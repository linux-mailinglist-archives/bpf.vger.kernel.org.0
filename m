Return-Path: <bpf+bounces-59817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62795ACFA13
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 01:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DC7F17A12B
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 23:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4C427FB3A;
	Thu,  5 Jun 2025 23:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vXykkAtY"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518A7211484
	for <bpf@vger.kernel.org>; Thu,  5 Jun 2025 23:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749166843; cv=none; b=U6Sjbf9bV+gBFgsRSH9DVLuOhkuak4rYq6q0Efmk5rEEmNaDooD9yiv9EjP8d+8Pdqa9D2sJMPwdRZXuDPh+Rt93ouMJ7te8hHkW+Lcte5og4oxZo6nw5cTJzY4P6FfYpyy1uW7UM0cAky5/A0Vl4wTbSpobdsVlvKUXVSlhKEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749166843; c=relaxed/simple;
	bh=DY1Y+z6M+sv7d9CrqTiKtylXnG+03vm1C0MC9BuF9eA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H+E6HMJuClG8kalt+3pifpoPDFkYwWzHm+7B0vaDVy/3jLuvXnnfAUbGwuwuwvRuimzOqq/dVwXwKdwDTJZAs+2jTOgvfJS9e5AqD+PGkCvUiwSMoRJCkvLj2OWY/k3OwywmTiVTGfI1Itubb8sRunW9J33jw7vpjHGBGDwWj14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vXykkAtY; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8c24eae8-a932-4c1d-87ec-c5f8ef8fdf79@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749166837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gn7jtOP0tgP6Plh9Pd6NTEV3J78AUqB6XTpVp8ZhP3E=;
	b=vXykkAtY1gpCpp2oHoLJoBJmqKHLECvbYMd+kBck6zoIQsZCfeLRouQ/wVfofEtZ363h0m
	imYKrKjwassA/PwmaUJ8+jcIZn5FggCve+AgZ2LAoFt4pDd9NH5RwasF0r2yx4msBNuRCY
	IsbJrve/TLiYxOhIy1/kGsGKLoXZops=
Date: Thu, 5 Jun 2025 16:40:31 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: add test cases with
 CONST_PTR_TO_MAP null checks
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Yonghong Song <yonghong.song@linux.dev>, Kernel Team <kernel-team@meta.com>
References: <20250604222729.3351946-1-isolodrai@meta.com>
 <20250604222729.3351946-3-isolodrai@meta.com>
 <CAEf4Bzae53DDPQYUwOC2w=LO1yxPMU2=vDoS7=rCSv1BkcsJ5A@mail.gmail.com>
 <8df5f5d4-cafe-477b-b0cf-7c86117f21cd@linux.dev>
 <CAADnVQJ-sxOEdzy7OktZrTUDxk7Rw7H3zCt_u+iM987zTTDksw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAADnVQJ-sxOEdzy7OktZrTUDxk7Rw7H3zCt_u+iM987zTTDksw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 6/5/25 10:00 AM, Alexei Starovoitov wrote:
