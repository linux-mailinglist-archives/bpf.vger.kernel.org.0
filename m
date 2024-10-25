Return-Path: <bpf+bounces-43135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB2B9AF90A
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 07:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 503D21C219A7
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 05:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6D718BC05;
	Fri, 25 Oct 2024 05:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBtUf+uc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC2622B641
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 05:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729832428; cv=none; b=ciCPPAAofs9FHHsFhsFsFzetOH04h0Q79Pfw3vVRbXfKWwrgPcfKHOOsojmngbJTT6q5HXNufZbwnFzEfiT+aEI2GDHulf4cn3bnirE1A667quRNpf22ZhHGXGL/t8qRdhw4ntY90ZSB7qoNPCZl+NQgTv3fPhvX3oW4SKHjLkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729832428; c=relaxed/simple;
	bh=c6X/VdQ6R6YPurQ6yYRRue1uaG6NPf4qIj9XhxH6o34=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=h4yLO5fU82toxEmDCXk5Xbyi2sF7zQWb6c7gD9sXQ6/bHtww/huwg0H95LoG1T0S04bifYT9WWEUsF2sarYNI0uXMByb06ppLIs4QxU/NhSzAYjtBVJobc8aMiFtIex5naS99ZxPQtuFX5sir6aAuThEth3V1yBdXVo07s9fiPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBtUf+uc; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ea7ad1e01fso1097281a12.0
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 22:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729832426; x=1730437226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8qeBneDrpKVbp9Os/dmbwNIf1r4SQPa4h5cMnhi/7s=;
        b=KBtUf+uc9IpSbgjuivG9oTLpbP8fdooRPt03mnnEaI69EYAY332Mao8s0MpYOrleY/
         JW0Wq/FMTDorXHsSYKw9BS64zwCT0CD+ABVymiKPJUyQKrTXr9g8p+aLPlX8gfKuayn1
         Qfc/qBPTMaUCtEYaccPJKcq/sEHpvNJU8GX9QQgYY3Kiy7c6qPy7WSxWKyvd5trHStHI
         v4sYmEk1sj4uysCR9UJayLigQBTU0qlIorp2yyLmp/WZriQ+qSZ624b2MmW+z0QslxyY
         /rO7RW6qGozzdiL1xR0Ii04S/d09qYMsiTVpm3KQz+MNR3hC4UeK6zw+eShFF6sHkQzW
         Kyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729832426; x=1730437226;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M8qeBneDrpKVbp9Os/dmbwNIf1r4SQPa4h5cMnhi/7s=;
        b=ld68L5VT8EMgw+8QlbRvQKgEGeAxzBTki1E13c+5+5rzFYmCfADBpzd1+qjmtzqQLe
         L1/5jcqstI9HBMHFeZH/j6v04PImf7NVDe60JFcP2fTOfOKCE8Pv0YB3+XVeBtOooTZr
         4e7ygEO7SCKSnWi7sjlq3j6opAjetOu0TJ+cjSt6agGDkxPoxPcryUyKYdvOhYm/GFSe
         xzkRgvzris90v/Wuaol4YDxS1vt1Ua1Zjv3PIyAc7eGgHiil8oDP1qD+OTxyC+SBYV98
         lLlPWq5gfJn6ZkxyuCLMgQ7z4Fb2Znzv+6tG3YSN0xvsmgUq9G6kw5BU5DvCgeJr5SVw
         iRQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGIOtyvApc91RGvLdyxdGGYNPYAb8/CLw1zjd2mNDoevAklPWb5fnvJ152mOTLoqTTh/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpYCUBn2KC8BsVqgdAwXNBkAnXo1mqbkjmFmpiDBDTrwnIk+5z
	meG6SSaCjrXNDTb0asj6/IggYxx1T2aZi0zvLFrcBnvONre69xRH
X-Google-Smtp-Source: AGHT+IEjbUKZKuzJkRHS9pgf9GgtapzoTxhnI0eu43ON0BywtAX/hhjm78E9+DYQ28CNzaF4z1Kkzg==
X-Received: by 2002:a05:6a20:2d1f:b0:1d8:c74d:1ca0 with SMTP id adf61e73a8af0-1d9888725a3mr6044647637.11.1729832425810;
        Thu, 24 Oct 2024 22:00:25 -0700 (PDT)
Received: from localhost ([98.97.32.58])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc867d4bdsm274484a12.31.2024.10.24.22.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 22:00:25 -0700 (PDT)
Date: Thu, 24 Oct 2024 22:00:21 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: zijianzhang@bytedance.com, 
 bpf@vger.kernel.org
Cc: martin.lau@linux.dev, 
 daniel@iogearbox.net, 
 john.fastabend@gmail.com, 
 ast@kernel.org, 
 andrii@kernel.org, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 mykolal@fb.com, 
 shuah@kernel.org, 
 jakub@cloudflare.com, 
 liujian56@huawei.com, 
 zijianzhang@bytedance.com, 
 cong.wang@bytedance.com
Message-ID: <671b25e5e316c_656c2085e@john.notmuch>
In-Reply-To: <20241020110345.1468595-6-zijianzhang@bytedance.com>
References: <20241020110345.1468595-1-zijianzhang@bytedance.com>
 <20241020110345.1468595-6-zijianzhang@bytedance.com>
Subject: RE: [PATCH bpf 5/8] selftests/bpf: Add more tests for
 test_txmsg_push_pop in test_sockmap
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
> Add more tests for test_txmsg_push_pop in test_sockmap for stricter tests.
> 
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> ---

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

