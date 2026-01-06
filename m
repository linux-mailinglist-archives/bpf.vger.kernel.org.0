Return-Path: <bpf+bounces-77996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFA6CFA34B
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 19:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F00232E9751
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 17:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC71344042;
	Tue,  6 Jan 2026 17:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i9Zkdju9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JLAdvAxl"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E32200C2
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 17:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767721104; cv=fail; b=SmlSlXgqe2lu2YaRuTWMQOAEas/DQtF9Jrwp7Rddq4H/D8smolZX62wkU3IOSoohD/5H/TGhrElGX8hqvtJc9pWxe5cDeDIJo6+I8La6HcnrVgCPIyrPNBTbQhsxqA3yxlFa8nctnZwM4EUO6uMFRmfwhxkdn4STnG9+Jwnsecw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767721104; c=relaxed/simple;
	bh=FNQR3hBuy1NFBIudUYmII2YW1bYqLL6Z8JKLby3skNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nm3xpzzg/aC4JDnFT9saXu/eHYY//3g5eOqAPI61JqJr7bLeQP5Px35itGe7TAX7PTBlInBRR6sQLiQpewspW77GviTtz3Sqpou2bFRSL5IQMbUuRZitqEGp+Pg2Da3OlFzwRkFGdwrRBnRXoiNVrvOJmwXgct7uqNxn5XVepeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i9Zkdju9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JLAdvAxl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606GpXPb3969067;
	Tue, 6 Jan 2026 17:37:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1p+r84SMHdQz5XRq/HmVbAyh8QiBWrAsWDmVsevriVk=; b=
	i9Zkdju9TkJbmRHEplqFXaZw7zKt0XfjHBQGKQjPUfIyh7ta+n2lvmemQ0nU4/P+
	G0D7uylfYA9mTuJfw8+xozaVQ1WIll3/9yO+akSBgfIO6FTpHYIHqobiGdvsjuF9
	BoFgv37t6qL5WPdPeiiB1xoQ/NczY2ZDHjrkVO1CbIaMDqjPYWMZoXEjQpBd258m
	uYFIfvfLk5bOnLq6J92s1ofBpoQCHctpmHFjQzqnaY+gL8ueYd3UMCyKxL7afemV
	zEDq0dASBMgObay+64N8ItsUU5GZ80vSESJ0gzBdfxA25MmrkWxFQT0jAmzw9brA
	0IamZtp0CTobg1g+bRK6mQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bh69b02us-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Jan 2026 17:37:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 606GRZjh030658;
	Tue, 6 Jan 2026 17:37:15 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011059.outbound.protection.outlook.com [40.107.208.59])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjcvsg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Jan 2026 17:37:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJYPB9HJAFkeccfrPo4iup3C6YyPZhsGePyJSeNT9D0kGjksceE+pARFrrbsbJY0OWv7vgL1H9lnyLocvsJpKwZKIPifgsLo6bisYbJh8xtsstsVroHtGXlfMdEXM8UCBNKvp9uhvh+dYsmHUobMVKtsR7vr+ac9SEoV6yeDOozcGbzeZeTUp9kGzGt8EXIC4iHhLOvpu1euOKeJ2LRQfPUM0phISR9ELRD0vHE9BfVw+Reic5FMoj8JQ3Vkx/FFBQ7d5FGegqAgRY10ic9Qu0zs1v+w3S+nJ0eqnm1V9UsR7fa8diHql5j0p03iCtOFH9kWqsXMg/2/HI9HxZZOjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1p+r84SMHdQz5XRq/HmVbAyh8QiBWrAsWDmVsevriVk=;
 b=fu0hPZ2AsFrf3pN2zD23uE0axMADrU9NZUOcFJm20ivnuy0sX7k2obn5dv/Lfj4m/w5Hf2SxdznimwJa8gTSw/T0irfXXXQgLo3iohqJaXUtIEoD5iOFe1ge8gB+gsGaSYj4MzWMyVKg+L3xgli2QKjf4FoSw9Lb+WIAUOoPhdRNnTiSeFLSr8wNMWXkKu0dZFlww5Va1xOfOfCOFrjqgI7e5B0fxlDFx3EizHIpqgXx21yr7g3FAHVTAX6+h5yn+B80zUw61UN9opG0fhojWIVZdYXNz6PQmdb5Yv/PuSbUf0Yng9TdbBF6N7S4ncjOqrrqyryPpJuNf6fcdhJEpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1p+r84SMHdQz5XRq/HmVbAyh8QiBWrAsWDmVsevriVk=;
 b=JLAdvAxlqd7k1ER1wEFP4+AKPiZqo2vJqndUec4zwo0cf7aPF6O5VDJutj8qE2dGd4gvkdY/edZxFdHmK2kwD+2TAvkdiMvkhgYHZgnaIYWwyweNeL9q47XXDNo2i7+XROGK6hCq+IMywJlpLsK/vec32TdnqopUsHe04K4hOGU=
