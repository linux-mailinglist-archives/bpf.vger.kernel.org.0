Return-Path: <bpf+bounces-38548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFAD9660BC
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 13:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99F261C25208
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 11:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CC9199FCC;
	Fri, 30 Aug 2024 11:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R92uDccr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B0kuid4W"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9161218F2DA
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 11:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725017191; cv=fail; b=c91FZ26FbRIEoBrMiMQSYP3A1Cku/NtMYDvVmOsL9XhbQKsUr/GlQQb7WhvP4r5rHD1U2FDHT2yLnMLB4j+/eG74zoM7UA+zaTwSw/s8YX0sL6X5iALs3wm4mrvGFDMPAYMlbGwSXBD3bx8gjNRJp7ED0tehtrZMo+mgrcgHYsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725017191; c=relaxed/simple;
	bh=2CGSnCWzoTLvQJAxLQyu0IjbwvHYaXq66rNW3br+y40=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aZzyDQ+6LnKBwTkfBMam7n8mYwkHOttE/06FuBn7MX5P5ULqUhLac9JmSk+NXAFfJsIB3xP99y0/1S2Hmq+LpZ951GDye/gHHqBtvDkWlQXEaowjaOMx00wrWYsAagPY43/dgPgsFqb+yp4jtnGnzTSCn8FLexYSdHQFwjIsy1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R92uDccr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B0kuid4W; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UBF7Bv014159;
	Fri, 30 Aug 2024 11:26:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=EEKgY5Aq8WAq2/XV3jUs5blNEB79wygl20yotEZI8rI=; b=
	R92uDccr0gWwnmJebs07uH4fGJYKXvbr0Qjnlp3Qx8RWjw/DXQQ4Hb0dccLHsiC0
	ixyEBD7zzUZ+kdF/Zy9yFehIODLIgClVD5TSxnOvL7l72nl+TZXuY1ZRBU/DVB5s
	MXq+E4mehYP9T/bJ635BOYfAeNhfM8qM1Vvq36MxqhiMFzpEYrNQiRb/NcpeERUk
	ct9LmSAZMnX9vudpbOApz2LAARH/QuEk+yxOuovXo2ZnR6qfbnUdIKCz/LrHkPg5
	U9harDmIkzGVqhmH3G7zdTNZNV7w+qFr1PkLIYNKqWNfO9x5/IWKxv7hUFsWOCUA
	IyQzL5KH8cL/HFPoSG/iwA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41bd1gr0mp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 11:26:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47UBAIJB031739;
	Fri, 30 Aug 2024 11:26:02 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418a0xxsas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 11:26:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DkGLUtNHrrxpMAXM0iRN5iOKhQQH9oYSOsAYmOfpHeoZEX06TOQDMoXa5XnLF206YvYc6/EeHbNlXx4l/pNJOCjY+r6tBPs9bI4DLwO1OVjELYgZObQHrzTDXiD2dUtfZmVLtHo0SkVNumBeEBqLOy4+WGY3OmQNqO6pJew94FKFC+GRdWjhwh5SbPERzX6dXM48eNtQSa/SxJKD7NuUswV1zp0FFoBjKBAdIWrYJHTYPGmG77pwg29dKPcaUBy/3rtv1ZlMaWC/JU4/SbXqDLGggd0pdWaKRlZm7QsBBDVwxlz4qNUT2eiBMgHxtP03nfMWk8LzFZl5v5B2cwd5hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEKgY5Aq8WAq2/XV3jUs5blNEB79wygl20yotEZI8rI=;
 b=M5wTwVodgEdkOmM4geGM+OHh0hhCqsoO+9oUDEd4jI0LrfNt2+LE/PZDk5RM3+G5ZNuo7IjcXuaqOVGMTjB0TOme15Dgr/B2x1oBFtSwLZte2myke5Y+x4RBJfR3hEbee42CijTr+08L7hOduxB+Bfr54aOQMekA0SzKWVp1Vzj9/ckX7Xtkwt7+PpzXFUJVo8sB2AKMHMd5Ec4qBmxb/iUqyjpZCezi+HvtRNxKUC2OUvu2KW1xm2g46gIJTsrMkcUgP29UiX73rQ+sxDZiAdlqM5HvB7KRlf2OrbY4M8qmlc+biWTH+PHgnsNq7ptEY00/lVGrzvEXzkSJLEAX+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEKgY5Aq8WAq2/XV3jUs5blNEB79wygl20yotEZI8rI=;
 b=B0kuid4WY5PmpPh1L4x1+ddxxTReKZ6o7i7G6p98sDTu60/CR+BSmbTYPvQRJ/Z1Z5dFs0KFNt6wbzM+fcNI7LxuNZJvpjPgomgotdwKJ+g6kuoEEZT7nw0piYTzo5RP31AYtIJR5dOOTfpYy/tpXLJVyM7xtMG0Z1uXWOGVZLQ=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CO6PR10MB5650.namprd10.prod.outlook.com (2603:10b6:303:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.19; Fri, 30 Aug
 2024 11:26:00 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 11:26:00 +0000
Message-ID: <5d5fe5b6-49bd-4ae3-8d6a-973ec627624a@oracle.com>
Date: Fri, 30 Aug 2024 12:25:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1] libbpf: ensure new BTF objects inherit input
 endianness
