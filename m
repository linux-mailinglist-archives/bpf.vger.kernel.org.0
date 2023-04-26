Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEA06EF984
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 19:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbjDZRif (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 13:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbjDZRib (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 13:38:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F568107
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 10:38:30 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QGx2qv004930;
        Wed, 26 Apr 2023 17:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2023-03-30; bh=zifXNAdtR1XAWiyNau0WO0EqnN5Pxn6KpcFM00WNaJo=;
 b=ImFGITncSUurJ8RFYYafPoD28Y6M06zKnurEkgeiVbxeMNBUxHRIulGokn3M4JocNBXF
 XARKXljy3X2lz5+WaZ1qARNlYOqQ0qMFksPPLhsZd1W7W8vg7ePzL+zaYjMEd+2OCwGl
 2OWWGbAeSEE3oIY1hkXUaaoucpUS97FvunNS3GBrfWZMthcOqsxK+PvYKfkX1YTsR/7Z
 Utyqs7M2RzyIv9d+5OMe//HFykB3vvGomHS/LH6l7QQwKc0+fV5Oa8QErRMS5UYFFS0w
 OjpN4GDqCpz52zk50s5ntjrInm1nwGQx3ECyLD1sC4zhNSDRhYUMWbFgLwYIBpPyI8h6 HA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46gbt4tp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Apr 2023 17:38:29 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33QGVcxu012772;
        Wed, 26 Apr 2023 17:38:27 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q461813n5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Apr 2023 17:38:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cq2ZwHXZyixLaXyC9weKvbvoWGFkzq8CCfLVRAZ1XmBT+9IpRcJK0Ms8BTiNTK8EJ/mkZSZ91SR/Ngy/eT38W9JiUJnRC7HGolLDej8LolXJjgMLBs1q1eIoJmZiZyPE7QZnTD4x2s5N7M0WazHbCoIA+rob3/1LM7t96BQcTv9GAxQGvpOMl95U+aqtf3VPPNIJUjHP7Rp51+VSc8poQMydxqGodyjzLHk0kjJ/B3BOkPr+8zy6kpFbXVfldG0CiP7pJsJpvg07fevAqvflknKlMlUmRpSLrwwTAFDrpiFdRtj6D7RUjsD/SwD2wNzNnrSWpankEYQoCKsfxieWvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zifXNAdtR1XAWiyNau0WO0EqnN5Pxn6KpcFM00WNaJo=;
 b=Cj2JCjSLemEHVjGalYroxilNPH4T2JkPJaJQispuXzwF5V14Ik4zTnWTBRnFChOBVA/tzfUoO9+iN82KDbTgPOJ+yr5MmQgLTd4/F6K+KFFfLH4/tLSXHpOplsmYGpB2WhdvWdNyImIwV8P6xemdi+DZB+9G6pFVKbJeA2kik0En9AbpbcOerC2O3T8xqqfvv+SMQmnYXB70bTH2da5Xjoiw7u6l+qZgzkeESR0dC4i+HBziJ92v6dQtDfWf3iFfQUYwgHwf0PKBo5MRlfz9Yk5s+W+8kNk5OP5ID0Uw7F2R5hZcAMmGj8Z2i/mg+5c2MEOcFN2VZCaH7h3vvWK98A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zifXNAdtR1XAWiyNau0WO0EqnN5Pxn6KpcFM00WNaJo=;
 b=OBa+byEEtIQolNSN1IQwd5AS7MfBq8NXPpe4Srcan1ES+7j2yokSrlEY31Qd7JQcA6ECaFGPDDK2V/yJ8KE6MOw5CxT7Th/3P48KvXQZnF+/7XcQ+KPacSWV508zb9hR50NqmNHwddtYA91R3A339vD7umHevhTX7dTKlhQXya8=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by DM8PR10MB5398.namprd10.prod.outlook.com (2603:10b6:8:38::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.21; Wed, 26 Apr 2023 17:38:06 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::53da:d3b:d2e4:d40]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::53da:d3b:d2e4:d40%6]) with mapi id 15.20.6319.033; Wed, 26 Apr 2023
 17:38:06 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     bpf@vger.kernel.org
