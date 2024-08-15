Return-Path: <bpf+bounces-37291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A45F953AE4
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 21:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE83B1F2626C
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 19:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1E77580A;
	Thu, 15 Aug 2024 19:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrW1Fyem"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5824AEEA
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 19:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723750476; cv=none; b=cPJkjV2vMQHsUvmdyYsQvkAJBDDFrI1hLWX6q0rNTSkEodgMqFTBySDMzppovflqsFUH2AVDB+4N8yN3WHOfz3ccBR56OXuTTFcmOD3QvOq30q7lWpGxA1I+KYcHAKuZ+RxMsoBX6q8xA3TfNoWMqPHvjmZWEbgILL1CEQRmGn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723750476; c=relaxed/simple;
	bh=ZM+l2X0jfUHuMeT1R7V6KmQw9pxsixfQgyK51o8pw0I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ddTRDD5QZrji5KeRJ8c6I4376q3on61rK1NCKuFawwzRFPzvOnDBKjzRJbWFZmTT60PEPOtm+VLD54olo76flx1cP910+aXSB01mD6GJOZQYF5GEI4Ca9kT5uZwzFqYQqOm57gbcPZ/EDfU55/tz3h0Y0O10i0yz/JSNYhWM8b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrW1Fyem; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7c3e0a3c444so878602a12.1
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 12:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723750475; x=1724355275; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JazobRINcG6wJrh/NohfQ9CvUzrS8EugJu6UiTWsez4=;
        b=RrW1Fyem79cn5bGUwtA/3UGzqA6A333KWIjti9o68rIaApfA/juiSSLsmUKiQL8jPE
         jJUUTkdUAKFcDzxPGdXa4V1JRi2pUIJajDH98CV0QQCniaEGPO0Rz5p5x5CJT1IEIgiL
         WptS4JYhVUGyD1I//m/6ThTivUR+Wm7hJYfVK1MWUFC4Q0vWEEpv0RQ/q8PFjbZE1mt8
         FySoPYIQWkuI9dQsnDmVtwRgAlxf4UFnqaRsdMFUwBU60jj4MkKDck354V9+oCky001V
         zQyc0dKaT54Isrwoh5Wow95ilIjAtt4xYJRsrWCl5G9h58hVqU3vavh08LqhwHryTbPw
         9fXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723750475; x=1724355275;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JazobRINcG6wJrh/NohfQ9CvUzrS8EugJu6UiTWsez4=;
        b=Ig7H9/fWdWW8b/d668+h3mWfbnHejBc0cVgUBUyH+PoIt16exfORgM2HcVQCckUGZt
         eW7m6ekVuqgEB9v+s0iIWXWOsllTgWDTgp9+Tq2CPuFb8WKUldLHgc2XbkCY7BoRZOak
         v2xiG/ok9QJ5aqz5rrjy6fpbnYKsySlBwqF6KTBANO9jHCkPb5egJAhl7PL8W2Aj+san
         LJJ3JfDQRqyKMcYYNyW3+dLUHHdnKpfvldxdajl0gybCsE6cpMG837xD6MwcTUNnVKRq
         PSxIchYebITDjSyLvwPypw6jzU+zSsRGRVbI188T32aAJGVJDeo6iXukddUJZioVYshd
         wkxA==
X-Forwarded-Encrypted: i=1; AJvYcCXCm2fj0zIX99G/KDc26AyC+x/Q2nhiweTLRk8DZ2bZ8Z4sF2JD0lQbtwGZy+7opBiNr4vpKOiYzlTbbtAvULi6uzLJ
X-Gm-Message-State: AOJu0YxNWNmZWnQ5Ze70V4TPhsh3q+AXM1pM6VZBiwdUIcu4xDIMrYEs
	zkGUtwfJ9m8d5l0zyI12yDe0YS4cMhr9pzp5wdCqtrVMeCHixbSQX3xgBQVRGNw=
X-Google-Smtp-Source: AGHT+IG7RgspcP15rjB23JZdVehd/bTWUYTiNqc6hTooJOMxT0dYZDxik1GfaO5/F6ahyTVGgkHYYg==
X-Received: by 2002:a05:6a21:890c:b0:1c4:77ea:601a with SMTP id adf61e73a8af0-1c8f8628ea2mr6078118637.15.1723750474731;
        Thu, 15 Aug 2024 12:34:34 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b61dda3esm1319832a12.46.2024.08.15.12.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 12:34:34 -0700 (PDT)
Message-ID: <c5283abab1c4b9d33b6480674d3e8f72e6b66ec7.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf: utility function to get
 program disassembly after jit
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, hffilwlqm@gmail.com
Date: Thu, 15 Aug 2024 12:34:29 -0700
In-Reply-To: <de45cb69-8116-4589-a0ba-9e77ba1c3e60@linux.dev>
References: <20240809010518.1137758-1-eddyz87@gmail.com>
	 <20240809010518.1137758-3-eddyz87@gmail.com>
	 <de45cb69-8116-4589-a0ba-9e77ba1c3e60@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-15 at 12:27 -0700, Yonghong Song wrote:
> On 8/8/24 6:05 PM, Eduard Zingerman wrote:
> >      int get_jited_program_text(int fd, char *text, size_t text_sz)
> >=20
> You need to give some context before the above function signature.

Will do.

> > Loads and disassembles jited instructions for program pointed to by fd.
> > Much like 'bpftool prog dump jited ...'.
> >=20
> > The code and makefile changes are inspired by jit_disasm.c from bpftool=
.
> > Use llvm libraries to disassemble BPF program instead of libbfd to avoi=
d
> > issues with disassembly output stability pointed out in [1].
> >=20
> > Selftests makefile uses Makefile.feature to detect if LLVM libraries
> > are available. If that is not the case selftests build proceeds but
> > the function returns -ENOTSUP at runtime.
> >=20
> > [1] commit eb9d1acf634b ("bpftool: Add LLVM as default library for disa=
ssembling JIT-ed programs")
> >=20
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
>=20
> LGTM except a few nits below.
>=20
> Acked-by: Yonghong Song <yonghong.song@linux.dev>

Thank you for the review.
I agree with the nits, will fix as suggested.
Will send v2 shortly.

[...]


