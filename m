Return-Path: <bpf+bounces-7599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AA2779611
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 19:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C06A1282424
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 17:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B8D219DA;
	Fri, 11 Aug 2023 17:27:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEE21172E
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 17:27:16 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED48230C1
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 10:27:15 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BD0RX9006155;
	Fri, 11 Aug 2023 17:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=6+BTFhRHc8BNE0ZqwyxOH/jPkjf7pS/vBSSFfz1uy4w=;
 b=Z6y6JqCG3fU+iUMQ5b+sqAv76APhQW1pfOTjrFXczcb5Np+WsCyfaV9LfJU3fwZHRjvr
 URcUDFTj8HWVwETASAA1xTOfa3TLpvldLVYZeGoNKmKSwFlLAcEJF/5a5ASQNFp499yP
 cs38+UJGIoXCrTSrLTZWU8skn5H2ADRtgN68z1Sa5jlfEduJmWkuqRVcPCA0JW2Bnn8p
 9Y915uGCLzX1sj2VGngLAhwK5oaj13NrKCitc2qHYR5RIssMKXrdjt/jbKMBSlYweUoL
 UyKnTFRbYiB7E1bip4tNqb9E5Rk/GIbuMjzq6IhGyv9WqTwoC58X0aa6rEk8yUbPlDsQ AQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sd8y49jff-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Aug 2023 17:27:11 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37BGOIe6000452;
	Fri, 11 Aug 2023 17:22:17 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cvgjhbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Aug 2023 17:22:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bS/Gog1XvhDLMj2Ay0luhvwTeLQFWQnZM2sT4PJ/5L9b+QbnwSig7SeBLcTqI8G7FTjMAuW4e7HCrwqiQv7ZsqGmNgD5SdTNglPI/6dDILw1ezPrnOcsWlSd0CHfCwguhU/RmUEklhkM6N0JCW4yMgpvOLsNzRRsD4i7PQ3sp/AwUn5jTP9iXfF+UfYrhDcLIvCAxF98sn+ZIMuDHFS4uGeKKow1sdJN7JZBWNOy+Y0xqe6qUFb/5hpTSfBbB4F1L9loW6z1Msg/sG9t2Exh3r/OpGw5TH+4yIRTq8P+3DTCuguURZiz9oJXCF1wRafgrA7fQgd2RyXEeyzjNsmu2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+BTFhRHc8BNE0ZqwyxOH/jPkjf7pS/vBSSFfz1uy4w=;
 b=Uke4+EupGs0y6QatZY1g9cGuYsgmDliTzMOHJVwXx6oftyO8GFlXpkG/HIQ8EkinIH3q+0oD04j32/tVF62/+IimqXW5qwGAXkwyslv/qP7ZtCFD51LlnToO+Dh8i36bAXHLBCQKqZ9kXh1DsVcuG4BJx8ndpNLv5YTwvxWUXaZb90/C7SJa4uEwO/f8N0Wd978bMsM/BZude6Qh2/jJCoOCiqbrSnl7U70HxsnQK8TgQbEy9SDfwWkvwBaQdgox7c7ij5H9VQHgZBy7zr0fgi4kU4I5TAxttyNc5eo5x+T/vfYPW8KQNIiou7/g6X4n0rL5fQWoTZe7egHGLfgExw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+BTFhRHc8BNE0ZqwyxOH/jPkjf7pS/vBSSFfz1uy4w=;
 b=K2D5xOXbANXwQJBln/NcLIB017rjodfbN7+CENGLyprARGfKsOfAPXeQECVD3x9vErlNguNILljy9sL+t7xJCtBx5gXsAMr5W38m+tahoIhPwA7Pi5XzL6romDLNpV1hln4SaR7FHTI/PE7vFOp01lFh9Fdx9LSv/9EPQlGGoQE=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by CH0PR10MB4987.namprd10.prod.outlook.com (2603:10b6:610:c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.20; Fri, 11 Aug
 2023 17:22:14 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::991c:237e:165e:1af]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::991c:237e:165e:1af%3]) with mapi id 15.20.6652.028; Fri, 11 Aug 2023
 17:22:14 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: yonghong.song@linux.dev, bpf@vger.kernel.org,
        Nick Desaulniers
 <ndesaulniers@google.com>
