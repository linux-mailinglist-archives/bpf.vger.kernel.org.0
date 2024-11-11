Return-Path: <bpf+bounces-44527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DAB9C4208
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 16:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2231F2324A
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 15:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F134019F130;
	Mon, 11 Nov 2024 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V628GuXS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="W0jGv0zR"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4246B80034;
	Mon, 11 Nov 2024 15:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731339620; cv=fail; b=riFDr6y3UsiG+Aj0Mi+5O8Q9SWeak8vav/jBorjkSKv4GNzlFwuyZsi1zmTgpUORFPfZU1RH2VEOVtmEBoDfYhMdgRWWa8OAKvhVn/IcosZfMe68YBGSdfwR2G8vHYuSbnZ0CnYkFETqnT6LPJj8LJquJnwhX27f+wS17nMV+DE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731339620; c=relaxed/simple;
	bh=o0QmcPZVGlc6/RUoQAU9CYMScrQe/pFHsWDUX1ESfZg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iELJ3N00CcV5LBhwkEaf+r9YhJ9/VZUMQZL0Iv+124FlBNXIXUP/5MeZYt+F0nAO0+QPNSVr7ECiQepttuVxLrJcdu1HT1FkqR0muHxS7F1n5m/dVWRZDdxPFCR4fq6ePdrg2hHlBBNF2KNEP4NCfsVELJf+u6LJ9fWRJAcMiQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V628GuXS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=W0jGv0zR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AB9socb026295;
	Mon, 11 Nov 2024 15:39:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=+qFjGFycdZfuoI/KUTd0N4XuE3U4fbJXaoMMOYNOI1g=; b=
	V628GuXSp6isAAQfzsP+2Ty980iUh5CbHxPgnNySDOZLRba8PhK5A3fKHTMGV3qB
	bXltbhOfS8/isq9LVtgGuPDNm6+zs07EEVrd8vjelM2MkphHLcrcpezzJTE3js1j
	kho9HbEZm25LfxIW7PF577TIRgTHpYU4+lX1z5Kxy154yvPziCQ5Kxlzh0Xhtrql
	rg5Yo9sXiestQ3G9niF0eG3Df6AoVKy/EQyTYo8QVB07rx8xC8rbBDhrJ0Pc7HdT
	LTxQvC73jbj+0bHVIHE3mbpQE3LvIu+w0ZlBrgC5vTfNmzuEpkA+1cf0wIi4Mymw
	4b/FdkvJHYsBJT9pCugi3A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k5ap5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 15:39:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABECoEi023674;
	Mon, 11 Nov 2024 15:39:51 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx66wndb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 15:39:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5Vu7k0a3Avvq1QXEo/vF0XwAWaAJvaLHTfZklDMYpho1n9qfahktXDOYhc2jOw4fX7OlkdsMiGCjWQPfAHgt+27GuM+LBv1wu4KKAmARTSaSgdbZvs3vUrIIYEO+T0bgGPWPp4fT8cLU7+sp9NrF5g5oMT7BvmVYu5M8ujotxGSwyhWLPOOldFW1+vDWs2i9xOn4AJ6FxSNOBIJSZoZTw+B8V24sgKYVVuQOZ+RzYleWnAp8pWM55W2O1Ps6RelJmlo4N+UGZHN3uPC2PrKFc1AFnE465V+rrX+KW51ofSlglTIXhfFPBp0Rd0a2nATMTgmkN3rJC/Rm47AyVwOXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qFjGFycdZfuoI/KUTd0N4XuE3U4fbJXaoMMOYNOI1g=;
 b=D652n3TT2POaZ1A2yBWYBZCg6psHdeCbJDDZBE8oZfTw7Z1k90ByLCrnGr1a/3+FSaAPeRw+pNIELUz+a3utx1UVc+ZvkxuwY6oMkvLD5+WuZmwaO9ES+/4tL3Qa6rj6S8q8ZGJBnVwHpzwx4y6Z+E4dSiRb0cyWy/uOunXFgsTTsfdexPepMsYX2luCQ5Lf9reVsr92wC90LdKrofc/Tag9eoHuet2zWoAfISeNM7bqXxeYhyaCJRmIAlcQHTdt1+I7h0z3XZcIli0P3fwI2oo70K0SUJp6GcRTYxzpC8+qmYnF2sbH/TlEqmksudPIkPjwjqehBEXmnTvA4hM8og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qFjGFycdZfuoI/KUTd0N4XuE3U4fbJXaoMMOYNOI1g=;
 b=W0jGv0zROxqpkMVfLWJ/BBwIY+PuwODQekrUeacRAe7Yk6wg3Hiawf1p/Ys0GoUnQB9kOoMatjKtFARPEOqfL4CFAAjctmrpvArnF92XXNfeE17lnd+7bjGpvaFC99rTS8mpICzjFPRg1pBsIjOY0p5Hl23PjSgeA2L2o9iOwX4=
