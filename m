Return-Path: <bpf+bounces-66707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 194A2B38A82
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 21:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E98B97AD834
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 19:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB292641E3;
	Wed, 27 Aug 2025 19:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W6qObUCP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fLnZohUU"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE17A2EDD62;
	Wed, 27 Aug 2025 19:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756324359; cv=fail; b=VdKvcqnXWLnkAoVUaCVDk2jv7RddFHHnMUcWCNcvv4ebr+HAxSalnHAWyhF5M8FB62z6DUlsgOBi3cDyQvRfnIa1ukpQE/V3bKf6vIaRnCr2rFFXJFoRdATPG97XCAYtnmywSwV534eWr7bsCEQU6f/8IqY1uvpjbEVAAzx6dEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756324359; c=relaxed/simple;
	bh=E08U6LynAuXHeEvXM3D36Ug1FXpvGPgkENtpNhcC/E8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ldiP5Yusutot5JZ9xiSkVGQ3iHTJLzCrQemOLf3YSSlSZOPpYYiSS2eogdFl6prKbdtO4mNEsCQeHXcZAyQSwuvFQD7xxqVwUKEbr/Kd+gd60QgOaXtZEknA+XqzPSFOGv20Cbc3NlcLgfA8YD2RsGCPxmaaE3IdlKvYooW/l3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W6qObUCP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fLnZohUU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RJppsM001513;
	Wed, 27 Aug 2025 19:52:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5xrmYwWpo4kL2sypLCVX+92xaG08BfDmA2VeXvu1CtQ=; b=
	W6qObUCPPccVs7KEDFr97l1JB+bzhF/kP1PaWJDrQbNmjkST17r4pBKqL+9D0Ltc
	TtrrerOOJhfdThT/vAAjoFRhBh1UjQSk0NU38XaEdGwSQ9BMTydNTaCQOEkB74O3
	JPyxmO5c4Q3ciL/W/Mq64IL9vdhNdqbkK1nAzYx2LM2WbqZeYGuBzqHJrv5mvVB3
	N1sutUDEj5BWPeY1+zVbV8s43AIozSRBhfR0Q1n5uDf6QatRQjhRGDg/zkh9+xE3
	izZfV1ITRJaVbpz4jvcHMDsN65UbBbF13fqJZr5S8Yc5o//n8+DSRrfpixazo+NJ
	nIjJSqIlwVpVA85tZ6H3OQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q5pt7amh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 19:52:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57RIcYJU005016;
	Wed, 27 Aug 2025 19:52:12 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48qj8ba0fe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 19:52:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3b9G+thjiMKvFdbCN26h4yufrAZy6bDCXzzOziAt1wJztNeW+IHr2xpON23jHntLV4e7nKiN/I/7TbX7flarCJawhnUhqRU9wKVf/E0StCNj1gowhjnysu7qkyHpnM5oVOm8WbSljx4L4s/bEAwupBOjiOjVIwf+2pZq/Vcjp4/uT9b4eXe78NBSqUqKlhL32onXiqKojqvOWesF/OpBaWMF3rYvm3weItDT0Yrm+2863IiEsvSjqO/q1T0MTCwm580m8EiNdb3c7ZWK6qGNbBH+vI3fBxAn0AoQsQGITwabARpfvU8HhoIguFB66H+Mdp95DsA5LkXlXLVNwYKgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xrmYwWpo4kL2sypLCVX+92xaG08BfDmA2VeXvu1CtQ=;
 b=HKnTzhh5YsN2u60lSAZSXNctpDnSgBtUa84byr0BuQiE028+FVKNQVy4RrZE+TmoQa9R4GIFv7k0mR++ymwaCNDIqark9jF2K3VCYU7eRTkUZxYywFdCitLnq7gc8R0Uc9tH55E1a8Y8PP4EOe5ic1hxtCghiGw1tE7X7Z9ePg9EkjnK6z+c+x+uEgbwvKa5KA80koihZHsILgU06IeR/wxOLLulYDSCBhu+aySTjExSHsIJ0HeAC8tyRBb8NgKSL1qEUvx4c1liLHvUH9CEt6tGe0TzU1IeYC/bzhVHsAqD9Y8msYVLLPRQD53Y4ZsQFoRlIUhwwriEUMMWU3dWug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xrmYwWpo4kL2sypLCVX+92xaG08BfDmA2VeXvu1CtQ=;
 b=fLnZohUUP3fcX/mdBb4blhBZmd5EzLmon4ufCrR0vhccYAi4CiycQpFxd8QEwL1LoPoWRC+2ROffXOcACo2w79Tyj+npUbezf00s+ySufPo5GyMO+hDC7cNMxEF/jqQl61thnWAPDKPzUyJCcPUp/TFcOGaGMpRKljs0eWIKdWQ=
