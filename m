Return-Path: <bpf+bounces-28430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EE48B9A39
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 13:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA9F11C21046
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 11:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C89F664DB;
	Thu,  2 May 2024 11:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n//O9Q86";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="r41jLtsS"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F20240BF5
	for <bpf@vger.kernel.org>; Thu,  2 May 2024 11:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714650599; cv=fail; b=Mhd6oyAxKI6/A4yvYzfQeaCS0Yle2AjeFAf9tSwwT7DSxLP6qylC7mOOsbyX46PwdZCbefLnzsDNj5t/TRn1eVAcIaO3ortuD8sHWAKERrDxY2tHhK5pmzbYo0kRcpcDcTUwo6Bm/QUVNVAGei5uxUTwts08QUZ7kr9KbwNeitw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714650599; c=relaxed/simple;
	bh=kE9liETEY6DSotFrb+XcHCJgKKeTN2piXkgir3ui6x8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qyOFyAk03oljtWK2yaRTvJ1jtqdaTJQ7RKI+f1tziyxacezULUdMjIl4zjTSMKXxcNzM9HBOo9NawRUfGPJaiFCgrHGwYnJy5HC25dgZ5Q6H14mN9peGMZsEbZeb6S6t2O3T8yn9duI4BEz/qFz/bS5ShanaZG88wi7+2VSr30Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n//O9Q86; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=r41jLtsS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44284Ksi027515;
	Thu, 2 May 2024 11:49:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=shs+rwQnS6SbeqbxIrxoscaQ8/J1Hji5r13V0QG15Ck=;
 b=n//O9Q865dLyi7YdcxQTNOb5lUEajEouZHOsfMwqBRW+D5driekht2Jg1veEtFPuNZDO
 dXKizaG+7PC2IzQf5woTblUboWVhIXxABSFi4yZugU6c13+Wdryn3EwElSNCMBE+dg9e
 gjK8qAUyyh3h3F1J+bE7cSLw6AaTKPFLHAyMju9zqPeVY36NhSxao6IfMgjFc8TH1C/u
 RUT5EihlrgK9cPiVtGNUDDD0m6ptWXTaQz1J+ROE4wm3+p6+MwMTPvvmeWfITtfHnSgo
 couCVwquc65SUr8vGJJ6p2HJBk91EgQRsyjm4PM+ueChT7vnWaYkf+IU9a1P4rLun8/f SA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqy361qa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2024 11:49:35 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 442AhcIH008810;
	Thu, 2 May 2024 11:49:34 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xu4c23h22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2024 11:49:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yk08/YF3hep57LVFXgANcGldCB/IZcaJ2mFwJtGwgMZhHugXl4SLjIlJA96f+R8noBU4iz8FriEJAYUbPOA62jFSiWhKd2xlfhFR3B3hIYIuWbKuaNEvVJ/52f9ZEKroVFkqkEtST/YjSwvqFphDRs5c61VJZavniz2mJpTHHAyhTMvhKVI1HcUQVR5L355ffsj0L3UQS5BLlzY9SoJ4MnVbeCP2uJNNMzN9le+bWbIAC+HTysG+fnG34ivQCeGhZzdZBnOAEPMRjsoEOzK/yJ+Qre5Kg4OmX5lTRq+l3CcJREqHIXSJ9g5NjZDwoPeR9DDO4WrQw4g9fTPOSPf7WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shs+rwQnS6SbeqbxIrxoscaQ8/J1Hji5r13V0QG15Ck=;
 b=dx/JTFl6mlGDFWFzcb0ySAqLRc0FYKbLYAHEHH+1uDPCrNioJWpu9DoDkaFF/NYwifoLWFdkjhTukyUIF4p2HRmUe+/stcxQOuxLZofhZngfrD48jv3KnRWPv8GLqBzNP6yO0wRfD7Mzb2Gt+CozdJUQDcbhVyGvI9ZqcWpcyEa2kIYqxnzuxUD+e05FEO6MP4B5MTduOKQj/5haWsFvtKps4ejhj9jxEWBhjq0h8Pm4rkOJzuU8XBCmHEL5iYvmCQCcV2CRzbS27SnFvGmcCdnqkyTE7iRwCAeY3wEvCp+0q0f2UErrjIPbQKTvBCGTaU71vvbYC/i7+uHk7LHs4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shs+rwQnS6SbeqbxIrxoscaQ8/J1Hji5r13V0QG15Ck=;
 b=r41jLtsSJ3M3RBUez+zgD2QIHHOOy9OK+oCTPo9UT5D6Rp5dt/7GcRgLIKVxCDp5nbqHWWCxeIQDrvNNbVcgL+LTSpU1po8vTxlSqyg5i+Hm+NPVVq9sdPLFhrfnXsudG+F4otnLL1+nrnrvszQ0SUgyKsG6B/L+rHvud/zfSgI=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH0PR10MB4614.namprd10.prod.outlook.com (2603:10b6:510:42::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 11:49:31 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03%4]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 11:49:31 +0000
