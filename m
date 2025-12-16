Return-Path: <bpf+bounces-76718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DCACC412E
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 16:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88AC630D0E32
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 15:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B68339879;
	Tue, 16 Dec 2025 15:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mLMQJ3bp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JlOHdHL9"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2400033985D;
	Tue, 16 Dec 2025 15:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765897251; cv=fail; b=PGynUUUticJUOiGIQGgvtVsIydhlZiGg9nvxNURdn7logN/pkpNKtToMrsZBdvsmkcq13wSL4B0dmlmDg/z2bC6KR/1t67IDr4rLaUGDykyp8iT5yhAhZSOP3pSlQwlfWM5GPO87f+x919cH/S2LuVigRYuhKPvQTYOajb9fh58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765897251; c=relaxed/simple;
	bh=hXHyyRkIa41mAL6xXtAMzysgZShZ6MA0NhwOCniGaHg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g+HwObIgH6gCgRcFN399NgbotHnejnljArvhP0rDP3XHVA/PVMaYYSLk1o2/eg7Nzu0qLEVWxWDelqiq5fdo16NCTrTeKg1H2aoSbJFHj4t9yUvtIFWL3vHhYT0nWV3RlS1JUyKGNH/RW38kOxWGr4mdUhC/FQtWk3EiSRmPM1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mLMQJ3bp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JlOHdHL9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BGDuKP4443586;
	Tue, 16 Dec 2025 15:00:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=cExlfW6NQgW93Gz2/pVdw1tSTyku4zIhu8lRQ0ZZB+Y=; b=
	mLMQJ3bpc69l9jTB5FP21DYOcm7x9o+63x20OWNuIyC95/gs7UfqwsriEXL2XDLW
	1cVFN6n95XH6sANAbNmek9G1TqlnaAJ9PIleWenR/3ognJmNlM7jY2njelCrM748
	4M0xF5CTigmjnLvhKOxGHvz+00lUyE51snm78LmXv72+JZRKiDiK3j/O2CgQ7Ptz
	iFR1b48I3645cBsk4/pPD6hIejpkzBywvVsdG6zR9lOB6h3BgsH6TQadL72gGzC6
	MZg3UDJcm0u2yZ4qxOY0lMBnJxmGdcswDufTDdPZOsGSVXOkglfkdNRUKuorK+0Q
	KJC2heLVyZW1wwB8JJGhHQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0xja42r8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 15:00:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGESjkV022442;
	Tue, 16 Dec 2025 15:00:27 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012024.outbound.protection.outlook.com [40.107.209.24])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkkbqn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 15:00:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VtcTrJId+Mwi/fOmoEJ24OssjMcbPZ6ZLcxpGT9lZ7ft2owD5j0gQD42MDBpl7Hqn9kAAnXUdrr5tHW9wb2eZluezmYhoyqZkRqRRV8zCRhKqHLOqZmX1U2jTt9AVqAZZSXvTEaK0BQbYdRoUPwwSmvz4RtvWgkwoJHB302I/TdbnBai2NW/batsWMTnUUARkPJjfzf4pxV5p3Gy2T0M069FBv8KajPuFVoveJDSihB6GZAUuPvVrf78ankIxYAcY36uQQCygBAMwRaXYYhCR1Os3qxi1V/j/vugHNAK9b2+TqCJ49YGhawGCux0Of4r9+Nq3rXWb6P1cy5ZBFvitQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cExlfW6NQgW93Gz2/pVdw1tSTyku4zIhu8lRQ0ZZB+Y=;
 b=JZWNPZpmIxMFsAbFntyrRGFUIZCz9GLLFFqtKQYe2mUBodH/zrdRWMDQOKd/bFllx2XeNS6FcUNFibuidrtB+pcX0EAIDRDLTSZlIh3A3w93mSHOWSjiqM+6JYCMbz1tSJTlVJce9iQbYbLu09JUi7w5THgITirzbrDNO65B0NObn4xpUTPPSVG8O2igGSbTBQtCfQSXm9jNQZXCsvKaoO+Ui2hcmk13XCVX2fyB/qrOXxWWxGqdK+vS7eByLq4bRINxObr/W5BAMBtI1c6IgwxzeuRPkmmxgrAt1FS6PESDndBaNgjqRbmg/SOtR3KSm4ePA6Wqei717BEen/sOMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cExlfW6NQgW93Gz2/pVdw1tSTyku4zIhu8lRQ0ZZB+Y=;
 b=JlOHdHL95H8LeR9m7K1feV4TWYXkWkMkVI2qP3Hs8HZ5IBkd+tlW7ukeNXrhH51ZjBkVakh26Tnbj0u0h2C5JfNgwvKQZOzkbhq+FZEQIxAVWYCx7v/fiSZlb3tyM2yPLA5ALLbZ6KV9lqfOMg8MFjujUTBeA26qTXeVbKxlaqs=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 DS7PR10MB5182.namprd10.prod.outlook.com (2603:10b6:5:38f::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.13; Tue, 16 Dec 2025 15:00:21 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 15:00:21 +0000
Message-ID: <6f3027ee-576d-45de-9795-9a8e620292e9@oracle.com>
Date: Tue, 16 Dec 2025 15:00:08 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 bpf-next 03/10] libbpf: use kind layout to compute an
 unknown kind size
