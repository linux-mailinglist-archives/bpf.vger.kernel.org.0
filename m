Return-Path: <bpf+bounces-49043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B32A13702
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 10:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66D993A58A8
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 09:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02B61DC98C;
	Thu, 16 Jan 2025 09:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xj37RMuY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="N4WpClJo"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C161D5AC0;
	Thu, 16 Jan 2025 09:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737021117; cv=fail; b=ZqGoxPNTJqTjU2eb8gHgHc6v4S0R1resap3SKTviTAlxfIASphrdAYf+EtvAA9/U/AsQDck3FMA/hBnEGv61mYtklEIbvOAIBCSCZoGqoJmm5IRdWvypzQDkz+arBacBKsMATlukBhdAelI1PCz+zuIT29EqZEfjX7G60UWKSs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737021117; c=relaxed/simple;
	bh=nfjhittwzoaZKyRy/CiQFliuhy6TR6rBLCLPl+HK118=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uuIsggl4DOuzNYBAHzvM7sO37l+uY4lBp3+8nDkc7thExs0xZvvwJroDDBeyqVnYhX6rGPnuaEZcyeBUF8CIG533rNJZdmOZZ01jJnDEUANyZtVXIWcwXNusy9Qn6ba8tk3Tflr9Gki3tl6lrHK80uEuhMM7O7pdWYw9yYybqe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xj37RMuY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=N4WpClJo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50G9MsDP028783;
	Thu, 16 Jan 2025 09:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=jChGIGNdM+Rb8nAOPxTHAW3A/5OFyZLZnnsnJa4jqqY=; b=
	Xj37RMuYQJADYcRNHZ1Onv3+9QaBS2MPfugnoRzNofhXNGB2Oaeq8qYhrkpY3VN3
	NKeClxiY50SXl9VrIxNvzlTMDpX8dWJEWldnFLdJZSLh7IffAR8xfN95M51DfFNN
	PzJ5ECf+wJcH/RTCT6u+Z0P8sJS35IfsCsPUQUbUfTCTgjb8NugcfayGbtLshirL
	5IamJpmBRwvJCVAP+t9cYDFOti7kGiiog5ZU9EjGexnvjzVhvxwQh8mFrBgCZKJo
	Ui2haudnengs7P3HN73peoPNdB0RjPwh7nRlrxPjriyzQYBaONjra0cVVP9AHsLF
	TnXeetP1kIN9oN+9TTevNg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443gpct4qu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 09:51:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50G9FFkj020351;
	Thu, 16 Jan 2025 09:51:52 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 443f3gxevs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 09:51:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iFvMboXjaIrnugEQz9Xyd36Ry2EGu8Hx9igEFNwc1K2cDFxB6SChAaznQwsABG6FqxgNpLW3qLvI2UcUEmuiubMxHzm3VnouQ1qhBLe2FU04DYmbzQwR+P8BdADuusNBc6AiL0plln4wRQlIAEeE3kZlK+BKIMW4TnNjcwddM8jA1RlzGDHNtheOXwAv6rGPy4o3MmqYxjGUF/SlX287Q+8S1ptOZ73bm6EOxryOMGBc7GKOtKK5Hd8StuBTJLWO4ZKTGpLCrzGnJ+1get43wC1XtsqQTzFRbPNr5zZiMLsNePGE3XEa2UOOT/OS04LZG9Ylv4XjO3W6RxXbpFM5Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jChGIGNdM+Rb8nAOPxTHAW3A/5OFyZLZnnsnJa4jqqY=;
 b=bsAbhhsdFqkMHabGjqFa2zyxrqJZRBDAP7Fk1+27Jz3hZkd6Ag+IAmCU2m/1wK5SRo0XPMUPtwDm9GSkiwm+gC5OsgnbYmFBdD1b0VP8nhnrowPu6srNysu9/pYZcU8cEw1RoDZJPl1Hh0igOxOAinUbE4jeiLlCwrP3ZoflGPhhSIgJvmpKrS5RFPFIJSh/KKeDhS6mJuJM1YVtC6BuiNDMPzKRET9/Mb5OjZWr1grLAkdkPRioDyCZjz+YGYRsK+dSPHP0zAm5y2jVk/k3Qwkqrsj9Iy1xQsoXmo+SWkHNDunJ4RbP7kfsHnRTx9C0/fe7NN868mz8BvJUpVzVvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jChGIGNdM+Rb8nAOPxTHAW3A/5OFyZLZnnsnJa4jqqY=;
 b=N4WpClJoELOJApATf6pEDeNzf4ozUNF2cGni6cTkPU1c8QTDazdMsbmq11RO3H5C5MaJroPTLQ9QX0caZcMZOvopbGozOA7tWWsJjsuUC9K7k+Kx+XOfwyV4wX/Dm0vfeJqFl3yPf+TvA0bp1berZHXnHk7llE6kXzjl55laJek=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by LV3PR10MB7818.namprd10.prod.outlook.com (2603:10b6:408:1bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 09:51:49 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 09:51:49 +0000
Message-ID: <00b4f995-7105-499e-93b0-5e32d54948aa@oracle.com>
Date: Thu, 16 Jan 2025 09:51:44 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] module BTF validation failure (Error -22) on next
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Uros Bizjak <ubizjak@gmail.com>, Laura Nao <laura.nao@collabora.com>,
        bpf@vger.kernel.org, chrome-platform@lists.linux.dev,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>
