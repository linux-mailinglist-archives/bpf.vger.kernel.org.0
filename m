Return-Path: <bpf+bounces-55026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF778A772F7
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 05:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D53793ABFBB
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 03:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C51C1C7006;
	Tue,  1 Apr 2025 03:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lGLMddT9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c3X+300t"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A2433F6;
	Tue,  1 Apr 2025 03:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743478164; cv=fail; b=P1ltbHcI+1kWTXhZO6SFLYo2dhrvZ3NzUC08lN7tQpYblclx/LyivmBj+AjmzNC9+wDqAIOZScR4tOZjRHv43M5fthX6bbIW29nI/vcvHoh8TtY1smZP5F5dgZzUSRQbMcrZuYq6F9vHKoGfCSdi/ca0aPXElpBd7usc960R308=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743478164; c=relaxed/simple;
	bh=4TBmPiKHiCaRnODvrrh/29r3+LCGjUXrngoRrBoishc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KwOz83/N16Jo436BUGMdgATeCMXGauJ7xH3Q85e/IiNT+3Huo68kPwL/Rbl60jx9hHMZuXOZPIHJmRNH0LARaiBseZj+x43vEMAu9muIEMekbvQZIKlfIUf6TDwJrBMEVViS31ReOn62Op0POTYKXPJlJgmADv/yVhOmVY5GXog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lGLMddT9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c3X+300t; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5312veOK019207;
	Tue, 1 Apr 2025 03:28:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=86VIwq2porwz1FFrwj
	nrJHxCzik7Lx3YKKQ+Pmbzowc=; b=lGLMddT97p4MhZL3vSQT5J6+UCLzQtvakZ
	AS/aQ0knQrTg32/ea8NjlkCBIPFrL44i+1y1uMt/P83JoeoxVmzCvZJ+xH5aju8g
	u36wEGrYPs15JMJCNVe/8AnypKJjXnGPnxeDXeGXzMh5ODDKxk/NF5ew3/2G/9av
	yZVjLHEZWfCJNEwKAF6IEspl/dFxsX/3Rtb2V+YaGloMrcgKlb7afIveiXSAiVU2
	cefErsCaHVYmCKtU/62yupujQ8X1A5jDUUQe8YUmcBSufVWCHoNAwgcmMi4fwUFe
	YRGji5W2tqmxNUdPuq4AfrZvxH9o4JVasaLg73qnpKZX+2OSO1FQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p7n25bmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Apr 2025 03:28:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5313AC1j010838;
	Tue, 1 Apr 2025 03:28:35 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2049.outbound.protection.outlook.com [104.47.57.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45p7aer5k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Apr 2025 03:28:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dDlbf2SoFsW6v5z1/FgRzqMvVdziyZJEFcHHmJkN2c10/0AhwPmcAcNIENCKbBJV/m+FnQoezkaW8ar1CEbBQIkjesj0Y27tjCiUC6K1T3bRqOkFWquWWqGrCLVIPA4k13H58dPJ24yyW4U3LvETyx9TOve/YkXRmkw7pOKVbpI8vUeMyZmhEd6aIb6i9sF1pU4OexEbS60vW2cMHHcrWYHWWHJUUmwvbPjqMWiHCKomd+nlX34qnEUeog5KiVt7F5fODvX2/mmjdu9uV6+5k7CiR4OXfpgFiIhgAOiN1ISw69Qd0V/AsJuJWK2N1fOMT8CyRwbkmTauK3DwFx1UoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86VIwq2porwz1FFrwjnrJHxCzik7Lx3YKKQ+Pmbzowc=;
 b=e27ePn2mHGBkIPXb15RwpLYFKH5chwfDHRZuohtPvPmTMNz35Jte4pc1G+4Cs22uyP5ZAE/sgvcb2HCD1St4BPoh+/0lk1mq86qmGhePQIlk6xj2567JnMUxQSb7Itt4q99Qt6VNdw33hk8WIN/xVJ0UKsHlh0hWv6sRXeSQXKRChEiYr+9OjSByiIZU/XVxW1s7Y0iXMnDmDhcBkKoyqbh0Owjqur2cLyVzmrBIRblWsubAJPqAYsVvDNOg2uslv5fiUs6oAiRMXLZ/2IXWEMRyFDlgcZW9IlfRiuEa2WHyG6qdnO9ikCVXnr1kGqjYbHGOYt33amb2oMO+ESYyiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86VIwq2porwz1FFrwjnrJHxCzik7Lx3YKKQ+Pmbzowc=;
 b=c3X+300tOsQ8sEL+CrBDa5x5cm6rX2/BifSEZ+0E3wt40V36VTZtkMooz1tEulZeLU2YHDpkadTbuT7ylU1+tYVjhV5Nf72LQ7thIAWPCMEisejjUa3ur9E9odbdktaUuaJj1UyaPEzbTXEf+1ezxaTWeRm8cSpmD5k1rS4BVfA=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.38; Tue, 1 Apr
 2025 03:28:33 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8583.038; Tue, 1 Apr 2025
 03:28:33 +0000
Date: Tue, 1 Apr 2025 12:28:25 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, bpf@vger.kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        akpm@linux-foundation.org, peterz@infradead.org, vbabka@suse.cz,
        bigeasy@linutronix.de, rostedt@goodmis.org, shakeel.butt@linux.dev,
        mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm] mm/page_alloc: Avoid second trylock of zone->lock
