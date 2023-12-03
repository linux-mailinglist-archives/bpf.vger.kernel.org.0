Return-Path: <bpf+bounces-16546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 879DC802664
	for <lists+bpf@lfdr.de>; Sun,  3 Dec 2023 19:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F20C1C20963
	for <lists+bpf@lfdr.de>; Sun,  3 Dec 2023 18:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044281798F;
	Sun,  3 Dec 2023 18:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjEGhIFb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACEFDA
	for <bpf@vger.kernel.org>; Sun,  3 Dec 2023 10:54:48 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-35d4fb17c68so18842615ab.1
        for <bpf@vger.kernel.org>; Sun, 03 Dec 2023 10:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701629688; x=1702234488; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KZw9hAdYVPBddfgnZXd6Nh3yi00a9wAOEXbMaa7Jkbg=;
        b=cjEGhIFbQAyqHNC6hIALq7oJFxBzQLcX2ngNvdNohm7xKoIjgESWV0gfKELxzcMb/0
         1aCsbGHDQgKwIchMEQDYHPg46nak04bWX9fJjY8kZQGDwapSjlqW5cZJ4Vao78cIDhSA
         suAC7MqmxnHUEytl91foWZQs3EAWhiFl5XQHh9wVWH6n2nVesl/qoLND0dXoS9eywPrC
         HZlkqhJrUJU9fWO4Z/uqa2laAe8Rr3f1ksFxDxvUr/hHflMuT8tA06h2jDC8K0v6udjf
         8xsoZLKNCPFkw/9y1P19a19qNVbzOapUTC83ruSu+Qt6fSugl/Q9z6v4EQFCloHu4uDx
         8dew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701629688; x=1702234488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZw9hAdYVPBddfgnZXd6Nh3yi00a9wAOEXbMaa7Jkbg=;
        b=iyEbwzeeY06X+ym845LyBWpGQgq6L0ZZkaX95QAFBFi3ky4UOKVpnREI53Rc7DPGV7
         uCzhZTt2oNo1y8sYxlUx2s+dkto/ti2xYdiiuMwykYkFf1UNCr4OXV5jgQM8ameucEcc
         SzKkDSax/DAGw4RSkvI9fhN/vTa08DISoGPQmFOkj/JZno9ZNS8f9LLMo2wDQHUO4EID
         6XYv5MV5AN70WzX7ro4Z98g9toWMS1HLkH8Ql7OGagU1E6QswBFDyokevWyNCMXUrx1T
         /tzMrC6fZwQiXt8ZvZs7NgFBdEZa13s+tbAvNzr2BYSz1VK3pFNtU5Lx6uKqDU5yBD5Y
         yrpw==
X-Gm-Message-State: AOJu0YwkU06ot5VVQt3pTVdTGFOKQcwre4xDQyoS1GadY49W+TPL/3Mf
	6HP2J/zvdc3STjs3pOPYWfA=
X-Google-Smtp-Source: AGHT+IE2V+VCBKKavx3T/hMBmVQ2/wUigy7hG+mPiAEYRc2QNpaLxgeNR1QFi1J2AqRUvasTj/dobw==
X-Received: by 2002:a05:6e02:c63:b0:35d:6737:fb67 with SMTP id f3-20020a056e020c6300b0035d6737fb67mr2136100ilj.121.1701629687892;
        Sun, 03 Dec 2023 10:54:47 -0800 (PST)
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::4:e741])
        by smtp.gmail.com with ESMTPSA id c8-20020a17090ad90800b0028686583ed1sm1890896pjv.5.2023.12.03.10.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 10:54:47 -0800 (PST)
Date: Sun, 3 Dec 2023 10:54:44 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>, houtao1@huawei.com
Subject: Re: [PATCH bpf v4 5/7] bpf: Optimize the free of inner map
Message-ID: <20231203185444.l3bip4fwfbqqn5oz@macbook-pro-49.dhcp.thefacebook.com>
References: <20231130140120.1736235-1-houtao@huaweicloud.com>
 <20231130140120.1736235-6-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130140120.1736235-6-houtao@huaweicloud.com>

On Thu, Nov 30, 2023 at 10:01:18PM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> When removing the inner map from the outer map, the inner map will be
> freed after one RCU grace period and one RCU tasks trace grace
> period, so it is certain that the bpf program, which may access the
> inner map, has exited before the inner map is freed.
> 
> However there is no need to wait for one RCU tasks trace grace period if
> the outer map is only accessed by non-sleepable program. So adding
> sleepable_refcnt in bpf_map and increasing sleepable_refcnt when adding
> the outer map into env->used_maps for sleepable program. Considering the
> max number of bpf program is INT_MAX - 1, atomic_t instead of atomic64_t
> is used for sleepable_refcnt. When removing the inner map from the outer
> map, using sleepable_refcnt to decide whether or not a RCU tasks trace
> grace period is needed before freeing the inner map.

Optimizing too soon as usual?
I bet you saw that we use:
 atomic64_t refcnt
for bpf_map, but you probably didn't dig into git history and
missed commit 92117d8443bc ("bpf: fix refcnt overflow") ?


