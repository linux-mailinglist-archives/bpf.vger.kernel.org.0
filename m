Return-Path: <bpf+bounces-18064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F13DF81562B
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 02:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21D091C24870
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 01:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0ABF1875;
	Sat, 16 Dec 2023 01:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TUAwfwJs"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082A515494
	for <bpf@vger.kernel.org>; Sat, 16 Dec 2023 01:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BG0gSZ9004047;
	Sat, 16 Dec 2023 01:56:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=CpD0g9Xlqth/N8sJ3jdOMRaSKKDxSul2AIDCmdvFfA4=;
 b=TUAwfwJsJCmuIBzJ072w8do1W7NWQk193N0uI5N8VDkTYw64aGPYJI24lj29gQsFlbnK
 qpKn2e0G2GDEWXrn3mUxIJ7S5oQO8nENRJQHXbIO5C9VEeqBpcqWFgO9Ekdgf1pdfw+A
 CoMJ2VTuqjFeaZQnfG5+aZWk0xLOvbSecwb7mLSegr3tSWxoaKlkKuJJdOCMFlQFtKpV
 4MO73kllzrSWAqKP7Zv9TCKBQmrKUwXzOM1w8RaGb8E5kthk1+IARBMQDKkf7wDBF6wr
 6H9zntc2tftObSYGIhPQpUJEd9smDgBSBBlJKTy0KqIPS5uMwOaPtFdkkEq5CDB1wgMk oA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v11k71971-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 01:56:30 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BG1lh5N017373;
	Sat, 16 Dec 2023 01:56:30 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v11k7196j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 01:56:30 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFMoORh005066;
	Sat, 16 Dec 2023 01:56:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw4sm3vt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 01:56:29 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BG1uRf358786128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Dec 2023 01:56:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF3CA20043;
	Sat, 16 Dec 2023 01:56:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64A1A20040;
	Sat, 16 Dec 2023 01:56:27 +0000 (GMT)
Received: from heavy (unknown [9.171.70.156])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat, 16 Dec 2023 01:56:27 +0000 (GMT)
Date: Sat, 16 Dec 2023 02:56:25 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: andrii@kernel.org, daniel@iogearbox.net, peterz@infradead.org,
        martin.lau@kernel.org, bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next] s390/bpf: Fix indirect trampoline generation
Message-ID: <rcozfumr3cg2rsvth7d4e2tash7vqrbumddoina2ivqlftyo7b@inoaz3nkvojq>
References: <20231216004549.78355-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231216004549.78355-1-alexei.starovoitov@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3EYlmFU6M4IIbQxdWZDKPdCnnl2_kCeC
X-Proofpoint-GUID: 1ChskPT0gk7d_-zQZlM5-_1DwtX9SOhC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-16_01,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 mlxlogscore=520 spamscore=0 suspectscore=0 clxscore=1011
 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312160012

On Fri, Dec 15, 2023 at 04:45:49PM -0800, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> The func_addr used to be NULL for indirect trampolines used by struct_ops.
> Now func_addr is a valid function pointer.
> Hence use BPF_TRAMP_F_INDIRECT flag to detect such condition.
> 
> Fixes: 2cd3e3772e41 ("x86/cfi,bpf: Fix bpf_struct_ops CFI")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  arch/s390/net/bpf_jit_comp.c               | 3 ++-
>  tools/testing/selftests/bpf/DENYLIST.s390x | 2 --
>  2 files changed, 2 insertions(+), 3 deletions(-)

IIUC F_INDIRECT trampolines are called via C function pointers, and
func_addr does not participate in any call chains, but is rather used
as a source of CFI information. So returning to %r14 is the right
thing to do.

Thanks!

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

