Return-Path: <bpf+bounces-43069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7E39AEDC0
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 19:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4718B26FF1
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 17:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7994E1E284B;
	Thu, 24 Oct 2024 17:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jQP7YIZr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MSUtlnui"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA631F9EB1
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 17:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790467; cv=fail; b=bmokOHNTGTnac20s0GMbfqs/nqJfzwcQMqz58f5XZ+qFz+T1BizGBx7DJ4QrcvzKU/lCMWkvy0/8jMuxvjXHGDQfhMHnGYKP/K1AeT65bfWcJcauyW1JqsZLs3fFmd+UpLY7J0jatZ062NTNJIyCf2TjYyEqUOFKvlSuhKnYX+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790467; c=relaxed/simple;
	bh=v7/dz1st1V+7mc4Xr6FGuOL6up9CzgtcvHHioORR6dQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YFl14JiNfxHAx6XSJxU7XOv7PFJ8K1c8leoVyUgiTqO1WPTaResI3YjjIHdnJzvQ0dXbG/j0C23YohlYqb4PmUQ8+v6YX+HmCoK6ftxwSoyt0ZPH3A1Ioe0RGn+TueUJszGT4opcqVylWJI1568Ept/rz+ufytL3mxs7FA9dNcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jQP7YIZr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MSUtlnui; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OGu9CH030717;
	Thu, 24 Oct 2024 17:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=FSIXyRJbhy65IkmqiHPHyB5qaDzKcu8nQ/yRJCI+OVg=; b=
	jQP7YIZrMQCvdnaEeP987Ujp02x3Z9ZK7E2LZhatFOBeo4bwuW8ud8dYgZ9f0Z8r
	h90/kTZnNrLJjhpDpxJs3leiZbbKIcB6mgHxJp+n8CWbRjIatHCgCmcdNqpuiqpZ
	6T3AIHySoJDDMRKP5hYa1ZOu9M6c6TxmuJfz5GvKSVc9D9+v4584EVyTuEv1lYib
	jdOY2/T44vlQ3WdENXwAB5awW2mVGljErL3RKWggbcm3KmlHVlmcsHqhZ38Loj0D
	eMRDDKR4rcasStVBYuUF+MSoWttePa8LeQ55TLzsXyiEPsmNG37BxPqn1wZs7mEf
	wFMLAQK0qqxzXGLvrBtz5Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5ask7cc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 17:21:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49OG0uCX018499;
	Thu, 24 Oct 2024 17:21:01 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhmar35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 17:21:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RqfEXEw1L9bGXx6X8jZ2x5/wZZWLEQdoP06oxQRe+KD5IHvKWZyvSVfNGRH43PZxPWxkJ0aHJ4ld2IWfsLZetQGf6LKNjeB3UMjdWN1nitElbRFn/iJgteAUvX1Vs2ecpLFpV+h98CN0mEjUK6hT9TYkrW7MXnQCL2q6Eb687ZGgDuPVhHrU+LqyzELALBtmG98IGC2d5RU2asPpWSE4qmfqfNhBVeapZFf9kvOk0Sr87WYp8BHpXxwTWK2TWqWC+OVI5c271P7u7mMvz/tL2As1sLIWCcY9l+PltFAxX1lExI7byfRcQ7f160IL5HGVUWJ3V0P9gX52bv8iXJQkTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSIXyRJbhy65IkmqiHPHyB5qaDzKcu8nQ/yRJCI+OVg=;
 b=cblUrkrO9iMLUU4mOUrQ9AdRRrkYoZcGwrH/umn+4/0CwwmeMZksWRMgSi5zbvJCDR09YrrfTLNPBNrpkZfbSfWEmuzU20n1sbGkm/CtRoMbDv5u+lNUrXbaRWC6JhV9/xJ55D4ywCb+m/ttFKJ56XB2lOHmOL0GeblA0v28IkETTNabwvQ9NPTsLR6t2M4tJ2468NgvgOPBAX+gKgtpC9230dz6CD2+fpaBPUo7rKdaeqbpgRhSFV0+6H04OwQJY8+smjbTLgzzdhRTBO6d4SG7aFT2xs/pDva/Oj4hSwC7xpKQ1QOC+vmu4sIeLx5wMKc9AEy8xY4h/p1yzXmyhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSIXyRJbhy65IkmqiHPHyB5qaDzKcu8nQ/yRJCI+OVg=;
 b=MSUtlnui/XZeqeWg000UqGKa1oau2usUILyYsKJpC/pgWPZH3pJ0zLQESzkYPFUkZZLClKKJxQeZF52bU5K8GJoxBJ5KvmReURcIHElsa0iNuCHO+m5sZMi/rpkdyyFi/Awj68vFajvqM3CopbeD91cPdnCf2iRJqWbl0asOf2c=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ2PR10MB7598.namprd10.prod.outlook.com (2603:10b6:a03:540::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 24 Oct
 2024 17:20:59 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 17:20:59 +0000
Message-ID: <16877742-7f15-4fd9-95b4-228538decda0@oracle.com>
Date: Thu, 24 Oct 2024 18:20:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Questions about the state of some BTF features
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>
References: <CAEf4BzYYZa3m5ttEgfPnZUBdYpgoq3JS0GCedXgeoWLgvr9YPQ@mail.gmail.com>
 <b58c8ae4-3a5c-44b3-bc85-2dd7dcea397b@oracle.com>
 <CAEf4Bzbv4SrQd=Yt7Z2PNQLT+1VkLKMaERFwfE8d=8s7QQ-_bQ@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4Bzbv4SrQd=Yt7Z2PNQLT+1VkLKMaERFwfE8d=8s7QQ-_bQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0189.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::14) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SJ2PR10MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: 9be2dd0a-0442-47b1-c786-08dcf4503a45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnBrQW5ZbHBNWUs3eGVpQ1lodlVxT2tjWlllUWxodE1WRUUvSTUwaWhsR1lp?=
 =?utf-8?B?RHEvQ1VRaXhITjQxbXJ1ZnhlekRERTJiakxwZnR0cGhMZXhCVDBaZXdaSzdX?=
 =?utf-8?B?dmk4ZVd6eTNmekZJaHhoVWRwZlp5c3gvS1NhQno4ODdZWmc5UmI5RzVkQXkw?=
 =?utf-8?B?V2p3bENYSlllVjlYWm4zRWNoWnoveXpEYk1NNkpPUlJsYlFrZzgvdWJqeVZu?=
 =?utf-8?B?czF4U1p0SVlVaFJjVFUvVVh4a3VRVEJ5SjViOWx2VUF1YzBDTXJsT3lNVzQ4?=
 =?utf-8?B?SjU3QkdPQmxFZ0NQWUFpWEx5WXFMMWRhZU5NUnZScHp0MVZQbzdoM2l1Skkr?=
 =?utf-8?B?N3Rub3V5L05qK21oNWZoUkRnbzJ3a3JZeXpLNmtQZ0xkb3dUR3JBNWJlNnBi?=
 =?utf-8?B?Z2s4dDg4ditqMmJ1T1cwUG5IRVYydkVTY2dKY2JKSFBra29LcE9YcTFyVGRP?=
 =?utf-8?B?K2F4dXRlUHFnbENjMmFmVmI1K2VQa0d4a2lwSkJOcGZHUjgwM0FEeGN5RGlL?=
 =?utf-8?B?R1ErYXJOeDRNb0JMTWJVWFpuNjgxaWF1dGhaMXI5dDBWQXg3QUkyUks2RXNU?=
 =?utf-8?B?VFJVaWwrTys2R3pLSko0cWZHSGZGMzJNa1I0WlQvc0VaTjNtNlMvWGpKS1M1?=
 =?utf-8?B?TVBmR3I1R1JoZDkvQS95Uk5CNWRuaERubjAwaGJqTkRtU0wxYmIwcmtwQ2l3?=
 =?utf-8?B?QWJIckozaFJIbjdncStaMGJWV0d1aTNTZ1RDUThxZ3NpME1SMXllN0g5SWp1?=
 =?utf-8?B?cThwVFZjdTNCbU1IVlU1VlpaVW1Uell1SFhxTWZGRUc0d0VzSGdtK0ZlMkcr?=
 =?utf-8?B?cHdaMDE1VHYrODNaRGZuUXptMTc1c2d3MHE2OU5oRXpZKzB1dnNuTmh6cmlC?=
 =?utf-8?B?K3hUMlZKWTVCMTlKVzlSREcxMEJyb0NSWnN4Umt6UXlvdG1Vblg3TEJhNEtD?=
 =?utf-8?B?WDNDVEs2U0FIRmFyQXRLQ1lHeXcxWTZVVUJiZFZKeXdibDNBTG42MDJ5elJX?=
 =?utf-8?B?M3pNeG4vYTZHM0N5YVA4eW9NUDBITHRPZVUvcGM5R3pJc0R4MEJwclRYNlhY?=
 =?utf-8?B?SEFKQS9rYXMweUJUaHFveFRydWMwSTlrWStiU3pXaFZTbFIwOUtRbGVGd0lw?=
 =?utf-8?B?LzV6Q1h4RVFTM3hNNDU5VWFFcG5kS1pEUlg4Z2tRbGV0Zk11WktBS2o1MS9J?=
 =?utf-8?B?dWE1MTRFS3hwa0R6YkY1QmU0QXJnNlUyMzVIbFowSFlKaUlvOEdLOE0rc2RZ?=
 =?utf-8?B?T1FLUEp4aC93NVNOa1NxZ3F1VWQyK2s4V0ptWW44TGRiMlBzSTdDTHFPczVP?=
 =?utf-8?B?c085MVMrTS90NnVWQU5uU0ZWRzBscmpSdG5Ba3JWTktSR3RkQklOdFhkRGJz?=
 =?utf-8?B?V3QwLzNTeENOMC8wTllHUldGUDBFUkpIdU5pWlFMNnV6c3NvOTJwNlZsOUMz?=
 =?utf-8?B?Wjd5cDNLelpVVlpTdzJsOUZzdFEyVjBTcGNnVGxLNTB0NHVVSWR2dUVwem1n?=
 =?utf-8?B?VXVQWTVXTEtQdTlhakxPeXN3L2FmaURENXNLN25JMEg2TGM2V0FkWmtyZEZS?=
 =?utf-8?B?UmNuTGUvLzBvSGlJMXNJTFF0cytvWWZzVWFJdWdGVFNlTnh5V09SQmROb0c2?=
 =?utf-8?B?RE1MbnhkQWV5WjM2TVdDbnUzWlNtVlB4NkVGeW52bEozbHR5T2gzTi9DcHcx?=
 =?utf-8?B?bTEyN0FJYTJtY2RuWTNvT1JRU3pWUm9UUVc5c2hPcDhaWVc2MFJGbkQ2VDlw?=
 =?utf-8?Q?bdvsrYuBHzg2QtpZHW4iJYa5eHR0YTp9vt3uur6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0VzU2pzUHBKRXl6Rm0vdlJnMWp0RWZaUG15S2Rtd0o2QjFaV3loZHYzS3o1?=
 =?utf-8?B?NnlIYjdlUnMyU3RYcC83ZlF1ZnZHWEJuUUtHdnZ3WEVMa0NZb0hIeWVDeDdM?=
 =?utf-8?B?cnlUMzZYSXJ6c3ZPbWJDRjlvd08vTFVzcFlxa1poQW1rQlN6cXVWZForWERN?=
 =?utf-8?B?VXFxZ1gzclRqTjhrQ2l0ZGxmc1M5VG4xUktHRWpNcm5IbFcyR0k3WW1NT0xi?=
 =?utf-8?B?bFM1RTZNNG85SVBCdnhiVW43V2MyL2lIUXcva3ppR0QrYnUzdE1OdmZqZTlY?=
 =?utf-8?B?aGFET1pIUDBhWHNKRFk3WVpBbVhWaEtpRHdFdFZIRkM2QnNOZTdLWnpURXdq?=
 =?utf-8?B?MDB0WXRVaVB2Mlh4MTFLb2drVHFMaGtZTENYWEZsUDRTSXFCRk9uTlh6M3lI?=
 =?utf-8?B?dWtLNXowa1ZKOTZYTWV2a3VEcmdSWEJzYTJ5THFsTmV4ZjdXU1VIdWJBRmdl?=
 =?utf-8?B?bE9LRVBGb0NoaVJ2Zi95VklXRTNwaUZjUUc3R20reHE1WFA5Q1NnYjh6OUw1?=
 =?utf-8?B?OGdSUWZOY0paMTVCM1lFNXJzbS9PQld5VVhBU3VZbVpkazZLYnNQczRDZmNp?=
 =?utf-8?B?ditjN2hjd1c0cXVyV2Jjb0tzSmpDMDVhRmd2NFp1OUFhM2pEK2Vvb0ZDVUlt?=
 =?utf-8?B?c3FsdG5tRUxsZ3dwbmpDL3Q1NW5ZcFY2WXo4Qk5zVGtFQTBoZHZjZDQxMUpO?=
 =?utf-8?B?azhWMS9LNXBSNUI1T1BvUzJtV21FZlZsV3VTQUZBak5qS285cjdqdnViMkRM?=
 =?utf-8?B?RCtaTFBrd0VvQUx2TzVVZU1FRXd6WTR0aXJpNUNCc1ZSSkRmYTZpV0oyUHVM?=
 =?utf-8?B?Nmg0ZEwvaXhEQlpOVXo2clZubm1ETVloYmxSNGNwZmJSVlhXV01ZelprdjN1?=
 =?utf-8?B?dHJMVGlMVW5jRkdDZStHVEk1bmJJZDhLSzRWUFh1ZVA4VU03TWVTb0V3MlVZ?=
 =?utf-8?B?Qk9YQVkzTXJkUFNNZmxkRklkNE10Ny9BVTlxdkdYa0N2V1hSeTIwQVRoSlZz?=
 =?utf-8?B?cldUVlozakJLTHRWYlc0SkhCaHVtZmdHVVhDbGZHM1lWSEVoc0ZWbTFLcmk3?=
 =?utf-8?B?YnFhODhHY2luTkZ6VnBJTUNveFhKTWw2cnFNb2xoemxhQmUyQzV1TytBVytx?=
 =?utf-8?B?YUpTWjJKSjlJNkZ5UVkvMnRkdWZxNjQ2a0tINFhkMGcvN2REeWNENzQxOXZV?=
 =?utf-8?B?TWNzMGRyemUyaW1vaG9GbE05eE9nLzVOWjRLS2llOGNIZUNVWERSd214V0xQ?=
 =?utf-8?B?SVRscE9RTHZpaUZydVg3aDBFQVZhN29IbzhsemM1WVVPajZjaVN5TkVPYi9F?=
 =?utf-8?B?Rk8zTmh1MTNxUWxieXc5U1V1cFdPUWZ3b3dMZlI3azNacTdYVTUzRE1VY1NQ?=
 =?utf-8?B?L09QaG8vc25KVW5jNkxhR2FKblRHR1g3RG55NVFBQXlNa2lPS3dwNFRCZENJ?=
 =?utf-8?B?SHVIRm5rR1JzV2QwanN2SVFQeGJiM0Uvb0FZNnJFbEduS0d1ays0N0pWbE9D?=
 =?utf-8?B?L0UyMCtqR0tGTHdRL2FDQTJnNlRHMXdWVUlqVnBCU0V5NkNZckRKUHpNTWZU?=
 =?utf-8?B?MjVzeDd5UTk5b0xCc2g4dk9yYzlPWU9VSWM3NWRndTJZaVFyUGhhN2s5a3Ix?=
 =?utf-8?B?WXhudUpVOTI5NEFRVDgrWmJrQlV1Y3VtM2MxQytRYUpwcFNjUHpzYnZkSkQx?=
 =?utf-8?B?cUFEV2RzZDIwMEZSUndISUVBZWYyRFZUTmdkaFQzUlpGUERjR2xvd3RwRU5s?=
 =?utf-8?B?TXdVVU9IUm40VExxR09sUFdHY3NoUm1xeHRPTXNBTGx6RjBtdVEyNHNsVDFu?=
 =?utf-8?B?Z05VanFKVVlnMzNqNXV1cEdVRVB3a1BNbjVVeWNvdWFpeHJpT3AyNlBmN3BF?=
 =?utf-8?B?NGRzbStzV2wxbGlmWm5VMlRLNStvMXlXSWEzVTNHd3YvcHl1OEVHMFJJcm93?=
 =?utf-8?B?cmVNbGpDZDdzcmZCVnE5SGh4TnRMVUc3akJHbTZFcE5HZHFzemZYZU13R29o?=
 =?utf-8?B?WnlSVllPTzYxN2VjVUtMRFR6ZUk2ZUZjdkliQTlVTlluL0E4Z1lmcGc4bTY1?=
 =?utf-8?B?eWszRC9mZFdoTTFSYXlBcVBaNnFUbXJSWEJRcjZIMlZrbnlsaWoyN2lkTisw?=
 =?utf-8?B?azlhNGExQWRsOHRLK3RrbWNoU01oSG1rYlZieHlFUmk2SmZGNU12K28vU0ll?=
 =?utf-8?Q?izZ4Doeo9itU4LDkGcJ5Et8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yTOv6ibyWGNzORrkdA9nqGpcoa4kgFFQOAUCmj2+JvxsvLPhalBCFrPpJACAvElcYUGy/+1mBy9ukg3Akqhn8BZsK5PXvBFfwdgbo/cjgbjBTPiUplIQ5wejzO/SKZUssI3/P05BJ9djOOYg7goY3vvXyuS0Yfq/f60zYPUWxeXWqtJIHsXhxTleUWziPBYxI0t8sF3a5Fia2bkSBoqlrgeC6rQK67J8or+yypY+h5j9OPnSf99gVebVaCYlU97rfrbEqT23JCPJxZQqMKJx19vGplr6zN+QzMS+o6plnaVF4hqEvESTlMb8jBNc+XK7fctDwtuMnFsea1kJmWYm4v3fIi7O2QkWMFYbG2pYeuQOqyJsHvINSZbSrItK2InTn2SFCL35nvr5CYyRxxqeKcok772G9YEro2zGTbKYp0l8YYqzr4Xfdqf7qfbbllwts0LZPTY1O3F4IyXSRHuPzPSol6LZKyrkxoMcFS9QL220AdZ5H3COTCiFg76IZdd78CSGm2gmyrypTGiVwT+HbjMOIt0cl71VLnu+IIVqdNgHnMBuvYx7eMZCG6DEHtvksGZnnDsdZPfFbXoyDGl8alS/IBjuqqbw0ILfj3c8xsw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be2dd0a-0442-47b1-c786-08dcf4503a45
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 17:20:59.3902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gpoUgu1CSHM2vggw5weQtYk5NdUvUWTnJhgUWWmtCSZk4mYc74zZgcNOF+oG0pwnX11iaQ4gfCaxr8DaXHQvtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-24_16,2024-10-24_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410240143
X-Proofpoint-GUID: Bg_K-7s1eaq8GB2-TNS5ryV799sJmUVg
X-Proofpoint-ORIG-GUID: Bg_K-7s1eaq8GB2-TNS5ryV799sJmUVg

