Return-Path: <bpf+bounces-27555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0928AE979
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 16:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0D161F2319F
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 14:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA8784A54;
	Tue, 23 Apr 2024 14:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JRu/nK9b";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rJTKmDqB"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF7219470;
	Tue, 23 Apr 2024 14:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713882658; cv=fail; b=GfU3Ms5lU0UCgLPN/ylqd2L6Y8br8zFsCQEU39tzLyN309qLFYDt0kg5Xi3Fs2VStf8gGyyDa/QoOLqg0mmeScUOYQNqHopS4j49UDhg04EcScJgnNUlRXolm+D7Jq6FrNa+37FCRNYi96UkHJc6CwMDXbMnf4j9hL5SmBXZMX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713882658; c=relaxed/simple;
	bh=rnqUKJal3GVVBHepyXKErhTZED27AYrtgNDXs9hZ2js=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j5rxe/depyoYLd4NoPG98wI7c5CvFctH+VmvBvpeyalRMEEinUAjC1Qsb2uHMmOZxTSQ66Z1fa7i9U/j0zoO1G5rJkD2460J2OpXQzA78uXFOYE6gCTa4XVYRmcAi7SATpm80amcTXi3sqmTFJWw6n3kYmf/FT9dltKdDNBQEbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JRu/nK9b; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rJTKmDqB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43NDwxEE016604;
	Tue, 23 Apr 2024 14:30:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Kxv+D6ArR1k5+dnxIJrh0eLcgOcTxtzVmBjQsZ+3lHs=;
 b=JRu/nK9bOTm9HWJpLXwQc/t0piUemzvaK4DUA1OelOh+YI0r253jdbZ2baRsIS2ceu9H
 Jjtao6y/9pOcC/Caw2+REhUl8fGS+8pvd3g4enZPxytxuAP8NM3yYJuRqaBsaHb0L6UD
 E/iWKfcNIHxJSZN5JRZ8D7MqQutPghmaptv6F/Nj0Gtw+8EzRyFRuHS4UNSY1yYt5jNE
 X5A94fTYRrxhPtjEZ3GXtgbA+NV51VcAQowImnRhPVJcqTgFBqnzgpWGaV8VAejQ312B
 77K9CtfAqOzZkbr/IpV0+RFX6v2zGJtQZiziOnKdv/eMytks5AQQddsjJBJI/8dPgtS/ sQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4g4db7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 14:30:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43NDxFiP030938;
	Tue, 23 Apr 2024 14:30:11 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm457a34r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 14:30:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnM/zx2eoBWGyet/wDu4NiQ1xNMt5T/tNg+zR//kTIVqu+pwSsSq+AxzPJWNozZv9Z4k27EGvsoz6AdumilvbZIDTTrWMkGzt/x/zTPw6NJk15gHChlxt3Eh61qIUcUiMAajEBesYKO5wTEOEBE/9VrMEx99V58wpCpsaugbKNkXEwfHt0o8YujQI8Ie0ELRtFC1USHE5Mu/+RLFVxdF2RGdBSRUY7c/vw0416nls3b9YqlCQ4oUe+5of1igcXK8R9dEbVZ02WT9G3frgYDe8K67yAbi0N0UJPSfomYLUyitRkRnB2AHcb00Nz8461+xC0uD9r/UP1sWoLt56oYP9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kxv+D6ArR1k5+dnxIJrh0eLcgOcTxtzVmBjQsZ+3lHs=;
 b=Vhn9/l8bxx8sUSOCKDnfQEFyHNkbljKEduJS+ivShxER6/7s0m+vINBbuwHJ/g47gjNoTFdBhK9tSgqAGCN967X0YbwgN1pBmBz+2+PD9n4NeYRmUWiU8fwfZ3OJFicW/mTCVb7NsmIJ3v68/hhSHpUdAXQp8nTocUGXI4kNgyhizhinnOmHBdBHncClH/esYOWmVcD0Jvp3GxHmRMsIw89XMSQvaM6reWc73t355eHFfxKh90XiK62mV/mPwVg8DX3bGgb0mej39dzWiPkgAogvuvfBH3VoxUR06Qx7jueJxKJLPESdamzusJY82fzoL0wtKUn07GjMXLOIwrieOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kxv+D6ArR1k5+dnxIJrh0eLcgOcTxtzVmBjQsZ+3lHs=;
 b=rJTKmDqBKMkL9feO6gu5nQomkODdQSIuqPIqzi2jnG1U1/7vSX+0hniMaH+A29LZUmzDwMYGIgGHCU4xdoVQ++wsH5Co+Zv81FM8DTIO10WsnCVVYc2auYOVHeSGu3vSZ0ixJEMSqYH67y+KVjWWYupSmlmjSxKqxaWqFR0f3ME=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BLAPR10MB5076.namprd10.prod.outlook.com (2603:10b6:208:30f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 14:30:08 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 14:30:08 +0000
Message-ID: <a60a0842-cff9-407b-b970-316e615e22e1@oracle.com>
Date: Tue, 23 Apr 2024 15:30:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libbpf: extending BTF_KIND_INIT to accommodate some
 unusual types
To: Xin Liu <liuxin350@huawei.com>, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, yanan@huawei.com,
        wuchangye@huawei.com, xiesongyang@huawei.com, kongweibin2@huawei.com,
        zhangmingyi5@huawei.com, liwei883@huawei.com
References: <20240423131503.361149-1-liuxin350@huawei.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240423131503.361149-1-liuxin350@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0024.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::36) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|BLAPR10MB5076:EE_
X-MS-Office365-Filtering-Correlation-Id: 67b8d56b-16c9-45bb-fdb8-08dc63a1e041
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bkRqd2s2N0xpSkhjK0w1d05vN1E3aXpxZW5FYll4bWVmdVdIaHNCY01LUHNz?=
 =?utf-8?B?T1RKZEw4c1dpbzQwQmM3OGRJWS95M3pxbzNhVnl2UlNLRG5kaUgwdUlZQzcr?=
 =?utf-8?B?UERINGdLKzRlaDNrTU1CaTQzNEdjaDFRK0JHRVc5Q3dsWDR0WkJTaFBPU0hx?=
 =?utf-8?B?cmNwdWJEWmtrbzBoOW8vM3p4VmpUZytucjRaN0cyb0g5Tk1sNVpTZU8wVTJ5?=
 =?utf-8?B?UUJraU1wV255cUdTY0J0VlpOZ1hqcEs3eWJ4N2QrMEZYZjVZTUM2RjFvMVVw?=
 =?utf-8?B?akpSc3hvTTdQcEFVWnVZM1o0TEo2Ujh3OUpKNDB6SFdkcHRVR2RtL0hpNFlV?=
 =?utf-8?B?RmE2K0RjZUlGWWw3aTdyY09mUDByM0lqVzdSaUJXL2F2SzVYNkhlY29aTDNE?=
 =?utf-8?B?d0hnODQ5TmhQcjRpcitjN2JBSFF3bVcyMkJhRnh4UGhDSmM0NlR4S2pFZWxv?=
 =?utf-8?B?QXl3L0Z4YmFWZnFnTVNDUU9welB4cXBTRzIyUFVDaXJuSGtpdDJNN0hkMzdG?=
 =?utf-8?B?b3lvcnRlUzF3UkhZcWhvVUVtRURzc2JlRzdQc0NMajhlTmMycGJ2UTN0SUNR?=
 =?utf-8?B?aWhIMnk1ZmhlckxlL3dsUVZiZEowV0M4WHN3aFVzRnVER0dnbnNJWElDRzFx?=
 =?utf-8?B?V09wMmJUczQrc1V6RDRYSk43RHpKait0T2lCTGlWVGdOd21WSVZLU0JSblJD?=
 =?utf-8?B?dnlLVEpNTmJrakhXUmhOTTQrZnR4dUZvZGNVQkN4cDFaazJPSnRBaGdjU3N6?=
 =?utf-8?B?eUxRU1NCQU9pTUtDd1ZYR3BQdSt2YVZpQ1dmeHovci83TDRFWk8xSXErZmdD?=
 =?utf-8?B?VXB0RGcxS1lONTZQRkp5Zms2QzBDRXRVSFZhZWVPbWZ0LzNwUDRzSmh3QUxH?=
 =?utf-8?B?RGRlRnBQbzJSQVIrM3FXZi9EaWJ4Vml6cjg4UTg2S0VUVUdRbGtVdVB3VWhM?=
 =?utf-8?B?R1krOTQyYlJtc2VuVlFpUi91dUxQN0gvZG4yNWJ0Q2lqZ0dUYTBmVGJ6MXg1?=
 =?utf-8?B?Ymw1TkNrTnJBVEgza1RvOGcvd3VIVSt1djkrckg5SGJuQ1pyY0JKc1orcmdp?=
 =?utf-8?B?VDg2N0RUZ0NhK1lPbFdZdGlaN3oxN3MzeE9FblRmeGYybU83YlFPT2kxbnNw?=
 =?utf-8?B?cjk4SXI4SlVWU0tERnVuQnhaKzBPSmtOUTNRdVNnT2U2Q0hQRk1ELzVoSXBF?=
 =?utf-8?B?TVROZDdDc0MvM0VWK3JUSDYrZkNBdXRUcUFSTllYNkZmZUYycDR5dWw1c0Jy?=
 =?utf-8?B?QzJoVVc1cTY2bUJ2cE9QaWdXZTl4VklQR2hwNXRQRWlIK09INVRINmVCdG15?=
 =?utf-8?B?Rm5mdUhBWkp1VXllRW9CcmZuc0tSTFI3K0VwUk9iQXQ2c2lGZ0t6RWMxZ0d0?=
 =?utf-8?B?ZTJEVjJKVndZU0FvT1VOUThpU0tyNDVrNjRaMlR0MksyTGxlLzRxeVZpNVVm?=
 =?utf-8?B?am4yTVA5L3doM0I0U3p5MWpEYmQ2WEJlSGFBbUFsUk9XSXdZUEtEMkJQc2h4?=
 =?utf-8?B?ZlBBY3NVa2dLTS82L2I0R1AwVkFZU1hWb1FUaHNsV1VWczN5ME42cndpSXpK?=
 =?utf-8?B?VnRzMExZZXdoVFkrUFByS3g5bktQdEQ1MndBSUE1N2F5Z2lQNzJLUk45WG1n?=
 =?utf-8?B?eU5qMjh6WUx5UVBoUlhFNGdVOEd3aVc4UzIwaHRORktsQXRqOFhMdGNzdS9x?=
 =?utf-8?B?OStYVjVKZVZtUzROREdydUZOWEVZMVpMQ28rcjNuaHFjMEZTK3R3WWIyeGw0?=
 =?utf-8?Q?QXyXDOy5LjM+rmoCRtKMe4IVtqtVDBum8fh1oHD?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z1NMdlpTVTJHSGRuN0NDemZtU0o2UlE3eDY1V0lXUDZoQ0RPYVFTYlFva1ZK?=
 =?utf-8?B?SzZOdS9qRnA1SGQybmpyZkhLSkR3UllhQmtvVkNLUlZHeG1hVVZOVDJiZ05D?=
 =?utf-8?B?UTNmaC91djlnckFLeEpEZ1h4eXBkdkNrSkVLZENNUmUrWjZxQ0ZMWEVWWGs5?=
 =?utf-8?B?U3g3TmdQL3BtYmQ4OXJ0czkrNFFjSTY0bDBEYS9vZjlZbUV2aU5QL3JCL0NS?=
 =?utf-8?B?Q0ltTHRWMFVCcnZCaHJJUEo2dzMxazdhTnVUY2NRdHJ3TUlIMDIvK2xzdVhE?=
 =?utf-8?B?ZWxiWUEybUJ3YUxVVmdNVUJHUG02M1JiREVnQzVhK090QlR4Q2QvLzBvQkxY?=
 =?utf-8?B?WEJsN3p6QTNGdDdCUXNjZmZVZjd6QTN6UTFJYlVMYldzb1c1dVZHQUI1dGxJ?=
 =?utf-8?B?ZHBsODFDbW1pZ3NGbDBxQXdEdUpIVk9CVmtVRUhOY2I4b3JSMU82aklaZkxK?=
 =?utf-8?B?ejFZYlZ2QVJ2WTN4WUNITnFDOVY3eEJDaktSSTdlU3ZEYjE1aFVVOXBGQTF6?=
 =?utf-8?B?S3cwaEJSYXNkWEpPSytVRUxaM1YrNEY2WEFOeitERVJUY2VtMHhmNWhwMFVB?=
 =?utf-8?B?UVArYkowMGdLRE5Fc08wenNOS0M3dkFtdy9WR1BBQlhWTTBIOWJMYmhnNENt?=
 =?utf-8?B?NGd5WG5DRnBxMUlvL25LUFU0UVljSHF5SUtKQkZHcWVsRTZkRjc4aGYxYmJT?=
 =?utf-8?B?NlZJK1NxeUEwN2UvV0MyTHJmVGw3bC9RRWZEVmxZZ1ZLWm9ycTArN2phT2Nx?=
 =?utf-8?B?L1dXZlAvc2xKK2J5VmdSYWFwS2xSVERCR05JUkNUQUV1TVUrNE5vMEVqT0lS?=
 =?utf-8?B?ejdXY0o4YWZyRnZ6NzlqOERmYnp5dDIyaGF5aXo3MUV6M1ZvYTVZUHYweTNs?=
 =?utf-8?B?c1Q0RlBuOG9DMTBDbzZVUy92MTgrdUVFU2w3Um9vT0NQUWRRNE9XLzRtOHFP?=
 =?utf-8?B?bW5RNExaTXNWVVNmUzlLY1JldGVZZWgxNEM4WW9uMDhRK09JTVIraWRkU0t0?=
 =?utf-8?B?WXViR2U1Vmt5MTFhc2FIYzRVT3lKaGQ2VDJqNUlOUEc5MVAxN0pRUkxBWmpD?=
 =?utf-8?B?Zi9Xd2JzbVpQQjYzOG5DekYwa0IxdGxYR24wcW5id3ZMaDYwa2Yyb3JWOUlI?=
 =?utf-8?B?MllxSkozQXlzcUpUMUcyMEFGK29WQXpVSFUzbng4TnJrNHQ4aGdkUVFUc21l?=
 =?utf-8?B?Wm9FR2dXUnlnNEEyVFRhRW5vYmp4b256YlF4YXZ2amc1MTAyTW1JbTB2N3Mw?=
 =?utf-8?B?NGpSL3pHR1NkcEoyVlp0UUEwYW9obkxIdllWZllDQXp0N0VsRjlod0xMdG5P?=
 =?utf-8?B?bDY0YWNVZHh2em4yRGxTbnM0RHAwRkNLWmZIWGRjNjdzTzVoMDNzN3dsSENH?=
 =?utf-8?B?KzVMeWVkYmRjRjByNVNiRDRBeXlKbkx4bGg0NFppaitESXgzODMvemt2NVlz?=
 =?utf-8?B?Yk5jK1BpS2RYTGVFc1Z6QVRNQ2lQOGtSWUkrd0VsMHRVZkU0ckgyR2ViOEJy?=
 =?utf-8?B?RjgwMzhwNVVGYTBndU5wWTJlY3lpb3M0cnMzVDVOZzdOaTBOOU9tRDhGVURw?=
 =?utf-8?B?QVhnVUZVS0xJSVNvRGN1NXgxU2tlMEMyUlovL2RxSVVtNUV1Y0JYOWNJaEhG?=
 =?utf-8?B?ZklaQ2JXZ01HekZZMWt3c2graDRWbllLL2V1WGI5QmdMRDZtNzM3a1BTUWw2?=
 =?utf-8?B?OElKVXRnbFg4OTk5cm1WUGxSWGlWTTRnNUgreFFSWUJhaVNHTHdyZWRtbTB0?=
 =?utf-8?B?QmdmTC84c1VOdWNGVlVQRTg2TFZCOWxQbDdoK0tVRjh6S0wzSXdHNGdQd2FS?=
 =?utf-8?B?cm80ZkpTWTJPbGdZV0FlVUREaGVEV2dNdHVJTHF3T1lYTTM4d1oyRkd5TjA0?=
 =?utf-8?B?aFRvaGE3Y2lFWjJOZ0lmSEVEc1lQalZDa09EVEE4MFJwZFM1RElxc3NhREEv?=
 =?utf-8?B?M3VwRzJvQU5ILytQdFZTVS92WXFSVDJpdUEwMEdWYWRKdGJndGdYK1dobVBH?=
 =?utf-8?B?QzVzU1NHRE8rdFJ2U25xVGRxY3ROMStlclVmUi9tY3N4YVF0ZEU0Q0dhUWRO?=
 =?utf-8?B?bzlqczNXWUxzeEU0dGp2YmtYeFprRXlkUXd1Y3R1dFIra3RQc1pvbkZVem4x?=
 =?utf-8?B?R0I4NEFEL0txbkNhRlFESjh6WGVRK3ZWbkN3a3dsa2Z3ekh2eWJWM3lQdlZD?=
 =?utf-8?Q?Zy6aXNvx1MGn976s5EPTnc4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	IhIKdDbuLXxi7Q8tul5DBOCArt0FRXs+Y+GBMNcIqs/AEm3fLvX9P+BsA988T/jT+40yaCdsgmRsLgMMLYRRZ90ezbDlts4emyUSmIisiPJWdgo/htYE+NSBfhHqUChj6BksDNt44I2l9hj2XqX4m7bQO5QW9VDDDPqb5gTftSFLiSYHdBHLp1X/TOoTcFdSJo2eR+HNHKUOxy7V/vjxR8Br7tcGch5APwvxi5uF9Fg3S1zl5RWi4cQGRXBlz9MRaPdcs+zavvRySuKunCWTjA3nZ8Leeo7pGSVNqNxnXCMQihthf9Fffy1LoYwNmPhvweN8+jvuKIbCSALp2AAz4JH3ciJrq7MhxyeJRum1jP92hcntgUSPlCYh3Rt8nkpXMGVNEBfRRRBf6HhiZkU1Uw3j+U5lvE3i/Jo7N4SP5GGQZH5A4kYj6Zy5sTqfMZqwMv1YzAUYGjD6Xt5CPxfm35qOLXGZW8bFwh7+lfwk+bkKMjNOYW/iiYBeCEq8E9cHQPx/Uv/L5wKEAhn6ywTw+Y5+QJWtpAF0PTBZu7hoDkIAWvX4gRqFKIHENBl0tVw/WY5Od1yrLQyc+pfQylEq11FS4W4NDDNIjMJ7tBOi9Vc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b8d56b-16c9-45bb-fdb8-08dc63a1e041
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 14:30:08.5175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vY4g4tizCgh57fZPUjtGuFRy4lfquBpdWqi5UzKZSLMd7qlJwnLYZCie4m6ZOxq9osLxVz0LNgyNbZMIzRK88w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5076
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_12,2024-04-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404230035
X-Proofpoint-GUID: Zk0S1UNzhKTYAPdKvHDH7SeCgEOZ4SRU
X-Proofpoint-ORIG-GUID: Zk0S1UNzhKTYAPdKvHDH7SeCgEOZ4SRU