References: <20241115171712.427535-1-laura.nao@collabora.com>
 <20241204155305.444280-1-laura.nao@collabora.com>
 <CAFULd4a+GjfN5EgPM-utJNfwo5vQ9Sq+uqXJ62eP9ed7bBJ50w@mail.gmail.com>
 <Z10MkXtzyY9RDqSp@pop-os.localdomain>
 <3be0346a-8bc9-4be1-8418-b26c7aa4a862@oracle.com>
 <c067bc3d-62d6-4677-9daf-17c57f007e67@oracle.com>
 <Z4fyijoUoeTnOuDM@pop-os.localdomain>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <Z4fyijoUoeTnOuDM@pop-os.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0058.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::9) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|LV3PR10MB7818:EE_
X-MS-Office365-Filtering-Correlation-Id: 9951061e-7c28-45e6-cc34-08dd36136594
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VlAyaFp3MUs4L3NsNGpWRDhyUE00dE44WmtYVkI3UmtOa29DMHJ0YWtoTlRG?=
 =?utf-8?B?NllIT09MSTRaL1AvUlo0QnJTbCtEVUVQWCtGN2ErUFZZVVQ3V2NVNUw4TmVy?=
 =?utf-8?B?UFF4eVRqbEcxc3pzVU1XM1RaUHZQODlEdHE2Z214MGFqMlR0VU1QODRzc2hL?=
 =?utf-8?B?NG9qOXpjNzlTYnVuMFBnd0pVamd4bVNHenN6UDVNKzVxS3EvbXRpSy9wWm52?=
 =?utf-8?B?Nk14Z3JxRHJSWXd2cDZuci9uYkhiZGR0QWF2UHZlaXRzSmh4anQ1aTZjOHRF?=
 =?utf-8?B?c3FaN0NrV3RNcnNwTW9QUmFDL1lscW5KVmV5cHpuVGREcFd4WWhRNTN3TWhQ?=
 =?utf-8?B?MW1qL1ROem9LMitSSnB5ODM3cTM2WTdKWnllZ0FDUlNzMlIxekVZS0o2MlB5?=
 =?utf-8?B?N1dhSG9DYmFUT1FPN1FFb0wxcjUwdm9ISXRkUGpIYlpFYk9EalJSSHpUZG1W?=
 =?utf-8?B?MVhRSlhMRSs0a1Nrbmg0NzQ1QjRZN2MrTWJ3ZEZIVStxVUJGWi80RWRnQzVa?=
 =?utf-8?B?S2RrWWxVSzBTSTQ3SjEvbEhwRmttOC9ZTFdvM2NqZktTcmFqc0IrREpmQzFE?=
 =?utf-8?B?YXJiRS9iTFUyK2EwYStPcjdVSDI5L2x6OXc2UkFHTVR2NDVjb2lvUzlFZko1?=
 =?utf-8?B?cmZXYjVhRC9COTJLVkhXSjlzeFA5SWNrS2ZBTDhmbURZaUkwSDJTRGo2MFQ0?=
 =?utf-8?B?SjlUQ0x4d2hRVXl1UHp1UmZtY0pONXRWd1dTTzRvVU82WVpWeTZnNkp0V05y?=
 =?utf-8?B?QzFnUTlFU1BxSHVFL25LZjB4MXQ3Ui9oOE8yb1MvS2gzWnNzQzhiWVg1VUQ1?=
 =?utf-8?B?SEdvSUZSUkdwVnV5cWR5SGJLODZOMzd3ZUdUanIyZHhCZ2YrWkRQQVNNdnZN?=
 =?utf-8?B?ZVVRcnFHWkZnaHgxU2tocnpYN0hKd2c4am90ME1RZkxyQVQ0UWw3T3hFQ3BQ?=
 =?utf-8?B?MlNUVlBNenVWdkk1TjcybUhKWW9CUmVQZTVNd3VYQ3pObnZ5ZXE1NHpUN3Uz?=
 =?utf-8?B?SmFocUN1WS9zUlZWK1Jab2FISUhDdWkzUWVSNXJIc1d1YVZSeWJtT1FIdEVV?=
 =?utf-8?B?REdhdUxTb0EvSXR4Yzlxa1ViUHRvOFVCb2UrVVUzd0lBYU83a1c2ei91aGFM?=
 =?utf-8?B?Mkg3Y2JaM2VzK21scHErWWFQY3FoVWxWS096ckZTZm9XWFJhUkMySnNkVHZR?=
 =?utf-8?B?NVlMcDZuNkhFcVF1UEZhWDVLU3V1aXNCdi9QTkg0UXVoYkZpYTNiQTVKYWh2?=
 =?utf-8?B?U2h0VVowM1QzYUxlT0V3MG1aYTdOR0hzaldFVUt4TGdLTFNtTEtNUmluUnFU?=
 =?utf-8?B?b2V3SVpibnovdjBMTzRxL1Rva25YYVJGSlgwMVUvajd2OXlHeTJmU2Rsc3Ry?=
 =?utf-8?B?ZnRFcFQ4NmlzVWNxWEdlQk1jSmhhRGpybDRyRlZLMFptMGNyaXZ6MnJHeW1D?=
 =?utf-8?B?Smt3cUNrM1Uxci9tTk1jeklxV2VIRW9BMEpLOVNTUisxdWdXbWxOKzlibTc3?=
 =?utf-8?B?TEx3dUJqR0MydE1iS3V2Ulk4ZXA3alk1dkdZM1B5OVpMQS83SDVLQWZJbVFF?=
 =?utf-8?B?RUdQS3BkejBKeW1Cc2EyMjRwL3dTdk80eW5PVVhLT2lmeWhQTlYrV0pDdlRO?=
 =?utf-8?B?RWNQbVdYSmxxRXFST1hPZnArQnlEUTZuOFNNMFc4WXFZTStsM2VUeGgwUjQ1?=
 =?utf-8?B?NCs5QWg5NjFDODY0aHJxVVdDeWJlaDd3VHd2Y3ZjVk9iTWYrUnNSTHNZVWxP?=
 =?utf-8?B?SUdkTlkvdGhMU3RVdFFBOG8xMDlPbkRKOGxMSTN1TVlrditOdi9nR3VhVzBK?=
 =?utf-8?B?c2h5Zlh4QlduSlVuZUhNTTNaMUZrdWhHM0dKeHovNjRITWpRWHBCWWhMd3NI?=
 =?utf-8?Q?sWYnjEDI9o3uQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2xrZ1Nrb1QzOUUyNXZHZ3dsT21UWEFPdlN2emN5Mnl3TGZCbGtJWHR0U2Vm?=
 =?utf-8?B?RUlYWG1vK3pEdVVzcFhiTC9aMitEV3hzSzV0eHJ6WjM0b29PZUFiR0w4c0Ni?=
 =?utf-8?B?bmVBelBNczViaHl3NWZYbUVjT1Jkb2dWU2xtM2hWQysrT1phcFhzVG1IbFV6?=
 =?utf-8?B?Si9YcUZUWmpNUDAwTnZpcmxINnQ3N3RWcWt0MXgxYnlqUElaVWw5ZFJIcWtq?=
 =?utf-8?B?ejY4YnZjb1NQT3J0UWdvVDljTUdublUrSW9od2hSY0hpdWZOVVN5YUJkUHNE?=
 =?utf-8?B?QVA5djJkOFhQVjI5ckRxTGtKK0pWSFQyR2wyTDBNbUpvMDhOSDhOR1dsemh1?=
 =?utf-8?B?ODFTUTNkQ3J5S3hvSzFqRy80c2hxaDBDeTF5TTNhNUNlY0J1N2hxcGxGcVdu?=
 =?utf-8?B?djJiR3RBLzNkN2x2TnRXNVo5aGNLaWNmbXVkNHZVajhHbWRDZExQWWJBNWJj?=
 =?utf-8?B?cERHSEhiRm10b3RZY2t0ZE91TnFJdHR1a0xpRnZGUzRwNGt1aDhnZ0lCQ1Ez?=
 =?utf-8?B?bWVaWU5XdDRLbFVOMzlBcDcvU29RcGZMWS9XZlJSRFlYendxdVQzOW9raWdm?=
 =?utf-8?B?dlQ3dzF0ZGF0eXJhSUJ3dklqTGlwVmJ1Y2YxY2x0QnRxS1NOQXErZk5adlhD?=
 =?utf-8?B?ZHVZb01iUEhJQSswa0xtaUNqaG5vK05zRmtWMHpQU3p6eVdpR1VTa2psMWRI?=
 =?utf-8?B?d1dlaFBTdEFaQ1ZqZXhqZnhKdlZ0Z2tncEtIY1hBNlhSYWJmWDM5aXFDSi92?=
 =?utf-8?B?NkdzaUpOSWg4cFI2L1dEMGZRTFBOaWdiNWt1ckNyTjlYQWQrZmRwNjM0NG1X?=
 =?utf-8?B?aUw4UXVRdnVxRlhkTkYxUmc3OGt2Y3ByK0lzMm56Zkkwd0EzQXlRamxvdzUw?=
 =?utf-8?B?Zk5EVGtYNXJRQXo5TnF1Smt5VVZid3p3YmRlcFIwK1diL2QybzlHRWNyb0RK?=
 =?utf-8?B?YzZVUTBZN2YyVXVCUk1uWi9uSWhWNXQwMjJPR3JvUS9EdGZGbXhZZ0VtbTgr?=
 =?utf-8?B?THZjWVRLMU5JbzNnS3VoTHFwUTV5MXVZS2tJL2JNQ3dKRW1DUHh5NS84RkE5?=
 =?utf-8?B?cEwweUN5RmQ1VFcyMVpWZ2hGSjNBZUNkWmcvVGt1QlJWQU9IZWxIZ0xrZzhO?=
 =?utf-8?B?ZVIzZmxBV2RhOC9Gc3IyY1JCT1pWNWZXd0VLVWM1VUZHTnZTZUhTOHhFenBj?=
 =?utf-8?B?Z1hlWjhMajk5VjF1U2lCOTlnQ1VzZm9ybTNZcUwva09Odkg0d1NHaE5pRitU?=
 =?utf-8?B?bk85eGNjS0pKK2wrb05ldVRYNDJOL3g0SHJrWUZhTHFjcUlvbkxxV0VQOW9G?=
 =?utf-8?B?V1JpNG5WRFVyRGluUW5tOWIwMlUxN09hekNHMEIxV2p3SkRQTElkbnZzMVBB?=
 =?utf-8?B?UnBnaDZKL3BKZzFNNU91UDQxb24wZURRVkJyWUhGTUdObEtxbDR5bjVwL3Ez?=
 =?utf-8?B?UkJEQVhzYW1xTWMvT1g1M1pUdU9jbmVkdHYxcW8yM2hIdzBMK214Q1RjNGV5?=
 =?utf-8?B?eG5DQXNwdGM1Q29jNVgzeTdROVowcUVYTVRySFd5QWFjTmZRRVBwc1NpRHdV?=
 =?utf-8?B?MDFJNUdrWmVudFZuTzZHeng5dDFqU3N3L2ZreUdOOWNFbWlKUllFTncxUHE5?=
 =?utf-8?B?ckpwb2dUWUszVW1tWERwUVBxNnZINnF5MC8vcW9taUt6ZjJxakxoYXltSS9N?=
 =?utf-8?B?MjZ0bk1BUERtNjUweEc2anIzVFlJcEZhSDI3S0hiMDN6VHN1cTBpMnYycjBw?=
 =?utf-8?B?QldXbDdveFhUWi8wWlg4SEVqZzlxZHo2QTV2dzR5UWpOVTF5cmZDYTdyemhJ?=
 =?utf-8?B?d3FYbFpydmxCU2Z4MW45M1p6WDVQV00xcUpCRlNRNTZJd1V5TzhmNnlvK0Ir?=
 =?utf-8?B?eWE1c2VjN3pOaXc3akM0VFgzWGxOb2lOSXc5NXBOdTRVZktJa0VaL3ltNjlh?=
 =?utf-8?B?Y3hjb0w3SXZ6dG9XM2RaaW5OU3FCcjkvVSthZkRsRFQxNXBWNGo0cTRZYmlL?=
 =?utf-8?B?RFZma2dKOE01dGNGdTRsU1ZIQUs0YmVRRTFEWFkwNTR2ZzdVMzRvWGJGdVh0?=
 =?utf-8?B?YXFDWlAvY21uNzJrUXBFeldGcTNOekJwS3ExNTdWbk5lK0QzdHZ0RUQwQ0VI?=
 =?utf-8?B?dzNwcTBkZkg4SW9ERUFLY1MyMGJ1NEJYZHd3NmRkRlFveGNrbEFNTCtiUjZl?=
 =?utf-8?Q?cuiijrDKbvb6hz8vP3fNw0o=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CCpYybT9r32NZLVb0nQr+KtsVTi+BOK1qOSVn/ce4ONRSrqNbEv5tvmI+qFxHdTK06mhFE82vWGsLcF7j4iA6Z9oxAfAeYS30YMLIsdr0CB58iAuOvocYujaV8jbMa4CSHpmu2/PEuXiwZbf3VLT6Y5Dv7yzCoph239YlxBbu5Kh3GHgS5truIz3Y8Hs938eOfC3cy2NQBPwJix8URR+QaWj0BTUqMrS904cHFl9GNv9zSmnkwam1ETmB2n02ngguZXN/40nGmeCnYgyKClb+idxj1C+o20wGlG9QJW19Br+9Q9L4ou4qfI4KJS/ka2l+hbDP2KD7CCdoEtaiCua8d0/gVKJ0aB7t4xSEh1pur1J3gQtisoDPPBA3QSft5KQSC1nNuAsUqjOR9pMq6fv6d9ZMJZH5/vOt650467zje1V7/7c7sQAHJFbDkozpwgXSe2VfhR0ehCIWsF6rPCfmOYRg1npFA6+32GLVZUja5ib6pSvbGXxe1/AvFq98m7upvNTyLICg0b3+456F6JnyaCCWqTP+kVcVst4GNDPpvv1QDC2HIoEi84qoHWJcQlzkrB+NkEE/ioOnZ6sHKkOLN7no8YgGG2nwp0pZ13c6Xo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9951061e-7c28-45e6-cc34-08dd36136594
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 09:51:49.4964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /XBVGTkQsKMbwldwcTNPYVhSCGkUNqeMwMxdTpdXq8ITdengPaYlYPBvLu6yFtF4GEHCzRazZXGEoM0RdgFJuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7818
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_04,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501160072
X-Proofpoint-GUID: gjrKXy58F-eCBdzKfsuFJfNFnWDcQEsU
X-Proofpoint-ORIG-GUID: gjrKXy58F-eCBdzKfsuFJfNFnWDcQEsU

