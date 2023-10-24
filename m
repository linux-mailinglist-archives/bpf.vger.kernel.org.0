Return-Path: <bpf+bounces-13173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD507D5D8E
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 23:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C8801F22A72
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 21:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58D72D622;
	Tue, 24 Oct 2023 21:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfkeT6ll"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA212D609;
	Tue, 24 Oct 2023 21:56:02 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C586D7A;
	Tue, 24 Oct 2023 14:56:01 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6b87c1edfd5so3969004b3a.1;
        Tue, 24 Oct 2023 14:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698184561; x=1698789361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmI65534lvEYQw2UdDDyS9MxagfzkhI02azyml1WT/8=;
        b=nfkeT6llKewAZjU+MffGxyH4fLhhuO5rcpRcp0BZ9qN516STNmMdrUAArN5nc+lBTO
         c09p9PYGZCxBJ39y1NcbaNKRtbq92prVkQLHalCLcQGKZFRyoNfg8h1xv0+QCrghSyNo
         HeKpmFvhqUb5j8Qjrf+Al3CYIzKJhuV7JYj05YoiIIjZUcPr60kF16bSZxUnJytVAfpW
         Gm1NbsNXXEGlMTkeJwVG7W7TNEKi1lwSQ6zSqFBdknvfdzNd5uKGs6SxwBfPQBCn5/lw
         iqpLpClk01iR3FdUnusbgdKZovttJBOHpoJkfnFiYk4k4HI9IbMwV1A08O0irjAcZFwa
         uSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698184561; x=1698789361;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YmI65534lvEYQw2UdDDyS9MxagfzkhI02azyml1WT/8=;
        b=QKzCahDyirPnbpQvkbjIQGu390VJuM1s0knfA0aqZY1KUO+PagNwSYSkbEomCnhuDU
         aIpnM5XQrqRv0lYMD8HF93N0QIAS2ND94WJFVQraDZYvkhFbU6K2KKzVIIcqqcvdR6Nv
         5e6I4eXmmcaE5gIIdBwla6fhPv0+RbutIeASkE4pJBJl1F+gbTWR2zsNqIA6jWqekv22
         /WIlR9y/3ZKJQtIBXXoCgL/uexkzY8y8u4miTJIPiCaSBQjI8fMHacMxPIiTGaqvFojG
         j2+IxM27Ht8zrUI1zfQ/TkfUAA0ny1PjGpH2M6W5ukyS8bItPa8y5Y7wnRsX53rgIoA9
         EG+Q==
X-Gm-Message-State: AOJu0YzwLrzmv6WtKsXt9MgOkIvYTgw9EKZGwb6NT/oHHxiq54ddLl86
	wUBivNi2vnEFUb9c7iw2sJo=
X-Google-Smtp-Source: AGHT+IHuemq57B0X5vjPxlWkHrC96EJOJxzsv9YgPIgu8ureXOWgKVg9JOlGBjmMJ+u2sLxcg6065g==
X-Received: by 2002:a05:6a20:54a7:b0:15e:2d9f:cae0 with SMTP id i39-20020a056a2054a700b0015e2d9fcae0mr4516529pzk.10.1698184560960;
        Tue, 24 Oct 2023 14:56:00 -0700 (PDT)
Received: from localhost ([98.97.36.36])
        by smtp.gmail.com with ESMTPSA id v10-20020a63480a000000b0058ee60f8e4dsm7620724pga.34.2023.10.24.14.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:56:00 -0700 (PDT)
Date: Tue, 24 Oct 2023 14:55:59 -0700
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
Message-ID: <65383d6f3d15c_1969a2084a@john.notmuch>
In-Reply-To: <20231014121706.967988-1-liujian56@huawei.com>
References: <20231014121706.967988-1-liujian56@huawei.com>
Subject: RE: [PATCH bpf-next v6 0/7] add BPF_F_PERMANENT flag for sockmap
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

Liu Jian wrote:
> v5->v6: Modified the description of the helper function.
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

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