On 23/04/2024 14:15, Xin Liu wrote:
> On Mon, 22 Apr 2024 10:43:38 -0700 Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> 
>> On Mon, Apr 22, 2024 at 7:46 AM Xin Liu <liuxin350@huawei.com> wrote:
>>>
>>> In btf__add_int, the size of the new btf_kind_int type is limited.
>>> When the size is greater than 16, btf__add_int fails to be added
>>> and -EINVAL is returned. This is usually effective.
>>>
>>> However, when the built-in type __builtin_aarch64_simd_xi in the
>>> NEON instruction is used in the code in the arm64 system, the value
>>> of DW_AT_byte_size is 64. This causes btf__add_int to fail to
>>> properly add btf information to it.
>>>
>>> like this:
>>>   ...
>>>    <1><cf>: Abbrev Number: 2 (DW_TAG_base_type)
>>>     <d0>   DW_AT_byte_size   : 64              // over max size 16
>>>     <d1>   DW_AT_encoding    : 5        (signed)
>>>     <d2>   DW_AT_name        : (indirect string, offset: 0x53): __builtin_aarch64_simd_xi
>>>    <1><d6>: Abbrev Number: 0
>>>   ...
>>>
>>> An easier way to solve this problem is to treat it as a base type
>>> and set byte_size to 64. This patch is modified along these lines.
>>>
>>> Fixes: 4a3b33f8579a ("libbpf: Add BTF writing APIs")
>>> Signed-off-by: Xin Liu <liuxin350@huawei.com>
>>> ---
>>>  tools/lib/bpf/btf.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>>> index 2d0840ef599a..0af121293b65 100644
>>> --- a/tools/lib/bpf/btf.c
>>> +++ b/tools/lib/bpf/btf.c
>>> @@ -1934,7 +1934,7 @@ int btf__add_int(struct btf *btf, const char *name, size_t byte_sz, int encoding
>>>         if (!name || !name[0])
>>>                 return libbpf_err(-EINVAL);
>>>         /* byte_sz must be power of 2 */
>>> -       if (!byte_sz || (byte_sz & (byte_sz - 1)) || byte_sz > 16)
>>> +       if (!byte_sz || (byte_sz & (byte_sz - 1)) || byte_sz > 64)
>>
>>
>> maybe we should just remove byte_sz upper limit? We can probably
>> imagine 256-byte integers at some point, so why bother artificially
>> restricting it?
>>
>> pw-bot: cr
> 
> In the current definition of btf_kind_int, bits has only 8 bits, followed
> by 8 bits of unused interval. When we expand, we should only use 16 bits
> at most, so the maximum value should be 8192(1 << 16 / 8), directly removing
> the limit of byte_sz. It may not fit the current design. For INT type btfs
> greater than 255, how to dump is still a challenge.
> 
> Does the current version support a maximum of 8192 bytes?
> 

Presuming we expanded BTF_INT_BITS() as per

-#define BTF_INT_BITS(VAL)       ((VAL)  & 0x000000ff)
+#define BTF_INT_BITS(VAL)       ((VAL)  & 0x0000ffff)

...as you say we'd be able to represent a 65535-bit value. So if we
preserve the power-of-two restriction on byte sizes, we'd have to choose
between either having ints which

- have a byte_sz maximum of <= 4096 bytes, with all 32768 bits usable; or
- have a byte_sz maximum of <= 8192 bytes, with 65535 out of 65536 bits
usable

The first option seems more intuitive to me.

In terms of dumping, we could probably just dump a hex representation of
the relevant bytes.

>>
>>>                 return libbpf_err(-EINVAL);
>>>         if (encoding & ~(BTF_INT_SIGNED | BTF_INT_CHAR | BTF_INT_BOOL))
>>>                 return libbpf_err(-EINVAL);
>>> --
>>> 2.33.0
>>>
>>
> 

