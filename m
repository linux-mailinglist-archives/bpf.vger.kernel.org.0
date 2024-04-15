Return-Path: <bpf+bounces-26764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CDA8A4C7C
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 12:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E53EB22BE8
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 10:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3603258212;
	Mon, 15 Apr 2024 10:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HIlJr4zm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gL6sqVe9"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9474AEF4;
	Mon, 15 Apr 2024 10:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713176821; cv=fail; b=UTYvwARhuSlWs6kJPzTisWOr91KBL0BE5Spm/XNCUDGMzyvMCOo3cegReHIMEfB7Wi/YzBfMi/BoZ45drgWEZRPOWiIUTrP4EZRjOQc0NKXI968SqGooBc4iLlH/EcIbT7QgBRdhISdcio1ban09F50Ci117Fhf1VxtxZPqKYFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713176821; c=relaxed/simple;
	bh=WlOxPfK6nXoohq6n05PgavEclGyUIZf0WZNjovmYP9I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Iilro6LmNMGj7W7BL/mT+xZMKnw5LyHc5YSMLTQT+fTI3pLc6FGuh+G4RiADWXpzstaG/6VCl0iRAFHlg+GaOrWMcgJZK+l3Rh88B9v+blMorTqVSUEdRUlKXQWJyaYiWlgj9+XrZ8WAYh0he3Q4d0KHwanKflC8uzGlbu/F0R8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HIlJr4zm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gL6sqVe9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43F1xfo3021878;
	Mon, 15 Apr 2024 10:26:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=4lilM/5qNd/iGma6xxKlYH6J7bWVVAmLyvJeVexzZKk=;
 b=HIlJr4zm+xQFau84D1wwR7dVsF/koJ2330rOnuJkThjB8E2Wj2wZ6UdXVDuBgYrmxDtU
 GrAowbdnxWxtHZphSx+OBmtIle0mv3otbg1MvehuJ6RKJHpXWB5OFLHsXFq8rw6tsevm
 8oEXEZoS03Yz+VmhUNX0ZzOtZx7fTEYdldYVODq9BW8atPs2c7TuxpTOC9rdIlNlxB5j
 9tLezdgCv+ICPdvd1O2NdlBHuPc2ua9S+kgAocKjRiQJPSUsnD5/0a2gTj09CELHx9ZA
 49yJ8zCCQDlyIRjzbiNyT9LXZZtUW7iMdkGmVoCfyGLAi0QbFd0qPt2dzxv/o8pLL2iO 1w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfhxbjbsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 10:26:51 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43F8ZM0c028872;
	Mon, 15 Apr 2024 10:26:50 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgg5k6sj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 10:26:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SisUhl6JG0da9SF1AGRuYw3DEWBjgNYcczLRP6bgJL+7vx4pc2IoIqctAHooKLkyAVN0Zho7YkVSrZlhdCvoIqW5iy7Xztws/hZttoP1lXFS4v4Ohd4UhYh+LfRQQ9F/rrTXXh1MxK4o5D8JHzpxuUSdsn3LYlXABunsHTjjzhZPuPbydgkcxdxoXJGdKfzUAm7BpdM946epaX4s8NW21ontTPG7HT+nPOFOqwcmK7aZmbgV3aRvfgPSBvhn9H8lqM4r83w1wLfEd4FhQjT0q49Kzx3xmUz8pO6l2BHnNv/g2utsUooYiI83pdjheCJV2VzkEmhekiFFts8jjviulw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lilM/5qNd/iGma6xxKlYH6J7bWVVAmLyvJeVexzZKk=;
 b=Qfg20aWyrsAyPMIUADR17f7ry+8m4R4eAe7v7egtongnwMtQ+sGgGZgLEyKT3NDaIK760hmn8LySytRcMA3/g1T8+2M4BzUNjQM7udgiJsKKv7MoyYVgY2K6hUKfz/aSN9zjhUQdGRei7gBHiF+2gF4swtjAoM26f0wIUiVvQZ8FSM6LExu9Beo23tgxLTm1QaBovjtzpSbuZWWWBXdCA2NsfCxVJfpqS0v2fOLfU1EKo4x8bajkR0v/8ZR8FzYpr01fciphyqcD8bQOdk7gosl1OPqF8SXY8aLGw/AyoIIw7Z3nubs3cSYhVBeQ4LPMC2N+3qd9t71XJAXhFbX6uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lilM/5qNd/iGma6xxKlYH6J7bWVVAmLyvJeVexzZKk=;
 b=gL6sqVe9J5lrC43aRccRka/6Ef5+ePB5g9gD1JVpnbx0rxTdDPY2615eyUnw9bQLmx4gA78WxwYuDZaMtjPJR+Eq8NI5ydmPueG5eVuDj5zDKWnkBixGd7l8LY5wAUuYv4oHUGWIDVRUy3lixU/euKshQu6MCBZ1gfApoZ+18rQ=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SA1PR10MB7709.namprd10.prod.outlook.com (2603:10b6:806:3a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 10:26:48 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03%4]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 10:26:48 +0000
