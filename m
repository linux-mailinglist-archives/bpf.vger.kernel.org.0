Return-Path: <bpf+bounces-31860-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 679AB90429A
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 19:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E2D4284C8D
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 17:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20FB54F87;
	Tue, 11 Jun 2024 17:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jKdV23ja";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Dj4GphL2"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8792845948
	for <bpf@vger.kernel.org>; Tue, 11 Jun 2024 17:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718127684; cv=fail; b=PTnWI/cZWUs66v5Kk/UiWWS9BBxQnnVAUFb2C2KNSv7n1y2O6A9Z8C4epacleSXh2URThKkuQY5YbAyVn623TFkuQtw9V6UwXgNHbfm4zYxhSvKlSbd7PVcbFLsyMGJqSPFycbfPkPMazaix2PWnFFEKTMsRW5EFQP8IAOG7nh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718127684; c=relaxed/simple;
	bh=oMbV2i1vN7UY8zHfulCqS3W5HzCJtDqjBgDZ8dl4U9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bh4HFKe7RRzT18WfeySPp80vWR/tcNFbQZD4neP3VvTYpyk+U28XDF9slfAjCGKcEX+i1ixVgNuKq71I2XI7rwzzCNcGGchvxjhQX96SGvCw39srcp2UVWUFXHZEaeuv5kcbHRAt6IREWZnFNJm6A9JxLId4+fXIEV0XAg+sJFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jKdV23ja; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Dj4GphL2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BFsHWv028059;
	Tue, 11 Jun 2024 17:41:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=jpeju0AdgpjcXC49fsm6rjrOTqBHolaDEaVPJENyFcc=; b=
	jKdV23jarT8Vv1C77B6iGS1urETBsVWI+2SB1cBxg6VIJbD6iRx9fU8yyD9PUFOH
	BlcH83KAVSEWn9WNYqbmQ3YBHJWE6Lqjrv0AaQlrAt/2Wg4Z/Rj3bYJEjg1s/WQi
	ITZsix0b+Z7Xom8Vr25JKiHZp2x7nyBWkCOmrIMaXfr5ULV8JyGSwEeDfQT6YWal
	vuy90EurshtXrzjsvwAmzLunk2SGHYt6jFwDCthXfEM6TOOnm0pK5PHp8K4EswHe
	VKPzBqMTGbrtJH8xKSFCGPUE5HWXejNZvEnssNIG7AUOtCR4Tt3XOLu5B0/2MrV7
	ej4uTA3ZKpOjVxI/o8kocw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh1mdeq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 17:41:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45BHMRc6012522;
	Tue, 11 Jun 2024 17:41:17 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ync9x7caj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 17:41:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXImsvBQR1Rr+QB225U94Wgl2jV9EcWiBNRoMMovpac+Z9kqsS7eBBXXVV4WkaeeL5EAkT97/wYJhNpbjZCycUaYipfvKtilGx0VNAh0IEkjdVfg7rimfH0vk1VHuxcruxaDsuLW8wii1FCwD0Atbi2/0Yidkunm1ga77M5X1FGDP6GyyfRRtv7cAwg+1yjkvZYeRuMRkmL3hrUsY1blXEvN8r9UVFIZQT/F0qFrtCuR4Hjq8Og7aMVbdZEvz+y2QEdzF3novnOe2Kdc9NthW9bomq+MN4XCESGDAbCnGKgnARyGpd/ZQOsXvD6N/Cf9R6tyo2faihij1kpqJV2Mvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpeju0AdgpjcXC49fsm6rjrOTqBHolaDEaVPJENyFcc=;
 b=cM+Z6yxe7mcvJvUPH41wyte39BNCncySCdyc0jjZ7izOM3EYPBMUt8bWlYWocObnSxJwB+97BDQhqesOOAqbhCxfjX2LY1VHm6Tw+3FVqhvIHkjWw7o7WBY3kn4HFMqU8rBSUaqMvXH/87dE0ZPtJ7XGFvoZi4e2/6Qlb5zCJ9/F7Vx2d/tippUz2yGNP3ofmNDdTH5OlgzTomuTTNQCYLto5WIy277CBNPQr/4bSjDMo6N9vDQfLoN+OEEClpLDfJWG84cctLe3oVcxRz9qOeXg4+Ta0rS8phzILo8VObsMzDtJliu0dPfX35LrxCMc0HPnFfHP/FcQmDuf/kvsJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpeju0AdgpjcXC49fsm6rjrOTqBHolaDEaVPJENyFcc=;
 b=Dj4GphL24A/IaAgZCyxgcr5HAQJksIw3NRD6zH3atC/qfiCMQV0U8hwJrJObRQkntuCLAIp9YrFkHbOqcb76UnippzaErAc89quT09cmmE6ycDctXY9DdyYWhx7P7CeTJ/PiGHDAsMGOeyYqJKI5OH8HvFlkmMJIuBGeJ0KWeHE=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by DS7PR10MB6000.namprd10.prod.outlook.com (2603:10b6:8:9c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 17:41:15 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb%7]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 17:41:15 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>, jose.marchesi@oracle.com,
        david.faust@oracle.com, Yonghong Song <yonghong.song@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Match tests against regular expres
