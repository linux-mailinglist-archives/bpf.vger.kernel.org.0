Return-Path: <bpf+bounces-7829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3847077D083
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 19:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E136628142E
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 17:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAD3156E4;
	Tue, 15 Aug 2023 17:01:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67DA13AFD
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 17:01:36 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F413B3
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 10:01:35 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FGiGxk002199;
	Tue, 15 Aug 2023 17:01:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=mYlJGRNy0bN5EQns28TUTiLdbXByy0l1IbUw+Lqu+KM=;
 b=U3gEGldxiUnwFLJFR5PA4m8FIo1/kPq5jtI/cFLDHM2gtVGMe9fiGK+KIFznXeo/RWTY
 XZlT+7hqkq05fwmcn1zCgflpfmtxRQ3ZNz7+9d0A6Ky1bTKuZN1MyAhP5kyfBZOqwBEv
 +nKnakNEGEBd0qYXIALRlI16ebpWTpeptvgDdGY8865ndT0FNWsieEkzfrJTZR8AStTt
 gLwORWrhx45Yusu0ihD92xccNU6OxOw9i2jL7cZMFnfkaGWFkrQMbkMPEAVLkSbgBqm8
 q6cS/rCS6E21u/wjNgqWKiQAAI2HduX20GCAKrKHtYFYF70dHjA/Ijl/C3S/7h/SkWPC ZQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se349d6jr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Aug 2023 17:01:31 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37FFvrOW027586;
	Tue, 15 Aug 2023 17:01:30 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey1sar7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Aug 2023 17:01:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRLy6uGqLuEIFqwkeaCITHkEC3SrmBsdWR/QIi6buD8SdwWcTVR1zXXyjbaoIWkqT5yYusj7O8zyUzHqFzkKwtifLwGW58XoTBRQRJLdPWSYFGaZOxMneLAoaOYuCbSFUq4/+FICJ9bTN2+Z5OA/AeoS614NvJEISm3IzLIdVgwTYEXXPm+7F5GXzcWypLqKzpOW9TNkNIcWJYnJKhr5PpM8ls4sL/r1qlX7R5KbpmJZ3h0DK+Pvco2vB7ZVX5WQx9q0kqYI1WEpMa9fBxeeo7dlK8cgCMscGQhUyXwOXk+jFMO5WjsmzWTbBK8D3tsbjRBMVF0tHs+p0Kc00annlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYlJGRNy0bN5EQns28TUTiLdbXByy0l1IbUw+Lqu+KM=;
 b=GOhTBYcH8aBMgJ1uiKx1NlsNDOISt/HD99eYl2fBEu9S6DUdUw3jXELaMY0lEZq+FTdbTTDZ5ZEmpc5bfyxxtEV2wOhbmJwlnDN+w3wtRoF/ZAa07gcxe23B5FJySoim97jLLUHCGuRwfxHFeTyChgklgYfWVAK1GvqLUy2sES3rbcuv4iOwUULrrxMlWdq0XsSZrKttm/T73T3pLPG2tcuv51D3TALHf3SaPogwTQTW+P7gMqBsHzmuxZLZiQU7IXng4gh/rWbq1pgZoQeWE9v21KX3KQtLR/r+PIqEHgPmcKBZ+VcWqm7Lh3WNWSJrtb8eJ8TxDi1Ymfs+dDe9Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYlJGRNy0bN5EQns28TUTiLdbXByy0l1IbUw+Lqu+KM=;
 b=CLJi0SUKoVyKvsx5xCpAkH1e5OXvKpsUP/HmnYHp41jdBp51ckIiQybbxABXQ0RWRUkMMQRXHCmHmfWEizh8NbZoioYUuflmduLsSLHIgeEc03IEYovdDfDN9fcQRYLI51WyEEr5/9RL06r9cmM/vIMPUbf3aW//LGHd6MZvSVo=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by CY8PR10MB6705.namprd10.prod.outlook.com (2603:10b6:930:91::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 17:01:28 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::7d31:72cf:ebed:894f]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::7d31:72cf:ebed:894f%5]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 17:01:27 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, david.faust@oracle.com, cupertino.miranda@oracle.com
