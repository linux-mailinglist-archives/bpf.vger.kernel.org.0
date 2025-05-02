Return-Path: <bpf+bounces-57276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42341AA7A4C
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 21:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B4561C03E1B
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 19:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370EE1F1522;
	Fri,  2 May 2025 19:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOeQBIZK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA3F1DB125;
	Fri,  2 May 2025 19:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746214415; cv=none; b=KaOv8WjMMIimc5d/L4I58Y+GfJyu1/bkxDK1SRrh/wjCOS+Ga226u5xLyLJhPBmsUoif9/94fukxxWofSmtQfefMXwQO34tBv9p7vSpiQsv9DRw08dE+aSsTpwXDJzZQfO6jyolxVPq5IrnFZcdqLlHfwiw2XDhgJm1OCUsMSNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746214415; c=relaxed/simple;
	bh=qWBC80F2xAAlXhQQHnmL+8164r7M6zUNF6naOIszZbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lt0r0ZigTvNCFgUn8owIsyCym5Ru9eOiuOTSVoi3oTMQv7zWBkTLLea7LSterY6byDUqjGobCxovWB139Ooul/7mzmpSmRRgLdrobIAAB0xafQ5vnBfcndTQJLQI3WBU/fkyUGhZMTIAyTdM92nb7DkveXC5edcTc/shF8t/Ees=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOeQBIZK; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e6405e4ab4dso2876449276.0;
        Fri, 02 May 2025 12:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746214413; x=1746819213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfS7K1haLBHftdjDHGYldaRugLtY9AbpZpUC4/2URWI=;
        b=KOeQBIZKTTzwaGQYeJcIxFzQ/b9SiLblFCQdS8enmcf+ep1njsVw456bBU3I0NSB4x
         rBLHpiOqmiyaACuzWsJol49anXWonSt3hXngWY36JIPd8+pInzOO5HKIfdmgZUNCfS+O
         XRmcgyOTDFiTVe2nZimnOzum2/mZtsgpmJk8VTmu/UIGCAo/4sg1nJA4jTOw6iCuvLX3
         OtaEjv8Iev2JOvM66BNjX4am4mbrjbm7D8iHkt+ETOI/gVkTLcXZ8BfqVEveLcXdunT+
         62LAzakwIB/RfbqpYAD52LkXETW7AadeFR8u/iv535X+qFz4Hu20BlPqApST6sft8mD6
         OwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746214413; x=1746819213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EfS7K1haLBHftdjDHGYldaRugLtY9AbpZpUC4/2URWI=;
        b=h7mNvm6pAQXNw84pDo5iu64tjlgYvv0+zgHVeWIHKhHObYjdBRQgnFxQvFR5I+TWm2
         pQhljeF9Z9etXEzxgUQb2cFU51pfHkFxoWehKAIjYv2GrIFE93xWfAmu2KowXrSxtV+F
         nEF1hyy7ql7PobcEomDtciu/zdPK03CardtW5UhXSU4aZ0NDX/nSb2HVdvX7InsnnnXs
         wdO3Y+urpC6imPug5cHfSsfuh4IJNAVv2QuY/PGKfpXa5x3Oo5XU9pBfhk2HpFSAA1tV
         s+BF4EBL/wT61RQ5U0ySgeFyGlYwX1zXYbQThyK/PI26ADgALWbRp2mlacd8c7XD2hRg
         j5oA==
X-Forwarded-Encrypted: i=1; AJvYcCUq7Ikdn87LNO/WKjrmnZEkmAwK1joOKwv5j3ND1v11ves7dJnaZ+r9Ambj3GZ/lalMNo90dqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcqMvLLIUzEupUqRDXwTa1b+PkJfVJiVpppAMCDr3OK03Uxt1A
	LzoqSWnRp/cOaLEYixRJRcxmSIRU94dmf8ogHPQhxkkeqBICcYbkhiXCpozUO8x0Kw9HuE6VbMA
	BqCHu5/1cAr4QRe9WE40g6p8wm68=
X-Gm-Gg: ASbGncspW5O9dYxBe/mMtLM/M+hn2mkeIASn2/cxby/tWJstrTdfpdj5Tqt7xSobhBz
	Fsrrze55eCTCdQQkDbLIRUTSzAcJY88rgbFD6tyD1lv/1sLNk8Oapf6jr7KK7uQQ0Zq+5B7neiA
	iWyQ0JuUkWUJXiMAOM1njQKg==
X-Google-Smtp-Source: AGHT+IGzX7EmNI70ec9qEkEis7ZSaP0ZznbyzKq7yDQ/Od/uW/JYTP4iqVJzbbgEopqygWZ8mrTlkMIiMgkblR85qTE=
X-Received: by 2002:a05:6902:18cc:b0:e69:18e6:6729 with SMTP id
 3f1490d57ef6-e7564a530b9mr5459451276.13.1746214413218; Fri, 02 May 2025
 12:33:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501223025.569020-1-ameryhung@gmail.com> <20250501223025.569020-3-ameryhung@gmail.com>
 <83c8f387-c4a9-4293-9996-fec285d34c94@linux.dev> <CAMB2axO2Jkc4Ec051+BYhju2Vr_GwzZL6yhHGuohMdg2q6WLRQ@mail.gmail.com>
 <ec91dcac-d2d0-4705-aca1-8cdc1954aa11@linux.dev>
In-Reply-To: <ec91dcac-d2d0-4705-aca1-8cdc1954aa11@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 2 May 2025 12:33:21 -0700
X-Gm-Features: ATxdqUHV1YzGIXl-sVQzJeJu1zHaRUwp_mbSihMS6gvmuldsLtYwsSuHc9RfJMA
Message-ID: <CAMB2axNCKcGST4SVxXJ+9eqna7u3JZka+qH=pp-dpmW6gM0OaQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next/net v1 2/5] selftests/bpf: Test setting and
 creating bpf qdisc as default qdisc
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	xiyou.wangcong@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 12:27=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 5/2/25 10:52 AM, Amery Hung wrote:
> >>> +static void test_default_qdisc_attach_to_mq(void)
> >>> +{
> >>> +     struct bpf_qdisc_fifo *fifo_skel;
> >>> +     char default_qdisc[IFNAMSIZ];
> >>> +     struct netns_obj *netns;
> >>> +     char tc_qdisc_show[64];
> >>> +     struct bpf_link *link;
> >>> +     char *str_ret;
> >>> +     FILE *tc;
> >>> +     int err;
> >>> +
> >>> +     fifo_skel =3D bpf_qdisc_fifo__open_and_load();
> >>> +     if (!ASSERT_OK_PTR(fifo_skel, "bpf_qdisc_fifo__open_and_load"))
> >>> +             return;
> >>> +
> >>> +     link =3D bpf_map__attach_struct_ops(fifo_skel->maps.fifo);
> >>
> >>          fifo_skel->links.fifo =3D bpf_map__attach_struct_ops(....);
> >>
> >> Then no need to bpf_link__destroy(link). bpf_qdisc_fifo__destroy() sho=
uld do.
> >>
> >
> > I see. I assume it will also be okay to set autoattach and call
> > bpf_qdisc_fifo__attach()?
>
> Good point. bpf_qdisc_fifo__attach() will be even simpler. I thought the
> autoattach is true by default. Please check.
>

You are right. It is true by default. I will also clean up other qdisc
subtests in this way.

