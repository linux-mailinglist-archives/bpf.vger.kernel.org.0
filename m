Return-Path: <bpf+bounces-15693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A54067F4FBE
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 19:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45515B20E66
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 18:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6085CD0C;
	Wed, 22 Nov 2023 18:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HY79OHuU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39B7101
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 10:39:28 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507adc3381cso5704e87.3
        for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 10:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700678367; x=1701283167; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bYgkpeKZIVMPGtIfLVYcJHsZwD+llpJZUsXtfWeApnY=;
        b=HY79OHuUOHQRl+9glI6Kn2lmeGFyl35fgvkDISmhbxZEZl/St39M3ZowqwqztRAg5x
         drDtyjdJDQCD4H4P83574ydXOFZiP2dqgwdeRPmBCx4UlrXRnxCNbxcuvkdA/eK/5JVd
         8HQ/b9TaQXJYjbQz7BeSf/U9rICyZalHc0nEmLJrhgV7Xxt+UiPApHI+f5SDhSxb2ygh
         1XFJnOHXwL3sNCSMaJCQtYiPOkj76lgk5eykdDOBI7OhV2I6L0atS3CH6zDpRqqNTum6
         zBM4e2Q+tS47oNpBD4e3h70woGEgZLIlPt6xcvqxvIm0TDVnt3Pl09Ax9+U/GFkq4lPW
         V9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700678367; x=1701283167;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bYgkpeKZIVMPGtIfLVYcJHsZwD+llpJZUsXtfWeApnY=;
        b=UsyZLwlpDLnZUfqQLPxheFsDISwgHq3b8g+tkxU7pAm47SHJwXvxdglrjwbHHJLVLD
         l8wqcHcK8dtUFhcgNlAtrsjGLTgZN5xshupTGouylwKBJWQU99i1XBv7VfAj3WTSdf/k
         vQvtyua42lNXY8OJtZnRqTTJiB7fAMwq6CFTUYo3jVs9M6ubcSHNMItpUY/kOFa++ZCm
         XfdPd//aZLyEWYmNzqf2uKrF1r5AYPBmo2hrRgVraX2itlj2HK95iYqR3nqMP9nWzhIG
         9PU+0TBXSSJZKwHHFhdEMYCbshRYh9FZmGVhTx5iMCKV6U9hZNGHsMGVms7jXkg4qj1t
         rQLQ==
X-Gm-Message-State: AOJu0YwmqRioiBsBjwODoiJUUPGDRkwnLjGH1Ktn4WOQCnebh1omcVPq
	qt1MpBQ/CbQIRPLJtvh8iu4=
X-Google-Smtp-Source: AGHT+IGmuLt2D30JwbKrXDkZ46AYYYooPjhBIHgSmLs3TynJ03Ajy+a5JAqN8ctTb+JEE67g9SEnmw==
X-Received: by 2002:a05:6512:1591:b0:50a:bb04:2321 with SMTP id bp17-20020a056512159100b0050abb042321mr2918675lfb.1.1700678366728;
        Wed, 22 Nov 2023 10:39:26 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id c13-20020a056512238d00b0050810b02cffsm1918935lfv.22.2023.11.22.10.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 10:39:26 -0800 (PST)
Message-ID: <fd1defcbd087bdd145694298a8e82acc3e244831.camel@gmail.com>
Subject: Re: [PATCH] C inlined assembly for reproducing max<min
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Yonghong Song
	 <yonghong.song@linux.dev>, "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: Tao Lyu <tao.lyu@epfl.ch>, Andrii Nakryiko <andrii@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Hao Luo <haoluo@google.com>, Martin KaFai Lau
 <martin.lau@linux.dev>,  mathias.payer@nebelwelt.net,
 meng.xu.cs@uwaterloo.ca, sanidhya.kashyap@epfl.ch,  Song Liu
 <song@kernel.org>
Date: Wed, 22 Nov 2023 20:39:24 +0200
In-Reply-To: <CAADnVQJqmpSoABqd-dCQBU2ExiPda1mHz2pKHv2jzpSMYFMeqQ@mail.gmail.com>
References: <d3a518de-ada3-45e8-be3e-df942c2208b5@linux.dev>
	 <20231122144018.4047232-1-tao.lyu@epfl.ch>
	 <2e8a1584-a289-4b2e-800c-8b463e734bcb@linux.dev>
	 <CAADnVQJqmpSoABqd-dCQBU2ExiPda1mHz2pKHv2jzpSMYFMeqQ@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-11-22 at 10:15 -0800, Alexei Starovoitov wrote:
[...]
> >   multiclass J<BPFJumpOp Opc, string OpcodeStr, PatLeaf Cond, PatLeaf C=
ond32> {
> >     def _rr : JMP_RR<Opc, OpcodeStr, Cond>;
> >     def _ri : JMP_RI<Opc, OpcodeStr, Cond>;
> > @@ -265,6 +329,10 @@ defm JULT : J<BPF_JLT, "<", BPF_CC_LTU, BPF_CC_LTU=
_32>;
> >   defm JULE : J<BPF_JLE, "<=3D", BPF_CC_LEU, BPF_CC_LEU_32>;
> >   defm JSLT : J<BPF_JSLT, "s<", BPF_CC_LT, BPF_CC_LT_32>;
> >   defm JSLE : J<BPF_JSLE, "s<=3D", BPF_CC_LE, BPF_CC_LE_32>;
> > +def JSET_RR    : JSET_RR<"&">;
> > +def JSET_RI    : JSET_RI<"&">;
> > +def JSET_RR_32 : JSET_RR_32<"&">;
> > +def JSET_RI_32 : JSET_RI_32<"&">;
> >   }
> >=20
> >   // ALU instructions
> >=20
> > can solve your inline asm issue. We will discuss whether llvm compiler
> > should be implementing this instruction from source or not.
>=20
> I'd say 'yes'. clang/llvm should support such asm syntax.
>=20
> Jose, Eduard,
> Thoughts?

I agree, since instruction is documented it should have assembly
representation. All other instructions from instruction-set.rst seem
to have one.

