Return-Path: <bpf+bounces-20468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F0483EC98
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 11:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B525B22931
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 10:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C981EB20;
	Sat, 27 Jan 2024 10:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TYblH1l4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sA0rhuXy"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67FE7F
	for <bpf@vger.kernel.org>; Sat, 27 Jan 2024 10:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706350064; cv=fail; b=iaehoGxlTqEliofUo/BINinoUdRYFqZfuhh27jutRlwiAAyUof3TI0KN+5GJ3puc7I+Iqhq9WI+R7x7e5ap4TibSYcdmsWEQCfQkYjieVdg/1Aw1BMo0VzIQcsMsKz0Ci5EJDxYcf8PKBWa79Y58Qcbcajd54r8nja7YdTh2QIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706350064; c=relaxed/simple;
	bh=w2kFCWwehBgg4f44ZLWpglzHpJoNdmpEJRl5PoTArpg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PgmIu334dCd1nUM4BBoRknLzaP4ByR0tQwj9TA1UWzNFrswS3I8N3ODMty0hUmMDG1zmgPN58PVQLHl8FDpo2bTIzFqCgxLYqftfnQiq/CD8IK0HSbpChjXgOCEU5kpA4Dbcab86DzNDbRYPIWSZ+vtLZq81T3LkxB9ApTQoHo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TYblH1l4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sA0rhuXy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40R9RO5A007375;
	Sat, 27 Jan 2024 10:07:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=trgnTHzwJ4RUz31VGowrQHNk7XOOa4iNzyK4lqdvkLA=;
 b=TYblH1l4WY1kPQVBxtyeHBY7ytEatW9EDZQEFj7eUZ2EkRPEtWUgqyw8nSqEPnsjVFFM
 Qr4fBnx157vq73L2lt/TXcVgbYf9Sr1Qb1fYwTClVzryzCmxYsMpnfTBnR8lzPRESuXf
 GTyH0+kNUOiR7GW60al+rk7ieXOlyY4/4uJT9QIFkWaO7xKo17kg0TsdvSS8LH+9DJ7A
 cUOHsjk7Ih7pbyNkTOCAI307GNvbg1L3+jGgstazAxjTYj9MLGugee1+gSChwMIZP1Au
 qdl54s6NJei4yosB/TtEuHDtvilIVcEHH3d1oSS22D0YACamvH2pYevCZXcuukvvrqNi Yw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvre28fsb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jan 2024 10:07:32 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40R8qof5008556;
	Sat, 27 Jan 2024 10:07:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9a9ukt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jan 2024 10:07:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vu/gHTtcUoQ193630xbbYUvaQ5wO1WAostkfnLJw2pcX4f2pbkrVHJJw8TCwyvCdCsTgpYuxLYc5j6oamwqB3NvwTaPzO2zyyMHJRxHBUC9nvt8fxCCauyWSF82Enci/k9U3a96ITOdpXGaUZuTRYoGi7IOc2Ux+Dj4TYKQLt8QqXARn2tpoyTy3ynL83i6vzELVb6jrplfJpnmtzD2O4OGdSXlTarIKKVH4OwLoZsAXyB/lwYOoHPWqmHEkAASEC+Y11WXXfBUClURwWxzquG+QlEOhDlU9asQ7KxFBMmN9o/jcsjH7YpbOPlzuYkyFcnCFakgeYzcTasRopzOIbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trgnTHzwJ4RUz31VGowrQHNk7XOOa4iNzyK4lqdvkLA=;
 b=JpcQg2BYO57vRfH2vhsIJAPK7ovoPiqxWfSGUQWzTUu9XPCNFJa9BV6N2JKjj5zZU6n9ui3uvjwp70Hy5/rzMyC+5/QDu+CZpEVOOlq96qg1W8/LEJFAkfcopZEXuUoMCYUIo9K3G9F400OWPhSh1olm5PZrmi8d08bAiZ5BVQuzfu3HOEOUPSQc+n1IgVTrQ7AwKJTjo7Y5YuBN7YctEjhWB784Uu9YDugIy5sQiE5KaIllO8qNJnIExa77mhQi7FJCZRO9u+ent9uHgwo9HQkydmqodaIqxGSy6qFF+lGVMUD5UuF8k8ehaYRoamnDVjsIqWS9bp3jQ34cTtDg+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trgnTHzwJ4RUz31VGowrQHNk7XOOa4iNzyK4lqdvkLA=;
 b=sA0rhuXy9aTQzKPTQy30otzw/Rm6OQxMZcoUvzRZPM/knPwie1n3GqMoXbBX2i9mOMM+12vPYP95YE3Qt4b8phnYyNyLyk9PkVWjVfVLk/2fL4t1kK50WJk1XaEVxmpYjRJoNm9/c+z+ujlbr3+b/TK140uzwO1uEHe/hSjouSk=
