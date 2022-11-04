Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA1C61A572
	for <lists+bpf@lfdr.de>; Sat,  5 Nov 2022 00:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiKDXLz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 19:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiKDXLa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 19:11:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C23B3FB88;
        Fri,  4 Nov 2022 16:11:29 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4Kj8Xq014047;
        Fri, 4 Nov 2022 23:11:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=d5T6UaBB2if/Vn7ZczP5UcjhJSksdGIh+yyY/t+UW6k=;
 b=UVzIm9OCBDQ806HN/rNFWXriwxTTaeaG/r8m635tNfFVv6GMjG0Ig4dO2bCzb8eJAfYq
 raUbaqVTQBzbyl8DJpIIFBFa+7BhrROyjGP7Xx4SNepfs2xiBGoUadjOkJY4ya6lSdMD
 pVd6NERQNXSYT8XdFPo/n5X7g337vtkIrSAbEQYNfxsXMF5wd914N8FupJ6xJz32TJOs
 Bk+kswy/1+21z/MQ8FBUeWLKMfZX3QtcC18KSyL0CeTPGRx/8l7+Room+Bnx9nJFPWTb
 x5fiNiJns2m1JVPqiMoHRYPaaIa16R1pozWWzldtfIMl6eEdvEfQKGlNbgtGOhg+t9O+ 7Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgts1hgp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 23:11:25 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4NB3i3029674;
        Fri, 4 Nov 2022 23:11:24 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kmpr9a2xp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 23:11:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5srHPXmoMDKnuOXCPa1864bsuR8nUPxptgPcOdlJ7UVKfjiMxlKd6FZD4aPSscoF0yliXb2VELHSP3/YJ8LMY/NrMTaMDY1DV24iTVbm2E/c7fTelL96G4uhz9obKR89RX+DMfOPTPfsCmXErow2vg66YEy2Fi4yjt67S+kXa67WLZ8wTjCE/y1vIgde/uYIYJempcS7e7f8wXeMftN5HOfEc74E5dN5s5fLpVVEqQw1ULVCO1zJowRWK0lxtjOXh8RkrN5+t9MbHadFg3OylKIn7c6v//2gOduJJz77mH7jREVVKeeg3O5MblbO5XtK473nxLiK483TjPoqFSZrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5T6UaBB2if/Vn7ZczP5UcjhJSksdGIh+yyY/t+UW6k=;
 b=LFaGr8aBPxNqQ8vPq7OUi4p5VFx2a/B18qirpcTCoizTz/pJ+ajN7y4jL8S3DvNTJAxsNfFhcEGON3BUFJrPeKl56tkjytFNraoBKvUbejPl8jxf8uEa6gf+Ft21NqiA+vM97g8Rhc+PNNQ9f3BlO10WZCRkvKg97b+rsqc6HxFyAxGO5G2uB9mCR3yejFHkWSBOj9yoRNMvsZtyx2dskZEizhe/18OMgcMTJlX+X+hBWlk2NgLV4CXq6f+npNGF9m6ui4G5Xiokb9ABnwziQidCMXx6Dx9U47RzWB5hSq0RSDl+f3ucPYvgu0me3al9iSn9jc7wtvk3OEPisfiv2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5T6UaBB2if/Vn7ZczP5UcjhJSksdGIh+yyY/t+UW6k=;
 b=zTHvNReQaLC/kJCliOSkKE9d57Aav3uE+NRIFi4c3SImka1Rvm1fMUdyIoic/adOOSnPIFXIXUbBbF31DM0BPx4ozZJ4TM4yzmKzmC9Le4qHEkse+6N+cEjTiQv0wcVFbLiuQeXvDGCWVAS944ph3VCw+11zC3v9uwwIZ8p0vSc=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH0PR10MB4972.namprd10.prod.outlook.com (2603:10b6:610:c0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.23; Fri, 4 Nov
 2022 23:11:22 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24%8]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 23:11:22 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        alan.maguire@oracle.com, Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 bpf 8/9] libbpf: btf dedup identical struct test needs check for nested structs/arrays
Date:   Fri,  4 Nov 2022 16:11:02 -0700
Message-Id: <20221104231103.752040-9-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221104231103.752040-1-stephen.s.brennan@oracle.com>
References: <20221104231103.752040-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0101.namprd04.prod.outlook.com
 (2603:10b6:806:122::16) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|CH0PR10MB4972:EE_
