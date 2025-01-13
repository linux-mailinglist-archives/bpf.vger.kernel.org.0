Return-Path: <bpf+bounces-48672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFF2A0B3D2
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 10:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F22EF7A2A82
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 09:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570091FDA9C;
	Mon, 13 Jan 2025 09:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fz1cTLLG"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622E81FDA7A;
	Mon, 13 Jan 2025 09:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736762381; cv=none; b=Mo6IdB0U/bvccazxdhAv3QqAGVt6FZMxzTppI8peBAP7iIwoKzOz+qQd++eRPVBzsWIXBkrYrjyg1Uw5BeJCCwmyKVRBbn2rChZfw85HREqmmbyWLBQ78kziF6ls5aQRzHoJRjAgU684m8qbNN8N6/l4pJuhUQFXlIWaTkdoHQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736762381; c=relaxed/simple;
	bh=HXfc/MrkJHMg4EK5swHrR9lPNKRHfqqLHgamt08x0Ek=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uKmKCk1gGXSpK/fiVvZc1pqhz34GX3UnWHvifbt6aMWLrfPG0IcKpnhduSrRTtcb1YyBLBM6CMkRlYWRuxadSGQpyMZx4q+5bfxfOOiE1LliC7hVBGafRmoAyF0iFaYbqO5mvSMs1fDgoBol6TY20MfgReghEmTZh9iHZfFs+fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Fz1cTLLG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50D3qqn1002379;
	Mon, 13 Jan 2025 09:59:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=StrBcLiHd6f0gbm6Q8qciYtYqt1wsPKW4JUT9wQkiLY=; b=Fz1cTLLG
	HyQXtXFR5o0mUMY6VocmaPPVnqOUdwONCNFlZd5Lc8HgSayZeCeJqaUCZNANA7el
	Ok9KLAdL3m3cQdaDygXMwRXj8DYl0Z8QQ4uLZkmGMXvdO4G7NB8TB15J7PfDpRlu
	FGdaUKoFi/Ksl5DVK0p7liYWvxsBLqh+6AWie2aZGV51E2ADnDrxZuTWuWmuH0Tf
	2TnO7+iY7FsAfgsekY+klNrtkIi4X3oNwqj/0P+5Wx+V8QPOE45rk1yu108NBHbo
	jnjvSeUIMuSP8Nlb/8YB4XCe0ZuD1jKW1pmHEDjccGmq1TaGGWwj/Lg9UqkLaQoh
	d+U0zDR9JExt3A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 444uags9cd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 09:58:51 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50D9wIjW028414;
	Mon, 13 Jan 2025 09:58:50 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 444uags9cb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 09:58:50 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50D8ZOtE007364;
	Mon, 13 Jan 2025 09:58:49 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443ymwjt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 09:58:49 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50D9wlds54722852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 09:58:47 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 635F42004D;
	Mon, 13 Jan 2025 09:58:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BC932004B;
	Mon, 13 Jan 2025 09:58:45 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.124.211.30])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 13 Jan 2025 09:58:44 +0000 (GMT)
Date: Mon, 13 Jan 2025 15:28:39 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: bpf@vger.kernel.org, daniel@iogearbox.net, maciej.fijalkowski@intel.com,
        sdf@fomichev.me, netdev@vger.kernel.org, sdf@google.com,
        kuba@kernel.org, yoong.siang.song@intel.com, ast@kernel.org
Subject: [RFC] Fix mismatch in if_xdp.h between tools and kernel UAPI
Message-ID: <Z4TjzzB8NSnTy_Wa@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NYjWebT6GUyyx-s_8TmkQkcAaEQWSLff
X-Proofpoint-GUID: fEJbpHupk8-Z8s5d6H50apE8zmI4jT0w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=470
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1011
 impostorscore=0 bulkscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501130084

Hello all,

While building libbpf, I encountered the following warning:

Warning: Kernel ABI header at 'tools/include/uapi/linux/if_xdp.h' differs from latest version at 'include/uapi/linux/if_xdp.h'

A brief diff shows discrepancies in the doc comments regarding `union
xsk_tx_metadata` vs. `struct xsk_tx_metadata` references. Below is the
relevant snippet:
$ diff tools/include/uapi/linux/if_xdp.h include/uapi/linux/if_xdp.h
120c120
<  * field of union xsk_tx_metadata.
---
>  * field of struct xsk_tx_metadata.
125c125
<  * are communicated via csum_start and csum_offset fields of union
---
>  * are communicated via csum_start and csum_offset fields of struct

This patch aligns the documentation in
`tools/include/uapi/linux/if_xdp.h` with the kernel UAPI header in
`include/uapi/linux/if_xdp.h` to remove the mismatch and associated
warning.

Please consider applying this fix. Let me know if there are any
questions or if additional changes are needed.

vishal.c

diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
index 2f082b01ff228..42ec5ddaab8dc 100644
--- a/tools/include/uapi/linux/if_xdp.h
+++ b/tools/include/uapi/linux/if_xdp.h
@@ -117,12 +117,12 @@ struct xdp_options {
        ((1ULL << XSK_UNALIGNED_BUF_OFFSET_SHIFT) - 1)

 /* Request transmit timestamp. Upon completion, put it into tx_timestamp
- * field of union xsk_tx_metadata.
+ * field of struct xsk_tx_metadata.
  */
 #define XDP_TXMD_FLAGS_TIMESTAMP               (1 << 0)

 /* Request transmit checksum offload. Checksum start position and offset
- * are communicated via csum_start and csum_offset fields of union
+ * are communicated via csum_start and csum_offset fields of struct
  * xsk_tx_metadata.
  */
 #define XDP_TXMD_FLAGS_CHECKSUM                        (1 << 1)

