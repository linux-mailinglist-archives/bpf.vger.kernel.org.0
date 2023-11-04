Return-Path: <bpf+bounces-14200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 494E67E0D7B
	for <lists+bpf@lfdr.de>; Sat,  4 Nov 2023 04:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8285B2154F
	for <lists+bpf@lfdr.de>; Sat,  4 Nov 2023 03:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAC23D86;
	Sat,  4 Nov 2023 03:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FO101Qmw"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95C11FA2;
	Sat,  4 Nov 2023 03:27:35 +0000 (UTC)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FC2D52;
	Fri,  3 Nov 2023 20:27:34 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a8ee23f043so31944777b3.3;
        Fri, 03 Nov 2023 20:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699068453; x=1699673253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t79ed9XiwZXOp7boVVPg4vgfuU9CmNpE6nf+tVDfWaQ=;
        b=FO101QmwHNxiv7lwn2LEzIQ+/Q4d9dzgmVknAWb2xDCRY2B7MXzqjf2XlqDvZtUSwP
         BPrehLgzE5UUhKgw/TuHuf6gBslciDLG6mAGsKf4EaIiLex+pnrg0TsG/+LGKorGbBCx
         mVMp/3PVvjioHRFaTrM2HaIWfUB6jZKYwwAiYBttrnmVp4Z/c71USoykNNzDGuP4uP1V
         I3F+2F4jTSVVT74Z6J6Hh1/ygRPuSVBzxAPp8dTbWv/TnS+dqWzPbY5kq38tZaFPlX39
         6zRHzKfJGy7zcEfeL5KLuji4v8Rkj/q33yCjc+ZogygO2DclbyBLUD5LkbnKxpMC9Xm1
         nImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699068453; x=1699673253;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t79ed9XiwZXOp7boVVPg4vgfuU9CmNpE6nf+tVDfWaQ=;
        b=D9/HkJVk3yB5AdA5CMzu5mRNu9seAsEQ3kj7Qb4lCTn+Mh0ddVqasqWnqlVewGn5eC
         FCKeY/4mLI27yzM+mnQWGHD9dCsEo2/MQAghkKkOzVbHLfXnLoQqc8GM7Y6bJRah28+y
         J0WtoZ0AF5h3O/z8ZwiIW8MFmTHxZxxJLN7+nQzlUl7nITA+ovyS++qcaqDmwKx+6cH1
         TVhhmv8AK0Xg1rIhYU/TU/K6s2cJ48CWDgCbuGdIoz7XYyWn+I0lWRxSztrJfmv0waP4
         1/OYbFXzCgb794wMkWLdk6y49hIyvChyUBc2I3ZqWzDzK74cMUHPHi0VamORGBE7092N
         /1Vw==
X-Gm-Message-State: AOJu0YzTWKsJg898yCF5JNsrZhBeBzjemKkt9l+GrbKWECheH8GZWcSH
	KwbCnN4uj4Im6BPWN3UqVZNJ1PNdfQA=
X-Google-Smtp-Source: AGHT+IGaX7bqRigDq3EZfKlYiUcGdiX6gT86FtQRsGyd7YZBrAWoo+nh1+Y2wcQDlKUzDdC/4kT97g==
X-Received: by 2002:a05:690c:f13:b0:5a7:be8c:e85 with SMTP id dc19-20020a05690c0f1300b005a7be8c0e85mr6078489ywb.24.1699068452844;
        Fri, 03 Nov 2023 20:27:32 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba00::41f])
        by smtp.gmail.com with ESMTPSA id h10-20020a62b40a000000b006bf536bcd23sm2047971pfn.161.2023.11.03.20.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 20:27:32 -0700 (PDT)
Date: Fri, 03 Nov 2023 20:27:30 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, 
 Liu Jian <liujian56@huawei.com>
Cc: john.fastabend@gmail.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 kpsingh@kernel.org, 
 sdf@google.com, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 netdev@vger.kernel.org, 
 bpf@vger.kernel.org
Message-ID: <6545ba22b3cfa_3358c20839@john.notmuch>
In-Reply-To: <87bkcg1nk2.fsf@cloudflare.com>
References: <20231028100552.2444158-1-liujian56@huawei.com>
 <87bkcg1nk2.fsf@cloudflare.com>
Subject: Re: [PATCH bpf-next v7 0/7] add BPF_F_PERMANENT flag for sockmap
 skmsg redirect
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
> On Sat, Oct 28, 2023 at 06:05 PM +08, Liu Jian wrote:
> > v6->v7: Rebase to latest bpf-next tree, and no changes.
> > v5->v6: Modified the description of the helper function.
> > v4->v5: Fix one refcount bug caused by patch1.
> > v3->v4: Change the two helpers's description.
> > 	Let BPF_F_PERMANENT takes precedence over apply/cork_bytes.
> >
> > Liu Jian (7):
> >   bpf, sockmap: add BPF_F_PERMANENT flag for skmsg redirect
> >   selftests/bpf: Add txmsg permanently test for sockmap
> >   selftests/bpf: Add txmsg redir permanently test for sockmap
> >   selftests/bpf: add skmsg verdict tests
> >   selftests/bpf: add two skmsg verdict tests for BPF_F_PERMANENT flag
> >   selftests/bpf: add tests for verdict skmsg to itself
> >   selftests/bpf: add tests for verdict skmsg to closed socket
> >
> >  include/linux/skmsg.h                         |   1 +
> >  include/uapi/linux/bpf.h                      |  45 +++++--
> >  net/core/skmsg.c                              |   6 +-
> >  net/core/sock_map.c                           |   4 +-
> >  net/ipv4/tcp_bpf.c                            |  12 +-
> >  tools/include/uapi/linux/bpf.h                |  45 +++++--
> >  .../selftests/bpf/prog_tests/sockmap_basic.c  | 122 ++++++++++++++++++
> >  .../selftests/bpf/progs/test_sockmap_kern.h   |   3 +-
> >  .../bpf/progs/test_sockmap_msg_verdict.c      |  25 ++++
> >  tools/testing/selftests/bpf/test_sockmap.c    |  41 +++++-
> >  10 files changed, 272 insertions(+), 32 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_msg_verdict.c
> 
> I gave it one last look. For the series:
> 
> Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

Ah I assumed the reviewed-bys were just carried through. So one more time,

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

