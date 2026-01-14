Return-Path: <bpf+bounces-78824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8C7D1C34B
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 04:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 849B5307280B
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 03:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B3F322B8E;
	Wed, 14 Jan 2026 03:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EcdN2wzh"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E4D2BD5AF;
	Wed, 14 Jan 2026 03:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768359905; cv=none; b=BnInEbs9ClaSPRiTJLYEA/wbTxV2y6sX0uiYtTh2IEHDQKOj5Z22kkXRBRkYzVaLRDeM5LlZkhzwhECakE4T+Hq9ijMd73NnFr8RcOYVi8PLkf51GqFaOvUo+ti3THaVJvU3GYfqdZL8yU7tNzMbilipltOvl3J+Qtuh50AmXb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768359905; c=relaxed/simple;
	bh=uGYn6KMuQ0sdFTvJXiSqeDNnG7UyKTC0dz/CVkLlwOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qO4a6Pd7w4tpBNUMgN6O/q/S0mWahdYyhb3XbsLj6vvVaderW4WXyeyJdMU75DzFhm6/sv1lDbxMoK+M2RWDTN5/9IUjUi2y+zazmpYyfBlHaH9+kL+cOE2Foqh2Lpjq97DYB5XLxJ+6DDSFvVDGpXsrQdChJUYx4cwUJZMBi4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EcdN2wzh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60E0vJXP026338;
	Wed, 14 Jan 2026 03:04:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mo5CGY
	/iMY3KaBQAArahIvVsq+WB3Ds4VT39jwdoqE8=; b=EcdN2wzhkKCMEQzfkYVdMD
	aoxQz1jR24wjzHPB5D9HvrixueZ+EhZWMk0slLkdq5zrws7/p736b3Smq29OzO+X
	c29vtRQUK0jKf7SOoQZtorWiDJKU1F06dhBTVWahWW+OAukU7ulJnYuCPXM8y2Om
	VXI/mKDBQmzVj4jOL9LLnFEaZVx3jEuUr/Qg1E7qMuQO74tmZnaLqCwazImGw9HH
	vEE3zogxXqt+1MXSwJ0DngdgNBvTodO/2+yw7CSfoyb0ximyKIGwGf4QJLLbeBIK
	vQwNOLlznjLX4bo22x1SNlW7Y6/Ilj5z8EMThdK149AebK1HP7bv4bo7qsvId4sA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkc6h7akg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 03:04:36 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60E34ZJb023525;
	Wed, 14 Jan 2026 03:04:35 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkc6h7akd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 03:04:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60DNwfZM031255;
	Wed, 14 Jan 2026 03:04:34 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm3t1qk0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 03:04:34 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60E34V6E27329010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 03:04:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECF3420043;
	Wed, 14 Jan 2026 03:04:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFC2E20040;
	Wed, 14 Jan 2026 03:04:25 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.124.217.241])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Jan 2026 03:04:25 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: hbathini@linux.ibm.com, sachinpb@linux.ibm.com, venkat88@linux.ibm.com,
        andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        naveen@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
        Christophe Leroy <chleroy@kernel.org>
Subject: Re: [PATCH bpf-next v4 0/2] powerpc64/bpf: Inline helper in powerpc JIT
Date: Wed, 14 Jan 2026 08:34:24 +0530
Message-ID: <176835971841.41689.9713436596116630224.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1765343385.git.skb99@linux.ibm.com>
References: <cover.1765343385.git.skb99@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oyr2J7X1wIT925gR43uRlxC4s-yxIpHj
X-Proofpoint-ORIG-GUID: B7vlNFk52xOMyPJqymI6VSjJiYDL9OSj
X-Authority-Analysis: v=2.4 cv=TaibdBQh c=1 sm=1 tr=0 ts=696707c4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=sLBzE-RsjPQaH2mEHBgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDAxOSBTYWx0ZWRfX3FlZ/6mw9n0N
 W3RxTFW/B0xbZv8bOB5aLi64nPQfmIUAIbGwpW8NWdXzx0pHO2PqTRUhybCaMSSCLuOM3TYQIII
 cgmLlUAb5siikXSkcz2HauMMRMhhXQPX5j2RCvH9dIwsbPxgJ7iLvPSxVlHZ43+TZv/exR6syJF
 qmHV9BDhcBE0Ga9mTY8DKUerZThPIT5UexVg94ff8RNZFIsIz2IaHpAL2wAb531MJb9Va/KYL7W
 WnAsrUcshv1nAjLuxd96E5DmiR2UDXhJubP3h42p+ASsdDIqyat078KbJHE/Oyx606ibAYjuIjq
 bWx45W0YmRpZUWQWyMrKn3m4x9R7H4/l3vO9eJgkG4X4DJPUND4vxDBFCPHK7p1ssX+PJILVv7q
 7I9BHaE0fmCfzL0hV+JSJ7g0PqyVTx8hUUPzDaj1jhFyiQkDW+aL8DqkVguTTvCNBjXq75toNLx
 Bd//A1xsSk9kLESMrog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601140019

On Wed, 10 Dec 2025 12:20:31 +0530, Saket Kumar Bhaskar wrote:
> This series add support for internal only per-CPU instructions,
> inlines the bpf_get_smp_processor_id() and bpf_get_current_task()
> helper calls for powerpc BPF JIT.
> 
> Changes since v3:
> * Added break after computing per cpu address so that the computed
>   address is not overwritten by src_reg as suggested by AI bot.
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc64/bpf: Support internal-only MOV instruction to resolve per-CPU addrs
      https://git.kernel.org/powerpc/c/58a075adf3fb1701435d29e0113284dc31d6e43e
[2/2] powerpc64/bpf: Inline bpf_get_smp_processor_id() and bpf_get_current_task/_btf()
      https://git.kernel.org/powerpc/c/20ab1d11265350a9ea3d315d6c70170b8198f329

cheers

