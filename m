Return-Path: <bpf+bounces-20727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FBE8424B6
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 13:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6F51F2A052
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 12:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA41B67E7C;
	Tue, 30 Jan 2024 12:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="PNzUaejD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFDF6A33E
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 12:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706617173; cv=none; b=SVOBnbesL8uMOmxO83V2S/QXyxwv7CEOU0i42xPqDx7NgyeuBOMN5cdRtFsDYS55brdPfakc43YlUbVtKNfmLUyjeIefbmyKQMj5NkqCiuPftQlhgFsbEWHIDlruqPtHoaSbMnsc3+1iUB3nHCDwNoQbiMMCjfi8z5P8kGxGlZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706617173; c=relaxed/simple;
	bh=k8ZOIXDxyu7ZtgsH6s3CyT9vAtVpCyNCYrrTNZdRQtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uhe25HcD7XYDyHsPH8Oofz7Ch/Q+ar5BXLRGXtXTo7xwK/KjfymblsOD5A68a8H3ZFXbc1RbdAlr6EuBa4A3Iin+KeEkYSD/72VOTQosUdk3+CVstfJ+hzEXsuZrxhHBROJwBtozwPpOpq9prG/c/v94ijpq7/0O+RXF3Xv0wzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=PNzUaejD; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33ae3be1c37so1532391f8f.0
        for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 04:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1706617170; x=1707221970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Q63xLswOBkA+oq/He0tfo2qtt1SB42uR6PmKEpdZ/g=;
        b=PNzUaejD7JZ+xxj04nDfVv6fOO2BAQCN64XfCdsOuZiHwfhcBvF3BheLNqmlp4v79m
         GgwcUyxn5LTYeXGviAUrNKM1ppK5gaZ3GH26L/baLsvv8qNYOxQI13wHl3ch0UF0PSa9
         DjZMs557zvZsNXGi3R0CL08mI2hKPSyXqs3vcmzjwirYxuBs/aKQq5jGFnYw0yTjnRRE
         JIoxvfHNp6Le1q7HxGc6v7Tw24XzfkbD2Pvj9kXydwIgTOw2M/laTv+1V3AWkLFhdNF2
         sHXAhNUEZuCGN+ryhM/7eKb64MYmIXX2GoT3IrD+R8GGVvY/SlgqWrANx99qmzDXSKLA
         qUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706617170; x=1707221970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Q63xLswOBkA+oq/He0tfo2qtt1SB42uR6PmKEpdZ/g=;
        b=G1Hl6NFjSD0OQZIwxZXrBh1nysxKaUee2CXOEB06MRVoF3R64Z4tTUwQIF9VqF2tBW
         fC3pBGonGuPh/WiphEPXhsDlikHE80V7s4EN6QWMXpARTKVm0LsImdeioiAoK4II4xza
         tcgIINXF57RL25Elu2QMWYpDbTpE263U07sPL8Cjws9uSl7oWTlxU4NtqEEtRkAdxKBP
         CcKNTbDoyJPYjGafuP2DT5OObag68nXDhVKQ6pz7Exrn7E/dGRTEQiAlndcMisjU5rgP
         u5eIui+7j4euyyF60W3PKw7jy3C8xt91H9dHkymHNalln8SH5jUIHFKxx0UJzITH3U3z
         LoVQ==
X-Gm-Message-State: AOJu0YzLpeOsG0udVN+IgCX5EuRcFwPAzKRYYvYME9KmsjVBqSBcOD3Q
	pBFmh5GqL8l09C0KXiBzI+mfxKrhc/XR9TiZeXk64HbzqiW32SGuD+oWTPSYbng=
X-Google-Smtp-Source: AGHT+IHP5Q4bKUbQc+QVYzjCC/RWqa8BIB2EwRcssg6n7gHSE8Vbr3XsBtaF5SnyjqSkKmi2ZzpwYQ==
X-Received: by 2002:adf:e701:0:b0:33a:f48d:1a16 with SMTP id c1-20020adfe701000000b0033af48d1a16mr1236248wrm.22.1706617169742;
        Tue, 30 Jan 2024 04:19:29 -0800 (PST)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ch15-20020a5d5d0f000000b0033905a60689sm10774829wrb.45.2024.01.30.04.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 04:19:29 -0800 (PST)
Date: Tue, 30 Jan 2024 12:13:48 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 1/5] bpf: fix potential error return
Message-ID: <Zbjn/N+P0AtObCy7@zh-lab-node-5>
References: <20240122164936.810117-1-aspsk@isovalent.com>
 <20240122164936.810117-2-aspsk@isovalent.com>
 <ZbjbZjS2IWuj09VK@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbjbZjS2IWuj09VK@krava>

On Tue, Jan 30, 2024 at 12:20:06PM +0100, Jiri Olsa wrote:
> On Mon, Jan 22, 2024 at 04:49:32PM +0000, Anton Protopopov wrote:
> > The bpf_remove_insns() function returns WARN_ON_ONCE(error), where
> > error is a result of bpf_adj_branches(), and thus should be always 0
> > However, if for any reason it is not 0, then it will be converted to
> > boolean by WARN_ON_ONCE and returned to user space as 1, not an actual
> > error value. Fix this by returning the original err after the WARN check.
> > 
> > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> 
> nice catch
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> > ---
> >  kernel/bpf/core.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index fbb1d95a9b44..9ba9e0ea9c45 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -532,6 +532,8 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
> >  
> >  int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt)
> >  {
> > +	int err;
> > +
> >  	/* Branch offsets can't overflow when program is shrinking, no need
> >  	 * to call bpf_adj_branches(..., true) here
> >  	 */
> > @@ -539,7 +541,12 @@ int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt)
> >  		sizeof(struct bpf_insn) * (prog->len - off - cnt));
> >  	prog->len -= cnt;
> >  
> > -	return WARN_ON_ONCE(bpf_adj_branches(prog, off, off + cnt, off, false));
> > +	err = bpf_adj_branches(prog, off, off + cnt, off, false);
> > +	WARN_ON_ONCE(err);
> > +	if (err)
> > +		return err;
> > +
> > +	return 0;
> 
> could be just 'return err'

Thanks.  I am inserting some code in a consequent patch in between,
so left this in this form

> jirka
> 
> >  }
> >  
> >  static void bpf_prog_kallsyms_del_subprogs(struct bpf_prog *fp)
> > -- 
> > 2.34.1
> > 

