Return-Path: <bpf+bounces-71013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 402E3BDF515
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 17:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0C8D3A7F5C
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 15:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC402FABE6;
	Wed, 15 Oct 2025 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Mhv5LU5p";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jtGib7yF"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7F11F1537
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760541635; cv=fail; b=aBkp/YyJbBpEh2zw34l5GQr+Q/WPpVnlWv2fWYyXg7uEGaqNtMoAMA2PfX0vCijxOX1nDy1DMggKTfnGLA98g3//DEjEgHjtvvYQSf+elatCHwK3ZT07+0CD5BGXL/0ZxiC8MwL/Eur2CTzlrgz0OAAkLjJC5HswXPduP49wCRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760541635; c=relaxed/simple;
	bh=3ygSTOivehQjymKMaB97HdSffZQn29S2ZSFOw2+Ft5Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SROxRloii2TQIlsIzhlQVz/IqGHQX5kYChnKABXybY1qODJpT8EV5sC/HmZKRUMY3eRqD51op+UZi8/wXregX4Ohboo7kHo2s7WdqSexgXDI0LON6PgG2PDgoG+gaO3dSynrzDscNp23uZMNroCXYxxKzn2F5LwqdfF52fLFGzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Mhv5LU5p; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jtGib7yF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FEu3QG025465;
	Wed, 15 Oct 2025 15:19:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=F8o0YaXDjbc2MeWMxZZh0SvoBKt20X0+jMfP3lAssAQ=; b=
	Mhv5LU5pD9JSopQgLfmsnU/3TgHoTMSIhgEJKs1wEsuWesOFws+CAkDv7YKxt6be
	Pt+OKL4NYNoJR/EqtNJT/glV3oueAeRyPcTnHzrHoqVpYj9gF10Y29/+HMHMDAsL
	O+KuQoXAVTGhZLDK+qpEhRQSskm+HGmUJVq4PU+lVE6kLT/o5tZFGlf/CV340WDi
	K1c0Bvrk5HRazjlxev/df/xh79zuC5uMu/wnslvRCgFSjqvOHKftmvfD5+Em2D/G
	vpav9tnfGuYfGV//ePQM7zK4RT5LFl2iSPWC4KNb92BX03a5jwrPRoPJFL8hslUf
	Zvaq2PFurvCETuVcQeBoQQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qe59ew4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 15:19:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59FFB6QV037444;
	Wed, 15 Oct 2025 15:19:42 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013051.outbound.protection.outlook.com [40.93.196.51])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpafqad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 15:19:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oy9IC5fezIp4wSraHy7pe1ymOtXcgskiUlUenZ9Owu6yvhFFlFeGezyo261SMI62hO2pZvKRxshFNzKGYEHkfvijrwQR79UYkhpZGb1ww9mXKjeJy6l89s/GKCVfCs/2ejeQG6i8/GFVTBHWFY6tDcyF7lhKyMitN+2JiULdo0z92yhLxyYTOCZa/46LXmrM+zK3Ra20ZfY3KwO+fESeZZIpfgwd9geHOE3lIoKUgtLSV7DN0jHAGAheDHb6UrbEe/byDStGcFMqyKTvqQMD6y2hkU18Z5wm7AY5snQ++jw/Txod71PDIbzu91ZdZoi4D4qGTslq/cbYbG6OY/+k0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8o0YaXDjbc2MeWMxZZh0SvoBKt20X0+jMfP3lAssAQ=;
 b=c+D6cP21gVLy5TBOdPV5hxUy8caMNMV73+TX80tHF0r5VjYE9kws41Fv3u6gMA6pOoKVtRj5XzR7Ti1/SDZ/cwV04XPnZg0+2VyizoYg1FB94gFpcB/7GjnzLKqIp67TBS2lNYhgsqeTmLQJpbwC0wnu8+tEmFf2Act2sbaiOlBW+cKrrUU60/8b0yrRVty/BYqFEzA8BUDHet0BuCjATBU0Ud5JAaJRz/nSX5i+RtscfmBNYWROAra+x811UDCcrE56hfm5a5Gcq6o82JlxFvhDLZA9a7xFKtHuqqSCnDyQuVztFlhc2nCZkAqR5d3//axCr65qk0gjme2EVOAGZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8o0YaXDjbc2MeWMxZZh0SvoBKt20X0+jMfP3lAssAQ=;
 b=jtGib7yF84jfT8U1guU7wW0bPu5hLEx1afG1hCwCvUFHzOaS1t0iOsa+CjLdyB96TKI6mJkxgGuaNeT5alOZfibA6/GGmBhya3epOIT1wlcw/Li6rL6xrQfAu4PELdVziaBLp+gB8aqCd2nrQDED5YUGyhju7Mdq/mVbI3vY23M=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 SA1PR10MB6319.namprd10.prod.outlook.com (2603:10b6:806:252::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 15:19:38 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 15:19:38 +0000
Message-ID: <5fdfb3f8-8acb-405e-8171-bc57fca71210@oracle.com>
Date: Wed, 15 Oct 2025 16:19:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 00/15] support inline tracing with BTF
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@linux.dev>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thierry Treyer <ttreyer@meta.com>,
        Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Quentin Monnet <qmo@kernel.org>,
        Ihor Solodrai <ihor.solodrai@linux.dev>,
        David Faust
 <david.faust@oracle.com>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        bpf <bpf@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20251008173512.731801-1-alan.maguire@oracle.com>
 <CAADnVQLN3jQLfkjs-AG2GqsG5Ffw_nefYczvSVmiZZm5X9sd=A@mail.gmail.com>
 <b4cd1254-59b4-4bac-9742-49968109c8af@oracle.com>
 <CAADnVQ+yYeX7G--X4eCSW_cyK_DH3xnS-s2tyQLeBYf=NnzUEQ@mail.gmail.com>
 <aO45ZjLlUM0O5NAe@krava> <6a3dfd7d-00de-4215-9bdb-f6ffab899730@oracle.com>
 <aO-s74SN8YDqoEWQ@krava>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <aO-s74SN8YDqoEWQ@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0415.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::19) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|SA1PR10MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d5315dc-fcee-4ca0-1841-08de0bfe413e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1FBd0hWV045WG5VbWtNQ2JPWE1zM3BVU1ozTkZqU3BPOXB6ZXhWU01pSG4v?=
 =?utf-8?B?WFBnazFhRnpLUGhhMWhQSUZOeVNKdk9vWnJ1WmFYbC92S0hLY1hCV0RrZndJ?=
 =?utf-8?B?U3dKLzIyemFaYlF3QmU3cW05YmdIT25YZndjaFhZRDg4dkRGdllrMTg4alY2?=
 =?utf-8?B?SGhRVFdyQmVUeWEwK2c4alRKbW5OeGx3ZU9JcWFtbWpyckV0TnVzeXpTRWdo?=
 =?utf-8?B?YjZFQUdjeXJpMUl4bWUxQXhhSHJFaHpLZ2Y0MFFNK004VHBNM1hWd0s1U2hl?=
 =?utf-8?B?Rm9ZaDVqV2VIb0xjL0M3WnZxMktscmZXN0xTSmdQZ3BuWkFvNzJPTVRYNTBm?=
 =?utf-8?B?RWFNMWxadlRUMW56cjFPSUhkZHZhR2t6dk8wZktZamtkc2U4OGdnVWFOMEtJ?=
 =?utf-8?B?cGFPa2dMYXkyN0xoMTIxQzFnZTdCU3kzZ3lpUWhOeWdxdzYrTEZtck9CTDY0?=
 =?utf-8?B?ODlVaUdZWjhtUU84czQzUlVJNXZocmpRdnNHcnBhOHZ1T0dHZVlxbXRXc2Fo?=
 =?utf-8?B?aEtvQTNYQnM4L2F5aFVwWmxJazFLUGdhV3N3WUYwTHpIdjNFb1VmMitVeWZV?=
 =?utf-8?B?V25VdWFzVERFZ0tNQU0yU0xEMzZ6cmh3TXZLRnErNkRLc0VzaHpvUmViczk1?=
 =?utf-8?B?aG44bHl5RHZ6clgyZkpJcHpyTEVaQ1pCZjhDcktzUURFYm56WjVCZjNDQUg1?=
 =?utf-8?B?ZGM4Wnhpc0tjOEdicmp4UmJoblcvVE5EbzJtZVh0WVBvZDQvckpDbUxpNzlW?=
 =?utf-8?B?VUFtcXhqWmdKdjVTNGNZSmtnRUxzRURXdW5xUHprRy9BU3RTKzcvSG4wdWJl?=
 =?utf-8?B?TkEyUEpwZHpIY2lXL0Y0RnJoYnl3V2pNdVRVVHgvTlFwZ2pWZ3p3bkxJc1o5?=
 =?utf-8?B?R3h4VDRiTENrd1JSNFRVOUJuT0ozVURIL3ZFdWlpRlNaVmhpV0grcmxuR3hB?=
 =?utf-8?B?SHJKOXVTRnBQb3NSVG9aS3FsMExKc3puVmpXTTkxUVV0dlpJYkdPWDZzSytL?=
 =?utf-8?B?bC8rYThOK0tHTVVwT1JFVVA3TWpRTm9WSzM0cWJCanh0S1YvbnpvaFl1aVo5?=
 =?utf-8?B?Z2xPaHM2RTIwa0tSOGlFQmJFTXBIaVlLZm1LN003U2ZQK1NKTU9WNTd3TTIr?=
 =?utf-8?B?S0IxRXpEaWx4enZDbWc4Um1XNGNuQ0VBQ3Z5aUVIQjFVNWp5RXoySndTS2Zi?=
 =?utf-8?B?UGpWa0FVZ1JQSUF4SlByUU9DS2IzRXk0TXA5RkVzeXhpa3pKbjVKcVVkVXhJ?=
 =?utf-8?B?MTZlK2NsZnZzNmg0ZmtsZUhBKzc3cEZ0YWRTeDU5aXpBVG9HNUx5ZU1lbXpR?=
 =?utf-8?B?U05kMTVhdEtQWGh5T2psMjR2Szd5VDAwNGc3VE5QOE53cm9KRkdkR01SVTJT?=
 =?utf-8?B?TGdEZm1ld1k3TEdCMEYxNHVmMnQ1dUZmTkVJZkQzZ09lMHFDODlLeHR2WXZw?=
 =?utf-8?B?R1NTRW9qcEFtYUVKL0pnZmsyZ3ZnbDN6SVFzSEFraFhuZjV0bEhWS2wwS2k1?=
 =?utf-8?B?NEFGcHpndHlBdXA4bGtVRXFHVVFVcUpJaHZQc29obVBrN2JtdDl1WnZOcHh1?=
 =?utf-8?B?MnA4ZWc0RWwrOThxdllYWE5HV0NvNTJCQ0RlbU5MYXF2UFg1ZVp6cXgvMjli?=
 =?utf-8?B?WXVpanR6TVpEK0Vwd2FFaThhdHZOakFkWEhtbWxhRzJ4bUlWeDlNSVAwbFQ4?=
 =?utf-8?B?Q1pLeUJVWnRQL3daQWF0K21KbFRXRGEvMW41SDZLTVFXOUF4cm5YR2ZXYWM5?=
 =?utf-8?B?Ulh0aVRwTmwza3h4S29EMlFzR3J3RzVzcUhHQUdXdklHcE5YK1VUd2xzeVN1?=
 =?utf-8?B?QXFDZjhIekwySVowMFk0dUtXSjdCVFVzN0NMd2l1T2xXRXR2TC9LdWFDVGpS?=
 =?utf-8?B?RFlFQUtwV0RKTnNzTVdLNWN2aWhueXViYUFKNlE0VFB0ZDdrSU4yZUdUb0p5?=
 =?utf-8?Q?0eHZGL8D4cEMAeN8vIV5cb0n6XNU1ee9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVJBeEdzQjU5UmRUTTFlZ0pZMmpvZytoNE1hSVZFaTJKL2xlYWc4MjhQTDh4?=
 =?utf-8?B?cEZWZUM0VzZLdS9Lb3dpUkdWbm05dHRud2dmZHRpMi9IeXBXd291OFhWeWZs?=
 =?utf-8?B?bkpObjZRQktrRVVZenEvcDFpbnEwUDI3Rm5qQ0ZJVlp0d3JjQlJRWUlMdlFO?=
 =?utf-8?B?NUdaeG5vc0RGT01lUG10eWJ3cXRQMmJrYVZhcDBCRzIzWmRMVy9GeVM4RldI?=
 =?utf-8?B?Y2FBRml0ZUljMVJpWTV3emQ5WDFsWkdRMk10ODlIdTgzVmV3Qko4QjdLYmJE?=
 =?utf-8?B?eWtNblNkSExNV04zS1N1dUlOSDdKZk95ekoxVkNqMThTY21zQ2E3K1lBazlx?=
 =?utf-8?B?eW5KY2FINFZPT1RqUzVGTHpjT0Y3WldYSldSb0xiUXMzZjdqMWUvaHdrOUJv?=
 =?utf-8?B?S2MyMUpXUUEvM3hDd3BUZ2pVVitzU0Z1NWZ3OEhKUUpyeWNRNFptV3B3SUkr?=
 =?utf-8?B?NTRaZ290dEt0OVJtZy8wbW8rWXlVWjZlTEpTVHRGQ2gyMnN0SXR0bVVQanBG?=
 =?utf-8?B?aXdobDFSZGp5RmUxRjNENzFpZm9RV2UxZGZ3OUU5aHIzenJRQ1J6SWFaZTZR?=
 =?utf-8?B?QzFrbXRLNnQ0MzZiOHhEaGFKalZmUEVXanIwRGpJNmhPeFZ4RUhjZWxUN3dL?=
 =?utf-8?B?cDlyTXJSNktLdklZQ2VZUU1NRGJ1UlorenRGb3JRNWRrUlFld1MyUkZVdTVY?=
 =?utf-8?B?T2tIQjRXNlo2YXJZWHZ4NVdzNEUwZ1ppTGhmV09wSzhYb3V3dVAzSDBmeWtH?=
 =?utf-8?B?S3l5K0ZncnRTUjNrWWgzZFY3Y3c2aXRGR3JHbjdtanczb1AvUlhTL0trNHFE?=
 =?utf-8?B?dC9wT1dBaUZjcjZVN1RHNXFWNmZCVGorbnZjMnRvQTNGaHBFWENOQWNsYmRn?=
 =?utf-8?B?dExsT25GdmtoZW9VVUhMVy9odHB4L1ROWWNUMEZocS9BQ1JCWmFtRzdrZkdu?=
 =?utf-8?B?cVpLMTJFZm96RUlUc21ETnJFYXNhbUxwTHYyaHp2RHNIY0RvLzk4T0tPekxm?=
 =?utf-8?B?bGZPWGhrbGkvMlBLTDFqeXUyWldaQ095aUJmczZ5NEE2bTRGR3JBRVpJcW9Q?=
 =?utf-8?B?ZlljL0RPZy9KdTlzektpeGVpR1hpbSsrM0tLR1RZb0dpZHB1UUhGbExSdjBP?=
 =?utf-8?B?ZUVRNTltUFdsbWtKUGtMVmw3N3hEZExSeGd3L3UvbXRxRW05Tlg4TmRvQXF3?=
 =?utf-8?B?NVJsdzM4dXQ1RGI4VDFyemV6UGlDYk1ZNzNrQU1Ra1dMd0Q5eVFSanIvMk1w?=
 =?utf-8?B?NXhWQkdtQmdzUHE3aXYxV3JzVjJRdlgxeWFuQk5OTkFXM0NLVEQ3YSs1aTky?=
 =?utf-8?B?d1JFK3FkYkY1UFgvUkFvdWNmMlU5aU0rWHljcFpDc1JsQmxnVE5UN1BYdjAv?=
 =?utf-8?B?Z0t0bllqZGowRWdoaW1UTHVyZWRUd0VTQzlxRmhvU01vckFISHI4WEVYeldx?=
 =?utf-8?B?c3dHci9ab0dQSUhXdHU3R3RGYldJZDFCNUpNdFdvMU5LQWplTXk1bEJTYU9u?=
 =?utf-8?B?SmNyOUhRcDNBamFqT3ZGRFpNOVZZVWlrUHE0Rlp5SFBMek1OcGViUTFzMy84?=
 =?utf-8?B?U05rV3lkNmJCaytZWmE5RnhlaVJzWWRtbEN0Y05YUVF1S2hJdy9CTWNTSlNp?=
 =?utf-8?B?QmdFc2RuUU9rMHhXVGpySXNjL0grZDgzN1RSVFhsRWEvOU9RQjAraEM5MG9X?=
 =?utf-8?B?ZDl3MVR0akdpY09YTkhSWnk0SUhQcXcyVkxCbEpOSGdLUmNTSmFOem81YTNP?=
 =?utf-8?B?N0ZBZXAyVWUrakFNM01MTlFYMHAydlhtR3l0YUVlcGZpczdGU0tWZ3hOMnpv?=
 =?utf-8?B?Qm1wYnQyZjlZbVlYOHZKcEZCckFiQTlERVBJTHJad0t4dGxYNmdQam1EWUVP?=
 =?utf-8?B?ZE9yaFY5MkJuR0FScWQ1S1lhM2loVml1Q3F6TlZKN3RkYUFGOURPN1hBbnNw?=
 =?utf-8?B?bXB5V3BlTHBXWGtuZmQxREloeFBDZjVwdURqbi84ZHpSODBKL3lIdmpkUjFH?=
 =?utf-8?B?UnJ2WWRHbVVJNXVLOExFc3UyWXBlbTluTjUvaTIzR2d2aE9aQ1cvcXdDTFhI?=
 =?utf-8?B?UWtVSkovdzkxNEdzeVJ6Y1FzdWQvRWtpcExTbkF4MjBrQkYrSSsybENvaFhs?=
 =?utf-8?B?eTQ1UXg1UWwwekVkR2l4SWdDcDlzSTIwUTZ2TWFZZTllZGQ1b21qd2pFNFZs?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JOkDqoKF1jqPvMxw60mXKdMfzrkS6VqHKGA/iDsRIPXihDmCIztXFrrpZDF3xTb3TKYzUdfu/9hDPLtio6mp73Dfdqn5Tak3fJEAjbaOxK4kU/dsuW2IvhCtZ/8aRrjtt1zyvlkCpOkNxHiCeSvd1JMFtWsfFaQQ4BTqEM84x3c7e6Pt5P/MMRvpBpZM964vO6R9ZlEET4ULCk77yqgie2gZzphnKYR8K7oc519fvaih79OzPjk5J18Np11xAEImjT4lzo5bO7OOc5zWg82h1449oMowcMy44lpZCJCOVKEJr3VovMCT0kz2kQf+kfeZ63IessvGi/ddFKrVIXfRncQS+JcjZWii6HtRDi++ncgd6VtMZy4/0eKUKPaCLHgFH/h/bdihZaGyOoG8eCeXvzn+Z9lGZ+NKiKdmZ31AvD3ai8VhECpX2G9v8BqO5TmS6bM70xGfvv/737JWvvwVH77/4Ij4BmBU+guE6imxHv+s2IXloOVRi4wTDkF76IOU3HuytHWyaBLoFZbPs7ktXxcqGe+FstzXRKQee3HU6RBJuFivkfkRO83nn8QPWpsjJN9AeWqfoAAcH4/huFEg+93Rssuhwyr95oHoihnVxao=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d5315dc-fcee-4ca0-1841-08de0bfe413e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 15:19:38.0753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C5SRNdskFwP6fycGguwWqF7NwU+3czIipwWNQI4Nry1+H58aUCyNwEjhQJZ8/rMTTgnsMfVvml4bHv99RFIG7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6319
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510150116
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMCBTYWx0ZWRfX0ZXw3UzFRIz+
 bwz0+/AQvrRzl+335FPhIMAt05kPpUChmvB7Bo5Swy8UbuYxtM4jsO5uitt4Lp8zYoCS2ckSm/i
 XuabhISmlJ70wXr6eHn4OCtugmiAChYLps5NWm3B4qIMT8kJqHOpRRKAqpLdTcxhHrFTdGudKQd
 +U9fQlanC6+Xd5aoE8vqe/XUVmjqfCnJQjKLRZQB/Jgntn9nMFdGuBKmmzTKJdPmKkldHEQnWxp
 QHV0+UK7i+NJqbu0wX55lWb4/EJ60X63NB+EpKDZb6JzpYxCkeW7Vib7FvP1u7XZ0j/tVreage0
 tC0wR5o7vqk/rwApCdJHZJ6pW+MEoe2GUdLMFmVMgxQ9yG0F5KeqF3rmoVhoBgtq4wuYmgwaGfC
 5Ep5OKPwqp0hcmTB7UUnM5fwLS6HRw==
