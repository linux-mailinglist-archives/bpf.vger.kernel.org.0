Return-Path: <bpf+bounces-72511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041DCC13FFC
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 11:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B38364273A4
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 10:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD9C301010;
	Tue, 28 Oct 2025 10:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWl1sLDr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0826C3002AA
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 10:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761645853; cv=none; b=tHKDUmY0vKU7h9xpo6yN+ylhwoWszcXRkTgfspJhOcCF0ST1ozRcbZHouYQahBiuuapLjNNUAKBXg/8mVj1XpdkNbXqyjLLJM3+P4cUlI2xRXCZvEEsJGc2HOzdituV11tRRu7Lo76hvP1E6aRMHGtpCw5ttbVa6svPvgeXdUp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761645853; c=relaxed/simple;
	bh=q+bQHLq1w05QJgsVJSwn9RhCFh+XKlZTZ84fCq8xA6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azdpG7Kt8VDBlMUiDQBaidqZlQTyS2jkfzV9Nt0I/1M3bi7nC3XSzlQ04Mb4pPpihcyQBghGDzXzZ9NRej8XNovtBx6R/eHVb0YpU9ETAz1xulBwgui5R/03ZCKaKaS4WMJucKs457cP9bCnZ5jQnB9pLi7RHZAdyIXrmWxfGRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWl1sLDr; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ee12807d97so5170908f8f.0
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 03:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761645849; x=1762250649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=080zHev5qUrFq45pSte8Iy1xCxPxrDjsYw0VGQCApp0=;
        b=nWl1sLDr1Jo3/sm5O7ir/nSTtzm6KH3PTi7VFPb1xzxmXfbihKRmRDi7sz5Gk12ZJ+
         HCVB5DvMhabUW+FbrlKutShbqrvV5E/XRHW8XlLAZPnY+q8njeKY6+9HEYqxd8k+d9CE
         X0pQWR3sDMnUkgWT0Glq2y/6PlbJ4erbnv0Y13IMDBE8psyGes2RVOyRXoel4thoOnfS
         MeHWbt8vEvDIaxn5ApdLhOQOUdPSPGhKLeMJ02XbvStUv1GdvE261FYMrv09/9q29AFI
         sQUAEdVLW8f+HqoOndNe5GgwplWjpet3caEFGVoozmqqwMeBkhtYs3U0BbWsZOT+FvMT
         GPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761645849; x=1762250649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=080zHev5qUrFq45pSte8Iy1xCxPxrDjsYw0VGQCApp0=;
        b=jCWfzF3bttcYw/CTx8tbRzXkPZW7gCW3dZn+4lYa8VCoRk/ohA1pTRJLizMMsHVJLX
         SpNVKLX5Dn5TNomXHwM/cseP8TMed3Zit1k9w6O1eJBZS+GxGOxQX22LFmYHILLWDiSd
         hVQe5M7pY57aprrEBkMavTn/TidMrdiqXeXckdWctoILbPhqgkYjJwyn2jM6jdxHgQyU
         xJKqVicC4n6hhnNKhb47/HZaXXO2yyR14izUykoTAQJ4C52HXjYEUav71I43J5a4abPd
         97ckbzIXjxI8JU4RPleZWXnBUtfPWY5YiZ9L+ZzKwrlDClGbA/6wIep/o9OLn+ZIzbxD
         xmIQ==
X-Gm-Message-State: AOJu0YwYGtX8f+dr8kIzc1bXxwB8uK8rFQ6+ChtHz7a/eb//6Z/5adrI
	R4QvPMwSdWATJNiQK+8dFhBjgxojUuWi/vlhLwPcgfoQzFVMJMaxmYJX
X-Gm-Gg: ASbGnctf04TEXMsYX6vZChN+4eOQ6uHfuHL1X6kMhkH8IdK40shPHgbZAdMwTFGztZq
	kIq5rko1fMXjMahUX6F+eE7ivKsHSbLarExKCtU/2v4wdwHl0hVr4kdpcKe6djyGUrjgflDAK0L
	46ZuT04falk0LTmciRmwjG1BbABGGLmYZrqVANWLeMEWZJGDhL5Q0ZDBA/ksO8iXHAztH6hah2y
	vhds9lnu1r0ZluddQuJKVfWPqEkwyCKbY627qKF58O1/ws11125AXuS+qLzWoOwtDbKltrQdOBY
	uP9TdqgC/5lJ5guSKHZSw2gmDUaazG7eFiS6Gf4V2fKLr1mmypah1Thh0XsZO9WersVVIZ7f/R/
	nmSaNFlPqR/p1Zcq59JkyOeN3eQ8q0/9dNZd9R957Hz/W8hJPheKmYPnPNx37Rg6SPOaHRgDNar
	GlkbCQBMLtjA==
X-Google-Smtp-Source: AGHT+IHbSkxFN4nUNyPxjSujGJd3gofxNH2jp1qQlNH4k8BlgFpgAv8aN++SpavnmL3Yf1iz99IApw==
X-Received: by 2002:a05:6000:25c5:b0:427:79f:dcd8 with SMTP id ffacd0b85a97d-429a7e96c1cmr2186495f8f.55.1761645849047;
        Tue, 28 Oct 2025 03:04:09 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7b6fsm19540045f8f.1.2025.10.28.03.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 03:04:08 -0700 (PDT)
