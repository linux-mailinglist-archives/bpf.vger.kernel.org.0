Return-Path: <bpf+bounces-14947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0197E923E
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 20:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08745B207CF
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 19:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EFD171B2;
	Sun, 12 Nov 2023 19:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e9ESkDmW"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B62168C0
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 19:23:58 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833CB1BEC
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 11:23:57 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5c19a2f606dso136105a12.3
        for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 11:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699817037; x=1700421837; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VpS28gNyhEcEF+l4H+O7recBzFF+ICo3HBZBdeqTo1k=;
        b=e9ESkDmW6GVcZrYeb9tB8C3ojGkmfLZfpWf/dQS5d8NWslMscjKE6fJypIdEG8Tjcj
         ugzFOnW6KpAcP3JBb4U/HOZ/W01eHptkI5VNUoWJpjSxJT9CoS9T0Vu88JBhMZAITQ8f
         1dsxOVpMBq0RihNSvcyOmA4zlJOg7m/bMvRAe0pA1+2dt9ucyZjTZWvXIGqdplhfTETH
         RsRHTYqCQJJRhMgQ3ghyyTj4YQdtknZkNcyCWdqUtIJPEOMzB5nJTSolKAVILiW36nPS
         mlKT4G+VYha3s3+5/3Hb6JlB/NFBIerr4LXJZvzBv5RTaa960rEew00d7/jNLxRI+diW
         arDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699817037; x=1700421837;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VpS28gNyhEcEF+l4H+O7recBzFF+ICo3HBZBdeqTo1k=;
        b=L0/QCucDZXNysLbTxFc4MIArZsJ9cagc78jw2vI+saIJ1BbPuFShm9Q+RRrTdi+9vI
         nSkSJxYxSz13ZX7JkVy/Kg3Y1BGJwECYbjIGVFED3th/DaJsWttILaBquNwNHolbDcgj
         LAPxRzRyEyPPU8YVALInXBfjTl1tHYrQQU0w57eEC4MHLOR5LTkKqFSmFQE8F1XnZ+Sx
         tBpf7+FJh1j0SZu82JqUdG2jDhFqZEL7PxepfLe+zeekd2dGRwsiXqG0qALQegQ1m6bq
         bBYQl9XTs5vMPCoIFcoTTaWwfhFGs6g3ZlIG3N0M4dBrNe1WxJhrVEy/T14fo7r89a4v
         N0Rg==
X-Gm-Message-State: AOJu0YwSSVeUnRoC7EgllnUOtbP8TWAouc7qC+cgN6g65Tl+sHcMYbAJ
	Tbglsk/DKXAZH9msUz03+tqHD28=
X-Google-Smtp-Source: AGHT+IEPVeM5eLf0Uz/WEEYeIGwUuu7OR1uO6SMlAPsWLvlChThBVcI0aancW9MtINOS1hr0t9rUyYk=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:45:0:b0:5bd:9c1e:c557 with SMTP id
 66-20020a630045000000b005bd9c1ec557mr1299616pga.3.1699817036971; Sun, 12 Nov
 2023 11:23:56 -0800 (PST)
Date: Sun, 12 Nov 2023 11:23:55 -0800
In-Reply-To: <20231111043821.2258513-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231111043821.2258513-1-houtao@huaweicloud.com>
Message-ID: <ZVEmS3Eu3Dd4BZBe@google.com>
Subject: Re: [PATCH bpf] bpf: Add missed allocation hint for bpf_mem_cache_alloc_flags()
From: Stanislav Fomichev <sdf@google.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
Content-Type: text/plain; charset="utf-8"

On 11/11, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> bpf_mem_cache_alloc_flags() may call __alloc() directly when there is no
> free object in free list, but it doesn't initialize the allocation hint
> for the returned pointer. It may lead to bad memory dereference when
> freeing the pointer, so fix it by initializing the allocation hint.
> 
> Fixes: 822fb26bdb55 ("bpf: Add a hint to allocated objects.")
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Makes sense from briefly looking at the code. But I'll defer to Alexei
on this one. There is also __alloc call from alloc_bulk and I can't
quickly grasp why you're fixing this single place only.

