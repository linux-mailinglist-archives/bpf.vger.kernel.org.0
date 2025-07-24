Return-Path: <bpf+bounces-64245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C2AB107C6
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 12:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2689916845A
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 10:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B42E264636;
	Thu, 24 Jul 2025 10:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gpCF89wS"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2721553A3;
	Thu, 24 Jul 2025 10:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753352921; cv=none; b=iNWxIoTPAk7bsCgYrzOKPi2tfmXCVP2WqeG/yCHg54zDD/YZfpFkrCnpgZGZfNPVZrAgEFThGB0Hyt0eQnMBHvmj3ayoqQ31Woc1h7mKzZiYvXUkjuphA16RECRKKxfhYuvMxYLBDMem0TJQRFIGi/bI8+nCsChPZUc9pdzEjdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753352921; c=relaxed/simple;
	bh=jj/0BmB+B8j3Zeuc2p8c35sBALxZfgn/rN0S8ORXtHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tI6apBHMHs0nGNu7xQurwSbVVeXeidsIl1HIavNaTED/Io/gTPbyZUEPzP/E/P/VY0d8DYr4kitSVG7YZyX1NV5S68ClAo43Wd0stGpTf1O6/+ilAvv2xVsdtXL1/PeJWWFAGoHpRAUWfsFl28iubxWFuT9cufTx8/qlDcqXVUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gpCF89wS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O903hn013613;
	Thu, 24 Jul 2025 10:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=IW0OO2vbd7Yt+fVJKmVhfh+MRawsOK
	Z3s7Mh1qAcyUk=; b=gpCF89wSWC5hCyJ1x0NbaDxcFY5KNtRIh3h4BZXnjehhHi
	ScuSrt1eUF4PNn0VPc4pAlez8/1bJBcUDGFIHofsXl7iVepayUu3LmKYxkvjbMnh
	MdmWbpjDgtj70maJD1eUAo2SflIjJcJR3zAm01zCdEK/ekmU5wzns9AjH2Gny1y0
	1wkQaqjCLFKZTTdRvr0m3t65RiYclvV4NhsgvlPqoeqWBLk1SonB26kWzXBNYwkS
	3ldVdDbvXm7/ZXHGfNcHL48sgcwMj7LzuhgMFqOlge0921AZ9zPyL7tlMU5fxpJ0
	DIpxJFpgZQb1clEBaPTKFUqufTAGLbGnBnjStD3g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ffqj32v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 10:28:00 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56OARxo7007806;
	Thu, 24 Jul 2025 10:27:59 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ffqj32q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 10:27:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56O8Z3F8024744;
	Thu, 24 Jul 2025 10:27:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 480rd2kuhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 10:27:58 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56OARscI57540936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 10:27:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A483E2004D;
	Thu, 24 Jul 2025 10:27:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0672220040;
	Thu, 24 Jul 2025 10:27:50 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.109.219.153])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 24 Jul 2025 10:27:49 +0000 (GMT)
Date: Thu, 24 Jul 2025 15:57:47 +0530
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: puranjay@kernel.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
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
Subject: Re: [PATCH RESEND bpf-next 1/1] powerpc64/bpf: Add jit support for
 load_acquire and store_release
Message-ID: <aIIKo39dK22ew1T5@linux.ibm.com>
References: <20250717202935.29018-1-puranjay@kernel.org>
 <20250717202935.29018-2-puranjay@kernel.org>
 <mb61pfreuy1rm.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mb61pfreuy1rm.fsf@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA3NSBTYWx0ZWRfXwpYsStwbaguj
 MLZnE4B8pwCWmnyqwfAGsygQ+k4ngWMHO3Q2qMwk5h0bZKOxXabjEm3imY4Pl6LK+0JNlmHmiUX
 RUoy3aCHkx2KfDTjP0VJ5DeqdPxAdnMJSe2Mp6lhv4ez6JqiFRcXRmuEr2Pnz+fJola8W7wni2l
 LA9mBjOvse+z7yZQmT2FtPFgSpV2AB+ucLB2T2dVxG5oIt7tMrvBwUBNp18I5WqAyAcLBXw3ws3
 y4QupxIw7Ckle3Wj601Kv0UbNJExe++xybZHYrGLQyXo3SyemDHUbMOMTTgZajiTIWkWte9q+WI
 l3mr40WiB7Mlgh1M5gDLgaIN12/ubHSK5KRnrNsq9ul/Ut1a3tiF7UrN0hrimYKlDOUIR/PUmCQ
 rfUlGtbl0cRbARFhv4dLWshPkvbxh1tw3F6mDRJCri6NRGsxBQ6IoXkhngCqURLj8SVSzYAn
X-Proofpoint-ORIG-GUID: hsfdS3Djti54WQWz0Goe9_004e2_6AhU
X-Proofpoint-GUID: 14fYURJF-xzHmQylf5GWj7RKAYiVY2n2
X-Authority-Analysis: v=2.4 cv=eqvfzppX c=1 sm=1 tr=0 ts=68820ab0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=ilFHw0CSd9IqsmPWPxAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 clxscore=1011 suspectscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240075

