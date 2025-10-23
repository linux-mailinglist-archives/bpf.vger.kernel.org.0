Return-Path: <bpf+bounces-71875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BFABFFF43
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 10:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1375F4EF411
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 08:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3053301026;
	Thu, 23 Oct 2025 08:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d+ppSSzK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VLtSbwqo"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE49C2FF14A
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 08:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761208588; cv=fail; b=VWZuDSX0l4Y7bIS9HLDZqEmBYV+yRm0r5FF3HQJ/HuAYDwZYGbgqcUFrpi5djRv8YNTfRe3+1z9OGwnlyL3LRhxRixMNbroTFEijQmWNcdToCvc07rM6c5B2E1XcqMONl1vS6Q48bkI7NqXS2KiMqLpgjqhTeZhLevPJsHbDiSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761208588; c=relaxed/simple;
	bh=+y19g3Hv+6/xK5mYPQg3+crxif3m+WxcctxEaJtuWBU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uKZBlVqdF3VdvQGQjFeeNIkUPmnQn63Mj46WaP2CktF9SBntUte0vNbt9sCEO0FbUbPP+Pre6n2Ns/IjfL4hpBPdTW38VzmjzqbSmSOJkgUAeVP+nqbBInuGzOkhPovSe4Oh0uWWfYIt81+jN6f8PyfNRQOFc4FEHCPSE1MMxxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d+ppSSzK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VLtSbwqo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7uOmr022463;
	Thu, 23 Oct 2025 08:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=HxsRUKxJIZwlvgNEhv4cfE6NCjUQEKriFbnIJ+0sjLQ=; b=
	d+ppSSzKUv607IGK55kZ8v/JwXQHH8FtU9UW1+vxqma6VXC5Mh9DZGO+lJg5dg8p
	NfuFrNgpxhdGFqzTcFk830olecrqWJlc/5Gj+mEz58ItPpSBecs5sZrKVipqtRH+
	QhPxSafpD0kOyu4moPdT0UbNA89e42BdQxcjvbRzBkeygCwEUD6d+eDP52eRysn6
	sDsBK9B+UKGEiutRBFXIXIjDk3JWtiUHtboPcfFD7825ZfjYDnUCDrZ+TjaPFk9C
	UZKlyfQO7Ogr849kOOcWFWj71OmW530pijB8GxtL8e/didWkVRdXpYxux6/rB2Lt
	xxPDT0KPMz9YI14Mdm/IBg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xv3kt16a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 08:35:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7jF2C000865;
	Thu, 23 Oct 2025 08:35:54 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010022.outbound.protection.outlook.com [52.101.61.22])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1be8utb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 08:35:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJKg/+uNb/MygS+ZJCc98eHipC7e1c22XvKdvM52EiOkvYMqvJW659W1jCpa06jrxWG9A3byVZVW9uBHM6xgZ3swNWQlSxeU0CD1l9ShaqyHCyAz2GpWuQGel9H4fjYAxANVofWdL8IxlQyzlL4JJVeejv+Bp1DcEOUHwHXva6pIKGhz73Ex2Erq0u3wde8ZhXjLdieD4xQJhYwcbXaHXjrA0/relDjwSmmbG3uKLvozq6yJlGcOpv14fijVGcrfcC49k3G9Vbd+82zKbkC4bUM7lgtPFJaNTezlLCbCvHyMoygndGL9E4BRbRUy70C5X4VNH0rlfoyzB9kXiNxrKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxsRUKxJIZwlvgNEhv4cfE6NCjUQEKriFbnIJ+0sjLQ=;
 b=LyB3iJD6cmUIEgq5RBSLnbEGJgWsM0ypHuxPK72VwLIeZvPHhp4Ncn8H8ZJA0b81uA+ssRZKLcUKlXLt5J68vgByNyrfk2GkwitY9pFx88WaDjneI+DWzzTHCxsz1VZiIg7H9f0xSCb872zqEO362D2nbKhxv7gUYCidf83dfeo6USPB3x347V5CKRy02tom+mwbuI70QD9LvY3f8Od3ixJFi9tTosdwLFHh2wKcydeaFgNnwtS9P44aI4AAw9EG6DiBxKy458v5FSjIAhw8yzAcI8G27qzm1UF2zwU9Hb1L8eEz44Qo2m8V1fsWGOZXQs9HiuukxzdB+//nw56iag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxsRUKxJIZwlvgNEhv4cfE6NCjUQEKriFbnIJ+0sjLQ=;
 b=VLtSbwqoiiG0kpr8q1GRlZBHXTPeYolAMPcrxkz//p3seHSSH6xKNk839a2lSgHixSAJEL33tt+1Haq8Q29ElXd2K/g6W/LGXNV3LEjzD6mYk+XEtX1Mmzpj6kU7ooZob68/l+NqIsLo1gsCJ7ljA2g3phap6JtL04uRnzi+h6g=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 PH0PR10MB5594.namprd10.prod.outlook.com (2603:10b6:510:f6::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.13; Thu, 23 Oct 2025 08:35:52 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 08:35:51 +0000
