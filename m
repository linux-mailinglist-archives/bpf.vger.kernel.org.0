Return-Path: <bpf+bounces-7541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 007CA778E94
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 14:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE4632821E5
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 12:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C89279D2;
	Fri, 11 Aug 2023 12:02:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCD91868
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 12:02:14 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7402C110
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 05:02:13 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37AMjsix014940;
	Fri, 11 Aug 2023 12:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=NUGHon1+pcA0iWXrDK+v6ZFekcPeGXx2T9uAP+bhSMk=;
 b=4JqUDVqoPfhcByCZ1RH05F6MAAb1jMKWsctKM0hb5KAYEOXX6dKadCPCmBthBtBHkRUk
 a9s44dRFDGJAU4J+3XCcc+8vCbHlXs22Sg7aDtYhKnuA+g27q6L+ilEvqd+l0soxRkoC
 z0wuwZ02HVVNvDuwKfOJ41GwZpvGRvbuXS9XBbAzzjf5ETD6iLeBKm5mtvDau2OZx8wf
 mt4Eff7Y0f6GWpzw7h36lt+Yi6Op0NmOz2QNBh8kJZZFc/uCX1xfHGHMyBJIfj06eQid
 6cXtJbWJAFZLYkWoKIsCQ1x8ltT5eY1Byegsn8puQAxJplsl2Y/ymJGzHVdsqyWmAZdB KA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sd8y3ruu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Aug 2023 12:02:08 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37BB59IS002883;
	Fri, 11 Aug 2023 12:02:07 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cva1j53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Aug 2023 12:02:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6TulF9gL5ATdRLRPV+D/TYy+yQ8OUA/k5Mv7bPbyj2KhrtTafRWdIZxLbV/nnQAL29GfyoHxD7OVha4fzL+0wows2eN9J5v//YiEpqJbQPxyE7wxBnmAhs3GMPONaSBkq30DG1B4CxLjidOopJG8r6O1gRKGjYpO53qsIs4Ru9dbLPk6DBmsTSvNwwLdDRFH6swoQF0K8faSXQTwq54Yn/WY+eVPsdIXSv3kwMCm+RBNjNcFV6AEVd4ygKqhPESnypB86wfZxlGq2Lr2yTYeQvTT6uvRxDaq5KItinOOPqlRVOo+Bm4j9gWMEFHejxeb5LQyEpUyWChLtAUQoKiBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUGHon1+pcA0iWXrDK+v6ZFekcPeGXx2T9uAP+bhSMk=;
 b=kRLFFduqFzJfVrjybSJcHUpIaY4Mnq9tJVjrTmcnFivNkuTGzCj0iX2nuiPII9n2oCVqyuVxxe5JQ66NV5CrKVRpLzig/gw1Fw4lVbjJ3VvXa6ublB8dm/oCje81hgwVJdfQZrdaw+UY+SbgC0rW3mmGZCkBEyBbALp1J7TPsM3ogV87Zk6MEhZ2DNG5sbYthA7tfb6Gx3LBi3pP+7RBhLbzYLNQiIQ37wAeIPtOQk91wjj4IfZrzkpTGt03ESAjADPhdtBlahjR4NsGppxqyjWLLljzOD85Y+BurJNsPkXNYmxocdIcCOqdu9Wwq2EJ6aPus/W/dd9cGPHVYWUq/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUGHon1+pcA0iWXrDK+v6ZFekcPeGXx2T9uAP+bhSMk=;
 b=UK6Gi2o8eJmZozxVCy+4jkPUuYbWtoZbsz6LclLn1tkIHW9fFCJkB1Hw91ujbjLREVmBNIsZ9P6RcT/3mGx/9zw8q2i3tZbHe+d+HFGS2hRYlMrCMyuPzl1tfA+CIouaKxdZXfEKr7SvQLhHouDTBD/MazN/XIOWJgaU2WgGbVM=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by DS7PR10MB6000.namprd10.prod.outlook.com (2603:10b6:8:9c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 12:02:04 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::991c:237e:165e:1af]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::991c:237e:165e:1af%3]) with mapi id 15.20.6652.028; Fri, 11 Aug 2023
 12:02:04 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: yonghong.song@linux.dev, bpf@vger.kernel.org,
        Nick Desaulniers
 <ndesaulniers@google.com>
