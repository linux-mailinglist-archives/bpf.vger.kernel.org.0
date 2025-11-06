Return-Path: <bpf+bounces-73819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3135CC3AB86
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 12:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4613146411D
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 11:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12AE315767;
	Thu,  6 Nov 2025 11:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUaY63x1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QykzFlY0"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2E930E0E2
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 11:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429677; cv=none; b=pFvwydp3dlf1HpLTmWzWCOyCGX/QcZO4cFRY9w4VQZbQWUt1N0+3CLa7UpgCiNpvgDIkSZBT6KYFTltTUbPUaFZxsyWLYp8yk9eHggdiF4dDQb8xFGmXYOTtLhDfQxLpNAUXhMnJJRfu3wlAUc0yt2Cm0tu+c2yRvk774pPKEGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429677; c=relaxed/simple;
	bh=D0ESafiFnrAHx1xAZJLjIGxN45DgsIeRyNfJcnFl56Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RUtHMCysdKMk2PDRIWw0vnqCp+J8kvjgNIwqwQ6wzyWIEb+PjwgeQe0xiMSgYfinxO6Vis+nDr1L+48ReZhIzNIAYxHPhoFadrLVn+dEbrSi7vE1CQMzqiwOq2l3aVRwUbRtBDy0f6a7yqYrLIMoK5cMqubjlVShAZGZuJjGfu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UUaY63x1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QykzFlY0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762429674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0JviuZOYT5VOJubSBo7kcaUm1NAOOfzcTxwXg/1vMe4=;
	b=UUaY63x1cO40/wbCYMQ3MnWBd+yJ9BQtSze8PMeRUOQht3AwVqCdMW3ks+YqsBq+jWkkFi
	KE/m9umDapcOvE7SqvDtTqvMaMG4I2Up9rFSBFitVJVxB19K88+mttfKDLocGJeJbllB/h
	o3kVEcJmW1iYpK0HigSVjVauCPRqfS0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-tu7JfSdlNxqvbNtXicg2bw-1; Thu, 06 Nov 2025 06:47:53 -0500
X-MC-Unique: tu7JfSdlNxqvbNtXicg2bw-1
X-Mimecast-MFC-AGG-ID: tu7JfSdlNxqvbNtXicg2bw_1762429672
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-429f0907e13so216090f8f.1
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 03:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762429672; x=1763034472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0JviuZOYT5VOJubSBo7kcaUm1NAOOfzcTxwXg/1vMe4=;
        b=QykzFlY0LZCuy3V4UnKJjHEt87nA2uZY8ivl9Bs6bCXUVr0Wtjg/AW8OF41QPjaUY5
         SxQpQm+u7NDV7tYxnmmBBbs9y/ofVzOskLTsMHAIupmjBmEVQslSYEY2m8uDkDrxw05t
         0UwORE/od097juxNbnNi0yt/TBKQvwr2bykKtxT7z3RFaSRvdHtoPvX8j9zDM2DzUvKx
         1v+duEob9eLRj1cHep5PESbsYVFgvD0Wp1RquD+IgNorrZg/En6uH/zqHs7UB5Ta/JRX
         JuWG3OVfMRaeQioyzF8GBxYUlbJT7z8+y4mnaI/EpFa9bs8U4KiQS3TrUTP96l2DVX79
         HX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762429672; x=1763034472;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0JviuZOYT5VOJubSBo7kcaUm1NAOOfzcTxwXg/1vMe4=;
        b=d75au65SibmmXclOA5IBvPhmCXNnAZLAKxYjOS1k7gWG5ZD4R87aIyb165cS5HASLA
         QOl0ZEzQVRzwutRm5rWWJL/BbUxeyakA4AiSNAYtDnK8wqYX8HzS8gEOerwDfM3Budax
         ZvRQgp40TNk7rh7ahe611XvqVKfnxzDVsRoipvE2ggegUMMVbWp/EyA/zNfdDn8v8RGW
         93pv4Uyi6NpvFeEk4sH3XQFKrsNJiGXzEassWOdOtMvwrvXg4EHLnE7IlOqYxUhWjTRW
         xy9+XkDR8SMuk4MnOq80YxvLAQroKT6LjpSZ23/36VpxeWUg4EgnUr0btCiBIdqD9ztT
         ikfQ==
X-Forwarded-Encrypted: i=1; AJvYcCULLRyQ1Z2XqyU4vr1WL9R4H0BRG7jaqZaE3kkX7SnvsgK1T7f9M0za+lwgUDhTPz2Uw6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjZnG2jnipHUsgNI8z3CGyT+BEZtbocNM7EH63LmN7A/caQuUY
	c8fYxreh/tpkf0aJw2kJtN+QFWqxIbUl3PknS2Z30S21cYf9ALvgC78P0zoYN+Ig2B7VcWwfl8B
	rutRYT7lUmqI7IewI5k8Ufh8FYvjVNFartKEBtHWB0cTfl9lhcXfP+w==
X-Gm-Gg: ASbGncvn4XJccaovcKsb+JpsnllHLu3Hg5SpBIvl997qTQGwKVTtxauRKAb1If6KslT
	X/ES5LRGInmlxo9JjCDufz7jQewTDGefd50soaDzo/FdSray7/PTYw5VvvB9ALuqYD91BUu2QYW
	A3Y0a58hvuFUXkZG4vmv+pWTZhoZyHq75jDnbQqetxaYW19Iw23hEVJOZ65cyM6Yl20+dQ98kIY
	7BEmw5uL9yzfM7V54V1ew4v27AKtoJOZS6gBGAqOyZUL7I4aZXDp4kezfv6vrPm0RVM6MlJUzXh
	qS4Y8zDfQQR/9BQ5VjpaCGKFhKlGfCb48xZXbzzGM1esjJ9J7lXDBXm0+KcjNWFBk7L/M8oEGFt
	Qhg==
X-Received: by 2002:a5d:584a:0:b0:429:d0f0:6dd1 with SMTP id ffacd0b85a97d-429e33396cemr6851005f8f.58.1762429671746;
        Thu, 06 Nov 2025 03:47:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyM0CqjbrXAtnYkiBBxwxzEmqQL7alB7xzeOenRekpIf1Zfq6usduu0337jFWK1+wDdZonKw==
X-Received: by 2002:a5d:584a:0:b0:429:d0f0:6dd1 with SMTP id ffacd0b85a97d-429e33396cemr6850974f8f.58.1762429671254;
        Thu, 06 Nov 2025 03:47:51 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb49c2fdsm4632849f8f.39.2025.11.06.03.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 03:47:50 -0800 (PST)
Message-ID: <981dbc10-0833-418e-b389-93e0daee8acf@redhat.com>
Date: Thu, 6 Nov 2025 12:47:48 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 08/14] tcp: accecn: retransmit downgraded SYN
 in AccECN negotiation
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com, parav@nvidia.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
 <20251030143435.13003-9-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251030143435.13003-9-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/25 3:34 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Based on AccECN spec (RFC9768), if the sender of an AccECN SYN
> (the TCP Client) times out before receiving the SYN/ACK, it SHOULD
> attempt to negotiate the use of AccECN at least one more time by
> continuing to set all three TCP ECN flags (AE,CWR,ECE) = (1,1,1) on
> the first retransmitted SYN (using the usual retransmission time-outs).
> 
> If this first retransmission also fails to be acknowledged, in
> deployment scenarios where AccECN path traversal might be problematic,
> the TCP Client SHOULD send subsequent retransmissions of the SYN with
> the three TCP-ECN flags cleared (AE,CWR,ECE) = (0,0,0).
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