Subject: Re: Masks and overflow of signed immediates in BPF instructions
In-Reply-To: <ab4264da-7c73-e7c5-334d-ed61c9fdd241@linux.dev> (Yonghong Song's
	message of "Tue, 15 Aug 2023 09:12:33 -0700")
References: <877cpwgzgh.fsf@oracle.com>
	<ab4264da-7c73-e7c5-334d-ed61c9fdd241@linux.dev>
Date: Tue, 15 Aug 2023 19:01:22 +0200
Message-ID: <87leec44v1.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0015.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::20) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|CY8PR10MB6705:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fa1a8c6-9361-4b04-0e3e-08db9db143dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	rSmBLFWuueiPMC67xe3kMcbyY7JUUlNy3rnKSTkgyHRU5yLbCIBdPdg80ZffJPOpQk6pQTaeIRBqLy7c6UYnL+2/jw3H3z2crw+QphkuX8dUjD9qDzsmIh+21zZknivh9uPSTC5pm1uNtkl3TJXZl/EzXL9rcOx51X8nRKTIGwWEU6bYT/M0W8orgiA7QvtJU7fRVRwrjAZAxxpZ/jXvCTVqxj1BrH3qKUeL/awPAoJT/A1YDvP86FDExBy+zrXZ7MmSMmn+UKQwnPX1QfX/qke36c0aE69hm70lUpmPiGIKWZVSfQJJqsHXritOM6Ndb9p/VylEliEXfI2oL80UmRhr4h/KUJCcd6cfrrSBFDMGMEv9JutBiQKOejJGBKNBYVxAiinOcw2+qy1xRgA2ndsWGaeDD5dLcn2IOwf3tRYwm0lIt/M0NP1GM/617aRB+I+K9Ul+0Rt/R87rXy0Ir1n/f8kxTcyldHyHzctS6uDjiwUCtH9mbkHziTMod/PMefhLwQoTvP2rVb3Yu3Xrfh9736qOIm8TJUhMPzHlUEvc95nH4LP9rbQPH0VUJvFFjHGucv3WuZkigKYXTjMaWDPDW8YVeEqqR3GHGHQ/110=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(136003)(39860400002)(1800799009)(186009)(451199024)(41300700001)(8936002)(6666004)(107886003)(38100700002)(5660300002)(2906002)(36756003)(86362001)(66476007)(66556008)(66946007)(316002)(6916009)(4326008)(6512007)(2616005)(478600001)(8676002)(83380400001)(6486002)(53546011)(26005)(6506007)(14773001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?FEZ5hMy88CH9DGhsaYVCQycdPnOlRgEkr/EVny8FGEKrYTbxMNDN1AqBbqzv?=
 =?us-ascii?Q?0R4KB8n5z7vzcd4avPLAYECZG84HiJqP10RC79LlEM0vq9X2ZWgKNS/x1NAa?=
 =?us-ascii?Q?cIlXWGVUHmSX0zx+B9WOh5UX7mayVbvMLxrUnigYDMX0OMyVESa9GyrPmMDu?=
 =?us-ascii?Q?br9SSaa2Ays4EPVFNZdi/okfU+dnOpkquRS68Xr1Hl2/u4DA7qtt/auubhcP?=
 =?us-ascii?Q?tBSwDS5bOcaF9MeA9UBrLc/wrxQrsj6OV8L5Wtl25q7LUW3ut8s4HqeozmUh?=
 =?us-ascii?Q?kr6yJkxJlsqZFKkKNqwlZVJ06IUb9C0e/7AvOmGLYCHga14Qeo+Vbq+6g/Bd?=
 =?us-ascii?Q?e+q3CKEdSvKncVfTdsqjgeh74xFGsS8ZjdyzrBZs18dMTNX6rmWEidhS6fpJ?=
 =?us-ascii?Q?dpLxQJ0nW+NPHV0NGHjJYrmY6vI+/MZYDqNzUc5hwhU6l653H+wIMfEyC3hw?=
 =?us-ascii?Q?266NUouZPV4SjL63H9CXjYJvbBQM/t/dC9tWFnBoO6TUX861ecIOwz0LdEO7?=
 =?us-ascii?Q?5xNbdIyJ8YK5SN/9710Xh4mbUP++5MTezQV+akrMLvFobkm7E66vYs/KpUlS?=
 =?us-ascii?Q?Ov4irOm3cgQ+o+UYzf/nZH5Qj+t0ap8/f7JO8LyAFM9CCtzQMVy9a8Rh2PpL?=
 =?us-ascii?Q?AuB8GiL4RgazVqbj1t1TBaX7/67Guv36acd57b7ll7n5pysX9sAZeFy2wTn3?=
 =?us-ascii?Q?EX6a7xkMb4XLl+GnMVWz4pCXpkfuEmGJmivj9uWvydZtgWhQ5/aeCy5ijQqI?=
 =?us-ascii?Q?+zgO1Vf0L1QawkIoqkrnD410lIO7KbkFnixoFWv3LpvCdBGv1Mr02eSi+hkB?=
 =?us-ascii?Q?fRDhiTRx2y6kEhQgw921BJL1fpU0XegHv6wHZCjFAx4EFRUb2SZt4QJULNF+?=
 =?us-ascii?Q?T8fz2e0MKYsF/D3u4tYEPIT00uIJGNH21rGFmca/IyNEvggei8gDuwhSLQEp?=
 =?us-ascii?Q?4kE/hKVr3Ij2EYGA73nZMHWzRHjM4Jw5TWSCafLtD3cd5JoEtGz0znywzn3C?=
 =?us-ascii?Q?DTx+SA1lpCYq2m772Mujycz3K+/+iDFMpt7+MwV6TBiiA1rOPrBXsLzI86+Z?=
 =?us-ascii?Q?v1Pkw3VPdJ85ZOTF8Y6VoIv1VnQm6riJUFKSgHPxK47JGlNIJAFeuwcj8U4L?=
 =?us-ascii?Q?IMQ55A7/fZY1bAZy6SjVpjBRiBXoH4mdQE29jRjYdbbduZlvkx7H07+OpFTK?=
 =?us-ascii?Q?MosbpHjkFXBMrcHeJ5UK9pGRcUFHkksM6Ju7Jqwfn2M5XSfpP2wbwkPORyB9?=
 =?us-ascii?Q?/ek71jUJ/U45QXuemY/ylXjVZcVNGIn6xIg+5ND7eMymrQQ2+1L9e1MCv8sj?=
 =?us-ascii?Q?vnjhF+Z0mqvHmShpCO2i7La7yaXQSiQmITYwYpMj/0XTRPta8og7WcFvh80J?=
 =?us-ascii?Q?aV04uAlWFu1PmqgDPiMEaLENi4NmJZxuQWE5q2bQEfGDPBslzn4ny0C6QUmr?=
 =?us-ascii?Q?HI9YaJ29DuoRM1trr/9A16O/cafE/YedaGM1+YqWQLx4YTR2K6A8E3TMnVGK?=
 =?us-ascii?Q?Zm6OcK6v0fJhLzgluC5e9D1/YKIDKNnt2DJZQYXzijGT9MxQ4kubTidnskcy?=
 =?us-ascii?Q?2ybbVWj9Aa3QBM/9CVvjhwAKktJjlasiD/IwWCNGiOAEc8Md6aTPwNsSAhPz?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YH71eq+GoX15MF/+UodZFG2WDuh4TQvVkDiAR47DTXDA49lk4Inz/BtaGVx5ibEQosN+65jbTbdAo1EJsngjeVw8djHG9nH94xhvzZSmB0xEK3m75Oar7GTf4Tp66cgAeq6lRgNJmMaJTxOU1XOeCUsxI3JjGeBCX6pBwhnOdLMtOY2E0C4KFe8fzF9i4roavs6Uja/eQqXsPB4W3iD2mxtJkNDb3seSWVpTEdBcIOLWN1AAmCDyM8/e3+g/f33w5Aa4cEysPmg6U1uGIguYrKClKkT2j63GICgzvQzuonjcoNU8L0Sdl7Kn1ZR7PQkC/KaowwNZzgkgLMFTHT96h17EVks2f3MLeIJD2b9ffdGrpkIflmDdBZcNF1hispYvupsRuv4eeaUk4D96wS+xFaZOHjbvZJLr4WXmbabM907OtSSJBLRgYv45EPXvpiEdNL/TXnwFqkfhQ0eWiRKDgPRm5/hcN13Kxb45ZaJD3NaNlgbBxtdJIiVaJcegoIWwPAnCempZjAJedqnZmmIhVU7uAniZ3j0ymWE/8Y76BlEonPBi9NCbG06lqcyLUDWtVzyvoI/wEAohaKpWVwBpf0fOmE8sSHIT34/i2VQBps+Wc4QFdE4NEalX91bdKcyjpC9l95d2CeaLlExImnMuHrz6up0tVJBZN6Ihkhv3C7CiEF99IAECQtKo7j+OeiLG1yejK0T9GrPQXJ6rHGkCBt3pOyxIwmnugXhmYAvtW5cTZkS2Z+1HuJQtIfUpr+OEd673z/YOqd1iOq6M6AahGAdXfsekSzNU24f+iW7Yf4A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa1a8c6-9361-4b04-0e3e-08db9db143dd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 17:01:27.9356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZReb80OgjiYnBtD115YwhU3mOjdggawBo3PWYMuRrGmpoCET5Xu4gkKEoyrcU5uGZ2Ns7j1Stg9RzGsdi8GC35+CWGfsdk7LRu+tmlx2zI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6705
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-15_16,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=841 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308150152
X-Proofpoint-GUID: BMUj62zUXri5bb_tjDGUuMA_oDt3qBvr
X-Proofpoint-ORIG-GUID: BMUj62zUXri5bb_tjDGUuMA_oDt3qBvr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


> On 8/15/23 7:19 AM, Jose E. Marchesi wrote:
>> Hello.
>> The selftest progs/verifier_masking.c contains inline assembly code
>> like:
>>    	w1 = 0xffffffff;
>> The 32-bit immediate of that instruction is signed.  Therefore, GAS
>> complains that the above instruction overflows its field:
>>    /tmp/ccNOXFQy.s:46: Error: signed immediate out of range, shall
>> fit in 32 bits
>> The llvm assembler is likely relying on signed overflow for the
>> above to
>> work.
>
> Not really.
>
>   def _ri_32 : ALU_RI<BPF_ALU, Opc, off,
>                    (outs GPR32:$dst),
>                    (ins GPR32:$src2, i32imm:$imm),
>                    "$dst "#OpcodeStr#" $imm",
>                    [(set GPR32:$dst, (OpNode GPR32:$src2,
>                    i32immSExt32:$imm))]>;
>
>
> If generating from source, the pattern [(set GPR32:$dst, (OpNode
> GPR32:$src2, i32immSExt32:$imm))] so value 0xffffffff is not SExt32
> and it won't match and eventually a LDimm_64 insn will be generated.

If by "generating from source" you mean compiling from C, then sure, I
wasn't implying clang was generating `r1 = 0xffffffff' for assigning
that positive value to a register.

> But for inline asm, we will have
>   (outs GPR32:$dst)
>   (ins GPR32:$src2, i32imm:$imm)
>
> and i32imm is defined as
>   def i32imm : Operand<i32>;
> which is a unsigned 32bit value, so it is recognized properly
> and the insn is encoded properly.

We thought the imm32 operand in ALU instructions is signed, not
unsigned.  Is it really unsigned??

>> Using negative numbers to denote masks is ugly and obfuscating (for
>> non-obvious cases like -1/0xffffffff) so I suggest we introduce a
>> pseudo-op so we can do:
>>     w1 = %mask(0xffffffff)
>
> I changed above
>   w1 = 0xffffffff;
> to
>   w1 = %mask(0xffffffff)
> and hit the following compilation failure.
>
> progs/verifier_masking.c:54:9: error: invalid % escape in inline
> assembly string
>    53 |         asm volatile ("                                 \
>       |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    54 |         w1 = %mask(0xffffffff);                         \
>       |                ^
> 1 error generated.
>
> Do you have documentation what is '%mask' thing?

It doesn't exist.

I am suggesting to add support for that pseudo-op to the BPF assemblers:
both GAS and the llvm BPF assembler.

>> allowing the assembler to do the right thing (TM) converting and
>> checking that the mask is valid and not relying on UB.
>> Thoughts?
>> 

