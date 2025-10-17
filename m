Return-Path: <bpf+bounces-71202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED2CBE911D
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 15:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA81619C4C17
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 13:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD033570CC;
	Fri, 17 Oct 2025 13:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ctETU8Sz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Chy/WBh9"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA64E231C9F
	for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 13:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760709295; cv=fail; b=uBk0XoyubAvONn3sDEP1bXlBUDfd+Hn32dLm/AdB0sj7TnW1A8jeoKX8jRqRY95CKBOlFu01FL2Oeja+TUrFwxl32dnGvhd1pfmGicl/bD6g9vumIAkNeKpUE+AgbSp8pPDyUfgliAAzfffkr5c9UBUlffwjoBBfXhKheg37A/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760709295; c=relaxed/simple;
	bh=p1Z869deGMqdENBYBJfpz3iQKpS3CX9bOtUsoC7HjpA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NGM9o/ax7luJuKTxCUIJ0GqpiEW6LTzTiwXhzq4SvmTXcS5j5iDkyCje3fDVV3BMLDgJzgvJ0ATiqm9YL8s3oSybXiLtpPt0ciaRigeOCljUjrj/h8baLoSFFW/PRVy80VWxbfyUnQBgepBJLzhgmw5evTo+9lGWti7PA6BUMw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ctETU8Sz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Chy/WBh9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HCdaDD014027;
	Fri, 17 Oct 2025 13:54:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=vImSAwpY9b2PDIcXmBNl0HEx5i7jL7R+J+Vp/rX1e64=; b=
	ctETU8SzHRNjPfcGAbTS2wUN5DvDQmSimthfjl+1owQj38Uc/NuiwAMJQ9RKxm6+
	hCfH2Q4YTSzB9X0ekkSR4w3qQrzZbEdNxjtOSWVRbxJpOoMSbC1LpoKKjdPWNaO9
	JT25AG2NP35JRmOZfwIgfAPUsiUi7QDklJq6bDrPp02FxAuGwxOGhRPubEZpEEjk
	2qeK+qy/bVX0InAm6fWemmZj0rTehd1MOKkLWvrNfge8uIxSuwZjN4Cpk4IXYCjp
	4f5hbrB5tYNQLPrIAOY4bh8T5HwmE5BleuxkJqoPTNou+CK9PtkdbDU1ytZT02iP
	/SXxz3K8urKz/Wu29yxMNA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qf9c32xf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 13:54:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59HDgg69013656;
	Fri, 17 Oct 2025 13:54:29 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012063.outbound.protection.outlook.com [52.101.48.63])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpcv508-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 13:54:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNC48//B25/R9hKPBaXgo7JFXLQyR7Mmjs2XBm49V3h8EQiJrccnrEon/l0g+/o/3WWlm3ztKPjKI9r0JX8KIRzoZqpgqN4Vt++qcWdgr9/y5nionhAGDeTJk+C8U7RGj7HC+mhpC2UQzT30w9YBAOeNUIV8UoV3gaGDDAkL8eepxmbxMY4MUtu4gdu9Vo+k5VWJyIQ711QAWqhleoGJ4Nlr3YbJlx+TEAT+X0mwmXwLMi4YcKcIBgG0TgnzuQBSbVATahcWNFu5uvJdFr5F6WhqhNM02rZhi+bCzVBKbRTKfOhhCPW+fY4vL6ON8CA6fSxdgUwEpaCx5SlTs6Rp4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vImSAwpY9b2PDIcXmBNl0HEx5i7jL7R+J+Vp/rX1e64=;
 b=NUflwZAIsWu6KfU/OtbzlKAWjRiV4x5oWbHZB6rcsq7UnscK6X77UIbW4fvX6psLTgmn0akNiuwnKx+rQf6ua8W/4MrILiBKnJ4ZKsH2UXVQ6cA2ccFEl5zsJSTFgjHPUm7xTLVn/j/DwxDOZP/1noX4qMYobr4/DLqe2+8o0X1vl4YQ0KfshG5LzdELN7txq/CaRtbZvsI5vTpOu3MA0GiJLqSzCrQp57Ox0Grp7TOJZfjLK3aBZgjlMYVFp+vJAD+bxUkWtA5MUasKOGxEmt5fADl4uRQB9BSNNioeU5MxBrU3Bz5NCY3JlZuU00lxpfX48ksoSCr6iTk3X8Fmfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vImSAwpY9b2PDIcXmBNl0HEx5i7jL7R+J+Vp/rX1e64=;
 b=Chy/WBh9x7niePUObf2eOP9K3ighPkqEGtTK/V9xt5KVUZya7Vc5xLdmbiTkmrXMYryH/1rrKzUHnlJxhbmTJuHbn/vH8lU16XyMhKF9W9fEZLA7wWMMbG4Pw3uAVqS5qL6Bj8nftbcxnmswhENlisiIRj6hWgerIORTIFhYOwU=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 DS7PR10MB5927.namprd10.prod.outlook.com (2603:10b6:8:85::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.13; Fri, 17 Oct 2025 13:54:26 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 13:54:26 +0000
Message-ID: <bca00601-b45d-4977-8d54-20a97192029a@oracle.com>
Date: Fri, 17 Oct 2025 14:54:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 12/15] kbuild, module, bpf: Support
 CONFIG_DEBUG_INFO_BTF_EXTRA=m
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        david.faust@oracle.com, jose.marchesi@oracle.com, bpf@vger.kernel.org
References: <20251008173512.731801-1-alan.maguire@oracle.com>
 <20251008173512.731801-13-alan.maguire@oracle.com>
 <CAEf4BzaharR9cnR9Yd5Shoq8A6afJo0HW+N7cw3k9JhGZmqY4w@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzaharR9cnR9Yd5Shoq8A6afJo0HW+N7cw3k9JhGZmqY4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0234.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::18) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|DS7PR10MB5927:EE_
