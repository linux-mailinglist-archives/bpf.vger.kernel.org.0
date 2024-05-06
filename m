Return-Path: <bpf+bounces-28674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0298BD004
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 16:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC021F25184
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 14:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BF813D53A;
	Mon,  6 May 2024 14:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TgwY9B73";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="edpM1S4c"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1787281207
	for <bpf@vger.kernel.org>; Mon,  6 May 2024 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005177; cv=fail; b=gMXxRKd4MUC9TGqJuan63CXD1J1XyPqNXTmdT4XBI1Iiw1GhiMgLN4gyiderlzGzeNemyjvHOsA/czD0P8anr4ISr+5OIH2uTi41pbNYqckuqQx9R+EJTgN1NhrQvhhXlHi2wraj4z/lmLR4bPzPq5qf5jb3O4eoVL/qowx3eEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005177; c=relaxed/simple;
	bh=I9oW3X0T1Yb6ODnNG4o7vHLib2sGJNFXIAO9LYFrkNI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=EZv8gD+WAyNU7LP/RiqLbodPCSARMjvhZfVGEGJO6dh55+JE7UgIWlwAn5W17sulSNWdFBtDYZNeADSE35O8puy3KckILWGvqOZU6Z4dGe0zBKhu/WQRLJYioXh+VHIXug44sSCdZFTVojs1Z6LgQn6jNmpz1a5v8HsvDklQY3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TgwY9B73; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=edpM1S4c; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446AnBuM031886;
	Mon, 6 May 2024 14:19:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=Z8TkBN7+EdSUzEupSbgffdaJCGkhS9otNDEqtQE7y3M=;
 b=TgwY9B73cInFpvub5j9IrLXbecj6yuh4oMvpmuBciI6H4k6qBoupaXKKdj6cQS+oNNGy
 ay2j9YjJkbOHMwdvqxxEDR66bKM2twm8FPGQ1Gj+QYtEKONURLgDRa6trsi+9QQflg4t
 AAkJlFvGO+TwhiYJuZRMPakJNgypmjEWTQouP+36fzv2kwGA7N3NnftaU7hKRC1WV6xK
 BXIj3HwBtDcGiELEqv4RfRuFd/ftC5yTdkyZn4+anfKGQGPKiLu/PxyGlsqwYR/7HEDp
 1znzHDqEVGy3b6tq6iXh+tQrcV8QXxB7wfLeM/kXEf5mMZoKtUt9lmW5R8GyMruWTacQ sA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwbt52qmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 14:19:32 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 446E6F2K039443;
	Mon, 6 May 2024 14:19:31 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf5pgvs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 14:19:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmvPWcF/Y15w/b32xaHIct2QknDlG5kluVMiW6DnA67ZYXC7bSOEUpIZhb9LaWNEyLJxZD9EqhIcozOyY9PmkAfWEsVVSdHDOhlaNZy1W5bFzYcacl500af8g3+9d80nGmb6jD6eR8PMfqTCjShUIT9p4Q4AL6gdaEIbgnWQAgkgPt6c8Oypgc7/FW1EOG4ZnAuLD6NmRJRYGGrecxRviB396wu6N83VsGvmb4Q0QFSdJbaLQqqhJwJ8JlWZwzS8txywdYSCyRsBtrcoEtDihKuiqD5lSELJcR0ADiOSQmy34KhNFMggiQSP4Xy3TDSZLbbx4ZTR6l6w1l1RcVQziw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8TkBN7+EdSUzEupSbgffdaJCGkhS9otNDEqtQE7y3M=;
 b=DeEo6ustV1fNk/YB8YRGPpdyzB2I/lFtKwhflB+5f2RVdyNZMH5LAEVyY+AmKbTXCu6OJlzYXKPUgn/VAviO63c/Y21bFW0ct2KwgefXelrpCzyuYSrGL8lFSzfYaVAcM8b0N9hxDOTI2MMgAO+eROAfrG3ktJ8g/PzCO0wzjJ7z2WIMS3wIOBGYT5ATweY+EGkXqpm9qa9LVe3K94tILTqaZhBjk9xoLvv/vfKisNCMBL/Z7p+Gi//wHuFqPSwYfXpPGnkrIwBTwzFcTrR0hYrkZLh0APWg7bWu5yr/Z3ZaorIPGvluWhT8px/2prGd6s3GdUu7Y5xptht71lyNXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8TkBN7+EdSUzEupSbgffdaJCGkhS9otNDEqtQE7y3M=;
 b=edpM1S4cu6llLOQPPQzx2ixahjhm8temwCyAvwnXVZRup2j3XfqBhN1ryoq61dPTuzwyOxzftCOCBKwQX0B3GkS1rIophTQVGk+2jEq30473CiztaxHAXRn4ElDE8iUG3UTY1SecjowZDLb5CbowtpH7n/j+5+z0+8o2LGNIYyg=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by DS0PR10MB7173.namprd10.prod.outlook.com (2603:10b6:8:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 14:19:28 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 14:19:27 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next v5 0/6] bpf/verifier: range computation improvements
