Return-Path: <bpf+bounces-70651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B37BC914D
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 14:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C5C23A0FC6
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 12:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8AC2E2DC4;
	Thu,  9 Oct 2025 12:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MHjceFf0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LFH60eSs"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2F02C2346;
	Thu,  9 Oct 2025 12:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760013677; cv=fail; b=XSJrlKr03OqUHXvsN4LfEHx7Q0Xz6nwpH00sEHIDwceouJnDOJtkisn7LWr0yZSw7KxlxRo2Zw2MCcJ3+O1YGcy60jtXVu8oo89IHnBLYJ7QfpIlE3zWVKspVbJf/kZB3J0du90NzThG/vHWeE03zYPNIQw6tjCWZEK9l1MNnfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760013677; c=relaxed/simple;
	bh=y/I+q6AWBdzm2vP1anZv7EoBoHjT/ex9D9HlH1qcm/I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e3PFqn402rYAL+muCJsZ/maGgW8rOU/N1URqy4Yzv/A1vE8hcccBwyK0TGcefWxNk4GWgKtQZ95M+GC4Jz9sTT+NJvQVuYo2vhBv2N28iXZwOjG9h7XYDcZ2wbJ9Z0Gv9pdPHzP3/AFvpSAKIUT+pmvFrVOZwwckBGQixqVQ0HQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MHjceFf0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LFH60eSs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5997u4je011879;
	Thu, 9 Oct 2025 12:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=nCq5jR6KD36ZZyIGqs9aJAcrDzo9gnSjuh59JijGdM4=; b=
	MHjceFf0AZ6UJuMl7yJ39HDkw19wlW9ejRt5ZTqdEr+K1rerMY3lMQVoItTPSXHz
	OmfPo+k497CrROk21qV9X8/4iiqY3dcn7BuWcSTZ8oIyIRSxDN+ckxHTleUqujHZ
	2pHfXiiQlHJjvMtFQzxiZC5xsD2SeSxUFueqCaDIRLXZYYGouW60hSgWoAIZptcZ
	HplLe7XGY365Y2njKbQXP5MAbOaV4jegc3ipKeREwiZVgq51GHdHnHjtLB7vp4yQ
	qmV+Yjh/molaQOKZglU/9sazNNqJHgofMr/4yh5AvH5CT6OArp3JEOtONW2ykl4u
	wZamAXRjYqh8m8Xvohc2Uw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv8psh5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Oct 2025 12:41:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 599Awbr0022800;
	Thu, 9 Oct 2025 12:41:07 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011032.outbound.protection.outlook.com [52.101.62.32])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49nv62ks7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Oct 2025 12:41:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9ulzq7Naz7QdQQQ/eqPpqeh9Ij9WCfEvLpcBH6GWyGRlyqSUJfcMIqyydWQkpBu++BBm4EcKP9ov1GSEC0iHDdKvf6Um5zLoMY5D0zCyHuVmR7rU7CznZJLeCoFE+ce+WDNocqv6IHM5BgoukvxCOfnXIv7Ivxp4IKyQPRIcILVEGu9QBZKY0v0WbIyRQnuQ3PDlFInRPOKwKSWPHHvqY1VmopKisuNheBMx6bLC9CwIfihnLUU4iPQgVP8zqEwzict/EAf5T954kLtjYlQN8wFHtqDtBvZugjlYB1FnfEVtZS9L+d2oeM9iJdLFtRRN8mxbLMdFlN+CtAdMkxR0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCq5jR6KD36ZZyIGqs9aJAcrDzo9gnSjuh59JijGdM4=;
 b=L/vgOa8kLCu31SckJeyMxlbPzLKv66QCOQGsMJUH34Aa2wHddrd6TzlPGcj1bCEtutWRCPV/JkRgOywpfSNItIaq2B6DZODSHJMsGwQprTZN3Df+R2Flfl3BGsMcxRFUBDBYdFz520QJKVLK0NYBLQpa8SvN3v32UgfK+Cnexz8UjHOu6tMBGRMDkYhRhxqD09g62/PePM8mcu875ilQLA65tKGIEnhDG71fSKG4aOk0MKdyYMJUL7F/wlquhw/g+DThrF7A5L2Xo1mAsudx9xEw8QpBkremV6YzMFAMqvzriW7lstKCO37lZmixqErS6ehpxHepWRHfZEAk8qsaZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCq5jR6KD36ZZyIGqs9aJAcrDzo9gnSjuh59JijGdM4=;
 b=LFH60eSse+NILAZ+eMyfsVKLxaA/3KHI2nTVcpU1wdfNKZIZ8rNEhdoq7hqmDjQLVbRJPmIGDnrWXbJZTddwJxaO/xlDxEfi2ilIPJfvytvzMNnXnWq8UV/4U/wDpk6Irsc9A4N2pa4RTgH97iiVwJHpph4L4JkZ8mVtgSErJFw=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 IA1PR10MB6123.namprd10.prod.outlook.com (2603:10b6:208:3a9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 12:41:04 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 12:41:04 +0000
Message-ID: <167bfba2-c65c-4e32-968c-3157e85bc410@oracle.com>
Date: Thu, 9 Oct 2025 13:40:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v1] btf_encoder: move ambiguous_addr flag to
 elf_function
