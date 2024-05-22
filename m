Return-Path: <bpf+bounces-30291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D3D8CC060
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 13:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DBB41C224B9
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 11:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9E682892;
	Wed, 22 May 2024 11:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W96hvT8j"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E1356B72;
	Wed, 22 May 2024 11:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716377886; cv=none; b=Xy/7OeacX2bng/FDOiIGZ98gZwLGwubaDMtC2slju0neMq4YgiWCDLGSKfFN25bzh0fgauwSgLbrgvGPRHXmH71R0uhlOJ1FlLpWnXuhZjqRxmluxQQ9irfYPPpHxlFmE6vQjokksFk5v4oSeVQqVHnTXfgdbiFXVY2cHvQ1tIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716377886; c=relaxed/simple;
	bh=j+W4GcZJGISa77lDIEBfrxFXmjiKU9BCqC2sLBGFabQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n+jToij07stIaBg40NI60QgTrxjCrFF8JCT3NU78ijVQmA8UDxZvTvIqEN8KkCCIIAPp6yzGdh4mKllncAuR+/slRQ2J+vaalucOZvN7JWIZUPOw2iW1MqBmNLLgkKhkuDvybabMHnWHEJzmlq+YGCap5RWIdp2ktAnID5fT2aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W96hvT8j; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44MBDjON004375;
	Wed, 22 May 2024 11:37:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=tLtkLaJdZcABEuKym7kQ0uGy5iDx/Mdabykmq2f/jnw=;
 b=W96hvT8jTsH9kRl7AZDQ+nNDpUDzk3m954evYLx301G0VZel/cWErybTqmIh4ProGWGl
 dQGcdL8jFGKIgGUASAYCTZ7hZO0u8ozgeeRAV59Kq1alfSomqiWWljVjpw0kAsLuY+qm
 kx6ExyANJdff/8Rabx0tg6D00oM+ElKLWGKD6v5MpOuAcFnJfMGHHxwJnefc26HsYlEZ
 or43uwWG/wGmzEX6dOP4WiLERsDhwCDVAUpv40AVhfgn0LN54wb2qKpGoiKn3l/RwJj8
 YmfcZrbj/fNx7mglqcfzEjUtC2AmXZIxrPlcZRRpgdu6YDXOcNad+J6xtS+nrVyNukBe cQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y9fmw022k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 11:37:36 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44MBbaA4009010;
	Wed, 22 May 2024 11:37:36 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y9fmw022f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 11:37:36 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44M8c9gK008090;
	Wed, 22 May 2024 11:37:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y79c338t2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 11:37:35 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44MBbVUM48693692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 11:37:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC51D2004B;
	Wed, 22 May 2024 11:37:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75D4120043;
	Wed, 22 May 2024 11:37:29 +0000 (GMT)
Received: from [9.203.115.195] (unknown [9.203.115.195])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 May 2024 11:37:29 +0000 (GMT)
Message-ID: <922473a0-7e74-45e8-9929-154d0590d124@linux.ibm.com>
Date: Wed, 22 May 2024 17:07:28 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] powerpc64/bpf: jit support for unconditional byte
 swap
To: Artem Savkov <asavkov@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240517075650.248801-1-asavkov@redhat.com>
 <20240517075650.248801-3-asavkov@redhat.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20240517075650.248801-3-asavkov@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: B1XldeUENKxGYq5S-5rVvIhGUSDaHHY-
X-Proofpoint-GUID: X_i3t_4zqRLlNLATCKOrtc6kfWhvOpTC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_05,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 mlxscore=0 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 clxscore=1011 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405220077



On 17/05/24 1:26 pm, Artem Savkov wrote:
> Add jit support for unconditional byte swap. Tested using BSWAP tests
> from test_bpf module.
> 
> Signed-off-by: Artem Savkov <asavkov@redhat.com>
> ---
>   arch/powerpc/net/bpf_jit_comp64.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index 3071205782b15..97191cf091bbf 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -699,11 +699,12 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
>   		 */
>   		case BPF_ALU | BPF_END | BPF_FROM_LE:
>   		case BPF_ALU | BPF_END | BPF_FROM_BE:

> +		case BPF_ALU64 | BPF_END | BPF_FROM_LE:

A comment here indicating this case does unconditional swap
could improve readability.

Other than this minor nit, the patchset looks good to me.
Also, tested the changes with test_bpf module and selftests.
For the series..

Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>

>   #ifdef __BIG_ENDIAN__
>   			if (BPF_SRC(code) == BPF_FROM_BE)
>   				goto emit_clear;
>   #else /* !__BIG_ENDIAN__ */
> -			if (BPF_SRC(code) == BPF_FROM_LE)
> +			if (BPF_CLASS(code) == BPF_ALU && BPF_SRC(code) == BPF_FROM_LE)
>   				goto emit_clear;
>   #endif
>   			switch (imm) {

