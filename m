Return-Path: <bpf+bounces-15096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DE07EC755
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 16:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0E791F27A0A
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 15:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D771639FD3;
	Wed, 15 Nov 2023 15:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k6s60LlQ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CC039FCB
	for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 15:32:14 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C65B101;
	Wed, 15 Nov 2023 07:32:13 -0800 (PST)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFEfF0O011444;
	Wed, 15 Nov 2023 15:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=2uJLotgHlgRxURd3rERlYjhkdxIcci9sSwCopdFTe8E=;
 b=k6s60LlQvbHpPw0eqTHAJoytxj70tPfJZnSCNeojLzNXE9SEzHyVQsApf2skIGi1VXAE
 81mwSXH1aS5qJp23xYMVQRvia+Pr+lDq5d5Ni7lNv1/xz/uUqj7q8PhmmKvPfxcbQeQh
 4DVvjIpq8KFuAq9HkrFm7HZ12uXf0CNnfnYp7z9xL6gXEYQOm28ur9xfiyTf7cIMTugR
 X6fVYGh0MEXr2smneLaWLa63oYbsZz1Sz/0BjBnmWZP77V8tm0HB2iavGhvNyFlAb9w6
 jyXA6rIO/srImblF3za0opJs+wV/q1ktZ11e3/urynvZ7Gkx+Kpu30ij+kZmnfJpQ7yB Vg== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucyydhqnd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Nov 2023 15:31:49 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFDn75l028114;
	Wed, 15 Nov 2023 15:31:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uap5k7pp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Nov 2023 15:31:48 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AFFVeT924052472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Nov 2023 15:31:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 51B7020040;
	Wed, 15 Nov 2023 15:31:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2532D20043;
	Wed, 15 Nov 2023 15:31:40 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 15 Nov 2023 15:31:40 +0000 (GMT)
Date: Wed, 15 Nov 2023 16:31:39 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Marc Hartmayer <mhartmay@linux.ibm.com>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 01/13] bpf: Add support for non-fix-size
 percpu mem allocation
Message-ID: <20231115153139.29313-A-hca@linux.ibm.com>
References: <20230827152729.1995219-1-yonghong.song@linux.dev>
 <20230827152734.1995725-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230827152734.1995725-1-yonghong.song@linux.dev>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hit-Dxdf9_l1zixbimsevOL6HlZJoFLn
X-Proofpoint-ORIG-GUID: hit-Dxdf9_l1zixbimsevOL6HlZJoFLn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_13,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1011 impostorscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 mlxlogscore=949
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150115

On Sun, Aug 27, 2023 at 08:27:34AM -0700, Yonghong Song wrote:
> This is needed for later percpu mem allocation when the
> allocation is done by bpf program. For such cases, a global
> bpf_global_percpu_ma is added where a flexible allocation
> size is needed.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  include/linux/bpf.h   |  4 ++--
>  kernel/bpf/core.c     |  8 +++++---
>  kernel/bpf/memalloc.c | 14 ++++++--------
>  3 files changed, 13 insertions(+), 13 deletions(-)

Both Marc and Mikhail reported out-of-memory conditions on s390 machines,
and bisected it down to this upstream commit 41a5db8d8161 ("bpf: Add
support for non-fix-size percpu mem allocation").
This seems to eat up a lot of memory only based on the number of possible
CPUs.

If we have a machine with 8GB, 6 present CPUs and 512 possible CPUs (yes,
this is a realistic scenario) the memory consumption directly after boot
is:

$ cat /sys/devices/system/cpu/present
0-5
$ cat /sys/devices/system/cpu/possible
0-511

Before this commit:

$ cat /proc/meminfo
MemTotal:        8141924 kB
MemFree:         7639872 kB

With this commit

$ cat /proc/meminfo
MemTotal:        8141924 kB
MemFree:         4852248 kB

So, this appears to be a significant regression.
I'm quoting the rest of the original patch below for reference only.

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 12596af59c00..144dbddf53bd 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -55,8 +55,8 @@ struct cgroup;
>  extern struct idr btf_idr;
>  extern spinlock_t btf_idr_lock;
>  extern struct kobject *btf_kobj;
> -extern struct bpf_mem_alloc bpf_global_ma;
> -extern bool bpf_global_ma_set;
> +extern struct bpf_mem_alloc bpf_global_ma, bpf_global_percpu_ma;
> +extern bool bpf_global_ma_set, bpf_global_percpu_ma_set;
>  
>  typedef u64 (*bpf_callback_t)(u64, u64, u64, u64, u64);
>  typedef int (*bpf_iter_init_seq_priv_t)(void *private_data,
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 0f8f036d8bd1..95599df82ee4 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -64,8 +64,8 @@
>  #define OFF	insn->off
>  #define IMM	insn->imm
>  
> -struct bpf_mem_alloc bpf_global_ma;
> -bool bpf_global_ma_set;
> +struct bpf_mem_alloc bpf_global_ma, bpf_global_percpu_ma;
> +bool bpf_global_ma_set, bpf_global_percpu_ma_set;
>  
>  /* No hurry in this branch
>   *
> @@ -2921,7 +2921,9 @@ static int __init bpf_global_ma_init(void)
>  
>  	ret = bpf_mem_alloc_init(&bpf_global_ma, 0, false);
>  	bpf_global_ma_set = !ret;
> -	return ret;
> +	ret = bpf_mem_alloc_init(&bpf_global_percpu_ma, 0, true);
> +	bpf_global_percpu_ma_set = !ret;
> +	return !bpf_global_ma_set || !bpf_global_percpu_ma_set;
>  }
>  late_initcall(bpf_global_ma_init);
>  #endif
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index 9c49ae53deaf..cb60445de98a 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -499,15 +499,16 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
>  	struct obj_cgroup *objcg = NULL;
>  	int cpu, i, unit_size, percpu_size = 0;
>  
> +	/* room for llist_node and per-cpu pointer */
> +	if (percpu)
> +		percpu_size = LLIST_NODE_SZ + sizeof(void *);
> +
>  	if (size) {
>  		pc = __alloc_percpu_gfp(sizeof(*pc), 8, GFP_KERNEL);
>  		if (!pc)
>  			return -ENOMEM;
>  
> -		if (percpu)
> -			/* room for llist_node and per-cpu pointer */
> -			percpu_size = LLIST_NODE_SZ + sizeof(void *);
> -		else
> +		if (!percpu)
>  			size += LLIST_NODE_SZ; /* room for llist_node */
>  		unit_size = size;
>  
> @@ -527,10 +528,6 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
>  		return 0;
>  	}
>  
> -	/* size == 0 && percpu is an invalid combination */
> -	if (WARN_ON_ONCE(percpu))
> -		return -EINVAL;
> -
>  	pcc = __alloc_percpu_gfp(sizeof(*cc), 8, GFP_KERNEL);
>  	if (!pcc)
>  		return -ENOMEM;
> @@ -543,6 +540,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
>  			c = &cc->cache[i];
>  			c->unit_size = sizes[i];
>  			c->objcg = objcg;
> +			c->percpu_size = percpu_size;
>  			c->tgt = c;
>  			prefill_mem_cache(c, cpu);
>  		}
> -- 
> 2.34.1
> 

