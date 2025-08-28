Return-Path: <bpf+bounces-66814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB850B39AA9
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 12:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CEC7684A6F
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 10:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A51130C62D;
	Thu, 28 Aug 2025 10:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cG6kqENa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yqKIEV51"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C50330C60A;
	Thu, 28 Aug 2025 10:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756378273; cv=fail; b=B1IF2PQwyqLBI1C9zHv3bjq+V6nXIHuNhhhGQLcCIutkQOFcrPX6MeUXcYC56Ab7ExYUnjgRDst2lFwYR9TysiAWeqf7+j21SCYVRUVCe/hVVkF2Uk3H+k4mZZ1llUAHdzaFnc3gvbd4sHhO6suC9EltAvCqAl7p4+pJMpODifY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756378273; c=relaxed/simple;
	bh=cwueqma/zQ+Uv3Q0BNP+FCgtxPXJFRY0272LCGk9VQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DVnVTzBjFdEtR6qBEZQ3yrhacNlLmjHYW0fzb7+0ePxtb7Pi1yp8W4NA9gQvzFj+KInXMnjaiktUcvdO5UoxRAlUCEQ/MqgMUdLimfcwQoZoufj/fNBQg/Qw8tlrJmQFlKQT0NpmwJo2j3UyQeyXE5O4BrmHcAzY3nUnv+c802g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cG6kqENa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yqKIEV51; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S8tmHP029314;
	Thu, 28 Aug 2025 10:50:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=X9QYOPadtEcK/RZ0qJyl+YgGbHqy64H6Xe8LJ3LSb8M=; b=
	cG6kqENaeTifFEkssNakVYgdlNxLslUmLdw9cHq6zSpSTGfI1gNCtnfMIXLhRM0r
	zytNFJlrkNdovoEUg8/1n02gmQt/pzFyBLcgTgukvwOUcOrVjplPO8hglNRHe6Vp
	c4Enhd0EBEROvFW2ZhM5vlz++nRLb7AP18HmfDBwhyHcy4bRqRCiaixN+AxPG2+M
	xWsSOtrc9dmBRVn104OLFAuV9OkvyqO5VNqEZYdjnxkRVJowZAtUNiZWK6+fAOTi
	IFb7bdQUW0luxlv1P2JZuXhZ5LY+bpqTRD0PsR1sPvlJS1tCdNkkulwrMdYgonBf
	fuA7xbfeFlrzZIpRQB5ajg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q58s87q2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 10:50:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57S9o1jM027083;
	Thu, 28 Aug 2025 10:50:26 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011014.outbound.protection.outlook.com [40.107.208.14])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43bm0ph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 10:50:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CAr1ydTW299GZz05HxXBrLOddklIgyqtRW7bJsU6nzDVg7knvE01y8brRyR3modDZTFK1qaS2ZWI1EW+Oh4l4bs9sZBUH35KhMe3qSgxJomHVlspy8eeVeqBBWqaiJ4SDE3s4AGiTGsakHEuHqgGClJBROvx1610R4O6luuJjsdqRTIvwSkXxlrtHqRFI6RfMl0zx32361w5su2ygplmErj642LHoO8PunUS75rZeNwSbZR7mzlcsLwTh+iAj2lfxgr7ZPUIsRHXgRKH3eyiZ8I7H7xJcWhUzgS9++WT+sydzgWBIVgGcpmk32ajUd6LEAr7CqPX/CPXxQA8JrUKbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9QYOPadtEcK/RZ0qJyl+YgGbHqy64H6Xe8LJ3LSb8M=;
 b=TK1LVXdhdg/ALWR2aQWxRUXCMXap2WWksS/0Nt+ifAdyVAAHxWDzbXewVqHq6SgOTXOxlq3+Rv9wLKSgUnIS8x2rcd45QaqDn9vnPEyWrEGry53DlMKYIqDxnZyHxScgsmwsjceOjEJoiJcNpeTsh2eknfjII3KtDCed4xZkzKu6jqaEyHAso6h1QotJW2ZyZVgiGE+xcGGmVvEwoSlGUa7jm+x2qyNfHaWHew7h5rMlqixUfn9iwNYJP9xNuTTMTRJxHyDKKClsSxccy3441Geelr9AOBMlkiajWAm5t5l7TJzURpDmnd25n5rqTrVG9HOfeMoUHN6ypidqAAYwug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9QYOPadtEcK/RZ0qJyl+YgGbHqy64H6Xe8LJ3LSb8M=;
 b=yqKIEV51tjdRsQBLU76KI0O/kLfeKA+hqjufYNzjQcxOwD4fsAaWOS4TEddGwHSrAvJ2QN4XgooLXD+LQfJP0M2B3SEDfwr7ih2nEsJGtDXANIExiG5ch1K7amuwaLV7j9d+CJoL15pD5w93MJvnzo7Up77glekPLHgv1EJrw6M=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA0PR10MB7136.namprd10.prod.outlook.com (2603:10b6:208:409::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 28 Aug
 2025 10:50:19 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 10:50:19 +0000
Date: Thu, 28 Aug 2025 11:50:16 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        hannes@cmpxchg.org, usamaarif642@gmail.com,
        gutierrez.asier@huawei-partners.com, willy@infradead.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net,
        bpf@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 mm-new 01/10] mm: thp: add support for BPF based THP
 order selection
Message-ID: <80db932c-6d0d-43ef-9c80-386300cbeb64@lucifer.local>
References: <20250826071948.2618-1-laoar.shao@gmail.com>
 <20250826071948.2618-2-laoar.shao@gmail.com>
 <f1bc20e0-9d39-4294-8f70-f51315a534d8@lucifer.local>
 <CALOAHbCd4vuZoot-Bt4y=4EMLB0UvX=5u8PjsW2Nz883sevT1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbCd4vuZoot-Bt4y=4EMLB0UvX=5u8PjsW2Nz883sevT1g@mail.gmail.com>
