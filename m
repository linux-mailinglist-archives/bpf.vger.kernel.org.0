Return-Path: <bpf+bounces-31443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEB98FD11B
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 16:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F0A1F219CF
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 14:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6A525601;
	Wed,  5 Jun 2024 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NSRT1+hv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sIYzSuzz"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78E019D88E
	for <bpf@vger.kernel.org>; Wed,  5 Jun 2024 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717598932; cv=fail; b=TQRLhdIqBHE5nOYSwTDSUq+MJnF6bECRdXo1H0iVyONU6rq84CgNDfITmAE/f2Ndx9Wp/hJee2rfBDUNuaxNkRM7IMOQpr+KhjWbxh2Vu8U/tQg0uBtSldkUrlenh8m511WYOT1/qHDwxfikq3XhlGk8pKt9LSmh9RlpqVVChdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717598932; c=relaxed/simple;
	bh=V7os93yCfLiRVPjbFRH0K2rNUDfd1NoDSdXjmHGkJu4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lEe4su/mW2psUqgPRXU2M3jchbmksIf1YyKeTVEhJNSYKE869zgnzIq6fckV6W3hJVgeQdwsPP54hgOeBHbaNDeEO4oD6hPODTOLCjJgeYSayLA4XTKg3em4o24dynPHFPXq0I1xLTQJ2hAbyKh0f0s8juen/Pn13VjHv3ZLxBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NSRT1+hv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sIYzSuzz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 455CMJsr015516;
	Wed, 5 Jun 2024 14:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=NBSFNPeccC6e5bQ+uW85fOHdKw54WHr8as/OzWc/KFA=;
 b=NSRT1+hvsiIEuHQalwYRbDbugd/W7lHHNA4/VpmnPXWI5BLix9yfIs8xQmlmv/CedpRv
 SsO8GXi0Q/p3o+WrViU/IJFQ6V6A4xLAel1+LKo5IPspUBh3CDcjWSUzjrzsXg0F64VL
 idzFpI13OdqER9yvFcIi/rBe+uZ9cSzv3srrkvWPGxsUQSZvI9+rFTtWF9JSuI4xrbDw
 +88065+HJ9vUDgm1H8e9rBX0Eyu75BpJ0cFzAzL8C2yw3eStvgfd3ZfEQn2KMd2NQHTS
 Nc9FwrKuXLKLAC3zJ82kKFtOokFF9slD3i2yDQahpiX9hABGKGEJVL+d156EWOmksbVv CQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbtw9f79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Jun 2024 14:48:33 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 455DSe9p015579;
	Wed, 5 Jun 2024 14:48:32 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrjdu0y4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Jun 2024 14:48:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AIX3OMyDtPtEAP4rTYhD4cAjsgMKOKlTVwidDwdAk9DIn9ZorUj0TbMx0Qlf7s3WZol77uOa0g0pbuGY97Ez2HIPGpWTGc4hNdIVOw6b7QTW6R5ZqiD2OaxvukiY8asEZVF4aAWMJgQC2WblgJajhqR6oQVfpjYDpXRSPZTgXNEru87vst0qxxGMNgzUzWrQT/NCdmut7EQ0Bqj98rCGu0OxS/D+u5rhe/8YRgmIxtLWLpPeLiVALNAObPnlFGr1vrxpEucxjTCWvg++0KwHKnYIS8MzKZloPmjxg+pv1umfwQIe/cZPfa5zZSr211yrtUhJzWEskixXtshZIpYqEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBSFNPeccC6e5bQ+uW85fOHdKw54WHr8as/OzWc/KFA=;
 b=X+ioab9BdTYVkU2l14ZwGWDOGR25R+I7VUXOlKItiQs4zZpmnM312X/g+efHj9I8KO+4O53giPB64qZUnWhn3uQZBPhH6VM2QM/DfwSbuSyzn+7sjqqIq0AC74GMcxPc81NfM3pXVPf/X/0m1SR3H6LoEhHAGKbuGP6N4wMvM0MCaUHVcpqRRjQfYYhkL3VpEMUPkOGK0VNPRKC8GIFHElO+BqvSqDeshaYGdCZSFrtsOFRonlhpwALji0KzAYsw4kOe97nQ32Ku874EU5iwU2APERd26W21HawLuE6wToD2ijzt5NG6MG9l9P/Vz6EY7LMhDxUSd3p/4ryBWgMskA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBSFNPeccC6e5bQ+uW85fOHdKw54WHr8as/OzWc/KFA=;
 b=sIYzSuzzq6YyOu/rpGjsnLDJOBgBHdEXuyJTOuGYZZqtYcBJNoBGhnvBGJglieIF4fYbQqUC1m0jIxciejSoo0Hn91G5jPc+104hQhIVaNYbf09Yo9jpwWJ6RqUetDNAcYXUbDEaovC68iWEYB6/HSmS0ry3seIcC3GQsyTZWK8=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CY8PR10MB7217.namprd10.prod.outlook.com (2603:10b6:930:71::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.32; Wed, 5 Jun
 2024 14:48:30 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 14:48:30 +0000
Message-ID: <0f041abd-388f-4d84-837a-fc288374abff@oracle.com>
Date: Wed, 5 Jun 2024 15:48:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next 0/5] libbpf: BTF field iterator
To: Jiri Olsa <olsajiri@gmail.com>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, eddyz87@gmail.com
References: <20240605001629.4061937-1-andrii@kernel.org>
 <ZmAnWoByxFnBJV4F@krava>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ZmAnWoByxFnBJV4F@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::35)
 To BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CY8PR10MB7217:EE_
