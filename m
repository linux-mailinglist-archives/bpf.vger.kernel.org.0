Return-Path: <bpf+bounces-16544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D152D8025F9
	for <lists+bpf@lfdr.de>; Sun,  3 Dec 2023 18:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A741F21128
	for <lists+bpf@lfdr.de>; Sun,  3 Dec 2023 17:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E657817728;
	Sun,  3 Dec 2023 17:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F4YKSqs4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Vp5w2wOr"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010ACDB;
	Sun,  3 Dec 2023 09:29:48 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B3HI3OX003658;
	Sun, 3 Dec 2023 17:28:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=667eJT/OzAaNh0zm9jS1vI3euhojnH91TG5IH7LeY84=;
 b=F4YKSqs4B8Sg24twnXRpROKCPIa7AIf7RBYaEPzexg9+gzsfQgVCeZ/Fe4c/fK3MVh2U
 yUeccypIK/Rwtl7neMeBbxg7jSHhVJrnZ8bRQYcVhp49rBnaniMSs8MdAdU3OQgmZ+w5
 sidLKmylqriE1GAW4XQpKoveyT+yb9of7APxEtJJjgRb1iw/rG+i7QyxUcUp3zPrdE4L
 w5BmBM9fO4dSpKjVdc+aPEHpkOn4FColHdIJJivj6/VQv240/nbwV2tIqPQzxuf/ZP+r
 OEOJgLC2MR0tb6ku1/ssgbq1cUsb0fIZ8kh6Y5LpRcBX/cwF+MIpcgri2y9Cmo2Qk27h QA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3urvmv03rp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 03 Dec 2023 17:28:51 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B3FWSOv014491;
	Sun, 3 Dec 2023 17:28:50 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu14sx3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 03 Dec 2023 17:28:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MpW3id7YLoY04kP+DVYB+OnkYRNmIH5LIdy7hat/AdBe3EyNjLT/ydy2+pgvs5vGyE4tUSUzg+GhHZC4jgUyijt5F7QoV6RV5819ZoFB9ZxCqDr7Ri03/66y909GVoN96lPmMGoXQSDcHXOhB+Yk33TVZftl3SVSWiV2VHmvjNNTqVSUkck8OQcIK+7f9gALHBanOAUXYU9/4tinIo0nz69cQe2Y/uiNR35amzOlYaGPrd35ndKnccw2/8VW1Kkrj/4iELe/A3/67lYTTWsZQ8/ew+C19aju4mStv5sc4qsg3CNy4qDQ81w4WRKjPTaj7DHBTUjtZL0ZA6AV4hJ4Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=667eJT/OzAaNh0zm9jS1vI3euhojnH91TG5IH7LeY84=;
 b=LJO+/7aduf1kvmnLDWQTi99NLUsG8No3wXPeI3mO58qu8JNwgUQImBzR9ZFHL8SxaNrJzEcoQQptJnDd8QzKDzQrluz496S1M8Diyp93clSimShyoBJpI7dHudtD6Rlemw6K+ntxJvx3RYm8/nvgBQojCXX84hBEri8IaPEehhkzK9RjGR9iysFxdPM3YP2QD7rpQwIk5ChGCx4DGTk9sHCKxdqtDa5ThHCRmjAv+OMlQTKbTm4AXw7DLKBz1cXc/fjp2PO06KPpcIL4USoQcW0CMkP43cK2ARp6FgknQ67JekjBr+1psTfzkut+/9++bJyaEeZMBbU9QuohjgfcwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=667eJT/OzAaNh0zm9jS1vI3euhojnH91TG5IH7LeY84=;
 b=Vp5w2wOrHfKALr32iVUSJsXh6338qL8Yl90/TqTby4aqjvMUHe14IyMM5JY5xGb4ORNpzMfESaMGwSc+0AtQtWAGW6C1ej1hN8UMoK70JuoZbXR0/ZAt9t1RhKvrlBRYCnaI+73pWcxJKG0IkS+JaOKNrlwL7D7kE10I3EoanPk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH8PR10MB6480.namprd10.prod.outlook.com (2603:10b6:510:22c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.32; Sun, 3 Dec
 2023 17:28:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7046.033; Sun, 3 Dec 2023
 17:28:22 +0000
Date: Sun, 3 Dec 2023 12:28:18 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
        pabeni@redhat.com, jiri@resnulli.us, amritha.nambiar@intel.com,
        donald.hunter@gmail.com, sdf@google.com, horms@kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH net-next] tools: ynl: remove generated user space code
 from git
Message-ID: <ZWy6sv5UyoVW1lHi@tissot.1015granger.net>
References: <20231202211759.343719-1-kuba@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202211759.343719-1-kuba@kernel.org>
X-ClientProxiedBy: CH5P222CA0018.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH8PR10MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c855f64-6c3a-4259-a995-08dbf4253f3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	pJCCu8MGYk95JXxua7urc20J2apJqvpFiqQD6E4mDhY6TFVgk69AvTyfuxGzDbIyu24LSCuvVAwdJNKIoaxbfFM2phcKXamwKE++tV62W+8J77n+3occbkzcyqJHqU/Ca5bufbG/Tm6OVX90l3NpTUzQr7T/AdkvdxP/A/btZZKFsppUH0vot1cCUBO7RFWKyFGdsqxgOneWgi2pcL+KFePH5LyFcHP6W/jvUUdLsF3RB0A1mXMXyo7S5TkrYZ9JvoO4FaZu9xX3fhZZWkP3x7O6ZushB06H2CNk3VZ333Vqwtf8u3dYsgTcJbPLMi165qd9B4t6Uggebw89O6Ov39hV25eAvbQ/knmgF6/4/PehP5/MKE0yShnPd9ONLxYor5V1q9sWWiRcUIdIzaAF5pg44yyysWK2JONgIRozo1/K/98ABT+rYgw/VF00cOk+nkC3nay7+e6tWNRXqz/yUFxH6aHrGJSZoUqLUC/VUl9U5qGj1OHtpmoCe/PJrFXM7Ez20NZlPeKFsUi6YqJjUq61iNImcwjmLO8TJEGqIU0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(39860400002)(346002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(38100700002)(26005)(66946007)(66556008)(66476007)(6916009)(316002)(6506007)(6512007)(9686003)(83380400001)(41300700001)(2906002)(478600001)(6486002)(966005)(6666004)(30864003)(7416002)(4326008)(8936002)(8676002)(5660300002)(86362001)(44832011)(559001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zp6maepwPnpFRuG9Q9qX1lacxsXHSwpc5gEuikotrByo553j+xtqR8Q6k2/R?=
 =?us-ascii?Q?rRy0cmmA14Wr0foblukR2bsOtA3sWKJscsNaCZnjDql2UVml7CF6iV9ot7Y8?=
 =?us-ascii?Q?F+ByvTn7CXnFiXjGBU3uGawRVLUmymHUmsc+6KudTEFQRkefWZLf5bG215he?=
 =?us-ascii?Q?qoeMlIGGpe/IG1z2a+TQDq7nVMD4aDXqY4Ave+SLFl1gW41vc4tdPUSlSvD/?=
 =?us-ascii?Q?1EFVm+dJMiutFKHhFCLdn+Cp4Wqdr56xbdzkwQAN9BNeth1L6XSi62Kbd4yu?=
 =?us-ascii?Q?HibxXqz/Q0CQkUtBDZ1WUCyKz7qgiyfghjv7fd9tBIPmeNBBsK1Tqht+9BsR?=
 =?us-ascii?Q?3uXoBiUSVyFQUFtxsU+xtw+KDDdwsJygjTO0dQHTcDRxPQDr0/Jbqw8pZScm?=
 =?us-ascii?Q?J9X41EPjBY61CLjCAO4b7+6rTQwtUfYLxYmojld7L7w0TTNj+hjN3h23IsQj?=
 =?us-ascii?Q?hhSrdTA6t6oejkjdDUTbd/X+rSA56YdSd1dbUgqeeECFvynSVFYUbF5S2PXT?=
 =?us-ascii?Q?QssrZhV0W8mt7Wd8i+co3/jlJ2b3wcPtHhGthWpUbWgQfjxKbEteBZ3lQzhI?=
 =?us-ascii?Q?i/yoYE3n76RL7BhGC7AERnyQjp/NxDkj50mRk0tQfcEVy3uZxMAUgD/Vd8h1?=
 =?us-ascii?Q?Q5VCEo/VoZBjPA6TeQST96coogyZoXXWrmLeQ7ArZQH3BcB/TWB8iJGZRI5V?=
 =?us-ascii?Q?mJig5T7m1UKe0zmUwst8DG7DVZrk2wB+k1Wj+g9Q2S9HyLEkgn/yEbPjmG1x?=
 =?us-ascii?Q?qAuXeKc9a7BD4vlJDHoy32/REXvinNF9oTrze0f9geu7BC7amxidjEuiq/9r?=
 =?us-ascii?Q?iUPHx4GKXpwq9KdouDJBn9S4nd9yPLaf/+cAu9DLE3dnF59Zu10czpzXX8Lk?=
 =?us-ascii?Q?tHri4EhPOSC/DtFnIM0DN19XzfaglSXwVqAhkVrj5IyjT5u2AjDgALTEAkVw?=
 =?us-ascii?Q?YzYAP8G0w+HYP3nPmSOuMTl6d4K7dGme3Vu3rX81pLrbWmHHVcRW1Km8wACS?=
 =?us-ascii?Q?DbaO2MkXPNIeJLmF6hLmDEzF0O46fZsK/PHvU/QbozcxcEaPIvP7641fIIbO?=
 =?us-ascii?Q?PwVCLujecuFmlEwy/+3kqV6qcYEqhk1RskLWOmIQ9oyErSvbXxLWepVC2AHh?=
 =?us-ascii?Q?p4fiLVf3qpqoZvuqus52klkoFkrwY+JQGv9fkv8YnrYElYqmm+RPY+y7Zsz5?=
 =?us-ascii?Q?HFlDTt8YKqd9qTgUe/iZMsz0oA/KU7LLfk0QvWvU52VLMPKqDfPD9dtY5cax?=
 =?us-ascii?Q?tnWl3wQ2KHjICKcdhCmJilq4iqNoQgxlBVBevvNIIn2sF9VVjMASuJu67crd?=
 =?us-ascii?Q?N3uYjGr2sWuSmryg8YaEXYR868jR7pdixtnuIkswPTmGUyDyzF/hBNPMhtof?=
 =?us-ascii?Q?Kb+RAlpGPZbKx+qvb/BdLKaT6ii305C/M9FeqWgf5P5fF5hbwd/22U7ZhBLu?=
 =?us-ascii?Q?RcRfeRsOjP21cqheXyv1Gk2Yz416XvAMnYC1eUhKBhd1gaOnPqdYGQeLiFEm?=
 =?us-ascii?Q?Z+CySz5NLNbcgn7lnrNUK3e8xZEV0zHE3gc2ktxtoBqLANJsYuLttC7t3aWF?=
 =?us-ascii?Q?t6O6L7W8NmJ2f9a/3IM0FqypzB95uPiupekSWw6ht2bSlsQn+e+jThwFShfU?=
 =?us-ascii?Q?7A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?us-ascii?Q?QKcs3y+r0yt/o8vdx3oREdFShcw/CF+0Fp8Fz7YjKCBWZV0ngN58H566ygld?=
 =?us-ascii?Q?Ocxqxvx5d9os0281MW1t28gubc5kxlwAz4Ro3n3oFDnnIhUcIf7GE4RaZnLB?=
 =?us-ascii?Q?d9RG9BhyNHlVu2TmGkH0DHOEEYmmlp7BcZ3qlYxGE6vsK3SYR8X3tSRJps5A?=
 =?us-ascii?Q?udGJf7sFN8BKvanxUefVJcVi1+f+M8+gJrnzMiDBZla74KJJ6RWIropSUlUf?=
 =?us-ascii?Q?dbFwxlsY7qaYKchoHx+ZcPWx2KQ4VUc72mrw2+UAgxb4afEPQlA2uxeJQzLt?=
 =?us-ascii?Q?PJUsW+BJZuVz7VPHFcr0oaBqg6sAk7xSFj5JMZZX+uj7OiY5mFeTvE4N36C2?=
 =?us-ascii?Q?OoEux+H08vgnS+i0Cg8doauOwmxnV8dxGWlJxX7063x7p82+Qf7hD9IFxnbH?=
 =?us-ascii?Q?MUOu7QfOXmA2LrEUNSGeOfhdAe0H0XJa+9I5Kd2CPq0G3+O/PhO8A/XAMsk/?=
 =?us-ascii?Q?4BX6cI/GJQ5eyeUttmSlW0xl3WLD3E/5+t6hEsRlu29IdG/WqcBcTC+eV1iF?=
 =?us-ascii?Q?k/aEA04kpHR278r+P+iVWPjfGUH1qEr9dflda7Mbc7cbqMLgPSgp+jCFst5K?=
 =?us-ascii?Q?3UZ6MK5o1PvaTYh5t960n9NJ5TdpiofZ8Oy++dD+bfum8bsLMulKL429KQam?=
 =?us-ascii?Q?T9bjEOhG1BrKbXjDJIQtIXlk7FdgzoSaM1njCfVcP/oOJKiJHG/s9JPi8jGi?=
 =?us-ascii?Q?ZDnAvQnwOlrw9MQgy8NVpQEaJtolmPTP2+LGn+LeEjmz55HJVUG0W6T2/vGy?=
 =?us-ascii?Q?dmhe/WlnkzQjb8TeVDZ+PAusORcGW0u5Hk2T7mw7+BOiuaLox1GJ2XI4vhRM?=
 =?us-ascii?Q?EVU3jgPcx3+9wXeNXwYoGLeilI2+TjtbBjgvpeRVJ27rRO3IWgE0RNS9eHFF?=
 =?us-ascii?Q?ni9Riae7CAuOxDNfAOnnYiyCr07sjS4LkIu0MkJYh1M5mX4A76dgsauUyf49?=
 =?us-ascii?Q?bT4Xit6CajOCjIEae1Etl/+UXUjWx0qfoBurC9lZkuM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c855f64-6c3a-4259-a995-08dbf4253f3e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2023 17:28:22.1054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RA8dLYv/tkS6s31d0DYDN6hYoIHTWLb+Ym/MPYgpAiy7IWQ1wyWs9PRPOBU/6p7/voeuGigeaWy16aWAY3zc4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6480
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-03_15,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312030138
X-Proofpoint-ORIG-GUID: X2FuhhCdzSOe_91VpfWyb1kpEiysro1s
X-Proofpoint-GUID: X2FuhhCdzSOe_91VpfWyb1kpEiysro1s

On Sat, Dec 02, 2023 at 01:17:59PM -0800, Jakub Kicinski wrote:
> The ynl-generated user space C code is already above 25kLoC
> and is growing.
> 
> The initial reason to commit these files was to make reviewing changes
> to the generator easier. Unfortunately, it has the opposite effect on
> reviewing changes to specs, and we get far more changes to specs
> than to the generator.
> 
> Uncommit those fails, as they are generated on the fly as needed.
> netdev patchwork now runs a script on each series to create a diff
> of generated code on the fly, for the rare cases when looking at
> it is helpful:
> https://github.com/kuba-moo/nipa/blob/master/tests/series/ynl/ynl.sh
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: jiri@resnulli.us
> CC: amritha.nambiar@intel.com
> CC: donald.hunter@gmail.com
> CC: sdf@google.com
> CC: chuck.lever@oracle.com
> CC: horms@kernel.org
> CC: bpf@vger.kernel.org

Acked-by: Chuck Lever <chuck.lever@oracle.com>


> ---
>  tools/net/ynl/generated/.gitignore       |    2 +
>  tools/net/ynl/generated/devlink-user.c   | 6864 ----------------------
>  tools/net/ynl/generated/devlink-user.h   | 5255 -----------------
>  tools/net/ynl/generated/ethtool-user.c   | 6370 --------------------
>  tools/net/ynl/generated/ethtool-user.h   | 5535 -----------------
>  tools/net/ynl/generated/fou-user.c       |  330 --
>  tools/net/ynl/generated/fou-user.h       |  343 --
>  tools/net/ynl/generated/handshake-user.c |  332 --
>  tools/net/ynl/generated/handshake-user.h |  145 -
>  tools/net/ynl/generated/netdev-user.c    |  663 ---
>  tools/net/ynl/generated/netdev-user.h    |  264 -
>  tools/net/ynl/generated/nfsd-user.c      |  203 -
>  tools/net/ynl/generated/nfsd-user.h      |   67 -
>  13 files changed, 2 insertions(+), 26371 deletions(-)
>  create mode 100644 tools/net/ynl/generated/.gitignore
>  delete mode 100644 tools/net/ynl/generated/devlink-user.c
>  delete mode 100644 tools/net/ynl/generated/devlink-user.h
>  delete mode 100644 tools/net/ynl/generated/ethtool-user.c
>  delete mode 100644 tools/net/ynl/generated/ethtool-user.h
>  delete mode 100644 tools/net/ynl/generated/fou-user.c
>  delete mode 100644 tools/net/ynl/generated/fou-user.h
>  delete mode 100644 tools/net/ynl/generated/handshake-user.c
>  delete mode 100644 tools/net/ynl/generated/handshake-user.h
>  delete mode 100644 tools/net/ynl/generated/netdev-user.c
>  delete mode 100644 tools/net/ynl/generated/netdev-user.h
>  delete mode 100644 tools/net/ynl/generated/nfsd-user.c
>  delete mode 100644 tools/net/ynl/generated/nfsd-user.h
> 
> diff --git a/tools/net/ynl/generated/.gitignore b/tools/net/ynl/generated/.gitignore
> new file mode 100644
> index 000000000000..ade488626d26
> --- /dev/null
> +++ b/tools/net/ynl/generated/.gitignore
> @@ -0,0 +1,2 @@
> +*-user.c
> +*-user.h
> diff --git a/tools/net/ynl/generated/devlink-user.c b/tools/net/ynl/generated/devlink-user.c
> deleted file mode 100644
> index 8e757e249dab..000000000000
> --- a/tools/net/ynl/generated/devlink-user.c
> +++ /dev/null
> @@ -1,6864 +0,0 @@
> -// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> -/* Do not edit directly, auto-generated from: */
> -/*	Documentation/netlink/specs/devlink.yaml */
> -/* YNL-GEN user source */
> -
> -#include <stdlib.h>
> -#include <string.h>
> -#include "devlink-user.h"
> -#include "ynl.h"
> -#include <linux/devlink.h>
> -
> -#include <libmnl/libmnl.h>
> -#include <linux/genetlink.h>
> -
> -/* Enums */
> -static const char * const devlink_op_strmap[] = {
> -	[3] = "get",
> -	// skip "port-get", duplicate reply value
> -	[DEVLINK_CMD_PORT_NEW] = "port-new",
> -	[13] = "sb-get",
> -	[17] = "sb-pool-get",
> -	[21] = "sb-port-pool-get",
> -	[25] = "sb-tc-pool-bind-get",
> -	[DEVLINK_CMD_ESWITCH_GET] = "eswitch-get",
> -	[DEVLINK_CMD_DPIPE_TABLE_GET] = "dpipe-table-get",
> -	[DEVLINK_CMD_DPIPE_ENTRIES_GET] = "dpipe-entries-get",
> -	[DEVLINK_CMD_DPIPE_HEADERS_GET] = "dpipe-headers-get",
> -	[DEVLINK_CMD_RESOURCE_DUMP] = "resource-dump",
> -	[DEVLINK_CMD_RELOAD] = "reload",
> -	[DEVLINK_CMD_PARAM_GET] = "param-get",
> -	[DEVLINK_CMD_REGION_GET] = "region-get",
> -	[DEVLINK_CMD_REGION_NEW] = "region-new",
> -	[DEVLINK_CMD_REGION_READ] = "region-read",
> -	[DEVLINK_CMD_PORT_PARAM_GET] = "port-param-get",
> -	[DEVLINK_CMD_INFO_GET] = "info-get",
> -	[DEVLINK_CMD_HEALTH_REPORTER_GET] = "health-reporter-get",
> -	[DEVLINK_CMD_HEALTH_REPORTER_DUMP_GET] = "health-reporter-dump-get",
> -	[63] = "trap-get",
> -	[67] = "trap-group-get",
> -	[71] = "trap-policer-get",
> -	[76] = "rate-get",
> -	[80] = "linecard-get",
> -	[DEVLINK_CMD_SELFTESTS_GET] = "selftests-get",
> -};
> -
> -const char *devlink_op_str(int op)
> -{
> -	if (op < 0 || op >= (int)MNL_ARRAY_SIZE(devlink_op_strmap))
> -		return NULL;
> -	return devlink_op_strmap[op];
> -}
> -
> -static const char * const devlink_sb_pool_type_strmap[] = {
> -	[0] = "ingress",
> -	[1] = "egress",
> -};
> -
> -const char *devlink_sb_pool_type_str(enum devlink_sb_pool_type value)
> -{
> -	if (value < 0 || value >= (int)MNL_ARRAY_SIZE(devlink_sb_pool_type_strmap))
> -		return NULL;
> -	return devlink_sb_pool_type_strmap[value];
> -}
> -
> -static const char * const devlink_port_type_strmap[] = {
> -	[0] = "notset",
> -	[1] = "auto",
> -	[2] = "eth",
> -	[3] = "ib",
> -};
> -
> -const char *devlink_port_type_str(enum devlink_port_type value)
> -{
> -	if (value < 0 || value >= (int)MNL_ARRAY_SIZE(devlink_port_type_strmap))
> -		return NULL;
> -	return devlink_port_type_strmap[value];
> -}
> -
> -static const char * const devlink_port_flavour_strmap[] = {
> -	[0] = "physical",
> -	[1] = "cpu",
> -	[2] = "dsa",
> -	[3] = "pci_pf",
> -	[4] = "pci_vf",
> -	[5] = "virtual",
> -	[6] = "unused",
> -	[7] = "pci_sf",
> -};
> -
> -const char *devlink_port_flavour_str(enum devlink_port_flavour value)
> -{
> -	if (value < 0 || value >= (int)MNL_ARRAY_SIZE(devlink_port_flavour_strmap))
> -		return NULL;
> -	return devlink_port_flavour_strmap[value];
> -}
> -
> -static const char * const devlink_port_fn_state_strmap[] = {
> -	[0] = "inactive",
> -	[1] = "active",
> -};
> -
> -const char *devlink_port_fn_state_str(enum devlink_port_fn_state value)
> -{
> -	if (value < 0 || value >= (int)MNL_ARRAY_SIZE(devlink_port_fn_state_strmap))
> -		return NULL;
> -	return devlink_port_fn_state_strmap[value];
> -}
> -
> -static const char * const devlink_port_fn_opstate_strmap[] = {
> -	[0] = "detached",
> -	[1] = "attached",
> -};
> -
> -const char *devlink_port_fn_opstate_str(enum devlink_port_fn_opstate value)
> -{
> -	if (value < 0 || value >= (int)MNL_ARRAY_SIZE(devlink_port_fn_opstate_strmap))
> -		return NULL;
> -	return devlink_port_fn_opstate_strmap[value];
> -}
> -
> -static const char * const devlink_port_fn_attr_cap_strmap[] = {
> -	[0] = "roce-bit",
> -	[1] = "migratable-bit",
> -	[2] = "ipsec-crypto-bit",
> -	[3] = "ipsec-packet-bit",
> -};
> -
> -const char *devlink_port_fn_attr_cap_str(enum devlink_port_fn_attr_cap value)
> -{
> -	if (value < 0 || value >= (int)MNL_ARRAY_SIZE(devlink_port_fn_attr_cap_strmap))
> -		return NULL;
> -	return devlink_port_fn_attr_cap_strmap[value];
> -}
> -
> -static const char * const devlink_sb_threshold_type_strmap[] = {
> -	[0] = "static",
> -	[1] = "dynamic",
> -};
> -
> -const char *devlink_sb_threshold_type_str(enum devlink_sb_threshold_type value)
> -{
> -	if (value < 0 || value >= (int)MNL_ARRAY_SIZE(devlink_sb_threshold_type_strmap))
> -		return NULL;
> -	return devlink_sb_threshold_type_strmap[value];
> -}
> -
> -static const char * const devlink_eswitch_mode_strmap[] = {
> -	[0] = "legacy",
> -	[1] = "switchdev",
> -};
> -
> -const char *devlink_eswitch_mode_str(enum devlink_eswitch_mode value)
> -{
> -	if (value < 0 || value >= (int)MNL_ARRAY_SIZE(devlink_eswitch_mode_strmap))
> -		return NULL;
> -	return devlink_eswitch_mode_strmap[value];
> -}
> -
> -static const char * const devlink_eswitch_inline_mode_strmap[] = {
> -	[0] = "none",
> -	[1] = "link",
> -	[2] = "network",
> -	[3] = "transport",
> -};
> -
> -const char *
> -devlink_eswitch_inline_mode_str(enum devlink_eswitch_inline_mode value)
> -{
> -	if (value < 0 || value >= (int)MNL_ARRAY_SIZE(devlink_eswitch_inline_mode_strmap))
> -		return NULL;
> -	return devlink_eswitch_inline_mode_strmap[value];
> -}
> -
> -static const char * const devlink_eswitch_encap_mode_strmap[] = {
> -	[0] = "none",
> -	[1] = "basic",
> -};
> -
> -const char *
> -devlink_eswitch_encap_mode_str(enum devlink_eswitch_encap_mode value)
> -{
> -	if (value < 0 || value >= (int)MNL_ARRAY_SIZE(devlink_eswitch_encap_mode_strmap))
> -		return NULL;
> -	return devlink_eswitch_encap_mode_strmap[value];
> -}
> -
> -static const char * const devlink_dpipe_match_type_strmap[] = {
> -	[0] = "field-exact",
> -};
> -
> -const char *devlink_dpipe_match_type_str(enum devlink_dpipe_match_type value)
> -{
> -	if (value < 0 || value >= (int)MNL_ARRAY_SIZE(devlink_dpipe_match_type_strmap))
> -		return NULL;
> -	return devlink_dpipe_match_type_strmap[value];
> -}
> -
> -static const char * const devlink_dpipe_action_type_strmap[] = {
> -	[0] = "field-modify",
> -};
> -
> -const char *devlink_dpipe_action_type_str(enum devlink_dpipe_action_type value)
> -{
> -	if (value < 0 || value >= (int)MNL_ARRAY_SIZE(devlink_dpipe_action_type_strmap))
> -		return NULL;
> -	return devlink_dpipe_action_type_strmap[value];
> -}
> -
> -static const char * const devlink_dpipe_field_mapping_type_strmap[] = {
> -	[0] = "none",
> -	[1] = "ifindex",
> -};
> -
> -const char *
> -devlink_dpipe_field_mapping_type_str(enum devlink_dpipe_field_mapping_type value)
> -{
> -	if (value < 0 || value >= (int)MNL_ARRAY_SIZE(devlink_dpipe_field_mapping_type_strmap))
> -		return NULL;
> -	return devlink_dpipe_field_mapping_type_strmap[value];
> -}
> -
> -static const char * const devlink_resource_unit_strmap[] = {
> -	[0] = "entry",
> -};
> -
> -const char *devlink_resource_unit_str(enum devlink_resource_unit value)
> -{
> -	if (value < 0 || value >= (int)MNL_ARRAY_SIZE(devlink_resource_unit_strmap))
> -		return NULL;
> -	return devlink_resource_unit_strmap[value];
> -}
> -
> -static const char * const devlink_reload_action_strmap[] = {
> -	[1] = "driver-reinit",
> -	[2] = "fw-activate",
> -};
> -
> -const char *devlink_reload_action_str(enum devlink_reload_action value)
> -{
> -	if (value < 0 || value >= (int)MNL_ARRAY_SIZE(devlink_reload_action_strmap))
> -		return NULL;
> -	return devlink_reload_action_strmap[value];
> -}
> -
> -static const char * const devlink_param_cmode_strmap[] = {
> -	[0] = "runtime",
> -	[1] = "driverinit",
> -	[2] = "permanent",
> -};
> -
> -const char *devlink_param_cmode_str(enum devlink_param_cmode value)
> -{
> -	if (value < 0 || value >= (int)MNL_ARRAY_SIZE(devlink_param_cmode_strmap))
> -		return NULL;
> -	return devlink_param_cmode_strmap[value];
> -}
> -
> -static const char * const devlink_flash_overwrite_strmap[] = {
> -	[0] = "settings-bit",
> -	[1] = "identifiers-bit",
> -};
> -
> -const char *devlink_flash_overwrite_str(enum devlink_flash_overwrite value)
> -{
> -	if (value < 0 || value >= (int)MNL_ARRAY_SIZE(devlink_flash_overwrite_strmap))
> -		return NULL;
> -	return devlink_flash_overwrite_strmap[value];
> -}
> -
> -static const char * const devlink_trap_action_strmap[] = {
> -	[0] = "drop",
> -	[1] = "trap",
> -	[2] = "mirror",
> -};
> -
> -const char *devlink_trap_action_str(enum devlink_trap_action value)
> -{
> -	if (value < 0 || value >= (int)MNL_ARRAY_SIZE(devlink_trap_action_strmap))
> -		return NULL;
> -	return devlink_trap_action_strmap[value];
> -}
> -
> -/* Policies */
> -struct ynl_policy_attr devlink_dl_dpipe_match_policy[DEVLINK_ATTR_MAX + 1] = {
> -	[DEVLINK_ATTR_DPIPE_MATCH_TYPE] = { .name = "dpipe-match-type", .type = YNL_PT_U32, },
> -	[DEVLINK_ATTR_DPIPE_HEADER_ID] = { .name = "dpipe-header-id", .type = YNL_PT_U32, },
> -	[DEVLINK_ATTR_DPIPE_HEADER_GLOBAL] = { .name = "dpipe-header-global", .type = YNL_PT_U8, },
> -	[DEVLINK_ATTR_DPIPE_HEADER_INDEX] = { .name = "dpipe-header-index", .type = YNL_PT_U32, },
> -	[DEVLINK_ATTR_DPIPE_FIELD_ID] = { .name = "dpipe-field-id", .type = YNL_PT_U32, },
> -};
> -
> -struct ynl_policy_nest devlink_dl_dpipe_match_nest = {
> -	.max_attr = DEVLINK_ATTR_MAX,
> -	.table = devlink_dl_dpipe_match_policy,
> -};
> -
> -struct ynl_policy_attr devlink_dl_dpipe_match_value_policy[DEVLINK_ATTR_MAX + 1] = {
> -	[DEVLINK_ATTR_DPIPE_MATCH] = { .name = "dpipe-match", .type = YNL_PT_NEST, .nest = &devlink_dl_dpipe_match_nest, },
> -	[DEVLINK_ATTR_DPIPE_VALUE] = { .name = "dpipe-value", .type = YNL_PT_BINARY,},
> -	[DEVLINK_ATTR_DPIPE_VALUE_MASK] = { .name = "dpipe-value-mask", .type = YNL_PT_BINARY,},
> -	[DEVLINK_ATTR_DPIPE_VALUE_MAPPING] = { .name = "dpipe-value-mapping", .type = YNL_PT_U32, },
> -};
> -
> -struct ynl_policy_nest devlink_dl_dpipe_match_value_nest = {
> -	.max_attr = DEVLINK_ATTR_MAX,
> -	.table = devlink_dl_dpipe_match_value_policy,
> -};
> -
> -struct ynl_policy_attr devlink_dl_dpipe_action_policy[DEVLINK_ATTR_MAX + 1] = {
> -	[DEVLINK_ATTR_DPIPE_ACTION_TYPE] = { .name = "dpipe-action-type", .type = YNL_PT_U32, },
> -	[DEVLINK_ATTR_DPIPE_HEADER_ID] = { .name = "dpipe-header-id", .type = YNL_PT_U32, },
> -	[DEVLINK_ATTR_DPIPE_HEADER_GLOBAL] = { .name = "dpipe-header-global", .type = YNL_PT_U8, },
> -	[DEVLINK_ATTR_DPIPE_HEADER_INDEX] = { .name = "dpipe-header-index", .type = YNL_PT_U32, },
> -	[DEVLINK_ATTR_DPIPE_FIELD_ID] = { .name = "dpipe-field-id", .type = YNL_PT_U32, },
> -};
> -
> -struct ynl_policy_nest devlink_dl_dpipe_action_nest = {
> -	.max_attr = DEVLINK_ATTR_MAX,
> -	.table = devlink_dl_dpipe_action_policy,
> -};
> -
> -struct ynl_policy_attr devlink_dl_dpipe_action_value_policy[DEVLINK_ATTR_MAX + 1] = {
> -	[DEVLINK_ATTR_DPIPE_ACTION] = { .name = "dpipe-action", .type = YNL_PT_NEST, .nest = &devlink_dl_dpipe_action_nest, },
> -	[DEVLINK_ATTR_DPIPE_VALUE] = { .name = "dpipe-value", .type = YNL_PT_BINARY,},
> -	[DEVLINK_ATTR_DPIPE_VALUE_MASK] = { .name = "dpipe-value-mask", .type = YNL_PT_BINARY,},
> -	[DEVLINK_ATTR_DPIPE_VALUE_MAPPING] = { .name = "dpipe-value-mapping", .type = YNL_PT_U32, },
> -};
> -
> -struct ynl_policy_nest devlink_dl_dpipe_action_value_nest = {
> -	.max_attr = DEVLINK_ATTR_MAX,
> -	.table = devlink_dl_dpipe_action_value_policy,
> -};
> -
> -struct ynl_policy_attr devlink_dl_dpipe_field_policy[DEVLINK_ATTR_MAX + 1] = {
> -	[DEVLINK_ATTR_DPIPE_FIELD_NAME] = { .name = "dpipe-field-name", .type = YNL_PT_NUL_STR, },
> -	[DEVLINK_ATTR_DPIPE_FIELD_ID] = { .name = "dpipe-field-id", .type = YNL_PT_U32, },
> -	[DEVLINK_ATTR_DPIPE_FIELD_BITWIDTH] = { .name = "dpipe-field-bitwidth", .type = YNL_PT_U32, },
> -	[DEVLINK_ATTR_DPIPE_FIELD_MAPPING_TYPE] = { .name = "dpipe-field-mapping-type", .type = YNL_PT_U32, },
> -};
> -
> -struct ynl_policy_nest devlink_dl_dpipe_field_nest = {
> -	.max_attr = DEVLINK_ATTR_MAX,
> -	.table = devlink_dl_dpipe_field_policy,
> -};
> -
> -struct ynl_policy_attr devlink_dl_resource_policy[DEVLINK_ATTR_MAX + 1] = {
> -	[DEVLINK_ATTR_RESOURCE_NAME] = { .name = "resource-name", .type = YNL_PT_NUL_STR, },
> -	[DEVLINK_ATTR_RESOURCE_ID] = { .name = "resource-id", .type = YNL_PT_U64, },
> -	[DEVLINK_ATTR_RESOURCE_SIZE] = { .name = "resource-size", .type = YNL_PT_U64, },
> -	[DEVLINK_ATTR_RESOURCE_SIZE_NEW] = { .name = "resource-size-new", .type = YNL_PT_U64, },
> -	[DEVLINK_ATTR_RESOURCE_SIZE_VALID] = { .name = "resource-size-valid", .type = YNL_PT_U8, },
> -	[DEVLINK_ATTR_RESOURCE_SIZE_MIN] = { .name = "resource-size-min", .type = YNL_PT_U64, },
> -	[DEVLINK_ATTR_RESOURCE_SIZE_MAX] = { .name = "resource-size-max", .type = YNL_PT_U64, },
> -	[DEVLINK_ATTR_RESOURCE_SIZE_GRAN] = { .name = "resource-size-gran", .type = YNL_PT_U64, },
> -	[DEVLINK_ATTR_RESOURCE_UNIT] = { .name = "resource-unit", .type = YNL_PT_U8, },
> -	[DEVLINK_ATTR_RESOURCE_OCC] = { .name = "resource-occ", .type = YNL_PT_U64, },
> -};
> -
> -struct ynl_policy_nest devlink_dl_resource_nest = {
> -	.max_attr = DEVLINK_ATTR_MAX,
> -	.table = devlink_dl_resource_policy,
> -};
> -
> -struct ynl_policy_attr devlink_dl_info_version_policy[DEVLINK_ATTR_MAX + 1] = {
> -	[DEVLINK_ATTR_INFO_VERSION_NAME] = { .name = "info-version-name", .type = YNL_PT_NUL_STR, },
> -	[DEVLINK_ATTR_INFO_VERSION_VALUE] = { .name = "info-version-value", .type = YNL_PT_NUL_STR, },
> -};
> -
> -struct ynl_policy_nest devlink_dl_info_version_nest = {
> -	.max_attr = DEVLINK_ATTR_MAX,
> -	.table = devlink_dl_info_version_policy,
> -};
> -
> -struct ynl_policy_attr devlink_dl_fmsg_policy[DEVLINK_ATTR_MAX + 1] = {
> -	[DEVLINK_ATTR_FMSG_OBJ_NEST_START] = { .name = "fmsg-obj-nest-start", .type = YNL_PT_FLAG, },
> -	[DEVLINK_ATTR_FMSG_PAIR_NEST_START] = { .name = "fmsg-pair-nest-start", .type = YNL_PT_FLAG, },
> -	[DEVLINK_ATTR_FMSG_ARR_NEST_START] = { .name = "fmsg-arr-nest-start", .type = YNL_PT_FLAG, },
> -	[DEVLINK_ATTR_FMSG_NEST_END] = { .name = "fmsg-nest-end", .type = YNL_PT_FLAG, },
> -	[DEVLINK_ATTR_FMSG_OBJ_NAME] = { .name = "fmsg-obj-name", .type = YNL_PT_NUL_STR, },
> -};
> -
> -struct ynl_policy_nest devlink_dl_fmsg_nest = {
> -	.max_attr = DEVLINK_ATTR_MAX,
> -	.table = devlink_dl_fmsg_policy,
> -};
> -
> -struct ynl_policy_attr devlink_dl_port_function_policy[DEVLINK_PORT_FUNCTION_ATTR_MAX + 1] = {
> -	[DEVLINK_PORT_FUNCTION_ATTR_HW_ADDR] = { .name = "hw-addr", .type = YNL_PT_BINARY,},
> -	[DEVLINK_PORT_FN_ATTR_STATE] = { .name = "state", .type = YNL_PT_U8, },
> -	[DEVLINK_PORT_FN_ATTR_OPSTATE] = { .name = "opstate", .type = YNL_PT_U8, },
> -	[DEVLINK_PORT_FN_ATTR_CAPS] = { .name = "caps", .type = YNL_PT_BITFIELD32, },
> -};
> -
> -struct ynl_policy_nest devlink_dl_port_function_nest = {
> -	.max_attr = DEVLINK_PORT_FUNCTION_ATTR_MAX,
> -	.table = devlink_dl_port_function_policy,
> -};
> -
> -struct ynl_policy_attr devlink_dl_reload_stats_entry_policy[DEVLINK_ATTR_MAX + 1] = {
> -	[DEVLINK_ATTR_RELOAD_STATS_LIMIT] = { .name = "reload-stats-limit", .type = YNL_PT_U8, },
> -	[DEVLINK_ATTR_RELOAD_STATS_VALUE] = { .name = "reload-stats-value", .type = YNL_PT_U32, },
> -};
> -
> -struct ynl_policy_nest devlink_dl_reload_stats_entry_nest = {
> -	.max_attr = DEVLINK_ATTR_MAX,
> -	.table = devlink_dl_reload_stats_entry_policy,
> -};
> -
> -struct ynl_policy_attr devlink_dl_reload_act_stats_policy[DEVLINK_ATTR_MAX + 1] = {
> -	[DEVLINK_ATTR_RELOAD_STATS_ENTRY] = { .name = "reload-stats-entry", .type = YNL_PT_NEST, .nest = &devlink_dl_reload_stats_entry_nest, },
> -};
> -
> -struct ynl_policy_nest devlink_dl_reload_act_stats_nest = {
> -	.max_attr = DEVLINK_ATTR_MAX,
> -	.table = devlink_dl_reload_act_stats_policy,
> -};
> -
> -struct ynl_policy_attr devlink_dl_selftest_id_policy[DEVLINK_ATTR_SELFTEST_ID_MAX + 1] = {
> -	[DEVLINK_ATTR_SELFTEST_ID_FLASH] = { .name = "flash", .type = YNL_PT_FLAG, },
> -};
> -
> -struct ynl_policy_nest devlink_dl_selftest_id_nest = {
> -	.max_attr = DEVLINK_ATTR_SELFTEST_ID_MAX,
> -	.table = devlink_dl_selftest_id_policy,
> -};
> -
> -struct ynl_policy_attr devlink_dl_dpipe_table_matches_policy[DEVLINK_ATTR_MAX + 1] = {
> -	[DEVLINK_ATTR_DPIPE_MATCH] = { .name = "dpipe-match", .type = YNL_PT_NEST, .nest = &devlink_dl_dpipe_match_nest, },
> -};
> -
> -struct ynl_policy_nest devlink_dl_dpipe_table_matches_nest = {
> -	.max_attr = DEVLINK_ATTR_MAX,
> -	.table = devlink_dl_dpipe_table_matches_policy,
> -};
> -
> -struct ynl_policy_attr devlink_dl_dpipe_table_actions_policy[DEVLINK_ATTR_MAX + 1] = {
> -	[DEVLINK_ATTR_DPIPE_ACTION] = { .name = "dpipe-action", .type = YNL_PT_NEST, .nest = &devlink_dl_dpipe_action_nest, },
> -};
> -
> -struct ynl_policy_nest devlink_dl_dpipe_table_actions_nest = {
> -	.max_attr = DEVLINK_ATTR_MAX,
> -	.table = devlink_dl_dpipe_table_actions_policy,
> -};
> -
> -struct ynl_policy_attr devlink_dl_dpipe_entry_match_values_policy[DEVLINK_ATTR_MAX + 1] = {
> -	[DEVLINK_ATTR_DPIPE_MATCH_VALUE] = { .name = "dpipe-match-value", .type = YNL_PT_NEST, .nest = &devlink_dl_dpipe_match_value_nest, },
> -};
> -
> -struct ynl_policy_nest devlink_dl_dpipe_entry_match_values_nest = {
> -	.max_attr = DEVLINK_ATTR_MAX,
> -	.table = devlink_dl_dpipe_entry_match_values_policy,
> -};
> -
> -struct ynl_policy_attr devlink_dl_dpipe_entry_action_values_policy[DEVLINK_ATTR_MAX + 1] = {
> -	[DEVLINK_ATTR_DPIPE_ACTION_VALUE] = { .name = "dpipe-action-value", .type = YNL_PT_NEST, .nest = &devlink_dl_dpipe_action_value_nest, },
> -};
> -
> -struct ynl_policy_nest devlink_dl_dpipe_entry_action_values_nest = {
> -	.max_attr = DEVLINK_ATTR_MAX,
> -	.table = devlink_dl_dpipe_entry_action_values_policy,
> -};
> -
> -struct ynl_policy_attr devlink_dl_dpipe_header_fields_policy[DEVLINK_ATTR_MAX + 1] = {
> -	[DEVLINK_ATTR_DPIPE_FIELD] = { .name = "dpipe-field", .type = YNL_PT_NEST, .nest = &devlink_dl_dpipe_field_nest, },
> -};
> -
> -struct ynl_policy_nest devlink_dl_dpipe_header_fields_nest = {
> -	.max_attr = DEVLINK_ATTR_MAX,
> -	.table = devlink_dl_dpipe_header_fields_policy,
> -};
> -
> -struct ynl_policy_attr devlink_dl_resource_list_policy[DEVLINK_ATTR_MAX + 1] = {
> -	[DEVLINK_ATTR_RESOURCE] = { .name = "resource", .type = YNL_PT_NEST, .nest = &devlink_dl_resource_nest, },
> -};
> -
> -struct ynl_policy_nest devlink_dl_resource_list_nest = {
> -	.max_attr = DEVLINK_ATTR_MAX,
> -	.table = devlink_dl_resource_list_policy,
> -};
> -
> -struct ynl_policy_attr devlink_dl_reload_act_info_policy[DEVLINK_ATTR_MAX + 1] = {
> -	[DEVLINK_ATTR_RELOAD_ACTION] = { .name = "reload-action", .type = YNL_PT_U8, },
> -	[DEVLINK_ATTR_RELOAD_ACTION_STATS] = { .name = "reload-action-stats", .type = YNL_PT_NEST, .nest = &devlink_dl_reload_act_stats_nest, },
> -};
> -
> -struct ynl_policy_nest devlink_dl_reload_act_info_nest = {
> -	.max_attr = DEVLINK_ATTR_MAX,
> -	.table = devlink_dl_reload_act_info_policy,
> -};
> -
> -struct ynl_policy_attr devlink_dl_dpipe_table_policy[DEVLINK_ATTR_MAX + 1] = {
> -	[DEVLINK_ATTR_DPIPE_TABLE_NAME] = { .name = "dpipe-table-name", .type = YNL_PT_NUL_STR, },
> -	[DEVLINK_ATTR_DPIPE_TABLE_SIZE] = { .name = "dpipe-table-size", .type = YNL_PT_U64, },
> -	[DEVLINK_ATTR_DPIPE_TABLE_MATCHES] = { .name = "dpipe-table-matches", .type = YNL_PT_NEST, .nest = &devlink_dl_dpipe_table_matches_nest, },
> -	[DEVLINK_ATTR_DPIPE_TABLE_ACTIONS] = { .name = "dpipe-table-actions", .type = YNL_PT_NEST, .nest = &devlink_dl_dpipe_table_actions_nest, },
> -	[DEVLINK_ATTR_DPIPE_TABLE_COUNTERS_ENABLED] = { .name = "dpipe-table-counters-enabled", .type = YNL_PT_U8, },
> -	[DEVLINK_ATTR_DPIPE_TABLE_RESOURCE_ID] = { .name = "dpipe-table-resource-id", .type = YNL_PT_U64, },
> -	[DEVLINK_ATTR_DPIPE_TABLE_RESOURCE_UNITS] = { .name = "dpipe-table-resource-units", .type = YNL_PT_U64, },
> -};
> -
> -struct ynl_policy_nest devlink_dl_dpipe_table_nest = {
> -	.max_attr = DEVLINK_ATTR_MAX,
> -	.table = devlink_dl_dpipe_table_policy,
> -};
> -
> -struct ynl_policy_attr devlink_dl_dpipe_entry_policy[DEVLINK_ATTR_MAX + 1] = {
> -	[DEVLINK_ATTR_DPIPE_ENTRY_INDEX] = { .name = "dpipe-entry-index", .type = YNL_PT_U64, },
> -	[DEVLINK_ATTR_DPIPE_ENTRY_MATCH_VALUES] = { .name = "dpipe-entry-match-values", .type = YNL_PT_NEST, .nest = &devlink_dl_dpipe_entry_match_values_nest, },
> -	[DEVLINK_ATTR_DPIPE_ENTRY_ACTION_VALUES] = { .name = "dpipe-entry-action-values", .type = YNL_PT_NEST, .nest = &devlink_dl_dpipe_entry_action_values_nest, },
> -	[DEVLINK_ATTR_DPIPE_ENTRY_COUNTER] = { .name = "dpipe-entry-counter", .type = YNL_PT_U64, },
> -};
> -
> -struct ynl_policy_nest devlink_dl_dpipe_entry_nest = {
> -	.max_attr = DEVLINK_ATTR_MAX,
> -	.table = devlink_dl_dpipe_entry_policy,
> -};
> -
> -struct ynl_policy_attr devlink_dl_dpipe_header_policy[DEVLINK_ATTR_MAX + 1] = {
> -	[DEVLINK_ATTR_DPIPE_HEADER_NAME] = { .name = "dpipe-header-name", .type = YNL_PT_NUL_STR, },
> -	[DEVLINK_ATTR_DPIPE_HEADER_ID] = { .name = "dpipe-header-id", .type = YNL_PT_U32, },
> -	[DEVLINK_ATTR_DPIPE_HEADER_GLOBAL] = { .name = "dpipe-header-global", .type = YNL_PT_U8, },
> -	[DEVLINK_ATTR_DPIPE_HEADER_FIELDS] = { .name = "dpipe-header-fields", .type = YNL_PT_NEST, .nest = &devlink_dl_dpipe_header_fields_nest, },
> -};
> -
> -struct ynl_policy_nest devlink_dl_dpipe_header_nest = {
> -	.max_attr = DEVLINK_ATTR_MAX,
> -	.table = devlink_dl_dpipe_header_policy,
> -};
> -
> -struct ynl_policy_attr devlink_dl_reload_stats_policy[DEVLINK_ATTR_MAX + 1] = {
> -	[DEVLINK_ATTR_RELOAD_ACTION_INFO] = { .name = "reload-action-info", .type = YNL_PT_NEST, .nest = &devlink_dl_reload_act_info_nest, },
> -};
> -
> -struct ynl_policy_nest devlink_dl_reload_stats_nest = {
> -	.max_attr = DEVLINK_ATTR_MAX,
> -	.table = devlink_dl_reload_stats_policy,
> -};
> -
> -struct ynl_policy_attr devlink_dl_dpipe_tables_policy[DEVLINK_ATTR_MAX + 1] = {
> -	[DEVLINK_ATTR_DPIPE_TABLE] = { .name = "dpipe-table", .type = YNL_PT_NEST, .nest = &devlink_dl_dpipe_table_nest, },
> -};
> -
> -struct ynl_policy_nest devlink_dl_dpipe_tables_nest = {
> -	.max_attr = DEVLINK_ATTR_MAX,
> -	.table = devlink_dl_dpipe_tables_policy,
> -};
> -
> -struct ynl_policy_attr devlink_dl_dpipe_entries_policy[DEVLINK_ATTR_MAX + 1] = {
> -	[DEVLINK_ATTR_DPIPE_ENTRY] = { .name = "dpipe-entry", .type = YNL_PT_NEST, .nest = &devlink_dl_dpipe_entry_nest, },
> -};
> -
> -struct ynl_policy_nest devlink_dl_dpipe_entries_nest = {
> -	.max_attr = DEVLINK_ATTR_MAX,
> -	.table = devlink_dl_dpipe_entries_policy,
> -};
> -
> -struct ynl_policy_attr devlink_dl_dpipe_headers_policy[DEVLINK_ATTR_MAX + 1] = {
> -	[DEVLINK_ATTR_DPIPE_HEADER] = { .name = "dpipe-header", .type = YNL_PT_NEST, .nest = &devlink_dl_dpipe_header_nest, },
> -};
> -
> -struct ynl_policy_nest devlink_dl_dpipe_headers_nest = {
> -	.max_attr = DEVLINK_ATTR_MAX,
> -	.table = devlink_dl_dpipe_headers_policy,
> -};
> -
> -struct ynl_policy_attr devlink_dl_dev_stats_policy[DEVLINK_ATTR_MAX + 1] = {
> -	[DEVLINK_ATTR_RELOAD_STATS] = { .name = "reload-stats", .type = YNL_PT_NEST, .nest = &devlink_dl_reload_stats_nest, },
> -	[DEVLINK_ATTR_REMOTE_RELOAD_STATS] = { .name = "remote-reload-stats", .type = YNL_PT_NEST, .nest = &devlink_dl_reload_stats_nest, },
> -};
> -
> -struct ynl_policy_nest devlink_dl_dev_stats_nest = {
> -	.max_attr = DEVLINK_ATTR_MAX,
> -	.table = devlink_dl_dev_stats_policy,
> -};
> -
> -struct ynl_policy_attr devlink_policy[DEVLINK_ATTR_MAX + 1] = {
> -	[DEVLINK_ATTR_BUS_NAME] = { .name = "bus-name", .type = YNL_PT_NUL_STR, },
> -	[DEVLINK_ATTR_DEV_NAME] = { .name = "dev-name", .type = YNL_PT_NUL_STR, },
> -	[DEVLINK_ATTR_PORT_INDEX] = { .name = "port-index", .type = YNL_PT_U32, },
> -	[DEVLINK_ATTR_PORT_TYPE] = { .name = "port-type", .type = YNL_PT_U16, },
> -	[DEVLINK_ATTR_PORT_SPLIT_COUNT] = { .name = "port-split-count", .type = YNL_PT_U32, },
> -	[DEVLINK_ATTR_SB_INDEX] = { .name = "sb-index", .type = YNL_PT_U32, },
> -	[DEVLINK_ATTR_SB_POOL_INDEX] = { .name = "sb-pool-index", .type = YNL_PT_U16, },
> -	[DEVLINK_ATTR_SB_POOL_TYPE] = { .name = "sb-pool-type", .type = YNL_PT_U8, },
> -	[DEVLINK_ATTR_SB_POOL_SIZE] = { .name = "sb-pool-size", .type = YNL_PT_U32, },
> -	[DEVLINK_ATTR_SB_POOL_THRESHOLD_TYPE] = { .name = "sb-pool-threshold-type", .type = YNL_PT_U8, },
> -	[DEVLINK_ATTR_SB_THRESHOLD] = { .name = "sb-threshold", .type = YNL_PT_U32, },
> -	[DEVLINK_ATTR_SB_TC_INDEX] = { .name = "sb-tc-index", .type = YNL_PT_U16, },
> -	[DEVLINK_ATTR_ESWITCH_MODE] = { .name = "eswitch-mode", .type = YNL_PT_U16, },
> -	[DEVLINK_ATTR_ESWITCH_INLINE_MODE] = { .name = "eswitch-inline-mode", .type = YNL_PT_U16, },
> -	[DEVLINK_ATTR_DPIPE_TABLES] = { .name = "dpipe-tables", .type = YNL_PT_NEST, .nest = &devlink_dl_dpipe_tables_nest, },
> -	[DEVLINK_ATTR_DPIPE_TABLE] = { .name = "dpipe-table", .type = YNL_PT_NEST, .nest = &devlink_dl_dpipe_table_nest, },
> -	[DEVLINK_ATTR_DPIPE_TABLE_NAME] = { .name = "dpipe-table-name", .type = YNL_PT_NUL_STR, },
> -	[DEVLINK_ATTR_DPIPE_TABLE_SIZE] = { .name = "dpipe-table-size", .type = YNL_PT_U64, },
> -	[DEVLINK_ATTR_DPIPE_TABLE_MATCHES] = { .name = "dpipe-table-matches", .type = YNL_PT_NEST, .nest = &devlink_dl_dpipe_table_matches_nest, },
> -	[DEVLINK_ATTR_DPIPE_TABLE_ACTIONS] = { .name = "dpipe-table-actions", .type = YNL_PT_NEST, .nest = &devlink_dl_dpipe_table_actions_nest, },
> -	[DEVLINK_ATTR_DPIPE_TABLE_COUNTERS_ENABLED] = { .name = "dpipe-table-counters-enabled", .type = YNL_PT_U8, },
> -	[DEVLINK_ATTR_DPIPE_ENTRIES] = { .name = "dpipe-entries", .type = YNL_PT_NEST, .nest = &devlink_dl_dpipe_entries_nest, },
> -	[DEVLINK_ATTR_DPIPE_ENTRY] = { .name = "dpipe-entry", .type = YNL_PT_NEST, .nest = &devlink_dl_dpipe_entry_nest, },
> -	[DEVLINK_ATTR_DPIPE_ENTRY_INDEX] = { .name = "dpipe-entry-index", .type = YNL_PT_U64, },
> -	[DEVLINK_ATTR_DPIPE_ENTRY_MATCH_VALUES] = { .name = "dpipe-entry-match-values", .type = YNL_PT_NEST, .nest = &devlink_dl_dpipe_entry_match_values_nest, },
> -	[DEVLINK_ATTR_DPIPE_ENTRY_ACTION_VALUES] = { .name = "dpipe-entry-action-values", .type = YNL_PT_NEST, .nest = &devlink_dl_dpipe_entry_action_values_nest, },
> -	[DEVLINK_ATTR_DPIPE_ENTRY_COUNTER] = { .name = "dpipe-entry-counter", .type = YNL_PT_U64, },
> -	[DEVLINK_ATTR_DPIPE_MATCH] = { .name = "dpipe-match", .type = YNL_PT_NEST, .nest = &devlink_dl_dpipe_match_nest, },
> -	[DEVLINK_ATTR_DPIPE_MATCH_VALUE] = { .name = "dpipe-match-value", .type = YNL_PT_NEST, .nest = &devlink_dl_dpipe_match_value_nest, },
> -	[DEVLINK_ATTR_DPIPE_MATCH_TYPE] = { .name = "dpipe-match-type", .type = YNL_PT_U32, },
> -	[DEVLINK_ATTR_DPIPE_ACTION] = { .name = "dpipe-action", .type = YNL_PT_NEST, .nest = &devlink_dl_dpipe_action_nest, },
> -	[DEVLINK_ATTR_DPIPE_ACTION_VALUE] = { .name = "dpipe-action-value", .type = YNL_PT_NEST, .nest = &devlink_dl_dpipe_action_value_nest, },
> -	[DEVLINK_ATTR_DPIPE_ACTION_TYPE] = { .name = "dpipe-action-type", .type = YNL_PT_U32, },
> -	[DEVLINK_ATTR_DPIPE_VALUE] = { .name = "dpipe-value", .type = YNL_PT_BINARY,},
> -	[DEVLINK_ATTR_DPIPE_VALUE_MASK] = { .name = "dpipe-value-mask", .type = YNL_PT_BINARY,},
> -	[DEVLINK_ATTR_DPIPE_VALUE_MAPPING] = { .name = "dpipe-value-mapping", .type = YNL_PT_U32, },
> -	[DEVLINK_ATTR_DPIPE_HEADERS] = { .name = "dpipe-headers", .type = YNL_PT_NEST, .nest = &devlink_dl_dpipe_headers_nest, },
> -	[DEVLINK_ATTR_DPIPE_HEADER] = { .name = "dpipe-header", .type = YNL_PT_NEST, .nest = &devlink_dl_dpipe_header_nest, },
> -	[DEVLINK_ATTR_DPIPE_HEADER_NAME] = { .name = "dpipe-header-name", .type = YNL_PT_NUL_STR, },
> -	[DEVLINK_ATTR_DPIPE_HEADER_ID] = { .name = "dpipe-header-id", .type = YNL_PT_U32, },
> -	[DEVLINK_ATTR_DPIPE_HEADER_FIELDS] = { .name = "dpipe-header-fields", .type = YNL_PT_NEST, .nest = &devlink_dl_dpipe_header_fields_nest, },
> -	[DEVLINK_ATTR_DPIPE_HEADER_GLOBAL] = { .name = "dpipe-header-global", .type = YNL_PT_U8, },
> -	[DEVLINK_ATTR_DPIPE_HEADER_INDEX] = { .name = "dpipe-header-index", .type = YNL_PT_U32, },
> -	[DEVLINK_ATTR_DPIPE_FIELD] = { .name = "dpipe-field", .type = YNL_PT_NEST, .nest = &devlink_dl_dpipe_field_nest, },
> -	[DEVLINK_ATTR_DPIPE_FIELD_NAME] = { .name = "dpipe-field-name", .type = YNL_PT_NUL_STR, },
> -	[DEVLINK_ATTR_DPIPE_FIELD_ID] = { .name = "dpipe-field-id", .type = YNL_PT_U32, },
> -	[DEVLINK_ATTR_DPIPE_FIELD_BITWIDTH] = { .name = "dpipe-field-bitwidth", .type = YNL_PT_U32, },
> -	[DEVLINK_ATTR_DPIPE_FIELD_MAPPING_TYPE] = { .name = "dpipe-field-mapping-type", .type = YNL_PT_U32, },
> -	[DEVLINK_ATTR_PAD] = { .name = "pad", .type = YNL_PT_IGNORE, },
> -	[DEVLINK_ATTR_ESWITCH_ENCAP_MODE] = { .name = "eswitch-encap-mode", .type = YNL_PT_U8, },
> -	[DEVLINK_ATTR_RESOURCE_LIST] = { .name = "resource-list", .type = YNL_PT_NEST, .nest = &devlink_dl_resource_list_nest, },
> -	[DEVLINK_ATTR_RESOURCE] = { .name = "resource", .type = YNL_PT_NEST, .nest = &devlink_dl_resource_nest, },
> -	[DEVLINK_ATTR_RESOURCE_NAME] = { .name = "resource-name", .type = YNL_PT_NUL_STR, },
> -	[DEVLINK_ATTR_RESOURCE_ID] = { .name = "resource-id", .type = YNL_PT_U64, },
> -	[DEVLINK_ATTR_RESOURCE_SIZE] = { .name = "resource-size", .type = YNL_PT_U64, },
> -	[DEVLINK_ATTR_RESOURCE_SIZE_NEW] = { .name = "resource-size-new", .type = YNL_PT_U64, },
> -	[DEVLINK_ATTR_RESOURCE_SIZE_VALID] = { .name = "resource-size-valid", .type = YNL_PT_U8, },
> -	[DEVLINK_ATTR_RESOURCE_SIZE_MIN] = { .name = "resource-size-min", .type = YNL_PT_U64, },
> -	[DEVLINK_ATTR_RESOURCE_SIZE_MAX] = { .name = "resource-size-max", .type = YNL_PT_U64, },
> -	[DEVLINK_ATTR_RESOURCE_SIZE_GRAN] = { .name = "resource-size-gran", .type = YNL_PT_U64, },
> -	[DEVLINK_ATTR_RESOURCE_UNIT] = { .name = "resource-unit", .type = YNL_PT_U8, },
> -	[DEVLINK_ATTR_RESOURCE_OCC] = { .name = "resource-occ", .type = YNL_PT_U64, },
> -	[DEVLINK_ATTR_DPIPE_TABLE_RESOURCE_ID] = { .name = "dpipe-table-resource-id", .type = YNL_PT_U64, },
> -	[DEVLINK_ATTR_DPIPE_TABLE_RESOURCE_UNITS] = { .name = "dpipe-table-resource-units", .type = YNL_PT_U64, },
> -	[DEVLINK_ATTR_PORT_FLAVOUR] = { .name = "port-flavour", .type = YNL_PT_U16, },
> -	[DEVLINK_ATTR_PARAM_NAME] = { .name = "param-name", .type = YNL_PT_NUL_STR, },
> -	[DEVLINK_ATTR_PARAM_TYPE] = { .name = "param-type", .type = YNL_PT_U8, },
> -	[DEVLINK_ATTR_PARAM_VALUE_CMODE] = { .name = "param-value-cmode", .type = YNL_PT_U8, },
> -	[DEVLINK_ATTR_REGION_NAME] = { .name = "region-name", .type = YNL_PT_NUL_STR, },
> -	[DEVLINK_ATTR_REGION_SNAPSHOT_ID] = { .name = "region-snapshot-id", .type = YNL_PT_U32, },
> -	[DEVLINK_ATTR_REGION_CHUNK_ADDR] = { .name = "region-chunk-addr", .type = YNL_PT_U64, },
> -	[DEVLINK_ATTR_REGION_CHUNK_LEN] = { .name = "region-chunk-len", .type = YNL_PT_U64, },
> -	[DEVLINK_ATTR_INFO_DRIVER_NAME] = { .name = "info-driver-name", .type = YNL_PT_NUL_STR, },
> -	[DEVLINK_ATTR_INFO_SERIAL_NUMBER] = { .name = "info-serial-number", .type = YNL_PT_NUL_STR, },
> -	[DEVLINK_ATTR_INFO_VERSION_FIXED] = { .name = "info-version-fixed", .type = YNL_PT_NEST, .nest = &devlink_dl_info_version_nest, },
> -	[DEVLINK_ATTR_INFO_VERSION_RUNNING] = { .name = "info-version-running", .type = YNL_PT_NEST, .nest = &devlink_dl_info_version_nest, },
> -	[DEVLINK_ATTR_INFO_VERSION_STORED] = { .name = "info-version-stored", .type = YNL_PT_NEST, .nest = &devlink_dl_info_version_nest, },
> -	[DEVLINK_ATTR_INFO_VERSION_NAME] = { .name = "info-version-name", .type = YNL_PT_NUL_STR, },
> -	[DEVLINK_ATTR_INFO_VERSION_VALUE] = { .name = "info-version-value", .type = YNL_PT_NUL_STR, },
> -	[DEVLINK_ATTR_FMSG] = { .name = "fmsg", .type = YNL_PT_NEST, .nest = &devlink_dl_fmsg_nest, },
> -	[DEVLINK_ATTR_FMSG_OBJ_NEST_START] = { .name = "fmsg-obj-nest-start", .type = YNL_PT_FLAG, },
> -	[DEVLINK_ATTR_FMSG_PAIR_NEST_START] = { .name = "fmsg-pair-nest-start", .type = YNL_PT_FLAG, },
> -	[DEVLINK_ATTR_FMSG_ARR_NEST_START] = { .name = "fmsg-arr-nest-start", .type = YNL_PT_FLAG, },
> -	[DEVLINK_ATTR_FMSG_NEST_END] = { .name = "fmsg-nest-end", .type = YNL_PT_FLAG, },
> -	[DEVLINK_ATTR_FMSG_OBJ_NAME] = { .name = "fmsg-obj-name", .type = YNL_PT_NUL_STR, },
> -	[DEVLINK_ATTR_HEALTH_REPORTER_NAME] = { .name = "health-reporter-name", .type = YNL_PT_NUL_STR, },
> -	[DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD] = { .name = "health-reporter-graceful-period", .type = YNL_PT_U64, },
> -	[DEVLINK_ATTR_HEALTH_REPORTER_AUTO_RECOVER] = { .name = "health-reporter-auto-recover", .type = YNL_PT_U8, },
> -	[DEVLINK_ATTR_FLASH_UPDATE_FILE_NAME] = { .name = "flash-update-file-name", .type = YNL_PT_NUL_STR, },
> -	[DEVLINK_ATTR_FLASH_UPDATE_COMPONENT] = { .name = "flash-update-component", .type = YNL_PT_NUL_STR, },
> -	[DEVLINK_ATTR_PORT_PCI_PF_NUMBER] = { .name = "port-pci-pf-number", .type = YNL_PT_U16, },
> -	[DEVLINK_ATTR_TRAP_NAME] = { .name = "trap-name", .type = YNL_PT_NUL_STR, },
> -	[DEVLINK_ATTR_TRAP_ACTION] = { .name = "trap-action", .type = YNL_PT_U8, },
> -	[DEVLINK_ATTR_TRAP_GROUP_NAME] = { .name = "trap-group-name", .type = YNL_PT_NUL_STR, },
> -	[DEVLINK_ATTR_RELOAD_FAILED] = { .name = "reload-failed", .type = YNL_PT_U8, },
> -	[DEVLINK_ATTR_NETNS_FD] = { .name = "netns-fd", .type = YNL_PT_U32, },
> -	[DEVLINK_ATTR_NETNS_PID] = { .name = "netns-pid", .type = YNL_PT_U32, },
> -	[DEVLINK_ATTR_NETNS_ID] = { .name = "netns-id", .type = YNL_PT_U32, },
> -	[DEVLINK_ATTR_HEALTH_REPORTER_AUTO_DUMP] = { .name = "health-reporter-auto-dump", .type = YNL_PT_U8, },
> -	[DEVLINK_ATTR_TRAP_POLICER_ID] = { .name = "trap-policer-id", .type = YNL_PT_U32, },
> -	[DEVLINK_ATTR_TRAP_POLICER_RATE] = { .name = "trap-policer-rate", .type = YNL_PT_U64, },
> -	[DEVLINK_ATTR_TRAP_POLICER_BURST] = { .name = "trap-policer-burst", .type = YNL_PT_U64, },
> -	[DEVLINK_ATTR_PORT_FUNCTION] = { .name = "port-function", .type = YNL_PT_NEST, .nest = &devlink_dl_port_function_nest, },
> -	[DEVLINK_ATTR_PORT_CONTROLLER_NUMBER] = { .name = "port-controller-number", .type = YNL_PT_U32, },
> -	[DEVLINK_ATTR_FLASH_UPDATE_OVERWRITE_MASK] = { .name = "flash-update-overwrite-mask", .type = YNL_PT_BITFIELD32, },
> -	[DEVLINK_ATTR_RELOAD_ACTION] = { .name = "reload-action", .type = YNL_PT_U8, },
> -	[DEVLINK_ATTR_RELOAD_ACTIONS_PERFORMED] = { .name = "reload-actions-performed", .type = YNL_PT_BITFIELD32, },
> -	[DEVLINK_ATTR_RELOAD_LIMITS] = { .name = "reload-limits", .type = YNL_PT_BITFIELD32, },
> -	[DEVLINK_ATTR_DEV_STATS] = { .name = "dev-stats", .type = YNL_PT_NEST, .nest = &devlink_dl_dev_stats_nest, },
> -	[DEVLINK_ATTR_RELOAD_STATS] = { .name = "reload-stats", .type = YNL_PT_NEST, .nest = &devlink_dl_reload_stats_nest, },
> -	[DEVLINK_ATTR_RELOAD_STATS_ENTRY] = { .name = "reload-stats-entry", .type = YNL_PT_NEST, .nest = &devlink_dl_reload_stats_entry_nest, },
> -	[DEVLINK_ATTR_RELOAD_STATS_LIMIT] = { .name = "reload-stats-limit", .type = YNL_PT_U8, },
> -	[DEVLINK_ATTR_RELOAD_STATS_VALUE] = { .name = "reload-stats-value", .type = YNL_PT_U32, },
> -	[DEVLINK_ATTR_REMOTE_RELOAD_STATS] = { .name = "remote-reload-stats", .type = YNL_PT_NEST, .nest = &devlink_dl_reload_stats_nest, },
> -	[DEVLINK_ATTR_RELOAD_ACTION_INFO] = { .name = "reload-action-info", .type = YNL_PT_NEST, .nest = &devlink_dl_reload_act_info_nest, },
> -	[DEVLINK_ATTR_RELOAD_ACTION_STATS] = { .name = "reload-action-stats", .type = YNL_PT_NEST, .nest = &devlink_dl_reload_act_stats_nest, },
> -	[DEVLINK_ATTR_PORT_PCI_SF_NUMBER] = { .name = "port-pci-sf-number", .type = YNL_PT_U32, },
> -	[DEVLINK_ATTR_RATE_TX_SHARE] = { .name = "rate-tx-share", .type = YNL_PT_U64, },
> -	[DEVLINK_ATTR_RATE_TX_MAX] = { .name = "rate-tx-max", .type = YNL_PT_U64, },
> -	[DEVLINK_ATTR_RATE_NODE_NAME] = { .name = "rate-node-name", .type = YNL_PT_NUL_STR, },
> -	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .name = "rate-parent-node-name", .type = YNL_PT_NUL_STR, },
> -	[DEVLINK_ATTR_LINECARD_INDEX] = { .name = "linecard-index", .type = YNL_PT_U32, },
> -	[DEVLINK_ATTR_LINECARD_TYPE] = { .name = "linecard-type", .type = YNL_PT_NUL_STR, },
> -	[DEVLINK_ATTR_SELFTESTS] = { .name = "selftests", .type = YNL_PT_NEST, .nest = &devlink_dl_selftest_id_nest, },
> -	[DEVLINK_ATTR_RATE_TX_PRIORITY] = { .name = "rate-tx-priority", .type = YNL_PT_U32, },
> -	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .name = "rate-tx-weight", .type = YNL_PT_U32, },
> -	[DEVLINK_ATTR_REGION_DIRECT] = { .name = "region-direct", .type = YNL_PT_FLAG, },
> -};
> -
> -struct ynl_policy_nest devlink_nest = {
> -	.max_attr = DEVLINK_ATTR_MAX,
> -	.table = devlink_policy,
> -};
> -
> -/* Common nested types */
> -void devlink_dl_dpipe_match_free(struct devlink_dl_dpipe_match *obj)
> -{
> -}
> -
> -int devlink_dl_dpipe_match_parse(struct ynl_parse_arg *yarg,
> -				 const struct nlattr *nested)
> -{
> -	struct devlink_dl_dpipe_match *dst = yarg->data;
> -	const struct nlattr *attr;
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_DPIPE_MATCH_TYPE) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.dpipe_match_type = 1;
> -			dst->dpipe_match_type = mnl_attr_get_u32(attr);
> -		} else if (type == DEVLINK_ATTR_DPIPE_HEADER_ID) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.dpipe_header_id = 1;
> -			dst->dpipe_header_id = mnl_attr_get_u32(attr);
> -		} else if (type == DEVLINK_ATTR_DPIPE_HEADER_GLOBAL) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.dpipe_header_global = 1;
> -			dst->dpipe_header_global = mnl_attr_get_u8(attr);
> -		} else if (type == DEVLINK_ATTR_DPIPE_HEADER_INDEX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.dpipe_header_index = 1;
> -			dst->dpipe_header_index = mnl_attr_get_u32(attr);
> -		} else if (type == DEVLINK_ATTR_DPIPE_FIELD_ID) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.dpipe_field_id = 1;
> -			dst->dpipe_field_id = mnl_attr_get_u32(attr);
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -void
> -devlink_dl_dpipe_match_value_free(struct devlink_dl_dpipe_match_value *obj)
> -{
> -	unsigned int i;
> -
> -	for (i = 0; i < obj->n_dpipe_match; i++)
> -		devlink_dl_dpipe_match_free(&obj->dpipe_match[i]);
> -	free(obj->dpipe_match);
> -	free(obj->dpipe_value);
> -	free(obj->dpipe_value_mask);
> -}
> -
> -int devlink_dl_dpipe_match_value_parse(struct ynl_parse_arg *yarg,
> -				       const struct nlattr *nested)
> -{
> -	struct devlink_dl_dpipe_match_value *dst = yarg->data;
> -	unsigned int n_dpipe_match = 0;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -	int i;
> -
> -	parg.ys = yarg->ys;
> -
> -	if (dst->dpipe_match)
> -		return ynl_error_parse(yarg, "attribute already present (dl-dpipe-match-value.dpipe-match)");
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_DPIPE_MATCH) {
> -			n_dpipe_match++;
> -		} else if (type == DEVLINK_ATTR_DPIPE_VALUE) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = mnl_attr_get_payload_len(attr);
> -			dst->_present.dpipe_value_len = len;
> -			dst->dpipe_value = malloc(len);
> -			memcpy(dst->dpipe_value, mnl_attr_get_payload(attr), len);
> -		} else if (type == DEVLINK_ATTR_DPIPE_VALUE_MASK) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = mnl_attr_get_payload_len(attr);
> -			dst->_present.dpipe_value_mask_len = len;
> -			dst->dpipe_value_mask = malloc(len);
> -			memcpy(dst->dpipe_value_mask, mnl_attr_get_payload(attr), len);
> -		} else if (type == DEVLINK_ATTR_DPIPE_VALUE_MAPPING) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.dpipe_value_mapping = 1;
> -			dst->dpipe_value_mapping = mnl_attr_get_u32(attr);
> -		}
> -	}
> -
> -	if (n_dpipe_match) {
> -		dst->dpipe_match = calloc(n_dpipe_match, sizeof(*dst->dpipe_match));
> -		dst->n_dpipe_match = n_dpipe_match;
> -		i = 0;
> -		parg.rsp_policy = &devlink_dl_dpipe_match_nest;
> -		mnl_attr_for_each_nested(attr, nested) {
> -			if (mnl_attr_get_type(attr) == DEVLINK_ATTR_DPIPE_MATCH) {
> -				parg.data = &dst->dpipe_match[i];
> -				if (devlink_dl_dpipe_match_parse(&parg, attr))
> -					return MNL_CB_ERROR;
> -				i++;
> -			}
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -void devlink_dl_dpipe_action_free(struct devlink_dl_dpipe_action *obj)
> -{
> -}
> -
> -int devlink_dl_dpipe_action_parse(struct ynl_parse_arg *yarg,
> -				  const struct nlattr *nested)
> -{
> -	struct devlink_dl_dpipe_action *dst = yarg->data;
> -	const struct nlattr *attr;
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_DPIPE_ACTION_TYPE) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.dpipe_action_type = 1;
> -			dst->dpipe_action_type = mnl_attr_get_u32(attr);
> -		} else if (type == DEVLINK_ATTR_DPIPE_HEADER_ID) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.dpipe_header_id = 1;
> -			dst->dpipe_header_id = mnl_attr_get_u32(attr);
> -		} else if (type == DEVLINK_ATTR_DPIPE_HEADER_GLOBAL) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.dpipe_header_global = 1;
> -			dst->dpipe_header_global = mnl_attr_get_u8(attr);
> -		} else if (type == DEVLINK_ATTR_DPIPE_HEADER_INDEX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.dpipe_header_index = 1;
> -			dst->dpipe_header_index = mnl_attr_get_u32(attr);
> -		} else if (type == DEVLINK_ATTR_DPIPE_FIELD_ID) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.dpipe_field_id = 1;
> -			dst->dpipe_field_id = mnl_attr_get_u32(attr);
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -void
> -devlink_dl_dpipe_action_value_free(struct devlink_dl_dpipe_action_value *obj)
> -{
> -	unsigned int i;
> -
> -	for (i = 0; i < obj->n_dpipe_action; i++)
> -		devlink_dl_dpipe_action_free(&obj->dpipe_action[i]);
> -	free(obj->dpipe_action);
> -	free(obj->dpipe_value);
> -	free(obj->dpipe_value_mask);
> -}
> -
> -int devlink_dl_dpipe_action_value_parse(struct ynl_parse_arg *yarg,
> -					const struct nlattr *nested)
> -{
> -	struct devlink_dl_dpipe_action_value *dst = yarg->data;
> -	unsigned int n_dpipe_action = 0;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -	int i;
> -
> -	parg.ys = yarg->ys;
> -
> -	if (dst->dpipe_action)
> -		return ynl_error_parse(yarg, "attribute already present (dl-dpipe-action-value.dpipe-action)");
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_DPIPE_ACTION) {
> -			n_dpipe_action++;
> -		} else if (type == DEVLINK_ATTR_DPIPE_VALUE) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = mnl_attr_get_payload_len(attr);
> -			dst->_present.dpipe_value_len = len;
> -			dst->dpipe_value = malloc(len);
> -			memcpy(dst->dpipe_value, mnl_attr_get_payload(attr), len);
> -		} else if (type == DEVLINK_ATTR_DPIPE_VALUE_MASK) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = mnl_attr_get_payload_len(attr);
> -			dst->_present.dpipe_value_mask_len = len;
> -			dst->dpipe_value_mask = malloc(len);
> -			memcpy(dst->dpipe_value_mask, mnl_attr_get_payload(attr), len);
> -		} else if (type == DEVLINK_ATTR_DPIPE_VALUE_MAPPING) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.dpipe_value_mapping = 1;
> -			dst->dpipe_value_mapping = mnl_attr_get_u32(attr);
> -		}
> -	}
> -
> -	if (n_dpipe_action) {
> -		dst->dpipe_action = calloc(n_dpipe_action, sizeof(*dst->dpipe_action));
> -		dst->n_dpipe_action = n_dpipe_action;
> -		i = 0;
> -		parg.rsp_policy = &devlink_dl_dpipe_action_nest;
> -		mnl_attr_for_each_nested(attr, nested) {
> -			if (mnl_attr_get_type(attr) == DEVLINK_ATTR_DPIPE_ACTION) {
> -				parg.data = &dst->dpipe_action[i];
> -				if (devlink_dl_dpipe_action_parse(&parg, attr))
> -					return MNL_CB_ERROR;
> -				i++;
> -			}
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -void devlink_dl_dpipe_field_free(struct devlink_dl_dpipe_field *obj)
> -{
> -	free(obj->dpipe_field_name);
> -}
> -
> -int devlink_dl_dpipe_field_parse(struct ynl_parse_arg *yarg,
> -				 const struct nlattr *nested)
> -{
> -	struct devlink_dl_dpipe_field *dst = yarg->data;
> -	const struct nlattr *attr;
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_DPIPE_FIELD_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.dpipe_field_name_len = len;
> -			dst->dpipe_field_name = malloc(len + 1);
> -			memcpy(dst->dpipe_field_name, mnl_attr_get_str(attr), len);
> -			dst->dpipe_field_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_DPIPE_FIELD_ID) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.dpipe_field_id = 1;
> -			dst->dpipe_field_id = mnl_attr_get_u32(attr);
> -		} else if (type == DEVLINK_ATTR_DPIPE_FIELD_BITWIDTH) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.dpipe_field_bitwidth = 1;
> -			dst->dpipe_field_bitwidth = mnl_attr_get_u32(attr);
> -		} else if (type == DEVLINK_ATTR_DPIPE_FIELD_MAPPING_TYPE) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.dpipe_field_mapping_type = 1;
> -			dst->dpipe_field_mapping_type = mnl_attr_get_u32(attr);
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -void devlink_dl_resource_free(struct devlink_dl_resource *obj)
> -{
> -	free(obj->resource_name);
> -}
> -
> -int devlink_dl_resource_parse(struct ynl_parse_arg *yarg,
> -			      const struct nlattr *nested)
> -{
> -	struct devlink_dl_resource *dst = yarg->data;
> -	const struct nlattr *attr;
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_RESOURCE_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.resource_name_len = len;
> -			dst->resource_name = malloc(len + 1);
> -			memcpy(dst->resource_name, mnl_attr_get_str(attr), len);
> -			dst->resource_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_RESOURCE_ID) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.resource_id = 1;
> -			dst->resource_id = mnl_attr_get_u64(attr);
> -		} else if (type == DEVLINK_ATTR_RESOURCE_SIZE) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.resource_size = 1;
> -			dst->resource_size = mnl_attr_get_u64(attr);
> -		} else if (type == DEVLINK_ATTR_RESOURCE_SIZE_NEW) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.resource_size_new = 1;
> -			dst->resource_size_new = mnl_attr_get_u64(attr);
> -		} else if (type == DEVLINK_ATTR_RESOURCE_SIZE_VALID) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.resource_size_valid = 1;
> -			dst->resource_size_valid = mnl_attr_get_u8(attr);
> -		} else if (type == DEVLINK_ATTR_RESOURCE_SIZE_MIN) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.resource_size_min = 1;
> -			dst->resource_size_min = mnl_attr_get_u64(attr);
> -		} else if (type == DEVLINK_ATTR_RESOURCE_SIZE_MAX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.resource_size_max = 1;
> -			dst->resource_size_max = mnl_attr_get_u64(attr);
> -		} else if (type == DEVLINK_ATTR_RESOURCE_SIZE_GRAN) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.resource_size_gran = 1;
> -			dst->resource_size_gran = mnl_attr_get_u64(attr);
> -		} else if (type == DEVLINK_ATTR_RESOURCE_UNIT) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.resource_unit = 1;
> -			dst->resource_unit = mnl_attr_get_u8(attr);
> -		} else if (type == DEVLINK_ATTR_RESOURCE_OCC) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.resource_occ = 1;
> -			dst->resource_occ = mnl_attr_get_u64(attr);
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -void devlink_dl_info_version_free(struct devlink_dl_info_version *obj)
> -{
> -	free(obj->info_version_name);
> -	free(obj->info_version_value);
> -}
> -
> -int devlink_dl_info_version_parse(struct ynl_parse_arg *yarg,
> -				  const struct nlattr *nested)
> -{
> -	struct devlink_dl_info_version *dst = yarg->data;
> -	const struct nlattr *attr;
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_INFO_VERSION_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.info_version_name_len = len;
> -			dst->info_version_name = malloc(len + 1);
> -			memcpy(dst->info_version_name, mnl_attr_get_str(attr), len);
> -			dst->info_version_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_INFO_VERSION_VALUE) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.info_version_value_len = len;
> -			dst->info_version_value = malloc(len + 1);
> -			memcpy(dst->info_version_value, mnl_attr_get_str(attr), len);
> -			dst->info_version_value[len] = 0;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -void devlink_dl_fmsg_free(struct devlink_dl_fmsg *obj)
> -{
> -	free(obj->fmsg_obj_name);
> -}
> -
> -int devlink_dl_fmsg_parse(struct ynl_parse_arg *yarg,
> -			  const struct nlattr *nested)
> -{
> -	struct devlink_dl_fmsg *dst = yarg->data;
> -	const struct nlattr *attr;
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_FMSG_OBJ_NEST_START) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.fmsg_obj_nest_start = 1;
> -		} else if (type == DEVLINK_ATTR_FMSG_PAIR_NEST_START) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.fmsg_pair_nest_start = 1;
> -		} else if (type == DEVLINK_ATTR_FMSG_ARR_NEST_START) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.fmsg_arr_nest_start = 1;
> -		} else if (type == DEVLINK_ATTR_FMSG_NEST_END) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.fmsg_nest_end = 1;
> -		} else if (type == DEVLINK_ATTR_FMSG_OBJ_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.fmsg_obj_name_len = len;
> -			dst->fmsg_obj_name = malloc(len + 1);
> -			memcpy(dst->fmsg_obj_name, mnl_attr_get_str(attr), len);
> -			dst->fmsg_obj_name[len] = 0;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -void devlink_dl_port_function_free(struct devlink_dl_port_function *obj)
> -{
> -	free(obj->hw_addr);
> -}
> -
> -int devlink_dl_port_function_put(struct nlmsghdr *nlh, unsigned int attr_type,
> -				 struct devlink_dl_port_function *obj)
> -{
> -	struct nlattr *nest;
> -
> -	nest = mnl_attr_nest_start(nlh, attr_type);
> -	if (obj->_present.hw_addr_len)
> -		mnl_attr_put(nlh, DEVLINK_PORT_FUNCTION_ATTR_HW_ADDR, obj->_present.hw_addr_len, obj->hw_addr);
> -	if (obj->_present.state)
> -		mnl_attr_put_u8(nlh, DEVLINK_PORT_FN_ATTR_STATE, obj->state);
> -	if (obj->_present.opstate)
> -		mnl_attr_put_u8(nlh, DEVLINK_PORT_FN_ATTR_OPSTATE, obj->opstate);
> -	if (obj->_present.caps)
> -		mnl_attr_put(nlh, DEVLINK_PORT_FN_ATTR_CAPS, sizeof(struct nla_bitfield32), &obj->caps);
> -	mnl_attr_nest_end(nlh, nest);
> -
> -	return 0;
> -}
> -
> -void
> -devlink_dl_reload_stats_entry_free(struct devlink_dl_reload_stats_entry *obj)
> -{
> -}
> -
> -int devlink_dl_reload_stats_entry_parse(struct ynl_parse_arg *yarg,
> -					const struct nlattr *nested)
> -{
> -	struct devlink_dl_reload_stats_entry *dst = yarg->data;
> -	const struct nlattr *attr;
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_RELOAD_STATS_LIMIT) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.reload_stats_limit = 1;
> -			dst->reload_stats_limit = mnl_attr_get_u8(attr);
> -		} else if (type == DEVLINK_ATTR_RELOAD_STATS_VALUE) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.reload_stats_value = 1;
> -			dst->reload_stats_value = mnl_attr_get_u32(attr);
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -void devlink_dl_reload_act_stats_free(struct devlink_dl_reload_act_stats *obj)
> -{
> -	unsigned int i;
> -
> -	for (i = 0; i < obj->n_reload_stats_entry; i++)
> -		devlink_dl_reload_stats_entry_free(&obj->reload_stats_entry[i]);
> -	free(obj->reload_stats_entry);
> -}
> -
> -int devlink_dl_reload_act_stats_parse(struct ynl_parse_arg *yarg,
> -				      const struct nlattr *nested)
> -{
> -	struct devlink_dl_reload_act_stats *dst = yarg->data;
> -	unsigned int n_reload_stats_entry = 0;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -	int i;
> -
> -	parg.ys = yarg->ys;
> -
> -	if (dst->reload_stats_entry)
> -		return ynl_error_parse(yarg, "attribute already present (dl-reload-act-stats.reload-stats-entry)");
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_RELOAD_STATS_ENTRY) {
> -			n_reload_stats_entry++;
> -		}
> -	}
> -
> -	if (n_reload_stats_entry) {
> -		dst->reload_stats_entry = calloc(n_reload_stats_entry, sizeof(*dst->reload_stats_entry));
> -		dst->n_reload_stats_entry = n_reload_stats_entry;
> -		i = 0;
> -		parg.rsp_policy = &devlink_dl_reload_stats_entry_nest;
> -		mnl_attr_for_each_nested(attr, nested) {
> -			if (mnl_attr_get_type(attr) == DEVLINK_ATTR_RELOAD_STATS_ENTRY) {
> -				parg.data = &dst->reload_stats_entry[i];
> -				if (devlink_dl_reload_stats_entry_parse(&parg, attr))
> -					return MNL_CB_ERROR;
> -				i++;
> -			}
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -void devlink_dl_selftest_id_free(struct devlink_dl_selftest_id *obj)
> -{
> -}
> -
> -int devlink_dl_selftest_id_put(struct nlmsghdr *nlh, unsigned int attr_type,
> -			       struct devlink_dl_selftest_id *obj)
> -{
> -	struct nlattr *nest;
> -
> -	nest = mnl_attr_nest_start(nlh, attr_type);
> -	if (obj->_present.flash)
> -		mnl_attr_put(nlh, DEVLINK_ATTR_SELFTEST_ID_FLASH, 0, NULL);
> -	mnl_attr_nest_end(nlh, nest);
> -
> -	return 0;
> -}
> -
> -void
> -devlink_dl_dpipe_table_matches_free(struct devlink_dl_dpipe_table_matches *obj)
> -{
> -	unsigned int i;
> -
> -	for (i = 0; i < obj->n_dpipe_match; i++)
> -		devlink_dl_dpipe_match_free(&obj->dpipe_match[i]);
> -	free(obj->dpipe_match);
> -}
> -
> -int devlink_dl_dpipe_table_matches_parse(struct ynl_parse_arg *yarg,
> -					 const struct nlattr *nested)
> -{
> -	struct devlink_dl_dpipe_table_matches *dst = yarg->data;
> -	unsigned int n_dpipe_match = 0;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -	int i;
> -
> -	parg.ys = yarg->ys;
> -
> -	if (dst->dpipe_match)
> -		return ynl_error_parse(yarg, "attribute already present (dl-dpipe-table-matches.dpipe-match)");
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_DPIPE_MATCH) {
> -			n_dpipe_match++;
> -		}
> -	}
> -
> -	if (n_dpipe_match) {
> -		dst->dpipe_match = calloc(n_dpipe_match, sizeof(*dst->dpipe_match));
> -		dst->n_dpipe_match = n_dpipe_match;
> -		i = 0;
> -		parg.rsp_policy = &devlink_dl_dpipe_match_nest;
> -		mnl_attr_for_each_nested(attr, nested) {
> -			if (mnl_attr_get_type(attr) == DEVLINK_ATTR_DPIPE_MATCH) {
> -				parg.data = &dst->dpipe_match[i];
> -				if (devlink_dl_dpipe_match_parse(&parg, attr))
> -					return MNL_CB_ERROR;
> -				i++;
> -			}
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -void
> -devlink_dl_dpipe_table_actions_free(struct devlink_dl_dpipe_table_actions *obj)
> -{
> -	unsigned int i;
> -
> -	for (i = 0; i < obj->n_dpipe_action; i++)
> -		devlink_dl_dpipe_action_free(&obj->dpipe_action[i]);
> -	free(obj->dpipe_action);
> -}
> -
> -int devlink_dl_dpipe_table_actions_parse(struct ynl_parse_arg *yarg,
> -					 const struct nlattr *nested)
> -{
> -	struct devlink_dl_dpipe_table_actions *dst = yarg->data;
> -	unsigned int n_dpipe_action = 0;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -	int i;
> -
> -	parg.ys = yarg->ys;
> -
> -	if (dst->dpipe_action)
> -		return ynl_error_parse(yarg, "attribute already present (dl-dpipe-table-actions.dpipe-action)");
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_DPIPE_ACTION) {
> -			n_dpipe_action++;
> -		}
> -	}
> -
> -	if (n_dpipe_action) {
> -		dst->dpipe_action = calloc(n_dpipe_action, sizeof(*dst->dpipe_action));
> -		dst->n_dpipe_action = n_dpipe_action;
> -		i = 0;
> -		parg.rsp_policy = &devlink_dl_dpipe_action_nest;
> -		mnl_attr_for_each_nested(attr, nested) {
> -			if (mnl_attr_get_type(attr) == DEVLINK_ATTR_DPIPE_ACTION) {
> -				parg.data = &dst->dpipe_action[i];
> -				if (devlink_dl_dpipe_action_parse(&parg, attr))
> -					return MNL_CB_ERROR;
> -				i++;
> -			}
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -void
> -devlink_dl_dpipe_entry_match_values_free(struct devlink_dl_dpipe_entry_match_values *obj)
> -{
> -	unsigned int i;
> -
> -	for (i = 0; i < obj->n_dpipe_match_value; i++)
> -		devlink_dl_dpipe_match_value_free(&obj->dpipe_match_value[i]);
> -	free(obj->dpipe_match_value);
> -}
> -
> -int devlink_dl_dpipe_entry_match_values_parse(struct ynl_parse_arg *yarg,
> -					      const struct nlattr *nested)
> -{
> -	struct devlink_dl_dpipe_entry_match_values *dst = yarg->data;
> -	unsigned int n_dpipe_match_value = 0;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -	int i;
> -
> -	parg.ys = yarg->ys;
> -
> -	if (dst->dpipe_match_value)
> -		return ynl_error_parse(yarg, "attribute already present (dl-dpipe-entry-match-values.dpipe-match-value)");
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_DPIPE_MATCH_VALUE) {
> -			n_dpipe_match_value++;
> -		}
> -	}
> -
> -	if (n_dpipe_match_value) {
> -		dst->dpipe_match_value = calloc(n_dpipe_match_value, sizeof(*dst->dpipe_match_value));
> -		dst->n_dpipe_match_value = n_dpipe_match_value;
> -		i = 0;
> -		parg.rsp_policy = &devlink_dl_dpipe_match_value_nest;
> -		mnl_attr_for_each_nested(attr, nested) {
> -			if (mnl_attr_get_type(attr) == DEVLINK_ATTR_DPIPE_MATCH_VALUE) {
> -				parg.data = &dst->dpipe_match_value[i];
> -				if (devlink_dl_dpipe_match_value_parse(&parg, attr))
> -					return MNL_CB_ERROR;
> -				i++;
> -			}
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -void
> -devlink_dl_dpipe_entry_action_values_free(struct devlink_dl_dpipe_entry_action_values *obj)
> -{
> -	unsigned int i;
> -
> -	for (i = 0; i < obj->n_dpipe_action_value; i++)
> -		devlink_dl_dpipe_action_value_free(&obj->dpipe_action_value[i]);
> -	free(obj->dpipe_action_value);
> -}
> -
> -int devlink_dl_dpipe_entry_action_values_parse(struct ynl_parse_arg *yarg,
> -					       const struct nlattr *nested)
> -{
> -	struct devlink_dl_dpipe_entry_action_values *dst = yarg->data;
> -	unsigned int n_dpipe_action_value = 0;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -	int i;
> -
> -	parg.ys = yarg->ys;
> -
> -	if (dst->dpipe_action_value)
> -		return ynl_error_parse(yarg, "attribute already present (dl-dpipe-entry-action-values.dpipe-action-value)");
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_DPIPE_ACTION_VALUE) {
> -			n_dpipe_action_value++;
> -		}
> -	}
> -
> -	if (n_dpipe_action_value) {
> -		dst->dpipe_action_value = calloc(n_dpipe_action_value, sizeof(*dst->dpipe_action_value));
> -		dst->n_dpipe_action_value = n_dpipe_action_value;
> -		i = 0;
> -		parg.rsp_policy = &devlink_dl_dpipe_action_value_nest;
> -		mnl_attr_for_each_nested(attr, nested) {
> -			if (mnl_attr_get_type(attr) == DEVLINK_ATTR_DPIPE_ACTION_VALUE) {
> -				parg.data = &dst->dpipe_action_value[i];
> -				if (devlink_dl_dpipe_action_value_parse(&parg, attr))
> -					return MNL_CB_ERROR;
> -				i++;
> -			}
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -void
> -devlink_dl_dpipe_header_fields_free(struct devlink_dl_dpipe_header_fields *obj)
> -{
> -	unsigned int i;
> -
> -	for (i = 0; i < obj->n_dpipe_field; i++)
> -		devlink_dl_dpipe_field_free(&obj->dpipe_field[i]);
> -	free(obj->dpipe_field);
> -}
> -
> -int devlink_dl_dpipe_header_fields_parse(struct ynl_parse_arg *yarg,
> -					 const struct nlattr *nested)
> -{
> -	struct devlink_dl_dpipe_header_fields *dst = yarg->data;
> -	unsigned int n_dpipe_field = 0;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -	int i;
> -
> -	parg.ys = yarg->ys;
> -
> -	if (dst->dpipe_field)
> -		return ynl_error_parse(yarg, "attribute already present (dl-dpipe-header-fields.dpipe-field)");
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_DPIPE_FIELD) {
> -			n_dpipe_field++;
> -		}
> -	}
> -
> -	if (n_dpipe_field) {
> -		dst->dpipe_field = calloc(n_dpipe_field, sizeof(*dst->dpipe_field));
> -		dst->n_dpipe_field = n_dpipe_field;
> -		i = 0;
> -		parg.rsp_policy = &devlink_dl_dpipe_field_nest;
> -		mnl_attr_for_each_nested(attr, nested) {
> -			if (mnl_attr_get_type(attr) == DEVLINK_ATTR_DPIPE_FIELD) {
> -				parg.data = &dst->dpipe_field[i];
> -				if (devlink_dl_dpipe_field_parse(&parg, attr))
> -					return MNL_CB_ERROR;
> -				i++;
> -			}
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -void devlink_dl_resource_list_free(struct devlink_dl_resource_list *obj)
> -{
> -	unsigned int i;
> -
> -	for (i = 0; i < obj->n_resource; i++)
> -		devlink_dl_resource_free(&obj->resource[i]);
> -	free(obj->resource);
> -}
> -
> -int devlink_dl_resource_list_parse(struct ynl_parse_arg *yarg,
> -				   const struct nlattr *nested)
> -{
> -	struct devlink_dl_resource_list *dst = yarg->data;
> -	unsigned int n_resource = 0;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -	int i;
> -
> -	parg.ys = yarg->ys;
> -
> -	if (dst->resource)
> -		return ynl_error_parse(yarg, "attribute already present (dl-resource-list.resource)");
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_RESOURCE) {
> -			n_resource++;
> -		}
> -	}
> -
> -	if (n_resource) {
> -		dst->resource = calloc(n_resource, sizeof(*dst->resource));
> -		dst->n_resource = n_resource;
> -		i = 0;
> -		parg.rsp_policy = &devlink_dl_resource_nest;
> -		mnl_attr_for_each_nested(attr, nested) {
> -			if (mnl_attr_get_type(attr) == DEVLINK_ATTR_RESOURCE) {
> -				parg.data = &dst->resource[i];
> -				if (devlink_dl_resource_parse(&parg, attr))
> -					return MNL_CB_ERROR;
> -				i++;
> -			}
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -void devlink_dl_reload_act_info_free(struct devlink_dl_reload_act_info *obj)
> -{
> -	unsigned int i;
> -
> -	for (i = 0; i < obj->n_reload_action_stats; i++)
> -		devlink_dl_reload_act_stats_free(&obj->reload_action_stats[i]);
> -	free(obj->reload_action_stats);
> -}
> -
> -int devlink_dl_reload_act_info_parse(struct ynl_parse_arg *yarg,
> -				     const struct nlattr *nested)
> -{
> -	struct devlink_dl_reload_act_info *dst = yarg->data;
> -	unsigned int n_reload_action_stats = 0;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -	int i;
> -
> -	parg.ys = yarg->ys;
> -
> -	if (dst->reload_action_stats)
> -		return ynl_error_parse(yarg, "attribute already present (dl-reload-act-info.reload-action-stats)");
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_RELOAD_ACTION) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.reload_action = 1;
> -			dst->reload_action = mnl_attr_get_u8(attr);
> -		} else if (type == DEVLINK_ATTR_RELOAD_ACTION_STATS) {
> -			n_reload_action_stats++;
> -		}
> -	}
> -
> -	if (n_reload_action_stats) {
> -		dst->reload_action_stats = calloc(n_reload_action_stats, sizeof(*dst->reload_action_stats));
> -		dst->n_reload_action_stats = n_reload_action_stats;
> -		i = 0;
> -		parg.rsp_policy = &devlink_dl_reload_act_stats_nest;
> -		mnl_attr_for_each_nested(attr, nested) {
> -			if (mnl_attr_get_type(attr) == DEVLINK_ATTR_RELOAD_ACTION_STATS) {
> -				parg.data = &dst->reload_action_stats[i];
> -				if (devlink_dl_reload_act_stats_parse(&parg, attr))
> -					return MNL_CB_ERROR;
> -				i++;
> -			}
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -void devlink_dl_dpipe_table_free(struct devlink_dl_dpipe_table *obj)
> -{
> -	free(obj->dpipe_table_name);
> -	devlink_dl_dpipe_table_matches_free(&obj->dpipe_table_matches);
> -	devlink_dl_dpipe_table_actions_free(&obj->dpipe_table_actions);
> -}
> -
> -int devlink_dl_dpipe_table_parse(struct ynl_parse_arg *yarg,
> -				 const struct nlattr *nested)
> -{
> -	struct devlink_dl_dpipe_table *dst = yarg->data;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -
> -	parg.ys = yarg->ys;
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_DPIPE_TABLE_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.dpipe_table_name_len = len;
> -			dst->dpipe_table_name = malloc(len + 1);
> -			memcpy(dst->dpipe_table_name, mnl_attr_get_str(attr), len);
> -			dst->dpipe_table_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_DPIPE_TABLE_SIZE) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.dpipe_table_size = 1;
> -			dst->dpipe_table_size = mnl_attr_get_u64(attr);
> -		} else if (type == DEVLINK_ATTR_DPIPE_TABLE_MATCHES) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.dpipe_table_matches = 1;
> -
> -			parg.rsp_policy = &devlink_dl_dpipe_table_matches_nest;
> -			parg.data = &dst->dpipe_table_matches;
> -			if (devlink_dl_dpipe_table_matches_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == DEVLINK_ATTR_DPIPE_TABLE_ACTIONS) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.dpipe_table_actions = 1;
> -
> -			parg.rsp_policy = &devlink_dl_dpipe_table_actions_nest;
> -			parg.data = &dst->dpipe_table_actions;
> -			if (devlink_dl_dpipe_table_actions_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == DEVLINK_ATTR_DPIPE_TABLE_COUNTERS_ENABLED) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.dpipe_table_counters_enabled = 1;
> -			dst->dpipe_table_counters_enabled = mnl_attr_get_u8(attr);
> -		} else if (type == DEVLINK_ATTR_DPIPE_TABLE_RESOURCE_ID) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.dpipe_table_resource_id = 1;
> -			dst->dpipe_table_resource_id = mnl_attr_get_u64(attr);
> -		} else if (type == DEVLINK_ATTR_DPIPE_TABLE_RESOURCE_UNITS) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.dpipe_table_resource_units = 1;
> -			dst->dpipe_table_resource_units = mnl_attr_get_u64(attr);
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -void devlink_dl_dpipe_entry_free(struct devlink_dl_dpipe_entry *obj)
> -{
> -	devlink_dl_dpipe_entry_match_values_free(&obj->dpipe_entry_match_values);
> -	devlink_dl_dpipe_entry_action_values_free(&obj->dpipe_entry_action_values);
> -}
> -
> -int devlink_dl_dpipe_entry_parse(struct ynl_parse_arg *yarg,
> -				 const struct nlattr *nested)
> -{
> -	struct devlink_dl_dpipe_entry *dst = yarg->data;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -
> -	parg.ys = yarg->ys;
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_DPIPE_ENTRY_INDEX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.dpipe_entry_index = 1;
> -			dst->dpipe_entry_index = mnl_attr_get_u64(attr);
> -		} else if (type == DEVLINK_ATTR_DPIPE_ENTRY_MATCH_VALUES) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.dpipe_entry_match_values = 1;
> -
> -			parg.rsp_policy = &devlink_dl_dpipe_entry_match_values_nest;
> -			parg.data = &dst->dpipe_entry_match_values;
> -			if (devlink_dl_dpipe_entry_match_values_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == DEVLINK_ATTR_DPIPE_ENTRY_ACTION_VALUES) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.dpipe_entry_action_values = 1;
> -
> -			parg.rsp_policy = &devlink_dl_dpipe_entry_action_values_nest;
> -			parg.data = &dst->dpipe_entry_action_values;
> -			if (devlink_dl_dpipe_entry_action_values_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == DEVLINK_ATTR_DPIPE_ENTRY_COUNTER) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.dpipe_entry_counter = 1;
> -			dst->dpipe_entry_counter = mnl_attr_get_u64(attr);
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -void devlink_dl_dpipe_header_free(struct devlink_dl_dpipe_header *obj)
> -{
> -	free(obj->dpipe_header_name);
> -	devlink_dl_dpipe_header_fields_free(&obj->dpipe_header_fields);
> -}
> -
> -int devlink_dl_dpipe_header_parse(struct ynl_parse_arg *yarg,
> -				  const struct nlattr *nested)
> -{
> -	struct devlink_dl_dpipe_header *dst = yarg->data;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -
> -	parg.ys = yarg->ys;
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_DPIPE_HEADER_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.dpipe_header_name_len = len;
> -			dst->dpipe_header_name = malloc(len + 1);
> -			memcpy(dst->dpipe_header_name, mnl_attr_get_str(attr), len);
> -			dst->dpipe_header_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_DPIPE_HEADER_ID) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.dpipe_header_id = 1;
> -			dst->dpipe_header_id = mnl_attr_get_u32(attr);
> -		} else if (type == DEVLINK_ATTR_DPIPE_HEADER_GLOBAL) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.dpipe_header_global = 1;
> -			dst->dpipe_header_global = mnl_attr_get_u8(attr);
> -		} else if (type == DEVLINK_ATTR_DPIPE_HEADER_FIELDS) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.dpipe_header_fields = 1;
> -
> -			parg.rsp_policy = &devlink_dl_dpipe_header_fields_nest;
> -			parg.data = &dst->dpipe_header_fields;
> -			if (devlink_dl_dpipe_header_fields_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -void devlink_dl_reload_stats_free(struct devlink_dl_reload_stats *obj)
> -{
> -	unsigned int i;
> -
> -	for (i = 0; i < obj->n_reload_action_info; i++)
> -		devlink_dl_reload_act_info_free(&obj->reload_action_info[i]);
> -	free(obj->reload_action_info);
> -}
> -
> -int devlink_dl_reload_stats_parse(struct ynl_parse_arg *yarg,
> -				  const struct nlattr *nested)
> -{
> -	struct devlink_dl_reload_stats *dst = yarg->data;
> -	unsigned int n_reload_action_info = 0;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -	int i;
> -
> -	parg.ys = yarg->ys;
> -
> -	if (dst->reload_action_info)
> -		return ynl_error_parse(yarg, "attribute already present (dl-reload-stats.reload-action-info)");
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_RELOAD_ACTION_INFO) {
> -			n_reload_action_info++;
> -		}
> -	}
> -
> -	if (n_reload_action_info) {
> -		dst->reload_action_info = calloc(n_reload_action_info, sizeof(*dst->reload_action_info));
> -		dst->n_reload_action_info = n_reload_action_info;
> -		i = 0;
> -		parg.rsp_policy = &devlink_dl_reload_act_info_nest;
> -		mnl_attr_for_each_nested(attr, nested) {
> -			if (mnl_attr_get_type(attr) == DEVLINK_ATTR_RELOAD_ACTION_INFO) {
> -				parg.data = &dst->reload_action_info[i];
> -				if (devlink_dl_reload_act_info_parse(&parg, attr))
> -					return MNL_CB_ERROR;
> -				i++;
> -			}
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -void devlink_dl_dpipe_tables_free(struct devlink_dl_dpipe_tables *obj)
> -{
> -	unsigned int i;
> -
> -	for (i = 0; i < obj->n_dpipe_table; i++)
> -		devlink_dl_dpipe_table_free(&obj->dpipe_table[i]);
> -	free(obj->dpipe_table);
> -}
> -
> -int devlink_dl_dpipe_tables_parse(struct ynl_parse_arg *yarg,
> -				  const struct nlattr *nested)
> -{
> -	struct devlink_dl_dpipe_tables *dst = yarg->data;
> -	unsigned int n_dpipe_table = 0;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -	int i;
> -
> -	parg.ys = yarg->ys;
> -
> -	if (dst->dpipe_table)
> -		return ynl_error_parse(yarg, "attribute already present (dl-dpipe-tables.dpipe-table)");
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_DPIPE_TABLE) {
> -			n_dpipe_table++;
> -		}
> -	}
> -
> -	if (n_dpipe_table) {
> -		dst->dpipe_table = calloc(n_dpipe_table, sizeof(*dst->dpipe_table));
> -		dst->n_dpipe_table = n_dpipe_table;
> -		i = 0;
> -		parg.rsp_policy = &devlink_dl_dpipe_table_nest;
> -		mnl_attr_for_each_nested(attr, nested) {
> -			if (mnl_attr_get_type(attr) == DEVLINK_ATTR_DPIPE_TABLE) {
> -				parg.data = &dst->dpipe_table[i];
> -				if (devlink_dl_dpipe_table_parse(&parg, attr))
> -					return MNL_CB_ERROR;
> -				i++;
> -			}
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -void devlink_dl_dpipe_entries_free(struct devlink_dl_dpipe_entries *obj)
> -{
> -	unsigned int i;
> -
> -	for (i = 0; i < obj->n_dpipe_entry; i++)
> -		devlink_dl_dpipe_entry_free(&obj->dpipe_entry[i]);
> -	free(obj->dpipe_entry);
> -}
> -
> -int devlink_dl_dpipe_entries_parse(struct ynl_parse_arg *yarg,
> -				   const struct nlattr *nested)
> -{
> -	struct devlink_dl_dpipe_entries *dst = yarg->data;
> -	unsigned int n_dpipe_entry = 0;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -	int i;
> -
> -	parg.ys = yarg->ys;
> -
> -	if (dst->dpipe_entry)
> -		return ynl_error_parse(yarg, "attribute already present (dl-dpipe-entries.dpipe-entry)");
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_DPIPE_ENTRY) {
> -			n_dpipe_entry++;
> -		}
> -	}
> -
> -	if (n_dpipe_entry) {
> -		dst->dpipe_entry = calloc(n_dpipe_entry, sizeof(*dst->dpipe_entry));
> -		dst->n_dpipe_entry = n_dpipe_entry;
> -		i = 0;
> -		parg.rsp_policy = &devlink_dl_dpipe_entry_nest;
> -		mnl_attr_for_each_nested(attr, nested) {
> -			if (mnl_attr_get_type(attr) == DEVLINK_ATTR_DPIPE_ENTRY) {
> -				parg.data = &dst->dpipe_entry[i];
> -				if (devlink_dl_dpipe_entry_parse(&parg, attr))
> -					return MNL_CB_ERROR;
> -				i++;
> -			}
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -void devlink_dl_dpipe_headers_free(struct devlink_dl_dpipe_headers *obj)
> -{
> -	unsigned int i;
> -
> -	for (i = 0; i < obj->n_dpipe_header; i++)
> -		devlink_dl_dpipe_header_free(&obj->dpipe_header[i]);
> -	free(obj->dpipe_header);
> -}
> -
> -int devlink_dl_dpipe_headers_parse(struct ynl_parse_arg *yarg,
> -				   const struct nlattr *nested)
> -{
> -	struct devlink_dl_dpipe_headers *dst = yarg->data;
> -	unsigned int n_dpipe_header = 0;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -	int i;
> -
> -	parg.ys = yarg->ys;
> -
> -	if (dst->dpipe_header)
> -		return ynl_error_parse(yarg, "attribute already present (dl-dpipe-headers.dpipe-header)");
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_DPIPE_HEADER) {
> -			n_dpipe_header++;
> -		}
> -	}
> -
> -	if (n_dpipe_header) {
> -		dst->dpipe_header = calloc(n_dpipe_header, sizeof(*dst->dpipe_header));
> -		dst->n_dpipe_header = n_dpipe_header;
> -		i = 0;
> -		parg.rsp_policy = &devlink_dl_dpipe_header_nest;
> -		mnl_attr_for_each_nested(attr, nested) {
> -			if (mnl_attr_get_type(attr) == DEVLINK_ATTR_DPIPE_HEADER) {
> -				parg.data = &dst->dpipe_header[i];
> -				if (devlink_dl_dpipe_header_parse(&parg, attr))
> -					return MNL_CB_ERROR;
> -				i++;
> -			}
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -void devlink_dl_dev_stats_free(struct devlink_dl_dev_stats *obj)
> -{
> -	devlink_dl_reload_stats_free(&obj->reload_stats);
> -	devlink_dl_reload_stats_free(&obj->remote_reload_stats);
> -}
> -
> -int devlink_dl_dev_stats_parse(struct ynl_parse_arg *yarg,
> -			       const struct nlattr *nested)
> -{
> -	struct devlink_dl_dev_stats *dst = yarg->data;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -
> -	parg.ys = yarg->ys;
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_RELOAD_STATS) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.reload_stats = 1;
> -
> -			parg.rsp_policy = &devlink_dl_reload_stats_nest;
> -			parg.data = &dst->reload_stats;
> -			if (devlink_dl_reload_stats_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == DEVLINK_ATTR_REMOTE_RELOAD_STATS) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.remote_reload_stats = 1;
> -
> -			parg.rsp_policy = &devlink_dl_reload_stats_nest;
> -			parg.data = &dst->remote_reload_stats;
> -			if (devlink_dl_reload_stats_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -/* ============== DEVLINK_CMD_GET ============== */
> -/* DEVLINK_CMD_GET - do */
> -void devlink_get_req_free(struct devlink_get_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req);
> -}
> -
> -void devlink_get_rsp_free(struct devlink_get_rsp *rsp)
> -{
> -	free(rsp->bus_name);
> -	free(rsp->dev_name);
> -	devlink_dl_dev_stats_free(&rsp->dev_stats);
> -	free(rsp);
> -}
> -
> -int devlink_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct ynl_parse_arg *yarg = data;
> -	struct devlink_get_rsp *dst;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -
> -	dst = yarg->data;
> -	parg.ys = yarg->ys;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_BUS_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.bus_name_len = len;
> -			dst->bus_name = malloc(len + 1);
> -			memcpy(dst->bus_name, mnl_attr_get_str(attr), len);
> -			dst->bus_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_DEV_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.dev_name_len = len;
> -			dst->dev_name = malloc(len + 1);
> -			memcpy(dst->dev_name, mnl_attr_get_str(attr), len);
> -			dst->dev_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_RELOAD_FAILED) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.reload_failed = 1;
> -			dst->reload_failed = mnl_attr_get_u8(attr);
> -		} else if (type == DEVLINK_ATTR_DEV_STATS) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.dev_stats = 1;
> -
> -			parg.rsp_policy = &devlink_dl_dev_stats_nest;
> -			parg.data = &dst->dev_stats;
> -			if (devlink_dl_dev_stats_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct devlink_get_rsp *
> -devlink_get(struct ynl_sock *ys, struct devlink_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct devlink_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_GET, 1);
> -	ys->req_policy = &devlink_nest;
> -	yrs.yarg.rsp_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = devlink_get_rsp_parse;
> -	yrs.rsp_cmd = 3;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	devlink_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* DEVLINK_CMD_GET - dump */
> -void devlink_get_list_free(struct devlink_get_list *rsp)
> -{
> -	struct devlink_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		free(rsp->obj.bus_name);
> -		free(rsp->obj.dev_name);
> -		devlink_dl_dev_stats_free(&rsp->obj.dev_stats);
> -		free(rsp);
> -	}
> -}
> -
> -struct devlink_get_list *devlink_get_dump(struct ynl_sock *ys)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct devlink_get_list);
> -	yds.cb = devlink_get_rsp_parse;
> -	yds.rsp_cmd = 3;
> -	yds.rsp_policy = &devlink_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_GET, 1);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	devlink_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ============== DEVLINK_CMD_PORT_GET ============== */
> -/* DEVLINK_CMD_PORT_GET - do */
> -void devlink_port_get_req_free(struct devlink_port_get_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req);
> -}
> -
> -void devlink_port_get_rsp_free(struct devlink_port_get_rsp *rsp)
> -{
> -	free(rsp->bus_name);
> -	free(rsp->dev_name);
> -	free(rsp);
> -}
> -
> -int devlink_port_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct ynl_parse_arg *yarg = data;
> -	struct devlink_port_get_rsp *dst;
> -	const struct nlattr *attr;
> -
> -	dst = yarg->data;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_BUS_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.bus_name_len = len;
> -			dst->bus_name = malloc(len + 1);
> -			memcpy(dst->bus_name, mnl_attr_get_str(attr), len);
> -			dst->bus_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_DEV_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.dev_name_len = len;
> -			dst->dev_name = malloc(len + 1);
> -			memcpy(dst->dev_name, mnl_attr_get_str(attr), len);
> -			dst->dev_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_PORT_INDEX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.port_index = 1;
> -			dst->port_index = mnl_attr_get_u32(attr);
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct devlink_port_get_rsp *
> -devlink_port_get(struct ynl_sock *ys, struct devlink_port_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct devlink_port_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_PORT_GET, 1);
> -	ys->req_policy = &devlink_nest;
> -	yrs.yarg.rsp_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.port_index)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PORT_INDEX, req->port_index);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = devlink_port_get_rsp_parse;
> -	yrs.rsp_cmd = 7;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	devlink_port_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* DEVLINK_CMD_PORT_GET - dump */
> -int devlink_port_get_rsp_dump_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct devlink_port_get_rsp_dump *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -
> -	dst = yarg->data;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_BUS_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.bus_name_len = len;
> -			dst->bus_name = malloc(len + 1);
> -			memcpy(dst->bus_name, mnl_attr_get_str(attr), len);
> -			dst->bus_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_DEV_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.dev_name_len = len;
> -			dst->dev_name = malloc(len + 1);
> -			memcpy(dst->dev_name, mnl_attr_get_str(attr), len);
> -			dst->dev_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_PORT_INDEX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.port_index = 1;
> -			dst->port_index = mnl_attr_get_u32(attr);
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -void devlink_port_get_rsp_list_free(struct devlink_port_get_rsp_list *rsp)
> -{
> -	struct devlink_port_get_rsp_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		free(rsp->obj.bus_name);
> -		free(rsp->obj.dev_name);
> -		free(rsp);
> -	}
> -}
> -
> -struct devlink_port_get_rsp_list *
> -devlink_port_get_dump(struct ynl_sock *ys,
> -		      struct devlink_port_get_req_dump *req)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct devlink_port_get_rsp_list);
> -	yds.cb = devlink_port_get_rsp_dump_parse;
> -	yds.rsp_cmd = 7;
> -	yds.rsp_policy = &devlink_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_PORT_GET, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	devlink_port_get_rsp_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ============== DEVLINK_CMD_PORT_SET ============== */
> -/* DEVLINK_CMD_PORT_SET - do */
> -void devlink_port_set_req_free(struct devlink_port_set_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	devlink_dl_port_function_free(&req->port_function);
> -	free(req);
> -}
> -
> -int devlink_port_set(struct ynl_sock *ys, struct devlink_port_set_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_PORT_SET, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.port_index)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PORT_INDEX, req->port_index);
> -	if (req->_present.port_type)
> -		mnl_attr_put_u16(nlh, DEVLINK_ATTR_PORT_TYPE, req->port_type);
> -	if (req->_present.port_function)
> -		devlink_dl_port_function_put(nlh, DEVLINK_ATTR_PORT_FUNCTION, &req->port_function);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== DEVLINK_CMD_PORT_NEW ============== */
> -/* DEVLINK_CMD_PORT_NEW - do */
> -void devlink_port_new_req_free(struct devlink_port_new_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req);
> -}
> -
> -void devlink_port_new_rsp_free(struct devlink_port_new_rsp *rsp)
> -{
> -	free(rsp->bus_name);
> -	free(rsp->dev_name);
> -	free(rsp);
> -}
> -
> -int devlink_port_new_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct ynl_parse_arg *yarg = data;
> -	struct devlink_port_new_rsp *dst;
> -	const struct nlattr *attr;
> -
> -	dst = yarg->data;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_BUS_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.bus_name_len = len;
> -			dst->bus_name = malloc(len + 1);
> -			memcpy(dst->bus_name, mnl_attr_get_str(attr), len);
> -			dst->bus_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_DEV_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.dev_name_len = len;
> -			dst->dev_name = malloc(len + 1);
> -			memcpy(dst->dev_name, mnl_attr_get_str(attr), len);
> -			dst->dev_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_PORT_INDEX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.port_index = 1;
> -			dst->port_index = mnl_attr_get_u32(attr);
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct devlink_port_new_rsp *
> -devlink_port_new(struct ynl_sock *ys, struct devlink_port_new_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct devlink_port_new_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_PORT_NEW, 1);
> -	ys->req_policy = &devlink_nest;
> -	yrs.yarg.rsp_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.port_index)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PORT_INDEX, req->port_index);
> -	if (req->_present.port_flavour)
> -		mnl_attr_put_u16(nlh, DEVLINK_ATTR_PORT_FLAVOUR, req->port_flavour);
> -	if (req->_present.port_pci_pf_number)
> -		mnl_attr_put_u16(nlh, DEVLINK_ATTR_PORT_PCI_PF_NUMBER, req->port_pci_pf_number);
> -	if (req->_present.port_pci_sf_number)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PORT_PCI_SF_NUMBER, req->port_pci_sf_number);
> -	if (req->_present.port_controller_number)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PORT_CONTROLLER_NUMBER, req->port_controller_number);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = devlink_port_new_rsp_parse;
> -	yrs.rsp_cmd = DEVLINK_CMD_PORT_NEW;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	devlink_port_new_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* ============== DEVLINK_CMD_PORT_DEL ============== */
> -/* DEVLINK_CMD_PORT_DEL - do */
> -void devlink_port_del_req_free(struct devlink_port_del_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req);
> -}
> -
> -int devlink_port_del(struct ynl_sock *ys, struct devlink_port_del_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_PORT_DEL, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.port_index)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PORT_INDEX, req->port_index);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== DEVLINK_CMD_PORT_SPLIT ============== */
> -/* DEVLINK_CMD_PORT_SPLIT - do */
> -void devlink_port_split_req_free(struct devlink_port_split_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req);
> -}
> -
> -int devlink_port_split(struct ynl_sock *ys, struct devlink_port_split_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_PORT_SPLIT, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.port_index)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PORT_INDEX, req->port_index);
> -	if (req->_present.port_split_count)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PORT_SPLIT_COUNT, req->port_split_count);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== DEVLINK_CMD_PORT_UNSPLIT ============== */
> -/* DEVLINK_CMD_PORT_UNSPLIT - do */
> -void devlink_port_unsplit_req_free(struct devlink_port_unsplit_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req);
> -}
> -
> -int devlink_port_unsplit(struct ynl_sock *ys,
> -			 struct devlink_port_unsplit_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_PORT_UNSPLIT, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.port_index)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PORT_INDEX, req->port_index);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== DEVLINK_CMD_SB_GET ============== */
> -/* DEVLINK_CMD_SB_GET - do */
> -void devlink_sb_get_req_free(struct devlink_sb_get_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req);
> -}
> -
> -void devlink_sb_get_rsp_free(struct devlink_sb_get_rsp *rsp)
> -{
> -	free(rsp->bus_name);
> -	free(rsp->dev_name);
> -	free(rsp);
> -}
> -
> -int devlink_sb_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct ynl_parse_arg *yarg = data;
> -	struct devlink_sb_get_rsp *dst;
> -	const struct nlattr *attr;
> -
> -	dst = yarg->data;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_BUS_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.bus_name_len = len;
> -			dst->bus_name = malloc(len + 1);
> -			memcpy(dst->bus_name, mnl_attr_get_str(attr), len);
> -			dst->bus_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_DEV_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.dev_name_len = len;
> -			dst->dev_name = malloc(len + 1);
> -			memcpy(dst->dev_name, mnl_attr_get_str(attr), len);
> -			dst->dev_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_SB_INDEX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.sb_index = 1;
> -			dst->sb_index = mnl_attr_get_u32(attr);
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct devlink_sb_get_rsp *
> -devlink_sb_get(struct ynl_sock *ys, struct devlink_sb_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct devlink_sb_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_SB_GET, 1);
> -	ys->req_policy = &devlink_nest;
> -	yrs.yarg.rsp_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.sb_index)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_SB_INDEX, req->sb_index);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = devlink_sb_get_rsp_parse;
> -	yrs.rsp_cmd = 13;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	devlink_sb_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* DEVLINK_CMD_SB_GET - dump */
> -void devlink_sb_get_list_free(struct devlink_sb_get_list *rsp)
> -{
> -	struct devlink_sb_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		free(rsp->obj.bus_name);
> -		free(rsp->obj.dev_name);
> -		free(rsp);
> -	}
> -}
> -
> -struct devlink_sb_get_list *
> -devlink_sb_get_dump(struct ynl_sock *ys, struct devlink_sb_get_req_dump *req)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct devlink_sb_get_list);
> -	yds.cb = devlink_sb_get_rsp_parse;
> -	yds.rsp_cmd = 13;
> -	yds.rsp_policy = &devlink_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_SB_GET, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	devlink_sb_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ============== DEVLINK_CMD_SB_POOL_GET ============== */
> -/* DEVLINK_CMD_SB_POOL_GET - do */
> -void devlink_sb_pool_get_req_free(struct devlink_sb_pool_get_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req);
> -}
> -
> -void devlink_sb_pool_get_rsp_free(struct devlink_sb_pool_get_rsp *rsp)
> -{
> -	free(rsp->bus_name);
> -	free(rsp->dev_name);
> -	free(rsp);
> -}
> -
> -int devlink_sb_pool_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct devlink_sb_pool_get_rsp *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -
> -	dst = yarg->data;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_BUS_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.bus_name_len = len;
> -			dst->bus_name = malloc(len + 1);
> -			memcpy(dst->bus_name, mnl_attr_get_str(attr), len);
> -			dst->bus_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_DEV_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.dev_name_len = len;
> -			dst->dev_name = malloc(len + 1);
> -			memcpy(dst->dev_name, mnl_attr_get_str(attr), len);
> -			dst->dev_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_SB_INDEX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.sb_index = 1;
> -			dst->sb_index = mnl_attr_get_u32(attr);
> -		} else if (type == DEVLINK_ATTR_SB_POOL_INDEX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.sb_pool_index = 1;
> -			dst->sb_pool_index = mnl_attr_get_u16(attr);
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct devlink_sb_pool_get_rsp *
> -devlink_sb_pool_get(struct ynl_sock *ys, struct devlink_sb_pool_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct devlink_sb_pool_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_SB_POOL_GET, 1);
> -	ys->req_policy = &devlink_nest;
> -	yrs.yarg.rsp_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.sb_index)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_SB_INDEX, req->sb_index);
> -	if (req->_present.sb_pool_index)
> -		mnl_attr_put_u16(nlh, DEVLINK_ATTR_SB_POOL_INDEX, req->sb_pool_index);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = devlink_sb_pool_get_rsp_parse;
> -	yrs.rsp_cmd = 17;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	devlink_sb_pool_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* DEVLINK_CMD_SB_POOL_GET - dump */
> -void devlink_sb_pool_get_list_free(struct devlink_sb_pool_get_list *rsp)
> -{
> -	struct devlink_sb_pool_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		free(rsp->obj.bus_name);
> -		free(rsp->obj.dev_name);
> -		free(rsp);
> -	}
> -}
> -
> -struct devlink_sb_pool_get_list *
> -devlink_sb_pool_get_dump(struct ynl_sock *ys,
> -			 struct devlink_sb_pool_get_req_dump *req)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct devlink_sb_pool_get_list);
> -	yds.cb = devlink_sb_pool_get_rsp_parse;
> -	yds.rsp_cmd = 17;
> -	yds.rsp_policy = &devlink_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_SB_POOL_GET, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	devlink_sb_pool_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ============== DEVLINK_CMD_SB_POOL_SET ============== */
> -/* DEVLINK_CMD_SB_POOL_SET - do */
> -void devlink_sb_pool_set_req_free(struct devlink_sb_pool_set_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req);
> -}
> -
> -int devlink_sb_pool_set(struct ynl_sock *ys,
> -			struct devlink_sb_pool_set_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_SB_POOL_SET, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.sb_index)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_SB_INDEX, req->sb_index);
> -	if (req->_present.sb_pool_index)
> -		mnl_attr_put_u16(nlh, DEVLINK_ATTR_SB_POOL_INDEX, req->sb_pool_index);
> -	if (req->_present.sb_pool_threshold_type)
> -		mnl_attr_put_u8(nlh, DEVLINK_ATTR_SB_POOL_THRESHOLD_TYPE, req->sb_pool_threshold_type);
> -	if (req->_present.sb_pool_size)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_SB_POOL_SIZE, req->sb_pool_size);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== DEVLINK_CMD_SB_PORT_POOL_GET ============== */
> -/* DEVLINK_CMD_SB_PORT_POOL_GET - do */
> -void
> -devlink_sb_port_pool_get_req_free(struct devlink_sb_port_pool_get_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req);
> -}
> -
> -void
> -devlink_sb_port_pool_get_rsp_free(struct devlink_sb_port_pool_get_rsp *rsp)
> -{
> -	free(rsp->bus_name);
> -	free(rsp->dev_name);
> -	free(rsp);
> -}
> -
> -int devlink_sb_port_pool_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct devlink_sb_port_pool_get_rsp *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -
> -	dst = yarg->data;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_BUS_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.bus_name_len = len;
> -			dst->bus_name = malloc(len + 1);
> -			memcpy(dst->bus_name, mnl_attr_get_str(attr), len);
> -			dst->bus_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_DEV_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.dev_name_len = len;
> -			dst->dev_name = malloc(len + 1);
> -			memcpy(dst->dev_name, mnl_attr_get_str(attr), len);
> -			dst->dev_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_PORT_INDEX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.port_index = 1;
> -			dst->port_index = mnl_attr_get_u32(attr);
> -		} else if (type == DEVLINK_ATTR_SB_INDEX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.sb_index = 1;
> -			dst->sb_index = mnl_attr_get_u32(attr);
> -		} else if (type == DEVLINK_ATTR_SB_POOL_INDEX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.sb_pool_index = 1;
> -			dst->sb_pool_index = mnl_attr_get_u16(attr);
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct devlink_sb_port_pool_get_rsp *
> -devlink_sb_port_pool_get(struct ynl_sock *ys,
> -			 struct devlink_sb_port_pool_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct devlink_sb_port_pool_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_SB_PORT_POOL_GET, 1);
> -	ys->req_policy = &devlink_nest;
> -	yrs.yarg.rsp_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.port_index)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PORT_INDEX, req->port_index);
> -	if (req->_present.sb_index)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_SB_INDEX, req->sb_index);
> -	if (req->_present.sb_pool_index)
> -		mnl_attr_put_u16(nlh, DEVLINK_ATTR_SB_POOL_INDEX, req->sb_pool_index);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = devlink_sb_port_pool_get_rsp_parse;
> -	yrs.rsp_cmd = 21;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	devlink_sb_port_pool_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* DEVLINK_CMD_SB_PORT_POOL_GET - dump */
> -void
> -devlink_sb_port_pool_get_list_free(struct devlink_sb_port_pool_get_list *rsp)
> -{
> -	struct devlink_sb_port_pool_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		free(rsp->obj.bus_name);
> -		free(rsp->obj.dev_name);
> -		free(rsp);
> -	}
> -}
> -
> -struct devlink_sb_port_pool_get_list *
> -devlink_sb_port_pool_get_dump(struct ynl_sock *ys,
> -			      struct devlink_sb_port_pool_get_req_dump *req)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct devlink_sb_port_pool_get_list);
> -	yds.cb = devlink_sb_port_pool_get_rsp_parse;
> -	yds.rsp_cmd = 21;
> -	yds.rsp_policy = &devlink_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_SB_PORT_POOL_GET, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	devlink_sb_port_pool_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ============== DEVLINK_CMD_SB_PORT_POOL_SET ============== */
> -/* DEVLINK_CMD_SB_PORT_POOL_SET - do */
> -void
> -devlink_sb_port_pool_set_req_free(struct devlink_sb_port_pool_set_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req);
> -}
> -
> -int devlink_sb_port_pool_set(struct ynl_sock *ys,
> -			     struct devlink_sb_port_pool_set_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_SB_PORT_POOL_SET, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.port_index)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PORT_INDEX, req->port_index);
> -	if (req->_present.sb_index)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_SB_INDEX, req->sb_index);
> -	if (req->_present.sb_pool_index)
> -		mnl_attr_put_u16(nlh, DEVLINK_ATTR_SB_POOL_INDEX, req->sb_pool_index);
> -	if (req->_present.sb_threshold)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_SB_THRESHOLD, req->sb_threshold);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== DEVLINK_CMD_SB_TC_POOL_BIND_GET ============== */
> -/* DEVLINK_CMD_SB_TC_POOL_BIND_GET - do */
> -void
> -devlink_sb_tc_pool_bind_get_req_free(struct devlink_sb_tc_pool_bind_get_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req);
> -}
> -
> -void
> -devlink_sb_tc_pool_bind_get_rsp_free(struct devlink_sb_tc_pool_bind_get_rsp *rsp)
> -{
> -	free(rsp->bus_name);
> -	free(rsp->dev_name);
> -	free(rsp);
> -}
> -
> -int devlink_sb_tc_pool_bind_get_rsp_parse(const struct nlmsghdr *nlh,
> -					  void *data)
> -{
> -	struct devlink_sb_tc_pool_bind_get_rsp *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -
> -	dst = yarg->data;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_BUS_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.bus_name_len = len;
> -			dst->bus_name = malloc(len + 1);
> -			memcpy(dst->bus_name, mnl_attr_get_str(attr), len);
> -			dst->bus_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_DEV_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.dev_name_len = len;
> -			dst->dev_name = malloc(len + 1);
> -			memcpy(dst->dev_name, mnl_attr_get_str(attr), len);
> -			dst->dev_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_PORT_INDEX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.port_index = 1;
> -			dst->port_index = mnl_attr_get_u32(attr);
> -		} else if (type == DEVLINK_ATTR_SB_INDEX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.sb_index = 1;
> -			dst->sb_index = mnl_attr_get_u32(attr);
> -		} else if (type == DEVLINK_ATTR_SB_POOL_TYPE) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.sb_pool_type = 1;
> -			dst->sb_pool_type = mnl_attr_get_u8(attr);
> -		} else if (type == DEVLINK_ATTR_SB_TC_INDEX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.sb_tc_index = 1;
> -			dst->sb_tc_index = mnl_attr_get_u16(attr);
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct devlink_sb_tc_pool_bind_get_rsp *
> -devlink_sb_tc_pool_bind_get(struct ynl_sock *ys,
> -			    struct devlink_sb_tc_pool_bind_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct devlink_sb_tc_pool_bind_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_SB_TC_POOL_BIND_GET, 1);
> -	ys->req_policy = &devlink_nest;
> -	yrs.yarg.rsp_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.port_index)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PORT_INDEX, req->port_index);
> -	if (req->_present.sb_index)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_SB_INDEX, req->sb_index);
> -	if (req->_present.sb_pool_type)
> -		mnl_attr_put_u8(nlh, DEVLINK_ATTR_SB_POOL_TYPE, req->sb_pool_type);
> -	if (req->_present.sb_tc_index)
> -		mnl_attr_put_u16(nlh, DEVLINK_ATTR_SB_TC_INDEX, req->sb_tc_index);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = devlink_sb_tc_pool_bind_get_rsp_parse;
> -	yrs.rsp_cmd = 25;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	devlink_sb_tc_pool_bind_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* DEVLINK_CMD_SB_TC_POOL_BIND_GET - dump */
> -void
> -devlink_sb_tc_pool_bind_get_list_free(struct devlink_sb_tc_pool_bind_get_list *rsp)
> -{
> -	struct devlink_sb_tc_pool_bind_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		free(rsp->obj.bus_name);
> -		free(rsp->obj.dev_name);
> -		free(rsp);
> -	}
> -}
> -
> -struct devlink_sb_tc_pool_bind_get_list *
> -devlink_sb_tc_pool_bind_get_dump(struct ynl_sock *ys,
> -				 struct devlink_sb_tc_pool_bind_get_req_dump *req)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct devlink_sb_tc_pool_bind_get_list);
> -	yds.cb = devlink_sb_tc_pool_bind_get_rsp_parse;
> -	yds.rsp_cmd = 25;
> -	yds.rsp_policy = &devlink_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_SB_TC_POOL_BIND_GET, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	devlink_sb_tc_pool_bind_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ============== DEVLINK_CMD_SB_TC_POOL_BIND_SET ============== */
> -/* DEVLINK_CMD_SB_TC_POOL_BIND_SET - do */
> -void
> -devlink_sb_tc_pool_bind_set_req_free(struct devlink_sb_tc_pool_bind_set_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req);
> -}
> -
> -int devlink_sb_tc_pool_bind_set(struct ynl_sock *ys,
> -				struct devlink_sb_tc_pool_bind_set_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_SB_TC_POOL_BIND_SET, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.port_index)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PORT_INDEX, req->port_index);
> -	if (req->_present.sb_index)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_SB_INDEX, req->sb_index);
> -	if (req->_present.sb_pool_index)
> -		mnl_attr_put_u16(nlh, DEVLINK_ATTR_SB_POOL_INDEX, req->sb_pool_index);
> -	if (req->_present.sb_pool_type)
> -		mnl_attr_put_u8(nlh, DEVLINK_ATTR_SB_POOL_TYPE, req->sb_pool_type);
> -	if (req->_present.sb_tc_index)
> -		mnl_attr_put_u16(nlh, DEVLINK_ATTR_SB_TC_INDEX, req->sb_tc_index);
> -	if (req->_present.sb_threshold)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_SB_THRESHOLD, req->sb_threshold);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== DEVLINK_CMD_SB_OCC_SNAPSHOT ============== */
> -/* DEVLINK_CMD_SB_OCC_SNAPSHOT - do */
> -void devlink_sb_occ_snapshot_req_free(struct devlink_sb_occ_snapshot_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req);
> -}
> -
> -int devlink_sb_occ_snapshot(struct ynl_sock *ys,
> -			    struct devlink_sb_occ_snapshot_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_SB_OCC_SNAPSHOT, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.sb_index)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_SB_INDEX, req->sb_index);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== DEVLINK_CMD_SB_OCC_MAX_CLEAR ============== */
> -/* DEVLINK_CMD_SB_OCC_MAX_CLEAR - do */
> -void
> -devlink_sb_occ_max_clear_req_free(struct devlink_sb_occ_max_clear_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req);
> -}
> -
> -int devlink_sb_occ_max_clear(struct ynl_sock *ys,
> -			     struct devlink_sb_occ_max_clear_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_SB_OCC_MAX_CLEAR, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.sb_index)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_SB_INDEX, req->sb_index);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== DEVLINK_CMD_ESWITCH_GET ============== */
> -/* DEVLINK_CMD_ESWITCH_GET - do */
> -void devlink_eswitch_get_req_free(struct devlink_eswitch_get_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req);
> -}
> -
> -void devlink_eswitch_get_rsp_free(struct devlink_eswitch_get_rsp *rsp)
> -{
> -	free(rsp->bus_name);
> -	free(rsp->dev_name);
> -	free(rsp);
> -}
> -
> -int devlink_eswitch_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct devlink_eswitch_get_rsp *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -
> -	dst = yarg->data;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_BUS_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.bus_name_len = len;
> -			dst->bus_name = malloc(len + 1);
> -			memcpy(dst->bus_name, mnl_attr_get_str(attr), len);
> -			dst->bus_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_DEV_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.dev_name_len = len;
> -			dst->dev_name = malloc(len + 1);
> -			memcpy(dst->dev_name, mnl_attr_get_str(attr), len);
> -			dst->dev_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_ESWITCH_MODE) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.eswitch_mode = 1;
> -			dst->eswitch_mode = mnl_attr_get_u16(attr);
> -		} else if (type == DEVLINK_ATTR_ESWITCH_INLINE_MODE) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.eswitch_inline_mode = 1;
> -			dst->eswitch_inline_mode = mnl_attr_get_u16(attr);
> -		} else if (type == DEVLINK_ATTR_ESWITCH_ENCAP_MODE) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.eswitch_encap_mode = 1;
> -			dst->eswitch_encap_mode = mnl_attr_get_u8(attr);
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct devlink_eswitch_get_rsp *
> -devlink_eswitch_get(struct ynl_sock *ys, struct devlink_eswitch_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct devlink_eswitch_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_ESWITCH_GET, 1);
> -	ys->req_policy = &devlink_nest;
> -	yrs.yarg.rsp_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = devlink_eswitch_get_rsp_parse;
> -	yrs.rsp_cmd = DEVLINK_CMD_ESWITCH_GET;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	devlink_eswitch_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* ============== DEVLINK_CMD_ESWITCH_SET ============== */
> -/* DEVLINK_CMD_ESWITCH_SET - do */
> -void devlink_eswitch_set_req_free(struct devlink_eswitch_set_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req);
> -}
> -
> -int devlink_eswitch_set(struct ynl_sock *ys,
> -			struct devlink_eswitch_set_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_ESWITCH_SET, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.eswitch_mode)
> -		mnl_attr_put_u16(nlh, DEVLINK_ATTR_ESWITCH_MODE, req->eswitch_mode);
> -	if (req->_present.eswitch_inline_mode)
> -		mnl_attr_put_u16(nlh, DEVLINK_ATTR_ESWITCH_INLINE_MODE, req->eswitch_inline_mode);
> -	if (req->_present.eswitch_encap_mode)
> -		mnl_attr_put_u8(nlh, DEVLINK_ATTR_ESWITCH_ENCAP_MODE, req->eswitch_encap_mode);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== DEVLINK_CMD_DPIPE_TABLE_GET ============== */
> -/* DEVLINK_CMD_DPIPE_TABLE_GET - do */
> -void devlink_dpipe_table_get_req_free(struct devlink_dpipe_table_get_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req->dpipe_table_name);
> -	free(req);
> -}
> -
> -void devlink_dpipe_table_get_rsp_free(struct devlink_dpipe_table_get_rsp *rsp)
> -{
> -	free(rsp->bus_name);
> -	free(rsp->dev_name);
> -	devlink_dl_dpipe_tables_free(&rsp->dpipe_tables);
> -	free(rsp);
> -}
> -
> -int devlink_dpipe_table_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct devlink_dpipe_table_get_rsp *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -
> -	dst = yarg->data;
> -	parg.ys = yarg->ys;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_BUS_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.bus_name_len = len;
> -			dst->bus_name = malloc(len + 1);
> -			memcpy(dst->bus_name, mnl_attr_get_str(attr), len);
> -			dst->bus_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_DEV_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.dev_name_len = len;
> -			dst->dev_name = malloc(len + 1);
> -			memcpy(dst->dev_name, mnl_attr_get_str(attr), len);
> -			dst->dev_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_DPIPE_TABLES) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.dpipe_tables = 1;
> -
> -			parg.rsp_policy = &devlink_dl_dpipe_tables_nest;
> -			parg.data = &dst->dpipe_tables;
> -			if (devlink_dl_dpipe_tables_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct devlink_dpipe_table_get_rsp *
> -devlink_dpipe_table_get(struct ynl_sock *ys,
> -			struct devlink_dpipe_table_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct devlink_dpipe_table_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_DPIPE_TABLE_GET, 1);
> -	ys->req_policy = &devlink_nest;
> -	yrs.yarg.rsp_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.dpipe_table_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DPIPE_TABLE_NAME, req->dpipe_table_name);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = devlink_dpipe_table_get_rsp_parse;
> -	yrs.rsp_cmd = DEVLINK_CMD_DPIPE_TABLE_GET;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	devlink_dpipe_table_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* ============== DEVLINK_CMD_DPIPE_ENTRIES_GET ============== */
> -/* DEVLINK_CMD_DPIPE_ENTRIES_GET - do */
> -void
> -devlink_dpipe_entries_get_req_free(struct devlink_dpipe_entries_get_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req->dpipe_table_name);
> -	free(req);
> -}
> -
> -void
> -devlink_dpipe_entries_get_rsp_free(struct devlink_dpipe_entries_get_rsp *rsp)
> -{
> -	free(rsp->bus_name);
> -	free(rsp->dev_name);
> -	devlink_dl_dpipe_entries_free(&rsp->dpipe_entries);
> -	free(rsp);
> -}
> -
> -int devlink_dpipe_entries_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct devlink_dpipe_entries_get_rsp *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -
> -	dst = yarg->data;
> -	parg.ys = yarg->ys;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_BUS_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.bus_name_len = len;
> -			dst->bus_name = malloc(len + 1);
> -			memcpy(dst->bus_name, mnl_attr_get_str(attr), len);
> -			dst->bus_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_DEV_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.dev_name_len = len;
> -			dst->dev_name = malloc(len + 1);
> -			memcpy(dst->dev_name, mnl_attr_get_str(attr), len);
> -			dst->dev_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_DPIPE_ENTRIES) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.dpipe_entries = 1;
> -
> -			parg.rsp_policy = &devlink_dl_dpipe_entries_nest;
> -			parg.data = &dst->dpipe_entries;
> -			if (devlink_dl_dpipe_entries_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct devlink_dpipe_entries_get_rsp *
> -devlink_dpipe_entries_get(struct ynl_sock *ys,
> -			  struct devlink_dpipe_entries_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct devlink_dpipe_entries_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_DPIPE_ENTRIES_GET, 1);
> -	ys->req_policy = &devlink_nest;
> -	yrs.yarg.rsp_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.dpipe_table_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DPIPE_TABLE_NAME, req->dpipe_table_name);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = devlink_dpipe_entries_get_rsp_parse;
> -	yrs.rsp_cmd = DEVLINK_CMD_DPIPE_ENTRIES_GET;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	devlink_dpipe_entries_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* ============== DEVLINK_CMD_DPIPE_HEADERS_GET ============== */
> -/* DEVLINK_CMD_DPIPE_HEADERS_GET - do */
> -void
> -devlink_dpipe_headers_get_req_free(struct devlink_dpipe_headers_get_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req);
> -}
> -
> -void
> -devlink_dpipe_headers_get_rsp_free(struct devlink_dpipe_headers_get_rsp *rsp)
> -{
> -	free(rsp->bus_name);
> -	free(rsp->dev_name);
> -	devlink_dl_dpipe_headers_free(&rsp->dpipe_headers);
> -	free(rsp);
> -}
> -
> -int devlink_dpipe_headers_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct devlink_dpipe_headers_get_rsp *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -
> -	dst = yarg->data;
> -	parg.ys = yarg->ys;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_BUS_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.bus_name_len = len;
> -			dst->bus_name = malloc(len + 1);
> -			memcpy(dst->bus_name, mnl_attr_get_str(attr), len);
> -			dst->bus_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_DEV_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.dev_name_len = len;
> -			dst->dev_name = malloc(len + 1);
> -			memcpy(dst->dev_name, mnl_attr_get_str(attr), len);
> -			dst->dev_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_DPIPE_HEADERS) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.dpipe_headers = 1;
> -
> -			parg.rsp_policy = &devlink_dl_dpipe_headers_nest;
> -			parg.data = &dst->dpipe_headers;
> -			if (devlink_dl_dpipe_headers_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct devlink_dpipe_headers_get_rsp *
> -devlink_dpipe_headers_get(struct ynl_sock *ys,
> -			  struct devlink_dpipe_headers_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct devlink_dpipe_headers_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_DPIPE_HEADERS_GET, 1);
> -	ys->req_policy = &devlink_nest;
> -	yrs.yarg.rsp_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = devlink_dpipe_headers_get_rsp_parse;
> -	yrs.rsp_cmd = DEVLINK_CMD_DPIPE_HEADERS_GET;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	devlink_dpipe_headers_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* ============== DEVLINK_CMD_DPIPE_TABLE_COUNTERS_SET ============== */
> -/* DEVLINK_CMD_DPIPE_TABLE_COUNTERS_SET - do */
> -void
> -devlink_dpipe_table_counters_set_req_free(struct devlink_dpipe_table_counters_set_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req->dpipe_table_name);
> -	free(req);
> -}
> -
> -int devlink_dpipe_table_counters_set(struct ynl_sock *ys,
> -				     struct devlink_dpipe_table_counters_set_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_DPIPE_TABLE_COUNTERS_SET, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.dpipe_table_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DPIPE_TABLE_NAME, req->dpipe_table_name);
> -	if (req->_present.dpipe_table_counters_enabled)
> -		mnl_attr_put_u8(nlh, DEVLINK_ATTR_DPIPE_TABLE_COUNTERS_ENABLED, req->dpipe_table_counters_enabled);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== DEVLINK_CMD_RESOURCE_SET ============== */
> -/* DEVLINK_CMD_RESOURCE_SET - do */
> -void devlink_resource_set_req_free(struct devlink_resource_set_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req);
> -}
> -
> -int devlink_resource_set(struct ynl_sock *ys,
> -			 struct devlink_resource_set_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_RESOURCE_SET, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.resource_id)
> -		mnl_attr_put_u64(nlh, DEVLINK_ATTR_RESOURCE_ID, req->resource_id);
> -	if (req->_present.resource_size)
> -		mnl_attr_put_u64(nlh, DEVLINK_ATTR_RESOURCE_SIZE, req->resource_size);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== DEVLINK_CMD_RESOURCE_DUMP ============== */
> -/* DEVLINK_CMD_RESOURCE_DUMP - do */
> -void devlink_resource_dump_req_free(struct devlink_resource_dump_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req);
> -}
> -
> -void devlink_resource_dump_rsp_free(struct devlink_resource_dump_rsp *rsp)
> -{
> -	free(rsp->bus_name);
> -	free(rsp->dev_name);
> -	devlink_dl_resource_list_free(&rsp->resource_list);
> -	free(rsp);
> -}
> -
> -int devlink_resource_dump_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct devlink_resource_dump_rsp *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -
> -	dst = yarg->data;
> -	parg.ys = yarg->ys;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_BUS_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.bus_name_len = len;
> -			dst->bus_name = malloc(len + 1);
> -			memcpy(dst->bus_name, mnl_attr_get_str(attr), len);
> -			dst->bus_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_DEV_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.dev_name_len = len;
> -			dst->dev_name = malloc(len + 1);
> -			memcpy(dst->dev_name, mnl_attr_get_str(attr), len);
> -			dst->dev_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_RESOURCE_LIST) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.resource_list = 1;
> -
> -			parg.rsp_policy = &devlink_dl_resource_list_nest;
> -			parg.data = &dst->resource_list;
> -			if (devlink_dl_resource_list_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct devlink_resource_dump_rsp *
> -devlink_resource_dump(struct ynl_sock *ys,
> -		      struct devlink_resource_dump_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct devlink_resource_dump_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_RESOURCE_DUMP, 1);
> -	ys->req_policy = &devlink_nest;
> -	yrs.yarg.rsp_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = devlink_resource_dump_rsp_parse;
> -	yrs.rsp_cmd = DEVLINK_CMD_RESOURCE_DUMP;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	devlink_resource_dump_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* ============== DEVLINK_CMD_RELOAD ============== */
> -/* DEVLINK_CMD_RELOAD - do */
> -void devlink_reload_req_free(struct devlink_reload_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req);
> -}
> -
> -void devlink_reload_rsp_free(struct devlink_reload_rsp *rsp)
> -{
> -	free(rsp->bus_name);
> -	free(rsp->dev_name);
> -	free(rsp);
> -}
> -
> -int devlink_reload_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct ynl_parse_arg *yarg = data;
> -	struct devlink_reload_rsp *dst;
> -	const struct nlattr *attr;
> -
> -	dst = yarg->data;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_BUS_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.bus_name_len = len;
> -			dst->bus_name = malloc(len + 1);
> -			memcpy(dst->bus_name, mnl_attr_get_str(attr), len);
> -			dst->bus_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_DEV_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.dev_name_len = len;
> -			dst->dev_name = malloc(len + 1);
> -			memcpy(dst->dev_name, mnl_attr_get_str(attr), len);
> -			dst->dev_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_RELOAD_ACTIONS_PERFORMED) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.reload_actions_performed = 1;
> -			memcpy(&dst->reload_actions_performed, mnl_attr_get_payload(attr), sizeof(struct nla_bitfield32));
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct devlink_reload_rsp *
> -devlink_reload(struct ynl_sock *ys, struct devlink_reload_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct devlink_reload_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_RELOAD, 1);
> -	ys->req_policy = &devlink_nest;
> -	yrs.yarg.rsp_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.reload_action)
> -		mnl_attr_put_u8(nlh, DEVLINK_ATTR_RELOAD_ACTION, req->reload_action);
> -	if (req->_present.reload_limits)
> -		mnl_attr_put(nlh, DEVLINK_ATTR_RELOAD_LIMITS, sizeof(struct nla_bitfield32), &req->reload_limits);
> -	if (req->_present.netns_pid)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_NETNS_PID, req->netns_pid);
> -	if (req->_present.netns_fd)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_NETNS_FD, req->netns_fd);
> -	if (req->_present.netns_id)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_NETNS_ID, req->netns_id);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = devlink_reload_rsp_parse;
> -	yrs.rsp_cmd = DEVLINK_CMD_RELOAD;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	devlink_reload_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* ============== DEVLINK_CMD_PARAM_GET ============== */
> -/* DEVLINK_CMD_PARAM_GET - do */
> -void devlink_param_get_req_free(struct devlink_param_get_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req->param_name);
> -	free(req);
> -}
> -
> -void devlink_param_get_rsp_free(struct devlink_param_get_rsp *rsp)
> -{
> -	free(rsp->bus_name);
> -	free(rsp->dev_name);
> -	free(rsp->param_name);
> -	free(rsp);
> -}
> -
> -int devlink_param_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct devlink_param_get_rsp *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -
> -	dst = yarg->data;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_BUS_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.bus_name_len = len;
> -			dst->bus_name = malloc(len + 1);
> -			memcpy(dst->bus_name, mnl_attr_get_str(attr), len);
> -			dst->bus_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_DEV_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.dev_name_len = len;
> -			dst->dev_name = malloc(len + 1);
> -			memcpy(dst->dev_name, mnl_attr_get_str(attr), len);
> -			dst->dev_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_PARAM_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.param_name_len = len;
> -			dst->param_name = malloc(len + 1);
> -			memcpy(dst->param_name, mnl_attr_get_str(attr), len);
> -			dst->param_name[len] = 0;
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct devlink_param_get_rsp *
> -devlink_param_get(struct ynl_sock *ys, struct devlink_param_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct devlink_param_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_PARAM_GET, 1);
> -	ys->req_policy = &devlink_nest;
> -	yrs.yarg.rsp_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.param_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_PARAM_NAME, req->param_name);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = devlink_param_get_rsp_parse;
> -	yrs.rsp_cmd = DEVLINK_CMD_PARAM_GET;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	devlink_param_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* DEVLINK_CMD_PARAM_GET - dump */
> -void devlink_param_get_list_free(struct devlink_param_get_list *rsp)
> -{
> -	struct devlink_param_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		free(rsp->obj.bus_name);
> -		free(rsp->obj.dev_name);
> -		free(rsp->obj.param_name);
> -		free(rsp);
> -	}
> -}
> -
> -struct devlink_param_get_list *
> -devlink_param_get_dump(struct ynl_sock *ys,
> -		       struct devlink_param_get_req_dump *req)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct devlink_param_get_list);
> -	yds.cb = devlink_param_get_rsp_parse;
> -	yds.rsp_cmd = DEVLINK_CMD_PARAM_GET;
> -	yds.rsp_policy = &devlink_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_PARAM_GET, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	devlink_param_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ============== DEVLINK_CMD_PARAM_SET ============== */
> -/* DEVLINK_CMD_PARAM_SET - do */
> -void devlink_param_set_req_free(struct devlink_param_set_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req->param_name);
> -	free(req);
> -}
> -
> -int devlink_param_set(struct ynl_sock *ys, struct devlink_param_set_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_PARAM_SET, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.param_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_PARAM_NAME, req->param_name);
> -	if (req->_present.param_type)
> -		mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_TYPE, req->param_type);
> -	if (req->_present.param_value_cmode)
> -		mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_VALUE_CMODE, req->param_value_cmode);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== DEVLINK_CMD_REGION_GET ============== */
> -/* DEVLINK_CMD_REGION_GET - do */
> -void devlink_region_get_req_free(struct devlink_region_get_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req->region_name);
> -	free(req);
> -}
> -
> -void devlink_region_get_rsp_free(struct devlink_region_get_rsp *rsp)
> -{
> -	free(rsp->bus_name);
> -	free(rsp->dev_name);
> -	free(rsp->region_name);
> -	free(rsp);
> -}
> -
> -int devlink_region_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct devlink_region_get_rsp *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -
> -	dst = yarg->data;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_BUS_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.bus_name_len = len;
> -			dst->bus_name = malloc(len + 1);
> -			memcpy(dst->bus_name, mnl_attr_get_str(attr), len);
> -			dst->bus_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_DEV_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.dev_name_len = len;
> -			dst->dev_name = malloc(len + 1);
> -			memcpy(dst->dev_name, mnl_attr_get_str(attr), len);
> -			dst->dev_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_PORT_INDEX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.port_index = 1;
> -			dst->port_index = mnl_attr_get_u32(attr);
> -		} else if (type == DEVLINK_ATTR_REGION_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.region_name_len = len;
> -			dst->region_name = malloc(len + 1);
> -			memcpy(dst->region_name, mnl_attr_get_str(attr), len);
> -			dst->region_name[len] = 0;
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct devlink_region_get_rsp *
> -devlink_region_get(struct ynl_sock *ys, struct devlink_region_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct devlink_region_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_REGION_GET, 1);
> -	ys->req_policy = &devlink_nest;
> -	yrs.yarg.rsp_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.port_index)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PORT_INDEX, req->port_index);
> -	if (req->_present.region_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_REGION_NAME, req->region_name);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = devlink_region_get_rsp_parse;
> -	yrs.rsp_cmd = DEVLINK_CMD_REGION_GET;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	devlink_region_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* DEVLINK_CMD_REGION_GET - dump */
> -void devlink_region_get_list_free(struct devlink_region_get_list *rsp)
> -{
> -	struct devlink_region_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		free(rsp->obj.bus_name);
> -		free(rsp->obj.dev_name);
> -		free(rsp->obj.region_name);
> -		free(rsp);
> -	}
> -}
> -
> -struct devlink_region_get_list *
> -devlink_region_get_dump(struct ynl_sock *ys,
> -			struct devlink_region_get_req_dump *req)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct devlink_region_get_list);
> -	yds.cb = devlink_region_get_rsp_parse;
> -	yds.rsp_cmd = DEVLINK_CMD_REGION_GET;
> -	yds.rsp_policy = &devlink_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_REGION_GET, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	devlink_region_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ============== DEVLINK_CMD_REGION_NEW ============== */
> -/* DEVLINK_CMD_REGION_NEW - do */
> -void devlink_region_new_req_free(struct devlink_region_new_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req->region_name);
> -	free(req);
> -}
> -
> -void devlink_region_new_rsp_free(struct devlink_region_new_rsp *rsp)
> -{
> -	free(rsp->bus_name);
> -	free(rsp->dev_name);
> -	free(rsp->region_name);
> -	free(rsp);
> -}
> -
> -int devlink_region_new_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct devlink_region_new_rsp *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -
> -	dst = yarg->data;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_BUS_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.bus_name_len = len;
> -			dst->bus_name = malloc(len + 1);
> -			memcpy(dst->bus_name, mnl_attr_get_str(attr), len);
> -			dst->bus_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_DEV_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.dev_name_len = len;
> -			dst->dev_name = malloc(len + 1);
> -			memcpy(dst->dev_name, mnl_attr_get_str(attr), len);
> -			dst->dev_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_PORT_INDEX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.port_index = 1;
> -			dst->port_index = mnl_attr_get_u32(attr);
> -		} else if (type == DEVLINK_ATTR_REGION_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.region_name_len = len;
> -			dst->region_name = malloc(len + 1);
> -			memcpy(dst->region_name, mnl_attr_get_str(attr), len);
> -			dst->region_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_REGION_SNAPSHOT_ID) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.region_snapshot_id = 1;
> -			dst->region_snapshot_id = mnl_attr_get_u32(attr);
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct devlink_region_new_rsp *
> -devlink_region_new(struct ynl_sock *ys, struct devlink_region_new_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct devlink_region_new_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_REGION_NEW, 1);
> -	ys->req_policy = &devlink_nest;
> -	yrs.yarg.rsp_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.port_index)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PORT_INDEX, req->port_index);
> -	if (req->_present.region_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_REGION_NAME, req->region_name);
> -	if (req->_present.region_snapshot_id)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_REGION_SNAPSHOT_ID, req->region_snapshot_id);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = devlink_region_new_rsp_parse;
> -	yrs.rsp_cmd = DEVLINK_CMD_REGION_NEW;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	devlink_region_new_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* ============== DEVLINK_CMD_REGION_DEL ============== */
> -/* DEVLINK_CMD_REGION_DEL - do */
> -void devlink_region_del_req_free(struct devlink_region_del_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req->region_name);
> -	free(req);
> -}
> -
> -int devlink_region_del(struct ynl_sock *ys, struct devlink_region_del_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_REGION_DEL, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.port_index)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PORT_INDEX, req->port_index);
> -	if (req->_present.region_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_REGION_NAME, req->region_name);
> -	if (req->_present.region_snapshot_id)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_REGION_SNAPSHOT_ID, req->region_snapshot_id);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== DEVLINK_CMD_REGION_READ ============== */
> -/* DEVLINK_CMD_REGION_READ - dump */
> -int devlink_region_read_rsp_dump_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct devlink_region_read_rsp_dump *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -
> -	dst = yarg->data;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_BUS_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.bus_name_len = len;
> -			dst->bus_name = malloc(len + 1);
> -			memcpy(dst->bus_name, mnl_attr_get_str(attr), len);
> -			dst->bus_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_DEV_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.dev_name_len = len;
> -			dst->dev_name = malloc(len + 1);
> -			memcpy(dst->dev_name, mnl_attr_get_str(attr), len);
> -			dst->dev_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_PORT_INDEX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.port_index = 1;
> -			dst->port_index = mnl_attr_get_u32(attr);
> -		} else if (type == DEVLINK_ATTR_REGION_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.region_name_len = len;
> -			dst->region_name = malloc(len + 1);
> -			memcpy(dst->region_name, mnl_attr_get_str(attr), len);
> -			dst->region_name[len] = 0;
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -void
> -devlink_region_read_rsp_list_free(struct devlink_region_read_rsp_list *rsp)
> -{
> -	struct devlink_region_read_rsp_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		free(rsp->obj.bus_name);
> -		free(rsp->obj.dev_name);
> -		free(rsp->obj.region_name);
> -		free(rsp);
> -	}
> -}
> -
> -struct devlink_region_read_rsp_list *
> -devlink_region_read_dump(struct ynl_sock *ys,
> -			 struct devlink_region_read_req_dump *req)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct devlink_region_read_rsp_list);
> -	yds.cb = devlink_region_read_rsp_dump_parse;
> -	yds.rsp_cmd = DEVLINK_CMD_REGION_READ;
> -	yds.rsp_policy = &devlink_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_REGION_READ, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.port_index)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PORT_INDEX, req->port_index);
> -	if (req->_present.region_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_REGION_NAME, req->region_name);
> -	if (req->_present.region_snapshot_id)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_REGION_SNAPSHOT_ID, req->region_snapshot_id);
> -	if (req->_present.region_direct)
> -		mnl_attr_put(nlh, DEVLINK_ATTR_REGION_DIRECT, 0, NULL);
> -	if (req->_present.region_chunk_addr)
> -		mnl_attr_put_u64(nlh, DEVLINK_ATTR_REGION_CHUNK_ADDR, req->region_chunk_addr);
> -	if (req->_present.region_chunk_len)
> -		mnl_attr_put_u64(nlh, DEVLINK_ATTR_REGION_CHUNK_LEN, req->region_chunk_len);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	devlink_region_read_rsp_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ============== DEVLINK_CMD_PORT_PARAM_GET ============== */
> -/* DEVLINK_CMD_PORT_PARAM_GET - do */
> -void devlink_port_param_get_req_free(struct devlink_port_param_get_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req);
> -}
> -
> -void devlink_port_param_get_rsp_free(struct devlink_port_param_get_rsp *rsp)
> -{
> -	free(rsp->bus_name);
> -	free(rsp->dev_name);
> -	free(rsp);
> -}
> -
> -int devlink_port_param_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct devlink_port_param_get_rsp *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -
> -	dst = yarg->data;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_BUS_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.bus_name_len = len;
> -			dst->bus_name = malloc(len + 1);
> -			memcpy(dst->bus_name, mnl_attr_get_str(attr), len);
> -			dst->bus_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_DEV_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.dev_name_len = len;
> -			dst->dev_name = malloc(len + 1);
> -			memcpy(dst->dev_name, mnl_attr_get_str(attr), len);
> -			dst->dev_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_PORT_INDEX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.port_index = 1;
> -			dst->port_index = mnl_attr_get_u32(attr);
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct devlink_port_param_get_rsp *
> -devlink_port_param_get(struct ynl_sock *ys,
> -		       struct devlink_port_param_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct devlink_port_param_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_PORT_PARAM_GET, 1);
> -	ys->req_policy = &devlink_nest;
> -	yrs.yarg.rsp_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.port_index)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PORT_INDEX, req->port_index);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = devlink_port_param_get_rsp_parse;
> -	yrs.rsp_cmd = DEVLINK_CMD_PORT_PARAM_GET;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	devlink_port_param_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* DEVLINK_CMD_PORT_PARAM_GET - dump */
> -void devlink_port_param_get_list_free(struct devlink_port_param_get_list *rsp)
> -{
> -	struct devlink_port_param_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		free(rsp->obj.bus_name);
> -		free(rsp->obj.dev_name);
> -		free(rsp);
> -	}
> -}
> -
> -struct devlink_port_param_get_list *
> -devlink_port_param_get_dump(struct ynl_sock *ys)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct devlink_port_param_get_list);
> -	yds.cb = devlink_port_param_get_rsp_parse;
> -	yds.rsp_cmd = DEVLINK_CMD_PORT_PARAM_GET;
> -	yds.rsp_policy = &devlink_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_PORT_PARAM_GET, 1);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	devlink_port_param_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ============== DEVLINK_CMD_PORT_PARAM_SET ============== */
> -/* DEVLINK_CMD_PORT_PARAM_SET - do */
> -void devlink_port_param_set_req_free(struct devlink_port_param_set_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req);
> -}
> -
> -int devlink_port_param_set(struct ynl_sock *ys,
> -			   struct devlink_port_param_set_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_PORT_PARAM_SET, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.port_index)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PORT_INDEX, req->port_index);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== DEVLINK_CMD_INFO_GET ============== */
> -/* DEVLINK_CMD_INFO_GET - do */
> -void devlink_info_get_req_free(struct devlink_info_get_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req);
> -}
> -
> -void devlink_info_get_rsp_free(struct devlink_info_get_rsp *rsp)
> -{
> -	unsigned int i;
> -
> -	free(rsp->bus_name);
> -	free(rsp->dev_name);
> -	free(rsp->info_driver_name);
> -	free(rsp->info_serial_number);
> -	for (i = 0; i < rsp->n_info_version_fixed; i++)
> -		devlink_dl_info_version_free(&rsp->info_version_fixed[i]);
> -	free(rsp->info_version_fixed);
> -	for (i = 0; i < rsp->n_info_version_running; i++)
> -		devlink_dl_info_version_free(&rsp->info_version_running[i]);
> -	free(rsp->info_version_running);
> -	for (i = 0; i < rsp->n_info_version_stored; i++)
> -		devlink_dl_info_version_free(&rsp->info_version_stored[i]);
> -	free(rsp->info_version_stored);
> -	free(rsp);
> -}
> -
> -int devlink_info_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	unsigned int n_info_version_running = 0;
> -	unsigned int n_info_version_stored = 0;
> -	unsigned int n_info_version_fixed = 0;
> -	struct ynl_parse_arg *yarg = data;
> -	struct devlink_info_get_rsp *dst;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -	int i;
> -
> -	dst = yarg->data;
> -	parg.ys = yarg->ys;
> -
> -	if (dst->info_version_fixed)
> -		return ynl_error_parse(yarg, "attribute already present (devlink.info-version-fixed)");
> -	if (dst->info_version_running)
> -		return ynl_error_parse(yarg, "attribute already present (devlink.info-version-running)");
> -	if (dst->info_version_stored)
> -		return ynl_error_parse(yarg, "attribute already present (devlink.info-version-stored)");
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_BUS_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.bus_name_len = len;
> -			dst->bus_name = malloc(len + 1);
> -			memcpy(dst->bus_name, mnl_attr_get_str(attr), len);
> -			dst->bus_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_DEV_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.dev_name_len = len;
> -			dst->dev_name = malloc(len + 1);
> -			memcpy(dst->dev_name, mnl_attr_get_str(attr), len);
> -			dst->dev_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_INFO_DRIVER_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.info_driver_name_len = len;
> -			dst->info_driver_name = malloc(len + 1);
> -			memcpy(dst->info_driver_name, mnl_attr_get_str(attr), len);
> -			dst->info_driver_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_INFO_SERIAL_NUMBER) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.info_serial_number_len = len;
> -			dst->info_serial_number = malloc(len + 1);
> -			memcpy(dst->info_serial_number, mnl_attr_get_str(attr), len);
> -			dst->info_serial_number[len] = 0;
> -		} else if (type == DEVLINK_ATTR_INFO_VERSION_FIXED) {
> -			n_info_version_fixed++;
> -		} else if (type == DEVLINK_ATTR_INFO_VERSION_RUNNING) {
> -			n_info_version_running++;
> -		} else if (type == DEVLINK_ATTR_INFO_VERSION_STORED) {
> -			n_info_version_stored++;
> -		}
> -	}
> -
> -	if (n_info_version_fixed) {
> -		dst->info_version_fixed = calloc(n_info_version_fixed, sizeof(*dst->info_version_fixed));
> -		dst->n_info_version_fixed = n_info_version_fixed;
> -		i = 0;
> -		parg.rsp_policy = &devlink_dl_info_version_nest;
> -		mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -			if (mnl_attr_get_type(attr) == DEVLINK_ATTR_INFO_VERSION_FIXED) {
> -				parg.data = &dst->info_version_fixed[i];
> -				if (devlink_dl_info_version_parse(&parg, attr))
> -					return MNL_CB_ERROR;
> -				i++;
> -			}
> -		}
> -	}
> -	if (n_info_version_running) {
> -		dst->info_version_running = calloc(n_info_version_running, sizeof(*dst->info_version_running));
> -		dst->n_info_version_running = n_info_version_running;
> -		i = 0;
> -		parg.rsp_policy = &devlink_dl_info_version_nest;
> -		mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -			if (mnl_attr_get_type(attr) == DEVLINK_ATTR_INFO_VERSION_RUNNING) {
> -				parg.data = &dst->info_version_running[i];
> -				if (devlink_dl_info_version_parse(&parg, attr))
> -					return MNL_CB_ERROR;
> -				i++;
> -			}
> -		}
> -	}
> -	if (n_info_version_stored) {
> -		dst->info_version_stored = calloc(n_info_version_stored, sizeof(*dst->info_version_stored));
> -		dst->n_info_version_stored = n_info_version_stored;
> -		i = 0;
> -		parg.rsp_policy = &devlink_dl_info_version_nest;
> -		mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -			if (mnl_attr_get_type(attr) == DEVLINK_ATTR_INFO_VERSION_STORED) {
> -				parg.data = &dst->info_version_stored[i];
> -				if (devlink_dl_info_version_parse(&parg, attr))
> -					return MNL_CB_ERROR;
> -				i++;
> -			}
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct devlink_info_get_rsp *
> -devlink_info_get(struct ynl_sock *ys, struct devlink_info_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct devlink_info_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_INFO_GET, 1);
> -	ys->req_policy = &devlink_nest;
> -	yrs.yarg.rsp_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = devlink_info_get_rsp_parse;
> -	yrs.rsp_cmd = DEVLINK_CMD_INFO_GET;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	devlink_info_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* DEVLINK_CMD_INFO_GET - dump */
> -void devlink_info_get_list_free(struct devlink_info_get_list *rsp)
> -{
> -	struct devlink_info_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		unsigned int i;
> -
> -		rsp = next;
> -		next = rsp->next;
> -
> -		free(rsp->obj.bus_name);
> -		free(rsp->obj.dev_name);
> -		free(rsp->obj.info_driver_name);
> -		free(rsp->obj.info_serial_number);
> -		for (i = 0; i < rsp->obj.n_info_version_fixed; i++)
> -			devlink_dl_info_version_free(&rsp->obj.info_version_fixed[i]);
> -		free(rsp->obj.info_version_fixed);
> -		for (i = 0; i < rsp->obj.n_info_version_running; i++)
> -			devlink_dl_info_version_free(&rsp->obj.info_version_running[i]);
> -		free(rsp->obj.info_version_running);
> -		for (i = 0; i < rsp->obj.n_info_version_stored; i++)
> -			devlink_dl_info_version_free(&rsp->obj.info_version_stored[i]);
> -		free(rsp->obj.info_version_stored);
> -		free(rsp);
> -	}
> -}
> -
> -struct devlink_info_get_list *devlink_info_get_dump(struct ynl_sock *ys)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct devlink_info_get_list);
> -	yds.cb = devlink_info_get_rsp_parse;
> -	yds.rsp_cmd = DEVLINK_CMD_INFO_GET;
> -	yds.rsp_policy = &devlink_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_INFO_GET, 1);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	devlink_info_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ============== DEVLINK_CMD_HEALTH_REPORTER_GET ============== */
> -/* DEVLINK_CMD_HEALTH_REPORTER_GET - do */
> -void
> -devlink_health_reporter_get_req_free(struct devlink_health_reporter_get_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req->health_reporter_name);
> -	free(req);
> -}
> -
> -void
> -devlink_health_reporter_get_rsp_free(struct devlink_health_reporter_get_rsp *rsp)
> -{
> -	free(rsp->bus_name);
> -	free(rsp->dev_name);
> -	free(rsp->health_reporter_name);
> -	free(rsp);
> -}
> -
> -int devlink_health_reporter_get_rsp_parse(const struct nlmsghdr *nlh,
> -					  void *data)
> -{
> -	struct devlink_health_reporter_get_rsp *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -
> -	dst = yarg->data;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_BUS_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.bus_name_len = len;
> -			dst->bus_name = malloc(len + 1);
> -			memcpy(dst->bus_name, mnl_attr_get_str(attr), len);
> -			dst->bus_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_DEV_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.dev_name_len = len;
> -			dst->dev_name = malloc(len + 1);
> -			memcpy(dst->dev_name, mnl_attr_get_str(attr), len);
> -			dst->dev_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_PORT_INDEX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.port_index = 1;
> -			dst->port_index = mnl_attr_get_u32(attr);
> -		} else if (type == DEVLINK_ATTR_HEALTH_REPORTER_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.health_reporter_name_len = len;
> -			dst->health_reporter_name = malloc(len + 1);
> -			memcpy(dst->health_reporter_name, mnl_attr_get_str(attr), len);
> -			dst->health_reporter_name[len] = 0;
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct devlink_health_reporter_get_rsp *
> -devlink_health_reporter_get(struct ynl_sock *ys,
> -			    struct devlink_health_reporter_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct devlink_health_reporter_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_HEALTH_REPORTER_GET, 1);
> -	ys->req_policy = &devlink_nest;
> -	yrs.yarg.rsp_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.port_index)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PORT_INDEX, req->port_index);
> -	if (req->_present.health_reporter_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_HEALTH_REPORTER_NAME, req->health_reporter_name);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = devlink_health_reporter_get_rsp_parse;
> -	yrs.rsp_cmd = DEVLINK_CMD_HEALTH_REPORTER_GET;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	devlink_health_reporter_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* DEVLINK_CMD_HEALTH_REPORTER_GET - dump */
> -void
> -devlink_health_reporter_get_list_free(struct devlink_health_reporter_get_list *rsp)
> -{
> -	struct devlink_health_reporter_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		free(rsp->obj.bus_name);
> -		free(rsp->obj.dev_name);
> -		free(rsp->obj.health_reporter_name);
> -		free(rsp);
> -	}
> -}
> -
> -struct devlink_health_reporter_get_list *
> -devlink_health_reporter_get_dump(struct ynl_sock *ys,
> -				 struct devlink_health_reporter_get_req_dump *req)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct devlink_health_reporter_get_list);
> -	yds.cb = devlink_health_reporter_get_rsp_parse;
> -	yds.rsp_cmd = DEVLINK_CMD_HEALTH_REPORTER_GET;
> -	yds.rsp_policy = &devlink_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_HEALTH_REPORTER_GET, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.port_index)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PORT_INDEX, req->port_index);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	devlink_health_reporter_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ============== DEVLINK_CMD_HEALTH_REPORTER_SET ============== */
> -/* DEVLINK_CMD_HEALTH_REPORTER_SET - do */
> -void
> -devlink_health_reporter_set_req_free(struct devlink_health_reporter_set_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req->health_reporter_name);
> -	free(req);
> -}
> -
> -int devlink_health_reporter_set(struct ynl_sock *ys,
> -				struct devlink_health_reporter_set_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_HEALTH_REPORTER_SET, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.port_index)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PORT_INDEX, req->port_index);
> -	if (req->_present.health_reporter_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_HEALTH_REPORTER_NAME, req->health_reporter_name);
> -	if (req->_present.health_reporter_graceful_period)
> -		mnl_attr_put_u64(nlh, DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD, req->health_reporter_graceful_period);
> -	if (req->_present.health_reporter_auto_recover)
> -		mnl_attr_put_u8(nlh, DEVLINK_ATTR_HEALTH_REPORTER_AUTO_RECOVER, req->health_reporter_auto_recover);
> -	if (req->_present.health_reporter_auto_dump)
> -		mnl_attr_put_u8(nlh, DEVLINK_ATTR_HEALTH_REPORTER_AUTO_DUMP, req->health_reporter_auto_dump);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== DEVLINK_CMD_HEALTH_REPORTER_RECOVER ============== */
> -/* DEVLINK_CMD_HEALTH_REPORTER_RECOVER - do */
> -void
> -devlink_health_reporter_recover_req_free(struct devlink_health_reporter_recover_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req->health_reporter_name);
> -	free(req);
> -}
> -
> -int devlink_health_reporter_recover(struct ynl_sock *ys,
> -				    struct devlink_health_reporter_recover_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_HEALTH_REPORTER_RECOVER, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.port_index)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PORT_INDEX, req->port_index);
> -	if (req->_present.health_reporter_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_HEALTH_REPORTER_NAME, req->health_reporter_name);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== DEVLINK_CMD_HEALTH_REPORTER_DIAGNOSE ============== */
> -/* DEVLINK_CMD_HEALTH_REPORTER_DIAGNOSE - do */
> -void
> -devlink_health_reporter_diagnose_req_free(struct devlink_health_reporter_diagnose_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req->health_reporter_name);
> -	free(req);
> -}
> -
> -int devlink_health_reporter_diagnose(struct ynl_sock *ys,
> -				     struct devlink_health_reporter_diagnose_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_HEALTH_REPORTER_DIAGNOSE, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.port_index)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PORT_INDEX, req->port_index);
> -	if (req->_present.health_reporter_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_HEALTH_REPORTER_NAME, req->health_reporter_name);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== DEVLINK_CMD_HEALTH_REPORTER_DUMP_GET ============== */
> -/* DEVLINK_CMD_HEALTH_REPORTER_DUMP_GET - dump */
> -int devlink_health_reporter_dump_get_rsp_dump_parse(const struct nlmsghdr *nlh,
> -						    void *data)
> -{
> -	struct devlink_health_reporter_dump_get_rsp_dump *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -
> -	dst = yarg->data;
> -	parg.ys = yarg->ys;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_FMSG) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.fmsg = 1;
> -
> -			parg.rsp_policy = &devlink_dl_fmsg_nest;
> -			parg.data = &dst->fmsg;
> -			if (devlink_dl_fmsg_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -void
> -devlink_health_reporter_dump_get_rsp_list_free(struct devlink_health_reporter_dump_get_rsp_list *rsp)
> -{
> -	struct devlink_health_reporter_dump_get_rsp_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		devlink_dl_fmsg_free(&rsp->obj.fmsg);
> -		free(rsp);
> -	}
> -}
> -
> -struct devlink_health_reporter_dump_get_rsp_list *
> -devlink_health_reporter_dump_get_dump(struct ynl_sock *ys,
> -				      struct devlink_health_reporter_dump_get_req_dump *req)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct devlink_health_reporter_dump_get_rsp_list);
> -	yds.cb = devlink_health_reporter_dump_get_rsp_dump_parse;
> -	yds.rsp_cmd = DEVLINK_CMD_HEALTH_REPORTER_DUMP_GET;
> -	yds.rsp_policy = &devlink_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_HEALTH_REPORTER_DUMP_GET, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.port_index)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PORT_INDEX, req->port_index);
> -	if (req->_present.health_reporter_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_HEALTH_REPORTER_NAME, req->health_reporter_name);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	devlink_health_reporter_dump_get_rsp_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ============== DEVLINK_CMD_HEALTH_REPORTER_DUMP_CLEAR ============== */
> -/* DEVLINK_CMD_HEALTH_REPORTER_DUMP_CLEAR - do */
> -void
> -devlink_health_reporter_dump_clear_req_free(struct devlink_health_reporter_dump_clear_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req->health_reporter_name);
> -	free(req);
> -}
> -
> -int devlink_health_reporter_dump_clear(struct ynl_sock *ys,
> -				       struct devlink_health_reporter_dump_clear_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_HEALTH_REPORTER_DUMP_CLEAR, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.port_index)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PORT_INDEX, req->port_index);
> -	if (req->_present.health_reporter_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_HEALTH_REPORTER_NAME, req->health_reporter_name);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== DEVLINK_CMD_FLASH_UPDATE ============== */
> -/* DEVLINK_CMD_FLASH_UPDATE - do */
> -void devlink_flash_update_req_free(struct devlink_flash_update_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req->flash_update_file_name);
> -	free(req->flash_update_component);
> -	free(req);
> -}
> -
> -int devlink_flash_update(struct ynl_sock *ys,
> -			 struct devlink_flash_update_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_FLASH_UPDATE, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.flash_update_file_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_FLASH_UPDATE_FILE_NAME, req->flash_update_file_name);
> -	if (req->_present.flash_update_component_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_FLASH_UPDATE_COMPONENT, req->flash_update_component);
> -	if (req->_present.flash_update_overwrite_mask)
> -		mnl_attr_put(nlh, DEVLINK_ATTR_FLASH_UPDATE_OVERWRITE_MASK, sizeof(struct nla_bitfield32), &req->flash_update_overwrite_mask);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== DEVLINK_CMD_TRAP_GET ============== */
> -/* DEVLINK_CMD_TRAP_GET - do */
> -void devlink_trap_get_req_free(struct devlink_trap_get_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req->trap_name);
> -	free(req);
> -}
> -
> -void devlink_trap_get_rsp_free(struct devlink_trap_get_rsp *rsp)
> -{
> -	free(rsp->bus_name);
> -	free(rsp->dev_name);
> -	free(rsp->trap_name);
> -	free(rsp);
> -}
> -
> -int devlink_trap_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct ynl_parse_arg *yarg = data;
> -	struct devlink_trap_get_rsp *dst;
> -	const struct nlattr *attr;
> -
> -	dst = yarg->data;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_BUS_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.bus_name_len = len;
> -			dst->bus_name = malloc(len + 1);
> -			memcpy(dst->bus_name, mnl_attr_get_str(attr), len);
> -			dst->bus_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_DEV_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.dev_name_len = len;
> -			dst->dev_name = malloc(len + 1);
> -			memcpy(dst->dev_name, mnl_attr_get_str(attr), len);
> -			dst->dev_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_TRAP_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.trap_name_len = len;
> -			dst->trap_name = malloc(len + 1);
> -			memcpy(dst->trap_name, mnl_attr_get_str(attr), len);
> -			dst->trap_name[len] = 0;
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct devlink_trap_get_rsp *
> -devlink_trap_get(struct ynl_sock *ys, struct devlink_trap_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct devlink_trap_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_TRAP_GET, 1);
> -	ys->req_policy = &devlink_nest;
> -	yrs.yarg.rsp_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.trap_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_TRAP_NAME, req->trap_name);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = devlink_trap_get_rsp_parse;
> -	yrs.rsp_cmd = 63;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	devlink_trap_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* DEVLINK_CMD_TRAP_GET - dump */
> -void devlink_trap_get_list_free(struct devlink_trap_get_list *rsp)
> -{
> -	struct devlink_trap_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		free(rsp->obj.bus_name);
> -		free(rsp->obj.dev_name);
> -		free(rsp->obj.trap_name);
> -		free(rsp);
> -	}
> -}
> -
> -struct devlink_trap_get_list *
> -devlink_trap_get_dump(struct ynl_sock *ys,
> -		      struct devlink_trap_get_req_dump *req)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct devlink_trap_get_list);
> -	yds.cb = devlink_trap_get_rsp_parse;
> -	yds.rsp_cmd = 63;
> -	yds.rsp_policy = &devlink_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_TRAP_GET, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	devlink_trap_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ============== DEVLINK_CMD_TRAP_SET ============== */
> -/* DEVLINK_CMD_TRAP_SET - do */
> -void devlink_trap_set_req_free(struct devlink_trap_set_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req->trap_name);
> -	free(req);
> -}
> -
> -int devlink_trap_set(struct ynl_sock *ys, struct devlink_trap_set_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_TRAP_SET, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.trap_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_TRAP_NAME, req->trap_name);
> -	if (req->_present.trap_action)
> -		mnl_attr_put_u8(nlh, DEVLINK_ATTR_TRAP_ACTION, req->trap_action);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== DEVLINK_CMD_TRAP_GROUP_GET ============== */
> -/* DEVLINK_CMD_TRAP_GROUP_GET - do */
> -void devlink_trap_group_get_req_free(struct devlink_trap_group_get_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req->trap_group_name);
> -	free(req);
> -}
> -
> -void devlink_trap_group_get_rsp_free(struct devlink_trap_group_get_rsp *rsp)
> -{
> -	free(rsp->bus_name);
> -	free(rsp->dev_name);
> -	free(rsp->trap_group_name);
> -	free(rsp);
> -}
> -
> -int devlink_trap_group_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct devlink_trap_group_get_rsp *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -
> -	dst = yarg->data;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_BUS_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.bus_name_len = len;
> -			dst->bus_name = malloc(len + 1);
> -			memcpy(dst->bus_name, mnl_attr_get_str(attr), len);
> -			dst->bus_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_DEV_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.dev_name_len = len;
> -			dst->dev_name = malloc(len + 1);
> -			memcpy(dst->dev_name, mnl_attr_get_str(attr), len);
> -			dst->dev_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_TRAP_GROUP_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.trap_group_name_len = len;
> -			dst->trap_group_name = malloc(len + 1);
> -			memcpy(dst->trap_group_name, mnl_attr_get_str(attr), len);
> -			dst->trap_group_name[len] = 0;
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct devlink_trap_group_get_rsp *
> -devlink_trap_group_get(struct ynl_sock *ys,
> -		       struct devlink_trap_group_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct devlink_trap_group_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_TRAP_GROUP_GET, 1);
> -	ys->req_policy = &devlink_nest;
> -	yrs.yarg.rsp_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.trap_group_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_TRAP_GROUP_NAME, req->trap_group_name);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = devlink_trap_group_get_rsp_parse;
> -	yrs.rsp_cmd = 67;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	devlink_trap_group_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* DEVLINK_CMD_TRAP_GROUP_GET - dump */
> -void devlink_trap_group_get_list_free(struct devlink_trap_group_get_list *rsp)
> -{
> -	struct devlink_trap_group_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		free(rsp->obj.bus_name);
> -		free(rsp->obj.dev_name);
> -		free(rsp->obj.trap_group_name);
> -		free(rsp);
> -	}
> -}
> -
> -struct devlink_trap_group_get_list *
> -devlink_trap_group_get_dump(struct ynl_sock *ys,
> -			    struct devlink_trap_group_get_req_dump *req)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct devlink_trap_group_get_list);
> -	yds.cb = devlink_trap_group_get_rsp_parse;
> -	yds.rsp_cmd = 67;
> -	yds.rsp_policy = &devlink_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_TRAP_GROUP_GET, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	devlink_trap_group_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ============== DEVLINK_CMD_TRAP_GROUP_SET ============== */
> -/* DEVLINK_CMD_TRAP_GROUP_SET - do */
> -void devlink_trap_group_set_req_free(struct devlink_trap_group_set_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req->trap_group_name);
> -	free(req);
> -}
> -
> -int devlink_trap_group_set(struct ynl_sock *ys,
> -			   struct devlink_trap_group_set_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_TRAP_GROUP_SET, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.trap_group_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_TRAP_GROUP_NAME, req->trap_group_name);
> -	if (req->_present.trap_action)
> -		mnl_attr_put_u8(nlh, DEVLINK_ATTR_TRAP_ACTION, req->trap_action);
> -	if (req->_present.trap_policer_id)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_TRAP_POLICER_ID, req->trap_policer_id);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== DEVLINK_CMD_TRAP_POLICER_GET ============== */
> -/* DEVLINK_CMD_TRAP_POLICER_GET - do */
> -void
> -devlink_trap_policer_get_req_free(struct devlink_trap_policer_get_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req);
> -}
> -
> -void
> -devlink_trap_policer_get_rsp_free(struct devlink_trap_policer_get_rsp *rsp)
> -{
> -	free(rsp->bus_name);
> -	free(rsp->dev_name);
> -	free(rsp);
> -}
> -
> -int devlink_trap_policer_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct devlink_trap_policer_get_rsp *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -
> -	dst = yarg->data;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_BUS_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.bus_name_len = len;
> -			dst->bus_name = malloc(len + 1);
> -			memcpy(dst->bus_name, mnl_attr_get_str(attr), len);
> -			dst->bus_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_DEV_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.dev_name_len = len;
> -			dst->dev_name = malloc(len + 1);
> -			memcpy(dst->dev_name, mnl_attr_get_str(attr), len);
> -			dst->dev_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_TRAP_POLICER_ID) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.trap_policer_id = 1;
> -			dst->trap_policer_id = mnl_attr_get_u32(attr);
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct devlink_trap_policer_get_rsp *
> -devlink_trap_policer_get(struct ynl_sock *ys,
> -			 struct devlink_trap_policer_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct devlink_trap_policer_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_TRAP_POLICER_GET, 1);
> -	ys->req_policy = &devlink_nest;
> -	yrs.yarg.rsp_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.trap_policer_id)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_TRAP_POLICER_ID, req->trap_policer_id);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = devlink_trap_policer_get_rsp_parse;
> -	yrs.rsp_cmd = 71;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	devlink_trap_policer_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* DEVLINK_CMD_TRAP_POLICER_GET - dump */
> -void
> -devlink_trap_policer_get_list_free(struct devlink_trap_policer_get_list *rsp)
> -{
> -	struct devlink_trap_policer_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		free(rsp->obj.bus_name);
> -		free(rsp->obj.dev_name);
> -		free(rsp);
> -	}
> -}
> -
> -struct devlink_trap_policer_get_list *
> -devlink_trap_policer_get_dump(struct ynl_sock *ys,
> -			      struct devlink_trap_policer_get_req_dump *req)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct devlink_trap_policer_get_list);
> -	yds.cb = devlink_trap_policer_get_rsp_parse;
> -	yds.rsp_cmd = 71;
> -	yds.rsp_policy = &devlink_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_TRAP_POLICER_GET, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	devlink_trap_policer_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ============== DEVLINK_CMD_TRAP_POLICER_SET ============== */
> -/* DEVLINK_CMD_TRAP_POLICER_SET - do */
> -void
> -devlink_trap_policer_set_req_free(struct devlink_trap_policer_set_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req);
> -}
> -
> -int devlink_trap_policer_set(struct ynl_sock *ys,
> -			     struct devlink_trap_policer_set_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_TRAP_POLICER_SET, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.trap_policer_id)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_TRAP_POLICER_ID, req->trap_policer_id);
> -	if (req->_present.trap_policer_rate)
> -		mnl_attr_put_u64(nlh, DEVLINK_ATTR_TRAP_POLICER_RATE, req->trap_policer_rate);
> -	if (req->_present.trap_policer_burst)
> -		mnl_attr_put_u64(nlh, DEVLINK_ATTR_TRAP_POLICER_BURST, req->trap_policer_burst);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== DEVLINK_CMD_HEALTH_REPORTER_TEST ============== */
> -/* DEVLINK_CMD_HEALTH_REPORTER_TEST - do */
> -void
> -devlink_health_reporter_test_req_free(struct devlink_health_reporter_test_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req->health_reporter_name);
> -	free(req);
> -}
> -
> -int devlink_health_reporter_test(struct ynl_sock *ys,
> -				 struct devlink_health_reporter_test_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_HEALTH_REPORTER_TEST, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.port_index)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PORT_INDEX, req->port_index);
> -	if (req->_present.health_reporter_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_HEALTH_REPORTER_NAME, req->health_reporter_name);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== DEVLINK_CMD_RATE_GET ============== */
> -/* DEVLINK_CMD_RATE_GET - do */
> -void devlink_rate_get_req_free(struct devlink_rate_get_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req->rate_node_name);
> -	free(req);
> -}
> -
> -void devlink_rate_get_rsp_free(struct devlink_rate_get_rsp *rsp)
> -{
> -	free(rsp->bus_name);
> -	free(rsp->dev_name);
> -	free(rsp->rate_node_name);
> -	free(rsp);
> -}
> -
> -int devlink_rate_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct ynl_parse_arg *yarg = data;
> -	struct devlink_rate_get_rsp *dst;
> -	const struct nlattr *attr;
> -
> -	dst = yarg->data;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_BUS_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.bus_name_len = len;
> -			dst->bus_name = malloc(len + 1);
> -			memcpy(dst->bus_name, mnl_attr_get_str(attr), len);
> -			dst->bus_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_DEV_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.dev_name_len = len;
> -			dst->dev_name = malloc(len + 1);
> -			memcpy(dst->dev_name, mnl_attr_get_str(attr), len);
> -			dst->dev_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_PORT_INDEX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.port_index = 1;
> -			dst->port_index = mnl_attr_get_u32(attr);
> -		} else if (type == DEVLINK_ATTR_RATE_NODE_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.rate_node_name_len = len;
> -			dst->rate_node_name = malloc(len + 1);
> -			memcpy(dst->rate_node_name, mnl_attr_get_str(attr), len);
> -			dst->rate_node_name[len] = 0;
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct devlink_rate_get_rsp *
> -devlink_rate_get(struct ynl_sock *ys, struct devlink_rate_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct devlink_rate_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_RATE_GET, 1);
> -	ys->req_policy = &devlink_nest;
> -	yrs.yarg.rsp_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.port_index)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PORT_INDEX, req->port_index);
> -	if (req->_present.rate_node_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_RATE_NODE_NAME, req->rate_node_name);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = devlink_rate_get_rsp_parse;
> -	yrs.rsp_cmd = 76;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	devlink_rate_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* DEVLINK_CMD_RATE_GET - dump */
> -void devlink_rate_get_list_free(struct devlink_rate_get_list *rsp)
> -{
> -	struct devlink_rate_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		free(rsp->obj.bus_name);
> -		free(rsp->obj.dev_name);
> -		free(rsp->obj.rate_node_name);
> -		free(rsp);
> -	}
> -}
> -
> -struct devlink_rate_get_list *
> -devlink_rate_get_dump(struct ynl_sock *ys,
> -		      struct devlink_rate_get_req_dump *req)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct devlink_rate_get_list);
> -	yds.cb = devlink_rate_get_rsp_parse;
> -	yds.rsp_cmd = 76;
> -	yds.rsp_policy = &devlink_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_RATE_GET, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	devlink_rate_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ============== DEVLINK_CMD_RATE_SET ============== */
> -/* DEVLINK_CMD_RATE_SET - do */
> -void devlink_rate_set_req_free(struct devlink_rate_set_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req->rate_node_name);
> -	free(req->rate_parent_node_name);
> -	free(req);
> -}
> -
> -int devlink_rate_set(struct ynl_sock *ys, struct devlink_rate_set_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_RATE_SET, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.rate_node_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_RATE_NODE_NAME, req->rate_node_name);
> -	if (req->_present.rate_tx_share)
> -		mnl_attr_put_u64(nlh, DEVLINK_ATTR_RATE_TX_SHARE, req->rate_tx_share);
> -	if (req->_present.rate_tx_max)
> -		mnl_attr_put_u64(nlh, DEVLINK_ATTR_RATE_TX_MAX, req->rate_tx_max);
> -	if (req->_present.rate_tx_priority)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_RATE_TX_PRIORITY, req->rate_tx_priority);
> -	if (req->_present.rate_tx_weight)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_RATE_TX_WEIGHT, req->rate_tx_weight);
> -	if (req->_present.rate_parent_node_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_RATE_PARENT_NODE_NAME, req->rate_parent_node_name);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== DEVLINK_CMD_RATE_NEW ============== */
> -/* DEVLINK_CMD_RATE_NEW - do */
> -void devlink_rate_new_req_free(struct devlink_rate_new_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req->rate_node_name);
> -	free(req->rate_parent_node_name);
> -	free(req);
> -}
> -
> -int devlink_rate_new(struct ynl_sock *ys, struct devlink_rate_new_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_RATE_NEW, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.rate_node_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_RATE_NODE_NAME, req->rate_node_name);
> -	if (req->_present.rate_tx_share)
> -		mnl_attr_put_u64(nlh, DEVLINK_ATTR_RATE_TX_SHARE, req->rate_tx_share);
> -	if (req->_present.rate_tx_max)
> -		mnl_attr_put_u64(nlh, DEVLINK_ATTR_RATE_TX_MAX, req->rate_tx_max);
> -	if (req->_present.rate_tx_priority)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_RATE_TX_PRIORITY, req->rate_tx_priority);
> -	if (req->_present.rate_tx_weight)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_RATE_TX_WEIGHT, req->rate_tx_weight);
> -	if (req->_present.rate_parent_node_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_RATE_PARENT_NODE_NAME, req->rate_parent_node_name);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== DEVLINK_CMD_RATE_DEL ============== */
> -/* DEVLINK_CMD_RATE_DEL - do */
> -void devlink_rate_del_req_free(struct devlink_rate_del_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req->rate_node_name);
> -	free(req);
> -}
> -
> -int devlink_rate_del(struct ynl_sock *ys, struct devlink_rate_del_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_RATE_DEL, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.rate_node_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_RATE_NODE_NAME, req->rate_node_name);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== DEVLINK_CMD_LINECARD_GET ============== */
> -/* DEVLINK_CMD_LINECARD_GET - do */
> -void devlink_linecard_get_req_free(struct devlink_linecard_get_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req);
> -}
> -
> -void devlink_linecard_get_rsp_free(struct devlink_linecard_get_rsp *rsp)
> -{
> -	free(rsp->bus_name);
> -	free(rsp->dev_name);
> -	free(rsp);
> -}
> -
> -int devlink_linecard_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct devlink_linecard_get_rsp *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -
> -	dst = yarg->data;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_BUS_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.bus_name_len = len;
> -			dst->bus_name = malloc(len + 1);
> -			memcpy(dst->bus_name, mnl_attr_get_str(attr), len);
> -			dst->bus_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_DEV_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.dev_name_len = len;
> -			dst->dev_name = malloc(len + 1);
> -			memcpy(dst->dev_name, mnl_attr_get_str(attr), len);
> -			dst->dev_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_LINECARD_INDEX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.linecard_index = 1;
> -			dst->linecard_index = mnl_attr_get_u32(attr);
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct devlink_linecard_get_rsp *
> -devlink_linecard_get(struct ynl_sock *ys, struct devlink_linecard_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct devlink_linecard_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_LINECARD_GET, 1);
> -	ys->req_policy = &devlink_nest;
> -	yrs.yarg.rsp_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.linecard_index)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_LINECARD_INDEX, req->linecard_index);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = devlink_linecard_get_rsp_parse;
> -	yrs.rsp_cmd = 80;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	devlink_linecard_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* DEVLINK_CMD_LINECARD_GET - dump */
> -void devlink_linecard_get_list_free(struct devlink_linecard_get_list *rsp)
> -{
> -	struct devlink_linecard_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		free(rsp->obj.bus_name);
> -		free(rsp->obj.dev_name);
> -		free(rsp);
> -	}
> -}
> -
> -struct devlink_linecard_get_list *
> -devlink_linecard_get_dump(struct ynl_sock *ys,
> -			  struct devlink_linecard_get_req_dump *req)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct devlink_linecard_get_list);
> -	yds.cb = devlink_linecard_get_rsp_parse;
> -	yds.rsp_cmd = 80;
> -	yds.rsp_policy = &devlink_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_LINECARD_GET, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	devlink_linecard_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ============== DEVLINK_CMD_LINECARD_SET ============== */
> -/* DEVLINK_CMD_LINECARD_SET - do */
> -void devlink_linecard_set_req_free(struct devlink_linecard_set_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req->linecard_type);
> -	free(req);
> -}
> -
> -int devlink_linecard_set(struct ynl_sock *ys,
> -			 struct devlink_linecard_set_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_LINECARD_SET, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.linecard_index)
> -		mnl_attr_put_u32(nlh, DEVLINK_ATTR_LINECARD_INDEX, req->linecard_index);
> -	if (req->_present.linecard_type_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_LINECARD_TYPE, req->linecard_type);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== DEVLINK_CMD_SELFTESTS_GET ============== */
> -/* DEVLINK_CMD_SELFTESTS_GET - do */
> -void devlink_selftests_get_req_free(struct devlink_selftests_get_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	free(req);
> -}
> -
> -void devlink_selftests_get_rsp_free(struct devlink_selftests_get_rsp *rsp)
> -{
> -	free(rsp->bus_name);
> -	free(rsp->dev_name);
> -	free(rsp);
> -}
> -
> -int devlink_selftests_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct devlink_selftests_get_rsp *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -
> -	dst = yarg->data;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == DEVLINK_ATTR_BUS_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.bus_name_len = len;
> -			dst->bus_name = malloc(len + 1);
> -			memcpy(dst->bus_name, mnl_attr_get_str(attr), len);
> -			dst->bus_name[len] = 0;
> -		} else if (type == DEVLINK_ATTR_DEV_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.dev_name_len = len;
> -			dst->dev_name = malloc(len + 1);
> -			memcpy(dst->dev_name, mnl_attr_get_str(attr), len);
> -			dst->dev_name[len] = 0;
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct devlink_selftests_get_rsp *
> -devlink_selftests_get(struct ynl_sock *ys,
> -		      struct devlink_selftests_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct devlink_selftests_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_SELFTESTS_GET, 1);
> -	ys->req_policy = &devlink_nest;
> -	yrs.yarg.rsp_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = devlink_selftests_get_rsp_parse;
> -	yrs.rsp_cmd = DEVLINK_CMD_SELFTESTS_GET;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	devlink_selftests_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* DEVLINK_CMD_SELFTESTS_GET - dump */
> -void devlink_selftests_get_list_free(struct devlink_selftests_get_list *rsp)
> -{
> -	struct devlink_selftests_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		free(rsp->obj.bus_name);
> -		free(rsp->obj.dev_name);
> -		free(rsp);
> -	}
> -}
> -
> -struct devlink_selftests_get_list *
> -devlink_selftests_get_dump(struct ynl_sock *ys)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct devlink_selftests_get_list);
> -	yds.cb = devlink_selftests_get_rsp_parse;
> -	yds.rsp_cmd = DEVLINK_CMD_SELFTESTS_GET;
> -	yds.rsp_policy = &devlink_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, DEVLINK_CMD_SELFTESTS_GET, 1);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	devlink_selftests_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ============== DEVLINK_CMD_SELFTESTS_RUN ============== */
> -/* DEVLINK_CMD_SELFTESTS_RUN - do */
> -void devlink_selftests_run_req_free(struct devlink_selftests_run_req *req)
> -{
> -	free(req->bus_name);
> -	free(req->dev_name);
> -	devlink_dl_selftest_id_free(&req->selftests);
> -	free(req);
> -}
> -
> -int devlink_selftests_run(struct ynl_sock *ys,
> -			  struct devlink_selftests_run_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_SELFTESTS_RUN, 1);
> -	ys->req_policy = &devlink_nest;
> -
> -	if (req->_present.bus_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> -	if (req->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> -	if (req->_present.selftests)
> -		devlink_dl_selftest_id_put(nlh, DEVLINK_ATTR_SELFTESTS, &req->selftests);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -const struct ynl_family ynl_devlink_family =  {
> -	.name		= "devlink",
> -};
> diff --git a/tools/net/ynl/generated/devlink-user.h b/tools/net/ynl/generated/devlink-user.h
> deleted file mode 100644
> index 1db4edc36eaa..000000000000
> --- a/tools/net/ynl/generated/devlink-user.h
> +++ /dev/null
> @@ -1,5255 +0,0 @@
> -/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
> -/* Do not edit directly, auto-generated from: */
> -/*	Documentation/netlink/specs/devlink.yaml */
> -/* YNL-GEN user header */
> -
> -#ifndef _LINUX_DEVLINK_GEN_H
> -#define _LINUX_DEVLINK_GEN_H
> -
> -#include <stdlib.h>
> -#include <string.h>
> -#include <linux/types.h>
> -#include <linux/netlink.h>
> -#include <linux/devlink.h>
> -
> -struct ynl_sock;
> -
> -extern const struct ynl_family ynl_devlink_family;
> -
> -/* Enums */
> -const char *devlink_op_str(int op);
> -const char *devlink_sb_pool_type_str(enum devlink_sb_pool_type value);
> -const char *devlink_port_type_str(enum devlink_port_type value);
> -const char *devlink_port_flavour_str(enum devlink_port_flavour value);
> -const char *devlink_port_fn_state_str(enum devlink_port_fn_state value);
> -const char *devlink_port_fn_opstate_str(enum devlink_port_fn_opstate value);
> -const char *devlink_port_fn_attr_cap_str(enum devlink_port_fn_attr_cap value);
> -const char *
> -devlink_sb_threshold_type_str(enum devlink_sb_threshold_type value);
> -const char *devlink_eswitch_mode_str(enum devlink_eswitch_mode value);
> -const char *
> -devlink_eswitch_inline_mode_str(enum devlink_eswitch_inline_mode value);
> -const char *
> -devlink_eswitch_encap_mode_str(enum devlink_eswitch_encap_mode value);
> -const char *devlink_dpipe_match_type_str(enum devlink_dpipe_match_type value);
> -const char *
> -devlink_dpipe_action_type_str(enum devlink_dpipe_action_type value);
> -const char *
> -devlink_dpipe_field_mapping_type_str(enum devlink_dpipe_field_mapping_type value);
> -const char *devlink_resource_unit_str(enum devlink_resource_unit value);
> -const char *devlink_reload_action_str(enum devlink_reload_action value);
> -const char *devlink_param_cmode_str(enum devlink_param_cmode value);
> -const char *devlink_flash_overwrite_str(enum devlink_flash_overwrite value);
> -const char *devlink_trap_action_str(enum devlink_trap_action value);
> -
> -/* Common nested types */
> -struct devlink_dl_dpipe_match {
> -	struct {
> -		__u32 dpipe_match_type:1;
> -		__u32 dpipe_header_id:1;
> -		__u32 dpipe_header_global:1;
> -		__u32 dpipe_header_index:1;
> -		__u32 dpipe_field_id:1;
> -	} _present;
> -
> -	enum devlink_dpipe_match_type dpipe_match_type;
> -	__u32 dpipe_header_id;
> -	__u8 dpipe_header_global;
> -	__u32 dpipe_header_index;
> -	__u32 dpipe_field_id;
> -};
> -
> -struct devlink_dl_dpipe_match_value {
> -	struct {
> -		__u32 dpipe_value_len;
> -		__u32 dpipe_value_mask_len;
> -		__u32 dpipe_value_mapping:1;
> -	} _present;
> -
> -	unsigned int n_dpipe_match;
> -	struct devlink_dl_dpipe_match *dpipe_match;
> -	void *dpipe_value;
> -	void *dpipe_value_mask;
> -	__u32 dpipe_value_mapping;
> -};
> -
> -struct devlink_dl_dpipe_action {
> -	struct {
> -		__u32 dpipe_action_type:1;
> -		__u32 dpipe_header_id:1;
> -		__u32 dpipe_header_global:1;
> -		__u32 dpipe_header_index:1;
> -		__u32 dpipe_field_id:1;
> -	} _present;
> -
> -	enum devlink_dpipe_action_type dpipe_action_type;
> -	__u32 dpipe_header_id;
> -	__u8 dpipe_header_global;
> -	__u32 dpipe_header_index;
> -	__u32 dpipe_field_id;
> -};
> -
> -struct devlink_dl_dpipe_action_value {
> -	struct {
> -		__u32 dpipe_value_len;
> -		__u32 dpipe_value_mask_len;
> -		__u32 dpipe_value_mapping:1;
> -	} _present;
> -
> -	unsigned int n_dpipe_action;
> -	struct devlink_dl_dpipe_action *dpipe_action;
> -	void *dpipe_value;
> -	void *dpipe_value_mask;
> -	__u32 dpipe_value_mapping;
> -};
> -
> -struct devlink_dl_dpipe_field {
> -	struct {
> -		__u32 dpipe_field_name_len;
> -		__u32 dpipe_field_id:1;
> -		__u32 dpipe_field_bitwidth:1;
> -		__u32 dpipe_field_mapping_type:1;
> -	} _present;
> -
> -	char *dpipe_field_name;
> -	__u32 dpipe_field_id;
> -	__u32 dpipe_field_bitwidth;
> -	enum devlink_dpipe_field_mapping_type dpipe_field_mapping_type;
> -};
> -
> -struct devlink_dl_resource {
> -	struct {
> -		__u32 resource_name_len;
> -		__u32 resource_id:1;
> -		__u32 resource_size:1;
> -		__u32 resource_size_new:1;
> -		__u32 resource_size_valid:1;
> -		__u32 resource_size_min:1;
> -		__u32 resource_size_max:1;
> -		__u32 resource_size_gran:1;
> -		__u32 resource_unit:1;
> -		__u32 resource_occ:1;
> -	} _present;
> -
> -	char *resource_name;
> -	__u64 resource_id;
> -	__u64 resource_size;
> -	__u64 resource_size_new;
> -	__u8 resource_size_valid;
> -	__u64 resource_size_min;
> -	__u64 resource_size_max;
> -	__u64 resource_size_gran;
> -	enum devlink_resource_unit resource_unit;
> -	__u64 resource_occ;
> -};
> -
> -struct devlink_dl_info_version {
> -	struct {
> -		__u32 info_version_name_len;
> -		__u32 info_version_value_len;
> -	} _present;
> -
> -	char *info_version_name;
> -	char *info_version_value;
> -};
> -
> -struct devlink_dl_fmsg {
> -	struct {
> -		__u32 fmsg_obj_nest_start:1;
> -		__u32 fmsg_pair_nest_start:1;
> -		__u32 fmsg_arr_nest_start:1;
> -		__u32 fmsg_nest_end:1;
> -		__u32 fmsg_obj_name_len;
> -	} _present;
> -
> -	char *fmsg_obj_name;
> -};
> -
> -struct devlink_dl_port_function {
> -	struct {
> -		__u32 hw_addr_len;
> -		__u32 state:1;
> -		__u32 opstate:1;
> -		__u32 caps:1;
> -	} _present;
> -
> -	void *hw_addr;
> -	enum devlink_port_fn_state state;
> -	enum devlink_port_fn_opstate opstate;
> -	struct nla_bitfield32 caps;
> -};
> -
> -struct devlink_dl_reload_stats_entry {
> -	struct {
> -		__u32 reload_stats_limit:1;
> -		__u32 reload_stats_value:1;
> -	} _present;
> -
> -	__u8 reload_stats_limit;
> -	__u32 reload_stats_value;
> -};
> -
> -struct devlink_dl_reload_act_stats {
> -	unsigned int n_reload_stats_entry;
> -	struct devlink_dl_reload_stats_entry *reload_stats_entry;
> -};
> -
> -struct devlink_dl_selftest_id {
> -	struct {
> -		__u32 flash:1;
> -	} _present;
> -};
> -
> -struct devlink_dl_dpipe_table_matches {
> -	unsigned int n_dpipe_match;
> -	struct devlink_dl_dpipe_match *dpipe_match;
> -};
> -
> -struct devlink_dl_dpipe_table_actions {
> -	unsigned int n_dpipe_action;
> -	struct devlink_dl_dpipe_action *dpipe_action;
> -};
> -
> -struct devlink_dl_dpipe_entry_match_values {
> -	unsigned int n_dpipe_match_value;
> -	struct devlink_dl_dpipe_match_value *dpipe_match_value;
> -};
> -
> -struct devlink_dl_dpipe_entry_action_values {
> -	unsigned int n_dpipe_action_value;
> -	struct devlink_dl_dpipe_action_value *dpipe_action_value;
> -};
> -
> -struct devlink_dl_dpipe_header_fields {
> -	unsigned int n_dpipe_field;
> -	struct devlink_dl_dpipe_field *dpipe_field;
> -};
> -
> -struct devlink_dl_resource_list {
> -	unsigned int n_resource;
> -	struct devlink_dl_resource *resource;
> -};
> -
> -struct devlink_dl_reload_act_info {
> -	struct {
> -		__u32 reload_action:1;
> -	} _present;
> -
> -	enum devlink_reload_action reload_action;
> -	unsigned int n_reload_action_stats;
> -	struct devlink_dl_reload_act_stats *reload_action_stats;
> -};
> -
> -struct devlink_dl_dpipe_table {
> -	struct {
> -		__u32 dpipe_table_name_len;
> -		__u32 dpipe_table_size:1;
> -		__u32 dpipe_table_matches:1;
> -		__u32 dpipe_table_actions:1;
> -		__u32 dpipe_table_counters_enabled:1;
> -		__u32 dpipe_table_resource_id:1;
> -		__u32 dpipe_table_resource_units:1;
> -	} _present;
> -
> -	char *dpipe_table_name;
> -	__u64 dpipe_table_size;
> -	struct devlink_dl_dpipe_table_matches dpipe_table_matches;
> -	struct devlink_dl_dpipe_table_actions dpipe_table_actions;
> -	__u8 dpipe_table_counters_enabled;
> -	__u64 dpipe_table_resource_id;
> -	__u64 dpipe_table_resource_units;
> -};
> -
> -struct devlink_dl_dpipe_entry {
> -	struct {
> -		__u32 dpipe_entry_index:1;
> -		__u32 dpipe_entry_match_values:1;
> -		__u32 dpipe_entry_action_values:1;
> -		__u32 dpipe_entry_counter:1;
> -	} _present;
> -
> -	__u64 dpipe_entry_index;
> -	struct devlink_dl_dpipe_entry_match_values dpipe_entry_match_values;
> -	struct devlink_dl_dpipe_entry_action_values dpipe_entry_action_values;
> -	__u64 dpipe_entry_counter;
> -};
> -
> -struct devlink_dl_dpipe_header {
> -	struct {
> -		__u32 dpipe_header_name_len;
> -		__u32 dpipe_header_id:1;
> -		__u32 dpipe_header_global:1;
> -		__u32 dpipe_header_fields:1;
> -	} _present;
> -
> -	char *dpipe_header_name;
> -	__u32 dpipe_header_id;
> -	__u8 dpipe_header_global;
> -	struct devlink_dl_dpipe_header_fields dpipe_header_fields;
> -};
> -
> -struct devlink_dl_reload_stats {
> -	unsigned int n_reload_action_info;
> -	struct devlink_dl_reload_act_info *reload_action_info;
> -};
> -
> -struct devlink_dl_dpipe_tables {
> -	unsigned int n_dpipe_table;
> -	struct devlink_dl_dpipe_table *dpipe_table;
> -};
> -
> -struct devlink_dl_dpipe_entries {
> -	unsigned int n_dpipe_entry;
> -	struct devlink_dl_dpipe_entry *dpipe_entry;
> -};
> -
> -struct devlink_dl_dpipe_headers {
> -	unsigned int n_dpipe_header;
> -	struct devlink_dl_dpipe_header *dpipe_header;
> -};
> -
> -struct devlink_dl_dev_stats {
> -	struct {
> -		__u32 reload_stats:1;
> -		__u32 remote_reload_stats:1;
> -	} _present;
> -
> -	struct devlink_dl_reload_stats reload_stats;
> -	struct devlink_dl_reload_stats remote_reload_stats;
> -};
> -
> -/* ============== DEVLINK_CMD_GET ============== */
> -/* DEVLINK_CMD_GET - do */
> -struct devlink_get_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -};
> -
> -static inline struct devlink_get_req *devlink_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_get_req));
> -}
> -void devlink_get_req_free(struct devlink_get_req *req);
> -
> -static inline void
> -devlink_get_req_set_bus_name(struct devlink_get_req *req, const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_get_req_set_dev_name(struct devlink_get_req *req, const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -
> -struct devlink_get_rsp {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 reload_failed:1;
> -		__u32 dev_stats:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u8 reload_failed;
> -	struct devlink_dl_dev_stats dev_stats;
> -};
> -
> -void devlink_get_rsp_free(struct devlink_get_rsp *rsp);
> -
> -/*
> - * Get devlink instances.
> - */
> -struct devlink_get_rsp *
> -devlink_get(struct ynl_sock *ys, struct devlink_get_req *req);
> -
> -/* DEVLINK_CMD_GET - dump */
> -struct devlink_get_list {
> -	struct devlink_get_list *next;
> -	struct devlink_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void devlink_get_list_free(struct devlink_get_list *rsp);
> -
> -struct devlink_get_list *devlink_get_dump(struct ynl_sock *ys);
> -
> -/* ============== DEVLINK_CMD_PORT_GET ============== */
> -/* DEVLINK_CMD_PORT_GET - do */
> -struct devlink_port_get_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 port_index:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 port_index;
> -};
> -
> -static inline struct devlink_port_get_req *devlink_port_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_port_get_req));
> -}
> -void devlink_port_get_req_free(struct devlink_port_get_req *req);
> -
> -static inline void
> -devlink_port_get_req_set_bus_name(struct devlink_port_get_req *req,
> -				  const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_port_get_req_set_dev_name(struct devlink_port_get_req *req,
> -				  const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_port_get_req_set_port_index(struct devlink_port_get_req *req,
> -				    __u32 port_index)
> -{
> -	req->_present.port_index = 1;
> -	req->port_index = port_index;
> -}
> -
> -struct devlink_port_get_rsp {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 port_index:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 port_index;
> -};
> -
> -void devlink_port_get_rsp_free(struct devlink_port_get_rsp *rsp);
> -
> -/*
> - * Get devlink port instances.
> - */
> -struct devlink_port_get_rsp *
> -devlink_port_get(struct ynl_sock *ys, struct devlink_port_get_req *req);
> -
> -/* DEVLINK_CMD_PORT_GET - dump */
> -struct devlink_port_get_req_dump {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -};
> -
> -static inline struct devlink_port_get_req_dump *
> -devlink_port_get_req_dump_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_port_get_req_dump));
> -}
> -void devlink_port_get_req_dump_free(struct devlink_port_get_req_dump *req);
> -
> -static inline void
> -devlink_port_get_req_dump_set_bus_name(struct devlink_port_get_req_dump *req,
> -				       const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_port_get_req_dump_set_dev_name(struct devlink_port_get_req_dump *req,
> -				       const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -
> -struct devlink_port_get_rsp_dump {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 port_index:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 port_index;
> -};
> -
> -struct devlink_port_get_rsp_list {
> -	struct devlink_port_get_rsp_list *next;
> -	struct devlink_port_get_rsp_dump obj __attribute__((aligned(8)));
> -};
> -
> -void devlink_port_get_rsp_list_free(struct devlink_port_get_rsp_list *rsp);
> -
> -struct devlink_port_get_rsp_list *
> -devlink_port_get_dump(struct ynl_sock *ys,
> -		      struct devlink_port_get_req_dump *req);
> -
> -/* ============== DEVLINK_CMD_PORT_SET ============== */
> -/* DEVLINK_CMD_PORT_SET - do */
> -struct devlink_port_set_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 port_index:1;
> -		__u32 port_type:1;
> -		__u32 port_function:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 port_index;
> -	enum devlink_port_type port_type;
> -	struct devlink_dl_port_function port_function;
> -};
> -
> -static inline struct devlink_port_set_req *devlink_port_set_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_port_set_req));
> -}
> -void devlink_port_set_req_free(struct devlink_port_set_req *req);
> -
> -static inline void
> -devlink_port_set_req_set_bus_name(struct devlink_port_set_req *req,
> -				  const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_port_set_req_set_dev_name(struct devlink_port_set_req *req,
> -				  const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_port_set_req_set_port_index(struct devlink_port_set_req *req,
> -				    __u32 port_index)
> -{
> -	req->_present.port_index = 1;
> -	req->port_index = port_index;
> -}
> -static inline void
> -devlink_port_set_req_set_port_type(struct devlink_port_set_req *req,
> -				   enum devlink_port_type port_type)
> -{
> -	req->_present.port_type = 1;
> -	req->port_type = port_type;
> -}
> -static inline void
> -devlink_port_set_req_set_port_function_hw_addr(struct devlink_port_set_req *req,
> -					       const void *hw_addr, size_t len)
> -{
> -	free(req->port_function.hw_addr);
> -	req->port_function._present.hw_addr_len = len;
> -	req->port_function.hw_addr = malloc(req->port_function._present.hw_addr_len);
> -	memcpy(req->port_function.hw_addr, hw_addr, req->port_function._present.hw_addr_len);
> -}
> -static inline void
> -devlink_port_set_req_set_port_function_state(struct devlink_port_set_req *req,
> -					     enum devlink_port_fn_state state)
> -{
> -	req->_present.port_function = 1;
> -	req->port_function._present.state = 1;
> -	req->port_function.state = state;
> -}
> -static inline void
> -devlink_port_set_req_set_port_function_opstate(struct devlink_port_set_req *req,
> -					       enum devlink_port_fn_opstate opstate)
> -{
> -	req->_present.port_function = 1;
> -	req->port_function._present.opstate = 1;
> -	req->port_function.opstate = opstate;
> -}
> -static inline void
> -devlink_port_set_req_set_port_function_caps(struct devlink_port_set_req *req,
> -					    struct nla_bitfield32 *caps)
> -{
> -	req->_present.port_function = 1;
> -	req->port_function._present.caps = 1;
> -	memcpy(&req->port_function.caps, caps, sizeof(struct nla_bitfield32));
> -}
> -
> -/*
> - * Set devlink port instances.
> - */
> -int devlink_port_set(struct ynl_sock *ys, struct devlink_port_set_req *req);
> -
> -/* ============== DEVLINK_CMD_PORT_NEW ============== */
> -/* DEVLINK_CMD_PORT_NEW - do */
> -struct devlink_port_new_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 port_index:1;
> -		__u32 port_flavour:1;
> -		__u32 port_pci_pf_number:1;
> -		__u32 port_pci_sf_number:1;
> -		__u32 port_controller_number:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 port_index;
> -	enum devlink_port_flavour port_flavour;
> -	__u16 port_pci_pf_number;
> -	__u32 port_pci_sf_number;
> -	__u32 port_controller_number;
> -};
> -
> -static inline struct devlink_port_new_req *devlink_port_new_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_port_new_req));
> -}
> -void devlink_port_new_req_free(struct devlink_port_new_req *req);
> -
> -static inline void
> -devlink_port_new_req_set_bus_name(struct devlink_port_new_req *req,
> -				  const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_port_new_req_set_dev_name(struct devlink_port_new_req *req,
> -				  const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_port_new_req_set_port_index(struct devlink_port_new_req *req,
> -				    __u32 port_index)
> -{
> -	req->_present.port_index = 1;
> -	req->port_index = port_index;
> -}
> -static inline void
> -devlink_port_new_req_set_port_flavour(struct devlink_port_new_req *req,
> -				      enum devlink_port_flavour port_flavour)
> -{
> -	req->_present.port_flavour = 1;
> -	req->port_flavour = port_flavour;
> -}
> -static inline void
> -devlink_port_new_req_set_port_pci_pf_number(struct devlink_port_new_req *req,
> -					    __u16 port_pci_pf_number)
> -{
> -	req->_present.port_pci_pf_number = 1;
> -	req->port_pci_pf_number = port_pci_pf_number;
> -}
> -static inline void
> -devlink_port_new_req_set_port_pci_sf_number(struct devlink_port_new_req *req,
> -					    __u32 port_pci_sf_number)
> -{
> -	req->_present.port_pci_sf_number = 1;
> -	req->port_pci_sf_number = port_pci_sf_number;
> -}
> -static inline void
> -devlink_port_new_req_set_port_controller_number(struct devlink_port_new_req *req,
> -						__u32 port_controller_number)
> -{
> -	req->_present.port_controller_number = 1;
> -	req->port_controller_number = port_controller_number;
> -}
> -
> -struct devlink_port_new_rsp {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 port_index:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 port_index;
> -};
> -
> -void devlink_port_new_rsp_free(struct devlink_port_new_rsp *rsp);
> -
> -/*
> - * Create devlink port instances.
> - */
> -struct devlink_port_new_rsp *
> -devlink_port_new(struct ynl_sock *ys, struct devlink_port_new_req *req);
> -
> -/* ============== DEVLINK_CMD_PORT_DEL ============== */
> -/* DEVLINK_CMD_PORT_DEL - do */
> -struct devlink_port_del_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 port_index:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 port_index;
> -};
> -
> -static inline struct devlink_port_del_req *devlink_port_del_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_port_del_req));
> -}
> -void devlink_port_del_req_free(struct devlink_port_del_req *req);
> -
> -static inline void
> -devlink_port_del_req_set_bus_name(struct devlink_port_del_req *req,
> -				  const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_port_del_req_set_dev_name(struct devlink_port_del_req *req,
> -				  const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_port_del_req_set_port_index(struct devlink_port_del_req *req,
> -				    __u32 port_index)
> -{
> -	req->_present.port_index = 1;
> -	req->port_index = port_index;
> -}
> -
> -/*
> - * Delete devlink port instances.
> - */
> -int devlink_port_del(struct ynl_sock *ys, struct devlink_port_del_req *req);
> -
> -/* ============== DEVLINK_CMD_PORT_SPLIT ============== */
> -/* DEVLINK_CMD_PORT_SPLIT - do */
> -struct devlink_port_split_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 port_index:1;
> -		__u32 port_split_count:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 port_index;
> -	__u32 port_split_count;
> -};
> -
> -static inline struct devlink_port_split_req *devlink_port_split_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_port_split_req));
> -}
> -void devlink_port_split_req_free(struct devlink_port_split_req *req);
> -
> -static inline void
> -devlink_port_split_req_set_bus_name(struct devlink_port_split_req *req,
> -				    const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_port_split_req_set_dev_name(struct devlink_port_split_req *req,
> -				    const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_port_split_req_set_port_index(struct devlink_port_split_req *req,
> -				      __u32 port_index)
> -{
> -	req->_present.port_index = 1;
> -	req->port_index = port_index;
> -}
> -static inline void
> -devlink_port_split_req_set_port_split_count(struct devlink_port_split_req *req,
> -					    __u32 port_split_count)
> -{
> -	req->_present.port_split_count = 1;
> -	req->port_split_count = port_split_count;
> -}
> -
> -/*
> - * Split devlink port instances.
> - */
> -int devlink_port_split(struct ynl_sock *ys, struct devlink_port_split_req *req);
> -
> -/* ============== DEVLINK_CMD_PORT_UNSPLIT ============== */
> -/* DEVLINK_CMD_PORT_UNSPLIT - do */
> -struct devlink_port_unsplit_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 port_index:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 port_index;
> -};
> -
> -static inline struct devlink_port_unsplit_req *
> -devlink_port_unsplit_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_port_unsplit_req));
> -}
> -void devlink_port_unsplit_req_free(struct devlink_port_unsplit_req *req);
> -
> -static inline void
> -devlink_port_unsplit_req_set_bus_name(struct devlink_port_unsplit_req *req,
> -				      const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_port_unsplit_req_set_dev_name(struct devlink_port_unsplit_req *req,
> -				      const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_port_unsplit_req_set_port_index(struct devlink_port_unsplit_req *req,
> -					__u32 port_index)
> -{
> -	req->_present.port_index = 1;
> -	req->port_index = port_index;
> -}
> -
> -/*
> - * Unplit devlink port instances.
> - */
> -int devlink_port_unsplit(struct ynl_sock *ys,
> -			 struct devlink_port_unsplit_req *req);
> -
> -/* ============== DEVLINK_CMD_SB_GET ============== */
> -/* DEVLINK_CMD_SB_GET - do */
> -struct devlink_sb_get_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 sb_index:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 sb_index;
> -};
> -
> -static inline struct devlink_sb_get_req *devlink_sb_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_sb_get_req));
> -}
> -void devlink_sb_get_req_free(struct devlink_sb_get_req *req);
> -
> -static inline void
> -devlink_sb_get_req_set_bus_name(struct devlink_sb_get_req *req,
> -				const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_sb_get_req_set_dev_name(struct devlink_sb_get_req *req,
> -				const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_sb_get_req_set_sb_index(struct devlink_sb_get_req *req, __u32 sb_index)
> -{
> -	req->_present.sb_index = 1;
> -	req->sb_index = sb_index;
> -}
> -
> -struct devlink_sb_get_rsp {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 sb_index:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 sb_index;
> -};
> -
> -void devlink_sb_get_rsp_free(struct devlink_sb_get_rsp *rsp);
> -
> -/*
> - * Get shared buffer instances.
> - */
> -struct devlink_sb_get_rsp *
> -devlink_sb_get(struct ynl_sock *ys, struct devlink_sb_get_req *req);
> -
> -/* DEVLINK_CMD_SB_GET - dump */
> -struct devlink_sb_get_req_dump {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -};
> -
> -static inline struct devlink_sb_get_req_dump *
> -devlink_sb_get_req_dump_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_sb_get_req_dump));
> -}
> -void devlink_sb_get_req_dump_free(struct devlink_sb_get_req_dump *req);
> -
> -static inline void
> -devlink_sb_get_req_dump_set_bus_name(struct devlink_sb_get_req_dump *req,
> -				     const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_sb_get_req_dump_set_dev_name(struct devlink_sb_get_req_dump *req,
> -				     const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -
> -struct devlink_sb_get_list {
> -	struct devlink_sb_get_list *next;
> -	struct devlink_sb_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void devlink_sb_get_list_free(struct devlink_sb_get_list *rsp);
> -
> -struct devlink_sb_get_list *
> -devlink_sb_get_dump(struct ynl_sock *ys, struct devlink_sb_get_req_dump *req);
> -
> -/* ============== DEVLINK_CMD_SB_POOL_GET ============== */
> -/* DEVLINK_CMD_SB_POOL_GET - do */
> -struct devlink_sb_pool_get_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 sb_index:1;
> -		__u32 sb_pool_index:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 sb_index;
> -	__u16 sb_pool_index;
> -};
> -
> -static inline struct devlink_sb_pool_get_req *
> -devlink_sb_pool_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_sb_pool_get_req));
> -}
> -void devlink_sb_pool_get_req_free(struct devlink_sb_pool_get_req *req);
> -
> -static inline void
> -devlink_sb_pool_get_req_set_bus_name(struct devlink_sb_pool_get_req *req,
> -				     const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_sb_pool_get_req_set_dev_name(struct devlink_sb_pool_get_req *req,
> -				     const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_sb_pool_get_req_set_sb_index(struct devlink_sb_pool_get_req *req,
> -				     __u32 sb_index)
> -{
> -	req->_present.sb_index = 1;
> -	req->sb_index = sb_index;
> -}
> -static inline void
> -devlink_sb_pool_get_req_set_sb_pool_index(struct devlink_sb_pool_get_req *req,
> -					  __u16 sb_pool_index)
> -{
> -	req->_present.sb_pool_index = 1;
> -	req->sb_pool_index = sb_pool_index;
> -}
> -
> -struct devlink_sb_pool_get_rsp {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 sb_index:1;
> -		__u32 sb_pool_index:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 sb_index;
> -	__u16 sb_pool_index;
> -};
> -
> -void devlink_sb_pool_get_rsp_free(struct devlink_sb_pool_get_rsp *rsp);
> -
> -/*
> - * Get shared buffer pool instances.
> - */
> -struct devlink_sb_pool_get_rsp *
> -devlink_sb_pool_get(struct ynl_sock *ys, struct devlink_sb_pool_get_req *req);
> -
> -/* DEVLINK_CMD_SB_POOL_GET - dump */
> -struct devlink_sb_pool_get_req_dump {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -};
> -
> -static inline struct devlink_sb_pool_get_req_dump *
> -devlink_sb_pool_get_req_dump_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_sb_pool_get_req_dump));
> -}
> -void
> -devlink_sb_pool_get_req_dump_free(struct devlink_sb_pool_get_req_dump *req);
> -
> -static inline void
> -devlink_sb_pool_get_req_dump_set_bus_name(struct devlink_sb_pool_get_req_dump *req,
> -					  const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_sb_pool_get_req_dump_set_dev_name(struct devlink_sb_pool_get_req_dump *req,
> -					  const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -
> -struct devlink_sb_pool_get_list {
> -	struct devlink_sb_pool_get_list *next;
> -	struct devlink_sb_pool_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void devlink_sb_pool_get_list_free(struct devlink_sb_pool_get_list *rsp);
> -
> -struct devlink_sb_pool_get_list *
> -devlink_sb_pool_get_dump(struct ynl_sock *ys,
> -			 struct devlink_sb_pool_get_req_dump *req);
> -
> -/* ============== DEVLINK_CMD_SB_POOL_SET ============== */
> -/* DEVLINK_CMD_SB_POOL_SET - do */
> -struct devlink_sb_pool_set_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 sb_index:1;
> -		__u32 sb_pool_index:1;
> -		__u32 sb_pool_threshold_type:1;
> -		__u32 sb_pool_size:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 sb_index;
> -	__u16 sb_pool_index;
> -	enum devlink_sb_threshold_type sb_pool_threshold_type;
> -	__u32 sb_pool_size;
> -};
> -
> -static inline struct devlink_sb_pool_set_req *
> -devlink_sb_pool_set_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_sb_pool_set_req));
> -}
> -void devlink_sb_pool_set_req_free(struct devlink_sb_pool_set_req *req);
> -
> -static inline void
> -devlink_sb_pool_set_req_set_bus_name(struct devlink_sb_pool_set_req *req,
> -				     const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_sb_pool_set_req_set_dev_name(struct devlink_sb_pool_set_req *req,
> -				     const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_sb_pool_set_req_set_sb_index(struct devlink_sb_pool_set_req *req,
> -				     __u32 sb_index)
> -{
> -	req->_present.sb_index = 1;
> -	req->sb_index = sb_index;
> -}
> -static inline void
> -devlink_sb_pool_set_req_set_sb_pool_index(struct devlink_sb_pool_set_req *req,
> -					  __u16 sb_pool_index)
> -{
> -	req->_present.sb_pool_index = 1;
> -	req->sb_pool_index = sb_pool_index;
> -}
> -static inline void
> -devlink_sb_pool_set_req_set_sb_pool_threshold_type(struct devlink_sb_pool_set_req *req,
> -						   enum devlink_sb_threshold_type sb_pool_threshold_type)
> -{
> -	req->_present.sb_pool_threshold_type = 1;
> -	req->sb_pool_threshold_type = sb_pool_threshold_type;
> -}
> -static inline void
> -devlink_sb_pool_set_req_set_sb_pool_size(struct devlink_sb_pool_set_req *req,
> -					 __u32 sb_pool_size)
> -{
> -	req->_present.sb_pool_size = 1;
> -	req->sb_pool_size = sb_pool_size;
> -}
> -
> -/*
> - * Set shared buffer pool instances.
> - */
> -int devlink_sb_pool_set(struct ynl_sock *ys,
> -			struct devlink_sb_pool_set_req *req);
> -
> -/* ============== DEVLINK_CMD_SB_PORT_POOL_GET ============== */
> -/* DEVLINK_CMD_SB_PORT_POOL_GET - do */
> -struct devlink_sb_port_pool_get_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 port_index:1;
> -		__u32 sb_index:1;
> -		__u32 sb_pool_index:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 port_index;
> -	__u32 sb_index;
> -	__u16 sb_pool_index;
> -};
> -
> -static inline struct devlink_sb_port_pool_get_req *
> -devlink_sb_port_pool_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_sb_port_pool_get_req));
> -}
> -void
> -devlink_sb_port_pool_get_req_free(struct devlink_sb_port_pool_get_req *req);
> -
> -static inline void
> -devlink_sb_port_pool_get_req_set_bus_name(struct devlink_sb_port_pool_get_req *req,
> -					  const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_sb_port_pool_get_req_set_dev_name(struct devlink_sb_port_pool_get_req *req,
> -					  const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_sb_port_pool_get_req_set_port_index(struct devlink_sb_port_pool_get_req *req,
> -					    __u32 port_index)
> -{
> -	req->_present.port_index = 1;
> -	req->port_index = port_index;
> -}
> -static inline void
> -devlink_sb_port_pool_get_req_set_sb_index(struct devlink_sb_port_pool_get_req *req,
> -					  __u32 sb_index)
> -{
> -	req->_present.sb_index = 1;
> -	req->sb_index = sb_index;
> -}
> -static inline void
> -devlink_sb_port_pool_get_req_set_sb_pool_index(struct devlink_sb_port_pool_get_req *req,
> -					       __u16 sb_pool_index)
> -{
> -	req->_present.sb_pool_index = 1;
> -	req->sb_pool_index = sb_pool_index;
> -}
> -
> -struct devlink_sb_port_pool_get_rsp {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 port_index:1;
> -		__u32 sb_index:1;
> -		__u32 sb_pool_index:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 port_index;
> -	__u32 sb_index;
> -	__u16 sb_pool_index;
> -};
> -
> -void
> -devlink_sb_port_pool_get_rsp_free(struct devlink_sb_port_pool_get_rsp *rsp);
> -
> -/*
> - * Get shared buffer port-pool combinations and threshold.
> - */
> -struct devlink_sb_port_pool_get_rsp *
> -devlink_sb_port_pool_get(struct ynl_sock *ys,
> -			 struct devlink_sb_port_pool_get_req *req);
> -
> -/* DEVLINK_CMD_SB_PORT_POOL_GET - dump */
> -struct devlink_sb_port_pool_get_req_dump {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -};
> -
> -static inline struct devlink_sb_port_pool_get_req_dump *
> -devlink_sb_port_pool_get_req_dump_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_sb_port_pool_get_req_dump));
> -}
> -void
> -devlink_sb_port_pool_get_req_dump_free(struct devlink_sb_port_pool_get_req_dump *req);
> -
> -static inline void
> -devlink_sb_port_pool_get_req_dump_set_bus_name(struct devlink_sb_port_pool_get_req_dump *req,
> -					       const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_sb_port_pool_get_req_dump_set_dev_name(struct devlink_sb_port_pool_get_req_dump *req,
> -					       const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -
> -struct devlink_sb_port_pool_get_list {
> -	struct devlink_sb_port_pool_get_list *next;
> -	struct devlink_sb_port_pool_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void
> -devlink_sb_port_pool_get_list_free(struct devlink_sb_port_pool_get_list *rsp);
> -
> -struct devlink_sb_port_pool_get_list *
> -devlink_sb_port_pool_get_dump(struct ynl_sock *ys,
> -			      struct devlink_sb_port_pool_get_req_dump *req);
> -
> -/* ============== DEVLINK_CMD_SB_PORT_POOL_SET ============== */
> -/* DEVLINK_CMD_SB_PORT_POOL_SET - do */
> -struct devlink_sb_port_pool_set_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 port_index:1;
> -		__u32 sb_index:1;
> -		__u32 sb_pool_index:1;
> -		__u32 sb_threshold:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 port_index;
> -	__u32 sb_index;
> -	__u16 sb_pool_index;
> -	__u32 sb_threshold;
> -};
> -
> -static inline struct devlink_sb_port_pool_set_req *
> -devlink_sb_port_pool_set_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_sb_port_pool_set_req));
> -}
> -void
> -devlink_sb_port_pool_set_req_free(struct devlink_sb_port_pool_set_req *req);
> -
> -static inline void
> -devlink_sb_port_pool_set_req_set_bus_name(struct devlink_sb_port_pool_set_req *req,
> -					  const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_sb_port_pool_set_req_set_dev_name(struct devlink_sb_port_pool_set_req *req,
> -					  const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_sb_port_pool_set_req_set_port_index(struct devlink_sb_port_pool_set_req *req,
> -					    __u32 port_index)
> -{
> -	req->_present.port_index = 1;
> -	req->port_index = port_index;
> -}
> -static inline void
> -devlink_sb_port_pool_set_req_set_sb_index(struct devlink_sb_port_pool_set_req *req,
> -					  __u32 sb_index)
> -{
> -	req->_present.sb_index = 1;
> -	req->sb_index = sb_index;
> -}
> -static inline void
> -devlink_sb_port_pool_set_req_set_sb_pool_index(struct devlink_sb_port_pool_set_req *req,
> -					       __u16 sb_pool_index)
> -{
> -	req->_present.sb_pool_index = 1;
> -	req->sb_pool_index = sb_pool_index;
> -}
> -static inline void
> -devlink_sb_port_pool_set_req_set_sb_threshold(struct devlink_sb_port_pool_set_req *req,
> -					      __u32 sb_threshold)
> -{
> -	req->_present.sb_threshold = 1;
> -	req->sb_threshold = sb_threshold;
> -}
> -
> -/*
> - * Set shared buffer port-pool combinations and threshold.
> - */
> -int devlink_sb_port_pool_set(struct ynl_sock *ys,
> -			     struct devlink_sb_port_pool_set_req *req);
> -
> -/* ============== DEVLINK_CMD_SB_TC_POOL_BIND_GET ============== */
> -/* DEVLINK_CMD_SB_TC_POOL_BIND_GET - do */
> -struct devlink_sb_tc_pool_bind_get_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 port_index:1;
> -		__u32 sb_index:1;
> -		__u32 sb_pool_type:1;
> -		__u32 sb_tc_index:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 port_index;
> -	__u32 sb_index;
> -	enum devlink_sb_pool_type sb_pool_type;
> -	__u16 sb_tc_index;
> -};
> -
> -static inline struct devlink_sb_tc_pool_bind_get_req *
> -devlink_sb_tc_pool_bind_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_sb_tc_pool_bind_get_req));
> -}
> -void
> -devlink_sb_tc_pool_bind_get_req_free(struct devlink_sb_tc_pool_bind_get_req *req);
> -
> -static inline void
> -devlink_sb_tc_pool_bind_get_req_set_bus_name(struct devlink_sb_tc_pool_bind_get_req *req,
> -					     const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_sb_tc_pool_bind_get_req_set_dev_name(struct devlink_sb_tc_pool_bind_get_req *req,
> -					     const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_sb_tc_pool_bind_get_req_set_port_index(struct devlink_sb_tc_pool_bind_get_req *req,
> -					       __u32 port_index)
> -{
> -	req->_present.port_index = 1;
> -	req->port_index = port_index;
> -}
> -static inline void
> -devlink_sb_tc_pool_bind_get_req_set_sb_index(struct devlink_sb_tc_pool_bind_get_req *req,
> -					     __u32 sb_index)
> -{
> -	req->_present.sb_index = 1;
> -	req->sb_index = sb_index;
> -}
> -static inline void
> -devlink_sb_tc_pool_bind_get_req_set_sb_pool_type(struct devlink_sb_tc_pool_bind_get_req *req,
> -						 enum devlink_sb_pool_type sb_pool_type)
> -{
> -	req->_present.sb_pool_type = 1;
> -	req->sb_pool_type = sb_pool_type;
> -}
> -static inline void
> -devlink_sb_tc_pool_bind_get_req_set_sb_tc_index(struct devlink_sb_tc_pool_bind_get_req *req,
> -						__u16 sb_tc_index)
> -{
> -	req->_present.sb_tc_index = 1;
> -	req->sb_tc_index = sb_tc_index;
> -}
> -
> -struct devlink_sb_tc_pool_bind_get_rsp {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 port_index:1;
> -		__u32 sb_index:1;
> -		__u32 sb_pool_type:1;
> -		__u32 sb_tc_index:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 port_index;
> -	__u32 sb_index;
> -	enum devlink_sb_pool_type sb_pool_type;
> -	__u16 sb_tc_index;
> -};
> -
> -void
> -devlink_sb_tc_pool_bind_get_rsp_free(struct devlink_sb_tc_pool_bind_get_rsp *rsp);
> -
> -/*
> - * Get shared buffer port-TC to pool bindings and threshold.
> - */
> -struct devlink_sb_tc_pool_bind_get_rsp *
> -devlink_sb_tc_pool_bind_get(struct ynl_sock *ys,
> -			    struct devlink_sb_tc_pool_bind_get_req *req);
> -
> -/* DEVLINK_CMD_SB_TC_POOL_BIND_GET - dump */
> -struct devlink_sb_tc_pool_bind_get_req_dump {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -};
> -
> -static inline struct devlink_sb_tc_pool_bind_get_req_dump *
> -devlink_sb_tc_pool_bind_get_req_dump_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_sb_tc_pool_bind_get_req_dump));
> -}
> -void
> -devlink_sb_tc_pool_bind_get_req_dump_free(struct devlink_sb_tc_pool_bind_get_req_dump *req);
> -
> -static inline void
> -devlink_sb_tc_pool_bind_get_req_dump_set_bus_name(struct devlink_sb_tc_pool_bind_get_req_dump *req,
> -						  const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_sb_tc_pool_bind_get_req_dump_set_dev_name(struct devlink_sb_tc_pool_bind_get_req_dump *req,
> -						  const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -
> -struct devlink_sb_tc_pool_bind_get_list {
> -	struct devlink_sb_tc_pool_bind_get_list *next;
> -	struct devlink_sb_tc_pool_bind_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void
> -devlink_sb_tc_pool_bind_get_list_free(struct devlink_sb_tc_pool_bind_get_list *rsp);
> -
> -struct devlink_sb_tc_pool_bind_get_list *
> -devlink_sb_tc_pool_bind_get_dump(struct ynl_sock *ys,
> -				 struct devlink_sb_tc_pool_bind_get_req_dump *req);
> -
> -/* ============== DEVLINK_CMD_SB_TC_POOL_BIND_SET ============== */
> -/* DEVLINK_CMD_SB_TC_POOL_BIND_SET - do */
> -struct devlink_sb_tc_pool_bind_set_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 port_index:1;
> -		__u32 sb_index:1;
> -		__u32 sb_pool_index:1;
> -		__u32 sb_pool_type:1;
> -		__u32 sb_tc_index:1;
> -		__u32 sb_threshold:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 port_index;
> -	__u32 sb_index;
> -	__u16 sb_pool_index;
> -	enum devlink_sb_pool_type sb_pool_type;
> -	__u16 sb_tc_index;
> -	__u32 sb_threshold;
> -};
> -
> -static inline struct devlink_sb_tc_pool_bind_set_req *
> -devlink_sb_tc_pool_bind_set_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_sb_tc_pool_bind_set_req));
> -}
> -void
> -devlink_sb_tc_pool_bind_set_req_free(struct devlink_sb_tc_pool_bind_set_req *req);
> -
> -static inline void
> -devlink_sb_tc_pool_bind_set_req_set_bus_name(struct devlink_sb_tc_pool_bind_set_req *req,
> -					     const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_sb_tc_pool_bind_set_req_set_dev_name(struct devlink_sb_tc_pool_bind_set_req *req,
> -					     const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_sb_tc_pool_bind_set_req_set_port_index(struct devlink_sb_tc_pool_bind_set_req *req,
> -					       __u32 port_index)
> -{
> -	req->_present.port_index = 1;
> -	req->port_index = port_index;
> -}
> -static inline void
> -devlink_sb_tc_pool_bind_set_req_set_sb_index(struct devlink_sb_tc_pool_bind_set_req *req,
> -					     __u32 sb_index)
> -{
> -	req->_present.sb_index = 1;
> -	req->sb_index = sb_index;
> -}
> -static inline void
> -devlink_sb_tc_pool_bind_set_req_set_sb_pool_index(struct devlink_sb_tc_pool_bind_set_req *req,
> -						  __u16 sb_pool_index)
> -{
> -	req->_present.sb_pool_index = 1;
> -	req->sb_pool_index = sb_pool_index;
> -}
> -static inline void
> -devlink_sb_tc_pool_bind_set_req_set_sb_pool_type(struct devlink_sb_tc_pool_bind_set_req *req,
> -						 enum devlink_sb_pool_type sb_pool_type)
> -{
> -	req->_present.sb_pool_type = 1;
> -	req->sb_pool_type = sb_pool_type;
> -}
> -static inline void
> -devlink_sb_tc_pool_bind_set_req_set_sb_tc_index(struct devlink_sb_tc_pool_bind_set_req *req,
> -						__u16 sb_tc_index)
> -{
> -	req->_present.sb_tc_index = 1;
> -	req->sb_tc_index = sb_tc_index;
> -}
> -static inline void
> -devlink_sb_tc_pool_bind_set_req_set_sb_threshold(struct devlink_sb_tc_pool_bind_set_req *req,
> -						 __u32 sb_threshold)
> -{
> -	req->_present.sb_threshold = 1;
> -	req->sb_threshold = sb_threshold;
> -}
> -
> -/*
> - * Set shared buffer port-TC to pool bindings and threshold.
> - */
> -int devlink_sb_tc_pool_bind_set(struct ynl_sock *ys,
> -				struct devlink_sb_tc_pool_bind_set_req *req);
> -
> -/* ============== DEVLINK_CMD_SB_OCC_SNAPSHOT ============== */
> -/* DEVLINK_CMD_SB_OCC_SNAPSHOT - do */
> -struct devlink_sb_occ_snapshot_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 sb_index:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 sb_index;
> -};
> -
> -static inline struct devlink_sb_occ_snapshot_req *
> -devlink_sb_occ_snapshot_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_sb_occ_snapshot_req));
> -}
> -void devlink_sb_occ_snapshot_req_free(struct devlink_sb_occ_snapshot_req *req);
> -
> -static inline void
> -devlink_sb_occ_snapshot_req_set_bus_name(struct devlink_sb_occ_snapshot_req *req,
> -					 const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_sb_occ_snapshot_req_set_dev_name(struct devlink_sb_occ_snapshot_req *req,
> -					 const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_sb_occ_snapshot_req_set_sb_index(struct devlink_sb_occ_snapshot_req *req,
> -					 __u32 sb_index)
> -{
> -	req->_present.sb_index = 1;
> -	req->sb_index = sb_index;
> -}
> -
> -/*
> - * Take occupancy snapshot of shared buffer.
> - */
> -int devlink_sb_occ_snapshot(struct ynl_sock *ys,
> -			    struct devlink_sb_occ_snapshot_req *req);
> -
> -/* ============== DEVLINK_CMD_SB_OCC_MAX_CLEAR ============== */
> -/* DEVLINK_CMD_SB_OCC_MAX_CLEAR - do */
> -struct devlink_sb_occ_max_clear_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 sb_index:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 sb_index;
> -};
> -
> -static inline struct devlink_sb_occ_max_clear_req *
> -devlink_sb_occ_max_clear_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_sb_occ_max_clear_req));
> -}
> -void
> -devlink_sb_occ_max_clear_req_free(struct devlink_sb_occ_max_clear_req *req);
> -
> -static inline void
> -devlink_sb_occ_max_clear_req_set_bus_name(struct devlink_sb_occ_max_clear_req *req,
> -					  const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_sb_occ_max_clear_req_set_dev_name(struct devlink_sb_occ_max_clear_req *req,
> -					  const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_sb_occ_max_clear_req_set_sb_index(struct devlink_sb_occ_max_clear_req *req,
> -					  __u32 sb_index)
> -{
> -	req->_present.sb_index = 1;
> -	req->sb_index = sb_index;
> -}
> -
> -/*
> - * Clear occupancy watermarks of shared buffer.
> - */
> -int devlink_sb_occ_max_clear(struct ynl_sock *ys,
> -			     struct devlink_sb_occ_max_clear_req *req);
> -
> -/* ============== DEVLINK_CMD_ESWITCH_GET ============== */
> -/* DEVLINK_CMD_ESWITCH_GET - do */
> -struct devlink_eswitch_get_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -};
> -
> -static inline struct devlink_eswitch_get_req *
> -devlink_eswitch_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_eswitch_get_req));
> -}
> -void devlink_eswitch_get_req_free(struct devlink_eswitch_get_req *req);
> -
> -static inline void
> -devlink_eswitch_get_req_set_bus_name(struct devlink_eswitch_get_req *req,
> -				     const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_eswitch_get_req_set_dev_name(struct devlink_eswitch_get_req *req,
> -				     const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -
> -struct devlink_eswitch_get_rsp {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 eswitch_mode:1;
> -		__u32 eswitch_inline_mode:1;
> -		__u32 eswitch_encap_mode:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	enum devlink_eswitch_mode eswitch_mode;
> -	enum devlink_eswitch_inline_mode eswitch_inline_mode;
> -	enum devlink_eswitch_encap_mode eswitch_encap_mode;
> -};
> -
> -void devlink_eswitch_get_rsp_free(struct devlink_eswitch_get_rsp *rsp);
> -
> -/*
> - * Get eswitch attributes.
> - */
> -struct devlink_eswitch_get_rsp *
> -devlink_eswitch_get(struct ynl_sock *ys, struct devlink_eswitch_get_req *req);
> -
> -/* ============== DEVLINK_CMD_ESWITCH_SET ============== */
> -/* DEVLINK_CMD_ESWITCH_SET - do */
> -struct devlink_eswitch_set_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 eswitch_mode:1;
> -		__u32 eswitch_inline_mode:1;
> -		__u32 eswitch_encap_mode:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	enum devlink_eswitch_mode eswitch_mode;
> -	enum devlink_eswitch_inline_mode eswitch_inline_mode;
> -	enum devlink_eswitch_encap_mode eswitch_encap_mode;
> -};
> -
> -static inline struct devlink_eswitch_set_req *
> -devlink_eswitch_set_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_eswitch_set_req));
> -}
> -void devlink_eswitch_set_req_free(struct devlink_eswitch_set_req *req);
> -
> -static inline void
> -devlink_eswitch_set_req_set_bus_name(struct devlink_eswitch_set_req *req,
> -				     const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_eswitch_set_req_set_dev_name(struct devlink_eswitch_set_req *req,
> -				     const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_eswitch_set_req_set_eswitch_mode(struct devlink_eswitch_set_req *req,
> -					 enum devlink_eswitch_mode eswitch_mode)
> -{
> -	req->_present.eswitch_mode = 1;
> -	req->eswitch_mode = eswitch_mode;
> -}
> -static inline void
> -devlink_eswitch_set_req_set_eswitch_inline_mode(struct devlink_eswitch_set_req *req,
> -						enum devlink_eswitch_inline_mode eswitch_inline_mode)
> -{
> -	req->_present.eswitch_inline_mode = 1;
> -	req->eswitch_inline_mode = eswitch_inline_mode;
> -}
> -static inline void
> -devlink_eswitch_set_req_set_eswitch_encap_mode(struct devlink_eswitch_set_req *req,
> -					       enum devlink_eswitch_encap_mode eswitch_encap_mode)
> -{
> -	req->_present.eswitch_encap_mode = 1;
> -	req->eswitch_encap_mode = eswitch_encap_mode;
> -}
> -
> -/*
> - * Set eswitch attributes.
> - */
> -int devlink_eswitch_set(struct ynl_sock *ys,
> -			struct devlink_eswitch_set_req *req);
> -
> -/* ============== DEVLINK_CMD_DPIPE_TABLE_GET ============== */
> -/* DEVLINK_CMD_DPIPE_TABLE_GET - do */
> -struct devlink_dpipe_table_get_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 dpipe_table_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	char *dpipe_table_name;
> -};
> -
> -static inline struct devlink_dpipe_table_get_req *
> -devlink_dpipe_table_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_dpipe_table_get_req));
> -}
> -void devlink_dpipe_table_get_req_free(struct devlink_dpipe_table_get_req *req);
> -
> -static inline void
> -devlink_dpipe_table_get_req_set_bus_name(struct devlink_dpipe_table_get_req *req,
> -					 const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_dpipe_table_get_req_set_dev_name(struct devlink_dpipe_table_get_req *req,
> -					 const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_dpipe_table_get_req_set_dpipe_table_name(struct devlink_dpipe_table_get_req *req,
> -						 const char *dpipe_table_name)
> -{
> -	free(req->dpipe_table_name);
> -	req->_present.dpipe_table_name_len = strlen(dpipe_table_name);
> -	req->dpipe_table_name = malloc(req->_present.dpipe_table_name_len + 1);
> -	memcpy(req->dpipe_table_name, dpipe_table_name, req->_present.dpipe_table_name_len);
> -	req->dpipe_table_name[req->_present.dpipe_table_name_len] = 0;
> -}
> -
> -struct devlink_dpipe_table_get_rsp {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 dpipe_tables:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	struct devlink_dl_dpipe_tables dpipe_tables;
> -};
> -
> -void devlink_dpipe_table_get_rsp_free(struct devlink_dpipe_table_get_rsp *rsp);
> -
> -/*
> - * Get dpipe table attributes.
> - */
> -struct devlink_dpipe_table_get_rsp *
> -devlink_dpipe_table_get(struct ynl_sock *ys,
> -			struct devlink_dpipe_table_get_req *req);
> -
> -/* ============== DEVLINK_CMD_DPIPE_ENTRIES_GET ============== */
> -/* DEVLINK_CMD_DPIPE_ENTRIES_GET - do */
> -struct devlink_dpipe_entries_get_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 dpipe_table_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	char *dpipe_table_name;
> -};
> -
> -static inline struct devlink_dpipe_entries_get_req *
> -devlink_dpipe_entries_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_dpipe_entries_get_req));
> -}
> -void
> -devlink_dpipe_entries_get_req_free(struct devlink_dpipe_entries_get_req *req);
> -
> -static inline void
> -devlink_dpipe_entries_get_req_set_bus_name(struct devlink_dpipe_entries_get_req *req,
> -					   const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_dpipe_entries_get_req_set_dev_name(struct devlink_dpipe_entries_get_req *req,
> -					   const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_dpipe_entries_get_req_set_dpipe_table_name(struct devlink_dpipe_entries_get_req *req,
> -						   const char *dpipe_table_name)
> -{
> -	free(req->dpipe_table_name);
> -	req->_present.dpipe_table_name_len = strlen(dpipe_table_name);
> -	req->dpipe_table_name = malloc(req->_present.dpipe_table_name_len + 1);
> -	memcpy(req->dpipe_table_name, dpipe_table_name, req->_present.dpipe_table_name_len);
> -	req->dpipe_table_name[req->_present.dpipe_table_name_len] = 0;
> -}
> -
> -struct devlink_dpipe_entries_get_rsp {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 dpipe_entries:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	struct devlink_dl_dpipe_entries dpipe_entries;
> -};
> -
> -void
> -devlink_dpipe_entries_get_rsp_free(struct devlink_dpipe_entries_get_rsp *rsp);
> -
> -/*
> - * Get dpipe entries attributes.
> - */
> -struct devlink_dpipe_entries_get_rsp *
> -devlink_dpipe_entries_get(struct ynl_sock *ys,
> -			  struct devlink_dpipe_entries_get_req *req);
> -
> -/* ============== DEVLINK_CMD_DPIPE_HEADERS_GET ============== */
> -/* DEVLINK_CMD_DPIPE_HEADERS_GET - do */
> -struct devlink_dpipe_headers_get_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -};
> -
> -static inline struct devlink_dpipe_headers_get_req *
> -devlink_dpipe_headers_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_dpipe_headers_get_req));
> -}
> -void
> -devlink_dpipe_headers_get_req_free(struct devlink_dpipe_headers_get_req *req);
> -
> -static inline void
> -devlink_dpipe_headers_get_req_set_bus_name(struct devlink_dpipe_headers_get_req *req,
> -					   const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_dpipe_headers_get_req_set_dev_name(struct devlink_dpipe_headers_get_req *req,
> -					   const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -
> -struct devlink_dpipe_headers_get_rsp {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 dpipe_headers:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	struct devlink_dl_dpipe_headers dpipe_headers;
> -};
> -
> -void
> -devlink_dpipe_headers_get_rsp_free(struct devlink_dpipe_headers_get_rsp *rsp);
> -
> -/*
> - * Get dpipe headers attributes.
> - */
> -struct devlink_dpipe_headers_get_rsp *
> -devlink_dpipe_headers_get(struct ynl_sock *ys,
> -			  struct devlink_dpipe_headers_get_req *req);
> -
> -/* ============== DEVLINK_CMD_DPIPE_TABLE_COUNTERS_SET ============== */
> -/* DEVLINK_CMD_DPIPE_TABLE_COUNTERS_SET - do */
> -struct devlink_dpipe_table_counters_set_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 dpipe_table_name_len;
> -		__u32 dpipe_table_counters_enabled:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	char *dpipe_table_name;
> -	__u8 dpipe_table_counters_enabled;
> -};
> -
> -static inline struct devlink_dpipe_table_counters_set_req *
> -devlink_dpipe_table_counters_set_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_dpipe_table_counters_set_req));
> -}
> -void
> -devlink_dpipe_table_counters_set_req_free(struct devlink_dpipe_table_counters_set_req *req);
> -
> -static inline void
> -devlink_dpipe_table_counters_set_req_set_bus_name(struct devlink_dpipe_table_counters_set_req *req,
> -						  const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_dpipe_table_counters_set_req_set_dev_name(struct devlink_dpipe_table_counters_set_req *req,
> -						  const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_dpipe_table_counters_set_req_set_dpipe_table_name(struct devlink_dpipe_table_counters_set_req *req,
> -							  const char *dpipe_table_name)
> -{
> -	free(req->dpipe_table_name);
> -	req->_present.dpipe_table_name_len = strlen(dpipe_table_name);
> -	req->dpipe_table_name = malloc(req->_present.dpipe_table_name_len + 1);
> -	memcpy(req->dpipe_table_name, dpipe_table_name, req->_present.dpipe_table_name_len);
> -	req->dpipe_table_name[req->_present.dpipe_table_name_len] = 0;
> -}
> -static inline void
> -devlink_dpipe_table_counters_set_req_set_dpipe_table_counters_enabled(struct devlink_dpipe_table_counters_set_req *req,
> -								      __u8 dpipe_table_counters_enabled)
> -{
> -	req->_present.dpipe_table_counters_enabled = 1;
> -	req->dpipe_table_counters_enabled = dpipe_table_counters_enabled;
> -}
> -
> -/*
> - * Set dpipe counter attributes.
> - */
> -int devlink_dpipe_table_counters_set(struct ynl_sock *ys,
> -				     struct devlink_dpipe_table_counters_set_req *req);
> -
> -/* ============== DEVLINK_CMD_RESOURCE_SET ============== */
> -/* DEVLINK_CMD_RESOURCE_SET - do */
> -struct devlink_resource_set_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 resource_id:1;
> -		__u32 resource_size:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u64 resource_id;
> -	__u64 resource_size;
> -};
> -
> -static inline struct devlink_resource_set_req *
> -devlink_resource_set_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_resource_set_req));
> -}
> -void devlink_resource_set_req_free(struct devlink_resource_set_req *req);
> -
> -static inline void
> -devlink_resource_set_req_set_bus_name(struct devlink_resource_set_req *req,
> -				      const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_resource_set_req_set_dev_name(struct devlink_resource_set_req *req,
> -				      const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_resource_set_req_set_resource_id(struct devlink_resource_set_req *req,
> -					 __u64 resource_id)
> -{
> -	req->_present.resource_id = 1;
> -	req->resource_id = resource_id;
> -}
> -static inline void
> -devlink_resource_set_req_set_resource_size(struct devlink_resource_set_req *req,
> -					   __u64 resource_size)
> -{
> -	req->_present.resource_size = 1;
> -	req->resource_size = resource_size;
> -}
> -
> -/*
> - * Set resource attributes.
> - */
> -int devlink_resource_set(struct ynl_sock *ys,
> -			 struct devlink_resource_set_req *req);
> -
> -/* ============== DEVLINK_CMD_RESOURCE_DUMP ============== */
> -/* DEVLINK_CMD_RESOURCE_DUMP - do */
> -struct devlink_resource_dump_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -};
> -
> -static inline struct devlink_resource_dump_req *
> -devlink_resource_dump_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_resource_dump_req));
> -}
> -void devlink_resource_dump_req_free(struct devlink_resource_dump_req *req);
> -
> -static inline void
> -devlink_resource_dump_req_set_bus_name(struct devlink_resource_dump_req *req,
> -				       const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_resource_dump_req_set_dev_name(struct devlink_resource_dump_req *req,
> -				       const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -
> -struct devlink_resource_dump_rsp {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 resource_list:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	struct devlink_dl_resource_list resource_list;
> -};
> -
> -void devlink_resource_dump_rsp_free(struct devlink_resource_dump_rsp *rsp);
> -
> -/*
> - * Get resource attributes.
> - */
> -struct devlink_resource_dump_rsp *
> -devlink_resource_dump(struct ynl_sock *ys,
> -		      struct devlink_resource_dump_req *req);
> -
> -/* ============== DEVLINK_CMD_RELOAD ============== */
> -/* DEVLINK_CMD_RELOAD - do */
> -struct devlink_reload_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 reload_action:1;
> -		__u32 reload_limits:1;
> -		__u32 netns_pid:1;
> -		__u32 netns_fd:1;
> -		__u32 netns_id:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	enum devlink_reload_action reload_action;
> -	struct nla_bitfield32 reload_limits;
> -	__u32 netns_pid;
> -	__u32 netns_fd;
> -	__u32 netns_id;
> -};
> -
> -static inline struct devlink_reload_req *devlink_reload_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_reload_req));
> -}
> -void devlink_reload_req_free(struct devlink_reload_req *req);
> -
> -static inline void
> -devlink_reload_req_set_bus_name(struct devlink_reload_req *req,
> -				const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_reload_req_set_dev_name(struct devlink_reload_req *req,
> -				const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_reload_req_set_reload_action(struct devlink_reload_req *req,
> -				     enum devlink_reload_action reload_action)
> -{
> -	req->_present.reload_action = 1;
> -	req->reload_action = reload_action;
> -}
> -static inline void
> -devlink_reload_req_set_reload_limits(struct devlink_reload_req *req,
> -				     struct nla_bitfield32 *reload_limits)
> -{
> -	req->_present.reload_limits = 1;
> -	memcpy(&req->reload_limits, reload_limits, sizeof(struct nla_bitfield32));
> -}
> -static inline void
> -devlink_reload_req_set_netns_pid(struct devlink_reload_req *req,
> -				 __u32 netns_pid)
> -{
> -	req->_present.netns_pid = 1;
> -	req->netns_pid = netns_pid;
> -}
> -static inline void
> -devlink_reload_req_set_netns_fd(struct devlink_reload_req *req, __u32 netns_fd)
> -{
> -	req->_present.netns_fd = 1;
> -	req->netns_fd = netns_fd;
> -}
> -static inline void
> -devlink_reload_req_set_netns_id(struct devlink_reload_req *req, __u32 netns_id)
> -{
> -	req->_present.netns_id = 1;
> -	req->netns_id = netns_id;
> -}
> -
> -struct devlink_reload_rsp {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 reload_actions_performed:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	struct nla_bitfield32 reload_actions_performed;
> -};
> -
> -void devlink_reload_rsp_free(struct devlink_reload_rsp *rsp);
> -
> -/*
> - * Reload devlink.
> - */
> -struct devlink_reload_rsp *
> -devlink_reload(struct ynl_sock *ys, struct devlink_reload_req *req);
> -
> -/* ============== DEVLINK_CMD_PARAM_GET ============== */
> -/* DEVLINK_CMD_PARAM_GET - do */
> -struct devlink_param_get_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 param_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	char *param_name;
> -};
> -
> -static inline struct devlink_param_get_req *devlink_param_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_param_get_req));
> -}
> -void devlink_param_get_req_free(struct devlink_param_get_req *req);
> -
> -static inline void
> -devlink_param_get_req_set_bus_name(struct devlink_param_get_req *req,
> -				   const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_param_get_req_set_dev_name(struct devlink_param_get_req *req,
> -				   const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_param_get_req_set_param_name(struct devlink_param_get_req *req,
> -				     const char *param_name)
> -{
> -	free(req->param_name);
> -	req->_present.param_name_len = strlen(param_name);
> -	req->param_name = malloc(req->_present.param_name_len + 1);
> -	memcpy(req->param_name, param_name, req->_present.param_name_len);
> -	req->param_name[req->_present.param_name_len] = 0;
> -}
> -
> -struct devlink_param_get_rsp {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 param_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	char *param_name;
> -};
> -
> -void devlink_param_get_rsp_free(struct devlink_param_get_rsp *rsp);
> -
> -/*
> - * Get param instances.
> - */
> -struct devlink_param_get_rsp *
> -devlink_param_get(struct ynl_sock *ys, struct devlink_param_get_req *req);
> -
> -/* DEVLINK_CMD_PARAM_GET - dump */
> -struct devlink_param_get_req_dump {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -};
> -
> -static inline struct devlink_param_get_req_dump *
> -devlink_param_get_req_dump_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_param_get_req_dump));
> -}
> -void devlink_param_get_req_dump_free(struct devlink_param_get_req_dump *req);
> -
> -static inline void
> -devlink_param_get_req_dump_set_bus_name(struct devlink_param_get_req_dump *req,
> -					const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_param_get_req_dump_set_dev_name(struct devlink_param_get_req_dump *req,
> -					const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -
> -struct devlink_param_get_list {
> -	struct devlink_param_get_list *next;
> -	struct devlink_param_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void devlink_param_get_list_free(struct devlink_param_get_list *rsp);
> -
> -struct devlink_param_get_list *
> -devlink_param_get_dump(struct ynl_sock *ys,
> -		       struct devlink_param_get_req_dump *req);
> -
> -/* ============== DEVLINK_CMD_PARAM_SET ============== */
> -/* DEVLINK_CMD_PARAM_SET - do */
> -struct devlink_param_set_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 param_name_len;
> -		__u32 param_type:1;
> -		__u32 param_value_cmode:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	char *param_name;
> -	__u8 param_type;
> -	enum devlink_param_cmode param_value_cmode;
> -};
> -
> -static inline struct devlink_param_set_req *devlink_param_set_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_param_set_req));
> -}
> -void devlink_param_set_req_free(struct devlink_param_set_req *req);
> -
> -static inline void
> -devlink_param_set_req_set_bus_name(struct devlink_param_set_req *req,
> -				   const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_param_set_req_set_dev_name(struct devlink_param_set_req *req,
> -				   const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_param_set_req_set_param_name(struct devlink_param_set_req *req,
> -				     const char *param_name)
> -{
> -	free(req->param_name);
> -	req->_present.param_name_len = strlen(param_name);
> -	req->param_name = malloc(req->_present.param_name_len + 1);
> -	memcpy(req->param_name, param_name, req->_present.param_name_len);
> -	req->param_name[req->_present.param_name_len] = 0;
> -}
> -static inline void
> -devlink_param_set_req_set_param_type(struct devlink_param_set_req *req,
> -				     __u8 param_type)
> -{
> -	req->_present.param_type = 1;
> -	req->param_type = param_type;
> -}
> -static inline void
> -devlink_param_set_req_set_param_value_cmode(struct devlink_param_set_req *req,
> -					    enum devlink_param_cmode param_value_cmode)
> -{
> -	req->_present.param_value_cmode = 1;
> -	req->param_value_cmode = param_value_cmode;
> -}
> -
> -/*
> - * Set param instances.
> - */
> -int devlink_param_set(struct ynl_sock *ys, struct devlink_param_set_req *req);
> -
> -/* ============== DEVLINK_CMD_REGION_GET ============== */
> -/* DEVLINK_CMD_REGION_GET - do */
> -struct devlink_region_get_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 port_index:1;
> -		__u32 region_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 port_index;
> -	char *region_name;
> -};
> -
> -static inline struct devlink_region_get_req *devlink_region_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_region_get_req));
> -}
> -void devlink_region_get_req_free(struct devlink_region_get_req *req);
> -
> -static inline void
> -devlink_region_get_req_set_bus_name(struct devlink_region_get_req *req,
> -				    const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_region_get_req_set_dev_name(struct devlink_region_get_req *req,
> -				    const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_region_get_req_set_port_index(struct devlink_region_get_req *req,
> -				      __u32 port_index)
> -{
> -	req->_present.port_index = 1;
> -	req->port_index = port_index;
> -}
> -static inline void
> -devlink_region_get_req_set_region_name(struct devlink_region_get_req *req,
> -				       const char *region_name)
> -{
> -	free(req->region_name);
> -	req->_present.region_name_len = strlen(region_name);
> -	req->region_name = malloc(req->_present.region_name_len + 1);
> -	memcpy(req->region_name, region_name, req->_present.region_name_len);
> -	req->region_name[req->_present.region_name_len] = 0;
> -}
> -
> -struct devlink_region_get_rsp {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 port_index:1;
> -		__u32 region_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 port_index;
> -	char *region_name;
> -};
> -
> -void devlink_region_get_rsp_free(struct devlink_region_get_rsp *rsp);
> -
> -/*
> - * Get region instances.
> - */
> -struct devlink_region_get_rsp *
> -devlink_region_get(struct ynl_sock *ys, struct devlink_region_get_req *req);
> -
> -/* DEVLINK_CMD_REGION_GET - dump */
> -struct devlink_region_get_req_dump {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -};
> -
> -static inline struct devlink_region_get_req_dump *
> -devlink_region_get_req_dump_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_region_get_req_dump));
> -}
> -void devlink_region_get_req_dump_free(struct devlink_region_get_req_dump *req);
> -
> -static inline void
> -devlink_region_get_req_dump_set_bus_name(struct devlink_region_get_req_dump *req,
> -					 const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_region_get_req_dump_set_dev_name(struct devlink_region_get_req_dump *req,
> -					 const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -
> -struct devlink_region_get_list {
> -	struct devlink_region_get_list *next;
> -	struct devlink_region_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void devlink_region_get_list_free(struct devlink_region_get_list *rsp);
> -
> -struct devlink_region_get_list *
> -devlink_region_get_dump(struct ynl_sock *ys,
> -			struct devlink_region_get_req_dump *req);
> -
> -/* ============== DEVLINK_CMD_REGION_NEW ============== */
> -/* DEVLINK_CMD_REGION_NEW - do */
> -struct devlink_region_new_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 port_index:1;
> -		__u32 region_name_len;
> -		__u32 region_snapshot_id:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 port_index;
> -	char *region_name;
> -	__u32 region_snapshot_id;
> -};
> -
> -static inline struct devlink_region_new_req *devlink_region_new_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_region_new_req));
> -}
> -void devlink_region_new_req_free(struct devlink_region_new_req *req);
> -
> -static inline void
> -devlink_region_new_req_set_bus_name(struct devlink_region_new_req *req,
> -				    const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_region_new_req_set_dev_name(struct devlink_region_new_req *req,
> -				    const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_region_new_req_set_port_index(struct devlink_region_new_req *req,
> -				      __u32 port_index)
> -{
> -	req->_present.port_index = 1;
> -	req->port_index = port_index;
> -}
> -static inline void
> -devlink_region_new_req_set_region_name(struct devlink_region_new_req *req,
> -				       const char *region_name)
> -{
> -	free(req->region_name);
> -	req->_present.region_name_len = strlen(region_name);
> -	req->region_name = malloc(req->_present.region_name_len + 1);
> -	memcpy(req->region_name, region_name, req->_present.region_name_len);
> -	req->region_name[req->_present.region_name_len] = 0;
> -}
> -static inline void
> -devlink_region_new_req_set_region_snapshot_id(struct devlink_region_new_req *req,
> -					      __u32 region_snapshot_id)
> -{
> -	req->_present.region_snapshot_id = 1;
> -	req->region_snapshot_id = region_snapshot_id;
> -}
> -
> -struct devlink_region_new_rsp {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 port_index:1;
> -		__u32 region_name_len;
> -		__u32 region_snapshot_id:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 port_index;
> -	char *region_name;
> -	__u32 region_snapshot_id;
> -};
> -
> -void devlink_region_new_rsp_free(struct devlink_region_new_rsp *rsp);
> -
> -/*
> - * Create region snapshot.
> - */
> -struct devlink_region_new_rsp *
> -devlink_region_new(struct ynl_sock *ys, struct devlink_region_new_req *req);
> -
> -/* ============== DEVLINK_CMD_REGION_DEL ============== */
> -/* DEVLINK_CMD_REGION_DEL - do */
> -struct devlink_region_del_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 port_index:1;
> -		__u32 region_name_len;
> -		__u32 region_snapshot_id:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 port_index;
> -	char *region_name;
> -	__u32 region_snapshot_id;
> -};
> -
> -static inline struct devlink_region_del_req *devlink_region_del_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_region_del_req));
> -}
> -void devlink_region_del_req_free(struct devlink_region_del_req *req);
> -
> -static inline void
> -devlink_region_del_req_set_bus_name(struct devlink_region_del_req *req,
> -				    const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_region_del_req_set_dev_name(struct devlink_region_del_req *req,
> -				    const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_region_del_req_set_port_index(struct devlink_region_del_req *req,
> -				      __u32 port_index)
> -{
> -	req->_present.port_index = 1;
> -	req->port_index = port_index;
> -}
> -static inline void
> -devlink_region_del_req_set_region_name(struct devlink_region_del_req *req,
> -				       const char *region_name)
> -{
> -	free(req->region_name);
> -	req->_present.region_name_len = strlen(region_name);
> -	req->region_name = malloc(req->_present.region_name_len + 1);
> -	memcpy(req->region_name, region_name, req->_present.region_name_len);
> -	req->region_name[req->_present.region_name_len] = 0;
> -}
> -static inline void
> -devlink_region_del_req_set_region_snapshot_id(struct devlink_region_del_req *req,
> -					      __u32 region_snapshot_id)
> -{
> -	req->_present.region_snapshot_id = 1;
> -	req->region_snapshot_id = region_snapshot_id;
> -}
> -
> -/*
> - * Delete region snapshot.
> - */
> -int devlink_region_del(struct ynl_sock *ys, struct devlink_region_del_req *req);
> -
> -/* ============== DEVLINK_CMD_REGION_READ ============== */
> -/* DEVLINK_CMD_REGION_READ - dump */
> -struct devlink_region_read_req_dump {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 port_index:1;
> -		__u32 region_name_len;
> -		__u32 region_snapshot_id:1;
> -		__u32 region_direct:1;
> -		__u32 region_chunk_addr:1;
> -		__u32 region_chunk_len:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 port_index;
> -	char *region_name;
> -	__u32 region_snapshot_id;
> -	__u64 region_chunk_addr;
> -	__u64 region_chunk_len;
> -};
> -
> -static inline struct devlink_region_read_req_dump *
> -devlink_region_read_req_dump_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_region_read_req_dump));
> -}
> -void
> -devlink_region_read_req_dump_free(struct devlink_region_read_req_dump *req);
> -
> -static inline void
> -devlink_region_read_req_dump_set_bus_name(struct devlink_region_read_req_dump *req,
> -					  const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_region_read_req_dump_set_dev_name(struct devlink_region_read_req_dump *req,
> -					  const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_region_read_req_dump_set_port_index(struct devlink_region_read_req_dump *req,
> -					    __u32 port_index)
> -{
> -	req->_present.port_index = 1;
> -	req->port_index = port_index;
> -}
> -static inline void
> -devlink_region_read_req_dump_set_region_name(struct devlink_region_read_req_dump *req,
> -					     const char *region_name)
> -{
> -	free(req->region_name);
> -	req->_present.region_name_len = strlen(region_name);
> -	req->region_name = malloc(req->_present.region_name_len + 1);
> -	memcpy(req->region_name, region_name, req->_present.region_name_len);
> -	req->region_name[req->_present.region_name_len] = 0;
> -}
> -static inline void
> -devlink_region_read_req_dump_set_region_snapshot_id(struct devlink_region_read_req_dump *req,
> -						    __u32 region_snapshot_id)
> -{
> -	req->_present.region_snapshot_id = 1;
> -	req->region_snapshot_id = region_snapshot_id;
> -}
> -static inline void
> -devlink_region_read_req_dump_set_region_direct(struct devlink_region_read_req_dump *req)
> -{
> -	req->_present.region_direct = 1;
> -}
> -static inline void
> -devlink_region_read_req_dump_set_region_chunk_addr(struct devlink_region_read_req_dump *req,
> -						   __u64 region_chunk_addr)
> -{
> -	req->_present.region_chunk_addr = 1;
> -	req->region_chunk_addr = region_chunk_addr;
> -}
> -static inline void
> -devlink_region_read_req_dump_set_region_chunk_len(struct devlink_region_read_req_dump *req,
> -						  __u64 region_chunk_len)
> -{
> -	req->_present.region_chunk_len = 1;
> -	req->region_chunk_len = region_chunk_len;
> -}
> -
> -struct devlink_region_read_rsp_dump {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 port_index:1;
> -		__u32 region_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 port_index;
> -	char *region_name;
> -};
> -
> -struct devlink_region_read_rsp_list {
> -	struct devlink_region_read_rsp_list *next;
> -	struct devlink_region_read_rsp_dump obj __attribute__((aligned(8)));
> -};
> -
> -void
> -devlink_region_read_rsp_list_free(struct devlink_region_read_rsp_list *rsp);
> -
> -struct devlink_region_read_rsp_list *
> -devlink_region_read_dump(struct ynl_sock *ys,
> -			 struct devlink_region_read_req_dump *req);
> -
> -/* ============== DEVLINK_CMD_PORT_PARAM_GET ============== */
> -/* DEVLINK_CMD_PORT_PARAM_GET - do */
> -struct devlink_port_param_get_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 port_index:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 port_index;
> -};
> -
> -static inline struct devlink_port_param_get_req *
> -devlink_port_param_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_port_param_get_req));
> -}
> -void devlink_port_param_get_req_free(struct devlink_port_param_get_req *req);
> -
> -static inline void
> -devlink_port_param_get_req_set_bus_name(struct devlink_port_param_get_req *req,
> -					const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_port_param_get_req_set_dev_name(struct devlink_port_param_get_req *req,
> -					const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_port_param_get_req_set_port_index(struct devlink_port_param_get_req *req,
> -					  __u32 port_index)
> -{
> -	req->_present.port_index = 1;
> -	req->port_index = port_index;
> -}
> -
> -struct devlink_port_param_get_rsp {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 port_index:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 port_index;
> -};
> -
> -void devlink_port_param_get_rsp_free(struct devlink_port_param_get_rsp *rsp);
> -
> -/*
> - * Get port param instances.
> - */
> -struct devlink_port_param_get_rsp *
> -devlink_port_param_get(struct ynl_sock *ys,
> -		       struct devlink_port_param_get_req *req);
> -
> -/* DEVLINK_CMD_PORT_PARAM_GET - dump */
> -struct devlink_port_param_get_list {
> -	struct devlink_port_param_get_list *next;
> -	struct devlink_port_param_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void devlink_port_param_get_list_free(struct devlink_port_param_get_list *rsp);
> -
> -struct devlink_port_param_get_list *
> -devlink_port_param_get_dump(struct ynl_sock *ys);
> -
> -/* ============== DEVLINK_CMD_PORT_PARAM_SET ============== */
> -/* DEVLINK_CMD_PORT_PARAM_SET - do */
> -struct devlink_port_param_set_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 port_index:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 port_index;
> -};
> -
> -static inline struct devlink_port_param_set_req *
> -devlink_port_param_set_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_port_param_set_req));
> -}
> -void devlink_port_param_set_req_free(struct devlink_port_param_set_req *req);
> -
> -static inline void
> -devlink_port_param_set_req_set_bus_name(struct devlink_port_param_set_req *req,
> -					const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_port_param_set_req_set_dev_name(struct devlink_port_param_set_req *req,
> -					const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_port_param_set_req_set_port_index(struct devlink_port_param_set_req *req,
> -					  __u32 port_index)
> -{
> -	req->_present.port_index = 1;
> -	req->port_index = port_index;
> -}
> -
> -/*
> - * Set port param instances.
> - */
> -int devlink_port_param_set(struct ynl_sock *ys,
> -			   struct devlink_port_param_set_req *req);
> -
> -/* ============== DEVLINK_CMD_INFO_GET ============== */
> -/* DEVLINK_CMD_INFO_GET - do */
> -struct devlink_info_get_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -};
> -
> -static inline struct devlink_info_get_req *devlink_info_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_info_get_req));
> -}
> -void devlink_info_get_req_free(struct devlink_info_get_req *req);
> -
> -static inline void
> -devlink_info_get_req_set_bus_name(struct devlink_info_get_req *req,
> -				  const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_info_get_req_set_dev_name(struct devlink_info_get_req *req,
> -				  const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -
> -struct devlink_info_get_rsp {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 info_driver_name_len;
> -		__u32 info_serial_number_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	char *info_driver_name;
> -	char *info_serial_number;
> -	unsigned int n_info_version_fixed;
> -	struct devlink_dl_info_version *info_version_fixed;
> -	unsigned int n_info_version_running;
> -	struct devlink_dl_info_version *info_version_running;
> -	unsigned int n_info_version_stored;
> -	struct devlink_dl_info_version *info_version_stored;
> -};
> -
> -void devlink_info_get_rsp_free(struct devlink_info_get_rsp *rsp);
> -
> -/*
> - * Get device information, like driver name, hardware and firmware versions etc.
> - */
> -struct devlink_info_get_rsp *
> -devlink_info_get(struct ynl_sock *ys, struct devlink_info_get_req *req);
> -
> -/* DEVLINK_CMD_INFO_GET - dump */
> -struct devlink_info_get_list {
> -	struct devlink_info_get_list *next;
> -	struct devlink_info_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void devlink_info_get_list_free(struct devlink_info_get_list *rsp);
> -
> -struct devlink_info_get_list *devlink_info_get_dump(struct ynl_sock *ys);
> -
> -/* ============== DEVLINK_CMD_HEALTH_REPORTER_GET ============== */
> -/* DEVLINK_CMD_HEALTH_REPORTER_GET - do */
> -struct devlink_health_reporter_get_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 port_index:1;
> -		__u32 health_reporter_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 port_index;
> -	char *health_reporter_name;
> -};
> -
> -static inline struct devlink_health_reporter_get_req *
> -devlink_health_reporter_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_health_reporter_get_req));
> -}
> -void
> -devlink_health_reporter_get_req_free(struct devlink_health_reporter_get_req *req);
> -
> -static inline void
> -devlink_health_reporter_get_req_set_bus_name(struct devlink_health_reporter_get_req *req,
> -					     const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_health_reporter_get_req_set_dev_name(struct devlink_health_reporter_get_req *req,
> -					     const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_health_reporter_get_req_set_port_index(struct devlink_health_reporter_get_req *req,
> -					       __u32 port_index)
> -{
> -	req->_present.port_index = 1;
> -	req->port_index = port_index;
> -}
> -static inline void
> -devlink_health_reporter_get_req_set_health_reporter_name(struct devlink_health_reporter_get_req *req,
> -							 const char *health_reporter_name)
> -{
> -	free(req->health_reporter_name);
> -	req->_present.health_reporter_name_len = strlen(health_reporter_name);
> -	req->health_reporter_name = malloc(req->_present.health_reporter_name_len + 1);
> -	memcpy(req->health_reporter_name, health_reporter_name, req->_present.health_reporter_name_len);
> -	req->health_reporter_name[req->_present.health_reporter_name_len] = 0;
> -}
> -
> -struct devlink_health_reporter_get_rsp {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 port_index:1;
> -		__u32 health_reporter_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 port_index;
> -	char *health_reporter_name;
> -};
> -
> -void
> -devlink_health_reporter_get_rsp_free(struct devlink_health_reporter_get_rsp *rsp);
> -
> -/*
> - * Get health reporter instances.
> - */
> -struct devlink_health_reporter_get_rsp *
> -devlink_health_reporter_get(struct ynl_sock *ys,
> -			    struct devlink_health_reporter_get_req *req);
> -
> -/* DEVLINK_CMD_HEALTH_REPORTER_GET - dump */
> -struct devlink_health_reporter_get_req_dump {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 port_index:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 port_index;
> -};
> -
> -static inline struct devlink_health_reporter_get_req_dump *
> -devlink_health_reporter_get_req_dump_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_health_reporter_get_req_dump));
> -}
> -void
> -devlink_health_reporter_get_req_dump_free(struct devlink_health_reporter_get_req_dump *req);
> -
> -static inline void
> -devlink_health_reporter_get_req_dump_set_bus_name(struct devlink_health_reporter_get_req_dump *req,
> -						  const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_health_reporter_get_req_dump_set_dev_name(struct devlink_health_reporter_get_req_dump *req,
> -						  const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_health_reporter_get_req_dump_set_port_index(struct devlink_health_reporter_get_req_dump *req,
> -						    __u32 port_index)
> -{
> -	req->_present.port_index = 1;
> -	req->port_index = port_index;
> -}
> -
> -struct devlink_health_reporter_get_list {
> -	struct devlink_health_reporter_get_list *next;
> -	struct devlink_health_reporter_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void
> -devlink_health_reporter_get_list_free(struct devlink_health_reporter_get_list *rsp);
> -
> -struct devlink_health_reporter_get_list *
> -devlink_health_reporter_get_dump(struct ynl_sock *ys,
> -				 struct devlink_health_reporter_get_req_dump *req);
> -
> -/* ============== DEVLINK_CMD_HEALTH_REPORTER_SET ============== */
> -/* DEVLINK_CMD_HEALTH_REPORTER_SET - do */
> -struct devlink_health_reporter_set_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 port_index:1;
> -		__u32 health_reporter_name_len;
> -		__u32 health_reporter_graceful_period:1;
> -		__u32 health_reporter_auto_recover:1;
> -		__u32 health_reporter_auto_dump:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 port_index;
> -	char *health_reporter_name;
> -	__u64 health_reporter_graceful_period;
> -	__u8 health_reporter_auto_recover;
> -	__u8 health_reporter_auto_dump;
> -};
> -
> -static inline struct devlink_health_reporter_set_req *
> -devlink_health_reporter_set_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_health_reporter_set_req));
> -}
> -void
> -devlink_health_reporter_set_req_free(struct devlink_health_reporter_set_req *req);
> -
> -static inline void
> -devlink_health_reporter_set_req_set_bus_name(struct devlink_health_reporter_set_req *req,
> -					     const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_health_reporter_set_req_set_dev_name(struct devlink_health_reporter_set_req *req,
> -					     const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_health_reporter_set_req_set_port_index(struct devlink_health_reporter_set_req *req,
> -					       __u32 port_index)
> -{
> -	req->_present.port_index = 1;
> -	req->port_index = port_index;
> -}
> -static inline void
> -devlink_health_reporter_set_req_set_health_reporter_name(struct devlink_health_reporter_set_req *req,
> -							 const char *health_reporter_name)
> -{
> -	free(req->health_reporter_name);
> -	req->_present.health_reporter_name_len = strlen(health_reporter_name);
> -	req->health_reporter_name = malloc(req->_present.health_reporter_name_len + 1);
> -	memcpy(req->health_reporter_name, health_reporter_name, req->_present.health_reporter_name_len);
> -	req->health_reporter_name[req->_present.health_reporter_name_len] = 0;
> -}
> -static inline void
> -devlink_health_reporter_set_req_set_health_reporter_graceful_period(struct devlink_health_reporter_set_req *req,
> -								    __u64 health_reporter_graceful_period)
> -{
> -	req->_present.health_reporter_graceful_period = 1;
> -	req->health_reporter_graceful_period = health_reporter_graceful_period;
> -}
> -static inline void
> -devlink_health_reporter_set_req_set_health_reporter_auto_recover(struct devlink_health_reporter_set_req *req,
> -								 __u8 health_reporter_auto_recover)
> -{
> -	req->_present.health_reporter_auto_recover = 1;
> -	req->health_reporter_auto_recover = health_reporter_auto_recover;
> -}
> -static inline void
> -devlink_health_reporter_set_req_set_health_reporter_auto_dump(struct devlink_health_reporter_set_req *req,
> -							      __u8 health_reporter_auto_dump)
> -{
> -	req->_present.health_reporter_auto_dump = 1;
> -	req->health_reporter_auto_dump = health_reporter_auto_dump;
> -}
> -
> -/*
> - * Set health reporter instances.
> - */
> -int devlink_health_reporter_set(struct ynl_sock *ys,
> -				struct devlink_health_reporter_set_req *req);
> -
> -/* ============== DEVLINK_CMD_HEALTH_REPORTER_RECOVER ============== */
> -/* DEVLINK_CMD_HEALTH_REPORTER_RECOVER - do */
> -struct devlink_health_reporter_recover_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 port_index:1;
> -		__u32 health_reporter_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 port_index;
> -	char *health_reporter_name;
> -};
> -
> -static inline struct devlink_health_reporter_recover_req *
> -devlink_health_reporter_recover_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_health_reporter_recover_req));
> -}
> -void
> -devlink_health_reporter_recover_req_free(struct devlink_health_reporter_recover_req *req);
> -
> -static inline void
> -devlink_health_reporter_recover_req_set_bus_name(struct devlink_health_reporter_recover_req *req,
> -						 const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_health_reporter_recover_req_set_dev_name(struct devlink_health_reporter_recover_req *req,
> -						 const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_health_reporter_recover_req_set_port_index(struct devlink_health_reporter_recover_req *req,
> -						   __u32 port_index)
> -{
> -	req->_present.port_index = 1;
> -	req->port_index = port_index;
> -}
> -static inline void
> -devlink_health_reporter_recover_req_set_health_reporter_name(struct devlink_health_reporter_recover_req *req,
> -							     const char *health_reporter_name)
> -{
> -	free(req->health_reporter_name);
> -	req->_present.health_reporter_name_len = strlen(health_reporter_name);
> -	req->health_reporter_name = malloc(req->_present.health_reporter_name_len + 1);
> -	memcpy(req->health_reporter_name, health_reporter_name, req->_present.health_reporter_name_len);
> -	req->health_reporter_name[req->_present.health_reporter_name_len] = 0;
> -}
> -
> -/*
> - * Recover health reporter instances.
> - */
> -int devlink_health_reporter_recover(struct ynl_sock *ys,
> -				    struct devlink_health_reporter_recover_req *req);
> -
> -/* ============== DEVLINK_CMD_HEALTH_REPORTER_DIAGNOSE ============== */
> -/* DEVLINK_CMD_HEALTH_REPORTER_DIAGNOSE - do */
> -struct devlink_health_reporter_diagnose_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 port_index:1;
> -		__u32 health_reporter_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 port_index;
> -	char *health_reporter_name;
> -};
> -
> -static inline struct devlink_health_reporter_diagnose_req *
> -devlink_health_reporter_diagnose_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_health_reporter_diagnose_req));
> -}
> -void
> -devlink_health_reporter_diagnose_req_free(struct devlink_health_reporter_diagnose_req *req);
> -
> -static inline void
> -devlink_health_reporter_diagnose_req_set_bus_name(struct devlink_health_reporter_diagnose_req *req,
> -						  const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_health_reporter_diagnose_req_set_dev_name(struct devlink_health_reporter_diagnose_req *req,
> -						  const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_health_reporter_diagnose_req_set_port_index(struct devlink_health_reporter_diagnose_req *req,
> -						    __u32 port_index)
> -{
> -	req->_present.port_index = 1;
> -	req->port_index = port_index;
> -}
> -static inline void
> -devlink_health_reporter_diagnose_req_set_health_reporter_name(struct devlink_health_reporter_diagnose_req *req,
> -							      const char *health_reporter_name)
> -{
> -	free(req->health_reporter_name);
> -	req->_present.health_reporter_name_len = strlen(health_reporter_name);
> -	req->health_reporter_name = malloc(req->_present.health_reporter_name_len + 1);
> -	memcpy(req->health_reporter_name, health_reporter_name, req->_present.health_reporter_name_len);
> -	req->health_reporter_name[req->_present.health_reporter_name_len] = 0;
> -}
> -
> -/*
> - * Diagnose health reporter instances.
> - */
> -int devlink_health_reporter_diagnose(struct ynl_sock *ys,
> -				     struct devlink_health_reporter_diagnose_req *req);
> -
> -/* ============== DEVLINK_CMD_HEALTH_REPORTER_DUMP_GET ============== */
> -/* DEVLINK_CMD_HEALTH_REPORTER_DUMP_GET - dump */
> -struct devlink_health_reporter_dump_get_req_dump {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 port_index:1;
> -		__u32 health_reporter_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 port_index;
> -	char *health_reporter_name;
> -};
> -
> -static inline struct devlink_health_reporter_dump_get_req_dump *
> -devlink_health_reporter_dump_get_req_dump_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_health_reporter_dump_get_req_dump));
> -}
> -void
> -devlink_health_reporter_dump_get_req_dump_free(struct devlink_health_reporter_dump_get_req_dump *req);
> -
> -static inline void
> -devlink_health_reporter_dump_get_req_dump_set_bus_name(struct devlink_health_reporter_dump_get_req_dump *req,
> -						       const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_health_reporter_dump_get_req_dump_set_dev_name(struct devlink_health_reporter_dump_get_req_dump *req,
> -						       const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_health_reporter_dump_get_req_dump_set_port_index(struct devlink_health_reporter_dump_get_req_dump *req,
> -							 __u32 port_index)
> -{
> -	req->_present.port_index = 1;
> -	req->port_index = port_index;
> -}
> -static inline void
> -devlink_health_reporter_dump_get_req_dump_set_health_reporter_name(struct devlink_health_reporter_dump_get_req_dump *req,
> -								   const char *health_reporter_name)
> -{
> -	free(req->health_reporter_name);
> -	req->_present.health_reporter_name_len = strlen(health_reporter_name);
> -	req->health_reporter_name = malloc(req->_present.health_reporter_name_len + 1);
> -	memcpy(req->health_reporter_name, health_reporter_name, req->_present.health_reporter_name_len);
> -	req->health_reporter_name[req->_present.health_reporter_name_len] = 0;
> -}
> -
> -struct devlink_health_reporter_dump_get_rsp_dump {
> -	struct {
> -		__u32 fmsg:1;
> -	} _present;
> -
> -	struct devlink_dl_fmsg fmsg;
> -};
> -
> -struct devlink_health_reporter_dump_get_rsp_list {
> -	struct devlink_health_reporter_dump_get_rsp_list *next;
> -	struct devlink_health_reporter_dump_get_rsp_dump obj __attribute__((aligned(8)));
> -};
> -
> -void
> -devlink_health_reporter_dump_get_rsp_list_free(struct devlink_health_reporter_dump_get_rsp_list *rsp);
> -
> -struct devlink_health_reporter_dump_get_rsp_list *
> -devlink_health_reporter_dump_get_dump(struct ynl_sock *ys,
> -				      struct devlink_health_reporter_dump_get_req_dump *req);
> -
> -/* ============== DEVLINK_CMD_HEALTH_REPORTER_DUMP_CLEAR ============== */
> -/* DEVLINK_CMD_HEALTH_REPORTER_DUMP_CLEAR - do */
> -struct devlink_health_reporter_dump_clear_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 port_index:1;
> -		__u32 health_reporter_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 port_index;
> -	char *health_reporter_name;
> -};
> -
> -static inline struct devlink_health_reporter_dump_clear_req *
> -devlink_health_reporter_dump_clear_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_health_reporter_dump_clear_req));
> -}
> -void
> -devlink_health_reporter_dump_clear_req_free(struct devlink_health_reporter_dump_clear_req *req);
> -
> -static inline void
> -devlink_health_reporter_dump_clear_req_set_bus_name(struct devlink_health_reporter_dump_clear_req *req,
> -						    const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_health_reporter_dump_clear_req_set_dev_name(struct devlink_health_reporter_dump_clear_req *req,
> -						    const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_health_reporter_dump_clear_req_set_port_index(struct devlink_health_reporter_dump_clear_req *req,
> -						      __u32 port_index)
> -{
> -	req->_present.port_index = 1;
> -	req->port_index = port_index;
> -}
> -static inline void
> -devlink_health_reporter_dump_clear_req_set_health_reporter_name(struct devlink_health_reporter_dump_clear_req *req,
> -								const char *health_reporter_name)
> -{
> -	free(req->health_reporter_name);
> -	req->_present.health_reporter_name_len = strlen(health_reporter_name);
> -	req->health_reporter_name = malloc(req->_present.health_reporter_name_len + 1);
> -	memcpy(req->health_reporter_name, health_reporter_name, req->_present.health_reporter_name_len);
> -	req->health_reporter_name[req->_present.health_reporter_name_len] = 0;
> -}
> -
> -/*
> - * Clear dump of health reporter instances.
> - */
> -int devlink_health_reporter_dump_clear(struct ynl_sock *ys,
> -				       struct devlink_health_reporter_dump_clear_req *req);
> -
> -/* ============== DEVLINK_CMD_FLASH_UPDATE ============== */
> -/* DEVLINK_CMD_FLASH_UPDATE - do */
> -struct devlink_flash_update_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 flash_update_file_name_len;
> -		__u32 flash_update_component_len;
> -		__u32 flash_update_overwrite_mask:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	char *flash_update_file_name;
> -	char *flash_update_component;
> -	struct nla_bitfield32 flash_update_overwrite_mask;
> -};
> -
> -static inline struct devlink_flash_update_req *
> -devlink_flash_update_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_flash_update_req));
> -}
> -void devlink_flash_update_req_free(struct devlink_flash_update_req *req);
> -
> -static inline void
> -devlink_flash_update_req_set_bus_name(struct devlink_flash_update_req *req,
> -				      const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_flash_update_req_set_dev_name(struct devlink_flash_update_req *req,
> -				      const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_flash_update_req_set_flash_update_file_name(struct devlink_flash_update_req *req,
> -						    const char *flash_update_file_name)
> -{
> -	free(req->flash_update_file_name);
> -	req->_present.flash_update_file_name_len = strlen(flash_update_file_name);
> -	req->flash_update_file_name = malloc(req->_present.flash_update_file_name_len + 1);
> -	memcpy(req->flash_update_file_name, flash_update_file_name, req->_present.flash_update_file_name_len);
> -	req->flash_update_file_name[req->_present.flash_update_file_name_len] = 0;
> -}
> -static inline void
> -devlink_flash_update_req_set_flash_update_component(struct devlink_flash_update_req *req,
> -						    const char *flash_update_component)
> -{
> -	free(req->flash_update_component);
> -	req->_present.flash_update_component_len = strlen(flash_update_component);
> -	req->flash_update_component = malloc(req->_present.flash_update_component_len + 1);
> -	memcpy(req->flash_update_component, flash_update_component, req->_present.flash_update_component_len);
> -	req->flash_update_component[req->_present.flash_update_component_len] = 0;
> -}
> -static inline void
> -devlink_flash_update_req_set_flash_update_overwrite_mask(struct devlink_flash_update_req *req,
> -							 struct nla_bitfield32 *flash_update_overwrite_mask)
> -{
> -	req->_present.flash_update_overwrite_mask = 1;
> -	memcpy(&req->flash_update_overwrite_mask, flash_update_overwrite_mask, sizeof(struct nla_bitfield32));
> -}
> -
> -/*
> - * Flash update devlink instances.
> - */
> -int devlink_flash_update(struct ynl_sock *ys,
> -			 struct devlink_flash_update_req *req);
> -
> -/* ============== DEVLINK_CMD_TRAP_GET ============== */
> -/* DEVLINK_CMD_TRAP_GET - do */
> -struct devlink_trap_get_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 trap_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	char *trap_name;
> -};
> -
> -static inline struct devlink_trap_get_req *devlink_trap_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_trap_get_req));
> -}
> -void devlink_trap_get_req_free(struct devlink_trap_get_req *req);
> -
> -static inline void
> -devlink_trap_get_req_set_bus_name(struct devlink_trap_get_req *req,
> -				  const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_trap_get_req_set_dev_name(struct devlink_trap_get_req *req,
> -				  const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_trap_get_req_set_trap_name(struct devlink_trap_get_req *req,
> -				   const char *trap_name)
> -{
> -	free(req->trap_name);
> -	req->_present.trap_name_len = strlen(trap_name);
> -	req->trap_name = malloc(req->_present.trap_name_len + 1);
> -	memcpy(req->trap_name, trap_name, req->_present.trap_name_len);
> -	req->trap_name[req->_present.trap_name_len] = 0;
> -}
> -
> -struct devlink_trap_get_rsp {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 trap_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	char *trap_name;
> -};
> -
> -void devlink_trap_get_rsp_free(struct devlink_trap_get_rsp *rsp);
> -
> -/*
> - * Get trap instances.
> - */
> -struct devlink_trap_get_rsp *
> -devlink_trap_get(struct ynl_sock *ys, struct devlink_trap_get_req *req);
> -
> -/* DEVLINK_CMD_TRAP_GET - dump */
> -struct devlink_trap_get_req_dump {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -};
> -
> -static inline struct devlink_trap_get_req_dump *
> -devlink_trap_get_req_dump_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_trap_get_req_dump));
> -}
> -void devlink_trap_get_req_dump_free(struct devlink_trap_get_req_dump *req);
> -
> -static inline void
> -devlink_trap_get_req_dump_set_bus_name(struct devlink_trap_get_req_dump *req,
> -				       const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_trap_get_req_dump_set_dev_name(struct devlink_trap_get_req_dump *req,
> -				       const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -
> -struct devlink_trap_get_list {
> -	struct devlink_trap_get_list *next;
> -	struct devlink_trap_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void devlink_trap_get_list_free(struct devlink_trap_get_list *rsp);
> -
> -struct devlink_trap_get_list *
> -devlink_trap_get_dump(struct ynl_sock *ys,
> -		      struct devlink_trap_get_req_dump *req);
> -
> -/* ============== DEVLINK_CMD_TRAP_SET ============== */
> -/* DEVLINK_CMD_TRAP_SET - do */
> -struct devlink_trap_set_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 trap_name_len;
> -		__u32 trap_action:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	char *trap_name;
> -	enum devlink_trap_action trap_action;
> -};
> -
> -static inline struct devlink_trap_set_req *devlink_trap_set_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_trap_set_req));
> -}
> -void devlink_trap_set_req_free(struct devlink_trap_set_req *req);
> -
> -static inline void
> -devlink_trap_set_req_set_bus_name(struct devlink_trap_set_req *req,
> -				  const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_trap_set_req_set_dev_name(struct devlink_trap_set_req *req,
> -				  const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_trap_set_req_set_trap_name(struct devlink_trap_set_req *req,
> -				   const char *trap_name)
> -{
> -	free(req->trap_name);
> -	req->_present.trap_name_len = strlen(trap_name);
> -	req->trap_name = malloc(req->_present.trap_name_len + 1);
> -	memcpy(req->trap_name, trap_name, req->_present.trap_name_len);
> -	req->trap_name[req->_present.trap_name_len] = 0;
> -}
> -static inline void
> -devlink_trap_set_req_set_trap_action(struct devlink_trap_set_req *req,
> -				     enum devlink_trap_action trap_action)
> -{
> -	req->_present.trap_action = 1;
> -	req->trap_action = trap_action;
> -}
> -
> -/*
> - * Set trap instances.
> - */
> -int devlink_trap_set(struct ynl_sock *ys, struct devlink_trap_set_req *req);
> -
> -/* ============== DEVLINK_CMD_TRAP_GROUP_GET ============== */
> -/* DEVLINK_CMD_TRAP_GROUP_GET - do */
> -struct devlink_trap_group_get_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 trap_group_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	char *trap_group_name;
> -};
> -
> -static inline struct devlink_trap_group_get_req *
> -devlink_trap_group_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_trap_group_get_req));
> -}
> -void devlink_trap_group_get_req_free(struct devlink_trap_group_get_req *req);
> -
> -static inline void
> -devlink_trap_group_get_req_set_bus_name(struct devlink_trap_group_get_req *req,
> -					const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_trap_group_get_req_set_dev_name(struct devlink_trap_group_get_req *req,
> -					const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_trap_group_get_req_set_trap_group_name(struct devlink_trap_group_get_req *req,
> -					       const char *trap_group_name)
> -{
> -	free(req->trap_group_name);
> -	req->_present.trap_group_name_len = strlen(trap_group_name);
> -	req->trap_group_name = malloc(req->_present.trap_group_name_len + 1);
> -	memcpy(req->trap_group_name, trap_group_name, req->_present.trap_group_name_len);
> -	req->trap_group_name[req->_present.trap_group_name_len] = 0;
> -}
> -
> -struct devlink_trap_group_get_rsp {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 trap_group_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	char *trap_group_name;
> -};
> -
> -void devlink_trap_group_get_rsp_free(struct devlink_trap_group_get_rsp *rsp);
> -
> -/*
> - * Get trap group instances.
> - */
> -struct devlink_trap_group_get_rsp *
> -devlink_trap_group_get(struct ynl_sock *ys,
> -		       struct devlink_trap_group_get_req *req);
> -
> -/* DEVLINK_CMD_TRAP_GROUP_GET - dump */
> -struct devlink_trap_group_get_req_dump {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -};
> -
> -static inline struct devlink_trap_group_get_req_dump *
> -devlink_trap_group_get_req_dump_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_trap_group_get_req_dump));
> -}
> -void
> -devlink_trap_group_get_req_dump_free(struct devlink_trap_group_get_req_dump *req);
> -
> -static inline void
> -devlink_trap_group_get_req_dump_set_bus_name(struct devlink_trap_group_get_req_dump *req,
> -					     const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_trap_group_get_req_dump_set_dev_name(struct devlink_trap_group_get_req_dump *req,
> -					     const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -
> -struct devlink_trap_group_get_list {
> -	struct devlink_trap_group_get_list *next;
> -	struct devlink_trap_group_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void devlink_trap_group_get_list_free(struct devlink_trap_group_get_list *rsp);
> -
> -struct devlink_trap_group_get_list *
> -devlink_trap_group_get_dump(struct ynl_sock *ys,
> -			    struct devlink_trap_group_get_req_dump *req);
> -
> -/* ============== DEVLINK_CMD_TRAP_GROUP_SET ============== */
> -/* DEVLINK_CMD_TRAP_GROUP_SET - do */
> -struct devlink_trap_group_set_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 trap_group_name_len;
> -		__u32 trap_action:1;
> -		__u32 trap_policer_id:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	char *trap_group_name;
> -	enum devlink_trap_action trap_action;
> -	__u32 trap_policer_id;
> -};
> -
> -static inline struct devlink_trap_group_set_req *
> -devlink_trap_group_set_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_trap_group_set_req));
> -}
> -void devlink_trap_group_set_req_free(struct devlink_trap_group_set_req *req);
> -
> -static inline void
> -devlink_trap_group_set_req_set_bus_name(struct devlink_trap_group_set_req *req,
> -					const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_trap_group_set_req_set_dev_name(struct devlink_trap_group_set_req *req,
> -					const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_trap_group_set_req_set_trap_group_name(struct devlink_trap_group_set_req *req,
> -					       const char *trap_group_name)
> -{
> -	free(req->trap_group_name);
> -	req->_present.trap_group_name_len = strlen(trap_group_name);
> -	req->trap_group_name = malloc(req->_present.trap_group_name_len + 1);
> -	memcpy(req->trap_group_name, trap_group_name, req->_present.trap_group_name_len);
> -	req->trap_group_name[req->_present.trap_group_name_len] = 0;
> -}
> -static inline void
> -devlink_trap_group_set_req_set_trap_action(struct devlink_trap_group_set_req *req,
> -					   enum devlink_trap_action trap_action)
> -{
> -	req->_present.trap_action = 1;
> -	req->trap_action = trap_action;
> -}
> -static inline void
> -devlink_trap_group_set_req_set_trap_policer_id(struct devlink_trap_group_set_req *req,
> -					       __u32 trap_policer_id)
> -{
> -	req->_present.trap_policer_id = 1;
> -	req->trap_policer_id = trap_policer_id;
> -}
> -
> -/*
> - * Set trap group instances.
> - */
> -int devlink_trap_group_set(struct ynl_sock *ys,
> -			   struct devlink_trap_group_set_req *req);
> -
> -/* ============== DEVLINK_CMD_TRAP_POLICER_GET ============== */
> -/* DEVLINK_CMD_TRAP_POLICER_GET - do */
> -struct devlink_trap_policer_get_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 trap_policer_id:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 trap_policer_id;
> -};
> -
> -static inline struct devlink_trap_policer_get_req *
> -devlink_trap_policer_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_trap_policer_get_req));
> -}
> -void
> -devlink_trap_policer_get_req_free(struct devlink_trap_policer_get_req *req);
> -
> -static inline void
> -devlink_trap_policer_get_req_set_bus_name(struct devlink_trap_policer_get_req *req,
> -					  const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_trap_policer_get_req_set_dev_name(struct devlink_trap_policer_get_req *req,
> -					  const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_trap_policer_get_req_set_trap_policer_id(struct devlink_trap_policer_get_req *req,
> -						 __u32 trap_policer_id)
> -{
> -	req->_present.trap_policer_id = 1;
> -	req->trap_policer_id = trap_policer_id;
> -}
> -
> -struct devlink_trap_policer_get_rsp {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 trap_policer_id:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 trap_policer_id;
> -};
> -
> -void
> -devlink_trap_policer_get_rsp_free(struct devlink_trap_policer_get_rsp *rsp);
> -
> -/*
> - * Get trap policer instances.
> - */
> -struct devlink_trap_policer_get_rsp *
> -devlink_trap_policer_get(struct ynl_sock *ys,
> -			 struct devlink_trap_policer_get_req *req);
> -
> -/* DEVLINK_CMD_TRAP_POLICER_GET - dump */
> -struct devlink_trap_policer_get_req_dump {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -};
> -
> -static inline struct devlink_trap_policer_get_req_dump *
> -devlink_trap_policer_get_req_dump_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_trap_policer_get_req_dump));
> -}
> -void
> -devlink_trap_policer_get_req_dump_free(struct devlink_trap_policer_get_req_dump *req);
> -
> -static inline void
> -devlink_trap_policer_get_req_dump_set_bus_name(struct devlink_trap_policer_get_req_dump *req,
> -					       const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_trap_policer_get_req_dump_set_dev_name(struct devlink_trap_policer_get_req_dump *req,
> -					       const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -
> -struct devlink_trap_policer_get_list {
> -	struct devlink_trap_policer_get_list *next;
> -	struct devlink_trap_policer_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void
> -devlink_trap_policer_get_list_free(struct devlink_trap_policer_get_list *rsp);
> -
> -struct devlink_trap_policer_get_list *
> -devlink_trap_policer_get_dump(struct ynl_sock *ys,
> -			      struct devlink_trap_policer_get_req_dump *req);
> -
> -/* ============== DEVLINK_CMD_TRAP_POLICER_SET ============== */
> -/* DEVLINK_CMD_TRAP_POLICER_SET - do */
> -struct devlink_trap_policer_set_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 trap_policer_id:1;
> -		__u32 trap_policer_rate:1;
> -		__u32 trap_policer_burst:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 trap_policer_id;
> -	__u64 trap_policer_rate;
> -	__u64 trap_policer_burst;
> -};
> -
> -static inline struct devlink_trap_policer_set_req *
> -devlink_trap_policer_set_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_trap_policer_set_req));
> -}
> -void
> -devlink_trap_policer_set_req_free(struct devlink_trap_policer_set_req *req);
> -
> -static inline void
> -devlink_trap_policer_set_req_set_bus_name(struct devlink_trap_policer_set_req *req,
> -					  const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_trap_policer_set_req_set_dev_name(struct devlink_trap_policer_set_req *req,
> -					  const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_trap_policer_set_req_set_trap_policer_id(struct devlink_trap_policer_set_req *req,
> -						 __u32 trap_policer_id)
> -{
> -	req->_present.trap_policer_id = 1;
> -	req->trap_policer_id = trap_policer_id;
> -}
> -static inline void
> -devlink_trap_policer_set_req_set_trap_policer_rate(struct devlink_trap_policer_set_req *req,
> -						   __u64 trap_policer_rate)
> -{
> -	req->_present.trap_policer_rate = 1;
> -	req->trap_policer_rate = trap_policer_rate;
> -}
> -static inline void
> -devlink_trap_policer_set_req_set_trap_policer_burst(struct devlink_trap_policer_set_req *req,
> -						    __u64 trap_policer_burst)
> -{
> -	req->_present.trap_policer_burst = 1;
> -	req->trap_policer_burst = trap_policer_burst;
> -}
> -
> -/*
> - * Get trap policer instances.
> - */
> -int devlink_trap_policer_set(struct ynl_sock *ys,
> -			     struct devlink_trap_policer_set_req *req);
> -
> -/* ============== DEVLINK_CMD_HEALTH_REPORTER_TEST ============== */
> -/* DEVLINK_CMD_HEALTH_REPORTER_TEST - do */
> -struct devlink_health_reporter_test_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 port_index:1;
> -		__u32 health_reporter_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 port_index;
> -	char *health_reporter_name;
> -};
> -
> -static inline struct devlink_health_reporter_test_req *
> -devlink_health_reporter_test_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_health_reporter_test_req));
> -}
> -void
> -devlink_health_reporter_test_req_free(struct devlink_health_reporter_test_req *req);
> -
> -static inline void
> -devlink_health_reporter_test_req_set_bus_name(struct devlink_health_reporter_test_req *req,
> -					      const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_health_reporter_test_req_set_dev_name(struct devlink_health_reporter_test_req *req,
> -					      const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_health_reporter_test_req_set_port_index(struct devlink_health_reporter_test_req *req,
> -						__u32 port_index)
> -{
> -	req->_present.port_index = 1;
> -	req->port_index = port_index;
> -}
> -static inline void
> -devlink_health_reporter_test_req_set_health_reporter_name(struct devlink_health_reporter_test_req *req,
> -							  const char *health_reporter_name)
> -{
> -	free(req->health_reporter_name);
> -	req->_present.health_reporter_name_len = strlen(health_reporter_name);
> -	req->health_reporter_name = malloc(req->_present.health_reporter_name_len + 1);
> -	memcpy(req->health_reporter_name, health_reporter_name, req->_present.health_reporter_name_len);
> -	req->health_reporter_name[req->_present.health_reporter_name_len] = 0;
> -}
> -
> -/*
> - * Test health reporter instances.
> - */
> -int devlink_health_reporter_test(struct ynl_sock *ys,
> -				 struct devlink_health_reporter_test_req *req);
> -
> -/* ============== DEVLINK_CMD_RATE_GET ============== */
> -/* DEVLINK_CMD_RATE_GET - do */
> -struct devlink_rate_get_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 port_index:1;
> -		__u32 rate_node_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 port_index;
> -	char *rate_node_name;
> -};
> -
> -static inline struct devlink_rate_get_req *devlink_rate_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_rate_get_req));
> -}
> -void devlink_rate_get_req_free(struct devlink_rate_get_req *req);
> -
> -static inline void
> -devlink_rate_get_req_set_bus_name(struct devlink_rate_get_req *req,
> -				  const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_rate_get_req_set_dev_name(struct devlink_rate_get_req *req,
> -				  const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_rate_get_req_set_port_index(struct devlink_rate_get_req *req,
> -				    __u32 port_index)
> -{
> -	req->_present.port_index = 1;
> -	req->port_index = port_index;
> -}
> -static inline void
> -devlink_rate_get_req_set_rate_node_name(struct devlink_rate_get_req *req,
> -					const char *rate_node_name)
> -{
> -	free(req->rate_node_name);
> -	req->_present.rate_node_name_len = strlen(rate_node_name);
> -	req->rate_node_name = malloc(req->_present.rate_node_name_len + 1);
> -	memcpy(req->rate_node_name, rate_node_name, req->_present.rate_node_name_len);
> -	req->rate_node_name[req->_present.rate_node_name_len] = 0;
> -}
> -
> -struct devlink_rate_get_rsp {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 port_index:1;
> -		__u32 rate_node_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 port_index;
> -	char *rate_node_name;
> -};
> -
> -void devlink_rate_get_rsp_free(struct devlink_rate_get_rsp *rsp);
> -
> -/*
> - * Get rate instances.
> - */
> -struct devlink_rate_get_rsp *
> -devlink_rate_get(struct ynl_sock *ys, struct devlink_rate_get_req *req);
> -
> -/* DEVLINK_CMD_RATE_GET - dump */
> -struct devlink_rate_get_req_dump {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -};
> -
> -static inline struct devlink_rate_get_req_dump *
> -devlink_rate_get_req_dump_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_rate_get_req_dump));
> -}
> -void devlink_rate_get_req_dump_free(struct devlink_rate_get_req_dump *req);
> -
> -static inline void
> -devlink_rate_get_req_dump_set_bus_name(struct devlink_rate_get_req_dump *req,
> -				       const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_rate_get_req_dump_set_dev_name(struct devlink_rate_get_req_dump *req,
> -				       const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -
> -struct devlink_rate_get_list {
> -	struct devlink_rate_get_list *next;
> -	struct devlink_rate_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void devlink_rate_get_list_free(struct devlink_rate_get_list *rsp);
> -
> -struct devlink_rate_get_list *
> -devlink_rate_get_dump(struct ynl_sock *ys,
> -		      struct devlink_rate_get_req_dump *req);
> -
> -/* ============== DEVLINK_CMD_RATE_SET ============== */
> -/* DEVLINK_CMD_RATE_SET - do */
> -struct devlink_rate_set_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 rate_node_name_len;
> -		__u32 rate_tx_share:1;
> -		__u32 rate_tx_max:1;
> -		__u32 rate_tx_priority:1;
> -		__u32 rate_tx_weight:1;
> -		__u32 rate_parent_node_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	char *rate_node_name;
> -	__u64 rate_tx_share;
> -	__u64 rate_tx_max;
> -	__u32 rate_tx_priority;
> -	__u32 rate_tx_weight;
> -	char *rate_parent_node_name;
> -};
> -
> -static inline struct devlink_rate_set_req *devlink_rate_set_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_rate_set_req));
> -}
> -void devlink_rate_set_req_free(struct devlink_rate_set_req *req);
> -
> -static inline void
> -devlink_rate_set_req_set_bus_name(struct devlink_rate_set_req *req,
> -				  const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_rate_set_req_set_dev_name(struct devlink_rate_set_req *req,
> -				  const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_rate_set_req_set_rate_node_name(struct devlink_rate_set_req *req,
> -					const char *rate_node_name)
> -{
> -	free(req->rate_node_name);
> -	req->_present.rate_node_name_len = strlen(rate_node_name);
> -	req->rate_node_name = malloc(req->_present.rate_node_name_len + 1);
> -	memcpy(req->rate_node_name, rate_node_name, req->_present.rate_node_name_len);
> -	req->rate_node_name[req->_present.rate_node_name_len] = 0;
> -}
> -static inline void
> -devlink_rate_set_req_set_rate_tx_share(struct devlink_rate_set_req *req,
> -				       __u64 rate_tx_share)
> -{
> -	req->_present.rate_tx_share = 1;
> -	req->rate_tx_share = rate_tx_share;
> -}
> -static inline void
> -devlink_rate_set_req_set_rate_tx_max(struct devlink_rate_set_req *req,
> -				     __u64 rate_tx_max)
> -{
> -	req->_present.rate_tx_max = 1;
> -	req->rate_tx_max = rate_tx_max;
> -}
> -static inline void
> -devlink_rate_set_req_set_rate_tx_priority(struct devlink_rate_set_req *req,
> -					  __u32 rate_tx_priority)
> -{
> -	req->_present.rate_tx_priority = 1;
> -	req->rate_tx_priority = rate_tx_priority;
> -}
> -static inline void
> -devlink_rate_set_req_set_rate_tx_weight(struct devlink_rate_set_req *req,
> -					__u32 rate_tx_weight)
> -{
> -	req->_present.rate_tx_weight = 1;
> -	req->rate_tx_weight = rate_tx_weight;
> -}
> -static inline void
> -devlink_rate_set_req_set_rate_parent_node_name(struct devlink_rate_set_req *req,
> -					       const char *rate_parent_node_name)
> -{
> -	free(req->rate_parent_node_name);
> -	req->_present.rate_parent_node_name_len = strlen(rate_parent_node_name);
> -	req->rate_parent_node_name = malloc(req->_present.rate_parent_node_name_len + 1);
> -	memcpy(req->rate_parent_node_name, rate_parent_node_name, req->_present.rate_parent_node_name_len);
> -	req->rate_parent_node_name[req->_present.rate_parent_node_name_len] = 0;
> -}
> -
> -/*
> - * Set rate instances.
> - */
> -int devlink_rate_set(struct ynl_sock *ys, struct devlink_rate_set_req *req);
> -
> -/* ============== DEVLINK_CMD_RATE_NEW ============== */
> -/* DEVLINK_CMD_RATE_NEW - do */
> -struct devlink_rate_new_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 rate_node_name_len;
> -		__u32 rate_tx_share:1;
> -		__u32 rate_tx_max:1;
> -		__u32 rate_tx_priority:1;
> -		__u32 rate_tx_weight:1;
> -		__u32 rate_parent_node_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	char *rate_node_name;
> -	__u64 rate_tx_share;
> -	__u64 rate_tx_max;
> -	__u32 rate_tx_priority;
> -	__u32 rate_tx_weight;
> -	char *rate_parent_node_name;
> -};
> -
> -static inline struct devlink_rate_new_req *devlink_rate_new_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_rate_new_req));
> -}
> -void devlink_rate_new_req_free(struct devlink_rate_new_req *req);
> -
> -static inline void
> -devlink_rate_new_req_set_bus_name(struct devlink_rate_new_req *req,
> -				  const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_rate_new_req_set_dev_name(struct devlink_rate_new_req *req,
> -				  const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_rate_new_req_set_rate_node_name(struct devlink_rate_new_req *req,
> -					const char *rate_node_name)
> -{
> -	free(req->rate_node_name);
> -	req->_present.rate_node_name_len = strlen(rate_node_name);
> -	req->rate_node_name = malloc(req->_present.rate_node_name_len + 1);
> -	memcpy(req->rate_node_name, rate_node_name, req->_present.rate_node_name_len);
> -	req->rate_node_name[req->_present.rate_node_name_len] = 0;
> -}
> -static inline void
> -devlink_rate_new_req_set_rate_tx_share(struct devlink_rate_new_req *req,
> -				       __u64 rate_tx_share)
> -{
> -	req->_present.rate_tx_share = 1;
> -	req->rate_tx_share = rate_tx_share;
> -}
> -static inline void
> -devlink_rate_new_req_set_rate_tx_max(struct devlink_rate_new_req *req,
> -				     __u64 rate_tx_max)
> -{
> -	req->_present.rate_tx_max = 1;
> -	req->rate_tx_max = rate_tx_max;
> -}
> -static inline void
> -devlink_rate_new_req_set_rate_tx_priority(struct devlink_rate_new_req *req,
> -					  __u32 rate_tx_priority)
> -{
> -	req->_present.rate_tx_priority = 1;
> -	req->rate_tx_priority = rate_tx_priority;
> -}
> -static inline void
> -devlink_rate_new_req_set_rate_tx_weight(struct devlink_rate_new_req *req,
> -					__u32 rate_tx_weight)
> -{
> -	req->_present.rate_tx_weight = 1;
> -	req->rate_tx_weight = rate_tx_weight;
> -}
> -static inline void
> -devlink_rate_new_req_set_rate_parent_node_name(struct devlink_rate_new_req *req,
> -					       const char *rate_parent_node_name)
> -{
> -	free(req->rate_parent_node_name);
> -	req->_present.rate_parent_node_name_len = strlen(rate_parent_node_name);
> -	req->rate_parent_node_name = malloc(req->_present.rate_parent_node_name_len + 1);
> -	memcpy(req->rate_parent_node_name, rate_parent_node_name, req->_present.rate_parent_node_name_len);
> -	req->rate_parent_node_name[req->_present.rate_parent_node_name_len] = 0;
> -}
> -
> -/*
> - * Create rate instances.
> - */
> -int devlink_rate_new(struct ynl_sock *ys, struct devlink_rate_new_req *req);
> -
> -/* ============== DEVLINK_CMD_RATE_DEL ============== */
> -/* DEVLINK_CMD_RATE_DEL - do */
> -struct devlink_rate_del_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 rate_node_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	char *rate_node_name;
> -};
> -
> -static inline struct devlink_rate_del_req *devlink_rate_del_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_rate_del_req));
> -}
> -void devlink_rate_del_req_free(struct devlink_rate_del_req *req);
> -
> -static inline void
> -devlink_rate_del_req_set_bus_name(struct devlink_rate_del_req *req,
> -				  const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_rate_del_req_set_dev_name(struct devlink_rate_del_req *req,
> -				  const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_rate_del_req_set_rate_node_name(struct devlink_rate_del_req *req,
> -					const char *rate_node_name)
> -{
> -	free(req->rate_node_name);
> -	req->_present.rate_node_name_len = strlen(rate_node_name);
> -	req->rate_node_name = malloc(req->_present.rate_node_name_len + 1);
> -	memcpy(req->rate_node_name, rate_node_name, req->_present.rate_node_name_len);
> -	req->rate_node_name[req->_present.rate_node_name_len] = 0;
> -}
> -
> -/*
> - * Delete rate instances.
> - */
> -int devlink_rate_del(struct ynl_sock *ys, struct devlink_rate_del_req *req);
> -
> -/* ============== DEVLINK_CMD_LINECARD_GET ============== */
> -/* DEVLINK_CMD_LINECARD_GET - do */
> -struct devlink_linecard_get_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 linecard_index:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 linecard_index;
> -};
> -
> -static inline struct devlink_linecard_get_req *
> -devlink_linecard_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_linecard_get_req));
> -}
> -void devlink_linecard_get_req_free(struct devlink_linecard_get_req *req);
> -
> -static inline void
> -devlink_linecard_get_req_set_bus_name(struct devlink_linecard_get_req *req,
> -				      const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_linecard_get_req_set_dev_name(struct devlink_linecard_get_req *req,
> -				      const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_linecard_get_req_set_linecard_index(struct devlink_linecard_get_req *req,
> -					    __u32 linecard_index)
> -{
> -	req->_present.linecard_index = 1;
> -	req->linecard_index = linecard_index;
> -}
> -
> -struct devlink_linecard_get_rsp {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 linecard_index:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 linecard_index;
> -};
> -
> -void devlink_linecard_get_rsp_free(struct devlink_linecard_get_rsp *rsp);
> -
> -/*
> - * Get line card instances.
> - */
> -struct devlink_linecard_get_rsp *
> -devlink_linecard_get(struct ynl_sock *ys, struct devlink_linecard_get_req *req);
> -
> -/* DEVLINK_CMD_LINECARD_GET - dump */
> -struct devlink_linecard_get_req_dump {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -};
> -
> -static inline struct devlink_linecard_get_req_dump *
> -devlink_linecard_get_req_dump_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_linecard_get_req_dump));
> -}
> -void
> -devlink_linecard_get_req_dump_free(struct devlink_linecard_get_req_dump *req);
> -
> -static inline void
> -devlink_linecard_get_req_dump_set_bus_name(struct devlink_linecard_get_req_dump *req,
> -					   const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_linecard_get_req_dump_set_dev_name(struct devlink_linecard_get_req_dump *req,
> -					   const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -
> -struct devlink_linecard_get_list {
> -	struct devlink_linecard_get_list *next;
> -	struct devlink_linecard_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void devlink_linecard_get_list_free(struct devlink_linecard_get_list *rsp);
> -
> -struct devlink_linecard_get_list *
> -devlink_linecard_get_dump(struct ynl_sock *ys,
> -			  struct devlink_linecard_get_req_dump *req);
> -
> -/* ============== DEVLINK_CMD_LINECARD_SET ============== */
> -/* DEVLINK_CMD_LINECARD_SET - do */
> -struct devlink_linecard_set_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 linecard_index:1;
> -		__u32 linecard_type_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	__u32 linecard_index;
> -	char *linecard_type;
> -};
> -
> -static inline struct devlink_linecard_set_req *
> -devlink_linecard_set_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_linecard_set_req));
> -}
> -void devlink_linecard_set_req_free(struct devlink_linecard_set_req *req);
> -
> -static inline void
> -devlink_linecard_set_req_set_bus_name(struct devlink_linecard_set_req *req,
> -				      const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_linecard_set_req_set_dev_name(struct devlink_linecard_set_req *req,
> -				      const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_linecard_set_req_set_linecard_index(struct devlink_linecard_set_req *req,
> -					    __u32 linecard_index)
> -{
> -	req->_present.linecard_index = 1;
> -	req->linecard_index = linecard_index;
> -}
> -static inline void
> -devlink_linecard_set_req_set_linecard_type(struct devlink_linecard_set_req *req,
> -					   const char *linecard_type)
> -{
> -	free(req->linecard_type);
> -	req->_present.linecard_type_len = strlen(linecard_type);
> -	req->linecard_type = malloc(req->_present.linecard_type_len + 1);
> -	memcpy(req->linecard_type, linecard_type, req->_present.linecard_type_len);
> -	req->linecard_type[req->_present.linecard_type_len] = 0;
> -}
> -
> -/*
> - * Set line card instances.
> - */
> -int devlink_linecard_set(struct ynl_sock *ys,
> -			 struct devlink_linecard_set_req *req);
> -
> -/* ============== DEVLINK_CMD_SELFTESTS_GET ============== */
> -/* DEVLINK_CMD_SELFTESTS_GET - do */
> -struct devlink_selftests_get_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -};
> -
> -static inline struct devlink_selftests_get_req *
> -devlink_selftests_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_selftests_get_req));
> -}
> -void devlink_selftests_get_req_free(struct devlink_selftests_get_req *req);
> -
> -static inline void
> -devlink_selftests_get_req_set_bus_name(struct devlink_selftests_get_req *req,
> -				       const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_selftests_get_req_set_dev_name(struct devlink_selftests_get_req *req,
> -				       const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -
> -struct devlink_selftests_get_rsp {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -};
> -
> -void devlink_selftests_get_rsp_free(struct devlink_selftests_get_rsp *rsp);
> -
> -/*
> - * Get device selftest instances.
> - */
> -struct devlink_selftests_get_rsp *
> -devlink_selftests_get(struct ynl_sock *ys,
> -		      struct devlink_selftests_get_req *req);
> -
> -/* DEVLINK_CMD_SELFTESTS_GET - dump */
> -struct devlink_selftests_get_list {
> -	struct devlink_selftests_get_list *next;
> -	struct devlink_selftests_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void devlink_selftests_get_list_free(struct devlink_selftests_get_list *rsp);
> -
> -struct devlink_selftests_get_list *
> -devlink_selftests_get_dump(struct ynl_sock *ys);
> -
> -/* ============== DEVLINK_CMD_SELFTESTS_RUN ============== */
> -/* DEVLINK_CMD_SELFTESTS_RUN - do */
> -struct devlink_selftests_run_req {
> -	struct {
> -		__u32 bus_name_len;
> -		__u32 dev_name_len;
> -		__u32 selftests:1;
> -	} _present;
> -
> -	char *bus_name;
> -	char *dev_name;
> -	struct devlink_dl_selftest_id selftests;
> -};
> -
> -static inline struct devlink_selftests_run_req *
> -devlink_selftests_run_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct devlink_selftests_run_req));
> -}
> -void devlink_selftests_run_req_free(struct devlink_selftests_run_req *req);
> -
> -static inline void
> -devlink_selftests_run_req_set_bus_name(struct devlink_selftests_run_req *req,
> -				       const char *bus_name)
> -{
> -	free(req->bus_name);
> -	req->_present.bus_name_len = strlen(bus_name);
> -	req->bus_name = malloc(req->_present.bus_name_len + 1);
> -	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> -	req->bus_name[req->_present.bus_name_len] = 0;
> -}
> -static inline void
> -devlink_selftests_run_req_set_dev_name(struct devlink_selftests_run_req *req,
> -				       const char *dev_name)
> -{
> -	free(req->dev_name);
> -	req->_present.dev_name_len = strlen(dev_name);
> -	req->dev_name = malloc(req->_present.dev_name_len + 1);
> -	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> -	req->dev_name[req->_present.dev_name_len] = 0;
> -}
> -static inline void
> -devlink_selftests_run_req_set_selftests_flash(struct devlink_selftests_run_req *req)
> -{
> -	req->_present.selftests = 1;
> -	req->selftests._present.flash = 1;
> -}
> -
> -/*
> - * Run device selftest instances.
> - */
> -int devlink_selftests_run(struct ynl_sock *ys,
> -			  struct devlink_selftests_run_req *req);
> -
> -#endif /* _LINUX_DEVLINK_GEN_H */
> diff --git a/tools/net/ynl/generated/ethtool-user.c b/tools/net/ynl/generated/ethtool-user.c
> deleted file mode 100644
> index 660435639e2b..000000000000
> --- a/tools/net/ynl/generated/ethtool-user.c
> +++ /dev/null
> @@ -1,6370 +0,0 @@
> -// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> -/* Do not edit directly, auto-generated from: */
> -/*	Documentation/netlink/specs/ethtool.yaml */
> -/* YNL-GEN user source */
> -/* YNL-ARG --user-header linux/ethtool_netlink.h --exclude-op stats-get */
> -
> -#include <stdlib.h>
> -#include <string.h>
> -#include "ethtool-user.h"
> -#include "ynl.h"
> -#include <linux/ethtool.h>
> -
> -#include <libmnl/libmnl.h>
> -#include <linux/genetlink.h>
> -
> -#include "linux/ethtool_netlink.h"
> -
> -/* Enums */
> -static const char * const ethtool_op_strmap[] = {
> -	[ETHTOOL_MSG_STRSET_GET] = "strset-get",
> -	[ETHTOOL_MSG_LINKINFO_GET] = "linkinfo-get",
> -	[3] = "linkinfo-ntf",
> -	[ETHTOOL_MSG_LINKMODES_GET] = "linkmodes-get",
> -	[5] = "linkmodes-ntf",
> -	[ETHTOOL_MSG_LINKSTATE_GET] = "linkstate-get",
> -	[ETHTOOL_MSG_DEBUG_GET] = "debug-get",
> -	[8] = "debug-ntf",
> -	[ETHTOOL_MSG_WOL_GET] = "wol-get",
> -	[10] = "wol-ntf",
> -	[ETHTOOL_MSG_FEATURES_GET] = "features-get",
> -	[ETHTOOL_MSG_FEATURES_SET] = "features-set",
> -	[13] = "features-ntf",
> -	[14] = "privflags-get",
> -	[15] = "privflags-ntf",
> -	[16] = "rings-get",
> -	[17] = "rings-ntf",
> -	[18] = "channels-get",
> -	[19] = "channels-ntf",
> -	[20] = "coalesce-get",
> -	[21] = "coalesce-ntf",
> -	[22] = "pause-get",
> -	[23] = "pause-ntf",
> -	[24] = "eee-get",
> -	[25] = "eee-ntf",
> -	[26] = "tsinfo-get",
> -	[27] = "cable-test-ntf",
> -	[28] = "cable-test-tdr-ntf",
> -	[29] = "tunnel-info-get",
> -	[30] = "fec-get",
> -	[31] = "fec-ntf",
> -	[32] = "module-eeprom-get",
> -	[34] = "phc-vclocks-get",
> -	[35] = "module-get",
> -	[36] = "module-ntf",
> -	[37] = "pse-get",
> -	[ETHTOOL_MSG_RSS_GET] = "rss-get",
> -	[ETHTOOL_MSG_PLCA_GET_CFG] = "plca-get-cfg",
> -	[40] = "plca-get-status",
> -	[41] = "plca-ntf",
> -	[ETHTOOL_MSG_MM_GET] = "mm-get",
> -	[43] = "mm-ntf",
> -};
> -
> -const char *ethtool_op_str(int op)
> -{
> -	if (op < 0 || op >= (int)MNL_ARRAY_SIZE(ethtool_op_strmap))
> -		return NULL;
> -	return ethtool_op_strmap[op];
> -}
> -
> -static const char * const ethtool_udp_tunnel_type_strmap[] = {
> -	[0] = "vxlan",
> -	[1] = "geneve",
> -	[2] = "vxlan-gpe",
> -};
> -
> -const char *ethtool_udp_tunnel_type_str(int value)
> -{
> -	if (value < 0 || value >= (int)MNL_ARRAY_SIZE(ethtool_udp_tunnel_type_strmap))
> -		return NULL;
> -	return ethtool_udp_tunnel_type_strmap[value];
> -}
> -
> -static const char * const ethtool_stringset_strmap[] = {
> -};
> -
> -const char *ethtool_stringset_str(enum ethtool_stringset value)
> -{
> -	if (value < 0 || value >= (int)MNL_ARRAY_SIZE(ethtool_stringset_strmap))
> -		return NULL;
> -	return ethtool_stringset_strmap[value];
> -}
> -
> -/* Policies */
> -struct ynl_policy_attr ethtool_header_policy[ETHTOOL_A_HEADER_MAX + 1] = {
> -	[ETHTOOL_A_HEADER_DEV_INDEX] = { .name = "dev-index", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_HEADER_DEV_NAME] = { .name = "dev-name", .type = YNL_PT_NUL_STR, },
> -	[ETHTOOL_A_HEADER_FLAGS] = { .name = "flags", .type = YNL_PT_U32, },
> -};
> -
> -struct ynl_policy_nest ethtool_header_nest = {
> -	.max_attr = ETHTOOL_A_HEADER_MAX,
> -	.table = ethtool_header_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_pause_stat_policy[ETHTOOL_A_PAUSE_STAT_MAX + 1] = {
> -	[ETHTOOL_A_PAUSE_STAT_PAD] = { .name = "pad", .type = YNL_PT_IGNORE, },
> -	[ETHTOOL_A_PAUSE_STAT_TX_FRAMES] = { .name = "tx-frames", .type = YNL_PT_U64, },
> -	[ETHTOOL_A_PAUSE_STAT_RX_FRAMES] = { .name = "rx-frames", .type = YNL_PT_U64, },
> -};
> -
> -struct ynl_policy_nest ethtool_pause_stat_nest = {
> -	.max_attr = ETHTOOL_A_PAUSE_STAT_MAX,
> -	.table = ethtool_pause_stat_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_cable_test_tdr_cfg_policy[ETHTOOL_A_CABLE_TEST_TDR_CFG_MAX + 1] = {
> -	[ETHTOOL_A_CABLE_TEST_TDR_CFG_FIRST] = { .name = "first", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_CABLE_TEST_TDR_CFG_LAST] = { .name = "last", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_CABLE_TEST_TDR_CFG_STEP] = { .name = "step", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_CABLE_TEST_TDR_CFG_PAIR] = { .name = "pair", .type = YNL_PT_U8, },
> -};
> -
> -struct ynl_policy_nest ethtool_cable_test_tdr_cfg_nest = {
> -	.max_attr = ETHTOOL_A_CABLE_TEST_TDR_CFG_MAX,
> -	.table = ethtool_cable_test_tdr_cfg_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_fec_stat_policy[ETHTOOL_A_FEC_STAT_MAX + 1] = {
> -	[ETHTOOL_A_FEC_STAT_PAD] = { .name = "pad", .type = YNL_PT_IGNORE, },
> -	[ETHTOOL_A_FEC_STAT_CORRECTED] = { .name = "corrected", .type = YNL_PT_BINARY,},
> -	[ETHTOOL_A_FEC_STAT_UNCORR] = { .name = "uncorr", .type = YNL_PT_BINARY,},
> -	[ETHTOOL_A_FEC_STAT_CORR_BITS] = { .name = "corr-bits", .type = YNL_PT_BINARY,},
> -};
> -
> -struct ynl_policy_nest ethtool_fec_stat_nest = {
> -	.max_attr = ETHTOOL_A_FEC_STAT_MAX,
> -	.table = ethtool_fec_stat_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_mm_stat_policy[ETHTOOL_A_MM_STAT_MAX + 1] = {
> -	[ETHTOOL_A_MM_STAT_PAD] = { .name = "pad", .type = YNL_PT_IGNORE, },
> -	[ETHTOOL_A_MM_STAT_REASSEMBLY_ERRORS] = { .name = "reassembly-errors", .type = YNL_PT_U64, },
> -	[ETHTOOL_A_MM_STAT_SMD_ERRORS] = { .name = "smd-errors", .type = YNL_PT_U64, },
> -	[ETHTOOL_A_MM_STAT_REASSEMBLY_OK] = { .name = "reassembly-ok", .type = YNL_PT_U64, },
> -	[ETHTOOL_A_MM_STAT_RX_FRAG_COUNT] = { .name = "rx-frag-count", .type = YNL_PT_U64, },
> -	[ETHTOOL_A_MM_STAT_TX_FRAG_COUNT] = { .name = "tx-frag-count", .type = YNL_PT_U64, },
> -	[ETHTOOL_A_MM_STAT_HOLD_COUNT] = { .name = "hold-count", .type = YNL_PT_U64, },
> -};
> -
> -struct ynl_policy_nest ethtool_mm_stat_nest = {
> -	.max_attr = ETHTOOL_A_MM_STAT_MAX,
> -	.table = ethtool_mm_stat_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_cable_result_policy[ETHTOOL_A_CABLE_RESULT_MAX + 1] = {
> -	[ETHTOOL_A_CABLE_RESULT_PAIR] = { .name = "pair", .type = YNL_PT_U8, },
> -	[ETHTOOL_A_CABLE_RESULT_CODE] = { .name = "code", .type = YNL_PT_U8, },
> -};
> -
> -struct ynl_policy_nest ethtool_cable_result_nest = {
> -	.max_attr = ETHTOOL_A_CABLE_RESULT_MAX,
> -	.table = ethtool_cable_result_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_cable_fault_length_policy[ETHTOOL_A_CABLE_FAULT_LENGTH_MAX + 1] = {
> -	[ETHTOOL_A_CABLE_FAULT_LENGTH_PAIR] = { .name = "pair", .type = YNL_PT_U8, },
> -	[ETHTOOL_A_CABLE_FAULT_LENGTH_CM] = { .name = "cm", .type = YNL_PT_U32, },
> -};
> -
> -struct ynl_policy_nest ethtool_cable_fault_length_nest = {
> -	.max_attr = ETHTOOL_A_CABLE_FAULT_LENGTH_MAX,
> -	.table = ethtool_cable_fault_length_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_bitset_bit_policy[ETHTOOL_A_BITSET_BIT_MAX + 1] = {
> -	[ETHTOOL_A_BITSET_BIT_INDEX] = { .name = "index", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_BITSET_BIT_NAME] = { .name = "name", .type = YNL_PT_NUL_STR, },
> -	[ETHTOOL_A_BITSET_BIT_VALUE] = { .name = "value", .type = YNL_PT_FLAG, },
> -};
> -
> -struct ynl_policy_nest ethtool_bitset_bit_nest = {
> -	.max_attr = ETHTOOL_A_BITSET_BIT_MAX,
> -	.table = ethtool_bitset_bit_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_tunnel_udp_entry_policy[ETHTOOL_A_TUNNEL_UDP_ENTRY_MAX + 1] = {
> -	[ETHTOOL_A_TUNNEL_UDP_ENTRY_PORT] = { .name = "port", .type = YNL_PT_U16, },
> -	[ETHTOOL_A_TUNNEL_UDP_ENTRY_TYPE] = { .name = "type", .type = YNL_PT_U32, },
> -};
> -
> -struct ynl_policy_nest ethtool_tunnel_udp_entry_nest = {
> -	.max_attr = ETHTOOL_A_TUNNEL_UDP_ENTRY_MAX,
> -	.table = ethtool_tunnel_udp_entry_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_string_policy[ETHTOOL_A_STRING_MAX + 1] = {
> -	[ETHTOOL_A_STRING_INDEX] = { .name = "index", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_STRING_VALUE] = { .name = "value", .type = YNL_PT_NUL_STR, },
> -};
> -
> -struct ynl_policy_nest ethtool_string_nest = {
> -	.max_attr = ETHTOOL_A_STRING_MAX,
> -	.table = ethtool_string_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_cable_nest_policy[ETHTOOL_A_CABLE_NEST_MAX + 1] = {
> -	[ETHTOOL_A_CABLE_NEST_RESULT] = { .name = "result", .type = YNL_PT_NEST, .nest = &ethtool_cable_result_nest, },
> -	[ETHTOOL_A_CABLE_NEST_FAULT_LENGTH] = { .name = "fault-length", .type = YNL_PT_NEST, .nest = &ethtool_cable_fault_length_nest, },
> -};
> -
> -struct ynl_policy_nest ethtool_cable_nest_nest = {
> -	.max_attr = ETHTOOL_A_CABLE_NEST_MAX,
> -	.table = ethtool_cable_nest_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_bitset_bits_policy[ETHTOOL_A_BITSET_BITS_MAX + 1] = {
> -	[ETHTOOL_A_BITSET_BITS_BIT] = { .name = "bit", .type = YNL_PT_NEST, .nest = &ethtool_bitset_bit_nest, },
> -};
> -
> -struct ynl_policy_nest ethtool_bitset_bits_nest = {
> -	.max_attr = ETHTOOL_A_BITSET_BITS_MAX,
> -	.table = ethtool_bitset_bits_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_strings_policy[ETHTOOL_A_STRINGS_MAX + 1] = {
> -	[ETHTOOL_A_STRINGS_STRING] = { .name = "string", .type = YNL_PT_NEST, .nest = &ethtool_string_nest, },
> -};
> -
> -struct ynl_policy_nest ethtool_strings_nest = {
> -	.max_attr = ETHTOOL_A_STRINGS_MAX,
> -	.table = ethtool_strings_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_bitset_policy[ETHTOOL_A_BITSET_MAX + 1] = {
> -	[ETHTOOL_A_BITSET_NOMASK] = { .name = "nomask", .type = YNL_PT_FLAG, },
> -	[ETHTOOL_A_BITSET_SIZE] = { .name = "size", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_BITSET_BITS] = { .name = "bits", .type = YNL_PT_NEST, .nest = &ethtool_bitset_bits_nest, },
> -};
> -
> -struct ynl_policy_nest ethtool_bitset_nest = {
> -	.max_attr = ETHTOOL_A_BITSET_MAX,
> -	.table = ethtool_bitset_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_stringset_policy[ETHTOOL_A_STRINGSET_MAX + 1] = {
> -	[ETHTOOL_A_STRINGSET_ID] = { .name = "id", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_STRINGSET_COUNT] = { .name = "count", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_STRINGSET_STRINGS] = { .name = "strings", .type = YNL_PT_NEST, .nest = &ethtool_strings_nest, },
> -};
> -
> -struct ynl_policy_nest ethtool_stringset_nest = {
> -	.max_attr = ETHTOOL_A_STRINGSET_MAX,
> -	.table = ethtool_stringset_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_tunnel_udp_table_policy[ETHTOOL_A_TUNNEL_UDP_TABLE_MAX + 1] = {
> -	[ETHTOOL_A_TUNNEL_UDP_TABLE_SIZE] = { .name = "size", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_TUNNEL_UDP_TABLE_TYPES] = { .name = "types", .type = YNL_PT_NEST, .nest = &ethtool_bitset_nest, },
> -	[ETHTOOL_A_TUNNEL_UDP_TABLE_ENTRY] = { .name = "entry", .type = YNL_PT_NEST, .nest = &ethtool_tunnel_udp_entry_nest, },
> -};
> -
> -struct ynl_policy_nest ethtool_tunnel_udp_table_nest = {
> -	.max_attr = ETHTOOL_A_TUNNEL_UDP_TABLE_MAX,
> -	.table = ethtool_tunnel_udp_table_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_stringsets_policy[ETHTOOL_A_STRINGSETS_MAX + 1] = {
> -	[ETHTOOL_A_STRINGSETS_STRINGSET] = { .name = "stringset", .type = YNL_PT_NEST, .nest = &ethtool_stringset_nest, },
> -};
> -
> -struct ynl_policy_nest ethtool_stringsets_nest = {
> -	.max_attr = ETHTOOL_A_STRINGSETS_MAX,
> -	.table = ethtool_stringsets_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_tunnel_udp_policy[ETHTOOL_A_TUNNEL_UDP_MAX + 1] = {
> -	[ETHTOOL_A_TUNNEL_UDP_TABLE] = { .name = "table", .type = YNL_PT_NEST, .nest = &ethtool_tunnel_udp_table_nest, },
> -};
> -
> -struct ynl_policy_nest ethtool_tunnel_udp_nest = {
> -	.max_attr = ETHTOOL_A_TUNNEL_UDP_MAX,
> -	.table = ethtool_tunnel_udp_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_strset_policy[ETHTOOL_A_STRSET_MAX + 1] = {
> -	[ETHTOOL_A_STRSET_HEADER] = { .name = "header", .type = YNL_PT_NEST, .nest = &ethtool_header_nest, },
> -	[ETHTOOL_A_STRSET_STRINGSETS] = { .name = "stringsets", .type = YNL_PT_NEST, .nest = &ethtool_stringsets_nest, },
> -	[ETHTOOL_A_STRSET_COUNTS_ONLY] = { .name = "counts-only", .type = YNL_PT_FLAG, },
> -};
> -
> -struct ynl_policy_nest ethtool_strset_nest = {
> -	.max_attr = ETHTOOL_A_STRSET_MAX,
> -	.table = ethtool_strset_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_linkinfo_policy[ETHTOOL_A_LINKINFO_MAX + 1] = {
> -	[ETHTOOL_A_LINKINFO_HEADER] = { .name = "header", .type = YNL_PT_NEST, .nest = &ethtool_header_nest, },
> -	[ETHTOOL_A_LINKINFO_PORT] = { .name = "port", .type = YNL_PT_U8, },
> -	[ETHTOOL_A_LINKINFO_PHYADDR] = { .name = "phyaddr", .type = YNL_PT_U8, },
> -	[ETHTOOL_A_LINKINFO_TP_MDIX] = { .name = "tp-mdix", .type = YNL_PT_U8, },
> -	[ETHTOOL_A_LINKINFO_TP_MDIX_CTRL] = { .name = "tp-mdix-ctrl", .type = YNL_PT_U8, },
> -	[ETHTOOL_A_LINKINFO_TRANSCEIVER] = { .name = "transceiver", .type = YNL_PT_U8, },
> -};
> -
> -struct ynl_policy_nest ethtool_linkinfo_nest = {
> -	.max_attr = ETHTOOL_A_LINKINFO_MAX,
> -	.table = ethtool_linkinfo_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_linkmodes_policy[ETHTOOL_A_LINKMODES_MAX + 1] = {
> -	[ETHTOOL_A_LINKMODES_HEADER] = { .name = "header", .type = YNL_PT_NEST, .nest = &ethtool_header_nest, },
> -	[ETHTOOL_A_LINKMODES_AUTONEG] = { .name = "autoneg", .type = YNL_PT_U8, },
> -	[ETHTOOL_A_LINKMODES_OURS] = { .name = "ours", .type = YNL_PT_NEST, .nest = &ethtool_bitset_nest, },
> -	[ETHTOOL_A_LINKMODES_PEER] = { .name = "peer", .type = YNL_PT_NEST, .nest = &ethtool_bitset_nest, },
> -	[ETHTOOL_A_LINKMODES_SPEED] = { .name = "speed", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_LINKMODES_DUPLEX] = { .name = "duplex", .type = YNL_PT_U8, },
> -	[ETHTOOL_A_LINKMODES_MASTER_SLAVE_CFG] = { .name = "master-slave-cfg", .type = YNL_PT_U8, },
> -	[ETHTOOL_A_LINKMODES_MASTER_SLAVE_STATE] = { .name = "master-slave-state", .type = YNL_PT_U8, },
> -	[ETHTOOL_A_LINKMODES_LANES] = { .name = "lanes", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_LINKMODES_RATE_MATCHING] = { .name = "rate-matching", .type = YNL_PT_U8, },
> -};
> -
> -struct ynl_policy_nest ethtool_linkmodes_nest = {
> -	.max_attr = ETHTOOL_A_LINKMODES_MAX,
> -	.table = ethtool_linkmodes_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_linkstate_policy[ETHTOOL_A_LINKSTATE_MAX + 1] = {
> -	[ETHTOOL_A_LINKSTATE_HEADER] = { .name = "header", .type = YNL_PT_NEST, .nest = &ethtool_header_nest, },
> -	[ETHTOOL_A_LINKSTATE_LINK] = { .name = "link", .type = YNL_PT_U8, },
> -	[ETHTOOL_A_LINKSTATE_SQI] = { .name = "sqi", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_LINKSTATE_SQI_MAX] = { .name = "sqi-max", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_LINKSTATE_EXT_STATE] = { .name = "ext-state", .type = YNL_PT_U8, },
> -	[ETHTOOL_A_LINKSTATE_EXT_SUBSTATE] = { .name = "ext-substate", .type = YNL_PT_U8, },
> -	[ETHTOOL_A_LINKSTATE_EXT_DOWN_CNT] = { .name = "ext-down-cnt", .type = YNL_PT_U32, },
> -};
> -
> -struct ynl_policy_nest ethtool_linkstate_nest = {
> -	.max_attr = ETHTOOL_A_LINKSTATE_MAX,
> -	.table = ethtool_linkstate_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_debug_policy[ETHTOOL_A_DEBUG_MAX + 1] = {
> -	[ETHTOOL_A_DEBUG_HEADER] = { .name = "header", .type = YNL_PT_NEST, .nest = &ethtool_header_nest, },
> -	[ETHTOOL_A_DEBUG_MSGMASK] = { .name = "msgmask", .type = YNL_PT_NEST, .nest = &ethtool_bitset_nest, },
> -};
> -
> -struct ynl_policy_nest ethtool_debug_nest = {
> -	.max_attr = ETHTOOL_A_DEBUG_MAX,
> -	.table = ethtool_debug_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_wol_policy[ETHTOOL_A_WOL_MAX + 1] = {
> -	[ETHTOOL_A_WOL_HEADER] = { .name = "header", .type = YNL_PT_NEST, .nest = &ethtool_header_nest, },
> -	[ETHTOOL_A_WOL_MODES] = { .name = "modes", .type = YNL_PT_NEST, .nest = &ethtool_bitset_nest, },
> -	[ETHTOOL_A_WOL_SOPASS] = { .name = "sopass", .type = YNL_PT_BINARY,},
> -};
> -
> -struct ynl_policy_nest ethtool_wol_nest = {
> -	.max_attr = ETHTOOL_A_WOL_MAX,
> -	.table = ethtool_wol_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_features_policy[ETHTOOL_A_FEATURES_MAX + 1] = {
> -	[ETHTOOL_A_FEATURES_HEADER] = { .name = "header", .type = YNL_PT_NEST, .nest = &ethtool_header_nest, },
> -	[ETHTOOL_A_FEATURES_HW] = { .name = "hw", .type = YNL_PT_NEST, .nest = &ethtool_bitset_nest, },
> -	[ETHTOOL_A_FEATURES_WANTED] = { .name = "wanted", .type = YNL_PT_NEST, .nest = &ethtool_bitset_nest, },
> -	[ETHTOOL_A_FEATURES_ACTIVE] = { .name = "active", .type = YNL_PT_NEST, .nest = &ethtool_bitset_nest, },
> -	[ETHTOOL_A_FEATURES_NOCHANGE] = { .name = "nochange", .type = YNL_PT_NEST, .nest = &ethtool_bitset_nest, },
> -};
> -
> -struct ynl_policy_nest ethtool_features_nest = {
> -	.max_attr = ETHTOOL_A_FEATURES_MAX,
> -	.table = ethtool_features_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_privflags_policy[ETHTOOL_A_PRIVFLAGS_MAX + 1] = {
> -	[ETHTOOL_A_PRIVFLAGS_HEADER] = { .name = "header", .type = YNL_PT_NEST, .nest = &ethtool_header_nest, },
> -	[ETHTOOL_A_PRIVFLAGS_FLAGS] = { .name = "flags", .type = YNL_PT_NEST, .nest = &ethtool_bitset_nest, },
> -};
> -
> -struct ynl_policy_nest ethtool_privflags_nest = {
> -	.max_attr = ETHTOOL_A_PRIVFLAGS_MAX,
> -	.table = ethtool_privflags_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_rings_policy[ETHTOOL_A_RINGS_MAX + 1] = {
> -	[ETHTOOL_A_RINGS_HEADER] = { .name = "header", .type = YNL_PT_NEST, .nest = &ethtool_header_nest, },
> -	[ETHTOOL_A_RINGS_RX_MAX] = { .name = "rx-max", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_RINGS_RX_MINI_MAX] = { .name = "rx-mini-max", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_RINGS_RX_JUMBO_MAX] = { .name = "rx-jumbo-max", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_RINGS_TX_MAX] = { .name = "tx-max", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_RINGS_RX] = { .name = "rx", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_RINGS_RX_MINI] = { .name = "rx-mini", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_RINGS_RX_JUMBO] = { .name = "rx-jumbo", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_RINGS_TX] = { .name = "tx", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_RINGS_RX_BUF_LEN] = { .name = "rx-buf-len", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_RINGS_TCP_DATA_SPLIT] = { .name = "tcp-data-split", .type = YNL_PT_U8, },
> -	[ETHTOOL_A_RINGS_CQE_SIZE] = { .name = "cqe-size", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_RINGS_TX_PUSH] = { .name = "tx-push", .type = YNL_PT_U8, },
> -	[ETHTOOL_A_RINGS_RX_PUSH] = { .name = "rx-push", .type = YNL_PT_U8, },
> -	[ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN] = { .name = "tx-push-buf-len", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX] = { .name = "tx-push-buf-len-max", .type = YNL_PT_U32, },
> -};
> -
> -struct ynl_policy_nest ethtool_rings_nest = {
> -	.max_attr = ETHTOOL_A_RINGS_MAX,
> -	.table = ethtool_rings_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_channels_policy[ETHTOOL_A_CHANNELS_MAX + 1] = {
> -	[ETHTOOL_A_CHANNELS_HEADER] = { .name = "header", .type = YNL_PT_NEST, .nest = &ethtool_header_nest, },
> -	[ETHTOOL_A_CHANNELS_RX_MAX] = { .name = "rx-max", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_CHANNELS_TX_MAX] = { .name = "tx-max", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_CHANNELS_OTHER_MAX] = { .name = "other-max", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_CHANNELS_COMBINED_MAX] = { .name = "combined-max", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_CHANNELS_RX_COUNT] = { .name = "rx-count", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_CHANNELS_TX_COUNT] = { .name = "tx-count", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_CHANNELS_OTHER_COUNT] = { .name = "other-count", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_CHANNELS_COMBINED_COUNT] = { .name = "combined-count", .type = YNL_PT_U32, },
> -};
> -
> -struct ynl_policy_nest ethtool_channels_nest = {
> -	.max_attr = ETHTOOL_A_CHANNELS_MAX,
> -	.table = ethtool_channels_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_coalesce_policy[ETHTOOL_A_COALESCE_MAX + 1] = {
> -	[ETHTOOL_A_COALESCE_HEADER] = { .name = "header", .type = YNL_PT_NEST, .nest = &ethtool_header_nest, },
> -	[ETHTOOL_A_COALESCE_RX_USECS] = { .name = "rx-usecs", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_COALESCE_RX_MAX_FRAMES] = { .name = "rx-max-frames", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_COALESCE_RX_USECS_IRQ] = { .name = "rx-usecs-irq", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_COALESCE_RX_MAX_FRAMES_IRQ] = { .name = "rx-max-frames-irq", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_COALESCE_TX_USECS] = { .name = "tx-usecs", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_COALESCE_TX_MAX_FRAMES] = { .name = "tx-max-frames", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_COALESCE_TX_USECS_IRQ] = { .name = "tx-usecs-irq", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_COALESCE_TX_MAX_FRAMES_IRQ] = { .name = "tx-max-frames-irq", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_COALESCE_STATS_BLOCK_USECS] = { .name = "stats-block-usecs", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_COALESCE_USE_ADAPTIVE_RX] = { .name = "use-adaptive-rx", .type = YNL_PT_U8, },
> -	[ETHTOOL_A_COALESCE_USE_ADAPTIVE_TX] = { .name = "use-adaptive-tx", .type = YNL_PT_U8, },
> -	[ETHTOOL_A_COALESCE_PKT_RATE_LOW] = { .name = "pkt-rate-low", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_COALESCE_RX_USECS_LOW] = { .name = "rx-usecs-low", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_COALESCE_RX_MAX_FRAMES_LOW] = { .name = "rx-max-frames-low", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_COALESCE_TX_USECS_LOW] = { .name = "tx-usecs-low", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_COALESCE_TX_MAX_FRAMES_LOW] = { .name = "tx-max-frames-low", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_COALESCE_PKT_RATE_HIGH] = { .name = "pkt-rate-high", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_COALESCE_RX_USECS_HIGH] = { .name = "rx-usecs-high", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_COALESCE_RX_MAX_FRAMES_HIGH] = { .name = "rx-max-frames-high", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_COALESCE_TX_USECS_HIGH] = { .name = "tx-usecs-high", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_COALESCE_TX_MAX_FRAMES_HIGH] = { .name = "tx-max-frames-high", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_COALESCE_RATE_SAMPLE_INTERVAL] = { .name = "rate-sample-interval", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_COALESCE_USE_CQE_MODE_TX] = { .name = "use-cqe-mode-tx", .type = YNL_PT_U8, },
> -	[ETHTOOL_A_COALESCE_USE_CQE_MODE_RX] = { .name = "use-cqe-mode-rx", .type = YNL_PT_U8, },
> -	[ETHTOOL_A_COALESCE_TX_AGGR_MAX_BYTES] = { .name = "tx-aggr-max-bytes", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES] = { .name = "tx-aggr-max-frames", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS] = { .name = "tx-aggr-time-usecs", .type = YNL_PT_U32, },
> -};
> -
> -struct ynl_policy_nest ethtool_coalesce_nest = {
> -	.max_attr = ETHTOOL_A_COALESCE_MAX,
> -	.table = ethtool_coalesce_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_pause_policy[ETHTOOL_A_PAUSE_MAX + 1] = {
> -	[ETHTOOL_A_PAUSE_HEADER] = { .name = "header", .type = YNL_PT_NEST, .nest = &ethtool_header_nest, },
> -	[ETHTOOL_A_PAUSE_AUTONEG] = { .name = "autoneg", .type = YNL_PT_U8, },
> -	[ETHTOOL_A_PAUSE_RX] = { .name = "rx", .type = YNL_PT_U8, },
> -	[ETHTOOL_A_PAUSE_TX] = { .name = "tx", .type = YNL_PT_U8, },
> -	[ETHTOOL_A_PAUSE_STATS] = { .name = "stats", .type = YNL_PT_NEST, .nest = &ethtool_pause_stat_nest, },
> -	[ETHTOOL_A_PAUSE_STATS_SRC] = { .name = "stats-src", .type = YNL_PT_U32, },
> -};
> -
> -struct ynl_policy_nest ethtool_pause_nest = {
> -	.max_attr = ETHTOOL_A_PAUSE_MAX,
> -	.table = ethtool_pause_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_eee_policy[ETHTOOL_A_EEE_MAX + 1] = {
> -	[ETHTOOL_A_EEE_HEADER] = { .name = "header", .type = YNL_PT_NEST, .nest = &ethtool_header_nest, },
> -	[ETHTOOL_A_EEE_MODES_OURS] = { .name = "modes-ours", .type = YNL_PT_NEST, .nest = &ethtool_bitset_nest, },
> -	[ETHTOOL_A_EEE_MODES_PEER] = { .name = "modes-peer", .type = YNL_PT_NEST, .nest = &ethtool_bitset_nest, },
> -	[ETHTOOL_A_EEE_ACTIVE] = { .name = "active", .type = YNL_PT_U8, },
> -	[ETHTOOL_A_EEE_ENABLED] = { .name = "enabled", .type = YNL_PT_U8, },
> -	[ETHTOOL_A_EEE_TX_LPI_ENABLED] = { .name = "tx-lpi-enabled", .type = YNL_PT_U8, },
> -	[ETHTOOL_A_EEE_TX_LPI_TIMER] = { .name = "tx-lpi-timer", .type = YNL_PT_U32, },
> -};
> -
> -struct ynl_policy_nest ethtool_eee_nest = {
> -	.max_attr = ETHTOOL_A_EEE_MAX,
> -	.table = ethtool_eee_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_tsinfo_policy[ETHTOOL_A_TSINFO_MAX + 1] = {
> -	[ETHTOOL_A_TSINFO_HEADER] = { .name = "header", .type = YNL_PT_NEST, .nest = &ethtool_header_nest, },
> -	[ETHTOOL_A_TSINFO_TIMESTAMPING] = { .name = "timestamping", .type = YNL_PT_NEST, .nest = &ethtool_bitset_nest, },
> -	[ETHTOOL_A_TSINFO_TX_TYPES] = { .name = "tx-types", .type = YNL_PT_NEST, .nest = &ethtool_bitset_nest, },
> -	[ETHTOOL_A_TSINFO_RX_FILTERS] = { .name = "rx-filters", .type = YNL_PT_NEST, .nest = &ethtool_bitset_nest, },
> -	[ETHTOOL_A_TSINFO_PHC_INDEX] = { .name = "phc-index", .type = YNL_PT_U32, },
> -};
> -
> -struct ynl_policy_nest ethtool_tsinfo_nest = {
> -	.max_attr = ETHTOOL_A_TSINFO_MAX,
> -	.table = ethtool_tsinfo_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_cable_test_policy[ETHTOOL_A_CABLE_TEST_MAX + 1] = {
> -	[ETHTOOL_A_CABLE_TEST_HEADER] = { .name = "header", .type = YNL_PT_NEST, .nest = &ethtool_header_nest, },
> -};
> -
> -struct ynl_policy_nest ethtool_cable_test_nest = {
> -	.max_attr = ETHTOOL_A_CABLE_TEST_MAX,
> -	.table = ethtool_cable_test_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_cable_test_ntf_policy[ETHTOOL_A_CABLE_TEST_NTF_MAX + 1] = {
> -	[ETHTOOL_A_CABLE_TEST_NTF_HEADER] = { .name = "header", .type = YNL_PT_NEST, .nest = &ethtool_header_nest, },
> -	[ETHTOOL_A_CABLE_TEST_NTF_STATUS] = { .name = "status", .type = YNL_PT_U8, },
> -	[ETHTOOL_A_CABLE_TEST_NTF_NEST] = { .name = "nest", .type = YNL_PT_NEST, .nest = &ethtool_cable_nest_nest, },
> -};
> -
> -struct ynl_policy_nest ethtool_cable_test_ntf_nest = {
> -	.max_attr = ETHTOOL_A_CABLE_TEST_NTF_MAX,
> -	.table = ethtool_cable_test_ntf_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_cable_test_tdr_policy[ETHTOOL_A_CABLE_TEST_TDR_MAX + 1] = {
> -	[ETHTOOL_A_CABLE_TEST_TDR_HEADER] = { .name = "header", .type = YNL_PT_NEST, .nest = &ethtool_header_nest, },
> -	[ETHTOOL_A_CABLE_TEST_TDR_CFG] = { .name = "cfg", .type = YNL_PT_NEST, .nest = &ethtool_cable_test_tdr_cfg_nest, },
> -};
> -
> -struct ynl_policy_nest ethtool_cable_test_tdr_nest = {
> -	.max_attr = ETHTOOL_A_CABLE_TEST_TDR_MAX,
> -	.table = ethtool_cable_test_tdr_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_cable_test_tdr_ntf_policy[ETHTOOL_A_CABLE_TEST_TDR_NTF_MAX + 1] = {
> -	[ETHTOOL_A_CABLE_TEST_TDR_NTF_HEADER] = { .name = "header", .type = YNL_PT_NEST, .nest = &ethtool_header_nest, },
> -	[ETHTOOL_A_CABLE_TEST_TDR_NTF_STATUS] = { .name = "status", .type = YNL_PT_U8, },
> -	[ETHTOOL_A_CABLE_TEST_TDR_NTF_NEST] = { .name = "nest", .type = YNL_PT_NEST, .nest = &ethtool_cable_nest_nest, },
> -};
> -
> -struct ynl_policy_nest ethtool_cable_test_tdr_ntf_nest = {
> -	.max_attr = ETHTOOL_A_CABLE_TEST_TDR_NTF_MAX,
> -	.table = ethtool_cable_test_tdr_ntf_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_tunnel_info_policy[ETHTOOL_A_TUNNEL_INFO_MAX + 1] = {
> -	[ETHTOOL_A_TUNNEL_INFO_HEADER] = { .name = "header", .type = YNL_PT_NEST, .nest = &ethtool_header_nest, },
> -	[ETHTOOL_A_TUNNEL_INFO_UDP_PORTS] = { .name = "udp-ports", .type = YNL_PT_NEST, .nest = &ethtool_tunnel_udp_nest, },
> -};
> -
> -struct ynl_policy_nest ethtool_tunnel_info_nest = {
> -	.max_attr = ETHTOOL_A_TUNNEL_INFO_MAX,
> -	.table = ethtool_tunnel_info_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_fec_policy[ETHTOOL_A_FEC_MAX + 1] = {
> -	[ETHTOOL_A_FEC_HEADER] = { .name = "header", .type = YNL_PT_NEST, .nest = &ethtool_header_nest, },
> -	[ETHTOOL_A_FEC_MODES] = { .name = "modes", .type = YNL_PT_NEST, .nest = &ethtool_bitset_nest, },
> -	[ETHTOOL_A_FEC_AUTO] = { .name = "auto", .type = YNL_PT_U8, },
> -	[ETHTOOL_A_FEC_ACTIVE] = { .name = "active", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_FEC_STATS] = { .name = "stats", .type = YNL_PT_NEST, .nest = &ethtool_fec_stat_nest, },
> -};
> -
> -struct ynl_policy_nest ethtool_fec_nest = {
> -	.max_attr = ETHTOOL_A_FEC_MAX,
> -	.table = ethtool_fec_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_module_eeprom_policy[ETHTOOL_A_MODULE_EEPROM_MAX + 1] = {
> -	[ETHTOOL_A_MODULE_EEPROM_HEADER] = { .name = "header", .type = YNL_PT_NEST, .nest = &ethtool_header_nest, },
> -	[ETHTOOL_A_MODULE_EEPROM_OFFSET] = { .name = "offset", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_MODULE_EEPROM_LENGTH] = { .name = "length", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_MODULE_EEPROM_PAGE] = { .name = "page", .type = YNL_PT_U8, },
> -	[ETHTOOL_A_MODULE_EEPROM_BANK] = { .name = "bank", .type = YNL_PT_U8, },
> -	[ETHTOOL_A_MODULE_EEPROM_I2C_ADDRESS] = { .name = "i2c-address", .type = YNL_PT_U8, },
> -	[ETHTOOL_A_MODULE_EEPROM_DATA] = { .name = "data", .type = YNL_PT_BINARY,},
> -};
> -
> -struct ynl_policy_nest ethtool_module_eeprom_nest = {
> -	.max_attr = ETHTOOL_A_MODULE_EEPROM_MAX,
> -	.table = ethtool_module_eeprom_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_phc_vclocks_policy[ETHTOOL_A_PHC_VCLOCKS_MAX + 1] = {
> -	[ETHTOOL_A_PHC_VCLOCKS_HEADER] = { .name = "header", .type = YNL_PT_NEST, .nest = &ethtool_header_nest, },
> -	[ETHTOOL_A_PHC_VCLOCKS_NUM] = { .name = "num", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_PHC_VCLOCKS_INDEX] = { .name = "index", .type = YNL_PT_BINARY,},
> -};
> -
> -struct ynl_policy_nest ethtool_phc_vclocks_nest = {
> -	.max_attr = ETHTOOL_A_PHC_VCLOCKS_MAX,
> -	.table = ethtool_phc_vclocks_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_module_policy[ETHTOOL_A_MODULE_MAX + 1] = {
> -	[ETHTOOL_A_MODULE_HEADER] = { .name = "header", .type = YNL_PT_NEST, .nest = &ethtool_header_nest, },
> -	[ETHTOOL_A_MODULE_POWER_MODE_POLICY] = { .name = "power-mode-policy", .type = YNL_PT_U8, },
> -	[ETHTOOL_A_MODULE_POWER_MODE] = { .name = "power-mode", .type = YNL_PT_U8, },
> -};
> -
> -struct ynl_policy_nest ethtool_module_nest = {
> -	.max_attr = ETHTOOL_A_MODULE_MAX,
> -	.table = ethtool_module_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_pse_policy[ETHTOOL_A_PSE_MAX + 1] = {
> -	[ETHTOOL_A_PSE_HEADER] = { .name = "header", .type = YNL_PT_NEST, .nest = &ethtool_header_nest, },
> -	[ETHTOOL_A_PODL_PSE_ADMIN_STATE] = { .name = "admin-state", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL] = { .name = "admin-control", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_PODL_PSE_PW_D_STATUS] = { .name = "pw-d-status", .type = YNL_PT_U32, },
> -};
> -
> -struct ynl_policy_nest ethtool_pse_nest = {
> -	.max_attr = ETHTOOL_A_PSE_MAX,
> -	.table = ethtool_pse_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_rss_policy[ETHTOOL_A_RSS_MAX + 1] = {
> -	[ETHTOOL_A_RSS_HEADER] = { .name = "header", .type = YNL_PT_NEST, .nest = &ethtool_header_nest, },
> -	[ETHTOOL_A_RSS_CONTEXT] = { .name = "context", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_RSS_HFUNC] = { .name = "hfunc", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_RSS_INDIR] = { .name = "indir", .type = YNL_PT_BINARY,},
> -	[ETHTOOL_A_RSS_HKEY] = { .name = "hkey", .type = YNL_PT_BINARY,},
> -};
> -
> -struct ynl_policy_nest ethtool_rss_nest = {
> -	.max_attr = ETHTOOL_A_RSS_MAX,
> -	.table = ethtool_rss_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_plca_policy[ETHTOOL_A_PLCA_MAX + 1] = {
> -	[ETHTOOL_A_PLCA_HEADER] = { .name = "header", .type = YNL_PT_NEST, .nest = &ethtool_header_nest, },
> -	[ETHTOOL_A_PLCA_VERSION] = { .name = "version", .type = YNL_PT_U16, },
> -	[ETHTOOL_A_PLCA_ENABLED] = { .name = "enabled", .type = YNL_PT_U8, },
> -	[ETHTOOL_A_PLCA_STATUS] = { .name = "status", .type = YNL_PT_U8, },
> -	[ETHTOOL_A_PLCA_NODE_CNT] = { .name = "node-cnt", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_PLCA_NODE_ID] = { .name = "node-id", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_PLCA_TO_TMR] = { .name = "to-tmr", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_PLCA_BURST_CNT] = { .name = "burst-cnt", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_PLCA_BURST_TMR] = { .name = "burst-tmr", .type = YNL_PT_U32, },
> -};
> -
> -struct ynl_policy_nest ethtool_plca_nest = {
> -	.max_attr = ETHTOOL_A_PLCA_MAX,
> -	.table = ethtool_plca_policy,
> -};
> -
> -struct ynl_policy_attr ethtool_mm_policy[ETHTOOL_A_MM_MAX + 1] = {
> -	[ETHTOOL_A_MM_HEADER] = { .name = "header", .type = YNL_PT_NEST, .nest = &ethtool_header_nest, },
> -	[ETHTOOL_A_MM_PMAC_ENABLED] = { .name = "pmac-enabled", .type = YNL_PT_U8, },
> -	[ETHTOOL_A_MM_TX_ENABLED] = { .name = "tx-enabled", .type = YNL_PT_U8, },
> -	[ETHTOOL_A_MM_TX_ACTIVE] = { .name = "tx-active", .type = YNL_PT_U8, },
> -	[ETHTOOL_A_MM_TX_MIN_FRAG_SIZE] = { .name = "tx-min-frag-size", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_MM_RX_MIN_FRAG_SIZE] = { .name = "rx-min-frag-size", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_MM_VERIFY_ENABLED] = { .name = "verify-enabled", .type = YNL_PT_U8, },
> -	[ETHTOOL_A_MM_VERIFY_STATUS] = { .name = "verify-status", .type = YNL_PT_U8, },
> -	[ETHTOOL_A_MM_VERIFY_TIME] = { .name = "verify-time", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_MM_MAX_VERIFY_TIME] = { .name = "max-verify-time", .type = YNL_PT_U32, },
> -	[ETHTOOL_A_MM_STATS] = { .name = "stats", .type = YNL_PT_NEST, .nest = &ethtool_mm_stat_nest, },
> -};
> -
> -struct ynl_policy_nest ethtool_mm_nest = {
> -	.max_attr = ETHTOOL_A_MM_MAX,
> -	.table = ethtool_mm_policy,
> -};
> -
> -/* Common nested types */
> -void ethtool_header_free(struct ethtool_header *obj)
> -{
> -	free(obj->dev_name);
> -}
> -
> -int ethtool_header_put(struct nlmsghdr *nlh, unsigned int attr_type,
> -		       struct ethtool_header *obj)
> -{
> -	struct nlattr *nest;
> -
> -	nest = mnl_attr_nest_start(nlh, attr_type);
> -	if (obj->_present.dev_index)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_HEADER_DEV_INDEX, obj->dev_index);
> -	if (obj->_present.dev_name_len)
> -		mnl_attr_put_strz(nlh, ETHTOOL_A_HEADER_DEV_NAME, obj->dev_name);
> -	if (obj->_present.flags)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_HEADER_FLAGS, obj->flags);
> -	mnl_attr_nest_end(nlh, nest);
> -
> -	return 0;
> -}
> -
> -int ethtool_header_parse(struct ynl_parse_arg *yarg,
> -			 const struct nlattr *nested)
> -{
> -	struct ethtool_header *dst = yarg->data;
> -	const struct nlattr *attr;
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_HEADER_DEV_INDEX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.dev_index = 1;
> -			dst->dev_index = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_HEADER_DEV_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.dev_name_len = len;
> -			dst->dev_name = malloc(len + 1);
> -			memcpy(dst->dev_name, mnl_attr_get_str(attr), len);
> -			dst->dev_name[len] = 0;
> -		} else if (type == ETHTOOL_A_HEADER_FLAGS) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.flags = 1;
> -			dst->flags = mnl_attr_get_u32(attr);
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -void ethtool_pause_stat_free(struct ethtool_pause_stat *obj)
> -{
> -}
> -
> -int ethtool_pause_stat_put(struct nlmsghdr *nlh, unsigned int attr_type,
> -			   struct ethtool_pause_stat *obj)
> -{
> -	struct nlattr *nest;
> -
> -	nest = mnl_attr_nest_start(nlh, attr_type);
> -	if (obj->_present.tx_frames)
> -		mnl_attr_put_u64(nlh, ETHTOOL_A_PAUSE_STAT_TX_FRAMES, obj->tx_frames);
> -	if (obj->_present.rx_frames)
> -		mnl_attr_put_u64(nlh, ETHTOOL_A_PAUSE_STAT_RX_FRAMES, obj->rx_frames);
> -	mnl_attr_nest_end(nlh, nest);
> -
> -	return 0;
> -}
> -
> -int ethtool_pause_stat_parse(struct ynl_parse_arg *yarg,
> -			     const struct nlattr *nested)
> -{
> -	struct ethtool_pause_stat *dst = yarg->data;
> -	const struct nlattr *attr;
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_PAUSE_STAT_TX_FRAMES) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.tx_frames = 1;
> -			dst->tx_frames = mnl_attr_get_u64(attr);
> -		} else if (type == ETHTOOL_A_PAUSE_STAT_RX_FRAMES) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.rx_frames = 1;
> -			dst->rx_frames = mnl_attr_get_u64(attr);
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -void ethtool_cable_test_tdr_cfg_free(struct ethtool_cable_test_tdr_cfg *obj)
> -{
> -}
> -
> -void ethtool_fec_stat_free(struct ethtool_fec_stat *obj)
> -{
> -	free(obj->corrected);
> -	free(obj->uncorr);
> -	free(obj->corr_bits);
> -}
> -
> -int ethtool_fec_stat_put(struct nlmsghdr *nlh, unsigned int attr_type,
> -			 struct ethtool_fec_stat *obj)
> -{
> -	struct nlattr *nest;
> -
> -	nest = mnl_attr_nest_start(nlh, attr_type);
> -	if (obj->_present.corrected_len)
> -		mnl_attr_put(nlh, ETHTOOL_A_FEC_STAT_CORRECTED, obj->_present.corrected_len, obj->corrected);
> -	if (obj->_present.uncorr_len)
> -		mnl_attr_put(nlh, ETHTOOL_A_FEC_STAT_UNCORR, obj->_present.uncorr_len, obj->uncorr);
> -	if (obj->_present.corr_bits_len)
> -		mnl_attr_put(nlh, ETHTOOL_A_FEC_STAT_CORR_BITS, obj->_present.corr_bits_len, obj->corr_bits);
> -	mnl_attr_nest_end(nlh, nest);
> -
> -	return 0;
> -}
> -
> -int ethtool_fec_stat_parse(struct ynl_parse_arg *yarg,
> -			   const struct nlattr *nested)
> -{
> -	struct ethtool_fec_stat *dst = yarg->data;
> -	const struct nlattr *attr;
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_FEC_STAT_CORRECTED) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = mnl_attr_get_payload_len(attr);
> -			dst->_present.corrected_len = len;
> -			dst->corrected = malloc(len);
> -			memcpy(dst->corrected, mnl_attr_get_payload(attr), len);
> -		} else if (type == ETHTOOL_A_FEC_STAT_UNCORR) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = mnl_attr_get_payload_len(attr);
> -			dst->_present.uncorr_len = len;
> -			dst->uncorr = malloc(len);
> -			memcpy(dst->uncorr, mnl_attr_get_payload(attr), len);
> -		} else if (type == ETHTOOL_A_FEC_STAT_CORR_BITS) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = mnl_attr_get_payload_len(attr);
> -			dst->_present.corr_bits_len = len;
> -			dst->corr_bits = malloc(len);
> -			memcpy(dst->corr_bits, mnl_attr_get_payload(attr), len);
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -void ethtool_mm_stat_free(struct ethtool_mm_stat *obj)
> -{
> -}
> -
> -int ethtool_mm_stat_parse(struct ynl_parse_arg *yarg,
> -			  const struct nlattr *nested)
> -{
> -	struct ethtool_mm_stat *dst = yarg->data;
> -	const struct nlattr *attr;
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_MM_STAT_REASSEMBLY_ERRORS) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.reassembly_errors = 1;
> -			dst->reassembly_errors = mnl_attr_get_u64(attr);
> -		} else if (type == ETHTOOL_A_MM_STAT_SMD_ERRORS) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.smd_errors = 1;
> -			dst->smd_errors = mnl_attr_get_u64(attr);
> -		} else if (type == ETHTOOL_A_MM_STAT_REASSEMBLY_OK) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.reassembly_ok = 1;
> -			dst->reassembly_ok = mnl_attr_get_u64(attr);
> -		} else if (type == ETHTOOL_A_MM_STAT_RX_FRAG_COUNT) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.rx_frag_count = 1;
> -			dst->rx_frag_count = mnl_attr_get_u64(attr);
> -		} else if (type == ETHTOOL_A_MM_STAT_TX_FRAG_COUNT) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.tx_frag_count = 1;
> -			dst->tx_frag_count = mnl_attr_get_u64(attr);
> -		} else if (type == ETHTOOL_A_MM_STAT_HOLD_COUNT) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.hold_count = 1;
> -			dst->hold_count = mnl_attr_get_u64(attr);
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -void ethtool_cable_result_free(struct ethtool_cable_result *obj)
> -{
> -}
> -
> -int ethtool_cable_result_parse(struct ynl_parse_arg *yarg,
> -			       const struct nlattr *nested)
> -{
> -	struct ethtool_cable_result *dst = yarg->data;
> -	const struct nlattr *attr;
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_CABLE_RESULT_PAIR) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.pair = 1;
> -			dst->pair = mnl_attr_get_u8(attr);
> -		} else if (type == ETHTOOL_A_CABLE_RESULT_CODE) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.code = 1;
> -			dst->code = mnl_attr_get_u8(attr);
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -void ethtool_cable_fault_length_free(struct ethtool_cable_fault_length *obj)
> -{
> -}
> -
> -int ethtool_cable_fault_length_parse(struct ynl_parse_arg *yarg,
> -				     const struct nlattr *nested)
> -{
> -	struct ethtool_cable_fault_length *dst = yarg->data;
> -	const struct nlattr *attr;
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_CABLE_FAULT_LENGTH_PAIR) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.pair = 1;
> -			dst->pair = mnl_attr_get_u8(attr);
> -		} else if (type == ETHTOOL_A_CABLE_FAULT_LENGTH_CM) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.cm = 1;
> -			dst->cm = mnl_attr_get_u32(attr);
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -void ethtool_bitset_bit_free(struct ethtool_bitset_bit *obj)
> -{
> -	free(obj->name);
> -}
> -
> -int ethtool_bitset_bit_put(struct nlmsghdr *nlh, unsigned int attr_type,
> -			   struct ethtool_bitset_bit *obj)
> -{
> -	struct nlattr *nest;
> -
> -	nest = mnl_attr_nest_start(nlh, attr_type);
> -	if (obj->_present.index)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_BITSET_BIT_INDEX, obj->index);
> -	if (obj->_present.name_len)
> -		mnl_attr_put_strz(nlh, ETHTOOL_A_BITSET_BIT_NAME, obj->name);
> -	if (obj->_present.value)
> -		mnl_attr_put(nlh, ETHTOOL_A_BITSET_BIT_VALUE, 0, NULL);
> -	mnl_attr_nest_end(nlh, nest);
> -
> -	return 0;
> -}
> -
> -int ethtool_bitset_bit_parse(struct ynl_parse_arg *yarg,
> -			     const struct nlattr *nested)
> -{
> -	struct ethtool_bitset_bit *dst = yarg->data;
> -	const struct nlattr *attr;
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_BITSET_BIT_INDEX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.index = 1;
> -			dst->index = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_BITSET_BIT_NAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.name_len = len;
> -			dst->name = malloc(len + 1);
> -			memcpy(dst->name, mnl_attr_get_str(attr), len);
> -			dst->name[len] = 0;
> -		} else if (type == ETHTOOL_A_BITSET_BIT_VALUE) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.value = 1;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -void ethtool_tunnel_udp_entry_free(struct ethtool_tunnel_udp_entry *obj)
> -{
> -}
> -
> -int ethtool_tunnel_udp_entry_parse(struct ynl_parse_arg *yarg,
> -				   const struct nlattr *nested)
> -{
> -	struct ethtool_tunnel_udp_entry *dst = yarg->data;
> -	const struct nlattr *attr;
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_TUNNEL_UDP_ENTRY_PORT) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.port = 1;
> -			dst->port = mnl_attr_get_u16(attr);
> -		} else if (type == ETHTOOL_A_TUNNEL_UDP_ENTRY_TYPE) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.type = 1;
> -			dst->type = mnl_attr_get_u32(attr);
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -void ethtool_string_free(struct ethtool_string *obj)
> -{
> -	free(obj->value);
> -}
> -
> -int ethtool_string_put(struct nlmsghdr *nlh, unsigned int attr_type,
> -		       struct ethtool_string *obj)
> -{
> -	struct nlattr *nest;
> -
> -	nest = mnl_attr_nest_start(nlh, attr_type);
> -	if (obj->_present.index)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_STRING_INDEX, obj->index);
> -	if (obj->_present.value_len)
> -		mnl_attr_put_strz(nlh, ETHTOOL_A_STRING_VALUE, obj->value);
> -	mnl_attr_nest_end(nlh, nest);
> -
> -	return 0;
> -}
> -
> -int ethtool_string_parse(struct ynl_parse_arg *yarg,
> -			 const struct nlattr *nested)
> -{
> -	struct ethtool_string *dst = yarg->data;
> -	const struct nlattr *attr;
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_STRING_INDEX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.index = 1;
> -			dst->index = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_STRING_VALUE) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.value_len = len;
> -			dst->value = malloc(len + 1);
> -			memcpy(dst->value, mnl_attr_get_str(attr), len);
> -			dst->value[len] = 0;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -void ethtool_cable_nest_free(struct ethtool_cable_nest *obj)
> -{
> -	ethtool_cable_result_free(&obj->result);
> -	ethtool_cable_fault_length_free(&obj->fault_length);
> -}
> -
> -int ethtool_cable_nest_parse(struct ynl_parse_arg *yarg,
> -			     const struct nlattr *nested)
> -{
> -	struct ethtool_cable_nest *dst = yarg->data;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -
> -	parg.ys = yarg->ys;
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_CABLE_NEST_RESULT) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.result = 1;
> -
> -			parg.rsp_policy = &ethtool_cable_result_nest;
> -			parg.data = &dst->result;
> -			if (ethtool_cable_result_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_CABLE_NEST_FAULT_LENGTH) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.fault_length = 1;
> -
> -			parg.rsp_policy = &ethtool_cable_fault_length_nest;
> -			parg.data = &dst->fault_length;
> -			if (ethtool_cable_fault_length_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -void ethtool_bitset_bits_free(struct ethtool_bitset_bits *obj)
> -{
> -	unsigned int i;
> -
> -	for (i = 0; i < obj->n_bit; i++)
> -		ethtool_bitset_bit_free(&obj->bit[i]);
> -	free(obj->bit);
> -}
> -
> -int ethtool_bitset_bits_put(struct nlmsghdr *nlh, unsigned int attr_type,
> -			    struct ethtool_bitset_bits *obj)
> -{
> -	struct nlattr *nest;
> -
> -	nest = mnl_attr_nest_start(nlh, attr_type);
> -	for (unsigned int i = 0; i < obj->n_bit; i++)
> -		ethtool_bitset_bit_put(nlh, ETHTOOL_A_BITSET_BITS_BIT, &obj->bit[i]);
> -	mnl_attr_nest_end(nlh, nest);
> -
> -	return 0;
> -}
> -
> -int ethtool_bitset_bits_parse(struct ynl_parse_arg *yarg,
> -			      const struct nlattr *nested)
> -{
> -	struct ethtool_bitset_bits *dst = yarg->data;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -	unsigned int n_bit = 0;
> -	int i;
> -
> -	parg.ys = yarg->ys;
> -
> -	if (dst->bit)
> -		return ynl_error_parse(yarg, "attribute already present (bitset-bits.bit)");
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_BITSET_BITS_BIT) {
> -			n_bit++;
> -		}
> -	}
> -
> -	if (n_bit) {
> -		dst->bit = calloc(n_bit, sizeof(*dst->bit));
> -		dst->n_bit = n_bit;
> -		i = 0;
> -		parg.rsp_policy = &ethtool_bitset_bit_nest;
> -		mnl_attr_for_each_nested(attr, nested) {
> -			if (mnl_attr_get_type(attr) == ETHTOOL_A_BITSET_BITS_BIT) {
> -				parg.data = &dst->bit[i];
> -				if (ethtool_bitset_bit_parse(&parg, attr))
> -					return MNL_CB_ERROR;
> -				i++;
> -			}
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -void ethtool_strings_free(struct ethtool_strings *obj)
> -{
> -	unsigned int i;
> -
> -	for (i = 0; i < obj->n_string; i++)
> -		ethtool_string_free(&obj->string[i]);
> -	free(obj->string);
> -}
> -
> -int ethtool_strings_put(struct nlmsghdr *nlh, unsigned int attr_type,
> -			struct ethtool_strings *obj)
> -{
> -	struct nlattr *nest;
> -
> -	nest = mnl_attr_nest_start(nlh, attr_type);
> -	for (unsigned int i = 0; i < obj->n_string; i++)
> -		ethtool_string_put(nlh, ETHTOOL_A_STRINGS_STRING, &obj->string[i]);
> -	mnl_attr_nest_end(nlh, nest);
> -
> -	return 0;
> -}
> -
> -int ethtool_strings_parse(struct ynl_parse_arg *yarg,
> -			  const struct nlattr *nested)
> -{
> -	struct ethtool_strings *dst = yarg->data;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -	unsigned int n_string = 0;
> -	int i;
> -
> -	parg.ys = yarg->ys;
> -
> -	if (dst->string)
> -		return ynl_error_parse(yarg, "attribute already present (strings.string)");
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_STRINGS_STRING) {
> -			n_string++;
> -		}
> -	}
> -
> -	if (n_string) {
> -		dst->string = calloc(n_string, sizeof(*dst->string));
> -		dst->n_string = n_string;
> -		i = 0;
> -		parg.rsp_policy = &ethtool_string_nest;
> -		mnl_attr_for_each_nested(attr, nested) {
> -			if (mnl_attr_get_type(attr) == ETHTOOL_A_STRINGS_STRING) {
> -				parg.data = &dst->string[i];
> -				if (ethtool_string_parse(&parg, attr))
> -					return MNL_CB_ERROR;
> -				i++;
> -			}
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -void ethtool_bitset_free(struct ethtool_bitset *obj)
> -{
> -	ethtool_bitset_bits_free(&obj->bits);
> -}
> -
> -int ethtool_bitset_put(struct nlmsghdr *nlh, unsigned int attr_type,
> -		       struct ethtool_bitset *obj)
> -{
> -	struct nlattr *nest;
> -
> -	nest = mnl_attr_nest_start(nlh, attr_type);
> -	if (obj->_present.nomask)
> -		mnl_attr_put(nlh, ETHTOOL_A_BITSET_NOMASK, 0, NULL);
> -	if (obj->_present.size)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_BITSET_SIZE, obj->size);
> -	if (obj->_present.bits)
> -		ethtool_bitset_bits_put(nlh, ETHTOOL_A_BITSET_BITS, &obj->bits);
> -	mnl_attr_nest_end(nlh, nest);
> -
> -	return 0;
> -}
> -
> -int ethtool_bitset_parse(struct ynl_parse_arg *yarg,
> -			 const struct nlattr *nested)
> -{
> -	struct ethtool_bitset *dst = yarg->data;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -
> -	parg.ys = yarg->ys;
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_BITSET_NOMASK) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.nomask = 1;
> -		} else if (type == ETHTOOL_A_BITSET_SIZE) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.size = 1;
> -			dst->size = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_BITSET_BITS) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.bits = 1;
> -
> -			parg.rsp_policy = &ethtool_bitset_bits_nest;
> -			parg.data = &dst->bits;
> -			if (ethtool_bitset_bits_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -void ethtool_stringset_free(struct ethtool_stringset_ *obj)
> -{
> -	unsigned int i;
> -
> -	for (i = 0; i < obj->n_strings; i++)
> -		ethtool_strings_free(&obj->strings[i]);
> -	free(obj->strings);
> -}
> -
> -int ethtool_stringset_put(struct nlmsghdr *nlh, unsigned int attr_type,
> -			  struct ethtool_stringset_ *obj)
> -{
> -	struct nlattr *nest;
> -
> -	nest = mnl_attr_nest_start(nlh, attr_type);
> -	if (obj->_present.id)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_STRINGSET_ID, obj->id);
> -	if (obj->_present.count)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_STRINGSET_COUNT, obj->count);
> -	for (unsigned int i = 0; i < obj->n_strings; i++)
> -		ethtool_strings_put(nlh, ETHTOOL_A_STRINGSET_STRINGS, &obj->strings[i]);
> -	mnl_attr_nest_end(nlh, nest);
> -
> -	return 0;
> -}
> -
> -int ethtool_stringset_parse(struct ynl_parse_arg *yarg,
> -			    const struct nlattr *nested)
> -{
> -	struct ethtool_stringset_ *dst = yarg->data;
> -	unsigned int n_strings = 0;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -	int i;
> -
> -	parg.ys = yarg->ys;
> -
> -	if (dst->strings)
> -		return ynl_error_parse(yarg, "attribute already present (stringset.strings)");
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_STRINGSET_ID) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.id = 1;
> -			dst->id = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_STRINGSET_COUNT) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.count = 1;
> -			dst->count = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_STRINGSET_STRINGS) {
> -			n_strings++;
> -		}
> -	}
> -
> -	if (n_strings) {
> -		dst->strings = calloc(n_strings, sizeof(*dst->strings));
> -		dst->n_strings = n_strings;
> -		i = 0;
> -		parg.rsp_policy = &ethtool_strings_nest;
> -		mnl_attr_for_each_nested(attr, nested) {
> -			if (mnl_attr_get_type(attr) == ETHTOOL_A_STRINGSET_STRINGS) {
> -				parg.data = &dst->strings[i];
> -				if (ethtool_strings_parse(&parg, attr))
> -					return MNL_CB_ERROR;
> -				i++;
> -			}
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -void ethtool_tunnel_udp_table_free(struct ethtool_tunnel_udp_table *obj)
> -{
> -	unsigned int i;
> -
> -	ethtool_bitset_free(&obj->types);
> -	for (i = 0; i < obj->n_entry; i++)
> -		ethtool_tunnel_udp_entry_free(&obj->entry[i]);
> -	free(obj->entry);
> -}
> -
> -int ethtool_tunnel_udp_table_parse(struct ynl_parse_arg *yarg,
> -				   const struct nlattr *nested)
> -{
> -	struct ethtool_tunnel_udp_table *dst = yarg->data;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -	unsigned int n_entry = 0;
> -	int i;
> -
> -	parg.ys = yarg->ys;
> -
> -	if (dst->entry)
> -		return ynl_error_parse(yarg, "attribute already present (tunnel-udp-table.entry)");
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_TUNNEL_UDP_TABLE_SIZE) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.size = 1;
> -			dst->size = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_TUNNEL_UDP_TABLE_TYPES) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.types = 1;
> -
> -			parg.rsp_policy = &ethtool_bitset_nest;
> -			parg.data = &dst->types;
> -			if (ethtool_bitset_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_TUNNEL_UDP_TABLE_ENTRY) {
> -			n_entry++;
> -		}
> -	}
> -
> -	if (n_entry) {
> -		dst->entry = calloc(n_entry, sizeof(*dst->entry));
> -		dst->n_entry = n_entry;
> -		i = 0;
> -		parg.rsp_policy = &ethtool_tunnel_udp_entry_nest;
> -		mnl_attr_for_each_nested(attr, nested) {
> -			if (mnl_attr_get_type(attr) == ETHTOOL_A_TUNNEL_UDP_TABLE_ENTRY) {
> -				parg.data = &dst->entry[i];
> -				if (ethtool_tunnel_udp_entry_parse(&parg, attr))
> -					return MNL_CB_ERROR;
> -				i++;
> -			}
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -void ethtool_stringsets_free(struct ethtool_stringsets *obj)
> -{
> -	unsigned int i;
> -
> -	for (i = 0; i < obj->n_stringset; i++)
> -		ethtool_stringset_free(&obj->stringset[i]);
> -	free(obj->stringset);
> -}
> -
> -int ethtool_stringsets_put(struct nlmsghdr *nlh, unsigned int attr_type,
> -			   struct ethtool_stringsets *obj)
> -{
> -	struct nlattr *nest;
> -
> -	nest = mnl_attr_nest_start(nlh, attr_type);
> -	for (unsigned int i = 0; i < obj->n_stringset; i++)
> -		ethtool_stringset_put(nlh, ETHTOOL_A_STRINGSETS_STRINGSET, &obj->stringset[i]);
> -	mnl_attr_nest_end(nlh, nest);
> -
> -	return 0;
> -}
> -
> -int ethtool_stringsets_parse(struct ynl_parse_arg *yarg,
> -			     const struct nlattr *nested)
> -{
> -	struct ethtool_stringsets *dst = yarg->data;
> -	unsigned int n_stringset = 0;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -	int i;
> -
> -	parg.ys = yarg->ys;
> -
> -	if (dst->stringset)
> -		return ynl_error_parse(yarg, "attribute already present (stringsets.stringset)");
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_STRINGSETS_STRINGSET) {
> -			n_stringset++;
> -		}
> -	}
> -
> -	if (n_stringset) {
> -		dst->stringset = calloc(n_stringset, sizeof(*dst->stringset));
> -		dst->n_stringset = n_stringset;
> -		i = 0;
> -		parg.rsp_policy = &ethtool_stringset_nest;
> -		mnl_attr_for_each_nested(attr, nested) {
> -			if (mnl_attr_get_type(attr) == ETHTOOL_A_STRINGSETS_STRINGSET) {
> -				parg.data = &dst->stringset[i];
> -				if (ethtool_stringset_parse(&parg, attr))
> -					return MNL_CB_ERROR;
> -				i++;
> -			}
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -void ethtool_tunnel_udp_free(struct ethtool_tunnel_udp *obj)
> -{
> -	ethtool_tunnel_udp_table_free(&obj->table);
> -}
> -
> -int ethtool_tunnel_udp_parse(struct ynl_parse_arg *yarg,
> -			     const struct nlattr *nested)
> -{
> -	struct ethtool_tunnel_udp *dst = yarg->data;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -
> -	parg.ys = yarg->ys;
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_TUNNEL_UDP_TABLE) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.table = 1;
> -
> -			parg.rsp_policy = &ethtool_tunnel_udp_table_nest;
> -			parg.data = &dst->table;
> -			if (ethtool_tunnel_udp_table_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -/* ============== ETHTOOL_MSG_STRSET_GET ============== */
> -/* ETHTOOL_MSG_STRSET_GET - do */
> -void ethtool_strset_get_req_free(struct ethtool_strset_get_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	ethtool_stringsets_free(&req->stringsets);
> -	free(req);
> -}
> -
> -void ethtool_strset_get_rsp_free(struct ethtool_strset_get_rsp *rsp)
> -{
> -	ethtool_header_free(&rsp->header);
> -	ethtool_stringsets_free(&rsp->stringsets);
> -	free(rsp);
> -}
> -
> -int ethtool_strset_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct ethtool_strset_get_rsp *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -
> -	dst = yarg->data;
> -	parg.ys = yarg->ys;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_STRSET_HEADER) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.header = 1;
> -
> -			parg.rsp_policy = &ethtool_header_nest;
> -			parg.data = &dst->header;
> -			if (ethtool_header_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_STRSET_STRINGSETS) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.stringsets = 1;
> -
> -			parg.rsp_policy = &ethtool_stringsets_nest;
> -			parg.data = &dst->stringsets;
> -			if (ethtool_stringsets_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct ethtool_strset_get_rsp *
> -ethtool_strset_get(struct ynl_sock *ys, struct ethtool_strset_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct ethtool_strset_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_STRSET_GET, 1);
> -	ys->req_policy = &ethtool_strset_nest;
> -	yrs.yarg.rsp_policy = &ethtool_strset_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_STRSET_HEADER, &req->header);
> -	if (req->_present.stringsets)
> -		ethtool_stringsets_put(nlh, ETHTOOL_A_STRSET_STRINGSETS, &req->stringsets);
> -	if (req->_present.counts_only)
> -		mnl_attr_put(nlh, ETHTOOL_A_STRSET_COUNTS_ONLY, 0, NULL);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = ethtool_strset_get_rsp_parse;
> -	yrs.rsp_cmd = ETHTOOL_MSG_STRSET_GET;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	ethtool_strset_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* ETHTOOL_MSG_STRSET_GET - dump */
> -void ethtool_strset_get_list_free(struct ethtool_strset_get_list *rsp)
> -{
> -	struct ethtool_strset_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		ethtool_header_free(&rsp->obj.header);
> -		ethtool_stringsets_free(&rsp->obj.stringsets);
> -		free(rsp);
> -	}
> -}
> -
> -struct ethtool_strset_get_list *
> -ethtool_strset_get_dump(struct ynl_sock *ys,
> -			struct ethtool_strset_get_req_dump *req)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct ethtool_strset_get_list);
> -	yds.cb = ethtool_strset_get_rsp_parse;
> -	yds.rsp_cmd = ETHTOOL_MSG_STRSET_GET;
> -	yds.rsp_policy = &ethtool_strset_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, ETHTOOL_MSG_STRSET_GET, 1);
> -	ys->req_policy = &ethtool_strset_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_STRSET_HEADER, &req->header);
> -	if (req->_present.stringsets)
> -		ethtool_stringsets_put(nlh, ETHTOOL_A_STRSET_STRINGSETS, &req->stringsets);
> -	if (req->_present.counts_only)
> -		mnl_attr_put(nlh, ETHTOOL_A_STRSET_COUNTS_ONLY, 0, NULL);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	ethtool_strset_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ============== ETHTOOL_MSG_LINKINFO_GET ============== */
> -/* ETHTOOL_MSG_LINKINFO_GET - do */
> -void ethtool_linkinfo_get_req_free(struct ethtool_linkinfo_get_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	free(req);
> -}
> -
> -void ethtool_linkinfo_get_rsp_free(struct ethtool_linkinfo_get_rsp *rsp)
> -{
> -	ethtool_header_free(&rsp->header);
> -	free(rsp);
> -}
> -
> -int ethtool_linkinfo_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct ethtool_linkinfo_get_rsp *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -
> -	dst = yarg->data;
> -	parg.ys = yarg->ys;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_LINKINFO_HEADER) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.header = 1;
> -
> -			parg.rsp_policy = &ethtool_header_nest;
> -			parg.data = &dst->header;
> -			if (ethtool_header_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_LINKINFO_PORT) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.port = 1;
> -			dst->port = mnl_attr_get_u8(attr);
> -		} else if (type == ETHTOOL_A_LINKINFO_PHYADDR) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.phyaddr = 1;
> -			dst->phyaddr = mnl_attr_get_u8(attr);
> -		} else if (type == ETHTOOL_A_LINKINFO_TP_MDIX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.tp_mdix = 1;
> -			dst->tp_mdix = mnl_attr_get_u8(attr);
> -		} else if (type == ETHTOOL_A_LINKINFO_TP_MDIX_CTRL) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.tp_mdix_ctrl = 1;
> -			dst->tp_mdix_ctrl = mnl_attr_get_u8(attr);
> -		} else if (type == ETHTOOL_A_LINKINFO_TRANSCEIVER) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.transceiver = 1;
> -			dst->transceiver = mnl_attr_get_u8(attr);
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct ethtool_linkinfo_get_rsp *
> -ethtool_linkinfo_get(struct ynl_sock *ys, struct ethtool_linkinfo_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct ethtool_linkinfo_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_LINKINFO_GET, 1);
> -	ys->req_policy = &ethtool_linkinfo_nest;
> -	yrs.yarg.rsp_policy = &ethtool_linkinfo_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_LINKINFO_HEADER, &req->header);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = ethtool_linkinfo_get_rsp_parse;
> -	yrs.rsp_cmd = ETHTOOL_MSG_LINKINFO_GET;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	ethtool_linkinfo_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* ETHTOOL_MSG_LINKINFO_GET - dump */
> -void ethtool_linkinfo_get_list_free(struct ethtool_linkinfo_get_list *rsp)
> -{
> -	struct ethtool_linkinfo_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		ethtool_header_free(&rsp->obj.header);
> -		free(rsp);
> -	}
> -}
> -
> -struct ethtool_linkinfo_get_list *
> -ethtool_linkinfo_get_dump(struct ynl_sock *ys,
> -			  struct ethtool_linkinfo_get_req_dump *req)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct ethtool_linkinfo_get_list);
> -	yds.cb = ethtool_linkinfo_get_rsp_parse;
> -	yds.rsp_cmd = ETHTOOL_MSG_LINKINFO_GET;
> -	yds.rsp_policy = &ethtool_linkinfo_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, ETHTOOL_MSG_LINKINFO_GET, 1);
> -	ys->req_policy = &ethtool_linkinfo_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_LINKINFO_HEADER, &req->header);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	ethtool_linkinfo_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ETHTOOL_MSG_LINKINFO_GET - notify */
> -void ethtool_linkinfo_get_ntf_free(struct ethtool_linkinfo_get_ntf *rsp)
> -{
> -	ethtool_header_free(&rsp->obj.header);
> -	free(rsp);
> -}
> -
> -/* ============== ETHTOOL_MSG_LINKINFO_SET ============== */
> -/* ETHTOOL_MSG_LINKINFO_SET - do */
> -void ethtool_linkinfo_set_req_free(struct ethtool_linkinfo_set_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	free(req);
> -}
> -
> -int ethtool_linkinfo_set(struct ynl_sock *ys,
> -			 struct ethtool_linkinfo_set_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_LINKINFO_SET, 1);
> -	ys->req_policy = &ethtool_linkinfo_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_LINKINFO_HEADER, &req->header);
> -	if (req->_present.port)
> -		mnl_attr_put_u8(nlh, ETHTOOL_A_LINKINFO_PORT, req->port);
> -	if (req->_present.phyaddr)
> -		mnl_attr_put_u8(nlh, ETHTOOL_A_LINKINFO_PHYADDR, req->phyaddr);
> -	if (req->_present.tp_mdix)
> -		mnl_attr_put_u8(nlh, ETHTOOL_A_LINKINFO_TP_MDIX, req->tp_mdix);
> -	if (req->_present.tp_mdix_ctrl)
> -		mnl_attr_put_u8(nlh, ETHTOOL_A_LINKINFO_TP_MDIX_CTRL, req->tp_mdix_ctrl);
> -	if (req->_present.transceiver)
> -		mnl_attr_put_u8(nlh, ETHTOOL_A_LINKINFO_TRANSCEIVER, req->transceiver);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== ETHTOOL_MSG_LINKMODES_GET ============== */
> -/* ETHTOOL_MSG_LINKMODES_GET - do */
> -void ethtool_linkmodes_get_req_free(struct ethtool_linkmodes_get_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	free(req);
> -}
> -
> -void ethtool_linkmodes_get_rsp_free(struct ethtool_linkmodes_get_rsp *rsp)
> -{
> -	ethtool_header_free(&rsp->header);
> -	ethtool_bitset_free(&rsp->ours);
> -	ethtool_bitset_free(&rsp->peer);
> -	free(rsp);
> -}
> -
> -int ethtool_linkmodes_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct ethtool_linkmodes_get_rsp *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -
> -	dst = yarg->data;
> -	parg.ys = yarg->ys;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_LINKMODES_HEADER) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.header = 1;
> -
> -			parg.rsp_policy = &ethtool_header_nest;
> -			parg.data = &dst->header;
> -			if (ethtool_header_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_LINKMODES_AUTONEG) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.autoneg = 1;
> -			dst->autoneg = mnl_attr_get_u8(attr);
> -		} else if (type == ETHTOOL_A_LINKMODES_OURS) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.ours = 1;
> -
> -			parg.rsp_policy = &ethtool_bitset_nest;
> -			parg.data = &dst->ours;
> -			if (ethtool_bitset_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_LINKMODES_PEER) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.peer = 1;
> -
> -			parg.rsp_policy = &ethtool_bitset_nest;
> -			parg.data = &dst->peer;
> -			if (ethtool_bitset_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_LINKMODES_SPEED) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.speed = 1;
> -			dst->speed = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_LINKMODES_DUPLEX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.duplex = 1;
> -			dst->duplex = mnl_attr_get_u8(attr);
> -		} else if (type == ETHTOOL_A_LINKMODES_MASTER_SLAVE_CFG) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.master_slave_cfg = 1;
> -			dst->master_slave_cfg = mnl_attr_get_u8(attr);
> -		} else if (type == ETHTOOL_A_LINKMODES_MASTER_SLAVE_STATE) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.master_slave_state = 1;
> -			dst->master_slave_state = mnl_attr_get_u8(attr);
> -		} else if (type == ETHTOOL_A_LINKMODES_LANES) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.lanes = 1;
> -			dst->lanes = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_LINKMODES_RATE_MATCHING) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.rate_matching = 1;
> -			dst->rate_matching = mnl_attr_get_u8(attr);
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct ethtool_linkmodes_get_rsp *
> -ethtool_linkmodes_get(struct ynl_sock *ys,
> -		      struct ethtool_linkmodes_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct ethtool_linkmodes_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_LINKMODES_GET, 1);
> -	ys->req_policy = &ethtool_linkmodes_nest;
> -	yrs.yarg.rsp_policy = &ethtool_linkmodes_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_LINKMODES_HEADER, &req->header);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = ethtool_linkmodes_get_rsp_parse;
> -	yrs.rsp_cmd = ETHTOOL_MSG_LINKMODES_GET;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	ethtool_linkmodes_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* ETHTOOL_MSG_LINKMODES_GET - dump */
> -void ethtool_linkmodes_get_list_free(struct ethtool_linkmodes_get_list *rsp)
> -{
> -	struct ethtool_linkmodes_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		ethtool_header_free(&rsp->obj.header);
> -		ethtool_bitset_free(&rsp->obj.ours);
> -		ethtool_bitset_free(&rsp->obj.peer);
> -		free(rsp);
> -	}
> -}
> -
> -struct ethtool_linkmodes_get_list *
> -ethtool_linkmodes_get_dump(struct ynl_sock *ys,
> -			   struct ethtool_linkmodes_get_req_dump *req)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct ethtool_linkmodes_get_list);
> -	yds.cb = ethtool_linkmodes_get_rsp_parse;
> -	yds.rsp_cmd = ETHTOOL_MSG_LINKMODES_GET;
> -	yds.rsp_policy = &ethtool_linkmodes_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, ETHTOOL_MSG_LINKMODES_GET, 1);
> -	ys->req_policy = &ethtool_linkmodes_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_LINKMODES_HEADER, &req->header);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	ethtool_linkmodes_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ETHTOOL_MSG_LINKMODES_GET - notify */
> -void ethtool_linkmodes_get_ntf_free(struct ethtool_linkmodes_get_ntf *rsp)
> -{
> -	ethtool_header_free(&rsp->obj.header);
> -	ethtool_bitset_free(&rsp->obj.ours);
> -	ethtool_bitset_free(&rsp->obj.peer);
> -	free(rsp);
> -}
> -
> -/* ============== ETHTOOL_MSG_LINKMODES_SET ============== */
> -/* ETHTOOL_MSG_LINKMODES_SET - do */
> -void ethtool_linkmodes_set_req_free(struct ethtool_linkmodes_set_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	ethtool_bitset_free(&req->ours);
> -	ethtool_bitset_free(&req->peer);
> -	free(req);
> -}
> -
> -int ethtool_linkmodes_set(struct ynl_sock *ys,
> -			  struct ethtool_linkmodes_set_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_LINKMODES_SET, 1);
> -	ys->req_policy = &ethtool_linkmodes_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_LINKMODES_HEADER, &req->header);
> -	if (req->_present.autoneg)
> -		mnl_attr_put_u8(nlh, ETHTOOL_A_LINKMODES_AUTONEG, req->autoneg);
> -	if (req->_present.ours)
> -		ethtool_bitset_put(nlh, ETHTOOL_A_LINKMODES_OURS, &req->ours);
> -	if (req->_present.peer)
> -		ethtool_bitset_put(nlh, ETHTOOL_A_LINKMODES_PEER, &req->peer);
> -	if (req->_present.speed)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_LINKMODES_SPEED, req->speed);
> -	if (req->_present.duplex)
> -		mnl_attr_put_u8(nlh, ETHTOOL_A_LINKMODES_DUPLEX, req->duplex);
> -	if (req->_present.master_slave_cfg)
> -		mnl_attr_put_u8(nlh, ETHTOOL_A_LINKMODES_MASTER_SLAVE_CFG, req->master_slave_cfg);
> -	if (req->_present.master_slave_state)
> -		mnl_attr_put_u8(nlh, ETHTOOL_A_LINKMODES_MASTER_SLAVE_STATE, req->master_slave_state);
> -	if (req->_present.lanes)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_LINKMODES_LANES, req->lanes);
> -	if (req->_present.rate_matching)
> -		mnl_attr_put_u8(nlh, ETHTOOL_A_LINKMODES_RATE_MATCHING, req->rate_matching);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== ETHTOOL_MSG_LINKSTATE_GET ============== */
> -/* ETHTOOL_MSG_LINKSTATE_GET - do */
> -void ethtool_linkstate_get_req_free(struct ethtool_linkstate_get_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	free(req);
> -}
> -
> -void ethtool_linkstate_get_rsp_free(struct ethtool_linkstate_get_rsp *rsp)
> -{
> -	ethtool_header_free(&rsp->header);
> -	free(rsp);
> -}
> -
> -int ethtool_linkstate_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct ethtool_linkstate_get_rsp *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -
> -	dst = yarg->data;
> -	parg.ys = yarg->ys;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_LINKSTATE_HEADER) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.header = 1;
> -
> -			parg.rsp_policy = &ethtool_header_nest;
> -			parg.data = &dst->header;
> -			if (ethtool_header_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_LINKSTATE_LINK) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.link = 1;
> -			dst->link = mnl_attr_get_u8(attr);
> -		} else if (type == ETHTOOL_A_LINKSTATE_SQI) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.sqi = 1;
> -			dst->sqi = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_LINKSTATE_SQI_MAX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.sqi_max = 1;
> -			dst->sqi_max = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_LINKSTATE_EXT_STATE) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.ext_state = 1;
> -			dst->ext_state = mnl_attr_get_u8(attr);
> -		} else if (type == ETHTOOL_A_LINKSTATE_EXT_SUBSTATE) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.ext_substate = 1;
> -			dst->ext_substate = mnl_attr_get_u8(attr);
> -		} else if (type == ETHTOOL_A_LINKSTATE_EXT_DOWN_CNT) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.ext_down_cnt = 1;
> -			dst->ext_down_cnt = mnl_attr_get_u32(attr);
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct ethtool_linkstate_get_rsp *
> -ethtool_linkstate_get(struct ynl_sock *ys,
> -		      struct ethtool_linkstate_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct ethtool_linkstate_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_LINKSTATE_GET, 1);
> -	ys->req_policy = &ethtool_linkstate_nest;
> -	yrs.yarg.rsp_policy = &ethtool_linkstate_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_LINKSTATE_HEADER, &req->header);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = ethtool_linkstate_get_rsp_parse;
> -	yrs.rsp_cmd = ETHTOOL_MSG_LINKSTATE_GET;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	ethtool_linkstate_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* ETHTOOL_MSG_LINKSTATE_GET - dump */
> -void ethtool_linkstate_get_list_free(struct ethtool_linkstate_get_list *rsp)
> -{
> -	struct ethtool_linkstate_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		ethtool_header_free(&rsp->obj.header);
> -		free(rsp);
> -	}
> -}
> -
> -struct ethtool_linkstate_get_list *
> -ethtool_linkstate_get_dump(struct ynl_sock *ys,
> -			   struct ethtool_linkstate_get_req_dump *req)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct ethtool_linkstate_get_list);
> -	yds.cb = ethtool_linkstate_get_rsp_parse;
> -	yds.rsp_cmd = ETHTOOL_MSG_LINKSTATE_GET;
> -	yds.rsp_policy = &ethtool_linkstate_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, ETHTOOL_MSG_LINKSTATE_GET, 1);
> -	ys->req_policy = &ethtool_linkstate_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_LINKSTATE_HEADER, &req->header);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	ethtool_linkstate_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ============== ETHTOOL_MSG_DEBUG_GET ============== */
> -/* ETHTOOL_MSG_DEBUG_GET - do */
> -void ethtool_debug_get_req_free(struct ethtool_debug_get_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	free(req);
> -}
> -
> -void ethtool_debug_get_rsp_free(struct ethtool_debug_get_rsp *rsp)
> -{
> -	ethtool_header_free(&rsp->header);
> -	ethtool_bitset_free(&rsp->msgmask);
> -	free(rsp);
> -}
> -
> -int ethtool_debug_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct ethtool_debug_get_rsp *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -
> -	dst = yarg->data;
> -	parg.ys = yarg->ys;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_DEBUG_HEADER) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.header = 1;
> -
> -			parg.rsp_policy = &ethtool_header_nest;
> -			parg.data = &dst->header;
> -			if (ethtool_header_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_DEBUG_MSGMASK) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.msgmask = 1;
> -
> -			parg.rsp_policy = &ethtool_bitset_nest;
> -			parg.data = &dst->msgmask;
> -			if (ethtool_bitset_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct ethtool_debug_get_rsp *
> -ethtool_debug_get(struct ynl_sock *ys, struct ethtool_debug_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct ethtool_debug_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_DEBUG_GET, 1);
> -	ys->req_policy = &ethtool_debug_nest;
> -	yrs.yarg.rsp_policy = &ethtool_debug_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_DEBUG_HEADER, &req->header);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = ethtool_debug_get_rsp_parse;
> -	yrs.rsp_cmd = ETHTOOL_MSG_DEBUG_GET;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	ethtool_debug_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* ETHTOOL_MSG_DEBUG_GET - dump */
> -void ethtool_debug_get_list_free(struct ethtool_debug_get_list *rsp)
> -{
> -	struct ethtool_debug_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		ethtool_header_free(&rsp->obj.header);
> -		ethtool_bitset_free(&rsp->obj.msgmask);
> -		free(rsp);
> -	}
> -}
> -
> -struct ethtool_debug_get_list *
> -ethtool_debug_get_dump(struct ynl_sock *ys,
> -		       struct ethtool_debug_get_req_dump *req)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct ethtool_debug_get_list);
> -	yds.cb = ethtool_debug_get_rsp_parse;
> -	yds.rsp_cmd = ETHTOOL_MSG_DEBUG_GET;
> -	yds.rsp_policy = &ethtool_debug_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, ETHTOOL_MSG_DEBUG_GET, 1);
> -	ys->req_policy = &ethtool_debug_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_DEBUG_HEADER, &req->header);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	ethtool_debug_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ETHTOOL_MSG_DEBUG_GET - notify */
> -void ethtool_debug_get_ntf_free(struct ethtool_debug_get_ntf *rsp)
> -{
> -	ethtool_header_free(&rsp->obj.header);
> -	ethtool_bitset_free(&rsp->obj.msgmask);
> -	free(rsp);
> -}
> -
> -/* ============== ETHTOOL_MSG_DEBUG_SET ============== */
> -/* ETHTOOL_MSG_DEBUG_SET - do */
> -void ethtool_debug_set_req_free(struct ethtool_debug_set_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	ethtool_bitset_free(&req->msgmask);
> -	free(req);
> -}
> -
> -int ethtool_debug_set(struct ynl_sock *ys, struct ethtool_debug_set_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_DEBUG_SET, 1);
> -	ys->req_policy = &ethtool_debug_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_DEBUG_HEADER, &req->header);
> -	if (req->_present.msgmask)
> -		ethtool_bitset_put(nlh, ETHTOOL_A_DEBUG_MSGMASK, &req->msgmask);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== ETHTOOL_MSG_WOL_GET ============== */
> -/* ETHTOOL_MSG_WOL_GET - do */
> -void ethtool_wol_get_req_free(struct ethtool_wol_get_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	free(req);
> -}
> -
> -void ethtool_wol_get_rsp_free(struct ethtool_wol_get_rsp *rsp)
> -{
> -	ethtool_header_free(&rsp->header);
> -	ethtool_bitset_free(&rsp->modes);
> -	free(rsp->sopass);
> -	free(rsp);
> -}
> -
> -int ethtool_wol_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct ynl_parse_arg *yarg = data;
> -	struct ethtool_wol_get_rsp *dst;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -
> -	dst = yarg->data;
> -	parg.ys = yarg->ys;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_WOL_HEADER) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.header = 1;
> -
> -			parg.rsp_policy = &ethtool_header_nest;
> -			parg.data = &dst->header;
> -			if (ethtool_header_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_WOL_MODES) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.modes = 1;
> -
> -			parg.rsp_policy = &ethtool_bitset_nest;
> -			parg.data = &dst->modes;
> -			if (ethtool_bitset_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_WOL_SOPASS) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = mnl_attr_get_payload_len(attr);
> -			dst->_present.sopass_len = len;
> -			dst->sopass = malloc(len);
> -			memcpy(dst->sopass, mnl_attr_get_payload(attr), len);
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct ethtool_wol_get_rsp *
> -ethtool_wol_get(struct ynl_sock *ys, struct ethtool_wol_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct ethtool_wol_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_WOL_GET, 1);
> -	ys->req_policy = &ethtool_wol_nest;
> -	yrs.yarg.rsp_policy = &ethtool_wol_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_WOL_HEADER, &req->header);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = ethtool_wol_get_rsp_parse;
> -	yrs.rsp_cmd = ETHTOOL_MSG_WOL_GET;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	ethtool_wol_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* ETHTOOL_MSG_WOL_GET - dump */
> -void ethtool_wol_get_list_free(struct ethtool_wol_get_list *rsp)
> -{
> -	struct ethtool_wol_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		ethtool_header_free(&rsp->obj.header);
> -		ethtool_bitset_free(&rsp->obj.modes);
> -		free(rsp->obj.sopass);
> -		free(rsp);
> -	}
> -}
> -
> -struct ethtool_wol_get_list *
> -ethtool_wol_get_dump(struct ynl_sock *ys, struct ethtool_wol_get_req_dump *req)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct ethtool_wol_get_list);
> -	yds.cb = ethtool_wol_get_rsp_parse;
> -	yds.rsp_cmd = ETHTOOL_MSG_WOL_GET;
> -	yds.rsp_policy = &ethtool_wol_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, ETHTOOL_MSG_WOL_GET, 1);
> -	ys->req_policy = &ethtool_wol_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_WOL_HEADER, &req->header);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	ethtool_wol_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ETHTOOL_MSG_WOL_GET - notify */
> -void ethtool_wol_get_ntf_free(struct ethtool_wol_get_ntf *rsp)
> -{
> -	ethtool_header_free(&rsp->obj.header);
> -	ethtool_bitset_free(&rsp->obj.modes);
> -	free(rsp->obj.sopass);
> -	free(rsp);
> -}
> -
> -/* ============== ETHTOOL_MSG_WOL_SET ============== */
> -/* ETHTOOL_MSG_WOL_SET - do */
> -void ethtool_wol_set_req_free(struct ethtool_wol_set_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	ethtool_bitset_free(&req->modes);
> -	free(req->sopass);
> -	free(req);
> -}
> -
> -int ethtool_wol_set(struct ynl_sock *ys, struct ethtool_wol_set_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_WOL_SET, 1);
> -	ys->req_policy = &ethtool_wol_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_WOL_HEADER, &req->header);
> -	if (req->_present.modes)
> -		ethtool_bitset_put(nlh, ETHTOOL_A_WOL_MODES, &req->modes);
> -	if (req->_present.sopass_len)
> -		mnl_attr_put(nlh, ETHTOOL_A_WOL_SOPASS, req->_present.sopass_len, req->sopass);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== ETHTOOL_MSG_FEATURES_GET ============== */
> -/* ETHTOOL_MSG_FEATURES_GET - do */
> -void ethtool_features_get_req_free(struct ethtool_features_get_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	free(req);
> -}
> -
> -void ethtool_features_get_rsp_free(struct ethtool_features_get_rsp *rsp)
> -{
> -	ethtool_header_free(&rsp->header);
> -	ethtool_bitset_free(&rsp->hw);
> -	ethtool_bitset_free(&rsp->wanted);
> -	ethtool_bitset_free(&rsp->active);
> -	ethtool_bitset_free(&rsp->nochange);
> -	free(rsp);
> -}
> -
> -int ethtool_features_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct ethtool_features_get_rsp *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -
> -	dst = yarg->data;
> -	parg.ys = yarg->ys;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_FEATURES_HEADER) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.header = 1;
> -
> -			parg.rsp_policy = &ethtool_header_nest;
> -			parg.data = &dst->header;
> -			if (ethtool_header_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_FEATURES_HW) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.hw = 1;
> -
> -			parg.rsp_policy = &ethtool_bitset_nest;
> -			parg.data = &dst->hw;
> -			if (ethtool_bitset_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_FEATURES_WANTED) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.wanted = 1;
> -
> -			parg.rsp_policy = &ethtool_bitset_nest;
> -			parg.data = &dst->wanted;
> -			if (ethtool_bitset_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_FEATURES_ACTIVE) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.active = 1;
> -
> -			parg.rsp_policy = &ethtool_bitset_nest;
> -			parg.data = &dst->active;
> -			if (ethtool_bitset_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_FEATURES_NOCHANGE) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.nochange = 1;
> -
> -			parg.rsp_policy = &ethtool_bitset_nest;
> -			parg.data = &dst->nochange;
> -			if (ethtool_bitset_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct ethtool_features_get_rsp *
> -ethtool_features_get(struct ynl_sock *ys, struct ethtool_features_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct ethtool_features_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_FEATURES_GET, 1);
> -	ys->req_policy = &ethtool_features_nest;
> -	yrs.yarg.rsp_policy = &ethtool_features_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_FEATURES_HEADER, &req->header);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = ethtool_features_get_rsp_parse;
> -	yrs.rsp_cmd = ETHTOOL_MSG_FEATURES_GET;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	ethtool_features_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* ETHTOOL_MSG_FEATURES_GET - dump */
> -void ethtool_features_get_list_free(struct ethtool_features_get_list *rsp)
> -{
> -	struct ethtool_features_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		ethtool_header_free(&rsp->obj.header);
> -		ethtool_bitset_free(&rsp->obj.hw);
> -		ethtool_bitset_free(&rsp->obj.wanted);
> -		ethtool_bitset_free(&rsp->obj.active);
> -		ethtool_bitset_free(&rsp->obj.nochange);
> -		free(rsp);
> -	}
> -}
> -
> -struct ethtool_features_get_list *
> -ethtool_features_get_dump(struct ynl_sock *ys,
> -			  struct ethtool_features_get_req_dump *req)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct ethtool_features_get_list);
> -	yds.cb = ethtool_features_get_rsp_parse;
> -	yds.rsp_cmd = ETHTOOL_MSG_FEATURES_GET;
> -	yds.rsp_policy = &ethtool_features_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, ETHTOOL_MSG_FEATURES_GET, 1);
> -	ys->req_policy = &ethtool_features_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_FEATURES_HEADER, &req->header);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	ethtool_features_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ETHTOOL_MSG_FEATURES_GET - notify */
> -void ethtool_features_get_ntf_free(struct ethtool_features_get_ntf *rsp)
> -{
> -	ethtool_header_free(&rsp->obj.header);
> -	ethtool_bitset_free(&rsp->obj.hw);
> -	ethtool_bitset_free(&rsp->obj.wanted);
> -	ethtool_bitset_free(&rsp->obj.active);
> -	ethtool_bitset_free(&rsp->obj.nochange);
> -	free(rsp);
> -}
> -
> -/* ============== ETHTOOL_MSG_FEATURES_SET ============== */
> -/* ETHTOOL_MSG_FEATURES_SET - do */
> -void ethtool_features_set_req_free(struct ethtool_features_set_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	ethtool_bitset_free(&req->hw);
> -	ethtool_bitset_free(&req->wanted);
> -	ethtool_bitset_free(&req->active);
> -	ethtool_bitset_free(&req->nochange);
> -	free(req);
> -}
> -
> -void ethtool_features_set_rsp_free(struct ethtool_features_set_rsp *rsp)
> -{
> -	ethtool_header_free(&rsp->header);
> -	ethtool_bitset_free(&rsp->hw);
> -	ethtool_bitset_free(&rsp->wanted);
> -	ethtool_bitset_free(&rsp->active);
> -	ethtool_bitset_free(&rsp->nochange);
> -	free(rsp);
> -}
> -
> -int ethtool_features_set_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct ethtool_features_set_rsp *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -
> -	dst = yarg->data;
> -	parg.ys = yarg->ys;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_FEATURES_HEADER) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.header = 1;
> -
> -			parg.rsp_policy = &ethtool_header_nest;
> -			parg.data = &dst->header;
> -			if (ethtool_header_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_FEATURES_HW) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.hw = 1;
> -
> -			parg.rsp_policy = &ethtool_bitset_nest;
> -			parg.data = &dst->hw;
> -			if (ethtool_bitset_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_FEATURES_WANTED) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.wanted = 1;
> -
> -			parg.rsp_policy = &ethtool_bitset_nest;
> -			parg.data = &dst->wanted;
> -			if (ethtool_bitset_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_FEATURES_ACTIVE) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.active = 1;
> -
> -			parg.rsp_policy = &ethtool_bitset_nest;
> -			parg.data = &dst->active;
> -			if (ethtool_bitset_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_FEATURES_NOCHANGE) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.nochange = 1;
> -
> -			parg.rsp_policy = &ethtool_bitset_nest;
> -			parg.data = &dst->nochange;
> -			if (ethtool_bitset_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct ethtool_features_set_rsp *
> -ethtool_features_set(struct ynl_sock *ys, struct ethtool_features_set_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct ethtool_features_set_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_FEATURES_SET, 1);
> -	ys->req_policy = &ethtool_features_nest;
> -	yrs.yarg.rsp_policy = &ethtool_features_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_FEATURES_HEADER, &req->header);
> -	if (req->_present.hw)
> -		ethtool_bitset_put(nlh, ETHTOOL_A_FEATURES_HW, &req->hw);
> -	if (req->_present.wanted)
> -		ethtool_bitset_put(nlh, ETHTOOL_A_FEATURES_WANTED, &req->wanted);
> -	if (req->_present.active)
> -		ethtool_bitset_put(nlh, ETHTOOL_A_FEATURES_ACTIVE, &req->active);
> -	if (req->_present.nochange)
> -		ethtool_bitset_put(nlh, ETHTOOL_A_FEATURES_NOCHANGE, &req->nochange);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = ethtool_features_set_rsp_parse;
> -	yrs.rsp_cmd = ETHTOOL_MSG_FEATURES_SET;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	ethtool_features_set_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* ============== ETHTOOL_MSG_PRIVFLAGS_GET ============== */
> -/* ETHTOOL_MSG_PRIVFLAGS_GET - do */
> -void ethtool_privflags_get_req_free(struct ethtool_privflags_get_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	free(req);
> -}
> -
> -void ethtool_privflags_get_rsp_free(struct ethtool_privflags_get_rsp *rsp)
> -{
> -	ethtool_header_free(&rsp->header);
> -	ethtool_bitset_free(&rsp->flags);
> -	free(rsp);
> -}
> -
> -int ethtool_privflags_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct ethtool_privflags_get_rsp *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -
> -	dst = yarg->data;
> -	parg.ys = yarg->ys;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_PRIVFLAGS_HEADER) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.header = 1;
> -
> -			parg.rsp_policy = &ethtool_header_nest;
> -			parg.data = &dst->header;
> -			if (ethtool_header_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_PRIVFLAGS_FLAGS) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.flags = 1;
> -
> -			parg.rsp_policy = &ethtool_bitset_nest;
> -			parg.data = &dst->flags;
> -			if (ethtool_bitset_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct ethtool_privflags_get_rsp *
> -ethtool_privflags_get(struct ynl_sock *ys,
> -		      struct ethtool_privflags_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct ethtool_privflags_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_PRIVFLAGS_GET, 1);
> -	ys->req_policy = &ethtool_privflags_nest;
> -	yrs.yarg.rsp_policy = &ethtool_privflags_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_PRIVFLAGS_HEADER, &req->header);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = ethtool_privflags_get_rsp_parse;
> -	yrs.rsp_cmd = 14;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	ethtool_privflags_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* ETHTOOL_MSG_PRIVFLAGS_GET - dump */
> -void ethtool_privflags_get_list_free(struct ethtool_privflags_get_list *rsp)
> -{
> -	struct ethtool_privflags_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		ethtool_header_free(&rsp->obj.header);
> -		ethtool_bitset_free(&rsp->obj.flags);
> -		free(rsp);
> -	}
> -}
> -
> -struct ethtool_privflags_get_list *
> -ethtool_privflags_get_dump(struct ynl_sock *ys,
> -			   struct ethtool_privflags_get_req_dump *req)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct ethtool_privflags_get_list);
> -	yds.cb = ethtool_privflags_get_rsp_parse;
> -	yds.rsp_cmd = 14;
> -	yds.rsp_policy = &ethtool_privflags_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, ETHTOOL_MSG_PRIVFLAGS_GET, 1);
> -	ys->req_policy = &ethtool_privflags_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_PRIVFLAGS_HEADER, &req->header);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	ethtool_privflags_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ETHTOOL_MSG_PRIVFLAGS_GET - notify */
> -void ethtool_privflags_get_ntf_free(struct ethtool_privflags_get_ntf *rsp)
> -{
> -	ethtool_header_free(&rsp->obj.header);
> -	ethtool_bitset_free(&rsp->obj.flags);
> -	free(rsp);
> -}
> -
> -/* ============== ETHTOOL_MSG_PRIVFLAGS_SET ============== */
> -/* ETHTOOL_MSG_PRIVFLAGS_SET - do */
> -void ethtool_privflags_set_req_free(struct ethtool_privflags_set_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	ethtool_bitset_free(&req->flags);
> -	free(req);
> -}
> -
> -int ethtool_privflags_set(struct ynl_sock *ys,
> -			  struct ethtool_privflags_set_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_PRIVFLAGS_SET, 1);
> -	ys->req_policy = &ethtool_privflags_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_PRIVFLAGS_HEADER, &req->header);
> -	if (req->_present.flags)
> -		ethtool_bitset_put(nlh, ETHTOOL_A_PRIVFLAGS_FLAGS, &req->flags);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== ETHTOOL_MSG_RINGS_GET ============== */
> -/* ETHTOOL_MSG_RINGS_GET - do */
> -void ethtool_rings_get_req_free(struct ethtool_rings_get_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	free(req);
> -}
> -
> -void ethtool_rings_get_rsp_free(struct ethtool_rings_get_rsp *rsp)
> -{
> -	ethtool_header_free(&rsp->header);
> -	free(rsp);
> -}
> -
> -int ethtool_rings_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct ethtool_rings_get_rsp *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -
> -	dst = yarg->data;
> -	parg.ys = yarg->ys;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_RINGS_HEADER) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.header = 1;
> -
> -			parg.rsp_policy = &ethtool_header_nest;
> -			parg.data = &dst->header;
> -			if (ethtool_header_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_RINGS_RX_MAX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.rx_max = 1;
> -			dst->rx_max = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_RINGS_RX_MINI_MAX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.rx_mini_max = 1;
> -			dst->rx_mini_max = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_RINGS_RX_JUMBO_MAX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.rx_jumbo_max = 1;
> -			dst->rx_jumbo_max = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_RINGS_TX_MAX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.tx_max = 1;
> -			dst->tx_max = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_RINGS_RX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.rx = 1;
> -			dst->rx = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_RINGS_RX_MINI) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.rx_mini = 1;
> -			dst->rx_mini = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_RINGS_RX_JUMBO) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.rx_jumbo = 1;
> -			dst->rx_jumbo = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_RINGS_TX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.tx = 1;
> -			dst->tx = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_RINGS_RX_BUF_LEN) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.rx_buf_len = 1;
> -			dst->rx_buf_len = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_RINGS_TCP_DATA_SPLIT) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.tcp_data_split = 1;
> -			dst->tcp_data_split = mnl_attr_get_u8(attr);
> -		} else if (type == ETHTOOL_A_RINGS_CQE_SIZE) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.cqe_size = 1;
> -			dst->cqe_size = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_RINGS_TX_PUSH) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.tx_push = 1;
> -			dst->tx_push = mnl_attr_get_u8(attr);
> -		} else if (type == ETHTOOL_A_RINGS_RX_PUSH) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.rx_push = 1;
> -			dst->rx_push = mnl_attr_get_u8(attr);
> -		} else if (type == ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.tx_push_buf_len = 1;
> -			dst->tx_push_buf_len = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.tx_push_buf_len_max = 1;
> -			dst->tx_push_buf_len_max = mnl_attr_get_u32(attr);
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct ethtool_rings_get_rsp *
> -ethtool_rings_get(struct ynl_sock *ys, struct ethtool_rings_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct ethtool_rings_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_RINGS_GET, 1);
> -	ys->req_policy = &ethtool_rings_nest;
> -	yrs.yarg.rsp_policy = &ethtool_rings_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_RINGS_HEADER, &req->header);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = ethtool_rings_get_rsp_parse;
> -	yrs.rsp_cmd = 16;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	ethtool_rings_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* ETHTOOL_MSG_RINGS_GET - dump */
> -void ethtool_rings_get_list_free(struct ethtool_rings_get_list *rsp)
> -{
> -	struct ethtool_rings_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		ethtool_header_free(&rsp->obj.header);
> -		free(rsp);
> -	}
> -}
> -
> -struct ethtool_rings_get_list *
> -ethtool_rings_get_dump(struct ynl_sock *ys,
> -		       struct ethtool_rings_get_req_dump *req)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct ethtool_rings_get_list);
> -	yds.cb = ethtool_rings_get_rsp_parse;
> -	yds.rsp_cmd = 16;
> -	yds.rsp_policy = &ethtool_rings_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, ETHTOOL_MSG_RINGS_GET, 1);
> -	ys->req_policy = &ethtool_rings_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_RINGS_HEADER, &req->header);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	ethtool_rings_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ETHTOOL_MSG_RINGS_GET - notify */
> -void ethtool_rings_get_ntf_free(struct ethtool_rings_get_ntf *rsp)
> -{
> -	ethtool_header_free(&rsp->obj.header);
> -	free(rsp);
> -}
> -
> -/* ============== ETHTOOL_MSG_RINGS_SET ============== */
> -/* ETHTOOL_MSG_RINGS_SET - do */
> -void ethtool_rings_set_req_free(struct ethtool_rings_set_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	free(req);
> -}
> -
> -int ethtool_rings_set(struct ynl_sock *ys, struct ethtool_rings_set_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_RINGS_SET, 1);
> -	ys->req_policy = &ethtool_rings_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_RINGS_HEADER, &req->header);
> -	if (req->_present.rx_max)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_RINGS_RX_MAX, req->rx_max);
> -	if (req->_present.rx_mini_max)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_RINGS_RX_MINI_MAX, req->rx_mini_max);
> -	if (req->_present.rx_jumbo_max)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_RINGS_RX_JUMBO_MAX, req->rx_jumbo_max);
> -	if (req->_present.tx_max)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_RINGS_TX_MAX, req->tx_max);
> -	if (req->_present.rx)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_RINGS_RX, req->rx);
> -	if (req->_present.rx_mini)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_RINGS_RX_MINI, req->rx_mini);
> -	if (req->_present.rx_jumbo)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_RINGS_RX_JUMBO, req->rx_jumbo);
> -	if (req->_present.tx)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_RINGS_TX, req->tx);
> -	if (req->_present.rx_buf_len)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_RINGS_RX_BUF_LEN, req->rx_buf_len);
> -	if (req->_present.tcp_data_split)
> -		mnl_attr_put_u8(nlh, ETHTOOL_A_RINGS_TCP_DATA_SPLIT, req->tcp_data_split);
> -	if (req->_present.cqe_size)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_RINGS_CQE_SIZE, req->cqe_size);
> -	if (req->_present.tx_push)
> -		mnl_attr_put_u8(nlh, ETHTOOL_A_RINGS_TX_PUSH, req->tx_push);
> -	if (req->_present.rx_push)
> -		mnl_attr_put_u8(nlh, ETHTOOL_A_RINGS_RX_PUSH, req->rx_push);
> -	if (req->_present.tx_push_buf_len)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN, req->tx_push_buf_len);
> -	if (req->_present.tx_push_buf_len_max)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX, req->tx_push_buf_len_max);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== ETHTOOL_MSG_CHANNELS_GET ============== */
> -/* ETHTOOL_MSG_CHANNELS_GET - do */
> -void ethtool_channels_get_req_free(struct ethtool_channels_get_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	free(req);
> -}
> -
> -void ethtool_channels_get_rsp_free(struct ethtool_channels_get_rsp *rsp)
> -{
> -	ethtool_header_free(&rsp->header);
> -	free(rsp);
> -}
> -
> -int ethtool_channels_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct ethtool_channels_get_rsp *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -
> -	dst = yarg->data;
> -	parg.ys = yarg->ys;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_CHANNELS_HEADER) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.header = 1;
> -
> -			parg.rsp_policy = &ethtool_header_nest;
> -			parg.data = &dst->header;
> -			if (ethtool_header_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_CHANNELS_RX_MAX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.rx_max = 1;
> -			dst->rx_max = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_CHANNELS_TX_MAX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.tx_max = 1;
> -			dst->tx_max = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_CHANNELS_OTHER_MAX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.other_max = 1;
> -			dst->other_max = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_CHANNELS_COMBINED_MAX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.combined_max = 1;
> -			dst->combined_max = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_CHANNELS_RX_COUNT) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.rx_count = 1;
> -			dst->rx_count = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_CHANNELS_TX_COUNT) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.tx_count = 1;
> -			dst->tx_count = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_CHANNELS_OTHER_COUNT) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.other_count = 1;
> -			dst->other_count = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_CHANNELS_COMBINED_COUNT) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.combined_count = 1;
> -			dst->combined_count = mnl_attr_get_u32(attr);
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct ethtool_channels_get_rsp *
> -ethtool_channels_get(struct ynl_sock *ys, struct ethtool_channels_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct ethtool_channels_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_CHANNELS_GET, 1);
> -	ys->req_policy = &ethtool_channels_nest;
> -	yrs.yarg.rsp_policy = &ethtool_channels_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_CHANNELS_HEADER, &req->header);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = ethtool_channels_get_rsp_parse;
> -	yrs.rsp_cmd = 18;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	ethtool_channels_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* ETHTOOL_MSG_CHANNELS_GET - dump */
> -void ethtool_channels_get_list_free(struct ethtool_channels_get_list *rsp)
> -{
> -	struct ethtool_channels_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		ethtool_header_free(&rsp->obj.header);
> -		free(rsp);
> -	}
> -}
> -
> -struct ethtool_channels_get_list *
> -ethtool_channels_get_dump(struct ynl_sock *ys,
> -			  struct ethtool_channels_get_req_dump *req)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct ethtool_channels_get_list);
> -	yds.cb = ethtool_channels_get_rsp_parse;
> -	yds.rsp_cmd = 18;
> -	yds.rsp_policy = &ethtool_channels_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, ETHTOOL_MSG_CHANNELS_GET, 1);
> -	ys->req_policy = &ethtool_channels_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_CHANNELS_HEADER, &req->header);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	ethtool_channels_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ETHTOOL_MSG_CHANNELS_GET - notify */
> -void ethtool_channels_get_ntf_free(struct ethtool_channels_get_ntf *rsp)
> -{
> -	ethtool_header_free(&rsp->obj.header);
> -	free(rsp);
> -}
> -
> -/* ============== ETHTOOL_MSG_CHANNELS_SET ============== */
> -/* ETHTOOL_MSG_CHANNELS_SET - do */
> -void ethtool_channels_set_req_free(struct ethtool_channels_set_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	free(req);
> -}
> -
> -int ethtool_channels_set(struct ynl_sock *ys,
> -			 struct ethtool_channels_set_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_CHANNELS_SET, 1);
> -	ys->req_policy = &ethtool_channels_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_CHANNELS_HEADER, &req->header);
> -	if (req->_present.rx_max)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_CHANNELS_RX_MAX, req->rx_max);
> -	if (req->_present.tx_max)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_CHANNELS_TX_MAX, req->tx_max);
> -	if (req->_present.other_max)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_CHANNELS_OTHER_MAX, req->other_max);
> -	if (req->_present.combined_max)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_CHANNELS_COMBINED_MAX, req->combined_max);
> -	if (req->_present.rx_count)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_CHANNELS_RX_COUNT, req->rx_count);
> -	if (req->_present.tx_count)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_CHANNELS_TX_COUNT, req->tx_count);
> -	if (req->_present.other_count)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_CHANNELS_OTHER_COUNT, req->other_count);
> -	if (req->_present.combined_count)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_CHANNELS_COMBINED_COUNT, req->combined_count);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== ETHTOOL_MSG_COALESCE_GET ============== */
> -/* ETHTOOL_MSG_COALESCE_GET - do */
> -void ethtool_coalesce_get_req_free(struct ethtool_coalesce_get_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	free(req);
> -}
> -
> -void ethtool_coalesce_get_rsp_free(struct ethtool_coalesce_get_rsp *rsp)
> -{
> -	ethtool_header_free(&rsp->header);
> -	free(rsp);
> -}
> -
> -int ethtool_coalesce_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct ethtool_coalesce_get_rsp *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -
> -	dst = yarg->data;
> -	parg.ys = yarg->ys;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_COALESCE_HEADER) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.header = 1;
> -
> -			parg.rsp_policy = &ethtool_header_nest;
> -			parg.data = &dst->header;
> -			if (ethtool_header_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_COALESCE_RX_USECS) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.rx_usecs = 1;
> -			dst->rx_usecs = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_COALESCE_RX_MAX_FRAMES) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.rx_max_frames = 1;
> -			dst->rx_max_frames = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_COALESCE_RX_USECS_IRQ) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.rx_usecs_irq = 1;
> -			dst->rx_usecs_irq = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_COALESCE_RX_MAX_FRAMES_IRQ) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.rx_max_frames_irq = 1;
> -			dst->rx_max_frames_irq = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_COALESCE_TX_USECS) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.tx_usecs = 1;
> -			dst->tx_usecs = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_COALESCE_TX_MAX_FRAMES) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.tx_max_frames = 1;
> -			dst->tx_max_frames = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_COALESCE_TX_USECS_IRQ) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.tx_usecs_irq = 1;
> -			dst->tx_usecs_irq = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_COALESCE_TX_MAX_FRAMES_IRQ) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.tx_max_frames_irq = 1;
> -			dst->tx_max_frames_irq = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_COALESCE_STATS_BLOCK_USECS) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.stats_block_usecs = 1;
> -			dst->stats_block_usecs = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_COALESCE_USE_ADAPTIVE_RX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.use_adaptive_rx = 1;
> -			dst->use_adaptive_rx = mnl_attr_get_u8(attr);
> -		} else if (type == ETHTOOL_A_COALESCE_USE_ADAPTIVE_TX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.use_adaptive_tx = 1;
> -			dst->use_adaptive_tx = mnl_attr_get_u8(attr);
> -		} else if (type == ETHTOOL_A_COALESCE_PKT_RATE_LOW) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.pkt_rate_low = 1;
> -			dst->pkt_rate_low = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_COALESCE_RX_USECS_LOW) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.rx_usecs_low = 1;
> -			dst->rx_usecs_low = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_COALESCE_RX_MAX_FRAMES_LOW) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.rx_max_frames_low = 1;
> -			dst->rx_max_frames_low = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_COALESCE_TX_USECS_LOW) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.tx_usecs_low = 1;
> -			dst->tx_usecs_low = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_COALESCE_TX_MAX_FRAMES_LOW) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.tx_max_frames_low = 1;
> -			dst->tx_max_frames_low = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_COALESCE_PKT_RATE_HIGH) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.pkt_rate_high = 1;
> -			dst->pkt_rate_high = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_COALESCE_RX_USECS_HIGH) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.rx_usecs_high = 1;
> -			dst->rx_usecs_high = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_COALESCE_RX_MAX_FRAMES_HIGH) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.rx_max_frames_high = 1;
> -			dst->rx_max_frames_high = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_COALESCE_TX_USECS_HIGH) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.tx_usecs_high = 1;
> -			dst->tx_usecs_high = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_COALESCE_TX_MAX_FRAMES_HIGH) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.tx_max_frames_high = 1;
> -			dst->tx_max_frames_high = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_COALESCE_RATE_SAMPLE_INTERVAL) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.rate_sample_interval = 1;
> -			dst->rate_sample_interval = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_COALESCE_USE_CQE_MODE_TX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.use_cqe_mode_tx = 1;
> -			dst->use_cqe_mode_tx = mnl_attr_get_u8(attr);
> -		} else if (type == ETHTOOL_A_COALESCE_USE_CQE_MODE_RX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.use_cqe_mode_rx = 1;
> -			dst->use_cqe_mode_rx = mnl_attr_get_u8(attr);
> -		} else if (type == ETHTOOL_A_COALESCE_TX_AGGR_MAX_BYTES) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.tx_aggr_max_bytes = 1;
> -			dst->tx_aggr_max_bytes = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.tx_aggr_max_frames = 1;
> -			dst->tx_aggr_max_frames = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.tx_aggr_time_usecs = 1;
> -			dst->tx_aggr_time_usecs = mnl_attr_get_u32(attr);
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct ethtool_coalesce_get_rsp *
> -ethtool_coalesce_get(struct ynl_sock *ys, struct ethtool_coalesce_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct ethtool_coalesce_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_COALESCE_GET, 1);
> -	ys->req_policy = &ethtool_coalesce_nest;
> -	yrs.yarg.rsp_policy = &ethtool_coalesce_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_COALESCE_HEADER, &req->header);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = ethtool_coalesce_get_rsp_parse;
> -	yrs.rsp_cmd = 20;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	ethtool_coalesce_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* ETHTOOL_MSG_COALESCE_GET - dump */
> -void ethtool_coalesce_get_list_free(struct ethtool_coalesce_get_list *rsp)
> -{
> -	struct ethtool_coalesce_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		ethtool_header_free(&rsp->obj.header);
> -		free(rsp);
> -	}
> -}
> -
> -struct ethtool_coalesce_get_list *
> -ethtool_coalesce_get_dump(struct ynl_sock *ys,
> -			  struct ethtool_coalesce_get_req_dump *req)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct ethtool_coalesce_get_list);
> -	yds.cb = ethtool_coalesce_get_rsp_parse;
> -	yds.rsp_cmd = 20;
> -	yds.rsp_policy = &ethtool_coalesce_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, ETHTOOL_MSG_COALESCE_GET, 1);
> -	ys->req_policy = &ethtool_coalesce_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_COALESCE_HEADER, &req->header);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	ethtool_coalesce_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ETHTOOL_MSG_COALESCE_GET - notify */
> -void ethtool_coalesce_get_ntf_free(struct ethtool_coalesce_get_ntf *rsp)
> -{
> -	ethtool_header_free(&rsp->obj.header);
> -	free(rsp);
> -}
> -
> -/* ============== ETHTOOL_MSG_COALESCE_SET ============== */
> -/* ETHTOOL_MSG_COALESCE_SET - do */
> -void ethtool_coalesce_set_req_free(struct ethtool_coalesce_set_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	free(req);
> -}
> -
> -int ethtool_coalesce_set(struct ynl_sock *ys,
> -			 struct ethtool_coalesce_set_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_COALESCE_SET, 1);
> -	ys->req_policy = &ethtool_coalesce_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_COALESCE_HEADER, &req->header);
> -	if (req->_present.rx_usecs)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_COALESCE_RX_USECS, req->rx_usecs);
> -	if (req->_present.rx_max_frames)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_COALESCE_RX_MAX_FRAMES, req->rx_max_frames);
> -	if (req->_present.rx_usecs_irq)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_COALESCE_RX_USECS_IRQ, req->rx_usecs_irq);
> -	if (req->_present.rx_max_frames_irq)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_COALESCE_RX_MAX_FRAMES_IRQ, req->rx_max_frames_irq);
> -	if (req->_present.tx_usecs)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_COALESCE_TX_USECS, req->tx_usecs);
> -	if (req->_present.tx_max_frames)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_COALESCE_TX_MAX_FRAMES, req->tx_max_frames);
> -	if (req->_present.tx_usecs_irq)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_COALESCE_TX_USECS_IRQ, req->tx_usecs_irq);
> -	if (req->_present.tx_max_frames_irq)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_COALESCE_TX_MAX_FRAMES_IRQ, req->tx_max_frames_irq);
> -	if (req->_present.stats_block_usecs)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_COALESCE_STATS_BLOCK_USECS, req->stats_block_usecs);
> -	if (req->_present.use_adaptive_rx)
> -		mnl_attr_put_u8(nlh, ETHTOOL_A_COALESCE_USE_ADAPTIVE_RX, req->use_adaptive_rx);
> -	if (req->_present.use_adaptive_tx)
> -		mnl_attr_put_u8(nlh, ETHTOOL_A_COALESCE_USE_ADAPTIVE_TX, req->use_adaptive_tx);
> -	if (req->_present.pkt_rate_low)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_COALESCE_PKT_RATE_LOW, req->pkt_rate_low);
> -	if (req->_present.rx_usecs_low)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_COALESCE_RX_USECS_LOW, req->rx_usecs_low);
> -	if (req->_present.rx_max_frames_low)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_COALESCE_RX_MAX_FRAMES_LOW, req->rx_max_frames_low);
> -	if (req->_present.tx_usecs_low)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_COALESCE_TX_USECS_LOW, req->tx_usecs_low);
> -	if (req->_present.tx_max_frames_low)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_COALESCE_TX_MAX_FRAMES_LOW, req->tx_max_frames_low);
> -	if (req->_present.pkt_rate_high)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_COALESCE_PKT_RATE_HIGH, req->pkt_rate_high);
> -	if (req->_present.rx_usecs_high)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_COALESCE_RX_USECS_HIGH, req->rx_usecs_high);
> -	if (req->_present.rx_max_frames_high)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_COALESCE_RX_MAX_FRAMES_HIGH, req->rx_max_frames_high);
> -	if (req->_present.tx_usecs_high)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_COALESCE_TX_USECS_HIGH, req->tx_usecs_high);
> -	if (req->_present.tx_max_frames_high)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_COALESCE_TX_MAX_FRAMES_HIGH, req->tx_max_frames_high);
> -	if (req->_present.rate_sample_interval)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_COALESCE_RATE_SAMPLE_INTERVAL, req->rate_sample_interval);
> -	if (req->_present.use_cqe_mode_tx)
> -		mnl_attr_put_u8(nlh, ETHTOOL_A_COALESCE_USE_CQE_MODE_TX, req->use_cqe_mode_tx);
> -	if (req->_present.use_cqe_mode_rx)
> -		mnl_attr_put_u8(nlh, ETHTOOL_A_COALESCE_USE_CQE_MODE_RX, req->use_cqe_mode_rx);
> -	if (req->_present.tx_aggr_max_bytes)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_COALESCE_TX_AGGR_MAX_BYTES, req->tx_aggr_max_bytes);
> -	if (req->_present.tx_aggr_max_frames)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES, req->tx_aggr_max_frames);
> -	if (req->_present.tx_aggr_time_usecs)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS, req->tx_aggr_time_usecs);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== ETHTOOL_MSG_PAUSE_GET ============== */
> -/* ETHTOOL_MSG_PAUSE_GET - do */
> -void ethtool_pause_get_req_free(struct ethtool_pause_get_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	free(req);
> -}
> -
> -void ethtool_pause_get_rsp_free(struct ethtool_pause_get_rsp *rsp)
> -{
> -	ethtool_header_free(&rsp->header);
> -	ethtool_pause_stat_free(&rsp->stats);
> -	free(rsp);
> -}
> -
> -int ethtool_pause_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct ethtool_pause_get_rsp *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -
> -	dst = yarg->data;
> -	parg.ys = yarg->ys;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_PAUSE_HEADER) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.header = 1;
> -
> -			parg.rsp_policy = &ethtool_header_nest;
> -			parg.data = &dst->header;
> -			if (ethtool_header_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_PAUSE_AUTONEG) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.autoneg = 1;
> -			dst->autoneg = mnl_attr_get_u8(attr);
> -		} else if (type == ETHTOOL_A_PAUSE_RX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.rx = 1;
> -			dst->rx = mnl_attr_get_u8(attr);
> -		} else if (type == ETHTOOL_A_PAUSE_TX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.tx = 1;
> -			dst->tx = mnl_attr_get_u8(attr);
> -		} else if (type == ETHTOOL_A_PAUSE_STATS) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.stats = 1;
> -
> -			parg.rsp_policy = &ethtool_pause_stat_nest;
> -			parg.data = &dst->stats;
> -			if (ethtool_pause_stat_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_PAUSE_STATS_SRC) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.stats_src = 1;
> -			dst->stats_src = mnl_attr_get_u32(attr);
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct ethtool_pause_get_rsp *
> -ethtool_pause_get(struct ynl_sock *ys, struct ethtool_pause_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct ethtool_pause_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_PAUSE_GET, 1);
> -	ys->req_policy = &ethtool_pause_nest;
> -	yrs.yarg.rsp_policy = &ethtool_pause_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_PAUSE_HEADER, &req->header);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = ethtool_pause_get_rsp_parse;
> -	yrs.rsp_cmd = 22;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	ethtool_pause_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* ETHTOOL_MSG_PAUSE_GET - dump */
> -void ethtool_pause_get_list_free(struct ethtool_pause_get_list *rsp)
> -{
> -	struct ethtool_pause_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		ethtool_header_free(&rsp->obj.header);
> -		ethtool_pause_stat_free(&rsp->obj.stats);
> -		free(rsp);
> -	}
> -}
> -
> -struct ethtool_pause_get_list *
> -ethtool_pause_get_dump(struct ynl_sock *ys,
> -		       struct ethtool_pause_get_req_dump *req)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct ethtool_pause_get_list);
> -	yds.cb = ethtool_pause_get_rsp_parse;
> -	yds.rsp_cmd = 22;
> -	yds.rsp_policy = &ethtool_pause_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, ETHTOOL_MSG_PAUSE_GET, 1);
> -	ys->req_policy = &ethtool_pause_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_PAUSE_HEADER, &req->header);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	ethtool_pause_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ETHTOOL_MSG_PAUSE_GET - notify */
> -void ethtool_pause_get_ntf_free(struct ethtool_pause_get_ntf *rsp)
> -{
> -	ethtool_header_free(&rsp->obj.header);
> -	ethtool_pause_stat_free(&rsp->obj.stats);
> -	free(rsp);
> -}
> -
> -/* ============== ETHTOOL_MSG_PAUSE_SET ============== */
> -/* ETHTOOL_MSG_PAUSE_SET - do */
> -void ethtool_pause_set_req_free(struct ethtool_pause_set_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	ethtool_pause_stat_free(&req->stats);
> -	free(req);
> -}
> -
> -int ethtool_pause_set(struct ynl_sock *ys, struct ethtool_pause_set_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_PAUSE_SET, 1);
> -	ys->req_policy = &ethtool_pause_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_PAUSE_HEADER, &req->header);
> -	if (req->_present.autoneg)
> -		mnl_attr_put_u8(nlh, ETHTOOL_A_PAUSE_AUTONEG, req->autoneg);
> -	if (req->_present.rx)
> -		mnl_attr_put_u8(nlh, ETHTOOL_A_PAUSE_RX, req->rx);
> -	if (req->_present.tx)
> -		mnl_attr_put_u8(nlh, ETHTOOL_A_PAUSE_TX, req->tx);
> -	if (req->_present.stats)
> -		ethtool_pause_stat_put(nlh, ETHTOOL_A_PAUSE_STATS, &req->stats);
> -	if (req->_present.stats_src)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_PAUSE_STATS_SRC, req->stats_src);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== ETHTOOL_MSG_EEE_GET ============== */
> -/* ETHTOOL_MSG_EEE_GET - do */
> -void ethtool_eee_get_req_free(struct ethtool_eee_get_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	free(req);
> -}
> -
> -void ethtool_eee_get_rsp_free(struct ethtool_eee_get_rsp *rsp)
> -{
> -	ethtool_header_free(&rsp->header);
> -	ethtool_bitset_free(&rsp->modes_ours);
> -	ethtool_bitset_free(&rsp->modes_peer);
> -	free(rsp);
> -}
> -
> -int ethtool_eee_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct ynl_parse_arg *yarg = data;
> -	struct ethtool_eee_get_rsp *dst;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -
> -	dst = yarg->data;
> -	parg.ys = yarg->ys;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_EEE_HEADER) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.header = 1;
> -
> -			parg.rsp_policy = &ethtool_header_nest;
> -			parg.data = &dst->header;
> -			if (ethtool_header_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_EEE_MODES_OURS) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.modes_ours = 1;
> -
> -			parg.rsp_policy = &ethtool_bitset_nest;
> -			parg.data = &dst->modes_ours;
> -			if (ethtool_bitset_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_EEE_MODES_PEER) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.modes_peer = 1;
> -
> -			parg.rsp_policy = &ethtool_bitset_nest;
> -			parg.data = &dst->modes_peer;
> -			if (ethtool_bitset_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_EEE_ACTIVE) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.active = 1;
> -			dst->active = mnl_attr_get_u8(attr);
> -		} else if (type == ETHTOOL_A_EEE_ENABLED) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.enabled = 1;
> -			dst->enabled = mnl_attr_get_u8(attr);
> -		} else if (type == ETHTOOL_A_EEE_TX_LPI_ENABLED) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.tx_lpi_enabled = 1;
> -			dst->tx_lpi_enabled = mnl_attr_get_u8(attr);
> -		} else if (type == ETHTOOL_A_EEE_TX_LPI_TIMER) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.tx_lpi_timer = 1;
> -			dst->tx_lpi_timer = mnl_attr_get_u32(attr);
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct ethtool_eee_get_rsp *
> -ethtool_eee_get(struct ynl_sock *ys, struct ethtool_eee_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct ethtool_eee_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_EEE_GET, 1);
> -	ys->req_policy = &ethtool_eee_nest;
> -	yrs.yarg.rsp_policy = &ethtool_eee_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_EEE_HEADER, &req->header);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = ethtool_eee_get_rsp_parse;
> -	yrs.rsp_cmd = 24;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	ethtool_eee_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* ETHTOOL_MSG_EEE_GET - dump */
> -void ethtool_eee_get_list_free(struct ethtool_eee_get_list *rsp)
> -{
> -	struct ethtool_eee_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		ethtool_header_free(&rsp->obj.header);
> -		ethtool_bitset_free(&rsp->obj.modes_ours);
> -		ethtool_bitset_free(&rsp->obj.modes_peer);
> -		free(rsp);
> -	}
> -}
> -
> -struct ethtool_eee_get_list *
> -ethtool_eee_get_dump(struct ynl_sock *ys, struct ethtool_eee_get_req_dump *req)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct ethtool_eee_get_list);
> -	yds.cb = ethtool_eee_get_rsp_parse;
> -	yds.rsp_cmd = 24;
> -	yds.rsp_policy = &ethtool_eee_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, ETHTOOL_MSG_EEE_GET, 1);
> -	ys->req_policy = &ethtool_eee_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_EEE_HEADER, &req->header);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	ethtool_eee_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ETHTOOL_MSG_EEE_GET - notify */
> -void ethtool_eee_get_ntf_free(struct ethtool_eee_get_ntf *rsp)
> -{
> -	ethtool_header_free(&rsp->obj.header);
> -	ethtool_bitset_free(&rsp->obj.modes_ours);
> -	ethtool_bitset_free(&rsp->obj.modes_peer);
> -	free(rsp);
> -}
> -
> -/* ============== ETHTOOL_MSG_EEE_SET ============== */
> -/* ETHTOOL_MSG_EEE_SET - do */
> -void ethtool_eee_set_req_free(struct ethtool_eee_set_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	ethtool_bitset_free(&req->modes_ours);
> -	ethtool_bitset_free(&req->modes_peer);
> -	free(req);
> -}
> -
> -int ethtool_eee_set(struct ynl_sock *ys, struct ethtool_eee_set_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_EEE_SET, 1);
> -	ys->req_policy = &ethtool_eee_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_EEE_HEADER, &req->header);
> -	if (req->_present.modes_ours)
> -		ethtool_bitset_put(nlh, ETHTOOL_A_EEE_MODES_OURS, &req->modes_ours);
> -	if (req->_present.modes_peer)
> -		ethtool_bitset_put(nlh, ETHTOOL_A_EEE_MODES_PEER, &req->modes_peer);
> -	if (req->_present.active)
> -		mnl_attr_put_u8(nlh, ETHTOOL_A_EEE_ACTIVE, req->active);
> -	if (req->_present.enabled)
> -		mnl_attr_put_u8(nlh, ETHTOOL_A_EEE_ENABLED, req->enabled);
> -	if (req->_present.tx_lpi_enabled)
> -		mnl_attr_put_u8(nlh, ETHTOOL_A_EEE_TX_LPI_ENABLED, req->tx_lpi_enabled);
> -	if (req->_present.tx_lpi_timer)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_EEE_TX_LPI_TIMER, req->tx_lpi_timer);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== ETHTOOL_MSG_TSINFO_GET ============== */
> -/* ETHTOOL_MSG_TSINFO_GET - do */
> -void ethtool_tsinfo_get_req_free(struct ethtool_tsinfo_get_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	free(req);
> -}
> -
> -void ethtool_tsinfo_get_rsp_free(struct ethtool_tsinfo_get_rsp *rsp)
> -{
> -	ethtool_header_free(&rsp->header);
> -	ethtool_bitset_free(&rsp->timestamping);
> -	ethtool_bitset_free(&rsp->tx_types);
> -	ethtool_bitset_free(&rsp->rx_filters);
> -	free(rsp);
> -}
> -
> -int ethtool_tsinfo_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct ethtool_tsinfo_get_rsp *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -
> -	dst = yarg->data;
> -	parg.ys = yarg->ys;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_TSINFO_HEADER) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.header = 1;
> -
> -			parg.rsp_policy = &ethtool_header_nest;
> -			parg.data = &dst->header;
> -			if (ethtool_header_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_TSINFO_TIMESTAMPING) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.timestamping = 1;
> -
> -			parg.rsp_policy = &ethtool_bitset_nest;
> -			parg.data = &dst->timestamping;
> -			if (ethtool_bitset_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_TSINFO_TX_TYPES) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.tx_types = 1;
> -
> -			parg.rsp_policy = &ethtool_bitset_nest;
> -			parg.data = &dst->tx_types;
> -			if (ethtool_bitset_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_TSINFO_RX_FILTERS) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.rx_filters = 1;
> -
> -			parg.rsp_policy = &ethtool_bitset_nest;
> -			parg.data = &dst->rx_filters;
> -			if (ethtool_bitset_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_TSINFO_PHC_INDEX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.phc_index = 1;
> -			dst->phc_index = mnl_attr_get_u32(attr);
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct ethtool_tsinfo_get_rsp *
> -ethtool_tsinfo_get(struct ynl_sock *ys, struct ethtool_tsinfo_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct ethtool_tsinfo_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_TSINFO_GET, 1);
> -	ys->req_policy = &ethtool_tsinfo_nest;
> -	yrs.yarg.rsp_policy = &ethtool_tsinfo_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_TSINFO_HEADER, &req->header);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = ethtool_tsinfo_get_rsp_parse;
> -	yrs.rsp_cmd = 26;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	ethtool_tsinfo_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* ETHTOOL_MSG_TSINFO_GET - dump */
> -void ethtool_tsinfo_get_list_free(struct ethtool_tsinfo_get_list *rsp)
> -{
> -	struct ethtool_tsinfo_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		ethtool_header_free(&rsp->obj.header);
> -		ethtool_bitset_free(&rsp->obj.timestamping);
> -		ethtool_bitset_free(&rsp->obj.tx_types);
> -		ethtool_bitset_free(&rsp->obj.rx_filters);
> -		free(rsp);
> -	}
> -}
> -
> -struct ethtool_tsinfo_get_list *
> -ethtool_tsinfo_get_dump(struct ynl_sock *ys,
> -			struct ethtool_tsinfo_get_req_dump *req)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct ethtool_tsinfo_get_list);
> -	yds.cb = ethtool_tsinfo_get_rsp_parse;
> -	yds.rsp_cmd = 26;
> -	yds.rsp_policy = &ethtool_tsinfo_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, ETHTOOL_MSG_TSINFO_GET, 1);
> -	ys->req_policy = &ethtool_tsinfo_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_TSINFO_HEADER, &req->header);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	ethtool_tsinfo_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ============== ETHTOOL_MSG_CABLE_TEST_ACT ============== */
> -/* ETHTOOL_MSG_CABLE_TEST_ACT - do */
> -void ethtool_cable_test_act_req_free(struct ethtool_cable_test_act_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	free(req);
> -}
> -
> -int ethtool_cable_test_act(struct ynl_sock *ys,
> -			   struct ethtool_cable_test_act_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_CABLE_TEST_ACT, 1);
> -	ys->req_policy = &ethtool_cable_test_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_CABLE_TEST_HEADER, &req->header);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== ETHTOOL_MSG_CABLE_TEST_TDR_ACT ============== */
> -/* ETHTOOL_MSG_CABLE_TEST_TDR_ACT - do */
> -void
> -ethtool_cable_test_tdr_act_req_free(struct ethtool_cable_test_tdr_act_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	free(req);
> -}
> -
> -int ethtool_cable_test_tdr_act(struct ynl_sock *ys,
> -			       struct ethtool_cable_test_tdr_act_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_CABLE_TEST_TDR_ACT, 1);
> -	ys->req_policy = &ethtool_cable_test_tdr_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_CABLE_TEST_TDR_HEADER, &req->header);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== ETHTOOL_MSG_TUNNEL_INFO_GET ============== */
> -/* ETHTOOL_MSG_TUNNEL_INFO_GET - do */
> -void ethtool_tunnel_info_get_req_free(struct ethtool_tunnel_info_get_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	free(req);
> -}
> -
> -void ethtool_tunnel_info_get_rsp_free(struct ethtool_tunnel_info_get_rsp *rsp)
> -{
> -	ethtool_header_free(&rsp->header);
> -	ethtool_tunnel_udp_free(&rsp->udp_ports);
> -	free(rsp);
> -}
> -
> -int ethtool_tunnel_info_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct ethtool_tunnel_info_get_rsp *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -
> -	dst = yarg->data;
> -	parg.ys = yarg->ys;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_TUNNEL_INFO_HEADER) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.header = 1;
> -
> -			parg.rsp_policy = &ethtool_header_nest;
> -			parg.data = &dst->header;
> -			if (ethtool_header_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_TUNNEL_INFO_UDP_PORTS) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.udp_ports = 1;
> -
> -			parg.rsp_policy = &ethtool_tunnel_udp_nest;
> -			parg.data = &dst->udp_ports;
> -			if (ethtool_tunnel_udp_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct ethtool_tunnel_info_get_rsp *
> -ethtool_tunnel_info_get(struct ynl_sock *ys,
> -			struct ethtool_tunnel_info_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct ethtool_tunnel_info_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_TUNNEL_INFO_GET, 1);
> -	ys->req_policy = &ethtool_tunnel_info_nest;
> -	yrs.yarg.rsp_policy = &ethtool_tunnel_info_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_TUNNEL_INFO_HEADER, &req->header);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = ethtool_tunnel_info_get_rsp_parse;
> -	yrs.rsp_cmd = 29;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	ethtool_tunnel_info_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* ETHTOOL_MSG_TUNNEL_INFO_GET - dump */
> -void
> -ethtool_tunnel_info_get_list_free(struct ethtool_tunnel_info_get_list *rsp)
> -{
> -	struct ethtool_tunnel_info_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		ethtool_header_free(&rsp->obj.header);
> -		ethtool_tunnel_udp_free(&rsp->obj.udp_ports);
> -		free(rsp);
> -	}
> -}
> -
> -struct ethtool_tunnel_info_get_list *
> -ethtool_tunnel_info_get_dump(struct ynl_sock *ys,
> -			     struct ethtool_tunnel_info_get_req_dump *req)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct ethtool_tunnel_info_get_list);
> -	yds.cb = ethtool_tunnel_info_get_rsp_parse;
> -	yds.rsp_cmd = 29;
> -	yds.rsp_policy = &ethtool_tunnel_info_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, ETHTOOL_MSG_TUNNEL_INFO_GET, 1);
> -	ys->req_policy = &ethtool_tunnel_info_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_TUNNEL_INFO_HEADER, &req->header);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	ethtool_tunnel_info_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ============== ETHTOOL_MSG_FEC_GET ============== */
> -/* ETHTOOL_MSG_FEC_GET - do */
> -void ethtool_fec_get_req_free(struct ethtool_fec_get_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	free(req);
> -}
> -
> -void ethtool_fec_get_rsp_free(struct ethtool_fec_get_rsp *rsp)
> -{
> -	ethtool_header_free(&rsp->header);
> -	ethtool_bitset_free(&rsp->modes);
> -	ethtool_fec_stat_free(&rsp->stats);
> -	free(rsp);
> -}
> -
> -int ethtool_fec_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct ynl_parse_arg *yarg = data;
> -	struct ethtool_fec_get_rsp *dst;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -
> -	dst = yarg->data;
> -	parg.ys = yarg->ys;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_FEC_HEADER) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.header = 1;
> -
> -			parg.rsp_policy = &ethtool_header_nest;
> -			parg.data = &dst->header;
> -			if (ethtool_header_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_FEC_MODES) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.modes = 1;
> -
> -			parg.rsp_policy = &ethtool_bitset_nest;
> -			parg.data = &dst->modes;
> -			if (ethtool_bitset_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_FEC_AUTO) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.auto_ = 1;
> -			dst->auto_ = mnl_attr_get_u8(attr);
> -		} else if (type == ETHTOOL_A_FEC_ACTIVE) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.active = 1;
> -			dst->active = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_FEC_STATS) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.stats = 1;
> -
> -			parg.rsp_policy = &ethtool_fec_stat_nest;
> -			parg.data = &dst->stats;
> -			if (ethtool_fec_stat_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct ethtool_fec_get_rsp *
> -ethtool_fec_get(struct ynl_sock *ys, struct ethtool_fec_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct ethtool_fec_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_FEC_GET, 1);
> -	ys->req_policy = &ethtool_fec_nest;
> -	yrs.yarg.rsp_policy = &ethtool_fec_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_FEC_HEADER, &req->header);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = ethtool_fec_get_rsp_parse;
> -	yrs.rsp_cmd = 30;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	ethtool_fec_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* ETHTOOL_MSG_FEC_GET - dump */
> -void ethtool_fec_get_list_free(struct ethtool_fec_get_list *rsp)
> -{
> -	struct ethtool_fec_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		ethtool_header_free(&rsp->obj.header);
> -		ethtool_bitset_free(&rsp->obj.modes);
> -		ethtool_fec_stat_free(&rsp->obj.stats);
> -		free(rsp);
> -	}
> -}
> -
> -struct ethtool_fec_get_list *
> -ethtool_fec_get_dump(struct ynl_sock *ys, struct ethtool_fec_get_req_dump *req)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct ethtool_fec_get_list);
> -	yds.cb = ethtool_fec_get_rsp_parse;
> -	yds.rsp_cmd = 30;
> -	yds.rsp_policy = &ethtool_fec_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, ETHTOOL_MSG_FEC_GET, 1);
> -	ys->req_policy = &ethtool_fec_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_FEC_HEADER, &req->header);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	ethtool_fec_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ETHTOOL_MSG_FEC_GET - notify */
> -void ethtool_fec_get_ntf_free(struct ethtool_fec_get_ntf *rsp)
> -{
> -	ethtool_header_free(&rsp->obj.header);
> -	ethtool_bitset_free(&rsp->obj.modes);
> -	ethtool_fec_stat_free(&rsp->obj.stats);
> -	free(rsp);
> -}
> -
> -/* ============== ETHTOOL_MSG_FEC_SET ============== */
> -/* ETHTOOL_MSG_FEC_SET - do */
> -void ethtool_fec_set_req_free(struct ethtool_fec_set_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	ethtool_bitset_free(&req->modes);
> -	ethtool_fec_stat_free(&req->stats);
> -	free(req);
> -}
> -
> -int ethtool_fec_set(struct ynl_sock *ys, struct ethtool_fec_set_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_FEC_SET, 1);
> -	ys->req_policy = &ethtool_fec_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_FEC_HEADER, &req->header);
> -	if (req->_present.modes)
> -		ethtool_bitset_put(nlh, ETHTOOL_A_FEC_MODES, &req->modes);
> -	if (req->_present.auto_)
> -		mnl_attr_put_u8(nlh, ETHTOOL_A_FEC_AUTO, req->auto_);
> -	if (req->_present.active)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_FEC_ACTIVE, req->active);
> -	if (req->_present.stats)
> -		ethtool_fec_stat_put(nlh, ETHTOOL_A_FEC_STATS, &req->stats);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== ETHTOOL_MSG_MODULE_EEPROM_GET ============== */
> -/* ETHTOOL_MSG_MODULE_EEPROM_GET - do */
> -void
> -ethtool_module_eeprom_get_req_free(struct ethtool_module_eeprom_get_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	free(req);
> -}
> -
> -void
> -ethtool_module_eeprom_get_rsp_free(struct ethtool_module_eeprom_get_rsp *rsp)
> -{
> -	ethtool_header_free(&rsp->header);
> -	free(rsp->data);
> -	free(rsp);
> -}
> -
> -int ethtool_module_eeprom_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct ethtool_module_eeprom_get_rsp *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -
> -	dst = yarg->data;
> -	parg.ys = yarg->ys;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_MODULE_EEPROM_HEADER) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.header = 1;
> -
> -			parg.rsp_policy = &ethtool_header_nest;
> -			parg.data = &dst->header;
> -			if (ethtool_header_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_MODULE_EEPROM_OFFSET) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.offset = 1;
> -			dst->offset = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_MODULE_EEPROM_LENGTH) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.length = 1;
> -			dst->length = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_MODULE_EEPROM_PAGE) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.page = 1;
> -			dst->page = mnl_attr_get_u8(attr);
> -		} else if (type == ETHTOOL_A_MODULE_EEPROM_BANK) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.bank = 1;
> -			dst->bank = mnl_attr_get_u8(attr);
> -		} else if (type == ETHTOOL_A_MODULE_EEPROM_I2C_ADDRESS) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.i2c_address = 1;
> -			dst->i2c_address = mnl_attr_get_u8(attr);
> -		} else if (type == ETHTOOL_A_MODULE_EEPROM_DATA) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = mnl_attr_get_payload_len(attr);
> -			dst->_present.data_len = len;
> -			dst->data = malloc(len);
> -			memcpy(dst->data, mnl_attr_get_payload(attr), len);
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct ethtool_module_eeprom_get_rsp *
> -ethtool_module_eeprom_get(struct ynl_sock *ys,
> -			  struct ethtool_module_eeprom_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct ethtool_module_eeprom_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_MODULE_EEPROM_GET, 1);
> -	ys->req_policy = &ethtool_module_eeprom_nest;
> -	yrs.yarg.rsp_policy = &ethtool_module_eeprom_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_MODULE_EEPROM_HEADER, &req->header);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = ethtool_module_eeprom_get_rsp_parse;
> -	yrs.rsp_cmd = 32;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	ethtool_module_eeprom_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* ETHTOOL_MSG_MODULE_EEPROM_GET - dump */
> -void
> -ethtool_module_eeprom_get_list_free(struct ethtool_module_eeprom_get_list *rsp)
> -{
> -	struct ethtool_module_eeprom_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		ethtool_header_free(&rsp->obj.header);
> -		free(rsp->obj.data);
> -		free(rsp);
> -	}
> -}
> -
> -struct ethtool_module_eeprom_get_list *
> -ethtool_module_eeprom_get_dump(struct ynl_sock *ys,
> -			       struct ethtool_module_eeprom_get_req_dump *req)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct ethtool_module_eeprom_get_list);
> -	yds.cb = ethtool_module_eeprom_get_rsp_parse;
> -	yds.rsp_cmd = 32;
> -	yds.rsp_policy = &ethtool_module_eeprom_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, ETHTOOL_MSG_MODULE_EEPROM_GET, 1);
> -	ys->req_policy = &ethtool_module_eeprom_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_MODULE_EEPROM_HEADER, &req->header);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	ethtool_module_eeprom_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ============== ETHTOOL_MSG_PHC_VCLOCKS_GET ============== */
> -/* ETHTOOL_MSG_PHC_VCLOCKS_GET - do */
> -void ethtool_phc_vclocks_get_req_free(struct ethtool_phc_vclocks_get_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	free(req);
> -}
> -
> -void ethtool_phc_vclocks_get_rsp_free(struct ethtool_phc_vclocks_get_rsp *rsp)
> -{
> -	ethtool_header_free(&rsp->header);
> -	free(rsp);
> -}
> -
> -int ethtool_phc_vclocks_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct ethtool_phc_vclocks_get_rsp *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -
> -	dst = yarg->data;
> -	parg.ys = yarg->ys;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_PHC_VCLOCKS_HEADER) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.header = 1;
> -
> -			parg.rsp_policy = &ethtool_header_nest;
> -			parg.data = &dst->header;
> -			if (ethtool_header_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_PHC_VCLOCKS_NUM) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.num = 1;
> -			dst->num = mnl_attr_get_u32(attr);
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct ethtool_phc_vclocks_get_rsp *
> -ethtool_phc_vclocks_get(struct ynl_sock *ys,
> -			struct ethtool_phc_vclocks_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct ethtool_phc_vclocks_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_PHC_VCLOCKS_GET, 1);
> -	ys->req_policy = &ethtool_phc_vclocks_nest;
> -	yrs.yarg.rsp_policy = &ethtool_phc_vclocks_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_PHC_VCLOCKS_HEADER, &req->header);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = ethtool_phc_vclocks_get_rsp_parse;
> -	yrs.rsp_cmd = 34;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	ethtool_phc_vclocks_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* ETHTOOL_MSG_PHC_VCLOCKS_GET - dump */
> -void
> -ethtool_phc_vclocks_get_list_free(struct ethtool_phc_vclocks_get_list *rsp)
> -{
> -	struct ethtool_phc_vclocks_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		ethtool_header_free(&rsp->obj.header);
> -		free(rsp);
> -	}
> -}
> -
> -struct ethtool_phc_vclocks_get_list *
> -ethtool_phc_vclocks_get_dump(struct ynl_sock *ys,
> -			     struct ethtool_phc_vclocks_get_req_dump *req)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct ethtool_phc_vclocks_get_list);
> -	yds.cb = ethtool_phc_vclocks_get_rsp_parse;
> -	yds.rsp_cmd = 34;
> -	yds.rsp_policy = &ethtool_phc_vclocks_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, ETHTOOL_MSG_PHC_VCLOCKS_GET, 1);
> -	ys->req_policy = &ethtool_phc_vclocks_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_PHC_VCLOCKS_HEADER, &req->header);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	ethtool_phc_vclocks_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ============== ETHTOOL_MSG_MODULE_GET ============== */
> -/* ETHTOOL_MSG_MODULE_GET - do */
> -void ethtool_module_get_req_free(struct ethtool_module_get_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	free(req);
> -}
> -
> -void ethtool_module_get_rsp_free(struct ethtool_module_get_rsp *rsp)
> -{
> -	ethtool_header_free(&rsp->header);
> -	free(rsp);
> -}
> -
> -int ethtool_module_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct ethtool_module_get_rsp *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -
> -	dst = yarg->data;
> -	parg.ys = yarg->ys;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_MODULE_HEADER) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.header = 1;
> -
> -			parg.rsp_policy = &ethtool_header_nest;
> -			parg.data = &dst->header;
> -			if (ethtool_header_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_MODULE_POWER_MODE_POLICY) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.power_mode_policy = 1;
> -			dst->power_mode_policy = mnl_attr_get_u8(attr);
> -		} else if (type == ETHTOOL_A_MODULE_POWER_MODE) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.power_mode = 1;
> -			dst->power_mode = mnl_attr_get_u8(attr);
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct ethtool_module_get_rsp *
> -ethtool_module_get(struct ynl_sock *ys, struct ethtool_module_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct ethtool_module_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_MODULE_GET, 1);
> -	ys->req_policy = &ethtool_module_nest;
> -	yrs.yarg.rsp_policy = &ethtool_module_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_MODULE_HEADER, &req->header);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = ethtool_module_get_rsp_parse;
> -	yrs.rsp_cmd = 35;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	ethtool_module_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* ETHTOOL_MSG_MODULE_GET - dump */
> -void ethtool_module_get_list_free(struct ethtool_module_get_list *rsp)
> -{
> -	struct ethtool_module_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		ethtool_header_free(&rsp->obj.header);
> -		free(rsp);
> -	}
> -}
> -
> -struct ethtool_module_get_list *
> -ethtool_module_get_dump(struct ynl_sock *ys,
> -			struct ethtool_module_get_req_dump *req)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct ethtool_module_get_list);
> -	yds.cb = ethtool_module_get_rsp_parse;
> -	yds.rsp_cmd = 35;
> -	yds.rsp_policy = &ethtool_module_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, ETHTOOL_MSG_MODULE_GET, 1);
> -	ys->req_policy = &ethtool_module_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_MODULE_HEADER, &req->header);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	ethtool_module_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ETHTOOL_MSG_MODULE_GET - notify */
> -void ethtool_module_get_ntf_free(struct ethtool_module_get_ntf *rsp)
> -{
> -	ethtool_header_free(&rsp->obj.header);
> -	free(rsp);
> -}
> -
> -/* ============== ETHTOOL_MSG_MODULE_SET ============== */
> -/* ETHTOOL_MSG_MODULE_SET - do */
> -void ethtool_module_set_req_free(struct ethtool_module_set_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	free(req);
> -}
> -
> -int ethtool_module_set(struct ynl_sock *ys, struct ethtool_module_set_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_MODULE_SET, 1);
> -	ys->req_policy = &ethtool_module_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_MODULE_HEADER, &req->header);
> -	if (req->_present.power_mode_policy)
> -		mnl_attr_put_u8(nlh, ETHTOOL_A_MODULE_POWER_MODE_POLICY, req->power_mode_policy);
> -	if (req->_present.power_mode)
> -		mnl_attr_put_u8(nlh, ETHTOOL_A_MODULE_POWER_MODE, req->power_mode);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== ETHTOOL_MSG_PSE_GET ============== */
> -/* ETHTOOL_MSG_PSE_GET - do */
> -void ethtool_pse_get_req_free(struct ethtool_pse_get_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	free(req);
> -}
> -
> -void ethtool_pse_get_rsp_free(struct ethtool_pse_get_rsp *rsp)
> -{
> -	ethtool_header_free(&rsp->header);
> -	free(rsp);
> -}
> -
> -int ethtool_pse_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct ynl_parse_arg *yarg = data;
> -	struct ethtool_pse_get_rsp *dst;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -
> -	dst = yarg->data;
> -	parg.ys = yarg->ys;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_PSE_HEADER) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.header = 1;
> -
> -			parg.rsp_policy = &ethtool_header_nest;
> -			parg.data = &dst->header;
> -			if (ethtool_header_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_PODL_PSE_ADMIN_STATE) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.admin_state = 1;
> -			dst->admin_state = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_PODL_PSE_ADMIN_CONTROL) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.admin_control = 1;
> -			dst->admin_control = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_PODL_PSE_PW_D_STATUS) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.pw_d_status = 1;
> -			dst->pw_d_status = mnl_attr_get_u32(attr);
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct ethtool_pse_get_rsp *
> -ethtool_pse_get(struct ynl_sock *ys, struct ethtool_pse_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct ethtool_pse_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_PSE_GET, 1);
> -	ys->req_policy = &ethtool_pse_nest;
> -	yrs.yarg.rsp_policy = &ethtool_pse_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_PSE_HEADER, &req->header);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = ethtool_pse_get_rsp_parse;
> -	yrs.rsp_cmd = 37;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	ethtool_pse_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* ETHTOOL_MSG_PSE_GET - dump */
> -void ethtool_pse_get_list_free(struct ethtool_pse_get_list *rsp)
> -{
> -	struct ethtool_pse_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		ethtool_header_free(&rsp->obj.header);
> -		free(rsp);
> -	}
> -}
> -
> -struct ethtool_pse_get_list *
> -ethtool_pse_get_dump(struct ynl_sock *ys, struct ethtool_pse_get_req_dump *req)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct ethtool_pse_get_list);
> -	yds.cb = ethtool_pse_get_rsp_parse;
> -	yds.rsp_cmd = 37;
> -	yds.rsp_policy = &ethtool_pse_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, ETHTOOL_MSG_PSE_GET, 1);
> -	ys->req_policy = &ethtool_pse_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_PSE_HEADER, &req->header);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	ethtool_pse_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ============== ETHTOOL_MSG_PSE_SET ============== */
> -/* ETHTOOL_MSG_PSE_SET - do */
> -void ethtool_pse_set_req_free(struct ethtool_pse_set_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	free(req);
> -}
> -
> -int ethtool_pse_set(struct ynl_sock *ys, struct ethtool_pse_set_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_PSE_SET, 1);
> -	ys->req_policy = &ethtool_pse_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_PSE_HEADER, &req->header);
> -	if (req->_present.admin_state)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_PODL_PSE_ADMIN_STATE, req->admin_state);
> -	if (req->_present.admin_control)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_PODL_PSE_ADMIN_CONTROL, req->admin_control);
> -	if (req->_present.pw_d_status)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_PODL_PSE_PW_D_STATUS, req->pw_d_status);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== ETHTOOL_MSG_RSS_GET ============== */
> -/* ETHTOOL_MSG_RSS_GET - do */
> -void ethtool_rss_get_req_free(struct ethtool_rss_get_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	free(req);
> -}
> -
> -void ethtool_rss_get_rsp_free(struct ethtool_rss_get_rsp *rsp)
> -{
> -	ethtool_header_free(&rsp->header);
> -	free(rsp->indir);
> -	free(rsp->hkey);
> -	free(rsp);
> -}
> -
> -int ethtool_rss_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct ynl_parse_arg *yarg = data;
> -	struct ethtool_rss_get_rsp *dst;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -
> -	dst = yarg->data;
> -	parg.ys = yarg->ys;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_RSS_HEADER) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.header = 1;
> -
> -			parg.rsp_policy = &ethtool_header_nest;
> -			parg.data = &dst->header;
> -			if (ethtool_header_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_RSS_CONTEXT) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.context = 1;
> -			dst->context = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_RSS_HFUNC) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.hfunc = 1;
> -			dst->hfunc = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_RSS_INDIR) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = mnl_attr_get_payload_len(attr);
> -			dst->_present.indir_len = len;
> -			dst->indir = malloc(len);
> -			memcpy(dst->indir, mnl_attr_get_payload(attr), len);
> -		} else if (type == ETHTOOL_A_RSS_HKEY) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = mnl_attr_get_payload_len(attr);
> -			dst->_present.hkey_len = len;
> -			dst->hkey = malloc(len);
> -			memcpy(dst->hkey, mnl_attr_get_payload(attr), len);
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct ethtool_rss_get_rsp *
> -ethtool_rss_get(struct ynl_sock *ys, struct ethtool_rss_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct ethtool_rss_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_RSS_GET, 1);
> -	ys->req_policy = &ethtool_rss_nest;
> -	yrs.yarg.rsp_policy = &ethtool_rss_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_RSS_HEADER, &req->header);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = ethtool_rss_get_rsp_parse;
> -	yrs.rsp_cmd = ETHTOOL_MSG_RSS_GET;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	ethtool_rss_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* ETHTOOL_MSG_RSS_GET - dump */
> -void ethtool_rss_get_list_free(struct ethtool_rss_get_list *rsp)
> -{
> -	struct ethtool_rss_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		ethtool_header_free(&rsp->obj.header);
> -		free(rsp->obj.indir);
> -		free(rsp->obj.hkey);
> -		free(rsp);
> -	}
> -}
> -
> -struct ethtool_rss_get_list *
> -ethtool_rss_get_dump(struct ynl_sock *ys, struct ethtool_rss_get_req_dump *req)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct ethtool_rss_get_list);
> -	yds.cb = ethtool_rss_get_rsp_parse;
> -	yds.rsp_cmd = ETHTOOL_MSG_RSS_GET;
> -	yds.rsp_policy = &ethtool_rss_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, ETHTOOL_MSG_RSS_GET, 1);
> -	ys->req_policy = &ethtool_rss_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_RSS_HEADER, &req->header);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	ethtool_rss_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ============== ETHTOOL_MSG_PLCA_GET_CFG ============== */
> -/* ETHTOOL_MSG_PLCA_GET_CFG - do */
> -void ethtool_plca_get_cfg_req_free(struct ethtool_plca_get_cfg_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	free(req);
> -}
> -
> -void ethtool_plca_get_cfg_rsp_free(struct ethtool_plca_get_cfg_rsp *rsp)
> -{
> -	ethtool_header_free(&rsp->header);
> -	free(rsp);
> -}
> -
> -int ethtool_plca_get_cfg_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct ethtool_plca_get_cfg_rsp *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -
> -	dst = yarg->data;
> -	parg.ys = yarg->ys;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_PLCA_HEADER) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.header = 1;
> -
> -			parg.rsp_policy = &ethtool_header_nest;
> -			parg.data = &dst->header;
> -			if (ethtool_header_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_PLCA_VERSION) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.version = 1;
> -			dst->version = mnl_attr_get_u16(attr);
> -		} else if (type == ETHTOOL_A_PLCA_ENABLED) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.enabled = 1;
> -			dst->enabled = mnl_attr_get_u8(attr);
> -		} else if (type == ETHTOOL_A_PLCA_STATUS) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.status = 1;
> -			dst->status = mnl_attr_get_u8(attr);
> -		} else if (type == ETHTOOL_A_PLCA_NODE_CNT) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.node_cnt = 1;
> -			dst->node_cnt = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_PLCA_NODE_ID) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.node_id = 1;
> -			dst->node_id = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_PLCA_TO_TMR) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.to_tmr = 1;
> -			dst->to_tmr = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_PLCA_BURST_CNT) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.burst_cnt = 1;
> -			dst->burst_cnt = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_PLCA_BURST_TMR) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.burst_tmr = 1;
> -			dst->burst_tmr = mnl_attr_get_u32(attr);
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct ethtool_plca_get_cfg_rsp *
> -ethtool_plca_get_cfg(struct ynl_sock *ys, struct ethtool_plca_get_cfg_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct ethtool_plca_get_cfg_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_PLCA_GET_CFG, 1);
> -	ys->req_policy = &ethtool_plca_nest;
> -	yrs.yarg.rsp_policy = &ethtool_plca_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_PLCA_HEADER, &req->header);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = ethtool_plca_get_cfg_rsp_parse;
> -	yrs.rsp_cmd = ETHTOOL_MSG_PLCA_GET_CFG;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	ethtool_plca_get_cfg_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* ETHTOOL_MSG_PLCA_GET_CFG - dump */
> -void ethtool_plca_get_cfg_list_free(struct ethtool_plca_get_cfg_list *rsp)
> -{
> -	struct ethtool_plca_get_cfg_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		ethtool_header_free(&rsp->obj.header);
> -		free(rsp);
> -	}
> -}
> -
> -struct ethtool_plca_get_cfg_list *
> -ethtool_plca_get_cfg_dump(struct ynl_sock *ys,
> -			  struct ethtool_plca_get_cfg_req_dump *req)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct ethtool_plca_get_cfg_list);
> -	yds.cb = ethtool_plca_get_cfg_rsp_parse;
> -	yds.rsp_cmd = ETHTOOL_MSG_PLCA_GET_CFG;
> -	yds.rsp_policy = &ethtool_plca_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, ETHTOOL_MSG_PLCA_GET_CFG, 1);
> -	ys->req_policy = &ethtool_plca_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_PLCA_HEADER, &req->header);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	ethtool_plca_get_cfg_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ETHTOOL_MSG_PLCA_GET_CFG - notify */
> -void ethtool_plca_get_cfg_ntf_free(struct ethtool_plca_get_cfg_ntf *rsp)
> -{
> -	ethtool_header_free(&rsp->obj.header);
> -	free(rsp);
> -}
> -
> -/* ============== ETHTOOL_MSG_PLCA_SET_CFG ============== */
> -/* ETHTOOL_MSG_PLCA_SET_CFG - do */
> -void ethtool_plca_set_cfg_req_free(struct ethtool_plca_set_cfg_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	free(req);
> -}
> -
> -int ethtool_plca_set_cfg(struct ynl_sock *ys,
> -			 struct ethtool_plca_set_cfg_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_PLCA_SET_CFG, 1);
> -	ys->req_policy = &ethtool_plca_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_PLCA_HEADER, &req->header);
> -	if (req->_present.version)
> -		mnl_attr_put_u16(nlh, ETHTOOL_A_PLCA_VERSION, req->version);
> -	if (req->_present.enabled)
> -		mnl_attr_put_u8(nlh, ETHTOOL_A_PLCA_ENABLED, req->enabled);
> -	if (req->_present.status)
> -		mnl_attr_put_u8(nlh, ETHTOOL_A_PLCA_STATUS, req->status);
> -	if (req->_present.node_cnt)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_PLCA_NODE_CNT, req->node_cnt);
> -	if (req->_present.node_id)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_PLCA_NODE_ID, req->node_id);
> -	if (req->_present.to_tmr)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_PLCA_TO_TMR, req->to_tmr);
> -	if (req->_present.burst_cnt)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_PLCA_BURST_CNT, req->burst_cnt);
> -	if (req->_present.burst_tmr)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_PLCA_BURST_TMR, req->burst_tmr);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== ETHTOOL_MSG_PLCA_GET_STATUS ============== */
> -/* ETHTOOL_MSG_PLCA_GET_STATUS - do */
> -void ethtool_plca_get_status_req_free(struct ethtool_plca_get_status_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	free(req);
> -}
> -
> -void ethtool_plca_get_status_rsp_free(struct ethtool_plca_get_status_rsp *rsp)
> -{
> -	ethtool_header_free(&rsp->header);
> -	free(rsp);
> -}
> -
> -int ethtool_plca_get_status_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct ethtool_plca_get_status_rsp *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -
> -	dst = yarg->data;
> -	parg.ys = yarg->ys;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_PLCA_HEADER) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.header = 1;
> -
> -			parg.rsp_policy = &ethtool_header_nest;
> -			parg.data = &dst->header;
> -			if (ethtool_header_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_PLCA_VERSION) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.version = 1;
> -			dst->version = mnl_attr_get_u16(attr);
> -		} else if (type == ETHTOOL_A_PLCA_ENABLED) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.enabled = 1;
> -			dst->enabled = mnl_attr_get_u8(attr);
> -		} else if (type == ETHTOOL_A_PLCA_STATUS) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.status = 1;
> -			dst->status = mnl_attr_get_u8(attr);
> -		} else if (type == ETHTOOL_A_PLCA_NODE_CNT) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.node_cnt = 1;
> -			dst->node_cnt = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_PLCA_NODE_ID) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.node_id = 1;
> -			dst->node_id = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_PLCA_TO_TMR) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.to_tmr = 1;
> -			dst->to_tmr = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_PLCA_BURST_CNT) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.burst_cnt = 1;
> -			dst->burst_cnt = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_PLCA_BURST_TMR) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.burst_tmr = 1;
> -			dst->burst_tmr = mnl_attr_get_u32(attr);
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct ethtool_plca_get_status_rsp *
> -ethtool_plca_get_status(struct ynl_sock *ys,
> -			struct ethtool_plca_get_status_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct ethtool_plca_get_status_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_PLCA_GET_STATUS, 1);
> -	ys->req_policy = &ethtool_plca_nest;
> -	yrs.yarg.rsp_policy = &ethtool_plca_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_PLCA_HEADER, &req->header);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = ethtool_plca_get_status_rsp_parse;
> -	yrs.rsp_cmd = 40;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	ethtool_plca_get_status_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* ETHTOOL_MSG_PLCA_GET_STATUS - dump */
> -void
> -ethtool_plca_get_status_list_free(struct ethtool_plca_get_status_list *rsp)
> -{
> -	struct ethtool_plca_get_status_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		ethtool_header_free(&rsp->obj.header);
> -		free(rsp);
> -	}
> -}
> -
> -struct ethtool_plca_get_status_list *
> -ethtool_plca_get_status_dump(struct ynl_sock *ys,
> -			     struct ethtool_plca_get_status_req_dump *req)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct ethtool_plca_get_status_list);
> -	yds.cb = ethtool_plca_get_status_rsp_parse;
> -	yds.rsp_cmd = 40;
> -	yds.rsp_policy = &ethtool_plca_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, ETHTOOL_MSG_PLCA_GET_STATUS, 1);
> -	ys->req_policy = &ethtool_plca_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_PLCA_HEADER, &req->header);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	ethtool_plca_get_status_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ============== ETHTOOL_MSG_MM_GET ============== */
> -/* ETHTOOL_MSG_MM_GET - do */
> -void ethtool_mm_get_req_free(struct ethtool_mm_get_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	free(req);
> -}
> -
> -void ethtool_mm_get_rsp_free(struct ethtool_mm_get_rsp *rsp)
> -{
> -	ethtool_header_free(&rsp->header);
> -	ethtool_mm_stat_free(&rsp->stats);
> -	free(rsp);
> -}
> -
> -int ethtool_mm_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct ynl_parse_arg *yarg = data;
> -	struct ethtool_mm_get_rsp *dst;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -
> -	dst = yarg->data;
> -	parg.ys = yarg->ys;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_MM_HEADER) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.header = 1;
> -
> -			parg.rsp_policy = &ethtool_header_nest;
> -			parg.data = &dst->header;
> -			if (ethtool_header_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_MM_PMAC_ENABLED) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.pmac_enabled = 1;
> -			dst->pmac_enabled = mnl_attr_get_u8(attr);
> -		} else if (type == ETHTOOL_A_MM_TX_ENABLED) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.tx_enabled = 1;
> -			dst->tx_enabled = mnl_attr_get_u8(attr);
> -		} else if (type == ETHTOOL_A_MM_TX_ACTIVE) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.tx_active = 1;
> -			dst->tx_active = mnl_attr_get_u8(attr);
> -		} else if (type == ETHTOOL_A_MM_TX_MIN_FRAG_SIZE) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.tx_min_frag_size = 1;
> -			dst->tx_min_frag_size = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_MM_RX_MIN_FRAG_SIZE) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.rx_min_frag_size = 1;
> -			dst->rx_min_frag_size = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_MM_VERIFY_ENABLED) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.verify_enabled = 1;
> -			dst->verify_enabled = mnl_attr_get_u8(attr);
> -		} else if (type == ETHTOOL_A_MM_VERIFY_TIME) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.verify_time = 1;
> -			dst->verify_time = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_MM_MAX_VERIFY_TIME) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.max_verify_time = 1;
> -			dst->max_verify_time = mnl_attr_get_u32(attr);
> -		} else if (type == ETHTOOL_A_MM_STATS) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.stats = 1;
> -
> -			parg.rsp_policy = &ethtool_mm_stat_nest;
> -			parg.data = &dst->stats;
> -			if (ethtool_mm_stat_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct ethtool_mm_get_rsp *
> -ethtool_mm_get(struct ynl_sock *ys, struct ethtool_mm_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct ethtool_mm_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_MM_GET, 1);
> -	ys->req_policy = &ethtool_mm_nest;
> -	yrs.yarg.rsp_policy = &ethtool_mm_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_MM_HEADER, &req->header);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = ethtool_mm_get_rsp_parse;
> -	yrs.rsp_cmd = ETHTOOL_MSG_MM_GET;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	ethtool_mm_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* ETHTOOL_MSG_MM_GET - dump */
> -void ethtool_mm_get_list_free(struct ethtool_mm_get_list *rsp)
> -{
> -	struct ethtool_mm_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		ethtool_header_free(&rsp->obj.header);
> -		ethtool_mm_stat_free(&rsp->obj.stats);
> -		free(rsp);
> -	}
> -}
> -
> -struct ethtool_mm_get_list *
> -ethtool_mm_get_dump(struct ynl_sock *ys, struct ethtool_mm_get_req_dump *req)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct ethtool_mm_get_list);
> -	yds.cb = ethtool_mm_get_rsp_parse;
> -	yds.rsp_cmd = ETHTOOL_MSG_MM_GET;
> -	yds.rsp_policy = &ethtool_mm_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, ETHTOOL_MSG_MM_GET, 1);
> -	ys->req_policy = &ethtool_mm_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_MM_HEADER, &req->header);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	ethtool_mm_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* ETHTOOL_MSG_MM_GET - notify */
> -void ethtool_mm_get_ntf_free(struct ethtool_mm_get_ntf *rsp)
> -{
> -	ethtool_header_free(&rsp->obj.header);
> -	ethtool_mm_stat_free(&rsp->obj.stats);
> -	free(rsp);
> -}
> -
> -/* ============== ETHTOOL_MSG_MM_SET ============== */
> -/* ETHTOOL_MSG_MM_SET - do */
> -void ethtool_mm_set_req_free(struct ethtool_mm_set_req *req)
> -{
> -	ethtool_header_free(&req->header);
> -	free(req);
> -}
> -
> -int ethtool_mm_set(struct ynl_sock *ys, struct ethtool_mm_set_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, ETHTOOL_MSG_MM_SET, 1);
> -	ys->req_policy = &ethtool_mm_nest;
> -
> -	if (req->_present.header)
> -		ethtool_header_put(nlh, ETHTOOL_A_MM_HEADER, &req->header);
> -	if (req->_present.verify_enabled)
> -		mnl_attr_put_u8(nlh, ETHTOOL_A_MM_VERIFY_ENABLED, req->verify_enabled);
> -	if (req->_present.verify_time)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_MM_VERIFY_TIME, req->verify_time);
> -	if (req->_present.tx_enabled)
> -		mnl_attr_put_u8(nlh, ETHTOOL_A_MM_TX_ENABLED, req->tx_enabled);
> -	if (req->_present.pmac_enabled)
> -		mnl_attr_put_u8(nlh, ETHTOOL_A_MM_PMAC_ENABLED, req->pmac_enabled);
> -	if (req->_present.tx_min_frag_size)
> -		mnl_attr_put_u32(nlh, ETHTOOL_A_MM_TX_MIN_FRAG_SIZE, req->tx_min_frag_size);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ETHTOOL_MSG_CABLE_TEST_NTF - event */
> -int ethtool_cable_test_ntf_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct ethtool_cable_test_ntf_rsp *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -
> -	dst = yarg->data;
> -	parg.ys = yarg->ys;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_CABLE_TEST_NTF_HEADER) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.header = 1;
> -
> -			parg.rsp_policy = &ethtool_header_nest;
> -			parg.data = &dst->header;
> -			if (ethtool_header_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_CABLE_TEST_NTF_STATUS) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.status = 1;
> -			dst->status = mnl_attr_get_u8(attr);
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -void ethtool_cable_test_ntf_free(struct ethtool_cable_test_ntf *rsp)
> -{
> -	ethtool_header_free(&rsp->obj.header);
> -	free(rsp);
> -}
> -
> -/* ETHTOOL_MSG_CABLE_TEST_TDR_NTF - event */
> -int ethtool_cable_test_tdr_ntf_rsp_parse(const struct nlmsghdr *nlh,
> -					 void *data)
> -{
> -	struct ethtool_cable_test_tdr_ntf_rsp *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -
> -	dst = yarg->data;
> -	parg.ys = yarg->ys;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == ETHTOOL_A_CABLE_TEST_TDR_NTF_HEADER) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.header = 1;
> -
> -			parg.rsp_policy = &ethtool_header_nest;
> -			parg.data = &dst->header;
> -			if (ethtool_header_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == ETHTOOL_A_CABLE_TEST_TDR_NTF_STATUS) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.status = 1;
> -			dst->status = mnl_attr_get_u8(attr);
> -		} else if (type == ETHTOOL_A_CABLE_TEST_TDR_NTF_NEST) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.nest = 1;
> -
> -			parg.rsp_policy = &ethtool_cable_nest_nest;
> -			parg.data = &dst->nest;
> -			if (ethtool_cable_nest_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -void ethtool_cable_test_tdr_ntf_free(struct ethtool_cable_test_tdr_ntf *rsp)
> -{
> -	ethtool_header_free(&rsp->obj.header);
> -	ethtool_cable_nest_free(&rsp->obj.nest);
> -	free(rsp);
> -}
> -
> -static const struct ynl_ntf_info ethtool_ntf_info[] =  {
> -	[ETHTOOL_MSG_LINKINFO_NTF] =  {
> -		.alloc_sz	= sizeof(struct ethtool_linkinfo_get_ntf),
> -		.cb		= ethtool_linkinfo_get_rsp_parse,
> -		.policy		= &ethtool_linkinfo_nest,
> -		.free		= (void *)ethtool_linkinfo_get_ntf_free,
> -	},
> -	[ETHTOOL_MSG_LINKMODES_NTF] =  {
> -		.alloc_sz	= sizeof(struct ethtool_linkmodes_get_ntf),
> -		.cb		= ethtool_linkmodes_get_rsp_parse,
> -		.policy		= &ethtool_linkmodes_nest,
> -		.free		= (void *)ethtool_linkmodes_get_ntf_free,
> -	},
> -	[ETHTOOL_MSG_DEBUG_NTF] =  {
> -		.alloc_sz	= sizeof(struct ethtool_debug_get_ntf),
> -		.cb		= ethtool_debug_get_rsp_parse,
> -		.policy		= &ethtool_debug_nest,
> -		.free		= (void *)ethtool_debug_get_ntf_free,
> -	},
> -	[ETHTOOL_MSG_WOL_NTF] =  {
> -		.alloc_sz	= sizeof(struct ethtool_wol_get_ntf),
> -		.cb		= ethtool_wol_get_rsp_parse,
> -		.policy		= &ethtool_wol_nest,
> -		.free		= (void *)ethtool_wol_get_ntf_free,
> -	},
> -	[ETHTOOL_MSG_FEATURES_NTF] =  {
> -		.alloc_sz	= sizeof(struct ethtool_features_get_ntf),
> -		.cb		= ethtool_features_get_rsp_parse,
> -		.policy		= &ethtool_features_nest,
> -		.free		= (void *)ethtool_features_get_ntf_free,
> -	},
> -	[ETHTOOL_MSG_PRIVFLAGS_NTF] =  {
> -		.alloc_sz	= sizeof(struct ethtool_privflags_get_ntf),
> -		.cb		= ethtool_privflags_get_rsp_parse,
> -		.policy		= &ethtool_privflags_nest,
> -		.free		= (void *)ethtool_privflags_get_ntf_free,
> -	},
> -	[ETHTOOL_MSG_RINGS_NTF] =  {
> -		.alloc_sz	= sizeof(struct ethtool_rings_get_ntf),
> -		.cb		= ethtool_rings_get_rsp_parse,
> -		.policy		= &ethtool_rings_nest,
> -		.free		= (void *)ethtool_rings_get_ntf_free,
> -	},
> -	[ETHTOOL_MSG_CHANNELS_NTF] =  {
> -		.alloc_sz	= sizeof(struct ethtool_channels_get_ntf),
> -		.cb		= ethtool_channels_get_rsp_parse,
> -		.policy		= &ethtool_channels_nest,
> -		.free		= (void *)ethtool_channels_get_ntf_free,
> -	},
> -	[ETHTOOL_MSG_COALESCE_NTF] =  {
> -		.alloc_sz	= sizeof(struct ethtool_coalesce_get_ntf),
> -		.cb		= ethtool_coalesce_get_rsp_parse,
> -		.policy		= &ethtool_coalesce_nest,
> -		.free		= (void *)ethtool_coalesce_get_ntf_free,
> -	},
> -	[ETHTOOL_MSG_PAUSE_NTF] =  {
> -		.alloc_sz	= sizeof(struct ethtool_pause_get_ntf),
> -		.cb		= ethtool_pause_get_rsp_parse,
> -		.policy		= &ethtool_pause_nest,
> -		.free		= (void *)ethtool_pause_get_ntf_free,
> -	},
> -	[ETHTOOL_MSG_EEE_NTF] =  {
> -		.alloc_sz	= sizeof(struct ethtool_eee_get_ntf),
> -		.cb		= ethtool_eee_get_rsp_parse,
> -		.policy		= &ethtool_eee_nest,
> -		.free		= (void *)ethtool_eee_get_ntf_free,
> -	},
> -	[ETHTOOL_MSG_CABLE_TEST_NTF] =  {
> -		.alloc_sz	= sizeof(struct ethtool_cable_test_ntf),
> -		.cb		= ethtool_cable_test_ntf_rsp_parse,
> -		.policy		= &ethtool_cable_test_ntf_nest,
> -		.free		= (void *)ethtool_cable_test_ntf_free,
> -	},
> -	[ETHTOOL_MSG_CABLE_TEST_TDR_NTF] =  {
> -		.alloc_sz	= sizeof(struct ethtool_cable_test_tdr_ntf),
> -		.cb		= ethtool_cable_test_tdr_ntf_rsp_parse,
> -		.policy		= &ethtool_cable_test_tdr_ntf_nest,
> -		.free		= (void *)ethtool_cable_test_tdr_ntf_free,
> -	},
> -	[ETHTOOL_MSG_FEC_NTF] =  {
> -		.alloc_sz	= sizeof(struct ethtool_fec_get_ntf),
> -		.cb		= ethtool_fec_get_rsp_parse,
> -		.policy		= &ethtool_fec_nest,
> -		.free		= (void *)ethtool_fec_get_ntf_free,
> -	},
> -	[ETHTOOL_MSG_MODULE_NTF] =  {
> -		.alloc_sz	= sizeof(struct ethtool_module_get_ntf),
> -		.cb		= ethtool_module_get_rsp_parse,
> -		.policy		= &ethtool_module_nest,
> -		.free		= (void *)ethtool_module_get_ntf_free,
> -	},
> -	[ETHTOOL_MSG_PLCA_NTF] =  {
> -		.alloc_sz	= sizeof(struct ethtool_plca_get_cfg_ntf),
> -		.cb		= ethtool_plca_get_cfg_rsp_parse,
> -		.policy		= &ethtool_plca_nest,
> -		.free		= (void *)ethtool_plca_get_cfg_ntf_free,
> -	},
> -	[ETHTOOL_MSG_MM_NTF] =  {
> -		.alloc_sz	= sizeof(struct ethtool_mm_get_ntf),
> -		.cb		= ethtool_mm_get_rsp_parse,
> -		.policy		= &ethtool_mm_nest,
> -		.free		= (void *)ethtool_mm_get_ntf_free,
> -	},
> -};
> -
> -const struct ynl_family ynl_ethtool_family =  {
> -	.name		= "ethtool",
> -	.ntf_info	= ethtool_ntf_info,
> -	.ntf_info_size	= MNL_ARRAY_SIZE(ethtool_ntf_info),
> -};
> diff --git a/tools/net/ynl/generated/ethtool-user.h b/tools/net/ynl/generated/ethtool-user.h
> deleted file mode 100644
> index ca0ec5fd7798..000000000000
> --- a/tools/net/ynl/generated/ethtool-user.h
> +++ /dev/null
> @@ -1,5535 +0,0 @@
> -/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
> -/* Do not edit directly, auto-generated from: */
> -/*	Documentation/netlink/specs/ethtool.yaml */
> -/* YNL-GEN user header */
> -/* YNL-ARG --user-header linux/ethtool_netlink.h --exclude-op stats-get */
> -
> -#ifndef _LINUX_ETHTOOL_GEN_H
> -#define _LINUX_ETHTOOL_GEN_H
> -
> -#include <stdlib.h>
> -#include <string.h>
> -#include <linux/types.h>
> -#include <linux/ethtool.h>
> -
> -struct ynl_sock;
> -
> -extern const struct ynl_family ynl_ethtool_family;
> -
> -/* Enums */
> -const char *ethtool_op_str(int op);
> -const char *ethtool_udp_tunnel_type_str(int value);
> -const char *ethtool_stringset_str(enum ethtool_stringset value);
> -
> -/* Common nested types */
> -struct ethtool_header {
> -	struct {
> -		__u32 dev_index:1;
> -		__u32 dev_name_len;
> -		__u32 flags:1;
> -	} _present;
> -
> -	__u32 dev_index;
> -	char *dev_name;
> -	__u32 flags;
> -};
> -
> -struct ethtool_pause_stat {
> -	struct {
> -		__u32 tx_frames:1;
> -		__u32 rx_frames:1;
> -	} _present;
> -
> -	__u64 tx_frames;
> -	__u64 rx_frames;
> -};
> -
> -struct ethtool_cable_test_tdr_cfg {
> -	struct {
> -		__u32 first:1;
> -		__u32 last:1;
> -		__u32 step:1;
> -		__u32 pair:1;
> -	} _present;
> -
> -	__u32 first;
> -	__u32 last;
> -	__u32 step;
> -	__u8 pair;
> -};
> -
> -struct ethtool_fec_stat {
> -	struct {
> -		__u32 corrected_len;
> -		__u32 uncorr_len;
> -		__u32 corr_bits_len;
> -	} _present;
> -
> -	void *corrected;
> -	void *uncorr;
> -	void *corr_bits;
> -};
> -
> -struct ethtool_mm_stat {
> -	struct {
> -		__u32 reassembly_errors:1;
> -		__u32 smd_errors:1;
> -		__u32 reassembly_ok:1;
> -		__u32 rx_frag_count:1;
> -		__u32 tx_frag_count:1;
> -		__u32 hold_count:1;
> -	} _present;
> -
> -	__u64 reassembly_errors;
> -	__u64 smd_errors;
> -	__u64 reassembly_ok;
> -	__u64 rx_frag_count;
> -	__u64 tx_frag_count;
> -	__u64 hold_count;
> -};
> -
> -struct ethtool_cable_result {
> -	struct {
> -		__u32 pair:1;
> -		__u32 code:1;
> -	} _present;
> -
> -	__u8 pair;
> -	__u8 code;
> -};
> -
> -struct ethtool_cable_fault_length {
> -	struct {
> -		__u32 pair:1;
> -		__u32 cm:1;
> -	} _present;
> -
> -	__u8 pair;
> -	__u32 cm;
> -};
> -
> -struct ethtool_bitset_bit {
> -	struct {
> -		__u32 index:1;
> -		__u32 name_len;
> -		__u32 value:1;
> -	} _present;
> -
> -	__u32 index;
> -	char *name;
> -};
> -
> -struct ethtool_tunnel_udp_entry {
> -	struct {
> -		__u32 port:1;
> -		__u32 type:1;
> -	} _present;
> -
> -	__u16 port /* big-endian */;
> -	__u32 type;
> -};
> -
> -struct ethtool_string {
> -	struct {
> -		__u32 index:1;
> -		__u32 value_len;
> -	} _present;
> -
> -	__u32 index;
> -	char *value;
> -};
> -
> -struct ethtool_cable_nest {
> -	struct {
> -		__u32 result:1;
> -		__u32 fault_length:1;
> -	} _present;
> -
> -	struct ethtool_cable_result result;
> -	struct ethtool_cable_fault_length fault_length;
> -};
> -
> -struct ethtool_bitset_bits {
> -	unsigned int n_bit;
> -	struct ethtool_bitset_bit *bit;
> -};
> -
> -struct ethtool_strings {
> -	unsigned int n_string;
> -	struct ethtool_string *string;
> -};
> -
> -struct ethtool_bitset {
> -	struct {
> -		__u32 nomask:1;
> -		__u32 size:1;
> -		__u32 bits:1;
> -	} _present;
> -
> -	__u32 size;
> -	struct ethtool_bitset_bits bits;
> -};
> -
> -struct ethtool_stringset_ {
> -	struct {
> -		__u32 id:1;
> -		__u32 count:1;
> -	} _present;
> -
> -	__u32 id;
> -	__u32 count;
> -	unsigned int n_strings;
> -	struct ethtool_strings *strings;
> -};
> -
> -struct ethtool_tunnel_udp_table {
> -	struct {
> -		__u32 size:1;
> -		__u32 types:1;
> -	} _present;
> -
> -	__u32 size;
> -	struct ethtool_bitset types;
> -	unsigned int n_entry;
> -	struct ethtool_tunnel_udp_entry *entry;
> -};
> -
> -struct ethtool_stringsets {
> -	unsigned int n_stringset;
> -	struct ethtool_stringset_ *stringset;
> -};
> -
> -struct ethtool_tunnel_udp {
> -	struct {
> -		__u32 table:1;
> -	} _present;
> -
> -	struct ethtool_tunnel_udp_table table;
> -};
> -
> -/* ============== ETHTOOL_MSG_STRSET_GET ============== */
> -/* ETHTOOL_MSG_STRSET_GET - do */
> -struct ethtool_strset_get_req {
> -	struct {
> -		__u32 header:1;
> -		__u32 stringsets:1;
> -		__u32 counts_only:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	struct ethtool_stringsets stringsets;
> -};
> -
> -static inline struct ethtool_strset_get_req *ethtool_strset_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_strset_get_req));
> -}
> -void ethtool_strset_get_req_free(struct ethtool_strset_get_req *req);
> -
> -static inline void
> -ethtool_strset_get_req_set_header_dev_index(struct ethtool_strset_get_req *req,
> -					    __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_strset_get_req_set_header_dev_name(struct ethtool_strset_get_req *req,
> -					   const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_strset_get_req_set_header_flags(struct ethtool_strset_get_req *req,
> -					__u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -static inline void
> -__ethtool_strset_get_req_set_stringsets_stringset(struct ethtool_strset_get_req *req,
> -						  struct ethtool_stringset_ *stringset,
> -						  unsigned int n_stringset)
> -{
> -	free(req->stringsets.stringset);
> -	req->stringsets.stringset = stringset;
> -	req->stringsets.n_stringset = n_stringset;
> -}
> -static inline void
> -ethtool_strset_get_req_set_counts_only(struct ethtool_strset_get_req *req)
> -{
> -	req->_present.counts_only = 1;
> -}
> -
> -struct ethtool_strset_get_rsp {
> -	struct {
> -		__u32 header:1;
> -		__u32 stringsets:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	struct ethtool_stringsets stringsets;
> -};
> -
> -void ethtool_strset_get_rsp_free(struct ethtool_strset_get_rsp *rsp);
> -
> -/*
> - * Get string set from the kernel.
> - */
> -struct ethtool_strset_get_rsp *
> -ethtool_strset_get(struct ynl_sock *ys, struct ethtool_strset_get_req *req);
> -
> -/* ETHTOOL_MSG_STRSET_GET - dump */
> -struct ethtool_strset_get_req_dump {
> -	struct {
> -		__u32 header:1;
> -		__u32 stringsets:1;
> -		__u32 counts_only:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	struct ethtool_stringsets stringsets;
> -};
> -
> -static inline struct ethtool_strset_get_req_dump *
> -ethtool_strset_get_req_dump_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_strset_get_req_dump));
> -}
> -void ethtool_strset_get_req_dump_free(struct ethtool_strset_get_req_dump *req);
> -
> -static inline void
> -ethtool_strset_get_req_dump_set_header_dev_index(struct ethtool_strset_get_req_dump *req,
> -						 __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_strset_get_req_dump_set_header_dev_name(struct ethtool_strset_get_req_dump *req,
> -						const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_strset_get_req_dump_set_header_flags(struct ethtool_strset_get_req_dump *req,
> -					     __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -static inline void
> -__ethtool_strset_get_req_dump_set_stringsets_stringset(struct ethtool_strset_get_req_dump *req,
> -						       struct ethtool_stringset_ *stringset,
> -						       unsigned int n_stringset)
> -{
> -	free(req->stringsets.stringset);
> -	req->stringsets.stringset = stringset;
> -	req->stringsets.n_stringset = n_stringset;
> -}
> -static inline void
> -ethtool_strset_get_req_dump_set_counts_only(struct ethtool_strset_get_req_dump *req)
> -{
> -	req->_present.counts_only = 1;
> -}
> -
> -struct ethtool_strset_get_list {
> -	struct ethtool_strset_get_list *next;
> -	struct ethtool_strset_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void ethtool_strset_get_list_free(struct ethtool_strset_get_list *rsp);
> -
> -struct ethtool_strset_get_list *
> -ethtool_strset_get_dump(struct ynl_sock *ys,
> -			struct ethtool_strset_get_req_dump *req);
> -
> -/* ============== ETHTOOL_MSG_LINKINFO_GET ============== */
> -/* ETHTOOL_MSG_LINKINFO_GET - do */
> -struct ethtool_linkinfo_get_req {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_linkinfo_get_req *
> -ethtool_linkinfo_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_linkinfo_get_req));
> -}
> -void ethtool_linkinfo_get_req_free(struct ethtool_linkinfo_get_req *req);
> -
> -static inline void
> -ethtool_linkinfo_get_req_set_header_dev_index(struct ethtool_linkinfo_get_req *req,
> -					      __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_linkinfo_get_req_set_header_dev_name(struct ethtool_linkinfo_get_req *req,
> -					     const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_linkinfo_get_req_set_header_flags(struct ethtool_linkinfo_get_req *req,
> -					  __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_linkinfo_get_rsp {
> -	struct {
> -		__u32 header:1;
> -		__u32 port:1;
> -		__u32 phyaddr:1;
> -		__u32 tp_mdix:1;
> -		__u32 tp_mdix_ctrl:1;
> -		__u32 transceiver:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	__u8 port;
> -	__u8 phyaddr;
> -	__u8 tp_mdix;
> -	__u8 tp_mdix_ctrl;
> -	__u8 transceiver;
> -};
> -
> -void ethtool_linkinfo_get_rsp_free(struct ethtool_linkinfo_get_rsp *rsp);
> -
> -/*
> - * Get link info.
> - */
> -struct ethtool_linkinfo_get_rsp *
> -ethtool_linkinfo_get(struct ynl_sock *ys, struct ethtool_linkinfo_get_req *req);
> -
> -/* ETHTOOL_MSG_LINKINFO_GET - dump */
> -struct ethtool_linkinfo_get_req_dump {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_linkinfo_get_req_dump *
> -ethtool_linkinfo_get_req_dump_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_linkinfo_get_req_dump));
> -}
> -void
> -ethtool_linkinfo_get_req_dump_free(struct ethtool_linkinfo_get_req_dump *req);
> -
> -static inline void
> -ethtool_linkinfo_get_req_dump_set_header_dev_index(struct ethtool_linkinfo_get_req_dump *req,
> -						   __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_linkinfo_get_req_dump_set_header_dev_name(struct ethtool_linkinfo_get_req_dump *req,
> -						  const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_linkinfo_get_req_dump_set_header_flags(struct ethtool_linkinfo_get_req_dump *req,
> -					       __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_linkinfo_get_list {
> -	struct ethtool_linkinfo_get_list *next;
> -	struct ethtool_linkinfo_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void ethtool_linkinfo_get_list_free(struct ethtool_linkinfo_get_list *rsp);
> -
> -struct ethtool_linkinfo_get_list *
> -ethtool_linkinfo_get_dump(struct ynl_sock *ys,
> -			  struct ethtool_linkinfo_get_req_dump *req);
> -
> -/* ETHTOOL_MSG_LINKINFO_GET - notify */
> -struct ethtool_linkinfo_get_ntf {
> -	__u16 family;
> -	__u8 cmd;
> -	struct ynl_ntf_base_type *next;
> -	void (*free)(struct ethtool_linkinfo_get_ntf *ntf);
> -	struct ethtool_linkinfo_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void ethtool_linkinfo_get_ntf_free(struct ethtool_linkinfo_get_ntf *rsp);
> -
> -/* ============== ETHTOOL_MSG_LINKINFO_SET ============== */
> -/* ETHTOOL_MSG_LINKINFO_SET - do */
> -struct ethtool_linkinfo_set_req {
> -	struct {
> -		__u32 header:1;
> -		__u32 port:1;
> -		__u32 phyaddr:1;
> -		__u32 tp_mdix:1;
> -		__u32 tp_mdix_ctrl:1;
> -		__u32 transceiver:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	__u8 port;
> -	__u8 phyaddr;
> -	__u8 tp_mdix;
> -	__u8 tp_mdix_ctrl;
> -	__u8 transceiver;
> -};
> -
> -static inline struct ethtool_linkinfo_set_req *
> -ethtool_linkinfo_set_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_linkinfo_set_req));
> -}
> -void ethtool_linkinfo_set_req_free(struct ethtool_linkinfo_set_req *req);
> -
> -static inline void
> -ethtool_linkinfo_set_req_set_header_dev_index(struct ethtool_linkinfo_set_req *req,
> -					      __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_linkinfo_set_req_set_header_dev_name(struct ethtool_linkinfo_set_req *req,
> -					     const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_linkinfo_set_req_set_header_flags(struct ethtool_linkinfo_set_req *req,
> -					  __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -static inline void
> -ethtool_linkinfo_set_req_set_port(struct ethtool_linkinfo_set_req *req,
> -				  __u8 port)
> -{
> -	req->_present.port = 1;
> -	req->port = port;
> -}
> -static inline void
> -ethtool_linkinfo_set_req_set_phyaddr(struct ethtool_linkinfo_set_req *req,
> -				     __u8 phyaddr)
> -{
> -	req->_present.phyaddr = 1;
> -	req->phyaddr = phyaddr;
> -}
> -static inline void
> -ethtool_linkinfo_set_req_set_tp_mdix(struct ethtool_linkinfo_set_req *req,
> -				     __u8 tp_mdix)
> -{
> -	req->_present.tp_mdix = 1;
> -	req->tp_mdix = tp_mdix;
> -}
> -static inline void
> -ethtool_linkinfo_set_req_set_tp_mdix_ctrl(struct ethtool_linkinfo_set_req *req,
> -					  __u8 tp_mdix_ctrl)
> -{
> -	req->_present.tp_mdix_ctrl = 1;
> -	req->tp_mdix_ctrl = tp_mdix_ctrl;
> -}
> -static inline void
> -ethtool_linkinfo_set_req_set_transceiver(struct ethtool_linkinfo_set_req *req,
> -					 __u8 transceiver)
> -{
> -	req->_present.transceiver = 1;
> -	req->transceiver = transceiver;
> -}
> -
> -/*
> - * Set link info.
> - */
> -int ethtool_linkinfo_set(struct ynl_sock *ys,
> -			 struct ethtool_linkinfo_set_req *req);
> -
> -/* ============== ETHTOOL_MSG_LINKMODES_GET ============== */
> -/* ETHTOOL_MSG_LINKMODES_GET - do */
> -struct ethtool_linkmodes_get_req {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_linkmodes_get_req *
> -ethtool_linkmodes_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_linkmodes_get_req));
> -}
> -void ethtool_linkmodes_get_req_free(struct ethtool_linkmodes_get_req *req);
> -
> -static inline void
> -ethtool_linkmodes_get_req_set_header_dev_index(struct ethtool_linkmodes_get_req *req,
> -					       __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_linkmodes_get_req_set_header_dev_name(struct ethtool_linkmodes_get_req *req,
> -					      const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_linkmodes_get_req_set_header_flags(struct ethtool_linkmodes_get_req *req,
> -					   __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_linkmodes_get_rsp {
> -	struct {
> -		__u32 header:1;
> -		__u32 autoneg:1;
> -		__u32 ours:1;
> -		__u32 peer:1;
> -		__u32 speed:1;
> -		__u32 duplex:1;
> -		__u32 master_slave_cfg:1;
> -		__u32 master_slave_state:1;
> -		__u32 lanes:1;
> -		__u32 rate_matching:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	__u8 autoneg;
> -	struct ethtool_bitset ours;
> -	struct ethtool_bitset peer;
> -	__u32 speed;
> -	__u8 duplex;
> -	__u8 master_slave_cfg;
> -	__u8 master_slave_state;
> -	__u32 lanes;
> -	__u8 rate_matching;
> -};
> -
> -void ethtool_linkmodes_get_rsp_free(struct ethtool_linkmodes_get_rsp *rsp);
> -
> -/*
> - * Get link modes.
> - */
> -struct ethtool_linkmodes_get_rsp *
> -ethtool_linkmodes_get(struct ynl_sock *ys,
> -		      struct ethtool_linkmodes_get_req *req);
> -
> -/* ETHTOOL_MSG_LINKMODES_GET - dump */
> -struct ethtool_linkmodes_get_req_dump {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_linkmodes_get_req_dump *
> -ethtool_linkmodes_get_req_dump_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_linkmodes_get_req_dump));
> -}
> -void
> -ethtool_linkmodes_get_req_dump_free(struct ethtool_linkmodes_get_req_dump *req);
> -
> -static inline void
> -ethtool_linkmodes_get_req_dump_set_header_dev_index(struct ethtool_linkmodes_get_req_dump *req,
> -						    __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_linkmodes_get_req_dump_set_header_dev_name(struct ethtool_linkmodes_get_req_dump *req,
> -						   const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_linkmodes_get_req_dump_set_header_flags(struct ethtool_linkmodes_get_req_dump *req,
> -						__u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_linkmodes_get_list {
> -	struct ethtool_linkmodes_get_list *next;
> -	struct ethtool_linkmodes_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void ethtool_linkmodes_get_list_free(struct ethtool_linkmodes_get_list *rsp);
> -
> -struct ethtool_linkmodes_get_list *
> -ethtool_linkmodes_get_dump(struct ynl_sock *ys,
> -			   struct ethtool_linkmodes_get_req_dump *req);
> -
> -/* ETHTOOL_MSG_LINKMODES_GET - notify */
> -struct ethtool_linkmodes_get_ntf {
> -	__u16 family;
> -	__u8 cmd;
> -	struct ynl_ntf_base_type *next;
> -	void (*free)(struct ethtool_linkmodes_get_ntf *ntf);
> -	struct ethtool_linkmodes_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void ethtool_linkmodes_get_ntf_free(struct ethtool_linkmodes_get_ntf *rsp);
> -
> -/* ============== ETHTOOL_MSG_LINKMODES_SET ============== */
> -/* ETHTOOL_MSG_LINKMODES_SET - do */
> -struct ethtool_linkmodes_set_req {
> -	struct {
> -		__u32 header:1;
> -		__u32 autoneg:1;
> -		__u32 ours:1;
> -		__u32 peer:1;
> -		__u32 speed:1;
> -		__u32 duplex:1;
> -		__u32 master_slave_cfg:1;
> -		__u32 master_slave_state:1;
> -		__u32 lanes:1;
> -		__u32 rate_matching:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	__u8 autoneg;
> -	struct ethtool_bitset ours;
> -	struct ethtool_bitset peer;
> -	__u32 speed;
> -	__u8 duplex;
> -	__u8 master_slave_cfg;
> -	__u8 master_slave_state;
> -	__u32 lanes;
> -	__u8 rate_matching;
> -};
> -
> -static inline struct ethtool_linkmodes_set_req *
> -ethtool_linkmodes_set_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_linkmodes_set_req));
> -}
> -void ethtool_linkmodes_set_req_free(struct ethtool_linkmodes_set_req *req);
> -
> -static inline void
> -ethtool_linkmodes_set_req_set_header_dev_index(struct ethtool_linkmodes_set_req *req,
> -					       __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_linkmodes_set_req_set_header_dev_name(struct ethtool_linkmodes_set_req *req,
> -					      const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_linkmodes_set_req_set_header_flags(struct ethtool_linkmodes_set_req *req,
> -					   __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -static inline void
> -ethtool_linkmodes_set_req_set_autoneg(struct ethtool_linkmodes_set_req *req,
> -				      __u8 autoneg)
> -{
> -	req->_present.autoneg = 1;
> -	req->autoneg = autoneg;
> -}
> -static inline void
> -ethtool_linkmodes_set_req_set_ours_nomask(struct ethtool_linkmodes_set_req *req)
> -{
> -	req->_present.ours = 1;
> -	req->ours._present.nomask = 1;
> -}
> -static inline void
> -ethtool_linkmodes_set_req_set_ours_size(struct ethtool_linkmodes_set_req *req,
> -					__u32 size)
> -{
> -	req->_present.ours = 1;
> -	req->ours._present.size = 1;
> -	req->ours.size = size;
> -}
> -static inline void
> -__ethtool_linkmodes_set_req_set_ours_bits_bit(struct ethtool_linkmodes_set_req *req,
> -					      struct ethtool_bitset_bit *bit,
> -					      unsigned int n_bit)
> -{
> -	free(req->ours.bits.bit);
> -	req->ours.bits.bit = bit;
> -	req->ours.bits.n_bit = n_bit;
> -}
> -static inline void
> -ethtool_linkmodes_set_req_set_peer_nomask(struct ethtool_linkmodes_set_req *req)
> -{
> -	req->_present.peer = 1;
> -	req->peer._present.nomask = 1;
> -}
> -static inline void
> -ethtool_linkmodes_set_req_set_peer_size(struct ethtool_linkmodes_set_req *req,
> -					__u32 size)
> -{
> -	req->_present.peer = 1;
> -	req->peer._present.size = 1;
> -	req->peer.size = size;
> -}
> -static inline void
> -__ethtool_linkmodes_set_req_set_peer_bits_bit(struct ethtool_linkmodes_set_req *req,
> -					      struct ethtool_bitset_bit *bit,
> -					      unsigned int n_bit)
> -{
> -	free(req->peer.bits.bit);
> -	req->peer.bits.bit = bit;
> -	req->peer.bits.n_bit = n_bit;
> -}
> -static inline void
> -ethtool_linkmodes_set_req_set_speed(struct ethtool_linkmodes_set_req *req,
> -				    __u32 speed)
> -{
> -	req->_present.speed = 1;
> -	req->speed = speed;
> -}
> -static inline void
> -ethtool_linkmodes_set_req_set_duplex(struct ethtool_linkmodes_set_req *req,
> -				     __u8 duplex)
> -{
> -	req->_present.duplex = 1;
> -	req->duplex = duplex;
> -}
> -static inline void
> -ethtool_linkmodes_set_req_set_master_slave_cfg(struct ethtool_linkmodes_set_req *req,
> -					       __u8 master_slave_cfg)
> -{
> -	req->_present.master_slave_cfg = 1;
> -	req->master_slave_cfg = master_slave_cfg;
> -}
> -static inline void
> -ethtool_linkmodes_set_req_set_master_slave_state(struct ethtool_linkmodes_set_req *req,
> -						 __u8 master_slave_state)
> -{
> -	req->_present.master_slave_state = 1;
> -	req->master_slave_state = master_slave_state;
> -}
> -static inline void
> -ethtool_linkmodes_set_req_set_lanes(struct ethtool_linkmodes_set_req *req,
> -				    __u32 lanes)
> -{
> -	req->_present.lanes = 1;
> -	req->lanes = lanes;
> -}
> -static inline void
> -ethtool_linkmodes_set_req_set_rate_matching(struct ethtool_linkmodes_set_req *req,
> -					    __u8 rate_matching)
> -{
> -	req->_present.rate_matching = 1;
> -	req->rate_matching = rate_matching;
> -}
> -
> -/*
> - * Set link modes.
> - */
> -int ethtool_linkmodes_set(struct ynl_sock *ys,
> -			  struct ethtool_linkmodes_set_req *req);
> -
> -/* ============== ETHTOOL_MSG_LINKSTATE_GET ============== */
> -/* ETHTOOL_MSG_LINKSTATE_GET - do */
> -struct ethtool_linkstate_get_req {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_linkstate_get_req *
> -ethtool_linkstate_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_linkstate_get_req));
> -}
> -void ethtool_linkstate_get_req_free(struct ethtool_linkstate_get_req *req);
> -
> -static inline void
> -ethtool_linkstate_get_req_set_header_dev_index(struct ethtool_linkstate_get_req *req,
> -					       __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_linkstate_get_req_set_header_dev_name(struct ethtool_linkstate_get_req *req,
> -					      const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_linkstate_get_req_set_header_flags(struct ethtool_linkstate_get_req *req,
> -					   __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_linkstate_get_rsp {
> -	struct {
> -		__u32 header:1;
> -		__u32 link:1;
> -		__u32 sqi:1;
> -		__u32 sqi_max:1;
> -		__u32 ext_state:1;
> -		__u32 ext_substate:1;
> -		__u32 ext_down_cnt:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	__u8 link;
> -	__u32 sqi;
> -	__u32 sqi_max;
> -	__u8 ext_state;
> -	__u8 ext_substate;
> -	__u32 ext_down_cnt;
> -};
> -
> -void ethtool_linkstate_get_rsp_free(struct ethtool_linkstate_get_rsp *rsp);
> -
> -/*
> - * Get link state.
> - */
> -struct ethtool_linkstate_get_rsp *
> -ethtool_linkstate_get(struct ynl_sock *ys,
> -		      struct ethtool_linkstate_get_req *req);
> -
> -/* ETHTOOL_MSG_LINKSTATE_GET - dump */
> -struct ethtool_linkstate_get_req_dump {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_linkstate_get_req_dump *
> -ethtool_linkstate_get_req_dump_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_linkstate_get_req_dump));
> -}
> -void
> -ethtool_linkstate_get_req_dump_free(struct ethtool_linkstate_get_req_dump *req);
> -
> -static inline void
> -ethtool_linkstate_get_req_dump_set_header_dev_index(struct ethtool_linkstate_get_req_dump *req,
> -						    __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_linkstate_get_req_dump_set_header_dev_name(struct ethtool_linkstate_get_req_dump *req,
> -						   const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_linkstate_get_req_dump_set_header_flags(struct ethtool_linkstate_get_req_dump *req,
> -						__u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_linkstate_get_list {
> -	struct ethtool_linkstate_get_list *next;
> -	struct ethtool_linkstate_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void ethtool_linkstate_get_list_free(struct ethtool_linkstate_get_list *rsp);
> -
> -struct ethtool_linkstate_get_list *
> -ethtool_linkstate_get_dump(struct ynl_sock *ys,
> -			   struct ethtool_linkstate_get_req_dump *req);
> -
> -/* ============== ETHTOOL_MSG_DEBUG_GET ============== */
> -/* ETHTOOL_MSG_DEBUG_GET - do */
> -struct ethtool_debug_get_req {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_debug_get_req *ethtool_debug_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_debug_get_req));
> -}
> -void ethtool_debug_get_req_free(struct ethtool_debug_get_req *req);
> -
> -static inline void
> -ethtool_debug_get_req_set_header_dev_index(struct ethtool_debug_get_req *req,
> -					   __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_debug_get_req_set_header_dev_name(struct ethtool_debug_get_req *req,
> -					  const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_debug_get_req_set_header_flags(struct ethtool_debug_get_req *req,
> -				       __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_debug_get_rsp {
> -	struct {
> -		__u32 header:1;
> -		__u32 msgmask:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	struct ethtool_bitset msgmask;
> -};
> -
> -void ethtool_debug_get_rsp_free(struct ethtool_debug_get_rsp *rsp);
> -
> -/*
> - * Get debug message mask.
> - */
> -struct ethtool_debug_get_rsp *
> -ethtool_debug_get(struct ynl_sock *ys, struct ethtool_debug_get_req *req);
> -
> -/* ETHTOOL_MSG_DEBUG_GET - dump */
> -struct ethtool_debug_get_req_dump {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_debug_get_req_dump *
> -ethtool_debug_get_req_dump_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_debug_get_req_dump));
> -}
> -void ethtool_debug_get_req_dump_free(struct ethtool_debug_get_req_dump *req);
> -
> -static inline void
> -ethtool_debug_get_req_dump_set_header_dev_index(struct ethtool_debug_get_req_dump *req,
> -						__u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_debug_get_req_dump_set_header_dev_name(struct ethtool_debug_get_req_dump *req,
> -					       const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_debug_get_req_dump_set_header_flags(struct ethtool_debug_get_req_dump *req,
> -					    __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_debug_get_list {
> -	struct ethtool_debug_get_list *next;
> -	struct ethtool_debug_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void ethtool_debug_get_list_free(struct ethtool_debug_get_list *rsp);
> -
> -struct ethtool_debug_get_list *
> -ethtool_debug_get_dump(struct ynl_sock *ys,
> -		       struct ethtool_debug_get_req_dump *req);
> -
> -/* ETHTOOL_MSG_DEBUG_GET - notify */
> -struct ethtool_debug_get_ntf {
> -	__u16 family;
> -	__u8 cmd;
> -	struct ynl_ntf_base_type *next;
> -	void (*free)(struct ethtool_debug_get_ntf *ntf);
> -	struct ethtool_debug_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void ethtool_debug_get_ntf_free(struct ethtool_debug_get_ntf *rsp);
> -
> -/* ============== ETHTOOL_MSG_DEBUG_SET ============== */
> -/* ETHTOOL_MSG_DEBUG_SET - do */
> -struct ethtool_debug_set_req {
> -	struct {
> -		__u32 header:1;
> -		__u32 msgmask:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	struct ethtool_bitset msgmask;
> -};
> -
> -static inline struct ethtool_debug_set_req *ethtool_debug_set_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_debug_set_req));
> -}
> -void ethtool_debug_set_req_free(struct ethtool_debug_set_req *req);
> -
> -static inline void
> -ethtool_debug_set_req_set_header_dev_index(struct ethtool_debug_set_req *req,
> -					   __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_debug_set_req_set_header_dev_name(struct ethtool_debug_set_req *req,
> -					  const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_debug_set_req_set_header_flags(struct ethtool_debug_set_req *req,
> -				       __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -static inline void
> -ethtool_debug_set_req_set_msgmask_nomask(struct ethtool_debug_set_req *req)
> -{
> -	req->_present.msgmask = 1;
> -	req->msgmask._present.nomask = 1;
> -}
> -static inline void
> -ethtool_debug_set_req_set_msgmask_size(struct ethtool_debug_set_req *req,
> -				       __u32 size)
> -{
> -	req->_present.msgmask = 1;
> -	req->msgmask._present.size = 1;
> -	req->msgmask.size = size;
> -}
> -static inline void
> -__ethtool_debug_set_req_set_msgmask_bits_bit(struct ethtool_debug_set_req *req,
> -					     struct ethtool_bitset_bit *bit,
> -					     unsigned int n_bit)
> -{
> -	free(req->msgmask.bits.bit);
> -	req->msgmask.bits.bit = bit;
> -	req->msgmask.bits.n_bit = n_bit;
> -}
> -
> -/*
> - * Set debug message mask.
> - */
> -int ethtool_debug_set(struct ynl_sock *ys, struct ethtool_debug_set_req *req);
> -
> -/* ============== ETHTOOL_MSG_WOL_GET ============== */
> -/* ETHTOOL_MSG_WOL_GET - do */
> -struct ethtool_wol_get_req {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_wol_get_req *ethtool_wol_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_wol_get_req));
> -}
> -void ethtool_wol_get_req_free(struct ethtool_wol_get_req *req);
> -
> -static inline void
> -ethtool_wol_get_req_set_header_dev_index(struct ethtool_wol_get_req *req,
> -					 __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_wol_get_req_set_header_dev_name(struct ethtool_wol_get_req *req,
> -					const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_wol_get_req_set_header_flags(struct ethtool_wol_get_req *req,
> -				     __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_wol_get_rsp {
> -	struct {
> -		__u32 header:1;
> -		__u32 modes:1;
> -		__u32 sopass_len;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	struct ethtool_bitset modes;
> -	void *sopass;
> -};
> -
> -void ethtool_wol_get_rsp_free(struct ethtool_wol_get_rsp *rsp);
> -
> -/*
> - * Get WOL params.
> - */
> -struct ethtool_wol_get_rsp *
> -ethtool_wol_get(struct ynl_sock *ys, struct ethtool_wol_get_req *req);
> -
> -/* ETHTOOL_MSG_WOL_GET - dump */
> -struct ethtool_wol_get_req_dump {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_wol_get_req_dump *
> -ethtool_wol_get_req_dump_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_wol_get_req_dump));
> -}
> -void ethtool_wol_get_req_dump_free(struct ethtool_wol_get_req_dump *req);
> -
> -static inline void
> -ethtool_wol_get_req_dump_set_header_dev_index(struct ethtool_wol_get_req_dump *req,
> -					      __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_wol_get_req_dump_set_header_dev_name(struct ethtool_wol_get_req_dump *req,
> -					     const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_wol_get_req_dump_set_header_flags(struct ethtool_wol_get_req_dump *req,
> -					  __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_wol_get_list {
> -	struct ethtool_wol_get_list *next;
> -	struct ethtool_wol_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void ethtool_wol_get_list_free(struct ethtool_wol_get_list *rsp);
> -
> -struct ethtool_wol_get_list *
> -ethtool_wol_get_dump(struct ynl_sock *ys, struct ethtool_wol_get_req_dump *req);
> -
> -/* ETHTOOL_MSG_WOL_GET - notify */
> -struct ethtool_wol_get_ntf {
> -	__u16 family;
> -	__u8 cmd;
> -	struct ynl_ntf_base_type *next;
> -	void (*free)(struct ethtool_wol_get_ntf *ntf);
> -	struct ethtool_wol_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void ethtool_wol_get_ntf_free(struct ethtool_wol_get_ntf *rsp);
> -
> -/* ============== ETHTOOL_MSG_WOL_SET ============== */
> -/* ETHTOOL_MSG_WOL_SET - do */
> -struct ethtool_wol_set_req {
> -	struct {
> -		__u32 header:1;
> -		__u32 modes:1;
> -		__u32 sopass_len;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	struct ethtool_bitset modes;
> -	void *sopass;
> -};
> -
> -static inline struct ethtool_wol_set_req *ethtool_wol_set_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_wol_set_req));
> -}
> -void ethtool_wol_set_req_free(struct ethtool_wol_set_req *req);
> -
> -static inline void
> -ethtool_wol_set_req_set_header_dev_index(struct ethtool_wol_set_req *req,
> -					 __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_wol_set_req_set_header_dev_name(struct ethtool_wol_set_req *req,
> -					const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_wol_set_req_set_header_flags(struct ethtool_wol_set_req *req,
> -				     __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -static inline void
> -ethtool_wol_set_req_set_modes_nomask(struct ethtool_wol_set_req *req)
> -{
> -	req->_present.modes = 1;
> -	req->modes._present.nomask = 1;
> -}
> -static inline void
> -ethtool_wol_set_req_set_modes_size(struct ethtool_wol_set_req *req, __u32 size)
> -{
> -	req->_present.modes = 1;
> -	req->modes._present.size = 1;
> -	req->modes.size = size;
> -}
> -static inline void
> -__ethtool_wol_set_req_set_modes_bits_bit(struct ethtool_wol_set_req *req,
> -					 struct ethtool_bitset_bit *bit,
> -					 unsigned int n_bit)
> -{
> -	free(req->modes.bits.bit);
> -	req->modes.bits.bit = bit;
> -	req->modes.bits.n_bit = n_bit;
> -}
> -static inline void
> -ethtool_wol_set_req_set_sopass(struct ethtool_wol_set_req *req,
> -			       const void *sopass, size_t len)
> -{
> -	free(req->sopass);
> -	req->_present.sopass_len = len;
> -	req->sopass = malloc(req->_present.sopass_len);
> -	memcpy(req->sopass, sopass, req->_present.sopass_len);
> -}
> -
> -/*
> - * Set WOL params.
> - */
> -int ethtool_wol_set(struct ynl_sock *ys, struct ethtool_wol_set_req *req);
> -
> -/* ============== ETHTOOL_MSG_FEATURES_GET ============== */
> -/* ETHTOOL_MSG_FEATURES_GET - do */
> -struct ethtool_features_get_req {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_features_get_req *
> -ethtool_features_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_features_get_req));
> -}
> -void ethtool_features_get_req_free(struct ethtool_features_get_req *req);
> -
> -static inline void
> -ethtool_features_get_req_set_header_dev_index(struct ethtool_features_get_req *req,
> -					      __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_features_get_req_set_header_dev_name(struct ethtool_features_get_req *req,
> -					     const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_features_get_req_set_header_flags(struct ethtool_features_get_req *req,
> -					  __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_features_get_rsp {
> -	struct {
> -		__u32 header:1;
> -		__u32 hw:1;
> -		__u32 wanted:1;
> -		__u32 active:1;
> -		__u32 nochange:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	struct ethtool_bitset hw;
> -	struct ethtool_bitset wanted;
> -	struct ethtool_bitset active;
> -	struct ethtool_bitset nochange;
> -};
> -
> -void ethtool_features_get_rsp_free(struct ethtool_features_get_rsp *rsp);
> -
> -/*
> - * Get features.
> - */
> -struct ethtool_features_get_rsp *
> -ethtool_features_get(struct ynl_sock *ys, struct ethtool_features_get_req *req);
> -
> -/* ETHTOOL_MSG_FEATURES_GET - dump */
> -struct ethtool_features_get_req_dump {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_features_get_req_dump *
> -ethtool_features_get_req_dump_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_features_get_req_dump));
> -}
> -void
> -ethtool_features_get_req_dump_free(struct ethtool_features_get_req_dump *req);
> -
> -static inline void
> -ethtool_features_get_req_dump_set_header_dev_index(struct ethtool_features_get_req_dump *req,
> -						   __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_features_get_req_dump_set_header_dev_name(struct ethtool_features_get_req_dump *req,
> -						  const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_features_get_req_dump_set_header_flags(struct ethtool_features_get_req_dump *req,
> -					       __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_features_get_list {
> -	struct ethtool_features_get_list *next;
> -	struct ethtool_features_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void ethtool_features_get_list_free(struct ethtool_features_get_list *rsp);
> -
> -struct ethtool_features_get_list *
> -ethtool_features_get_dump(struct ynl_sock *ys,
> -			  struct ethtool_features_get_req_dump *req);
> -
> -/* ETHTOOL_MSG_FEATURES_GET - notify */
> -struct ethtool_features_get_ntf {
> -	__u16 family;
> -	__u8 cmd;
> -	struct ynl_ntf_base_type *next;
> -	void (*free)(struct ethtool_features_get_ntf *ntf);
> -	struct ethtool_features_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void ethtool_features_get_ntf_free(struct ethtool_features_get_ntf *rsp);
> -
> -/* ============== ETHTOOL_MSG_FEATURES_SET ============== */
> -/* ETHTOOL_MSG_FEATURES_SET - do */
> -struct ethtool_features_set_req {
> -	struct {
> -		__u32 header:1;
> -		__u32 hw:1;
> -		__u32 wanted:1;
> -		__u32 active:1;
> -		__u32 nochange:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	struct ethtool_bitset hw;
> -	struct ethtool_bitset wanted;
> -	struct ethtool_bitset active;
> -	struct ethtool_bitset nochange;
> -};
> -
> -static inline struct ethtool_features_set_req *
> -ethtool_features_set_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_features_set_req));
> -}
> -void ethtool_features_set_req_free(struct ethtool_features_set_req *req);
> -
> -static inline void
> -ethtool_features_set_req_set_header_dev_index(struct ethtool_features_set_req *req,
> -					      __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_features_set_req_set_header_dev_name(struct ethtool_features_set_req *req,
> -					     const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_features_set_req_set_header_flags(struct ethtool_features_set_req *req,
> -					  __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -static inline void
> -ethtool_features_set_req_set_hw_nomask(struct ethtool_features_set_req *req)
> -{
> -	req->_present.hw = 1;
> -	req->hw._present.nomask = 1;
> -}
> -static inline void
> -ethtool_features_set_req_set_hw_size(struct ethtool_features_set_req *req,
> -				     __u32 size)
> -{
> -	req->_present.hw = 1;
> -	req->hw._present.size = 1;
> -	req->hw.size = size;
> -}
> -static inline void
> -__ethtool_features_set_req_set_hw_bits_bit(struct ethtool_features_set_req *req,
> -					   struct ethtool_bitset_bit *bit,
> -					   unsigned int n_bit)
> -{
> -	free(req->hw.bits.bit);
> -	req->hw.bits.bit = bit;
> -	req->hw.bits.n_bit = n_bit;
> -}
> -static inline void
> -ethtool_features_set_req_set_wanted_nomask(struct ethtool_features_set_req *req)
> -{
> -	req->_present.wanted = 1;
> -	req->wanted._present.nomask = 1;
> -}
> -static inline void
> -ethtool_features_set_req_set_wanted_size(struct ethtool_features_set_req *req,
> -					 __u32 size)
> -{
> -	req->_present.wanted = 1;
> -	req->wanted._present.size = 1;
> -	req->wanted.size = size;
> -}
> -static inline void
> -__ethtool_features_set_req_set_wanted_bits_bit(struct ethtool_features_set_req *req,
> -					       struct ethtool_bitset_bit *bit,
> -					       unsigned int n_bit)
> -{
> -	free(req->wanted.bits.bit);
> -	req->wanted.bits.bit = bit;
> -	req->wanted.bits.n_bit = n_bit;
> -}
> -static inline void
> -ethtool_features_set_req_set_active_nomask(struct ethtool_features_set_req *req)
> -{
> -	req->_present.active = 1;
> -	req->active._present.nomask = 1;
> -}
> -static inline void
> -ethtool_features_set_req_set_active_size(struct ethtool_features_set_req *req,
> -					 __u32 size)
> -{
> -	req->_present.active = 1;
> -	req->active._present.size = 1;
> -	req->active.size = size;
> -}
> -static inline void
> -__ethtool_features_set_req_set_active_bits_bit(struct ethtool_features_set_req *req,
> -					       struct ethtool_bitset_bit *bit,
> -					       unsigned int n_bit)
> -{
> -	free(req->active.bits.bit);
> -	req->active.bits.bit = bit;
> -	req->active.bits.n_bit = n_bit;
> -}
> -static inline void
> -ethtool_features_set_req_set_nochange_nomask(struct ethtool_features_set_req *req)
> -{
> -	req->_present.nochange = 1;
> -	req->nochange._present.nomask = 1;
> -}
> -static inline void
> -ethtool_features_set_req_set_nochange_size(struct ethtool_features_set_req *req,
> -					   __u32 size)
> -{
> -	req->_present.nochange = 1;
> -	req->nochange._present.size = 1;
> -	req->nochange.size = size;
> -}
> -static inline void
> -__ethtool_features_set_req_set_nochange_bits_bit(struct ethtool_features_set_req *req,
> -						 struct ethtool_bitset_bit *bit,
> -						 unsigned int n_bit)
> -{
> -	free(req->nochange.bits.bit);
> -	req->nochange.bits.bit = bit;
> -	req->nochange.bits.n_bit = n_bit;
> -}
> -
> -struct ethtool_features_set_rsp {
> -	struct {
> -		__u32 header:1;
> -		__u32 hw:1;
> -		__u32 wanted:1;
> -		__u32 active:1;
> -		__u32 nochange:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	struct ethtool_bitset hw;
> -	struct ethtool_bitset wanted;
> -	struct ethtool_bitset active;
> -	struct ethtool_bitset nochange;
> -};
> -
> -void ethtool_features_set_rsp_free(struct ethtool_features_set_rsp *rsp);
> -
> -/*
> - * Set features.
> - */
> -struct ethtool_features_set_rsp *
> -ethtool_features_set(struct ynl_sock *ys, struct ethtool_features_set_req *req);
> -
> -/* ============== ETHTOOL_MSG_PRIVFLAGS_GET ============== */
> -/* ETHTOOL_MSG_PRIVFLAGS_GET - do */
> -struct ethtool_privflags_get_req {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_privflags_get_req *
> -ethtool_privflags_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_privflags_get_req));
> -}
> -void ethtool_privflags_get_req_free(struct ethtool_privflags_get_req *req);
> -
> -static inline void
> -ethtool_privflags_get_req_set_header_dev_index(struct ethtool_privflags_get_req *req,
> -					       __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_privflags_get_req_set_header_dev_name(struct ethtool_privflags_get_req *req,
> -					      const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_privflags_get_req_set_header_flags(struct ethtool_privflags_get_req *req,
> -					   __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_privflags_get_rsp {
> -	struct {
> -		__u32 header:1;
> -		__u32 flags:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	struct ethtool_bitset flags;
> -};
> -
> -void ethtool_privflags_get_rsp_free(struct ethtool_privflags_get_rsp *rsp);
> -
> -/*
> - * Get device private flags.
> - */
> -struct ethtool_privflags_get_rsp *
> -ethtool_privflags_get(struct ynl_sock *ys,
> -		      struct ethtool_privflags_get_req *req);
> -
> -/* ETHTOOL_MSG_PRIVFLAGS_GET - dump */
> -struct ethtool_privflags_get_req_dump {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_privflags_get_req_dump *
> -ethtool_privflags_get_req_dump_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_privflags_get_req_dump));
> -}
> -void
> -ethtool_privflags_get_req_dump_free(struct ethtool_privflags_get_req_dump *req);
> -
> -static inline void
> -ethtool_privflags_get_req_dump_set_header_dev_index(struct ethtool_privflags_get_req_dump *req,
> -						    __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_privflags_get_req_dump_set_header_dev_name(struct ethtool_privflags_get_req_dump *req,
> -						   const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_privflags_get_req_dump_set_header_flags(struct ethtool_privflags_get_req_dump *req,
> -						__u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_privflags_get_list {
> -	struct ethtool_privflags_get_list *next;
> -	struct ethtool_privflags_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void ethtool_privflags_get_list_free(struct ethtool_privflags_get_list *rsp);
> -
> -struct ethtool_privflags_get_list *
> -ethtool_privflags_get_dump(struct ynl_sock *ys,
> -			   struct ethtool_privflags_get_req_dump *req);
> -
> -/* ETHTOOL_MSG_PRIVFLAGS_GET - notify */
> -struct ethtool_privflags_get_ntf {
> -	__u16 family;
> -	__u8 cmd;
> -	struct ynl_ntf_base_type *next;
> -	void (*free)(struct ethtool_privflags_get_ntf *ntf);
> -	struct ethtool_privflags_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void ethtool_privflags_get_ntf_free(struct ethtool_privflags_get_ntf *rsp);
> -
> -/* ============== ETHTOOL_MSG_PRIVFLAGS_SET ============== */
> -/* ETHTOOL_MSG_PRIVFLAGS_SET - do */
> -struct ethtool_privflags_set_req {
> -	struct {
> -		__u32 header:1;
> -		__u32 flags:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	struct ethtool_bitset flags;
> -};
> -
> -static inline struct ethtool_privflags_set_req *
> -ethtool_privflags_set_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_privflags_set_req));
> -}
> -void ethtool_privflags_set_req_free(struct ethtool_privflags_set_req *req);
> -
> -static inline void
> -ethtool_privflags_set_req_set_header_dev_index(struct ethtool_privflags_set_req *req,
> -					       __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_privflags_set_req_set_header_dev_name(struct ethtool_privflags_set_req *req,
> -					      const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_privflags_set_req_set_header_flags(struct ethtool_privflags_set_req *req,
> -					   __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -static inline void
> -ethtool_privflags_set_req_set_flags_nomask(struct ethtool_privflags_set_req *req)
> -{
> -	req->_present.flags = 1;
> -	req->flags._present.nomask = 1;
> -}
> -static inline void
> -ethtool_privflags_set_req_set_flags_size(struct ethtool_privflags_set_req *req,
> -					 __u32 size)
> -{
> -	req->_present.flags = 1;
> -	req->flags._present.size = 1;
> -	req->flags.size = size;
> -}
> -static inline void
> -__ethtool_privflags_set_req_set_flags_bits_bit(struct ethtool_privflags_set_req *req,
> -					       struct ethtool_bitset_bit *bit,
> -					       unsigned int n_bit)
> -{
> -	free(req->flags.bits.bit);
> -	req->flags.bits.bit = bit;
> -	req->flags.bits.n_bit = n_bit;
> -}
> -
> -/*
> - * Set device private flags.
> - */
> -int ethtool_privflags_set(struct ynl_sock *ys,
> -			  struct ethtool_privflags_set_req *req);
> -
> -/* ============== ETHTOOL_MSG_RINGS_GET ============== */
> -/* ETHTOOL_MSG_RINGS_GET - do */
> -struct ethtool_rings_get_req {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_rings_get_req *ethtool_rings_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_rings_get_req));
> -}
> -void ethtool_rings_get_req_free(struct ethtool_rings_get_req *req);
> -
> -static inline void
> -ethtool_rings_get_req_set_header_dev_index(struct ethtool_rings_get_req *req,
> -					   __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_rings_get_req_set_header_dev_name(struct ethtool_rings_get_req *req,
> -					  const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_rings_get_req_set_header_flags(struct ethtool_rings_get_req *req,
> -				       __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_rings_get_rsp {
> -	struct {
> -		__u32 header:1;
> -		__u32 rx_max:1;
> -		__u32 rx_mini_max:1;
> -		__u32 rx_jumbo_max:1;
> -		__u32 tx_max:1;
> -		__u32 rx:1;
> -		__u32 rx_mini:1;
> -		__u32 rx_jumbo:1;
> -		__u32 tx:1;
> -		__u32 rx_buf_len:1;
> -		__u32 tcp_data_split:1;
> -		__u32 cqe_size:1;
> -		__u32 tx_push:1;
> -		__u32 rx_push:1;
> -		__u32 tx_push_buf_len:1;
> -		__u32 tx_push_buf_len_max:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	__u32 rx_max;
> -	__u32 rx_mini_max;
> -	__u32 rx_jumbo_max;
> -	__u32 tx_max;
> -	__u32 rx;
> -	__u32 rx_mini;
> -	__u32 rx_jumbo;
> -	__u32 tx;
> -	__u32 rx_buf_len;
> -	__u8 tcp_data_split;
> -	__u32 cqe_size;
> -	__u8 tx_push;
> -	__u8 rx_push;
> -	__u32 tx_push_buf_len;
> -	__u32 tx_push_buf_len_max;
> -};
> -
> -void ethtool_rings_get_rsp_free(struct ethtool_rings_get_rsp *rsp);
> -
> -/*
> - * Get ring params.
> - */
> -struct ethtool_rings_get_rsp *
> -ethtool_rings_get(struct ynl_sock *ys, struct ethtool_rings_get_req *req);
> -
> -/* ETHTOOL_MSG_RINGS_GET - dump */
> -struct ethtool_rings_get_req_dump {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_rings_get_req_dump *
> -ethtool_rings_get_req_dump_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_rings_get_req_dump));
> -}
> -void ethtool_rings_get_req_dump_free(struct ethtool_rings_get_req_dump *req);
> -
> -static inline void
> -ethtool_rings_get_req_dump_set_header_dev_index(struct ethtool_rings_get_req_dump *req,
> -						__u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_rings_get_req_dump_set_header_dev_name(struct ethtool_rings_get_req_dump *req,
> -					       const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_rings_get_req_dump_set_header_flags(struct ethtool_rings_get_req_dump *req,
> -					    __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_rings_get_list {
> -	struct ethtool_rings_get_list *next;
> -	struct ethtool_rings_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void ethtool_rings_get_list_free(struct ethtool_rings_get_list *rsp);
> -
> -struct ethtool_rings_get_list *
> -ethtool_rings_get_dump(struct ynl_sock *ys,
> -		       struct ethtool_rings_get_req_dump *req);
> -
> -/* ETHTOOL_MSG_RINGS_GET - notify */
> -struct ethtool_rings_get_ntf {
> -	__u16 family;
> -	__u8 cmd;
> -	struct ynl_ntf_base_type *next;
> -	void (*free)(struct ethtool_rings_get_ntf *ntf);
> -	struct ethtool_rings_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void ethtool_rings_get_ntf_free(struct ethtool_rings_get_ntf *rsp);
> -
> -/* ============== ETHTOOL_MSG_RINGS_SET ============== */
> -/* ETHTOOL_MSG_RINGS_SET - do */
> -struct ethtool_rings_set_req {
> -	struct {
> -		__u32 header:1;
> -		__u32 rx_max:1;
> -		__u32 rx_mini_max:1;
> -		__u32 rx_jumbo_max:1;
> -		__u32 tx_max:1;
> -		__u32 rx:1;
> -		__u32 rx_mini:1;
> -		__u32 rx_jumbo:1;
> -		__u32 tx:1;
> -		__u32 rx_buf_len:1;
> -		__u32 tcp_data_split:1;
> -		__u32 cqe_size:1;
> -		__u32 tx_push:1;
> -		__u32 rx_push:1;
> -		__u32 tx_push_buf_len:1;
> -		__u32 tx_push_buf_len_max:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	__u32 rx_max;
> -	__u32 rx_mini_max;
> -	__u32 rx_jumbo_max;
> -	__u32 tx_max;
> -	__u32 rx;
> -	__u32 rx_mini;
> -	__u32 rx_jumbo;
> -	__u32 tx;
> -	__u32 rx_buf_len;
> -	__u8 tcp_data_split;
> -	__u32 cqe_size;
> -	__u8 tx_push;
> -	__u8 rx_push;
> -	__u32 tx_push_buf_len;
> -	__u32 tx_push_buf_len_max;
> -};
> -
> -static inline struct ethtool_rings_set_req *ethtool_rings_set_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_rings_set_req));
> -}
> -void ethtool_rings_set_req_free(struct ethtool_rings_set_req *req);
> -
> -static inline void
> -ethtool_rings_set_req_set_header_dev_index(struct ethtool_rings_set_req *req,
> -					   __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_rings_set_req_set_header_dev_name(struct ethtool_rings_set_req *req,
> -					  const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_rings_set_req_set_header_flags(struct ethtool_rings_set_req *req,
> -				       __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -static inline void
> -ethtool_rings_set_req_set_rx_max(struct ethtool_rings_set_req *req,
> -				 __u32 rx_max)
> -{
> -	req->_present.rx_max = 1;
> -	req->rx_max = rx_max;
> -}
> -static inline void
> -ethtool_rings_set_req_set_rx_mini_max(struct ethtool_rings_set_req *req,
> -				      __u32 rx_mini_max)
> -{
> -	req->_present.rx_mini_max = 1;
> -	req->rx_mini_max = rx_mini_max;
> -}
> -static inline void
> -ethtool_rings_set_req_set_rx_jumbo_max(struct ethtool_rings_set_req *req,
> -				       __u32 rx_jumbo_max)
> -{
> -	req->_present.rx_jumbo_max = 1;
> -	req->rx_jumbo_max = rx_jumbo_max;
> -}
> -static inline void
> -ethtool_rings_set_req_set_tx_max(struct ethtool_rings_set_req *req,
> -				 __u32 tx_max)
> -{
> -	req->_present.tx_max = 1;
> -	req->tx_max = tx_max;
> -}
> -static inline void
> -ethtool_rings_set_req_set_rx(struct ethtool_rings_set_req *req, __u32 rx)
> -{
> -	req->_present.rx = 1;
> -	req->rx = rx;
> -}
> -static inline void
> -ethtool_rings_set_req_set_rx_mini(struct ethtool_rings_set_req *req,
> -				  __u32 rx_mini)
> -{
> -	req->_present.rx_mini = 1;
> -	req->rx_mini = rx_mini;
> -}
> -static inline void
> -ethtool_rings_set_req_set_rx_jumbo(struct ethtool_rings_set_req *req,
> -				   __u32 rx_jumbo)
> -{
> -	req->_present.rx_jumbo = 1;
> -	req->rx_jumbo = rx_jumbo;
> -}
> -static inline void
> -ethtool_rings_set_req_set_tx(struct ethtool_rings_set_req *req, __u32 tx)
> -{
> -	req->_present.tx = 1;
> -	req->tx = tx;
> -}
> -static inline void
> -ethtool_rings_set_req_set_rx_buf_len(struct ethtool_rings_set_req *req,
> -				     __u32 rx_buf_len)
> -{
> -	req->_present.rx_buf_len = 1;
> -	req->rx_buf_len = rx_buf_len;
> -}
> -static inline void
> -ethtool_rings_set_req_set_tcp_data_split(struct ethtool_rings_set_req *req,
> -					 __u8 tcp_data_split)
> -{
> -	req->_present.tcp_data_split = 1;
> -	req->tcp_data_split = tcp_data_split;
> -}
> -static inline void
> -ethtool_rings_set_req_set_cqe_size(struct ethtool_rings_set_req *req,
> -				   __u32 cqe_size)
> -{
> -	req->_present.cqe_size = 1;
> -	req->cqe_size = cqe_size;
> -}
> -static inline void
> -ethtool_rings_set_req_set_tx_push(struct ethtool_rings_set_req *req,
> -				  __u8 tx_push)
> -{
> -	req->_present.tx_push = 1;
> -	req->tx_push = tx_push;
> -}
> -static inline void
> -ethtool_rings_set_req_set_rx_push(struct ethtool_rings_set_req *req,
> -				  __u8 rx_push)
> -{
> -	req->_present.rx_push = 1;
> -	req->rx_push = rx_push;
> -}
> -static inline void
> -ethtool_rings_set_req_set_tx_push_buf_len(struct ethtool_rings_set_req *req,
> -					  __u32 tx_push_buf_len)
> -{
> -	req->_present.tx_push_buf_len = 1;
> -	req->tx_push_buf_len = tx_push_buf_len;
> -}
> -static inline void
> -ethtool_rings_set_req_set_tx_push_buf_len_max(struct ethtool_rings_set_req *req,
> -					      __u32 tx_push_buf_len_max)
> -{
> -	req->_present.tx_push_buf_len_max = 1;
> -	req->tx_push_buf_len_max = tx_push_buf_len_max;
> -}
> -
> -/*
> - * Set ring params.
> - */
> -int ethtool_rings_set(struct ynl_sock *ys, struct ethtool_rings_set_req *req);
> -
> -/* ============== ETHTOOL_MSG_CHANNELS_GET ============== */
> -/* ETHTOOL_MSG_CHANNELS_GET - do */
> -struct ethtool_channels_get_req {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_channels_get_req *
> -ethtool_channels_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_channels_get_req));
> -}
> -void ethtool_channels_get_req_free(struct ethtool_channels_get_req *req);
> -
> -static inline void
> -ethtool_channels_get_req_set_header_dev_index(struct ethtool_channels_get_req *req,
> -					      __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_channels_get_req_set_header_dev_name(struct ethtool_channels_get_req *req,
> -					     const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_channels_get_req_set_header_flags(struct ethtool_channels_get_req *req,
> -					  __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_channels_get_rsp {
> -	struct {
> -		__u32 header:1;
> -		__u32 rx_max:1;
> -		__u32 tx_max:1;
> -		__u32 other_max:1;
> -		__u32 combined_max:1;
> -		__u32 rx_count:1;
> -		__u32 tx_count:1;
> -		__u32 other_count:1;
> -		__u32 combined_count:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	__u32 rx_max;
> -	__u32 tx_max;
> -	__u32 other_max;
> -	__u32 combined_max;
> -	__u32 rx_count;
> -	__u32 tx_count;
> -	__u32 other_count;
> -	__u32 combined_count;
> -};
> -
> -void ethtool_channels_get_rsp_free(struct ethtool_channels_get_rsp *rsp);
> -
> -/*
> - * Get channel params.
> - */
> -struct ethtool_channels_get_rsp *
> -ethtool_channels_get(struct ynl_sock *ys, struct ethtool_channels_get_req *req);
> -
> -/* ETHTOOL_MSG_CHANNELS_GET - dump */
> -struct ethtool_channels_get_req_dump {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_channels_get_req_dump *
> -ethtool_channels_get_req_dump_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_channels_get_req_dump));
> -}
> -void
> -ethtool_channels_get_req_dump_free(struct ethtool_channels_get_req_dump *req);
> -
> -static inline void
> -ethtool_channels_get_req_dump_set_header_dev_index(struct ethtool_channels_get_req_dump *req,
> -						   __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_channels_get_req_dump_set_header_dev_name(struct ethtool_channels_get_req_dump *req,
> -						  const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_channels_get_req_dump_set_header_flags(struct ethtool_channels_get_req_dump *req,
> -					       __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_channels_get_list {
> -	struct ethtool_channels_get_list *next;
> -	struct ethtool_channels_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void ethtool_channels_get_list_free(struct ethtool_channels_get_list *rsp);
> -
> -struct ethtool_channels_get_list *
> -ethtool_channels_get_dump(struct ynl_sock *ys,
> -			  struct ethtool_channels_get_req_dump *req);
> -
> -/* ETHTOOL_MSG_CHANNELS_GET - notify */
> -struct ethtool_channels_get_ntf {
> -	__u16 family;
> -	__u8 cmd;
> -	struct ynl_ntf_base_type *next;
> -	void (*free)(struct ethtool_channels_get_ntf *ntf);
> -	struct ethtool_channels_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void ethtool_channels_get_ntf_free(struct ethtool_channels_get_ntf *rsp);
> -
> -/* ============== ETHTOOL_MSG_CHANNELS_SET ============== */
> -/* ETHTOOL_MSG_CHANNELS_SET - do */
> -struct ethtool_channels_set_req {
> -	struct {
> -		__u32 header:1;
> -		__u32 rx_max:1;
> -		__u32 tx_max:1;
> -		__u32 other_max:1;
> -		__u32 combined_max:1;
> -		__u32 rx_count:1;
> -		__u32 tx_count:1;
> -		__u32 other_count:1;
> -		__u32 combined_count:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	__u32 rx_max;
> -	__u32 tx_max;
> -	__u32 other_max;
> -	__u32 combined_max;
> -	__u32 rx_count;
> -	__u32 tx_count;
> -	__u32 other_count;
> -	__u32 combined_count;
> -};
> -
> -static inline struct ethtool_channels_set_req *
> -ethtool_channels_set_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_channels_set_req));
> -}
> -void ethtool_channels_set_req_free(struct ethtool_channels_set_req *req);
> -
> -static inline void
> -ethtool_channels_set_req_set_header_dev_index(struct ethtool_channels_set_req *req,
> -					      __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_channels_set_req_set_header_dev_name(struct ethtool_channels_set_req *req,
> -					     const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_channels_set_req_set_header_flags(struct ethtool_channels_set_req *req,
> -					  __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -static inline void
> -ethtool_channels_set_req_set_rx_max(struct ethtool_channels_set_req *req,
> -				    __u32 rx_max)
> -{
> -	req->_present.rx_max = 1;
> -	req->rx_max = rx_max;
> -}
> -static inline void
> -ethtool_channels_set_req_set_tx_max(struct ethtool_channels_set_req *req,
> -				    __u32 tx_max)
> -{
> -	req->_present.tx_max = 1;
> -	req->tx_max = tx_max;
> -}
> -static inline void
> -ethtool_channels_set_req_set_other_max(struct ethtool_channels_set_req *req,
> -				       __u32 other_max)
> -{
> -	req->_present.other_max = 1;
> -	req->other_max = other_max;
> -}
> -static inline void
> -ethtool_channels_set_req_set_combined_max(struct ethtool_channels_set_req *req,
> -					  __u32 combined_max)
> -{
> -	req->_present.combined_max = 1;
> -	req->combined_max = combined_max;
> -}
> -static inline void
> -ethtool_channels_set_req_set_rx_count(struct ethtool_channels_set_req *req,
> -				      __u32 rx_count)
> -{
> -	req->_present.rx_count = 1;
> -	req->rx_count = rx_count;
> -}
> -static inline void
> -ethtool_channels_set_req_set_tx_count(struct ethtool_channels_set_req *req,
> -				      __u32 tx_count)
> -{
> -	req->_present.tx_count = 1;
> -	req->tx_count = tx_count;
> -}
> -static inline void
> -ethtool_channels_set_req_set_other_count(struct ethtool_channels_set_req *req,
> -					 __u32 other_count)
> -{
> -	req->_present.other_count = 1;
> -	req->other_count = other_count;
> -}
> -static inline void
> -ethtool_channels_set_req_set_combined_count(struct ethtool_channels_set_req *req,
> -					    __u32 combined_count)
> -{
> -	req->_present.combined_count = 1;
> -	req->combined_count = combined_count;
> -}
> -
> -/*
> - * Set channel params.
> - */
> -int ethtool_channels_set(struct ynl_sock *ys,
> -			 struct ethtool_channels_set_req *req);
> -
> -/* ============== ETHTOOL_MSG_COALESCE_GET ============== */
> -/* ETHTOOL_MSG_COALESCE_GET - do */
> -struct ethtool_coalesce_get_req {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_coalesce_get_req *
> -ethtool_coalesce_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_coalesce_get_req));
> -}
> -void ethtool_coalesce_get_req_free(struct ethtool_coalesce_get_req *req);
> -
> -static inline void
> -ethtool_coalesce_get_req_set_header_dev_index(struct ethtool_coalesce_get_req *req,
> -					      __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_coalesce_get_req_set_header_dev_name(struct ethtool_coalesce_get_req *req,
> -					     const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_coalesce_get_req_set_header_flags(struct ethtool_coalesce_get_req *req,
> -					  __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_coalesce_get_rsp {
> -	struct {
> -		__u32 header:1;
> -		__u32 rx_usecs:1;
> -		__u32 rx_max_frames:1;
> -		__u32 rx_usecs_irq:1;
> -		__u32 rx_max_frames_irq:1;
> -		__u32 tx_usecs:1;
> -		__u32 tx_max_frames:1;
> -		__u32 tx_usecs_irq:1;
> -		__u32 tx_max_frames_irq:1;
> -		__u32 stats_block_usecs:1;
> -		__u32 use_adaptive_rx:1;
> -		__u32 use_adaptive_tx:1;
> -		__u32 pkt_rate_low:1;
> -		__u32 rx_usecs_low:1;
> -		__u32 rx_max_frames_low:1;
> -		__u32 tx_usecs_low:1;
> -		__u32 tx_max_frames_low:1;
> -		__u32 pkt_rate_high:1;
> -		__u32 rx_usecs_high:1;
> -		__u32 rx_max_frames_high:1;
> -		__u32 tx_usecs_high:1;
> -		__u32 tx_max_frames_high:1;
> -		__u32 rate_sample_interval:1;
> -		__u32 use_cqe_mode_tx:1;
> -		__u32 use_cqe_mode_rx:1;
> -		__u32 tx_aggr_max_bytes:1;
> -		__u32 tx_aggr_max_frames:1;
> -		__u32 tx_aggr_time_usecs:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	__u32 rx_usecs;
> -	__u32 rx_max_frames;
> -	__u32 rx_usecs_irq;
> -	__u32 rx_max_frames_irq;
> -	__u32 tx_usecs;
> -	__u32 tx_max_frames;
> -	__u32 tx_usecs_irq;
> -	__u32 tx_max_frames_irq;
> -	__u32 stats_block_usecs;
> -	__u8 use_adaptive_rx;
> -	__u8 use_adaptive_tx;
> -	__u32 pkt_rate_low;
> -	__u32 rx_usecs_low;
> -	__u32 rx_max_frames_low;
> -	__u32 tx_usecs_low;
> -	__u32 tx_max_frames_low;
> -	__u32 pkt_rate_high;
> -	__u32 rx_usecs_high;
> -	__u32 rx_max_frames_high;
> -	__u32 tx_usecs_high;
> -	__u32 tx_max_frames_high;
> -	__u32 rate_sample_interval;
> -	__u8 use_cqe_mode_tx;
> -	__u8 use_cqe_mode_rx;
> -	__u32 tx_aggr_max_bytes;
> -	__u32 tx_aggr_max_frames;
> -	__u32 tx_aggr_time_usecs;
> -};
> -
> -void ethtool_coalesce_get_rsp_free(struct ethtool_coalesce_get_rsp *rsp);
> -
> -/*
> - * Get coalesce params.
> - */
> -struct ethtool_coalesce_get_rsp *
> -ethtool_coalesce_get(struct ynl_sock *ys, struct ethtool_coalesce_get_req *req);
> -
> -/* ETHTOOL_MSG_COALESCE_GET - dump */
> -struct ethtool_coalesce_get_req_dump {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_coalesce_get_req_dump *
> -ethtool_coalesce_get_req_dump_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_coalesce_get_req_dump));
> -}
> -void
> -ethtool_coalesce_get_req_dump_free(struct ethtool_coalesce_get_req_dump *req);
> -
> -static inline void
> -ethtool_coalesce_get_req_dump_set_header_dev_index(struct ethtool_coalesce_get_req_dump *req,
> -						   __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_coalesce_get_req_dump_set_header_dev_name(struct ethtool_coalesce_get_req_dump *req,
> -						  const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_coalesce_get_req_dump_set_header_flags(struct ethtool_coalesce_get_req_dump *req,
> -					       __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_coalesce_get_list {
> -	struct ethtool_coalesce_get_list *next;
> -	struct ethtool_coalesce_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void ethtool_coalesce_get_list_free(struct ethtool_coalesce_get_list *rsp);
> -
> -struct ethtool_coalesce_get_list *
> -ethtool_coalesce_get_dump(struct ynl_sock *ys,
> -			  struct ethtool_coalesce_get_req_dump *req);
> -
> -/* ETHTOOL_MSG_COALESCE_GET - notify */
> -struct ethtool_coalesce_get_ntf {
> -	__u16 family;
> -	__u8 cmd;
> -	struct ynl_ntf_base_type *next;
> -	void (*free)(struct ethtool_coalesce_get_ntf *ntf);
> -	struct ethtool_coalesce_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void ethtool_coalesce_get_ntf_free(struct ethtool_coalesce_get_ntf *rsp);
> -
> -/* ============== ETHTOOL_MSG_COALESCE_SET ============== */
> -/* ETHTOOL_MSG_COALESCE_SET - do */
> -struct ethtool_coalesce_set_req {
> -	struct {
> -		__u32 header:1;
> -		__u32 rx_usecs:1;
> -		__u32 rx_max_frames:1;
> -		__u32 rx_usecs_irq:1;
> -		__u32 rx_max_frames_irq:1;
> -		__u32 tx_usecs:1;
> -		__u32 tx_max_frames:1;
> -		__u32 tx_usecs_irq:1;
> -		__u32 tx_max_frames_irq:1;
> -		__u32 stats_block_usecs:1;
> -		__u32 use_adaptive_rx:1;
> -		__u32 use_adaptive_tx:1;
> -		__u32 pkt_rate_low:1;
> -		__u32 rx_usecs_low:1;
> -		__u32 rx_max_frames_low:1;
> -		__u32 tx_usecs_low:1;
> -		__u32 tx_max_frames_low:1;
> -		__u32 pkt_rate_high:1;
> -		__u32 rx_usecs_high:1;
> -		__u32 rx_max_frames_high:1;
> -		__u32 tx_usecs_high:1;
> -		__u32 tx_max_frames_high:1;
> -		__u32 rate_sample_interval:1;
> -		__u32 use_cqe_mode_tx:1;
> -		__u32 use_cqe_mode_rx:1;
> -		__u32 tx_aggr_max_bytes:1;
> -		__u32 tx_aggr_max_frames:1;
> -		__u32 tx_aggr_time_usecs:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	__u32 rx_usecs;
> -	__u32 rx_max_frames;
> -	__u32 rx_usecs_irq;
> -	__u32 rx_max_frames_irq;
> -	__u32 tx_usecs;
> -	__u32 tx_max_frames;
> -	__u32 tx_usecs_irq;
> -	__u32 tx_max_frames_irq;
> -	__u32 stats_block_usecs;
> -	__u8 use_adaptive_rx;
> -	__u8 use_adaptive_tx;
> -	__u32 pkt_rate_low;
> -	__u32 rx_usecs_low;
> -	__u32 rx_max_frames_low;
> -	__u32 tx_usecs_low;
> -	__u32 tx_max_frames_low;
> -	__u32 pkt_rate_high;
> -	__u32 rx_usecs_high;
> -	__u32 rx_max_frames_high;
> -	__u32 tx_usecs_high;
> -	__u32 tx_max_frames_high;
> -	__u32 rate_sample_interval;
> -	__u8 use_cqe_mode_tx;
> -	__u8 use_cqe_mode_rx;
> -	__u32 tx_aggr_max_bytes;
> -	__u32 tx_aggr_max_frames;
> -	__u32 tx_aggr_time_usecs;
> -};
> -
> -static inline struct ethtool_coalesce_set_req *
> -ethtool_coalesce_set_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_coalesce_set_req));
> -}
> -void ethtool_coalesce_set_req_free(struct ethtool_coalesce_set_req *req);
> -
> -static inline void
> -ethtool_coalesce_set_req_set_header_dev_index(struct ethtool_coalesce_set_req *req,
> -					      __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_coalesce_set_req_set_header_dev_name(struct ethtool_coalesce_set_req *req,
> -					     const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_coalesce_set_req_set_header_flags(struct ethtool_coalesce_set_req *req,
> -					  __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -static inline void
> -ethtool_coalesce_set_req_set_rx_usecs(struct ethtool_coalesce_set_req *req,
> -				      __u32 rx_usecs)
> -{
> -	req->_present.rx_usecs = 1;
> -	req->rx_usecs = rx_usecs;
> -}
> -static inline void
> -ethtool_coalesce_set_req_set_rx_max_frames(struct ethtool_coalesce_set_req *req,
> -					   __u32 rx_max_frames)
> -{
> -	req->_present.rx_max_frames = 1;
> -	req->rx_max_frames = rx_max_frames;
> -}
> -static inline void
> -ethtool_coalesce_set_req_set_rx_usecs_irq(struct ethtool_coalesce_set_req *req,
> -					  __u32 rx_usecs_irq)
> -{
> -	req->_present.rx_usecs_irq = 1;
> -	req->rx_usecs_irq = rx_usecs_irq;
> -}
> -static inline void
> -ethtool_coalesce_set_req_set_rx_max_frames_irq(struct ethtool_coalesce_set_req *req,
> -					       __u32 rx_max_frames_irq)
> -{
> -	req->_present.rx_max_frames_irq = 1;
> -	req->rx_max_frames_irq = rx_max_frames_irq;
> -}
> -static inline void
> -ethtool_coalesce_set_req_set_tx_usecs(struct ethtool_coalesce_set_req *req,
> -				      __u32 tx_usecs)
> -{
> -	req->_present.tx_usecs = 1;
> -	req->tx_usecs = tx_usecs;
> -}
> -static inline void
> -ethtool_coalesce_set_req_set_tx_max_frames(struct ethtool_coalesce_set_req *req,
> -					   __u32 tx_max_frames)
> -{
> -	req->_present.tx_max_frames = 1;
> -	req->tx_max_frames = tx_max_frames;
> -}
> -static inline void
> -ethtool_coalesce_set_req_set_tx_usecs_irq(struct ethtool_coalesce_set_req *req,
> -					  __u32 tx_usecs_irq)
> -{
> -	req->_present.tx_usecs_irq = 1;
> -	req->tx_usecs_irq = tx_usecs_irq;
> -}
> -static inline void
> -ethtool_coalesce_set_req_set_tx_max_frames_irq(struct ethtool_coalesce_set_req *req,
> -					       __u32 tx_max_frames_irq)
> -{
> -	req->_present.tx_max_frames_irq = 1;
> -	req->tx_max_frames_irq = tx_max_frames_irq;
> -}
> -static inline void
> -ethtool_coalesce_set_req_set_stats_block_usecs(struct ethtool_coalesce_set_req *req,
> -					       __u32 stats_block_usecs)
> -{
> -	req->_present.stats_block_usecs = 1;
> -	req->stats_block_usecs = stats_block_usecs;
> -}
> -static inline void
> -ethtool_coalesce_set_req_set_use_adaptive_rx(struct ethtool_coalesce_set_req *req,
> -					     __u8 use_adaptive_rx)
> -{
> -	req->_present.use_adaptive_rx = 1;
> -	req->use_adaptive_rx = use_adaptive_rx;
> -}
> -static inline void
> -ethtool_coalesce_set_req_set_use_adaptive_tx(struct ethtool_coalesce_set_req *req,
> -					     __u8 use_adaptive_tx)
> -{
> -	req->_present.use_adaptive_tx = 1;
> -	req->use_adaptive_tx = use_adaptive_tx;
> -}
> -static inline void
> -ethtool_coalesce_set_req_set_pkt_rate_low(struct ethtool_coalesce_set_req *req,
> -					  __u32 pkt_rate_low)
> -{
> -	req->_present.pkt_rate_low = 1;
> -	req->pkt_rate_low = pkt_rate_low;
> -}
> -static inline void
> -ethtool_coalesce_set_req_set_rx_usecs_low(struct ethtool_coalesce_set_req *req,
> -					  __u32 rx_usecs_low)
> -{
> -	req->_present.rx_usecs_low = 1;
> -	req->rx_usecs_low = rx_usecs_low;
> -}
> -static inline void
> -ethtool_coalesce_set_req_set_rx_max_frames_low(struct ethtool_coalesce_set_req *req,
> -					       __u32 rx_max_frames_low)
> -{
> -	req->_present.rx_max_frames_low = 1;
> -	req->rx_max_frames_low = rx_max_frames_low;
> -}
> -static inline void
> -ethtool_coalesce_set_req_set_tx_usecs_low(struct ethtool_coalesce_set_req *req,
> -					  __u32 tx_usecs_low)
> -{
> -	req->_present.tx_usecs_low = 1;
> -	req->tx_usecs_low = tx_usecs_low;
> -}
> -static inline void
> -ethtool_coalesce_set_req_set_tx_max_frames_low(struct ethtool_coalesce_set_req *req,
> -					       __u32 tx_max_frames_low)
> -{
> -	req->_present.tx_max_frames_low = 1;
> -	req->tx_max_frames_low = tx_max_frames_low;
> -}
> -static inline void
> -ethtool_coalesce_set_req_set_pkt_rate_high(struct ethtool_coalesce_set_req *req,
> -					   __u32 pkt_rate_high)
> -{
> -	req->_present.pkt_rate_high = 1;
> -	req->pkt_rate_high = pkt_rate_high;
> -}
> -static inline void
> -ethtool_coalesce_set_req_set_rx_usecs_high(struct ethtool_coalesce_set_req *req,
> -					   __u32 rx_usecs_high)
> -{
> -	req->_present.rx_usecs_high = 1;
> -	req->rx_usecs_high = rx_usecs_high;
> -}
> -static inline void
> -ethtool_coalesce_set_req_set_rx_max_frames_high(struct ethtool_coalesce_set_req *req,
> -						__u32 rx_max_frames_high)
> -{
> -	req->_present.rx_max_frames_high = 1;
> -	req->rx_max_frames_high = rx_max_frames_high;
> -}
> -static inline void
> -ethtool_coalesce_set_req_set_tx_usecs_high(struct ethtool_coalesce_set_req *req,
> -					   __u32 tx_usecs_high)
> -{
> -	req->_present.tx_usecs_high = 1;
> -	req->tx_usecs_high = tx_usecs_high;
> -}
> -static inline void
> -ethtool_coalesce_set_req_set_tx_max_frames_high(struct ethtool_coalesce_set_req *req,
> -						__u32 tx_max_frames_high)
> -{
> -	req->_present.tx_max_frames_high = 1;
> -	req->tx_max_frames_high = tx_max_frames_high;
> -}
> -static inline void
> -ethtool_coalesce_set_req_set_rate_sample_interval(struct ethtool_coalesce_set_req *req,
> -						  __u32 rate_sample_interval)
> -{
> -	req->_present.rate_sample_interval = 1;
> -	req->rate_sample_interval = rate_sample_interval;
> -}
> -static inline void
> -ethtool_coalesce_set_req_set_use_cqe_mode_tx(struct ethtool_coalesce_set_req *req,
> -					     __u8 use_cqe_mode_tx)
> -{
> -	req->_present.use_cqe_mode_tx = 1;
> -	req->use_cqe_mode_tx = use_cqe_mode_tx;
> -}
> -static inline void
> -ethtool_coalesce_set_req_set_use_cqe_mode_rx(struct ethtool_coalesce_set_req *req,
> -					     __u8 use_cqe_mode_rx)
> -{
> -	req->_present.use_cqe_mode_rx = 1;
> -	req->use_cqe_mode_rx = use_cqe_mode_rx;
> -}
> -static inline void
> -ethtool_coalesce_set_req_set_tx_aggr_max_bytes(struct ethtool_coalesce_set_req *req,
> -					       __u32 tx_aggr_max_bytes)
> -{
> -	req->_present.tx_aggr_max_bytes = 1;
> -	req->tx_aggr_max_bytes = tx_aggr_max_bytes;
> -}
> -static inline void
> -ethtool_coalesce_set_req_set_tx_aggr_max_frames(struct ethtool_coalesce_set_req *req,
> -						__u32 tx_aggr_max_frames)
> -{
> -	req->_present.tx_aggr_max_frames = 1;
> -	req->tx_aggr_max_frames = tx_aggr_max_frames;
> -}
> -static inline void
> -ethtool_coalesce_set_req_set_tx_aggr_time_usecs(struct ethtool_coalesce_set_req *req,
> -						__u32 tx_aggr_time_usecs)
> -{
> -	req->_present.tx_aggr_time_usecs = 1;
> -	req->tx_aggr_time_usecs = tx_aggr_time_usecs;
> -}
> -
> -/*
> - * Set coalesce params.
> - */
> -int ethtool_coalesce_set(struct ynl_sock *ys,
> -			 struct ethtool_coalesce_set_req *req);
> -
> -/* ============== ETHTOOL_MSG_PAUSE_GET ============== */
> -/* ETHTOOL_MSG_PAUSE_GET - do */
> -struct ethtool_pause_get_req {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_pause_get_req *ethtool_pause_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_pause_get_req));
> -}
> -void ethtool_pause_get_req_free(struct ethtool_pause_get_req *req);
> -
> -static inline void
> -ethtool_pause_get_req_set_header_dev_index(struct ethtool_pause_get_req *req,
> -					   __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_pause_get_req_set_header_dev_name(struct ethtool_pause_get_req *req,
> -					  const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_pause_get_req_set_header_flags(struct ethtool_pause_get_req *req,
> -				       __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_pause_get_rsp {
> -	struct {
> -		__u32 header:1;
> -		__u32 autoneg:1;
> -		__u32 rx:1;
> -		__u32 tx:1;
> -		__u32 stats:1;
> -		__u32 stats_src:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	__u8 autoneg;
> -	__u8 rx;
> -	__u8 tx;
> -	struct ethtool_pause_stat stats;
> -	__u32 stats_src;
> -};
> -
> -void ethtool_pause_get_rsp_free(struct ethtool_pause_get_rsp *rsp);
> -
> -/*
> - * Get pause params.
> - */
> -struct ethtool_pause_get_rsp *
> -ethtool_pause_get(struct ynl_sock *ys, struct ethtool_pause_get_req *req);
> -
> -/* ETHTOOL_MSG_PAUSE_GET - dump */
> -struct ethtool_pause_get_req_dump {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_pause_get_req_dump *
> -ethtool_pause_get_req_dump_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_pause_get_req_dump));
> -}
> -void ethtool_pause_get_req_dump_free(struct ethtool_pause_get_req_dump *req);
> -
> -static inline void
> -ethtool_pause_get_req_dump_set_header_dev_index(struct ethtool_pause_get_req_dump *req,
> -						__u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_pause_get_req_dump_set_header_dev_name(struct ethtool_pause_get_req_dump *req,
> -					       const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_pause_get_req_dump_set_header_flags(struct ethtool_pause_get_req_dump *req,
> -					    __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_pause_get_list {
> -	struct ethtool_pause_get_list *next;
> -	struct ethtool_pause_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void ethtool_pause_get_list_free(struct ethtool_pause_get_list *rsp);
> -
> -struct ethtool_pause_get_list *
> -ethtool_pause_get_dump(struct ynl_sock *ys,
> -		       struct ethtool_pause_get_req_dump *req);
> -
> -/* ETHTOOL_MSG_PAUSE_GET - notify */
> -struct ethtool_pause_get_ntf {
> -	__u16 family;
> -	__u8 cmd;
> -	struct ynl_ntf_base_type *next;
> -	void (*free)(struct ethtool_pause_get_ntf *ntf);
> -	struct ethtool_pause_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void ethtool_pause_get_ntf_free(struct ethtool_pause_get_ntf *rsp);
> -
> -/* ============== ETHTOOL_MSG_PAUSE_SET ============== */
> -/* ETHTOOL_MSG_PAUSE_SET - do */
> -struct ethtool_pause_set_req {
> -	struct {
> -		__u32 header:1;
> -		__u32 autoneg:1;
> -		__u32 rx:1;
> -		__u32 tx:1;
> -		__u32 stats:1;
> -		__u32 stats_src:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	__u8 autoneg;
> -	__u8 rx;
> -	__u8 tx;
> -	struct ethtool_pause_stat stats;
> -	__u32 stats_src;
> -};
> -
> -static inline struct ethtool_pause_set_req *ethtool_pause_set_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_pause_set_req));
> -}
> -void ethtool_pause_set_req_free(struct ethtool_pause_set_req *req);
> -
> -static inline void
> -ethtool_pause_set_req_set_header_dev_index(struct ethtool_pause_set_req *req,
> -					   __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_pause_set_req_set_header_dev_name(struct ethtool_pause_set_req *req,
> -					  const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_pause_set_req_set_header_flags(struct ethtool_pause_set_req *req,
> -				       __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -static inline void
> -ethtool_pause_set_req_set_autoneg(struct ethtool_pause_set_req *req,
> -				  __u8 autoneg)
> -{
> -	req->_present.autoneg = 1;
> -	req->autoneg = autoneg;
> -}
> -static inline void
> -ethtool_pause_set_req_set_rx(struct ethtool_pause_set_req *req, __u8 rx)
> -{
> -	req->_present.rx = 1;
> -	req->rx = rx;
> -}
> -static inline void
> -ethtool_pause_set_req_set_tx(struct ethtool_pause_set_req *req, __u8 tx)
> -{
> -	req->_present.tx = 1;
> -	req->tx = tx;
> -}
> -static inline void
> -ethtool_pause_set_req_set_stats_tx_frames(struct ethtool_pause_set_req *req,
> -					  __u64 tx_frames)
> -{
> -	req->_present.stats = 1;
> -	req->stats._present.tx_frames = 1;
> -	req->stats.tx_frames = tx_frames;
> -}
> -static inline void
> -ethtool_pause_set_req_set_stats_rx_frames(struct ethtool_pause_set_req *req,
> -					  __u64 rx_frames)
> -{
> -	req->_present.stats = 1;
> -	req->stats._present.rx_frames = 1;
> -	req->stats.rx_frames = rx_frames;
> -}
> -static inline void
> -ethtool_pause_set_req_set_stats_src(struct ethtool_pause_set_req *req,
> -				    __u32 stats_src)
> -{
> -	req->_present.stats_src = 1;
> -	req->stats_src = stats_src;
> -}
> -
> -/*
> - * Set pause params.
> - */
> -int ethtool_pause_set(struct ynl_sock *ys, struct ethtool_pause_set_req *req);
> -
> -/* ============== ETHTOOL_MSG_EEE_GET ============== */
> -/* ETHTOOL_MSG_EEE_GET - do */
> -struct ethtool_eee_get_req {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_eee_get_req *ethtool_eee_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_eee_get_req));
> -}
> -void ethtool_eee_get_req_free(struct ethtool_eee_get_req *req);
> -
> -static inline void
> -ethtool_eee_get_req_set_header_dev_index(struct ethtool_eee_get_req *req,
> -					 __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_eee_get_req_set_header_dev_name(struct ethtool_eee_get_req *req,
> -					const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_eee_get_req_set_header_flags(struct ethtool_eee_get_req *req,
> -				     __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_eee_get_rsp {
> -	struct {
> -		__u32 header:1;
> -		__u32 modes_ours:1;
> -		__u32 modes_peer:1;
> -		__u32 active:1;
> -		__u32 enabled:1;
> -		__u32 tx_lpi_enabled:1;
> -		__u32 tx_lpi_timer:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	struct ethtool_bitset modes_ours;
> -	struct ethtool_bitset modes_peer;
> -	__u8 active;
> -	__u8 enabled;
> -	__u8 tx_lpi_enabled;
> -	__u32 tx_lpi_timer;
> -};
> -
> -void ethtool_eee_get_rsp_free(struct ethtool_eee_get_rsp *rsp);
> -
> -/*
> - * Get eee params.
> - */
> -struct ethtool_eee_get_rsp *
> -ethtool_eee_get(struct ynl_sock *ys, struct ethtool_eee_get_req *req);
> -
> -/* ETHTOOL_MSG_EEE_GET - dump */
> -struct ethtool_eee_get_req_dump {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_eee_get_req_dump *
> -ethtool_eee_get_req_dump_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_eee_get_req_dump));
> -}
> -void ethtool_eee_get_req_dump_free(struct ethtool_eee_get_req_dump *req);
> -
> -static inline void
> -ethtool_eee_get_req_dump_set_header_dev_index(struct ethtool_eee_get_req_dump *req,
> -					      __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_eee_get_req_dump_set_header_dev_name(struct ethtool_eee_get_req_dump *req,
> -					     const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_eee_get_req_dump_set_header_flags(struct ethtool_eee_get_req_dump *req,
> -					  __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_eee_get_list {
> -	struct ethtool_eee_get_list *next;
> -	struct ethtool_eee_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void ethtool_eee_get_list_free(struct ethtool_eee_get_list *rsp);
> -
> -struct ethtool_eee_get_list *
> -ethtool_eee_get_dump(struct ynl_sock *ys, struct ethtool_eee_get_req_dump *req);
> -
> -/* ETHTOOL_MSG_EEE_GET - notify */
> -struct ethtool_eee_get_ntf {
> -	__u16 family;
> -	__u8 cmd;
> -	struct ynl_ntf_base_type *next;
> -	void (*free)(struct ethtool_eee_get_ntf *ntf);
> -	struct ethtool_eee_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void ethtool_eee_get_ntf_free(struct ethtool_eee_get_ntf *rsp);
> -
> -/* ============== ETHTOOL_MSG_EEE_SET ============== */
> -/* ETHTOOL_MSG_EEE_SET - do */
> -struct ethtool_eee_set_req {
> -	struct {
> -		__u32 header:1;
> -		__u32 modes_ours:1;
> -		__u32 modes_peer:1;
> -		__u32 active:1;
> -		__u32 enabled:1;
> -		__u32 tx_lpi_enabled:1;
> -		__u32 tx_lpi_timer:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	struct ethtool_bitset modes_ours;
> -	struct ethtool_bitset modes_peer;
> -	__u8 active;
> -	__u8 enabled;
> -	__u8 tx_lpi_enabled;
> -	__u32 tx_lpi_timer;
> -};
> -
> -static inline struct ethtool_eee_set_req *ethtool_eee_set_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_eee_set_req));
> -}
> -void ethtool_eee_set_req_free(struct ethtool_eee_set_req *req);
> -
> -static inline void
> -ethtool_eee_set_req_set_header_dev_index(struct ethtool_eee_set_req *req,
> -					 __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_eee_set_req_set_header_dev_name(struct ethtool_eee_set_req *req,
> -					const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_eee_set_req_set_header_flags(struct ethtool_eee_set_req *req,
> -				     __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -static inline void
> -ethtool_eee_set_req_set_modes_ours_nomask(struct ethtool_eee_set_req *req)
> -{
> -	req->_present.modes_ours = 1;
> -	req->modes_ours._present.nomask = 1;
> -}
> -static inline void
> -ethtool_eee_set_req_set_modes_ours_size(struct ethtool_eee_set_req *req,
> -					__u32 size)
> -{
> -	req->_present.modes_ours = 1;
> -	req->modes_ours._present.size = 1;
> -	req->modes_ours.size = size;
> -}
> -static inline void
> -__ethtool_eee_set_req_set_modes_ours_bits_bit(struct ethtool_eee_set_req *req,
> -					      struct ethtool_bitset_bit *bit,
> -					      unsigned int n_bit)
> -{
> -	free(req->modes_ours.bits.bit);
> -	req->modes_ours.bits.bit = bit;
> -	req->modes_ours.bits.n_bit = n_bit;
> -}
> -static inline void
> -ethtool_eee_set_req_set_modes_peer_nomask(struct ethtool_eee_set_req *req)
> -{
> -	req->_present.modes_peer = 1;
> -	req->modes_peer._present.nomask = 1;
> -}
> -static inline void
> -ethtool_eee_set_req_set_modes_peer_size(struct ethtool_eee_set_req *req,
> -					__u32 size)
> -{
> -	req->_present.modes_peer = 1;
> -	req->modes_peer._present.size = 1;
> -	req->modes_peer.size = size;
> -}
> -static inline void
> -__ethtool_eee_set_req_set_modes_peer_bits_bit(struct ethtool_eee_set_req *req,
> -					      struct ethtool_bitset_bit *bit,
> -					      unsigned int n_bit)
> -{
> -	free(req->modes_peer.bits.bit);
> -	req->modes_peer.bits.bit = bit;
> -	req->modes_peer.bits.n_bit = n_bit;
> -}
> -static inline void
> -ethtool_eee_set_req_set_active(struct ethtool_eee_set_req *req, __u8 active)
> -{
> -	req->_present.active = 1;
> -	req->active = active;
> -}
> -static inline void
> -ethtool_eee_set_req_set_enabled(struct ethtool_eee_set_req *req, __u8 enabled)
> -{
> -	req->_present.enabled = 1;
> -	req->enabled = enabled;
> -}
> -static inline void
> -ethtool_eee_set_req_set_tx_lpi_enabled(struct ethtool_eee_set_req *req,
> -				       __u8 tx_lpi_enabled)
> -{
> -	req->_present.tx_lpi_enabled = 1;
> -	req->tx_lpi_enabled = tx_lpi_enabled;
> -}
> -static inline void
> -ethtool_eee_set_req_set_tx_lpi_timer(struct ethtool_eee_set_req *req,
> -				     __u32 tx_lpi_timer)
> -{
> -	req->_present.tx_lpi_timer = 1;
> -	req->tx_lpi_timer = tx_lpi_timer;
> -}
> -
> -/*
> - * Set eee params.
> - */
> -int ethtool_eee_set(struct ynl_sock *ys, struct ethtool_eee_set_req *req);
> -
> -/* ============== ETHTOOL_MSG_TSINFO_GET ============== */
> -/* ETHTOOL_MSG_TSINFO_GET - do */
> -struct ethtool_tsinfo_get_req {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_tsinfo_get_req *ethtool_tsinfo_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_tsinfo_get_req));
> -}
> -void ethtool_tsinfo_get_req_free(struct ethtool_tsinfo_get_req *req);
> -
> -static inline void
> -ethtool_tsinfo_get_req_set_header_dev_index(struct ethtool_tsinfo_get_req *req,
> -					    __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_tsinfo_get_req_set_header_dev_name(struct ethtool_tsinfo_get_req *req,
> -					   const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_tsinfo_get_req_set_header_flags(struct ethtool_tsinfo_get_req *req,
> -					__u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_tsinfo_get_rsp {
> -	struct {
> -		__u32 header:1;
> -		__u32 timestamping:1;
> -		__u32 tx_types:1;
> -		__u32 rx_filters:1;
> -		__u32 phc_index:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	struct ethtool_bitset timestamping;
> -	struct ethtool_bitset tx_types;
> -	struct ethtool_bitset rx_filters;
> -	__u32 phc_index;
> -};
> -
> -void ethtool_tsinfo_get_rsp_free(struct ethtool_tsinfo_get_rsp *rsp);
> -
> -/*
> - * Get tsinfo params.
> - */
> -struct ethtool_tsinfo_get_rsp *
> -ethtool_tsinfo_get(struct ynl_sock *ys, struct ethtool_tsinfo_get_req *req);
> -
> -/* ETHTOOL_MSG_TSINFO_GET - dump */
> -struct ethtool_tsinfo_get_req_dump {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_tsinfo_get_req_dump *
> -ethtool_tsinfo_get_req_dump_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_tsinfo_get_req_dump));
> -}
> -void ethtool_tsinfo_get_req_dump_free(struct ethtool_tsinfo_get_req_dump *req);
> -
> -static inline void
> -ethtool_tsinfo_get_req_dump_set_header_dev_index(struct ethtool_tsinfo_get_req_dump *req,
> -						 __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_tsinfo_get_req_dump_set_header_dev_name(struct ethtool_tsinfo_get_req_dump *req,
> -						const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_tsinfo_get_req_dump_set_header_flags(struct ethtool_tsinfo_get_req_dump *req,
> -					     __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_tsinfo_get_list {
> -	struct ethtool_tsinfo_get_list *next;
> -	struct ethtool_tsinfo_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void ethtool_tsinfo_get_list_free(struct ethtool_tsinfo_get_list *rsp);
> -
> -struct ethtool_tsinfo_get_list *
> -ethtool_tsinfo_get_dump(struct ynl_sock *ys,
> -			struct ethtool_tsinfo_get_req_dump *req);
> -
> -/* ============== ETHTOOL_MSG_CABLE_TEST_ACT ============== */
> -/* ETHTOOL_MSG_CABLE_TEST_ACT - do */
> -struct ethtool_cable_test_act_req {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_cable_test_act_req *
> -ethtool_cable_test_act_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_cable_test_act_req));
> -}
> -void ethtool_cable_test_act_req_free(struct ethtool_cable_test_act_req *req);
> -
> -static inline void
> -ethtool_cable_test_act_req_set_header_dev_index(struct ethtool_cable_test_act_req *req,
> -						__u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_cable_test_act_req_set_header_dev_name(struct ethtool_cable_test_act_req *req,
> -					       const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_cable_test_act_req_set_header_flags(struct ethtool_cable_test_act_req *req,
> -					    __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -/*
> - * Cable test.
> - */
> -int ethtool_cable_test_act(struct ynl_sock *ys,
> -			   struct ethtool_cable_test_act_req *req);
> -
> -/* ============== ETHTOOL_MSG_CABLE_TEST_TDR_ACT ============== */
> -/* ETHTOOL_MSG_CABLE_TEST_TDR_ACT - do */
> -struct ethtool_cable_test_tdr_act_req {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_cable_test_tdr_act_req *
> -ethtool_cable_test_tdr_act_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_cable_test_tdr_act_req));
> -}
> -void
> -ethtool_cable_test_tdr_act_req_free(struct ethtool_cable_test_tdr_act_req *req);
> -
> -static inline void
> -ethtool_cable_test_tdr_act_req_set_header_dev_index(struct ethtool_cable_test_tdr_act_req *req,
> -						    __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_cable_test_tdr_act_req_set_header_dev_name(struct ethtool_cable_test_tdr_act_req *req,
> -						   const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_cable_test_tdr_act_req_set_header_flags(struct ethtool_cable_test_tdr_act_req *req,
> -						__u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -/*
> - * Cable test TDR.
> - */
> -int ethtool_cable_test_tdr_act(struct ynl_sock *ys,
> -			       struct ethtool_cable_test_tdr_act_req *req);
> -
> -/* ============== ETHTOOL_MSG_TUNNEL_INFO_GET ============== */
> -/* ETHTOOL_MSG_TUNNEL_INFO_GET - do */
> -struct ethtool_tunnel_info_get_req {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_tunnel_info_get_req *
> -ethtool_tunnel_info_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_tunnel_info_get_req));
> -}
> -void ethtool_tunnel_info_get_req_free(struct ethtool_tunnel_info_get_req *req);
> -
> -static inline void
> -ethtool_tunnel_info_get_req_set_header_dev_index(struct ethtool_tunnel_info_get_req *req,
> -						 __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_tunnel_info_get_req_set_header_dev_name(struct ethtool_tunnel_info_get_req *req,
> -						const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_tunnel_info_get_req_set_header_flags(struct ethtool_tunnel_info_get_req *req,
> -					     __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_tunnel_info_get_rsp {
> -	struct {
> -		__u32 header:1;
> -		__u32 udp_ports:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	struct ethtool_tunnel_udp udp_ports;
> -};
> -
> -void ethtool_tunnel_info_get_rsp_free(struct ethtool_tunnel_info_get_rsp *rsp);
> -
> -/*
> - * Get tsinfo params.
> - */
> -struct ethtool_tunnel_info_get_rsp *
> -ethtool_tunnel_info_get(struct ynl_sock *ys,
> -			struct ethtool_tunnel_info_get_req *req);
> -
> -/* ETHTOOL_MSG_TUNNEL_INFO_GET - dump */
> -struct ethtool_tunnel_info_get_req_dump {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_tunnel_info_get_req_dump *
> -ethtool_tunnel_info_get_req_dump_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_tunnel_info_get_req_dump));
> -}
> -void
> -ethtool_tunnel_info_get_req_dump_free(struct ethtool_tunnel_info_get_req_dump *req);
> -
> -static inline void
> -ethtool_tunnel_info_get_req_dump_set_header_dev_index(struct ethtool_tunnel_info_get_req_dump *req,
> -						      __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_tunnel_info_get_req_dump_set_header_dev_name(struct ethtool_tunnel_info_get_req_dump *req,
> -						     const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_tunnel_info_get_req_dump_set_header_flags(struct ethtool_tunnel_info_get_req_dump *req,
> -						  __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_tunnel_info_get_list {
> -	struct ethtool_tunnel_info_get_list *next;
> -	struct ethtool_tunnel_info_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void
> -ethtool_tunnel_info_get_list_free(struct ethtool_tunnel_info_get_list *rsp);
> -
> -struct ethtool_tunnel_info_get_list *
> -ethtool_tunnel_info_get_dump(struct ynl_sock *ys,
> -			     struct ethtool_tunnel_info_get_req_dump *req);
> -
> -/* ============== ETHTOOL_MSG_FEC_GET ============== */
> -/* ETHTOOL_MSG_FEC_GET - do */
> -struct ethtool_fec_get_req {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_fec_get_req *ethtool_fec_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_fec_get_req));
> -}
> -void ethtool_fec_get_req_free(struct ethtool_fec_get_req *req);
> -
> -static inline void
> -ethtool_fec_get_req_set_header_dev_index(struct ethtool_fec_get_req *req,
> -					 __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_fec_get_req_set_header_dev_name(struct ethtool_fec_get_req *req,
> -					const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_fec_get_req_set_header_flags(struct ethtool_fec_get_req *req,
> -				     __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_fec_get_rsp {
> -	struct {
> -		__u32 header:1;
> -		__u32 modes:1;
> -		__u32 auto_:1;
> -		__u32 active:1;
> -		__u32 stats:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	struct ethtool_bitset modes;
> -	__u8 auto_;
> -	__u32 active;
> -	struct ethtool_fec_stat stats;
> -};
> -
> -void ethtool_fec_get_rsp_free(struct ethtool_fec_get_rsp *rsp);
> -
> -/*
> - * Get FEC params.
> - */
> -struct ethtool_fec_get_rsp *
> -ethtool_fec_get(struct ynl_sock *ys, struct ethtool_fec_get_req *req);
> -
> -/* ETHTOOL_MSG_FEC_GET - dump */
> -struct ethtool_fec_get_req_dump {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_fec_get_req_dump *
> -ethtool_fec_get_req_dump_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_fec_get_req_dump));
> -}
> -void ethtool_fec_get_req_dump_free(struct ethtool_fec_get_req_dump *req);
> -
> -static inline void
> -ethtool_fec_get_req_dump_set_header_dev_index(struct ethtool_fec_get_req_dump *req,
> -					      __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_fec_get_req_dump_set_header_dev_name(struct ethtool_fec_get_req_dump *req,
> -					     const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_fec_get_req_dump_set_header_flags(struct ethtool_fec_get_req_dump *req,
> -					  __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_fec_get_list {
> -	struct ethtool_fec_get_list *next;
> -	struct ethtool_fec_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void ethtool_fec_get_list_free(struct ethtool_fec_get_list *rsp);
> -
> -struct ethtool_fec_get_list *
> -ethtool_fec_get_dump(struct ynl_sock *ys, struct ethtool_fec_get_req_dump *req);
> -
> -/* ETHTOOL_MSG_FEC_GET - notify */
> -struct ethtool_fec_get_ntf {
> -	__u16 family;
> -	__u8 cmd;
> -	struct ynl_ntf_base_type *next;
> -	void (*free)(struct ethtool_fec_get_ntf *ntf);
> -	struct ethtool_fec_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void ethtool_fec_get_ntf_free(struct ethtool_fec_get_ntf *rsp);
> -
> -/* ============== ETHTOOL_MSG_FEC_SET ============== */
> -/* ETHTOOL_MSG_FEC_SET - do */
> -struct ethtool_fec_set_req {
> -	struct {
> -		__u32 header:1;
> -		__u32 modes:1;
> -		__u32 auto_:1;
> -		__u32 active:1;
> -		__u32 stats:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	struct ethtool_bitset modes;
> -	__u8 auto_;
> -	__u32 active;
> -	struct ethtool_fec_stat stats;
> -};
> -
> -static inline struct ethtool_fec_set_req *ethtool_fec_set_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_fec_set_req));
> -}
> -void ethtool_fec_set_req_free(struct ethtool_fec_set_req *req);
> -
> -static inline void
> -ethtool_fec_set_req_set_header_dev_index(struct ethtool_fec_set_req *req,
> -					 __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_fec_set_req_set_header_dev_name(struct ethtool_fec_set_req *req,
> -					const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_fec_set_req_set_header_flags(struct ethtool_fec_set_req *req,
> -				     __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -static inline void
> -ethtool_fec_set_req_set_modes_nomask(struct ethtool_fec_set_req *req)
> -{
> -	req->_present.modes = 1;
> -	req->modes._present.nomask = 1;
> -}
> -static inline void
> -ethtool_fec_set_req_set_modes_size(struct ethtool_fec_set_req *req, __u32 size)
> -{
> -	req->_present.modes = 1;
> -	req->modes._present.size = 1;
> -	req->modes.size = size;
> -}
> -static inline void
> -__ethtool_fec_set_req_set_modes_bits_bit(struct ethtool_fec_set_req *req,
> -					 struct ethtool_bitset_bit *bit,
> -					 unsigned int n_bit)
> -{
> -	free(req->modes.bits.bit);
> -	req->modes.bits.bit = bit;
> -	req->modes.bits.n_bit = n_bit;
> -}
> -static inline void
> -ethtool_fec_set_req_set_auto_(struct ethtool_fec_set_req *req, __u8 auto_)
> -{
> -	req->_present.auto_ = 1;
> -	req->auto_ = auto_;
> -}
> -static inline void
> -ethtool_fec_set_req_set_active(struct ethtool_fec_set_req *req, __u32 active)
> -{
> -	req->_present.active = 1;
> -	req->active = active;
> -}
> -static inline void
> -ethtool_fec_set_req_set_stats_corrected(struct ethtool_fec_set_req *req,
> -					const void *corrected, size_t len)
> -{
> -	free(req->stats.corrected);
> -	req->stats._present.corrected_len = len;
> -	req->stats.corrected = malloc(req->stats._present.corrected_len);
> -	memcpy(req->stats.corrected, corrected, req->stats._present.corrected_len);
> -}
> -static inline void
> -ethtool_fec_set_req_set_stats_uncorr(struct ethtool_fec_set_req *req,
> -				     const void *uncorr, size_t len)
> -{
> -	free(req->stats.uncorr);
> -	req->stats._present.uncorr_len = len;
> -	req->stats.uncorr = malloc(req->stats._present.uncorr_len);
> -	memcpy(req->stats.uncorr, uncorr, req->stats._present.uncorr_len);
> -}
> -static inline void
> -ethtool_fec_set_req_set_stats_corr_bits(struct ethtool_fec_set_req *req,
> -					const void *corr_bits, size_t len)
> -{
> -	free(req->stats.corr_bits);
> -	req->stats._present.corr_bits_len = len;
> -	req->stats.corr_bits = malloc(req->stats._present.corr_bits_len);
> -	memcpy(req->stats.corr_bits, corr_bits, req->stats._present.corr_bits_len);
> -}
> -
> -/*
> - * Set FEC params.
> - */
> -int ethtool_fec_set(struct ynl_sock *ys, struct ethtool_fec_set_req *req);
> -
> -/* ============== ETHTOOL_MSG_MODULE_EEPROM_GET ============== */
> -/* ETHTOOL_MSG_MODULE_EEPROM_GET - do */
> -struct ethtool_module_eeprom_get_req {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_module_eeprom_get_req *
> -ethtool_module_eeprom_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_module_eeprom_get_req));
> -}
> -void
> -ethtool_module_eeprom_get_req_free(struct ethtool_module_eeprom_get_req *req);
> -
> -static inline void
> -ethtool_module_eeprom_get_req_set_header_dev_index(struct ethtool_module_eeprom_get_req *req,
> -						   __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_module_eeprom_get_req_set_header_dev_name(struct ethtool_module_eeprom_get_req *req,
> -						  const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_module_eeprom_get_req_set_header_flags(struct ethtool_module_eeprom_get_req *req,
> -					       __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_module_eeprom_get_rsp {
> -	struct {
> -		__u32 header:1;
> -		__u32 offset:1;
> -		__u32 length:1;
> -		__u32 page:1;
> -		__u32 bank:1;
> -		__u32 i2c_address:1;
> -		__u32 data_len;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	__u32 offset;
> -	__u32 length;
> -	__u8 page;
> -	__u8 bank;
> -	__u8 i2c_address;
> -	void *data;
> -};
> -
> -void
> -ethtool_module_eeprom_get_rsp_free(struct ethtool_module_eeprom_get_rsp *rsp);
> -
> -/*
> - * Get module EEPROM params.
> - */
> -struct ethtool_module_eeprom_get_rsp *
> -ethtool_module_eeprom_get(struct ynl_sock *ys,
> -			  struct ethtool_module_eeprom_get_req *req);
> -
> -/* ETHTOOL_MSG_MODULE_EEPROM_GET - dump */
> -struct ethtool_module_eeprom_get_req_dump {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_module_eeprom_get_req_dump *
> -ethtool_module_eeprom_get_req_dump_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_module_eeprom_get_req_dump));
> -}
> -void
> -ethtool_module_eeprom_get_req_dump_free(struct ethtool_module_eeprom_get_req_dump *req);
> -
> -static inline void
> -ethtool_module_eeprom_get_req_dump_set_header_dev_index(struct ethtool_module_eeprom_get_req_dump *req,
> -							__u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_module_eeprom_get_req_dump_set_header_dev_name(struct ethtool_module_eeprom_get_req_dump *req,
> -						       const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_module_eeprom_get_req_dump_set_header_flags(struct ethtool_module_eeprom_get_req_dump *req,
> -						    __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_module_eeprom_get_list {
> -	struct ethtool_module_eeprom_get_list *next;
> -	struct ethtool_module_eeprom_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void
> -ethtool_module_eeprom_get_list_free(struct ethtool_module_eeprom_get_list *rsp);
> -
> -struct ethtool_module_eeprom_get_list *
> -ethtool_module_eeprom_get_dump(struct ynl_sock *ys,
> -			       struct ethtool_module_eeprom_get_req_dump *req);
> -
> -/* ============== ETHTOOL_MSG_PHC_VCLOCKS_GET ============== */
> -/* ETHTOOL_MSG_PHC_VCLOCKS_GET - do */
> -struct ethtool_phc_vclocks_get_req {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_phc_vclocks_get_req *
> -ethtool_phc_vclocks_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_phc_vclocks_get_req));
> -}
> -void ethtool_phc_vclocks_get_req_free(struct ethtool_phc_vclocks_get_req *req);
> -
> -static inline void
> -ethtool_phc_vclocks_get_req_set_header_dev_index(struct ethtool_phc_vclocks_get_req *req,
> -						 __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_phc_vclocks_get_req_set_header_dev_name(struct ethtool_phc_vclocks_get_req *req,
> -						const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_phc_vclocks_get_req_set_header_flags(struct ethtool_phc_vclocks_get_req *req,
> -					     __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_phc_vclocks_get_rsp {
> -	struct {
> -		__u32 header:1;
> -		__u32 num:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	__u32 num;
> -};
> -
> -void ethtool_phc_vclocks_get_rsp_free(struct ethtool_phc_vclocks_get_rsp *rsp);
> -
> -/*
> - * Get PHC VCLOCKs.
> - */
> -struct ethtool_phc_vclocks_get_rsp *
> -ethtool_phc_vclocks_get(struct ynl_sock *ys,
> -			struct ethtool_phc_vclocks_get_req *req);
> -
> -/* ETHTOOL_MSG_PHC_VCLOCKS_GET - dump */
> -struct ethtool_phc_vclocks_get_req_dump {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_phc_vclocks_get_req_dump *
> -ethtool_phc_vclocks_get_req_dump_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_phc_vclocks_get_req_dump));
> -}
> -void
> -ethtool_phc_vclocks_get_req_dump_free(struct ethtool_phc_vclocks_get_req_dump *req);
> -
> -static inline void
> -ethtool_phc_vclocks_get_req_dump_set_header_dev_index(struct ethtool_phc_vclocks_get_req_dump *req,
> -						      __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_phc_vclocks_get_req_dump_set_header_dev_name(struct ethtool_phc_vclocks_get_req_dump *req,
> -						     const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_phc_vclocks_get_req_dump_set_header_flags(struct ethtool_phc_vclocks_get_req_dump *req,
> -						  __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_phc_vclocks_get_list {
> -	struct ethtool_phc_vclocks_get_list *next;
> -	struct ethtool_phc_vclocks_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void
> -ethtool_phc_vclocks_get_list_free(struct ethtool_phc_vclocks_get_list *rsp);
> -
> -struct ethtool_phc_vclocks_get_list *
> -ethtool_phc_vclocks_get_dump(struct ynl_sock *ys,
> -			     struct ethtool_phc_vclocks_get_req_dump *req);
> -
> -/* ============== ETHTOOL_MSG_MODULE_GET ============== */
> -/* ETHTOOL_MSG_MODULE_GET - do */
> -struct ethtool_module_get_req {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_module_get_req *ethtool_module_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_module_get_req));
> -}
> -void ethtool_module_get_req_free(struct ethtool_module_get_req *req);
> -
> -static inline void
> -ethtool_module_get_req_set_header_dev_index(struct ethtool_module_get_req *req,
> -					    __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_module_get_req_set_header_dev_name(struct ethtool_module_get_req *req,
> -					   const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_module_get_req_set_header_flags(struct ethtool_module_get_req *req,
> -					__u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_module_get_rsp {
> -	struct {
> -		__u32 header:1;
> -		__u32 power_mode_policy:1;
> -		__u32 power_mode:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	__u8 power_mode_policy;
> -	__u8 power_mode;
> -};
> -
> -void ethtool_module_get_rsp_free(struct ethtool_module_get_rsp *rsp);
> -
> -/*
> - * Get module params.
> - */
> -struct ethtool_module_get_rsp *
> -ethtool_module_get(struct ynl_sock *ys, struct ethtool_module_get_req *req);
> -
> -/* ETHTOOL_MSG_MODULE_GET - dump */
> -struct ethtool_module_get_req_dump {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_module_get_req_dump *
> -ethtool_module_get_req_dump_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_module_get_req_dump));
> -}
> -void ethtool_module_get_req_dump_free(struct ethtool_module_get_req_dump *req);
> -
> -static inline void
> -ethtool_module_get_req_dump_set_header_dev_index(struct ethtool_module_get_req_dump *req,
> -						 __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_module_get_req_dump_set_header_dev_name(struct ethtool_module_get_req_dump *req,
> -						const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_module_get_req_dump_set_header_flags(struct ethtool_module_get_req_dump *req,
> -					     __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_module_get_list {
> -	struct ethtool_module_get_list *next;
> -	struct ethtool_module_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void ethtool_module_get_list_free(struct ethtool_module_get_list *rsp);
> -
> -struct ethtool_module_get_list *
> -ethtool_module_get_dump(struct ynl_sock *ys,
> -			struct ethtool_module_get_req_dump *req);
> -
> -/* ETHTOOL_MSG_MODULE_GET - notify */
> -struct ethtool_module_get_ntf {
> -	__u16 family;
> -	__u8 cmd;
> -	struct ynl_ntf_base_type *next;
> -	void (*free)(struct ethtool_module_get_ntf *ntf);
> -	struct ethtool_module_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void ethtool_module_get_ntf_free(struct ethtool_module_get_ntf *rsp);
> -
> -/* ============== ETHTOOL_MSG_MODULE_SET ============== */
> -/* ETHTOOL_MSG_MODULE_SET - do */
> -struct ethtool_module_set_req {
> -	struct {
> -		__u32 header:1;
> -		__u32 power_mode_policy:1;
> -		__u32 power_mode:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	__u8 power_mode_policy;
> -	__u8 power_mode;
> -};
> -
> -static inline struct ethtool_module_set_req *ethtool_module_set_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_module_set_req));
> -}
> -void ethtool_module_set_req_free(struct ethtool_module_set_req *req);
> -
> -static inline void
> -ethtool_module_set_req_set_header_dev_index(struct ethtool_module_set_req *req,
> -					    __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_module_set_req_set_header_dev_name(struct ethtool_module_set_req *req,
> -					   const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_module_set_req_set_header_flags(struct ethtool_module_set_req *req,
> -					__u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -static inline void
> -ethtool_module_set_req_set_power_mode_policy(struct ethtool_module_set_req *req,
> -					     __u8 power_mode_policy)
> -{
> -	req->_present.power_mode_policy = 1;
> -	req->power_mode_policy = power_mode_policy;
> -}
> -static inline void
> -ethtool_module_set_req_set_power_mode(struct ethtool_module_set_req *req,
> -				      __u8 power_mode)
> -{
> -	req->_present.power_mode = 1;
> -	req->power_mode = power_mode;
> -}
> -
> -/*
> - * Set module params.
> - */
> -int ethtool_module_set(struct ynl_sock *ys, struct ethtool_module_set_req *req);
> -
> -/* ============== ETHTOOL_MSG_PSE_GET ============== */
> -/* ETHTOOL_MSG_PSE_GET - do */
> -struct ethtool_pse_get_req {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_pse_get_req *ethtool_pse_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_pse_get_req));
> -}
> -void ethtool_pse_get_req_free(struct ethtool_pse_get_req *req);
> -
> -static inline void
> -ethtool_pse_get_req_set_header_dev_index(struct ethtool_pse_get_req *req,
> -					 __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_pse_get_req_set_header_dev_name(struct ethtool_pse_get_req *req,
> -					const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_pse_get_req_set_header_flags(struct ethtool_pse_get_req *req,
> -				     __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_pse_get_rsp {
> -	struct {
> -		__u32 header:1;
> -		__u32 admin_state:1;
> -		__u32 admin_control:1;
> -		__u32 pw_d_status:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	__u32 admin_state;
> -	__u32 admin_control;
> -	__u32 pw_d_status;
> -};
> -
> -void ethtool_pse_get_rsp_free(struct ethtool_pse_get_rsp *rsp);
> -
> -/*
> - * Get Power Sourcing Equipment params.
> - */
> -struct ethtool_pse_get_rsp *
> -ethtool_pse_get(struct ynl_sock *ys, struct ethtool_pse_get_req *req);
> -
> -/* ETHTOOL_MSG_PSE_GET - dump */
> -struct ethtool_pse_get_req_dump {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_pse_get_req_dump *
> -ethtool_pse_get_req_dump_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_pse_get_req_dump));
> -}
> -void ethtool_pse_get_req_dump_free(struct ethtool_pse_get_req_dump *req);
> -
> -static inline void
> -ethtool_pse_get_req_dump_set_header_dev_index(struct ethtool_pse_get_req_dump *req,
> -					      __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_pse_get_req_dump_set_header_dev_name(struct ethtool_pse_get_req_dump *req,
> -					     const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_pse_get_req_dump_set_header_flags(struct ethtool_pse_get_req_dump *req,
> -					  __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_pse_get_list {
> -	struct ethtool_pse_get_list *next;
> -	struct ethtool_pse_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void ethtool_pse_get_list_free(struct ethtool_pse_get_list *rsp);
> -
> -struct ethtool_pse_get_list *
> -ethtool_pse_get_dump(struct ynl_sock *ys, struct ethtool_pse_get_req_dump *req);
> -
> -/* ============== ETHTOOL_MSG_PSE_SET ============== */
> -/* ETHTOOL_MSG_PSE_SET - do */
> -struct ethtool_pse_set_req {
> -	struct {
> -		__u32 header:1;
> -		__u32 admin_state:1;
> -		__u32 admin_control:1;
> -		__u32 pw_d_status:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	__u32 admin_state;
> -	__u32 admin_control;
> -	__u32 pw_d_status;
> -};
> -
> -static inline struct ethtool_pse_set_req *ethtool_pse_set_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_pse_set_req));
> -}
> -void ethtool_pse_set_req_free(struct ethtool_pse_set_req *req);
> -
> -static inline void
> -ethtool_pse_set_req_set_header_dev_index(struct ethtool_pse_set_req *req,
> -					 __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_pse_set_req_set_header_dev_name(struct ethtool_pse_set_req *req,
> -					const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_pse_set_req_set_header_flags(struct ethtool_pse_set_req *req,
> -				     __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -static inline void
> -ethtool_pse_set_req_set_admin_state(struct ethtool_pse_set_req *req,
> -				    __u32 admin_state)
> -{
> -	req->_present.admin_state = 1;
> -	req->admin_state = admin_state;
> -}
> -static inline void
> -ethtool_pse_set_req_set_admin_control(struct ethtool_pse_set_req *req,
> -				      __u32 admin_control)
> -{
> -	req->_present.admin_control = 1;
> -	req->admin_control = admin_control;
> -}
> -static inline void
> -ethtool_pse_set_req_set_pw_d_status(struct ethtool_pse_set_req *req,
> -				    __u32 pw_d_status)
> -{
> -	req->_present.pw_d_status = 1;
> -	req->pw_d_status = pw_d_status;
> -}
> -
> -/*
> - * Set Power Sourcing Equipment params.
> - */
> -int ethtool_pse_set(struct ynl_sock *ys, struct ethtool_pse_set_req *req);
> -
> -/* ============== ETHTOOL_MSG_RSS_GET ============== */
> -/* ETHTOOL_MSG_RSS_GET - do */
> -struct ethtool_rss_get_req {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_rss_get_req *ethtool_rss_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_rss_get_req));
> -}
> -void ethtool_rss_get_req_free(struct ethtool_rss_get_req *req);
> -
> -static inline void
> -ethtool_rss_get_req_set_header_dev_index(struct ethtool_rss_get_req *req,
> -					 __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_rss_get_req_set_header_dev_name(struct ethtool_rss_get_req *req,
> -					const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_rss_get_req_set_header_flags(struct ethtool_rss_get_req *req,
> -				     __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_rss_get_rsp {
> -	struct {
> -		__u32 header:1;
> -		__u32 context:1;
> -		__u32 hfunc:1;
> -		__u32 indir_len;
> -		__u32 hkey_len;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	__u32 context;
> -	__u32 hfunc;
> -	void *indir;
> -	void *hkey;
> -};
> -
> -void ethtool_rss_get_rsp_free(struct ethtool_rss_get_rsp *rsp);
> -
> -/*
> - * Get RSS params.
> - */
> -struct ethtool_rss_get_rsp *
> -ethtool_rss_get(struct ynl_sock *ys, struct ethtool_rss_get_req *req);
> -
> -/* ETHTOOL_MSG_RSS_GET - dump */
> -struct ethtool_rss_get_req_dump {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_rss_get_req_dump *
> -ethtool_rss_get_req_dump_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_rss_get_req_dump));
> -}
> -void ethtool_rss_get_req_dump_free(struct ethtool_rss_get_req_dump *req);
> -
> -static inline void
> -ethtool_rss_get_req_dump_set_header_dev_index(struct ethtool_rss_get_req_dump *req,
> -					      __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_rss_get_req_dump_set_header_dev_name(struct ethtool_rss_get_req_dump *req,
> -					     const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_rss_get_req_dump_set_header_flags(struct ethtool_rss_get_req_dump *req,
> -					  __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_rss_get_list {
> -	struct ethtool_rss_get_list *next;
> -	struct ethtool_rss_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void ethtool_rss_get_list_free(struct ethtool_rss_get_list *rsp);
> -
> -struct ethtool_rss_get_list *
> -ethtool_rss_get_dump(struct ynl_sock *ys, struct ethtool_rss_get_req_dump *req);
> -
> -/* ============== ETHTOOL_MSG_PLCA_GET_CFG ============== */
> -/* ETHTOOL_MSG_PLCA_GET_CFG - do */
> -struct ethtool_plca_get_cfg_req {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_plca_get_cfg_req *
> -ethtool_plca_get_cfg_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_plca_get_cfg_req));
> -}
> -void ethtool_plca_get_cfg_req_free(struct ethtool_plca_get_cfg_req *req);
> -
> -static inline void
> -ethtool_plca_get_cfg_req_set_header_dev_index(struct ethtool_plca_get_cfg_req *req,
> -					      __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_plca_get_cfg_req_set_header_dev_name(struct ethtool_plca_get_cfg_req *req,
> -					     const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_plca_get_cfg_req_set_header_flags(struct ethtool_plca_get_cfg_req *req,
> -					  __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_plca_get_cfg_rsp {
> -	struct {
> -		__u32 header:1;
> -		__u32 version:1;
> -		__u32 enabled:1;
> -		__u32 status:1;
> -		__u32 node_cnt:1;
> -		__u32 node_id:1;
> -		__u32 to_tmr:1;
> -		__u32 burst_cnt:1;
> -		__u32 burst_tmr:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	__u16 version;
> -	__u8 enabled;
> -	__u8 status;
> -	__u32 node_cnt;
> -	__u32 node_id;
> -	__u32 to_tmr;
> -	__u32 burst_cnt;
> -	__u32 burst_tmr;
> -};
> -
> -void ethtool_plca_get_cfg_rsp_free(struct ethtool_plca_get_cfg_rsp *rsp);
> -
> -/*
> - * Get PLCA params.
> - */
> -struct ethtool_plca_get_cfg_rsp *
> -ethtool_plca_get_cfg(struct ynl_sock *ys, struct ethtool_plca_get_cfg_req *req);
> -
> -/* ETHTOOL_MSG_PLCA_GET_CFG - dump */
> -struct ethtool_plca_get_cfg_req_dump {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_plca_get_cfg_req_dump *
> -ethtool_plca_get_cfg_req_dump_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_plca_get_cfg_req_dump));
> -}
> -void
> -ethtool_plca_get_cfg_req_dump_free(struct ethtool_plca_get_cfg_req_dump *req);
> -
> -static inline void
> -ethtool_plca_get_cfg_req_dump_set_header_dev_index(struct ethtool_plca_get_cfg_req_dump *req,
> -						   __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_plca_get_cfg_req_dump_set_header_dev_name(struct ethtool_plca_get_cfg_req_dump *req,
> -						  const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_plca_get_cfg_req_dump_set_header_flags(struct ethtool_plca_get_cfg_req_dump *req,
> -					       __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_plca_get_cfg_list {
> -	struct ethtool_plca_get_cfg_list *next;
> -	struct ethtool_plca_get_cfg_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void ethtool_plca_get_cfg_list_free(struct ethtool_plca_get_cfg_list *rsp);
> -
> -struct ethtool_plca_get_cfg_list *
> -ethtool_plca_get_cfg_dump(struct ynl_sock *ys,
> -			  struct ethtool_plca_get_cfg_req_dump *req);
> -
> -/* ETHTOOL_MSG_PLCA_GET_CFG - notify */
> -struct ethtool_plca_get_cfg_ntf {
> -	__u16 family;
> -	__u8 cmd;
> -	struct ynl_ntf_base_type *next;
> -	void (*free)(struct ethtool_plca_get_cfg_ntf *ntf);
> -	struct ethtool_plca_get_cfg_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void ethtool_plca_get_cfg_ntf_free(struct ethtool_plca_get_cfg_ntf *rsp);
> -
> -/* ============== ETHTOOL_MSG_PLCA_SET_CFG ============== */
> -/* ETHTOOL_MSG_PLCA_SET_CFG - do */
> -struct ethtool_plca_set_cfg_req {
> -	struct {
> -		__u32 header:1;
> -		__u32 version:1;
> -		__u32 enabled:1;
> -		__u32 status:1;
> -		__u32 node_cnt:1;
> -		__u32 node_id:1;
> -		__u32 to_tmr:1;
> -		__u32 burst_cnt:1;
> -		__u32 burst_tmr:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	__u16 version;
> -	__u8 enabled;
> -	__u8 status;
> -	__u32 node_cnt;
> -	__u32 node_id;
> -	__u32 to_tmr;
> -	__u32 burst_cnt;
> -	__u32 burst_tmr;
> -};
> -
> -static inline struct ethtool_plca_set_cfg_req *
> -ethtool_plca_set_cfg_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_plca_set_cfg_req));
> -}
> -void ethtool_plca_set_cfg_req_free(struct ethtool_plca_set_cfg_req *req);
> -
> -static inline void
> -ethtool_plca_set_cfg_req_set_header_dev_index(struct ethtool_plca_set_cfg_req *req,
> -					      __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_plca_set_cfg_req_set_header_dev_name(struct ethtool_plca_set_cfg_req *req,
> -					     const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_plca_set_cfg_req_set_header_flags(struct ethtool_plca_set_cfg_req *req,
> -					  __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -static inline void
> -ethtool_plca_set_cfg_req_set_version(struct ethtool_plca_set_cfg_req *req,
> -				     __u16 version)
> -{
> -	req->_present.version = 1;
> -	req->version = version;
> -}
> -static inline void
> -ethtool_plca_set_cfg_req_set_enabled(struct ethtool_plca_set_cfg_req *req,
> -				     __u8 enabled)
> -{
> -	req->_present.enabled = 1;
> -	req->enabled = enabled;
> -}
> -static inline void
> -ethtool_plca_set_cfg_req_set_status(struct ethtool_plca_set_cfg_req *req,
> -				    __u8 status)
> -{
> -	req->_present.status = 1;
> -	req->status = status;
> -}
> -static inline void
> -ethtool_plca_set_cfg_req_set_node_cnt(struct ethtool_plca_set_cfg_req *req,
> -				      __u32 node_cnt)
> -{
> -	req->_present.node_cnt = 1;
> -	req->node_cnt = node_cnt;
> -}
> -static inline void
> -ethtool_plca_set_cfg_req_set_node_id(struct ethtool_plca_set_cfg_req *req,
> -				     __u32 node_id)
> -{
> -	req->_present.node_id = 1;
> -	req->node_id = node_id;
> -}
> -static inline void
> -ethtool_plca_set_cfg_req_set_to_tmr(struct ethtool_plca_set_cfg_req *req,
> -				    __u32 to_tmr)
> -{
> -	req->_present.to_tmr = 1;
> -	req->to_tmr = to_tmr;
> -}
> -static inline void
> -ethtool_plca_set_cfg_req_set_burst_cnt(struct ethtool_plca_set_cfg_req *req,
> -				       __u32 burst_cnt)
> -{
> -	req->_present.burst_cnt = 1;
> -	req->burst_cnt = burst_cnt;
> -}
> -static inline void
> -ethtool_plca_set_cfg_req_set_burst_tmr(struct ethtool_plca_set_cfg_req *req,
> -				       __u32 burst_tmr)
> -{
> -	req->_present.burst_tmr = 1;
> -	req->burst_tmr = burst_tmr;
> -}
> -
> -/*
> - * Set PLCA params.
> - */
> -int ethtool_plca_set_cfg(struct ynl_sock *ys,
> -			 struct ethtool_plca_set_cfg_req *req);
> -
> -/* ============== ETHTOOL_MSG_PLCA_GET_STATUS ============== */
> -/* ETHTOOL_MSG_PLCA_GET_STATUS - do */
> -struct ethtool_plca_get_status_req {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_plca_get_status_req *
> -ethtool_plca_get_status_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_plca_get_status_req));
> -}
> -void ethtool_plca_get_status_req_free(struct ethtool_plca_get_status_req *req);
> -
> -static inline void
> -ethtool_plca_get_status_req_set_header_dev_index(struct ethtool_plca_get_status_req *req,
> -						 __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_plca_get_status_req_set_header_dev_name(struct ethtool_plca_get_status_req *req,
> -						const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_plca_get_status_req_set_header_flags(struct ethtool_plca_get_status_req *req,
> -					     __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_plca_get_status_rsp {
> -	struct {
> -		__u32 header:1;
> -		__u32 version:1;
> -		__u32 enabled:1;
> -		__u32 status:1;
> -		__u32 node_cnt:1;
> -		__u32 node_id:1;
> -		__u32 to_tmr:1;
> -		__u32 burst_cnt:1;
> -		__u32 burst_tmr:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	__u16 version;
> -	__u8 enabled;
> -	__u8 status;
> -	__u32 node_cnt;
> -	__u32 node_id;
> -	__u32 to_tmr;
> -	__u32 burst_cnt;
> -	__u32 burst_tmr;
> -};
> -
> -void ethtool_plca_get_status_rsp_free(struct ethtool_plca_get_status_rsp *rsp);
> -
> -/*
> - * Get PLCA status params.
> - */
> -struct ethtool_plca_get_status_rsp *
> -ethtool_plca_get_status(struct ynl_sock *ys,
> -			struct ethtool_plca_get_status_req *req);
> -
> -/* ETHTOOL_MSG_PLCA_GET_STATUS - dump */
> -struct ethtool_plca_get_status_req_dump {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_plca_get_status_req_dump *
> -ethtool_plca_get_status_req_dump_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_plca_get_status_req_dump));
> -}
> -void
> -ethtool_plca_get_status_req_dump_free(struct ethtool_plca_get_status_req_dump *req);
> -
> -static inline void
> -ethtool_plca_get_status_req_dump_set_header_dev_index(struct ethtool_plca_get_status_req_dump *req,
> -						      __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_plca_get_status_req_dump_set_header_dev_name(struct ethtool_plca_get_status_req_dump *req,
> -						     const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_plca_get_status_req_dump_set_header_flags(struct ethtool_plca_get_status_req_dump *req,
> -						  __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_plca_get_status_list {
> -	struct ethtool_plca_get_status_list *next;
> -	struct ethtool_plca_get_status_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void
> -ethtool_plca_get_status_list_free(struct ethtool_plca_get_status_list *rsp);
> -
> -struct ethtool_plca_get_status_list *
> -ethtool_plca_get_status_dump(struct ynl_sock *ys,
> -			     struct ethtool_plca_get_status_req_dump *req);
> -
> -/* ============== ETHTOOL_MSG_MM_GET ============== */
> -/* ETHTOOL_MSG_MM_GET - do */
> -struct ethtool_mm_get_req {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_mm_get_req *ethtool_mm_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_mm_get_req));
> -}
> -void ethtool_mm_get_req_free(struct ethtool_mm_get_req *req);
> -
> -static inline void
> -ethtool_mm_get_req_set_header_dev_index(struct ethtool_mm_get_req *req,
> -					__u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_mm_get_req_set_header_dev_name(struct ethtool_mm_get_req *req,
> -				       const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_mm_get_req_set_header_flags(struct ethtool_mm_get_req *req,
> -				    __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_mm_get_rsp {
> -	struct {
> -		__u32 header:1;
> -		__u32 pmac_enabled:1;
> -		__u32 tx_enabled:1;
> -		__u32 tx_active:1;
> -		__u32 tx_min_frag_size:1;
> -		__u32 rx_min_frag_size:1;
> -		__u32 verify_enabled:1;
> -		__u32 verify_time:1;
> -		__u32 max_verify_time:1;
> -		__u32 stats:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	__u8 pmac_enabled;
> -	__u8 tx_enabled;
> -	__u8 tx_active;
> -	__u32 tx_min_frag_size;
> -	__u32 rx_min_frag_size;
> -	__u8 verify_enabled;
> -	__u32 verify_time;
> -	__u32 max_verify_time;
> -	struct ethtool_mm_stat stats;
> -};
> -
> -void ethtool_mm_get_rsp_free(struct ethtool_mm_get_rsp *rsp);
> -
> -/*
> - * Get MAC Merge configuration and state
> - */
> -struct ethtool_mm_get_rsp *
> -ethtool_mm_get(struct ynl_sock *ys, struct ethtool_mm_get_req *req);
> -
> -/* ETHTOOL_MSG_MM_GET - dump */
> -struct ethtool_mm_get_req_dump {
> -	struct {
> -		__u32 header:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -};
> -
> -static inline struct ethtool_mm_get_req_dump *
> -ethtool_mm_get_req_dump_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_mm_get_req_dump));
> -}
> -void ethtool_mm_get_req_dump_free(struct ethtool_mm_get_req_dump *req);
> -
> -static inline void
> -ethtool_mm_get_req_dump_set_header_dev_index(struct ethtool_mm_get_req_dump *req,
> -					     __u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_mm_get_req_dump_set_header_dev_name(struct ethtool_mm_get_req_dump *req,
> -					    const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_mm_get_req_dump_set_header_flags(struct ethtool_mm_get_req_dump *req,
> -					 __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -
> -struct ethtool_mm_get_list {
> -	struct ethtool_mm_get_list *next;
> -	struct ethtool_mm_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void ethtool_mm_get_list_free(struct ethtool_mm_get_list *rsp);
> -
> -struct ethtool_mm_get_list *
> -ethtool_mm_get_dump(struct ynl_sock *ys, struct ethtool_mm_get_req_dump *req);
> -
> -/* ETHTOOL_MSG_MM_GET - notify */
> -struct ethtool_mm_get_ntf {
> -	__u16 family;
> -	__u8 cmd;
> -	struct ynl_ntf_base_type *next;
> -	void (*free)(struct ethtool_mm_get_ntf *ntf);
> -	struct ethtool_mm_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void ethtool_mm_get_ntf_free(struct ethtool_mm_get_ntf *rsp);
> -
> -/* ============== ETHTOOL_MSG_MM_SET ============== */
> -/* ETHTOOL_MSG_MM_SET - do */
> -struct ethtool_mm_set_req {
> -	struct {
> -		__u32 header:1;
> -		__u32 verify_enabled:1;
> -		__u32 verify_time:1;
> -		__u32 tx_enabled:1;
> -		__u32 pmac_enabled:1;
> -		__u32 tx_min_frag_size:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	__u8 verify_enabled;
> -	__u32 verify_time;
> -	__u8 tx_enabled;
> -	__u8 pmac_enabled;
> -	__u32 tx_min_frag_size;
> -};
> -
> -static inline struct ethtool_mm_set_req *ethtool_mm_set_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct ethtool_mm_set_req));
> -}
> -void ethtool_mm_set_req_free(struct ethtool_mm_set_req *req);
> -
> -static inline void
> -ethtool_mm_set_req_set_header_dev_index(struct ethtool_mm_set_req *req,
> -					__u32 dev_index)
> -{
> -	req->_present.header = 1;
> -	req->header._present.dev_index = 1;
> -	req->header.dev_index = dev_index;
> -}
> -static inline void
> -ethtool_mm_set_req_set_header_dev_name(struct ethtool_mm_set_req *req,
> -				       const char *dev_name)
> -{
> -	free(req->header.dev_name);
> -	req->header._present.dev_name_len = strlen(dev_name);
> -	req->header.dev_name = malloc(req->header._present.dev_name_len + 1);
> -	memcpy(req->header.dev_name, dev_name, req->header._present.dev_name_len);
> -	req->header.dev_name[req->header._present.dev_name_len] = 0;
> -}
> -static inline void
> -ethtool_mm_set_req_set_header_flags(struct ethtool_mm_set_req *req,
> -				    __u32 flags)
> -{
> -	req->_present.header = 1;
> -	req->header._present.flags = 1;
> -	req->header.flags = flags;
> -}
> -static inline void
> -ethtool_mm_set_req_set_verify_enabled(struct ethtool_mm_set_req *req,
> -				      __u8 verify_enabled)
> -{
> -	req->_present.verify_enabled = 1;
> -	req->verify_enabled = verify_enabled;
> -}
> -static inline void
> -ethtool_mm_set_req_set_verify_time(struct ethtool_mm_set_req *req,
> -				   __u32 verify_time)
> -{
> -	req->_present.verify_time = 1;
> -	req->verify_time = verify_time;
> -}
> -static inline void
> -ethtool_mm_set_req_set_tx_enabled(struct ethtool_mm_set_req *req,
> -				  __u8 tx_enabled)
> -{
> -	req->_present.tx_enabled = 1;
> -	req->tx_enabled = tx_enabled;
> -}
> -static inline void
> -ethtool_mm_set_req_set_pmac_enabled(struct ethtool_mm_set_req *req,
> -				    __u8 pmac_enabled)
> -{
> -	req->_present.pmac_enabled = 1;
> -	req->pmac_enabled = pmac_enabled;
> -}
> -static inline void
> -ethtool_mm_set_req_set_tx_min_frag_size(struct ethtool_mm_set_req *req,
> -					__u32 tx_min_frag_size)
> -{
> -	req->_present.tx_min_frag_size = 1;
> -	req->tx_min_frag_size = tx_min_frag_size;
> -}
> -
> -/*
> - * Set MAC Merge configuration
> - */
> -int ethtool_mm_set(struct ynl_sock *ys, struct ethtool_mm_set_req *req);
> -
> -/* ETHTOOL_MSG_CABLE_TEST_NTF - event */
> -struct ethtool_cable_test_ntf_rsp {
> -	struct {
> -		__u32 header:1;
> -		__u32 status:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	__u8 status;
> -};
> -
> -struct ethtool_cable_test_ntf {
> -	__u16 family;
> -	__u8 cmd;
> -	struct ynl_ntf_base_type *next;
> -	void (*free)(struct ethtool_cable_test_ntf *ntf);
> -	struct ethtool_cable_test_ntf_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void ethtool_cable_test_ntf_free(struct ethtool_cable_test_ntf *rsp);
> -
> -/* ETHTOOL_MSG_CABLE_TEST_TDR_NTF - event */
> -struct ethtool_cable_test_tdr_ntf_rsp {
> -	struct {
> -		__u32 header:1;
> -		__u32 status:1;
> -		__u32 nest:1;
> -	} _present;
> -
> -	struct ethtool_header header;
> -	__u8 status;
> -	struct ethtool_cable_nest nest;
> -};
> -
> -struct ethtool_cable_test_tdr_ntf {
> -	__u16 family;
> -	__u8 cmd;
> -	struct ynl_ntf_base_type *next;
> -	void (*free)(struct ethtool_cable_test_tdr_ntf *ntf);
> -	struct ethtool_cable_test_tdr_ntf_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void ethtool_cable_test_tdr_ntf_free(struct ethtool_cable_test_tdr_ntf *rsp);
> -
> -#endif /* _LINUX_ETHTOOL_GEN_H */
> diff --git a/tools/net/ynl/generated/fou-user.c b/tools/net/ynl/generated/fou-user.c
> deleted file mode 100644
> index f30bef23bc31..000000000000
> --- a/tools/net/ynl/generated/fou-user.c
> +++ /dev/null
> @@ -1,330 +0,0 @@
> -// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> -/* Do not edit directly, auto-generated from: */
> -/*	Documentation/netlink/specs/fou.yaml */
> -/* YNL-GEN user source */
> -
> -#include <stdlib.h>
> -#include <string.h>
> -#include "fou-user.h"
> -#include "ynl.h"
> -#include <linux/fou.h>
> -
> -#include <libmnl/libmnl.h>
> -#include <linux/genetlink.h>
> -
> -/* Enums */
> -static const char * const fou_op_strmap[] = {
> -	[FOU_CMD_ADD] = "add",
> -	[FOU_CMD_DEL] = "del",
> -	[FOU_CMD_GET] = "get",
> -};
> -
> -const char *fou_op_str(int op)
> -{
> -	if (op < 0 || op >= (int)MNL_ARRAY_SIZE(fou_op_strmap))
> -		return NULL;
> -	return fou_op_strmap[op];
> -}
> -
> -static const char * const fou_encap_type_strmap[] = {
> -	[0] = "unspec",
> -	[1] = "direct",
> -	[2] = "gue",
> -};
> -
> -const char *fou_encap_type_str(int value)
> -{
> -	if (value < 0 || value >= (int)MNL_ARRAY_SIZE(fou_encap_type_strmap))
> -		return NULL;
> -	return fou_encap_type_strmap[value];
> -}
> -
> -/* Policies */
> -struct ynl_policy_attr fou_policy[FOU_ATTR_MAX + 1] = {
> -	[FOU_ATTR_UNSPEC] = { .name = "unspec", .type = YNL_PT_REJECT, },
> -	[FOU_ATTR_PORT] = { .name = "port", .type = YNL_PT_U16, },
> -	[FOU_ATTR_AF] = { .name = "af", .type = YNL_PT_U8, },
> -	[FOU_ATTR_IPPROTO] = { .name = "ipproto", .type = YNL_PT_U8, },
> -	[FOU_ATTR_TYPE] = { .name = "type", .type = YNL_PT_U8, },
> -	[FOU_ATTR_REMCSUM_NOPARTIAL] = { .name = "remcsum_nopartial", .type = YNL_PT_FLAG, },
> -	[FOU_ATTR_LOCAL_V4] = { .name = "local_v4", .type = YNL_PT_U32, },
> -	[FOU_ATTR_LOCAL_V6] = { .name = "local_v6", .type = YNL_PT_BINARY,},
> -	[FOU_ATTR_PEER_V4] = { .name = "peer_v4", .type = YNL_PT_U32, },
> -	[FOU_ATTR_PEER_V6] = { .name = "peer_v6", .type = YNL_PT_BINARY,},
> -	[FOU_ATTR_PEER_PORT] = { .name = "peer_port", .type = YNL_PT_U16, },
> -	[FOU_ATTR_IFINDEX] = { .name = "ifindex", .type = YNL_PT_U32, },
> -};
> -
> -struct ynl_policy_nest fou_nest = {
> -	.max_attr = FOU_ATTR_MAX,
> -	.table = fou_policy,
> -};
> -
> -/* Common nested types */
> -/* ============== FOU_CMD_ADD ============== */
> -/* FOU_CMD_ADD - do */
> -void fou_add_req_free(struct fou_add_req *req)
> -{
> -	free(req->local_v6);
> -	free(req->peer_v6);
> -	free(req);
> -}
> -
> -int fou_add(struct ynl_sock *ys, struct fou_add_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, FOU_CMD_ADD, 1);
> -	ys->req_policy = &fou_nest;
> -
> -	if (req->_present.port)
> -		mnl_attr_put_u16(nlh, FOU_ATTR_PORT, req->port);
> -	if (req->_present.ipproto)
> -		mnl_attr_put_u8(nlh, FOU_ATTR_IPPROTO, req->ipproto);
> -	if (req->_present.type)
> -		mnl_attr_put_u8(nlh, FOU_ATTR_TYPE, req->type);
> -	if (req->_present.remcsum_nopartial)
> -		mnl_attr_put(nlh, FOU_ATTR_REMCSUM_NOPARTIAL, 0, NULL);
> -	if (req->_present.local_v4)
> -		mnl_attr_put_u32(nlh, FOU_ATTR_LOCAL_V4, req->local_v4);
> -	if (req->_present.peer_v4)
> -		mnl_attr_put_u32(nlh, FOU_ATTR_PEER_V4, req->peer_v4);
> -	if (req->_present.local_v6_len)
> -		mnl_attr_put(nlh, FOU_ATTR_LOCAL_V6, req->_present.local_v6_len, req->local_v6);
> -	if (req->_present.peer_v6_len)
> -		mnl_attr_put(nlh, FOU_ATTR_PEER_V6, req->_present.peer_v6_len, req->peer_v6);
> -	if (req->_present.peer_port)
> -		mnl_attr_put_u16(nlh, FOU_ATTR_PEER_PORT, req->peer_port);
> -	if (req->_present.ifindex)
> -		mnl_attr_put_u32(nlh, FOU_ATTR_IFINDEX, req->ifindex);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== FOU_CMD_DEL ============== */
> -/* FOU_CMD_DEL - do */
> -void fou_del_req_free(struct fou_del_req *req)
> -{
> -	free(req->local_v6);
> -	free(req->peer_v6);
> -	free(req);
> -}
> -
> -int fou_del(struct ynl_sock *ys, struct fou_del_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, FOU_CMD_DEL, 1);
> -	ys->req_policy = &fou_nest;
> -
> -	if (req->_present.af)
> -		mnl_attr_put_u8(nlh, FOU_ATTR_AF, req->af);
> -	if (req->_present.ifindex)
> -		mnl_attr_put_u32(nlh, FOU_ATTR_IFINDEX, req->ifindex);
> -	if (req->_present.port)
> -		mnl_attr_put_u16(nlh, FOU_ATTR_PORT, req->port);
> -	if (req->_present.peer_port)
> -		mnl_attr_put_u16(nlh, FOU_ATTR_PEER_PORT, req->peer_port);
> -	if (req->_present.local_v4)
> -		mnl_attr_put_u32(nlh, FOU_ATTR_LOCAL_V4, req->local_v4);
> -	if (req->_present.peer_v4)
> -		mnl_attr_put_u32(nlh, FOU_ATTR_PEER_V4, req->peer_v4);
> -	if (req->_present.local_v6_len)
> -		mnl_attr_put(nlh, FOU_ATTR_LOCAL_V6, req->_present.local_v6_len, req->local_v6);
> -	if (req->_present.peer_v6_len)
> -		mnl_attr_put(nlh, FOU_ATTR_PEER_V6, req->_present.peer_v6_len, req->peer_v6);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/* ============== FOU_CMD_GET ============== */
> -/* FOU_CMD_GET - do */
> -void fou_get_req_free(struct fou_get_req *req)
> -{
> -	free(req->local_v6);
> -	free(req->peer_v6);
> -	free(req);
> -}
> -
> -void fou_get_rsp_free(struct fou_get_rsp *rsp)
> -{
> -	free(rsp->local_v6);
> -	free(rsp->peer_v6);
> -	free(rsp);
> -}
> -
> -int fou_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -	struct fou_get_rsp *dst;
> -
> -	dst = yarg->data;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == FOU_ATTR_PORT) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.port = 1;
> -			dst->port = mnl_attr_get_u16(attr);
> -		} else if (type == FOU_ATTR_IPPROTO) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.ipproto = 1;
> -			dst->ipproto = mnl_attr_get_u8(attr);
> -		} else if (type == FOU_ATTR_TYPE) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.type = 1;
> -			dst->type = mnl_attr_get_u8(attr);
> -		} else if (type == FOU_ATTR_REMCSUM_NOPARTIAL) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.remcsum_nopartial = 1;
> -		} else if (type == FOU_ATTR_LOCAL_V4) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.local_v4 = 1;
> -			dst->local_v4 = mnl_attr_get_u32(attr);
> -		} else if (type == FOU_ATTR_PEER_V4) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.peer_v4 = 1;
> -			dst->peer_v4 = mnl_attr_get_u32(attr);
> -		} else if (type == FOU_ATTR_LOCAL_V6) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = mnl_attr_get_payload_len(attr);
> -			dst->_present.local_v6_len = len;
> -			dst->local_v6 = malloc(len);
> -			memcpy(dst->local_v6, mnl_attr_get_payload(attr), len);
> -		} else if (type == FOU_ATTR_PEER_V6) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = mnl_attr_get_payload_len(attr);
> -			dst->_present.peer_v6_len = len;
> -			dst->peer_v6 = malloc(len);
> -			memcpy(dst->peer_v6, mnl_attr_get_payload(attr), len);
> -		} else if (type == FOU_ATTR_PEER_PORT) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.peer_port = 1;
> -			dst->peer_port = mnl_attr_get_u16(attr);
> -		} else if (type == FOU_ATTR_IFINDEX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.ifindex = 1;
> -			dst->ifindex = mnl_attr_get_u32(attr);
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct fou_get_rsp *fou_get(struct ynl_sock *ys, struct fou_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct fou_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, FOU_CMD_GET, 1);
> -	ys->req_policy = &fou_nest;
> -	yrs.yarg.rsp_policy = &fou_nest;
> -
> -	if (req->_present.af)
> -		mnl_attr_put_u8(nlh, FOU_ATTR_AF, req->af);
> -	if (req->_present.ifindex)
> -		mnl_attr_put_u32(nlh, FOU_ATTR_IFINDEX, req->ifindex);
> -	if (req->_present.port)
> -		mnl_attr_put_u16(nlh, FOU_ATTR_PORT, req->port);
> -	if (req->_present.peer_port)
> -		mnl_attr_put_u16(nlh, FOU_ATTR_PEER_PORT, req->peer_port);
> -	if (req->_present.local_v4)
> -		mnl_attr_put_u32(nlh, FOU_ATTR_LOCAL_V4, req->local_v4);
> -	if (req->_present.peer_v4)
> -		mnl_attr_put_u32(nlh, FOU_ATTR_PEER_V4, req->peer_v4);
> -	if (req->_present.local_v6_len)
> -		mnl_attr_put(nlh, FOU_ATTR_LOCAL_V6, req->_present.local_v6_len, req->local_v6);
> -	if (req->_present.peer_v6_len)
> -		mnl_attr_put(nlh, FOU_ATTR_PEER_V6, req->_present.peer_v6_len, req->peer_v6);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = fou_get_rsp_parse;
> -	yrs.rsp_cmd = FOU_CMD_GET;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	fou_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* FOU_CMD_GET - dump */
> -void fou_get_list_free(struct fou_get_list *rsp)
> -{
> -	struct fou_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		free(rsp->obj.local_v6);
> -		free(rsp->obj.peer_v6);
> -		free(rsp);
> -	}
> -}
> -
> -struct fou_get_list *fou_get_dump(struct ynl_sock *ys)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct fou_get_list);
> -	yds.cb = fou_get_rsp_parse;
> -	yds.rsp_cmd = FOU_CMD_GET;
> -	yds.rsp_policy = &fou_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, FOU_CMD_GET, 1);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	fou_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -const struct ynl_family ynl_fou_family =  {
> -	.name		= "fou",
> -};
> diff --git a/tools/net/ynl/generated/fou-user.h b/tools/net/ynl/generated/fou-user.h
> deleted file mode 100644
> index fd566716ddd6..000000000000
> --- a/tools/net/ynl/generated/fou-user.h
> +++ /dev/null
> @@ -1,343 +0,0 @@
> -/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
> -/* Do not edit directly, auto-generated from: */
> -/*	Documentation/netlink/specs/fou.yaml */
> -/* YNL-GEN user header */
> -
> -#ifndef _LINUX_FOU_GEN_H
> -#define _LINUX_FOU_GEN_H
> -
> -#include <stdlib.h>
> -#include <string.h>
> -#include <linux/types.h>
> -#include <linux/fou.h>
> -
> -struct ynl_sock;
> -
> -extern const struct ynl_family ynl_fou_family;
> -
> -/* Enums */
> -const char *fou_op_str(int op);
> -const char *fou_encap_type_str(int value);
> -
> -/* Common nested types */
> -/* ============== FOU_CMD_ADD ============== */
> -/* FOU_CMD_ADD - do */
> -struct fou_add_req {
> -	struct {
> -		__u32 port:1;
> -		__u32 ipproto:1;
> -		__u32 type:1;
> -		__u32 remcsum_nopartial:1;
> -		__u32 local_v4:1;
> -		__u32 peer_v4:1;
> -		__u32 local_v6_len;
> -		__u32 peer_v6_len;
> -		__u32 peer_port:1;
> -		__u32 ifindex:1;
> -	} _present;
> -
> -	__u16 port /* big-endian */;
> -	__u8 ipproto;
> -	__u8 type;
> -	__u32 local_v4;
> -	__u32 peer_v4;
> -	void *local_v6;
> -	void *peer_v6;
> -	__u16 peer_port /* big-endian */;
> -	__s32 ifindex;
> -};
> -
> -static inline struct fou_add_req *fou_add_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct fou_add_req));
> -}
> -void fou_add_req_free(struct fou_add_req *req);
> -
> -static inline void
> -fou_add_req_set_port(struct fou_add_req *req, __u16 port /* big-endian */)
> -{
> -	req->_present.port = 1;
> -	req->port = port;
> -}
> -static inline void
> -fou_add_req_set_ipproto(struct fou_add_req *req, __u8 ipproto)
> -{
> -	req->_present.ipproto = 1;
> -	req->ipproto = ipproto;
> -}
> -static inline void fou_add_req_set_type(struct fou_add_req *req, __u8 type)
> -{
> -	req->_present.type = 1;
> -	req->type = type;
> -}
> -static inline void fou_add_req_set_remcsum_nopartial(struct fou_add_req *req)
> -{
> -	req->_present.remcsum_nopartial = 1;
> -}
> -static inline void
> -fou_add_req_set_local_v4(struct fou_add_req *req, __u32 local_v4)
> -{
> -	req->_present.local_v4 = 1;
> -	req->local_v4 = local_v4;
> -}
> -static inline void
> -fou_add_req_set_peer_v4(struct fou_add_req *req, __u32 peer_v4)
> -{
> -	req->_present.peer_v4 = 1;
> -	req->peer_v4 = peer_v4;
> -}
> -static inline void
> -fou_add_req_set_local_v6(struct fou_add_req *req, const void *local_v6,
> -			 size_t len)
> -{
> -	free(req->local_v6);
> -	req->_present.local_v6_len = len;
> -	req->local_v6 = malloc(req->_present.local_v6_len);
> -	memcpy(req->local_v6, local_v6, req->_present.local_v6_len);
> -}
> -static inline void
> -fou_add_req_set_peer_v6(struct fou_add_req *req, const void *peer_v6,
> -			size_t len)
> -{
> -	free(req->peer_v6);
> -	req->_present.peer_v6_len = len;
> -	req->peer_v6 = malloc(req->_present.peer_v6_len);
> -	memcpy(req->peer_v6, peer_v6, req->_present.peer_v6_len);
> -}
> -static inline void
> -fou_add_req_set_peer_port(struct fou_add_req *req,
> -			  __u16 peer_port /* big-endian */)
> -{
> -	req->_present.peer_port = 1;
> -	req->peer_port = peer_port;
> -}
> -static inline void
> -fou_add_req_set_ifindex(struct fou_add_req *req, __s32 ifindex)
> -{
> -	req->_present.ifindex = 1;
> -	req->ifindex = ifindex;
> -}
> -
> -/*
> - * Add port.
> - */
> -int fou_add(struct ynl_sock *ys, struct fou_add_req *req);
> -
> -/* ============== FOU_CMD_DEL ============== */
> -/* FOU_CMD_DEL - do */
> -struct fou_del_req {
> -	struct {
> -		__u32 af:1;
> -		__u32 ifindex:1;
> -		__u32 port:1;
> -		__u32 peer_port:1;
> -		__u32 local_v4:1;
> -		__u32 peer_v4:1;
> -		__u32 local_v6_len;
> -		__u32 peer_v6_len;
> -	} _present;
> -
> -	__u8 af;
> -	__s32 ifindex;
> -	__u16 port /* big-endian */;
> -	__u16 peer_port /* big-endian */;
> -	__u32 local_v4;
> -	__u32 peer_v4;
> -	void *local_v6;
> -	void *peer_v6;
> -};
> -
> -static inline struct fou_del_req *fou_del_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct fou_del_req));
> -}
> -void fou_del_req_free(struct fou_del_req *req);
> -
> -static inline void fou_del_req_set_af(struct fou_del_req *req, __u8 af)
> -{
> -	req->_present.af = 1;
> -	req->af = af;
> -}
> -static inline void
> -fou_del_req_set_ifindex(struct fou_del_req *req, __s32 ifindex)
> -{
> -	req->_present.ifindex = 1;
> -	req->ifindex = ifindex;
> -}
> -static inline void
> -fou_del_req_set_port(struct fou_del_req *req, __u16 port /* big-endian */)
> -{
> -	req->_present.port = 1;
> -	req->port = port;
> -}
> -static inline void
> -fou_del_req_set_peer_port(struct fou_del_req *req,
> -			  __u16 peer_port /* big-endian */)
> -{
> -	req->_present.peer_port = 1;
> -	req->peer_port = peer_port;
> -}
> -static inline void
> -fou_del_req_set_local_v4(struct fou_del_req *req, __u32 local_v4)
> -{
> -	req->_present.local_v4 = 1;
> -	req->local_v4 = local_v4;
> -}
> -static inline void
> -fou_del_req_set_peer_v4(struct fou_del_req *req, __u32 peer_v4)
> -{
> -	req->_present.peer_v4 = 1;
> -	req->peer_v4 = peer_v4;
> -}
> -static inline void
> -fou_del_req_set_local_v6(struct fou_del_req *req, const void *local_v6,
> -			 size_t len)
> -{
> -	free(req->local_v6);
> -	req->_present.local_v6_len = len;
> -	req->local_v6 = malloc(req->_present.local_v6_len);
> -	memcpy(req->local_v6, local_v6, req->_present.local_v6_len);
> -}
> -static inline void
> -fou_del_req_set_peer_v6(struct fou_del_req *req, const void *peer_v6,
> -			size_t len)
> -{
> -	free(req->peer_v6);
> -	req->_present.peer_v6_len = len;
> -	req->peer_v6 = malloc(req->_present.peer_v6_len);
> -	memcpy(req->peer_v6, peer_v6, req->_present.peer_v6_len);
> -}
> -
> -/*
> - * Delete port.
> - */
> -int fou_del(struct ynl_sock *ys, struct fou_del_req *req);
> -
> -/* ============== FOU_CMD_GET ============== */
> -/* FOU_CMD_GET - do */
> -struct fou_get_req {
> -	struct {
> -		__u32 af:1;
> -		__u32 ifindex:1;
> -		__u32 port:1;
> -		__u32 peer_port:1;
> -		__u32 local_v4:1;
> -		__u32 peer_v4:1;
> -		__u32 local_v6_len;
> -		__u32 peer_v6_len;
> -	} _present;
> -
> -	__u8 af;
> -	__s32 ifindex;
> -	__u16 port /* big-endian */;
> -	__u16 peer_port /* big-endian */;
> -	__u32 local_v4;
> -	__u32 peer_v4;
> -	void *local_v6;
> -	void *peer_v6;
> -};
> -
> -static inline struct fou_get_req *fou_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct fou_get_req));
> -}
> -void fou_get_req_free(struct fou_get_req *req);
> -
> -static inline void fou_get_req_set_af(struct fou_get_req *req, __u8 af)
> -{
> -	req->_present.af = 1;
> -	req->af = af;
> -}
> -static inline void
> -fou_get_req_set_ifindex(struct fou_get_req *req, __s32 ifindex)
> -{
> -	req->_present.ifindex = 1;
> -	req->ifindex = ifindex;
> -}
> -static inline void
> -fou_get_req_set_port(struct fou_get_req *req, __u16 port /* big-endian */)
> -{
> -	req->_present.port = 1;
> -	req->port = port;
> -}
> -static inline void
> -fou_get_req_set_peer_port(struct fou_get_req *req,
> -			  __u16 peer_port /* big-endian */)
> -{
> -	req->_present.peer_port = 1;
> -	req->peer_port = peer_port;
> -}
> -static inline void
> -fou_get_req_set_local_v4(struct fou_get_req *req, __u32 local_v4)
> -{
> -	req->_present.local_v4 = 1;
> -	req->local_v4 = local_v4;
> -}
> -static inline void
> -fou_get_req_set_peer_v4(struct fou_get_req *req, __u32 peer_v4)
> -{
> -	req->_present.peer_v4 = 1;
> -	req->peer_v4 = peer_v4;
> -}
> -static inline void
> -fou_get_req_set_local_v6(struct fou_get_req *req, const void *local_v6,
> -			 size_t len)
> -{
> -	free(req->local_v6);
> -	req->_present.local_v6_len = len;
> -	req->local_v6 = malloc(req->_present.local_v6_len);
> -	memcpy(req->local_v6, local_v6, req->_present.local_v6_len);
> -}
> -static inline void
> -fou_get_req_set_peer_v6(struct fou_get_req *req, const void *peer_v6,
> -			size_t len)
> -{
> -	free(req->peer_v6);
> -	req->_present.peer_v6_len = len;
> -	req->peer_v6 = malloc(req->_present.peer_v6_len);
> -	memcpy(req->peer_v6, peer_v6, req->_present.peer_v6_len);
> -}
> -
> -struct fou_get_rsp {
> -	struct {
> -		__u32 port:1;
> -		__u32 ipproto:1;
> -		__u32 type:1;
> -		__u32 remcsum_nopartial:1;
> -		__u32 local_v4:1;
> -		__u32 peer_v4:1;
> -		__u32 local_v6_len;
> -		__u32 peer_v6_len;
> -		__u32 peer_port:1;
> -		__u32 ifindex:1;
> -	} _present;
> -
> -	__u16 port /* big-endian */;
> -	__u8 ipproto;
> -	__u8 type;
> -	__u32 local_v4;
> -	__u32 peer_v4;
> -	void *local_v6;
> -	void *peer_v6;
> -	__u16 peer_port /* big-endian */;
> -	__s32 ifindex;
> -};
> -
> -void fou_get_rsp_free(struct fou_get_rsp *rsp);
> -
> -/*
> - * Get tunnel info.
> - */
> -struct fou_get_rsp *fou_get(struct ynl_sock *ys, struct fou_get_req *req);
> -
> -/* FOU_CMD_GET - dump */
> -struct fou_get_list {
> -	struct fou_get_list *next;
> -	struct fou_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void fou_get_list_free(struct fou_get_list *rsp);
> -
> -struct fou_get_list *fou_get_dump(struct ynl_sock *ys);
> -
> -#endif /* _LINUX_FOU_GEN_H */
> diff --git a/tools/net/ynl/generated/handshake-user.c b/tools/net/ynl/generated/handshake-user.c
> deleted file mode 100644
> index 6901f8462cca..000000000000
> --- a/tools/net/ynl/generated/handshake-user.c
> +++ /dev/null
> @@ -1,332 +0,0 @@
> -// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> -/* Do not edit directly, auto-generated from: */
> -/*	Documentation/netlink/specs/handshake.yaml */
> -/* YNL-GEN user source */
> -
> -#include <stdlib.h>
> -#include <string.h>
> -#include "handshake-user.h"
> -#include "ynl.h"
> -#include <linux/handshake.h>
> -
> -#include <libmnl/libmnl.h>
> -#include <linux/genetlink.h>
> -
> -/* Enums */
> -static const char * const handshake_op_strmap[] = {
> -	[HANDSHAKE_CMD_READY] = "ready",
> -	[HANDSHAKE_CMD_ACCEPT] = "accept",
> -	[HANDSHAKE_CMD_DONE] = "done",
> -};
> -
> -const char *handshake_op_str(int op)
> -{
> -	if (op < 0 || op >= (int)MNL_ARRAY_SIZE(handshake_op_strmap))
> -		return NULL;
> -	return handshake_op_strmap[op];
> -}
> -
> -static const char * const handshake_handler_class_strmap[] = {
> -	[0] = "none",
> -	[1] = "tlshd",
> -	[2] = "max",
> -};
> -
> -const char *handshake_handler_class_str(enum handshake_handler_class value)
> -{
> -	if (value < 0 || value >= (int)MNL_ARRAY_SIZE(handshake_handler_class_strmap))
> -		return NULL;
> -	return handshake_handler_class_strmap[value];
> -}
> -
> -static const char * const handshake_msg_type_strmap[] = {
> -	[0] = "unspec",
> -	[1] = "clienthello",
> -	[2] = "serverhello",
> -};
> -
> -const char *handshake_msg_type_str(enum handshake_msg_type value)
> -{
> -	if (value < 0 || value >= (int)MNL_ARRAY_SIZE(handshake_msg_type_strmap))
> -		return NULL;
> -	return handshake_msg_type_strmap[value];
> -}
> -
> -static const char * const handshake_auth_strmap[] = {
> -	[0] = "unspec",
> -	[1] = "unauth",
> -	[2] = "psk",
> -	[3] = "x509",
> -};
> -
> -const char *handshake_auth_str(enum handshake_auth value)
> -{
> -	if (value < 0 || value >= (int)MNL_ARRAY_SIZE(handshake_auth_strmap))
> -		return NULL;
> -	return handshake_auth_strmap[value];
> -}
> -
> -/* Policies */
> -struct ynl_policy_attr handshake_x509_policy[HANDSHAKE_A_X509_MAX + 1] = {
> -	[HANDSHAKE_A_X509_CERT] = { .name = "cert", .type = YNL_PT_U32, },
> -	[HANDSHAKE_A_X509_PRIVKEY] = { .name = "privkey", .type = YNL_PT_U32, },
> -};
> -
> -struct ynl_policy_nest handshake_x509_nest = {
> -	.max_attr = HANDSHAKE_A_X509_MAX,
> -	.table = handshake_x509_policy,
> -};
> -
> -struct ynl_policy_attr handshake_accept_policy[HANDSHAKE_A_ACCEPT_MAX + 1] = {
> -	[HANDSHAKE_A_ACCEPT_SOCKFD] = { .name = "sockfd", .type = YNL_PT_U32, },
> -	[HANDSHAKE_A_ACCEPT_HANDLER_CLASS] = { .name = "handler-class", .type = YNL_PT_U32, },
> -	[HANDSHAKE_A_ACCEPT_MESSAGE_TYPE] = { .name = "message-type", .type = YNL_PT_U32, },
> -	[HANDSHAKE_A_ACCEPT_TIMEOUT] = { .name = "timeout", .type = YNL_PT_U32, },
> -	[HANDSHAKE_A_ACCEPT_AUTH_MODE] = { .name = "auth-mode", .type = YNL_PT_U32, },
> -	[HANDSHAKE_A_ACCEPT_PEER_IDENTITY] = { .name = "peer-identity", .type = YNL_PT_U32, },
> -	[HANDSHAKE_A_ACCEPT_CERTIFICATE] = { .name = "certificate", .type = YNL_PT_NEST, .nest = &handshake_x509_nest, },
> -	[HANDSHAKE_A_ACCEPT_PEERNAME] = { .name = "peername", .type = YNL_PT_NUL_STR, },
> -};
> -
> -struct ynl_policy_nest handshake_accept_nest = {
> -	.max_attr = HANDSHAKE_A_ACCEPT_MAX,
> -	.table = handshake_accept_policy,
> -};
> -
> -struct ynl_policy_attr handshake_done_policy[HANDSHAKE_A_DONE_MAX + 1] = {
> -	[HANDSHAKE_A_DONE_STATUS] = { .name = "status", .type = YNL_PT_U32, },
> -	[HANDSHAKE_A_DONE_SOCKFD] = { .name = "sockfd", .type = YNL_PT_U32, },
> -	[HANDSHAKE_A_DONE_REMOTE_AUTH] = { .name = "remote-auth", .type = YNL_PT_U32, },
> -};
> -
> -struct ynl_policy_nest handshake_done_nest = {
> -	.max_attr = HANDSHAKE_A_DONE_MAX,
> -	.table = handshake_done_policy,
> -};
> -
> -/* Common nested types */
> -void handshake_x509_free(struct handshake_x509 *obj)
> -{
> -}
> -
> -int handshake_x509_parse(struct ynl_parse_arg *yarg,
> -			 const struct nlattr *nested)
> -{
> -	struct handshake_x509 *dst = yarg->data;
> -	const struct nlattr *attr;
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == HANDSHAKE_A_X509_CERT) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.cert = 1;
> -			dst->cert = mnl_attr_get_u32(attr);
> -		} else if (type == HANDSHAKE_A_X509_PRIVKEY) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.privkey = 1;
> -			dst->privkey = mnl_attr_get_u32(attr);
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -/* ============== HANDSHAKE_CMD_ACCEPT ============== */
> -/* HANDSHAKE_CMD_ACCEPT - do */
> -void handshake_accept_req_free(struct handshake_accept_req *req)
> -{
> -	free(req);
> -}
> -
> -void handshake_accept_rsp_free(struct handshake_accept_rsp *rsp)
> -{
> -	unsigned int i;
> -
> -	free(rsp->peer_identity);
> -	for (i = 0; i < rsp->n_certificate; i++)
> -		handshake_x509_free(&rsp->certificate[i]);
> -	free(rsp->certificate);
> -	free(rsp->peername);
> -	free(rsp);
> -}
> -
> -int handshake_accept_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct ynl_parse_arg *yarg = data;
> -	struct handshake_accept_rsp *dst;
> -	unsigned int n_peer_identity = 0;
> -	unsigned int n_certificate = 0;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -	int i;
> -
> -	dst = yarg->data;
> -	parg.ys = yarg->ys;
> -
> -	if (dst->certificate)
> -		return ynl_error_parse(yarg, "attribute already present (accept.certificate)");
> -	if (dst->peer_identity)
> -		return ynl_error_parse(yarg, "attribute already present (accept.peer-identity)");
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == HANDSHAKE_A_ACCEPT_SOCKFD) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.sockfd = 1;
> -			dst->sockfd = mnl_attr_get_u32(attr);
> -		} else if (type == HANDSHAKE_A_ACCEPT_MESSAGE_TYPE) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.message_type = 1;
> -			dst->message_type = mnl_attr_get_u32(attr);
> -		} else if (type == HANDSHAKE_A_ACCEPT_TIMEOUT) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.timeout = 1;
> -			dst->timeout = mnl_attr_get_u32(attr);
> -		} else if (type == HANDSHAKE_A_ACCEPT_AUTH_MODE) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.auth_mode = 1;
> -			dst->auth_mode = mnl_attr_get_u32(attr);
> -		} else if (type == HANDSHAKE_A_ACCEPT_PEER_IDENTITY) {
> -			n_peer_identity++;
> -		} else if (type == HANDSHAKE_A_ACCEPT_CERTIFICATE) {
> -			n_certificate++;
> -		} else if (type == HANDSHAKE_A_ACCEPT_PEERNAME) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(attr));
> -			dst->_present.peername_len = len;
> -			dst->peername = malloc(len + 1);
> -			memcpy(dst->peername, mnl_attr_get_str(attr), len);
> -			dst->peername[len] = 0;
> -		}
> -	}
> -
> -	if (n_certificate) {
> -		dst->certificate = calloc(n_certificate, sizeof(*dst->certificate));
> -		dst->n_certificate = n_certificate;
> -		i = 0;
> -		parg.rsp_policy = &handshake_x509_nest;
> -		mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -			if (mnl_attr_get_type(attr) == HANDSHAKE_A_ACCEPT_CERTIFICATE) {
> -				parg.data = &dst->certificate[i];
> -				if (handshake_x509_parse(&parg, attr))
> -					return MNL_CB_ERROR;
> -				i++;
> -			}
> -		}
> -	}
> -	if (n_peer_identity) {
> -		dst->peer_identity = calloc(n_peer_identity, sizeof(*dst->peer_identity));
> -		dst->n_peer_identity = n_peer_identity;
> -		i = 0;
> -		mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -			if (mnl_attr_get_type(attr) == HANDSHAKE_A_ACCEPT_PEER_IDENTITY) {
> -				dst->peer_identity[i] = mnl_attr_get_u32(attr);
> -				i++;
> -			}
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct handshake_accept_rsp *
> -handshake_accept(struct ynl_sock *ys, struct handshake_accept_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct handshake_accept_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, HANDSHAKE_CMD_ACCEPT, 1);
> -	ys->req_policy = &handshake_accept_nest;
> -	yrs.yarg.rsp_policy = &handshake_accept_nest;
> -
> -	if (req->_present.handler_class)
> -		mnl_attr_put_u32(nlh, HANDSHAKE_A_ACCEPT_HANDLER_CLASS, req->handler_class);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = handshake_accept_rsp_parse;
> -	yrs.rsp_cmd = HANDSHAKE_CMD_ACCEPT;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	handshake_accept_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* HANDSHAKE_CMD_ACCEPT - notify */
> -void handshake_accept_ntf_free(struct handshake_accept_ntf *rsp)
> -{
> -	unsigned int i;
> -
> -	free(rsp->obj.peer_identity);
> -	for (i = 0; i < rsp->obj.n_certificate; i++)
> -		handshake_x509_free(&rsp->obj.certificate[i]);
> -	free(rsp->obj.certificate);
> -	free(rsp->obj.peername);
> -	free(rsp);
> -}
> -
> -/* ============== HANDSHAKE_CMD_DONE ============== */
> -/* HANDSHAKE_CMD_DONE - do */
> -void handshake_done_req_free(struct handshake_done_req *req)
> -{
> -	free(req->remote_auth);
> -	free(req);
> -}
> -
> -int handshake_done(struct ynl_sock *ys, struct handshake_done_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, HANDSHAKE_CMD_DONE, 1);
> -	ys->req_policy = &handshake_done_nest;
> -
> -	if (req->_present.status)
> -		mnl_attr_put_u32(nlh, HANDSHAKE_A_DONE_STATUS, req->status);
> -	if (req->_present.sockfd)
> -		mnl_attr_put_u32(nlh, HANDSHAKE_A_DONE_SOCKFD, req->sockfd);
> -	for (unsigned int i = 0; i < req->n_remote_auth; i++)
> -		mnl_attr_put_u32(nlh, HANDSHAKE_A_DONE_REMOTE_AUTH, req->remote_auth[i]);
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -static const struct ynl_ntf_info handshake_ntf_info[] =  {
> -	[HANDSHAKE_CMD_READY] =  {
> -		.alloc_sz	= sizeof(struct handshake_accept_ntf),
> -		.cb		= handshake_accept_rsp_parse,
> -		.policy		= &handshake_accept_nest,
> -		.free		= (void *)handshake_accept_ntf_free,
> -	},
> -};
> -
> -const struct ynl_family ynl_handshake_family =  {
> -	.name		= "handshake",
> -	.ntf_info	= handshake_ntf_info,
> -	.ntf_info_size	= MNL_ARRAY_SIZE(handshake_ntf_info),
> -};
> diff --git a/tools/net/ynl/generated/handshake-user.h b/tools/net/ynl/generated/handshake-user.h
> deleted file mode 100644
> index bce537d8b8cc..000000000000
> --- a/tools/net/ynl/generated/handshake-user.h
> +++ /dev/null
> @@ -1,145 +0,0 @@
> -/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
> -/* Do not edit directly, auto-generated from: */
> -/*	Documentation/netlink/specs/handshake.yaml */
> -/* YNL-GEN user header */
> -
> -#ifndef _LINUX_HANDSHAKE_GEN_H
> -#define _LINUX_HANDSHAKE_GEN_H
> -
> -#include <stdlib.h>
> -#include <string.h>
> -#include <linux/types.h>
> -#include <linux/handshake.h>
> -
> -struct ynl_sock;
> -
> -extern const struct ynl_family ynl_handshake_family;
> -
> -/* Enums */
> -const char *handshake_op_str(int op);
> -const char *handshake_handler_class_str(enum handshake_handler_class value);
> -const char *handshake_msg_type_str(enum handshake_msg_type value);
> -const char *handshake_auth_str(enum handshake_auth value);
> -
> -/* Common nested types */
> -struct handshake_x509 {
> -	struct {
> -		__u32 cert:1;
> -		__u32 privkey:1;
> -	} _present;
> -
> -	__s32 cert;
> -	__s32 privkey;
> -};
> -
> -/* ============== HANDSHAKE_CMD_ACCEPT ============== */
> -/* HANDSHAKE_CMD_ACCEPT - do */
> -struct handshake_accept_req {
> -	struct {
> -		__u32 handler_class:1;
> -	} _present;
> -
> -	enum handshake_handler_class handler_class;
> -};
> -
> -static inline struct handshake_accept_req *handshake_accept_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct handshake_accept_req));
> -}
> -void handshake_accept_req_free(struct handshake_accept_req *req);
> -
> -static inline void
> -handshake_accept_req_set_handler_class(struct handshake_accept_req *req,
> -				       enum handshake_handler_class handler_class)
> -{
> -	req->_present.handler_class = 1;
> -	req->handler_class = handler_class;
> -}
> -
> -struct handshake_accept_rsp {
> -	struct {
> -		__u32 sockfd:1;
> -		__u32 message_type:1;
> -		__u32 timeout:1;
> -		__u32 auth_mode:1;
> -		__u32 peername_len;
> -	} _present;
> -
> -	__s32 sockfd;
> -	enum handshake_msg_type message_type;
> -	__u32 timeout;
> -	enum handshake_auth auth_mode;
> -	unsigned int n_peer_identity;
> -	__u32 *peer_identity;
> -	unsigned int n_certificate;
> -	struct handshake_x509 *certificate;
> -	char *peername;
> -};
> -
> -void handshake_accept_rsp_free(struct handshake_accept_rsp *rsp);
> -
> -/*
> - * Handler retrieves next queued handshake request
> - */
> -struct handshake_accept_rsp *
> -handshake_accept(struct ynl_sock *ys, struct handshake_accept_req *req);
> -
> -/* HANDSHAKE_CMD_ACCEPT - notify */
> -struct handshake_accept_ntf {
> -	__u16 family;
> -	__u8 cmd;
> -	struct ynl_ntf_base_type *next;
> -	void (*free)(struct handshake_accept_ntf *ntf);
> -	struct handshake_accept_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void handshake_accept_ntf_free(struct handshake_accept_ntf *rsp);
> -
> -/* ============== HANDSHAKE_CMD_DONE ============== */
> -/* HANDSHAKE_CMD_DONE - do */
> -struct handshake_done_req {
> -	struct {
> -		__u32 status:1;
> -		__u32 sockfd:1;
> -	} _present;
> -
> -	__u32 status;
> -	__s32 sockfd;
> -	unsigned int n_remote_auth;
> -	__u32 *remote_auth;
> -};
> -
> -static inline struct handshake_done_req *handshake_done_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct handshake_done_req));
> -}
> -void handshake_done_req_free(struct handshake_done_req *req);
> -
> -static inline void
> -handshake_done_req_set_status(struct handshake_done_req *req, __u32 status)
> -{
> -	req->_present.status = 1;
> -	req->status = status;
> -}
> -static inline void
> -handshake_done_req_set_sockfd(struct handshake_done_req *req, __s32 sockfd)
> -{
> -	req->_present.sockfd = 1;
> -	req->sockfd = sockfd;
> -}
> -static inline void
> -__handshake_done_req_set_remote_auth(struct handshake_done_req *req,
> -				     __u32 *remote_auth,
> -				     unsigned int n_remote_auth)
> -{
> -	free(req->remote_auth);
> -	req->remote_auth = remote_auth;
> -	req->n_remote_auth = n_remote_auth;
> -}
> -
> -/*
> - * Handler reports handshake completion
> - */
> -int handshake_done(struct ynl_sock *ys, struct handshake_done_req *req);
> -
> -#endif /* _LINUX_HANDSHAKE_GEN_H */
> diff --git a/tools/net/ynl/generated/netdev-user.c b/tools/net/ynl/generated/netdev-user.c
> deleted file mode 100644
> index 3b9dee94d4ce..000000000000
> --- a/tools/net/ynl/generated/netdev-user.c
> +++ /dev/null
> @@ -1,663 +0,0 @@
> -// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> -/* Do not edit directly, auto-generated from: */
> -/*	Documentation/netlink/specs/netdev.yaml */
> -/* YNL-GEN user source */
> -
> -#include <stdlib.h>
> -#include <string.h>
> -#include "netdev-user.h"
> -#include "ynl.h"
> -#include <linux/netdev.h>
> -
> -#include <libmnl/libmnl.h>
> -#include <linux/genetlink.h>
> -
> -/* Enums */
> -static const char * const netdev_op_strmap[] = {
> -	[NETDEV_CMD_DEV_GET] = "dev-get",
> -	[NETDEV_CMD_DEV_ADD_NTF] = "dev-add-ntf",
> -	[NETDEV_CMD_DEV_DEL_NTF] = "dev-del-ntf",
> -	[NETDEV_CMD_DEV_CHANGE_NTF] = "dev-change-ntf",
> -	[NETDEV_CMD_PAGE_POOL_GET] = "page-pool-get",
> -	[NETDEV_CMD_PAGE_POOL_ADD_NTF] = "page-pool-add-ntf",
> -	[NETDEV_CMD_PAGE_POOL_DEL_NTF] = "page-pool-del-ntf",
> -	[NETDEV_CMD_PAGE_POOL_CHANGE_NTF] = "page-pool-change-ntf",
> -	[NETDEV_CMD_PAGE_POOL_STATS_GET] = "page-pool-stats-get",
> -};
> -
> -const char *netdev_op_str(int op)
> -{
> -	if (op < 0 || op >= (int)MNL_ARRAY_SIZE(netdev_op_strmap))
> -		return NULL;
> -	return netdev_op_strmap[op];
> -}
> -
> -static const char * const netdev_xdp_act_strmap[] = {
> -	[0] = "basic",
> -	[1] = "redirect",
> -	[2] = "ndo-xmit",
> -	[3] = "xsk-zerocopy",
> -	[4] = "hw-offload",
> -	[5] = "rx-sg",
> -	[6] = "ndo-xmit-sg",
> -};
> -
> -const char *netdev_xdp_act_str(enum netdev_xdp_act value)
> -{
> -	value = ffs(value) - 1;
> -	if (value < 0 || value >= (int)MNL_ARRAY_SIZE(netdev_xdp_act_strmap))
> -		return NULL;
> -	return netdev_xdp_act_strmap[value];
> -}
> -
> -static const char * const netdev_xdp_rx_metadata_strmap[] = {
> -	[0] = "timestamp",
> -	[1] = "hash",
> -};
> -
> -const char *netdev_xdp_rx_metadata_str(enum netdev_xdp_rx_metadata value)
> -{
> -	value = ffs(value) - 1;
> -	if (value < 0 || value >= (int)MNL_ARRAY_SIZE(netdev_xdp_rx_metadata_strmap))
> -		return NULL;
> -	return netdev_xdp_rx_metadata_strmap[value];
> -}
> -
> -static const char * const netdev_xsk_flags_strmap[] = {
> -	[0] = "tx-timestamp",
> -	[1] = "tx-checksum",
> -};
> -
> -const char *netdev_xsk_flags_str(enum netdev_xsk_flags value)
> -{
> -	value = ffs(value) - 1;
> -	if (value < 0 || value >= (int)MNL_ARRAY_SIZE(netdev_xsk_flags_strmap))
> -		return NULL;
> -	return netdev_xsk_flags_strmap[value];
> -}
> -
> -/* Policies */
> -struct ynl_policy_attr netdev_page_pool_info_policy[NETDEV_A_PAGE_POOL_MAX + 1] = {
> -	[NETDEV_A_PAGE_POOL_ID] = { .name = "id", .type = YNL_PT_UINT, },
> -	[NETDEV_A_PAGE_POOL_IFINDEX] = { .name = "ifindex", .type = YNL_PT_U32, },
> -};
> -
> -struct ynl_policy_nest netdev_page_pool_info_nest = {
> -	.max_attr = NETDEV_A_PAGE_POOL_MAX,
> -	.table = netdev_page_pool_info_policy,
> -};
> -
> -struct ynl_policy_attr netdev_dev_policy[NETDEV_A_DEV_MAX + 1] = {
> -	[NETDEV_A_DEV_IFINDEX] = { .name = "ifindex", .type = YNL_PT_U32, },
> -	[NETDEV_A_DEV_PAD] = { .name = "pad", .type = YNL_PT_IGNORE, },
> -	[NETDEV_A_DEV_XDP_FEATURES] = { .name = "xdp-features", .type = YNL_PT_U64, },
> -	[NETDEV_A_DEV_XDP_ZC_MAX_SEGS] = { .name = "xdp-zc-max-segs", .type = YNL_PT_U32, },
> -	[NETDEV_A_DEV_XDP_RX_METADATA_FEATURES] = { .name = "xdp-rx-metadata-features", .type = YNL_PT_U64, },
> -	[NETDEV_A_DEV_XSK_FEATURES] = { .name = "xsk-features", .type = YNL_PT_U64, },
> -};
> -
> -struct ynl_policy_nest netdev_dev_nest = {
> -	.max_attr = NETDEV_A_DEV_MAX,
> -	.table = netdev_dev_policy,
> -};
> -
> -struct ynl_policy_attr netdev_page_pool_policy[NETDEV_A_PAGE_POOL_MAX + 1] = {
> -	[NETDEV_A_PAGE_POOL_ID] = { .name = "id", .type = YNL_PT_UINT, },
> -	[NETDEV_A_PAGE_POOL_IFINDEX] = { .name = "ifindex", .type = YNL_PT_U32, },
> -	[NETDEV_A_PAGE_POOL_NAPI_ID] = { .name = "napi-id", .type = YNL_PT_UINT, },
> -	[NETDEV_A_PAGE_POOL_INFLIGHT] = { .name = "inflight", .type = YNL_PT_UINT, },
> -	[NETDEV_A_PAGE_POOL_INFLIGHT_MEM] = { .name = "inflight-mem", .type = YNL_PT_UINT, },
> -	[NETDEV_A_PAGE_POOL_DETACH_TIME] = { .name = "detach-time", .type = YNL_PT_UINT, },
> -};
> -
> -struct ynl_policy_nest netdev_page_pool_nest = {
> -	.max_attr = NETDEV_A_PAGE_POOL_MAX,
> -	.table = netdev_page_pool_policy,
> -};
> -
> -struct ynl_policy_attr netdev_page_pool_stats_policy[NETDEV_A_PAGE_POOL_STATS_MAX + 1] = {
> -	[NETDEV_A_PAGE_POOL_STATS_INFO] = { .name = "info", .type = YNL_PT_NEST, .nest = &netdev_page_pool_info_nest, },
> -	[NETDEV_A_PAGE_POOL_STATS_ALLOC_FAST] = { .name = "alloc-fast", .type = YNL_PT_UINT, },
> -	[NETDEV_A_PAGE_POOL_STATS_ALLOC_SLOW] = { .name = "alloc-slow", .type = YNL_PT_UINT, },
> -	[NETDEV_A_PAGE_POOL_STATS_ALLOC_SLOW_HIGH_ORDER] = { .name = "alloc-slow-high-order", .type = YNL_PT_UINT, },
> -	[NETDEV_A_PAGE_POOL_STATS_ALLOC_EMPTY] = { .name = "alloc-empty", .type = YNL_PT_UINT, },
> -	[NETDEV_A_PAGE_POOL_STATS_ALLOC_REFILL] = { .name = "alloc-refill", .type = YNL_PT_UINT, },
> -	[NETDEV_A_PAGE_POOL_STATS_ALLOC_WAIVE] = { .name = "alloc-waive", .type = YNL_PT_UINT, },
> -	[NETDEV_A_PAGE_POOL_STATS_RECYCLE_CACHED] = { .name = "recycle-cached", .type = YNL_PT_UINT, },
> -	[NETDEV_A_PAGE_POOL_STATS_RECYCLE_CACHE_FULL] = { .name = "recycle-cache-full", .type = YNL_PT_UINT, },
> -	[NETDEV_A_PAGE_POOL_STATS_RECYCLE_RING] = { .name = "recycle-ring", .type = YNL_PT_UINT, },
> -	[NETDEV_A_PAGE_POOL_STATS_RECYCLE_RING_FULL] = { .name = "recycle-ring-full", .type = YNL_PT_UINT, },
> -	[NETDEV_A_PAGE_POOL_STATS_RECYCLE_RELEASED_REFCNT] = { .name = "recycle-released-refcnt", .type = YNL_PT_UINT, },
> -};
> -
> -struct ynl_policy_nest netdev_page_pool_stats_nest = {
> -	.max_attr = NETDEV_A_PAGE_POOL_STATS_MAX,
> -	.table = netdev_page_pool_stats_policy,
> -};
> -
> -/* Common nested types */
> -void netdev_page_pool_info_free(struct netdev_page_pool_info *obj)
> -{
> -}
> -
> -int netdev_page_pool_info_put(struct nlmsghdr *nlh, unsigned int attr_type,
> -			      struct netdev_page_pool_info *obj)
> -{
> -	struct nlattr *nest;
> -
> -	nest = mnl_attr_nest_start(nlh, attr_type);
> -	if (obj->_present.id)
> -		mnl_attr_put_uint(nlh, NETDEV_A_PAGE_POOL_ID, obj->id);
> -	if (obj->_present.ifindex)
> -		mnl_attr_put_u32(nlh, NETDEV_A_PAGE_POOL_IFINDEX, obj->ifindex);
> -	mnl_attr_nest_end(nlh, nest);
> -
> -	return 0;
> -}
> -
> -int netdev_page_pool_info_parse(struct ynl_parse_arg *yarg,
> -				const struct nlattr *nested)
> -{
> -	struct netdev_page_pool_info *dst = yarg->data;
> -	const struct nlattr *attr;
> -
> -	mnl_attr_for_each_nested(attr, nested) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == NETDEV_A_PAGE_POOL_ID) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.id = 1;
> -			dst->id = mnl_attr_get_uint(attr);
> -		} else if (type == NETDEV_A_PAGE_POOL_IFINDEX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.ifindex = 1;
> -			dst->ifindex = mnl_attr_get_u32(attr);
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -/* ============== NETDEV_CMD_DEV_GET ============== */
> -/* NETDEV_CMD_DEV_GET - do */
> -void netdev_dev_get_req_free(struct netdev_dev_get_req *req)
> -{
> -	free(req);
> -}
> -
> -void netdev_dev_get_rsp_free(struct netdev_dev_get_rsp *rsp)
> -{
> -	free(rsp);
> -}
> -
> -int netdev_dev_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct ynl_parse_arg *yarg = data;
> -	struct netdev_dev_get_rsp *dst;
> -	const struct nlattr *attr;
> -
> -	dst = yarg->data;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == NETDEV_A_DEV_IFINDEX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.ifindex = 1;
> -			dst->ifindex = mnl_attr_get_u32(attr);
> -		} else if (type == NETDEV_A_DEV_XDP_FEATURES) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.xdp_features = 1;
> -			dst->xdp_features = mnl_attr_get_u64(attr);
> -		} else if (type == NETDEV_A_DEV_XDP_ZC_MAX_SEGS) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.xdp_zc_max_segs = 1;
> -			dst->xdp_zc_max_segs = mnl_attr_get_u32(attr);
> -		} else if (type == NETDEV_A_DEV_XDP_RX_METADATA_FEATURES) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.xdp_rx_metadata_features = 1;
> -			dst->xdp_rx_metadata_features = mnl_attr_get_u64(attr);
> -		} else if (type == NETDEV_A_DEV_XSK_FEATURES) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.xsk_features = 1;
> -			dst->xsk_features = mnl_attr_get_u64(attr);
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct netdev_dev_get_rsp *
> -netdev_dev_get(struct ynl_sock *ys, struct netdev_dev_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct netdev_dev_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, NETDEV_CMD_DEV_GET, 1);
> -	ys->req_policy = &netdev_dev_nest;
> -	yrs.yarg.rsp_policy = &netdev_dev_nest;
> -
> -	if (req->_present.ifindex)
> -		mnl_attr_put_u32(nlh, NETDEV_A_DEV_IFINDEX, req->ifindex);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = netdev_dev_get_rsp_parse;
> -	yrs.rsp_cmd = NETDEV_CMD_DEV_GET;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	netdev_dev_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* NETDEV_CMD_DEV_GET - dump */
> -void netdev_dev_get_list_free(struct netdev_dev_get_list *rsp)
> -{
> -	struct netdev_dev_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		free(rsp);
> -	}
> -}
> -
> -struct netdev_dev_get_list *netdev_dev_get_dump(struct ynl_sock *ys)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct netdev_dev_get_list);
> -	yds.cb = netdev_dev_get_rsp_parse;
> -	yds.rsp_cmd = NETDEV_CMD_DEV_GET;
> -	yds.rsp_policy = &netdev_dev_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, NETDEV_CMD_DEV_GET, 1);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	netdev_dev_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* NETDEV_CMD_DEV_GET - notify */
> -void netdev_dev_get_ntf_free(struct netdev_dev_get_ntf *rsp)
> -{
> -	free(rsp);
> -}
> -
> -/* ============== NETDEV_CMD_PAGE_POOL_GET ============== */
> -/* NETDEV_CMD_PAGE_POOL_GET - do */
> -void netdev_page_pool_get_req_free(struct netdev_page_pool_get_req *req)
> -{
> -	free(req);
> -}
> -
> -void netdev_page_pool_get_rsp_free(struct netdev_page_pool_get_rsp *rsp)
> -{
> -	free(rsp);
> -}
> -
> -int netdev_page_pool_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct netdev_page_pool_get_rsp *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -
> -	dst = yarg->data;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == NETDEV_A_PAGE_POOL_ID) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.id = 1;
> -			dst->id = mnl_attr_get_uint(attr);
> -		} else if (type == NETDEV_A_PAGE_POOL_IFINDEX) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.ifindex = 1;
> -			dst->ifindex = mnl_attr_get_u32(attr);
> -		} else if (type == NETDEV_A_PAGE_POOL_NAPI_ID) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.napi_id = 1;
> -			dst->napi_id = mnl_attr_get_uint(attr);
> -		} else if (type == NETDEV_A_PAGE_POOL_INFLIGHT) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.inflight = 1;
> -			dst->inflight = mnl_attr_get_uint(attr);
> -		} else if (type == NETDEV_A_PAGE_POOL_INFLIGHT_MEM) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.inflight_mem = 1;
> -			dst->inflight_mem = mnl_attr_get_uint(attr);
> -		} else if (type == NETDEV_A_PAGE_POOL_DETACH_TIME) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.detach_time = 1;
> -			dst->detach_time = mnl_attr_get_uint(attr);
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct netdev_page_pool_get_rsp *
> -netdev_page_pool_get(struct ynl_sock *ys, struct netdev_page_pool_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct netdev_page_pool_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, NETDEV_CMD_PAGE_POOL_GET, 1);
> -	ys->req_policy = &netdev_page_pool_nest;
> -	yrs.yarg.rsp_policy = &netdev_page_pool_nest;
> -
> -	if (req->_present.id)
> -		mnl_attr_put_uint(nlh, NETDEV_A_PAGE_POOL_ID, req->id);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = netdev_page_pool_get_rsp_parse;
> -	yrs.rsp_cmd = NETDEV_CMD_PAGE_POOL_GET;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	netdev_page_pool_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* NETDEV_CMD_PAGE_POOL_GET - dump */
> -void netdev_page_pool_get_list_free(struct netdev_page_pool_get_list *rsp)
> -{
> -	struct netdev_page_pool_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		free(rsp);
> -	}
> -}
> -
> -struct netdev_page_pool_get_list *
> -netdev_page_pool_get_dump(struct ynl_sock *ys)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct netdev_page_pool_get_list);
> -	yds.cb = netdev_page_pool_get_rsp_parse;
> -	yds.rsp_cmd = NETDEV_CMD_PAGE_POOL_GET;
> -	yds.rsp_policy = &netdev_page_pool_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, NETDEV_CMD_PAGE_POOL_GET, 1);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	netdev_page_pool_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -/* NETDEV_CMD_PAGE_POOL_GET - notify */
> -void netdev_page_pool_get_ntf_free(struct netdev_page_pool_get_ntf *rsp)
> -{
> -	free(rsp);
> -}
> -
> -/* ============== NETDEV_CMD_PAGE_POOL_STATS_GET ============== */
> -/* NETDEV_CMD_PAGE_POOL_STATS_GET - do */
> -void
> -netdev_page_pool_stats_get_req_free(struct netdev_page_pool_stats_get_req *req)
> -{
> -	netdev_page_pool_info_free(&req->info);
> -	free(req);
> -}
> -
> -void
> -netdev_page_pool_stats_get_rsp_free(struct netdev_page_pool_stats_get_rsp *rsp)
> -{
> -	netdev_page_pool_info_free(&rsp->info);
> -	free(rsp);
> -}
> -
> -int netdev_page_pool_stats_get_rsp_parse(const struct nlmsghdr *nlh,
> -					 void *data)
> -{
> -	struct netdev_page_pool_stats_get_rsp *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	const struct nlattr *attr;
> -	struct ynl_parse_arg parg;
> -
> -	dst = yarg->data;
> -	parg.ys = yarg->ys;
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == NETDEV_A_PAGE_POOL_STATS_INFO) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.info = 1;
> -
> -			parg.rsp_policy = &netdev_page_pool_info_nest;
> -			parg.data = &dst->info;
> -			if (netdev_page_pool_info_parse(&parg, attr))
> -				return MNL_CB_ERROR;
> -		} else if (type == NETDEV_A_PAGE_POOL_STATS_ALLOC_FAST) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.alloc_fast = 1;
> -			dst->alloc_fast = mnl_attr_get_uint(attr);
> -		} else if (type == NETDEV_A_PAGE_POOL_STATS_ALLOC_SLOW) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.alloc_slow = 1;
> -			dst->alloc_slow = mnl_attr_get_uint(attr);
> -		} else if (type == NETDEV_A_PAGE_POOL_STATS_ALLOC_SLOW_HIGH_ORDER) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.alloc_slow_high_order = 1;
> -			dst->alloc_slow_high_order = mnl_attr_get_uint(attr);
> -		} else if (type == NETDEV_A_PAGE_POOL_STATS_ALLOC_EMPTY) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.alloc_empty = 1;
> -			dst->alloc_empty = mnl_attr_get_uint(attr);
> -		} else if (type == NETDEV_A_PAGE_POOL_STATS_ALLOC_REFILL) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.alloc_refill = 1;
> -			dst->alloc_refill = mnl_attr_get_uint(attr);
> -		} else if (type == NETDEV_A_PAGE_POOL_STATS_ALLOC_WAIVE) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.alloc_waive = 1;
> -			dst->alloc_waive = mnl_attr_get_uint(attr);
> -		} else if (type == NETDEV_A_PAGE_POOL_STATS_RECYCLE_CACHED) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.recycle_cached = 1;
> -			dst->recycle_cached = mnl_attr_get_uint(attr);
> -		} else if (type == NETDEV_A_PAGE_POOL_STATS_RECYCLE_CACHE_FULL) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.recycle_cache_full = 1;
> -			dst->recycle_cache_full = mnl_attr_get_uint(attr);
> -		} else if (type == NETDEV_A_PAGE_POOL_STATS_RECYCLE_RING) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.recycle_ring = 1;
> -			dst->recycle_ring = mnl_attr_get_uint(attr);
> -		} else if (type == NETDEV_A_PAGE_POOL_STATS_RECYCLE_RING_FULL) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.recycle_ring_full = 1;
> -			dst->recycle_ring_full = mnl_attr_get_uint(attr);
> -		} else if (type == NETDEV_A_PAGE_POOL_STATS_RECYCLE_RELEASED_REFCNT) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.recycle_released_refcnt = 1;
> -			dst->recycle_released_refcnt = mnl_attr_get_uint(attr);
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -struct netdev_page_pool_stats_get_rsp *
> -netdev_page_pool_stats_get(struct ynl_sock *ys,
> -			   struct netdev_page_pool_stats_get_req *req)
> -{
> -	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
> -	struct netdev_page_pool_stats_get_rsp *rsp;
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	nlh = ynl_gemsg_start_req(ys, ys->family_id, NETDEV_CMD_PAGE_POOL_STATS_GET, 1);
> -	ys->req_policy = &netdev_page_pool_stats_nest;
> -	yrs.yarg.rsp_policy = &netdev_page_pool_stats_nest;
> -
> -	if (req->_present.info)
> -		netdev_page_pool_info_put(nlh, NETDEV_A_PAGE_POOL_STATS_INFO, &req->info);
> -
> -	rsp = calloc(1, sizeof(*rsp));
> -	yrs.yarg.data = rsp;
> -	yrs.cb = netdev_page_pool_stats_get_rsp_parse;
> -	yrs.rsp_cmd = NETDEV_CMD_PAGE_POOL_STATS_GET;
> -
> -	err = ynl_exec(ys, nlh, &yrs);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return rsp;
> -
> -err_free:
> -	netdev_page_pool_stats_get_rsp_free(rsp);
> -	return NULL;
> -}
> -
> -/* NETDEV_CMD_PAGE_POOL_STATS_GET - dump */
> -void
> -netdev_page_pool_stats_get_list_free(struct netdev_page_pool_stats_get_list *rsp)
> -{
> -	struct netdev_page_pool_stats_get_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		netdev_page_pool_info_free(&rsp->obj.info);
> -		free(rsp);
> -	}
> -}
> -
> -struct netdev_page_pool_stats_get_list *
> -netdev_page_pool_stats_get_dump(struct ynl_sock *ys)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct netdev_page_pool_stats_get_list);
> -	yds.cb = netdev_page_pool_stats_get_rsp_parse;
> -	yds.rsp_cmd = NETDEV_CMD_PAGE_POOL_STATS_GET;
> -	yds.rsp_policy = &netdev_page_pool_stats_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, NETDEV_CMD_PAGE_POOL_STATS_GET, 1);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	netdev_page_pool_stats_get_list_free(yds.first);
> -	return NULL;
> -}
> -
> -static const struct ynl_ntf_info netdev_ntf_info[] =  {
> -	[NETDEV_CMD_DEV_ADD_NTF] =  {
> -		.alloc_sz	= sizeof(struct netdev_dev_get_ntf),
> -		.cb		= netdev_dev_get_rsp_parse,
> -		.policy		= &netdev_dev_nest,
> -		.free		= (void *)netdev_dev_get_ntf_free,
> -	},
> -	[NETDEV_CMD_DEV_DEL_NTF] =  {
> -		.alloc_sz	= sizeof(struct netdev_dev_get_ntf),
> -		.cb		= netdev_dev_get_rsp_parse,
> -		.policy		= &netdev_dev_nest,
> -		.free		= (void *)netdev_dev_get_ntf_free,
> -	},
> -	[NETDEV_CMD_DEV_CHANGE_NTF] =  {
> -		.alloc_sz	= sizeof(struct netdev_dev_get_ntf),
> -		.cb		= netdev_dev_get_rsp_parse,
> -		.policy		= &netdev_dev_nest,
> -		.free		= (void *)netdev_dev_get_ntf_free,
> -	},
> -	[NETDEV_CMD_PAGE_POOL_ADD_NTF] =  {
> -		.alloc_sz	= sizeof(struct netdev_page_pool_get_ntf),
> -		.cb		= netdev_page_pool_get_rsp_parse,
> -		.policy		= &netdev_page_pool_nest,
> -		.free		= (void *)netdev_page_pool_get_ntf_free,
> -	},
> -	[NETDEV_CMD_PAGE_POOL_DEL_NTF] =  {
> -		.alloc_sz	= sizeof(struct netdev_page_pool_get_ntf),
> -		.cb		= netdev_page_pool_get_rsp_parse,
> -		.policy		= &netdev_page_pool_nest,
> -		.free		= (void *)netdev_page_pool_get_ntf_free,
> -	},
> -	[NETDEV_CMD_PAGE_POOL_CHANGE_NTF] =  {
> -		.alloc_sz	= sizeof(struct netdev_page_pool_get_ntf),
> -		.cb		= netdev_page_pool_get_rsp_parse,
> -		.policy		= &netdev_page_pool_nest,
> -		.free		= (void *)netdev_page_pool_get_ntf_free,
> -	},
> -};
> -
> -const struct ynl_family ynl_netdev_family =  {
> -	.name		= "netdev",
> -	.ntf_info	= netdev_ntf_info,
> -	.ntf_info_size	= MNL_ARRAY_SIZE(netdev_ntf_info),
> -};
> diff --git a/tools/net/ynl/generated/netdev-user.h b/tools/net/ynl/generated/netdev-user.h
> deleted file mode 100644
> index cc3d80d1cf8c..000000000000
> --- a/tools/net/ynl/generated/netdev-user.h
> +++ /dev/null
> @@ -1,264 +0,0 @@
> -/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
> -/* Do not edit directly, auto-generated from: */
> -/*	Documentation/netlink/specs/netdev.yaml */
> -/* YNL-GEN user header */
> -
> -#ifndef _LINUX_NETDEV_GEN_H
> -#define _LINUX_NETDEV_GEN_H
> -
> -#include <stdlib.h>
> -#include <string.h>
> -#include <linux/types.h>
> -#include <linux/netdev.h>
> -
> -struct ynl_sock;
> -
> -extern const struct ynl_family ynl_netdev_family;
> -
> -/* Enums */
> -const char *netdev_op_str(int op);
> -const char *netdev_xdp_act_str(enum netdev_xdp_act value);
> -const char *netdev_xdp_rx_metadata_str(enum netdev_xdp_rx_metadata value);
> -const char *netdev_xsk_flags_str(enum netdev_xsk_flags value);
> -
> -/* Common nested types */
> -struct netdev_page_pool_info {
> -	struct {
> -		__u32 id:1;
> -		__u32 ifindex:1;
> -	} _present;
> -
> -	__u64 id;
> -	__u32 ifindex;
> -};
> -
> -/* ============== NETDEV_CMD_DEV_GET ============== */
> -/* NETDEV_CMD_DEV_GET - do */
> -struct netdev_dev_get_req {
> -	struct {
> -		__u32 ifindex:1;
> -	} _present;
> -
> -	__u32 ifindex;
> -};
> -
> -static inline struct netdev_dev_get_req *netdev_dev_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct netdev_dev_get_req));
> -}
> -void netdev_dev_get_req_free(struct netdev_dev_get_req *req);
> -
> -static inline void
> -netdev_dev_get_req_set_ifindex(struct netdev_dev_get_req *req, __u32 ifindex)
> -{
> -	req->_present.ifindex = 1;
> -	req->ifindex = ifindex;
> -}
> -
> -struct netdev_dev_get_rsp {
> -	struct {
> -		__u32 ifindex:1;
> -		__u32 xdp_features:1;
> -		__u32 xdp_zc_max_segs:1;
> -		__u32 xdp_rx_metadata_features:1;
> -		__u32 xsk_features:1;
> -	} _present;
> -
> -	__u32 ifindex;
> -	__u64 xdp_features;
> -	__u32 xdp_zc_max_segs;
> -	__u64 xdp_rx_metadata_features;
> -	__u64 xsk_features;
> -};
> -
> -void netdev_dev_get_rsp_free(struct netdev_dev_get_rsp *rsp);
> -
> -/*
> - * Get / dump information about a netdev.
> - */
> -struct netdev_dev_get_rsp *
> -netdev_dev_get(struct ynl_sock *ys, struct netdev_dev_get_req *req);
> -
> -/* NETDEV_CMD_DEV_GET - dump */
> -struct netdev_dev_get_list {
> -	struct netdev_dev_get_list *next;
> -	struct netdev_dev_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void netdev_dev_get_list_free(struct netdev_dev_get_list *rsp);
> -
> -struct netdev_dev_get_list *netdev_dev_get_dump(struct ynl_sock *ys);
> -
> -/* NETDEV_CMD_DEV_GET - notify */
> -struct netdev_dev_get_ntf {
> -	__u16 family;
> -	__u8 cmd;
> -	struct ynl_ntf_base_type *next;
> -	void (*free)(struct netdev_dev_get_ntf *ntf);
> -	struct netdev_dev_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void netdev_dev_get_ntf_free(struct netdev_dev_get_ntf *rsp);
> -
> -/* ============== NETDEV_CMD_PAGE_POOL_GET ============== */
> -/* NETDEV_CMD_PAGE_POOL_GET - do */
> -struct netdev_page_pool_get_req {
> -	struct {
> -		__u32 id:1;
> -	} _present;
> -
> -	__u64 id;
> -};
> -
> -static inline struct netdev_page_pool_get_req *
> -netdev_page_pool_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct netdev_page_pool_get_req));
> -}
> -void netdev_page_pool_get_req_free(struct netdev_page_pool_get_req *req);
> -
> -static inline void
> -netdev_page_pool_get_req_set_id(struct netdev_page_pool_get_req *req, __u64 id)
> -{
> -	req->_present.id = 1;
> -	req->id = id;
> -}
> -
> -struct netdev_page_pool_get_rsp {
> -	struct {
> -		__u32 id:1;
> -		__u32 ifindex:1;
> -		__u32 napi_id:1;
> -		__u32 inflight:1;
> -		__u32 inflight_mem:1;
> -		__u32 detach_time:1;
> -	} _present;
> -
> -	__u64 id;
> -	__u32 ifindex;
> -	__u64 napi_id;
> -	__u64 inflight;
> -	__u64 inflight_mem;
> -	__u64 detach_time;
> -};
> -
> -void netdev_page_pool_get_rsp_free(struct netdev_page_pool_get_rsp *rsp);
> -
> -/*
> - * Get / dump information about Page Pools.
> -(Only Page Pools associated with a net_device can be listed.)
> -
> - */
> -struct netdev_page_pool_get_rsp *
> -netdev_page_pool_get(struct ynl_sock *ys, struct netdev_page_pool_get_req *req);
> -
> -/* NETDEV_CMD_PAGE_POOL_GET - dump */
> -struct netdev_page_pool_get_list {
> -	struct netdev_page_pool_get_list *next;
> -	struct netdev_page_pool_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void netdev_page_pool_get_list_free(struct netdev_page_pool_get_list *rsp);
> -
> -struct netdev_page_pool_get_list *
> -netdev_page_pool_get_dump(struct ynl_sock *ys);
> -
> -/* NETDEV_CMD_PAGE_POOL_GET - notify */
> -struct netdev_page_pool_get_ntf {
> -	__u16 family;
> -	__u8 cmd;
> -	struct ynl_ntf_base_type *next;
> -	void (*free)(struct netdev_page_pool_get_ntf *ntf);
> -	struct netdev_page_pool_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void netdev_page_pool_get_ntf_free(struct netdev_page_pool_get_ntf *rsp);
> -
> -/* ============== NETDEV_CMD_PAGE_POOL_STATS_GET ============== */
> -/* NETDEV_CMD_PAGE_POOL_STATS_GET - do */
> -struct netdev_page_pool_stats_get_req {
> -	struct {
> -		__u32 info:1;
> -	} _present;
> -
> -	struct netdev_page_pool_info info;
> -};
> -
> -static inline struct netdev_page_pool_stats_get_req *
> -netdev_page_pool_stats_get_req_alloc(void)
> -{
> -	return calloc(1, sizeof(struct netdev_page_pool_stats_get_req));
> -}
> -void
> -netdev_page_pool_stats_get_req_free(struct netdev_page_pool_stats_get_req *req);
> -
> -static inline void
> -netdev_page_pool_stats_get_req_set_info_id(struct netdev_page_pool_stats_get_req *req,
> -					   __u64 id)
> -{
> -	req->_present.info = 1;
> -	req->info._present.id = 1;
> -	req->info.id = id;
> -}
> -static inline void
> -netdev_page_pool_stats_get_req_set_info_ifindex(struct netdev_page_pool_stats_get_req *req,
> -						__u32 ifindex)
> -{
> -	req->_present.info = 1;
> -	req->info._present.ifindex = 1;
> -	req->info.ifindex = ifindex;
> -}
> -
> -struct netdev_page_pool_stats_get_rsp {
> -	struct {
> -		__u32 info:1;
> -		__u32 alloc_fast:1;
> -		__u32 alloc_slow:1;
> -		__u32 alloc_slow_high_order:1;
> -		__u32 alloc_empty:1;
> -		__u32 alloc_refill:1;
> -		__u32 alloc_waive:1;
> -		__u32 recycle_cached:1;
> -		__u32 recycle_cache_full:1;
> -		__u32 recycle_ring:1;
> -		__u32 recycle_ring_full:1;
> -		__u32 recycle_released_refcnt:1;
> -	} _present;
> -
> -	struct netdev_page_pool_info info;
> -	__u64 alloc_fast;
> -	__u64 alloc_slow;
> -	__u64 alloc_slow_high_order;
> -	__u64 alloc_empty;
> -	__u64 alloc_refill;
> -	__u64 alloc_waive;
> -	__u64 recycle_cached;
> -	__u64 recycle_cache_full;
> -	__u64 recycle_ring;
> -	__u64 recycle_ring_full;
> -	__u64 recycle_released_refcnt;
> -};
> -
> -void
> -netdev_page_pool_stats_get_rsp_free(struct netdev_page_pool_stats_get_rsp *rsp);
> -
> -/*
> - * Get page pool statistics.
> - */
> -struct netdev_page_pool_stats_get_rsp *
> -netdev_page_pool_stats_get(struct ynl_sock *ys,
> -			   struct netdev_page_pool_stats_get_req *req);
> -
> -/* NETDEV_CMD_PAGE_POOL_STATS_GET - dump */
> -struct netdev_page_pool_stats_get_list {
> -	struct netdev_page_pool_stats_get_list *next;
> -	struct netdev_page_pool_stats_get_rsp obj __attribute__((aligned(8)));
> -};
> -
> -void
> -netdev_page_pool_stats_get_list_free(struct netdev_page_pool_stats_get_list *rsp);
> -
> -struct netdev_page_pool_stats_get_list *
> -netdev_page_pool_stats_get_dump(struct ynl_sock *ys);
> -
> -#endif /* _LINUX_NETDEV_GEN_H */
> diff --git a/tools/net/ynl/generated/nfsd-user.c b/tools/net/ynl/generated/nfsd-user.c
> deleted file mode 100644
> index 360b6448c6e9..000000000000
> --- a/tools/net/ynl/generated/nfsd-user.c
> +++ /dev/null
> @@ -1,203 +0,0 @@
> -// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> -/* Do not edit directly, auto-generated from: */
> -/*	Documentation/netlink/specs/nfsd.yaml */
> -/* YNL-GEN user source */
> -
> -#include <stdlib.h>
> -#include <string.h>
> -#include "nfsd-user.h"
> -#include "ynl.h"
> -#include <linux/nfsd_netlink.h>
> -
> -#include <libmnl/libmnl.h>
> -#include <linux/genetlink.h>
> -
> -/* Enums */
> -static const char * const nfsd_op_strmap[] = {
> -	[NFSD_CMD_RPC_STATUS_GET] = "rpc-status-get",
> -};
> -
> -const char *nfsd_op_str(int op)
> -{
> -	if (op < 0 || op >= (int)MNL_ARRAY_SIZE(nfsd_op_strmap))
> -		return NULL;
> -	return nfsd_op_strmap[op];
> -}
> -
> -/* Policies */
> -struct ynl_policy_attr nfsd_rpc_status_policy[NFSD_A_RPC_STATUS_MAX + 1] = {
> -	[NFSD_A_RPC_STATUS_XID] = { .name = "xid", .type = YNL_PT_U32, },
> -	[NFSD_A_RPC_STATUS_FLAGS] = { .name = "flags", .type = YNL_PT_U32, },
> -	[NFSD_A_RPC_STATUS_PROG] = { .name = "prog", .type = YNL_PT_U32, },
> -	[NFSD_A_RPC_STATUS_VERSION] = { .name = "version", .type = YNL_PT_U8, },
> -	[NFSD_A_RPC_STATUS_PROC] = { .name = "proc", .type = YNL_PT_U32, },
> -	[NFSD_A_RPC_STATUS_SERVICE_TIME] = { .name = "service_time", .type = YNL_PT_U64, },
> -	[NFSD_A_RPC_STATUS_PAD] = { .name = "pad", .type = YNL_PT_IGNORE, },
> -	[NFSD_A_RPC_STATUS_SADDR4] = { .name = "saddr4", .type = YNL_PT_U32, },
> -	[NFSD_A_RPC_STATUS_DADDR4] = { .name = "daddr4", .type = YNL_PT_U32, },
> -	[NFSD_A_RPC_STATUS_SADDR6] = { .name = "saddr6", .type = YNL_PT_BINARY,},
> -	[NFSD_A_RPC_STATUS_DADDR6] = { .name = "daddr6", .type = YNL_PT_BINARY,},
> -	[NFSD_A_RPC_STATUS_SPORT] = { .name = "sport", .type = YNL_PT_U16, },
> -	[NFSD_A_RPC_STATUS_DPORT] = { .name = "dport", .type = YNL_PT_U16, },
> -	[NFSD_A_RPC_STATUS_COMPOUND_OPS] = { .name = "compound-ops", .type = YNL_PT_U32, },
> -};
> -
> -struct ynl_policy_nest nfsd_rpc_status_nest = {
> -	.max_attr = NFSD_A_RPC_STATUS_MAX,
> -	.table = nfsd_rpc_status_policy,
> -};
> -
> -/* Common nested types */
> -/* ============== NFSD_CMD_RPC_STATUS_GET ============== */
> -/* NFSD_CMD_RPC_STATUS_GET - dump */
> -int nfsd_rpc_status_get_rsp_dump_parse(const struct nlmsghdr *nlh, void *data)
> -{
> -	struct nfsd_rpc_status_get_rsp_dump *dst;
> -	struct ynl_parse_arg *yarg = data;
> -	unsigned int n_compound_ops = 0;
> -	const struct nlattr *attr;
> -	int i;
> -
> -	dst = yarg->data;
> -
> -	if (dst->compound_ops)
> -		return ynl_error_parse(yarg, "attribute already present (rpc-status.compound-ops)");
> -
> -	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -		unsigned int type = mnl_attr_get_type(attr);
> -
> -		if (type == NFSD_A_RPC_STATUS_XID) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.xid = 1;
> -			dst->xid = mnl_attr_get_u32(attr);
> -		} else if (type == NFSD_A_RPC_STATUS_FLAGS) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.flags = 1;
> -			dst->flags = mnl_attr_get_u32(attr);
> -		} else if (type == NFSD_A_RPC_STATUS_PROG) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.prog = 1;
> -			dst->prog = mnl_attr_get_u32(attr);
> -		} else if (type == NFSD_A_RPC_STATUS_VERSION) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.version = 1;
> -			dst->version = mnl_attr_get_u8(attr);
> -		} else if (type == NFSD_A_RPC_STATUS_PROC) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.proc = 1;
> -			dst->proc = mnl_attr_get_u32(attr);
> -		} else if (type == NFSD_A_RPC_STATUS_SERVICE_TIME) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.service_time = 1;
> -			dst->service_time = mnl_attr_get_u64(attr);
> -		} else if (type == NFSD_A_RPC_STATUS_SADDR4) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.saddr4 = 1;
> -			dst->saddr4 = mnl_attr_get_u32(attr);
> -		} else if (type == NFSD_A_RPC_STATUS_DADDR4) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.daddr4 = 1;
> -			dst->daddr4 = mnl_attr_get_u32(attr);
> -		} else if (type == NFSD_A_RPC_STATUS_SADDR6) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = mnl_attr_get_payload_len(attr);
> -			dst->_present.saddr6_len = len;
> -			dst->saddr6 = malloc(len);
> -			memcpy(dst->saddr6, mnl_attr_get_payload(attr), len);
> -		} else if (type == NFSD_A_RPC_STATUS_DADDR6) {
> -			unsigned int len;
> -
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -
> -			len = mnl_attr_get_payload_len(attr);
> -			dst->_present.daddr6_len = len;
> -			dst->daddr6 = malloc(len);
> -			memcpy(dst->daddr6, mnl_attr_get_payload(attr), len);
> -		} else if (type == NFSD_A_RPC_STATUS_SPORT) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.sport = 1;
> -			dst->sport = mnl_attr_get_u16(attr);
> -		} else if (type == NFSD_A_RPC_STATUS_DPORT) {
> -			if (ynl_attr_validate(yarg, attr))
> -				return MNL_CB_ERROR;
> -			dst->_present.dport = 1;
> -			dst->dport = mnl_attr_get_u16(attr);
> -		} else if (type == NFSD_A_RPC_STATUS_COMPOUND_OPS) {
> -			n_compound_ops++;
> -		}
> -	}
> -
> -	if (n_compound_ops) {
> -		dst->compound_ops = calloc(n_compound_ops, sizeof(*dst->compound_ops));
> -		dst->n_compound_ops = n_compound_ops;
> -		i = 0;
> -		mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> -			if (mnl_attr_get_type(attr) == NFSD_A_RPC_STATUS_COMPOUND_OPS) {
> -				dst->compound_ops[i] = mnl_attr_get_u32(attr);
> -				i++;
> -			}
> -		}
> -	}
> -
> -	return MNL_CB_OK;
> -}
> -
> -void
> -nfsd_rpc_status_get_rsp_list_free(struct nfsd_rpc_status_get_rsp_list *rsp)
> -{
> -	struct nfsd_rpc_status_get_rsp_list *next = rsp;
> -
> -	while ((void *)next != YNL_LIST_END) {
> -		rsp = next;
> -		next = rsp->next;
> -
> -		free(rsp->obj.saddr6);
> -		free(rsp->obj.daddr6);
> -		free(rsp->obj.compound_ops);
> -		free(rsp);
> -	}
> -}
> -
> -struct nfsd_rpc_status_get_rsp_list *
> -nfsd_rpc_status_get_dump(struct ynl_sock *ys)
> -{
> -	struct ynl_dump_state yds = {};
> -	struct nlmsghdr *nlh;
> -	int err;
> -
> -	yds.ys = ys;
> -	yds.alloc_sz = sizeof(struct nfsd_rpc_status_get_rsp_list);
> -	yds.cb = nfsd_rpc_status_get_rsp_dump_parse;
> -	yds.rsp_cmd = NFSD_CMD_RPC_STATUS_GET;
> -	yds.rsp_policy = &nfsd_rpc_status_nest;
> -
> -	nlh = ynl_gemsg_start_dump(ys, ys->family_id, NFSD_CMD_RPC_STATUS_GET, 1);
> -
> -	err = ynl_exec_dump(ys, nlh, &yds);
> -	if (err < 0)
> -		goto free_list;
> -
> -	return yds.first;
> -
> -free_list:
> -	nfsd_rpc_status_get_rsp_list_free(yds.first);
> -	return NULL;
> -}
> -
> -const struct ynl_family ynl_nfsd_family =  {
> -	.name		= "nfsd",
> -};
> diff --git a/tools/net/ynl/generated/nfsd-user.h b/tools/net/ynl/generated/nfsd-user.h
> deleted file mode 100644
> index 989c6e209ced..000000000000
> --- a/tools/net/ynl/generated/nfsd-user.h
> +++ /dev/null
> @@ -1,67 +0,0 @@
> -/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
> -/* Do not edit directly, auto-generated from: */
> -/*	Documentation/netlink/specs/nfsd.yaml */
> -/* YNL-GEN user header */
> -
> -#ifndef _LINUX_NFSD_GEN_H
> -#define _LINUX_NFSD_GEN_H
> -
> -#include <stdlib.h>
> -#include <string.h>
> -#include <linux/types.h>
> -#include <linux/nfsd_netlink.h>
> -
> -struct ynl_sock;
> -
> -extern const struct ynl_family ynl_nfsd_family;
> -
> -/* Enums */
> -const char *nfsd_op_str(int op);
> -
> -/* Common nested types */
> -/* ============== NFSD_CMD_RPC_STATUS_GET ============== */
> -/* NFSD_CMD_RPC_STATUS_GET - dump */
> -struct nfsd_rpc_status_get_rsp_dump {
> -	struct {
> -		__u32 xid:1;
> -		__u32 flags:1;
> -		__u32 prog:1;
> -		__u32 version:1;
> -		__u32 proc:1;
> -		__u32 service_time:1;
> -		__u32 saddr4:1;
> -		__u32 daddr4:1;
> -		__u32 saddr6_len;
> -		__u32 daddr6_len;
> -		__u32 sport:1;
> -		__u32 dport:1;
> -	} _present;
> -
> -	__u32 xid /* big-endian */;
> -	__u32 flags;
> -	__u32 prog;
> -	__u8 version;
> -	__u32 proc;
> -	__s64 service_time;
> -	__u32 saddr4 /* big-endian */;
> -	__u32 daddr4 /* big-endian */;
> -	void *saddr6;
> -	void *daddr6;
> -	__u16 sport /* big-endian */;
> -	__u16 dport /* big-endian */;
> -	unsigned int n_compound_ops;
> -	__u32 *compound_ops;
> -};
> -
> -struct nfsd_rpc_status_get_rsp_list {
> -	struct nfsd_rpc_status_get_rsp_list *next;
> -	struct nfsd_rpc_status_get_rsp_dump obj __attribute__((aligned(8)));
> -};
> -
> -void
> -nfsd_rpc_status_get_rsp_list_free(struct nfsd_rpc_status_get_rsp_list *rsp);
> -
> -struct nfsd_rpc_status_get_rsp_list *
> -nfsd_rpc_status_get_dump(struct ynl_sock *ys);
> -
> -#endif /* _LINUX_NFSD_GEN_H */
> -- 
> 2.43.0
> 

-- 
Chuck Lever

