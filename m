Return-Path: <bpf+bounces-12282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DF87CA7BF
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 14:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ED04B2123D
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 12:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C4526E2B;
	Mon, 16 Oct 2023 12:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="mgT5JJOA"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27977241FF
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 12:07:24 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B15DC
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 05:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=TEnSZIvpSmwaN7cCqVlIu4FsV7ACOF+OL3jC1tuaUH0=; b=mgT5JJOALKatilAZzAvSwnGGcO
	F1fn4cXst/MP3vXLygT0dFa0Vs1EV75pevRhCX7mfEXJ3C3g7fgrH8nmZE+FXVAIPbnrIMLqoadnC
	xmYQJOxvQvBsb+PU8orK1E4xDVMTQ7D1zeMXRabULVyuFn9uVENytWZKJQ+JUHCdnha6KbG46C37K
	nyVPRrs9r5ZxRV3Bue+ue12o3pZBmk+esjDRCfTsvWxUiiXnTuSD3S4ZuFZI8g+wAUwFkQUjizKFn
	ADS1r2HhxyyNyf+J4Uz+p0FaDTAtLYrPnewuHUrL/09rnXhoP+tRzV8RgrjQZBVKR6rN+QCAxwd8D
	2mVxKTjw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qsMND-000ALG-Pl; Mon, 16 Oct 2023 14:07:03 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qsMND-000F9v-E0; Mon, 16 Oct 2023 14:07:03 +0200
Subject: Re: [PATCH v6 0/5] powerpc/bpf: use BPF prog pack allocator
To: Hari Bathini <hbathini@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Song Liu <songliubraving@fb.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
References: <20231012200310.235137-1-hbathini@linux.ibm.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <140a1e76-dfa4-d20e-fc10-09b4f3a85cb4@iogearbox.net>
Date: Mon, 16 Oct 2023 14:07:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231012200310.235137-1-hbathini@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27063/Mon Oct 16 10:02:17 2023)
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/12/23 10:03 PM, Hari Bathini wrote:
> Most BPF programs are small, but they consume a page each. For systems
> with busy traffic and many BPF programs, this may also add significant
> pressure on instruction TLB. High iTLB pressure usually slows down the
> whole system causing visible performance degradation for production
> workloads.
> 
> bpf_prog_pack, a customized allocator that packs multiple bpf programs
> into preallocated memory chunks, was proposed [1] to address it. This
> series extends this support on powerpc.
> 
> Both bpf_arch_text_copy() & bpf_arch_text_invalidate() functions,
> needed for this support depend on instruction patching in text area.
> Currently, patch_instruction() supports patching only one instruction
> at a time. The first patch introduces patch_instructions() function
> to enable patching more than one instruction at a time. This helps in
> avoiding performance degradation while JITing bpf programs.
> 
> Patches 2 & 3 implement the above mentioned arch specific functions
> using patch_instructions(). Patch 4 fixes a misnomer in bpf JITing
> code. The last patch enables the use of BPF prog pack allocator on
> powerpc and also, ensures cleanup is handled gracefully.
> 
> [1] https://lore.kernel.org/bpf/20220204185742.271030-1-song@kernel.org/
> 
> Changes in v6:
> * No changes in patches 2-5/5 except addition of Acked-by tags from Song.
> * Skipped merging code path of patch_instruction() & patch_instructions()
>    to avoid performance overhead observed on ppc32 with that.

I presume this will be routed via Michael?

Thanks,
Daniel

