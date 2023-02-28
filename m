Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724506A5088
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 02:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjB1BNH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 20:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjB1BNG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 20:13:06 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0B99772
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 17:13:00 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31RIhoTn015596;
        Tue, 28 Feb 2023 01:12:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2022-7-12; bh=FpCdo4JEuEiEz4Wj+wv6E52sZJyqRHtUEh5/sx1kdls=;
 b=gg4LZobTiY0SNHJehe33BXhTSUqNyRK4EXIIxpifroxklOjvzTfzDKdzWcSUVk2Pt8LX
 KE9nBuPcylWYfw37GLVKyebt3s4hp7FfyhBVLKxVQtN5FxfSn1H/c5STS+aH09PTAnAN
 kn6PhRPvmFVHoNabzmSRCoH9lEeAl5jKSD1t5kyOUPM2VktHaSfRn78Q9fiO7r5TCjJq
 L2qPbs7TDNXxOTFav966q1+YB17r1GK60ZxI534qkcz4ONeghC0IAxsJwsYGD6e2h5Ce
 x6gZlH2zhG9VUesYuh35HCY1nSl7ovO5xSIIaWjwoIM9ILEBUK371txIOvSZGXc/imob NA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nybakn329-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 01:12:56 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31RNBb4X031562;
        Tue, 28 Feb 2023 01:12:55 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8scuvvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 01:12:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zk3jqWvsm1mqgKss9TokmSQemrwHUyhALZEEHTfrBEnIQrJlKFBF4llJNKqsu3cBukUXgq7v2iOBIMnnqwhjZ4Y/DHaB7HJzJLVPHOG158kuqin/WPuBlJLZfN1OVJjHHYPldD99ZKBogXCVWrkKiLfVR7obh8kd1eU93dB5tcJVfg57/lEK2vGNi9m0XGRhW6ZqcoM70LGr8Q0pRLCTo/OB4F63kZ6ElzA3vHlHSlxeRsi6SLkcDOJUv/StKr+jHqBREewDFtaBQHgaljgiLEug+6s8v9+hU06KzAxDL8LYC4AMuJPBtvu889tqEtQ3xvNjyUiT4c2z+jrM0k1S4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpCdo4JEuEiEz4Wj+wv6E52sZJyqRHtUEh5/sx1kdls=;
 b=BkTfhPRQ28xB8ingJIx36+0BxFlye8vvLdFrxT0pCzccKSrTO8tmNOXsDAuPATArWye8jTRpx/91BVOZR/6IU4z9HdMVP2ycLEw1ewnn48s88prv/nScU/YKIIhrB/GRniE1B4l+20QkxXZrxncbCGuMOZ6tnELoGAdRbzXZWOoUrzYNpV72IrjY9+aOBZl8MnlJEDm+KXt2k78WDrV0Wkx6Mck1+nZQn12hFJ3/N0y/iuR/7OM71yuqTicDijMw3xTVIG3iajahor3S6CuBz1qISwX51E5OY4RQd3sLmirqwCcgTK9RU3AoshjehL1M4XhjzlYMz8uvx1NvFROeOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpCdo4JEuEiEz4Wj+wv6E52sZJyqRHtUEh5/sx1kdls=;
 b=zSBA8LV00wNGex+4QVbLD8w420ip3Eh4/qVRuURrVmLqD2TOJszPwLdJeP+k7/zjkmM7pxa2OMoqodNVlQMDBLE/NXgg55OqXCPRHAmPqpKdgaauYxtgxxBWJhnSJ6GewBKZ9Jh6NGJk0ADfX+YeY2wye71+/su+SW1W0KFEpyk=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by SA1PR10MB5687.namprd10.prod.outlook.com (2603:10b6:806:23f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.14; Tue, 28 Feb
 2023 01:12:53 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::486a:626e:635a:3ce2]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::486a:626e:635a:3ce2%3]) with mapi id 15.20.6156.010; Tue, 28 Feb 2023
 01:12:53 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     bpf <bpf@vger.kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@ietf.org,
        Dave Thaler <dthaler@microsoft.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH V4] bpf, docs: Document BPF insn encoding in term of stored
 bytes