X-Authority-Analysis: v=2.4 cv=V7JwEOni c=1 sm=1 tr=0 ts=68efbb8f cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=VUVdGSQf2XHouxhYba8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 6Wpe-7uL-jd6SPqUCzu7O9gGy746nkXg
X-Proofpoint-GUID: 6Wpe-7uL-jd6SPqUCzu7O9gGy746nkXg

On 15/10/2025 15:17, Jiri Olsa wrote:
> On Tue, Oct 14, 2025 at 03:55:53PM +0100, Alan Maguire wrote:
>> On 14/10/2025 12:52, Jiri Olsa wrote:
>>> On Mon, Oct 13, 2025 at 05:12:45PM -0700, Alexei Starovoitov wrote:
>>>> On Mon, Oct 13, 2025 at 12:38 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>>
>>>>>
>>>>> I was trying to avoid being specific about inlines since the same
>>>>> approach works for function sites with optimized-out parameters and they
>>>>> could be easily added to the representation (and probably should be in a
>>>>> future version of this series). Another "extra" source of info
>>>>> potentially is the (non per-cpu) global variables that Stephen sent
>>>>> patches for a while back and the feeling was it was too big to add to
>>>>> vmlinux BTF proper.
>>>>>
>>>>> But extra is a terrible name. .BTF.aux for auxiliary info perhaps?
>>>>
>>>> aux is too abstract and doesn't convey any meaning.
>>>> How about "BTF.func_info" ? It will cover inlined and optimized funcs.
>>>>
>>>> Thinking more about reuse of struct btf_type for these...
>>>> After sleeping on it it feels a bit awkward today, since if they're
>>>> types they suppose to be in one table with other types,
>>>> searchable and so on, but we actually don't want them there.
>>>> btf_find_*() isn't fast and people are trying to optimize it.
>>>> Also if we teach the kernel to use these loc-s they probably
>>>> should be in a separate table.
>>>>
>>>> global non per-cpu vars fit into current BTF's datasec concept,
>>>> so they can be another kernel module with a different name.
>>>>
>>>> I guess one can argue that LOCSEC is similar to DATASEC.
>>>> Both need their own search tables separate from the main type table.
>>>>
>>>>>
>>>>>> The partially inlined functions were the biggest footgun so far.
>>>>>> Missing fully inlined is painful, but it's not a footgun.
>>>>>> So I think doing "kloc" and usdt-like bpf_loc_arg() completely in
>>>>>> user space is not enough. It's great and, probably, can be supported,
>>>>>> but the kernel should use this "BTF.inline_info" as well to
>>>>>> preserve "backward compatibility" for functions that were
>>>>>> not-inlined in an older kernel and got partially inlined in a new kernel.
>>>>>>
>>>>>
>>>>> That would be great; we'd need to teach the kernel to handle multi-split
>>>>> BTF but I would hope that wouldn't be too tricky.
>>>>>
>>>>>> If we could use kprobe-multi then usdt-like bpf_loc_arg() would
>>>>>> make a lot of sense, but since libbpf has to attach a bunch
>>>>>> of regular kprobes it seems to me the kernel support is more appropriate
>>>>>> for the whole thing.
>>>>>
>>>>> I'm happy with either a userspace or kernel-based approach; the main aim
>>>>> is to provide this functionality in as straightforward a form as
>>>>> possible to tracers/libbpf. I have to confess I didn't follow the whole
>>>>> kprobe multi progress, but at one stage that was more kprobe-based
>>>>> right? Would there be any value in exploring a flavour of kprobe-multi
>>>>> that didn't use fprobe and might work for this sort of use case? As you
>>>>> say if we had that keeping a user-space based approach might be more
>>>>> attractive as an option.
>>>>
>>>> Agree.
>>>>
>>>> Jiri,
>>>> how hard would it be to make multi-kprobe work on arbitrary IPs ?
>>>
>>> multi-kprobe uses fprobe which uses ftrace/fgraph fast api to attach,
>>> but it can do that only on the entry of ftrace-able functions which
>>> have nop5 hooks at the entry
>>>
>>> attaching anywhere else requires standard kprobe and the attach time
>>> (and execution time) will be bad
>>>
>>> would be great if inlined functions kept the nop5/fentry hooks ;-)
>>> but that's probably not that simple
>>>
>>
>> Yeah, if it was doable - and with metadata about inline sites it
>> certainly _seems_ possible - it does seem to work against the reason we
>> inline stuff (saving overheads). Steve mentioned this as a possibility
>> at GNU cauldron too if I remember, so worth discussing of course!
>>
>> I was thinking about something simpler to be honest; a flavour of kprobe
>> multi that used kprobes under the hood in kernel to be suitable for
>> inline sites without any tweaking of the sites. So there is a kprobe
>> performance penalty if you're tracing, but none otherwise.
> 
> so you mean we'd still use kprobe_multi api and its code would use fprobe
> for ftrace-able functions and standard kprobe for the rest?
> 
> jirka

Yeah, if possible. For the kernel inline sites we'd be dealing in raw
addresses rather than function names so that in itself might be enough
of a hint that it's not an fprobe site, so I guess it could be framed as
an extension of kprobe multi to support a mix of fprobe-able and
non-fprobe-able sites. Not sure how feasible that is though.

Alan

