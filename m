Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B00573F99
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 00:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236908AbiGMW0p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 18:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236731AbiGMW0n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 18:26:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970894D16D
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 15:26:41 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DJDmd4023352;
        Wed, 13 Jul 2022 22:26:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=4Hg3kN02eIyu2V1IlEAQ/QcL8+JpyBO+yf59F7xDroI=;
 b=NHmOO4/Jb0PQ5uo2DSm8Dyh19JSUk9527AGMdPJVOiMQ2hHFQBbf/VvPuwiY1Qait4rl
 4hK7tfvplE3QGsSWw48weDN+Irl9iS3TEDNbRgBwF30PztQDp4ryKzLM5zMt9anTZQSZ
 /5h7D0Blr5opR/V2QjvH0PuOzZP1wEmji7k5LJ5TISTKMTrFsIcs7Xc0sZm+h8VBlssL
 dSWN0XHtnhXcWS6hjILhQ90vM8pRx/RNumbbLxUJSZLhLfRE/iHxY42RFuQ+8uE4bnvZ
 0EbSsjBiKmfrqVfrxYQr0u+yiMkigoRO6w6HGI4F1J3o9iApQe9zh7grwZttyH+Ai8f+ 5w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71scbnmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 22:26:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26DMKpcY033696;
        Wed, 13 Jul 2022 22:26:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h70455nap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 22:26:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXcxg+z5xAfmEQuD1VUs0pMgMXy7Ygsb+rLwnBNMiJqbFW6uzA5DAOOyzinSF2GdzIn+4qVuyPAvsOwOeQJXqbTAoBKgUaA/Fw4uJXI/SL4sGCK2buANRAh8JHFBCGH/7BhvCh4BoZdJ7y8CR+BloF7cnbjJ5YzMpjHoQFTXOISyIVcX6YcqzIP4/PED3LcZ0VTmWkmPsDxewDDDMazneMU+dxypVmMPkzziPZ+IYG8woeCKSHYigVveohvuySKBBakBoTmIVBYu6YjVxp4Sy58Z1UXINzrstEz8s8NEch/8ZIFMTnzzHckSa8K0QQ+vVymjmoCL5sCS4MinZ8OBaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Hg3kN02eIyu2V1IlEAQ/QcL8+JpyBO+yf59F7xDroI=;
 b=jXX2QwjiXLvVeaAVo5d6Xpc/nRs0u237go9VYVdbBvvfnEl1ZeZblgJNLvfRwalRxjM926e9Y5GNPsQNyBHS55cwotdzbb7CaHd7biaeVQJLDfyaZRjwiuNeZ+At9qUijhiNtP1s1e/4e0meV2zK5/hR956x0C1XJ77WqC+LM2n86udpcCHgQnKkaZGacNYhLn0u4jzDa1TfBeJx/6fBW1bLv5rb/cPvgWRXlX9znam0ze2+JdS6+s2qbll9gEejtRjB6ml+GZVf3Qvis/B1X+ZmAf8CrzBvHadlbbHa/l14pRW+5r1Hc2ZOH6eYoV1PzWCI/RAGt5GhA6ysjQGiEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Hg3kN02eIyu2V1IlEAQ/QcL8+JpyBO+yf59F7xDroI=;
 b=PEzjcQdMgg4IV0GFjwAqDiBQxSDkzWf3uDj8TmvTkq3YFABkH8iLTiJMcBj82AG7q7awEMM5x2uNoL3eJP4Ug+LCsim5gRaonJsOXdHSGxja4hjFAv8wumTIICIY4Z0IxL3Z2cymeSfBqTes+DchcM/oIWcb14W1eImjDyRihjU=
