Return-Path: <bpf+bounces-62768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD95AFE2D8
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 10:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 569CA4E6768
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 08:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670FD27EFE9;
	Wed,  9 Jul 2025 08:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jj0LDM4i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9E127B4FC
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 08:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752050292; cv=none; b=c5mYI+FvkNSyUwhtLcMeBNrpZoOLVG0xfXKiCOYRggCMJU6AqbAvJ/Unp3seAeuO769bvGzNyYn/KKI90L2sXcBzvYoz+VqYdzv8iW4siQZv6Tph1W4N3RDaSbuL4rEiMt2i5OIESRKk5WSHfGQ7iI83hZhC12hRw/n9HAhMfUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752050292; c=relaxed/simple;
	bh=M3zK0s7h2A0jFAlj0DciFNrcNiGE9jA+QTCtoZ0cJCc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ioPtOl8HYKqwNFosmUrzvnfvAYB4S5jTW3uS7HJVlaSLu2pvOXpP5SmIEY0xUggyos6WJfaHbv8XPlHZOaI/emoRP0AkPFEPDiKsQV6XF7T7NdE7AQ28PmdHB6FRWUCedPFzVsvIxZrg1/cRf58cyYUthr8WIAB1d0VzrCbHob8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jj0LDM4i; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23694cec0feso47021955ad.2
        for <bpf@vger.kernel.org>; Wed, 09 Jul 2025 01:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752050289; x=1752655089; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Zzcc1R+Y5yEh2ypM+8FWTO7V0dvlDTHZeD1FGhQdqqk=;
        b=Jj0LDM4iwqQqNM7Jhqw4SpnyqpIzhxoRm/TOmD6rVk5KJK7gppvU/MKM5VUGMJJC3/
         p+SLu8qW0VFPI7yYaVsN4YPsd0NTkM9Pm1QwOg9ZSSXlnxrINynB4oXj04foGV0B+JKG
         DCN42+iU8bqN08/0dUq0dyO9uv5ifGFxDDRP8h2+qyYmNmDpIaOXDl6uwERjNNtJfyIS
         lcD8WoXU+6fiRW51nOaVsiEHCp6x9eAMYmcAwAj7X0vbwI6Mw5zR97XMHWHp9CJsda6P
         FPL3GrGeacyh+9HZC1yuOjV7Lmb862dNgrY+pa71Y6SuxhFP6XjqLLIWYKM529H4BDSy
         fffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752050289; x=1752655089;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zzcc1R+Y5yEh2ypM+8FWTO7V0dvlDTHZeD1FGhQdqqk=;
        b=Aja4JRS6PFt8K3PEx4OOfjTADx2w77cJtWJ4xjI0pPSm9x/4R2Zuq2fg7eqb1SmzqK
         F3Hp3JlCyaAQBboQVqepm8MwvUbBCfd5khcR/QgTRQ/oRXAisKkZgacNcVWmEwialoT/
         qxZCwJLu1OK2zPRY8/bXNddbjw9ZcZL1jTiPr593+eDd8AsnjGSvprvfiNOLBmnRx57X
         NF1ICPePXzf3QPeqRhxegI98gpJ1edq8e2ir83s366PD8RXaX7cHLu2JsykcoieNnU3N
         /ZNWfkxVL4VqtZqS7qJnxPjjp2cYOG/y1iGig3lYsTFLGTY5h2rWuN6MRRGPi2rteHk7
         /Qmw==
X-Forwarded-Encrypted: i=1; AJvYcCV1G41CdffSfBvkBWhJVdf+RUVVcDQ+c2798K0uxdIeMpGrYkVF6ZFfwfqBCFXFhtCnG/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhzs2fOsrCkedyvbr1bDSdrVl8O+93QY0kLC6vwkIChcMf9fVV
	vdib5EoDIev4b/78021Q0qeqavJJ6sxWXDFyEjihBACxyCMDyh8gPyHlAuSrLhAy
