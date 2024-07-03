Return-Path: <bpf+bounces-33767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 692B8926028
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 14:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B75A1C2204A
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 12:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C09176ABB;
	Wed,  3 Jul 2024 12:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4w1z5JB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561CC85298;
	Wed,  3 Jul 2024 12:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720009324; cv=none; b=ZmVKXxRGNaqgXTnW8FeX4wq/fLW7ce9ASS0r5ecsQb74PL3GZYbs1P7gj69vI++f+/FmbNHjE0Onq7qKSUIT7p0AKDcGVJQKwFuC4dg378rijYkQUfiA+cf9daGBJwvI6iaYMM+vxYs+N/3focGqSwZKfn9lTrXWvtJ6kNBwkYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720009324; c=relaxed/simple;
	bh=m4n82d0J3T8685flgzkuvY6d+GsiP8d6MyWa3RazyGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ot4GJiiZQz2A2XFhqX1gUyqtzU/EAl9e205fOCVxdIn/TCZ+FxEXC99uaLiTAS0j76lA1mmI7ubZocQuMknUKHnkRTsiwJchIAocnSMUc0y6N6G+0qdp08UU+sJC6EpLPDd5U3aKOoXXTmpUyYzqBNa+tJt74+Ouev5nEjotShw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4w1z5JB; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-1fa2ea1c443so40291015ad.0;
        Wed, 03 Jul 2024 05:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720009322; x=1720614122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUmNJmYy7NJ6Dze7UhH2LVbEnF29e+6mD1oyuBQ6Egk=;
        b=j4w1z5JB8ICqmeD0b4W3tMu5KHTVtlts4AS48fpMdz84uceQsGSLfZjDDOHj68uoOY
         8xF5aDRsZO/wQWNE/jnf+U7slrHK7R0IMdLIVcEkDpWGT7tjmJm3jR04diLRxXkjgfR6
         T7mMJPPDAK2z7YhWbXXpQyP6p/ItJ3mPeCyrDgl+IabzDTLuhlSKJP35IeaCBDufQ5Ss
         FxKcfovhWJQLCm5wkl72TDvIUzn/1shInoO7/33dz36vdRGTVXxeI33vQ5qIkecoamhL
         A38M9M6tBZhmk5AiBCLph4UqR0pUb0gaqEohTELUvHGZUMuU8fLoVtN1Y+GVlQriM6ml
         bp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720009322; x=1720614122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUmNJmYy7NJ6Dze7UhH2LVbEnF29e+6mD1oyuBQ6Egk=;
        b=lmJjWjzU/Ox+S/1p3GF8buD+ZbkULg18J+FYWro4PbKYxzeKitjTPU30PSq9KhPpNH
         WHy6ZY7/vBUpIDF39EIXRlviqu3TzXW6jF/DNON+FCm6KQav1MUpw19EKMzAxUNMp1LS
         JTs1l0oBGL5zt3djaG0bRt/iuIrCFIe5coo2ek7mWwaNaBwdS7P2tl6nqV+SMElHmSEM
         nss21FuOJq2KoGPJIV73/afyMAYmszghzwvLL/RybGtb/ZwqFNIIp46wD0Zwv8Wb53wi
         RwKEAK4Xin4e0CEfV+vmdTQvJl8qK6D5yfevYXhYq2qU74aKKPQNUUzotFsJLBzlHVD4
         3rSw==
X-Forwarded-Encrypted: i=1; AJvYcCVWsGz9fX1ueOw4Qkzk2jYUkvt7g45T+7XmVJ9KcPI5jfboUriEQf8qkJper26/y8zU8iRBdwOBrYi5Jw5OllQmIPRk3YyeMDCRC3u4/kaqMrGODm/d1zSwRHFQyM2Jgfsr1bTqchWb3AYd4GfzQeIjiTj0+z6+uRUS
X-Gm-Message-State: AOJu0YwmWSEA6ZKpa4AwViZB/zZzNDZjTNgjuRbi1EIq3hVMIC4fl4sJ
	NuWnUbu0NhgwMNAKilDem5rufldJhMAR15QHUZrR9Nik/Z3fy/EQ
X-Google-Smtp-Source: AGHT+IHFhpUsM+UjoIZsvc9abfXBBwVr4Pvy2R6DexEfQuaMWZGPVsyFvMSpNFqyTQepijGjgMqDtw==
X-Received: by 2002:a17:903:18d:b0:1fa:f9e1:5d33 with SMTP id d9443c01a7336-1faf9e15e0amr32122215ad.50.1720009322425;
        Wed, 03 Jul 2024 05:22:02 -0700 (PDT)
Received: from localhost.localdomain ([240e:604:203:6020:9d53:3114:91d1:7a47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb24fbd598sm3616985ad.199.2024.07.03.05.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 05:22:01 -0700 (PDT)
From: Fred Li <dracodingfly@gmail.com>
To: pabeni@redhat.com
Cc: aleksander.lobakin@intel.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	dracodingfly@gmail.com,
	edumazet@google.com,
	haoluo@google.com,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux@weissschuh.net,
	martin.lau@linux.dev,
	mkhalfella@purestorage.com,
	nbd@nbd.name,
	netdev@vger.kernel.org,
	sashal@kernel.org,
	sdf@google.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	herbert@gondor.apana.org.au
Subject: Re: [PATCH v2 1/2] net: Fix skb_segment when splitting gso_size mangled skb having linear-headed frag_list whose head_frag=true
Date: Wed,  3 Jul 2024 20:21:53 +0800
Message-Id: <20240703122153.25381-1-dracodingfly@gmail.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <fd44c91884d0ebf3625ac85a1049679a987f8f79.camel@redhat.com>
References: <fd44c91884d0ebf3625ac85a1049679a987f8f79.camel@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I must admit I more than a bit lost in the many turns of skb_segment(),
> but the above does not look like the correct solution, as it will make
> the later BUG_ON() unreachable/meaningless.

Sorry, the subsequent BUG_ON maybe should be removed in this patch, because
for skb_headlen(list_skb) > len, it will continue splitting as commit 13acc94eff122 
(net: permit skb_segment on head_frag frag_list skb) does.

> 
> Do I read correctly that when the BUG_ON() triggers:
> 
> list_skb->len is 125
> len is 75
> list_skb->frag_head is true
>

yes, it's correct.
list_skb->len is 125
gso_size is 75, also the len in the BUG_ON conditon
list_skb->head_frag is true
 
> It looks like skb_segment() is becoming even and ever more complex to
> cope with unexpected skb layouts, only possibly when skb_segment() is
> called by some BPF helpers.
> 
> Thanks,
> 
> Paolo

I'll wait for more suggestions from others.

Thanks

Fred Li



