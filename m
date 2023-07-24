Return-Path: <bpf+bounces-5692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABFE75E5D0
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 02:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96FC1281561
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 00:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E169628;
	Mon, 24 Jul 2023 00:18:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1128536B
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 00:18:22 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCF2129
	for <bpf@vger.kernel.org>; Sun, 23 Jul 2023 17:18:20 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36NMxZvP013749;
	Mon, 24 Jul 2023 00:18:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=IF5rkMoPRsQglZc5dTF+luiNmNMg5V1UyDJfAzObIAM=;
 b=00fNxpC5VYs3wHLwhmFKoPQ11yt1gaaUVQgWSAMupFCJoGIHWYcy2y2mSL+HW0csg5r7
 hrIhgb8XTJ170fjKvZNEZQcAMnlv+hbwcztdEuz21CYIPLP7CxUukM+hDzoldk62t8Qv
 3fRlbRCAvM3e8p4b8vM1E2Ac3nZcs2R7sNsT7vlR5OLFq4QmjmzXmO65zD0J12RNpCh8
 TpqTBWQuKZ8waXYyJFV+Al/3Gn1As3NOx8A8DVYucPH4SVfPpRlOylzdMHTJT6DZ431d
 kNF7Slfhc+/XWw7QpW+NwANYSHNTlkLWSzxqnFW1mWwI8nYMX7+Bu2maloEtcmhURJRS 0g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s075d1mbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jul 2023 00:18:02 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36NNvosw003840;
	Mon, 24 Jul 2023 00:18:01 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j2sy38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jul 2023 00:18:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dd5nhLAq+XH0mBZ9kwTZgyI3DAGzrJ7rLr3sVRyjcNzetZg08e33pldO+DXQ8aAdwcKaGHEAzqnA3qQuYHJQXgpo7bOUSe1wHJk9SyFNhlyBpp3WaxA1BYASOOdSH4J9hnqGynjtcQ2XTkFJfBAF/gixf6GKk6YHDbeiycsD5x908ilrx7y6XKAJE9EA5g2slHj3Q6FIHmSOAM/urbi8txVxBBuO84C4mjynib8GXhPvxEnspw6s2SDVl+3zRLRspIkiWiJSe/AG9cRSTpM+10/bVzo0TH4aRC0zkTut+rOl5dnShJgIhhoJCOt+aBLvAoWdvLPJ4ouvKD0S4j+oiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IF5rkMoPRsQglZc5dTF+luiNmNMg5V1UyDJfAzObIAM=;
 b=F5GTNV8z3Dxptjow9dUpiPuBJAsAvfnYVEa76T5wh5Xb507tPBTf81QlUtOCoDB0XJ73UgPFJYgp4JeH+Swpb4GN4Oerd/BWJkK4pCUCVh6rHRVzs85Ql1Gk05eLpkd0v3jGXcn0fcOVDxbdBZwGyfXXyynt8fE1BMP1QYLk+J1j0FqXaQOj9/VHkFth5ild/f8VTX4LxAGEnv5TQyZbocEsCYCIj41rVEV69iYWC/bX1H1cnpf7DJqmCOuzx4w80NvJJgUBjfwPRLtGYBsLCtosiD+RyKLlY7QnQ7CbH1RLqYCaYKOjIjAO2N1meGvuYG5khM7uxaoysokOpBLWwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IF5rkMoPRsQglZc5dTF+luiNmNMg5V1UyDJfAzObIAM=;
 b=NEKxOt3CP27kSQM9awXGyjVNmWqF7mOFjNvHjqHSuPXn9uWnsY9Uaq3GlFjx1IuWfWeuq7FQ/AxhTkDEv7NlEaSrGTL3SamubD3R9d8vZqlHjS514ljM9W3TdppsMb44RI8QtVUkcjZJPHKBOhhoJEiWyfadF+EroAmwFwkHi/0=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by SJ2PR10MB7109.namprd10.prod.outlook.com (2603:10b6:a03:4cd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.40; Mon, 24 Jul
 2023 00:17:57 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::4d0c:9857:9b42:2f6c]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::4d0c:9857:9b42:2f6c%4]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 00:17:57 +0000
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
In-Reply-To: <87351h8gak.fsf@oracle.com> (Jose E. Marchesi's message of "Fri,
	21 Jul 2023 16:56:03 +0200")
References: <20230713060718.388258-1-yhs@fb.com>
	<8b3e804bc23d44ba3a30b9d69e6590bede857ed3.camel@gmail.com>
	<aa910249-cc7f-680f-144a-b6f6962b277d@meta.com>
	<87351h8gak.fsf@oracle.com>
Date: Mon, 24 Jul 2023 02:17:52 +0200
Message-ID: <87fs5ep3gv.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0099.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::14) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|SJ2PR10MB7109:EE_
X-MS-Office365-Filtering-Correlation-Id: 3670498e-593e-44a3-cd93-08db8bdb6e83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	JBIIN0jRiVoDrDZWRYjAyxjyTS+6zzihN7NmlYc+E4PibeZscgxzxzXXYGRtsHr3HE98i2PRvhWw+FlVGAumgqUu0YlVBmw0fPXKXGkMTypqgPvLlaYSTQJz0hbqGst/yzfYbu+YaN5tq16rrWmvELzmlU7nk8vB+iyr8Eyn2ZUSXqNP7/tO8C8qbz3xA0IAXq1cRqCgR3NVKv0dI/eLpx5kLaguNWMgbzJ+YwnEYY14SRvwtWqyqtbB09difvXmA+fgpckz7Ecf7ZpHwm5Jl7mR6vxlA6aHC0Eo4k/LjsHhgzzTJhloVFqx0WRUPeIHPLxc10o9Td6Z15rv7uVOBooxDNCidwSbZMTPuPtJNITmjDT1/4qlQLV7WXE7NFA17ah1+uNSrnA0TorWwlNXXMH6wGAVKUt9A1x/u/UpBTQTzC2wKDLJu8V8dELvAbmEz5WZRSRAyxRtHcKr8PByFv/Dh4uxG9U0YNlfKEYBRuqUfWNXjX60TcNuHl24d+hOTtdqKVwiXt6ch5pH0Sh+P8vafLUGCIhMyt2LaRa+lsHa4e0DUaZ4G1MnExn4LuqGz6n9VyBfNwoDOYYkHdD39YqnES1n6pFuT8bx5NYZT3R9ZcaYzXbqvgg7j1cJwvI6yL7gM2Maic/z52zAyem+Mw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199021)(6512007)(966005)(6486002)(6666004)(478600001)(54906003)(186003)(2616005)(6506007)(26005)(107886003)(4744005)(2906002)(41300700001)(66556008)(4326008)(5660300002)(316002)(8676002)(8936002)(66476007)(6916009)(66946007)(38100700002)(36756003)(86362001)(533714005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?uJ/BjREvvqxJXrGyNcsafW73ivhB2AtNZlTvtIb4S1mWgia0BYGS4gci7o27?=
 =?us-ascii?Q?coYhsXeZZufKFM8zOyW49FDn25Be5TI9ghHu21FnU8ctNYf/frCgYtc0mJNL?=
 =?us-ascii?Q?2ofWLLeHAdA8xDZm34ZcyHC9/ID9a5UsU3iUIzhft1giCuJEybdcIytiZaUE?=
 =?us-ascii?Q?AvQps4OKmjZSL4Kf4/mEFGi2N7S82XLxM2d/pf7K8LUwwirFd9FVDz3R0XbY?=
 =?us-ascii?Q?VFbkqNVGJJi+5Qr88lPPIDM7D1ni4CVnZruJDPWkeuWfiKzfzg+XBg/p4pMD?=
 =?us-ascii?Q?gRv+zx3asbaf5gA6Z6tVqWMDjXDNsveVfR2DTnA5CuGI+Q/C85HpFnKaK5k1?=
 =?us-ascii?Q?77oG9KeFZaGSE+ipsg/4jCtrzs59BFil4WU/SI4KPwi2zxNpGmPVFRchqcq3?=
 =?us-ascii?Q?sVmMNs5VZ22Limv93g0Ux9Jy0s1kkTJRWVXyXfn/SCA45vPN+NVdKCErW5+/?=
 =?us-ascii?Q?AYNIPPR48FmfMxZ/6PGGgTVapxpmJHB0207eUV34/MzzVs3DkpSb06zeYGaD?=
 =?us-ascii?Q?YXL4WVeSjXco8ueem1twY/fsc7f2TxEapODRCzgzSpfHEVx8Md6WG3q46G/8?=
 =?us-ascii?Q?D84aZ8Y6sMuPBejc8/RszQxynG4lZt/1r7XgzgYWYKzGIXYYvBCkGq5/9cQp?=
 =?us-ascii?Q?dj36+GyRlYRiEJ6AHIt9dJupNLyTNFFq14HNNUIhx9M+5G3WyqCf5Nw6Wnz1?=
 =?us-ascii?Q?d35BdT8YwAaIyD29uXBiC423f+zntTLBrDgXzg17rJie2CEG3lag16DQ79yG?=
 =?us-ascii?Q?sEZJPIdAODliiIkE+shlwU5LV3fai2Q7q/p21EkCcVoBZNQFvIBbKGRR57tO?=
 =?us-ascii?Q?vBoLDQLhV9KcPUZikKfXmku3aAu8AoJS15xC18eODZHGPlTS7Q1/tnlId6ja?=
 =?us-ascii?Q?/siWftjC36S9aybuovblvqv49AIEAh5N1YrBRliIIhspan9PGQJPzDub4o/m?=
 =?us-ascii?Q?nzcLPtchnpNcbeVJbdn7oRtcPtySD2NIP0MVGzUNF4GcrF897AUjLhZK09wW?=
 =?us-ascii?Q?IXCAxtHZ0/Ftu+G1qHS2tTDlecYGjMwN8ch6jQHtfpBhFrkd06iXJtCJgwT8?=
 =?us-ascii?Q?mJxjGZX7hOMbwfIXbkc9H1asGoHj/k86Lo5GoKh5c+eAEHYCO8z6fUW0qu9j?=
 =?us-ascii?Q?x5K+0LO5ogWde3Z35cr5aiMekp64pwxjNBiBGTCocUNQAxfKB/vxeeH4SZu9?=
 =?us-ascii?Q?mpPTSzkieX4mMaLhmT+U7Ini9MRsAdo19dXESl64xF+i8OaBUJjyNk1KAbF8?=
 =?us-ascii?Q?U6ow7tuz3HBzXYxqDnbfCilD2NWhfCXxnt2ha4K+fKtxizXG/2XEO1OSHNDh?=
 =?us-ascii?Q?7/7UpOhF4mJJtwWpiZzpYFnDKwLC2UshRfTihIxv/yewpVZLxZbFZMoaZoYI?=
 =?us-ascii?Q?73OuF/6CsnCjrGIF3tqv9Nx/sy5kIuBMGIDp3jWyyp3kMLXfnIstfnQV4Amo?=
 =?us-ascii?Q?U0nUP+EnXAbVpssXsYRWzerax1YlfWEaNW57Vctpnq+sXvoeBbNIA1lDHi/z?=
 =?us-ascii?Q?wsSWcTSeCFOel4950ffNbIk4+7kMKWzOwDVcG4QiXqMwiCeu/AnlZ3bpK8fG?=
 =?us-ascii?Q?SosqWOVkuDFgdj9Q4XyVgCbZCoK9Goa1tv3DqdaeOXBPldPEkuXFBH+gKdgX?=
 =?us-ascii?Q?QQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RwK7Tj6J3oyP/ygLkzSBZYNMP2acEt6nZFTsndhnU5UlWSkV0fPHJdFSYMAL7xG/9XsTXwRNuOeqv1rdEIL1eGHLtAwvS8xe0XJ3gHJDf97JTs12p+tTG3qyHXGt4DSinmHV7v9sp68yziLA3j3mopGHEexC26p+E3aVe7SONVWY3UgNdgeZWjH8WBMzignt8JMasuuGEQ5WDKTmr+HTuWTzUuGcb6jxsfLiHCK54UaqqR3/EslBKUCxrHsAa2QA7fHoFpSuo4DEOPtBw3tv/lBdsOdRSNm0Uj37okQ+J+JadrcVuXyhDqt9KjfXvTnvEDDjW6fGkp0QIPD/N2AeE4Q1aydwad0Z48yoappPXt9OsPRlrr4dX8U5iQ9TZAYvBiVPyy0LqaDR3ZhfcWA/mR87+MsZHYw8coAZXtGOKquLWggfFLPTQ22vnj/Pv/OyOtWbW3Ngr01ozkZJzzl12DPzM0YCinRTcN41D3xHbqv2gXmbdiMwAY4TWUaDyWcjYHQzWXilxh/gD752vTHFPg+ftAbKtu+WjUsqbbBsSSfZ8gFbbTP8dOTvMJNCLG3px+5Df1VLiAMhVUCHXwyBtOJpkg90SJPa7zWd+tL9DtDoLz2Akf9UKVMQaIGVG+1m7lTudTGkunhAIt5YWTkE2wrQ7RLkHo0BdIvZcLPOUYKUXhZLkRciXsyjzr8f+zYf5y6wQs5vZucZbjDCgAF5uRpaUMlROEi1hOq3kJfYlgVArWgvUhiPFJ4aVarzKZpooUrh60iSGPmD/e9dLYOQzXUoeYELfurTQDi2LuV5ipDIMn3rJqGUyq1olbLYt6WXhgxvm4fhx9x/+UTj4Rh19MhBjZqLQqVpAhP0/pInxBmRcmDj6Q+tzpVLhR0gg34ktkNF079Ti0iHkWY/a3KO31Gi1pd6GxiSqy5wMEuRWH4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3670498e-593e-44a3-cd93-08db8bdb6e83
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 00:17:57.4050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6AEXoE5oijHyI8kD7gnI9cuH16D/kHoc3ld9Uaqo4AxoYIikef5LG0PC4gUyl2F3R4r/TdBBcWlAkht8Nx19srzWPEI13nJbH33jUQxcCE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7109
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-23_12,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=393
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307240000
X-Proofpoint-ORIG-GUID: evA_-aM4VDiGjcALls8FidXF6xg2X_wF
X-Proofpoint-GUID: evA_-aM4VDiGjcALls8FidXF6xg2X_wF
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


> Hi Yonghong.
>
>>>>>    . sign extended load
>>>>>    . sign extended mov
>>>>>    . bswap
>>>>>    . signed div/mod
>>>>>    . ja with 32-bit offset
>
> I am adding the V4 BPF instructions to binutils.  Where is the precise
> "pseudo-c" syntax used by the new instructions documented?

I looked at the tests in https://reviews.llvm.org/D144829 and:

> For ALU sdiv/smod we are using:
>
>    rd s/= rs
>    rd s%= rs

Looks like I chose wisely, just by chance 8-)

> For ALU movs instruction I just made up:
>
>    rd s= (i8) rs
>    rd s= (i16) rs
>    rd s= (i32) rs

Just changed that in binutils [1] to

  rd = (s8) rs
  rd = (s16) rs
  rd = (s32) rs

> For ALU32 movs I just made up:
>
>    wd s= (i8) ws
>    wd s= (i16) ws
>    wd s= (i32) ws

Just changed that in binutils [1] to

  wd = (s8) ws
  wd = (s16) ws
  wd = (s32) ws

[1] https://sourceware.org/pipermail/binutils/2023-July/128544.html

