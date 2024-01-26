Return-Path: <bpf+bounces-20404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C7783DDA4
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 16:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AE771C2128C
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 15:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3098F1CFBE;
	Fri, 26 Jan 2024 15:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUQK90cY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C101CF9A;
	Fri, 26 Jan 2024 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283510; cv=none; b=tepfsjN1BcRAewRX3BS/ipH53es3eggFgTyrBoUhCZmhvzHYhg6sJ/7reXm+Aiw1EL4Z94GrX945OO0slgsDcqcLgYEAKa4OXFEhzMM+kWRtLWM2PeiOIzRjXSEtu0P7goaIzLZulTn3lga/u2+KNbhJVuvBhG/3lLGMTpCBxr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283510; c=relaxed/simple;
	bh=/htQK2IItKAYhqbyJxrA0hGtb13N20ZyoEK7ARlWJZ8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=LYWGp2Ne+KPzwFWCd0ZyffOQAPOYXvsmVoxx4R7m7sdlJVYv011LBS7dEirxbUfZrn0MJibmckn20KT4fjzDL4kwku2Hkj83LCkK0j9J1So7pXfQuCow51xmhh09IVfKWEYIJ+w+HftfGdFN4ckNbGjVuqjkj27sO1qFJHZtmkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUQK90cY; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ddcfbc5a5fso565587b3a.2;
        Fri, 26 Jan 2024 07:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706283508; x=1706888308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o1+6GcJFuulMAZyHkYh17hR/uxi03PofWm5VKEHq4Zw=;
        b=ZUQK90cYxA/v7/gNBnD3TuyQaDDCGXyIdvrUatc42wPAHK5lAJiLoXFR3KMOslzwCh
         oQttddrUT20xXuqhsC0/qX121Boguhva64K+nN7y9B3mSWeNAAPkS4JqC5S7hHlFeFFX
         AsPz+0rqCfJbGOGDsntwCplfaILX3Frbr4syjmZ+gTzY9eR8ZRt/BgSAW0Y6JxERQ3AA
         tRKHqta9inUIzqDNo0/5r/xdx5wv4nHtyXjhKnRF3W7ehLuSDunGOJpNKYaMwYG8H404
         a3CVE1aU8me0zZ/r9E+kjwqE/2SAHTpjzKZNXZrl8bFj5pcSM0AZV3MwlcaIpMgWlCN1
         Gvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706283508; x=1706888308;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o1+6GcJFuulMAZyHkYh17hR/uxi03PofWm5VKEHq4Zw=;
        b=vmEIpFJ8cmzJFk2ZgQT218olEoD/zf7xCGVkcJ7oLrhcNyoQn+WvYsA+fUoexgRGwH
         Fr2k1C7wTncLRQJqxQX7kv5LhujB2giaiDSYBZsEBQt0ODehxeo39TCieaUq03iJoJ/e
         OpPpJ7GIHFb4BZFOEdXM8sfd3m+2SxWYH0kUoxcdo9DtyCw8JL4dmSrWGGd9xFfBwm9w
         G6YgRw82b/LKDmhuNeSMEhZ8WZGhm3HkCNGnimgVWJCYYZcVM+sU1t6UIUYuZgCDL8KW
         sNJdSmh/wfur26vHJTTjZ6GjuzLy10LRUcH7S8JVnkV/DqdHSlsSFL52t6lVSLqX+hVe
         CxRg==
X-Gm-Message-State: AOJu0YyibWg82iJIvbQPt4wWt2Oi6u88JxTpyZuWA/Ldw1YnRVY6Sx+o
	WAkFaatP9uFcPrH83jyzfsr4ZkQIMw+vMZ3bYQPI/bzctj59mRPh
X-Google-Smtp-Source: AGHT+IEozVSoX7Bz/uN/tMsSwMuNRu8jxrBXWL/rk0HUG7glpQniL/3luc/oPGHRNY1ndLZaPWneMQ==
X-Received: by 2002:a62:ab0e:0:b0:6dd:a1de:b19d with SMTP id p14-20020a62ab0e000000b006dda1deb19dmr1429043pff.54.1706283508636;
        Fri, 26 Jan 2024 07:38:28 -0800 (PST)
Received: from localhost ([98.97.32.4])
        by smtp.gmail.com with ESMTPSA id p17-20020a056a0026d100b006d9accac5c4sm1239349pfw.35.2024.01.26.07.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 07:38:27 -0800 (PST)
Date: Fri, 26 Jan 2024 07:38:26 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 andrii@kernel.org
Message-ID: <65b3d1f2d5333_154997208d0@john.notmuch>
In-Reply-To: <87zfwse0ln.fsf@cloudflare.com>
References: <20240124185403.1104141-1-john.fastabend@gmail.com>
 <20240124185403.1104141-3-john.fastabend@gmail.com>
 <87zfwse0ln.fsf@cloudflare.com>
Subject: Re: [PATCH bpf-next v2 2/4] bpf: sockmap, add a sendmsg test so we
 can check that path
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Sitnicki wrote:
> On Wed, Jan 24, 2024 at 10:54 AM -08, John Fastabend wrote:
> > Sendmsg path with multiple buffers is slightly different from a single
> > send in how we have to handle and walk the sg when doing pops. Lets
> > ensure this walk is correct.
> >
> > Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> > ---
> >  .../bpf/prog_tests/sockmap_helpers.h          |  8 +++
> >  .../bpf/prog_tests/sockmap_msg_helpers.c      | 53 +++++++++++++++++++
> >  2 files changed, 61 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
> > index 781cbdf01d7b..4d8d24482032 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
> > +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
> > @@ -103,6 +103,14 @@
> >  		__ret;                                                         \
> >  	})
> >  
> > +#define xsendmsg(fd, msg, flags)                                               \
> > +	({                                                                     \
> > +		ssize_t __ret = sendmsg((fd), (msg), (flags));                 \
> > +		if (__ret == -1)                                               \
> > +			FAIL_ERRNO("sendmsg");                                 \
> > +		__ret;                                                         \
> > +	})
> > +
> >  #define xrecv_nonblock(fd, buf, len, flags)                                    \
> >  	({                                                                     \
> >  		ssize_t __ret = recv_timeout((fd), (buf), (len), (flags),      \
> > diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c b/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c
> > index 9ffe02f45808..e5e618e84950 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c
> > @@ -52,6 +52,50 @@ static void pop_simple_send(struct msg_test_opts *opts, int start, int len)
> >  	ASSERT_OK(cmp, "pop cmp end bytes failed");
> >  }
> >  
> > +static void pop_complex_send(struct msg_test_opts *opts, int start, int len)
> > +{
> > +	struct test_sockmap_msg_helpers *skel = opts->skel;
> > +	char buf[] = "abcdefghijklmnopqrstuvwxyz";
> > +	size_t sent, recv, total = 0;
> > +	struct msghdr msg = {0};
> > +	struct iovec iov[15];
> > +	char *recvbuf;
> > +	int i;
> > +
> > +	for (i = 0; i < 15; i++) {
> 
> Always nice to use ARRAY_SIZE.

Agree will do.

> 
> > +		iov[i].iov_base = buf;
> > +		iov[i].iov_len = sizeof(buf);
> > +		total += sizeof(buf);
> > +	}
> > +
> > +	recvbuf = malloc(total);
> > +	if (!recvbuf)
> > +		FAIL("pop complex send malloc failure\n");
> 
> 390 bytes, why not have it on stack?

Sure one less thing that could fail seems like a win.

