Return-Path: <bpf+bounces-65427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2C8B229DB
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 16:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BE6C1C230D6
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 13:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647BF28727A;
	Tue, 12 Aug 2025 13:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5hWhq4k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA7F27FD59;
	Tue, 12 Aug 2025 13:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755006775; cv=none; b=J0r4S9IuPovEddAsmWYSxck379IfJCs/6FCDpeizLI4D1OQBUkOpIre/qX5miwbnq2yh3gUbyqa22+VAG/iO6f6TmyFkYWmP//RL1FRPa89C41O6q/T/koqF+MMk1QFJ4ZhoyeFIFI87yGE9beEUX2SkBvMCs82berWohGgVTeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755006775; c=relaxed/simple;
	bh=sOA/KDWtEhBU3NsvwAcZGdSBwjJHBeUqJI2hfR+VcmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uj3PiBJQtIoFxHBamssmC8zHcTE8JpLH0GSe10cgDD/GrLrE2v5atNX8D1uXxFSYfjYK//lKrL0si1vs82HbY0aW611gSTUCDAC1VjJAU9vjFfteJhhFAVdhkoWwMdu5aKHkAz7DI0yJBqfWQyKnCzOkSWBE+soa7CPFLC5J/3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5hWhq4k; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24049d1643aso40539815ad.3;
        Tue, 12 Aug 2025 06:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755006772; x=1755611572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M/IhMv/df6igaCY5Ez3VX21KWWi9D8jxwPV8mLr2Spo=;
        b=C5hWhq4kV6A6hUAaZ0R841YiHgCAyGOU+dlUgko7NTSqUWcG8q6AXsv9NMxbPZsqUV
         HLW/vj6Jk7YSGeMlXR2MAsS9E+7g9cnDMZOR+XxYz7mkhv3c050zjr9l3h37Jvh3rSHb
         R3/SQ3BZ6DH2nZy5n0eLfqk7GNzjnA5v9K/Znv+AB/Zgp7KxIZCrH+Tk5BNww223Yu/Q
         JCcUsNFpNKq262lFrgOr8M/7h7YGcnxDHGdduYJ3OeIfu/rUFeV8ZkZF9go8q4/e33z2
         R8sW06XPVNDPAlfWQsUSYcBmy4QSqMpRCOGWhQQEBI0E9eYLjOWarQuwgGQIUJt69jq4
         oF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755006772; x=1755611572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M/IhMv/df6igaCY5Ez3VX21KWWi9D8jxwPV8mLr2Spo=;
        b=QVVcz7kIYD0VDQv+lkGwxdE1I+S3Jq6E/nNrE1Fs2p0QU1OBsvH0kuw3WXlXRhm03A
         iZKDdyczRcLRtYEEqrPM+Cf8RLfHpIE70Eko3pywdmVzOzzFTEXbLp7pY/6KsSEJ1LuT
         GxRZzS8pqZ614nyPa1QXqHjTBQliANVDUlV4mwCCOmU4udtWb7+kkdBUX5jnvqajVarx
         AgiYysYIdZyfUstQwkG0erzd0P0TVCOCsT4lvPZ8Xgu3I+GRBUDhviV7SZ7L9GPcyx2I
         iQb+w0L02zsA/SJ8nQEJgTHDrSmD0zuaM8Gin/dkhy0Rx8j9l+w7Hp5N/t6aPPs3P67x
         pJBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEi4s7vcOBKXkKWumi2LVxkkPV57X3Z457mlGnAqITAkfRbhQW+Jmo8OC2oCUSkkwt/+c=@vger.kernel.org, AJvYcCVzE8Tos9k7mB2yqSpgS7PuIcHLxZhQVNkxJlFzTFec76Wl7en7wzZVUeulh4Gb6sdL580wg/y2@vger.kernel.org
X-Gm-Message-State: AOJu0YzFFq/K/UXXqMGsDwnGBTaCl0oq7YGhgYlbJe+Z2yGHbPMUC2s1
	fh9tHJWEDub+sx3ThWHm77PeQEXsQ+PNdyu9wkWahX6QYSbTaHrzEH+P
