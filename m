Return-Path: <bpf+bounces-50515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFED4A294E7
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 16:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C62BF3AAFDE
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 15:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344D61632DA;
	Wed,  5 Feb 2025 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jxjwo7sl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E35021345;
	Wed,  5 Feb 2025 15:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738769168; cv=none; b=pEHBen++4292fwLHkn6CAwSOGS/GChcyL4xnd2CPnyOAOouTSxzAlfCM/vNLRhnDjCS3+QFLcGa90Je7rY5CZ5sfYBqeIPEdWHbU/OA2SMUqtZ08UEl3BgF5loImO/uP6PIYNN/5ogakVSHhoWUJ5Q35vssiRXpphr3egbhLKDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738769168; c=relaxed/simple;
	bh=ceI2Og1YY2tL9tTn5vhzNHhsO3c2ouqbNDoT+NvwPwY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=VStoRhI/X8Ww/1s88SgTHpNdJuOkjkoFrecfX04tZaO2vYcwCq6judWGCYMdfOCaDEZvVc3Be+hktOnh2tBFQN7FQonXfv6pbNZQjtvBSQpIkcpwcbQxs9Wg7D8Y8JR0f7i2HKKE7AzuJk+aQF0XoHCyI0VbEPUKyM2hsBPDkbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jxjwo7sl; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b7041273ddso606170185a.3;
        Wed, 05 Feb 2025 07:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738769166; x=1739373966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjvSrLR8t25XTceqrXJLcQ2KMtfLRWx+7pzwnKanK+w=;
        b=Jxjwo7slt7H/G72dY2V0brIq+Q5lWTvn0orvGmdIwfnoViBybOgFVphPecQn3gz8ea
         bLtxdFdxukp7PdX61wjBZpV7/XU31lZ9AEOqRER22EKIdQkR5rsX0k983QTshlGjmnyE
         l1NsNFnx0gEjK3VKVazk+kiwb43I1vnAEtMaPgwu97riQtapsyZ9tTcxjXLaSBOCNVyr
         KvafBFsoYjsEaqKxT1ieCXvgVPPqv8MZpgHrtMp6lTacYCk1ALPXOmi0SGDOjBtqNp/r
         626rSHX8xSm6lDKPZDaXepg3O/RiagPRTa+3dPOfUWNOcNkN5bxcd5RpIXP1KhQc6HSG
         YLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738769166; x=1739373966;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WjvSrLR8t25XTceqrXJLcQ2KMtfLRWx+7pzwnKanK+w=;
        b=OSNvWP4UYe2qnDSt2e/CLVUNQpWQIykts0J5K4E81OgLO+kqeBZMUA9nbZt91bAlW1
         v0JXmh+Xpl5pyAyz/9MhoIUUT2y6EIy2lE+2OkkBe5xcINjDMzgAfIcqTFnwipt/UWBK
         BT0+mnGiKSTzSf5ohZh7o4bTUD3eFROcs4VyrRizsjFh351KaqUHoI/OHjZQCVyQwWut
         CmXsVCaZ0bjaDFVwz8KA2eMGqw4rglwy0ZzK0HqChNkhTiRzB2S6hIcRZ+t2FnazNwNz
         GzJjHnBcshDFLzVJEVn9ZLgHHsK4Z/Pm/pSItY5ffQ7Ki6NcN9bUaS7VZFJ5hX5RDx2L
         oTpg==
X-Forwarded-Encrypted: i=1; AJvYcCVAEXoJ9d3ea/+QUbN0o7gY9Kz+KdLDaHT9WRz2rPiBttRXJewafjbbydx5LHYWOJKit36+Pmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcOCLchOwyXZQwZjfXX5kniMqRc4oe+0V4pi/MpRhjFWo58Cul
	Xd/IMsN4r+yOVkcmUSRr5ThGupkW3HYFrndqJQ59zOEoodniPn6A
X-Gm-Gg: ASbGncv+9brNo7pweY5J+fGk0W2Bkubiz8jvGYOQjRhkkyQTsQq4kyTFILEGaUjh38R
	PvkhndjhO05icutvpkj11IJKBzk2HbA2velkrKTfNNVWPAf8iHFxr6ope7Aq0WmRffdP5Xc8ngd
	8y1CB/U4/OfvNemw/pCu88+0sJsJfTKMutSQcho9dSWqfGuV/eKmsAENGixO7DzZTaLfVfR1qi+
	/q+yKTuPx8Ff7JhjwIUlUPLP5ldCQ/td+Acf75Lo03teoQkYepy9TlS/9PLoH+nNPgU4oadGFkE
	ZAjvqbBNm55RCYA9+ftABEYV7ogAdZOBQ8eirZMkbtoUnTUnMlmJDodO/DrsT+o=
