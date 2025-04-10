Return-Path: <bpf+bounces-55644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EC1A83E5F
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 11:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1181797AF
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 09:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17BA211713;
	Thu, 10 Apr 2025 09:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="GAFZnsnp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD9A20F079
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 09:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744276497; cv=none; b=r3Zn484IYohpv07h1PPTjDqRzI3GLsn8SpxcQZojOlmbIu+UPU4847lyHv0NOzyOxfcOLgRWZ4W1lIPO38kG3OzefEOV1Nlo1dWuwjP8yIoFvpo31XAMs4+cFw4qhIW9SviejmsdwjyRXMTyHwpQcHMpvfpCZ3w+w4VaPKNArUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744276497; c=relaxed/simple;
	bh=BB4/5TGrnhxBSJ0n+TSMCvwIVPBKE7itG7Q9AayME5c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qdexfxPiW7/YnWytxvl5YCow9aDiFYp17en85iO37wiyW0aLKtJSL5NkOZAcqN8kgYPJnc3pWlILovhYGLT8NT8zxnyoRlkXfRpHCpRS5TC8y/K+EpLTu9TTtghNRVRfrHS7KhkAdVr/Wa1gjRKL+BXDCXaQjaVG3jn5ZQmI2yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=GAFZnsnp; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e5b6f3025dso843609a12.1
        for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 02:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1744276492; x=1744881292; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aa2azPnFakTpFa9UzfA6jXivdaPZndDwlyHzJIAIWaw=;
        b=GAFZnsnpRJeAHLdROOpYsz0wjbpakJLXM/FfiSfFLHW45PSUU5ZB5KGQprfWawm/5g
         U9teKmKbd9wpJEnajGRlAJVNaS4zD2YmqRNoBOy7xpfsekWf6dbCKSG26y9L4uAccYJE
         HEAtWGCIcDdysUZTv/CjgpIPt1Zj8rzEFRMh8S6elJxNSciVyWn5GkdR6GRHCcchunku
         amygJqKWxHN7fHHEqMVkBKewCrUiMiMbyKM0a7nNoJmzR1rG4Sm+8+fjVmMzmzdBCA9x
         hAduX6izk9bQtUP7SUDFMRW9e1PMDVXTtxBpykr3kHMh7xb874J3ox96kn35STtbUx1K
         jC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744276492; x=1744881292;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aa2azPnFakTpFa9UzfA6jXivdaPZndDwlyHzJIAIWaw=;
        b=HxH8WsoOLIsq4DB+tcPIDn3otkwwyYa22NF/+MUS9ZFREu6vKe77UCG0gTjUzSFpia
         0X8dCXYE2WY1q8Vegl5FYpqYo7KXKKmUERs47/5QkfrUriJGYtdsueuXt3s0SRSX8NOi
         97hW2JPQunmE+OUJgfx7odH9VZXqsiiJZQLdBLUDI2mj/VoOkC5I8XVjWq7CJXFsCeYa
         Jt2OoCb5t18bFBOUzpBzWFq/uvioKTX8n+3MqQw5mSd5QISoK0eoBKdULEbX2z+eiuu0
         l/9lO+h0ebGe+ondi/aUSmUko/IDe1Zfn0fiX2d7HNB0UX2l7hk7/CxnrcDdchfw3pQ7
         sBNA==
X-Gm-Message-State: AOJu0YzA/eqKooxA8ui+w+8RU99kWppzgnC/fzget3b7A7kuIDIrApG0
	PetpJdrybunlavaXDzCLW9OzeZhpAmifxive1AvmZfmKsPF3lE2vP1apa6a93f4=
X-Gm-Gg: ASbGncu0Vj5+CZJwbyRV5Q6xwNWY7+rc4MWGsJ/0Al93QJ2HKMT32MkPd8OPlnAdVTJ
	FUZE1T6W7abZ4tSjcDhNNIopc8G9mC4RJpXEMBMnoPFdqb83RSUYNjztW0GHFchVrYa2O9Nagzt
	i3B9eqvz5HWFZvdyF7+jvSn5YYoThSxiX5aXLECWlXLgda4JpdM6rq9kBpeANgqyGwMP/4OMgMN
	L1LDYxMS3wQbUAbjrgPtbYR4Yig+pQh+mcGnsDPpLPgSOIK6UJ/NILM8YHukr2ai5iFMsJo1xRV
	r+KhPHuHOdN+35p1HvWK0bHmNqVcWxjr
X-Google-Smtp-Source: AGHT+IGfxqUkbMd28wiwc7XZNYJ7mbGiot17Ko65didG+wzVbB4h0j9zcUm8YACTZu3LT8jeyD945Q==
X-Received: by 2002:a05:6402:84f:b0:5f0:d893:bf8a with SMTP id 4fb4d7f45d1cf-5f32929653bmr1608468a12.20.1744276492476;
        Thu, 10 Apr 2025 02:14:52 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:506a:2dc::49:1e5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f2fbd54286sm1997958a12.81.2025.04.10.02.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 02:14:51 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org,  mrpre@163.com,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  John Fastabend
 <john.fastabend@gmail.com>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman <eddyz87@gmail.com>,
  Song Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Steven Rostedt
 <rostedt@goodmis.org>,  Masami Hiramatsu <mhiramat@kernel.org>,  Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Jesper Dangaard Brouer <hawk@kernel.org>,
  linux-kernel@vger.kernel.org,  netdev@vger.kernel.org,
  linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v1] bpf, sockmap: Introduce tracing capability
 for sockmap
