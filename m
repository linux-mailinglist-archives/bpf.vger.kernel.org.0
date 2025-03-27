Return-Path: <bpf+bounces-54822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5B1A7347F
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 15:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0565E1783F3
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 14:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A308217F30;
	Thu, 27 Mar 2025 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ff7SnedY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F74B20E6FA
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 14:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743085976; cv=none; b=OJYgqI8S0XZ3Sv6NadWF3Mh4O9gzpUZ3k8JZGXqHtQF2Y+BtslBg2y+PIqQLG/YTbZ/Jt5OKuA7/Aqj0XfOASV2Yya+jrNxetX32ydqxW7ujCdbYV+AiEo2r+SIfR+G4ihe03z6qecd0D+ZFhAfxRXdzTLcjqlEDk+OAikS37HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743085976; c=relaxed/simple;
	bh=SlSpDNGcF9tes4e0zEu1wDuZRURWsxEymPc1Hxa3I+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rQy8fCQAN5TEWBNXxhqx6weuUvDfGW4ehqx03DVm8++nyLGYdlOEyd33imnnj2tyLfeN4h/MA6GaDC9gzgpN4szOC8x89NMZa5M9iMtZm+KkUvVzj3LIsMG0XjS1gARol3NYwv1lB0cKCu8ifQ6r6vG4t4SgcWg4d9Hi8vsRvMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ff7SnedY; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-601ebdf02daso634570eaf.0
        for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 07:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743085974; x=1743690774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9c+V+yyatY40KwSh2gkT+ww1rGMA56ItZglBMmFuto=;
        b=Ff7SnedY6rlSlm42I1eMw1II8jwtv5zp7RWyNxRHyc9WMq6rQVedNQT4qxsGNFFT1B
         di2AcSGt9PhgAAI/0oGrWvR2ln1Y4sGjpicUdNwfuHz1DHn8SWgw2pnlpv2lOblGfPpn
         QUGpMUqD0e/BEFDbi9eopcKvSAtX5s7AzxSQowkRZkuc7yxdHkx1DZfjslUQr1CRwIXC
         gp8SqUh/oLO98UgEFzbUI8SwdJAag4ptrYYSsf9T3QZbRsg9fjEGveZHVS1GZNyyIaMC
         lLO18BhA1EHV+hXHS1UFBJXhdcOfU+tJOVT+P6F9rwKvQYNyJK4MhvdOAXTKIsYRn7wt
         cI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743085974; x=1743690774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9c+V+yyatY40KwSh2gkT+ww1rGMA56ItZglBMmFuto=;
        b=Kl5WjizRKlevsGUEGzhKHh7kd7eVJV3pf1Uhn0ni+l2kSOY5x5oGRNPYBW+JyeeC5O
         YNl5X1XXDAB7LO4wwkBPQW5d7tW0Om2Mu68RDZ+jkuULtvZ5hme04DnrkM7ORzJtTbVi
         UNlCQQu/Wl7btptZLZBHXdw2hWdxe8jsfGeT+RB1BzAReNRVdCsqM8jYMZYh7MbyUKIY
         nr3niT0ndUYGEFABDTegAItljJtbYy8MYHLKj95AJRnhJNcQ6i5msP04uGGJO2z1oxRD
         z8IdGAKP2ttkIRyRpvvC+65Fclg744UA4H3gR9ogpCSEi496FWOQb1lYzjNmLFlgYXad
         Jqpw==
X-Forwarded-Encrypted: i=1; AJvYcCWOpJLFAullcDZhSu3W0CriyxCBHVxPJclVn4ep3+DqONH7eXaKqqiU2iMwHz+tiqBDl9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsN0ZO3fOgq5jzCp2hAtDGZd5e22OZtI/iH71L9Qp6EQ9/odom
	Zf5h+WaYx3rUa246FYqoMRv9Q+CH9DBG5K/7BYqBFDauLT1k30JXoD1vE+OJbOIl0RWXv/TImMp
	1gYJHNH8MnBAvNr7+PvGG5SH4BYI=
