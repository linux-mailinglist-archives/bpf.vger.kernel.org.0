Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA036A2304
	for <lists+bpf@lfdr.de>; Fri, 24 Feb 2023 21:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjBXUGN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Feb 2023 15:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjBXUGM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Feb 2023 15:06:12 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C62B6F434
        for <bpf@vger.kernel.org>; Fri, 24 Feb 2023 12:05:42 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OHiB4L025488;
        Fri, 24 Feb 2023 20:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2022-7-12; bh=9GpMp+3Egdvc9ZDZT/eNwemTaWbbvuVCQA+4viRmvdc=;
 b=mwAPw2qHe2fqrzrD6Bm3q4AjLNK8tyg9HGz9567msXkY4aKpACSuzM/DKmxRg2cnnWma
 DF9yciRspCr2EjapiNpbbhNYFE5exi3W01QAIHX/Z+FtjlBRe1y9dEC9LX5mu0zgnnd2
 d0RuHz7iXi1r8/sWINTkV8JX6UFOwxeVs9HQ1QtyDHsOOO9t93kDeiEsk61N19blitud
 OH7YNbuP3x7rjS01ftQK5VZsNSUmivtrCg0axHOqh5zZRuQI8e3umVcpLMtWVQvA/b9M
 gAS9JJIJs7+aHGe8q1aU54T/k8KRTz/LPz+OLSq6q/cgYw7OfVkYShWSnaH7ZXfbkRlX Zg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntq7unvfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 20:04:16 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31OJegq2025984;
        Fri, 24 Feb 2023 20:04:16 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn49xefg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 20:04:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lua53lWl1iu7qihmMD1v1ycq0JwqAzFoLG+ZFTnRHHhWxWt87TPliAwvbqwa2wvnyC5QFFEPYLRKrSKAdCl3YIGelpFRDKEejlS6alVjMtmRa9P+QgvvnjgF4bac11yW1jYaDIq4Ec5n1XaD+zLjs1U1lH/GzbwmhVu0feYAIUt00l5wOGEwL15B5nj/NjKLzuDrWaxvNrNTJR3bSL6noS58kcDtj2qbYbf4vTs6ppE4/WIXGbKws0vQSJK1iqMYOeHVOvQp1xtKybwEfldgEnyivcr+51E7PcwIlESJX5y3sZ3EF++ZtWLtm29ksEpKm+6fZE315+mXQ4GEkXh8rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GpMp+3Egdvc9ZDZT/eNwemTaWbbvuVCQA+4viRmvdc=;
 b=gmU5wTc2iA56oCz947wtJZe8ODgJUyrgbLvCQQKQc65U/RcHX88lgHFjjq7JOMNNqtNfJxNfd3CZa7IJECrym2MoHIVA6QRvCfXIR2EOGrKex1jz9vUYhALV2pdYeDzXZMbv4NBHnF8nE1/NQIAPIsYuoMUVK6iDckZLf44lgK1g3Je1zzXEgWPcGkTd8nB3dkFTNgy0wezBbcXOOKXxmaBsTuGk8H5dkeAq0L3l0+gP9GvSqw+YKLrwpRL66U0oy7wLUfidH1oGsudGukI1THmXJxXTCqXzXBaUK89WhyWC+j33g5eZXpGqkGyu+Qd/21+68fEJv3BXBEM3DOanzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GpMp+3Egdvc9ZDZT/eNwemTaWbbvuVCQA+4viRmvdc=;
 b=nAJXa/6bnvTpY7KjKL3UUtyKUXhbyje+nKrxygarvmwIqIL40auQYzFppdnxIQ5Dr1amaDwlFpvSZjE8uOtGA+SjeKMCaOKZUV46z447Sq8tFKL4dct5tt0SWG0qOM77IzQNwZCczjIeX7IrZ04difROV4n4UBYiRVOck1Jv5TA=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by SA3PR10MB7024.namprd10.prod.outlook.com (2603:10b6:806:318::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.11; Fri, 24 Feb
 2023 20:04:13 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::486a:626e:635a:3ce2]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::486a:626e:635a:3ce2%3]) with mapi id 15.20.6156.010; Fri, 24 Feb 2023
 20:04:13 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     bpf <bpf@vger.kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@ietf.org
