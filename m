Return-Path: <bpf+bounces-51833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CF4A39EAA
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 15:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BA137A4BF6
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 14:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D5026A0D2;
	Tue, 18 Feb 2025 14:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYiaIdVl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD7526A0C2;
	Tue, 18 Feb 2025 14:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739888613; cv=none; b=TMontb7tdACHvrfvY55btECLr5QrViTUpWdReLxX377M1LMH5v2J9xNk3ioxSpXWAE60VLtJrxIzG+dGWt9RHp96a13dKHKn/JZs9puI7OHE06F28y5D7Q3Brxrd6QmpCxTny9gkz6WeNRAbER8D1y9BiiRRcD+n9bigEGHoaMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739888613; c=relaxed/simple;
	bh=o0kr4oPtjBUUVPz8w6aWci9aFbelCHTWFUVw9G8wlXk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=AWh10JbX5Nx8zz4HxhaohmMLnZOILpheTfSyvIthePXOv12LbE7Y0P+JdozDD1itot3qnHz5UPJ3QRhSoyrsXtXMczS8BkNVLE8DC6b3BjEt0JG+YW/+P6YDLgTQqlIOjXiN4bklLw9kokZ20XMH5nPmDGJjb+Lm4dd3HZ0Ht3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYiaIdVl; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c0892e4b19so389964785a.3;
        Tue, 18 Feb 2025 06:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739888610; x=1740493410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKGjhSaJZ+ZH3iTkdLLQoNHs0Xa4HsnYmIckT9BTv0k=;
        b=CYiaIdVlKghioEROxQAcZ5qpq3TlBUdifuNGJy9SI1VKnXZ3iZH86K69LH4RGJF/tf
         DL/eVM2EqdKTZUW8YAs0SzcHvBzNySRGs0m0ZVwiyTTKzhxfLsjQvuPxy1eTo+XDPNVn
         KTxD6mPTwDOASjVLa1gYGLjrN8bwwbiTTVuGYqN5vA0Bts64NE+3+UD+3z6OFiyIhz5V
         K9x19/OKOwTLjtJL0RudEjUdet3y5QfNCdCadrefBoSzYtG4ymza5p3eH8iNoTzmoKcg
         ezMravdw2Im7Q0dvZw1GY1b9ddUoYURxNkIXlVxgeTPB6wNlNAXvAzaG1Kc+t6P8x0vE
         92dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739888610; x=1740493410;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CKGjhSaJZ+ZH3iTkdLLQoNHs0Xa4HsnYmIckT9BTv0k=;
        b=eNplSQCB9nLOQjYUyhNy6+pGCQM2NKHX0WLsJAie3e4gYG+0hd2CEvQe24Po7y3c1G
         CKbOFnqOFL3qym1bhnP/s+NX9FQj6pgdsX1AZEeEjwJFk/YmbsNBhYF4oestSUXf3oeK
         GQx/QOm/LWUYFhki4sU0wSpd6yce1ljPcWwmyErulZjBfKq2cISmI+d6b1PPcL6FkN3j
         UjJM1knHunsXbtOorMrt7sc0ZpvdaNGZWpLKHAnucFYacR/y1Ri5LFd1DF2ML5iU9eHf
         jAX1ji74imWRPbtCa/hSuXu/+7YmTk0SDfi0W7LEdmdwnpy9D1KHw7sMstLPaJZKpM1c
         MlJA==
X-Forwarded-Encrypted: i=1; AJvYcCWyD6dSB0lmC0+U4oNFn7fTMU7odMrQIr4AK0YklWR0sEp0ASHxS5L9kD2JvMu3dpFFOc9ddz8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1LPX8AhRTSE+e03jTA3CBiNU0chWoK65UuTNRuMyeae6B4kvH
	qUhgmM29rTiYUO9JhMWAp51dymJcfsWe+2lId4qvkZkX2TDXVRkq
X-Gm-Gg: ASbGncsEF/xZ/YReQ/7dEbJIA3UxTGAIRCUbLAGvHGBVqOHtJID15o/OESLKwmQ30P6
	Gsc5DYp+ZkpaqW8BPXNmubIPsFmvPH/5SMBOhtCLuXVUq75t3h7kfudY6pP46q1JT9btJBXl6q0
	OjVlwoQkEY2U4OTlHIoba3WDNnZVqb2G1u13HBCk6wQCe1CZmoxNEnMbMmIXnHK2NchfogQNBO5
	3nlKmtm6p98HOQjWOCXvADtz4vxqinqtDjXy6zX/+4wscr5NuqS2M8qkH09eVQvk4c/9GojmVyd
	n6yO1j+Ts8C5i1CMsjL0L+hgPpFrXqNYeIxUbpH8igx6Bl/6B/zJzYBqLwM76Hc=
X-Google-Smtp-Source: AGHT+IH7Y5IGpjKl5bqTB0yDn9CYTixA+6iws2R79Q+XK+3MZ1HQBnDMSLEbFSazueRqFof9I9+OzA==
X-Received: by 2002:a05:620a:2944:b0:7c0:82c8:e42c with SMTP id af79cd13be357-7c08aa79eafmr1800566385a.42.1739888610289;
        Tue, 18 Feb 2025 06:23:30 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c07c861537sm662616985a.67.2025.02.18.06.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 06:23:29 -0800 (PST)
Date: Tue, 18 Feb 2025 09:23:29 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 shuah@kernel.org, 
 ykolal@fb.com
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kerneljasonxing@gmail.com>
Message-ID: <67b497e197e5c_10d6a329432@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250218050125.73676-7-kerneljasonxing@gmail.com>
References: <20250218050125.73676-1-kerneljasonxing@gmail.com>
 <20250218050125.73676-7-kerneljasonxing@gmail.com>
Subject: Re: [PATCH bpf-next v12 06/12] bpf: add BPF_SOCK_OPS_TS_SCHED_OPT_CB
 callback
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> Support SCM_TSTAMP_SCHED case for bpf timestamping.
> 
> Add a new sock_ops callback, BPF_SOCK_OPS_TS_SCHED_OPT_CB. This
> callback will occur at the same timestamping point as the user
> space's SCM_TSTAMP_SCHED. The BPF program can use it to get the
> same SCM_TSTAMP_SCHED timestamp without modifying the user-space
> application.
> 
> A new SKBTX_BPF flag is added to mark skb_shinfo(skb)->tx_flags,
> ensuring that the new BPF timestamping and the current user
> space's SO_TIMESTAMPING do not interfere with each other.
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

