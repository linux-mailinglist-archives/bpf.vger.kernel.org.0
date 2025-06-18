Return-Path: <bpf+bounces-60992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD2BADF72A
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 21:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31D567A8BF8
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 19:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91118219311;
	Wed, 18 Jun 2025 19:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZytZ6UYZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D3B1E0B91
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 19:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750276149; cv=none; b=VOEXDReLdRJtI23RUyPFeF/Yd+MtAV3F+jvO/Rh99eglrnoxZhI+54djxkPLCfPGmmWPkXLOz3dWzYrXECWJb3rh0asRkX6W/VDSQTjA6U/Hzlq54sNKrdkeR/1MdLoxtvmYXdgAIkku6TiwkM4gFh0mCb+xzctCJ+FzN4P9bis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750276149; c=relaxed/simple;
	bh=SIknRRuJoAmJQrfveZxAenHRhoJwCxG8uPlWkrv6/94=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uySWuY85w3oNMiQDw66xQAkmYJikWuk8+vdE50qfEOPOj7FAGdz9CcT9cQg+BsYJfLi+qvcEa9v8VvxypOXbk6qEa8AobyjoHnvaHb9QNEvFA/JnCcZvytx8mDAc7GYibyTilYs/bW3NPcj8CsSXdx/653AFNDgbqB1zK4g2Dls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZytZ6UYZ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-311a6236effso5721659a91.2
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 12:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750276147; x=1750880947; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avIKHeUWhUc/S3ePcCKX+yG4/EyxTP7saneAp8nUYcY=;
        b=ZytZ6UYZ2Vl+1B6qWh3fFeAA+2P8YD0XHVnaOi7vhmjgkB43udd5naXqynTWxG9OdB
         Ubs2sz4lDpJ8Aa+KFtbBC4qA5ZgnFylHjB6ZGHJpbTFnJu+wuyDFhhPIF1Gksi2iIGR7
         +Dmwu9WQod3a0XkQkhtfIUulidQMnWzmMYxj2UyoBP9UMHt8xiXknPYyU2CK1/O+CSgR
         Kcc2+Q6Z7eCZKHcJZFPBYrudsK6Xk23hav3XcWDziROmgbfiExaOOFXCreTinTYXAwfp
         oDnlcegdcxZ5fmJrgT+N//kUZxQUZvNdrB0mfr+DSrAxDjQX/RnNQWVQ/dQByr5sG7T4
         rmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750276147; x=1750880947;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=avIKHeUWhUc/S3ePcCKX+yG4/EyxTP7saneAp8nUYcY=;
        b=oqUqBb3fbx4i8gwyJq3p8pxAGMyetbhtIIcPf6qT1LuYVciM0lPvu8ZHD139Jk4UMd
         weszNgxKSNdSwj3wcKs7rU0l1BgvHBkhjpKEnmp4eEqkHHyxl8Brrt/80i+0THpZV8JB
         yFiE28GiEp1dKByer0S4mmUTW9cxASnx1oizd4Op+l58CvyUaivHJj/KDXjXYtMPBQ5V
         nQe/lmgeUwjuw/zGo49KQ/VmP31J8PkmMNHBZBq/Lunw3HCT59p0iPY4rtRsHz6atpse
         ks2Xq6HRldc/sYGXKtt2skDWLHr0oBhsYMYgQFJ0+pmKAd79QoUEuFrhA+iHMXD1Tccd
         7IvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQPtrrz163f/yfkh+/GChUTkji1bl9vnNH9Qj3z+su1FihvBMx1rYqbs0ooPrx0w/CKdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzblPV0Kn2Jv7rBWNhBB1tFWBFe+pgFf/8Fn/xYOYDEEttTWBY+
	OSy+llDpK+d3gLGwUWY9yDQjbAdawHToHUwkQAUTqJft0IGubIr5OxPa8J4P4/WZQn4=
X-Gm-Gg: ASbGncvAEdkgf+1BfHFn8PFh/DxJi2wRy/vPMBjXg7t1KFjq3/o5nkNry4h/yQUqTLW
	cpz0P+8SxkIMFpqnhH3C/R+otmTMaV5opnRf06tLR/Lj8Qzxnct2iuvhUcktM/WbGgp9KUNJBdA
	zQ4w9mvxuw3w3oQ5wWZ7yxKfLDbPo6hDAjlnbGV97bzss7oLU3srUikmawM2gvfi935AssZqwoe
	2mijdK0MtcMktcs16DFa905oy733xI4xiKnwI+++1p22r/QOlYQHAd/tp6pO8aE1nFFKi7mjFdc
	xoUuw2RGssS5SFTmGxMyDf/cf0ksydh7w2LkqRiW6GkdcHXAKiso8nhTxA==
X-Google-Smtp-Source: AGHT+IH+vsuTeTuiZ7icSSZfZ3+VwHGhhjtohRTt/K5mOag5iH7Bfx669eEVvjhF/uxMwJ1MqG+hrA==
X-Received: by 2002:a17:90b:57ec:b0:313:d350:a78a with SMTP id 98e67ed59e1d1-313f1cc64d1mr29055061a91.13.1750276146925;
        Wed, 18 Jun 2025 12:49:06 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d88c0a8sm105602295ad.3.2025.06.18.12.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 12:49:06 -0700 (PDT)
Message-ID: <1c17cd755a3e8865ad06baad86d42e42e289439a.camel@gmail.com>
Subject: Re: [RFC bpf-next 8/9] libbpf: support llvm-generated indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Wed, 18 Jun 2025 12:49:04 -0700
In-Reply-To: <20250615085943.3871208-9-a.s.protopopov@gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
	 <20250615085943.3871208-9-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-06-15 at 08:59 +0000, Anton Protopopov wrote:

[...]

> @@ -698,6 +712,14 @@ struct bpf_object {
>  	bool has_subcalls;
>  	bool has_rodata;
> =20
> +	const void *rodata;
> +	size_t rodata_size;
> +	int rodata_map_fd;

This is sort-of strange, that jump table metadata resides in one
section, while jump section itself is in .rodata. Wouldn't it be
simpler make LLVM emit all jump tables info in one section?
Also note that Elf_Sym has name, section index, value and size,
hence symbols defined for jump table section can encode jump tables.
E.g. the following implementation seems more intuitive:

  .jumptables
    <subprog-rel-off-0>
    <subprog-rel-off-1> | <--- jump table #1 symbol:
    <subprog-rel-off-2> |        .size =3D 2   // number of entries in the =
jump table
    ...                          .value =3D 1  // offset within .jumptables
    <subprog-rel-off-N>                          ^
                                                 |
  .text                                          |
    ...                                          |
    <insn-N>     <------ relocation referencing -'
    ...                  jump table #1 symbol

> +
> +	/* Jump Tables */
> +	struct jt **jt;
> +	size_t jt_cnt;
> +
>  	struct bpf_gen *gen_loader;
> =20
>  	/* Information when doing ELF related work. Only valid if efile.elf is =
not NULL */

[...]