X-ClientProxiedBy: CWLP123CA0006.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:56::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA0PR10MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: 2272602a-303a-4cdb-0f80-08dde620adff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkZhb051bXBYclFLQUkrRjlFMVUzenVBUTljZG5lMzZ3R0dnVi9zTmp3LzJ6?=
 =?utf-8?B?OVVuSDFzVENLYVJWNGRteUxkM2RmWVhkS0FMVXRvUVlaREdObFlqQmJxcGZl?=
 =?utf-8?B?eGt4ZFNUckxmL285aEYzODJXRXRKSm94M0R1b2ZoVklQWVdpdXV2MXg2Vkh5?=
 =?utf-8?B?dld2M1h0bzNkVDRLOGExODdHbUtSbFJJMUdueVhjSWVlUlNmTnpjN1VFd1U2?=
 =?utf-8?B?NStYZ1dhTWFSQ0lscVdKdHA3ZnZZcGx3cklNUEEybEs0eG5waDVqOG1lTStK?=
 =?utf-8?B?T2ZzUmtKZlZnV1dBNktQQmQycjFCbDZBNGtpc0xybmNWRVR3OWZSb3c0QW1w?=
 =?utf-8?B?cjJDL1JLalIyUjR2cnJFcmFqVEFzQXRRRmorTFVhWTZRRTFIdDBiQm01MnJ2?=
 =?utf-8?B?YjhHa25uUGIxbTlzY1dEa2s1UTJXNjZUeGVZbURBeXF0WWkrMFVpemRlZVVQ?=
 =?utf-8?B?NXhVejk2cFJVdUI5bGw0OVRuNFNBdW45WEZBSjRsb1RsRzc5ODdNWnpVOUdZ?=
 =?utf-8?B?RkFtc3REd3VOd2t4cXlhQWJYeTFVV3YwcDhuYVRnaVRzR2tjTTcwSjFLUjNT?=
 =?utf-8?B?bElJYTVUc1lqclR1YitVZnBFcVpRcDJ3Q2dBUUdVTVBWaWt2aXRuOE84Zmsw?=
 =?utf-8?B?N1QwcEViUUF5QWVMUUQzTGdUUEM1OE5QaitaelpFZWQrRkRnMU1kLzVIZnpz?=
 =?utf-8?B?OUwzZ1NhM2Y1SWlLOG81dUo4K0dmd3ZzS2VsdGhhYmlOaXI3ejU5K0hUak5t?=
 =?utf-8?B?VnNscVZGZzd4dlJmeGJxMTZKMEl4VEdNWXFGMVF1ZGhWeU1qQXFieks2MjRN?=
 =?utf-8?B?cThncHVsaG1LS0ZJaStBbmIyUmxRWkRpZlpxR2ZhNGF6WDZkdTJCeUsvamUw?=
 =?utf-8?B?dC93ekV6L0dBeXA3OVQ1M3RlQmY1d29vWWU3ZUtReWUxNm90ajFsVmNjbmkx?=
 =?utf-8?B?alg3Qmk1RnBkNU14ZEFaVGdZOW9oYmhHZ0o2RVdlcWhvNzBnTXIrR0NPMjU5?=
 =?utf-8?B?MkZPRit3Y0dNM1I3aDlqZ04wK0YwMzBVTWhqU2tkbFgwelpCMEYrL2I4c05v?=
 =?utf-8?B?T1RlalFaeVMxaU5FU0tBbGlDb1lsODI3ZDRNRkd5YnQvMnF4dzc4aldncDdK?=
 =?utf-8?B?bE1aSUtQbVdtdFB0UUNZR0dSbGpwaGtsVTkyM1VUMXRZamdNQmRsUzAzYzdm?=
 =?utf-8?B?Yzk2UWNudDBINHBTdjQ4V290SGhXMThsSVBLMWlDeWw1Qm02a2g5eFJQdnND?=
 =?utf-8?B?VVhyN2MrWGFlSUdhcFNOU0c2Titjb0cxV1VWUFc4SUttNWpWSlNySlVZL2tY?=
 =?utf-8?B?VDFXWXdFd3pueGJhS1ZVMTFPeHhVU3VJQnZYQ1JlMlF3V0NlemgwbVU5ejNy?=
 =?utf-8?B?UCtVMm44WHlMNmpJMmtXYURBMlhyUWFteUZuZEtURHM4NG9zcDhCQ0duK1Vk?=
 =?utf-8?B?b3dZeXNYOHpvSmluRXBKWGZIZG5udnJNM000VWhxYm9hWU0yNUFSL0l3MS9s?=
 =?utf-8?B?RXFiWGZHN1hyOTFaWWh2QVhDL2JrR1FrQmllOXg3MHM2bUp2QU9ZRk5CTWVm?=
 =?utf-8?B?aGJva1FteTd4MVJJNDd5aXFUT0lCeFNhcnQyaHZYekJ3cVRyMUJnZFF5ZWE3?=
 =?utf-8?B?NmNPcFA4Mng3Z25VWjdOM3lSN01ncDZtNzdoeGJpVXRpdnhEcW1ObTBlcDVW?=
 =?utf-8?B?bjFNelpYalJiNlZ6c3Q3a3lCRmtsdGVXOUpqV1ZKWnZFcmpYejFkdnFzK1R0?=
 =?utf-8?B?TEJ6TG8yMEtqc1h0aTBJYys4di9XekZWZjAzRFU2Ym5GcTlZUFRIQmNxTjlk?=
 =?utf-8?Q?hCbRYIZgpaaifWb3VjSHwAOeApkAQZya6gaRE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjdZSStLRFprM0dJQjBWOXo1YVdoUExGN2pJbGxma0VVdHhJaTV3Y2o3azVW?=
 =?utf-8?B?YnpDb3N4aU55bHdYTVBMaE9xN1IwVm5vS0ExZGhGQ0p6Yk4vMDgvVnd2MlR3?=
 =?utf-8?B?WHlyVTVhQkdFbTZDZHZudG9Ud1E1R3Nmb3kwZkdUL25mY085T3dwRUVabXFD?=
 =?utf-8?B?NWdyakx3RXFra09PL1I5MWJVbTNGTkVoYnoyOHJzVDVraTMvNU5nV2MvWnVV?=
 =?utf-8?B?TGxIV1JOOXRCUmpRNExhVmNTOElxSllQdTJUeHRpNWkyUG9taSttVlhYd1Jo?=
 =?utf-8?B?QnFCRjRNa0o5QlVaRXZ6STF6SlFrNlFJL0lsMkZXWEtLaEMwNENOS0FHOHBs?=
 =?utf-8?B?UFVmMW1raHRwZ1hYdUhGOXdMeldVZGpqZE1ha2doR0hVM240UVl1dGZ4OHlw?=
 =?utf-8?B?NWNVRHFOWlUwNmgyVHVhd0p1RjhFMXZ6Yi9Fc3pmWmcwTjFLa3Y0YnNaSTdy?=
 =?utf-8?B?K3NTSHhxeTRoeEpYZEYySUQ2K081NFFqV1lHVE1WVyt3T0hVbzN6MHBtR1Qz?=
 =?utf-8?B?OFNJSHlicEFpbXhZUXJhNnJrWC9sTk56VnBYTE1tbUM4SWpJUnVHa3hzSndo?=
 =?utf-8?B?eVU0M1BLYWFaTXN3WjdtQWRPMktFaGRVVHNHZmNGcklHWTZGZHFpYlhjRUFN?=
 =?utf-8?B?U2U1RjFoZ2VtZTFpaTZ6VUdBcFgvZzFmdFZxNzEwTlIwanM4VXk5WW1iaXNY?=
 =?utf-8?B?cDBaZVhjYzY1U3hlK0JUdWY0cE5nNjVwdlVFcU10NHhWUVFkWGRnek1RbTlE?=
 =?utf-8?B?NTgzN2hBeFowcEpWdWxidUVZWExyZlJ1SUdyWXVjQVc0WHJVMUFvQ3hyTE5y?=
 =?utf-8?B?UkxrbkVLQ2t2bnYwWkNPeDZxRlpZNUhHbVZmaVBXa3NPblFYdFRGWDRPazBy?=
 =?utf-8?B?cnltOE5md01XY2VwcHBidGFFVklQQzVpVHZQUG1HbVh0a0N3MXozbmRyYzRv?=
 =?utf-8?B?eWNmSWNvNlFqbG05Z3dhbDNHWkRFTlk4dGRmVnpzZit3cXBlcnVmajN5dERO?=
 =?utf-8?B?am1xTi9VenA2VmlPNndtVS9sUXZuTkhveFlVVE9remRidHFHdmUvU1pLbHRs?=
 =?utf-8?B?cXAvY0dUck9TWGpyeThNclBpVmJUUFhqUkVDWTZleGRWVjF1SVdCaUUrVXdy?=
 =?utf-8?B?blVGY2N6ZHF6T2s0YU1MdkxpbEJseWp5UUc5OWVHMzRUM1MyVm5laGRqMkZU?=
 =?utf-8?B?cWtYYWFNUDk0N3REVzcwdmFjcjJVWC85ZnMwczdpNE91a0xvMHpEaDVjZFBW?=
 =?utf-8?B?dDNPUDJ4TzJIVFlKSWMyMWZpekdsWGtLL0w5NTRkdVdVakZ4SnNFRWFNVTlh?=
 =?utf-8?B?K3kxUUoyakIvMjQ2MWw5Tk5ISzQ4blNkM1FoWGZZZkUzVmFRcG84UFd3V2I5?=
 =?utf-8?B?L29LVVZia3llR0xFOHBkRDlBblZsNkdXdjUxbUtIOHdMTmI5RXB1SVR6dVpW?=
 =?utf-8?B?b0tQU1BxQmc4SnNvWmJUMUsvbXRiSmdlaUtsM0E1R1Qvc3B2TktvaCt5MWll?=
 =?utf-8?B?RU84WlBQbUduQzNVa1FodGUwRHU5ckkwR29FTExMQ0JFZFlKOVdKL3FRZkRR?=
 =?utf-8?B?YVBjZU1hZ2Z6QkZ5aWs2L3RNQUJ2M0E4bWw3S0w3NFhLcDlYN1FVOUFyTTVp?=
 =?utf-8?B?WGtQdWxUTXBBTXIyd2NkUHNrb0VtZTU5WlNuRHJzNXJ3Y0pubVZWZElqSExm?=
 =?utf-8?B?dkVONUZnQ3BwYmlkZWx6OW1PMVFQS08xbWNOR1hqakdja3g1R21hTEcwSStE?=
 =?utf-8?B?TDFZeEExT1Qvb0taQmt1SzRmdERkRzRudU1aT0g3TUROT0c5a3JBaWVPZkVq?=
 =?utf-8?B?WCtZczNvM0ZLQU1kWlRxZW1xaiszNTkzckU5SG1nZ3R6dDV2aVJIRDdvbS9n?=
 =?utf-8?B?MFVuYXVSaldlbzRGZHBYOGJPWTZCT0kyd2VTTTdqeTA1aXoweUxRR09DdCs4?=
 =?utf-8?B?ZndsVEtJTzFueVIxcGZxK0d6aWE3RHYrZUd1clNqME5MTTlCWDVjRWpuZXpC?=
 =?utf-8?B?WjBMVjdCT0doN2NvY0hTWGV4MHRvZDcrOVN3SjVxTWF0NjZOaGYyd1ZlbUVI?=
 =?utf-8?B?OEdkZ2RxeHI1ZGczUlVYNmIrazJNU2pzb0lkbnMvY2lsZlkvbFFlWnhHeERO?=
 =?utf-8?B?WEJzRmtzUzRxVE9lRThHcWpIV2FJNHg1Q2pndUkxeWNvR0NCQjFXRXRBSXNk?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	F2B6KayVZhjKGt5j7QKFm1XJ7V15aFiE/qxSFmRmCncsUyGhyUgAnlG8Kf81wq8wr7nJVBlch/PBrGNlsptGxE/88CZbDR5c0GbCg/dF+zNsm76+ZfssmqMiu9wJUEDf1VvkFcEMZGKncE4NuAhX2gQt07ZL9tH+ddGz5ZI7zbknBepURthZ7A0e7u6LQQZ5Yz2YeIxRtiPJpJECtoRCq+Jz0yRXYdrRPF77WXQjx6evN9cAcOzGODZLIKFk51I1joBDHdCJpwhAJj2tSN1qIyIsRTDnxNEpLvw0wTZ/j2yuhnrPkz3zSHMgsg5+aAV9VMWpm7G4VFAXAp3OCNrxeFByaWThqhHICavJfwAfVuvxO3b+m49TMq2zTUkBc+iVyWFtiqWisFFO0OUnPjM1GBFOQEUCgRvJh3Kr4D6RPWfKkBUBl4DHy4toavt1L2xwV9WPdrwCE8eGJ8g5xAiE3g2cpwIDDbScnDb3rdO8zAk+rM2mk2d/49tm0nanmb2vbDrPBcU7J+GLwMVWNfq0CeUaXuLZR3v4j7AOJ47aHvQIy2mNLAWidT837u0uPCZxcImPkQNS3Bxxz5Puaa4nLVs2Idqec9SWxfvl147R63Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2272602a-303a-4cdb-0f80-08dde620adff
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 10:50:19.1148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4CVEqjg6GMHpsIFnj/yqUHiuh/EdoaXvS/+qanWWj3miEmVf+sNQgt+IjWff+ViZyFK7J/XIziRk+7IbKBoUzJ+bN1S6xH5XMlEvcrfcwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7136
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508280090
X-Authority-Analysis: v=2.4 cv=J6mq7BnS c=1 sm=1 tr=0 ts=68b03474 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=07d9gI8wAAAA:8 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8 a=EUKqZ3xtgp5BXCl0uf8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=e2CUPOnPG4QKp8I52DXD:22
X-Proofpoint-GUID: 2grRuPNC379gAs3s3UWVD8I1ExjhsYn8
X-Proofpoint-ORIG-GUID: 2grRuPNC379gAs3s3UWVD8I1ExjhsYn8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyNyBTYWx0ZWRfXwXttoAEAn3MV
 Xc6f3zSafgMOal4jTuxXCr8asoG/okPnhpV8FTz5cfMVAcXMt9VcW/ATUJn3AcqAaNuUuekMro6
 AB8KInJbWGRytpd8n/MKEi+f8nYUJ+YMurgNlFreU/kAUbLsrTHpiCk83yesAq95EJUpNmbzJLG
 uBIF1oWpu7AqXJmGfXxYZIJDdO5tYJjZCNiTYT635GRRGUhkXtjtD82imR0/RjxrHtb6R9BpsBU
 R/2Z28KXrTMQIIpiiHwWYwzWZfFVUCsFBy69gLAN5nZyYyptoZiZe9V/nMsMIbdUr8P26LjcYxO
 ORm3Mau7KnXvLkJTmsacBXe3T/YUmyIKnr9g/O8R0QwPKM0xiF7UvQzSI4WHdM4so8vFnlHOyB3
 Lvs51krP

