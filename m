Return-Path: <bpf+bounces-13854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 152637DE82E
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 23:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9E3BB210FF
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 22:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7D813FEC;
	Wed,  1 Nov 2023 22:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQMV7B3X"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4598F6ABA
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 22:40:16 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8475119
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 15:40:14 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9d2e7726d5bso48865866b.0
        for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 15:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698878413; x=1699483213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exYEuRCmmUBEd+Uu6+GD6+fTpg2Qm2D3TEV+N4MHgKs=;
        b=LQMV7B3Xx4pIiRVsT1d+7wMgUBWt553hmzFf/QhAogtEISqDEDRhdRisjyGDRc4qk2
         g23hnxKNRbt6/N/BEypozEwbTSFwWD9gvuRYv45y3zo3k+W0thEgjgJEBEHwf5oyiKDE
         xC9CDKUGQPfByUZaPt5QNoR7Uo3xW0vXTr5+wDZP+rfiEWJZx5uM+0xCbcXOYWqs6W9V
         cckXKvEl43AK9BgkwbWfeyydhA2Ajf+QxCnJoypbiCEtm88acEAVxThOVqPkMFdmzXJE
         FzzJypyaLYftDfvkUZoY8LFD8WQzkLPWszArdmU0NGRntjMpXbhQFoLG1CIbGVIIAgNI
         s9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698878413; x=1699483213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exYEuRCmmUBEd+Uu6+GD6+fTpg2Qm2D3TEV+N4MHgKs=;
        b=H9RrTbG4LlV1PiX2uQ379XJhP88ouWfmRii17Ym4bG9VcPO+WUKKKhxZW5fbJ3ObWM
         4Zzj/NX9oS5s0izGE3c8yTMg1Rylg4To9nj94YhB519l91QIapA4PJP8NoOi4M0evZ4t
         rvuYOvFUDAetn77fFzDmCkCVudHu1rX0TyP4+c3vpdylRY4ALTwgWslpYQr+BDwP5Or7
         64ABlZNBR2tcc3K4Lc9MEgKj/0/5TLOiyUjMpps0XiQWQyzmj2xbXfTrP7s9nvTYSf/j
         /0q7aE5vVbe0aNzvxPUE0JI47xWsxvuBhNU2EmLoxF0VK6124dgmh2/0ZAto0KYiViot
         bGAg==
X-Gm-Message-State: AOJu0Yx1cqu8gAGFABOp7+QH3zta1mofCYGOBI6fzKwutOU0ZJ49PTSS
	aYBuoVUy6olfxyYFFD8VYaBEC2SaZIutP1iQpXo=
X-Google-Smtp-Source: AGHT+IGDxDKpOj8Lnqprj+C12A8mBbnhS2fCCq5sE/oPrtQNEcHY5o1uPVn3pOS37KgA53OMlkQ8/9WKS3NFzvHPZ+0=
X-Received: by 2002:a17:907:1b02:b0:9ae:82b4:e309 with SMTP id
 mp2-20020a1709071b0200b009ae82b4e309mr3204158ejc.0.1698878413299; Wed, 01 Nov
 2023 15:40:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN+4W8i=7Wv2VwvWZGhX_mc8E7EST10X_Z5XGBmq=WckusG_fw@mail.gmail.com>
 <CAEf4BzZCjTsWhcmQz08QB4mirfgG0ea6bYJX2RgKirwFxAO+3g@mail.gmail.com> <CAN+4W8gKa=wRegmvnr_DTCJjrr5EM6nVws0Mf7Ksto3ZzZroQA@mail.gmail.com>
In-Reply-To: <CAN+4W8gKa=wRegmvnr_DTCJjrr5EM6nVws0Mf7Ksto3ZzZroQA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 Nov 2023 15:40:01 -0700
Message-ID: <CAEf4BzY1QZEKSthdG8N_Cs7jdxM-S9gnLZfOfp+s636ORyoUcQ@mail.gmail.com>
Subject: Re: BTF_TYPE_ID_LOCAL off by one?
To: Lorenz Bauer <lorenz.bauer@isovalent.com>
Cc: Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 1, 2023 at 2:27=E2=80=AFAM Lorenz Bauer <lorenz.bauer@isovalent=
.com> wrote:
>
> On Tue, Oct 31, 2023 at 6:38=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > I don't remember if this is intention or not, but the main part is
> > adjusting CO-RE relocation, the actual instruction value is less
> > important. But this is happening after static linking, because BTF is
> > deduplicated (there is a duplication in BTF generated by Clang).
>
> Ah I see! And the deduplication is done by libbpf during linking? So

yes

> far, we've been validating that the instruction immediate matches what
> is in ext_infos. Should I just stop doing that?

probably, because I just checked libbpf's linker code, I don't think
we adjust instructions that have CO-RE relocations. We might probably
add that, but it's basically just BTF_TYPE_ID_LOCAL that would need
this special handling. If someone sends the patch I'll accept it :)

>
> > There are at least two identical prototypes (which is strange and
> > might be worth looking into from Clang side).
>
> That would be good!

Agreed, maybe Yonghong or Eduard can take a look when they get time?

