Return-Path: <bpf+bounces-55652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6521DA842EA
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 14:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3497A189B5ED
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 12:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C89284B3A;
	Thu, 10 Apr 2025 12:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wye5TYs8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TjLDJfT5"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DBA1E0B62;
	Thu, 10 Apr 2025 12:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744287679; cv=fail; b=Y7M7XKdUIZQVCuZOASydxY8O3540oJOU17fX9KaP1nCcTSc2wF5yFO2u85bY60yMHPImjpd746zYvqjOLSX34lOI7hD7jl4Avvxr20APT09gVq7swUX8bduHXsoH2G4yUZJO6mrEm2YcBePrenLhsYY2j/bMuJQBCLdaWgIBoSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744287679; c=relaxed/simple;
	bh=bAhieTeaBc+R5JprEVjZwdrEctZmVIOMDquLlbPKeKE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XW3suHeyjLtagHgNUCNsuOx9y+Osl23qmqVbRg67mdCkoRSLwHqZCe1QMQ69vfojKwZZQmS2FeIrXZIYZJRGwEwwjbfGx/GEnrkZ+QRV7w6maDpqs0smRvImJKA4GUNvzVPwrS8ohxfW3the1HeQtzu051baEeBErsXccpTEVHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Wye5TYs8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TjLDJfT5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53ACHmsX016688;
	Thu, 10 Apr 2025 12:20:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=FgJO6/YO4q0kySN4XQWEbdkH9JZycngPbD66UziR6Co=; b=
	Wye5TYs8okMawAuTJUEQ8PeXK7bSGICePNOivS0ho3JjDKJ7qSHiOaxv2nHKLq9r
	U6TUJDeqNMw1IInZos9D8XkEhYGqSuKSFpHNnlk+KRrl2U6by43W7NjU69BRQIPQ
	G9KJ04OXdkEdr5AAKTT0h47bRadmML5Sbj8N8sjHTP7ZfVgOobyHwOPMqVMbueMz
	r1zN8b+0Fme2Muz2CIqIyPtib0Vh9qRPFPmhnlT6E3MXGPHodzU4VXzKm1CYZEHA
	qYsONP0qwe02MpvCgtS/2atEVJWmL5GIlo2SOwUEhV/6oMGyDISKvo6ImBv+WcdU
	YukF3ktuqifafJYpIyyGbw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45xc6406u6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 12:20:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53ABUJWk023825;
	Thu, 10 Apr 2025 12:20:53 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azlp17010007.outbound.protection.outlook.com [40.93.10.7])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyjgmf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 12:20:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQuiGT5lKlJPv6ZzWhhz881yGFYmquaTvYmGPIFlWOn9Q3ULX/k8bfiKiONxTB0i/YWRVzT/Gi7xvl0DojDziXzxyQPK0lD+pRZo5Z3+VEYRyuSs3OsBq0Kmmjo15fNe7Kgq2sx48JW2rsYV56+B+8q4GkbHnQGP2AEL3oR0fVmHD7ilEE19ONJGed8CaWoLBsEQFoDnOPkZbVk0OhzpkyI5JUoN3Ec4xRN0Jss3iM196/+XIAEe3qADKzsBecAbmGOBxBHifr7ntRr6FDNQJ/TYv9AUULcFAThu20tDbh9iOLfPcNxduevdXXvj9cbEB18ROAdcfFL6IcWK80bWww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgJO6/YO4q0kySN4XQWEbdkH9JZycngPbD66UziR6Co=;
 b=eRiCnuRzBI2N5XUIsoV68NpjljaJgbsx+U0K9UQh3ykyRaDwMpH0zZLYZqtX5ma82Ag9R3eQBkA3KG0ZAxEGsC8F94g03nAmXUAP4k2Wpiw7e2iM/RdweJzMSWLJ6LHvOsRwEJ6snFnzVjZKNG7WygmoNBzgcR4uBGwSFwY6IBamI+BF5Ykn/nIw/duHJm706+lyGMIwpMcOI6Jbw4Q6/3yyuH/u3v6b6z2CEZ779HN6op9mx2KmJz+reWwOulOmIcppudlacIfaQBvLtQGX9b7DK28lZCVN7gXrcX73hduhyZbU9V+9NTre9g21tan2dLUYw62o2y88qmVmy+MqQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgJO6/YO4q0kySN4XQWEbdkH9JZycngPbD66UziR6Co=;
 b=TjLDJfT5DpBN/fgxcAMLsGroi54dHEBRxxtgiy9gAss8ZFyEcD42xytazynw9MNEkM2gMTjO/J5kYHMPj/TlLplHs4KptG9U1RdtDuQ0c5OPiOQpjGmzvKkSDApDgmeJdV19LGPzSyEvSUaCPUfxnIntT4NJ9nVwXz/D7eaWpoo=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CH4PR10MB8098.namprd10.prod.outlook.com (2603:10b6:610:238::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Thu, 10 Apr
 2025 12:20:50 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%5]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 12:20:50 +0000
