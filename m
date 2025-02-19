Return-Path: <bpf+bounces-51903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3951A3B066
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 05:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0924E1895D32
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 04:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2B71ADC89;
	Wed, 19 Feb 2025 04:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJNRoHt3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F7A1D554;
	Wed, 19 Feb 2025 04:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739939778; cv=none; b=IhbcV9FcBYG+FwDq8J8W0877pLd+9CsQlegAFPH/QR0BwNzz8AMJHZSXndyWFjK69rxjPBXHfq9WSBd4gkB43wI+amdoH9jkVK01r9e5M2vq5uLELEKbtUpSkp+aEnpKrglMXGQD8Z7fX7ZTdKnARi9LzBzThZLfcZajvY48lLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739939778; c=relaxed/simple;
	bh=BmHnCACKYA3MiSicyfylGMkAtUIPVbcUold434lJ9R0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QRXw8Hc41pYsaJDB141yezrKDdIpyriwHwPP2cdR2Hn0dFjwUwXVdqHbcyZztx5ETfJ4lC7BkhsnjlRerWpnSr9HyVUNIuYtCV2Go6/BSSeVhyATCA3+zf6paZ2CajqyBjzSCgUE1gfHOOtqp5bSOnXWwRKFEf22vFF5IPuWSRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJNRoHt3; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220e989edb6so127185295ad.1;
        Tue, 18 Feb 2025 20:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739939776; x=1740544576; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=riATTGyG710pV3BN3120yRJm6DIA+EsvvFZ67rMBOj0=;
        b=dJNRoHt3cTHALD4VOGhGGbObkpcz+4o6dmUwxFHHO67YMwTPkCDLcElP9kY6lIX2mb
         AYDLYw5EfOquG3SsFr2DmpSAjSDXsQBzx5+3cgWUmeElsL1CFxKswOv0TV5qYyDtzFN2
         tuPM+3X118LrrPYPjC9x9Y1bA18L4Gk/xSQgFJRJ3egHJDHVy3kTtVq2pi1WQOZT0Vgd
         37VooCSeYwVEkSFQDMNgEKAZbx/30MZonpKznhtmEFsoDxjMvLBJkYQUfyIdxMPrVe0p
         /Rf7sYXhtkC/lzohWzwpmxA7lDpRjygiZzU8jfqwPCQAfRKGMqZkmelnRU9VuVHdbfu9
         r0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739939776; x=1740544576;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=riATTGyG710pV3BN3120yRJm6DIA+EsvvFZ67rMBOj0=;
        b=LQUtL37HmQVXdMNYgw7iBdM9Z2F9xJlz8EiwZs3OgyEK4MIve3t9aDum1DujhogX0O
         wvQbS2fO4rlRPdHI+5QfvHzXlHL34HPp9TmhlBnDCFtsCWbEbsHBSzlP2rePYI0qslkw
         9oP61h2zpM92oXY59YCoKvcGx6N9+ZfgysOp4hCIH3QHWGcEWXfvP4krn6HxIDrxPlmQ
         Kskse1T/5cRABPYY2yOTLvTr+6c4/Ylf9PO6Hbiy7/3fHW07T2S/u0LQkxzSYzOcHYxx
         VxaIOB5dr1KhXRbsN6FMYDPpBAnrt/FT9J8SO2i2gx5FnmueImhcnmgLo744D6gNw3mY
         UODg==
X-Forwarded-Encrypted: i=1; AJvYcCW3W7CtTIamIldMj5Pu+mUj9o3ABrBgpbHVlrq8hgCEe2YL3sSA62k49oyJURmNMGIeS7w=@vger.kernel.org, AJvYcCXV9oekpHoodMGRieQt4v9DdQrhqZJNI/sjqYUs2qp/IboijDDvioKsi8vlEYTVSv2TdQtW4AH/Pw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm+PBp1Za8Co9YXBNsMsibRICf4RL7Y2Bv8+uOCmjL61L3ktBi
	9rUC7W2YYooaIU+WjJ8vF7EGo6xrcD+Eyyk+km7pYIGFrQ2cGKY5
