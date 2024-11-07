Return-Path: <bpf+bounces-44245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E6F9C099A
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 16:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14E041F245F9
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 15:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF06212D21;
	Thu,  7 Nov 2024 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U49qGbvK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Q/FpE7oj"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518332940D;
	Thu,  7 Nov 2024 15:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730991978; cv=fail; b=PCaq8TlPaqjb5888+IZYNdl99SRHs7KfAOZlwxxTyYh0heRtmD+PPwpxtcuvzR8gX6rpMBRzlPiZOcrwIm67xgwM6rqsLl+PkSr6X4jdc9aUx9Wzu08E3MGojE3kTQzqbWwQVx2HbAA9Q5Dev3kjmn1zNAzRlVa+RZqETNmewi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730991978; c=relaxed/simple;
	bh=OHiS5KU59hbBbNQgtXxci0LcQSxEqbHtU7uk6joM4aQ=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m+eylNmDEACA66NjIVSkGiIOrSoG9/axpRa/87aJKN2yjjtZok7wp0/rBOLqj+sSsjq6HIm87A1Reouaba06HREZh92X1EKEGqaiYMNcZorOvnAVsP0Hg4Q+cY6si/4hDdbROl1crPAtTubC3qfAlNQL4FEJoAOBiMjb1/cqmGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U49qGbvK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Q/FpE7oj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7D2EoJ031344;
	Thu, 7 Nov 2024 15:06:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=q9WZJNNR19qe1VrMHP2EoShhEQOyuAhTg6eeH5vWZfw=; b=
	U49qGbvK6ittwgUnGJWew97qsYbS6m1LbvkQrurDuag6GuYwBiZf1X1LzcuKkRaI
	WUhun+fw/8HGn9yIXM/73lmbOz2YElQxrXuP1xPvfrSJs2/bjpaepH9C7B+LIFDz
	nGFp7pOMdCD9UIquDaEUm0AtNVnZZ35hoD+osN0YtotCDU3IHY1KapkrNroKk9+R
	s+NLdwzYXlOMPf7XubUoyfnZ0qmrdexGymIVcc8KHyg5vK2jN8PcLvRw9LG5rT1x
	q1Z5fwoHmBNEgWydxWFTVJBQ8ZeENLvPDwwToQtT8emSGVih96v2tQohQeWzbHtU
	H9aX6rxoTG97FxRz78ahOQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nb0cjqs4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 15:06:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7E5oht031449;
	Thu, 7 Nov 2024 15:06:13 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42nah9ur1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 15:06:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IoMJHGXjIiYbHJDMdGHYGwQK8FhDKH+7AEne3oU11DiNe/3eL3+S6/70nK7JBk4TIksuaqu3G4tLtS58zQ0AKRVgLbonl1cVajuY5/QOd34RSM60xKGi7USPQzfu33tfaerFC8gdB2fzZ4yNQtE7ZZLblvhzbElusNv6zsk96Dzs5hVNJNreIHYR9WdyWbi9ftwmz7UUnipyHXXoIi3wtJBldFEn6WMSOV7rCjFIV1XoN9S3H34W+KMF50Ajet6DL3uod0M1N4A9GagtZNsR8EHdhEhpl2kgTWL8jGpGClK0cpH0N3rbUHImfhoA3QAtlFLUKelWqQPReTltSK6H5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9WZJNNR19qe1VrMHP2EoShhEQOyuAhTg6eeH5vWZfw=;
 b=VGex3K2z6KG5tl6dHnN3EN3yJG/lvjsBPJBsbcd+NuMd5QSYHBlKGT2JO+XlG/orVpAPjQ8bK0upynN+4xB4R3hzFvZ6wOfypS1AjZv+AYhKlsHxsfy5v8wBvv2prrF1EtT2ZGXTrrwsfD/sb/yY5wNEwWJcrFvsyuYKxEwnN1eh4rV+vg/r3mCdP82rbqng3jTQhmGcr965Dm+zcVdaOzW+a0CEA5QhiqJynC65dCrbivuLAezt2dXSxQCQys/rPuQQHrlvJsKaVxsDjS1RBfN8oDdeyK9Rd8/19jzahUHADBtGhsrc4BHFVvux1+RZCNAhhMJldlIAKu7v6Wd09w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9WZJNNR19qe1VrMHP2EoShhEQOyuAhTg6eeH5vWZfw=;
 b=Q/FpE7ojmvoPZ9sV+8RiTMF/f/AoCPWZfln5jOx+VUqarkzmYPggdXo2/bl2SpQKLu9cRV68kQ8ub3V9jMYK8LiAIZJ0QZINpb3VlH3KuAYruKLt3mSn9KHrEdde6Mr2B6KW+784VIiJVRRn70rwahQUBBw6DQ1S2vepR30HEiY=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA0PR10MB7546.namprd10.prod.outlook.com (2603:10b6:208:483::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Thu, 7 Nov
 2024 15:06:07 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%3]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 15:06:07 +0000