Subject: Re: Usage of "p" constraint in BPF inline asm
In-Reply-To: <7ae83d1248b649a8765a3e01e7a526c86b956ef3.camel@gmail.com>
	(Eduard Zingerman's message of "Thu, 10 Aug 2023 22:38:31 +0300")
References: <87edkbnq14.fsf@oracle.com>
	<a4c550e4-1d65-aace-d9ba-820b89390f54@linux.dev>
	<87a5uyiyp1.fsf@oracle.com>
	<223ef785-8f8a-14bf-58e4-f9ed02b21482@linux.dev>
	<37b9680f074a871041c3dd61d22e6a6c9fd02fb0.camel@gmail.com>
	<87v8dmhfwg.fsf@oracle.com>
	<7ae83d1248b649a8765a3e01e7a526c86b956ef3.camel@gmail.com>
Date: Fri, 11 Aug 2023 14:01:57 +0200
Message-ID: <87y1ihg53e.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20)
 To BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|DS7PR10MB6000:EE_
X-MS-Office365-Filtering-Correlation-Id: 60097452-c566-49a9-43c1-08db9a62c6f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Yn8VLUTu/rOcysWLMFdecFR4rS/D8qLnjT2kzhNGonfz+2JkYraE8svX+d28+SJlWzIsOjiVliJpAWOkm0b2OB4R4Yuhmq62XwYZq5vzrxYsik5a5+oOalYppygdohD/iKjfBw2HqxVlMQTv0OnFpW3gTF10n/DpOv8L4imTr+M8M9R4VAEA5BLyRZUdqRWJD9pfWCeo03ih3d9+MIO1y9P3+Ax8FNhUZPns6FbNfrEMLqvINjqYL7XkPb/APS14lM8bKek5nAP083S8gLSNDoVWVfe68q2LQGI5h+h+xuMqtKFZzY2L3WFpQyl/YwGfDTvD6oj2phP1w/JVmYcYhRrdYc48GwmdLSYLHj8wjSvtWbn/QuGjQdMLNQXtcBNv3k8HOGBPn4fG7eruHGMtfosd2KhKOJ0hXRJ6rPy0QvZJM3zcgyFpxeZHTeA0pcmJynfmB4c+8y/aOWkwZBuGOztSXXI9oLz/tApcvtwQ8nlw9jJFKJPTZBW8MHvX8q1DW1ZJhKB0F6lDn1gDrzGesp35Rcw2yMaB08VmmB0n+bVm6ujMmVQ+qcIjeKW4xz+Y
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(396003)(39860400002)(376002)(186006)(1800799006)(451199021)(4326008)(6916009)(66556008)(66946007)(66476007)(41300700001)(5660300002)(6666004)(2616005)(6486002)(4744005)(2906002)(8676002)(86362001)(8936002)(38100700002)(478600001)(6512007)(6506007)(26005)(36756003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qxYYdliIMuMGBti8kOA3A+Qgf8BZ1WMogZHdpS3r8wR7VpCXX+cvK+eLac9U?=
 =?us-ascii?Q?YL2QyBln++6SpuvoFeLEiR9FqNS22ZPEMrEYS8QQqOXS3SQm7MjGVsuPdgOi?=
 =?us-ascii?Q?Js9NxqLlm0xJibJtzkUDCOF6qnZfkvhOclyybXrdbGTyJG4/QmS4oJKOYzMC?=
 =?us-ascii?Q?2W8cUY/4TZUQf5UY9yzFb/NiF4yVVKI0/gsioyu6CMG0vF2cKqT+gI4yfXnw?=
 =?us-ascii?Q?wXrj+NOO9kEfPLub03MPFC9bCfuN19K9yXMqqVUXq1qUuEZFGyz4RmFjVFwK?=
 =?us-ascii?Q?/IccBv3X7fZlslkiExyQFpAWXPWAk0q2KRHFS9oVz7HohAvgS7n0VI5qSRHQ?=
 =?us-ascii?Q?7KQVJ1tZOvuxb43QPEQyZ2OfpY+lHK8X1FS3MBRDk1ZyfBuVoPBXT7XNW1tS?=
 =?us-ascii?Q?F0J99JEvfBnz6rjmtBBCe7R1vCAxB5Z9ehnpXlB6bNxO+2LJlI9fiUwma+zw?=
 =?us-ascii?Q?pW2m5eTFh5KZecYdSonTLOh4ByiKhIeLQ1DTLtN4hCmJ8eoJWApSr54EU493?=
 =?us-ascii?Q?ubTjhJGxlVbgmP+/j7/XKUNvDUBbgcbNiHTIouwBGQNLnd/tj3wwCq+Dg80B?=
 =?us-ascii?Q?YK2O5mySM2VtXMsYbJLteDDrG/+npuTrw5dbBqYm/dQTp4U/xYb7qbeko92z?=
 =?us-ascii?Q?l80TsfDmwKKLDBVs1BQxOfhUeq1+n+7SMWcIPJAw1xYUHhkrVz4aI3mKED8q?=
 =?us-ascii?Q?LNLSVFxiSyBvnjMJnjoZnXWtrB4CrrCZIx8i5YZK7x5aqGAVRHoxfE/KDJUz?=
 =?us-ascii?Q?F2Fx2oDmrH70K84rJc/8gXZ1JMlJ5/RxYfsU11TcAbin5+Yb4cTAEjShY/E4?=
 =?us-ascii?Q?bnDIK0OLDwuNeDKPrWzMAd8deYQ5wc8hCjbgRBe4J+NLaXiHodMnEXrxmmqo?=
 =?us-ascii?Q?JKHrPHKCYq9J18o+yC69lZxgrUfbOQP/Wqz6cn55Gd/p6KoTLWOmkFGIsL8y?=
 =?us-ascii?Q?1Ku52J4X97WBwXP5fz1jaz/07U/TSJ7SMaYHfhM2vhUdDxL7lkMlymG7/Pp7?=
 =?us-ascii?Q?4BqYxonpBFAMEZ7/4v9ClKRD70cJQd4q3wRt6o1Xl+KcfDYH1LA2mjnNUCyn?=
 =?us-ascii?Q?K5TVALomKsKC99MByTxlXwdLRI/ex3gH1744vAuThKbSMn0ucAILhrJrhPXk?=
 =?us-ascii?Q?jKz49Xl/GgfcgaEcDCiyzu4MnwL4Jjr17Rdg3BiIkj0JrjajDN1pFb+n/9le?=
 =?us-ascii?Q?u5XZQDcvfNvQ+VS4Sk48/etCgfWC3C9XOlhsuApWOcakI9OSqExql8vB66Wh?=
 =?us-ascii?Q?kD2aLeFrXKwNI7x6NlC7dmwk5dpBA42w3BR1NKpSiQON9yXWRZKr2pKCYozH?=
 =?us-ascii?Q?fKxu56jo+rVNfy34h8WPEQfMEJn4LkMdSvHW3UddYsji0TJpaTkPz65jAVQw?=
 =?us-ascii?Q?EWbT40RQ9YxjkWXHuw4CjfEQB3I3U78evU5sT/HYHTeLNBOOvnkZQPFAwBtq?=
 =?us-ascii?Q?NgKXsBBvK8EU1HG99b+3bLOLUgXssiPh5LNIRIaEcMDcWfR1LpR+ymLkgfvb?=
 =?us-ascii?Q?qwdHNA0SFs2VVHJ0HObhLLBARumH5A1KBmQ5I0/wMlBjHOBEjhDIu9z4xgfL?=
 =?us-ascii?Q?R2QEjgj4EhUi1hZv25EOXa/Q8NOfsavBeUW1Fz83cRx8urhaEwNuq5wkFTxj?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	75BqpC72JB9wj8/gDhEw5zhnsArtYdtrtlwIUmZoUeEsjIA4N/VkVjqeDBYq0iEurqa7tchHy2Go34Ll9naqBL7J01ReVAJV2RUQykXLruKknQJFC3l2I5o9M4qq8+jo/ZluUaSk7Bw4VgidRWa2G3+tLR+YxjuqwwOZ3uXJHKp4W02PRS5FYhiM3iNDuowdP7lVW+iL4P2SRxZOyWB2N1MTToTUIU+AlaiU11ndfoxnRsz7+9aUYSyjDklTcPYQGX+fpVXG3wVMtZ+tr7nJb/wmqJdmGaSike4GdL2QaNArwSambO46Orjr1U1Z929dXj5XVmnNsp3C8Bp0EaBtwcFuEdcY1QS7qRoIPfTI6UmwAqnt8QFJWdLr6runW//9z3LHwiLTbJ//tch12k5/+mv0xUNkdWGiqNqP2PCpvlr2SosOxC5w4zgrIsuv5JGDauLZKdRqPGysIMRheI2dAzHycFuia79JfDJ9Ri/ztpJYajek089C7DbzpYk+9+s0CQvOtzl+wjGPT3Q/JpejMQsTQxWXZxj13aci9zLn11GICsXcLdv9eXqete0Z2YbXkv/CAdyggS4VhgaZ5PXCPJ4IFfkGyFfkdad+FNYTG/Cvkortfkn4g1P+ASk+mImE/72SSuyKRyQW7aXQSWMPtS/djnGK1kn4FYpxbth6wx/RYWxicXEBqqU5r1VDY4rhGOEC6BT/P52t2WRMjEPTsNqqJmEBO0XO5opK4x4w9/vmBtxOkIP/Cjf0S1GnQVCNbjAicspZj6AIQDNEtYsmvyGOX+5fvu9KUaBbQgihXVHZF9YTJlkq9YGJUXYUPVPcLsAR1+8hIp1+UBjqpmqQxDVg6nvkRh45Dbynuwv0tIY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60097452-c566-49a9-43c1-08db9a62c6f3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 12:02:04.0693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yKtHQCNxy1Pnvb+8y1dO+quQAUqvmUtZDLjqdZKZzBMBCi9PO+R1b/n7bLPZEdkFAB1o7YidDayvY2/6CsEYygcetk60UbFZn0sBXM++ecM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB6000
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_03,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308110110
X-Proofpoint-GUID: VhTdVMhoZtwunJ7BC1oYts1i1kBMJ27A
X-Proofpoint-ORIG-GUID: VhTdVMhoZtwunJ7BC1oYts1i1kBMJ27A
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


> On Thu, 2023-08-10 at 21:10 +0200, Jose E. Marchesi wrote:
> [...]
>> Note the same fix would be needed in the inline asm in
>> selftests/bpf/progs/iters.c:iter_err_unsafe_asm_loop.
>
> Right, sorry. Tested with that change as well, no changes in the
> generated object files for clang. Can't grep "p" anywhere else in
> selftests.
>
> [...]

Thank you.

Ok, so since people seems to agree to the proposed fix, I will prepare a
patch for this.  First I will have to set up a kernel BPF development
environment... but I guess it is about time for that ;)

Other than running the kernel selftests, is there any other testing you
would recommend to a n00b like me, for changes like this (code
generation changes)?

