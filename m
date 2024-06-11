Return-Path: <bpf+bounces-31858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB34E904298
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 19:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80198283B66
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 17:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2484DA00;
	Tue, 11 Jun 2024 17:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eQTyMFFK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GS1uCz1Q"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A884F5F9
	for <bpf@vger.kernel.org>; Tue, 11 Jun 2024 17:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718127670; cv=fail; b=ORbYpxXVPfPLIht2ehyB/NhZBUD3JMijm4+PGYWHXdcaxzSBOsjvXPOrvmS0mLPBJD4QicoeRSbELDf062an1P6bbbGdXEuzn6+5Ong5FCv4YVWi3SxNOdbz6ivTV36vd/hPkFjI2YXIlUKGOFnmFoI8X/IijvnYuhoMgof62dE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718127670; c=relaxed/simple;
	bh=pUq0Cmm8gw/AwH7Tzj0hwydaHG7VoaBDQc0/715gumk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=aUVKEKecVSXbuzbcQ8DqFwK+1lqzaRGtO4ZCOR3KTCH0KCbEAvFAPbefwnsENJ8M95ZcuoJrK8mMS9UOpPL/9/z9S0pl9r7by5PFqgA+SLYJ4mpLhKMNJSaRSlVRtXEUWi/VCVyUtb2Yh8kKCK69Kg5Z2vI704nr7c1+sHrKpHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eQTyMFFK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GS1uCz1Q; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BFqInl013388
	for <bpf@vger.kernel.org>; Tue, 11 Jun 2024 17:41:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=VjV0J7ymAZ7xQs
	YrVAyJEpLkyikfPuSFz5PblZvIn8Y=; b=eQTyMFFK/8IVIsrXRV+C2EWfUM2Ceu
	UikDaLObtqZkyLegs8lV9dTmkygenKC7SR+DcpQS1+YGVBzez+QaLc8TDIRsGJSJ
	Mfpkzln+BCrpaEXjvnKkuCozCXXoOwoIZ8bZu4wJu9ZimNRWcFVN15pdvxeysolj
	GhmeVAjC8j+cfZC4E7qRYb3spNQ+I6jR4Ng6Rmkez/gnsx6EE32BRO+FT7QasiSF
	M03KF/zS5ny7DZvc4TGN0cJSfIF3LfW1j8ScZeNgvK3W6BUisP1J/yBxdA9ABH8l
	6UtcxFMp8YLtPPeHPEb6Atc3n4cBn7Fod9aoOKWT4C90M+4RPQt1AS9A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh7fnbtv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Tue, 11 Jun 2024 17:41:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45BGWw50019894
	for <bpf@vger.kernel.org>; Tue, 11 Jun 2024 17:41:07 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ync8xj307-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Tue, 11 Jun 2024 17:41:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rkh4Qm140WjS32jFhmu2B5X6tpNYZFQDAX3qiBwTUmu/UB8VKxjAflB7Y//Jm2PQcHvi3FhbnulgagLn1i9q68kq8AeMhbaDh9SGJw/pfwLGyUCVeEXqleaZQXY/O132SAi0itU6ssPr+eZgKUB81kpOVaT5oo6chGZOUJCQsY1KYW4DCVV99igmnDVOrJ8lufS1UzSZCFCn+gDtcbi59KZkxMKhur3zJU6GVCybnp2E7KdM4WlFfVlYTvqjERkMVlH/aYWMqjaU+tOzRSjo5YSQeDoQlxCHQ9bQcefdkSeirKB19q85juLqURE3IEAc/vCt0R71ZU3Vz98FoELNjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjV0J7ymAZ7xQsYrVAyJEpLkyikfPuSFz5PblZvIn8Y=;
 b=iRcfBCqEw/4qZJZznwtaslhG8IGP8EQmNK3GqlyB6tGqzIHde/d4rvBM1KTmTaWkgsjU5ssHzW7mLymx5RjhlNJ5talpNMFSL4bOhgLOz5iz0hJR36dxcKgw+4b1L8B3bIiTGGlT2uUrRv73/A++hatjxkTXy0egJqB1i0X/56cXZNTa0/3w1QX+8dAbx+Ncb2Ie+zzO4vHHbXG+yrarVZOAPZaxfG2V+mEFcHdtkG4dTcrBXsS78/uMJlFa31mWkOJcrXup1kozkbFvs6cPBLoXfBcPvuDz5P2MagbJpRCiiACg2uI2y9z+hyNUmsj7ZnDYxCxnUXmkTdsT8d0/gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjV0J7ymAZ7xQsYrVAyJEpLkyikfPuSFz5PblZvIn8Y=;
 b=GS1uCz1QGywXqQBkwLf6g2PY3dLMkZDN8e5Q/lndn8AUXpzilgHRucUNiYA78I+/3o+sBpGaKs4zbMfhv6eL5p4wb43yjnSokYTa9jsFmVcCnTcO3glyYYzEfPU/ls/2MzM27tbPokjCWhcGPPJibZq56bfNz9JHRcGVOapBOMY=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by MN2PR10MB4125.namprd10.prod.outlook.com (2603:10b6:208:1df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 17:41:04 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb%7]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 17:41:04 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>
