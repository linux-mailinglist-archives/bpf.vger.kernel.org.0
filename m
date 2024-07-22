Return-Path: <bpf+bounces-35262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1469993942F
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 21:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E0B1C21752
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 19:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D795017107B;
	Mon, 22 Jul 2024 19:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="UeTXJxIB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDF91BF54
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 19:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676409; cv=none; b=Vfm5IzbxEePfUIcj6kwnYOdEjzL5O5QHqIz6b71FdysyYVyfiXoco3rPFNo0+gnxLL/iCmIZDluCBRPD/+4RWOZNvORhRbQy0HXTr3Jv1DM+foxziZQiAvy60VuubMdNDDCIWrJ/LU4mMCKVJs+9GipfUQq30pn60wLARvLsyOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676409; c=relaxed/simple;
	bh=RC16Xj2GExN2UNH5sQwynzelC+AZm0hY/uBKoz/E/dQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VIFqV3E9rdTDQEnenef8TVTTYcgdbZTuB+PJ8vtI2+JSYq9UY1z9kkK4xJnpBywVp5BAolSuCq4lNdHTd7q1gCk8aq970Ftw6mCj9/hE0wF9CoQy2dF3i8UrghMHMiSIXXm+50ud318JKHDD5n9aoQSOikVX+Z7EDj/sxtdsMSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=UeTXJxIB; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a1337cfbb5so4422545a12.3
        for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 12:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1721676405; x=1722281205; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kegZFA65qLO4AJ+rLRcibC4hYdIssGNELpKKk1lmIOA=;
        b=UeTXJxIBhUKO5qeNdT48Zn9FWkT8mwnzutwicxUesSYtdj8w70gawdlJ5EGjc3/lkI
         LIHLNkkNZNIo9Aujb1wLOQR5F3mXT6/e5+B0tlpMkUx/N6jyWa21ib/rYHnZQCf4EUVh
         LZewe7Xcf+ojSO+tgdUNZO+TfvE0LAHj0C2CZYHZRT/TK55X0CDxLPn2OLXn4ZQru+qN
         iJE1LbLYswOukq2qvio7LfwA9YRufno9jgGBvB26CJAb24XN2PJ2Vp1r9IIuz9l6d+WF
         bnzA+nRBuDg8mFwjhjBuFD3iy6kzlRmgLqS+PyISS07Grq1h+Y9EddsidXuqtURehFXo
         85ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721676405; x=1722281205;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kegZFA65qLO4AJ+rLRcibC4hYdIssGNELpKKk1lmIOA=;
        b=P+QcHKznIB5VhZdONZ6WGazZE+ttGV0gQmreBFudYOZLAfmQzprWEzom0BhjMuzEgv
         bKhDyNNrv/l94XEqPZ7CRZeX0m5jsj4Q2AegbgYWQ2TmT7kZ56wP7wvadfwMNMlICzVo
         fVl8gYnnL4XYw6ts50W3SG/nAQVBQALzeWLjqBE+B+7sqw8RYZGs+V1a83t0X9fGLBPY
         dibXQyJspB19wonu8VhmySlgjuk1xXh+S4FjHpM/H0keFDDUeARTJUb83RVduVF9Cfc0
         /orPt5PR4dEoP15rORh9FeCBfkOCfWb+tOtyIgbyyUlOpuKmtfmgCnE3UF3HG92djVmL
         a95w==
X-Forwarded-Encrypted: i=1; AJvYcCUuuyE6uqF1XIfQK0M45z/QaZ0fdRp1llRnB9j4he1s8bwhPlXPhDSzn6Jp7a1BlFcSQjBTKyWRyEEC0SdBNJ4N31Yo
X-Gm-Message-State: AOJu0YyaVdOeZ1lgCVtK+eujqpXNVVdN9xWWnlwKfcBgDd6PYvnffhKx
	XuP/5dJ5zTUcSXOEgWapPl1cApQ97fJqHroE0047PX7baVvBPOaJNB4ltZddF04=
X-Google-Smtp-Source: AGHT+IFk08DF4nk6DApKnGf17haGiFMZZBC4ibQa7ps0oo5s2Aos6W12At7KcyB+FATmOyLLcvmLJA==
X-Received: by 2002:a05:6402:34c8:b0:59e:b95d:e769 with SMTP id 4fb4d7f45d1cf-5a941d254b0mr760623a12.5.1721676405318;
        Mon, 22 Jul 2024 12:26:45 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:4c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a59be83c69sm3126637a12.58.2024.07.22.12.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 12:26:44 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org,  bpf@vger.kernel.org,  davem@davemloft.net,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  john.fastabend@gmail.com,  kuniyu@amazon.com,  Rao.Shoaib@oracle.com,
  cong.wang@bytedance.com, Andrii Nakryiko <andrii@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>
Subject: Re: [PATCH bpf v3 2/4] selftest/bpf: Support SOCK_STREAM in
 unix_inet_redir_to_connected()
In-Reply-To: <027fdb41-ee11-4be0-a493-22f28a1abd7c@rbox.co> (Michal Luczaj's
	message of "Mon, 22 Jul 2024 15:07:28 +0200")