X-MS-Office365-Filtering-Correlation-Id: 31b31421-d8bb-46bc-b732-08dc856e90d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MitPTlF3VjlmYW80UW14YTRWU2hDTnYzaURBVWZXVkdOaXhETnFrU2hhWGRq?=
 =?utf-8?B?cy8yaG1taklTQmw2eWQ4dm9ZaWhLQ0xMM2ZCVG95aExTSGN0N0c2SmsxZFgz?=
 =?utf-8?B?TzlXUzhDMVptTW9lUWpwUWxBM29QMHEzQlRFclNQVXZYT2VWREZMTDhodVBl?=
 =?utf-8?B?Qkd2WnMvT2EwT2w5QkhJajVMamRoRmd0T2NJSmtXbHVqTTExTmxGMmhnSm5R?=
 =?utf-8?B?d1krM25jckhYNTZjeVkxUkNsSmkxcVF4Vm16YTA2eVJtMGNoV3VwZldRY25H?=
 =?utf-8?B?UkMraHdmS2V4dUJ0c0Q4Ulp5cHAveTRHZDdPYVlNZk1xbzV5czk5UDcyYmRV?=
 =?utf-8?B?TlZRcWs4NnVkT0oxRytQWHduazZHVm9DYzRlQUxET3pHbUlVMU0rM056cUd0?=
 =?utf-8?B?cmRlb0FEYjBlU3ZxQk9IQVIyN1FyM2s2Q0lGOUtNczBCRUl1eW1tRWtRZzZF?=
 =?utf-8?B?SkdPbThqRjIvbmd1VnE0RjduTkptVm9vcnlXZXpTTzNvcGNNTDZ6T002UjA1?=
 =?utf-8?B?WXg1YnE0TlNkakR6LzhtRy9CREpSYnpuTEEwSHVuQ0ZVZ2w1N3ROZ3FLcE9l?=
 =?utf-8?B?U1BTQTZOTFZyVEpPVEZRNnJlQ1Z2QWVqMElDWTc4Wnliem1Ic09QVmU3SlJ4?=
 =?utf-8?B?TWl0bGxsZ1pWenJ6ZmZvS0ozQTd3Q2VGSk96MjBkUEZnNWNEcFA5UzZMVGtB?=
 =?utf-8?B?U0o1T09xWS9DdG5YOGtRd21ncXNXMUx1ekkvcVhpbVJOR0VhY1FtdDg4Y0hP?=
 =?utf-8?B?dXQ1elhUczR4SVZHVTAyV2xwQTBhNEx0ZS9zWHlSQUN1TnEwVGdUVlNDZkky?=
 =?utf-8?B?NEZoeTBLQlQwLytMWlNVbUVNWExZeWxCUjZBRlVKd0NkaEpnc21DbXV3UWo4?=
 =?utf-8?B?bFA3eEFmRnFtWTlXN2lRWHJEd2RxUDh5bmJ4aVVuRnI1OTZIN1h6UElsMzBS?=
 =?utf-8?B?bG1hUThjOXdoUDNYbDl6RFdzUW9CdEtISWprTGdJN3RBM29adlRtcUpyejZN?=
 =?utf-8?B?Q1ZTdnBNampudmlHekU5TUwvTXVFbXNGeTF4Wkkwei8zTjZRNXdGRFNQTkxK?=
 =?utf-8?B?L3ZISnR3MkJhTi9nL01JYmxvY0FXanlZTDlrV2RZNi8vMkVCK1FCdEpXQmpZ?=
 =?utf-8?B?c01xOTVTdUxWRnBiNVZmQUFwUFZYQWZEVTF1Q0srbHlMMjJ0blN1LzlER1N2?=
 =?utf-8?B?QWU4dEl0ZU50bWRSdTRHNW1Vem5TZWN5M2FVVmVNWU4zckFSSTFlVkhCRG96?=
 =?utf-8?B?dGlEeHorUXNFbkdyd0ZYeXV1WkZJeGt4Zm9Ya29XZDk5SnJTU2EzbGYrTjBY?=
 =?utf-8?B?U0JkU0VaZVlNejZuV1Fnazh4QnVsR1dUUExZTGs2cE9aM1JxNFZoV3hjZ3Nv?=
 =?utf-8?B?TDVLQ2NKOU54Smw2QXlUbGlOUVp0SXJOU2IrUTNKY3JFSEFDcFVMOHMxTmV5?=
 =?utf-8?B?SUdEa0JtbE9qcEhHVjJxSjhNMXMvS3NablkxbStqNFRKQlByN252ZzNKTE1P?=
 =?utf-8?B?WW14SnNZcHYrbmZjbDlyMGU3M1ZRQTNNZUowTTRBMjNYTm1yVlo4dmxLYjN0?=
 =?utf-8?B?b0YxZHBZM3llUlVkMTFHZjdXcVpZSzMzSk1MTS9ieENWa09McG9DWXM2bG5U?=
 =?utf-8?B?QXJFYysxbXZXWWpXQmoyY25XcEhzMEhUdnN5SDNseENEZThrMUdNcGVpWTdW?=
 =?utf-8?B?dnoweDhVQ2QxaHFPamFBdEp2bFcyeWowd3FWUjJscERKdDM2dHo0cU1CRUJX?=
 =?utf-8?Q?VtDYHg6pPWRU5Ksr4RBeylcMbhYgj8qnKewuskE?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QWxQNi82SStaOTF0bWdJek5ieU9LOWZERExjMW9zMkhiOFh0UXRGMmZiVEt4?=
 =?utf-8?B?STNFbjAxMERZUzdHUmlRWUErY08rVElvcnlPeUFqQVBnNmp6dndtazRZdWJn?=
 =?utf-8?B?Nm9ZQlp5NmtWWkZOYjdJbEpGSDk4blJZZjZGbHVJYkNYUEVyVE91dlcvZU80?=
 =?utf-8?B?S1BDN1lOUjBMaUttY3BkVktIeXVYSWd0bWtlTWg4Y1R6aEplYk9tYnF6a2or?=
 =?utf-8?B?NmF4WUxFV3g0RlpiOVl3RDZKMEt1OEZSbU1rdlI0UlZkVjZLM0h6ZFpZbEpk?=
 =?utf-8?B?Ym5JOWY1aC82RU9hU1pVTkRpSkRGOGxxd2NLR2NpZDVqZGd4MjVoaHZUTmJa?=
 =?utf-8?B?RWo0N2JOVmxpWUJVemI0YXEyNFQxMklZUlhwcE5XajNnMTRVVzlSYmdHNWNI?=
 =?utf-8?B?ZXFRbFlpN05VMStSZFZ6Yzk0Ri9PL1pJR0gydUJXeDhpVFpKNWNlK3dydkxk?=
 =?utf-8?B?UXVLYkZNY3grV25GRUMvNzczUTdkTnRzY08rNVAvRHFLanVsMGEyVGlTWXM1?=
 =?utf-8?B?TGtLWERNbzJkeGFqNjdnT1JtVTBhWmdLV04xdnZBTjY4OUJBeG9MbmRKMkox?=
 =?utf-8?B?aE13V0NCUXQ0NmJ4N2F2WWZjS2V3L21iTzhXMlVWR1R0R2JhREpPTGIyMXFu?=
 =?utf-8?B?SWdtSFRaSFJtcmlIc0VjWW1ETzBIRWJHenM5dnd6T2J4aWU3cnlsRWJUcmw4?=
 =?utf-8?B?UUpBbnhqSTJkaGpkS2RKbWNaVG1CQy9ZVmlIMG44UHp0Zk1RTEt2bTBISlJQ?=
 =?utf-8?B?bmlTbzNZbEtncksvcTJOaUR0Q2swS08wZmhubGx1cnpDNlpBdDV6M1FIUG1o?=
 =?utf-8?B?YVZGbG95MGtuYWFHdEZBVjJnSHNIV05qc3c3Z3psVnVkeVl5STNxOWIyeTd4?=
 =?utf-8?B?dVk4bTNtSG52UmJVRVd5bGFZRExoMUVUR1o5QmlzOUIzRDhKZTJENFluU2VM?=
 =?utf-8?B?cDNtdlFCUUQyREtDb2JmOHlYK29xU0hReFFwOUVnajlNdzFhcTBGUWZzQVBw?=
 =?utf-8?B?NlZvRTREdzVqamYvSlozaXpsOFk5aHUwNEw3SWJ4L2FwWjRTMzBad1FJMjBL?=
 =?utf-8?B?VVRrb2IzZDlkNnVlaFhKL2NNTmdZdnZEQXp1aVJ6dUZoek9SNDB2UXVWQW5J?=
 =?utf-8?B?RzJaLys5RkNtalVEamFEOEwzdWpma3ZvTXM2UC9IeVpCNzJOaWJndnF1a2g3?=
 =?utf-8?B?L3BneW10VXpLc2dNczY1Mkp0bUhDWlQ1clhiazFocHpGbFdaazNUUXpYSlNU?=
 =?utf-8?B?QWJkaUpHYm42R2JlVjZHS3RVMzZFK0NrMHAxaEs1amRFakcwZkU5cFBWc1pG?=
 =?utf-8?B?ZURveDQxMVFwaHlzZ2sxMlFXTTIxUEVxQ3c4STNtWmFIQm1qamdzTk1kRHAr?=
 =?utf-8?B?bFVhYjgxSmtqN2xaRzFoSmdvTlc0Ym16dmcyTDMwYzlaZ2l5dGFTcXpsUnVB?=
 =?utf-8?B?Ni9iSFZQTG9kOWNTMnFUdHM2OW9qVVN1bjJEaW1QM29SNFhQVDd4UTU0VXp4?=
 =?utf-8?B?eHlFSENOSERzSmlaYVhPZ1RzOFhGTzlQcmRrYmRVT1A0OXhhdmp4T0JtZDdN?=
 =?utf-8?B?bTRvNlNjZDBlZGVDTFp1b0ovNXJTcFF1ZXd6TFhqOUk4WnpBeUI5WEcrclJX?=
 =?utf-8?B?c1hGdWZZbVJONlY0SldrUlg3cTVWSDlXeFZnZzJsdjRvcnFSZDc5bHMwVjMz?=
 =?utf-8?B?c3NidFl2UFV2TjBXb0swY1hyZnBWeGE0SmxrVjR6RHNsS0JSZjE1NkY5dTRU?=
 =?utf-8?B?WHdWdXNvR2lFR09TKzRmTlRlWHQ1bDB1MVdqcnNqbndET0ZGcW4xOGlHbVZ3?=
 =?utf-8?B?cEwvYjlOWGc4c1R0c2pJWXdjNTNPTlpKeXduT3EzQUNzK0N6STlyN2xnMkxN?=
 =?utf-8?B?SHNOekxaRUZkUW43d0F1MjhGQUlRdUtYZDVCeHRmdFUwUk8xS0ZSeWNhdE1a?=
 =?utf-8?B?ekJSN1oxemFjMU1YSnJkUmVMYnp6ckJZTmFlL0pYc1lvMlgwd1VBTWNxWFY2?=
 =?utf-8?B?NmFHWlN0R2tLNDBOQnR0L1M3cTByMEovY1NqWC9NY0ZMRlhaemdKT1NGOWhz?=
 =?utf-8?B?ZXBtZ2lVRmZwRVhPOEJRR3JlRDY5QnYvYUp5SWFRMFoxaTRwNUtkS1VySUZG?=
 =?utf-8?B?YVJnbVpoYXVaYSthdHBVWG44aWYrbXVBLytqSDlEQisyMHB6eHpqL1E0di9x?=
 =?utf-8?Q?eRF7+qMko+9ShGlgfuw548k=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	4B0JeTxVZOzq5W34QORBmFyHFoXQ8ge+aedhIMgx4BElWxou+PgSaobdnZ/TAh2YlPvssfAKeRxvv/Z+ZogJed1jvkoAGMgZTQCRp2aAM4WVbpP/6sXh2+odQaFv0dAaVpg3I+OxhjtX4vvMeypK+FMxY1A/9YrkPnR70sOiaK75eCuxXzyIZec3HcH+BmPTEnBlvHbLaIDerYO4QrTMvNvtoRWAyuK2RgcNaufhQkLPcmhGpT3niGtc77W3swir25AM5jnZ6ShjA0f0ne9QQ4GPMJc/wfLab4IKQ7Ver9159dmdP6DmLFWhZEffFrHvvNlDDxfNxE2MvCgMZxL5Xh+mIGgrCoj3z/Ek1kfXGR6qIcDEuYb1qYxszGZtxEEVvhNK/kZI7BG1JxH3GmwTUs+EFN4UGm0OF6jkw2y49FFVlsn8snjCPhwkdbaijM46PW9kTvv8CJYrkuSrul9Hypf4LhWncLORVIT5S5+5YDmeKFO0Ph5VSjX4izOWG3MDNSWWWynmd6UAgf17Irst4m12L452MXE/y92jA+Il0GEBCLfayfMKroRfdaCI2L75LVpOOk8O3j3BRFgNfPYWwuS6tmtRu1tCrauDNvIeNlg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b31421-d8bb-46bc-b732-08dc856e90d9
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 14:48:30.6396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KF6vJb3lazH/ajPTHYUd/tne4I1xWDl94jU73jUGtltEzCWy7HrNW6NYISuMNjyY35B0SaAE+o9cC4AXqQJACA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7217
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_02,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406050112
X-Proofpoint-GUID: twOK47MsYu8QpLhRhtHhuFnmIHFJw9FO
X-Proofpoint-ORIG-GUID: twOK47MsYu8QpLhRhtHhuFnmIHFJw9FO

