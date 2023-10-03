Return-Path: <bpf+bounces-11243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 336647B5FE7
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 06:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 3305828199E
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 04:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B57111A;
	Tue,  3 Oct 2023 04:31:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0A1A3C;
	Tue,  3 Oct 2023 04:31:08 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF446A9;
	Mon,  2 Oct 2023 21:31:07 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-692ada71d79so354750b3a.1;
        Mon, 02 Oct 2023 21:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696307467; x=1696912267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqqnrUoFn52+99WXD4BZwoyg7h4jOwIHHPpjV7FQK48=;
        b=auXPAhACIwKSA1l3BLgmNSg4DF0+lorzgt4Xy/DFOEIaRSljuNoli2U0Ddg6+KHbI6
         X0RY+AsMmalxhcY6UNYPmsQcXUmS0PrumZtVjwjKRIfX4LTYNYu5skK3o+YdbBfLi7UF
         39TsOkPUYkex8z7B3a0dkobwFigo+hXYkmJjettbjYNtf/CQXVnaZFwg38sS1pxNhkOF
         fAZ9jQH1PczVQwuUZoEt4eODnree9IJCil6e2pJen/quTALr/rrHvuv4JSfHf4p+4OcI
         owgCr6xy4x3rn4TEc+9RZeVFVbiKif2l+1WPBJOIuSwHTifTH60sH5NYEvUA5qYSU5yQ
         eWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696307467; x=1696912267;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QqqnrUoFn52+99WXD4BZwoyg7h4jOwIHHPpjV7FQK48=;
        b=f0hAoXGJDMcgMd28idzFCZWIafXQK0EVl2ZzrZBgy8a+cAhOZUw3JZM0I0fVUOGkeW
         NN1AP6ZkxuzqQEWF0NgV9bXAy+vYcZ7ESCcJINZCkDrJHCUYoqLSfzzTSCjqbcRZ7ycV
         YH18MuWhYac+zdD4MRt1QTCaPPUnlEV3H5ajpWvWG3vhKIT/szJewUjXxMmS1SAcOsC9
         NV4M6acQG1XL/JMjXGQ55LuPCY0FShhgm2QFRiwlqunqwPfZhTy4Lqoy1Cyplz2szNtA
         b5kW+tPcZ72eilaR4CzBwZWNUbMw1ruT8gFmthiKOHjzytOraUfOw3M7lQFzsPHZJkkw
         gMDg==
X-Gm-Message-State: AOJu0YwhLnEE1+/o+qWWL3a/ab1DFyjlXl/1z3qwEpZqFISSh0p73T6y
	RuXkCJE8eCjUTUITGgl+4EUONqGhs9Skdw==
X-Google-Smtp-Source: AGHT+IG6y3d2eMa0Uw1nE7sDh0XVXdD8e9Zz6lJaGEea+J/OOlIwMlBJA8pTv+xtNl7TvSCgyJg5eg==
X-Received: by 2002:aa7:88cb:0:b0:68f:f6dd:e78b with SMTP id k11-20020aa788cb000000b0068ff6dde78bmr13080608pff.17.1696307467213;
        Mon, 02 Oct 2023 21:31:07 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba00:2a00:5720:bdb8:2705])
        by smtp.gmail.com with ESMTPSA id bm2-20020a056a00320200b00690ca4356f1sm319900pfb.198.2023.10.02.21.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 21:31:06 -0700 (PDT)
Date: Mon, 02 Oct 2023 21:31:00 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Liu Jian <liujian56@huawei.com>, 
 john.fastabend@gmail.com, 
 jakub@cloudflare.com, 
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
 dsahern@kernel.org
Cc: netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 liujian56@huawei.com
Message-ID: <651b9904e54cc_4fa3f208c3@john.notmuch>
In-Reply-To: <20230927093013.1951659-1-liujian56@huawei.com>
References: <20230927093013.1951659-1-liujian56@huawei.com>
Subject: RE: [PATCH bpf-next v5 0/7] add BPF_F_PERMANENT flag for sockmap
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Liu Jian wrote:
> v4->v5: Fix one refcount bug caused by patch1.
> v3->v4: Change the two helpers's description.
> 	Let BPF_F_PERMANENT takes precedence over apply/cork_bytes.
> 
> Liu Jian (7):
>   bpf, sockmap: add BPF_F_PERMANENT flag for skmsg redirect
>   selftests/bpf: Add txmsg permanently test for sockmap
>   selftests/bpf: Add txmsg redir permanently test for sockmap
>   selftests/bpf: add skmsg verdict tests
>   selftests/bpf: add two skmsg verdict tests for BPF_F_PERMANENT flag
>   selftests/bpf: add tests for verdict skmsg to itself
>   selftests/bpf: add tests for verdict skmsg to closed socket
> 
>  include/linux/skmsg.h                         |   1 +
>  include/uapi/linux/bpf.h                      |  45 +++++--
>  net/core/skmsg.c                              |   6 +-
>  net/core/sock_map.c                           |   4 +-
>  net/ipv4/tcp_bpf.c                            |  12 +-
>  tools/include/uapi/linux/bpf.h                |  45 +++++--
>  .../selftests/bpf/prog_tests/sockmap_basic.c  | 122 ++++++++++++++++++
>  .../selftests/bpf/progs/test_sockmap_kern.h   |   3 +-
>  .../bpf/progs/test_sockmap_msg_verdict.c      |  25 ++++
>  tools/testing/selftests/bpf/test_sockmap.c    |  41 +++++-
>  10 files changed, 272 insertions(+), 32 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_msg_verdict.c
> 
> -- 
> 2.34.1
> 

Thanks! Tests LGTM one question below on API being reset on errors.