To: Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, acme@kernel.org, andrii@kernel.org, ast@kernel.org,
        eddyz87@gmail.com, olsajiri@gmail.com, kernel-team@meta.com
References: <20250920003656.3592976-1-ihor.solodrai@linux.dev>
 <580f039a-72eb-417b-a435-d9ec0661fb96@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <580f039a-72eb-417b-a435-d9ec0661fb96@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR04CA0016.eurprd04.prod.outlook.com
 (2603:10a6:10:110::26) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|IA1PR10MB6123:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b1d56d-ab2e-4401-8960-08de07311c3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M00rY0g2UDZmR0tuUlBXeXYvRmMyblIwZEhZVk14R1lKSkxUNld6SW93UlpN?=
 =?utf-8?B?UWczbFNpSUtMOEZNK1dNbXl2MVR4YXN1UndqbWgrWWhTY2xhQW5IM0JKU2hz?=
 =?utf-8?B?VUprV1N4Zko0QzFpNDlsNGRCdDlRN3YwSmpSTEFBaHI3OWZ4YUZKK3Y5clpX?=
 =?utf-8?B?MWtPYzBPdXEyaFNhdVh1NWwxMkpFZTFKQTExZmFyUGkrR0g1Vm1HYzdsbDJ2?=
 =?utf-8?B?aFVxb2dKeVlNaDByM0hWQjdtQkt1dE4yV0M2dFY1TVhuZWorU2NsNTBoVldo?=
 =?utf-8?B?VFE4S3MyRGdaS1hOd1NPS0k2eXdXTERoS0tpWllkSDFEcy83eG1Oc0RwNGFl?=
 =?utf-8?B?RXZKTHF1ZVJaSDFlcExKb1dGM01RYkxwZW9MOGhka1RSSkRYcFpOb3VRRzkv?=
 =?utf-8?B?S1VzNklXQjE2NTE5Q1FBWXRtY1RINGdFMk15STBvcTJzbkdMNGtjYnpTVi9H?=
 =?utf-8?B?bXZaQXNPZy9kRjVVWTV2UVZQWWRFZTJXc2VYQjZpcytQSlh1MnNxYU9MOEI4?=
 =?utf-8?B?TVJML0JRTjg0L2p3RGtUelJQamRqOTNvLzZiSEMxYWVrZUZXazY2WXZLbFdz?=
 =?utf-8?B?K040d29BNDJNUVlIRnVJcWt3RVRkY2x0Q2FrNXBZYVF1dUFYbGtiemVIUEIx?=
 =?utf-8?B?MVJkTzZkNXhkZ1FBUEErODFzOStUUUNpRXkvMWt3YWVFZ2NhbVJTZ3VIK1V4?=
 =?utf-8?B?YWhnekdXU21aSnJDOHV6aVVONWwzcnBqaVVjRDl6YnlRSFRkWkdJTzlXWXBW?=
 =?utf-8?B?b3NQVk5XQXU0R0FxVS9Nd1FFaG9MaVNFa3RKSGpneWVVY2lFMmtiUzA2OVJ2?=
 =?utf-8?B?bmJYVGJBWEdEY1RnN29rWm50bXh2ZmlPbERsMkwvRXBrWUp6Tzk0d3VuRHJY?=
 =?utf-8?B?R3ZldWo0NU9DYmFpN2ZHT3dJWGRQRnIzTjBWWk80dWRRQ1hrdSsvUFJKQm1D?=
 =?utf-8?B?Um1Hc1o0QzFORGNaaDhKYTNvdW1KNmkwOWhWS1JFNzBiNHU1amNOMWVtQnpv?=
 =?utf-8?B?NXF6eW5PdUNMTWxHby8zd1EzUC9LREt4UEtBR2R1ZDJHaVYxYWdza0VJZEhu?=
 =?utf-8?B?c2RrK0VWQ3J6TDJuOEZrWmJXSDAwaHBwR0xMdC9LR3Zodk1SaTR3Q2FrUEdH?=
 =?utf-8?B?RlI0dXFwaHNyM3BDZTFxNldjRENrN01rb1VPVmRaRWZmbFBzUW9XTFExRTRQ?=
 =?utf-8?B?V3dtblg0a3BsTFpoelpCdXZFbGQzbUJ0OG9qQ1VZRWVQOWt0QzhNL0NmYXVx?=
 =?utf-8?B?UWM0K05IMThuNkU3WkZveFVyYmJLTkxiR0U1TlZKRVFoaDY4SXNvN3llSHl5?=
 =?utf-8?B?NUltWDBudklieUxjaFRaQTlVRVVIVXlYSzRqWTBpOURQdHBlK1RwazVTRDFi?=
 =?utf-8?B?VndwY3NNYnQ4YkZ2QktwZlN4Y0RTTHpZdmlDSDl2cGNWU05SbTRlZ09iUFlL?=
 =?utf-8?B?TVBSUXFNKzBLYTVFRlNSZHd6cG0rZ0UyWktkSmVpeSsvOXRmNFRXWUVUUFRy?=
 =?utf-8?B?RExseFNRQWlhSGYvNEFnamYyK090OFg5ZkxkZ0VsM3JXM2JIend4c3RKeEZL?=
 =?utf-8?B?ZlR4YjdCZ3pMNzBlc3hkR09oRjZsL3AzdUVWdDgxMjBiMnZSVDFwZUcwRUhU?=
 =?utf-8?B?QzBhMTFwWlBIa29tdDdBanROeXZ3aGlWcTllTERQRDM3UVRZTFFVNE1UekZa?=
 =?utf-8?B?RE5ma1JQaUtrMXdydW1lYi9iYUJmRWFRSDJoMFpjbmM4RjJQdDBrVEV6REJ1?=
 =?utf-8?B?elBTVzBhNEMzWnFjOTg3RjRGK2FjVk5IOWNXTERBdkZWZDY5czZxUCtDYUFz?=
 =?utf-8?B?ejNFNnJTeDVTMi9DWkhoZnZWYnVaSnJvYVBkeGlVTEY5aFVSUVZINUdpMktx?=
 =?utf-8?B?L2M3ek9FSWZhYWtydUJxc3ZzK3dLMGtWUHdkck4vWDludnJDcENEQkhlNXFT?=
 =?utf-8?Q?RxyZV80czPM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDJHc3VzNlFCOGNyQ25VVldlN3RHZzFjNXZGVnRsT2NDajlnSVZGWGswZG40?=
 =?utf-8?B?U3dJZjVMQi91MW1BdTFQRWsrYStMOUFnOXdHVkZseVBnbHoxYngyQjRqUkdZ?=
 =?utf-8?B?bmZHK1h0SFRiaUFTeFVhbHYwT2E5L2ZjS3FNbHhjdWNwOXNpYUtBaVJRTStG?=
 =?utf-8?B?dm8zUldVUWtENlJ4bUIzWjg1bzg2OVNpdmgwS2JDRnNtYnJEcVhzT2NOeXJ3?=
 =?utf-8?B?QU1XaHJ2cjFjV3lzZ1hydm9jeHloNzFHTG93YjFWWDNPVnhoTTU1V1ZWMzVL?=
 =?utf-8?B?RWE3NnMxODBxSUJXSnZ2V0Z4TUttbFd1cEdrOGxNdlhLUDg4aVdDUUd6QTg3?=
 =?utf-8?B?WGR0UEdxUStCM09RaGwzZzF5bXZnQ1ViVEtOclpyd251TjBLVzVEUE1iS0Nx?=
 =?utf-8?B?N2ZxclFGQ1A4RFluRkNUKzV1MW56OWM2T2Y5YU0zeWY1U096VWZ0OGkvSHhx?=
 =?utf-8?B?UGRVNFVCWWxvejUrZ2N0cFVWbGF5U0tOdkU3ZGxUZXg5c203T2tjRnJBNzEy?=
 =?utf-8?B?M1ZRbCt1VTI1YWphczhEZWZyMW03OU02L2h5QStOclBIUFZTMHg0aXpHSVg0?=
 =?utf-8?B?VE5hcFNxMGVkK2JxU2ZYajJmSTdVVEpDaFN1NWU5ODlzaklxa2NvVGhYOW1r?=
 =?utf-8?B?MU1pUmkrbFd4TlprVnVIQStyYVhHa3BIMmI4dUNNTXBjeUhVaVFleFMrT3Zk?=
 =?utf-8?B?UmZuM0ZxMDN0Mi9hcUNQZ0NyU2Z2UWxaenVuODN0WnBwSkcyalRocmpxRkxo?=
 =?utf-8?B?OTdETm9CcDlvQVpDV1ZNZFl3ZjkzTE1nY25yTnJyVG1PcFhiQlk5eDlyQkc0?=
 =?utf-8?B?Q2NwM1FvY2NzZU1HR1FiWlpUSm1RZ0RhRE5MR0hOMkVJK2xFMEtXWldGcGtm?=
 =?utf-8?B?Mm13bG9GRFlwV2RrRlZLTkR3ZnM1cnpTWnNqTDVkaDJicVg2eXlFdk5kSFR1?=
 =?utf-8?B?WFA0L0FPQUYySjBWWWNPTUhCd3V2Yy9KOVowYjNGNzJjZFZjbHZucVFGd1Rz?=
 =?utf-8?B?U2p6U1VTV2NrUTRpVlZ6S0tiRHJZa0c3UDljdTVJU0JEZFByMUdCYjRCWndl?=
 =?utf-8?B?RHZyZ2syTkZKWFU3cGh3UXBEeXpxSUhXMUVudC9xMjdzbnh0QmtIdDlPMTdJ?=
 =?utf-8?B?MkJuNkpLZW5IWEZMcUYxNG54VkIyNG9mVkdBU0FKc0hvSjdLYUJjVWJEQ0Rt?=
 =?utf-8?B?SHQrd01aZGp1ZDBwOVVVZTk4VEMxdWJrM2FFVWJkdzdGSjZsMkthOEFwYUpL?=
 =?utf-8?B?aG5rbVJCNjdiU2Q2M1o1cklMbHgrOVMrS1FGandpRDhtL1VEdjRwSGpFQXpx?=
 =?utf-8?B?L0dwNXFqVExkVk8rQkRac0ZMbmNRSktVMDRnTUxVSlBoUTVvRjVTbS80ekVY?=
 =?utf-8?B?TklFbXZrYVRtcHhRck9kNVFQZ05DT2w4aW9iNlA4RmEweEllTHFReFZpWi9E?=
 =?utf-8?B?cWxOM0Z1TmVWZllhY25ydUNZREpTOFNja0dCM3ZaWUR0RzJIL2xHR2JZak9v?=
 =?utf-8?B?WWl6amRRL3FYTHpnc0Yxd0h2aitDOWhXYkdhcnM5bUcxdEFzNURFTjRDK0VB?=
 =?utf-8?B?M2IwR1Faeks0ektJUnc0MHFiam1OK3Fld0wyK2hMZlFUSTJpY01RZVEvb01s?=
 =?utf-8?B?cGNwc3MvVGl5WFZ4QXBhVTNjZzh1cmxITEhDbkJ2aVNMVDNYdlJkdGVzdUVx?=
 =?utf-8?B?OEdGZm1QQVVxMGEvWXF5clZycUQ3OTBiSUUyZHNPUXRVei81aGNMTnRwVHRZ?=
 =?utf-8?B?LzB0NlNjR2lkbnNkU21UQmFXaFY4Y0VKVkpvYm9idjJWZUVlZE5jcU9SWVkz?=
 =?utf-8?B?Z01PSlE4QTZzYWtBdEVaTDVWWDBpazRWS0wvckhjUEpDeFRTNFprcUxsNUcx?=
 =?utf-8?B?T3dLaU16NmxIOStSQSt1UnJFS3NqeS9hK2hxTEdvQytoZnNFWXpRS01Zc1NR?=
 =?utf-8?B?NFk0bHhOcTFwczIyajQ1bDBOVzRPZENjbXBsb0t6RmpLc3NhN2Ftdks1SnA0?=
 =?utf-8?B?aG9pb1JyRGphV0hhQTVlaUxuS0c4ZEtYcmg1RGgyRVVPTG5qb3JhMlFNbDRH?=
 =?utf-8?B?ZVJ1Qy9MazJwcHA5VUdueDhlUWdUVGZpYlVnVzlkcHJORHk4blJ5QkxiTWpB?=
 =?utf-8?B?aEtGV2NVT0N3UWZrUXVwbzE1WnpzMFN5TE1wL0lJenhSc21tUDRpSmVQUVoy?=
 =?utf-8?B?RHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2v9DKMTllB7K0pjatelQxX3ftPe4UAK7Vr65Nv/y0fSRZy7H1OHYqAdWsdCJ+NDF3th99JttMixFkh1AjMGCHVmz3Ccv/Tw44Q/LTZ+lH40dUc63FtQi1Bd2Bq9NJvTTMqYMJ3hPHsT2M38xWYbIH2xA3MIFWIYiD0gUlgxPnqPYfnP38BMph1c5t86PKzwMhz17gY6N9dLTEXcKw/vO1bE+88w4y8UFcTDMKVhpNqgTTsinJfGvu8NEkbTAig5vFlXLWB4sSQcJW385/QqztEuNX7KlrSIyuTBZLlk6RO1P/KZoBkkEZnfMMs1vlVTCtWBraA/uvkzDzvIL+s77PxjK4ENiI086hR7LYCsb16DBh9RTMvQJQibiRKer4Z9XpbrU4TyYIbM5T+q4z42qSn5B36SsSaDWnMnQzPiC6qjUXFK5/dzkJH9c5PvM4aYiFWEEMHZiRgW5IJmQA3ulGGIfqxyJrlv1B7WZtCHitZDOR4M1FTkvizD6PozkwL/fJ7muYNEopKVx64+pgtFrES360nWr4KA8k6/tLy2tffffsyAAX+Arfz7HSf6NXK4pGMn2sU9ZMyHzTuKFWmkOsYna0vLk5CTjn7O3bXrLj6c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b1d56d-ab2e-4401-8960-08de07311c3c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 12:41:04.6300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cd6B80hrkkCqE0vZeKqgkYadRh7ZEn1bFefY30bXLTUNXCvvF+wkf4VGqKkKNordIEDRWN8vS0o+SAEZyiC2lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6123
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510090074
X-Proofpoint-GUID: wUFP6fv0XJg7PcVhFQXCI3Gv5_t2WRz4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMiBTYWx0ZWRfX438c+3jbnq20
 jBGweC1xc1Ujrg41jmdGUvwVN/B6R4l+OkDxLizVCWxpY0vvqv6di8Ym6+190wzOZ2JTJSGmrPa
 J++RetDcSbtm3BXiULAHQBkVfYz32n1gB0/0a6ghLyfc7xrHLHCrqjskI5ebfksTqfsUD+KqgKk
 IPnwRo8faZQoBmyxrzomkOITjb/S1BcJU7imo3TgBRevvJhmg7mpWN6XoAnymSt5o9iG7pYWT4a
 QztProX0B14rv74aXK+G4hg1y8Ue0MkVw9gG4PIa2NVwKEVeiYWZbB6mIch8gq/MF5pwvaIJkSx
 Qpp+4hpFy1W/ZAy2e3kewanCGfg/tA4h1CWpHNGrkJVAln6mSUU0AfEN8Tek2a9OgUjR+xCf8/4
 e49ho3uogZPi1iaBSOhAOzLHv9O0DPJi+SiFi19ndv+5pa/KRO8=