On 05/06/2024 09:52, Jiri Olsa wrote:
> On Tue, Jun 04, 2024 at 05:16:24PM -0700, Andrii Nakryiko wrote:
>> Add BTF field (type and string fields, right now) iterator support instead of
>> using existing callback-based approaches, which make it harder to understand
>> and support BTF-processing code.
>>
>> v1->v2:
>>   - t_cnt -> t_off_cnt, m_cnt -> m_off_cnt (Eduard);
>>   - simpified code in linker.c (Jiri);
>> rfcv1->v1:
>>   - check errors when initializing iterators (Jiri);
>>   - split RFC patch into separate patches.
>>
>> Andrii Nakryiko (5):
>>   libbpf: add BTF field iterator
>>   libbpf: make use of BTF field iterator in BPF linker code
>>   libbpf: make use of BTF field iterator in BTF handling code
>>   bpftool: use BTF field iterator in btfgen
>>   libbpf: remove callback-based type/string BTF field visitor helpers
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
>

Retested v2, all looks good

Tested-by: Alan Maguire <alan.maguire@oracle.com>

> jirka
> 
>>
>>  tools/bpf/bpftool/gen.c         |  16 +-
>>  tools/lib/bpf/btf.c             | 328 +++++++++++++++++++-------------
>>  tools/lib/bpf/libbpf_internal.h |  26 ++-
>>  tools/lib/bpf/linker.c          |  58 +++---
>>  4 files changed, 262 insertions(+), 166 deletions(-)
>>
>> -- 
>> 2.43.0
>>

