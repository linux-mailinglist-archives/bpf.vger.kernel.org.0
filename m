Return-Path: <bpf+bounces-70169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B2BBB2031
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 00:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68B0216C0FA
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 22:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C210A311C10;
	Wed,  1 Oct 2025 22:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jm8lfT0L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5CB3C2F
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 22:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759358636; cv=none; b=n+8coFxE+zh5X0v4DF/LaUc/lqprtBPdajWAM/CTVHk1AmwHE1NsaB4kZsNqrCDiKSXq3LLrsZ1KXlQ3+ZEKj4baX3N5Dygbx1kbHktsl4zlpLwMpcUubsvZGzmYzlwj5cTv4U8U52QogePBOpphHuhDQPoA/doON0DCYy4ZweI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759358636; c=relaxed/simple;
	bh=stfu/muFj7xs3rV0AWEv1AMPhh9j9McVZ8ZHblgpYtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xh9/nZlEiJCycQybRaap+ijvK0TfetWt4WWycn4PsBzRTIiuO6HVBd1NxnwsvpjJO4YEz7gXo27jP2DXNr02lxuFOEbOZhZtTPJA/YkGRH2wT8iZU/Eiyayjno2yoFAPe7aRLdkGOecf8IMAJUWJ1XYmzsjT0HXS2+iI8T7CHeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jm8lfT0L; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-421b93ee372so147748f8f.2
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 15:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759358633; x=1759963433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOTPH0HqPl+nYfb0QESMdPoZjCRhGBAJ/4AZhFX5VKM=;
        b=jm8lfT0LSvCEtRen2gjH9BXwjeULNB/3/28Gwk/xBHUeX17FV9QWMJc1HEbECIFCzB
         n953L4GBjR2KcDOQi4J6wsFnw/wZxZqegkn+EJozXJ03I4YTc75kt+9qmGRMcKRUv0w+
         XjIfBP7jNpEmKd91z1K9QuAmN8r2AbvHO79oEXyMHi4S9hyzYQL1jSxiG5J5d10KOgNf
         pUNqrEqnlmmQluE0O0UCZrGWSxT5TMUzqR+7ulyD6JHCAo95bkoWIdC6aa1fJDuXSR68
         Zn5dDeowQlBQrROVBCRsA0V5YPpCUaCZeowNHpI41u/Ze8HrDslT9sgGKQ78rDeDfcec
         Nibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759358633; x=1759963433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yOTPH0HqPl+nYfb0QESMdPoZjCRhGBAJ/4AZhFX5VKM=;
        b=uaLrHBz2Jw9wyG41Aw37wDrQTNFo9HdM73pq7o+9bJJr195r5w8IYAfLSg41wdtMaW
         QuUV/pzNxXnTKV5IV/6IpD6aCAvLMnCk99Za4Mbb1hncNhKWytaJmTWC+6SRu87P3ZqD
         2fhlc3YMulfiA981TiQ/9WU4ysTnqdtTHbah5WkhPuO0DtdEQa19Z/i9Y8l2LX68H3rj
         ja+r8vGJlOXZAxp9y6tSD1MYerN3DzJO5CIgSzxmWK5nBbZr+bKaoD+hft6HfRNRSQI8
         muFVSP8MxNSgPX5PGhFtYDkeWssYxfM729q7EMPrK8mAcrp1Qw5tEm7EiLoZCWPdRmAl
         916Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQJfD0GmBViitP77q6z0CjZp4dt/ZwvfAvrVFqLQcjX3QsNrwrQYB2QgxupV3UHRJ+768=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc4Z3iWVZURXJSwCTcXXiUQVlDVbSu0Z5i0ELyibX1g6L2xg4p
	mUXfDP4IsG0xMXen853xknRKWAK0E3iijUR4ZuP63oSw1jewKm4Jmv7gRu9LMTbv74Kxl1cIo6X
	IHlFiEfxg+ULWFIbqnqO1hO41nGwhNRY=
X-Gm-Gg: ASbGnctv5tgcbZjxB3hMJQZWeYV6gweUZEhwjjKc/ELqkvDJeAmfbcbvDF8vUQKuBHZ
	meFpNs0YjCv0Kz7ts3EIXnxQHRfAMQZxKg/vdngEH8wJqWkVbJOvc7DZbtBlr1FLIJPuM2o31Zd
	WM5gHy5g7cvaS1xO+R1Uvf1Vfxdbl+U0zwasSuJkhEmYYArLdCd9BtPQJGTbOjDcXIlgsW2nii9
	TVLCZLoA/6wvQWOaL8qX2AaYdAS917RhdQcoOlZAnl/aVqzm/KuiL1uzWKm
X-Google-Smtp-Source: AGHT+IF1NKrjJqAY/snBgiA7cmziDUHKbnS6vAZF/A4vbSI8VQFn4crfJfryZg3t6ItFqfWHGQmAr42R503RE1NZFrA=
X-Received: by 2002:a05:6000:4282:b0:40e:31a2:7efe with SMTP id
 ffacd0b85a97d-425577f4cb8mr4135385f8f.14.1759358632495; Wed, 01 Oct 2025
 15:43:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_70D024BAE70A0A309A4781694C7B764B0608@qq.com> <ce95e0574660f0f9d8cc2a280957aa4f922e6458.camel@gmail.com>
