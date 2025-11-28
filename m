Return-Path: <bpf+bounces-75677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D63C90EE0
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 07:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2549D3502CC
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 06:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CEC2C3277;
	Fri, 28 Nov 2025 06:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfJqdIe2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D6D264619
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 06:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764310586; cv=none; b=GYiMpa3hFEld5VkXjmUbyaCXSXIxi2gB6NydJcaqcI/ldnFl4IDY6v7SaqXP0lLNi5O7z/MeOZ+/1DQ25cwhhHzknLUMGiVTarRZZbZ8TbOMhgKnHeZyax8IH0NA/d16/vNl0v5oYC/SR2sFw5tX3Knq63sJKvC4njKW7U7eXq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764310586; c=relaxed/simple;
	bh=Ddfq70Wq2njdv2t38hOHLOSzU+Ne9oRmi/W722hOnv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOSX6MHgTN6iQz9waPhYW0hZvQ1bVs3bI+WIodzs3QpCAh1+RWKbLrXumKiJSzKH2Zj1sagMVUb6sUh645qg38rkoCWVj5yXrd3c03m5jnrLczGGfGXfwemUb4VDuMQCuI63UsuWwPDgVKx0AusuJJ8OARNrziK5sRp51x0dmeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfJqdIe2; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477a219db05so7884235e9.2
        for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 22:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764310583; x=1764915383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nNBd/d4YAEtMBiBZXF01n2LDFrSxOqxWsFomuAuzux0=;
        b=hfJqdIe2ahAIY0CYu0OXkh1lJY688y+w5rQpZCGMtsiBf4Fq6mzTy0i/o3xs/ak6Hb
         Far8E5pyWlMnKzCd0udzqnKtIoBBbnKPs8XK5yP29ZOii1hi7XLDukewDLtmwZT3HB0L
         1MU1p5YxAOL97NNiWhTYjqk5QkBNYnROLr4F0TQpHLaO4J3SkIZQpgwsNEgvjNOKVKms
         03Sx8tHMo1cwXuPi0ys4dPjkHxTr8Fjwd5+6Z5ioAO+8oic1A3IXj5l89DlaB4Zqbt7I
         pXcuSwd3SCPjcr2lct6vudy7fuXqrKmya6XnP3Dk6Zy1s72v8xeQwdpD3RpAoswNQmxJ
         lD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764310583; x=1764915383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNBd/d4YAEtMBiBZXF01n2LDFrSxOqxWsFomuAuzux0=;
        b=mJtGBD0TCn9uOvtKK4njqs5h3SQuvJS/qInrn1dPnoj63LVv7Cy2JI0fhS9n5a7QaS
         ofs+8jfnCh1fnwp5+mLz0ot9z5BHlzagixxWf/HX0Zuf6Sl8N7EnQqT6rQ5pBDULv6s1
         9uLH41DHdyBF+Ho/ChqIqHXg8D/voOYKvOUIxRxDTw6sZww3Gp4kYd43/urHQEdMBNtW
         jGNkC8h7TtruIzlIj6+XIxy3LD7e1ddAjGgsFtYhN3tuYTjTIE7ySONL5HXDhcqPONeN
         8I0UNfQwJ6ut4w4+mHSL6PSDf6fFo8irQsQJv4tezC5IJgPudims4RcD+w7+5kSKuuKY
         qoIQ==
X-Gm-Message-State: AOJu0Yxjfo77BmSrC1k2sGpeYi0BpUuAPLHZxIMIM69X+8sXNlqUVBkL
	TD4gKjP50C4Oh853Sru2OuekA8We5wbZ/RcO8lxjmbijxcEulEIAfWCp
