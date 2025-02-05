Return-Path: <bpf+bounces-50565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5766EA29BD2
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 22:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23286188800D
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 21:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C03B214A8E;
	Wed,  5 Feb 2025 21:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1KI0BKU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B25D1FECAC
	for <bpf@vger.kernel.org>; Wed,  5 Feb 2025 21:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738790579; cv=none; b=K/KgHDaWvoohyFL+eMvEevVs17IP3DgW0qqx9z1YWBUMhRxH2hCHlPWyEYTZV4GyM+tVNL624Q/qESq1dLXfBQwxHL7Y4tJpVjDxp4Lcf5Z1kInMy6fr8g9Mx6PiwGjdf5ILpZiaJTn6ZhdYVfRD/rI2xyQZJ+a8T1SR8Y5hpBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738790579; c=relaxed/simple;
	bh=Zh8cop7rgRMwSvQV+SwcdE/N8MrzAsAM5zcvhuTxrYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PkdmNsfic8JJ9Jd2AFbhpnDQWRyVx1WpBRsbmZuh9ZI+eHfw2G1ETjtkcOCUVWGmwWxxOlezliwn/WkR3UcPZiqRcSVware58AEdPfnfogD6JGcld5gZwtaDN3MaJsvFyrq41kGmHZWaAxSRnIR+u8YjhHqmCxAS6KeeYg9hYk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1KI0BKU; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f2cfd821eso4681995ad.3
        for <bpf@vger.kernel.org>; Wed, 05 Feb 2025 13:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738790577; x=1739395377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8Ngnhv/F5+lmvZVwYv4fDUuEdpIFvkuCzIcZ+dy/f8=;
        b=f1KI0BKUEZ1ZA5D4Ym/wUyUABn7yZPq35YqGqOsONFediUw6Ry7eIYN3Ab0zdUs+5k
         5RMIV43aPJ7jBvg7U+Xt1Y6SZCtg5KsmZzEyYfxYLiqSva3mqdVWUvbMd5ndRqHn4sav
         R7IQGyyV9ARrNzb9jXuS5rkG4xOo5gI4bCRHzxi0RcFeKZvHm8E9ssCLboYMS0kMxtch
         8BtiqcY1n8/QJYqLNLaTvw1kX8C9R812Yys2BfjruSwjrDRUXiRipGDIQ8y7GoZrT5W1
         12Npxtrs8eYH7Kod1XyUURMzWqTw2FtmtffJ9Bmu1a12gelo4iYmJEvGucsFdJYtfOhn
         N+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738790577; x=1739395377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8Ngnhv/F5+lmvZVwYv4fDUuEdpIFvkuCzIcZ+dy/f8=;
        b=NZFe2GWk0ASRfCHJeEc1GFIGdLFW/FH2RpkwX08Wtbo/gKspPL45tO1oxC7mPO16+t
         +Fe3nAfh1kZv7f7CBxicBAfcWcYRabOcNdJ9ZrBpJ3CSq5UDtTYiGLddZoY2ImKt5wUH
         m6OXm1mrCiqAVqZV4T5Eca16mltb9LYWuWaRAk1weiPM5htu48SqpK3cOOjzzg/pcRHn
         JFTUhE6T6m/osPj1td71s4ptRpxhCaT8CkTaozo4r+R7hHxFuMdB2wx8wdD7NL69QiMa
         zA8waXoRMfmTna1dOqnPGyx4+ELvBvUuKkrTzDxaQ2FPz4f+d3ui7ZFnde2vzJS2FG+n
         wETw==
X-Gm-Message-State: AOJu0Yx7vPbfg2/ZxmR7l4NhDBnnpTWBVUj9PPL5FhX5ovGmoI2Y5Ie6
	5HSDOpvI19k+696Q5y4Jl6IZJqKoaqDkHO6qUpTIKBRM5o2wjgqY/ciHO+vbpogNhdUHTjXwI10
	7MSJjJ8mVlqCsM5odcib+fsX0NZU=
X-Gm-Gg: ASbGncttgqnFAu1Cfj4jUC/A16Dk6mQkpFUC3R2SCQdcs511fE/kwODXpX8Pt0PuqDC
	RTd+XhxWK/9X0HC4yugUPXduHClgFyCiptXR1/ICKNOzmjwmIJ556WKVfcnzcdyWpi9ZxPKE7+E
	TgLmoRCg00dCVh