In-Reply-To: <ce95e0574660f0f9d8cc2a280957aa4f922e6458.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 1 Oct 2025 15:43:41 -0700
X-Gm-Features: AS18NWAhirZLj6COt6Ekc7dX7LZSMoKf-WasfTMdOSN2rf9Z3bSFLCWTcS7s0gw
Message-ID: <CAADnVQLZwiDStRSkB=pHXEZ6emqBebH+Db1KBJnnc4cYWn6vww@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Correctly reject negative offsets for ALU ops
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: yazhoutang@foxmail.com, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Yazhou Tang <tangyazhou518@outlook.com>, Shenghao Yuan <shenghaoyuan0928@163.com>, 
	Tianci Cao <ziye@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 11:14=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2025-09-30 at 23:04 +0800, yazhoutang@foxmail.com wrote:
> > From: Yazhou Tang <tangyazhou518@outlook.com>
> >
> > When verifying BPF programs, the check_alu_op() function validates
> > instructions with ALU operations. The 'offset' field in these
> > instructions is a signed 16-bit integer.
> >
> > The existing check 'insn->off > 1' was intended to ensure the offset is
> > either 0, or 1 for BPF_MOD/BPF_DIV. However, because 'insn->off' is
> > signed, this check incorrectly accepts all negative values (e.g., -1).
> >
> > This commit tightens the validation by changing the condition to
> > '(insn->off !=3D 0 && insn->off !=3D 1)'. This ensures that any value
> > other than the explicitly permitted 0 and 1 is rejected, hardening the
> > verifier against malformed BPF programs.
> >
> > Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> > Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> > Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
> > Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
> > Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
> > ---
>
> The change makes sense to me.
> Could you please add a selftest?
> Something like this:
>
> ---- 8< ------------------------------
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_sdiv.c b/tools/te=
sting/selftests/bpf/progs/verifier_sdiv.c
> index 148d2299e5b4..c0f7e6d82e13 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_sdiv.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_sdiv.c
> @@ -1221,4 +1221,20 @@ int dummy_test(void)
>
>  #endif
>
> +#include "../../../include/linux/filter.h"
> +
> +SEC("socket")
> +__failure __msg("BPF_ALU uses reserved fields")
> +__naked void div_bad_off(void)
> +{
> +       asm volatile(
> +               "r0 =3D 1;"
> +               ".8byte %[bad_div];"
> +               "r0 =3D 0;"
> +               "exit;"
> +       :
> +       : __imm_insn(bad_div, BPF_RAW_INSN(BPF_ALU64 | BPF_DIV | BPF_X, 0=
, 0, -1, 0))
> +       : __clobber_all);
> +}
> +
>
> ------------------------------ >8 ----
>
> But maybe wrap this with a macro, to try different opcodes and offsets/im=
m.
>
> >  kernel/bpf/verifier.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 9fb1f957a093..8979a84f9253 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -15739,7 +15739,7 @@ static int check_alu_op(struct bpf_verifier_env=
 *env, struct bpf_insn *insn)
> >       } else {        /* all other ALU ops: and, sub, xor, add, ... */
> >
> >               if (BPF_SRC(insn->code) =3D=3D BPF_X) {
> > -                     if (insn->imm !=3D 0 || insn->off > 1 ||
> > +                     if (insn->imm !=3D 0 || (insn->off !=3D 0 && insn=
->off !=3D 1) ||
> >                           (insn->off =3D=3D 1 && opcode !=3D BPF_MOD &&=
 opcode !=3D BPF_DIV)) {
> >                               verbose(env, "BPF_ALU uses reserved field=
s\n");
> >                               return -EINVAL;
> > @@ -15749,7 +15749,7 @@ static int check_alu_op(struct bpf_verifier_env=
 *env, struct bpf_insn *insn)
> >                       if (err)
> >                               return err;
> >               } else {
> > -                     if (insn->src_reg !=3D BPF_REG_0 || insn->off > 1=
 ||
> > +                     if (insn->src_reg !=3D BPF_REG_0 || (insn->off !=
=3D 0 && insn->off !=3D 1) ||
> >                           (insn->off =3D=3D 1 && opcode !=3D BPF_MOD &&=
 opcode !=3D BPF_DIV)) {
> >                               verbose(env, "BPF_ALU uses reserved field=
s\n");
> >                               return -EINVAL;
>
> Nit: personally, I'd change this whole 'if' block to something like below=
:
>
>                 bool good_off =3D insn->off =3D=3D 0 ||
>                                 (insn->off =3D=3D 1 && (opcode =3D=3D BPF=
_MOD || opcode =3D=3D BPF_DIV));
>                 bool good_imm =3D BPF_SRC(insn->code) =3D=3D BPF_X
>                                 ? insn->imm =3D=3D 0
>                                 : insn->src_reg =3D=3D BPF_REG_0;
>
>                 if (!good_off || !good_imm) { // (or make these bad_off a=
nd bad_imm)

I think it's less readable.
So applied as-is.

Yazhou,

please follow up with a selftest.