Date: Tue, 11 Jun 2024 18:40:56 +0100
Message-Id: <20240611174056.349620-3-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240611174056.349620-1-cupertino.miranda@oracle.com>
References: <20240611174056.349620-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0228.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::16) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|DS7PR10MB6000:EE_
X-MS-Office365-Filtering-Correlation-Id: 8351a625-9407-4f3f-5039-08dc8a3db121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?oc/uUZLacWGQJU5TZzxusav4oJGg68yhT2v6OTgDpQXNs1/qRl0ovCOR+5fi?=
 =?us-ascii?Q?hInx5XWC5xa4rvsYlsqOSgCcG59PQ8VOQbcQZJynB+JLWOk9xeE7dfiCsEZV?=
 =?us-ascii?Q?qrt/wM4iPGfrUzSSVRSSrFeXxalDTp89DOGKTgbsoSVC+rbMKjQikWgmZwN/?=
 =?us-ascii?Q?bZbKoEMzr+2pmz10R8tDXsxMBtgX/leDOC3uZSQxk9rjeYfvassfSFFzLn/4?=
 =?us-ascii?Q?oCWA+Rh1WDqxmr2b9PoTMM1JRI7a6Et/yvXjDkDj1uMrs66VnaRpEDvwJzjP?=
 =?us-ascii?Q?PvoBOjPiGm+v6M6ClSwoXjFoiFPEQg0qtgqS4Wbdt5QjKmnPUNxmwD5GMhPu?=
 =?us-ascii?Q?3QlF7hd8KUN65G8AQzzJB7JVN2HDoYTg82sZzLh3YiaaZKCVuUbJM1/k2Rf+?=
 =?us-ascii?Q?+AJIHVXg4Z695RkjTgpvEefWZNbXebfuXredrv5yt07o5WRSsZuAiL/0aucz?=
 =?us-ascii?Q?MIN/Hln8GQnv7HbOCcaB8Nn+rIXGCv1TCH/vHwz0esfQAAbFGR29j1YeD0Zc?=
 =?us-ascii?Q?h0ySngblDDv59JM7Z+rOkGWs5OEU0mqZHia4y2VXpmAPLEHalJWR1FhdDrMH?=
 =?us-ascii?Q?Tym0oyDVPeZURVguUrnxYqy9EphYO2aV1f2DuHCGGx2yh2Ej4CQ3eMtoLzt1?=
 =?us-ascii?Q?V/GTNwxWglOIgE2NH/rb9P43OimF6ennhHvNPBu/IVlqR7VCZmFFUuQDpbPl?=
 =?us-ascii?Q?Sp/GL3q/LknSHCUeeRReiWuoUMFFzXPbTbYsg0RrUw7bt77/jDzrnt+GCTq2?=
 =?us-ascii?Q?0wVPB7uI7R2xWDExXGOx9OUNVyPrwBE6Dw1Rn8STyEFJp6jchlfROKjkwhU4?=
 =?us-ascii?Q?Hd9fUBao2ixBdS52TPIq3LYxFj7EK8LRf1OO+dWBBsTCgZnFjPXx2QwC7kbE?=
 =?us-ascii?Q?VJMyhJC/MSVLBbbtneHEWLVlmKRtSLNucRNvDA5BtXwtSaYD4fUAq6hM+jAX?=
 =?us-ascii?Q?OxdeEmDAh+beHBpSMANuENQj3kbL83HsOm/IUon/+fusPnBaMzI/JO7CYqaW?=
 =?us-ascii?Q?6hlnFjzu963hv7Qc9vCkeDXO+5lmVn3cmiczX/9mAQ+s2635OU1aczrZCx+J?=
 =?us-ascii?Q?riMd4rlxYZ+HHtUT4o5IRHr+GPKUX48R66y9Y9EX1y+5pxezT2/IKvZdcFmT?=
 =?us-ascii?Q?gEBfbRn24/AHl/7Y/MrL6F6tsRcK4KIG8Xj14A7peoZjlAGfognIFO8as/OU?=
 =?us-ascii?Q?MPwg8of6cO0c6pIIG2srNTS3DYK5WPKaY8ZOfRFBhyazkdZi6N37fYv3KPUQ?=
 =?us-ascii?Q?vsika6h68QGmBSQiz+IJxfzlIFHGcilof6EwBRuWYkvvPEonftaRzHm0LUR2?=
 =?us-ascii?Q?SVsUx5y+3slMMPSWYJh2tQje?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?m8o1FUrimHCERPT0x08zITUGfziwF7+YHIfT6fTUHVGqUf0ZDWtbPNN54PdF?=
 =?us-ascii?Q?qwUeI1VpsXzTXSoL5cYNFteJEobXV2hm5gTDVnS5yk6u+XE/DA9dXwxq1JOY?=
 =?us-ascii?Q?37Rcf9BHPFTnK31tO3HCtAylkofzL22EzCH2RSd6pWX0piW9PLFOf8oNiU6b?=
 =?us-ascii?Q?eBwSv4RFqkQWDo+SW694aHgF2RxXWn6jQQbWU9RVcfhRpyIrRjWrsj6X9UJc?=
 =?us-ascii?Q?QmSd2EcFbkfJH2CqGeLl0UPr/bmTpMwtszaVI8a/R3NjjM7LhpwI6TzO6jbl?=
 =?us-ascii?Q?ZJ+pGgYqJdNdpfMNvNpFo/oWUHaOK4lxxycDrZomtNHkFY6ms47vC83Hi+G4?=
 =?us-ascii?Q?aJinN68CTFErlcMJRCfOz8YBdUB5CSt2aI1yDX++rvsr3xVGGHoEM/bPv0NS?=
 =?us-ascii?Q?jJYeRHdlcfsvqlAAWFctO9ZmMJR2QtHjpaMTo16hzblo5OJisteQ7+2qLIU6?=
 =?us-ascii?Q?010tL0TiWmL1Aryp2jbngHkHJYZ9f5/Ewkd4wn+Rkk06U+nN+rFJsRe7Vq1f?=
 =?us-ascii?Q?txeVamYTT61AwjlwCOorqgm14HQ4cLNZUu78/48J97ekz/QGmtgPag/E+tDU?=
 =?us-ascii?Q?ykbc3z2+J6UBVipTJDNaymNHmC5WMN6PpZAK1iE+5rsPcILzWQkmamA407Un?=
 =?us-ascii?Q?OkOuLdiXzrzUASgtuHV8nRu2GAUqzfkGPcT5GY0y+zQgd254XkHs8g2iE6if?=
 =?us-ascii?Q?XB1XOVIUhSvP3ZxQl5YUXuFvFyexDhS683799o2/PWMtjteiWgPpz1mds7B8?=
 =?us-ascii?Q?LxdHMfkvUVzKNu2X565N8Cl4PrIGRy44MiNmNVuDvYfKNyRpk0kbt2mkE1Hm?=
 =?us-ascii?Q?3uachREBPrXszRSYwUKt4teLM1DeFqh8dpvbaYZFFNbyOAWYXboP4l3iHctB?=
 =?us-ascii?Q?MftOxL5J66DeU+cyjP7pSihALQbUdcwLQra1TYim5yjSJ/HE78RN6CkoH/H1?=
 =?us-ascii?Q?Cue62Ib4MTCcFUH82udOteHOoCfF78qe6WeoJUYpE+R6fCGsNdyXJR0y/S7Q?=
 =?us-ascii?Q?bFolO8zVev8Xi1hC3JW7Ot4G0/fV3Hfr7GF7VKb//JD/N8G8oZ448m50mSYx?=
 =?us-ascii?Q?ixJsM1eFHw3f+j4C35BsMNPmoazEOuG5TbPnSxSkxj27pC4IY8EfiDTX+aBw?=
 =?us-ascii?Q?EgZJ7AcN+z1HcUxyjU0oI8B1Z/xorRSz8i8dE3vv86sD0EUHaVnOOCLJJyww?=
 =?us-ascii?Q?rncOUbxsub5LhanSpS1H1dAObbr2p1O7sdA5wwmQhwJs5OzJfvIjWHAqXWq3?=
 =?us-ascii?Q?Ef0/jI4B6z1BomqcBas4eTm2RoI6MwoMKACanMW/KItCzoa28a47WeeU2/47?=
 =?us-ascii?Q?J+3CQEBFLaJhCCn9nNh40grOiuAILWjbBJtuo16lbNOJCywXpE//Tk0Eiczi?=
 =?us-ascii?Q?qNYmZ7jXyEAn9FIvd1OEd8vElGQgyXfrrQ9ybNEEmIZ2YCZhFmWdR3iUAFu8?=
 =?us-ascii?Q?VuUFvDjEyuSlSza4FeYrcvTq0W5SvAX27LYdV05Q01LHwx8XJ175vtP1A13w?=
 =?us-ascii?Q?wUuOdW1Gajyyhus+3V9Y+YGCj4s0k6IVYDe9ulHnwZXY/3xdeanjYxEXJ+uY?=
 =?us-ascii?Q?Yev8E6m0soUn5kX0L3G4uVZ3tS/+/uLYbowpxUKuJEU2RBuaP0ksHAdrpuN9?=
 =?us-ascii?Q?5djjl43Gb49/rjJIc7maY1A=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	TJoeXiRFWjq6NuvrXzd2hcA5M3PBrpO7+/BZqGWDKcggB/CKAUfyXPjbUoZu0zVWoKOlnYLpu0lz64zCWlHbWgfxGxDz3I69H+q4fWBP/kbi+NjWDtt3QntMnMwCvnn7Y1O1LDHM6CVPqyVV85y53J/nDQKc3rJIPy7lDdPsxULiFRmirKILjQIZF36DVy3F/W81wlQ9gnNh5+xqDfGywPvph0QDIQXtRePYVXgg/erfmUPKSQ2gP3AWfnNrD6EooK0tl9In4vZjijTdB6T+7LCVCwtPWwi5MZaBAbJiObq9nVwL+fCE9CaL+5zJy+TBKb3fFZiImURSUqyJSqMbzrU+jbyEbD464R8j7YqwdMfeegpuRn0U13VVeOl1zVl7YtUW0ZkIxL+sb8eHinW82NFCog0OXc51MYra8OPq+q06NXK6liF82MueMLuU1SWrXWud4Ps40M5X7GaO7XwxNLXB1gBpBM63zVt7fjBJ9o6oBe6sATrPvh9Smo8ntIm5oAiqhcp3+33kJeqPxQBBz4hczqeo/VHbVCq9U4+/lmmAYut1O6+citQsgi4hTxomP1wLJKYmnfx8wqguxO/OSkXTXUDUJphZ+PFf9xRaXv8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8351a625-9407-4f3f-5039-08dc8a3db121
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 17:41:15.1372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7/0NrVmpEwWn+TTd2ZK2GAUFbxdAtYMeCNcsybroDcFTSFwp5SDTN4xUVBIYpnWLJUEWyy+mZ9j/Bq9fSmITIIC6luPQOiV+MsR/DypNRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB6000
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_09,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406110122
X-Proofpoint-ORIG-GUID: nJ6jjfHP40UMVgRZpa_DVBWAKVogWU4D
X-Proofpoint-GUID: nJ6jjfHP40UMVgRZpa_DVBWAKVogWU4D