Message-ID: <3817fa6d-122f-4cbc-92be-616355ec04c2@oracle.com>
Date: Mon, 15 Apr 2024 11:26:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] tests: Add a BTF reproducible generation test
To: Arnaldo Carvalho de Melo <acme@kernel.org>, dwarves@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, bpf@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Kui-Feng Lee <kuifeng@fb.com>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
References: <20240412211604.789632-1-acme@kernel.org>
 <20240412211604.789632-13-acme@kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240412211604.789632-13-acme@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P189CA0029.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::34) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SA1PR10MB7709:EE_
X-MS-Office365-Filtering-Correlation-Id: 933f49c8-0990-4f55-8a0d-08dc5d368e94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9ZvwfIa1anoAgzzLW4xhI2iNxNtFWD7M5SijwB+TD4TC+9yiiCzXN935ZuhtJj+h1+StvdBQIOnrG/fMK87ltCdh+rBU0/040AHmf554zmlD+F/K4pHOImntNfrNMi6NsZ1/ACFCoNJS6+7u5EnmvE8cMH4MGGDwfWxuTTScXgXcGUSL6rGZgAWj8n9nnwHlXmaT03rXF87WsJ7koN7h4dxkeqpw/wz7fGXeU68lL5F7Y5+lgtHkTlat9SKAWFGm1qvB3RkS3j1PcqYF7WD9F8030elLHeRo8UqzGLz564qxp0bKvduotgqV8LTkoF9zkDd3R0zA33i4ZovLFIi0x0/tdhjdHWqQGJkgk1Bq2lbaoOUlR8dIItE3UnIRtEwPrJTXydDwxB834P9CJRyBtlDeT2aQjbYnSm7i7cRBQxh/joMjl11TCnl3tpeYAimRt3jkx0T9pA8YJu/SLVEhhxHipaEYclH7fl4681HOAuCbiMvjaUTJTysSjmsEG4nh8VQvrT94wJvSub6gyiO1S550neVDgTevj3g0wpTvpO7TnS7GgJmNcdWybb8PrF0QFEIZ9J10n2cl+qOrgSRNpR9ILyUKMklKSafLvAl+2xNN8bgHnmsaY2soY285ns15vKE+rtieMP+giXvQq2pjFUo+9VzEIuSlhKaFBcFy/3w=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dkZpd0VoS1JrM2FqOTE0M3pkM3B5UWZwanFJcGJEQ3F1NldYNHZsa0pTdGZ6?=
 =?utf-8?B?MG9pdmxra0dzMG12MWE0SEpEZUVxZVFGSEtnejZwRUVkbEJURWlpN0RQL05y?=
 =?utf-8?B?UVp0UmZzZTE1ZUREYUhQTTVtazk2Z1pXd2lKTzFlZUE3cVNVWktMUHlvRVJK?=
 =?utf-8?B?TGt5SmhFZ2xoY1g3SjVFeG1sWXY0M1UyTGtJM2pqajFLSVBzK0twaXF2bC9L?=
 =?utf-8?B?TmRlRHpZT2VOd1dGc0NJeVRLZWRmcGRTQzkweW95K0V4U1pGRGt4Z0VGRWJK?=
 =?utf-8?B?WnBUdHJ6ZldDaGorOW1hODJEcy9jaUlxU2VKcEE2UGQyaXNFSDVrQURCUVlC?=
 =?utf-8?B?V3pncFI0bE5jeHdQWXovZFg4Vld2MTNoTGk5NkY4K0JZVGlVbi94V1pXVWlQ?=
 =?utf-8?B?YndCcGRjQ1hzeVlxRlRpaWR4NXpFMTE2bzVERFVwc00rcThDQ1h0c1F5QXY3?=
 =?utf-8?B?WVhpNHFldjBiTVp1UUlCUGVXUHFteUdOYURzMUF2T2UzUFprQVdLQ09HYzNu?=
 =?utf-8?B?WTVtVklHR1l4YUZxUGwxeDVuc1VvdTM0VmVKQXdWYXpGSENUcnVtRDZzeXND?=
 =?utf-8?B?LzJFQ2hyTUZES05KTHBLaE1XY0ZzQ2VwZjdPbWljZ2pldHBoQVNxWjlkK04z?=
 =?utf-8?B?cVpKTnFZZDJJV0d4dUhaTXVuMUM5UHJ0YVVlUTB1L2pneVlaWGpUMDd4OWdk?=
 =?utf-8?B?SStHVDFvZmJvbHpTVHJuNUlpeEgyT25uTjhleVFrdjlPYzVPZ2dmZGgzaEZN?=
 =?utf-8?B?a2VDbWl2aHFOcE9iVXl0UnpjRXMwTWpjUnIwVGlUclRkUTcvb2RVc2xHN0Vv?=
 =?utf-8?B?L2tqTzY4OFhyMWwvdm8vc2FoeVdvRW5FWDBZVm5SZEFWeVg2eGVDYkFjVWll?=
 =?utf-8?B?YXF4RldxZUVJbFd2Z3ppRVZkRWVYN0tFeDVXMlcrM1Nkd3lMNTIzWnRHMlcx?=
 =?utf-8?B?WmQwOHAvbVAzdCthMzNJSjZIaEp4eEcwTCs2UmNpU3F0bHJibGp6ZjdyVS9o?=
 =?utf-8?B?ckFUV25KTHdldERiZFJEMFZwa1NWVThQOVBoekp3NEZwc25VRFdRckhXaUNC?=
 =?utf-8?B?MHF0TTRNemN3SWF0VC9VZUszT1ZUL1RiZDR4U09kak42QUtFVTNCckNvNWtI?=
 =?utf-8?B?bEFNSmFQakhnYkZ3OEVGdGZnSnBnTWhMcmllc0ZVOEhpZlRFL0RFOWtpY1VQ?=
 =?utf-8?B?S0RNY0ZwaGwzUHM5dTNtM0RReE9QQ1Z2aDZXRVFRc1RZZjRyWnZ2OUhPeG9L?=
 =?utf-8?B?TjRFeGVoNGw1TkVHUWVuSFN4bVBnY3dpNThKWFJWNnNwNGppU29WdUFOb2dK?=
 =?utf-8?B?NXRQRUtzdE1PUEtzLzZXYkQzU2hYcDYzQ1R4TmNlY01tZCs2eCt4cmxvK3lW?=
 =?utf-8?B?ZTNubC9YSk1SeC85cGZLcnVjc3o5Mi9lbkZSWU1WdkdlT0pQSjhmNklsYXRI?=
 =?utf-8?B?d1ZNMTFWWDlvQ3JTOGJaeVdOQnZnbzkxendIc1EzbVcvTzJ4Y1hxOUVkTkNm?=
 =?utf-8?B?UEY3YXZQNDJRK0dVeTlmencvQ09pNmdVcktvSHU3MmxKcEdWY216UHZ6dE1Q?=
 =?utf-8?B?WlpZMUJ1b20vQ1dodXVCNXdxTTh3Zit2VnhCT05WU24vQ1dRR1VCMGk4d295?=
 =?utf-8?B?MTU5Vzd0a3ZGOHBMU0NycFVqb211ZEFTamRrRXJ3SHhlay9rdXVSd2hIZXlP?=
 =?utf-8?B?TnYrUm5IQ1J6eStoaFJTZTE0VmpVelhXK0E3STN2YU90WUM3N0Q0ZWJwZ1hK?=
 =?utf-8?B?SlR5azhoK09Sd0R4SSsvbzMvKzkxS0kzU3AvQ3ZYUndSWXpxOXptWng4UmFx?=
 =?utf-8?B?TERlT2NJRnJRTHozMklHNnFuU2pmV0FJM0FDL3R4dzA3ZFlXTjNTeW1FNFlU?=
 =?utf-8?B?bGl6bzY1VCs1V3RCZmJuVTFEMVJ2d1FOeXk0bTZONWVwYVl0dnpReWZmNVdX?=
 =?utf-8?B?VTB0Q1RRblFJWjdscExUK09OWXZ0N1h1SC95M3hOUlFZUnZwWUM5b2Voc3JC?=
 =?utf-8?B?NGllNUFPM0pDcGEzYVdLalBSMlpyQWw1bWlWNWZjQVdSWWlMWWFoNnlVZkI1?=
 =?utf-8?B?RWRXLzJDVk9OM0dxU2RENHprZW4vTnE0WWNJVHAvekZOM3IreFR4NTVvbXF5?=
 =?utf-8?B?cnM2K01tQUNST2gzZDFnWGxuZDV0QmNOMDhHSi9WV09NQ1RKcXZHQUE2N0RD?=
 =?utf-8?Q?PjjOP/k7GmVfcyTEXDuny7I=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XD0YtsSQVrcY9uxkEqSCBDxDVQYKgIURJa+K9UW2Lfr9JeG05t1weIauTdlNYny71o7ZAHv1c3u4azqRM1Iw7imqc0ZqRkDTZ91blFuWr3sdo9WPwfLqaXa1xm65QGeD4OlwZe0tb/MFfh7hm8dROoRYHWduaBrvklg2o3l10gl8Z5AfEFVKmEls13zBahPQ4EQCr400JuPtXT8UpfSlxR8XG/WHxEUZDPhwGDl4bk4c31sjQ0UPiEXW6dp0kgvVRoWwDL0vhrdIc+51fvPJoGZ+24PPyc4QGFX+R7M1nK/5ocnq4w/e1ssMgWMUxSCAk7E5GCMMMK9QD23YZmGPiEVArRrQi6SEef/sZ2pGjFK1S3q2bLTG1Cz7mc+Mjsps8SCYRVpXVRuomsO0N9tBJkxuLkVsglNRkYY04TK79ipjj6KX4tXGGqBYjseVs21Gx8rHQeUhNWGunI2r0ZkuvI6Rqy4PGaPDye0EM7ujBFmzbBGl64VykMUa6jql5hFTL9WsL1YV7mzhSY0+NP7emvdzVL3LMpBS/3YbHr0vxGYFsWic0xbBiZhNIlVy+hhgmx32WYE6xolh8YGrWZtImOqH0um73qpB6AJLLB6r7qQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 933f49c8-0990-4f55-8a0d-08dc5d368e94
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 10:26:48.6811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ctJZUXYREd+sPAJkS/sDX0s6UFYpDFbN+0vu/MLNAOEZ+kpkjUknryxmHQNrd2gbJtcf3mkmKUZbGVu/mzwwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7709
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_08,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404150068
X-Proofpoint-ORIG-GUID: VQCjIdbOllvvnFACNCMgDobX9SGpIKyh
X-Proofpoint-GUID: VQCjIdbOllvvnFACNCMgDobX9SGpIKyh

