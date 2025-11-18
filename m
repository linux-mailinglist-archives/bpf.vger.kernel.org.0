Return-Path: <bpf+bounces-74922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F0BC681A9
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 09:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6585B4E375A
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 08:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE412FFFB3;
	Tue, 18 Nov 2025 08:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MOsD3t3q"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3352D46DD;
	Tue, 18 Nov 2025 08:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763452956; cv=none; b=iogxTnjZovB7exhd8pkmd3nK91mFkAVUDFzFYzKk7S6KZd+3p1UOb0PizaxWPZKI2mLOpFea/ZyvK4dYG/A/a2cbndaePMgt9RKGaA9dwJB3GajXcSWZKzXbfwkzpYs7DaFJSRoLAiEgHHpQn+7CcgCzGECgdPpmsVqtevEp1nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763452956; c=relaxed/simple;
	bh=Q6bFOnhq9NWylKybWK6vGSIGqH6vYwGhfhS+LX0VLx4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lbZP6b4xHj3WAh1lDqICgGKmOTwm07gSngBPBCjLJ55RBGjdGWYCxiaaEwSPsbDuRlRZRzLx0toENUkMo4LJ3t+CrzzS4BNIGJqnYZCevOsKqfzPZ98pKSLezQECNq25u+i8Vwk9e/P43fXeCUOztu+NMTwxt6xQctUsd3XmjBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MOsD3t3q; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHKgKSb000525;
	Tue, 18 Nov 2025 08:02:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ryf7Mh
	F/i0lsWOB5R0WjJ9ezYU0j/DrJ5rtmwrfocFw=; b=MOsD3t3qtzVaArxFTZvAI9
	gc8OmP1u6rZFtjaKUs+Kal9lwUOc3/oahXBAdicka5mFLVFDZnGiZQbKWbBF3yxv
	oSbOG10DdETa+vj9qPnE7HDq0qix0rkJ+wWfEv0tzQO/8gXkN3rCmqqpH4vh1/dE
	cJ/MvdDu7EnpzgBmjVuXD4WXtzb8vWVBdqomGyJwom49mSDIocwdb9O34AYJ6PS1
	SSB8e2HtXDQkDxl/fBf6LxGVnwt+Ir/t0WPvE9fLTAkSUFUq5raxkK+SAUwWOkvM
	s4MGQf+IzBgnFTqo+hVvdVb7v9z0PLZipKCi7+m+2E4VbkA2NQgjTwPqNaMdDwkA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejjtsfe5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 08:02:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI4RqPF017326;
	Tue, 18 Nov 2025 08:02:22 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4af6j1hrn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 08:02:22 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AI82LjE58786134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 08:02:21 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A98F58123;
	Tue, 18 Nov 2025 08:02:21 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD29E58124;
	Tue, 18 Nov 2025 08:02:20 +0000 (GMT)
Received: from [9.155.203.176] (unknown [9.155.203.176])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 18 Nov 2025 08:02:20 +0000 (GMT)
Message-ID: <19cda4f5-a201-4133-9ef6-ee5bf44b0f8a@linux.ibm.com>
Date: Tue, 18 Nov 2025 09:02:19 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: samples/bpf build error: no member named 'ns_id' in
 struct ns_common
From: Mikhail Zaslonko <zaslonko@linux.ibm.com>
To: bpf@vger.kernel.org
Cc: linux-next@vger.kernel.org, Alexander Egorenkov <egorenar@linux.ibm.com>,
        Christian Brauner <brauner@kernel.org>
References: <9a8eaa37-698d-41ff-a6f8-287b685d7f78@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <9a8eaa37-698d-41ff-a6f8-287b685d7f78@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: i0kgmCPdGQvbqJWNifTKbkL7XL7Lzq8X
X-Proofpoint-ORIG-GUID: i0kgmCPdGQvbqJWNifTKbkL7XL7Lzq8X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX0ycPIv9Nqy0p
 2/KbnDV6roN+mnHFulkVXlzgEIbdM+jqBAT0EV0/koD9iMkW/usUIgICFMBA8O1n4Shmp7YfN3Q
 JTHcrikfmzmY0z5eBCHxPWyBYKIC5qYnIpW9FqiKLkDmg1UauNOC/KF0kYER5YWJsv2uoEsprAi
 v5UnZMOuD1bnn0dbFjZ2RPEJgsMl8N1gdxXli6wAVPk3NjvraCa6TX2TG9iWTrwz18uh1vgI0p0
 ntVUSxdNK4lsOMt6l3iWDhidoU+UePRbdWGVAftUnHfpi4ZOOAc0aF86jafqOFq9xyEdGQodRb4
 /3Johu1ieHvey0+NjSrBdYe2uR/0dpSNReMkHSlR/OzZDl+PDDrwZ4a5BFHRMrBDGZ2pWbWaGk7
 WrZ3YulucGuVUFvBlB0qGpgG6n/teA==
X-Authority-Analysis: v=2.4 cv=SvOdKfO0 c=1 sm=1 tr=0 ts=691c280f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=qbmNozvd1ZgaVv0vuk0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511150032



On 11/17/2025 10:19 PM, Mikhail Zaslonko wrote:
> Hi,
> 
> I’m observing build errors in samples/bpf on linux-next.
> 
>   - linux-next snapshot: next-20251117 
>   - Architecture: s390x
>   - Compiler: clang version 20.1.8
> 
> Numerous errors of the following type:
> 
> In file included from lathist_kern.c:9:
> In file included from /root/linux-next/include/linux/ptrace.h:10:
> In file included from /root/linux-next/include/linux/pid_namespace.h:11:
> /root/linux-next/include/linux/ns_common.h:25:23: error: no member named 'ns_id' in 'struct ns_common'
>    25 |         VFS_WARN_ON_ONCE(ns->ns_id == 0);
>       |                          ~~  ^
> 
> Appears to be a mismatch between kernel headers and bpf. 
> On next-20251111 no errors of this type took place.
> 
> I figured out the following patch series is likely the cause:
> https://lore.kernel.org/all/20251109-namespace-6-19-fixes-v1-0-ae8a4ad5a3b3@kernel.org/

Sorry, wrong link. Here is the related patch-series:
https://lore.kernel.org/all/20251110-work-namespace-nstree-fixes-v1-0-e8a9264e0fb9@kernel.org/

> 
> Thanks,
> Mikhail Zaslonko


