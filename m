Return-Path: <bpf+bounces-40802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7881598E76D
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 01:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E87011F2721B
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 23:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09C819F403;
	Wed,  2 Oct 2024 23:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dQj6ZOmi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vThWW4iI"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35774199249;
	Wed,  2 Oct 2024 23:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727913198; cv=fail; b=VGwYioowDmgHoeZHiSYakQSS4L8X5bUuHTOngeBUkw8MeVDnZOw1esTn+V2h03PnLygG3fGQwnYI11nQZgos7QfviUrNtYznaGdvnTka0XHpmzJKwM0QkzLhuDFAOccsCAOq2fUn3/2JrBOHs2q3BBrMnGHUAMV1W4ixqLK3kl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727913198; c=relaxed/simple;
	bh=nJ54YNPaypTPpJbuW6KySZNX5+pOYtAVFtU5ajR2yAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AF8W15AtL/BmU53FR2RU5ADq17W4v5Yi33yRW+3Jj18HfqH6BKWWuOdPzxVUs8HXcm24wRpyC0UIc3L26BNA6powbiQ7UQ0eemZft9xd5z2wgKicyVnBwY85UgnRHUgAKEqiW2oQqytj9fEyvzGg5vhWtcV4VDpC1LabM9qQqJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dQj6ZOmi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vThWW4iI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492MghJe031788;
	Wed, 2 Oct 2024 23:53:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=Bbyzpcs81t4JJ1/b4UtooRDZxXMzXkoXC1/woHpThUg=; b=
	dQj6ZOmicCmJyW23QJ5znFncI5XgWMX7HUxXfUGABug5eXgINZZTpg6wDCgULcFx
	4oeidiUqTjeKNs4qjOVm0YCf9YJrw1zTvh3vPAfFD3jYoyWWKt1KQLYRQV/8Ubzx
	ALhTDBxTpcwR1omFO3fCNRwEmV8dxo72uKvcgDlcj66HXfz/YArEnK+D38/VKNSE
	QE74xYslB4AerBmyTlfl5B6ccDjwKwv4nLg+OhlJpXv6893B5maUgNePK/KODEeu
	lroqtaAZojmESrClOc3/6A/2u6JlDEjLukSGv0YO4VA9Uv4yeZb5Prhn8dP72wjW
	Hw/n1fnTeMcdEmkEBODhFg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x87dauf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 23:53:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492LVZ2A028553;
	Wed, 2 Oct 2024 23:53:04 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x889r8kw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 23:53:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=czkqklhio0ERuv1Pa9Q1sLbBSRN4DPKZlphahOTPpGYI07186a/2s8rwqhpY/raNwDoPWwMGsy+03netCCELrgqj7TlQQo3DgVTkEWy20yIFRit4YtmdBxkWF0YGGmp+LAkEPLqStrI62HvaWe1qTintZVdt/Vsm/LXpAbIWp5Ru5nahR7ivQbUWHUNZePfgiix5GJv2f4dXOQaZIDWEgMiU05mdHQjYoP0i8LDiG+A9QNwZD3rMDuPEz+j7WZ3nk3CII0XKpxNuxBuxYmT9yoNy0J+pom1IX+CRSn9D/y38lGJM70hP4YiZ+eD3II7ThFFOqxylyJTfHQh4mT6PRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bbyzpcs81t4JJ1/b4UtooRDZxXMzXkoXC1/woHpThUg=;
 b=WwjxffJCSsbEAnvZs8ahiTicN8cLXJ0CQRlOExE2tJoTXHUEiIsBcjfn3zMeT2uOBjhQfVWQVILn/Hp10FI84q/4mXD1tSsc85v+o+RiBtAa9ccL3vTatP9F3KtJ6euEAbnbSTAFfZf2wNOF6qozFH89RZqtOfktxtiOoZI8cUfAnu2+xAW/Yy+rUu0x6QVhz+uyqrekf9rDmC5EA5Us+l9mZR1LSZzUd92ZrToXf4cAgR3OM3bCOWZQUzQU7+4fsWEA4Rr/vJry0JNW+iSEDPYS3UWK+B31Thwq/fC0JyrkMhvt7MjZ9hk7gsUGMh795ziW17BFcMz9H4GWp1rysA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bbyzpcs81t4JJ1/b4UtooRDZxXMzXkoXC1/woHpThUg=;
 b=vThWW4iIWW23zW1SVGLtpVeZhal5kNXMlR+e1ag+KYpfD/YOnN6sugtLmow7SbVVN7jtmHhXVsU5hg4hQu7fq+5lbN3PWk8wZAjviSTmjICkCjdfEUruQfze01JSxrKigeHuDtEyIhEUEBVPwT5dNZCFL/XcnUAuvp5iYwjVscc=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by SA2PR10MB4458.namprd10.prod.outlook.com (2603:10b6:806:f8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 23:53:01 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 23:53:01 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
        linux-debuggers@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves v3 2/5] btf_encoder: stop indexing symbols for VARs
