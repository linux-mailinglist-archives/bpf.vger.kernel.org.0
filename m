Return-Path: <bpf+bounces-10181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 316EB7A272A
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 21:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC8A8281800
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 19:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9755319BB2;
	Fri, 15 Sep 2023 19:27:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423FD1094C
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 19:27:06 +0000 (UTC)
Received: from out-213.mta0.migadu.com (out-213.mta0.migadu.com [91.218.175.213])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3564E50
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 12:27:05 -0700 (PDT)
Message-ID: <a967ddd5-9b6d-df17-cef4-0baeb0d9252e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1694806024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=alWL3GHrQxakFacxE4oyxz8hAneeAlgh8UAl0NR/+y0=;
	b=kr8idsAdVaY/Q1Gf1ctsFqEMe0gkbyhtTN26W4rx7pupcNoQSVyRZRZfLLNadgwIa5N511
	x3DP9git8cdWpBxJtDig8cqjlWZFhrZnvi4DXadNBkA1wB8amBsqEindfUgdL+XiIrkl9i
	0RiCWrrLevdtYtFb8FlQNO36Rudk3Ro=
Date: Fri, 15 Sep 2023 12:26:34 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] bpf: Allow to use kfunc XDP hints and frags
 together
Content-Language: en-US
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org
References: <20230915083914.65538-1-larysa.zaremba@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230915083914.65538-1-larysa.zaremba@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/15/23 1:39 AM, Larysa Zaremba wrote:
> There is no fundamental reason, why multi-buffer XDP and XDP kfunc RX hints
> cannot coexist in a single program.
> 
> Allow those features to be used together by modifying the flags condition
> for dev-bound-only programs, segments are still prohibited for fully
> offloaded programs, hence additional check.

Applied. Please do follow up with a test. Thanks.