On Thu, Aug 28, 2025 at 01:54:39PM +0800, Yafang Shao wrote:
> On Wed, Aug 27, 2025 at 11:03 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Tue, Aug 26, 2025 at 03:19:39PM +0800, Yafang Shao wrote:
> > > This patch introduces a new BPF struct_ops called bpf_thp_ops for dynamic
> > > THP tuning. It includes a hook get_suggested_order() [0], allowing BPF
> > > programs to influence THP order selection based on factors such as:
> > > - Workload identity
> > >   For example, workloads running in specific containers or cgroups.
> > > - Allocation context
> > >   Whether the allocation occurs during a page fault, khugepaged, or other
> > >   paths.
> > > - System memory pressure
> > >   (May require new BPF helpers to accurately assess memory pressure.)
> > >
> > > Key Details:
> > > - Only one BPF program can be attached at a time, but it can be updated
> > >   dynamically to adjust the policy.
> > > - Supports automatic mTHP order selection and per-workload THP policies.
> > > - Only functional when THP is set to madise or always.
> > >
> > > It requires CONFIG_EXPERIMENTAL_BPF_ORDER_SELECTION to enable. [1]
> > > This feature is unstable and may evolve in future kernel versions.
> > >
> > > Link: https://lwn.net/ml/all/9bc57721-5287-416c-aa30-46932d605f63@redhat.com/ [0]
> > > Link: https://lwn.net/ml/all/dda67ea5-2943-497c-a8e5-d81f0733047d@lucifer.local/ [1]
> > >
> > > Suggested-by: David Hildenbrand <david@redhat.com>
> > > Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > ---
> > >  include/linux/huge_mm.h    |  15 +++
> > >  include/linux/khugepaged.h |  12 ++-
> > >  mm/Kconfig                 |  12 +++
> > >  mm/Makefile                |   1 +
> > >  mm/bpf_thp.c               | 186 +++++++++++++++++++++++++++++++++++++
> >
> > Please add new files to MAINTAINERS as you add them.
>
> will do it.
>
> >
> > >  mm/huge_memory.c           |  10 ++
> > >  mm/khugepaged.c            |  26 +++++-
> > >  mm/memory.c                |  18 +++-
> > >  8 files changed, 273 insertions(+), 7 deletions(-)
> > >  create mode 100644 mm/bpf_thp.c
> > >
> > > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > > index 1ac0d06fb3c1..f0c91d7bd267 100644
> > > --- a/include/linux/huge_mm.h
> > > +++ b/include/linux/huge_mm.h
> > > @@ -6,6 +6,8 @@
> > >
> > >  #include <linux/fs.h> /* only for vma_is_dax() */
> > >  #include <linux/kobject.h>
> > > +#include <linux/pgtable.h>
> > > +#include <linux/mm.h>
> >
> > Hm this is a bit weird as mm.h includes huge_mm... I guess it will be handled by
> > header defines but still.
>
> Some refactoring is needed for these two header files, but we can
> handle it separately later.
>
> >
> > >
> > >  vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf);
> > >  int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> > > @@ -56,6 +58,7 @@ enum transparent_hugepage_flag {
> > >       TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG,
> > >       TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG,
> > >       TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG,
> > > +     TRANSPARENT_HUGEPAGE_BPF_ATTACHED,      /* BPF prog is attached */
> > >  };
> > >
> > >  struct kobject;
> > > @@ -195,6 +198,18 @@ static inline bool hugepage_global_always(void)
> > >                       (1<<TRANSPARENT_HUGEPAGE_FLAG);
> > >  }
> > >
> > > +#ifdef CONFIG_EXPERIMENTAL_BPF_ORDER_SELECTION
> > > +int get_suggested_order(struct mm_struct *mm, struct vm_area_struct *vma__nullable,
> > > +                     u64 vma_flags, enum tva_type tva_flags, int orders);
> >
> > Not a massive fan of this naming to be honest. I think it should explicitly
> > reference bpf, e.g. bpf_hook_thp_get_order() or something.
>
> will change it to bpf_hook_thp_get_orders().

