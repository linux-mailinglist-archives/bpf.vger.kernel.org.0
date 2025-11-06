Return-Path: <bpf+bounces-73828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7518DC3AE22
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 13:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D8893A934F
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 12:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A207232AAA9;
	Thu,  6 Nov 2025 12:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZa5AE1C";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DWnAcrPw"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02C22D9ED9
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 12:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762431712; cv=none; b=Ocj+3bVU0K/eDCGXkUNy62XrM//is7ftr3/sKMZJly/yt64eSQYrpF3Hb57EQ3xMf97gJqUpwYy09IwJ+5Avfk1WEtCuuHsfGWG7rGq+uzczA4wHInWTvz2dv+ruNt3xH2pT5GBgQHB7VQzO8hF16x3DPjUyNNZy38UBBlePRaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762431712; c=relaxed/simple;
	bh=f6B/tbcYYNUY1cwi4BIgQgWXetzxYn720LqQVpZbrbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JVuq7p6qKLfae1wjr0OQf3LXlIBHXApTQ/60/HJVPSTpL8Y42QhV9fzURdXD517tquCJlWdooxII1Xy2xk/AnKrrNdnvEE5K8fC/W8p/g6dRsVjnkxb11kLkx4uBYnfaUjBgLsQa6i79NlnJkP2qVal+uGfrSKurOPdGM04R3J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eZa5AE1C; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DWnAcrPw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762431709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v1N4Cl13V8PNbOQcEwPAAvE71VJRJZSQLqVmISUC4TI=;
	b=eZa5AE1C/cYEn3pnftu2tKCPblgDKDaAr/uXngjB7P1u8hcvrklzW+ddV3omHw44z2SCem
	58HNaEPS/gB+8cvTGIHCX+7auxIaz0Uj/sf165FlGrB0Aj2MUrnF8KK2SRgwawHgIGX6bl
	r1f6iwwMsbNgNXnj7Q7Q865lynuRiFs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-ArJt2ihEPfK9566FgFSqIw-1; Thu, 06 Nov 2025 07:21:48 -0500
X-MC-Unique: ArJt2ihEPfK9566FgFSqIw-1
X-Mimecast-MFC-AGG-ID: ArJt2ihEPfK9566FgFSqIw_1762431707
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4776b0ada3dso82475e9.0
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 04:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762431706; x=1763036506; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v1N4Cl13V8PNbOQcEwPAAvE71VJRJZSQLqVmISUC4TI=;
        b=DWnAcrPwqMo4756CjlWSvsFVEhMpFRwKmngSYToxMYFkJWBkUWQtmZNKNQOL9FPB8M
         RLwGxk9v/T0aen0n8grPyG8VOMDtKY8jZaOmLHCcL+hgpiuUTmFvQPsuUEBh2yOFUgof
         Jpp1FoF7/lKezfPV92HRzZXUWMcsh/x7v1gdC02MZlxLTi35ezDdQX8HRI0FFGgstZ2n
         NApyKtzF1r2rDfzDMAL1TF19i3JuLlhuAAdTT7ckGtea8WKDbgcQr+yLqyK/V6hTolW0
         dMprOa6DJ9ER6V6I3V0Sq4bOdbHFBlD4OaFF13zHmr/ugP5sXIBYLQEszxkzPRnL9pUQ
         nJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762431707; x=1763036507;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v1N4Cl13V8PNbOQcEwPAAvE71VJRJZSQLqVmISUC4TI=;
        b=C4cx/GATwBiEd/mMS4gHOsNULPU+aCKHMRpTwra2FvpY1DqP9/OUK0RWV7PB2VF7aL
         euSbUwf0o30H89bUwlKkqUQiurP1n0LVvj945DRKH1MbFCS1MVHRGTiAwiD9wwVYdvIt
         +zKRkRfeO8KzdciMRS4/7wJBILYGojoAcgzBupqxNnIDJb78rCLxRzNlzW9HxGAvIxxG
         jOCyqyHooWU6NmyviPmaHir7RsCZy5bHYuMDzjV6XJHTKOn8PYrRkBkMoBrS7SuQCO3A
         YV+aYYzbIbY/Rygz+Das0qG/5DzcAjWhZ3BaZ+jZy/9zxaNfJuCnttj9obLX5KaoMEpq
         jdnA==
X-Forwarded-Encrypted: i=1; AJvYcCXoh/fSU1MCiYtiG149bTX8YamvM7pbhJxmL54QA3DylkgNaDUtdJ3GX4kiUxl7j3xCuBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCuy11bibWHLYRJDsHc4k5bxMX1j2+EKWbsDgXfsVYekRmuBMg
	e7Fsut+QUiqU8VDeWvQ0/f7VNuUAWv5ND5QiwP09BiHN7bN1boA3GsZ+jQ5H2w1YpvxeuIGPI7E
	i1iz7cpWvamMz0cCShRTVmPlAujfW7ozdd7yF3+p20dKxttIZVu6Rsw==
X-Gm-Gg: ASbGncv0cUeuvshbAP1tyl+z6T8ZfiI6fuvLCmhqrgsPFm6opa2ttpcqRGrAJEi+lDC
	afFT3uKBlq8VJc87NTxAAj7BQFk6t1mHbHqyoxVitNIlCnQIb87bMhhdJVBSLnGyfhgI6dK4z+Y
	UjU921KgMUmMycckJ1eWi57DchYKmaz/ZUsm5WE9Xpv8ANe0KSyry0J4OGWe4czmMfDyYFr6XaE
	4iwJnqa0nyOFA+44qe0sUzxfvYzj5qZCjW1JG+n5EBem1tIdJYeFGHTdBNSNS1DP7AgExaYKVzO
	7VNV/xBlF5EWrryu31OU9CLQ8/h2sk/EZN2QWsE5Avsp9B8MPbAEUF61PL46yaGMXKPdkf117zQ
	QkA==
X-Received: by 2002:a05:6000:4112:b0:429:9272:c1be with SMTP id ffacd0b85a97d-429eb151f1emr2335245f8f.8.1762431706694;
        Thu, 06 Nov 2025 04:21:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhC3gPHF44nNLz6WF4vQ+gEkHlkVJdaQMy0UYsfuedwouhI/V3U2psJ1S8t/e2gVWT4Gn96Q==
X-Received: by 2002:a05:6000:4112:b0:429:9272:c1be with SMTP id ffacd0b85a97d-429eb151f1emr2335200f8f.8.1762431706238;
        Thu, 06 Nov 2025 04:21:46 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb40379esm4634350f8f.9.2025.11.06.04.21.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 04:21:45 -0800 (PST)
Message-ID: <faea7f2c-f63f-4b0e-9c75-1e93fdee5811@redhat.com>
Date: Thu, 6 Nov 2025 13:21:43 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 13/14] tcp: accecn: detect loss ACK w/ AccECN
 option and add TCP_ACCECN_OPTION_PERSIST
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
 <20251030143435.13003-14-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251030143435.13003-14-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/25 3:34 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Detect spurious retransmission of a previously sent ACK carrying the
> AccECN option after the second retransmission. Since this might be caused
> by the middlebox dropping ACK with options it does not recognize, disable
> the sending of the AccECN option in all subsequent ACKs. This patch
> follows Section 3.2.3.2.2 of AccECN spec (RFC9768).
> 
> Also, a new AccECN option sending mode is added to tcp_ecn_option sysctl:
> (TCP_ECN_OPTION_PERSIST), which ignores the AccECN fallback policy and
> persistently sends AccECN option once it fits into TCP option space.
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


