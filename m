Return-Path: <bpf+bounces-45324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351029D474C
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 06:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A6ADB22E7D
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 05:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B75314F10E;
	Thu, 21 Nov 2024 05:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uh4qUbZ3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9301BA3D
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 05:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732167501; cv=none; b=cWiwsKtJQRncNPZDpWz4X8rbkz63QM16fLjgV9nfFwVhs5uVgeWmhapwsY9zWvuOVC9FHhdiNkpG+Pj9nDlqPwdZRE5HdONIeEHW3X983vhyq/2kDtQYxaKrqpLtH9OBtMjZ6+Swfhpt7aX4g8V1nTfDTjAOmOsAuBBfu5Vmjkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732167501; c=relaxed/simple;
	bh=Uf2wWPAagfB4GGTWROK6fb/jcqSOmGyzJhQjj1C0x7g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=rOH1O25pYn+P208K/ZYYgpK0htrMykpXdFbKPYa12Bko7gEP7DEtRWs5RToB0WGjxF1GD87gvjK9TZ9kHqamxj/kw95P/NVh/42ljNr2YkUirEanglattSOh8t6J4XCW1lcKaNG1A/COMU3EOZWZYLf1iEdbgg0FyXnsWuvSo7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uh4qUbZ3; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2126408cf31so3441995ad.0
        for <bpf@vger.kernel.org>; Wed, 20 Nov 2024 21:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732167497; x=1732772297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZee4/YuoGuMcoRWphnS7qUsvGNJrFCSsuvUZOfMvW4=;
        b=Uh4qUbZ3YfMwjavJ5ln4J4+3xxOFQiSPdiqdljmSZzQKbOikkaBiWSl1oFlnOXBIKS
         HsrKUzahf52T6ARb93gDGcfW1BlL5S3kL+tZ1JWOEFk/ySGaUjmMEtPrWNj5z/tP+9ol
         jBQcWvKseAHVp9kdUyNEqskdvHRrzvtT+arPJN50MRmdL97c5JBx927tYmpnW0BcMvZP
         WIzL9iCor6sG8hGcrA05SrrnSIC1sBBI+PpRzV2qYiBrGmCJHpqmIy0/rBJRQNl8GvII
         3FN2uCu3J69c6RE8eQzPfM+kO6vxLtVpN9Dc9GJg+17hmAOKr4Rd5+BLJXc9FkHRUufa
         2FJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732167497; x=1732772297;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HZee4/YuoGuMcoRWphnS7qUsvGNJrFCSsuvUZOfMvW4=;
        b=joYNAXat01tGk0/9ObhxYzN899wrqi0YrUOnOU9zZA9LB0K0242VHkNj8eIxP3zLfU
         ySbV3Ccfu4jAULRy7ucokqeMmkEkdJPwwf8jJBN3udTchjghNNxuUkadZpQrze1ApSDB
         GqXBH6nxuikMdvMdx569K6sJzkHooesbAo9sdgTTTRF/LOQbaTRwHvBWiiZfdagFoUlD
         czx6oiJJbAm1C54pemmrIIV8kVwNUSHSetAXnHUXEQCIeq1NYUNxaPI5YcnDtTHxxBRH
         2eKT4R6c/bUcBwJQiLtlDGXNQ82g9Hw753GazQeSvu6/ybwQmEjwhtK/pUtNRDsC/0TL
         9v7w==
X-Forwarded-Encrypted: i=1; AJvYcCUZVv6f1gLgiUIex/7lP8RVEr7TF+hORmQ6porSwAAoRcXkPn5v0oErkvi0HySBo26azTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhDU/owT4h7nbyrk75nVcHt1oS+qBBkH2l0QNt9AVGy0m+WeAX
	xKyEUDZmiIJUEPb6pWYF0HdCV5gZ6ExlxRhCn6JA5lSpMhbR5zH6
X-Gm-Gg: ASbGncsTWFi99h9prTS0gplOI2P3DlBjAzqFkBZhNiS8BfwEXIGQZKYxu3aVljUfEpf
	u6PX//FFwXLqWKnOpvWlxvzLJX63WHXZGeGTx9uB1lABHS4CIZik3ZPtG0/2r8YoPTzkx6NniIy
	qlslYqyITmIkoK80MNxomTf/+Zgb3N8iOps7V0P3Jut6SRKcVsqt0x0dLFNcktOEd3LpS5SHlKi
	1dJj4QyS8Qs/cirLTmGPDscTullVwlKT1ZJedA8euAoiTvdlvA=
X-Google-Smtp-Source: AGHT+IH3N25wqMJ7YIiw+vstaR93rEx00DaSZ4emVfwxSVIvvq/qptOXkCrpv2blPnREI3PHAPUn8Q==
X-Received: by 2002:a17:902:cf41:b0:212:5814:8916 with SMTP id d9443c01a7336-2127035e612mr45780955ad.45.1732167496818;
        Wed, 20 Nov 2024 21:38:16 -0800 (PST)
Received: from localhost ([98.97.39.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-212883ce7f6sm4824095ad.201.2024.11.20.21.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 21:38:15 -0800 (PST)
Date: Wed, 20 Nov 2024 21:38:14 -0800
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
Message-ID: <673ec74681e52_157a2083d@john.notmuch>
In-Reply-To: <20241016234838.3167769-2-zijianzhang@bytedance.com>
References: <20241016234838.3167769-1-zijianzhang@bytedance.com>
 <20241016234838.3167769-2-zijianzhang@bytedance.com>
Subject: RE: [PATCH bpf 1/2] selftests/bpf: Add apply_bytes test to
 test_txmsg_redir_wait_sndmem in test_sockmap
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
> Add this to more comprehensively test the socket memory accounting logic
> in the __SK_REDIRECT and __SK_DROP cases of tcp_bpf_sendmsg. We don't have
> test when apply_bytes are not zero in test_txmsg_redir_wait_sndmem.
> test_send_large has opt->rate=2, it will invoke sendmsg two times.
> Specifically, the first sendmsg will trigger the case where the ret value
> of tcp_bpf_sendmsg_redir is less than 0; while the second sendmsg happens
> after the 3 seconds timeout, and it will trigger __SK_DROP because socket
> c2 has been removed from the sockmap/hash.
> 
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> ---

Thanks, sorry for the rather long delay.

Acked-by: John Fastabend <john.fastabend@gmail.com>