Message-ID: <07d92da1-36f3-44d2-a0a4-cf7dabf278c6@oracle.com>
Date: Thu, 10 Apr 2025 13:20:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v1] dwarf_loader: Fix skipped encoding of function
 BTF on 32-bit systems
To: Tony Ambardar <tony.ambardar@gmail.com>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yonghong.song@linux.dev>
References: <20250410083359.198724-1-tony.ambardar@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20250410083359.198724-1-tony.ambardar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0266.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::19) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CH4PR10MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b9f11ae-8653-4a03-2db8-08dd782a218e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDhiUE03RS9yVlR2Mk84REttckFLaVppT0NMMm1DWDlTQStCbk0yKy8wd3Fy?=
 =?utf-8?B?YTJGZFNiM20vTDJiYmJ1ZTJMSFlmeTU3VVlkWjFnRWQ0dHNFcnNYZDF1b3BV?=
 =?utf-8?B?MWVtQlhNa3ZOd1pCSnhySjVTb3JUaE5rTTVwV1hiMFYrRFVSck1PdlNQSXhN?=
 =?utf-8?B?b2E0SVh2aS9pdi9yZ3FkbW5JYThMRGNsMDgrRHRQT1ZhWkFqZFFYRWFxWE8v?=
 =?utf-8?B?OHFCTnpWZ3pDMFJVUkk0OFZJMUZ5NUVPRk5WU3c3STYzR28yQ0UwcGpLc3dT?=
 =?utf-8?B?RzJYZk1FNGREMkIzVnZCdzN0dDBhS0N2QzFjTWpWbVdzWmpXeWhEendKWktI?=
 =?utf-8?B?RUYwOVVueW4ya2Uxd0daYlpRWkZxQ2tTMnNOWE1Cd3QzczdJU2t1UjNvVy9U?=
 =?utf-8?B?YkM3OGluZW8rWEJqSGR1TG40b3JqOUl6ODh1MTFhV0diVVFYZm5MeUZhTkRK?=
 =?utf-8?B?bzJTcTlFbzBGajZ3TGZweDcrcXJDQ0k2MzcwUW1MZVFMVDE0ajJ0ajF6QVov?=
 =?utf-8?B?d0NseENEaXA3QTNtYkRKSTNRZGcrUWhzMm5jMWN3azFZbDhra2dkeWcvZzBF?=
 =?utf-8?B?MnB4UE9hT0RQcTVhaXdaazJweDdhK2ZrQnYycTNPOXY0dUJmeERwdGtRL0VZ?=
 =?utf-8?B?WlZVTjhhMmduenV2RGJiWXRjekc4R2RydzcvY0RvT2JaWnhKNlAvWnVqblMw?=
 =?utf-8?B?TStZTjNTbW1ydXBxTW1ESDVwYjZSWmpCbm9hdWtkOGN2K1RYNHlXMko3K3pS?=
 =?utf-8?B?TlpuWVdTT0tKZlBTRkpjQ2I2dnV0NzZDWXc1ck5CYTQyalN2ZS9QK3hCVTlN?=
 =?utf-8?B?QkY3MVU3TkFpdUY4cmpsSjNhWWpKMERMdmhMdVZYQzVhQ25Cdy84cGdNY2c3?=
 =?utf-8?B?NXJ4ckpuc242NU9tTk5yT0RVUU5Ga1c4RnRFYWNKV1l3eGxEc3RnUFBLYlNL?=
 =?utf-8?B?eEZaZkhENk1XRmpZRFl2Z3prSFZaVHZUNE40c1Z6N1JKcnkwQjBUcDJicnc5?=
 =?utf-8?B?NDB6c2dZV1pmcG80Ym1pZ0I0Rm5lWFdRRmNXT0xycWJZcGNwY1NRd09oRWhJ?=
 =?utf-8?B?b2IyTXVGVk9RQTlJZ1hHS2ZRenZtazIxbHo1UlFNTk9heVRNd0o5MWc4aWFG?=
 =?utf-8?B?b2NsSStoSVpwQ0gyWU9YZk5yeXNaWjZRYTFJRmlZR1AxTC9vczBXTi8zTWRj?=
 =?utf-8?B?U0ZwM3B3aHFnSHNKd1pVclEwb2tTaEYydUlEby8zSllUQUtZL3l6eXhacHJr?=
 =?utf-8?B?b054Uy9uNVZTU1VxMTRRS21SblRIbDZnRHRjWUQxc0lGaVl6bTcrU05JZzkw?=
 =?utf-8?B?SmUvcjV0T29DcXBQZ1YyWHRmZTdqaE9UemV6VlBLaEVCWlF5MW13S1lSVjMy?=
 =?utf-8?B?TkljV0IxL2JBRFNJR3htd0t2bnhVdHh1S00zUUxIRU1HNDUxMjhVNE8rb0JF?=
 =?utf-8?B?L0R3SjJtN1g3ZWJ5NWJTaC9ubk43cFVPR25mT2NZYU91U3RacVhmZDFhMmNw?=
 =?utf-8?B?NnlYMDd0eVZ5eklDT2JzWE9FQTBlOUNTdkxrTEZBQ2s4WUtTNERVOFdkbFBt?=
 =?utf-8?B?SlltbG0rLzVvRzAxUjFUVU9USVNVdFN5WkpUTFZNclBzR2JrR2Q4S1pteUxP?=
 =?utf-8?B?VEEvQ2xHVkQ4T05yYkcvZVN4SmYvUmQybzlSN0V1cVovTW5aZGZkTmdoY2Jp?=
 =?utf-8?B?WllxZ24vVC9tbGVZTXZKbFRSZ1RySFpWbTJOU21VQnlhdHpNK0xTaCtQSGVX?=
 =?utf-8?B?L1NsM3hwSEZORC9mdXpsc2hwQy9ETnlCTmZlYUoveFprS3VEUjQveEN0eTR1?=
 =?utf-8?B?bHBNb0tDWG9zYW9OVXZXWE5tTVdtL1dNZmNOWXMvb1JkQlBxVjFaUWxGWmtN?=
 =?utf-8?Q?qFlCr4Rtfuulf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUxsTktoN3lnWURUalgxUGdyRldPUlo2SVNZcDdzYzUycEFGTE92M1cxZE03?=
 =?utf-8?B?czBhMSsySUpjWjdyTXl2NXlsYUh5NHl4Zit0VGZudng4aWtTdVpjNUgwMGRn?=
 =?utf-8?B?bUw2cWZ1Sk9zajZDbWJjMDZKeFZGTGttTWk2MlFnWmorRkh1bFRxdkVmSjR2?=
 =?utf-8?B?Y0VyOHlCbWpSYUNxdVZBS1dmRFZxRVAvZi9FSkFLZEhaTzNSSjdLbzBWRm8y?=
 =?utf-8?B?TDIya28xanFBZHJwZHJoaUdhYnArMFZCUUFoL05tU2ZjR2FZWVhNNGFtY1VK?=
 =?utf-8?B?RnhjTEtRb0VUc0c1TTFadXdVRldKTEpYNDVWK1dOV2RoSXdlSmlObTEzTnZt?=
 =?utf-8?B?bDNvcjhWaTNrS25XSkhDQWNkSzVOOWlPN3FyUFhOMTYzOXp6NVZKMHk0dzE1?=
 =?utf-8?B?eDlIaXZsU1VERmM4YXk5NjdtNXhlcU41NWRIRW93MUlKZ0lPWlpmVXA3djhH?=
 =?utf-8?B?MUM5MVd3cXpaUks2d1VtdkF1K1BhQVdoYUtZWjkyeHRjbk5OUHhsbDlBeFQv?=
 =?utf-8?B?N3J1cmNYWFJsaFpGVGFTUjJKd2p5Rm9ZWDNUWk05SWVOT3lXbDIrcEVKWFh4?=
 =?utf-8?B?M1NmaXZPU3R0SDNoNDZYcks5V2dWT0MwbGs2ZlExMlV4emw1WDZreHh4UVE5?=
 =?utf-8?B?cEhPWUNJMkxTaExTTlJybHdJZ1hBelZlQVFLUmxFZlRrTkVPaEpPZWx2eFU5?=
 =?utf-8?B?TUJ1c2NyazUrMS9SN2w4QjVIWFFlVUFQNkh1Nld6Y2w4K2xtMEpxVVdEaGkx?=
 =?utf-8?B?R0NRWnNMSTlDeG5rM2c4c2lYU2JwVWtCVytoYitzVVU0TUk5QkRzSWxKTzdp?=
 =?utf-8?B?RlRPMWJkZGFteHM1Y0JjUDRIQVU3K1Z2OWF2L0t3Qm9xNEwxNmxVTlk5TFJi?=
 =?utf-8?B?NkJOVzZyM3FSSUFnN1RhRmFMQ0dXSU55S2NYeDhDUFJMZmRJWEFjeHZtYkhx?=
 =?utf-8?B?WEQ1bWNGREt5TWI2SmtYUmRJWkd1ZkxlMG90dHpTWk9RYVI2WXVPMncrRExo?=
 =?utf-8?B?RWxKZ1VqVzZRTFFWREpEejVvNEdORUlqZ255eEtjMFdsZm1MY0FtTnhqRzU3?=
 =?utf-8?B?SzdFa2RDQW9yRU5zTjFpbjFDK0NoTUZFTXJwSHJCa0w0S3AwMUFtUTh0Mm5H?=
 =?utf-8?B?VDhZNEI2WlNQTHNVNlVzWUJhVWhReUtnSmJpdVZaSVhxYmZTVUNvdXNOMW5a?=
 =?utf-8?B?c1VrUmtCRG5KK1dyWS9RS1NJZnl6TE9kUnV5Ry83QzVVUk5lM3lCaUdBSVRw?=
 =?utf-8?B?TC85K2ZYaEh3WG41UHE3OTEzcVhzd2Z1eW1XMWpkdG5lYmwwNFZLbXVGZlR0?=
 =?utf-8?B?RXRGbjJTbjdKczBwS2ZiajdIWXpqQkdFZG5wZmJPQlN1L3ZKRFJYSUpNSE5Y?=
 =?utf-8?B?c3Y0ZWlIMVpiSXFsVjBaaGRCenVHRzBrTGRBQzlyZm54MlIrS3l2TTFuUEYv?=
 =?utf-8?B?OEh4bkozT3UrWm9ua2ZuNjJYNm45dTlTY2VOTkt3Q0ExQ01lZ0kxSHpqM2Q0?=
 =?utf-8?B?by80MlZhbGpzYTVTdGo4N0IvMENwakhEdmdLbWIxeGtZbG8xRUc3WTMvNDBY?=
 =?utf-8?B?bVZIMnRpVll0R0dYbDlmN1R6SEZWMmtCbW03WC9vM3JvaFVTNERYemxGanBC?=
 =?utf-8?B?QXdDMGlXcFZLSDU1dEFDN0M4SlZJUk1pR243ZHlYUG1ZOGZsdys1eGVPTSty?=
 =?utf-8?B?cWdCbzNBWmFQaFREM1ZYWEpSTGh0Q1Z1RXFoU2lIU3NYR2RPSVJLZTBac0FT?=
 =?utf-8?B?UndiZjl6eEhhR1VlVmtNb3FuNjNZcHJIdy82ajRRY2REQlNpa1B5Nlh0ZVRF?=
 =?utf-8?B?V0xyYjJpRGw2Sk85TWI1MHlnZFhEaDVKQWxiY0pOdWhnU0x6NTRkM3JkSnIr?=
 =?utf-8?B?cE5iTjVrdVdTczdNUm5QSzVsQ2ZQWkpSTkllWUdJNG1ySENZWWhiNTIyQUNp?=
 =?utf-8?B?REdBU2Y1OXp5SWRRZ3RFZW5sbkhOTFQyMGx6eTlweEV3UEh3dDNyZE1zWTIz?=
 =?utf-8?B?aU5KOGdVL2djL2padXllSzNtMVJOTFU1ZnJnSFNzU2ROaWh0OFdwdERhdXlI?=
 =?utf-8?B?VXNNUFpyeEpJVmdwb1l4aGQySy9aWUJ4Zkt6NnZOSGpxQ1lOK0FBNkpPa3cx?=
 =?utf-8?B?dFJtR2V2N3RrQk5CaHBzSDJ3QUxJalJZSjk2V09pTW02VEw2Kzl3T1pFQWJY?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yczRI7k5tXCL5LXqbcT7sLemNod5NjOiaL/zAsagnMafBcz+3JIUe3yUxVWlL6+/L5KKSIsKZ+IfQ6nkvvyVtqijLEyblty98Ch1GYlpxlGhNxsfNhi0skz84GnWmpXSLqnNdkKOWYvEZoEVuQ6WL2JONFHm5fgSL4H1AOe3dLFxuzsMR/hSaNbEgaUCj+8rXv33fDD0aNq1blYn4d6uQnH748K+EF58NwyWJKtKrOiPagg+KT/eXEx3ugFRfwhZwc+zh8XjQKD1gGCHrXvWj+l6dw9eoEyO0YG1B3q4TDEWmMzC/KxwanoYLu5F1PglbdFwddXoUjNPj3MeE3P3mLjlhRTf3wbtShB/noQOdYlQ9ajowNwgHqzzl7loumq8wR3HIRUst8jwoT3Ga3tEiz3ljL4fA5wamQNM5Ouxl7Nuk7kNeHsfwNKbLaB6xbqTfHbh1YJa9Mr7XHHV4mDj1c39pUK5M05aNryNLr7wl8l/HP/mMwVjIE+SYC4XtbUT2inKU9lDwiF6rllG/OdeRSqlbE7vXio2UL6LCbVmpL9jT/LdHqsbPylDRlT3WUJvnavkNHkBoe/Gi470EtMqjL6Lk9YOzsDpXwEMszKj6cI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b9f11ae-8653-4a03-2db8-08dd782a218e
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 12:20:50.5829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SgDsgJEirjMHWINhtxPhiJudlP2pUhJXmJaYngFxPjAQyI2NLUNcz5i5je92Bc5SBmbhDD6ihBlLos33PObSSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8098
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_02,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504100090
X-Proofpoint-GUID: U7OGzH2IIZEGedCtmju37bNddvFTrjPn
X-Proofpoint-ORIG-GUID: U7OGzH2IIZEGedCtmju37bNddvFTrjPn