To: Eduard Zingerman <eddyz87@gmail.com>, andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org,
        ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org,
        ttreyer@meta.com, mykyta.yatsenko5@gmail.com
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
 <20251215091730.1188790-4-alan.maguire@oracle.com>
 <9e1b071598f9c1c1adcac0d8cb2591c452a675fd.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <9e1b071598f9c1c1adcac0d8cb2591c452a675fd.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::15) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|DS7PR10MB5182:EE_
X-MS-Office365-Filtering-Correlation-Id: 08ac25ac-9da1-46b6-a7bb-08de3cb3d57b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3djVENzbUIwNkxXYjdHMlV4YTVXWXoraEFjLzV1bjdwOUp6VnZHYnNZNmxm?=
 =?utf-8?B?bVYvZFVvOG91Y29yanI2WWdVd1RZdW8yYkl3NlRSRVpJNmZlb0lFVENZUmlz?=
 =?utf-8?B?LzRwbGlNNk00OWY0OGhJNyttRmd4OVJDUnlwWllDOHdac0x1K1E3all3R1hn?=
 =?utf-8?B?WkNEUGRzcXhxQWpzTFNaOHpyQ0doZVBhT0dLVkNVUjgydVJYL29zMTZvMzQ3?=
 =?utf-8?B?YU9WMEFLNlBCV1NSaGtkcEliQktNQzdlK3ZlQ1JuU0RZQ3FDcnZQTEtRalM5?=
 =?utf-8?B?dEUwRy9FVmNZNitLYTFoZzlqZWxZellUNHd6MnBZVHpiTXNWbHNLOEVsc0VN?=
 =?utf-8?B?OWRSdEIwZXdvd3EvZ0c2cjU3R25YMWNuQ2N0MURBQmRva0lobU9zT1NwbWpn?=
 =?utf-8?B?U25vRG43QXppNUdvdFlYTjNsWDFWaG8rQ0phdnRGa0JDRnFuMjRpUVdwN21I?=
 =?utf-8?B?VHdEdlZJVU8ySlhjRlB0ZEppVmZ0SHBBbjlmbGdTRVJ0T1RxKytEcjluYjNx?=
 =?utf-8?B?M0MwL0VHN2MzWVl4UFBVaGdHN2lxakg1YnYrZld6L0VuQTRFZ243NjFtbURY?=
 =?utf-8?B?c0hSaU9kZUpHTGVHYURCSjVQMStkSFVDT3hyTHRIaGZJQmRMYStQR29YTHVG?=
 =?utf-8?B?KzJIMFZ1dGdLYUNGMGJ3RUNiNEZQNXhZTTVMWVNRZjlNcnFMMjlZanY3T0Ns?=
 =?utf-8?B?c3RvMmx0U3lMV0lvdFJYbk5oMzEwL3M2MlF5Tnp6QjI5Q2FGa2NMenVSMkpX?=
 =?utf-8?B?aHl0bEFBSHVTRW9FdVFKc2txdHpVcjFtbnIvZFl1anZEV2xvUC9OVmg2R3Y5?=
 =?utf-8?B?MEd5ZjM4aGhnaUd0YWVHYkQrcjhpVkxKbmJleGRiZ1dHQWQyZWRnQysyNnhz?=
 =?utf-8?B?MUo4MGZTYWtYQnd4SnR6TUFzTnlqbjBQdXllYVhoODJGNm1JZnFhUEhPM0ov?=
 =?utf-8?B?STFJN2VoTDVZdmFpK3NEK3QvUk5LRmlPOTVTTThJTnNuN1gwUVJxZElFa0Jl?=
 =?utf-8?B?N2NsRHBLUUVpVEVEc0RWZlNQMFdQMXB3dDNiazc1WFVsMUtEVGFKbzdINHBX?=
 =?utf-8?B?T1hucWFyMDZRWDl0ckl0RkdwcUNaZWlMeDdBU0NoajNjQytQa3dBWnh6RHFM?=
 =?utf-8?B?dUlGNllPbWN4eUdqVzZzMnc1YjgrZUt1YXI3MGcyK3J4YzZwRHRsMmRlK0M4?=
 =?utf-8?B?WFRzVGZDTWFlbVB5anExeVpZdk1RcGk0Z3ZaOWRvc0lkVXJnQTBCRXVFamVK?=
 =?utf-8?B?a3V1TVRnRFZaWVdwZWFsdGxFaTBlNHRsSWpBOSt4WTRCc2gyS1UzcVc4Z0ZV?=
 =?utf-8?B?c1dBNlFKMVRRa0IxRzVkTVdxTXVrc2JmRFloWFgvRFI2MHJOYWFnTWJHQ0Er?=
 =?utf-8?B?VmJiWStBZnk0SzZLUGZDeXFzeEkxdDBJVnE4UHFQVjNyMkxBVGhvdTJrMU9R?=
 =?utf-8?B?OHZ6b2JGN3JKSFR3aEtrVGhVWkdwYW9iSnV5SW16eVFzWEREaVZwdkVsNG9n?=
 =?utf-8?B?VGsxT1JzRVc1T09xSkhmZUdJbUt0UDNYdGlob1dLakVrVzB3U3k1czZISEVz?=
 =?utf-8?B?ZkhaQ2E1UGo1OHdpTDJDSFFRUUs2UjBMdEZpcXhWVGdoNEd1TEhjb3BDN3ph?=
 =?utf-8?B?YlBwSVZmMm1UL3NXTHZUbER2UDB3SkhCcmFZZEVzL0VHaGNYSVo0eUtYVzQz?=
 =?utf-8?B?MktGOHh0ZWJGRDBVaTVsY09nR1VvQnhuYU1sdDFKWWZFVUt2MFRSbkgxNWhJ?=
 =?utf-8?B?ZUNGaTZpR3NlcmFETmtnRkRNNUVBUFhPbDMwcDZVZTVSWVJnU2dMYXJNVjJN?=
 =?utf-8?B?Q2dyeGhTc21QTzZDMTNKMjEyRDNEcURrankzK1QxM2xmZ3c3TVVad0hneW9F?=
 =?utf-8?B?U0RxSDRmckQvcnFkRjhzNk1kYWF0c3ZSbGh6YjZNSFV6MUR5TVhZbUN6L2hn?=
 =?utf-8?Q?SOH5ioFy5u1FRTVTBqU8y669Cca0DZxT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azVLMjREaTlmRVdLRER0eS9vSytnRGkzOFJCb1E4SFBNeWJ4OTlpdVdML0to?=
 =?utf-8?B?Z1RmZG5EUVpXbG9oTHlZOWxHY01YUThKRzE5blJ3dGhNUWNJVmxxOGFZK3J2?=
 =?utf-8?B?YkVGcmdxZGJVbkZjZU1URE1IdFhKZ2VJVWlLbDZmdm9tYklrcG9aQU0zYUVZ?=
 =?utf-8?B?ZVQ5OUt5Vm5XSC9KNHA5OXZPd0cvQU5uakYrV254c1NNMjB0WE1sanZyTUZr?=
 =?utf-8?B?cTluRFRxL3Q5T0xsN09CdERneE5MQmVkM2JsTEorNkcrVXd6Mjl5NGR0elUr?=
 =?utf-8?B?Q1BRbElwTG1hbXVZWWVFdGZEZXNSczF6QXhpcW1McmR2a1N2cFdONGZvR3VE?=
 =?utf-8?B?QlNnSkdsTEp1WW04T2poZXY0UWlsdC80ckRTbk4weVg5Q1M5QkJ1V3M3ek9W?=
 =?utf-8?B?WWhBQkdteHo5VlhYa0dRVm9zVTQ3dGlONjFvL1JpN21KL1U0RWl4Q0xrdERU?=
 =?utf-8?B?ZVhFRFM1aUt6bHBNRWV3MG0wY0pmL1EyNWorWDZoRHpWcCtRY2drMmFCWXhi?=
 =?utf-8?B?eko2TXY1N1E4ZGtpSHZJK1FUeG9VVE1YNVlSNVlwTDNRbzhOdGpGa3FVV0hj?=
 =?utf-8?B?ZWtQOWY0ak1OcHQ1NU5OUVpWZXJ4UUxaK0VvOHd3S3cvSExxcHpjTnN2bGxC?=
 =?utf-8?B?bUgvVkVTR2Q1VGh2ajFkL0trUitsbnlUdDlRZDhZNHNpN2xOMloxOUFhbks5?=
 =?utf-8?B?dENkMGdLekJxd09GSngrNDgvUFpJc3cwbDVlaDNLajFXS29PZVRxOExqc0d4?=
 =?utf-8?B?TjJuZzNvY2JMR0ZncmVWb2l3dE52bHNFTTFxeUdZbk5UWktQZFlNcWU0ck1Z?=
 =?utf-8?B?a2thR2hZS2FqYU0xcHZRQVNpMDZaOEtKdnZHaGJydXIzZHcvZnUyQnRjUzhu?=
 =?utf-8?B?bkpBS2l6bTN6c1Z1dys2Zk8rSzgwOWFTNzhvL05oaE5pTk5Xak5mWW1OZXlX?=
 =?utf-8?B?SGhWUW11UVFmY0RZNGVCWTBQYzVGa3JMTWhyTDhSQVJpSzVRM01kb1MwQmpt?=
 =?utf-8?B?eGxNZFUrMFE1T1dzRlZkK0tUU3duRlFuU1pMcUVBNjVLUWxTaEFKL1k5bkhs?=
 =?utf-8?B?L2I5NXFPZHU1aUR2dEtucEtnMEIxTi92citSQkxZL0d0ak9EenlZMkdIN2xn?=
 =?utf-8?B?TEkvUkF3YXltQTBmZlA1WVhvSm1ZWERsTWx6NGE0bnZCTXVZZzUzdERNZXlG?=
 =?utf-8?B?bUtmamVaVFNGSE9YK1RIOVRnazlWSWRMSFFpQ1JoOFc0clJwWHNuaWtrcjE1?=
 =?utf-8?B?OHFoT1NTOFl6d0lISWJ3YTRpLzNVamhqbnhML3poT0tUY05id1hQYnJqU1Ry?=
 =?utf-8?B?aThVUUVNV2RyWFNpODdzMUVXWlhDTUlpajVTNnZSS0VGd1JaVHNjOGQvRG03?=
 =?utf-8?B?QnFtaHJNYVRrRDRCNkxEYkVodUxTRVRzNjZtQTc5T1pIdzNGWkY4eGN0cFhL?=
 =?utf-8?B?Q21HcmpTd2tDUUM2TTBtZkNPY0Mxa2xFTTlKYWVlM1VMMVQ5azFLb2N1dzAw?=
 =?utf-8?B?b09OVHQvQlhPZzVNLzIzRG52R1N2YnhGTDBYYVhYMmwwOWpvOFFwVktlZG9S?=
 =?utf-8?B?Zk1wMVUwQ1BZQlozNW5rTDhIaWRkRWkzUXdCM1NObmtHTk1xUjlSYXI3VldS?=
 =?utf-8?B?bzNuakZnTElzTk0xYS9Dc0R6OTYzM05RaUtzMlRnQUt2SGNkYlhPZ3NFZWNs?=
 =?utf-8?B?ZlFTSHh2ZStKU0Z2bVVGUGJwNEpjOWJPSENyTklkOHRaSUxDQkpqMitUdFpM?=
 =?utf-8?B?UU5xNkhGY2xFZEZsY0haVTRzMXgzRmpnNG1GNmRDOFZjUFFIbVRTbkI1eHor?=
 =?utf-8?B?eDF3NDIrdzA0Z1pRZVRFcE9qRy9oNlFyS21hYjhKSUNRWHZQNGpybGkwdGZH?=
 =?utf-8?B?NWlvckRTeXhaUm43MEhhQ0lPUG1ZUUhCUWZRemt6OS8xdTJBUC9Eb2RSQlBQ?=
 =?utf-8?B?Y2kzdTZrMW5QbVBiK0pFRExtMXA4SUV6dXBhRkpPdnFJVnNNMlVDTTBnN2h4?=
 =?utf-8?B?VTdNekZpRTVqOXBvVnZtczhhTUdUR05TV0U4ZXgreGZsWmFtajNPVklRVEg5?=
 =?utf-8?B?UzZEY0xoTUdyYTdYeFBuNDZuc3B0elJvUWZHMERSYjM4TzZRSDJ3eDZFeTFn?=
 =?utf-8?B?QUswcko2cVZ6UERFaHJodVVZb0p2VU5rNVJ6cWRyRnJXbGZtYnZScUI3NEN4?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3TNERpN7u++LBaOdPZb1hBqiypqj3hfLViuT8UoHH8RwOXjN2DjJ1bCCnkDyxjd8930IR5NIoA1N/uGjInD6gvgEej5AhIdFzbFmiyZeCE1DzXvBk5Lr5HCOArhRurHMJXVTU6/ai5vV5eWr8Ar7wVJOI7sn/xQW62rBqYCd2+qQ540DXBIJs4gumVJuG5KS7iA/CLGKrG131iMSYtIExw8qq8qDBihLIzqYfTjCsmWyxLQOEpRjkyOUZUKmmxsLrWjfkvuiu3O6+RpKvZiLrISI8ShBzlNlFWn80KDQiDHj+w9SPXCxwQKq6HMrx9iWbPj0YVeHDrBnCTwINGX/Ye82PkRKv8mzGmVCEntpvGMVPE5ZMw9SBV/JCnpFcCYCAubT1ueO4v/odA5u2uNw8bHUdZOhCKG0o3dOMxpGUt7j9c/yaIF6AqoGaEtwTneyxlDTquz/0XLiJC+Cw0cDU4xq4ubcfoiSC2ZFSWo32L4RClfzvbg2XKzmpl1SotyMZNmvBPrQ0LA+5+CWNaOX/+mHW6zkCxGRRBQbIS2VdXJuSD++bhRcbXTlcZgtz6aYefVGgoWPMsKtPiElFOvvOwkzs4ORKOa49Z0YwwxOzRI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ac25ac-9da1-46b6-a7bb-08de3cb3d57b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 15:00:21.5226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AX/NiaQz+Awhgml0ZrEyRO54e+Iub28OhsepcZloMP4+wjqqaQhMPVm3JqhJXKgICk1X5s6obj430Ic+7X0fGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5182
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=880 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512160128
X-Authority-Analysis: v=2.4 cv=TbWbdBQh c=1 sm=1 tr=0 ts=6941740b b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ckNEw6ko5CaXkXk6fd0A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13654
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDEyOCBTYWx0ZWRfXwXhXTwX3fvJq
 gmBJ/zziG9z5F3NYJvNhtgKrMkkTyJmeP7uJYpsWC8PwzyJFECgD8cPVtLmBrIJ6PTIAvggL4uS
 CXjyi0un5VwZ6vMTysLTq/hA7PhDSWHwffAaNglsjzWnVdL0cXx5A5aIutaFbrDOLjosngQs7rL
 X6O7vd6ZK3FGESDXJm4SgOOIJ9hgOQqyqSPuTGwhxFdcd7EjSwiuFChRm9HIW15/ltinY6PTkuB
 0pooTB96pvCusdPcneQlsjnz17F5vBhXqnPnhLaBky1Vbndr5xsY3tQHOXF2HQpR95F2Y7ve89z
 JyUl1h+UQ/MdxaOCDvR1u4IKlLe2D95hHx8pz9imHY+kSFuWl8ZHBASmU/ji3ym+PNUM9LoTvqI
 QBxf11+8/tmjQF0VgRuq5IrmLKC+3kZUaRKxeEZua3ZgyPOvLeI=
