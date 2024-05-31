Return-Path: <bpf+bounces-31039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FBE8D65EA
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 17:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41AF11F23A50
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 15:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC01177A1E;
	Fri, 31 May 2024 15:39:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F21524211
	for <bpf@vger.kernel.org>; Fri, 31 May 2024 15:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717169964; cv=fail; b=EEPXhcENg1S56wjdvH3Hk6bHbcfweK67Qap/EwAwcT+4jvBSp6X3/WCKWPpbWwdLnK80ZhoGjgL/+/JWQGObU9y9iz3pRBGIiT8HXd4JLImfiEKvJmiwkMS+DVmS711X3y+R1dVqijMQ0jFneGvv92wS/UEiVSloQZa6mUfnbj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717169964; c=relaxed/simple;
	bh=FWi7WHGxf8Na6x4iogDVCn1bo7UCGrQMAldvQLUfn90=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JCOh4e8vVYBUAk498g5YAAoA8yBjtGML7k765KoaqlEQErjOvmRjZxVmbBMW25MymBSh17mWTrQzYCu0/CpHj/TvMgs3UwP8jiL0VkkU8K4iyTakkutB6EUIokrzD8dk3ydDNNk9vVz4UsOjBK9E1cg09zLpNZNiemQuJfAMcso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44V9Vadm025199;
	Fri, 31 May 2024 15:38:52 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3Dh6M+dWU9hJiKmWoQH23B7Z3Ur+/05ZhoUNJhMiq4eSQ=3D;_b?=
 =?UTF-8?Q?=3DOXpEx19zvk/+nJLkh/nVBBrQHbNsR175TSoYrK+lO83Lp8WCWbOapwABNeDe?=
 =?UTF-8?Q?WBzS/MaU_3OPHyl0OYc9zYeI5sH9+qxMStLwaR30W+FtjF95uHFph1KBD7DdTP+?=
 =?UTF-8?Q?W/ag8sORYQbWMf_FRjMcbjNacOAnuNgWgrSNQeGT7Zh1GcV6Bbj/X2CoNQ1bNLo?=
 =?UTF-8?Q?ZqxfrbS+62o5Bl3Dji94_zKJGQmq0TKt9s1ivoh17gIcTxXKUTJCVQsWU6hZ60r?=
 =?UTF-8?Q?KAn6yweC5Qru/T2ctOBeUSYsup_qg1d8G0i4D5mEMqyjRlgXU09xC09sKldDjDF?=
 =?UTF-8?Q?ERuYydhw516YGwFNOH1mngCn0Qaf3Gsf_0g=3D=3D_?=
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8p7ubv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 15:38:51 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44VFUwMU019262;
	Fri, 31 May 2024 15:38:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yf7r2m3b8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 15:38:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SrkVQS7rXlZAcQVTLEBbHBzMDggnwhHsvoz36zJ6ms+N/klqObN12Ipb7dqC2AzBQWXlH0QPAEQ1ELVhiNFng1CB/dV/eUll/UKF30gNArDISxGgkE4qsKaGufaSN9wf3R4hO6nREWhY9hP/GeLmtbMyrmU9um0DuIKxTXhTNl3EUEjgEP85nVBFPqp9XDM6FcoKr/ftyBXSN21yKyEPYz3PQeJmS84g9SzlN77vFeT/Fdv2ggos90SOVPmAs2dnEOr1UfP94IDsTQTibG1juNJ6HtwIEXHndVZvTCuYHeZ/maZHQ2OwK6uqOa42pwKUyXYVkpkGjrF87vOnRvohGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6M+dWU9hJiKmWoQH23B7Z3Ur+/05ZhoUNJhMiq4eSQ=;
 b=IgLEXcZHSL2evLC0Gwl3GzxC7Fr3exOAVSNIehmr2OYrPqnP+akPUtLC5jxk8Nhy0tQMtubkaD00CfwFLU8+uR4jsfAAvS5SsHRbexpBpqbw5OygiwysW+k74FM4F5S08BzP6ukg6/lJ6l8dzw/jzsHvRTh2ZgtKXfz43f3t6vy49RVhRzP3Qfmcdkpx7BNbQ9LpzOT+xfeytkZMjSF6buAWO7D+d/GIEz3DLRZ00REhHXlomrnvjoj7gVW4XvZV9Ti7YnLEdz+jZwwzSJ3OhTfLu1Yd3LZ8v3PR7c8XUAwMBJNF/JpWrW3q/SMFOYOxX3naiLTfMjsq0QEzer3+eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6M+dWU9hJiKmWoQH23B7Z3Ur+/05ZhoUNJhMiq4eSQ=;
 b=dTID+rr1uHkrlapHG9gW7PmMFW1ZgIBL+NUnrq9FwPMa+f+vOJlkxMEAeyLYN1jojZMVLcV6JGMAwcI+TULwG9OCv7rfHJCdDVvn8++Lz6zjirScAKo3m/aOTkFlvCtMn7H+3PQge7yVWwmei6bQCYeZYhE3dCVvO0Y2KUj0HA0=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CO1PR10MB4658.namprd10.prod.outlook.com (2603:10b6:303:91::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 15:38:47 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 15:38:47 +0000
Message-ID: <843d8e77-080c-4211-b7c7-dd6918bef901@oracle.com>
Date: Fri, 31 May 2024 16:38:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 bpf-next 3/9] libbpf: split BTF relocation
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, houtao1@huawei.com,
        bpf@vger.kernel.org, masahiroy@kernel.org, mcgrof@kernel.org,
        nathan@kernel.org
