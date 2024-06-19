Return-Path: <bpf+bounces-32530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBC890F562
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 19:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF02F1F213D3
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 17:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB52155C8B;
	Wed, 19 Jun 2024 17:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k/EF4PdT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gQzi+sjD"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0043477107
	for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 17:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718819021; cv=fail; b=iuo3OwijGgp+exju0XZN4us54csViiiWDU7hNxwT95RkKnKtxHcnOGLLRrKKnxKmmrCIKQ0nkmO1r8VUixyPCMxag83Ska1a2FfnzLF27U4WKf1JJjxi1/8H3TsElMR7xSIF7V13s4xfroaFMJCLKDI8LYBoxNYrSloUSFCb/tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718819021; c=relaxed/simple;
	bh=4TOIiYOFOwk5VWRiqGXPR7hKtFMbQ+N+SW4bxEzSRC0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XcVT6lMalVwhpt/3IA8tF6bOjt+39Ei2FppVwH5MuF18mDhfGu55+Y7TUTgZssc7ExtsbAvEQmwqXd/2AAP3KX3FhO1jGdB3BIZta6C2S5mQzDeREamJWd56bxcfYCVnpJLGmQw4CuqLFvqecm0boyIrGndq6KvLk2wHJIF1PPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k/EF4PdT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gQzi+sjD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JFBQgp026145;
	Wed, 19 Jun 2024 17:43:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=F4/FBt6TRmOJZifAaCL0lE5rieSvKN9y5C/pej806Ww=; b=
	k/EF4PdTx9jQhBtlmhzeGcCX+emsuPc6UBmbk2JDVvM6+9xQlXgQDViDjTYMCpGH
	/4+0etROLm/4f9uw9OMi/wQK1b4NdyVIT6ztHyBaRh8d6RWIv0alTGzhXaRktTK4
	EM6xPwRI6TwNrwdygAVE4eFfLgsO9NEPbo+72WwLeHL8/+CWthpo+6l39mMb5i8G
	X8bD9Y6HfP+9gbrCW06KDh8Opir6oLg/h5XpWpWb3K8lcCv8dTrbOlc7ZwYlq87v
	tJspaIypOCDdGu/bVsN0sFxS5FtSPdzMusXVxY1BEy+B1+nYksnQKaX2yhrc3ZEc
	2X2b+tzJY7vj4Qjg+hR1Uw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yuj9n9qy0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 17:43:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45JHQBLX032890;
	Wed, 19 Jun 2024 17:43:06 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1d9jat7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 17:43:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMmNFCnty0c6CFFjz7VhwaNw+Z2ztDrS58Ew/sCpp+WgjjPsWF4lYPY0o6tSYbuEJl8Mol42pS1dPZpnC4TnkFlUQdLjivruo0ZE5hC2N6an1+BCY5R6pfNLNedIvUyVDRuMvRkoCbgH+EZ5QfpdiRaYsAgj0B32oB7hgqIw/NgUn/5TNWE1Ttd7ADTRdbwXqeGRwXauuPOr0/Eq6pmr4utmv65Qnyn7rpeX5bIfIFI5PS+0lf9rtKNvY+pwz46X7tKwliIv0HYuviQeGRkjHzUMsTKPYeG+hapIjoLK3eTgMujN8DV0vUep8/sljsVSW4UPZkl9jVbz9p/DnXJy2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4/FBt6TRmOJZifAaCL0lE5rieSvKN9y5C/pej806Ww=;
 b=SOJMgh9B+X5kN4q7bodjRE5RvO2pKzo5iKoVdhKLy/9bYqGW3q0gwBs+TOzvfcZ6bK2wfz62ntEzT3d14Q+f0wKmIqXDCs/x3MkKW/EGh1AV6KWlnPXKbP6P2ADi7YPY44PPYzXrwY/6GRhbcoWL3OI777nZGHU/sMEXWZOhvRjUjy0+swyF9cB10NuJ6BBWG6E/chrPei6giHwOR/8ArvRBLl2pwfxRoav9HFhIW9a6KdEC6xeZx5tnxaTvZPV9jPVeaRkFjJ1PhrvrwB5MpY8cxLgBGcILXEB+xnbVLB2epzebsTqep5noUC56fFpAu7HfNUqkPYNemIfRS+2Y0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4/FBt6TRmOJZifAaCL0lE5rieSvKN9y5C/pej806Ww=;
 b=gQzi+sjDTEp8tcRYqd3pE5gkwWlWIEtuGwN5A2pFd9eydXuu4jF8SBNsmW9ZZgNqR9prD/8i8+SC8TP2fqtP7bUMBYmJUy5B4sarMME/kcK3F7xeVFBpCkY03uIgJMZ/u3V6EGb1kdgGLS6x6MP7fe6xLiiEI/mgsNidVh69UmI=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SA2PR10MB4780.namprd10.prod.outlook.com (2603:10b6:806:118::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 17:43:04 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 17:43:03 +0000
Message-ID: <9359e765-c341-4164-90fd-78feafed89d5@oracle.com>
Date: Wed, 19 Jun 2024 18:42:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: add kfunc_call test for
 simple dtor in bpf_testmod
To: Eduard Zingerman <eddyz87@gmail.com>, andrii@kernel.org
Cc: acme@redhat.com, ast@kernel.org, daniel@iogearbox.net, jolsa@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, mykolal@fb.com, thinker.li@gmail.com,
        bentiss@kernel.org, tanggeliang@kylinos.cn, bpf <bpf@vger.kernel.org>
References: <20240618160454.801527-1-alan.maguire@oracle.com>
 <20240618160454.801527-6-alan.maguire@oracle.com>
 <4321b99db5b362e278b1f37d6bd9b9a43d859d63.camel@gmail.com>
 <76509fc5411e35a4820c333abca155b3fa4e5b84.camel@gmail.com>
 <44779d5f-6d54-43cb-b556-d62201765c9d@oracle.com>
 <3396181b67ff82ba8d25a620a72353989d733fc2.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <3396181b67ff82ba8d25a620a72353989d733fc2.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0467.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::22) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SA2PR10MB4780:EE_
