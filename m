Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDEFD3480DE
	for <lists+bpf@lfdr.de>; Wed, 24 Mar 2021 19:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237606AbhCXSp4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Mar 2021 14:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237603AbhCXSpj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Mar 2021 14:45:39 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F14C061763
        for <bpf@vger.kernel.org>; Wed, 24 Mar 2021 11:45:38 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id y1so31511141ljm.10
        for <bpf@vger.kernel.org>; Wed, 24 Mar 2021 11:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=uo7bWqb6Mq96Y11z0ABxfzds/LHcU3KNRjRUUkDEn3o=;
        b=Gu52pz+ORTgtAGQBjvTYndLVFa3qsgdyn1gWUNMoVAf3srRzs/y2EgDtmc6ZV0hFPo
         UdU16kka/QtDqcT3ry8WlAe99AWy5ng6TCYFZCFQ+FjQl4FVRz4CMlC3RF5AJMLl6qJq
         Ea4slDNt8NxB/uuKMrCa93DWoeHXUjpMSvlN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=uo7bWqb6Mq96Y11z0ABxfzds/LHcU3KNRjRUUkDEn3o=;
        b=rAlsNgo1JoHHWZnvxTqrYli3b7t+i/PRp6SAAt5v78Q1TVnlo/LE2r92wcLtRR42qN
         MbuVwiJH5G4EDbwV3s+YicJ2tRudjOYCcYCVqdc67LGpmLg+2Zm6jsfixRBXM4dlEaCM
         thTrWk4JoTqJ5WCnJZGEj0uosWxxHLrxiVC1NBikiwGzneOow3nwjVWG/5wuUz/ttYB/
         NN/QLFqVXhWFDb4JpaLLF9duVRHyZJ3idLRdG/pd8ROSqkzrp9aUjj7Y8ErpPX28gZ+h
         1EYb5CXUfClw5Jttl6wvP7WEfrGeVl/n0/kkeDOWj3gIYIfup8sAOF6tNNJpjHybqLDn
         BeKg==
X-Gm-Message-State: AOAM5335XrOQnG6SrBJTKy2gR7AaGsAjOBiErzlWcW/b1AH+oBXol6Dw
        aBWEwRiNCsxwmTfmDWMLCnDLNs0paFZc1PtsNUO7tg==
X-Google-Smtp-Source: ABdhPJxbw+LKlrpdkZNt3gLK4Qdkm3NRfB3wimiy7sFh60oz2HC4kgmT3GAcUBa22/PBGyEzCUK6bApjDe8JgLrt/UY=
X-Received: by 2002:a2e:9899:: with SMTP id b25mr2958047ljj.376.1616611537127;
 Wed, 24 Mar 2021 11:45:37 -0700 (PDT)
MIME-Version: 1.0
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 24 Mar 2021 18:45:26 +0000
Message-ID: <CACAyw99e288cPoBuxTjt17YfMy8AHT72AmS1W83EexxvWKaP3w@mail.gmail.com>
Subject: Pinned link access mode troubles
To:     Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi list,

BPF_OBJ_GET allows specifying BPF_F_RDONLY or BPF_F_WRONLY for
file_flags. They are used to check that the current user has the
necessary permissions in bpf_obj_do_get:

    ret = path_permission(&path, ACC_MODE(flags));
    if (ret)
        goto out;

The map code additionally uses the flags in bpf_map_new_fd to attach
the permissions to the fd. Programs and links ignore flags (from
bpf_obj_get_user):

    if (type == BPF_TYPE_PROG)
        ret = bpf_prog_new_fd(raw);
    else if (type == BPF_TYPE_MAP)
        ret = bpf_map_new_fd(raw, f_flags);
    else if (type == BPF_TYPE_LINK)
        ret = bpf_link_new_fd(raw);
    else
        return -ENOENT;

For programs this probably isn't too exciting, since AFAIK they are
immutable from the user space. The same isn't true for links. Given a
link that is pinned to a bpffs for which my user only has read access,
I can call BPF_LINK_UPDATE and BPF_LINK_DETACH. To me this seems to
break the privilege model. This is a real issue in our code base since
we pin a link with 0664, which means that anybody on the system can
detach our link. I can work around this by using 0660 mode for links,
but I think there are several issues that need fixing:

1. BPF_OBJ_GET doesn't return an error when flags aren't useful, like
in the program case.
2. BPF_OBJ_GET returns an fd that allows destructive actions even if
BPF_F_RDONLY is passed.

Based on some git archaeology I think we are in luck: the code in
question was introduced in commit 70ed506c3bbc ("bpf: Introduce
pinnable bpf_link abstraction") and has changed very little from what
I can see, so backporting should be doable. Additionally, it seems
like libbpf doesn't provide a way to specify file_flags when loading
pinned objects. So the likelihood of breaking users is very low.

I'd like to propose the following changes:

1. Return an error from BPF_OBJ_GET If file_flags is not 0 for
programs and links. This we can backport.
2. (optional) Add code to respect BPF_F_RDONLY, etc. for links. This
requires adding a new interface to libbpf.

Opinions?

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