X-Gm-Gg: ASbGncu8pk9G1mWncXo7DpIPUS6aVd6cP7TCSSPo+UiEFkFzexoObl4ka76n0M7XPlx
	lUkchsSps/m/UKWoPfSsepRyPVXdWcp2bopWNKmDPaYpzUWyZ7xxf4IziG8MOb0wQmMtFTEVvPS
	4YRLMSdUA3HMvlG1cd4Ht62p6d1O/uyffJJT8NT8b8BLoceGgTJxnmsvo7ZQCamBDES+ADUjFRJ
	1fqfRDj7IP0zfA2pBWBZg+6fliGA7+svsZB7DuxB8TCam88OYw16+DPR5nlJd2jUuNMynDYtohK
	KZCiQngtF/YOMsnkLIReMUU9qdSSAx3tKB+GMK+FuE0j/ITVTINmWiMBZ6+W7yxsPCj5b72aw6P
	iJLQCf42YkA25s2l5+4hTAYTLo2Czm3SRIgW1fKdpWNpxgtCF2nrRqWZNzSSQoDUssEh4W0kK2T
	8Ms8bPWJOb7HoW
X-Google-Smtp-Source: AGHT+IHfIC7qW2hq8meDGhghk76nsMjAJE1sbACh5hYFen3ktZLr+6RyqousAGLrclbpAAxwoPvZ4A==
X-Received: by 2002:a17:902:ebc2:b0:240:86b2:aeb6 with SMTP id d9443c01a7336-242fc33d8bdmr53926795ad.26.1755006771826;
        Tue, 12 Aug 2025 06:52:51 -0700 (PDT)
Received: from ?IPV6:2601:646:8f04:30:c0e:994c:1a00:bb33? ([2601:646:8f04:30:c0e:994c:1a00:bb33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24300f8ca2asm17854825ad.141.2025.08.12.06.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 06:52:51 -0700 (PDT)
Message-ID: <5585b91c-e836-457f-a3e1-3fe7fabe12be@gmail.com>
Date: Tue, 12 Aug 2025 06:52:49 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 1/9] eth: fbnic: Add support for HDS
 configuration
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org
Cc: kuba@kernel.org, alexanderduyck@fb.com, andrew+netdev@lunn.ch,
 ast@kernel.org, bpf@vger.kernel.org, corbet@lwn.net, daniel@iogearbox.net,
 davem@davemloft.net, edumazet@google.com, hawk@kernel.org, horms@kernel.org,
 jdamato@fastly.com, john.fastabend@gmail.com, kernel-team@meta.com,
 pabeni@redhat.com, sdf@fomichev.me, aleksander.lobakin@intel.com
References: <20250811211338.857992-1-mohsin.bashr@gmail.com>
 <20250811211338.857992-2-mohsin.bashr@gmail.com>
 <5a3ffacd-bae8-4ca6-85a4-4369b687e718@linux.dev>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <5a3ffacd-bae8-4ca6-85a4-4369b687e718@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


>>       fbnic_config_drop_mode_rcq(nv, rcq);
>> +    /* Force lower bound on MAX_HEADER_BYTES. Below this, all frames 
>> should
>> +     * be split at L4. It would also result in the frames being split at
>> +     * L2/L3 depending on the frame size.
>> +     */
>> +    if (fbn->hds_thresh < FBNIC_HDR_BYTES_MIN) {
>> +        rcq_ctl = FBNIC_QUEUE_RDE_CTL0_EN_HDR_SPLIT;
>> +        hds_thresh = FBNIC_HDR_BYTES_MIN;
>> +    }
>> +
>>       rcq_ctl = FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_PADLEN_MASK, 
>> FBNIC_RX_PAD) |
> 
> because you still unconditionally rewrite the value here. at the same
> time FBNIC_QUEUE_RDE_CTL0_EN_HDR_SPLIT value will be lost, so I believe
> it should be
> 
>   rcq_ctl |= FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_PADLEN_MASK, FBNIC_RX_PAD) |
> 
> and then the init code above makes sense.
> 
Yes, you are right. I kinda messed up this patch in V2. Thanks for 
pointing this out.

