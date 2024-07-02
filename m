Return-Path: <bpf+bounces-33609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DEC923AA0
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 11:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 429E91F2262C
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 09:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60822157A7C;
	Tue,  2 Jul 2024 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PaoS8lf1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SPRrJMjO"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B40D3A8D0;
	Tue,  2 Jul 2024 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719913793; cv=fail; b=uw1IJoz/k6q9Nbr0rBJiDxIJx2KA1mLGVloh3V4NeF3zCQ+rwB3gT3lOKh9cW2w/CaBOYfLZzSwxuAJSs4aWxR0nAtOOClZ3OdyqKpRDsDEIUuwIqfaO1ltXgOrMPiG5KsjjLbuO3DB6ZUEKEutQHulSZaA6LtM/FtOS+3oNB7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719913793; c=relaxed/simple;
	bh=Vmz6TJjWrbOc5LZZBWnWXHWtbM3JGrDTkgISIcTkjok=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UAIQqfta4jYFNKF3lZtKaHGzR7BL8o6ZYVj7GaJdr9o3XkVWHMyB0ItQpYGJ/E0WZICSKRDjyUyAWKKGJIuICCNYOfBFHpWRQwyF4Kv5O9D5LQxzmLHOUaKeX+WMLrViYtMusqvs5u6wxrh/talV9alVChlkLVAEuIGBHX81wBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PaoS8lf1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SPRrJMjO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4625MUFE025661;
	Tue, 2 Jul 2024 09:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=+YvabNEET9wVqM6w/xclWerK0vb0m1wbWi+K7moaq+0=; b=
	PaoS8lf1Cq/ezkJlmOLZFTmlflgqANbGCYguZ0uIjIDzwCmoMQx+CW15u+yyVMBz
	c3cq7UHlQJCDiDhL/tyul+G3zIWr78jbY5FuInocslv1lRwldPXZWItpuQOLdoEM
	Jcr+kqhtwAvTE5XsWBg5Q1jQOXbU1r5IZtkacOr8FLCe5xkKuVlQf4iUtFylb/gu
	m3WzfF68d9aiwh2p+rD4DgAA4g+4pyqcBwkE/0AI+gSa1paYp0LielffrEtq6Rrg
	XJSL0JMeM1NKLsmbSxozQuEcFGBhiMjALwqOBjKKaTNAlg9PuuDbP8UQxsBMgfwp
	qDPeBIUYHJDKOXt4tctc8g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4028v0nh1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jul 2024 09:49:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4629HK62010613;
	Tue, 2 Jul 2024 09:49:20 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028q7mtd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jul 2024 09:49:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bop5nk49v68Ja5r/6mYeUJe8oV23m9u4b7vmQ68PTlkfMIqHY1VsY0fF/B3HPDBDcMt3HgLQ452rzgVDGeENu4LmNdOqsBCVQSuXyT5dXFBn5BMVaq1IlkHRSbR8KY8sKhwiRasvql5Ew0Q/xhTp0Ech7Mjv+Mc2EkE+2G+8SPU/Idfrq933kQU1FGuKWZZf+v396ralo6NjQzkigvIUGcLpZ+D3uyyxUKU8gEu1llIO5kXqKqVMq4yFbTvgxnG43uvYBPQLMdLMXYXojVyI4qtf9vvGLuUHLl2qHi8HU2/crC7VB7fFuIQIhZJ1kFhmY8+ryXiyr+hSlkANpN2pkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YvabNEET9wVqM6w/xclWerK0vb0m1wbWi+K7moaq+0=;
 b=A4K8nbBhziMuOZUMCLp4UYgrhH3kFteh15L+qSTI2bewqNVB8uHrAdAf7GNR2fjfI5AsNb8k0IAT2Nixe4N1gZ9BCS9+rkJLUXOARLrTiiI/lc0NBCMclyFnZPfZY2BBYoLZ8KooXyIKGy1UkbZAPUpdmrDdL4Vx6wI5UkzzggEQmh+QVTWSYIq/JPemxSqINvXQwRuxPV04XwCmlQmlIeC51TaFgvtqLpvM35exbt4WBPL9WjmYCl1Q6NNmK2RhRX6nTV+DuepARRkFPaOFsgBin5mWR7lhEOMDGCx4m+TTqPmGkOZYxnJWj0NykhbKmVZrU4XZ7lL31RPmNSRXpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YvabNEET9wVqM6w/xclWerK0vb0m1wbWi+K7moaq+0=;
 b=SPRrJMjOIhD5XJochKDcoyusxXFvwPXdZMH1W7Goi8WMUxCQ+NCh8fAw3L+4keKY+IQCFhbx2eqEi1e6A/Me8+TN+gRPy4KiPx8InByCM80ETTXtC+9wHQiOBX7JC1/08UaE83zI8Ihchdhtk67iJlkufa8qOOLIaPCsU7C0Dmg=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CH3PR10MB7394.namprd10.prod.outlook.com (2603:10b6:610:149::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Tue, 2 Jul
 2024 09:49:18 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 09:49:18 +0000
Message-ID: <21ec0d92-fb99-41b3-b1b9-3b8a4504271c@oracle.com>
Date: Tue, 2 Jul 2024 10:49:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] kbuild, bpf: reproducible BTF from pahole when
 KBUILD_BUILD_TIMESTAMP set
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, nathan@kernel.org,
        nicolas@fjasle.eu, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org, linux-kbuild@vger.kernel.org,
        asmadeus@codewreck.org