Message-ID: <90b3b613-8665-425b-8132-5b9ac86ab616@oracle.com>
Date: Thu, 7 Nov 2024 15:05:56 +0000
User-Agent: Mozilla Thunderbird
From: Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [REGRESSION] module BTF validation failure (Error -22) on next
To: Laura Nao <laura.nao@collabora.com>, regressions@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, kernel@collabora.com, bpf@vger.kernel.org,
        chrome-platform@lists.linux.dev
References: <20241106160820.259829-1-laura.nao@collabora.com>
Content-Language: en-GB
In-Reply-To: <20241106160820.259829-1-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA0PR10MB7546:EE_
X-MS-Office365-Filtering-Correlation-Id: 4966a2a3-afcb-4415-deaa-08dcff3db4ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1kwYlNMUXhrNjYxMStSWTJpb2tUNCtKVTk2bEpZWGtlUWdmVnF4L0JFREtX?=
 =?utf-8?B?MVNmV1AzUEdOQXJtWDQvZDNvaG44UnFUL3ZNNHdKK2FyUGxYcm1nY1VNMkdR?=
 =?utf-8?B?R1NoQnNsc2k1anRuRzk0NW44NlZ6U1lkZHh1OHFHWktGU3V0RVhhUlJ1Mll6?=
 =?utf-8?B?NFpUSnlTWWhLVWpqZDFYOFJjOEdEaVAxN3U1cTI5WklRaEtlWDJpSW8wVDVF?=
 =?utf-8?B?MVAyN0RONkNLZTR1Z3BISXdwSldCM2M2bk5adnMrbkdvVDRUTHFiK1hSc00x?=
 =?utf-8?B?VWxWZW82Y1Z4by9CbVZsZk5YbmNPMnVwY0hRL3BpTW4xUUoxN1JIcmptV0J1?=
 =?utf-8?B?NUpmM0gvVjhnbTl3a2Z6M0FOcXNUejVzQ1lnNnRsZkdYbUc2eHNubTdvTWhI?=
 =?utf-8?B?VVpvM2EzRDRHaW9vcmlVbUc3V0RNREh1TWZQcVlHbjJEZ2dHRTRtZVVLWjM5?=
 =?utf-8?B?WUlGUVgwZW1vTmZmWHFHZWtmS2JFMnMzY2UweUx6WURZRldQeC9MQUtvVnV1?=
 =?utf-8?B?T1RpYmlXWlNxa3JFb1BHM0NNWDFJczNiOWVVYTVSM0kxSU5Vc0lSTENYMW12?=
 =?utf-8?B?eldFcVZhRTh2d1VEbjdGUVdrS1B3dXpMV2c0bEd0cHVweWJwQzdXWTFiU3BZ?=
 =?utf-8?B?ejBoVmZzcnlDOTZ0RHlCNHI4bERmeHN2VW12Y0s3ZFFyLzNMZm5Tb0QxMDFa?=
 =?utf-8?B?TWtkSGVNRXRrVFY5bjRoWWxXa2tVZ1k3bVAza2lGVWRBc0RacHVPYlJnTytZ?=
 =?utf-8?B?SVpYaFE2TTVneTFQeEtEcFZSYXROWGk0TWdJMXdWR0x6MkMwMVlVNkZMZ2RU?=
 =?utf-8?B?SkhwQ0QxeUZBbDhXaURJcTlQeCtWNDY1V2ZOc2tFMDNXSXFaVHlLbkxvTVB6?=
 =?utf-8?B?bGNHQUlabTF1VGZnN2FvMFVtMk95NVRrYU9ZQTZjcWJxdWFiRXc2cjJPK3dm?=
 =?utf-8?B?WC9JR3poWGUzeEZwRWpsUE93YTRUeGp4S3BnSlN5L2xvVHptWjh3Mi9vK1h6?=
 =?utf-8?B?aFprNUM2QkpuUWxPbUJJWWtZYXQzUHhvUXNzaUU0SFBWR3orcFNkem9iUkVB?=
 =?utf-8?B?MlN6cmFMWlRYU3NjSjNybnExTEV4RVdZV2p0VHFscnZxR1V6THhuYzNWSmg2?=
 =?utf-8?B?NWdxODloWUpsS1ZEdkZpSkU2ZU5RN3RxSUhuVUw5b25jMVRTdE5NSVM3SE1C?=
 =?utf-8?B?NUxVREgxMDhBMGVUN0VvMUVhL2hBT3pFMXVtQzEvall2UlNIZHpqbzNMSURM?=
 =?utf-8?B?MXVzVnFPVTB0ekd3Vnc3NVd4c3FOM3lVSkpRaldjT2RmQVNWejBGWklsNzlR?=
 =?utf-8?B?UUs5amVZUW9reER4ZnlYNCtWSDllYkxOalpTSzhhN1ZocmtGSGU3YjZRWSth?=
 =?utf-8?B?ZWRxV1orTHJKb3ROU2Z0VzdoNFc3ai85ZTUwRCtNMlEyZHFKWnFLWUpQcmRQ?=
 =?utf-8?B?bytOZm9MM2h3cS9TOTdKUEpraHFZdlJhTWJDZDdVSmExUGt5TzZJQTJjZUp4?=
 =?utf-8?B?ZEZjT2pwSGNhZWRpOWlydXVwNlJ5NmlaYjdxM1pVUngwRnp3aW4vTFV4QmRs?=
 =?utf-8?B?OGZURUpYRmlzWmJib3VGbnhIQ2lkbVFlKzBVTGRkZ0Rma0ZVaGxGLzV6Qktj?=
 =?utf-8?B?K0Y1VWE4cmUyZStmck92dTBLb3ZMRll3bzgrZTNkWFpHZkI0TWFoTkh3S1Nw?=
 =?utf-8?B?VGtUb3B5YnAySERtcXYxNnpjUkF6SEhPd1JDeGxVY3pQamtoNzBEanJoZXJO?=
 =?utf-8?Q?DliW9p2UppXXdoV3yp0AKKdS9ZWgEEQbCYxqBNJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TktBdnJKdElhWm1iNUlhRThCc09uZUhlTDVuZjZBRzFTZjAwTForbXh2R2NX?=
 =?utf-8?B?OXYyOTh3M0FzOEtJV1JYcVdoSzVhTllsMlVyZFNBWEpIWXdlTWhSZS8zTm5o?=
 =?utf-8?B?cWhhOUxBRnB0M3hwQ2hHQkc4ZThDSkNtSERwOVBCMmwrMGppZWF2QzJ0Z3Qx?=
 =?utf-8?B?SlBmWEZjUEFOS25IUjR2bkQrWjJSMldzM1BEOFJzaXVLRm1yZlp2bVVCL21D?=
 =?utf-8?B?MGJUc3J0eXhqVHByL3dCOU1NTUFOZVZpMnJ6MmVHRmZVYnh6K2Vvbjh1V0Zq?=
 =?utf-8?B?RDd3ODZuMUh3eTVaZkp6aVNhenJWcWZ5R0pNVDFlS0tmNGVkbVI5REZFZTN5?=
 =?utf-8?B?UlZtSHVUaWhHV1Q4ZTJWc2V0SzR3VlRGZEVDbElFYXhjOWtzQzB1ZHkzSWQ0?=
 =?utf-8?B?Ly9wMFJZMW92cC9hNVJTS2hiWHJUNE5Vc05QUWJIejFxUEFpcmVzV2FhVEt5?=
 =?utf-8?B?VGpKRHFWbys5QmNFNzhSS2tHRmwvL29WcGdBNlhTSDFXRVRMOHBlSmwxWnZi?=
 =?utf-8?B?Qzh4SXAyUmxEUE5zVW5mUGJUQ1BhVVhlSEl2WUtmVTU1MVdUVjhKbDNqSGJ5?=
 =?utf-8?B?OVB3UlBxOHduTUFuc3BTeGVPMWorem9GQSs4U01LL0YvMXRNWWlRU0RCZmxJ?=
 =?utf-8?B?R3lFaXdiSFB2aE0wM0JEU05wMXc3YTBORkxTUmdSakZVKzJoL2JLSVYvNlc4?=
 =?utf-8?B?bTJiZjRVTko2bmkzNXZzWVFqazBxSFRxVEhKU0xzUGZiTHlHMklwS3NmSlE5?=
 =?utf-8?B?ME1mNTRDM0pXa3h3dGNuWTAwWUlsNjVGYlJpaG5ObksyVVhPNUxNUVRZTENq?=
 =?utf-8?B?NkVOU0N2UzJtUkNmdDg3bGxOS2EzNVN1UkJHOUpJUDRLNUIvTGJLRTJ3VEkv?=
 =?utf-8?B?UnRSUUxldjJwdmVzTTdWOWN6SkEvRTk0M0tpZFVXSHBwK3p2TVRCK3NPNWlV?=
 =?utf-8?B?Q1k0QWZJNGsvODVnazZTTzBzZG9aK2RvU2R1ZWVIdGdIcnUvQW5hWDdCRWw0?=
 =?utf-8?B?V2pJZnVWVU1EeUdzUW1xUnRlREsxL0hUQXA4RXhLa1VabWVNSnFkVUttWjZV?=
 =?utf-8?B?T016U0R5TU54bExseTlOM0YvTTJUdlZEaFJMMnM4SUtRckZnNThySmNUVnRz?=
 =?utf-8?B?aUpYM0NBTTNOQ2RneTlaYXVRdGsxOW1vTjI3cCtCdGRZSWJGQi9kempYMVpz?=
 =?utf-8?B?NzlkSWV1eGxEV1dGOHpHcytYTlJWcmFwOU9aeDlUd2o2ODIvQXhMV0NPR2pU?=
 =?utf-8?B?ZnkzdnpTa2krelFlMlpDMzVabzNkZTVTQ1h1UzNRZ29Xa0hNSlE1VTN0QWZT?=
 =?utf-8?B?U2MrWEdKVDdxUzloOVdHZE5TZkFtVFBjM05mU29ZNlFMdGppUGVhUlV4bU1Q?=
 =?utf-8?B?M3ZGNW0rMWZlM1ZMTEVRazUyNFpoNmdnVTV6U2xNK2lFZGpRSzN1KzJiWnNQ?=
 =?utf-8?B?RFpMenppZGM0TkpDQTByRCtiRDZ0L0NLY005M1FTZVNiZDFJS0Y2Z0FuQjJS?=
 =?utf-8?B?em1QT0hwci9lM2VreHZaemRoT3VwbloxRlJUU2VxOEwvd0psUS93UGZlRm94?=
 =?utf-8?B?aC85TFhRSURzeWhNbHBzT1RjaDlrSlFQR2NORno5aHlSeldZaWpHVThrREdS?=
 =?utf-8?B?bHM4MGVaZ0NuSExtRktjcmxzMWMyUzBSN215UWMyYjA0WTc5SHpCYVh5OTJn?=
 =?utf-8?B?azdFNlkzMHRsb3Y4ZkdsckVLOW83S3RDY0RJclNYTCtCQVN0djhzbU1QcHNy?=
 =?utf-8?B?NnVEQ3A5N1pINUtCSTBueDhSWUp5cXhMeHJnMk56Mm5tSUFRWWREZmQzd1lL?=
 =?utf-8?B?RklGbGZkRDh1Y3ExeWw5VEZ2ekdBNVVPYjJOVkpEYlhPVm0vRzVFNzNZVE1S?=
 =?utf-8?B?SU1lcnlSN2J4OEJQV1ZmT3FZRW8vSThVVmx4UGVxOUVxeU95YXA4RUVEN1Ez?=
 =?utf-8?B?NGRlampZelVNZHplT290N0FJZ1E5bW10YjF3NGFwdjhjeEV1SE9zZjdSdCtK?=
 =?utf-8?B?Sit6NnpOSnBLV2g2WURkZHU3NHBDQnhTbUhwNC9WTDdnVWU1TUpsTHlwS3p4?=
 =?utf-8?B?bFhydk5tbHdtdWlKRHhjNGdoeWoxemwxQlFzY1J3bG9wV2w4aXM5WTlrSkVm?=
 =?utf-8?B?MDgreFZSSklRSDFiWXdQclNjYXpOOXc5bmI3WEVGZTZlbCtZeGU0c0JaSWY1?=
 =?utf-8?Q?3/KEpfNFnD1HLDGxMa1pdNE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0I7kYJNZYzpWKrmIT0Wz619jKjmP71T+UhU8uH4ycPse2wh9B5ZDPaHdFPEysWxVTUYaSgo/s9f3o2YpYgwjwW/HrKwuGB5J7lby+/yqdH+qzwladjKW6ab/klQzlyGlsEUsYZuL0gveRXb0qahp2UStDOo3AOm+ETDYImzg+CbWsGjibBlDBA2/O/qBTmA5+52umimgBi3QrZKyzGADAsXhBr0c4P1DoeLn9oFDXsH5B3PVMkKlZCe+Pf/WmFeINqkzbgsEJ1RAzBzzaRizVCZ3KAFlqqLLQI5QxQ5A5fmYhzj7RhrQrGoX6O9/AM4QmnMA4VYt4OHbOr2DEMKPSjYZBqLaNoY/8YGfhPR2Lwq8DaAzPvzubHbHt3aLU/16Kr8OYUS541pirPPgmWafVb6PDnGMB/fwOGZpGRv2d/8WD1xm1YemzZmylmchjtbYYhQ1rVmjZh7yxQi1luNJQtsrHtdjGn9E4AxY4HJPeYcIMis/H9zl3XBiwgeu2MWf7Ax2zlJPLMK4mUFH5sdXmiylm+zkL6ddexX3Gd5WjtAPkLlyMwHSq4WkrM3k69UbtVE0mHhQFSTtHYgA9Dj2hbuaArlKVWptEXcIMJYarkA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4966a2a3-afcb-4415-deaa-08dcff3db4ca
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 15:06:07.4637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7HfflWXqfmTioF7y6xZvADoT9/nf0vVHKHbMEndW9cz+/9tR8iYPyASu2BE8re7Yl6SnAFBgkFISCGXB3t8tPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7546
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-07_06,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411070117
X-Proofpoint-ORIG-GUID: WqDI15_Ux7rb5yctW71LZseHGQxzDIjZ
X-Proofpoint-GUID: WqDI15_Ux7rb5yctW71LZseHGQxzDIjZ