References: <20240528122408.3154936-1-alan.maguire@oracle.com>
 <20240528122408.3154936-4-alan.maguire@oracle.com>
 <7da6ec1c366bb7b5461b10eeaaa75945b74815be.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <7da6ec1c366bb7b5461b10eeaaa75945b74815be.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0039.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::16) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CO1PR10MB4658:EE_
X-MS-Office365-Filtering-Correlation-Id: f3aafe3e-ba9d-4b2e-4b50-08dc8187c305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?K2J4ZzhJaTYxN2t4aGxKV2pDSFl2cC9BSi9ra012M1lLTVk1ejh4T2ExTUhq?=
 =?utf-8?B?YUdyeS9kVDErazljMis0Ums2ckFuUGdRMWdIVjZJcGI2dkFhL1hlU3dPNnBG?=
 =?utf-8?B?Rm8xV2hja2VxNEpuckM2cHJKSFR1U2VoWTNobXR4N3lvWDJrQTkyYzFnZnF3?=
 =?utf-8?B?eEt0dDc0YlRpeDhrWWN3RThHWFBGenFmYnBudklVTDBvVUd5NDNJR3VobmZH?=
 =?utf-8?B?cHNYRlJIamMyU1JrcjRoL0VTaVpXMkNVRzhNZzhHcHd2eGx2aFZQdW5ubjV3?=
 =?utf-8?B?Y0g2RGkxdkFxM3A1YUVuNVAxZHU0TkphbEhWeW1sOW0wcW5uY0pIUzhQZnBN?=
 =?utf-8?B?MG5zSUxha1RsYnMzTjFOOWFWVFppVS83NTdUcnJJL0kraUg2ZDd6MXdyaXFy?=
 =?utf-8?B?MWhEMjgybEdmUzhDR0FSZUYxZHZZTnRIZlJEZUhkQXJ5VUN2bWRPanB5YnNT?=
 =?utf-8?B?SXhwak1GdlNsdTY5bWl4aFNCMGMzbG95dXQ0TTNqRWt4a0dFaWhzTjJuWkxN?=
 =?utf-8?B?V25KNzkvMXBEZWlvUGlYaU05Qzh1U1dKMTQ5UDFwUWFDL2Ftd0xHNDQ3M3hs?=
 =?utf-8?B?UkwwQ1dkM1lQeXpxanRpZXNpT0pocWlvMjJkcjVUNTIydkJJaUNMa0FuT3du?=
 =?utf-8?B?RWR2WndFTnJHdDB3Wm1EOGtJNnFhSkJDUGRweVJDbENCYlhtTEpodnlWbTl0?=
 =?utf-8?B?cWpISi95SW9sNzU1Z3dPdHB5c3J0RUxQR2pnR0JaUjhhZ1Yra1psMmhHUnln?=
 =?utf-8?B?RHNhSnJqWjh6MzhDN0lQSjZxWGVXdUhqWGR0R1FxVEpFTktqWTNBNjVBQmU5?=
 =?utf-8?B?VGgxZi9POE05Ym5sMUNWaFRkVjN6cExQWGFuYjdPaTlJcU44bk9tczR6dlBM?=
 =?utf-8?B?TVFpbTdhdEZyMGpWVGtzOUFxampzSzVZNFdOM2lUc2U5VEp0dytyaXJzZGpV?=
 =?utf-8?B?cFVqeDh3bC9WVno3QXdReU1mUGJSaENLTkpSMEhWdzlqTEpVVm1IMnlONzRm?=
 =?utf-8?B?U01PcS9pbGpQZ3U3cXVLMW5jdGhzeXJ0aGVxekIrTUV0a2FPdzZrWlk3M1Bl?=
 =?utf-8?B?UnZlNGhoMjZQSXk5ZVBOWXlGblJHeVBYNzR1VjlhSHhpaU00ZXlGcW9wbjdn?=
 =?utf-8?B?VjJTNU41Z3pIZTJXK3ZoOENjdmFYc3pxL3BLQWRBd0E1a0pZS1RBcE1VRitS?=
 =?utf-8?B?TVg2akN1VFlnZlhHcjNpMVVXOGFqY2c5b0tOangwdWZ6NERSQXFuaDJtWk9H?=
 =?utf-8?B?QmFqbGQraEIzcEpVclg2MW1LZmhSVUNNdFJlSDcxS0pIa0pleWJ3VmJQKzZ2?=
 =?utf-8?B?MDFxU1JIdVV1N1hKVHVNY2R4YzFXZmtwc21ZRi9GeFp4ZldBNHVuMFNKMEJP?=
 =?utf-8?B?dWcwWTJMWDVyenB4VXdXdVBvVHVFSjFWeklJQ0Mxc2RvQmF4ZlJBTkRBN0xJ?=
 =?utf-8?B?QTd5OHkzY3JzOW1iMVI2b1pMVjJjK3F6cUQ3aWJxcUZBR0N5VENidmoweWlL?=
 =?utf-8?B?dE9SZU1OcFFSQkREY0hwZEtSSGs1R2ZIL0JCMDQ0OVRyZ2dhcFNYY0NJTEJ0?=
 =?utf-8?B?R0k0MzZBOGpLM3VZb2Y3ZXFFMkUrNDBHbXJSVHg4ZmV1b3U0c2NjTDZIMEsy?=
 =?utf-8?Q?spBF+9pjEJMcYqlNlJE6XF5X7u2KDjw/r2GyUlAneplQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MlRPbnNoSloxbVYzNzNQZTFoZC83Nkg0K0ZDUDFCaDF3QU1sb1ZwWHJ5MmtS?=
 =?utf-8?B?dmI5bTM1S2dnOW8wQ1Z4aUFWbE9Cd0tWRlhJUGJJZjRGblVBWENqbFdqZE13?=
 =?utf-8?B?WEVLUnJtSGt0czdGWUNkUEdieGxVcG82SzF0RkNRQzMyZ2poaVRVeXJSM0FU?=
 =?utf-8?B?b1F0SFJlaVhyWHpkOURNSkpxWWdhZEtjVEVJTGhrc21RK2RWQnFvT1RRYlVC?=
 =?utf-8?B?ejk4MGtkYjl0dVlOTWlTOHpkZFRKbEN3VzRSMWphUVhLd3pycE1DeGpwMjBD?=
 =?utf-8?B?eEdoenJYVndUaWVReVFlVGgwT2tkb3VtS01sZHg0N0dES2U4SGJvQnhWRFVL?=
 =?utf-8?B?emJXeDJIWDUrVERzUFRvK0xpSHJpc0tSMWpZSnRpK0VTUFJ0amxCY3FURFJk?=
 =?utf-8?B?czdTU21ycGZLYnNSbDB5c0NxR2RKS21xVHVkTnloQ2xMc0xoV21xa09qMU14?=
 =?utf-8?B?QkdibzM1YWdmbzZmRGYvZjNWaWRleXlqZXgxRURDMFNMK2dNMWR2OGRNMWQ1?=
 =?utf-8?B?QW9LUXQrSnlCaHhVTlBESWVOSldzSU1vNFQxd0F6eXFmL1YrcVFXS1R3T1Zj?=
 =?utf-8?B?ckYxQ1hSclNvZmw4SHp3a2t0TlVONU9XdVdWWGhGdlhrMDJ2OS9UVTVOejU5?=
 =?utf-8?B?WENFdmtteGRxT3NKOEpmTDVYR24yUXRrQUtNekV5dXp4dElSck1xdUt0S1pk?=
 =?utf-8?B?QjVJcjRSajZLczkvb1lzOUk4L1lWWkJPNjUzd2Zqams5ZFM0KzJzZ1JINlhO?=
 =?utf-8?B?MlNSMFNMa215bXkvdjZPZFBPUDJxenZPUnRQdmp5bkR6TEQ2a1V3VGo3MFRO?=
 =?utf-8?B?UFlxa3l3QU8vOEw1S1dzVFNCdFN5dUFDUkxqdEFlYkNOMmw5cE5SbVVxemNs?=
 =?utf-8?B?VDlSTFpUUTlVWmlZVUFHVFlIYW1OeWx3OGRTZjRGckIzalFQMWdsemlZcW9q?=
 =?utf-8?B?MHZrVWVRd0V4NitDeFNJUGpHWmtCZVM4bzY5U1hSYmRLN29Ld2c2QlpZRGZM?=
 =?utf-8?B?NG1HMVo2VWhJWG5uVHZESjd3clIrY0VpL1RZM0htOUdhWXBDazB1VzZkM04r?=
 =?utf-8?B?RVFXTklwZFRBRWoxTFhuQ3gwTDQ2Z2hvY3NOd2ZqU0ZWaHBrNnkxa05TV21Z?=
 =?utf-8?B?SWczZkp5aWVGWjJoY0RWOTl6Y05vYzlINHFTS1VIdzVqMnJMOVpFRW4zOVpz?=
 =?utf-8?B?bzIxZXlENW1KdUgxdE5tVy9FMjYzengzMXk5TjNuTE1RRmo4RWlmZVBld29a?=
 =?utf-8?B?RU9WRTd5dWEvZVdzZURhZHJuNmplODBsNVhLeHVzRTBIeTFFOFA0b0tKYlMx?=
 =?utf-8?B?ck9HL28xZDNSRW8zRThtNG8ySHFMWnlpWExydWlBcm40ak9qRjN1T0ZQMHBZ?=
 =?utf-8?B?UnJCaTRvV0hMdUFTMk5wOFZPT2J2N3VrRFh6eXc0elhMQ3dTbFE3T09NUjF5?=
 =?utf-8?B?L2g5bTNHMFBEd2p6OUNickZ6N01rU0tUNXhwR2QvK3cwckppNFJlS25KUFpJ?=
 =?utf-8?B?cW5TcitCeTFFQjRvSm9LYS80U01XK0ZGTTcrQU0zanZZTnJPSXJRWDgwaHZK?=
 =?utf-8?B?MTdYOVB2bDZvU1RkWENyVXg3U0lHQkxjVFRwWENjclY4SzZoRDVzU09IVkdh?=
 =?utf-8?B?MXhkblFsUnRFeklpQTVuODRsZkp4QUlvdHNYNmgxNjJ1WE8zZzB3NVB6cDlJ?=
 =?utf-8?B?MFYyWW1XK2Jsbld4UVVqSUFhMHpTQWw2bk5uRjhkWWlhWEsxeHRySWIxVDNa?=
 =?utf-8?B?aW50eERyU09oZ1pabXF6SXlsZjJhblNyNmtLUUNORG9KVjN2c1U2bEdGdU5o?=
 =?utf-8?B?SDV5Z081cGhhTWNWdTVwYjYyWEpmR1VSV0pBY21TYVBDKzBDc3pkVm1uY0V2?=
 =?utf-8?B?NWYwWDBZVG5ONGZiRUxUejdXRjBmVXVzRnFaYWcydlVhdk9RbEJxdTZqMlY3?=
 =?utf-8?B?bkg2RFY3N0RCVHVQbEJPQW53UHh6UW8xTFh1M0JlVm5RQlEzanQrR0xmTWFL?=
 =?utf-8?B?OEorc0ZhZ0R0UkJmWUYzSFdSVXZKcjBzRzF6Q0RsVkp6d2VHWitUMURIQklN?=
 =?utf-8?B?cHc4Sm1pWjFFQkprSjN4QUNIdE16WG5GUjBocDNJUTdaT1loTmRiRU9rN1lz?=
 =?utf-8?B?anpuRlFxWVlsM2NsNDAzOVF3QmJ1OWFFMElPNlZ2VlNQc0V4OURRMEtwS2NQ?=
 =?utf-8?Q?SpIKEcHEmdX145mBxP3FZ6c=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	roMJUOwOBKO/C9BtwwKAYbSX1URkAQjxFoVThOXflM/0q/mT+fS8pOhS1sZLwy+opZbcfQ1SQ33PS9it2PQcGdX4oCeyVDX5Kqbh5kmdLrAjU1MvEYxus9fqOew3dtDm7tNRYZY9o8fxoYjeDeflm/0C886i0jQ+d9DHauHVnYWnO6iRib5oZycFeMpZlEqHDq43Oby/h0sVOewijqbhElg1yWiPN1FU4roV3ANQBNdC3jqavDpkj0hpC9R3LFQh8q7ggFtza6qMT0qkOquICKvB6BxgsdFq+V+WFOQI0nx1pk2zil1FBPiPWtFpJT7W4KtAee8BGeG82yrmHkD494llUMmnytK5YOiSrHxw37z1N7rC9ewRXb3Xgw9QZdYkCootePnkzTFakw9J95s213c14WOaWKm15P/F6KX3CFdl9tq4+8AVDAEteI98etIwYARJS50HSbQeJfKDKyuOh4oGaNL5FG4Siog2o2va6KabOzxPj3anCmJqjsYftdQWvUZZCLky8GfmTkX4R2CVs/TmkFT3KqUMa34f75FSct+6kCgIdiSjcNKjWaYmUQgPMO35YUgm3uV3zqa9RtaBjFZapwLzFlAXkctmPwd5css=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3aafe3e-ba9d-4b2e-4b50-08dc8187c305
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 15:38:47.4152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yYf7UAtCnxw2syJueHmDr3/vx+LHPBjD0GfdIUKmiD5AYzQ/BYjLJRXwXkAb0Z4vWXDGjLAw4Gz0LFroIk39sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4658
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_11,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405310117
X-Proofpoint-ORIG-GUID: h5mEh0QPI_pqjDT6bf08RNm93-4j0sWw
X-Proofpoint-GUID: h5mEh0QPI_pqjDT6bf08RNm93-4j0sWw

