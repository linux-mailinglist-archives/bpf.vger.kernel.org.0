Return-Path: <bpf+bounces-45326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 835009D4755
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 06:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C32DB21C7D
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 05:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D351547E0;
	Thu, 21 Nov 2024 05:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmE1YDbH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1F6126F1E
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 05:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732168187; cv=none; b=IEhXXe0oL3IJu1t31ko/MkCOb7MOWLyMJde09jFPZVEXjNwIIlTiTLiDGjmuvEL8yNTAlDKhzlxs5UHQi+nzaUkNsPnCTl+RwPdTRUtnwuTSqtKxFCkVzaW+ykfENBYVHWVEjTrBhb97swDOknrQHj2es/KUnhZbnwQZgmfgn/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732168187; c=relaxed/simple;
	bh=e0DJB3iGuuHSM0RgZMwRBr7aQLFF3u5U57sldBXrKuE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=I4OfzhoncMPMpXgfQl1cFt4bhb1YDMuD76dTvXqDrV4IAmpy5jRCU9gq4pyqQp5Rs61ipF6akMq7sAlAW+mCgPCepH/XMtUIBIAWYwSxW+OqGQ+xISudio+MisL3jdTVkfrqLOe094fs5zU7cv+X7qb5DeTJDHT8f9NNbwtGRuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmE1YDbH; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-211fb27cc6bso4955205ad.0
        for <bpf@vger.kernel.org>; Wed, 20 Nov 2024 21:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732168185; x=1732772985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mn4sc7JVDNyH1xmUmNZT288UQVkSFD+RhIIySgz4Ht4=;
        b=TmE1YDbH0cTzGhVL+K/W2cYv+krqC271bcvLyrZIxnm8NvkXP+uOiNDUvGeeRbdhho
         C370BsH65k0gPnhBO59Ignp1GnuSsOaQlxVhyhugb5JzPkj4bZSc45lQJojDodKjvkil
         Z9DDpH/cVEpYRnx702qGEvx7oMJuV04F7ih2IqzPzCor0zLAzyl0F6imGEHNgdPzQ0Yh
         dJdmfaQHCMgxs3BfpicdZtw8Erwsm68/NXHlTGizNW3lB5NF/Lj6B1Il0I38gdvCaNh1
         JkTpIfNh2RxIpmg0B5paQaLdoID2snvFMVQuANlI3QfarGaFdVIVKWcUB0KbWgiIdEeq
         FSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732168185; x=1732772985;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Mn4sc7JVDNyH1xmUmNZT288UQVkSFD+RhIIySgz4Ht4=;
        b=qAgAAAtg+cyIZs/Zi47Yhn02C3t3Rhb9aZIxzyWz4Tb8fg9L2phtEms9dQDfU624Ut
         HS+ep0XmG/oJbfbeTQs9ObE6X8B1SnVig7fwcc1hTYePlji+hCd2BQFHYcGIFBlHOxJN
         33K7vwStPerFuc17ucp5UokR8ji8bNDqkrjgnCWvEKNtAvWmehi/Z6B1shPWAcExJh9Q
         leuA7ArpUccTrM55xkfV7SjdIN6FokbzPwy/zCIWeQzvkJuzfWo0YCDhGhtHJOcCtMED
         lInXwnqkq1fk7CBmGEIrPAey6Dexp6AEAYGOlEECAlY8KvJe3NhKGlQv4xVR+nEFv3Rt
         +OBg==
X-Forwarded-Encrypted: i=1; AJvYcCULokpoCKIBlKu8ttmAUU9gWK0u6glF99Q2FrFzyCn/tqdBtYRjCVu+1gHinkR9avUTdF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIZxKyTCa3hpknKyooftqV0pdSqo1sr4hD5JW+S5ezIlho19CR
	EoYjBBGdC5nNWmMXSNpBJ146nLzCr8FuVy97BTCzXov8rDTlXSMu
X-Google-Smtp-Source: AGHT+IHkqfqG2I0tv5JSI++unwUqtwjlC0faysjzz7LVB3LU+hTO8gwEM57KD8MCKCQaAcpNijvx3A==
X-Received: by 2002:a17:902:e810:b0:20c:5cdd:a91 with SMTP id d9443c01a7336-2126cb20a48mr70855355ad.41.1732168185323;
        Wed, 20 Nov 2024 21:49:45 -0800 (PST)
Received: from localhost ([98.97.39.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-212883ff4b2sm5176205ad.251.2024.11.20.21.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 21:49:44 -0800 (PST)
Date: Wed, 20 Nov 2024 21:49:43 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: zijianzhang@bytedance.com, 
 bpf@vger.kernel.org
Cc: edumazet@google.com, 
 john.fastabend@gmail.com, 
 jakub@cloudflare.com, 
 davem@davemloft.net, 
 dsahern@kernel.org, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 mykolal@fb.com, 
 shuah@kernel.org, 
 wangyufen@huawei.com, 
 xiyou.wangcong@gmail.com, 
 zijianzhang@bytedance.com
Message-ID: <673ec9f7d8f02_157a20835@john.notmuch>
In-Reply-To: <20241016234838.3167769-1-zijianzhang@bytedance.com>
References: <20241016234838.3167769-1-zijianzhang@bytedance.com>
Subject: RE: [PATCH bpf 0/2] tcp_bpf: Fix the sk_mem_uncharge logic in
 tcp_bpf_sendmsg
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

zijianzhang@ wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
> 
> When apply_bytes are not zero, sk_mem_uncharge for __SK_REDIRECT and
> __SK_DROP in tcp_bpf_sendmsg has some problem. Added a selftest to trigger
> the memory accounting WARNING, and fixed the sk_mem_uncharge logic in
> tcp_bpf_sendmsg
> 
> Zijian Zhang (2):
>   selftests/bpf: Add apply_bytes test to test_txmsg_redir_wait_sndmem in
>     test_sockmap
>   tcp_bpf: Fix the sk_mem_uncharge logic in tcp_bpf_sendmsg

I would probably prefer the patches with the fix first than the selftest
just to avoid tripping up any bisect.

But patches look good. Thanks and sorry for the delay again I was
travelling and OOO for a bit.

> 
>  net/ipv4/tcp_bpf.c                         | 11 ++++-------
>  tools/testing/selftests/bpf/test_sockmap.c |  6 +++++-
>  2 files changed, 9 insertions(+), 8 deletions(-)
> 
> -- 
> 2.20.1
> 



