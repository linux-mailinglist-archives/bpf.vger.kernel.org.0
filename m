Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADB3207C27
	for <lists+bpf@lfdr.de>; Wed, 24 Jun 2020 21:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391257AbgFXT1b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Jun 2020 15:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391250AbgFXT1a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Jun 2020 15:27:30 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33777C061573;
        Wed, 24 Jun 2020 12:27:29 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id e13so2992965qkg.5;
        Wed, 24 Jun 2020 12:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cVgR+y2rl1A0O/fcIfcloIxbYTjgzf+SX0xSidJWfM4=;
        b=bTNjmNtZMYFpbvCFyALTaIIDPoxFnxSQLQEu7xaZJqXTSwv+MG0RtESgNGGIgiApEU
         0Z+8jj1Vp+nrpKyICKhkiJXDbCJBqwVIHJsxN/rEelAGgBbLGIMlG6nexL0CEyfaaSYP
         algjcHmUyNbmpNkA4tWOnptKJqO2ehR+vPSpwovlwa0KwGiuikQwQOvc03oaUSvCTT7G
         MOYP3W8DHfTm5/eUVoG2GGgsJ9fAiGgpAckUTUow+gF8gx11sGpyj8OCxJzJe8yvKLAA
         s0GTw8VKCCAGwQHlh/gEo52If+hmGcDdqGBVifFijdzYmFrFZkIoeEqB+JNLvw7THseK
         hKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cVgR+y2rl1A0O/fcIfcloIxbYTjgzf+SX0xSidJWfM4=;
        b=SR9nXsdBREWNdBMvPjVq9UnKTkrxmZuvFOyziPyXHl0pNQcFS6GWQcQXR0g+biQPXa
         2XFDrJj8wzRAHxd/1ItC6U6D3XYWUxO7UWlvBWEeWNsOsaio2EoDFUheIYb642B+Blo6
         bybQTdmtBZvT+5T5do3/Vqj1xtKkNIImq5WHws4yTq3Q0i6dLvya4rx9kxGkpMrIvzy5
         JvUOPCxomNm8k2/+SMXY+Z9hgFKmQXvDflzzMJhVEBX71AVAH3t9PaAsLcNaXSGasLPE
         PH4/zW1lpwXKeiSEsTXoFsG3Hw+Kj5Ohj2ynAQHNtsFDmplKNpzrGziCBcrx43Krzj53
         OAtw==
X-Gm-Message-State: AOAM532n6dX2QM2W1BrXS89vk8o2wGx49ptURDK5VI6LkUeih9ZExF17
        3NJxxN41NBrNmvOtxI9Sd+B4lFqcT5IJ/IsGAzE=
X-Google-Smtp-Source: ABdhPJx+/poaDqENTiUEwjVUVn3Mpk70zyLPDpJAkQY/9iPuPw0pdc/p7KxYXqjJt72cTVCkKFR+MuZlBTgpijOKDMM=
X-Received: by 2002:a05:620a:12d2:: with SMTP id e18mr27821595qkl.437.1593026848420;
 Wed, 24 Jun 2020 12:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <2020062414452752504112@gmail.com>
In-Reply-To: <2020062414452752504112@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 24 Jun 2020 12:27:17 -0700
Message-ID: <CAEf4BzakcsdDcoeUN4uwigFti6iJrAu2Ge3EPfJm1cHyUq5W=Q@mail.gmail.com>
Subject: Re: tools/bpf: build failed with defconfig(x86_64) on v5.6 and v5.7
To:     Li Xinhai <lixinhai.lxh@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 23, 2020 at 11:46 PM Li Xinhai <lixinhai.lxh@gmail.com> wrote:
>
> - information of machine
> Linux localhost.localdomain 4.18.0-193.6.3.el8_2.x86_64 #1 SMP Wed Jun 10=
 11:09:32 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
