Return-Path: <bpf+bounces-11827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5470A7C03A5
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 20:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DE60281D9C
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 18:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F225E2FE00;
	Tue, 10 Oct 2023 18:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B3i5x7lV"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D9B28F0
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 18:44:44 +0000 (UTC)
X-Greylist: delayed 327 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 10 Oct 2023 11:44:43 PDT
Received: from out-203.mta0.migadu.com (out-203.mta0.migadu.com [IPv6:2001:41d0:1004:224b::cb])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084E794
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 11:44:42 -0700 (PDT)
Message-ID: <0722d3e1-7f89-439a-ac31-d310fd25e30b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1696963137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HEaCWeyqDKuRaA1kPL00CPfpmGiW4R63Bp8dk759zks=;
	b=B3i5x7lVxgrYwJazEePyYyCqwI/Qmfa3NhqHsv2EOErsvXdO1NmUOCdOZL/m6iWToZbp9+
	6+Vr+Izl28N98xWZ3BHPkDK1vPbrjPbDm1Irfvwd7we6dC9I6aFnaoe/Jar0xVGJ2Nwzvh
	tIFQpFgh11UuCaOzDp2uJr/jSA7oGG4=
Date: Tue, 10 Oct 2023 14:38:51 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 bpf-next 4/4] selftests/bpf: Add tests for open-coded
 task_vma iter
Content-Language: en-US
To: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20231010175637.3405682-1-davemarchevsky@fb.com>
 <20231010175637.3405682-5-davemarchevsky@fb.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: David Marchevsky <david.marchevsky@linux.dev>
In-Reply-To: <20231010175637.3405682-5-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 10/10/23 1:56 PM, Dave Marchevsky wrote:
> The open-coded task_vma iter added earlier in this series allows for
> natural iteration over a task's vmas using existing open-coded iter
> infrastructure, specifically bpf_for_each.
> 
> This patch adds a test demonstrating this pattern and validating
> correctness. The vma->vm_start and vma->vm_end addresses of the first
> 1000 vmas are recorded and compared to /proc/PID/maps output. As
> expected, both see the same vmas and addresses - with the exception of
> the [vsyscall] vma - which is explained in a comment in the prog_tests
> program.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---

BPF CI is unhappy as it's unable to apply this patch.
Likely because I manually deleted an extraneous empty line
in the .patch file.

Will respin as v6 shortly.