X-Gm-Gg: ASbGncvSD8xiPv9ZND1skz2/byuWlXgGfYxrwmsZuDCJ7CWVhUOtFFRO06iG2HRTY9G
	LSlqv005IHpOc0YinNYkiJwR3Yu8KtZQYrzi61zMdLo9YAtlGrvxyG1RyXWXA9JOiOha6+l8mPN
	kYVHO/spUT3rZTiStvRULtSj6abKc9ETxbzHylaiZy4D1aUY82duSL9h1bV/LjDmNbdQQuVC2bU
	lLQxdSBF7sMKrMY8mXjvEgLHM7Qv52mBrVCmAFxB7UC95rKHam1QtuUGa/NmVo19SdRYMHLM7+F
	RZspkb/X0RlRrZdN3QumsXIysIHB3WvnbeXMCvcftx/JDcT9vgwYt2WiudMX5MO0BXilsobFSXz
	jNdyqMyqNuM0eTi2+aiaLfDudd34adId0d6hpYDIzBknGRR0+oL/1fBX+r/cl1b9gHyokOcqgA8
	p0E82XFnBLviCwHIKp76xZ
X-Google-Smtp-Source: AGHT+IFEVb/jAIP51kUupfgeWguOUvlHhhITZUZXkdPaM9nV4ssRYjb0+bKzl2BUh9eEFHV9i9ILyQ==
X-Received: by 2002:a05:600c:19d4:b0:477:63b5:6f3a with SMTP id 5b1f17b1804b1-477c112635amr226098685e9.27.1764310583196;
        Thu, 27 Nov 2025 22:16:23 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca1a303sm7513921f8f.27.2025.11.27.22.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 22:16:22 -0800 (PST)
Date: Fri, 28 Nov 2025 06:22:50 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next] bpf: check for insn arrays in
 check_ptr_alignment
Message-ID: <aSk/ugIsUxww5tyT@mail.gmail.com>
References: <20251127210732.3241888-1-a.s.protopopov@gmail.com>
 <40da69b17d8be21c32270eba8f2c28c20078f03219c37288441322285a1d18d3@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40da69b17d8be21c32270eba8f2c28c20078f03219c37288441322285a1d18d3@mail.kernel.org>

On 25/11/27 09:25PM, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 766695491..43991449f 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -6482,6 +6482,8 @@ static int check_ptr_alignment(struct bpf_verifier_env *env,
> >  		break;
> >  	case PTR_TO_MAP_VALUE:
> >  		pointer_desc = "value ";
> > +		if (reg->map_ptr->map_type == BPF_MAP_TYPE_INSN_ARRAY)
> > +			strict = true;
> >  		break;
> >  	case PTR_TO_CTX:
> >  		pointer_desc = "context ";
> > @@ -7529,8 +7531,6 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
> >  {
> >  	struct bpf_reg_state *regs = cur_regs(env);
> >  	struct bpf_reg_state *reg = regs + regno;
> > -	bool insn_array = reg->type == PTR_TO_MAP_VALUE &&
> > -			  reg->map_ptr->map_type == BPF_MAP_TYPE_INSN_ARRAY;
> >  	int size, err = 0;
> >
> >  	size = bpf_size_to_bytes(bpf_size);
> > @@ -7538,7 +7538,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
> >  		return size;
> >
> >  	/* alignment checks will add in reg->off themselves */
> > -	err = check_ptr_alignment(env, reg, off, size, strict_alignment_once || insn_array);
> > +	err = check_ptr_alignment(env, reg, off, size, strict_alignment_once);
> >  	if (err)
> >  		return err;
> 
> The insn_array variable declaration was removed, but this code still
> uses it at check_mem_access():7568. Does this compile?

Robot is right, I should have sent it as a series with
https://lore.kernel.org/bpf/20251127210656.3239541-1-a.s.protopopov@gmail.com/
Will resend it now.

> 	if (t == BPF_WRITE && insn_array) {
> 		verbose(env, "writes into insn_array not allowed\n");
> 		return -EACCES;
> 	}
> 
> The fix would be to check the map type directly:
> 
> 	if (t == BPF_WRITE && reg->type == PTR_TO_MAP_VALUE &&
> 	    reg->map_ptr->map_type == BPF_MAP_TYPE_INSN_ARRAY) {
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19747897022


