Return-Path: <bpf+bounces-77363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC72CD90A6
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 12:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94799306B1B1
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 11:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2632232C309;
	Tue, 23 Dec 2025 11:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BGXhp+Mb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ts6I6Frg"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3E032B9BD;
	Tue, 23 Dec 2025 11:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766488209; cv=fail; b=swPInxZ+cf4e4Tmhsb4P9dAnBkTpEANEWIk6P6v/QoOHNOMlUc8Ru2dciU01DAgvkJm2SeYI269RcEvh61UIzq3yC/15g6/tpc+uEVJIrj99tTrHJ+oDGQWDyLZmh63fhenM/g3OXrAXC9U9EgjhaU/7APfPMRhdkQmct19ICG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766488209; c=relaxed/simple;
	bh=Q7JFirH8ZQxqVpHhyk1tqmeGGSwf+OOHgbFsNymh5O4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ssBcOKle9JJQnksx1jmB+rIOTUcmSZXdEW/LBI38oD+j6bGTEjjeP5DozVbE8pyiaRL9LUZcQCO5Y8R8JgYATcXKvUnNdPEhYcjcZr+g4cTx4PiMh544cj2b07yvvZfA5wOt7loFFm8HAnvYaNilCbhb6oqyQcnNorQCE0D9kwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BGXhp+Mb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ts6I6Frg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BN9XTPs067936;
	Tue, 23 Dec 2025 11:09:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lPGu+B3Cs8AgbA3IuseslMf0IkTlEFBFizgClZvc5V0=; b=
	BGXhp+MbHriiU8Fz2bZXPg2FatXs0JHwXLV9LjhVRHBYA7JqvoLVH4C3/8kbL7RP
	TPBVgwgBaMyJvokx1GwvyizRnFsZUdKP9XB6IPJ0Hepmxxn2NrmUA9WhRElGL5Au
	cse240JG/7+BSPNdt0eIEFqVM2PMtj5+XKNFV2JGfAqdQAXd2JgJTK1emkSsoo5z
	ZLRBg9skVAcLo0JRkPzOpDr1KgfqdbB4FL0cAGyTxsT45KYpYaNO5Is+BcTfUr8C
	FkiOS0q3tispsUFjXim8iQ8Yie1pOz7GUPjvmInvt8h8I2kv2MiHEkP7IekANfOI
	uvboF3yzUhevP7A55/KZ2g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b7rhy02ht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Dec 2025 11:09:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BNAs9LG000490;
	Tue, 23 Dec 2025 11:09:38 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013000.outbound.protection.outlook.com [40.93.201.0])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b5j8jkq0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Dec 2025 11:09:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uhEaj8+NjVJmNfCa7Ey9uyNWLFnJWq6+PmD+hdonUYKIrKqT8U1yw3KFsarZn62JtCcOhPQy2m1ysYIKPxCGJjTq/SMmtme4KqmZB6iGVhzAZXen1104GsHVoZh+tOWz1hVOopK+PQvzQDQagj51+KnLSxe1rkYTuSjsX6xn7EYMkSoNJFUCsAeTWVf7RhSUrhGyF8wjtoH+coZeMtWzZwEwr2wlM8+3d4GPH6hItsj9Jox1cnxho1TwLbiOPqihlB4toHUB9WOc9M38tEd68ZsDOM67U8DTtP75p7hka7iLVyrVF011zhH3x4ERYFwbQxX6rotpLxSsUgMqTiPx8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPGu+B3Cs8AgbA3IuseslMf0IkTlEFBFizgClZvc5V0=;
 b=Kjt1dR3ZUvoBEvs1m3bG97OADe6c5qc4NcHfGxkbgh2RQbpO4Rk6OQyUvWDc4Yrt5vUiCyYS5rrjBVq945GCJxQQRgeL2ejpRCWlZFYbjldV8xG3/Ysjrqg3QL+Hp2FVkSd25azvZJrZJQRZQuj7+gvm4naOoMeG0nYWFIrVBnaXeTXLvCHZIyPv5Hlvc0SlB4GP1ga7zaoFsefeIgA2PhGw0kuS+WJXgb/c70JopnUfigfNXbu7Hj3jy3I1Q4qqjqjctHdLmIf93ZJ+kaEWOSZXQ2AXkjTfVrTYPFHoTzTpjakTcvQ5A8aw9RxKpWVfgB13xmxfnRkUWk6am8aUYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPGu+B3Cs8AgbA3IuseslMf0IkTlEFBFizgClZvc5V0=;
 b=Ts6I6Frg0UJbMjAK73ptebGEVh0p5o+AD3YrFKZGMyVK99NttRQ1Q0MBjIF8DzDpCSyGBHW4eFYKoGvmLu2aynjhi+j6CB5iSWb68S/jFr+oVuliNrC+lzBp9qUeCoM5UgLsej0b0tGqXku1sqnsuwywVhHVeHvnhS+xNzICePc=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 CH3PR10MB7259.namprd10.prod.outlook.com (2603:10b6:610:12a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 11:09:36 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9456.008; Tue, 23 Dec 2025
 11:09:35 +0000
Message-ID: <19a4596d-06dc-42ae-b149-cc2b52fffae9@oracle.com>
Date: Tue, 23 Dec 2025 11:09:29 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 bpf-next 01/10] btf: add kind layout encoding to UAPI
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
        Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Quentin Monnet <qmo@kernel.org>,
        Ihor Solodrai <ihor.solodrai@linux.dev>,
        dwarves <dwarves@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Thierry Treyer <ttreyer@meta.com>,
        Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
 <20251215091730.1188790-2-alan.maguire@oracle.com>
 <CAEf4Bzaw6KRU2yDbawOe+eusCjCwvg0FwhkpvGA3HE=gC=ZLbQ@mail.gmail.com>
 <42914a9b-0f34-4cee-bc36-4847373fa0b5@oracle.com>
 <CAEf4BzZuikZK5cZQyV=ge6UBKHxc+dwTLjcHZB_1Smw1AwntNA@mail.gmail.com>
 <e2df60e1-db17-4b75-8e0e-56fcfdb53686@oracle.com>
 <CAEf4BzarPLAcwKApft_nBVM_d3WW58zytZfLQVz387TF2c2FVg@mail.gmail.com>
 <CAADnVQ+achE6ebfCxyfHyxMMFJ-Oq=hUK=JkWUAGwz+7HeV4Qw@mail.gmail.com>
 <22c54404-512c-4229-8c93-8ec1321619e0@oracle.com>
 <CAADnVQ+VU_nRgPS0H6j6=macgT49+eW7KCf7zPEn9V5K0HN5-A@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAADnVQ+VU_nRgPS0H6j6=macgT49+eW7KCf7zPEn9V5K0HN5-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0182.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::7) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|CH3PR10MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: a23e6c87-f55f-446d-9603-08de4213c1d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHBWSVF4enJ2bjF2MFRTbTF4UTJqbkJ4dzhwQkFPL2o4WmtxRGxxRU5BV3FO?=
 =?utf-8?B?SGlJam9IL1ZZc0xVSWYvZDBNcEJqbjFQelZNK1pkK2tlS2NxOXhOS1k1Y2cy?=
 =?utf-8?B?OHYrZURUMjl1YWhVU0lmcEZyNmhXOXkrcGUxQ0pQaVFpYXo5dUt0YUxKUTB1?=
 =?utf-8?B?QmxsTGVHWVJoZUNOQlhGWUpGckpPdFlnb0h4TEJKbGpRTVVZMTZsZ3QwMHFa?=
 =?utf-8?B?UkRKQnJ0T3lZTWhpamowOEdOMjRQSnNaU3ViQ1V1VnVlcVlyTW1pTkxtM05m?=
 =?utf-8?B?cFgyRGJTWngrTmV3Mk9IY0VNaFMwYmM4TXJvK1lQN2RIZ2NDWFNUNzRqVjJX?=
 =?utf-8?B?a09YZnVKV2FVYjJDb3lKd2J2c3lPdyt2NHhZYmEvaDNSTmZtamtxRTl0QWw2?=
 =?utf-8?B?Z3hVSEVOY2dZNHdDQ0x6WGI4TU5haTB3RmJvY1hvVExraGZiN0hYanQ2aWFj?=
 =?utf-8?B?VEpkNnhDUVlyQWU2MVFBRk1ZYlJGeElTaEREY0dDdjgwclRFa1NIUkI0aEJH?=
 =?utf-8?B?SnZzakJiRHhGRkVuNW94V2l2MWhvV1F1dTRWTzVaalRpcmp6RkZlQUtudG1C?=
 =?utf-8?B?WjN3U2l5andnVkgwWWk0Z3crUlMxelRyVXdmd0ZoQlc0TDlIYVhaTDdtSjZi?=
 =?utf-8?B?R09neU1nRnJXUGlWYko1S3NVbHlGeU8xZ0dxMTN2QVZ5OHVYTGZQZjd1NjND?=
 =?utf-8?B?SnY3MGhhWURBVTFMdk9JZkxHVWh5NENzQlVxUFV2N3A3endNek9rdGt4aEVi?=
 =?utf-8?B?Y3dXb0xSMFVXUzkwWEpYME95R2Y5cXJwQXZEVlAyYlZFZHdzdVZtMVlvMTE3?=
 =?utf-8?B?WEc1bmZObVV6c1NGd3hJZjJqVmEyZktPWkdIWC9NTGVrR1U4SXZTUDNzMXRi?=
 =?utf-8?B?N2VlSGdTcXlidXJQRW5ZZlV6eWE1Z1d1eFl0YVE0QkQrY3hTYzZldE9pUFNW?=
 =?utf-8?B?Z3VtWmtlV3NrWXREVGxJOG9ock5UY0prMTBzL3B4MEZQZWdRS3huT2kyc0Nm?=
 =?utf-8?B?cGd5d3lmZHA4RUJ3VmJJd3BKeFJhaEhXNDNWdWxnVSs0ZXdDMmdOb0dqbHAv?=
 =?utf-8?B?YVZCU2NqMVNuTXZKQlBPT2xlSkFZNndDK0FYTFZNZHlsbE9jcXFCYU14cnJO?=
 =?utf-8?B?R3dJRjZUVTVsYzVKbllFdUltOW9rTURPL1g0TVUrSTNvQXhkMFo3ekJxRktZ?=
 =?utf-8?B?RFdyaE5JWE94ZkZTUkpCcHNnQnJ3NlFkVmJUU1JKSTliK2pjSmx0OGpyOTVV?=
 =?utf-8?B?MUpjbWUrVDBhRFJjdTNVSnZJZjNHd3dhbGtnY2MzeGp0MG5scnpFaFcxWVVr?=
 =?utf-8?B?dCtZcFdZdGNYanQrQ2hzMkc2WnBYOUtMWUJKM0NScXI0c1R2cDJEdWlwTEFE?=
 =?utf-8?B?VW94cDI3VVp4bVR0TDRZVEVlMm00eE9YWkcyRlFseG5JeWl3a1AzaFN3UFdG?=
 =?utf-8?B?ZkMxNFhlcUFFNkQ3b3NUODJlMVNXWUY1YjE1ZjF5UTlsa1ZDYklPdE5YejN6?=
 =?utf-8?B?MW5RZCt5cGd3WW90T2pldk1mMVhoZitmR1lsN3ZvNGlyU0VkalE5QmZKT0VE?=
 =?utf-8?B?WmhDcWswaTRuVEZDK0lORkFBUlZnT25kdGxUejcwUFdUamppdnFUUzUrSERE?=
 =?utf-8?B?OEdtZ1hIVXJJTnFsb21SMUZPZ3llaWs1RWE3Y2Z5ZVJsMnkzZDByNUhTVmtN?=
 =?utf-8?B?TFMyWVYzUFJwV00yOGdWSmNvUm4vckVIVlREc2pPQjRHWFFkbWtlQU8wYkJH?=
 =?utf-8?B?ZzRLdDR6YmVvVzZKa2ZPK083Wng0WEJvSFhPd0lSZkFvNWhTSm5xT3hESW9E?=
 =?utf-8?B?MzB5ZGt0M2MwNlJUcXlCVzl6WjhDVHIrWFVnMVFZSnk0MVZEMHNlVmIrOThF?=
 =?utf-8?B?d2ZXcmk0RHFiRWM1ZGhZRXRqWW5seVR4bTN0a0pGODNrQlF1R1hKTXJmK3pN?=
 =?utf-8?Q?60J6k4l6I/Qhs+/P4FkxXW2HLhBG9lKJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2RobHg2blVNME12UlJpdlFGM2J3bFBkUFNKRHZTUnNJWUdVUXJEZDZyTU16?=
 =?utf-8?B?UDdwYmlnaFUwYTlISldFT2ZrV1hrYTExQ21XMWJaOUxoVkkwVjVkekxxcTIw?=
 =?utf-8?B?UWR3MTBqZ1VkU2FMeHNuOGRWaVRWRk9uV1o0UmVTVGt4dkgyNUhMWHNYQkx3?=
 =?utf-8?B?M05abmk2TG1PWFB6UjEydjJ4S0U2QnpEcGVEL28rZ2tBSUVXWWMyZElySFNz?=
 =?utf-8?B?QmlSbXRLV3dYZnhJRGNpWTdJckZmbUlMUnNSQWFsSGo2ZEgzV1JEcDM1ZXVl?=
 =?utf-8?B?VTcvV2hHNTQzcUFFWVBNSWhJdmM1Z1g1czBKY0oycHh4U2xIR3F5S1B6YzVv?=
 =?utf-8?B?UThHODRFM1lJeHMrZ0tNMEFqcjR3bGFIVkpJVU9aVDFYNmY1LzVkZlVTSm5i?=
 =?utf-8?B?L0E4SDhibW1NTmEvZGxMU2JPRzY3SWFsM0Y5UnBxTTN4WmFzbFlPaVg0RWVu?=
 =?utf-8?B?emtaQU5nUUdGcWpkSG0vak5UamRQWURsdytpaWJQWDl5WWI0cEVXbGJSN0VX?=
 =?utf-8?B?R1V2Y2VaK01CMmZoZ1o4RGZpTjg3WCtkQTBGbXd4ajFWenhxcC8wMTJueUVq?=
 =?utf-8?B?TG1SZnV1ZlJFT3BPVTc5NmI2Z1RWQ3dVVjRZVzdDNU1TSnczZit3QlZnRmdl?=
 =?utf-8?B?NVpoSCtEVDgwdE9xTU05Mk5GeXZORVQyYW45R1F0cHJ2bURUanVXcWlrSjVw?=
 =?utf-8?B?N1Q1SENTMUJSL1BEcjBqQXgzbVhrNUQxUVY5eXZUeDVlM0QycklLTzJxVHVP?=
 =?utf-8?B?QnUwSkhXSkdWYnZKTVBmckh4c0ZLMVRMejhPRWF0S3pya01QUFNXTHlwVDVR?=
 =?utf-8?B?ZVh5MjVoUmQzRDZ5OTFjTzdPdjltMDNuaXNDcWNVS2ppTldqM1BSVHdUOEJ0?=
 =?utf-8?B?TXpWOTZicER1NUp3SEFzNDlHNlBQY3ZxQnN1REhCSll4OGo0WENJUVVQR25h?=
 =?utf-8?B?OWt2WTZQU1ZHUW5zdHZ4TG1yeWw3VGN1bE9MRDVvZmRzQzZRTUhOeDBsOWtT?=
 =?utf-8?B?UkRBMDZiem0rOHF5ZU00Y2laOXIwZmNoSVBVVFZMaFRWUTJzWnZFeTUzZUM1?=
 =?utf-8?B?bWVodmxxSDNCMUJHSjFjazc1cU9GeXFEck9UL2JKUjBLdkpxMjQrNmY2RkM0?=
 =?utf-8?B?ZW1XSlNQWTFOZGw1TlVXYlRRUE9pYTZmeVRMK3hzOEcwZlBLSmhjQUg1MlRM?=
 =?utf-8?B?UldsZnNpcUhKVHozVG5CSmI3UG5KVFMzcDdUUWpldEJhV3I0c3JIY2FKOFQy?=
 =?utf-8?B?NUYybUgxSUh2SjlIZEhBV3ZjMzYzeGtRNXZhTURwSTJ5U3lQMGFjWERRUWVi?=
 =?utf-8?B?c01ud1FRVkY2eG82WjhjVnZPNXlESVo1d3A1L2JaZm1LK2FseExRUTBqVENH?=
 =?utf-8?B?Ry85S04vWS82NGhDeHhCUEs3elJFQXd4SGs1dTRUcHpsblp3WnBiNkdPUlIw?=
 =?utf-8?B?aXJtZ0I2Sjc4NWdZY2k3alpuRUhncUw4RzV4VktSanhlNGRyaTdSajFmelJT?=
 =?utf-8?B?STc4N1ZtMU9BcEQ1NU85M2hDV1RzbjJEbTRTYi84eDRmVlhjaE94WnQyMUZT?=
 =?utf-8?B?S2xqSGI1dGJtU2taTW5WbEpuVE4vcE5pRFYvalRibTZxTUZSclJQazRQOStN?=
 =?utf-8?B?M0Q0czVKQnFUMEd5L2Z1aTVHTDJyYWR0L3hrLyt3aGRiVU5aeG4zaDhsTGlE?=
 =?utf-8?B?MmVvK3dBZzFwcDFEeGpXRnJ1VGtoU2pmcWZCYlFlRHRaSmwzZ2JBVFh4S095?=
 =?utf-8?B?ekhMb1BDTkRZVGk4MGNPY0hmck1mY05ibW9MQXRIbS9PckZ0MnFqSTk4SWJ2?=
 =?utf-8?B?WmkzVmNGYkcwY1k4ZUFXTlBSL0RwRDkxWUNzekZrMHk4bklXakZjOStzOEJj?=
 =?utf-8?B?V09RZDNvdjcwSnRENTVNaHhTcU51Q1JSODRCSGNhQk9wWTE4ZFpNUGxLNExT?=
 =?utf-8?B?LzBieXRMcGUraC90U09qdi9TQzJHL2l1QnlGNlZXTy9lWEliV2RUeTRpb0Yv?=
 =?utf-8?B?K2NlYmxTZkU3anNOTlhmb2VLZ1gvRndpRktERnQwRCtKM2p3N05DVC9UNVM4?=
 =?utf-8?B?ZFd4djhDaDNWUVBqUDZmQ2UvRHU4SS9KMDRKY1hkLzFqM3loRk11cG9iRjUv?=
 =?utf-8?B?VS9WY0kxb05rbW9Gdmovd1Z2cUc1MXZ3R2ExUjM3UEVnQWt4YnRWOUR1RHRa?=
 =?utf-8?B?T3paSG1YKzlRNzlkL1hKajV1RWZZTVBUNzJCVTZzN1pLOVpvTTU0c09IWkJM?=
 =?utf-8?B?dGYvQUtQSmhyWEdLdUcwSmtWbEllN1YwNStwK3M4ZTdLcU9ud3hXQzBNeHhD?=
 =?utf-8?B?SWx2ZmRhMytuV0t6cHhyWVAzYnpiSHg3N2gxanM0WkpDTkt5by92UT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qzaxTyySugVxGzfLvT8W7IdnhIJqRov7gFBafoSYZGeIgKfUMpwQAb0mD9adqSEq9sd3ET0fe9W94+OBdQqsx4jXlOLDUdRXZymP+rw7VRuVPi/KqBFjzqMcqzMrIlw3BBSBDPUtSETsbhQ6WyOklRxevMfAIuB2JMiSD+AEpDiv1ZV+lnrxuxyKlMlBJvlZ5RLWl/kDOB5Kx9tmEKaWSKaTGje6R5EmaCdt+ASfryAaIyEh+ncdbXnoRCxOErVbxgrFQOhJDCLzEsLcy8Fsdoo2Pr9QSlZnxfmj3b0oFlcxbC/C+SbssPbWpBbDAPYdeUSuEQSR4KjjXnDAghytnk04XggEHoxLAzpH8KzVfDx+yStugpwC2SSFgokMAyi97+XXc2tTiY8+zfD9wltkPtzwg0CmU0MK1stezmvFwFEHPsoolpQpkO5pw8lEoQSy0pB6DsrwfrDag6ayprOILyz/gzmlg34/o+ND2JXKryOo/1W+ZJMU9j2N3Qd4Q7ucOl6NIRBveVXIVkLPaBR3AykQ+gpH7PC/reVu3rgaI2PTLyDeqvJgeIWRwI690sb+WL2a+LeABlTt0FZSqm0vNv0QzYU+Z0tmtjVeXqWoRP8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a23e6c87-f55f-446d-9603-08de4213c1d6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 11:09:35.8525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 145Rmlqhgzx01HNh8vbi1ZRtxsKVDala1RWNuefUycy7TQFLv3/W09ORJYtUqmOb2TTcy97ErHffN/2X9y7lZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7259
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_03,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512230090
X-Proofpoint-GUID: XOWx2hYASXRALWuDC6uMcT3pvPFF8eJ0
X-Authority-Analysis: v=2.4 cv=SM9PlevH c=1 sm=1 tr=0 ts=694a7873 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=JwIzlVgTJaO5d66XA6sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12110
X-Proofpoint-ORIG-GUID: XOWx2hYASXRALWuDC6uMcT3pvPFF8eJ0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDA4OSBTYWx0ZWRfX1KjVmLzfo1P7
 HGYlmyxT2oi0805M7PPbDlNBkXaooICmm19PSZFn9L3Q5HgJ5gBBvI2Z0iAWckNuYQsd4YkgajA
 gBWaX2+jIo0IikJGRwIMULZudKMMgtVb3QdyDL4KGTISVTiAJRUEJsdUDnciIfAxi6a6fsOYD8P
 mY5BJU2Z57tcMwKHE+Fm3P+Bi5R8R12olbSr+tAX9Dd8QnPwxy22jZSBNxLaUaJP8hQKxmkHMt+
 h13exOpQHc2pt+LPI1jPGXkVOm97BjFww93YZn6L/9sxtPCskUXFXRbFjNeMOPbzv3AXou2KA2d
 yVCDhhabXemlx6DLrGnnGp4X/NOASPpX7DLB2MWlj1ZJD3FQ7yodSxQjD4TNfZzQEyEES/EvK0a
 JkXzXVUmTHIja6iM9P7or2XxY78r4Qm9azNYAxsBpVyx90Vs7nnNMbq+KjRzM4HJVXx+HLsMn7I
 t55fWuas2enaTHdSfhcn/YLoHfeKHy2BZd+EaW98=

