Return-Path: <bpf+bounces-26584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD15E8A21A2
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 00:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEEFC1C215D4
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 22:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E2B3FE5B;
	Thu, 11 Apr 2024 22:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arbWoHmq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF263FBBD
	for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 22:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712873538; cv=none; b=IEAyLdJQT4u2Li1+tPXeTtUqdS2DJRK15u0PBXdQsqSbmDp8NfkDwswNTtNxAcFpnWC1JlxXZ7wzLuIYf2QxvVXDIu3OQJNZSm/8GS1zfa41msrALnab461NDMytGz/YXZmg6YuhLfj8JSGO9nGCFXPu1FnQ2tOtmq5eJHfzbho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712873538; c=relaxed/simple;
	bh=RWJ3+1TKc71+xY+rluVgmJU/xVK6xmPo8z7S4g/4o2Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E55EI26x4jbZxAx216RxShu7wd/i2xuCGASD7Ew1hMJrVCPMjWsiA+i6WJEWzZXRFRrWrqiCZ9CRdmyqKdh5tywa4w7vLlFS1jAtM4R3GLrhlVpmiOPmSwBqD3rOEM3e+ChGXim1OTtzVh+Km6a1J8GuVqZWI3TnJ0SlqLWmca4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arbWoHmq; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-516d756eb74so354358e87.3
        for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 15:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712873535; x=1713478335; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RWJ3+1TKc71+xY+rluVgmJU/xVK6xmPo8z7S4g/4o2Y=;
        b=arbWoHmqGcchW6vfAni6ZcHCdsymWGrOOhhallDZQEOg3XmVPHJCOGUWGykASMVF3L
         DblGAkFImldYR/PxtNK0sfP67fOY93y0B0qLXsFVjjYz17yIGCFZnzUgpe/YzfLx0EtS
         YGWVAvPB1i7EsAz4KNn9KQ4VE3fc9ItK0uNiMzwSsuwCW8qoKJwaI+NIAy8NiO3fw4ZA
         upcOVdFOBMNSLSHFtgJiNP75+FsBGpwcSSLlffOcMe/pGnZb3I14i/dSHzzDG30PrfcY
         ITLZN0B9o3bMlsrgDX23Ue1hyOEe+9IPGfFP0bEWOvM16X17a5iksWcYvns77SeFhqMM
         m7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712873535; x=1713478335;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RWJ3+1TKc71+xY+rluVgmJU/xVK6xmPo8z7S4g/4o2Y=;
        b=VY8bMXWFVUwirRLkJztimAV/S3cqW72mVgyC8fsmxQBAr7h1b8iveow+jYnVbNmP09
         MAwDqPGUf1DZm2JjpXp1LOUZZivD3kA16Ihyf0LjYcPEqUdIqBnpSxx8RsM2v4p444Fq
         fmEUgJZoEyFF9Dg4F9NFN9gR/MIPVLCVJe+aK7CW502YpZCJZzIop4ahIbE36d3GCrUy
         gFl1RwpSJNbO/+dgrR1uYdOFx4CBzFhpCequAxU1+OMfawmhBE5ViZ1rgGBX/ghnha4w
         baWAkSah8D6zOkd3RdpmJm+BVxh/N+GJModmLyUhkDwY9tO5fM3b0SS8Pm1n5U00RjC/
         G9Xg==
X-Forwarded-Encrypted: i=1; AJvYcCV+W0kS7vQdS855vVeDy74BrQWMmhedlHtVFoMdP8l2nFuEA+YqwaDoryRiGAVpsPCWyRZqhGZG1s4ORy2Apq4zj2rL
X-Gm-Message-State: AOJu0YzUYO+ipf5VqmpnMC/k0evPmcMM7Vt8h85l3nEtaK6XbO1CjKOY
	mlDLa2kxG+CKiee447D0SGEGBdiGNDaWMmQKMXJ21dDTFV/LI9ONahz7yfjb
X-Google-Smtp-Source: AGHT+IGC2XC/pteZAi9DVo9BQF6IH8LyHGOvYXtHwMZEr+k4r4Ulj4cOeVa3TPov00ryJlsROf9nQA==
X-Received: by 2002:a05:6512:481c:b0:517:8b17:1f1a with SMTP id eo28-20020a056512481c00b005178b171f1amr458372lfb.68.1712873535257;
        Thu, 11 Apr 2024 15:12:15 -0700 (PDT)
Received: from [192.168.100.206] ([89.28.99.140])
        by smtp.gmail.com with ESMTPSA id qs1-20020a170906458100b00a5227c8f0e4sm728610ejc.89.2024.04.11.15.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 15:12:14 -0700 (PDT)
Message-ID: <6d20f36e975ce7fe3d478bc80c9f3510404430da.camel@gmail.com>
Subject: Re: [PATCH bpf-next 02/11] bpf: Remove unnecessary call to
 btf_field_type_size().
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org,  martin.lau@linux.dev, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
Cc: sinquersw@gmail.com, kuifeng@meta.com
Date: Fri, 12 Apr 2024 01:12:13 +0300
In-Reply-To: <20240410004150.2917641-3-thinker.li@gmail.com>
References: <20240410004150.2917641-1-thinker.li@gmail.com>
	 <20240410004150.2917641-3-thinker.li@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-04-09 at 17:41 -0700, Kui-Feng Lee wrote:
> field->size has been initialized by bpf_parse_fields() with the value
> returned by btf_field_type_size(). Use it instead of calling
> btf_field_type_size() again.
>=20
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>


