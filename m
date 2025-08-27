Return-Path: <bpf+bounces-66680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AF6B386EE
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 17:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 733B07C70F0
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 15:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687F22E1C6B;
	Wed, 27 Aug 2025 15:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eyKIdI5V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j+zB1pej"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A0E258A;
	Wed, 27 Aug 2025 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756309675; cv=fail; b=hyqo3+vAI1s3VA46Sn/oPgLrgon6w7YUALD6ZEJJgAbJrvWrECHYW+VmumLHKAsXxxdW9yHdg1DuUMcpyeKUx/0QtfNFwRF/Cm3jQgWKh0eiKpbzss2WHPNhfjNgTJ4JiHCyYv0ipmuZ9IZ3Zj+yW9wz3EVjZMHbvzS2nsa2MXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756309675; c=relaxed/simple;
	bh=gxjloCuAy6QacYYD1xNqu9wwR0cm5PMV3/A15JqhxDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eZ19roKg3lRDpuVHMv/veKdMGiR6gXf9LcBpU/g+l7DcGShlal31FtIUPlVB4BR2C0lXd1VH8LoxeIn0xNcFvpOfCv/MxtWME4KupYz02opTag0JAgcJ6YJs0PJR8p3pXRiqMotxQJATTvT9x31Sdg8cDfXfE/dNOu7cbJh49Fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eyKIdI5V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j+zB1pej; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57R7tpj3001055;
	Wed, 27 Aug 2025 15:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=bRs9E19w/1cI274+AL
	w+5bVKSZHrVUrn+GBA6i7ApZ8=; b=eyKIdI5VsqG8YsNAWM19B4juUWHYDd8Spn
	kzOgLOY2LMUTTmklxwrKYWuenuuY40nZJVb9JqqrB4ItqwcB99lmq065Hglu58ph
	elaBNEcWVROIWZV3KzaQaUitR6Kv2lBrnJtvqisO7JU9Ji5oZDAO8sXieq9C6YLh
	SC92596TYmIzJajVgwfBfy1vDyksxojVVPL0xZoOzjXty6tXxFxqoQlEWuG/vrCu
	7XvFOjJ7YqOhhx4RzoppAeHtH66qrJ1UbugC1xCzo80K063jgg9aUmmbQbpdTi8a
	CFnibKNoH8XqEsgrN3kHSw1QgTM/WPYTYFrKu5xVonK2VyW6j+zA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q4e26u2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 15:47:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57REU8ap005107;
	Wed, 27 Aug 2025 15:47:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48qj8b2ekq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 15:47:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BD5PFm+NUlufSlcKPwXoH6N3JFfuYsadJcttTd8wZjuzUVE6viWaGahzFs6+lfapc401w9hbGGjyrVKMibUFAYhYiNRBmsXeGzNQ564giLIE9ismSZpr/WfN+6mqSw8AcveYOGh/uFLbWMADNajpKYLT7SU9+eWsXgQ/VbqwHF6NDPD8DVbRLGO9FIMKWk64BhRWJTXLeJzDe1s5SBBAhvkU5/3j2A1IniuoZuPTLb6zCN04di2Mbca3N9iD1XJga4S60NA5ypgubfabmRz33JCTLdU6GiB1H4FNbMisvCxw3zqN+hzTSeHgEkIm/bMQwPjQgSYrQeaYgyx3AD81YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRs9E19w/1cI274+ALw+5bVKSZHrVUrn+GBA6i7ApZ8=;
 b=GBIB1jTgBlQzCk7TfPsl07nJ59eA+xj9cWX2UJLFwpkkXPEMh0AtO3YkD2nZqWj2wedd0Mk+zAGBQ0Bw8vDWRD4bZ5zXsec0z0/5imz7hIj+9weBRamvFNY7UBg9r1TnWJQBGjysge3bEc5/GDCqs7InAE4YWXNj/vG72u4UBPfNr/w8PCK7/mC6stdZBqQ8FQUD2wWtqRu/4FalaArS/Wm6Zblf4iiX5+vBmXCpfR2B2BGvshnHZ/sdsRZri6bOz6X+8yiivtinQBu4u3zZ/+bw1aTw5L+aDB0OHa2ve1MITg2WMUPNnjaQju7sXLDvOdqwSWZ4q5DMTfufuH0U5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRs9E19w/1cI274+ALw+5bVKSZHrVUrn+GBA6i7ApZ8=;
 b=j+zB1pejA6BFjNlkVpUzY6toXe0iTgVP4jlbE7RHBXvpg8FRaqR0JCV7SzFo5BgjlE2wFh27QK0YDR5dC+bB2g/W9k8xeq1RWFca3RdQGl7n0SPoPRdDXhSJ0lrDw7QkLl9lVdksoQQWE76VUSTszHzCkbWzd1ly94fOONril3s=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB7767.namprd10.prod.outlook.com (2603:10b6:510:2fe::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 15:47:05 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 15:47:05 +0000
Date: Wed, 27 Aug 2025 16:47:02 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        hannes@cmpxchg.org, usamaarif642@gmail.com,
        gutierrez.asier@huawei-partners.com, willy@infradead.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net,
        bpf@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 mm-new 10/10] MAINTAINERS: add entry for BPF-based THP
 adjustment