Message-ID: <71337493-c508-4b51-9425-b9d211295ab1@oracle.com>
Date: Thu, 23 Oct 2025 09:35:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 01/15] bpf: Extend UAPI to support location
 information
To: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org
Cc: martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        david.faust@oracle.com, jose.marchesi@oracle.com, bpf@vger.kernel.org
References: <20251008173512.731801-1-alan.maguire@oracle.com>
 <20251008173512.731801-2-alan.maguire@oracle.com>
 <531305ee76a5ef186b1204dc8281ebc7ebb2b1c0.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <531305ee76a5ef186b1204dc8281ebc7ebb2b1c0.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::11) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|PH0PR10MB5594:EE_
X-MS-Office365-Filtering-Correlation-Id: 1890e3cf-9057-405d-50cb-08de120f2caf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmFEWGRLSnVRbTFVT2ZVNUNqUEdvZTlaNXZOYTdjNnZ0VVh6V1lIY1g2czk4?=
 =?utf-8?B?Y3pEbTFqQXhvcVU1ZnNWZVgraXF1T1NZUnpmSnlJbkI3ak5STkZPK3J6aGc0?=
 =?utf-8?B?VjJUWEJiVmV2emw2SHNpcDRXemFIZXlNZVVEdHFBSEp1M3JLYVNiL2FVTWpm?=
 =?utf-8?B?Y1N5KzRxb3ZJZHBSUVYwQzBaeEV5RTZSdXJrdnVWUUdPTEplaWVmVG93YjBC?=
 =?utf-8?B?TG5NMXNTSFYxbmVEWmdjN0Jub3dxd2N2UGRmUk40TjJOR0hXUk9aaE9JTG91?=
 =?utf-8?B?VEMrOFJtcFRUalVKOEdmdWZHSDdHVGtwWE5VVkVzaHUxL2xlVnBzU3lVOVN2?=
 =?utf-8?B?bTdjS09sT1VBYVo1MXAwTTJyNTYwRjQrV2RmcnNIY0ZPc3luVlhDUmh3QWto?=
 =?utf-8?B?NmJxdHpmZXkydmFhVWVyTjkyTU1HSmZoZjhkUlpaYk1vRnJQZWZacjRwUVdn?=
 =?utf-8?B?UmhZb01MdTNNdVJDS0V2RjhOeHNwV0k2SXZsYUZneTQ0ZnA5VFpka0pUWVB2?=
 =?utf-8?B?aDZzODRMMU9nQTBmb3pUM0drTkpIVUkyZFRWbVRDUkpEVVQxZHYvWmw0STdh?=
 =?utf-8?B?TkFUYll1QUZ0cUFPRW5nTTZxQ3U3L3dZbnZwZnRhQjI1TkhKaHA5RVArRlRy?=
 =?utf-8?B?Z20vdkIvdEMwbGsxQS80Tjk5U0xzSVJmbkFWTDF5RlJ5TU8vdXdPSXR5c0Zh?=
 =?utf-8?B?Z08vRWRhaE85eHVsNEpNaUJKUDZXa3I2R0V0UXZaYVRYWWg1aGF6bUl3TlAy?=
 =?utf-8?B?aEZoRVJlb1ZKcVJzOGI2VTA1aGZrNUM5eGFWUGJxcW5FcnJJVVJ1anM3V3po?=
 =?utf-8?B?NEdvenc5MURiK1JHMjg0YU40NEp6eHkxTkRCVWsySnFyY3hnZEZPVEFLdWZn?=
 =?utf-8?B?R2tpUjY4ajUyT0NvMHFHSXhzaWlPU0FQZmliNEhPUk01YTByMDh1MkdyOUtW?=
 =?utf-8?B?V2k0MVUwRFhNWlZEdVdjSGpNZmNjbmx0UHY2bmU1ZkxlSVcvdlp6RG5oSnJ6?=
 =?utf-8?B?M3ZRa0VDTThOTmhPUEpIWC9HNVhCS2d1TlAvVnUzV1NjQmd0bTBpZ2c0Wk9J?=
 =?utf-8?B?Zm9RelpwOUFRam9hY3lwRm0yeWJRZTZ1bWwzZlpKYUlxZ0NLSTVkYXlMQUho?=
 =?utf-8?B?VjE0bTN5TkZKRGVFcjl3OTNwS1plYk50am5TKzRINVA2OVlwNlVnQmxQTEdL?=
 =?utf-8?B?andRVjBacG9TTTlBbWF2MFJmWGo0T2RORm44eStNLzN0Y29xeVR5V2o2czN1?=
 =?utf-8?B?azllZVRSSEJNRnRubWJzblZPb1krVmsrUjgvaG5ybU81SHZPcXc3S0ZvU3o2?=
 =?utf-8?B?Yk0vTW0rakZ2dlR5N0hrR2d3K3IxR1RQZGVIcW9DVVJjRHdkZE8zYmplTXdO?=
 =?utf-8?B?Q1ZGMDdTanQrdjRBcGdvRGI2ZExLVm9ERDMvSXlON0Y5cFIwZWcwZUVMYjRj?=
 =?utf-8?B?c005TE5zQTM3OVNIUzdkNElYSjlCY2RkUVpJNEt2TzJCanczcDFPZzNVdVpB?=
 =?utf-8?B?MjZZNXhKRlArN0xRaEh5ellyTFVXRW56MWFUZ0h6UWtVVTIwVVZ4L3NpeHFy?=
 =?utf-8?B?eUhJREFjWVZLWmRNcTN4b092Z1RyNlNTdlBWTS9VRmw0SmpkL0QzOW1hbE0y?=
 =?utf-8?B?OU9yRXpnakMreUhNbllqRlVNRFZibXZXaDljcFRXOTI1T0dSZ0M0SmFRNWI0?=
 =?utf-8?B?U3BxQ0RhODlWbVRXTjAvb21BYTY3cmYyUnZLSy9qenFMdll3MEhOcGpqa2NP?=
 =?utf-8?B?NUVFMy8zOW5jWHdzL1N4VEFMd0tXVllSSUZFMVlneTVVUmdNWmZrb0owWmxa?=
 =?utf-8?B?dXdvMmxXeWE5eklxOE9NTjhwRDhqTERaLzRpbS81R3lSY1k2MVJPUlBZVmlV?=
 =?utf-8?B?MnBKYTk5ZDZ4aHRNdlZoZ05keE11dUM3OE9GUkVNWW5UdWFxTDN3dkhNTUw2?=
 =?utf-8?Q?M9Zww3fbwRJTP+mk6AQXmgYcJWTEMuAC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YU1PcCswK251bGNlNUNHK2ZMY2Nxb2diL05TWFVMT254N2EvVzVFRmhadXVF?=
 =?utf-8?B?MWtrVEFCMjhaQUtBK3BjL1M3Ky9oOE53bmk4UFF5c0lqVG9IN1RqcytWT1k3?=
 =?utf-8?B?NVRnaDZrTnlGSHcrV2k5RnkzeXdXRjZJcW52alM3VG93VlEvT3N3M21rbFIw?=
 =?utf-8?B?aHlPMWRFV29xSlJNTFZqbkEzSzIxY1gyVlRrV2NvbUQ2RktNOGZucklTNGh0?=
 =?utf-8?B?ZXVrbUJFVzl6bWJTQ253cjM2RDM4RGl6SWNPWXovbklCNUVLaEFML0dQMStX?=
 =?utf-8?B?aXhoa0Y2a2Z3OWU0STlPUXV4YzIybjNibWJlMTlUam1uZFZ0NEdPREZzeFo5?=
 =?utf-8?B?cjJ2WGRiekhHZ1VNaTVGTk5PalZqYkxubm5EaUFlS2dpREI2bmg1NmNoU285?=
 =?utf-8?B?R0Q5bHIwTzlseGJUUEJXR1JhazRUMFpNU0YxQlhiVWY3TzRTY1lIN05QRnoy?=
 =?utf-8?B?ZVplUkpqU0lWYnh6dzJ5dXI1VFFuSW1USEl4eXNtcm50b2ZjTldaU0FWVVZQ?=
 =?utf-8?B?c0FWUG82czFqNFFVRVFPazdSbXJZaUVxM1JWa1gya1V1ZWxyT1dHZWxKVWJm?=
 =?utf-8?B?Q2NhcnoxanVUa1p0Zi85NDRYTjZ0eXRLYitGbnUrTmdSKzZib2V5ZXhpZmVK?=
 =?utf-8?B?Syt2aHdoRXRHcTYrR0V6eDNKL3BISUptdGNsaEw5SGlDL24vcnMwZDhoQnJW?=
 =?utf-8?B?OU1EUUs5RTNMOFp6VE43Rk1FRDRHdTRkeUgxejRJRk9sKzhSWHEzMlA2Vyt6?=
 =?utf-8?B?ZkdmTDhZL2VaaEpPT2tIQytjVUpOWU1hbzBJSUVvL1R0a1BPYUNLLy9MbVBJ?=
 =?utf-8?B?RTdpcHNXRWxTTHZUS0FuNEhxOFg5Tlg0QmpyWmxnWHZkMXNpNUdJZXFtdGxM?=
 =?utf-8?B?NUdwTU8zYW55VDQxdjFZK2hnTVdOdURNM01uVGV4eXRPeUFYcFZnbVpOTjFl?=
 =?utf-8?B?YWNTV1pkb2VNV1ppR0V3VFF1Vm9Ld3UvNkJWLzRoR1BsQlh0TUg5NmFyclUr?=
 =?utf-8?B?UHFWTkZlK3ljWjBDWWcwMVZKbUQxME53ejdISEtnckE3cjM1Ty9ha2JpOWYv?=
 =?utf-8?B?bk9tVEpYZ0ZuMFdoQ1RYMHFnUUZJZ2ZjOStFQk5sd0RQbzB6N2lTcUxCSCtp?=
 =?utf-8?B?dmJ1aUJQTnRYSGhnRnlMMmxsSDF2RWtPMUVyV3NrVWo4UThaZE84OEVNcTVW?=
 =?utf-8?B?dml0OStpS1R6eVZubStLVDN0eU0rbDAvWUgyOE1SZ2ZMQXhrVnZsamJieWNl?=
 =?utf-8?B?STBxTExTSVZSeUhvMFRPSHI5TUFIVHNsOGhYRTFaNm1JTkttNmt6dWZxRE0z?=
 =?utf-8?B?YnY3bXFLK283aTBCYVd3ZlJlNjlKeDI1czhySlBnSXAyY0MyeUVXaDQrT2dw?=
 =?utf-8?B?b0hLMHB0ZVRzVWo5anVaeHIvazNWYW1LdWRwRHQxOUowT0llQ0VRb0hJbU0x?=
 =?utf-8?B?UkZMZC9KdnVrRVRXWnJ1WTNIeWhxaGlqTmI1emYxUWZScmFWN2dZdnROSDhW?=
 =?utf-8?B?TVFPWUI3TGppOXZsYlZaUk1oK2o4SEtKeURTbWQxTThyazdvQUlOUmFzSm5T?=
 =?utf-8?B?L2lhRE9kbUZENDJCSXF2U0dmVTZ6TzlBVEkyS2tIakMzbzdrSGFQV245cWFu?=
 =?utf-8?B?aFZLVW8xYVlMWnhjVUNJbFRvS2NIUUdHNHpZVFhhRENJeHVObUV4S2x5V2w2?=
 =?utf-8?B?MUF6VXNWeVdUUU9BZ2NPLzlpY0pYalkrYnVKbXdqYkFzM0diWGc2QzNQREp0?=
 =?utf-8?B?TFk2MGFZanVzSGFUZ1BWZ1lQL1JiZTFocXpHZ3RZbHFOT0dzdWlWdkxadnRV?=
 =?utf-8?B?QncvbVF4clNLOFBJcVNzTlE5dXBEai8wSEovaUxyRzVyb0puNWM1K1JId0JU?=
 =?utf-8?B?YW95TXk1K2cydW9CWTVudkJPNUYxQXN5bFp3cXh2UWFxS1BEUHBpR0xBVXRm?=
 =?utf-8?B?ZFNwS2VqSXpHYnVCaUVXWW5DbTd5WkMwRWxJOE5keDN3andEUGFla3dmWXFH?=
 =?utf-8?B?a3JXOXVsa2JlSTR6czAyR3NwU091aDhvSjlGS2RtOUpiTnNLSGZnMmc4alpM?=
 =?utf-8?B?eERWaWN2WW9YcWFvdVZmMFVjbWJ5R0Z6MGdDaW9aMzlBZTBBMVdmUHNtNGRZ?=
 =?utf-8?B?N1RNWnN2STBFbXcyVUI5dnZCa0pWaTAvUjhIclhNNFhhTmxUZm1PS0dNVXRm?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AiQr4cDOSwHyeS/HgB4FLDo0HPCysYWq6uP/Z0idhCseRWtJAEYi0ejLUlVOQ1u4fW+VkXeBnsurY5xYrWT8EJUZWWInSqoieK/dGSWR/5BnRwDFFLvC+0VpOMnkuT4voqx0vnHANCUOdIlwWiWwsuy6d8NHbjx3en8FqxGvtCzuJt+67c9LJ1SbtC695C9DmG2/nn2emH71pj6fIuyxPcFaMxKaDjtV2he+vjLvMElfx0hvka3fZ7MR/OMjLdCSrARONZC11jo8bfLDwzcPvO1LNf9sb2jT8h8NIw8RlS8WXMttKedbJrK97hyIr8kbKCClrYljEPoFD4YV2f1Bw3W7K+DzNsAzKjg7Eu6gQYb49U08qo3/Ip/2WxKWKwI9gOdqzpM0pOD2BBzYowmqHmRou2v0QqskerJPHjeQbKIjC744wKuhdG52eTB0P4JPiw4QETnOIqyKGo14IaCNMAxC2REhpRYytYJ+STprSt2IKraanFIdmblnczWDBFapvuQ4E7pkXJLhgRfYqbcTggISS6uhvfnpFBfZj3BzMwGXjVkMYCpPa/NHCp6xNhntqXS8OIxKSa8LdByQLNRMzI6GDEQj9q06oFXyj28bTrY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1890e3cf-9057-405d-50cb-08de120f2caf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 08:35:51.9127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QyvGZEVSmu2LGOGv3ZYGjZYF7vQ2TSggsnUJvbh1+A+7JObu0NosaG5SYtkS8KDZBjWzlhOD1ScCehyZgdDgyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5594
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510230076
X-Authority-Analysis: v=2.4 cv=acVsXBot c=1 sm=1 tr=0 ts=68f9e8ec b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=2JiABmKDm955DcjJ5vAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: g_wdFInKnt9b6sxlBWCiADV3mhuSO8p1
X-Proofpoint-GUID: g_wdFInKnt9b6sxlBWCiADV3mhuSO8p1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA3MSBTYWx0ZWRfX8pp2J6/0pgf7
 l3HX+n3yMGeJoZmrMmlb9g618Iun9QmzB6Sif6MeIiy1CkIC+1KP/H3YBt6XFDneFReG/cKXFrl
 iU7BZJr3SuLUnyiYwTKmygJwbDYNEsxK9TA9VjH45pHUeHYtEKSwv9Og5fnKTDj0O0O4rd6ijC0
 4XcXYCHrn/6QEPvxBA8X0O6YniNZpFx9sQS0MVpHHfPdPFSjVnRZdPP1XoEAPXduq67TGlv4PZA
 VwBubfXS0wTQzhJFNeF7qpYCrEt0TJhfMyrNzx1xVLuTwxTBh/1/UwnxDAwMckKO/Bn7ASLcVDv
 J2xjyjZr3cYCTuKzGPDcvcHFFQyEvHHQonRxhB1i1+HiDF6KjSErjUpM8HuFLGvOKurUmVT9xfg
 giY2Ou7jaYc5R4hcft6OR1jpYynKkA==

