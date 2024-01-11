Return-Path: <bpf+bounces-19361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5EC82AC15
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 11:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D7F5B23041
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 10:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286C11426C;
	Thu, 11 Jan 2024 10:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TF8TCe9S";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jbvNnZae"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB98F14278
	for <bpf@vger.kernel.org>; Thu, 11 Jan 2024 10:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40B7i73K007726;
	Thu, 11 Jan 2024 10:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Oe78wzTXfTwR4tLecssfKdSJGGffLm9dyoBINRmrDj0=;
 b=TF8TCe9SMfAKu9djDR/nccxmkVKah8MmAYrSxk9NM9VDj5PGsJ9lcZMvc1S9tr5l25iR
 mFY0/mC2ofHImD/g8hj9pqh5zOeY8Z6rVmXvu09ZaYyv8sb0ruwDjY2yzv1o+oclLjLZ
 zO4hXI7vFyIOeUA/5+F/pL1O7CslzMumJSb/0VrCqRbXGBU5EWy8C8APvV//2ekkSSjn
 Dkh8HqRxS5TZ7rKnpbtcS1okwwPVcHCoZnPuZ9f9G9i157XcJVCNMxziA7erHJAWbdrA
 1Ce1+BEXM5/f0dzb+6iSruLjwg61EfEYZLJEgsf+ZJvCoZQlUeR5WeRNCy3gbloXsHD8 kg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vjbc2rbj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 10:34:35 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40BA1sM5014048;
	Thu, 11 Jan 2024 10:34:34 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vfurednsm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 10:34:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSpPqXEFEjaG87qcvpEdPsP6wctB9c+8UuTRN8EqwIOCJxvz2IoK2OThYdZ2heTf+Aoh8VyYOFQBSGQEm3z3L3MGOO4CVJuZx+QnHhRYx9Mb1vLlwt/UEIcg8mFZ5zQru9Urbva1Qvw35c84bwL4DUTrvzkTGFa+LGREZL6QHDgbZxw/5TTVGgZGTS3AGVZY6jyBZLjABiAovieYrGzLHRd6CHsQ6KpcdLxkyj2a9spvtpo/HSTWULtWlj3mh+TE/kGHSlYeYtVmIc48aEU4vgXMrskKAn2MV4E26dCaw7Y7340bfYuMLFg9iZf8eU9+hnJ8Ea9OdE7vkonD8Hyhpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oe78wzTXfTwR4tLecssfKdSJGGffLm9dyoBINRmrDj0=;
 b=FEVMnB5CKGX+eG/DFv7WLajjlIA/iyjeaJ4kEw/zcDSLJbsdrm3IE/jkTBs8grGxpICn+TrXZO2/gqmG0vFwZLQyMv5m5L/V+s1cEd/Ur+bUlr+Kag+yUW2yIKwfgNAgdMBPmLUjmp6uVquifwsGgBhAGiCp6KlfsnARIKVBXaBIx1WOVg+3uMG7isnlDROZW2IbpxpJ9lKHwJM7IJxtyQzbSNU9Lu7hWULENfuatV988XnNV3ik2N+25RkJ3ilIskBTVaDHD03cXjwWvnH0QlYJd0iO+plxPabnEQTp4TeqZSYjJTjwOxtMBWdqzTgF4rSwr7/04eVXt7llzvkV4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oe78wzTXfTwR4tLecssfKdSJGGffLm9dyoBINRmrDj0=;
 b=jbvNnZaeC1bdV1CbM175U2P7xSDe/cA4uWs/LLEkMvXQDRk3UmNtZoGB/QSbFACA2flmI9aJoFAWMPyETgDhUt1KGaSNB+xk8o5ZZTKwssmIvrf1/wK0rEo27/COO5x8UHuVBrGU4TCk6eea619iRTwkt9QTdHsof0PnAeoABjg=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by SJ0PR10MB4592.namprd10.prod.outlook.com (2603:10b6:a03:2d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 10:34:32 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::a45d:77b4:ce0c:9146]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::a45d:77b4:ce0c:9146%7]) with mapi id 15.20.7159.020; Thu, 11 Jan 2024
 10:34:32 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
        "Jose E. Marchesi"
 <jemarch@gnu.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Yonghong
 Song <yonghong.song@linux.dev>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>,
        John Fastabend
 <john.fastabend@gmail.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team
 <kernel-team@fb.com>
