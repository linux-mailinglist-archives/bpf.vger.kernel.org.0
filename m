Return-Path: <bpf+bounces-52476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAF3A43273
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 02:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D828717633A
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 01:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAAC208A0;
	Tue, 25 Feb 2025 01:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqQTqDZy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E06179A3;
	Tue, 25 Feb 2025 01:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740446938; cv=none; b=SJBaXlPp2on8p3oZdmL6+tSPzI6MpPrmSaIqFkNQKlvgkafenIWtDiF2XBzbkFvW+wghC5sHWc3gT44jiL72VIWTIh8Ifbr9uN+z+oPdo+I2W5WaEpMLH64K8kS3ZzzSOt+b6mL2GcXtteLwAsN/Z3qBaBeSpNCfZLzGyrVbFpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740446938; c=relaxed/simple;
	bh=Dzg91BDWK7zi67v+Whkooj8jJ3afSj4eCpgvCoEeWHg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t3IaosjbqBiA13x8i8MlVYdCtPKYjx9yVA8vdRf4CMbKvJZ56IX2QTxQv/ce4pRtvgSbrYDYABbztaS1Z5U4YYNTCphPW/zJY2y4EQHz2iGvQFAZbYBpHvF1A0UKcdzDB1k4Yhh1Uu9pWxTZ8nbaxzgSFl9d0WiumTE5ldi6/vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqQTqDZy; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fc042c9290so7844244a91.0;
        Mon, 24 Feb 2025 17:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740446936; x=1741051736; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Dzg91BDWK7zi67v+Whkooj8jJ3afSj4eCpgvCoEeWHg=;
        b=YqQTqDZyZwWhVcPNSIw5uXjLoLm1YPLFEr408e0w1hsmXuq8YgjWMcVEESYKjtEozM
         B94X9Ybn3wdygV8w2/venAsF63ZGRDsaIr/9fRBRXSNcUUFDClasxC/POfMFUxkpvSJc
         +uCOZY+jkbMIQQXNxE51Wg9NmAA6/Ud97VPnNDl03bFjMpnmjwWysAzGv5oSwALJFdo0
         34I1yH3cGKYeB7CfYiPfQtLng1WGUVufm4+3Anv3KtfASB4nAzvvthjdzGP0TaCeo1gI
         Gcuzcswn23/MCzAwIQoPLXQs+p6SlUyoeonVXBB5OrsKoc6LGbw2E5pKvsleXc+gNbfO
         iY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740446936; x=1741051736;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dzg91BDWK7zi67v+Whkooj8jJ3afSj4eCpgvCoEeWHg=;
        b=UDucGSKGccEf9/e6mFWJhvdpFLzsIxQkwlLyKuEcGU1VS9EHylpJRztCa7U6kNxF4X
         47g5Py/j6fJc/N5U4LuVW8723e3T/7JDMUEKPBA9rniuQwtSKHCqAiO9dmsf1GeNuzkk
         414X1S9te2ZPWSObT3miIg84sZN+rKKEbrTFmZAQDbJMMd05GhLC8/60CiS4UJM+74MP
         HLKHydpHm8exqAuReEmhQZW7I2PFE8WC4SN/lQIfIY6T/BiLsh6OoPv1P7ntK2/vKtal
         yGK19mschyOwwY4e/6UOqn4vRx9oP8oTtu75o9pk6XmDVb2Fop+QomWYuDrzSFQB+fXp
         4WfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUIWFqITbwSPwlVgEty73l4uCEoTKCork0TSrm7BEIWh1w2kgLmD4Z1s65BJ1JINkFN20oRGG99xBfRsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE3E1RDAGEXgZcgnM73JKSLcorR+Ep8eLfxBkjGGs16tzdqpj0
	PSlfFl/RORG6ooZoxq6pOzjUhBlPclBwlIaAcuqvlEsO01xBYX95au0Gyw==
X-Gm-Gg: ASbGncsVQ/Mf9fA+tiBwXUCbuz7id3Y1jlMLv5ufZ4waaoVU6kw/6d14iqGEinVTVXR
	SaBiGlqkRc5n+iz7ItweIPQ7eziAdg1F4Q8//U6P/UkwXbcqgfIwLva5A2lcLi/zQXoWx0rtsm5
	/qYQpBLUNBBq9KVEKLAtqcvX2hnluVXCUoqrdDSAiMlLC91yuT3XeDZ3zitSBvEpalFJ8p9fhgT
	6sHNpXji/ymYEna7vB8mWArlqpu1seCazjkkMHE3MdEs1cEjFaglTrUGpE4hJXDaNDwowBcXAri
	gg4FOGAF7gkcexgSxHS5WPc=
X-Google-Smtp-Source: AGHT+IFYCcAb7spIngf2WA6YrGCkndPZbjGXi5gy2Q8gYZ5wcUXhuV8G5Boq1GIlH49oMpq+xOaciw==
X-Received: by 2002:a17:90b:4a07:b0:2ee:bc1d:f98b with SMTP id 98e67ed59e1d1-2fce7b058e3mr24105144a91.31.1740446936309;
        Mon, 24 Feb 2025 17:28:56 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe6a43cddbsm309517a91.31.2025.02.24.17.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 17:28:55 -0800 (PST)
Message-ID: <abeaac9dadaddc3b95826eb12ee169558a271bbe.camel@gmail.com>
Subject: Re: [PATCH bpf-next v8 0/5] Add prog_kfunc feature probe
From: Eduard Zingerman <eddyz87@gmail.com>
To: Tao Chen <chen.dylane@linux.dev>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, chen.dylane@gmail.com
Date: Mon, 24 Feb 2025 17:28:51 -0800
In-Reply-To: <c9e36bd3-0903-4ce6-afdc-7deff6d489c1@linux.dev>
References: <20250224165912.599068-1-chen.dylane@linux.dev>
	 <c9e36bd3-0903-4ce6-afdc-7deff6d489c1@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-02-25 at 01:13 +0800, Tao Chen wrote:

[...]

> Hi Eduard,
> I used a simple script to find all kfunc prog types and comapre it with=
=20
> your program, most of them are consistent=EF=BC=8C the results are as fol=
lows,=20
> and i add pathch 4 additionally to fix kfunc probe like=20
> bpf_session_is_return.

Hi Tao,

Thank you for putting together the python script. I double checked
output of the script and the output of the test and find these
consistent.

(I noticed that a few kfuncs are in the vmlinux.h but are not printed
 by the test:
 - bpf_skb_get_xfrm_info
 - bpf_skb_set_xfrm_info
 - bpf_xdp_get_xfrm_state
 - bpf_xdp_xfrm_state_release
 - bpf_dynptr_from_skb
 - bpf_dynptr_from_xdp
 - bpf_sock_addr_set_sun_path
 but that is another topic).

Thanks,
Eduard

[...]


