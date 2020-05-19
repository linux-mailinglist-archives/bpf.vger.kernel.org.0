Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43AC61DA099
	for <lists+bpf@lfdr.de>; Tue, 19 May 2020 21:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgESTJt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 May 2020 15:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgESTJt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 May 2020 15:09:49 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0011C08C5C0
        for <bpf@vger.kernel.org>; Tue, 19 May 2020 12:09:48 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id p4so142344qvr.10
        for <bpf@vger.kernel.org>; Tue, 19 May 2020 12:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=raM1VqmCm3GYW75MVkTY0Qg9nZ5emw7l95/51B74Nwg=;
        b=nDh67nJtvJJEatPhfbbGyA31uywFr31AavlbGj6AGKyvh0B/rYX0iFXuMIjtvh1iJf
         80UWIfm1Wy4OH0yri9MPZJrJTthu+HIBa26WHsxTjdM8hKhBaVCkPVbmFKhPKgr/BV8j
         pvPZ+JfgLRd74Da/hMhQwUfGdeklPHJoM1doMCxfifuSWI1C/Tt4hHoXKBwB1E034xE6
         uJSxWHkA4d2jxsQVvqgjtfF49mmDNvf8Klvs/pcOnYkmsMWt0VebxkuAEaMpkIAvXVxY
         QXML06EG/4kvktn5iwNnmFULGVavJL6kLHY+CjMAKilqYyMoZd4IlUWddy39pAacJmGw
         OLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=raM1VqmCm3GYW75MVkTY0Qg9nZ5emw7l95/51B74Nwg=;
        b=a5aQzeUuoCvjuvsXeE4mvTwrSOyBSFWi+SIdPd2Ysz60uYcgRzkTsYCugMfiDpedws
         D1o/zPPmZmBkPSLGgeWa2L2lCp+Zb53gGz3dItpINfFEo1X8tc08d5iIAPGv9n7UWHxH
         kz2IU2FTzArVCJRX+K3Z9RKRt0Neold2ytU2RI7JA1nmWefj868yIAsHyLal9u2NeaTY
         KsdA7VT9njP2lT/05FA4xOtFsKPQhGQLAr4weAQV+PeN/vJfbVwNlM6db6BqPu0xcMzj
         2FTJqwilCYIiiue5VMQdUqxeViY2zFVVdY+zPdVhYD1CoC4sBfIPKC2EOIzJtrnMtd5Z
         npmQ==
X-Gm-Message-State: AOAM5329OBSBI+vRxrXr3OwikhskC/+Z2X+rIBmA838GEJrUeO3OFSQe
        zav6b3qEPc19cVjL/CgZ8r8nDmGwwk/ssllBK3k=
X-Google-Smtp-Source: ABdhPJyo/YI3oasNI/4MsWKOo3dkiwE0f86EaSlXKixqhNTDi9hMRXGiRubGgxhJcEmuUrNON4A/UA3EmIlE3fRVdv8=
X-Received: by 2002:a0c:a892:: with SMTP id x18mr1107972qva.247.1589915388028;
 Tue, 19 May 2020 12:09:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200519084957.55166-1-yauheni.kaliuta@redhat.com>
In-Reply-To: <20200519084957.55166-1-yauheni.kaliuta@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 19 May 2020 12:09:36 -0700
Message-ID: <CAEf4Bzb-FjHtH9dyVtjZf7FYBB2BiPs0mK8ZoqH3B9iU5Hz7Mg@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: install btf .c files
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Jiri Benc <jbenc@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 19, 2020 at 1:50 AM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> Some .c files used by test_progs to check btf and they are missing
> from installation after commit 74b5a5968fe8 ("selftests/bpf: Replace
> test_progs and test_maps w/ general rule").
>
> Take them back.
>
> Fixes: 74b5a5968fe8 ("selftests/bpf: Replace test_progs and
> test_maps w/ general rule")
>
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index e716e931d0c9..d96440732905 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -46,6 +46,9 @@ TEST_GEN_FILES =
>  TEST_FILES = test_lwt_ip_encap.o \
>         test_tc_edt.o
>
> +BTF_C_FILES = $(wildcard progs/btf_dump_test_case_*.c)
> +TEST_FILES += $(BTF_C_FILES)

Can you please re-use BTF_C_FILES in TRUNNER_EXTRA_FILES := assignment
on line 357?

See also $(TRUNNER_BINARY)-extras rule. For "flavored" test_progs
runners (e.g., test_progs-no_alu32), those files need to be copied
into no_alu32 sub-directory (same for BPF .o files, actually). Unless
you don't want to run flavored test_progs, of course.

>  # Order correspond to 'make run_tests' order
>  TEST_PROGS := test_kmod.sh \
>         test_xdp_redirect.sh \
> --
> 2.26.2
>