Subject: Re: asm register constraint. Was: [PATCH v2 bpf-next 2/5] bpf:
 Introduce "volatile compare" macro
In-Reply-To: <CAADnVQK54oAjfKtciJ5Z4fwChUDUC_1HYkodzwDzJR42GSun1w@mail.gmail.com>
	(Alexei Starovoitov's message of "Wed, 10 Jan 2024 18:46:29 -0800")
References: <20231221033854.38397-1-alexei.starovoitov@gmail.com>
	<20231221033854.38397-3-alexei.starovoitov@gmail.com>
	<CAP01T77fbW-9N+Z-2LFS=174HN6v_OJAbR_s6EOfLLW8Oceh_g@mail.gmail.com>
	<CAADnVQKY4hB4quJX_oyq4GULEJkehXWx6uW1nAYHveyvdyG8sw@mail.gmail.com>
	<CAADnVQ+tYBpt_aRG5aU3sAYEysKxUOKQ24dBG4bP2kLy8nmmgA@mail.gmail.com>
	<44a9223b6638673487850eb9d70cc01ef58e9d93.camel@gmail.com>
	<CAADnVQLmXxn9RrniktuW80XO14oyOmgJ_NboBBC_-CU4O=-v9g@mail.gmail.com>
	<87h6jm6atm.fsf@oracle.com>
	<CAADnVQK54oAjfKtciJ5Z4fwChUDUC_1HYkodzwDzJR42GSun1w@mail.gmail.com>
Date: Thu, 11 Jan 2024 11:34:28 +0100
Message-ID: <87v880upjf.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0245.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::16) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|SJ0PR10MB4592:EE_
X-MS-Office365-Filtering-Correlation-Id: fd30376b-01e0-4eb8-d8aa-08dc1290e5e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	i/aJ6eYZsF+sd8XD5ny4hKxODC+8Kw4EzTjTdBu9myxJwpArrnH+gD7rER2uETC3JcAo3aCgV59dj3csCE/hB2EhZwXOX4iuYynb2WfzDwYcjUgcUPsRDJ2+fHnNoK1jKBeMsyhletl0VtfJiFfn5FYYITdX12yhu22a7QYKecAxYeN377kIlNa5jwlykPe0awBatgocRSJQSxynDTuetAWE/6B0FuUxWdRZlLWqgR1oSVlu+ZeFwa3FPu5BiohCVHBOivK4gbkzxPXhzLTSdkx1sLJ7YvtfUSea0cjh7TaEkEbF5n4IWS+or5NJpYgOCmw4P5iqDmEFX5OMiIVQQlGNxOSdDyyviGTDOZVtaNsH4GL6Lwkd5gF5C6+1KtHHgDr3RJG78HMxNEpEupLMSX1GhJZ5PsNi8O4bTWTk+NeND7qV++7GO/MmxH33hqQSO0NUX3T0LDH807Y21HKKs0HNgi1YtdlT1pj7CV+Qf3JzPK0dMl8/JI3UBNlB0/LXffXcspx0i/8bCjyo7K/3ACVBR+2Lslg9vNkyPEGdw3EnMSEhHFqyWtq+fTpSy/z9
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(366004)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2906002)(38100700002)(5660300002)(36756003)(2616005)(26005)(4326008)(6512007)(6506007)(53546011)(41300700001)(6666004)(478600001)(86362001)(7416002)(54906003)(66946007)(8936002)(8676002)(6486002)(66556008)(66476007)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aHBFbFFERHJqUHV6ZlpPc2kxaTNQUmNQNTUxN1dzVWNPZGlBb2c1Y3Avb0V2?=
 =?utf-8?B?L1plc2NTZG9SRXlJcGxzYzdndkthTTU3Skh0c2l5SVRSMGNBeklKa1gyZDdz?=
 =?utf-8?B?SFZGS3RCZC90TEpIazU1VmFNZjQ2QzhNMlFWVEFCbDRCMkFHWUVrVWJaNmJj?=
 =?utf-8?B?UUtWbWVGL1RVMTVsY2t1b3JkTWVIWmZIZEN2VEVLR3FyTmwrcXE2SHY2dHZq?=
 =?utf-8?B?VjBTRXZRc2lzekVKbER0MUJzNy9nc0tzeGlYVEhmK2NRSDNCMVRhOUg4VGFU?=
 =?utf-8?B?YU90V29DZy82WXBveW9mSHpoUGQ0Y2hESktFWnF5ZHVOUloxMmVNTGhjRVRH?=
 =?utf-8?B?ZFRVeGRUc0pjbHJ4dDlyZm9rUjk0WXpBQ0pjNXdwMGM2Qm9PZ3MxN2ptb0Fk?=
 =?utf-8?B?NUdNYzR6bFZXVzNGNjBON0JXQkNleTYvNlNHMTg1SUQwUjllU1RlYUs1SmFW?=
 =?utf-8?B?UUd5WW1RSEI0bFpSaU5naWdPeWpIOEVKMUswUE96MEJDaU5ZQnRSNVlycXVE?=
 =?utf-8?B?NGw5RXFtYXdEbXZzWjFTcDJXbXRsQStmTnFxZGFxeUtjNmxzbUNJQWtIejQx?=
 =?utf-8?B?OWhxZjZJVkhtcWNnRDRNa1YrZTZuYnczcTFlRzZCRjZIRGlCMy9QdHk2ZE1n?=
 =?utf-8?B?VEFoeENVNWZUUnJZOVBycSs1RjE3eU9pUWJUUEhYYXh5V1NteUhLMHBoY1lz?=
 =?utf-8?B?MHdWamo2aWtoR1RIcDZ1VWdWZXBrV0c3N1Y3UUYvbU9ZVFJZWElpOFZGdnNo?=
 =?utf-8?B?M0pESWlRZjF5MFhUSGw2SHducDBrV2FRZ3NMZjZucVZLcG5kVmJHd2U0MXF4?=
 =?utf-8?B?cUljSlcvdTdkSjErQ3Z3c1JRdDN4VHQ0cnZjTFEvd1UrNkNKN0NBTGRRT2k1?=
 =?utf-8?B?SEluYmdHTzU2Z0hZTzU3cG5xQk1DNThQS3NSL0Z1MWJLbUZXbXpwNmZwUnVk?=
 =?utf-8?B?dmE2Ry9wR0dMZk1ZR1pHaVVTRTNNR2cvUFBWZTdDcWV3d1ltZXpQeWd3WmUx?=
 =?utf-8?B?bHJVV0FPR1lsWE9RRWQ0VE00Zy8rQTFQK3ltU25ZRVFXemVXM1Q1ZExsdlR5?=
 =?utf-8?B?YlI5OVpsQjczdzhxcjJYYXIwNmlOeitTSG5RREVYNm4vOEx6ek1WWXh5aFdB?=
 =?utf-8?B?VVhMMk9OdHZOcWwxWGcxL3pkUWVMNS95MjdIY0ZUY1l6SkNiNjEzTHRoeWF6?=
 =?utf-8?B?anp0RmV1M2loTjhrc3F3SW50dTFueDMwaTNwY0dncU50QTJzVWJYcXNBVkR5?=
 =?utf-8?B?TkhHdWVoMGhBaWFoSHpnOHNsMXJHZEk4aVVMeUJzU1k1bGh1OFJ0cHd1WFhi?=
 =?utf-8?B?Y3p1eEtxRmJWYkN3Qk4xenhMS3h1TE1KZ1FtbFBmc0ZsaXF0Qm1mcmJibkMw?=
 =?utf-8?B?em5oTEpBR3RHRE5DZnY0QjNVRnNpd1hqek9SL08xUG9EckF1Qk5YOVFFN0xY?=
 =?utf-8?B?Yld5V3M0MnJ3d0VEcmdlc0ltY0pBL2c5TjFTT2dMOEMvYUgrUE0xMTNNZHVD?=
 =?utf-8?B?S2hkMFUweGlzU2RpOGJiSU5BSXY0YWJmSVdESHp3OHk4UDdOalNSaDdYVFhq?=
 =?utf-8?B?RkpURjNhUm5PZTBuNzNoTCtRWXJzTWxMSzBSMmRuR3A1QVdrd1lFaW9xSUJD?=
 =?utf-8?B?YzZSampqTDVkWHArWE1qNnF0aXE1cWJTcTUvT0xvMStyamJKS2hGd0E1UXZm?=
 =?utf-8?B?OUNFbXJPRXVVSkRPZDJadjJjTW1TRDlQbXBlV3cwVjJzZ0Yxd09XTzdkUmxz?=
 =?utf-8?B?dmhOMmI5dlpwQ01wVmxnMkJ1WklPTVhHTzMzczJxMU1CcEtZSHNHWkZNc1c3?=
 =?utf-8?B?NnlqK1Z0Y01DUHlkUE5ScGMvZHRibUl1KytkL3VURmNTblZMcXdIeFhLWFRo?=
 =?utf-8?B?dmYxdUVkYXlTMDljQmlYWXlZbkMzWmNHOTZVVVBQOXVTbmU5R1BTcjNpVy95?=
 =?utf-8?B?STNRNE1tSFVFUHl1VzNqOVFTNUtKcHdHVXQrL1VtTi9aM0VCcEM5V05mLzJF?=
 =?utf-8?B?WnBWcTYvM1E4UXZ5YXlSdVgyb1YrNXBFM2VaK3VuNHdVRGx6dEljSnJtVHJl?=
 =?utf-8?B?L29OSWJKYlVWQ1QvbW5DMnJMUm9GUmVzL0ZkVEcwbXJ0YnExdlFJUmJaZlIr?=
 =?utf-8?B?b2xFS1p5eUF2LzRzaTVxQ0FzaHZDNnpVUXdxNlh2dWdqdzBoOHR3S0VjbjNV?=
 =?utf-8?B?ZlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0CPY6zex2K1CFpAriEZlL3+8lY5ggrZ0OENb+51IHPUYeg5+XLNQN51JB0uCeKgHTeR9FBwXffmvQRBroJ4xJ008ZUCrEmw9IhIeOsnSB6CPAhf2wVmV1zzqry+YlpPj9POXzTOB1InQR9XW7wpGl4zBWlUduPXuRZRCNZKPI4/lDB8OpOPLP5EkA+ay2yrRzu6AtruIyRIIy2fT8O84/HUCG1BvRYq0oyJN/FdpSSeAFOEzKMAewJdYq+PoW9xVzzOOeYsDQSSYnWxZz5xfuaGYDLoLqdqAfmET4ojeq0ke1MjMmLs1tCx/vF4aqALveZyQDbGq61h/lzEmr2chPYQY4NDkocxCRLBLBYob8wLsCORHK8oOtRUWCnzsT7cjLYu8rgntufNE/1Tz9/rWum1N7GcKXHHLoBvEGA/jCGMiGRa616VYoyx7VjSFOBBQesUoLr8tkzA8EQHptbDyrYGYykMEyHbruZb/aIMDtEI7otCxBSDFNKJ3DHSUknVNUG1zETyM/BW7PO3QTZAuP5YXQTnlMVBeG2IXLg0E7VGcNd+mwbGG7TUJN15Ihn5npNt6tlHfTXMWpPnqICOWlPDuIh2QyfaaRCNTdRphSi8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd30376b-01e0-4eb8-d8aa-08dc1290e5e9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 10:34:32.4197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /qlbI0T1qzp3zlTQWpC4xsMjTkJA5DlFFZ+NJUosoxIKpxUbgf3Gg1Z9cCzoXVMSbeNsUfE0yEY/4AUI+Ombi6fV0YGCMSo1AO9Kl0DsbJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4592
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-11_05,2024-01-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401110085
X-Proofpoint-GUID: rq2G7pfdAa4i_UfATfKyP8T141RPLgUY
X-Proofpoint-ORIG-GUID: rq2G7pfdAa4i_UfATfKyP8T141RPLgUY


