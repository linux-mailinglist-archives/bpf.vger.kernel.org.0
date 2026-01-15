Return-Path: <bpf+bounces-79136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C806D27F50
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 20:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82183300BA2D
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 19:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214C72E7623;
	Thu, 15 Jan 2026 19:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UuDmp8Sp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Q1CCVue0"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247763A0B23
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 19:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768504318; cv=fail; b=YHvn//XH6DgZMmAksb2d40P4xEpj5l+Ij17wAFuvLor5u+YZQ2+kB+wBsNu+OS9mh/x8LxRogovPtz95ydYuoD9BTkLVyuIIhiV1XnIb85Wo0d5wJCYUVfdW87ZC/eyi8g/OKYiNO+ZmshRXM1QOTLfvmXKrjItw5+t0oEaGKPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768504318; c=relaxed/simple;
	bh=vjmQRj3TJ0b1/EcL6kUlDO2l2xjEHKxXglWvB5FBByw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EwdxIPk+w+ETpiuxRrxsPAGkKjRm5kJeuq2gcTEyLM+5Q2OErCev2ImypOobuOOJ1PjgEPEYJoZvAlbAYoDpugtRrCugAT9MlGAsa2IKBiqjEzwwpjKjbIqvEg0H3wYx3gq3ZdyqSdnLGUrVLm8wv6qefCMfSG0jcO+pAwBgxyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UuDmp8Sp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Q1CCVue0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FEtB4T802772;
	Thu, 15 Jan 2026 19:11:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wLRO+g3DH7XNqnqYYX59VJYAt1IJxjxk0iOjYJdxYhU=; b=
	UuDmp8Sp5rS42YqIxDaewxwitmyY4UUGiR80Ka65aiczqbyEBZy2yWRCAf7e3JHb
	h3zTOg1aw3lX5kgyjcPqudBojckuoNm6dhat4+WtpRZjDXPtMMJ899GId+xXM5Hu
	rl4wQskMWuoD1HctthD95le4nxUHF1huGfAYVvvftpNXdCMdpIAz6fm5Ga8u+fSh
	GvCbXImIo0p+a9K087/9uMknDBW3qcZoxcU3yHGTav3f7NbH9jgVHE1zM33Isuov
	UOLT4AHrvw0H5hDqBIr8bRoqNBKBvkCTPM6OLoOKa1aT2Z8KO6fn/ZrVV0G7drF2
	VCkxOvqP5zYXstkE44rjHg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkre40g90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Jan 2026 19:11:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60FI7Bt5005714;
	Thu, 15 Jan 2026 19:11:14 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010063.outbound.protection.outlook.com [52.101.46.63])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7bek2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Jan 2026 19:11:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKccKAB1XpOUELK1VUaIyuryqe6+iSIyv5DmD/ujf188Ft1+VyKlTP3+x4QlIo5qtmwLx4SxPR90Uvg0VHf3Wfasn15ouBQd7bY2m5U5DE1w4dOim7EmjicEMl8qRMIxM0ZPh3R1dBnv3YFS0qzrCsuS1husEfL9PwzmCjyTn08fcgRy0xd9JKU4cSlEwPIjz99+LxYeq77BaDHZvARVH0w1r86SB3yRPLy8NDR/v61xj+YdWDe7PlpK4ckON5RsbiCdArGTdaCDD44jQMmZS5WzSoEQKjAsRbPnYh4y/oQfi7IVTEeCZek/J0YT83XjKi684FYgjmylxHzJ+rNtUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLRO+g3DH7XNqnqYYX59VJYAt1IJxjxk0iOjYJdxYhU=;
 b=C8HnzxOGHct1tsYmExM45SRBJQOsh7GJ6WFl1xrns0dVDK/vudQkh+MiKd1T0/453KMI5qIw/LnAxLrjVmXj+iI4qaq5qId95jx3Gho4YQytu5tVGSDyB9HClYL3BtO2BL3vc5ZzsDOTHNwxwgkRDnl2w6Bkap6D1N9rLp8UWvGb6SjSIN8K2xpXkm73w+8khddtSuQwMJEcTXRUZSKKwPSCN7GIw6eLeaOU2CiEwlnjSZyYB2VL8GWlqZ3mhqqgPZuIrpExgXzjqeoPMsgm2yKrIC4vwD70qyujlrKY/Yc92xwbaFq0zmRPp+ZejIdTYN0IbHUWG4KRAI9vduU5+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLRO+g3DH7XNqnqYYX59VJYAt1IJxjxk0iOjYJdxYhU=;
 b=Q1CCVue0Xhgp8f1GPjGzFnFHE7CN3d7eIe0f3Mrd0zacqeiRrrtzpPacBG+5WMJfjABf+aAEqzlrOfGQpmzaEZM2m5HEEXdFAQPDSbtRYVHL8fDQy4WvRtmq2tkuQBFDa5WRMhmD4jvQj1qJpmvjEdDjorePP56mj17eJJmm71c=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 DM6PR10MB4300.namprd10.prod.outlook.com (2603:10b6:5:221::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.7; Thu, 15 Jan 2026 19:11:10 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9478.004; Thu, 15 Jan 2026
 19:11:10 +0000
Message-ID: <7b09d0ce-9d4a-439a-969a-24b808f76b30@oracle.com>
Date: Thu, 15 Jan 2026 19:11:03 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: KCSCAN and duplicate types in BTF [was Re: [PATCH bpf v2 1/2]
 libbpf: BTF dedup should ignore modifiers in type equivalence checks)]