X-Gm-Gg: ASbGncspOP7QwBV9xmNvdNqurzG6OphDt5qsjizB3KR/v4XBMyCSFxb9+CwNMeJdyF8
	7ozMLo9IWkPLv7j1Yrb9m6sXRtIJF7cuJ6hJ7ZtW//twuHugNA1vt2awZ6x+6oOghPC8Pmo3s/N
	lLMANVLYj4f8NWOSSB8Xwp/MFyPOaNmKOaCXvPyD3QQd0JD4V3YDdK7Vhqq2bRMrB93cJ90fUa2
	2lH5sRIPzUeWpLN8SakGx2hFXZrtzsNqd1RE9tupD2qNiA0VAA0oiyiz3rgYNKXUtsN+5doFezx
	6f5yXu7D3ifRxKiQ9kU0FmZ1fa2GP9rhZzlFzRnqsoq5lP4SOatlQDU7QhahT1jo93qL
X-Google-Smtp-Source: AGHT+IFIiYPtGYJd6WoSL7Ah9HNG1bSmgCQPtUzto0gF1F6ma1z4+x6nZltsMM+vq9SU+MEXyTrgsQ==
X-Received: by 2002:a17:903:2f4b:b0:234:d679:72e3 with SMTP id d9443c01a7336-23ddb337bd3mr29520255ad.42.1752050289411;
        Wed, 09 Jul 2025 01:38:09 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c84582333sm128851835ad.186.2025.07.09.01.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 01:38:08 -0700 (PDT)
Message-ID: <f38d1a6ff69991230b929f2cad5776f500a2a57c.camel@gmail.com>
Subject: Re: [RFC bpf-next 8/9] libbpf: support llvm-generated indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf
 <bpf@vger.kernel.org>,  Alexei Starovoitov	 <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Anton Protopopov	 <aspsk@isovalent.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Quentin Monnet	 <qmo@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>
Date: Wed, 09 Jul 2025 01:38:06 -0700
In-Reply-To: <f90ea7ec00265ab842e373a69f0ffdbb374f7614.camel@gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
		 <20250615085943.3871208-9-a.s.protopopov@gmail.com>
		 <CAADnVQKhVyh4WqjUgxYLZwn5VMY6hSMWyLoQPxt4TJG1812DcA@mail.gmail.com>
		 <690335c5969530cb96ed9b968ce7371fb1f0228a.camel@gmail.com>
		 <aG3/MWCOwdk5z0mp@mail.gmail.com>
	 <f90ea7ec00265ab842e373a69f0ffdbb374f7614.camel@gmail.com>
Content-Type: multipart/mixed; boundary="=-IMVcChg8AWwAkTkyWgqP"
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-IMVcChg8AWwAkTkyWgqP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-07-08 at 22:58 -0700, Eduard Zingerman wrote:

[...]

> This seems to work:
> https://github.com/eddyz87/llvm-project/tree/separate-jumptables-section.=
1

Pushed an update:
- correct offsets computation;
- avoid relocations in the .jumptables section.

Here is how it looks now (updated session.log attached):

  foo:                                    # @foo
  # %bb.0:                                # %entry
  	w1 =3D *(u32 *)(r1 + 0)
  	if w1 > 31 goto LBB0_2
  # %bb.1:                                # %entry
  .LJTI0_0:
  	.reloc 0, FK_SecRel_8, .BPF.JT.0.0
  	gotox r1
  	goto LBB0_2
  LBB0_7:
  	w1 =3D 2
  	goto LBB0_3
        ...
  .Lfunc_end0:
  	.size	foo, .Lfunc_end0-foo

  	.section	.jumptables,"",@progbits
  .L0_0_set_7 =3D LBB0_7-.LJTI0_0
  .L0_0_set_2 =3D LBB0_2-.LJTI0_0
  .L0_0_set_8 =3D LBB0_8-.LJTI0_0
  .L0_0_set_9 =3D LBB0_9-.LJTI0_0
  .L0_0_set_10 =3D LBB0_10-.LJTI0_0
  .BPF.JT.0.0:
  	.long	.L0_0_set_7
  	.long	.L0_0_set_2
  	.long	.L0_0_set_2
  	.long	.L0_0_set_2
  	.long	.L0_0_set_2
        ...

I think this is a correct form, further changes should be LLVM
internal.

--=-IMVcChg8AWwAkTkyWgqP
Content-Disposition: attachment; filename="session.log"
Content-Transfer-Encoding: base64
Content-Type: text/x-log; name="session.log"; charset="UTF-8"

