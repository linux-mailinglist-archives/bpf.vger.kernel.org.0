Return-Path: <bpf+bounces-59830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 155FEACFB5A
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 04:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93B9218991EE
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 02:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3734199E9D;
	Fri,  6 Jun 2025 02:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AI8ViTLq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322901DFCE
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 02:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749177968; cv=none; b=YWfGHmzv9mjZG53umWF1iXqdlOuyZHqvjy7AXyRSwQ7XCHdhYMniLEjkPx/Le+N6ChfXk+vtM2s0DGo4ghZaB+ObZ74MqzoeDSv2HT9EkuUkMNQgRBJDKqHwFl4z15zce2tvJwFL+M/skfp0Cauf8a0CDHm9txr8s3C+e5US8Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749177968; c=relaxed/simple;
	bh=FGKkzlgkU/IM2JE8mXiwZXhG4wK4Nky01ASNIBPIZo4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ClG3MMqIg8oz072UqO66YGlXPvMasWNxJVd70XPCHx+1T/D27n/QOc71NkJV6UKTXuWPMtfKVpAdU73e6Qld745k2BWrYVM03WOyMmS1JSGocjDdboeaWwlaCA7Cf+uv0tKimW7LLmAb/g3SqyWaQv+oYUkI0R69p6/Utsa4s2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AI8ViTLq; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-747fc77bb2aso1384251b3a.3
        for <bpf@vger.kernel.org>; Thu, 05 Jun 2025 19:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749177966; x=1749782766; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FGKkzlgkU/IM2JE8mXiwZXhG4wK4Nky01ASNIBPIZo4=;
        b=AI8ViTLq9JjMx/kiWdVR0mvt/QEpC2qwQMlwZJEIsW7Xjsoxn8fA11b2xMJUQGZXNQ
         vf3YCyhy6DWmrLqrE7DB3/doEO+Jk0yNBHA2NpM7pocg5hANbdCvG4D1EqWJ//n1UF7A
         UFmzkodS0jK6GWKvu0Dtxngk1Kj7nMG9oYDDLh1XrEpdg2Q8O8oQDyILG57TpgvGJyPo
         QlIyOXZjIQgnGLqa9FWLB4S+hOkdaic1inI0Q07gS3pX5BA0jwjcUoJ1L5xFoqHNncp2
         xMCYrwZX/G7IT5mlMBymEhcG2mtHqf4UbwFQJcf2SXhNFTepCKtrxiV3jJ7nANfy+I7c
         Qwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749177966; x=1749782766;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FGKkzlgkU/IM2JE8mXiwZXhG4wK4Nky01ASNIBPIZo4=;
        b=LdljKX0gnP+E5V9YaHI+UB1pVoiOmc/V5OoOPwytaEeRmwvRvRGcVVN3bcI/mEfW39
         KcT3Xw/Swkjy3Sa8YYYGto8Hh2cRME58YuJX4k9H+gsUYXX06yBeOgtsqGsj5XIT1ieC
         VlaonecxSwiwPwAF4WBYXXlR3yzBk6vNxEFHX4WjB4wrtTrhzVv6tA9dD37MJJbZMnPy
         F7FF9gvHOqFg6hWuYdNnLrmzCpCN/yqFIRa3eUMDh75Ogfdkl7PERfOu4Yih/ogK2B4k
         4lWfiBy/XamY4n3MKGGOa66J/WUKTdc+KBM16uY68vjirjkIFAHdxO4ypRKZCcKnoaa7
         wRJQ==
X-Gm-Message-State: AOJu0Yx26juyf7KAyAQR1n/yMwD1nbyCb0ViJ+QMXwqNAnQrdL7KAgSP
	P14T5rsxr3OFLsNn+zwksPk1o3tiBCjTE3QiyIC5NYr3PFKCU51vzrFj
X-Gm-Gg: ASbGncsKFfn/r3KR2HA0tr2I+2m7UKBA/79iXrDtpv6G9xv8LY1xLMRSpiWwJAxiUzw
	asBLoIA3gONceXSATcOnbtiSGNM9wrZdF3Fp6eDMwSnsvjO0IGGGMcrU8RgJfoymflrIiyoG2k4
	YvEij1WxVqnozee/YqSvoPcoUjSxCCVtX2idX4PZV8sHBEL+OTS9/DniinQCha8uyG6cHXrOZzF
	oUMSNsjyqY2Kk8vnsC7Eqm+rwsL3p67alMV1oztLc1gvasD9v0GivaQDSD88+SqFthOs4HbnbCX
	3zWxNfbe4GSMFzwfqGE2iK3Swsw3GXYt/wpAvOTRgGsymg9YazVdzYHzAw==
X-Google-Smtp-Source: AGHT+IFp/PQijTAeTD5RAhT9TKDgAN9/cnfYVGMyUFOrrtZxksqTnu/XN5xcFT3e3DG3GEv4bzmG4w==
X-Received: by 2002:a05:6a00:488b:b0:748:2eb7:8cc7 with SMTP id d2e1a72fcca58-7482eb793b6mr287236b3a.21.1749177966443;
        Thu, 05 Jun 2025 19:46:06 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b083908sm336406b3a.76.2025.06.05.19.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 19:46:06 -0700 (PDT)
Message-ID: <ef717b35baef4a9fb2d3a8b751a89106b146c816.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] veristat: memory accounting for bpf
 programs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song	 <yonghong.song@linux.dev>
Date: Thu, 05 Jun 2025 19:46:04 -0700
In-Reply-To: <CAADnVQ+N2A9+vuR5kc1m6h8-q7Kx4Y4dvhS6fn2tfLSKEWWOVg@mail.gmail.com>
References: <20250605230609.1444980-1-eddyz87@gmail.com>
	 <20250605230609.1444980-3-eddyz87@gmail.com>
	 <8bf346133b103ee586f7ffd1a47572f9ee000704.camel@gmail.com>
	 <CAADnVQKsfQSM76q88o38GboUrSuts9xEYAMZ=36AUCcrwG34Jg@mail.gmail.com>
	 <d4bc026d37fc75f986abe276f2650feff0d4ad70.camel@gmail.com>
	 <CAADnVQ+N2A9+vuR5kc1m6h8-q7Kx4Y4dvhS6fn2tfLSKEWWOVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-06-05 at 19:35 -0700, Alexei Starovoitov wrote:

[...]

> > Things that might be reusable:
> > - get_root_cgroup
> > - remove_cgroup
> > - join_root_cgroup
> > - join_cgroup
> >=20
> > These rely on CGROUP_MOUNT_PATH and CGROUP_WORK_DIR being constants,
> > I'll need to modify these helpers to parameterize this.
>=20
> ok. ignore that suggestion then.
> do what is simplest.

I think I'll add some struct to denote cgroup context and adapt the
above utility functions. Should be useful.


