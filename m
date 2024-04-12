Return-Path: <bpf+bounces-26653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F35A78A372A
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 22:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9518F1F228DE
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 20:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1871637144;
	Fri, 12 Apr 2024 20:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GACbKPM9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3590D1FBB;
	Fri, 12 Apr 2024 20:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712954449; cv=none; b=gBHz5/+AV2qVLJNPSCEz/4qwM/Pj56ekY5szAowdJ9EGFMS45NgCjuu5K5XFPvuH3fgLmveMxaC47YD9eIkFguBZ+Ojs+gGcKkPLd7oeoL8Dbadsj3q2+NsOOCB5i1248M0Wl8PXoRNdKyRbEB0eFGMDiK6kKp9a5RXhGZ0btWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712954449; c=relaxed/simple;
	bh=6I7FJ1n/ZopMb9aGUauBF+gPbtN3jIoL1YIR0FUl8SU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cEjAuZBAH4UaXSXk/r+JfyIg7Ext8AzrnQ06gLMZq0Yv941wiMEMzUmZg845F59q2jwoV8CSeElyYk8TBKUs1my9lm31Bw61vf+KLLDjf0/inYKKtVo8xknRkFQwfikwQ+1s30w8N0D7IwQuC4JJ6adDs0nx+kA10ofpBaonMsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GACbKPM9; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5700a9caee0so271585a12.2;
        Fri, 12 Apr 2024 13:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712954446; x=1713559246; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6I7FJ1n/ZopMb9aGUauBF+gPbtN3jIoL1YIR0FUl8SU=;
        b=GACbKPM93NUDDBQF8111iUVC6Sx5yCM21Z2C44xizk+yL1U+GWEYV3M0qs8SR6sqsb
         m5RB0z0L31thw3bpIwJvh/F97QwXtnveGejZQfw3huCMFIkmSSVH0gy3Jds3jzN7oXjh
         q8j6iOdbHDajZ6JvYbV+h9BdBGTf2UkOWBJ+QS1BPjlzEVHD4dYxomS01Z0PuCkNVPh8
         b1A5wVPgoTcbu3R+6G87dpCZZTUNYq2rrmixBGazdSTVJGEorgMwM6uDQAyRDj4DQCrE
         j5TQ0szDKcz3AAnwc/cpEgQylo346/+G1704xPTqt8xk7bi7ZcpFLz6VenZdKWKa9LGp
         Bh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712954446; x=1713559246;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6I7FJ1n/ZopMb9aGUauBF+gPbtN3jIoL1YIR0FUl8SU=;
        b=jF+AchaREuxrvQjkrxjLzCPlgiSkj96N3GcOA2ywt0N+ISrA/aYXk6UchE/JlozN3R
         Dj8kcv3Gslhs/Sd+GGGRyiS1HOTqLUeec6a47cxqE1Uyr3O3QxJd1kRzTYLF0vyQdnHi
         pzhvEukesAwzY47z9X4URa2grn1N88cR8gwT4PTrNAmiBO1W5sC020ZmHB3mVkscRPRW
         3bPPVnRla/7x2rk7AwFtYsOsOmaKjG5OXBRiu8U0fIIJabuaET/62mWRpqIBf9IeuZUh
         ZTZc4OaxfGoQE9p00RMeDNzdAGuH0w/IJ1jmDsS1iBY30fHEJUHerFBa4zIUSN/gHbZX
         enSA==
X-Forwarded-Encrypted: i=1; AJvYcCXjMdxwofx1z5VUNnU50+LJJis4dCuqXM4OyHY98RrtfOcSd7Qf6+gHvmaVoSaje4rZ9Mb1+3M2uxKQwM98f+E+awFNyD6EzsvpuDcmSXFCl9EA6YrgV17uBPqgyw==
X-Gm-Message-State: AOJu0Yx03DUjz8VcDuSF3HnStY6AnrPzBjWvFtzKD2ygwJ+vMDwl7i5h
	i/0RPT9sORpOk+xbcqlkSmbgxCFgfvRC/V0gdfg9yLA1hpyVulKr
X-Google-Smtp-Source: AGHT+IH6RPFL6fJmHiwdBFQp8UNV3SsOPyGvscsHmJWZ2g4iNhIYh/SsXT9qKHSlYNjVrXN/hP+RhQ==
X-Received: by 2002:a17:906:fcb6:b0:a52:35d6:157c with SMTP id qw22-20020a170906fcb600b00a5235d6157cmr1813723ejb.68.1712954446243;
        Fri, 12 Apr 2024 13:40:46 -0700 (PDT)
Received: from [192.168.100.206] ([89.28.99.140])
        by smtp.gmail.com with ESMTPSA id ku21-20020a170907789500b00a517e505e3bsm2175163ejc.204.2024.04.12.13.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 13:40:45 -0700 (PDT)
Message-ID: <fcaf2c3d2134ae6ecbfbd17dbaa574373ff7ab03.camel@gmail.com>
Subject: Re: [RFC/PATCHES 00/12] pahole: Reproducible parallel DWARF
 loading/serial BTF encoding
From: Eduard Zingerman <eddyz87@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org, Jiri
 Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>, Kate Carcia
 <kcarcia@redhat.com>, bpf@vger.kernel.org, Kui-Feng Lee <kuifeng@fb.com>, 
 Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Date: Fri, 12 Apr 2024 23:40:44 +0300
In-Reply-To: <ZhmbiFdtYN3tlG6u@x1>
References: <20240402193945.17327-1-acme@kernel.org>
	 <747816d2edd61a075d200ffa5da680d2cc2d6854.camel@gmail.com>
	 <64bfcf02-030d-471a-871a-e7490d74ca28@oracle.com>
	 <db6480e9378f59c367b03f7455372caf7b593348.camel@gmail.com>
	 <ZhmbiFdtYN3tlG6u@x1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-04-12 at 17:37 -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Apr 09, 2024 at 05:34:46PM +0300, Eduard Zingerman wrote:
> > Still, there are a few discrepancies in generated BTFs: some function
> > prototypes are included twice at random (about 30 IDs added/deleted).
> > This might be connected to Alan's suggestion and requires
> > further investigation.
> >=20
> > All in all, Arnaldo's approach with CU ordering looks simpler.
>=20
> I'm going, for now, with the simple approach, can I take your comments
> as a Reviewed-by: you?

If you are going to post next version I'll go through the new series
and ack the patches (I understand the main idea but did not read the
series in detail).