X-MS-Office365-Filtering-Correlation-Id: 4df145c2-f491-4a13-7292-08dabeb9e382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xrWVuojUGG+J63aKcA1cnx86lMYvvejHtbsBMYTAFexpx0sS7ryZX0cC9gwj5wixDPE4WnEdmE8E6ONov/Y2VTEPmt7Uvh3VcnklVpr0a4bOhYC4Gdd5M6KxYc6NOyjkeo0Tza3iNTd5ET55Krfw1ttNj6wl4iSRbpLSpc0yc69wrWIAyBcjOCwHU2+nRlcOxd93pDHxt8VN1pINn2+TVwFyCcCHOrLRX6lzUYV4uqFGz6y8lO1+T0CcExuksd5yRLgCfWqeKk1USKc878oZu2kOWt3G00UmX0s+BvcqPAWwGJqnS0gWRPyx8V3bp/xAdlIDra7v+d6vHl8bkrw/gDNyfVRgJjhHgZTJBFHvHSaynOyTI9NY/HHonNvUq99v5P3hzvWWqwgPh7gGTszSMr4c5Ghud942AdOg4OD9+RGCcPTzHSw6j1wYU/67mkY+MVdkskc+fk1nArEZ4F1Fc5i2nsMmdy1C/NyLq3HJolkJw174USo4Xq2jDurqlJGi1KbtJ93QXJ2oauVOh3PuvlCxUzFmaA7lPB7c1FngS1ze+JT3ffcJ9dA+Dq6UpLyQInzeMCMgtQQO0gkEPP1cN7JYl3qWyOyiq1bpUxUo5F1U8ejjSoQc2+0knzRPJEbIurrKNLMWxoQCHs1fNx5Lus/NmidpF67f79okE09ikr5qz4yotHqv9GRst02dZ//438Hb79MAxlcb3NVid4RIvvcPU7ve5TtDGGf3sYGcSyQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199015)(36756003)(86362001)(103116003)(41300700001)(4326008)(6862004)(2906002)(5660300002)(83380400001)(478600001)(8936002)(6200100001)(316002)(966005)(66476007)(66946007)(66556008)(37006003)(8676002)(54906003)(6486002)(38100700002)(26005)(2616005)(186003)(1076003)(6512007)(6506007)(6666004)(7049001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ypIb14hE0xh2q+4ZLVxr6If2RU8t78hudD1OPTpa1NygNgGi7oeZ05QODTES?=
 =?us-ascii?Q?Vzrh3JT0NEiaA0C6C8yd2txM0iyArD4NJiUdzirGb/FPjXkFM8NjqtpNo07j?=
 =?us-ascii?Q?ntunlO3WpKolJ+ANEnMeyesxFcq+qBr2EZ2Dc1mhfFpeF7ZDNAjh8GjNY8aQ?=
 =?us-ascii?Q?GZZS32Vmzvq6fqNjyQLDF8Q48BEwTGDHvfpd3NwnOVl7OjNR3TEFybq4I0Aa?=
 =?us-ascii?Q?5RKPID+lA/dcJIL0jzWj7pHaesGOVuAucIXTAyRWkIFV+bQ3GZS1BpSrjekp?=
 =?us-ascii?Q?ZAXHoL9hPC7GmVjX5no3e15ZQ3o6nxObbTpPFOw4uMg938rhDNZg37vyXHE2?=
 =?us-ascii?Q?lZuReZN3d1EhFSdHLPf/U2HTmPE5OPaNHognt7U//Q8L1DdnbO7KPjBdZrZj?=
 =?us-ascii?Q?uzmmj49I5H4lUfiHTELaE7cuf8fCCkzFIWotwp77JdLcbH41QvHuJ5nWzZKq?=
 =?us-ascii?Q?QOk2li9Ne0DaBmTUukm/KsRT8Jgrym67vugIuTsJ7FeNTa0QNnoNFUr2bexq?=
 =?us-ascii?Q?PynZmeWPVj6YbPSJRfp1WbNGuKjJu5BmVbmHEZth9FPIsS9+JdOvwCAUmIMi?=
 =?us-ascii?Q?Q65RV744/oNkcH8tUwMg1PS+xuFCzREyfX++cscOtJFyi1IxioAZb9ZmLuFz?=
 =?us-ascii?Q?tfmbVy7oUbYSpfFOFeEHBSi0jU1hm7Zu8TyzfJuIMSwSZK6KxoT3j5tZW3+y?=
 =?us-ascii?Q?h1STjqGgOrHB9PYQM/0VLv0jRYkhQn/lEXMsZgz+fnqeaiwDLkE4BkF2sBIi?=
 =?us-ascii?Q?Qm/DgLnrbFJ1ksWPe4eUs2A99Cer2JWKJxkGtoMi6e6MK6YS3FQSi8x170NH?=
 =?us-ascii?Q?6VSar7uWxDuuLCucAuqA3l+QmUyFAZQaN5EllgC0K1XKUipwDe+H1+qhfcee?=
 =?us-ascii?Q?9YcmMV71du0bDAq13tC9dqS3MHZduc7MWvvUQROQacu6/16X5eMmmulid8Ji?=
 =?us-ascii?Q?M1l8yWt1kzDGvatFbAEtq8z+LLiQkiRjmXnFzXyQaiv0VAZ6C1txCHQ2cIG8?=
 =?us-ascii?Q?O+BqK0PYGaqE3wc4hl11Jhoknzo44BJ1h0bDWgoFsGETcTO9WC0BGcDwqr5K?=
 =?us-ascii?Q?iPPMOfd96BHklYnzZwO9mGWfiSOaps/TjRIrEB74RcUT65Ky5rzrZQLq7lxZ?=
 =?us-ascii?Q?GA7+Q+0Kfg+wYr8FuRH70i7uCQZ9m6F7r5Y9FiaNpaBySqxYBgP7+uJ7GiXa?=
 =?us-ascii?Q?//EnxpCJw+BmjLFneKrzvd1CXH36jxm/s0Axs6AWrfRpFxyTqJUBLtUM0kNz?=
 =?us-ascii?Q?UUhunLgCRIkBezVq26Sm9xGc+hRVhjTQfnmiTB73uYtY8EVQRcZmabA7AeNy?=
 =?us-ascii?Q?bYrj7dpt1tW4Hnj8WhijfLJwHKo22Gi6VYbBfMfg/LL2EHP4ZQTHb+EVC0KC?=
 =?us-ascii?Q?RNJUXSem09QfEd1v8U6d3iL7cjZ748Nn1lAnVOYsMa8c7PkqlFcVTxyh+JPJ?=
 =?us-ascii?Q?5a+qrn5x2shohJS40ZSnnnMk0uvfGWcp+MqgXziqxgKLQAciPMIL+vaJis1m?=
 =?us-ascii?Q?q69XLuU2WkNgMyfMdNZyYRJFf+jGE5yDPt5V3pTh0IfM0uMJAy5Kxxovh4ex?=
 =?us-ascii?Q?jS4T8oK8c15P+3+In1Old8hbQR0eiayPYwksWhYrDJlBH1PYeImxrRqtrdn9?=
 =?us-ascii?Q?9w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df145c2-f491-4a13-7292-08dabeb9e382
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 23:11:22.2956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /eBcA0SN9tb4dN8Ev4J0V6at0S42wC0F+/uzujXlw7/3J6aQHppZGzk5l/4SxTvrcs1HCs1xOdYofb/TSj6kuqSLpHOTfke5/mrhGxIcKn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4972
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_12,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 adultscore=0 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211040142
X-Proofpoint-GUID: XjoDO7VkIBDoXq20HcojOqPJ1TRaFLKC
X-Proofpoint-ORIG-GUID: XjoDO7VkIBDoXq20HcojOqPJ1TRaFLKC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alan Maguire <alan.maguire@oracle.com>

