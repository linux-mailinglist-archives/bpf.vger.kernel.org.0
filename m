Return-Path: <bpf+bounces-19833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 865C4831FEE
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 20:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B802C1C20BE7
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 19:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947552E627;
	Thu, 18 Jan 2024 19:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jl5a8YnX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52842E656
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 19:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705607613; cv=none; b=qeZxWuMSlK40/lwO17nsfi7pfqq/fFarIJbxdbzAJ0XI4PT/paOGDFCEj4nhZqyceZMQr0Ud1oid86NFa+pQ6oUwhlAIE+tl4bspxUIJDjGwOKe2sjL7bEQs/SGtvH1A5gMUdvfthUG6eWtEXExgIBBc914Bay0vGpKucF1YQyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705607613; c=relaxed/simple;
	bh=rReXPv2Hg82ZBMsXiRwrui9oVd/ehecCJgFVXAKULL0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d6/KLvZ+tigUnIVM3+CNNwDfDleL32SsvuHMXHDpuv34CYG+8gtjKf78OBAkekXTaPvevL5tHlTkCDKEd6sApVa4LUwCpwG8NhQRocUsyrEFwyqQJjYpyrl7kwOBOnE3xRB4eG5UYurHEpCh/w188js5cCHwNTQY62sZpdF0nn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jl5a8YnX; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-337c40fde20so1917129f8f.0
        for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 11:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705607610; x=1706212410; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rReXPv2Hg82ZBMsXiRwrui9oVd/ehecCJgFVXAKULL0=;
        b=jl5a8YnXZEslW69aXNO5ZXLADdq8a+qWRQDih3gfbbv/MGWaWEXKpoqTkpDiVgaYfM
         PXWgM8z7pQ6tdewpe7hTccw/dOeIG74oVElSaPKOu7acPDQeQgbgxLdUUDsDUPHW0HTk
         9rxYc4yx/4xSoZASXCyTnt0YI7ajYnO0l8Ok42jIre+SRwep2SFnbHYl73960SjHYsnr
         dS/lrEsw+j1/u4GEQTk4vBtY+J9hSZuSv/30K2fwk/4XDSYsiQWRDBjAgLkGe1UVy7qJ
         QBWdOZgFXnIIlwe17oL4Q/RJnN4MasfMr4uttcwhPqiZGk+NC/g3QS3HnQSI1ZxutlMJ
         vSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705607610; x=1706212410;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rReXPv2Hg82ZBMsXiRwrui9oVd/ehecCJgFVXAKULL0=;
        b=D9EgH2kcjmEN7JRTSAuE+tE/jhxV6T0WrTfZ9DqWXNhwZBMqO6/EBYEPUSAx+spz76
         MNh72PfVTb6cqrpI6bksl5rixcFnc6BWxXCstw91fIZdoEoak22xVBVl+ndd3zLuGiD5
         /u6XhkJNnsQ+11rqYodMXAwHISm82b/lLYu1CQaOyQTrXZPrqtN20p3BtPBBF0KHyLkY
         UOlwLqClPN9lSsxTrs7+PbqT3teVdqt5f+La2iz2LtUk/Zel4IHDB4ZKa3p5wD7wcnCB
         oNUS3MInFnZB5guRRoMNVSnSizf6+HfZUXI3WanTru5Qmd6vGNNPPNWW/hSCnFsrHYqz
         PfJA==
X-Gm-Message-State: AOJu0YzrG2SRzkp+GQN8iOfqsLey62+IzPnhUj5uD8XfxQ0fOqrEOBuH
	sZDLD0ASF3BQY4E459jXPObRHhVGCYCVYtA7t3/FCVclhMubrdpxhfBL6MdA
X-Google-Smtp-Source: AGHT+IEmVJ+T7iy+qP1AuDdW628RROU3FaZwwrmRJYvJ1ZznvAboEPCZGxIYu0fLkwoCjdU7cesQaw==
X-Received: by 2002:a05:600c:3396:b0:40d:7f19:40b1 with SMTP id o22-20020a05600c339600b0040d7f1940b1mr847587wmp.169.1705607609760;
        Thu, 18 Jan 2024 11:53:29 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id jg1-20020a05600ca00100b0040d4e1393dcsm30255133wmb.20.2024.01.18.11.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 11:53:29 -0800 (PST)
Message-ID: <8d2edf0d946656d0ba3e5a6c279da194a473020b.camel@gmail.com>
Subject: Re: [PATCH v2 bpf 0/5] Tighten up arg:ctx type enforcement
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Thu, 18 Jan 2024 21:53:28 +0200
In-Reply-To: <781173a0f5e6eb383b03fc85dab3927ae88c52a5.camel@gmail.com>
References: <20240117223340.1733595-1-andrii@kernel.org>
	 <781173a0f5e6eb383b03fc85dab3927ae88c52a5.camel@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-01-18 at 21:49 +0200, Eduard Zingerman wrote:
[...]
>=20
> I've read through patch-set and it seem to be ok,
> checks match behavior described in patch #3 description.
>=20
> Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

Oh, well, I missed v3.
Never-mind then, sorry for the noise.

