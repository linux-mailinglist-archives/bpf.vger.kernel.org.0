Return-Path: <bpf+bounces-21299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9799584B270
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 11:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAE53B25AD3
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 10:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F8812E1E6;
	Tue,  6 Feb 2024 10:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iEpg6zpz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kSqVzCQv"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EE13D54A
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 10:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707215024; cv=fail; b=N+Z+JhN29RQdVzF6eCc76NlsglsCsWz5TIvChnbr08OrVnGyVfUVdx+E5j9LCFKtIVJY+5Pa5BL0TasK3vMN3NDwDXj7Aup3C2lSAOnMjxh4BhTJTVifqB6jbgCQcNbdgQxf+kDIJvfXQFvUoIBTpIhU/a6u1pG/wY6MhQwS2Ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707215024; c=relaxed/simple;
	bh=0WDuG07lFZcpU+0BVssjVZ4lBR/ATnLM00I6831poUU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PXX+0Ss5UB08/8dljADI03s7LdRq0pvt4Sv9zAejlVLC44pPJMwQiF6/CnmDH6vATvxNGjQD53+Rb7PKbKdNyyajIFwS2HwkPUys9yIC0hDVcLgX3ocFg4FU+0g/DdcH0CD3dsljptdDrb+iZmrif31SnpV0jSRs5r+fWiJTI8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iEpg6zpz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kSqVzCQv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 416AGb3u004826;
	Tue, 6 Feb 2024 10:23:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=1+AbwwR7V3+Oi/h2gvcLXHG0ccXkMSmwUKAyVvrygT8=;
 b=iEpg6zpzz6sjJYPfa9m8zCIwmmNR8sZZo+Z5wJsJDUDCbdcoatieGYiPICzGuzaMKfpg
 Kf8WSIg99cVoA/QK9ndaHjWi6LNsUdiLDdVKV8Ymr2Kc63V2RcohpNpT5O4bQvpYX3DQ
 s+9OtO7l5F5dJSvJRYBKp+I9yvW2z2PxBzKwxbi4+YgtnVPkfmtU4tUdvBflImPZ2qxe
 3qew6DqMkn6SbomeEB7VgXK8y8bz6kiyP1Lt2Oz5rB6VeWx53CtRpYXSe2gluunC32JI
 vNYyd71GjF02py20BtDDgpIdALVjnXxX0DcUU5aqm6mvRayB3ufC8au94ccPrqu09/Pd yA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1c93xj64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 10:23:39 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 416AKSt2038332;
	Tue, 6 Feb 2024 10:23:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx73ree-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 10:23:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bM+AAXwBSruED5z2Bir1UsUbId+H2fhfbmuVmsMvS+RUTX0n1aRdUSxAJoGoOUNREU77yX/wlp6BtspQ+YIfz4NxxXQUASV4JfCjuzH9/uWQ1E7U5mUWh6PNTUXLbjAxyhfgGkGEekQjHYoyYwiY6sX8kuwEPKIMPQT99hzfGbaan5ZIhyWocFHRI1iU5F4aV2U2DUrRALQrDye58IdoHih5CBvadZ+iEzNIkB9TDcGPltka23H0wv+GlUnhKBlL91LNbbrW3ZQHchvdEB+XgkYS68rwcQiE84/lMhOevrhWjXWBuspSoD5e3mU3ITi6mICk4rtfUpBvXBCxQ7/q5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+AbwwR7V3+Oi/h2gvcLXHG0ccXkMSmwUKAyVvrygT8=;
 b=EBXVRm1wS3H3u2YkPFmCFg5X0QshJOKpQBS8ONzAJLOFgVH/J+iJP9eP/dcCrciaV+zHmXTez5DayshsU3K0LcWNPfGO0fb1HbROfx+GS0IHVpZ+DLPcwXk40oOEGh82WSpiMcxYQYgVDvlNTX82yIC4d6lFBqlp1VcVooi/QTHLWRAYnfTgWenJJxl9HrhreYScR2UMaWRbPMBU7od7JUAJbdt8IIwG9jTbibhoX5w/4t8L83Jrzfklj2SA/kvUyc2xazaKH+1wW8oBh320wEVWW+wxQAn/QXAN9as8mAnA7LGpWrtkobyKi6N/06WKiTQ1EZZNKai93DfNIot4Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+AbwwR7V3+Oi/h2gvcLXHG0ccXkMSmwUKAyVvrygT8=;
 b=kSqVzCQv+WQro74eHETbwFVeI/TCeNNbZ2p0y2NMwn5BSBNAsxtLMwg9aoOJnxX+M00oV+57B8huFIZps3TExIcSVTat7KRMgKKGH5xvcPp23gksVRtG/lDyjDE5hFw++RgHIPxGFPFbq2l+aDAfZ12EW/tS615d4bJ43bxEp4E=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by SA1PR10MB7698.namprd10.prod.outlook.com (2603:10b6:806:38f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 10:23:36 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 10:23:36 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@meta.com>, Eduard Zingerman <eddyz87@gmail.com>,
        David Faust <david.faust@oracle.com>,
        Cupertino Miranda <cupertino.miranda@oracle.com>
Subject: [PATCH bpf-next V3] bpf: use -Wno-address-of-packed-member in some selftests
Date: Tue,  6 Feb 2024 11:23:30 +0100
Message-Id: <20240206102330.7113-1-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0048.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::15) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|SA1PR10MB7698:EE_
X-MS-Office365-Filtering-Correlation-Id: 299039bf-8563-4891-cd68-08dc26fdad9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	fYhGRzY4/QgJB1OXv8ZFMEzDscWbrI/rn+iN0KpHecQWmp5j+sso0Q8cJ7mN5NLL07DrJkD+AjVn4/1EIjibMWw0DXxC7Owz4ixTmG1fwiqg/ipwCCJ1RF/hw1I7btiOiN9OnTLo44MUFnyTMYuO0W4MTwCYbhjamDs1PJMZcrEYlkoGSZk++VUDOolCZ578peXNxjbeVVyygQT+MaB1id+368Xk6AnKkGVk3GQIf3JeBMfwO53p8VZLtOp27wWY/imMp2yrUEmDiiIxrvPGbGTiYRrayB1p3iRzti9y2P2LBFesoZYg9bTXtlyd7puZronsrLI6fNF7ztRNSnmp9EZUgHHYqWbHhtsjsgNbomTt9mfETV5Vv+GA4cfbpfnSchsUZKDutY8GxfcgsqQHuZ1cSC17atjxz8ohwglNpi23Hp69tsxhp3w12Zbghr92PFts2Ji8S+4csGGZ2dmlbjFSsLmoL40sPB6MGVN1CgpKI+NJpiXdBE22J1d9ejTBzhPZQ9eNxv5RU4qyjvhfyZaTktkd9n5Pu/8Mtav9L07QqLaEbgTQuI9212/Hdf9w
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(136003)(366004)(346002)(230922051799003)(230273577357003)(1800799012)(64100799003)(186009)(451199024)(2906002)(83380400001)(38100700002)(41300700001)(26005)(66556008)(316002)(6916009)(54906003)(66476007)(66946007)(86362001)(8676002)(4326008)(8936002)(2616005)(1076003)(6506007)(5660300002)(6512007)(6666004)(107886003)(36756003)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Aog/KLOaQpPZa7I2Vgy8NEs32je/sYdVTdZCU93pFRcIWzo1v9tnceS5a60k?=
 =?us-ascii?Q?uhzbhMwwGr8rFktluXhyrhpQEPgeV4A079CckuIEgdip/U2zppLBJ7O+EVq5?=
 =?us-ascii?Q?V72lZ90eckYwS2QTxj5l6DfuSnATYpHmi0O46YY/NCV88SMdHNfIFAZZNmc/?=
 =?us-ascii?Q?UOuoXGAGPc09PjJGjeuV1rb/L1o+5EpOyZoS0esw9aKQTDWxiybBaKxyh9kE?=
 =?us-ascii?Q?3ftq9B4JX7uhs6GZtCskFHQeIxU5b+Grf2aULJacbDHEE8F+cf2i7aJ1CH9r?=
 =?us-ascii?Q?qbdPoQrngY0xxtEXB9wRY7UR19UsNoHGSBew4vbgncllygyK/QMAta+2dpcU?=
 =?us-ascii?Q?pKH/Huh9ABX9P6RDZGkpBI9EC4KFbiOzWUiodwhsBCbFpsZR69+44cP4DzGR?=
 =?us-ascii?Q?YPLVDPI7YXNEJZXftX3E0IBAIe+QIYL2hZ/ceYYbnPT/XQHMdfWhm63lW96m?=
 =?us-ascii?Q?6a3JkNx+RgR/gs5PLymQrTgyeGA3uEv0PoRdQg7VRfvaE1SuK3RpDAXWuci/?=
 =?us-ascii?Q?8pfw6wBYUUhUYkEy2sg7o9Oimy/6sc/ikYQ5bTdNsf1xGKVhK9HBSRTDqpqM?=
 =?us-ascii?Q?t+6a7fn91FOx49sGT96b9A51BSPymDn3vpBiWyG3f0cP7toek0cnkRKXUYn8?=
 =?us-ascii?Q?Jvc0YU4TrLFMN6nkbN6CIN/nLXd/Geo1xM8ebUcH++cbHPjY9xHYL8+wpwyB?=
 =?us-ascii?Q?ZQj8JdttFgSStVYvwh0lDHpIFjv/Ek8THhjdg2rq6qyQEJzL6iZT4j3s3OJZ?=
 =?us-ascii?Q?1I6TxT7oylshp00HXaJLAdd0UfM3m1Y/I2CKiUIKrOqrI4khJcckZHU6g9cJ?=
 =?us-ascii?Q?OCp0sDLtkomf9kvzf3ajPdhfDKHVdl4pppgdBjdNMqX6peuVM34hlgh+tLJ1?=
 =?us-ascii?Q?wTx7x/PKyUqzxsKKkjJSHZfEeG9lyK0nKPTTdk/WKW0cXp2Gj2DCKkHMHHzV?=
 =?us-ascii?Q?Rf2QD1/jVZ+BQeUr4+KT2ldvzI8wqpKbZ/KpDBumGLPJi2hvkndGT3EMYP5l?=
 =?us-ascii?Q?BfuLkIl2xuOEhZbSpOm6om/s3JXmWNd+UQhoOxx9Ph6nrit/7rBZhLF86GJN?=
 =?us-ascii?Q?ew448CGYiq70HUrTptHesBr6uTePz4Qphf2GKDTdmZDuyO7mwRBcR0U5PKWG?=
 =?us-ascii?Q?RgoJnZ9dpQhhGkb3jpgQJ1GgPTb90Y3w6Y5b50E8jYFChEpSlUEgZ16B2K89?=
 =?us-ascii?Q?/GOUW7A2PE4dhd2SM8S1DToIVIxwqAl/HBIFDy/8nmSrIymgSc4glAEmdhI0?=
 =?us-ascii?Q?R6sFYl/RRXc6I/akaJX43pDijboQ3WxdukNevN/T0SaNDaopSLwFItOuw2/n?=
 =?us-ascii?Q?7QwDVdbh92ML0bad5L84Wwniha8N+JS7K0w1bHISZaMWtQEwFfCLVPIWNtOj?=
 =?us-ascii?Q?tF5zF2zXMYoh3paHCWmTYICie199JClwTJMH9mXBLOGBSKRrVvuYhUikrODK?=
 =?us-ascii?Q?lXziepHYNvmbmdeDCwO9ptxMqUFKBxxm1R1GL+JIR+qYoq+glFcPM9aTWz1G?=
 =?us-ascii?Q?fs5eOYTnoCG0V6xUOwGKpGzxMChi2wQdlqBHWtSqYBFaQG9ZcEc59EIJ2fkN?=
 =?us-ascii?Q?ry3pGW8Tv0T4J7CiI1waPAeJCv6CzJYHpeqcQ0uHcVUCAi+wmIu+Nk81j+a+?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gQaSz6Mzj8vm86VXW+ikTSorI2oYIRnIwFuly1prxg3mDzuJ3m2qbK4aYZ2CUsTw/ghy7SMmqirUQbxq7AV9JFosF8+c/EAO4OE3d/PqYgotEIEtOLwkLk7bn8r56rPOpP848D82Qs5qTtD4inPmvqEexK+mNFoqyF+GQQwAzXFtdZ0Wi58zwDViHel6sM6mKAvYUie1nhEE0TtlWGu5PYAI4m4fUmhrxdcUzqasfydjmN4g4BPtEjMPfiLUUC2wzg1qDC+xurkY2i0e/2hQ+N7W2UVMd0F/5JRI/lOeSVxNgVt3LLa8KrdfLftd2T/VSgOyqY1NBSmdHa/HTKnwmrRCKq+/hB6I0xMyQ7TrubvpCqkL38o0w4FMI4OG90L7QA1Ltykz+G6UQXOf+deANqw+Uh427WmX3xiyRBTcWFrB4g9MWvRrY+d4fLdC5CVk3mnY16LdD9DK51O3u/UytAjSXOsoajYrlAvsm08ao+7g6iRJTDPs0K0k8P2eWaK0v/DuOOs/8sCujcUDOy9YMbLIS1/03TS2MxakEYFkG0YYKnmjZzuOidM/rJ/gT6J4B8i6K/U649OkPj2W4I2MJXxtRSi1rfT43qLE5Y2szUs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 299039bf-8563-4891-cd68-08dc26fdad9a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 10:23:36.3431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQ8kmxhhus/fjGfVRFki0X/UkmC0JiYQyT4bUz/ot4k8tJLrFFc2aQ2ntQ7e6agP2wgneMIqh9/BZM490DjHo3+XMv1YgAFalKhQucalrx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7698
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_03,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402060073
X-Proofpoint-ORIG-GUID: aknJoitAoFNSwhxI2VGzpLOkr5-XCCfs
X-Proofpoint-GUID: aknJoitAoFNSwhxI2VGzpLOkr5-XCCfs