Date: Mon,  6 May 2024 15:18:43 +0100
Message-Id: <20240506141849.185293-1-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0450.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::23) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|DS0PR10MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: e19f4a52-ac4c-404c-00b8-08dc6dd789a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Gfc0WEIc6kITMHvgsaIaCd5C3JU7Rf3VLuKgcmE/wkzHNgqOM6HDpfAdoyYA?=
 =?us-ascii?Q?V0r+h6xKccLbDfre/yK8Fqoy27iC9ldeFAU/gH2LH+F01g1aSrkUT3ZWw5ml?=
 =?us-ascii?Q?Jty1WfgU+5CUHPPiGxkg4sh2AqkG1X70JfviN5W60Fbb0Yh4rk1AnAAHCGg+?=
 =?us-ascii?Q?Mxk++oBqD3qy8KyFL6HhLrF8xkkvz4zeqJfq9JaT+9k0T4hQtznUlCAFF3CF?=
 =?us-ascii?Q?lu0PCvj36u4Y0i7KrDhVbpAjS1Ar9CFcUVT91xuvAbgrN0GQqmqY1GtKgMKe?=
 =?us-ascii?Q?nEk2jD10iL7lxfIj+ObJO2DElywu0oTXcQlFr1SUEBOgB+0I/oQ9t6VjzCvM?=
 =?us-ascii?Q?nfoByuM28wIgFD+fzrmIfCjEFYt1G9IE1j73yQcRZOtUUgiMLT3DK4NIgJUr?=
 =?us-ascii?Q?SRdA/9908SU9i3lXm/+EDijj+eaXMFXQpKZK3cZFrjixHnicf+gEl6yh5e9Y?=
 =?us-ascii?Q?MoY/DRRWnt3qw4n8aye14p0g0LenNpZn8mSCYdLYX4UdY3kusXlbE9l6PvE0?=
 =?us-ascii?Q?LyxGc8Pn/dDp8dD4gwYxanQTqAEwMlyCzBTIF0kIfp8R85eDq7eE14thUU1d?=
 =?us-ascii?Q?Fxza75gEStpOC5PqX5/cLKDQZAN2Jgat4mNbqXluPbCmOtJd2c3HUJe/Rru1?=
 =?us-ascii?Q?KhEjZdeZhXlmrkJgGShcF3WY1aBIycCYO2YwCmAJDjyupsgbxzo7CihYyYIa?=
 =?us-ascii?Q?MiTGEWkgrgKswupFWlCe9iK8akz0Bp1I4I6jKqYCP2+qSfJcxXQsDTDZs1pR?=
 =?us-ascii?Q?/7x4p/8LQFqcozcCahpFlnDM4g2eYTSTpFY3DK9znJUX4pCSQK6glu5husQT?=
 =?us-ascii?Q?fxrGveTByMXaE6XUqC9VYvgOstNIN9r1mGiRz4C2I6CpqxGwDrqGFw8VYjpx?=
 =?us-ascii?Q?ZuBxe0WNIqPT/6R6xTLjnUwSAZ2Y9aqDhpj87nRQVmoPF/sqxMQzQrP31r3M?=
 =?us-ascii?Q?gZ44buA/ptqF9qQqt0XdVDzSwnMwtvMZl2F53KnTzG3HsX+H1wlnUzcbm5Zs?=
 =?us-ascii?Q?1HbwuWLs+dDrO0ruQIRcnr0GvnnX1mSpuBlqvU9VQW6bFvE0evGQen0uf5Ka?=
 =?us-ascii?Q?Y9w1FrNRkEjTX40cPoJ5BF4QaxkbApRPHmqqIVGqlGsw0D+LcFFPmzgyulTS?=
 =?us-ascii?Q?2lcLBKumzWFdFb43i/dctGMZTMQntkcW7y026EH4sbLB7QBWTy35lgfkB2yM?=
 =?us-ascii?Q?OAU3ZXg3C4phcGHxoASdRyJxMaeevSH0qHFOoY0XOUk7MJCwSeYicsJA9cxJ?=
 =?us-ascii?Q?5VnCXtpq26sEJL8nVwjSYN5VXs+D/qyGqQMzg75MAQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?HE5C9B3/ChFfI8TCZyX4uKPUdMWiCfcT3QjuTseznwb6dVVtRbmUFrDCGBHp?=
 =?us-ascii?Q?WExYgMAq9O4nuwu/dQkJEWGBHYF1K3EZBMavWvcGRuUQt8CTI2uitGp16K5H?=
 =?us-ascii?Q?8g9+RdB7KS5t/Sr7cnBVMBkRsk5LSqwRloGzhOdI5PXy/LRJnR6VpEVrugul?=
 =?us-ascii?Q?Q2z3SPoNhyxABh9TM0FN9f6eJIWbEoxr+s9W5aEMGWblh8NrA5qduxMmFg1E?=
 =?us-ascii?Q?iAdx86YOFGBX4fmWIcdXHmldAYdt/ygafon9Q392K3Doh2AIBaDkMeyjn/u3?=
 =?us-ascii?Q?a4gVV3hElGZ2o0hORpayySce2vbefaWx6BFbS4s6B8AQodLQcwVfFULb1Kzb?=
 =?us-ascii?Q?bQeJXClhWLh4OK2mbKNKfz819NrJhx0BaK07m8JOenxW0n7on5C8acwp6vY3?=
 =?us-ascii?Q?hqKySSa02oLXkgSbNk81Qf9CG+Hj2AMIyeE3oXeJ5XfJWO2KoGmrxZxE6IHT?=
 =?us-ascii?Q?lIQLnEznZIp0FCdTV2BDBh8rNfJIAfdHHxhnTT7faXjvKehJXh0HLqEBD4RW?=
 =?us-ascii?Q?CLwdPQ1RWynv7uLr/+FoBJypsoopKisO8R9QOiiO3nhdackN+sTyyotIqzN+?=
 =?us-ascii?Q?RzzdQNUyttOPAy2CucFn+AgSQuGhmQnRy3ioeQiGkJppBZv8uf639qXf/Wlb?=
 =?us-ascii?Q?tFgN6MwzgyAOB9tC3yBAZBQXvuMNN8O1FOEuFKa0CcNVg1nVblBBQrZsWwbk?=
 =?us-ascii?Q?fIvdL4s5ZisGLmHvHyvCI8nEt04g0V4648BjtOa+lBm9A/wLbY+6JI51dlmp?=
 =?us-ascii?Q?R7BXCQMAnQasqZedDtvlTVaOMvI8azfFghYrwoIp6WxHzC6uV6C/iOFm85BX?=
 =?us-ascii?Q?9y2g6VaF6Er/Wb6rYlcXelFmyk7CtagWmV/EBcxg4l7o+WsIpN2G+8wfQO4n?=
 =?us-ascii?Q?LaYDwiR6GE3nYKJN9VIcMdC1VXLti0SvXd3mcetiSqP+kyB5kLDmbA7S0RqO?=
 =?us-ascii?Q?P9rwqQ2bG57w4BJnVu7MLBLQVrdMqiRD/Ny0Nf6BGfSUzLOWdAbBDLhXEgCr?=
 =?us-ascii?Q?+7PyGT2TtxLBCqnv00vDspUYtOBQ9G9klyHsSsD5OVxb/ZrGyx+bIvHGetPY?=
 =?us-ascii?Q?ebD2vBUQk1LBdhSwUcYdNDCImV+ANU5Va7WswT6549UDRvkvYn3hDKSavE9Q?=
 =?us-ascii?Q?SvS9k08LsnBMp930uuFNsDhf7B9cf4ZZ41cdMrol7qF/SE0e7SMihXBwuCE0?=
 =?us-ascii?Q?Z0C51qLeb2uH5oVU+mrT2a6N4jlCrs2UCO3rGFH0YdbiRplOAFPeAG+Eba9a?=
 =?us-ascii?Q?n0HAQaIXclR2YHI83IJI48ffI5pK5b28olU/bmP589XP7401taPUPJmooBuo?=
 =?us-ascii?Q?qQp/+7rsPaHlBPA0BzYxI6N9kTh/rPHJjrIXXKowAi1ghXEzd6gM6NvNNruO?=
 =?us-ascii?Q?1Bgvs9XuzcVjpcdKyDHoG5mI5Z1uk0pvydg0tetYGobdgD2xv3+Qle4afLbI?=
 =?us-ascii?Q?SlwaQRFDBbRK5R5yemLRddzE9V61sidALJfJRaH9MjnGxyg3k67EuukmEDz+?=
 =?us-ascii?Q?BAutbhL3dfbxFsTAhJGZAsg5rmxKG/G9rxRJfeB0EsYYBt84ewOlzZlKTOVR?=
 =?us-ascii?Q?dxb0wfbqAmCMn3lYry7joiv2DQyShXbm1NhHrSbS1NcaTU1zjN+gM3JF8Wcb?=
 =?us-ascii?Q?VgexILf8+74v/M1kwR5Knrw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2aG6C8jIzC/Bo3UYOabUEESDruuSCE+3++9YaxgyhFg/x3lYZylIJFkSRB4dUFwkFzqvbb0YbQAUsyiF7tMwPn/v6CfCetBzYo+NOYIatmUn/vc6hckl2fSdVnS5L6Zy+lAPYYtP41f13kgSA96PzA/tlHoZheWzn4zNergElvJO8dE6PVv6VK4UD+R6OARObJ1PazA11In07Cb6fxjP6FQ3SZBMP//ij17zGlgQ0NGNH44xpbP8nHdxSFKlhAqYCgz3XUWyVN7PaBftkiaS5+MyLd18qd4m+2fjWKUReu8Qs94i+6chpHvj1C052FNMUcSVeG3Drf/OQzaIT7LmOaXZxDNJDCxuHIVZ5WDDZjBSnGAqp2ogzX9hrJRqkNXGWbwaxm7v++t3ucxqAoX1XrEB74GhbSO/0D4mdlQPqqAGDmzcHgTJ2Jhv7gNQzINj+NaX2tTJDw4fPX+2nhPyXnRRJzEDuTwlkHmGiU5MndNqJT8LYB77TvTG/tq4vR1PNkkeh0q5jran255hgpRlfGplA+xmHrYrw5gztpb0pnOT2eLEtHJGPD/mnJP/Pu7GlOVaRjbCHW9SdVIitiLAjIIoOyJ+J3qJCkGVj/QfnLA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e19f4a52-ac4c-404c-00b8-08dc6dd789a0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 14:19:27.6165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lK2DD7QinucPIFg5a/hvcNjBooJQqB3yil+bADs+vPeYC2M83ZztLdnvD40vnBe7O3LBivPwOLmQ+//Hk0k7YyMHunq+n4FrI2jcyTibomI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7173
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_08,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405060099
X-Proofpoint-GUID: K1k_p0R1BcpEz8oIMQ9MsVIU215mgBFY
X-Proofpoint-ORIG-GUID: K1k_p0R1BcpEz8oIMQ9MsVIU215mgBFY