Subject: Re: Usage of "p" constraint in BPF inline asm
In-Reply-To: <83b2fb306e34a76b07c4625df1ab2d00a183043f.camel@gmail.com>
	(Eduard Zingerman's message of "Fri, 11 Aug 2023 19:12:03 +0300")
References: <87edkbnq14.fsf@oracle.com>
	<a4c550e4-1d65-aace-d9ba-820b89390f54@linux.dev>
	<87a5uyiyp1.fsf@oracle.com>
	<223ef785-8f8a-14bf-58e4-f9ed02b21482@linux.dev>
	<37b9680f074a871041c3dd61d22e6a6c9fd02fb0.camel@gmail.com>
	<87v8dmhfwg.fsf@oracle.com>
	<7ae83d1248b649a8765a3e01e7a526c86b956ef3.camel@gmail.com>
	<87y1ihg53e.fsf@oracle.com>
	<48b24b86e221a9559a13d51df57b72d0da5d0c7f.camel@gmail.com>
	<87sf8pfz5v.fsf@oracle.com>
	<83b2fb306e34a76b07c4625df1ab2d00a183043f.camel@gmail.com>
Date: Fri, 11 Aug 2023 19:22:08 +0200
Message-ID: <87h6p5ebpb.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0003.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::19) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|CH0PR10MB4987:EE_
X-MS-Office365-Filtering-Correlation-Id: d45128b8-c77c-4729-574c-08db9a8f8133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ahKVxNRBMYzFc3AH1bVo+/9rDpMgfkbN9LsWmVF8REwfRZdCqUg/82D8vyBVo7/XPUEd+HectFZD/RRj4BPQQjsfT/2h/ykeQG7xSf5adnNxSZ8JbHXYSkOC098L6amqPrG3hKNPhB3D3O/iLg9vXgCo7clYVuV6oUFtcFc1+s/kq0vn5ddvLKFHkZxEOtNtTbMzDQ8MyaBsPaPLap25yhxRvU0dAQThXSt4oSC5M0yvmPBuQb8AR2wba+lxxUX/8wR3gf0lwWSHDlvoa7za8WrE2br+X8CX/VSXu6PSni+1lT1wQ4MgiVMIdeUB1SIhUJy4/6JXM4qdlo8U+8Bk/yzxc3M1KTJII7SNt8DMoW1+rYvhCd9cX4Lwj2Ez8e3XIcU/rn1FxjZanmqaMM698DdB+OKj7DDfLYNtRTc0dgyTWUonD7u89r98QZ6wJpuua53EQ3+wsdjd0Zhg8Bhrj1a4CPnsBkewyPUHw3Tqo7xSTSUU6aQem19mr9rqn6lqQsFqA24rOxzUdMhyvVuO8KejhgZtQY4VZ/QUBxlJmPGllKUppkX+2pXt1E3igdCpBBsLLz8Z8ite1yIvKxYidg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199021)(186006)(1800799006)(6512007)(966005)(478600001)(6486002)(6666004)(83380400001)(26005)(2616005)(2906002)(66476007)(5660300002)(66556008)(66946007)(4326008)(6916009)(8936002)(19627235002)(6506007)(8676002)(41300700001)(316002)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?aNjZLAnDoaBBeUgOyzPKI81OW2MjdQDb4BmEqttl62YY7iEGFnPwKHHfWvwR?=
 =?us-ascii?Q?1X9glCTQFjmHct54oXajrdecywQcCCSNEpcahFhxGdJ+CWE72XEVT07vsMQO?=
 =?us-ascii?Q?+kw8frEVwPPSFxyOgbYFI1uEjcfAiKVlmwEyahI0XOERU4Z8zm34avf9ZPDD?=
 =?us-ascii?Q?bAouwYafq+t16eRrKiBE8Jo+xlfUMNNelxGbFh9peAy+3f2DJRRsbKiJ6Lk2?=
 =?us-ascii?Q?XYWIIxIVbXthCtHS2l5byjN7BZrrtpmtjHJQAaaNXVOCI2pnJcHpNnzYQDsw?=
 =?us-ascii?Q?kVKtjEWKRPi0L9BzE8Y/1H/xf6AXyHD7pF+oovmgcqpYpGjbq3qHRARF0WFz?=
 =?us-ascii?Q?QpEdeS4cIv2sIB+KKZzaXZ2iuB6zfDw4KXs8bw7YjKQqgKgDFBShOk9k4DDU?=
 =?us-ascii?Q?hgJo07GAb6TZOM4BDjkp8y52nyPnjNbaa0bSJl7LWOW+P8PAs5dkM8l581Vq?=
 =?us-ascii?Q?Ge6QM/QmHBrpgb6K3DA/UBSqJVh+GqMCwKYjWweFqpP3U4B7670MDuCiVx1W?=
 =?us-ascii?Q?asy9qowvrlJi6P/JRzgxiyEa4Lf+Ep5KAA+6b1wdL3Ev1krWtHhdS2d+Rlvp?=
 =?us-ascii?Q?sIgOrktU3gCiT1AP4hdZ/JTizl6J4+kPLYuDwcheFm1K9UIIagull7gEtZeI?=
 =?us-ascii?Q?quink/L8zqgeZsnh/HKAND3EB1KGloUJZA/KOEQMl/kdwQBEHZ5aTOXsgD0i?=
 =?us-ascii?Q?kTcNnqnAFiHYKmTAaUeZ7mcPLA0EoTvskeR27wDEz0109o/RsFDj1H4gW7c8?=
 =?us-ascii?Q?2NGKmyMMQdolayZcfkX/S1R4U1BuPk4R6b3n5AYwstArsIkMDgdAvdtfc4ZN?=
 =?us-ascii?Q?IF7SXrBJ16ivPxYeF/PlM/0hT0bodgvwFnZyLPq43pLGfRwTXJfn/X4niz0t?=
 =?us-ascii?Q?4VSkMRfTaaB2Wc/jQrbtlsun54g7m5AmjfNIdzR+yx03uHsqA00bc1jQUmoo?=
 =?us-ascii?Q?JPdD/2PcGB9UbUjMs90Lb0aCF68agPFW2nEf8GGs8hYOicOiK0WnRfZpU1Tq?=
 =?us-ascii?Q?jhv6HuMjbdTdyXcAiCicL+K3tZx60L4Pb1f+7DfZw+pwUine4pNDbrJtN42m?=
 =?us-ascii?Q?nvMj/y7rVodkS6NZM85A67MH6rhf4mvki3xVlecnVGKRIaLoM6AYYW4M+jd7?=
 =?us-ascii?Q?XYxZAQFDxn0TLnj0bnCKaEksJ+dOC1RWaegoJuS0MYv5d/NRiyd3rhPdezd1?=
 =?us-ascii?Q?X5iJat3331yr90+DhuV0eALqwrjv3c+yM4TqHXP9bI76b24OffFGPVWRtR/d?=
 =?us-ascii?Q?zJsbiL2Q4B4rIc750onU3PvZpNAgja9Er4reVxbgbedL+OxRQsfhET27gHWv?=
 =?us-ascii?Q?ZZLuv5onpl0stM89kz9rywApsd0mdIwV4fVaxRkhzz5zIA73U3vI8bIlMALq?=
 =?us-ascii?Q?N0RxCtlU36UFhhL2nlDW8uRtUc+hUcgYxPybuLbaSYgiKeXH7LmieBdiLgw8?=
 =?us-ascii?Q?jQMxatv9jXxQ9gqmbtQJ2TGxm1JPpEh8MVJNLqRPnC8N7FgMew99puQpOgIf?=
 =?us-ascii?Q?KxD9BLiPE3ImnfSFlTetQPcX9BJsjtTtsa8GQ4/GpxnG7hThP1iXtqgnQUEO?=
 =?us-ascii?Q?SGjucEbz9wr0PM/r13xG06SJUcRvWS9dodbb/7LebKhL5E2IDDSWXiWrOk7L?=
 =?us-ascii?Q?1Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jcDSTpz9/fCF5U7I1fnb/JhQIzhzgchwil58r6cakM0ECa7s1JgVmUsJAa9nt4dwGQHNi42bUBClEdWP6AzUZjdXxNdQ8MWrcLD1jcJBHWKJf3SnywsGkQopG0LhUyZZJsOEIkwS5WYQ1AI1M07/EsGW82IgEUQALxXMI7pGrJEB8YutauNmqQ+RID742WD18fk48/YMo19LSnT3xw14+0ASDqeXAhDjO7S8S87oSwM8c/KZkkhlBUUT230W22vePIPETeyaOaYoVtyqqD8W2LIJflvqKVqaRXKNqeXiGOodnhEq3D1TtDhWZ0daa8C710tx9iTpnBmrwnrHsj3oz2idOgWiu0jml2oi8gNa6cMZvpOxqQID1Rw9BUi0++cI9uqgc6cKXF9Lh939L/EwKS00aPZ4WwxFMOYR8QCGpU7EeXWcT0md8A7dzU92vfYuH0wESGZckgA0ckzFms+a3Rbr2mKqC40FcTAzpRRRQr5UGFbVGFwD+dzzukSJXAw9xsFfv/hTYxeixbl2xqkKp7KyCS2ohHo1xHBbAtCg7eDW6206HV1nrl1i44phj2WvNXJ7D2Ke/N+BUtykBKs8xQHzomTuYU1DYvdixod4YVKBYjEWhyjuVXWUytiIW0ZOZWa74m+Ket2XRF1391GhIHLzO36V6cI8UnWaCsoqxKNnHP3ItYkxtxFV2uExaiwnEOwMBxd0ZCj4QG2ruw4Cgb+9EA7gs8Oinr3rgDLSY7qk1GkDi0KVMzyyWEAgI/Xcj/AGeRrSZ0krVKFXKwkUoC8FemUkgYdeRXil6WrjTDnwyGQe80iqqpjOf+KlpesBEdp8mT0Jqphv176/L86lyQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d45128b8-c77c-4729-574c-08db9a8f8133
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 17:22:14.4281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RrQknmlJifvVeman+AfZOLuS4Ovw0YcqF/WKCfdhMLK00cmbzxrHz3VGkeIdcN9N5rt+s0hpHg1eOramg2X+sTTIC2piQlnR/uCnEY+t5fo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4987
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_09,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308110158
X-Proofpoint-GUID: NLlKE_sxGNzV6Koe-vmeItgaxlNmEFlh
X-Proofpoint-ORIG-GUID: NLlKE_sxGNzV6Koe-vmeItgaxlNmEFlh
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Thanks.  I will give it a try.

