Return-Path: <bpf+bounces-55899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E641A88DB9
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 23:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC1C13B3163
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 21:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10ADE1EB1B5;
	Mon, 14 Apr 2025 21:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iprZvO/B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487C41A83F2;
	Mon, 14 Apr 2025 21:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744665935; cv=none; b=qD6awZDpZZC5q42oJlnArr9BtLU/Pq+onGrMuAwuowE2b4mY1B8fJgJ3Vy3DZU7fNEHVQBNEDi8slSbwU5/oAsa1df2QMkgS7PhxlZ2IMSvzgsgGjB2ZGlvH84X7m19wXMrsVGfns84vnDDgAbYfNBg4aElfVgQrBXOymiOM/vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744665935; c=relaxed/simple;
	bh=N4BFEDl7uYJZ/uee6Yh5jrAWw8mBsknP61/45paC1Mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsViYzfuhdyI21i7aZ2bEFU39OPkQcO8B1YpT8INf+vxMETZjG8IWXPVCeadpt/TLNe5YcjqwLs2s7Xrr8JbnFRfBUvD5OD/hLf6SwNCCVjqn5wUgJn798MjBY9xZx0CM+ZuKlcY1gwX29G5VmhLTW7SdV3i7fCMCaXIZ/Zq8pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iprZvO/B; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-225477548e1so46803305ad.0;
        Mon, 14 Apr 2025 14:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744665933; x=1745270733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u1IQBK50cTzuspbb54qXzEgBNmv1ZuYACNvXUgrmt94=;
        b=iprZvO/B9S2fQNXB5AFWQtXBCz3xY2V5ZLQlqJcTxMwJXasIAxvyg3B2e08enEM8w9
         CigXEN3y1F33YK+wrgZ3ykhX5EdvE4KVPH9SM81W9XU2TwpudvkpnTTG1150yxIX5Zis
         1t14vUsWYs+cTwz8sLnOJUOonm/bjA0BsDz2CuuHI/l7QMrBlxglifvTe+G7jcIpkFdC
         tHdrYk/GnAFvauIy3lA1ZDJOae4v7PwJ4vwZ8XGnsbBY5xKPuyppzOoplEybRfE3YUiY
         MdN3uORktmvXk8gB+DjuC1qMEet2g5m7qFapSq7ptVsbZ/VpVczHXuIx7BjneJZKNcux
         qXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744665933; x=1745270733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1IQBK50cTzuspbb54qXzEgBNmv1ZuYACNvXUgrmt94=;
        b=WpTFhcc2oybi8yXKPKciBeEihtxYTK3z0AvnCc5aQdh+1izJWzeAX72rT/OaN0F1Y8
         hMSN6rrMbsjX04m3+njBEFTEu/WWa2a/V5gWqSMWWlgtPJte/Kuo+fALPrzq8j036t4S
         4oJkZWL4/ylS1L2vtTo2XwLb8K/IoplmwuOsN7so8tfNdQyCvhCrjZTloM9Po2a1Xfqh
         nzBiE6/dt6URbcRSMhumynmjDP60fdNBtIZ5Er/hihEECF4Dgsm+uabi3H1GsUKUbzCZ
         E8XGV51+NZ++V9XT1Sazq/x+PtwPVY3rXvx1AdTWcs1XzqqYVaCRhWZjFBAp2RythQ1w
         p8/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/DtncBTYX0K21c4CdOu2bZRtJDmBv3ZXdv+JslaM3MdUoHLmNrxzkaUR4dcjDqELaS2HzZXCp@vger.kernel.org, AJvYcCUXyO+wD8Hdgdc1LwUl9YHIYopYncK5RMuOJHq4Iq/t0MpVikkDQVH3B5LQ1+K2V7akhGYj/VzgBdMWV1s=@vger.kernel.org, AJvYcCUcbPPyn0xgaowJwhfkEi/Hbmn2+fmFUxgLIHPqB5WcFD6YbAwerrLnFw3S3QaAOqgZ2hFhk1DUoP+dyiPv5COl/0AU@vger.kernel.org
X-Gm-Message-State: AOJu0YzRTUuFaI8+Vty/PjfrFbzBkViScW5OVAARovs5SN5QLdHtEHzZ
	LlHEimP1+fx4arX1Zr/bbxoFq3RSpUd+jgBJc4m/7C/nGb1ERp2H
X-Gm-Gg: ASbGncuZ72oBQTSmmj70gMSagbCESBiVDeaxSZ6kVV3C1+6SZHZu+PdxVmh137jsJwy
	gzMAGQlx4kLaDMsS/9y6851ygbVVkN7XzdPqhs36rzwYpbzfc6kLjR7wrRPMSK8zzSLXx86qiXR
	DxS9ufTANXxM1BJ0ujQltrVSR2asJCcRqfQeodIsDjcBPDWrJ4Ulu93JESezelEr5D9SfBakduX
	1h6k5vFq2V77fItQePmsBIEH7LaQwZDVBjviuDONzDHSpKaE+1228SBzFPqrG7/2IiwcqeKmHWw
	4Oh7U+VH3iOeokwBwtwcSutTm65uivV25Da4fYS+KFQy
X-Google-Smtp-Source: AGHT+IFSueGj0QdNKNpNqsLVoIp4A4P4xbJ2sCbD0cXBKvhK0NSuw7f6ErhqZ15aCkOjkYVOXZ5F1Q==
X-Received: by 2002:a17:902:f709:b0:223:fabd:4f99 with SMTP id d9443c01a7336-22bea4953demr206548995ad.5.1744665933444;
        Mon, 14 Apr 2025 14:25:33 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccb82fsm103617715ad.219.2025.04.14.14.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 14:25:32 -0700 (PDT)
Date: Mon, 14 Apr 2025 14:25:31 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, mrpre@163.com,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/2] bpf, sockmap: Introduce tracing
 capability for sockmap
Message-ID: <Z/19S2yMP/2TViMa@pop-os.localdomain>
References: <20250414161153.14990-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414161153.14990-1-jiayuan.chen@linux.dev>

On Tue, Apr 15, 2025 at 12:11:45AM +0800, Jiayuan Chen wrote:
> +#ifndef __TRACE_SOCKMAP_HELPER_ONCE_ONLY
> +#define __TRACE_SOCKMAP_HELPER_ONCE_ONLY
> +
> +enum sockmap_direct_type {
> +	SOCKMAP_REDIR_NONE	= 0,
> +	SOCKMAP_REDIR_INGRESS,
> +	SOCKMAP_REDIR_EGRESS,
> +};

I am curious why you need to define them here since you already pass
'ingress' as a parameter? Is it possible to reuse the BPF_F_INGRESS bit?

Thanks!

