Return-Path: <bpf+bounces-9052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F7E78ED15
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 14:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 332401C20A93
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 12:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941FC11709;
	Thu, 31 Aug 2023 12:29:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5B08C10
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 12:29:53 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C955CFF;
	Thu, 31 Aug 2023 05:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=AuoeT0q4LJbl7muZqjyyTpJkzqz+1kv2o9BGttWzdfA=; b=Lt9RdBHrmbU1Mkao1QA3gcXnYe
	M9KpP2B1pWSPLH+626tGR1/Dc6oK66sR7E1ZpnHZ95/nKwkPQPOLIQ8d1iXSuGI7g+njLLs/qEhVM
	dQbAbyveGyiF/MxPXdLoNFpN9D7/Lz2oDIICpkmWyRr82WN/J8LwGobTfvzGaSYGOy01mG0ezsRTJ
	PEFXKEtB12QUWB67nxgDRZsa7Gfz0wGmaZyt1xEcE+jkgkC9cZ0B/02UusnBh/BtR715BmqT61N6Q
	cAxt/15DGDr5JTp2+M7gevgmhKXVUXoqQf/8q/Krclunplquh2Dzx7K5doqvzuGyMXJGciV57uzsx
	G2fCf+zA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qbgnw-0003yI-N6; Thu, 31 Aug 2023 14:29:45 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qbgnw-0004pD-KU; Thu, 31 Aug 2023 14:29:44 +0200
Subject: Re: [PATCH bpf-next] selftests/bpf: Include build flavors for install
 target
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 bpf@vger.kernel.org
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Alexei Starovoitov <ast@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230828183329.546959-1-bjorn@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <abe27949-6e35-07e6-ef29-bbc749fc40d5@iogearbox.net>
Date: Thu, 31 Aug 2023 14:29:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230828183329.546959-1-bjorn@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27017/Thu Aug 31 09:40:48 2023)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/28/23 8:33 PM, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> When using the "install" or targets depending on install,
> e.g. "gen_tar", the BPF machine flavors weren't included.
> 
> A command like:
>    | make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- O=/workspace/kbuild \
>    |    HOSTCC=gcc FORMAT= SKIP_TARGETS="arm64 ia64 powerpc sparc64 x86 sgx" \
>    |    -C tools/testing/selftests gen_tar
> would not include bpf/no_alu32, bpf/cpuv4, or bpf/bpf-gcc.
> 
> Include the BPF machine flavors for "install" make target.
> 
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>

Looks good and BPF CI also seems to be fine with it, wrt INSTDIRS could we use
a more appropriate location where we define it? Was thinking sth like:

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 7c77a21c3371..8b724efb8b7f 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -50,14 +50,17 @@ TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test
         test_cgroup_storage \
         test_tcpnotify_user test_sysctl \
         test_progs-no_alu32
+TEST_INST_SUBDIRS := no_alu32

  # Also test bpf-gcc, if present
  ifneq ($(BPF_GCC),)
  TEST_GEN_PROGS += test_progs-bpf_gcc
+TEST_INST_SUBDIRS += bpf_gcc
  endif

  ifneq ($(CLANG_CPUV4),)
  TEST_GEN_PROGS += test_progs-cpuv4
+TEST_INST_SUBDIRS += cpuv4
  endif

[...]

Thanks,
Daniel

