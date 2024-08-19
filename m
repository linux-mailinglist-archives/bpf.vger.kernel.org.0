Return-Path: <bpf+bounces-37520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AC5956E56
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 17:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45B501F210D5
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 15:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF5B175D46;
	Mon, 19 Aug 2024 15:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C926Wo7z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="psGb8Rsu"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1871741C3
	for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 15:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724080314; cv=fail; b=fgxSWxPeAqVsZ9f6Ua4M95Y3AYbgHisZDv6q+RM1UDTfrbdynowId0JbbtPvKalNHbLd03TyINzWGv2DEBaRIX404g1qfW8/Vqj4/N/pXqPToYue6Y4G62IMFB2yr7GID5uF9tYz6oiGYluKITRAYMLGqqXxluPrWMy4JHXuI8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724080314; c=relaxed/simple;
	bh=m4ukiOGIsibsa9KJM60XGEwJE/KeekEJsQYaff9RJug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q89HhMwfgkOBRkpIKvrRrxHBFzWEFuy4qdT2RnLwbjflKFtOzq+209e2/MtztnMk9KcKOQDs3sqoZI67uEH33O8Rob8AnBTQebuRZ+h0+t6zVOD5lCdb2aUzKj3+49sRAm9VKEtpM1lH2y/8iKM1wYxIMIWPX9glnLEUwwo9t+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C926Wo7z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=psGb8Rsu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JD6sh7013190;
	Mon, 19 Aug 2024 15:11:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=Z35dEbfkB2VTX7MJTmShyELW5+GJMSHjFCMRfNFiARE=; b=
	C926Wo7zF7zrzbKEtmRv3KA1XrGtO+bcFno4ArUx7IKjoQrAVlCviWpVh+meV8gJ
	X++i3EmhkbYgAiVU1Pwcd9rwCA5AwvgL1moNtuwKh5IQZuVLq4j8CrFd+5CuFKPd
	dCqivx7iJwQ0gxpHBbeYYb0DnXp10sBKB7J47f/6NDNOsloGDf3vNJhYFmBjX6QH
	Kv0BnkVReUs/4JDmIm2ZhRstBq2ay3sjNqTp390IoEL23Bkuo1xfkKuiHzHja8Ic
	4npDetaJJMAiwRNEA1H7tcbajfK51Xr4B05VDrAgE4Sh0ou39AF2BRE9a1A48Kcp
	snahovcEB8m7YBMu9qC1RQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m67au2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 15:11:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47JEbIrJ007873;
	Mon, 19 Aug 2024 15:11:46 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 413h3p97d1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 15:11:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NPELYA6e+Yc+0UfOGx9P26iRUXOkepFQqDqUI6s8P1kXhr2n3cSf9c+OMlpRNLqvTm/IiobYyGfJzv5CkHxO8C3zoX/i+EkzH40wihyOkxiVcKtZNTnlYV1deblIVOzzd032OmTliTonMsnGoajjZYEeAjZwWhqmS9NQ+Gi8RBFfOaCQESwuUkXouOpVZ4vaei1dmb7Hl6kWN+gbeLbKqghVBYkTTgSlZGkQUPNKe1x2eZqzVB/H/qPzOSsMr2WLMXa3pvK9R0LEwYHAQjwKr+5UDxthEypF+cPDTVwU3D3cCFKBCuAnbhIIfRLiyG7g8Eo3saxX27uVyA+Qqwq4+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z35dEbfkB2VTX7MJTmShyELW5+GJMSHjFCMRfNFiARE=;
 b=ZSZgGcbCCKUnlWRMMuN9sln8pItXOtskpTdG7oXQUb0S1bGcOllGG/k13+M5f01XbIzB9ysz2atlHRUeyHV/PjV466mHYKn1QY4/z+eBLFQbUo+a6K1h3DFo8sMsX7AzUG53LcCdgaiUKG8I6TdyWFpMpjFMvg0zwCPaZBHE69Og4iJ3mDY4QwR+Ua87BQTbNkOdsF3pmQksVmY7uUrDAbPll0jwhSDgeV4sUJk4gZeQIM5suVywYxpzaEoiaT3yqkwwlkdWlLYRuQd+GdKS6n6N09c6I9FnRq1yGVN25QtNK3U331hi3WKI/v6oRYFrvG/qo3DlHzppjK0xETBfww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z35dEbfkB2VTX7MJTmShyELW5+GJMSHjFCMRfNFiARE=;
 b=psGb8RsuaxlgPoMUx0/pqmBMsHiOBZPyoQvYBLRKz7aoep5qByfKKckeIo9JmVqu9AHyKe0+G56lj5TvP06JghVRzc5eTpDzDF1zC8Xlo/LTwZTO6/oUp3x99FwL8yMUcD1ZwnKr2WuIFADT2bWEyinjnwHsRzkTHmFTW0HUr5k=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by DM4PR10MB6230.namprd10.prod.outlook.com (2603:10b6:8:8d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11; Mon, 19 Aug 2024 15:11:44 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb%2]) with mapi id 15.20.7875.016; Mon, 19 Aug 2024
 15:11:44 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        David Faust <david.faust@oracle.com>
