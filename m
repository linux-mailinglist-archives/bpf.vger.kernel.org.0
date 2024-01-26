Return-Path: <bpf+bounces-20405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DB483DDA7
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 16:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933E31C215AA
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 15:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF4D1CFBC;
	Fri, 26 Jan 2024 15:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfkmBrIs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8C71CD26;
	Fri, 26 Jan 2024 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283530; cv=none; b=nvDF0M7VjAViw0Gpo6JtK4Eko8cq9YQBlA5QwDcaaap0vWPaqs1dax8TgNn6V8JPgVAPscJxeq7qyabUGemsOs9vBYAtW17QDVCH27D/uD0F/RnnwAtzfRcVxTWm5v52TqjBAM2GO2BFGiryFBBb0+rtgdygGpMApOSHODLbWKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283530; c=relaxed/simple;
	bh=4Xs8MulNUzdjgUxipKwZtjYtjrBKfmZjV12VqDliCbI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=UiJqqW2FVKiWpRItSqPg6B3D0HKsW6cbqrkUcftuHgRdb5Y45t2hwuZMsdw2v+Tm60/LU1gwYxhUSx2rHzpzy57VkP3tXSR/WNUpBJ6mk03ajI3USu0USNRPXwXCXLajRYhm2B1KeHvYkQXWuNAVXqSOgywETgkNq5r6uC7mYf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfkmBrIs; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ddce722576so422465b3a.1;
        Fri, 26 Jan 2024 07:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706283528; x=1706888328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70HA05hhM8c3qZT1O/FpkvyawRIYoLxxv+63aHCCcaA=;
        b=VfkmBrIs8+47Wcpu8jS3/zLJp67srq2O3xfqABVqpKz55NpxvM2CxQgznkR8mW366m
         ZnPi5fQYR5rJHkiBdgmrgpEiswQbuIpzilJ0e6AN+YUOJA1H4zWB60S+hL8AumB2AULu
         Aq7QfRLlWwuctwGarlYgeeP4X4MfU3rA16WeeWkOpfkRIRaVyZavITQRCwD45sQP1bGs
         igyo+SLAHdQnoJD8pkwpgJWZkw/MX8QGmNHiFf4lK8UFe+S8KVeaok6KH9E5igVtXLpU
         JkBXjWADsDBL0bBgqz2rFF649ifjjs42YnOg0WQ77by+Zwrg45/hrLK8zgRnHeiZvjBr
         limA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706283528; x=1706888328;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=70HA05hhM8c3qZT1O/FpkvyawRIYoLxxv+63aHCCcaA=;
        b=XQIFwv87yeEDKxJWZV7ThOxhhZtAyAOM8LUFoAPQKv7AaRlygqY22VfMulqz1qE4Ys
         X56YfPvz99Rp52d7D5Vn69OLsSOAz0GnDxju988BkZX9LbEV5RGlH0c6qa91zm+UAJ+P
         akjWi6ofueOCEsMUs55GfTKM+0jPVwNvH7bnkYtSvKMIB78BoHRCL3gZldVR0pwrvKQ7
         knWsLSXTvUpcVEIWjh9dNxabm93UjhNpn/AsOZ5w8U5dBub1GRpIdUBxjnHF1nfpu9ld
         m9eIHY+nfSH6vXMczJvxBm442cIfXOtTH4WCjJatAnZKzeKZL2sn5A8VxJwTzRSCP97o
         7PrA==
X-Gm-Message-State: AOJu0YxWI6w6nqUwXENFdLAwLYzuegWliGlVmPxT/waPw27uA+t9XZoU
	vo3pTzfQMS7cUftycwiZmdLPV3Rzn0Prfh4SDN4ba2OfRZbDazNFV1OclgYh
X-Google-Smtp-Source: AGHT+IFhE5mYKMCMYw6zMajProaW13U/zNP7et6FJ4UZaWK2Y5VfOpq+3mhUqZCwZNr/mashuNlIeg==
X-Received: by 2002:aa7:9f51:0:b0:6db:cace:5f60 with SMTP id h17-20020aa79f51000000b006dbcace5f60mr1080772pfr.8.1706283528429;
        Fri, 26 Jan 2024 07:38:48 -0800 (PST)
Received: from localhost ([98.97.32.4])
        by smtp.gmail.com with ESMTPSA id r18-20020aa79892000000b006ddb83e5e47sm1270646pfl.90.2024.01.26.07.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 07:38:47 -0800 (PST)
Date: Fri, 26 Jan 2024 07:38:46 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 andrii@kernel.org
Message-ID: <65b3d2066fa3a_154997208af@john.notmuch>
In-Reply-To: <87o7d8dv2f.fsf@cloudflare.com>
References: <20240124185403.1104141-1-john.fastabend@gmail.com>
 <20240124185403.1104141-4-john.fastabend@gmail.com>
 <87o7d8dv2f.fsf@cloudflare.com>
Subject: Re: [PATCH bpf-next v2 3/4] bpf: sockmap, add a cork to force
 buffering of the scatterlist
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
> > By using cork we can force multiple sends into a single scatterlist
> > and test that first the cork gives us the correct number of bytes,
> > but then also test the pop over the corked data.
> >
> > Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> > ---
> >  .../bpf/prog_tests/sockmap_msg_helpers.c      | 81 +++++++++++++++++++
> >  .../bpf/progs/test_sockmap_msg_helpers.c      |  3 +
> >  2 files changed, 84 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c b/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c
> > index e5e618e84950..8ced54fe1a0b 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c
> > @@ -21,6 +21,85 @@ struct msg_test_opts {
> >  
> >  #define POP_END -1
> >  
> > +static void cork_send(struct msg_test_opts *opts, int cork)
> > +{
> > +	struct test_sockmap_msg_helpers *skel = opts->skel;
> > +	char buf[] = "abcdefghijklmnopqrstuvwxyz";
> > +	size_t sent, total = 0, recv;
> > +	char *recvbuf;
> > +	int i;
> > +
> > +	skel->bss->pop = false;
> 
> Why reset it? Every subtest loads new program & creates new maps.

Agree I'lld elete it.

> 
> > +	skel->bss->cork = cork;
> > +
> > +	/* Send N bytes in 27B chunks */
> > +	for (i = 0; i < cork / sizeof(buf); i++) {
> > +		sent = xsend(opts->client, buf, sizeof(buf), 0);
> > +		if (sent < sizeof(buf))
> > +			FAIL("xsend failed");
> > +		total += sent;
> > +	}
> > +
> > +	recvbuf = malloc(total);
> > +	if (!recvbuf)
> > +		FAIL("cork send malloc failure\n");
> > +
> > +	ASSERT_OK(skel->bss->err, "cork error");
> > +	ASSERT_EQ(skel->bss->size, cork, "cork did not receive all bytes");
> > +
> > +	recv = xrecv_nonblock(opts->server, recvbuf, total, 0);
> > +	if (recv != total)
> > +		FAIL("Received incorrect number of bytes");
> > +
> > +	free(recvbuf);
> > +}
> 
> [...]



