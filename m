Return-Path: <bpf+bounces-65206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0013B1DA1C
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 16:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 673295601B8
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 14:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A88265CC5;
	Thu,  7 Aug 2025 14:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HCdg8cJ7"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6F2264FB5;
	Thu,  7 Aug 2025 14:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754577744; cv=none; b=TxqsSFWSlM+P12Aa5TbK8vZScJuhXCNeSLBEncrR5UABJL39r+rqrnPROFGPW9EMIqFoXB97NIUKiuLcVfCePp3B2uPTSja4I0bApmrbEU45XtLIvI5RlPuvzgZG/mbwdx+EZJqEIGvMVZ1rRjTR6tcZH8kpgtVYOmVOXHAZVy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754577744; c=relaxed/simple;
	bh=Si9nTj362qNOMoGUnGa32eyz+Jw8YDP7QQC3ApMtlYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKTC3OImSqR2ZJM/q61zI073y9apzxkC5E20gNtu0SCdlY/iuG6VwYFzDmqQpJ+RlsnEZ5PAQWBGEp5HZGGrUNKxgsFF2S4iC2fCyMzYA8pc/bHNcZV/bO/jO9U3HvN/TTtUULG+oF/X/GKlAYxm+leW6Gy3cHDKWZ1N4H2uAHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HCdg8cJ7; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5777NEq3028483;
	Thu, 7 Aug 2025 14:42:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=zCZ5k
	mfgdxhymZJNYMT+AXz3bDI1HBoXQ6FNboAavA4=; b=HCdg8cJ7M1olhqYpElJQd
	DDwfTzyTJ6s1Bmt4EV7qsamC9Wa+oLT1UuJDG9wn4kE3un76tdxvPuIyqTNlxDSf
	NYYBZMeZdK7UR/eUIxW73j53DbeegtvBhsdeFLpH1U6TT0Zl6MyBC0PyGWULwuxR
	4KaIuWqAU3V6J/b0eqEvHDx9vKvqj9Z3+SGZRlUZFvOH7CfHUx61IpXq22mcv4qA
	EKjXB7n3p28NdOTjBKGVZh54j225sH0hAefiUyjc5EpyIi46SPzwO3hN+1cdSGmX
	scGm6ozNEA7StTWz5PygbMZsa8DVmWQz8HSNDVvN/ePY4fC7qAzrrntQlwrmJWp1
	A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvh47yx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 14:42:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 577EKWEY005619;
	Thu, 7 Aug 2025 14:42:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwyhvx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 14:42:14 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 577EgAIp014830;
	Thu, 7 Aug 2025 14:42:13 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-8.vpn.oracle.com [10.154.53.8])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 48bpwyhvt5-4;
	Thu, 07 Aug 2025 14:42:13 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC dwarves 3/6] pahole: Add btf_encode to conf_load
Date: Thu,  7 Aug 2025 15:42:06 +0100
Message-ID: <20250807144209.1845760-4-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250807144209.1845760-1-alan.maguire@oracle.com>
References: <20250807144209.1845760-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508070118
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDExOSBTYWx0ZWRfXxt8URy3zisEJ
 cL+SlSa5pkeFaA365nKmxY00Q43Kqo485VGOogV85NnwgEABUsNmbwOvJFmTT6qMOSGetyiBWqH
 5QY4M5mMYHdMz0jNOwcT8Kd6HQ5O/cR4Iiz24k7R30Eb9e2QwJuOLBpZsUylHIkg1wBAtkE6sFe
 +5EMwktFMu/X10Hkk1v+10jgLBXJaw0LHAvYGs5s8XP6Efrf/sPMcsUvc0hgcgPHrYgmTg7ANTc
 qjk5DJ+u4XtpwjwIi08VM5es7tWZT4ZmKKuTiBjovKRUWK4485ZjLSjG0IhVjvSW7fTiJyj2Fzx
 BlSmZ3uByE1K60D91q5BJpK3V/z9GY8M5wwHHGNkDmfQwDdmusOmyxwku0XZV6Bqc0fObNmmJBI
 1QVIuOXOvtKYqXhFAAaWAVoLUwbbQa0Bf7MwLewMhDcN0vG/AP4dfyqCyXxTGbNpX/xFe5rL
