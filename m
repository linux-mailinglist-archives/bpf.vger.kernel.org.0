Return-Path: <bpf+bounces-71136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC80BE5120
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 20:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14CDA1A64CFC
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 18:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21A0233140;
	Thu, 16 Oct 2025 18:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/6wxnG4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE897223710
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 18:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760639813; cv=none; b=hVCHRxGXg4+jCMPpugzaSpglBJelFAswAvDAUEuZswZaaqRxOoEXVACFa8+d+R8hGShzkY1zdkNCI0qFYYWmW+gH/aAU5ygsw9cD3Zvb3Z4FbzRbjPVUtetrzHyKkNWKJF9LTRgWp1Uq/CGrs7/g5meq5jYP4djKdYU1neQfFHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760639813; c=relaxed/simple;
	bh=PP55H9LZCrNg+VYCTWyVw38AKk2Jp1Hs85/aDpeHSNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sdNOZBQ7KdSKDpV1TXTZNFjO/ElcRWrcpQ2zioYiF77A6y9S8m2v9DdP4vWVbAtVFXvzXhCEHSLsGBy4z2IcapYVwjKBedzA8EiBHiCUz0V4x+bRfLyJUnSnZzvwAykuAspiCHVuZQ05d9B8mCVMky7XIUEJ1rkCONeswjZQVns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/6wxnG4; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77f67ba775aso1587935b3a.3
        for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 11:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760639811; x=1761244611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RtJQczqIQEvGP+Crx1aqNJBrBvUIfZN0sKxLDUHu1NI=;
        b=I/6wxnG40sPhdBdNW1RE1KPBhaye2PxZJqM3MsDWA4+3D6d8CfzBDqWDjp7cYAvtG1
         n/L4uw9NexJPtVxMcrGoWZ+AhH4fJwrs7Pglx49PUzOAksZBNAervfFWMXP6BFHnj+LZ
         FZhAU56YwNPUuGhuplGgxwUC2DQvk0Y3+rriVxiKQ8KIkafByt7c0Rn2CnaPmLG426s/
         7cEOmOn8AmuAYmalgX0lhytQb6HfNEkI3ntqFA+b3m+Rzi57zlbMaNJ8oIWokY985kuI
         StX7otVvk9mXZ9GlZwHyE4FdFWQNclcHvSkUZJrGrXbVsmkYgnZfUF3GCTHS5YaUJH69
         +u+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760639811; x=1761244611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RtJQczqIQEvGP+Crx1aqNJBrBvUIfZN0sKxLDUHu1NI=;
        b=V8Y41dHZIG7kE+Fz8jJhkae5R5a0udynvr3AqNFyhI3L/JBAU6v98J1/6l6HyNWdtM
         n03aerFHDI23bO1efiTvrfBpMAbGTvgH95FG6bC9l4H1F2GUxVLhKBVANhGzM0m35sOR
         /stuCvNVtXg+Z4GWxZ2c8SIWvhv3aNo2TxjfjpMeldVJF8I4kFKZ6kKk65ZmgytA+QsS
         tuE4kcMbtbgGRiv/kVAdCURC8Lq1hfg5cpnFNDG78ibaapX5z++aqTzeM473Rla2qMm2
         pKqt3YEnV+fkwW16lh3vcZpiSyxFYyIq/4jRhWJfkGHHsiHzdmBcKB1bfwbE9dj/q/ar
         zChw==
X-Forwarded-Encrypted: i=1; AJvYcCXuIa3kY4+I4a/ZkGX2jEWcDxYoNNd6B/VuTxQe5BIS/UuSXS4skHP3TQ7xSJxaQohvQ1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqPK1+4eDqO8Nnr0HPEbuykC9DyVeCdI4z/F0oko5fMe5wm026
	vL21QLQ93GMe6OloxQafbQiaYoWhBF49deJg+y8TbU8SkD8H/4o67Vf6qaXJegYu1WlvvZaFk9B
	ren2LH5ivvAioC+L2vNQWsM0ZV+u/9Ig=
X-Gm-Gg: ASbGncuSy6chr7HvbT0IGs/HTIe2yh5uFgAZxF8WwZI70OekCQJ5mQcWSPsmbpnt1FB
	Z9w9nP90gVfTCcF2s/TPMEnWagsDoKAM9/5ayqK259TmyJQeAjzH2TeNcni58I3SNVfppMsXveY
	V9ovbjAwX/muLsWa7fbAdr/pwBUMG/wBHXrv2b0KWn07Nz48jl27+vzjFSWKDkMYH2tgx2wao1W
	nrO806UZT+EzqsD3GUWnUGWSwmMiJaq131bao6tQ8eisicYuKTlmMzgCdePsU/D+tMMCiDMiIaW
	wr1vhuI5+8U=
X-Google-Smtp-Source: AGHT+IED3nr4vs9SXFpVC30uCBI2pzHb9sB1NtLe93tO/bdmCrFx8j2sF9bSootwK5RX9cxM0ay+/d4UihGfMjsEL2g=
X-Received: by 2002:a05:6a21:9986:b0:320:3da8:34d7 with SMTP id
 adf61e73a8af0-334a85661b7mr1019443637.22.1760639811013; Thu, 16 Oct 2025
 11:36:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008173512.731801-1-alan.maguire@oracle.com> <20251008173512.731801-5-alan.maguire@oracle.com>
In-Reply-To: <20251008173512.731801-5-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 16 Oct 2025 11:36:36 -0700
X-Gm-Features: AS18NWANcScWPGbbZETO945HH2LCzNkjRh_D65_GOsygmo5Td9cPYFnH_hNW5ag
Message-ID: <CAEf4Bzb=B=iZgC00HY8otd2M-q_899u=ag_2WCnJ0pQjEYDZhw@mail.gmail.com>
Subject: Re: [RFC bpf-next 04/15] libbpf: Fix parsing of multi-split BTF
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com, 
	yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	qmo@kernel.org, ihor.solodrai@linux.dev, david.faust@oracle.com, 
	jose.marchesi@oracle.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 10:35=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> When creating multi-split BTF we correctly set the start string offset
> to be the size of the base string section plus the base BTF start
> string offset; the latter is needed for multi-split BTF since the
> offset is non-zero there.
>
> Unfortunately the BTF parsing case needed that logic and it was
> missed.
>
> Fixes: 4e29128a9ace ("libbpf/btf: Fix string handling to support
> multi-split BTF")
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

please send the fix separately


> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 6b06fb60d39a..62d80e8e81bf 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -1122,7 +1122,7 @@ static struct btf *btf_new(const void *data, __u32 =
size, struct btf *base_btf, b
>         if (base_btf) {
>                 btf->base_btf =3D base_btf;
>                 btf->start_id =3D btf__type_cnt(base_btf);
> -               btf->start_str_off =3D base_btf->hdr->str_len;
> +               btf->start_str_off =3D base_btf->hdr->str_len + base_btf-=
>start_str_off;
>         }
>
>         if (is_mmap) {
> --
> 2.39.3
>