X-MS-Office365-Filtering-Correlation-Id: 42d4a667-b094-4837-cd61-08de0d84af11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGdjRFFLY2ZCWjltYmF5Z1NPODFxSW0rcXk0TWZhYUtGYmNLeDUxM1R0ajE3?=
 =?utf-8?B?SG1JcDVreE85eDR2OWJWSUpjK09hVE1lVklBUFBlS3F0Ym5hNEM5YUQ2cmhY?=
 =?utf-8?B?bkpDdWt0bnFqNW5CVXBKb1VvMnFnSFduYmwyMUhwNFNJMW93clhERnlUendQ?=
 =?utf-8?B?dDZtbHRNUWc0c0Q3WS9iSzNkRDRzaW1qNG55cW1lTy9DQ2hTekN2UlR3eEto?=
 =?utf-8?B?RVRGeUt4ZEU1SEY3SXkxVkE4eHhDalREWENSZkJmbnVEZnp2aXQ0MCtHdkdv?=
 =?utf-8?B?bjJ2eGdhdmtXN0k4U28vaENXeFRsYWZGcTB0Ti9LU0VmaGprRnhsZFZqZ2Fm?=
 =?utf-8?B?N2xLamNLVGVYVTZ2bFo1bWNTNmI4aTlkMXhlK2dtN01QK2cxSDRWRWQ2UWQv?=
 =?utf-8?B?VnordVVwU0dpWW8ybU9QbHVzbWJXZG04Q04yRnhHU2xKZkJBZmY3V05sRXk2?=
 =?utf-8?B?b0pHVTNSMHFWVHByTnhiMmJzcEJCcVhiT0lWc0VscHdUUHF2dnM1YmpsV3Ba?=
 =?utf-8?B?NUd4Vzg3U3BmQm10MUI5VGhiQjhYWmhGN29KZDFLYUYxd3hQUWRUcTVmYTFP?=
 =?utf-8?B?Zmd4cjJQb3luYjBHcFVGQ2ZJRFBidGtyZUd3V1hnMkM0TVNOcVo0RThKWlZC?=
 =?utf-8?B?KzFXUk1wYVdkNlYrQ2Fnb2kvbVRMQ2pXN29yazRla1gxTVo2VUozYUJEOFFR?=
 =?utf-8?B?Qk93ZkRuTDdCQzhrd3NJRmJscGN2aStBZGQzVTA1QUtYVEZkVmJRQ1RZanVD?=
 =?utf-8?B?NnhpbEdyWnBXVkpveXVqcVd6U1VuWEVmb0tOOGFIcWRXa0Urb3VHU3M4THhT?=
 =?utf-8?B?UVBBeGhJS3grNy8xZDZBQWdFdWR3U0UvZGF5Q2d6bVQrMlhwbTluK3Y0L3la?=
 =?utf-8?B?cjV4anJjblZ1MWZIQngvZ1J5aGY5Y21aM1FjVFg3UldhbzZkb0hrSjlPalBI?=
 =?utf-8?B?aUdSNWNGTTFKVmpRRGpsekkzY2hwdWtjMngwZnI1SGpIcE1XcSt0YjgzYzky?=
 =?utf-8?B?WnY1L0Z6S0YvdnI1MG56VEdDV3BoeEMrMm5hUTlVMytPNFRJWXVoTExJUzZa?=
 =?utf-8?B?TlBmS0VhK3JLTGZFUTQ1SDlBSzhpbTBwRkpMT1hlWEtBQjVBeEQ3eC95Nllr?=
 =?utf-8?B?NlFtWHdrc0lWdVpCM2RJcU1JczQ0Q1N2RFNvNlBHSVJrNkJsOUYvQ0VtUDRu?=
 =?utf-8?B?MHNkak9ZUTltN2VRTEFDNHR2dW1mMGtwU3pDYjhDNnBoQVNMc1o0QmRPMS92?=
 =?utf-8?B?bVlNc3cvSjZ5NFJndy9pRGtRL2djNXhMdEJXa3VvSEltRzh0YzJaSy90K2FL?=
 =?utf-8?B?SEM2aHlwZkRpeDJGcDdhSDYrcG5RQzNWMkVyemx3UVUwRWZEcFJLQ0VpU05a?=
 =?utf-8?B?T0ltaGhuNm9GKy80QkZNa3lKMlhDRUNoWmpWNjV1dWFIc3VRMERVdmx2Y3JM?=
 =?utf-8?B?UUhrUk4xM3VTaGRVeUg2a21lYzBmSzM5ZlNSYzVMOXRsc3NjMjZaL2pmc2Ft?=
 =?utf-8?B?TFRpeHYrQzBkTzYyK2wrRE5GSXBEamw1eFhlN2MrTDRnMFlmNkFreEFBUWxC?=
 =?utf-8?B?d01WbG9Rd3dQbVhGVzZOcFlPOEFqck1JcHhjLzkyRGQxaHRLd1E3U0QvbCts?=
 =?utf-8?B?KzZ3OFhzbkdBTmhwb0Yxdks4ZHZHNWk0aWdlaGozUHExREUyZi9mQXhYcmRM?=
 =?utf-8?B?MmJmUnpQQkduZW9aREwxS1FwMnRMWm12K2w1cmtQWkhvTDlwTS9Pd1RnWFlO?=
 =?utf-8?B?ZG1wV2hjdlAyaFN1SWJhZzNmcUpwT0VuUkJJV1YyNnFRc1dwa2JmNnEyK3BK?=
 =?utf-8?B?TFYwRUxZWjNmS290anQ0NzRzTG8rcWZvcVpKTktUSldmZmtsSUdELzRKY1hL?=
 =?utf-8?B?NytJVVh0L2NQUVdHQVR5MnFXcEJyZFJDajllcFFxTTRTSmY1WE4wU3pyUGtw?=
 =?utf-8?Q?eFZlZ1jDTDLNYa37QFdH7V1m2wmVH3+z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1Fib3FSRXNUOU1jQjdtMThKSG1KeElqaUZITkRIWEdSejd4djh0eUJOSDF4?=
 =?utf-8?B?WVBnYlpWbFJJOFJZenJyRG44aWRnc1E3eTN5TTQ4ZUZ2OGJrc1VybGltbXBo?=
 =?utf-8?B?ckRiWDVSbGdpaWY5S1ZuLzRCVHpieFJFY2ovMWwydmFEbTdVSWZycFg5Ulkr?=
 =?utf-8?B?RklxcytCR0tKbnEvcVNaVUFlVGFqaDdJMXN5MlduY3ZWeWVWMUxlanlhUFdJ?=
 =?utf-8?B?S2JQaFZJbWhGekQyMFo4cklxN2NFNzZVZGx4UUdSbW10dU9IVkZxMytiU1BL?=
 =?utf-8?B?c0c1SnU0d1FOanJtRlQ0YStmRGdqeE9YZnNhVWFKZzJIU3VsRXV3Z1gybDd3?=
 =?utf-8?B?bVZGUVA2b25OVEN6VlU5RXI4QjdZN1NlWTZsQVhXbzAzTDNJd0ZsU2Y3cnFm?=
 =?utf-8?B?eXE0RmlBTGR3VW9KZlB3eDNvV1lMc1dsakFHWG5VeWZSQ3dIb2krV1hVSzYr?=
 =?utf-8?B?bEdwNWRUTml6TXBiWDVRVVN3TWZab0ppbGlVSHYrQWIzaElVdzEvbk5La05V?=
 =?utf-8?B?QzA3eWVEZUhuR1dsYmprckR2TCtIeXZJdk4rNjhtaTFURWZaVTlrMU9wdWxl?=
 =?utf-8?B?Q0RIM0MvUTFKQUtacXc3Q3o5TEFuSkVHdW9kYk1yTWt5R21SeDRhbUYyTWRO?=
 =?utf-8?B?QkNGeDFkQUluc25raEN4dTVOdDAzS1ZEN3NYWEdBVXlwMWhCQzNlank3U2RP?=
 =?utf-8?B?UmR3eU50VERrYjJ6YWhwQjZ0UzVHMWJXc21FaWJaUWI0bzJPaG42VjhPQUFk?=
 =?utf-8?B?UGhHQzBneXhqU3FtZ24zZFN6b1ZkNHZOS0pQODN3cEFCNEdZUGhiZXNmSGgx?=
 =?utf-8?B?VWIvb1I4MG9pRk1jTmI4SVE2RnNjaytnMWhPUkREaER3OWEzR0ZTL0NETWNx?=
 =?utf-8?B?MFgwVHBjNGRIckVnUHhxMUFXZ213SzlkM0twQ3d2ODhFZUFMYVFPWjlkL25J?=
 =?utf-8?B?K2Yxd3R5eGFDS0FmSVpTN3lBR1hxYmNoMEt3VVlscnNLdFZoYXp3a0tzWjRw?=
 =?utf-8?B?S1BVbFIydEU2Uk9nYTY5VmV0dmI3WDlzYWpVeG1uZEt2OHpITjhiRWhIc1VM?=
 =?utf-8?B?bDNsTkppVjVtTGgwV0tJenpzTzZGK3hPNFhJYXpCZE1pSjdVZFVicTc4Y3Q5?=
 =?utf-8?B?RGZlRWZRNG5OQ1B0VW9wb050M2E2OSsvbVBEdmpPZmlrd1FiTUMxcFl1U1A5?=
 =?utf-8?B?RTloU1RGT0FaVUlhZ0ZQNFhwN3dYSVVWZzJzdzVSMkZ5OUVSYlFzZVJMYWxl?=
 =?utf-8?B?ZVU1RWsra0FHZXRrT05seHhoOUU4YURlMWhrMnFiYVhyMnhSOFNxZ2xiN01h?=
 =?utf-8?B?T3IvdmM5SXErQlZzbnBwdTZINWdoWlhRSUZVbmFNb2ZYc1p1MXVqSHl5VS8w?=
 =?utf-8?B?Mk1JeVpoOGZDc1AyZ2x5S2JSbFd1d0gzaERUaXZ6WkhWV0M5WnpvQ29MLzFH?=
 =?utf-8?B?QWxtb3lQZmRRV3J5eit4TFAxK2tkT2xRdmpPU0cxdzRjc3dZL3RqMk9qWkZW?=
 =?utf-8?B?Wm9kNERDRVlpWHlKRitKNWJjQWdrbXVQSWhQZHhRVTNxSzRsZTRvTExZL3Ry?=
 =?utf-8?B?QlV6T0o5RGJpWWRlOWcxaklHb1JqTVBXVktCSnFlMTh4aUk0RXVWZkJTOWlD?=
 =?utf-8?B?Z1oyV3hLRW1RNDBvUnc4c1hTYlU2eUNGM2ZkVXFxeS9vbTRjNlNacWFJeElG?=
 =?utf-8?B?dmhUb2R6dlh4VVVMUmV3U3lZbkk4Ym05Q2FBb1VaRG82Zmh0L1NkZndwcWN6?=
 =?utf-8?B?VUx5RzY3ZHM3SUNtTUQ2dWlyVXM5cEVBK2VTdnFUNlJHUDRoRGJWL0pKcnJW?=
 =?utf-8?B?cUdDejcvUlliSDA4SmNQNWU4SlhxVjdJSjZzWW9OdzMzdVMxNlpSVk1KS0Fu?=
 =?utf-8?B?ZHBqTGVDRTFTM3RRdGQ3dUpKZElVWlFxSjJyU25tY1VxazNCRjNmbEJNYWVz?=
 =?utf-8?B?TmpnMklnNFJsUUdDMkhkd2hKTTg0WkpNQXlnVFFBcjNyMlRFT3Rod2xnL1gr?=
 =?utf-8?B?SDBhMDVVR1NqNWtzalk5NDZBWEliNGtzK3lJL1NZaTZMaFhxY1VUMWNKZjJJ?=
 =?utf-8?B?V2NxRS9jOEdhN2doMXh0amJWTGdDcmw1Rmg2Z0xxSzE0am1BYWMxZGRVc2FO?=
 =?utf-8?B?UDdwOHJTV2NLSWZ6d3dLZ2ZzZXk1ZzFlV2dUUnFweGkwNmNCa1VIZC9JZDll?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5opgVo/5825C47RE9xu8iciNepzlv1SZFdBNej64YOPfGS1Sm6lGIeckhWK1ESZNcv8o6psfxKaA7+qSUivpqsORSzGtXYS0NkezeipgalwpHjBopYNIJEDZ9RPcar2AgcJCl8Ey7aB3BcgmnrEcv/QeTBz+PyaCwZz9WevOetlY2bs4ET8/DIPaMW3yQOBu9blH38FkjnmH2v63nv9WivBrT6FtUrtTeKk68f7zCGxSKUnuXFS+JPcnMyJV2r5QZJJppZTzet4RF/rAxKusMQv7qSLj1R+mjHx2WI7ejtUc4W1+QxAwIzj1LP30gaZd1ejGasGMnSfrxU7Jn/riMJVBz77LdcLCaqCAVTT+cBXvBaJdyoIDLlEcxOVo0LTRVZdGCXNqCPCn/sTjfl0QsbUuKTP5Rn3gIyGLAehdlU5u933VvgG8MbdRnK3J2LdasJQByRj4joHn2Om37arWjdcVpXXTYY7bwGBIzkbhcaJ718Yta9e3w09/6FrnnDeaF3Kkz9oqjrkwz32A2/H/j6j1d7HMHKJog6Sw0LQB8Xjm4R2IyCGa1HeRFLJ7ZL1HSxf6PH4hg1+uZiLmjorj7HPUrCxkg8qH7mMYRBhZZfM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d4a667-b094-4837-cd61-08de0d84af11
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 13:54:25.9791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Y1njP7RBcEZS5SJ5MrWbf+cIx/g58EgaPXNcHcyaqabS5r3rGfYCCxLBfLs8Jarw48OFZfwNvwCEv6gJBelKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5927
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510170103
X-Proofpoint-GUID: gkG4ge8LIOjlFnLbcBP6g3-UFg1Dqstr
X-Proofpoint-ORIG-GUID: gkG4ge8LIOjlFnLbcBP6g3-UFg1Dqstr
X-Authority-Analysis: v=2.4 cv=QfNrf8bv c=1 sm=1 tr=0 ts=68f24a96 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=_1f747B9AAAA:8 a=WSbx_2EuEZNy01txSn4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bNydOr8fjcDc2d-BW8Hn:22 cc=ntf awl=host:13624
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfX4z8A8JBGW+wY
 9pZPEL4xWK/Hz3HRVU6PdD/GbEA3yeQbmzd7pBm+P9sr8k2woCETmTk/CDC+X5+6ixqqRvMXmyS
 rFQ9wSpsBpturpSGHhPp72+pAUdYqJXgN2GIF97GRCxq6UGJxoNPShpI12HiH9JgKvS5oZWG5B3
 2BFI853eFqmrZ5tZCw2JAmd1CJx21CnScYRBobw9P0Vrxlrwlq2X5lqOrcQhMH6BFgn3T+eXbWa
 6oPIYCSkOlD3FvMV08P1BwDRT7g40pdeeiu1X9NniyKUmhSK6kInMC06zxQqIJMjZOGAxTogCru
 nhSzHkM9bvsIT1r6uE8v2SY7X1QPLi9d+tuyGHmQWKbQkpG+8v052206SL5U6Sod2N1yualTgKt
 ZYSWrdckfXVKX15cXNlhY/7X6KGsz6TyZwJv4iOH0ZCD/6WK2CM=

