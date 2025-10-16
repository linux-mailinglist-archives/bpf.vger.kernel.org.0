Return-Path: <bpf+bounces-71101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E71ABBE2487
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 11:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE3ED1888CBA
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 09:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4DC30F7E6;
	Thu, 16 Oct 2025 09:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CU1XdXuw"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A22628BA81
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 09:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760605353; cv=none; b=BtDatY9WcPzfUffExwf6F/cRnmhF1S9J0xJ/nzdET0GSwxw3rpwB0xV5Lp9wacJQjrKKgu0MgUbhuVN8b9bCKdeJqjuqWJ2oUKNwoXVcE0FJmS10/+f5Mre6u9Kwd7giLtDmJfmwBPd9sru0ImwbRSSBsbHKIXWhGYjE4LRpKno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760605353; c=relaxed/simple;
	bh=+AtvyGqwUgALdVZc2SXcYDz/237PjQqovYd5Z7PxSbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RBIy2ReXZGMxhHoNXuKqy8IydaL39qJGhPWWEhE6nUO3RxVRn79qlR60p46gtEdiJ6v7VOXyFtgCuVLVH+MzPo2KfXlGOnQLVJ8qYW9doN903/gowEWgxDX29fX/ZyIQS2kYdRkYehYTYupDr6+MEFwvlCW7pKqQUu+4QkX0ItE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CU1XdXuw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760605351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5GQfxStX9qdjnF8aD6SOVhJPa/g/zUO8yOqhMVk2ON4=;
	b=CU1XdXuwXtAlN5+0UwA9INA9S1zJFuFErCFuDBVib8hpMsHqU+fvDv6znfBqA5++GdNgxs
	w1RS3BWwwhBvlB1kJrTo1XKV7GPfPIC3ktx6VH91l8Yexg5e57V8Z6S3z17PXl33ZKIkME
	iQmRMazQZ53TEa7EIA6RlcMH6phv7GY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-quI79kK9MMypMfj2olYzMg-1; Thu, 16 Oct 2025 05:02:29 -0400
X-MC-Unique: quI79kK9MMypMfj2olYzMg-1
X-Mimecast-MFC-AGG-ID: quI79kK9MMypMfj2olYzMg_1760605348
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-471001b980eso2921605e9.1
        for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 02:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760605348; x=1761210148;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5GQfxStX9qdjnF8aD6SOVhJPa/g/zUO8yOqhMVk2ON4=;
        b=BCJV76i120lGF3BQQ9zgIPY+yqjR5mWIv2+9OGJG8CIs7vAuHDIsNAXUX3WY4QX6UN
         FzH3ccNCd7AjJdznC06c4EikIcGpvQY5Z3WKnaVctuNJlzQ16lMMdCik0d28rik2gKxB
         gST48VcPKx9xxQa9RMPu0dh2E+OFVnwUu507MkYJdO0XKHVsnvkXc5y2GWdJ5rM18sUl
         19qF0Wc8bhu1YQ80ODNHIW+Nt0EWalvy8z+UfJbs8ax4oHBWXEuABWu3wHSsynPUYjqa
         7Sbgbz0lrRW7n9NVh+u1gOFrFYqALXXT0WsJuzm7sFlQo3NYqanR/Xp3TLzTwSQgRo9Q
         /SSw==
X-Forwarded-Encrypted: i=1; AJvYcCXE/YTc+Vt/cPCtYsNITMnhL3XIz2HmWsVnY/+4UI2mjD+RHF2hMZm89yNC/Bw4oOlQDjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZlmZGh+R217MTe43AJyfACUqt45uK2AdAFKlGV7LbCasF+WeZ
	Jbcu8oto1XUs5Si5dQLSNS/1Lwe8gz9Og5tCvVrnfRdYiGWY7jO8u1pRSGPrFvoncwUAkPvZWYo
	eXJ1MZtw1Jgqk8d2WDEDW9XStH+QOPMCubJd7vf/5kGfL1CXm88s8LA==
X-Gm-Gg: ASbGncsrx1rM+3FGFYyKdodswRRD1/F/ErKomfEbkdp7Ms9/brcmMKDkFe2VdCUoaeC
	14SNduHTMoSkQi0oL6TOKzP5mAnNCKxoxcL9kXuNJBq3L6HKq6foVnFc61tbXgGKXC2LwPUgoDF
	TT7XwQc4u3YVfsM3Q9Z1cJVrceiJihDuYTK/KQCxb2FXkhA1ACBPRpMkZRV4d2XHWsZpgw1qunY
	eeWj/MaoxNo3MMAuC5yG2rfOO9167T1TAMAMv5bKTz54UhGvtpT/fyP4Su1x25Dr8UAUOiawRc8
	R/x/G18TsS3IUUwlRUvflke6MuWCgC7WCAe5zIektqORvn5Bx6EXjCmCLrq1GXZMeoJG3qTXfAz
	PnEF80IWVflblxLpBeqSAxt64CTvxcnZDj0teGZHJhE8d8+U=
X-Received: by 2002:a05:600c:3b08:b0:456:1b6f:c888 with SMTP id 5b1f17b1804b1-46fa9af364bmr194084485e9.23.1760605348016;
        Thu, 16 Oct 2025 02:02:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBKaKCixlap2LGsrCQoy/ztjbrbjTMc5FWNVc5/WkapPDjvhhGgdyb9Tum59RrTjzgqDuQQw==
X-Received: by 2002:a05:600c:3b08:b0:456:1b6f:c888 with SMTP id 5b1f17b1804b1-46fa9af364bmr194083915e9.23.1760605347524;
        Thu, 16 Oct 2025 02:02:27 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711444e3fesm14977005e9.15.2025.10.16.02.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 02:02:26 -0700 (PDT)
Message-ID: <4042d1da-a7aa-46c4-87c5-736d74d280a2@redhat.com>
Date: Thu, 16 Oct 2025 11:02:22 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 05/13] tcp: accecn: handle unexpected AccECN
 negotiation feedback
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20251013170331.63539-1-chia-yu.chang@nokia-bell-labs.com>
 <20251013170331.63539-6-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251013170331.63539-6-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/13/25 7:03 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> According to Section 3.1.2 of AccECN spec (RFC9768), if a TCP Client
> has sent a SYN requesting AccECN feedback with (AE,CWR,ECE) = (1,1,1)
> then receives a SYN/ACK with the currently reserved combination
> (AE,CWR,ECE) = (1,0,1) but it does not have logic specific to such a
> combination, the Client MUST enable AccECN mode as if the SYN/ACK
> confirmed that the Server supported AccECN and as if it fed back that
> the IP-ECN field on the SYN had arrived unchanged.
> 
> This patch fix an incorrect AccECN negoation of commit 3cae34274c79
> ("tcp: accecn: AccECN negotiation").

Minor nit: with my previous feedback I asked a formal fixes tag here.

Yes, we can have fixes tag on net-next.

No need to re-submit just for this.

/P


