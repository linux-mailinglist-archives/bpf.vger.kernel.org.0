Return-Path: <bpf+bounces-8127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078E6781C22
	for <lists+bpf@lfdr.de>; Sun, 20 Aug 2023 04:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC9D21C208A8
	for <lists+bpf@lfdr.de>; Sun, 20 Aug 2023 02:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1C0A51;
	Sun, 20 Aug 2023 02:43:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6C6368
	for <bpf@vger.kernel.org>; Sun, 20 Aug 2023 02:43:22 +0000 (UTC)
Received: from out-32.mta0.migadu.com (out-32.mta0.migadu.com [IPv6:2001:41d0:1004:224b::20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13D91D771
	for <bpf@vger.kernel.org>; Sat, 19 Aug 2023 18:41:41 -0700 (PDT)
Message-ID: <79d3c797-17ba-bc9e-b1f9-44ad024b576f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692495699; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=UyzMdkJUGGZImIIDV3kVx4Vupk9R5T81wame5f6pg+g=;
	b=bfq7wcPoIr+AlO+wZMmA357dkf02WW3xG7gm5KcYTJ0puQ4Zn+6ZFsueEo0F05l+6cGFfU
	GJ+74naanA5VBc1PCpCDjdwLBXx9sL555riZNLfOyR17FHBam7+Ucbh9G6xWEv8grJ+ZI5
	rWREhPF/1sOR26zlKDcXv460PKGzu2c=
Date: Sat, 19 Aug 2023 18:41:30 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Content-Language: en-US
To: Shubham Bansal <illusionist.neo@gmail.com>,
 Johan Almbladh <johan.almbladh@anyfinetworks.com>,
 Paul Burton <paulburton@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Luke Nelson <luke.r.nels@gmail.com>,
 Xi Wang <xi.wang@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 "David S. Miller" <davem@davemloft.net>, Wang YanQing <udknight@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, bpf <bpf@vger.kernel.org>
Subject: bpf: Request to add -mcpu=v4 support for
 ARM/MIPS/NFP/POWERPC/RISCV/S390/SPARC/X86_32
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

A new set of bpf insns have been recently added in llvm with flag
[-mcpu=v4](https://reviews.llvm.org/D144829). In the kernel,
x86_64 and arm64 have implemented -mcpu=v4 support:
   x86_64: 
https://lore.kernel.org/all/20230728011143.3710005-1-yonghong.song@linux.dev/
   arm64: 
https://lore.kernel.org/bpf/20230815154158.717901-1-xukuohai@huaweicloud.com/

The following arch's do not have -mcpu=v4 support yet:
   arm, mips, nfp, powerpc, riscv, sc90, sparc and x86_32

If you have a chance, could you take a look at what
x86_64/arm64 does and add support to the above arch'es?

Thanks!

Yonghong

