Return-Path: <bpf+bounces-56663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AD5A9BD84
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 06:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6F391BA1E2A
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 04:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A760C6FC5;
	Fri, 25 Apr 2025 04:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAENpEAm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DEC211C;
	Fri, 25 Apr 2025 04:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745554872; cv=none; b=BSdH1/SbjuNNV7wiuh2tqkqL/47G33M/QigOhPm1CTrOy2oUnZIgFcTL6g8Vo/dtBDz6ccAnOk9JZLSwCQ4yfmI6Zw9/eHLmtCRCGS5bITvX9puINjsEMEcTe5ooigYx+ft+bPZ9GYy0JaIiloLbSJ6x2P1rEWyRtUk7uum6uxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745554872; c=relaxed/simple;
	bh=+yaWzT6r4JMRJQXV6x1vvZyp88WGrpRvUaCULB0Q3qA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QgQAo9ormXB9g0p+IFFVfebaPnsEbTLsqIEO6xsFclBo6IiDb9EJmMyP11bxorKVy1X+lMUxwzLF5hwqYkg9XXh+GscHn3VfY/BILWLMaGyQpERJJK3pRGuuYxzQB7xeFAZpn0DaCkN9Cn+HhWc0pIEEo9mCJMzLg9TXC6tyscA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAENpEAm; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-224171d6826so28620485ad.3;
        Thu, 24 Apr 2025 21:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745554870; x=1746159670; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+yaWzT6r4JMRJQXV6x1vvZyp88WGrpRvUaCULB0Q3qA=;
        b=XAENpEAmWDwCUxM4k73W2aHplr7CMComlmi6txpIVcRZnF1QN/NB+HvRL1n0SeP1ik
         KnS0jcI2gtHvbuqj2/e8yG9qvcAlOe1GBkyAslMAuTeQ+l+S4aAwK0NjFCHvC3Ml2goJ
         T+EWTgUR/GhflSdDFTLuuhfsGI+W9tlbZBzRAW/fV5qHjGg6gpJSRPo2OrER0YG9m+/t
         QLTRwklEb33TxnBPg/SjCNcXHoAZPPG7Pd/MwEGp4x1374DDfd4Xejn8er4Cl8/0U3VZ
         OF+R+m/TQdFMddEe/p3oxW7KkVQm4UoDvlwFvkHQFU1gDSHoLU3a1SFehecYEEampiwv
         97uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745554870; x=1746159670;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+yaWzT6r4JMRJQXV6x1vvZyp88WGrpRvUaCULB0Q3qA=;
        b=pUC5r2PzU3VKIZueBnXAX5XwYhAswU8tR0kpTJxS9dl742e0FJNTXbKL2yxzSvC1yg
         CkctpeDBQ5sNCOviVxtxLt6p0mi8BRCuSdoDtp3x/ASYJ9Ap2IfZVhfM/8Ue/rRR6g3k
         rBUYiDO8OutJCV6R6b94sxqurNfdrXGvXlJK2EXrnNcXP/srDvaU8+6ysy3kDHHZHG8q
         laqL3Kz8eYvYu4Vhs52u8ypgsgEc+cmqEmfDHgy7blml8H85vbqypRWVbMoRHaR4glUa
         k/pVL6AghhbhRv2Iba2rMw+2yVlHb2bP8xRtc3707NukMB7VQj0NszjCqiTiz8Xu04jt
         RfbA==
X-Forwarded-Encrypted: i=1; AJvYcCVU0k5K7WkENeZse3OBxPO4worvjktzdid45Zo5zWu/CX0fYuzpY3flczgss+A5IpV18w9p7oYlGDoBF1x+@vger.kernel.org, AJvYcCW+ttAFBrnDfIgio0FaQL63rJp33BzePS1l+mNBon4vdCxdJHqIAARRJcvwfESUjR0/Zhkdr/he@vger.kernel.org, AJvYcCXpSITeTsB3ippuRKBG/FGTP7cRt+RfFuI2tOm7IH4FcieW2sHfedt6RvBlmWIzwe9lwMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL27kZUlLf/LlWUb5Vby6uHRKHfP/pWn5/+C7qDzFVABPqVC2b
	mtB+QqB+tfSoVrP3DxRXGTdojuFCR+xOOYA1w7l1CyhRmgpzSx+R
X-Gm-Gg: ASbGncu69LLIOHeslXHmaaDPuNKPSLOqYq9NmlxuXNfVa9E2+f6R+aSJfRi5IfDIMkQ
	mS9UhnguUAxqLFiOkL6Va42qdprH7gY3pCPRNVRh4jxO9xlD8JcFeUuCk/1KvvvYhC2bDlrWPue
	AQciZw7LBrKeFFc12gfgRGoDFomgZSwa9uZwdNq5V9CbmXMxHOgnhB2+ms5NLWmlwTs7jXbJUOZ
	HNlm2iy5rlqNluszpkeUp471w9+W9UpoIK2lak4DZe7W4ls/L5OiNYZ+rLsIbwoWGGza7Wx8+dp
	fz6HlBFDhw6dsgt5UAmrXjbfObmCaNOuhgyr7SDyPHHXEPxE0Y3T5HBEs/LhvCsslTaqmVNkw5s
	ai3KaAPNESxXFfa5e78A=
X-Google-Smtp-Source: AGHT+IGWLbMKf5sYtW4rSiMV38NKZyqcmVeq1HvhSCzBrf7T/vSTtn9Z0BU/6O41NwkpiLMa+8jRAQ==
X-Received: by 2002:a17:903:fa6:b0:22d:b305:e082 with SMTP id d9443c01a7336-22dbf640a4emr13120665ad.47.1745554869899;
        Thu, 24 Apr 2025 21:21:09 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:ed97:ee93:42a1:7559? ([2001:ee0:4f0e:fb30:ed97:ee93:42a1:7559])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5103259sm22367705ad.185.2025.04.24.21.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 21:21:09 -0700 (PDT)
Message-ID: <099f2537-e756-4608-ab28-d7702b9c1436@gmail.com>
Date: Fri, 25 Apr 2025 11:21:01 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] virtio-net: disable delayed refill when pausing rx
To: Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250424104716.40453-1-minhquangbui99@gmail.com>
 <20250424183450.28f5d5fb@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20250424183450.28f5d5fb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/25/25 08:34, Jakub Kicinski wrote:
> On Thu, 24 Apr 2025 17:47:13 +0700 Bui Quang Minh wrote:
>> This only includes the selftest for virtio-net deadlock bug. The fix
>> commit has been applied already.
> This conflicts with Joe's series slightly:
> https://lore.kernel.org/all/20250424002746.16891-1-jdamato@fastly.com/
> Could you rebase on latest net-next and perhaps follow the comment
> I left on v4 ?

Sure, I'll do it. Thanks for your review :)

Quang Minh.

