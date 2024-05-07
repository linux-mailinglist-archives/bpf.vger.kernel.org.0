Return-Path: <bpf+bounces-28753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7208BD9A5
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 05:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E506B2280D
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 03:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E70A3FB2F;
	Tue,  7 May 2024 03:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Y5lpGjJv"
X-Original-To: bpf@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7A650A67
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 03:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715051737; cv=none; b=nwkywQgP0EErYdE8L92SelCyKnczomX0F1vCL2zDkoG+eKLJpWYC2Lr0RqfUEP5fDaSZvmBS5ORwe+/xIHPvbVLOVVEj2cf2nz0F6lf9OVtVK8Qp3vjECFciIJRbavzKVmWHZ4LKbxpiqp7t/NJxhNUpi+T8DpoLYWcqRmfPJko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715051737; c=relaxed/simple;
	bh=jMrEKDwZCFov2K64LDvgoYffo5ZggXpzw6fuUy2inUU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZMXlhxtxQf2lDz9Fn8d9Xu6vnzgzBmWbtS0OL34PZynI/TwmUsildiWpg72Pu1jPixCwIMkIvXZjglXG8SauuoovPtWe/LE6RKM/0g46AwgkVwBBz+kh4P+GO6guYm/pPSKYGYJFSOmWoi8K0WB4iFCqcsJ9FMtHEXKOEd4w2zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Y5lpGjJv; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715051726; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=fvyMm0M5S/jAwxgOJhHMO2OcnsUJKWVm4Xslcg7cod4=;
	b=Y5lpGjJvYNr1dFEiWv0SmFFK909mL4f6RuI4b/yQLdHJMaDtaTU/l79jsqSpuUxJdqhi8X1nLTY5TFDhEg+N/YXONyrR7p1nJF1WWhTM5cie0Rp+4WT+RHpeY673Gwi30Sx4+YowNT2y7yGv8a8ig//CLoM+1N0dROhYneVEe1c=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0W6-Z8Wb_1715051723;
Received: from 30.221.128.110(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0W6-Z8Wb_1715051723)
          by smtp.aliyun-inc.com;
          Tue, 07 May 2024 11:15:24 +0800
Message-ID: <e2b00a10-db9f-4b8f-82ac-49a3f9b301ed@linux.alibaba.com>
Date: Tue, 7 May 2024 11:15:23 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Philo Lu <lulie@linux.alibaba.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Expand skb dynptr selftests
 for tp_btf
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, ast@kernel.org,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mykolal@fb.com,
 shuah@kernel.org, drosen@google.com, xuanzhuo@linux.alibaba.com,
 bpf@vger.kernel.org
References: <20240430121805.104618-1-lulie@linux.alibaba.com>
 <20240430121805.104618-3-lulie@linux.alibaba.com>
 <5e3d1bd3-0893-41b0-89e1-9311d53c2198@linux.dev>
In-Reply-To: <5e3d1bd3-0893-41b0-89e1-9311d53c2198@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/5/7 05:43, Martin KaFai Lau wrote:
> On 4/30/24 5:18 AM, Philo Lu wrote:
>> Add 3 test cases for skb dynptr used in tp_btf:
[...]
>> +
>> +SEC("tp_btf/kfree_skb")
>> +int BPF_PROG(test_dynptr_skb_tp_btf, struct __sk_buff *skb, void 
>> *location)
> 
> struct __sk_buff is the incorrect type. This happens to work but will be 
> a surprise for people trying to read something (e.g. skb->len). The same 
> goes for the ones in dynptr_fail.c.
> 

What do you think if I replace "struct __sk_buff" with "void"? The diffs 
are appended below.

Because we are not to read anything in these cases, I think using void* 
is enough to avoid confusion. On the other hand, to use "struct sk_buff" 
here, we have to introduce the definition, and tune codes as the input 
type of bpf_dynptr_from_skb() is defined as struct __sk_buff in 
"bpf_kfuncs.h".

Thanks.

-----------------
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c 
b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index c438d1c3cac56..42dbf8715c6a8 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -1257,7 +1257,7 @@ int skb_invalid_ctx(void *ctx)

  SEC("fentry/skb_tx_error")
  __failure __msg("must be referenced or trusted")
-int BPF_PROG(skb_invalid_ctx_fentry, struct __sk_buff *skb)
+int BPF_PROG(skb_invalid_ctx_fentry, void *skb)
  {
         struct bpf_dynptr ptr;

@@ -1269,7 +1269,7 @@ int BPF_PROG(skb_invalid_ctx_fentry, struct 
__sk_buff *skb)

  SEC("fexit/skb_tx_error")
  __failure __msg("must be referenced or trusted")
-int BPF_PROG(skb_invalid_ctx_fexit, struct __sk_buff *skb)
+int BPF_PROG(skb_invalid_ctx_fexit, void *skb)
  {
         struct bpf_dynptr ptr;

diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c 
b/tools/testing/selftests/bpf/progs/dynptr_success.c
index 8faafab97c0ec..bfcc85686cf04 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -547,7 +547,7 @@ int test_dynptr_skb_strcmp(struct __sk_buff *skb)
  }

  SEC("tp_btf/kfree_skb")
-int BPF_PROG(test_dynptr_skb_tp_btf, struct __sk_buff *skb, void *location)
+int BPF_PROG(test_dynptr_skb_tp_btf, void *skb, void *location)
  {
         __u8 write_data[2] = {1, 2};
         struct bpf_dynptr ptr;