>
> - configurations
> make defconfig
> make kvmconfig
>
> - failed logs on v5.6
> ```
>   LINK     /mnt/build/1_build/05_build_v5.6/bpf/bpftool//libbpf/libbpf.a
>   LINK     /mnt/build/1_build/05_build_v5.6/bpf/bpftool/bpftool
>   DESCEND  runqslower
>   GEN      /mnt/build/0_code/0_linux/linux/tools/bpf/runqslower/.output/b=
pf_helper_defs.h
> make[4]: *** No rule to make target '/mnt/build/0_code/0_linux/linux/tool=
s/include/linux/build_bug.h', needed by '/mnt/build/0_code/0_linux/linux/to=
ols/bpf/runqslower/.output/staticobjs/libbpf.o'.  Stop.
> make[3]: *** [Makefile:183: /mnt/build/0_code/0_linux/linux/tools/bpf/run=
qslower/.output/staticobjs/libbpf-in.o] Error 2
> make[2]: *** [Makefile:79: .output/libbpf.a] Error 2
> make[1]: *** [Makefile:119: runqslower] Error 2
> make: *** [Makefile:68: bpf] Error 2
> ```
>
> - failed logs on v5.7
> ```
> In file included from /mnt/build/0_code/0_linux/linux/tools/include/linux=
/build_bug.h:5,
>                  from /mnt/build/0_code/0_linux/linux/tools/include/linux=
/kernel.h:8,
>                  from /mnt/build/0_code/0_linux/linux/kernel/bpf/disasm.h=
:10,
>                  from /mnt/build/0_code/0_linux/linux/kernel/bpf/disasm.c=
:8:
> /mnt/build/0_code/0_linux/linux/kernel/bpf/disasm.c: In function =E2=80=
=98__func_get_name=E2=80=99:
> /mnt/build/0_code/0_linux/linux/tools/include/linux/compiler.h:37:38: war=
ning: nested extern declaration of =E2=80=98__compiletime_assert_0=E2=80=99=
 [-Wnested-externs]
>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>                                       ^~~~~~~~~~~~~~~~~~~~~
> /mnt/build/0_code/0_linux/linux/tools/include/linux/compiler.h:16:15: not=
e: in definition of macro =E2=80=98__compiletime_assert=E2=80=99
>    extern void prefix ## suffix(void) __compiletime_error(msg); \
>                ^~~~~~
> /mnt/build/0_code/0_linux/linux/tools/include/linux/compiler.h:37:2: note=
: in expansion of macro =E2=80=98_compiletime_assert=E2=80=99
>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>   ^~~~~~~~~~~~~~~~~~~
> /mnt/build/0_code/0_linux/linux/tools/include/linux/build_bug.h:39:37: no=
te: in expansion of macro =E2=80=98compiletime_assert=E2=80=99
>  #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                      ^~~~~~~~~~~~~~~~~~
> /mnt/build/0_code/0_linux/linux/tools/include/linux/build_bug.h:50:2: not=
e: in expansion of macro =E2=80=98BUILD_BUG_ON_MSG=E2=80=99
>   BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>   ^~~~~~~~~~~~~~~~
> /mnt/build/0_code/0_linux/linux/kernel/bpf/disasm.c:20:2: note: in expans=
ion of macro =E2=80=98BUILD_BUG_ON=E2=80=99
>   BUILD_BUG_ON(ARRAY_SIZE(func_id_str) !=3D __BPF_FUNC_MAX_ID);
>   ^~~~~~~~~~~~
> ```
>

This one I've seen and I have no idea why this is happening (suddenly)
and how to fix that.

> and
> ```
>   LINK     /mnt/build/0_code/0_linux/linux/tools/bpf/runqslower/.output/l=
ibbpf.a
>   GEN      vmlinux.h
>   BPF      runqslower.bpf.o
> In file included from runqslower.bpf.c:3:
> .output/vmlinux.h:5:15: error: attribute 'preserve_access_index' is not s=
upported by '#pragma clang attribute'
> #pragma clang attribute push (__attribute__((preserve_access_index)), app=
ly_to =3D record)
>               ^
> .output/vmlinux.h:98607:15: error: '#pragma clang attribute pop' with no =
matching '#pragma clang attribute push'
> #pragma clang attribute pop
>               ^
> 2 errors generated.
> make[2]: *** [Makefile:57: .output/runqslower.bpf.o] Error 1
> make[1]: *** [Makefile:119: runqslower] Error 2
> make: *** [Makefile:68: bpf] Error 2
> ```
>

This just means you don't have recent-enough Clang on your system. You
need Clang 10 at least.


> On this same machine and with same configuration, I've tried v5.4 and v5.=
5, no failures.
>
>