Thanks!

>
> >
> > Right now this is super unclear as to what it's for.
> >
> > Also wrt vma_flags - this type is wrong :) it's vm_flags_t and going to change
> > to a bitmap of unlimiiteeed size soon. So probs best not to pass around as value
> > type either.
>
> As replied in another thread. I will change it.

Thanks. Will check the other thread.

>
> >
> > But unclear us to purpose as mentioned elsewhere.
> >
> > And also get_suggested_order() should be get_suggested_orderS() no? As you
> > seem later in the code to be referencing a bitfield?
>
> Right, it should be bpf_hook_thp_get_orderS().

Thanks!

>
> >
> > Also will mm ever != vma->vm_mm?
>
> No it can't. It can be guaranteed by the caller.

In this case we don't need to pass mm separately then right?

>
> >
> > Are we hacking this for the sake of overloading what this does?
>
> The @vma is actually unneeded. I will remove it.

Ah OK.

I am still a little concerned about passing around a value reference to the VMA
flags though, esp as this type can + will change in future (not sure what that
means for BPF).

We may go to e.g. a 128 bit bitmap there etc.


>
> >
> > Also if we're returning a bitmask of orders which you seem to be (not sure I
> > like that tbh - I feel like we shoudl simply provide one order but open for
> > disucssion) - shouldn't it return an unsigned long?
>
> We are indifferent to whether a single order or a bitmask is returned,
> as we only use order-0 and order-9. We have no use cases for
> middle-order pages, though this feature might be useful for other
> architectures or for some special use cases.

Well surely we want to potentially specify a mTHP under certain circumstances
no?

In any case I feel it's worth making any bitfield a system word size.

