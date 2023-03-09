Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049056B2BFE
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 18:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjCIRZu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 12:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjCIRZs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 12:25:48 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2DCF31E7
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 09:25:45 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id cy23so9895472edb.12
        for <bpf@vger.kernel.org>; Thu, 09 Mar 2023 09:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678382743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=srhDemZ+FglCyrTyITXmP6Dnz3XcJYTz0HC17JG/+9s=;
        b=kUP30HeFaKQC592Gq8LzMvKYFn0TCfJnVo7aW+Ivwp+0HTgfyQb5UBpPYan8W1U9tc
         J9UOQckeazAeZwdR6zgTJSh8x3QranwhvZCX21tEpyKkbQU5YqYiSvdIbCeFiHZzxDbU
         BTFsRbqzyq7qnUPMMPKFr5FEhqFEgo9piVvQ/TF38NOBdi7u2VHFKcwfAKC6D7Gv3I0g
         2bZaXiakSRettA6ZIj0UyuKMPBMNfOn54CcS8mbwAOpuzbYR9Iiq8qElvavysH14HogO
         3I/DXbHvS/MuiTP0eieKinInKj7xvMFQp0jn2MRdsrFkR08EDTaKL1KDd7N31WL3JC84
         OBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678382743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=srhDemZ+FglCyrTyITXmP6Dnz3XcJYTz0HC17JG/+9s=;
        b=iOQmKZNt8nfBVa8q30ukw37uLzaelYWPcuyVDkYBASVZJvvgsny2DHVtxCZNe3Uijr
         rbpvh7zDXsJNZAvvbk2yStXQjp7+s3yyvVLLg7zI+euch2qDs1b3KQbCpw1xGqkPEhG7
         ubrPOaZqGlf4SG4UW2KlfY7aSRXn89aoYmfSb5WxqzkCpaXtr1IhjvcazLhyzRvy8W14
         KfbeslcXYZPMK+Q2OuUwnoodCBbJxzW0VGD7g8N7z8KoqFMVxyg2qD69ZG+NQ/IIuUZ1
         2fgbIpFIHlMo8zYlOGveOcCVTbFgswlU4F8DnDEIsiuFGLMakAeDDn/Y6msikIVNbDWF
         gq/g==
X-Gm-Message-State: AO0yUKUYWc+HMRaFalRLuqwGQF7cM9DDmgGQVPJMqKvMeu1KYFHjKaQU
        Iulxt1e6MLXGUzxM4BqKTMXsQdWRTFJQZhm4uWQ=
X-Google-Smtp-Source: AK7set8BnlvnaZiRYgVyCg4Wxifrf6HxRXmS05O5fQHfQpt3TQ6I7HvbGrfoGWlei2MAMZmIp7mVoef1STZp+Te9eis=
X-Received: by 2002:a17:906:6d98:b0:8ab:b606:9728 with SMTP id
 h24-20020a1709066d9800b008abb6069728mr11592629ejt.5.1678382743450; Thu, 09
 Mar 2023 09:25:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1677583941.git.vmalik@redhat.com> <CAEf4BzY9h+ywcxo5=6WZbJzN=9_9UJ_fwKVEBDHWn=4PDPf33Q@mail.gmail.com>
 <21821216-f882-d036-776b-4a0c6473d2d4@redhat.com>
In-Reply-To: <21821216-f882-d036-776b-4a0c6473d2d4@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 9 Mar 2023 09:25:31 -0800
Message-ID: <CAEf4BzYTu4zfZrmexo6fnYGtNgvFYXtbZk_NEQnZXCPuvjBmjA@mail.gmail.com>
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

