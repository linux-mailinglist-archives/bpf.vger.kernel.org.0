Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4187230118A
	for <lists+bpf@lfdr.de>; Sat, 23 Jan 2021 01:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbhAWARe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jan 2021 19:17:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:48388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbhAVXvP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jan 2021 18:51:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BAE323B52
        for <bpf@vger.kernel.org>; Fri, 22 Jan 2021 23:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611359434;
        bh=8/IhIqBBdElc0DnyifuFkLZwG8G+lgMV6K3iSE0gW/M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r9oitys+pau43ikSMZFmGSf+hnCskZGl8dm+iPtD9zJB6PWJEr/tM5Ei+JFOsiMA3
         d4Zm++eIUN6lS8/JMz8JBp4iWNO9Q+ZVWMDyoc5w0zvqq3FJqc+F75AYpXF9aiJ/XT
         urQAXCEhndOh8YzB2k3PDxl6eHT86oG8Q+W6MQqLSOtvbuUaziejT/ikBo5AJBixGR
         ijL0Ldqbjieib/hAsO53/k5Nw4BMPQ70xhxc2hepU44ruCPx2He7Tf1Vo/Tqcj1Xme
         fSj9iJMaKQYgeDWoi0m4YwuMnmU8zOxAZOynEUblmYPYiu1DvlJie9sbt1XFG7p7ZA
         oQgrcodD003rg==
Received: by mail-lf1-f52.google.com with SMTP id f1so84208lfu.3
        for <bpf@vger.kernel.org>; Fri, 22 Jan 2021 15:50:34 -0800 (PST)
X-Gm-Message-State: AOAM5333bsRomurir8rbVzBKOvz7EzzAj0ZyIwifmAIhBWkFwtYzts+l
        LAwL5xWLIM7IZdg6RHRUMUeyQg7OYZX9SwdIb5elaQ==
X-Google-Smtp-Source: ABdhPJw0ARgET/QGQOkap3HBMXJgZVPOV3Jc59vN+bW1p5mla7p1MeiFViG0Z/5GfE9WZG3OSP6UDoHlVOpu/lIPnDs=
X-Received: by 2002:a19:c7c2:: with SMTP id x185mr76315lff.162.1611359432739;
 Fri, 22 Jan 2021 15:50:32 -0800 (PST)
MIME-Version: 1.0
References: <20210122123003.46125-1-mikko.ylinen@linux.intel.com> <CACYkzJ6sMBvZ_ZG9++jwpQ+JQL3PL02okhD0O5Ftz4Hd7jEC3Q@mail.gmail.com>
In-Reply-To: <CACYkzJ6sMBvZ_ZG9++jwpQ+JQL3PL02okhD0O5Ftz4Hd7jEC3Q@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Sat, 23 Jan 2021 00:50:21 +0100
X-Gmail-Original-Message-ID: <CACYkzJ5i6DNxY3D3SqiO_LO2HBbA-EgPFdK8ZBcFNmTVWweucg@mail.gmail.com>
Message-ID: <CACYkzJ5i6DNxY3D3SqiO_LO2HBbA-EgPFdK8ZBcFNmTVWweucg@mail.gmail.com>
Subject: Re: [PATCH] bpf: Drop disabled LSM hooks from the sleepable set
To:     Mikko Ylinen <mikko.ylinen@linux.intel.com>
Cc:     bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        KP Singh <kpsingh@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 22, 2021 at 11:33 PM KP Singh <kpsingh@kernel.org> wrote:
>
> On Fri, Jan 22, 2021 at 1:32 PM Mikko Ylinen
> <mikko.ylinen@linux.intel.com> wrote:
> >
> > Networking LSM hooks are conditionally enabled and when building the new
> > sleepable BPF LSM hooks with the networking LSM hooks disabled, the
> > following build error occurs:
> >
> > BTFIDS  vmlinux
> > FAILED unresolved symbol bpf_lsm_socket_socketpair
> >
> > To fix the error, conditionally add the networking LSM hooks to the
> > sleepable set.
> >
> > Fixes: 423f16108c9d8 ("bpf: Augment the set of sleepable LSM hooks")
> > Signed-off-by: Mikko Ylinen <mikko.ylinen@linux.intel.com>
>
> Thanks!
>
> Acked-by: KP Singh <kpsingh@kernel.org>

Btw, I was noticing that there's another hook that is surrounded by ifdefs:

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 70e5e0b6d69d..f7f7754e938d 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -166,7 +166,11 @@ BTF_ID(func, bpf_lsm_inode_symlink)
 BTF_ID(func, bpf_lsm_inode_unlink)
 BTF_ID(func, bpf_lsm_kernel_module_request)
 BTF_ID(func, bpf_lsm_kernfs_init_security)
+
+#ifdef CONFIG_KEYS
 BTF_ID(func, bpf_lsm_key_free)
+#endif
+
 BTF_ID(func, bpf_lsm_mmap_file)
 BTF_ID(func, bpf_lsm_netlink_send)
 BTF_ID(func, bpf_lsm_path_notify)

It would be great if you can also add this to your patch :)

I guess the cleanest solution to never let this happen would be to
incorporate this in
lsm_hook_defs.h and mark hooks as SLEEPABLE and NON_SLEEPABLE with an
extra parameter to the LSM_HOOK macro and then only generate the BTF IDs
based on this macro parameter.
