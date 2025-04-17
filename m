Return-Path: <bpf+bounces-56164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF2DA92C0B
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 22:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148C13BEBC2
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 20:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0282066F4;
	Thu, 17 Apr 2025 20:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hT2Z4RgY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3501DDA2F
	for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 20:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744920634; cv=none; b=kIF038lBiIRLx/yFYYD+bidVF2NthOm4OKFqNZGz/GdexfGGhYVDnugp2hGSk5fv+HphcVPVHGOUuS5BgipkyVIDG10w1wEzRh2XlZUyufDjjk+Hm9EG53BJUAV0TB3lx93nASg33Z0kscC2B8ZfpkBCmzAEaviMpmTiT7k3CJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744920634; c=relaxed/simple;
	bh=002o3JyYhc3nsY5l/xXUWR71aHw0JptiuEYn3Od9TOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SzTSPyi34aba24TNPbi6UeAqWWvp/aXcyf6KycriJ0zz9U9V86ge53z8oWS6X9jhlaHPwrHnHHrY1c4/5RFDNpQ7W6vicp6Io/HGvsUI+q7DDTVWyvQ2bB22WsF6iHJr2Cw5kvImmbUiB7ZdP1WiNgpc0tgPrdIjPYViZVu9FD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hT2Z4RgY; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-ac34257295dso227276466b.2
        for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 13:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744920631; x=1745525431; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JNrF0lwkiKLJMlYNWIyQIGxja6GACAwhpUC2Sfr8icQ=;
        b=hT2Z4RgY42/liRFQVWAwmmE2CwaF5qn+b+QYT4a46gZt/nf2GKZrHzNJ7+JcSkUXN8
         gMD4Aom8JCmqrVwZm/CX/e+hnEApgNsIBMHMJO8uo7qBkb42x9uk2IYmp/T5cK4g7Tnv
         anNIUboH67xyMeZR1wN/PP7YMDW02VQdl/IZWgNyMaQwqIe+bhgWxIy9f709PKZJATUR
         djl6VguAd4C3hjpLyvjresycKWt53rR4B9tEqk8BolHqAmPJnCX4YdCa6WCB+wZWCo8A
         3OdPv8Df39HTl4mrktIiAaMc94Ulw6tV9lC+lf0IEVuE3hheircPdvlX77u8oZNnSwif
         hDeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744920631; x=1745525431;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JNrF0lwkiKLJMlYNWIyQIGxja6GACAwhpUC2Sfr8icQ=;
        b=fDydQy3/1ot23lFsmfvHRgSux6jUKvLJhexGvGXBOPoe+E8mnDZ7IFf9iC83gX+4pe
         MADCRIw09iZ7gIxK26uyOTIJH6yyGilHBSoj11PTN3qn4NEwLDHjFCcxSsm6VlKi8BZ0
         6goHm7Q7Ca7R1IEmdPmLP+oW5ZODS4Zho6oyBKTZlCrZs66vQ7egH8XxmJ/oD54uuuoH
         Hsb6xovQbAW/ZgJBoDASzFetHKQI61iyUDXCfNvGTrCAAoeud6PWGwmWBe25eQolnOsC
         mfxE3onZSZLgZQ+hK/ZS8RkYwKfgB0wxvjDvaq+8zGF4Sa5zsXHH5kTj5OSQIWGYOi1J
         hfLA==
X-Gm-Message-State: AOJu0YzIK6FQIL7swPKdrzuopkCoBHTC/5S7x1oGRgRSUX98wmO4foxQ
	NSQG/T6JMsaQIcMnvHW3KAZQ1LOXu2FeiEFoM7lMWHYL7PHE8CT54QCLHiSCif18Gusq7Fhv8in
	iL8S5IHPCa3OVHcevS50suaQmXFU=
X-Gm-Gg: ASbGncu1RJqsnyKB55JFwCQc+T/H8/TSFfZk28lKlHyOnsx9mcuSkKcemAkW026ptGb
	SNEc149PXuPgyt2NbSgJGYZe+hJVzNC/6lDEkL/7CcSMqJhmSyVnPDyP2+4MmqO1auQrPK5GNru
	YfvFnXGmfgqEey//b8MBggb1WKzpn+Eac94WIyE0g6Uos=
X-Google-Smtp-Source: AGHT+IF/LXCJx0g8B4AeVUkUQLO/4B1yO9+Sp4sra9ehMHz5eMTvdAS4/Ze+CkaHfQGLN/23YvJJweHVuHhvU6mraHk=
X-Received: by 2002:a17:906:db04:b0:ac1:db49:99a3 with SMTP id
 a640c23a62f3a-acb74dc38b5mr15902366b.40.1744920630845; Thu, 17 Apr 2025
 13:10:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414161443.1146103-1-memxor@gmail.com> <20250414161443.1146103-5-memxor@gmail.com>
 <87a58g1otz.fsf@gmail.com>
In-Reply-To: <87a58g1otz.fsf@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 17 Apr 2025 22:09:54 +0200
X-Gm-Features: ATxdqUECOJTaqGMy2c1Vyu9ded_VIuSi2SdYMN8kST8hQnJmNhP9v0KcFC-glR4
Message-ID: <CAP01T74a=65hrUUO6kNqomBPf0Yu+iP_bVrTCqFtdPO2KPeQdA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next/net v1 04/13] selftests/bpf: Add tests for
 dynptr source object interaction
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Barret Rhoden <brho@google.com>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Apr 2025 at 10:40, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>
> > Add a few tests to capture source object relationship with dynptr and
> > their slices and ensure invalidation of everything works correctly.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
>
> It would be great to have a bit more test cases here,
> following your nice diagram from patch #1:
>
>                   +-- orig  dptr (ref=1) --> slice 1 (ref=1)
>  source (ref=1) --|-- clone dptr (ref=1) --> slice 2 (ref=1)
>                   +-- clone dptr (ref=1) --> slice 3 (ref=1)
>
> In one test (probably extending the one in this patch):
> - check that both orig and clone slices can be read at some point
> - destroy orig or clone and check that one of the slices can
>   be read, while another can't.
>
> In another test:
> - destroy source and check that both orig and clone slices
>   are no longer accessible.

Agreed, will try and add more cases explicitly.

I struggled to have more than two callbacks automatically working with
RUN_TESTS and struct_ops, so I guess I will do explicit loading and
failure checks.

>
> Also, is it possible to conjure a test case with two hierarchies?
> E.g. source1(ref=1) and source2(ref=2)?
>

Should be possible, I'll add it.

> [...]