Received: from CY5PR10MB6261.namprd10.prod.outlook.com (2603:10b6:930:43::22)
 by PH3PPF34C504C55.namprd10.prod.outlook.com (2603:10b6:518:1::793) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 19:52:09 +0000
Received: from CY5PR10MB6261.namprd10.prod.outlook.com
 ([fe80::4a7d:7fe5:63c2:445]) by CY5PR10MB6261.namprd10.prod.outlook.com
 ([fe80::4a7d:7fe5:63c2:445%4]) with mapi id 15.20.9031.024; Wed, 27 Aug 2025
 19:52:09 +0000
Message-ID: <53ab50de-04e0-48b1-af19-f1dbf60b0927@oracle.com>
Date: Wed, 27 Aug 2025 20:52:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: Mark kfuncs as __noclone
To: Eduard Zingerman <eddyz87@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Andrea Righi <arighi@nvidia.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        David Vernet <void@manifault.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250822140553.46273-1-arighi@nvidia.com>
 <86de1bf6-83b0-4d31-904b-95af424a398a@linux.dev>
 <45c49b4eedc6038d350f61572e5eed9f183b781b.camel@gmail.com>
 <a3dabb42-efb5-4aea-8bf8-b3d5ae26dfa1@linux.dev>
 <a7bcc333d54501d544821b5feeb82588d3bc06cb.camel@gmail.com>
 <c41268ae-e09c-43e3-9bd3-89b762989ec0@oracle.com>
 <0d5c5cf8e1f3efb35b1f597dae2ae2bf0fb9a346.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <0d5c5cf8e1f3efb35b1f597dae2ae2bf0fb9a346.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::16) To CY5PR10MB6261.namprd10.prod.outlook.com
 (2603:10b6:930:43::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6261:EE_|PH3PPF34C504C55:EE_
X-MS-Office365-Filtering-Correlation-Id: 905db564-a33d-4819-9c5e-08dde5a33508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0tWUDdtdkRMZ1dkYkVRS3VzV2FSWktvcG12TThCQTIvcHdRVWtFYjdPd1ZR?=
 =?utf-8?B?T2U3ak45UTFvTWp4K3E5S0lVUGc2ZjBOc3doajBwYjIyWHdCWEkvTUJ6R3R6?=
 =?utf-8?B?WkFZUS9FeGJwL1JpZ1JHUlg4Zyt2T2hjZmdsZXVoV0Q0bzFaM3M1blowV3Z4?=
 =?utf-8?B?M0thblJ3ZGhmTEJDb3Qvbkt5dGhmbVp2QjVUeFB3a00vTFh2K05mUFN3WnFG?=
 =?utf-8?B?ZVhHOTB6Z0RUQlZXT1hmaFUxTTd6MUhnN1lZZGNBUUp3Z1M2Sml5SmpxRTlY?=
 =?utf-8?B?NHNvekViVWcrc0RTU21xNnF4N2EyWkxKZ2FZSVhpSzFwQ0VUenBBMXpyOEdM?=
 =?utf-8?B?R3FnenRVKzA2WkRYYzZCNEFNS1AzT2hHN0E2SU9HR2tiMUFObXc1Y0NUaXNs?=
 =?utf-8?B?aHRNeWlmbmlRalEyTVNFUzZUWWpWU2oxTURybUlNRmRsdzRDN3hsRVlwVmdL?=
 =?utf-8?B?blRDbzZhVDdyemN5QU91N0QyZktsaEVlNlNieWVWUWV3WDk4U2kxWjNEZ2l5?=
 =?utf-8?B?QncvMDFncmkxQkJyS09sZlg5NnFENVdMN2FtZFg0WU9iQmVSZ3Q3OUpVTXNu?=
 =?utf-8?B?eVVPWVcwczFYcE5sNm5NdUZaUDlUUm13czd6Y1dsclZ3Ri9wZERORWdaNDkx?=
 =?utf-8?B?ak9FTFBHKzFtNGJwZm53Q08wWlRzVmlPKzhDSmpaWGd2L3craFN3cGZQeUtN?=
 =?utf-8?B?bCtRSUk4OFNjV2ZTN2M3RUQyK3dmT3d0UWQwZ3p6RmNweExGd2Q0WXRXZ3BR?=
 =?utf-8?B?cmNaM3ViTDlsT3hJUXBxcGpJeGk3eFFxdGlKV0lhV0d3d2hDcTZDZlZnSm1k?=
 =?utf-8?B?dExBTG8yWjRLS3FaR3J2R3AzeEhIMklhTWR2ZHV0RFFtTFpKNXN0QmQ5MHB3?=
 =?utf-8?B?RmdJT2xoL0grdTNLeVdEckZXRE1ZbStPdWgrbGRlNGx4UHo4R0I1Y1gwYWNO?=
 =?utf-8?B?Rms5MmFxWjVjcVVac2V6MHVjV3BwVXN6SGJ0eEwrV3krMW5GbzU4ME5HWFZ0?=
 =?utf-8?B?OFJjV3Nhc21WNDBYL0U0MzRVemJQS3ZHMHNTd3FFbVptcFNHcjlxYlB2WWcx?=
 =?utf-8?B?eVZwRVhMTFkxRXMzaW1iRW9ZTW9ib3dmb0p2V0VKMGlaSG9MVnRsRUdEbU5p?=
 =?utf-8?B?aDFINFRjWjRvL1JRQ3NRTHduczlPenV0bE4vTGhsOVdsT1FYN2FVem5ZV01a?=
 =?utf-8?B?L0k4d1o0M0R6bUVKUkRxWmZpNnZOWmtSa3kySDhXTEtNUWxZTi9DeHZGY3hO?=
 =?utf-8?B?L3BGQWZUNUFDbzY0bitMSjhza0c5b3VWVEJlY1lXQTdXQjEvZC9EOHlTMS8w?=
 =?utf-8?B?WXJkUU1jQTQ3NldwQ2JMc0JzZ1VLQjBtQ2RJbGdHcStsYVRkWUNETzZVUDA4?=
 =?utf-8?B?eUhMUlF3VGQrcDJFU3N2S3dKQjBaM3QrcTdlYnBPU1VQMHFiS3l5RkNLTnY2?=
 =?utf-8?B?T051UjZVZlB2bEpBc2lPZ09SYWJVY1hvdXFMWXhhTWowaUZFaEhBRVVKeXY4?=
 =?utf-8?B?bnkraXM2ZjlnVWE4M3RObzYwTnpZRDBiaUsrOXJHa1oxcVFKYmVwRHVqOGF6?=
 =?utf-8?B?RTgvR2tSdUVFS1Q3QkcwWWozMmtRT2lwOVV1THEyeEhMNG9zYXR0SERZWVpp?=
 =?utf-8?B?QTlrUkFhTUYrRkZPM3NYdHJLZXIxSHhVU3d1QWQrbllMbUtTWmxERXJTL3g3?=
 =?utf-8?B?K2ZtUktvRTRha3Fqb0c5b09YTGtwL1NmRjJaL2VyNFFqMGx1d2NleFR6RVdN?=
 =?utf-8?B?Q3FQcGdoZ1psRXRyeGdBbGRpUlNONmhLNWVnWmZiZXdoZDZCUGZ2ODVtbEM0?=
 =?utf-8?B?KzF4bXd3TTZ4L1BNajNpVFFORkVEaDlCMXJ5enZ3NGVBcStueTl1bFI2M0tR?=
 =?utf-8?B?Sk96c21FU1Q4YmJDZDB3dnhQeGltV0xYQzBNbEtYVVZ6ekE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6261.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnZjaWxDUFl6RVhVMDl3MGV1b2VpSjlVanIyMmwweTR1eXl5aElXR05mblA1?=
 =?utf-8?B?S01GVWV3Yk5MbGdlMjhaZzNzT09Lb000NHAwR285K0FDODluSDJvSThJN1pM?=
 =?utf-8?B?N21nOS9wdkhUQ1VHa2RjeDhpdzRCZktZalZZY1BSU1hGTVFTTmh3cTNhTkRL?=
 =?utf-8?B?Mk8xbWk0L08vZ3NLRUtYQk02U21scDB2U0M2NFg2Vk0wdUZUdXgyUjNyMFdI?=
 =?utf-8?B?aGJZVXVwaWdFdmZod1JkZFNlM1JnekI0ZURpZ29xYWp4SGpaTGtnK3h2S2xN?=
 =?utf-8?B?VGdFcHlEaWE5M2Y1R2RJK01jSWlZdGZPT29nWUJLbU1MMTdFSlZqR2VZTmlE?=
 =?utf-8?B?RDFXOXR5UFkxckNORjBKZVh2VHpaQU9TZXN5NmFCRXpUN0N4Nm1sR0xzL1Fq?=
 =?utf-8?B?NVBDSnhPZ0V1ZFAwUkpwd3ZFRWxPOGVGeEhMY1MzWUFic1lqdDI3YUJEbndY?=
 =?utf-8?B?RlAycGptc3VCRUNxRW1YYkFmZk9XckFNSjhTRkVtTk1Bd1dQcmMwbWtaYnJz?=
 =?utf-8?B?MHdCU0VnTkhzc2dQcFhDYzdSTXJ1bGVEZSs4WWpmOXd5VEF2NEs0OE4rODNT?=
 =?utf-8?B?RGNHUVFUZGdCZ293d2FKeUU2KzNrNDFPUFhFWU56cEZGUDRjUVVjc0hINkxk?=
 =?utf-8?B?bW5xSGFTdG4zTER1L3lvOUlVZnpKOVhhTTFPVkJuTjNJVHlOc0lXSFFXa2ZU?=
 =?utf-8?B?bmFEQVJpZ1JkdEVjTjNRMHF0elBTL0hpamJGYnlVVjhhMlMvNmVveTc3REJw?=
 =?utf-8?B?Z3Y4K1l6Q3dWSXlkZ3dwREowdG9jMFluSytLMGIxTGpGNXhTNkFOYXl3Yzd4?=
 =?utf-8?B?UWtyN0FpSDkrcGpKN1V3TGlpSm5LSVVzSXI2RWNDQ0NnKzBxSnFIY3JIbWVJ?=
 =?utf-8?B?RGVaemdpYStPQmZpM2Q1OGFKb242aVFzcnhjdHBnN091R0RZV1FYTTJRa3JW?=
 =?utf-8?B?N0NWSk5ORVUxaVNwa00vZkZaWmYwV1k3dXVuYkdvcXlHaFZwQi9XeXpFbWF3?=
 =?utf-8?B?K3Q1VFJuekNoZENlZFQ2QW5Ic0JGSitpU3dCVndYMFFMZi9YTXhVbXd6aEJD?=
 =?utf-8?B?Z1FGZXB0Q3RwOGdhTG9aNG5wVTRSb0sxbStPSXZabnhpMmV0OCtwN0o3OWFj?=
 =?utf-8?B?cWx6MUpYRGlHSW4zVVc0YWtvNC9uVDNGSkttUDJEMTNTOEZ5N005dkFWdHY5?=
 =?utf-8?B?SklhbGtZWkdTN0MrR1lQbEs5cnI2VDNjckttV0dOV1Q2R1p0WUxSVG9ZbTFy?=
 =?utf-8?B?YTB3eEpobDBkR0xjYjkzcWVJL3VKSHRYUGMrTGlUcWtFbmFUSlRoU1JadmU2?=
 =?utf-8?B?SS9jWDJPMkxHclJ2Ry9HbXVIdEJKMTZjZ3BCUTB4eWVKU0xyS1A5bkZ5WGg4?=
 =?utf-8?B?VTFCT29KK1JrRSsybzd0Wk44b3krSVhFY0NFdXhYbVhtV2RnNTRZS3AxSnZR?=
 =?utf-8?B?QzYybzdtSTJuUE9pMkJvYXhjbm1lbSt2MEZVWmhoSERCOTl4WkpyTFFBbGQ3?=
 =?utf-8?B?WGRJMEp5Zk1TWnN3akI5a21sM244R1gvSGw2RFhOcHhCRWF5ZVhJNmwydUo0?=
 =?utf-8?B?cFpCczZNSUJkRzVqSjd4N1c3dmlZL3ZNa0cwNGNTSlhuMUdUc2FxMjlmZ3k0?=
 =?utf-8?B?ODFWRis5M3hBOEVsSmtid3JuRzc1QkRwNHl5U2NHbHhoK0Nkbm5lY3F6TS9i?=
 =?utf-8?B?U3pUclU4Tzg1b2dLTWk2Q2FjRnk3dmhVWXZrR25wVTNKQmVWMytKTzh3M2wz?=
 =?utf-8?B?SmVudTBRbjdVMzJjSGpJZm9NMmZ0QWdUaTRLUlpYRGM1OWh5MzJLN2d1QXVV?=
 =?utf-8?B?NUIwQVRhSlVBaGlMU2VKRGMwaDFCUmM0TEFleGdOUXdKL3hxR0ZIY3YxNHhO?=
 =?utf-8?B?Nlp4VTRONUNkZHZhbjhrMkhzS0RrN3lUNUlvalBWVHI5QjZBb1VUQ3hsMG9X?=
 =?utf-8?B?WWg4SFN0SEtJVHFLZjVaWHFOZXVldGRLOHZNTFkvV0dUMFhEaHVsSzdmY0x0?=
 =?utf-8?B?WUM2aVpCYkZTOW45Tjd3eFVPTU9OUmxmMC8zcDNGWlVDcUJ2S1pIQ0JlSXZJ?=
 =?utf-8?B?eTBqUDhtMndVNWpNUE9FUVE2TWlyNlBYZEdiSjg4TXVNeUNtWi9jc0lra2RQ?=
 =?utf-8?B?T0NWSWQ3V1FqVzJWVG1QYTNXV1lXNGdab1BKdTN5TlhCMDNsMVFEMjV0MUFk?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+KddSTmgCChO3fxNb5naXL4xciyLS88ZGIaoM+dtvoLBOkcdifictmhcRXdcZPSx2jYfFr6ZsCB1IN+tnN+YS2iUSeYolPjVN7amwXkkXc/EIJ+O36OHFHQU+9KnL0o8gw5vkP+rKL8U8TTYivmYdREzj2SzQ43jeyXuNeQvMTBFjG9/6bRFATGqguKaMknuh5E+9O2aazx12OsMTxOndvDqNh8VHIr1y3mIzbjkvd4MNtVAm9lnyYWknI/8dYkvpWBx4DYpRa2XsWbJJGDlJgZfaD+rUc1MEqnt/BVOBW319SRrgio24ayH6jOhkI8ScKONIqnP99UGwyG7L1c4c17WkufEa0nRHOyaXGa1iM5kZXz6S6a0uyeP0gnRxsOi0Zk35bsdBeZKNOuqsQVsfNbEoi1AFemDr4miiFssE/jG+MCt3Z/IMDqKrgoLIkIXqrwGf/CLh1sw5sFG2TLs0HPHpIdY0gerzOEUgniNmW6FUsAvSVn8xJ9cEyE77hq/iEQoJOAT4oaxxlBOlV9A37l9Zz6EpTdfwVbEybJoMZXzdBRKpFBSyEaEujTsAJdE0jP+wG/Xi2woCxJJBE0XGE4UuzTNwuTJ4Nu3snFLo6s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 905db564-a33d-4819-9c5e-08dde5a33508
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6261.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 19:52:09.1002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7GguvBECz3Ry/Zm9aaDieI94vJq9rgbXVrjHBrlmIpha5iXITU0lRGEBUtfq1bV6GegQTm5flyx2z7IddMobbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF34C504C55
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=629 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508270170
X-Proofpoint-ORIG-GUID: bCOLalSmhyCn8jkrjXZHIqpB3z2fTcdG
X-Proofpoint-GUID: bCOLalSmhyCn8jkrjXZHIqpB3z2fTcdG
X-Authority-Analysis: v=2.4 cv=EcXIQOmC c=1 sm=1 tr=0 ts=68af61ed b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=JjdRYzZ7IvRskbZsJ-sA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12068
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMCBTYWx0ZWRfX/npiKzCea2rR
 frkVWytfxIb/th/+EyfjCWVbxE1BKqfYu0/ejFDQzhXx9g0Snf6u6NGKhgtIpckWbuXxjniJf96
 pIGMYF3nc31T83wmAL2d8RxfAx7fhVPwDCBXPKy0SSYc6k8EaImty5npYsN+mzGBRyExVUdJhQS
 CzC9Tk/OXqvDJPyevjWCvTZp+Sf6AmQJ2QwdlUmKMk6E7MioRrIGhjTP+lhcjAvPTMmqq0tXX+g
 5zCZ3jAm6SEf3JMSLdwtujhMFu48cN28j/ZlDm+ZNmrEKPVTdDXULZ6T/cWWkL7WLEV484xL6w1
 tbzKyw74gnFxjmLCr1U18oFO6RNeEKX4tPvAgdNrhbeaNBPyT+xYmd1116HrQDRrU8QJvCBzFNV
 W0r3XTs7tnJT+3WmBC20zIVHe9hVAg==

On 27/08/2025 20:41, Eduard Zingerman wrote:
> On Wed, 2025-08-27 at 20:28 +0100, Alan Maguire wrote:
> 
> [...]
> 
>> I'm working on a small 2-patch series at the moment to improve this. The
>> problem is we currently have no way to associate the DWARF with the
>> relevant ELF function; DWARF representations of functions do not have
>> "." suffixes either so we are just matching by name prefix when we
>> collect DWARF info about a particular function.
> 
> Oh, I see, there is no way to associate DWARF info with either
> 'bpf_strnchr' or 'bpf_strnchr.constprop.0' w/o checking address.
> Thank you.
> 
>> The series I'm working on uses DWARF addresses to improve the DWARF/ELF
>> association, ensuring that we don't toss functions that look
>> inconsistent but just have .part or .cold suffixed components that have
>> non-matching DWARF function signatures. ".constprop" isn't covered yet
>> however.
> 
> Is ".constprop" special, or just has to be allowed as one of the prefixes?
>

Yonghong can remind me if I've got this wrong, but .constprop is
somewhat different from .part/.cold in that the latter aren't really on
function boundaries. Sometimes we want to retain .constprop
representations since they are function boundaries and sometimes do not
mess with parameters in incompatible ways. If we can find a good
heuristic for tossing them when they are not helpful as in the above
case that would be great, but I'm not sure how to do that without losing
BTF representations which are useful. Any suggestions on that would be
really great; in the meantime I'll try and get the series dealing with
.part and .cold functions out ASAP. Thanks!

Alan

