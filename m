Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4196AFDAF
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 04:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjCHD6S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 22:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjCHD6Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 22:58:16 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879ED43910
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 19:58:14 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id i34so60707878eda.7
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 19:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678247893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Tlzmmymv6b69PVxJ1Sm9cagL1grmfqzVtN4rp8n3VM=;
        b=izjOKz6RIwfLULeu44jvcjz9qq4SI4PK6MIEK6Bk519R/i5XOU6hhrNe5Q0OP47C9f
         G5g2duLJN9MGSneletJYEWIXGXTj50M4gQKYQHIuGybJWqLhBe/Ffrj0qdQS0XUjSu1+
         xiUnHCIKPU+KelrmLX/X+nBGgAxPK5IepwiLb0d86/NYvo/t2Wt6lhKPOdJQ4QpK+ncS
         2/gJm6oGr/42W3Hd3OWBFjPzq2nW8bJR3gzbSYRA0vHW5JsK+et2ZPOaH/hROujP0AEu
         SLt8s74/ehF2BPlpyP5cuzybEGiTctvCUH39mgNQeM+0QZwG4L7UsszWKWjdVMUkuSIY
         IIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678247893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Tlzmmymv6b69PVxJ1Sm9cagL1grmfqzVtN4rp8n3VM=;
        b=7XnuPfGk5tQVPRNO1ZblR4ETcebXCbmInnDxaJ7qte4H8Xs0yUavK+ZFFBj++uaquA
         uuLN75EMoM7ZI4lkDqtpUCBHc4o3UN02tTbiiqVl6r7/dB+aaiIoYm4o5bDlc7ElqPyE
         17luod37gJwc/UmAQDTCC9iMiiHH7eTJ3WmU3sI+7egaTF0XKJXxyZpY2P+oe26jvEwq
         MvilsjsprNWdctdChH8Y0109vj+y2xoRaslI4Z7TzMoZJLn+pNtVQGRW37y3n++Scila
         LEtIhZwcRDHiKZ+SLlp+Wlm0qhV/tpM+p8cFPjtPrFUDZDX2wJrNKXuXdYgCi/gYd5tT
         wcRA==
X-Gm-Message-State: AO0yUKWwzOedm5nDZ/KO6DPDnOggX86fywj86wseg0l8E4Rwl1/4ZrZj
        x1ECIqexYJlYSIovx++s7afDuaIKj42z2W3JXQn/Y/wfX7k=
X-Google-Smtp-Source: AK7set8OhPx0vZTyAfagJr5/C0CDaWNO9Vr7WWCf7yEMUg4+/IKA+SpJncsH32r6y9uAllcejjamHsMACFxA7j7xEkI=
X-Received: by 2002:a17:906:4bcb:b0:8b1:28f6:8ab3 with SMTP id
 x11-20020a1709064bcb00b008b128f68ab3mr8447062ejv.15.1678247892869; Tue, 07
 Mar 2023 19:58:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1677583941.git.vmalik@redhat.com>
In-Reply-To: <cover.1677583941.git.vmalik@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 7 Mar 2023 19:58:01 -0800
Message-ID: <CAEf4BzY9h+ywcxo5=6WZbJzN=9_9UJ_fwKVEBDHWn=4PDPf33Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 0/2] Fix attaching fentry/fexit/fmod_ret/lsm
 to modules
To:     Viktor Malik <vmalik@redhat.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 28, 2023 at 4:27=E2=80=AFAM Viktor Malik <vmalik@redhat.com> wr=
ote:
>
> I noticed that the verifier behaves incorrectly when attaching to fentry
> of multiple functions of the same name located in different modules (or
> in vmlinux). The reason for this is that if the target program is not
> specified, the verifier will search kallsyms for the trampoline address
> to attach to. The entire kallsyms is always searched, not respecting the
> module in which the function to attach to is located.
>
> As Yonghong correctly pointed out, there is yet another issue - the
> trampoline acquires the module reference in register_fentry which means
> that if the module is unloaded between the place where the address is
> found in the verifier and register_fentry, it is possible that another
> module is loaded to the same address in the meantime, which may lead to
> errors.
>
> This patch fixes the above issues by extracting the module name from the
> BTF of the attachment target (which must be specified) and by doing the
> search in kallsyms of the correct module. At the same time, the module
> reference is acquired right after the address is found and only released
> right before the program itself is unloaded.
>

is it expected that your newly added test fails on arm64? See [0]

  [0] https://github.com/kernel-patches/bpf/actions/runs/4359596129/jobs/76=
21687719

> ---
> Changes in v9:
> - two small changes suggested by Jiri Olsa and Jiri's ack
>
> Changes in v8:
> - added module_put to error paths in bpf_check_attach_target after the
>   module reference is acquired
>
> Changes in v7:
> - refactored the module reference manipulation (comments by Jiri Olsa)
> - cleaned up the test (comments by Andrii Nakryiko)
>
> Changes in v6:
> - storing the module reference inside bpf_prog_aux instead of
>   bpf_trampoline and releasing it when the program is unloaded
>   (suggested by Jiri Olsa)
>
> Changes in v5:
> - fixed acquiring and releasing of module references by trampolines to
>   prevent modules being unloaded between address lookup and trampoline
>   allocation
>
> Changes in v4:
> - reworked module kallsyms lookup approach using existing functions,
>   verifier now calls btf_try_get_module to retrieve the module and
>   find_kallsyms_symbol_value to get the symbol address (suggested by
>   Alexei)
> - included Jiri Olsa's comments
> - improved description of the new test and added it as a comment into
>   the test source
>
> Changes in v3:
> - added trivial implementation for kallsyms_lookup_name_in_module() for
>   !CONFIG_MODULES (noticed by test robot, fix suggested by Hao Luo)
>
> Changes in v2:
> - introduced and used more space-efficient kallsyms lookup function,
>   suggested by Jiri Olsa
> - included Hao Luo's comments
>
>
> Viktor Malik (2):
>   bpf: Fix attaching fentry/fexit/fmod_ret/lsm to modules
>   bpf/selftests: Test fentry attachment to shadowed functions
>
>  include/linux/bpf.h                           |   2 +
>  kernel/bpf/syscall.c                          |   6 +
>  kernel/bpf/trampoline.c                       |  28 ----
>  kernel/bpf/verifier.c                         |  18 ++-
>  kernel/module/internal.h                      |   5 +
>  net/bpf/test_run.c                            |   5 +
>  .../selftests/bpf/bpf_testmod/bpf_testmod.c   |   6 +
>  .../bpf/prog_tests/module_attach_shadow.c     | 128 ++++++++++++++++++
>  8 files changed, 169 insertions(+), 29 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/module_attach_=
shadow.c
>
> --
> 2.39.1
>