To: Marco Elver <elver@google.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, andrii@kernel.org,
        yonghong.song@linux.dev, nilay@linux.ibm.com, ast@kernel.org,
        jolsa@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        eddyz87@gmail.com, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        bvanassche@acm.org, bpf@vger.kernel.org
References: <20260114183808.2946395-1-alan.maguire@oracle.com>
 <20260114183808.2946395-2-alan.maguire@oracle.com>
 <CAEf4BzZruKmtcwK+V_qT8RcaXpp3=GXaZaiQtK4OchSR8Ye4Yg@mail.gmail.com>
 <5886e8c8-7646-4686-91b7-185cc953be20@oracle.com>
 <CANpmjNPJfmN57BsZknURkPG+1__1CsxW3zk+gpWS83c1diKstg@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CANpmjNPJfmN57BsZknURkPG+1__1CsxW3zk+gpWS83c1diKstg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0066.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::9) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|DM6PR10MB4300:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e9840f2-78a4-4c19-6da7-08de5469d7be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmZwOURETGFReVk4WmdMVnZrbjFmU05kNGZUaGJrQjFtSU1yUHVFZjNYY3lQ?=
 =?utf-8?B?c2RMUnhKZlNFenRaVFpEdk1HSHRhUzBKUE5tV05MQ2Q1ZTdJb1J4L0dIQ2R4?=
 =?utf-8?B?ckNIblM1dTlGTmxLYmtvVkovbEY3dFlYOEo2RndhbVdJT01rdnd6RHExNlZ0?=
 =?utf-8?B?TjdlaXdNaFlSUGZSQXB1dU52UHVNMmlDTWFSdlU0cFpudkJpU00wUlJlRnNQ?=
 =?utf-8?B?WTRidkVBVDhUSVZ6Z2JzQjZoTFB6cDVvNUlTbmc5R0VyeCtBcGkzeE1lRS8r?=
 =?utf-8?B?Wm9LSC9RVEZOWHhnT2NLTk50aFE3dVdMaDBKS0YvSnFsSGhISFdKMmozNUI5?=
 =?utf-8?B?cXI1N3VLU0UrWHhwcXAwSXhqMXlyVjg1S3l6WG02TXZYZ2FHTWF1Tkl2T214?=
 =?utf-8?B?S3hoS3FFQjgrU2pWVSs2RmJ0Y0VvSmtqTHBUNTBwSGtTWE0vT2s2OU5BTnAr?=
 =?utf-8?B?dEtyL2Ixc1N6OGF0aFpaS0NkZmF0NUQvdkpBYXo3aUFlRHQrYWxJRjV5cURK?=
 =?utf-8?B?TDAzMGV6UkNoeXNFdjVoRy9NaDFoMm16N21PdCthWjQ3QzNhRGMxbll4Y3JP?=
 =?utf-8?B?dmNsTFEwclQ2bURraDVndngrNHU1VldLcGttUXRSS0s5L0h5TmlBNVhIaWt1?=
 =?utf-8?B?NTFqL05ociszVEh5QVpEd0hHbWZsUE1RV2lWN1BJT0NIeWFIa3hkUGc1OW9U?=
 =?utf-8?B?RXZmOTZLcDQveHY4OURDRlBIUVE1eXZ1V3NoUVAvTCthUWlVRFRNZU1TK0xi?=
 =?utf-8?B?aC9uMGU2aFg4QXBBUmUyRWRLTGFBNmJBN2NaSU5VRW9kZjhLWk4rSUJlN0Rp?=
 =?utf-8?B?NFJiZU4vN1JsVVFUQi80MUxhTGN2NVB4cmlqaElxNjhOaURDQmlsQVdhWExv?=
 =?utf-8?B?UXdDaitiZUVSbUpQeHJ5RHIzeFgvR3paVVFyQ1JQSUpSSUVVN1p2UUtWR1Ez?=
 =?utf-8?B?eXo0R0VyRlBtcVBVaXB6N3NwNXR6dndwQm9MRGwvUkxyRHhtWjR1endJaXFy?=
 =?utf-8?B?RndlS0tjTUN4eDZ2M1dWNzgzVjBkM1BmMkpJaUhKZ0V0UEpha2ZUWmxwVlV5?=
 =?utf-8?B?MEo4RVAvOHo3WlNpQlg4N2s1aGJZRG9RSjlsTTlVMjFacDlxME5zSW55bXBN?=
 =?utf-8?B?UEY1ZnhiNUREK1RUaWFvUEZpbDFQRy9yU0liTUduMjdzSDBLQ0hSelloUEVR?=
 =?utf-8?B?eFFmZm41M1g4NnVIR3ZIb3g5QUJScDNFRTkyM1o5Sm4zRUNValFubmxuWGJa?=
 =?utf-8?B?RXZFMy8vNUNzVmNQRGNZZlBkRk5zVlF5d2xjMUE5K3h2SThnaGVnVDc0K0dI?=
 =?utf-8?B?RDlFelBDQVFTQnJyQ1lndmtaeHNrSG5MNmxmQTI5cHlwS21mOCtzeS9LSjJt?=
 =?utf-8?B?cVkreml3RXNxRXBRR2t0SDVkM0Q5eXJyODB3Z2l5UmwvTVRQN1JoZ29VM1lX?=
 =?utf-8?B?M1FHTHJEdzhvNjFzWHhSMzBvZ3FobmF2ZjRCelNUdDhGUHdCR0drK25nNEVp?=
 =?utf-8?B?V2thYWZwS1dydEFUbU56OTBQVE5zOEh4T0NvakNnQkpEQ2Z3TkxCallwdFR6?=
 =?utf-8?B?dmFUWWxkTGpaV3hNRElnSUdnR0hSTTdlanpoUzNwN09jMmtSQzl3a21oczQ4?=
 =?utf-8?B?QUYyS05CN1NCSjhUb0hZMGV1RS8vN2dIc1I0cW9KVkE0SEtuTHhVQ25yQUVt?=
 =?utf-8?B?ejNsWUdOeVVLSkhzYXhoMGlpdmIyS01ra3R5VmJVc2l2NnZVdTBBQktWa1B4?=
 =?utf-8?B?OTZjR2RsS080ZktTV09ib0s5MFB1V0Z4V1N4cEd3YmY5ZXJ4MmxTTUp4NXFX?=
 =?utf-8?B?SmRUMU5BaFV5eFV0LzNJTkZNOVlIWE42cG9Mbk1QZ1JnSVJxbmxvSWhMRzdt?=
 =?utf-8?B?TDNkUk9URGh6SE5QMXRNcFZ4bElwMitwMlBzV01QWG5qVkxDbGh1RUllVm4r?=
 =?utf-8?B?K2VSZkNKcWtxQVhWZ01xNkhTOU9CbjZqWjJnM2hyd0RvN0JHWTdsSDI0cVFJ?=
 =?utf-8?B?UVpnSXlSaG8vRzdxd3VKNUVLMHVtMlM0ajJ1Y2M2VG5pR3hXWUkzUi9ETE95?=
 =?utf-8?B?WXVtTExIYzBaYlVsbzQ4K1RnMWJRdWUwcklCNnEwT3BRT0lnR1RkTmNoMUJw?=
 =?utf-8?Q?Nong=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlpSNjArcUVmSCtVUnQyalFob09JTU1kYmR1V1dQREM3cjE1NlFTbVl6OWJr?=
 =?utf-8?B?bGJYRTh2dUVjeW80cVlSZXRqZHNtSy94VWVTUXV2b2pOSVdDMmNHOXFId1hI?=
 =?utf-8?B?b2N0VkU1ZVZ5YjVJNUZrWlFCcWxVUjZ4YjN6Y0xKMFYrVXRHcHVLMEpzQnN4?=
 =?utf-8?B?ZG1WRThMaWYrUVdUMDdobVlmM1RSOUpaUGdKRFU4UGV2Yk1rZ2h2MDZIVGsw?=
 =?utf-8?B?bXZNeGxjS0JZUlRxdmdqZWdLYkd1bmVvMTIvTjFhdFZWdlNCeUMxZHhVN0Z0?=
 =?utf-8?B?UmVGVDZqS1ZYQXROVE1qYkFwZWxyUzgwMFlvWlJMVlVWVElCdmlZZXBLUDJi?=
 =?utf-8?B?aWlOeXJwUDc4VmxtVU1PLzROT3I2NkE5TTZpajlZRjRudUEveEtJdDFCWGEv?=
 =?utf-8?B?ZmdybGNIVXo3Z1NYdWZXTVdCVE9NTVpaN3dlc0pyYnFKQTNrcXBBRGE5eVhq?=
 =?utf-8?B?Tk9rVEZCRy8zeFRYOTJaMXEvblFFT3QzbFdFSnRObmxCTnZMejRQVzhwN1F1?=
 =?utf-8?B?WXZFbUY2cGxrNVREOVhNd1ZKT1AxNHgzTUNtT2szSlNlMGtwRzdXRFlneldp?=
 =?utf-8?B?dkNWemxoZEMvYjl2NUVua2ZQRHZCZUN5NnJzWTZRdGI4dnVvanRiT0Z3Q2xU?=
 =?utf-8?B?dWVNdjR4RFprZnBMb2JHWTRRSG1aamFQa282UC9VM0doaXIrU1k1bzJ5QUxn?=
 =?utf-8?B?VDdYaHBzaGJOdTdWRVVhRlZraEczTlJsZFlqTnNPQkFpU3ZPbVZwQzFkSUJK?=
 =?utf-8?B?VjY2WmRlcWhHWFZOTGQ1WU5LS0pTYUxyNnNHWjJDNUxXbzRsNHp1Sjk4bUJa?=
 =?utf-8?B?MGQzMmcyVGdEcFVzdzVYRGJDSmhoRVdrTnYrQ0FNdmRzSE13UlJONkNxbkRT?=
 =?utf-8?B?UjBqbGdjYWNWS3VyRkJnRGw5THB1SmF5UERhK0lWVHRxWDlHYm5NaTBhZ0Va?=
 =?utf-8?B?SlBwSE1tUmNaNGdLSHgxVUFTSlI5MHU2ZWhQQ2psSFBRQ0h4cUhyQ2ZEVFA1?=
 =?utf-8?B?dmV3cG11a3pTaEdEd1Jja3cwdFllVU16QVhLSWxxc0Q0K3ZDYVN2dDBoWW80?=
 =?utf-8?B?VEhOR3NyQ3NGbzZsOHBOWVlLa0t5ZlREcXNqaHZLT0cvbGhxRUV0MzZIalNP?=
 =?utf-8?B?emRua3MwNVAwaG1iYVRZcEhvWWdRbUZYMHdHdmQ2a2JlTUNkVnVJRDB1NnJ3?=
 =?utf-8?B?ZjZNUFhOQUMyaW0xUWdQZTIxZkpKR1ZUbWpsay9jeVA4ZURZVW9uNzJrSnlP?=
 =?utf-8?B?Kzg2TnZ1cVhySmdCMkFJbEUwTjlQZ2Q2bXVFRWlVRWVTZ2F5eFBjYzdTcmhu?=
 =?utf-8?B?TjQ4M05PTkwxeVFveUVDUzBlUlZvc2hYaFlsZzJLVkZMSzdEaGNydGp2WkNC?=
 =?utf-8?B?U0JoaVluM1JYWkQxWUhpcG5hT1h0NTM4bHhnRUlMS3JRZDZMamhCOU5udk1C?=
 =?utf-8?B?Yk5ybGg1a1doNm9Fak8zSm1sYXRxNFJYWHJzUkErVzZZam9QNEZLVUJOTkU1?=
 =?utf-8?B?dzhycHBQUUhTQWlueDlDRllJdjA5MHU0Z0pIMjVVb0tIYUFUSFFPajd4YUJ3?=
 =?utf-8?B?M3lBVkxaSnY0ajU1bFFHOS8ySEFvWmtXWnJLQ25IcVI4NlFjeDFTeUZnQlFT?=
 =?utf-8?B?U3BIbk1laTZRYThCblFWUG5yUlE2Qytqd0lZUDNtUlN0LzNBQ3FEM0VVTURi?=
 =?utf-8?B?ZkVHZ1MrREpidloxZjBHN3FGR1h1QnFaVG0zV1FSYS80YmNVTGNmNmZKb1lo?=
 =?utf-8?B?TjlXc1VHM3JEMDMxMStwV0pYY2daaERzV3RyakRuTVAyZWpLSUpRRjBXK3Va?=
 =?utf-8?B?UW0wWk5HNHg3RmhabG5wSkFVWTVudDE3clJXNW8vQStjakZ6aUdUNmFkMWIy?=
 =?utf-8?B?WWUydVZ4cDREeUZFbmtDenFNMFNVVlV2L2Y1MEQ3WXM2MUduelc3cUNZUjhr?=
 =?utf-8?B?VkZudWw1cTY4U3VYbmpmVlVEQ09RRFVySHI4ejBmVGIrMENmMGJwTjdRTzFE?=
 =?utf-8?B?SDVTekVkTzhUQmR2clNFeElQbERLTzJFYTNXWllrdUhsVmFwYjk3ZFVmNHF0?=
 =?utf-8?B?Wmk4TGNHL01Lem9nTGR1cGFqdWFsUHU4Y3ZRdTh5US9wUzdLZDR3ektOclZN?=
 =?utf-8?B?aGpBRE9meXErZ0Y0TFZMWHhiWnVCNjN0NzlwWmlJSTlVWmJPb0kzNjJHeTQy?=
 =?utf-8?B?SDNZcmhNYUNRd0lQOFM0SFMyckJGK0V5SzdrVCtSNGFoR2FyZTl3UFdaUitE?=
 =?utf-8?B?UEp4NVhJT2lpNFBSZFpjTVJ1b3VBM0xYei9SbnhwU3BlbThOaEJ5OEd5MFRJ?=
 =?utf-8?B?TDA5SkdEK2xJTmpMakhUWGhZRlJBbXFGeXliSy9hUHNiY2hIbEw5UT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FiRHjg7N3lEaRy1kMuvjRjAQdUsLA9VyEFS9g+ogWUUPM5GayoBCJDxxwNS0x05WBIIRWF7Sy2MpTiD3skaiqNyqu5eY+GH26FVqjyAzIRSxjcbONfIcpZ7odM4DFmk2GaC5zCFhvTk1dTgGxUduA6rTjK8s5mBRLEAZbUc/Mqcrl74z4gke2MgD3TED2k5FT2IrYPZRs2InjqMk3JpNqs+7HA5PZ0s1NNDVImbMqoQ3ho/u97GsCv0EWaLJhUXbRaESUIodBpm0hi3tJDUGrU+6Ic70uzQJQh0fvcTSYy3XnW9YVw0G/CzLJzNST3I2fvqqrc+RJB/OLcejhRDiqfMDN3aqwL+kBEzgbseK5V2KZCpSCF6XNBaSNrjpjqXl4UH/UKZyF5gFF7vaiRaiumEYb9YthBDx4Mh749G1owInjQlyhgATN2dlkSE8dAKIIRouhSNFha9utJ0rMYaF1DdF0XcwU+ub7tXxC34S2tB5XXqxlJlKi07SeibuUBoXenJOSxhaHMb+kOMJytqkNho1p5cy3GX+znsTD7aRyenFd5PYCJx1M2NHesUTGRzbtQSCJC+lCL90DlmnmGqObboYOxnVAEZ3lX0O0jjup3U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e9840f2-78a4-4c19-6da7-08de5469d7be
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 19:11:10.3552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQv84b2gzKrpYJEpU7FPjL+hiSAyesvZbDo37DXrR07xetuX/Ot84DhPtLF0sf4yP8x4xJSWM0SkXPyqLMRiqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4300
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_06,2026-01-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601150149
X-Proofpoint-ORIG-GUID: 5ez2YdDgMX5ZWgEeOdkxN2_4jDiCqVfm
X-Authority-Analysis: v=2.4 cv=YKOSCBGx c=1 sm=1 tr=0 ts=69693bd3 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8 a=5qUQm5ksQB-EVdhpwFwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDE0OSBTYWx0ZWRfX0XznCIte38EY
 OTHppHA7OJtIrqYfMx2s0R8JlWs2JwtGBoFsmugVms/ApV8Ak1qN2iviAP88bpaUkfQoi5v1Jgu
 B1zMbf5aDp9X9cG+jYZb+a6CdRpKwHjL79hoIvuWyluwfkPtZkJ102wcJWg3gVly1WEJMljWZSu
 XsPZnZTsqARdDhusN8eMiwm2ikZsA3KSYvX2FE/y+apAGvnS+nzfuwP1kWSfLQs13PMoztW3pZ+
 0haYZAJfIz71Yi1hOzmugiV/h9ygwaXpFBzfK2aXSUWZlcJDlneISzcQaqf5UZGceqg5gHtZil+
 krQEPLgMm3lLInoCp/7VAy42b5CHaCbrnVlmTsojI24yebKSyKk8dRoxEJeLb9KJ5PYhpyN2kby
 eqtTc/RY+aBDlqd7dM1bXWqOr/D8vQOb5jXEJByj6GGO0VcoD7BOTVuOFzTQVo5zmFqMUegRu/n
 RKmYmi8FgNLUJrkyITA==
