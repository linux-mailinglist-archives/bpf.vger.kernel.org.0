Return-Path: <bpf+bounces-64471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BD0B132F6
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 04:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC64D3B3728
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 02:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F23A19D8A8;
	Mon, 28 Jul 2025 02:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lWdz531I"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A733D984;
	Mon, 28 Jul 2025 02:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753669810; cv=none; b=C/Rh6RTv312ohb/jx4TPGnAO2Q3COq27/z/ETjA1mZ76moVqHrmcf1FGIYwMCNB7WlYoV3Ya/4knvb+9BuXUH5q6Px5O1HduX7PI4Egma8meSdOM/xSBQv/tz34S++B2jfanL8HgOqKuDhpuw3qpnc/Tr1eVc1ltA8RB4Tmx9RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753669810; c=relaxed/simple;
	bh=vOkJ1RzqHkoMiZ4cLBnYGI698brLIal+ciVpcz/ehuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V+HCFsjPfsoUP/oSdxNLBUjttCVsxTZAJKP8gbbSt19cdAP/9Uat1yr0Xw8eVGZ2nn+WRZ5zfpGy7QvNzvjeV7ULPwIcwyQpkFSkRi3Aqs+YvL6QSv8UpN5NLyp5dpBfYmG81jpRisXxXxZXB1T/wyu6/K1bNJqf2WjTOufKCzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lWdz531I; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56RKUAVs001988;
	Mon, 28 Jul 2025 02:29:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Udz1ZS
	L6XnQ4VlWJT3DNSHPYMWqsB+qvgEoKroxXnLQ=; b=lWdz531Iq6GRxFzQzLa23g
	kNETsBiDYdiITImnX2amSLUqljOH5HzWl0jdUAWRWLXgOq0gn66mmIc8qYEsvGEL
	T9dbf/zsvKSnPIJM4l2InG28L8Tt7wfXpSC+kIC7JoRs/Plqzaa17+eKqZoJpAod
	Ec9JlWT0yNKid4nW8pZy9RloUw7GxYzZa+zPSJKQGn5azXtRnS4o3G/Z5XkPl+rc
	zpNohXoVFalGV4uliRRNI0qkPGoH0zDeMPlgLS/IuYaeJTrNRczz9guaWI7Y/d2O
	j8j2Qh85D43AbLNGG0RM7M1mg5ZcEFTAx77u93mTS0pPDqnOQ79k9RpKtlMGoYGg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 485u6w0vrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 02:29:27 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 56S2TQwk031463;
	Mon, 28 Jul 2025 02:29:26 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 485u6w0vrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 02:29:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56S0tCPl015940;
	Mon, 28 Jul 2025 02:29:25 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 485aumbsj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 02:29:25 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56S2TOiF65339824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 02:29:24 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67D5C5804E;
	Mon, 28 Jul 2025 02:29:24 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D80545803F;
	Mon, 28 Jul 2025 02:29:13 +0000 (GMT)
Received: from [9.39.20.72] (unknown [9.39.20.72])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Jul 2025 02:29:13 +0000 (GMT)
Message-ID: <352e0ea6-7a35-4617-ad6e-34e102061732@linux.ibm.com>
Date: Mon, 28 Jul 2025 07:59:12 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND bpf-next 1/1] powerpc64/bpf: Add jit support for
 load_acquire and store_release
To: Daniel Borkmann <daniel@iogearbox.net>,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>, puranjay@kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin
 <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Naveen N Rao <naveen@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        Peilin Ye <yepeilin@google.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>,
        lkmm@lists.linux.dev
