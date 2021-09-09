Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD497404315
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 03:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241726AbhIIBqS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Sep 2021 21:46:18 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:15396 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236691AbhIIBqS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Sep 2021 21:46:18 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H4hYC0KW8zQsFq;
        Thu,  9 Sep 2021 09:41:03 +0800 (CST)
Received: from dggpeml500025.china.huawei.com (7.185.36.35) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 9 Sep 2021 09:45:04 +0800
Received: from [10.174.176.117] (10.174.176.117) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 9 Sep 2021 09:45:03 +0800
Subject: Re: [PATCH bpf] bpf: handle return value of BPF_PROG_TYPE_STRUCT_OPS
 prog
To:     Martin KaFai Lau <kafai@fb.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "KP Singh" <kpsingh@kernel.org>
References: <20210901085344.3052333-1-houtao1@huawei.com>
 <20210908060611.jylpjegug3gs5gys@kafai-mbp.dhcp.thefacebook.com>
 <8e8dd070-ba19-2153-bf9b-8bbb16a70abb@huawei.com>
 <20210908171939.l6ozdyoji3n5baaf@kafai-mbp.dhcp.thefacebook.com>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <427b92b3-417e-9dda-688e-c9e3c1b2b38c@huawei.com>
Date:   Thu, 9 Sep 2021 09:45:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210908171939.l6ozdyoji3n5baaf@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 9/9/2021 1:19 AM, Martin KaFai Lau wrote:
> On Wed, Sep 08, 2021 at 09:31:55PM +0800, Hou Tao wrote:
>> Hi,
>>
>> On 9/8/2021 2:06 PM, Martin KaFai Lau wrote:
>>> On Wed, Sep 01, 2021 at 04:53:44PM +0800, Hou Tao wrote:
>>>> Currently if a function ptr in struct_ops has a return value, its
>>>> caller will get a random return value from it, because the return
>>>> value of related BPF_PROG_TYPE_STRUCT_OPS prog is just dropped.
>>>>
>>>> So adding a new flag BPF_TRAMP_F_RET_FENTRY_RET to tell bpf trampoline
>>>> to save and return the return value of struct_ops prog if ret_size of
>>>> the function ptr is greater than 0. Also restricting the flag to be
>>>> used alone.
>>> Thanks for the report and fix!  Sorry for the late reply.
>>>
>>> This bug is missed because the tcp-cc func is not always called.
>>> A better test needs to be created to force exercising these funcs
>>> in bpf_test_run(), which can be a follow-up patch in the bpf-next.
>>> Could you help to create this test as a follow up?
>> Yes, will do. The first thought comes into my mind is implementing .get_info hook
>> in a bpf tcp_congestion_ops and checking its return value in userspace by
>> getsockopt(fd, TCP_CC_INFO).
> The bpf-tcp-cc's struct_ops currently does not support ".get_info".
Yes. I just find it in unsupported_ops[].
> It will be a good addition also.
> Different bpf-tcp-cc implementations have different infos, so it cannot be
> bounded by a fixed struct like 'union tcp_cc_info'.  The format should be
> a btf_id followed by the actual info-data.  The kernel should be able to
> learn the size of the info-data from the btf_id.  The ".get_info" is
> also used by inet_diag for tools (ss) like iproute2.  libbpf can pretty-print
> the btf described data and libbpf support is added to iproute2, so pieces
> should be in-place for iproute2's tools to handle data described by btf.
>
> For ".get_info" in getsockopt(TCP_CC_INFO), not sure how the application
> may use them but I think it will at least enable the application log
> them as other kernel's tcp-cc do.  The implementation details may
> need some more thoughts but should not be a big issue.

getsockopt(TCP_CC_INFO) also calls .get_info although it bounds the max size of

info as sizoef(union_tcp_cc_info), so userspace can check the value of returned optlen.

>> I also consider to add a new BPF struct_ops
>> for testing purpose, but it may be a little overkill.
> A dummy struct_ops for testing makes sense. It probably should
> be the one done first for testing purpose.  Although "get_info"
> is a good add, having a separate testing struct_ops will be easier
> to test other interesting cases in the future.

So I will start by adding a dummy struct_ops for testing purpose, because it will

be much simpler and leaving adding support for .get_info for bpf-tcp-cc as another

patch.

>> I just check that it can be applied both on bpf and bpf-next, do you
>> have other commits in your tree ?
> There is no local commit.
>
> >From a quick look, the patch is created from a pretty old tree and it
> is missing the BPF_TRAMP_F_SKIP_FRAME.  It is introduced in
> commit 7e6f3cd89f04 ("bpf, x86: Store caller's ip in trampoline stack")
> on Jul 15 2021 which is pretty old.
>
> I am only able to apply with the --3way merge like "git am --3way".
> Andrii, is it fine to land the patch like this?

I cannot apply it cleanly if using "git am --reject xx.patch", and it's OK if

using "git cherry-pick commit_id", so I will rebase and repost it.

>> @@ -1949,17 +1972,19 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>>  	struct bpf_tramp_progs *fmod_ret = &tprogs[BPF_TRAMP_MODIFY_RETURN];
>>  	u8 **branches = NULL;
>>  	u8 *prog;
>> +	bool save_ret;
>>  
>>  	/* x86-64 supports up to 6 arguments. 7+ can be added in the future */
>>  	if (nr_args > 6)
>>  		return -ENOTSUPP;
>>  
>> -	if ((flags & BPF_TRAMP_F_RESTORE_REGS) &&
>> -	    (flags & BPF_TRAMP_F_SKIP_FRAME))
>> +	if (!is_valid_bpf_tramp_flags(flags))
>>  		return -EINVAL;
>>  
>> -	if (flags & BPF_TRAMP_F_CALL_ORIG)
>> -		stack_size += 8; /* room for return value of orig_call */
>> +	/* room for return value of orig_call or fentry prog */
>> +	save_ret = flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET);
>> +	if (save_ret)
>> +		stack_size += 8;
>>  
>>  	if (flags & BPF_TRAMP_F_SKIP_FRAME)
>   	^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 	
>>  		/* skip patched call instruction and point orig_call to actual
> .