Cc:     James Hilliard <james.hilliard1@gmail.com>, gmartinezq07@gmail.com
Subject: Support for the pseudo-C BPF assembler syntax in GAS
Date:   Wed, 26 Apr 2023 19:37:59 +0200
Message-ID: <878reeilxk.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0050.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::19) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|DM8PR10MB5398:EE_
X-MS-Office365-Filtering-Correlation-Id: 25479068-ae9f-4e73-d643-08db467cfe68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OKtqBJZz6u5UConAueLnsyhMS3/zkn0L0oh8HZvsoL7VtpyNNDeBszJzxiq7/czPnuWGopP5Fq9a2UqBZaIfOxrXl2vL46hKAcAdM6T5+5WpuovYL/vjBaRosB2/HAbxy0hUtHoVgbAvy3N1KRoJgGO87EUi/WrmbT0Cl59NNYUqnRgdHS6390293+h3gW6xR1nqqono+oR+QXUPEmTaJe7U1g+6rcLXnnMCNx8j4UBR3cqz5uj0aWJojkNe6QM5bkhpSDCztFt4GMCC8FxQZzb4BgheoxCAhr7nXFS1IoP5l13uZQD/tH8PSr6SOgTQc4NqLq/0lcNcyfwDJcDmFkfMBcieWQEJw8eCE4wuJ5uEL1oaOorMs9QOUKClDMEqGK5Fgj41pEhBclgIHjanDydp+xHa2iRcuEg3L2QgaCr/dVPrWjKE6DOFQgnj1F90gmTO8Y9ZqWyXvYJA2AwUPLMUdAj+OB1vyA7p38phW4wG9mdd4osneGlyYSbJ8a/KqojEpDzPv3HhN6RQvnvXKj8eXfEODlRVtrNoaHxeRZoGaAqvNcLES2DgoVRcWvDAXUm0zrvTo6M3vxuk4JcyxOL9tJqAQ2QV/7XcHERt+CE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(136003)(366004)(39860400002)(396003)(451199021)(66946007)(66556008)(66476007)(316002)(6916009)(4326008)(5660300002)(41300700001)(8936002)(8676002)(2906002)(186003)(38100700002)(86362001)(966005)(26005)(6512007)(6506007)(558084003)(36756003)(2616005)(478600001)(6486002)(6666004)(533714005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bDJL4E1x52iBKiA/5TqOPc2KLau+ACt4+T6lsFWhxJVaMnAVuUvQu/3OC581?=
 =?us-ascii?Q?J9fETKPcuTi1BNP6n3qdx7KmxjmBbK12v5G2xYN68GtnjK3j4pbs/82V9uOI?=
 =?us-ascii?Q?sDQ8KWV7Im9PSCM43LdnselK6D1hzTRuHbcmdkuvKq+MG8ni9uUEvniIRjkd?=
 =?us-ascii?Q?nyE8zP4vq+gFYWQLAF+ncPQmylMdv8S3yYC15KckKamPsApkYUkTSBVyrzzR?=
 =?us-ascii?Q?dDIELvDNPIusYg2k/yLIQpixrby4QHJmoRZNkCkTVUUJvskHu36HobHD8nTz?=
 =?us-ascii?Q?7m4h2JlSMa8bxg1yS+YQ/tNyxYifloqofTERbFG4Pbpm5YAnic0N0NEmBuuF?=
 =?us-ascii?Q?Ps3IMHaAojfCAN4RUTiEsGXmvt4cFnYhWjkmBBF6SbyT8oCjZ4uq9t8scJE/?=
 =?us-ascii?Q?/+LsRRTFgYHzEo60wOousP38iakk+RiU4jOdZGzxoxA6XQsIO/ccYH6NltTo?=
 =?us-ascii?Q?TuPw/mxrfbZbU5CfvaqQ7rYr15fMLdOINBFeP88KcQPWMdhKre0lgG4c6om+?=
 =?us-ascii?Q?jC+wUfKIyZv4DGwGPpoXHvqI0hdoFW/7OwWcd3TzanVQMO47CCWAslT6lftM?=
 =?us-ascii?Q?7S66OOfU6D3BMBTVyu46LvH+ZstCxaKRYqgZUaU4ykx7RbufGYqwTm8/3Pb1?=
 =?us-ascii?Q?k9MafckFbW7wvsPA1SUY11HUSuhbt54WgsQBgAx8NqfestKg7b8Ct4OCIPIa?=
 =?us-ascii?Q?3UYV3FpQoI8HlyTi7VqbaIlV+ZGstNTXeSKCLkcCefFHJDMLhamLnP33yooU?=
 =?us-ascii?Q?IuGwM7YNfDk+0MZZ6EBRpWYHEGECyz9/aBHfzYC0nQoQeqbILHj+3qL4sTTx?=
 =?us-ascii?Q?NFvRstlw8gEdx1gEg8NAnXQX6uVGJ5nyfIuR5r+e5AWmSK5DlSkJePJUTZ5m?=
 =?us-ascii?Q?B1bIZSBDeTkgG+g8KV8Gyph9yzMj0ud3AeysJXPwvwtn4FlDYWucCfvqtLPt?=
 =?us-ascii?Q?qk8dXPT/LGsdw7kIs2z2cc0amSr82OTMBTW4uOdcwicDKWeFQ1fxhOdtSPLV?=
 =?us-ascii?Q?fkcADX0OfX+gVUAhEqoyyaEtivfg0zzS8Rf9FNGiiLzuw6HDV9bBcAXxaFAa?=
 =?us-ascii?Q?sSPA8GJw9QR9VhdGlMkHqVoam5AHw6pbDLAUbaMs/R4Iq7+MsqOAk53zUjrI?=
 =?us-ascii?Q?Mx11gPdzETLLA81Em3kM1ysGQmMq5oyUMpfNzooWDraRtDm5+FP6atm8mWuI?=
 =?us-ascii?Q?Inog0Nw80FatzGrvMTbshWss14HWrzLdho1UPnYVogk71tNo9v2rbkAByJ1J?=
 =?us-ascii?Q?y31Pz157uBQdy4F0D91k1fC/a547CcmVv2SyUxwAT+e46H9BFm/Lt7zGRadH?=
 =?us-ascii?Q?h5hWGzYWks3T84tE5u1Qw9oV5TYsj9NBEUtFHBBg3BP7wCnKjKBOkA+FeksU?=
 =?us-ascii?Q?ul9CqCyr5cDXmdq11FzxDJ4OlPu9dNR9rFBS5ePZ52bMbZ0s6DauZmaAITX9?=
 =?us-ascii?Q?8SwVhMuhBZ62dOLT+LDvb8pdEQ/k+J/LNrPRHdT7ho6J/gngNb4DMIE48Mpf?=
 =?us-ascii?Q?+ALxlWIrkJI2beD5EoIWM9PeDwk4mPbwuMjQT3d9FbwrsLz6RrPfkFWmUS2R?=
 =?us-ascii?Q?dKbXVsSBrKrARr5oIl7tkaGMYc5cddHVot9FsszmG71OiOzWSnu/CsgIN1/w?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1mbBXfn4+cPEKyk2utqF44oajr5hErvvTlFA+51zQtueIsZNLcewWcy/jR2csOFELL8lI3ugIvuL1oF0TmOo3pANRMFXLDvDTur6yp6cUOtQbgDQ4zwixIoen2r0ItkUvQ7Zmc5b8BACs1DTwZp1Y7g4fEAkDbEGBo6fSOkXAbIv0eMxXAaPMETuFlXfIatmWW6cMQ8UbZRcrQ+LNyi2Ej6NfKHFiOSBG5ukuLk6TnpLrHlc1PfkwpP5uSPhcYcZvgrTYhDDjPkskv6Fsjq2JzRwtAaN7zdE5Q3Km0ynR9KCDbYFlp14acPtSLB0jl4YR6lJb1gyg3KmLhO6kYnkYd0lzr4+3GFcqag3eEwr94HQICmF4ilzYifcNozUxBKQLQU+tWb11oGHZfLE8ypynmumJD1sFTD26kYdaTAy2hOBK89xefP2G8unoKG2dI4FdFKbD1vEWPW1I5gFWWvQtVv0P/Qjtv12nseqn1iq8Q9I4FB+jVhzXk5fjbJMrwI4HUDthv2wjjK6ymmeDdQO7yUod84Q/QxY7Y0WsL7cus+Pf1wjNLPSbZrC1ZNeD5Eai5tXmsvE5UvPhlw0BazxKorgzc1q/HQzDsIGlcrw7ZFgHVpBSo8OOkJVvKDldq8uo8mOyk4siISvGCTkhK746sphDMCjiknaMhUiKA5iiI8eOkZHnerlaPcMlR+vOq6kKs2SJ+YoqUdvuGlgp54+D3roxtFBh0QMc5n0t1+a7YrjCHRJ4taczlJFlb1lh+Zo8fmvpo2Rjje8IU8V3sxJA2RJ0wYgEIs0kX9Dr1Vch/o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25479068-ae9f-4e73-d643-08db467cfe68
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 17:38:06.2159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKQTEQJkJAGIJUE9Gnmyjf54xxVH6r92/7S4/WmG7oQg7fNK/UL+/A3J3u1Dn45UTZHx9nmFNSgpPLHUnDK0Q1npvRU8hE7/OmlarIPk45k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5398
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_09,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 mlxlogscore=689 spamscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304260156
X-Proofpoint-GUID: TjK0eRjcskg-o2GEcfMn00dlpkenaQmn
X-Proofpoint-ORIG-GUID: TjK0eRjcskg-o2GEcfMn00dlpkenaQmn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Just a heads up, we just committed support for the assembly syntax used
by clang to the GNU assembler [1].

Salud!

[1] https://sourceware.org/pipermail/binutils/2023-April/127222.html
