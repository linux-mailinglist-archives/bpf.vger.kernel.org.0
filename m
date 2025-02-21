Return-Path: <bpf+bounces-52152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 356C1A3EC81
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 07:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 454527A5540
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 06:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFF41FAC23;
	Fri, 21 Feb 2025 06:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnFkmnjt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097B218C937
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 06:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740117918; cv=none; b=tYR28CfZJYyf4ybMcG6vSIF8bOL0Ed8i8rirs1JqqsrxGdKt6O4KPzMyLALEojpok7zco4urVyC3i1Ho/3pzui4LDG/W1q+7mYi66haKNzuay8CHk0MybKZNY0S2MBWKz8I71poSuIfikJm65KlJmFU3DcIoSVYMa9CU5grhVzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740117918; c=relaxed/simple;
	bh=g+x/i8K+GLyzHo1DD7OeP+K9U65IqeIHEGbWLDEXdJU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TOk7Z810IuccQ8C4PylLKLRY7owLwAAFS6L9pbFYirvpy7TIGG/Z3rM7OJiFnrMxfIOSrYhHvGaMdEwiXL5o6QPu5wyy6AqWd42KWC4Xsl3ESg6a9Solq+Tj7DlUuGh6775ReQYUXrQ0kxDvaUPWgT1eqmA+APydMmII6rUiRlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnFkmnjt; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220ecbdb4c2so46451995ad.3
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 22:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740117915; x=1740722715; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g+x/i8K+GLyzHo1DD7OeP+K9U65IqeIHEGbWLDEXdJU=;
        b=YnFkmnjtHMOej5/1Q7JEDtOu+CQ/7CRpl+Vz+YS1z/epCKeJOMBASA41aQ+tFva6hT
         vdie0Nu/bxXgHQD2eQ8pZrFEQjU4R2YnDXezqwd9mrT7iZpSJ1rOvNDAjxPirlQ8I8cU
         IP+FMqIFokNtutlXFX1c7L9JdpkJ/zqGawMEKoGdt1ZLIZWxyU8j7AJiMyG4tFXFT+Xg
         gu+9eJ7uhErqN3vyMZ7VqHar/BBWI+CJWMeXJ1Wu9Fo4lVlc7X1i7134rY6+le73yXVF
         QQzy+QRYJtO4VGro2otGFeDkLuVuF944pAitq02IGbwbZ1tAykcIBt56lejkIxynTn5k
         J9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740117915; x=1740722715;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g+x/i8K+GLyzHo1DD7OeP+K9U65IqeIHEGbWLDEXdJU=;
        b=jDsgk+Tlt3PKXgP1roumUbjpH9OJMEOGULiasRrWd/VoV8dWQ7xL8KLBlfDxE861eI
         3SVbKpIwkeHtx2oujL3ixUB5gIWMEh82IkraWRrgL8w/u4XgIuqkX7ytQRPPf1JhyQTx
         94xBHjVCJrrHklLv9gho4sBYetuMd0ScuXlEqkIlSrEhA4bl9geNN9X9mVtUG1HffmQ6
         k14jHKaSuQAX89zFy94tiUDdtjqVnepI0GOw43UiCBd2iCXDcsXDQPBcHZU5VkVe8MR6
         V/2nPzYgVFMReak2/yb/Q24nQJsuh6GxfLBGMLQavjlaOTqHOkfTvTrLpTdewFiEmcVR
         gDow==
X-Gm-Message-State: AOJu0YwNEfHcIG45TbiyN5g+8JRzSC1IZgh+bl0e6ZPLSVQcLa3Yv16q
	sx9MlBEYGwUJyEoTUC4w1+ECWCEIhCiab/dxAb3NY92gQCuUUv3lundHIA==
X-Gm-Gg: ASbGncv55/L5QTHS4EzXgkrEpe7fPd6y2cOS0rq2nyvsn3jpHgLYhtytSZsGvNU9IID
	SBrNBbAgquwtSApom5XAgAK4KOCTscWTejpvBC9iLn3Igas+uvQUpOh8v3wlvO6F/uVmu/fjET9
	nlZukwHKJBD3FDyLQHcJEp3KnX5i0JoyObvsS7uItScIzsAiBStBUD/LK0KuclfcmXHZddxnTnA
	+5x/mJ47B8MbBpCvmHM/VN7HFi4p+gV8+m2WDwbbS2TRqiLDGCMk8NpKxwkj0lu0yZ5p9BR32PF
	z1TS7uhAaHYBfwo//y7eSE8=
X-Google-Smtp-Source: AGHT+IHyVhESGapEvHONKbmvp78ZccuBvaSfDNYT6q3sfVxzg7k0sABNpzrRHdpINyr8cGiFihGH0g==
X-Received: by 2002:a17:902:ccd0:b0:21f:1096:7d5 with SMTP id d9443c01a7336-221a0ed78bcmr27948075ad.17.1740117915009;
        Thu, 20 Feb 2025 22:05:15 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220f26ea127sm110625865ad.96.2025.02.20.22.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 22:05:14 -0800 (PST)
Message-ID: <fb5d1434fd1432c2cabd61ce95c694b45f4c20ef.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Test gen_pro/epilogue
 that generate kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	alexei.starovoitov@gmail.com, martin.lau@kernel.org, kernel-team@meta.com
Date: Thu, 20 Feb 2025 22:05:09 -0800
In-Reply-To: <CAMB2axMdFK4cCndpaGR_8nSfe4ypzX35vqW=CysOwTuKndxDsw@mail.gmail.com>
References: <20250220212532.783859-1-ameryhung@gmail.com>
	 <20250220212532.783859-2-ameryhung@gmail.com>
	 <e83d842e9f6c5cb6f98fd8cb760ec1c8e17e419a.camel@gmail.com>
	 <CAMB2axNXpctJ8M9VgWJPFWKsMGt-u1cnt_KdXW=wBDNi6npBiA@mail.gmail.com>
	 <CAMB2axMjLRNeH=4cm+M5kTKr6b47tOgjCKXVHVXTKbbf6z09TQ@mail.gmail.com>
	 <88897fb139f903b9d0aae3291602d1df35b31ea7.camel@gmail.com>
	 <CAMB2axMdFK4cCndpaGR_8nSfe4ypzX35vqW=CysOwTuKndxDsw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-02-20 at 21:06 -0800, Amery Hung wrote:
> On Thu, Feb 20, 2025 at 7:02=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:

[...]

> >=20
> > So, for this particular case there are only two options: resolve id
> > dynamically, as you did, or use a kfunc internal to this module
> > instead (which should simplify the test, imo).
> >=20
>=20
> Currently, generating module kfunc in pro/epilogue is not supported
> due to the complication in resolving insn->off of the kfunc call. I
> have one patch that test how it can work. But after some discussion
> with Martin, we think we can revisit it when there is a struct_ops
> module that wants to do so. I will keep the current dynamic btf id
> resolution in the next respin over using module kfunc unless people
> think we should support it now.

Fair enough.
Sorry for the false trail with BTF_ID_LIST,
this resolve_btfids corner case was a surprise for me.