Date:   Tue, 28 Feb 2023 02:12:47 +0100
Message-ID: <87r0ua7fu8.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0501CA0043.eurprd05.prod.outlook.com
 (2603:10a6:200:68::11) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|SA1PR10MB5687:EE_
X-MS-Office365-Filtering-Correlation-Id: e32e788e-f5ec-4639-3107-08db1928eaa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FbtXDMm6yIA0svWwMtvOAxXIzuT+/msefbfykNxagvYn2Uh95ailuJnfQZnGVzIscu40bRhGQMAKfPJpt2GmeLdMNNG9iAAnRWg2siM+i/EN45IkVocEJE6FzrMwec3M+MfCq9273NzeekFArYluStHeN++mqfPoGl4/SVa4CNwoQoLyj4qxNUll/06lmmxfTP9j6WDZJ5ZlucmNdohHy8+2E+pyQpnW2YLE2pljdsawjRbLOBQ+MBfJxBiAvRzevGZWy8KIsxscgp+2Yae56p8BdAjfEHf6b/dETpVZPFjXZwzGgIDWdfzsfTOVhUveDKMlTig2Ly7/UOC50xJ9MwuhB8WWD7Yirk0MOblSqfznOb7LdxBCxCgnbKUapbp3yZs76YaXU9viT5mBFoBfMssBQuuWkhLlcVyPgv3HObzm6MlOkoDoZMY+Wer2EOPjvuEXx2OKjx+lU79cpihPqIwDyEs6gu1gKgPKwkkuVUcsuQYLQrOWHAdoi9gE4EUOSPvI9pJq602Y0me+WAXEvFbdxsKScmLYlBV3WCHzHrFRa9LrZADfPMumkLVP2I86kfX2SX7MDVMtqBpFDqDQXuejw2gut7S/0ebw1EcqRMl38g03+nqsSJ4hZlqjITluBmL3ogQsK3+fbbbl3QDLFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199018)(36756003)(316002)(54906003)(6486002)(478600001)(2906002)(8936002)(66476007)(66946007)(66556008)(4326008)(8676002)(6916009)(41300700001)(5660300002)(86362001)(38100700002)(2616005)(186003)(6666004)(6506007)(6512007)(83380400001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EaUcRb7WwVOslC5nQgzwbnk0mfDzuVZpgBNcItjs+1xivE169Ja7VEwtJX6f?=
 =?us-ascii?Q?TyzFQoa9AG8etDXWuv/40nroUxAyhGx5efvvmAGgKvmt0oBjgb2uBWmEr69M?=
 =?us-ascii?Q?dKTz2a2HC3MGM0ehexkw7cxyquO4qkKLzgUD0phRdZQmakdKRr8WrJnGOx6J?=
 =?us-ascii?Q?buTqpuJj1Mk8Qf1tGJsrHCXMme+VmBv4pTbtD5oXo6mX3e9+L4BKa8pqT/Ix?=
 =?us-ascii?Q?H3sLCi7hW9tbBxfMWpSzNdhroUGIWuH4SvDMRd92ouOUo0iDgsDiFV5cRnOe?=
 =?us-ascii?Q?r5sJh/sRE5tlWqZCbNEbEGNXMkGIdtfNQ2/p7UD0kYp63PU6c3NZJLsp3VGO?=
 =?us-ascii?Q?L9Q813O+MlyE2gDTam8TkRw1Q0Bw4vXFVgrermgQvEPZPM3ZmDclqIsFr6kb?=
 =?us-ascii?Q?5jqSToEAw2wVa4EnFHga1G9CWi4RSiPvmeClZBVephRFcPArgqRs87vlt54F?=
 =?us-ascii?Q?xvkrg2sPBbfpDB2WWks8mp2XlbAC6M92OaBQBI2fQ/6VubQuLmROzfemnqkf?=
 =?us-ascii?Q?oCNE/N6c6KyZHArxDribWwl70JRUeuYyMRMPg+QIUwYTMsJm+/Sfdstug1H3?=
 =?us-ascii?Q?MUke0wBtP0TDWyv5Y/AbcZvm8CQojLRGhZLnumdUz2VCWlbhbFe3J8l4t+YB?=
 =?us-ascii?Q?hvYsLQMuruKJiOEG+H4nDMClCKexRgaVDTXKd1VawTkrxemwJTYYznzAVJgG?=
 =?us-ascii?Q?6ZolVUjySkZ7x8TMPeABRtfVe/bCo7CGsph5kxQO/7v1ecENfl77Vm0TMnjD?=
 =?us-ascii?Q?fJiIWXSJk3gGeW4JzgvDix/kZ/fdrrbWXzWaDeyRVLVuQer9IRodLDa80AWL?=
 =?us-ascii?Q?RWB/7a8aBJdBbUzQuD5+qfPDfSTiGVSifNqaJs5aeRnpfWbsjeqc3FufMLuB?=
 =?us-ascii?Q?o/4vCVFSKX4jRlPSMYFDTocN9NpfCf09Dl0eU+cXRt//ZuJeaDThx9Wsb/aB?=
 =?us-ascii?Q?08NDfktYnY/bO51oNn4ZFdOHiGfjVnNZJOZFEOhe4oRb4AWXklG3sTiCkvB3?=
 =?us-ascii?Q?fQxDAB0l8mN7d1cyTaL6Ym6ZEvCre1kgo+95XM/rRWV4+ao7RHi9CropBUUr?=
 =?us-ascii?Q?YOgzhL2X+ErcyPu1qp6c06ftWPXHxvIdhWgAmQwm00boB2kRxFiAeqh2p2Ee?=
 =?us-ascii?Q?UyGupMD2n/FOjS00RvOUat0f6UFM3pD2bScb7pVZMhUnUipUgGBAMSfrGy7y?=
 =?us-ascii?Q?93i5wJJZ8us/GchVH22BUlsi+XXfkvp7AQzwcfAqDuF1flk/8gMbiyS5w8GW?=
 =?us-ascii?Q?pX3ddKPVUwnKXf/5jFXEShJKJviH35LSsgDctw9pNEfEoYW+YNY+jrBh0c+E?=
 =?us-ascii?Q?n5gpoVQ0fY30nF+VYDsO/xTIwkfbahMNxHdvphnlAfYd4uOZtlgfXKdhf/yi?=
 =?us-ascii?Q?Bhwg/pnZbME5RDfaRLypc8tsqsDHVNZLrcM32o5HBF6Y7ZO8t0H9MpYS9NBC?=
 =?us-ascii?Q?a5T5aT7+k0grpJZDr8FF7nsffIdAJAmYUNPgCPoTRZ/4IAjSNDFLWWnBFQP5?=
 =?us-ascii?Q?OsFFWAl0r67//KUk3O0L/jxkbliTy0VIYh6dydmmIiJMobZeSqrDPJlMoN+e?=
 =?us-ascii?Q?uyxlRHrPiWQrzJyZuKXOBdffMWDd1wMRaeDVydBewAneu+EhJ1r7LgtOjUjI?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /jNMEXIIoBa2yKathqGfd8TezYId5AHk9ojIdWJIVjfzp+L7ZcevAMAaimTF/zcxVPJwYIDcMztkDdTRFUGlr82CVhBnJYjbtaKIbjlazGpcvBhF1apyQJAqqvXZNgLo2s+egGnH+Sc07vxJZutiN8S80tvAUVTT24X6weZNjoD4fWzh0srHOhYDiU8mcK6qw3WDsYj1I0A1tUUxPRBTYQFTG/QbtSjIN5FUpmI4R0XnrW2E65cp1srYwTyvEeyTOLhXGUuPHpEhb72SQ1S1UqU1XF8x2VyWKlU+B1GsYSIvxmsMRZoEa6hjz0IUHBvmLmwQieTBvMQAcz+SR1zrQXn1x4+CsZiOhCD1EFj/g5+KUlFQEh7zJrQU6b7zK7F/BZe1vIC1yxUUByW63Hy9gbISSeQ3kxCdmcejXeUTcsFzD2i72DD6exwucUfTAPqp+vL573BHLwMdt6q8xIzOwKW3YT99LXBWYpTTqav56lC0bSeT9IQqWQUPQSQBOeohh1uYbDODyZE4NDnRlKuX5x/CTakjCfCuRAqJHd1Pd22ijFAxuhIjNOQttAXSfDrSkDg7UmDGB8LasFgrdoHBKlZXpzcOZWMqZn7YbQ/BXF6Rn31zSMkbgSozcku/GDEtntWIW36cNwIcHVOkL6pPRwKWAHy31Kclkona65uJ23Vf0sfmeXBi/KCYLBm87PwuvCFqhSlhSxlzekQmiwKsG049/GaqUTfO7hpKrboTZYppZ492de3UlI5wvWQGRBA7PU0j+OH/pQ/Yl2AIVj+naqp1qtWO51InsGKjnbK2cJBiaOI6X95y7AOyMCA/lXWLMrAPxSkh0zAV78nP75YIvwiOMG5j3INX3HL0LYumCv3ksKGwunqLXzBgqhDpaBzE
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e32e788e-f5ec-4639-3107-08db1928eaa2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 01:12:53.2066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gBpyULWUYrae7i/JpTC7a4r7xPg8tS/D4lBnh0tesxohcAO3VbJVhShERfd3oVYazo+AH/+wos6qdFYNAX3fWreqpeJdknDiGkyL9ep0+lE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-27_19,2023-02-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302280008
X-Proofpoint-GUID: haGBx5qUwR6wf04OXXdB0o4cu_wV_Nag
X-Proofpoint-ORIG-GUID: haGBx5qUwR6wf04OXXdB0o4cu_wV_Nag
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


[Changes from V3:
- Back to src_reg and dst_reg, since they denote register numbers
  as opposed to the values stored in these registers.]

[Changes from V2:
- Use src and dst consistently in the document.
- Use a more graphical depiction of the 128-bit instruction.
- Remove `Where:' fragment.
- Clarify that unused bits are reserved and shall be zeroed.]

[Changes from V1:
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
 Documentation/bpf/instruction-set.rst | 46 ++++++++++++++-------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 01802ed9b29b..f67a6677ae09 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -38,15 +38,11 @@ eBPF has two instruction encodings:
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
+  opcode:8 src_reg:4 dst_reg:4 offset:16 imm:32 // In little-endian BPF.
+  opcode:8 dst_reg:4 src_reg:4 offset:16 imm:32 // In big-endian BPF.
 
 **imm**
   signed integer immediate value
@@ -64,16 +60,17 @@ imm            offset   src_reg  dst_reg  opcode
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
+  opcode                  offset imm          assembly
+         src_reg dst_reg
+  07     0       1        00 00  44 33 22 11  r1 += 0x11223344 // little
+         dst_reg src_reg
+  07     1       0        00 00  11 22 33 44  r1 += 0x11223344 // big
 
 Note that most instructions do not use all of the fields.
 Unused fields shall be cleared to zero.
@@ -84,18 +81,23 @@ The 64 bits following the basic instruction contain a pseudo instruction
 using the same format but with opcode, dst_reg, src_reg, and offset all set to zero,
 and imm containing the high 32 bits of the immediate value.
 
-=================  ==================
-64 bits (MSB)      64 bits (LSB)
-=================  ==================
-basic instruction  pseudo instruction
-=================  ==================
+This is depicted in the following figure::
+
+        basic_instruction
+  .-----------------------------.
+  |                             |
+  code:8 regs:16 offset:16 imm:32 unused:32 imm:32
+                                  |              |
+                                  '--------------'
+                                 pseudo instruction
 
 Thus the 64-bit immediate value is constructed as follows:
 
   imm64 = (next_imm << 32) | imm
 
 where 'next_imm' refers to the imm value of the pseudo instruction
-following the basic instruction.
+following the basic instruction.  The unused bytes in the pseudo
+instruction are reserved and shall be cleared to zero.
 
 Instruction classes
 -------------------
-- 
2.30.2

