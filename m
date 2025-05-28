Return-Path: <bpf+bounces-59161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B3DAC667A
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 11:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DE8D3A4523
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 09:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1C527A469;
	Wed, 28 May 2025 09:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XLYJ3d3x"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C636827A12D;
	Wed, 28 May 2025 09:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748426316; cv=none; b=gC+AeCW1h+YZgkJXEj2P9CLPviu0WbdtR4QbGOGUXWrVva46EoxtqcAZ+9PtlHhKYO50E101sPnuYsf1JCEP9+i0GMWWOdoEk6Jy8NlwUi+1VladK1c+KtOXArLj49nhXlwH1H65j7o9F+ztKKJnfSZXLq5pGUJSAnlQ3FXh4Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748426316; c=relaxed/simple;
	bh=1KH5I5umT7kjAyqc0TMAOssbMAv8dAo8icKnDwyTGBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6E9TDsIO69GrjQADf2wW+ERDrrEKaKXZ+AXbzZzFMRsk3Ka9zHu0paEwI9XgcdrbwcDrYQ9ppnkbPMXVl5CPYxYMUeAIrgIVlsr4NM9U4vA8lq4vmNHeFpahF0OoxZgu30FTjOPBHcQ9rq29Y8uhyp/gyQKbcjcelnvSzX4ArY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XLYJ3d3x; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S1h87P011936;
	Wed, 28 May 2025 09:58:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=KApP1
	V2t66NyyxiRQ89rjuBuiqtHb/P/tfRlBAZebQc=; b=XLYJ3d3xchO0eETYX3TVt
	78aZ5wK7CqzhA8xjUo3BRSxtRp9su5qg+OeetpM9tO8iacPPzFDvTzeDC1zj47Je
	Lacgoch8Q0IIhHAGJdUxKnZcIcg0wpbKRAHu1Vamj/qeFRgdAuWZrrDDHD1DHZEI
	TnUi0l/03J45hpGePzGVPYcswqnY50Ts8xnA46/6Zx3hN5MBPRqyL14oWz2/JvHh
	lfjbDGHuZ268Q30WyM1EYDtV3BLAe5BkcW+O3Z3Y8BHRNinw+mkO3B9oOSPgVWnr
	BJvuwtzrfAsOOfZPNBa5l69LCdzx+D7zEpllD0JGDFHR88kkS3LAZHkIYqrspWKw
	A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v3pd5981-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 09:58:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54S7j59s025374;
	Wed, 28 May 2025 09:58:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jaev3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 09:58:00 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54S9qwVu007194;
	Wed, 28 May 2025 09:58:00 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-51-118.vpn.oracle.com [10.154.51.118])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 46u4jaeuw6-6;
	Wed, 28 May 2025 09:57:59 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, masahiroy@kernel.org, qmo@kernel.org,
        ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org,
        ttreyer@meta.com, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v5 bpf-next 5/9] libbpf: BTF validation can use kind layout for unknown kinds
Date: Wed, 28 May 2025 10:57:39 +0100
Message-ID: <20250528095743.791722-6-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250528095743.791722-1-alan.maguire@oracle.com>
References: <20250528095743.791722-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_05,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=971 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505280086
X-Proofpoint-ORIG-GUID: jdMMcr5NM4iut--XPf28qlcWO0ivs1R5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDA4NyBTYWx0ZWRfX2gZC58nJD2Za LXaGTRE0dkexrW8FsQXoxY8OPhayqU/uVaW1AhZowLEaAkYfnhLFjv4AQOiD8d5hXXyhLN6W2ah VvuyX5e8RcZS7VTYVvy+YinKTMZjfGdGM1eC3YehMrd6Qd2yI385/zCHrcjOoiRLojOW7GL0LoB
 EFMXGEWuG+Rf/ArsCBhuHstP2PunxUjckIHNz3IiTPbSjknoJaPxOfdnrwFzNz9G+mpAJdH3SEZ 3zd18uzN3bL6v2GCnoPZO3eJfprr6e+EmvfKjdtYJsmbUw/l/DpEUqQbP9tWOCCmoJXgNxX6ioI 11LgkRMv3khh2tiX76UyA0Xg+PvhlmF6z7DWeMM5iL227u50lZJLVTXNdt4oJkmfebmIjeqzSmK
 RvtT4hxkyvfUoL7/LdD42bmJQo7O+1lOocvQMWH660Rg0y3lYQkxalGtP9xnQBG+O9AIuY9y
X-Authority-Analysis: v=2.4 cv=UZNRSLSN c=1 sm=1 tr=0 ts=6836de2f b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=aoasKMbPG5nyLhygJAEA:9 a=zgiPjhLxNE0A:10 a=zZCYzV9kfG8A:10 cc=ntf
 awl=host:13206
X-Proofpoint-GUID: jdMMcr5NM4iut--XPf28qlcWO0ivs1R5

BTF parsing can use kind layout to navigate unknown kinds, so
btf_validate_type() should take kind layout information into
account to avoid failure when an unrecognized kind is met.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index f3c4dc0c9007..1116bc098d00 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -702,8 +702,12 @@ static int btf_validate_type(const struct btf *btf, const struct btf_type *t, __
 		break;
 	}
 	default:
-		pr_warn("btf: type [%u]: unrecognized kind %u\n", id, kind);
-		return -EINVAL;
+		/* Kind may be represented in kind layout information. */
+		if (btf_type_size_unknown(btf, t) < 0) {
+			pr_warn("btf: type [%u]: unrecognized kind %u\n", id, kind);
+			return -EINVAL;
+		}
+		break;
 	}
 	return 0;
 }
-- 
2.39.3


