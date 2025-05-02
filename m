Return-Path: <bpf+bounces-57208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6DFAA6E2B
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 11:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB87D3BED64
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 09:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3333622D78B;
	Fri,  2 May 2025 09:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F0rmJcZg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Sivpzn1y"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C139218024
	for <bpf@vger.kernel.org>; Fri,  2 May 2025 09:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746178331; cv=fail; b=Ai5XG7zYCt2g2MYSyDcm/6cdKX+m7BUJwxOJR34tklHReZS1FQvn5kT/JrbZOclTGid9yccDHL1NXTR+zXO9ui/oh9Idl+IdrUxgD/YLnW6QTQMaxVZT+d8rCBqluZLv0OzmID7/AJB1b8CSWH+asUNFN0yIhnj07O9VKndenjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746178331; c=relaxed/simple;
	bh=Y4j3AOsGoN++NKXXodydgt1eLShupC6HNXNGJ+LsPyA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gV2+rV4J9LHYofiLb7iONyeM/F+PNlbnxX/EtmtDlHslYn4MjjDFQLVcvp6/7wdU+boBL0mFNTO0Il4FLKAW2MV1dZoBvm0VAd7T+6YzQ5b+gLOYuso7ykCzx10+hdYw/lAXkEZvkGzfngWeS3Bd7T6taT0x0Xrs7UgkYWsnn0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F0rmJcZg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Sivpzn1y; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5425WYRO013685;
	Fri, 2 May 2025 09:31:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=u6xwhN7ILK5TZEyB/udEOv1nAt3q5qxIyCxsPggrW2I=; b=
	F0rmJcZgfvy55z+XioEPhg7kI4f8MwDJipNG3fnP3gcvYNBXeaqwvDm09JkOH29A
	ujDl+8ArtUO70w2jLwav2dT95h+/yuozA7RiLcv7UENL71Lp9E0et5gnb42O2Znn
	ghRvVKObiDFFLy1j0RXmabXUXIGTVcQ4+L5NkeNq3TnVHOE7bzR/pRFSsZb52Qyw
	02ld28PZzmCgQR7OS8ygHXpIzVAtYaqIrIBZ5Oovk+03uWjWaPgOudbDuUzwD5uZ
	EjLDxePCqCxVnV2RaWs+y17/WbrGa6IDq1JmMvlP2BW6WdlH28BMmx6h78Zm4c1C
	si87F8Ig+6q11oh8k7523A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6ukw3gb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 May 2025 09:31:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5427wUx9033611;
	Fri, 2 May 2025 09:31:51 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxdk1wv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 May 2025 09:31:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6UM/VZOx/0Sf0k6Ph5cPcScCtQc1TdK4DXU0TY37dakQfXGhQNLzt/C3CgM3TXp7rzzM3Ax9cdUzUFoT1xOCWoDu5wP/9xuv1BYfKp1wZk+LdjH1SKc2PbZsGoN6PGw5RI/OVio1KWHntt+5NdY/zC/xTiEzS15MKt7msTe7r2pkSYLWfgf0WghIgMdbramCye5Afqyc+QC6GBdSjl6KJYAGPOdS8/lkTnL3Z9UV803E5hn8u9hKepJGY4TsjBJ7+IqJOUCaiNSwj2OjQDJSIkF2ekH/1znT5mcQUeimCr+Lat7sw5RCJpo/2siOQvOv0fvjditLNd3f4+W6PD1Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6xwhN7ILK5TZEyB/udEOv1nAt3q5qxIyCxsPggrW2I=;
 b=bvYVFGWiNNEwShMvEcJJmkIUe1PXPG4Gs/iGzw6Ru3tjt6/HXuu9uzfUlJO8pmrgBCpdGBKHREpYt1nXthjdiTA5ccGbptI63o84oEIoQhG4q1hAON+B/jDxoXTVsj776fyh3aH0byT8iMR35XOxJhfA2a140NdoC1othfKlMuBIQxa0IY/7Y1KR3+nSiQTlYUPf3e4w1MkjeOQHvmF4Ioe/rXNgeuPFm8ly9OfXttBIBd9rWZx728zQbqOnrN13KRr77dppHyYRsUb5yqgs/S0QrxkCrwRwarRwL/mp0qcJoEeMYX86npB0K56NEZClAn0zerLQ2SblCBPIx9HGqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6xwhN7ILK5TZEyB/udEOv1nAt3q5qxIyCxsPggrW2I=;
 b=Sivpzn1y9Ce8mr7gZlUGAOmqVIKTsVKDdim/TnPszfOO4jsiskTPKhDPRu0DlqOZ6+vUu4fIYJG5Yp9oKoSYqX0oSz+7cQmIXgC6GAOSPt6/FLNcLJzRzzSwQNmWtX5k7vzZPMMHudeB4oFzap59G5n9PWo19sjCX3nWcfi134s=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MN2PR10MB4173.namprd10.prod.outlook.com (2603:10b6:208:1d1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 2 May
 2025 09:31:49 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8699.022; Fri, 2 May 2025
 09:31:48 +0000
Message-ID: <95dbb7e5-c2aa-4114-bdb9-9d9ea53653f0@oracle.com>
Date: Fri, 2 May 2025 10:31:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] libbpf: improve BTF dedup handling of
 "identical" BTF types
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
References: <20250501235231.1339822-1-andrii@kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20250501235231.1339822-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0202.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::8) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MN2PR10MB4173:EE_
X-MS-Office365-Filtering-Correlation-Id: 262b8529-30bb-4014-c598-08dd895c29c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NG81RDZsdXMrZUdsVFFFMlpCbG1aemJJZWhjOFA4WHBNTXdsMFpURUlLeVNr?=
 =?utf-8?B?NWZTNVU2WldXWGpvOFZEZ2xJSXBrWFZRNXBzOE45dFdVdXl0UEpWUS84Vy9M?=
 =?utf-8?B?UjNvWUtPTGNneVVTWGQ1ajAxOW5TSW8wRWVOdWJRVjJvaUZ5Y0R0MFgzZmkw?=
 =?utf-8?B?VDlzWHMzMnRYUGgzc3pxSGluS3V6Tk5GblBkVWJHajV6L1lVN3NteTc1TGNj?=
 =?utf-8?B?WUEvNmJYR2R6MW9HKzZQTjhJVTNMcHUrQ3UxaWhJV1JzOTRta2FwcFozQ0cy?=
 =?utf-8?B?L29Dd29UZWh6WmlxQUtseFJlYktqWGlhNW1BOUM1UGwwWFpweXJnaU5YVXZO?=
 =?utf-8?B?bEQwVEI2KzVJTVZMR3hqUENtOWZMV0RmVTNhd2ZVWjJhdzhFQnBKdnd2ZXly?=
 =?utf-8?B?dG9YdVZmS25pc2gxUUxSNTYzRUNYZEpTNkJ2aURJYXNWcm45TXFkMjFNNTRL?=
 =?utf-8?B?QjNQc01ncVNBWFV3UDUyK3Z3WENhZzBaV1JEQ0w3UUk4L0p1QmswWmJKWEhY?=
 =?utf-8?B?MC94NW16K1N1aVpCRlhwMW1uTlAwNXk1dGVndnB6b2VNSEQybWtEUG1uZmNa?=
 =?utf-8?B?K2hGOEhMd3VIVG50MzliOG1GWEkxT1VJYXJ5YkFxT0hPNk5Zam1PaVMrck5J?=
 =?utf-8?B?V0pORUkzU2NwclJNWXZhQ2VGNmZEVUtqdmhhRlNRaWpBbFVvWWdqek8wYmhr?=
 =?utf-8?B?RHdKd2k5QmpmRUFWL1JiVjRJcGZ6ZTc1ekxBcS92SUM4NGp4NWVOL0dTNnZS?=
 =?utf-8?B?UUFDTTNFSVBkZ3RYSzBVN21Yck8yRlVlOFVJQ1liVUhwb3BsY3lFYWJxdVpx?=
 =?utf-8?B?a1ZXcGpHZ2l5cG1FclFneGhkSjB5T256WXFtaHFKU2VpWEt2QUxzajB6WCsv?=
 =?utf-8?B?TUpLb3dxcHlMcGZxMVpDZUlUVkFQa2NKbWFLdGhKZWJ1WDl1ajFrNTZaSzda?=
 =?utf-8?B?OXRrT1VUOFhLRWhPTWM1Nk9xWTVjdE8rQzNKQUFIQ2lETjM2RlVTZkdDVlgw?=
 =?utf-8?B?ZU13b1A0bnZUWTRBOHZvd2NpOVVCTVdESnEzM1U1NzVBR0xwaXhhNis2dlV5?=
 =?utf-8?B?c0JCcEg5VUs4NWptNFV1MGU5YWVtWm8zQ1c4RUZWREpMS1NiZ2ZaVDQ5aWZI?=
 =?utf-8?B?K01mZGJSZXNITThIeXV2OEo1Tyt3YjRmeTE4Q3ZScXk4NzFiOUdBSkdQODQz?=
 =?utf-8?B?UlNwckhHeS9JNklBQ0pEdFZlY21TZU9DM3VSSlZEcDI0SlVoNlhiVlBSdnYy?=
 =?utf-8?B?WGZVZFJBV3hGd1MxK1lzUGtCMElRbDVFdnpyZXBvMm15ajdES2pqYmZTL04x?=
 =?utf-8?B?ME51ME5PeG0rQVJ3QzdibHVKbTZJblJtUWFsKzFFZnRmZVNKcHZGZzg0cjVS?=
 =?utf-8?B?dmNvSWZnRHRRVlpzb1FNcWRtaGNrMlRLc1RhOCs3WjNMZktxUGU2b2FncjFY?=
 =?utf-8?B?cXZuL3JXd2E0SGlkM2ZyZXZ0eFlvS21CUzRzbGJneUM2Y2MrMW1VL1puaXU4?=
 =?utf-8?B?VkQxZTBmdjFCSW5DUmZNTkJJMFUrQUc5TmFIbmoweE1TUHcvMnBObFpEeDJo?=
 =?utf-8?B?YlljSmYwSUlkOWJDeHJkRTdTZWJtYWovOWU5WmZKdjEvU1lLWlhkdU1OYjZD?=
 =?utf-8?B?Z0FxU0xPTDdXMWR4YnhQVUQyNnd5bDdxRllWMGtZZlBhWUpWMmtCaXRzMWJG?=
 =?utf-8?B?NFJURDllWlhKclJDZDNpRldWV0tTOExUU3NvakMxcGw2V2VuSGo5VkNXeUtk?=
 =?utf-8?B?K0ZkMHRpbTY4Z1dRU0pISnFYL0ZuSitwMm5yOFdVU3RrSUp0dWk4MnlDbGla?=
 =?utf-8?B?SUVoWGZzWTJBaU9CQUc5NnFPWTJrczVSREtsaFdidUVhek9uUGxuTkhBRTdR?=
 =?utf-8?B?cmhsOW1oVlFiUmZicmRXZERpUkpTb0dMQm85NEJHaVlFN0xpL2RZUldJZ0Jj?=
 =?utf-8?Q?lgsjC9PuLkg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkluNVVOUWV6cmpEQThEY3JjZ0V2VnRZZURZRmhBRlZXQUVHUm9WNEdmOGZL?=
 =?utf-8?B?SzVoQXpvT1VwWHZMV01rY0tzLzI5MUlXTHR2SWZmcDZlakg2VWlaRkNkTlhT?=
 =?utf-8?B?SjdUUkNFODl0dWtrMDBQMUJUTU00UG5XVDhpRTJYRG05L0FhN2FFVWdGT3Ur?=
 =?utf-8?B?dEVmTEw5RWxQMFFzWXdNUS81U3d4WkpjS2U3ZXZONGd2RlQ3WTZJTktmcmpi?=
 =?utf-8?B?a3Blc1d3UWZ5SWFheDRsSHlyVHJibFZTMWVvRjZqUjhtY3k0WUdRdzNXZFdH?=
 =?utf-8?B?SE1iRDM2SVFtWXlLWlRMSUFXU2RsNHd5d2ZXYUg2RHJLbEJjZk1JYzFNcjNr?=
 =?utf-8?B?VkRSY2VWcHJ1T0xxM0Rod2JCd0VmbVJMcjU1OTFDZmkyZ3pRbjJlYWp5dHNR?=
 =?utf-8?B?UUg5bmdta1FPTVgzbW8rc0pNa2h6K1pDSUlHWEZJcndibWFhWnpFTVFHRmFx?=
 =?utf-8?B?S3BIUVVUT0NVeDBrU2lYM1VoT2FpOGxZVHdjUEczcTBPOFVuUkN5KzNwcU5v?=
 =?utf-8?B?ZVhrUUhYdEZVY3hyRkU1TU1HNFhYM24zdURHVmhyVWp6T0ZnRTcrbkU3NlhC?=
 =?utf-8?B?Nmx1NjV0a3JReDIwTzlVd3BvRDdSeUpjLzRGK0tSeXVnWFNaR2RSc3VBL2dK?=
 =?utf-8?B?MFh6QnJIRnFTajQ1SXovNEw3RWt6ZWZwUDdpS1owNVFHV2djSFQxRHdEVTNR?=
 =?utf-8?B?MG1LNlVPWnowRlMrTmdqMm1XVHJZdlJyNk8rVHZIVDVPb1lObFZrM0lWSXJx?=
 =?utf-8?B?SytvMnJwaFM5LytKYW9xYTRkT2c1MkgyZ01vRkxmMGprWHFDMTBQeXBSN1do?=
 =?utf-8?B?TElPVUR1QTVJT05jSnFVallDU2lvZnZEdUZlWFRyQlhnc1dLd1k3V0VUeVVO?=
 =?utf-8?B?L201d2pLZHN4U0p6Mnpxby9kVTBBSWZzUnF0NW9JSzcwMWdoTndsc3U1cXFJ?=
 =?utf-8?B?S2l4R2Znd0hFM0huZ3RPUUI5dEZEamgwRXFFM1Z1R3pVS253T3JxUHlwVFRY?=
 =?utf-8?B?TkFLTFpraFlrL05xZDlPTnpIWk1oN0krRUFyL0ZDZFIvL1JPYkFNTjJpQ3dt?=
 =?utf-8?B?aWUvcmZXRS8wSnRnZXdSSUlpa29EWEJBS3NwSzlQWHE5dEFnUXVKSm5tZjlo?=
 =?utf-8?B?USt1Mjk2Nm5RUG4xV2xuM1FWdC9JOGNiSGxZanYvRmRRKzJOQURFNVpJZ09k?=
 =?utf-8?B?d1RIc1lVN2svY0ZsOE5yd3hjRWdXOTg5czlRN2ZiOVRQemtOTUo1UXRqT0ZX?=
 =?utf-8?B?V1hwa3JYL2VHbjNScjdnSG1uK2JhYUhPbXFsR3ZpUGZkWjNqc3d2djhHOXlQ?=
 =?utf-8?B?SGRFK0VOTndSdkl3blJZVGlWelpiL1dXTFdTVzJ0V0dlaWljNWFxRG9vcklM?=
 =?utf-8?B?bEE2WFg4YzZSVzZmR1NxeGtUWWVZQkNEZU1CKzFaNmlDbzkrY2dIaGFEbFZJ?=
 =?utf-8?B?UWYrTFhpSEdzZUNTTkxaRnhreklrWFBmZEV4RnlHait6QlVKUTVaVFlJaFUz?=
 =?utf-8?B?NEtaTnpMMTFCK1BDeGY1aWROeWppVHRZTUE5YUswdU9QUkt3QTQxbHkybHc2?=
 =?utf-8?B?dTNCVTNCWVozUnErbWFvelFNa0J6K2xCWmVrRnlXU0ZQWFZBK21qRy9iR2hB?=
 =?utf-8?B?VHFRaHJyZGs2WWQ0MWZzQ0Rja05LUkhjRnl0OFRFLzRJQlhCbVNJaTM3Ui93?=
 =?utf-8?B?YVVrcmNLb0FZYlYzRkNHRGhTYmxTNVhhNEZMOUcvTWtWNUh1dTVVY09RTHhn?=
 =?utf-8?B?bnA1N2VVVG52QTVGVkFwTi9Edm1rOHkyVitYWXlnOWNSaDEwK1dlU3c5Y0dI?=
 =?utf-8?B?TFlDVFZoVlB4Tmcxd09ZMmpja2VWRjBTWmlGdHdXc083U3ZVL1kvei92UkFT?=
 =?utf-8?B?ZldkWHNSNm5EL3YwbTZXM2RxbitxNG5uVlRaT04wSkVBMGhZNXR1UEptWmI2?=
 =?utf-8?B?UWE5UFUzQTF4a2RGQTg1VEUxSWtJK3dLN1FDR1lTaHM4ai9kUm94MVlTUlZa?=
 =?utf-8?B?cG1ydDV3UC9HT2tPTmlxVjZOemNpZ0dlZFlQcm9uUFFsZXY4WE9ReWs1U1Jk?=
 =?utf-8?B?ajROcTJSK0xvSC9rVjFMWURDcmVNYnd1cS9ZdDNrRjRGNW16ZFFRT1pRQjVW?=
 =?utf-8?B?eEZzclp1bU5rb2s4eE80OFg0K2lVTExCUHQ4R3cvRVIralNDQ2hzMjNoZ2xa?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5Nk8gYjHWbPc8EY4oLDe8oUVHFflWzYM//WWRLU5bbqR7q46XDu+0++1hH9onMA4ddRtDwVt8JxHvnANX1SJHBKjwff5OFgBnt9Qq/kZcWmntugq5qnKVBTMpHVi4jkOIjL28dP52gYEnOY9aJjga2skN7WeZeK8YO/n+eIlug5SUsKUy2TMacxMKhCE3MnjI+xNQn+rNF2jOdEGqfDys9HCCvLHEKvflkqkYDfg/zRKgrB2d0STf2RvpVqBtJcWgUlKKLm6WUzNOzmy/RRF+JyFGcx2NRcffy/MODUdLQ6qbNhXV/zSkqGNCSD+QIiyxj9x8bV+Hqtz4UdHA3q1reqCqDAgyx+2PXzzqIveUM155QQdqHBMAv6DulsCG8ff0KmCSxArjaJ8MqCP09lkERnLfXCL7CcSwl4nbwNLneGS76OROxQ83yTGAC01qvO66+vsZe5bWymxJXAuUSy3tUnBEvIQt9lVwLaZpLJwNoVlCkkM9dMnrBr9uvRKAuoO3sFcRCFo2RDmt5PA9jjgQOkbjUc2VmJSYPsR8g+Ftsj3REra+0lXKomSUY798L14Z5yS9wD9UyM4VxBx7rxQHbaj4+hn8I3l3sNuvQTev4Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 262b8529-30bb-4014-c598-08dd895c29c7
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 09:31:48.8546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4FOgMFYvnvHs1VtNafFhsWAXi74RTKuc7nPH1Zfv9jJMpyGSoZhdWblEyDkPS/1Y3qWJYNd1Uh5G4RnFQiqv5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4173
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505020074
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA3NCBTYWx0ZWRfX3H0z5lCKrABv fXwkLzGRVq3/T/mbeXrEp161W5A7BIQGhRVLuawkzNOOh1NsZT4Iwi7g0auMurM+kvUstydYpUI JnfL3xPCfvumWSsytQcwOSD9ylriuBOFqc16zd8mQwXwQH+IxWDrCwY2ETvd3VJNsJ34dNZTH+z
 cMjOHQG2rODYc+PnKfYmoXeyr+x/P8GVapyHv6Gf/RBOyxK7Ys8X2m0rlh3uxKOTk4hWAIbWGvE Z3ugniZxLkU+SaTDXHXzi9KuERfVhIshvhOReqdYdKBU3FLJy7Rh8gi98+kP4nHAdYCJqVM8IOl f/SDs9oh7YBYhE01EAnOWm9y2rN2hzPfNXRv7bts8R3M+VocxRy1JM2OpMzio3GK/3kXouBsDBU
 prjNAUaNgoL8zgP5FIRY2IgTeFFflYlZ9+0bNtPv9CVClaai/YWL0xmb9lNVVvVQb14DIL7W
