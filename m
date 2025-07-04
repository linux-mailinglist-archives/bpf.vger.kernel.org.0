Return-Path: <bpf+bounces-62437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A07AF9B1E
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 21:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6FE11676C1
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 19:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85238214A79;
	Fri,  4 Jul 2025 19:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsS+uwoM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC33A2E3706
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 19:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751657027; cv=none; b=ou6tIddGuUshDAYJTXyTqCUMZHbwi2Ai5/JKQoguQQXFuatt1gTVEsuPdijyNF8sNtPJKZKjnPA2bjN2Me/EHtpBv2kfmwIdoPQXG83cnefDvFm6UTGjKE9JChrY+wa9F8mWd2dwYaY26916oGwRy/4CnjmFDn3usAyxujWig3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751657027; c=relaxed/simple;
	bh=9HAt1gdnN40gggIHOghbRpT3fhWn/xVVcU2WwPXYlr4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VAxXry/0LU3woE/HIZJytUt++jdfbUBIZmjaLUBIxYXDFm7mduelKzi/h6UhxgS5I1LXsBmojrrFqaLGkWnOp6zknAI5FJV1/ps8Z2CZ20pkOtwc+R2No//AakkpnL7ApvH8S9KDr/JnhfYmkhcMaxe/fAxWT0xRDDtLlYcjfzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsS+uwoM; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b31d578e774so1967525a12.1
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 12:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751657025; x=1752261825; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9HAt1gdnN40gggIHOghbRpT3fhWn/xVVcU2WwPXYlr4=;
        b=RsS+uwoM6LWkcYzowB2ZJ3KYfQeDPihxgaDdsG6pazi+7FrfsvS06d3DIcQuF8M2rK
         T4Mrn4Io6qk5JlKrxl7e1eF9Nmp62zhgVSxDEQTzk811t7n8WiqJTzN6bvrUxQ7Yg7t1
         Muy9HhixtLgcR0QIYTLo0nO9hZGVSp84QP/C8EXXlwaypiZoBpxeClDQvfUBqe/Y5Xtt
         HPsjDfYJ5yUfKzdwO0WNNv8sBGwuEXNYBJbUP2zpUepfzy3npfh62offwACrJaSH8zhf
         uumiLgQh/OViV71EdX28tdmEuNZxJ2xt8UXbchkYam91LC61MhuKDZUOc6wGkHgj+5bo
         nqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751657025; x=1752261825;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9HAt1gdnN40gggIHOghbRpT3fhWn/xVVcU2WwPXYlr4=;
        b=eZ94BIuSMCrRR04P0jJR0zNLGZGnyCSiXttXMruYsbuoNY778jMq62D48hBYuZm4CI
         vBuWWsurV6oIFxZppztIqc77gd9aMICVWk2GqAA45nNmdDv4jyy5WAX81N3pcDHWH90z
         rZPUxMtmBF76bTc/ACquY6PdNfdJU6WfN2mvu55Qgzb7imf51fjRaqvSJk09Im7Nvanr
         C+g2uIACW3HkJlBPcu2GVCagDApfEmF8Fd1EPExHgLiNhRqxBYHPut0mhYVLa1VC25bN
         88MWe3IVfelIulhtbiK+D0c3eUjERrGLJOn1dEBXW+jDNCd4dFXtw+MDQY5OYZ/4SoSW
         IYkg==
X-Forwarded-Encrypted: i=1; AJvYcCVJXS113iElBEzOTR0v0GKROPv8uQF7oM7rvSqrEzStHjYKba+WIaVXXZNOGEQPj4fU7WM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMg+92ELAjYjz6Gq+3DwMjgCtLzdReVggqICFdFOqmkE1fdymE
	+5Fgt9TACU4JMiA5cTv9IZQcAFjsvElaYQ6GjaTTaJhq6S5s1BodZxXV
X-Gm-Gg: ASbGnctKoJdwKQV6E+4nE2QhFZGkDtzZirZGb3zzu57NClD3tmdK7f5w21KncfeSTOP
	k2jqh/1wF5PwOWC68HDhAfED29QR7gFt7cQ1vLBIvYoro2L5JNBnnxwQNgwqVmIWLOddSNtx4Tz
	/ESurcX+ZCSqHyYYB0mStam4xICeDsGU8mZmW/r3kDfc3UY+E0PxKZMYjTj7q/zgENe6ZGAAt1T
	2WGj+SUNw2R/T2ee0yG8MGj8gMkAXd3l4oR06nuJ+U9HWZtHn4GwyIOj69GbvSyvfZLqDxOtOFG
	Rm/8NWRa8iDBYEpay6+YaxGZ6RRZ6Qbfenhar+24OnU5rJGfapb6UJaRoQ==
X-Google-Smtp-Source: AGHT+IEKS3w2visBzJG/GyvTKdb9OG7nuizuaQ9ZUzEu0TpWqjaJIBfvPSCQVv3U4RY2P8ao16liBQ==
X-Received: by 2002:a17:90b:33d1:b0:30e:3737:7c87 with SMTP id 98e67ed59e1d1-31aab854dadmr6022155a91.5.1751657025072;
        Fri, 04 Jul 2025 12:23:45 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8431a1f0sm27567315ad.32.2025.07.04.12.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 12:23:44 -0700 (PDT)
Message-ID: <e5acf74c70f6aa01ca7be4c0afce9dd6a20a910e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 4/8] bpf: attribute __arg_untrusted for
 global function parameters
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Matt Bobrowski <mattbobrowski@google.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, 	kernel-team@fb.com, yonghong.song@linux.dev, Alexei
 Starovoitov	 <alexei.starovoitov@gmail.com>
Date: Fri, 04 Jul 2025 12:23:43 -0700
In-Reply-To: <CAP01T74_diwrEB0D=LOqVGQTGjiETm65cqh3zZEL5S5EkTYaZQ@mail.gmail.com>
References: <20250702224209.3300396-1-eddyz87@gmail.com>
	 <20250702224209.3300396-5-eddyz87@gmail.com>
	 <CAP01T74AYNX5ARJ5YXryUyKvn5o0Dv0JBoq3CCKcD8rh==uKQA@mail.gmail.com>
	 <fb5b8613584dbce72359e44ef3974e4cb7c8298e.camel@gmail.com>
	 <de7f3a2c5bc521c1111b0ed1870291c0889e4757.camel@gmail.com>
	 <CAP01T75+cXUv4Je+bYQNb-Us_MF1s1Zc9fL0wmowLExKUQ8KNg@mail.gmail.com>
	 <a8f522a0e9eaf060727b7782d700f998efaa757c.camel@gmail.com>
	 <CAP01T74_diwrEB0D=LOqVGQTGjiETm65cqh3zZEL5S5EkTYaZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-07-04 at 21:15 +0200, Kumar Kartikeya Dwivedi wrote:

[...]

> Yeah, so if the user specifies a type and has co-re enabled, they're
> accessing a kernel struct.
> If they're doing it without co-re, it's broken today already, or they
> know the struct is fixed in layout somehow so it's ok.
> If not, they want to access things at fixed offsets. So we can just
> use the type they're using to model untrusted derefs.
>=20
> So always using prog BTF makes sense to me.

Ok, I'm switching to always using prog BTF.

