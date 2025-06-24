Return-Path: <bpf+bounces-61369-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0406AAE649C
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 14:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 012BB4039F7
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 12:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E71C298CA1;
	Tue, 24 Jun 2025 12:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bPrFDcDr"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBD22989B3
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 12:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750767323; cv=none; b=dNi1iu9eLBpe6zmMR8l71GBF/KuprH6yxrLUZDjUIyJnNGqyCH7gouJ4V0dRu2chhaz3N/kGjGYyXhQF+RgJANxqxxpoKvGTQMf5W4Z/iXigTw9PNPfNJ750zd9a3h+2dyWO+O3LAe4k9aZCVMlUlUtQOehJCQVgbIFSvnmRre4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750767323; c=relaxed/simple;
	bh=rj8s53Pe5Ke7u0QUC0bcYuTAY/77gdw1d0lKQbNEUSk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EVuROQanLR7FgnITzIE7e/2XiwKxcHovPwe7DSE010qsFCyMQEAWChbG2dV8hb5PKwSGfo14LgvYfLigPWZh4dP5BGe68cWgzH446WWG1Wc090tXRFHJqmq6ZQqItUokRYFtGdiyK8rk/g9+YKYDHKFCbuHp4z75OVoUTt3t2V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bPrFDcDr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O4v4EN019048;
	Tue, 24 Jun 2025 12:15:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=WMgM58m18xVz7ZO6fGilQsRn2tY8BBSSwNcJsoyU+
	os=; b=bPrFDcDrxYUyYuQPFJxK9oHrDtNCz2FY4ErKwa8a8KyBbmIoQ6tDYK3ah
	I0rSbF96cM2K9NtjJyZeDCsAYu6AOMOATqPHlZRG3pgRSriwfMNoIkwholRFmuyO
	u/QnqGj4NoKHCYIRRZcj6aHIq1OM1bE7PzZINzNsecstQjOnASAoGJiV5xuqYusL
	i7gIh1KptHOckTFgU5Iywzzvky69F9qCMlEggaonUGUC2FmRE1zt6MhleDF2uCjG
	1n7EAlwsXOyPA4ts8oovKYrmnhkdHZfYDInKAtH3iO+LlrADN0BW9NMOIkJJoh7Z
	KX5hliR9VnOOLOHFMqKBTJGAdMkDw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dmfe8he8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 12:15:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55OBSTCf003983;
	Tue, 24 Jun 2025 12:15:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e99kkmeq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 12:15:06 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55OCF33I28639904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 12:15:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41DF220049;
	Tue, 24 Jun 2025 12:15:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACAD620040;
	Tue, 24 Jun 2025 12:15:02 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.5.146])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Jun 2025 12:15:02 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 0/2] s390/bpf: Describe the frame using a struct instead of constants
Date: Tue, 24 Jun 2025 14:04:26 +0200
Message-ID: <20250624121501.50536-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lnyQcp5yylhmP7a1UhhxNwqcO6IElQNr
X-Proofpoint-GUID: lnyQcp5yylhmP7a1UhhxNwqcO6IElQNr
X-Authority-Analysis: v=2.4 cv=BpqdwZX5 c=1 sm=1 tr=0 ts=685a96cc cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=04KB4t3DcwN-hSm8:21 a=6IFa9wvqVegA:10 a=br7M2B_5Ej0s_fevjAgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDA5OSBTYWx0ZWRfX1yFKgSokvxtz a18N4HHaCRt57BAR5sICuyCNO35Iz1ijmJSanBXMG6iVt1UBdmSIiOAzoToLAAiPj2N744jBpbZ tijApfL1G5RPkF644i/kvG3qukNq6dtTUuhtw+C5UgIcrvFyJFdYXL50eDw9SSpqa9jT4iIYaFh
 I73fO7xJNrpvrhw3rPBoRncpCSt082qRq3Qdf6To8FgZAtXa/OLfKx83bd0EVzY8xOe8PyZICiF a7Wj2heYZnwL+jUExqXaR3pQFXpi6HYmjWEmtDAAs1EV76nFFQc1Q7ly8ndYqUPchbvtpDN/stO bs7M/7WfXZrVa5Xa5EquOIbdHN/xQhTH96uAOM9Pdb842RMQicGjehCte5hD2XQGCq3rsy2k+kD
 5ntMTSm+y/kNVDS6S0/Urw04E2nY6sRCehJ+IMfIIs4xk8tIdpXV9hh7E4IRXlP4e7lDE2PW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_04,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 spamscore=0 mlxlogscore=985
 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506240099

Hi,

This series contains two small refactorings without functional changes.

The first one removes the code duplication around calculating the
distance from %r15 to the stack frame.

The second one simplifies how offsets to various values stored inside
the frame are calculated.

Best regards,
Ilya

Ilya Leoshkevich (2):
  s390/bpf: Centralize frame offset calculations
  s390/bpf: Describe the frame using a struct instead of constants

 arch/s390/net/bpf_jit.h      |  55 -----------------
 arch/s390/net/bpf_jit_comp.c | 113 +++++++++++++++++++++--------------
 2 files changed, 67 insertions(+), 101 deletions(-)
 delete mode 100644 arch/s390/net/bpf_jit.h

-- 
2.49.0