On 12/04/2024 22:16, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
>   $ time tests/reproducible_build.sh vmlinux
>   Parallel reproducible DWARF Loading/Serial BTF encoding: Ok
> 
>   real  1m13.844s
>   user  3m3.601s
>   sys   0m9.049s
>   $
> 
> If the number of threads started by pahole is different than what was
> requests via its -j command line option, it will fail as well as if the
> output of 'bpftool btf dump' differs from the BTF encoded totally
> serially to one of the detached BTF encoded using reproducible DWARF
> loading/BTF encoding.
> 
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Kui-Feng Lee <kuifeng@fb.com>
> Cc: Thomas Weißschuh <linux@weissschuh.net>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tests/reproducible_build.sh | 56 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100755 tests/reproducible_build.sh
> 

great to have a test for this! a few small things below but
for the series

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Tested-by: Alan Maguire <alan.maguire@oracle.com>

> diff --git a/tests/reproducible_build.sh b/tests/reproducible_build.sh
> new file mode 100755
> index 0000000000000000..9c72d548c2a21136
> --- /dev/null
> +++ b/tests/reproducible_build.sh
> @@ -0,0 +1,56 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Test if BTF generated serially matches reproducible parallel DWARF loading + serial BTF encoding
> +# Arnaldo Carvalho de Melo <acme@redhat.com> (C) 2024-
> +
> +vmlinux=$1

