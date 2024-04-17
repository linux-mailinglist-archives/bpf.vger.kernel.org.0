Return-Path: <bpf+bounces-27044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CAD8A831E
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 14:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4CB21C2111D
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 12:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6EC13D53E;
	Wed, 17 Apr 2024 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gKFCBeZs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zDwlsq9x"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061A413D2A9
	for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 12:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713356710; cv=fail; b=ZhaTTomMMbeOKpb19GuxhQ/1whtp3v7D5lJnXZiesQdM7MmKckB3dt/7Ru+IK9bLc6vAryNucRpGFYNnGhckWFjxTeob+JXPQ91OnihsL+OdyGvAyYz4WK340W8bXXXLfaK5spBTj2KZX7GgqKfAXjTStirA+7Nuz/M9ja8WhbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713356710; c=relaxed/simple;
	bh=t9hvWIRk4QrBQzObM75b5AAbNGcp35KYhYuvqHm6G3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gpzTykSOjPjVQ0+yK6sByLlMZDwEfoTUx6TLK54iDYzNdleB01uHT7uEeK2OWCmBWdC2akYinyf0Y5btfZBjaXf+u+TG7dvSlFU9lTZrG43yiOR0tD51H5bG66oBsm23oZw3RAA3G6okBd/UwO0u5gubbHI5TF0vECPBXo3nliA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gKFCBeZs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zDwlsq9x; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43H8xpfp021226;
	Wed, 17 Apr 2024 12:25:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=3pcUD+mjEVXKWyVD+rHTzowUNSQwSSjAzzzoWUI0+34=;
 b=gKFCBeZsX5JMAbpMe8Kvrz8TUkGfRv8NPtq5u1IdjkVFlHewJbVTCQZd53Y6T/FVVdQA
 roCVtzhHOdiNoPgUwYiiJFL74oieaEONDE+YvARAud/TnVkJRO7+UHqAR0yHaqeb9oAy
 lTXMyWKYYa4p+/cpgbirQTRjZVpjcLq/6MC6is5TY4TcpVQzKV1kzvVxAoXxkVQBelPM
 tzKOdEssekXnTyaGcp939znUjIVHUmg2rNLPAnRLzxQSZy/QSsT4ZlR2ublX7k2bz+Rn
 /MT+YgpKCl5ZkmdsXonapYxKiCOOzDVgZ/+sR2ff8dknKGO930hU+Rx070HRo3F2d17Z NA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgycqq9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 12:25:05 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43HC9N2Q012472;
	Wed, 17 Apr 2024 12:25:05 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xgkwgs8b4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 12:25:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yj4MH0SPsQ2eBGUN14e6zNawOlyawMF74CYByjYjqPdyo58LZCIGIBOk3ptUc4KorFG6gPyB/Iu7EQUIL579eVmxtCI/CsY4Tp/n5l6H+oxLWt3sKq9NpA5UYeM0WYjZemgqPupCChZJU7DYua02dBafO8mN3UJr0i3WAGzld2v57ih2YooWbKLfQ8NLVM0ObAspXStnrauUNlW4oyr6GTFHtP57NW+dHhKU0OuvPznEB9stJcT5txZkW2So8QBSNOR85Fbmmr31090hOl7N9INihSBV56WswP7aknLNZDsr8f5QIFt6Cktx5ZMikwG2zfuOoF5Jvflk3Duu2+DiUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pcUD+mjEVXKWyVD+rHTzowUNSQwSSjAzzzoWUI0+34=;
 b=C3/E4glnyLX55bhtEFeByHrZo4fzDLzbY9Ycx/0y0qWxNxn4y+Jx0sE0i4gGhuIRRZ32I0ArzT+Ot+XEj5byOa5dPvc8aIK/yorhY30m9EW0DII6vE9wnlTkl+bBT8Rzfuk5MIDnAHRGxtyO7n7ApVwTAH7H8BqrVTR2cME4RZc/MLHJXw8cg9Dm3ls12ob0qhpLmF1ha7VBiQkLrXkXQsJvzqfs3icwPu9LBu3ckINQXpjNNFBM/ENohvJAgUzp4taA/rVaGyEKH3GCV81BHBq0pGViKnE96jsMlVu2Jz5Rl0dg/mBBCAuKcXgnU9zOtY4VuiuLhtSKNQBj3KSAGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pcUD+mjEVXKWyVD+rHTzowUNSQwSSjAzzzoWUI0+34=;
 b=zDwlsq9xp6QJj6rHdQZti3Ly7AHxzd1WPdgSG8LhIrGQ96sON/c95DUSemb9BTlTClQSchayV/r3ma4zVUzPO8ymNXb/bKk5tXgzLser96nzQX0R1wlQCsVdbET77jg/QeGzytzslvwK7PAi5obJcQCAhFfYeJlrjxxLTn0rN78=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by SA2PR10MB4745.namprd10.prod.outlook.com (2603:10b6:806:11b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Wed, 17 Apr
 2024 12:25:02 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7472.037; Wed, 17 Apr 2024
 12:25:02 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Faust <david.faust@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
Subject: [PATCH bpf-next v2 5/5] selftests/bpf: MUL range computation tests.
Date: Wed, 17 Apr 2024 13:23:41 +0100
Message-Id: <20240417122341.331524-6-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240417122341.331524-1-cupertino.miranda@oracle.com>
References: <20240417122341.331524-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::14)
 To MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|SA2PR10MB4745:EE_