Date: Tue, 28 Oct 2025 10:10:44 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v7 bpf-next 01/12] bpf, x86: add new map type:
 instructions array
Message-ID: <aQCWpEY6lF7x1aYp@mail.gmail.com>
References: <20251026192709.1964787-1-a.s.protopopov@gmail.com>
 <20251026192709.1964787-2-a.s.protopopov@gmail.com>
 <d2c4c93fcc4d7d6c8faef63e918ba4e625ae7b03.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2c4c93fcc4d7d6c8faef63e918ba4e625ae7b03.camel@gmail.com>

On 25/10/27 02:44PM, Eduard Zingerman wrote:
> On Sun, 2025-10-26 at 19:26 +0000, Anton Protopopov wrote:
> 
> [...]
> 
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index d4c93d9e73e4..d8ee0c4d9af8 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -3648,6 +3648,22 @@ struct x64_jit_data {
> >  	struct jit_context ctx;
> >  };
> >  
> > +struct insn_ptrs_data {
> > +	int *addrs;
> > +	u8 *image;
> > +};
> > +
> > +static void update_insn_ptr(void *jit_priv, u32 xlated_off, u32 *jitted_off, long *ip)
> > +{
> > +	struct insn_ptrs_data *data = jit_priv;
> > +
> > +	if (!data->addrs || !data->image || !jitted_off || !ip)
> > +		return;
> > +
> > +	*jitted_off = data->addrs[xlated_off];
> > +	*ip = (long)(data->image + *jitted_off);
> > +}
> > +
> >  #define MAX_PASSES 20
> >  #define PADDING_PASSES (MAX_PASSES - 5)
> >  
> > @@ -3658,6 +3674,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
> >  	struct bpf_prog *tmp, *orig_prog = prog;
> >  	void __percpu *priv_stack_ptr = NULL;
> >  	struct x64_jit_data *jit_data;
> > +	struct insn_ptrs_data insn_ptrs_data;
> >  	int priv_stack_alloc_sz;
> >  	int proglen, oldproglen = 0;
> >  	struct jit_context ctx = {};
> > @@ -3827,6 +3844,12 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
> >  			jit_data->header = header;
> >  			jit_data->rw_header = rw_header;
> >  		}
> > +
> > +		/* jit_data may not contain proper info, copy the required fields */
> > +		insn_ptrs_data.addrs = addrs;
> > +		insn_ptrs_data.image = image;
> > +		bpf_prog_update_insn_ptrs(prog, &insn_ptrs_data, update_insn_ptr);
> > +
> >  		/*
> >  		 * ctx.prog_offset is used when CFI preambles put code *before*
> >  		 * the function. See emit_cfi(). For FineIBT specifically this code
> 
> [...]
> 
> > diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
> > new file mode 100644
> > index 000000000000..f9f875ee2027
> > +++ b/kernel/bpf/bpf_insn_array.c
> 
> [...]
> 
> > +void bpf_prog_update_insn_ptrs(struct bpf_prog *prog, void *jit_priv,
> > +			       update_insn_ptr_func_t update_insn_ptr)
> > +{
> 
> Nit: I think the control flow becomes a bit convoluted with this
>      function pointer. Wdyt about changing the signature to:
> 
>        void bpf_prog_update_insn_ptrs(struct bpf_prog *prog,
>                                       u32 *offsets /* maps xlated_off to offset in image */,
>                                       void *image)
> 
>      x86 jit provides this info, it looks like arm64 and riscv jits do too
>      (arch/arm64/net/bpf_jit_comp.c:jit_ctx->offset field,
>       arch/riscv/net/bpf_jit.h:rv_jit_context->offset).
>      So, seem to be a reasonable assumption.
> 
>      Wdyt?

I did it a bit more abstract variant right away because in future
(read "static keys") there will be more data passed around.  I will
switch to your variant, and then, once I follow up with static keys,
it can be generalized, if needed.

> > +	struct bpf_insn_array *insn_array;
> > +	struct bpf_map *map;
> > +	u32 xlated_off;
> > +	int i, j;
> > +
> > +	for (i = 0; i < prog->aux->used_map_cnt; i++) {
> > +		map = prog->aux->used_maps[i];
> > +		if (!is_insn_array(map))
> > +			continue;
> > +		insn_array = cast_insn_array(map);
> > +		for (j = 0; j < map->max_entries; j++) {
> > +			xlated_off = insn_array->values[j].xlated_off;
> > +			if (xlated_off == INSN_DELETED)
> > +				continue;
> > +			if (xlated_off < prog->aux->subprog_start)
> > +				continue;
> > +			xlated_off -= prog->aux->subprog_start;
> > +			if (xlated_off >= prog->len)
> > +				continue;
> > +
> > +			update_insn_ptr(jit_priv, xlated_off,
> > +					&insn_array->values[j].jitted_off,
> > +					&insn_array->ips[j]);
> > +		}
> > +	}
> > +}
> 
> [...]

