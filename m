Return-Path: <bpf+bounces-31148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2F98D75C7
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 15:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41BAEB21D5D
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 13:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6528B3FB01;
	Sun,  2 Jun 2024 13:42:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8013CF7E
	for <bpf@vger.kernel.org>; Sun,  2 Jun 2024 13:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717335777; cv=fail; b=eCIy21n24EYr2JjAc7F11woi3+xclCKG4cC1Dl1If7XnIRJQXtUI8127IQUGSJVWQkTee2aVeURH9kujZ5f8COsPs+02Kgi7Lv8CUfHiITaJUJblwe1p2G+PBk6JAOcEpNXs7+FwV7jffGljOroR+n//oKwXbLR8H29gixSHb94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717335777; c=relaxed/simple;
	bh=AKsPM1J+cCnaztPbQelO9plmdion5DUmw22zrdllYjk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BlH+7jzXRWh3s/8UO+Z4+WCvXdRWRjFmFQsMeXC6JFC43sJFIh0oq48mnjUjZ+IJ2FN9EOJ+ZcBJPyYzZkQfxhtvDS3dAgsdImD8YfTbNhHWzobHjZG9LXpRjzS2s7Bj4sQmy/k11h8LmxNLmYTlWGLNdJ6T5XxLwPe5J1cK9ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4522EeZP010178;
	Sun, 2 Jun 2024 13:42:24 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DUlEzFO2u1qm62krEqdaYjzCnpNUklBzkNlkRIWUtKtI=3D;_b?=
 =?UTF-8?Q?=3DV1Y3voVxIIshNXa2MU6EwYmllXAOQpFP0fwqYJVchPpttqYuFxElF5Vr9wZy?=
 =?UTF-8?Q?jGt80IX1_zuN/J1UsqKSkTty1PGtFivfuYfEeQ1PtPUqPSfTJXbiMklvsdARVK8?=
 =?UTF-8?Q?p6bt434z7Kv1z0_gIabpRLXPSwmHbW8RHbSN5OxLlA0VLuhSsjnCnnHZFPG5DUa?=
 =?UTF-8?Q?wJpxAUUs3pSlJ3YbI/Jg_Ytmp2hRTLcsrMqyouatX9MpECfFVyJnkrTb3sCOk0E?=
 =?UTF-8?Q?vDaSZQoy3f10LtXw/sLBLZEN/l_cYI74rDTPzTTrFSHQDVQt7bb4AizxAedm8mR?=
 =?UTF-8?Q?6loelsjicN8YmJfwosR0pBtErs12LoEv_Ow=3D=3D_?=
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfuvvsc3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 02 Jun 2024 13:42:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 452CDdXD037916;
	Sun, 2 Jun 2024 13:42:22 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrja15h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 02 Jun 2024 13:42:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULdsb5akW5nMII9CoN1a6JBgLBtfWKW+8JLrNqYbcxWFF2A5/3ISYJ1pnILZUR+nfTTyvcws7PlCpK5Ja3jrvw0KbX9/UxtZYhU2A1Px5FWehICL52LUB76n5HK7dkB2LuAFyu2LS61mqbEDL9rm1o2mX3LgmK8MGJ2cJJ+9+T85kfV2T8MEbNQVHkdinQwG/Xp/1VybyzT/VYf657mVEW1mzc7OPfu+3S1WzRwje6KYHpA6C89z/x3OG5hcjVnu8Ox1/fiXGkNkps7yRB1Sp5MuqJq3Glw5Sfb/O/0+mJETWrRLlHEBilRGFlhtMCRFJ+ht4VFkSakYIrK0IJuCkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UlEzFO2u1qm62krEqdaYjzCnpNUklBzkNlkRIWUtKtI=;
 b=BWnV1Jsa7yVWeWl4YSfftFdUtiiTld2n42z/4hfiaXkYVcid5D672PVFPASKkkKG603tWqTP1UovVCodvoQvRqPcc6OQcROH2sjkrt0AZed8CAmxC6p/t6BsgkCOhnj7GDSgpgorP+n+k0hG1cjlOafTjY4moNyYJiy+hMCzOTBLWCdxuRAXDkw0y9reP88brceBCN5yu+dT6o+Ixj6wrSOLIw556AXTM219AYFnz5iNudM2Y9nRusXVivDT5p0RMXIaXVznSb/Kgtz3/do6ka5rmKL7SyMbTo5VQQu3ecGAwD3IR1YWJhXuKsUpH924cvfgQKdXVCDe3e027eQYmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlEzFO2u1qm62krEqdaYjzCnpNUklBzkNlkRIWUtKtI=;
 b=LwYtlKcWmrB0NYOJhQYcSfyLrR8xhwc3dK+Qa59BfhKGPxQWWAlZdKK8YdDKgvbl0h7/sVstl0FJ08Jh10Xs9nj/7kTR9edFTgaW19fEA4vCAuucGfFphg36h3LOFxhcINztM4EgUm91Q8DHe41W8QvieEvMg7a06qiT0fGLWu4=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CH2PR10MB4295.namprd10.prod.outlook.com (2603:10b6:610:a6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Sun, 2 Jun
 2024 13:42:20 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7633.021; Sun, 2 Jun 2024
 13:42:20 +0000
Message-ID: <95a78cf9-c358-4822-b052-65cae1d5391a@oracle.com>
Date: Sun, 2 Jun 2024 14:42:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 bpf-next 8/9] libbpf,bpf: share BTF relocate-related
 code with kernel
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com, eddyz87@gmail.com, mykolal@fb.com,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        houtao1@huawei.com, bpf@vger.kernel.org, masahiroy@kernel.org,
        mcgrof@kernel.org, nathan@kernel.org