On 15/01/2025 17:38, Cong Wang wrote:
> On Mon, Dec 16, 2024 at 03:19:01PM +0000, Alan Maguire wrote:
>> Seems like there's a few approaches we can take in fixing this:
>>
>> 1. designate "__pcpu_" prefix as a variable prefix to filter out. This
>> resolves the immediate problem but is too narrowly focused IMO and we
>> may end up playing whack-a-mole with other dummy variable prefixes.
>> 2. resurrect ELF section variable information fully; i.e. record a list
>> of variables per ELF section (or at least per ELF section we care
>> about). If variable is not on the list for the ELF section, do not
>> encode it.
>> 3. midway between the two; for the 0 address case specifically, verify
>> that the variable name really _is_ in the associated ELF section. No
>> need to create a local ELF table variable representation, we could just
>> walk the table in the case of the 0 addresses.
>>
>> Diff for approach 3 is as follows
> 
> Hi Alan,
> 
> Thanks for your detailed analysis.
> 
> Is your patch formally submitted and merged? A quick code search with
> variable_in_sec() tells me no, but I could very easily miss things here,
> hence I am asking you. :)

hi Cong, I submitted the patch here:

https://lore.kernel.org/dwarves/20241217103629.2383809-1-alan.maguire@oracle.com/

..but it looks like it hasn't landed officially yet, apologies about
that. Would you mind testing the master branch of dwarves with the patch
applied to confirm the problem is fixed? It worked at my end but would
be great to confirm it fixes the issue on your side too. Thanks!

Alan

