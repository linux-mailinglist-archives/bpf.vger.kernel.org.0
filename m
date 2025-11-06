Return-Path: <bpf+bounces-73826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFE9C3ADA7
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 13:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ADB20343514
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 12:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AFA32A3D7;
	Thu,  6 Nov 2025 12:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HbHntlqi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VGgjJa4W"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5032D9ED9
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 12:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762431528; cv=none; b=P7rPNX7TW0sUArN89rVCjaM37J7Ruc7Fx6f5ocCrcsU/sI6fovJJnZ2tJ02SPmYnv4fgk7DMe/rq220Ymob/1K+n7189M4g1aXO87SfEdQQNnJAH0yR7WBQlhMFQb4HbcojmcqC3MvuXmOdBZPLcadnnffzupdM1TznIRvbAl2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762431528; c=relaxed/simple;
	bh=uoFFD9n3hLU6Mq7kB4d0vCBxzAioEZz8yBEJ2YTctco=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bc1K/MQHtDpD2UQjNOppKmCNiPO0TZTABBoOtZFlCF20l+eap2Ew5kI0Rr+OORjNRzjBkhs0jZokuAj/4XbaY9Tq36z5x/bDtIYc5yhgzyXzYOgzsMwaxslT2wcDlkn7UQCUD30ljrEj+rZ6TPxBlotdZlUcc3vTOrBoQ/hhBO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HbHntlqi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VGgjJa4W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762431525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xt6hYilKH7tDfneGToMjji5Pnxk9yLau0emKZyN+R0A=;
	b=HbHntlqiVt62SX0aecfH/5uSPh1wgWwhEEOCqF1EpghGWnJwetsswW0wv74tymhWI0GkGS
	2r5HT6skzDP0kOYcimsRszeyluElyhQwVjjOyEIJB8OBH4CUAJ1jKWd5hNEx7YCC6HquDh
	qWk8oJI7r+s1HHZNS3KGmC2Akr8FP60=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-A7f_vLIYNM-rrRNGRJ502w-1; Thu, 06 Nov 2025 07:18:44 -0500
X-MC-Unique: A7f_vLIYNM-rrRNGRJ502w-1
X-Mimecast-MFC-AGG-ID: A7f_vLIYNM-rrRNGRJ502w_1762431523
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47717c2737bso4873335e9.2
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 04:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762431523; x=1763036323; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xt6hYilKH7tDfneGToMjji5Pnxk9yLau0emKZyN+R0A=;
        b=VGgjJa4WV6FXNH1haRuo7OMbf4J0XlOOUYLmkFazf38M7tol0v1D6MvEn6F9t8Gm/R
         VC0JqUdtSQ1hi8XF1i3z/SIhQVqxbWvnsZg+ptWYreGcwNhpLOanY0h6YCtElYZUF4Lx
         ehfLLg8c+hylcZ3mOJaibK433zLyWrhV1ZsMojakSJJ3xFQRhxOQBXHoWBNpGSo0+Lh6
         j2oZol6MFxN09/RiMSX1kh3T7PffgYIzgVRIEAcYCLWcznEe8VoyDoqAGFd0aC+DF4ct
         UxM0HLy15OFhl5YiYKf8WUpP1+HS1h3NgZp5THGDp7PI8EHuZ0MZ9sZF62wSuoy1YYte
         JoBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762431523; x=1763036323;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xt6hYilKH7tDfneGToMjji5Pnxk9yLau0emKZyN+R0A=;
        b=lOYVDZsCa/6aF7A/SA7ZQJtS7XECqQHru0mB46hlbdKjrADjEyq8SRnfb2iasCsD5w
         oXmlgxpK7bUtuYdeQFG/B3gAL1dH0jQSAdhtNkonbpZYb/F78A/bjHxWEk420LZtuT9d
         /S6c2Z5NK9qThH0XyYvRqRBAfDb7X9Ae7cSB7wO2aLPVBclVCd4KWsi2dMt32JARxkie
         TmRF2Md2oBVK/woRK6aqIGoodkfnEm/txMUzz3jjPdo/W1xaEsdggfJJz5pNzcDeOLzX
         EaLtIUVS0UjKLhN8EVvlfBn0SeAbFg1DrMQcDT86eJhKzNmPxWPW3sxEWJ34kDGvc8TX
         3Low==
X-Forwarded-Encrypted: i=1; AJvYcCUTD22ncQKYUSfDDuVNV2O3yj+2uWzts5q3S7KkACqYGNB3RIdeW59LAeHhr3hYbL4acSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDimpEwAfP9ujB66FG0sb7XMiQMCEfnz6TmpC5wy+JQYQ0yij7
	6Cac9FZQauJPR5tTALbsDrdtKfui3lAgGVpfeH+O+2YNKjisGgnSoB2fR+FpdSaLO91rhi+1lmp
	u5SEVmXncX7CdtZ3uJKNw4p9IEdmyQoxZ0QxxWn+nPwbB8lIxVb4xRw==
X-Gm-Gg: ASbGncs9b+ypNGfDh6ZhhjQ5ik4maEp67KsBJccrA43Pu6qI+4U1ngHuN68OdAdg1Gs
	N05f3vIKDIQ1qmmIR4s+TirZSDlHZbFFTCeMmtve93xZS1SSEZJRUg/9Kt3Yp4REEdbz3jElNkx
	sBZ026lmhylY92KM9WVqj+7hFq0rQnhs/8YG8UUbEWWXu7hI1rhZ9q32rfoLJ5e/rFn+P/art1P
	48iDB3ZQTWRKmud1XZERVmJBAptaysM23dc5SbosmL2FZaIuwW34P31pteV9ulEjtnN7rBSVvCd
	vjAwXr6+MhFU2cJkfdN/hP2uhFubWA6OdjgzeZrlh5tbCPdDqY71juhEVR3IkWj8WujJsJOjZlu
	eyg==
X-Received: by 2002:a05:600c:620f:b0:477:c71:1fd3 with SMTP id 5b1f17b1804b1-4775cdf253dmr62958685e9.28.1762431522950;
        Thu, 06 Nov 2025 04:18:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGg2T2KZ3KXS1p9s6HYB8H5GhOQWRao0wUciVpoj7nlzP5kx7LVUIS1TvbmMMWe0Fwec2vCYQ==
X-Received: by 2002:a05:600c:620f:b0:477:c71:1fd3 with SMTP id 5b1f17b1804b1-4775cdf253dmr62958205e9.28.1762431522520;
        Thu, 06 Nov 2025 04:18:42 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce20ff3sm100590715e9.10.2025.11.06.04.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 04:18:42 -0800 (PST)
Message-ID: <35a98a1e-588f-44d0-ab99-f4b4508f65cb@redhat.com>
Date: Thu, 6 Nov 2025 13:18:39 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 12/14] tcp: accecn: fallback outgoing half
 link to non-AccECN
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
 <20251030143435.13003-13-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251030143435.13003-13-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/25 3:34 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> According to Section 3.2.2.1 of AccECN spec (RFC9768), if the Server
> is in AccECN mode and in SYN-RCVD state, and if it receives a value of
> zero on a pure ACK with SYN=0 and no SACK blocks, for the rest of the
> connection the Server MUST NOT set ECT on outgoing packets and MUST
> NOT respond to AccECN feedback. Nonetheless, as a Data Receiver it
> MUST NOT disable AccECN feedback.
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