> On Thu, Jun 5, 2025 at 9:42 AM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> On 6/5/25 9:24 AM, Andrii Nakryiko wrote:
>>> On Wed, Jun 4, 2025 at 3:28 PM Ihor Solodrai <isolodrai@meta.com> wrote:
>>>>
>>>> [...]
>>>>
>>>> +SEC("socket")
>>>> +int map_ptr_is_never_null(void *ctx)
>>>> +{
>>>> +       struct bpf_map *maps[2] = { 0 };
>>>> +       struct bpf_map *map = NULL;
>>>> +       int __attribute__((aligned(8))) key = 0;
>>>
>>> aligned(8) makes any difference?
>>
>> Yes. If not aligned (explicitly or by accident), verification fails
>> with "math between fp pointer and register with unbounded min value is
>> not allowed" at maps[key]. See the log below.
> 
> It's not clear to me why "aligned" changes code gen,
> but let's not rely on it.
> Try 'unsigned int key' instead.
> Also note that &key part pessimizes the code.
> Do for (...; i < 2; i++) {u32 key = i; &key }
> instead.

I've tried changing the test like this:

@@ -144,12 +144,12 @@ int map_ptr_is_never_null(void *ctx)
  {
         struct bpf_map *maps[2] = { 0 };
         struct bpf_map *map = NULL;
-       int __attribute__((aligned(8))) key = 0;

-       for (key = 0; key < 2; key++) {
+       for (int i = 0; i < 2; i++) {
+               __u32 key = i;
                 map = bpf_map_lookup_elem(&map_in_map, &key);
                 if (map)
-                       maps[key] = map;
+                       maps[i] = map;
                 else
                         return 0;
         }

This version passes verification independent of the first patch being
applied, which kinda defeats the purpose of the test. Verifier log
below:

     0: R1=ctx() R10=fp0
     ; int map_ptr_is_never_null(void *ctx) @ verifier_map_in_map.c:143
     0: (b4) w1 = 0                        ; R1_w=0
     ; __u32 key = i; @ verifier_map_in_map.c:149
     1: (63) *(u32 *)(r10 -4) = r1
     mark_precise: frame0: last_idx 1 first_idx 0 subseq_idx -1
     mark_precise: frame0: regs=r1 stack= before 0: (b4) w1 = 0
     2: R1_w=0 R10=fp0 fp-8=0000????
     2: (bf) r2 = r10                      ; R2_w=fp0 R10=fp0
     3: (07) r2 += -4                      ; R2_w=fp-4
     ; map = bpf_map_lookup_elem(&map_in_map, &key); @ 
verifier_map_in_map.c:150
     4: (18) r1 = 0xff302cd6802e0a00       ; 
R1_w=map_ptr(map=map_in_map,ks=4,vs=4)
     6: (85) call bpf_map_lookup_elem#1    ; 
R0_w=map_value_or_null(id=1,map=map_in_map,ks=4,vs=4)
     ; if (map) @ verifier_map_in_map.c:151
     7: (15) if r0 == 0x0 goto pc+7        ; R0_w=map_ptr(ks=4,vs=4)
     8: (b4) w1 = 1                        ; R1_w=1
     ; __u32 key = i; @ verifier_map_in_map.c:149
     9: (63) *(u32 *)(r10 -4) = r1         ; R1_w=1 R10=fp0 fp-8=mmmm????
     10: (bf) r2 = r10                     ; R2_w=fp0 R10=fp0
     11: (07) r2 += -4                     ; R2_w=fp-4
     ; map = bpf_map_lookup_elem(&map_in_map, &key); @ 
verifier_map_in_map.c:150
     12: (18) r1 = 0xff302cd6802e0a00      ; 
R1_w=map_ptr(map=map_in_map,ks=4,vs=4)
     14: (85) call bpf_map_lookup_elem#1   ; 
R0=map_value_or_null(id=2,map=map_in_map,ks=4,vs=4)
     ; } @ verifier_map_in_map.c:164
     15: (b4) w0 = 0                       ; R0_w=0
     16: (95) exit


If map[i] is changed back to map[key] like this:

	for (int i = 0; i < 2; i++) {
		__u32 key = i;
		map = bpf_map_lookup_elem(&map_in_map, &key);
		if (map)
			maps[key] = map; /* change here */
		else
			return 0;
	}

Verification fails with "invalid unbounded variable-offset write to 
stack R2"

     VERIFIER LOG:
     =============
     arg#0 reference type('UNKNOWN ') size cannot be determined: -22
     0: R1=ctx() R10=fp0
     ; int map_ptr_is_never_null(void *ctx) @ verifier_map_in_map.c:143
     0: (b7) r1 = 0                        ; R1_w=0
     ; struct bpf_map *maps[2] = { 0 }; @ verifier_map_in_map.c:145
     1: (7b) *(u64 *)(r10 -8) = r1         ; R1_w=0 R10=fp0 fp-8_w=0
     2: (7b) *(u64 *)(r10 -16) = r1        ; R1_w=0 R10=fp0 fp-16_w=0
     3: (b4) w1 = 0                        ; R1_w=0
     ; __u32 key = i; @ verifier_map_in_map.c:149
     4: (63) *(u32 *)(r10 -20) = r1        ; R1_w=0 R10=fp0 fp-24=0000????
     5: (bf) r2 = r10                      ; R2_w=fp0 R10=fp0
     6: (07) r2 += -20                     ; R2_w=fp-20
     ; map = bpf_map_lookup_elem(&map_in_map, &key); @ 
verifier_map_in_map.c:150
     7: (18) r1 = 0xff1f1a9b829ae400       ; 
R1_w=map_ptr(map=map_in_map,ks=4,vs=4)
     9: (85) call bpf_map_lookup_elem#1    ; 
R0_w=map_value_or_null(id=1,map=map_in_map,ks=4,vs=4)
     ; if (map) @ verifier_map_in_map.c:151
     10: (15) if r0 == 0x0 goto pc+24      ; R0_w=map_ptr(ks=4,vs=4)
     ; maps[key] = map; @ verifier_map_in_map.c:152
     11: (61) r1 = *(u32 *)(r10 -20)       ; R1_w=0 R10=fp0 fp-24=0000????
     12: (67) r1 <<= 3                     ; R1_w=0
     13: (bf) r2 = r10                     ; R2_w=fp0 R10=fp0
     14: (07) r2 += -16                    ; R2_w=fp-16
     15: (0f) r2 += r1                     ; R1_w=0 R2_w=fp-16
     16: (7b) *(u64 *)(r2 +0) = r0         ; R0_w=map_ptr(ks=4,vs=4) 
R2_w=fp-16 fp-16_w=map_ptr(ks=4,vs=4)
     17: (b4) w1 = 1                       ; R1_w=1
     ; __u32 key = i; @ verifier_map_in_map.c:149
     18: (63) *(u32 *)(r10 -20) = r1       ; R1_w=1 R10=fp0 fp-24=mmmm????
     19: (bf) r2 = r10                     ; R2_w=fp0 R10=fp0
     20: (07) r2 += -20                    ; R2_w=fp-20
     ; map = bpf_map_lookup_elem(&map_in_map, &key); @ 
verifier_map_in_map.c:150
     21: (18) r1 = 0xff1f1a9b829ae400      ; 
R1_w=map_ptr(map=map_in_map,ks=4,vs=4)
     23: (85) call bpf_map_lookup_elem#1   ; 
R0=map_value_or_null(id=2,map=map_in_map,ks=4,vs=4)
     ; if (map) @ verifier_map_in_map.c:151
     24: (15) if r0 == 0x0 goto pc+10      ; R0=map_ptr(ks=4,vs=4)
     ; maps[key] = map; @ verifier_map_in_map.c:152
     25: (61) r1 = *(u32 *)(r10 -20)       ; 
R1_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) 
R10=fp0 fp-24=mmmm????
     26: (67) r1 <<= 3                     ; 
R1_w=scalar(smin=0,smax=umax=0x7fffffff8,smax32=0x7ffffff8,umax32=0xfffffff8,var_off=(0x0; 
0x7fffffff8))
     27: (bf) r2 = r10                     ; R2_w=fp0 R10=fp0
     28: (07) r2 += -16                    ; R2_w=fp-16
     29: (0f) r2 += r1                     ; 
R1_w=scalar(smin=0,smax=umax=0x7fffffff8,smax32=0x7ffffff8,umax32=0xfffffff8,var_off=(0x0; 
0x7fffffff8)) 
R2_w=fp(off=-16,smin=0,smax=umax=0x7fffffff8,smax32=0x7ffffff8,umax32=0xfffffff8,var_off=(0x0; 
0x7fffffff8))
     30: (7b) *(u64 *)(r2 +0) = r0
     invalid unbounded variable-offset write to stack R2

... which can be "fixed" by aligning the local key variable

     __u32 __attribute__((aligned(8))) key = i;

but that puts us back to square one.

It appears that alignment becomes a problem if the variable is used as
array index and also it's address is passed to a helper.

And if different vars are used for array access and map lookup, then
map_ptr nullness issue doesn't reproduce.

Any suggestions?



