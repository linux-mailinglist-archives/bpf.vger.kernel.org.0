Return-Path: <bpf+bounces-54366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E50CA687CE
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 10:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE7ED3A7158
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 09:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBC4253328;
	Wed, 19 Mar 2025 09:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SqfL4RF5"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA83F250C00
	for <bpf@vger.kernel.org>; Wed, 19 Mar 2025 09:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376087; cv=none; b=dh1pzuYYj0OsgbLN9ZHczZAvM7RckhH+5lCGvaWBh6YAb0ZCC8mHnR01JZVa64Fp+wWdWwgKqy49v5sGxOhkf6gXPwuaQSkY3ekABbuejAzlD6hsbJ01+II2zOc83F5v3l0bObC5/6JLh6os6c/s31g8FYCUqaxVXi/MIrbDNE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376087; c=relaxed/simple;
	bh=hayqKUFA/zQJSjM3dzvjLdtKtJ8WDFXlSPyW2SDZhz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4QC89SR5cQvqPq0AN3JMOqyCxDcX8wtm8oMOYcCKvNlKq0mud+t/pujIiHGmf54A6j1M4KczQV93+eRRXibBi2Nu46HU2IByKqwjf4l36wHVgj0BKsZ8Bwgcez7u+XFp7lZL3VQfUmcQh2Td2jYM9QlbxKNQB3tcCzx7fZLHjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SqfL4RF5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742376084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SBldNCvr3M04fJOmB6HQlMjvE8qJv/8GrRmjEF3wfqc=;
	b=SqfL4RF5On3PKul5OWVvei4wV8b8IBO64+lZ0pqKLcYPyrI3P97llBDZsH6LcLogBjH20p
	653J9Q/XKCdPYlYFh9RSNhRekl9+qG5NGVb/CqsE+jtlL5MuplvwHm3FWg702gb77C2U5d
	v4KUfkOBMq0QeEP9sZQw8mPAdQAEzF0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-AvJROtfqOliqaX9CxVzIcg-1; Wed, 19 Mar 2025 05:21:23 -0400
X-MC-Unique: AvJROtfqOliqaX9CxVzIcg-1
X-Mimecast-MFC-AGG-ID: AvJROtfqOliqaX9CxVzIcg_1742376082
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cfda30a3cso26283505e9.3
        for <bpf@vger.kernel.org>; Wed, 19 Mar 2025 02:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742376082; x=1742980882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBldNCvr3M04fJOmB6HQlMjvE8qJv/8GrRmjEF3wfqc=;
        b=WiW5uSMuAS3SE0CoR1JVmxlTWan73srjgZJil9HEq2OyNJsBm9K/T9pka35y6TWa8M
         tLSw6MeuZNlifmn67pOOEsEt+qCygBxb1o/dwCYEaehX/sTr/xxNcXzBvyV54y9299ol
         EDmWla3l2oAjh/9SvyrbFhqU68llTzsHwIKbGJ14NISlRWJBfPizQnbp7o361IUJKa7P
         H/wq2PSYZjqMGpZWsSv8bvtAGskwAf3RW6f1at7TRGEiwm1OpgI/GqoIUXPoyI2I1Odj
         5JOtDrMnWHk9t6P5QqicsGhAqscysquoi09MSz89mJ68kFLCVMFdC2zwrdlHlV5aEIHq
         u5DQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0c06U8oqDThjnb4+reRLfQN1OG8hwcehjpa6K7eanPm7fDBwCoKm1X54vUdjCFaQ1hyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Cn2a7LjBCFtdv/5xQuHjRHACNOI8/ajtV8NBYAqz7vISi3xS
	qDaq1OotErUSkMuWBQxPxmjYFpM2T/JONHy1AiJHRBoMLheBfsuu9a4mCoeuM/QSnZ224pMGTF4
	H7yfA29KxxPqx2Fzen+28BMWPKGx/dnhZYo/FsXOHe7kwZVsd/A==
