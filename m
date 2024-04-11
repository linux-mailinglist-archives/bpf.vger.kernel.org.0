Return-Path: <bpf+bounces-26566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411838A1E9A
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 20:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09245B220E3
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 18:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F47285926;
	Thu, 11 Apr 2024 17:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ftLSTGpH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x1LjN1hE"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8225585645
	for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 17:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712857087; cv=fail; b=YD1VhpBU0b1Dx9RFnogjbXZQ5Z9xJxfsMAeqnb+bbVspNgMyYwhZC/yoB+Z1ubfnUOULaq4+IBS1Hn1YgjqEmJsHvjtEoKUIC5mUAIwvpu2iUtlDJ79InLhxRNTIi4R09Yfs2NgtqeWK+74SRB+kh3bt21SuoPVcQKZkbzB43Wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712857087; c=relaxed/simple;
	bh=f0P7BDc31So37EmaxYiPLrby6mZhDT+11Tu6nmJcrHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MmbZL2lDsCmt8Vq36bV9GLuqpYwRl7+lqewLzJrxBR6ZiFCpKOA8Clnx1o9ghTvgrRBGEAfXp0fuAgAGzwgpc7Nh7/JYos6EwgVsNEbObKb2qNm0eolLE84n0DOZzFuT9dkLCwtGibdMxA3I2TNDcOKfxvj6TiD7T3wx0Tz5qR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ftLSTGpH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x1LjN1hE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43BGtKGH009329;
	Thu, 11 Apr 2024 17:38:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=xO/1m8H2/w7LOCBROy/VdmnT9n7foxfVFU0wOOhsb+8=;
 b=ftLSTGpH4vuLM+ePS6q9i5q1DqLN2Ju8ENQZK1wgW30mScEqnhxQQOSV+mXhI7vDd2eY
 dbzhSkWAT6qHVL6sqqMBmgYjqiAMEG1DC6N2iPs1Y7kJeE548YIsU1RQn/ebcl5cmxOy
 2dSgZ1ebJng9bqS92hHjNrtkPlA8wh+lOyBKC667ByXGrshtDZiUvcGpoSOiCfRYRC7i
 WImYSLDPq9VVAfw3AVebEwKwbIonCMV89NfJxCIy2ztSt5dmrtnPFvPnuh4xsAO9v2jM
 YuxmrJDftBhDCujOnFuB+cU9Aan2+m3THimiTtYl2ApsBeBThG3JgJdwCl45P2v4ihcU gw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xed4jry5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2024 17:38:02 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43BGAB6F040050;
	Thu, 11 Apr 2024 17:38:01 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavug4tq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2024 17:38:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pou1qSvixZKecK9yowCSC3eZ9kEMHlElKW7Ka66NHs/x62+0DJ8BkIasDCFE0YSucwE+s6d6BpVTYLvPH5pQEGhQ9C+dfyDxD/kCyxLsVWPoAunoG/4m0zyvBGUeLqq8xYNiBiaKN+q6LZdppiHQACyuRbda10rDChkx2hG+Tx0n3YavmKmcEsDlf/LseTk3WpuqIHz55ie78Gwzh6tl3z0INH7qdhS6TPNM/Qv/+BYXbmlfE3axGuVJPPDqmNf7HiMrV4N1IZir5+pd/R0H4lo9c2Gu/Z7Ps6O+2EmoqM8+hyO6O1cUGATtbyrTS+Biz9Y0ycMsqRo8un3wKyjlZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xO/1m8H2/w7LOCBROy/VdmnT9n7foxfVFU0wOOhsb+8=;
 b=eD0sNyx5E5U2B1uwwC+rUGhQZFqI9Rlrfp1tucijgxqc/Sy6Ngi7iBKGKuq6n2RBJxsK6PpEv0nFaQs8/mYEtZftgakxCWzMgFLX5b5iUptVopJK8RAbmna0s4G/tY3LyxWwYnbicGG288keEZ9OCYOmzAJJUzlz9VckeH9Oc6eaRZqgLuxgUVvdGsk1ZwZRDCxzUq4UrF8MVF8hci3P5wZUrpGbSVo1qPpT1x9BT9LFVU5Nng0Q8tEa/c85hi0btin3RNdBXJ9RcJ7ByWfshNeX+9J0uQadIEsJAOgDy49bPieSnNmnG4EkaLSO02eVLRtJvIRgF8qmpp+jhl2D2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xO/1m8H2/w7LOCBROy/VdmnT9n7foxfVFU0wOOhsb+8=;
 b=x1LjN1hEgoaQd2t5CVRRueOBRt8hpK0BZ/9wqoL5UJDXm09j+Cjv0mCPhbJxW3MlUnvvT3ZjJI/tm/zPFjvuoKAlPJTAX1k+1Bsa0KPbx3Eg7moI84jtw/qj5spVZIIpV91oa4B7LIC83RH83etPW5aBj8q8MO7iztfY0D9jdNI=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by MW5PR10MB5828.namprd10.prod.outlook.com (2603:10b6:303:190::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 17:37:57 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 17:37:56 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: jose.marchesi@oracle.com, david.faust@oracle.com, elena.zannoni@oracle.com,
        yonghong.song@linux.dev, alexei.starovoitov@gmail.com,
        Cupertino Miranda <cupertino.miranda@oracle.com>
Subject: [PATCH bpf-next 2/3] bpf: refactor checks for range computation
Date: Thu, 11 Apr 2024 18:37:31 +0100
Message-Id: <20240411173732.221881-2-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240411173732.221881-1-cupertino.miranda@oracle.com>
References: <20240411173732.221881-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0427.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::18) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|MW5PR10MB5828:EE_
X-MS-Office365-Filtering-Correlation-Id: da3ffeb1-a752-49f0-a5e1-08dc5a4e1fca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	20DffBQLHzvgXzc1DrO+d8DpaUXDryVXyDaqcjzgU3t6xBvfnSzOxhLWm61jLf1bEgCmhX+tM/L4FO7rn91Y7bA27+2SzxcXEXWQymcwVg4NXQFXfphlFMZTKJj4y4LDbqrd/8OGxm411ZGDM4nDHJUk1nW4FSjP318XJzRqXjDgvqCmCtI7Jel81anHMBwGYkr7JB7XLC8Yu9Es8IzTlpiTdLSdVupqTw5WuSOsYyyqxQWGcdiKFPLZj5Nxn9nNohnak/9NhJGNWvtOs0rwIylUmq8cJBigRmasIL6hIHhkOUFuEggVVPEflFjXalDfhcEVGauAFeWaxaBllDiV+wHycT76I0IxZ56F6eAAsrurjbuVPTAevrN2xHwgjIeLtOUj6Orqy4sFavC3jbsXi9Zj3JgAkVIoCAHOIkly7i/h+zZ6BbF12IT8NyFK8ZXvai0dFFWndM4DtX/+nFBmaC9SCLGwKZ3MW8/uGwDvzOax/xWhPw7oCv3V4LJ87naSCahRkSTl+8nAzDECBXZIENz1ryGWMCP71HXvyTqm8S07/Spj9htZTq6gBaGG6ySMeLvKGMLM8Q+e2KaGhwayd19WVAoPvlmqTTKZlFQXpoeuWCh9xgOrbsSeuL0PITzNxBNuVAyTqP1kPRnAjjcHniIz4Cc1eDjgJ9FPkc/jE5Q=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?FJpc7WaA9llgMMIP6PQJoLLHvYCAB74DaKVbmraawNVKTehtEPDXUf3j7RZa?=
 =?us-ascii?Q?p4+b/Q9FBKDPVnOeDQ1f4bXvKQW9iUavi8entAs7B3RV/jUKJt+BoCKuWtyT?=
 =?us-ascii?Q?45TiihdzGGDdIydLi14xlxzJ4gSrH7nM225RTBXjeRm8Cr9MTkOn/Vxd0lT4?=
 =?us-ascii?Q?EO5eywOYLO+ZNy/2n7eQkMbafPkWWAHAvZc8deETSG2wxYpyhkINK9aUh/Za?=
 =?us-ascii?Q?sairpxZRyZCfwixJJvFZ7+5Irjf/oNIbKsWNeW6W+GqxVSu2p9vkwHkFK48x?=
 =?us-ascii?Q?/1XcqbdZFVi0OTkQtseWxSYVMrRXKAH6ChpRS6ESzGYcbImCZAwguzdUg1C1?=
 =?us-ascii?Q?8DhlgtmuF5XFMiXBMEVBl/PiuZYT5Rp7yZ0tHGdgsZWbH3CDJbjsa/TnFfAa?=
 =?us-ascii?Q?rqDVbQ5a8URBa0G6vun2Kp/YjMUQV/a+FKQ8jdqOL1C7JmQ/zB/5vwGT4+Ku?=
 =?us-ascii?Q?MOH+Si692DcOia72rWq6WC/o4XTVX7GRZFolMuX3VKPcopTPXcAKeB2jj62p?=
 =?us-ascii?Q?ZCC6pZurjVb46mZNualRj7VsTra/HoIDiUpejj8+YRe46Qtw7U2yFDO3WRdU?=
 =?us-ascii?Q?lxbJOTl2CFs0EELV82gjykXTGbjVLNRCZPymM+2dhiMJpj0DtXs6pq1lN2dH?=
 =?us-ascii?Q?qzRzjEmG1NYAHszqe63NMHtyH6PkdofubLskBq9f6NPaKOKEs+ZWJzUt0GvI?=
 =?us-ascii?Q?TaDh/AeSXXEyChXL3plHL9nTnb6GIMvWXsdBWAmpikKABprmxEjoUZjdGCy2?=
 =?us-ascii?Q?uf2DDBs+cp/R6YJRQSqErYzmJX2POktf3RHnnM3nwxQA3eAY5jY2g4Lyl3C0?=
 =?us-ascii?Q?7VP6rqrtqE8+e9pj9pI3Bsy7MkMBz5AyI2YgBcQtTwUXaFUE1ZlyKd2OFRE3?=
 =?us-ascii?Q?HPDFXrx5MoQ72iWFHjDmw7goajsp7TOeJQVlPSDpzYHnSncjBF4gtqj6in5D?=
 =?us-ascii?Q?0F4xfl0PGXYIAcRZZOr/qTAus4ELRdBdI/KllZ60bwD3EY+JAflzDgr1FOEI?=
 =?us-ascii?Q?Ac0PxfGi0JcxWrsl1VHWJ8+bL5IY2nwufUgzL+ZhvTZHs6VhnSbhix/41cJU?=
 =?us-ascii?Q?8eB7Ye4I/vgRuN7e5RQ9PYoMo+veZudBTj3BYrRlPYUfT8sCC1fDEThFjKAS?=
 =?us-ascii?Q?vJIPWeee2T0EaSVl4TtltEWIvl8Mrf5F0AD4NEnNhhNIm5aIL8zJnrRGuKrG?=
 =?us-ascii?Q?ydUKabj4vXJtZafTuCXmuA2Jt+h1LZy1iamfUo0awihaiJq2y6cDMy5t2iaG?=
 =?us-ascii?Q?QNu4CPHee8ZZK9X+T8ZUshYqUfw5BDzHBQVBM5NHy9VKNmEntWgFvhKUbF+t?=
 =?us-ascii?Q?hRVkZcgLWw055/njxSwnmKV/bhsb/ofajan5e9F4nvFWUaDwwUewxyOX3zzs?=
 =?us-ascii?Q?EIPeU7H/ivPeTHm5rzjAJkXDcDIXCOXI7elskSrKIGZyUyv8vFn3zTV6ld89?=
 =?us-ascii?Q?Aa4ljGWfm1blnc793gzmNrY8UYFVfWeJqE1rxxo8HzsRE8cvYDy1AdJNsEMp?=
 =?us-ascii?Q?YvZlzVcJU3Doj7SoqeUmfCm50yvL4C8lCTrthEgN4VF1cuVVvc/nZK0sowP+?=
 =?us-ascii?Q?qsFlFd2M7VoJBCsrX/C8SGaPhy5CwOanJhyMN0F6lfcxKh7vDCJaLukP/++v?=
 =?us-ascii?Q?lEd+gmJQmoP5rc7+we4PNu8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7l+2V5xB+b1ME1gN+ACgLJX3bqad7c7uGhlbMwz3fXEoDVV5GPduF7viBGiDnHgvQ3QFv3oxx6uTDKD80ktj4PHagxVU5Ry/auRTHmR/ItmfNjk27yZKmyIXOIp67TJ0kX21ZnMc7J51tS4uB1NGfJRocjCs3tPhdy5yCiQruDXvHMXIRkWZrWCLYL+i3rSJTpUHOZV6YHdVYueT3FGo/oEVqhAM6DoWOblKXoQ+yaiCJZ9mY17bdjbBWvGD8fM4eKMEYH7yuA49Q2RQXwHhJgjantZTaRETofCmF+LeCaAuNnPje79d/HJJg/cx9dL6iSA9r8gFjVdOY50YXP/WhmRzXGgUrLrh5Yk/SJ2agV8968elxR1W+zi7azMQo1TlN/oyZ+zBrqSqiayBwzLwTQqMyQyxGnCsWnt69Frd9VOZShke8FhD5g/oYUFshzm+gGyor43YtGEjXR8+PsS3kOEmVsO3caCJe+ttEI0kpI2LKJCTKc4cdYI2PmlnijVeSX9oIv8PFnM1kRhErAXJJ/cDuSRTIeL1JbuQwnEp6AagMNjtC1cv0fsxPFJixUDzpKfm5NDFJE9qFCPegz30Dfm1GznmUH9bmJxm3xTgQA0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da3ffeb1-a752-49f0-a5e1-08dc5a4e1fca
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 17:37:56.8923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ug9jJQC293ShfRDONBzbLjslvU+hLI7/Mk9UO4+A/LrblgnWSXYTq0bSRaP1GJUKBccgKzmUKGeqHrKmnMIKespEPTun9+tKoc/14SL9YU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5828
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_10,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404110128
X-Proofpoint-GUID: JmVEzeo8st41fOGRCmO_RtHM-np0HL-X
X-Proofpoint-ORIG-GUID: JmVEzeo8st41fOGRCmO_RtHM-np0HL-X