Subject: [PATCH bpf-next v3 0/2] Regular expression support for test output matching
Date: Tue, 11 Jun 2024 18:40:54 +0100
Message-Id: <20240611174056.349620-1-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0293.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::11) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|MN2PR10MB4125:EE_
X-MS-Office365-Filtering-Correlation-Id: 9da0ba90-23a4-4a09-11b8-08dc8a3daacb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ohrxeGNltJ81w4jk/VqPuDdMak1J0LaS1f32T5r2fBBw/V8IBjIqgupelegY?=
 =?us-ascii?Q?+f+tcMcsP0ehKmE0lXh+T8FhBoEhBmfyxUMpOWRdV3P8cy69XmwRXBS3ZPwZ?=
 =?us-ascii?Q?1u4o8FWoikTFHLooBXyjVnvT2blXOKl16YP0CUxC9SI/oU76Bf6duT0fBQTK?=
 =?us-ascii?Q?Ugs48syn0n/rTKkzAHeag/Xzmg14AiHjEPuLv4iuPVopULgK1bfZnkqZuLga?=
 =?us-ascii?Q?IBzahBYvwM2v8MZih9izn+CmUWriiF3ePwhZCf84S/hbth1S5rfGbVm7FODe?=
 =?us-ascii?Q?s3K82a2gAqP5CWD/Fo1WFi+xdsAavbZXrZOCOR6FeHsIIhgcRHjrsjU+mFeT?=
 =?us-ascii?Q?essGODqOszalJVWNzSJfMxdLQ5Q+eQPNl1oS9eUPoEIGN4hKe43HegVeqtP9?=
 =?us-ascii?Q?Sl1GOfl4rl16UfZc+H7vTt0u4j4xTIXCRytHe7rUFf9DXq1yQuh48hgbAPRh?=
 =?us-ascii?Q?6xcHMCg+mj/RHYwcQZ580LgroEJQJCYSEnBTbjHmqelvCq6nQkgMTGj81sh4?=
 =?us-ascii?Q?IzumnJpqzjAXrQb6E4OL9sMTuHJ88zBRXpjZ97UuhUEqXm52xrAMznJEgIaJ?=
 =?us-ascii?Q?cG0Uwsqbv/MSOxIHb/BNKKXPe29f5J/v+3r1VQKDyFwL3tyyjWcnq0e9d1lk?=
 =?us-ascii?Q?mPewDk1Zevd6izfJ8/kOjN+nvfqocMZZlY0NZzpLI9qAH2bMT2YLRUQCNvWw?=
 =?us-ascii?Q?YpBZ5l6s33NPVeYPrVNfXmhSbi8OemEQMVKXdi52wyRnMwUhczKbKNSeDXqk?=
 =?us-ascii?Q?7NoiXJoUZo1DuTlUhZ95mHsTl1oAyh2dnmLXRuXQn5SKcr7uPLtSGlQXWXo7?=
 =?us-ascii?Q?yhDUqqF9Cqnl0hpxyIGbDU/9WNlF6nUKyZ3FinnLyBkpwWXp5brKU84Vl2p5?=
 =?us-ascii?Q?ONCCKq8G68VBMiNtnJF+mjCCK0SwfM8tJxuFR6gm2jDTG6VJHetMMQi7px7O?=
 =?us-ascii?Q?q31Iy0DbDwkvO2gqHtWl/aDLmxF2qRcn0lnrisNEdaN5+4Hu0dHYRr736JIQ?=
 =?us-ascii?Q?3lrWL1H+melqk1F866GrkJDaADIru2ecrM8rd06XWjgte9TszqdgzEgnVU7/?=
 =?us-ascii?Q?Ywhdhm5UcGLAPeMmaC6Kk+jlMliMROSHGwo6SyyUhMsqpym9pTFlR9yveGfl?=
 =?us-ascii?Q?x09XNZ/TBJ4KSp2o7sKS+R/GnRN1BGxlSSbGw5MiRfu7Di39sP6pMqyOglMA?=
 =?us-ascii?Q?4Hdy+Qw3uvpVEPC5CzIRB9r1UJoVahpv0eOxNZeT2sdl08e5nDXEnNr2Nce/?=
 =?us-ascii?Q?7QFfTr85ese731g4OP2ZPTIiOgwT59tX11iv98px8J5sdIgCai+8H84AhBBi?=
 =?us-ascii?Q?uO3ijLSrvcWBQxVItpM5J7zi?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gmvhG8yIddjoSKM0tOSixP213IG5CDlPE0Xc4BS12FQ0n1B6MWOqQ7kfPGVI?=
 =?us-ascii?Q?v+ywBE9Pe2uOC3XMXe2AAUgA0AcuWgzCDtvk2Sd1LDVOEG/OL8uGlKmzOYod?=
 =?us-ascii?Q?nRoW8is1HoVp18EaEECpCnTnD3OIPXClq+bps7GQ8N19IlLWGdVyBQOcHR4b?=
 =?us-ascii?Q?MBsAKjjCig40BAzMUkB65B9VMAh2IOP+lHM5H6q5RqR9O1CxcWgRR3jgor2c?=
 =?us-ascii?Q?j+bOcuMmy0vB2/3HE4BgsCF40P1b9hE1USjSjWd1zQ8C3JeYD/nI1JI/6Vry?=
 =?us-ascii?Q?SXr7voLXAC+k2/8o2nGiOBJSpJsTr978tBvGsr6zvBI062D5nzUc2yNR+hPa?=
 =?us-ascii?Q?QZaoHeWFGLThxHsZggkWQIla0RbhTXJcnpZOkoSoF6j9uTgWsNJ+Y2Np4cr8?=
 =?us-ascii?Q?vREsQyqq+HnnjoULvv1EHjQwseitvRrRXlfd4Vy8DgneqSiMjZglSjoqa+9W?=
 =?us-ascii?Q?nzVe4UxdP+kx3gBNAuPr6/+tYxKHMs/toNhE8HqiryY0E03/WHxh8B3qzWcm?=
 =?us-ascii?Q?3DsotZHRUKVjN5hzylHtE2suLlJ2aeielPcCSzIgzip9fPResummIx7tNCqh?=
 =?us-ascii?Q?SF0A/Fliar18z00lHy3oOspHlKj3Z5wyxuNNV17m2r7mG9vJ1QbULQOOuvlQ?=
 =?us-ascii?Q?VciDRxBdF09I+dAFXzkk2fKGjbDblDmcCR6P9N8sZCJl4YXTP5eoMBMuZvLm?=
 =?us-ascii?Q?iGx4d2Bh9hRALnwpggyhvIqA58k3DtRzn97aQWJRrYQ3ITZlggqNQ9fLG8Lj?=
 =?us-ascii?Q?CBOgZ/6rJV9YC6IB5qNzHJFY1OI2QCzh4HA66quE6mn2P7TvUR4pgZH6ojHo?=
 =?us-ascii?Q?tkXTbPJfVH6gXSW9npB38kHBl/Y9n0/dyZ/qn7zU40BHXOVhA0HI0tZdBAxp?=
 =?us-ascii?Q?gfb0gKJ6AuzZl4Mx1u2nohMFsUrMDHBSrjCu0LDIubmHATIj3LUGIUSPsJuv?=
 =?us-ascii?Q?hBWdVRP3jfs8AP4iyDUZWnyt+fVImmP8iUDlpbAw/3Cq+SbEtPBFSOWHsR8i?=
 =?us-ascii?Q?i3KU2Ov2IX/+xk+m8wN3cvamKR3Mej5jYXQp7do3tNhAsT9QXuDnNaDKVDkA?=
 =?us-ascii?Q?aCDsWvvmzSbjiES5Y7m81Pta7lszy27tdXUcon5O2vyjLHQF6WHW/2atE7DP?=
 =?us-ascii?Q?vFjMWXa4BDir46dyvjz6okN6cCtQxbb75XZ6q8lLVPbY58DYGUG0AJ2bEeDo?=
 =?us-ascii?Q?QZOUWcXsEeXjeMY8Kqugn39Smkg4Y3HBkIbRNFop5gHXk2P+Drw9vjyhTRFM?=
 =?us-ascii?Q?s0Tdp1eiDMF7U/mCsGLU6C5iJOXu+EEujVpNwgWwUBFD4+nbRPRUG7FpG0Nn?=
 =?us-ascii?Q?QEZgYGE374bWvQ4wtNcmwJHx3Xq/MfIh7oDsLk6seSCVQWZWCbmdgzLA6R/z?=
 =?us-ascii?Q?BUnW6taR1ZdUDfBWwI3nL1fxGZqlt1IxzzY0SSQ06x5lU84GF3AeoBEmgFx8?=
 =?us-ascii?Q?Rkfj2Y37OOXc7blFP8Ed+jQ92JMhyDUA6bGyXx6b2o9aZnyjFIJBHZp3Fn7h?=
 =?us-ascii?Q?YZ3g53dFxVhXK6ryJZ65WahemoI4CJeSsg87KWhcWIhDPT9apCiogYGX7aY9?=
 =?us-ascii?Q?9Vm2PZMA4p6lSHxUUFm1TTxKFgI+qsXhimq0dE2OqaNV0daZFysPsVd/ZXrK?=
 =?us-ascii?Q?WhvFrX1iipDV7DTNoamzI80=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Lot2LoDimGEnTgXbFBnuekS8PN3fmDELHvZUguPzkHyGGrNVdj2HM+Rt+6Iij1RqA0ZK8jqC6VHK3ZYxzbWUrT6pUMelT/UGLTefqgtWIShidI58u+TbVuzt1+0KjuNEepeM4XCSXJHbNFrj2POMBMQ8cqkXE38KRG8MSMyAWnNFwycYKHinzAh6cE4qF05Ib4DGps0IhKyyJc+P+mIzlVVCECyfJ51Ld+zX7etP/dgaZ05ZGLh/qoXwdkS0Wy5u/oWwiAe5RLxOyTDqdYKC4/hNS/xVH2nU1zMX6DZtrp7oI12nYWVLnroljV1GvqF4SUmR8uJA8fJBtk4zaWDWAhArQpCpuIC2summ4sVoVl5LfJ416cBbJV6qu3SMuItuwdWrjZewI+U9nd20Z6VkrInVTRX88YKLia4si7JeOdU2xrcrskutikK4T2Bt5mH8ecqLXQXcDz1hiVu2rla1TC+3KTBBVNjnWfH8gEuW3wtZWaDuUZ7o7AP7I+6x2gf1KWBWrqHXL1SJZh7/KUXb3xKi+pgrtgbkvxK6VboCCv/EBm8MMy2TlPEDlHlDFU3FPfOYGJos2O68xka4rhp0kVMOI1dGHkddhJJ/KWcV2JQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da0ba90-23a4-4a09-11b8-08dc8a3daacb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 17:41:04.4187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QaVRRd4yy38/aIY9FX8A/MVZ8SoNa9uysIWEXvvyAdyvIB/u3LEHALPk2jHr/Habw+bZNUk2Y4ChMGc4gkpTTfy42M2487kH3JT2HCP5aGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4125
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_09,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406110122
X-Proofpoint-GUID: Vlbxl38IouUBF4q-k8RLzoAFlb7deVeg
X-Proofpoint-ORIG-GUID: Vlbxl38IouUBF4q-k8RLzoAFlb7deVeg

Hi everyone,

This version fixes the patches based on Andriis review.
Looking forward to your review.

Regards,
Cupertino

Cupertino Miranda (2):
  selftests/bpf: Support checks against a regular expression.
  selftests/bpf: Match tests against regular expres

 tools/testing/selftests/bpf/progs/bpf_misc.h  |  11 +-
 .../testing/selftests/bpf/progs/dynptr_fail.c |   6 +-
 .../testing/selftests/bpf/progs/rbtree_fail.c |   8 +-
 .../bpf/progs/refcounted_kptr_fail.c          |   4 +-
 .../selftests/bpf/progs/verifier_sock.c       |   4 +-
 tools/testing/selftests/bpf/test_loader.c     | 118 +++++++++++++-----
 6 files changed, 109 insertions(+), 42 deletions(-)

-- 
2.39.2


