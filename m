Return-Path: <bpf+bounces-32305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1081E90B344
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 17:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126F71C22EBC
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 15:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC0813E40C;
	Mon, 17 Jun 2024 14:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YExncLq4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MfaFSeTr"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C722B9A0
	for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718633730; cv=fail; b=eBvqTNOIJIRFLeOPf0vSu2GpSiHVIN5TUjTcc/8amW/QugjsRpdGO0fqXZbIh4edtXHQbHYW0u5RiZCOaZVKVTxHbuqk5QM8MLlHWFg+Vh3FqdBwbQVMwAyucvoEx/MfvkYWZvclZmy0pUJgiVL4U/2TcX7NQHfYFRUQPZ06vVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718633730; c=relaxed/simple;
	bh=6JS8KQsNgfBrpwBZ0EIbkI7nsJRGBjxK35lSdkj2EK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W/KauxhT7TQCZ5Fy4yZ7PfhrfVeUMnL3LEGSLB+N+1eL8sdLhfPe+KvsxVEWtvYpaG1Xj5tzziETeixL+M8ukkzmX4hJMbkpafLV2vQup0MOrW87jrQSlYOuleAfiJzV3Z75psi/UJBLklpDiklDDouf98HTU0rrqMVI2GyJ66g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YExncLq4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MfaFSeTr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HEBRqJ009662;
	Mon, 17 Jun 2024 14:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=Q0P04Vnj+jgXO32obfo1oetMp3/7+ZkupJlJOjAFyYc=; b=
	YExncLq4z1Pcrl9GhZODKWdjqdDB+sJJjrSaUBhmTFsq1NTk2Pnu3QKtWzEr4JTd
	1QXOG77L3JavXz3Cqcm/0oqig4DrkPsHGod8hmP8fDJu0PbN/eM8kxhiWB9KErLT
	HgBz8u4f071RmGEiOOlLHpjpBAa/zDvfKm0lU3Bba0PApBQDB9qi4SoaAc6Owxkj
	sASoyCVceCmbyZn2gUnIPsers/JxUJrEttdFl5YhRhtOEs0zepOUGp1pOcuwT7a6
	Kpn2NC6b7n5u4GWySEx8jI7TFpqLI7doOSDps20VsI3qdbZFln2C4QsCFthzYNY9
	44RWuGOqcDpcq5pI+at6sA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys1cc2sq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 14:15:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45HE1ZCB029141;
	Mon, 17 Jun 2024 14:15:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1d6m64a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 14:15:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzvOvYex7eUqMV/MeouCAQrhE/VGqKT6dSdJm0fLivcX1ocrHNkSeOy0DIwAvVhfXl6P3W2DDMHtZwu2Bq+TTQzrfabkhA7Rlg47kJdXClM12+VBQo/UZFXFg3RU+NXHB9tc0rizbHLPPipL18WnZNAk2HvAS4062tej6R/RgpltWQFb+hdDxI/KmmqhyhiIL1FI0im/h5AVeF1r2E5nAV2NQgfhHBOVoOZNx3vF+ICDqtzEd4Jfx9DPryIeMSDWA83Ztn5JFrtwriDrnh//MrpBTybpcqXzmALiQ0SyjUF+F4SM2OTTpZzH/agDK+C1pw53mqXWtU69B1DfPdM6sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0P04Vnj+jgXO32obfo1oetMp3/7+ZkupJlJOjAFyYc=;
 b=BmrjRrD9WWeT3NlJJOIj3mb4l/FaRX+LX9px8gsFVPNcTmJtuHLGcZr4bBWaE8loKipQf9GbL+2qtpD7V0fdM271vK48Xihh6mCulj1rUfGLtW9A0iAPDWOuyS7Qcg81bFgxiV7r4MW1FWxvG9HNyxeBFnkmo0KHKovhMLQcwLbJ41XmRmi7ebDPKKt6bkxuITsr/b+Ise08CHQtew6cf9mslO5XIpeOtceYrFRVbB7NPzLL8AoHUxWPdSr0UugkdahoC3N2FQLyCy2t9MilNLGZDgSn2Ln3sDwbCPAeMTl+qt2YLAds7l3lqzLLh8w/PHv210l13dDSpPkghtkk/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0P04Vnj+jgXO32obfo1oetMp3/7+ZkupJlJOjAFyYc=;
 b=MfaFSeTr6BWlYYDGrIQLddfL5nN+Qt7MZOOf4ZcSPmIqARKoQhfAUXa+MswjpAYk7L3FYo0gE8fwpqqxTN/shunO2HrYpoBZLrsnAxrDuOA//VJ/lid28vaVYt3Fo0rqQa+6xTquj1Y+WXBdipIaxSJQgUdra/SnL+MMABwQ/x4=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by LV3PR10MB7772.namprd10.prod.outlook.com (2603:10b6:408:1b4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 17 Jun
 2024 14:15:16 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb%7]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 14:15:16 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Eduard Zingerman <eddyz87@gmail.com>, jose.marchesi@oracle.com,
        david.faust@oracle.com, Yonghong Song <yonghong.song@linux.dev>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next v5 2/2] selftests/bpf: Match tests against regular expression