[Differences from V2:
- Remove conditionals in the source files pragmas, as the
  pragma is supported by both GCC and clang.]

Both GCC and clang implement the -Wno-address-of-packed-member
warning, which is enabled by -Wall, that warns about taking the
address of a packed struct field when it can lead to an "unaligned"
address.

This triggers the following errors (-Werror) when building three
particular BPF selftests with GCC:

  progs/test_cls_redirect.c
  986 |         if (ipv4_is_fragment((void *)&encap->ip)) {
  progs/test_cls_redirect_dynptr.c
  410 |         pkt_ipv4_checksum((void *)&encap_gre->ip);
  progs/test_cls_redirect.c
  521 |         pkt_ipv4_checksum((void *)&encap_gre->ip);
  progs/test_tc_tunnel.c
   232 |         set_ipv4_csum((void *)&h_outer.ip);

These warnings do not signal any real problem in the tests as far as I
can see.

This patch adds pragmas to these test files that inhibit the
-Waddress-of-packed-member warning.

Tested in bpf-next master.
No regressions.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Yonghong Song <yhs@meta.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: David Faust <david.faust@oracle.com>
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>
---
 tools/testing/selftests/bpf/progs/test_cls_redirect.c        | 2 ++
 tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c | 2 ++
 tools/testing/selftests/bpf/progs/test_tc_tunnel.c           | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect.c b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
index 66b304982245..bfc9179259d5 100644
--- a/tools/testing/selftests/bpf/progs/test_cls_redirect.c
+++ b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
@@ -22,6 +22,8 @@
 
 #include "test_cls_redirect.h"
 
+#pragma GCC diagnostic ignored "-Waddress-of-packed-member"
+
 #ifdef SUBPROGS
 #define INLINING __noinline
 #else
diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c b/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
index f41c81212ee9..da54c09e9a15 100644
--- a/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
+++ b/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
@@ -23,6 +23,8 @@
 #include "test_cls_redirect.h"
 #include "bpf_kfuncs.h"
 
+#pragma GCC diagnostic ignored "-Waddress-of-packed-member"
+
 #define offsetofend(TYPE, MEMBER) \
 	(offsetof(TYPE, MEMBER) + sizeof((((TYPE *)0)->MEMBER)))
 
diff --git a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
index e6e678aa9874..d8d7ab5e8e30 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
@@ -20,6 +20,8 @@
 #include <bpf/bpf_endian.h>
 #include <bpf/bpf_helpers.h>
 
+#pragma GCC diagnostic ignored "-Waddress-of-packed-member"
+
 static const int cfg_port = 8000;
 
 static const int cfg_udp_src = 20000;
-- 
2.30.2