X-Proofpoint-ORIG-GUID: iaZBgPP7N-Q64jtIoaFRSVH2-1Qojndc
X-Proofpoint-GUID: iaZBgPP7N-Q64jtIoaFRSVH2-1Qojndc

On 16/12/2025 06:07, Eduard Zingerman wrote:
> On Mon, 2025-12-15 at 09:17 +0000, Alan Maguire wrote:
> 
> [...]
> 
>> @@ -395,8 +416,7 @@ static int btf_type_size(const struct btf_type *t)
>>  	case BTF_KIND_DECL_TAG:
>>  		return base_size + sizeof(struct btf_decl_tag);
>>  	default:
>> -		pr_debug("Unsupported BTF_KIND:%u\n", btf_kind(t));
>> -		return -EINVAL;
>> +		return btf_type_size_unknown(btf, t);
>>  	}
>>  }
>>  
> 
> That's a matter of personal preference, of-course, but it seems to me
> that using `kind_layouts` table from your next patch for size
> computation for all kinds would be a bit more elegant.
> 
> Also, a question, should BTF validation check sizes for known kinds
> and reject kind layout sections if those sizes differ from expected?
>

yeah, I'd say we'd need your second suggestion for the first to be safe,
and it seems worthwhile doing both I think. Thanks!
 
> [...]


