Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D8D6A4980
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 19:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjB0SVk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 13:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjB0SVi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 13:21:38 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE25C23856
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 10:21:37 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31RG0JsK017397;
        Mon, 27 Feb 2023 18:21:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2022-7-12; bh=ZuanA27KH52pAEm1iutN407Wz48ewu3J3xb7A2IzdcA=;
 b=t55aIkjZCYpEMfRyhj0gyM0p+DlSYdZac8PXx3EhgUuWoxYt9zVpZibLbJxW/ZJSjQXf
 QB2WaHKPE8qC2bgnWYLG4TcqzZHZYlt/ytZkZF0R49c9nEg8aczJUdkQ4hnq1S6rEBlX
 kE+v8wJqFbhf7C51VPMJLJS5GePRdTbQPY9S6gMb1yPHT1qpAfa3pnPC5VK04dBeVGQJ
 6StnE9wjdgPJTZN11rs3dc9TOQemf1Gp9YCxMYQbnLRS+ctVP5Zr4PsUOTK1euXjuOeq
 nszJvepr7/1kA3K2BggSOUXtxtDNVZQaJXmQT3h9cr8GPE7cHyuq42CE0rpwvufJegXV HQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyba7c8en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Feb 2023 18:21:35 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31RHtNrs029518;
        Mon, 27 Feb 2023 18:21:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sbptxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Feb 2023 18:21:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igl+ciiWRZBLElCszM7ZdZb7r9k/KRgLzJDGw0joeS65ORGBqN4H+4PkUD7al8ZS/nqJhX13tC8VDtUvZOQbQXOKqvORK+ytQZ/2VdG/UWiMv4C7wyKoPdkykIxeWjIDAmyxrKfc4XJA1zVd2o08f61tBlUQqmsL9/g2nMrbWMKQ5+JPGCTqJNhhfI0xGOmsiM0bdEZfLy5pFKs5T5G6f9D/bn4gp1OPYQkw2UJUZzeueQQgmfuiBNf8bUXCS4lG3t+XYvUScawhmcsjYlOOVcAJKJD6RQBwv+2/TCvtoDN91o7OkIowiAcv+X3IuMHh5I2Z2+2zZX5BWxoCUiEsDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZuanA27KH52pAEm1iutN407Wz48ewu3J3xb7A2IzdcA=;
 b=XcC+zt4jAWnFFAWZezvV8r9dT8DTn3UZPGeQXhUuyWqh+ToUz9jiEq0fDZY0i/HZY7EecKNGnOZ8fxrnVjCyK1ZY+r5skwmpftfleDRIxG9beUuubq/BBawDKKEd8+4+kWOYKxmSefhvcT5ZzrmQXUPXWIo9Ub4ZcBdWGK+RqDnuY0ObyfV5GgFSQ3WvrvrHerYMQpX9d2zrPpgedMOeapJHFydYyzojfplDb7AunwnlUORln8nB69naj0RDSXRfVhgHuup7/ZARzR+jTKGezz2ojtU+3nOzkLF8164HFWGMphex6UOFUJaIuEjbWf5O1fjs5Jq2KOrCu25D4dgsHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZuanA27KH52pAEm1iutN407Wz48ewu3J3xb7A2IzdcA=;
 b=ZS8NhOsUGENTMKQ2MJtgwt32GvYFvpKX6vapu8LUFB9W4CCvWZ4GvuymuE006egYv3Ww8c551LIx4iijidF9Uym0gfIXBY6cth8T+1H6Auxiw1sm6HsxyoSBKH9ivyvpDDR3+5Axpoy2XTpvivrh1dJjspj/ns0XuD9Z//vmEnc=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by DS0PR10MB6872.namprd10.prod.outlook.com (2603:10b6:8:131::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.14; Mon, 27 Feb
 2023 18:21:31 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::486a:626e:635a:3ce2]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::486a:626e:635a:3ce2%3]) with mapi id 15.20.6156.010; Mon, 27 Feb 2023
 18:21:31 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     bpf <bpf@vger.kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@ietf.org,
        David Vernet <void@manifault.com>
Subject: [PATCH V2] bpf, docs: Document BPF insn encoding in term of stored
 bytes
