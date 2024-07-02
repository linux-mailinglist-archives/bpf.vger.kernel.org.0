Return-Path: <bpf+bounces-33684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7719249E8
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 23:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D0F21C22A39
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 21:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF9B20127D;
	Tue,  2 Jul 2024 21:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngeSm3gz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BDE148FF0
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 21:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719955515; cv=none; b=DCpcc9bTUKglIPZQcGIIQkZ9XphJuuCq10U9AitHTgNZcPuvWWjN1t9Bxg7/vZWhF3vEWboB2uTb2f9+ckHTV/4uv0tzqEXCnV/iee+I1M3/E31hoLJTBGr/v1CnWFs4tcOrrDuLkoEJwxlHgxx0NDdsRGj42RmVjM/HAUnbPLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719955515; c=relaxed/simple;
	bh=/fTt1z+i1hJf6FlAjJL9UZ/rsVGF5sTqs1W9FSmntEI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lbdagxJ18mNjN89w92UxkBK24KQrQwQjgSTfChHJ38sIOcUnbSV+S8rmTZ0FW0wCgokaJFwSTffKLezy24gjoBV1Fby4429bGOmQwl/j4hkmL7Bg5XxjmQiB9QN5HVm8RI9gmZ9KDZ2GWNIvfwT2/dMtxUst9WL8HajWfZDNpe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngeSm3gz; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-37636c38d6aso20875485ab.3
        for <bpf@vger.kernel.org>; Tue, 02 Jul 2024 14:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719955513; x=1720560313; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r1HvDJYjMPhlOYV/GJ1u07JPpLjxv/lnt2Yl+YnKTU8=;
        b=ngeSm3gzGUotQBHcw7ZGPILfFs+PKZFeylmkQGxzZ1TGa/NCar/FVaprbl3WHD5emh
         MdvWxhtApcrawXXrFmMW4MvydOEK4RSTTPoPSsACaBsI75aIPK9XgUoA+0ybMeQ76LsA
         9v5cJ4IcioOO1xKFcPoZRwPiJcCDyyzQUKViDT8pGlDniQ86EcH5oWvjoJPMGA6MgMte
         sCsev5rx8RIAEVJ+XgC9axF8RIfmMBUlD1dERpJ5cABD8kXXCdlf/zyAm8QtaRwlmQaN
         207Lv5UC1KrsZicKGUzWX2TnUAXFMne6kKgqVeZwl6sW5vaUyycDbCwSigTZmQRSpICz
         siDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719955513; x=1720560313;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r1HvDJYjMPhlOYV/GJ1u07JPpLjxv/lnt2Yl+YnKTU8=;
        b=xO2J1ywYHf5upyOXREgYDbc+0yFMlehdzmp1Uhf0U5ZONLHaWR4k1piUqe3dqNU6mf
         zwLYqcTtOSTgzyE9SxOh8Wn6O7MufyUq3vy9ZxhOACRP8f9sRoJzqf63gR0I4C847jJN
         W2HMrXZHY+OjVQ6fGn9656SZ0B8/oC9+Uve19klR6dlgYZxxGrGtmA3OtJYXzIMuFlh6
         pXTlAb3c8CZY6u9i+P8Vfn8lplPew2skZiPvv4+WSHQHZc08nsQ2EW2gKyFAni8sM336
         0OGS+ZLPiTw50QD69mowg+/xz5zOOpIBAEztmj8wPqnqyHdwFidqLE58V2lPFntFGorE
         lXpg==
X-Gm-Message-State: AOJu0YxHaiS6R9U6rkKMnMlneAlDaFztKewAQnvNCl0TAruHU4pN8jOf
	i0PY5IlRWvc0K4UF9jTFjf3x3Tweq2wgK7ArhHDgPnEJizlI427BvDqbyQ==
X-Google-Smtp-Source: AGHT+IGeYcuSB3Y5fUmLZ8g90u0k+HPFg1uTXyiugBwnP65X+7HWIYQStOJbMXv4w/yqXoepCDkGAA==
X-Received: by 2002:a05:6e02:1e0b:b0:375:c394:568b with SMTP id e9e14a558f8ab-37cd2bedb91mr136267955ab.21.1719955512969;
        Tue, 02 Jul 2024 14:25:12 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6a8df0e3sm7067910a12.36.2024.07.02.14.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:25:12 -0700 (PDT)
Message-ID: <f32e7e557a6cc4368875d645692c8340cdd9198c.camel@gmail.com>
Subject: Re: [RFC bpf-next v1 3/8] bpf, x86: no_caller_saved_registers for
 bpf_get_smp_processor_id()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  jose.marchesi@oracle.com
Date: Tue, 02 Jul 2024 14:25:07 -0700
In-Reply-To: <CAEf4Bza7nmnFDvuPLU2xRQ-mZifUKLSiq3ZuE91MCaPoTqtBXw@mail.gmail.com>
References: <20240629094733.3863850-1-eddyz87@gmail.com>
	 <20240629094733.3863850-4-eddyz87@gmail.com>
	 <CAEf4BzangPmSY3thz6MW5rMzcA+eOgjD4QNfg2b594u8Qx-45A@mail.gmail.com>
	 <ab7694e6802ddab1ea49994663ca787e98aa25a1.camel@gmail.com>
	 <CAEf4Bza7nmnFDvuPLU2xRQ-mZifUKLSiq3ZuE91MCaPoTqtBXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-02 at 14:11 -0700, Andrii Nakryiko wrote:

[...]

> > > > +#ifdef CONFIG_X86_64
> > > > +       case BPF_FUNC_get_smp_processor_id:
> > > > +               return env->prog->jit_requested && bpf_jit_supports=
_percpu_insn();
> > > > +#endif
> > >=20
> > > please see bpf_jit_inlines_helper_call(), arm64 and risc-v inline it
> > > in JIT, so we need to validate they don't assume any of R1-R5 registe=
r
> > > to be a scratch register
> >=20
> > At the moment I return false for this archs.
> > Or do you suggest these to be added in the current patch-set?
>=20
> I'd add them from the get go. CC Puranjay to double-check?

I'll give it a try.

