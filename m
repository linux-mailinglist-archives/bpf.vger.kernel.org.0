Return-Path: <bpf+bounces-6679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD5D76C402
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 06:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAC33281C74
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 04:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B343315AC;
	Wed,  2 Aug 2023 04:15:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772E9110C
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 04:15:45 +0000 (UTC)
Received: from out-83.mta1.migadu.com (out-83.mta1.migadu.com [IPv6:2001:41d0:203:375::53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3441704
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 21:15:44 -0700 (PDT)
Message-ID: <cfea5339-2c1d-7dba-15ed-984ffdca4817@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690949742; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WVo00ivED8om/Zq1phKlUBQZeDCiTWzOZgjIhZJLXw0=;
	b=UCaMOvQtDnPSZMA3avmU9iwS8YIU/yLyg660wtTykhLJTgL67Nf8nz2yTKaksJLEfiOrKS
	3UciSvZvm1AaUKFdAlCm4U7Di+YQxoA+pXHn96ve0jOx4HZIudGwlfbUK6q4Jks5kiTh5n
	qX8Nbg3tDED+SVGhPfRu53J3Grq8cTc=
Date: Tue, 1 Aug 2023 21:15:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH v1 bpf-next 3/7] bpf: Use bpf_mem_free_rcu when
 bpf_obj_dropping refcounted nodes
Content-Language: en-US
To: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20230801203630.3581291-1-davemarchevsky@fb.com>
 <20230801203630.3581291-4-davemarchevsky@fb.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230801203630.3581291-4-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/1/23 1:36 PM, Dave Marchevsky wrote:
> This is the final fix for the use-after-free scenario described in
> commit 7793fc3babe9 ("bpf: Make bpf_refcount_acquire fallible for
> non-owning refs"). That commit, by virtue of changing
> bpf_refcount_acquire's refcount_inc to a refcount_inc_not_zero, fixed
> the "refcount incr on 0" splat. The not_zero check in
> refcount_inc_not_zero, though, still occurs on memory that could have
> been free'd and reused, so the commit didn't properly fix the root
> cause.
> 
> This patch actually fixes the issue by free'ing using the recently-added
> bpf_mem_free_rcu, which ensures that the memory is not reused until
> RCU Tasks Trace grace period has elapsed. If that has happened then
> there are no non-owning references alive that point to the
> recently-free'd memory, so it can be safely reused.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

