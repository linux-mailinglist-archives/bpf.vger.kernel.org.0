Return-Path: <bpf+bounces-28533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D32D8BB2C7
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 20:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 187AD282837
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 18:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21FC1598E1;
	Fri,  3 May 2024 18:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvYZx9GF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34631159570
	for <bpf@vger.kernel.org>; Fri,  3 May 2024 18:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714760333; cv=none; b=PS+pUbdVXU5ChuYDgyYseFY9/3448QozJLYYkxWDrcUz9W4tKzULR766x1Ri86KhS/gCoQAekjQaXBBy5gWhKPgC47zmk6Fq9Bbvccmr3wdjt4p5mpelnF+z89UXOK8S23mD9e0/weNLCQ7QdARax+HhgaMKd//Shqv7SU5xRzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714760333; c=relaxed/simple;
	bh=n4KO//L/jCzPEp0GC2ebpiM8u0Aj9ys6cLRrCnDEXUA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mKhHjvjeJ6U4oVytd/X1chVMx49zezuz1HAXnBD2uaB6UXCuX9i+dkQex+Qc1eHivxtxScQWqTkUcp995ZZ8s9HVjvb74QLWMtqzJM5+znkMc5QF71s5jrvRa9AcTmLGibqzKIPyYsJ0nvT2Fwc/ySPHHeGpk83cKxiDXhxVNnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvYZx9GF; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f45020ac2cso19261b3a.0
        for <bpf@vger.kernel.org>; Fri, 03 May 2024 11:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714760331; x=1715365131; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n4KO//L/jCzPEp0GC2ebpiM8u0Aj9ys6cLRrCnDEXUA=;
        b=HvYZx9GFcNxfaaLkZmnLzMnL0hPCn0R97YZ//4Mg68hSkOeGfSFGoyuCML79/rx+Oz
         TnwXlB5dUINWLEp/GFnDcdqHqTbRnHyld7LlO1rQPvMlCQ6KldPfXVgE41HGHY0DPF7n
         W3BnN2jEykrm9AM6jR6QPddDJ/i/X58FJ7dYOyZ6SOiJdfK7GpvI4dC0KRXI/8J7w6ha
         GmoU9NGQ/+C71hHY9M5MYRs7wCvkG6OfkYjYIS04km3QIfkbK15IDarm+kCRT5tcz7nv
         MWQh0k9LorBXkgwT6edHYjsQgHmX9fcj6fGflAetjSthZwVueW1AcUOewcJrhFzzCR8N
         TkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714760331; x=1715365131;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n4KO//L/jCzPEp0GC2ebpiM8u0Aj9ys6cLRrCnDEXUA=;
        b=iNYzT8cklga6KwhyA/2Er+mWMjrjr0WBEjgvzDgfA0Og5fBgD3QxhpOKiyzSL50jYC
         fjVk/KyiicEXZOpXpG51mE+wnsAXX9UxOYcvpzwrBoCB9p9SponAuq0wvHqwZDBcZuXk
         I4bwfxJbWmLO7ZNfPJjXxsJw520ldytFdCH5xVkIaZXDbbUHh/U3WVxFaLDSWSKayGnT
         WyAdaYA/5x3PbiKqbck5+5+r8HC5eJyboI+N3i8s9NSteTG6gNrMTgKG4683n4R5K1fY
         7MSzioNWPn1fbtLZ8AQvwMjRczsV76cSTN2tT7gj+8M1wwxIFyqwCZJflS3zDZsc6HBS
         1exw==
X-Gm-Message-State: AOJu0Yzi4zuB1O+AnBhFTXjRH5hQDWjZOV4WLVuPYNO/mJPqEx8U6z6F
	Z13lt8P2mQPYHHXNXSuAcADCiznMyMBv0c4lwivAh7t2LN9yr5wf
X-Google-Smtp-Source: AGHT+IGDLQVgzy+YXdLOvhOTIjBvrsHA+lWIF3e0NwlIOy4i9POd33cYPbCjO1zGl2EGqdRXHcMOLA==
X-Received: by 2002:a05:6a21:3a4b:b0:1af:36df:5159 with SMTP id zu11-20020a056a213a4b00b001af36df5159mr3919210pzb.59.1714760331354;
        Fri, 03 May 2024 11:18:51 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160:da47:6959:81c7:8b0? ([2604:3d08:6979:1160:da47:6959:81c7:8b0])
        by smtp.gmail.com with ESMTPSA id c6-20020a056a00008600b006e6fc52ecd0sm2337757pfj.123.2024.05.03.11.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 11:18:50 -0700 (PDT)
Message-ID: <402d482b9681aa29f0714d9855a3348a78751343.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 0/7] bpf/verifier: range computation
 improvements
From: Eduard Zingerman <eddyz87@gmail.com>
To: Cupertino Miranda <cupertino.miranda@oracle.com>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, "Jose E.
	Marchesi" <jose.marchesi@oracle.com>
Date: Fri, 03 May 2024 11:18:50 -0700
In-Reply-To: <87cyq2u9se.fsf@oracle.com>
References: <20240429212250.78420-1-cupertino.miranda@oracle.com>
	 <87ikzvt22v.fsf@oracle.com>
	 <CAADnVQJa9h7fgyHN3sbgpPrV7Kk8O+N2NVL4pF4qbE5xf59M9g@mail.gmail.com>
	 <87cyq2u9se.fsf@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-03 at 17:42 +0100, Cupertino Miranda wrote:
> Is it Ok to reduce all this to 2 patches.
> One with the verifier changes and another with selftests.

Hi Miranda,

I think Alexei meant that patch #7 could be moved to the beginning of the p=
atch-set.
Which would simplify patch #2.
The main logical structure of the series makes sense to me, I think we shou=
ld keep it:
- replace calls to mark_reg_unknown
>> do equivalent of patch #7 here, remove unnecessary checks <<
- refactor checks for range computation (factor out is_safe_to_compute_dst_=
reg_range)
- improve XOR and OR range computation
- XOR and OR range computation tests
- relax MUL range computation check
- MUL range computation tests