Received: from CO1PR10MB4500.namprd10.prod.outlook.com (2603:10b6:303:98::18)
 by PH7PR10MB6311.namprd10.prod.outlook.com (2603:10b6:510:1b2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.12; Tue, 6 Jan
 2026 17:37:12 +0000
Received: from CO1PR10MB4500.namprd10.prod.outlook.com
 ([fe80::8a:149b:1a7a:c7dc]) by CO1PR10MB4500.namprd10.prod.outlook.com
 ([fe80::8a:149b:1a7a:c7dc%5]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 17:37:12 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>, david.faust@oracle.com,
        cupertino.miranda@oracle.com, Eduard Zingerman <eddyz87@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next 1/2] bpf: adapt selftests to GCC 16 -Wunused-but-set-variable
Date: Tue,  6 Jan 2026 18:36:49 +0100
Message-Id: <20260106173650.18191-2-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260106173650.18191-1-jose.marchesi@oracle.com>
References: <20260106173650.18191-1-jose.marchesi@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0413.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::14) To CO1PR10MB4500.namprd10.prod.outlook.com
 (2603:10b6:303:98::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4500:EE_|PH7PR10MB6311:EE_
X-MS-Office365-Filtering-Correlation-Id: cd9e8920-0bae-49b0-7a70-08de4d4a39ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5Y5SkdrcTe7sPdtrhLZqIlQF77XbO40lnIJueSax66l5cAELvi9PknaGNOPV?=
 =?us-ascii?Q?W5940al+iUiRrk6OuP//DBI1jEsVjtlrNEnBCDwUML5XT3u/klc7ry9hc3Fv?=
 =?us-ascii?Q?yFbWsYLOH9slSRpxf0oaFeevYKRR1V1PIOIYfou77BGb9l92YVFMRFAqAsVN?=
 =?us-ascii?Q?2jeqfoPHwo8dGRQX6fJ/Z4dyXIWUXmLMPk6joyfYLs2v5EgIIfJoz9u/cTm1?=
 =?us-ascii?Q?7fSxmEhYWM4fpYkGAuMpszt8tTnkjz+XD7PtWadjJLNS5wieT4TQPCzxw7VU?=
 =?us-ascii?Q?cu38KNTl1c6SImu/lqZS8VWDuwdSFfL8vqMEIdsr0+2/K7Z5ehNHorj94cHo?=
 =?us-ascii?Q?BNmf7CaBLoUDddj5fM+5canhjy6Te10qfPBRXDaz/n1wYjn9O4FQ0htS6nzJ?=
 =?us-ascii?Q?3bMsAf7I+iE4pR2h3AaYq0nbmlFeZSJ9cdGUA0TVHZUv85cID0jS+tWJ5kGo?=
 =?us-ascii?Q?Fy1mEKK1gdEg/S3sVJXcA1cZi0Sg7ZToVuslups9x733PRHr8ILumUkXHdlk?=
 =?us-ascii?Q?5Clq+ijakL4l2XpBrnlqniFYklC0OcM45bEDOukeSKrVJvGV5GeD4bsO+t9F?=
 =?us-ascii?Q?Z86Bjlxycg4nFHI5XA0eT+lUxpJbkxK3SgKWb9fwtRq9METaLFD3ktdLLMdP?=
 =?us-ascii?Q?AbkYjjXw3RoqBgpegjdcs9yszH+BLqDv54Qrpwbt2/c8VpbPan6t2BmWtGj9?=
 =?us-ascii?Q?l4Mh+8SrNwc63FbtZb2GY1o98WuimPanynBNGSyMTYfSHUl/y4mvvchF0sti?=
 =?us-ascii?Q?IpGW5Nta76+X1NNKlK2v3mBOp8k4phSkFC8E/xxA3i+thJYbba3q4sQgbo/P?=
 =?us-ascii?Q?KTgu8tXhyFqzoJ2CXWmrCZll94/+749S4ltiu0frR2Fcg33jaCOdd3U4VJ5c?=
 =?us-ascii?Q?mwXcqUd3PRG6JekvbB5UQr+QHRzryYECwCqE5ClOwYYA6PN0ncJJH5hmh3rR?=
 =?us-ascii?Q?c+aB8HqDzyIqW06dW+OQlMJtyLx9dPi2oXXfuVhTd2xyphu4AxNPsJcYEToy?=
 =?us-ascii?Q?7JEPv+u8pTOHMqQB5yk0Djlj3L+DwRisdy8CE4fMBQerRd2HXQrjt3/M11qC?=
 =?us-ascii?Q?vyzbFxaQnWDpQZfMUROv6b663H96WnSTcKo7nMTyWCC0x92yveB4H02eo3Vj?=
 =?us-ascii?Q?yIP/9wzCuYthPDEQDIBhlvtolfDx7/QaxbVBKt3mQQQ7QOISnHsrtsz2zUed?=
 =?us-ascii?Q?Fwo52b1hGxs2Qp5/GYtq/L+ZCOCYrwAtfrjwRhRQ5z0GgkRapZTKUx4CLT/k?=
 =?us-ascii?Q?4+PMNmhfi40URujrIqszt7H+wp5HWAJgIIVeGpUHWf2Fwh8AtVqjyrMZaFwG?=
 =?us-ascii?Q?Wa2qc3JDAwqaL76X4XuDS6Qlj8QSR1zNqVCrdWTy0HHc2ORJ5ug9NJyEZt3y?=
 =?us-ascii?Q?PA71o21tNIfyMiTfCcP80vJBQSxh8PK39KzqY25PbJKs2mqJQXV/TlRU+9kX?=
 =?us-ascii?Q?pBpsBx70ie57Ivub3w/OmRQzZnRCUM4OesN0ACkWSWtHwLmTSF9VDQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4500.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?leJGvttsKoI+Tx1pINKmPh5ERkc8B98SI2+qhVOR33mzU5MXhXnyrOLqu0YS?=
 =?us-ascii?Q?1iRnSZeikha0mvphS2ui9xA/e1Bek1n4yqTrubP5kxFZOgPzuxhZjLH4nZ0Q?=
 =?us-ascii?Q?zEyUBYQvrn5+wDXZH/6V95pgngOhSyBp/9+ZqNrllm9BMQ2aEUHn9tSPWlZ9?=
 =?us-ascii?Q?RTN0c8yzFv1+B69i6oW1X1eQcztm8EHAcgxwxYgOVj1of51mkOkko4Wjiv1P?=
 =?us-ascii?Q?IWt6VOju8T77zNRupOttd2o+dYExjVOTlHje+xeoO4CWdrvQMPcJWsoGEQ2V?=
 =?us-ascii?Q?hunpS/p52moukJBbukKcfBniQw9RQPlgjUf4Q2a8H2Nekd37aeNPddGVTjvb?=
 =?us-ascii?Q?MMlYb1RNJAwhQRuVtuJUnhJBKNRWO7DcN5JwtbyejKEQ1tp8ez6yU26WGS7d?=
 =?us-ascii?Q?b91ceepR6+lZxXo3HU9K5oheRynmqNBZ1XXBdt85CaKaYKaISJs8/wAA1XKn?=
 =?us-ascii?Q?b62YFU8J75AQ1fOZfD5GDy0G0A3V2KqXz7OqM/NWL0m6YuoQPHllQrQkpSsO?=
 =?us-ascii?Q?7vMSanAv8BiZwMCfDtwLll0jYnDd70uMbgfqTsGnhmMJQE1BCx5n6JRnTOPW?=
 =?us-ascii?Q?w+KMFcyDY63UJ6XjJXigWR3vfsjB8fVrmkavT8+SGDtfHCXglIX7oiqzUXhz?=
 =?us-ascii?Q?xnN4lEglGth6LYPAxrkY0O2G1HaviRy/8iqPdFslOuHbAo0CMbXg+ox+J8BK?=
 =?us-ascii?Q?g33yCBkj9+QAFTULztukJKoopgQdXh5boUa5s2nsU0aV2qiqwdG0B/dNwm4T?=
 =?us-ascii?Q?5NU3CqRjd3LeJvcMOsSXXwKGnJWffCO14G1CaN8o+OG6FMO5T0ds1TxMqpAq?=
 =?us-ascii?Q?zggO203g07Wr3uZwjt2YOSrbkNMx7r0K083iIIKGIFn4du78mESo7xJwWFPQ?=
 =?us-ascii?Q?2Ozie+WlACIa6NS7pBUZmvlmVP3081e42Ig70tSHeQyizLLB6J3310AB8BE4?=
 =?us-ascii?Q?JRIuwz2aWi/WgkB8MTgeMmF0GOcG6Ct/P711wJoqqRSw0XXA59rLVmythwpm?=
 =?us-ascii?Q?2ATQ0SV2xoBB3yCCQdRt8YJy6yO0B3MSYCKW9X9ir20E/xrjoXLe8LLD0y2L?=
 =?us-ascii?Q?R/3Y4D/tVf/zL97S7byK708hl4yfRmhKe5kxKcOFj04+wUW3S8Yb71KC3usf?=
 =?us-ascii?Q?BHv7C46N9f5sItyJ/hnZDzS04b25ivqx01ApDhiEX1d2EMpf8FWNED7+BoV8?=
 =?us-ascii?Q?x5tiEYlGOblHPJ7VniOACpvd7w0BeQJ9H7/NrhD2J7c5lJAbDod44LqMtoBe?=
 =?us-ascii?Q?jqNDn5PEmYoLmh7G69ZLxnr2aAF/ZAmG6BHCtD2R3AL1j6umUguxuvJ6LhQA?=
 =?us-ascii?Q?HkZIknLUHSSxGRmXKvKk6eMHjl6hv0P3gzEYLN8Ry94Uwgc9GdciiRlp48fN?=
 =?us-ascii?Q?GeTkwD6UZ749aggEzVQiMw4MMHyiQK0m5eoP1g6V0MoKUHD78hDbS0Aj74wJ?=
 =?us-ascii?Q?EQlHBsuEhrE1iVTcUyVGB17u6rjViKbEyX7vF10kJbdDXB4o9Og490dZW0ze?=
 =?us-ascii?Q?XT9/z3FtMlOBXEFudakjEhF4m5npgi6ogXYZaL+kRlmtY8CSWChRHMkTdlKG?=
 =?us-ascii?Q?7LzfkV6hAqYAz8cdRYWnoGUXCa2ggQ/+VxPkx3qcZJMbJXGnYQzNZDNF1Zm+?=
 =?us-ascii?Q?m3f2Mzcm85TDtGbTbAMAPwssQaa4FVtr0KSS4cQ3M7g8Wc2DPIksNP59QgyH?=
 =?us-ascii?Q?SVGTcQnCf63psvThVXH3C5jUvVK9GuiWDlbx17wvtYNEmNsZyGpAUv7Y/UWx?=
 =?us-ascii?Q?1HdRR1f7d0YARfYNMPIQpDHmGjPMTn8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OwS27yowEGYtflKvbTtDh+tkDTXIg7qR/B2hZeXLMzNH0GXUSagcKpRO1DMAGwY7x5B5lmKDjcUy7zTcZwrDiYvvnmwei8TP39eXnoYpWjEGCMmPhzv3ydAR2QtfHrdqLdq0DcSQcJg7uaiqr3mrvSHs4rZMKVn6NnrbyWhlbE2ebo/2vx6/dcoJv63+XCm7s1Ym8v74bo+T9GQDtmH6AuCK/5grlsMIfaurLwnmDTq3XZf3aQIfC5s0rvhA+84xNUh1XfUd+rvrC9/Ep3x8F83CwE0ofvYZ6X5POzIMq4+G1yOuzHHlhcZAndFzuZ7HOw/Rl0qe0vQfB2mvi+o8LrEvvf6njRl+rRvwZSvUysQpy6nkfC5wKuGkDgGDrPp2rFygfuWWmeptJ7/d2Mt8WkUDAV2HJeicooyHUQj3xwW4ZZOnDZifNNC1PDIANHrh6EQEcOtlTKlhuPVm3Sr4+B3Jin5fmvkuTrmgTlQfrc3TJjaKFqNBNEJWdOe3qdEPcBgVRYT+68qQvOM2JIevnq6cT3OVy57aL0A7XQWl18mwxz2Bdf/XY9jqSuZuKc2UIgeSQKWcItu14ijXf7/dO6u17cqctIUbWsudI5O2zFE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9e8920-0bae-49b0-7a70-08de4d4a39ca
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4500.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 17:37:12.8624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VP3+oNNPR7HJnsgyBFAdv8hQisi5okN6S4zc8ZN/xcL6W7kUJm9DdP/CaLb4j1/GPJGT7dSOqb27zMeC26VWnaARjLc4So6MvM4vzeft2FA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6311
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601060152
X-Authority-Analysis: v=2.4 cv=R6gO2NRX c=1 sm=1 tr=0 ts=695d484c b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=mDV3o1hIAAAA:8 a=yPCof4ZbAAAA:8
 a=pGLkceISAAAA:8 a=3k1YfKFluj5yiSLoflwA:9 cc=ntf awl=host:13654
X-Proofpoint-ORIG-GUID: -fu0GC3ke8rW2T8X8muYvbQrvnklUuLh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDE1MyBTYWx0ZWRfX4IVUmtv3kk0z
 gGY//H8x+ZV1XtSQd9fscrVqkLRnWpS3mdw3yS18lGDTlFmGi2kKe3erjXLCqUNlw52TNxMvGqT
 of54P6Op/e936+km7BFrXj9Sqvcupt0y2DiWlviQp6lzkA6gtX/s2qosBZNInZQGvWprT5zHW7R
 QrJAGZhirgmuoXTgmifmtYa7dhNvODh1poEHGpDYb2DjptPd8RY6kKxnB/fh6sOSwfbXtde7GsZ
 ebymeOTWwxFO3IIQr9nIV++oXqaCmmv9dymb+Nq5QUg020NTmCLEBMrlPo99tjkIyx5ib/alNS1
 a7Tx30dsfBllIHMMWTe90qnt9siGgalYmtG6EWHzXaQ+i3ywVhx1DbijWUo08vJmjcGNfccBC5g
 ZUfVUAcGix8kONs2tedjpNva9MgBlGsKiGrAwnAk0aIGU0ixb6+NJR34oCK/lL0lRSa+nSnbHLs
 Qxct9ady7xKaw/0+VXDBIgMG8SBru2Ig3r93Rwh4=
X-Proofpoint-GUID: -fu0GC3ke8rW2T8X8muYvbQrvnklUuLh

GCC 16 has changed the semantics of -Wunused-but-set-variable, as well
as introducing new options -Wunused-but-set-variable={0,1,2,3} to
adjust the level of support.

One of the changes is that GCC now treats 'sum += 1' and 'sum++' as
non-usage, whereas clang (and GCC < 16) considers the first as usage
and the second as non-usage, which is sort of inconsistent.

The GCC 16 -Wunused-but-set-variable=2 option implements the previous
semantics of -Wunused-but-set-variable, but since it is a new option,
it cannot be used unconditionally for forward-compatibility, just for
backwards-compatibility.

So this patch adds pragmas to the two self-tests impacted by this,
progs/free_timer.c and progs/rcu_read_lock.c, to make gcc to ignore
-Wunused-but-set-variable warnings when compiling them with GCC > 15.

See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=44677#c25 for details
on why this regression got introduced in GCC upstream.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: david.faust@oracle.com
Cc: cupertino.miranda@oracle.com
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/progs/free_timer.c    | 10 ++++++++++
 tools/testing/selftests/bpf/progs/rcu_read_lock.c | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/free_timer.c b/tools/testing/selftests/bpf/progs/free_timer.c
index 4501ae8fc414..eccb2d47db43 100644
--- a/tools/testing/selftests/bpf/progs/free_timer.c
+++ b/tools/testing/selftests/bpf/progs/free_timer.c
@@ -7,6 +7,16 @@
 
 #define MAX_ENTRIES 8
 
+/* clang considers 'sum += 1' as usage but 'sum++' as non-usage.  GCC
+ * is more consistent and considers both 'sum += 1' and 'sum++' as
+ * non-usage.  This triggers warnings in the functions below.
+ *
+ * Starting with GCC 16 -Wunused-but-set-variable=2 can be used to
+ * mimic clang's behavior.  */
+#if !defined(__clang__) && __GNUC__ > 15
+#pragma GCC diagnostic ignored "-Wunused-but-set-variable"
+#endif
+
 struct map_value {
 	struct bpf_timer timer;
 };
diff --git a/tools/testing/selftests/bpf/progs/rcu_read_lock.c b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
index d70c28824bbe..b4e073168fb1 100644
--- a/tools/testing/selftests/bpf/progs/rcu_read_lock.c
+++ b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
@@ -7,6 +7,16 @@
 #include "bpf_tracing_net.h"
 #include "bpf_misc.h"
 
+/* clang considers 'sum += 1' as usage but 'sum++' as non-usage.  GCC
+ * is more consistent and considers both 'sum += 1' and 'sum++' as
+ * non-usage.  This triggers warnings in the functions below.
+ *
+ * Starting with GCC 16 -Wunused-but-set-variable=2 can be used to
+ * mimic clang's behavior.  */
+#if !defined(__clang__) && __GNUC__ > 15
+#pragma GCC diagnostic ignored "-Wunused-but-set-variable"
+#endif
+
 char _license[] SEC("license") = "GPL";
 
 struct {
-- 
2.30.2


