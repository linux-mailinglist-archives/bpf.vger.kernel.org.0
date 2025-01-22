Return-Path: <bpf+bounces-49465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0BBA18F7A
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 11:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B3033A4FEF
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 10:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81B221128F;
	Wed, 22 Jan 2025 10:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MQMhKZ+r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ImJxFDaG"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66387211269
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 10:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737540847; cv=fail; b=pMP8wXBiG/9GsCrhQ5nr7SWc6TkM4I8+pX4Ov3LzMAxL+c4ufA7KybSN5jApxo6S7/oq/q9iRY2p2/Hbm4+uVx6Kf8XjjnaZv6glg0inHVfd8NvH0pzOZXZeXGTfNlg8a4BkyHfuvZ8wk1sEXtH4tW8bQlJsuRxFk5qoLnrZ+Jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737540847; c=relaxed/simple;
	bh=qhphew6XSbW5LrMoW70fkmqXY58E8kaUHr7KN1U9EKM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l+X3MU6Cg4O7VPwmLzhufkMdRpeLu7Bba/QptB6hjxBNz+pF2UVa3/q2HhlkkTdciYvHDAqko/jukz9DA7erFnIBGppD88jHBJWHim5doHEuFu6jIOZpVciRAnR3m5lnUZTN6QaBl+WmySUQRo0emQTAslDVM+bnYKX/a4SInk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MQMhKZ+r; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ImJxFDaG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50M93B48014322;
	Wed, 22 Jan 2025 10:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=OjoZhvD1UeKTsoP2xjOAUGroABscVlYmSEQD6apDKeM=; b=
	MQMhKZ+rmKPjJ6tvmWSNwuLDb5TNy8CU910AXGPmCLbwkXdbMa6w6RvL8BSOBlhG
	g7h24BKMNupBuv59O7bfh1gROz4Y9evMhtPCVpHEjU0AqwfyRAwFUUKt3SYr8zOH
	e7kdAc7U4/2FeQLVaZeJAfW2joF1T+Skm57DstNCzkTENiUwqX7TOWB1JqHOM1dA
	rxLrbXLqVJJ+GAjSy7wcj53M85Q7zZsHpUSIFKvh1iheGUd6Z5MJU7Bj9E5uQOyp
	9ITLmdgx1NeuNx7TxsJi8r+xcVwvToyJHEhbRtfHw9k5VoEGoCTqLL6KE8VI9PT7
	oz4ZYU3+kXgxro/xDjxL/A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44awpx0417-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 10:13:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50M9FcfM036590;
	Wed, 22 Jan 2025 10:13:43 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44917qnfp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 10:13:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X0kzZiG4HfrBtTg2uKky31fab1P+gpIM+J08OcF16ZFJfHfL1HnkFqv2aHX203hKPyqeNrP04OSGtaDwXwxT0JX46AjbpGHWsAyxQ2N2yaRrg7rXKsLOKYrWCWoNlkArwVsZnEv2weDm/dtgCAFaQl41aLcWoRlTJckddJ3qYjoiDQBX2gEhkl6krxlansguqWEA2mEmhecXECfzXBkk0qaIV3CdNutOJGhRMmmKOCrd18q9eATwAIXZcTPTJycH8FafPg76ZdIfj14AfEDaLwR3xXfkrzAaxfJSUFTNWYTiiBCUubP6loQQ5x3Mk1gLJITFqehqrtKXlpxilsAnwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjoZhvD1UeKTsoP2xjOAUGroABscVlYmSEQD6apDKeM=;
 b=rn/gLaKrTSRIk5W6Zzg4M0HuraHk2RLvGtc0Q08scuHn/CuGIKrHAivyueuUyRVlfNDd9s0wNF/gRr9U3cytPR6hdddGh2s13gavEweGmtdKE7HZL2as1IYe/Ie1ZcxwXtvYzpUr1yYrgOshGgM9J7tCBXcW6AN8yUGVAzazN2BoO+jBKxUnzUwir7v31AFIyTGtH3ER8UGruLs2/JCMgIA+tsDc+RtubqsXxaz63GiNiKG3vVaBl86Qw6kBNz69+/mnq0sJMsuAdsYzX7GtrGFqV1yMuuPR1sF584na1le6O5GrhDBbCK0IXWcu9xdpS+/VGMtH9LgtqWD9KtgnlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjoZhvD1UeKTsoP2xjOAUGroABscVlYmSEQD6apDKeM=;
 b=ImJxFDaGvFL0KwkA1mmYGR1mJAGw32B72XXrMwHPZvgrmzcudicOxCkyQoRTjOz1hyhDasppECwscV8siehpXB70g9HpL15glAkvKVXCUZ9e8F4Am19x4sqrrYVdxpL/DnHMLoMDErRdkQ0TliGH8hQZ7YJBBKs4Uzfz5im9euc=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA0PR10MB7623.namprd10.prod.outlook.com (2603:10b6:208:493::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Wed, 22 Jan
 2025 10:13:41 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 10:13:40 +0000
Message-ID: <4bc39acd-e7ce-44e1-b7c7-ffbeb1ecb4f1@oracle.com>
Date: Wed, 22 Jan 2025 10:13:36 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/5] BTF: arbitrary __attribute__ encoding
To: Ihor Solodrai <ihor.solodrai@pm.me>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        mykolal@fb.com, jose.marchesi@oracle.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20250122025308.2717553-1-ihor.solodrai@pm.me>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20250122025308.2717553-1-ihor.solodrai@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0410.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:83::8) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA0PR10MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: 440c4230-176d-43aa-60ac-08dd3acd71ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2V1dHF6T1crLzQrYVlla3hwVzQyYzhXYkpQMnUrak1nVkpSUENibERIZlNr?=
 =?utf-8?B?ZmhxY1NTdU1GNUYvTHBpamhxSnJOU0dDeHNodFg4R1U1dzd2dHBILzR3YS9w?=
 =?utf-8?B?QTJqN3lkRGtVR2lPY1RzOEVPZHptZEZlaTVLN2VDL2sraURZaVNQempoWklX?=
 =?utf-8?B?SXhzZXhWbk5xVmlVV3BqbHBIY2E2cFdhWnVaV0kwWHJKY2k2OU8vall1OUlB?=
 =?utf-8?B?d05ZVGVPMXhaK2MyK25HOHQ3NEdmL0I4eEc3ZENKeTBqcE9tS3hyOU5pakdK?=
 =?utf-8?B?S1Rjcjg1RThtTHNqUkpSWDl6d1hMWFJYNlRubVovazR6WS9qUlZXU1QzeUhh?=
 =?utf-8?B?YkVDVysyRm1aMm1yWXZUWThDNFBCdCt1U0k2dXQ4YTdyRG5DTUdqcE9JbkhM?=
 =?utf-8?B?RHdMMFVudWlyVFZIaEhqcWF4M29iWVVPc3NBZWhUOU9xY0VIVGR1ZnVET3lI?=
 =?utf-8?B?cldhV2VGY2ZLRHk3S2kxMDRBOXdDMURQTHlMRW4zSFhKSUdQNXhpYXI3emFU?=
 =?utf-8?B?eTgxdWprQ21vbU1xZG5wdm5xUFhTT3dZZ2JjSkNmOWE0UExnaU8za2RNRjE1?=
 =?utf-8?B?Q1JuOVFrY1hZdzBWTXFvVTZWMU5LM0k2a2p6WmZIWFkrcHBVQU5lbEJoclAz?=
 =?utf-8?B?T1IxaEpJSkQ1UDZ5SDBmaHJudWw1YjJ5Zk0wNWp5dDJTZ1RucE9DOHYrOUVM?=
 =?utf-8?B?ODVHSFB3eHpJWmZDSEw1eXBNb2gxNmVhbEllRGlsS2ZUMUR3NWtnWVlLUjIv?=
 =?utf-8?B?Q0x5YVE0QUJNQm1JcitodnpIaXV1M3R4YWlCbXAvK0p3K28xd3V3dEU4K1Bw?=
 =?utf-8?B?TTVYanYzaW9DZ1dyUU5sWmxNTStuWWdvazNPRUFmSks1QVhvNXJxUVlNTzBo?=
 =?utf-8?B?QVQxdDdET2hldEhVTWhpd2FsbFkveExUQit3RkdTUkc2QkZ2Z2l3bVdpY0hN?=
 =?utf-8?B?UnYxMTR0d3VCY250VDNWbTBVc0JVZnJjVm1VQ0dubDVUOGxXS1lCdG9jQXpS?=
 =?utf-8?B?VnBzTmk0eThpNk5lQkVES2lCLzdRT1B0eExvUnVHanhGeWdwRmxzaStMTUR5?=
 =?utf-8?B?S3NwTTl3aElOSlI4dmlucmFYZVVzbzVCUndkT2dxRHNpd0xFejFkNzI2QVBi?=
 =?utf-8?B?RDJ2bGxvcDRGNHZvd1dpSjNDRzJYQjg0M284ckJSYjk1WXp4THE4RjN5SlRU?=
 =?utf-8?B?Q3E5dHdxOFhnZVJIdVZvdmREU0o4N3RRcUcrRWZBR2pOREdFOEZ2UVpJRVNt?=
 =?utf-8?B?K25wMEszdXBVZTFqMXFDV0xLclp3aS9tNTNaa0NuVjBxQVREbVRDYTJpYjg1?=
 =?utf-8?B?eUFJTGttSzNxRlJuMG5SQSsxS2ZVMnZ3UEVPQ2NGMk1nNWpuV21TZWpRY1Q3?=
 =?utf-8?B?SXltSDA3c2NCcUtCNlRUSFdrTW1WUDB0dEh3dEx5R1NnL0xpZlFCN0ZEVkhk?=
 =?utf-8?B?WXV3MWNvcGRpU2FjNTQvMFNxemlDQWtBUFdRTXJjRlMxMXBKT3dPTm5ZKzlT?=
 =?utf-8?B?TmRnYU5IbzRiM2dqV05xbno1UFRVbmcxS25hc3FIdWkzSWc4RkdPT09YSlI5?=
 =?utf-8?B?T0k4bmJLelRaYVlVWG80VjZWekFnM3FkS3E4NGZJN2dxNGZtVkxnQjdzZEoz?=
 =?utf-8?B?SGYyZFl3VzkwNDJGM3hIOC9XVG1WaTZjWGZ5RFZCdXBHcWk0c1ZISzBhaTQy?=
 =?utf-8?B?RldKWXFROUxoNHN6WjUxNEk3REpxMkJ0dlZTanB4VXJYbTkvSDAwUHphcmVy?=
 =?utf-8?B?RWRQVk8xQVdFc1JXUlEzQVNENkhDbkkwS3djcUd3RUFBY3JsSjh3SnBpUXpn?=
 =?utf-8?B?MGl3N0pzdi8rd0o0QTZCQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGZFV3hlNW82THBiejZrUXBQczNIRVRRdkc0d2JLbW8xOUZYRFdOWkludTEx?=
 =?utf-8?B?V0c5MU5uZTNkUkpQZVc4Q2NKcE5PRE9QVU5sbi9CRTBuTGpBcWtpcDFnTDgx?=
 =?utf-8?B?Q3ZBVmQydnB0MlBqdTZNRW5VZFpGTG1sYjVqdHdFcktMKzJCd3U5dGp5cW8x?=
 =?utf-8?B?VXZEQkxRR01MZ25zekdrMHJ1clI2czczRGw2NTF5ZUtENnVab2lDYSsrdFhh?=
 =?utf-8?B?d3pBVEVkSnVickE0bnZENHc1TG94Y211ZkJWZXExbjh6YzFLa3N2cEE2SjJk?=
 =?utf-8?B?bWU4OUJnVHUyanlObnZPRHpwTjQxdVhGR0JjTTQvT1JFTkk0cHlNeXZpMlR2?=
 =?utf-8?B?T2F2R1R1ZjloOWUvWmZyZXk2NlgzNjlSSmhHNTFyNGpMY3JlWjRyaXBxWEY2?=
 =?utf-8?B?bEhQbUg1bUN2MzhHQ29DVWRuM3dTbGc2VWtwNG1jY2dYcWV1aTF6bzFMaC9G?=
 =?utf-8?B?RGswTUVqWk1JVmx2NzVnYnp6cmNYNGpscXVyV2t4Z0hOVU14VmJVdHRVTjFK?=
 =?utf-8?B?V0dueVI2RnBzdTJIaVB0blpkZXF6YXhRTkY5RHdZSVk2Z1lPVDY3b0F1S1Fs?=
 =?utf-8?B?ME4rUndVOVhMYUx0blBacThtMC9oM3J5WVF1R2poSkdWNTJZZVREdFpqZ0Rl?=
 =?utf-8?B?eXRPbTRtQmo1RkZUOG81Q3NMV1JqdTdQL3BoblFQQ2QzeDNoWFlFcHlWMmFL?=
 =?utf-8?B?MExHNlprUVlwUE82KzZLaFR5TDZ3eExxWS9ScG5sREltRnVSL0cvMll5SERY?=
 =?utf-8?B?NWNueE81cVpxZFVya2VoSHVocis2YUIvRjdnMldJVFptaTMxZVd5QzNHUVZm?=
 =?utf-8?B?WTJWRXNhaVVtTkd0a3JlV2c1K3Qzak00K2xHQVBBTXhHSld4anBsR2dETnNw?=
 =?utf-8?B?a3MyemJtYVlMSG5jUUF4amZ3SGx2Wk1Ya0pxWWM0UWNlYThmS1BGZ0dXbVhW?=
 =?utf-8?B?RU1kQW01YUdPZ2FiWlVqbFBVcVdVOWcyc0hUcU51a21Cb2U0QUpLaWVFc2hQ?=
 =?utf-8?B?N1NSSVk0aUErQ21WS2dwVlBBMFNNZ3gyOHQ4WE1aNmUxZjY1S05ZUGpjS3VO?=
 =?utf-8?B?MklQTWl4STVVRS9RZEV5MEVnQVRUZ0I3amFJcjFmOTJlSGtONWkvUTFaYkI5?=
 =?utf-8?B?TURSYjFFb2lSYmtHYmRUUnFEQm5NZElPbXVyM3ViQzVnVnQxY1BJNlR4TVJj?=
 =?utf-8?B?OVV6RWJXb2w3Y1Z4QlFlQ0c2bVpubDRrNGJ4aWY1SzB3MWJWaVpUVi9KVkhD?=
 =?utf-8?B?MXdFOHdBRnpjbFFPbzUrekVFaWN2R0hXR0xUL3NFeXRvQnpGMTRsdmFKOFND?=
 =?utf-8?B?RkZsd014UjFmYWlqZHFWcXFnTHNYRGt5NHZRcW51eGJidmFuOVpXaHB1SGN1?=
 =?utf-8?B?Nk4wZ1lKd25WNnAyTjFMVXdLVHlJbEFYNHJsWGNpVzVRejBET0NYZ1JhVkRj?=
 =?utf-8?B?aTVGWFFuNVQyazgvNHM4UmF1UFBLR2l0clI3b2trMWovZ3ZROExEY3J3eTFt?=
 =?utf-8?B?aTREUXBoc1VNQk9yY08wVHlMUFVMM1lFNXZqSHBuMmFSeUNsM2tmbWUwMHlV?=
 =?utf-8?B?KzRVR1BUdW1uRkdCZ0xKOXc4VDlVMUM2R1hicXZndytmZjc4NjF4MGF4QXVU?=
 =?utf-8?B?ZjZ1S2tIczRzdm0wTFUyUlJPbGtQMDVRWVg0LzNTNXNjRDlZa2Z4djltZCtR?=
 =?utf-8?B?RG1xUU5qMG44NjFONmMxSllxOEkwMFZ5MWtiaE9TcU50WVhXMXdTS0s1OVRJ?=
 =?utf-8?B?SU11RStKdUVMbGNYb0VGdGJzZWJTazRBVU10UzBkTHpMVWRHRDBISjdBT1N2?=
 =?utf-8?B?QjZxeEpMYStNVFo3Q3o2cHgzUWI0NWhiUjdzYW0za3pHRldNd09NMTNPVGhV?=
 =?utf-8?B?RDlEQjdpY2xvTGxQZ2FwYmpMclNFNWxpcEY0SDFCSkpBN0xFOHVvZ3Njc0Vz?=
 =?utf-8?B?TXhYWFFqWGdWOXJEdVNka05leHJXcS9rZnN0VmpDY2dEUUFyS2FNVzNZeVll?=
 =?utf-8?B?WU1ubEZMcEl4TU1rUFE4TEVvRjF5QUVhZldESDZHbDNOSGJGYUs3UER3MWZh?=
 =?utf-8?B?Tm5IK2pTZ0pEMW14TE1lOWJGM1AxQ28zd0lQTE1BbXc1SEdrSFpkaVJiSGVI?=
 =?utf-8?B?UGtjY2hXS0E1bUNTM3F5QTFqSEtqTjlLbzIzL3dVbUhYQ0xHTEtEUnlodTRq?=
 =?utf-8?Q?BE37RHB8EYZnv7Hbhc+Y6sM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2dDUPhjSwpujr91aHE3lDojnDS1Zc+YeEkAvUVbK9zQ39UD5fGhs9ulA9UGk3+xG1cNUzZDaJcfyE6SnjyxIgqsVilBJ15JU1BV4MARRfS5wD9uuFFwSo+eb1dBRHW0Ej2Awcen9qsrrxgsg8fTqD/s1vUVFjfpKaRQDFLBL+PtbPzRmf2ukVvpmBfEIJfMrQvLtZhOkXeDNyr9RIf7bCH4mldtgGJNgM2ERuj76Qx1AAKOG1uBC0YdmfLLqcUNaNZMjflFLiFTszZ/uucrqOK3mI25Y3tvQCZAcrV/jA/YVPPQeSiJBS58yHpIbG1mIpWpCVkqPFBV/0a9ZAv2HSZumqipejgEyJbh5M1OudbAtHMzZtu2O/60B8EwJEraTLDNBNhS96TlP50JKaA7Ki76sHZOwUD6iOQTcoBKYq8rJhrrYKMYEI3LDqzX5HEJRCPqQvLi7urHJC11u/MonQsTiJYu5UxteIq2W5vP8wvKYwY3UJHbYlF26LEXITK/fcJGYkEwpJT/FuVC+C53iQcQsxOjyqS+g+PG2i/CyjkcZ0u/zv3feEzpjto9wilPh2sR6VbExYZV7tjQ6PlA3y5G4iB7TdA6x5hHxTc+XsEo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 440c4230-176d-43aa-60ac-08dd3acd71ad
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 10:13:40.8713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yk7qnkuVWZuv/d2qThYmsmj4Nnd1gr8WKP4YwzwJj7msEnzNXWAHD3fuJJnJT3fvSmXIKX5DafXF34cbhTu2cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7623
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_04,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501220074
X-Proofpoint-ORIG-GUID: Zdzc1XvqbMSWIE0YQAWE3_-8t4DKV_l4
X-Proofpoint-GUID: Zdzc1XvqbMSWIE0YQAWE3_-8t4DKV_l4