References: <20240701173133.3283312-1-alan.maguire@oracle.com>
 <CAK7LNAStVrAx8LjDiYogRvS16-dZ+LrwcWq8gHnTbvKvR_JFFA@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAK7LNAStVrAx8LjDiYogRvS16-dZ+LrwcWq8gHnTbvKvR_JFFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU6P191CA0007.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::22) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CH3PR10MB7394:EE_
X-MS-Office365-Filtering-Correlation-Id: a3b45f73-b755-4a3a-eb1d-08dc9a7c3d78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VldnZFp0V3RHUlRrdVQxMThZRXloZXRsZ1Z0dW9LdUF5bjdLL0M5YTc5WnI3?=
 =?utf-8?B?VDY2Mk55MUI4Vkw2QUoyay8vZmpzTEhlZFZtZ0hsZ00rMHJOTVZ4VldBdjhJ?=
 =?utf-8?B?OEwyanhFOXV4R1VReVVsVzBTdnFGeGM2L1VZcFliSTllNXdqZHZxVmNSUDV6?=
 =?utf-8?B?L2JhV2gzek8vTWsreDhLK2tRNHdQMGNmcldaaUZwS0Z4bVFaRGNyUVV0S2NM?=
 =?utf-8?B?RzBPU2IzVXI3bVdGcnM4TjRRMDZtYXNlVkowOGkzdG5nQyt0ZXd6TDJKd04x?=
 =?utf-8?B?T0QyZXVUMFhVTC9xc1hKeGF5U3JyV1F5U0R1Q1FWbXNQd21ycFRZT09BR2h2?=
 =?utf-8?B?WnE1bnJVcDR3dmZoR2YvbTlyd2hPL2g1V0xQemJOUzAxZnMwb2x2WkhRRndq?=
 =?utf-8?B?UnExcWRtaHNLbUliaC83MUdlNG9Ea0MwSjlKM0IwRG03TzJwOERvakRheEhP?=
 =?utf-8?B?QWhUN1ZTR1I3c0UvQm9EaG96MnBiVHpuSVZzVjZURWJpL29GYzFvcmFHN1ly?=
 =?utf-8?B?MmswVGs0K1NkODR6ajg0TWhKK1liSU9VeHJCNzlJNFYvZmFnWUlzZHFaOExu?=
 =?utf-8?B?YzhiZnFzTWlOYjJjUGMxUXJlaXJXUTM0TVcxOVpob1doU2dYTkxvMC9BQnRD?=
 =?utf-8?B?ZG1UVXErdytHSEhXYlAwU2Q2U251Nm1iY09qbTJKTXZSaS9zSlJFL0VMci9m?=
 =?utf-8?B?eVoxTW5TYlZNa3huRURTRmJKTklxNjFnQjErRnRLZ0FuWnhLcUVxY0tBMkky?=
 =?utf-8?B?UC9qR0E4cko4a1RzQVlRbk5Jb2k4Y3RWZFBIbWlzdnQ2UVJ2cFovRFA3UE01?=
 =?utf-8?B?QlM3VS96SWdRUlN1WERHUnZzdjdjK3EwZ2dSbEhBLzhVUGx1Z1BkWkF2dlRW?=
 =?utf-8?B?QW04K2pycFo4SDNKdjBPR0l2SW8weHhPZUIwVlBQVDZaTnFQYTJ4d0JGckpD?=
 =?utf-8?B?a1FZZW5jbnp3RjFEVzY0eFpvOFBWeFdJRjlESGRneE5nOTFNRm5NZkxtMU5n?=
 =?utf-8?B?d096U0F5Z1V4eG9XWStEejB0Ny9NUFdpRHJkTDFNRFVFVmhRVkUyemRwNTZ4?=
 =?utf-8?B?ZlQ5SGlDaWJKMmZoSkVFcFBXcFdoWjlMRnRva2xkWWZjdlY0K2Q5cEpjaXQv?=
 =?utf-8?B?VWhsYkJRaHh2Q2lteGxaZndQbVR5M1pQNTAzbjhaRGxFcitJRU9nWlprVWtR?=
 =?utf-8?B?MnJIUWNla0lXOXI1ekRUb1V4VnhNT29kYmUxUm5CeUc2Q1pvTkdHZXpSNU9G?=
 =?utf-8?B?OGRpQmxXaDNUdXRuNy85a0x1aVNkNERSMitpUzE5YUh2eVYxOXhNaEZPRm5h?=
 =?utf-8?B?N1lidlpWQ3BBUTVaaXRrQktoSXh6enNPYkUyditHSnF6OUUxYzNaYzJVTTgv?=
 =?utf-8?B?WWh6aFZjcTYxTnp2Wkxidm9JV01taG1kRVRRWHZZR2xabVNnNG43UnhuQ0lt?=
 =?utf-8?B?UGZVMWMveGZvdHFsbmljRXpIWkVubzJudjgwM1d4dXJMOXFSYzBvbmhlU1JY?=
 =?utf-8?B?STlTSlU0UzBZdnhJNjAyVkpZakw2NTN3VTBGaFBad2paQnl4ZjRMaXdrZDNG?=
 =?utf-8?B?d0NXcDdJMjQrNjlIZ1AxWkUzdWFpRTREVVNEQmo5S0RpRjNrc3hITUpFa3g2?=
 =?utf-8?B?ek5TZyt4VnNYN0t2RXdzTGVuZHNtS0VBdE8zWTlTdlJPRFFpcTZvQkl3aXlr?=
 =?utf-8?B?R2N5elhocFgyaEpvUVRvWU0xWTdRamNxMk9DbmdzU1lCMEcydHFTdmRyZnpD?=
 =?utf-8?Q?Va31YlJrQ6Nb98Amh8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?d04wQ2d1L2VDL01WWUFic3JDbURqeHFKcHpDTzVOazdiRlVFeU9LLzJCZkg3?=
 =?utf-8?B?WWhUYzFLeFI3cTlZTkl5QUFkWVF6L2NuU2dubXZzSzVJcng2bXp2RnVlUUhH?=
 =?utf-8?B?UStZMEtSMzd0RzJXOXBYMENJN3IyUEUvY1VaWjhmOVJxbjZxU2hPQVE4WUxE?=
 =?utf-8?B?ZldhVHRjNU5Fa2FrVE9EZXdEaE9SVzNrWDM0K0hCS0QyTVRTM3NBRUw1NTha?=
 =?utf-8?B?amZ2STM5VFJaWk93aXkzRitmeUhFRStYWFFua2VGSGd5MUpqemNLc0NVUmx1?=
 =?utf-8?B?bzQzOHRqclUrbk00eUFaOUM3ZktHbkh1Z3dZUkNOMHMzTVlNVTI0aFBaN3JC?=
 =?utf-8?B?NmRpMG43T1h5b0hJN3paZlpmbDJhbmNsT0U3WGsxZE5GOEZlWjdXUVZ2RVNO?=
 =?utf-8?B?QkdOeFY5OG5sTWEyV01Ta3M2cTNWbUhjdy94MDBpS09ydE1FbFoyUldvK3Bz?=
 =?utf-8?B?a3BIbXExUk05VG0ybGM5RWJUN0xGT3RRZDRKaDcvSHpXa2VJM1FCZlR0eVB3?=
 =?utf-8?B?OUJidTJWQXN4NTdaYU9kaDNvR3JRSm9qWE1yaGNFOHFrUjNQZ2JzV0didzdu?=
 =?utf-8?B?ZnQxdnVVOWVaNHU0M2JpSzdsLzFYZk5jU3ZLT2RsS0NoVlRYZVRBSTNkZ3pF?=
 =?utf-8?B?aW1LU3pWOVFZc2hVM2cyNEt4dDBBNks3QVI1NTVqUTgzcjFKWTd3Nk9Rekpl?=
 =?utf-8?B?eVRPd3p6azJLWXI3UFBORk12Y0pOSU1FT2taaER3VXBKMHlXS0U5amRIQndR?=
 =?utf-8?B?RURCRlBqMDBtYjhhaWExTG9JNFJtRVFZMll2Sk1vU25uTjdiWFRIaE1UL1hh?=
 =?utf-8?B?b1g3SXlWMWVaTEc3UXZTbWJUWnA0T2h4ZmdHWFM5cVIvbDlab0R6MVk0a3l2?=
 =?utf-8?B?WXRacEhGQy9DNHAzRlhQUjF5aEtaV2l4UVNjL3phbGw0N2RqQllPSG1DWUpK?=
 =?utf-8?B?Z0tFQVpDdUhnQmE0U21IbVBLSm1UVk5IUUtHN3pTcDg1L0hWa1J0bUw0SzJl?=
 =?utf-8?B?RGg0ODM3WFFuVER4SUNuNEZHcjEwb3FuZWdOMjVXYmtkWk9wekdVQTh4VG1W?=
 =?utf-8?B?M3FuUmtYallHa21QMEt6ZWlIZnY5NVV3aHBubVVZeXFVeU5lSEZBbjkzK3J1?=
 =?utf-8?B?SmhmalQ4a1JQTnBCdXJhQmVYYlJBbld5NjZSZy9MWHRsRUJKVDUxR1F6S2sx?=
 =?utf-8?B?REZsR0ZORktBTTVPNnA0d2tOYU5GcjhpV1l5YmNGb1VMRTI1S0VDa0daUW9Q?=
 =?utf-8?B?WmRFb0FScmpJc05kZDluaEFQMnNZUG4yVGo3YnNscytaWDI4QW1JZTVsZ3ZH?=
 =?utf-8?B?T1g3dFRCb1dqb2h2VWVZbnUrYTdhcFhWT3haVzdMTzV0bmVib0NaU1cyV3FF?=
 =?utf-8?B?QTFiRnBWeUY2emN6TG1UOEJLM0dGdmRGaHJadE5GWThNMVJXaytFVU1Fcmtv?=
 =?utf-8?B?WkM5NFpjUGxZRElXWklBNzNUR1JIVXZoVWxJNnhDVTIzWTRTU3hmOGhTdmRF?=
 =?utf-8?B?aENTRjNtalhaYXRRcitTbWFrOGVMVUZkUDk3dXRTSGc3anh1M0NKdnRXVDMy?=
 =?utf-8?B?QyttTndMTGttRFhNWSs0OG1DVTRBNDFrM0xZdGNiSDNNR1JMTDRoWTlBTXl0?=
 =?utf-8?B?RUxyRm5LSnJQdk1oTFFsc0Rjc3h5eHhKd01jVWtNalFSOFRXaWxCNkRWTVRa?=
 =?utf-8?B?R0kxRjFlN1JYVVRPRFFMUmZHakZlMzYzQTVZOHByS1ordjhuV2ZhamFYNTFs?=
 =?utf-8?B?UVRIY2NoWVB1TTg3WVp3ZS9yc0pLK1U4eGk3NFQ2QVF5R1VicFdqcjljOTVl?=
 =?utf-8?B?RzFxWDliVE9ra0t6SWNRbnVvOVovSmYwZnh5WlZJNTJGNlU4QzFuOU9ncmQ0?=
 =?utf-8?B?R0FMVkdSSnVZU1doSmd5ZHBQbWxvN0wrSHRSaVVuWFRvZW91N2ZVMDlZaDR5?=
 =?utf-8?B?QWxBOWZ4a3JlUG5tVEwrbG9vK3NRaENESXVROTNvb2tLUGNrdE1tandMaFBp?=
 =?utf-8?B?T1A0UE02R09KelV1Q21kajdoSThoYjQrMlU4Rkp6WWN3WURkUVNwZUp2eDVJ?=
 =?utf-8?B?dCtjcFFxUUNGREpWcDd1Y1pJZFFYUGdCREpWbFlFdVNhaG1ZV0Y2ZXlxRjd3?=
 =?utf-8?B?ZVA5eGVlRjBDNTNXTmY5b29LSXkwc0F3eUl2cE4zYnJESmc1WHYyY0Vxb1V1?=
 =?utf-8?B?NFlXQ2EzMUp0NndTVXh6anFvZ1NmZWlpN1ZwdENSS1ZITnRPSmtac2RkWjZR?=
 =?utf-8?B?STNJeVlwMERDRU10OEF6bDJMRWpRPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	SOeiSTjSHyx7a60sUzOwiEZ0W6ybfPE2QFo59PnbzAmwwC6nwQIPMgIH78F1qCvpGiDiLhNQtp2LFCsT8qoHyy9GRusi6yHrVZl6LeC02qwV+k/JcHKQ4reZs2RvQuCJUQSytMMRwvybc0i/gIq7r+Ygsthefmar3243j5qXf9rL1DPnmXGFAfWDaBgO+KNKC/dpyESdSThUe00auH/x6kiMyeekMhNGOjjsLYq4ofdDNMXKppiWUQaX+N0NWfR/ryCQkgX/jEu3A1wQOd+H1Nrvl6Qe/OD1n2JwFgeTbCng6Jgc/3+ZW1IdJJ5ExaME4vrn8Wyt1nS7rUNnK4Mu18w+RKasZAKdKmr2Dnuqo+kgHXmQ/mwFHqdPZ7EDEVu98GKqi6gNafJy0zt0WxAF8m226k/vWDO+2ym4YzNpGF23V2F2xrFnGp4uem75p0nrXo21bGc8CpuGYI/CGHKc4g3Lg4wXMTfHivg8au/Hvqu2lG/lwWvJTa7tDDjzTP2L1VOJDxoK7qLOUCBF6kBEaYOKR4N2OCxVdcDqJFkewyReP/HRO1s0itSD727vI8yNCX6iovf1/ff4CNZbmaevjTRxSywjk2chzDi/StUs6TI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b45f73-b755-4a3a-eb1d-08dc9a7c3d78
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 09:49:17.9412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 79EirskuPm7/nwaOy6M98PYfexl+k4ersqZjzHPSWA8lGsq3BMIkkAP+g0KqJvpVP20Jm6g+RNYqTZfOPKKFxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7394
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_06,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407020073
X-Proofpoint-ORIG-GUID: IhEc8jBLXw0z9C80tK4YkC4TpV3RKMTw
X-Proofpoint-GUID: IhEc8jBLXw0z9C80tK4YkC4TpV3RKMTw

