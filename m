Return-Path: <bpf+bounces-56236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BF0A93A7A
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 18:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7CE97B5094
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 16:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F332215070;
	Fri, 18 Apr 2025 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="QaT3PONR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D24214818
	for <bpf@vger.kernel.org>; Fri, 18 Apr 2025 16:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992816; cv=none; b=BzRyo5J/YJXn+O83I9IT+4gSSAMstai+QqEV4LfIk8b/k+G3kxIOYcs/7Q7r50gml8BUCjAQ9SaVATQIXDC9/FbZtKgwV+f0Qn7vbi5Vsxc+B1/B8t/MqZB7VrSxkA9lTrK8c21f2lI0+4/iTGUgDWREBEZWDTdOsCf1ywg2xNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992816; c=relaxed/simple;
	bh=dnPlx1v/5+9ztyxM4DD3uu2rXOji5rsQEo270rydr7I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jDi+JvCBI5Bd+IKb3zmthxTNz9hmUnT7FSPP4xnHT5bBFbo75h+MqKy7QWBvOaax6DhZiMBbhMKoK7GBhTA2VEHvkaVlXDOyMzzp1nrERgu+BO2J/rG217Y6KWArBDYRPB2EgmeE2wWZlgr38l38vSwQcPV6wh34j3U+2SMib28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=QaT3PONR; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5ec9d24acfbso5478658a12.0
        for <bpf@vger.kernel.org>; Fri, 18 Apr 2025 09:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1744992813; x=1745597613; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dnPlx1v/5+9ztyxM4DD3uu2rXOji5rsQEo270rydr7I=;
        b=QaT3PONRArsY3lLNVeDHfsE4UhO014kmIrTkSySDTiTJP7iFtTJyvR2447yF6y5lKF
         ulPWpPmzKAB8TuHdfWNprw0fCGljGVYNKNVSPOxB8nqhHaE2ysaYPC8NjpX7Hn0tOj0Q
         hi3WDjmr/8XFEqtt9NqG+yO/ko1ceBNf+4eXuFXqzHFHCOxivcBixorgyMzB1AgWp3PX
         m5cqqTnz0HTMAEzNsyB/+iO1iJurK6T8GglOuGzIOj4tEduqWiFyBmOuWLEOETtopxN1
         OrNAbA7tAr+txv7ZCFLwmXxVlB3RKNj6AwnFEQE2bhFdwxhAmpPD1ZDcgTnZeX6R0lqu
         fDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744992813; x=1745597613;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dnPlx1v/5+9ztyxM4DD3uu2rXOji5rsQEo270rydr7I=;
        b=k7CSj4+0FPFAiJ4jm5yWZwhooUErDsFgj01MPr4ciIccItNN6BDpxcqDYfpf36aS6A
         9/mXvXwZMTG6u9O92NdtYziB6T+JrqTpIypbd892POPK+bjwB6P9F0GCYKpbG7hy7QG/
         Vu/2HjxSy9ITPvDNpVkwA7Y9n+QfS9RMcDIXWbAI8RzENmgRuwwFRp+0lYVcWICyeClk
         tuyyhgVTBpT+yB1diXZBRya8JgftdlXkRJSSHcC0d4lM9lLy6LVJ6Juooi4tbzuZGtX9
         it/e5rK2iMxuB1lSXkvfd8iWZK15ijxljMj9mV3emhIEy2KujSBQyLlb0qgbopIiE1hC
         X+7g==
X-Forwarded-Encrypted: i=1; AJvYcCWoJncDEIZClXYiiFE7jBckY83VcCY9HVNEktlRWVNpHEL7rmgNlNg2qfGqraeyfA6JOGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7iAbifRtgX3ZRt+/y2D1kAKXQiwt2Ktoouu0n2s2M9Ve3JxeY
	a2NItQR4bz96tNTl1YAeeBRbcOXZ1XM84ATVJtM8QdPRYaZyDrcUWu313ObV8Rg=
X-Gm-Gg: ASbGnctxhrx2l3TvuBIHkG6qjujl8lLq92ayODNx+auejb627BK8VOP7CTk849uhMMO
	6MEaCL1M6dulV0VnuD4MHhm32HQD90z1+AiOLGBF7eMuQma9QykqoamLRJ1U8nQgJQdyeqzYx5c
	bhDl4f0/nF144JsCKDlt4UJ8a7Yo2/NCI3XKaVm/jPEHdgnRVa9JQENvAAR++k29b5MrmgWQr9g
	qG9NYEGTbgjV7O95i7/ZMFmuBZcJlTFbVSTBKm/hdvpTbX7N189K0LKErE7vn7pynN/8jgaJN7j
	L8xG0CGUytmfVSUzmuYGgwYXabshlZVWjQ==
X-Google-Smtp-Source: AGHT+IFLgbP7tACquxzJP1RHEXNOH/DlqDIlfnCrIa/5xv6iI7vhI+s5eVpkRTeUtU+t5K/5B3t8Fw==
X-Received: by 2002:a17:907:6e9e:b0:ac1:17fe:c74f with SMTP id a640c23a62f3a-acb7534d843mr242424666b.21.1744992813109;
        Fri, 18 Apr 2025 09:13:33 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:506a:2387::38a:4e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6eefcfb8sm137109166b.111.2025.04.18.09.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 09:13:32 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Mykola Lysenko <mykolal@fb.com>,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Martin KaFai
 Lau <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  John Fastabend <john.fastabend@gmail.com>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  Jonathan Corbet <corbet@lwn.net>,
  bpf@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 3/9] selftests/bpf: Add u32()/u64() to
 sockmap_helpers
In-Reply-To: <20250411-selftests-sockmap-redir-v2-3-5f9b018d6704@rbox.co>
	(Michal Luczaj's message of "Fri, 11 Apr 2025 13:32:39 +0200")
References: <20250411-selftests-sockmap-redir-v2-0-5f9b018d6704@rbox.co>
	<20250411-selftests-sockmap-redir-v2-3-5f9b018d6704@rbox.co>
Date: Fri, 18 Apr 2025 18:13:30 +0200
Message-ID: <87cyd9a1n9.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Apr 11, 2025 at 01:32 PM +02, Michal Luczaj wrote:
> Add integer wrappers for convenient sockmap usage.
>
> While there, fix misaligned trailing slashes.
>
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