> On Tue, Jan 9, 2024 at 3:00=E2=80=AFAM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
>>
>> >
>> > Also need to align with GCC. (Jose cc-ed)
>>
>> GCC doesn't have an integrated assembler, so using -masm=3Dpseudoc it ju=
st
>> compiles the program above to:
>>
>>   foo:
>>         call bar
>>         r0 +=3D 1
>>         exit
>>
>> Also, at the moment we don't support a "w" constraint, because the
>> assembly-like assembly syntax we started with implies different
>> instructions that interpret the values stored in the BPF 64-bit
>> registers as 32-bit or 64-bit values, i.e.
>>
>>   mov %r1, 1
>>   mov32 %r1, 1
>
> Heh. gcc tried to invent a traditional looking asm for bpf and instead
> invented the above :)

Very funny, but we didn't invent it.  We took it from ubpf.

> x86 and arm64 use single 'mov' and encode sub-registers as rax/eax or
> x0/w0.

Yes both targets support specifying portions of the 64-bit registers
using pseudo-register names, which is a better approch vs. using
explicit mnemonics for the 32-bit operations (mov32, add32, etc) because
it makes it possible to specify which instruction to use in a
per-operand basis, like making the mode of actually passed arguments in
inline assembly to influence the operation to be performed.

It is nice to have it also in BPF.

