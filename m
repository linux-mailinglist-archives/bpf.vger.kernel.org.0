Return-Path: <bpf+bounces-18830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A0F8225B4
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 00:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57D928485C
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 23:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CEB17993;
	Tue,  2 Jan 2024 23:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXohY6k4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0FC17984;
	Tue,  2 Jan 2024 23:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-203fe0e3fefso5234539fac.2;
        Tue, 02 Jan 2024 15:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704239358; x=1704844158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HtFes5HAvMdaJ6n//9Br1YRErPp3U5BQyMtnxEhHE+4=;
        b=EXohY6k4gLY0aZa5ImR+kcJLUc5plt4CiCpYocSA+PATq2Uc1ee16+C/T6TwfTeuWc
         UUAeqpG/omTo34p293UiC87yg77yqRFzUKGUdDXifUzZB3JkFbn5lrGiIko2pfSTl2CU
         Rj8o+3fc67nXclbdtePeLuZ+Xmt1kBp4bvnnNJVBWM662A4mRKZr8+kjg67gt/6UCiyd
         X/VIWM9OWT1mpwzKokPWkXPABVTEB+EwqXT46QGYpRbAHDu2VLL8Ujmhyt5AXIgk/mVM
         FNLL67rtlhKPqz4ywvTWzjti8hZJfGceFiq635lnIa08mYvDlDFZh4to4yUZ/C0Euqeh
         tu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704239358; x=1704844158;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HtFes5HAvMdaJ6n//9Br1YRErPp3U5BQyMtnxEhHE+4=;
        b=M1+gg1qR0tw6zhHFepSKX6AH7qKVwtkreO9pAZac5aPOAKTiiXAQiy8NCFn0OVinTz
         SlRYmMF2LmNeW6Sj9gimhnI+tZYNUdSP7fML3V9b4EtRtEMgf344a9VIVxOeX89oa5c5
         Uq9XC9iEyXReE+ZnqrXAPB0RezLTQLJ4g/PL2bcsYceR4IP0OmFtVIxRWNbhZsIKTBer
         6+CJHzgbgKoxiYjMFMNiMpu6jOwBYNhkc0bBrcGEIuhng6bzpYoS6/Nw7h0dE1bHUh21
         HI995sQESmSTqBpg+ZDuZzFtBwrtESe3xPmrz6Lb9nd/Dq+/ioxgYYdY4tMTDuGh0pNw
         eN1w==
X-Gm-Message-State: AOJu0YyaGKCDtMvGA2KzFb2GS/6gZIINkIR/mDn4UeBryYimI46plkhs
	NdJzZfYnoJbJi/n/WaSIIFA=
X-Google-Smtp-Source: AGHT+IF8usf/RRhsvY273ldoB6IOYFkvLihPJ2DOiZrbb7qU+MpgVmIKqjlHe90Y5LoYPVELGuEuEQ==
X-Received: by 2002:a05:6871:713:b0:204:23fc:8a73 with SMTP id f19-20020a056871071300b0020423fc8a73mr15697181oap.21.1704239357983;
        Tue, 02 Jan 2024 15:49:17 -0800 (PST)
Received: from localhost ([98.97.37.198])
        by smtp.gmail.com with ESMTPSA id s16-20020a63f050000000b005b7dd356f75sm21407203pgj.32.2024.01.02.15.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 15:49:17 -0800 (PST)
Date: Tue, 02 Jan 2024 15:49:16 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: rivendell7@gmail.com, 
 kuniyu@amazon.com, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org
Message-ID: <6594a0fc51d1d_11e86208c3@john.notmuch>
In-Reply-To: <87v88bvk0a.fsf@cloudflare.com>
References: <20231221232327.43678-1-john.fastabend@gmail.com>
 <87v88bvk0a.fsf@cloudflare.com>
Subject: Re: [PATCH bpf 0/5] fix sockmap + stream  af_unix memleak
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
> On Thu, Dec 21, 2023 at 03:23 PM -08, John Fastabend wrote:
> > There was a memleak when streaming af_unix sockets were inserted into
> > multiple sockmap slots and/or maps. This is because each insert would
> > call a proto update operatino and these must be allowed to be called
> > multiple times. The streaming af_unix implementation recently added
> > a refcnt to handle a use after free issue, however it introduced a
> > memleak when inserted into multiple maps.
> >
> > This series fixes the memleak, adds a note in the code so we remember
> > that proto updates need to support this. And then we add three tests
> > for each of the slightly different iterations of adding sockets into
> > multiple maps. I kept them as 3 independent test cases here. I have
> > some slight preference for this they could however be a single test,
> > but then you don't get to run them independently which was sort of
> > useful while debugging.
> >
> > John Fastabend (5):
> >   bpf: sockmap, fix proto update hook to avoid dup calls
> >   bpf: sockmap, added comments describing update proto rules
> >   bpf: sockmap, add tests for proto updates many to single map
> >   bpf: sockmap, add tests for proto updates single socket to many map
> >   bpf: sockmap, add tests for proto updates replace socket
> >
> >  include/linux/skmsg.h                         |   5 +
> >  net/unix/unix_bpf.c                           |  21 +-
> >  .../selftests/bpf/prog_tests/sockmap_basic.c  | 199 +++++++++++++++++-
> >  3 files changed, 221 insertions(+), 4 deletions(-)
> 
> Sorry for the delay. I was out.

Thanks for the review.

> 
> This LGTM with some room for improvement in tests.
> You repeat the code to create different kind of sockets in each test.
> That could be refactored to use some kind of a factory helper.

Yeah, my first attempt was uglier than the repeated setup in my
opinion. So figured I would get this out and think a bit more
about it. Lets see if BPF maintainers want me to fix the typo
on Reported-by or if it can be fixed on merged.

> 
> Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>



