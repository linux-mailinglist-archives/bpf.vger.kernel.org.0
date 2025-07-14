Return-Path: <bpf+bounces-63206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36845B0428A
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 17:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB8F51677E6
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 15:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70AD2571DD;
	Mon, 14 Jul 2025 15:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RkZDeKoJ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E37198E91
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 15:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505416; cv=none; b=cMfxJ78RbFnmJ7SkVeyQYuva+Hq/asZSQEQMTGrX35lxj51UYP/w+UYAVCG/BdVbhYmPLtnLk+R+8oJc7eZBExo7TQzyWSB+pwzANZKcwY33Vvmc5ofPysb9EReIG+IJP7ZN8HAbxTXoewkGVXApqvjZEVkForPZ6vJOqoFlsbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505416; c=relaxed/simple;
	bh=HgEdt27/fadF/UDelzRUDfGMNwFhsLgZIGfeu1efcvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dXpB2IkFO1MWI1KPnm+uvzaeL2Dlbc+xbYxzZGf5P7c6ZPsU/5jFDh70TCjtawNZvElEdiVMKzwRe1Qe7xwoAImEXQoWWirxCfZYTT7fiZ6bkEUXmieILtUpwkPJScbTjGOx26jfkVxmQFd3sk7zjuQaqHasDp9C2cofBuPwgZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RkZDeKoJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752505413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CHjUCxwTYZsQwTU8Zui9gNjcOnUwNl2oic1dvzZPsoo=;
	b=RkZDeKoJAs88NjgOYsJeEQz2pI1C1dII/6FnbsAm44fCbH4sxD2yxtYdxbbCsJRCV7gibU
	XSTMMtgrvpJBNsFw5LeEudMuclt1kFpU9JDjXXOyAPSrrnjtMrmeT0OKATsnn+hB1boKvw
	uhnELfewUjtuGKuIFWgzMrJn8SWnzyI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-rXdASc5UNKyBa7x7xvryaA-1; Mon, 14 Jul 2025 11:03:32 -0400
X-MC-Unique: rXdASc5UNKyBa7x7xvryaA-1
X-Mimecast-MFC-AGG-ID: rXdASc5UNKyBa7x7xvryaA_1752505411
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-455f79a2a16so22116335e9.2
        for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 08:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752505411; x=1753110211;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CHjUCxwTYZsQwTU8Zui9gNjcOnUwNl2oic1dvzZPsoo=;
        b=i04EuF1fn1VmSkYr3GtRD4c7qnpMRQpSuxJK6lZkFRmD4OPyJUkCUk+/XaAiMAxPtv
         Iu8Wx7Z1JFhw74SqQbLJjo5xaq4wKUe/XqO/yQfl910xEXxUzGOi9ZfgC6Ycnrb5o0al
         gsFJVsX/l5X76A0nKe30/c2P8BXLf9+ikblAFlaRQUzgoUjeyZIZRIRtTFS9xYnvWZfp
         pTALZZ5QFU45Gzv4uM15q80eYsYaPwEnFTOwutAmT8gIA9vjwYCMH38LwMzOHP4jfTuJ
         UjOR74wV7HPi+ozHMAmF5Ep0vrejBtQ6OU+H3JPI6R4hUN3MfGOsHAp+is0Z5NpABbmc
         ahkg==
X-Forwarded-Encrypted: i=1; AJvYcCVx3WeKK/xeN0p5g7uwWE0SUOja+zGdJyuMXT1qSG/sc5l+NGiEkm3fP/uJF5jQcyIBez8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq1S+jfJ2Rc/ZP8d/hU6ewDrqIN/2HUdwZWdD2albxe+mRhUO9
	lnxVBmHpI2twQO/AIJ1+ESpbHRXxj2+CsZYajEy6z5+bFaMUnxyGA6pJeWXAjuX1sfxPmcFeU+r
	Xi+uZFWxjSDANDPZ+88+QuwOjflXQc4T8QmmoPrJsxKVTetrDAV5guA==
X-Gm-Gg: ASbGncttc0UQvMdc9OyCo3oq3BeqJSvz0sgxWZqMjDkZYf5YM0HATBbP8Q/k5h9Cmy6
	8W+OzIUabTP3QD3O4Hhi6e7NwocN5FFIH6NyTSUHT089OU8sfBtr5KauOUzdeUFcWt1NlfGleaT
	p8I3UnHer52QEr+ZhlrsohOoVCETsPMxIT+7bl2UmFZmrUcH53EBvlqK3M5rXVT2WIO3OoG8JOt
	158ifQDh7xRcD/ZoUwfu4z/Jv56WTZHLH3pgBEAjDVkL+Z4Oh4mXs74UT/X8dYF4WRqUKNi8Mov
	fytrXlLAmTjtjDawFokwzueNkjSRG8nwlZWdFOE19+M=
X-Received: by 2002:a05:600c:1f14:b0:43d:fa59:af97 with SMTP id 5b1f17b1804b1-454f4255695mr113362275e9.32.1752505410971;
        Mon, 14 Jul 2025 08:03:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgGUQLi8QIz9qJck9h2onkd29NM35VCq7kR/qUQg+hshIrtci80OF3+t9fpKWQoP0MLQ3vkg==
X-Received: by 2002:a05:600c:1f14:b0:43d:fa59:af97 with SMTP id 5b1f17b1804b1-454f4255695mr113361195e9.32.1752505410294;
        Mon, 14 Jul 2025 08:03:30 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.155.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc201asm12513593f8f.22.2025.07.14.08.03.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 08:03:29 -0700 (PDT)
Message-ID: <d16bda13-2f84-4d15-a737-d2782cda480f@redhat.com>
Date: Mon, 14 Jul 2025 17:03:27 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 net-next 14/15] tcp: accecn: AccECN option ceb/cep and
 ACE field multi-wrap heuristics
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
References: <20250704085345.46530-1-chia-yu.chang@nokia-bell-labs.com>
 <20250704085345.46530-15-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250704085345.46530-15-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/4/25 10:53 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Ilpo Järvinen <ij@kernel.org>
> 
> The AccECN option ceb/cep heuristic algorithm is from AccECN spec
> Appendix A.2.2 to mitigate against false ACE field overflows. Armed
> with ceb delta from option, delivered bytes, and delivered packets it
> is possible to estimate how many times ACE field wrapped.
> 
> This calculation is necessary only if more than one wrap is possible.
> Without SACK, delivered bytes and packets are not always trustworthy in
> which case TCP falls back to the simpler no-or-all wraps ceb algorithm.
> 
> Signed-off-by: Ilpo Järvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


