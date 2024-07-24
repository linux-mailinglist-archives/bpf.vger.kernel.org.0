Return-Path: <bpf+bounces-35540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F25793B58E
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 19:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 665CAB23767
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 17:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36788167DB8;
	Wed, 24 Jul 2024 17:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D5YvkR4v";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TrqL8Im1"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9791607AB;
	Wed, 24 Jul 2024 17:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721840763; cv=fail; b=ACv2Y8Y8ydh7gRaS8tdqRPEscSnugTsIuPhh9p/5CW2Jy8ugSaFsYgqR442fUlZrShhjRSaBYjH7PcJhBnJYl794aPbVo7o26yVVHOS0K4dTlOoL0QW3E7uHh1XlJrJIFyVLDKQojsdJowfmgfQgS69duxi1blt+KPEOb7db+5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721840763; c=relaxed/simple;
	bh=36tf0Aod5/IVAFhlX1B0uvn8z9k5jMHExaaYY5Jr8kA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BRtyFMK5DIw5zKsbZYDlYh1fQ+JRmT/yLaokIFZhMiALCvQ/Y6tabEAuGV53wBou/vScn0tKqzLGEdk495myEui2qRLYbYlcrwUQevediyflBD5rKEongKXhmsSA4tmXWpgRpcwjC9U6QEA8pinBve+j+IdgH7UyFoOiRwKZITc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D5YvkR4v; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TrqL8Im1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OFXpVT029449;
	Wed, 24 Jul 2024 17:05:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=4T5vjNkydZ+swpxBebzgijNbLUdXmfKunxmKljioqSA=; b=
	D5YvkR4vsDmZfifP0rOx8tVmi/ojL0BHO4Mc+VBcZX5Z6ZzOYA4537itU2iATOsf
	gYuTeMhvnjCZAx1feqMCrhCeVcAxMqCRx2/wPHfwoyq1X+olmh14Mmw2AYm/uJtu
	RxbI4BwwK6YaKtz/aLWvPqFc0UNItT8qGwtxYzwFGd7ww7UVw4Gncupyl9DYquFK
	mR7pplu4BM91emELkzW6jPb/m0Id6tunkxP8F0FKdQeR77wRKj2ILOlqb0PJ34Vb
	ifXYn1NFUWmK6lJi5VowJDWhouiVRCuKynjYhkv6J3vbHIVyHOMu1z0YFL4uBf0m
	bPBX1jmDd+AUeqeOR3bBig==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hgkt9gh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jul 2024 17:05:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46OG55PY011094;
	Wed, 24 Jul 2024 17:05:33 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h29swyjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jul 2024 17:05:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGZuYUXRutVZ/x7lsbns1UwE2/5WNIq1FzE8ABayPjAI2kyba8MlrNBGYkgnTsuvPNo6xOZ05OlASZjziHxnaIIXi34NKQaE1bl6ZHDFSi/bCO9SNnQj89cqsM566p12EdFKEBrt52C33lJZiR15lgKIDchZwXRWM64mj7UpjyNrihEZ3Bo7Wd1Kdw9trrOvYrcGrIrPFsS7fEkjYWspkRs1ojMBVfPxKuYbsgi6xQFdTiUyxOFk8ujqOICYm/0fiJpvgmfRYzqyzVdbNP1o5iyZV22rwWHz9/J8XK3G1WrWdkkpPlq7mM7whfA5C2k2dcV8n38TZjuhAfKArtwq2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4T5vjNkydZ+swpxBebzgijNbLUdXmfKunxmKljioqSA=;
 b=fm5rqxjsm2Uj5f7SbChq55KVgOX9HgBjs2kuqislx6yMlG6tqKOwr/AbHC4cdMZAuskP5AfzWL1k147+ZV0ILsY5DbJZVKJN9xT2+dnzCYVBkfSx5/mQqE+NeVeoG0jWVRude8FjFzd/vqVtXQqRlg+I/Z/t7Eh5BDNgx04g5VCuURLNREF6edJiD7I8n+KlPI88KnObB7O8CF1mUspgu6rfFXTUet78aihYBlZ0KVqxH5pC4FQcUqS6k3Vw4ymLKo/tkAC3MlXfGI4MoB+jCbT1z1N4gUrp1yg9g4/jQ+gcG3WKWcOWQkBsvfyx9j9Z3l3IOsYSZOOhYcRGxnlbxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4T5vjNkydZ+swpxBebzgijNbLUdXmfKunxmKljioqSA=;
 b=TrqL8Im1+opKA2EAfk4ujkxJEq1nqRKPWHxEWIR1b7wsvSUNNAhgHBsMZAJKRxb4OLrVz6W2fnzctLl95PHZ7LYfDkUw/IsJF5nPrY2WG2nxWOrWB980L8m6K1clFh+FFyaau+mHn+eo4zv2i1/W+MmFG+ktA1NxdVLkr0odx1Q=