Received: from BN8PR10MB3107.namprd10.prod.outlook.com (2603:10b6:408:c2::18)
 by SJ0PR10MB4685.namprd10.prod.outlook.com (2603:10b6:a03:2df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Sat, 27 Jan
 2024 10:07:28 +0000
Received: from BN8PR10MB3107.namprd10.prod.outlook.com
 ([fe80::f03f:cc66:b93:fe45]) by BN8PR10MB3107.namprd10.prod.outlook.com
 ([fe80::f03f:cc66:b93:fe45%7]) with mapi id 15.20.7228.029; Sat, 27 Jan 2024
 10:07:28 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Yonghong Song <yhs@meta.com>, Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>, david.faust@oracle.com,
        cupertino.miranda@oracle.com
Subject: [PATCH V2] bpf: use -Wno-error in certain tests when building with GCC
Date: Sat, 27 Jan 2024 11:07:02 +0100
Message-Id: <20240127100702.21549-1-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0266.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::11) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR10MB3107:EE_|SJ0PR10MB4685:EE_
X-MS-Office365-Filtering-Correlation-Id: fc96e103-0e52-4af8-e025-08dc1f1fbb88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	s1DPbXF+SELIvYiUFrPwiOOZxW6Ycpq4ipmcE3H1LRu/JnQ5yeIu2ijxFMl+PBwHbuVa4N9v5X31SZOzmh6nxRS1sb7KK69s2bJc3Nd6lWmvJSqMzmahItASGrUSyEMU6FQHYetZAgoGMddL/BNxIkFvsPDI/ZdNmcRG8TQ6i1JGK+/n8PALkTB+1HgcJ319SXBosfdOwjNhNTzz6iyqtqRBM0ALiuAcRAYKDi0Z/H0kWi6Ux5/JXzJm5yk3NZn9BHVAVI+lvjjb3fMm5touSHf3Wh+lNk2eiH2kc/MAEshRXai0qu2y3cLc62dJZUu/qkVEgffNgVmHOWAIt1gAmNnMzd4HnZgdoVOig+xvqWhBaW3kNLCC7hztqoH8yqj8rw3QI+NJSVO2uVL9BvD+SEajYIAN7p07OsdkJsAIreaoabZ9lItiuLnIVxannlfH9mtl5FBzfvkKu5t2D4cLMXktFsUtaO1xHv7+Gi1zL8d5vPtL3CDqFC+unM3CEbqIs/6hZJMMzZTWxO5RMx/ypbEBWjElOS6VJw1bI3vI84z2bsb9Nc1Y6ZjcHEfVb54l107rwdwQlWYUz9t2J3rk1bNPjy0kaFA5x+lS9qecHXvJw72PMlICpFZgQqX54uwX
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3107.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(136003)(346002)(230273577357003)(230922051799003)(230173577357003)(64100799003)(451199024)(1800799012)(186009)(66946007)(86362001)(316002)(6486002)(66556008)(54906003)(478600001)(66476007)(6916009)(38100700002)(26005)(6666004)(6506007)(107886003)(2616005)(1076003)(4326008)(8676002)(5660300002)(83380400001)(6512007)(8936002)(36756003)(2906002)(41300700001)(66899024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?XiaIOvfL/ojlItag8Zk2z38uZ3dG+t3aqW2nTICrLpH1QRGr75qEu/WQ++zs?=
 =?us-ascii?Q?o5lYTJiTc0r8808p/fwZ6a/Pcry9wALCyUgHrakh0cQXMJ6L3pDm51+6eQ9J?=
 =?us-ascii?Q?tuEA93/ZyUN/Fw2d7uhSDHWc3tlT5i9LhtrYWyEBaV9jtxvVpcStKBpXIlDg?=
 =?us-ascii?Q?z7T5v49DJUof7S1XtoayAlOeRD0HdzdFNs+RhhQMLVy8K8SKaW+v69FEnz42?=
 =?us-ascii?Q?KTS3pOdbGXYVjNtA1Slbo+U3jjXeW2H60Hz6d7+m9HSFO47oTxY1yld1XeBh?=
 =?us-ascii?Q?nItn/1oYJ+eTsPubbB62Bj8IVFJRe6Ba7RFK5nzbsqGqZj1HEd56QfnlLnxc?=
 =?us-ascii?Q?MK3Z9AzHcalOwSgZeu0x+kolpPdftU2xuVewSzaCkTEQpVTABktwB961vjPI?=
 =?us-ascii?Q?DW65WlnafM69GIYfLW4V/VwZAPx7BNIq7O0uLcxf8RMIKR03vT6vN5NhS0+K?=
 =?us-ascii?Q?T/CQUzZivTnrPAGXC9x2U34W067dQBDm/4pq+0URvLYzJxZzt0DmhnRZXt6z?=
 =?us-ascii?Q?qdFros4J4BnUldYOAtuX2TOGerj4T7dG+Nukz+J2jspsdTZfadHEU7lBnpwe?=
 =?us-ascii?Q?DgDqllujsSnD4k/i3DDGm36LWE+nM0Bfdz9WExApMt8bKw8eKtAyz7/Fa2y3?=
 =?us-ascii?Q?v/+rfOcPyoyXkAwDnrzubvW8xpjCG13pR2ISIK71L9ImIsqO4Fi9mAt/hSew?=
 =?us-ascii?Q?lYoXrAaTvq7zfNCaVCV777w1nk9bbSn43UdF1RTUF5t7xEZw1k3EKw5Zz+UX?=
 =?us-ascii?Q?z5ePbaMk09jdNPf1vvPz57jZICBkF0A+oU+o/QAFxtkSq2Awwt+R8VpA80MU?=
 =?us-ascii?Q?XS/sluI7A0CY7aclHb61Y5qXvkSbLE8/60SmPISKmCY/sH/x2ChUIkFPZEIT?=
 =?us-ascii?Q?QDxTSSiTK45qsIJzHgCpuy1f4mGFZ4tX9wl5lXpbN3/tAoBhX47KpiqjkPd8?=
 =?us-ascii?Q?NKGN2JDib3UaGpM+t+LU6C6mlHL0CvE5id8t9eI8xoVHAAH8tX/589e00n6C?=
 =?us-ascii?Q?hQfYA88gqEObKFCmOpd4ImV/7YV+qVgmKZ6FL5DG8yvXML/tc5q0AZuHKnEn?=
 =?us-ascii?Q?pANOEI8v26dV7KAwvwRfeI4adeynVVGWF8A1XgU2qNiyjo3EcAfvu4BZRz2R?=
 =?us-ascii?Q?NpYVIYyTe3v2A8TGrOJxgZnmelpDfDNsA7g86hheDHqCMYlZIcH+IaZG+gmT?=
 =?us-ascii?Q?YcntmRoJbYzxDYCbeKRplN3vRFLN4FRJBa7JsLRXn6hhOG5+XfbPkmSAI9B7?=
 =?us-ascii?Q?LuDSqCsW/y+M1pDIP8sFBO3AnvsnVFiWCF8kGwZmcW0PlRfj7ykem2mzQUGH?=
 =?us-ascii?Q?n06/nF2l/NC0zvydAr/pmmtek7Re4j2fgrsybQlXg7v/V1GVqaett2OJ8xUH?=
 =?us-ascii?Q?WVm38jc/ZsUfotPj4YKpcQzaI5EgnoUlX0XZ/eCLdXn8bThTuaDnW2Yg9MKp?=
 =?us-ascii?Q?Q3FWrtOo3E2mpv/lKSkp6gjPEk3HyP62IHXixhQYhCf7FfdcHyudFaOhOhit?=
 =?us-ascii?Q?VGKrgyMbMJbvYUkUVl86rLxBZe/mxeQrOP3rRrpFE/wB06/9iV7mA+9WoVfb?=
 =?us-ascii?Q?yT//pVpIduboYjCX/IwjSEey3XtXLy5S0Gk5UJ3TT95meHITTakDNWtKpzAz?=
 =?us-ascii?Q?Ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vkNTZNH3a+gFwWzsCo4R8nZFCdEYzWwe0WY1C02YUmAcAbZSstkApoNvbMPs+MGUA1AJnGDEK5Wkq9nKoinZ6b73YinzL3ecRShm5BwahMjms3M4ldcN7FliYxFkPtOwjFZibqi7u836GEGVxJIl4UM884Kf2TiwZPH0GWmZzbPD7wdQyotUjk8LvhLX7mdIx0PaO0WxW0Uuvh8+oOF0HPXPnQli4OvkG1pYd7gZklnDwc9P+l4HBPPoNTePJJwf46/qPs1ltDqsA9dsovMgFuEdYb7lzoY8azULNgQwfdImwuFNMIFCbWkW5Jm5uxvXhO7OCNfKPUl4rcUjuZ/m53fE9SpRHNHFb5ou37mf6hzQQbs/AcE7/DmkJNrmLGd/LS2Kw9+GmNmqcKdELetdAQBQ3aAL/5ad+mqVd4mtNDQ7zhuUilPxzh4Ibh0YByvfQyuJJSBqe9tAg4W3bQgP3dxlOqtRKB6vbJWegb6FFEsbczE7qYm9LoGv0+NjJ19A8PgClKVzk8K/fMWB7jEPoEBTuD2tS39r5MjEcbG1LX9rxr4kH5xXEwt13plDpQ7xZ4dFPhp1lntGrpzaDGr22ttwbFBs4gLC0wk/iljOlDw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc96e103-0e52-4af8-e025-08dc1f1fbb88
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2024 10:07:28.5285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qYqOu2NK8jwL5Mg5rbFtM635VuM25h4UAE8APOpSQtthx3HXdCzR5G7E8294GNBJ2nnm3fQO7Nfe0SR5C18sjo17uPS0RDTPrLNnUsaQTog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4685
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401270073
X-Proofpoint-GUID: vi30IwdFBnoJFWADp93-_M_S-mzunwsA
X-Proofpoint-ORIG-GUID: vi30IwdFBnoJFWADp93-_M_S-mzunwsA

[Changes from V1:
- Build rule simplified, as there is no need to use $(if ...)]

Certain BPF selftests contain code that, albeit being legal C, trigger
warnings in GCC that cannot be disabled.  This is the case for example
for the tests

  progs/btf_dump_test_case_bitfields.c
  progs/btf_dump_test_case_namespacing.c
  progs/btf_dump_test_case_packing.c
  progs/btf_dump_test_case_padding.c
  progs/btf_dump_test_case_syntax.c

which contain struct type declarations inside function parameter
lists.  This is problematic, because:

- The BPF selftests are built with -Werror.

- The Clang and GCC compilers sometimes differ when it comes to handle
  warnings.  in the handling of warnings.  One compiler may emit
  warnings for code that the other compiles compiles silently, and one
  compiler may offer the possibility to disable certain warnings, while
  the other doesn't.

In order to overcome this problem, this patch modifies the
tools/testing/selftests/bpf/Makefile in order to:

1. Enable the possibility of specifing per-source-file extra CFLAGS.
   This is done by defining a make variable like:

   <source-filename>-CFLAGS := <whateverflags>

   And then modifying the proper Make rule in order to use these flags
   when compiling <source-filename>.

2. Use the mechanism above to add -Wno-error to CFLAGS for the
   following selftests:

   progs/btf_dump_test_case_bitfields.c
   progs/btf_dump_test_case_namespacing.c
   progs/btf_dump_test_case_packing.c
   progs/btf_dump_test_case_padding.c
   progs/btf_dump_test_case_syntax.c

   Note the corresponding -CFLAGS variables for these files are
   defined only if the selftests are being built with GCC.

Note that, while compiler pragmas can generally be used to disable
particular warnings per file, this 1) is only possible for warning
that actually can be disabled in the command line, i.e. that have
-Wno-FOO options, and 2) doesn't apply to -Wno-error.

