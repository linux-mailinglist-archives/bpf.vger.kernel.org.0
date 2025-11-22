Return-Path: <bpf+bounces-75282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEFCC7C128
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 02:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 64FC234A3AB
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 01:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBFF1F09AD;
	Sat, 22 Nov 2025 01:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZL4VFDU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435A62BAF4
	for <bpf@vger.kernel.org>; Sat, 22 Nov 2025 01:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763774001; cv=none; b=V5fFwF+DMKnsAL8vNvCy5fLK8v75nYOIvcFZulfuEi4MDPHfgciOF8Gs3MqQEhAp9ROA5RxnzEkvF7q0asMC1N4fVALRs4/6LTt4Ok5ieqVaWo2+BOG1ULYIuc9dWMqGsy3WyXDcJgXheHePTDi9sSf6wgviFB5+Snzm7Q6C1QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763774001; c=relaxed/simple;
	bh=saP4U5WhwlXVToCCAufwLLzNHnfjLxtTvbXL7C7/9I4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LGRcgB56JILgDMegvZmgrpnyAF7ZtQXJ/BrvyeNdarWv/cpY2Nj/6U6nDYsC/raHXsS7o6Ehw3oBw82sWy/u9uGnThUSISYRRKN5LkuFB0unNSh6sAqJxNhZyNT8Ohzy3s1wOElQdNIlTo7ZukmkiiwyH+UAlyObk+7QRF19o6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZL4VFDU; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so2884813b3a.1
        for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 17:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763773997; x=1764378797; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=saP4U5WhwlXVToCCAufwLLzNHnfjLxtTvbXL7C7/9I4=;
        b=MZL4VFDUVF2XUuut7Eycu2BwuilcgJ6aSQHDRyAexb3TvoDS43XeGcaLR5Vw7SRHJr
         UqhvjMZz4XFbOu4IEIj3Fop+bUJlQwgN81/JhfX93TT8eMINaKgGeblu+oTecewRaXp8
         ST5DjwED2OFMi6rCqSqIgTlrNYnY+s/vtyfU8y5ZsskQoYQWjNyrFGk1CCHRs81ZT2Ox
         9nVwR0SCNHiCIoSdcyDYVTqyDBcyHcNPvbAsrTnudX4ERxEIBc+Siuzv1G9h4jTEpKqu
         Mw2fY1qobKIzgfLEvlIgo0DHVMlB8uKPmvYPeXEO3dHz9RjB4Ld1rizJigBDLU5nu1xf
         EulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763773997; x=1764378797;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=saP4U5WhwlXVToCCAufwLLzNHnfjLxtTvbXL7C7/9I4=;
        b=RBCdsQEWoFKhLuxXcgC0H4MxLLAXa6gP/HxA/WqMB8zaNe7lIRPLxgznMghLhPFKzI
         18jIkcLZfPmo0xjYFHt/ynaJlQUfze0fSPJcI0vrYLLoUfcSlRf4zSx1oAeOfpiLFJcn
         6ruhlu6nWdRJoexnDhRJCvfVF5EalY8Nciorvtc8UVARKsnhpYD3A76m04Cox1SDksmo
         mRIb7DLQtFa3F+AjbQnj67IWN7zR/fFTK0Dnp8zY/AO4VgqCSDmLE46yC46+CnGf+z6K
         kukpmadMglwldKKV5pX2/nlfO3zzl4X1xVcXQxsVtA53kHZRbR1EZM8UdiZNigyxwfQb
         Baug==
X-Forwarded-Encrypted: i=1; AJvYcCXufnoax02bA5MNh9vKdh5T+uhWpNWRjvbi9DsqS23KiSiJJ6L2J0T99aG8rhYnDlY7tx4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvf0GJYYUHeeMsNmZ1A7JbZTQedq/KVzXQC6mcHmQLn2L1pzW3
	P+Ew+OYPF69XKNe/QnwQ5qI20oSecF0DOps4SIbq0W6UcSNOgrjTvSDc
X-Gm-Gg: ASbGncs4H4PyP6I5VFMsSNVFh9RSJfjXyyoEpNKAD9Dp4DZtITaEQkRZX2br5Gn5Zfg
	8lkRYXhi8ypxSRvao6mTJ1F15sdo7JkgzUCEyyrVEsYzNq0qyGuOvL5vN3PpzGhQ5/k5iqAhN1W
	KVXgwchQMkakvhPPoKrq5TJk+2StbhD6hmj9J8+4/msZKANcNXyQyip+X7PO+xHqWsBzDodZM36
	Amoeq0UzAP9CxrRS49kT+ODtnF1+16QwINmef7jE3ER+hgSOod4YEk2SyANBV4DEtN+XYeZF3k8
	8tOLYMNXfplEPFKoTMpWHmL8655oFoRqMNd3yynFAkxXV/ox8UZxu6i+SjpPo+DfpGOR4wXvBql
	NdcSJ6reRBrMv9EE5OgmlmHxxXNVUl5Ham8jDSErBW4mgAmNfSkBnnlh9qxQM9Zn7X1eSq/Rks7
	i/FxSlDU0=
X-Google-Smtp-Source: AGHT+IGIIcLGKXwyxuZlN6zxJg+WkVgPCE2c4e1rlk/IN7KLg5Hz52zlgmkpzsDz9+2o01MH/tdE/g==
X-Received: by 2002:a05:6a00:3983:b0:7ac:78d6:5f00 with SMTP id d2e1a72fcca58-7c58effc48emr4683334b3a.31.1763773997302;
        Fri, 21 Nov 2025 17:13:17 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ed47b388sm7349609b3a.27.2025.11.21.17.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 17:13:16 -0800 (PST)
Message-ID: <9cb294bb7d786f8ac3b55a2593fb15e76b5d9696.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: support nested rcu critical
 sections
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko	
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau	 <martin.lau@kernel.org>, Puranjay Mohan <puranjay12@gmail.com>, 
	kernel-team@fb.com
Date: Fri, 21 Nov 2025 17:13:14 -0800
In-Reply-To: <20251117200411.25563-2-puranjay@kernel.org>
References: <20251117200411.25563-1-puranjay@kernel.org>
	 <20251117200411.25563-2-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-11-17 at 20:04 +0000, Puranjay Mohan wrote:
> Currently, nested rcu critical sections are rejected by the verifier and
> rcu_lock state is managed by a boolean variable. Add support for nested
> rcu critical sections by make active_rcu_locks a counter similar to
> active_preempt_locks. bpf_rcu_read_lock() increments this counter and
> bpf_rcu_read_unlock() decrements it, MEM_RCU -> PTR_UNTRUSTED transition
> happens when active_rcu_locks drops to 0.
>=20
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

