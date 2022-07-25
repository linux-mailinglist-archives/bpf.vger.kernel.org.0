Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256DB57FA4A
	for <lists+bpf@lfdr.de>; Mon, 25 Jul 2022 09:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiGYHbj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Jul 2022 03:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGYHbj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jul 2022 03:31:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE5B11C39
        for <bpf@vger.kernel.org>; Mon, 25 Jul 2022 00:31:38 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26P6F0YE031512;
        Mon, 25 Jul 2022 07:31:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2022-7-12; bh=RT+0ftfTP1W1l514im67iOPSLWa1kdeBipWgWJC7JcU=;
 b=Wz3qSu9n557WCmArpotOTd7vdd6hrmSAnhdIQKDJZTqSrMYJWI0ycsoTRnWVNMUxuQzj
 wo2LEi2WA/pI95KeK3NF0ZSwRTz+A8VuFrtq5rRcFrSuCiJ/GzQDXpMmfBzrf970eGj3
 /cPzL1IEZpJ9n6uCO9PXr8EEkT6Dvhi5IV/9KLEFFZi02mxeZrYfl/A2rmEsJmsEAQg+
 HGrlqhCg3afUc97i4y5BK3gHXcG4JmRLZ1tphQruaH+V1SOOHw8e7wb2qxsZFYhifsj+
 urDIe9CLIWe/NWw/ckb3TFA9DdHA+w1aMAeDDC8H13VinY1Qjh21aqGuvg4VlAT7aQky Vg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9hsjer9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jul 2022 07:31:08 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26P5oFek006262;
        Mon, 25 Jul 2022 07:31:08 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hh659waea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jul 2022 07:31:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOt3RTqhSil3DrRkOfTJ3VO5A1+VvWP6Ew/uZo36qZOXCM/r9rvtCIobgihtjQTf6YkRvMkeNqUNxaXlTLxoueS9vs+gStGlDrHpmbx4WMXZHIpfzUGpiQhLIAZVEdq1NUZt7ml4iMLvVW2OLVIo9z1Booies0cGyL8LTulMxXOv84qWkHUecfNWYMvpJmtlN3D6IfoZ1th7E6kRhFczSD5juZSX6bDPtqEmUkm7g1pmNpQQb5wDM0m5yBetQbEc1CRHsKcZt9SGdqmJeYl7+yiT686rmqms7PMIupeWfCW6/fgzslIfZnXG05pS+osg3Gj0OrDKArJ7rFZQvNrj6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RT+0ftfTP1W1l514im67iOPSLWa1kdeBipWgWJC7JcU=;
 b=JUWriIHut/RmLyKKMEmsggr8xqJ0pKaXSbQh5Ue/aXumLM1DjsA/L8uCdyYk6o0VLuDVwCn8ik8FrNNHmOhfwODz05Fagh8CRyAYbs9CKtI+6Ult4KdRkOnPrzsr52ljKjzy9Dd+n4UGhMQJPlOOd0sBolXFZokgjZr5yvzGqKCjDnXGEf+t9g54XgLvJk8BzQ8TzLEkiq+W7FoXu9ggrahSK/cK44vKhFJ78VUopQAvx3HG6akEauAcwmCW4PTht68MC8BN0n1YvorNgI+lY11VPPJWfJCEr+nsfVUAS3o7A6CE3C21rCMz9HQ/UAeoI9TA2ahQ87WDHEch8mvJSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RT+0ftfTP1W1l514im67iOPSLWa1kdeBipWgWJC7JcU=;
 b=mC6Zp/CO+q9rbMBCRd5UYI51+AvZStHtGPVxJqXgRDqKVgERigMNYbH4ZgJes0ekT6N1Q1gGG/xinTzNJXA4hZTbkEikNuOcGqqwFQnZv1L0qHF+AJ3KSThsRiCAS2lk80OONpl6sktKHPgS1QedNXIFJgmmi4IJQH6ml0nkxDc=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BL3PR10MB6257.namprd10.prod.outlook.com (2603:10b6:208:38c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Mon, 25 Jul
 2022 07:31:06 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b1c7:933:e8c2:f84f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b1c7:933:e8c2:f84f%8]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 07:31:06 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     andrii@kernel.org, mykolal@fb.com, ftokarev@gmail.com,
        jolsa@redhat.com
