Return-Path: <bpf+bounces-71047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C37BE094F
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 22:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D8D75411B8
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 20:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16FF30B530;
	Wed, 15 Oct 2025 20:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajrfsx7X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4DE41C71
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 20:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760559005; cv=none; b=Ijosr+J6PFpuVSfJXqWrEF03PyVPjuxZ53qywDH46BxEn0vM8PPoyiVZ6qhjvvPQtxwuqYmBCIJ1wpBNaSJr34LN1MnNCXh/4T8htPgADisuz2jR/1DEDhNCmwyy9VwpSipuyi6y+iZojZTSedhwulD7+ED1jFFmBgOge+e4tw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760559005; c=relaxed/simple;
	bh=kZpneR/XUNUI3ubnrP5+KrImV+jKaDQDj6WIhj87lBg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JfFRRV5xhqnqJPFUdGGWQ36+ibQUZHKCf3wmSxPj1+lQl+n26TdlE0oPrkGmveJzhqTnKdCShBZwTKQac2RXI0M9Z4XjUsdp5zIjeR3u+hVQZBS+j576tIVJ+85wH31m3eBbbl4wvoIPe/lWXNctgnRL4/KBF0S1QzA8o3kNRUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajrfsx7X; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-781010ff051so25758b3a.0
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 13:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760559003; x=1761163803; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MCUa3IVNaOZEvx5tWjyhowsJNN35hujhwhx02oSqdf8=;
        b=ajrfsx7XHjjljPJGEMOQ4q3MD/sll1YlgW1Fjcv4Mrg8DLwNFvE4MlAjjGSrUZFkSu
         swKXSQ9O1yG3eWyJ3dMj8goLYC6Ba0aDsTW8GIuA/hVAmxXkELTOzGLlFC8pGskktcdg
         O4S18RRJ0oOaoGSwPcV5Xg5jst/VRO7UB1kXnxbhB8Fh5K+dCOnca7AGVKzfnxe1bli9
         2wPvGwg3/PQAfCvL5OraCdPdjhJFFuVzvHxOi6T2qWv3zqkOEx6cRjh4gvRrCInWjF4O
         CqRjo7ICrrTEMyEMOW1b8Agrvh/RF9Gml92qIt3/yeGlADzs4PC85atrA5++MRofivIw
         BFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760559003; x=1761163803;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MCUa3IVNaOZEvx5tWjyhowsJNN35hujhwhx02oSqdf8=;
        b=DyAwMuNTM4WRyrg9i0aTA3qNA8yBgqfO9NYhJqTKI+JUcf/6aj2bVp0de3ZNB8ZS/I
         DpO0Z0C5Ueuez6C0qMfRzkxA9mG+JND7sOFMIwm7aNoP34IMJL4NyJ8skenYCnC2ZW+3
         a9aaQqxJF0ay3N/+hdFBIkXWekTfz4hFdRzyk08pLaWu9OKYed8j7ND7FyCcCfPrL0Mo
         HouTdUQX0Vmr0P+abDDCfmPky8CEwcn58LcZINIFNm6XgbnzVlv/VhV4i9fwoqe6RDwp
         a7YY1xPLYzZqzZoRrhUTXDmU7/eY1cwvcZEKAU4q1rBhv+MJVjHBDDDVbgcEkuOsqXpS
         8bRg==
X-Forwarded-Encrypted: i=1; AJvYcCXkONdZdqd/ewu+YWTMmPB0dMATPlef3wyTtY+IH0y4SW8aIHqttZfopEsbH5jTmTN5Abc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvgjZA4c116VPh1KSsdrbvstNE0D/Upe/Srucvraa4bk5s43DV
	d55NT00QRTdhm+5yFgD0yreRFakHuh2G7TF67oXsSU2ac0CI12e8xexM
X-Gm-Gg: ASbGnctMkZ6Yph4SyKPAmZhLMcn1APuTffr9925vAx24YOiTFAbT61HNmeYGPOLKQg4
	sPJ75GQM0vmvkmyQKZ6l676cI/lBJxtWmpPNrdkW2uY3b7HA9X/PRPS6caQ2SOSfOzMn1LRAZd2
	hkdJqbAqO8C/tWDcPhKjij+Nzfmny2OcBbsAPb+IjI48Hzp0uBnOf3X6p3GJY8RitdM+5XYeKw3
	zNZAW/zqHfpaYe0G57wJfI3FLjTDS7jcSBqsyc0iSlUMdRIX3/vINDwx/1BImf4K5arGkI2xBNA
	rcwaosZ0th9iQHqNdLdJ0hJJwJx2CfA2sgv6pPpiPXomP6kf7gPwY5zxDVZ68BWc9uUEgT6KBMY
	lYyi67Q6OTbKHlfXmFc7ZNNaCZJdBfhJEVBOYLrmvPtL3i+KTuw==
X-Google-Smtp-Source: AGHT+IFnoeRbSvEekKuM718qr1Ce6hCe/ZV33TBm5id/ip7iVptg4Ll8wJEe6OWPaBqppbuQu189Pg==
X-Received: by 2002:a05:6a20:d181:b0:334:89c6:cdeb with SMTP id adf61e73a8af0-33489c6e366mr4710417637.56.1760559003102;
        Wed, 15 Oct 2025 13:10:03 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a2288786bsm469932a12.5.2025.10.15.13.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 13:10:02 -0700 (PDT)
Message-ID: <eccfef0ebf53ed38ec4f9cfd5ff9e8b9f9ff1e4d.camel@gmail.com>
Subject: Re: [RFC PATCH v2 07/11] bpf: add plumbing for file-backed dynptr
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Wed, 15 Oct 2025 13:10:00 -0700
In-Reply-To: <20251015161155.120148-8-mykyta.yatsenko5@gmail.com>
References: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
	 <20251015161155.120148-8-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-15 at 17:11 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Add the necessary verifier plumbing for the new file-backed dynptr type.
> Introduce two kfuncs for its lifecycle management:
>  * bpf_dynptr_from_file() for initialization
>  * bpf_dynptr_file_discard() for destruction
>=20
> Currently there is no mechanism for kfunc to release dynptr, this patch
> add one:
>  * Dynptr release function sets meta->release_regno
>  * Call unmark_stack_slots_dynptr() if meta->release_regno is set and
>  dynptr ref_obj_id is set as well.
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