Subject: [PATCH] bpf, docs: Document BPF insn encoding in term of stored bytes
Date:   Fri, 24 Feb 2023 21:04:07 +0100
Message-ID: <87y1om25l4.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0295.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::19) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|SA3PR10MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: f7cca548-0ae5-4a22-e489-08db16a24c9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: edDib3Pwx6TLtio2mAWZY4ZnYh2OR+RW7Boo4YqxkcmdFBK7LwxCOlZ+fxeU8UBrJMoL4qSk1h/PcZtuWG7ogBxy6hDgWLPDxahRh1UcufXhYhPMwyeFBmtV0ieByfJ71d7H5JQOBHxJgdNL5ivYbzXhl2o+3A99gQQJa4qe9Bige3cXdwPBsbenEBck4eAcIZ6Ly67Qo+CxIsHjovEr01oP82cUrhqUZKE/9t2jKWm1QCLPv6VDlXSG4zDFkd9Vsd/0pwGkgJrM/d7cvbzuHSRdg8KanMSLevXQoFcXCIRVuDmx7qGZZLg4883nH4jlsxLgJppTsSo3WFVBXeGsTY15B7bf2hF7lJahQbKI+fu1S1eDyEIWoMht01qbAA/C/16y3t4P7gW6Ax9HSYeRE1z8bJOLh3JnSmWPCpVjuabcGnSHtUc0TYbRZ+LWm6hY4xauW82pALSTrPKsowvjoCG3psifS7Ja431obdlHCQVK3JhK+2lyzyRFaIQVk5MTjc80WPGRGefm+CCiPNv2U6qARHsnaOulVGDglU1Gh24gFcGNC4V8U/HZekm7/wKY5Anb2XRklbS3DB+Sq9DJoFzbpACJUfqA9FHrTT0NJzT6wgu8UhoS6cqbfRqpqJzJpsRFjZU5D4bZTxGcNBPo8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199018)(36756003)(2906002)(83380400001)(26005)(186003)(2616005)(6506007)(316002)(38100700002)(66946007)(6916009)(66476007)(66556008)(4326008)(8676002)(5660300002)(8936002)(41300700001)(478600001)(6512007)(6666004)(86362001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dXMiMzFE3fougrQd3+z8I2+E3f70K32lZgBhSUkQDo8dBd45TKhINJVgQsmX?=
 =?us-ascii?Q?wvUPbo9f1Iih0tYjkll3EcPBRBta79Y7QuZhm6/S5WEhm+GdeqlTbohFZdo4?=
 =?us-ascii?Q?Tu0wZNDjEc1JYtnOXdCUjsuW3jx/Ff+/vMKfiNv8+2KCx1az2LpFFLcay9T4?=
 =?us-ascii?Q?M4j4/MQWe5nBUqzXUuQs841UbsP/LU4jqjCFE51fsTzRU6JBUFNNGkhb9me/?=
 =?us-ascii?Q?+Hpp9C5zRioK+V0Gg650LE73tWNS0hzurTQvfBBAqPDkXq1dFRbin71pMfFk?=
 =?us-ascii?Q?cVeRhr9Mx4KMiMadFoOeOWezX30jt7RW7ve8DGu/xQ39XVYaBBDwgNM0+rvc?=
 =?us-ascii?Q?lEwX7zXfWMfN089F1bes4JkGfC44eL34YSnr/cc0CauG/6QhB2gu181/xjvE?=
 =?us-ascii?Q?MT4zA4VCmScpILyAgspskesnZwDqH1RTzsAc7NWy+TN2q2VN+PYmOe2ehG54?=
 =?us-ascii?Q?4pFlDMyxksJI0UoJEmC6fPKLrAE8Nivo4Q0nvDx2W4wbwUR22v0KMP2JWu7h?=
 =?us-ascii?Q?tZqtERU+W9B+zRKJdYQCZE0mYlt8gzl8bitJkGvoijhglmHa+GtZA6OJedDk?=
 =?us-ascii?Q?pJImtf0qOt4ZSXa2YEgA9IINFyMbSCm3GvPa1tvSIYlNYYsRQorquX/2Y9JD?=
 =?us-ascii?Q?qSXW+5BjQxX3cnDhI+1jvBCEW+5XkDebgL0Q72z3W6Rxuh69oEOTkCJskily?=
 =?us-ascii?Q?HLCn2ApvKVLL+VQQFR7vctWfavEovD+MqbLAP7kIRcwapfSnhfLCnzmoU940?=
 =?us-ascii?Q?BNSl9bQb84HGU5B1P0oJSbf3t4DBeifUq069G49h+xqb9QfR7/GcMV9v1uWQ?=
 =?us-ascii?Q?Zd8z8IfivT5sar2t8ZTamdd2T52ISp1XnJpRUPXubyaJXNstAZHoWEBMSfG2?=
 =?us-ascii?Q?0hkMaCoxQxiE+vQY+f2fUEboGAU0j6lGNQXc8xvKK4nC9YlZtPMhWI66Rc+i?=
 =?us-ascii?Q?laEu1hdoXHpemrHlUK1B/kTy+uEfrU4feKT+h1YGpMhO2yMGbpofZLIIihr+?=
 =?us-ascii?Q?3lAYLEJSmJeTxT/N4XbdYbP42vaFFiZqt+pOIFRElsN6NgLWcX8VjeTDjDWn?=
 =?us-ascii?Q?vkWUM9eB7MPxJAIEwkZbW8BAYqgUrQ5uYIxFRoDBMddK16VQ0GTA2WEVoLDx?=
 =?us-ascii?Q?K+ztUkuW4vhdGFGLug39SdBhPjRLndfNJBZhZHYWz2ahEJokycY5UsF3Ssqm?=
 =?us-ascii?Q?Dx/n33/IZEMR4orIU4V0TkVRiPZxpcYZv1ccYM0DydLAe8Q1Hqb6Zegm4jtK?=
 =?us-ascii?Q?tLDQA74VIvHnguk/XZPZL01Ye4Twe+4LsJet8+CNlbnN+z62OojyW69Qcjtm?=
 =?us-ascii?Q?Gu6T2EXX3OWZxjpPIE9vqxj0+8IZ6uyPTz+TQIUaLzckmVIMJ0OHX44nTZN9?=
 =?us-ascii?Q?2jZ0gZpeeMk4+4bkgLRvpjdrejzYQYLWfF44PEdcqxuPREfwzb2PCO38hKc9?=
 =?us-ascii?Q?EMcRsAUVS36IcWF1FnDko+R9RRC2S9cIXyG+pyYR6TpLINKphvDgJ9JlPMan?=
 =?us-ascii?Q?3Cgbq3pmLLuAq1XAL7UASHVuebR4yMSVjflojHwoMLtbdxsQqU7jxLn6PYne?=
 =?us-ascii?Q?z9mEOjD9yApFafrdO6QVsen8Tlx893oj8r08itd2ixYIo0NkuplZfSl7RlZn?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CkHhu5NGU6qB1GGRpCoGo/Fick+afONSqlPeazB6A2fbUEQJR2d+OQrMrW+e1gZRXrO1EudXS4NBIUKPeK+qg7iogCVq4Nzob1q+6r+hLCt8MvGBdGXkCpNPqlT8mekIorm8SOvGqu+sJ/7R1JAt7oXqFHys1zroTUIOA7osTMgHFRdcODJFOMATAN1wc84S6GldTVt5/738gvaIkk1mkttNzWZHBDeGx7JiP/+Kqh/pfxjps1kTPgTOZImL+Ar5ySe5/wOM8JmSx6Xsx2YzgCvPff65sDvO+tZZfTPVkPGZuUeQCynf3QmxjQUS6eC9R7+DpPTePp31/0eKJBL54V+4oi7i++k3Hlzg13hYimfy5zNVveCHTlB9qYd8KyssyMEpig/OhYhv03bh4l2g8qOUG4MIi2brPKQKHzxB4IuErBy791CIUU5hp2Yf3mOjKxFhhMPW3Tckntt2yOhOGon6GTzmI56kB397EsUI65EA2dCOhRk+iEUaxnHUD4p6KdIBk/tR7ytjL5Ufs7oDkZar0mod5KRVw3pU7+khfajFThseA4KNykETZVam1vXve03QjAW3mswxQLPvfCwBgQevWp3OIUVWIWX/nSU4CN998CF8fmEvTNUoQyYCbMsUeernUIh2Zufw2bTGZ78o1hxeB+5O4dPhTlg/3HzzDYK8Bjp2aOEpABtpW4lgvqn/nfKDyDdAh9gBwx0YgQMNpu877nD3X8pZ4r+UOseZAHBbGlOjP8uacarM75PgP6dr7Z3lixirjuSkirqMfVBY42pSYFBzhHCfDY/Xtn4xfGikovUX/Xuhgy+dMKCM71HP
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7cca548-0ae5-4a22-e489-08db16a24c9d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 20:04:13.1954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+p50uxkK9xhs27HSR4uGuL4Daup/JD7zaYD3edIbxinM/rXztNJ3qhKTEOIzSkVetv9KWx8BTGM/ME5i8dcMQsxKcr8u4mKF/CDhGLgEac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7024
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_14,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302240159
X-Proofpoint-GUID: M258UNTMAHH8cAvn2NS8KOeljPocciWE
X-Proofpoint-ORIG-GUID: M258UNTMAHH8cAvn2NS8KOeljPocciWE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


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
 Documentation/bpf/instruction-set.rst | 43 +++++++++++++--------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 01802ed9b29b..9b28c0e15bb6 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -38,15 +38,13 @@ eBPF has two instruction encodings:
 * the wide instruction encoding, which appends a second 64-bit immediate (i.e.,
   constant) value after the basic instruction for a total of 128 bits.
 
-The basic instruction encoding looks as follows for a little-endian processor,
-where MSB and LSB mean the most significant bits and least significant bits,
-respectively:
+The fields conforming an encoded basic instruction are stored in the
+following order:
 
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
+For example:
 
-Multi-byte fields ('imm' and 'offset') are similarly stored in
-the byte order of the processor.
+  opcode         offset imm          assembly
+         src dst
+  07     0   1   00 00  44 33 22 11  r1 += 0x11223344 // little
+         dst src
+  07     1   0   00 00  11 22 33 44  r1 += 0x11223344 // big
 
 Note that most instructions do not use all of the fields.
 Unused fields shall be cleared to zero.
@@ -84,18 +83,18 @@ The 64 bits following the basic instruction contain a pseudo instruction
 using the same format but with opcode, dst_reg, src_reg, and offset all set to zero,
 and imm containing the high 32 bits of the immediate value.
 
-=================  ==================
-64 bits (MSB)      64 bits (LSB)
-=================  ==================
-basic instruction  pseudo instruction
-=================  ==================
+This is depicted in the following figure:
+
+  basic_instruction                 pseudo_instruction
+  code:8 regs:16 offset:16 imm:32 | unused:32 imm:32
 
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

