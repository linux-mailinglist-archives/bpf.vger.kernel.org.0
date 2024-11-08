Return-Path: <bpf+bounces-44321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 012F89C1508
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 05:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADE531F23974
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 04:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9117A1C3F04;
	Fri,  8 Nov 2024 03:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWiov4xn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CCC13AA5D;
	Fri,  8 Nov 2024 03:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731038321; cv=none; b=q8zX8VdX61xZgHsBokrhEuop60WkSq3MXKRRK0psFLL/2IqlH5UF8szjmWWDput4O6RpC0bQVrjLsFaYW1NK0GjLHIe4BLpNnJZJFL5BQgjRYvQ8QPR1je2VEEzo5khyZVqZ1KNBeNi4ZTMKIblbepP6KCrdA1m2pg4zrg900ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731038321; c=relaxed/simple;
	bh=G6xYyZET+LiEoBYKCD4tIlYoObq1EKM1JoyFdSTj9uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHrwjfVoo78ZMjnFEJMPFY3iOFlVmYahq4Hgw38SaaEtdvqLQVgFX7JyFoVepHR/5kp7wZlkyw0czbTuS+gu+HBbZzcxqdzDhIdZhD2s8TjnwPBuNbZjyfRNK6FF3M1/d6i9RzJPg8avWs/LDk+I66supi2+qbfe9AQu0/YK5fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWiov4xn; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e61b47c6cso1416615b3a.2;
        Thu, 07 Nov 2024 19:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731038319; x=1731643119; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kjwr2DXbjxf4lKUHhaafaHXyPKj4YCEnaURIWXZUSiA=;
        b=GWiov4xnXKwqRhcjkKAXeL9EupnPkcn9IenSdHqfmAeT2TS65doAeKtzjS8ZmCmRWR
         87iniweMSm+OPKB7TfiuyhiVUM9KtLhvWPYBQxTAssjLBbxiWrZrrtwXhW7nmProuI+q
         BfRhjFIQLa+Z8oL6lqvsyyWZXds+fy9KbzMtT5aSp4mhT1rCLggGYYiQLHQZj3f+HDOf
         RhztEBeY0GIi+X9BdO/JpCrkHfiSbmUayfmCHLHQBUNQin7DycRSrlIrOa6E/2SYSoVn
         0QEQ0O19KniqJm60VmV9FlaUf2gtlSe/K+k147PGHxId4N7u49YbF/D8vg69s/lo1f25
         ddTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731038319; x=1731643119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kjwr2DXbjxf4lKUHhaafaHXyPKj4YCEnaURIWXZUSiA=;
        b=IBDr8ElS7tCCOdWQMhMoYUf7fAbdrifV126ZPPHkuEFcPCacMeY1KAyWvYVnvbc1Ad
         JJyrAiogTPpcsURn1jmQgXTf2wUwAloE4t1rhyfV+2WQ4zxSCLyBd9DvTDeWTc4UEyFA
         xsxbEcbqr2RDfJDwzbzQQKch20BJrxFekpcyt1bfWjwvpuzLd5xZuyvWZnLqXXXZ2d9k
         sjxMFWg87dMRSiuqF031rP7PoI+KGD61TJmubTZxczJS4kArbAQcnr+Y4ZjxXtCFMgzR
         v3qHhHhcJGZAJU8xrY6VKFFbjCdO+H30E2aNylcrF4hBkaIjhbGknb0raQzc73QLyarX
         HpDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVi5bh/JmCKtXRKmfCpmUdvitHqv9aH/nkXL8M7ezxTLXREtXL9XEpwAV5vN2RT5FsObHHx2o4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgdR7nZ8R75KZAV7gg659ztuPxMs+7zyGKp9t7ImD4jfYne+gr
	BT7AiAhXadlHxRqfX7t8gjtYA4Ht0VdHdt79hcqArEMgTRGJcrK9
X-Google-Smtp-Source: AGHT+IGJNXO1v8s6xGHpy/gyjeZQOJTIYdBL+MeTJsVh/Il8o1ENKlF7P8Ei7/7k1/iMDGxnNMoEJA==
X-Received: by 2002:a05:6a20:7289:b0:1d4:fd63:95bc with SMTP id adf61e73a8af0-1dc22893107mr1927924637.9.1731038318898;
        Thu, 07 Nov 2024 19:58:38 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:7950:9609:53e9:c7fa])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a4f566sm2571812b3a.171.2024.11.07.19.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 19:58:38 -0800 (PST)
Date: Thu, 7 Nov 2024 19:58:36 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: zijianzhang@bytedance.com
Cc: bpf@vger.kernel.org, john.fastabend@gmail.com, jakub@cloudflare.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, dsahern@kernel.org, netdev@vger.kernel.org,
	cong.wang@bytedance.com
Subject: Re: [PATCH bpf 0/2] tcp_bpf: update the rmem scheduling for ingress
 redirection
Message-ID: <Zy2MbHoO9xNQj2pb@pop-os.localdomain>
References: <20241017005742.3374075-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017005742.3374075-1-zijianzhang@bytedance.com>

On Thu, Oct 17, 2024 at 12:57:40AM +0000, zijianzhang@bytedance.com wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
> 
> We should do sk_rmem_schedule instead of sk_wmem_schedule in function
> bpf_tcp_ingress. We also need to update sk_rmem_alloc accordingly to
> account for the rmem.
> 

Is it possible to have a test case for this? I think it would be easier
to prove and convince people to accept these changes.

Thanks!