On 06/11/2024 16:08, Laura Nao wrote:
> Hello,
> 
> KernelCI has detected a module loading regression affecting all AMD and 
> Intel Chromebooks in the Collabora LAVA lab, occurring between 
> next-20241024 and next-20241025.
> 
> The logs indicate a failure in BTF module validation, preventing all 
> modules from loading correctly (with CONFIG_MODULE_ALLOW_BTF_MISMATCH 
> unset). The example below is from an AMD Chromebook (HP 14b na0052xx), 
> with similar errors observed on other AMD and Intel devices:
> 
> [    5.284373] failed to validate module [cros_kbd_led_backlight] BTF: -22
> [    5.291392] failed to validate module [i2c_hid] BTF: -22
> [    5.293958] failed to validate module [chromeos_pstore] BTF: -22
> [    5.302832] failed to validate module [coreboot_table] BTF: -22
> [    5.309175] failed to validate module [raydium_i2c_ts] BTF: -22
> [    5.309264] failed to validate module [i2c_cros_ec_tunnel] BTF: -22
> [    5.322158] failed to validate module [typec] BTF: -22
> [    5.327554] failed to validate module [snd_timer] BTF: -22
> [    5.327573] failed to validate module [cros_usbpd_notify] BTF: -22
> [    5.339272] failed to validate module [elan_i2c] BTF: -22
> [    5.345821] failed to validate module [industrialio] BTF: -22
> [    5.423113] failed to validate module [cfg80211] BTF: -22
> [    5.443074] failed to validate module [cros_ec_dev] BTF: -22
> [    5.448857] failed to validate module [snd_pci_acp3x] BTF: -22
> [    5.454736] failed to validate module [cros_kbd_led_backlight] BTF: -22
> [    5.461458] failed to validate module [regmap_i2c] BTF: -22
> [    5.470228] failed to validate module [i2c_piix4] BTF: -22
> [    5.491123] failed to validate module [i2c_hid] BTF: -22
> [    5.491226] failed to validate module [chromeos_pstore] BTF: -22
> [    5.496519] failed to validate module [coreboot_table] BTF: -22
> [    5.502632] failed to validate module [snd_timer] BTF: -22
> [    5.538916] failed to validate module [gsmi] BTF: -22
> [    5.604971] failed to validate module [mii] BTF: -22
> [    5.604971] failed to validate module [videobuf2_common] BTF: -22
> [    5.604972] failed to validate module [sp5100_tco] BTF: -22
> [    5.616068] failed to validate module [snd_soc_acpi] BTF: -22
> [    5.680553] failed to validate module [bluetooth] BTF: -22
> [    5.749320] failed to validate module [chromeos_pstore] BTF: -22
> [    5.755440] failed to validate module [mii] BTF: -22
> [    5.760522] failed to validate module [snd_timer] BTF: -22
> [    5.783549] failed to validate module [bluetooth] BTF: -22
> [    5.841561] failed to validate module [mii] BTF: -22
> [    5.846699] failed to validate module [snd_timer] BTF: -22
> [    5.892444] failed to validate module [mii] BTF: -22
> [    5.897708] failed to validate module [snd_timer] BTF: -22
> [    5.945507] failed to validate module [snd_timer] BTF: -22
> 
> The full kernel log is available on [1]. The config used is available on
> [2] and the kernel/modules have been built using gcc-12.
> 
> The issue is still present on next-20241105.
> 
> I'm sending this report to track the regression while a fix is
> identified. The culprit commit hasn't been pinpointed yet, I'll report
> back once it's identified.
> 
> Any feedback or suggestion for additional debugging steps would be greatly 
> appreciated.
> 
> Best,
>

Thanks for the report! Judging from the config, you're seeing this with
pahole v1.24. I have seen issues like this in the past where during a
kernel build, module BTF has been built against vmlinux BTF, and then
something later re-triggers vmlinux BTF generation. If that re-triggered
vmlinux BTF does not use the same type ids for types, this can result in
mismatch errors as above since modules are referring to out-of-date type
ids in vmlinux. That's just a preliminary guess though, we'll
need more info to help get to the bottom of this.

A few suggestions to help debug this:

- if you have build logs, check BTF generation of vmlinux. Did it in
fact happen twice perhaps? Even better if, if kernel CI saves logs, feel
free to send a pointer and I'll take a look.
- can you post the vmlinux (stripped of DWARF data if possible to limit
size) and one of the failing modules somewhere so we can analyze?
- Failing that,
bpftool btf dump file /path/2/vmlinux_from_build > vmlinux.raw
and upload of the vmlinux.raw and one of the failing module .kos would help.

I've tried to reproduce this; no luck so far at my end.

Alan

> Laura
> 
> [1] https://pastebin.com/raw/dtvzBkxh
> [2] https://pastebin.com/raw/a1MGi3wH
> 
> #regzbot introduced: next-20241024..next-20241025
> 
> 


