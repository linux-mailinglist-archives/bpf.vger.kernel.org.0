Return-Path: <bpf+bounces-70519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF76BC2249
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 18:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9ECF4F7077
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 16:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB002E7F11;
	Tue,  7 Oct 2025 16:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ILOV0jd0"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DCD2E62B1;
	Tue,  7 Oct 2025 16:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759855401; cv=none; b=FsCsxGGjCG/pGQShc4CPXhFWUe0DOX9tVsN9IKXb2QSm//Vn6ine/shgY5/JfiJiakhOEbJ8/hPrnMAqg5HWAMA/xPUJxlkRW8UnwCjolJS4O1OnCeBvH9fyR8IwZmolNm2J4u2GbdXUEH8U0sIbSCuoYzgmcRDsCt6zvDq+B3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759855401; c=relaxed/simple;
	bh=Jaz+/BZCqVxcqYDoHpP9Kj5r/09VltHAJQYFTSMdr9w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WAUfutVPSV7mddUpViSJwfkGGp5N2DLPAy9D+/7MZX4jTpVe7lqBadQhM6Ht7uMbx55+FyLFxLaF1PL0Xuuux8AFHvuRXWQtR4LmYH/29dbXSg7wtoOGqDBBmVV7PN3NipVGMH7nXB++CD0w/r0rKStYN6uz9ONYymoTxfiepWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ILOV0jd0; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 597Fq39e3928046;
	Tue, 7 Oct 2025 09:43:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=zzmjj3IqYxbJ3FZW9fNFsn2i9xeCEwlnVhm4zbtDAzM=; b=ILOV0jd093/R
	stWNwcG9zUZp6axVUg4kEiL7ZqdBUpUAS6qz5I/+95Wez1qCgrXe4Jg4NSNCQMxz
	ucR0wwo2WHKRnRHw2eMUcB58dzYbiNaQbqzY2ewst4wnx0BtuUOejb7DsrwEd33r
	74HDKgln5EzvCicgML30oWveRqgkns03PuZDTomTMr+7gnuFN1irm0l5mAVrYnr4
	bTHJKXgI2orb8d1TIcQxUfMjlxeQ9gQvVH6hSv2SARHeOai49gnqK3hxdnmNw4dG
	N2eJyH0SQNy3KmMZ1086UgjA0QC7DK11XYXTmQt2WGUROKzaMclJp7+uBOziaGXo
	pUZG6h/PkA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 49mx0ebw21-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 07 Oct 2025 09:43:01 -0700 (PDT)
Received: from devbig091.ldc1.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Tue, 7 Oct 2025 16:42:34 +0000
From: Chris Mason <clm@meta.com>
To: KP Singh <kpsingh@kernel.org>
CC: Chris Mason <clm@meta.com>, <bpf@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <bboscaccy@linux.microsoft.com>, <paul@paul-moore.com>,
        <kys@microsoft.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <syzbot@syzkaller.appspotmail.com>
Subject: Re: [PATCH bpf-next v7 1/5] bpf: Implement signature verification for BPF programs
Date: Tue, 7 Oct 2025 09:42:10 -0700
Message-ID: <20251007164217.1966541-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250921160120.9711-2-kpsingh@kernel.org>
References:
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 9lbpTvL3nYOlIO1UFZ3xafeUvuj14frt
X-Authority-Analysis: v=2.4 cv=SoGdKfO0 c=1 sm=1 tr=0 ts=68e54315 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=kxiUpit_5B_PL5oZeFQA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 9lbpTvL3nYOlIO1UFZ3xafeUvuj14frt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDEzMiBTYWx0ZWRfX9CNAHxvDFayD
 JyhwT8OrJByCG8/4WcUp70oj1VO65vQTDHoYW8ba2RPHtmeGJJ+HTsv1lw1pnOeyoNP2ePb4Fgh
 SJyOQ2nqFsTyTD5TDSoaNeNZTVKUNtvusdLdZOH7OUvS6e+w1UXKlvIwvC8/GWfzlfNhODe5b8o
 Yjb2fBWrMIPOW6p7YHPL/Sskg+so0S8X4wo1XuL5hi42BZ5UJ9Cs0NZ6oMkv3RIW5FbOBPMH6r8
 KylpuzGtrAXOQHZB7Xx34HjCfm0GDth16/ZllG3bP572E7VCq+C9A/MV+vU/+qzeUGemMmn3lj4
 juGxQTCyPzpuMQTEktLnnfo8iIazvTaJXFiYrg7l9HCCLL8z5CJD18DLUlzZCRJCCGd4KLe0ak/
 8wk6TIGHgmCY4ImtqI27ZzpJ1b0VJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01

Hi KP,

On Sun, 21 Sep 2025 18:01:16 +0200 KP Singh <kpsingh@kernel.org> wrote:

> This patch extends the BPF_PROG_LOAD command by adding three new fields
> to `union bpf_attr` in the user-space API:
> 
>   - signature: A pointer to the signature blob.
>   - signature_size: The size of the signature blob.
>   - keyring_id: The serial number of a loaded kernel keyring (e.g.,
>     the user or session keyring) containing the trusted public keys.
> 
> When a BPF program is loaded with a signature, the kernel:
> 
> 1.  Retrieves the trusted keyring using the provided `keyring_id`.
> 2.  Verifies the supplied signature against the BPF program's
>     instruction buffer.
> 3.  If the signature is valid and was generated by a key in the trusted
>     keyring, the program load proceeds.
> 4.  If no signature is provided, the load proceeds as before, allowing
>     for backward compatibility. LSMs can chose to restrict unsigned
>     programs and implement a security policy.
> 5.  If signature verification fails for any reason,
>     the program is not loaded.
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index cf7173b1bb83..8a3c3d26f6e2 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -39,6 +39,7 @@
>  #include <linux/tracepoint.h>
>  #include <linux/overflow.h>
>  #include <linux/cookie.h>
> +#include <linux/verification.h>
>  
>  #include <net/netfilter/nf_bpf_link.h>
>  #include <net/netkit.h>
> @@ -2785,8 +2786,44 @@ static bool is_perfmon_prog_type(enum bpf_prog_type prog_type)
>  	}
>  }
>  
> +static int bpf_prog_verify_signature(struct bpf_prog *prog, union bpf_attr *attr,
> +				     bool is_kernel)
> +{
> +	bpfptr_t usig = make_bpfptr(attr->signature, is_kernel);
> +	struct bpf_dynptr_kern sig_ptr, insns_ptr;
> +	struct bpf_key *key = NULL;
> +	void *sig;
> +	int err = 0;
> +
> +	if (system_keyring_id_check(attr->keyring_id) == 0)
> +		key = bpf_lookup_system_key(attr->keyring_id);
> +	else
> +		key = bpf_lookup_user_key(attr->keyring_id, 0);
> +
> +	if (!key)
> +		return -EINVAL;
> +
> +	sig = kvmemdup_bpfptr(usig, attr->signature_size);

Should there be some validation on signature_size?  It looks like we're
giving vmalloc exactly what userland sent.

-chris

