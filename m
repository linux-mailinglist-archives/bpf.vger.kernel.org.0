Return-Path: <bpf+bounces-79012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB42D23AA8
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 10:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF274303B059
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 09:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F05535CBDF;
	Thu, 15 Jan 2026 09:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="msKV93Q5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ok5NW/Qj"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666F335B12F;
	Thu, 15 Jan 2026 09:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768470096; cv=fail; b=QWDzSs5RdzbaO6yGCOQehx8UZKAuz5tv84dHknUgoJzXVRoAiBJWDtzSjUg0WeGAmDedtsDQsRDhWmcz8soBovEzUN511/ZmNYKfvzy+DwqOaBEQpOxyH9Pfl+1gZfxTN2XQyvPwENRcILp7Q/qx89RrRmeWUk0Ty0d5iQjcthE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768470096; c=relaxed/simple;
	bh=JspUjQSUvSJv+gnIEqwRTvDILfH2d72Q719uq78jU7o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dmQyhOqOngNby1vYSHJORNSpvAzP611ZisQeNYgUj4vVqdumb0e0+6oKNZgLrAgXOxHUXhBcXptvvFmN63Psriq6WUI8jM3FR6TjUx5W0qTsYOeHSmCj4Zr9D3oTOWuwEGFCcFuwYIOBAjKtpc/gsfslByOZ6mMN/KuAIC57RCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=msKV93Q5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ok5NW/Qj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60F9amsc1098168;
	Thu, 15 Jan 2026 09:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=DkDWBC8n7pN6d/GJywiTVyEcWEgn4PUrj5pwLxiGCIE=; b=
	msKV93Q5zcPkZpHCxaEhw0z0oEuQVHEbId4I9oENZult52RHMttohXM8274sVMzo
	co6GJ5u9RTSTKNzober90Ptj9jER7a9Wm+Zeci7Ir+kzsB4+8aONtcJYZ9o8yEnx
	G+tCjDZP5jROWLp/h7hoqq5eTLOIeegb+oT6DqCbLQJtGkWp1JaY9Qv3t6BHQtaI
	CbBrdWuYf3R/4yCsEQf3BcveHrOvzxfJn7qqLHbZAhR0SvWoGNNgM53eJ+jApkoK
	kOL7VbfCGQHwwLUPpwxtNnAJlTicuCF95HV2uJbjP9tWdQGG0M07O50pKSm0Mh86
	UlG8+nHLz3Aws184/qRJBQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkntb787p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Jan 2026 09:41:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60F9Y9Lx034710;
	Thu, 15 Jan 2026 09:41:27 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011040.outbound.protection.outlook.com [52.101.62.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7b5egw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Jan 2026 09:41:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M10vbCF5CyGCt4PlIZ0o18zDOpmdMLaHccDfMO2IvzwhW1Ew3OJhCID/2ouw2XrZjE9VcLwsXGCtLTI8VYNAqd4JEYz4Haf7RuZZwv0fud4jgYYetvyowffAvx6LxuVXOpM3HLmzOlJl22AJWFuhehpbek2hB+c8x5SFrEwgtHiOr4Csy5+Q2BDfyZzQPMY/P+TkG2ivEaVf+cP5qx44WYkRXUWNHSlJdR8DFA2GcIcRq4VWeGzF31eASUBvHBPhGFNCaMl+mGPriCkYLVXWUMrb+uZwlrtsnoIo5hrFRhmuYz6zejTgfIC9s7aXdNIFFktBalYUfJq3KCGWuHtoWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkDWBC8n7pN6d/GJywiTVyEcWEgn4PUrj5pwLxiGCIE=;
 b=ZTEp7gIgy5FUiQBnf7C+hHq7clCNZWaF9zAAnFPTPYfeapXMK/HDCx31o1RqOKwCsq4jf8xFFnZHxIqz8VRGlQAWimOGDk/vlbJFHu202GQlIa2bYUab/+38g8Ugs1aAdDWXgHJ6KNfloKHL2nyP/OP54mwR4QPLZ6z1L/NZsHRvtF35ouCFUIb+tFJaJbi0XrkrUBoNWS9YPHuN0uMCYuxIwZjq1l/jyzikyrDZcdLIvRBLabfcgIUx5EGMBRhZklkc6T4IMCws6mH/jKyi6jkWRMrExMw0ZTtWKNp9r/akfCVpANMYDJr1vEStTuLx1mdbn6vozYIYmb2xqANoBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkDWBC8n7pN6d/GJywiTVyEcWEgn4PUrj5pwLxiGCIE=;
 b=Ok5NW/QjEZBao6cfv2pQF0/q0S/zu2ZX6kTjxquc6ZDKHv9CB3AsDHTE7ExDaobBNzJmehPMI6gYUYzUNjuGekOresf12vbBz8xco9um+MRxmr1TNz2mZDBAL6HQaKKPRKpscJifUib2j+BLLSBU7KcEly1+jOpejUe5YgT+pfg=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 IA0PR10MB7158.namprd10.prod.outlook.com (2603:10b6:208:403::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Thu, 15 Jan
 2026 09:41:23 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9478.004; Thu, 15 Jan 2026
 09:41:23 +0000
Message-ID: <4e8df34f-50be-4c91-a43a-26c84fc5008b@oracle.com>
Date: Thu, 15 Jan 2026 09:41:16 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves] bpf_encoder: Fix a verbose output issue
To: Yonghong Song <yonghong.song@linux.dev>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        bpf@vger.kernel.org, kernel-team@fb.com
References: <20260115050044.2220436-1-yonghong.song@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260115050044.2220436-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::15) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|IA0PR10MB7158:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cdeac0b-6784-4778-9da7-08de541a3eaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGVNNW1aRGhoWVpURVZlbFA4cGdOY3VqVEszTEFVMmF1N2hpbHpTSU5kWWpK?=
 =?utf-8?B?REJUSGhXemd3Zkw3cGtiSXZ1WVRMTHhEcWl2STBOM0M1c1VLb1JuUTh2ZHk2?=
 =?utf-8?B?VTIvYXpPc0x1OS9sNVdSckRGQ0VHdVgrMXhkTEFmc2R2MU9mMUVKSDc1STJw?=
 =?utf-8?B?b1pJSDd0YThBUjE1NU9pYlAydmExWW1pVElTZTF0VkNxdEhiRUc2dUhISTFl?=
 =?utf-8?B?TytDcGh0OHA0dCs3ZW1mbkRhbTM3R2JsZ3ZieUpYOTRxY0RjSXdpR1pDUUt4?=
 =?utf-8?B?S3V0UmpVYi85S3NCbE5heVBuVlBadERlcDdhNHhyS21URHJ1U0pXRFlDV254?=
 =?utf-8?B?bWQwU3dwWCtZK1hmeTJIMTZlS01uZjJvUHVUcWg2RC9wOTZJNjZRZkZiK0hD?=
 =?utf-8?B?NmVXTkNOZUVjVS9MRUJHanJZQzJUamdNTWdsTFlwdUhUc0xlYUhleE8wK2NQ?=
 =?utf-8?B?cGpYNjhCN1IyYVRib1VkTWdUeEx3S2YxcHlXWnlvbFVIemxzZXJiUUpJVGxw?=
 =?utf-8?B?MUgrRFgzd2NmS0FIQWZpb2lKWGJLcVFyY0hDdS9TeXJHdGhWRFJHZlJiOFZN?=
 =?utf-8?B?WktFSzVBODVqZ21yUjYvMWFqRXQxdngzOVhKNExWdUZGVXU1UzllSmEwL09E?=
 =?utf-8?B?M2RXVHlRT1o5cU91RjZvdExxaWxiS28vRnVHMytTRkwyWWdWbW9RWEY4cGRw?=
 =?utf-8?B?NEEzTGgxUW9uc1RmR1FQTzIyTDdla01zSGkxMTkrbjZ0Y25sNWcwOXUrbWJG?=
 =?utf-8?B?OFl5TG8rWmFwcENjVDFLYVJSZ1RWbmJRZXVTYlRnTDUzU2t5bmwzQnk0WERq?=
 =?utf-8?B?WXdzc0NnUjFzeDVMUzdKVXR0SEE5RlZOSHNkWEdkaWlwMzl6WStXMy9iUFBG?=
 =?utf-8?B?OU1UcVdLNmU4MjJOSW9TSmUySjlFUUZVd1Bma21jMTRjbFJPZ044NDBzanNz?=
 =?utf-8?B?Q283VmhGVXI0aGRtNG9kU3ZPQkFSc2xxa0tyeUV6cS9sYjVZeEFFUEd4RkFM?=
 =?utf-8?B?eWo2UVQ0VTJqckJVY3B1ZncrNkJJN3lFZUw1c1BuMTZJNDBEK1RwV2lyV1Rz?=
 =?utf-8?B?eElNb29LeHlXWDRWSmVHYmRaNEQzNXdWUW9JTzZ5YTMvcmRzR2MzREZaQnJD?=
 =?utf-8?B?QUN4K1ZVYldYWnRMdTQyOXplZ1pxa0JwOEcxODlBM3V0bmY3YU5maUNtMTA4?=
 =?utf-8?B?YmpYcjhkQ2doblN5dGJ0Vk96dDlKZGdOUm9EbGxFMDA1b3lnUU5zSWo0WnZE?=
 =?utf-8?B?emlseEhBa2ttcVVkblNkbERoa3JsRFpPZk55UHk1OHV6U2xySmQ4MTRXQy9H?=
 =?utf-8?B?YUdoNTNmYnVVU2dZNGdiQ0ZGeFZCK3VOYXdtMGc1QnRlcWU0eFk4ZHpjaHFZ?=
 =?utf-8?B?dTJEWFZJOUlUS1cwKzNIQmJINUdvRXBzSS9INGdJVVNZaGFUQVF0NjErckZM?=
 =?utf-8?B?b1Q1aFRSLzZGMVJZbjg1VWhtaEFrbnBnREphNEpRdjZuYU1OZHJZVDRyUVhx?=
 =?utf-8?B?Ukc0QTA2NnRQRnpkK2VHckM2RmN0YjlsZXBza1RMaGRURU51eEt2RWdLQ1Iy?=
 =?utf-8?B?bXNXY0p3d2UvbFZwczREMDUvRG9aampKZm1hc1pzR3FQdWtrVGQ5cVB1dXNo?=
 =?utf-8?B?Y2J2eE1sM3lKNDJOS0ZoaXQ1RG1FSGpGWnVCd0EzazJHZE5KaXU2UnN0ZjBX?=
 =?utf-8?B?UVVNcks5VytqODhTeEVrZVJ1SVMxaWUrQlhYYm01b3pWdE5rTHpTUVY5aUVs?=
 =?utf-8?B?aWtWcUVsZTNXNU1Lbk53UGZHMFlBVnZLZk84L3kyd1EyNmRBZWxoMDRrY0s4?=
 =?utf-8?B?UmZteDVoWUxOcWlKeHpYbE1xaTR6UTJqMm1McWVUUnFPVVNlKzBGa2p1LzNk?=
 =?utf-8?B?OHVsNFloQ3FJV2FyOVIzRkJmSW0wY0ZSYmN2eUoyY2ZDZnNiczNYa054Q2NC?=
 =?utf-8?B?eHhYRTUzYkVmWmxPSllyQnhnenNYOVZUMS9TaW1qZ0VKd01pUzczZENZelJP?=
 =?utf-8?B?RGZLdnBmK1lGMXQ1SnplVnJHeFhZNWNiNW4vVU9oLzgvZHd2QWs5QVJRUGpr?=
 =?utf-8?B?UDlON2NFZDdFS0pINUFXOFFsdzRCNG02eU1NSFk3eUNOWDN5QUUzbVFSYW1U?=
 =?utf-8?Q?xyso=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1hrV3dYcFVHL09iRml5MkFPQ2d1TVA5eEVDdEU0c1NpSkJhdFZGTnF6WWJN?=
 =?utf-8?B?ZHY3M0xnRzRVbktjeWhCVDgwMzQ4Rnp1Nm1qTDVzcHRPaUpIM2tvcW12K1JH?=
 =?utf-8?B?RTlFN3RCbUZRYTNldDI4Tnd3ZHJyTW5oNHVMQWgvOTY3VjNjbmQvTy9ueUpp?=
 =?utf-8?B?YVNUdExxVHA3SDd1OVF0dmVJbXNKQmhyOERXemZrTnRPUXhLU2J1MVpsb1pE?=
 =?utf-8?B?TDRzY0lQRDJZS29adUxvOXVBeHhoYmpNalY4Lzhqekk3ZHZlbkYrWGdRdlhx?=
 =?utf-8?B?ZllrTGtTcnRETG9BTFJQc3h4V01lcGsrd1ZNaUFJblBrclFEbTZLYk5RWm4r?=
 =?utf-8?B?dkdGTWtydFFncmpoMml6MUhybkdXb2VuUWZ5azd2cEdJcW5rbUV6djBXZDM4?=
 =?utf-8?B?Z09xY0RpTGlBVVhlcEhEMzNRcnJSR00yQWVxS2FlNXkyRnM1cllDeElFUnZi?=
 =?utf-8?B?bjQxR1JlSTZ0Mkw0NStXZVUyaGJ0bEdXTU1zcWVNRjB3bWVpSkRoaE82aE94?=
 =?utf-8?B?MTdKQVJyQTdtVnhTZ0dPL08yMmJEVzRxSVFwaUc3ZDVtMHFEWE5GYXFLSjhI?=
 =?utf-8?B?NytnT3dBd04xTjJwdStHMHNhR3ZhZEZBako5eWJKMlVWNnYzbmNHVE1JRHND?=
 =?utf-8?B?cDhYSCtyK1Q0b0FCRTNQMkhtdHNZWVBKcjVyR1pkR1AxNEFYTHBPcm9aZjJq?=
 =?utf-8?B?RXY2eStPbEFxSTF2MjA0RFd2UlAwMzJmVTltT1pnMXVJUHlQNW93QjRPUjhK?=
 =?utf-8?B?aTQ0bUY4SmM0UmFQVGJKK0xid0sxRTZOaWU1TW5WWFE1VFJ4dHZ3SjMzSXdk?=
 =?utf-8?B?RzZaNTgzZUhoQnIzejV5eERLM0Nkb1lUb2Q5YnloL241bFdCdEhHc1lKdDZF?=
 =?utf-8?B?dmVxdmZySHl6Kys5V3h1REVOZXczb0RnVk1va0FkR2tBUUNFM1J0QmlmK1o3?=
 =?utf-8?B?cys4eTlNVENEdmYrNFFyc0UzaUU2bWJVbGxjazJ6ek1NZkx1RWdaZ3Q1YlF3?=
 =?utf-8?B?cmw5d2FVNUZuRlpiZEx0S3FuMEFnTzhFZVVEV1FERDV0eXo5cURpSi9JWTFu?=
 =?utf-8?B?RG41d2I0dDRRSTFPTzZTNllKRVFvcmN0Zm9xRmpRREZSS09MNDNMQjFKMEhw?=
 =?utf-8?B?Q2J2dGRQbFA4WTkrSkFiSzhMTTJOS2kySGtUUGVYQWJ6T1hkQUdjYlRmWlRX?=
 =?utf-8?B?ZkgxQ3BJaUZqYW1NUlFocklsbnh2dFN0Y3ZUTlNESnU5UVk5ZDlFaE5vQmFS?=
 =?utf-8?B?YzVwbnBBUW5nVUNkOS9tc2FEbFo2MWxsZ2Mza0NrVC90eVFGVU9DdGJZSCts?=
 =?utf-8?B?YS9OMzd5ckpMVllDN3BiTGplbGFxTmJCYWwvN0tJTko3VWJoSDBjeWJpT1hF?=
 =?utf-8?B?QmRacXJieGl3T1B4WExWZkpsNlVadXNJQUYxK2QzcDFnRm5DWVFkMkx0amFT?=
 =?utf-8?B?aE9FZUVlakRkUEt0TmUzZFRpOHJNbWtjd1h2a1lkYWJaeGd4TEIwVHFQVytG?=
 =?utf-8?B?Y0F3cVQ3V0FWSUxlYjRqNlh6amxhR1pKS3lrYXNNeDBRQTJLWXhNRWttRGxJ?=
 =?utf-8?B?Z1EyUWdMR25CelFlVk9sSy9PQjM3UUFSTSthWkNJSTFZNG55eXozVktEY3Jj?=
 =?utf-8?B?RXpYQXdGK1VMZmhXL0hPV1NEallTMXc5WmdLakM3KytiS0svSDc2dXNZNjQ1?=
 =?utf-8?B?VCtQOG1FU0ZsUy9CMmF0WCtUVk95LzJ5dWlRblhNMHRWcGdESEc0a29ndytF?=
 =?utf-8?B?TEt4WWhKNGg0QjY2VjdNQy9CdzY2OFRCNHVyOUNFaUtYdmlkNVdGQVJzUjJ1?=
 =?utf-8?B?RVFTVDJmek90NVRCN1V1SXlVb2dBQkhFUW5yc3ZPSWdFRW1CRjlEazh6ZjRn?=
 =?utf-8?B?bEg3NUlyTnRjTjlydXdUZFo2bVFBMGFqZ0F2WE4xWkZjdUJTeGZTOTBRT2h6?=
 =?utf-8?B?MlZDck1saGE5dGlDVG5rd2VBc1FXUzRRL1FyZHJPNnNMTGd6WHF1T3MxNVhU?=
 =?utf-8?B?VjQ1eUhJMVJ3bFBnM1U5dU9UMXdhYlJKTGptRG9WMVZ5T3NPSk5ORW1WRTBX?=
 =?utf-8?B?cGFIOG5oUml6Q1N6RGEySmR3TWErRWtRdkhxaG82WUlHcDQzSEdhcC9XeDNC?=
 =?utf-8?B?WTUxc01WY2xUYzdVZXd3TTJacDY1MjQwMDdNaW1SUUg0NkJiMlJ0NGVkZThH?=
 =?utf-8?B?bDJVRXBxbmRLSWNZWmJUajZpRlEzc1NPS3JKT3gyQThjSzJQeE5WR2xONDB3?=
 =?utf-8?B?eXpKRkRtTXdpOWVxbG5jeW85R1pLWnU3TlB1U1FTRnVoZ3VEZkx0TEJaMXNZ?=
 =?utf-8?B?L1hLN0RhNnZqUlRKaDdZbDM4Q3M4Z05DbW02UFVLenZ5Q0puU3IxQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	G4NTFODvZeUUsIU9oJImk6U20NaMkf6ZAhF4z1Q8gn35titwpAtCtPpNqpyMpsusmOFETWJwtCKAlC2PoQTqtpnD7wHxGLBtP3rzRWHjyXIkGIFEx9TcjxOMeBnrh0PCxKewCrFaeh/lo8hrgldC08ZdvVBY3tqMH+cjQrwUVzD+XuPKWS/DTQ1i4VzQjI4PynnI39g0VjpeRGdOz7S/7ss3DHsKqqdgxYgqeO9+nCn/ON/4+TFAPdBzQC/qTJ56EvNHMJIuzwm1zBE62oiEeWrabdztr0CH1vww1kgnqamDu1NQFV0V09O24Rj3BL/SicRp8TMqT7zo153sJ6eHudhwlf3PiJavJ+aB67tctbF1FlyeIDSYkhuiaBx3Fg0nI0GKPR6mM56J2EvSUoyVYVTe9OgajiX3ETmfYcsybo8kM5hbU4l8xq/DXZ4X5W3YUHQJ2VPMgEAweDrk3MVA9Piby/E9s47vvaHm1j7O8p5sq7tFqiOog4rCBgL/YRzp0RCSb/JNFvKTWniJlcGDJgJgAyviPFJAqdmPrC4pYgqLDFAPImuGKmBXeMyBJtVkfiSOt5yTjS8ZPk6A2wOo/16ACTPfLf4br78/6YH/Smk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cdeac0b-6784-4778-9da7-08de541a3eaf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 09:41:23.2983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HXtDNL0i5l9/rsgViKG87IsKjnrUEdwT8KvhgwT7PNN495AvCkuGkvoF4J+kPzvU40dCS85Lw4cnlXABkACnog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7158
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_03,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601150068
X-Proofpoint-GUID: svGXlZc8cFvl419bRDSFvgzKnlIqcMan
X-Proofpoint-ORIG-GUID: svGXlZc8cFvl419bRDSFvgzKnlIqcMan
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDA2OCBTYWx0ZWRfXxPZ02ZXJnxrp
 num1nkh0+nijx4WnxEjpgO5bFM8fg4kY3WXSJZxyIx16RYJkjt34NxPSgMURhghVRPZTZs+XMoh
 lMt1S1eBO/35tdbi+O30N72GdcAArGx3SHFstLFK9xq7qsfnp3HPFCq/2r2wQmEzetCS0CZL9We
 MkAzu9otdLZ1x/Zf5aOVuCa9ZebHMjhvexaJyPptkB8Ld+kv3VkU5J0mhq0ZrtciFwAcXKrDG7J
 dM/Yi1H9C5M5CfXLRYY6tICS1++cXoNUybKqxOsp1iXav6+CdWmssrvyfj8il8QilhfcjLThBV0
 Zi2IAQmTeG9AM146cpXdDkPmsnZtvpuRygrV97yQp87HpVprsemKmwcVQASS+AK0ijdnSZ1eepn
 KT+DX/KsIdCvzqfE3GiZiFIpiFByPA08xY7shXQk8xOqd0WaZa5GFXwbzY9/G3rrAdhNrOKXEvk
 2gOfJgzBok0MFy5zEkw==