Date: Mon, 17 Jun 2024 15:14:58 +0100
Message-Id: <20240617141458.471620-3-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240617141458.471620-1-cupertino.miranda@oracle.com>
References: <20240617141458.471620-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0468.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::24) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|LV3PR10MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: 04c75e60-8b0d-42fa-4be1-08dc8ed7e93a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?nK4xzZRejyR3iMmxY+qTBAOBhTZ1lHFWCM+vF7SsN7lk2DKgquE9xMeKbjU+?=
 =?us-ascii?Q?1m+5Rj2ivzlOsBrPF3G5+vdtpq1FN5RBGClshW14eAYY7ryUC8D+zU1Q3d9v?=
 =?us-ascii?Q?xv2wbEnyx5a4yge6Vouu41p8bNkeWko0UTLKuO709IrYDaakFTFUHFUD8gz1?=
 =?us-ascii?Q?FDvRW+7XczM6nTj2l7yZfFT7eYQ3owHxyJObXJhMLq40l+Grs+FFR3q1WpB2?=
 =?us-ascii?Q?DJT3KPxAgZB3E6Mene5bLtJ79KQmtf/mlAS81g+tr3GzWV2bQpuxEyFobwNY?=
 =?us-ascii?Q?iVbyE79pdhCgQFWHfabhIG+FqYlZ3Edw8OUdGE8jVRznZVjeKSNOAV8m8Td4?=
 =?us-ascii?Q?HfMuODxeEVZAYswB1e1jJLoRI7iPv8TPVK/dmkshAL7+i0fMMrErQf5d4YOU?=
 =?us-ascii?Q?iM48ulObRJE5075yyusMh84zdLW49r+KmoBUfHrdloPpI1TEeI3n2n+G1kVv?=
 =?us-ascii?Q?IF67q7NDKpiejkpN3DlF0z6ScmaOrWHVvs6RoHls5xc9EKZ9iRR62snBVPHD?=
 =?us-ascii?Q?3RTbF4WbNDMT22x24JlPge/GIP9fMLSbb9H8Vk4DYQwh8LeBxH0bF1vvMrUW?=
 =?us-ascii?Q?52xNRrNpV58eqGFAKomdm4gZtxa8uYNmK8eLjbjj0woIzTXEz9IXoGgOba7o?=
 =?us-ascii?Q?u7NDd11slEIqb99y3N9FTvSST2TcPkqp9CkyRbJyyOzCudKJc4vAF4geutdY?=
 =?us-ascii?Q?wP6o7uMeedmVNQPZgGNRZHitsnxznz0Q/BxArBHWCBGBnJ6pgbHvKsoOSLVM?=
 =?us-ascii?Q?9U9eESKfqvP4GaK1dz++1NHu1qPZBncvMg50ysgpFjGK0reFQXrIwsPzI9ej?=
 =?us-ascii?Q?j1wZQbb3ltE8Gl986pRdQpkw+DmpcdACGSVklDMrGHVMkTLrSkEwXSi714Az?=
 =?us-ascii?Q?j8+tsQG45u7OamPb9/mDgv2MvyKf+ScSo4X8ygnzRNVUS9zy5WSMoxqB7OfC?=
 =?us-ascii?Q?hHfiffd6acuM5cQ5I19CFMsyRbt6doZkLC/qb0RkaNRx/Y1+miZwD6LitT9S?=
 =?us-ascii?Q?CKeBL6/IPZHUJtqh+/RPS6ZHDBfBbhpGfK4qTGmXrsPrU+kWRXNak63lAP03?=
 =?us-ascii?Q?/1n/eF1ioR+TyVjcQAd6QZX+y0Avi++mie9FcM/IK84vREcBG/xAM0xWOiBb?=
 =?us-ascii?Q?C6Ao4g5bC7oIC0KbHGdxgR0celbCNCrCQqWQLsPfhkVwDW95JNGdqRIcOqtY?=
 =?us-ascii?Q?6JXyek8m6JwliKjSUPzM2kq0xzImBLyCgNwkvHMA/rLISOBD8uk6PpJtGWxk?=
 =?us-ascii?Q?1+RKBXjPeKmiJbKO9ELq+tXTFhOSlvkPXTcCE3UgUYTL5fP80thG5uxHXlre?=
 =?us-ascii?Q?lrFd/TiUClFR84OXpVt4dt9m?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?KTqJ5veDQ0iXZwTBUlCwRXH2aleqVjr51VOkVqGq3DbCKbZ15YAtm8s/nQ9u?=
 =?us-ascii?Q?WN1gZjdBlUSBYZoGqRRAaC4JZ0+Uwx/7mPbwvOgIzZ/8h+X49VksAhrpVZjv?=
 =?us-ascii?Q?4rTP+DE5tfmqjG0xVHvaMEsTJ+yDxqUtF5Ts1Zep7lu76mg9A5J0fxJ5yHm3?=
 =?us-ascii?Q?+zfUmHn3Q4Nrej/VfkPESdz0WyldgzL7nFdVuLB8nSQrhYVKcXIBNd4mV11R?=
 =?us-ascii?Q?hJoUPyiYuoy0wlIvZ5zVIIOcPHNuO0UnuJkB7oXb9ks1vx+Z0gDF0QqRctWS?=
 =?us-ascii?Q?dHMC6AJ7Vs20dHg6OwaGZvxvmIVKdCbRSZpgthBQfRh7ukVhF7b2HhrpO5K/?=
 =?us-ascii?Q?agnmzUzFrpQstmjsMi+IPN8IULtSD+yrIRg/O+F+xcGBe5jskDZ6/9FD1gFE?=
 =?us-ascii?Q?6cEZLem+rtZno7+jbmReBimbJm41A+WdZpzhQiZa3x9UPet8ZcJupTqHPBPh?=
 =?us-ascii?Q?ujN1sb8NWk126ijd64JJTkeB4oRU9jzdPNNh5bGpgGM1bqq/OL4Yktn2IIav?=
 =?us-ascii?Q?hWbnNDPWK21spnP0xtjsUV1EpLtCBJH7W3233LkRwVpImh+ytJGXuYlfPMpc?=
 =?us-ascii?Q?SZZ/BS/WnGGjKW08Pee7aujmFkFvqcpGQV/EIT1d68qrJDPfAgLl6d77oqRR?=
 =?us-ascii?Q?283TNC4s1fdcWZUGZzbVJQjnKo806UQMwNANltgM6RKJkeI11Z6xhkIStpij?=
 =?us-ascii?Q?XuHXQBdlDSonnf8qXzChCcsZPBxaHXTXrnePOKNzUAy1xt+HlFYVIB+BgIml?=
 =?us-ascii?Q?+s8NPegZW9HeS1epDzCsT9m9zwXZc1oetZ4s6CjHmCda30Y81zC5sVl8HBml?=
 =?us-ascii?Q?qOeg2myq6NsH/z0qP9wIXZYto0UWg0C8lv/T+YIq0ZSohw3Uk64dpHulEL+/?=
 =?us-ascii?Q?m5Xc5D+MUw1U2gL73F9oSDtfsMDWwuUdBV/YPsygAf6qj856b+lOwM0cK/xQ?=
 =?us-ascii?Q?27zNrtcfURP54scVadQaUAJANW+R+oHTTI+ruOBoChbLBvYv8U9Wgr3ooisd?=
 =?us-ascii?Q?8iVJ0j+1C7PH/YKDiryjDnGo4czNHehsFUEYar3OO2crt9zrCxip3K3vxLpp?=
 =?us-ascii?Q?vvR7aybZzCJ+Gi9hrp48pZrshH2YRlUWJFC4LeFa+bKhmWLZSt4CpkP89YzH?=
 =?us-ascii?Q?DuKEGiREjm/yerTq+NN4MSAOKLT94qRojCxhjRDFU6PHStfG0jxVSRvz1N88?=
 =?us-ascii?Q?wfULHywjPoJJfNSysYR4GuSD8OuN9o5hwpHD1tQ8kibcNblzpZdup6tCAQLm?=
 =?us-ascii?Q?ifHW2A2u2xWxgXdzbbBHCcc9gGx9681M8zS1Xh0Gag3vrUw5XFs96pKk1MtE?=
 =?us-ascii?Q?se+GxpBmx7uyX3tn6/rCbV6MwSNlD1QdBu6zZTNk7tsbqZxuZjJvzepARTJX?=
 =?us-ascii?Q?gBH8AV2XhqHu3hKuGem31VBi0b26k+PfvBdGuEWjZuI1v2xUeoxYZjhB6fy6?=
 =?us-ascii?Q?/jeyfNMfxFbJi4KVRH1ydDcS2DMl4QXpvP9Ra0X1HzG3Y+QGSpjTtZiINLbH?=
 =?us-ascii?Q?n7oG52zFeQztuX+C2w7vvrGw2+vxNWZZmwjVX+DNu2WD7QThw2rp1cR0pQdl?=
 =?us-ascii?Q?gV4b69zSwViHqtFWHx4PPMmI8cqNdKTsAm2RVONjdWDDZyB90cb7wXPmUM3k?=
 =?us-ascii?Q?oVoU2gvRwLOw6VykB25xwCk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	LchOdPl/+fXS5A5U1xOevEkgYCfj4oZgwKlVknFtqLxgmlV05IEhuMfswAD5CzUVVKmY2g8N55pVFk2QdWHpsMLkRP9zY66j1CCS6Xi4VAKti1nQhIFvtpT7MF3JTUSb+1kvAA9OtU3/OapETc+3asLyhtPq1SJo3aJ2w7ni4UZAZXIeTSnEvEFUs8LkSHBPrmpBxc81Zk1Gw5lIdBtEDvRFEFIIshC3dLrgBxz2mwXW+YdV/QQbRhFzYsJZEDfPS0jdb4NWw/XET3h1f5hEot4Wb1eBm2wI67Bq+F+zUmrIXL3QvFS1YYM2pZoa0b22AmrQ0qzPMmlzAakyBuETMKss+4m2cC076pEUgIu1vxw/hco+SGFB4jloRM+1lbxlJKrLuWcxSyv61RvlDy8Yu+1+idaT3c92n0wloqsws44PqxfEAapeMQETlhdUhnPawGZvxnHXiTsz332ypatL4Fnx7YhpQg4APNtt0mTJYG/CV+GkFIFsgjQZwR1Tabr2IHl88VuxlfYELW5NNRuAwuP3IoDcMgR+ez6Do4ui3ssZPy7KgJDQEJie24wUmXlAsHasamjVLz4cBAeMdfj8ctmBkY/aGzqj2knOI42LtY4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c75e60-8b0d-42fa-4be1-08dc8ed7e93a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 14:15:16.3443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bUMp5sWQpxMkl0ZvVg6Mx9ENEc6mHgCU8xiiexe6xRjZcZCL7qjWrisf4YlCDfdzSwsM7aXvJZEqAAcg3/f4OwVBQ0Rl/2Jif39HO0gaTIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7772
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_12,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406170110
X-Proofpoint-ORIG-GUID: Bu5OVng1jrWIlmBggbFMJDFn0TcPhxg5
X-Proofpoint-GUID: Bu5OVng1jrWIlmBggbFMJDFn0TcPhxg5