On 10/04/2025 09:33, Tony Ambardar wrote:
> While doing JIT development on armhf BTF kernels, I hit a strange issue
> where some functions were missing in BTF data. This required considerable
> debugging but can be reproduced simply:
> 
> $ bpftool --version
> bpftool v7.6.0
> using libbpf v1.6
> features: llvm, skeletons
> 
> $ pahole --version
> v1.29
> 
> $ pahole -J -j --btf_features=decl_tag,consistent_func,decl_tag_kfuncs .tmp_vmlinux_armhf
> btf_encoder__tag_kfunc: failed to find kfunc 'scx_bpf_select_cpu_dfl' in BTF
> btf_encoder__tag_kfuncs: failed to tag kfunc 'scx_bpf_select_cpu_dfl'
> 
> $ pfunct -Fbtf -E -f scx_bpf_select_cpu_dfl .tmp_vmlinux_armhf
> <nothing>
> 
> $ pfunct -Fdwarf -E -f scx_bpf_select_cpu_dfl .tmp_vmlinux_armhf
> s32 scx_bpf_select_cpu_dfl(struct task_struct * p, s32 prev_cpu, u64 wake_flags, bool * is_idle);
> 
> $ pahole -J -j --btf_features=decl_tag,decl_tag_kfuncs .tmp_vmlinux_armhf
> 
> $ pfunct -Fbtf -E -f scx_bpf_select_cpu_dfl .tmp_vmlinux_armhf
> bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct * p, s32 prev_cpu, u64 wake_flags, bool * is_idle);
> 
> The key things to note are the pahole 'consistent_func' feature and the u64
> 'wake_flags' parameter vs. arm 32-bit registers. These point to existing
> code handling arguments larger than register-size, but only structs.
> 
> Generalize the code for any type of argument exceeding register size (i.e.
> cu->addr_size). This should work for integral or aggregate types, and also
> avoids a bug in the current code where a register-sized struct could be
> mistaken for larger.
> 
> Fixes: a53c58158b76 ("dwarf_loader: Mark functions that do not use expected registers for params")
> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>

