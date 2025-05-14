Return-Path: <bpf+bounces-58182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF87AB68DA
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 12:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC02D17571C
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 10:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0403E270543;
	Wed, 14 May 2025 10:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GhDL1YaZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xFGsDmrw"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5ED25DCF9;
	Wed, 14 May 2025 10:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747218691; cv=fail; b=MvtZAyDX73X2sO4Tsc+34KyVXV6otQsMfhuJ/XxgCRkU0MFnr27+WNUWEA5utUbO5OxgAvnP3Y1isMlqOMeomo0TDQT2PBrZx1i1Qdf4Fo+Ymc2xm2//aHwbaKgi8BCuhhE3pxYE8wb45d8cV8SnfXrFoHqa679O85dVdE2iI9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747218691; c=relaxed/simple;
	bh=+8kHWzS/huCEa4rXmFulCanAjtspkQ4MIp9nWX6MGjk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dMOHD4Flb14pUMQdJWx3vxKKJYq6YTaxWEJOQ4S48bPTC3vYvlFz3bwRH55dMmGsQlWOgbqibITyIfCt7/bh5nuPxqcRl6JaN8PbC29ysJzmBc8Cq5HAFofGHrB5n/QX+u0ynBKUB606zja+gAYzdhhAts+PH03R9VRWRoLnnEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GhDL1YaZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xFGsDmrw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E0fqCr026813;
	Wed, 14 May 2025 10:31:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=d5jSZtCJi+OpEakxjFkeEE1IvwywnxEk+rJNyc4CWKc=; b=
	GhDL1YaZfQKdS7fKVossiMJCaBjc+Mj0+FHbryuRppbqn/IAeBYA9QWBmjRgoQaD
	A53o8FTceFtm5Egit26H9vdQmGa0u0b2iGnKR43Y1b8S7+RMZD6le65XTNflnfEG
	3004YnTWo5T9e35BmBSOkw42sQ8dRKIR6mKw8OZEmfASCNYERHktm1+WU1JPSf7E
	sqjjtBjZPBMPlZXUDAoiD1edEJrggmHaOsgHUHWyk657D/0Iy7FMO+9Q6Bs4nu7z
	d2ZNj9P8hi1lD6TiQ3aJk25/vR42uxmt0KsRpKRU4TfXoTiMLRWLThJkcXAjdSbA
	mx1alzG+NRF6G1Es9wUT/w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbccs9en-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 10:31:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54E8NNju004487;
	Wed, 14 May 2025 10:31:10 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012052.outbound.protection.outlook.com [40.93.20.52])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46mqmbureb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 10:31:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HqSzRx8Ux1B2jjHf0wmSWZfIkNHAgN6j7ST+OTdlwnnBKqKC0VqGWl4MwU+KXQhg5FLb22E4WMSgK7VAsW/wvmezdbCkW9qakunHnUjUjoqq1NZPvjDbtsx/0ALxEjmfgkNnbVMuXhyvnELSZzZeK4ifFKp10Ekv2C1GVzhBbQ9Bvs+WmPU2Apzp7uqrnn/fVNOuNGw+3mdJy8awPLdC/QWvxfSV/Hd0dfBefPC126tylvPr/tRpbiV+Dfn1HIQtD1Aa+O0Rb6mrtDbLqbwe3IEeU+c68/Cjk/Uz1r8YS/n4iiNFA5fDDfqDinPVj1vi93mKlqeI7Ma39PpREqj8sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5jSZtCJi+OpEakxjFkeEE1IvwywnxEk+rJNyc4CWKc=;
 b=Hj5zuUGmLF/ucsM4qgOVNgzF1o5XgjPoiaynl+lrC4kzg4PQHKzQCNgyRDAu4qmHSl86okdmO3/vlBaQ5+x7eNxtWi8EDoaQ2tB3V4QTQdu5Z2meXQyTHegXMP1RuLtAGsDmD2YfLTkDLLbiTCBDAnOaRUJetkSPkmSDkiiPARhvvz6ouvu5wPZnTPUs2iZsV7W9+Du+rH27kUrMsIFOxcP59bloODkIx0guCPtAgh7PGSdjbBTY5LwQigVAYhysAMN+H+yp05BnHlnQly79n331TiE9jTp9ts4hnv9ouHcz8RWXvw2n47RJ2njwX2VHu06StVOmeviIC+bJKuVq+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5jSZtCJi+OpEakxjFkeEE1IvwywnxEk+rJNyc4CWKc=;
 b=xFGsDmrw3VN9lz5c3tsEBB5DRTSu8NfvUi+Fk9SaifiiB1IyAxkaC8xtKgJV5CQjvRrKC36G/fE9dT1szl71rosSyqYpZH6KBQKfxqMR7wpo7Uvb1lxntPaswrHbSP8D1WUcGnWrvD7Ec4Vs9ydVgRn/RZ1g40BUXaf8CCKNM/M=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CY8PR10MB6873.namprd10.prod.outlook.com (2603:10b6:930:84::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 10:30:50 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8699.022; Wed, 14 May 2025
 10:30:50 +0000
Message-ID: <4bc9b6c3-4e02-48d3-9b07-c7b1069bfd35@oracle.com>
Date: Wed, 14 May 2025 11:30:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 0/3] bpf: handle 0-sized structs properly
To: Tony Ambardar <tony.ambardar@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org,
        alexis.lothore@bootlin.com, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        bpf@vger.kernel.org, dwarves@vger.kernel.org
