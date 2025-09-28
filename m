Return-Path: <bpf+bounces-69917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12328BA6678
	for <lists+bpf@lfdr.de>; Sun, 28 Sep 2025 04:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EE24189AB93
	for <lists+bpf@lfdr.de>; Sun, 28 Sep 2025 02:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35384248861;
	Sun, 28 Sep 2025 02:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h05QdE4J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357432EAE3
	for <bpf@vger.kernel.org>; Sun, 28 Sep 2025 02:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759027347; cv=none; b=rzo3aE/m5MxMis06rufgBFtgo1WNlg8ielATO4k3Jbg5B7I3EgnwUz/aIF0w9sq+qMH8hZlE55cO18x9v5GeQzG1q0PyEp9tl2OAyDNrvCtuVkhJ0NSkRgyxG1wF1bYd2Dn/pfYtUc7SBIamXaj12QV5bk/FAUarHuxnyl75CrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759027347; c=relaxed/simple;
	bh=Z5WQ1ttQ0w3iRgxGSLk3QKYw8pGfieOlRarpwSq/4uI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dG1S1jE9+Y1uRETQ+xUeG/cX4Y3KrGqBZiVHD/qibAnn8E9TUoDZ5a362V45oP60gkSfR2PhgDQDZXCTChiaqngJv6LVQMixkid+PSZN3uaYI+vPHr6Pf9ICgTtCP4xmLGGCRR2gFc4YlVHej+MHOUL/+JJFD+uWktVsv1JDMT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h05QdE4J; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso527674b3a.0
        for <bpf@vger.kernel.org>; Sat, 27 Sep 2025 19:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759027345; x=1759632145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKHSRf6yP1dzP+SM5CVuaBmmyKFqeYwqp6uQ3q85QjM=;
        b=h05QdE4JjDnnHi0s4OsAbvXpPAGr8kDgawJxxkkuX+QkGJTgSQuQIVMGZOYblEmFDU
         heKaoANgT9yBwdXTxhg6HygzuqIsgs+0xGyLEBicpVpfke14jh/du7IbGff+/42j60AO
         KJSWJTtbTFoKQ1riCApPEqu7Ql7kpYriAojy4X9p2AczjSIeBRRNTY4YwaGbdlNZWl49
         nl2OfTKq+NyC/0BQoqOZopAbLAE3ZtVH+EQbn6PGWPIo5uU2+qTZm1u03GQNK+Pkqa5W
         6VuuXbqBbx2w+MdphipPOrPNENTkOEUNuHIOz/oenGO1nBMsrg0eUtBVfBtjT0pvWExU
         h8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759027345; x=1759632145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKHSRf6yP1dzP+SM5CVuaBmmyKFqeYwqp6uQ3q85QjM=;
        b=b/OV+5ZEgi+3DhEzquus3y8v9nOTycMaSR+VryG5ttQzr2x8Asyj2VT9qf2BkQoRz7
         mCSl29fbFzCBgAGKBw+Mj470G4MqBZCvb3970eOP2Qnpr0Ml+2/jClzDNOdcT7ruYvRZ
         fMLqUM9T06SIlQz9aVl7owxYjWDnGBP2biLGRklIR8xzUEU34W6iSBiewmZ3BJDyaEqd
         MwfZi8ML+mHA76gqGzK6XV3WXu/kSGVCoLGXscOuIRV3SfXHHB1gB++1EHM5KAPa34AT
         ghzg1gpM40KcqUR+jiLaPWzz0ZpXSS5d2W6R+udeJspghoLsV/5ZrJp6j0D90Tdg8csV
         CcdA==
X-Gm-Message-State: AOJu0YyOhJ4X+p/3utqRu2p0tyDdxgyT5zFdR+zDcZxlRM99GeXNFndC
	04G0bOxYJGI90eOJmmTmWFFfdbi48lxoSFgFyL0JXd5HW4MpAyhX79bqslmGnwgbZyVv3CbO9pl
	JaetFnz+JKPgMBkhVmlvZWW0kBmBBc3Y=
X-Gm-Gg: ASbGncutQpoPO6Mfv0zPdPv0uAk++pklr12uCqI8d0UAAbAdMNqYntNR4lfx1Di0rSu
	ugEuF1ZSiuiAZLHN/ZOD8d7PjfGeddiIt6phc1NTAXHlOMrSMw4Xhl5B7bnR5LZQPFqlf/2U7a5
	RrfIs/uDQdHWFm3MN/Hf9Biisw1OMCo60dpQOAu1ox0hCreMOuYiiF1lyogpMGbVE4mrrc7GUVM
	NXv
X-Google-Smtp-Source: AGHT+IFmS7m83R3xeQLS9Ff1t7oT4kUIho3v9e20S3nkClJvtVlLT6dcprj4sK2kCCSi7PbZAvyvgwaNGvoRwJofLp8=
X-Received: by 2002:a17:903:3845:b0:246:2e9:daaa with SMTP id
 d9443c01a7336-27ed4a09580mr150089945ad.2.1759027345564; Sat, 27 Sep 2025
 19:42:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925153746.96154-1-leon.hwang@linux.dev> <20250925153746.96154-7-leon.hwang@linux.dev>