Date: Wed,  2 Oct 2024 16:52:44 -0700
Message-ID: <20241002235253.487251-3-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241002235253.487251-1-stephen.s.brennan@oracle.com>
References: <20241002235253.487251-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN8PR12CA0014.namprd12.prod.outlook.com
 (2603:10b6:408:60::27) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|SA2PR10MB4458:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d09dde5-f5d0-4dac-6a5f-08dce33d599b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cyZjSTcayOyjlUbT4MnMX6pDDGHlGyOqoYDr4y1g3qpnb+1KgMbjuqIWeiql?=
 =?us-ascii?Q?9xCKEhyKC4AF2vBGr0L8wpTOXkm4SEk33+LqAanATEiWB814H0/x3996AcmT?=
 =?us-ascii?Q?yq5qDsIG12Y5L2StFqKdhXV3Pe34YACzGChuJm/TAIHJ7K/j+LYplPbNm5GA?=
 =?us-ascii?Q?xemsslJ7KqKDyBdiNpkLjfoWhivsCClXdwpKGHZkWsKS4dP672h8oGV0XfTd?=
 =?us-ascii?Q?szr2SmSkS60LYtXnpd+GXqswE1VMVvHoKjB3mzDHwnApyezc+0w+kdLqMPOh?=
 =?us-ascii?Q?RdPfQIaYctSvVUejJV3ZsmUDyOdTf45d+Eb9TG03Gnry4mabSsQYx7a/Dqe1?=
 =?us-ascii?Q?fATuvp0zmhXTo/zyCMIRAE14AKVfpAIQKdkgDOwUM3E0t4lp9Hj37Ws7Jm9C?=
 =?us-ascii?Q?9rUB3rkwN+XtscUOif0E8/VouwqLeahrLSTS+2Q5OhccrlF8L0J6nTSwbrqs?=
 =?us-ascii?Q?W6sM9kyf+gusslf496pS6Qp1QpsWSfngDscnCJ+/KKuY9L8Jr46S/VujbLmo?=
 =?us-ascii?Q?hOJvj46dDeuc2R58OodhPoIkx86tIGQDMfeG3MC7gC/FZHFDw5vwY64UrLTn?=
 =?us-ascii?Q?g0qNzBxRr5dp/pPWTuh96rswrj+SKze0N+UCM6Xa1DbST9WSpjLyjSUOWUVd?=
 =?us-ascii?Q?tDhOVm96OrWZtGizJu24BFoyPn1EpUWiZdyI0d9t8m2kILgW6ud0gxGtYpjY?=
 =?us-ascii?Q?ADu0oeUK/ysiRkqWRyQX7IVuOm7OdpKQkXipk8C4jp3xLvySiMQxO+HTHrIT?=
 =?us-ascii?Q?S6S1wjVA/xeGwUXtS80yM0ts8kxZF6NPZ+ivWjpmhRAZyLs2h85VFEoCLQil?=
 =?us-ascii?Q?6A2KumCP/whaqwaB+qhRmJDoK3pL+mlg1UREEwOV1fcrFGcLPErTEBU9H/9J?=
 =?us-ascii?Q?K1u4J34LyNI8IES6sazfsNB1qoNT5ariINpZFn4D/XMe3aUqaHH26WlnPEDf?=
 =?us-ascii?Q?I8M58sss/pLOm3FfptjS8sIx5R5TGXys9Ak4QDZs/l8L52Ya2EitC5gZ6Dl7?=
 =?us-ascii?Q?8z1EQAY74aptzODPSv8OCQiDpwy9xvZyC8eOuGFdaF1HXNw7WIE0qvQjacDB?=
 =?us-ascii?Q?AnneiJYAbqZ/D0JY+PcbAdskD9IodtjW1MkKZf/MZhsxSqY9x8Ifdp0E9WXZ?=
 =?us-ascii?Q?KRlXKWiHoA1YALhoWeGiNvj2UGo9zOvnZbVEs/1LYZeli4QbGzJRGRKt8Unr?=
 =?us-ascii?Q?DN1WN6EVi/dmeaI+B2MuzlOfuj99ltLJF5y7YlToR0SSFiSN0aG2AaL9ko8U?=
 =?us-ascii?Q?yZWIwxQuy2dyfpZRFtDKnAlrXiPLSd4RI9jQu7hFUQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N2pwun9hbf/i3rXe9V/kueYPUAvVJpponKPjtAVpjI+vkQ+1VteqkHEMzzy3?=
 =?us-ascii?Q?mJKP5hCMt5hRa9xoj+g7OZBq69I35YEzqNJRlBrX5a9l0EGD7BmXbooZ651K?=
 =?us-ascii?Q?EYHhHOSWVU1g3+vh6O5LF2Nlfne6jmyjco2MmBlaY0mAJ1KLt4ILnaWxPbPA?=
 =?us-ascii?Q?TaKvjMB9thk3Da0Ue/5DbMRu8cvnpCMWS93VFJ3RpdEhCQSCejex6hTnIzjO?=
 =?us-ascii?Q?62kBNbRjYJlQVUr322HVORQAspLH+kBnrCrHdSZfgVy8GWEoaSmF+KqQ5V2k?=
 =?us-ascii?Q?kwNx/XG8tRKrBJuM3hPdDi3GcnhSCgZs32ztiDpWiQ9y/z6mPcqh44A0P3Ml?=
 =?us-ascii?Q?dQIywJMaOT/haSSGkG5b9vtJCA9cHIOH0iLpQ2rr3L1kJG59kT7vZJK3aw4J?=
 =?us-ascii?Q?avu42ZryKynm6hfuUrhuj9kLBuGYCUaSzIZe02FaE7EZGFyJnPuDaR4jZq3+?=
 =?us-ascii?Q?TAZFH9L9zbSJvfy33ugRMuKmknBY7eRigMO+9bmVpheKbAMbyjPDyOZ+nHa6?=
 =?us-ascii?Q?517THY7pakvBcEDMi1E7e2D4i9jSF5jnNj+zKzhsQrKYnOjKznGKrXUKrCN3?=
 =?us-ascii?Q?XpgEXVNMq8haF7jPPXSNxiYuaSpSRsQUng3TvH+XLpmxcBUz8n0sigj0kOay?=
 =?us-ascii?Q?KqzsB78xgkT+7BAVsNfuBt+KnXZakStePgKQ9yIid6O67Ux/5B4Ya80r8mWP?=
 =?us-ascii?Q?Oy+2TJZ6QtmJoOLX9CQ+dAarNIYhA8qU+RmXssA5rtjjeBchGFyP1xLTDi07?=
 =?us-ascii?Q?SthiEsR67C3VoT7A8/mSyiUYLijx8anp8qcWOlnCGphgMGJsZ1Vq0AUgaIfv?=
 =?us-ascii?Q?pTGoLouFs6dr76YLmt0zwQQ4fmcYJYXV5kKOLrhg5MWg3l+6qPgg7HSrYCs1?=
 =?us-ascii?Q?jhFxTpdp4wtUqUDvkqoT3S0S4QUTN9o/fV4K2bxn+c7YamYGLUezXIr5qVRg?=
 =?us-ascii?Q?rGAOffD4bBTFLpDPDGg3Ryfd5KerZ46t2YBqCcsNvzE+iWdFfGR0asittZyC?=
 =?us-ascii?Q?2EulcZdTWK+WuM+DgTeq+2tp1PoCxpE4jHAu7cr2r6QHuOCtb0f6JJ4Rm43O?=
 =?us-ascii?Q?iBIVivrPKV3M6qGqQLomaTwaSUjIeJeXyNbzRezi6TA2MYE5VTG6E9/YKR3W?=
 =?us-ascii?Q?lK2q6xTp/sUTmKIOmgV7fAsz11HWDHld5mlzyyJ3apo37g8RmKcgw4QAni8E?=
 =?us-ascii?Q?i5OxuYmBNFxrrFUG61tbnfwjIWWIj/IKxdWZkme9PNk1Lt7QmTYHZAOzwvSP?=
 =?us-ascii?Q?CcKtsEpvd1s25ckaRhjQv6YhtCfb7DUVaUfbti+lc/y5/KIY/STz/xLT+V7W?=
 =?us-ascii?Q?RmumqqV4kc1DQ/AOTmN7GsOYGf4oWFQyF1tGm/4T1GvLPc0seTEtGi3JzzRe?=
 =?us-ascii?Q?yv4YakmkRjiKZVEs+SYRLxY4lKsAzhL8qFw1CYCeCHyJS0j1ffCGYESS+hCz?=
 =?us-ascii?Q?0blJ+TA7z+lCjEz+P+CD3Lk2ZDnOabUagPioTn7LFCvZGXBeI8Hp/cLHppjC?=
 =?us-ascii?Q?ColDRdOytF0dD4QJTzd3sZr2RQKlkJRGuQgIAMiHqLG8dAiyrOufDBudK+rL?=
 =?us-ascii?Q?sx+ft4U0Z9/qTsVfJHRfvZwJiSOojVZJ1SjLc3LOPvpxestQjByxNQ1ae7Dj?=
 =?us-ascii?Q?lDerKylws+tGdP9Tll+PjrM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	77irJ6nhyrrEzv8In7CaWbkJbX8B98ixP7dh0a8wkMu2Qk+Hk2t4yN/MPjrKSSh3TyHqayq3mI2tcvlFWjZZJoAhC4y+4vkx+V+BZfU8Z+SAI1qTLbgrsZZ7T+ARJAQ/jV4n0aXgYU3FWH637JTNQoOArzVAGLaFAYZp1S9V1zpC2P7wxvVZhlU4nzi0NRT5Dg45BWNt39W7qc79BmY2Lr5TPyswfyBzazh/TF5M+S9Xer0AMNrREeLv7R2ax5ej5ltntJcHIl02Rev+BlMQsGCFQuuF2nO7zRCqcL9eU5PXazUe6agCYNO0WOk3XvfJv1dfXztElM9Wxt9sYRt0S/KWkYG+OlIXuar1bEHf3iEc4mO2N3AltFfRtynOi88NVeV/vepVWsYdWKsRfr2kTXEmfjPJnBdNIWV0TS2vw1FqdfJLj8NQ3A0gFshVttAqHX21fZAWhjpdePx6z07XSoIXUIHeRnEO4RP/tVXJS0DJuvgYlvOKYi0gWRLU6hXIQTObkpk7JRs+1qpVoQFJdAHue/UB3aXzB9QygrijBAanctrmjLtLGFtBE+eDrw35TwhACApTZ5P8fYO/TMKfJ9i5SlHTmF9SEiqfgGd+/Dc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d09dde5-f5d0-4dac-6a5f-08dce33d599b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 23:53:01.7244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Xw/kxxUusRm686dsd7s6pdG6mcgRGXFu/kC3nRD1PfF3wWK49veVfe5UZQhyAQEosM/8i322ESqmR2INsDq39YpUMbp7sCn/ENXECB5ipE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4458
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_21,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410020169
X-Proofpoint-GUID: r32tOQnZ4qPhqsNxerHIVAy92sKI2qjt
X-Proofpoint-ORIG-GUID: r32tOQnZ4qPhqsNxerHIVAy92sKI2qjt