Split range computation checks in its own function, isolating pessimitic
range set for dst_reg and failing return to a single point.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
---
 kernel/bpf/verifier.c | 141 +++++++++++++++++++++++-------------------
 1 file changed, 77 insertions(+), 64 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a219f601569a..7894af2e1bdb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13709,6 +13709,82 @@ static void scalar_min_max_arsh(struct bpf_reg_state *dst_reg,
 	__update_reg_bounds(dst_reg);
 }
 
+static bool is_const_reg_and_valid(struct bpf_reg_state reg, bool alu32,
+				   bool *valid)
+{
+	s64 smin_val = reg.smin_value;
+	s64 smax_val = reg.smax_value;
+	u64 umin_val = reg.umin_value;
+	u64 umax_val = reg.umax_value;
+
+	s32 s32_min_val = reg.s32_min_value;
+	s32 s32_max_val = reg.s32_max_value;
+	u32 u32_min_val = reg.u32_min_value;
+	u32 u32_max_val = reg.u32_max_value;
+
+	bool known = alu32 ? tnum_subreg_is_const(reg.var_off) :
+			     tnum_is_const(reg.var_off);
+
+	if (alu32) {
+		if ((known &&
+		     (s32_min_val != s32_max_val || u32_min_val != u32_max_val)) ||
+		      s32_min_val > s32_max_val || u32_min_val > u32_max_val)
+			*valid &= false;
+	} else {
+		if ((known &&
+		     (smin_val != smax_val || umin_val != umax_val)) ||
+		    smin_val > smax_val || umin_val > umax_val)
+			*valid &= false;
+	}
+
+	return known;
+}
+
+static bool is_safe_to_compute_dst_reg_ranges(struct bpf_insn *insn,
+					      struct bpf_reg_state src_reg)
+{
+	bool src_known;
+	u64 insn_bitness = (BPF_CLASS(insn->code) == BPF_ALU64) ? 64 : 32;
+	bool alu32 = (BPF_CLASS(insn->code) != BPF_ALU64);
+	u8 opcode = BPF_OP(insn->code);
+
+	bool valid_known = true;
+	src_known = is_const_reg_and_valid(src_reg, alu32, &valid_known);
+
+	/* Taint dst register if offset had invalid bounds
+	 * derived from e.g. dead branches.
+	 */
+	if (valid_known == false)
+		return false;
+
+	switch (opcode) {
+	case BPF_ADD:
+	case BPF_SUB:
+	case BPF_AND:
+	case BPF_XOR:
+	case BPF_OR:
+		return true;
+
+	/* Compute range for MUL if the src_reg is known.
+	 */
+	case BPF_MUL:
+		return src_known;
+
+	/* Shift operators range is only computable if shift dimension operand
+	 * is known. Also, shifts greater than 31 or 63 are undefined. This
+	 * includes shifts by a negative number.
+	 */
+	case BPF_LSH:
+	case BPF_RSH:
+	case BPF_ARSH:
+		return src_known && (src_reg.umax_value < insn_bitness);
+	default:
+		break;
+	}
+
+	return false;
+}
+
 /* WARNING: This function does calculations on 64-bit values, but the actual
  * execution may occur on 32-bit values. Therefore, things like bitshifts
  * need extra checks in the 32-bit case.
@@ -13720,52 +13796,10 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 {
 	struct bpf_reg_state *regs = cur_regs(env);
 	u8 opcode = BPF_OP(insn->code);
-	bool src_known;
-	s64 smin_val, smax_val;
-	u64 umin_val, umax_val;
-	s32 s32_min_val, s32_max_val;
-	u32 u32_min_val, u32_max_val;
-	u64 insn_bitness = (BPF_CLASS(insn->code) == BPF_ALU64) ? 64 : 32;
 	bool alu32 = (BPF_CLASS(insn->code) != BPF_ALU64);
 	int ret;
 
-	smin_val = src_reg.smin_value;
-	smax_val = src_reg.smax_value;
-	umin_val = src_reg.umin_value;
-	umax_val = src_reg.umax_value;
-
-	s32_min_val = src_reg.s32_min_value;
-	s32_max_val = src_reg.s32_max_value;
-	u32_min_val = src_reg.u32_min_value;
-	u32_max_val = src_reg.u32_max_value;
-
-	if (alu32) {
-		src_known = tnum_subreg_is_const(src_reg.var_off);
-		if ((src_known &&
-		     (s32_min_val != s32_max_val || u32_min_val != u32_max_val)) ||
-		    s32_min_val > s32_max_val || u32_min_val > u32_max_val) {
-			/* Taint dst register if offset had invalid bounds
-			 * derived from e.g. dead branches.
-			 */
-			__mark_reg_unknown(env, dst_reg);
-			return 0;
-		}
-	} else {
-		src_known = tnum_is_const(src_reg.var_off);
-		if ((src_known &&
-		     (smin_val != smax_val || umin_val != umax_val)) ||
-		    smin_val > smax_val || umin_val > umax_val) {
-			/* Taint dst register if offset had invalid bounds
-			 * derived from e.g. dead branches.
-			 */
-			__mark_reg_unknown(env, dst_reg);
-			return 0;
-		}
-	}
-
-	if (!src_known &&
-	    opcode != BPF_ADD && opcode != BPF_SUB && opcode != BPF_AND &&
-	    opcode != BPF_XOR && opcode != BPF_OR) {
+	if (!is_safe_to_compute_dst_reg_ranges(insn, src_reg)) {
 		__mark_reg_unknown(env, dst_reg);
 		return 0;
 	}
@@ -13822,39 +13856,18 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		scalar_min_max_xor(dst_reg, &src_reg);
 		break;
 	case BPF_LSH:
-		if (umax_val >= insn_bitness) {
-			/* Shifts greater than 31 or 63 are undefined.
-			 * This includes shifts by a negative number.
-			 */
-			mark_reg_unknown(env, regs, insn->dst_reg);
-			break;
-		}
 		if (alu32)
 			scalar32_min_max_lsh(dst_reg, &src_reg);
 		else
 			scalar_min_max_lsh(dst_reg, &src_reg);
 		break;
 	case BPF_RSH:
-		if (umax_val >= insn_bitness) {
-			/* Shifts greater than 31 or 63 are undefined.
-			 * This includes shifts by a negative number.
-			 */
-			mark_reg_unknown(env, regs, insn->dst_reg);
-			break;
-		}
 		if (alu32)
 			scalar32_min_max_rsh(dst_reg, &src_reg);
 		else
 			scalar_min_max_rsh(dst_reg, &src_reg);
 		break;
 	case BPF_ARSH:
-		if (umax_val >= insn_bitness) {
-			/* Shifts greater than 31 or 63 are undefined.
-			 * This includes shifts by a negative number.
-			 */
-			mark_reg_unknown(env, regs, insn->dst_reg);
-			break;
-		}
 		if (alu32)
 			scalar32_min_max_arsh(dst_reg, &src_reg);
 		else
-- 
2.30.2


