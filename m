Return-Path: <bpf+bounces-75842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9D9C9963F
	for <lists+bpf@lfdr.de>; Mon, 01 Dec 2025 23:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 387F54E265E
	for <lists+bpf@lfdr.de>; Mon,  1 Dec 2025 22:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9062D257845;
	Mon,  1 Dec 2025 22:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gl+osIRu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B8F79CF
	for <bpf@vger.kernel.org>; Mon,  1 Dec 2025 22:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764628528; cv=none; b=Y3y47/SEhBJDMOqXrh3Y00OlsT33zfEs49iY42P0qiA/Mcs/LK7cmLc2uJRkB1YHukSqh24uJOFyK50apzuE/WvrqAe6ep0snPvYoBQRtCkIKRFN6xJRRGPAn0DLeJhbSK62naZBPGZjEpJZWWV+eikFsHsjEoIfzXSOQWz2bHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764628528; c=relaxed/simple;
	bh=8IkQC367KHXKt9jqRHpAo37AqTpVy+dOriA3pr55a00=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hESzEyEX6+8E1d8hxrEoG3lxckcIPfvSmbHA8UiBVLlq+y+K9ilA9DYPTvnjbgmhMyygzHZ8ysWLdBR2Nb7G4DYEe19X2IIJctvDR3kULT3xv7jzaiwXHX7BbRo1rFbDOV7tiapeuqWmdkyDbVVRIYx8/WrHyqGzGgbb2GR4V7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gl+osIRu; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7bc248dc16aso3834138b3a.0
        for <bpf@vger.kernel.org>; Mon, 01 Dec 2025 14:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764628526; x=1765233326; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RG/4t/fc4ubpG6xGBil90eH+SR01wWnr5RTdFEazNq0=;
        b=gl+osIRu5YXJKh8/c8yO/Eo68mdUCbCYRMyPArh11q7sVQN4Eti/asxkApxSXF0uCF
         bKhO5miuWjB4P2mkBaYxOfKMBrw8/eDWa72fZ1hBhfOK2CKKTOHkW5+Yb4SwUOm3bvJ3
         3YAcnWAStnpHvoz2EhANIXqU7v4FoIlvuXflzGoOFDGGKOwgKykeLowYzZVNHe0U45zT
         8lOJHUvcRl9+Q5aX2fxRRqNLNyFQnHG8HCvE09nQ1n52+qtb2ccdkIeW1xokP32pZy1Q
         gQyR3rGI0TREZnL2GlvUPApsW/Mad8E0KR30uyqSWIwZUmKUk1BJ6hGsMvNQRazlrLAO
         0RgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764628526; x=1765233326;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RG/4t/fc4ubpG6xGBil90eH+SR01wWnr5RTdFEazNq0=;
        b=TnwwswE+7xMWbAuepZvoTbARhCd6JQ+XkXilrwieRbFixyzz1kLUJJA/82WGbITQBm
         DJcdsBlkqdUoqHAgc+0Cm+4Qhcga1tgvr1TNlwhh7kogIq/AbP3J+rWHxZ6QHgcSzJm8
         NYn8AkXI0rcCzs1K6KQdsmJaGabE9g9yfP/NhEdOBVCVFoosl9kom0TKz6uVve361HGS
         dQwMwHqL1oPm+fVyuXsJroBLNM5bTIQh8rtavC7hy04vBMyDK33inG4Y07i63QsmO0Sn
         CaZO6d6is/KGSNMidikg0D2NNOFDZ0OGcadn5JYuUWwGuhv7L8sKwZaJIEmlgQPaToYy
         9d8Q==
X-Gm-Message-State: AOJu0YxUmi+iOuWIARLMxt/NihWESgCNmJn37jZWTT+aZzr6DPHEQhvH
	ixxb1STfWJ3Hz5T8cNrQ7JSddLZCV4AuwJro+uwvmI7MSdQaA9ZkaC8c
