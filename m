Return-Path: <bpf+bounces-28773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0023F8BDEF6
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 11:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9005282914
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 09:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928071514E1;
	Tue,  7 May 2024 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KA1bImir";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vulPBDRL"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8A2150997
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715075426; cv=fail; b=Qc5iDek604mQllINgg1hNqAfIii+wUOfqMtTahxM/32zVzbfEKFV0wNlZhvFOR7DN5KQZmwxFPGXaciSscsCxyF4pNAe+Hesr0dqCQ6GkPIw4SP001GR+SZfG3d5L/68qyVitS9BYgP6I8Jz16b9eaRDT+uhhLe/rXr2u1nGMUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715075426; c=relaxed/simple;
	bh=YEBoRsCXkBq1PXJDGBMAsVT5lPMW3pJbBYdA4AWFxeM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bJOdNBWW/gLUKz+m8hWM4ze59qwVp+mkOspEZO5zcet73UOH039bm1N2f+YdpwejU4SLd/PRytktm/4F9UC9HlkNtPpULmx8crVKnKp41K0RabB+Vp4OiR9QQEkhb5T00kmNzsYo1/RKJ8xPZlNza1w75DrGBZOazkcG4C/cb54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KA1bImir; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vulPBDRL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 447947XI016601;
	Tue, 7 May 2024 09:50:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=e0dqH2MMFSY5Zk3V3A9O7FMTaf8Ku+8pkFwyb6JTV8I=;
 b=KA1bImirIwzJebPXwo/3xMyAw/PLb+oDj2HdLS0qPwtvMMXsWe54LeT1Rh222DW8iSzC
 Vlkef0yXvW+44XCsyZfr7plHvqxvZUPSkcD4FLLjgXG8Zrd++K22hxJ/mnoLbLKqKVVa
 fOUXElfS22bu8Svv8qQhOiPrHCnlFgqCbad2rw9RueAPHClwclzzK2VUYJlSiRTgBAW7
 C2CgNlFsTneTPmku7K5uzy1WjmBu351avkF0stQoXZ+r/p0R+a4GOikFPkS7ZYilpYlB
 yS35AzHQjNhPDELSGyPJuYPf/W7ZUBMZWHz6jylS5rEMXb8g+MFLRkCk1PHQ7166x8i8 GQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwbt54k8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 09:50:22 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4478uaFO027556;
	Tue, 7 May 2024 09:50:21 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbfe11m6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 09:50:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbtKjwa1JZ7AMkt2MJdjzk7caiP11H86c3znYgZqTcYa9KTv1gxwtAVGyv17kAGmQ5tUxjKrf6SP5p+xx3giwS9PqJErvAdia31vIn7eNRRMwFIOSdjSoBdKtjA1k+THpNjQ52IwpfpcgAvqfC/LYnrsonH4UcQBRgiFj0HkSQzPOM+jMW4oYGWu70ePpLAcjtpPD2jc37lI1rn6f4qqOkYHqDxtbnOOLh8tAJrud4L04AtwlEmnft+5HKl6Lh3F0jSBbVy+iU3zGpE9eauhXREQk1fdjy6KSk0kR6VkJCgRGDTcJinNHV/Wnn/TxD/0eI7e+xkH/h2/KobesiIKHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0dqH2MMFSY5Zk3V3A9O7FMTaf8Ku+8pkFwyb6JTV8I=;
 b=m+kXJPFqMJy4t8rmprDMSkXZmTgkE19rKam0+v+9hLL+rDhnY/xQLmlCgnCXk4gyuL6VDz+OkCuyL6oHhtJOZTr30MjxJHcwgfccpryO1kitpwq1/g0KIqOqSohROl6gq3Vjljl8woQaO4RGKXYwZtFFZxywj5YIOcnUzDu7aR6JBC6rqq8zpxd6woCy/prB3LswJP20NSZAq9BR0VzSJCjKrZcnuup0cNH5NfGoMhRU7EnkrBRF/xskmiGxGMwLyGcH8dw1hHV9AaLaONTvGCBfD2pkFz5ZUBZ68XP/iXDzzn1+QU1ozE2EmUODyQ4mGfr/Ztz/FykynSjyRrG9gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0dqH2MMFSY5Zk3V3A9O7FMTaf8Ku+8pkFwyb6JTV8I=;
 b=vulPBDRL4NxAZw/A1u68cp6YLOzYAIzNTgtMtAKDSjbXQNcxaP+Rv5PMFqVRI3fdkK9KcvV7aSspVKNmX6PChe3DoNFZ/hbVTbNsVH9JEGYinFUhVbxYxZB4OzGPRfw8auzKKQWXB4oqbn6VHQsQD4yb0rct294iSrEFT4Z+xuI=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by DS0PR10MB7343.namprd10.prod.outlook.com (2603:10b6:8:fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Tue, 7 May
 2024 09:50:18 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 09:50:18 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>, david.faust@oracle.com,
        cupertino.miranda@oracle.com
Subject: [PATCH bpf-next] bpf: temporarily define BPF_NO_PRESEVE_ACCESS_INDEX for GCC
Date: Tue,  7 May 2024 11:50:11 +0200
Message-Id: <20240507095011.15867-1-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0006.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::12) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|DS0PR10MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f7d197e-aa39-459d-6e8b-08dc6e7b1a8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?HBUuAlbOah2ohzsUz6evXho1UuW8kjHqVExSmi/w9pp0n/J2eZkNg86A2UYN?=
 =?us-ascii?Q?+rm+hhS3JcmD5aFb98SG1A4wAheV7jgTHWSE5NLmDY+dPHFqOsz7AGUMuCqV?=
 =?us-ascii?Q?eJqNlK5qRW+pvLV4Yaiy54JzBYrUJIiPDuAfsc3+pALATebOzR53BaSATcX4?=
 =?us-ascii?Q?L+ZkeeACIjTSF116QY2j4s7hH+NBlbmblHkGkJ6RAV5dItH0crXsytAx+/Nw?=
 =?us-ascii?Q?Ax95HmgmZOOumIw2By40HGD6ApJKnsm4oQHh9wMqzuf1w6QyHgDX63LP8TQT?=
 =?us-ascii?Q?BusZr9cYtVtloVhO9EkTwFncfnFMCVeVgicWQvlfQsu17sVDcqi350gICp3R?=
 =?us-ascii?Q?Rfo5cxVX7cNpAWKdTpd1zn6iCvTmrejX+s27yoIq8f6eovi4L9d1csgYiURh?=
 =?us-ascii?Q?5pdFzFL2pscg7GsHdivt61ObzE/mM9iJlNDP1B+Tfvnqtv+53LRVf4yP7rge?=
 =?us-ascii?Q?39QpflodF70sPSniYYfS8B10Bdpfos5E74atpo3Z+yVl6utz1Mps6G6IWVLT?=
 =?us-ascii?Q?fQMRe17A+PHbgvZ2Bleqb3Kgq98qFCCtaVvnNaOUIz1XLiMVgNAOU33gyBFL?=
 =?us-ascii?Q?GesEP2tRG9M6w8gij2McYzd44tFUWMt2X/79XDAnOnRtx7WlRmtsq83Fju6v?=
 =?us-ascii?Q?YK8INF4pGjXwE2DduC/hFopKXdq4aM1vgIaOSH0Yo1X7Vva+nGHgQroAWcUJ?=
 =?us-ascii?Q?VUe9o+dqu5FcVbFD52TuVGJ9cO4BwDDp8c7Xdkh3xvwWzjUMNhK7cPd6CXIF?=
 =?us-ascii?Q?4X2+jPj0+mQssbcvaaI/qcXM4kcG6IAZUF8F0cFuPjAyhGt7OQRv9pKu5vXh?=
 =?us-ascii?Q?P/NLB48dpmCYXoNJ75QDrc4r+fTXxeQobOBvmFrxvp2jhTjDCTA2BcDCg9ZA?=
 =?us-ascii?Q?c5dnbuDFlk1DyB0nsjTSSSj8YNfqKuQIsYZ2wMoKYrUq/aF6Injdf4bSZ2WA?=
 =?us-ascii?Q?uL7UUvG2GDAUNxds40kkK2gPasTknahb5v5vXznQmW6z/jqmcSHFLTA3YNr3?=
 =?us-ascii?Q?F6ZJ0nZxApq4PW/T2Jt1JtLvx77Nu67yXJ+IJfnW4ZUwxcWiFqZgfSNEZgeq?=
 =?us-ascii?Q?a9XJfGYrpa6NC5dCIAMKW8pCZn4rltHrnItIcR3LrT5DjpkkFUhl5Z8M05+n?=
 =?us-ascii?Q?2LsUxssDJRCwyqhGwXT67RzX+CUqI0BWbKnKwFaffx1AhDmYWzlAp3KV5zkY?=
 =?us-ascii?Q?KIXNJ67XSsCAW2WZv4B/CvDpdDxtTBX/bcWOMqBS6T+GoXQ2zh4Zs+OZGzM?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?x1nka1vAfrZ3NEZ3uegL1SP7eP/iIFOI3mPZtqEjSjhYJYbxDhTvjL4+8lE5?=
 =?us-ascii?Q?z94tSiGitQt7WeaP1Q1TU7BTR+e+RJhZGJDhoJupSt37juEAWJ6m0fiSrg/X?=
 =?us-ascii?Q?qfaMqccmhW7MrK5zCaJyOtbCKPHSItylfjvfl9vKD/0F/LSlQ+L9WuQ49Q9O?=
 =?us-ascii?Q?WC3OGoWQrXvOKTs4vtRFsfoSF6uTPKHiBVSV9u6i2eL/grLsnp2QTNkdrflu?=
 =?us-ascii?Q?kqe/8Ixinc8RuG3ssDv35OVUzducZ6ZzGFsMGQT4seDluD6xlTccQNO439ls?=
 =?us-ascii?Q?HkcL8HoyjAxdmQOCwrRAQwCt80pHJ1hivcHb9Ns/CgIbXQjuyJBgtLcIl5v3?=
 =?us-ascii?Q?Ux581yAtspOfGtIoMEDX+xBkcvUZTAqj4OzLrxEHGpT1QB0UOffjB4L1lgL0?=
 =?us-ascii?Q?Wuab4uQyDden92XvmuRNnSsCQLrjG5kaP6tYA1KTFltA2cTXvFSlDGYkzJqF?=
 =?us-ascii?Q?QJiS7wDNITbvgtAhURDfJblMbKyaMK002h2NZ9Tyz/SqOZtLczqEF5diHxLR?=
 =?us-ascii?Q?7+XBO+hJ+N+tCoWbcWKsk75uMdIADmMuNTHBDc9KMsHOR481Hs8x2UVv7zSK?=
 =?us-ascii?Q?bUFQxYa7lAOTGzwc9TciugnTnDY4ubsIOTJcrodribQ5p/WlVs2L5wAw0rL2?=
 =?us-ascii?Q?lkZqeCClxwfXE/WFJcKgbP7ySQOkdFPDa1Y/MHngTb7v6Jt+w0J1gqoJWHkp?=
 =?us-ascii?Q?k8NYP9+pP0uFnJv+wjl2WN4kM5OoU8Cw++40oEx3Xl86vHi8m3rrhjXZI4ST?=
 =?us-ascii?Q?8DMK3iwCYki9UHn8vKlwi1QEjYQPSRIobuvhrrQaMIT7UptqMgSd+6+V1ywE?=
 =?us-ascii?Q?kV3Gotz+2w+Qt81jtyiwA3gFV29sm7MPWDxr/kfQ01KL9rf//JmspCW5sQVz?=
 =?us-ascii?Q?fntGIIT6yez+qTN98SyGCMb9HetF1tb8WeTN1o9nnouXLRySkA+Fr5qcpzs8?=
 =?us-ascii?Q?lFiaUcDbBj/DnEK+ZGnxSaz0sOozrE46iUMo4eZ8b6jX0BJoOW3uK0MBXTop?=
 =?us-ascii?Q?gYC3mTugFtDqnVLGKTjF0h6WWi0dV+493k/daaVPbtvc6EZafMcFFNn6t2/A?=
 =?us-ascii?Q?5tMRZ99AMtWC4m0zPXPsbGrElIMdt6Igb7FTinHOFhdZg8aUIGYgH6UstUKi?=
 =?us-ascii?Q?r10RNIFc2u1qUfy8REi1f1AosXWGTMC6o8vQ+bBIpM62VlZEIPpU92knrwwJ?=
 =?us-ascii?Q?rlooNBjAvOg7DEyndRgirBkmferaH1LjxSILHB62CodBgMOpL35NsjD4oYNq?=
 =?us-ascii?Q?rQ/4UM4cMmWoKZf/eygtK9CcHgh8j+9xTMVoQeXrTtZuTO7ztMI6FUnRLny+?=
 =?us-ascii?Q?BP9IRPw+5oIvzQ4YG9SHkwjRepzWT+jLMNyyf9/RBuBTSbAYB0VRCkJbw0iV?=
 =?us-ascii?Q?/PXmVTp0BkjmPo3u2NT1MGHPL+wF/2QhzjQ3CzUIIMIvRmlbiI6yz64rZfsS?=
 =?us-ascii?Q?3wsAZnO1+heijZFLo3rsXAyaj3LZanodx0XDxSF92YI/uSzkZOj9DdJG4SAK?=
 =?us-ascii?Q?hN/T5FZzFVHHETJTAza/s/o10lCJ9L1KuNqrzReCDIxrmolDZZvM+IEx6F/m?=
 =?us-ascii?Q?RlKi91/nZGG4bar3tgy8hZhin6Vc4Ly0OrMzDRXkZbw/dHolemE5jv6Qb+H7?=
 =?us-ascii?Q?+w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	rw9BXInmkdIBjvF+VmeKgPunfTdV+fo6AgN4GVmXK0Se31Wdt+QZabDy8L510X6gPXF8tX6x9owWJzv9ZuqAq74vjQCOnPfCTtVQglffc2EkA3VwfyLdV14PCyIczMX2D8PdpY1C1o5SGP/Wv7ccbIQp2yeBCS3n+z5fgLOnpTxMuqwxuC6nbv3/92bDrG0qeU6GSz+EjlkEwL6zZctVpH2HteoCxpOAo/YZ01Efjc2e9N01WixjJZC2BNpgnGhIaGTh7xMrzBim5kBzRPSNj35fn23D89tBXwN6MKTZCws1xwplqrfFhPG6/I6i3zbKDjFhYhdsaWRnL4x4Y6ci6jIiypKvfU1k0IbQwZrfaeHEdUQdU3z2VevRu9vKbdf1X48/8YSGfBOsFBY83WIXFJAN4RmqUc0NDIZtcyTMzxgizxk3LkUlJUxfgUeS/Cm4KxkVUS9I5tEHpoo1b0yAQl73Eptlqqkxh0I8Ltiu7qxGTCOjJCsL5GJt/yC9iKmD954FimbqBiHEfhspUl0ASTl4IT/t2SnrqnU3DjyalaufcYCwQgTmZoynMEXcHzTEufx9N2MW+g1OyegTyQ4SR2rPsP3aUy3Eq1IDF/DfwXk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7d197e-aa39-459d-6e8b-08dc6e7b1a8c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 09:50:18.7133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BoKlpS1BcbwQm1BjUg4tmNOk5/0flPiq3YZzT5bFk3qTswYVDrS0ASg0MFjM0Kh8OKnbCM/AYVIjOm85XSaS3qmNKzEY26493nDqrPrJT4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7343
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_04,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405070065
X-Proofpoint-GUID: Vq-Ij7rlzW2eC4d1NBr1rE6RC0YRT2W9
X-Proofpoint-ORIG-GUID: Vq-Ij7rlzW2eC4d1NBr1rE6RC0YRT2W9

