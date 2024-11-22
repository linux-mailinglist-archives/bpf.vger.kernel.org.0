Return-Path: <bpf+bounces-45474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCDF9D6229
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 17:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31A5C282174
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 16:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707251E1A36;
	Fri, 22 Nov 2024 16:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MctXfxfP"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573A11E1A1C
	for <bpf@vger.kernel.org>; Fri, 22 Nov 2024 16:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292483; cv=none; b=SoXa9eL7ZrHCKfg7EcRqWQhCvzz2yYWzEJ92xeiFjZ478roh39aea2mMhdyTjmMrFLWBrY12nL5hAkaxbH4X6tFG6wz+MTXzdGks1kArjcKKdQlk3DGOamNOX68OEegPeOIM6HsD4OSiYFYD/UHUrqbBw9KHFceSpbBhf29Lxrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292483; c=relaxed/simple;
	bh=qKtTB5DV3Zl7Y+bAH9RuF3TD9YvDTYHWYvVeSislgT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cXA3V7x8L9mabQ5BxtCgfXEOf+Li4S1YdHTRsjNCOBFvqu1lZOydnTuqJxbik04QqyOBZmxwGmGoBr/6G93ocowjNpFIjlUD9AzZYDBP+8L/W9Wm4IaRGhDn0Iljm0pnRtXso2GFzYnkiBWu4WNXKcY9IO+nR7oVTcIYfWQBREw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MctXfxfP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732292479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qKtTB5DV3Zl7Y+bAH9RuF3TD9YvDTYHWYvVeSislgT4=;
	b=MctXfxfPobufAJTIZN1DFV1XrTqVYArGsgZysGxdZ22pctOnR8obDojkRN//qpmJlZm9ap
	oklp/UsRR4spujdGbQIfSYbRfAFC3mNfAPv9kQ7KjBFcEwC2MP/bbNJhoI1iUW1ATFhdy2
	Z/fifoAG6t2KxIn54yyLzjAz/AndwxQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-uF-0LgduNHCWGVKX-XWosg-1; Fri, 22 Nov 2024 11:21:18 -0500
X-MC-Unique: uF-0LgduNHCWGVKX-XWosg-1
X-Mimecast-MFC-AGG-ID: uF-0LgduNHCWGVKX-XWosg
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-539fb5677c9so2301301e87.0
        for <bpf@vger.kernel.org>; Fri, 22 Nov 2024 08:21:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732292476; x=1732897276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKtTB5DV3Zl7Y+bAH9RuF3TD9YvDTYHWYvVeSislgT4=;
        b=IJhkSrC6G1T6XKSYmCDWQ3+Hg8ITQmNCMexdlvPcuGWOdC436vkbNXYVTB+IYmI58d
         zAPurfLJSjum9rQarl2kGSofC8JfvrZ+2HZOULLSEgs1e/RennSP/WOkP/9vJ0Oj4hEU
         dc0uei1RuFhD0zjCC1+cf6QKuln2gR7pY5CS98hRMz+HMjeQi8Zh0wLqrIOkNN8npJ7M
         8SZv4sSilRtrGGgHEBq8oKfSzNQkwePuMIX0+xworDfFLp/fklQQ5qkhefTeA8Di+I+E
         05VLu1/mpp5olzNPlOhBqwctwPedlfYoNKEMa8cr5i/Vk9UnkHSYGHmsK9+an5vqvvy0
         mRJg==
X-Forwarded-Encrypted: i=1; AJvYcCXdIb7cydzFgmIWVdY/+n9t6cl+dOysCssPwofhL6hJgaa5e3y2jjGgil+pVEvs6qMtVoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YywAbHPOmaGYZJKgfqsJ7A4GiRHX7pEDSmXjl3DiPsWOPhZ6VlS
	P9Rj+bzcGR+AVqGpmCiVLVgkSvxV16QmfWPlExwG1omDM0wywKNadXUGIdcoeHTbjvfmFG2Ar8q
	fbx//DbH0b0e0UbITqBciSCUGSKVTYSPbghk8FQYcTKQcPxoYXA==
X-Gm-Gg: ASbGncu16BI9LPfchfu00PNJR59IG+h1Edj1VRiEBfc69je5LHf3dpE85I0oH6Yr6sS
	JrmN77U/fSrhiyhHgajvorfCRahAiPj802XIB4m4oBnO3KyIYEhAcsmYKyJC9gZ0fOf+fCHTZoB
	xBTnWDlzpIfuvqdagSXVmSVxuqExy9WUMuFR2m2hCg044z+MjR7nExLbXxUiLV4TU3SZ7gazG77
	mi6cjZ4tBW/a5E+XqGcmpZCau8P4h8N9H29fE+Ouw712TJ4uzTxzbFS68m8mAj4vkF+a7iqq8dQ
	nC85Xw==
X-Received: by 2002:ac2:51c9:0:b0:53d:8c79:ace5 with SMTP id 2adb3069b0e04-53dd3aabeffmr2344585e87.54.1732292476485;
        Fri, 22 Nov 2024 08:21:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFR0ePfE3lovnWGuzpFCv2uMYuHyzHPO1LZjbHFLMvu00pbafujzeSDjCej37Sftl/YHlPHDg==
X-Received: by 2002:ac2:51c9:0:b0:53d:8c79:ace5 with SMTP id 2adb3069b0e04-53dd3aabeffmr2344568e87.54.1732292476130;
        Fri, 22 Nov 2024 08:21:16 -0800 (PST)
Received: from lleonard-thinkpadp16vgen1.rmtit.csb ([176.206.22.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b463ab5fsm98768945e9.27.2024.11.22.08.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 08:21:15 -0800 (PST)
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
Subject: Re: [PATCH bpf 3/4] bpf, vsock: Invoke proto::close on close()
Date: Fri, 22 Nov 2024 17:20:31 +0100
Message-ID: <20241122162031.55141-1-leonardi@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118-vsock-bpf-poll-close-v1-3-f1b9669cacdc@rbox.co>
References: <20241118-vsock-bpf-poll-close-v1-3-f1b9669cacdc@rbox.co>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I spent some time checking and nobody but __sock_create (net/socket.c)
and vsock_release can set sock->sk to NULL.

I also ran checkpatch, everything LGTM.
Thanks for the fix!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>