Subject: [PATCH 2/3] selftest/bpf: _GNU_SOURCE redefined in g++
Date: Mon, 19 Aug 2024 16:11:28 +0100
Message-Id: <20240819151129.1366484-3-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240819151129.1366484-1-cupertino.miranda@oracle.com>
References: <20240819151129.1366484-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0034.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::17) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|DM4PR10MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: f045c6eb-c8b2-483c-328b-08dcc0613c87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GB2ChgsPCMame8a/ZlcBFG4h4urIQqQKYJN6eMG4oU73qpoZYgVtaOnNEy7+?=
 =?us-ascii?Q?5rgggqo858Z9XMp7ZaTxgR623Q/oYlChPq6nG8RR3KdvIQN1/xMzf2yZ7vsc?=
 =?us-ascii?Q?symacagbIuqvR8R7BLjfK7PQjEueQYPb8Un+luqcagzFCjBV1eB3M7Qb0rJ8?=
 =?us-ascii?Q?+mlFo5KLmkykVd4gEy5+xeT05yQRKlZNtZB7VF0Wh+fZyFekjd9BhlTgE8qE?=
 =?us-ascii?Q?Tuu3UMQ3EzIa6IhsVJpqqmRb31LvcAWtkNh16UqXLMNWyLNAwPiXbWmEZSGq?=
 =?us-ascii?Q?CGyoh1zjTsbu8fUiiHTl0dAHMXrv/zNbsN+tHYMIsnHRFMxkpZpxzUz+/2l9?=
 =?us-ascii?Q?7bUKMzCh0U47Fdoi1/ewiccfT9Pi19EuAIfgA4sdQlAHHYtn1kKfhUspdN9y?=
 =?us-ascii?Q?g2tE6COOopEI8y+lqrYhOWzAZ3pztVwn+SXXrHJSQ+FiXCegcKfD9cS8VloN?=
 =?us-ascii?Q?krRWl1E09m6LZveyc596y6OeBf2U2SAy/OAAl6eNTOah+eFVaSwVQEzsgYus?=
 =?us-ascii?Q?dOJsI8PQwMZme1leQ7jkb4VvUj3Cwtgurb7q/GnlyZhaUAlgxyHy9siwu3CO?=
 =?us-ascii?Q?9W0eZq5jFVxT+vIG7RG2g53sjH/kKJAxm4xdpvjtGrlZSOzWaG7/zeEgPdDl?=
 =?us-ascii?Q?AEeMbo8twZ5nuZM7BsBiqbQzOPq7CFpIVBoJphHUCxt4fZzV2d8pFP97Y5dD?=
 =?us-ascii?Q?ZJ9neVkp9zcn54GhFBK+JIesBZaJPJozM9ahTClBXkSmjY0p/k7CmuSWJhnl?=
 =?us-ascii?Q?+NE1nqo7QeI93ltUrTSS4CvQNaDiMNghpmzZbDsuAdL3HOqgHl/krob6kdna?=
 =?us-ascii?Q?dmdyXJuYBzLqvimgGklkqOEclpHgYpNdBj+VK+0gVjPfgczW+TaFw8lrVk1j?=
 =?us-ascii?Q?awFQgBJx3LqHQJlSjeBoaCHhDyl8ncohEgYzMoBaLdnGOfoP5HCyM+sx28WX?=
 =?us-ascii?Q?sIV/lhAuW9+lSZh5ExDiPakaGjzJjfpdwaXaOUsfVLTHcULh0/WbS8XSrznB?=
 =?us-ascii?Q?wfdVCOjAsbfkvcrR8eQOJ9QN0/1nYMVeDXecy1kCQ+N15OEvqGqHTnafN+iC?=
 =?us-ascii?Q?Xl+JyswaY/kXXrhV9la/FsP7lIZeUyugzUi10UhO3zRH8/Z5ugXIqPcZsY7q?=
 =?us-ascii?Q?sF9MA5sokCzXx8YoFlb9/rHyAKjzjS5CEWa2jyYTMNP7g2uH2Br/cc0exTt9?=
 =?us-ascii?Q?OymTEmTWhOJPv15YHR5pFgRA+1wWCv0LbxosBEfVjQwsCTcu9DDWzbfD6enO?=
 =?us-ascii?Q?lxXx/7cjo4Qekpz0j3HHnkEum/jDgFOvWjg59RectW3JImVbemNuOPoZTKfr?=
 =?us-ascii?Q?/qHfnAZrQFFu0psU6endlpXHNEhhGPrFwG0E/o9cF5s6aw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dpZgSRZda8MG0+SmDcSaQ/zsobqSjMt8bC+kbQUtoZt+RKIRIi1W/AXfXD+x?=
 =?us-ascii?Q?JTH1p6RmnBhl2qpV/fBxa1g6SKYVaJlsx1ONEIHrTjzbYyzRdZmqBR5ydMNn?=
 =?us-ascii?Q?zBtb5gacdJDn8xrlM9H7QJkWr9oGqMRiF/HSp7Tum3Cdx40jmGzK2P9qvIiX?=
 =?us-ascii?Q?Ti4/qxaFxpIIQY0L05LtW9Zp/aRltpLTwZ8H1tJ7MBreQc8DJ5O5BhVIG54Z?=
 =?us-ascii?Q?dypUU69e3J+BiOscWX6XBGXlSV0MCKJlsYyim4vxm5rQxRXggAOqILOFGvSN?=
 =?us-ascii?Q?mrlMmEYFNQg5l5JUHUEA/+oELac5KONLI5iLQ+ttrWlRaBQ1DSzj/OGF1JCu?=
 =?us-ascii?Q?tJgwRTCIkQlslL3lQ8i+0i0dkNzEdmklUp7iQ8X/HUK49XE3ul7rCpcW2IDi?=
 =?us-ascii?Q?cjNTe+PTn9Ln5/HsF7hYRSzQOX/VDJm8uGdTIk8gVu3fqinK/z5BeXrObF4k?=
 =?us-ascii?Q?0+scv34WQotCswV0tdL+4nXV9ADLzqcLCLHqFo8wOASa5PQjz+MJ0Axw13lH?=
 =?us-ascii?Q?kadh9aBu2JD6K5+aZvaPG2drYg+Ta9fD4NcRAzH8pfDFL6/LAKfhFt+X4S1M?=
 =?us-ascii?Q?rXKMWByfnfaxKiOBbQ+fv3Xt8flnAAXX0S471XdMx4H8yuY/rSOtqipDqrTZ?=
 =?us-ascii?Q?TtH+rO2vAztlfcnadYd2MI08gN1QWAvG/DPjFWbL+nj3YFWpzoWZuP1xtgR3?=
 =?us-ascii?Q?on/bzlbWuXJ7eInL0ZAvCdrshhYQmU9UhPKZbyliii/EM6NKq2iHq5oTj929?=
 =?us-ascii?Q?NNCHMU7aXjUuITeCN1uUpMKei3tthk+S2rn/swuVzFtUVFZdyamhpMgP1T5d?=
 =?us-ascii?Q?5mvUpYC9N7K5GMf4juJsJl1V04A+D+lXFQxjmu5YTTR+SOLd2WxaqsX6Yq7H?=
 =?us-ascii?Q?hmAaQlO9vA4lWAusXFRCWqLglrIWv3dpMPa6sdppQB8mx9KR2qNT6Njxxrhn?=
 =?us-ascii?Q?O+UZuigajtXj2aQya7bq18EmKHuwoDn+3UClxGPmg1e0AmRIQV+Xjo/a4l0E?=
 =?us-ascii?Q?AVZwhIsQJgF1jatrBNu4nrj04qpTSEYRt2uVkZXyABF/aZvQtFCYBmElRkdv?=
 =?us-ascii?Q?Ag6SyANPJp1Y2/0okx/0dI7UC+iaYvwlHlSC02VEoTfbp7m1BUtX58so6APU?=
 =?us-ascii?Q?VNkD1r1VVb5LgxoGYn8MiJcXERwtILJy/icwsYqB2GzpoIjXQ2rrU2OavOPg?=
 =?us-ascii?Q?bgcjHEt5HL9SE35uFjWidd+KwCMxsWau5dTbBmbSa10RkBobMTFMfW7DsXXG?=
 =?us-ascii?Q?4XJOevtV1Ae+Beg7BU8dnxBPfu20U0P+JMsNT4OzWBWBlFVmdTWhzcv6DCDB?=
 =?us-ascii?Q?dMQAKIASw8IQhn3m+Y4P0QNGrQGnPfU0REbX1WXPizi6F+MdBJNq7rXaCxVC?=
 =?us-ascii?Q?Njh2eeQQNS2GuZgbATPNZ6MzFswiTXGn7MXGU5EeU7YEyXDKZUJyneCAHmXc?=
 =?us-ascii?Q?XiRogF3zh6e6aQoGYnpobuU93R46m5E15Avu78v49I5QIL0rq5D2tEfzU7mP?=
 =?us-ascii?Q?bY0oeOZS6GOUxzPNma9QuEx+Z5v36MzxP+PmrNYG+5xUGFHxkIAFEPa4mMen?=
 =?us-ascii?Q?qrzyWsUc2vpGgIxCqGwjmm8jdeQm441GkQgQ3hMtKp0memT9WItBvM8HD5Ko?=
 =?us-ascii?Q?FOrKL6P7uiyczaH5TnsZ8mo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	A3zd5IJLGVJWKOAEcxaRZJYzvCT6nOmTulghg9Mq/HnwDWwQvvP+I/gBpS6ghhcrTBPV5cuerhNPl/2rYRA65YbxB8zS2mDDgJ5+qpZImG0Sn2+W7k5HNrUOb3aUng3rbcQqA7/ZXqi5DfrfyTTHL9mtIxkiTRJHOBtu6IAWOW23R2a+YgIRiZiGYn8y6+yISvnLq0gBtXQ2J8heaXft0w56oQ1LffQZKLaFkqXCA6pDQ/RZzVzCPQs4ePhPfTio2Tsxd279BLCSTddqZkwQpX/cIpbQP/f9dM8nwHlYg/T7oWUyDXMvR0knva9MGSxswDOszZak4rBOQidlnNk+qpRWIl3XLwNdNEQi/xRAwhWOWjIEVF+WJwlH6oT96Sg2Z6moUlSFEPD0WeLmiqTiuPvBitEU4hyQrtAA8sCEUfkXhsDel5mWd7wWiA/Aas7AQbBHQJKmMxm1Va01OLXyH+0fUNZhQ+bnoDEgF/rE+ALbXLNyXDhvCnzMBjMhlWHzXPRbmT0jRJOT3EFJPLk7HVo0CsK3aMwwcAD5CBbiCykEe5P1AT6/mKPKe1oxUKJGX+LSRswXQPaBIssrZr5TjliUB4f6Fi+E3NwbZZd/G/Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f045c6eb-c8b2-483c-328b-08dcc0613c87
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 15:11:44.1498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FfKEawGjxuaKs1+3YOarproUqkf0qHGFPHG8GF7+bActBkLfmZjR1QMLPwcy7HTsKA54grMR56v3NjTQ38/MmX3DCv3dHjAVmhkepFkjn8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6230
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_13,2024-08-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408190101
X-Proofpoint-ORIG-GUID: DhpHrzMBuHijU0YpV2j79QmtGi1BTVQP
X-Proofpoint-GUID: DhpHrzMBuHijU0YpV2j79QmtGi1BTVQP

