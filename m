Return-Path: <bpf+bounces-78941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C947D2092B
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 18:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D7A2301F3C5
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 17:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBC92D322E;
	Wed, 14 Jan 2026 17:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rGo9VSon";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Wmf9x/7f"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63892F069D;
	Wed, 14 Jan 2026 17:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768412180; cv=fail; b=NxwJaSnKjn6h/HLSB5IOzgu9SGakCZhnYYoYHZteLf8ZDYXl8Q5PcZuFhUmuDGKsmcfajzpZ6MQEBMJtVxzdeoSicOErpxPS2yg6fKm+w8B3ILNEkZS/jLYspB8NMgeYrUp0F/NJ+1hR8/JFVVc3USaKk58GuIzseyUUaQH5ufg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768412180; c=relaxed/simple;
	bh=V5CnlC+KT09TFcXgeuI/tUE9RsYCmKL36xGT2j5bJSk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s3XJhZ7CD7rt+UyKBFuIaZ8JWTdizn6DduvOCbvWywCTNz93xpyUjcNSETZnCIO6Y/hy4eyZIG0mjNJhCbb8SiHjFDZce9fTSCrFyJIAMUcmWQL05TUBeQtGv5RzkgyQzPI9U1PogSm/yL3U542S1qbdy+9rpJF3CO+sOcueU6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rGo9VSon; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Wmf9x/7f; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60E6crNq2755030;
	Wed, 14 Jan 2026 17:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9blMwJuyIYPnBuDM0uZGmd3X6iCX5DO4ZCzDSYWgDN8=; b=
	rGo9VSonMpkZAX+n+FY9P02eIkrBjax+NS8bZbxIt2wn7elss3gJ+8X+9faO9IZ3
	2tEQmjTy6RSsHd7fjMPMICMTvdCkR00yyXHdbNcKPEHAVDnm/YrtF8J+bJMjITOD
	RHBEppyFBG8fOOnS0Lf9SfPzSNRU8POhfOJEnHcDZEnIpIE8Sl/n3lxHajyyvDt4
	vJVJz/oylp3KIn6mHkz6BsTKLAXkBNIT0N7HJ6rckm68LGYc1y+3p2wfBMHt4EIk
	GGfbqwX7gGVua6IBuyziXV7FWt14In90svfY6B+BVVsh2tV6IiYSp+ODHeBZg8vf
	Dk5RTDGrPuXdOZHqDWrhPw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkpwgnmcw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 17:35:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60EHBEk1008289;
	Wed, 14 Jan 2026 17:35:54 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011037.outbound.protection.outlook.com [40.93.194.37])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7a2wsr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 17:35:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqBUeUwoP9shYn+CS5nH5vJoLU7O9XBhyjJkLfa9fgGW7fL5qMazYKoIXy0z5o/RpgMF5eX9ls+qD6z5hCWb6E2VinQ/ssJ66xtlABb+Q/KUquh0uP0WbHOBMbAV/Nlr+hU5ircLuF5+Vradq2Ydsv647xGGJS3MDWU3xvCQ2XAgOE2xrJQuc4iCLLzSZ5nfcmpFbjCHI2MDut1lnyAS0R04j1+6ZSynCcS5DAGgaLmoVNnVzvE+B46FdUBC9Zkr+lbULxoOIRhXZEaVJW5aqezXrdzgPyrb8kyAfKYJXOAKPfy1uZvEWKYcR96bbVpXA6z9aFK4wGNlzd19WEFThQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9blMwJuyIYPnBuDM0uZGmd3X6iCX5DO4ZCzDSYWgDN8=;
 b=zFTfLuJspnvov+8r68R1F3h46VUCP+4ufak057yo7q4ymEDFcyigKXQm/IH6NnZ8Yg46UDPE4liwJdoXJztoaV2yuq7eHQvROGFFzwuj6GSJ3wDRACGKKUVsaoczoJBNfNdIHbFTR8EqcTCLkihjhD61IfNk01AOPjKL//KOC42Vxn8a4flzHImcH0/PmIKnzmXgw6uyRzbfjaK2MfqBVbYf/FElgInq19IzJvgBlK3+EWfMRdIADWM619UNu9seE1rq4h8IwNFjWIUAMIqt0GlriIEt6sKVMmx/1nSa/I8iS9k5wbo0Q7VguBXu6oHeWogJX7fH3cONeKnM/H1A5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9blMwJuyIYPnBuDM0uZGmd3X6iCX5DO4ZCzDSYWgDN8=;
 b=Wmf9x/7f7z2N2UoYlw+aLY9qJYtSCAiimeGEuGdnlnrhd4gIZnjPM4x22q9xjnTN9eZatyWxnjraVI+wEHx473jd8bWPnxtPlvv4cApDPsRK4DE2pbgqkJ/4x0+f09cSJ6yMvUuGdJ9zadKvHGQZrN2EGZ7aGvnoKBlaInhdDH0=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 CH0PR10MB4857.namprd10.prod.outlook.com (2603:10b6:610:c2::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.7; Wed, 14 Jan 2026 17:35:51 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9478.004; Wed, 14 Jan 2026
 17:35:51 +0000
Message-ID: <31e5d219-07f4-46c0-bef1-53af20d473f1@oracle.com>
Date: Wed, 14 Jan 2026 17:35:45 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: The same symbol is printed twice when use tracepoint to get stack
To: Tao Chen <chen.dylane@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
References: <e876fdea-ad0c-49dd-80ec-bd835ebfe0a4@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <e876fdea-ad0c-49dd-80ec-bd835ebfe0a4@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0152.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::7) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|CH0PR10MB4857:EE_
X-MS-Office365-Filtering-Correlation-Id: da74713e-c580-4f42-d85e-08de53935cc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|14052099004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z085aFhDQVpkaG1XYTZRQ01jRzhVWG1acTNYeEZQOW15c1R6dnpsbkpmT3B0?=
 =?utf-8?B?WEpjOHY3TU8xVUh6WUVaQVBvRVdMUTZuTk9kb2NjcWNmMjh5dHI5cEVtQ3px?=
 =?utf-8?B?L0JLVlQ2ZjNLSFQvMkUxbk5KK0hiL3JBMnRYYlQyS256TVNPTlltaU4vVWhx?=
 =?utf-8?B?RGpTWWliSURCcGp1dXRyMWtYVFlmVnZvMGMrbEZ1UVpqRS9nV2I4TkJwemlR?=
 =?utf-8?B?c1dOZCtRTzR4S3B0VytpaWZNcXcvcVZScjA4cURNRFdld21BVnZIWWVwdHdq?=
 =?utf-8?B?VDBIcTlOdUhUd3gwdGw4TVp5L3J5d0gzWFF6VE81ZVFOaFpVUnZVMllCSU5W?=
 =?utf-8?B?RSs1bk9HSE9tVWZJVG93Rm5vaTVPL1pPVUV0eGFHOWVHbTZFWUFMYUZCczd6?=
 =?utf-8?B?emt0SDlISCs1TlhiN1NvbEpZUlk5Qm9xT0Y3UXRpZm5kVHJwdnRsSmw1TWpw?=
 =?utf-8?B?L1BkWjVBS0hMMWZxOURwZnhEVktHL01kZTR5SU5wblRUbnhURXJyMStYOEZR?=
 =?utf-8?B?WFMyd1FpR1dBNHFwNDVDTXFWY1lMcUpqeGU5UWIzQnI2Z0grc1YxK2dnZE9k?=
 =?utf-8?B?S3NibUVYcnVjMmI5c24zYVpYdUJnNTA1MVRjTmwxbnNsWSs2KzNJdTd5ck85?=
 =?utf-8?B?Q3FNMDN5bThIQlloQnNEZFFlSFlMeE0vOFNVSlRkUTFpa2hpcERWdDVvZmZv?=
 =?utf-8?B?OVpOWFZuRW5PdVJvSkNHTndBVUZCN25hMlFWcjFONTJPZzVJb0N0UFEzOXpJ?=
 =?utf-8?B?bzR4WFA5QkowOFFMYkE0VDZwWDZ4MEoyYzBYNzFtaC9XR3YraXgzWWtoVkxp?=
 =?utf-8?B?RDEvY3p2R3U4L2s2RURFWXZKZzhjaWVGNmhFeTV0UXpyYkE2RnJJM1ZYaElU?=
 =?utf-8?B?cWdXRlBjdzlqWTQ1WjFBa0lnUlU4Z0phZlphSzhmQnU2RnA3T2Q5cmljdjN4?=
 =?utf-8?B?TGFMOW1wL1g0N0NSbmt3WFgzOHF5alRQY0hUbGpKQU1oUE5rQ3RLTFF6VHBY?=
 =?utf-8?B?N3N0UVBnU1pjU2ZNMFlDamZGUWV2TlZiY2hFbjFuSTcwK0U1MUJyb1ZnVmVu?=
 =?utf-8?B?czRQVWRUODI3aGQwUkVGN0JqQ0ZMUW1SMmF3Mm8wVlpEUEQ3d2FvOGJJQjBI?=
 =?utf-8?B?NER6WmFxcEREK2dpYTUzd1lSbG14aWZUWnYwSzNoVlRjTktBbERpUHBmUzVS?=
 =?utf-8?B?bGhFbC9FUkx6aDArcXZYYlU2ZjlxOFh0THBHQ0VyakdMd0ZmTkNJWUhBUW1W?=
 =?utf-8?B?dDBiYmc1dXBoU05kV0lya3RGT0x3aUJhbXAyL1VlQ3dBRllMMlZTYVlBeDV3?=
 =?utf-8?B?aUlGQVNkOHhtTGFRTFpqSEd3cU56WXdqc3Q0WHh0U0xSOS85bzZSd0ZhOTVs?=
 =?utf-8?B?cTdkL1d1VTNvaGdBd002ZkJ2MEJhSi85R3BOYmZWMkhWdWVTeVI2Y2c2TVBq?=
 =?utf-8?B?eHhxNk52SEdVYVd2ZFRDSGhlaHIyS2hyR3YzOXVIeVZJU0lIa2xpaGFKakMv?=
 =?utf-8?B?dnFYek1nY0ZvL0lWdGlqSU1xYytNUHhBSjdwSk5Lck1OY2k5OEcxdG01Y0Zj?=
 =?utf-8?B?bVk5M0h4aTdGUHlIc0t0T2tRM3pvemJ1b3AyUk13NWFiVklyWUtLSGdqUXBp?=
 =?utf-8?B?b3RDU1VEc0FZTnU4UDBJYm92WVBQKzc5aTR0T2dJVDdpdWpsY21IbHNYenVI?=
 =?utf-8?B?cFFsRytlbUIzS0dsUG1YTHdUek00RWp4LzZNbE5wZURZYVRIRzU3NCtZUmVh?=
 =?utf-8?B?SFJaZW5oYUZEaWRFWUcwUWE2aGI4WS9LUzNxSWlnWWducjZJdE5YdXNZL0xT?=
 =?utf-8?B?M1RzYXhDbWdrdys0K1prZWJNNFNoc2xRQzBQbGxZb1lDWFNValRSZ21TVTZR?=
 =?utf-8?B?V01sVWpVcjBNTUxOOU9KYTV4aTFFL3JSNmg2NHBZWC84Vk1ORFVSWnphbzJo?=
 =?utf-8?B?TlA3dTNkOFJZd2lyaDQzdnRNQ2RtUStEOFdlaUc0MWNJNVc3NWMyRDJlcHZS?=
 =?utf-8?B?UmFhY29EMk1PeVlDRGhYL2ZTeEV0RGRRWE5HZi9LaDVLdTN2bkNMdU5wOWVl?=
 =?utf-8?B?c0FFTXptV3hycFhLaDRpazJZTjQxd21sZXo1K1RKaG5TK0dZVEo4dTROWDVp?=
 =?utf-8?Q?2LQkm4AqR8kh/rxLLxmtTbwng?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(14052099004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXMyOHo0cmhxZWdEQ2dpaEtSVDdOcWpEdkhWOWR1RytaUVhPY25LaGRyRnha?=
 =?utf-8?B?MlhUVlc2Z3VRWEdma0h3VThOUlJpcVBpR21wWUNVeVBLWlJtcEt6NUJkMTJ1?=
 =?utf-8?B?OWNaNkZXYWxkUGJPV21iUVVnOHZYMHNadVFMM2VOOVBkeVNJeDd2MFBwMlVP?=
 =?utf-8?B?QmRhRHNrRDhpWU0xWTJrM0tmUzNtOWxMOHh3TUdBeGhGUkxnTWtGRVRBWDRP?=
 =?utf-8?B?WmZyc1ViSStqT1N4M1ZGR2R6Z1NSclJQOUVnTERNSDZIelRLZE5yTjNGQW9I?=
 =?utf-8?B?MFdNMzRYN1JvVHJjYXBNemlRZlpOaUlWTWh6ZStNSU5hSFpCdU1xUmc1bUV4?=
 =?utf-8?B?VmNWbk9PMjBTb3pub1Y2Vm94SktieHp0U3g1M1QvTGljekVwNERiK0hHTXRD?=
 =?utf-8?B?aVJPanozSWVOODI0MU9ESW1qSHBYZHBvZ0lua2VwT2dpMFpqbzlmRTVOTitv?=
 =?utf-8?B?MytMbWJBZ1FITEpydk44SHlLek9yOVVuNWpVckNsY1FrakdOLzRVRE1hUWp5?=
 =?utf-8?B?WnZVTWFvQndpcElJUlBtNXdNNlFINkJyUHJtVStLMlp2YlF6N1FIVW9vWUMx?=
 =?utf-8?B?TXJldGtCVHhCbXhrRXVSWnRtTmVZVFFwSkZZWmUwb3dCa3NYbEhOWm5SMFFO?=
 =?utf-8?B?RnBnTklmc3hHWDJhNG1pUi9WWmRERGhIeS93UzcxMlpXMy9LS1NZdDdvL094?=
 =?utf-8?B?ME5yVVZtQlhIeVZZclhLY0RiT1BSUmd5NjM1OW91a0xCWkJlbnRBUW9yYU1U?=
 =?utf-8?B?NHVadGZFY28vVytpYlZaOGNCaFVhKzJGQzBwcjEyUzdtbk1DUVFDMGJHanR4?=
 =?utf-8?B?ZndtNE85S1UwMU91R0ZhbDhOSCtPV2R1WEhJMWtGSTFQdForSEUyQzNSZnoz?=
 =?utf-8?B?Wmc1S3BISU5HcDVKSzY4azd2YzBDZ3ZhQzZTTlMrVFZneGJING82MVJSajVu?=
 =?utf-8?B?OUUyUUxhRS8ySEZMb0xZQ0hpQldkYVlNZE9vNGZzSE90L21FaWJKS0plVTBk?=
 =?utf-8?B?MG5iWW4rWFFJQlR5Ym5NNS8zek9LbmVTY01qTDVZS0lJaUVZVEE2OWZTa1hp?=
 =?utf-8?B?aC81RzU1SW5mSjhrME12OEtLUkZwbTc3THBuNDFKNXI5WEtJalpzTFh6U0FE?=
 =?utf-8?B?OGZnOVU0RU8zQlZZL2kvTUUyZ25GS2pWMWlYT0M4UTV3UjA1c1gvcGZDRll0?=
 =?utf-8?B?WkxmSTQxb1Q0QzAzOFo0RTJlcDBYRXJqRGRBOUxSQlA3L04rWGZ6ZnhOOFAr?=
 =?utf-8?B?UGk4SHhvc3RvNUdUaUxLTkE3TWNvUThLZEpCQ2pNMEdOWnZUL0tGUXNoMDBI?=
 =?utf-8?B?dWZNbVpmRDVCK04vQkx4c2syVDhtdVZnMC9ZTi9iV0l2Vm1YQ0RxdkpuMXhF?=
 =?utf-8?B?azEwT0c5OWRES0UvOXlNZVVEbkpEWWduZG9zc05EMGdpY2oyaTRrUWdtOHdE?=
 =?utf-8?B?SHpGYzM4QkVpNWlad0ZZbmpmNGEvQ0hZY3VFeFd6ZGRZZDdsb2MxcUlNUURG?=
 =?utf-8?B?RmlBZnZMUTZRTHpYaFYwdy9LdGp1VTJGbXo0VzZEUVYvMTZOZVNoSTROMUNv?=
 =?utf-8?B?emNPT1NiaWNCUDQrbmYwVjlNN1p3a2pIOStTUGpJWVBDcDI3SGw2c0IwK0RT?=
 =?utf-8?B?ZUZxRVQzNVRDY2gyRnZ2V21ZRVVCK1ZPRkYvRTM4UWFsOVFHaWpBSmpaNGUx?=
 =?utf-8?B?ay9Ick5wQWpsdVNEL0Ivb2tBUkgvL0ZxWXlYNUpHRm9TekNkd2JRSmtlRXJ4?=
 =?utf-8?B?N2daTkVXcWhIRDNlQmNJdExKRGhiVDNZSUVrNzVOTkdTeTRJZFlwbDBjS1d4?=
 =?utf-8?B?MHdsN0tCcXR0YSs3R0x4eGNTNzhuTUVRS1piSmFoNzRxUUJ6c1NPaFd2cE5u?=
 =?utf-8?B?RHNVamRFUlgwVTR1cHVIcE9DcERGQU1UQXh0MWdDd0c5cHlJRDVTL2hTa0dB?=
 =?utf-8?B?Z1pvTkV3TERQOVpudmNXNkc5VHdrQTJkaGU5TlFmMHFyQUlYQmZWZUZPRWRW?=
 =?utf-8?B?Y0sxODkvb3B2WHRlMDVVc05OcXRVU0tUWjZ1T25jSmhmdkpKQllKWk1UTjN1?=
 =?utf-8?B?NXNiMUNDLzBpSVFvL1k4Zk5Ybkt4YXNINWNQNFYzbDZGYjg4SlV6QktmNTNy?=
 =?utf-8?B?RGR2YjN3ZStvdDFKOHlmMlIxNHc3QUg3UitLL2kyTStsQjhzdC9wRTVxZStn?=
 =?utf-8?B?SWRhZ0lEeVBob2hDeG01UGZqa1JQelN5NFVoOHhtMTFQRkMxWTdiYWF0OFdi?=
 =?utf-8?B?ZHJlYTRNRDhrNEVvWStpMVFxdUd6VWQzTkZ2VUdrSHFwVmp6aEczeEw4R1Za?=
 =?utf-8?B?WW1iT2l1dU1URGhlSFowandUVmEyTm4yM20rWEErc3VqR3FmTU5jQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iQtsHRjibpRkq+zbM2MULNxF+Q+2KTMx6N5EFlbhfGwVHuXV3lA5kAEpUyV8tMWLxHSTlC+SdoetR6CX8UYgnTP62DwiEKr61VVC4Km7bNT4Hbkt2XFtSrRiBQmWqXbOikljuiQ9OmdQaX2SeQpUeVx5S7mQPsbCC3/5b/dOUOlPfW58EnrKibq4CR0znY6WdhjXQgJZEz12xRC6RU3ugqr9uSAurEXYQjiRutJUGaPJlcNvPLQ4C4YhUaLzbXSr+9MzLHKQWwRGw1WsBJ8mgaEHjsetY9YvoE0Q2Qd4IPjH+QUnECnVmYe9e3E+tu6zyHRLPbc9AHpmTpsqlh3qP+wqgaY1LujZJXb0LuiH0SYpW35VpcmY6c2uMhuJFrZrKsLFWnRJTgoEv4RD/SFCXgxVXIUEEb55iraulOCUB3y45d59lM0yl3+TqicyxrF5rxyCtZjsVHnp3D4OpYp5iBNXZ8N7lnIWb/JU+BNoS1pJIg3TVFISKWLP7vCXU3glmQgtRq2g/r4gdpOMgg7rc6pLtkmSE9HfWpCi9yqrKK0/LY85YVq9Jhodx6f6fk6WvZA+Yi4bt8t2yc1e6CHRlmxa6IUPeQH8sR8M0sHnmbs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da74713e-c580-4f42-d85e-08de53935cc2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 17:35:51.7402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wzgIqG7nId4atwr2Im+0VOSb2ZYUl+YGoIDgZ3Gqk61954BSD3hM9cFREa20HAEGUHQeN8V0CZ1BK196VrpaEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4857
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_05,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601140147
X-Proofpoint-GUID: wYoebAKYk6D5H7-qSZQoyITJBED9xJYJ
X-Proofpoint-ORIG-GUID: wYoebAKYk6D5H7-qSZQoyITJBED9xJYJ
X-Authority-Analysis: v=2.4 cv=ZtLg6t7G c=1 sm=1 tr=0 ts=6967d3fb cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=NEAV23lmAAAA:8 a=hnwMpiV-vuxu4JJv9ZEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDE0OCBTYWx0ZWRfX012jnpugz98b
 k0p5ETZ0mdTX+ERMWVqN5GBc1GfyGziLTlW4ycW2x7zU1wkTuyzFjylvMJqUD2N9RAu+62u5mcZ
 HZCB5XGLk2TKHB+Q9EIAv0YufJckwI1zqN7uu6FUuRej7NC1kI5LScrtJE9/96Z4T103o015cM/
 fDWxsLGGMMVkuCI2M1LEe1xYVD7QoIcd6Sc7ah4HIiEsx+/lhHuzpvxzfHI1WEYpDUmwX166xMY
 bZ91B3hHmdgR5aKDc51kbYGzVv5O+rLoXoZk84syDiQWLOOgg0OqBV4+2LKOmULusGSmPOFv57/
 jxx6+WaZV2ieK2LuuSRGINtGlok+Neult56T048U1Qy6RUGghiyUs2Nc6Xd1Or/bpg05wwJkLFL
 zXCHw3tvy+p2GbsoeJu/nPDqZHKMw+RKDswbtwoLwwOK7FDHGb7ackaGaBUt4yIudfuPwn5r4lM
 +8woX8GeOJWRVyrQBig==

On 14/01/2026 15:09, Tao Chen wrote:
> Hi guys,
> 
> When using tracepoints to retrieve stack information, I observed that perf_trace_sched_migrate_task was printed twice. And the issue also occurs with tools using libbpf.
>

You may need the fix Jiri provided for x86_64 [1]. Eugene mentioned that
the issue persists for arm64 however [2].

Alan

[1] https://lore.kernel.org/bpf/20251104215405.168643-2-jolsa@kernel.org/
[2] https://lore.kernel.org/all/a38fed68-67bc-98ce-8e12-743342121ae3@oracle.com/
 
> sudo bpftrace -e '
> tracepoint:sched:sched_migrate_task {
> printf("Task %s migrated by:\n", args->comm);
> print(kstack);
> }'
> 
> Task kcompactd0 migrated by:
> 
>         perf_trace_sched_migrate_task+9
>         perf_trace_sched_migrate_task+9
>         set_task_cpu+353
>         detach_task+77
>         detach_tasks+281
>         sched_balance_rq+452
>         sched_balance_newidle+504
>         pick_next_task_fair+84
>         __pick_next_task+66
>         pick_next_task+43
>         __schedule+332
>         schedule+41
>         schedule_hrtimeout_range+239
>         do_poll.constprop.0+668
>         do_sys_poll+499
>         __x64_sys_ppoll+220
>         x64_sys_call+5722
>         do_syscall_64+126
>         entry_SYSCALL_64_after_hwframe+118
> 
> Task jbd2/sda2-8 migrated by:
> 
>         perf_trace_sched_migrate_task+9
>         perf_trace_sched_migrate_task+9
>         set_task_cpu+353
>         try_to_wake_up+365
>         default_wake_function+26
>         autoremove_wake_function+18
>         __wake_up_common+118
>         __wake_up+55
>         __jbd2_log_start_commit+195
> 
> env:
> bpftrace v0.21.2
> ubuntu24.04，6.14.0-36-generic
> 
> The issue is as follows:
> https://github.com/bpftrace/bpftrace/issues/4949
> 
> 
> It seems that there is no special handling in the kernel.
> Does anyone has thoughts on this issue. Thanks.
> 
> BPF_CALL_4(bpf_get_stack_raw_tp, struct bpf_raw_tracepoint_args *, args,
>            void *, buf, u32, size, u64, flags)
> {
>         struct pt_regs *regs = get_bpf_raw_tp_regs();
>         int ret;
> 
>         if (IS_ERR(regs))
>                 return PTR_ERR(regs);
> 
>         perf_fetch_caller_regs(regs);
>         ret = bpf_get_stack((unsigned long) regs, (unsigned long) buf,
>                             (unsigned long) size, flags, 0);
>         put_bpf_raw_tp_regs();
>         return ret;
> }
> 