X-Proofpoint-GUID: 5ez2YdDgMX5ZWgEeOdkxN2_4jDiCqVfm

On 15/01/2026 18:55, Marco Elver wrote:
> On Thu, 15 Jan 2026 at 19:36, Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> On 15/01/2026 17:50, Andrii Nakryiko wrote:
>>> On Wed, Jan 14, 2026 at 10:38 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>
>>>> We see identical type problems in [1] as a result of an occasionally
>>>> applied volatile modifier to kernel data structures. Such things can
>>>> result from different header include patterns, explicit Makefile
>>>> rules, and in the KCSAN case compiler flags.  As a result consider
>>>> types with modifiers const, volatile and restrict as equivalent
>>>> for dedup equivalence testing purposes.
>>>>
>>>> Type tag is excluded from modifier equivalence as it would be possible
>>>> we would end up with the type without the type tag annotations in the
>>>> final BTF, which could potentially lead to information loss.
>>>>
>>>> Importantly we do not update the hypothetical map for matching types;
>>>> this allows us to match in both directions where the canonical has
>>>> the modifier _and_ when it does not.  This bidirectional matching is
>>>> important because in some cases we need to favour the modifier,
>>>> and in other cases not.  Consider split BTF; if the base BTF has
>>>> a struct containing a type without modifier and the split has the
>>>> modifier, we want to deduplicate and have base type as canonical.
>>>> Also if a type has a mix of modifier and non-modifier qualified
>>>> types we want it to deduplicate against a possibly different mix.
>>>> See the following selftest for examples of these cases.
>>>>
>>>> [1] https://lore.kernel.org/bpf/42a1b4b0-83d0-4dda-b1df-15a1b7c7638d@linux.ibm.com/
>>>>
>>>> Reported-by: Nilay Shroff <nilay@linux.ibm.com>
>>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>>> ---
>>>>  tools/lib/bpf/btf.c | 35 ++++++++++++++++++++++++++---------
>>>>  1 file changed, 26 insertions(+), 9 deletions(-)
>>>>
>>>
>>> Alan,
>>>
>>> I do not like this approach and I do not want to teach BTF dedup to
>>> ignore random volatiles. Let's either work with KCSAN folks to fix
>>> __data_racy discrepancy or add some option to pahole to strip
>>> volatiles (but not by default, only if KCSAN is enabled in Kconfig)
>>> before dedup (and thus we can't do that in resolve_btfids,
>>> unfortunately; it has to go into pahole).
>>>
>>
>> Okay, I think the former would be the better path if possible; cc'ed Marco
>> who introduced __data_racy with commit
>>
>> 31f605a308e6 ("kcsan, compiler_types: Introduce __data_racy type qualifier")
>>
>>
>> ...and Bart is already on the cc list. Feel free to include anyone
>> else who might be able to help here.
>>
>> The background here is that in generating BPF Type Format (BTF)
>> info for kernels we are hitting a problem since a few structures
>> use __data_racy annotations for fields and these structures are compiled
>> into both KCSAN and non-KCSAN objects. The result is some have a volatile
>> modifier and some do not, and we wind up with a bunch of duplicated
>> core kernel data structures as a result of the differences, and this
>> creates problems for BTF generation.
>>
>> Perhaps one way out of this would be to have an unconditional __data_racy
>> definition specific for struct fields
>>
>> #define __data_racy_field       volatile
>>
>> ...and use it for the two cases below?
>>
>> By having that defined regardless of whether KCSAN was enabled or not,
>> and using it for struct fields (while leaving variables intact) we
>> can sidestep the problem from the BTF side. Would that work from the
>> KCSAN side and for the fields in question in general?
>>
>>> Furthermore, it seems like __data_racy is meant to be used with
>>> *variables*, not as part of *field* declaration ([0]), so perhaps it
>>> was a mistake to add those to fields. Note, there are just *TWO*
>>> fields with __data_racy:
>>>
>>> include/linux/blkdev.h
>>> 498:    unsigned int __data_racy rq_timeout;
>>>
>>> include/linux/backing-dev-defs.h
>>> 174:    unsigned long __data_racy ra_pages;
>>>
>>
>> Not sure, the original commit above gives a struct field annotation
>> as an example. Anyway hopefully we can find a workable solution.
> 
> By "KCSAN enabled or not", I assume you mean in KCSAN kernels only? We

