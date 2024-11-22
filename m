Return-Path: <bpf+bounces-45475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38909D6309
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 18:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E2ABB247DC
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 17:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BD21DF961;
	Fri, 22 Nov 2024 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hzpftI8M"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42474156883
	for <bpf@vger.kernel.org>; Fri, 22 Nov 2024 17:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732296426; cv=none; b=nUG+YmMifCg7UPQQdEhKEIJ4fend1ynDLCh2m9xJ0PGACRMfnt2letbsHKGpsnm363VvgiDxOAQlgurhCwxOZvJ6NpeEqfODYe/F2F6YWoayOxROxjxheIA5rRHTBXbL9xMHPA6xjmMF+fVA4eiJsifagLoqg95xYWl+2QI+8zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732296426; c=relaxed/simple;
	bh=ClLKHDqr6PkmVcgcEQS26XuKU5WAQb5CRj4MznEbpvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/p/+lcggnsnrPhl876VkRdihx30M7p90hUqNuCYYo4vLpbO29ivuu2IoqNhYp1qjEs0Nhp5GmB1/KFbZRoKEbMyHffsn1IpHH4ZvJzyi/gXyhNwHs7nEHSq/0iznpOkcWrRrucp9S5tfq8zOjQL5jFI9EH56XSY8fZ5lrgbkwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hzpftI8M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732296419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bonjTJEsrDIaVijnWhdP+tUvaZ22+wg4ayk5WPuEpAc=;
	b=hzpftI8MVcQb9YtSAjIo4mF5YWKYGV8o1YZv7fIamFPtYviYoRrNI2H73j5eDYeCpUrerp
	jWXsev7LyKgmN+AA4JQ1siibAQjoS/bVvnlWYV3GHelTutpeT+r2+uegNYp8+fmH4rmckG
	IOMmDFVwGkWO8berNWTHeaz7lcgTrho=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-lflmpJpTOuabCsV9w_yM3w-1; Fri, 22 Nov 2024 12:26:58 -0500
X-MC-Unique: lflmpJpTOuabCsV9w_yM3w-1
X-Mimecast-MFC-AGG-ID: lflmpJpTOuabCsV9w_yM3w
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-432d04b3d40so15009475e9.1
        for <bpf@vger.kernel.org>; Fri, 22 Nov 2024 09:26:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732296417; x=1732901217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bonjTJEsrDIaVijnWhdP+tUvaZ22+wg4ayk5WPuEpAc=;
        b=NRB8Qu19gsJKsHIeFoP9SD4KZoSQdOme5HxqZDMOBcIPyaR3PPVWlyS+zbTe7YUmLG
         fBX2PLwBC4YYr3lkLgdGBufonJRnDAGleXAL/4NI7noTdCjIVz6igHx3Doa5WpXgbRoF
         vDtVmTn/mNnb7GJKQVeoXLQtnqdI1Yrbhdy6gZZyWMTRoTSJR2jnU99ZrUNSxaditWar
         1w03czMnEOf8W/UKNlXxWorh5YO3e5hGAXKXmtcJMwDvkoH8kFLtkSQUbGKtx2Jbs99f
         /fUoNG7MGoo7XuRi5PZl6yPoQtAQGejJQOcXZfxt++0KpyFEf3hXNStcCoSloWrDjzP6
         jviQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6obzvty9RXTITcgxwUD1tkeWsO16f0kfKjCfEonbHM172NO3diUYXgRu+t3pc9hqXrUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+njEGPv8GVNvmfsxp49kgPyFXhNRKcAN4Cfev757JjKdazBuc
	9cnyJHqBTEA4Bl6e0sgw4UmV8ply9+HSn4MlSN1MdR9ZMmBiiw1K/9Or4uyLPJdQt4l2poCuf0/
	L2j6qHP4LUwkeRByT+pyUVbl152f+CqoKhKQnmgUNDgreotpuaA==
X-Gm-Gg: ASbGncuGrKA+JAjnsUDJfjwEpvIN56+KpkKXWZsrCWpih9Ots4dp1or/ux/L2iTnhYW
	8aQtLaaip4SEj1gxwC0CXfsStMrjoid3nTlm7S2yUqpXoxXb5KcbCh9Aow8ztLJzUywhM7tbB+S
	Qt9vwPIkT8cwSrXYFPyfielPPmc3lyj88IZm+mrS95+PeRdy1FOBnUkENLcQ1CpIXXWLiXxIlmN
	tu4lWVMnbPEv71IJrgLIe31JzGOfW07lK/4FnuFL4snN1mX+/bJAAJHQFZnQ5Im7OMCfe0ayQVW
	ParzxQ==
X-Received: by 2002:a5d:5f8c:0:b0:382:39a7:3995 with SMTP id ffacd0b85a97d-38260b5b5a5mr3051897f8f.17.1732296417181;
        Fri, 22 Nov 2024 09:26:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJ8cnKY3PHy55oSgMvuyy7GftnO8GWR0CeQCP0dYaT9/4MetPL4C2V96vIO3UU3FglDdAiFg==
X-Received: by 2002:a5d:5f8c:0:b0:382:39a7:3995 with SMTP id ffacd0b85a97d-38260b5b5a5mr3051859f8f.17.1732296416829;
        Fri, 22 Nov 2024 09:26:56 -0800 (PST)
Received: from lleonard-thinkpadp16vgen1.rmtit.csb ([176.206.22.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbc3557sm3016023f8f.81.2024.11.22.09.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 09:26:56 -0800 (PST)
From: Luigi Leonardi <leonardi@redhat.com>
To: mhal@rbox.co
Cc: andrii@kernel.org,
	ast@kernel.org,
	bobby.eshleman@bytedance.com,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	eddyz87@gmail.com,
	edumazet@google.com,
	haoluo@google.com,
	horms@kernel.org,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	kuba@kernel.org,
	linux-kselftest@vger.kernel.org,
	martin.lau@linux.dev,
	mst@redhat.com,
	mykolal@fb.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sdf@fomichev.me,
	sgarzare@redhat.com,
	shuah@kernel.org,
	song@kernel.org,
	yonghong.song@linux.dev,
	Luigi Leonardi <leonardi@redhat.com>
Subject: Re: [PATCH bpf 1/4] bpf, vsock: Fix poll() missing a queue
Date: Fri, 22 Nov 2024 18:26:29 +0100
Message-ID: <20241122172629.62588-1-leonardi@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118-vsock-bpf-poll-close-v1-1-f1b9669cacdc@rbox.co>
References: <20241118-vsock-bpf-poll-close-v1-1-f1b9669cacdc@rbox.co>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>When a verdict program simply passes a packet without redirection, sk_msg
>is enqueued on sk_psock::ingress_msg. Add a missing check to poll().
>
>Fixes: 634f1a7110b4 ("vsock: support sockmap")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index dfd29160fe11c4675f872c1ee123d65b2da0dae6..919da8edd03c838cbcdbf1618425da6c5ec2df1a 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1054,6 +1054,9 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
> 		mask |= EPOLLRDHUP;
> 	}
> 
>+	if (sk_is_readable(sk))
>+		mask |= EPOLLIN | EPOLLRDNORM;
>+
> 	if (sock->type == SOCK_DGRAM) {
> 		/* For datagram sockets we can read if there is something in
> 		 * the queue and write as long as the socket isn't shutdown for

LGTM, thanks!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>


