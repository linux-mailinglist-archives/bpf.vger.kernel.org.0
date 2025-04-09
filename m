Return-Path: <bpf+bounces-55558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFE6A82D31
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 19:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A666A4634DC
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 17:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E739270EC1;
	Wed,  9 Apr 2025 17:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIwpPEVa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28CF1DFFC;
	Wed,  9 Apr 2025 17:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744218292; cv=none; b=eAHMeB6ryfmLaY9rNilxOPmaOUMdsBcs/UC9renNmbCJuM0Ea5l+dCXlRM6zs3bOYSSgXbv7Wl81ZKTgSS5Ig7cQEmgMSG6m/t6SQaqAkDegnP5cy52B1ITm9FcqvGcagf518RWx+WS/O1W3SkgsFdZFlX61/2pUL6n8ledyAIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744218292; c=relaxed/simple;
	bh=AK63bXsws5LI+IIQAeopP/uy2WwZqDIcj/MXMgiB7g0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2Faq7RvFhNxgV818WlRfWH3Sdgz/1WEAh+vYucPaECv1HG9nmT4XrfEVR+PsVBtVvoCA3YoYdjSlyeTSSL355Dd9CN5ogQiPs0B6y2zuQxbAhNyWvnsO5LpSWGiVZ0JJOknFMfFObv2NZJDxfT0d1dghPQGk+Ai4hOaPZrjZFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIwpPEVa; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3014ae35534so5852672a91.0;
        Wed, 09 Apr 2025 10:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744218290; x=1744823090; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=klGbrW2mzbCdR+XeXsx1uph/j4tkgJ+FLETarobmc34=;
        b=bIwpPEVaIA51//rxdBCYippJnNQhm/GjFU6gUHN/+VytrjZLHXlOQfvYvKx1L2ab2y
         xozRRwpe+QZ0W3tCLM3LwIpjlN+Tw3du1HlFQRCTLcHaeo8ZSCQlLTyNstt24NjDnymG
         UkqdgwiryiZPOw4Ypb/iHvlEMpgdEgY/ay0TrXUwHlI+TkvsHLo+X5WcIKuZVmdAcfg8
         n4J68y9+ZdY1fRe/hvrH8xRkayfk7p+O+rZ/TUovLoV/E34Ps4c/LPPQqmqnA2IJmCY6
         REIt4RX/6DN8aGyRrV87WX3h+v07Zw5n3jl9vsfbrZNeOPdnABeQUJ3wCPLInhh0v3F6
         HYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744218290; x=1744823090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=klGbrW2mzbCdR+XeXsx1uph/j4tkgJ+FLETarobmc34=;
        b=Cbwh7HyFoCa7Yr7wLz0iurkYgjoAArboYbPtHIY/Uxy6+nijjQdvLEuelUBajZljjk
         P2mW6Pgym7JMIeCFiZ3pEdvEt6k6+70dOuN4nyy+NuzrT158IKz89h0Ws2AYiTTiEddR
         VBBx9kyQZ0m5jrwaj041QV1GQwZkD7W8c4ZEfYiZrmT4e4PdMDTxqMRYDSnDWpwXcq5J
         ElNIiVxHpVKA04bxDuOhO6L9q7lqXpFWiGF80cd9nWloviPMc9K3Y+DvD0xaCWGVS3Ut
         Hcv5li3hGKiy/+3iq3w3oXaaynJIySmjNwdeKfY9t4x5zeKkMq2JcCXslRClCbvku6js
         zJkw==
