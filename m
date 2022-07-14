Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FAA5753CA
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 19:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240443AbiGNRM4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 13:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240090AbiGNRM4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 13:12:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69A84BD28
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 10:12:53 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26EGDQ2B026666;
        Thu, 14 Jul 2022 17:12:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=6Qcsc53dAA30h2Rc2mggv0lUH7Mkoa80MmjCy99r3fY=;
 b=epnhleKwNDue4960rIbKDxzf6FInUPUiSrCjq2hIOmk4e9158fTUvB6OQw1VqOnlq5S/
 AYKLwDmacZQvAxB7iZQHxtVYW1kzgJKihHLjtO3mDylXtRmi8dYBJ2n2HuzQe3kAbu/s
 zWJd8rQcvjSxcR1jRQTkksGH7HbkHvePmCji7Obw+ucNXcG8z+bniX5iuO/H3p1ttcnN
 /qcVMCm4tRvrBXgK8+jUygpMQIwk0UJ0iCpHmXpKLzs9cQ6vWPr9LxvbVSXNYV3x+h+C
 29vcxdsDUqodYy74hiu5E3v5tYGKaoQvQaF9xTxSf8mlOB+nGeezEqkYj/cy5alGrTtK cQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71r1dbxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 17:12:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26EHAhlm009363;
        Thu, 14 Jul 2022 17:12:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7045sghw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 17:12:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2jO0tLNaviyWGVAIFu0wDhwPGBZhJauy6mifWfnjBkhdWbCs0Gij26v1bbB+2/lDYp+z67DHpW8ComKoYR/8YJ27DbTYmkmRtzgCyxvlwdSCU5vK14uSHCGUfKxjSEVpvJS6YUMo8sb+6Gd/TCot966SHD5csX4yfWlPzHYJOjpYgxd6YbdFc/D51vK2k6mIpCTXHOpNh1MmgoO+sWjiQH+/fnYIA9fV8PMbPdUGcWe4hYOxpayTeuFI//cySpPpG7kn5Vl3nwVAG/ftNIUowdWrHU9NT/MAkGUA7Hf/uGetOV50WDHfpwILV+HjVhAl/T2rkA9Dc2KYpfT0dKVHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Qcsc53dAA30h2Rc2mggv0lUH7Mkoa80MmjCy99r3fY=;
 b=YalJd9g/W0g7RGZv9I2uD9v0xwNPZ7sbAZE69oEpDnA29yffhIPc/dJxdnVftP4SvcVoOtmleZwBXd5f9hOZHXizAwUg+aR4ZmopIrKCsKAJpfMpHamJtkIncutgHw59wO5RR7cToxgvvdyNzTTHl+SX0SqW664Ojw7pn+25ExrsaC8rGsC8buueckQj+jdyhDXV4OUhzTbSKS9FDBMDs+A5hsVrdfSaaQQZMIY6FwR8t1Caf15la5BBKdpZhD5sYuvKVImoCA4Hv7Q1ma5h2q4o7OsyTYzFSychXJAMoiZtfLydmNKGgXFSv/RlXwr4c54dhjIEoOZUSLCnJ10B/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Qcsc53dAA30h2Rc2mggv0lUH7Mkoa80MmjCy99r3fY=;
 b=zf3txTnMztoidliUp0rFcVx9gKQK2zqsqupvoPzZ+pYBq0TQNISiGh22VvOer47AeXVzQM3c09T/9mpcIWihwL0Z5upa65bLA8UwbM98l9HafCVCTf197iz3oMXBBvoYvtGKAZj6XNjfpip62O1VMnr+/3A5tHxdNiijEIV89hs=