Thanks for investigating this! I've tested this versus baseline on
x86_64 and aarch64. I'm seeing some small divergence in functions
encoded; for example on aarch64 we don't get a representation for

static int __io_run_local_work(struct io_ring_ctx *ctx, io_tw_token_t
tw, int min_events, int max_events);

The reason for that is the second argument is a typedef io_tw_token_t,
which is in turn a typedef for:

struct io_tw_state {
};

i.e. an empty struct.

The reason is with your patch we've moved from type-centric to
size-centric criteria used to allow functions into BTF that have
unexpected register usage; because the above function uses unexpected
registers _and_ does not exceed the address size, the function is marked
as having an inconsistent reg mapping. In this case, that seems
reasonable since it is true; there is no register needed to represent
the second argument.

The deeper rationale here in allowing functions that have structs that
may be represented by multiple registers is that we can handle this
outcome; the BPF_PROG2() macro was added to handle such cases and seems
to handle multi-register representation but _not_ representations where
a register is not needed at all. I'm basing that on the
___bpf_union_arg() macro in bpf_tracing.h so please correct me if I'm
wrong (we could potentially add a sizeof(t) == 0 clause here perhaps).

So in other words, though we see small divergences in representation I
_think_ they are consistent with our expectations.

I'd really like to see wider testing of this patch before it lands
however so we can shake out other problematic cases if any. If folks
could try this and compare BTF representations to baseline that would be
great! In particular comparing raw BTF is necessary since vmlinux.h
representations don't include functions (aside from kfuncs). Now that we
have always-reproducible BTF a simple diff of "bpftool btf dump file
vmlinux" can be used to make such comparisons.