X-Forwarded-Encrypted: i=1; AJvYcCU8LpF3GdalMpQkcaN4V++V97VgUxueorm4UbbG7HkO8SfXBZlVfEOV0MXcUKkEfLSeV0Y87RpJ@vger.kernel.org, AJvYcCWeQ1jY6uzjC7cgFrJt3e8G9iAjRe5Bg14iRnJ3XTA+uGuv6BC7qcCrwuP+rKAE+qe7kwBM/3Xp6wdYmWg=@vger.kernel.org, AJvYcCX3I1D9UcPXXnbq6igSTp53d7BEmajLHQOPqtSkhGGEofDsTQCeuCOHFR4PMyBlpY+uSXvxyybDpxy6J6Fj6HloIgac@vger.kernel.org
X-Gm-Message-State: AOJu0YyyIpYxWeRQQS9SdefBeFxnoyxtGtKZPss4lNQu43VbIwTqpAY0
	Mg+0+A5CmybW1xm4D+S5RJtu4EnzLj02YZoJN+24ZtG2wT8E3r2E
X-Gm-Gg: ASbGncszd5PvgNbxPh62UtE/LThZQGdSABVG+/al/fHrZlQNy8PJjqqSXWjRQlyu8zW
	mEH+bXwCXXRzC6zQwbH+x4RuM0RdklQUL5rj28IJEg81h9cPFwZwvH27LzlHw+78ieTKW2Pv9jo
	l8ZrqNKzjW/J64jMC10OCM4GZGBjrdEV9862chdPFwtXdfZTxektIThyJaiSowuHV2hIK1CSdJ6
	Qq5TTOw8mq57zSySQRPjv/nGoxjhmaCVlVJ5idLhQs4A/VFHc1YTnRBTQCbXKEdqdLypBjeWgMZ
	8FKHDElc5NVZeFXZa2cL1x5zoE30OHSWPk6I0YVxIjM1
X-Google-Smtp-Source: AGHT+IH1GJQRsQdL8vsxW2i6J/AcLPmhbW7dGfFqiXayketC4IAZW8FIee9qDIlr5sPY9tyxW/kMew==
X-Received: by 2002:a17:90b:270b:b0:301:1bce:c26f with SMTP id 98e67ed59e1d1-306dd324830mr3507098a91.3.1744218289915;
        Wed, 09 Apr 2025 10:04:49 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306df06a767sm1890018a91.6.2025.04.09.10.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 10:04:49 -0700 (PDT)
Date: Wed, 9 Apr 2025 10:04:48 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, mrpre@163.com, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v1] bpf, sockmap: Introduce tracing capability
 for sockmap
Message-ID: <Z/aosJ3uvzTZTEXS@pop-os.localdomain>
References: <20250409102937.15632-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409102937.15632-1-jiayuan.chen@linux.dev>

On Wed, Apr 09, 2025 at 06:29:33PM +0800, Jiayuan Chen wrote:
> Sockmap has the same high-performance forwarding capability as XDP, but
> operates at Layer 7.
> 
> Introduce tracing capability for sockmap, similar to XDP, to trace the
> execution results of BPF programs without modifying the programs
> themselves, similar to the existing trace_xdp_redirect{_map}.
> 
> It is crucial for debugging BPF programs, especially in production
> environments.
> 
> Additionally, a header file was added to bpf_trace.h to automatically
> generate tracepoints.
> 
> Test results:
> $ echo "1" > /sys/kernel/tracing/events/sockmap/enable
> 
> skb:
> sockmap_redirect: sk=00000000d3266a8d, type=skb, family=2, protocol=6, \
> prog_id=73, length=256, action=PASS
> 
> msg:
> sockmap_redirect: sk=00000000528c7614, type=msg, family=2, protocol=6, \
> prog_id=185, length=5, action=REDIRECT
> 
> tls:
> sockmap_redirect: sk=00000000d04d2224, type=skb, family=2, protocol=6, \
> prog_id=143, length=35, action=PASS
> 
> strparser:
> sockmap_skb_strp_parse: sk=00000000ecab0b30, family=2, protocol=6, \
> prog_id=170, size=5

Nice work!

While you are on it, could we also trace skb->_sk_redir bits too? It is
very useful to distinguish, at least, ingress from egress redirection.

Thanks!