X-MS-Office365-Filtering-Correlation-Id: 145541ec-9e92-4a7f-36e0-08dc90874545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|7416011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Qi96eVN0UTVtZ2dxMGJrYVZsTm90b29Nc0RQSXZmSUo0eEdjS2VmcFZ2bUc4?=
 =?utf-8?B?WWI5cWw3dG04M2Q2RmhDNi9VdXdPTmpiTWpEUDYzSVBYYUp3WllJNmV5Rlpv?=
 =?utf-8?B?VDJjTFNHWHZ3NFg2dDNRUmMrOVE1a1NZdzFTUjVCS091UHJRb0Jibm9NdTFD?=
 =?utf-8?B?U0RidVNkbHQ5R2I5WWhTWVM0NVBBUlltU1R0b3A5Zkd3RDBleUZva0diYzMy?=
 =?utf-8?B?Yks3S0EzZTgrTGdESlJ5TEJ2QU5ScnhOVUhQVExQWlc2YkMrMEJEVmhBZDU0?=
 =?utf-8?B?UzlqdVhGU0I4UnQrcWxCKzFGcTUzcWc2aWpLT3piK1pmUlNETW80RWdzRnNV?=
 =?utf-8?B?UTNuYm9iUlljaWhudVJlbS9yRmloN2VGT3ZJZU9UKzBMWjd5WGIvSXh3ZUJy?=
 =?utf-8?B?UmJGR0dJU285NXMvalJoWnZvOGtqS0c4MFdlZEFvekU2QitCL29GOW04cEQr?=
 =?utf-8?B?aUFOa1EvVkc0WVYyRHJkRkRlV3BqWHA2bk9xUnl2UzFIRFltdjNGYmNTVWli?=
 =?utf-8?B?ZXpTajdOQjBIcGxKMDNVVjJWSnNqM3lsUXBULytMWUoyRE0yRFdsc3NJOTNH?=
 =?utf-8?B?ODlXK1pJVHZUVG1PNXd1dm40azUrRWpvdXBRMlJxbnR0Q0hoaXJiWmc1dk1u?=
 =?utf-8?B?MVZDbm9wd21LQm5KZHlXMXFmOGhRdHVWb1Z1Q0NYV3l6K0JTNDdMYlBabVJu?=
 =?utf-8?B?U1NDSHJrQ3NvTlY5UjBmY1JYR1ZYVWFmSW5LM3I3MVN1czJTNDAwQmthZWVl?=
 =?utf-8?B?cGZyLzFyZ1E2cWVRSUNXbHhibVU5UUdmdWdxYmUzQVBKKzJzb3ZhNnJRZ3BD?=
 =?utf-8?B?azhlS05hQ3A2cU9CZWNpQUZPL2VlZ2ttYzEwRDJoVE5iNmZSZnRpclNnRFdy?=
 =?utf-8?B?YnQxb3BxdUdIS0FFUTJVT0d3Rzc2bmpGUlJ0b3hvK3YySTBJSitjT29qaDJE?=
 =?utf-8?B?SjFYWXJtcXFzNlVMY2ZLZ0tFYm9oQ1c0VDZCVS9aRTNWcGZNWUtOUlJTOGJx?=
 =?utf-8?B?TSswUDFTdCtXMkNEenlScHZjSE9ENnRYSjYvL3ZUdWFzenlnTW1CUEI3SGk3?=
 =?utf-8?B?N0p5MlVpTHpDSzU3NndpVXVtQ3Y4bUhmSzU1VnoweTduS3ZOaG1JemJlLzEw?=
 =?utf-8?B?VEZ5RHoxVjhnZStGeFZibDArWVdneVJnaityMzNNYUtRUnl1Z0tzSlNRem92?=
 =?utf-8?B?OWZhRjVZRWdUSmFpaFNGVEc3ZU9Ca1JnMU5TcU0yOUNUVDJsVU80aVp2cEd1?=
 =?utf-8?B?QU4yNVNNRUcxbFFmcEg4TEo4YTdBN0hKRlNNaHJXWDNUN093eC9qV1JWaXQr?=
 =?utf-8?B?NjdYcG9rWmxNVDFLeUNiQ3pHQzBmY0h0NlVrNlBOTG4yeFNENUNWdzRYZ2dE?=
 =?utf-8?B?NHp1cURRdjhUK0ZKWVJUNUhYMVBrSklCcWtjVXBiN3d6MnZTN1g5WWMrbW4x?=
 =?utf-8?B?SVhLN2d5K3kxUWp6UUZuVGNkUjJTYkhyR3FQdjlyTHhPTmZlUm8vMmp5UzhM?=
 =?utf-8?B?aXlIL3Z3WW8xSEY1NXBMbnA5MnlmcDZkcWRNVzhLVkZuZVNtR1pLbnVFK21W?=
 =?utf-8?B?TXNPOWNTbS9aUE9qeDMybGdKQXQ1TlV3a3Q4N0JJUmx4YVNUWFZzNGpxeGV6?=
 =?utf-8?B?MXByS09SalRhVU9xUzY4NDFhYU83dzQ0MGI0REpaMEZuS0RqcUNuNk80aGxx?=
 =?utf-8?B?Y3Z6b3hMRHNHY0laYW9pOXNyNHNGWTVVNDdDKzFiQ2Q2dURVUzBINTRBYzBG?=
 =?utf-8?Q?EErs9nnMbpbGRi0d+7xLxx/jkISF1sH3u/+mqaN?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bFpXaWRxY3F4NG5vNzJlamVTUUx5aVpZanJDNEE2ZDdUMU1tb0hsSjhYYVdr?=
 =?utf-8?B?N0NjeUZpQkhSdDgvM25PRVYrS2paUnZvWXdGdkcvZXhtOXduT1Q2ck9jZjlz?=
 =?utf-8?B?c2F5SzhBd1ZCZ0VhTnlpVTVBdFAyLzlEbkJqYVNlMjh6MUllK2VJU05ZQ2dB?=
 =?utf-8?B?d211SmZkREQ0Q1ZDTkhmblFHa0swQldEYndUL2txQTJWY3hFUzVMbmhBdEpp?=
 =?utf-8?B?dWd2MEtSaDlzS2pXb0x0WldFMTNCYUdnWGxjeGZXd1QxeUgwZk54WW02Yk5G?=
 =?utf-8?B?bk5qdmI2dHh2RG1xbzRSRDE0SnFBc2E4VEpCOGtRaDJUZHNwWFEzY3Vyc09j?=
 =?utf-8?B?Y1N5bVB6bVpobEVDekU5WTh2blZZVTQ1aHZSRHNkcEY0Q1NKMGxVTGRBUmlJ?=
 =?utf-8?B?bjVMb0tXNE9vdS9uWnJqY3A0Y0RQdFlONWFHSGIvdnE5bW4zdE14ZG8zYzAv?=
 =?utf-8?B?cWF5ZWI3NXZ1aTBjWDBIcElxUWpVSTZVRytzOExWWGIxTWFFT2lMSjNXUVE2?=
 =?utf-8?B?WCtneUUwOWMvWU1vUGxtVUwzY2hoQ2duamFjV0RKcm9Jb0gwejd6WWRZM2xj?=
 =?utf-8?B?bHBiK3BTcmFId1ozbGh1aC94VXlzd3NvbHN1QUI0TE0rYXNJallPQnJabGNH?=
 =?utf-8?B?OXNtdDB3SWRibjhidXRUT092UWJNYlQ4akI2dmROYkJPN0ZZUVRtelZrTEh3?=
 =?utf-8?B?N2ptWGhFdXBwNisrd3UzZzBHN3ZTWFEwWDhsb1BZZUN5emR2aCtoYmcrTlJY?=
 =?utf-8?B?YXoyRkEwQ3poeUJyMDlqNERNU0QreGZXKy83WnFxMnByL2wvalg1TkZxWlpJ?=
 =?utf-8?B?T04zTnJJZVFYSUZZRS85UUQrNjhRRDRyUHlvdEVGZTQvanYzYXp4REtHSzJ4?=
 =?utf-8?B?RFJNZXByRjVsNWJ6cFZVeUx5MHhLWFk1TFhnWFBlUTgrVHJIVXorQWs3M2p0?=
 =?utf-8?B?L01TVHo1RjdVbVdiQkR1V2xlbHc3V1Y0eEZPTlQvNmxMSFNOSWlPRXJ6TUxJ?=
 =?utf-8?B?dURkaUQ5WXp3RmUvN0dVS0dRNFFBQ25EVVZMVWxtS2JzUTMzSFJlcWtENWg2?=
 =?utf-8?B?Ymo2S0swWm4yYzhycEQyWDR1R210R2RnbmhvYVNUMVZ4aFFwVTljNi92RjFi?=
 =?utf-8?B?QnFBL2ZVQmcwNFdIdS9qK1RmOVMwZi9pRThLcjhCVU9wMkVHZ1YrVjBxS2p3?=
 =?utf-8?B?aU9heENXbEx4TitSUm9zeE42bHRYbFBXT1Nzc2t4ZFNpbEcrSVkrL2E5ektv?=
 =?utf-8?B?RUc4YXhHa2tlcmRZdFpRNkRwN21LYjdKeE1JakZGTS9lbEVHdUlKTXdwNUhW?=
 =?utf-8?B?ejRsWFhzaGhISWt3dWNpbmkwbkdHSFZya3E2b3l6TG5BNE54U1JoT3pQU1Vo?=
 =?utf-8?B?V3RFM1NSamtybHRkdGJXYVNTeUx1VGhtcDdvS055QmpjYXE5NTRLYnJxbGtM?=
 =?utf-8?B?RXJhYUtzb1lJV29BcEU3OE5yZlBTa1N1b2RtUGhsVTZrTHBHSXIzcFRaMVU5?=
 =?utf-8?B?TlhuWWNJdDQwL20ydExWZURPaWRteDRvQjdHV3pEaXMrZTNzcHgxRXlaelVH?=
 =?utf-8?B?T1hKZFdLNHNaOGVVYWppcjlLWCtUZ0JPVjZ1czhiK0dkdU81UFZwdVg1Zk5z?=
 =?utf-8?B?cWpaM0RzRHU4NjdEcFY5MEhyUk9EUTBJVUcxbE1nNFE0bE9ucHJhWENzVnNu?=
 =?utf-8?B?ck1aZWZxeENSNXg0TWd6TnR0ajF1VDRWK01GM1AzazloVmtHRDhzRU44ZVV2?=
 =?utf-8?B?WWZSWGQrV01yMDBwb0tFU1JRZ29ycUZ1aEhsRTdDZkpMYnNrbFM2Qmk2cm1q?=
 =?utf-8?B?ek01NEpaTk40VHQ4bFI3N1p6NGkybmRMNk5XcjRQUXFyYWdQTm1wMmU2WUox?=
 =?utf-8?B?UVk2ZVIzNjJteEJpTEJuNFg0VFptQ2trZkZ2MXJUdGl4YXlnQUpIcW5iNCs2?=
 =?utf-8?B?ck9WVmlVYTh0aExZM3BVSlNaKzZyYkZ0WTY4dHlWUTdDdk44UjRzZzdsUUVK?=
 =?utf-8?B?Ym9CZ2k5ZTJOSnd5VlBhNWtqbXJFblEwZUVwS3Z4d1BsUzlTN1poM0VyTEk0?=
 =?utf-8?B?R2IzclhDQzY0QkRCZUFNMEVHaDh6NlU4R0lZMjFVTFFLQU5hRnZ6ak50eXpX?=
 =?utf-8?B?aUEwMXJLbm5FRWNNRkpLd293SFZzNUV0eVR3bXdPVUdtbk5BajZZZ0phTWRF?=
 =?utf-8?Q?AzebqjkWiCARKfzWeZP6r0w=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6KSW/fWcK46CKrwCR5DJQRcl31RRbjrqXuT8CfIBsTWcWklsTnuMribyKlhGqywSgg4J4npW2TfsnbectDMLAl4jbsNuRzW0DZ6JjLO+e4PsGl26fHiaclRyKVR7mJ7SnW/B5VwaFyxoCekkBTVhEzcd3WzQee9e1EN5Tbl1g6+Zgb/XwOFvAHRIRiuw1z9mTt0km6qIzjDoozrNs4zb84GvikdVc7F/7JpzxaKnXrJqGsAW+8zps7WOmaN0BchTqyT552r+uynwP8RhmTaf+Cu1KDdiFhiep5Qt5EFrYRSFUM1vhCEottyHfe12qXGc3OmXANSHJhP9CqKR191sy9tBPCNllqHVhtnYn65OR+Rb6TZaYyek1R8L2ESlOV3gTiBPpaF9l82HB/z8YI2wQ4svkpfb74e9GF4fSyCK0s3ppaYn7/HHM8RGetGqbssBLOZEOLRwvcF3Wt3wxwu0zvn11oTtKK3CrSTFn+K0WeYaHT1zfIm5LyGpzLR6WabpFwluZyG9i/g8BegQav8WdlWn3Z108nV9Ozma1f4X7Is3F3NiAeIMjeRWujdaR06cLlOhn3s3e/OV/aTBP+9V82P1jOyFp87PXTtqGqQ0Jck=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 145541ec-9e92-4a7f-36e0-08dc90874545
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 17:43:03.8580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDZDMdkmqV3id6WnuPi/33P05dH4tXclsoK2O7oL+sQvIXafFh1jO2U1MLjqp1mVlb2zYH65MFECR7YMhR1bgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4780
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406190133
X-Proofpoint-GUID: 4IqjNqXXtd8AA4Fq5F4CwE9Mn9FE8qHo
X-Proofpoint-ORIG-GUID: 4IqjNqXXtd8AA4Fq5F4CwE9Mn9FE8qHo