In-Reply-To: <20250409102937.15632-1-jiayuan.chen@linux.dev> (Jiayuan Chen's
	message of "Wed, 9 Apr 2025 18:29:33 +0800")
References: <20250409102937.15632-1-jiayuan.chen@linux.dev>
Date: Thu, 10 Apr 2025 11:14:50 +0200
Message-ID: <87ikncgyyd.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Apr 09, 2025 at 06:29 PM +08, Jiayuan Chen wrote:
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
>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  MAINTAINERS                    |  1 +
>  include/linux/bpf_trace.h      |  2 +-
>  include/trace/events/sockmap.h | 89 ++++++++++++++++++++++++++++++++++
>  net/core/skmsg.c               |  6 +++
>  4 files changed, 97 insertions(+), 1 deletion(-)
>  create mode 100644 include/trace/events/sockmap.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a7a1d121a83e..578e16d86853 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4420,6 +4420,7 @@ L:	netdev@vger.kernel.org
>  L:	bpf@vger.kernel.org
>  S:	Maintained
>  F:	include/linux/skmsg.h
> +F:	include/trace/events/sockmap.h
>  F:	net/core/skmsg.c
>  F:	net/core/sock_map.c
>  F:	net/ipv4/tcp_bpf.c
> diff --git a/include/linux/bpf_trace.h b/include/linux/bpf_trace.h
> index ddf896abcfb6..896346fb2b46 100644
> --- a/include/linux/bpf_trace.h
> +++ b/include/linux/bpf_trace.h
> @@ -3,5 +3,5 @@
>  #define __LINUX_BPF_TRACE_H__
>  
>  #include <trace/events/xdp.h>
> -
> +#include <trace/events/sockmap.h>
>  #endif /* __LINUX_BPF_TRACE_H__ */
> diff --git a/include/trace/events/sockmap.h b/include/trace/events/sockmap.h
> new file mode 100644
> index 000000000000..2a69b011e88f
> --- /dev/null
> +++ b/include/trace/events/sockmap.h
> @@ -0,0 +1,89 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM sockmap
> +
> +#if !defined(_TRACE_SOCKMAP_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_SOCKMAP_H
> +
> +#include <linux/filter.h>
> +#include <linux/tracepoint.h>
> +#include <linux/bpf.h>
> +#include <linux/skmsg.h>
> +
> +TRACE_DEFINE_ENUM(__SK_DROP);
> +TRACE_DEFINE_ENUM(__SK_PASS);
> +TRACE_DEFINE_ENUM(__SK_REDIRECT);
> +TRACE_DEFINE_ENUM(__SK_NONE);
> +
> +#define show_act(x) \
> +	__print_symbolic(x, \
> +		{ __SK_DROP,		"DROP" }, \
> +		{ __SK_PASS,		"PASS" }, \
> +		{ __SK_REDIRECT,	"REDIRECT" }, \
> +		{ __SK_NONE,		"NONE" })
> +
> +#define trace_sockmap_skmsg_redirect(sk, prog, msg, act)	\
> +	trace_sockmap_redirect((sk), "msg", (prog), (msg)->sg.size, (act))
> +
> +#define trace_sockmap_skb_redirect(sk, prog, skb, act)		\
> +	trace_sockmap_redirect((sk), "skb", (prog), (skb)->len, (act))
> +
> +TRACE_EVENT(sockmap_redirect,
> +	    TP_PROTO(const struct sock *sk, const char *type,
> +		     const struct bpf_prog *prog, int length, int act),
> +	    TP_ARGS(sk, type, prog, length, act),
> +
> +	TP_STRUCT__entry(
> +		__field(const void *, sk)
> +		__field(const char *, type)
> +		__field(__u16, family)
> +		__field(__u16, protocol)
> +		__field(int, prog_id)
> +		__field(int, length)
> +		__field(int, act)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->sk		= sk;
> +		__entry->type		= type;
> +		__entry->family		= sk->sk_family;
> +		__entry->protocol	= sk->sk_protocol;
> +		__entry->prog_id	= prog->aux->id;
> +		__entry->length		= length;
> +		__entry->act		= act;
> +	),
> +
> +	TP_printk("sk=%p, type=%s, family=%d, protocol=%d, prog_id=%d, length=%d, action=%s",
> +		  __entry->sk, __entry->type, __entry->family, __entry->protocol,
> +		  __entry->prog_id, __entry->length,
> +		  show_act(__entry->act))

sk address is useful if you're going to attach a bpf program to the
tracepoint. Not so much if you're printing the recorded trace.

I'd print the netns and the socket inode instead, or in addition to.
These can be cross-referenced against `lsns` and `ss` output.

> +);
> +
> +TRACE_EVENT(sockmap_skb_strp_parse,
> +	    TP_PROTO(const struct sock *sk, const struct bpf_prog *prog,
> +		     int size),
> +	    TP_ARGS(sk, prog, size),
> +
> +	TP_STRUCT__entry(
> +		__field(const void *, sk)
> +		__field(__u16, family)
> +		__field(__u16, protocol)
> +		__field(int, prog_id)
> +		__field(int, size)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->sk		= sk;
> +		__entry->family		= sk->sk_family;
> +		__entry->protocol	= sk->sk_protocol;
> +		__entry->prog_id	= prog->aux->id;
> +		__entry->size		= size;
> +	),
> +
> +	TP_printk("sk=%p, family=%d, protocol=%d, prog_id=%d, size=%d",
> +		  __entry->sk, __entry->family, __entry->protocol,
> +		  __entry->prog_id, __entry->size)
> +);
> +#endif /* _TRACE_SOCKMAP_H */
> +
> +#include <trace/define_trace.h>