Received: from DS7PR10MB5278.namprd10.prod.outlook.com (2603:10b6:5:3a5::9) by
 IA1PR10MB6146.namprd10.prod.outlook.com (2603:10b6:208:3aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 15:39:48 +0000
Received: from DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::eb46:3581:87c4:e378]) by DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::eb46:3581:87c4:e378%2]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 15:39:48 +0000
Message-ID: <b32b2892-31b1-4dc0-8398-d8fadfaafcc6@oracle.com>
Date: Mon, 11 Nov 2024 15:39:42 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves 3/3] dwarf_loader: Check DW_OP_[GNU_]entry_value
 for possible parameter matching
To: Yonghong Song <yonghong.song@linux.dev>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team@fb.com, Song Liu <song@kernel.org>
References: <20241108180508.1196431-1-yonghong.song@linux.dev>
 <20241108180524.1198900-1-yonghong.song@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20241108180524.1198900-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0141.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::46) To DS7PR10MB5278.namprd10.prod.outlook.com
 (2603:10b6:5:3a5::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5278:EE_|IA1PR10MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: 218737b5-b7e1-471e-fa24-08dd02671337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZEFxQ3pkRGgybHBMQ3QwQnh3cUJzVThUNGlyMTlnUnA1aW1VdEVobUIrdktT?=
 =?utf-8?B?TE1yTkFPbDg4TSsvNjJ5WlBhQkhxYnMwSUc5RVJ6WU9CbWlIemtWS1VpaTk3?=
 =?utf-8?B?YUIvY3ZiZERPa3pXcVRoV1plOUw2TUl6K3NUSWJBd01zVHlXSHVUb01Vemxj?=
 =?utf-8?B?L2ZoNmlwRlVyWm5DQTRBckJSdk9jc1NJdUhnNHdPS203eXBrSUI5dFdiaHRR?=
 =?utf-8?B?N2pTWDdVODNZQm91OWMzSVRQbTU2TGkvWDlyWFRCdTFsenZCaTRrTTB1dEpY?=
 =?utf-8?B?Q3VJb2ZnVFhVd2FYYXF3Q2hKWERNYmw5SERWeXJmaUtxMndaS1BjMU04NG5N?=
 =?utf-8?B?RnRHdjVvMUZ5RDNhdzRvSkxWdFdIZnZYa0R2SXNycGZuTVZpNEZTTW5JSHZm?=
 =?utf-8?B?YmJBbWxrWWV4TlZpanpDZzVJZS9malV6VjZrTlVJU0NiRlRvcFFXMll0QWNJ?=
 =?utf-8?B?L0F6dDZ3MWpZUzljc0pyU2M0ODBBMldYZE1lYUM0Nk4yWmpla0VGNll6RkJL?=
 =?utf-8?B?TlIzak10eG9YazcyTGpkbEk2ZCt4Rkt4cUVBSmhjV2swU2h3WUhQYjkzOG0z?=
 =?utf-8?B?anF2N3E3QWRPMEZBbWNoaE5hanM3K0FRb245dGxLL01MUXdlY1ZwYWVIbFJT?=
 =?utf-8?B?ZU9ld3RNd2xHMnRwOEtlYnV1NzdCREVWQitjVm42WFJUWEpBeDNZYTRnNUxo?=
 =?utf-8?B?bEFndFl2YmdhbDU5ckpOeWFDQmpVcTJJd2NTalBmeVZ6WndFdjRUZkhzczgx?=
 =?utf-8?B?VEw4YUZLb3pGQVpMMjI5VlJ4UVFxZ0wvMFRhbWdkMlFLWTM3eWpYaFd3djRX?=
 =?utf-8?B?OExPSDdFcE5VM3psS0hKU1hHL3k4clBhbks0TndRR1JjakFUU1RYZGZSWEJI?=
 =?utf-8?B?dnY0QitySGluSmwzNnZHRm5hb2hyalc3YU93VjNXZkZ4MHpJZ0pnNk9mOU1k?=
 =?utf-8?B?TjVLU0x6Y01CVmp1bUUvRnN1R1VpWDVvbVBoOHowak1EcWJja0JCSG95NlpM?=
 =?utf-8?B?U3FhNk9xb0ZsSWZML1VJQkNSdVJLZVM3VDJXaGJXYVcvS05IN0RMZTVwQWVa?=
 =?utf-8?B?TDdpdnA2MkdMTTNuUWhKa0JvOVVnakgwb0ZiT3h5TGU0ajJsdXlGRmQ3Q213?=
 =?utf-8?B?ZmNUeGp6WEFCSlpZVEltb1NtV1lGNmR6ZHAwQ0VhZUNRMDU5ZEVHNWlzYStt?=
 =?utf-8?B?ZWk1NUtMalB4S0NYYTZWSzZzU0JLR0VHTFlUa2l1bHhuaWJKQ1BjM1lRSUlR?=
 =?utf-8?B?QTFQK0h5a243bXdnakt3cXF0VTdZNTFBSVhCdHFLOHNIdE1HS2hCTGVKMTNY?=
 =?utf-8?B?bHFpNVY2ckVha1pSR1pqSkhkR2VTWkNvT1p5d3VYOUZqVmJOWGRoVW9iNjI1?=
 =?utf-8?B?U1J4Ny9VaVBEeitYd3pJMlowd0phd3lkaVVSc3BhRS9nMGVUK1U1ZUU3SXFN?=
 =?utf-8?B?RkZhTUZFZmdWajQvbkhSSGZTY2RsczdWd2d6Vi9NZ0FrZnl3SFV0Ym1QSmFx?=
 =?utf-8?B?V1I3VUJhTjUrVlRXUnlYR0tpVjJpUlh1Z3o1cFhzS3JaWktudlBvK3JtL0NE?=
 =?utf-8?B?TFV1ajhaYTQ0VVg1UHhDQXMzTHcyMGppb2JvWUJuZDJia2ZHZVd2TkVFcTdi?=
 =?utf-8?B?c3p4YnlHeHlQeWJpOGlhaE9pNm5uS3dkNlh4N2hmRVU2R2M4akYyMTlkeDZN?=
 =?utf-8?B?dGpsRE84VkpNamxiQWhYQkRYbjBhUFpxVGtPZkVRalBSUXpidlFuSkxSMFAv?=
 =?utf-8?Q?BU/iGOp3Uo8YLtMCA5k87cWJrwy2lwOi4oar4W2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5278.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUpPN2JqUGhJbk0yS2I5VExRS3F4ZmZkcExJOXlpOEE3RExGb1U2MjNjT3hh?=
 =?utf-8?B?Q291R1pkVENxVVU2dzJlaGdXd0doNVk4VUV2ZnM4R01UeGV1RHpzdjBDTU5y?=
 =?utf-8?B?QmlTUnF2cmJMUVgydUhQYjNpN211VFdjVHVPTVpWVkJDaDZBZVVZSHZQU1lu?=
 =?utf-8?B?SzZwY243emNXVHJHdzkyZGdoVkh4WHphdkZnaFR0YkRqRk9xYlRjKzZYS3Bx?=
 =?utf-8?B?TkViUDVWZE40N01pUVhYZmcyeFJrQW9oaWNjU2s2aXdIV3cwWWw2UnI4bGs4?=
 =?utf-8?B?c01MZnNJSVQzSzBIWFM3ZFAwRkR6YkE5aGJvU1NUQXlXSmVIMGRyTEpTZmEy?=
 =?utf-8?B?S3BFMklsMDFVR1hkcElldGhzQ3BXVWhtVi8zTTlCTzFjUGgvTDJLRUxnNVVL?=
 =?utf-8?B?RFk5SzFValNjWVRJZWsweHdrUURIR0Z5bUpTNHhKQ1dFRE1BYnhDRWVOSWx2?=
 =?utf-8?B?VzU0QmdzTzZJa1dNUGZJVktKUmc3OHlDSTQyUUVwdkQxWlA0aVdycnhBbUl3?=
 =?utf-8?B?YmZYbVJYNDFieisyNTVFeVZHQVpKaWcrVXBIT3FOSWZaRGZRdHUyMW9DVGNG?=
 =?utf-8?B?VVpRcCszN3Yza0hPM3B5dEc2YlRRNFRtdlF6d1JPbCtrN2xST1Z0R016S0lt?=
 =?utf-8?B?UEQ3aHFvSUJ5Z0pDclFQa2FCOTBzRmdWQktmYnd4UGlvWmVMSUVaeWlQdFc5?=
 =?utf-8?B?cWVKMUtDclpzaFR0bjdySnRmVnoyeVZ0bTNtZk5MWHdvOVRHZTN5S2FtQ2RU?=
 =?utf-8?B?TkpXVVVOR0lqYmtFQWhiVmUrTnZKNFFrREthSDFtSC9xWFpvOHFNdjRZS3cx?=
 =?utf-8?B?SmROQlc2ejcyZ2FUK0hNemIycHQyc0drR2xTQllaYVhZMklZaGNwb05pWEFG?=
 =?utf-8?B?cnlxWHBQcVFZZ0UybEUvZmt0QjBZSkNINFNkUGpqNVRqMjdDRVNVOUdhSXdj?=
 =?utf-8?B?djNkOXJia29TTkp0VlJWdkZYZ0FPekllb0ZPY25BZzhYbGxlelZZRU5qMEQw?=
 =?utf-8?B?ZWowUzRvRXV1QjlYVlVLZk5zZi83dUo0cG4wS0I2dTN2b3JWSTdYajZmUnBP?=
 =?utf-8?B?YnNydGZIS1pKYXFNdzNNd1gwSWo4QUpXSFYwdkduMWVHQWg5VVhXMTJtK3lJ?=
 =?utf-8?B?WDZySjRHdFNXcFZ0SGE5aEU5QXM0TWJqWGphN1VDTXlNYUh1YUg2OFJTRmRl?=
 =?utf-8?B?RWNjMHQ3L2RPY1RHSlpFL3lnS0YxOGN1a3RyVmZjWVo5anVqMFVLQUl5dE5s?=
 =?utf-8?B?SlYyb0FwUGJDc3lBL1VEREYrdzYwN1diZ0tadFFMc25kOUVKYjFaRVhIb3Y1?=
 =?utf-8?B?ZDZWUWNIcjVJL2JTY1EwbEQybjFUaEhveHgySnRCSWRpYXZ3alFlZUJNd1Ja?=
 =?utf-8?B?ZzRYT2dYakJBTjlXQkZBbGRhclB5Z0lwQ1J0aXo0a2lpeXNsakRPR3RSWVJs?=
 =?utf-8?B?OXltdWZhTUk0dHBqTHB4a1pSNVQreWt5em5aWU9OSkRuUy9CckdBV3dDWDJ6?=
 =?utf-8?B?aFZqb2RGcmsveW9wZWN0TlRpcWF4dllmL0QwSmpZb2xHcHVJUXNCc2p6ZEZu?=
 =?utf-8?B?T0JrR3ZQcStZQzAzc2liS3VwaWh4SFIvcWZxWHpQWXY1bGgxaEU2OGE1UW0r?=
 =?utf-8?B?NUJHd0wxTUtCUWxHOU94VUVjTGg5cU8wZUxwdGdPWC8vUkhhNU1iR3BRcnRW?=
 =?utf-8?B?c3hIamdSOWdFdm5ONzdtYlJUU1ZYdHRFUHpoQmY1bWhZem11ci8rVGpWOHR2?=
 =?utf-8?B?S0lNNU1NY2JIcENlZWVEVHdmMVd4ZlpPOEZvWWFKSXNMbFJoNkdPZXk3blVF?=
 =?utf-8?B?T3c1ZDMrQjZwZWdocmVDR0xGTXpja2xCSjRteURyS3FhUXVXemlnWTZORmg4?=
 =?utf-8?B?R0dBWElwVW9Iak9lRWdSOWozMTVqWURJTWpUZFN1QUR2QjkxQVJmWE10Zzli?=
 =?utf-8?B?c1oxMFd4bW5yQTZ1U2J4VlpwdGJMOE4vZXZBUTFDQVR0dUp4OUx6WGttR1B4?=
 =?utf-8?B?UEgvMkNBZkRXcnBFVGNxQ1NaUW9IWkcvOCtyd0JJbytlSjZ2L09rNVVVVW05?=
 =?utf-8?B?YzVRV2ZPUzRnbzhxNkdyaTZzczBUcUI2QjVSNzQ1OGdRMnpLMU5IQTVOYmJl?=
 =?utf-8?B?RUhySUtuVmpmUjRjeXR4dklEdHdQdE1JYmpzL0R5RHdnd1J6RS8xSmx1SFhT?=
 =?utf-8?Q?hLXVkceZihEkOY6jaZcjrXs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dM4YVVPmMmQThJNb7ByKILtBn41sjjQX6ACI2y9pz0lFGTxSjCUH7OTjdhGpgw+Q3ftJb49skvbQqDiPNqU95g5aXSAOIwrXLL0WVBSWUpJixfplu1uv68uaVLJsyc9o5+kjCdqk33NPfyW7PaotlgeIB2qa3Y2bvhr7t7w4bDaANaphuKJYq6E3G4kBSkIlz8N8ym9EnzDaXKaeW+0pVsbgfo1Yf28qCwlioCREfvRc2Xggp8kU52y7ZmiXWDrhel1hLkrVX0Uxj7cp+xLRsd3RrQdK2VkSTmgZtH0EwNAwpP9+De7GVYnHwL9KWejoFHXDeOCxYpWg0ofgo5up9zrwZ/VWbR+Z9tmWHuWpwTs9mz3zsk4IMD/jSK6kg5o0D90XWFWdOPN5rLeqKswTMDSW7vNi8Hv4v2BcY70cOw5JNprhSWqMdOdU6c0ZkaeRYxp8xsxR+pgepBibF7TDzRlk8TVT6CO3RKtsclLflDoCNLdOnwn+8ITkzGP8DjaJcpWEG7QzzEzLbDrVSDPPfJSAcY78VTMPElITuJq+XFrWYeX/DsNni7kzSb6oKlshrPJiY3UcJ6qc85z/vDvWVrtLDLf2j2eVe1JrrwV5/ds=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 218737b5-b7e1-471e-fa24-08dd02671337
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5278.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 15:39:48.5398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBuppBOMoBAP+p+V3VAoXYeNVr2Hy7U01vKXM+K8W6DtV12/9VxTMtOCOtG71LilPUmCwJjuE5aqEooSKRTGFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6146
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-11_08,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411110128
X-Proofpoint-ORIG-GUID: DiTOGgKd0okYXEpghQJAIDutV7_u0yKz
X-Proofpoint-GUID: DiTOGgKd0okYXEpghQJAIDutV7_u0yKz

On 08/11/2024 18:05, Yonghong Song wrote:
> Song Liu reported that a kernel func (perf_event_read()) cannot be traced
> in certain situations since the func is not in vmlinux bTF. This happens
> in kernels 6.4, 6.9 and 6.11 and the kernel is built with pahole 1.27.
> 
> The perf_event_read() signature in kernel (kernel/events/core.c):
>    static int perf_event_read(struct perf_event *event, bool group)
> 
> Adding '-V' to pahole command line, and the following error msg can be found:
>    skipping addition of 'perf_event_read'(perf_event_read) due to unexpected register used for parameter
> 
> Eventually the error message is attributed to the setting
> (parm->unexpected_reg = 1) in parameter__new() function.
> 
> The following is the dwarf representation for perf_event_read():
>     0x0334c034:   DW_TAG_subprogram
>                 DW_AT_low_pc    (0xffffffff812c6110)
>                 DW_AT_high_pc   (0xffffffff812c640a)
>                 DW_AT_frame_base        (DW_OP_reg7 RSP)
>                 DW_AT_GNU_all_call_sites        (true)
>                 DW_AT_name      ("perf_event_read")
>                 DW_AT_decl_file ("/rw/compile/kernel/events/core.c")
>                 DW_AT_decl_line (4641)
>                 DW_AT_prototyped        (true)
>                 DW_AT_type      (0x03324f6a "int")
>     0x0334c04e:     DW_TAG_formal_parameter
>                   DW_AT_location        (0x007de9fd:
>                      [0xffffffff812c6115, 0xffffffff812c6141): DW_OP_reg5 RDI
>                      [0xffffffff812c6141, 0xffffffff812c6323): DW_OP_reg14 R14
>                      [0xffffffff812c6323, 0xffffffff812c63fe): DW_OP_GNU_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>                      [0xffffffff812c63fe, 0xffffffff812c6405): DW_OP_reg14 R14
>                      [0xffffffff812c6405, 0xffffffff812c640a): DW_OP_GNU_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value)
>                   DW_AT_name    ("event")
>                   DW_AT_decl_file       ("/rw/compile/kernel/events/core.c")
>                   DW_AT_decl_line       (4641)
>                   DW_AT_type    (0x0333aac2 "perf_event *")
>     0x0334c05e:     DW_TAG_formal_parameter
>                   DW_AT_location        (0x007dea82:
>                      [0xffffffff812c6137, 0xffffffff812c63f2): DW_OP_reg12 R12
>                      [0xffffffff812c63f2, 0xffffffff812c63fe): DW_OP_GNU_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
>                      [0xffffffff812c63fe, 0xffffffff812c640a): DW_OP_reg12 R12)
>                   DW_AT_name    ("group")
>                   DW_AT_decl_file       ("/rw/compile/kernel/events/core.c")
>                   DW_AT_decl_line       (4641)
>                   DW_AT_type    (0x03327059 "bool")
> 
> By inspecting the binary, the second argument ("bool group") is used
> in the function. The following are the disasm code:
>     ffffffff812c6110 <perf_event_read>:
>     ffffffff812c6110: 0f 1f 44 00 00        nopl    (%rax,%rax)
>     ffffffff812c6115: 55                    pushq   %rbp
>     ffffffff812c6116: 41 57                 pushq   %r15
>     ffffffff812c6118: 41 56                 pushq   %r14
>     ffffffff812c611a: 41 55                 pushq   %r13
>     ffffffff812c611c: 41 54                 pushq   %r12
>     ffffffff812c611e: 53                    pushq   %rbx
>     ffffffff812c611f: 48 83 ec 18           subq    $24, %rsp
>     ffffffff812c6123: 41 89 f4              movl    %esi, %r12d
>     <=========== NOTE that here '%esi' is used and moved to '%r12d'.
>     ffffffff812c6126: 49 89 fe              movq    %rdi, %r14
>     ffffffff812c6129: 65 48 8b 04 25 28 00 00 00    movq    %gs:40, %rax
>     ffffffff812c6132: 48 89 44 24 10        movq    %rax, 16(%rsp)
>     ffffffff812c6137: 8b af a8 00 00 00     movl    168(%rdi), %ebp
>     ffffffff812c613d: 85 ed                 testl   %ebp, %ebp
>     ffffffff812c613f: 75 3f                 jne     0xffffffff812c6180 <perf_event_read+0x70>
>     ffffffff812c6141: 66 2e 0f 1f 84 00 00 00 00 00 nopw    %cs:(%rax,%rax)
>     ffffffff812c614b: 0f 1f 44 00 00        nopl    (%rax,%rax)
>     ffffffff812c6150: 49 8b 9e 28 02 00 00  movq    552(%r14), %rbx
>     ffffffff812c6157: 48 89 df              movq    %rbx, %rdi
>     ffffffff812c615a: e8 c1 a0 d7 00        callq   0xffffffff82040220 <_raw_spin_lock_irqsave>
>     ffffffff812c615f: 49 89 c7              movq    %rax, %r15
>     ffffffff812c6162: 41 8b ae a8 00 00 00  movl    168(%r14), %ebp
>     ffffffff812c6169: 85 ed                 testl   %ebp, %ebp
>     ffffffff812c616b: 0f 84 9a 00 00 00     je      0xffffffff812c620b <perf_event_read+0xfb>
>     ffffffff812c6171: 48 89 df              movq    %rbx, %rdi
>     ffffffff812c6174: 4c 89 fe              movq    %r15, %rsi
>     <=========== NOTE: %rsi is overwritten
>     ......
>     ffffffff812c63f0: 41 5c                 popq    %r12
>     <============ POP r12
>     ffffffff812c63f2: 41 5d                 popq    %r13
>     ffffffff812c63f4: 41 5e                 popq    %r14
>     ffffffff812c63f6: 41 5f                 popq    %r15
>     ffffffff812c63f8: 5d                    popq    %rbp
>     ffffffff812c63f9: e9 e2 a8 d7 00        jmp     0xffffffff82040ce0 <__x86_return_thunk>
>     ffffffff812c63fe: 31 c0                 xorl    %eax, %eax
>     ffffffff812c6400: e9 be fe ff ff        jmp     0xffffffff812c62c3 <perf_event_read+0x1b3>
> 
> It is not clear why dwarf didn't encode %rsi in locations. But
> DW_OP_GNU_entry_value(DW_OP_reg4 RSI) tells us that RSI is live at
> the entry of perf_event_read(). So this patch tries to search
> DW_OP_GNU_entry_value/DW_OP_entry_value location/expression so if
> the expected parameter register matchs the register in
> DW_OP_GNU_entry_value/DW_OP_entry_value, then the original parameter
> is not optimized.
> 
> For one of internal 6.11 kernel, there are 62498 functions in BTF and
> perf_event_read() is not there. With this patch, there are 61552 functions
> in BTF and perf_event_read() is included.
>

hi Yonghong,

I'm confused by these numbers. I would have thought your changes would
have led to a net increase of functions encoded in vmlinux BTF since we
are now likely catching more cases where registers are expected.  When I
ran your patches against an LLVM-built kernel, that's what I saw; 70
additional functions were recognized as having expected parameters, and
thus were encoded in BTF. In your case it looks like we lost nearly 1000
functions. Any idea what's going on there? If you can share your config,
LLVM version I can dig into this from my side too. Thanks!

Alan

> Reported-by: Song Liu <song@kernel.org>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  dwarf_loader.c | 81 +++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 57 insertions(+), 24 deletions(-)
> 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index e0b8c11..1fe44bc 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -1169,34 +1169,67 @@ static bool check_dwarf_locations(Dwarf_Attribute *attr, struct parameter *parm,
>  		return false;
>  
>  #if _ELFUTILS_PREREQ(0, 157)
> -	/* dwarf_getlocations() handles location lists; here we are
> -	 * only interested in the first expr.
> -	 */
> -	if (dwarf_getlocations(attr, 0, &base, &start, &end,
> -			       &loc.expr, &loc.exprlen) > 0 &&
> -		loc.exprlen != 0) {
> -		expr = loc.expr;
> -
> -		switch (expr->atom) {
> -		case DW_OP_reg0 ... DW_OP_reg31:
> -			/* mark parameters that use an unexpected
> -			 * register to hold a parameter; these will
> -			 * be problematic for users of BTF as they
> -			 * violate expectations about register
> -			 * contents.
> +	bool reg_matched = false, reg_unmatched = false, first_expr_reg = false, ret = false;
> +	ptrdiff_t offset = 0;
> +	int loc_num = -1;
> +
> +	while ((offset = dwarf_getlocations(attr, offset, &base, &start, &end, &loc.expr, &loc.exprlen)) > 0 &&
> +	       loc.exprlen != 0) {
> +		ret = true;
> +		loc_num++;
> +
> +		for (int i = 0; i < loc.exprlen; i++) {
> +			Dwarf_Attribute entry_attr;
> +			Dwarf_Op *entry_ops;
> +			size_t entry_len;
> +
> +			expr = &loc.expr[i];
> +			switch (expr->atom) {
> +			case DW_OP_reg0 ... DW_OP_reg31:
> +				/* first location, first expression */
> +				if (loc_num == 0 && i == 0) {
> +					if (expected_reg >= 0) {
> +						if (expected_reg == expr->atom) {
> +							reg_matched = true;
> +							return true;
> +						} else {
> +							reg_unmatched = true;
> +						}
> +					}
> +					first_expr_reg = true;
> +				}
> +				break;
> +			/* For the following dwarf entry (arch x86_64) in parameter locations:
> +			 *    DW_OP_GNU_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
> +			 * RSI register should be available at the entry of the program.
>  			 */
> -			if (expected_reg >= 0 && expected_reg != expr->atom)
> -				parm->unexpected_reg = 1;
> -			break;
> -		default:
> -			parm->optimized = 1;
> -			break;
> +			case DW_OP_entry_value:
> +			case DW_OP_GNU_entry_value:
> +				if (reg_matched)
> +					break;
> +				if (dwarf_getlocation_attr (attr, expr, &entry_attr) != 0)
> +					break;
> +				if (dwarf_getlocation (&entry_attr, &entry_ops, &entry_len) != 0)
> +					break;
> +				if (entry_len != 1)
> +					break;
> +				if (expected_reg >= 0 && expected_reg == entry_ops->atom) {
> +					reg_matched = true;
> +					return true;
> +				}
> +				break;
> +			default:
> +				break;
> +			}
>  		}
> -
> -		return true;
>  	}
>  
> -	return false;
> +	if (reg_unmatched)
> +		parm->unexpected_reg = 1;
> +	else if (ret && !first_expr_reg)
> +		parm->optimized = 1;
> +
> +	return ret;
>  #else
>  	if (dwarf_getlocation(attr, &loc.expr, &loc.exprlen) == 0 &&
>  		loc.exprlen != 0) {


