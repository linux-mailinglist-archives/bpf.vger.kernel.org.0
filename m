Return-Path: <bpf+bounces-69363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E3CB954F9
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 11:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D72283AEF5F
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 09:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736A3320A1F;
	Tue, 23 Sep 2025 09:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XNokWGAa"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845D31946DF
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 09:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620873; cv=none; b=Ag3U9NuZ6muamQW4Rug2vBqC443ht7W762Xhpw/vTa78Xza8nCwDeOje8co0on/M49sJu6eItlC3JyuF7it44fvK6ok1P9SSTbXNlzKjFgFn10kT4FmPhFW4Acdbkfp+62vaDD7EGsk/eoBk2eXJpkpW8YDaoTMRyY2oVBzq7rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620873; c=relaxed/simple;
	bh=6NephiHlDDWZjUDgQSNZd+O1MAHNoJ8Zj4QSD6tMBlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=piCNcZhJKJ2ClvZrWXda8EBN1dxwmZGA/rZqujusGwyjSuov0zJw644yIixcnrJw3xjIT+Wu/QqEMLNT6GqcGcYlyeAjf6p6blvgBTAbGpefSk6A26R8Ml04q/9D95po9Ce/PpXT3z1zYRBEL1YWpjm6oh7OGeR65y3337WU7BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XNokWGAa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758620870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X3zbNBHZeX4u7pe1g8MFTz/QKax3NsVn23uV23hW5+U=;
	b=XNokWGAaoUAJ/P1KyfRmVDV9bYGvfZPQj8Tyxr+FQeu1D2+7tCn9c4gQHonAxN8SJUNv6g
	aKMcjOicXB2t85XbCFW4cPxhH2U06WqjQAm1SLsnZjIclY67JM+FW82xak4WU7Z+09j2Go
	CIGRSE5IOib5NKtjMhbw2jyEbgT2ZIg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-Yc7yJST_NI24zznFd0txFw-1; Tue, 23 Sep 2025 05:47:49 -0400
X-MC-Unique: Yc7yJST_NI24zznFd0txFw-1
X-Mimecast-MFC-AGG-ID: Yc7yJST_NI24zznFd0txFw_1758620868
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45cb604427fso29687115e9.1
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 02:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758620868; x=1759225668;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X3zbNBHZeX4u7pe1g8MFTz/QKax3NsVn23uV23hW5+U=;
        b=hHI7URNQJYsVqZGC2NVSdozv5GYgIiAOwDmts0FNahmQ1bm7V4VejT417Hu+ymSKyn
         jDJp1ibwn1W6kduuX2ZTfoRkBGN9poboPYNfThbCZt3VdRvzK+srRybIubeQ51ckFVEj
         CyFqTtpD9rbbiRmlSC5PUd5HCSJqWvo+hBJ412uc0gX9nG1KrkM7uvKPmLTWy/6amRXr
         aOACTqmnfGOTpx8vNIgfHiJ0l/nHWMi1IoDjQQlY7hgJtI7HbGMT6RW/T7iwXi/7yabo
         McqHfpddfjZ+TCNaXasfPgtJdjvHhD8LfmCvwod5sAlaTGiZl1coA8rhaa+rK5lrgAbt
         /Exw==
X-Forwarded-Encrypted: i=1; AJvYcCUDGtkyWcfKrB87khC2xnmNuTSE2e5oneTv/xvPfyCBl1v96GdUc9Uk0skvo8rbgQe5owU=@vger.kernel.org
X-Gm-Message-State: AOJu0YygOq3ezkjtM4dFlsghP6LXmHES9EeLTy44IgSS1GUE+vkkN9eS
	7x7636zKrOauS/451YGXlA8WnDyjP3zz9pdiEQovLBRbJneSBQhzg5ZdWACkwAQ1zOQ6MujhFLz
	rgPIdgfECZNZejMukBk35CUedflkhlwgNhjiUTHvWd7uww3g8RdrecA==
X-Gm-Gg: ASbGnctaHf8UYwjKvsaPZKT2CIm0uaT68HOUbMR+4oj1FaCwVu5beh8g61Pdy2vuAQ6
	5vAs9StiCnRKKqOi8DgFhlrQwhZuLE4Qpxs0aupyi9XgS208qegKKPh12qV02AAESoFnDjW2ibd
	PDB3h7c1OP+QVOZckHyNJ1chKX9wDeiBfI4SYp4jOz9ZWbs+bTSMrzYZFgF0DXHLv44m+miIy/b
	07tyUSn13TCw9rGQQdaXrFp1RfWX+fOFJ7icS/8oxHNxMmhvb9v0Tu1ar5BuL6BaOFzlDZh8mQ1
	IdwfH0prYr65K+LhgLOmWVs6W38pN17kFk12BvR37kcHvTMAF554/VL6Q0X6S6YpjlMIL9n41BT
	vZ2UUvaRoY2NP
X-Received: by 2002:a05:600c:4692:b0:45d:d609:1199 with SMTP id 5b1f17b1804b1-46e1dac9639mr18916195e9.30.1758620867683;
        Tue, 23 Sep 2025 02:47:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEejj73xYyvJhtG+80Oo+hw9FL95RSTSMEQ7BHTRfIVzB184Xe9dwz7Q3l23RiwZ/8pTX9Nhw==
X-Received: by 2002:a05:600c:4692:b0:45d:d609:1199 with SMTP id 5b1f17b1804b1-46e1dac9639mr18915955e9.30.1758620867259;
        Tue, 23 Sep 2025 02:47:47 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee106fd0edsm22603388f8f.53.2025.09.23.02.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 02:47:46 -0700 (PDT)
Message-ID: <161c09cc-9982-4046-9aa0-d0ec194daba0@redhat.com>
Date: Tue, 23 Sep 2025 11:47:44 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 03/14] tcp: accecn: Add ece_delta to
 rate_sample
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
Cc: Olivier Tilmans <olivier.tilmans@nokia.com>
References: <20250918162133.111922-1-chia-yu.chang@nokia-bell-labs.com>
 <20250918162133.111922-4-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250918162133.111922-4-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/18/25 6:21 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Ilpo Järvinen <ij@kernel.org>
> 
> Include echoed CE count into rate_sample. Replace local ecn_count
> variable with it.

Why? skimming over the next few patches it's not clear to me which is
the goal here.

Expanding the commit message would help, thanks!

Paolo