I should have clarified this, sorry; I meant _within_ a KCSAN kernel where
some objects opt out of KCSAN with KCSAN_SANITIZE like

KCSAN_SANITIZE_slab_common.o := n

> should _not_ define __data_racy as volatile outside KCSAN kernels, as
> that's not what __data_racy is for and would have other unintended
> consequences. KCSAN just knows to treat "volatile" specially, which is
> why it's used like it is here, but otherwise explicit volatile
> variables are a no-no in general.
> 
> Right now we have this in include/linux/compiler_types.h:
> 
> #ifdef __SANITIZE_THREAD__
> ... other defs that should remain untouched ...
> # define __data_racy volatile
> #else
> ...
> # define __data_racy
> #endif
> 
> But perhaps that should be moved to a separate #ifdef block:
> 
> #ifdef CONFIG_KCSAN
> # define __data_racy volatile
> #else
> # define __data_racy
> #endif
> 
> ... with an explanation why (consistent definitions across
> instrumented and uninstrumented source files), and why it's benign for
> uninstrumented code in KCSAN kernels (behaviour unchanged, but subtle
> performance loss, although it's an already instrumented kernel so
> performance is moot anyway). I think that should work, but it needs
> some testing.
> 
> Could you test something like that?
> 

I'm pretty sure that would work; let me try it out. Thanks!

Alan

> Thanks,
> -- Marco


