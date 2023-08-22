Return-Path: <bpf+bounces-8205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 327E478379C
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 03:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36ED31C20992
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 01:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA761110A;
	Tue, 22 Aug 2023 01:52:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3A610E9
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 01:52:26 +0000 (UTC)
Received: from out-21.mta0.migadu.com (out-21.mta0.migadu.com [IPv6:2001:41d0:1004:224b::15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64345180
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 18:52:24 -0700 (PDT)
Message-ID: <c01a78b3-cd40-bcc6-ae61-7bafb311d176@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692669142; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W+7geR9faTXwI//5v0n93GZduGiW6PpI2LTtkFuke9c=;
	b=s5VI+71jqefi+6TkX7HogtU5dK08a218yl0eFfv1N3ScTVvO1XNqyAbr8KiUhNvuqzNY5g
	GEvkwxOUj5ksCk07RPB8xv+KOECahOuXZtyrJ2Yqp1slfzLEb/UhP74WuyC++cfFLqNQLy
	HEPDj0xmYyyjlatA5yYJFLaty+ff2OE=
Date: Mon, 21 Aug 2023 18:52:18 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH v2 bpf-next 1/7] bpf: Ensure kptr_struct_meta is non-NULL
 for collection insert and refcount_acquire
Content-Language: en-US
To: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20230821193311.3290257-1-davemarchevsky@fb.com>
 <20230821193311.3290257-2-davemarchevsky@fb.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230821193311.3290257-2-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/21/23 12:33 PM, Dave Marchevsky wrote:
> It's straightforward to prove that kptr_struct_meta must be non-NULL for
> any valid call to these kfuncs:
> 
>    * btf_parse_struct_metas in btf.c creates a btf_struct_meta for any
>      struct in user BTF with a special field (e.g. bpf_refcount,
>      {rb,list}_node). These are stored in that BTF's struct_meta_tab.
> 
>    * __process_kf_arg_ptr_to_graph_node in verifier.c ensures that nodes
>      have {rb,list}_node field and that it's at the correct offset.
>      Similarly, check_kfunc_args ensures bpf_refcount field existence for
>      node param to bpf_refcount_acquire.
> 
>    * So a btf_struct_meta must have been created for the struct type of
>      node param to these kfuncs
> 
>    * That BTF and its struct_meta_tab are guaranteed to still be around.
>      Any arbitrary {rb,list} node the BPF program interacts with either:
>      came from bpf_obj_new or a collection removal kfunc in the same
>      program, in which case the BTF is associated with the program and
>      still around; or came from bpf_kptr_xchg, in which case the BTF was
>      associated with the map and is still around
> 
> Instead of silently continuing with NULL struct_meta, which caused
> confusing bugs such as those addressed by commit 2140a6e3422d ("bpf: Set
> kptr_struct_meta for node param to list and rbtree insert funcs"), let's
> error out. Then, at runtime, we can confidently say that the
> implementations of these kfuncs were given a non-NULL kptr_struct_meta,
> meaning that special-field-specific functionality like
> bpf_obj_free_fields and the bpf_obj_drop change introduced later in this
> series are guaranteed to execute.
> 
> This patch doesn't change functionality, just makes it easier to reason
> about existing functionality.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

