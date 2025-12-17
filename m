Return-Path: <bpf+bounces-76816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E98AECC603A
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 06:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9FDE3029BB3
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 05:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF8E262FFC;
	Wed, 17 Dec 2025 05:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TRumAIMB"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC403A1E8C;
	Wed, 17 Dec 2025 05:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765948390; cv=none; b=t3dgMLTgdw25xT8wSLS6blKF0ocvPPjSi9qbn5zmo7G6rNmEpRbqPF9Bx93BAIvJZjeyIBNzJV+FdAWzdM/BjPwZYCNXM0Zub11DzCitdv05WpHvZKUCv+fqolpQTQFKJM85adXdxbAVuwztHKA3Brkd7kb645Rk+9MZpdR3k9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765948390; c=relaxed/simple;
	bh=/0i0OSMpVT2hIQGn7G6i/W93lOrcUvZjd9FBlfJpkh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RhfVdky2vLSUhjJUs9JZ//NtEAVDp1i8DTJoH4ElLwPHBBPcnWNVLi+7/3DWN8tnuG1KvxRdLFfMMMgs35QSkdiMWO+jXU00UQHIJa8Hq1TPWmvvKLqqf003MwBrZxzrjQNbrWw+ps3gIydF5UmjXqwgoQiPFYNM/9HZBsLsm8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TRumAIMB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGL1gUu026434;
	Wed, 17 Dec 2025 05:12:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AnESU7
	T2SRFYil9p+DeIoI/bwHRwyGoGhxfQBvRLIpU=; b=TRumAIMBIHGnep8uFYoONy
	8NTUw/GI9SDarudESiPfyw9BpXCQZ9xVrOokZL0ii6ufU+ggiB7So74AlL+YN2hF
	LeDpAQySQsyKM31YuvvK1poyV6QksMIfagi2Zhm56bLEXFa7E5gEbgNAgnI9gQwB
	BJLqjUFzaHN+GYjObW6h9xQWut4KN6108wq5rFnRUetnqmC8MMgpeXHE+iEy62c8
	o7LGovl+nrPi4/GJqCgsN55E1271XI4JdoweHYXwlBiW2s2ikKMmUmiuSI3ccvZ0
	HcU6gF6c1sogbNw4B6rsOlTDdmb8jVu/NZuxhRr5Mmdnb/yOhMIO1DakU73wzcCA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yn8k5n9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 05:12:21 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BH5CKu7013342;
	Wed, 17 Dec 2025 05:12:20 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yn8k5n4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 05:12:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BH35pQi002976;
	Wed, 17 Dec 2025 05:12:19 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b1kykrbur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 05:12:19 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BH5CFQ947251868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 05:12:15 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFFC720043;
	Wed, 17 Dec 2025 05:12:14 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 265E320040;
	Wed, 17 Dec 2025 05:12:11 +0000 (GMT)
Received: from [9.109.222.214] (unknown [9.109.222.214])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Dec 2025 05:12:10 +0000 (GMT)
Message-ID: <a8345e11-d0b4-4000-9f2c-b02f01c8df44@linux.ibm.com>
Date: Wed, 17 Dec 2025 10:42:10 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 2/2] powerpc64/bpf: Inline
 bpf_get_smp_processor_id() and bpf_get_current_task/_btf()
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: sachinpb@linux.ibm.com, venkat88@linux.ibm.com, andrii@kernel.org,
        eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
        haoluo@google.com, jolsa@kernel.org, christophe.leroy@csgroup.eu,
        naveen@kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com
References: <cover.1765343385.git.skb99@linux.ibm.com>
 <89abfdd6f6721fbe7897865e74f2f691e5f7824a.1765343385.git.skb99@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <89abfdd6f6721fbe7897865e74f2f691e5f7824a.1765343385.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAxOCBTYWx0ZWRfX3mb8lah68yaY
 CBtzFRGOzfDPyxHJEx5BaYo5pv/8V/rUXZfqL94DiW7BMgXqZf0idoXWvam6rmIhW72/SF8N5FL
 8vdrE7E1KAhvQdY2rSJKBpBX+gEXaf5AqraeS5Q46AbWj9nYLSfyDyWvdyY6kQKNjcC6+HdDZ0/
 pFC+/DH3lyhulf1MoLimdEoelGM4qd1oxGieFn9NUs7kkd7pjTbYnDtwte2opQBccbZBujz/W58
 Nt+9W7hDRaZZFstBTu7LyFyrOA1ttcdnP86VRp78JfvzCMSjWUwvDhuIUxWtarbqxmBhB0X/H+j
 Hpli29y3uf4jKbPEe2kBJVsp7KHFKO5r30iVsxhXxMiJeQO5SpLL8MpKPRBza4i5Ecv/DEEtpvz
 nC1w7XUyXQ0yCEf5CjvAQacCsGtqPA==