On 23/10/2025 01:56, Eduard Zingerman wrote:
> On Wed, 2025-10-08 at 18:34 +0100, Alan Maguire wrote:
> 
> [...]
> 
>> diff --git a/include/linux/btf.h b/include/linux/btf.h
>> index f06976ffb63f..65091c6aff4b 100644
>> --- a/include/linux/btf.h
>> +++ b/include/linux/btf.h
> 
> [...]
> 
>>> @@ -552,7 +579,7 @@ struct btf_field_desc {
>>  	/* member struct size, or zero, if no members */
>>  	int m_sz;
>>  	/* repeated per-member offsets */
>> -	int m_off_cnt, m_offs[1];
>> +	int m_off_cnt, m_offs[2];
>>  };
> 
> Should this be a part of patch #2?
> Commit message of the patch #2 explains why its needed.
>

Probably should be; I tried to keep the kernel stuff in patch 1 but this
particular change is more conceptually related to the changes in patch 2
alright given that we share field iteration. Can move all the field
iterator changes into a distinct patch for clarity.
 >> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
>> index 266d4ffa6c07..a74b9d202847 100644
>> --- a/include/uapi/linux/btf.h
>> +++ b/include/uapi/linux/btf.h
> 
> [...]
> 
>> +/* BTF_KIND_LOC_PARAM consists a btf_type specifying a vlen of 0, name_off is 0
>> + * and is followed by a singular "struct btf_loc_param". type/size specifies
>> + * the size of the associated location value.  The size value should be
>> + * cast to a __s32 as negative sizes can be specified; -8 to indicate a signed
>> + * 8 byte value for example.
> 
> Not sure it matters after Andrii's suggestion, but I find this
> description a bit cryptic. Maybe just note that (s32)(t)->size
> can be -8, -4, -2 for signed values, 2, 4, 8 for unsigned values,
> and its absolute value denotes the size of the value in bytes?
> 
> +1 to Andrii's suggestion to use enum to represent btf_loc_param "tag".
> 
> Also, what register numbering scheme is used?
> Probably should be mentioned in the docstring.
> 

Good point; it's basically the register numbering we get from DWARF to
ensure it's arch-agnostic. Regs 0-31 map the same way they do for DWARF
and reg 33 is fp.

>> + *
>> + * If kind_flag is 1 the btf_loc is a constant value, otherwise it represents
>> + * a register, possibly dereferencing it with the specified offset.
>> + *
>> + * "struct btf_type" is followed by a "struct btf_loc_param" which consists
>> + * of either the 64-bit value or the register number, offset etc.
>> + * Interpretation depends on whether the kind_flag is set as described above.
>> + */
> 
> [...]
> 
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 0de8fc8a0e0b..29cec549f119 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
> 
> [...]
> 
>> +static void btf_loc_param_log(struct btf_verifier_env *env,
>> +			 const struct btf_type *t)
>> +{
>> +	const struct btf_loc_param *p = btf_loc_param(t);
>> +
>> +	if (btf_type_kflag(t))
>> +		btf_verifier_log(env, "type=%u const=%lld", t->type, btf_loc_param_value(t));
>> +	else
>> +		btf_verifier_log(env, "type=%u reg=%u flags=%d offset %u",
> 
> Nit: print flags in hex?
>

yep good idea. Thanks!

Alan