Currently we index symbols from the percpu ELF section, and when
processing DWARF variables for inclusion, we check whether the variable
matches an existing symbol. The matched symbol is used for three
purposes:

1. When no symbol of the same address is found, the variable is skipped.
   This can occur because the symbol name was an invalid BTF
   identifier, and so it did not get indexed. Or more commonly, it can
   be because the variable is not stored in the per-cpu section, and
   thus was not indexed.
2. If the symbol offset is 0, then we compare the DWARF variable's name
   against the symbol name to filter out "special" DWARF variables.
3. We use the symbol size in the DATASEC entry for the variable.

For 1, we don't need the symbol table: we can simply check the DWARF
variable name directly, and we can use the variable address to determine
the ELF section it is contained in. For 3, we also don't need the symbol
table: we can use the variable's size information from DWARF. Issue 2 is
more complicated, but thanks to the addition of the "artificial" and
"top_level" flags, many of the "special" DWARF variables can be directly
filtered out, and the few remaining problematic variables can be
filtered by name from a kernel-specific list of patterns.

This allows the symbol table index to be removed. The benefit of
removing this index is twofold. First, handling variable addresses is
simplified, since we don't need to know whether the file is ET_REL.
Second, this will make it easier to output variables that aren't just
percpu, since we won't need to index variables from all ELF sections.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 btf_encoder.c | 250 +++++++++++++++++++-------------------------------
 1 file changed, 96 insertions(+), 154 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 652a945..31a418a 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -93,16 +93,11 @@ struct elf_function {
 	struct btf_encoder_func_state state;
 };
 