References: <20240707222842.4119416-1-mhal@rbox.co>
	<20240707222842.4119416-3-mhal@rbox.co>
	<87zfqqnbex.fsf@cloudflare.com>
	<fb95824c-6068-47f2-b9eb-894ea9182ede@rbox.co>
	<87ikx962wm.fsf@cloudflare.com>
	<2eae7943-38d7-4839-ae72-97f9a3123c8a@rbox.co>
	<87sew57i4v.fsf@cloudflare.com>
	<027fdb41-ee11-4be0-a493-22f28a1abd7c@rbox.co>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Mon, 22 Jul 2024 21:26:43 +0200
Message-ID: <87ed7lcjnw.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jul 22, 2024 at 03:07 PM +02, Michal Luczaj wrote:
> On 7/19/24 13:09, Jakub Sitnicki wrote:
>> On Wed, Jul 17, 2024 at 10:15 PM +02, Michal Luczaj wrote:
>>> On 7/13/24 11:45, Jakub Sitnicki wrote:
>>>> On Thu, Jul 11, 2024 at 10:33 PM +02, Michal Luczaj wrote:
>>>>> And looking at that commit[1], inet_unix_redir_to_connected() has its
>>>>> @type ignored, too.  Same treatment?
>>>>
>>>> That one will not be a trivial fix like this case. inet_socketpair()
>>>> won't work for TCP as is. It will fail trying to connect() a listening
>>>> socket (p0). I recall now that we are in this state due to some
>>>> abandoned work that began in 75e0e27db6cf ("selftest/bpf: Change udp to
>>>> inet in some function names").
>>>> [...]
>>>
>>> Is this what you've meant? With this patch inet_socketpair() and
>>> vsock_socketpair_connectible can be reduced to a single call to
>>> create_pair(). And pairs creation in inet_unix_redir_to_connected()
>>> and unix_inet_redir_to_connected() accepts both sotypes.
>> 
>> Yes, exactly. This looks great.
>
> Happy to hear that. I'll prepare a series, include the little fixes and
> send it out for a proper review.
>
> One more thing: I've noticed changes in sockmap_helpers.h don't trigger
> test_progs rebuild (seems to be the case for all .h in prog_tests/). No
> idea if this is the right approach, but adding
> "$(TRUNNER_TESTS_DIR)/sockmap_helpers.h" to TRUNNER_EXTRA_SOURCES in
> selftests/bpf/Makefile does the trick.

CC'ed BPF selftests reviewers in case they'd like to chip in.

>
>> Classic cleanup with goto to close sockets is all right, but if you're
>> feeling brave and aim for something less branchy, I've noticed we have
>> finally started using __attribute__((cleanup)):
>> 
>> https://elixir.bootlin.com/linux/v6.10/source/tools/testing/selftests/bpf/progs/iters.c#L115
>
> I've tried. Is such "ownership passing" (to inhibit the cleanup) via
> construct like take_fd()[1] welcomed?

I'm fine with having such a helper to complement the cleanup attribute.
Alternatively, we can always open code it like it used to be in systemd
at first [1], if other reviewers don't warm up to it :-)

[1] https://github.com/systemd/systemd/blob/main/coccinelle/take-fd.cocci


>
> [1] https://lore.kernel.org/all/20240627-work-pidfs-v1-1-7e9ab6cc3bb1@kernel.org/
>
> static inline void close_fd(int *fd)
> {
> 	if (*fd >= 0)
> 		xclose(*fd);
> }
>
> #define __closefd __attribute__((cleanup(close_fd)))
>
> static inline int create_pair(int family, int sotype, int *c, int *p)
> {
> 	struct sockaddr_storage addr;
> 	socklen_t len = sizeof(addr);
> 	int err;
>
> 	int s __closefd = socket_loopback(family, sotype);
> 	if (s < 0)
> 		return s;
>
> 	err = xgetsockname(s, sockaddr(&addr), &len);
> 	if (err)
> 		return err;
>
> 	int s0 __closefd = xsocket(family, sotype, 0);

I'd stick to no declarations in the body. Init to -1 or -EBADF.

> 	if (s0 < 0)
> 		return s0;
>
> 	err = connect(s0, sockaddr(&addr), len);
> 	if (err) {
> 		if (errno != EINPROGRESS) {
> 			FAIL_ERRNO("connect");
> 			return err;
> 		}
>
> 		err = poll_connect(s0, IO_TIMEOUT_SEC);
> 		if (err) {
> 			FAIL_ERRNO("poll_connect");
> 			return err;
> 		}
> 	}
>
> 	switch (sotype & SOCK_TYPE_MASK) {
> 	case SOCK_DGRAM:
> 		err = xgetsockname(s0, sockaddr(&addr), &len);
> 		if (err)
> 			return err;
>
> 		err = xconnect(s, sockaddr(&addr), len);
> 		if (err)
> 			return err;
>
> 		*p = take_fd(s);
> 		break;
> 	case SOCK_STREAM:
> 	case SOCK_SEQPACKET:
> 		*p = xaccept_nonblock(s, NULL, NULL);

I wouldn't touch output arguments until we have succedeed.  Another
local var will be handy.

> 		if (*p < 0)
> 			return *p;
> 		break;
> 	default:
> 		FAIL("Unsupported socket type %#x", sotype);
> 		return -EOPNOTSUPP;
> 	}
>
> 	*c = take_fd(s0);
> 	return err;
> }