Message-ID: <2bc24644-0289-48c5-8118-8be4fc1658a9@oracle.com>
Date: Thu, 2 May 2024 12:49:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v9 2/3] pahole: Add --btf_feature=decl_tag_kfuncs
 feature
To: Daniel Xu <dxu@dxuuu.xyz>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: jolsa@kernel.org, quentin@isovalent.com, eddyz87@gmail.com,
        andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        bpf@vger.kernel.org
References: <cover.1714430735.git.dxu@dxuuu.xyz>
 <6d69d6dce917475ffe9c1bd7bc53358904f60915.1714430735.git.dxu@dxuuu.xyz>
 <ZjE85q0SJ1sve25u@x1>
 <2jjkwylnz7rjqkjpjb5li3n7g32uhrhx2uzwwthtgfqdf6bwzl@yjmuy24buoyl>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <2jjkwylnz7rjqkjpjb5li3n7g32uhrhx2uzwwthtgfqdf6bwzl@yjmuy24buoyl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P195CA0006.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::11) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH0PR10MB4614:EE_
X-MS-Office365-Filtering-Correlation-Id: c0ad4c9d-ea1e-4407-6e94-08dc6a9deddb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bkluQmpua2hEZWN4MlRGd205VkVSZTR4amtKMERPcHZEb3l6ZEE1aFBrVGtN?=
 =?utf-8?B?dmV4cmxMOGlXMG45cXZ6aWlsMGlvaE5SL2RsMytKcStBak9PYUN5S3JpVFdD?=
 =?utf-8?B?alA1Ri93SUFxTVJsZ0lTM0VHSkF3UnJrYS9CSzhYWjE0eS9sbXBlcWJ1eW9n?=
 =?utf-8?B?alhCWTNCVkhkUzRzdklBbk5CVkdPd21EWnQ4T0pKL2ZPTUVjR1VUTTdwZWhi?=
 =?utf-8?B?b3dnMmsweCtSV1FpZUpsUERVdFlyOHMrOG9rZ3lJTXFONUUwMEhvNTBBV1dz?=
 =?utf-8?B?R2YxYlMwWG40SDAwQWNTSUFOOXdUSWlBZUd0S0hERklHKzVtOGZsOXJoa1NC?=
 =?utf-8?B?Tkg5N3NZOUgyN05KNGhkWkZNSkxqNWV5YWdjVmQvaVR3UmtIQ0lHMDUxRjdO?=
 =?utf-8?B?WmFYWXpGT1JsR1lpVkFVSlNwS2RqRitZK3FjcUNMcUY0RVdVOWJkNWQwZFZv?=
 =?utf-8?B?MnZJandFRHRaWnVZUUpkQTh0Wi9TbUxXVEtPRWxGWGVDckd4ZUptc0dvR0Jk?=
 =?utf-8?B?WTFKUmNtUUN5OXdGT0RQUFN2Ni9nNE5FTXhjcEs5TkRzdThpU1Z1THJhUEpo?=
 =?utf-8?B?MkpVNHhvMTU2T2oramtGWFV2Z1VsRnd6Tmk3SmMvTWc5eitKWWhnb3MyRkNS?=
 =?utf-8?B?SUVnRmFNbEVjM0l0U0Q0OGw4K0Y1eFRZa3JMRzlnZkVaSkswdzBYQU50ZlIr?=
 =?utf-8?B?dTdnVFJXVGV0U2RkWlVKaWovQXlIY2hoTjcrRE1IRk5iZ29yOXQzVHNVWGp1?=
 =?utf-8?B?QnV6ejNobU5iYnRjRnBHaTFXelF0QVNBa2hZSXp0ZFRnbzJGcmZBanlIcStV?=
 =?utf-8?B?WDd1TDEvZmFlN1ZBUzRMSXFkY2hrOTFKcFVDb200Q2xLWFh5L2hmNGxZN0lH?=
 =?utf-8?B?cWg4ZjEvZ3RJNTJFMG5RcW51QTRRZUdyNnVRTVYwTG1lTDBTZm1hVFgvbzlw?=
 =?utf-8?B?SHdDU3U4d2NBNklxRVkraWZSWXlUMHJhQXNTM25MazZ0MzM3MTZaR1pIMWZJ?=
 =?utf-8?B?L3FPc092UzYzK2RDb0JwQW81dyt6SDBQSjRlYklCczRORDl6cEc3bHhHdVE3?=
 =?utf-8?B?UXBTeHRlLzQ5UC96TnJVU3hEcWlkZGw3c2l4WUZ0aXpZUG90V2pHNVdvMGps?=
 =?utf-8?B?a0loUytHMXVkMU5JMHY3b2F6WXRKUS8rRXd0cG9HYmFIL0JWTGRwemE4ZTdJ?=
 =?utf-8?B?K0I1WHFpVDh1eWVhM2hTczNCTFR3ZUhwYThQdHpSZS9GdW9WY0pDRFpMMXVl?=
 =?utf-8?B?R1V2VWVHbnZkYmo0SytzcW8vVU9DcmdxWmhKYkFzT0YxeGFIWjFKbFRoMTZz?=
 =?utf-8?B?dTQ4VnhjNmVVbHY0czYybDBOb0tjZmE0T1dpdXVTcTNWazIvOVBSUVZPRTFB?=
 =?utf-8?B?Y3l5ak1NbTgwSitpWis4SysxU3licWlqV2xiWWRabFhXa3U1S3piaVlHSjR3?=
 =?utf-8?B?dFp3S3ZpR3l5MGNMNmdUbU1tY2NIOEc3bFM0SE0vYmJMQy9HZUVpWGNsdEhT?=
 =?utf-8?B?TGU0TWYvVm9JZy9XRkV0TUtvbGtJSGtUTitPN1pvU3BZNHlvbC9sSnE4eEhG?=
 =?utf-8?B?MFV6dVRnVEpCSmZIOTVITkNXeGZrWlRzeWlkeTNjZy93a2ZZUHJJZ1BpaTJV?=
 =?utf-8?B?d2E3b0hQbmdHU3dFdnk4Rmt3NXpnb0ozdlF6YVRjelkxaUEzRWo4eDU5djNH?=
 =?utf-8?B?YUVUM1FYRzN3QTNxdTFEUHMzV2t3ZHVMKzZHMDNHeEQ2VnhXTENxRm5RPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZmF4K043OTB0M3RvUHlVZXhJK1l3NHNYYWtMajBiWGVtWlpKMmNILysxZnpO?=
 =?utf-8?B?dHlDUDhlNjMvTDNxeFo3V25JQ2F0bjBKcmdBdURqL1Zza29keDV6V3hrUHBv?=
 =?utf-8?B?MHEyd0VLdHdjVWVobzhWT1IvdGNMaUxJakUwbmtxVHpvOWxsSWVvaWd6VjNY?=
 =?utf-8?B?blp0akJRWGFKSEpXK3owdWF0YzdYc2lVZmxDbCsrc2ZXSEtkbmsrdHd2SWFu?=
 =?utf-8?B?eEZ5Rzk1YWErd3VQUU1tNnJQTDVYZXpFSFl3RURJYVFpNFVqU0lyaENIODJJ?=
 =?utf-8?B?MC93ZTVGaXRvMVltTFBTNi9leTlWaXF6ckdzRE9wL2ovd2s5MkU2SDlpOWdR?=
 =?utf-8?B?TVNxczNNM2FIT3BHRmlRYmhtaTlNRkI2NVc3bUJXRzVBaEFMWVdsZk1pcTNs?=
 =?utf-8?B?VXBUK2lDSmFhYnhEUWVJSWNnSktVeUgzR1NNUWJnUzVObWl1MzVNMHF2L0Zx?=
 =?utf-8?B?WnBpYTRrVUVGSVhXQUk5a0NaamhXT0JzOExDdVVnVlFNTGIrbSsyRFdrWmdQ?=
 =?utf-8?B?N0lJWUhDanEwb1g5eTdFYy9DVVlPRFRLQ0paVWdOWVg4UWpQL0ZsbU04MFRq?=
 =?utf-8?B?QjdLa0NkRDRSb21FM0N5TUhFSlhzSlJ0VGJzZ0k3Sm9QeDNpQUsvRVhPRnND?=
 =?utf-8?B?ejFzWThtZjhPSmhrQjcxbVYwWUZQWFNxTll4SVh3NlJwNGVnQW03L0pKb2g3?=
 =?utf-8?B?S1pHc2JINEk4cm1qYTlTZ3dseEg2NXVyMWx2dWtQdllNRStOQ1o3dzNuZE1q?=
 =?utf-8?B?RmdqcStJZWJrNGNtWkJZd0diT2MrSHBLSlR2Z0NQZWNPdU91b25EdVV5Tm1P?=
 =?utf-8?B?b2FIcWxZRUZORzJXeE1OTDF6M0ZSRXB0QzFxckdnd21WSUlZOEQ1VGxIMTRB?=
 =?utf-8?B?K3ZKanlUUkZOeUYvYUhDazBDWUdleEJLT0N3ZXcvaC96cXBpcDRYbWFiam5E?=
 =?utf-8?B?NmlVQld6SnlSVGJ1cHhTdjJNWWgzbjVHd091cVRsRkwwZzFscW82UU1FSlZz?=
 =?utf-8?B?RnFCMHl4ZUZMSDQwZDlsSlVXdVgxNWJTa2xWQSs5cEd4a0RYSHdHemlaTVhH?=
 =?utf-8?B?NWhxVTlXWE9xUy8vUmx1SlF6M0o4ZjVCSVJNUktuNzVrMCtXeVRhR2R6ZlU2?=
 =?utf-8?B?Ull5THFzOVFrRG1DTGQ4a1NEV3VGZjUyZUlPRTdPWG5pNmxFS1pPR0xSbVZP?=
 =?utf-8?B?dURKS0k5aVhWMW9PNERQaERHZUFEUERzL25uRGZoY2cyUTk4c21wYTRDTVN5?=
 =?utf-8?B?THBySDB6RFlyYW1TNGRUWTRJOTZtdzhNRGR2S1drN2tSRmR6cktxbjhUL0hm?=
 =?utf-8?B?TEorcjhWbnpqa0FHM3VoNUU2aXZ0WWdLMUY1dERYVkhlTXVpNFlJQ2pFemJD?=
 =?utf-8?B?djR3V2xSS1VwenNVMWhDK3VIc1RSV1pLK1ZPQUZTb0U0KzhSeFVCcFdid3Zs?=
 =?utf-8?B?R3ovK05zblBDbmpjQW5IbG1hVktKNzNDN1RpQ0dhV005dmc3d1QvbEZ0a0JW?=
 =?utf-8?B?REhUdnhCZmtDMGZoTWFrNlZxMTRCd2VGbTRhcG4rRW9EWnBIQnkrM2p6WXZt?=
 =?utf-8?B?U2NwbHdxVkhKVStEVERCMXVYSEU2Tm1ROTN3cXJFa3YxU0hqMGVYWjE1V1g0?=
 =?utf-8?B?WlF5QmlzMmNZV3JQdmt1U2R3ZUdic0xBNXJsc2h5cm1hMVBuMFZ0YnFMYmha?=
 =?utf-8?B?VTVTaUNkWlR3cXJqaDByV3hPTDJCM2k0dEp6RlhQenIvRUN0K0xkaU84dUJM?=
 =?utf-8?B?TmNOS3FQalozZVY1SDkrWHZrNXk3N3Bma21GUjZxSitqUDBCYlRFQVpvdUZD?=
 =?utf-8?B?RUhrOUhuRU03VFg1ZVdOZmQxQTZtMGxRSGI1eVZSZ1B1VEFkeXFWT2poRzVp?=
 =?utf-8?B?YlZDSnoyUW5CUU1NaThZTG1lOHFCM29SQWo2YU91YU90RFI4QzI5ZWJLejQ1?=
 =?utf-8?B?eS9ZMDBFWTFndFIwWG1BSjlMS2M2aXpxbEtkVmVVdURGaVc5UytINUVEWEUz?=
 =?utf-8?B?VkgwQ1NoWjJSRmdoTVg2SjBwYjVGd2tLcTB2cUZ6WHY0d3BGem9nR3gvelll?=
 =?utf-8?B?c2duYmkxWUNjejFYOWJJWS8xeExoTnJqa21NcEtZVHo4eU9LQmNsWGsxUTNa?=
 =?utf-8?B?YlZxY1hOcmgrSnNNSnh4aTFZblJBTFNNUXNmYjF6Q1BHRWdqUVlDK2JKa3E0?=
 =?utf-8?Q?1HQ8bt4ch7DwEOfwHdW0rvg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QKKSqnCBiM+HtxuU7DSZKEv48fE9OgFr8MT260AZ3lI6SkpFvD3U0becflDfaMz0WlBRVpFc0ethHoEl39HyKpI2v/7SVTihSrDRUTzPPzlleK8+eK0ms4xxgyx6sDbv94brAFvJLCvZCdBgdKwQjiXfySgQg+iw3yhkzpycbqb4QExfyfTU7I154IMN8FJFem3TcdGxHOXHX8AzN7nAq6KTSB/s1u33TMsxEeA/FM6I19Wt0/83Lgn3dQTNJUoETMR62EB7kUr/BbDX1pvwMsLwlYAFaxrR/gcWT8RWmVceB95oqml5NeHzwM7S3qXfe2Xou3AGxSczqcxSp5Y6RV+DgXOdqXFLpsZID/83CYz9x7lacMgtNdQB8k2L1+5x1elXir7B1WJ2jgqLEfYNACYDyfokn7hNCVnyAfJoSm2ArrNdxYC7BfX+vl4ucHiwkYAp+HOA0Sj6kyiVm7CdZQLxz1YYUi27iu3KGkRsKY2Qy3GvKE7zigVh2Z1rR2lxioaVw1xE3LhrQEvYYBFXk5FD0zWjxbZesgB8TXDxQKp3KV3Fd3RVGJD1WZVRq3sWw7yUJbfGlv7aotopxRVH1EV9W+7hJRhm8SEtHstZETs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ad4c9d-ea1e-4407-6e94-08dc6a9deddb
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 11:49:31.5096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6q7bCmt4Jjld/9m2jK8x/9khjL4CA4Hoqgn99VwOtSppDkHpPayMTvewXNxlsofhX5DkXhWb37O27azOPXvJGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4614
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-02_01,2024-05-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405020074
X-Proofpoint-ORIG-GUID: l6QDp82VQR7f-65BqlT54XftSdYUwbLZ
X-Proofpoint-GUID: l6QDp82VQR7f-65BqlT54XftSdYUwbLZ