X-Proofpoint-GUID: Y-kpQC9UTbw1JdLIk6nmtGVNGd8K9mFq
X-Proofpoint-ORIG-GUID: WV4EmMHsCkRlKqMhvUjCFXhos04Kvy5J
X-Authority-Analysis: v=2.4 cv=LbYxKzfi c=1 sm=1 tr=0 ts=69423bb5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=PRnckvQuzlTHD8o7MjgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 clxscore=1011 suspectscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2512130018



On 10/12/25 12:20 pm, Saket Kumar Bhaskar wrote:
> Inline the calls to bpf_get_smp_processor_id() and bpf_get_current_task/_btf()
> in the powerpc bpf jit.
> 
> powerpc saves the Logical processor number (paca_index) and pointer
> to current task (__current) in paca.
> 
> Here is how the powerpc JITed assembly changes after this commit:
> 
> Before:
> 
> cpu = bpf_get_smp_processor_id();
> 
> addis 12, 2, -517
> addi 12, 12, -29456
> mtctr 12
> bctrl
> mr	8, 3
> 
> After:
> 
> cpu = bpf_get_smp_processor_id();
> 
> lhz 8, 8(13)
> 
> To evaluate the performance improvements introduced by this change,
> the benchmark described in [1] was employed.
> 
> +---------------+-------------------+-------------------+--------------+
> |      Name     |      Before       |        After      |   % change   |
> |---------------+-------------------+-------------------+--------------|
> | glob-arr-inc  | 40.701 ± 0.008M/s | 55.207 ± 0.021M/s |   + 35.64%   |
> | arr-inc       | 39.401 ± 0.007M/s | 56.275 ± 0.023M/s |   + 42.42%   |
> | hash-inc      | 24.944 ± 0.004M/s | 26.212 ± 0.003M/s |   +  5.08%   |
> +---------------+-------------------+-------------------+--------------+
> 
> [1] https://github.com/anakryiko/linux/commit/8dec900975ef
> 

Looks good.

Acked-by: Hari Bathini <hbathini@linux.ibm.com>


> Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> ---
>   arch/powerpc/net/bpf_jit_comp.c   | 12 ++++++++++++
>   arch/powerpc/net/bpf_jit_comp64.c | 11 +++++++++++
>   2 files changed, 23 insertions(+)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index d53e9cd7563f..b243ee205885 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -471,6 +471,18 @@ bool bpf_jit_supports_percpu_insn(void)
>   	return IS_ENABLED(CONFIG_PPC64);
>   }
>   
> +bool bpf_jit_inlines_helper_call(s32 imm)
> +{
> +	switch (imm) {
> +	case BPF_FUNC_get_smp_processor_id:
> +	case BPF_FUNC_get_current_task:
> +	case BPF_FUNC_get_current_task_btf:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>   void *arch_alloc_bpf_trampoline(unsigned int size)
>   {
>   	return bpf_prog_pack_alloc(size, bpf_jit_fill_ill_insns);
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index 37723ee9344e..6c827e7aa691 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -1400,6 +1400,17 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
>   		case BPF_JMP | BPF_CALL:
>   			ctx->seen |= SEEN_FUNC;
>   
> +			if (src_reg == bpf_to_ppc(BPF_REG_0)) {
> +				if (imm == BPF_FUNC_get_smp_processor_id) {
> +					EMIT(PPC_RAW_LHZ(src_reg, _R13, offsetof(struct paca_struct, paca_index)));
> +					break;
> +				} else if (imm == BPF_FUNC_get_current_task ||
> +					   imm == BPF_FUNC_get_current_task_btf) {
> +					EMIT(PPC_RAW_LD(src_reg, _R13, offsetof(struct paca_struct, __current)));
> +					break;
> +				}
> +			}
> +
>   			ret = bpf_jit_get_func_addr(fp, &insn[i], extra_pass,
>   						    &func_addr, &func_addr_fixed);
>   			if (ret < 0)