X-Gm-Gg: ASbGncsATSeKYZ7wKcN8lTmDmphboZwUds2JVvNhAySc6dIIrQdFyAfOemJMQZr4K2N
	eh4JZFgqBOLDucaEWf1vMh9X/qm5jGYljfpUXP8oGmnRhzLhGmqA5tLocmjXhTEoJS+RazC0aXI
	FJuv6O4Bl9lpTWrM2zOYa4IdC7S9fcZYFx0rldFsxI/Fagl98oesrpgQbeh2x2lJTss6htEIdVU
	fFAJN6GmI7g4keLEwBYJLbpuXOxBriPjj7rbx6okE9hfbADVaa6qlN83yxeyPqQ15wU63x9d59/
	p222OrhefQ==
X-Received: by 2002:a05:600c:4fc8:b0:43a:b8eb:9e5f with SMTP id 5b1f17b1804b1-43d43781d7dmr15053265e9.3.1742376081592;
        Wed, 19 Mar 2025 02:21:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFTbAy+ec2vOHg58y5rxcFbvt1zKhjrhAbtgCtsF91K96gkFV7iO8cXVF5jgAUnN+dJQoKFQ==
X-Received: by 2002:a05:600c:4fc8:b0:43a:b8eb:9e5f with SMTP id 5b1f17b1804b1-43d43781d7dmr15052755e9.3.1742376081050;
        Wed, 19 Mar 2025 02:21:21 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f84f9bsm13000475e9.33.2025.03.19.02.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 02:21:20 -0700 (PDT)
Date: Wed, 19 Mar 2025 05:21:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v4 0/3] vsock/bpf: Handle races between sockmap
 update and connect() disconnecting
Message-ID: <20250319052106-mutt-send-email-mst@kernel.org>
References: <20250317-vsock-trans-signal-race-v4-0-fc8837f3f1d4@rbox.co>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317-vsock-trans-signal-race-v4-0-fc8837f3f1d4@rbox.co>

On Mon, Mar 17, 2025 at 10:52:22AM +0100, Michal Luczaj wrote:
> Signal delivery during connect() may disconnect an already established
> socket. Problem is that such socket might have been placed in a sockmap
> before the connection was closed.
> 
> PATCH 1 ensures this race won't lead to an unconnected vsock staying in the
> sockmap. PATCH 2 selftests it. 
> 
> PATCH 3 fixes a related race. Note that selftest in PATCH 2 does test this
> code as well, but winning this race variant may take more than 2 seconds,
> so I'm not advertising it.
> 
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

vsock things:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> Changes in v4:
> - Selftest: send signal to only our own process
> - Link to v3: https://lore.kernel.org/r/20250316-vsock-trans-signal-race-v3-0-17a6862277c9@rbox.co
> 
> Changes in v3:
> - Selftest: drop unnecessary variable initialization and reorder the calls
> - Link to v2: https://lore.kernel.org/r/20250314-vsock-trans-signal-race-v2-0-421a41f60f42@rbox.co
> 
> Changes in v2:
> - Handle one more path of tripping the warning
> - Add a selftest
> - Collect R-b [Stefano]
> - Link to v1: https://lore.kernel.org/r/20250307-vsock-trans-signal-race-v1-1-3aca3f771fbd@rbox.co
> 
> ---
> Michal Luczaj (3):
>       vsock/bpf: Fix EINTR connect() racing sockmap update
>       selftest/bpf: Add test for AF_VSOCK connect() racing sockmap update
>       vsock/bpf: Fix bpf recvmsg() racing transport reassignment
> 
>  net/vmw_vsock/af_vsock.c                           | 10 ++-
>  net/vmw_vsock/vsock_bpf.c                          | 24 ++++--
>  .../selftests/bpf/prog_tests/sockmap_basic.c       | 99 ++++++++++++++++++++++
>  3 files changed, 124 insertions(+), 9 deletions(-)
> ---
> base-commit: da9e8efe7ee10e8425dc356a9fc593502c8e3933
> change-id: 20250305-vsock-trans-signal-race-d62f7718d099
> 
> Best regards,
> -- 
> Michal Luczaj <mhal@rbox.co>