-struct var_info {
-	uint64_t    addr;
-	const char *name;
-	uint32_t    sz;
-};
-
 struct elf_secinfo {
 	uint64_t    addr;
 	const char *name;
 	uint64_t    sz;
+	uint32_t    type;
 };
 
 /*
@@ -125,17 +120,11 @@ struct btf_encoder {
 			  gen_floats,
 			  skip_encoding_decl_tag,
 			  tag_kfuncs,
-			  is_rel,
 			  gen_distilled_base;
 	uint32_t	  array_index_id;
 	struct elf_secinfo *secinfo;
 	size_t             seccnt;
-	struct {
-		struct var_info *vars;
-		int		var_cnt;
-		int		allocated;
-		uint32_t	shndx;
-	} percpu;
+	size_t             percpu_shndx;
 	int                encode_vars;
 	struct {
 		struct elf_function *entries;
@@ -2098,111 +2087,18 @@ int btf_encoder__encode(struct btf_encoder *encoder)
 	return err;
 }
 
-static int percpu_var_cmp(const void *_a, const void *_b)
-{
-	const struct var_info *a = _a;
-	const struct var_info *b = _b;
-
-	if (a->addr == b->addr)
-		return 0;
-	return a->addr < b->addr ? -1 : 1;
-}
-
-static bool btf_encoder__percpu_var_exists(struct btf_encoder *encoder, uint64_t addr, uint32_t *sz, const char **name)
-{
-	struct var_info key = { .addr = addr };
-	const struct var_info *p = bsearch(&key, encoder->percpu.vars, encoder->percpu.var_cnt,
-					   sizeof(encoder->percpu.vars[0]), percpu_var_cmp);
-	if (!p)
-		return false;
-
-	*sz = p->sz;
-	*name = p->name;
-	return true;
-}
-
-static int btf_encoder__collect_percpu_var(struct btf_encoder *encoder, GElf_Sym *sym, size_t sym_sec_idx)
-{
-	const char *sym_name;
-	uint64_t addr;
-	uint32_t size;
-
-	/* compare a symbol's shndx to determine if it's a percpu variable */
-	if (sym_sec_idx != encoder->percpu.shndx)
-		return 0;
-	if (elf_sym__type(sym) != STT_OBJECT)
-		return 0;
-
-	addr = elf_sym__value(sym);
-
-	size = elf_sym__size(sym);
-	if (!size)
-		return 0; /* ignore zero-sized symbols */
-
-	sym_name = elf_sym__name(sym, encoder->symtab);
-	if (!btf_name_valid(sym_name)) {
-		dump_invalid_symbol("Found symbol of invalid name when encoding btf",
-				    sym_name, encoder->verbose, encoder->force);
-		if (encoder->force)
-			return 0;
-		return -1;
-	}
-
-	if (encoder->verbose)
-		printf("Found per-CPU symbol '%s' at address 0x%" PRIx64 "\n", sym_name, addr);
-
-	/* Make sure addr is section-relative. For kernel modules (which are
-	 * ET_REL files) this is already the case. For vmlinux (which is an
-	 * ET_EXEC file) we need to subtract the section address.
-	 */
-	if (!encoder->is_rel)
-		addr -= encoder->secinfo[encoder->percpu.shndx].addr;
-
-	if (encoder->percpu.var_cnt == encoder->percpu.allocated) {
-		struct var_info *new;
-
-		new = reallocarray_grow(encoder->percpu.vars,
-					&encoder->percpu.allocated,
-					sizeof(*encoder->percpu.vars));
-		if (!new) {
-			fprintf(stderr, "Failed to allocate memory for variables\n");
-			return -1;
-		}
-		encoder->percpu.vars = new;
-	}
-	encoder->percpu.vars[encoder->percpu.var_cnt].addr = addr;
-	encoder->percpu.vars[encoder->percpu.var_cnt].sz = size;
-	encoder->percpu.vars[encoder->percpu.var_cnt].name = sym_name;
-	encoder->percpu.var_cnt++;
-
-	return 0;
-}
 