On 22/12/2025 19:03, Alexei Starovoitov wrote:
> On Sun, Dec 21, 2025 at 10:58 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>>>
>>> Hold on. I'm missing how libbpf will sanitize things for older kernels?
>>
>> The sanitization we can get from layout info is for handling a kernel built with
>> newer kernel/module BTF. The userspace tooling (libbpf and others) does not fully
>> understand it due to the presence of new kinds. In such a case layout data gives us
>> info to parse it by providing info on kind layout, and libbpf can sanitize it
>> to be usable for some cases (where the type graph is not fatally compromised
>> by the lack of a kind). This will always be somewhat limited, but it
>> does provide more usability than we have today.
> 
> I'm even more confused now. libbpf will sanitize BTF for the sake of
> user space? That's not something it ever did. libbpf sanitizes BTF
> only to

Right; it's an extension of the sanitization concept from what it does today.
Today we sanitize newer _program_ BTF to ensure it is acceptable to a kernel which 
lacks specific aspects of that BTF; the goal here is to support some simple sanitization
of the newer _kernel_ BTF by libbpf to help tools (that know about kind layout but may lack
latest kind info kernel has) to make that kernel BTF usable. Both address mismatches between 
kernel BTF version and userspace. The sanitization available in this case is quite limited,
but it would work for cases like BTF location info where it's optional and doesn't get
entangled in the type graph. We could call it something else if it would help distinguish
the concepts, but it is a similar sort of activity.


> be loaded in the older kernel where the original BTF was
> generated for a newer one. There is no reason to mangle BTF right until
> the point of loading. Presence of a kind layout helps user space tooling
> to print it, but that's not sanitization. The tools will just skip over.

With the help of flags, we can do a bit more than just have bpftool print types; we can
also support generation of a vmlinux.h in some cases, support some fentry tracing etc.
Anything that requires a close type match or relies on the newer BTF features we do not
support will not work of course, but it still salvages some usability when kernel BTF is
newer.