X-Proofpoint-ORIG-GUID: H0IqbKP17Ba-K9R5mCusZNGnSxgI8ydS
X-Proofpoint-GUID: H0IqbKP17Ba-K9R5mCusZNGnSxgI8ydS
X-Authority-Analysis: v=2.4 cv=Hpl2G1TS c=1 sm=1 tr=0 ts=6894bb47 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8 a=vogYJwDi1vZsJDmEXQkA:9 cc=ntf
 awl=host:12069

This will allow us to take BTF encoding-specific actions in
the btf_loader.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 dwarves.h |  1 +
 pahole.c  | 15 +++++++--------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/dwarves.h b/dwarves.h
index 21d4166..feb7402 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -87,6 +87,7 @@ struct conf_load {
 	bool			ignore_inline_expansions;
 	bool			ignore_labels;
 	bool			ptr_table_stats;
+	bool			btf_encode;
 	bool			skip_encoding_btf_decl_tag;
 	bool			skip_missing;
 	bool			skip_encoding_btf_type_tag;
diff --git a/pahole.c b/pahole.c
index ef01e58..96c748b 100644
--- a/pahole.c
+++ b/pahole.c
@@ -32,7 +32,6 @@
 static struct btf_encoder *btf_encoder;
 static char *detached_btf_filename;
 struct cus *cus;
-static bool btf_encode;
 static bool ctf_encode;
 static bool sort_output;
 static bool need_resort;
@@ -1864,7 +1863,7 @@ static error_t pahole__options_parser(int key, char *arg,
 							break;
 	case ARGP_btf_encode_detached:
 		  detached_btf_filename = arg; // fallthru
-	case 'J': btf_encode = 1;
+	case 'J': conf_load.btf_encode = true;
 		  conf_load.get_addr_info = true;
 		  conf_load.ignore_alignment_attr = true;
 		  // XXX for now, test this more thoroughly
@@ -3217,7 +3216,7 @@ static enum load_steal_kind pahole_stealer(struct cu *cu, struct conf_load *conf
 	    print_enumeration_with_enumerator(cu, enumerator_name))
 		return LSK__DELETE; // Maybe we can find this in several CUs, so don't stop it
 
-	if (btf_encode) {
+	if (conf_load->btf_encode) {
 		return pahole_stealer__btf_encode(cu, conf_load);
 	}
 #if 0
@@ -3530,7 +3529,7 @@ int main(int argc, char *argv[])
 	// and as this is at this point unintended, avoid that.
 	// Next we need to just skip object files that don't have the format we
 	// expect as the source for BTF encoding, i.e. no DWARF, no BTF, no problema.
-	if (btf_encode && conf_load.format_path == NULL)
+	if (conf_load.btf_encode && conf_load.format_path == NULL)
 		conf_load.format_path = "dwarf";
 
 	if (show_running_kernel_vmlinux) {
@@ -3593,7 +3592,7 @@ int main(int argc, char *argv[])
 				base_btf_file, libbpf_get_error(conf_load.base_btf));
 			goto out;
 		}
-		if (!btf_encode && !ctf_encode) {
+		if (!conf_load.btf_encode && !ctf_encode) {
 			// Force "btf" since a btf_base is being informed
 			conf_load.format_path = "btf";
 		}
@@ -3641,7 +3640,7 @@ try_sole_arg_as_class_names:
 
 	err = cus__load_files(cus, &conf_load, argv + remaining);
 	if (err != 0) {
-		if (class_name == NULL && !btf_encode && !ctf_encode) {
+		if (class_name == NULL && !conf_load.btf_encode && !ctf_encode) {
 			class_name = argv[remaining];
 
 			if (class_name == NULL) {
@@ -3658,7 +3657,7 @@ try_sole_arg_as_class_names:
 			goto try_sole_arg_as_class_names;
 		}
 
-		if (btf_encode || ctf_encode) {
+		if (conf_load.btf_encode || ctf_encode) {
 			// If encoding is asked for and there is no DEBUG info to encode from,
 			// there are no errors, continue...
 			goto out_ok;
@@ -3717,7 +3716,7 @@ try_sole_arg_as_class_names:
 	type_instance__delete(header);
 	header = NULL;
 
-	if (btf_encode && btf_encoder) { // maybe all CUs were filtered out and thus we don't have an encoder?
+	if (conf_load.btf_encode && btf_encoder) { // maybe all CUs were filtered out and thus we don't have an encoder?
 		err = btf_encoder__encode(btf_encoder, &conf_load);
 		btf_encoder__delete(btf_encoder);
 		if (err) {
-- 
2.43.5


