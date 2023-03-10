Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289516B4D17
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 17:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjCJQfp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 11:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjCJQe0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 11:34:26 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A459F0FFF
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 08:31:54 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32AAUZnd026354;
        Fri, 10 Mar 2023 14:51:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=lXjADzX0pkKJ77jDK0QzWuYsZ1iNQwL3vdiKcdaQxBU=;
 b=08fvTak57n6xVRY0hLOrhF638wUbmZhKRAgrmFfZLsRp47nYIPlRbh5n4ipE7hkVQd77
 O/Yv5+3eBX6Xpgz14d2cNq3moG7EKVGtvcjZMxo7+CewYBTGHoMZK/QwYDNzL8B729Bh
 6d0NdoUAsF8jfGzIdry5Hpkan4XoCFGgDI/1WEpSVSsoG6TiAirvOSvz3id14x5B95z0
 tElov+ilAiUWRuDk+W4LLcLf7ujThO64HzTkmL+BSnALaBNqPbvFxR926ckTZPyhitm5
 hHsZMWKGSnYt6BOIZrnJAVTmDrC5fkcVfPX2uX4t2iXO4K9rLdhHlO/e5sDdpiyTbw5b 6w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p415j5g9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 14:51:03 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32AEMSss021509;
        Fri, 10 Mar 2023 14:51:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6fub0dxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 14:51:02 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32AEosCP013152;
        Fri, 10 Mar 2023 14:51:01 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-184-199.vpn.oracle.com [10.175.184.199])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3p6fub0dkf-3;
        Fri, 10 Mar 2023 14:51:01 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     acme@kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        eddyz87@gmail.com, haoluo@google.com, jolsa@kernel.org,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        sinquersw@gmail.com, martin.lau@kernel.org, songliubraving@fb.com,
        sdf@google.com, timo@incline.eu, yhs@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 2/3] dwarves_fprintf: support skipping modifier
Date:   Fri, 10 Mar 2023 14:50:49 +0000
Message-Id: <1678459850-16140-3-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1678459850-16140-1-git-send-email-alan.maguire@oracle.com>
References: <1678459850-16140-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_06,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303100121
X-Proofpoint-GUID: LbenSbZLSmk0PcaoFKeq7OSfynuWJWlD
X-Proofpoint-ORIG-GUID: LbenSbZLSmk0PcaoFKeq7OSfynuWJWlD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When doing BTF comparisons between functions defined in multiple
CUs, it was noticed a few critical functions failed prototype
comparisons due to multiple "const" modifiers; for example:

function mismatch for 'memchr_inv'('memchr_inv'): 'void * ()(const const void  * , int, size_t)' != 'void * ()(const void  *, int, size_t)'

function mismatch for 'strnlen'('strnlen'): '__kernel_size_t ()(const const char  * , __kernel_size_t)' != '__kernel_size_t ()(const char  *, size_t)'

(note the "const const" in the first parameter.)

As such it would be useful to omit modifiers for comparison
purposes.  Also noted was the fact that for the "no_parm_names"
case, an extra space was being emitted in some cases, also
throwing off string comparisons of prototypes.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 dwarves.h         |  1 +
 dwarves_fprintf.c | 26 ++++++++++++++++----------
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/dwarves.h b/dwarves.h
index d04a36d..7a319d1 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -134,6 +134,7 @@ struct conf_fprintf {
 	uint8_t	   strip_inline:1;
 	uint8_t	   skip_emitting_atomic_typedefs:1;
 	uint8_t	   skip_emitting_errors:1;
+	uint8_t    skip_emitting_modifier:1;
 };
 
 struct cus;
diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index 5c6bf9c..b20a473 100644
--- a/dwarves_fprintf.c
+++ b/dwarves_fprintf.c
@@ -506,7 +506,8 @@ static const char *tag__ptr_name(const struct tag *tag, const struct cu *cu,
 				struct tag *next_type = cu__type(cu, type->type);
 
 				if (next_type && tag__is_pointer(next_type)) {
-					const_pointer = "const ";
+					if (!conf->skip_emitting_modifier)
+						const_pointer = "const ";
 					type = next_type;
 				}
 			}
@@ -580,13 +581,16 @@ static const char *__tag__name(const struct tag *tag, const struct cu *cu,
 				   *type_str = __tag__name(type, cu, tmpbf,
 							   sizeof(tmpbf),
 							   pconf);
-			switch (tag->tag) {
-			case DW_TAG_volatile_type: prefix = "volatile "; break;
-			case DW_TAG_const_type:    prefix = "const ";	 break;
-			case DW_TAG_restrict_type: suffix = " restrict"; break;
-			case DW_TAG_atomic_type:   prefix = "_Atomic ";  break;
+			if (!conf->skip_emitting_modifier) {
+				switch (tag->tag) {
+				case DW_TAG_volatile_type: prefix = "volatile "; break;
+				case DW_TAG_const_type: prefix = "const"; break;
+				case DW_TAG_restrict_type: suffix = " restrict"; break;
+				case DW_TAG_atomic_type:   prefix = "_Atomic ";  break;
+				}
 			}
-			snprintf(bf, len, "%s%s%s ", prefix, type_str, suffix);
+			snprintf(bf, len, "%s%s%s%s", prefix, type_str, suffix,
+				 conf->no_parm_names ? "" : " ");
 		}
 		break;
 	case DW_TAG_array_type:
@@ -818,9 +822,11 @@ print_default:
 	case DW_TAG_const_type:
 		modifier = "const";
 print_modifier: {
-		size_t modifier_printed = fprintf(fp, "%s ", modifier);
-		tconf.type_spacing -= modifier_printed;
-		printed		   += modifier_printed;
+		if (!conf->skip_emitting_modifier) {
+			size_t modifier_printed = fprintf(fp, "%s ", modifier);
+			tconf.type_spacing -= modifier_printed;
+			printed		   += modifier_printed;
+		}
 
 		struct tag *ttype = cu__type(cu, type->type);
 		if (ttype) {
-- 
1.8.3.1