This patch changes a few tests to make use of reg
would otherwise fail when compiled with GCC.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: jose.marchesi@oracle.com
Cc: david.faust@oracle.com
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
---
 tools/testing/selftests/bpf/progs/dynptr_fail.c          | 6 +++---
 tools/testing/selftests/bpf/progs/rbtree_fail.c          | 8 ++++----
 tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c | 4 ++--
 tools/testing/selftests/bpf/progs/verifier_sock.c        | 4 ++--
 4 files changed, 11 insertions(+), 11 deletions(-)

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
index 3fecf1c6dfe5..8399304eca72 100644
--- a/tools/testing/selftests/bpf/progs/rbtree_fail.c
+++ b/tools/testing/selftests/bpf/progs/rbtree_fail.c
@@ -29,7 +29,7 @@ static bool less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
 }
 
 SEC("?tc")
-__failure __msg("bpf_spin_lock at off=16 must be held for bpf_rb_root")
+__failure __regex("bpf_spin_lock at off=[0-9]+ must be held for bpf_rb_root")
 long rbtree_api_nolock_add(void *ctx)
 {
 	struct node_data *n;
@@ -43,7 +43,7 @@ long rbtree_api_nolock_add(void *ctx)
 }
 
 SEC("?tc")
-__failure __msg("bpf_spin_lock at off=16 must be held for bpf_rb_root")
+__failure __regex("bpf_spin_lock at off=[0-9]+ must be held for bpf_rb_root")
 long rbtree_api_nolock_remove(void *ctx)
 {
 	struct node_data *n;
@@ -61,7 +61,7 @@ long rbtree_api_nolock_remove(void *ctx)
 }
 
 SEC("?tc")