On 24/10/2024 17:53, Andrii Nakryiko wrote:
> On Thu, Oct 24, 2024 at 7:10 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> hey Andrii
>>
>> On 23/10/2024 01:08, Andrii Nakryiko wrote:
>>> Hey Alan,
>>>
>>> There were a few BTF-related features you've been working on, and I
>>> realized recently that I don't remember exactly where we ended up with
>>> them and whether there is anything blocking those features. So instead
>>> of going on a mailing list archeology trip, I decided to lazily ask
>>> you directly :)
>>>
>>> Basically, at some point we were discussing and reviewing BTF
>>> extensions to have a minimal description of BTF types sizes (fixed and
>>> per-item length). What happened to it? Did we decide it's not
>>> necessary, or is it still in the works?
>>
>> Yeah, it's still in the works; more on that below..
>>
>>>
>>> Also, distilled BTF stuff. We landed libbpf-side API (and I believe
>>> the kernel-side changes went in as well, right?), but I don't think we
>>> enabled this functionality for kernel builds, is that right? What's
>>> missing to have relocatable BTF inside kernel modules? Pahole changes?
>>> Has that landed?
>>>
>>
>> The pahole changes are in, and will be available in the imminent v1.28
>> release. Distilled BTF will however only be generated for out-of-tree
>> module builds, since it's not needed for kernels where vmlinux + module
>> are built at the same time.
> 
> It's not, strictly speaking, needed, but it might be a good thing to
> do this anyways to avoid unnecessary rebuilding of kernel modules
> (always a good thing).
> 
> But at the very least we should enable it for bpf_testmod* in BPF
> selftests. Can we start with that?
>