Message-ID: <6934188d-12a5-4225-aaa9-828878d8dba2@lucifer.local>
References: <20250826071948.2618-1-laoar.shao@gmail.com>
 <20250826071948.2618-11-laoar.shao@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826071948.2618-11-laoar.shao@gmail.com>
X-ClientProxiedBy: LO4P123CA0404.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: ba5e580e-efae-483f-45be-08dde580f900
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cx/EYkPbyorurY5hZVS8D5oG+avIC7KpxvpBsMXWMeO5ky/VurD36rD0NaSL?=
 =?us-ascii?Q?zwSwESqDwvO9JPaBqFgRlFckV3L7owvzYtsNp1DOw+TkIffExCCdTc6d682V?=
 =?us-ascii?Q?7WJ5mqVxg9utMkWIk3F9euDUs2MCinC5bzfu4dfBY5iYUHG+u3JHFUtc8Jgs?=
 =?us-ascii?Q?iT+QTTKKbCY5/lFICXjsGykMTFC4bsD6chcJFEyXmCod7dpBgJgPTe/cgnFO?=
 =?us-ascii?Q?lbfUlEWcxH3hHTbaJmjY5MWa8Moi1uZbRdAWX9YnbjImfP3ODLKx+FLyaYnC?=
 =?us-ascii?Q?trCuJt7CcgFn4i2ClcwQpT+8gBoQrH8uskront7NU5TPvkwygUJ3lw3IT7Hn?=
 =?us-ascii?Q?e1H5auIyk2WgA2mKM81G3HZtePCSdOYIfQzfDYUQ89dcUjTKN6zPoQ0rs1uR?=
 =?us-ascii?Q?J9yLDT3x9hBHbBSKGpIa5NrTDeSi6oQjrudPjCKApItxCLvNXTURzSwfD6bH?=
 =?us-ascii?Q?J0jkiBpVRZGmCLb3yk/t1dABtC5iI6cYLZzbKtvrHhCD4KGW+25QMOoQcK1A?=
 =?us-ascii?Q?hvcO2WuIw+4V9m9DyNTT1jIxCR5Do+UYqNCbasAe4pLM5rbrCZDTkwWbIwWc?=
 =?us-ascii?Q?wDCJA/P91Ou8weVKYinYsGTazWbaN9o7/SWVPUmrn7otZhExDeBjny1sxLoX?=
 =?us-ascii?Q?FRYkrZm5Mgwl1o7chDNL+X/8atuLo6Np8TMV38ci7RCGGRaeeZY3rXZzUNfw?=
 =?us-ascii?Q?n5Xc2n6ZlLRtI3bz+I6UkEgswchgthwa3903x27gRpoAyDcAu0/HlNJNuGPu?=
 =?us-ascii?Q?WIoJrJB6NEQvgCMzCTbrqYIiAKadaLKJ/XCnCIcSAD17nMRrdDV/AiLHj418?=
 =?us-ascii?Q?8M3Qwmv9zAbXWyYh5MUpoZ0JiCt4ACPr0WNalGSJ93Zs/NUMApQmb516E8Pz?=
 =?us-ascii?Q?WAtHOj4eN1ND4F8rkuZOeC8PnBkdxzDFSvhrm4mRoBjd80ph1EGH6KxV5nfx?=
 =?us-ascii?Q?ud9vzsdIcTDxHxSC6b5x7hjard8DHP7ZQVkDiryDUkC7I9rcObLS2xQp/4eX?=
 =?us-ascii?Q?VVnMkcmfIS0PZsxYCl5sA7wAXp+rY/vEHkUQgDbb/7abR43Da7/TzBXijJHe?=
 =?us-ascii?Q?uFIY6yetEDQWoNBSgfmFGvITgyyC1786sPERhY9JgJVYC035NZ8eUPusoOXD?=
 =?us-ascii?Q?gOCq4sltT/kZ5BabA0wSxbfaIskmoFveNMhl5fEYOE1rwS47m90pKuZtt0ul?=
 =?us-ascii?Q?6UptRFDA1/fcRBe+Cqh8KlJlICynNLCHYszmdEW1DbqHKdESxCs3NZhZpYrv?=
 =?us-ascii?Q?jsSU5OPbwwMqnrHIpVTY5wAGztXJyPwG5EetPXH7+hHvYJ+uMw2+31hdlEuK?=
 =?us-ascii?Q?j9ghMbu4RT6tN/TBBdCkK3XSN4HlFx4uFLsxxhYghHvfSh+/tmJeDLv6xy3c?=
 =?us-ascii?Q?nLP+vt2LL3hCMTuYvTO0DvPr1HuzR3jNKxz18kBwL3ElV5zqj0ndwdElYrHG?=
 =?us-ascii?Q?wdgZoCOy9HE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WpFrdrrhgHC+iUla/oiMoVd8MDCRutKwFo+pJHaz35eNEqqxawYxpELyaL9B?=
 =?us-ascii?Q?QhUTJEZYZ25/65P4XjwscGL0lV9Z+yi/HGjQ+lkK9JcTdCFkBeuX8qRJTY8R?=
 =?us-ascii?Q?VoKLYeiYkOxmdRtTSuzEGcImhHw2DcLeP9YQ2dx2B5I2XSnLvLj9NFeAUJ/V?=
 =?us-ascii?Q?hEu3rBoTrOtmUkw+6CMjM/SwjZsG6qPy9kX9p6p+cygCcqNBW/NH0YMiNnv9?=
 =?us-ascii?Q?yWKde3udtnvTrjRK7a7tM24nj6d2Vl3W37feW45iSAVRuyc2rsk1UWSMoH6F?=
 =?us-ascii?Q?i1omBYx+HENzNLZfsIJPIiMyio6Z4vn3dYKC3vBh1ic24+5ACm91MGyAA/qy?=
 =?us-ascii?Q?DN9ofc0f0BeGpg9EnPE0IIz8h6J6nWwadTMNN6hEjOlTKvCr0lB3rBuyuV5F?=
 =?us-ascii?Q?zM1tq8lCLWSfbeb8iW2EFAyIncuob8BP+b0kS6br6rDsQywdPrhELyt4kCsO?=
 =?us-ascii?Q?0bZE80rgYveLFGDA8eFySKgjICDxfnibHhQJist3QCpllFWUwvRzj3r+p1CJ?=
 =?us-ascii?Q?OKpDGRADFjIs3+9pb/KjiGauDxxZP7wbr4O7vhZakrmiYFrGKNqUAK8aKm8z?=
 =?us-ascii?Q?JXlOsaWBr6Yp3hDUslNn+U9Dwo5Wz4+Syj3EPMB2iPQbwBOh1AbgKthZxL0b?=
 =?us-ascii?Q?Fm1aV4fR1epwVEtvsb3pmLrH4SjL1zglF6cG3BFlw/3q2lIDIKIBZonlUc7W?=
 =?us-ascii?Q?D6k2hjPeXIHh/V7RzrxzaObaKCiaOnw9Ohh26pMUuiOjII7AE3gnTtbpvCpM?=
 =?us-ascii?Q?D9aV4cJ2s4kZJXz90gw/GdYI/WKtgtJpergrlYM4i17pK/QeecGFEmOXnGId?=
 =?us-ascii?Q?vDfVozack3f0Mm8dREkhK19w6pA5WQNgtxZd6gtI1qop+6ZoXH7hwhkCjwzJ?=
 =?us-ascii?Q?57cJbVmsKwegIDBA/VH7WHVPX0dhliHwljnZ2A5mOXZOlELefjPHZvaPGkHd?=
 =?us-ascii?Q?b+wHjI67Kk/fwQp5a6W7F4YNreb81eKMyAfQMxafMHVvev9PxaA4z5CssSok?=
 =?us-ascii?Q?iq8BqqFKymiVPRkkNtnSSCNR2JAvC+GRPLeXAcrv/6uBjkLpLIrb8SOF+77J?=
 =?us-ascii?Q?5q2+fbxZagp4vIlR1TudguKR1pqFs6VLZuDQQJ7FrVWDz/5y5S+xJn9FnKyk?=
 =?us-ascii?Q?66JZgVArBCmzrzNU4YsobHiAx4IE/7MijfjPbG+vGkktA1s3JVrt5/K8eIVX?=
 =?us-ascii?Q?MB4q8nln8t6ZB4wXSXKpvAgkiECd4Yvhlf92ia8fgNUJcXHLNXF/UkF/LUOM?=
 =?us-ascii?Q?8rmr0cOJHhztI9BYnaz5mDnl49SJ1j+fncXIovVMGzC3TYBI9YTCW8dd5w/f?=
 =?us-ascii?Q?hBOjOTjp+CgHovRcNUVvjPkfpbWW1SGkWlDir6IONKexgUbU7kCRQ890V3jW?=
 =?us-ascii?Q?44FHEcA+1USiyghiate+b9vaYVWuo945lWDHadsJPTT6vvNeEzDiDYGTa7dU?=
 =?us-ascii?Q?BiChMkuMEYNBnJIuyB/jSakOBCHuW5J4oBB9qN+ayLfPgyubBlFEeR+pD8MV?=
 =?us-ascii?Q?QBIfw8JKoH3f8qBg83nivwWoKkV6nGMIBd18sdGWl2ztKcNppUAwMYKmGUve?=
 =?us-ascii?Q?4q87tzdgF6cw4beN1jO55K44mPBQAPf+BKYBgDS7A6w3PSjnbbPHT9nsnQXg?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	g03qFpw0AkZ0sFqmR+rquPGCTvzCNv1/0CydVweuG9hI7V3sMK1au/XHP+6VeH/rh/ch87xb/nMfxOBxJXEdPvZwrK0lmXRE479NaUAf77cXHt7LrkQihNv6bMzv6qs6hSDl8IccRHmRS8b1FPS8nAnPuR/QnuP1676V2hrKIdPhllsAQdSZKUnJROsJ3FiZCofro9zKvdBwONoMM1spDFmceG8+i8KThMBSsY0oDGVcFMMLnbr24Ubr9YTt2iLHNKG8vheR83MQxmizoj623dq32EYaL13etvvsqS/EoFCvUxbpSq1wrs/b+SH85f6vFup/T9axgvFEGp6ump7t5H/1b/qQvEGCO4Es7g2Q5ummzcBi8r6WpOpkfQuPnPz5jTqqNibK0rybtO3Em5TeLmRXkQoE2gN9wvU9Ivr4WDk2NJEaFX/MBaaVYTq74wXpPIjysqZfKMRkksm4IdxW952XlMeQK8dk5VfEdO1d8UCDTQhAZR9jJa4jFZx6EmYQom9PYp2guYdxXzoM3t0mDgk69MJKTzGwBiin/aD/Qbr8X+S0ZnH7wKgxJiJNpJzuXrblt1ynuY8QHg9kUxpk1wjXYeOTDZKU1ryNOlmD1M0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5e580e-efae-483f-45be-08dde580f900
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 15:47:05.3298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZV6kwSW7hSOk5zvS4/IMBb30nKsJ97gTnl3W5itqHgucpArPu88McOEmYRcvMNrKpbxv6izTer8Kw7fS2mdJR8VMe9ACD9gYBFJy8cJ6EU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7767
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508270135
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxNyBTYWx0ZWRfXxc/HMHp7TbFG
 l7hjAUn3kg1SiZxplzy6UjlEVSJrzuoeIv0HVeg1eyNjUipJMNhxeHlY2SLYxQTzcWuYLyE9dGw
 eFoYUivHOYVxNqY5vZfuhzRKD8+6pxZUDUClGNlt4z4clmqnBi2ZFLSqtmrEkXufMQjhDtrkgmR
 9pmkIE5Qph3XiOlNSmUA6e24QeC460NLnLW6BHgX6YWhlckmCHpxqLEqxXhhKMYb9m5e0KMyHmt
 WSvZdQI3rWKeMtpSV9rccBiNSLmVUnDHEZSwu3Jlbhy3E/sd/diRv3KaJuZQyYkAKx5OEXsKE/C
 UgEymVIaOfBLRsd08Z+NbbEIH48yPiCndkyx+b2jbv99mB0kax09KQxYjN1QS9SW1tSjZa0o+Ls
 0ddWduEjeKF8a5R5sEVWGL0xhRQQpw==
