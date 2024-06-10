Return-Path: <bpf+bounces-31737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 924AA9028EC
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 20:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71A761C210BE
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 18:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EBE18C36;
	Mon, 10 Jun 2024 18:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0RY/oNJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE38156E4
	for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 18:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718045781; cv=none; b=PR3w5kjD2XjoEtbz7u6NOZoJf+F88ONje4+m4MI1WaOz+bBsXYTlciDVuBBpFn0E8fKRXPE/z70P8jXGZzDHo596OuPAzhyofJIAQtkkv+2tAZggHmc/dPPZrQa7TxaJVoc4E7TKCStUYCnhr/IdmhW9DRMhsgbGMXRWEypvQ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718045781; c=relaxed/simple;
	bh=MO+Vn/6OnjkcZwRuFrRnrkROZ83Yroi0nm9ajBd8Q3M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MUjVShahrmcZ6c977U7olo9QTvGnHzSDfe4DR9BaL1sxv2p3akA+IrO9YjlJZNp1FUc3qSm7AislWA3RqI5iq2YnF1B3C7jztrVAJI07ztB1GF8mzdYihcaaHNv40aT/pCgNIkX97cJQ7ydzcY/Y5l9l7MEZS4m87vYnLwTf424=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0RY/oNJ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f6f1677b26so14928955ad.0
        for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 11:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718045780; x=1718650580; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MO+Vn/6OnjkcZwRuFrRnrkROZ83Yroi0nm9ajBd8Q3M=;
        b=N0RY/oNJH2JFC1E/hGVDUJX+rNkGtz/hB3pCWUzzHDXgRWluJFo7ACBFyl0Gvj8TIU
         XNqLmNUllfmXcwfwO1G2GCnlLYMlyDZO5cTmN/pTfqmjjUkjW6ZO3FYqUEqI7XpXa4Cx
         bUWgpVZ5XZob/eSS4dHfkLWEgBDdlh+pqOHE66EgWh1f2sN8FMguTX0JZT7l5oArusq8
         +JZgYHOYESUkAftEqdpWMhlHVSwG8PrHhXQZl2S2i9USZHmnNHdOiBa07X8soL30TbAs
         apQ6uDM235abuoTd6lNZboalCB+GWxd8+xgBUxNvas3yrxbFyAOosUK/1OGgyZp3Ffvb
         SQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718045780; x=1718650580;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MO+Vn/6OnjkcZwRuFrRnrkROZ83Yroi0nm9ajBd8Q3M=;
        b=T1S2E+INNI9Tgx9F5GhgM7oWMSysgMNNEWPwuTMGgytkWElW8pNQFUfmvtFIoOiFke
         pzl7c3N5Tn2DJqmuekPviqKu/VkcVEwIO6tZ/WjUV/+66NeFJMrfg74ELwHZPB3prYTT
         pI5yDBycMGp94V3kRPkhAXiyctByzhagbpzAGgukZN8UPLDFgtE0Z3z2rNsZoIxBsIQ0
         YZo7fBffHzPhsvyn3YUhXJB3KiZHhfySi51BTwFXJKtmG4cyRajuRFVwjM9e1UTbXdyw
         YOZO6P2tA43pl3BWvAtubjrhhRdopXjN3OWvwmZqHfhJk0Yv9ezyEXR34eR3iLDpU7Py
         Zu0g==
X-Forwarded-Encrypted: i=1; AJvYcCWZA7x4CEE8OBET6/XQz5vcWVGzaUNTeUupQLIEO/L36CPq4mZR0ATSk3Czh+23feCj1zfowQ8jq3I1gfnJpCc1Tk+H
X-Gm-Message-State: AOJu0YwbmDuAyOKF9vRDvvRstVoq0OzjUJervbkqYpr9tzTXaiwgUiAN
	WGLT132Yc3iQMPegXrDVHkWDibVZQ9944ySTYki9RgcKAHCAX57Mrpg1dQ==
X-Google-Smtp-Source: AGHT+IGzAg3rE5jbxma84J1TdvML9gwKFOTbBwwCeArSogpX4l+zHxa+kLaAjCvTnaqRu9AFvDF5mQ==
X-Received: by 2002:a17:902:eccc:b0:1f7:1b61:af6a with SMTP id d9443c01a7336-1f728954dacmr7675675ad.28.1718045779754;
        Mon, 10 Jun 2024 11:56:19 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f702e1368bsm34071815ad.88.2024.06.10.11.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 11:56:19 -0700 (PDT)
Message-ID: <53a25fb040cdda5b794a5f1f5f6ddb73571df837.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Track delta between "linked"
 registers.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	memxor@gmail.com, kernel-team@fb.com
Date: Mon, 10 Jun 2024 11:56:14 -0700
In-Reply-To: <8ed1937f85f1f2b701ff70dd7b1429ffc9d250f6.camel@gmail.com>
References: <20240608004446.54199-1-alexei.starovoitov@gmail.com>
	 <20240608004446.54199-3-alexei.starovoitov@gmail.com>
	 <8ed1937f85f1f2b701ff70dd7b1429ffc9d250f6.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Also note that mark_precise_scalar_ids() needs to be updated
to use mask for ->id extraction.
(Although, that function is broken and I should spill out
 v2 of the patch-set that removes it asap).

