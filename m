Return-Path: <bpf+bounces-289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C554C6FDF48
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 15:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA61E1C20D74
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 13:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74A712B9A;
	Wed, 10 May 2023 13:54:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADAC12B7F
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 13:54:56 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6152D067
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 06:54:25 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64115e652eeso50392323b3a.0
        for <bpf@vger.kernel.org>; Wed, 10 May 2023 06:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683726850; x=1686318850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFTA+YHZar4Oz118gxD97aBFq0XerCtarrUCLUvjDhs=;
        b=NwW8HStLzcBGBWuhkxk3VYdAOnMpFI2yVJn1HJKOAl5bEHTPYu039z1bmncU6S5wZo
         +WXR6OYkF5YJLRun7lQXumWV2fSLFkwEvAwT/L1R7orgVcScwqJTSHqdcjxc/Wr2mIAZ
         8HenVCgm7/dEKgFfyxt4/q+06b6OUjWM9QuQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683726850; x=1686318850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NFTA+YHZar4Oz118gxD97aBFq0XerCtarrUCLUvjDhs=;
        b=OjnV/eR8Z9BM5gemn90dD5riKvElatBvDRg1ISsM9bdkNn5FTc47gwuUgS4L50ozMe
         VVfzh7OHBPHF0ufoXHSkdwB/NnRMxt20N2jX26IuVDMV1ec24+WA5U0eaQRLdS335Cyw
         r2910MhGD+tInXcCeodLVhNu331W885ceEvcrNyX2MG1W45or9Owuo8vx9ZeIj1h5Xg8
         4TGNCIyD1v3W6VYJE4AwCGFUysy84urYM7lgHbnQj0sUWK3sJ4w09jJh8gBtC2qrOzZL
         ph2Eo+H4iSHWf1BBXfnDgi/sM61imcfWTnLoVIoCBOn7ZAJSbWj0oewDVYBqdy3y46hB
         Bfnw==
X-Gm-Message-State: AC+VfDw/JK+4PxJ8Q3DmPHaxx5XhyJTaz8lQHgEadnpiCmoAuF/Nt3fu
	EwSliUsV7LLM08RITzSJEhtiIcrz/FXywpDFq8XtYQ==
X-Google-Smtp-Source: ACHHUZ5J5Jk+JR6vuoapdbfhTHTzByT7L2jYTyWvA7dlnjqSjg46nP3g1TEKz0R0p2jwesvA/x0xSlQ6S6J4X7O41mQ=
X-Received: by 2002:a17:90a:8186:b0:24e:3e07:9e27 with SMTP id
 e6-20020a17090a818600b0024e3e079e27mr20903759pjn.10.1683726849913; Wed, 10
 May 2023 06:54:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230508164650.3217164-1-revest@chromium.org> <11481869-52a9-037a-c7a4-ebbc7d426229@huawei.com>
In-Reply-To: <11481869-52a9-037a-c7a4-ebbc7d426229@huawei.com>
From: Florent Revest <revest@chromium.org>
Date: Wed, 10 May 2023 15:53:58 +0200
Message-ID: <CABRcYmK_J83T6C+9tqaQ1R5BfQ0D7FQQDFK5h7_UwBEcbu2QsQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] arm64,bpf: Support struct arguments in the BPF trampoline
To: Xu Kuohai <xukuohai@huawei.com>
Cc: bpf <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Zi Shen Lim <zlim.lnx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 10, 2023 at 9:07=E2=80=AFAM Xu Kuohai <xukuohai@huawei.com> wro=
te:
>
> On 5/9/2023 12:46 AM, Florent Revest wrote:
> > @@ -1799,7 +1799,7 @@ static int prepare_trampoline(struct jit_ctx *ctx=
, struct bpf_tramp_image *im,
> >        *                  [ ...               ]
> >        * SP + args_off    [ arg1              ]
> >        *
> > -      * SP + nargs_off   [ args count        ]
> > +      * SP + nregs_off   [ arg regs count    ]
>
> For description consistency, should arg1 ... argN in the previous
> lines also be changed to arg reg 1 ... arg reg N?

Sure, sounds good :) I'll send a v2

(for some reason your email ended up in my spam folder, lucky I noticed it)

