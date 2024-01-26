Return-Path: <bpf+bounces-20388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDFF83DA38
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 13:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 164B7287D55
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 12:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1B818EDE;
	Fri, 26 Jan 2024 12:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="MKSpzUby"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3979214AA7
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 12:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706272379; cv=none; b=grP1IP95asmSklm70+yLyRMwt2esLLd2HseOGd8eqnvJoECZn0e+lHJSv3w2GWdNKkIchuGtPw7WWBgKjb/5rz2rvvQnNqQDLeS1wh7VWj99YAh0B2AW//qmuBQyriA8aFDB0N7sPaCGUUhZWaoh2PynChNNNwjJ/24g0WhAXC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706272379; c=relaxed/simple;
	bh=cgOVhmy2RN26MqE/gEsRO4plYJeqHXTMy/c1gwkZdWc=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=X1MhwaH875H9fgkPRpuykGyivYoSTC44Q9AtvtWnhNPBOo/HYhs6vcLpxWxvrCzHFpl7oqSscKJycI3VUvIxMm4eq7YK7DsA8KkKiGeNJk0IOGqjx+jdPnDCsneK6oh22idn8jFDqhLZYraCduwKMHpG6SBEYYH5E2A92TG41ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=MKSpzUby; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33934567777so407631f8f.1
        for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 04:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1706272375; x=1706877175; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=HsJEoYpG4tId4fzNtSHT4zxmg9IOdsY6XGZ6e91fAN0=;
        b=MKSpzUbyDxRdaYOV0XyVou5Y4G2EKPtDZdM6B+4OKEDh6Sv78ibwA/afM0QqShKfRY
         34KKcMRWdWFAgJ6LuFbkVLkGENFTgHHqBca8qPzKJV+ZjzXX/EoXDqYBWaSc59UDP3/u
         R4RwqOec6PHT2BF0QSbfBDpqenc0q/NzMhR4riDC/XquyBF2gmBWmP0XNRPyrl1zwvJN
         llGwDkKeWzXZXFfZJcvFeGXbErIIvS1/yLf0aDQ1E+YXKobvxWDLa6tFpypSTLO5Cvd3
         VRLo5MuvTl+r+VLYMLU7e3OLOhtTdMRioEcoH0R2RR+mLdFNImfxLReSz/ZHccS3Xpcf
         bwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706272375; x=1706877175;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HsJEoYpG4tId4fzNtSHT4zxmg9IOdsY6XGZ6e91fAN0=;
        b=YsfDQjcR+AVvCnPd8wKofNp9IPCfYgkZ3rfQjAqcpgGCEDOzo4kjFWmW9uF5RWw01X
         Uy355+N61htrjia7XK4wGXRgNrnG4nJ2RQzcrLOfqpBCiwQNaYZtWdkZE1P9qphsDMgc
         8HuCLsJhDgwtvxsgWZ0pCN1evZKuBJgo7ExNf3kqCkjoCO5dkRrXEc3VrRgj3i0ze+Nq
         Kb+rxk1eWZMrNPicZJySyCQjUYWFKPQhEpKM73zcV990dijHEqauUzfuhhkd7DZqiNiZ
         fXbgdewTJ9wmlZ2aCuTRPT/ceWrXY7HUAQ+H+z/1eEX5XCuodnqYvWVuKZBo6NqmRo5v
         oM/g==
X-Gm-Message-State: AOJu0YzP8270d+fEa4ETKB20dAvnOfgYZBHYQYIzpIanOx1EWLrYqV1z
	NjXiCem7bkGK5NDPUJX1EM1aBcdzBqHOY7M99moBgoSWZNaXXlbPje8ZJJtTkhHjPTbWfZJ5dKU
	X
X-Google-Smtp-Source: AGHT+IGT4lngZT6DnPov2znB6JwPajDWsJ/2jKs23GzxwAUkdWFsCaLk5EWQtxbsclyjQoyLhNCixw==
X-Received: by 2002:a05:600c:a47:b0:40e:d21c:58fd with SMTP id c7-20020a05600c0a4700b0040ed21c58fdmr803999wmq.188.1706272375303;
        Fri, 26 Jan 2024 04:32:55 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:1a2])
        by smtp.gmail.com with ESMTPSA id j7-20020a170906278700b00a2ec877d3a6sm579675ejc.167.2024.01.26.04.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 04:32:54 -0800 (PST)
