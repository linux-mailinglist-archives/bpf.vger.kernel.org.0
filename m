Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9202C645055
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 01:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiLGA3h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 19:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiLGA3d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 19:29:33 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA482A73E
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 16:29:32 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id gh17so10310990ejb.6
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 16:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1iSMhlHKkb2JmsRow4AlMJVP4plxylkIo6rRQIMFeKc=;
        b=mJyINjxUg43SzCM1r+jJOAxZgcAooz7ZowBt7Y+rF08ZVS2vpccVLPbGMps6iBydCT
         k2jMkIeICX+gJ6CCHm/xUhnAxPXiKnct2aZ1OX4FQqreoSNoesSCZ3wZQKCEPepcFjKa
         njcLmwIXb/rE93BwXErLwTc6f5SqXkLyTzKSqetMqkQ1RP2jwdZM3u29UKAK4kw7x3a8
         R//uD/+RVzdZkDAmj1i2KmngkC2yJHXxANn/7/vhzfp0ds0POi51wcnGlIjgwRC20dIl
         /drfQRsr4AElyNTGGkkGj5XUCTGjhnoCgCyCF8grAOcelfRRYqd06xAuknBC86hiBUa1
         xLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1iSMhlHKkb2JmsRow4AlMJVP4plxylkIo6rRQIMFeKc=;
        b=IQOFMtO4DpcrLfhG2GAgpAZn67aRfIiT/nUxFiRPWVPLhp7vaozxe/lA46P5J/3V6p
         LDlJQ8pMGhAhfP49BArkeSWkxUVQpXAc8IFZAqkq08uVOdh1zabGDsIM/pXfXZG9nnle
         dqH6lUmeND/2XT+/siBL2tXS1EaJkgj0LlxqwCt4F5mlXZL+BGJGvdmOOuRqzIXURNre
         8N4s6nlKW41ENOpXJSdBsNoe+6Ze5xcwG+/cPUQe53z65qrrD9BazDzjNKVQzS9+UmxS
         TujS8GnjtIf2pLarm/zN31q/zF25lsgByFnkRITPKwpy3Pwk/8wMbHjxut8cwzkdjkat
         ErPw==
X-Gm-Message-State: ANoB5pmN+OPETqMBd6382MdH8vhfw1XTU0vXWqEZbRQsfrrbKxz90+aO
        xFBmUv+VFzI12z5B4ZeWCmMx9IA/kw3oTlHmSpCaxbrf
X-Google-Smtp-Source: AA0mqf6lo9bSfJOSHnVq1jpt3uObag6D2NhukcKMQEOybF+C+8IMVZyOwqlFk2PM4+3EJWN9FSvFJcsBDLFl74GaTws=
X-Received: by 2002:a17:906:94e:b0:7ba:4617:3f17 with SMTP id
 j14-20020a170906094e00b007ba46173f17mr52898604ejd.226.1670372970902; Tue, 06
 Dec 2022 16:29:30 -0800 (PST)
MIME-Version: 1.0
References: <20221205131618.1524337-1-daan.j.demeyer@gmail.com> <20221205131618.1524337-2-daan.j.demeyer@gmail.com>
In-Reply-To: <20221205131618.1524337-2-daan.j.demeyer@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 6 Dec 2022 16:29:18 -0800
Message-ID: <CAEf4BzYgFUS+Tqq72r5RgrMF6nHEp-zk7sc3jY1x19eS4wWXSQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: Install all required files to
 run selftests
To:     Daan De Meyer <daan.j.demeyer@gmail.com>
Cc:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 5, 2022 at 5:25 AM Daan De Meyer <daan.j.demeyer@gmail.com> wrote:
>
> When installing the selftests using
> "make -C tools/testing/selftests install", we need to make sure
> all the required files to run the selftests are installed. Let's
> make sure this is the case.
>
> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 6a0f043dc410..f6b8ffdde16f 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -532,8 +532,10 @@ TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko     \
>                        $(OUTPUT)/liburandom_read.so                     \
>                        $(OUTPUT)/xdp_synproxy                           \
>                        $(OUTPUT)/sign-file                              \
> -                      ima_setup.sh verify_sig_setup.sh                 \
> -                      $(wildcard progs/btf_dump_test_case_*.c)
> +                      $(realpath ima_setup.sh)                         \
> +                      $(realpath verify_sig_setup.sh)                  \

why do we need realpath for these scripts, but it's ok to not do that
for *.bpf.o and btf_dump_test_case_*.c below?


> +                      $(wildcard progs/btf_dump_test_case_*.c)         \
> +                      $(wildcard progs/*.bpf.o)
>  TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
>  TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS) -DENABLE_ATOMICS_TESTS
>  $(eval $(call DEFINE_TEST_RUNNER,test_progs))
> --
> 2.38.1
>
