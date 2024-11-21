Return-Path: <bpf+bounces-45350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C30E9D4AEF
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 11:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C19422870F0
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 10:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3BA1CDFCF;
	Thu, 21 Nov 2024 10:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c3Fn0yg4"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D70D171650
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 10:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732185147; cv=none; b=WaWPG8gBNgq+yW4lbGCeqApyu8jgKR7WiRURXzmwPFJf0WxfwbDc9zK/il2Jsu6WthJIFtkrxxFg5Z0SokX9vTB7XkEJ7EfFNoM0lsnx40yRcxz6tQJeM360T+dL5mEZSzL11diz8DsUUXIHdLjSAcIpwZCjuX2rf1Zzwd2LIHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732185147; c=relaxed/simple;
	bh=+f6krG8YyiieqMzFw5fnwVLxZpyjSeuutApQmSfBhTo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bjGaQSKRoJx5IW0jh9lcpVWkTDpBFf+A033OniLoE/TKwfsRk1Tc+ANFW/dVClzG5AeFDZxygRejA/6hvOqDd/QYZH28uHys5PvGXj46djET2EWM/GDhW/szL7XEdvAQ+hRl14NsAXc6glD0NSTNF6/B1ooY7dGfq/TUZCqtZgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c3Fn0yg4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732185144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+f6krG8YyiieqMzFw5fnwVLxZpyjSeuutApQmSfBhTo=;
	b=c3Fn0yg4ud6ZpmpP/zSk4LBWrb99k8QtRX1/HpKxroulsSQYdSk1sEKshZS8KmSu4aiODt
	GIwLRY7tVZGyelbuUGq4mKsxMsAoh/zPjbRpoQNWKnY/KsnUvsQlAb9EnPjndKNz1uMxPv
	0J/0WQiR3xKKEVd5k8WlASkfRHdZY54=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-J2iCQFJEMLGuNusFpqDNnA-1; Thu, 21 Nov 2024 05:32:23 -0500
X-MC-Unique: J2iCQFJEMLGuNusFpqDNnA-1
X-Mimecast-MFC-AGG-ID: J2iCQFJEMLGuNusFpqDNnA
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4315ad4938fso5107065e9.0
        for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 02:32:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732185142; x=1732789942;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+f6krG8YyiieqMzFw5fnwVLxZpyjSeuutApQmSfBhTo=;
        b=Y96/Qn+lIhXF89X6yA5xjfDUJYjMbNi+u0CkE3wgazNwcT+XJxRR3alXJRUW/zhSm2
         Nx7vPIgijtuYy/ftw10elRS5mKtsSHC0pQOG+a9O1K/08UYu9TVl8SLVH26vkdjxbq8h
         FfJtGzgLT13YoczFLkYOKECkLoWL7uZa7GWUm8XVpnc5I3/fdQCQVW0IWJSUhZJJu1vd
         0W8cFlvuKRsvjadl6mPOsMy+94rsR74kftOm3YIZfgWyLdbnLcRmCdGOv31m9j5VO59q
         P1K5eK4Tv3YNZUqkpRux2VCc7CZte/WQ48oCmhkuotLfHBJM7uxrUiFOTRdDddUBy8Ox
         G7hw==
X-Forwarded-Encrypted: i=1; AJvYcCUidkwu926LWdhg+JgRI9rXBNAjAIxG/91GMF9/mAGLtP03HooYDnfXts/XVuGGgaOXt9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YywMsDYX8Q0vhdQKgfN1VwhcYpXbkT9U6NPHj0Qtr71kNVs7SR5
	j447T1hSM1Z4zVqtavHz1oBbV3p8duals23HDR8q6CH9VPVawW6Wfe4sWH74Ra4P4JsCubIe83A
	XTd8PUdgtfHRpwg2ThxA2LsrOrwQ0g5Bb19oASg6o+pR/AUw7kw==
X-Gm-Gg: ASbGncspOjriOU8N5Z80ixRzgg7Csdo1BY8o6XHkEVRrhBkWP2M+Xtu6ztpRl41qvyj
	ENV1N9rsGpiPQ7b6iRm+usAsU8494y/sspxhzn+Ye2ZymRZqsexCb1V0OpXzBLrpWik0XJ7sN5/
	sODa77cNIVkyj5JXfXKyBZfETcqVAu7udil2kMb4wzvO8k+LggUyIepOEEZ+w4FfnAHUndeCHC6
	iMdraCNc6QzMYycJ+lcUGBF2lCOQklxRjMWzpxsnQ/6I4I=
X-Received: by 2002:a05:600c:5026:b0:42f:7e87:3438 with SMTP id 5b1f17b1804b1-43348906a77mr58831845e9.0.1732185141826;
        Thu, 21 Nov 2024 02:32:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEy1b5sCqE0/IoSB1PeKDde3wSIBPGfddZP/hZDohZtTKxAX/HJIAtroK9paXfQYIbeBK3GsQ==
X-Received: by 2002:a05:600c:5026:b0:42f:7e87:3438 with SMTP id 5b1f17b1804b1-43348906a77mr58831705e9.0.1732185141529;
        Thu, 21 Nov 2024 02:32:21 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b01e0584sm50444325e9.5.2024.11.21.02.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 02:32:20 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id CEFA9164D8DB; Thu, 21 Nov 2024 11:32:19 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Hao Luo
 <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, Daniel
 Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Thomas
 =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, houtao1@huawei.com,
 xukuohai@huawei.com
Subject: Re: [PATCH bpf-next 03/10] bpf: Handle BPF_EXIST and BPF_NOEXIST
 for LPM trie
In-Reply-To: <20241118010808.2243555-4-houtao@huaweicloud.com>
References: <20241118010808.2243555-1-houtao@huaweicloud.com>
 <20241118010808.2243555-4-houtao@huaweicloud.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 21 Nov 2024 11:32:19 +0100
Message-ID: <87bjy8j2rw.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hou Tao <houtao@huaweicloud.com> writes:

> From: Hou Tao <houtao1@huawei.com>
>
> There is exact match during the update of LPM trie, therefore, add the
> missed handling for BPF_EXIST and BPF_NOEXIST flags.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


