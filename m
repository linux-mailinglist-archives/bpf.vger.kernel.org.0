Return-Path: <bpf+bounces-5849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42809762026
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 19:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72A261C20F27
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 17:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9794B2590F;
	Tue, 25 Jul 2023 17:29:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A3F1F932
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 17:29:52 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EF41A8
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 10:29:50 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PFs8Gr028291;
	Tue, 25 Jul 2023 17:29:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2023-03-30; bh=VAM1IdbS63GzrvARrGC4DqA83sbmjkN+5+MpeFfZa5k=;
 b=LKdMlhLXxxZNuVkAXLyuPQsghajkn+9S1+DCZCOH/11UvcJkHkLahcuUfLMrQc+m7AcO
 D5omGw+RmBAiP6A4ulQUpTTDlkZG0v3OugTjvq9oITvB46HPc9X1wOnyPJfoDJ9uapbN
 seWddtMAqGmUhA9bEMYUo8wimXEwDsSzCgu7zD09CpbPqeqQhU4s/ClD8/Di460aQzEj
 UwkoCWQcq0EoXKXD8xtVotyubWrh+osdecTESxzCBcVNIT85aTmXxmSixj1OmE034C+S
 bP03nGQerNM0wKFAVkcdeuJDRnG4AAm2ax1kYF5dEVsFIJSZheJdulTe0BBpb78/Edk0 Tg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05hdwmwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jul 2023 17:29:48 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36PGHG03033413;
	Tue, 25 Jul 2023 17:29:48 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05jbcaq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jul 2023 17:29:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLTm7N5yqddGtjfV3ukbEKkdQal6QcVhSxDr4BbUN8lDQcTQyQZZrySjmohyv2eUBKxxlfy0vkPv+zUiwxh8u+AQE9k6xerWsiIOSHdFt5Ib7+dSdhT7gVq8Q2Ob4Za+HFNEJ7Ey24HWFztl6FXfQJIHIl2uHpmFfVWzrX1qOVMI6S43qWNkWA5uZtAGN3fA6usVmZxUFU68RyZjX7XqoymXsGQUe1jsAH2NCihdUXCRB5oV5UGsXgv+JWStjiTAQM4YG/+rssj6D4NGiYmke8SI/A161b4wKz33lGYnzwdVSnekZtCzK1XIl8IbRCwC7g3riybzSJI4uhc21dFtAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAM1IdbS63GzrvARrGC4DqA83sbmjkN+5+MpeFfZa5k=;
 b=dIbvf+sgNl2wjDPndbroxAAmcbAlBLKWWxEdc/mJVDEEeqgxd56XNmIHrOATdICQG8fBqFRo3ztUvHV2pAfL1Bsd0iGuUMgDF99fsJPzJ4CInpNmnhG/4Dy9lpTF/h7LepAKrMQ23zWJTAZu5EQjcR0+F/V7FPMNcJp8lvQ/Nzwwn307uRul22EtqGlqw16qDRcj+tBQW24jpyHHjH6c8GEq7N7eaiU9KWtAVBNq5ESpAT/MLtaMXel4JDgfluI8nxvqPDVqBMFdiYyL7JfiA6iw2C1x3IFCVIiPCSHYVE+MVIBM5r3Hk7ftBI0dvfyFahCLNfuL0Sc0jsAPs78n1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAM1IdbS63GzrvARrGC4DqA83sbmjkN+5+MpeFfZa5k=;
 b=nkadk062HTPd2ln2MyQQgnaiLK10GyeRtrXwer46fBnDJjtqf6VtHYM5ocHQ5ZgfbFpx2oeOM5bSbTdaAWZaAmRGfXIYBzXkFPGn9GhLhNeyPbMwps6gV3BfL/Qr/HhaZTubiV8aKqkHMTntYfVuHLKyevfcNEPYH4gFN8yJxws=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by SJ0PR10MB5743.namprd10.prod.outlook.com (2603:10b6:a03:3ee::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 17:29:45 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::d5ed:aedb:b99f:6f19]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::d5ed:aedb:b99f:6f19%3]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 17:29:45 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Yonghong Song <yhs@meta.com>
