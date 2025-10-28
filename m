Return-Path: <bpf+bounces-72644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A030C173F0
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 23:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7AC574F9A87
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 22:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C9136A5E7;
	Tue, 28 Oct 2025 22:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fpeolINJ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA143557FE
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 22:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761692179; cv=none; b=Gp/DntwewLnRz3d0K86Aabo0odeTFONuAXC8gsrx28h99Br//AaFPHELWklH2Z5f5vpWX7ztMxRgnXh8tz79KBqb6RLfA2hd92M5aWXxe8/IKU2EBeK4xTQ4W+tM83TUD5vyZ6BuqInoFGkQOfHH+1QIz6tz6A8R1fIZsMhlv+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761692179; c=relaxed/simple;
	bh=zNE2LkYBE1AfnhkzSQtQjrR2ixibO4hF2kKDWh9mL3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=syF4IVcunbLd5SM3LuRLWQ3VtyZcc7jgDU7rvr1UpcbX1w64NNgY6aReNwZB4AcqjM4sVzYP+ZBYucUQy4XxI+/j5f8t5EoSpYbBF9JOkEoMsKfoeVipWFkbpWeAWPi9sYYx159RJsuG9lCOwbX5HxNQG2ltRWJcTiFjxcfBlgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fpeolINJ; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SMCh2T030726;
	Tue, 28 Oct 2025 22:55:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=x+n/+
	Ats/aYSejTHy5UAOY+8Mhm7JLyoFaunsScIIh4=; b=fpeolINJctwxaiThmB4Ol
	xL+Mw7c47zVyFOHGQ1kdFzm6vobYLE4mzBK1UTdyO8ZVpMauZ85Xyxgt74i2kqpx
	r0fvfpZ49c1xyB7ukHQxzTopDDnIKwv8wMybIYkLH2Y51Uo0Lb6AeXcWo/mTNmsE
	Nz6GCDdzMptF0Cwum6axAZ4MKqIcundfXwoQODhYx5GKAO8bW7dpXGSCTa4KTrWJ
	H2MLMs/VL8gmcuU+7zTxR6b8h6ShbRhjIMmbTz9L6EvIi9m62cQM2SKUC2JSN3m7
	1CuiWUNgrnl+onZ814xNtaP4ud+pxpOVCKSN9Vr1q5nm2t+qcp/xgkWr61u5iMzG
	A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a33vygbc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 22:55:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59SLWKNc012210;
	Tue, 28 Oct 2025 22:55:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a33vwek62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 22:55:52 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59SMpl5u001957;
	Tue, 28 Oct 2025 22:55:52 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-54-249.vpn.oracle.com [10.154.54.249])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a33vwek50-2;
	Tue, 28 Oct 2025 22:55:51 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org
Cc: eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, ihor.solodrai@linux.dev, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 1/2] libbpf: Fix parsing of multi-split BTF
Date: Tue, 28 Oct 2025 22:55:43 +0000
Message-ID: <20251028225544.1312356-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251028225544.1312356-1-alan.maguire@oracle.com>
References: <20251028225544.1312356-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510280194
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2MiBTYWx0ZWRfXz7r5itPfhuld
 xCrKA7ooOp6IwHELE+EbUuiES9f+/BJmDXUQ3cuy2rraf/KeSjCYAjVZ0Gh6bNEra+6+/YCW/2H
 uF0HJp/aNCD95PBcczebIsJXFEb02qsoxr/UisjpL575Sl0IYkRrfm0qUvnkU058H6PhPXlsvQy
 SboprnsUFmmjB2gxDjDhURIpRTF4OK5El78iNWOFzM5EGGqT5VcmQsMklcuIdam9qXY1NUQfQzc
 hU50etjUP+w5WqkV3ZE6yHnGFSTkctF6tLQTtRFbrwQkhoXotuCGbzkRQvHQqgXMHUJbXZnPcxi
 2Lg9lEgra0ji+MlPY6uqlXlXK01o/eSRuCPIjbgW3fxjeWf+oVZIs7x1++LhKQChnFMRjHb6363
 A8hLwBjzy7Rde35NrZfywW6sfzyT+Q==
X-Proofpoint-ORIG-GUID: LWg3LMxsRgfvuEcHjTJu-kwW1TTHeIBl
X-Authority-Analysis: v=2.4 cv=M8xA6iws c=1 sm=1 tr=0 ts=690149f9 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=XlrTAmi2F6-cTnHVTwAA:9
X-Proofpoint-GUID: LWg3LMxsRgfvuEcHjTJu-kwW1TTHeIBl

When creating multi-split BTF we correctly set the start string offset
to be the size of the base string section plus the base BTF start
string offset; the latter is needed for multi-split BTF since the
offset is non-zero there.

Unfortunately the BTF parsing case needed that logic and it was
missed.

Fixes: 4e29128a9ace ("libbpf/btf: Fix string handling to support multi-split BTF")
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 18907f0fcf9f..9f141395c074 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1061,7 +1061,7 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf, b
 	if (base_btf) {
 		btf->base_btf = base_btf;
 		btf->start_id = btf__type_cnt(base_btf);
-		btf->start_str_off = base_btf->hdr->str_len;
+		btf->start_str_off = base_btf->hdr->str_len + base_btf->start_str_off;
 	}
 
 	if (is_mmap) {
@@ -5818,7 +5818,7 @@ void btf_set_base_btf(struct btf *btf, const struct btf *base_btf)
 {
 	btf->base_btf = (struct btf *)base_btf;
 	btf->start_id = btf__type_cnt(base_btf);
-	btf->start_str_off = base_btf->hdr->str_len;
+	btf->start_str_off = base_btf->hdr->str_len + base_btf->start_str_off;
 }
 
 int btf__relocate(struct btf *btf, const struct btf *base_btf)
-- 
2.39.3