-static int btf_encoder__collect_symbols(struct btf_encoder *encoder, bool collect_percpu_vars)
+static int btf_encoder__collect_symbols(struct btf_encoder *encoder)
 {
-	Elf32_Word sym_sec_idx;
+	uint32_t sym_sec_idx;
 	uint32_t core_id;
 	GElf_Sym sym;
 
-	/* cache variables' addresses, preparing for searching in symtab. */
-	encoder->percpu.var_cnt = 0;
-
-	/* search within symtab for percpu variables */
 	elf_symtab__for_each_symbol_index(encoder->symtab, core_id, sym, sym_sec_idx) {
-		if (collect_percpu_vars && btf_encoder__collect_percpu_var(encoder, &sym, sym_sec_idx))
-			return -1;
 		if (btf_encoder__collect_function(encoder, &sym))
 			return -1;
 	}
 
-	if (collect_percpu_vars) {
-		if (encoder->percpu.var_cnt)
-			qsort(encoder->percpu.vars, encoder->percpu.var_cnt, sizeof(encoder->percpu.vars[0]), percpu_var_cmp);
-
-		if (encoder->verbose)
-			printf("Found %d per-CPU variables!\n", encoder->percpu.var_cnt);
-	}
-
 	if (encoder->functions.cnt) {
 		qsort(encoder->functions.entries, encoder->functions.cnt, sizeof(encoder->functions.entries[0]),
 		      functions_cmp);
@@ -2224,15 +2120,54 @@ static bool ftype__has_arg_names(const struct ftype *ftype)
 	return true;
 }
 
+static int get_elf_section(struct btf_encoder *encoder, unsigned long addr)
+{
+	/* Start at index 1 to ignore initial SHT_NULL section */
+	for (int i = 1; i < encoder->seccnt; i++)
+		/* Variables are only present in PROGBITS or NOBITS (.bss) */
+		if ((encoder->secinfo[i].type == SHT_PROGBITS ||
+		     encoder->secinfo[i].type == SHT_NOBITS) &&
+		    encoder->secinfo[i].addr <= addr &&
+		    (addr - encoder->secinfo[i].addr) < encoder->secinfo[i].sz)
+			return i;
+	return -ENOENT;
+}
+
+/*
+ * Filter out variables / symbol names with common prefixes and no useful
+ * values. Prefixes should be added sparingly, and it should be objectively
+ * obvious that they are not useful.
+ */
+static bool filter_variable_name(const char *name)
+{
+	static const struct { char *s; size_t len; } skip[] = {
+		#define X(str) {str, sizeof(str) - 1}
+		X("__UNIQUE_ID"),
+		X("__tpstrtab_"),
+		X("__exitcall_"),
+		X("__func_stack_frame_non_standard_")
+		#undef X
+	};
+	int i;
+
+	if (*name != '_')
+		return false;
+
+	for (i = 0; i < ARRAY_SIZE(skip); i++) {
+		if (strncmp(name, skip[i].s, skip[i].len) == 0)
+			return true;
+	}
+	return false;
+}
+
 static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 {
 	struct cu *cu = encoder->cu;
 	uint32_t core_id;
 	struct tag *pos;
 	int err = -1;
-	struct elf_secinfo *pcpu_scn = &encoder->secinfo[encoder->percpu.shndx];
 
-	if (encoder->percpu.shndx == 0 || !encoder->symtab)
+	if (encoder->percpu_shndx == 0 || !encoder->symtab)
 		return 0;
 
 	if (encoder->verbose)
@@ -2240,59 +2175,69 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 
 	cu__for_each_variable(cu, core_id, pos) {
 		struct variable *var = tag__variable(pos);
-		uint32_t size, type, linkage;
-		const char *name, *dwarf_name;
+		uint32_t type, linkage;
+		const char *name;
 		struct llvm_annotation *annot;
 		const struct tag *tag;
+		size_t shndx, size;
 		uint64_t addr;
 		int id;
 
+		/* Skip incomplete (non-defining) declarations */
 		if (var->declaration && !var->spec)
 			continue;
 
-		/* percpu variables are allocated in global space */
-		if (variable__scope(var) != VSCOPE_GLOBAL && !var->spec)
+		/*
+		 * top_level: indicates that the variable is declared at the top
+		 *   level of the CU, and thus it is globally scoped.
+		 * artificial: indicates that the variable is a compiler-generated
+		 *   "fake" variable that doesn't appear in the source.
+		 * scope: set by pahole to indicate the type of storage the
+		 *   variable has. GLOBAL indicates it is stored in static
+		 *   memory (as opposed to a stack variable or register)
+		 *
+		 * Some variables are "top_level" but not GLOBAL:
+		 *   e.g. current_stack_pointer, which is a register variable,
+		 *   despite having global CU-declarations. We don't want that,
+		 *   since no code could actually find this variable.
+		 * Some variables are GLOBAL but not top_level:
+		 *   e.g. function static variables
+		 */
+		if (!var->top_level || var->artificial || var->scope != VSCOPE_GLOBAL)
 			continue;
 
 		/* addr has to be recorded before we follow spec */
 		addr = var->ip.addr;
-		dwarf_name = variable__name(var);
 
-		/* Make sure addr is section-relative. DWARF, unlike ELF,
-		 * always contains virtual symbol addresses, so subtract
-		 * the section address unconditionally.
-		 */
-		if (addr < pcpu_scn->addr || addr >= pcpu_scn->addr + pcpu_scn->sz)
+		/* Get the ELF section info for the variable */
+		shndx = get_elf_section(encoder, addr);
+		if (shndx != encoder->percpu_shndx)
 			continue;
-		addr -= pcpu_scn->addr;
 
-		if (!btf_encoder__percpu_var_exists(encoder, addr, &size, &name))
-			continue; /* not a per-CPU variable */
+		/* Convert addr to section relative */
+		addr -= encoder->secinfo[shndx].addr;
 
-		/* A lot of "special" DWARF variables (e.g, __UNIQUE_ID___xxx)
-		 * have addr == 0, which is the same as, say, valid
-		 * fixed_percpu_data per-CPU variable. To distinguish between
-		 * them, additionally compare DWARF and ELF symbol names. If
-		 * DWARF doesn't provide proper name, pessimistically assume
-		 * bad variable.
-		 *
-		 * Examples of such special variables are:
-		 *
-		 *  1. __ADDRESSABLE(sym), which are forcely emitted as symbols.
-		 *  2. __UNIQUE_ID(prefix), which are introduced to generate unique ids.
-		 *  3. __exitcall(fn), functions which are labeled as exit calls.
-		 *
-		 *  This is relevant only for vmlinux image, as for kernel
-		 *  modules per-CPU data section has non-zero offset so all
-		 *  per-CPU symbols have non-zero values.
-		 */
-		if (var->ip.addr == 0) {
-			if (!dwarf_name || strcmp(dwarf_name, name))
+		/* DWARF specification reference should be followed, because
+		 * information like the name & type may not be present on var */
+		if (var->spec)
+			var = var->spec;
+
+		name = variable__name(var);
+		if (!name)
+			continue;
+
+		/* Check for invalid BTF names */
+		if (!btf_name_valid(name)) {
+			dump_invalid_symbol("Found invalid variable name when encoding btf",
+					    name, encoder->verbose, encoder->force);
+			if (encoder->force)
 				continue;
+			else
+				return -1;
 		}
 
-		if (var->spec)
-			var = var->spec;
+		if (filter_variable_name(name))
+			continue;
 
 		if (var->ip.tag.type == 0) {
 			fprintf(stderr, "error: found variable '%s' in CU '%s' that has void type\n",
@@ -2304,9 +2249,10 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 		}
 
 		tag = cu__type(cu, var->ip.tag.type);
-		if (tag__size(tag, cu) == 0) {
+		size = tag__size(tag, cu);
+		if (size == 0) {
 			if (encoder->verbose)
-				fprintf(stderr, "Ignoring zero-sized per-CPU variable '%s'...\n", dwarf_name ?: "<missing name>");
+				fprintf(stderr, "Ignoring zero-sized per-CPU variable '%s'...\n", name);
 			continue;
 		}
 
@@ -2388,8 +2334,6 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 			goto out_delete;
 		}
 
-		encoder->is_rel = ehdr.e_type == ET_REL;
-
 		switch (ehdr.e_ident[EI_DATA]) {
 		case ELFDATA2LSB:
 			btf__set_endianness(encoder->btf, BTF_LITTLE_ENDIAN);
@@ -2430,15 +2374,16 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 			encoder->secinfo[shndx].addr = shdr.sh_addr;
 			encoder->secinfo[shndx].sz = shdr.sh_size;
 			encoder->secinfo[shndx].name = secname;
+			encoder->secinfo[shndx].type = shdr.sh_type;
 
 			if (strcmp(secname, PERCPU_SECTION) == 0)
-				encoder->percpu.shndx = shndx;
+				encoder->percpu_shndx = shndx;
 		}
 
-		if (!encoder->percpu.shndx && encoder->verbose)
+		if (!encoder->percpu_shndx && encoder->verbose)
 			printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->filename, PERCPU_SECTION);
 
-		if (btf_encoder__collect_symbols(encoder, encoder->encode_vars & BTF_VAR_PERCPU))
+		if (btf_encoder__collect_symbols(encoder))
 			goto out_delete;
 
 		if (encoder->verbose)
@@ -2480,9 +2425,6 @@ void btf_encoder__delete(struct btf_encoder *encoder)
 	encoder->functions.allocated = encoder->functions.cnt = 0;
 	free(encoder->functions.entries);
 	encoder->functions.entries = NULL;
-	encoder->percpu.allocated = encoder->percpu.var_cnt = 0;
-	free(encoder->percpu.vars);
-	encoder->percpu.vars = NULL;
 
 	free(encoder);
 }
-- 
2.43.5


