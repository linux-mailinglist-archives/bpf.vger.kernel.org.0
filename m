Return-Path: <bpf+bounces-30165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8618CB58A
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 23:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CB62B2157B
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 21:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D42A149C49;
	Tue, 21 May 2024 21:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DvdswmPa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBD3487B0
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 21:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716328751; cv=none; b=gQwo4kn7NFkx2TRG9itfFM3ydu+9Zi5PTXI0wVH1tb8t9LydTBGEmeMxT9CgJhnLi7pm3aDtYP4J/zq9KuPuT5Ei5D3acnxSYbuJRjYKZlar5RD2spjveYeDyD9dfAP4g3w/vu410FsbH1lJJHPV+fKei2ENggOSR9F6DUi+xlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716328751; c=relaxed/simple;
	bh=XaigkbOwLK+o1X5tNLLDmxiVQ6E5qgREURmagb19brs=;
	h=Message-ID:Date:MIME-Version:To:From:Cc:Subject:Content-Type; b=mHhbC0fF4G91dgSPyxHY1LVXU9xQL4czfNsvPLaMLhMUje1a7hp7zQt0zoSMXVve6uHcoqwVl+eGokyTBzHUINjE/F7Tltf4FgrPkH0YAZrpr+UFOAys4jO2jMITdEmgqq7rkYpfbCXmQF/Iaum7r0Q7aKVc5TbtF3WzcQsXbFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DvdswmPa; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-241ad94775eso2409076fac.1
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 14:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716328749; x=1716933549; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:content-language:from:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCulgS4xL8QwT0myBjRcudy93UEfdd7jkeB5GVj1pM0=;
        b=DvdswmPaC7SN1it7BBpUXfhCIbu260xBxmZtTPPl1aier+w3keUuSrsrb4wA9W82Rg
         33tVll5y75lIH9oS8ZyTTR+9CfmvTET1kCvD2UPjf6sbUxgB2d0eOgTW8/AnUVs9EQF7
         ek5Vbc/5DKtYF/3ZxlJoeg6hYvvuSmXuUGPbk8EQucNWOw9tq/YopzeIe87l+/YcCG2z
         GYaXNNH0Ro+lS65EMwkm3hFZ5Ld++BoTGPyFlqo93wo8AH3AU3vfoNoj6YGra5RBozzS
         WwrvVvP5AO5z2MVvFaiQDUKI0d56vLH3H9x+UJxGa6/W7KgrXl8QWAvQzw1tIyBBniAt
         S3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716328749; x=1716933549;
        h=content-transfer-encoding:subject:cc:content-language:from:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MCulgS4xL8QwT0myBjRcudy93UEfdd7jkeB5GVj1pM0=;
        b=dpcRenEdhYzkI7AZKsV89Ur6ScjTnHacduJk6WwgOyw2/TIdXob6RsHtk+NXW2bvo1
         ywXcZPktZFXr8UrWS2U2ujJdchydUnW1IiMBTu8oM85k0pf16kTnqg+pZOOoTVSjFpHl
         fm4KPNGdMcovRUhHachxSU4v76lyxVNikbynKkn7NCT75bc6loxMJ9THiT854RM3QFxz
         6BtRDcLg9laJTkXgXsPeLSCoJ7Pg0yaigXknRf+qZLkrs2wvImnGynADsZCm55JmCP+X
         h1ivPj+oc3gk4l6u0CkLNYqU3b0bIbze7VFXvy4X2MOlglaLs1bhhDf170KgLMgiCSBn
         5tlQ==
X-Gm-Message-State: AOJu0Yyf+2nO2FeVGv4P6njnTa4MpXLRyPqLldOXv6FCa+znOJ8srwVk
	pNLdRLkYt8BMtLMNqwu/KG40aNioHOM3qYpg8g303YSu2XY1w12cUkQjI1cFORmgWNUhqXYO5qe
	kFA==
X-Google-Smtp-Source: AGHT+IHx6jonqIFa28/KfwEWCM1lIs6KPl1kellunQcIBB5W2n5X/PcNZ83GJh7ub3R/tbF9xsB/rA==
X-Received: by 2002:a05:6871:289e:b0:22e:a686:a943 with SMTP id 586e51a60fabf-24c68e06585mr375937fac.31.1716328748902;
        Tue, 21 May 2024 14:59:08 -0700 (PDT)
Received: from [192.168.1.8] (c-73-238-17-243.hsd1.ma.comcast.net. [73.238.17.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79312697702sm488173585a.12.2024.05.21.14.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 14:59:08 -0700 (PDT)
Message-ID: <3faf9614-d61c-47a4-b8ba-6d97ae71fd44@google.com>
Date: Tue, 21 May 2024 17:59:07 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: bpf@vger.kernel.org
From: Barret Rhoden <brho@google.com>
Content-Language: en-US
Cc: Dohyun Kim <dohyunkim@google.com>, Neel Natu <neelnatu@google.com>
Subject: BPF timers in hard irq context?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

hi -

we've noticed some variability in bpf timer expiration that goes away if 
we change the timers to run in hardirq context.

i imagine the use of softirqs was to keep the potentially long-running 
timer callback out of hardirq, but is there anything particularly 
dangerous about making them run in hardirq?

would you all be open to a patch that makes that a flag or something? 
e.g. BPF_F_TIMER_HARDIRQ.

thanks,

barret