On 31/05/2024 03:22, Eduard Zingerman wrote:
> On Tue, 2024-05-28 at 13:24 +0100, Alan Maguire wrote:
> 
> [...]
> 
>> +/* Build a map from distilled base BTF ids to base BTF ids. To do so, iterate
>> + * through base BTF looking up distilled type (using binary search) equivalents.
>> + */
>> +static int btf_relocate_map_distilled_base(struct btf_relocate *r)
>> +{
> 
> I have several observations about this algorithm.
> 
> The algorithm does Base.Cnt * log2(Dist.Cnt) binary searches.
> However, it might be better to switch searches around
> and look for distilled {name,size} pairs in base btf,
> doing Dist.Cnt * log2(Base.cnt) searches instead.
> Suppose Base.Cnt = 2**20 and Dist.Cnt = 2**10, in such case:
>   - Base.Cnt * log2(Dist.Cnt) = 2**20 * 10
>   - Dist.Cnt * log2(Base.cnt) = 2**10 * 20, which is smaller
> 

Hi Eduard,

I crunched some numbers on base, distilled base BTF to try and flesh
this out a bit more.

The number of struct, union, fwd, int, float, enum and enum64 types in
my vmlinux BTF is 14307.

This is 11% of the overall number of types, and it is this 11% we will
be searching distilled BTF for matches (we avoid searching for any other
types as we've previously verified that our distilled base BTF only
consists of these).

In terms of distilled BTF sizes, I built a kernel forcing distilled base
BTF for all 2708 modules to help get a sense for distilled .BTF.base
sizes.  We can sort these by .BTF.base size by doing the following:

modules=$(find . -name '*.ko' -depth -print);
for module in $modules ; do size=$(objdump -h $module |awk '/.BTF.base/
{ print $3}'); printf '%s %d \n' $module "0x0$size"  ; done |sort -n -k2

With this process, we see the largest .BTF.base section is

./drivers/net/ethernet/chelsio/cxgb4/cxgb4.ko 15732

...but most others are much less than 1k bytes in size. The in-tree
kernel modules probably utilize more kernel types so I suspect give us a
good sense of the worst case scenario for distilled BTF size.

Examining the .BTF.base section of cxgb4, we see 609 types.

So in this worst-case scenario I could generate, Base.Cnt = 14307,
Dist.Cnt = 600

Base.Cnt * log2(Dist.Cnt) = 14307 * 9	= 128763 comparisons
Dist.Cnt * log2(Base.cnt) = 600 * 14 	= 8400 comparisons

So that looks pretty cut-and-dried, but we also have to factor in the
initial sort comparisons.

The in-kernel sort reports n*log2(n) + 0.37*n + o(n) comparisons on
average; for base BTF that means sorting requires at least

Base: 14307*14+0.37*14307	= 205592 comparisons
Dist: 600*9+0.37*600		= 5622 comparisons

So we get an inversion of the above results, with (unless I'm
miscalculating something), sorting distilled base BTF requiring less
comparisons overall across both sort+search.

Sort Comparisons		Search comparisons		Total
======================================================================	
5622	(distilled)		128763	(to base)		134385
205592	(base)			8400	(to distilled)		213992

To validate the distilled numbers are roughly right, I DTraced[1]
comparison functions when loading cxgb4; as above we expect around
134385 across sort and search:

$ sudo dtrace -n 'fbt::cmp_btf_name_size:entry {@c=count(); }'
dtrace: description 'fbt::cmp_btf_name_size:entry ' matched 1 probe
^C

           107971

So the number (107971 calls to cmp_btf_name_size) seem to be in the
ballpark overall; next I tried aggregating by stack to see if the
numbers look right in sort versus search:

$ sudo dtrace -n 'fbt::cmp_btf_name_size:entry {@c[stack()]=count(); }'
dtrace: description 'fbt::cmp_btf_name_size:entry ' matched 1 probe
^C


              vmlinux`cmp_btf_name_size+0x5
              vmlinux`sort+0x34
              vmlinux`btf_relocate_map_distilled_base+0xce
              vmlinux`btf_relocate+0x1e3
              vmlinux`btf_parse_module+0x24b
              vmlinux`btf_module_notify+0xee
              vmlinux`notifier_call_chain+0x65
              vmlinux`blocking_notifier_call_chain_robust+0x67
              vmlinux`load_module+0x7fa
              vmlinux`init_module_from_file+0x97
              vmlinux`idempotent_init_module+0x109
              vmlinux`__x64_sys_finit_module+0x64
              vmlinux`x64_sys_call+0x1480
              vmlinux`do_syscall_64+0x68
              vmlinux`entry_SYSCALL_64_after_hwframe+0x76
             5882

              vmlinux`cmp_btf_name_size+0x5
              vmlinux`btf_relocate_map_distilled_base+0x29f
              vmlinux`btf_relocate+0x1e3
              vmlinux`btf_parse_module+0x24b
              vmlinux`btf_module_notify+0xee
              vmlinux`notifier_call_chain+0x65
              vmlinux`blocking_notifier_call_chain_robust+0x67
              vmlinux`load_module+0x7fa
              vmlinux`init_module_from_file+0x97
              vmlinux`idempotent_init_module+0x109
              vmlinux`__x64_sys_finit_module+0x64
              vmlinux`x64_sys_call+0x1480
              vmlinux`do_syscall_64+0x68
              vmlinux`entry_SYSCALL_64_after_hwframe+0x76
           102089

Yep, looks right - 5882 sort comparisons versus 102089 search comparisons.

I also traced the relocation time for btf_relocate() to complete
in-kernel, collecting the module name, distilled number of types, base
number of types and time for btf_relocate() to complete. I loaded 6
modules with varying numbers of distilled base BTF types.

$ sudo dtrace -n 'fbt::btf_relocate:entry
{ self->start = timestamp;
 self->btf = (struct btf *)arg0;
 self->nr_dist_types = self->btf->base_btf->nr_types
}
fbt::btf_relocate:return /self->start/
{
 @reloc[stringof(self->btf->name), self->nr_dist_types,
self->btf->base_btf->nr_types] = avg(timestamp-self->start);
}'
dtrace: description 'fbt::btf_relocate:entry ' matched 2 probes
^C

  hid_ite                                                  11   124271
       4432193
  lib80211                                                 12   124271
       4445910
  sctp                                                    109   124271
       5547703
  ib_core                                                 153   124271
       5803176
  bnxt_en                                                 147   124271
       5846436
  cxgb4                                                   610   124271
       8081113

So the overall relocation time - from 11 distilled types in hid_ite to
610 for cxgb4 - is within a range from 4.5msec (4432193ns above) to
8msec. The times for relocation represent less than 50% of overall
module load times - the later vary from 11-18msec across these modules.
It would be great to find some performance wins here, but I don't
_think_ swapping the sort/search targets will buy us much unfortunately.

> The algorithm might not handle name duplicates in the distilled BTF well,
> e.g. in theory, the following is a valid C code
> 
>   struct foo { int f; }; // sizeof(struct foo) == 4
>   typedef int foo;       // sizeof(foo) == 4
> 
> Suppose that these types are a part of the distilled BTF.
> Depending on which one would end up first in 'dist_base_info_sorted'
> bsearch might fail to find one or the other.
> 

In the case of distilled base BTF, only struct, union, enum, enum64,
int, float and fwd can be present. Size matches would have to be between
one of these kinds I think, but are still possible nevertheless.

> Also, algorithm does not report an error if there are several
> types with the same name and size in the base BTF.
>

Yep, while we have to handle this, it only becomes an ambiguity problem
if distilled base BTF refers to one of such types. On my vmlinux I see
the following duplicate name/size STRUCTs

'd_partition' size=16
'elf_note_info' size=248
'getdents_callback' size=40
'instance_attribute' size=32
'intel_pinctrl_context' size=16
'intel_pinctrl' size=744
'perf_aux_event'size=16
'quirk_entry'size=8

Of these, 5 seem legit: d_partition, getdents_callback,
instance_attribute, perf_aux_event, quirk_entry.

A few seem to be identical, possibly dedup failures:

struct intel_pinctrl {
        struct device *dev;
        raw_spinlock_t lock;
        struct pinctrl_desc pctldesc;
        struct pinctrl_dev *pctldev;
        struct gpio_chip chip;
        const struct intel_pinctrl_soc_data *soc;
        struct intel_community *communities;
        size_t ncommunities;
        struct intel_pinctrl_context context;
        int irq;
};

struct intel_pinctrl___2 {
        struct device *dev;
        raw_spinlock_t lock;
        struct pinctrl_desc pctldesc;
        struct pinctrl_dev *pctldev;
        struct gpio_chip chip;
        const struct intel_pinctrl_soc_data *soc;
        struct intel_community *communities;
        size_t ncommunities;
        struct intel_pinctrl_context___2 context;
        int irq;
};


struct elf_thread_core_info;

struct elf_note_info {
        struct elf_thread_core_info *thread;
        struct memelfnote psinfo;
        struct memelfnote signote;
        struct memelfnote auxv;
        struct memelfnote files;
        siginfo_t csigdata;
        size_t size;
        int thread_notes;
};

struct elf_thread_core_info___2;

struct elf_note_info___2 {
        struct elf_thread_core_info___2 *thread;
        struct memelfnote psinfo;
        struct memelfnote signote;
        struct memelfnote auxv;
        struct memelfnote files;
        compat_siginfo_t csigdata;
        size_t size;
        int thread_notes;
};

Both of these share self-reference, either directly or indirectly so
maybe it's a corner-case of dedup we're missing. I'll dig into these later.

> I suggest to modify the algorithm as follows:
> - let 'base_info_sorted' be a set of tuples {kind,name,size,id}
>   corresponding to the base BTF, sorted by kind, name and size;

That was my first thought, but we can't always search by kind; for
example it's possible the distilled base has a fwd and vmlinux only has
a struct kind for the same type name; in such a case we'd want to
support a match provided the fwd's kflag indicated a struct fwd.

In fact looking at the code we're missing logic for the opposite
condition (fwd only in base, struct in distilled base). I'll fix that.

The other case is an enum in distilled base matching an enum64
or an enum.

> - add a custom utility bsearch_unique, that behaves like bsearch,
>   but returns NULL if entry is non-unique with regards to current
>   predicate (e.g. use bsearch but also check neighbors);
> - for each type D in the distilled base:
>   - use bsearch_unique to find entry E in 'base_info_sorted'
>     that matches D.{kind,name,size} sub-tuple;
>   - if E exists, set id_map[D] := E.id;
>   - if E does not exist:
>     - if id_map[D] == BTF_IS_EMBEDDED, report an error;
>     - if id_map[D] != BTF_IS_EMBEDDED:
>       - use bsearch_unique to find entry E in 'base_info_sorted'
>         that matches D.{kind,name} sub-tuple;
>       - if E exists, set id_map[D] := E.id;
>       - otherwise, report an error.
> 
> This allows to:
> - flip the search order, potentially gaining some speed;
> - drop the 'base_name_cnt' array and logic;
> - handle the above hypothetical name conflict example.
>

I think flipping the search order could gain search speed, but only at
the expense of slowing things down overall due to the extra cost of
having to sort so many more elements. I suspect it will mostly be a
wash, though numbers above seem to suggest sorting distilled base may
have an edge when we consider both search and sort. The question is
probably which sort/search order is most amenable to handling the data
and helping us deal with the edge cases like duplicates.

With the existing scheme, I think catching cases of name duplicates in
distilled base BTF and name/size duplicates in base BTF for types we
want to relocate from distilled base BTF and erroring out would suffice;
basically the following applied to this patch (patch 3 in the series)

diff --git a/tools/lib/bpf/btf_relocate.c b/tools/lib/bpf/btf_relocate.c
index f2e91cdfb5cc..4e282ee8f183 100644
--- a/tools/lib/bpf/btf_relocate.c
+++ b/tools/lib/bpf/btf_relocate.c
@@ -113,6 +113,7 @@ static int btf_relocate_map_distilled_base(struct
btf_relocate *r)
 {
        struct btf_name_info *dist_base_info_sorted;
        struct btf_type *base_t, *dist_t, *split_t;
+       const char *last_name = NULL;
        __u8 *base_name_cnt = NULL;
        int err = 0;
        __u32 id;
@@ -136,6 +137,19 @@ static int btf_relocate_map_distilled_base(struct
btf_relocate *r)
        qsort(dist_base_info_sorted, r->nr_dist_base_types,
sizeof(*dist_base_info_sorted),
              cmp_btf_name_size);

+       /* It is possible - though highly unlikely - that
duplicate-named types
+        * end up in distilled based BTF; error out if this is the case.
+        */
+       for (id = 1; id < r->nr_dist_base_types; id++) {
+               if (last_name == dist_base_info_sorted[id].name) {
+                       pr_warn("Multiple distilled base types [%u],
[%u] share name '%s'; cannot relocate with base BTF.\n",
+                               id - 1, id, last_name);
+                       err = -EINVAL;
+                       goto done;
+               }
+               last_name = dist_base_info_sorted[id].name;
+       }
+
        /* Mark distilled base struct/union members of split BTF
structs/unions
         * in id_map with BTF_IS_EMBEDDED; this signals that these types
         * need to match both name and size, otherwise embeddding the base
@@ -272,6 +286,21 @@ static int btf_relocate_map_distilled_base(struct
btf_relocate *r)
                default:
                        continue;
                }
+               if (r->id_map[dist_name_info->id] &&
+ 		    r->id_map[dist_name_info->id != BTF_IS_EMBEDDED) {
+                       /* we already have a match; this tells us that
+                        * multiple base types of the same name
+                        * have the same size, since for cases where
+                        * multiple types have the same name we match
+                        * on name and size.  In this case, we have
+                        * no way of determining which to relocate
+                        * to in base BTF, so error out.
+                        */
+                       pr_warn("distilled base BTF type '%s' [%u], size
%u has multiple candidates of the same size (ids [%u, %u]) in base BTF\n",
+                               base_name_info.name, dist_name_info->id,
base_t->size,
+                               id, r->id_map[dist_name_info->id]);
+                       err = -EINVAL;
+                       goto done;
+               }
                /* map id and name */
                r->id_map[dist_name_info->id] = id;
                r->str_map[dist_t->name_off] = base_t->name_off;


With this change, I then tried using "bpftool btf dump -B vmlinux file
$module" for each of the 2700-odd modules I force-generated .BTF.base
sections for, to see if these conditions ever get triggered in practice
(since with your BTF parsing changes that allows us to test relocation).
 They don't it seems - all modules could relocate successfully with
vmlinux - which would suggest at least initially it might not be worth
adding additional complexity to the algorithm to handle them, aside from
error checks like the above.

> Wdyt?
> 

My personal take is that it would suffice to error out in some of the
edge cases, but I'm open to other approaches too. Hopefully some of the
data above helps us understand the costs of this approach at least. Thanks!

Alan

[1] https://github.com/oracle/dtrace-utils

>> +	struct btf_name_info *dist_base_info_sorted;
>> +	struct btf_type *base_t, *dist_t, *split_t;
>> +	__u8 *base_name_cnt = NULL;
>> +	int err = 0;
>> +	__u32 id;
>> +
>> +	/* generate a sort index array of name/type ids sorted by name for
>> +	 * distilled base BTF to speed name-based lookups.
>> +	 */
>> +	dist_base_info_sorted = calloc(r->nr_dist_base_types, sizeof(*dist_base_info_sorted));
>> +	if (!dist_base_info_sorted) {
>> +		err = -ENOMEM;
>> +		goto done;
>> +	}
>> +	for (id = 0; id < r->nr_dist_base_types; id++) {
>> +		dist_t = btf_type_by_id(r->dist_base_btf, id);
>> +		dist_base_info_sorted[id].name = btf__name_by_offset(r->dist_base_btf,
>> +								     dist_t->name_off);
>> +		dist_base_info_sorted[id].id = id;
>> +		dist_base_info_sorted[id].size = dist_t->size;
>> +		dist_base_info_sorted[id].needs_size = true;
>> +	}
>> +	qsort(dist_base_info_sorted, r->nr_dist_base_types, sizeof(*dist_base_info_sorted),
>> +	      cmp_btf_name_size);
>> +
>> +	/* Mark distilled base struct/union members of split BTF structs/unions
>> +	 * in id_map with BTF_IS_EMBEDDED; this signals that these types
>> +	 * need to match both name and size, otherwise embeddding the base
>> +	 * struct/union in the split type is invalid.
>> +	 */
>> +	for (id = r->nr_dist_base_types; id < r->nr_split_types; id++) {
>> +		split_t = btf_type_by_id(r->btf, id);
>> +		if (btf_is_composite(split_t)) {
>> +			err = btf_type_visit_type_ids(split_t, btf_mark_embedded_composite_type_ids,
>> +						      r);
>> +			if (err < 0)
>> +				goto done;
>> +		}
>> +	}
>> +
>> +	/* Collect name counts for composite types in base BTF.  If multiple
>> +	 * instances of a struct/union of the same name exist, we need to use
>> +	 * size to determine which to map to since name alone is ambiguous.
>> +	 */
>> +	base_name_cnt = calloc(r->base_str_len, sizeof(*base_name_cnt));
>> +	if (!base_name_cnt) {
>> +		err = -ENOMEM;
>> +		goto done;
>> +	}
>> +	for (id = 1; id < r->nr_base_types; id++) {
>> +		base_t = btf_type_by_id(r->base_btf, id);
>> +		if (!btf_is_composite(base_t) || !base_t->name_off)
>> +			continue;
>> +		if (base_name_cnt[base_t->name_off] < 255)
>> +			base_name_cnt[base_t->name_off]++;
>> +	}
>> +
>> +	/* Now search base BTF for matching distilled base BTF types. */
>> +	for (id = 1; id < r->nr_base_types; id++) {
>> +		struct btf_name_info *dist_name_info, base_name_info = {};
>> +		int dist_kind, base_kind;
>> +
>> +		base_t = btf_type_by_id(r->base_btf, id);
>> +		/* distilled base consists of named types only. */
>> +		if (!base_t->name_off)
>> +			continue;
>> +		base_kind = btf_kind(base_t);
>> +		base_name_info.id = id;
>> +		base_name_info.name = btf__name_by_offset(r->base_btf, base_t->name_off);
>> +		switch (base_kind) {
>> +		case BTF_KIND_INT:
>> +		case BTF_KIND_FLOAT:
>> +		case BTF_KIND_ENUM:
>> +		case BTF_KIND_ENUM64:
>> +			/* These types should match both name and size */
>> +			base_name_info.needs_size = true;
>> +			base_name_info.size = base_t->size;
>> +			break;
>> +		case BTF_KIND_FWD:
>> +			/* No size considerations for fwds. */
>> +			break;
>> +		case BTF_KIND_STRUCT:
>> +		case BTF_KIND_UNION:
>> +			/* Size only needs to be used for struct/union if there
>> +			 * are multiple types in base BTF with the same name.
>> +			 * If there are multiple _distilled_ types with the same
>> +			 * name (a very unlikely scenario), that doesn't matter
>> +			 * unless corresponding _base_ types to match them are
>> +			 * missing.
>> +			 */
>> +			base_name_info.needs_size = base_name_cnt[base_t->name_off] > 1;
>> +			base_name_info.size = base_t->size;
>> +			break;
>> +		default:
>> +			continue;
>> +		}
>> +		dist_name_info = bsearch(&base_name_info, dist_base_info_sorted,
>> +					 r->nr_dist_base_types, sizeof(*dist_base_info_sorted),
>> +					 cmp_btf_name_size);
>> +		if (!dist_name_info)
>> +			continue;
>> +		if (!dist_name_info->id || dist_name_info->id > r->nr_dist_base_types) {
>> +			pr_warn("base BTF id [%d] maps to invalid distilled base BTF id [%d]\n",
>> +				id, dist_name_info->id);
>> +			err = -EINVAL;
>> +			goto done;
>> +		}
>> +		dist_t = btf_type_by_id(r->dist_base_btf, dist_name_info->id);
>> +		dist_kind = btf_kind(dist_t);
>> +
>> +		/* Validate that the found distilled type is compatible.
>> +		 * Do not error out on mismatch as another match may occur
>> +		 * for an identically-named type.
>> +		 */
>> +		switch (dist_kind) {
>> +		case BTF_KIND_FWD:
>> +			switch (base_kind) {
>> +			case BTF_KIND_FWD:
>> +				if (btf_kflag(dist_t) != btf_kflag(base_t))
>> +					continue;
>> +				break;
>> +			case BTF_KIND_STRUCT:
>> +				if (btf_kflag(base_t))
>> +					continue;
>> +				break;
>> +			case BTF_KIND_UNION:
>> +				if (!btf_kflag(base_t))
>> +					continue;
>> +				break;
>> +			default:
>> +				continue;
>> +			}
>> +			break;
>> +		case BTF_KIND_INT:
>> +			if (dist_kind != base_kind ||
>> +			    btf_int_encoding(base_t) != btf_int_encoding(dist_t))
>> +				continue;
>> +			break;
>> +		case BTF_KIND_FLOAT:
>> +			if (dist_kind != base_kind)
>> +				continue;
>> +			break;
>> +		case BTF_KIND_ENUM:
>> +			/* ENUM and ENUM64 are encoded as sized ENUM in
>> +			 * distilled base BTF.
>> +			 */
>> +			if (dist_kind != base_kind && base_kind != BTF_KIND_ENUM64)
>> +				continue;
>> +			break;
>> +		case BTF_KIND_STRUCT:
>> +		case BTF_KIND_UNION:
>> +			/* size verification is required for embedded
>> +			 * struct/unions.
>> +			 */
>> +			if (r->id_map[dist_name_info->id] == BTF_IS_EMBEDDED &&
>> +			    base_t->size != dist_t->size)
>> +				continue;
>> +			break;
>> +		default:
>> +			continue;
>> +		}
>> +		/* map id and name */
>> +		r->id_map[dist_name_info->id] = id;
>> +		r->str_map[dist_t->name_off] = base_t->name_off;
>> +	}
>> +	/* ensure all distilled BTF ids now have a mapping... */
>> +	for (id = 1; id < r->nr_dist_base_types; id++) {
>> +		const char *name;
>> +
>> +		if (r->id_map[id] && r->id_map[id] != BTF_IS_EMBEDDED)
>> +			continue;
>> +		dist_t = btf_type_by_id(r->dist_base_btf, id);
>> +		name = btf__name_by_offset(r->dist_base_btf, dist_t->name_off);
>> +		pr_warn("distilled base BTF type '%s' [%d] is not mapped to base BTF id\n",
>> +			name, id);
>> +		err = -EINVAL;
>> +		break;
>> +	}
>> +done:
>> +	free(base_name_cnt);
>> +	free(dist_base_info_sorted);
>> +	return err;
>> +}
> 
> [...]