X-Proofpoint-GUID: gq4zSIfJBK5moVyYktCBaKVbpPEbq5Wh
X-Authority-Analysis: v=2.4 cv=A5VsP7WG c=1 sm=1 tr=0 ts=68149108 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=gkhhXHu3wlBeOMmVDRgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: gq4zSIfJBK5moVyYktCBaKVbpPEbq5Wh

On 02/05/2025 00:52, Andrii Nakryiko wrote:
> BTF dedup has a strong assumption that compiler with deduplicate identical
> types within any given compilation unit (i.e., .c file). This property
> is used when establishing equilvalence of two subgraphs of types.
> 
> Unfortunately, this property doesn't always holds in practice. We've
> seen cases of having truly identical structs, unions, array definitions,
> and, most recently, even pointers to the same type being duplicated
> within CU.
> 
> Previously, we mitigated this on a case-by-case basis, adding a few
> simple heuristics for validating that two BTF types (having two
> different type IDs) are structurally the same. But this approach scales
> poorly, and we can have more weird cases come up in the future.
> 
> So let's take a half-step back, and implement a bit more generic
> structural equivalence check, recursively. We still limit it to
> reasonable depth to avoid long reference loops. Depth-wise limiting of
> potentially cyclical graph isn't great, but as I mentioned below doesn't
> seem to be detrimental performance-wise. We can always improve this in
> the future with per-type visited markers, if necessary.
> 
> Performance-wise this doesn't seem too affect vmlinux BTF dedup, which
> makes sense because this logic kicks in not so frequently and only if we
> already established a canonical candidate type match, but suddenly find
> a different (but probably identical) type.
> 
> On the other hand, this seems to help to reduce duplication across many
> kernel modules. In my local test, I had 639 kernel module built. Overall
> .BTF sections size goes down from 41MB bytes down to 5MB (!), which is
> pretty impressive for such a straightforward piece of logic added. But
> it would be nice to validate independently just in case my bash and
> Python-fu is broken.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Looks great!

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