References: <20250717202935.29018-1-puranjay@kernel.org>
 <20250717202935.29018-2-puranjay@kernel.org> <mb61pfreuy1rm.fsf@kernel.org>
 <aIIKo39dK22ew1T5@linux.ibm.com>
 <c3eff304-8dd3-418d-afa9-eaf91020c535@iogearbox.net>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <c3eff304-8dd3-418d-afa9-eaf91020c535@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=K4siHzWI c=1 sm=1 tr=0 ts=6886e087 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=MP_mQu3T_XVgOpPGKvUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDAxNiBTYWx0ZWRfX2mgFZC7txfAK
 5F2sw3GKUp0JDsfdxssKlJ2eh8q+Ech4RYeGciHEWo1/UQUmv8K2FK2IbB0ACnJ6zUWHrZoHqoc
 OrgTGwHRjUknDttIKCLcjd2YeIJjgL0Nw8FTIb5Zk8UnqC6oUPz6CQTQg1Gf/I82ETY8wAekqPM
 OEBYOJsW5QcTiTHwq4m5jc0a4JewbYvGUEvr8mkXXGwv9aA/d/QHJupoMlqjWKGHNc/kNppqDtn
 AzBssJrLEXHaKW9hIuTrM6KTYC4F6AT/lk/uvCuRsgS071eDSP4aJTEVD1A417YpBLVUXl7Oi+5
 HAIZtLSA1mpXJ1+0eQisnI8XwIsk91f9X9xytBDsA6KX9I003y2vI3OySid+Tg+hqA9L0e2av3A
 KPeQvPx5hj2KDzPKIae7yDwwALSWzaA3gLoerMkjONO9qacDDrY92PC5LfJ20xS+YwD1H2ak
X-Proofpoint-ORIG-GUID: VH9OaA3fh2bI9vlvx6XDQ7FAuZtsLfMa
X-Proofpoint-GUID: RGmbb0kq1z6B8SdZiVqdBiwpyELLQwWo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_01,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 mlxlogscore=909
 phishscore=0 suspectscore=0 spamscore=0 clxscore=1011 mlxscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280016



