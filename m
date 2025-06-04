Return-Path: <bpf+bounces-59659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11309ACE2B3
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 19:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1751168047
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 17:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E40F1DE89A;
	Wed,  4 Jun 2025 17:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zn4hnpY+"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D85D1EEA47
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 17:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749056571; cv=none; b=eSfaZ9iSGHKu3Vm+K6lKNYm31vozKTxlk4GjyyEyLql7PbTypCq+G4Cx3YhZGA/q8xz1K1inIFUZTniv0c2uImBnT2iMNLK3IP4cGEyM8eBjKEgaJEV4NnF2xZIjYu3QtcWMe4IzPG2auhPevU77zBnXkkD0C/zPyPvRmTSwa0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749056571; c=relaxed/simple;
	bh=P92Z/lDShPFdDV0ba/bd+B1EUgMMMMP1rDAJOEmCppY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RatRCFMLVFF8yIVPexMqwUFfa/9l6rYvaUgldY84jAwa+9VZoy8vfX9hMFJc8AVv9hpS4h2nVDv4lv2jawCNcbYhGXUiwm03TgnT8G+Hrn21CnEap7aBgkorvqW0F2HYqI+YlWuL7puOb3dFKs5kOqr6fxdb8eYkBc0oI36qdrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zn4hnpY+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749056568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P92Z/lDShPFdDV0ba/bd+B1EUgMMMMP1rDAJOEmCppY=;
	b=Zn4hnpY+1dmX0bdbUpIZMnvaJ/25MpMCwmKysbBUv0Ck9wn8E0ZCHonwXYiV0PmQ3MOcTr
	TYPHAPkMmuMQrcgS462Q5ZxEImW/gN2ViMV7dhZq6bsSAZgyF1ZY/n96qhf8IgZi1c9ypR
	36Jx+MAMBqzdCmeBockU/4i9QqdQAio=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-qSuCq8NhMCyvAmO-MGRmrA-1; Wed, 04 Jun 2025 13:02:47 -0400
X-MC-Unique: qSuCq8NhMCyvAmO-MGRmrA-1
X-Mimecast-MFC-AGG-ID: qSuCq8NhMCyvAmO-MGRmrA_1749056566
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-601a4d2913fso7242530a12.0
        for <bpf@vger.kernel.org>; Wed, 04 Jun 2025 10:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749056566; x=1749661366;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P92Z/lDShPFdDV0ba/bd+B1EUgMMMMP1rDAJOEmCppY=;
        b=HccQNV/JMvMzpXPSOmRXtV0GEnecBx3/iQuUJHVreLw3Lg0J8tm/ocmQzPLxRFn6r+
         x4eO22nQFqbuHGr+teyyTve5Jj0D9H/vVwtbjbG9mP95qC5EWZym/72Sp/ceZhnkmN5B
         runq2U2IlM1KA8Qq6oYivobaOk8OWMNotqES/CmnaW/60+LJQQxcPBXBwQzZ4Su1Xq+9
         znERqO0CIl7TDYDy6O/nGbqdtmDqrBgN3ZhYilz62XKz34dT3QZt+AbHEPR9pnNenop4
         LLRKWStOPVlRQH5Jcr9gtCQk4eg5PWhrlP3h7F1NCHV4itDJ4MopaP2sQJ+YU6aoUMCN
         WBMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfhC3aT6hqJc96Eyyw+pqTDCDi3YcS+l4U86Ov5M+MZeCY1Q4lxOzDq0dNdkCH6S3aDlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZGJ90kPG/OEN7yU3ogazS41XTbfe/UETrXWjtUJBfmAQkpzUW
	sx4NDPmRF0s9m+96DEDD7Wjt06jOO4/vF/Plce/zC8ZGD1K2J4tayh0AfEThOhcT4R3eQ5YzxCs
	KdAy94CBZrjhlyXT2thG9jw56RThgYWt/McXuVOhVKpgwnf+PPJDQxA==
X-Gm-Gg: ASbGncsL8sw0R6hi/JEFWjuDeCCWebQVOoPTFsVZgRvI153WLytqGLhWuco0L5M0ivL
	l88u78e7xGCRFgmJer+WmqaMJvEP9OilO+oV91TJ14oc1FBlNpeG8yZoiCq4so0D7h7dAkTiXud
	s2YS4g7/PhYohb/Xuktv268ypP0v6ywvXlHwdQB/uJEavKS0Qe+rg+O9nKivQaB3GIc3T3RiCPB
	tKQH3YL19RAvHy/7ySwOs6ifngrR4vGd8IvivLAwCwNJ1/HZm9Z+hL2uQdLeGj4uoLTKHyBg+Hg
	H3dbFZjS
X-Received: by 2002:a05:6402:348e:b0:601:f3f1:f10e with SMTP id 4fb4d7f45d1cf-606e98b0c7fmr3783601a12.5.1749056566230;
        Wed, 04 Jun 2025 10:02:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAdY6lpY2ygDLbTrWvUQe7gwiHA2y3sjXZHMWjovtfZAcIj8f4Ly3/xK0aa9hY0kNARvcHRw==
X-Received: by 2002:a05:6402:348e:b0:601:f3f1:f10e with SMTP id 4fb4d7f45d1cf-606e98b0c7fmr3783554a12.5.1749056565710;
        Wed, 04 Jun 2025 10:02:45 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-606da099aebsm1673134a12.63.2025.06.04.10.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 10:02:45 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 39C481AA916F; Wed, 04 Jun 2025 19:02:44 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, asml.silence@gmail.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
 leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Subject: Re: [RFC v4 05/18] page_pool: use netmem alloc/put APIs in
 __page_pool_alloc_pages_slow()
In-Reply-To: <20250604025246.61616-6-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-6-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Jun 2025 19:02:44 +0200
Message-ID: <87bjr3v3rf.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> Use netmem alloc/put APIs instead of page alloc/put APIs in
> __page_pool_alloc_pages_slow().
>
> While at it, improved some comments.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