X-Gm-Gg: ASbGncvjhUBrn14MdD+3P1abBxo+v8a1kdkIaau5kHcmvdUhMsdjBpjmmdg2G6NrWgi
	CUetQj25oWECdTx4MZPQQpJVu7jSfCbY+Yln+AwimSwrHUTQr/7GSGxSLivtR2Eg2uvQkNHRPyH
	2Y9LREZdNq2yh4acSOlEOP/hCE0O4013JtKrjs18Ta2ch0jALE/sWrA7AuVotYzMcqXdOZLVymW
	0/HMQppWA08q32AkX+YI1uCFjGpTb2S0eOFMyqIwEtHhc3Koo6cZTQVCgZlYn8T33qHjqaDpxrI
	WjPvCVXotgOj
X-Google-Smtp-Source: AGHT+IEB06iw8nq9dtjJMxJVEb1OCgjs1a1uwVd1Lb23kx+Ycmk377vAhGXyiE7sYPHT06gH5rZyKg==
X-Received: by 2002:a17:903:41c3:b0:21f:baa:80c1 with SMTP id d9443c01a7336-221040d74e3mr282537535ad.53.1739939776307;
        Tue, 18 Feb 2025 20:36:16 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536437asm97059385ad.72.2025.02.18.20.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 20:36:15 -0800 (PST)
Message-ID: <8d222fd0f26fdce0193047074e660abab19ffc32.camel@gmail.com>
Subject: Re: [PATCH v2 dwarves 2/4] btf_encoder: emit type tags for
 bpf_arena pointers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org, 
	bpf@vger.kernel.org
Cc: acme@kernel.org, alan.maguire@oracle.com, ast@kernel.org,
 andrii@kernel.org, 	mykolal@fb.com, kernel-team@meta.com
Date: Tue, 18 Feb 2025 20:36:11 -0800
In-Reply-To: <20250212201552.1431219-3-ihor.solodrai@linux.dev>
References: <20250212201552.1431219-1-ihor.solodrai@linux.dev>
	 <20250212201552.1431219-3-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-02-12 at 12:15 -0800, Ihor Solodrai wrote:

[...]

> diff --git a/btf_encoder.c b/btf_encoder.c
> index 965e8f0..3cec106 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c

[...]

> +static int btf__tag_bpf_arena_ptr(struct btf *btf, int ptr_id)
> +{
> +	const struct btf_type *ptr;
> +	int tagged_type_id;
> +
> +	ptr =3D btf__type_by_id(btf, ptr_id);
> +	if (!btf_is_ptr(ptr))
> +		return -EINVAL;
> +
> +	tagged_type_id =3D btf__add_type_attr(btf, BPF_ARENA_ATTR, ptr->type);
> +	if (tagged_type_id < 0)
> +		return tagged_type_id;
> +
> +	return btf__add_ptr(btf, tagged_type_id);
> +}

I might be confused, but this is a bit strange.
The type constructed here is: ptr -> type_tag -> t.
However, address_space is an attribute of a pointer, not a pointed type.
I think that correct sequence should be: type_tag -> ptr -> t.
This would make libbpf emit C declaration as follows:

  void * __attribute__((address_space(1))) ptr;

Instead of current:

  void __attribute__((address_space(1))) * ptr;

clang generates identical IR for both declarations:

  @ptr =3D dso_local global ptr addrspace(1) null, align 8

Thus, imo, this function should be simplified as below:

  static int btf__tag_bpf_arena_ptr(struct btf *btf, int ptr_id)
  {
	const struct btf_type *ptr;

	ptr =3D btf__type_by_id(btf, ptr_id);
	if (!btf_is_ptr(ptr))
		return -EINVAL;

	return btf__add_type_attr(btf, BPF_ARENA_ATTR, ptr_id);
  }

[...]