Hi everyone,

This is what I hope to be the last version. :)

Regards,
Cupertino

Changes from v1:
 - Reordered patches in the series.
 - Fix refactor to be acurate with original code.
 - Fixed other mentioned small problems.

Changes from v2:
 - Added a patch to replace mark_reg_unknowon for __mark_reg_unknown in
   the context of range computation.
 - Reverted implementation of refactor to v1 which used a simpler
   boolean return value in check function.
 - Further relaxed MUL to allow it to still compute a range when neither
   of its registers is a known value.
 - Simplified tests based on Eduards example.
 - Added messages in selftest commits.

Changes from v3:
 - Improved commit message of patch nr 1.
 - Coding style fixes.
 - Improve XOR and OR tests.
 - Made function calls to pass struct bpf_reg_state pointer instead.
 - Improved final code as a last patch.

Changes from v4:
 - Merged patch nr 7 in 2.

Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Faust <david.faust@oracle.com>
Cc: Jose Marchesi <jose.marchesi@oracle.com>
Cc: Elena Zannoni <elena.zannoni@oracle.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>

Cupertino Miranda (6):
  bpf/verifier: replace calls to mark_reg_unknown.
  bpf/verifier: refactor checks for range computation
  bpf/verifier: improve XOR and OR range computation
  selftests/bpf: XOR and OR range computation tests.
  bpf/verifier: relax MUL range computation check
  selftests/bpf: MUL range computation tests.

 kernel/bpf/verifier.c                         | 106 +++++++-----------
 .../selftests/bpf/progs/verifier_bounds.c     |  63 +++++++++++
 2 files changed, 104 insertions(+), 65 deletions(-)

-- 
2.39.2


