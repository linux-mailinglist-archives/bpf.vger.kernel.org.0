Return-Path: <bpf+bounces-11148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB317B3D58
	for <lists+bpf@lfdr.de>; Sat, 30 Sep 2023 02:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 762BD1C20A32
	for <lists+bpf@lfdr.de>; Sat, 30 Sep 2023 00:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86B465C;
	Sat, 30 Sep 2023 00:47:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5279E361
	for <bpf@vger.kernel.org>; Sat, 30 Sep 2023 00:46:59 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895B894
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 17:46:56 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3231df054c4so10492283f8f.0
        for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 17:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696034815; x=1696639615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTdhIwSsz/a8w2ifkRuW3ixhiP6zM2k4XZTaLkMo6mw=;
        b=evIFR9Glygi4H4ckqMz4Y0jQ7DIHPcYIwa0PTD372k8Jli4WmQygncVegSwKEtQSiY
         kdGLFxp/4d56908wY4VaJIn/OghMRazYy7a/kq8GSY3jWBuJIT7Z37BVrc98rDJKeIZs
         Z2oyscaj6bBN6fj8maDKHxjLDQQnAK/ilH1E7JWFjK+3X/nd6Ij0TfR6SxarZcHkW4u5
         lrXrzv3q7QBukIEZGSyYuvyOK/bAhnuUVw+7/opqU6URHRl/iuZAI5XQL+J3107D8ny+
         AGnf8iV6r5902KunWbv/u4Wv6B2IL+xAiFA56EraWbJqKvM5KcGC6NOi4i/zk07KAZ/o
         FrQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696034815; x=1696639615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kTdhIwSsz/a8w2ifkRuW3ixhiP6zM2k4XZTaLkMo6mw=;
        b=NR4M7MmSv2eZoez8EYUJAN6zFj6IbntUmcCerav3wD2gBeAXIbBQkCkPaTZ8EDUbmh
         i5LrqdxHomB+HfmnQaQEORmvhz1OHPb4wdqLNabccJQp7+m1ezvjB2/A5ZaLlymvRuQj
         pPqihat+pEJeexLwlweZXQlDvzSvKQCCve7cSamgSMqpb9dJUF1sKFYr1yTlzw7TlBek
         Q3sxvgqKoL5IiNAzMsnhyQ+dndb6LU5z6fTMyJcJv6VSNo8utfti2Z1rQXv2m4xi9ThE
         yKFrcksJ3ljHnyhR77c7FYqVIDD42ChIZ5XdS1wUG8LAJE+CiH+Z9fLcH+KVKJsCkuao
         nXnA==
X-Gm-Message-State: AOJu0Yxn4nsI+10yi2svcbEIsSnM3uMgETR6aH07LO5qp+CapooAoh2Z
	F1ytVrB/VlofOA3UYv1pp75CioZDMysCEVMxvX4iEhEHW20=
X-Google-Smtp-Source: AGHT+IHvytC5vmWOY9Caqd219ycSRnCXAH0fSJkUbFvlrLu/mYdI7/4eePDur0SYwVrOT4FNSJMZ8go7XbDd7J7PSyo=
X-Received: by 2002:a5d:6950:0:b0:319:7656:3863 with SMTP id
 r16-20020a5d6950000000b0031976563863mr4457344wrw.47.1696034814654; Fri, 29
 Sep 2023 17:46:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PH7PR21MB3878516D62B3AFA921A999F1A3C1A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <eb00a1e51d720a519d8ed1537e99e6c7996b6766.camel@gmail.com>
In-Reply-To: <eb00a1e51d720a519d8ed1537e99e6c7996b6766.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 29 Sep 2023 17:46:43 -0700
Message-ID: <CAADnVQJam8GS1Q5yDjXroUV3k=4Btm_Guso1WxUFyhwETvgwFQ@mail.gmail.com>
Subject: Re: BPF_ALU | BPF_MOVSX with offset = 32?
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Dave Thaler <dthaler@microsoft.com>, Yonghong Song <yonghong.song@linux.dev>, 
	"bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 29, 2023 at 5:54=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2023-09-28 at 21:35 +0000, Dave Thaler wrote:
> > In re-reading the instruction-set.rst changes for sign extensions, ther=
e is one ambiguity
> > regarding BPF_ALU | BPF_MOVSX with offset =3D 32.
> >
> > Is it:
> > a) Undefined (not a permitted instruction), or
> > b) Defined as being synonymous with BPF_ALU | BPF_MOV?
> >
> > The table implies (b) when it says:
> > > BPF_MOVSX  0xb0   8/16/32  dst =3D (s8,s16,s32)src
> >
> > But the following text could be interpreted as ():
> > > ``BPF_ALU | BPF_MOVSX`` :term:`sign extends<Sign Extend>` 8-bit and 1=
6-bit operands into 32
> > > bit operands, and zeroes the remaining upper 32 bits.
>
> Hi Dave,
>
> I checked current verifier implementation and it goes with option (a):

that's correct.
I think that sentence is clear enough:
BPF_ALU | BPF_MOVSX`` :term:`sign extends<Sign Extend>` 8-bit and
16-bit operands into 32.
Which means that 24-bit, 32-bit or other bit width is not permitted.
I frankly don't see any ambiguity.