X-Proofpoint-ORIG-GUID: wUFP6fv0XJg7PcVhFQXCI3Gv5_t2WRz4
X-Authority-Analysis: v=2.4 cv=U6SfzOru c=1 sm=1 tr=0 ts=68e7ad65 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=ruMe8xyG7t8too32Pn0A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12091

On 20/09/2025 01:43, Ihor Solodrai wrote:
> On 9/19/25 5:36 PM, Ihor Solodrai wrote:
>> Having an "ambiguous address" in the context of BTF encoding is an
>> attribute of an ELF function, and not any specific DWARF instance of
>> it. Thus it is redundant to maintain this flag in every
>> btf_encoder_func_state, and merging them in btf_encoder__save_func().
>>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> ---
>>  btf_encoder.c | 47 ++++++++++++++++++++++++-----------------------
>>  1 file changed, 24 insertions(+), 23 deletions(-)
>>
>> [...]
> Hi Alan,
> 
> I've just noticed that you merged v2 of "btf_encoder: group all
> function ELF syms by function name" and not v3 [1] as I expected.
> 
> This patch is essentialy v2->v3 diff merged into current next.
> 
> vmlinux.h is identical between this patch and pahole/next (09c1e9c)
> for a sample vmlinux I had at hand.
> 
> Successful CI checks: https://github.com/acmel/dwarves/pull/70/checks
> 
> [1] https://lore.kernel.org/dwarves/20250801202009.3942492-1-ihor.solodrai@linux.dev/

applied to the next branch of

https://git.kernel.org/pub/scm/devel/pahole/pahole.git/

Thanks!

Alan