References: <20250508132237.1817317-1-alan.maguire@oracle.com>
 <CAEf4BzZfFixwy4vQG8jrUBtAOUFx=t1KG2F+AtKPVNCsMz0vQw@mail.gmail.com>
 <aCG8kz1eZjjw+sSU@kodidev-ubuntu>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <aCG8kz1eZjjw+sSU@kodidev-ubuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0196.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::16) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CY8PR10MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: 29025e45-64fb-4e92-ea48-08dd92d2659d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFVwb3ZqZTBzT2JVQWwxdHhOTVZTeTZpOHREbGdRQ0ZXKzFuV2JkbU5MZ2Qr?=
 =?utf-8?B?RmthR1djRnc5S0FsNjBJWm9oME1TUHVhbzQxQjV5bFJkMTZxVHl4Y2gzNkMw?=
 =?utf-8?B?L2cvdFZIY0hPRDcvU05Mc3Q3RmJSK3RyUXU1SzY1eW9JTkVQS2dqNGw2TlUy?=
 =?utf-8?B?Mm8zcTZmWTFDZkVEMVEreG9ldUdmeGxFNVZVNFRpU2h0RmxjcnJlSWNNKzBz?=
 =?utf-8?B?MXZCNG9rajh4bDlWQkxRaWNBVUcvM3B1Vm1mV0R3ZitwNjBOZWJKQVk1aXYy?=
 =?utf-8?B?Y2lTZ3JhSDZsWTl3WEk1c3dzUzNVZXg3aUFGSWVlU3k2SFlmV09POE1sV1VK?=
 =?utf-8?B?MTgrZlRmVzF4MVdVZzdhZmZsMlVFdjdnQ2MwT3A4RDlWTWlyQ2VpaDYvSnRX?=
 =?utf-8?B?STVMUGxOaExlQ1U2MkZXQjV1aEpGeTNkeU1OSUpwRlRTMGRIdFYxK1VuaDQ1?=
 =?utf-8?B?aTI0WjhkWmt0RGdhNk8rUXFvenFiUXAvUEJsTnU3TERnTVB1NWplSkl3QkQ0?=
 =?utf-8?B?c0p4cXZXTS9QTDVuc3FhNVFxZjZ1TzdZZnFzNlNqQ29wbmJ1MnkwMnFFTzll?=
 =?utf-8?B?M00zZmJsa3ZLRW5Tc1hJQzZ2R1QvejVjc2g1M3UxK1E3NU9qTjAvOTNGRlU2?=
 =?utf-8?B?VkM0aTEwMlhRU1IwQ25OSGdiZVlBMHAyMi82OXNGS05rNG00bnl5c2lLck5a?=
 =?utf-8?B?NUhFVGNiNndBazVVL0t5RzdGcmRmK2RIdnU5WDBsNkZBdVpjU05FRHJyTkll?=
 =?utf-8?B?SUtidkVzcmJwVUpBbUU3OStUQ2M3RHZkQ0t6cTFBWU9DLyt3dTNid29BQXNO?=
 =?utf-8?B?cUpkelVuOEQ5MUVzNFR2aTk5NHhTRWc0dEJrV2o4WHdLWk5pK1hVL3p5WEg0?=
 =?utf-8?B?N0pEZ1VXWVUyUjB3Smx2YUMraFdPTjY1WVJGWlVSa01vanNqR3YrNGNDdmQ5?=
 =?utf-8?B?aGZETjlSOXRPMW42TjlCekJnSExJR1FRTEJRZnd6QkRZOUU3cjF6T0w4WGZ4?=
 =?utf-8?B?NDhibVhtOGhtYTMvM2JUY3BUL2ZZNDZDc3ZHSlh3K1dsVEhGZm9MUEM1bUxQ?=
 =?utf-8?B?cjZIOXJLNStNUVA5UUdFMVErQmxiQWplank0N3UreXdsaTVESWNWc3JDOGdP?=
 =?utf-8?B?ejZBcUxMaktxRVA4U3h1allVMFV6TElmQnduMnRsTmxaa2pXeHRGZGVlVE5F?=
 =?utf-8?B?YndjU1N3M3F5TWtWKzF3NjA3STlOZGt2TENKdTh0d2Jla01nbVNxZ1p6NTV5?=
 =?utf-8?B?ZFhWdmpRYUpDS2ZqMlk2RXpLSkV0MlVRaDladXk3VG9ySnRqQUl3bjRkTmFl?=
 =?utf-8?B?M0hUbk5iVi9PL2Q1S3NoY2lvNU4wSkVoSWZBTjNaeEhFM01QTzQ5RFF3Wm1H?=
 =?utf-8?B?MCtPdVptMWRqbHNBbkhPaEV1Z0xuWkpSVWxUSnpxWXY2VzAxcW8ybGNzQnA1?=
 =?utf-8?B?czBVTHUvQWxBbzdPT01kdm5kKzJqYXdVQmdrdDR4dEdJdkNWeXp6QnRXOFBj?=
 =?utf-8?B?cnN2eWtiZWw1MlBiNlMwRTdHRFFmR0Y5Qzh3WE8rbFdtWFRweFhWeE1nS2t1?=
 =?utf-8?B?S1hHeWR6WHQ5emM3dGdJM25qQkZ4V2syUnZBVDM2cXlvVzlxSXJlME5oL21r?=
 =?utf-8?B?NkVzWEE0NSsvS01kb1dybE1XalVyekQvb3JYYVFsMGN1UVdRcytqUnJVbUNj?=
 =?utf-8?B?K255V3pZcGplT2pFY2NYMko2UTgyajBSWXlVeUs3RDBERE5YS29Jd2VpVFJk?=
 =?utf-8?B?NE5Uc1ZrdDgvYkdYZ0x1K2NPUnpaSFJudFpEL1p4V1lreGErZjJFOVdFYi95?=
 =?utf-8?B?NWlHaWsyK3JSWE96OGlDb3YwSVdPYThKYjdJOUwzYUUrbGZmUXd3WGR0MDE0?=
 =?utf-8?B?U2dVRGNHKzc0MW9vZzBjYXRjMTZNMjJTMy9xdFArY24rNWRLSzA5dUthUnN4?=
 =?utf-8?Q?xsZ7WmMcvJg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlVnUEs5MFAwZXdDbVhlZEtIcmpGNHAwUVFpeWhBNGRyeWE3a1BLN3k2a2Vt?=
 =?utf-8?B?SGtSb3hPN3lWanYzYm9SMHpOUUhDOWY1YlhybkxIbEpWazRIK24xbm8zRERP?=
 =?utf-8?B?Qmp1Ym1jUVZsM1hpUlQwb3AwRnh2KzJQVEdlVHhTbVRNeFkzUmZuYjJ0cDUx?=
 =?utf-8?B?cmRZc3k2QS81ek5sUlZ1VTQwTmZXSzc3SUM1c2RrY2NxNi9HemhBaVZIalVD?=
 =?utf-8?B?ZDJnbmorcnhvN25zWG5HVmtXUjNqSVhvU2dJT29tWHkyc3plc2E2TGM4eDJ2?=
 =?utf-8?B?Qmg2bW9CT0x6bDNQUlljRXdjLzZCa1FsbkR5b0VUVkwrWlk1clB0bGhsMkpB?=
 =?utf-8?B?SGJtdTVyL055dThxaWxCeThYdG1rVVYxdmNwT1NEU3RXT0NKOWc4bjYxeGc0?=
 =?utf-8?B?T0RmZmFSRDVBenZYWW1yL2ltV2huRnhpbytVZUViL0xJbGZTYTdOTGJOUlZn?=
 =?utf-8?B?MGRXK0tDaG42SlRBeG9UMkFJdnpPL3A3bXdqTUNCLzZidkxCbGw3dVVjaG9x?=
 =?utf-8?B?ckt2Ti9MWlRvekdtRk50SlNJMVp3cXFSQ3JRQUIwYWRoSzJwTkV0NHljREF2?=
 =?utf-8?B?c1EzTzFvd0lKL3l0bEVyMGs0VmpPTzg4V3dZa3VHOWlsUG80WkZwS0ZzSlRj?=
 =?utf-8?B?YXlMZGZqOGN5SDBibzVOV2NhZW4rOFJMUk1DeGc3c24wUDhpcGxudXpkQVpk?=
 =?utf-8?B?aDhVdy93bjdsOUNudlBkU2o2WStJNnE4VCt2WEFJem5JOUh6K0FpV3R5Ri8z?=
 =?utf-8?B?OUdmYS9nZ1p3VklQbGxiRVpPVFdsVncvL1RaeHlwOFJueUtPNDZmRFlXem1X?=
 =?utf-8?B?RzFqeTF5VEtBTmhQNmpxQUNsZnA5MktSaVlwbXJva3lGb25MbzRuV3RoVEh1?=
 =?utf-8?B?MFRLNS9GWW9icTExb0hCY2hHL21jVTJVdHk4R3I4Unp1bzRTTXNRRDcwaFRC?=
 =?utf-8?B?N3RkcTRra2h3YlJXSVp4ckVyemo2VGJmN0Nqa0w4WXNKeWdzWU9DSGNpNTA3?=
 =?utf-8?B?bDNYRkY1aEM0OEUwdkU4M2pEK3JlNTJrZS9RNU5Ta3AxenFrRnpQbDlsQlFu?=
 =?utf-8?B?VldWU09XZCtEUSswVWNZOWdENGV4MUlSWlkrbmRkV0dpcVVjTmFlWHlHaEdT?=
 =?utf-8?B?VkVOR09kN2h3dGpubDMrQW9acGZQc09tYzZoSC9HdmZCNzVEdGpBdUVIdzBw?=
 =?utf-8?B?QVJMTEpuMmdJMVNtYU1iT1FQck0zQUZ6WmJDeC83aVUwVlRTN1gwR0tMM0RC?=
 =?utf-8?B?YkY5UE9GSk5qemlxOUpkbkRwZFhMZnhPS0l1WTVxeUUzSmF0WXhKcUxsTVdO?=
 =?utf-8?B?b3pWYTZyVmdaWjI3aHBOcnF3OE9MeVgzTkFZT2x4eHZIaXljU3V4KzhXODhT?=
 =?utf-8?B?T3NlRHEwTy9mV3Fka2RtTGtpY3pEODJiMXlSOVNKNDJVcWo5dkF5UlRBZTdw?=
 =?utf-8?B?Nm4wMVl0Nm0rMXVQUGhodjNGL0VKRk9FTkhSSXkzelVvdDVNaDZZeHBjRTEr?=
 =?utf-8?B?cFFPMi9YYUpvd21mQlJkaDVQWUFoWVRrOVlIcnpCbHhxNE5iVnA3VVVKcmxy?=
 =?utf-8?B?bCt1a2RLYUdaUVF5N0J4RmwxWkk3NWhkWFdMM1IyeDRzQ1N0djBiZTc1SmF5?=
 =?utf-8?B?QWRzaWErSUtZWWZUd3ZxZWVrK0Z5QjBkcmg4ZW1RbEIzZFNJbDIwbDNVdXFl?=
 =?utf-8?B?OTBDazVKOHZZTXN3bWlTTSt4UGFrVDVkRXAxN25sUUdXeFd4S0E5N3JxS3cx?=
 =?utf-8?B?MFZmQllBb09zbHRBaDZLS2RJNVVHYzNKT2NPTmlBTTFEVTRxT0xmUEc2S1Ar?=
 =?utf-8?B?TC9oK2M3QzNjWGZ0aVFIQUw0WThaRXh1VVVuWjdFSEVLZVEwckdqY28zcGtL?=
 =?utf-8?B?MHREdEdZeERaZHhvOXI0UXp5TnFrclpFMUZLT0U0Q0xYT3V1cCt2aTMvUTVv?=
 =?utf-8?B?cC9SS3Bwa3o1dDNsZDR4enRLa1EyNk4xYnJZcWI1SUhWclJkYXFLM0kvNmMy?=
 =?utf-8?B?YnlTbFhpbjRLcGZuUHNhWVd6VTRLcnFhQ0VxRzRTWnpQcTcxWlR6MnRwSUhP?=
 =?utf-8?B?dmpFaFJkZHBwRnV2YTVlc3MxZldSNjdZZm1nQ0phZ2ZHQjJjUlNIaEFVOHh2?=
 =?utf-8?B?RUpIYWtyeEgxTFdPZmNKWkpFODRzMCtQUU9vb3lrNDhGS0t2OHViTjhYbVhs?=
 =?utf-8?B?Vnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7HhTO9vaQ4eNKVzHYkhgAHTWwhHZVttmfqNgxf5I2z2MPopWcTQlbj9YfvV1SQMzsPsK42hVg7aPtvZjGqD+DkiAyW4PeJoElfPEy9wG6SCspUZSE19pApi/yTYiXgBbqeiXYuwwSX8ROSNb9STrPcfESW8ZCDWNdhiGoDUfSOnSQAtypqG4uKhj2e+XZlq6i6mkmEan5O4mH06n18Uf0tGjgKnkC4IdcuQliXjs1O2OjUocq5b98SP0chjhg7iH7hrs1jX2mT5p8u0IRhTNbtOG/FAsGVonB1KTALhoE/Kd4oHlj07cviaDmmRPDOwPioWSY3ERgTcsxupi8JoKgWgL/k3cLB6tI19Qkmh0tp5ZMQ9L1HgSPNeiLzWKp1OwgK+Uo/QIBVMc/ziBmqyWqFm3oqswQiJcC37r015enJMLPOLFIay8KBlscPKCC8jdYP/tCQwaDD3wl/+BRKaFtJh0yIVgjfjoJnGtGNeiprAWioyXhzoohA26bp5gd5bk72cIAFBRNuu5USNE2TH3lRgp74E9KptSIqP0iwdmUeTpX3JdDJUO8J0PMByEjpU9Z89l8PVooW6qVBZr4x2lSX6kXg7I5/6iA50YGyld+cE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29025e45-64fb-4e92-ea48-08dd92d2659d
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 10:30:50.3489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8jckfKHpjFFnCNlVkAH+l/x2aAjsteWYE6RC8PbCRKN5PtLd1oocVCk7E6/fC086I1E+mG89UyeOPk1uW1LMQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6873
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_03,2025-05-14_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505140092
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDA5MSBTYWx0ZWRfX6BXEFGm5Hj/p ZsxAaLa4NwM35y5h6aVZghuCenkTbqaorhS6dRnx1uxWeKOeHZBkpRqhPJRnTOEdf8Rd4w7EPqp 3Ah0kItsXjIGJkvgI43HvVz5kgbNHFF6M9/VGdrCLJkBAd6v4JmTbJtvh/w53L61fQ4o/t2hFC8
 VSKSFnE7IPG97HKBX7YZVW2gExjDkiem3Obs7yCxIN6q8vJFGUiLzIsDovj2RJ8+YnTMTBLhQ/3 MgPZFuvXY5tXZ0e6rJbxpy8WQfE5tt498Qju/rC0ch+QfJBbjduUpqzgrojfXnXqchiPcmSA7nI pevMt7KonNdw+tJT+75FDd/OMgwt1ejhFVockzBQUXml3BXYxFskWptM1cD5J8+EeISw8/gIVg/
 fppytkJj7rSniribxMB+slnuzRjizgmk+L4C/g7sBaVm3nKo7NbpDaM0Wv61DMVwmDVRptNo