nit: might be worth having a usage check/error for the vmlinux binary here.

> +outdir=$(mktemp -d /tmp/reproducible_build.sh.XXXXXX)
> +
> +echo -n "Parallel reproducible DWARF Loading/Serial BTF encoding: "
> +
> +test -n "$VERBOSE" && printf "\nserial encoding...\n"
> +
> +pahole --btf_encode_detached=$outdir/vmlinux.btf.serial $vmlinux

suggestion here; what about adding --btf_features=all as this would mean
we'd be encoding all the standard kernel features? we'd need to do the
same below in the thread loop. without that we're missing out on a few
features that the kernel builds use in BTF encoding, and we probably
want to ensure that we're testing as close to a real kernel BTF encoding
scenario as possible.

> +bpftool btf dump file $outdir/vmlinux.btf.serial > $outdir/bpftool.output.vmlinux.btf.serial
> +
> +nr_proc=$(getconf _NPROCESSORS_ONLN)
> +
> +for threads in $(seq $nr_proc) ; do
> +	test -n "$VERBOSE" && echo $threads threads encoding
> +	pahole -j$threads --reproducible_build --btf_encode_detached=$outdir/vmlinux.btf.parallel.reproducible $vmlinux &
> +	pahole=$!
> +	# HACK: Wait a bit for pahole to start its threads
> +	sleep 0.3s
> +	# PID part to remove ps output headers
> +	nr_threads_started=$(ps -L -C pahole | grep -v PID | wc -l)
> +
> +	if [ $threads -gt 1 ] ; then
> +		((nr_threads_started -= 1))
> +	fi
> +
> +	if [ $threads != $nr_threads_started ] ; then
> +		echo "ERROR: pahole asked to start $threads encoding threads, started $nr_threads_started"
> +		exit 1;
> +	fi
> +
> +	# ps -L -C pahole | grep -v PID | nl
> +	test -n "$VERBOSE" && echo $nr_threads_started threads started
> +	wait $pahole
> +	rm -f $outdir/bpftool.output.vmlinux.btf.parallel.reproducible
> +	bpftool btf dump file $outdir/vmlinux.btf.parallel.reproducible > $outdir/bpftool.output.vmlinux.btf.parallel.reproducible
> +	test -n "$VERBOSE" && echo "diff from serial encoding:"
> +	diff -u $outdir/bpftool.output.vmlinux.btf.serial $outdir/bpftool.output.vmlinux.btf.parallel.reproducible > $outdir/diff
> +	if [ -s $outdir/diff ] ; then
> +		echo "ERROR: BTF generated from DWARF in parallel is different from the one generated in serial!"
> +		exit 1
> +	fi
> +	test -n "$VERBOSE" && echo -----------------------------
> +done
> +
> +rm $outdir/*
> +rmdir $outdir
> +
> +echo "Ok"
> +
> +exit 0