>
> >
> > > +#else
> > > +static inline int
> > > +get_suggested_order(struct mm_struct *mm, struct vm_area_struct *vma__nullable,
> > > +                 u64 vma_flags, enum tva_type tva_flags, int orders)
> > > +{
> > > +     return orders;
> > > +}
> > > +#endif
> > > +
> > >  static inline int highest_order(unsigned long orders)
> > >  {
> > >       return fls_long(orders) - 1;
> > > diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> > > index eb1946a70cff..d81c1228a21f 100644
> > > --- a/include/linux/khugepaged.h
> > > +++ b/include/linux/khugepaged.h
> > > @@ -4,6 +4,8 @@
> > >
> > >  #include <linux/mm.h>
> > >
> > > +#include <linux/huge_mm.h>
> > > +
> >
> > Hm this is iffy too, There's probably a reason we didn't include this before,
> > the headers can be so so fragile. Let's be cautious...
>
> I will check.

Thanks!

>
> >
> > >  extern unsigned int khugepaged_max_ptes_none __read_mostly;
> > >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > >  extern struct attribute_group khugepaged_attr_group;
> > > @@ -22,7 +24,15 @@ extern int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
> > >
> > >  static inline void khugepaged_fork(struct mm_struct *mm, struct mm_struct *oldmm)
> > >  {
> > > -     if (mm_flags_test(MMF_VM_HUGEPAGE, oldmm))
> > > +     /*
> > > +      * THP allocation policy can be dynamically modified via BPF. Even if a
> > > +      * task was allowed to allocate THPs, BPF can decide whether its forked
> > > +      * child can allocate THPs.
> > > +      *
> > > +      * The MMF_VM_HUGEPAGE flag will be cleared by khugepaged.
> > > +      */
> > > +     if (mm_flags_test(MMF_VM_HUGEPAGE, oldmm) &&
> > > +             get_suggested_order(mm, NULL, 0, -1, BIT(PMD_ORDER)))
> >
> > Hmmm so there seems to be some kind of additional functionality you're providing
> > here kinda quietly, which is to allow the exact same interface to determine
> > whether we kick off khugepaged or not.
> >
> > Don't love that, I think we should be hugely specific about that.
> >
> > This bpf interface should literally be 'ok we're deciding what order we
> > want'. It feels like a bit of a gross overloading?
>
> This makes sense. I have no objection to reverting to returning a single order.

OK but key point here is - we're now determining if a forked child can _not_
allocate THPs using this function.

To me this should be a separate function rather than some _weird_ usage of this
same function.

And generally at this point I think we should just drop this bit of code
honestly.

>
> >
> > >               __khugepaged_enter(mm);
> > >  }
> > >
> > > diff --git a/mm/Kconfig b/mm/Kconfig
> > > index 4108bcd96784..d10089e3f181 100644
> > > --- a/mm/Kconfig
> > > +++ b/mm/Kconfig
> > > @@ -924,6 +924,18 @@ config NO_PAGE_MAPCOUNT
> > >
> > >         EXPERIMENTAL because the impact of some changes is still unclear.
> > >
> > > +config EXPERIMENTAL_BPF_ORDER_SELECTION
> > > +     bool "BPF-based THP order selection (EXPERIMENTAL)"
> > > +     depends on TRANSPARENT_HUGEPAGE && BPF_SYSCALL
> > > +
> > > +     help
> > > +       Enable dynamic THP order selection using BPF programs. This
> > > +       experimental feature allows custom BPF logic to determine optimal
> > > +       transparent hugepage allocation sizes at runtime.
> > > +
> > > +       Warning: This feature is unstable and may change in future kernel
> > > +       versions.
> >
> > Thanks! This is important to document. Absolute nitty nit: can you capitalise
> > 'WARNING'? Thanks!
>
> will do it.

Thanks!

>
> >
> > > +
> > >  endif # TRANSPARENT_HUGEPAGE
> > >
> > >  # simple helper to make the code a bit easier to read
> > > diff --git a/mm/Makefile b/mm/Makefile
> > > index ef54aa615d9d..cb55d1509be1 100644
> > > --- a/mm/Makefile
> > > +++ b/mm/Makefile
> > > @@ -99,6 +99,7 @@ obj-$(CONFIG_MIGRATION) += migrate.o
> > >  obj-$(CONFIG_NUMA) += memory-tiers.o
> > >  obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
> > >  obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
> > > +obj-$(CONFIG_EXPERIMENTAL_BPF_ORDER_SELECTION) += bpf_thp.o
> > >  obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
> > >  obj-$(CONFIG_MEMCG_V1) += memcontrol-v1.o
> > >  obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
> > > diff --git a/mm/bpf_thp.c b/mm/bpf_thp.c
> > > new file mode 100644
> > > index 000000000000..fbff3b1bb988
> > > --- /dev/null
> > > +++ b/mm/bpf_thp.c
> >
> > As mentioned before, please update MAINTAINERS for new files. I went to great +
> > painful lengths to get everything listed there so let's keep it that way please
> > :P
>
> will do it.

Thanks!

>
> >
> > > @@ -0,0 +1,186 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +#include <linux/bpf.h>
> > > +#include <linux/btf.h>
> > > +#include <linux/huge_mm.h>
> > > +#include <linux/khugepaged.h>
> > > +
> > > +struct bpf_thp_ops {
> > > +     /**
> > > +      * @get_suggested_order: Get the suggested THP orders for allocation
> > > +      * @mm: mm_struct associated with the THP allocation
> > > +      * @vma__nullable: vm_area_struct associated with the THP allocation (may be NULL)
> > > +      *                 When NULL, the decision should be based on @mm (i.e., when
> > > +      *                 triggered from an mm-scope hook rather than a VMA-specific
> > > +      *                 context).
> > > +      *                 Must belong to @mm (guaranteed by the caller).
> > > +      * @vma_flags: use these vm_flags instead of @vma->vm_flags (0 if @vma is NULL)
> > > +      * @tva_flags: TVA flags for current @vma (-1 if @vma is NULL)
> > > +      * @orders: Bitmask of requested THP orders for this allocation
> > > +      *          - PMD-mapped allocation if PMD_ORDER is set
> > > +      *          - mTHP allocation otherwise
> > > +      *
> > > +      * Rerurn: Bitmask of suggested THP orders for allocation. The highest
> > > +      *         suggested order will not exceed the highest requested order
> > > +      *         in @orders.
> > > +      */
> > > +     int (*get_suggested_order)(struct mm_struct *mm, struct vm_area_struct *vma__nullable,
> > > +                                u64 vma_flags, enum tva_type tva_flags, int orders) __rcu;
> >
> > I feel like we should be declaring this function pointer type somewhere else as
> > we're now duplicating this in two places.
>
> agreed, I have already done it to fix the spare warning.

Thanks!

>
> >
> > > +};
> > > +
> > > +static struct bpf_thp_ops bpf_thp;
> > > +static DEFINE_SPINLOCK(thp_ops_lock);
> > > +
> > > +int get_suggested_order(struct mm_struct *mm, struct vm_area_struct *vma__nullable,
> > > +                     u64 vma_flags, enum tva_type tva_flags, int orders)
> >
> > surely tva_flag? As this is an enum value?
>
> will change it to tva_type instead.

Thanks!

>
> >
> > > +{
> > > +     int (*bpf_suggested_order)(struct mm_struct *mm, struct vm_area_struct *vma__nullable,
> > > +                                u64 vma_flags, enum tva_type tva_flags, int orders);
> >
> > This type for vma flags is totally incorrect. vm_flags_t. And that's going to
> > change soon to an opaque type.
> >
> > Also right now it's actually an unsigned long.
> >
> > I really really do not like that we're providing extra, unexplained VMA flags
> > for some reason. I may be missing something :) so happy to hear why this is
> > necessary.
> >
> > However in future we really shouldn't be passing something like this.
>
> will change it as replied in another thread.

Thanks!

>
> >
> > Also - now a third duplication of the same function pointer :) can we do better
> > than this? At least typedef it.
> >
> > > +     int suggested_orders = orders;
> > > +
> > > +     /* No BPF program is attached */
> > > +     if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
> > > +                   &transparent_hugepage_flags))
> > > +             return suggested_orders;
> >
> > This is atomic ofc, but are we concerned about races, or I guess you expect only
> > the first attached bpf program to work with it I suppose.
>
> It is against the race to unreg or update.

