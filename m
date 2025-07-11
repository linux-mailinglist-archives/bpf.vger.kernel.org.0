Return-Path: <bpf+bounces-63005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52235B014DD
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 09:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1375A26D0
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 07:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE191F12F4;
	Fri, 11 Jul 2025 07:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Yah4Yt82";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TsqnL6fg"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEF11EFFBB
	for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 07:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752219636; cv=fail; b=UEZYGXPPBjW4N0qvw8/MkD0Y1Qg9HkpyAOvdxU6ecQW4QUmWretPBL2f5dBwB/LOeEOGKO6laj+5wwFM7A5qLxdzQQ9J+3CpCXtgwNy1UWGZ7X6qOHglyBtVa3TktfM4m/VCpVQw9uGzk0FfHgOB7ZHNXam65dtX2DmDrQU8WNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752219636; c=relaxed/simple;
	bh=S8CXRSc++HY0C7AmoY6ws5hcCkyhg2Lvf8wOneOROkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TZRVLL2XtFL33OI69pasOHI8ese4sHjZcNnqwqM6USqsPCgA+6sbWzG1Sr1UfejL6zgCkxnZiWvimjnDYX+DNxvVGvftloAVEaS+VDhd71k+2IYdsxl7R9X4xRu9maQCFFgqmV9ykWdKYMzaHiv4t43Ig1gAdaGLscxnQS5SS2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Yah4Yt82; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TsqnL6fg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B7WLnW006746;
	Fri, 11 Jul 2025 07:40:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=NGHj9AkC+LC/alBcEU
	17g8h+xD5EBa254Tv5tLUsEBo=; b=Yah4Yt82/OvYjlEbHT112Lr1y9c3vRl/R0
	jFXox7VkYOgN/rCz5EMsCy/ryhEhQCHwsOxHirLF5T4NtMm2JadspEQT17ePzKQl
	VX7TrcHxBav0OyoueTEgcnZI/rOa9aVjDcCyYB8L6WWwL2ggOeDYnd6pgboq+W5M
	EM95jvomtwEhP4oYN9wkWyO17HHXw9s79W1KEQAHgJBH+C6n2Jo/SUk6w5fzXjys
	hUYumldH2KKSW8OZiTlsJuFvyYIu5LPQnsUsbQD/gWW8SaVVzI4lNiWu2ta8Q8m8
	gb3T/sR5Ca6d1PC2tJsWLFzqGnR3Cs1I8wae+8PhqaSLWrooBHNw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47txa9809t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 07:40:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56B763ls014252;
	Fri, 11 Jul 2025 07:40:11 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptge1s51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 07:40:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fS3uH9qeVU2lHtRUGPD7gGsXKbijVZVYWojqNYttEFjtd/xr92pCGKq49lctVgETX6plxzdsUklEkdcXuIZtL5M/5TNEqYum/thlI3YYbaMcnOrAnLCb7tjO+Hrz9lRxMgCayRpQ6bfDHOpbOfEvvcf41wldVfx1rKJW+MTR5+H9VUgjQcdv2UF5DKfvjUvKUyT9pSOuJd575iRdq+PnhUlgmvnYqhXsLQVUN1gqQc2T5y4iHsrYm8Wz6g7I5KBtQ3xjeDUjiGqtRpFEtmS1UeSU1hRKV6D/ehCWQOVFlK1UUMHCTtVmbMMNRo4Jmrv0/bY8yl9x01xMuc3UeVO1vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGHj9AkC+LC/alBcEU17g8h+xD5EBa254Tv5tLUsEBo=;
 b=O5TYHFl6kWokg4FHrJqIk0b2/ntWK0ueEeLz83HL1niuueCNMVg+BPXjfTEhcWdWJ/UdW9u95irpkiG1O5JMMdL93/3u9XQS51PIT7vdDdeSDLQCbcYLKyEPigycy8WyEezadwu+qdidRPfcJ0R+V00Fe+rI0vVaO/6NNh7P5taECColnBKQQkbHpkpgEzuH18ZUcA5UX+gsXcTQJcNzUaaYD/QykLdgNV97QCmOX8aJEsIAdSpuCr/LAxO14aSAK6TUH1DKpWvZfnjggmF33nNwXx9xQ5hWL48bl/Gx/B2GfxmlVVGgEN1IRIM6eMvUfUjNYHmFkYgpdQDBCMl0ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGHj9AkC+LC/alBcEU17g8h+xD5EBa254Tv5tLUsEBo=;
 b=TsqnL6fg0pvPkqaDw4HpTA7cPQM74NhvbHKQKXj22+BXtpmhnn2NoZ5yiHLmEc37IJC7zGB7q9819mmI96QEg0VZkNx53H9Ho5gsntSgsx+KWhT9LcDGK+z/ptXepDsOpwcow2nbZ5ai9rQTIU4ZI6mH9h4HmmuQEsCsRXn4C8Y=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Fri, 11 Jul
 2025 07:40:08 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%4]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 07:40:08 +0000
