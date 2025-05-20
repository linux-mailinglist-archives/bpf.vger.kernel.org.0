Return-Path: <bpf+bounces-58538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A8BABD3DE
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 11:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9933B7AFF22
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 09:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD2626A098;
	Tue, 20 May 2025 09:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CYyDJVWg"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E801C3306;
	Tue, 20 May 2025 09:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747734450; cv=none; b=DcfAPu+LjT80bsMEudVBMKEcmEFIykAbbMNG9wY18eIof+Clyo/4aES9ysrkSOpg301aWVrm+oCeGZX21PjlT8EeTzjic7zI1Vj/kgmYRXvV/Ug0AtW/Ne/xwSmgwKDSE32JWXW1YPjmOc2G+TkBghEuv8dhkZ5I0fmLJ82KhY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747734450; c=relaxed/simple;
	bh=st5ZN9t4lGCsmTwBzj6GkRzehVqb+AvIjSrgYKxmT1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZHV0QvyxE0v1RZEbye/yk+12fqQBvOldL+oVxkWTvyerGGVqo9CDhwJzVlErAbUhKw3zWi4DTht6tQLOBEkdih5mIi7bDGoUrYbumNItHp8qqzNgJfPvHbR3WHEfdF4l8XSI1VcUTk2Q35RAA8RB1hJHkLnMlXJ3u4c6x1C07g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CYyDJVWg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K9F6SC008002;
	Tue, 20 May 2025 09:47:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=eYsshfL6ZUO0WplOFcK3FPi+KTAn+c
	nW/kMDuLwfRGY=; b=CYyDJVWgOkoVyl/0wxvxQC9k/uaTksD+i5VxFboBhblXmd
	57GPEmxFZezvrC0/PuK3i3RqrBq0V6lL4pG5qphQsr1GdG4Rzvt7XAPY0kfi0lJf
	LCGlnBg5sI9mNT7kCFz2iG9nGD49zIl4lvWUUkzGKmT2WZOXs23IDX5InPzncOUF
	zUzzTjBDO/AcZsLYM+yR/UzopLF50fp8lLd4vUO6vDGnECYi9YBspylhVdNsFQ4i
	ir6/u7WB5Xh74LaSHwTQMobbGDlwUvtnM6WSNpS7zQX4FeDoY/bPufIyBJ9uu6mQ
	g3NFJl4bjzYpwq0qrUtJRkmLorGWUNNva91GMQPw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46rpxkr53u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 09:47:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54K87Gga015958;
	Tue, 20 May 2025 09:47:09 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46q7g2aw0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 09:47:08 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54K9l7T140370652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 09:47:07 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48F9E2013E;
	Tue, 20 May 2025 09:47:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B0BF20140;
	Tue, 20 May 2025 09:47:07 +0000 (GMT)
Received: from osiris (unknown [9.152.212.133])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 20 May 2025 09:47:07 +0000 (GMT)
Date: Tue, 20 May 2025 11:47:05 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [bug?] s390: kernel panic on specification exception: 0006
Message-ID: <20250520094705.7932Bc3-hca@linux.ibm.com>
References: <4f3768be36e0298be4ceebd4fdd3e96dd4fbdc04@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f3768be36e0298be4ceebd4fdd3e96dd4fbdc04@linux.dev>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EM8G00ZC c=1 sm=1 tr=0 ts=682c4f9d cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=NEAV23lmAAAA:8 a=VuaLrmb_DCXaSyQ9aWYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: ndqHY9jSY1soiqAi2mGLACUJw-m9cHwz
X-Proofpoint-ORIG-GUID: ndqHY9jSY1soiqAi2mGLACUJw-m9cHwz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA3OSBTYWx0ZWRfXxOPtJFTQoQvW e5KbT4Np1rwke1MB6rgJTtatfakliBYkpfvaJi2385BgGpRd6h8Xim+p+djCjHOHwRlMNL8kIeY yESFxPnWzLoCVaxjmkk1f/T/SmhhmtU174L38r9o+9Ot6pwHSkyaneoAzZRJ/t0YWRY7Kczhqs2
 UsIEkAQ2MYlREfkE9Q6Xl+Fp1r9dBSUdm2yDD2TMeL1rT96PI4sLnQqFvLrLKdnAVEfjweahAaA Cp2A3s0V/JFZB9fHUeKsq2W528I/dG3Nw7QGW6Qnbm6E/RIa2sf7s5jGCjlhb64cVMK794JwbYQ 6olsJ9YAaJqyEIfifwlJWihEayxKkvyVByLiHLhQ8yUGF19z9HVZPiVZVisRVpcu3iX6qgTjFqZ
 wjDF36U5TQia8mrAElLSNAUXrVjRdvfN4IqJHImsDwwRC7r8nBo8CdxCbWlEZKjXw4W0lYBt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 clxscore=1011
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505200079

[full quote, and adding Ilya]

On Thu, May 15, 2025 at 07:04:20PM +0000, Ihor Solodrai wrote:
> Hi everyone.
> 
> Stumbled on the following while testing unrelated changes to BPF CI scripts:
> 
>     #353     select_reuseport:OK
>     specification exception: 0006 ilc:2 [#1]SMP
>     Modules linked in: bpf_testmod(OE) [last unloaded: bpf_test_modorder_x(OE)]
>     CPU: 0 UID: 0 PID: 108 Comm: new_name Tainted: G           OE       6.15.0-rc4-g169491540638-dirty #1 NONE
>     Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
>     Hardware name: IBM 8561 LT1 400 (KVM/Linux)
>     Krnl PSW : 0404e00180000000 000001e43ac595e4 (hrtimer_interrupt+0x4/0x2a0)
>                R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
>     Krnl GPRS: 7fffffffffffffff 000001e43ac595e0 00000000fff8f200 000001e43c52a0c0
>                00000164c50740d8 0000000000000000 0000000000000000 0000000000000000
>                0000000000000000 0000000000000000 000001643afabe00 0000000000000000
>                000003ff9fbadf98 000001e43b747550 000001e43ab12774 00000000fffdfe68
>     Krnl Code:#000001e43ac595e0: 67756573		mxd	%f7,1395(%r5,%r6)
>               >000001e43ac595e4: 743d696e		unknown
>                000001e43ac595e8: 73303031		unknown
>                000001e43ac595ec: 61652c64		unknown
>                000001e43ac595f0: 65627567		unknown
>                000001e43ac595f4: 2d74		ddr	%f7,%f4
>                000001e43ac595f6: 68726561		ld	%f7,1377(%r2,%r6)
>                000001e43ac595fa: 64733d6f		unknown
>     Call Trace:
>      [<000001e43ac595e4>] hrtimer_interrupt+0x4/0x2a0
>      [<000001e43ab128ca>] do_irq_async+0x5a/0x78
>      [<000001e43b65f694>] do_ext_irq+0xac/0x168
>      [<000001e43b66ae90>] ext_int_handler+0xc8/0xf8
>     Last Breaking-Event-Address:
>      [<000001e43ab08a9e>] clock_comparator_work+0x2e/0x30
>     Kernel panic - not syncing: Fatal exception in interrupt
> 
> This is on the current tip of bpf-next (9325d53fe9ad).
> 
> Job: https://github.com/kernel-patches/vmtest/actions/runs/15051985809/job/42309244372
> You can download full logs from there.
> 
> It only happened once so far, didn't repeat on restart.

Looks like the text section, which contains the hrtimer_interrupt
function, got corrupted, and an ASCII string was written there.
The hexdump above with the corrupted code translates to the following
ASCII text: "guest=ins001ae,debug-threads=o".

Does that ring a bell?