OK cool, it does make sense overall.

>
> >
> > > +
> > > +     rcu_read_lock();
> >
> > Is this sufficient? Anything stopping the mm or VMA going away here?
>
> This RCU lock is not for protecting the mm or VMA structures
> themselves, but for protecting the update of the function pointer.
> Arbitrary access to pointers within the mm_struct or vm_area_struct is
> prohibited, as they are guarded by the BPF verifier.
>
> >
> > > +     bpf_suggested_order = rcu_dereference(bpf_thp.get_suggested_order);
> > > +     if (!bpf_suggested_order)
> > > +             goto out;
> > > +
> > > +     suggested_orders = bpf_suggested_order(mm, vma__nullable, vma_flags, tva_flags, orders);
> >
> > OK so now it's suggested order_S but we're invoking suggested order :) whaaatt?
> > :)
>
> will change it.

Thanks!

>
> >
> > > +     if (highest_order(suggested_orders) > highest_order(orders))
> > > +             suggested_orders = orders;
> >
> > Hmmm so the semantics are - whichever is the highest order wins?
>
> The maximum requested order is determined by the callsite. For example:
> - PMD-mapped THP uses PMD_ORDER
> - mTHP uses (PMD_ORDER - 1)
>
> We must respect this upper bound to avoid undefined behavior. So the
> highest suggested order can't exceed the highest requested order.

OK, please document this in a comment here.

>
> >
> > I thought the idea was we'd hand control over to bpf if provided in effect?
> >
> > Definitely worth going over these semantics in the cover letter (and do forgive
> > me if you have and I've missed! :)
>
> It has already in the cover letter:
>
>  * Return: Bitmask of suggested THP orders for allocation. The highest
>  *         suggested order will not exceed the highest requested order
>  *         in @orders.

OK cool thanks, a comment here would be useful also.

>
>
> >
> > > +
> > > +out:
> > > +     rcu_read_unlock();
> > > +     return suggested_orders;
> > > +}
> > > +
> > > +static bool bpf_thp_ops_is_valid_access(int off, int size,
> > > +                                     enum bpf_access_type type,
> > > +                                     const struct bpf_prog *prog,
> > > +                                     struct bpf_insn_access_aux *info)
> > > +{
> > > +     return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
> > > +}
> > > +
> > > +static const struct bpf_func_proto *
> > > +bpf_thp_get_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> > > +{
> > > +     return bpf_base_func_proto(func_id, prog);
> > > +}
> > > +
> > > +static const struct bpf_verifier_ops thp_bpf_verifier_ops = {
> > > +     .get_func_proto = bpf_thp_get_func_proto,
> > > +     .is_valid_access = bpf_thp_ops_is_valid_access,
> > > +};
> > > +
> > > +static int bpf_thp_init(struct btf *btf)
> > > +{
> > > +     return 0;
> > > +}
> > > +
> > > +static int bpf_thp_init_member(const struct btf_type *t,
> > > +                            const struct btf_member *member,
> > > +                            void *kdata, const void *udata)
> > > +{
> > > +     return 0;
> > > +}
> > > +
> > > +static int bpf_thp_reg(void *kdata, struct bpf_link *link)
> > > +{
> > > +     struct bpf_thp_ops *ops = kdata;
> > > +
> > > +     spin_lock(&thp_ops_lock);
> > > +     if (test_and_set_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
> > > +                          &transparent_hugepage_flags)) {
> > > +             spin_unlock(&thp_ops_lock);
> > > +             return -EBUSY;
> > > +     }
> > > +     WARN_ON_ONCE(rcu_access_pointer(bpf_thp.get_suggested_order));
> > > +     rcu_assign_pointer(bpf_thp.get_suggested_order, ops->get_suggested_order);
> > > +     spin_unlock(&thp_ops_lock);
> > > +     return 0;
> > > +}
> > > +
> > > +static void bpf_thp_unreg(void *kdata, struct bpf_link *link)
> > > +{
> > > +     spin_lock(&thp_ops_lock);
> > > +     clear_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED, &transparent_hugepage_flags);
> > > +     WARN_ON_ONCE(!rcu_access_pointer(bpf_thp.get_suggested_order));
> > > +     rcu_replace_pointer(bpf_thp.get_suggested_order, NULL, lockdep_is_held(&thp_ops_lock));
> > > +     spin_unlock(&thp_ops_lock);
> > > +
> > > +     synchronize_rcu();
> > > +}
> >
> > I am a total beginner with BPF implementations so don't feel like I can say much
> > intelligent about the above. But presumably fairly standard fare BPF-wise?
>
> This implementation is necessary to support BPF program updates.

Ack.

