Return-Path: <bpf+bounces-31042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA3E8D6678
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 18:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5801C23CBD
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 16:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CF7172777;
	Fri, 31 May 2024 16:13:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E85158DD3
	for <bpf@vger.kernel.org>; Fri, 31 May 2024 16:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717172033; cv=fail; b=GtTyg/9hYIgFb46u1SRT8F9uMtwD2uvREqMktqy6SQbSUaUCGbIpsIOeXnrBFLd26tWQv/eJ40o3n7mY770pBdMwsU9m/ggtcB9Ewzw77M8PYN5DH9u+SdTj4oRGlhfhfCkt+nP5U6TTstD4asS2w6ichO5F6Jt7XU1HFwoC/4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717172033; c=relaxed/simple;
	bh=IGUtX0SasvWNdEPv0uTXdizx/yVyKs+mTYzY+mwE9jo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QLvkSIl87OSoKEhEQ9YqNBBoKvJAfaN9hDh2kSRApPurNIbVopXZKGMZaLMTJ6IrgnACUdb3qQOl017ruLC7Ugr9h+3h6tixprgYT05cIbOXeQ37q/zGNAiey62qnoyL7u4IeBk1p83K2cpTJ+KlmeKSiDKf0ozJXBIKf6kpaQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44V9VUi3002656;
	Fri, 31 May 2024 16:13:25 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3D5T+bOrdiybsFvodkk+DZ7HxAckeeqxrRmqmY/NKzw6A=3D;_b?=
 =?UTF-8?Q?=3DdS6hD9Qf3nDlxUoqFr5XX74Oy3djuVe/qlqJIrGaGbz3U77tnkwW+Gpdn6hr?=
 =?UTF-8?Q?6A6+hn+u_PV30hrsYZAKw0qQXlOpX+g20TGxD+ZxKynmcvgTjHZOP3iruvYp7Lh?=
 =?UTF-8?Q?VCPhjFe2GsM1Pw_x+/sJrq31ccgE+Owl8G2yF/usNjo2A/t+SUTZh1bDgjCnjf1?=
 =?UTF-8?Q?sCXza9lxfNkQ2RQouqV4_mt/6jDWSEKI6D5GBt4lmi5dhojF06xGbENKFVYdvDn?=
 =?UTF-8?Q?yczusj+NGCIyrzDWCeAMnBOt1d_K6oWDlbS9cEiWquWK7VraqrlWyxbDjWfhfzx?=
 =?UTF-8?Q?vRjxFeHXxYdSR8MDm0S6A9g2wW10lrcm_Qg=3D=3D_?=
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8hubk01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 16:13:24 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44VFFwdm010749;
	Fri, 31 May 2024 16:13:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc5124xt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 16:13:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7U/AnoP3sbMTLQeoywpwuSddTrpFyntLzFcnWon1fdjmC9aYG7qtI+fOubALe/rZQ+b/W4TcVJN+QIVt0aCgxQxerfKPqHirHOQDkSQcwdieC69qmNp3u12gWpAiRVzvsahWvXnEkpYlBSsU8ztgbdD64XvLo1xN6HpKDjzpGqYdNQxzR8HTb+dD9tCv7lMTsTI7ppbfcKQ0A8flteu9+cB46dMJ/TWBx8LoWgy7mp3wZXrtx65nLNAQgwmu/k/HYeht3OpZ7j2q9jcKmo9OhFI9Pii55DyjaTMR5sLrnf81sbJ9CXrEELkWMtGpeXzv1iT084qrPhtoZ72XJyAsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5T+bOrdiybsFvodkk+DZ7HxAckeeqxrRmqmY/NKzw6A=;
 b=YvQXU3lPypzXkaGP605L2VsSRuvp4SZrc1FtTxklJCLcOjxaDnc+Qy24IzqgHt+Yy6ofYnylSPfXJvSnhZh/i+nfpcYO/zmkarHUGn0q5evFJJ0zR3Fu4YET3c/B+P9jnlAS8eOWhUlyjTUJINqoMaBjKGKvUaoCUD6vRK3H/2F63kSygK1tA2ZdoTml0B1sTN38a0Pieohg70V+vKT4wC5n1qtcxt1p+1QnnvD5cpzZSYDFpsCcYB0Il6ElH1B0EmRzzgT+PR7KSoB5M0NRhum+gY6h2FhucQsebHYOrxjY0sEavO88nKlHnT/vD7mT2g2oMtkHxK1MAK8AVjg/3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5T+bOrdiybsFvodkk+DZ7HxAckeeqxrRmqmY/NKzw6A=;
 b=OE8aCUgCrTd4KnLA/BZEg6VuuXnlC7e/X1/NZMBCxn1ZP6kdkHLIFqSehscFI6had40YlA+KVN+WeXf5Y8AZ8DxPCm7L+iB24MDIENUUXMxgnyjqVujujUi1+1ioauD5TvVCvmo1Ehe2VROvSJ7vcMXIibvFiACzszISJcvrHUY=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH7PR10MB6311.namprd10.prod.outlook.com (2603:10b6:510:1b2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 16:13:18 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 16:13:18 +0000
Message-ID: <2b88e522-a8ae-4999-8a69-380da719edef@oracle.com>
Date: Fri, 31 May 2024 17:13:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 bpf-next 8/9] libbpf,bpf: share BTF relocate-related
 code with kernel