Date:   Mon, 27 Feb 2023 19:21:25 +0100
Message-ID: <87y1oj7yvu.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0066.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::30) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|DS0PR10MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: ab1f0ffc-b126-4d62-8078-08db18ef72cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n3SdnKf2PJQaVLWky0FQ8DZQ04qztK+tu5r+PqAuFXDDlYkBEPYlPO4rVFgRiry1YNXT9pPHCL6ikAqof75bMJvX4AyUMRKpcUh6IfMh7P0EqwKkLu+J6aynXXWlgbOsryAT3JxVR+2JQMMxx0cbc+QDpcqT3zZVZLWNC68T98iCZcG6I00zyGlcN0EQbCuPd/NsELznFML6iqg1MS20uO/ECcBsxgyxUsuM2/BdohzDFKv+58MKxEBbZljkO4byaIn8ElWFAUufHEM9Vn+3QGHvcRI0tivFtiA89Bckv6AeqMahM48sKFw6rP3OWSwI/2vWa0t/coRlPxd/cwALC9PeVgN6bZR1xndbX91jS6Wu2XJkqGWicEhLrX6t7DYJn8bZ/aqctlwRlW/Wk/iOfW516T6k+kRcM/ygYpRCkOi0TbY5Q5m96Xz1bF+/Yp5usYCAa4ty2f9Jvj+ikPjbnAOzfPJVoAqHpShXFWLaWDCEeVV1G/2UeicB3dZ74pbzMWUTOghDdTPRvKOwWhnzXQgTYkG3FUfXzQMvAWz0yhn/LfOdyrF3Tz8UcO2TlRfzCLDgUqu+z8rLNPHWksK9ybJ+m09nD5cKaBwDCDLILFLN7PghhScXEb+fGcTnsqgheed6BFQfJ9/YHPazFOqLvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199018)(38100700002)(86362001)(316002)(5660300002)(83380400001)(8676002)(66946007)(4326008)(66556008)(36756003)(66476007)(41300700001)(6916009)(8936002)(2906002)(2616005)(54906003)(6506007)(6512007)(6666004)(6486002)(478600001)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a+hdoCocAiZtQs7Un7Xyc3SkhMMyePcz1raiZFHQqSivEDiEROtZ3lV36yF1?=
 =?us-ascii?Q?J+OWJSvdz/JfZTMb34kGtJZPe94yqxcUzSFeRP/6v9gNyh0xK0Dp8xTAmozu?=
 =?us-ascii?Q?wevUJ3uCda1fYruyrseJXojTWA+9QVTaTyCqXYVxbfQTMfd8eSaryaV/F8HZ?=
 =?us-ascii?Q?2toDQ5jeoOrBQx8keYyFRwR/bH1noJUIkEeJ8xFkwRqmxa/p07NF5RpMRZXk?=
 =?us-ascii?Q?cpxU3fKbGzNGljAGwHPz2vy/Su6ew+5nujISDBMO+WciqxEUtKFl/NI4akDh?=
 =?us-ascii?Q?bVOAZsxKtkL+soC/p6N8GplDELDDLYXDagK6wIyRhoYOE8DTVL77BTmLVdTt?=
 =?us-ascii?Q?9R5OYsYU0wdosjIEZHjePqSWYP7k0zglTf4uAw1PupE+tUpHZwoy7rL4p/FM?=
 =?us-ascii?Q?rCLjJ5Oxu7MbtVeWTndiLYkQRmp/0IcHKw0IqaJOMtUFyjilDPXU4Eb1SsY/?=
 =?us-ascii?Q?C9l2ApKijPXLNDSIUVixeUAz7/XoR5zpydRuUwwa4lrJBlzQEHrITkuaHUGA?=
 =?us-ascii?Q?ZfvFttpRPS3u8AYwn0S5CiFFwKQFrHiUyk0YoZq/NkRAHvuBbvGik83Y+WV2?=
 =?us-ascii?Q?I+Qpo9r5eRqzQsR2zUiqYIOILOKGYIAPHsTvZkgZcTw5IiRxgdsSgT9TYLzt?=
 =?us-ascii?Q?1gSRyycWFOMAHPiiDodLhVX2nahs9D6uc6js6YpqS5ly3fSVNdUDPbGiQyvb?=
 =?us-ascii?Q?unywfUCMuH6mBLy092ELRUu+Uox9xgMA9aMkEJFI1ADlUxXpmxdKBsQdKFms?=
 =?us-ascii?Q?uXV/emEvheQBtKOQrRniVAsgfaewtH4GeHvcgkmbTpmPMAMrmkaLfJ8JuNJP?=
 =?us-ascii?Q?HWPBgagT/62z8Czv/zl2knWfyDnP92DTj1fcMyulvi6CI5y284hPlyCdHfL6?=
 =?us-ascii?Q?Tv33cQxnNXJqHP/IzdvoZw6Q5vpH3y8sDc9U4euc+5lcNpUo2biGed+hIuvD?=
 =?us-ascii?Q?YZIEgy8pg1yMBmTrG3mreM4/sYZUPtJEcugn9Ikw6JVPgUNIXAeSBR7qeo3y?=
 =?us-ascii?Q?md8cuePmYVAqSs0joXr12VI6qF6CTPKeJIG+jL5fFjBzopTMYS5lIj5m95IV?=
 =?us-ascii?Q?3fTxHJX3BGdZ/N4nn6deK/0YgYtxpgWF8wEnBup3Vgjjxk3wDAo1eiDCFFN3?=
 =?us-ascii?Q?uNF60+PEWjpAIj1MHgYCBn75EfNRj3Dhb4EkB8smcR4/PD6foL74TKOflKr+?=
 =?us-ascii?Q?Q/IiPISYtlh4cizWIKI1ZPEXeiFl/THGx/5fRnp4VQ3VqriR4LkVvlBFYl7x?=
 =?us-ascii?Q?PMqTNWuGTCJUHAphaTFU0VBm3ilO0bwNGB/gCqcmWhSyp2YZoSQmQedBo/zH?=
 =?us-ascii?Q?3t12r6qyxmfL4xZXgZj6dRBQRB80KqatnfN4TVhQ9KmgvmqfL/XCCfrwHRtp?=
 =?us-ascii?Q?X/mdb5JPe4p/bv//Ls/RPOPfMX6viYclC+uu9sjmNNBUXrr9HqtD34SdUg8L?=
 =?us-ascii?Q?kSup6GkroLQUqIu0tYfGktPBRXHDqJMV8jiJU10nPdlC84kfaJgbEGBqkfOj?=
 =?us-ascii?Q?pO7HVsSM85mv6mgdekr+0d5jgQTP7HXiKwN2jAw8FsMx+KV0mXgHFGTO8eDD?=
 =?us-ascii?Q?551ZRIn9RnYbwifpw8GuuOP+MXgws0akk2RytLrzlqljv854mO+mM5xXWaj8?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QvjrnzLNarnj4WYV0YXesC9S/JkTzF4UMJPvnY1UaA/gJ/aiDDrACGxUjasg0hMMqkjEaHUTZ1Tpx6JuwtFwhu7U1djjfRf7MCAI0Q6uU2nQ6divvTC2vCRcqMghzcOJTHBuPhhCcV+AMBowF+Zzj8vZY0iC4b3ZHsqf+onpmb7zvCpYrVcS7+m8kmv5KWMBJwHfEWTW2QY8MUpnPuqpPk20CHal61YrQybYMabu60aowfuC8ejHiWT2T4U2TzRq+xS1eh94lXSd7qQyOYrC0F0rD/9aOJxywY83aNnP5RbweTtlnB7ZcOdaTyExEAyvhkOOkHsuwcgNvaqUSTxY4/ZzAwu/AGBF6tv5FaRCJ5G1e71907353tgb0qhug4vhl6+7Aewiq0INYv99QIqApQvtN1PAs9P+KvZ4dQ0QnPlWQ8wzEUY9KB3L1Re2gaR2Amdp5uvGWvRB0WIfg0T9p/3T2q2whm83qvCGUUfIRct6gYxQfUtMjBQvWfnaRqwAIUPHej/kGQrOc6oQzKCsRVRIziDvjIA5+YwkaUup0rTvtPrdCg+bcLkYDPS7uEhk5zTOpfIlko2B5ZjYN9oYUzRZG88kPniATrHBe6wb84gfApwCzEwFlzIFcQoVqs6sy/ChV01lORyVA5nYS+HKYzdW4YF+HmUtU6pnYrmK8PzBUYKbPfP5XJm3vuujylLeSF2TAad0JQ95BqJZviqOs5ySvrzuqQnAQBTO8YTIHoatYnVBRD9DavtPJk2IOE89F3KsHKTA+jssLdwCxaWrGfZeVyfG/f/4V9SyH46RQBsHo2lOI0gMGQyj9p83GDK8x0K9Z8iltJtW3t8+SckGCmPxDnxAy85wAky+d/xwwWw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab1f0ffc-b126-4d62-8078-08db18ef72cf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 18:21:30.8946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ZOO/GeyJAa3QzYvoa47RgV6w39Xw/Kj6U8iS7x2hxJtec9i2muhcyMEru6obwhIPRhWlaPYHzwnhUzON265G/bEmHb0Qrw3FOY02pZEXXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6872
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-27_15,2023-02-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302270144
X-Proofpoint-ORIG-GUID: CYzjKginqCKQnoocLN8PQUxYORJ3CAz2
X-Proofpoint-GUID: CYzjKginqCKQnoocLN8PQUxYORJ3CAz2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


