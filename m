Return-Path: <bpf+bounces-21398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF03B84C859
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 11:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1D572871C1
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 10:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EEF24B2F;
	Wed,  7 Feb 2024 10:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Nwc39FfQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tDYuKW6u"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A03B25108
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 10:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707300788; cv=fail; b=Q6g5fV0u+nMkR9oUHi5AjrDhDxQxQN822gfL1C4d5C2ibUAetNjuNlPhDNgC9MnU2zJEmzGqc81NGCV5FdhTsAF/LcSvvex0dyrx/ZrcISHp3Jja8S5EnA7Os3yooBKZ2267/bBO+GNleASJOpgOdI/juX8AsZ81B1OZrzWkUrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707300788; c=relaxed/simple;
	bh=YkkeN1LnzsvNRSr9PQp+N9r2GCH18ABd5LLH6LrDMew=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=qAe4Jc/WCRBtkT/y4wilvE++8k2E4EPZ9CdTY2HuMo/7V/wMMTfPlb7GI29D4yuJKZaP6DCbz1juwOpYkEvhwINbpP2ElhcoafEg4MJ8ttiNGjJM34tpcHrbze1T9xOoCJZOELb/14QHELVKjTnKuqOmzZFJ1vH5EEDXnrl3aDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Nwc39FfQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tDYuKW6u; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4179wtF1001702;
	Wed, 7 Feb 2024 10:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=/kR7eS4Te9hs7CHVmOmtD8VKkVQbp++qPF5ecKmtuDc=;
 b=Nwc39FfQawtmv+D+naTprulTI/kmnOBKYzJRRuvVbCZcRu0v7jTs9XcL/d6DSFzgiCHR
 0680WQmZ1hC9AHInWY7PiGHFc+J3Rr38u5FSKaLKvKZpMGKXYpScKmIYlbtOMUVfDMKT
 tGn5HbLYNCDLtaN/LM8euSY6NwZpxO4HhnsUa7GGG1/bMyPk7qZ4pxOjeWub1ahgej4F
 6S/GvyxqxEKONtoW/vC4k0cZYZd8b3rFmjOq+2uBKSWvu61weHtR6N5bYIvVllTyg2k0
 HZgrxk99nidR/zw0MjqN5pvEVJgRUCAQcE8AmAKPRxyKzPGMFO53BidJMjABQ4zKumHc wQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1c941f51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Feb 2024 10:13:02 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4178bg1D007105;
	Wed, 7 Feb 2024 10:13:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx928a4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Feb 2024 10:13:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKD/PQkNYI0yxEgseOdG45LFEtxrAA4gVlxAeJ9LPCKjjHKNpyPZsJ6+RCy/G9QkcfWkpt1B//GA6Dny9M7I8lqUqiPJnLOvuIfhhzl0FBk78MLIwUPrAikvfq8N0T9+4Js4vWxlhjAOsw/MzyNPRIkQGnxygmi4hK4omn9y11QjQCO0bMrcpL4fSwUCYa+AJbQEBLix7zSCkTf8PuHHUMxGZvlB2NmlllShsnFzNu39sXycrDdhTr9P7yjFqn0mZ2E0dlr+mWtO4Rgk7JZxcM9Bezbx8NsuaAhvvKvpcYIMgPAJGn0rSfI8q3BRP1DKCpJUe+BFINwekBOdu89t6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kR7eS4Te9hs7CHVmOmtD8VKkVQbp++qPF5ecKmtuDc=;
 b=nFcgmhJ432wuK4+Bvcopyx9k568nf5OU9C9sm2SlmjzskMq7Ho3C/rd9j3dUdi/GCCFD6yhuJv3gpsg/6Q5B1qqW3OjszzwaeFEO+BRqbC6V8Yuhb/iLHnxFzomTXIZos1pDrIDv5PV9VUS+cXxJ+9ANawr8pEyinnwF24juXRWyLTSxwlLuy4dk5Ds7OjJmEwTJfeUnpRwzXhOYGvBYKaiLtqxjNDUULgxO2R1T1KlEqCtR6EfLH/Xgr1ismkr/HaILO/As3Wmr9jBOCeLDYR+EZ5EOhlbhk4DFI+h87+7NyDhgBa7RKFzIengCqCvhpsanHbFGE9kx+WQPlXyeBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kR7eS4Te9hs7CHVmOmtD8VKkVQbp++qPF5ecKmtuDc=;
 b=tDYuKW6u26kY8lVs0MKKLZw9l1Y8Uf5JyglSPoTC75MK8MlX8R9NbG1cTrgyM2JRvvnryqN88ufhf28jjS9hL7ygT4bqeoFYGAo+aQmgNLiu9HA2KFfXKUK+NQA0vnzIIztaHWZ0f9EGDNFl3Cgqcngnsm21a4+XsjVRFHOGRXw=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by BLAPR10MB4884.namprd10.prod.outlook.com (2603:10b6:208:30c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 10:12:59 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 10:12:59 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Yonghong Song <yhs@meta.com>, Eduard Zingerman <eddyz87@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        david.faust@oracle.com, cupertino.miranda@oracle.com
Subject: [PATCH bpf-next] bpf: abstract loop unrolling pragmas in BPF selftests
Date: Wed,  7 Feb 2024 11:12:53 +0100
Message-Id: <20240207101253.11420-1-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0686.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::18) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|BLAPR10MB4884:EE_
X-MS-Office365-Filtering-Correlation-Id: 255bef8e-0cbd-479c-0a94-08dc27c55c15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6XhA57Nzdfer8rMvDE0NxxtcoWFHrJadynN/4X0yV5gbLD7e+EnzfcbZu/DhpL7oSeu6da+keNz/Lvx1blFH2i190vLlRQW5i+C7PQj+mZeFpJ5l/Bk/zYn+hmd9g8EyI/Zu/FGX3qoxspqiARQgDOy5N8b9pEVBZErl5L8QHuSI7tQCj6M91u6hXxaVm7T6La927nvwHEhP4qP4OSY1E4nLp/PJQplj02doA9TdDCp4cXeP+uLhDqsOsIkq/PS7m1VQK4ta1Yugsep1W09UkeLEZEj1nHujPRB2XwcV1nPq9gkmy9mF/mwt4undY9JCLoEQkMsdeG7m0Uj1pyvG+nsdAGge9/yDC8yOhCSLPss+hud3+B0LEwP6whsbi9MhxSsHw8gE40raBbVTzQ5ldi4pNoEFmjtWfPIOOgv3NTpDRixT8nFXRk5Twy/jQIWhWzHDKDLJNhfucw02lIW9zqU27wdI8Zpsc+0YFDzD1moyDm6PMdL9P6/fL3AbE82SNVhhA74cKxq8PVhSAyccg2/uJKbOJeiUlK5NYfcNCZs1fsHeZzVp28UgXQnbYOT6
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(376002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(1076003)(2616005)(26005)(86362001)(107886003)(41300700001)(6486002)(478600001)(5660300002)(2906002)(66946007)(66476007)(316002)(6916009)(54906003)(4326008)(8936002)(36756003)(6512007)(8676002)(66556008)(30864003)(6506007)(6666004)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?C0gTl3Vu6xwptnZNe+cGsanrZ+0SlKHLw+g6AEiuUwJoFlwp4a07gjIKV/6q?=
 =?us-ascii?Q?dY+XOZ90Flo/+XDw+1QnpyRCvIJCHYbDp7o5ZwgfmjAcywvDaBDApJDNfX6B?=
 =?us-ascii?Q?habxBLDzpZ8hUJlGcxP/GtcXMUvoAAy+eVX5xejpWbFXqLj/dsgoGzsuZVd8?=
 =?us-ascii?Q?fALh5ZC/u8g1jsB1WCQGoAMVgDB4xa7lb7/xSzXmnjD0edUZrXwkLOUlNGxD?=
 =?us-ascii?Q?DKNkMeuSrPJN5YHfSJ+oHnLM1x/WDh9a1z3vtvahByT6evXi11SHhw3bancw?=
 =?us-ascii?Q?MbxxyjUXZMWp6qhRAklrgMSJ2bd941DGhOq5H6cJfwLlQ+/HaqdrHOCXAEj0?=
 =?us-ascii?Q?essmlOerm1Kks15M19Mi14IYW48h7nHh9sApMRDYo3TqjSbZRPIew+Svn5z7?=
 =?us-ascii?Q?U4QL1MleXaO1nvGakjEkWQOnF/PCg1Rf5KpFOykKeGfrfUKLkPuX+IVjOIZZ?=
 =?us-ascii?Q?Xb+pwdJWZIk6HM+CqMO9ClNSVQq9tuMlkXcQ5cNq2EEyfkjCsozAQOsGta3J?=
 =?us-ascii?Q?T32+twZIrSjx2HGm/ty4Vuq+iFCoLTpRIeGRyonrl97PSV5EnAtYkBtqv/7G?=
 =?us-ascii?Q?8naGNnU23TkPzM7QQyW0OY999CX5RbpvF0B1yLlOolhv0nxGHBMyeN2fWN5L?=
 =?us-ascii?Q?fzfXAPs+cTp9W6IsFOtQFB3nLHbvpZcICx5hftSgg+sYs383ShWyvNnCwTTL?=
 =?us-ascii?Q?iHklGMeBWBsCrDPGoS3NZtt8v5yXsUZAJqLxQh/+olqcAT72yBFoFIxTPEkc?=
 =?us-ascii?Q?kiwoSMIQxvOBNA5Zmi10iMU4o2242A61GikdEomVTHaHmd7yLnWcVNBX6bGe?=
 =?us-ascii?Q?UsDlk9Fd98Hs1dEDKu3Tuqil1WlQsQA/IcIV5AcNAjJ5v23a2NVacnW4F0Vs?=
 =?us-ascii?Q?conNOVUK8O+93xrIKw5otjlQISGKaiMcSYqdALJMwGm8aVtD7rPx5o8atmya?=
 =?us-ascii?Q?aOqy3bIBQELPFTgG4Qprq59Rx4/zJxQq11JRrZG5BkX2xZLljIy52PpjzF5G?=
 =?us-ascii?Q?uRXLISPXz/SQyFz3aiE5IXU4+iFFPp8CZ5rCrimoD3B93+jo0Xyv3fw711MO?=
 =?us-ascii?Q?6vKUSm2+pbxvnKCKP/Z4jdIP7bMioQqr5rNRWaUrahxrh3ayQNKQnImLFgLI?=
 =?us-ascii?Q?yu/se/sVIcXgujSqqg8q+MqNhNiTSi4YhYkSMJgH/Ld5Q15GrP46gHYHN8hN?=
 =?us-ascii?Q?G6gWwG7NkEeIIBwIiI20zC2Pillbfpy76ba3Hy5rbTTIqVpujjAJLoQLrKcW?=
 =?us-ascii?Q?Y+Mji01ya23GNnGYAwpgt7Y7zINj3fZjfvIEAzNP0k0lIZ7ktMgmpdM41u55?=
 =?us-ascii?Q?r3NllFk5qI9pRZovfwzhZu2cA8y8s6fBZuAb2VaC7N4Hwo+AmaZrEHLA2gkZ?=
 =?us-ascii?Q?GMtItXxS3i4vZkD2qXurX7IfOSmHqx9rCtet0PoCom8vkQCJbxDZL6iYKOS5?=
 =?us-ascii?Q?EHJ/sMXSmGXLgBA0Pyp4jefYMQrq0ZGmcnvEgHSHbjiLUD/AFrzQptwFDgZ6?=
 =?us-ascii?Q?oB7tV2X6RIMNLF8nzcP76AfhatJSM8UziIChqSdM+VgX2/svSMZ6OgKsvsX/?=
 =?us-ascii?Q?5SPzhTUtK93Bb6IAqin/8HQ7E4ti/qJOmuCo6idlHv3qtyicBajz/Qp7+Mvz?=
 =?us-ascii?Q?+w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DaNMBkpkc6STcCRvFPp714gGcrXpc4GbYvMHWGyc8AOERKHfz92AvtLQZOl+2O5Kq4vu6vhtZoUjFpkLqKDhsHl9pBHsbJJbMqfQcotcdXLOdlkN5dizBWQd6Z9jlvvQzj1zBv8c0NXZyH56apZQP+S2yfj5LIWAq7u149YbjeMdz5mJJhZIBsJewB5UYtJns8rk6dbMyb8fs5vPOMP2jeSXyTnjHzI5IkknZgguDhqBpHX5gOPD+o8axj11MnXMzXtOXi4ELVDvkU1RQvg13e9/ST83jmS/6XkhtoHym16JfCHmag3EX6NX7sPdE7/pfT135C3678eowC6H9jksGw59VQq9ohHMp3+bO8/qJd/imIvMMoUEB4zFB6SsDMHA//vE09P0GEt4EdplJ2NljnJWnjlrsyXSG6J00Fl7VS+j4KqDRGs+fXVMb/uUnCCOR64aak/R6HiTkvHqWFQ5EehCxGZ4BaPYVM8rGbQJ/GA0hqOEL3ufObPo3GNRokJdlPoWK/wwHBzcsPC0lR9D9/F5qGkRQN3/tAijrg9osc4bPCoNpOv7FtSWhOL4Lli85uFYOfkqMk4u7VX+AHBc4QFRu7sd3FZTn6vU7IK3r6k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 255bef8e-0cbd-479c-0a94-08dc27c55c15
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 10:12:59.0121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Ek1B1iQrwh+R6zNZ/cloaPIZzjiebcbaucYwOg96s/RpD/1mQhi/spRyEEsytoN0OuE7vAaYcKIrY0443VU1MyGFoRXz22bl9zz9jhQn58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4884
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=865 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402070075
X-Proofpoint-ORIG-GUID: nRtCH-LlDMWDHs3FoJLwNTyOplcg5UAm
X-Proofpoint-GUID: nRtCH-LlDMWDHs3FoJLwNTyOplcg5UAm

Some BPF tests use loop unrolling compiler pragmas that are clang
specific and not supported by GCC.  These pragmas, along with their
GCC equivalences are:

  #pragma clang loop unroll_count(N)
  #pragma GCC unroll N

  #pragma clang loop unroll(full)
  #pragma GCC unroll 65534

  #pragma clang loop unroll(disable)
  #pragma GCC unroll 1

  #pragma unroll [aka #pragma clang loop unroll(enable)]
  There is no GCC equivalence, and it seems to me that this clang
  pragma may be only useful when building without -funroll-loops to
  enable the optimization in particular loops.  In GCC -funroll-loops
  is enabled with -O2 and higher.  If this is also true in clang,
  perhaps these pragmas in selftests are redundant?

This patch adds a new header progs/bpf_compiler.h that defines the
following macros, which correspond to each pair of compiler-specific
pragmas above:

  __pragma_loop_unroll_count(N)
  __pragma_loop_unroll_full
  __pragma_loop_no_unroll
  __pragma_loop_unroll

The selftests using loop unrolling pragmas are then changed to include
the header and use these macros in place of the explicit pragmas.

Tested in bpf-next master.
No regressions.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: Yonghong Song <yhs@meta.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: david.faust@oracle.com
Cc: cupertino.miranda@oracle.com
---
 .../selftests/bpf/progs/bpf_compiler.h        | 33 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/iters.c     |  5 +--
 tools/testing/selftests/bpf/progs/loop4.c     |  4 ++-
 .../selftests/bpf/progs/profiler.inc.h        | 17 +++++-----
 tools/testing/selftests/bpf/progs/pyperf.h    |  7 ++--
 .../testing/selftests/bpf/progs/strobemeta.h  | 18 +++++-----
 .../selftests/bpf/progs/test_cls_redirect.c   |  5 +--
 .../selftests/bpf/progs/test_lwt_seg6local.c  |  6 ++--
 .../selftests/bpf/progs/test_seg6_loop.c      |  4 ++-
 .../selftests/bpf/progs/test_skb_ctx.c        |  4 ++-
 .../selftests/bpf/progs/test_sysctl_loop1.c   |  6 ++--
 .../selftests/bpf/progs/test_sysctl_loop2.c   |  6 ++--
 .../selftests/bpf/progs/test_sysctl_prog.c    |  6 ++--
 .../selftests/bpf/progs/test_tc_tunnel.c      |  4 ++-
 tools/testing/selftests/bpf/progs/test_xdp.c  |  3 +-
 .../selftests/bpf/progs/test_xdp_loop.c       |  3 +-
 .../selftests/bpf/progs/test_xdp_noinline.c   |  5 +--
 .../selftests/bpf/progs/xdp_synproxy_kern.c   |  6 ++--
 .../testing/selftests/bpf/progs/xdping_kern.c |  3 +-
 19 files changed, 103 insertions(+), 42 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_compiler.h

diff --git a/tools/testing/selftests/bpf/progs/bpf_compiler.h b/tools/testing/selftests/bpf/progs/bpf_compiler.h
new file mode 100644
index 000000000000..a7c343dc82e6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_compiler.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __BPF_COMPILER_H__
+#define __BPF_COMPILER_H__
+
+#define DO_PRAGMA_(X) _Pragma(#X)
+
+#if __clang__
+#define __pragma_loop_unroll DO_PRAGMA_(clang loop unroll(enable))
+#else
+/* In GCC -funroll-loops, which is enabled with -O2, should have the
+   same impact than the loop-unroll-enable pragma above.  */
+#define __pragma_loop_unroll
+#endif
+
+#if __clang__
+#define __pragma_loop_unroll_count(N) DO_PRAGMA_(clang loop unroll_count(N))
+#else
+#define __pragma_loop_unroll_count(N) DO_PRAGMA_(GCC unroll N)
+#endif
+
+#if __clang__
+#define __pragma_loop_unroll_full DO_PRAGMA_(clang loop unroll(full))
+#else
+#define __pragma_loop_unroll_full DO_PRAGMA_(GCC unroll 65534)
+#endif
+
+#if __clang__
+#define __pragma_loop_no_unroll DO_PRAGMA_(clang loop unroll(disable))
+#else
+#define __pragma_loop_no_unroll DO_PRAGMA_(GCC unroll 1)
+#endif
+
+#endif
diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index 225f02dd66d0..3db416606f2f 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -5,6 +5,7 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
+#include "bpf_compiler.h"
 
 #define ARRAY_SIZE(x) (int)(sizeof(x) / sizeof((x)[0]))
 
@@ -183,7 +184,7 @@ int iter_pragma_unroll_loop(const void *ctx)
 	MY_PID_GUARD();
 
 	bpf_iter_num_new(&it, 0, 2);
-#pragma nounroll
+	__pragma_loop_no_unroll
 	for (i = 0; i < 3; i++) {
 		v = bpf_iter_num_next(&it);
 		bpf_printk("ITER_BASIC: E3 VAL: i=%d v=%d", i, v ? *v : -1);
@@ -238,7 +239,7 @@ int iter_multiple_sequential_loops(const void *ctx)
 	bpf_iter_num_destroy(&it);
 
 	bpf_iter_num_new(&it, 0, 2);
-#pragma nounroll
+	__pragma_loop_no_unroll
 	for (i = 0; i < 3; i++) {
 		v = bpf_iter_num_next(&it);
 		bpf_printk("ITER_BASIC: E3 VAL: i=%d v=%d", i, v ? *v : -1);
diff --git a/tools/testing/selftests/bpf/progs/loop4.c b/tools/testing/selftests/bpf/progs/loop4.c
index b35337926d66..0de0357f57cc 100644
--- a/tools/testing/selftests/bpf/progs/loop4.c
+++ b/tools/testing/selftests/bpf/progs/loop4.c
@@ -3,6 +3,8 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 
+#include "bpf_compiler.h"
+
 char _license[] SEC("license") = "GPL";
 
 SEC("socket")
@@ -10,7 +12,7 @@ int combinations(volatile struct __sk_buff* skb)
 {
 	int ret = 0, i;
 
-#pragma nounroll
+	__pragma_loop_no_unroll
 	for (i = 0; i < 20; i++)
 		if (skb->len)
 			ret |= 1 << i;
diff --git a/tools/testing/selftests/bpf/progs/profiler.inc.h b/tools/testing/selftests/bpf/progs/profiler.inc.h
index de3b6e4e4d0a..6957d9f2805e 100644
--- a/tools/testing/selftests/bpf/progs/profiler.inc.h
+++ b/tools/testing/selftests/bpf/progs/profiler.inc.h
@@ -8,6 +8,7 @@
 #include "profiler.h"
 #include "err.h"
 #include "bpf_experimental.h"
+#include "bpf_compiler.h"
 
 #ifndef NULL
 #define NULL 0
@@ -169,7 +170,7 @@ static INLINE int get_var_spid_index(struct var_kill_data_arr_t* arr_struct,
 				     int spid)
 {
 #ifdef UNROLL
-#pragma unroll
+	__pragma_loop_unroll
 #endif
 	for (int i = 0; i < ARRAY_SIZE(arr_struct->array); i++)
 		if (arr_struct->array[i].meta.pid == spid)
@@ -185,7 +186,7 @@ static INLINE void populate_ancestors(struct task_struct* task,
 
 	ancestors_data->num_ancestors = 0;
 #ifdef UNROLL
-#pragma unroll
+	__pragma_loop_unroll
 #endif
 	for (num_ancestors = 0; num_ancestors < MAX_ANCESTORS; num_ancestors++) {
 		parent = BPF_CORE_READ(parent, real_parent);
@@ -212,7 +213,7 @@ static INLINE void* read_full_cgroup_path(struct kernfs_node* cgroup_node,
 	size_t filepart_length;
 
 #ifdef UNROLL
-#pragma unroll
+	__pragma_loop_unroll
 #endif
 	for (int i = 0; i < MAX_CGROUPS_PATH_DEPTH; i++) {
 		filepart_length =
@@ -261,7 +262,7 @@ static INLINE void* populate_cgroup_info(struct cgroup_data_t* cgroup_data,
 		int cgrp_id = bpf_core_enum_value(enum cgroup_subsys_id___local,
 						  pids_cgrp_id___local);
 #ifdef UNROLL
-#pragma unroll
+		__pragma_loop_unroll
 #endif
 		for (int i = 0; i < CGROUP_SUBSYS_COUNT; i++) {
 			struct cgroup_subsys_state* subsys =
@@ -402,7 +403,7 @@ static INLINE int trace_var_sys_kill(void* ctx, int tpid, int sig)
 			if (kill_data == NULL)
 				return 0;
 #ifdef UNROLL
-#pragma unroll
+			__pragma_loop_unroll
 #endif
 			for (int i = 0; i < ARRAY_SIZE(arr_struct->array); i++)
 				if (arr_struct->array[i].meta.pid == 0) {
@@ -482,7 +483,7 @@ read_absolute_file_path_from_dentry(struct dentry* filp_dentry, void* payload)
 	struct dentry* parent_dentry;
 
 #ifdef UNROLL
-#pragma unroll
+	__pragma_loop_unroll
 #endif
 	for (int i = 0; i < MAX_PATH_DEPTH; i++) {
 		filepart_length =
@@ -508,7 +509,7 @@ is_ancestor_in_allowed_inodes(struct dentry* filp_dentry)
 {
 	struct dentry* parent_dentry;
 #ifdef UNROLL
-#pragma unroll
+	__pragma_loop_unroll
 #endif
 	for (int i = 0; i < MAX_PATH_DEPTH; i++) {
 		u64 dir_ino = BPF_CORE_READ(filp_dentry, d_inode, i_ino);
@@ -629,7 +630,7 @@ int raw_tracepoint__sched_process_exit(void* ctx)
 	struct kernfs_node* proc_kernfs = BPF_CORE_READ(task, cgroups, dfl_cgrp, kn);
 
 #ifdef UNROLL
-#pragma unroll
+	__pragma_loop_unroll
 #endif
 	for (int i = 0; i < ARRAY_SIZE(arr_struct->array); i++) {
 		struct var_kill_data_t* past_kill_data = &arr_struct->array[i];
diff --git a/tools/testing/selftests/bpf/progs/pyperf.h b/tools/testing/selftests/bpf/progs/pyperf.h
index 026d573ce179..86484f07e1d1 100644
--- a/tools/testing/selftests/bpf/progs/pyperf.h
+++ b/tools/testing/selftests/bpf/progs/pyperf.h
@@ -8,6 +8,7 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
+#include "bpf_compiler.h"
 
 #define FUNCTION_NAME_LEN 64
 #define FILE_NAME_LEN 128
@@ -298,11 +299,11 @@ int __on_event(struct bpf_raw_tracepoint_args *ctx)
 #if defined(USE_ITER)
 /* no for loop, no unrolling */
 #elif defined(NO_UNROLL)
-#pragma clang loop unroll(disable)
+	__pragma_loop_no_unroll
 #elif defined(UNROLL_COUNT)
-#pragma clang loop unroll_count(UNROLL_COUNT)
+	__pragma_loop_unroll_count(UNROLL_COUNT)
 #else
-#pragma clang loop unroll(full)
+	__pragma_loop_unroll_full
 #endif /* NO_UNROLL */
 		/* Unwind python stack */
 #ifdef USE_ITER
diff --git a/tools/testing/selftests/bpf/progs/strobemeta.h b/tools/testing/selftests/bpf/progs/strobemeta.h
index 40df2cc26eaf..f74459eead26 100644
--- a/tools/testing/selftests/bpf/progs/strobemeta.h
+++ b/tools/testing/selftests/bpf/progs/strobemeta.h
@@ -10,6 +10,8 @@
 #include <linux/types.h>
 #include <bpf/bpf_helpers.h>
 
+#include "bpf_compiler.h"
+
 typedef uint32_t pid_t;
 struct task_struct {};
 
@@ -419,9 +421,9 @@ static __always_inline uint64_t read_map_var(struct strobemeta_cfg *cfg,
 	}
 
 #ifdef NO_UNROLL
-#pragma clang loop unroll(disable)
+	__pragma_loop_no_unroll
 #else
-#pragma unroll
+	__pragma_loop_unroll
 #endif
 	for (int i = 0; i < STROBE_MAX_MAP_ENTRIES; ++i) {
 		if (i >= map.cnt)
@@ -560,25 +562,25 @@ static void *read_strobe_meta(struct task_struct *task,
 		payload_off = sizeof(data->payload);
 #else
 #ifdef NO_UNROLL
-#pragma clang loop unroll(disable)
+	__pragma_loop_no_unroll
 #else
-#pragma unroll
+	__pragma_loop_unroll
 #endif /* NO_UNROLL */
 	for (int i = 0; i < STROBE_MAX_INTS; ++i) {
 		read_int_var(cfg, i, tls_base, &value, data);
 	}
 #ifdef NO_UNROLL
-#pragma clang loop unroll(disable)
+	__pragma_loop_no_unroll
 #else
-#pragma unroll
+	__pragma_loop_unroll
 #endif /* NO_UNROLL */
 	for (int i = 0; i < STROBE_MAX_STRS; ++i) {
 		payload_off = read_str_var(cfg, i, tls_base, &value, data, payload_off);
 	}
 #ifdef NO_UNROLL
-#pragma clang loop unroll(disable)
+	__pragma_loop_no_unroll
 #else
-#pragma unroll
+	__pragma_loop_unroll
 #endif /* NO_UNROLL */
 	for (int i = 0; i < STROBE_MAX_MAPS; ++i) {
 		payload_off = read_map_var(cfg, i, tls_base, &value, data, payload_off);
diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect.c b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
index 66b304982245..1f7e82649347 100644
--- a/tools/testing/selftests/bpf/progs/test_cls_redirect.c
+++ b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
@@ -20,6 +20,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 
+#include "bpf_compiler.h"
 #include "test_cls_redirect.h"
 
 #ifdef SUBPROGS
@@ -267,7 +268,7 @@ static INLINING void pkt_ipv4_checksum(struct iphdr *iph)
 	uint32_t acc = 0;
 	uint16_t *ipw = (uint16_t *)iph;
 
-#pragma clang loop unroll(full)
+	__pragma_loop_unroll_full
 	for (size_t i = 0; i < sizeof(struct iphdr) / 2; i++) {
 		acc += ipw[i];
 	}
@@ -294,7 +295,7 @@ bool pkt_skip_ipv6_extension_headers(buf_t *pkt,
 	};
 	*is_fragment = false;
 
-#pragma clang loop unroll(full)
+	__pragma_loop_unroll_full
 	for (int i = 0; i < 6; i++) {
 		switch (exthdr.next) {
 		case IPPROTO_FRAGMENT:
diff --git a/tools/testing/selftests/bpf/progs/test_lwt_seg6local.c b/tools/testing/selftests/bpf/progs/test_lwt_seg6local.c
index 48ff2b2ad5e7..fed66f36adb6 100644
--- a/tools/testing/selftests/bpf/progs/test_lwt_seg6local.c
+++ b/tools/testing/selftests/bpf/progs/test_lwt_seg6local.c
@@ -6,6 +6,8 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 
+#include "bpf_compiler.h"
+
 /* Packet parsing state machine helpers. */
 #define cursor_advance(_cursor, _len) \
 	({ void *_tmp = _cursor; _cursor += _len; _tmp; })
@@ -131,7 +133,7 @@ int is_valid_tlv_boundary(struct __sk_buff *skb, struct ip6_srh_t *srh,
 	*pad_off = 0;
 
 	// we can only go as far as ~10 TLVs due to the BPF max stack size
-	#pragma clang loop unroll(full)
+	__pragma_loop_unroll_full
 	for (int i = 0; i < 10; i++) {
 		struct sr6_tlv_t tlv;
 
@@ -302,7 +304,7 @@ int __encap_srh(struct __sk_buff *skb)
 
 	seg = (struct ip6_addr_t *)((char *)srh + sizeof(*srh));
 
-	#pragma clang loop unroll(full)
+	__pragma_loop_unroll_full
 	for (unsigned long long lo = 0; lo < 4; lo++) {
 		seg->lo = bpf_cpu_to_be64(4 - lo);
 		seg->hi = bpf_cpu_to_be64(hi);
diff --git a/tools/testing/selftests/bpf/progs/test_seg6_loop.c b/tools/testing/selftests/bpf/progs/test_seg6_loop.c
index a7278f064368..5059050f74f6 100644
--- a/tools/testing/selftests/bpf/progs/test_seg6_loop.c
+++ b/tools/testing/selftests/bpf/progs/test_seg6_loop.c
@@ -6,6 +6,8 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 
+#include "bpf_compiler.h"
+
 /* Packet parsing state machine helpers. */
 #define cursor_advance(_cursor, _len) \
 	({ void *_tmp = _cursor; _cursor += _len; _tmp; })
@@ -134,7 +136,7 @@ static __always_inline int is_valid_tlv_boundary(struct __sk_buff *skb,
 	// we can only go as far as ~10 TLVs due to the BPF max stack size
 	// workaround: define induction variable "i" as "long" instead
 	// of "int" to prevent alu32 sub-register spilling.
-	#pragma clang loop unroll(disable)
+	__pragma_loop_no_unroll
 	for (long i = 0; i < 100; i++) {
 		struct sr6_tlv_t tlv;
 
diff --git a/tools/testing/selftests/bpf/progs/test_skb_ctx.c b/tools/testing/selftests/bpf/progs/test_skb_ctx.c
index c482110cfc95..a724a70c6700 100644
--- a/tools/testing/selftests/bpf/progs/test_skb_ctx.c
+++ b/tools/testing/selftests/bpf/progs/test_skb_ctx.c
@@ -3,12 +3,14 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 
+#include "bpf_compiler.h"
+
 char _license[] SEC("license") = "GPL";
 
 SEC("tc")
 int process(struct __sk_buff *skb)
 {
-	#pragma clang loop unroll(full)
+	__pragma_loop_unroll_full
 	for (int i = 0; i < 5; i++) {
 		if (skb->cb[i] != i + 1)
 			return 1;
diff --git a/tools/testing/selftests/bpf/progs/test_sysctl_loop1.c b/tools/testing/selftests/bpf/progs/test_sysctl_loop1.c
index 553a282d816a..7f74077d6622 100644
--- a/tools/testing/selftests/bpf/progs/test_sysctl_loop1.c
+++ b/tools/testing/selftests/bpf/progs/test_sysctl_loop1.c
@@ -9,6 +9,8 @@
 
 #include <bpf/bpf_helpers.h>
 
+#include "bpf_compiler.h"
+
 #ifndef ARRAY_SIZE
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 #endif
@@ -30,7 +32,7 @@ static __always_inline int is_tcp_mem(struct bpf_sysctl *ctx)
 	if (ret < 0 || ret != sizeof(tcp_mem_name) - 1)
 		return 0;
 
-#pragma clang loop unroll(disable)
+	__pragma_loop_no_unroll
 	for (i = 0; i < sizeof(tcp_mem_name); ++i)
 		if (name[i] != tcp_mem_name[i])
 			return 0;
@@ -59,7 +61,7 @@ int sysctl_tcp_mem(struct bpf_sysctl *ctx)
 	if (ret < 0 || ret >= MAX_VALUE_STR_LEN)
 		return 0;
 
-#pragma clang loop unroll(disable)
+	__pragma_loop_no_unroll
 	for (i = 0; i < ARRAY_SIZE(tcp_mem); ++i) {
 		ret = bpf_strtoul(value + off, MAX_ULONG_STR_LEN, 0,
 				  tcp_mem + i);
diff --git a/tools/testing/selftests/bpf/progs/test_sysctl_loop2.c b/tools/testing/selftests/bpf/progs/test_sysctl_loop2.c
index 2b64bc563a12..68a75436e8af 100644
--- a/tools/testing/selftests/bpf/progs/test_sysctl_loop2.c
+++ b/tools/testing/selftests/bpf/progs/test_sysctl_loop2.c
@@ -9,6 +9,8 @@
 
 #include <bpf/bpf_helpers.h>
 
+#include "bpf_compiler.h"
+
 #ifndef ARRAY_SIZE
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 #endif
@@ -30,7 +32,7 @@ static __attribute__((noinline)) int is_tcp_mem(struct bpf_sysctl *ctx)
 	if (ret < 0 || ret != sizeof(tcp_mem_name) - 1)
 		return 0;
 
-#pragma clang loop unroll(disable)
+	__pragma_loop_no_unroll
 	for (i = 0; i < sizeof(tcp_mem_name); ++i)
 		if (name[i] != tcp_mem_name[i])
 			return 0;
@@ -57,7 +59,7 @@ int sysctl_tcp_mem(struct bpf_sysctl *ctx)
 	if (ret < 0 || ret >= MAX_VALUE_STR_LEN)
 		return 0;
 
-#pragma clang loop unroll(disable)
+	__pragma_loop_no_unroll
 	for (i = 0; i < ARRAY_SIZE(tcp_mem); ++i) {
 		ret = bpf_strtoul(value + off, MAX_ULONG_STR_LEN, 0,
 				  tcp_mem + i);
diff --git a/tools/testing/selftests/bpf/progs/test_sysctl_prog.c b/tools/testing/selftests/bpf/progs/test_sysctl_prog.c
index 5489823c83fc..efc3c61f7852 100644
--- a/tools/testing/selftests/bpf/progs/test_sysctl_prog.c
+++ b/tools/testing/selftests/bpf/progs/test_sysctl_prog.c
@@ -9,6 +9,8 @@
 
 #include <bpf/bpf_helpers.h>
 
+#include "bpf_compiler.h"
+
 /* Max supported length of a string with unsigned long in base 10 (pow2 - 1). */
 #define MAX_ULONG_STR_LEN 0xF
 
@@ -31,7 +33,7 @@ static __always_inline int is_tcp_mem(struct bpf_sysctl *ctx)
 	if (ret < 0 || ret != sizeof(tcp_mem_name) - 1)
 		return 0;
 
-#pragma clang loop unroll(full)
+	__pragma_loop_unroll_full
 	for (i = 0; i < sizeof(tcp_mem_name); ++i)
 		if (name[i] != tcp_mem_name[i])
 			return 0;
@@ -57,7 +59,7 @@ int sysctl_tcp_mem(struct bpf_sysctl *ctx)
 	if (ret < 0 || ret >= MAX_VALUE_STR_LEN)
 		return 0;
 
-#pragma clang loop unroll(full)
+	__pragma_loop_unroll_full
 	for (i = 0; i < ARRAY_SIZE(tcp_mem); ++i) {
 		ret = bpf_strtoul(value + off, MAX_ULONG_STR_LEN, 0,
 				  tcp_mem + i);
diff --git a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
index e6e678aa9874..ff5009e3c278 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
@@ -20,6 +20,8 @@
 #include <bpf/bpf_endian.h>
 #include <bpf/bpf_helpers.h>
 
+#include "bpf_compiler.h"
+
 static const int cfg_port = 8000;
 
 static const int cfg_udp_src = 20000;
@@ -81,7 +83,7 @@ static __always_inline void set_ipv4_csum(struct iphdr *iph)
 
 	iph->check = 0;
 
-#pragma clang loop unroll(full)
+	__pragma_loop_unroll_full
 	for (i = 0, csum = 0; i < sizeof(*iph) >> 1; i++)
 		csum += *iph16++;
 
diff --git a/tools/testing/selftests/bpf/progs/test_xdp.c b/tools/testing/selftests/bpf/progs/test_xdp.c
index d7a9a74b7245..8caf58be5818 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp.c
@@ -19,6 +19,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 #include "test_iptunnel_common.h"
+#include "bpf_compiler.h"
 
 struct {
 	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
@@ -137,7 +138,7 @@ static __always_inline int handle_ipv4(struct xdp_md *xdp)
 	iph->ttl = 8;
 
 	next_iph = (__u16 *)iph;
-#pragma clang loop unroll(full)
+	__pragma_loop_unroll_full
 	for (i = 0; i < sizeof(*iph) >> 1; i++)
 		csum += *next_iph++;
 
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_loop.c b/tools/testing/selftests/bpf/progs/test_xdp_loop.c
index c98fb44156f0..93267a68825b 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_loop.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_loop.c
@@ -15,6 +15,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 #include "test_iptunnel_common.h"
+#include "bpf_compiler.h"
 
 struct {
 	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
@@ -133,7 +134,7 @@ static __always_inline int handle_ipv4(struct xdp_md *xdp)
 	iph->ttl = 8;
 
 	next_iph = (__u16 *)iph;
-#pragma clang loop unroll(disable)
+	__pragma_loop_no_unroll
 	for (i = 0; i < sizeof(*iph) >> 1; i++)
 		csum += *next_iph++;
 
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_noinline.c b/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
index 42c8f6ded0e4..5c7e4758a0ca 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
@@ -15,6 +15,7 @@
 #include <linux/udp.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
+#include "bpf_compiler.h"
 
 static __always_inline __u32 rol32(__u32 word, unsigned int shift)
 {
@@ -362,7 +363,7 @@ bool encap_v4(struct xdp_md *xdp, struct ctl_value *cval,
 	iph->ttl = 4;
 
 	next_iph_u16 = (__u16 *) iph;
-#pragma clang loop unroll(full)
+	__pragma_loop_unroll_full
 	for (int i = 0; i < sizeof(struct iphdr) >> 1; i++)
 		csum += *next_iph_u16++;
 	iph->check = ~((csum & 0xffff) + (csum >> 16));
@@ -409,7 +410,7 @@ int send_icmp_reply(void *data, void *data_end)
 	iph->saddr = tmp_addr;
 	iph->check = 0;
 	next_iph_u16 = (__u16 *) iph;
-#pragma clang loop unroll(full)
+	__pragma_loop_unroll_full
 	for (int i = 0; i < sizeof(struct iphdr) >> 1; i++)
 		csum += *next_iph_u16++;
 	iph->check = ~((csum & 0xffff) + (csum >> 16));
diff --git a/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c b/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
index 518329c666e9..7ea9785738b5 100644
--- a/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
+++ b/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
@@ -7,6 +7,8 @@
 #include <bpf/bpf_endian.h>
 #include <asm/errno.h>
 
+#include "bpf_compiler.h"
+
 #define TC_ACT_OK 0
 #define TC_ACT_SHOT 2
 
@@ -151,11 +153,11 @@ static __always_inline __u16 csum_ipv6_magic(const struct in6_addr *saddr,
 	__u64 sum = csum;
 	int i;
 
-#pragma unroll
+	__pragma_loop_unroll
 	for (i = 0; i < 4; i++)
 		sum += (__u32)saddr->in6_u.u6_addr32[i];
 
-#pragma unroll
+	__pragma_loop_unroll
 	for (i = 0; i < 4; i++)
 		sum += (__u32)daddr->in6_u.u6_addr32[i];
 
diff --git a/tools/testing/selftests/bpf/progs/xdping_kern.c b/tools/testing/selftests/bpf/progs/xdping_kern.c
index 54cf1765118b..44e2b0ef23ae 100644
--- a/tools/testing/selftests/bpf/progs/xdping_kern.c
+++ b/tools/testing/selftests/bpf/progs/xdping_kern.c
@@ -15,6 +15,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 
+#include "bpf_compiler.h"
 #include "xdping.h"
 
 struct {
@@ -116,7 +117,7 @@ int xdping_client(struct xdp_md *ctx)
 		return XDP_PASS;
 
 	if (pinginfo->start) {
-#pragma clang loop unroll(full)
+		__pragma_loop_unroll_full
 		for (i = 0; i < XDPING_MAX_COUNT; i++) {
 			if (pinginfo->times[i] == 0)
 				break;
-- 
2.30.2


