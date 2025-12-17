Return-Path: <bpf+bounces-76896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBC4CC94FA
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 19:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52D01307C197
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 18:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDBB2D7D30;
	Wed, 17 Dec 2025 18:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PZqI0C0U";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zn0pchso"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A0B26F2BD
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 18:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765996916; cv=fail; b=nt60GduXRhl/G83zXzOZCKH58AZDZtFFNGPgviiulhXxXm0ArzssQ2tGzaUPRFFXhEjumlp/6FTyGCItnIrSf4EPxaXqKzLYqd58O4PQRs9MkU05ip0BJR+QvI3F+f+H/YDtBev3UTAcmF36t0q5onqZ+XHnMfPPTpcuojwUji0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765996916; c=relaxed/simple;
	bh=/P4lYtFJQLKNZd5wZst1oV2h67O6hs3Th6qyMG2hfAc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SW+09ifqzXdhlPpg7krOkuXR8x/mQCAXYxxfS3dWlaIhGVHanH/uswurJTnKTvZy5gqm9yJgTAihA977Al6ZehcTjcZL7riiQ57DItYAVFmUSonI72kqdgPgtwaJUDquvxIWC9hmgLWdHpmORZN7wvTuDZNDhfONcsUg7fgs38M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PZqI0C0U; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zn0pchso; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHH1fKA3141083;
	Wed, 17 Dec 2025 18:41:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=QFLlDrSDLHB6t0PJwAQpT+bD7PZ2TZ9HxlccbtsC9A8=; b=
	PZqI0C0UcsdujsCWdBhysvhrAzJqnyum4nz6R9PEsYKixeSzHC4nXIErhdSBVRdK
	+gx3ywWXnpDuQBefGNyJZvZENJ7UHkGZe8HeEi/oZ2Z5m4heM4B8sj/Bh2YgdclF
	V6gWvgqLSBhITjCjB0kc6bqHlC2zQZaTSXCVPHF64j/6u6vxA8iMH4DoX7Bhltun
	3ay8FZGLbemHE+ehMIOW4XLdcP+f6paIB3snO5fHEKjy5UMLmSsiSZgJV2X44Qug
	Z11INkDnzXG5V/U0U6cZM1AvA0n6EQxXyIzsag0wRpP5HSuh3PX4jzlYCcgqXSjQ
	CFKjMotFpSGdP/JP0cValA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0xja6cw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 18:41:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BHHTg8g016320;
	Wed, 17 Dec 2025 18:41:20 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010020.outbound.protection.outlook.com [52.101.85.20])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkne639-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 18:41:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfJTSgsGNdDmEoLiYNWLoa//wgtD7ge/73CFmvUyRr21AYWa4aN2rtb4AtwA33SK1wAc9tGDoPnDa9D147YDG0SxnO7g6PQOGmzZb7pgjAb7DJHc0nAeQQtBrzBGTlmxBMCkwZyPgOL7s4HjXnM/4Q9G6z9GD6+vzW4W0Q+YH+VsTH3CLtejmWMaC/D/ZZXObpXv+cpVxqqHmTsRF0b5UqTEuqqlUsMHD6IKifCZWFyo9EYrDZVb0AioLVMUfloiDDdxjw9EOxOM9R/nwktEfuwA2LmcMXkgQpC+Dez8sw3EHdUYODKO337XRVkz4BP5kGQoBqq7uNcy55r6JDB3pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFLlDrSDLHB6t0PJwAQpT+bD7PZ2TZ9HxlccbtsC9A8=;
 b=qau9cPXbMSXY4EgN2q8yqCHmpabVi3dbkEBd6ciT672tqrHXhH+kGAU5KhAYDxfq201wLCCWDICBNS+U9SbKPPAtbdMOo0kdcEOjeJquV3ysxiDO8MVe+oA5Z0X9cP1hJQP7G54N1JVqK91nEJ+/sNemu1Gyhbn19qvuFjeApZ79DpD0WHdorwWOnLrL/ZjG+ms9vBd+o762gryV808LV4LizwRoSr7y+J58IggPgYoNxKYi4dZwnGbyv/00OFIEdk5+9vOUqMlR1iHUt4IG2zP+RVAW86vsHNusCyObLJQ89vTgLrCC6vbnZnIFicouSZYh1YgfT0CnjKTSfVBplA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFLlDrSDLHB6t0PJwAQpT+bD7PZ2TZ9HxlccbtsC9A8=;
 b=zn0pchso41WwA5Zm5N19lPT0JJg9v1yzrJEvUYytA1eWe4YEjnf6F7/FcBDSSt8ag7xLiwjh0Mpd4ROtegEBvqCrP/+uzqGVrZ+4hlsO3TJwXTJZhrgnA8MFM/fDTC6ptVTvcdcQ7dMDOs6ZA7uzbcP1N/O1PFcCniXWRko0F68=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 SJ0PR10MB6374.namprd10.prod.outlook.com (2603:10b6:a03:47f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 18:41:16 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 18:41:15 +0000
Message-ID: <535846f7-4cc7-4b12-aab4-52e530d04706@oracle.com>
Date: Wed, 17 Dec 2025 18:41:09 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] libbpf: add option to force-anonymize nested
 structs for BTF dump
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Eduard Zingerman <eddyz87@gmail.com>, Quentin Monnet <qmo@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>
References: <20251216171854.2291424-1-alan.maguire@oracle.com>
 <20251216171854.2291424-2-alan.maguire@oracle.com>
 <d5a578c01f8a2d4d95ca16e0a9ee5b9bfce1c30e.camel@gmail.com>
 <9a096b2a16d552031a12f3f4f5a2c725212df5e6.camel@gmail.com>
 <b535b47a-519e-4138-861b-c16ed7fa0bcd@oracle.com>
 <CAADnVQ+EyYO+aOZewNQwETr5rphOCp6jJQH_fw9GqjVFdQd19A@mail.gmail.com>
 <CAEf4BzbWZtRdKCGwhjRV9MOufTC-coWFSU5sRtk4gdm9S_bg+w@mail.gmail.com>
 <6ae6dfd8-3f73-4318-93c1-97541d267a28@oracle.com>
 <CAADnVQ+wNPbbA0e4+6kx+LtOH=09jJyiYcEKZfc8kt6UPnq=EQ@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAADnVQ+wNPbbA0e4+6kx+LtOH=09jJyiYcEKZfc8kt6UPnq=EQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0018.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::23) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|SJ0PR10MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: fe0b014f-eb92-427e-8a26-08de3d9bdbe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzBQQkpaekNFN2lCdElNdEpjWG5CUUc1UnMxVlpyWXVFVTUzMk5aUXcyVTFS?=
 =?utf-8?B?ckZMTERUMHBGNXpjcTdSRG9Rb1VsQmVkeUxqT1VuMDVjeWV2NkhxMTRLWXpz?=
 =?utf-8?B?T3UrVEY2dHVwL2VnRk1TZDFuRG5CRWRQVm90TzNhT1lsckxDZC8xanNvSFhv?=
 =?utf-8?B?Lzh0ZU95V3VocXprRnM4VXFIMTk2SjU1UlNjNHlMTUlkS3hJV0pFTlEwMGNw?=
 =?utf-8?B?c3Q3LzV6dkhoazdVTWptRjlsZjJyKzAvR1R6NEkyaFdBS01LdnhLZXB0aFkr?=
 =?utf-8?B?bUloSHoxRDIxY0c3dXYxRkZzc3Vvdis2elJHOHVub3JuVEdIb3ZSNW9XZU1s?=
 =?utf-8?B?b3Bmb3VrRGcxaURpejl5a1FhM0FLWUU0YXJpN1lvaHlsb0liUGZVb2ZyMWNW?=
 =?utf-8?B?WGxBUVBscFB6eXlRdUZ2NERKRmZhZzBxZk9rbHNkR3FKTE41NDI5Qi9nQlVn?=
 =?utf-8?B?WCtxSktIc1ZpeVJ5a1BiTWN1UXBtZ21GNk9SQWNGWEd6MXlIc3BDTEVyWWo5?=
 =?utf-8?B?RnBlcnp3cVpjelFhbHNKcmJoRnAxdWl6MVJIcmtKY1lpNXVoclU1K0lKOEFG?=
 =?utf-8?B?ZXlRakxuMUNINGVoaExTQU1Gb0UxMHBqWFk3b2VCMlBPa2FMbmtIYXRocFVS?=
 =?utf-8?B?aCt2alB3Z0tCd0p6azVXVVI2azFSR0FvWitTN2kwdzc0UjEwWGpKYmJKOHZB?=
 =?utf-8?B?aUl3UFE4TVZSSUhGK09JUzYvRjN1cWkzRS9ocGZZT3ljSlVWTW5CRjJCTkxr?=
 =?utf-8?B?L2FuVUJQVWZzdlJmaHBySlpaNnR6Q2NEMUVLNlNlZ1ZrczZPQlYzYVFabkRj?=
 =?utf-8?B?eU1RL2RjbWdUZ0hjZW1ETnFyZWtuTXJkT050Z1R4S2hTY1VtOUhOZlJYZzhw?=
 =?utf-8?B?QjBaWk5FZVpqZnBLOXdwQk5IVVdzbDdld004Y0xiMFlPblE5VENGN3ZJT2Fs?=
 =?utf-8?B?YXc3UUt3bjR5RXhvS2xjdHREcmdQU2t1dm5lckhTOGdUcVVwWnJCMDROK2Y1?=
 =?utf-8?B?VVhYU20zdStvMjZSSG4xNFNhRTVleFlqU0l3ZFBvZnR5OE9DMFo0UUZVbzFq?=
 =?utf-8?B?MGxCVFhwMXQ1bytQZzVRc0NlM3B6eHJ5UHhNZUZMd3VuNmYvMDhWNE1Uc0Zw?=
 =?utf-8?B?NHBPa0h3VTkvbmZMQVh5WHhDdmhOMTFNUWs4WXhGYWZZNWhkWExSb3BRd0J6?=
 =?utf-8?B?bmM2b2ptZVlSOVcxbm4ycTJmQWhkWm55VGRvU2FhR3dtdHJSSmc1WllOMUJ1?=
 =?utf-8?B?dnNDU1ZPbGVnOERLTzZnV1R2WmJTZ1c0L09xa3ZiQStRZTIzUFhFUlNoTlNX?=
 =?utf-8?B?MWxuWTRkNnJaZG0zYXlSS0xMYUJwa3pVUFFKR3JWbCtRcmxuOUR5VTNyejBl?=
 =?utf-8?B?Z1YybkhDN3FLSkFGYnh6cUVsc2NzRUNqUCtyYmNkL0FoOFcwL2JRcGdKZkhv?=
 =?utf-8?B?UUIvWHk4aCtpMFpsUHpTMkJvVzhmb082VldmNjlkZ3F6eEZ6OTlHcXRxUzh1?=
 =?utf-8?B?ajAzTm05TTllcm9IUVh0TUV0V0oyRy9QWjlWVndodG1FRlFvMld0MWxEakVJ?=
 =?utf-8?B?TDZNalFwVm1pRldwOUwzUkM4T2xnVzh1TDk1L1VnbmJlNWs3SVYveWd0NVRm?=
 =?utf-8?B?V1FEc051ZlY3d1VjMWVEeFhYd3VrczV2MDRwQktJdG1lSGxJWVJPb3J0eWRp?=
 =?utf-8?B?N0dETkdDcDlLa0dyMjk5TUVEN3lxVkpnZjhXOCt4YkxNVHFFelpsUndwV0M0?=
 =?utf-8?B?dWlSb1BQUGp3RGFCeTB3aHZLcFdBZGJNOEdrZTlScFhZemNpSXJwakQ0RkRx?=
 =?utf-8?B?MTJQeXJOelJNL0JMV0d3TloyRWkrcytDbnA1QXlyRUtseTEzUHQ0WFFhY3VB?=
 =?utf-8?B?WWNEL2tZSDFnSWdiN1hnSEZiOGpqdzZCazkzSURFK1MzQVFKREJCazd1SFJI?=
 =?utf-8?Q?XUU96WuTjccID2I1SWlCVQNWvEskSGU0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2dySS9HclZRNldDS2RkZUUzd0ErdWlwUnh5TzV0aUlBMFV4c1Vuejl5VUZW?=
 =?utf-8?B?WCsrZlRVd1U0NC94MmlZVUVpNlJWRW8zbmxBVlYxZXltdXBHcUt1bVBKYkJk?=
 =?utf-8?B?WjIwenY1ZERVOUt1VVQ3OWtBRnh6ekEweFNnZ2kxY2ZpMjB1VHQ4R1Z5MGxG?=
 =?utf-8?B?OCtMYXJNbUxCcFE2T05LZFlCNFNwd3JQejJOdFdOVEJOdG51M242Vnk1clpj?=
 =?utf-8?B?YytKajFFUWJXazlycUIzREFYTEI3R2NzRDVFZ3Y5K21YdURQdXNDVDl5TnFR?=
 =?utf-8?B?Yk5TelF5c2xBWWFNZDdHaEdQWldONFlpaE1seCtTRFZvbjlEaHNRSGN0SUVJ?=
 =?utf-8?B?Vzgva0RWZ0ZrMGZiaGVNMDlKcnNxMFNldXlETTlWL0RlNHNkUUN6ZG5wRGs2?=
 =?utf-8?B?dkxacXZqd2JiQTBUTWFXd2xlcXI5MndXQ0d3aFhvL2I1U1ZiOWk4QUJUSE5o?=
 =?utf-8?B?TGE5MzErMDRwYlFHR1FCU29aRTZyS3ZuUjFuUFdndWdXRkZTd2xqRHlRQXJM?=
 =?utf-8?B?YWh1TFdoK1E3QnJjN1pZU1pacmZLVGhoYWZVemp5VzU0a2FhUnVXY0FKYS9I?=
 =?utf-8?B?aFlxdVQ1ejV4TFpnb1JxTDc0aUg4anp0VVJucDNJamZvZDhaaXhjYXJzaWpS?=
 =?utf-8?B?RUs0NU5aSis4alllRFdnbTAvaXRzbjdTQ1lSNThqY3F2RXJ3OC9zRFNRZnJr?=
 =?utf-8?B?ait4eStjckFhQnBTbUZYTW9nUEFMTGRHYUVINXI3dGZ2TzJlQU5uK0k2d1Fv?=
 =?utf-8?B?bkI5Z0xzeUNSSzlFVEtZSGtSMlgvV013MFE5VDVVVlFOaFdiZDRHZkh5R3M0?=
 =?utf-8?B?UHhNUFdKWE1ubk9kQWlYbjBBcUsrUVA1Nk1ZZDVJYVNxYisvOVpQTnlhSWd4?=
 =?utf-8?B?aVpMcHNKd0JhZjJ6N3k1Q0x3NXhCenBsVS92S1Z2NnlPeTZFbnpTaGdWSC8x?=
 =?utf-8?B?REFUb1k3RjRUYzErUGQyUGlXcXBQd25TSGw5eTRTTlNrN0NJSk5WN0lucFVt?=
 =?utf-8?B?SzIvZ2JBcC80L2xFWWprSUpXMXE5S2xBS1VkdlJvK2RrbnFnUC8yVFdCVk9v?=
 =?utf-8?B?MTJ4bGVOdUQ0aTUyRWJBQWhLZEd4KzdjVSsvMzBMMmthNjIzZ3JUVURrY1Bv?=
 =?utf-8?B?YnZya0ovMTlxeUJpbnRpK3NSTUNPNHAzKzZpTHNkS25MbGwrQmVHYzZ2cWF4?=
 =?utf-8?B?cnh3amg4NkFlREFRUmVVMjdVdGJJbjQvL2QyVjFWSFBkL0ppdlhwUkZkOHlm?=
 =?utf-8?B?clRRS3FlQXgrdDRhMzVDYjEreFpzNXl1aFlxKzNSSEJMR2o4aU5ZVmwxd0Jh?=
 =?utf-8?B?SFVxVFpCTXVNeGkxaUM1RnFjR3Z6NWxQS3Q3T3pBd3l6SzNma1Z2YVo1Rm85?=
 =?utf-8?B?bTg0OExYdUs5aWhJdDFmaUp3UDN0NUM1c2dxdCtTanEzY1J1c256NmRiamIr?=
 =?utf-8?B?cVFsS2lTUlM2U0o2cEJOcWdsRkM4cUZPS3lKSWRqeTRwTWlqMUJlcEs4alFS?=
 =?utf-8?B?TWYyeGlQdVV0ejFKQ3F2WGFZZVZhSzdtbE9pYlQ4dkhxeWdIZENWSmZwMGJB?=
 =?utf-8?B?ZXBGV0tqdklJSEpSZUtacXBuODNCbStEajQ1VEo1b1k1R25DWmVZNmZ4alQr?=
 =?utf-8?B?MVhPbHA4Vm1hMHZVZ2JpNytOZWxXQjc2VmZwMHE4VzE3eHk4YkNMTGRBd0lG?=
 =?utf-8?B?MEk2Wk02anVIcmZNaUpNd1MwU00vTTZET0VkZFdjeWVWTEQ4ZDh4eTlpaUhz?=
 =?utf-8?B?YjJMZmsrVXJSSkttS05OR2wrd0JTSmdxQ0wxVWNMazBUZTMycVNJeW5MWEJ1?=
 =?utf-8?B?Rk1XbVJwbkVZa3AvM2FrTW5iclhlTHJBMkxXcGhmVGtLY2RJL1NKNC96R1VU?=
 =?utf-8?B?N1JzQmZCaytNanZVdU9GMTFCN3A2WDRJVXA4WFhMaGUxdDJqbHBxWnhyaFNZ?=
 =?utf-8?B?bXFCWE1LZGV2emd3YUYvSUVJWWNtVCt6NVgrNUpXVGh2TkErZVdjZm9jT09a?=
 =?utf-8?B?Qzl1ZVV3VUFSbVhzMkRuYlBRZkEvT2Q5RVEzaFY0cUtzeFdSNGh4bDZ0WEt6?=
 =?utf-8?B?VjAyaU1tKzBKbFI0T2lxM21xMVgyMlRJS2JBK3AvSklNTzIzZDQ5aENYcHVZ?=
 =?utf-8?B?M3FyMzBhdFBsSTQ0Nm0rU3pTRUhEUXhwZERxSTVJalpuL3FpYTk3aVY3bFRk?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dgRPWlhytVMpb0US/9/YHPV201XID/lolu8NRyVSrauHKbVo7gyGkrTiP+CebMxELqTVQfnDkzaakXgR8mjmR77mLgUZh+vw0hGTrV15nLYYDeDiq24MXhi6uNY5RM9cMVt8Du3wwPOAf7/ZGaP6HdacVdk07+SvPaO30DPMrEqtyBhDUzoS2aI6aJceEAUEeNbgskmS771Xbt6xHoSKWh6j9M/9jBuu/2QcBgoJDDtEHaBV7e9AlgpGcnn3/L/wbesIajJK91YlDNl+w7dpN1hmYxZM6ALIETm1oV+hMAyN/GX1eBtBClD1wBmBKG0WK3Eg0W4O30h5+ED4z0b1QOX2/0PQIVfAjYaGKMySFu4StFMUOkmGKMBl2loBY2B683/mZPZ2ZmT4K87KK3kNtgs39Hd9vsNorXDs1vL+acLMJI9aaZ+UEuGxjbhd7N50CCaJi7s2RCdqcvmSrleWpXotMLw3YxpinvgkCJFwUwOsLncu5NwTQre4x65t8tV3dYw4MJxP8Cl7pjTZ95hDccJQtL8e7hkNewBkq8tbxodNfsXyHbg9zmAP21JDQIenN+1UTfE2E3diO6Ty4DQFO0mJ4t+4UgQNdpte2N5i5oI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0b014f-eb92-427e-8a26-08de3d9bdbe3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 18:41:15.4489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K3Bub8/87qIMnZhy6V1ONR4dlvCeFkLnrHsZs8B6exbjY5CfO0logCU7VE0NtAX26Q/iR3BA1EzJCLI3SOeUsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6374
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512170149
X-Authority-Analysis: v=2.4 cv=TbWbdBQh c=1 sm=1 tr=0 ts=6942f951 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8 a=raUaxOdy7VIq2MlIhvQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12110
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDE0OSBTYWx0ZWRfXwB/NRoHZEyva
 yiXAAcQ0xjX8xgjH9N9t35xDJEV9Y2Kl4rT/E8E0xHNpkQMQX9SzuTkc6/beZeMrfETdp/hLyLZ
 5usW6HQrtXCRadJBXHpKJZP8U6PpSTD+6r6TV6NWA5mFX71cRSCdOfYNyeKKYN6P8TYH0oxbpGi
 Tdk1jBQD19FkSjvB6txOAhIxxgOx4KLuomBhe3Rxj1tjONExJErQWRApMsmZinMDmreBSf1LjiS
 C71uBNn9nv3Pe0dVpN9S+nlqgByeMbUp3HFXYzSvhZkVzsViFJToCDcZDdr4kvhDZwAuQ7tTVtT
 4ufiCZzKd38iQRb+XaEJrOLdJkcNCTjdrdbzyYVADbipLBLsxhHkrnJg0rNwjjw7m+k9ViPB0zE
 f8mdFp2e3Za8DdJ1BIJwTgl/XUMAtmGenrOBnq7EL4GrvITGCLY=