References: <20240124185403.1104141-1-john.fastabend@gmail.com>
 <20240124185403.1104141-3-john.fastabend@gmail.com>
User-agent: mu4e 1.6.10; emacs 28.3
From: Jakub Sitnicki <jakub@cloudflare.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, andrii@kernel.org
Subject: Re: [PATCH bpf-next v2 2/4] bpf: sockmap, add a sendmsg test so we
 can check that path
Date: Fri, 26 Jan 2024 13:17:24 +0100
In-reply-to: <20240124185403.1104141-3-john.fastabend@gmail.com>
Message-ID: <87zfwse0ln.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 24, 2024 at 10:54 AM -08, John Fastabend wrote:
> Sendmsg path with multiple buffers is slightly different from a single
> send in how we have to handle and walk the sg when doing pops. Lets
> ensure this walk is correct.
>
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---
>  .../bpf/prog_tests/sockmap_helpers.h          |  8 +++
>  .../bpf/prog_tests/sockmap_msg_helpers.c      | 53 +++++++++++++++++++
>  2 files changed, 61 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
> index 781cbdf01d7b..4d8d24482032 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
> @@ -103,6 +103,14 @@
>  		__ret;                                                         \
>  	})
>  
> +#define xsendmsg(fd, msg, flags)                                               \
> +	({                                                                     \
> +		ssize_t __ret = sendmsg((fd), (msg), (flags));                 \
> +		if (__ret == -1)                                               \
> +			FAIL_ERRNO("sendmsg");                                 \
> +		__ret;                                                         \
> +	})
> +
>  #define xrecv_nonblock(fd, buf, len, flags)                                    \
>  	({                                                                     \
>  		ssize_t __ret = recv_timeout((fd), (buf), (len), (flags),      \
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c b/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c
> index 9ffe02f45808..e5e618e84950 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c
> @@ -52,6 +52,50 @@ static void pop_simple_send(struct msg_test_opts *opts, int start, int len)
>  	ASSERT_OK(cmp, "pop cmp end bytes failed");
>  }
>  
> +static void pop_complex_send(struct msg_test_opts *opts, int start, int len)
> +{
> +	struct test_sockmap_msg_helpers *skel = opts->skel;
> +	char buf[] = "abcdefghijklmnopqrstuvwxyz";
> +	size_t sent, recv, total = 0;
> +	struct msghdr msg = {0};
> +	struct iovec iov[15];
> +	char *recvbuf;
> +	int i;
> +
> +	for (i = 0; i < 15; i++) {

Always nice to use ARRAY_SIZE.

> +		iov[i].iov_base = buf;
> +		iov[i].iov_len = sizeof(buf);
> +		total += sizeof(buf);
> +	}
> +
> +	recvbuf = malloc(total);
> +	if (!recvbuf)
> +		FAIL("pop complex send malloc failure\n");

390 bytes, why not have it on stack?

> +
> +	msg.msg_iov = iov;
> +	msg.msg_iovlen = 15;
> +
> +	skel->bss->pop = true;
> +
> +	if (start == -1)
> +		start = sizeof(buf) - len - 1;
> +
> +	skel->bss->pop_start = start;
> +	skel->bss->pop_len = len;
> +
> +	sent = xsendmsg(opts->client, &msg, 0);
> +	if (sent != total)
> +		FAIL("xsend failed");
> +
> +	ASSERT_OK(skel->bss->err, "pop error");
> +
> +	recv = xrecv_nonblock(opts->server, recvbuf, total, 0);
> +	if (recv != sent - skel->bss->pop_len)
> +		FAIL("Received incorrect number number of bytes after pop");
> +
> +	free(recvbuf);
> +}
> +
>  static void test_sockmap_pop(void)
>  {
>  	struct msg_test_opts opts;
> @@ -92,6 +136,15 @@ static void test_sockmap_pop(void)
>  	/* Pop from end */
>  	pop_simple_send(&opts, POP_END, 5);
>  
> +	/* Empty pop from start of sendmsg */
> +	pop_complex_send(&opts, 0, 0);
> +	/* Pop from start of sendmsg */
> +	pop_complex_send(&opts, 0, 10);
> +	/* Pop from middle of sendmsg */
> +	pop_complex_send(&opts, 100, 10);
> +	/* Pop from end of sendmsg */
> +	pop_complex_send(&opts, 394, 10);

Isn't the start offset here past the end? 15*26=390?

> +
>  close_sockets:
>  	close(client);
>  	close(server);