Received: from MWHPR1001MB2158.namprd10.prod.outlook.com
 (2603:10b6:301:2d::17) by PH7PR10MB5831.namprd10.prod.outlook.com
 (2603:10b6:510:132::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 13 Jul
 2022 22:26:37 +0000
Received: from MWHPR1001MB2158.namprd10.prod.outlook.com
 ([fe80::65fb:fa92:9a15:f89b]) by MWHPR1001MB2158.namprd10.prod.outlook.com
 ([fe80::65fb:fa92:9a15:f89b%6]) with mapi id 15.20.5417.025; Wed, 13 Jul 2022
 22:26:37 +0000
From:   Indu Bhagat <indu.bhagat@oracle.com>
To:     bpf@vger.kernel.org
Cc:     yhs@fb.com, Indu Bhagat <indu.bhagat@oracle.com>
Subject: [PATCH bpf-next] docs/bpf: Update documentation for BTF_KIND_FUNC
Date:   Wed, 13 Jul 2022 15:25:44 -0700
Message-Id: <20220713222544.2355143-1-indu.bhagat@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0062.namprd11.prod.outlook.com
 (2603:10b6:a03:80::39) To MWHPR1001MB2158.namprd10.prod.outlook.com
 (2603:10b6:301:2d::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 900cac54-526f-465f-1994-08da651ebfe2
X-MS-TrafficTypeDiagnostic: PH7PR10MB5831:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SLa/fJVn7DM7FG+zbOaKiwlvNk2TgyGZPKRBl1+mGhL7WJkiSLd7L5b3GDdADtZ1LuqxfLqkyG0aODbMFG3BK4Gj3fkEXkf35gGjBGg6rbA0atsCqD3rZcubEsiQ7gEmvK/9ZPXbsHEFDujFbFijg0Tyf5YwRRhEVzeDOPwB6kdZr/Wg7glRPbedhYW26a1S0MpAedZjI3wlyfoFGLvaBOHeSfXIWh6ETclUFXeeVODIkvA2n35DT+HjN4jvii+RuHU8pbQH86gX8bZ+xFq2JfXXnH/E+6h2/E/ZfS878D43quAsIZESZ1NPYTv1HdhGI7960gQce+U4v2mA8RtPOvmSC7GzUkG8QRu05ujWaGIVaXJ6oqM1u6IZe827fDCWYHWaIq+yIconj/78qpo4NF0bdJBJ5pp5XSzkdHOZg79aH6FR7ULAuWjdqrpiAaFAShWbpGkxhuvW70MLc57EPLY6U8hNrCIa41tB3xoAzLSqkksLWLDjJ51lq81iFYg5WMRXavEPIL6Z7+vKf+exTEkI9XjbDKx28GlZsFYZHP8un8GY8NeXWY1VDM1W+UDkXfGjppwerURNIIkASaKzNalMJTXdbutFg7VOQPvrpC/bgoSx9kJCOtpKpbXkPlQgkP1LEZj/gbbMyT+mfDmMdfPfKErSp9IWcUqGJvsFL0hw0INNvzR3n+Pm5aOW1llaAiZoXrxxtzdhzvMjq3Srs8k8fCxKZd32IJAReZeIdlFpIxx9Pps4QsdPC/4iJdjE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2158.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(136003)(396003)(376002)(39860400002)(66556008)(66476007)(107886003)(83380400001)(86362001)(6916009)(1076003)(4326008)(44832011)(186003)(66946007)(2906002)(8676002)(4744005)(8936002)(38100700002)(6666004)(6486002)(2616005)(6512007)(52116002)(5660300002)(6506007)(36756003)(41300700001)(316002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XrDxTZQ7peAzpCEKma6bBII6+7DXOBrhGq3VI0spEHd3NG5F/sP1lMWbItwy?=
 =?us-ascii?Q?ltvEeT7hjCBG7ESlTt+wIDN70pAfAnT+xZ9ht9znCbGfhQMTj9JAb9Pv9H/2?=
 =?us-ascii?Q?qtSiGcbxZNcLZWRED0/YuxWP99SWaPIrcFJmWLNue3j91GYV6qBShmjmFGoF?=
 =?us-ascii?Q?/KS+5Wxo78p1voROMRG3b1cfQW5be5NGiyfDiriWHkxk/3jiyPC+zpW+vjLR?=
 =?us-ascii?Q?SekQasuXFyoig5VpQ++8czDw5xsQ2FW3ORYd/J+UABREssCthNoNI604vhIZ?=
 =?us-ascii?Q?G/V+PVC1AyUjyYTYyUrFlACHCI+mbmp2iBkzbTmsTPEeeNucqpfo3dciRb+d?=
 =?us-ascii?Q?A5FCLzk0o4HCu3KPjhDAOwuATdPWVZpkS9JnyjPkyhZ0kPb+r7SNRViTydMS?=
 =?us-ascii?Q?7tKlkVhMtGjc7Gx/KOVHEy3z/cIUaJlCJ4dqe3vRXpo0d7yvwBz3MdjksejK?=
 =?us-ascii?Q?vxAI+mBxlpn2ilzGfUv7Kim56mq7356CU/ULXcZwsla4TIDuUqi/xZedvQUw?=
 =?us-ascii?Q?0B7FH6fUCTHzZvAgCEF8GyeF7NZbijLQVQZze4zCn1RPDnDqhpJh3rEVbL0K?=
 =?us-ascii?Q?IuvxKSI6mCQ72j/C1lYezTVFum4rIPq91u5aa4R4CLtCi2ZmzX8fTSTt+mBw?=
 =?us-ascii?Q?rweGNy62Op1JngV/tLLRHahEBgQWOriyVLaK9sQNq33FWlSBioZGQD9HTyVU?=
 =?us-ascii?Q?zvePCaVCdbzLw0Afv06XQwzNKk7jfV+d02/PaVaZJi5QmAIgH4XYuU/FX/7H?=
 =?us-ascii?Q?L+tPYtZCserqVjbyakithyiKdxP7Ku7aeXzY7uMxH4YNe9jD5TdaZTv0SK/P?=
 =?us-ascii?Q?z/1xpCOrpIS0/9Gl4r/0JDlyiNX91hhn68mwHUnQ9ZuBT5y+3Kj/TCfFZA6W?=
 =?us-ascii?Q?h4BrH+RHF0mG2lgYa6I3CjoRIMeh/nj/W3Juwim8c5m9FceI+BcCfYpiysF7?=
 =?us-ascii?Q?PI+YQS/LRXsM0+92jglHm3hy+Z0uNfd/pUzJVdRZNzEteLoCnfEDbo9D6100?=
 =?us-ascii?Q?7F1FRlh1+Gmyw7pYnof57bS/FBjZN9hQ3bsoKRaPaPW+ZTD40O/x+p8YUI6z?=
 =?us-ascii?Q?YQES2pG461XBvCqbFV29vmcFbD4JtNSEvaJip2XdsA5mkVXuByuMXtacEsVU?=
 =?us-ascii?Q?ACpVm/5xktXX2Fv3GbtiTOBPtsSZOG3WeQp2duDXpiK9B4Ze6Fx8BpbmR/BM?=
 =?us-ascii?Q?e7NOjx4SUX40U+xVhr7N8v8gaeXmAMmn5s5H2mxK9uWNZWtOwehD/wjiXslY?=
 =?us-ascii?Q?XJzrq8Tbr3WSkjRr5Yqp3dqx0uSs6YuxExWuXmpW5/rRwnw7jB5PnuC2qs6F?=
 =?us-ascii?Q?iejxeyz5SEtBXCf3BiD6eckBBJhBbuxJK9POrwA1GcxcEi9kmfsFx51nnXXA?=
 =?us-ascii?Q?iwL5stull80bXN+iA2i3YexKLGHxW9HzxALDdwX+X0M5diDFXVImMZZL7XuW?=
 =?us-ascii?Q?gaRQsaEw95wxjKrmCD6VLXyQGIc5W1vVcG2r/IvfNLY03NocUPR0aLkaNDSg?=
 =?us-ascii?Q?7tbp9GgRQS9dEtQv7wUA8JNHCrSBmAj9UGci9TQRhrJbgU3zcrC4kxKhZMsp?=
 =?us-ascii?Q?NOeCss+pVNjL24/R3lAEV/e38jtFRP+gqfzPz166XJVtBChW9FVliU9h+4N4?=
 =?us-ascii?Q?Ug=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 900cac54-526f-465f-1994-08da651ebfe2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2158.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 22:26:37.2630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K71M+VSyvFzKbURS4YSijsLPT6qJVfpj2+GV/5falIEW4Rv5tWQ2hXSwKm1VVmWlRaAFaVEjKZV5JpcmxAOOiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5831
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-13_11:2022-07-13,2022-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207130092
X-Proofpoint-GUID: Ai2nyXFn37IdvNljHCsd_IneaDmslj8T
X-Proofpoint-ORIG-GUID: Ai2nyXFn37IdvNljHCsd_IneaDmslj8T
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
linkage information for functions.

Signed-off-by: Indu Bhagat <indu.bhagat@oracle.com>
---
 Documentation/bpf/btf.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index f49aeef62d0c..b3a9d5ac882c 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -369,7 +369,7 @@ No additional type data follow ``btf_type``.
   * ``name_off``: offset to a valid C identifier
   * ``info.kind_flag``: 0
   * ``info.kind``: BTF_KIND_FUNC
-  * ``info.vlen``: 0
+  * ``info.vlen``: linkage information (static=0, global=1)
   * ``type``: a BTF_KIND_FUNC_PROTO type
 
 No additional type data follow ``btf_type``.
-- 
2.31.1

