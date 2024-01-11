Return-Path: <bpf+bounces-19372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B35BA82B4CC
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 19:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBC7F1C24650
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 18:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B541CF86;
	Thu, 11 Jan 2024 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i9nIWHCK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vpFshdhX"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F53556763
	for <bpf@vger.kernel.org>; Thu, 11 Jan 2024 18:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40BGmsEq030038;
	Thu, 11 Jan 2024 18:33:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=ywQuBIgigQNjlbvPUF6f5Rwv2HOBslI1sTmSbu9yzME=;
 b=i9nIWHCKiOct+MumjAhY5dpYrPDwA+vBIWe7qPj/7yMSjO+Fp8cdiE+M2M/zoJCCy0x1
 avD+9i/X9oixmKr2W+wHe1yv5KAd9EebF3SUCL2Oww2xmP3uIHnvfhjNZLQar4aEOJcV
 9Id+6Q+avmh9s3PBSHNVGkf6a82uQ7TANWtyb9SmXB/0hJ5IGxbLD5kfgGZtuJ8x74PU
 /X7Mm7msAoX2GqZ6GE5xk+wnBZmLxQBdg5lMHuA4XV8HneoNgHyZwQDgdZw/3pp7vOBt
 2I2ZzDgCMwqx6WkJiAbzyTrTAuEg66TvKtRxP72UJSTK2R5L3cIOkU0JJ8yYz7UeEZYU DA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vjcnv18gx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 18:33:38 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40BHPXpi030112;
	Thu, 11 Jan 2024 18:33:37 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vfutqjqc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 18:33:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6xPmolHge2y3WPCgr0WBgBWX0SCYCGgiPancqkZON4NhM4kS2uYSr1OOOPSkOsq9q3cNbyX3ITMS6pSmO8lbTpwGzSo40Tg5967/nmXYMS7Z9mtc/NpCD2xNleIylwwt+ysp0iIKMIEY8y3g2n6hNaLWgtFB3CvV9B9QQMqnjhdCvY4q0KvESpJn0GY7gLoQBygvvgpsvlgGwOrDGI87UeJBys0wsrivgK3D/YWfFI/0nk+2sUXI43HXA/9QI8wEWsfOIptqBF1WlUxDiL40X4xgYjHL9qkwYT3nxvX0TInWnZLn92/djOCzEsNRrs9eV5jufpFa+qKGGEEemiZvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywQuBIgigQNjlbvPUF6f5Rwv2HOBslI1sTmSbu9yzME=;
 b=kHrahzjwlXQoDnA0XlyghoBEsBW6WXKzWylcSsIp+D602qTpptiANTBCTsqAA6Dh2ZHVb8+2HMP6r0O6P7/UurfUStHR0TSkIj76cTVPRWyApYH0iW0Reo+9WDrk5gz8og7rW7U1BORlUwolqE9MFiSd/HmI9K2LxNhOCk74o+oHQdmjem09HZD08WmXD1wkvvInW30Rmg5lhd9/Z+11iHtu4qkp3VnfAAL5pc6iUm+1J0l1xoW0RPavE2s+zQqQUdDzXy68L0n69w3pBxHBHFxCY1UeOxv3yHuFzpUCSPedPDss8t80ndfpeI6R2qjbVrEv0liIS+cK1ORItAz2SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywQuBIgigQNjlbvPUF6f5Rwv2HOBslI1sTmSbu9yzME=;
 b=vpFshdhXvzDXBsy+w3uUr2kdrwx8BmP8zTZSDIIzj22txSZwlxA9RfqbXSbZxSiqj3vbtPcKDF/2VXpPfNhxQWoMUkWAsB6Si2zx4WuTod1swTX0sFGZLbqMA7Z0ikKTbIUa/ds4D0klLU99LjwGtU56sRSXP7d+brY69+LfRBU=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by IA0PR10MB6866.namprd10.prod.outlook.com (2603:10b6:208:434::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 18:33:32 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::a45d:77b4:ce0c:9146]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::a45d:77b4:ce0c:9146%7]) with mapi id 15.20.7159.020; Thu, 11 Jan 2024
 18:33:32 +0000
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
In-Reply-To: <87mste4sjv.fsf@oracle.com> (Jose E. Marchesi's message of "Tue,
	09 Jan 2024 13:09:24 +0100")
References: <20231221033854.38397-1-alexei.starovoitov@gmail.com>
	<20231221033854.38397-3-alexei.starovoitov@gmail.com>
	<CAP01T77fbW-9N+Z-2LFS=174HN6v_OJAbR_s6EOfLLW8Oceh_g@mail.gmail.com>
	<CAADnVQKY4hB4quJX_oyq4GULEJkehXWx6uW1nAYHveyvdyG8sw@mail.gmail.com>
	<CAADnVQ+tYBpt_aRG5aU3sAYEysKxUOKQ24dBG4bP2kLy8nmmgA@mail.gmail.com>
	<44a9223b6638673487850eb9d70cc01ef58e9d93.camel@gmail.com>
	<CAADnVQLmXxn9RrniktuW80XO14oyOmgJ_NboBBC_-CU4O=-v9g@mail.gmail.com>
	<87h6jm6atm.fsf@oracle.com> <87mste4sjv.fsf@oracle.com>
Date: Thu, 11 Jan 2024 19:33:28 +0100
Message-ID: <878r4vra87.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0010.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::14) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|IA0PR10MB6866:EE_
X-MS-Office365-Filtering-Correlation-Id: d694c3c1-69a8-4562-5f8f-08dc12d3d074
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Jvb7+hiNIxFRdNBFipqXqtpB4Wshnmh9CWjSYguUmlUnl+F2GazuOUZxxSl97TiNKhFlD58QBHQq59FCRkEN5YaUJznCLK7LWVIOH+ktJUM4VPzu+INc+7q5zLteUxXS/j+RmBxt9CNcKATSJumtan2wRIEfCnkjBeOp+ajw6wIrqH7jBh0IoDe0qIAF6wLCBn2MO/9mtTzKXZrsDm4V6Xa6WF+bd5sB1B4DXfq1HlQp6vFR5jfFHXtQPMETDgCx3f9HmR9IRgK9lzZTF9zQMyT32zHve1tSrE5t2XPR80Xm7yYnPPFN9DO3ZcPoo+9YRdfRn/ZqvGjvgK+vDau2p6TlYPMxvn78oZLRB+XP3qFlSwKva0m8/vlEjA4Bv+GSTt9ti0yUo0Yxsq542qdBUEg3TXIS+82ceRrs6PYoggKGvGh5UDKXci8KMpdg5gyVrlMXUDjlegDwhvK8lQLu7nR968IJZJqmDfIo3gHyG6zE8ZSQd+SM+ZWLQ/qMNkZp8XvW/Vxpv50HH5lc3wlPmTNTLrdjBrpj3DBMg3tCPvD8VE+5zFhJLJlWDPBeJJGioCvpLnB2plWBLy/QF8xDmf+tD/OXZGImAONC24+dcUyVQ63Jvl/RzjwAjPxcW2KI
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(346002)(136003)(230273577357003)(230922051799003)(230173577357003)(1800799012)(64100799003)(186009)(451199024)(83380400001)(26005)(7416002)(6506007)(5660300002)(6486002)(6666004)(8676002)(66946007)(6512007)(2616005)(66556008)(66476007)(6916009)(4326008)(478600001)(8936002)(2906002)(36756003)(316002)(54906003)(41300700001)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2e3I/36JEk/Yi7u8765NF7j+sCHUeXTBDqs5Qa7bN5uZ8r0tNhOdIAl+oFld?=
 =?us-ascii?Q?huiBQ/RJoP2ePuPlly90cvEge8+MI1/lj5HAR4lP31kyvgUgVBeThb900H/x?=
 =?us-ascii?Q?m63fBeu6GPVO2XfYbXzkcN/eZDlyTuhkYgRpFggT7yrq1wCdX/iNyosqQkqm?=
 =?us-ascii?Q?6tUE5PBNLzvZF7Gojn26ZJx9zbgykgvqm2GIGbA3nMaICSpCn6fHUSjvDV+M?=
 =?us-ascii?Q?Fqx6vNZ7CIfeg3JVNEvYgnBcPiyG+1fusXNdihHMv1FijL6+w9Q0KlxAL6OO?=
 =?us-ascii?Q?bAm+JAoy8V3jyu+bOd0UnV5wBUdE4MgCsGuZ2aCCg2b6DtiJhdwvsgbHG4Cv?=
 =?us-ascii?Q?Ht/LYlpIVQ3yVxIuGdbaJYiTr1eTMQ/zStVt5Pvl2s/SiJ0KnX21FpKnFPYN?=
 =?us-ascii?Q?GCrOoWDzRSlsZkkaYqqt86rjSQo6EFNm8S/ucXakpc7bBuoBSFN026EEPcEM?=
 =?us-ascii?Q?8x1zVp/5LiiOVJovxK8m923SZrAymEivyzvt0rHZlnWzh10MezLEjujq+zoC?=
 =?us-ascii?Q?4ezIGB2dgmHwpRdhrlwTWJVBdm7PHCwkSzWnU6JMz4CoA05xShSXL2y1WHKS?=
 =?us-ascii?Q?OTYlH6+6G/NehFvazeEiZ0L4q33HxB7b5tEX6bxbrvEACv0SmithVI2siMWn?=
 =?us-ascii?Q?BZDfx9caWth3nPpzwwta/y+cPH8dl7zlflmVFSKt2BBnIkDbOuIieeLCQZDi?=
 =?us-ascii?Q?CyD7gIjUCfB4WfHgHo6mYlzbNcAmvnXUV/pJmqPKx4jfW7xYwi1Re8Hkun8w?=
 =?us-ascii?Q?+mLF+JmLY2077J1s+vneaogkFck4JxXCaJ1BIj6nBrp+4jcuHPAJKSVww0S9?=
 =?us-ascii?Q?4O2KKnEzlTiaYTO1DSyLOlAWvxNYXZh0YNQzngCr3aV7Zt98hX2+GcdO9pzf?=
 =?us-ascii?Q?UHo9oI/t93nQB3fOXIBHgsRAPYkzp0bJG3VbGmBgE02Xq444dXcS2U8tiAKJ?=
 =?us-ascii?Q?DrSnSySn9ANHo7HRoZI99Y0FJUnjQ/xiwfeAgXVb/nU4S8jCVBREWAxqh+fu?=
 =?us-ascii?Q?2aX/LZnL/uJsYLwC0evk4qUuG5eMAgQW+9qQG53Ogtjz+xNnilXQY+O3lEXz?=
 =?us-ascii?Q?qvub4WoQ3WwOMu/84ABuoXPIJZIv/Q3jMRGNEbZCtdAHMJBaFfoYkx6vOy+k?=
 =?us-ascii?Q?zGOxZE6GYpYYl52bMnMdm0OIwTr9iuc+YOsKBmTA0XNGyv8seQDIFCdV3GQe?=
 =?us-ascii?Q?0iQjF9rRYAQ/w7dDppWCDXv5xXFEQ8fn5vcuitqB0jsw8vH9fCKXgjTJIuZu?=
 =?us-ascii?Q?3fTfurhydNgcf1LiJIdIVl/pcFlGF74J7ZAp0X/dII+Oaj6HoPJqZJcsZ++b?=
 =?us-ascii?Q?7B9MoPnk176929IuMlxYUcMokDfzxMjxJiJX6DZIYnns3VSAhWOiHyvdtmYj?=
 =?us-ascii?Q?BBO5nZWJNhKJ3BxnjD3aQmV+ybeZuqvrsNntORnL6wzwoEJvYlAqyY41LjuM?=
 =?us-ascii?Q?zpK4l9R3yNk6h8KdbOmSGMnoj2KJH5siUYk0Q3HT3pfz/FCBK/8LT+DLnbgG?=
 =?us-ascii?Q?TREG+tbfZaAXTjeGAkHwCHRF2TPx4L7u/9ujh/x1FxD49x0wBcA9as0Txka7?=
 =?us-ascii?Q?qpiv3+9QWyCZv6nZytswig17raE8ubFIcV5UMnYZVjTg57hT0PAl/KxbyUxj?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7c6y0oLSZFZcTXsrMStjksaPM2mQBXNRe0t2jZQtZkYOkhXcy5YYQbh/xsWmp7C+Q3sLRYaYmy8BG0IOSw7dLs+EB596jx8X1w+G7CTwXx8+eKIdDhYMlwkdpyScpSgKUjnmpOGcClhwZlgT8v5klpLAwYw08f13+dWUcSnAe4E+g3VROZj06YCSPdJZ7bS52DNq9fA4qcC5HRCSp7ToH4hb+f5IqaNngRMoLNOv9FHRIEdplodvHTjeXxt49qT4/F0pah6ID5YhydPtLSvaNp5hu2Lg1pvplsnvXd2uUeyuR2u17XBf/Fw/sLMagwtGvwVSko9xsbFWvJYVS5xksLSf4myGupL9PhHG/ki+6k1c5E2BNJFTql9N/tL90VTCNK310iiMq7TbXr4DuoCtwVOQjAX/+BTNimDAius6+91Evt4SxgObkm1vRurfC1TvdJxZdxqzL0F9588YXNkpY3AV6q+2M2uxOoIqkzMT5MeJ/rG5H9HOxqzmqEKPCv9xBlVxg0pYj4c25EgnC3juPcskLDQN7XBKQj/iWx1g6Dr2YOLjnmz5bzz08giNuNB0j/ZpRuW1foADyhys8aO2u3GEKGYuU/ypjJcokh/dzZo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d694c3c1-69a8-4562-5f8f-08dc12d3d074
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 18:33:32.7376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 459h9rIsj8GghZRjz9zfs/wbg8C/LHCAqKoVGm5LOu6VE4ocx0xPZ3OBPFloh45gAMQlAJPeCJ+WMo8/KssPVDJTToB3l5JdiT90ExMyabc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6866
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-11_10,2024-01-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 malwarescore=0 mlxlogscore=925 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401110146
X-Proofpoint-GUID: 9_kmX6nKC8-V-3q_-DzUfNA5esUCWFlt
X-Proofpoint-ORIG-GUID: 9_kmX6nKC8-V-3q_-DzUfNA5esUCWFlt



> [I have just added a proposal for an agenda item to this week's BPF
>  Office Hours so we can discuss about BPF sub-registers and compiler
>  constraints, to complement this thread.]

Notes from the office hours:

Availability of 32-bit arithmetic instructions:

  (cpu >= v3 AND not disabled with -mno-alu32) OR -malu32

Compiler constraints:

  "r"

     64-bit register (rN) or 32-bit sub-register (wN), based on the mode of
     the operand.

     If 32-bit arithmetic available
        char, short -> wN and warning
        int -> wN
        long int -> rN
     Else
        char, short, int -> rN and warning
        long int -> rN

  "w"

     32-bit sub-register (wN) regardless of the mode of the operand.

     If 32-bit arithmetic available
       char, short -> wN and warning
       int -> wN
       long int -> wN and warning
     Else
       char, short, int, long int -> wN and warning

  "R"

     64-bit register (rN) regardless of the mode of the operand.

     char, short, int -> rN and warn
     long int -> rN

Additional constraints for instruction immediates:

  "I" imm32
  "i" imm64  (already exists as "i" is standard.)
  "O" off16

  warning if not in range.

