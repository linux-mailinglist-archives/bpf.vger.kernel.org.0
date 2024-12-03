Return-Path: <bpf+bounces-46031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D449E2E10
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 22:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87BE1162541
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 21:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4031209678;
	Tue,  3 Dec 2024 21:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4HgcnDP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3828208997
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 21:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733261182; cv=none; b=uY0p5ZdLh+a4VgEhA3ROhR6DUS2j/zEp9gMtcUm4lXQQZfUjLAgB9bTKlTVAx+jsKNSMksA+I8Hu5Gi0GEpLDpbj70Fg1LuVsFLosvrsvJQtGuXiCZ4BNoMTH0KB+aubPTrURdrXRWPBXMe1CZ6AgOBgnnNzCbeNBvPkx6RXWfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733261182; c=relaxed/simple;
	bh=a0vsYIiVBdDCfGHPhT+CIkU9Hqu4UU+Z2S1fwIWLvak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CRyq2gwJNoWsd63MVGtGjcF7gMgdZMmGkz/4j1Z2LaPR+mrvN5nGmVRXg2QPsAteYp/mlwCfG9mnYOUEs4B0j1mGHNK6WQFoK29XIMPdfmrKIp2XsCzHeeRs36Vxabii04b/E+m+v39psxWchYK+OtdU7pmDyJ3DrEgGAPuSZsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4HgcnDP; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ee8e8e29f6so2826822a91.0
        for <bpf@vger.kernel.org>; Tue, 03 Dec 2024 13:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733261180; x=1733865980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnQp30UlXT4Tjbpr/hSFAPm5PkzTkR0roAAM5qXI+NQ=;
        b=m4HgcnDPHoK7tiTHDiGitmsC8WyORWC4CO8mrHQfhjQI+febvbY3K2V6lJbQel77zr
         gpsibKS72h/20L2M0AJCHd7NJiiWr+NpuCXWOIa+seJxkzHlUPSxcjnfsofthVQwlL69
         2fvMBnH9rexais1ayaTChXgGey2B3f41rAu2q0eoDTG2MbCdLEPHNE2fENIMBoRv/Qsd
         Vz+jlfyfcBqWzzCqFcO0EXL1q7QXzwOYzmqN9NcG60nrnxP64j/L5hqblVr7v81hh2PO
         cxyXjPVqIwfcN5imN7tODtGHwo1+By+pyM7HyvJwxp3O/7RLzLKwM0qzmhgnVo8pWkoD
         varg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733261180; x=1733865980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XnQp30UlXT4Tjbpr/hSFAPm5PkzTkR0roAAM5qXI+NQ=;
        b=iZiq7oEJJP8K2FGoybwdEAkO0JF9xTZY1iabmDzWRlKaoSHpjUtaYN1rvPmcBT+dxb
         N8SbbLmFkM9Ne7eM4hS5gQ4doOTgKZYg+mF8BebWke+x/EvyUSq486IVp+BDqyrTQTGb
         k+hKKAWeuAyPKTd2i7oqs66w4c5iHG8m8sYn+8Y8XJ0whjuEPsSFN0Q5G6PuUDdfA1Ob
         MJ+6iOMKRz05+zrRU2Rw0PDRcn5I5WuMwEs7/Un+CLEO5CgcLvnfVw11Xl9knPaAIXPw
         k8dGEeEyONa37tfR6+ehwDHp1f4kcUZiabZUk8QLwuGPeWxDsuMAXqjuKVdvAd47AYn7
         zqsQ==
X-Gm-Message-State: AOJu0YzMoZjJIJcYkCL/qu+/mV5F1lIQW3djT0/Y85zQcix/lmvTvjzW
	H8BWWdA3yrrgLLXp0e7l8ehCldtXIOHd6ecnczmdBIZF1bZ77QgGrXEyrmyJLV/eHnm6Y2kvjCO
	QDtpBdqndFXMleSPsdYFd0msSsbRf+g==
X-Gm-Gg: ASbGnctbNpaXwIRnovF/lYmG2zqh7gd5493b7V27hFq6AkwNw9tTXOAttNvKFZPTyHX
	RVlHA8wB9YWBNd4qiHvQQErxb3bgm3GHgPw2VOTmzUn2lE+Y=
X-Google-Smtp-Source: AGHT+IF7lA6b2UUQPbYdXgyydlg+nkTdJiR0zbKkSU/RYZ3/14mB8Ks+iTC8T3gJPWlH7F0bSxoZweANfneJCOOBpR8=
X-Received: by 2002:a17:90b:3907:b0:2ee:fc08:1bc1 with SMTP id
 98e67ed59e1d1-2ef01275b48mr5735728a91.37.1733261180051; Tue, 03 Dec 2024
 13:26:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203135052.3380721-1-aspsk@isovalent.com> <20241203135052.3380721-7-aspsk@isovalent.com>
In-Reply-To: <20241203135052.3380721-7-aspsk@isovalent.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 3 Dec 2024 13:26:04 -0800
Message-ID: <CAEf4BzZmNK6FXj9aUnqUj3fVYyp=ne2X3uodZHnarrP_CbJMKw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 6/7] bpf: fix potential error return
To: Anton Protopopov <aspsk@isovalent.com>
Cc: bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 5:49=E2=80=AFAM Anton Protopopov <aspsk@isovalent.co=
m> wrote:
>
> The bpf_remove_insns() function returns WARN_ON_ONCE(error), where
> error is a result of bpf_adj_branches(), and thus should be always 0
> However, if for any reason it is not 0, then it will be converted to
> boolean by WARN_ON_ONCE and returned to user space as 1, not an actual
> error value. Fix this by returning the original err after the WARN check.
>
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/bpf/core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>

Looks irrelevant to the patch set and probably should go through the
bpf tree? I'll leave it up to Alexei to decide, though.

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index a2327c4fdc8b..8b9711e6da6c 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -539,6 +539,8 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_pro=
g *prog, u32 off,
>
>  int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt)
>  {
> +       int err;
> +
>         /* Branch offsets can't overflow when program is shrinking, no ne=
ed
>          * to call bpf_adj_branches(..., true) here
>          */
> @@ -546,7 +548,9 @@ int bpf_remove_insns(struct bpf_prog *prog, u32 off, =
u32 cnt)
>                 sizeof(struct bpf_insn) * (prog->len - off - cnt));
>         prog->len -=3D cnt;
>
> -       return WARN_ON_ONCE(bpf_adj_branches(prog, off, off + cnt, off, f=
alse));
> +       err =3D bpf_adj_branches(prog, off, off + cnt, off, false);
> +       WARN_ON_ONCE(err);
> +       return err;
>  }
>
>  static void bpf_prog_kallsyms_del_subprogs(struct bpf_prog *fp)
> --
> 2.34.1
>
>

