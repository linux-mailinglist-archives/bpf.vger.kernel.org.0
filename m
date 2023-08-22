Return-Path: <bpf+bounces-8203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C58783751
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 03:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 615951C20A06
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 01:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B325F10FA;
	Tue, 22 Aug 2023 01:21:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F19910E9
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 01:21:33 +0000 (UTC)
Received: from out-1.mta1.migadu.com (out-1.mta1.migadu.com [IPv6:2001:41d0:203:375::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF44A13E
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 18:21:31 -0700 (PDT)
Message-ID: <9a8b83da-cc31-eb91-9953-8705d1f74272@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692667290; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ij+SBWjEWd50++qqIL4Sg1fZ3lepqMxmirUbsHi3WH8=;
	b=lzou/vYxD4LyeFi5rgOkEjENYyBZpmggsmZMou1mbqkw9kaekUC1sCd8rgtSGiyqRLe15a
	A69VBtg2pdgA3jX7K3Z4o93Y9u9CYOQoyFCkHjp6HBykt6cgroos94NyExnfrCuQ9bFv02
	zlrIsMJGL2Nw79ZqCMgpL/LOR46nFIE=
Date: Mon, 21 Aug 2023 18:21:22 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH v2 bpf-next 1/3] bpf: Don't explicitly emit BTF for struct
 btf_iter_num
Content-Language: en-US
To: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>,
 sdf@google.com
References: <20230821173415.1970776-1-davemarchevsky@fb.com>
 <20230821173415.1970776-2-davemarchevsky@fb.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230821173415.1970776-2-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/21/23 10:34 AM, Dave Marchevsky wrote:
> Commit 6018e1f407cc ("bpf: implement numbers iterator") added the
> BTF_TYPE_EMIT line that this patch is modifying. The struct btf_iter_num
> doesn't exist, so only a forward declaration is emitted in BTF:
> 
>    FWD 'btf_iter_num' fwd_kind=struct
> 
> That commit was probably hoping to ensure that struct bpf_iter_num is
> emitted in vmlinux BTF. A previous version of this patch changed the
> line to emit the correct type, but Yonghong confirmed that it would
> definitely be emitted regardless in [0], so this patch simply removes
> the line.
> 
> This isn't marked "Fixes" because the extraneous btf_iter_num FWD wasn't
> causing any issues that I noticed, aside from mild confusion when I
> looked through the code.
> 
>    [0]: https://lore.kernel.org/bpf/25d08207-43e6-36a8-5e0f-47a913d4cda5@linux.dev/
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