However perhaps we could also think about enhancing the bpf_tracing.h
macro to handle zero-sized parameters like empty structs such that later
parameters are mapped to registers correctly (presuming that's
possible)? Yonghong, what do you think?

Thanks!

Alan

> ---
>  dwarf_loader.c | 37 ++++++++++++-------------------------
>  1 file changed, 12 insertions(+), 25 deletions(-)
> 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index e1ba7bc..22abfdb 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -2914,23 +2914,9 @@ out:
>  	return 0;
>  }
>  
> -static bool param__is_struct(struct cu *cu, struct tag *tag)
> +static bool param__is_wide(struct cu *cu, struct tag *tag)
>  {
> -	struct tag *type = cu__type(cu, tag->type);
> -
> -	if (!type)
> -		return false;
> -
> -	switch (type->tag) {
> -	case DW_TAG_structure_type:
> -		return true;
> -	case DW_TAG_const_type:
> -	case DW_TAG_typedef:
> -		/* handle "typedef struct", const parameter */
> -		return param__is_struct(cu, type);
> -	default:
> -		return false;
> -	}
> +	return tag__size(tag, cu) > cu->addr_size;
>  }
>  
>  static int cu__resolve_func_ret_types_optimized(struct cu *cu)
> @@ -2942,9 +2928,9 @@ static int cu__resolve_func_ret_types_optimized(struct cu *cu)
>  		struct tag *tag = pt->entries[i];
>  		struct parameter *pos;
>  		struct function *fn = tag__function(tag);
> -		bool has_unexpected_reg = false, has_struct_param = false;
> +		bool has_unexpected_reg = false, has_wide_param = false;
>  
> -		/* mark function as optimized if parameter is, or
> +		/* Mark function as optimized if parameter is, or
>  		 * if parameter does not have a location; at this
>  		 * point location presence has been marked in
>  		 * abstract origins for cases where a parameter
> @@ -2953,10 +2939,11 @@ static int cu__resolve_func_ret_types_optimized(struct cu *cu)
>  		 *
>  		 * Also mark functions which, due to optimization,
>  		 * use an unexpected register for a parameter.
> -		 * Exception is functions which have a struct
> -		 * as a parameter, as multiple registers may
> -		 * be used to represent it, throwing off register
> -		 * to parameter mapping.
> +		 * Exception is functions which have a wide
> +		 * parameter, as multiple registers may be used
> +		 * to represent it, throwing off register to
> +		 * parameter mapping. Examples could include
> +		 * structs or 64-bit types on a 32-bit arch.
>  		 */
>  		ftype__for_each_parameter(&fn->proto, pos) {
>  			if (pos->optimized || !pos->has_loc)
> @@ -2967,11 +2954,11 @@ static int cu__resolve_func_ret_types_optimized(struct cu *cu)
>  		}
>  		if (has_unexpected_reg) {
>  			ftype__for_each_parameter(&fn->proto, pos) {
> -				has_struct_param = param__is_struct(cu, &pos->tag);
> -				if (has_struct_param)
> +				has_wide_param = param__is_wide(cu, &pos->tag);
> +				if (has_wide_param)
>  					break;
>  			}
> -			if (!has_struct_param)
> +			if (!has_wide_param)
>  				fn->proto.unexpected_reg = 1;
>  		}
>  