On 22/01/2025 02:53, Ihor Solodrai wrote:
> This patch series extends BPF Type Format (BTF) to support arbitrary
> __attribute__ encoding.
> 
> Setting the kind_flag to 1 in BTF type tags and decl tags now changes
> the meaning for the encoded tag, in particular with respect to
> btf_dump in libbpf.
> 
> If the kflag is set, then the string encoded by the tag represents the
> full attribute-list of an attribute specifier [1].
> 
> This feature will allow extending tools such as pahole and bpftool to
> capture and use more granular type information, and make it easier to
> manage compatibility between clang and gcc BPF compilers.
>

sounds good! So presumably pahole will then have a "full_attribute" or
similar BTF feature that will only do full attribute encoding for
kernels that expect the kind flag to be set? Otherwise we'll run the
risk of generating invalid BTF for older kernels with newer pahole
(since those older kernels will fail to verify tags with a kind flag set).

Thanks!

Alan

> [1] https://gcc.gnu.org/onlinedocs/gcc-13.2.0/gcc/Attribute-Syntax.html
> 
> Ihor Solodrai (5):
>   libbpf: introduce kflag for type_tags and decl_tags in BTF
>   libbpf: check the kflag of type tags in btf_dump
>   selftests/bpf: add a btf_dump test for type_tags
>   bpf: allow kind_flag for BTF type and decl tags
>   selftests/bpf: add a BTF verification test for kflagged type_tag
> 
>  Documentation/bpf/btf.rst                     |  27 +++-
>  kernel/bpf/btf.c                              |   7 +-
>  tools/include/uapi/linux/btf.h                |   3 +-
>  tools/lib/bpf/btf.c                           |  87 +++++++---
>  tools/lib/bpf/btf.h                           |   3 +
>  tools/lib/bpf/btf_dump.c                      |   5 +-
>  tools/lib/bpf/libbpf.map                      |   2 +
>  tools/testing/selftests/bpf/prog_tests/btf.c  |  23 ++-
>  .../selftests/bpf/prog_tests/btf_dump.c       | 148 +++++++++++++-----
>  tools/testing/selftests/bpf/test_btf.h        |   6 +
>  10 files changed, 234 insertions(+), 77 deletions(-)
> 