The good news is that already happens, provided you have the updated
pahole to handle distilled base generation. After building selftests I see

$ objdump -h bpf_testmod.ko |grep BTF
  7 .BTF_ids      000001c8  0000000000000000  0000000000000000  00002c50
 2**0
 50 .BTF          000036f4  0000000000000000  0000000000000000  0006e048
 2**0
 51 .BTF.base     000004cc  0000000000000000  0000000000000000  0007173c
 2**0

Given that these changes are in the master branch of dwarves, I _think_
we should be testing with this in CI already, or will be imminently at
least. I'll do some retesting at my end to ensure no regressions are
observed in test results when using distilled base BTF.

One thing I neglected to do was to send a patch that describe .BTF.base
in Documentation/bpf/btf.rst ; we discuss .BTF_ids there so I think it'd
be good to mention .BTF.base there too?

>>
>> Here's the set of BTF things I think we've discussed and folks have
>> talked about wanting. I've tried to order them based upon dependencies,
>> but in most cases a different ordering is possible.
>>
>> 1. Build vmlinux BTF as a module (support CONFIG_DEBUG_INFO_BTF=m). This
>> one helps the embedded folks as modules can be on a separate partition,
>> and a very large vmlinux is a problem in that environment apparently.
>> Plus we can do module compression, and I did some measurements and
>> vmlinux BTF shrinks from ~7Mb to ~1.5Mb when gzip-compressed. This is
>> sort of a dependency for
>>
>> 2. all global variables in BTF. Stephen Brennan added support to pahole,
>> but we haven't switched the feature on yet in Makefile.btf. Needs more
>> testing and for some folks the growth in vmlinux BTF (~1.5Mb) may be an
>> issue, hence a soft dependency on 1.
>>
>> 3. BTF header modifications to support kind layout. I've been waiting
>> for the need for a new BTF kind to add this, but that's not strictly
>> needed. But that brings us on to
>>
>> 4. Augmenting BTF representations to support site-specific info
>> (including function addresses). We talked about this a bit with Yonghong
>> at plumbers. Will probably require new kind(s) so 3 should likely be
>> done first. May also need some special handling so as not to expose
>> function addresses to unprivileged users.
>>
>> So I think 1 is possibly needed before 2, and I'm working on an RFC for
>> 1 which I hope to get sent out next week (been a bit delayed working on
>> the pahole release). 3 would need to be done before 4, or ideally any
>> other series that introduced new BTF kinds.
>>
>> So that's the set of things I'm aware of - there may be other needs of
>> course - but the order 1-4 was roughly how I was thinking we could
>> attack it. 1 and 2 don't require core BTF changes, so are less
>> disruptive. We'd got pretty far down the road with an earlier version of
>> 3, so if anyone needed it sooner than I get to it, I'd be happy to help
>> of course.
> 
> Thanks, Alan, for the list.
> 
> I think we should prioritize 3 (and 1, of course), as you said, any
> BTF extension would be blocked on this (as far as I'm concerned at
> least). I wouldn't delay until we actually add a new BTF kind to land
> BTF header modifications, that would just delay future work
> unnecessarily.
>

Sounds good! I'll prioritize 3; it was pretty close last time we
discussed it I think.

Alan