X-Google-Smtp-Source: AGHT+IHrCzxBW8qFWLP8b4IkoGVkWitjsIjydVHQT/5p3BmoEJJ7Syn2vIpcggAH4/AFnXTC+THyPANnPKZIaQ6WGEQ=
X-Received: by 2002:a05:6a20:9e4c:b0:1d9:2b51:3ccd with SMTP id
 adf61e73a8af0-1ede88105c0mr8611007637.7.1738790577190; Wed, 05 Feb 2025
 13:22:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205190918.2288389-1-bboscaccy@linux.microsoft.com> <20250205190918.2288389-2-bboscaccy@linux.microsoft.com>
In-Reply-To: <20250205190918.2288389-2-bboscaccy@linux.microsoft.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 5 Feb 2025 13:22:43 -0800
X-Gm-Features: AWEUYZlV_rtteDNUynGjDSUK73BNJXf5tDCsOTKdazaCWeAg3IROo9W2z5gLyzA
Message-ID: <CAEf4BzZQUPfA8UcW1Ed9jM0J8z+yGHe=kOM5BwEBuDzJL3B1HA@mail.gmail.com>
Subject: Re: [PATCH 1/1] libbpf: Convert ELF notes into read-only maps
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: bpf@vger.kernel.org, kapron@google.com, teknoraver@meta.com, 
	roberto.sassu@huawei.com, paul@paul-moore.com, code@tyhicks.com, 
	xiyou.wangcong@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 11:09=E2=80=AFAM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> Add a flexible mechanism, using existing ELF constructs, to attach
> additional metadata to BPF programs for possible use by BPF
> gatekeepers and skeletons.
>
> During object file parsing, note sections are no longer skipped and
> now treated as read-only data. During libbpf-based loading or skeleton
> generation, those sections are then transformed into read-only maps
> which are subsequently passed into the kernel.

We already have this mechanism, it's .rodata (and
.rodata.<customname>) section(s). Adding .note sections as BPF maps
make no sense to me. Just piggy-back on .rodata for storing any
necessary metadata.

pw-bot: cr

>
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> ---
>  tools/bpf/bpftool/gen.c | 4 ++--
>  tools/lib/bpf/libbpf.c  | 6 ++++++
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 5a4d3240689ed..311d6a3f1c4bb 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -92,7 +92,7 @@ static void get_header_guard(char *guard, const char *o=
bj_name, const char *suff
>
>  static bool get_map_ident(const struct bpf_map *map, char *buf, size_t b=
uf_sz)
>  {
> -       static const char *sfxs[] =3D { ".data", ".rodata", ".bss", ".kco=
nfig" };
> +       static const char *sfxs[] =3D { ".data", ".rodata", ".bss", ".kco=
nfig", ".note" };
>         const char *name =3D bpf_map__name(map);
>         int i, n;
>
> @@ -117,7 +117,7 @@ static bool get_map_ident(const struct bpf_map *map, =
char *buf, size_t buf_sz)
>
>  static bool get_datasec_ident(const char *sec_name, char *buf, size_t bu=
f_sz)
>  {
> -       static const char *pfxs[] =3D { ".data", ".rodata", ".bss", ".kco=
nfig" };
> +       static const char *pfxs[] =3D { ".data", ".rodata", ".bss", ".kco=
nfig", ".note" };
>         int i, n;
>
>         /* recognize hard coded LLVM section name */
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 194809da51725..be6af0fece040 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -523,6 +523,7 @@ struct bpf_struct_ops {
>  #define STRUCT_OPS_SEC ".struct_ops"
>  #define STRUCT_OPS_LINK_SEC ".struct_ops.link"
>  #define ARENA_SEC ".addr_space.1"
> +#define NOTE_SEC ".note"
>
>  enum libbpf_map_type {
>         LIBBPF_MAP_UNSPEC,
> @@ -3977,6 +3978,11 @@ static int bpf_object__elf_collect(struct bpf_obje=
ct *obj)
>                         sec_desc->sec_type =3D SEC_BSS;
>                         sec_desc->shdr =3D sh;
>                         sec_desc->data =3D data;
> +               } else if (sh->sh_type =3D=3D SHT_NOTE && (strcmp(name, N=
OTE_SEC) =3D=3D 0 ||
> +                                                      str_has_pfx(name, =
NOTE_SEC "."))) {
> +                       sec_desc->sec_type =3D SEC_RODATA;
> +                       sec_desc->shdr =3D sh;
> +                       sec_desc->data =3D data;
>                 } else {
>                         pr_info("elf: skipping section(%d) %s (size %zu)\=
n", idx, name,
>                                 (size_t)sh->sh_size);
> --
> 2.48.1
>