X-Authority-Analysis: v=2.4 cv=Y+b4sgeN c=1 sm=1 tr=0 ts=682470ef cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=OEBwwlVOGtbjsWl_UNsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 1qO5KjOaNHPcVJfYjlMu1h7rcifxOolC
X-Proofpoint-ORIG-GUID: 1qO5KjOaNHPcVJfYjlMu1h7rcifxOolC

On 12/05/2025 10:17, Tony Ambardar wrote:
> On Fri, May 09, 2025 at 11:40:47AM -0700, Andrii Nakryiko wrote:
>> On Thu, May 8, 2025 at 6:22 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>
>>> When testing v1 of [1] we noticed that functions with 0-sized structs
>>> as parameters were not part of BTF encoding; this was fixed in v2.
>>> However we need to make sure we handle such zero-sized structs
>>> correctly since they confound the calling convention expectations -
>>> no registers are used for the empty struct so this has knock-on effects
>>> for subsequent register-parameter matching.
>>
>> Do you have a list (or at least an example) of the function we are
>> talking about, just curious to see what's that.
>>
> 
> BTW, Alan shared an example in the other pahole patch thread:
> https://lore.kernel.org/dwarves/07d92da1-36f3-44d2-a0a4-cf7dabf278c6@oracle.com/
>