Cc:     ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next] selftests/bpf: augment snprintf_btf tests with string overflow tests
Date:   Mon, 25 Jul 2022 08:31:01 +0100
Message-Id: <1658734261-4951-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: DB6PR0301CA0097.eurprd03.prod.outlook.com
 (2603:10a6:6:30::44) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 600559e1-41e1-4f40-5039-08da6e0fa2c7
X-MS-TrafficTypeDiagnostic: BL3PR10MB6257:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xAssxtCAH4f972D8HcqEbafHwwemDIJWbs9dvRGBLSeanIik2j0x3kK7bXpLDr980BKehWmFHwRzNHujv9kq1J13fZxcTFJGff2Q1L/Nrr8p4SFglxetHxau49RRwIuNSfV5bsFlDU52/k9vTH7Ke1UMeTOeBhBB48jRIevKQ34OarUOi9FKOH/xNkVO2SVKqnYMheyk11lR9ujdCPrqEI4nbeY8lTpPOCvtVJWbbLY27bHieRAsRCBNCxM+4EqsiqZpQ65U8uxsIpkIiyq6FGDvNoG4bIRz0iMjDhUeCQfxzgPOUWLN2CRiQQfHTZD2oi27CeKQ8s4RyGTl1N3CqoQCEcn+0iLLgfHrXdOXucYgWQ7WlcUmfI9RgQWcUkGS53mpoiQfguJl7BLBRo5YASjlmmIvVwgOmTSeiD0huNpAQ70O7A3a/cAWXwrbh9BMoC+GD2IOOmFxh82YbxAygb5RzA8Tdwgn6m3uROi0t0CzKckXoRg2HuSLRC7jjBbeBud7ZVS+72MfV0+WufVeJKhMKunIanwd2jQYdicOLKmS+JaqvNh1NvfSMv7QMN7v6nJmcH1tFfIvJEPCRTk0ATV0uSLCTK4KlXPpIrlzAypU1HhrI5LCgH9Mt3ITyesoCq+wC4tj9EpZt8uwSLSHqn735vzQmrFcR/bESpwRcFDBspQqZh4Njp7myegEFTkYBqhJZg8d8MZh5sEPc5pSaAcltERVO7FWTZ9l+FZ8/YaVnr04SAsR4ArCFVBrIRf0TcrjnGKAHfeub2EzBF9A27oPLAKqIs2Yx/99pPqDuIqt+Z4fKnmVA0TFbhL5dTYdHsn3S6C4WHoa7tta06qC3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(136003)(366004)(39860400002)(316002)(38350700002)(38100700002)(36756003)(66476007)(4326008)(83380400001)(66556008)(8676002)(66946007)(7416002)(52116002)(2906002)(44832011)(6666004)(41300700001)(6506007)(186003)(966005)(6486002)(478600001)(107886003)(86362001)(5660300002)(26005)(2616005)(6512007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4BLOkstzJeNgMnZGnhrcZdOmwPP26YUm6r9LbZs/j6Od7DkGMEsYBitBK3iA?=
 =?us-ascii?Q?dDPLF/7/ksUrhiRMyXddZdAGv4ijfltm5m7FBpqVr9TLAn75R5+IHhcMQWf/?=
 =?us-ascii?Q?2UIbnajTcG310S+wZPvjpkzDLZ/dYPMbVFADpBu3ArSwtGwztMIp/Xjxdw2l?=
 =?us-ascii?Q?Po+QNE7BlhUYCWc6C9yxJnfWwVM6fu6pTLLmarTyqzoL5B5iv0hl05AXFx/t?=
 =?us-ascii?Q?mCgEp0Mff8Sz0FvMwXN+kiFA5hcgNu+c+rN6Y+iFXry8gZkcL11WrNphnhBi?=
 =?us-ascii?Q?t5NDt3Xpsu2LJm37coA5unqcGDLJBYPGGIAfUJ3xLPzs/sgHjA/uQonGqSsg?=
 =?us-ascii?Q?P6ahuNahSJzRkzMPaFBa7H0lmu8zAQIQfGBsAX0f2h4uk7bLBxRY6XCnWxUK?=
 =?us-ascii?Q?qqPOpoGRUoVv3jWWuGADnsrbgYFwyckHnTpinbGXQs2518Pmk0UN2aeMzJrW?=
 =?us-ascii?Q?369DP9+m4pr8K3vP1CsdYEA0QFDn4S36+uJQuUeCvBMB4CtSyX1t3XNUJDb3?=
 =?us-ascii?Q?Lx4Zu+AyDlM67gCbjszCyas/VRNqxgC17/x0tm1sJ+lLMuDcSfawI5H7feLZ?=
 =?us-ascii?Q?3AOsMzWZQXmB2KPZLFpZKvNRQxNyZigbZZPPzCikHrbKm0BlxA0hD838pElK?=
 =?us-ascii?Q?8+29jT38F2dY9x1/Kmt1pKIQ9Lqr0bg1WKgpZra9RtVuFMAOqoBLavmomNZC?=
 =?us-ascii?Q?t/uCb5uV/DxX9qq2eb5QfftGlOSSDapYeG+O6v8xLuftiHIIVv7Wjv5VbqPD?=
 =?us-ascii?Q?agoD9Zn1w7D3EdIrGcd3AcBbJzJo51xAcu5Lp9BpZ8iCYkxODWFBuNgh2Loz?=
 =?us-ascii?Q?jMhrXw52H+QpYLaqUCmyNMVE6DOZp2ZPtgww0dq4ug4ZtIUSkuTmpDOJVtVT?=
 =?us-ascii?Q?oMIB/HCLzrFEpfvKOLl/SQ8RHmWttF7KWzv+LDvJTH1ixFifZeO0EeMwn9QS?=
 =?us-ascii?Q?8feMx7qbsBjHlgbW+6vHiNVx+/zUx95dbjtbqjI2bH7NH1ltlRVTNn3TPEzd?=
 =?us-ascii?Q?HnCn1895+zBaLLTy2ZfzJDGK1iCN+l7TvP8mXtVyxiT88lNqAqqNHkdSZXdV?=
 =?us-ascii?Q?QPWYstlxGsSOAnsc+koq1FUIZlMV1remn/FMncwJ/RrvFHsAY6iAEa60IgZv?=
 =?us-ascii?Q?6lwZ26mCr3rSvWaOUx4jRrw8EL4rEkOWRrQcmUePjieZ6BkOahuxgXzKbEdO?=
 =?us-ascii?Q?QGl4fcga5l08xyVXPvFYZl+eIbuSNpICR9iqIPWaFRtcSVLeGS1XCjeOCAsP?=
 =?us-ascii?Q?lWjbjIV7Yh2clWp8deYlILqQHNpvWO9qLQDMquC68p3IQmxomz4cm5FZff+T?=
 =?us-ascii?Q?qztkkqFK9NdsVA++d2KsUHfRR5nbGl4KG1h7FXgBj8m4QjTv/q3Srtga/jDl?=
 =?us-ascii?Q?CJ3pCXmyWFI1wrrDfVnDXELPCDHegxn3Sk808NLCBHO5j09Br2MiWMvk2L04?=
 =?us-ascii?Q?Gva//f9XssiFCTMFk/W92mN98UmSPH8uXf74Sy5oFGBz+WiB3MWDpJVCrqRf?=
 =?us-ascii?Q?gBHNe/ZAfRvgRB08rGZWjh0G+MLkAv1dn7Q8iiWob/9fgXLst4sC/vLoHEuq?=
 =?us-ascii?Q?LHywUNn51j1Td27ZyAwqdO6nXaMQm5Urk/GF463O?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 600559e1-41e1-4f40-5039-08da6e0fa2c7
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 07:31:06.3238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DmZJzN2rFSSwjdcdu+Gc7jVMhUIXItHL6DFCeuXhMvqw5EGK5c85AnH9i/Z5eqUIoig9Nz3EhoQ/Y30PQrFlJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6257
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-23_02,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207250031
X-Proofpoint-ORIG-GUID: _bh56JY6AB1uVlxHf1SHZT5_Vf4RdmFl
X-Proofpoint-GUID: _bh56JY6AB1uVlxHf1SHZT5_Vf4RdmFl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

add tests that verify bpf_snprintf_btf() behaviour with strings that

- exactly fit the buffer (string size + null terminator == buffer_size)
- overrun the buffer (string size + null terminator == buffer size + 1)
- overrun the buffer (string size + null terminator == buffer size + 2)

These tests require [1] ("bpf: btf: Fix vsnprintf return value check")

...which has not landed yet.

[1] https://lore.kernel.org/bpf/20220711211317.GA1143610@laptop/

Suggested-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/progs/netif_receive_skb.c        | 41 ++++++++++++++++++++--
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/netif_receive_skb.c b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
index 1d8918d..9fc48e4 100644
--- a/tools/testing/selftests/bpf/progs/netif_receive_skb.c
+++ b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
@@ -49,7 +49,7 @@ static int __strncmp(const void *m1, const void *m2, size_t len)
 }
 
 #if __has_builtin(__builtin_btf_type_id)
