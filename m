Return-Path: <bpf+bounces-78863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A767D1DF36
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 11:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F88730599BE
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 10:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A17387364;
	Wed, 14 Jan 2026 10:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNCbsb8j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B97537F721
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 10:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768385578; cv=none; b=IKhq2OdpOQgdsWVLtx9i74znFqLvzSrisl0myRoPcRExYz7DRv11WeGyhNpconTOwMbneBrjxRkcQI8nes+Qk90pM1qaN3kjHVxWsf09uWHUK18ywmmHmVvlp0mIAChnXbJxT/QkZWTF8LzboZJpFjZp4ML/L8Kbf/2SiCvQFfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768385578; c=relaxed/simple;
	bh=fFcM9RtqxbQ5t+zIYcudl8N7luiDJcyvth1G8tkCYjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibCQ+tx3/LISwDkHCvU+7lD8TEcSQ8B0pjSVRT9uN3nFivNpirkj4qExy6ZuVp08L/u4QfhZLjKv4TFkN4BeJVVBQQjyrwyCJth4GEWxbKFwuO9SCvb5fxxpglHJEoRK7DHMb7H2S3qoBQTc4cPHwqWU7ByHApyUbojKZ/IZoT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNCbsb8j; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so1788948266b.2
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 02:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768385576; x=1768990376; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mNTOEHnhVvM7C2eGncC1rKFRPu584plveum7Im4UG0U=;
        b=TNCbsb8jkmB1ybncdPf9GvKsvk5jxywrymfXfQYwMqFk4kTBYAabyBfJlAH6V21SSo
         UWpK6/4+lGfqqBSstvtLBR9ZU7J3AUNuCjI2c+av4AWHPv7ErQBnYieYBP7ClobnrQtt
         gvZZLLz65cE66W4l0CRwLgDsrAnO9Gq0yhVjk6YkwZue8KEjYEKh5rzmJa9ZK0mV39DR
         xqGsNfI7JhQg2lTny0HwMnHmi37wxHKpa8JxByRBCcaeAMg7jfmC4Nng48bxhccNk92V
         ztdlAfz9aPeGex2pFrF6r54kpXtSGxyjClCU1kUWFuDbQa0WMq850KqKjPkTGprot373
         2f3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768385576; x=1768990376;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mNTOEHnhVvM7C2eGncC1rKFRPu584plveum7Im4UG0U=;
        b=pVZ+ZUpJzPxBh8quUWtiZdLcGsPE+kzFZK7nsGOLqE/MncPXIs5Ltde+ozYcdLhkbS
         qkJei5ZOzFFY0w0KrHN8fqooByDNIRoWnMNZWC7LmtUdRTy8BKLV/XCYaDBF3EcUn7CQ
         L4vEV0FskbJMwR7gsVS6WNqjd/Pr19xax1GLZAxzaTySKp+zoZUTEsHCjyBCdfsVBGMp
         5Vx7qalAtSZqTZmRHRiC68a2f+t5Jzvj+CTn8v9CODY/2iGCFpJypoc6dTRfFrlU3Pu0
         r3aaR9iZKNMmjJGTbrpjgM+t5bjess/S4YLO4InBrARU1n4nebGvDaw1Z17Xzec0utTu
         sghQ==
X-Gm-Message-State: AOJu0Yzq6fcujt/cZbFI305KlGXPD2ryBiBEJTcfxjzNphWa0ApzHi+9
	R0hGE7hm2Cb1EfT7atCQ/xvEH5xUJC4d+ySHU3lbsTJXvJMSmcEiy0JA
X-Gm-Gg: AY/fxX7I8a26DDFwEW1SKsB7+KXBwMH6iDr2CiMvhjS+28BYVPjrwloCrZXTH28PLSv
	N1XhoNIjAzj07Y2mv3AFiRfR0tPTqDJVRMOeuJxiqcCUZODs6jwcsNF5y1s4sJRcr3vOZzhNw4/
	ZriyJpE3APEs17a+UnjjXnGxoYfEfXxssq91UtGKXGpDqmarNEttKoYLbSaCc89Jf2XuM6l0uQS
	Ha69i34GW1Yomb8a/m6rQBpit+SbiIvRWTUO1M/GNkAv2YDlrBwlZPhO8MX09TdqqyMX+wOXOLE
	NXzr6+q1sH8cnWQwUtxxCZARcNDARnBLxwUHLyyOKx9vztdpDUkCMnsI1b+qgiONb1PBt/AqBix
	dIbzlsZv8aVhub96aJurw1jg4lH2QIq46q34Wq5C7iVk2prTRYY8WrCjUUmfOFNki0TAzr7gG+g
	ciVQNdJiCmxlZKirZN64qSp8U29HxQHrM=
X-Received: by 2002:a17:907:9409:b0:b73:32c7:6e6a with SMTP id a640c23a62f3a-b8761087500mr190570466b.25.1768385575573;
        Wed, 14 Jan 2026 02:12:55 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b86fee09163sm1167530966b.26.2026.01.14.02.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 02:12:55 -0800 (PST)
Date: Wed, 14 Jan 2026 10:20:42 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 1/3] bpf: insn array: return proper address for
 non-zero offsets
Message-ID: <aWdt+i/ZISOBEKkP@mail.gmail.com>
References: <20260111153047.8388-1-a.s.protopopov@gmail.com>
 <20260111153047.8388-2-a.s.protopopov@gmail.com>
 <CAADnVQ+6aByMvKttzhMWSSHM=mwiZnAd9CLVE1beHoC2o1xvrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+6aByMvKttzhMWSSHM=mwiZnAd9CLVE1beHoC2o1xvrw@mail.gmail.com>

On 26/01/13 07:42PM, Alexei Starovoitov wrote:
> On Sun, Jan 11, 2026 at 7:23 AM Anton Protopopov
> <a.s.protopopov@gmail.com> wrote:
> >
> > The map_direct_value_addr() function of the instruction
> > array map incorrectly adds offset to the resulting address.
> > This is a bug, because later the resolve_pseudo_ldimm64()
> > function adds the offset. Fix it. Corresponding selftests
> > are added in a consequent commit.
> >
> > Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
> > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> 
> Applied and tweaked the subject line of all 3 patches.
> Please see what I did and don't invent new prefixes.
> bpf, libbpf, selftest/bpf, bpftool, and "bpf, x86/arm64:"
> are the only categories.
> If you see others, maintainers were too lazy to do fixups.

Got it, thanks!

