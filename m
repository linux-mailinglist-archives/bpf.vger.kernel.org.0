Return-Path: <bpf+bounces-10151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B46A37A232A
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 18:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AE201C20F8C
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 16:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACF011CB1;
	Fri, 15 Sep 2023 16:02:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7155B30CE6
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 16:02:28 +0000 (UTC)
Received: from out-221.mta1.migadu.com (out-221.mta1.migadu.com [95.215.58.221])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F454E78
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 09:02:26 -0700 (PDT)
Message-ID: <01584fd4-6f51-ebae-f8a2-d05965d7c075@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1694793744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I9qXWq2VqDh/JyDDgSP3lQaC0VvRZrcllxmErlIgMnc=;
	b=HTg/hEg/h7LxM8YCq0jj3yKXDIjygCJyqc0f7ZZbMdTcDu9n1wP1epm0B/Fw7WuqVteqcT
	GW5fJVKH2UsZaWosogQ3bV2HkISkA5DiChnkpZYj9GGWytqGw6K8NPdpKYNrrJaRoBZ1Zs
	HexQfWqJVBtKMfbhiVyk5L5Ga6hW6AA=
Date: Fri, 15 Sep 2023 09:02:18 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Syzkaller & bisect] There is general protection fault in
 bpf_prog_offload_verifier_prep in v6.6-rc1 kernel
Content-Language: en-US
To: Pengfei Xu <pengfei.xu@intel.com>
Cc: bpf@vger.kernel.org, heng.su@intel.com, lkp@intel.com, sdf@google.com
References: <ZQPTq8LBmwsz4PGg@xpf.sh.intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <ZQPTq8LBmwsz4PGg@xpf.sh.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/14/23 8:46 PM, Pengfei Xu wrote:
> Hi Stanislav,
> 
> Greeting!
> 
> There is general protection fault in bpf_prog_offload_verifier_prep in
> v6.6-rc1 kernel.
> 
> All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/230914_154711_bpf_prog_offload_verifier_prep
> Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230914_154711_bpf_prog_offload_verifier_prep/repro.c
> Syzkaller reproduced steps: https://github.com/xupengfe/syzkaller_logs/blob/main/230914_154711_bpf_prog_offload_verifier_prep/repro.prog
> Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230914_154711_bpf_prog_offload_verifier_prep/bisect_info.log
> Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/230914_154711_bpf_prog_offload_verifier_prep/0bb80ecc33a8fb5a682236443c1e740d5c917d1d_dmesg.log
> bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/230914_154711_bpf_prog_offload_verifier_prep/bzImage_0bb80ecc33a8fb5a682236443c1e740d5c917d1d.tar.gz
> Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230914_154711_bpf_prog_offload_verifier_prep/kconfig_origin
> 
> Bisected and found suspected commit is:
> 2b3486bc2d23 bpf: Introduce device-bound XDP programs

Thanks for the report.

It has just been fixed in the following commit in the bpf tree:

commit 1a49f4195d3498fe458a7f5ff7ec5385da70d92e
Author: Eduard Zingerman <eddyz87@gmail.com>
Date:   Mon Sep 11 17:55:37 2023

     bpf: Avoid dummy bpf_offload_netdev in __bpf_prog_dev_bound_init

     Fix for a bug observable under the following sequence of events:
     1. Create a network device that does not support XDP offload.
     2. Load a device bound XDP program with BPF_F_XDP_DEV_BOUND_ONLY flag
        (such programs are not offloaded).
     3. Load a device bound XDP program with zero flags
        (such programs are offloaded).

     At step (2) __bpf_prog_dev_bound_init() associates with device (1)
     a dummy bpf_offload_netdev struct with .offdev field set to NULL.
     At step (3) __bpf_prog_dev_bound_init() would reuse dummy struct
     allocated at step (2).
     However, downstream usage of the bpf_offload_netdev assumes that
     .offdev field can't be NULL, e.g. in bpf_prog_offload_verifier_prep().

     Adjust __bpf_prog_dev_bound_init() to require bpf_offload_netdev
     with non-NULL .offdev for offloaded BPF programs.

     Fixes: 2b3486bc2d23 ("bpf: Introduce device-bound XDP programs")
     Reported-by: syzbot+291100dcb32190ec02a8@syzkaller.appspotmail.com
     Closes: https://lore.kernel.org/bpf/000000000000d97f3c060479c4f8@google.com/
     Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
     Link: https://lore.kernel.org/r/20230912005539.2248244-2-eddyz87@gmail.com
     Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>