> imo support of gcc-only asm style is an obstacle in gcc-bpf adoption.
> It's not too far to reconsider supporting this. You can easily
> remove the support and it will reduce your maintenance/support work.
> It's a bit of a distraction in this thread too.
>
>> But then the pseudo-c assembly syntax (that we also support) translates
>> some of the semantics of the instructions to the register names,
>> creating the notion that BPF actually has both 32-bit registers and
>> 64-bit registers, i.e.
>>
>>   r1 +=3D 1
>>   w1 +=3D 1
>>
>> In GCC we support both assembly syntaxes and currently we lack the
>> ability to emit 32-bit variants in templates like "%[reg] +=3D 1", so I
>> suppose we can introduce a "w" constraint to:
>>
>> 2. When pseudo-c assembly syntax is used, expect a 32-bit mode to match
>>    the operand and warn about operand size overflow whenever necessary,
>>    and then emit "w" instead of "r" as the register name.
>
> clang supports "w" constraint with -mcpu=3Dv3,v4 and emits 'w'
> as register name.
>
>> > And, the most importantly, we need a way to go back to old behavior,
>> > since u32 var; asm("...":: "r"(var)); will now
>> > allocate "w" register or warn.
>>
>> Is it really necessary to change the meaning of "r"?  You can write
>> templates like the one triggering this problem like:
>>
>>   asm volatile ("%[reg] +=3D 1"::[reg]"w"((unsigned)bar()));
>>
>> Then the checks above will be performed, driven by the particular
>> constraint explicitly specified by the user, not driven by the type of
>> the value passed as the operand.
>
> That's a good question.
> For x86 "r" constraint means 8, 16, 32, or 64 bit integer.
> For arm64 "r" constraint means 32 or 64 bit integer.
>
> and this is traditional behavior of "r" in other asms too:
> AMDGPU - 32 or 64
> Hexagon - 32 or 64
> powerpc - 32 or 64
> risc-v - 32 or 64
> imo it makes sense for bpf asm to align with the rest so that:

