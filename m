Return-Path: <bpf+bounces-49597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA80A1AA21
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 20:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54DF1166C35
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 19:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A178A1AA1DC;
	Thu, 23 Jan 2025 19:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJLqOeCO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39DA157487
	for <bpf@vger.kernel.org>; Thu, 23 Jan 2025 19:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737659612; cv=none; b=RL2aJYeEhclM9uMxXkoBjlbkmL5+pXXWtYyIr1oo5wJhra4bduPl6VGP42K8d2uO3DgutsSY+ZCOLh5hmfp3pkefd3DhfpNywcs2BYWaFb1QYC430dKJh/+V/CzBfuQ6pJeeF5SV2H0IO17Nrbxa3hjLdelPvS9dEC57XCAHcZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737659612; c=relaxed/simple;
	bh=g1vR28Z4yCJu5ATJbkn6IOdn2y/yk2llxJdlKawcgKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cK6U7wi294E1JxFaXa0s4siE3QsSgtuy3B5c8UHdaUWpLHgkEEZI2mRJPbnmZm9hf51kv5zDiGCbch50g6sKrNJ6S6la3h8T/BGUsDIAqsROh5QBTq5srZ8Y49EY2+lEebqPiZEEr2cdzNoVS6K0QspdlK1fRjhv8lp0VeNI+LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJLqOeCO; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21670dce0a7so26402515ad.1
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2025 11:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737659610; x=1738264410; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+WCaRghUHCjK8U17Z1ieHfFRFXhOPjbXt9eCUGcGkSU=;
        b=UJLqOeCOSObGYjbsVaTBLNafq7rF76DSxa/F2xkym0OxdZ7AOKlBseMrslMw2oHJfO
         ynpIc6onfELsspd3Q0mnIKWtsZncxsX8I+9RPw/oHVbYBu4vf0907JsFiQr7WAt44NSo
         7FUYoQ1HtodmFQ95LXo29EvXlG/Ivs/i1/Wd3JEOpQ8vzfimQviYBraji1fxOoVwRh8U
         nMqzfCOBZHOzVJvx928YijGTd5wBXbpK9xbS3cfYNIBcaINOnFMJ0MDIdDrFsKYc8SFN
         IsgTWZFr8i/DdgfRJSrO4jpayVePiweEigUbLcF4JSlDVJVhrN6LROzZqbotbr8Z948J
         kBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737659610; x=1738264410;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+WCaRghUHCjK8U17Z1ieHfFRFXhOPjbXt9eCUGcGkSU=;
        b=tT+HQYUiGASbicFczPAg3IH5H6brwXnMxKGmKrm8kUj/+6uiiCRvazbnEzYznxTXWS
         1TVU9Pnj3S1aVywc1y8r8lTuS4lYQphl7kGoLB4obhHuaVn/PeJcU0Dni5eoQk7fgeC3
         Mmsf/kN76HXDDqbhcjvKGpXjlNV/oE5AUk92ZNFL3psUuZIXlp91JpIDGpwp55EccfWB
         kuOYeP3DJCUEiwbJXIc2m98OX/dS3PmwKg11uuvhywgRp9nVuU0cx78Uj6rsAcAF17ML
         BEX31I1jL0EOHbHDrLmnoLh+d5BcuEuL9lOTmxU0v6HT+Qad42VSJjfLdT91XOFF2uu+
         zmNw==
X-Forwarded-Encrypted: i=1; AJvYcCX2sEnjlUxOXjLOboJT7ZGtbVN97JtWPBrkKdZFwYMulD1CmdzXY4rjRovgoKltP/pLj3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YySksYIzydamm0D1aVAGXxGqIyMsxX4qTKvygD2OyjK9eX8dXGz
	ySWFFZXLh7M1jDRa0Shf/K0bgC2gWli6zAFY+peJe5uwdWNakfQ=
X-Gm-Gg: ASbGncsEbkJG7197irzm/TOV7MywlWTVsjr4aTx1Fj2+Mc3R7359QHawhtsZif4w8Ob
	OJZcRFjp5IodO1KqQUwLWTPbBe7gSXB2Xd5fIs6RkcC/tMKREKiHQ+vCIxXuwXLmY+kJfjTW2ly
	fNfYgDjY5mlHPlj+oUXlF5G6323tN4uEtkOOVT2mSgYhSuON9Ho/ZJF4Nytm6n8ARTI139JfgbW
	xLw7ov0hQZaKHdNQ+iHFlWNoF+AXXvCAAl/HbHxHswGkKLvxsTOGChdWPwflKLo1Wxdr/OMDsVv
	oREXCpd4zc92ghWZvpKxwFU9BUxmUXc8XRl2ymQ=
X-Google-Smtp-Source: AGHT+IFpSQaXdVpI4E/UkZXhqiUdaMe/2f/me0QnXHViX1ec3pX5mH/scEyzedCFLX5aS5sCKoDvKg==
X-Received: by 2002:a05:6a21:7891:b0:1e0:ae58:2945 with SMTP id adf61e73a8af0-1eb215ea56amr48274968637.31.1737659609897;
        Thu, 23 Jan 2025 11:13:29 -0800 (PST)
Received: from localhost (c-174-160-0-128.hsd1.ca.comcast.net. [174.160.0.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a6b2c12sm296686b3a.44.2025.01.23.11.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 11:13:29 -0800 (PST)
Date: Thu, 23 Jan 2025 11:13:28 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>,
	bpf@vger.kernel.org, Stanislav Fomichev <sdf@google.com>
Subject: Re: RX metadata kfuncs cause kernel panic with XDP generic mode
Message-ID: <Z5KU2KM-cB_tS9sU@mini-arch>
References: <dae862ec-43b5-41a0-8edf-46c59071cdda@hetzner-cloud.de>
 <87msfhqydl.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87msfhqydl.fsf@toke.dk>

On 01/23, Toke Høiland-Jørgensen wrote:
> Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de> writes:
> 
> > There is probably a check missing somewhere that prevents the use of
> > these kfuncs in the scope of do_xdp_generic?
> 
> Heh, yeah, we should definitely block device-bound programs from being
> attached in generic mode. Something like the below, I guess. Care to
> test that out?
> 
> -Toke
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index afa2282f2604..c1fa68264989 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -9924,6 +9924,10 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
>                         NL_SET_ERR_MSG(extack, "Program bound to different device");
>                         return -EINVAL;
>                 }
> +               if (bpf_prog_is_dev_bound(new_prog->aux) && mode == XDP_MODE_SKB) {
> +                       NL_SET_ERR_MSG(extack, "Can't attach device-bound programs in generic mode");
> +                       return -EINVAL;
> +               }
>                 if (new_prog->expected_attach_type == BPF_XDP_DEVMAP) {
>                         NL_SET_ERR_MSG(extack, "BPF_XDP_DEVMAP programs can not be attached to a device");
>                         return -EINVAL;
> 

I'm assuming you'll properly post a patch at some point?

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Might be a good idea to extend bpf_offload.py with that condition.

