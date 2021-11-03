Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBAB4444041
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 12:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhKCLDP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Nov 2021 07:03:15 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:27171 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhKCLDO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Nov 2021 07:03:14 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HkkKl35PvzTgG2;
        Wed,  3 Nov 2021 18:59:07 +0800 (CST)
Received: from dggpeml500025.china.huawei.com (7.185.36.35) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 3 Nov 2021 19:00:36 +0800
Received: from [10.174.176.117] (10.174.176.117) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 3 Nov 2021 19:00:36 +0800
Subject: Re: Question about pointer to forward type
To:     Yonghong Song <yhs@fb.com>, Martin KaFai Lau <kafai@fb.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        "Andrii Nakryiko" <andrii@kernel.org>
References: <c19f223e-2ef5-9f9a-f741-2fcc7d89fef6@huawei.com>
 <050ba6c6-c7b2-528c-b616-030b7b14d67e@fb.com>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <bb306bdd-4770-6d47-c490-a206d191b1e8@huawei.com>
Date:   Wed, 3 Nov 2021 19:00:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <050ba6c6-c7b2-528c-b616-030b7b14d67e@fb.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 11/3/2021 11:58 AM, Yonghong Song wrote:
>
>
> On 10/15/21 7:22 AM, Hou Tao wrote:
>> Hi,
>>
>> When adding test case for BPF STRUCT OPS, I got the following error
>> during test:
>>
>> libbpf: load bpf program failed: Permission denied
>> libbpf: -- BEGIN DUMP LOG ---
>> libbpf:
>> R1 type=ctx expected=fp
>> ; int BPF_PROG(test_1, struct bpf_dummy_ops_state *state)
>> 0: (b4) w0 = -218893067
>> ; int BPF_PROG(test_1, struct bpf_dummy_ops_state *state)
>> 1: (79) r1 = *(u64 *)(r1 +0)
>> func 'test_1' arg0 type FWD is not a struct
>> invalid bpf_context access off=0 size=8
>>
>> The error is reported from btf_ctx_access(). And the cause is
>> the definition of struct bpf_dummy_ops_state is separated from
>> the definition of test_1 function:
>>
>> test_1 is defined in include/linux/bpf.h
>>
>> struct bpf_dummy_ops_state;
>> struct bpf_dummy_ops {
>>          int (*test_1)(struct bpf_dummy_ops_state *cb);
>> }
>>
>> bpf_dummy_ops_state is defined in net/bpf/bpf_dummy_struct_ops.c
>>
>> struct bpf_dummy_ops_state {
>> };
>>
>> So arg0 has BTF_KIND_FWD type, and the check in btf_ctx_access() fails.
>> The problem can be fixed by moving the definition of bpf_dummy_ops_state
>> into include/linux/bpf.h or using a void * instead of
>> struct bpf_dummy_ops_state *. But forward declaration is possible under
>> STRUCT_OPS scenario, so my question is whether or not it is a known issue
>> and is there somebody working on this ?
>
> I suspect this is what happened.
> The 'struct bpf_dummy_ops_state' is defined in net/bpf/bpf_dummy_struct_ops.c,
> but this structure is not used in that file
> so there is no definition in the bpf_dummy_struct_ops.o dwarf.
>
> Since in the final combined dwarf, there is no "struct bpf_dummy_ops_state"
> definition, dedup won't be able to replace
> forward declaration with actual definition. And this caused
> your above issue.
>
> It would be good if you can verifier whether this is the case or
> not. If bpf_dummy_ops_state definition is in the dwarf, then we
> likely have a dedup problem.
struct bpf_dummy_ops_state is used in net/bpf/bpf_dummy_struct_ops.c, but
the problem still exists.

And it can be reproduced by moving the definition of bpf_dummy_ops_state
from include/linux/bpf.h to bpf_dummy_struct_ops.c as shown below and
running "./test_progs -t dummy_st_ops":

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2be6dfd68df9..1d1e6dff5ce8 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1024,9 +1024,7 @@ static inline void bpf_module_put(const void *data, struct
module *owner)

 #ifdef CONFIG_NET
 /* Define it here to avoid the use of forward declaration */
-struct bpf_dummy_ops_state {
-       int val;
-};
+struct bpf_dummy_ops_state;

 struct bpf_dummy_ops {
        int (*test_1)(struct bpf_dummy_ops_state *cb);
diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
index fbc896323bec..2beb755b5806 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -9,6 +9,10 @@

 extern struct bpf_struct_ops bpf_bpf_dummy_ops;

+struct bpf_dummy_ops_state {
+       int val;
+};
+
 /* A common type for test_N with return value in bpf_dummy_ops */
 typedef int (*dummy_ops_test_ret_fn)(struct bpf_dummy_ops_state *state, ...);


The following is the output of vmliux btf dump. We can see that it does
have the definition of bpf_dummy_ops_state.

# bpftool btf dump id 1 | grep "test_1\|bpf_dummy_ops_state" -A 6 -B 1
[29190] STRUCT 'bpf_dummy_ops' size=16 vlen=2
        'test_1' type_id=29194 bits_offset=0
        'test_2' type_id=29196 bits_offset=64
[29191] FUNC_PROTO '(anon)' ret_type_id=21 vlen=1
        '(anon)' type_id=29192
[29192] PTR '(anon)' type_id=29193
[29193] FWD 'bpf_dummy_ops_state' fwd_kind=struct
[29194] PTR '(anon)' type_id=29191

--
[106565] STRUCT 'bpf_dummy_ops_state' size=4 vlen=1
        'val' type_id=21 bits_offset=0
[106566] TYPEDEF 'dummy_ops_test_ret_fn' type_id=106567
[106567] PTR '(anon)' type_id=106568

And the definition of bpf_dummy_ops_state comes from
bpf_dummy_struct_ops.o:

# pahole -JV build/net/bpf/bpf_dummy_struct_ops.o | grep bpf_dummy_ops_state
[1910] STRUCT bpf_dummy_ops_state size=4

>
>>
>> Regards,
>> Tao
>>
> .

