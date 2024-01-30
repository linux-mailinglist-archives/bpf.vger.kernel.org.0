Return-Path: <bpf+bounces-20698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3739384224D
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 12:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0066BB2E7CC
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 11:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D1365BD0;
	Tue, 30 Jan 2024 11:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VaIFJLjc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pJCqHerx"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFAE5B5D0
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 11:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706612650; cv=fail; b=VLWg2qEd4IF0jJJkUPMWcX9LRqLHP+Zgu560RQ5yDiYsetiLEJE5Z+XlYKPbb9Q/etz6KG1xHdCKVrlmTwj8sXnGpK6cI+BeaDk3XE8OsDrtYU7YkThL3nXdpFMZOhAf/h/gy/iqr7D38uiAgUiqIRxMzXzWuNH6XbZlSXbs8yI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706612650; c=relaxed/simple;
	bh=1AEv6K+4rUoKQ/rZGRKwZ2uc0HexdMYV1bXcLsax/HU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PFWZKz4V2p+nQWtdi5LxHWSBwBp6DqCcz504cuFQtKGGPy8E6Kugb1k32SOUSZM0snH2wqEYSFC65E2KssMbXiqR6ytbx6lf3IRsh6rE1wC3aQMNPHkhVWI7h3AmKhL22X6MZZcffwr0s7KvDnoTCJyPJ3E9sxVOtflrrsPZZV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VaIFJLjc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pJCqHerx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40U93xad013142;
	Tue, 30 Jan 2024 11:04:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=eHxbVhGduwo4y1yKs0oapSNb5fW1a73WEEg0NSU/78A=;
 b=VaIFJLjcTLOiUxqLtJGt9eK7Mc96RQpHrcu9U/GnaH8AN01+B3AgN3oRfnH4knOZj5MP
 8LH0P3OUR1vpIqI7VpeJwRj8AQmsZ+cEME5j3NclkCvddExtAEMM1lfPNSkOGnI401GB
 E8j4nR86O9I0cbJ5K/nf6XrnPGBy/56j0CC7uy4QAQ0kjrINsA08OeqjaHv2mL6ARplA
 LFkvOsiROFLSD8taHvYq0t78R9gYCQKr2uCPSyQLIOnRlWdK10BkYdlBpQB30HQ8nbuK
 VJnD6REdz/yUh1P4bNsLETUw+eLN/IIE9DN9XHGq4BzspDHFarf1WQqkHPdUEb3yW5PW yA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvsvdpef7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 11:04:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40UAcQVs031413;
	Tue, 30 Jan 2024 11:03:56 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr97776r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 11:03:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3Ieuyz25oXkWR7db4TYRybBQC4vRpTrqnt8iD/GWZrbi246OYZsB03YIfFdvMRIEwbRhxeblQT7PLFYNecReSUJsVc5WhmyTsLADCCGKqXpJv5YtImQ6k6xDqFO7dpU0f8Vpg0U/jFkiDiJQndPuaJWsiB6L0cRY1Z8dzHunMyPcKrdl9rmgKSrCXhHS66TA1q3q3inPEDBX/6R7mCKL38OKgJ6IrvHKhm6thu1cYoJFB24oQW4hYzObeCuz7Qld/S3ujgI+RrYZprsaR98BJrIzYIPUriTcUiSbaoIXZTbNQ7iPmoNRqQ3mXntH+kF04dXwKEXaSuysj1Qy5p13Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHxbVhGduwo4y1yKs0oapSNb5fW1a73WEEg0NSU/78A=;
 b=Zr8X8J0XhtJzYUzcBTg8DtFyFNGydd2JzKhNG5IMCgFMgjCzbvTyPJst/Ml+zLRYq8mGOuVueFywzZVA4zcEyLlDkiumOBNfQQE/ogfwoOA6phs6TsvfBJylWq5cq64WoMvl56DK7a1DN19kO4djJXFqrcUGLlPJ65g4Nlp2fPXl64KrIxiC8TKNbRKKkEyyNAq6X4AXCKc447lF8WNz3fBDWXw7BBSMlWKAkxcXLp/I0YSYrV6LJJ3uowDGi+kj2tnyRYElMNGdqLeiYs3sjoaDhKe2zwgt/lh15A8wZNAodmN3MD+QEZfAbDn/wuL5/6ToxCCoGEE+KDMI+dL8mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHxbVhGduwo4y1yKs0oapSNb5fW1a73WEEg0NSU/78A=;
 b=pJCqHerxxV9yMCTLsxzkql4tk0XBlrdOzzkiJxkZbx/bbabNx0rnRgIzryphmafpN25zLZWbzad757je3+LHmt9KqGehkQC+mJy365drM1NLnZ2YijqTwcW0dGKMuBLy+NYFIgNeuEFVqN0YbOK64MRnaI1yH6TJlQ7lPr4ogsA=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by CH3PR10MB6692.namprd10.prod.outlook.com (2603:10b6:610:148::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 11:03:53 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 11:03:53 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Yonghong Song <yhs@meta.com>, Eduard Zingerman <eddyz87@gmail.com>,
        david.faust@oracle.com, cupertino.miranda@oracle.com
Subject: [PATCH bpf-next] bpf: build type-punning BPF selftests with -fno-strict-aliasing
Date: Tue, 30 Jan 2024 12:03:43 +0100
Message-Id: <20240130110343.11217-1-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P250CA0005.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::10) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|CH3PR10MB6692:EE_
X-MS-Office365-Filtering-Correlation-Id: d8a98f7c-34f7-45e2-ad23-08dc21832559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	IXoaaCqfUeNkClIMr5FUprjA6u3q90CD0FFD31F8B4kfpQYxrfPCeCicJsGzDN9RCg1Ow0DmZidL0FoEPO1D6PrEnMllDKDrezh5v8DVEnDhdqgjukg+oKeBGai48waT2opcZ8l59xJxi4e1RxwMeTJ8jIMCmv3VbsTA+fkgSVFyknIv80ScW1m3gU5XzDgH5/WXj6VIFus5CgCKbVYKrJ85qRQlIJ4OISOBwlW6oF3AAyGgQBEsTY/Aa01TSGmkxSwSTYzNjZZfvvY7JydRLDXRNlludLEHggiFXVk3w0jQcLrmq114r5dHRAEJ9pqomEOy4ivFb9f102YwRIp78GM1WlVtfvUGa8IFtnrap9aV7ea4vL4kwyJirO7tOu4fx0Hf6s+VsXc2O2DzRhQlXQAtYlvEcySC12NFz1tYtJKOcROIgbX7iwVkPSl6brOgEfvngOyxDSO2UaLvvvGGXuloSz0blQ8Syv2OOSEmEK7kp/k/uV5WbAR/H+mx2MmkquxpZysDY2a47bEqH1YhwEPoCKVJsa2BOlxmgwePqt5wzBTiatPEc2OWb3YFS8uzgKq8AyeufsC3mjOnr5u8HqWPNjptzXR8uPWgA75OuBAuTRUBP0TBP+8qYLAG/HVq
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(39860400002)(136003)(230922051799003)(230273577357003)(230173577357003)(186009)(451199024)(64100799003)(1800799012)(6512007)(6506007)(1076003)(2616005)(107886003)(26005)(478600001)(6486002)(83380400001)(8676002)(6916009)(8936002)(4326008)(2906002)(86362001)(66476007)(66556008)(54906003)(316002)(5660300002)(66946007)(38100700002)(6666004)(41300700001)(966005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?4KcNRkTwxGRhqcVPliyI/8Kw6S1w6OTQtIppje8zvtAH9skWnobCmiSRX8p5?=
 =?us-ascii?Q?mZcaMXVntG7GbK9qkFRKgxqr7FFV0zkFG2EvoKHRn2NJKkgeyr3oN8Dyn+sU?=
 =?us-ascii?Q?lXQd6NAtZ1m1WshjskqpBef95lhRNqmDUXVi65HAlh6JciMSUEjY/0sdYgya?=
 =?us-ascii?Q?JOGzh2AJ2I8XBVyQhKtgQo79NimRdne9fez1YsdQEaz62qnKOzSsr4pO87cM?=
 =?us-ascii?Q?oxfzZySzffOcAsreg01RcqO42j4Ykjeg7raunzkRyhcmYmhpvKAdCwbMpwN+?=
 =?us-ascii?Q?STYS5eSxBt2xcsu5cQpA426MmUdNU8mH8qRfwDbpHXZnyz94XidiR6GP6uQx?=
 =?us-ascii?Q?qwU1LvB6HD5VbCrRtI7sRL3yVh40TASiB63b1ktlR1FGzlKd0a22JfETQVpo?=
 =?us-ascii?Q?kjtvEyA9X2iN7ZSvrrFziBtx0767krtjoaZRUh2PDHOC5EMzblkryhuDpCd5?=
 =?us-ascii?Q?7e98/fOpbAghiWq1lB8bPqJh9tYtILB6ATpudzaOiJewXmlkF99siojPXR1F?=
 =?us-ascii?Q?B18Y7Cr/EutwHcMs8pMg0qML8OhejBKVRvES6T4TeNPT+7ArxrVZLsSar41B?=
 =?us-ascii?Q?yuhFTMAA2u226tyM8JEZDm+O9HhfaA7MxPPkHZzmVPFLOHRFtnU5TcWhja0F?=
 =?us-ascii?Q?YsWmFbMXeuU+aec83ebEoL6Jy7M8WL7kYwLPnZeEIeZtMs/N3kckAbl6jdaF?=
 =?us-ascii?Q?DbN/2bh22QPmvMRMRO9dAnk3Su+uJOWRMnX4JVm7+uKXqv8Y+t3uX9CcqIYC?=
 =?us-ascii?Q?964Nnd7Zi93U3TU28nF2BC98t736jLGSaCBk2qK6dh3mbnmhy7JXVEtp3a1+?=
 =?us-ascii?Q?ge1f0IvOrG0k9zGhPfI8cpNumNZ6l59HHPSXt1EkdIjPpToQHtQ+goIK8ZWl?=
 =?us-ascii?Q?DyS+rnOU21hOFeHpyDt+plPfu8LhS295FRZYbdfEBfT0anuiZExU8PjLUOUA?=
 =?us-ascii?Q?mvUvP+Xo5qyt2z2dtZpxHWU9zC6kYJ+n3kdFbTelRQ6xginF8I3HXV/XX1hy?=
 =?us-ascii?Q?VmbMAqTk2kF8e1k49+7Y9BKsUzGN+2BkTR4q0qWLwiYfD+kSXoa5ur7vrVCt?=
 =?us-ascii?Q?w1G4inAxsbzL+wCC48iWOHvt0241/2cPohqXzkCBOf2rz5XhD1h7ihbK61X9?=
 =?us-ascii?Q?P8XTafM0rrof84SKS0N8w54tKlyqozZp/DfeBLBa2ealRnAbfIWNrvkQBcBY?=
 =?us-ascii?Q?/4SYgnGKXzziwozXGIaak4q0GFbDf0moCsVmgU3IagZ1GQibj6Vzy6jkGeZ1?=
 =?us-ascii?Q?GtCu7sEo325Asxy977vQhXmy0WOrc6kCJKjhe7zz0lxpqiIKLii4RD8kaIMu?=
 =?us-ascii?Q?AaVSDEYjZiIZoG62ASov8h1pwYQfLdk0NrcYEnAW2mNhZD7l0gkUm3sOWp1A?=
 =?us-ascii?Q?eW3A8qALwnLzyMEFeJQdSCdn6VAnxL6V8G6W8B6vv8H5WQ0qRp+WEJbXGbvQ?=
 =?us-ascii?Q?lPLoL7ubZiZGJWN/5X/f3XhHAQOmtrZqPJpOOQuKLObTsfGGxISTrRoCRhpx?=
 =?us-ascii?Q?BQo6eV0Qzl0FlXPQ7Jw4ZUYE91qcHa8HURF1pF+x3F18R7Vfge3CsSPqCJBa?=
 =?us-ascii?Q?Grdxf6RrEyBsObfqSym5Bkh3W3qw9W5r2zeombAVH3tJ30/pUxLsPhpk/STs?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gmL6/7yYN/fHX2uV0dlKgc9TEP959wes6RUclsWvX+aj+2w+qCBwWuSv5+Nm8ws16g26KoARv5jd827RwoRYFSVszPLLz6HdzldNZuX2tPAODLaM9h106dNwrsJsjnnIqpHcWozx0LVRMwEqCpmA2z3pYNwp27ZFLg1I7dUz/LiyCvS2kD0q0hIUixtxHf4Ar3b6nzWtS1pUUOtD5ZkFJEevqtYFOFTJYTHOnvlm+FrK0CaVee+FaPmy06h0nb1600ZFrFXhHxLrNpvs1QdWnX4iyS3FVKTRcHGj2mxaCoNl1xSTzesLI4qkaWNqWoct8cixg6PFpal4B0jwsciCUKb8yJQgO5QoUQXw6GqhWypoobGSQuF1nghkSpB5hpk0TV7GuORBqNwsOmRc5syegV4joQNWTXswlPCCN0NhTNtDr5akimD+/vOMY8+MjOn7h9WQBQUwh9CC6RD7AehHhRyKLbQMblQ48q2gvruUsWjTDCecfEx0QaCFcpJnBvJmA4r3JLZf1noR78kFywKaKh9XXW32TXuY4HdslOH85zl1gAkW72v8rFFeJC15TqTLjNYkC9zr9NJQjaK7Lr2L0c9BMszwS+w3GH18ZAmyuCU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a98f7c-34f7-45e2-ad23-08dc21832559
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 11:03:53.2742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U9LTFnX6UAByW6c63oX+VaQEk2wbTWyOEyzdr9Pzc38gSwcqydhx6s2LAFgDwGKwywqv75HHf9km4YqC3JECRvseSrjpAANN98GJIeedj0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6692
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_05,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=929 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401300081
X-Proofpoint-ORIG-GUID: t6pONGNWYsbz-lYVXE8lvyBL2Xw9uQFc
X-Proofpoint-GUID: t6pONGNWYsbz-lYVXE8lvyBL2Xw9uQFc

A few BPF selftests perform type punning and they may break strict
aliasing rules, which are exploited by both GCC and clang by default
while optimizing.  This can lead to broken compiled programs.

This patch disables strict aliasing for these particular tests, by
mean of the -fno-strict-aliasing command line option.  This will make
sure these tests are optimized properly even if some strict aliasing
rule gets violated.

After this patch, GCC is able to build all the selftests without
warning about potential strict aliasing issue.

bpf@vger discussion on strict aliasing and BPF selftests:
https://lore.kernel.org/bpf/bae1205a-b6e5-4e46-8e20-520d7c327f7a@linux.dev/T/#t

Tested in bpf-next master.
No regressions.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: Yonghong Song <yhs@meta.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: david.faust@oracle.com
Cc: cupertino.miranda@oracle.com
---
 tools/testing/selftests/bpf/Makefile | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 1a3654bcb5dd..79253a376fc8 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -41,6 +41,19 @@ CFLAGS += -g $(OPT_FLAGS) -rdynamic					\
 LDFLAGS += $(SAN_LDFLAGS)
 LDLIBS += $(LIBELF_LIBS) -lz -lrt -lpthread
 
+# The following tests perform type punning and they may break strict
+# aliasing rules, which are exploited by both GCC and clang by default
+# while optimizing.  This can lead to broken programs.
+progs/bind4_prog.c-CFLAGS := -fno-strict-aliasing
+progs/bind6_prog.c-CFLAGS := -fno-strict-aliasing
+progs/dynptr_fail.c-CFLAGS := -fno-strict-aliasing
+progs/linked_list_fail.c-CFLAGS := -fno-strict-aliasing
+progs/map_kptr_fail.c-CFLAGS := -fno-strict-aliasing
+progs/syscall.c-CFLAGS := -fno-strict-aliasing
+progs/test_pkt_md_access.c-CFLAGS := -fno-strict-aliasing
+progs/test_sk_lookup.c-CFLAGS := -fno-strict-aliasing
+progs/timer_crash.c-CFLAGS := -fno-strict-aliasing
+
 ifneq ($(LLVM),)
 # Silence some warnings when compiled with clang
 CFLAGS += -Wno-unused-command-line-argument
-- 
2.30.2


