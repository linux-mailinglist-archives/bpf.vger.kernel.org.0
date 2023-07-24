Return-Path: <bpf+bounces-5693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAC775E5F4
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 03:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E85F31C209A6
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 01:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAF0811;
	Mon, 24 Jul 2023 01:04:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5347E8
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 01:04:53 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA9F186
	for <bpf@vger.kernel.org>; Sun, 23 Jul 2023 18:04:49 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36NNwJ9X019423;
	Mon, 24 Jul 2023 01:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=1aIQQ/4cbC8J3EUzaiA1u3643wy30UJCGMw5wMFSZ74=;
 b=2xp+hTvH8zBW/I2hjVYD9UpAHhUl7Z/hqlMaj/eidW9KXpYYnLNUKPd6p1HSsLu5davm
 FQSCDjer6c37mYOlFDuy8gSj+d1e8d3MJ6Y9IUb//5kDs2Vp0mmpT0wq0LPh31mmV325
 iCz17ETLblQ6j4oNAss7BLBwnAG6vszXx9QBMnrxNS27i7747XrsMTa+qPTJc3GJ/hoS
 1+wLHoesTZP95iX/XqEG9AYE2/GOaeAaCZdwxEHDpLzmv88gIPUgz/r1MaSv2NOkwJkQ
 qaZvkUDKOR9bgCADzwUAlE9uQI5X4inbEaCmNrI12Fd5NpdE09E1VZkM1a04/U7BGFbC sQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s07nuhks2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jul 2023 01:04:29 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36O0uCXG029156;
	Mon, 24 Jul 2023 01:04:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j92tkw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jul 2023 01:04:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dutUGJi7qJLWiRH+crqG+sk5Cs4qkqdTZnY4RrE/080kDxwilkRnqzn4siBGjODfOpQJUGhMWvB3cutBpH9ZGuC28X44J5mkJziqa5p5OCVFIKzwAg56h66dLJ7EuTLZNiS0YMOpxRm2JJUALjO6XGltSIoddkGNDV1VEk2xaP4S9tQsoCWYNKjZqYFKM30u5cTI8UU+6NPuKZkX3z2QrNuJAto6oZRqdxrHrADWPR7JPyVg6NofoYIRFJxsB7yO7GS5EGrvO7r4hsP73nGK1fqkKQNsJnPD7hSE5HNxDmb/Qk7pJhF9jQ+QlpbmHfZ6rJj/aUZ9h9d0b4GiEW0JJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aIQQ/4cbC8J3EUzaiA1u3643wy30UJCGMw5wMFSZ74=;
 b=RV70ws6gE0fNH1Wtd1v0UZCkJ9bQzuXx0ayPnf3hTfwieYegrhel6z2PZqwP619tuB0UnIuCyJII82036FlSeo0AEeieWiz6jUJZRjJXAX3J21ZD7mgOzbG/TTV0U0+YcdJwkpPABwUllr08ea+vMim7pEnxg9WM2zr+F/C0L2hgtvzmz2wuow2DhMFzf7q29q+l4VpExf09kPygJNRf/8zxfgCU+Q2pRNleGcpSi6PSzNi/58kW/r+UOMkZ4ELSYxsHrDFBj+RZ0r6XXt2MCJ646YDhzd+3wexI2mMKJC4XxSXNAyTxyZ1SOnAAqm74GhXC781FVGzdaJPfL89Y2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aIQQ/4cbC8J3EUzaiA1u3643wy30UJCGMw5wMFSZ74=;
 b=QeeNVjFQzvx1nPHT3617etp5C6j5eGuVSmoV4zF2WsQ9O3oij1pm2G2Ysj8VMp6BnlBEQCTSkWcR98EgnlTN93uXHuP+tOVcMivkAY8j0dSAeoCuqSbrTVWgqfYUE48DvPkeluW8gujdmq9Yb7pNjeiy/qjkYOokPM3dfLMyXz4=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by CH0PR10MB4954.namprd10.prod.outlook.com (2603:10b6:610:ca::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 01:04:26 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::4d0c:9857:9b42:2f6c]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::4d0c:9857:9b42:2f6c%4]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 01:04:25 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Yonghong Song <yhs@meta.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii
 Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song <maskray@google.com>, kernel-team@fb.com,
        cupertino.miranda@oracle.com, david.faust@oracle.com