Cc: bpf@vger.kernel.org
Subject: Register encoding in assembly for load/store instructions
Date: Tue, 25 Jul 2023 19:29:34 +0200
Message-ID: <87ila7dhmp.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0045.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::17) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|SJ0PR10MB5743:EE_
X-MS-Office365-Filtering-Correlation-Id: 22d348c0-7773-4cb3-2c95-08db8d34bd06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	I3CDdHOdVYfqwuITusQWow8twpGhJx7vr2x5SnUsBafKyofibJAnn2kETj3XmeAx0EFJUgvJU2RF6g1J8i8hPhCKgH+K5g2xnvg04UbFABX2Z8pJAx83HSQgjlBXWPuYNg7Ska8EPvyP2WcQt5PIFxMSQlvZDsIf7kk+pizSJMwxlIMw/mzsLdT21KPaUH9foTeniKwUBy2Ka+36NBOoQTGbOVRelj+NZYJADrKtI+IHPadQMcbpiYPDKKgfDt1M1TwAYVcQRWmmiMxoX3IxS3sTp/sEBLmA863HaLG0ZrUrtEB7ha94QecRa2iC5wjj2twpmObZG5pPmM9Vf2wN/Dmc8Jgp3bcRBidSLAuuW6FqgnUzDkoal7lYP3Y7/k53Z83KhzfPWp3CYsB/ENQED5zI8I9wJDLbtBhQRcDV6qRQ4PyhggucY8I4XE/dtrtJ29lqW9/9a8bQcUCuhVN1guqVfqxVDFCrwzSA6IQrlKFuPBND2XI87HHct2L+5iUBqiJuQU+O8PZjIAdkoDuhzH6E82J/f/xI5T+F9J4n5TciTcySijpV1I/vdxWLe9f1
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199021)(36756003)(86362001)(2906002)(478600001)(38100700002)(26005)(186003)(2616005)(6506007)(41300700001)(5660300002)(6666004)(6512007)(6486002)(8676002)(66556008)(66946007)(83380400001)(4326008)(6916009)(316002)(8936002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8SJiDEsWS5aGMs/dpmVZ0XPCKBo4FoVZZbNLkr8El1mZIpLrJN2nk/syl4e+?=
 =?us-ascii?Q?QyPDWdI7hUPH84ahTHnU1kXpF48nTUsNdIL6MCyAtRFB2l+FzEUk5/o75Mvw?=
 =?us-ascii?Q?ynOttMQNhpNnIKBfkP0VSTrdGgvfkldtSoVyl6wEw6P2dlo0jlUCvBlxnbPe?=
 =?us-ascii?Q?dXLMi2O8QYtio8T3jKXIAmoec5XNKFqb+IMu2p+nwniCGJr3jsUnt2WpoKQM?=
 =?us-ascii?Q?kPgoF0ZB49xy3PEEId1jCqMW3IS8W0Qr9mo61keNAFOCN8pkmtMo4kSLVmQI?=
 =?us-ascii?Q?mib4JmVoxAhJ1ZGWAAr4ej22gq6l/YUIgbKHO1i7EcqIEV7C/g+2dd6c72zP?=
 =?us-ascii?Q?M843nW6XC2omPrcENP8QDMAB9zjgMSOdpoKSsAa6VohKfoOeuJxAn4KqTdxE?=
 =?us-ascii?Q?LAESopZ0VTwE+OgseNnJFAGkCniv5g3m7zHKNGF2NriOXzMIE4LXQKQnu+p+?=
 =?us-ascii?Q?YAo04YRXlp36J59JuiyWBvtaOfHCYCF2lz+oJaXVezIyH1b8pZrCyxYWDdDZ?=
 =?us-ascii?Q?vgJZH4o8tOf3btQck6zKKtlSHMh/G0z1snL3pMqc1kEgtrUucVEbuv7Xj+2i?=
 =?us-ascii?Q?jN2cJ1BFHBY2N5sRifzH8e5twazgG66HWWK8dAFD8AHpgLji2OEyB2Kv3aO5?=
 =?us-ascii?Q?pJgl1KXokAXxuM51Nxj5IuqwN4sS/zyWrIgnLa1qTPDENOlrfd8I5IhhnKfl?=
 =?us-ascii?Q?b8L+jN1jtpEV9woMnh/jMOJJftBagcrBoOyxbN0wSz6WkAr3CNL2r2HevAmK?=
 =?us-ascii?Q?sdwp6oE4Eg030v1vgbwfv0/RfgBhdqjRbr7a3pNF6EfnHWs8b09U1CaFogkT?=
 =?us-ascii?Q?Ony53ZFZWUAY8Ipnn6WC/hZXtBV7eyNxMjjNS+BdAx8S70CGItUtYkxWOHHo?=
 =?us-ascii?Q?s6/vdfYloXsXH3HkpeqqzfLGH47Ic9h353SZSPr0tbC1b/DKLSnmSmrwNU6x?=
 =?us-ascii?Q?T1VUiRvH40asLGwSCpFGQU2LQ/8Qu8vqig7Hyu6QV8IZQncgRtQDJ6zli8yv?=
 =?us-ascii?Q?4+nmwqd50jBthxbGGa37XZY5xphZzAxB5jtKIZ6ETWHoRTm9/6+xwGhwe/D5?=
 =?us-ascii?Q?9tCY2U23mmzrUrxNsY3tKbHVI8ZYSOLD/jNGNeCK1lEBAtO8xnLYIpdbErxP?=
 =?us-ascii?Q?/k9S4PZeegsa6sn/fhSqHF1dPhSytKIOmzGhSLE4G1vf8lK2TRECWrWvBq1O?=
 =?us-ascii?Q?thp89vbBhqHrc0VjtGmN/jWXBJl9B/2H/OUAHtaQZSV4MsWtC2BhVq9sUvBX?=
 =?us-ascii?Q?Fqidi3etp3auSJMn3C0vf5kXjhB3z0lPWQBOxfNfzxfXdsapRyunbkE1hcEp?=
 =?us-ascii?Q?Cw4mmbgnz/Re/K4PgLI3JBdLz7iHV+7HvrRIwWzdO74ONyux+twEurqSfSxt?=
 =?us-ascii?Q?8c4TgZxnPj33+y9WaGqI0rhwu76B+Qhbdv6HCyWnpG5UHOSdfXE/rQv3cl6I?=
 =?us-ascii?Q?Awn9tSqvfy6jRYYvK4oI64lkD9lT39fyCDU+y86vRD0Vy/1+rxUFxEJfXm2x?=
 =?us-ascii?Q?UDgfpvFVnvXHbBwZz+lS5QHJB+ZFJzQeLU5ObLQGINtJj2GDLZ3XhptDutJH?=
 =?us-ascii?Q?GoXAJy1ms1kWlfpmCbILAZRnCNUo/QZAyKqXjabftodgRr4qZTvYuolFIU09?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XHcVbJYZGuIqzx2tq2aKwPeC8ZRtnG+RLtNjFv6RMKkrlNLNXbP0duniESyd1pD70J+Ccu9V30v8JLb77qyKMyuXNzRPhgc6fvtnB9qrkPean1fonJSAH/1Nfmbc84vewXFnP/vsJW5UrQk33ulcz0u/FxzXWPMbnxU/2G7DmFOaNCUgs1eGdgk0sZ++MDvZ8J5nUzI+2RnXJjtHxiIxAKpBZISGhworjeUIl9DGW1ux1uZxLUh3mP+7+4bdhVFz78CKYK9xcKBKgP34lZyg+FNJhNUyEQVdTuc5OhjqWzWa2FwYiF5y5vl5+swQbg2cCaraL7oBDLKqH0bzD5QiMrWdDr6S5HCWbIMpGOhu20nVRYAu0VJniaTUfQuwtpOPVkGKJ0vXocGZsakfFh5dN1x9/rhvfXjvY/vQfAvy3qURLX8lyTf3M/b+YOFidwwkK4j+WhT2zxj74geWfzdj9NjgOmBZ3mX6bAglRHv1ptqQnj5kMhykate9LwLqAzaYiFgB2V77buMkGZHUo8jVEB4gw9aKKbUVuiPGG4wbSp70VtKBUnAZav/p17gb/UXDffVMG36nCpryfqAqTm8Sh72gU7W0tP8A5sV0tlmlSVwzmN/4RitJ+LI/dnKVP8nho3MtIN95uHqEpEAFvnyalu/B2U9iCT1SNnr1+1/zwzgOTpJYsc3N5n85KsR39Drby2VhN1NZcKojAbsQMOm1WA1Ssup/dcskQQk0Xbhliauant5TqP6i+Sh5LmCl2lbotfnf9vP/Hx3w8If1TfNbc5oWvBqlKOrw45M4wsEghbI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d348c0-7773-4cb3-2c95-08db8d34bd06
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 17:29:45.4759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wz/b1Y0j5r4cW7Lm5l1B7u7X3nR7Ps177Kjbc1s3bPqZOQQFWB0CLomEGj0O0b8VqxuELEHe4n8AYBNRQ6tMKr5vStsCO3Xpsvrd1/GA7TI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5743
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_09,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=683 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307250153
X-Proofpoint-ORIG-GUID: fEKpovHyiYcP7WgbnOs-WK4KzdgBEOtR
X-Proofpoint-GUID: fEKpovHyiYcP7WgbnOs-WK4KzdgBEOtR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Hello Yonghong.

We have noticed that the llvm disassembler uses different notations for
registers in load and store instructions, depending somehow on the width
of the data being loaded or stored.

For example, this is an excerpt from the assembler-disassembler.s test
file in llvm:

  // Note: For the group below w1 is used as a destination for sizes u8, u16, u32.
  //       This is disassembler quirk, but is technically not wrong, as there are
  //       no different encodings for 'r1 = load' vs 'w1 = load'.
  //
  // CHECK: 71 21 2a 00 00 00 00 00	w1 = *(u8 *)(r2 + 0x2a)
  // CHECK: 69 21 2a 00 00 00 00 00	w1 = *(u16 *)(r2 + 0x2a)
  // CHECK: 61 21 2a 00 00 00 00 00	w1 = *(u32 *)(r2 + 0x2a)
  // CHECK: 79 21 2a 00 00 00 00 00	r1 = *(u64 *)(r2 + 0x2a)
  r1 = *(u8*)(r2 + 42)
  r1 = *(u16*)(r2 + 42)
  r1 = *(u32*)(r2 + 42)
  r1 = *(u64*)(r2 + 42)

The comment there clarifies that the usage of wN instead of rN in the
u8, u16 and u32 cases is a "disassembler quirk".

Anyway, the problem is that it seems that `clang -S' actually emits
these forms with wN.

Is that intended?

