Return-Path: <bpf+bounces-61884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B7FAEE6F7
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 20:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3357A1BC1FEC
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 18:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DAC2E62AB;
	Mon, 30 Jun 2025 18:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MA11ONWX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F3B286D7C;
	Mon, 30 Jun 2025 18:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751309275; cv=none; b=WlwA7kjZkio00dwfel3zDECKQ52DrXr8gOIX9t7K2t6sJiW9zdik2ulgQq2WZ0Q/Pyo3DT2y1i9jfzwTCe/KrYxP0VcD9KrG/Gdy4i4QLgfsVwS+g61OjNEcdOs5RlXr8RBDnOut3XZ6KnrnQXqz8pY1tKHzhT9M+4rIHW+Y06k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751309275; c=relaxed/simple;
	bh=ZFzT65FWxKa2J63Qje6deVGpZ+AcnaU3MpY7P3kPK/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htRQxe6diLhaLMo8ZaFU/zbn7W06V7yM/vNf1BQuCUZuNcPC8FG09vCNJj919NNzp4r559RtYMO6PuK9ugqVG1r8pi0Vh5rtwDpPfNU4D5oiFk6TqbzcgMvsGA9eWdFNdYphx3bvHqaay1YoZI8+ctwB+pPHFmIEjbQv0xbnYjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MA11ONWX; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-313910f392dso1739945a91.2;
        Mon, 30 Jun 2025 11:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751309273; x=1751914073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xh+upEPAJaXpVzUzxZqLUIW+lz2TINd7A0/KzA6yE4c=;
        b=MA11ONWXeN66fPWAvKW3OAKk+6tDMXkGbb4+kQFhhlBBGfsDF3/wI5maX0HvlFERmk
         X0eXkRAPVTQtA0/bdCsVMjU/3IHx0f592ZLXtcQJLoapjnBAF5JeYEIhBaKYMPqxsPlr
         4ap5EWNMT2UD/zoZxRykea65GJPv0dqEXV7l9eXvbvUquIZxeoDBBDwZMPJzJnU6xgcf
         9IQNjmbJCh/IIws4BMCjKKt76hc0/VmEBpjcabnixtWe1mH/JlmUPd+QA8qYIp9/5xZh
         wWGSVojWHkn2ufQ6fZiW7UTXzWnalXTAj7ZbhwAiKcYEJX7ZrU3LCPG1AGd59xO+l3dg
         7YRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751309273; x=1751914073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xh+upEPAJaXpVzUzxZqLUIW+lz2TINd7A0/KzA6yE4c=;
        b=E+5g69FvFF7BGQZU+6WBhqYUdv5+7TAQ/L6K0tQvATejTcGbn+1CUgfQTwkfTEd/Ty
         yJDMJSIX6heVGCXzxDmyX8/bGpWbj0D6AEFE7bwWdmDUJbI5uJWQQjKSch9wc984LdyG
         OQF6YtaU7O995eymJrtz9PZZmdU+qatt4myfoxILt4C/rpXRVjolgDnfTFGJQIuRp8sZ
         No05JvP/3TZbZfG5VFwI/fLMF6SWHxL1Cstnzv8off321smz1aFHtBDnpXtZ3CBvN0QQ
         oMVsIDKfl9Braki9d6Ksun/13HSwWT2vq/lixbV9g+bAj4H9+YIXDy5AsIyq1sMbW0Zz
         FwSQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0uH+89AeJY1bMF5pluzW9UN68Ktkhxoj+6N3m9e8qTn7WRzHyK8dNRYIw9dlsf6ANR1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzWn4mnXmPsslzkIxNVOR51hPaXNoQwKpP3Qa/yY9SndKsqWrR
	6uvycf023jyIg16fE2RCwZcinOo5kJRy2V3w7CzanvvVdIPflbSxDrc=
X-Gm-Gg: ASbGnct2m17PMnGUS1H8Dj/V4/As1vGgHcUgCQZHB1RrHVGoH7oGWh0BXAaks6eP6zG
	bakRC5YZ63tZCn20bZcIokVtjH8RiVcu+v5GRXVDOzqrTF6Uo4Cdfe6oz2PiPBarvT4BF7GlAzC
	zkneDc0qS8stzUNHwaHC4dIbrwACaJD27OlFeehXFlUgVKlrDRa0R8yjKkPnFFSlj84QGQO8/9W
	5BcyNXfbe3Q+i8k4hxQxyQP7WhgVS1jWa7VKjhjv825uFcwfvSNE/Jsh6TIKMbZIlHjtXy8wgT8
	gaSZ9o4lTfleVwf5NBkhbLGl+FxgvPOH/SDr9EUX8slNgIguOKsU79Bcgz2VdhbSndzVG9uaZeb
	5bAHtgol3V65tongYwcuuMes=
X-Google-Smtp-Source: AGHT+IFWhqTRubsuaqa3yAKXn3VbTJLXUGSY+1/XbR1Kv/h3wzx2x7U7W0GHv/UiqleRQfj5lPyI0w==
X-Received: by 2002:a17:90b:184f:b0:311:ea13:2e63 with SMTP id 98e67ed59e1d1-318c9225ebfmr20321463a91.13.1751309273166;
        Mon, 30 Jun 2025 11:47:53 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-318c13a15c2sm9414422a91.12.2025.06.30.11.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 11:47:52 -0700 (PDT)
Date: Mon, 30 Jun 2025 11:47:51 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jordan Rife <jordan@jrife.io>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v3 bpf-next 10/12] selftests/bpf: Create established
 sockets in socket iterator tests
Message-ID: <aGLb1ytEc0vi0ndw@mini-arch>
References: <20250630171709.113813-1-jordan@jrife.io>
 <20250630171709.113813-11-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250630171709.113813-11-jordan@jrife.io>

On 06/30, Jordan Rife wrote:
> Prepare for bucket resume tests for established TCP sockets by creating
> established sockets. Collect socket fds from connect() and accept()
> sides and pass them to test cases.
> 
> Signed-off-by: Jordan Rife <jordan@jrife.io>
> ---
>  .../bpf/prog_tests/sock_iter_batch.c          | 83 ++++++++++++++++++-
>  1 file changed, 79 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
> index 4c145c5415f1..2b0504cb127b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
> @@ -153,8 +153,66 @@ static void check_n_were_seen_once(int *fds, int fds_len, int n,
>  	ASSERT_EQ(seen_once, n, "seen_once");
>  }
>  
> +static int accept_from_one(int *server_fds, int server_fds_len)
> +{
> +	int i = 0;
> +	int fd;
> +

[..]

> +	for (; i < server_fds_len; i++) {

nit: move i=0 here?