Yes you are right and I agree.  It makes sense to follow the established
practice where "r" can lead to any pseudo-register name depending on the
mode of the operand, like in x86_64:

   char     -> %al
   short    -> %ax
   int      -> %eax
   long int -> %rax

And then add diagnostics conditioned on the availability of 32-bit
instructions (alu32).

>
> asm volatile ("%[reg] +=3D 1"::[reg]"r"((unsigned)bar())); would generate
> w0 +=3D 1, NO warn (with -mcpu=3Dv3,v4; and a warn with -mcpu=3Dv1,v2)
>
> asm volatile ("%[reg] +=3D 1"::[reg]"r"((unsigned long)bar()));
> r0 +=3D 1, NO warn
>
> asm volatile ("%[reg] +=3D 1"::[reg]"w"((unsigned)bar()));
> w0 +=3D 1, NO warn
>
> asm volatile ("%[reg] +=3D 1"::[reg]"w"((unsigned long)bar()));
> w0 +=3D 1 and a warn (currently there is none in clang)

Makes sense to me.

> I think we can add "R" constraint to mean 64-bit register only:
>
> asm volatile ("%[reg] +=3D 1"::[reg]"R"((unsigned)bar()));
> r0 +=3D 1 and a warn
>
> asm volatile ("%[reg] +=3D 1"::[reg]"R"((unsigned long)bar()));
> r0 +=3D 1, NO warn

The x86 target has similar constraints "q" (for %Rl registers) and "Q"
(for %Rh registers) but not for 32 and 64 pseudo-registers that I can
see.