Should have some numbers on the module size differences with this change
by Monday, had to dash before my build completed.

> ---
>  tools/lib/bpf/btf.c | 137 ++++++++++++++++++++++++++++----------------
>  1 file changed, 89 insertions(+), 48 deletions(-)
> 
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index b7513d4cce55..f18d7e6a453c 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -4356,59 +4356,109 @@ static inline __u16 btf_fwd_kind(struct btf_type *t)
>  	return btf_kflag(t) ? BTF_KIND_UNION : BTF_KIND_STRUCT;
>  }
>  
> -/* Check if given two types are identical ARRAY definitions */
> -static bool btf_dedup_identical_arrays(struct btf_dedup *d, __u32 id1, __u32 id2)
> +static bool btf_dedup_identical_types(struct btf_dedup *d, __u32 id1, __u32 id2, int depth)
>  {
>  	struct btf_type *t1, *t2;
> +	int k1, k2;
> +recur:
> +	if (depth <= 0)
> +		return false;
>  
>  	t1 = btf_type_by_id(d->btf, id1);
>  	t2 = btf_type_by_id(d->btf, id2);
> -	if (!btf_is_array(t1) || !btf_is_array(t2))
> +
> +	k1 = btf_kind(t1);
> +	k2 = btf_kind(t2);
> +	if (k1 != k2)
>  		return false;
>  
> -	return btf_equal_array(t1, t2);
> -}
> +	switch (k1) {
> +	case BTF_KIND_UNKN: /* VOID */
> +		return true;
> +	case BTF_KIND_INT:
> +		return btf_equal_int_tag(t1, t2);
> +	case BTF_KIND_ENUM:
> +	case BTF_KIND_ENUM64:
> +		return btf_compat_enum(t1, t2);
> +	case BTF_KIND_FWD:
> +	case BTF_KIND_FLOAT:
> +		return btf_equal_common(t1, t2);
> +	case BTF_KIND_CONST:
> +	case BTF_KIND_VOLATILE:
> +	case BTF_KIND_RESTRICT:
> +	case BTF_KIND_PTR:
> +	case BTF_KIND_TYPEDEF:
> +	case BTF_KIND_FUNC:
> +	case BTF_KIND_TYPE_TAG:
> +		if (t1->info != t2->info || t1->name_off != t2->name_off)
> +			return false;
> +		id1 = t1->type;> +		id2 = t2->type;
> +		goto recur;
> +	case BTF_KIND_ARRAY: {
> +		struct btf_array *a1, *a2;
>  
> -/* Check if given two types are identical STRUCT/UNION definitions */
> -static bool btf_dedup_identical_structs(struct btf_dedup *d, __u32 id1, __u32 id2)
> -{
> -	const struct btf_member *m1, *m2;
> -	struct btf_type *t1, *t2;
> -	int n, i;
> +		if (!btf_compat_array(t1, t2))
> +			return false;
>  
> -	t1 = btf_type_by_id(d->btf, id1);
> -	t2 = btf_type_by_id(d->btf, id2);
> +		a1 = btf_array(t1);
> +		a2 = btf_array(t1);
>  
> -	if (!btf_is_composite(t1) || btf_kind(t1) != btf_kind(t2))
> -		return false;
> +		if (a1->index_type != a2->index_type &&
> +		    !btf_dedup_identical_types(d, a1->index_type, a2->index_type, depth - 1))
> +			return false;
>  
> -	if (!btf_shallow_equal_struct(t1, t2))
> -		return false;
> +		if (a1->type != a2->type &&
> +		    !btf_dedup_identical_types(d, a1->type, a2->type, depth - 1))
> +			return false;
>  
> -	m1 = btf_members(t1);
> -	m2 = btf_members(t2);
> -	for (i = 0, n = btf_vlen(t1); i < n; i++, m1++, m2++) {
> -		if (m1->type != m2->type &&
> -		    !btf_dedup_identical_arrays(d, m1->type, m2->type) &&
> -		    !btf_dedup_identical_structs(d, m1->type, m2->type))
> +		return true;
> +	}
> +	case BTF_KIND_STRUCT:
> +	case BTF_KIND_UNION: {
> +		const struct btf_member *m1, *m2;
> +		int i, n;
> +
> +		if (!btf_shallow_equal_struct(t1, t2))
>  			return false;
> +
> +		m1 = btf_members(t1);
> +		m2 = btf_members(t2);
> +		for (i = 0, n = btf_vlen(t1); i < n; i++, m1++, m2++) {
> +			if (m1->type == m2->type)
> +				continue;
> +			if (!btf_dedup_identical_types(d, m1->type, m2->type, depth - 1))
> +				return false;
> +		}
> +		return true;
>  	}
> -	return true;
> -}
> +	case BTF_KIND_FUNC_PROTO: {
> +		const struct btf_param *p1, *p2;
> +		int i, n;
>  
> -static bool btf_dedup_identical_ptrs(struct btf_dedup *d, __u32 id1, __u32 id2)
> -{
> -	struct btf_type *t1, *t2;
> +		if (!btf_compat_fnproto(t1, t2))
> +			return false;
>  
> -	t1 = btf_type_by_id(d->btf, id1);
> -	t2 = btf_type_by_id(d->btf, id2);
> +		if (t1->type != t2->type &&
> +		    !btf_dedup_identical_types(d, t1->type, t2->type, depth - 1))
> +			return false;
>  
> -	if (!btf_is_ptr(t1) || !btf_is_ptr(t2))
> +		p1 = btf_params(t1);
> +		p2 = btf_params(t2);
> +		for (i = 0, n = btf_vlen(t1); i < n; i++, p1++, p2++) {
> +			if (p1->type == p2->type)
> +				continue;
> +			if (!btf_dedup_identical_types(d, p1->type, p2->type, depth - 1))
> +				return false;
> +		}
> +		return true;
> +	}
> +	default:
>  		return false;
> -
> -	return t1->type == t2->type;
> +	}
>  }
>  
> +
>  /*
>   * Check equivalence of BTF type graph formed by candidate struct/union (we'll
>   * call it "candidate graph" in this description for brevity) to a type graph
> @@ -4527,22 +4577,13 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
>  		 * different fields within the *same* struct. This breaks type
>  		 * equivalence check, which makes an assumption that candidate
>  		 * types sub-graph has a consistent and deduped-by-compiler
> -		 * types within a single CU. So work around that by explicitly
> -		 * allowing identical array types here.
> +		 * types within a single CU. And similar situation can happen
> +		 * with struct/union sometimes, and event with pointers.
> +		 * So accommodate cases like this doing a structural
> +		 * comparison recursively, but avoiding being stuck in endless
> +		 * loops by limiting the depth up to which we check.
>  		 */
> -		if (btf_dedup_identical_arrays(d, hypot_type_id, cand_id))
> -			return 1;
> -		/* It turns out that similar situation can happen with
> -		 * struct/union sometimes, sigh... Handle the case where
> -		 * structs/unions are exactly the same, down to the referenced
> -		 * type IDs. Anything more complicated (e.g., if referenced
> -		 * types are different, but equivalent) is *way more*
> -		 * complicated and requires a many-to-many equivalence mapping.
> -		 */
> -		if (btf_dedup_identical_structs(d, hypot_type_id, cand_id))
> -			return 1;
> -		/* A similar case is again observed for PTRs. */
> -		if (btf_dedup_identical_ptrs(d, hypot_type_id, cand_id))
> +		if (btf_dedup_identical_types(d, hypot_type_id, cand_id, 16))
>  			return 1;
>  		return 0;
>  	}


