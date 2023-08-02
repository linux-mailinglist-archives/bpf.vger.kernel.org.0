Return-Path: <bpf+bounces-6678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7D476C3F4
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 06:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6588B281CAE
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 04:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55177111B;
	Wed,  2 Aug 2023 04:12:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D33B15AA
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 04:12:03 +0000 (UTC)
Received: from out-102.mta1.migadu.com (out-102.mta1.migadu.com [IPv6:2001:41d0:203:375::66])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C63ED
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 21:12:02 -0700 (PDT)
Message-ID: <caec1828-7655-e8ce-7855-60ca779d7707@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690949520; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HorlZvj122iO4aO2McBzEzt24GCPX2WeR7cNzGa5WKE=;
	b=pZKnjt+Kx5ibmW4tKo23lt7WSjDAV4stgtoW+CHOQiVWSB7vduPSybGRO6nNlzKvtelmLu
	y6n1JAPbagGdmbkQp0UKpCgdM3gZb9KcsSXVo4A0aqDyao7/Zu2WG5axD4fR+pyDXRn/8t
	d0YAYDENje7BmnjMMU+PnVSQdnP4LyA=
Date: Tue, 1 Aug 2023 21:11:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH v1 bpf-next 2/7] bpf: Consider non-owning refs trusted
Content-Language: en-US
To: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20230801203630.3581291-1-davemarchevsky@fb.com>
 <20230801203630.3581291-3-davemarchevsky@fb.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230801203630.3581291-3-davemarchevsky@fb.com>
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
> Recent discussions around default kptr "trustedness" led to changes such
> as commit 6fcd486b3a0a ("bpf: Refactor RCU enforcement in the
> verifier."). One of the conclusions of those discussions, as expressed
> in code and comments in that patch, is that we'd like to move away from
> 'raw' PTR_TO_BTF_ID without some type flag or other register state
> indicating trustedness. Although PTR_TRUSTED and PTR_UNTRUSTED flags mark
> this state explicitly, the verifier currently considers trustedness
> implied by other register state. For example, owning refs to graph
> collection nodes must have a nonzero ref_obj_id, so they pass the
> is_trusted_reg check despite having no explicit PTR_{UN}TRUSTED flag.
> This patch makes trustedness of non-owning refs to graph collection
> nodes explicit as well.
> 
> By definition, non-owning refs are currently trusted. Although the ref
> has no control over pointee lifetime, due to non-owning ref clobbering
> rules (see invalidate_non_owning_refs) dereferencing a non-owning ref is
> safe in the critical section controlled by bpf_spin_lock associated with
> its owning collection.
> 
> Note that the previous statement does not hold true for nodes with shared
> ownership due to the use-after-free issue that this series is
> addressing. True shared ownership was disabled by commit 7deca5eae833
> ("bpf: Disable bpf_refcount_acquire kfunc calls until race conditions are fixed"),
> though, so the statement holds for now. Further patches in the series will change
> the trustedness state of non-owning refs before re-enabling
> bpf_refcount_acquire.
> 
> Let's add NON_OWN_REF type flag to BPF_REG_TRUSTED_MODIFIERS such that a
> non-owning ref reg state would pass is_trusted_reg check. Somewhat
> surprisingly, this doesn't result in any change to user-visible
> functionality elsewhere in the verifier: graph collection nodes are all
> marked MEM_ALLOC, which tends to be handled in separate codepaths from
> "raw" PTR_TO_BTF_ID. Regardless, let's be explicit here and document the
> current state of things before changing it elsewhere in the series.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

