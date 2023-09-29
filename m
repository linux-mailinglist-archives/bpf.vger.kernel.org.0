Return-Path: <bpf+bounces-11107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 710247B32D8
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 14:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 1C960282BDF
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 12:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B032F1865D;
	Fri, 29 Sep 2023 12:54:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208936FB5
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 12:54:23 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC99BF
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 05:54:20 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-5041335fb9cso22171349e87.0
        for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 05:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695992058; x=1696596858; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4Viv0NRYlyOVSdowvuIxWP0Ivw1z0AW2PIRRnxbL6hE=;
        b=JGvssWFzkpj1bfk8rBdYOrYTDZtMNQJjQ2M1f1D2r+hlVFAr0+wbHqJPzjhCsQKJ3d
         2fZrRmh5UIEJvHfLxWw720aXuQc5+Rme5N8ybq1M/hfGYGwPRJAPoLF9KgmX441Yx9UY
         cyLPmgdC6UzeDx38FTNW8ML42Fvk2dQLiKRKXasqEI91v1cetZJW0o8prxShj8FzfM2h
         qRkVuo4SGD0hSEtz/z3qUpTs2y3WsUPjXAl9u+OIIG5joxast27+yHJCFrJtr+Z+0Yvy
         BVC3JuXAIkwmXtpifdclMRGh4OFqRrbKZE4FAn/258r5DOBct0JCV+ikgpL7cLSMGBry
         V8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695992058; x=1696596858;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Viv0NRYlyOVSdowvuIxWP0Ivw1z0AW2PIRRnxbL6hE=;
        b=w813SXlAizDLyFNw3/GHrNQbeip3SCK0p8eqzh0MbVAaCtT819OnawgLzssUAMNuAO
         fI8iZgX2HIqp2xwPbAF6snAYidrKkJCV8Xb/ilKlp03UmpCk3e3zlj9Vd8P4fPTYKCEI
         sf2/rMH8ulWwY92Ev2icfBqz3+XKiq2KRYWuQXvzArutJIZnaR9LVRhaDvyTqDrUdkzB
         wjf0kXh+4IY4vw8z65b+fRCWgjWYXRCl+3ld0KqGaVeVF5D93z8wWEt8+EbSAfdRTGGR
         rNzlsnE+xG91jkfgjpaRWItgLACMbLC+IFloolNY713mETycyz74OHKnOPSX5cdwaLOc
         GtMw==
X-Gm-Message-State: AOJu0YwT7vOjTzQKnfW7bO1eBU4namGZD/kYpDnd//gwFmW704uXtxtd
	KGdtTubsAMr0FZS2u6f9YRg=
X-Google-Smtp-Source: AGHT+IGXCHgAiHmeuGQN4DBVgEj+g8FKFlVU8bIPaqAi3ZSftAO8LNp0GDz40bLUu4THCxfp0sxYsw==
X-Received: by 2002:ac2:48b4:0:b0:505:70fd:9711 with SMTP id u20-20020ac248b4000000b0050570fd9711mr1058398lfg.68.1695992058276;
        Fri, 29 Sep 2023 05:54:18 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id v3-20020ac25583000000b005056efb6bafsm288744lfg.128.2023.09.29.05.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 05:54:17 -0700 (PDT)
Message-ID: <eb00a1e51d720a519d8ed1537e99e6c7996b6766.camel@gmail.com>
Subject: Re: BPF_ALU | BPF_MOVSX with offset = 32?
From: Eduard Zingerman <eddyz87@gmail.com>
To: Dave Thaler <dthaler@microsoft.com>, Yonghong Song
 <yonghong.song@linux.dev>
Cc: "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Date: Fri, 29 Sep 2023 15:54:16 +0300
In-Reply-To: <PH7PR21MB3878516D62B3AFA921A999F1A3C1A@PH7PR21MB3878.namprd21.prod.outlook.com>
References: 
	<PH7PR21MB3878516D62B3AFA921A999F1A3C1A@PH7PR21MB3878.namprd21.prod.outlook.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-09-28 at 21:35 +0000, Dave Thaler wrote:
> In re-reading the instruction-set.rst changes for sign extensions, there =
is one ambiguity
> regarding BPF_ALU | BPF_MOVSX with offset =3D 32.
>=20
> Is it:
> a) Undefined (not a permitted instruction), or
> b) Defined as being synonymous with BPF_ALU | BPF_MOV?
>=20
> The table implies (b) when it says:
> > BPF_MOVSX  0xb0   8/16/32  dst =3D (s8,s16,s32)src
>=20
> But the following text could be interpreted as ():
> > ``BPF_ALU | BPF_MOVSX`` :term:`sign extends<Sign Extend>` 8-bit and 16-=
bit operands into 32
> > bit operands, and zeroes the remaining upper 32 bits.

Hi Dave,

I checked current verifier implementation and it goes with option (a):

    static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *=
insn)
    {
        ...
        } else if (opcode =3D=3D BPF_MOV) {
            if (BPF_SRC(insn->code) =3D=3D BPF_X) {
                ...
                if (BPF_CLASS(insn->code) =3D=3D BPF_ALU) {
                    if (insn->off !=3D 0 && insn->off !=3D 8 && insn->off !=
=3D 16) {
                        verbose(env, "BPF_MOV uses reserved fields\n");
                        return -EINVAL;
                    }
                } ...
                ...
            } ...
        ...
    }
   =20
For 32-bit move it reports error if insn->off =3D=3D 32.
LLVM backend also uses option (a) as it only defines MOVSX_rr_32_8 and
MOVSX_rr_32_16, thus hypothetical MOVSX_rr_32_32 would be rejected by
disassembler.
=20
> There's no reason I can think of to use it, given it's synonymous but if =
given a BPF program that
> uses it, should it be rejected by a verifier/disassembler/etc.?  Or treat=
ed as valid?

Atleast this is what happens now.

Thanks,
Eduard.