-__failure __msg("bpf_spin_lock at off=16 must be held for bpf_rb_root")
+__failure __regex("bpf_spin_lock at off=[0-9]+ must be held for bpf_rb_root")
 long rbtree_api_nolock_first(void *ctx)
 {
 	bpf_rbtree_first(&groot);
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
diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tools/testing/selftests/bpf/progs/verifier_sock.c
index ee76b51005ab..450b57933c79 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sock.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sock.c
@@ -799,7 +799,7 @@ l0_%=:	r0 = *(u32*)(r0 + %[bpf_xdp_sock_queue_id]);	\
 
 SEC("sk_skb")
 __description("bpf_map_lookup_elem(sockmap, &key)")
-__failure __msg("Unreleased reference id=2 alloc_insn=6")
+__failure __regex("Unreleased reference id=2 alloc_insn=[0-9]+")
 __naked void map_lookup_elem_sockmap_key(void)
 {
 	asm volatile ("					\
@@ -819,7 +819,7 @@ __naked void map_lookup_elem_sockmap_key(void)
 
 SEC("sk_skb")
 __description("bpf_map_lookup_elem(sockhash, &key)")
-__failure __msg("Unreleased reference id=2 alloc_insn=6")
+__failure __regex("Unreleased reference id=2 alloc_insn=[0-9]+")
 __naked void map_lookup_elem_sockhash_key(void)
 {
 	asm volatile ("					\
-- 
2.39.2