Received: from SA0PR10MB6425.namprd10.prod.outlook.com (2603:10b6:806:2c0::8)
 by CO6PR10MB5603.namprd10.prod.outlook.com (2603:10b6:303:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Wed, 24 Jul
 2024 17:05:30 +0000
Received: from SA0PR10MB6425.namprd10.prod.outlook.com
 ([fe80::447b:4d38:1f8b:28f1]) by SA0PR10MB6425.namprd10.prod.outlook.com
 ([fe80::447b:4d38:1f8b:28f1%3]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 17:05:30 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, si-wei.liu@oracle.com
Subject: [PATCH net 2/2] tun: add missing verification for short frame
Date: Wed, 24 Jul 2024 10:04:52 -0700
Message-Id: <20240724170452.16837-3-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724170452.16837-1-dongli.zhang@oracle.com>
References: <20240724170452.16837-1-dongli.zhang@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0024.namprd10.prod.outlook.com
 (2603:10b6:a03:255::29) To SA0PR10MB6425.namprd10.prod.outlook.com
 (2603:10b6:806:2c0::8)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR10MB6425:EE_|CO6PR10MB5603:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c439eca-c0af-4e71-0f09-08dcac02d2be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uiD9cFAGv2IFfo1A4GCEN9ztR0UiZ13kHN1s7nL+Gh8gThtIOHRoSeGx2Lll?=
 =?us-ascii?Q?eznk4pCxizvUu9cZXIKObiJNiM6AfcUqltUijuqoYhXUUEWtkNu0syr47uZP?=
 =?us-ascii?Q?qNlFcaIR7HsU3nJMNo0E7xTTJdb++zV3KzHVbuEAJQ527RhWTc2nazmpbSrC?=
 =?us-ascii?Q?4G3oFsjlnN0CwmCnc0VaC/hCpN9/n+D/5thgezwlAj01vle6eC2aAM2t1+dY?=
 =?us-ascii?Q?jINksjgYm3bOs+gybSHQ+kRluceflZ6iGQsIP9gPw6qGoGHzYK/SEbbEQW04?=
 =?us-ascii?Q?TjE4rfnQvjxVa0Nujm6ONmmJkQGAG/JPyFKhKccnfGfr1Y4WFR8yc9matczg?=
 =?us-ascii?Q?11Oo9ybmSDFX9Bt6M27MLMGe0nBKeDZ4WIZCwTZJZYvGcCpg1AwxCwCXHr3L?=
 =?us-ascii?Q?1G/dGI/BQV57jaRdRzpo1KKNQhj2M9FKD7aGAbJPcKGDP0cyVlxeCmFPm9g1?=
 =?us-ascii?Q?7bxRIRm1AzzTL1qFhjVYHC73F6TRxX+pqaxzYm+63EhNX+0Zd4BdaEezPxoC?=
 =?us-ascii?Q?qPNYz7vqZAc2rUcUg+1RYt7iuqqVm9MdcK5LIbgNZ7aEf0yJGNrnigwxy/dh?=
 =?us-ascii?Q?07qPjuxexY5qM5H1XV4YVIWOuPPZXxokURbpqR9Fc/p1z+aYZPCIaBTH4kN8?=
 =?us-ascii?Q?CxhIaysyfaxuccBDkcNwfGy3aUXxS+XlSFExbtk/J/15Ot4q6krUC4nYPnwR?=
 =?us-ascii?Q?XddddTP1ELdGWBbJPMt2s/qfsQu1wwtslvxPqvWd/O5IwE6vsIBB5eZKa+hD?=
 =?us-ascii?Q?S7vFmuegcAJpPfeOMj5BdT9aqLD04Dx+Kb5FUZA0kSYpCar8XSjXbdKOb2kc?=
 =?us-ascii?Q?hnPPaP34ikBILnenIE4xH/Gv+mpXynUtKN7joq7ufn1NnjnYat4leSx9PL5E?=
 =?us-ascii?Q?iAXlZw271WmrzgCuKvlyp2BeoBSfjsm2VnyO5fBd5j/BnjzCU6OuAILaRewY?=
 =?us-ascii?Q?ZKUvOY0YvXOgMjp5rxt25UeQUXbQhHQxmAUH7O893YQBwP1roT6YUy6Bo0r8?=
 =?us-ascii?Q?D+Fpl43DEB7O/Qw1BkY1CDS/CJaiM5F4cRLozqsfSWnQ+W8+U7MBAsTSmvsN?=
 =?us-ascii?Q?r7Ck23hF3jyK8vkeph+pUpzF6G+smJC+HNV0nh7aZyUcOlvwotD2yBeLRwz9?=
 =?us-ascii?Q?NUu2zHl4O2wCKvAN3IUozax7qh6O9A3IVpCnuZ9k/HYxu6SthtVqaolq8K2J?=
 =?us-ascii?Q?ctvndnpm5Q/Mf45maXPw1atDuCPRQYqLF5PpfHmgVPCNrz1xAP5oHVhkxEiN?=
 =?us-ascii?Q?N+goJTiCJsrpPQAQruJ+KqyNQZge3zT4Aj1MsmSzMfCF5XW8nwXFdDuqiAUv?=
 =?us-ascii?Q?FEI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR10MB6425.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vhnnP0fCxF6lRfDV2XEhjFl00YflpvOunTaZNF6e3vKWn9BBEqOUPdZPaiS6?=
 =?us-ascii?Q?Q6vMmcrdU73/fzk4F4HQwmALJYjAdR2JSs57tBHy+aRBm6Y8hTHe/YlKqzw2?=
 =?us-ascii?Q?tPZJKLUc99KO4+McNjd9sJUJnxYNEwBZE7VyxwblzjSDcscDZFWeP57b8npf?=
 =?us-ascii?Q?WhgwX+TJvD8Sj+08GMV4XWZgi4frjBjTJIr4ydgVrNz+f3fUhiRrnLOqKQ2R?=
 =?us-ascii?Q?b4+2Q3qJYp3/FydkVRwuu6J4h4k4ItlDM0k8xzMY2Kojmil7WKGSdLRPWGe7?=
 =?us-ascii?Q?YrBDGALUcT19PTd61eGd4ff1u9yOl8z5q3fp4UHx/MwHY/zqWQwiqbp7kRZG?=
 =?us-ascii?Q?Wb4IMgr959CWyKtIjtnAyPAuDhYyfV3nCOM6F8z5l3QoqABt325SAAZvQgDl?=
 =?us-ascii?Q?1XpLlGVq+4bZtyyYFpfm2snB3b0418fAJJFuJVwJsG9OSWxwT46uQ3n/CWAi?=
 =?us-ascii?Q?z2ik82XgJ0+YN+i2XD9cytTi0RYj1Ax0qQvNAczykGY20D7bDAmlHSd1+goV?=
 =?us-ascii?Q?ADWHL1CBkNiiEKGJKyTcRbt7IviaZau+II92Kgh4nynDVZSLQqJpn8F/0Yh6?=
 =?us-ascii?Q?slkOdfwJ7CFMzKahPioy9ruMI+tRLLnhbEIrWPovmBWvR5IlVpcYslxTbUiq?=
 =?us-ascii?Q?6+TPeL/ql1hmycy381QAxFI+8SDt31Q+ZaFuRWq7+Yhn39QR6WW/r8bQbJ2p?=
 =?us-ascii?Q?ogOQrPRsUb2GWaphx7wcKMSvCo9wVx+mhiwD+WhpD4l4OnvoTPVYK9MjM55f?=
 =?us-ascii?Q?Mp9Pe0prOlz5BSl+pKvDurq8h3syt3kW02FgwSinS5+ZyHcw+ejAl/OAz6yJ?=
 =?us-ascii?Q?HHz0SOHX8mEr0mCOlouXWrSrl9hSZgjPYd4dVIwwrkzZvcXRIvThANdSwboQ?=
 =?us-ascii?Q?yaaOztCYgCPxWhjqftOk3yBxZznVCzUGNB0/qH5acbgVDnCtzwmhp3KPX2AW?=
 =?us-ascii?Q?J0QiUiEOdcJC2Jov6/3zDZwDpX1PBb8rh8dXoySUudebym7PAgx6edclQbMi?=
 =?us-ascii?Q?oVUW8Omq1lCRrYY8rA/y8gSgaMPb2B97RSq6w0XHV0Nx6q8oicv/OxKhVFlR?=
 =?us-ascii?Q?PxVHDVgUvf+IqfVcETRKo+f4WzwbcvZ9ucnsgF9IHiIcZWht6jcjSLsrJCTL?=
 =?us-ascii?Q?TLknL4WHY0PCNwr03M3IIFSx+aOEfoaSrrxDW++zMuRRVMe4kDnrFDNoKv6C?=
 =?us-ascii?Q?crKJ0JoAwWwrZgu19jip39Pbf/vbJE96jdQX3eUz7LM5wguw/UqB9WKlvNmA?=
 =?us-ascii?Q?IxJXwqzHfogk9TCLKa7Xjc14fPN2vAKidxPkpn8ZL0L4zBZmBkzLOKPTdu5K?=
 =?us-ascii?Q?BNnafssGkTPhvNEdJDDppCULWyqoXVzzJ1seBUOjS7de8F5R/KpICRSCzEiU?=
 =?us-ascii?Q?jj/ePLyh1OdAyeAHfkXsAV74rgc9LdsroVj431HnZmR1xmnNVNMsVLv6HM4m?=
 =?us-ascii?Q?mL67FZt3bbbq05z94GT112T2K1etQLaA4YWhm4cXQiZ8HSxWiyMnnzxm6Nva?=
 =?us-ascii?Q?5cHeW1TiFc//TEpX4JDBqwk9eXc+T79e1TmVuYt8N91G5bsepnDkCImwJ6Ru?=
 =?us-ascii?Q?R3SXDP48lPcxQgaiSlCc/CjBEcYZtaqmGyE/uBNB1gw3ZmV0UrAJZlNZJ1W3?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fn4hbuxD3ohu/GrzwTjGz8J5NTxo+0z+RtVBFbAzubAOHJtyNYqpDS4AjdJg106IlAyZYZycw5Rw/keCq4vCm+6jmLzh8UuPIxwfjcDI0ob8BrQ2jdZnXEzFkl6SNpDhi38EwZzUBJNoF85j697Z1OkZeSQoC6u2i2pTejTGzNvYYnuQRxUC8rCW2HfpJCBW/KPAcYxGv3xDehyXbUkvNKq26ezArZZK61MyTv1cUHWTaq8BVkBnqWrCKkjqXwYYxGsfSKBCLAl81AzrNYR0RxuaPSdtCLbbM3HaIOvC0hnJXn7Qu6ezdH/cDCH3Sy1eVHbB8SQ/KoDWknIKXwEm8ANr7cJH95lLnQ62hLFeDuntSssOoSZUc5YAOa8ddnYZslRgr9UBINKbeXBjxltC0IrL9DxDssHl4b5qDNN2VTZ1RXFQ6vFKIZjWwxV8LFFhwqPTAuPEXuaf/q53ZCFIOSnCadw06feAh1hU6qOEoJlpxF8rEgsfiPBKra5EBCe718TrZ3tymkBpi1K9I1Q0ej1S6PHM/Bvh8/xpG/b8x6cxq4OwSv56Lbm+NETRv1EjEX6dV4TAhNZMkao484pZQe1JWv1NlktdRXHUsgCn3jg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c439eca-c0af-4e71-0f09-08dcac02d2be
X-MS-Exchange-CrossTenant-AuthSource: SA0PR10MB6425.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 17:05:30.6557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ptyYtEuKA0Swf20u5aNYuwmIbJetlvUgI34QOnHLOTtmandpyOw6R2jYeSWZ+Q+KtT5jz3GFhH28JfH7/0Npmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5603
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_18,2024-07-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407240123
X-Proofpoint-GUID: d4nYZdFStlWSAIGRFC-bxcTiPVqRxbt5
X-Proofpoint-ORIG-GUID: d4nYZdFStlWSAIGRFC-bxcTiPVqRxbt5

The cited commit missed to check against the validity of the frame length
in the tun_xdp_one() path, which could cause a corrupted skb to be sent
downstack. Even before the skb is transmitted, the
tun_xdp_one-->eth_type_trans() may access the Ethernet header although it
can be less than ETH_HLEN. Once transmitted, this could either cause
out-of-bound access beyond the actual length, or confuse the underlayer
with incorrect or inconsistent header length in the skb metadata.

In the alternative path, tun_get_user() already prohibits short frame which
has the length less than Ethernet header size from being transmitted for
IFF_TAP.

This is to drop any frame shorter than the Ethernet header size just like
how tun_get_user() does.

CVE: CVE-2024-41091
Inspired-by: https://lore.kernel.org/netdev/1717026141-25716-1-git-send-email-si-wei.liu@oracle.com/
Fixes: 043d222f93ab ("tuntap: accept an array of XDP buffs through sendmsg()")
Cc: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/tun.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 9b24861464bc..1d06c560c5e6 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2455,6 +2455,9 @@ static int tun_xdp_one(struct tun_struct *tun,
 	bool skb_xdp = false;
 	struct page *page;
 
+	if (unlikely(datasize < ETH_HLEN))
+		return -EINVAL;
+
 	xdp_prog = rcu_dereference(tun->xdp_prog);
 	if (xdp_prog) {
 		if (gso->gso_type) {
-- 
2.34.1