On 02/07/2024 08:58, Masahiro Yamada wrote:
> On Tue, Jul 2, 2024 at 2:32 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> Reproducible builds [1] require that the same source code with
>> the same set of tools can build identical objects each time,
>> but pahole in parallel mode was non-deterministic in
>> BTF generation prior to
>>
>> dba7b5e ("pahole: Encode BTF serially in a reproducible build")
>>
>> This was a problem since said BTF is baked into kernels and modules in
>> .BTF sections, so parallel pahole was causing non-reproducible binary
>> generation.  Now with the above commit we have support for parallel
>> reproducible BTF generation in pahole.
>>
>> KBUILD_BUILD_TIMESTAMP is set for reproducible builds, so if it
>> is set, add reproducible_build to --btf_features.
>>
>> [1] Documentation/kbuild/reproducible-builds.rst
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> 
> 
> 
> 
> Does not make sense.
> 
> 
> 
> KBUILD_BUILD_TIMESTAMP is not a switch for
> "please enable the reproducible build".
> 
> 
> KBUILD_BUILD_TIMESTAMP requires the build code
> to use the given time in the output where timestamps are used.
> 
> Your patch does not use the timestamp at all.
>

No, and that's not the intention. It is used as a signal to pahole to
enable reproducibility in parallel build. There is a cost to this so
it's not advisable in all scenarios [1]. Is there a kbuild-approved way
to determine if reproducible builds are in operation?

Alan

[1]
https://lore.kernel.org/dwarves/20240412211604.789632-12-acme@kernel.org/
> 
> If --btf_features=reproducible_build has no downside,
> please add it whenever supported.
> 
> 
> 
> 
> 
> 
> 
>> ---
>>  scripts/Makefile.btf | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
>> index b75f09f3f424..40bb72662967 100644
>> --- a/scripts/Makefile.btf
>> +++ b/scripts/Makefile.btf
>> @@ -21,6 +21,10 @@ else
>>  # Switch to using --btf_features for v1.26 and later.
>>  pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs
>>
>> +ifneq ($(KBUILD_BUILD_TIMESTAMP),)
>> +pahole-flags-$(call test-ge, $(pahole-ver), 126) += --btf_features=reproducible_build
>> +endif
>> +
>>  ifneq ($(KBUILD_EXTMOD),)
>>  module-pahole-flags-$(call test-ge, $(pahole-ver), 126) += --btf_features=distilled_base
>>  endif
>> --
>> 2.31.1
>>
> 
> 