This patch changes a few tests to make use of regular expressions.
Fixed tests otherwise fail when compiled with GCC.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Cc: jose.marchesi@oracle.com
Cc: david.faust@oracle.com
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
---
 tools/testing/selftests/bpf/progs/dynptr_fail.c          | 6 +++---
 tools/testing/selftests/bpf/progs/rbtree_fail.c          | 2 +-
 tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 66a60bfb5867..64cc9d936a13 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -964,7 +964,7 @@ int dynptr_invalidate_slice_reinit(void *ctx)
  * mem_or_null pointers.
  */
 SEC("?raw_tp")
-__failure __msg("R1 type=scalar expected=percpu_ptr_")
+__failure __regex("R[0-9]+ type=scalar expected=percpu_ptr_")
 int dynptr_invalidate_slice_or_null(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -982,7 +982,7 @@ int dynptr_invalidate_slice_or_null(void *ctx)
 
 /* Destruction of dynptr should also any slices obtained from it */
 SEC("?raw_tp")
-__failure __msg("R7 invalid mem access 'scalar'")
+__failure __regex("R[0-9]+ invalid mem access 'scalar'")
 int dynptr_invalidate_slice_failure(void *ctx)
 {
 	struct bpf_dynptr ptr1;
@@ -1069,7 +1069,7 @@ int dynptr_read_into_slot(void *ctx)
 
 /* bpf_dynptr_slice()s are read-only and cannot be written to */
 SEC("?tc")
-__failure __msg("R0 cannot write into rdonly_mem")
+__failure __regex("R[0-9]+ cannot write into rdonly_mem")
 int skb_invalid_slice_write(struct __sk_buff *skb)
 {
 	struct bpf_dynptr ptr;
diff --git a/tools/testing/selftests/bpf/progs/rbtree_fail.c b/tools/testing/selftests/bpf/progs/rbtree_fail.c
index 3fecf1c6dfe5..b722a1e1ddef 100644
--- a/tools/testing/selftests/bpf/progs/rbtree_fail.c
+++ b/tools/testing/selftests/bpf/progs/rbtree_fail.c
@@ -105,7 +105,7 @@ long rbtree_api_remove_unadded_node(void *ctx)
 }
 
 SEC("?tc")
-__failure __msg("Unreleased reference id=3 alloc_insn=10")
+__failure __regex("Unreleased reference id=3 alloc_insn=[0-9]+")
 long rbtree_api_remove_no_drop(void *ctx)
 {
 	struct bpf_rb_node *res;
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
index 1553b9c16aa7..f8d4b7cfcd68 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
@@ -32,7 +32,7 @@ static bool less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
 }
 
 SEC("?tc")
-__failure __msg("Unreleased reference id=4 alloc_insn=21")
+__failure __regex("Unreleased reference id=4 alloc_insn=[0-9]+")
 long rbtree_refcounted_node_ref_escapes(void *ctx)
 {
 	struct node_acquire *n, *m;
@@ -73,7 +73,7 @@ long refcount_acquire_maybe_null(void *ctx)
 }
 
 SEC("?tc")
-__failure __msg("Unreleased reference id=3 alloc_insn=9")
+__failure __regex("Unreleased reference id=3 alloc_insn=[0-9]+")
 long rbtree_refcounted_node_ref_escapes_owning_input(void *ctx)
 {
 	struct node_acquire *n, *m;
-- 
2.39.2


