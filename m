Return-Path: <bpf+bounces-46737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B57499EFCCC
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 20:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C816716A490
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 19:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1038A1A01B9;
	Thu, 12 Dec 2024 19:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZUdB02F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484F525948B;
	Thu, 12 Dec 2024 19:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734033278; cv=none; b=cQBG/u5dfjanZZj1DgLBmsaMfCBtup6wfj390US5ZlspPZE7x++vbr9w9CdlHwg356xf4Z/I1r3P2j+IN5ch9rBNMe5aywXll6Ostkt/GEvw9KZlA+t72O1TGhzsd5cEQ7T+zcqpbrxXj62Exl6tWO8o4V/00eMTSR5SB3qOUnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734033278; c=relaxed/simple;
	bh=y7ceDt/jp+ZISzHXE7cPI3FanAgt7uuCJEMCJ1gYX04=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i1aU/WPfZjd8aDD4QOAMo77UuUH3dT5QKx7yXs4U8pQpCh/1TYyGusxrmvF/oa2gHfr4S8A4qLze1gacsYDG5EHqEATz1vOYU0xn9wkQEGTjFZ3k7qcVea0eTh3HRpazmI6WHNZB0JA7L4B0tI3kCUHArQM/novsD4+o/acyp8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZUdB02F; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21661be2c2dso9137275ad.1;
        Thu, 12 Dec 2024 11:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734033276; x=1734638076; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RHEyUtt38gEJmL+87hvfIeJfaFj1LijPzTRS1Dvk3n8=;
        b=UZUdB02FDfSi3GSByMhKCkFOyYaIymmynrWekcEqohg78Xc37de6SzAj+IXSeZzSC/
         cSsydXPSWdSQt4NepgVfyeJSw5vkzvyF8scV8QgjkNKpjAWLrGse2jqlSnz4s3F6dXZo
         49JVmYT7Au+YdzBpgldTGYtM0oTayrIG/5gnscbYawoQtXte8cRJjjhEosrGxZVdRNFt
         34bpbDogZqFXkWK0mzOhYQBo+t+HZaaKOl4UbrQlWzcdWTeFX06T7sbgt/mBQgHv4DAH
         XrrQ3Ftha+EnRbruS3TvK7rJo13iDHTmK2/xc8lx8x/dSLvo7UeIplBSCCGREy+nCEJA
         pvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734033276; x=1734638076;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RHEyUtt38gEJmL+87hvfIeJfaFj1LijPzTRS1Dvk3n8=;
        b=Y67rMV7io8EeS6Tj50YuLkugiA3ivGw3pOc7Fv9SfO3FY1r/Vp4ELk3uNS/ALRgpjb
         XgmfwX/z5+3vUZGmd6DXWmJLnplPyMdfG4KD5zd7C8ev0vzO0DJbrDomt83bKRapHX0/
         gTqVVlKfB6AP40SeFwme9FdpPXuzJ211L5r9obznHAMeGm5hHeP0TOQa5z7XCQg2o3Z2
         +zyKNSYCDJcrUayUqRacByYFoutyh/Y48ZjC7022IhXRgkCug2U49DGRng6Ig3Jh1rSq
         A+j+DUoIsmRFe+JU2XnexNU1NsybNCtc5GgmQBfL7Qy3I7n4UnvEe4uL4+MHUw/vsY9F
         7KRA==
X-Forwarded-Encrypted: i=1; AJvYcCWzifZFbqsfwFiGbxAaJL7FDUwJeA7Fr9kYxYJrePDknos8XiwDNaMz/B2jvxVJRA0QwoOGCd5k@vger.kernel.org
X-Gm-Message-State: AOJu0YxI7O7CQK8s68+2LlBwr1DavpfIiS5scVJ6KtqDr7Nkwz0xTC/M
	xDezm7C2yZcuU0dZyoYMk3zFiLj/lW6e9jlXUmTQlTlz5VO6MVA5
X-Gm-Gg: ASbGncsvOEiO7O1lr2ypcL8nmiLQ8Gl/+/G4okTarjI6QAaf7Uinb7UxrdUUYZfKZot
	hEeXQFyUtvLrq6e/L/SzsdkXwKMdjugVR1HoRuiZNzFhGaTZv5yPFC1vQGf/gXdAnfA7jSvFyh3
	TYhdsdNNmsj5Xu8HFNVpFmsDG5Xq+EkIw74bhmMBSHYHUbuWiI5NYU9ZPwaXLQBxruQvjgYeRyE
	z7MN16agy0jm7NCoEKYftb3CUebzJGpqpboSDcGMxl8O4lw/N/Uqw==
X-Google-Smtp-Source: AGHT+IH37e7SK+yZ10332PJxuc/u/hF0kIgIKrv567fVEWTfl6bjHYm9yJJNlbywWuBK3y2edy8r8Q==
X-Received: by 2002:a17:903:32c1:b0:215:4394:40b5 with SMTP id d9443c01a7336-21778591528mr129407475ad.43.1734033276560;
        Thu, 12 Dec 2024 11:54:36 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21613889367sm111366725ad.51.2024.12.12.11.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 11:54:36 -0800 (PST)
Message-ID: <bae76fc801f50311c330de1d39a40a72314351a0.camel@gmail.com>
Subject: Re: [PATCH dwarves v1 2/2] tests: verify that pfunct prints
 btf_decl_tags read from BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org, 
	arnaldo.melo@gmail.com
Cc: bpf@vger.kernel.org, kernel-team@fb.com, ast@kernel.org,
 daniel@iogearbox.net, 	andrii@kernel.org, yonghong.song@linux.dev
Date: Thu, 12 Dec 2024 11:54:31 -0800
In-Reply-To: <e7247151-ad60-402c-a3f8-ce976ea03dc0@oracle.com>
References: <20241211021227.2341735-1-eddyz87@gmail.com>
	 <20241211021227.2341735-2-eddyz87@gmail.com>
	 <e7247151-ad60-402c-a3f8-ce976ea03dc0@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-12-12 at 19:50 +0000, Alan Maguire wrote:
> On 11/12/2024 02:12, Eduard Zingerman wrote:
> > When using BTF as a source, pfunct should now be able to print
> > btf_decl_tags for programs like below:
> >=20
> >   #define __tag(x) __attribute__((btf_decl_tag(#x)))
> >   __tag(a) __tag(b) void foo(void) {}
> >=20
> > This situation arises after recent kernel changes, where tags 'kfunc'
> > and 'bpf_fastcall' are added to some functions. To avoid dependency on
> > a recent kernel version test this by compiling a small C program using
> > clang with --target=3Dbpf, which would instruct clang to generate .BTF
> > section.
> >=20
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
>=20
> nit: the test is great but it would be good to print out a description
> even in non-verbose mode; when I run it via ./tests I see
>=20
>   5: Ok
>=20
> could we just echo the comment below, i.e.
>=20
> 5 : Check that pfunct can print btf_decl_tags read from BTF: Ok
>=20
> ?
>=20
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> Tested-by: Alan Maguire <alan.maguire@oracle.com>

Makes sense, will change.
Will wait a bit and resend v2 in the evening.
Thank you.

[...]