X-Proofpoint-ORIG-GUID: eRD-X-1Obo3sRm8hU_Xa-G-HaT6ianjY
X-Proofpoint-GUID: eRD-X-1Obo3sRm8hU_Xa-G-HaT6ianjY
X-Authority-Analysis: v=2.4 cv=IauHWXqa c=1 sm=1 tr=0 ts=68af287c b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=37rDS-QxAAAA:8 a=Z4Rwk6OoAAAA:8 a=20KFwNOVAAAA:8 a=zKPDAW-Sw0mgkiUV6_gA:9
 a=CjuIK1q_8ugA:10 a=k1Nq6YrhK2t884LQW06G:22 a=HkZW87K1Qel5hWWM3VKY:22 cc=ntf
 awl=host:12068

On Tue, Aug 26, 2025 at 03:19:48PM +0800, Yafang Shao wrote:
> Add maintainership entry for the experimental BPF-driven THP adjustment
> feature. This experimental component may be removed in future releases.
> I will help with maintenance tasks for this feature during its development
> lifecycle.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  MAINTAINERS | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 390829ae9803..71d0f7c58ce8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16239,6 +16239,7 @@ F:	Documentation/admin-guide/mm/transhuge.rst
>  F:	include/linux/huge_mm.h
>  F:	include/linux/khugepaged.h
>  F:	include/trace/events/huge_memory.h
> +F:	mm/bpf_thp.c
>  F:	mm/huge_memory.c
>  F:	mm/khugepaged.c
>  F:	mm/mm_slot.h
> @@ -16246,6 +16247,15 @@ F:	tools/testing/selftests/mm/khugepaged.c
>  F:	tools/testing/selftests/mm/split_huge_page_test.c
>  F:	tools/testing/selftests/mm/transhuge-stress.c
>
> +MEMORY MANAGEMENT - THP WITH BPF SUPPORT
> +M:	Yafang Shao <laoar.shao@gmail.com>
> +L:	bpf@vger.kernel.org
> +L:	linux-mm@kvack.org
> +S:	Maintained
> +F:	mm/bpf_thp.c
> +F:	tools/testing/selftests/bpf/prog_tests/thp_adjust.c
> +F:	tools/testing/selftests/bpf/progs/test_thp_adjust*
> +

Sorry but I don't agree with a separate section for this.

This should form part of the THP section only, I don't think it's warranted to
do elsewise.

>  MEMORY MANAGEMENT - USERFAULTFD
>  M:	Andrew Morton <akpm@linux-foundation.org>
>  R:	Peter Xu <peterx@redhat.com>
> --
> 2.47.3
>

