Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C434486D7C
	for <lists+bpf@lfdr.de>; Fri,  7 Jan 2022 00:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245331AbiAFXDA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 18:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245283AbiAFXDA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jan 2022 18:03:00 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3D2C061245
        for <bpf@vger.kernel.org>; Thu,  6 Jan 2022 15:02:59 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e2-20020a25d302000000b0060c57942183so7944755ybf.18
        for <bpf@vger.kernel.org>; Thu, 06 Jan 2022 15:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tIfuZpi5e6n5gI4gnm4wG7X8XVH/2tw3YB4IBjuMO4Q=;
        b=SzTlx8RtqgH/ifIKj/xE6+sVyerk9wESgNqR5qeFfGPlNFUBfos/jgFcAzJ9V6Mp4I
         Ju3rnFIghfdHijBMkk0xKkdUDU9Ah6mtElJf4lGhIR/W2MWzQoXbYYlP1ALbhEeUo6St
         IVhbHpy6CD4qUJBEz2+4JvbZ0LX8vsTbZBcq+SHyXkTzH0Arwv+23PfUIX0GESFUoOm3
         PHsN1hMJbCwMyVnaMqUiKlbUCgbEnOY+AKHaHr/FqF5rQHTDy9vKTFxjTro6T7lqgtLX
         p6YE0jXdkUKhYfma6BZG2eqFSYubLNRxuJO2JHtXG2PXobnTqgKxAobtaG/euGmgMXzl
         LOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tIfuZpi5e6n5gI4gnm4wG7X8XVH/2tw3YB4IBjuMO4Q=;
        b=X0e6O5du3OpaQLFmK2/Y/pCyNIKbQYgUsKHtz0628aifQg4O82Hg/i9Q/linv2skJm
         rd7GYbDKlkrXyn9a+9dq16TZzyB0xCIAelBXxqv0i6j4yuCHrq3pQFHPIpUtfzuuVSPD
         QiBaNJN2eirHz9MbdWazsABUq5wKhxd77aT/aokmUvJ0vc7ZlHnyu6gNug0EkkS8PfL5
         w+MYr9HB+r4YHJHeL3nMoa8fLbcrmZ3CIxEVpW6PyhcEK376i3Q4EG8LD5yCVxXxjjhX
         TaXimtEubFQYl7/5OWNkhrlnnGkFtBbuas9t6HHywRh/v95LlOZ9xbLJwkM1lNDj6zEL
         2XUw==
X-Gm-Message-State: AOAM531PajcxFeIWJQgmdHG+38e5yLtNitRRvPd81w6WDcAmwewsIrRH
        bcVEFo1rdL2SAeJRUYIZzKAmwR4=
X-Google-Smtp-Source: ABdhPJxNo5rBEdAmC1O3Euie+npGYzx9rpSggEmox6uNNrEMXVRJHKcou+l2RiFnU/2DRX2P9zjkw4M=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:f81a:dd1d:62f3:fee6])
 (user=sdf job=sendgmr) by 2002:a25:6b45:: with SMTP id o5mr48739373ybm.324.1641510179162;
 Thu, 06 Jan 2022 15:02:59 -0800 (PST)
Date:   Thu, 6 Jan 2022 15:02:56 -0800
In-Reply-To: <20220106215059.2308931-1-haoluo@google.com>
Message-Id: <Ydd1IIUG7/3kQRcR@google.com>
Mime-Version: 1.0
References: <20220106215059.2308931-1-haoluo@google.com>
Subject: Re: [PATCH RFC bpf-next v1 0/8] Pinning bpf objects outside bpffs
From:   sdf@google.com
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 01/06, Hao Luo wrote:
> Bpffs is a pseudo file system that persists bpf objects. Previously
> bpf objects can only be pinned in bpffs, this patchset extends pinning
> to allow bpf objects to be pinned (or exposed) to other file systems.

> In particular, this patchset allows pinning bpf objects in kernfs. This
> creates a new file entry in the kernfs file system and the created file
> is able to reference the bpf object. By doing so, bpf can be used to
> customize the file's operations, such as seq_show.

> As a concrete usecase of this feature, this patchset introduces a
> simple new program type called 'bpf_view', which can be used to format
> a seq file by a kernel object's state. By pinning a bpf_view program
> into a cgroup directory, userspace is able to read the cgroup's state
> from file in a format defined by the bpf program.

> Different from bpffs, kernfs doesn't have a callback when a kernfs node
> is freed, which is problem if we allow the kernfs node to hold an extra
> reference of the bpf object, because there is no chance to dec the
> object's refcnt. Therefore the kernfs node created by pinning doesn't
> hold reference of the bpf object. The lifetime of the kernfs node
> depends on the lifetime of the bpf object. Rather than "pinning in
> kernfs", it is "exposing to kernfs". We require the bpf object to be
> pinned in bpffs first before it can be pinned in kernfs. When the
> object is unpinned from bpffs, their kernfs nodes will be removed
> automatically. This somehow treats a pinned bpf object as a persistent
> "device".

> We rely on fsnotify to monitor the inode events in bpffs. A new function
> bpf_watch_inode() is introduced. It allows registering a callback
> function at inode destruction. For the kernfs case, a callback that
> removes kernfs node is registered at the destruction of bpffs inodes.
> For other file systems such as sockfs, bpf_watch_inode() can monitor the
> destruction of sockfs inodes and the created file entry can hold the bpf
> object's reference. In this case, it is truly "pinning".

> File operations other than seq_show can also be implemented using bpf.
> For example, bpf may be of help for .poll and .mmap in kernfs.

This looks awesome!

One thing I don't understand is: why did go through the pinning
interface VS regular attach/detach? IOW, why not allow regular
sys_bpf(BPF_PROG_ATTACH, prog_id, cgroup_id) and attach to the cgroup
(which, in turn, creates the kernfs nodes). Seems like this way you can drop
the requirement on the object being pinned in the bpffs first?
