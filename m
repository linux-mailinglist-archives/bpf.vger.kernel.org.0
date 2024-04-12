Return-Path: <bpf+bounces-26649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E12C38A3683
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 21:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EE4CB23268
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 19:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B3A150981;
	Fri, 12 Apr 2024 19:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KY3hxYjI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C6914F9E5
	for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 19:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712951455; cv=none; b=K7DRQZkBd16sW7qcP0HRlK2gyo+Bx3eFsCW0LgHPzEDlaKDXYXMSgBkzLDKVHRjtChm8BRmzbtiULajoODy/sfGWcdSDOJqWBtNnBqunMH0uvCz4m8yO9EAvXNC8P7Bxro/ZERb2C/2YI7dKCLLyXd6cr2BvfRoKvrqzAagDsTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712951455; c=relaxed/simple;
	bh=rJnF9EmK9zrV6ejqSk8zdHvrmeJCSMFWdlwMf3gQcsM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cap4Noq/efQKxp936cFjSslsj0dQoZCExCVG9Bc4N9kuV0Bq27/q7msOsIsnInI1lvjmsdhNTzOur23YyCjLnCwKtKhk6d5559ZVx3hCBZbedrQrMOPOgxtlgQq9ndhfPGJTbp11JfOdfpXcIDyc1Gc3fGDbku6luDSrbTm+M5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KY3hxYjI; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a521fd786beso161954666b.3
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 12:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712951452; x=1713556252; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rJnF9EmK9zrV6ejqSk8zdHvrmeJCSMFWdlwMf3gQcsM=;
        b=KY3hxYjI545yagjWDtsQxUlJ9b6zxltdoLveGDAXlrmTBt4UsTxdW3MC/J8/p390Bk
         FxPWvn2st0P9FF1UELOsn25k+jBCerXlLfRAJIkFN1Fc/bl7BdWrDr4HtHJooCyEXOG7
         KKdK+edQGObxCssGqXDv/02fUpwY49XCH6TfhfuUwl/2ka0kXZ8jMKQ+i//Ng+xNW+06
         0YYwPX612QBU+RoinF9Sl/TSQHFyGCH7ncHvMhah7WvfoDLopdccU4ymUPKFmhuO36Lp
         UCcVk9F8QlUW8wvNE7ebnwmlXoTwHtL2BS6TWa7ObDudWKFKnrPr+P8yKmAgrOaz2hD9
         lguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712951452; x=1713556252;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rJnF9EmK9zrV6ejqSk8zdHvrmeJCSMFWdlwMf3gQcsM=;
        b=dCYTMYsEhd8Y2RlzD5FqiLIfc05Dzk8Shhl1qpxiXe03xBdwic94p2fSzMFiRuqBme
         4y4Y08aFZm2E8FHpcOs4OVp8GrTl7RFfHPeJa6UgsV0KcIN/IQXA1Dcy94Ccj7BUCKLC
         ciu6qXTiHZkzwrmyWhxGCRJGu/GoQt+fywWoI/8Egctf71OfC2GQHJ5oKmbOYpI9+YSm
         1hacY9S7b/GDDspHMPJ0i3MlG6HUjE6S5rsg7f69J5468aNOMQOHakpegv0vVrw9laln
         Tsn5xnZOWjBaE8Kn8Jd0Ru28QFd3XtrvlRBT64K3tVj5kXzRxnVtgUOTm+3qB1Otfei4
         KQFw==
X-Forwarded-Encrypted: i=1; AJvYcCU/8DUX1wRR9AthH5Ns3ASodx99nah7dE1JGU2YKmIc3vVbx4Sdp5UxszA08spfBMF5jt1KUSrAXtPI+x8WFzesOiHB
X-Gm-Message-State: AOJu0YxmKOqwITEstruIoC4HuBQKmrThRYJ8uikwexsW62WjyyE+MXqc
	QEBGPvub2Wf6J4KMjf5Vxz6MCwbyuh0upa/jUGqTbkr+sa0MKlqsCBkPoV/J
X-Google-Smtp-Source: AGHT+IGCY8ofdyP8und658JKdwmMhuOuSmA33fwlI7CkUFH6MBX3eIMN+jscbCj696R6rkAU2kQvPA==
X-Received: by 2002:a17:906:40d8:b0:a51:a689:c706 with SMTP id a24-20020a17090640d800b00a51a689c706mr2022583ejk.74.1712951451612;
        Fri, 12 Apr 2024 12:50:51 -0700 (PDT)
Received: from [192.168.100.206] ([89.28.99.140])
        by smtp.gmail.com with ESMTPSA id pk2-20020a170906d7a200b00a4ea067f6f8sm2155238ejb.161.2024.04.12.12.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 12:50:51 -0700 (PDT)
Message-ID: <b26ae694e4f547b7f4e2bc48c0da8b0243cf1da8.camel@gmail.com>
Subject: Re: [PATCH bpf-next 07/11] bpf: check_map_access() with the
 knowledge of arrays.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kui-Feng Lee <sinquersw@gmail.com>, Kui-Feng Lee <thinker.li@gmail.com>,
  bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org,  kernel-team@meta.com, andrii@kernel.org
Cc: kuifeng@meta.com
Date: Fri, 12 Apr 2024 22:50:49 +0300
In-Reply-To: <79781f94-11b2-452e-8a3e-0ac3cf455166@gmail.com>
References: <20240410004150.2917641-1-thinker.li@gmail.com>
	 <20240410004150.2917641-8-thinker.li@gmail.com>
	 <c89a020a219dd2d6e781dce9986d46cbafd6499c.camel@gmail.com>
	 <edea9980-f29f-4589-9a39-d92a715822ce@gmail.com>
	 <520f62bee1e1a037c53dafabf4c4b71adee71cd2.camel@gmail.com>
	 <79781f94-11b2-452e-8a3e-0ac3cf455166@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-04-12 at 12:29 -0700, Kui-Feng Lee wrote:

[...]

>=20
> > Oh, I misunderstood the above statement then.
> > The way I read it was: "after this patch access to elements other than
> > the first one would be rejected". While this patch explicitly allows
> > access to the subsequent array elements, hence confusion.
> > Sorry for the noise.
>=20
> I will rephrase it to make it more clear.

Great, thank you.
>=20