X-Gm-Gg: ASbGncuUTa4KaQOiTnGJnvg5uxdJh8nxBImXLG5zOnw93pwMlN/pTADgPft07CyHuj2
	3kgKeBriVhvXDwuQIznxF1S/ngq9CINouwhCqTRhuLIYnE6Stwv0ymq34nVBkRtGX1itmyRHiKj
	ObRtIxk8SaLhNr1I8qzkpLTvtgABnTFNE85GBpY1pvcrkQ/VDRjfFQMoK86BSAxQ9IAB1okJcuP
	zA4ewqg5sGfki981TkVnB1VlOngPPxwx+bAZROlUPyhM1ZE4+rZFfrPoG3M0vfe41izSOK85jIT
	DWgXCpwxLlZ9QhJtFBAUesnMLVAoaC6J9/OIRKYeMOOVLBtiXtrbSYbl+8M4AIEKR+7PD2ffod8
	QDMI6vqKXAG9Z1jj+4zLkeubngwKJEtb7inOakpjzY5DrqCUnV+2p1zt9weX7RbaMdEd+v9lM+Q
	OQAwIG3tR1DTFRwPP8TrmrGr9gQ+6yyvH7nYDm
X-Google-Smtp-Source: AGHT+IEitvQMRUY55KdWwbDx43WqF44nIGk2f1Oqhi0PQjKth+ekcYkeUuwRNY6foCr8hKJPiCZBLQ==
X-Received: by 2002:a05:6a21:329b:b0:35d:d477:a7e0 with SMTP id adf61e73a8af0-3637dafc474mr29936764637.15.1764628525807;
        Mon, 01 Dec 2025 14:35:25 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:a2c1:e629:f1e2:84c8? ([2620:10d:c090:500::6:79eb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d150c5e612sm8871150b3a.6.2025.12.01.14.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 14:35:25 -0800 (PST)
Message-ID: <9a224465dc5cf8642673e633885057bb61b8fd31.camel@gmail.com>
Subject: Re: [PATCH v2 3/4] libbpf: offset global arena data into the arena
 if possible
From: Eduard Zingerman <eddyz87@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, memxor@gmail.com, andrii@kernel.org, 
	yonghong.song@linux.dev
Date: Mon, 01 Dec 2025 14:35:23 -0800
In-Reply-To: <CABFh=a6sNSrYnpmhSBjBxO9g8oLk3kY4avQ6hwoNzmX4b7aKgA@mail.gmail.com>
References: <20251118030058.162967-1-emil@etsalapatis.com>
	 <20251118030058.162967-4-emil@etsalapatis.com>
	 <ef19d394a7b4993a4f42fc063a9e33bf174f7035.camel@gmail.com>
	 <CABFh=a6sNSrYnpmhSBjBxO9g8oLk3kY4avQ6hwoNzmX4b7aKgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-12-01 at 13:34 -0500, Emil Tsalapatis wrote:

[...]

> > For (a), is there a way to move an address of first valid mmaped page
> > (from BPF perspective) w/o physically allocating the first page?
> >=20
>=20
> IIUC what you mean:
>=20
> This is what this change combined with bpf_alloc_reserve_pages() amounts =
to.
> First, we adjust all the symbol addresses into the mapping to move the ad=
dress
> out of the zero the page. Then, we call the existing bpf_alloc_reserve_pa=
ges()
> call to prevent the first page from ever being physically allocated.

libbpf.c:bpf_object__create_maps() allocates arena memory region as
follows:

  map->mmaped =3D mmap(addr: (void *)(long)map->map_extra, ...);

Where 'map_extra' comes from fill_map_from_def() / parse_btf_map_def().
The latter even provides a flag:

  map_def->parts |=3D MAP_DEF_MAP_EXTRA;

On the kernel side arena.c:arena_map_alloc() uses this 'map_extra' as
a starting arena address:

  arena->user_vm_start =3D attr->map_extra;

arena.c:arena_alloc_pages() uses 'user_vm_start' as follows:

  uaddr32 =3D (u32)(arena->user_vm_start + pgoff * PAGE_SIZE);
  ...
  return clear_lo32(val: arena->user_vm_start) + uaddr32;

Returned value is what BPF program sees as an address, right?
Is there a way to tweak arena_alloc_pages() implementation or arena
creation at libbpf side, such that arena_alloc_pages() never returns
value smaller then 16 * PAGE_SIZE?
E.g. by tweaking the attr->map_extra value in
bpf_object__create_maps() if it was not specified directly by user?

> Alternatively, if you maybe mean transparently add an offset to every
> arena address
>  in xlated/jitted code: That would also adjust the NULL pointers we're
> trying to catch
> to point to the first valid page we can allocate. In general, I don't
> think it's possible
> to do this in the verifier/JIT because this change depends on adjusting o=
nly
> the arena globals, and that is best done at load time.

For sure, it does not make sense to do it on verifier side.
It might even be impossible in general case.

