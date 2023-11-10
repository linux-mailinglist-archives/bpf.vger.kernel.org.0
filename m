Return-Path: <bpf+bounces-14801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 652B17E84EA
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 22:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20161280F8D
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 21:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088953C09C;
	Fri, 10 Nov 2023 21:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HDZLBVOv"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B953588A
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 21:05:15 +0000 (UTC)
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [IPv6:2001:41d0:203:375::b3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBEA93
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 13:05:13 -0800 (PST)
Message-ID: <82346298-c730-43ff-a53f-801dc209617f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699650311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tRB3z6UhVFAlsCTwbldcgpsM1kbXiIKMUAoqj4FVuBw=;
	b=HDZLBVOvSvXTRUzbZJYlOLM7AEUfRSNz1okkcelLeqhO8Plb9Ovnv9jEycPRZGYlKvPy2y
	VpsSa5XCQ/7u30y8jBf+u0S4JIl6uBTukOj5PJRREHhqFq3DsEhd+YQOLFfpqUL1Vz1EsJ
	E3YyQ3vHzI96YclMzg3NKDqlZ9kW90M=
Date: Fri, 10 Nov 2023 13:05:07 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] bpf: Do not allocate percpu memory at init
 stage
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20231110172050.2235758-1-yonghong.song@linux.dev>
 <CAADnVQJ2b8UNmzOLAQQbZXxanyPDSd7uv+j=xdh=g9pQCzKi5Q@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJ2b8UNmzOLAQQbZXxanyPDSd7uv+j=xdh=g9pQCzKi5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 11/10/23 12:32 PM, Alexei Starovoitov wrote:
> On Fri, Nov 10, 2023 at 9:23 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> +                               if (meta.func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
>> +                                       if (!bpf_global_percpu_ma_set) {
>> +                                               mutex_lock(&bpf_verifier_lock);
>> +                                               if (!bpf_global_percpu_ma_set) {
>> +                                                       err = bpf_mem_alloc_init(&bpf_global_percpu_ma, 0, true);
>> +                                                       if (!err)
>> +                                                               bpf_global_percpu_ma_set = true;
>> +                                               }
>> +                                               mutex_unlock(&bpf_verifier_lock);
> I feel we're taking unnecessary risk here by reusing the mutex.
> bpf_obj_new kfunc is a privileged operation and the verifier lock
> is not held in such scenario, so it won't deadlock,

That is true. deadlock situation won't happen.

> but let's just add another mutex to protect percpu_ma init.
> Much easier to reason about.

Okay. will do.


