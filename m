Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8B42519EF
	for <lists+bpf@lfdr.de>; Tue, 25 Aug 2020 15:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgHYNlO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Aug 2020 09:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbgHYNjH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Aug 2020 09:39:07 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F10C0617A5
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2020 06:39:07 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id h16so10362328oti.7
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2020 06:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=hzt5gSWMhbxVRh4PTXHJNP3u5f+ALDGjNCfyC0EUay0=;
        b=DgvcMHZXeG238As/oUgej2fYI4NHTQas98KjtjmWJjKPULmnvoSgM+BKVPo7sqCz55
         Ae7UmdoRIh55umzyJggt5eoDFB0GcblLNU4645xhpRYE6cuJV4J1r/vkIsbiAu/8rx69
         6v26hy/3QWGjFKmahUH9iHpA9akRvDTO6IOCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=hzt5gSWMhbxVRh4PTXHJNP3u5f+ALDGjNCfyC0EUay0=;
        b=enJNedebTPQD+ib1w7CNnFnmheDffQdNPU4jnZyp130v4PNu38GcEUAHUZPvLEwaxu
         DjvYKpJWFGX0beL22cgIx1jVQ7VpS2sl32AchvKZoT9oCUevdEdiWRQFjyGr7cL6G5at
         6VjBDGBAewlVgZakswnd7Sy9Er4Ezh3j3Q5qJC4ddLjcId26G66isbYl8cAx5w8AzbZ4
         nRnynZWMM8XhILKxhg0Pq/M9pTtzGYGqAJnwSraJr75wAtGDO2eoS9MTUZkKHGQSsvmx
         jOy0qDCeYQIoeNpc3QKx6mvD3ZHwyHrsyqt003AWXM8imyrEQXUWSFq2J2IPz/8Yi9lq
         dfhg==
X-Gm-Message-State: AOAM531332gIcrYN/Flrd1DkDnOQlpe7PJrrAfPL6gH5GmYrGoBjC3kk
        n+nUDBSNM8zPCpmHndjAldT4FhVVhGvK4vhO4OkxLooyAg/t5A==
X-Google-Smtp-Source: ABdhPJxcJTqL6U2dsLLrcc6eRglK/9YzR6cm5qy5sbHKemcE8RCGfvSnUI93O0H5IWZ68LRpoGXRjDRc8O/p0rd4fGg=
X-Received: by 2002:a9d:2f23:: with SMTP id h32mr7147730otb.334.1598362744999;
 Tue, 25 Aug 2020 06:39:04 -0700 (PDT)
MIME-Version: 1.0
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 25 Aug 2020 14:38:52 +0100
Message-ID: <CACAyw98fJe3qanRVe5LcoP49METHhzjZKPcSGnKQ-o=_F3=Hfw@mail.gmail.com>
Subject: Advisory file locking behaviour of bpf_link (and others?)
To:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I was playing around a bit, and noticed that trying to acquire an
exclusive POSIX record lock on a bpf_link fd fails. I've traced this
to the call to anon_inode_getfile from bpf_link_prime which
effectively specifies O_RDONLY on the bpf_link struct file. This makes
check_fmode_for_setlk return EBADF.

This means the following:
* flock(link, LOCK_EX): works
* fcntl(link, SETLK, F_RDLCK): works
* fcntl(link, SETLK, F_WRLCK): doesn't work

Especially the discrepancy between flock(EX) and fcntl(WRLCK) has me
puzzled. Should fcntl(WRLCK) work on a link?

program fds are always O_RDWR as far as I can tell (so all locks
work), while maps depend on map_flags.

Best
Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
