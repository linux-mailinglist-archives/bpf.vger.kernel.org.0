Return-Path: <bpf+bounces-31886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4EE904613
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 23:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3479428296A
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 21:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDD8152E12;
	Tue, 11 Jun 2024 21:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVqSm/hz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1043D386;
	Tue, 11 Jun 2024 21:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718140201; cv=none; b=R3YOPgCuV5mmkd3ywFhlKWlx7SBeHAU2iz+ZxUrOXxaoemYTmqLf8M2DogNcZUSG5qI95MrnUrtnBvGRXNnbvz3bnO0veUBHITKoHP7ERvTesH/CqxitLEqeKC0vceJXU2fBLdWdQAely6RALDDNwCiAi1KhyU2+AO9O4iASeNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718140201; c=relaxed/simple;
	bh=4QWD/NppNlyX7kfge6sQvP4g4K5j5/xtiUKrkX7W3Ic=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Scmf+ntYJTg277czrA+cW9PKb2Sl1GP3h+4+85aTI8BNBFA9M61Q7XgYes95t7c7v4eB+DNvvcVCl923fWSFjTXTTDAI8h1Cnrq25x9PNb3UtD9rHF5ViV9vVh+GCdjllEqZldww5WCvCm6V4lx5/osHVqcwiwJuziCkPLEz7Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVqSm/hz; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6b064841f81so39483846d6.1;
        Tue, 11 Jun 2024 14:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718140199; x=1718744999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNqy5Cf+UvpKzNVGMgI/JNd9dLFs+0wN96hFCPZnkT0=;
        b=IVqSm/hzfkMAVhY5t1RALPPjdWR2X1jfZpooiv49mRRA0+2Tjmkbi3BxnRJF73YURA
         drUMkU3Cev51C4IfpYvPPHfl/MA7aP0oTshJhWzWGM9Xf/4MOPB+CEl9ZCmb2KPCWRoH
         VeP4trQMGBw0cLimFCB6tWDRPMINE4a8n148wDsrUZlOaHshorDY+ManWWk/wo0ZezlL
         08JpoJXC3BebUScXwCRV6QnFJHdJYSBOFYRyxOgnSFYy3ellFRNyzBqYmw6qODfOBhy8
         ruJedRP6LOiSR+ZzguqT6vIKK2Gf5D+sHm0D7JAZjxhqK4EStE0sHxWzFruWAjwB6lP3
         taNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718140199; x=1718744999;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WNqy5Cf+UvpKzNVGMgI/JNd9dLFs+0wN96hFCPZnkT0=;
        b=w0eana4M55Y2Y4Wpqc+kFW8BncOMFI+PJd1x6RETPitFANHJpivipT7oHb2VM+3Z3J
         ADm4iHXMn1j4aG9yx19TXn55Z9vYGLC1qrCUinqhekBI2JI0mpqqg4s83f8GvT9K9V1M
         DxxZGeC7Pk507lshktD+bOUOZgf/dsq/evbGH3Ede8VodVldp7tPEDSWxtgZEZ/V6XKz
         /axup9paRwzjXbyYLnbPIH4NKH6fUvbequZ+zk40eNGy1b2TEPrE/DCI/kH299Wjg4hc
         dwDk1xa7wuL0zpp+7QkPL19PjVAiU7dTQUAYRAdjMQZAhssCbIGTC9QsxSKJk+GKOdQ3
         qEiA==
X-Forwarded-Encrypted: i=1; AJvYcCWVL0wt9B+hLIyebuENDDLmw58EvTOfgkC358xWbKa8k1ohMFEsWfI3aBlPdjIDPLk5TCgiX4Ap46smDtKAzQKD2F6Mvh07UA4apPKb5lo5GFZK92VnoFAcMg7f
X-Gm-Message-State: AOJu0YxLgG06Egel/r9FR15BCmZq5uxkVgm0wiwvGlgcuVyMw4GkhVaf
	NXlQb5wIEgac0FsROj0xXQsyuG0MhkClrMBe+XohU97766uk15/iMCFHaA==
X-Google-Smtp-Source: AGHT+IE5n9M5AmO+QBXgKWiCE2fo+MQpN9ryEyWphAUtUzvL9xfJqlmPoAJul+vNPrE4FBjfL5DzDg==
X-Received: by 2002:a05:6214:318c:b0:6b0:9479:cdd7 with SMTP id 6a1803df08f44-6b09479cf95mr3335326d6.54.1718140198955;
        Tue, 11 Jun 2024 14:09:58 -0700 (PDT)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b091670069sm5754776d6.96.2024.06.11.14.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 14:09:58 -0700 (PDT)
Date: Tue, 11 Jun 2024 17:09:58 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: YiFei Zhu <zhuyifei@google.com>, 
 netdev@vger.kernel.org, 
 bpf@vger.kernel.org
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Jonathan Lemon <jonathan.lemon@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <6668bd2632a87_f6b0e294fd@willemb.c.googlers.com.notmuch>
In-Reply-To: <8501fbbb7c61b62844c2f7e7fa5d7be3ee3aa259.1718138187.git.zhuyifei@google.com>
References: <cover.1718138187.git.zhuyifei@google.com>
 <8501fbbb7c61b62844c2f7e7fa5d7be3ee3aa259.1718138187.git.zhuyifei@google.com>
Subject: Re: [RFC PATCH net-next 3/3] selftests: drv-net: Add xsk_hw AF_XDP
 functionality test
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

YiFei Zhu wrote:
> Run tools/testing/selftest/bpf/xsk_hw.c as part of drv-net.
> 
> A matrix of TX/RX, copy/zerocopy, and driver mode / skb mode, are
> tested. Additionally, it tests some edge cases such as:
> - Zerocopy TX with and without attaching an XDP prog.
> - Zerocopy RX where binding happens before fillq gets filled.
> 
> TX and RX are tested separately, and the remote side always runs
> the basic AF_PACKET handler rather than AF_XDP, in order to
> isolate potential causes of test failures.
> 
> Currently the next-hop MAC address of each side must be manually
> specified via LOCAL_NEXTHOP_MAC & REMOTE_NEXTHOP_MAC. It's probably
> doable to detect these addresses automatically, but it's future work,
> and probably library code since it is also applicable to csum.py.
> 
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

