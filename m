Return-Path: <bpf+bounces-2643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6D4731CE4
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 17:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D22021C20EFD
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 15:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4A017FE5;
	Thu, 15 Jun 2023 15:44:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3723215AEF
	for <bpf@vger.kernel.org>; Thu, 15 Jun 2023 15:44:32 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4AA273F
	for <bpf@vger.kernel.org>; Thu, 15 Jun 2023 08:44:31 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-19a427d7b57so5352906fac.2
        for <bpf@vger.kernel.org>; Thu, 15 Jun 2023 08:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686843870; x=1689435870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4StmFmRajOimzwQuxAIm4oA1Qq+pBLBdDXasM5CJ9r0=;
        b=X9ur/1kQVScMujlfFfp3RRguZGxLCtamV4Mzp2jhXW69XuqY70QQFqj0rNBmgLCsao
         YezKD56/IDNwS0TvAu+X+bUeyOKHcNbo5hcSRIIDiQQNyCaVmT0uSxyHhW15PYIizP0m
         aFyjKgl/6bkcVvtG5PUV5GOXL1+F9NzTfdDE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686843870; x=1689435870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4StmFmRajOimzwQuxAIm4oA1Qq+pBLBdDXasM5CJ9r0=;
        b=GIbQ7sNsrzLLMyZ4ej//1UKtOAtp5bN87DuYsUAYNnuaNkEMgNXni4SclIFbKnNL/q
         eu/JjDKVIMcfX4EeahUQupv4S6ZdC+tsmzHgHXyspTpO8kMGfZEhjdZi2Dughhx6B4HQ
         utVrkE0bpRcfUiGyCjT/sB1MQc5dtwAL1Yr+HUdgBXTCdz91VmzON6Sxwo0yrBVRx5ET
         tyrR6tIX9e0Gs7kLiQ8/aFMpx0IVjz1wuG0Ebb4AMVztUPX/dM0Z485stJHXRu57JD+z
         SBHulw2tH4g6kJSUi43npR49FqFMC51d6JI2h25haMsv8mwY4+4yb0cmn6VDBpBtA/ln
         4x3g==
X-Gm-Message-State: AC+VfDwPiY3fyD4lnhFHXdcp70AeEGr1Oci0oazF9cjNrqRLVkOYvXWQ
	VR7/fCcqC0Dj37ASwlPGtSAsyEJr3fu5A50cLVotftEY5H8XrO/PqG5bSw==
X-Google-Smtp-Source: ACHHUZ4XzMRy765MiqkYZk2EQDL/FAz6ib58uJzpHUeyESFt2Ss5dqWqW1EtsOL4TZFKrIHxwhGFu6PjB0MFUoR5V30=
X-Received: by 2002:a05:6870:d450:b0:180:857:d47d with SMTP id
 j16-20020a056870d45000b001800857d47dmr13034116oag.57.1686843870070; Thu, 15
 Jun 2023 08:44:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230615145607.3469985-1-revest@chromium.org>
In-Reply-To: <20230615145607.3469985-1-revest@chromium.org>
From: Florent Revest <revest@chromium.org>
Date: Thu, 15 Jun 2023 17:44:18 +0200
Message-ID: <CABRcYm+C+tPwXAGnaDRR_U2hzyt+09fjkKBp3tPx6iKT4wBE2Q@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf/btf: Accept function names that contain dots
To: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 15, 2023 at 4:56=E2=80=AFPM Florent Revest <revest@chromium.org=
> wrote:
>
> When building a kernel with LLVM=3D1, LLVM_IAS=3D0 and CONFIG_KASAN=3Dy, =
LLVM
> leaves DWARF tags for the "asan.module_ctor" & co symbols.

To be fair I can't tell if this is an LLVM bug. It's sort of curious
that with LLVM_IAS=3D1, these debugging symbols are not kept and they
are with LLVM_IAS=3D0 but I don't know what the expected behavior should
be and how BTF should deal with it. I'll let people with more context
comment on this! :)

An easy reproducer is:

$ touch pwet.c

$ clang -g -fsanitize=3Dkernel-address -c -o pwet.o pwet.c
$ llvm-dwarfdump pwet.o | grep module_ctor

$ clang -fno-integrated-as -g -fsanitize=3Dkernel-address -c -o pwet.o pwet=
.c
$ llvm-dwarfdump pwet.o | grep module_ctor
                DW_AT_name      ("asan.module_ctor")

> In a dramatic turn of event, this BTF verification failure can cause
> the netfilter_bpf initialization to fail, causing netfilter_core to
> free the netfilter_helper hashmap and netfilter_ftp to trigger a
> use-after-free. The risk of u-a-f in netfilter will be addressed
> separately

To be precise, I meant "netfilter conntrack".

I sent the following patch as a more targeted mitigation for the uaf
https://lore.kernel.org/netfilter-devel/20230615152918.3484699-1-revest@chr=
omium.org/T/#u

