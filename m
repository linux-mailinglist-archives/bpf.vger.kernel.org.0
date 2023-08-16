Return-Path: <bpf+bounces-7897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EC177E286
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 15:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9A4F1C210A8
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 13:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E8E111BB;
	Wed, 16 Aug 2023 13:26:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8C1DF60
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 13:26:36 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7432D59;
	Wed, 16 Aug 2023 06:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=iazt9Upe7wS6eRnyTUTcCnN/AdUD6Uwis1lN6zV9t5M=; b=pdnPJh1EC4a6691fmX6d9Vbxft
	BFLB7xzl7Mm/9zd5ypYSWmcZnUcD9DZL21B/tNV7Pqz+CscGjPY0RGys2xQ0v2Z/vm4rJiQx1A0+4
	ULLUHuq1oAA6Dw6qdaooTy0mM043kI+6GhZbigAngOz9Vd4v1MWejZHT4aRWwdNHl3qdtr2n9ZkgE
	SHmsSaJVRX/OCjFhEylfGXbMyVJPzNKF3K5mAwznohSGX9bXPSLEN8rAaVztmJvR+D+qxxIVawoS2
	8xdqXWsx0ocyi1gjYoK6o9Tpilq5gCKQ0um+qt/pU9pAnMjVHOXBDlygHZMNgCNglTxxxZS9f2/Pl
	G9S6TayQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qWGWz-000CtP-EU; Wed, 16 Aug 2023 15:25:49 +0200
Received: from [85.1.206.226] (helo=pc-102.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qWGWy-000U1b-Hm; Wed, 16 Aug 2023 15:25:48 +0200
Subject: Re: [PATCH bpf-next v4 3/3] bpf, arm64: use bpf_jit_binary_pack_alloc
To: Puranjay Mohan <puranjay12@gmail.com>, ast@kernel.org, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, catalin.marinas@arm.com,
 mark.rutland@arm.com, bpf@vger.kernel.org, kpsingh@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
References: <20230626085811.3192402-1-puranjay12@gmail.com>
 <20230626085811.3192402-4-puranjay12@gmail.com>
 <CANk7y0gcP3dF2mESLp5JN1+9iDfgtiWRFGqLkCgZD6wby1kQOw@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <af236038-cfbf-876d-086f-4dea198ef497@iogearbox.net>
Date: Wed, 16 Aug 2023 15:25:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANk7y0gcP3dF2mESLp5JN1+9iDfgtiWRFGqLkCgZD6wby1kQOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27002/Wed Aug 16 09:38:26 2023)
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/15/23 4:09 PM, Puranjay Mohan wrote:
> Hi Everyone,
> 
> [+cc Björn]
> 
> On Mon, Jun 26, 2023 at 10:58 AM Puranjay Mohan <puranjay12@gmail.com> wrote:
>>
>> Use bpf_jit_binary_pack_alloc for memory management of JIT binaries in
>> ARM64 BPF JIT. The bpf_jit_binary_pack_alloc creates a pair of RW and RX
>> buffers. The JIT writes the program into the RW buffer. When the JIT is
>> done, the program is copied to the final RX buffer
>> with bpf_jit_binary_pack_finalize.
>>
>> Implement bpf_arch_text_copy() and bpf_arch_text_invalidate() for ARM64
>> JIT as these functions are required by bpf_jit_binary_pack allocator.
>>
>> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
>> Acked-by: Song Liu <song@kernel.org>
> 
> [...]
> 
>> +int bpf_arch_text_invalidate(void *dst, size_t len)
>> +{
>> +       __le32 *ptr;
>> +       int ret;
>> +
>> +       for (ptr = dst; len >= sizeof(u32); len -= sizeof(u32)) {
>> +               ret = aarch64_insn_patch_text_nosync(ptr++, AARCH64_BREAK_FAULT);
>> +               if (ret)
>> +                       return ret;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
> 
> While testing the same patch for riscv bpf jit, Björn found that
> ./test_tag is taking a lot of
> time to complete. He found that bpf_arch_text_invalidate() is calling
> patch_text_nosync() in RISCV
> and aarch64_insn_patch_text_nosync() here in ARM64. Both of the
> implementations call these functions
> in a loop for each word. The problem is that every call to
> patch_text_nosync()/aarch64_insn_patch_text_nosync()
> would clean the cache. This will make this
> function(bpf_arch_text_invalidate) really slow.
> 
> I did some testing using the vmtest.sh script on ARM64 with and
> without the patches, here are the results:
> 
> With Prog Pack patches applied:
> =========================
> 
> root@(none):/# time ./root/bpf/test_tag
> test_tag: OK (40945 tests)
> 
> real    3m2.001s
> user    0m1.644s
> sys     2m40.132s
> 
> Without Prog Pack:
> ===============
> 
> root@(none):/# time ./root/bpf/test_tag
> test_tag: OK (40945 tests)
> 
> real    0m26.809s
> user    0m1.591s
> sys     0m24.106s
> 
> As you can see the current implementation of
> bpf_arch_text_invalidate() is really slow. I need to
> implement a new function: aarch64_insn_set_text_nosync() and use it in
> bpf_arch_text_invalidate()
> rather than calling aarch64_insn_patch_text_nosync() in a loop.

Ok, thanks for looking into this. I'm going to toss the current version from
patchwork in that case and will wait for a v5 from your side.

> In the longer run, it would be really helpful if we have a standard
> text_poke API like x86 in every architecture.

Likely independent of this series, but in case you see potential to consolidate
generic pieces, it might be worth a look after the arm64/riscv bits landed.

Thanks for working on this, Puranjay!