-#define	TEST_BTF(_str, _type, _flags, _expected, ...)			\
+#define	TEST_BTF_SIZE(_str, _size, _type, _flags, _expected, ...)			\
 	do {								\
 		static const char _expectedval[EXPECTED_STRSIZE] =	\
 							_expected;	\
@@ -69,10 +69,13 @@ static int __strncmp(const void *m1, const void *m2, size_t len)
 			ret = -EINVAL;					\
 			break;						\
 		}							\
-		ret = bpf_snprintf_btf(_str, STRSIZE,			\
+		ret = bpf_snprintf_btf(_str, _size,			\
 				       &_ptr, sizeof(_ptr), _hflags);	\
-		if (ret)						\
+		if (ret	< 0) {						\
+			bpf_printk("bpf_snprintf_btf_failed (%s): %d\n",\
+				   _str, _expectedval, ret);		\
 			break;						\
+		}							\
 		_cmp = __strncmp(_str, _expectedval, EXPECTED_STRSIZE);	\
 		if (_cmp != 0) {					\
 			bpf_printk("(%d) got %s", _cmp, _str);		\
@@ -82,6 +85,10 @@ static int __strncmp(const void *m1, const void *m2, size_t len)
 			break;						\
 		}							\
 	} while (0)
+
+#define TEST_BTF(_str, _type, _flags, _expected, ...)			\
+	TEST_BTF_SIZE(_str, STRSIZE, _type, _flags, _expected,		\
+		      __VA_ARGS__)
 #endif
 
 /* Use where expected data string matches its stringified declaration */