On Thu, Jul 17, 2025 at 08:56:45PM +0000, puranjay@kernel.org wrote:
> Puranjay Mohan <puranjay@kernel.org> writes:
> 
> Somehow the cover letter for this patch was missed, adding it here:
> 
> To test the functionality of these special instructions, a tool called
> blitmus[0] was used to convert the following baseline litmus test[1] to bpf
> programs:
> 
>  C MP+poonceonces
> 
>  (*
>   * Result: Sometimes
>   *
>   * Can the counter-intuitive message-passing outcome be prevented with
>   * no ordering at all?
>   *)
> 
>  {}
> 
>  P0(int *buf, int *flag)
>  {
>          WRITE_ONCE(*buf, 1);
>          WRITE_ONCE(*flag, 1);
>  }
> 
>  P1(int *buf, int *flag)
>  {
>          int r0;
>          int r1;
> 
>          r0 = READ_ONCE(*flag);
>          r1 = READ_ONCE(*buf);
>  }
> 
>  exists (1:r0=1 /\ 1:r1=0) (* Bad outcome. *)
> 
> Running the generated bpf program shows that the bad outcome is possible on
> powerpc:
> 
>  [fedora@linux-kernel blitmus]$ sudo ./mp_poonceonces
>  Starting litmus test with configuration:
>    Test: MP+poonceonces
>    Iterations: 4100
> 
>  Test MP+poonceonces Allowed
>  Histogram (4 states)
>  21548375 :>1:r0=0; 1:r1=0;
>  301187   :>1:r0=0; 1:r1=1;
>  337147   *>1:r0=1; 1:r1=0;
>  18813291 :>1:r0=1; 1:r1=1;
>  Ok
> 
>  Witnesses
>  Positive: 337147, Negative: 40662853
>  Condition exists (1:r0=1 /\ 1:r1=0) is validated
>  Observation MP+poonceonces Sometimes 337147 40662853
>  Time MP+poonceonces 13.48
> 
>  Thu Jul 17 18:12:51 UTC
> 
> Now the second write and the first read is converted to store_release and
> load_acquire and it gives us the following litmus test[2]
> 
>  C MP+pooncerelease+poacquireonce
> 
>  (*
>   * Result: Never
>   *
>   * This litmus test demonstrates that smp_store_release() and
>   * smp_load_acquire() provide sufficient ordering for the message-passing
>   * pattern.
>   *)
> 
>  {}
> 
>  P0(int *buf, int *flag)
>  {
>          WRITE_ONCE(*buf, 1);
>          smp_store_release(flag, 1);
>  }
> 
>  P1(int *buf, int *flag)
>  {
>          int r0;
>          int r1;
> 
>          r0 = smp_load_acquire(flag);
>          r1 = READ_ONCE(*buf);
>  }
> 
>  exists (1:r0=1 /\ 1:r1=0) (* Bad outcome. *)
> 
> 
> Running the generated bpf program shows that the bad outcome is *not* possible
> on powerpc with the implementation in this patch:
> 
>  [fedora@linux-kernel blitmus]$ sudo ./mp_pooncerelease_poacquireonce
>  Starting litmus test with configuration:
>    Test: MP+pooncerelease+poacquireonce
>    Iterations: 4100
> 
>  Test MP+pooncerelease+poacquireonce Allowed
>  Histogram (3 states)
>  21036021 :>1:r0=0; 1:r1=0;
>  14488694 :>1:r0=0; 1:r1=1;
>  5475285  :>1:r0=1; 1:r1=1;
>  No
> 
>  Witnesses
>  Positive: 0, Negative: 41000000
>  Condition exists (1:r0=1 /\ 1:r1=0) is NOT validated
>  Observation MP+pooncerelease+poacquireonce Never 0 41000000
>  Time MP+pooncerelease+poacquireonce 13.74
> 
>  Thu Jul 17 18:13:40 UTC
> 
> [0] https://github.com/puranjaymohan/blitmus
> [1] https://github.com/puranjaymohan/blitmus/blob/main/litmus_tests/MP%2Bpoonceonces.litmus
> [2] https://github.com/puranjaymohan/blitmus/blob/main/litmus_tests/MP%2Bpooncerelease%2Bpoacquireonce.litmus

Hi Puranjay,

Thanks for the patch. I applied the patch and tested it.

Before this patch:

# ./test_progs -a \
  verifier_load_acquire,verifier_store_release,atomics