JCBjYXQganVtcC10YWJsZS10ZXN0LmMKCmludCBiYXIoaW50IHYpOwoKaW50IGZvbyhzdHJ1Y3Qg
c2ltcGxlX2N0eCAqY3R4KQp7CglpbnQgcmV0X3VzZXI7CgogICAgICAgIHN3aXRjaCAoY3R4LT54
KSB7CiAgICAgICAgY2FzZSAwOgogICAgICAgICAgICAgICAgcmV0X3VzZXIgPSAyOwogICAgICAg
ICAgICAgICAgYnJlYWs7CiAgICAgICAgY2FzZSAxMToKICAgICAgICAgICAgICAgIHJldF91c2Vy
ID0gMzsKICAgICAgICAgICAgICAgIGJyZWFrOwogICAgICAgIGNhc2UgMjc6CiAgICAgICAgICAg
ICAgICByZXRfdXNlciA9IDQ7CiAgICAgICAgICAgICAgICBicmVhazsKICAgICAgICBjYXNlIDMx
OgogICAgICAgICAgICAgICAgcmV0X3VzZXIgPSA1OwogICAgICAgICAgICAgICAgYnJlYWs7CiAg
ICAgICAgZGVmYXVsdDoKICAgICAgICAgICAgICAgIHJldF91c2VyID0gMTk7CiAgICAgICAgICAg
ICAgICBicmVhazsKICAgICAgICB9CgogICAgICAgIHN3aXRjaCAoYmFyKHJldF91c2VyKSkgewog
ICAgICAgIGNhc2UgMToKICAgICAgICAgICAgICAgIHJldF91c2VyID0gNTsKICAgICAgICAgICAg
ICAgIGJyZWFrOwogICAgICAgIGNhc2UgMTI6CiAgICAgICAgICAgICAgICByZXRfdXNlciA9IDc7
CiAgICAgICAgICAgICAgICBicmVhazsKICAgICAgICBjYXNlIDI3OgogICAgICAgICAgICAgICAg
cmV0X3VzZXIgPSAyMzsKICAgICAgICAgICAgICAgIGJyZWFrOwogICAgICAgIGNhc2UgMzI6CiAg
ICAgICAgICAgICAgICByZXRfdXNlciA9IDM3OwogICAgICAgICAgICAgICAgYnJlYWs7CiAgICAg
ICAgY2FzZSA0NDoKICAgICAgICAgICAgICAgIHJldF91c2VyID0gNzc7CiAgICAgICAgICAgICAg
ICBicmVhazsKICAgICAgICBkZWZhdWx0OgogICAgICAgICAgICAgICAgcmV0X3VzZXIgPSAxMTsK
ICAgICAgICAgICAgICAgIGJyZWFrOwogICAgICAgIH0KCiAgICAgICAgcmV0dXJuIHJldF91c2Vy
Owp9CgokIGNsYW5nIC0tdGFyZ2V0PWJwZiAtTzIgLVMgLW8gLSBqdW1wLXRhYmxlLXRlc3QuYwoJ
LnRleHQKCS5nbG9ibAlmb28gICAgICAgICAgICAgICAgICAgICAgICAgICAgICMgLS0gQmVnaW4g
ZnVuY3Rpb24gZm9vCgkucDJhbGlnbgkzCgkudHlwZQlmb28sQGZ1bmN0aW9uCmZvbzogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjIEBmb28KIyAlYmIuMDogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICMgJWVudHJ5Cgl3MSA9ICoodTMyICopKHIxICsgMCkKCWlmIHcx
ID4gMzEgZ290byBMQkIwXzIKIyAlYmIuMTogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICMgJWVudHJ5Ci5MSlRJMF8wOgoJLnJlbG9jIDAsIEZLX1NlY1JlbF84LCAuQlBGLkpULjAuMAoJ
Z290b3ggcjEKCWdvdG8gTEJCMF8yCkxCQjBfNzoKCXcxID0gMgoJZ290byBMQkIwXzMKTEJCMF85
OiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMgJXN3LmJiMgoJdzEgPSA0Cglnb3Rv
IExCQjBfMwpMQkIwXzg6ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIyAlc3cuYmIx
Cgl3MSA9IDMKCWdvdG8gTEJCMF8zCkxCQjBfMTA6ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAjICVzdy5iYjMKCXcxID0gNQoJZ290byBMQkIwXzMKTEJCMF8yOiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICMgJXN3LmRlZmF1bHQKCXcxID0gMTkKTEJCMF8zOiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICMgJXN3LmVwaWxvZwoJY2FsbCBiYXIKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMga2lsbDogZGVmICR3MCBraWxsZWQgJHcw
IGRlZiAkcjAKCXcwICs9IC0xCglpZiB3MCA+IDQzIGdvdG8gTEJCMF81CiMgJWJiLjQ6ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAjICVzdy5lcGlsb2cKLkxKVEkwXzE6CgkucmVsb2Mg
MCwgRktfU2VjUmVsXzgsIC5CUEYuSlQuMC4xCglnb3RveCByMAoJZ290byBMQkIwXzUKTEJCMF8x
MToKCXcwID0gNQoJZ290byBMQkIwXzYKTEJCMF81OiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICMgJXN3LmRlZmF1bHQ5Cgl3MCA9IDExCglnb3RvIExCQjBfNgpMQkIwXzEzOiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIyAlc3cuYmI2Cgl3MCA9IDIzCglnb3RvIExCQjBf
NgpMQkIwXzEyOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIyAlc3cuYmI1Cgl3MCA9
IDcKCWdvdG8gTEJCMF82CkxCQjBfMTQ6ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAj
ICVzdy5iYjcKCXcwID0gMzcKCWdvdG8gTEJCMF82CkxCQjBfMTU6ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAjICVzdy5iYjgKCXcwID0gNzcKTEJCMF82OiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICMgJXN3LmVwaWxvZzEwCglleGl0Ci5MZnVuY19lbmQwOgoJLnNpemUJ
Zm9vLCAuTGZ1bmNfZW5kMC1mb28KCS5zZWN0aW9uCS5qdW1wdGFibGVzLCIiLEBwcm9nYml0cwou
TDBfMF9zZXRfNyA9IExCQjBfNy0uTEpUSTBfMAouTDBfMF9zZXRfMiA9IExCQjBfMi0uTEpUSTBf
MAouTDBfMF9zZXRfOCA9IExCQjBfOC0uTEpUSTBfMAouTDBfMF9zZXRfOSA9IExCQjBfOS0uTEpU
STBfMAouTDBfMF9zZXRfMTAgPSBMQkIwXzEwLS5MSlRJMF8wCi5CUEYuSlQuMC4wOgoJLmxvbmcJ
LkwwXzBfc2V0XzcKCS5sb25nCS5MMF8wX3NldF8yCgkubG9uZwkuTDBfMF9zZXRfMgoJLmxvbmcJ
LkwwXzBfc2V0XzIKCS5sb25nCS5MMF8wX3NldF8yCgkubG9uZwkuTDBfMF9zZXRfMgoJLmxvbmcJ
LkwwXzBfc2V0XzIKCS5sb25nCS5MMF8wX3NldF8yCgkubG9uZwkuTDBfMF9zZXRfMgoJLmxvbmcJ
LkwwXzBfc2V0XzIKCS5sb25nCS5MMF8wX3NldF8yCgkubG9uZwkuTDBfMF9zZXRfOAoJLmxvbmcJ
LkwwXzBfc2V0XzIKCS5sb25nCS5MMF8wX3NldF8yCgkubG9uZwkuTDBfMF9zZXRfMgoJLmxvbmcJ
LkwwXzBfc2V0XzIKCS5sb25nCS5MMF8wX3NldF8yCgkubG9uZwkuTDBfMF9zZXRfMgoJLmxvbmcJ
LkwwXzBfc2V0XzIKCS5sb25nCS5MMF8wX3NldF8yCgkubG9uZwkuTDBfMF9zZXRfMgoJLmxvbmcJ
LkwwXzBfc2V0XzIKCS5sb25nCS5MMF8wX3NldF8yCgkubG9uZwkuTDBfMF9zZXRfMgoJLmxvbmcJ
LkwwXzBfc2V0XzIKCS5sb25nCS5MMF8wX3NldF8yCgkubG9uZwkuTDBfMF9zZXRfMgoJLmxvbmcJ
LkwwXzBfc2V0XzkKCS5sb25nCS5MMF8wX3NldF8yCgkubG9uZwkuTDBfMF9zZXRfMgoJLmxvbmcJ
LkwwXzBfc2V0XzIKCS5sb25nCS5MMF8wX3NldF8xMAoJLnNpemUJLkJQRi5KVC4wLjAsIDEyOAou
TDBfMV9zZXRfMTEgPSBMQkIwXzExLS5MSlRJMF8xCi5MMF8xX3NldF81ID0gTEJCMF81LS5MSlRJ
MF8xCi5MMF8xX3NldF8xMiA9IExCQjBfMTItLkxKVEkwXzEKLkwwXzFfc2V0XzEzID0gTEJCMF8x
My0uTEpUSTBfMQouTDBfMV9zZXRfMTQgPSBMQkIwXzE0LS5MSlRJMF8xCi5MMF8xX3NldF8xNSA9
IExCQjBfMTUtLkxKVEkwXzEKLkJQRi5KVC4wLjE6CgkubG9uZwkuTDBfMV9zZXRfMTEKCS5sb25n
CS5MMF8xX3NldF81CgkubG9uZwkuTDBfMV9zZXRfNQoJLmxvbmcJLkwwXzFfc2V0XzUKCS5sb25n
CS5MMF8xX3NldF81CgkubG9uZwkuTDBfMV9zZXRfNQoJLmxvbmcJLkwwXzFfc2V0XzUKCS5sb25n
CS5MMF8xX3NldF81CgkubG9uZwkuTDBfMV9zZXRfNQoJLmxvbmcJLkwwXzFfc2V0XzUKCS5sb25n
CS5MMF8xX3NldF81CgkubG9uZwkuTDBfMV9zZXRfMTIKCS5sb25nCS5MMF8xX3NldF81CgkubG9u
ZwkuTDBfMV9zZXRfNQoJLmxvbmcJLkwwXzFfc2V0XzUKCS5sb25nCS5MMF8xX3NldF81CgkubG9u
ZwkuTDBfMV9zZXRfNQoJLmxvbmcJLkwwXzFfc2V0XzUKCS5sb25nCS5MMF8xX3NldF81CgkubG9u
ZwkuTDBfMV9zZXRfNQoJLmxvbmcJLkwwXzFfc2V0XzUKCS5sb25nCS5MMF8xX3NldF81CgkubG9u
ZwkuTDBfMV9zZXRfNQoJLmxvbmcJLkwwXzFfc2V0XzUKCS5sb25nCS5MMF8xX3NldF81CgkubG9u
ZwkuTDBfMV9zZXRfNQoJLmxvbmcJLkwwXzFfc2V0XzEzCgkubG9uZwkuTDBfMV9zZXRfNQoJLmxv
bmcJLkwwXzFfc2V0XzUKCS5sb25nCS5MMF8xX3NldF81CgkubG9uZwkuTDBfMV9zZXRfNQoJLmxv
bmcJLkwwXzFfc2V0XzE0CgkubG9uZwkuTDBfMV9zZXRfNQoJLmxvbmcJLkwwXzFfc2V0XzUKCS5s
b25nCS5MMF8xX3NldF81CgkubG9uZwkuTDBfMV9zZXRfNQoJLmxvbmcJLkwwXzFfc2V0XzUKCS5s
b25nCS5MMF8xX3NldF81CgkubG9uZwkuTDBfMV9zZXRfNQoJLmxvbmcJLkwwXzFfc2V0XzUKCS5s
b25nCS5MMF8xX3NldF81CgkubG9uZwkuTDBfMV9zZXRfNQoJLmxvbmcJLkwwXzFfc2V0XzUKCS5s
b25nCS5MMF8xX3NldF8xNQoJLnNpemUJLkJQRi5KVC4wLjEsIDE3NgogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIyAtLSBFbmQgZnVuY3Rpb24KCS5hZGRyc2lnCgokIGNs
YW5nIC0tdGFyZ2V0PWJwZiAtTzIgLWMgLW8ganVtcC10YWJsZS10ZXN0Lm8ganVtcC10YWJsZS10
ZXN0LmMKJCBsbHZtLXJlYWRlbGYgLXIgLS1zeW1ib2xzIC0tc2VjdGlvbnMganVtcC10YWJsZS10
ZXN0Lm8KU2VjdGlvbiBIZWFkZXJzOgogIFtOcl0gTmFtZSAgICAgICAgICAgICAgVHlwZSAgICAg
ICAgICAgIEFkZHJlc3MgICAgICAgICAgT2ZmICAgIFNpemUgICBFUyBGbGcgTGsgSW5mIEFsCiAg
WyAwXSAgICAgICAgICAgICAgICAgICBOVUxMICAgICAgICAgICAgMDAwMDAwMDAwMDAwMDAwMCAw
MDAwMDAgMDAwMDAwIDAwICAgICAgMCAgIDAgIDAKICBbIDFdIC5zdHJ0YWIgICAgICAgICAgIFNU
UlRBQiAgICAgICAgICAwMDAwMDAwMDAwMDAwMDAwIDAwMDMyMCAwMDAwNjcgMDAgICAgICAwICAg
MCAgMQogIFsgMl0gLnRleHQgICAgICAgICAgICAgUFJPR0JJVFMgICAgICAgIDAwMDAwMDAwMDAw
MDAwMDAgMDAwMDQwIDAwMDBmMCAwMCAgQVggIDAgICAwICA4CiAgWyAzXSAucmVsLnRleHQgICAg
ICAgICBSRUwgICAgICAgICAgICAgMDAwMDAwMDAwMDAwMDAwMCAwMDAyZjAgMDAwMDMwIDEwICAg
SSAgNiAgIDIgIDgKICBbIDRdIC5qdW1wdGFibGVzICAgICAgIFBST0dCSVRTICAgICAgICAwMDAw
MDAwMDAwMDAwMDAwIDAwMDEzMCAwMDAxMzAgMDAgICAgICAwICAgMCAgMQogIFsgNV0gLmxsdm1f
YWRkcnNpZyAgICAgTExWTV9BRERSU0lHICAgIDAwMDAwMDAwMDAwMDAwMDAgMDAwMzIwIDAwMDAw
MCAwMCAgIEUgIDYgICAwICAxCiAgWyA2XSAuc3ltdGFiICAgICAgICAgICBTWU1UQUIgICAgICAg
ICAgMDAwMDAwMDAwMDAwMDAwMCAwMDAyNjAgMDAwMDkwIDE4ICAgICAgMSAgIDIgIDgKS2V5IHRv
IEZsYWdzOgogIFcgKHdyaXRlKSwgQSAoYWxsb2MpLCBYIChleGVjdXRlKSwgTSAobWVyZ2UpLCBT
IChzdHJpbmdzKSwgSSAoaW5mbyksCiAgTCAobGluayBvcmRlciksIE8gKGV4dHJhIE9TIHByb2Nl
c3NpbmcgcmVxdWlyZWQpLCBHIChncm91cCksIFQgKFRMUyksCiAgQyAoY29tcHJlc3NlZCksIHgg
KHVua25vd24pLCBvIChPUyBzcGVjaWZpYyksIEUgKGV4Y2x1ZGUpLAogIFIgKHJldGFpbiksIHAg
KHByb2Nlc3NvciBzcGVjaWZpYykKClJlbG9jYXRpb24gc2VjdGlvbiAnLnJlbC50ZXh0JyBhdCBv
ZmZzZXQgMHgyZjAgY29udGFpbnMgMyBlbnRyaWVzOgogICAgT2Zmc2V0ICAgICAgICAgICAgIElu
Zm8gICAgICAgICAgICAgVHlwZSAgICAgICAgICAgICAgIFN5bWJvbCdzIFZhbHVlICBTeW1ib2wn
cyBOYW1lCjAwMDAwMDAwMDAwMDAwMTAgIDAwMDAwMDAzMDAwMDAwMDEgUl9CUEZfNjRfNjQgICAg
ICAgICAgICAwMDAwMDAwMDAwMDAwMDAwIC5CUEYuSlQuMC4wCjAwMDAwMDAwMDAwMDAwNjggIDAw
MDAwMDA0MDAwMDAwMGEgUl9CUEZfNjRfMzIgICAgICAgICAgICAwMDAwMDAwMDAwMDAwMDAwIGJh
cgowMDAwMDAwMDAwMDAwMDgwICAwMDAwMDAwNTAwMDAwMDAxIFJfQlBGXzY0XzY0ICAgICAgICAg
ICAgMDAwMDAwMDAwMDAwMDA4MCAuQlBGLkpULjAuMQoKU3ltYm9sIHRhYmxlICcuc3ltdGFiJyBj
b250YWlucyA2IGVudHJpZXM6CiAgIE51bTogICAgVmFsdWUgICAgICAgICAgU2l6ZSBUeXBlICAg
IEJpbmQgICBWaXMgICAgICAgTmR4IE5hbWUKICAgICAwOiAwMDAwMDAwMDAwMDAwMDAwICAgICAw
IE5PVFlQRSAgTE9DQUwgIERFRkFVTFQgICBVTkQgCiAgICAgMTogMDAwMDAwMDAwMDAwMDAwMCAg
ICAgMCBGSUxFICAgIExPQ0FMICBERUZBVUxUICAgQUJTIGp1bXAtdGFibGUtdGVzdC5jCiAgICAg
MjogMDAwMDAwMDAwMDAwMDAwMCAgIDI0MCBGVU5DICAgIEdMT0JBTCBERUZBVUxUICAgICAyIGZv
bwogICAgIDM6IDAwMDAwMDAwMDAwMDAwMDAgICAxMjggTk9UWVBFICBHTE9CQUwgREVGQVVMVCAg
ICAgNCAuQlBGLkpULjAuMAogICAgIDQ6IDAwMDAwMDAwMDAwMDAwMDAgICAgIDAgTk9UWVBFICBH
TE9CQUwgREVGQVVMVCAgIFVORCBiYXIKICAgICA1OiAwMDAwMDAwMDAwMDAwMDgwICAgMTc2IE5P
VFlQRSAgR0xPQkFMIERFRkFVTFQgICAgIDQgLkJQRi5KVC4wLjEKCiQgbGx2bS1vYmpkdW1wIC0t
bm8tc2hvdy1yYXctaW5zbiAtU2RyIGp1bXAtdGFibGUtdGVzdC5vCmp1bXAtdGFibGUtdGVzdC5v
OglmaWxlIGZvcm1hdCBlbGY2NC1icGYKCkRpc2Fzc2VtYmx5IG9mIHNlY3Rpb24gLnRleHQ6Cgow
MDAwMDAwMDAwMDAwMDAwIDxmb28+OgogICAgICAgMDoJdzEgPSAqKHUzMiAqKShyMSArIDB4MCkK
ICAgICAgIDE6CWlmIHcxID4gMHgxZiBnb3RvICsweGEgPGZvbysweDYwPgogICAgICAgMjoJZ290
b3ggcjEKCQkwMDAwMDAwMDAwMDAwMDEwOiAgUl9CUEZfNjRfNjQJLkJQRi5KVC4wLjAKICAgICAg
IDM6CWdvdG8gKzB4OCA8Zm9vKzB4NjA+CiAgICAgICA0Ogl3MSA9IDB4MgogICAgICAgNToJZ290
byArMHg3IDxmb28rMHg2OD4KICAgICAgIDY6CXcxID0gMHg0CiAgICAgICA3Oglnb3RvICsweDUg
PGZvbysweDY4PgogICAgICAgODoJdzEgPSAweDMKICAgICAgIDk6CWdvdG8gKzB4MyA8Zm9vKzB4
Njg+CiAgICAgIDEwOgl3MSA9IDB4NQogICAgICAxMToJZ290byArMHgxIDxmb28rMHg2OD4KICAg
ICAgMTI6CXcxID0gMHgxMwogICAgICAxMzoJY2FsbCAtMHgxCgkJMDAwMDAwMDAwMDAwMDA2ODog
IFJfQlBGXzY0XzMyCWJhcgogICAgICAxNDoJdzAgKz0gLTB4MQogICAgICAxNToJaWYgdzAgPiAw
eDJiIGdvdG8gKzB4NCA8Zm9vKzB4YTA+CiAgICAgIDE2Oglnb3RveCByMAoJCTAwMDAwMDAwMDAw
MDAwODA6ICBSX0JQRl82NF82NAkuQlBGLkpULjAuMQogICAgICAxNzoJZ290byArMHgyIDxmb28r
MHhhMD4KICAgICAgMTg6CXcwID0gMHg1CiAgICAgIDE5Oglnb3RvICsweDkgPGZvbysweGU4Pgog
ICAgICAyMDoJdzAgPSAweGIKICAgICAgMjE6CWdvdG8gKzB4NyA8Zm9vKzB4ZTg+CiAgICAgIDIy
Ogl3MCA9IDB4MTcKICAgICAgMjM6CWdvdG8gKzB4NSA8Zm9vKzB4ZTg+CiAgICAgIDI0Ogl3MCA9
IDB4NwogICAgICAyNToJZ290byArMHgzIDxmb28rMHhlOD4KICAgICAgMjY6CXcwID0gMHgyNQog
ICAgICAyNzoJZ290byArMHgxIDxmb28rMHhlOD4KICAgICAgMjg6CXcwID0gMHg0ZAogICAgICAy
OToJZXhpdAo=


--=-IMVcChg8AWwAkTkyWgqP--