X-Authority-Analysis: v=2.4 cv=fIc0HJae c=1 sm=1 tr=0 ts=6968b648 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=R7VlMPkDppQcovyyMOUA:9 a=QEXdDO2ut3YA:10

On 15/01/2026 05:00, Yonghong Song wrote:
> For the following test.c:
>   $ cat test.c
>   unsigned tar(int a);
>   __attribute__((noinline)) static int foo(int a, int b)
>   {
>     return tar(a) + tar(a + 1);
>   }
>   __attribute__((noinline)) int bar(int a)
>   {
>     foo(a, 1);
>     return 0;
>   }
> The llvm compilation:
>   $ clang -O2 -g -c test.c
> And then
>   $ pahole -JV test.o
>   btf_encoder__new: 'test.o' doesn't have '.data..percpu' sectio  n
>   File test.o:
>   [1] INT unsigned int size=4 nr_bits=32 encoding=(none)
>   [2] INT int size=4 nr_bits=32 encoding=SIGNED
>   search cu 'test.c' for percpu global variables.
>   [3] FUNC_PROTO (anon) return=2 args=(2 a, [4] FUNC bar type_id=3
>   [5] FUNC_PROTO (anon) return=2 args=(2 a, 2 b, [6] FUNC foo type_id=5
> 
> The above confused format is due to btf_encoder__add_func_proto_for_state().
> The "is_last = param_idx == nr_params" is always false since param_idx
> starts from 0. The below change fixed the issue:
>   is_last = param_idx == (nr_params - 1)
> 
> With the fix, 'pahole -JV test.o' will produce the following:
>   ...
>   [3] FUNC_PROTO (anon) return=2 args=(2 a)
>   [4] FUNC bar type_id=3
>   [5] FUNC_PROTO (anon) return=2 args=(2 a, 2 b)
>   [6] FUNC foo type_id=5
>   ...
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

This fix looks good but I _think_ we have another instance of this; see
btf_encoder__add_func_proto_for_ftype()

	ftype__for_each_parameter(ftype, param) {
                name = parameter__name(param);
                type_id = param->tag.type == 0 ? 0 : encoder->type_id_off + param->tag.type;
                ++param_idx;
                if (btf_encoder__add_func_param(encoder, name, type_id, param_idx == nr_params))
                        return -1;
        }

        ++param_idx;
        if (ftype->unspec_parms)
                if (btf_encoder__add_func_param(encoder, NULL, 0, param_idx == nr_params))
                        return -1;

Maybe I'm misreading but that last ++param_idx outside the loop is unneeded
I think? If I'm right would you mind fixing that one too? Thanks!

> ---
>  btf_encoder.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index b37ee7f..09a5cda 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -895,7 +895,7 @@ static int32_t btf_encoder__add_func_proto_for_state(struct btf_encoder *encoder
>  	for (param_idx = 0; param_idx < nr_params; param_idx++) {
>  		p = &state->parms[param_idx];
>  		name = btf__name_by_offset(btf, p->name_off);
> -		is_last = param_idx == nr_params;
> +		is_last = param_idx == (nr_params - 1);
>  
>  		/* adding BTF data may result in a move of the
>  		 * name string memory, so make a temporary copy.


