Return-Path: <bpf+bounces-43137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8CB9AF924
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 07:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36AD6282DF5
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 05:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CAC18CC1B;
	Fri, 25 Oct 2024 05:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTsKKxe3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C46189B9F
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 05:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729833610; cv=none; b=pq1A/NhVG5rusMGGbgNssUKNzw3qADCAll+9qnBIFM1qJDsZoQm94Yvgp0GWgmg1M4Emp0dlSMj5QA7yKrznkIRrZ27BYRGTOhQYO5EbzkKBzg+/EnclfWb8v4fa5CpeDp9xtd0frjnocsj4szZ3UO3/6HHncyO36oUz5Lm+Oz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729833610; c=relaxed/simple;
	bh=vnOP5bXvPHtkSagOGKZqOuqctpnQ69HVXy0017WV0/k=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=CIqWEuh6q+uKkS2LsmffBi61CqnUqLAstFh1FKT9gOQU5kve0z+UVX6GSwEy7uqRDTNjUX1HgyZzfuEO9gx2319cIlGXaB7uEJYzKIHh85dkvpnSPkW6mIgPzW9nMbn9gfsnrObkIGVLGcy7S0RKifBkMgp/VNVZwgCyGHDLSFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTsKKxe3; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-208cf673b8dso13791325ad.3
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 22:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729833608; x=1730438408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOb58br8psXlDg6P0oVN6oI8IQ8t7zZfb0s2b9E6YGI=;
        b=bTsKKxe3tKPJ8sA7npe7qbK22IH6+3MVs0CqO9GODMEbq/94YKbkst5grnLEsDMEl2
         dzRB7bfGDnHP5PlRcsRpgDEZXPaiiE4ZWsoreXd1oLzqHoEJifWNz2CdNwuNPxFEhjuV
         ZGmNmLLaD+SSbEhM7KdlDa5ZEXnDriyL6seAAFe4pfSP+gegR3eP/uvH9XmP9hDQrs8Q
         MFKa9lV49PfbeTWVb1FypUxdq2jEOE03LRs1WXNuvrp/EPabd4bKBf2YYJ+BMuqsTQWe
         LfWYfMMEyn3ATA2aP3bRdptbx0n2aQWLZ+EJXl2hC7M6ieWNu1IWW7D2fKxxOQNNE5cu
         OYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729833608; x=1730438408;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tOb58br8psXlDg6P0oVN6oI8IQ8t7zZfb0s2b9E6YGI=;
        b=q9dMchRBJlj1Hrn9CqX5clilHi5I6tjCfXWyGyynjjfTW+Pab/eWfhtFou3iy3V+Px
         fvIUc9Y2tXzp1Q3Sq5uU1RzYWydRVWSqu8Vq9mwxx7i+IGQrTCiZKPBKN2nYNhh+Q9hK
         SmDFTJ3feX0eUCfW/YaWN2ZODuKMu+9uL9rILzI2NCZHMGs6rWai3i7jkxZZRTApGS94
         dzI8YJdVLbd09ntHB8US+nAah/viyDwN2jCohUaoNGWqVzmCXoCxIO3lNYpGiuUpM2s0
         65cDYLUQfefapqWJuKQQ0y/LGWMeCnnNvBhQVIyyCBibnuicEI0LuVz+v2fG9DJgjxxb
         kHeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB8XVKVaqzaDAL+0Dlzz8Jwja4sAYF6VUU8NiGT/o/cZwOxsymE6TAnx2bAjvs4Ha/JSM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0ov5iH4bIxtieoSbFWRiKoE83qJcwreaAVn3Oa0N24CwEcz/S
	gOBT0xnQOylwxQXMRp175Yb2e+FFzyxPCMQhBnhfeVzaSjKIfA+H
X-Google-Smtp-Source: AGHT+IFaFQTLLC/BIwO6DXckoHhmGyqCYFYudr3hmQqq1qg+w7sU9zgNY7zyGTvOdMOQV6JVyXoObg==
X-Received: by 2002:a17:902:da8a:b0:207:3a53:fe67 with SMTP id d9443c01a7336-20fb9972f5dmr50345755ad.32.1729833607754;
        Thu, 24 Oct 2024 22:20:07 -0700 (PDT)
Received: from localhost ([98.97.32.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc030a05sm2718235ad.229.2024.10.24.22.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 22:20:07 -0700 (PDT)
Date: Thu, 24 Oct 2024 22:20:03 -0700
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
Message-ID: <671b2a8366366_656c20848@john.notmuch>
In-Reply-To: <20241020110345.1468595-8-zijianzhang@bytedance.com>
References: <20241020110345.1468595-1-zijianzhang@bytedance.com>
 <20241020110345.1468595-8-zijianzhang@bytedance.com>
Subject: RE: [PATCH bpf 7/8] bpf, sockmap: Several fixes to bpf_msg_pop_data
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
> Several fixes to bpf_msg_pop_data,
> 1. In sk_msg_shift_left, we should put_page
> 2. if (len == 0), return early is better
> 3. pop the entire sk_msg (last == msg->sg.size) should be supported
> 4. Fix for the value of variable a and sge->length
> 5. In sk_msg_shift_left, after shifting, i has already pointed to the next
> element. Addtional sk_msg_iter_var_next may result in BUG.
> 
> Fixes: 7246d8ed4dcc ("bpf: helper to pop data from messages")
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> ---

Thanks!

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

