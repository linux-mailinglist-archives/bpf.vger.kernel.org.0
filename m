Return-Path: <bpf+bounces-44913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E673B9CD4D0
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 01:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83A6EB247A0
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 00:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0371F95A;
	Fri, 15 Nov 2024 00:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mL5pIEWe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA8D1EA91
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731631836; cv=none; b=UqUDZYl46sNsAGsVHbDHm4gjSXbNRtf3dIRw+vla2K4w+ZPb9pIwIP+AN5a4BGKvQ0sojMUOXEkO1FJ288fdnczpkA05LZo4LZ77ArRde/1UEA6gRRXvOsPCUVn04l5PXlnSOvqpeAJbBG+PijSRymr5RYjjcep6kPd/VY/e9NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731631836; c=relaxed/simple;
	bh=66pl17jJTBeDGibo35WfEE2wEDENd0xHS0SzHS38T+c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NMXjNwLK1BlB6zM4BcpF/hFjgRbLkt5aNs1jG8Ae2V30IgDQONeYicBvgDXbDScXZgX0i8hP3PKhbVTZbRwNTY8RyAP8oKIAhH30HlKFvNDK2P3PT5oIgnycLn6Zgn3nPfFZBNJyvX6QPxBTJHFop8cf71s7zaW4Ie3yAWjJMuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mL5pIEWe; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20c77459558so11567985ad.0
        for <bpf@vger.kernel.org>; Thu, 14 Nov 2024 16:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731631834; x=1732236634; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aiQ4oePn+twaYsVayK2MFtxDBUJmMu6qCA4lQpU8Xbs=;
        b=mL5pIEWep9aoPk3bV3BL2+4Wb0ilQ69gCra1wdeVyT7tcN3ENFmn9fgXa1B511M4IC
         F+NqJRH0maSb9vtqOyJMHQ14ntRFHRRyok/mo372+b/eR6nlmzH4RW3BmF1Ms1ZnXFWQ
         GtKqgkl1AM8b4OlyeP/+mfxWcQe/ZRX6JVNoyQHe063lEyyQzL8iQxhwsxbl83Vm8huy
         dv57k8PNmsWhTeqMoq89wq8esEk2klTTURjv81oPex4BNBEVrxpgv6XrDehJU3nuj8vj
         jDo7TFXm1o6GZGy+zFCOAgs+HWIdLFMRWdE0UPou7M0D35OcGyZkCVyOGXhq6LQySbHJ
         mvfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731631834; x=1732236634;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aiQ4oePn+twaYsVayK2MFtxDBUJmMu6qCA4lQpU8Xbs=;
        b=mkC18Q+5KgmMTdzAU1XG9rHAOUllkhJFF7WyS5Zfm09D7oyAEEhDzI9oXh7tcuQdMi
         Ajz0rXnWoqqKKomVp9xciwBoc7bjkGhe6OSwIN8CVJqTp+KElZ+Cjg3D89a900j1MQK5
         BRD4RUWg5AcA+wNCV+DJR7YQDkbhyb1RYjiGgGK9AO6C4pg4QGfrR/2GC0482Oc0+yth
         Lz3/csh5nPAnhHWMSR/UxSLGA+JmYi/sVgM1sNdg9Wq9cFsK7spLJwQlnvGMKPvUPxej
         vDCmyQ6PIfIatcMQoG8jGnM40fuGBa8AnIrRZNJXkjh4nOfkB/xOrBFr/IjXgncu3Gay
         3sFw==
X-Gm-Message-State: AOJu0YywIJ3s1oA7zAlzYodbQ4lE8bQQoDAkY8rDG5vIM/xNqsl8AY52
	P+E9kVATlfUQPf30tKM2qiY2fvavRVD3yoiga9lwAQh2jFcugRjxYegEArWh
X-Google-Smtp-Source: AGHT+IGXjqDPC+8tpnbKo28pZI3kJS2tH8y2gxJx49eJAQkpLlw5nL7JyUIi3Bw3yM4bL0yA0dhnWQ==
X-Received: by 2002:a17:902:e885:b0:20f:aee9:d8d7 with SMTP id d9443c01a7336-211d0d81e71mr13523795ad.32.1731631833884;
        Thu, 14 Nov 2024 16:50:33 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0eca48fsm2357755ad.84.2024.11.14.16.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 16:50:33 -0800 (PST)
Message-ID: <da1040939abff53c84bcd3a6dc7b7bd6ebdcea58.camel@gmail.com>
Subject: Re: [RFC bpf-next 01/11] bpf: use branch predictions in
 opt_hard_wire_dead_code_branches()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  memxor@gmail.com
Date: Thu, 14 Nov 2024 16:50:28 -0800
In-Reply-To: <CAEf4Bza57teg+vOc_P2Fk02gEFPY69u7yPRzksr4GRVvS7o1Cg@mail.gmail.com>
References: <20241107175040.1659341-1-eddyz87@gmail.com>
	 <20241107175040.1659341-2-eddyz87@gmail.com>
	 <0f0cf220fa711f0bd376bdb167c035e53dd409f9.camel@gmail.com>
	 <CAEf4BzYUMMOdfwsWovDqQMgDnd8eGQVEyJLVRvqzmSwsZoW-wA@mail.gmail.com>
	 <CAEf4Bza57teg+vOc_P2Fk02gEFPY69u7yPRzksr4GRVvS7o1Cg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-14 at 16:19 -0800, Andrii Nakryiko wrote:

[...]

> I was also always hoping that we'll eventually optimize the following pat=
tern:
>=20
> r1 =3D *(global var)
> if r1 =3D=3D 1 /* always 1 or 0 */
>    goto +...
> ...
>=20
>=20
> This is extremely common with .rodata global variables, and while the
> branches are dead code eliminated, memory reads are not. Not sure how
> involved it would be to do this.

Could you please elaborate a bit.
For a simple test like below compiler replaces 'flag' with 1,
so no action is needed from verifier:

    const int flag =3D 1;

    SEC("socket")
    __success
    __xlated("foobar")
    int rodata_test(void *ctx)
    {
    	if (flag)
    		return 1;
    	return 0;
    }