X-MS-Office365-Filtering-Correlation-Id: 40e4c5ff-f4ca-4eef-153e-08dc5ed96806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	huSOipQVtBKloPtqxpnnZgdtKoVWzeZlajhyd6shfSg2JB8xwoN7l5UwNec2FvdccqMjGJtsAKYzLlMpqWACeJHExAPFbaCCRKh0Ia/RBn/sZxx10W7O/Le1virMLn9A6DAu8nZbi1QM7n5PiwvJmXNFSwNjd1/TcPL4Rl6HK62KTHJwkPGgzEBAoli7EZ/hYWfG78cGVnOWbP8d88pJJqD201B5oNPtnvEh9Ue9l6rPVaXZkVcfoUA1TpVlW0kPgn6kmU7D1AchZat1TOH3wXStrM17aI+bmymlVZE4AoAdm1OnkwIKGh4IA0TYoKooHaUhEVnuCh79EOnp+nmqJTMZvxUjc4tkwXHewe2Txj7JOZc7EDqiLimQXmycBpzlSl6gU1HAgBoblWXxlcQcuQA48whaE82KwpNAISDoM7aagpWXUAC1ZKpDsXxIUCKlRpgE952+KHMDX73Nb4W9YtBfAwyss59E0YwI6qTza3xDGb7SCDumcfV1tGS4o5ZmhS/Jsz0gYF9TDjQv360HNlZ/gyWutLNf7YN9FUsUXopIlKIeRNH74sf3AyYVdtNsgWkP/CWMnjkn4GaWd6QPXLwKqcNlcE7F6rThuTqrsXBvfZFXhxzLNO2r0ycGnGql9jkAqRtB8WzQUV/CQqri+HcRez5OBoSbIEXnPjjwALw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ejuWnPYA6aYYy8NwLMFAwou+FsM2Qer5ZPUNADyDgjvTglbgHJ/9OjoyKfP8?=
 =?us-ascii?Q?JXuoEHIKngARLXbU4FtNgA/uBdqAe2sf+NwyIE/jiV+r25mMuslisR83M2s1?=
 =?us-ascii?Q?j/wGN1V1CcoNNYGPphych9y4Itg4DYxQ4oz+StOcUuBAtFiDmAWddHkEhCxL?=
 =?us-ascii?Q?xiXLF5vHTuOLjGlyhzsSmy2x+KiUvgEud5jnCbYhXYlg9B92qE4dU1ac2B6S?=
 =?us-ascii?Q?JytYeVkvsOddwCHXlB/aKEo9iT7ae+h27drZfALErHfiniVwbW8wap73uhbf?=
 =?us-ascii?Q?iLcna+BlkkI1/PbCLuXPE+HMtPPkrqtgSb+mNbIZe9ybTjuvDd88alHx8xE8?=
 =?us-ascii?Q?z2hqrafTZ4bNfj0gXMaMBAVZf7XKZD6Gec7eXyV+AixxOA7e0YCqv1raLTSh?=
 =?us-ascii?Q?s/Iy3fy6Qki84xqllcYEscH1/vP+1Lntvxw6vUxRFrK6am12LdpnM0CWI32n?=
 =?us-ascii?Q?FAeF4bnuYeF6nDysY/4Fo+p7i57Xv2WIL+r61RPTluyRyPb7g104Wam/LDzb?=
 =?us-ascii?Q?PBF4osgpm9zmsrV++2vj9GOw9qdXVSQESLlIQMo6GTJqOmizFnnt5FhSWRWl?=
 =?us-ascii?Q?zeGpMDdVSI5OZ7fXVIrQDU2M+SdBKb5k9u6GxK3bn0z9WIsz2dpIO3reUjVL?=
 =?us-ascii?Q?r+IX5LLFx7LSll4c4/c8Nk2R62z2vJGBT33mxaDZJUftHEifWbEirkHAhr1E?=
 =?us-ascii?Q?sVQ0YWHJbriZYb6zX3dQydOQtkDxLeh2O37wa9sC10Cc+TbnFyMQ57I5BSp5?=
 =?us-ascii?Q?EnywBNa1hwboaUuYwyhu1EVEGJ64dXJOoHq/O8uHe1LbGqUlOxI5WsDwX+cw?=
 =?us-ascii?Q?+uPj+1jC9OO6nFSY1NFzDYqNw0x2rlrkF+hI4gl2iU/XJmKXf3K8D/zXmnBD?=
 =?us-ascii?Q?IqryPShTS6CUeNtiW0nyS2Whndj1OyHANof1AFvvfnmFLbctpHoM1RwUK2EN?=
 =?us-ascii?Q?tcBqZ9mnA6lYsPc8iiPPHQ6S0K3H9/GE/AF2Vki952YnI0UbgqK1GQwKJ/aN?=
 =?us-ascii?Q?jc6sWyhAYd+KsbqXkKt7kh88cplTut111asfqFg8At1eoHllZ5yTQWJYGCft?=
 =?us-ascii?Q?w4fD9Vx2AfLSj/ec337/+OD50V4H4jVlFfOiSomF31ueM/X3S0gzVoR9NDto?=
 =?us-ascii?Q?gZxA8biGxVPp1/J80lUBMWlv3XXz8ggykJSU5ubOzAkKF9mLJjM/JSjB6x17?=
 =?us-ascii?Q?nSEw9pGXOKsFVSqJ1hBxeJHQTqKK8k4oRLERPw5ydInKDvSFr96uqHXO19xd?=
 =?us-ascii?Q?sE21TtwNs6e7pT1qOFd2n9QvgSlzYWT2s06pK+O4xSiPWIzxp34F9pY0ilO8?=
 =?us-ascii?Q?g5tgqE7Eh9DvxZPb/Y4LdV6kvyUo8C+DD2s78D/87xfuiwkbC2+SaDJcKLH0?=
 =?us-ascii?Q?93+BlcnmhWopvFSrQfC/D+5KMvmxa7Qq1yI1rfSdQdqescSEoZlOcQaNjzOf?=
 =?us-ascii?Q?akp/enqxxRFdBN47AWywNifLN7a5ZAFu6aijGBRhUSLLXaZ9qmRfATen5ZOF?=
 =?us-ascii?Q?/0uUqLJyJ5lzk7cvEsKX5i9nOCjdriOggBb0trXZMkIVfwiA0FkbVh6kTu9A?=
 =?us-ascii?Q?X6t5auUsFjxvQxnaHXMChXq2cwS4wpU5xmN9rOk1kYnnvmsivFn1BO33tc+N?=
 =?us-ascii?Q?/XbsAnvqykuKVBqpooshtq0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fS8OO3iGCkqNXRg6ZSxGz6R90idtd4j6GsgL52q0dWKJMbJk9oELczzKWJSdUs2D23rND/9Aafsvd+gMCLDXjCYrwvIr35+QdWOIS6uJ5/pjqxA+yEuEVN0ruyHlOge+okMYU1qpj9C85Ll9FYSv/V2DpSPXR3452JWbyzct88IZsBjniSkU0T7a8gZ7D7jnt+RPFrWiPQNv/WWbPCK1wf832SIUyMfejdQy2upsATmE27zEfi3svKf+bu6nvjqR3ASWgEq+v58NOyb36Vv7Y0QuXd3U4xBNq4DTE51UtaUoiCK/tjYpjBADnhZ6ZchcjaihhYWD0baezqfoCQRIjNmLil3rI//tdzB/ufSMR7AoXtC1mOJGJoCyMgbZoCgaDoGHkOJNsJNbNPR9Y6Ffjlpx2JWAGsl2CatHm12g1+J0HJgeigYafPA613HfqvqtywM3cAG0a2wXYdZF0nYcaw0RTkqwG/sFTIIwPeCLoGLJnz7gMeZwZFWRD6QWt+L0Jbmj5CCRlXWhhVm5UtUe6mX/9/JMMKcmXT+XbqiKBzGDw5NCNpHYw8ko4IpQoY9WBHv+Lsrgk5nkMh9RlnyQfFfDbPj/hcLO7iRHQSi8q10=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e4c5ff-f4ca-4eef-153e-08dc5ed96806
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 12:25:02.6813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /61QoMKpUH5Gc34na7QslodmdzmNWwGh0wzxTFKtM3L4k8W7ap9ytZI7Nnk9B2IeTJU3fiadreSQnPhu7njYEmsvvGdFiYvcnM32uThAbKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4745
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_09,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404170085
X-Proofpoint-ORIG-GUID: mUgXK6zGxG_kDvFcDvkLvGuiG7mlvnQK
X-Proofpoint-GUID: mUgXK6zGxG_kDvFcDvkLvGuiG7mlvnQK

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Faust <david.faust@oracle.com>
Cc: Jose Marchesi <jose.marchesi@oracle.com
Cc: Elena Zannoni <elena.zannoni@oracle.com>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 99 +++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index e3c867d48664..719e247114f5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -949,6 +949,105 @@ l1_%=:	r0 = 0;						\
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("bounds check for reg32 <= 9, 3 mul (0,3)")
+__success __failure_unpriv
+__msg_unpriv("R0 min value is outside of the allowed memory range")
+__retval(0)
+__naked void reg32_3_mul_reg_01(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];                    \
+	r6 = r0;                                        \
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	w1 = 3;						\
+	r6 >>= 62;					\
+	w1 *= w6;					\
+	if w1 <= 9 goto l1_%=;				\
+	r0 = *(u64*)(r0 + 8);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b),
+	  __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds check for reg32 <= 9, (0,3) mul 3")
+__success __failure_unpriv
+__msg_unpriv("R0 min value is outside of the allowed memory range")
+__retval(0)
+__naked void reg32_13_mul_reg_3(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];                    \
+	r6 = r0;                                        \
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	w1 = 3;						\
+	r6 >>= 62;					\
+	w6 *= w1;					\
+	if w6 <= 9 goto l1_%=;				\
+	r0 = *(u64*)(r0 + 8);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b),
+	  __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds check for reg32 >= 6 && reg32 <= 15, (2,5) mul 3")
+__success __failure_unpriv
+__msg_unpriv("R0 min value is outside of the allowed memory range")
+__retval(0)
+__naked void reg32_25_mul_reg_3(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];                    \
+	r6 = r0;                                        \
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	w1 = 3;						\
+	r6 >>= 62;					\
+	r6 += 2;					\
+	w6 *= w1;					\
+	if w6 > 15 goto l1_%=;				\
+	if w6 < 6 goto l1_%=;				\
+	r0 = 0;						\
+	exit;						\
+l1_%=:  r0 = *(u64*)(r0 + 8);				\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b),
+	  __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 SEC("socket")
 __description("bounds checks after 32-bit truncation. test 1")
 __success __failure_unpriv __msg_unpriv("R0 leaks addr")
-- 
2.39.2