Subject: Re: [PATCH bpf-next v2 00/15] bpf: Support new insns from cpu v4
In-Reply-To: <87fs5ep3gv.fsf@oracle.com> (Jose E. Marchesi's message of "Mon,
	24 Jul 2023 02:17:52 +0200")
References: <20230713060718.388258-1-yhs@fb.com>
	<8b3e804bc23d44ba3a30b9d69e6590bede857ed3.camel@gmail.com>
	<aa910249-cc7f-680f-144a-b6f6962b277d@meta.com>
	<87351h8gak.fsf@oracle.com> <87fs5ep3gv.fsf@oracle.com>
Date: Mon, 24 Jul 2023 03:04:19 +0200
Message-ID: <875y6ap1bg.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0668.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::14) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|CH0PR10MB4954:EE_
X-MS-Office365-Filtering-Correlation-Id: d9c0a9c8-54a8-4db1-a5d4-08db8be1ec84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	DITur+hv58kphxr+mgsSGfKrJEwyIZboGGdVvj4QdB21cm0FgGJH6RDX3snIFUA9N3rXWekJlDPkb+tECEG267yPAsoXQde1Ae4rvsFDUYB1oj9zONRUTokOb4kmDgKc5EweYprOSEbF/akXKt1UAz958ECLr3nLyjy4mOlPPOwZYmWU8UvdKURksJ8WV7xQ6CU+Z27T/gOxVR55eONtxyF8bZ+/DGB8656LEwvgqRzXKW30qRaYoOa0LOigX0wTFO7T5nphYIN6MgcOoVXVRBDFsm+Kc4mJLDkBrqPUpHkMl4DOIcZCskiRvTdWfRqDjRyk9IZ2yjMibGWS/dkG8TC717G4TCNkPPWQzvI1z1G07Mkvl1xIPcFENVLYLn3NH6dwU8BwK1+PW4lz464CXVQ2TnIg5ebZDci8OVMhdrlkL7UhX8fd+nEoQLXZG8lgaB7yWwDpWZwhDE0nBtkBt3++PHJaHyO6APciVoWmdM0gAjA+QrEiPkYP3Dlv9a1A7DIMS/I/riE7x3ovZsnqxiYXdgl7A/HYn46cyuaY2tkdGv67DwVUTx+8R1sSmXd6LKyiEWErX4zx2BSaeIp6nQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199021)(38100700002)(36756003)(107886003)(2616005)(8936002)(8676002)(5660300002)(478600001)(54906003)(66556008)(66476007)(6916009)(4326008)(316002)(66946007)(41300700001)(26005)(186003)(6506007)(966005)(6486002)(6512007)(6666004)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?D1zEf4HXJvB2JkruCBHltqFoCPd3/8d2Lv3ayZeDvFdZjSrmRwGLqCzX2gbX?=
 =?us-ascii?Q?YovZ4UO8LHu9gh3FIeYOVA78YR1IiFUSVcbcBzFfbFhVfaf+m0wn+gCO7P/H?=
 =?us-ascii?Q?D846bezIpJkQI93CdWOSSa06/aT1noP+oztyAZOcQEUvRlCtH4wR1aiPHVys?=
 =?us-ascii?Q?39p7E0s1o3d7tw4vWZNRbVHtTBjlwKZ/s4/XxNKokFOLwrtQOIol0Re8PXjx?=
 =?us-ascii?Q?BwP2cMPD9I2TXt85b0Tx/Hst0NVOrHn8t0+3dcOLbCxVN6ASrwq3G0OPZEWh?=
 =?us-ascii?Q?nyz3DsP5eNAFbvFX2cIG9pwxPBFbhC55CsWbh04eFM8beIU/DEYcWvK5QzSw?=
 =?us-ascii?Q?BOKq3uiODA0YGtC74F18hMBCrTMW2cZEm9A0tRnwQBMa3Z8kMzGD2Ouj1i0W?=
 =?us-ascii?Q?eEj4unNTJYO3V9HN0EhqceRMfN3J+AsQ3YpQxFRYSMe8vsjg9vBeaggEggmq?=
 =?us-ascii?Q?TWMl3+FeAAbXmMWNLMkqPuAHIG9Vd8maX4IVqSpnxMjpDdQtPd7cN5+gFX8G?=
 =?us-ascii?Q?zsfDf0S6BiZU6Mt8DMVGIosOUd6eXD/019wLPioV2YZxIWsaojfQgJC8F+/F?=
 =?us-ascii?Q?76Mky9TMlhsbp6LfswuHc7BL18khiMF8M9nmGSnkFpWKHXkoHSOcAs6ooAci?=
 =?us-ascii?Q?7BkwBt0ZgbbaNR6PSCm6DRFvGm3KkMiVbWl6PFnevjXFyX8zADrAD9C4a7Hz?=
 =?us-ascii?Q?9tjwG+jTz5oqOWmQTRM5DzfiWJpAh77zqm+69c37Qo/2hF5AgJhaHJ5/M2Ud?=
 =?us-ascii?Q?cCddxIFYUIHpMyGTGfYQlZ6ZistyIAVsm2xtZs/cQQjso1zshd+qYkJVdWaL?=
 =?us-ascii?Q?NNpW46CttCPmtFQ9MpAy1KndKqiYjfPrDJfSEeqls88TvJMJVIX5X4y4dDQL?=
 =?us-ascii?Q?Fvv2hAEyqY1g6SnpBCgX5bPHkuYQiSzZ0x2j8EfkxbOv/YNCRw+WeKxSEOVD?=
 =?us-ascii?Q?gOhB19zS72RJRYwzpXFBH+Uk/zif5IzK7UlOhVRF6f9de867IsdpwhDkSGs9?=
 =?us-ascii?Q?HVrkNHJ+wR86L1+cHaN+SS4Rz/W6mOq06FsCSI2QNBqkKX8AtP2jJU5kxl/W?=
 =?us-ascii?Q?HYhkWQZSEgZ3iVdXsn1GfK86vqIHkQeBqykKTRAxVAPey+Fz1N+YMJgxaXk9?=
 =?us-ascii?Q?D9wtH1PY23BtIVJXU4zOJmV29N77Wnte6dvRwSzWboq/C/WHpiQJ/bwJUhA9?=
 =?us-ascii?Q?t1UKPVA9CNeO+i1ioZwRGZy4dmqhkIjU5AnkDi/yW/78i90t2J+qfPA7QK7n?=
 =?us-ascii?Q?DedN1/fT4J4Qre4VLLdOQGuJXQWv5NZaIqIuN38rwXzDOkFL4bfFvcsXYgKD?=
 =?us-ascii?Q?0FNSCCXq1u0riDhQmZW2GoQVwgfaT7umgQNnRWgMkfUkeS1kbmki4FiDeGFj?=
 =?us-ascii?Q?C7iCtYRFqiX0n8PpjAtvJz8ksJfkFpDmGv+D+SrqKroEv+AN1SLmLmH9tTIE?=
 =?us-ascii?Q?XeXSogmU064JjBqAu7broz5/b5pBV1CFytvuuBx6vbuWTUCfisDd4G4nlIal?=
 =?us-ascii?Q?/R6ek/vMGvwlPOvj8rpr2W5C60Lac8I0T5vNJ6tvvbV6SdAH86ZvUlOb/460?=
 =?us-ascii?Q?Bd4iOzTa4H8QWFVHuPS5GkQVXxifYGCHW+phDmODqRIt95UmxBPWHkNVFjmM?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1xsNv/u1NZEbSPnK/hn78ROqjOLKhop40qEKRRowDAvsae4UZpTiCS6UP3GSXJf+vkyuNvPdT6Jfyhv77po+/vHfDW7QCJBQZA52VHZr/p07vCNdCqZnsiiEErcYWAHJ88Nsmgp0G3dnTKrpfdK6dlJKk7uOW3vbDAd4NfzRKPkLCO/8x9QKyHgqJxSfeX0OT1DJG/f8bR3VJXuP0qRZEDcIQjlR6IAb/7LanUPvDsK8IOm3MGyN2ESLACiOm55mAFFt31NdBG1M2kBMAtB2KvMdlnQZvoO68lhXjQbn2+EJowLTdjyON7koxN+03JipR/t5CwEcC/XpogybUKSmnHCohniSuLl9Ib9NX9M2kOO8U49RTssZxFE84hQIk33S+1nDrhmPcz2T62x+SZvmjj/U8ZMo1BERzBTrhJ4Rwwx2ufggD78vMp14uPuZAvMwoPYBeJ5m7+bUTfLIVS6tIfs7jd/0OxPhnk0VVn67yTfCX0DFiLod0QFbfpj/m/n+fW81M37NFteLbFCoNhbrLCRlirs8xgu1leozEdpOFO0AJXet34UK2E7bsSbrbzHIUGv23Wf8WSy8gwFf2RBd7+hB6EXW1IyAfqN2xn98Bh8nDdTiFFNjpQYG6WGGNDxPf8ajN8+Lp4mzdtEDj/X9r9M7qEJGwe7EVqLuBa30dtvKz8VJHVb/FfZBkEOmpM4X50SFcFe0vP3KUFIXrJhYQw5iIkZcDs2qKf0KScZygZt5xc9RsI2qL62hpBkpSbmWJF18tbzh9xZC2RuTW2rbfOomKBzI4eCmzzEuu28VflNIUtAoE4CvD6CDFz76T86hn/4OAtvh6tlRKC2bHHHjcUCULMXKZR+OMlL6R+PuQDhnpmDIsCyht9Jp9oAe6noT3SY2LnPC4td3gef7/aK1d/zL2WCU4JOEtbAaZpnzgJU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c0a9c8-54a8-4db1-a5d4-08db8be1ec84
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 01:04:25.7704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S1Mt4azCuHBsAW55wA34hnfcEkJ3iyCzJurZRdHV+r3A4k8BuQ0wsqalUSJcATF5pk2jWuGwTWINUxHuEaTlqjzq4cER5sE50vc6WmrVszc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4954
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-23_12,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=503 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307240008
X-Proofpoint-ORIG-GUID: 6qB1lMK0WJ95oB5DFTeGDS2YjXRft8jJ
X-Proofpoint-GUID: 6qB1lMK0WJ95oB5DFTeGDS2YjXRft8jJ
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