Tested in bpf-next master branch.
No regressions.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: Yonghong Song <yhs@meta.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: david.faust@oracle.com
Cc: cupertino.miranda@oracle.com
---
 tools/testing/selftests/bpf/Makefile | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index fd15017ed3b1..1a3654bcb5dd 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -64,6 +64,15 @@ TEST_INST_SUBDIRS := no_alu32
 ifneq ($(BPF_GCC),)
 TEST_GEN_PROGS += test_progs-bpf_gcc
 TEST_INST_SUBDIRS += bpf_gcc
+
+# The following tests contain C code that, although technically legal,
+# triggers GCC warnings that cannot be disabled: declaration of
+# anonymous struct types in function parameter lists.
+progs/btf_dump_test_case_bitfields.c-CFLAGS := -Wno-error
+progs/btf_dump_test_case_namespacing.c-CFLAGS := -Wno-error
+progs/btf_dump_test_case_packing.c-CFLAGS := -Wno-error
+progs/btf_dump_test_case_padding.c-CFLAGS := -Wno-error
+progs/btf_dump_test_case_syntax.c-CFLAGS := -Wno-error
 endif
 
 ifneq ($(CLANG_CPUV4),)
@@ -504,7 +513,8 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:				\
 		     $(wildcard $(BPFDIR)/*.bpf.h)			\
 		     | $(TRUNNER_OUTPUT) $$(BPFOBJ)
 	$$(call $(TRUNNER_BPF_BUILD_RULE),$$<,$$@,			\
-					  $(TRUNNER_BPF_CFLAGS))
+					  $(TRUNNER_BPF_CFLAGS)         \
+					  $$($$<-CFLAGS))
 
 $(TRUNNER_BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
 	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
-- 
2.30.2


