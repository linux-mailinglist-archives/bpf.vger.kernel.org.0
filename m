Return-Path: <bpf+bounces-70025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 738A3BACA03
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 13:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF3081922F57
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 11:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50E11E1A05;
	Tue, 30 Sep 2025 11:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bwnznzr4"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD16C1E0E1F
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 11:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759230195; cv=none; b=rA921H0YDFAFJ82r+FKV3vjsD9pB8fkghnnKRBhL159eO/wBbBbc31y6JL9YcPSEPA88BIGKhxVn/GwJr9zhjnAhiIx8yqtbV0QktzMXMAxYddCYM/9l3Rp0z+i8gEVF00wNgxDFAf/mOI7A3w+to/Or16V+Q5gBWuyHFYne198=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759230195; c=relaxed/simple;
	bh=5u6BGMyZg0ZeuMYiYi7YTJmV+4yktA30/Ri8cWBKCfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=g6uF05BNAyjhWvb8KNotMKRS8K1ldHnphiULVHOOpcDvq2uKMuWSpEXCRJj3L7PEpMNc6/Va8KRBSOwmC9BL1htOI2VghD7w3TzKeXl3SISdU+k4xhiqa9u0tHld6JN0uI2sHpp/csSooFoz7FlYNGMJWFNDTRkmvuFfPCiZo5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bwnznzr4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759230192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c3hCo/D5uBvIFt5tzpRk70r2TMeNU+1RWRpfUU5oV6g=;
	b=Bwnznzr4DzDI/AYLdCD3Ce+gdlY+Hf4mcXr40J1x2pYeehIksbAZPZ4LmjsqHtQKZhlyqw
	YHD9ndlOQ0YYeK3oAbVyiv68wWojc+d0fveSa421++EoHaMNXqSg03eC2TSJnFkuCItitX
	orqsQbjcTvIR67aM2Eb0GD23hULE8Nk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-vYe4_QnbOwedML5xyQyGQA-1; Tue, 30 Sep 2025 07:03:11 -0400
X-MC-Unique: vYe4_QnbOwedML5xyQyGQA-1
X-Mimecast-MFC-AGG-ID: vYe4_QnbOwedML5xyQyGQA_1759230190
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e32eb4798so29264625e9.2
        for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 04:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759230190; x=1759834990;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c3hCo/D5uBvIFt5tzpRk70r2TMeNU+1RWRpfUU5oV6g=;
        b=QIIlVmGde/2bq90daZe7aVLbkmyzVShSDFJCjxLomXWHOj/ZIBDlR0uqSyxHUkUn5A
         8Vklhxr5+KKc6bO214dTRHz23iYbNUaJFKf9HVkXEydw+9NuO48NSjGF8t3sE/B1IuTe
         8Hilk8Z+10xK8fRfJCO8HhLk/bGIQsWdgVHuYitcNVBEl0lcTca70ux4O0k+n3KClXz4
         Yhg3sOML+aK6Ebf7CCS4wZS746InCo9fKkhM7uDccGiFS0LZgiJai5eiji/gT+yVNWIk
         cCaUlBbl23LZdg6Rc33jpUra6Kibpol5GD8jLteiqpoxSswA28hAWsEom9tfKW6ReDhy
         TuXg==
X-Forwarded-Encrypted: i=1; AJvYcCXO+nlA2xFP6lTt/0QM3jb5ZXV0neSEy4CozV4iPoIhVEyEndFsXcvM38G5/sl7yfH/obE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeqGMFtUEM+qykECFROQwqSwDTv7vLPUUYNcD+VT72gelTkSvq
	ihQBn9oJLVJWJEJE1wJG8LgGkF5KL2XfN3IpF/cVr9lkz1qZENNnI4ZDlqix69ktlGib6uCwgba
	98R3lpjJ49WJ9I/k4mcqaULd/ppbaLE2u6ojzaheibuD1QbPfE69fig==
X-Gm-Gg: ASbGncuMH7rU5533eqBG1RR/R+B1ZJQVBJ3QwqAnR3Xeiml21oOZqAjbOKFXeEqemFC
	nX2IMLqiR8RSslif2o7IEpMC4a9Cy0VYovwn6GcWMcV6YRZxEnYqrEPyMV9fZl7ti2QNg5oXnfH
	VNpA0l2/OQLl44zfAiV5sF6Onq18C9uEdpsWOCRamQL2HUivFMe2fRI7JTGMuze6ILmFw3JYI2u
	Suw/86/puM+8MtZk5Nduc4b3RDIjLaHrs9k+hH/uTNR9gXWOvUZxg91bj6ea5zCJ8v+Sfb+3anu
	4zuM94w81Qm7cu2Fp6LxAcNpJiow4636CIJvCH3yvDkGI/fik+M0keX6nD6jRmKKfG/02MK4+gv
	H75Gn9qwQ5SCJembMuw==
X-Received: by 2002:a05:600c:34ce:b0:45b:47e1:ef6d with SMTP id 5b1f17b1804b1-46e32a2c1d6mr192326105e9.36.1759230190160;
        Tue, 30 Sep 2025 04:03:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFj7mxj8Yl0hTsBFdCmnwOPVTMRa5dKLaiRfxfgQ9PMsc+FPZrq9aAN3rhTAERQcDc04InRg==
X-Received: by 2002:a05:600c:34ce:b0:45b:47e1:ef6d with SMTP id 5b1f17b1804b1-46e32a2c1d6mr192325725e9.36.1759230189782;
        Tue, 30 Sep 2025 04:03:09 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e56f3dab0sm51237975e9.1.2025.09.30.04.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 04:03:09 -0700 (PDT)
Message-ID: <49f887d8-a34d-4154-af94-84a3f77700e1@redhat.com>
Date: Tue, 30 Sep 2025 13:03:07 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 00/12] AccECN protocol case handling series
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
References: <20250927084803.17784-1-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250927084803.17784-1-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 9/27/25 10:47 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> Plesae find the v2 AccECN case handling patch series, which covers
> several excpetional case handling of Accurate ECN spec (RFC9768),
> adds new identifiers to be used by CC modules, adds ecn_delta into
> rate_sample, and keeps the ACE counter for computation, etc.
> 
> This patch series is part of the full AccECN patch series, which is available at
> https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/

This is a quite large series, touching core part bits of the stack, and
we are very late in the cycle - finalizing the net-next PR right now.

Let's defer it to the next cycle, thanks!

Paolo