In-Reply-To: <20250925153746.96154-7-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sat, 27 Sep 2025 19:42:13 -0700
X-Gm-Features: AS18NWDZYAPQZRS1nH8n3z3gWZQy-mw2ZykayMEOWZD-elL6RABzFBcmOHvwdU4
Message-ID: <CAEf4BzYZhtjBbMxVxTKt2KTSiCw1RT_Li4pYC-GvcE5U4=St+g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 6/7] libbpf: Add BPF_F_CPU and BPF_F_ALL_CPUS
 flags support for percpu maps
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, jolsa@kernel.org, yonghong.song@linux.dev, 
	song@kernel.org, eddyz87@gmail.com, dxu@dxuuu.xyz, deso@posteo.net, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 8:38=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> Add libbpf support for the BPF_F_CPU flag for percpu maps by embedding th=
e
> cpu info into the high 32 bits of:
>
> 1. **flags**: bpf_map_lookup_elem_flags(), bpf_map__lookup_elem(),
>    bpf_map_update_elem() and bpf_map__update_elem()
> 2. **opts->elem_flags**: bpf_map_lookup_batch() and
>    bpf_map_update_batch()
>
> And the flag can be BPF_F_ALL_CPUS, but cannot be
> 'BPF_F_CPU | BPF_F_ALL_CPUS'.
>
> Behavior:
>
> * If the flag is BPF_F_ALL_CPUS, the update is applied across all CPUs.
> * If the flag is BPF_F_CPU, it updates value only to the specified CPU.
> * If the flag is BPF_F_CPU, lookup value only from the specified CPU.
> * lookup does not support BPF_F_ALL_CPUS.
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/lib/bpf/bpf.h    |  8 ++++++++
>  tools/lib/bpf/libbpf.c | 26 ++++++++++++++++++++------
>  tools/lib/bpf/libbpf.h | 21 ++++++++-------------
>  3 files changed, 36 insertions(+), 19 deletions(-)
>

[...]

> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 5118d0a90e243..8c06a5cb7569f 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1196,12 +1196,13 @@ LIBBPF_API struct bpf_map *bpf_map__inner_map(str=
uct bpf_map *map);
>   * @param key_sz size in bytes of key data, needs to match BPF map defin=
ition's **key_size**
>   * @param value pointer to memory in which looked up value will be store=
d
>   * @param value_sz size in byte of value data memory; it has to match BP=
F map
> - * definition's **value_size**. For per-CPU BPF maps value size has to b=
e
> - * a product of BPF map value size and number of possible CPUs in the sy=
stem
> - * (could be fetched with **libbpf_num_possible_cpus()**). Note also tha=
t for
> - * per-CPU values value size has to be aligned up to closest 8 bytes for
> - * alignment reasons, so expected size is: `round_up(value_size, 8)
> - * * libbpf_num_possible_cpus()`.
> + * definition's **value_size**. For per-CPU BPF maps, value size can be
> + * `round_up(value_size, 8)` if either **BPF_F_CPU** or **BPF_F_ALL_CPUS=
** is

please update, it's not round_up(), as we decided earlier


> + * specified in **flags**, otherwise a product of BPF map value size and=
 number
> + * of possible CPUs in the system (could be fetched with
> + * **libbpf_num_possible_cpus()**). Note also that for per-CPU values va=
lue
> + * size has to be aligned up to closest 8 bytes, so expected size is:
> + * `round_up(value_size, 8) * libbpf_num_possible_cpus()`.
>   * @flags extra flags passed to kernel for this operation
>   * @return 0, on success; negative error, otherwise
>   *
> @@ -1219,13 +1220,7 @@ LIBBPF_API int bpf_map__lookup_elem(const struct b=
pf_map *map,
>   * @param key pointer to memory containing bytes of the key
>   * @param key_sz size in bytes of key data, needs to match BPF map defin=
ition's **key_size**
>   * @param value pointer to memory containing bytes of the value
> - * @param value_sz size in byte of value data memory; it has to match BP=
F map
> - * definition's **value_size**. For per-CPU BPF maps value size has to b=
e
> - * a product of BPF map value size and number of possible CPUs in the sy=
stem
> - * (could be fetched with **libbpf_num_possible_cpus()**). Note also tha=
t for
> - * per-CPU values value size has to be aligned up to closest 8 bytes for
> - * alignment reasons, so expected size is: `round_up(value_size, 8)
> - * * libbpf_num_possible_cpus()`.
> + * @param value_sz refer to **bpf_map__lookup_elem**'s description.'
>   * @flags extra flags passed to kernel for this operation
>   * @return 0, on success; negative error, otherwise
>   *
> --
> 2.50.1
>