[Differences from V1:
- Use rst literal blocks for figures.
- Avoid using | in the basic instruction/pseudo instruction figure.
- Rebased to today's bpf-next master branch.]

This patch modifies instruction-set.rst so it documents the encoding
of BPF instructions in terms of how the bytes are stored (be it in an
ELF file or as bytes in a memory buffer to be loaded into the kernel
or some other BPF consumer) as opposed to how the instruction looks
like once loaded.

This is hopefully easier to understand by implementors looking to
generate and/or consume bytes conforming BPF instructions.

The patch also clarifies that the unused bytes in a pseudo-instruction
shall be cleared with zeros.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>

---
 Documentation/bpf/instruction-set.rst | 44 +++++++++++++--------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 01802ed9b29b..3341bfe20e4d 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -38,15 +38,13 @@ eBPF has two instruction encodings:
 * the wide instruction encoding, which appends a second 64-bit immediate (i.e.,
   constant) value after the basic instruction for a total of 128 bits.
 
-The basic instruction encoding looks as follows for a little-endian processor,
-where MSB and LSB mean the most significant bits and least significant bits,
-respectively:
+The fields conforming an encoded basic instruction are stored in the
+following order::
 
-=============  =======  =======  =======  ============
-32 bits (MSB)  16 bits  4 bits   4 bits   8 bits (LSB)
-=============  =======  =======  =======  ============
-imm            offset   src_reg  dst_reg  opcode
-=============  =======  =======  =======  ============
+  opcode:8 src:4 dst:4 offset:16 imm:32 // In little-endian BPF.
+  opcode:8 dst:4 src:4 offset:16 imm:32 // In big-endian BPF.
+
+Where,
 
 **imm**
   signed integer immediate value
@@ -64,16 +62,17 @@ imm            offset   src_reg  dst_reg  opcode
 **opcode**
   operation to perform
 
-and as follows for a big-endian processor:
+Note that the contents of multi-byte fields ('imm' and 'offset') are
+stored using big-endian byte ordering in big-endian BPF and
+little-endian byte ordering in little-endian BPF.
 
-=============  =======  =======  =======  ============
-32 bits (MSB)  16 bits  4 bits   4 bits   8 bits (LSB)
-=============  =======  =======  =======  ============
-imm            offset   dst_reg  src_reg  opcode
-=============  =======  =======  =======  ============
+For example::
 
-Multi-byte fields ('imm' and 'offset') are similarly stored in
-the byte order of the processor.
+  opcode         offset imm          assembly
+         src dst
+  07     0   1   00 00  44 33 22 11  r1 += 0x11223344 // little
+         dst src
+  07     1   0   00 00  11 22 33 44  r1 += 0x11223344 // big
 
 Note that most instructions do not use all of the fields.
 Unused fields shall be cleared to zero.
@@ -84,18 +83,19 @@ The 64 bits following the basic instruction contain a pseudo instruction
 using the same format but with opcode, dst_reg, src_reg, and offset all set to zero,
 and imm containing the high 32 bits of the immediate value.
 
-=================  ==================
-64 bits (MSB)      64 bits (LSB)
-=================  ==================
-basic instruction  pseudo instruction
-=================  ==================
+This is depicted in the following figure::
+
+  basic_instruction               pseudo instruction
+  ------------------------------- ------------------
+  code:8 regs:16 offset:16 imm:32 unused:32 imm:32
 
 Thus the 64-bit immediate value is constructed as follows:
 
   imm64 = (next_imm << 32) | imm
 
 where 'next_imm' refers to the imm value of the pseudo instruction
-following the basic instruction.
+following the basic instruction.  The unused bytes in the pseudo
+instruction shall be cleared to zero.
 
 Instruction classes
 -------------------
-- 
2.30.2