To: Eduard Zingerman <eddyz87@gmail.com>,
        Tony Ambardar <tony.ambardar@gmail.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <5be4f797c3d5092b34d243361ebd0609f3301452.camel@gmail.com>
 <20240830095150.278881-1-tony.ambardar@gmail.com>
 <7425efdc2c8f52a780e2b4817e15911f8dd491f2.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <7425efdc2c8f52a780e2b4817e15911f8dd491f2.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0548.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::11) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CO6PR10MB5650:EE_
X-MS-Office365-Filtering-Correlation-Id: 1deac6df-fe6d-482d-7095-08dcc8e6863f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEgwVzZIUy9teHlJeDhzZTk1VndjcEI1SVFGNnVGb3k0VHRsUm1jN04wOUxO?=
 =?utf-8?B?MHdidjFtRkNla0xBWFV0MCtQQ2t6YzlWMW8rSzFjOE9kSVNXQkZpK2hQalMz?=
 =?utf-8?B?WU1JMU5GeFJjdmdBWHhPNlRNM1hwRFE0NU03L2tnYVpMdDJyeisvTmJxc1VE?=
 =?utf-8?B?clBBYWcvRXJPZjFpcUpMUmtxNzU3aVo1SUt6U25zd05BK2NtdjdXR29CWFNJ?=
 =?utf-8?B?TzBEWkRLZW1rMk1xM3JudFBqdUhza1YweHg1TzNnZkl3TWZ5QUhKWkl6MFEz?=
 =?utf-8?B?Z2FWRm5na3dRQkkvNmZRbXRIQ1RsSGJ5VVdoalhndU8rNm8zeXYrTFp1WHNG?=
 =?utf-8?B?NXI3blRFMjNmakl5YmV6cDk2TWJLWThleFFMeXFDNVhSQnIydUhnUmZOVWV6?=
 =?utf-8?B?WHg3VTZiZmk5bVNtRVk3ZXZYcDg2NWtCZUhMa1E0OWM4emcvZENuejBwWG9t?=
 =?utf-8?B?aGV5RHlWb283aTRCY1RBU0IySWhSanZFRk1aOVlhcW90U3ZzL2l3SGFwcisx?=
 =?utf-8?B?UHhhTjFYV2h0WWs5MjNuOW9iRm1QQzhiTExhcGpiNkNCK0IvQmV4cUd5YjM0?=
 =?utf-8?B?M3NKS0J3Y3I0RU5DTFVOTmJaT2h6TWpMZStyNUVHUGtDM0Z3OHBWbW1TRy9Q?=
 =?utf-8?B?ZFJQS0ZMRTlZbkd3VmRSOXF2dS9TcDh3dWtadE5vN2ZNOHdDRm9UYjdWdEFi?=
 =?utf-8?B?aER3dUl3KzBUS0lITS9BUERDa3BQL1lWVlB6RWsvQkxuSGdsMzFnaHl6eXRF?=
 =?utf-8?B?RHB4QnozK1lsR09yZDExbExKa0RyQldGbGFPelU2T24vSm5Nd1dicEpzTUxk?=
 =?utf-8?B?SktyaVc1em5qdCtBdk1KUHAvdjNGcUF4YTF5T01WZGlJT3h6dDB3dFpFVlJE?=
 =?utf-8?B?cVl4dW9OMXZkVnVCT0JiUjdWdHZqbGt4K3gzQlpnZnltZVFPNDNGYzRsVkhJ?=
 =?utf-8?B?SHJ5OWxGZWQvS3luT1BTeTF4LzdRNmgya2x0dERab0laQ2Y0TW9jc0YzYWFJ?=
 =?utf-8?B?NzNjeEp0dDYvbjB0cU5KQWFDRTdQOGZVOUF2N3hLdHZpMzZ6aWloWjFZSW9U?=
 =?utf-8?B?OHZuYXdwbTEzSG04M3VKQk94dmxLWm5LMXR5N1pldVdLeU4wNGxsaTJmL2tC?=
 =?utf-8?B?WVFTMHA1YS9rVWl6Zm5wU2xYN3ZaNWtsd1N6T2ovaG5oVjBZNSt0Vjc5WFI5?=
 =?utf-8?B?V3U0RGZvRUg5YUtQc3cvUzg0SzJRK01BT3JTOThqanNuc0Z1Zm1ackRzVldW?=
 =?utf-8?B?YndUN3VEcG85eWUweEV4bDF4Uk5ldTdUdWZMTCs0dHZtelY0Vm04OUd1dFMx?=
 =?utf-8?B?T3A1c092akJnL1lqZTVBb01VeGQ4anlMaVVjbTZVZUlQc1BYUkorV1V5UTJU?=
 =?utf-8?B?Zm0wY3NkZWF6RDQ0cC9sR1dmV2ZFRlBJTGIrYUtIOW80Zi9FR2h6aWRZTi9N?=
 =?utf-8?B?RGV1aFJEMGRqditDZEprV041cy9BOFRvRDVybTdEMlZqcDc1bFo2Z1JETW8w?=
 =?utf-8?B?TGlEQ2JieDNsVnlPc3Vab3hKVXZmV0lkRFZ6RXpncHMrMURoVVB6alU0T3F0?=
 =?utf-8?B?L0RnQ1dGd0pHRlJ4bGRJWm5jTTljb095YXM5bGE0ZkFUcis5MjZoT0VSeko4?=
 =?utf-8?B?Z3YwZjZYd2FFa2kweE5IRVVnUFFNRlUySitjKzI4QW9qMkZERUwwQ1BlU0Jh?=
 =?utf-8?B?WDFReUFjdXBncEd1UE0ydUxoN1dIbkFIZ0lydkhvTXhPVld1bGRod1QrN01r?=
 =?utf-8?B?L3hyMG5ETzFQT3VtcnV0NDEwbnRUWXplVDJXM1NKalRTV2dESHVxUks5SWpu?=
 =?utf-8?Q?ZS38eKzJEKIywqOOgsqwON/jTFr3MuuR2N0s4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWoxbVh1QlpIemJrZ0tsT09UWGlrZW0ybm91dEhrZ2V5ano0YUhTVWhJSVM5?=
 =?utf-8?B?SWhaYUgwUUNtQndyMkxoQkZTMzFSZW14cFZtbmFvNURzc1Via3JSbzBnTWFy?=
 =?utf-8?B?eXhQWGxOR25WalRlQ0U0WnR4bDl4cjRYMnFORmtySHBmaG8yU05MaCs1Yy9U?=
 =?utf-8?B?T1Q4T1M0TmlqNWljN3pDd2pveWJtTEk1TDZ4SFBKSUFnekRKTXpsa1pCTlFO?=
 =?utf-8?B?TktjN0FlME95N3VxU2I3WjlEd1k0UzllNWttTkY1WDJiRktqeFdTemVMVUlh?=
 =?utf-8?B?dTRnb1FnaG5XQmdiaFlOMkVSRU93UjV6bDlwSGhOczVQczdlS0RIeGlOeUZs?=
 =?utf-8?B?eUQ0eWtVWFpEUlpRZmhoL3g0YlJ4dy9FZ0F0SE5BalE3ZFJkMWFyNUJUS284?=
 =?utf-8?B?VVNYcHNlWXRlRlpuVVhPVDlYZW9IV1BJaUloQ3ZXMzFVZnhPbzFDY0R1cVE4?=
 =?utf-8?B?OTE1UkhHQlRUb2F2VWlUbDczcXpNdmJ6ajlqSHhsM1hrL21IL2JIZ28veWlR?=
 =?utf-8?B?UXhQN0U0QlgwRVJMYVAyQ3krZUJzcEp1MTdJZ3JoLzBwYnZsQ1FENXpOTG9Q?=
 =?utf-8?B?L3RkeVdvbVZ1bzJVeW9PMjd6M3lyU082aER4TmE0THZHZmVCSEsxT0hNcysr?=
 =?utf-8?B?TWdwOVBYUVZTMVVUUmpSczJJc1hML041RUtDNjRIS01rV3JLUFRpd2Fta2NT?=
 =?utf-8?B?MDA0QzE0ZWh5WWViaU1NYzBlamdSSlV5eEYvMXg1WXZkYTFQdTM0NXM1SkZv?=
 =?utf-8?B?a2ZReGJCam05K0xubnY4SWxGblZsc0tpeGVoR2NxZXZGT3FYcWZPWXJBZnZh?=
 =?utf-8?B?K3JoRU9iK21KbGpDL1lNWFNhNUJSaDl1Ym8yS1g2L3VkVHZkYUhrNVA5TVVv?=
 =?utf-8?B?cTA0ek1jbXRDekRyMkk1d1Rha3cvcDQ1cXpwSVEwNWhOejk1bUlDbFh5Q3RV?=
 =?utf-8?B?cHNhbTcrUC9Zb0EzN0hpanlHRkY3Z0g4TjMwS2hreHNLQzFpSWpaTElxTmZH?=
 =?utf-8?B?eHQ0ZU9ZSXB2MEhiS0ZrMHZyVWtDak1DN1kyME9XQVFKbit1K3FJenhHUW5y?=
 =?utf-8?B?b2JycjM2SVY0ZFNmSWdrR1ZIVWYwMTRDTG1oMVl4eUZFMlhPaEZXdnArcHlW?=
 =?utf-8?B?ZFZvbGQ2SDRCeUpPOWp3L3hFV1kyWllGME5vVWpHMm53bStsVFZFVldxVnNl?=
 =?utf-8?B?N1djMnZNbnlGaFA1cFcvdUZPRjd1dnF6RVE0YVg3TExMazFKcmxuN3VKQ1BR?=
 =?utf-8?B?d2tkeWNLSi9RRU9KTlZOZE96N0ZablZGdFlaK0hoU21QR0RtVFYwcFBBbita?=
 =?utf-8?B?ZTFvdjRVN0hteXBiOWpIRnFGbmNjYzduZFBHbTQ4STI4cU9xUlZ2cWltT29N?=
 =?utf-8?B?ZVEyM0JnTzR4SmtnSnY4ZHVlUDJTWlZjN1BiTzIwZkxKZS9wR1kvT0xYWENx?=
 =?utf-8?B?eG5aUUhpN2o5Skw4VjUyVnhrTElwMGZTNHg2T3p0blN5VlZQZUVkRjlkOG51?=
 =?utf-8?B?K1RUOUZveHlTamdqRXVRTzRUYnFhMjBxTnJTakRQb0tCV013MFdmOE10WlRk?=
 =?utf-8?B?RkZDRk5NMWpmZHZHemgzd3hRQzNLc0cvcU1rZDdMZ1p5T0lNZlY2akYwNGJs?=
 =?utf-8?B?OGpjeS8zNzJGUzFwYXFqbnMwK0dST2V3STk2Q09oZjRuT1E2cDBwR1p2eGY2?=
 =?utf-8?B?MVdWdklCamYzZ0NIS3p4eDhVWmdCTDdOSlIvcVlTVGFMN2FwT2N4clRhaTND?=
 =?utf-8?B?VkZuK3NQUkg3cGdwVkJoSkkxUnZTRERIRFpJdVp0ODNHVVJpSEpVbE9kU3ll?=
 =?utf-8?B?a1ZjeWJIY09XZTZKSlRwN21HZUZUdFFuMktiTE1tbWZVbUpzdUtJSGV2SHFM?=
 =?utf-8?B?d0MxL1EzdFF1M3NzN1FQS3dOWXRVWEYwaVVuLzYvaHpOL2FVZ2crSVloSGlT?=
 =?utf-8?B?TDl5M2t1cmRzUVhZWHZqK3p6dHJpL2M1V21JL1c5ODl1ZjRIRGthOFhwMFpQ?=
 =?utf-8?B?ZWdNN3BYV0x0ZGpFTEV2d1NENWJydGtLdFYzRkk5VGFhSi9wb2ZzRzhQSldH?=
 =?utf-8?B?YjNGV0l4K1psUTVFeVpjcit0RHlsN0JpRUdmQnFWU25oRmZzNVR6MWtsVkZ5?=
 =?utf-8?B?bVVWd2MwM3htc3ZOdTNWakpKWldhYzZBSlVFNUNyWEptenozblB4Nm91YzVi?=
 =?utf-8?Q?kM8mudKKF4HuOxY9ApYuLjE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yLWixqKiDyWiOQjZPp6bsdxeoh6p1a2lAJdxh3/MUo+Kp67saLpXuVyHR3TIIr08Ouarx3sLoM1OUIouhfxEPEP5NlGb/Ml7zdzWrZMIaspmBRMbuthPSJ8itkVrA6oUp7OsfTFF3XhVjKdqQggem11AuQ9q1VUMnezeA8JFTtUnxs+oSYwhZoPxMGcfdEhNd0aoDxzuDBXC1txkN4+VaDT7J+TYwyJ++DzsBsPrUhFdHTzx2ZCAVDnKDz+XQgWR/s5tSP87esKFVXaE4yZ8xuCIFZeWEGLZTH8EubEfKmo1WEmxa9ArsyRfXS4SvEOPcVgFAZnKhGXyDZsiMrAKml9dhV3m0hEMbJraMzMFh6v5Bbxz8K42wmXRTAVZbjq2sd0QMenE+g7lfvA8vBg/znEuHRkCw2itcdG0Qc9K+IBjcOrBbQuRStehrU/aHbm2NYUdX7fgSiEDG14mov0rmlKwM6ZMfja68u5Syq2BzLEoZgRzctNZGXJYKukoEo43HnNCVYDpKwINnkIVxi9TIKL6+HhPj4200QIo3jkHvM+8JQsLKzZCkny+kRd+amddgRVWZ/661a+xTDCUKVVrSZgSOjc1FkEdq+sK83y2fcc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1deac6df-fe6d-482d-7095-08dcc8e6863f
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 11:26:00.1797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fpaIzggVn5In6Ymrm3Yz+nwDUUGhrf8//GA+sGtnaGHwUHpmWFL37z69aI+l4fzytyD1wpSQuebHsU1X3zONKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5650
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_06,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300086
X-Proofpoint-ORIG-GUID: 0VTAdqc9T0SXgcZJFQAfVV_hl_P2Ys6a
X-Proofpoint-GUID: 0VTAdqc9T0SXgcZJFQAfVV_hl_P2Ys6a