On 01/05/2024 00:00, Daniel Xu wrote:
> Hi Arnaldo,
> 
> On Tue, Apr 30, 2024 at 03:48:06PM GMT, Arnaldo Carvalho de Melo wrote:
>> On Mon, Apr 29, 2024 at 04:45:59PM -0600, Daniel Xu wrote:
>>> Add a feature flag to guard tagging of kfuncs. The next commit will
>>> implement the actual tagging.
>>>
>>> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>>> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
>>
>> Also 'decl_tag_kfuncs' is not enabled when using --btf_features=default,
>> right? as:
>>
>>         BTF_DEFAULT_FEATURE(decl_tag_kfuncs, btf_decl_tag_kfuncs, false),
>>
>> And that false is .default_enabled=false.
> 
> I think that `false` is for `initial_value`, isn't it? The macro sets
> the `default_enabled` field.
> 

yep it's the initial unset value. Specifying an option in --btf_features
flips that value, so for initial-off values they are switched on, while
initial-on values are switched off. I _think_ the intent here is to tag
kfuncs by default, so we can add tag_kfuncs to the set of options
specified in pahole-flags for v1.26. We won't be using "default" there
as we want to call out the flags explicitly.

Alan

> Building with this seems to tag the kfuncs for me:
> 
> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf                                                                                                                                                                 
> index 82377e470aed..7128dc25ba29 100644                                                                                                                                                                                  
> --- a/scripts/Makefile.btf                                                                                                                                                                                               
> +++ b/scripts/Makefile.btf                                                                                                                                                                                               
> @@ -16,4 +16,6 @@ pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)                += --lang_exclude=rust                                                                                                                   
>                                                                                                                                                                                                                          
>  pahole-flags-$(call test-ge, $(pahole-ver), 125)       += --skip_encoding_btf_inconsistent_proto --btf_gen_optimized                                                                                                    
>                                                                                                                                                                                                                          
> +pahole-flags-$(call test-ge, $(pahole-ver), 126)       = -j --lang_exclude=rust --btf_features=default                                                                                                                  
> +                                                                                                                                                                                                                        
>  export PAHOLE_FLAGS := $(pahole-flags-y)
> 
> Thanks,
> Daniel