>> Hi Yonghong.
>>
>>>>>>    . sign extended load
>>>>>>    . sign extended mov
>>>>>>    . bswap
>>>>>>    . signed div/mod
>>>>>>    . ja with 32-bit offset
>>
>> I am adding the V4 BPF instructions to binutils.  Where is the precise
>> "pseudo-c" syntax used by the new instructions documented?
>
> I looked at the tests in https://reviews.llvm.org/D144829 and:
>
>> For ALU sdiv/smod we are using:
>>
>>    rd s/= rs
>>    rd s%= rs
>
> Looks like I chose wisely, just by chance 8-)
>
>> For ALU movs instruction I just made up:
>>
>>    rd s= (i8) rs
>>    rd s= (i16) rs
>>    rd s= (i32) rs
>
> Just changed that in binutils [1] to
>
>   rd = (s8) rs
>   rd = (s16) rs
>   rd = (s32) rs
>
>> For ALU32 movs I just made up:
>>
>>    wd s= (i8) ws
>>    wd s= (i16) ws
>>    wd s= (i32) ws
>
> Just changed that in binutils [1] to
>
>   wd = (s8) ws
>   wd = (s16) ws
>   wd = (s32) ws
>
> [1] https://sourceware.org/pipermail/binutils/2023-July/128544.html

And finally for byte swap instructions:

    rd = bswap16 rd
    rd = bswap32 rd
    rd = bswap64 rd

https://sourceware.org/pipermail/binutils/2023-July/128546.html

So, at this point we should have support for all the new BPF V4
instructions in the binutils opcodes, assembler and disassembler.

We are working now in getting GCC making good use of them.
Salud!