Received: from MWHPR1001MB2158.namprd10.prod.outlook.com
 (2603:10b6:301:2d::17) by CY4PR10MB1671.namprd10.prod.outlook.com
 (2603:10b6:910:8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Thu, 14 Jul
 2022 17:12:49 +0000
Received: from MWHPR1001MB2158.namprd10.prod.outlook.com
 ([fe80::65fb:fa92:9a15:f89b]) by MWHPR1001MB2158.namprd10.prod.outlook.com
 ([fe80::65fb:fa92:9a15:f89b%6]) with mapi id 15.20.5417.025; Thu, 14 Jul 2022
 17:12:49 +0000
From:   Indu Bhagat <indu.bhagat@oracle.com>
To:     bpf@vger.kernel.org
Cc:     yhs@fb.com, andrii.nakryiko@gmail.com,
        Indu Bhagat <indu.bhagat@oracle.com>
Subject: [PATCH bpf-next v2] docs/bpf: Update documentation for BTF_KIND_FUNC
Date:   Thu, 14 Jul 2022 10:12:20 -0700
Message-Id: <20220714171220.1108229-1-indu.bhagat@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0312.namprd03.prod.outlook.com
 (2603:10b6:303:dd::17) To MWHPR1001MB2158.namprd10.prod.outlook.com
 (2603:10b6:301:2d::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c6b50e9-c7bd-49ad-29d5-08da65bc13d3
X-MS-TrafficTypeDiagnostic: CY4PR10MB1671:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KEjn8uhAYuJ8rehWUe2Y6REPbGh7kuccdS8ZDDbhSfg4xWvgOoLjLYdiprxdv8Kxh+n8fWJFJhm0fwUHo4PduY+RaI4syjx6hWjibPPXSGybTLgryLHsgkRyBKNGxhSIar7kN70WrpIUZ7643ttqfujwlt9ZOFyPyMajS94mdXEvZCdNati/lu6RTMK2Ng9mmyTeVfE3Rt2mNZXwPxVgRLc7Fedc8EK5zWEFIeUaFY946IqeixxmkW2Zfe7CkvwBPgTnV/PcuhC124HKrxHHotTadYGdiZYE/u4UnJ0T72TGpelf6/wkZXdUVOl2TmXxLANkiGl0Pf0b5t2Lewpljjdq4Xp8FVL9wni+3Np+BFS7Bhc4S7ff6jsytk9ZpYnfkB64thZyXOuXchIFgR+Gj34iOni+yvViLTjhz2CRwCpV4/OrWsZdM0ufXspp4Z8JNdC4l/Be0OzjDmLEA6Jg4LGqOF7el3vfI4bn7xxggg8QtMfZnIoZX1hdeYIS2vcQdbCS0ZPpupOVHnFWaFEdL95ggmUMnUSVUojlYqWcxRhArwfvby+5Qa2ZCrYB0/JJtuxLvbeP5gCgjUVRQqY5NowOLQjLaVIvrY0q0q4WdnBRP5MK7CMfJlqA439+/eyti1eOhCh4HfVR+sOwHKdTTEpPEXgt3PgeNgTctAmjFoEFojNwlPNtk5eslKxe+QziVdSqUZzfklN/3RgG0ZVDgHc6H7rEBz8ISEEGKSsc7ybgr7u2aDxjrOH3mBYTctUe2e3xU7Dm6IgEYlmKNeErCHjJprlC2fetwL1Zbgh4GK5cQIX1uw3vSjyduFDAELKa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2158.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(39860400002)(136003)(376002)(366004)(478600001)(41300700001)(6666004)(107886003)(6486002)(6506007)(1076003)(2616005)(6512007)(186003)(52116002)(26005)(38100700002)(38350700002)(83380400001)(86362001)(44832011)(2906002)(5660300002)(8936002)(36756003)(6916009)(66946007)(316002)(8676002)(4326008)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mmNmmVGPOCPzY4pGX1RXxoPasS8JZh1DWMyiuTpFdLKSbAiYWgO3v1XWiB2w?=
 =?us-ascii?Q?hZ9P5MzAoHI35HMLGvOhNvnHFsPUm5EymUbgezQG5Vw6vTaPCiKx3j9km1R3?=
 =?us-ascii?Q?1ixfvHztTnFqBXAj1gXsGlQMxLtA45mePzjrsuLCoGvPV86X+T1vbwYgoOQ1?=
 =?us-ascii?Q?V5oU7NS132NSFROdt9wcGS70p5mim/5aauRxPXRbYyMHk/tLeWj5Ih+qXVr2?=
 =?us-ascii?Q?sVy8mHd/IrVLJiJ3K0Z0AZXPnpcUsPf6a6HMKYNTdNfBmUGFowBdbJ4F+ctJ?=
 =?us-ascii?Q?rjP+rg69ssizvieabhrh7QWyfWlARFStvDKhSWiB6/Z3i1Ku4ECdnkgy48Cf?=
 =?us-ascii?Q?1S5f+geHUbAfT7OyI2lrbR/qbwaXmDdHU9vNk152X9lOkXzaKNjTdACMTYT+?=
 =?us-ascii?Q?+njpm06EoEICc7gepvBYuOc9gnsyh6UoRGtdaYSPGTX/w+TKKNsRoRjAj2lZ?=
 =?us-ascii?Q?jtAhv/ztWOzvdhCSM19o20hX+juKbrLozJG5ous4YCdK6RWLPDx+2Vpe1ksG?=
 =?us-ascii?Q?w9XS/JzXY5UWidx5BhohBK8dfnDUxSaw5sfEmYVWlT5gtw7QVwwY0YZhiW03?=
 =?us-ascii?Q?E2XghNXBiz4Cl5KC8/jaWFYvzHIbvmaaW78WIJhPNTJmYelLY/SifRDFlzFx?=
 =?us-ascii?Q?xx5vSru0am103/bQLE+ecdxPj2pyCGZtfLNVKAcbJkO0uaUi5hPpoghcHAZs?=
 =?us-ascii?Q?7JSKKoW8sGyleLYAVQVTZGRNT5RKxejl9PFevWqIfpR5le1MMFy4FgnoXagU?=
 =?us-ascii?Q?mO7J/wT59mxdcW3uMR3o20stmxX9x+4E8AB/NgoQjOOAQZDnMypi6jD5Zy9O?=
 =?us-ascii?Q?pb4MZnhV6Rjijs+8k842S7aDClL/55MIEPZOVkv8Dd+Dw4VXYk+JC4IA4xih?=
 =?us-ascii?Q?7CKUdFvAoIveHcS/cLwfw+aCh2c3QoVyLUEcjk67nt7xARVxc4Q/VG34gae9?=
 =?us-ascii?Q?5jYVLjqYZlD0HDsoUQEgTfPMbxBa1haTD1RudhYMmie1+I6mG1y4+EsqDlqT?=
 =?us-ascii?Q?I4ZZZ3hmDxguXof4zlxtWFbwR0vUhF6yXXJHKcBBsF3mlWHjxzdfLTEDJ2T1?=
 =?us-ascii?Q?Ag15djPtt4w0UBu2+k4HGtVpLZ8HagZK1MD1pyk53dlfT5IRSPmVlmiQlGS4?=
 =?us-ascii?Q?rpSKDqOeGvN4HZaempwOgK1XyULhU2BLXDNyJjQqRwHFs07ONOprTMdarTxl?=
 =?us-ascii?Q?9hvhVtRgbzsbCCUMIM+UJRRA9CWvUFB6+46hdX9IjpC2MmBNBgsPhxK7f8lN?=
 =?us-ascii?Q?h4zoFYG2KtQKFlGu4l6KEC9neNxZpOT4mMjnhf5nS5e5J3l5kj2LaVTkxBpO?=
 =?us-ascii?Q?RG/8S5wHQAF/DptQUUUoToqW8gQzaQAh6aX7isDQRMciU+7R4ycsRlIaqYyF?=
 =?us-ascii?Q?CC6nOsE0+ZLHNvlCmdUilP3QxKjeSpDeP+rVEMFpkBJ3+/bDni593SvkacGC?=
 =?us-ascii?Q?VGe0/kb9S204Ca6wN5R0jbdtAvr6/KCDpTYW/zUzmCKbXgWKb8cYOUld0a0o?=
 =?us-ascii?Q?OECEuH0KZj4Ye+QzRk1HhhqhFnQSJKFlhQ6lpezC25dZrmGhTAWMQNXAnAAx?=
 =?us-ascii?Q?gjJlhnFggfSfWDnElHsDjoBkF1uJLLMgzTYftagn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6b50e9-c7bd-49ad-29d5-08da65bc13d3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2158.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 17:12:49.0021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eYs54qc4gy3K4+zIq5rnq22roanLHtxHy+k4TrFaYSoziQvTtyGU6fHG6v3WYntgfN2kFHd4BuuwGaddUHWzFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1671
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-14_14:2022-07-14,2022-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207140075
X-Proofpoint-ORIG-GUID: 9cZ2nNg1FrxQeH_Ftz7zwaXoKCn7_1Vc
X-Proofpoint-GUID: 9cZ2nNg1FrxQeH_Ftz7zwaXoKCn7_1Vc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The vlen bits in the BTF type of kind BTF_KIND_FUNC are used to convey the
linkage information for functions. The Linux kernel only supports
linkage values of static (=0), and global (=1) at this time.

Signed-off-by: Indu Bhagat <indu.bhagat@oracle.com>
---
 Documentation/bpf/btf.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index f49aeef62d0c..3f9cc9150c89 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -369,7 +369,7 @@ No additional type data follow ``btf_type``.
   * ``name_off``: offset to a valid C identifier
   * ``info.kind_flag``: 0
   * ``info.kind``: BTF_KIND_FUNC
-  * ``info.vlen``: 0
+  * ``info.vlen``: linkage information (static=0, global=1, extern=2)
   * ``type``: a BTF_KIND_FUNC_PROTO type
 
 No additional type data follow ``btf_type``.
@@ -380,6 +380,9 @@ type. The BTF_KIND_FUNC may in turn be referenced by a func_info in the
 :ref:`BTF_Ext_Section` (ELF) or in the arguments to :ref:`BPF_Prog_Load`
 (ABI).
 
+Currently, only linkage values of static and global are supported in the
+kernel.
+
 2.2.13 BTF_KIND_FUNC_PROTO
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.31.1