On 16/10/2025 19:37, Andrii Nakryiko wrote:
> On Wed, Oct 8, 2025 at 10:36 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> Allow module-based delivery of potentially large vmlinux .BTF.extra section;
>> section; also support visibility of BTF data in kernel, modules in
>> /sys/kernel/btf_extra.
>>
> 
> nit: whatever naming we pick, I'd keep all the BTF exposed under the
> same /sys/kernel/btf/ directory. And then use suffixes to denote extra
> subsets of BTF. E.g., vmlinux is base vmlinux BTF, vmlinux.funcs (or
> whatever we will agree on) will be split BTF on top of vmlinux BTF
> with all this function information. Same for kernel modules: <module>
> for "base module BTF" (which is itself split on top of vmlinux, of
> course), and <module>.funcs for this extra func info stuff,
> (multi-)split on top of <module> BTF itself.
> 

I went back and forth on this; my only hesitation in adding to
/sys/kernel/btf was that I was concerned existing tools might make
assumptions about its contents; i.e.

- vmlinux is kernel BTF
- everything else is module BTF relative to base BTF

If we're not too worried about that we can put it in the same directory
with the "." connoting split BTF relative to the prefix

/sys/kernel/btf/[vmlinux|module].func_info

Don't think a "." is valid in a module name, so there should never be
name clashes.

For completeness another possibility is

/sys/kernel/btf/func.info/[vmlinux|module_name]

However I'm happy to adjust to whateer seems most intuitive. Thanks!

>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  include/linux/bpf.h       |   1 +
>>  include/linux/btf.h       |   2 +
>>  include/linux/module.h    |   4 ++
>>  kernel/bpf/Makefile       |   1 +
>>  kernel/bpf/btf.c          | 114 +++++++++++++++++++++++++++-----------
>>  kernel/bpf/btf_extra.c    |  25 +++++++++
>>  kernel/bpf/sysfs_btf.c    |  21 ++++++-
>>  kernel/module/main.c      |   4 ++
>>  lib/Kconfig.debug         |   2 +-
>>  scripts/Makefile.btf      |   3 +-
>>  scripts/Makefile.modfinal |   5 ++
>>  scripts/link-vmlinux.sh   |   6 ++
>>  12 files changed, 154 insertions(+), 34 deletions(-)
>>  create mode 100644 kernel/bpf/btf_extra.c
>>
> 
> [...]