The following commit:

commit cc937dad85aea4ab9e4f9827d7ea55932c86906b
Author: Edward Liaw <edliaw@google.com>
Date:   Tue Jun 25 22:34:45 2024 +0000

    selftests: centralize -D_GNU_SOURCE= to CFLAGS in lib.mk

introduces "-D_GNU_SOURCE=" to generic CFLAGS used within bpf selfttests
makefiles which include lib.mk.
g++ by default sets the _GNU_SOURCE flag internally which
reports the following warning and subsequent error:

<command-line>: error: "_GNU_SOURCE" redefined [-Werror]
<command-line>: note: this is the location of the previous definition

This patch removes that _GNU_SOURCE definition from CFLAGS when
compiling CPP files.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Jose Marchesi <jose.marchesi@oracle.com>
Cc: David Faust <david.faust@oracle.com>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index ded6e22b3076..f06c51bfd522 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -741,7 +741,7 @@ $(OUTPUT)/xdp_features: xdp_features.c $(OUTPUT)/network_helpers.o $(OUTPUT)/xdp
 # Make sure we are able to include and link libbpf against c++.
 $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOBJ)
 	$(call msg,CXX,,$@)
-	$(Q)$(CXX) $(CFLAGS) $(filter %.a %.o %.cpp,$^) $(LDLIBS) -o $@
+	$(Q)$(CXX) $(subst -D_GNU_SOURCE=,,$(CFLAGS)) $(filter %.a %.o %.cpp,$^) $(LDLIBS) -o $@
 
 # Benchmark runner
 $(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h $(BPFOBJ)
-- 
2.30.2