X-Google-Smtp-Source: AGHT+IH6/Jj/Jc/6SWx+8IVyg+FZ4vlYmXFWubo8OpEfN+VQgsF/nlbtlTMHMgY8IwF8XJCJUqKJLw==
X-Received: by 2002:a05:620a:294c:b0:7b6:f34a:c0db with SMTP id af79cd13be357-7c03a02f319mr481662985a.57.1738769165918;
        Wed, 05 Feb 2025 07:26:05 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a90571csm758224585a.83.2025.02.05.07.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 07:26:05 -0800 (PST)
Date: Wed, 05 Feb 2025 10:26:04 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 horms@kernel.org
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kerneljasonxing@gmail.com>
Message-ID: <67a3830cbe106_14e083294f9@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250204183024.87508-5-kerneljasonxing@gmail.com>
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-5-kerneljasonxing@gmail.com>
Subject: Re: [PATCH bpf-next v8 04/12] bpf: stop calling some sock_op BPF
 CALLs in new timestamping callbacks
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> Simply disallow calling bpf_sock_ops_setsockopt/getsockopt,
> bpf_sock_ops_cb_flags_set, and the bpf_sock_ops_load_hdr_opt for
> the new timestamping callbacks for the safety consideration.

Please reword this: Disallow .. unless this is operating on a locked
TCP socket. Or something along those lines.
 
> Besides, In the next round, the UDP proto for SO_TIMESTAMPING bpf
> extension will be supported, so there should be no safety problem,
> which is usually caused by UDP socket trying to access TCP fields.

Besides is probably the wrong word here: this is not an aside, but
the actual reason for this test, if I follow correctly.

> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>  net/core/filter.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index dc0e67c5776a..d3395ffe058e 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5523,6 +5523,11 @@ static int __bpf_setsockopt(struct sock *sk, int level, int optname,
>  	return -EINVAL;
>  }
>  
> +static bool is_locked_tcp_sock_ops(struct bpf_sock_ops_kern *bpf_sock)
> +{
> +	return bpf_sock->op <= BPF_SOCK_OPS_WRITE_HDR_OPT_CB;
> +}
> +
>  static int _bpf_setsockopt(struct sock *sk, int level, int optname,
>  			   char *optval, int optlen)
>  {
> @@ -5673,6 +5678,9 @@ static const struct bpf_func_proto bpf_sock_addr_getsockopt_proto = {
>  BPF_CALL_5(bpf_sock_ops_setsockopt, struct bpf_sock_ops_kern *, bpf_sock,
>  	   int, level, int, optname, char *, optval, int, optlen)
>  {
> +	if (!is_locked_tcp_sock_ops(bpf_sock))
> +		return -EOPNOTSUPP;
> +
>  	return _bpf_setsockopt(bpf_sock->sk, level, optname, optval, optlen);
>  }
>  
> @@ -5758,6 +5766,9 @@ static int bpf_sock_ops_get_syn(struct bpf_sock_ops_kern *bpf_sock,
>  BPF_CALL_5(bpf_sock_ops_getsockopt, struct bpf_sock_ops_kern *, bpf_sock,
>  	   int, level, int, optname, char *, optval, int, optlen)
>  {
> +	if (!is_locked_tcp_sock_ops(bpf_sock))
> +		return -EOPNOTSUPP;
> +
>  	if (IS_ENABLED(CONFIG_INET) && level == SOL_TCP &&
>  	    optname >= TCP_BPF_SYN && optname <= TCP_BPF_SYN_MAC) {
>  		int ret, copy_len = 0;
> @@ -5800,6 +5811,9 @@ BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct bpf_sock_ops_kern *, bpf_sock,
>  	struct sock *sk = bpf_sock->sk;
>  	int val = argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
>  
> +	if (!is_locked_tcp_sock_ops(bpf_sock))
> +		return -EOPNOTSUPP;
> +
>  	if (!IS_ENABLED(CONFIG_INET) || !sk_fullsock(sk))
>  		return -EINVAL;
>  
> @@ -7609,6 +7623,9 @@ BPF_CALL_4(bpf_sock_ops_load_hdr_opt, struct bpf_sock_ops_kern *, bpf_sock,
>  	u8 search_kind, search_len, copy_len, magic_len;
>  	int ret;
>  
> +	if (!is_locked_tcp_sock_ops(bpf_sock))
> +		return -EOPNOTSUPP;
> +
>  	/* 2 byte is the minimal option len except TCPOPT_NOP and
>  	 * TCPOPT_EOL which are useless for the bpf prog to learn
>  	 * and this helper disallow loading them also.
> -- 
> 2.43.5
> 