On Thu, Mar 9, 2023 at 1:52=E2=80=AFAM Viktor Malik <vmalik@redhat.com> wro=
te:
>
> On 3/8/23 04:58, Andrii Nakryiko wrote:
> > On Tue, Feb 28, 2023 at 4:27=E2=80=AFAM Viktor Malik <vmalik@redhat.com=
> wrote:
> >>
> >> I noticed that the verifier behaves incorrectly when attaching to fent=
ry
> >> of multiple functions of the same name located in different modules (o=
r
> >> in vmlinux). The reason for this is that if the target program is not
> >> specified, the verifier will search kallsyms for the trampoline addres=
s
> >> to attach to. The entire kallsyms is always searched, not respecting t=
he
> >> module in which the function to attach to is located.
> >>
> >> As Yonghong correctly pointed out, there is yet another issue - the
> >> trampoline acquires the module reference in register_fentry which mean=
s
> >> that if the module is unloaded between the place where the address is
> >> found in the verifier and register_fentry, it is possible that another
> >> module is loaded to the same address in the meantime, which may lead t=
o
> >> errors.
> >>
> >> This patch fixes the above issues by extracting the module name from t=
he
> >> BTF of the attachment target (which must be specified) and by doing th=
e
> >> search in kallsyms of the correct module. At the same time, the module
> >> reference is acquired right after the address is found and only releas=
ed
> >> right before the program itself is unloaded.
> >>
> >
> > is it expected that your newly added test fails on arm64? See [0]
> >
> >    [0] https://github.com/kernel-patches/bpf/actions/runs/4359596129/jo=
bs/7621687719
>
> I believe so, the test uses fentry and all fentry/fexit tests are
> failing on arm64 with the same error (524) and are disabled in the CI.


Then you have to add newly added tests into DENYLIST.aarch64

>
> >
> >> ---
> >> Changes in v9:
> >> - two small changes suggested by Jiri Olsa and Jiri's ack
> >>
> >> Changes in v8:
> >> - added module_put to error paths in bpf_check_attach_target after the
> >>    module reference is acquired
> >>
> >> Changes in v7:
> >> - refactored the module reference manipulation (comments by Jiri Olsa)
> >> - cleaned up the test (comments by Andrii Nakryiko)
> >>
> >> Changes in v6:
> >> - storing the module reference inside bpf_prog_aux instead of
> >>    bpf_trampoline and releasing it when the program is unloaded
> >>    (suggested by Jiri Olsa)
> >>
> >> Changes in v5:
> >> - fixed acquiring and releasing of module references by trampolines to
> >>    prevent modules being unloaded between address lookup and trampolin=
e
> >>    allocation
> >>
> >> Changes in v4:
> >> - reworked module kallsyms lookup approach using existing functions,
> >>    verifier now calls btf_try_get_module to retrieve the module and
> >>    find_kallsyms_symbol_value to get the symbol address (suggested by
> >>    Alexei)
> >> - included Jiri Olsa's comments
> >> - improved description of the new test and added it as a comment into
> >>    the test source
> >>
> >> Changes in v3:
> >> - added trivial implementation for kallsyms_lookup_name_in_module() fo=
r
> >>    !CONFIG_MODULES (noticed by test robot, fix suggested by Hao Luo)
> >>
> >> Changes in v2:
> >> - introduced and used more space-efficient kallsyms lookup function,
> >>    suggested by Jiri Olsa
> >> - included Hao Luo's comments
> >>
> >>
> >> Viktor Malik (2):
> >>    bpf: Fix attaching fentry/fexit/fmod_ret/lsm to modules
> >>    bpf/selftests: Test fentry attachment to shadowed functions
> >>
> >>   include/linux/bpf.h                           |   2 +
> >>   kernel/bpf/syscall.c                          |   6 +
> >>   kernel/bpf/trampoline.c                       |  28 ----
> >>   kernel/bpf/verifier.c                         |  18 ++-
> >>   kernel/module/internal.h                      |   5 +
> >>   net/bpf/test_run.c                            |   5 +
> >>   .../selftests/bpf/bpf_testmod/bpf_testmod.c   |   6 +
> >>   .../bpf/prog_tests/module_attach_shadow.c     | 128 ++++++++++++++++=
++
> >>   8 files changed, 169 insertions(+), 29 deletions(-)
> >>   create mode 100644 tools/testing/selftests/bpf/prog_tests/module_att=
ach_shadow.c
> >>
> >> --
> >> 2.39.1
> >>
> >
>