#11/1    atomics/add:OK
#11/2    atomics/sub:OK
#11/3    atomics/and:OK
#11/4    atomics/or:OK
#11/5    atomics/xor:OK
#11/6    atomics/cmpxchg:OK
#11/7    atomics/xchg:OK
#11      atomics:OK
#528/1   verifier_load_acquire/Clang version < 18, ENABLE_ATOMICS_TESTS not defined, and/or JIT doesn't support load-acquire, use a dummy test:OK
#528     verifier_load_acquire:OK
#565/1   verifier_store_release/Clang version < 18, ENABLE_ATOMICS_TESTS not defined, and/or JIT doesn't support store-release, use a dummy test:OK
#565     verifier_store_release:OK
Summary: 3/9 PASSED, 0 SKIPPED, 0 FAILED

After this patch:

# ./test_progs -a \
  verifier_load_acquire,verifier_store_release,atomics
#11/1    atomics/add:OK
#11/2    atomics/sub:OK
#11/3    atomics/and:OK
#11/4    atomics/or:OK
#11/5    atomics/xor:OK
#11/6    atomics/cmpxchg:OK
#11/7    atomics/xchg:OK
#11      atomics:OK
#529/1   verifier_load_acquire/load-acquire, 8-bit:OK
#529/2   verifier_load_acquire/load-acquire, 8-bit @unpriv:OK
#529/3   verifier_load_acquire/load-acquire, 16-bit:OK
#529/4   verifier_load_acquire/load-acquire, 16-bit @unpriv:OK
#529/5   verifier_load_acquire/load-acquire, 32-bit:OK
#529/6   verifier_load_acquire/load-acquire, 32-bit @unpriv:OK
#529/7   verifier_load_acquire/load-acquire, 64-bit:OK
#529/8   verifier_load_acquire/load-acquire, 64-bit @unpriv:OK
#529/9   verifier_load_acquire/load-acquire with uninitialized src_reg:OK
#529/10  verifier_load_acquire/load-acquire with uninitialized src_reg @unpriv:OK
#529/11  verifier_load_acquire/load-acquire with non-pointer src_reg:OK
#529/12  verifier_load_acquire/load-acquire with non-pointer src_reg @unpriv:OK
#529/13  verifier_load_acquire/misaligned load-acquire:OK
#529/14  verifier_load_acquire/misaligned load-acquire @unpriv:OK
#529/15  verifier_load_acquire/load-acquire from ctx pointer:OK
#529/16  verifier_load_acquire/load-acquire from ctx pointer @unpriv:OK
#529/17  verifier_load_acquire/load-acquire with invalid register R15:OK
#529/18  verifier_load_acquire/load-acquire with invalid register R15 @unpriv:OK
#529/19  verifier_load_acquire/load-acquire from pkt pointer:OK
#529/20  verifier_load_acquire/load-acquire from flow_keys pointer:OK
#529/21  verifier_load_acquire/load-acquire from sock pointer:OK
#529     verifier_load_acquire:OK
#566/1   verifier_store_release/store-release, 8-bit:OK
#566/2   verifier_store_release/store-release, 8-bit @unpriv:OK
#566/3   verifier_store_release/store-release, 16-bit:OK
#566/4   verifier_store_release/store-release, 16-bit @unpriv:OK
#566/5   verifier_store_release/store-release, 32-bit:OK
#566/6   verifier_store_release/store-release, 32-bit @unpriv:OK
#566/7   verifier_store_release/store-release, 64-bit:OK
#566/8   verifier_store_release/store-release, 64-bit @unpriv:OK
#566/9   verifier_store_release/store-release with uninitialized src_reg:OK
#566/10  verifier_store_release/store-release with uninitialized src_reg @unpriv:OK
#566/11  verifier_store_release/store-release with uninitialized dst_reg:OK
#566/12  verifier_store_release/store-release with uninitialized dst_reg @unpriv:OK
#566/13  verifier_store_release/store-release with non-pointer dst_reg:OK
#566/14  verifier_store_release/store-release with non-pointer dst_reg @unpriv:OK
#566/15  verifier_store_release/misaligned store-release:OK
#566/16  verifier_store_release/misaligned store-release @unpriv:OK
#566/17  verifier_store_release/store-release to ctx pointer:OK
#566/18  verifier_store_release/store-release to ctx pointer @unpriv:OK
#566/19  verifier_store_release/store-release, leak pointer to stack:OK
#566/20  verifier_store_release/store-release, leak pointer to stack @unpriv:OK
#566/21  verifier_store_release/store-release, leak pointer to map:OK
#566/22  verifier_store_release/store-release, leak pointer to map @unpriv:OK
#566/23  verifier_store_release/store-release with invalid register R15:OK
#566/24  verifier_store_release/store-release with invalid register R15 @unpriv:OK
#566/25  verifier_store_release/store-release to pkt pointer:OK
#566/26  verifier_store_release/store-release to flow_keys pointer:OK
#566/27  verifier_store_release/store-release to sock pointer:OK
#566     verifier_store_release:OK
Summary: 3/55 PASSED, 0 SKIPPED, 0 FAILED

Tested-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>

Regards,
Saket