To: Eduard Zingerman <eddyz87@gmail.com>, andrii@kernel.org, jolsa@kernel.org,
        acme@redhat.com, quentin@isovalent.com
Cc: mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        houtao1@huawei.com, bpf@vger.kernel.org, masahiroy@kernel.org,
        mcgrof@kernel.org, nathan@kernel.org
References: <20240528122408.3154936-1-alan.maguire@oracle.com>
 <20240528122408.3154936-9-alan.maguire@oracle.com>
 <13fd222ca9f31055b35c55b4ebd2b8b578b741b1.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <13fd222ca9f31055b35c55b4ebd2b8b578b741b1.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0003.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::15) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH7PR10MB6311:EE_
X-MS-Office365-Filtering-Correlation-Id: 0802adc2-9a74-4937-7701-08dc818c9547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bCtJTkVRR2ZsWExCaGtuNFE3K0IzWnVlOVVEamdnRUV1ZWpvL2laOW4yVnNz?=
 =?utf-8?B?UUZUVk12T1JFWjE1N2V6bDFjeXd0N3JoMFhGWldnRHdVV1JIYVhudE9kTHor?=
 =?utf-8?B?S3BIRHB6U0pKSzhQakpRVEdYR3BjRUREOE5seVVBZWFOS0drSVRQQms3NVd0?=
 =?utf-8?B?TWhBeEgyZE8xbWZleE1oQWgzZ0dvOXppdlZlbk9yV0RFcms3cW9QSTRFYVpk?=
 =?utf-8?B?ZUlIMkRRSmF1VUdPUS9OZnpyQXZ4V1N6WXY3QkF1NFQzaWxVL08xT1FjaWdL?=
 =?utf-8?B?MURpOUl2cmw5MGp2Uk1PbG1UeHhKbVNjTkVXSDZ2R2Y2USt4V2o1TmlUTGcv?=
 =?utf-8?B?THY4SFY3Z2ZBakFCRFFsUGFVTGhKSVk3MG9YNHFsSklZV09wcngrYnF2Ri9T?=
 =?utf-8?B?K2YyRXRqbDhDeHBNOEhFeDdoa3FNcG1sTEl4ZytkelF3RzhNZDZ0ZUVOYVds?=
 =?utf-8?B?KzRxY3ZDTEZXSndjK3dFb1QyTFRrSCtYL2RyMktNdGxEaTdNMExGTVo5K1Zj?=
 =?utf-8?B?Znhtb0FaY3lKU2VvejIwNjlwQTQwL1IvejZadXBlamJYK3dPZlgxWXZRV044?=
 =?utf-8?B?QjdSYWZzM3dRWkpIdjd0WWxTaHZwSHE0bHVKUEY0QlhWaVFlbEgvWXR0bHJZ?=
 =?utf-8?B?eWoraHNXSUVGdHV5R3RGbDZxdUFQbFhSYjNSY3hZWk8vNHJWSWVESW4zK1Jz?=
 =?utf-8?B?akNYREdmdFkxaEZMZE1iMTNobC81M2oyWHBsWjQ0NjcvL25GeTVIeVptOGRD?=
 =?utf-8?B?MkxHL3FUaTR0NWxiM3R5MGJIaUx4K2tCRU5RUW9LcjJteEYyL2tNaU5sV25S?=
 =?utf-8?B?d2RFa2pobVFuQW96akF3a3N2K0QxczJSdmxlUDJjNFVCbURGYlBLOG9Qek5l?=
 =?utf-8?B?WHRoZm1FVFlpL2RXNUllOUp5cCtERVFrdTNLWGkwQUt2OEtlSWx6Y0NWMWJO?=
 =?utf-8?B?alQ5Mzd3cGIzdU9seTFpUXRxV2VldVJDZ1hudFZqbU9ydjdjcmFkOWhvRysw?=
 =?utf-8?B?bUtMNUlCSGJmY09ocHhnVXhzZU55L3NNRkYrZmNpZ3djVjhaS3NzcHZPeFRl?=
 =?utf-8?B?SXdDOUViaGNGdS9tTHhPYmxPSm1IUTZKYVdFRm1IK1RGajlyVmlXVmJ3cHZC?=
 =?utf-8?B?Yy9HWkk1VWs2MWRncVVYamh4QmxkTHVPRnlQUjBkb3VYTzJyVzJJcWZkSlFY?=
 =?utf-8?B?VUlOUVBsOUQxaGhRZDRtMGFQZHE5S21HV2t2cDN6ZENObGFpMFpuS3Vuc0dJ?=
 =?utf-8?B?VDZLRjlINU90VjlSQTl1UHdkby81a1RIdnVqcHY3YU1ucDNWMmtQUkd4TWhM?=
 =?utf-8?B?MzFYU2xUREY5TUJySUhpbDFHdlVzZlpXOGRYUW1GTmpESkdQUUUvTklCN05a?=
 =?utf-8?B?bGo4eTBaZzRqRVh4SEtkUkM4QkQ4SG5jREhsM2FhNkNrTGVieWQ0emxRZGxN?=
 =?utf-8?B?TE1Db3lzSTl0VUhFcGhmc2RubE9WRnBZWnhESXFIb2FHaE51d2YyZit0RjJQ?=
 =?utf-8?B?ZGN3NlVXaWhyeCtPc0ZiNGZVNHphOUV5dFNRRTNYdEN6eDB6Y2dvWXNhRTJ6?=
 =?utf-8?B?Q0ZPdnB2UzhUcUd4OXhMaW9xSUtqZWhDVmJTL29WNXU1QVRhNWQ5YVJDanpE?=
 =?utf-8?B?SUlqMjl2OU1naW4wT2NHTzZHaldvZ1ZNMFQ0Z2FvSGpjeEo0L2s3aDJ0RXA0?=
 =?utf-8?B?Wk4za21oSUw5d1ZvTm1nbGI4T3ROK0FVeVFyVDlqQXViZTdpbzRpaFN3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NUNINTFnNzVLbHVHaXJCTmFrSVJXOGQ0b3dlMm54bEI3WXl2dEUySHpTVm5T?=
 =?utf-8?B?bFZjbW9DNlE4b3N4Wnp6MFV3M0JCWHFaN1VvSzVtRmZEUzh6YXZHcGtBaVll?=
 =?utf-8?B?R3Fob29TblUxOXprb2FlYjF0V3Z5SFM5VkdSaHdsWnRoR3JnbXJLZEVhNXp3?=
 =?utf-8?B?Zk9lYWMxcFF0T3F6aDZraS90QnZsQjFEZEd4a0ZydlAxdTR4Z0Yzc0tLczdI?=
 =?utf-8?B?UHI0b1dEUkpFNVlpdGRncDVINGtlM3JiZ3lyRG0wOWxWWVlZQjJrT1ZUODZY?=
 =?utf-8?B?YmZ0eGsyR1MyRmlHZWd1YjNhZEVWUnhxeFRqNWc3TTcvUHdIRDJjMDJBWVg5?=
 =?utf-8?B?ODF3bmY0M1dUR3VHUml5dmJ3czN5OGZlMXg5OU1hK21SN3R6aUljSnlyVDkw?=
 =?utf-8?B?eTRpMVlwODRNb05YQVVTQytDTDZVNTNnSzU5U1pCTk5aTHdMbm9qWGJSR1lN?=
 =?utf-8?B?WXR6ZjdxTk81dWZIT2RRU2gvWWFWOFZuVTl0OW5jWW9GdXprMkhuZml5ZWU3?=
 =?utf-8?B?SHlzRUpNSlNtZC8xTnRCeTRCOUluejFjdnJxMksyME1MclVwUm4wZC9qczJH?=
 =?utf-8?B?QXRZMHkwUHFnZzJDOGFVWmplWUtaM3phTi9uR3VhNTVkeUlBR1lwL0ljOWc4?=
 =?utf-8?B?c3JsaWhUOFk3QmsvREFESVpwWWJQT2N5ZVByOS93NmE0cnF0RlFHc2dqMVV3?=
 =?utf-8?B?ck9XMG9PNTFua29uRytLamw1ejRXelkxRHBQY3lxSlBlWlltUXhPZ1k4Rk51?=
 =?utf-8?B?cWcxNUxFRGllNm1Zd0QwbmY0NDRiMHA4ZlQ4c3YzUWhFeGtYcldtQy9TK1Mz?=
 =?utf-8?B?R3ZNMUFZL1J3RFJOb2VTdFhjbXJsM2VJZWlGbERCckh1YmIwVjhYYlFBYVlq?=
 =?utf-8?B?WExSVDVvcXR6azdGeHdBUk5WMnl0U1ZqdUx2bC9DMUU5RVhwaFhrMFdmWGYw?=
 =?utf-8?B?WEpoSzA4V09XZldlN0Y0U01ESktRcVR6MVhKeGwxL3JWcnBvSFdnN1NnVW5W?=
 =?utf-8?B?ZDJmUnNqRmtGMXZiT1pvb3ZsaVVFeXhCYk9QNS9WeC9wMHhCd0xCQUdCVDh2?=
 =?utf-8?B?Wkp3c0RHUEN0WWtwKzF6KzBwR3BzUHlYTFFVeTBUdUlTOGpJb0lGNmcxTEMr?=
 =?utf-8?B?eEgvNXU0VWlXMVJOWGlWREU3aTYzbUtjR2gyZ3BUZzVENkU2Z05qVk54eDZm?=
 =?utf-8?B?VlJlZTdUc3B4UW9QZU1pajRIaW9wME9NMW5GbkNMUndQdEdnTXRSaTk4NDU3?=
 =?utf-8?B?VnI0Ujd3UkhOTHJOSHpvOGRLSUs2SGhBbW5vWDFXMk1MeFlnRFdUa05xWC9L?=
 =?utf-8?B?QWlJTE5KcUF0elVETXJQa1Fsb01wK3BweVM2R3R3OUdGMWV2QXhzakpnamdr?=
 =?utf-8?B?bHhZekRBUk1OSkJZOXNvcUFyMmNNbXk1T25QaEtZV3BuM3VTc2RBWENNMFBW?=
 =?utf-8?B?b0RWcUxrSzRiS2RyeEROT0M0aXpYZkU5MHlNaE9GR0NrVzRHZmdOeitHSXFx?=
 =?utf-8?B?OGxRVjQxbzZyTHVvRC9ralA5elI3R1hsQ051ci9yK3NmU2xYaGxPQlFsVXNR?=
 =?utf-8?B?dkdEaXozTDhqMndjSGM0WVhia0N5LzZWeHRHamMxckpBVXdkZmVCVDRBNita?=
 =?utf-8?B?eko2MXIrNVlxRzJGVGcxUERTRjJGSk8xMkNWbkpGMjNkaCtwMDN3ZHVaSDRX?=
 =?utf-8?B?eFBaNEt1bDV2RjY5Vy9FODE1SWRwOHZ0bC9McXVQd3MzQU1wUHNMOVd5Q0E4?=
 =?utf-8?B?S2xDVlpMTmtTZy9Iei9NZHRFZ2F1dnNrN1N6ZEhxQVJPRjI0VDlsQ0JiSzIr?=
 =?utf-8?B?VHVZeHgxcDBld0FYWnNEN3F4SjFmM2pJNzNrZDIxUG94dUFGSlB6Z2JPQ3Vx?=
 =?utf-8?B?aGI4ZzZJOHE1dnZxM2w4OXRrRWpMVWlrdEpRY3lNVkk4S2wxZ3YyVFIwOGZq?=
 =?utf-8?B?cjlIM0s2dmdSYjM1YjdBV1pncmczYUI4ZXAyTlRkS055c3BJZTdSU3kwU0cx?=
 =?utf-8?B?VXV3OXlWSGdyQjBQQ1N6UlJNUkM3ZzgrRnBlZ2YvU3lpMFI1YlFNbUo4eGpw?=
 =?utf-8?B?NDJONFg1SnBEbUJmNnVteGxJWVEwK0pYWFUxNUF6alhUSStwSEt5NExzejAw?=
 =?utf-8?B?WVFpd3VBQko5aERteHpxSXU0WUE1azVGZ1pmM1htdys1RHo5RTdVbFlyS25n?=
 =?utf-8?Q?yxWCuf/Rg3C8Lhm+7PiBNRg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RJK+OGUrig4uBqpS00cEMEkFlz1Twyg/fAq4n7n/E5IMgIJH1+3dXaciitx/J0Fk9sKzWtjjECX5ZNJDjB3Hc2ozobE5UxnP4uWeoP7YANUNrkbLfUt5WSI8DSyHcswjFHdSwXbtHZxZuJ8nqgysV+jIeD+LxdBM6tQGdJamlLQTCYS4oHjAF25+fnIS6yFrVe/8s/+7VM09AfXtn/EPqVu0Ly2j8yHAD8qJMvdQbr/iJbVCG+fkBPXSCuA1hYM4jx1XJKr0Jwd9JKrm7G942/W/vRg2IYtlUeV82qM8a5neWf412GWUnn24kVviPzmqmO0/aClXKZQq0BEpMEvTQJnUdOTw0ptGoUahhKu9AefIim1GXj+D/MEV9tJqnQr4ly9KmRubJxGHoUgJ/jGD7TJTb1aMoYp7Kfh1BpPzD26eG73MUmDtX6QdWn6Q7Vo1gb8RozQvEcX/KnOKWQbEQxBZedt2Bg7JtuHE8mleik1LFULkmEP1ccPmAbJS7xv/5F4oX1snOtH4OHR6C85cewa/JeU+6BMktkB3fZ4Io32rvPb2lxcHdYthSH9luoWeT7ZqNfNt6HPUhuKepcA8LE9KdZumWi3rLxcJuRrDIYc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0802adc2-9a74-4937-7701-08dc818c9547
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:13:18.1454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 87Kx5LoBbW7aNuy/X63G01D0rbyBlOaruHwr/GvYqYPeHXR5djxfB1D2pEmrPy91DuPcusmt4fFL4tlAPQehLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6311
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_12,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405310122
X-Proofpoint-ORIG-GUID: QelUOD7yjx7FdHp3Kaf2BRQobmmIM-NG
X-Proofpoint-GUID: QelUOD7yjx7FdHp3Kaf2BRQobmmIM-NG

