Return-Path: <bpf+bounces-74804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EEBC66417
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 22:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 359CC4EC4FF
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 21:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211E83218D8;
	Mon, 17 Nov 2025 21:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FSGe+vqK"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331A731985F;
	Mon, 17 Nov 2025 21:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763414380; cv=none; b=POzBxUY1xCkIU4rs45olC2pZRfiUFnXX81Zyyqv2WHLzXZY/fTjCob7z7ioQtjhH1KwHhuxxOg2IW7K2dgPb+DowKwBqc89q1T4WIdIyhDC0qp+7B7IhGetdTJWxQrj4Rbwcmw1uWi0neuU5tAYhAiM+4OKPHAyTrifpKzvmssU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763414380; c=relaxed/simple;
	bh=Fcr2an9OvyfvByMvUiGXR6bKpiB77D8pC9j1w6+C2Ao=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=hpfut+Ig1dnh+7fpTrBtEYkd5zgtL4SW3gIVCi5bWK4a0LIkRS8pjJn7BfHM80hv4NvXZC613u2lqba/dWvqNlE0njILuqL80WZ1jcD/TbYdIpnldIZMl9YL4RAE44Wvbt9N5d7avCXkrJvkBpx3PGoBlzIGaDPEXAG64n+ZHHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FSGe+vqK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHA9PRB014231;
	Mon, 17 Nov 2025 21:19:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=oNRxzU4vgpmjzlPv1h5l0lfs5clT
	aOUfbtAGJEOhM80=; b=FSGe+vqKRIYqTxoWA7cvqPU20j8XsNoiVZUm9AFfcJXV
	I9RSRwKvzB9pK9lSDTMsX36L0r0z4MwJqBrh0Hg7F+ZftGkPaCub53Gw6Gk1ZIzC
	ySyL/VqRhosg/RGfSsFI1Fx/sb4DHkZKDHGoWFZ8AKbKF5t3/3ZXgO0GHFhZSjEG
	UwUXnenOID/Bjn0lTGqYm6aU6xYpXi5o5aW0gEgQEMLEsKQ0N1mpF3BYJUA7yYNx
	CttoVulwXdhktZ2fe/2xjFEH87c0A9HMCS+yS/qlP+JxIsVHtv+7+JsKlDKn4FuH
	dV5nWxX6RdcDldvX63WqgxRVbGgUq4xy97+0O6ydJQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejk182k9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 21:19:28 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHHTk0N010406;
	Mon, 17 Nov 2025 21:19:27 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4af3us048p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 21:19:27 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AHLJRTN24642278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 21:19:27 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8059558058;
	Mon, 17 Nov 2025 21:19:27 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87E7A58057;
	Mon, 17 Nov 2025 21:19:26 +0000 (GMT)
Received: from [9.111.144.178] (unknown [9.111.144.178])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 17 Nov 2025 21:19:26 +0000 (GMT)
Message-ID: <9a8eaa37-698d-41ff-a6f8-287b685d7f78@linux.ibm.com>
Date: Mon, 17 Nov 2025 22:19:24 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Subject: linux-next: samples/bpf build error: no member named 'ns_id' in
 struct ns_common
To: bpf@vger.kernel.org
Cc: linux-next@vger.kernel.org, Alexander Egorenkov <egorenar@linux.ibm.com>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=C/nkCAP+ c=1 sm=1 tr=0 ts=691b9160 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=dNcmTFmNxba2xSaGdesA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-GUID: _FUKo9_AZFfCMeqkxcjlRacmjK6LfgUu
X-Proofpoint-ORIG-GUID: _FUKo9_AZFfCMeqkxcjlRacmjK6LfgUu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX5kyeYHRvHbK6
 yQmmxT7Gx2r6PlSFeZnEuSY9Nf2lN8e4rhftka1CnoLcGsabPHeXMhBsBB2pU5uO1FGv08kCHCh
 zseNi5RoqJS9k1KHC0PNqSoXLFZgNZiXVHJRkbD+7T7CgB8TUt5GW8FI7TPtiaKLlrrppuyeahX
 XuTu95lKvClXhArhDnspykx4nCYKVbWCEbWzBCf0Ntyt/rf71CJ9zsG/bltpUrhqSWFcOa7TYg5
 4xNcSgbo9UngyD6LwcGS4c+SX+9xngc0vAbSeawIfAG9E/y4X2qY3uwIjc8lKjcGd0STI9CsF0h
 gI8VkIN8e28hr1N8UQbYRfHWUqY5yqd9nfI97eKVkOztDAtRAYg0Kv+ourdZAPn01ptOaG3KQGd
 Xv2qCJF450aOzQ4QObsx8dvESsdSWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032

Hi,

I’m observing build errors in samples/bpf on linux-next.

  - linux-next snapshot: next-20251117 
  - Architecture: s390x
  - Compiler: clang version 20.1.8

Numerous errors of the following type:

In file included from lathist_kern.c:9:
In file included from /root/linux-next/include/linux/ptrace.h:10:
In file included from /root/linux-next/include/linux/pid_namespace.h:11:
/root/linux-next/include/linux/ns_common.h:25:23: error: no member named 'ns_id' in 'struct ns_common'
   25 |         VFS_WARN_ON_ONCE(ns->ns_id == 0);
      |                          ~~  ^

Appears to be a mismatch between kernel headers and bpf. 
On next-20251111 no errors of this type took place.

I figured out the following patch series is likely the cause:
https://lore.kernel.org/all/20251109-namespace-6-19-fixes-v1-0-ae8a4ad5a3b3@kernel.org/

Thanks,
Mikhail Zaslonko

