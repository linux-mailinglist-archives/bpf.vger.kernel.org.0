Return-Path: <bpf+bounces-6680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3A376C4C5
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 07:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11B39281BD3
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 05:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106D215BA;
	Wed,  2 Aug 2023 05:21:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08D715AA
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 05:21:49 +0000 (UTC)
Received: from out-80.mta0.migadu.com (out-80.mta0.migadu.com [91.218.175.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78202C6
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 22:21:47 -0700 (PDT)
Message-ID: <d2a091bd-6b35-893e-2c6e-d637d994952c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690953705; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ff2+YBs2cqxBACHTB8juD0XjltmMelHd0+MpUzXKEoA=;
	b=CgC9R8AjATsGRvMk58Qlrj1MLDSNHnL4moedgTHVwMl81Rgeg/8SU3F6nZpn7OtWrAXs/S
	QHg7bkwv29e8Ofq+83pRX1CL8jMUo2xS8i9e/opTdQw0lvmizt4TFqzkR0ZtfULgeIMwKt
	PGCpqzq6l/u7XqrxodDsDM820C5FCPU=
Date: Tue, 1 Aug 2023 22:21:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH v1 bpf-next 4/7] bpf: Reenable bpf_refcount_acquire
Content-Language: en-US
To: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20230801203630.3581291-1-davemarchevsky@fb.com>
 <20230801203630.3581291-5-davemarchevsky@fb.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230801203630.3581291-5-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/1/23 1:36 PM, Dave Marchevsky wrote:
> Now that all reported issues are fixed, bpf_refcount_acquire can be
> turned back on. Also reenable all bpf_refcount-related tests which were
> disabled.
> 
> This a revert of:
>   * commit f3514a5d6740 ("selftests/bpf: Disable newly-added 'owner' field test until refcount re-enabled")
>   * commit 7deca5eae833 ("bpf: Disable bpf_refcount_acquire kfunc calls until race conditions are fixed")
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