When examining module BTF, it is common to see core kernel structures
such as sk_buff, net_device duplicated in the module.  After adding
debug messaging to BTF it turned out that much of the problem
was down to the identical struct test failing during deduplication;
sometimes the compiler adds identical structs.  However
it turns out sometimes that type ids of identical struct members
can also differ, even when the containing structs are still identical.

To take an example, for struct sk_buff, debug messaging revealed
that the identical struct matching was failing for the anon
struct "headers"; specifically for the first field:

__u8       __pkt_type_offset[0]; /*   128     0 */

Looking at the code in BTF deduplication, we have code that guards
against the possibility of identical struct definitions, down to
type ids, and identical array definitions.  However in this case
we have a struct which is being defined twice but does not have
identical type ids since each duplicate struct has separate type
ids for the above array member.   A similar problem (though not
observed) could occur for struct-in-struct.

The solution is to make the "identical struct" test check members
not just for matching ids, but to also check if they in turn are
identical structs or arrays.

The results of doing this are quite dramatic (for some modules
at least); I see the number of type ids drop from around 10000
to just over 1000 in one module for example.

For testing use latest pahole or apply [1], otherwise dedups
can fail for the reasons described there.

Also fix return type of btf_dedup_identical_arrays() as
suggested by Andrii to match boolean return type used
elsewhere.

Fixes: efdd3eb8015e ("libbpf: Accommodate DWARF/compiler bug with duplicated structs")
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

[1] https://lore.kernel.org/bpf/1666364523-9648-1-git-send-email-alan.maguire
---
 tools/lib/bpf/btf.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index d88647d..675a0df 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -3887,14 +3887,14 @@ static inline __u16 btf_fwd_kind(struct btf_type *t)
 }
 
 /* Check if given two types are identical ARRAY definitions */
-static int btf_dedup_identical_arrays(struct btf_dedup *d, __u32 id1, __u32 id2)
+static bool btf_dedup_identical_arrays(struct btf_dedup *d, __u32 id1, __u32 id2)
 {
 	struct btf_type *t1, *t2;
 
 	t1 = btf_type_by_id(d->btf, id1);
 	t2 = btf_type_by_id(d->btf, id2);
 	if (!btf_is_array(t1) || !btf_is_array(t2))
-		return 0;
+		return false;
 
 	return btf_equal_array(t1, t2);
 }
@@ -3918,7 +3918,9 @@ static bool btf_dedup_identical_structs(struct btf_dedup *d, __u32 id1, __u32 id
 	m1 = btf_members(t1);
 	m2 = btf_members(t2);
 	for (i = 0, n = btf_vlen(t1); i < n; i++, m1++, m2++) {
-		if (m1->type != m2->type)
+		if (m1->type != m2->type &&
+		    !btf_dedup_identical_arrays(d, m1->type, m2->type) &&
+		    !btf_dedup_identical_structs(d, m1->type, m2->type))
 			return false;
 	}
 	return true;
-- 
1.8.3.1


