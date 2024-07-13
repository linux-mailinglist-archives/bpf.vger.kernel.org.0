Return-Path: <bpf+bounces-34716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4644B9302E6
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 03:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89889B239F9
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 01:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DA98F6B;
	Sat, 13 Jul 2024 01:01:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E094C6E
	for <bpf@vger.kernel.org>; Sat, 13 Jul 2024 01:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720832479; cv=none; b=gbIF4Rs3QZ1YeY53Kl8oCKgv6/7lZtrjAl4iDkYmLbIXsVPiNGRLrZQZAN/k/Z1KwcVTyNZvFhxb561Rckj/AnoJxTjxCgHY9pEFHFdOkNes5tVRDpe/8NOz1vbsJEZa/T04XRl4v/qnm5VScxAflBsPqEtJ/YGwLC1yE/CBmOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720832479; c=relaxed/simple;
	bh=ra4w+jUzeMGM4/wgVXiJhEy2o62qo8KZp/zmcSzieJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EE3Q29lHcdprnTBZpQOeD8Q4xW90HkIS/vOUSsYthJPPiGomQJRRvIZjBs9S6moYnpM7+CcUQ2/Rn3Y/YaLnnQZpIVZnLzlYH5HTbsxuoB2XAQLZMXjZo8T29yapwDiFM8OeFrf7zexyCCNW9F1zFEww8CDqRi0KkHYVNpumbPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fbfb8e5e0cso9719205ad.0
        for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 18:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720832476; x=1721437276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yi5tzHJ3kBO7FHSF3Hj6XXpgmi3GQ9m5aYWFhf8BG4I=;
        b=dUgPictgoQ10g3xBn/OfoJj7GEYSVE4hm5awWONRuDP2GduFEMMb4f8HDCNmx5DzJf
         uFRvTHm+CGdmeiyBNvkQlO1OmcGgupYWNy6R0G/01KHWtnBr4nwQZcN07MRJM8d4KKGe
         VMpx4iHDshttxdMvJ1ud6qsrOedaEvPqyg2uBgUuYt+UyfsKonbr82wut62I9a3xHKQK
         +oCKW9klNGDMLvbJ+0NbCL+MvDnVbzKMVCwC/3QlvlpzYS/+M38D5RVjdidzJOE7z1j3
         66PbY3mei8Zq/S7qtN/B8F0+8iTZA/c4cLTVwtNJ4UEPcOL583orcxdGWzcKGntv3+HG
         E9Kw==
X-Gm-Message-State: AOJu0Yyy9mZwE2SADZSEJCNab82Zv59COjIadXwvklJxFsnKIq0Keh7p
	iAQJE/DmCrHsIC6ZPY2FysMIis8b5SnwIlKk8AisrQC/3BcudV0=
X-Google-Smtp-Source: AGHT+IGKlpRd+xP9oiaMBiw29ofYejacKgjKwYrAPWM+sibc6tLgMd+o25Pd4YAOV4MbyY8e04N0Cg==
X-Received: by 2002:a17:902:760b:b0:1f9:f538:4b09 with SMTP id d9443c01a7336-1fbb6d91298mr84340375ad.57.1720832476458;
        Fri, 12 Jul 2024 18:01:16 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc382e6sm487165ad.194.2024.07.12.18.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 18:01:16 -0700 (PDT)
Date: Fri, 12 Jul 2024 18:01:15 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next] libbpf: fix no-args func prototype BTF dumping
 syntax
Message-ID: <ZpHR2xZwIh7IpVdL@mini-arch>
References: <20240712224442.282823-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240712224442.282823-1-andrii@kernel.org>

On 07/12, Andrii Nakryiko wrote:
> For all these years libbpf's BTF dumper has been emitting not strictly
> valid syntax for function prototypes that have no input arguments.
> 
> Instead of `int (*blah)()` we should emit `int (*blah)(void)`.
> 
> This is not normally a problem, but it manifests when we get kfuncs in
> vmlinux.h that have no input arguments. Due to compiler internal
> specifics, we get no BTF information for such kfuncs, if they are not
> declared with proper `(void)`.
> 
> The fix is trivial. We also need to adjust a few ancient tests that
> happily assumed `()` is correct.
> 
> Reported-by: Tejun Heo <tj@kernel.org>
> Fixes: 351131b51c7a ("libbpf: add btf_dump API for BTF-to-C conversion")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

