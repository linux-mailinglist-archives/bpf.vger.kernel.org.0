Return-Path: <bpf+bounces-76598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D41FFCBD245
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 10:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AB1EB300C505
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 09:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B24E3242AF;
	Mon, 15 Dec 2025 09:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SVCSGrEm"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720CA20CCCA;
	Mon, 15 Dec 2025 09:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765790400; cv=none; b=dzGJ0VIBuyqzpx0Ejj8lPrH0oGMebo4DkOZLsmk2Yu0/6nt3H/iau/OBVsIfXsnycCXpIBB59fpPuJxtpBwJ10SiEs98JeCz/fV4fI0K+sasRKoKogm+SfpLktIfrRIIKw7ARAbJKeySh6VaRoZl+W525dnSFQjZAc+LX20yE50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765790400; c=relaxed/simple;
	bh=czKYZZgZ2h0a5CmzivUgwKfNPN+R6GkTefzcKKvZWJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cd/JMBjUF4BYuxCiygfbipa0CFJtqA6vlnOHxRaxXR9+ToFrLebpHUOT0JGiqeiwEQlq/ZW3GY2aUUh6X1uVSY2L5uTzcRS4J7H1EcuBCb4pbWLIdw23d2Ih5IBB15L3vewYaHTtpG7nD45xVYODqzru2u2zQqpV7lQ7L02NmBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SVCSGrEm; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BF7uLn61904223;
	Mon, 15 Dec 2025 09:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=lvNPi
	z7ohG1WLb4T5NdAioZy88cg1kgdYvVyxmSbnVs=; b=SVCSGrEmWHEPGM9U7dWR5
	JgvgPBkvEd/yo/8RHP14QrWpxbrjOS9MjRBP/EnKrie+d3yL/INlrGNwdWTPm3Ir
	fmmVPEhoxDJlcFhWjVTm2rSwCtxMSSzTls5AFL1B/326xRnt1h68meozIJ3lKv9+
	oG3q0/kYsoqqnxsjyJJDzt5FSurz/2OOcwHBVq8RdH3f1I65kpdZ2ZCegTdUOCz/
	3LAmkJMFHNj06x2cQNeBmQ+t8DhgHVaYIxSd6sHK52yVI5xCAu+yCznugetZyxTA
	05Ao6nWtXd+eKOjG8WA2Bneqr95c8DTnjE9p/hDHSmoDHE1P6qCSnAy4xhiboiER
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b106c9ne5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 09:18:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BF90jB1025190;
	Mon, 15 Dec 2025 09:18:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk8ygv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 09:18:26 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BF9Hdwa027566;
	Mon, 15 Dec 2025 09:18:25 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-2.vpn.oracle.com [10.154.53.2])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4b0xk8yg99-6;
	Mon, 15 Dec 2025 09:18:25 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, ttreyer@meta.com,
        mykyta.yatsenko5@gmail.com, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v8 bpf-next 05/10] libbpf: BTF validation can use kind layout for unknown kinds
Date: Mon, 15 Dec 2025 09:17:25 +0000
Message-ID: <20251215091730.1188790-6-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251215091730.1188790-1-alan.maguire@oracle.com>
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_01,2025-12-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150078
X-Proofpoint-ORIG-GUID: kV2wyoFiQKd8ogRpRdL78-lEIiUo8CIT
X-Proofpoint-GUID: kV2wyoFiQKd8ogRpRdL78-lEIiUo8CIT
X-Authority-Analysis: v=2.4 cv=et/SD4pX c=1 sm=1 tr=0 ts=693fd263 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=aoasKMbPG5nyLhygJAEA:9 a=zgiPjhLxNE0A:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDA3OCBTYWx0ZWRfX9qSO2+ZT53eI
 PDsBlNts9V7nzXPB471o3Dm3ZgtbO90/62kVDWqzVy6OrSLjRw18ETSP5dErKrPtAP0JPbxiZiJ
 CTrJaejYIXdL5cP5DbCoodoB8Kdt8wR8j2ARie5rII5eCFREbJkrc+BhadyT7tBr6Zt0S6bn7H8
 bsgtAFvwk1T36pCDELD6kGDYKWhutoYw7YWo+LTCevhYo7iHcp1Fo1PqZzAKxXjWrQtRQDNfy/m
 HI4DO+CILcVV3TjWCZhtqpVhtsVY+5CfSWLftFpUL9b/YE0cJ97ZGd9sybY9bBgaF7D/VCgpc32
 7ubTi/yGqdRDU98Bo6PdqLOACeWxVl+fdmuTe1WwHz2wUjVy6gKIuffqwkgUwh7fN9TDsHliJQ6
 ij/a3uWV1DG5MUE80XaMGvVi2Hvamg==

BTF parsing can use kind layout to navigate unknown kinds, so
btf_validate_type() should take kind layout information into
account to avoid failure when an unrecognized kind is met.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 589a9632a630..6098c8d1e26a 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -705,8 +705,12 @@ static int btf_validate_type(const struct btf *btf, const struct btf_type *t, __
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