Date: Fri, 11 Jul 2025 16:40:02 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
        shakeel.butt@linux.dev, mhocko@suse.com, bigeasy@linutronix.de,
        andrii@kernel.org, memxor@gmail.com, akpm@linux-foundation.org,
        peterz@infradead.org, rostedt@goodmis.org, hannes@cmpxchg.org
Subject: Re: [PATCH v2 6/6] slab: Introduce kmalloc_nolock() and
 kfree_nolock().
Message-ID: <aHC_0iyz6E4m4jPe@hyeyoo>
References: <20250709015303.8107-1-alexei.starovoitov@gmail.com>
 <20250709015303.8107-7-alexei.starovoitov@gmail.com>
 <aHC-_upDSW_Twplc@hyeyoo>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHC-_upDSW_Twplc@hyeyoo>
X-ClientProxiedBy: SL2P216CA0223.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:18::6) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|MW5PR10MB5738:EE_
X-MS-Office365-Filtering-Correlation-Id: bf599711-f71a-4b98-556a-08ddc04e28b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t99TxXI2DzRXsrghGH5tGWkD9vCDEHdcp7tMpkorH3u7vDy3ChPXkr5rQo9s?=
 =?us-ascii?Q?O5iN0MmjgWCS8cr+fr09pDnhJRC+GrhIoAVIheLdyKLEgA7rVDS+Bpz64ZLy?=
 =?us-ascii?Q?oSQpv6UwYfT994pJJpCsIofID8/vQfv5wAg4QW4pqWoyYO72MHMzpXBnsLl+?=
 =?us-ascii?Q?sWvzXq6Co8IAP+Iys4W+uK//zqUzPsD6FUWCmk6pvevg9RwOsbdBpIZCn36k?=
 =?us-ascii?Q?upi7m6qzDRTD8rNXWqziRzaANDX0xiNfLzuQnQs8FzoXe7NZKwt+fxzjvmEs?=
 =?us-ascii?Q?Ote80Ed0JAuhMBYa4X/72Q1vkpTEJpoE9s8n+vW0obGPbCvbmX2ZO17VzSWe?=
 =?us-ascii?Q?gReIZ5OE/7LHcX7Zlyk6hNiwhQA8hkMh/6KDsd/AiFhbMZf+rsYnV0dGQoar?=
 =?us-ascii?Q?7csdL8ldvsajvsCNG62cdc6nXrlcv7CAeaUHlh5M1fW7IJlszrjnj+RnHP5G?=
 =?us-ascii?Q?tyodq3GK8Gj95M4jxFKMqwkTpq9fj2s/2TAsh30tVJQrfiRD6QDh7hWDsctn?=
 =?us-ascii?Q?5Ipq1PSfiQa4ENzqYsd8CQXoca5fdf1AB3/anj1s6SEbYwwF6XcOCjbHuNuk?=
 =?us-ascii?Q?jInlYQYj6H2YNwmUNExy8w48GwGJgxpNSlWsNvB9Q0ZQAxTUFTbE/TK+VEud?=
 =?us-ascii?Q?dv2aG+ANseMCrdrhpfacL7TV1Ih2X1Ig9AOo/5TH19/6ClqnSkhf67mUPgXs?=
 =?us-ascii?Q?8vKrBHwy9DKpjyzoOA2aJUGiaQL9nuy5DF0iuC5C8cUPrIW5eAQ184+GGPAn?=
 =?us-ascii?Q?kD9++/Gnda737mZJ93lVsO8A9Uv9iaJ4b3ar1qNMikNDmKQX85jHVZ1t9Jp6?=
 =?us-ascii?Q?kjujRYVq+xEItY5CryLbLiKLnimV8M+vA7L823TWIo6rhgoHoZJBA1ktJRAr?=
 =?us-ascii?Q?zVY0+75i1GqwfZ4Riu8RWPEiRra6cU/tmBBOeJmXSZaz6owFOGoIs09Ffcfc?=
 =?us-ascii?Q?3PKTYCTQkrKkGK46abrJZ3m0mm7U1MDTI/iaF9EVazkqHZSDXI2kLRPT/Mbz?=
 =?us-ascii?Q?OszU54M2+/VVp98kNbGV4PJbi1bqqW8ppl2TR6DHk01SziZWeE3Y2NJndqLa?=
 =?us-ascii?Q?qhekknfbmrOvk+8ccCutpUn/XgaasvKKciLhq0jv+tuRKOObi8rKcYiFfVou?=
 =?us-ascii?Q?2epqbeYthJdqiDw3f6dni8worYNveV/fLwxoHsKUK5ORmA8gyVLPiAeBTKGB?=
 =?us-ascii?Q?pkuMOV9dPVwUgbTomLECsLDy2pBQ8/J95mQnGRGCb7HKk5/ye4qL42ruG8jN?=
 =?us-ascii?Q?hpyF+1RvsyLn9DOnuGXPg7io9Yh+WcJ92vLxtRyyPRqHkUoBQEIRaSfslNvx?=
 =?us-ascii?Q?aFHM61NX7dbhX6UD7miBoAOGqpzGlwXDNcyESvwTrlXmfHNRjpZhYlVQDqrH?=
 =?us-ascii?Q?7VJ47NHdqhapWkrckrU4Kn1//GwjxMhLf7v2larWlXUczHtqRiZfZQlyDPCE?=
 =?us-ascii?Q?5KfdRfnvWXg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0um2Y/JZAxImsINcq+hiuiu+LtRN57+ORWAnLXiDOvZgFA4tnMBmRwNZxL+1?=
 =?us-ascii?Q?aqgWw8M9i+kw6G2S7ZOfuYFQZasizAw7CyigeOTprzDz/CIMKoRAqbKFoVEL?=
 =?us-ascii?Q?pGFsC6y8ySbu4H3OS5/GZvgyYSiHsm7D2STnJSDujLxq7+E9reg0KC/6kaMP?=
 =?us-ascii?Q?XCnNW9RPCWpCbNqOOx4G2FszrdBKBmLO+f9kMdSX96fmaypY4lESPrcqS3H2?=
 =?us-ascii?Q?tSonaxjJvpfJwx12aPZxM+xKbjaddpgsKZr8AORnTYQVdkVuWyqMFeV/VD9Y?=
 =?us-ascii?Q?82Je1idKsZDvpO4bQVyiu/lyVY3JiD8op1txmVrq8LZOxAKaXsFGeiwlyNY/?=
 =?us-ascii?Q?MncAp7N8BYVmUVcUJLMGdc7dg9XervLxfpeGCaMJq+EFb2/JXIC9qRaXnAO5?=
 =?us-ascii?Q?z7bpS0RouGjpXhGVvPx6RKoXRDCJuisjHr9qf1AEIa/Vbz5zBolFlHWkwAZX?=
 =?us-ascii?Q?PHlH7YvyWLSnEs/J0+ObD+Oo1GbjcexlB6r6DmjHZgj4OHgmMJ19IypNpcKz?=
 =?us-ascii?Q?yOuBOj9lOe5HX7kolvodkxd/0HUWJbAFF2J1I9WYlxrso+ucOlo8ojNDBE/j?=
 =?us-ascii?Q?6hbIY1IuxYjI7AEj21wYxrLMQ/cazIxkny0TvJJ4pbPQUfygZdXR+r4svW+h?=
 =?us-ascii?Q?/RC/JtpqBz8IUyFiO+7CPrbUuBpuW4ewKlsLCDgV3jYJZ4R+HvvnfeclbG7+?=
 =?us-ascii?Q?5RhjZBlPL48XF7QbUr878kudVEM67ayWnrjhRTh+INzsdD6ZS0P45ewJbcBU?=
 =?us-ascii?Q?BR2PW6/0pd7rhADcljqS1ykfzfW0bh6Q6D8kG1CvfxiAC1BbGzvHt05HkSt6?=
 =?us-ascii?Q?RnK/iX8m/f7sZWi34tEXjAjQ+E3IgsmIYkiOquzx/AllNjDPuWhiqr8DEM6T?=
 =?us-ascii?Q?h7fideU8E+nGwljMFhv608jDugKBzSt5qfGZXl+AN4L5BiveMSrpsyZbBprY?=
 =?us-ascii?Q?iHDTMXQEv8/nomrnsUO3588BTXY9wQbwTkMqzQKte24f9ZnDBPCj8tGfNTvR?=
 =?us-ascii?Q?PMzoeGZRL0SPhPDITdVCJY+1YV475Qlx4X916bs+BO8ezVRQue2NLL79+Mbv?=
 =?us-ascii?Q?RFybeA7z3eN+Ewl6eObqDe3MIzXvfsGoHYZBlloS6a0lEzlj+cVP6ZhNwHwv?=
 =?us-ascii?Q?zyEWDwmBsoEhh+KuyJ8mvB76c1fEAQVqm5E0hxwcPuDldKJ8+Ycb/t0iw2o2?=
 =?us-ascii?Q?5Nd1UtEXWagHfpxv0b9uwaTG0G5WTySdtbnPJedXHNerNjvtFNeGCMknUn+M?=
 =?us-ascii?Q?CEYxio4MjAMs51bka/YVZcpkTYij9vEZhXG2EElXZddqsdE2dMsEZTMJszpa?=
 =?us-ascii?Q?fH048f2T0Ho1aA598DCikrb7ZMBhCQHNMTGd0wPVCfsX0BJMlwYV4q+ueuWH?=
 =?us-ascii?Q?4g4djai24HvOfzyqHP5TStCZxJ7FX2qgTGz7RG6Se+rKu6HKvA3OpV2QT1sG?=
 =?us-ascii?Q?Qscv6AHbfDXhYrBvCfumisAktcyEhujSuHdiWNc2UwE77W9OG/bHuh+gZzes?=
 =?us-ascii?Q?Cff1f3ZuGsPOVsDU66qU1NdP83Alu99LplMQaAsTi30mvEuBOVivvMkm7sO2?=
 =?us-ascii?Q?401iBapAPWLLBqsnMQ1XohBdOdWNL4OnEwwugvw0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tsOVHw0Tz8kTU6HaeYBGBhTzzmw/yfGNwUtF8kB5ZIAytjxuPZpaXDbLe1YZZ4cxb6SiFTX3Mui0i+c//SChXl7KqR4FLofTnWgasVTroXPSik9IbXRJ26d5A9qEjzuO/t+gfgPNv/DIR4ET68Fk47O1GS3rR116Dwt/6oAQZ5rGxx5u2jAW5NRAVUSQEB0HKOxH3SfA+ZPBxvmw9MZxtSgX9S3RfW6OZqs6x5ckM6uF3TO30SwzyWPatkeV4AnHeF5tw8bqRRCFNjy19jnNbi8d3iGkih8m79gjVtnY3G6y4ler5lhZ9PuYO7CDk37JUnk7myncuNpCuHZNRp/Z5ELCxzRcahyaE7lw9bRD0YAJ+CDIt93DhqLawHZ/fyTe/kAaMxAkQCgJ3c+ZCf8uT9X30/ljN00vnRVuDWc3IA/yuWf9PipLnPSCtLs8b2lB84mCBquy3PCXW0LO0xf0tLqOyD94V91tOcvHtRz2vcxRjn5aRGwJ4HcGGYVsluDMjg20bArZJcQftZsgjBvsGM8O3UHs2X5pjIoy8GcjMNjt4FLc1+7ow/91Ghl46CPGvJtypVqdrbaFjhXSy5R862BU2xzr5mL1k0QDUEntDkM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf599711-f71a-4b98-556a-08ddc04e28b5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 07:40:08.0773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BWARWM7rfseVeJrZp3I1VXrXaHiPG1dN5OU8610heHRfpYe5eCN6MBuOQU+dtLwwLn2OqTg26rCfDBbO+uiALw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5738
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=939 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110052
X-Proofpoint-GUID: 3vfkRAKciq6iTCK9vHB8Hb7rqU9O58KS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA1MiBTYWx0ZWRfX8ikCEmtjGFQq wmYDEogqiG6e93H4XmfolQO9zzBXLw1luFK3BI/DWH4H0Exc+sQCK4rLq+W9at7aQYhernmnHIx 7y9QGEu7jE3FmJ5qdK7cjJhS8zM60KrXu3orxq1hOOfx+JAyNnqeEsI8RX1FHGNLqdM0gU4+WVs
 y0gRaOpQCYYdrsTMOR3itSLR6cf0KRnhAdgSvqZrCYQLaH1X44l1loSNoP2X7MSiR7LB2t/WQ2L UnAe7W09trvVPY4r8dKbyx9HJ1/pIIbqE0HKyTh5HqCmCHdlqZxwQa1LiQR66JAIhGq/AacYlJi omGPJuvl5/49xzic/2D6D/gkETg7vQ/u4eYJZsjIt1Vx1q29zscquUzSOTqrM+5UeUn0wA6E6Ml
 npF2NZ5XsCmy2XUMbvzGKCVLBCWcS6VvnBjCM7Orsp2dJhoRnzMrHD5/AUnCH3tnHyVcIfyW
X-Proofpoint-ORIG-GUID: 3vfkRAKciq6iTCK9vHB8Hb7rqU9O58KS
X-Authority-Analysis: v=2.4 cv=e/EGSbp/ c=1 sm=1 tr=0 ts=6870bfdc b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yhJx4JffJt3_1zfpJ0sA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13600

On Fri, Jul 11, 2025 at 04:36:30PM +0900, Harry Yoo wrote:
> On Tue, Jul 08, 2025 at 06:53:03PM -0700, Alexei Starovoitov wrote:
> > @@ -1990,8 +1992,14 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> >  	gfp &= ~OBJCGS_CLEAR_MASK;
> >  	/* Prevent recursive extension vector allocation */
> >  	gfp |= __GFP_NO_OBJ_EXT;
> > -	vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
> > -			   slab_nid(slab));
> > +	if (unlikely(!allow_spin)) {
> > +		size_t sz = objects * sizeof(struct slabobj_ext);
> > +
> > +		vec = kmalloc_nolock(sz, __GFP_ZERO, slab_nid(slab));
> 
> Missing memset()?
> as there is no kcalloc_nolock()...

Oops, there's __GFP_ZERO. nevermind.

-- 
Cheers,
Harry / Hyeonggon

