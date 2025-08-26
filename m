Return-Path: <bpf+bounces-66594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20119B3742E
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 23:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6BA46887A4
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 21:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7132C08CD;
	Tue, 26 Aug 2025 21:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bswLa60/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E145275AF0;
	Tue, 26 Aug 2025 21:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756242160; cv=none; b=CMr5suCd5fvGd1jA6PTmNUk9vwEnju/KPLgOeahYYevfauvD+t4TNcO47FjSqUzbUMAQYy9AZGlPgexhqlcZd9Pm3tFDY3rFCvH7esOrgDjjkVjFU3YLXaJmibYI3MF9gwU421Cz5oc1gdcQt87Jw43mPhCKbtqfapeLtQb+3M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756242160; c=relaxed/simple;
	bh=vrfZ69BUo9anPEfla9jyQFuNICtcviHvzQII+lC6DBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBZSpS5TPjaHd+hQaSfE+jBrTq7Zu2hVf7fCAz9QPLbabbxwbUyWnuay+4/YBuW/Dl9KRC8dGKYSqKYHJiUkDbcKMH4e9inGaFrTZc+P/BABd6tqsVDdDTeyge37DxSndn8sp1YQGqJV8qD+XntNmOPigJ15mTb4qLiY3IJ2VvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bswLa60/; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-771f69fd6feso1817668b3a.1;
        Tue, 26 Aug 2025 14:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756242156; x=1756846956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4TOz9Zz82Bs1goYRz3ZWCTIreX8cLPvw1MlQ66lZlm4=;
        b=bswLa60/LkRVn18JtjPDxjqBH3oja8nErZ72UNOWOs8ENH3Qlv6kAkPAX1QQVUmvsx
         /jhUGv2gIUhFBH4O9zZieRf6xYL2mci9lRog+5SHdkh/H3hqGAAq2AN/3b/CwrrDBH1O
         I63C+LZnxXH9fuhosakWRjM0qb1jSZ0xEGK9gLcF38sPe4y+r+RAyE7Kl9mc3/uDF1Yt
         Otovh6UNLEEp8VocKXf1YhTHKbPFHvRUQcMU6XlNuRljraz+b+LdeOKtdA4gelNbMLWU
         uzWmV+59Bog/e3tVA0WxEOe2v+5iXcFOitlnmiZjKh51THmkBhCcRT7w5QpP3E7v0KYW
         9afg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756242156; x=1756846956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4TOz9Zz82Bs1goYRz3ZWCTIreX8cLPvw1MlQ66lZlm4=;
        b=oLK9njnz+YkHgJSND+ZBuzfHOSRYT0TQ6Ep0fycScGE4uBDlykJO9kRC9emqxxEyMq
         tJXbQh9tU5W8RtKdVJ+yFIBKiYxKdiDKFSHeqjabyXKSMjUPXH3eLc1WOe2Fwe3Xzchz
         oc1JHGfJFoTQ3+tcL+9+sarpeD4alDIrm9juIWKt5KvnOb8FCtFs3xKMaoeUQc1Vh/5V
         3x12ihkGvV2p3oe840EuWJBQEkTt2OyyYfWzGhXY7xU/NQIB6pMulD0uVR8x04lhWL6F
         JXxG6u5TyGb9Hcgxrreyo1Vt6OFxlq8tQNd1xTl+fvH5ITKM7htRZiic2WFzwirMgXSE
         qzbg==
X-Forwarded-Encrypted: i=1; AJvYcCW05aULgvDBdq9aHZx4JDNEuyfzNqc7Qor6F0vL5ZArGjMnh7A3Ak081Wu7c3aoTSaFx8Wj2qJz@vger.kernel.org, AJvYcCWo7UglyPpYx6Ad2vfm4Jt2mChDwDdLqImsBsYMepemfhhhw2PWiJr0ki4YErDy/2LtqS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwQ6q6nlP1KgDA/L8CbJEBob//yu1WMclL/JOKeAo77plwpPcM
	ETpqNjNMNj0krzFX2TTDmvF3brQ3IWoZYv+1agNglG3hLd0eatxc2sw=
X-Gm-Gg: ASbGncuM2W8mfYjqO1btkivsZ2ZjFZaR+/4XiA/aYB96uFBVrUeDlucGPetipYv7BBw
	qVj436YhaXkn+WuLnF9lVRmkbdtSDS2dbgZK0EWsFy+8odrHGViwfsd6DOX2+IA5mMwxzBiW4SI
	kZxgdf3fDhIoLvcQARNVtHuMGMI9FqI8G8rUS6GApW43/PoBCmJPzepsWAugNwdTNRLXuGOjHoA
	Uf4nJYFuqIBkRGfGUgs6oFw9i+sWSzUwaLbaWBkl/+eLAoyWGSI6RKQSeSv1aJrWomotXLrLj3H
	6Vmo8niOm0z2aXaRBa6h1kBtz448bIQR/w0zNSmMrvyBptIRN37fDSLZirDskEaTwaC+fcY2Wu7
	41ztUQO3esPxaQu9qqO0FnRDlueawNiwdZ8z+NfeSC9ImhczuTrQmzZ59/92aCz2tfWB6oF90aj
	7JUDZM6y2M/GaaPHfTr7DJdSgFUkRQZq7My/9sBqchMA4lc4Tnu7azx/xS9MjXl64DWWth1lCN3
	Egb
X-Google-Smtp-Source: AGHT+IH/6NlufdVNIcLQBa6ArKC1hHZB3XZyd6aY/NncBj4ELKMeHH2KVfWUWchni4qeoMCGm4z74g==
X-Received: by 2002:a05:6a20:5491:b0:243:15b9:7658 with SMTP id adf61e73a8af0-24340d24765mr25723804637.50.1756242156469;
        Tue, 26 Aug 2025 14:02:36 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-771fbbc3b96sm2453539b3a.45.2025.08.26.14.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 14:02:36 -0700 (PDT)
Date: Tue, 26 Aug 2025 14:02:35 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 bpf-next/net 2/5] bpf: Support bpf_setsockopt() for
 BPF_CGROUP_INET_SOCK_CREATE.
Message-ID: <aK4g640zGakSxlD9@mini-arch>
References: <20250826183940.3310118-1-kuniyu@google.com>
 <20250826183940.3310118-3-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250826183940.3310118-3-kuniyu@google.com>

On 08/26, Kuniyuki Iwashima wrote:
> We will store a flag in sk->sk_memcg by bpf_setsockopt() during
> socket() or before sk->sk_memcg is set in accept().
> 
> BPF_CGROUP_INET_SOCK_CREATE is invoked by __cgroup_bpf_run_filter_sk()
> that passes a pointer to struct sock to the bpf prog as void *ctx.
> 
> But there are no bpf_func_proto for bpf_setsockopt() that receives
> the ctx as a pointer to struct sock.
> 
> Let's add a new bpf_setsockopt() variant for BPF_CGROUP_INET_SOCK_CREATE.

[..]

> Note that inet_create() is not under lock_sock().

Does anything prevent us from grabbing the lock before running
SOCK_CREATE progs? This is not the fast path, so should be ok?
Will make it easier to reason about socket options (where all paths
are locked). We do similar things for sock_addr progs in
BPF_CGROUP_RUN_SA_PROG_LOCK.