References: <20240528122408.3154936-1-alan.maguire@oracle.com>
 <20240528122408.3154936-9-alan.maguire@oracle.com>
 <CAEf4BzaJQAyHmSOTyQaLCx29zFQZEZnHR+gaTNt-Ae5nvi7G6g@mail.gmail.com>
 <CAEf4BzZ4Z38GspkSi8QjdGTfwFvNZ3aVPjGjU-6XQte+dKwWVQ@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzZ4Z38GspkSi8QjdGTfwFvNZ3aVPjGjU-6XQte+dKwWVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0131.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::10) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CH2PR10MB4295:EE_
X-MS-Office365-Filtering-Correlation-Id: 6defa545-d908-4a05-a893-08dc8309d319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?L2tWYlhZdlV3RnViN25XUEtsS1g2ZkFpa21MNzVZeXM3NXhrOUN1dG9YYlZK?=
 =?utf-8?B?T3hHdmZsQzA1d2FwM2N0NEcyL2E0bzMyMWRYUHY2T0pVWm1PVmloSUFhZE82?=
 =?utf-8?B?ZDZsamZCZ0NyeUh1RFVEUTdZZ0NQeGQ0SVNxTE1aSWFPRHNoeHExRE00ZHdF?=
 =?utf-8?B?TU5JU0tFdVE2ZllMK1BaM3hRb0laYVlWNUtnd0xCZWcyNFFPSVE1NWhsNjdj?=
 =?utf-8?B?NjlvdU1uVFU1ejNFeG8zdlFYMUVjekUvMUROVk5BTVM4TVJQOHFGL3Zpc0Mx?=
 =?utf-8?B?ZVVlUUVDS0llWWt6NUJycnArV3ppQ3dRb0ZTVGY5Q3hxVHVSVmpPVWlwSUI0?=
 =?utf-8?B?dHMvVnRLVEVRMnVxLzArZzZmR25rcW5QWUtFMEJXdG82eG5sTEFXOHlWMGlI?=
 =?utf-8?B?blVIK0Jjd0ZhK0gvQmdnNWp5UEtPUmV5RjRSQTRmamhQVHdTdkZXaHgyd2Yx?=
 =?utf-8?B?ckV4UGlXaTJwekJQTGh1REJEcFVrTUR4NEZGRDdqVk50NVNVNDVncVYyNkVx?=
 =?utf-8?B?MWg3djZZSkljREJkdmI2bkpEeXBDSjU5S1B3QnZNeW1qcmtHc1hzZ29WZjk4?=
 =?utf-8?B?OWovYlZSS2grMnFtaTJFRDFmaHVNdFM2OTR0WGovVVpRMWVWSWVFZXVNSDl6?=
 =?utf-8?B?MWhDekdlV0ExWTV4dVlrY21CdUswbytQMzhxa2pnNnJvWnZPUFp1MW4zbjNV?=
 =?utf-8?B?bWNidTBnYlZNeDE0akE2TVhMNjhJME1GaUZPTFJvNFRjKzk3WklQYTU0bk1G?=
 =?utf-8?B?L29LWUJ0NzRGUXlGeG9sMWNoVDhRU1BVRnRNTjUxMFB0bElPcWFVZFJYbkU3?=
 =?utf-8?B?Qys4Q3U2QWU5SFlueG1xZ1l2T05tRFA5bElqL1dVWVc2WWFRS01tL2pXejZo?=
 =?utf-8?B?TThvT3B2ZFFGNUhtZmdpYXdqSWJ2ZU54VXRTSGpRb3V5Znl5ZndaSEY3TWs1?=
 =?utf-8?B?SGJ0MzR6UWhCSEdERUgwSjVaY3Bqa2VVUFlVdmtIaFh0dFpIMUhmUGFuY0Uv?=
 =?utf-8?B?S2F5YnZPWnFCRnE1UEJPZHlZU3VvSHY2NVBTd04vU3RXNzVOcks4a0d5d0Fs?=
 =?utf-8?B?Y3RTSE9USVE3NWhYQzlSRmdCQUdkVktCZzRJSUo2ZFZMakNURzg3WnNQRDc3?=
 =?utf-8?B?OGk3TmIxK3Y3SGZveHpON0w3TFZuVWF3SS9tTWhOcGRXekkxWlRzVDU3NER4?=
 =?utf-8?B?RCtwZUZmR1pISzg5QXlqRzlXL1NKeXNJZmFZZVdHVFNhNGhsOEwrUlNKY0hB?=
 =?utf-8?B?cmNHUERmTEphcjlWSHZRUUtra0V5RkNLck9ybFlpQkhUNTVzeldFYmVUSmpT?=
 =?utf-8?B?K1k3WFBnVjVJNUQwc1oza0xBZk5SZys1MFdsS3dTY084a0hhaFRkRkxyR1Nv?=
 =?utf-8?B?MDBqTDg1MWt0NW1OYkxqZW5hOU9oY0pqRFNHbitKTmY4WkFZOGJqdVVRR2NI?=
 =?utf-8?B?MXF0R09EZWQ2L0lLYU5kWG1wS1RzSy9qaU9rRk9tK1FlRzNuVlFMK1BuU3FT?=
 =?utf-8?B?bWpGbnBBN0kyemEwVEZZVXREQUNpWTJhVUxVTSsxMTN1REYwWEVId1F1TkFC?=
 =?utf-8?B?Nnp4Um1qN3FmS0RJdWxFM0RaY3MwRldPb2hJZFZLc25SNWZkbS9jNGdVTFRq?=
 =?utf-8?Q?D8TpZgHWHJpGP5C6AdAMDJnKILHt3d56xckCFRF4ylVQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aGFvOU5CVlUrdWFMSGpSQzV3aU8xUkI4SXRveEFUcUl6WWJVOFdVdFRwOGxw?=
 =?utf-8?B?dzhxUjB1R1BEdEVzVnU3a2U2aXdaVlptWEdxaElieVZFVE90U2hLTHdEcTIw?=
 =?utf-8?B?Qk1zclB2cjA0NUFmOFppZDJZQkRnb0p4bkN6S3Ivdk1KbnRNa3Z3VG4zVkkx?=
 =?utf-8?B?bTFLWXluZVp2K2sxMWh2c2llWGgzb3dyNllnMEFydlE2ekZiYmkxdTFhd09H?=
 =?utf-8?B?emxMNTdRWmxueUVxWWE0Nkxqb3E3NU1WWTM2NFJ5ZWY5dXdtdkhDQjE0Vyt0?=
 =?utf-8?B?dm82Nkd0NW5BNTBJY01oMVp2ckl5Y2Fvc0ZsbHRybnplTys1VVg3OVpyb2c2?=
 =?utf-8?B?RmFJZWw3TllaYzNidkdiQU9BL01ZZkQwWjAvRXpZTGp6ellxcllncnMzTzFk?=
 =?utf-8?B?T2ZNYTZIay8rWEZybllFYWd6U1NRWEtJSVVmTzdLd3UwclhKeUxJYS9MZ0wz?=
 =?utf-8?B?Y1pzV1pQdFlzSjR2eHJXSzFRV284bjB1d2xTY2dNWWdYVEtCb3ljQ21iMGkv?=
 =?utf-8?B?MDFOQmFkMmpmbmtMZ2ZyVS9wWXhwM3dnNzhDWlJ1c1JDZW9CajcxZzd4eXB0?=
 =?utf-8?B?RlUzRVlVV3c5Tno1K2NqUElsNGFIZGVSUU5UaUs3M1ROZ3ErUzZnT3dXaDF3?=
 =?utf-8?B?UktXWEVvQmdROURxOWUzNUhBQ0pYT09PZEhqQ25oSElBYXpHWnBVa3hMdHla?=
 =?utf-8?B?QlNYWk1FcUdFbkRueERvYXFzU21yK1ZHTGhMNjJMNHNQUVFYVVRYaHhLaFY4?=
 =?utf-8?B?dTAvME9QTFQ1MkN5TkRsVzN2NUxIZ1dZaFlMbHFiWmFZanZVdFFGVWVTMTd2?=
 =?utf-8?B?RDlZRHZNb3Nja0tCa0tlc1RKam5sL0hsM0grMmRvUkdYNm8xQlpkSFU1a2Uz?=
 =?utf-8?B?TjIzZWxGUGxzbGp6Mm9RNEl6ZDFtMER3OVJUdHB2ekJ4eWkrV3NwTzNHYkF5?=
 =?utf-8?B?OE5oM3Q4T3VHa0pOeklJaksyWHhUZm5acHE5Ky9RUnpoRzhBeTdDUmc2UXMv?=
 =?utf-8?B?NHZjdHd6UGEzV3V6MDg2VVBnNzFCcjU2NC9nSzlOLzZSNjdxMnRGdkU5cGQ5?=
 =?utf-8?B?M2Q1bjZobVhsVnhaYnFwVEJMNFVDVk02RURzcTh6dVpJN2dCM2xGY09nSXg5?=
 =?utf-8?B?TFVrbEVEMmRtR3FQSmJvNUMwUnFFSkYxREQyOXdaL2xlUWErbFc1TmZWZTNL?=
 =?utf-8?B?dkQ0cnpvczBrT2hDZG43U1Zma1VRVDRHSXYvYU16bGNsSW5VY1pkckVJMXZF?=
 =?utf-8?B?VzgwNFFFSkN0RXJXRkRnZWtVU1dTSmFXYTh3WGFaNWlLWWZrZGxydVZsdGxZ?=
 =?utf-8?B?dk1PVSt2bnJBcjZQK2pYUjVydEl6cFJhcE16Uk4vN092WWFIVUZoTTFjeVE0?=
 =?utf-8?B?eVdheXBIZmtYVkhvN2FUNmJvazRKNUtGVTFQK1RaekdZOXJhUEQ4RWpLV2tE?=
 =?utf-8?B?MERxaWNpcHRaSnZyOGVqcFVtV2lGN2ljaWRMeng3UG54eWFhakRhUzNCNTRh?=
 =?utf-8?B?ZVBKYndCT01QZlZMTlhPNVl6b0g1ZkhLdWs3b25SWDlxdmZTTjZLdC9HWjls?=
 =?utf-8?B?eTdnTi9sTDdycHdXNktRdlhLQzJmSDJmWTNXRW9LWGU4aGFTVWVNc2pBZklt?=
 =?utf-8?B?bnBPeUM0S04zVTRtaVk4M2t6a01JSzhjQm5FNVoxQzQzZlJwM0lvbUQ1M0pH?=
 =?utf-8?B?cDFQMHUxTTEybzR5eDNXeVF0MU1tMXRxenNvQWFONG9Ca3Uvb3VkaGNMcXJs?=
 =?utf-8?B?Z0ExdGJpMzluSHdQSlNSWmg1OVRzSzJtaHF5VStBK0txcFdIV2hXUzJ0Mnda?=
 =?utf-8?B?UHBBZjgzSmhvUFppdVBpUUx4aHNENnRHcFZLWkg4bHltdEhJNGFPbWpKZjBY?=
 =?utf-8?B?Z0Z6OURZb2wvbUhqTUIyTVJBV2JhRWkxT1V1a2xDUVp4bm9JWjJCOHJkNTVn?=
 =?utf-8?B?aTY0d0xhVFN3SVhWeFdmQTYreW9CT1dnY203NElZNUZyVVhhdGNLRVhDRTZy?=
 =?utf-8?B?KzZYcjdQTzF1em12aEhjcEJPRHYwKzJaM21XZklLbGNDd3JUTzhHU0NvT1dq?=
 =?utf-8?B?by9XWG9NNjZwTFFUTkM1bzJOdDd5cHYyVFFSTmNjTUVIY1hDZzAzR01JRmxW?=
 =?utf-8?B?RUMreVZKTTNLdnRKeWxNdmZQSlNWQUU1ZmhVb2NRRTRhVlMwZFZabXl6bktO?=
 =?utf-8?Q?QM2CSlmD3Ryy+ElOQ5UN3IA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pBwm1SIhoJROnStFDFra4CAtWC8DfvL8fh4oAn62zAeMkKhAu6Zn39foK1Nc/IkFzhACU3aMBWCH7YZoX1dU3IWTgNJ3hlpUbnP4w+SWhOCdiyt4GusrBNaDdY7NJiCwy0TjGXACoDt6qqBrsd2k3GR7610y+ViA1i4ZApf5uwXKOBv7EzPYWBIiBhsJU+G1xS/J86iFvi8w/GTxEfu23O4OU6dqwKf8RnsQtpCYhEsfJiOqm8EXj24pNGzc7dWsGHS+fU6LvdHqTiUj3Eptl0hbnO/nyG+gdrrOuxh5rhjvoudLAKuRHXctrOjZbiVQEM+5w/pddBf8JT94Or+eekm/Fk4xfp1VjXEjIl31WLXijQChxjtlVfZRYwo0J37qF9jjCi5wj8gXt3DOO8aOw4kn4C8H6s4Bmz0pjPz6dRG6aB9h7A/yBv75axmunqtvW8hMykWxRjcgo1CHF0i2eMjAhDid3ttI7/aGYDyLyywManHzLq/23k3FO0PtYWzF8wg6OecbvDfu5MFAJltG/4UA+t4r2mF/Bm4X4/+xaZwlSu/UVcT6DvxsGIEKqlVy/8D8Tm2ou7o7hrHNENodiQbBljd2wrectzZx8Az9Iy0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6defa545-d908-4a05-a893-08dc8309d319
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2024 13:42:20.1457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AKp41zNTuF/KTMjDXN+uGSDxI+1/OBHX50Br5K3aNW19CFg5f/kf/Kjhmdp19Vln+5J6WptI9S090e24ui93Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4295
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-02_08,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406020117
X-Proofpoint-GUID: necxZZT-4TxZWMQkLIk0aWIgvr5Ud5gK
X-Proofpoint-ORIG-GUID: necxZZT-4TxZWMQkLIk0aWIgvr5Ud5gK

