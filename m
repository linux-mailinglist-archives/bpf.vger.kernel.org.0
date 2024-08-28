Return-Path: <bpf+bounces-38317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AD89632C0
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 22:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC9B1F222C1
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 20:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568CE1AC45C;
	Wed, 28 Aug 2024 20:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eU/5wbLa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7922E15A85A
	for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 20:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724877768; cv=none; b=qtfujKKl5gmlMsxq+MoGti5KEInzb6APDlFzs78MnrqJ5Uo9Ac7WgRASboNHf/PPUPiZ6L9RRdlHbveOHbO3ck+RXBSq5EHGOF0+TPx8im2Y1Xh5x0VdiCvJlNMAkXr9peoQAfp+XUVdGs+1/pCNNlxogKEkzryUGSLG7gxOBME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724877768; c=relaxed/simple;
	bh=xwgxGuvyfsX2fMfCG9BMOL+NRkYAuwqcI+mbLa/EUdA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hzKOxCrGWWss63F2YYR1N4vtO+F59qg8PHjjYmR+tgYAtF2YCV880FmmWWCpFz0Q0Lh9U9vaRe9sZzU6/8pNROyxmz/2g+ZgMNBNAh90HPT1ThOEwIUDTMej17i/TQSM7ABfIi+TUVbvBgfypaF9NvrQZVuvxYSAA8mfPahYufo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eU/5wbLa; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc47abc040so62869615ad.0
        for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 13:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724877767; x=1725482567; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xwgxGuvyfsX2fMfCG9BMOL+NRkYAuwqcI+mbLa/EUdA=;
        b=eU/5wbLa2ji+4zeP4LDvE6ID8hrjYxWLK/FkG/+ixYxKyqZBbDim1mWKqazzuxJ9D4
         4jLBV6jJqsXDSTMVpw1N2ZRq9x7o8K8KB36sKQb8xTYsT5bAGHuurXzK+OkZNhpsUMp2
         cffN+sSEiC2LGkGJsHZtqayZsbhzh5DZbwbJsXv3wPzk0Bw9xoIygMorSk0O+Bwx0xpO
         7t+e2uyygLMN1vhjT4zxBm6rpA/LCTghRWWaoJiEjfBAiKu1csaml7cyKDthx9puhNHy
         12L7eS0AGVw51Me882Ky9oy5WeCixL1eXv2oBjP5T7jE0VTy+cg7kzCEzSGTnTRE8Jcy
         jl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724877767; x=1725482567;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xwgxGuvyfsX2fMfCG9BMOL+NRkYAuwqcI+mbLa/EUdA=;
        b=LwQLp7dFPw/7A+OUOYjuCbIQZJM8rXaMa2XLcl+Vhzyewp7xy/oHYLMoCbMBXDg9/L
         7+/cMQkM9JS4kavo7ZSMsVNhEaJG0TRR5AZK7PzPb7AB5MfdbEIzEMJ04nC7sdtu90jl
         pwAgdk6YDVspR75arM6AKaPmxeIEvQoJ4fxfce2wt/b4KXTYz6BTImG+bqjftFZWMJwR
         bP00KsnW6ju+ikf//BxUPpNf6hMOd5QDfSCK3SLjp+w5mU7vnXznZQ2iRzVyASJqSmIb
         ceMe57695vha/ZGSaEG8bCgjiLgoredvJJPhYhmpFgSQgkde9yOxfkXcpJRjghDnZqsW
         iQog==
X-Forwarded-Encrypted: i=1; AJvYcCWGDp0THhOekmqpu7o2duujOnUc8z0zuN7SvQ2QSTKFH/TikSt45kL3xaRlIglPqzo23kg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdew8huaO04ZoYD6TKEVeLXfTMocKEz+aHlZSQK2Ow9OPjWvCP
	mBgbTWh9MPi03Btkdnw/CPlo4kGEf+ouEC57UqKQ9SZff3UvsvHd
X-Google-Smtp-Source: AGHT+IEvR9Oj5yPrn5iwL/Wys8OKfUWnc7SoC7umKUcf4YQUmG2itV9yo+WguNdhqL2X1/NRHlfDnw==
X-Received: by 2002:a17:903:41d2:b0:203:8b7c:c8ef with SMTP id d9443c01a7336-2050c33205fmr8050845ad.20.1724877766579;
        Wed, 28 Aug 2024 13:42:46 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855dbf13sm103667445ad.163.2024.08.28.13.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:42:46 -0700 (PDT)
Message-ID: <bf0e1a4759ed7c09e84899cd25823a057a6bb9d7.camel@gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: fix bpf_object__open_skeleton()'s
 mishandling of options
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com, Daniel =?ISO-8859-1?Q?M=FCller?= <deso@posteo.net>
Date: Wed, 28 Aug 2024 13:42:41 -0700
In-Reply-To: <20240827203721.1145494-1-andrii@kernel.org>
References: <20240827203721.1145494-1-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-27 at 13:37 -0700, Andrii Nakryiko wrote:
> We do an ugly copying of options in bpf_object__open_skeleton() just to
> be able to set object name from skeleton's recorded name (while still
> allowing user to override it through opts->object_name).
>=20
> This is not just ugly, but it also is broken due to memcpy() that
> doesn't take into account potential skel_opts' and user-provided opts'
> sizes differences due to backward and forward compatibility. This leads
> to copying over extra bytes and then failing to validate options
> properly. It could, technically, lead also to SIGSEGV, if we are unlucky.
>=20
> So just get rid of that memory copy completely and instead pass
> default object name into bpf_object_open() directly, simplifying all
> this significantly. The rule now is that obj_name should be non-NULL for
> bpf_object_open() when called with in-memory buffer, so validate that
> explicitly as well.
>=20
> We adopt bpf_object__open_mem() to this as well and generate default
> name (based on buffer memory address and size) outside of bpf_object_open=
().
>=20
> Fixes: d66562fba1ce ("libbpf: Add BPF object skeleton support")
> Reported-by: Daniel M=C3=BCller <deso@posteo.net>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