>
> >
> > Will perhaps try to dig deeper on another iteration :) as intersting to me.
> >
> > > +
> > > +static int bpf_thp_update(void *kdata, void *old_kdata, struct bpf_link *link)
> > > +{
> > > +     struct bpf_thp_ops *ops = kdata;
> > > +     struct bpf_thp_ops *old = old_kdata;
> > > +     int ret = 0;
> > > +
> > > +     if (!ops || !old)
> > > +             return -EINVAL;
> > > +
> > > +     spin_lock(&thp_ops_lock);
> > > +     /* The prog has aleady been removed. */
> > > +     if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED, &transparent_hugepage_flags)) {
> > > +             ret = -ENOENT;
> > > +             goto out;
> > > +     }
> >
> > OK so we gate things on this flag and it's global, got it.
> >
> > I see this is a hook, and I guess RCU-all-the-things is what BPF does which
> > makes tonnes of sense.
> >
> > > +     WARN_ON_ONCE(!rcu_access_pointer(bpf_thp.get_suggested_order));
> > > +     rcu_replace_pointer(bpf_thp.get_suggested_order, ops->get_suggested_order,
> > > +                         lockdep_is_held(&thp_ops_lock));
> > > +
> > > +out:
> > > +     spin_unlock(&thp_ops_lock);
> > > +     if (!ret)
> > > +             synchronize_rcu();
> > > +     return ret;
> > > +}
> > > +
> > > +static int bpf_thp_validate(void *kdata)
> > > +{
> > > +     struct bpf_thp_ops *ops = kdata;
> > > +
> > > +     if (!ops->get_suggested_order) {
> > > +             pr_err("bpf_thp: required ops isn't implemented\n");
> > > +             return -EINVAL;
> > > +     }
> > > +     return 0;
> > > +}
> > > +
> > > +static int suggested_order(struct mm_struct *mm, struct vm_area_struct *vma__nullable,
> > > +                        u64 vma_flags, enum tva_type vm_flags, int orders)
> > > +{
> > > +     return orders;
> > > +}
> > > +
> > > +static struct bpf_thp_ops __bpf_thp_ops = {
> > > +     .get_suggested_order = suggested_order,
> > > +};
> >
> > Can you explain to me what this stub stuff is for? This is more 'BPF impl 101'
> > stuff sorry :)
>
> It is a CFI stub. cfi_stubs in BPF struct_ops are secure intermediary
> functions that prevent the kernel from making direct, unsafe jumps to
> BPF code. A new attached BPF program will run via this stub.

Ack.

>
> >
> > > +
> > > +static struct bpf_struct_ops bpf_bpf_thp_ops = {
> > > +     .verifier_ops = &thp_bpf_verifier_ops,
> > > +     .init = bpf_thp_init,
> > > +     .init_member = bpf_thp_init_member,
> > > +     .reg = bpf_thp_reg,
> > > +     .unreg = bpf_thp_unreg,
> > > +     .update = bpf_thp_update,
> > > +     .validate = bpf_thp_validate,
> > > +     .cfi_stubs = &__bpf_thp_ops,
> > > +     .owner = THIS_MODULE,
> > > +     .name = "bpf_thp_ops",
> > > +};
> > > +
> > > +static int __init bpf_thp_ops_init(void)
> > > +{
> > > +     int err = register_bpf_struct_ops(&bpf_bpf_thp_ops, bpf_thp_ops);
> > > +
> > > +     if (err)
> > > +             pr_err("bpf_thp: Failed to register struct_ops (%d)\n", err);
> > > +     return err;
> > > +}
> > > +late_initcall(bpf_thp_ops_init);
> > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > index d89992b65acc..bd8f8f34ab3c 100644
> > > --- a/mm/huge_memory.c
> > > +++ b/mm/huge_memory.c
> > > @@ -1349,6 +1349,16 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
> > >               return ret;
> > >       khugepaged_enter_vma(vma, vma->vm_flags);
> > >
> > > +     /*
> > > +      * This check must occur after khugepaged_enter_vma() because:
> > > +      * 1. We may permit THP allocation via khugepaged
> > > +      * 2. While simultaneously disallowing THP allocation
> > > +      *    during page fault handling
> > > +      */
> > > +     if (get_suggested_order(vma->vm_mm, vma, vma->vm_flags, TVA_PAGEFAULT, BIT(PMD_ORDER)) !=
> > > +                             BIT(PMD_ORDER))
> >
> > Hmmm so you return a bitmask of orders, but then you only allow this fault if
> > the only order provided is PMD order? That seems strange. Can you explain?
>
> This is in the do_huge_pmd_anonymous_page() that can only accept a PMD
> order, otherwise it might result in unexpected behavior.

OK please document this in the comment.

>
> >
> > > +             return VM_FAULT_FALLBACK;
> >
> > It'd be good to have a helper function for this like:
> >
> >         if (!bpf_hook_allow_pmd_order(vma, tva_flag))
> >                 return VM_FAULT_FALLBACK;
> >
> > And implemented like maybe:
> >
> > static bool bpf_hook_allow_pmd_order(struct vm_area_struct *vma, enum tva_type tva_flag)
> > {
> >         int orders = get_suggested_order(vma->vm_mm, vma, vma->vm_flags, tva_flag,
> >                         BIT(PMD_ORDER));
> >
> >         return orders & BIT(PMD_ORDER);
> > }
> >
> > It's good the tva flag gives context though.
>
> Thanks for the suggestion.
> will change it.


Thanks!