> On Fri, 2023-08-11 at 16:10 +0200, Jose E. Marchesi wrote:
>> > Do you need any help with the environment itself?
>> > (I can describe my setup if you need that).
>> 
>> That would be useful yes, thank you.
>
> There are several things needed:
> - bpf-next source code:
>   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
> - Specific kernel configuration
> - QEMU to run selftests in
> - Root file system for QEMU to boot
> - Means to kickstart tests execution inside the VM.
>
> There is a script vmtest.sh located in the kernel repository:
>
>     tools/testing/selftests/bpf/vmtest.sh
>     
> Which takes care of kernel configuration, compilation, selftests
> compilation, qemu rootfs image download and test execution.
>
> This is not exactly what I use but I tested in right now and it works
> with a few caveats. Explaining my setup would take longer so I'll
> start with this one. I will submit patches with fixes for caveats.
>
> ## Caveat #1: libc version
>
> The script downloads rootfs image from predefined location on github
> (aws?) and that image is based on debian bullseye. libc version on my
> system is newer, so there is an error when test binaries built on my
> system are executed inside VM. So, I have to prepare my own rootfs
> image and point vmtest.sh to it. It might not be a problem in your
> case, if so -- skip the rest of the section.
>
> Unfortunately, there is no option to override rootfs via command line
> of that script, so the following patch is needed:
>
> ```diff
> diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
> index 685034528018..3d0c7e7c0135 100755
> --- a/tools/testing/selftests/bpf/vmtest.sh
> +++ b/tools/testing/selftests/bpf/vmtest.sh
> @@ -124,6 +124,15 @@ download_rootfs()
>                 exit 1
>         fi
>  
> +        echo "download_rootfs: $ROOTFS_OVERRIDE"
> +        if [[ "$ROOTFS_OVERRIDE" != "" ]]; then
> +            if [[ ! -e $ROOTFS_OVERRIDE ]]; then
> +               echo "Can't find rootfs image referred to by ROOTFS_OVERRIDE: $ROOTFS_OVERRIDE"
> +               exit 1
> +            fi
> +            cat $ROOTFS_OVERRIDE | zstd -d | sudo tar -C "$dir" -x
> +            exit
> +        fi
>         download "${ARCH}/libbpf-vmtest-rootfs-$rootfsversion.tar.zst" |
>                 zstd -d | sudo tar -C "$dir" -x
>  }
> ```
>
>
> Here is how to prepare the disk image for bookworm:
>
>     $ git clone https://github.com/libbpf/ci libbpf-ci
>     $ cd libbpf-ci
>     $ sudo ./rootfs/mkrootfs_debian.sh -d bookworm
>       # !! eddy -- is my user name locally, update accordingly
>     $ sudo chown eddy libbpf-vmtest-rootfs-2023.08.11-bookworm-amd64.tar.zst
>     $ export ROOTFS_OVERRIDE=$(realpath libbpf-vmtest-rootfs-2023.08.11-bookworm-amd64.tar.zst)
>
> Script stores Qemu disk image in ~/.bpf_selftests/root.img .
> We need to prepare/update that image using the following command:
>
>       # !! make sure ROOTFS_OVERRIDE is set
>     $ cd <kernel-sources>
>     $ cd tools/testing/selftests/bpf
>     $ ./vmtest.sh -i
>
> (Note: script uses sudo internally, so it might ask for password).
>
> ## Caveat #2: make headers
>
> Kernel compilation command requires the following patch:
>
> ```diff
> diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
> index 685034528018..3d0c7e7c0135 100755
> --- a/tools/testing/selftests/bpf/vmtest.sh
> +++ b/tools/testing/selftests/bpf/vmtest.sh
> @@ -137,6 +146,7 @@ recompile_kernel()
>  
>         ${make_command} olddefconfig
>         ${make_command}
> +        ${make_command} headers
>  }
>  
>  mount_image()
> ```
>
> ## Running tests
>
> Running tests is simple:
>
>     $ cd <kernel-sources>
>     $ cd tools/testing/selftests/bpf
>     $ ./vmtest.sh -- ./test_verifier
>
> The script will rebuild both kernel and selftests if necessary.
> The log should look as follows:
>
>     $ ./vmtest.sh -- ./test_verifier
>     Output directory: /home/eddy/.bpf_selftests
>     ... build log ....
>     [    0.000000] Linux version 6.5.0-rc4-g2adbb7637fd1-dirty ...
>     ... boot log ...
>     + /etc/rcS.d/S50-startup
>     ./test_verifier
>     #0/u BPF_ATOMIC_AND without fetch OK
>     #0/p BPF_ATOMIC_AND without fetch OK
>     #1/u BPF_ATOMIC_AND with fetch OK
>     ... test_verifier log ...
>     #524/p wide load from bpf_sock_addr.msg_src_ip6[3] OK
>     Summary: 790 PASSED, 0 SKIPPED, 0 FAILED
>     [    3.724015] ACPI: PM: Preparing to enter system sleep state S5
>     [    3.725169] reboot: Power down
>     Logs saved in /home/eddy/.bpf_selftests/bpf_selftests.2023-08-11_18-53-05.log
>
> ## Selecting individual tests
>
> For test_verifier individual tests could be selected using command:
>
>     $ ./vmtest.sh -- ./test_verifier -vv 42
>
> (-vv forces detailed logging).
>
> For test_progs/test_progs-no_alu32/test_progs-cpuv4 using the
> following command:
>
>     $ ./vmtest.sh -- ./test_progs-cpuv4 -vvv -a verifier_ldsx
>
> (-a stands for allow and filters tests by names).
>
> `test_maps` do not take any options AFAIK.
>
> ---
>
> Hope this helps.
> Feel free to ask about any issues, or we can have a call in zoom.