On 01/06/2024 02:59, Andrii Nakryiko wrote:
> On Fri, May 31, 2024 at 12:04 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Tue, May 28, 2024 at 5:25 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>
>>> Share relocation implementation with the kernel.  As part of this,
>>> we also need the type/string visitation functions so add them to a
>>> btf_common.c file that also gets shared with the kernel. Relocation
>>> code in kernel and userspace is identical save for the impementation
>>> of the reparenting of split BTF to the relocated base BTF and
>>> retrieval of BTF header from "struct btf"; these small functions
>>> need separate user-space and kernel implementations.
>>>
>>> One other wrinkle on the kernel side is we have to map .BTF.ids in
>>> modules as they were generated with the type ids used at BTF encoding
>>> time. btf_relocate() optionally returns an array mapping from old BTF
>>> ids to relocated ids, so we use that to fix up these references where
>>> needed for kfuncs.
>>>
>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>> ---
>>>  include/linux/btf.h          |  45 ++++++++++
>>>  kernel/bpf/Makefile          |  10 ++-
>>>  kernel/bpf/btf.c             | 168 +++++++++++++++++++++++++----------
>>>  tools/lib/bpf/Build          |   2 +-
>>>  tools/lib/bpf/btf.c          | 130 ---------------------------
>>>  tools/lib/bpf/btf_iter.c     | 143 +++++++++++++++++++++++++++++
>>>  tools/lib/bpf/btf_relocate.c |  23 +++++
>>>  7 files changed, 344 insertions(+), 177 deletions(-)
>>>  create mode 100644 tools/lib/bpf/btf_iter.c
>>>
>>
>> [...]
>>
>>> +static inline struct btf_decl_tag *btf_decl_tag(const struct btf_type *t)
>>> +{
>>> +       return (struct btf_decl_tag *)(t + 1);
>>> +}
>>> +
>>>  static inline int btf_id_cmp_func(const void *a, const void *b)
>>>  {
>>>         const int *pa = a, *pb = b;
>>> @@ -515,9 +528,17 @@ static inline const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *
>>>  }
>>>  #endif
>>>
>>> +typedef int (*type_id_visit_fn)(__u32 *type_id, void *ctx);
>>> +typedef int (*str_off_visit_fn)(__u32 *str_off, void *ctx);
>>> +
>>
>> let me take a quick stab at implementing type/str field iterator in
>> libbpf. If I don't get stuck anywhere, maybe you can just rebase on
>> that and avoid the callback hell and the need for this
>> callback-vs-iter churn in the kernel code as well
>>
> 
> Sent it out as one RFC patch (which unfortunately makes it harder to
> see iterator logic, sorry; but I ran out of time to split it
> properly), see [0].
> It is especially nice when per-field logic is very simple (like
> bpftool's gen.c logic, where we just remap ID). Please take a look and
> let me know what you think.
> 
>   [0] https://patchwork.kernel.org/project/netdevbpf/patch/20240601014505.3443241-1-andrii@kernel.org/
>

thanks for this! Looking now...



>>>  #ifdef CONFIG_BPF_SYSCALL
>>>  const struct btf_type *btf_type_by_id(const struct btf *btf, u32 type_id);
>>> +void btf_set_base_btf(struct btf *btf, const struct btf *base_btf);
>>> +int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **map_ids);
>>> +int btf_type_visit_type_ids(struct btf_type *t, type_id_visit_fn visit, void *ctx);
>>> +int btf_type_visit_str_offs(struct btf_type *t, str_off_visit_fn visit, void *ctx);
>>>  const char *btf_name_by_offset(const struct btf *btf, u32 offset);
>>> +const char *btf_str_by_offset(const struct btf *btf, u32 offset);
>>>  struct btf *btf_parse_vmlinux(void);
>>>  struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog);
>>>  u32 *btf_kfunc_id_set_contains(const struct btf *btf, u32 kfunc_btf_id,
>>
>> [...]

