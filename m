Return-Path: <bpf+bounces-6761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F26F76D9F9
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 23:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221BB281E02
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 21:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FCC134B7;
	Wed,  2 Aug 2023 21:51:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E7610973
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 21:51:50 +0000 (UTC)
Received: from out-79.mta0.migadu.com (out-79.mta0.migadu.com [91.218.175.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A47173A
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 14:51:48 -0700 (PDT)
Message-ID: <efcd5b6e-d1a5-b63c-897f-411dccb4baae@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691013106; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mGFfLF0IaEmc6OPARonSKrF8hHFm/P2KwED6bkFETHM=;
	b=gPvyYuDiGT14noB/bkYIq35kIoYk79kJm07rYgLVKpL1m+tatT0vIt7yv4vgEO3j/uOiEg
	lk/Yf4LadwE+q1rhecj1V7M45Yygq7oxFqX2NXvHScuwdVATzVVNRhpcike2kpA8gLHqBb
	tetJS4tiaIDqC2Tex/R065NIpkDdIiU=
Date: Wed, 2 Aug 2023 14:51:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH v3 bpf-next 1/2] bpf: Fix uninitialized symbol in
 bpf_perf_link_fill_kprobe()
Content-Language: en-US
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
References: <20230731111313.3745-1-laoar.shao@gmail.com>
 <20230731111313.3745-2-laoar.shao@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230731111313.3745-2-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/31/23 4:13 AM, Yafang Shao wrote:
> The patch 1b715e1b0ec5: "bpf: Support ->fill_link_info for
> perf_event" from Jul 9, 2023, leads to the following Smatch static
> checker warning:
> 
>      kernel/bpf/syscall.c:3416 bpf_perf_link_fill_kprobe()
>      error: uninitialized symbol 'type'.
> 
> That can happens when uname is NULL. So fix it by verifying the uname
> when we really need to fill it.
> 
> Fixes: 1b715e1b0ec5 ("bpf: Support ->fill_link_info for perf_event")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/bpf/85697a7e-f897-4f74-8b43-82721bebc462@kili.mountain/
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

