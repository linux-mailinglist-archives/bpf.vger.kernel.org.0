Return-Path: <bpf+bounces-37531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5230B957401
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 20:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42901F24E25
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 18:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A107E188CBB;
	Mon, 19 Aug 2024 18:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SSAMbic5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BCF188CA4
	for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 18:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724093649; cv=none; b=ibA3brZeaJymNJpIigacHIGl/cIZTArZCiIRtW+jfqJlZVBNZ000jq+VXlfuBZE3A5/c4ZdAc+B+zJF0esJ9c6nsykQ6+rbmpnz8wJqYysTkYxQ8Mg64kA0HoL68WobTBxsDvVr4F2MqRn1TJCybL2ZtAiEIYfrGWetHOTv8Zr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724093649; c=relaxed/simple;
	bh=VWqQftthAzmWXdpjfUY7TDCUh996cQQqcaAE9eM/h/o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FheZyFAglYmDM4XOLnwpEzKbvUMz5zqTACo0NVAl5iKZNeYPCUBQhN+5ozJAf5oN3re/T2sA2w7qdpF4KSY7YFLkj0IbMhxEMFGFu+RQDqKAK/mNKd2enN8Rr7XK9+FGBIYy2sBTDEJ8XO3YVGgUfubSKlqJUZ+bbHQkGx1fko4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SSAMbic5; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5becd359800so3554192a12.0
        for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 11:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724093646; x=1724698446; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uc+P+VQxiYpJwnTL0GIqg8VREBTNeIMEPpLLIIekbpA=;
        b=SSAMbic5gGMxc6dIqLPTByGwTBdoi60XZzHcKEF55sMIIM9eDzyxFgCFCA3x+nbRSK
         riNH+UHznMYlPfo+nE4g584MN2yrwc15VvKj/PNfemctZTn8Od0D21aVnGf2g2oWWwiU
         jvziicNdTYO8YwfqC9RbB9/tNwcx9DyA5QlmaIHR5S+zPE00lvlVrf/bnCZShgyP0SqU
         8ZpoL6PCo3V4qPq17P7rnJK30Frv9wbxLe9g+76437wA64IvdZaWQr+n3UMuIVZPs0lW
         N3uMXh1ZThFoBS7d+QzlF51edt5+OF9XRseVFsQfPa/wHe+GDMi/cN/wFAaGdof7G1XR
         JDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724093646; x=1724698446;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uc+P+VQxiYpJwnTL0GIqg8VREBTNeIMEPpLLIIekbpA=;
        b=vhMl5JibUE+VoUrp8Z7/KeQrvWoOg9AOrWdaq9zNdgFk+ts5T+2OVAjo9uQCiauK99
         B+jGrQmRGJMTg/34qo4BEpzXJ2XNtPNfrXONrY1m/HWQ3n9pnVK/bWgFPLqy2CIYr3T6
         OI+TfzyrbbVTnAoWYldXfOu9130zPdxkvp08Qvq9RW6jI8xlISFAcaWYqlfq88v6BbL/
         n9eTU//vO7vHQi2PXXayjwUq3CVnT6w487X+jkMQwmLEcNuGPuubIA9ctPsoCLiAnyXX
         eyw8tyWuR+6hCBy+V7Bt28kCWv2Bv/QNRXDxB3HpQbW1Ozpoj9mTwHXA0KFrpiJIAKVf
         17Ow==
X-Gm-Message-State: AOJu0Yzo7J16jpW5VNNdkV92E6d6eMRvCt8aoyRuf4HHeBrlsux6xozH
	wdpWKsraHKU+Gsu4CuoSO8Uz/UGMuCF2liHohuEPYW2Qz3HnQhBfH/tFhzGcsgTuGjPbfsu3Gfj
	9Jic=
X-Google-Smtp-Source: AGHT+IEy+hSOaiJUKCk57O4HkN9x/BXh+80YDJpf1/zTKkytFqRl4wekMTyIYT1Lh7qu7vswq/kgCw==
X-Received: by 2002:a17:907:e2dd:b0:a7a:aa35:408d with SMTP id a640c23a62f3a-a839292f832mr766381566b.20.1724093645654;
        Mon, 19 Aug 2024 11:54:05 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83839342e9sm661780366b.110.2024.08.19.11.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 11:54:04 -0700 (PDT)
Date: Mon, 19 Aug 2024 21:54:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [bug report] selftest: bpf: Test bpf_sk_assign_tcp_reqsk().
Message-ID: <6ae12487-d3f1-488b-9514-af0dac96608f@stanley.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Kuniyuki Iwashima,

Commit a74712241b46 ("selftest: bpf: Test
bpf_sk_assign_tcp_reqsk().") from Jan 15, 2024 (linux-next), leads to
the following Smatch static checker warning:

	tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c:493 tcp_validate_cookie()
	warn: off by one 'mssind' == ARRAY_SIZE()?

./tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
    462 static int tcp_validate_cookie(struct tcp_syncookie *ctx)
    463 {
    464         u32 cookie = bpf_ntohl(ctx->tcp->ack_seq) - 1;
    465         u32 seq = bpf_ntohl(ctx->tcp->seq) - 1;
    466         u64 first = 0, second;
    467         int mssind;
    468         u32 hash;
    469 
    470         if (ctx->ipv4)
    471                 first = (u64)ctx->ipv4->saddr << 32 | ctx->ipv4->daddr;
    472         else if (ctx->ipv6)
    473                 first = (u64)ctx->ipv6->saddr.in6_u.u6_addr8[0] << 32 |
    474                         ctx->ipv6->daddr.in6_u.u6_addr32[0];
    475 
    476         second = (u64)seq << 32 | ctx->tcp->source << 16 | ctx->tcp->dest;
    477         hash = siphash_2u64(first, second, &test_key_siphash);
    478 
    479         if (ctx->attrs.tstamp_ok)
    480                 hash -= ctx->attrs.rcv_tsecr & COOKIE_MASK;
    481         else
    482                 hash &= ~COOKIE_MASK;
    483 
    484         hash -= cookie & ~COOKIE_MASK;
    485         if (hash)
    486                 goto err;
    487 
    488         mssind = (cookie & (3 << 6)) >> 6;
    489         if (ctx->ipv4) {
    490                 if (mssind > ARRAY_SIZE(msstab4))
                                   ^
Should be >= instead of >.

    491                         goto err;
    492 
--> 493                 ctx->attrs.mss = msstab4[mssind];
    494         } else {
    495                 if (mssind > ARRAY_SIZE(msstab6))
    496                         goto err;
    497 
    498                 ctx->attrs.mss = msstab6[mssind];
    499         }
    500 
    501         ctx->attrs.snd_wscale = cookie & BPF_SYNCOOKIE_WSCALE_MASK;
    502         ctx->attrs.rcv_wscale = ctx->attrs.snd_wscale;
    503         ctx->attrs.wscale_ok = ctx->attrs.snd_wscale == BPF_SYNCOOKIE_WSCALE_MASK;
    504         ctx->attrs.sack_ok = cookie & BPF_SYNCOOKIE_SACK;
    505         ctx->attrs.ecn_ok = cookie & BPF_SYNCOOKIE_ECN;
    506 
    507         return 0;
    508 err:
    509         return -1;
    510 }

regards,
dan carpenter

