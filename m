Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEE42F1292
	for <lists+bpf@lfdr.de>; Mon, 11 Jan 2021 13:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbhAKMtm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jan 2021 07:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbhAKMtm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jan 2021 07:49:42 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F7FC061786;
        Mon, 11 Jan 2021 04:49:02 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id x15so18258484ilq.1;
        Mon, 11 Jan 2021 04:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=Qi5Ue2Fa5K8j/6FFk7i0qA38bcCZMdE6+qZIvP07LIc=;
        b=p2R0DsNr2I++u6Yf976kLrtM2r39n9rWQ/96pIN4u4njgGH4f3RT7WCB4+rXQ1d/j1
         5nUmlP5wFuohYWrog+l7FAJgYjw0GVG9RYxdbUk0GYUyBn0qFuof+vk9hYvz/YhzK5wS
         ZaJRsEvaqVjDa1oR6u8GBrSj9335dEH0ROHNBN5uWOrRaZE5Moo4igHGZk3VyHy7iiiN
         Xm8WdP0MOblddtTMYYEYA/rbNAfGmtOvOfNgSMvtL1vh5FwxanpBjMEb4AeduBD0T3Oq
         BrbNXn+yYHsQ2Hb8BMg/68CELcMRXctCtekTMQNULewE4N7JKdnL6+YR2vF09/RGtXyB
         DEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Qi5Ue2Fa5K8j/6FFk7i0qA38bcCZMdE6+qZIvP07LIc=;
        b=pLcDeAxVvJ2sV5xBiWEDbGlX9IpW1NcQII1FlsZWmCVX8mD0+8u4k66PLYVxnYByRp
         REVeevbVB3b/tSXz0qchTet3kcansiiVxelJDNX5PknE2PKOQDrSbwPtg0tPEvu3PLJz
         vCz9ZGo/v1D0eafkMIclssCXTuYEYGQdGDFYc83nlQa4aI26S83VUbUAMjGRo61M3ezc
         NYZWxR7ZBXc+jBVM1IdF9lsut80GUVkpSRpyJm0B5ihLJChHY4gxfkKDL9RMKQcB1q0K
         EzvfUB2l5EJ8TTP4Vy5JK45stXdc/ehzJR0wiLI0fhjalUuI6ZtYH8NEf0egAe6qzZCD
         4dzg==
X-Gm-Message-State: AOAM533i4md5QlPfjTiWpg+iQyPrMw62dLgx1YPW2Q5lHYrKHrzYxjfl
        /q/vgrJakE+go19cSog0U34kWDjVlq9KqghZt88=
X-Google-Smtp-Source: ABdhPJxhxmfVZlitBa9vZVlyXJz3wWgY/HN3CeMF3ZZKfWmc0nq7QlwEJT0fFfHaJwefuSuGRrQxhn9OOQAzt/00Rgk=
X-Received: by 2002:a92:9e57:: with SMTP id q84mr5529394ili.112.1610369341611;
 Mon, 11 Jan 2021 04:49:01 -0800 (PST)
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 11 Jan 2021 13:48:50 +0100
Message-ID: <CA+icZUVuk5PVY4_HoCoY2ymd27UjuDi6kcAmFb_3=dqkvOA_Qw@mail.gmail.com>
Subject: Check pahole availibity and BPF support of toolchain before starting
 a Linux kernel build
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     bpf@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi BPF maintainers and Mashiro,

Debian started to use CONFIG_DEBUG_INFO_BTF=y.

My kernel-build fails like this:

+ info BTFIDS vmlinux
+ [  != silent_ ]
+ printf   %-7s %s\n BTFIDS vmlinux
 BTFIDS  vmlinux
+ ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
FAILED: load BTF from vmlinux: Invalid argument

The root cause is my selfmade LLVM toolchain has no BPF support.

$ which llc
/home/dileks/src/llvm-toolchain/install/bin/llc

$ llc --version
LLVM (http://llvm.org/):
 LLVM version 11.0.1
 Optimized build.
 Default target: x86_64-unknown-linux-gnu
 Host CPU: sandybridge

 Registered Targets:
   x86    - 32-bit X86: Pentium-Pro and above
   x86-64 - 64-bit X86: EM64T and AMD64

Debian's llc-11 shows me BPF support is built-in.

I see the breakag approx. 3 hours after the start of my kernel-build -
in the stage "vmlinux".
After 2 faulures in my build (2x 3 hours of build-time) I have still
no finished Linux v5.11-rc3 kernel.
This is a bit frustrating.

What about doing pre-checks - means before doing a single line of
compilation - to check for:
1. Required binaries
2. Required support of whatever feature in compiler, linker, toolchain etc.

Recently, I fell over depmod binary not found in my PATH - in one of
the last steps (modfinal) of the kernel build.

Any ideas to improve the situation?
( ...and please no RTFM, see links below. )

Thanks.

Regards,
- Sedat -


[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/link-vmlinux.sh#n144
[1] https://salsa.debian.org/kernel-team/linux/-/commit/929891281c61ce4403ddd869664c949692644a2f
[2] https://www.kernel.org/doc/html/latest/bpf/bpf_devel_QA.html?highlight=pahole#llvm
[3] https://www.kernel.org/doc/html/latest/bpf/btf.html?highlight=pahole#btf-generation