On 7/27/25 10:59 PM, Daniel Borkmann wrote:
> On 7/24/25 12:27 PM, Saket Kumar Bhaskar wrote:
> [...]
>> Thanks for the patch. I applied the patch and tested it.
>>
>> Before this patch:
>>
>> # ./test_progs -a \
>>    verifier_load_acquire,verifier_store_release,atomics
>> #11/1    atomics/add:OK
>> #11/2    atomics/sub:OK
>> #11/3    atomics/and:OK
>> #11/4    atomics/or:OK
>> #11/5    atomics/xor:OK
>> #11/6    atomics/cmpxchg:OK
>> #11/7    atomics/xchg:OK
>> #11      atomics:OK
>> #528/1   verifier_load_acquire/Clang version < 18, ENABLE_ATOMICS_TESTS not defined, and/or JIT doesn't support load-acquire, use a dummy test:OK
>> #528     verifier_load_acquire:OK
>> #565/1   verifier_store_release/Clang version < 18, ENABLE_ATOMICS_TESTS not defined, and/or JIT doesn't support store-release, use a dummy test:OK
>> #565     verifier_store_release:OK
>> Summary: 3/9 PASSED, 0 SKIPPED, 0 FAILED
>>
>> After this patch:
>>
>> # ./test_progs -a \
>>    verifier_load_acquire,verifier_store_release,atomics
>> #11/1    atomics/add:OK
>> #11/2    atomics/sub:OK
>> #11/3    atomics/and:OK
>> #11/4    atomics/or:OK
>> #11/5    atomics/xor:OK
>> #11/6    atomics/cmpxchg:OK
>> #11/7    atomics/xchg:OK
>> #11      atomics:OK
>> #529/1   verifier_load_acquire/load-acquire, 8-bit:OK
>> #529/2   verifier_load_acquire/load-acquire, 8-bit @unpriv:OK
>> #529/3   verifier_load_acquire/load-acquire, 16-bit:OK
>> #529/4   verifier_load_acquire/load-acquire, 16-bit @unpriv:OK
>> #529/5   verifier_load_acquire/load-acquire, 32-bit:OK
>> #529/6   verifier_load_acquire/load-acquire, 32-bit @unpriv:OK
>> #529/7   verifier_load_acquire/load-acquire, 64-bit:OK
>> #529/8   verifier_load_acquire/load-acquire, 64-bit @unpriv:OK
>> #529/9   verifier_load_acquire/load-acquire with uninitialized src_reg:OK
>> #529/10  verifier_load_acquire/load-acquire with uninitialized src_reg @unpriv:OK
>> #529/11  verifier_load_acquire/load-acquire with non-pointer src_reg:OK
>> #529/12  verifier_load_acquire/load-acquire with non-pointer src_reg @unpriv:OK
>> #529/13  verifier_load_acquire/misaligned load-acquire:OK
>> #529/14  verifier_load_acquire/misaligned load-acquire @unpriv:OK
>> #529/15  verifier_load_acquire/load-acquire from ctx pointer:OK
>> #529/16  verifier_load_acquire/load-acquire from ctx pointer @unpriv:OK
>> #529/17  verifier_load_acquire/load-acquire with invalid register R15:OK
>> #529/18  verifier_load_acquire/load-acquire with invalid register R15 @unpriv:OK
>> #529/19  verifier_load_acquire/load-acquire from pkt pointer:OK
>> #529/20  verifier_load_acquire/load-acquire from flow_keys pointer:OK
>> #529/21  verifier_load_acquire/load-acquire from sock pointer:OK
>> #529     verifier_load_acquire:OK
>> #566/1   verifier_store_release/store-release, 8-bit:OK
>> #566/2   verifier_store_release/store-release, 8-bit @unpriv:OK
>> #566/3   verifier_store_release/store-release, 16-bit:OK
>> #566/4   verifier_store_release/store-release, 16-bit @unpriv:OK
>> #566/5   verifier_store_release/store-release, 32-bit:OK
>> #566/6   verifier_store_release/store-release, 32-bit @unpriv:OK
>> #566/7   verifier_store_release/store-release, 64-bit:OK
>> #566/8   verifier_store_release/store-release, 64-bit @unpriv:OK
>> #566/9   verifier_store_release/store-release with uninitialized src_reg:OK
>> #566/10  verifier_store_release/store-release with uninitialized src_reg @unpriv:OK
>> #566/11  verifier_store_release/store-release with uninitialized dst_reg:OK
>> #566/12  verifier_store_release/store-release with uninitialized dst_reg @unpriv:OK
>> #566/13  verifier_store_release/store-release with non-pointer dst_reg:OK
>> #566/14  verifier_store_release/store-release with non-pointer dst_reg @unpriv:OK
>> #566/15  verifier_store_release/misaligned store-release:OK
>> #566/16  verifier_store_release/misaligned store-release @unpriv:OK
>> #566/17  verifier_store_release/store-release to ctx pointer:OK
>> #566/18  verifier_store_release/store-release to ctx pointer @unpriv:OK
>> #566/19  verifier_store_release/store-release, leak pointer to stack:OK
>> #566/20  verifier_store_release/store-release, leak pointer to stack @unpriv:OK
>> #566/21  verifier_store_release/store-release, leak pointer to map:OK
>> #566/22  verifier_store_release/store-release, leak pointer to map @unpriv:OK
>> #566/23  verifier_store_release/store-release with invalid register R15:OK
>> #566/24  verifier_store_release/store-release with invalid register R15 @unpriv:OK
>> #566/25  verifier_store_release/store-release to pkt pointer:OK
>> #566/26  verifier_store_release/store-release to flow_keys pointer:OK
>> #566/27  verifier_store_release/store-release to sock pointer:OK
>> #566     verifier_store_release:OK
>> Summary: 3/55 PASSED, 0 SKIPPED, 0 FAILED
>>
>> Tested-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> 
> Michael/Madhavan, I presume you'll pick this patch up?
> 

yes, Will do.

Thanks
Maddy

> Thanks,
> Daniel


