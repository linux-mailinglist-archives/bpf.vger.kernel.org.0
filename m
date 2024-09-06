Return-Path: <bpf+bounces-39088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3491296E6D0
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 02:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 590581C213FA
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 00:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C688911CBD;
	Fri,  6 Sep 2024 00:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZifFCMIo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD189C8CE;
	Fri,  6 Sep 2024 00:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725582417; cv=none; b=ngNfXirPMzfF2vT9WsB4lYVzw4WkySGeFBlI1HQQa8Xzh5x0g/hATRA3grSnIT5idmxPvQbiRzXB17JWgb5TNriC+TUCvvpJWgSNHotPaMkHO2+b2nW9++tO3APLd4uSNc8jkvTVM3A5TcA61DII4VguP+tRV8IWsv8QmMBN+cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725582417; c=relaxed/simple;
	bh=hxAybSz8cFIO8WKDNuGWqotgBbMG3yxSs2FhGNA9jEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0yy/Ec3NQ3orGJGM0O21Y+m4bEBpKL8x0OUZ8fqxQY9Bytxjv272IourtQB9M6/b6heHDQDx/sgytL7oHV8dsUltcf9x/Y4l2ZTwxFl7hcREuW+H7ksv350Apc4wdw2ajDhkuut85QlN3+B/R0X7hQbuDGvXIfpoIDJQbA+UmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZifFCMIo; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a86883231b4so212949766b.3;
        Thu, 05 Sep 2024 17:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725582414; x=1726187214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnyJnxydptKR36Rpv71A18YSqVYOWvLP/U58TklRseA=;
        b=ZifFCMIoFmtQCkctXicfqCdsQuTyLW8ZIPNI63Hn5aq1mYIRGz5O949MAmcAeFvKye
         xPs3CWesDvrYirMb++IP8YeeS6CuJbE5FVJrGZWMU1K++kW+u+Juw13L2nDzY7nQcexC
         QhF1nnXXCC3ikN+Jmh+Rnh867ewqzqP4HbM5u3N+5BbfVF6apibvyXpFbBv6tInulIfq
         f2g5qbAcr95lLayRYcEZUdAsQHT5gD6QruIGZ5JACttg/wBt/hpJ2DF1YrgB87vcoaij
         M1ee00a9U3qmJcEcs0IjlPKOw9O3LPtVkFckD4M/ObVKXeloIKvwC8NJBWE4Mg+ZPE3+
         N/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725582414; x=1726187214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YnyJnxydptKR36Rpv71A18YSqVYOWvLP/U58TklRseA=;
        b=jpG7EXpA3fMfVRl9Ny75iOuwpBAtUDYusX8vILMUCvCTdWMZfaj1pQhk+ft6lm5NXR
         tiSsOooXxJ1UiOgp+CZaJ874F3QOtIhKrRYlGoZFLd6adVV8XMTy1Nai5Ljb+y0SA/KK
         JI1MkmRgIa+ZB76Dz6xvNvcdYScuqEreX6CDINrqgfBaQT5LhLKQK6s9PQ+yEpze+2tR
         95oEFuE8g6h5tr/EDpFgu5BED6ey32Jr38ctYmcHMDFOSgwUyo4rJ4S3OomG8e9kcWJC
         O4BhQd4J4qXQL5syCGQa1A2WPIWXl7IlJ1n3BvbMktkz65crldU60AS/cpLLCP9GPp/q
         WCQw==
X-Forwarded-Encrypted: i=1; AJvYcCUXLOCjN1GU7tOwFWFNoXMhMKGZlGebE7zsDC1+qBHELNNDv57KF8tq30aP2R9AO6/X7QIPLHYh@vger.kernel.org, AJvYcCV/j/Rm/GCscIxME6K7weqDAjIbj4HP2cshmRk7xrq0fYa2Jqo0Z9XRBpGuZnjoouXuf0TCUVxkBtPr4yFw789aIfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrUWcb5GzTDOA/R2lg5Rr2zuEDBsyetX04ASn5ISdR/zUvRbWb
	l52tQmXtzFGpEXibYaiYf9dhMzdpUSnsfxGfmuyvZQ4zGb3yx8PwIvUA7DzsrFBBfpH41S1pJmv
	eSZmfkhEwvOzJ6/742WBwqpz+QmU=
X-Google-Smtp-Source: AGHT+IGzBOo7I+xvkS52Uc3NrrytQpaostPexMBl4O4nQaZDGoLdJpOv/5vE7ZID2d/5RTXyMGG+QIIHlc/fX2aQy/A=
X-Received: by 2002:a17:907:7d8c:b0:a8a:6f79:d69d with SMTP id
 a640c23a62f3a-a8a885f5f48mr48989066b.22.1725582413870; Thu, 05 Sep 2024
 17:26:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905075622.66819-1-lulie@linux.alibaba.com> <20240905075622.66819-4-lulie@linux.alibaba.com>
In-Reply-To: <20240905075622.66819-4-lulie@linux.alibaba.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 5 Sep 2024 17:26:42 -0700
Message-ID: <CAADnVQL1Z3LGc+7W1+NrffaGp7idefpbnKPQTeHS8xbQme5Paw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/5] tcp: Use skb__nullable in trace_tcp_send_reset
To: Philo Lu <lulie@linux.alibaba.com>
Cc: bpf <bpf@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Kui-Feng Lee <thinker.li@gmail.com>, Juntong Deng <juntong.deng@outlook.com>, jrife@google.com, 
	Alan Maguire <alan.maguire@oracle.com>, Dave Marchevsky <davemarchevsky@fb.com>, 
	Daniel Xu <dxu@dxuuu.xyz>, Viktor Malik <vmalik@redhat.com>, 
	Cupertino Miranda <cupertino.miranda@oracle.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Network Development <netdev@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 12:56=E2=80=AFAM Philo Lu <lulie@linux.alibaba.com> =
wrote:
>
> Replace skb with skb__nullable as the argument name. The suffix tells
> bpf verifier through btf that the arg could be NULL and should be
> checked in tp_btf prog.
>
> For now, this is the only nullable argument in tcp tracepoints.
>
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> ---
>  include/trace/events/tcp.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> index 1c8bd8e186b89..a27c4b619dffd 100644
> --- a/include/trace/events/tcp.h
> +++ b/include/trace/events/tcp.h
> @@ -91,10 +91,10 @@ DEFINE_RST_REASON(FN, FN)
>  TRACE_EVENT(tcp_send_reset,
>
>         TP_PROTO(const struct sock *sk,
> -                const struct sk_buff *skb,
> +                const struct sk_buff *skb__nullable,
>                  const enum sk_rst_reason reason),
>
> -       TP_ARGS(sk, skb, reason),
> +       TP_ARGS(sk, skb__nullable, reason),

netdev folks pls ack this patch.

Yes, it's a bit of a whack a mole and eventually we can get rid of it
with a smarter verifier (likely) or smarter objtool (unlikely).
Long term we should be able to analyze body of TP_fast_assign
automatically and conclude whether it's handling NULL for pointer
arguments or not. bpf verifier can easily do it for bpf code.
We just need to compile TP_fast_assign() as a tiny bpf snippet.
This is work in progress.

For now we have to use a suffix like __nullable.

