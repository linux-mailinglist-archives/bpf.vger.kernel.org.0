Return-Path: <bpf+bounces-40508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 966A198966E
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 19:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B46DF1C215B4
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 17:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038061822E5;
	Sun, 29 Sep 2024 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDX06bc1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA531822F8;
	Sun, 29 Sep 2024 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727629556; cv=none; b=Hkl054YU57JKPY7FNuoKExpMsr9qZ4CwSX/Kxms8GkLI3EciNYqVG1x753VCqgZ7CiOcrHIQ/yiZzoPjZ+WfYsH1BsXApU7/cUODhQHyS2aszENb3Jg82SPZaP+UWY0OLDhb4EbeYvGFUlxqDrL1cPyWUjgGAK0gC3g8zl53mnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727629556; c=relaxed/simple;
	bh=/gsm/eT+uw5Tn2GnAkK529lCZKXkzR4xRuYAWKooRNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5S14pYBF8s2Ce4c6W6V3jGStUDYfIybMP6txWpBf9U4C3i/sdVA5zPRCCiKeEbr5j8+W9fJct1URhHVrdol/NlRa+N4Vhy1b5/pXRjbeYvlAZAxzO2CQ2OiG2AIlXrKQVMQrKZoopcWNK3QcnPUYbFGJLaPaCcGaF2AuhuZVoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDX06bc1; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37cc60c9838so2022622f8f.1;
        Sun, 29 Sep 2024 10:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727629553; x=1728234353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PsHkwE+x8JT3hBupvf6LiFN5ijzuGAyqnqGRf6VWvU=;
        b=XDX06bc1gGdGm7bRQGk5rqIgILgtzJ2JJVCRjtjB6SLcYJ/4Q1vXlostW7zBDkBwUd
         ipJ00i0CdR4Vqb3OUosGnoIrUVPJN3XIFGoj1N8ki/xwgztZvU0lfznmUEAzqTEtoxsM
         lRugKD1VxAx+KsCP8v2eXdKrO5lEDgPpQeaiQYj/UOiSbQHi1+rlc3q4Xx/TxoBmsgfu
         Sb/Qr+ZEAjQfDHR0VIl81rK3Q/ceXiKWSXQ7d0HW2udetBlftqZ285WS+2HR6IFBRDGC
         KhDzstnFuIBMeOVVxU1LkEc0xCZQ5tGnLS1aq/HNQPbq4mIZ0FeYAjalX8kbl/2mF6s6
         8s0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727629553; x=1728234353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PsHkwE+x8JT3hBupvf6LiFN5ijzuGAyqnqGRf6VWvU=;
        b=k5YVLoh4WKc61CRc32/YEZRAIm2rsU6LrkW0kNYOANyBm6UHAKYB3k+iQhybbV1uI0
         8E44OCJ0EG/y2ZDXzxUqCL2UgM2vr/+646dq6M+ejPZz0MRc7XUhb/KSXERH6WST6TYy
         ITgOhrIyMYketkGzw3zsPUbk6Q1Fko8MjodWRFWP2iNYjQQpgeRyJasYqKf6I0hinTIk
         CASwChqQ8XVXwOk7eYn2TlJK/Hmoa3D5vuRrHEunCA0fQ0Z06HLTMRtgoEcZxnE5HIB5
         7G/nA4Ozg2hA75TqKW2mfDA+YTnUcX5boAF1hYzBofgx/g5svuU+QjuD1hSeF7sN8dHe
         K7vg==
X-Forwarded-Encrypted: i=1; AJvYcCUTNCIv3WA69PRoSGhVEm0e5ox1w7JWCgn68JmPVYr6bBPIw/ey1dYzqBn+PXokk2sv+RY=@vger.kernel.org, AJvYcCWpGd9J76ReDuFgZiEpk1tn0X8yLG7jsz8/x4n1c3l/0IZrOFmpq5I8JSQQ0ex1blojiHGeG4HmrYoddVBs@vger.kernel.org
X-Gm-Message-State: AOJu0YxYos5taYlMdOuZ4aFHsPrlaBQBds1Fb7hCT9bT+YpjqIAeuHwm
	WQAOs1zdIWl3ABDDl6iQlRnhTzheDMnjddJPfVRztkwRWWJzpHwlK1ty+NWPeUNK8n8T5oyDvNz
	H/QaxR4bc139zdpWPDHfeCnO2MIM=
X-Google-Smtp-Source: AGHT+IESQkCDQhwIOQ4tXcV3G5KgKbaYNyktnM/EGy/mvt5yRg16rArBeOUpxIDXvQqHh8wX8aNiB1bjlpRWUW4nbko=
X-Received: by 2002:adf:fa43:0:b0:37c:ca20:52a with SMTP id
 ffacd0b85a97d-37cd568bc9bmr5832448f8f.8.1727629553206; Sun, 29 Sep 2024
 10:05:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927184133.968283-1-namhyung@kernel.org> <20240927184133.968283-3-namhyung@kernel.org>
In-Reply-To: <20240927184133.968283-3-namhyung@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 29 Sep 2024 10:05:42 -0700
Message-ID: <CAADnVQKuR2-My5jYevwQS4K6QmOQVyfK3MYFngWMrc62ZET4ZA@mail.gmail.com>
Subject: Re: [RFC/PATCH bpf-next 2/3] mm/bpf: Add bpf_get_kmem_cache() kfunc
To: Namhyung Kim <namhyung@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	linux-mm <linux-mm@kvack.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 11:41=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> +__bpf_kfunc struct kmem_cache *bpf_get_kmem_cache(u64 addr)
> +{
> +       struct slab *slab;
> +
> +       slab =3D virt_to_slab((void *)(long)addr);
> +       return slab ? slab->slab_cache : NULL;
> +}

I think this needs more safety guards on 'addr'.
It needs to check the valid range of 'addr' before doing virt_to_slab.