X-Proofpoint-ORIG-GUID: h1ZrG-bwMyDs9ElwdWzgToyxXf_exAr4
X-Proofpoint-GUID: h1ZrG-bwMyDs9ElwdWzgToyxXf_exAr4

On 17/12/2025 17:52, Alexei Starovoitov wrote:
> On Wed, Dec 17, 2025 at 9:33 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> On 17/12/2025 17:06, Andrii Nakryiko wrote:
>>> On Wed, Dec 17, 2025 at 8:13 AM Alexei Starovoitov
>>> <alexei.starovoitov@gmail.com> wrote:
>>>>
>>>> On Wed, Dec 17, 2025 at 8:06 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>>
>>>>> struct foo {
>>>>>         struct foo *ptr;
>>>>> };
>>>>>
>>>>> struct bar {
>>>>>
>>>>> #ifdef __MS_EXTENSIONS__
>>>>>         struct foo;
>>>>> #else
>>>>>         struct {
>>>>>                 struct foo *ptr;
>>>>>         };
>>>>> #endif
>>>>
>>>> Did you test it ? I suspect AI invented it.
>>>> I see nothing like this in gcc or llvm sources.
>>>
>>> Grepping a bit I suspect we need to check for _MSC_EXTENSIONS, worst
>>> case - _MSC_VER. But Alan, please double check in practice.
>>
>> Thanks; I tried these too, no luck with either gcc or clang. Looks like the
>> requests to merge them haven't landed yet, latest I could find on this was [1]/[2].
> 
> clang diff landed, but these defines are there only when
> clang is built for windows.
> 
> After studying the code a bit the following works with clang on linux:
> 
> #if __has_builtin(__builtin_FUNCSIG)
> 
> but not with gcc.

So maybe the best we can do here is something like the following at the top
of vmlinux.h:

#ifndef BPF_USE_MS_EXTENSIONS
#if __has_builtin(__builtin_FUNCSIG) || defined(_MSC_EXTENSIONS)
#define BPF_USE_MS_EXTENSIONS
#endif
#endif

...and then guard using #ifdef BPF_USE_MS_EXTENSIONS

That will work on clang and perhaps at some point work on gcc, but also
gives the user the option to supply a macro to force use in cases where
there is no detection available.

