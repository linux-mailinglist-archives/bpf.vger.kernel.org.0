Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E90D55753D
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 10:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiFWIVW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jun 2022 04:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiFWIVV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jun 2022 04:21:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0387F4831A
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 01:21:20 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25N7DtQN004659;
        Thu, 23 Jun 2022 08:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=/DY6rTbJ08iXYSOe7atXoJayzsGIXeuuj0bG5TCg+P8=;
 b=VZKI7m0GWjBOKYVYFwXxkCiU7/KR3fzkXpUDUYnZDe5dn51vWUjy4w7ut0sIHhXKH0cF
 sppHQBrNS7doy94m4ABu67yC4OwQRgQPuU6u1jqFuI8/SKmnE83eGjBdSQyPu82oOIu3
 I0rFljiMC+JQI15/2XY5CzYSGdmoRMPz8W79sVXlu8lmkOGAqPY3VNlIoLk3tZPE9tTY
 t/zgD32WlKEJe097jDiYmBmfo55ZUK957fQHYC+8xXPt3/kKV5zAdYBBjoFECeFXewRI
 FHgCc3YUFnpuj1nlXtILFKtmkM2//s0E3z+X9sBHksfbdtdaFFCR2d34gsda4CJFDY6j uQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs54ctcyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jun 2022 08:21:19 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25N8Kclw040545;
        Thu, 23 Jun 2022 08:21:18 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtd9w3k1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jun 2022 08:21:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U26t6QjRFvOtWLsCe6R4soUAwz0yLUuLkNd6KW95RjsjIKnTYOOE2RZT4MK5KA5BlJDGVLMbvD5U/g6HQvYn3yXRxT3rRKuxrBC7l3afEf5z047azM22uQcdWbG5UEjKzWc9DUwtP+ebDEc2pwijRXzjl22CrtpZqHVZSuxZS8BXoOF/FldxCv7iJZG3StalM40gfRcDJMyvoF/RLLDeyD+yvFUDDPxASK1vBfgoJBTmkXpnhV8WSWi8AZy/KgBRC0gTdbwojHj2lPCV+qeD7o3Xca7mcOh2ckTXkQUlsVydXbdclcpyXqN33n26M3RccgmstMvbKDey/fcks6YrAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DY6rTbJ08iXYSOe7atXoJayzsGIXeuuj0bG5TCg+P8=;
 b=IpuwS/uowFCRZckqoZYdYN4LeUwt3xAGG3bOUqoex0GIkuTqq/ZHWgYdb/DMC/L06WsK3KPCgfe5bWA0riPNSvy/0kqMKN+DOI77P2yWDO1g5bE3zl6OIH0kMESGgmzcnuU+sGepRWgKey+sNw5Iue+P0o1Cgq14eojy3VyjUMuLlgPsa9Y6Dd6BV5CfOb1dSuEAsLQVSGEvTNEE2FRREcuoABQhQpzK4my+ztvAoQgw0nVjZSnmnhFal84o0eUaalBk2IdNldz6HjZDLr/8pi4i5/QGdzD/aKfX4DcXoq9cTFIid1de4kUQa0Qjp+w8gSy3fA7578stcqYBdVExOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DY6rTbJ08iXYSOe7atXoJayzsGIXeuuj0bG5TCg+P8=;
 b=H7LkoFdZ4Id2GA6516NXDl1rvX2DsuFB6osRmqpcxtfx6pVlkkk37/s6WFkMvqDxZy2iBNu/grqexByCKKG3i93NQKULJX7MPHEGftAvEtktS+chGPGmREVE9vMyQ9+lX1hSU1ZMoc0Z9iEpzxHDB5WXguoekbfKNO2H+AhSIl4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB1962.namprd10.prod.outlook.com
 (2603:10b6:3:110::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Thu, 23 Jun
 2022 08:21:16 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5373.015; Thu, 23 Jun 2022
 08:21:16 +0000
Date:   Thu, 23 Jun 2022 11:21:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     eddyz87@gmail.com
Cc:     bpf@vger.kernel.org
Subject: [bug report] bpf: Inline calls to bpf_loop when callback is known
Message-ID: <YrQicyVuXTF3WecL@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0169.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::16) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6188126-5b78-41d1-8915-08da54f157f2
X-MS-TrafficTypeDiagnostic: DM5PR10MB1962:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB19624F3275B125087378815D8EB59@DM5PR10MB1962.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Du/K5daen3ikZ9BRWTTgKaWqG6omuJImz3sX/U+q1xQ1CoT8MARNuRnu53ztfXubUaoOsNzu9dJW6uVUrQliYGc4JqbgySspDgAZHz6WP32m/9WxMqUincShhTdzXvnKcpOHQXBk8nOMeWM9pTIWzvhkzHIA8K/n6fVf5qIgi2i18HreNkhJHeyUKtqJa9frqSsn6DKcM0wppDQC/1anpVx0lUdXJvs1QcHvNiLs94R9U4BS7iJf8nOF63S0fuPjkfC5idWYQh2kYb0RwmxVmWOPGGZklaQkPFjiGp597KBulojxTK5rwA0uUjxzmALz34a0J3bYl9xkWAxzjEZ9G0j/WJd2DZquD56sjqsiwtX33Y5Lfi2lDqq9P6MUHCiACbgU8nl7uPwWJGqhKwm+38NTMvJY7fWi0SA8JlVOyJNWT1pQrX9szjy07hANDRkCe7LlO62s2Q6K9NLcJdE73crd1G8k7lmWSjoVuNtjghJre5345e7znbQ80riWOl150fD1J7jYVbBhbAImZkrzPRfwJdnNUOYLmumExgMVlukG5Au2w5jZIQexxxx0zJYv1fdoEgzjzQpRxdJXddwjZPzD7VhTiOwNOgJCfeIAxH2rkOcc0upLwWKclDP9/eSKTnAl3H/W0yfUJgB3OZmLhXzcONVhh/bbb5fLpHuCcjPDPFHQ0u1gyZ5tCZ9JwC58Ff6/4Xl/NjBWtOV/YC8ptpvx7t0zw4AMMwVG4/4G+yq2fy5EJLRItt15V69saaW3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(346002)(366004)(376002)(39860400002)(136003)(6506007)(66946007)(316002)(2906002)(6916009)(6512007)(8936002)(4326008)(66556008)(33716001)(6486002)(478600001)(38100700002)(52116002)(6666004)(8676002)(86362001)(66476007)(44832011)(41300700001)(9686003)(26005)(83380400001)(38350700002)(186003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dV3xn++rM5tA8F4icp6bC+3HGbDxRzncc3JmNzEji9EwKSs9s3ucbm9ggszq?=
 =?us-ascii?Q?HdvxIrXCK0PnPlUmzwdh4F/m7Sih5Z9b06eRk7YS0skp1PK1Xsef7qVju4FL?=
 =?us-ascii?Q?o0QrOWfynEtbM1Q+qa0lZUpxGpY66CyJbnlQ7ly/JPPdAIbDP/nJEH/laDZi?=
 =?us-ascii?Q?Wt2vC2FeCQkPkZlHESAdVwKQpeLItd7wnVv/sAPDbesENOXRpQTyICgOP42G?=
 =?us-ascii?Q?FS/jwUB5KgFndP/GUa8jXE4Dgxcpwq2Vw+W6O5OTtMFVfcZOZP9Efikt80ut?=
 =?us-ascii?Q?LrAfi8zzUruoTvbTgC/1njRCvjR01p6AWj8ZFQbfQUEjg3MGUm5YAMNeeO97?=
 =?us-ascii?Q?OOdpXMElDcXpURa+zyl9q7TdkHrLfkI+gO3rw765EU/+AQ1+gW5vwX5A59MN?=
 =?us-ascii?Q?HAdzk7T4I/xrZiFG+WnM6xdSRGveyO0t4nRuJG4ohwEUAamlni7Nwiy1udzq?=
 =?us-ascii?Q?etst4/vBFzZ2ChAhdreNmIProV5e43UrlO4OaOZElXYPhxtogNGNgvVgDbgb?=
 =?us-ascii?Q?a3hwoHXMb3ZoilNFraS3AzV8PwkuGNBYNntqoxmqgYlTF4cI1ORqv/BfJfp2?=
 =?us-ascii?Q?mukcnoKTCCN4hYMEF2191JPV3zvI8viErDWfXLjNuvCWkROwhrtbRkw/bi1L?=
 =?us-ascii?Q?NLpDKad4sDN12g7HkxVyS6987kHmNdmVBD2GJbO7I8eH1QkjZ1OdiQ/269P1?=
 =?us-ascii?Q?wRoDia6iQahHld+3ZQpWftWLHy4seZYL0813eZWomGHzzdmb0uzfN5dcD2Ul?=
 =?us-ascii?Q?yR2QX3DAjKBFwegJpEr0wPysHQD/4tiFKQniip+LThKUOFN0OZVF2vWikK0Y?=
 =?us-ascii?Q?iLu/Lu+HZSsqpfx6TlzJCNV5hZ0B76VSJTAsjJi9RCmPSRgumXj69/A5BiRf?=
 =?us-ascii?Q?09VlQ0BBf8SgeuilDCUdBbGQKdMM3V5TAT7r27J8RcoIuuPAK7S10ogqSepp?=
 =?us-ascii?Q?LlSFy0oPsPdJMZ59gdXKr98I6TTI+KWtSKtyUKFP7BiyVHwPnGXjV2egsION?=
 =?us-ascii?Q?bTX8htb+M6eMjHBcRiAMFJBm36d9e1vLrETxVCaxHvV5cJgc2JhS6eKWjFt9?=
 =?us-ascii?Q?8b90+19oynT0eO42v3paVuAeueJuTmT6/bvYSWfRUdeMMYKeXYZwoFg+eBAL?=
 =?us-ascii?Q?hwdv3Ja+/38evaKyY2QIuD00gQ4WqVBIkndTLLrBJ7S5SIU5Q3RSUZ9DF9yo?=
 =?us-ascii?Q?dESINZ7qd2CxFt/7zXdDhU8AprLC7FJDtHAGOj03IvEcUEGlhCLypzDR+9PD?=
 =?us-ascii?Q?ZU7yOYpBp7YuV6ncp3uLoRvLX3Qilp2QqxjEFz0odpK5jvlyjtejv1wzJT/L?=
 =?us-ascii?Q?5EUSBmMIh8nsPkhBRh/8HmD2pE3QRCwBGZ7i60pNBrCDf032KUOcCyowAOeJ?=
 =?us-ascii?Q?RAru6w63hkiw7DUMs4zsokDvHrOzrfXVLHwYJWG25pjIBEDHeyU4ZAbwrLcc?=
 =?us-ascii?Q?NnQYiXjmJRwwBa6Pf/cAhoi6ttIS5CYJurGWS5wgdqksNePQ509MQJm+/+E7?=
 =?us-ascii?Q?pZ1oXFUWgyvQHAXovSYx4kwkXkZGL1+Q19oc85ZsD19Zgmuo8w9q1qGiKUVr?=
 =?us-ascii?Q?dpFDbnIeibn0eOPq0bKHj8kM5VM9g+G9RJ77RWFFaBlvC7IYLPf69tmTdYqH?=
 =?us-ascii?Q?DA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6188126-5b78-41d1-8915-08da54f157f2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 08:21:16.7429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tbOhACm+0R+inuXJsIS99cJ4kGqwl9/B/mSwf86en3bf3YKNTHtivuQt+LkL17Nf0s+fEYK4nuAhTHT8pdU5Ja9WGZY6pIDtpzSL+IoXpOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1962
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-23_03:2022-06-22,2022-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=839 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206230033
X-Proofpoint-GUID: y3R3ZRiV6J1o2X5eMDnBITVtooOxIhSO
X-Proofpoint-ORIG-GUID: y3R3ZRiV6J1o2X5eMDnBITVtooOxIhSO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello Eduard Zingerman,

The patch 1ade23711971: "bpf: Inline calls to bpf_loop when callback
is known" from Jun 21, 2022, leads to the following Smatch static
checker warning:

	kernel/bpf/verifier.c:14420 inline_bpf_loop()
	error: dereferencing freed memory 'env->prog'

kernel/bpf/verifier.c
    14350 static struct bpf_prog *inline_bpf_loop(struct bpf_verifier_env *env,
    14351                                         int position,
    14352                                         s32 stack_base,
    14353                                         u32 callback_subprogno,
    14354                                         u32 *cnt)
    14355 {
    14356         s32 r6_offset = stack_base + 0 * BPF_REG_SIZE;
    14357         s32 r7_offset = stack_base + 1 * BPF_REG_SIZE;
    14358         s32 r8_offset = stack_base + 2 * BPF_REG_SIZE;
    14359         int reg_loop_max = BPF_REG_6;
    14360         int reg_loop_cnt = BPF_REG_7;
    14361         int reg_loop_ctx = BPF_REG_8;
    14362 
    14363         struct bpf_prog *new_prog;
    14364         u32 callback_start;
    14365         u32 call_insn_offset;
    14366         s32 callback_offset;
    14367 
    14368         /* This represents an inlined version of bpf_iter.c:bpf_loop,
    14369          * be careful to modify this code in sync.
    14370          */
    14371         struct bpf_insn insn_buf[] = {
    14372                 /* Return error and jump to the end of the patch if
    14373                  * expected number of iterations is too big.
    14374                  */
    14375                 BPF_JMP_IMM(BPF_JLE, BPF_REG_1, BPF_MAX_LOOPS, 2),
    14376                 BPF_MOV32_IMM(BPF_REG_0, -E2BIG),
    14377                 BPF_JMP_IMM(BPF_JA, 0, 0, 16),
    14378                 /* spill R6, R7, R8 to use these as loop vars */
    14379                 BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_6, r6_offset),
    14380                 BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_7, r7_offset),
    14381                 BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_8, r8_offset),
    14382                 /* initialize loop vars */
    14383                 BPF_MOV64_REG(reg_loop_max, BPF_REG_1),
    14384                 BPF_MOV32_IMM(reg_loop_cnt, 0),
    14385                 BPF_MOV64_REG(reg_loop_ctx, BPF_REG_3),
    14386                 /* loop header,
    14387                  * if reg_loop_cnt >= reg_loop_max skip the loop body
    14388                  */
    14389                 BPF_JMP_REG(BPF_JGE, reg_loop_cnt, reg_loop_max, 5),
    14390                 /* callback call,
    14391                  * correct callback offset would be set after patching
    14392                  */
    14393                 BPF_MOV64_REG(BPF_REG_1, reg_loop_cnt),
    14394                 BPF_MOV64_REG(BPF_REG_2, reg_loop_ctx),
    14395                 BPF_CALL_REL(0),
    14396                 /* increment loop counter */
    14397                 BPF_ALU64_IMM(BPF_ADD, reg_loop_cnt, 1),
    14398                 /* jump to loop header if callback returned 0 */
    14399                 BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, -6),
    14400                 /* return value of bpf_loop,
    14401                  * set R0 to the number of iterations
    14402                  */
    14403                 BPF_MOV64_REG(BPF_REG_0, reg_loop_cnt),
    14404                 /* restore original values of R6, R7, R8 */
    14405                 BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_10, r6_offset),
    14406                 BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_10, r7_offset),
    14407                 BPF_LDX_MEM(BPF_DW, BPF_REG_8, BPF_REG_10, r8_offset),
    14408         };
    14409 
    14410         *cnt = ARRAY_SIZE(insn_buf);
    14411         new_prog = bpf_patch_insn_data(env, position, insn_buf, *cnt);

The bpf_patch_insn_data() function sometimes frees the old "env->prog"
and returns "new_prog".

    14412         if (!new_prog)
    14413                 return new_prog;
    14414 
    14415         /* callback start is known only after patching */
    14416         callback_start = env->subprog_info[callback_subprogno].start;
    14417         /* Note: insn_buf[12] is an offset of BPF_CALL_REL instruction */
    14418         call_insn_offset = position + 12;
    14419         callback_offset = callback_start - call_insn_offset - 1;
--> 14420         env->prog->insnsi[call_insn_offset].imm = callback_offset;

Presumably somewhere there is a "env->prog = new_prog;" but I couldn't
spot it in bpf_patch_insn_data().  But it feels like it would be more
readable to say:

	new_prog->insnsi[call_insn_offset].imm = callback_offset;


    14421 
    14422         return new_prog;
    14423 }

regards,
dan carpenter