X-Gm-Gg: ASbGncsHkCSRAwG1dXXgoSxCD9wsfH2A4DfWhvjCJ99yy/l2YQXes+QhOOnbvAiWmVP
	9eSNPgr3LNTetiuIj+AphClnkU8Xrp26iWU/YZflR6NcMyGUC6d7Q/MAJ5BAs2wOUZtqa8tPIj0
	EZTYiVZ3Ol979CPKJOsDnYN6a29g==
X-Google-Smtp-Source: AGHT+IE54KQKqh8JZBtzoIUWRZtFp1/nOgJbkQ9uIBwjkDd27BigEFGZKOYoN1VpK0a8yH5tyuBBwL72JRS6OOzAQyM=
X-Received: by 2002:a05:6820:418d:b0:5fe:9b5a:531 with SMTP id
 006d021491bc7-60282f734a0mr274299eaf.0.1743085973885; Thu, 27 Mar 2025
 07:32:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325141046.38347-1-hengqi.chen@gmail.com> <d4870294-86c2-c458-3b2d-b581afcd9fa9@loongson.cn>
 <98a786e6-4c07-c6d0-38ae-bc5c5f7eb1f2@loongson.cn>
In-Reply-To: <98a786e6-4c07-c6d0-38ae-bc5c5f7eb1f2@loongson.cn>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Thu, 27 Mar 2025 22:32:43 +0800
X-Gm-Features: AQ5f1JonN7RXX3LYUkvLNYdba23POaq4dooYdtZLKiEvKoOwASq4jD92azsCGms
Message-ID: <CAEyhmHTA55=r2VzsTvRMeoqJnX+7_S7NQW4kT1TG-JD6FyUzWA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: BPF: Don't override subprog's return value
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org, chenhuacai@kernel.org, 
	john.fastabend@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tiezhu,

On Wed, Mar 26, 2025 at 12:13=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.c=
n> wrote:
>
> On 3/26/25 00:07, Tiezhu Yang wrote:
> > On 3/25/25 22:10, Hengqi Chen wrote:
> >> The verifier test `calls: div by 0 in subprog` triggers a panic at the
> >> ld.bu instruction. The ld.bu insn is trying to load byte from memory
> >> address returned by the subprog. The subprog actually set the correct
> >> address at the a5 register (dedicated register for BPF return values).
> >> But at commit 73c359d1d356 ("LoongArch: BPF: Sign-extend return values=
")
> >> we also sign extended a5 to the a0 register (return value in LoongArch=
).
> >> For function call insn, we later propagate the a0 register back to a5
> >> register. This is right for native calls but wrong for bpf2bpf calls
> >> which expect zero-extended return value in a5 register. So only move a=
0
> >> to a5 for native calls (i.e. non-BPF_PSEUDO_CALL).
> >>
> >> Fixes: 73c359d1d356 ("LoongArch: BPF: Sign-extend return values")
> >> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> >> ---
> >>   arch/loongarch/net/bpf_jit.c | 4 +++-
> >>   1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit=
.c
> >> index a06bf89fed67..73ff1a657aa5 100644
> >> --- a/arch/loongarch/net/bpf_jit.c
> >> +++ b/arch/loongarch/net/bpf_jit.c
> >> @@ -907,7 +907,9 @@ static int build_insn(const struct bpf_insn *insn,
> >> struct jit_ctx *ctx, bool ext
> >>           move_addr(ctx, t1, func_addr);
> >>           emit_insn(ctx, jirl, LOONGARCH_GPR_RA, t1, 0);
> >> -        move_reg(ctx, regmap[BPF_REG_0], LOONGARCH_GPR_A0);
> >> +
> >> +        if (insn->src_reg !=3D BPF_PSEUDO_CALL)
> >> +            move_reg(ctx, regmap[BPF_REG_0], LOONGARCH_GPR_A0);
> >>           break;
> >>       /* tail call */
> >
> > In my opinion, it is better to give a test case and show the test
> > result without and with this change.
> >
> > The test case should be put in the commit message at least and then
> > added into tools/testing/selftests/bpf or lib/test_bpf.c if not exist.
>
> Oh, it seems that there is a test case `calls: div by 0 in subprog`, so
> it will be great to add a test case in lib/test_bpf.c to test bpf jit if
> possible.
>

Don't think this is necessary, the verifier test is well maintained and
part of the BPF CI.

Actually, I am not familiar with the test_bpf.ko :)

> Thanks,
> Tiezhu
>

