Return-Path: <bpf+bounces-47441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B23489F9716
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 17:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C8CA189926B
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 16:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA84223C60;
	Fri, 20 Dec 2024 16:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+9lL9f8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663F522332B;
	Fri, 20 Dec 2024 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734713497; cv=none; b=qxsNNTDEaNT7Fs39wwoCsjOhfwi0OulAX/nO8T1+cB9Ufnloh0TmgLXZA4BA13gYpfb01ROGkEhlMLKkS3gf0i3k1DD8f6E8RtLSnKkHIVMYE1U3vKTATKtpy77K4xfHc3aAZU4bDuWbHh7F5Yo3caqfIu/uVFAgBTTUGmsmhWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734713497; c=relaxed/simple;
	bh=HPkhIBw/4uEx84HWtKiBxCfbApwv+OS0b7/QpplHQec=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=t6+vIOhIwAcx6bUjxoQ3VJs9Qs0oD9IciKhYMzkJOxKBhfUVJqKuh3aRQNnZ7mp3CHIFGh65rMTpOd1EsudYfLXZcoqZvlx+dxjvyP0CET42w7pCMnHTNUMGIT7DvJfOdmK4lHy1WO4Mh1IiNhkOrLDJWXosgisRKPVS7b8j9fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+9lL9f8; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2161eb94cceso15288595ad.2;
        Fri, 20 Dec 2024 08:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734713495; x=1735318295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEud0HpUzW8AGsAHXsgRgKAN5zSUNFNJtoYvN7JgreE=;
        b=C+9lL9f8eEuT2GqFtYwxpZvSR6lK/5RCR/ZyH8H7T65h8Ipc+StMnCsS99V2Hh87VX
         AjrVNwVb9MBIjvYSkai6/GgYTNmZvAIpzP7waQBez/1UnBQBd82zsD7Es4f8rDtqmVR7
         H9OsFt3uLGLUZkmZOmQw/WxSTc8b8LxmrIT2gryg5BCel+507GtKgujyxjBBCzgbz3Gi
         sZJ2iZ7uklqdooOj/vigpt1MBcMPP8poYAYcDXVWz7Xn4K+xIvn9sIYcvvdEyILK2VHu
         SbPF3Vg7xhuEMAaT2/5PmSIUjNHSLj9pVS1HURMAlH4N4UStURDIjjgE2d0g6N79COpM
         y89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734713495; x=1735318295;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lEud0HpUzW8AGsAHXsgRgKAN5zSUNFNJtoYvN7JgreE=;
        b=I3/J/W0qHtuoSSVtJYufJsB7pgMMFiWphRFo1TxaxnpuUGj70BMLytnNg792h9KVnS
         SP03GioVFV+d2bkudMY1a2AEdNjskek/V/l+vSyrFnsDXPJPsGv/Ue61R2CGKwpLM79/
         hVvMl9LkuOrjfHlGt8VwLVGtdDnDzgeG0hcyWsjQPbBoEwD9PwYpS+UzNne+MbHdUpIF
         GLPQOCc8PFFHipR5c+DAjbQGnZ7xH1dJ/heo0Qw4V40S4j9WZm/P/OtMDCemQIkwRSd7
         h0n/rVQz5vT5xyi7xF68EGPVv6VHA+WWDytVIRlq+nCihFvgr+N1gt9ii/hDpxKcjjBD
         erTg==
X-Forwarded-Encrypted: i=1; AJvYcCW65AAhUukDgEC5IIlZiXszxcjtXi18xVGvwH83NgAXhaUliV6Vf7rN6EjW+A8h1VZP7fgOrpy5@vger.kernel.org, AJvYcCX+hE0H3HVkKYSF7x5X/AJEmtFZ+u3F/M/vrril/4cSTq0WjatpDQWclUJ63IC+eFe5SDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm2PGT1D9PzaquI4MfIES8gl/w0wKrtqf8bS6EDOWdhNfp9nGf
	SZQeHXqE9MAkgobB8XGXLFPsX9zRUZAMJkCef9Cn69AFuXeyx2gPrR/9Fw==
X-Gm-Gg: ASbGncub8nEsRAyQ8dEutodADUwUG4+JSMeIOJZ1l/fi6kGNoz1BroSLs6aslC8Kg3N
	2B7zJ5PYh5yKXKqKDeJ7iBVoSYaGMq1qHokmKKVLkoAnnzPXWYhbkC4YSzYzFUTiZX+QpTX5Lgn
	kYb1KUJIptUTIOJA1imXoJYIrSfxnUKvvkuMrmUqcn+g8jIGlWB9co1u+oaD4Z+N8AcK+z7xqPf
	35N+9iYDEhHxBOJzuUvVdQHuJ6e26u/yRntNOCyaHS2GpnPqUL5V0s=
X-Google-Smtp-Source: AGHT+IH6hncF/IXzQqsfRxzRQS3FjeB5XNGzIaaBFZ6mk/sB7K7m1zCBlM90qhx2V3qOr/jvkYfJYw==
X-Received: by 2002:a17:902:e54e:b0:216:45eb:5e4d with SMTP id d9443c01a7336-219e6e8c529mr52391405ad.6.1734713495643;
        Fri, 20 Dec 2024 08:51:35 -0800 (PST)
Received: from localhost ([98.97.44.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca006fasm31240115ad.227.2024.12.20.08.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 08:51:35 -0800 (PST)
Date: Fri, 20 Dec 2024 08:51:32 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: zijianzhang@bytedance.com, 
 bpf@vger.kernel.org
Cc: john.fastabend@gmail.com, 
 jakub@cloudflare.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 horms@kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 netdev@vger.kernel.org, 
 Zijian Zhang <zijianzhang@bytedance.com>
Message-ID: <6765a094c9db5_21de2208d9@john.notmuch>
In-Reply-To: <20241210012039.1669389-1-zijianzhang@bytedance.com>
References: <20241210012039.1669389-1-zijianzhang@bytedance.com>
Subject: RE: [PATCH v2 bpf 0/2] tcp_bpf: update the rmem scheduling for
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
> We should do sk_rmem_schedule instead of sk_wmem_schedule in function
> bpf_tcp_ingress. We also need to update sk_rmem_alloc in bpf_tcp_ingress
> accordingly to account for the rmem.
> 
> v2:
>   - Update the commit message to indicate the reason for msg->skb check
> 
> Cong Wang (1):
>   tcp_bpf: charge receive socket buffer in bpf_tcp_ingress()
> 
> Zijian Zhang (1):
>   tcp_bpf: add sk_rmem_alloc related logic for tcp_bpf ingress
>     redirection
> 
>  include/linux/skmsg.h | 11 ++++++++---
>  include/net/sock.h    | 10 ++++++++--
>  net/core/skmsg.c      |  6 +++++-
>  net/ipv4/tcp_bpf.c    |  6 ++++--
>  4 files changed, 25 insertions(+), 8 deletions(-)
> 
> -- 
> 2.20.1
> 

Thanks. Sorry fo rthe delay I thought this had an ACK already. My fault.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