The vmlinux.h file generated by bpftool makes use of compiler pragmas
in order to install the CO-RE preserve_access_index in all the struct
types derived from the BTF info:

  #ifndef __VMLINUX_H__
  #define __VMLINUX_H__

  #ifndef BPF_NO_PRESERVE_ACCESS_INDEX
  #pragma clang attribute push (__attribute__((preserve_access_index)), apply_t = record
  #endif

  [... type definitions generated from kernel BTF ... ]

  #ifndef BPF_NO_PRESERVE_ACCESS_INDEX
  #pragma clang attribute pop
  #endif

The `clang attribute push/pop' pragmas are specific to clang/llvm and
are not supported by GCC.

At the moment the BTF dumping services in libbpf do not support
dicriminating between types dumped because they are directly referred
and types dumped because they are dependencies.  A suitable API is
being worked now. See [1] and [2].

In the interim, this patch changes the selftests/bpf Makefile so it
passes -DBPF_NO_PRESERVE_ACCESS_INDEX to GCC when it builds the
selftests.  This workaround is temporary, and may have an impact on
the results of the GCC-built tests.

[1] https://lore.kernel.org/bpf/20240503111836.25275-1-jose.marchesi@oracle.com/T/#u
[2] https://lore.kernel.org/bpf/20240504205510.24785-1-jose.marchesi@oracle.com/T/#u

Tested in bpf-next master.
No regressions.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: david.faust@oracle.com
Cc: cupertino.miranda@oracle.com
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 5d9c906bc3cb..f0c429cf4424 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -431,7 +431,7 @@ endef
 # Build BPF object using GCC
 define GCC_BPF_BUILD_RULE
 	$(call msg,GCC-BPF,$(TRUNNER_BINARY),$2)
-	$(Q)$(BPF_GCC) $3 -Wno-attributes -O2 -c $1 -o $2
+	$(Q)$(BPF_GCC) $3 -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes -O2 -c $1 -o $2
 endef
 
 SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
-- 
2.30.2