On 31/05/2024 10:34, Eduard Zingerman wrote:
> On Tue, 2024-05-28 at 13:24 +0100, Alan Maguire wrote:
>> Share relocation implementation with the kernel.  As part of this,
>> we also need the type/string visitation functions so add them to a
>> btf_common.c file that also gets shared with the kernel. Relocation
>> code in kernel and userspace is identical save for the impementation
>> of the reparenting of split BTF to the relocated base BTF and
>> retrieval of BTF header from "struct btf"; these small functions
>> need separate user-space and kernel implementations.
>>
>> One other wrinkle on the kernel side is we have to map .BTF.ids in
>> modules as they were generated with the type ids used at BTF encoding
>> time. btf_relocate() optionally returns an array mapping from old BTF
>> ids to relocated ids, so we use that to fix up these references where
>> needed for kfuncs.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
> 
> I think we also need a test or a few tests to verify that ID sets are
> converted correctly.
> 

We sort of get that implicitly since bpf_testmod.ko will have a
.BTF.base section, so its ID sets need to be relocated for the existing
tests to work correctly. I'm thinking something that makes use of a
bpf_iter_testmod_seq*() function while validating its BTF id > num base
types might work, or did you have something specific in mind? Thanks!

Alan

> Acked-by: Eduard Zingerman <eddyz87@gmail.com>

