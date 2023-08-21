Return-Path: <bpf+bounces-8185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F017833A2
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 22:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 673C3280E94
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 20:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B6F8F51;
	Mon, 21 Aug 2023 20:32:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8A48C0F
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 20:32:51 +0000 (UTC)
Received: from out-11.mta1.migadu.com (out-11.mta1.migadu.com [95.215.58.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DF293
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 13:32:49 -0700 (PDT)
Message-ID: <62c0e98e-6a91-ba19-e36f-dbfc122693d4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692649967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jgOhlCVf24i6v7CGhiYrie4TctVg65dLBsYKGGlj6A4=;
	b=mPvDekdiBWQc4y1SDeZWK53eYHdtvQtSkn94KvDpDUazLDsJ8u5hSNWsNI0XrMa22RSDmX
	weD2KuLUpnLj78nnS1QlEIPR913wZlMwH/NIPyD46X/J38E74Kn67/cx/6lbWJSJsLGM6A
	RISgSbJdz/4zI6JH1W/DH4SHCP3Vhcg=
Date: Mon, 21 Aug 2023 16:32:45 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 2/3] bpf: Introduce task_vma open-coded
 iterator kfuncs
To: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>,
 yonghong.song@linux.dev, sdf@google.com,
 Nathan Slingerland <slinger@meta.com>
References: <20230821173415.1970776-1-davemarchevsky@fb.com>
 <20230821173415.1970776-3-davemarchevsky@fb.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: David Marchevsky <david.marchevsky@linux.dev>
In-Reply-To: <20230821173415.1970776-3-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/21/23 1:34 PM, Dave Marchevsky wrote:
> This patch adds kfuncs bpf_iter_task_vma_{new,next,destroy} which allow
> creation and manipulation of struct bpf_iter_task_vma in open-coded
> iterator style. BPF programs can use these kfuncs directly or through
> bpf_for_each macro for natural-looking iteration of all task vmas.
> 
> The implementation borrows heavily from bpf_find_vma helper's locking -
> differing only in that it holds the mmap_read lock for all iterations
> while the helper only executes its provided callback on a maximum of 1
> vma. Aside from locking, struct vma_iterator and vma_next do all the
> heavy lifting.
> 
> The newly-added struct bpf_iter_task_vma has a name collision with a
> selftest for the seq_file task_vma iter's bpf skel, so the selftests/bpf/progs
> file is renamed in order to avoid the collision.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> Cc: Nathan Slingerland <slinger@meta.com>
> ---
>  include/uapi/linux/bpf.h                      |  4 +
>  kernel/bpf/helpers.c                          |  3 +
>  kernel/bpf/task_iter.c                        | 79 +++++++++++++++++++
>  tools/include/uapi/linux/bpf.h                |  5 ++

I forgot to update the tools bpf.h to match
new changes in this respin.
will send v3 shortly doing so

