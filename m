Return-Path: <bpf+bounces-8065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EEE780BB3
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 14:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D2691C2161B
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 12:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198F218AFA;
	Fri, 18 Aug 2023 12:23:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE83117FE9
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 12:23:01 +0000 (UTC)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E1EE7C
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 05:23:00 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-565f58f4db5so657533a12.0
        for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 05:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692361380; x=1692966180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ric5bKa/MsOuxTFdG8D/2C2k7yPaH8irBlhbtjjHXXk=;
        b=jIY2AHnEVq7QfzXKZLEbIheqIfVX/WOuXMLdyLtPhp52tONwjxbqyhXNTOKwvZmnip
         yc+V1XnhgtL//VTTeqrLnRB2iHYTxKcd6n55OXJJ1gNNIn8YHotfQaisLxhT0i7hG3CF
         M9X73MI585Ab5yregi2xZZ0OKOrRSU5kHL5ZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692361380; x=1692966180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ric5bKa/MsOuxTFdG8D/2C2k7yPaH8irBlhbtjjHXXk=;
        b=TZCWRBgSd1L8sQLPs4JkSb2Mcv3k28U0xSdh3dvWhucTH2stkhoSNwROZ0ERYCTfjS
         wtCn2fufmeIPzG2l+TAsst9RGspt0OvdGOMoIU/iBpBGmGuMA20f8rvBkPbeBUHa7/bG
         tRXsajHUPPfpSdoJIznmn+DSdFYpvbVSjXJ7LjS5WfUMEwotzuw5+0HeQJKTQf0/BWaX
         Z2iz9tgp0Rz9uhEg7FthZuN4o1FUNHzCXbMeiQWf4Hq/ZJfvAhBRf19mITMsTRyV6gSx
         uMB2zy9QFnAt+46Rk2gogBmbNqQOCHtCScK6kSQDwhhpD5BfKfusD0R1PorhBTOcSckV
         //Ag==
X-Gm-Message-State: AOJu0YzILskoX6WddB4ILtetKP8CW1NRYXtKLM/BSA0Cc0dEbJS4+Ul1
	jlwZwRv7YbVRT+OjxuB6GKrEMyI5qdh1u0Cl0IyFqIZPMiRG+d7F
X-Google-Smtp-Source: AGHT+IHelV4VvuL7lM9KvjGmNypvQfMShSOCTZXYmL3ldagBIJZpatow/N9YhzBWcqnuvOPIwWQVuKCkw+EqwUgK50M=
X-Received: by 2002:a17:90a:c204:b0:268:1be1:745a with SMTP id
 e4-20020a17090ac20400b002681be1745amr2090363pjt.29.1692361380223; Fri, 18 Aug
 2023 05:23:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230815154158.717901-1-xukuohai@huaweicloud.com>
In-Reply-To: <20230815154158.717901-1-xukuohai@huaweicloud.com>
From: Florent Revest <revest@chromium.org>
Date: Fri, 18 Aug 2023 14:22:49 +0200
Message-ID: <CABRcYmK1ByvJmozEp5opq8B_0VxoOdRFrSxVfdcNwcsFCN7yKg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/7] Support cpu v4 instructions for arm64
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Yonghong Song <yhs@fb.com>, Zi Shen Lim <zlim.lnx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 15, 2023 at 5:21=E2=80=AFPM Xu Kuohai <xukuohai@huaweicloud.com=
> wrote:
>
> From: Xu Kuohai <xukuohai@huawei.com>
>
> This series adds arm64 support for cpu v4 instructions [1].
>
> [1] https://lore.kernel.org/all/20230728011143.3710005-1-yonghong.song@li=
nux.dev/
>
> Xu Kuohai (7):
>   arm64: insn: Add encoders for LDRSB/LDRSH/LDRSW
>   bpf, arm64: Support sign-extension load instructions
>   bpf, arm64: Support sign-extension mov instructions
>   bpf, arm64: Support unconditional bswap
>   bpf, arm64: Support 32-bit offset jmp instruction
>   bpf, arm64: Support signed div/mod instructions
>   selftests/bpf: Enable cpu v4 tests for arm64

Thank you Xu! The series looks good to me so:

Acked-by: Florent Revest <revest@chromium.org>

And I could reproduce your successful test runs with a recent clang so:

Tested-by: Florent Revest <revest@chromium.org>