@@ -98,7 +105,9 @@ int BPF_PROG(trace_netif_receive_skb, struct sk_buff *skb)
 	static __u64 flags[] = { 0, BTF_F_COMPACT, BTF_F_ZERO, BTF_F_PTR_RAW,
 				 BTF_F_NONAME, BTF_F_COMPACT | BTF_F_ZERO |
 				 BTF_F_PTR_RAW | BTF_F_NONAME };
+	static char _short_str[2] = {};
 	static struct btf_ptr p = { };
+	char *short_str = _short_str;
 	__u32 key = 0;
 	int i, __ret;
 	char *str;
@@ -141,6 +150,32 @@ int BPF_PROG(trace_netif_receive_skb, struct sk_buff *skb)
 	TEST_BTF_C(str, int, 0, -4567);
 	TEST_BTF(str, int, BTF_F_NONAME, "-4567", -4567);
 
+	/* overflow tests; first string + terminator fits, others do not. */
+	TEST_BTF_SIZE(short_str, sizeof(_short_str), int, BTF_F_NONAME, "1", 1);
+	if (ret != 1) {
+		bpf_printk("bpf_snprintf_btf() should return 1 for '%s'/2-byte array",
+			   short_str);
+		ret = -ERANGE;
+	}
+	/* not enough space to write "10", write "1", return 2 for number of bytes we
+	 * should have written.
+	 */
+	TEST_BTF_SIZE(short_str, sizeof(_short_str), int, BTF_F_NONAME, "1", 10);
+	if (ret != 2) {
+		bpf_printk("bpf_snprintf_btf() should return 2 for '%s'/2-byte array",
+			   short_str);
+		ret = -ERANGE;
+	}
+	/* not enough space to write "100", write "1", return 3 for number of bytes we
+	 * should have written.
+	 */
+	TEST_BTF_SIZE(short_str, sizeof(_short_str), int, BTF_F_NONAME, "1", 100);
+	if (ret != 3) {
+		bpf_printk("bpf_snprintf_btf() should return 3 for '%s'/3-byte array",
+			   short_str);
+		ret = -ERANGE;
+	}
+
 	/* simple char */
 	TEST_BTF_C(str, char, 0, 100);
 	TEST_BTF(str, char, BTF_F_NONAME, "100", 100);
-- 
1.8.3.1