Yep, the one I came across on x86_64 was

static int __io_run_local_work(struct io_ring_ctx *ctx, io_tw_token_t
tw, int min_events, int max_events);

(the io_tw_token_t parameter is a typedef for

struct io_tw_state {
};


>> The question I have is whether it's safe to assume that regardless of
>> architecture we can assume that zero-sized struct has no effect on
>> register allocation (which would seem logical, but is that true for
>> all ABIs).
>>
>> BTW, while looking at patch #2, I noticed that
>> btf_distill_func_proto() disallows functions returning
>> struct-by-value, which seems overly aggressive, at least for structs
>> of up to 8 bytes. So maybe if we can validate that both cases are not
>> introducing any new quirks across all supported architectures, we can
>> solve both limitations?
>>
>

Good idea. I'll try and address this and add a return value test.

> Given pahole (and my related patch) assume pass-by-value for well-sized
> structs, I'd like to see this too. But while the pahole patch works on
> 64/32-bit archs, I noticed from patch #1 that e.g. ___bpf_treg_cnt()
> seems to hard-code a 64-bit register size. Perhaps we can fix that too? 
>

So I think your concern is the assumptions


        __builtin_choose_expr(sizeof(t) == 8, 1,        \
        __builtin_choose_expr(sizeof(t) == 16, 2,        \

? We may need arch-specific macros that specify register size that we
can use here, or is there a better way?

>> P.S., oh, and s390x selftest (test_struct_args) isn't happy, please check.

Yep, working to repro this locally now, thanks.

Alan