>
> >
> > > +
> > >       if (!(vmf->flags & FAULT_FLAG_WRITE) &&
> > >                       !mm_forbids_zeropage(vma->vm_mm) &&
> > >                       transparent_hugepage_use_zero_page()) {
> > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>
> > > index d3d4f116e14b..935583626db6 100644
> > > --- a/mm/khugepaged.c
> > > +++ b/mm/khugepaged.c
> > > @@ -474,7 +474,9 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
> > >  {
> > >       if (!mm_flags_test(MMF_VM_HUGEPAGE, vma->vm_mm) &&
> > >           hugepage_pmd_enabled()) {
> > > -             if (thp_vma_allowable_order(vma, vm_flags, TVA_KHUGEPAGED, PMD_ORDER))
> > > +             if (thp_vma_allowable_order(vma, vm_flags, TVA_KHUGEPAGED, PMD_ORDER) &&
> > > +                 get_suggested_order(vma->vm_mm, vma, vm_flags, TVA_KHUGEPAGED,
> > > +                                     BIT(PMD_ORDER)))
> >
> > I don't know why we aren't working the bpf hook into thp_vma_allowable_order()?
>
> Actually it can be added into thp_vma_allowable_order().  I will change it.

Thanks!

>
> >
> > Also a helper would work here.
> >
> > >                       __khugepaged_enter(vma->vm_mm);
> > >       }
> > >  }
> > > @@ -934,6 +936,8 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
> > >               return SCAN_ADDRESS_RANGE;
> > >       if (!thp_vma_allowable_order(vma, vma->vm_flags, type, PMD_ORDER))
> > >               return SCAN_VMA_CHECK;
> > > +     if (!get_suggested_order(vma->vm_mm, vma, vma->vm_flags, type, BIT(PMD_ORDER)))
> > > +             return SCAN_VMA_CHECK;
> >
> >
> >
> > >       /*
> > >        * Anon VMA expected, the address may be unmapped then
> > >        * remapped to file after khugepaged reaquired the mmap_lock.
> > > @@ -1465,6 +1469,11 @@ static void collect_mm_slot(struct khugepaged_mm_slot *mm_slot)
> > >               /* khugepaged_mm_lock actually not necessary for the below */
> > >               mm_slot_free(mm_slot_cache, mm_slot);
> > >               mmdrop(mm);
> > > +     } else if (!get_suggested_order(mm, NULL, 0, -1, BIT(PMD_ORDER))) {
> > > +             hash_del(&slot->hash);
> > > +             list_del(&slot->mm_node);
> > > +             mm_flags_clear(MMF_VM_HUGEPAGE, mm);
> > > +             mm_slot_free(mm_slot_cache, mm_slot);
> > >       }
> > >  }
> > >
> > > @@ -1538,6 +1547,9 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
> > >       if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_FORCED_COLLAPSE, PMD_ORDER))
> > >               return SCAN_VMA_CHECK;
> > >
> > > +     if (!get_suggested_order(vma->vm_mm, vma, vma->vm_flags, TVA_FORCED_COLLAPSE,
> > > +                              BIT(PMD_ORDER)))
> >
> > Again, can we please not duplicate thp_vma_allowable_order() logic?
> >
> > The THP code is horrible enough, but now we have to remember to also do the bpf
> > check?
>
> makes sense.
>
> >
> > > +             return SCAN_VMA_CHECK;
> > >       /* Keep pmd pgtable for uffd-wp; see comment in retract_page_tables() */
> > >       if (userfaultfd_wp(vma))
> > >               return SCAN_PTE_UFFD_WP;
> > > @@ -2416,6 +2428,10 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
> > >        * the next mm on the list.
> > >        */
> > >       vma = NULL;
> > > +
> > > +     /* If this mm is not suitable for the scan list, we should remove it. */
> > > +     if (!get_suggested_order(mm, NULL, 0, -1, BIT(PMD_ORDER)))
> > > +             goto breakouterloop_mmap_lock;
> >
> > OK again I'm really not loving this NULL, 0, -1 stuff. What is this supposed to
> > mean? The idea here is we have a hook for 'trying to determine THP order' and
> > now it's overloaded it seems in multiple ways?
> >
> > I may be missing context here.
> >
> > I'm also a bit perplexed by the comment as to what is intended here.
>
> Using a BPF-based approach for THP adjustment allows us to dynamically
> enable or disable THP for running applications without causing any
> disruption. This capability is particularly valuable in production
> environments. The logic here is designed to achieve exactly that.
>
>
> >
> > >       if (unlikely(!mmap_read_trylock(mm)))
> > >               goto breakouterloop_mmap_lock;
> > >
> > > @@ -2432,7 +2448,9 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
> > >                       progress++;
> > >                       break;
> > >               }
> > > -             if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_KHUGEPAGED, PMD_ORDER)) {
> > > +             if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_KHUGEPAGED, PMD_ORDER) ||
> > > +                 !get_suggested_order(vma->vm_mm, vma, vma->vm_flags, TVA_KHUGEPAGED,
> > > +                                      BIT(PMD_ORDER))) {
> >
> > Same various comments from above.
>
> will change it.
>
> >
> > >  skip:
> > >                       progress++;
> > >                       continue;
> > > @@ -2769,6 +2787,10 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
> > >       if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_FORCED_COLLAPSE, PMD_ORDER))
> > >               return -EINVAL;
> > >
> > > +     if (!get_suggested_order(vma->vm_mm, vma, vma->vm_flags, TVA_FORCED_COLLAPSE,
> > > +                              BIT(PMD_ORDER)))
> > > +             return -EINVAL;
> > > +
> >
> > Same various comments from above.
>
> will change it.
>
> >
> > >       cc = kmalloc(sizeof(*cc), GFP_KERNEL);
> > >       if (!cc)
> > >               return -ENOMEM;
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index d9de6c056179..0178857aa058 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -4486,6 +4486,7 @@ static inline unsigned long thp_swap_suitable_orders(pgoff_t swp_offset,
> > >  static struct folio *alloc_swap_folio(struct vm_fault *vmf)
> > >  {
> > >       struct vm_area_struct *vma = vmf->vma;
> > > +     int order, suggested_orders;
> > >       unsigned long orders;
> > >       struct folio *folio;
> > >       unsigned long addr;
> > > @@ -4493,7 +4494,6 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
> > >       spinlock_t *ptl;
> > >       pte_t *pte;
> > >       gfp_t gfp;
> > > -     int order;
> > >
> > >       /*
> > >        * If uffd is active for the vma we need per-page fault fidelity to
> > > @@ -4510,13 +4510,18 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
> > >       if (!zswap_never_enabled())
> > >               goto fallback;
> > >
> > > +     suggested_orders = get_suggested_order(vma->vm_mm, vma, vma->vm_flags,
> > > +                                            TVA_PAGEFAULT,
> > > +                                            BIT(PMD_ORDER) - 1);
> > > +     if (!suggested_orders)
> > > +             goto fallback;
> >

(Thanks for all above! :)

> > Wait, but below we have a bunch of fallbacks, now BPF overrides everything?
>
> When allocating high-order pages is not feasible, such as during
> periods of high memory pressure, the system should immediately fall
> back to using 4 KB pages.

OK makes sense.

>
> >
> > I know I'm repaeting myself :P but can we just please put this into
> > thp_vma_allowable_orders(), it's massively gross to just duplicate this check
> > _everywhere_ with subtle differences.
>
> will change it.

Thanks

>
> >
> > >       entry = pte_to_swp_entry(vmf->orig_pte);
> > >       /*
> > >        * Get a list of all the (large) orders below PMD_ORDER that are enabled
> > >        * and suitable for swapping THP.
> > >        */
> > >       orders = thp_vma_allowable_orders(vma, vma->vm_flags, TVA_PAGEFAULT,
> > > -                                       BIT(PMD_ORDER) - 1);
> > > +                                       suggested_orders);
> > >       orders = thp_vma_suitable_orders(vma, vmf->address, orders);
> > >       orders = thp_swap_suitable_orders(swp_offset(entry),
> > >                                         vmf->address, orders);
> > > @@ -5044,12 +5049,12 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
> > >  {
> > >       struct vm_area_struct *vma = vmf->vma;
> > >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > > +     int order, suggested_orders;
> > >       unsigned long orders;
> > >       struct folio *folio;
> > >       unsigned long addr;
> > >       pte_t *pte;
> > >       gfp_t gfp;
> > > -     int order;
> > >
> > >       /*
> > >        * If uffd is active for the vma we need per-page fault fidelity to
> > > @@ -5058,13 +5063,18 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
> > >       if (unlikely(userfaultfd_armed(vma)))
> > >               goto fallback;
> > >
> > > +     suggested_orders = get_suggested_order(vma->vm_mm, vma, vma->vm_flags,
> > > +                                            TVA_PAGEFAULT,
> > > +                                            BIT(PMD_ORDER) - 1);
> > > +     if (!suggested_orders)
> > > +             goto fallback;
> >
> > Same comment as above.
>
> will change it.

Thanks!

>
>
> Thanks a lot for your comments.

No problem, thanks for the series!

I am generally excited about exploring this, so once we figure out details be
good to see where this can go!

>
>
> --
> Regards
>
> Yafang


Cheers, Lorenzo