On 19/06/2024 17:54, Eduard Zingerman wrote:
> On Wed, 2024-06-19 at 17:45 +0100, Alan Maguire wrote:
> 
> [...]
> 
>> oops, missed a GFP_ATOMIC here to avoid possible sleeping. To use
>> existing kfunc call test structure it's simpler to do this than add a
>> sleepable test context I think, especially since the focus here is on
>> adding a basic test. More below..
> 
> Hi Alan,
> 
> And I agree, GFP_ATOMIC should probably help and it is simpler than
> adding a sleepable context.
> 
> [...]
> 
>> Yeah, my focus here was testing the registration to be honest and
>> thankfully as you noted it caught a case where I had forgotten to do id
>> relocation, so thanks for suggesting this!
>>
>> To trigger the dtor cleanup via a map, I came up with the following:
>>
>> - call bpf_testmod_ctx_create()
>> - do bpf_kptr_xchg(&ctx_val->ctx, ctx) to transfer the ctx kptr into the
>> map value;
>> - only release the reference if the kptr exchange fails
>> - and then it gets cleaned up on exit.
>>
>> I haven't used kptrs much so hopefully that's right.
>>
>> Tracing I confirmed cleanup happens via:
>>
>> $ sudo dtrace -n 'fbt::bpf_testmod_ctx_release:entry { stack(); }'
>> dtrace: description 'fbt::bpf_testmod_ctx_release:entry ' matched 1 probe
>> CPU     ID                    FUNCTION:NAME
>>   3 113779    bpf_testmod_ctx_release:entry
>>               vmlinux`array_map_free+0x69
>>               vmlinux`bpf_map_free_deferred+0x62
>>               vmlinux`process_one_work+0x192
>>               vmlinux`worker_thread+0x27a
>>               vmlinux`kthread+0xf7
>>               vmlinux`ret_from_fork+0x41
>>               vmlinux`ret_from_fork_asm+0x1a
>>
>> Does the above sound right? Thanks!
> 
> It does, might as well set some flag in the dtor kfunc and check it in
> the program (using another map?). Tbh, I thought we could get away w/o
> 

Sorry, I'm not following here. So I think what you'd like is a way to
verify that the dtor actually runs, is that right? The problem there is
that the map cleanup gets run when the skeleton gets destroyed, but then
it's too late then to collect a count value via that BPF object.

The only thing I can think of is to create an additional tracing object
that we separately load/attach to bpf_testmod_ctx_release() prior to
running kfunc call tests to verify that the destructor fires on cleanup
of the kfunc test skeletons. Is that what you have in mind? Thanks!

Alan