On 30/08/2024 12:15, Eduard Zingerman wrote:
> On Fri, 2024-08-30 at 02:51 -0700, Tony Ambardar wrote:
>> The pahole master branch recently added support for "distilled BTF" based
>> on libbpf v1.5, but may add .BTF and .BTF.base sections with the wrong byte
>> order (e.g. on s390x BPF CI), which then lead to kernel Oops when loaded.
>>
>> Fix by updating libbpf's btf__distill_base() and btf_new_empty() to retain
>> the byte order of any source BTF objects when creating new ones.
>>
>> Reported-by: Song Liu <song@kernel.org>
>> Reported-by: Eduard Zingerman <eddyz87@gmail.com>
>> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
>> Link: https://lore.kernel.org/bpf/6358db36c5f68b07873a0a5be2d062b1af5ea5f8.camel@gmail.com/
>> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
>> ---
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>

Tested-by: Alan Maguire <alan.maguire@oracle.com>

Thanks for the fix!

> But we also need a test for this. Like the one attached.
> Or Alan can share his test, which is much shorter but skips round trip to bytes and back.
>

Eduard's test is better than mine; mine was a simple addition to
btf_endian() tests that checked split/distilled BTF matched endianness
of the originating BTF for non-native endianness. Having actual
non-native endianness _use_ as in Eduard's test is much preferred I think.

> [...]