Message-ID: <Z-tdWXcv1Zqim2ng@harry>
References: <20250331002809.94758-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331002809.94758-1-alexei.starovoitov@gmail.com>
X-ClientProxiedBy: SE2P216CA0192.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c5::10) To DS0PR10MB7341.namprd10.prod.outlook.com
 (2603:10b6:8:f8::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|BN0PR10MB5143:EE_
X-MS-Office365-Filtering-Correlation-Id: b3954e46-3d6a-409b-5c34-08dd70cd478b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KhtXznoyfhgMSDj/ovs9Fx3AI7FQtTYDtAbBjWxvv1QUltKA7EZzEiH4n0QW?=
 =?us-ascii?Q?vGXeztr7Hd+vqYU09kF7JVswRAimzv9g8K5NobbN6zkZsItJyXAU8TNygMNX?=
 =?us-ascii?Q?gbeKeX+CQH1tj+xMHwn13vsvR88V4Q0eKyCwLdnQLiiHgAOUmpnbM31+0XTR?=
 =?us-ascii?Q?my1SnZISOoZDyozXcINJjedPU+EAUFKKKJvGrsjYCK1+wRIUDjpWkCG30+on?=
 =?us-ascii?Q?m4LPCoEPr/J6j0LqP9fvq/HB9m0ScujLXhsojWtyngTCIVH5h67cHtiTg6i/?=
 =?us-ascii?Q?D22YOuEZKuBZuNBPhB1FPZ5JPsd6YZ8KjDEDWhHTPeesGKdR86fzlyqQaKl9?=
 =?us-ascii?Q?r0KPBVFDr0Fy0e7tDokRoaElLOWW7dxNKvkDDsKZrgCL8pRQVYh3jNLOgxmN?=
 =?us-ascii?Q?gyFPOTzVXlJ4y5Y8sFvNEmvolCLUnHG/xRPk+AbHBw/NK8QaqLNEC/+kOnKR?=
 =?us-ascii?Q?ztKTETxBKNW+UnFXnloZpa6LART6GyyEqt662OcI6+AIIImSo9NFmlN+hU8O?=
 =?us-ascii?Q?La0Cql9wXAMZ9nKw4XZ6DDyql3bG2C4auOFU8RJh8dr+1BoQGWqiQ0ybPgAc?=
 =?us-ascii?Q?CfEGzRzlkc53GuPLiTg7p6zGKPiZTCFYAOOnLwAmh6AItAjVrwpNwBHRGrTZ?=
 =?us-ascii?Q?foSb+dJqoJ9I95RucMabZZziq0yI0Sqq3a8hOwk1LN1FSmXmlK00dZljZqnf?=
 =?us-ascii?Q?37koJX2s1i4p2PgrM+1jXOkKSB7G8kpbZw7gihhKT9Ii1TYiHE3tW1C0fbJb?=
 =?us-ascii?Q?/ToVeu4wqRll6TxazsTYQkPoLypgRIYet1IiVGAIE2V5ZoLHfF9rUWbK/+3c?=
 =?us-ascii?Q?RJz+Vm26QCQnT4TQU3tec5GCWcWG8H2D18qbiOych32xoV50up4mE0zgLsHQ?=
 =?us-ascii?Q?ET37WngmkHILTicIUxQiZu0g1bJZ9s/FqB0ng1pTgH7xiuxWRcWNif5Cspdx?=
 =?us-ascii?Q?oJbr1K6x+/ax7DEmSh7ddCrbO7PVDY+onB2v4MH9+7r85nlWoo4+hr/FnngJ?=
 =?us-ascii?Q?ufVyVcyhyB0BxRUfq/DagA+BnemFTZ5+JTkXCWtZM0iiCOJi8fJCybAgzq/G?=
 =?us-ascii?Q?eD5MRfbMKtXSOdsJn4iCeo3s3uylT9sl6xMWdYD0MDmAkJ09zj5o8loPX3+C?=
 =?us-ascii?Q?IYZfRYGc5b/tbGnyGiZEgqUxS24gHnXpXs76/IoR2N69/gzv62oe6GcWur4R?=
 =?us-ascii?Q?JdK6COPcQQq2ty5JBwlZlmqR9KMdWtb1Lo6FE9yGHbvhikv4it75b7j781ym?=
 =?us-ascii?Q?/QZdqW1i6gmDX8iqPkx4Eg0dKKO/HdVAoPMWOsqEqgRq0x1CPRci6SOBwO+X?=
 =?us-ascii?Q?+W0pjvLBNGpWTyhZStrnEN82Ersn+3CNvkBA56UDZImy6L0Q/snLBjVdDc5N?=
 =?us-ascii?Q?FL85YiYs+DFwODME9dNY3mQ//D3P?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9Oz4RLsziF4maolnFAVeRQwk7icWd4jpMU2uvjS6NhLUI9FstJuSJH5RgzhM?=
 =?us-ascii?Q?UP82KMzTC5CPEuek2Sxjtsxt133kQbioyw0TFfuqa7rz331sB/i5cJZROzke?=
 =?us-ascii?Q?MJHruw07kTQ21qjiZaF/4/Z4OET0VuqReIZuMHZ2hZmS51KidsS19XG4jyaq?=
 =?us-ascii?Q?vPhmdxgh2x5H2b9RKoMnazjLZWNc0peXpVS23amRDZ2qXA0bHoPMKuizMy59?=
 =?us-ascii?Q?cc5sIYvneQ7q9try2YiN5wGNfVoM2JG2gA90fwQNWGQXGpTn9U0XdWguxGQC?=
 =?us-ascii?Q?rBoxn61l2uvbbZcMUsWeOhNLbUCv6P1yMkoDjg6VqzpRbiohd+dnh4NvIBcn?=
 =?us-ascii?Q?ixlmZDOPK7l5Yzf7myJDCyfWKr1E4qM1Y4cBRpW6tuH7NYZkYeFewFHrna7f?=
 =?us-ascii?Q?nemR5I+Cfal1JW5ghheEG7luhesukqSAVLYzYselZb50DFmZ2Z4tvIWjvUHj?=
 =?us-ascii?Q?mH/UmYzEWG2ANiBlIT1f7k3Z9u00s5/9TO6hxSdHs34LFhKbmKD2HGECE35P?=
 =?us-ascii?Q?eDdoqumGKgKn1XAI7iRfpMdOKPEsetxncodCc49iD3N37yjOdTtzYZGp/cYU?=
 =?us-ascii?Q?O7iK5T9uotyTCRQpi1Wgs6PxD3rifiISQdCRcc1RBvfP9cIyOU3tVUoCVXs9?=
 =?us-ascii?Q?1fPjqVjGE0R6Btiak1GFkU5DwVBAUPipPduKeuDPExqdN84bI+1UxWKH7s2N?=
 =?us-ascii?Q?lY79u9YIDQ3alRdyRhhp/hsvvQWRguTiFKTCZz2tcL/Dj/9sU55/Yi3OjIQ6?=
 =?us-ascii?Q?UJuSLCp8s1qrLfQtOrQKTwvKEC2OpW6895eu0pU9daOMEaz8NcmedlHHG+sQ?=
 =?us-ascii?Q?aobCkQMH5i5fpG/pTciISvQjEwoSL+xt54MD3KMFS5g0QzeJniPheVnucvfF?=
 =?us-ascii?Q?6jW7u6kgXHHpl6QsHcf76i3ZJfupfexR6dJ8ND0tu8N9Wrn0f7UUzRFzhY+x?=
 =?us-ascii?Q?AmkP0/48EEbLsN8KXYYnVSKsbPJH9BiAZHCgjW1JCgVapAfegS268fClmSOD?=
 =?us-ascii?Q?nu2xgrLhiWVyt+ZvyoLo7HsTgikpgk/sU0GVOme+3kiDbG7GjoKrsFvudM1R?=
 =?us-ascii?Q?/tAoFmfGrRqz3JhIVoYNGdqVcbSJnZeO79XUYnvqGIYznjRwumZSYOTnBNTG?=
 =?us-ascii?Q?UOk+pPi2y27Sl0VTj660rPkzs5N55PwFSCfqWcSRB8Z2XkOPIourgWUA0kPG?=
 =?us-ascii?Q?VVS6wWZOTJ5zBRO67lBeHpMHm17FlsuRBqcXIim75svlfUVA4FW4wfZXtMo6?=
 =?us-ascii?Q?/kh7DrT3wr+JiE5GGp1gkmIl4T/XMzj8LN9f719U2sVPq2IqdbbAY0/Om1pY?=
 =?us-ascii?Q?TrKccgVH5tMG5gYatRCs4dRoyyLjVA2Rn3p/+uD4tL/RPfpqdh27eg1JOAwC?=
 =?us-ascii?Q?gcY/OsceQFNkfJgo9cGFhL/4YsTO3WfTLk1yTHIiBBGADAhu9yGxR78aCIQr?=
 =?us-ascii?Q?RE4Z2CfQ37MEK3+E1WsiqE4DtgYiZN+ksla41SaUkiGnHl2ZTGDiFgKWZcnd?=
 =?us-ascii?Q?KzY5hhgq/PhSmsaK6iLiq9gVL/QhxDNDbOMWOR48Zio0h9HRp+m4lGcWBNiR?=
 =?us-ascii?Q?6Scn84jDTCeV8LZ3xo+uz+seH2c2HFqYPXBfiZd6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	j1VezTJpoznsgdpiLxMrJWHcyKJaXQEg8loqfqOguWtJJu3KEoSJ6hBv4NgAoTrPd7aYoVQxKK9d2rA+vB8mry83cY1rZryppIgRANjtXjaMMt3A36G3KXY8GnN1ktQE7GrlnbnOfNm7tuZsTTZ8le7H8h7tAzIW1TI2wscvoafxAd18ADU19vT5oYfyrmFgSLE0ECeDagyzLxMxwRJPlAwkOJk1QDCRyaJEpcpjmhAFcotJd2za3rlzGuTbJwnd7UXGzvvWGaUSyN1FohQSbzxZfr949kRN36pDg4/giaXrLbg7JU8LYYdnD3EjwL8Q7GDGHUZNxWNhYWUBB5lJOReMOZOTqR/WSzbqkkzpaX3XOciTAuaXQWCozL/1sU5BOIA/Y/efk/WS/PLNME7HC6vgowG4FVgSsyBVisg6FFzMU5pxnWlTPeeF1kbahGzHcSfk4XSbRnV5e9ZcWJ1Ed5RQSJ4kqvdDf1L+PZJ/pZDuvGFBhkJeodOoe4jIP2npd4K8rw53m/n/Ouj/H+9YmCTEC3hUhFmWLLklIYSqfdHT0rHeSBdv9H+BA3eboSg+FZs+gP3p5WyCZJcq/0ksmjBjYXYesP2zrkny6MXcesI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3954e46-3d6a-409b-5c34-08dd70cd478b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7341.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 03:28:33.2150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w0sd3ofSh8EObDfvC0IyBKJyb0ztnnSZ4ScVbYkO+aXcsCHpHKZvvTTaHLgQwg0tdShyX8GzHgzwC46ScyzbkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5143
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_01,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504010010
X-Proofpoint-ORIG-GUID: tfXqst6m3OeW_tTney7WV1YL2b59B1bw
X-Proofpoint-GUID: tfXqst6m3OeW_tTney7WV1YL2b59B1bw

On Sun, Mar 30, 2025 at 05:28:09PM -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> spin_trylock followed by spin_lock will cause extra write cache
> access. If the lock is contended it may cause unnecessary cache
> line bouncing and will execute redundant irq restore/save pair.
> Therefore, check alloc/fpi_flags first and use spin_trylock or
> spin_lock.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Fixes: 97769a53f117 ("mm, bpf: Introduce try_alloc_pages() for opportunistic page allocation")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

>  mm/page_alloc.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e3ea5bf5c459..ffbb5678bc2f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1268,11 +1268,12 @@ static void free_one_page(struct zone *zone, struct page *page,
>  	struct llist_head *llhead;
>  	unsigned long flags;
>  
> -	if (!spin_trylock_irqsave(&zone->lock, flags)) {
> -		if (unlikely(fpi_flags & FPI_TRYLOCK)) {
> +	if (unlikely(fpi_flags & FPI_TRYLOCK)) {
> +		if (!spin_trylock_irqsave(&zone->lock, flags)) {
>  			add_page_to_zone_llist(zone, page, order);
>  			return;
>  		}
> +	} else {
>  		spin_lock_irqsave(&zone->lock, flags);
>  	}
>  
> @@ -2341,9 +2342,10 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
>  	unsigned long flags;
>  	int i;
>  
> -	if (!spin_trylock_irqsave(&zone->lock, flags)) {
> -		if (unlikely(alloc_flags & ALLOC_TRYLOCK))
> +	if (unlikely(alloc_flags & ALLOC_TRYLOCK)) {
> +		if (!spin_trylock_irqsave(&zone->lock, flags))
>  			return 0;
> +	} else {
>  		spin_lock_irqsave(&zone->lock, flags);
>  	}
>  	for (i = 0; i < count; ++i) {
> @@ -2964,9 +2966,10 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
>  
>  	do {
>  		page = NULL;
> -		if (!spin_trylock_irqsave(&zone->lock, flags)) {
> -			if (unlikely(alloc_flags & ALLOC_TRYLOCK))
> +		if (unlikely(alloc_flags & ALLOC_TRYLOCK)) {
> +			if (!spin_trylock_irqsave(&zone->lock, flags))
>  				return NULL;
> +		} else {
>  			spin_lock_irqsave(&zone->lock, flags);
>  		}
>  		if (alloc_flags & ALLOC_HIGHATOMIC)
> -- 
> 2.47.1
> 
> 

-- 
Cheers,
Harry (formerly known as Hyeonggon)

