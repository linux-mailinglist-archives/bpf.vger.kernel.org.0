Return-Path: <bpf+bounces-57058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C375AA50DE
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 17:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13B731BC8286
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 15:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0340A25D1F8;
	Wed, 30 Apr 2025 15:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TlxLU8k1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="L3VhU2/N"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786121DDDD
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746028430; cv=fail; b=T+uNh7jm5JD7b8Ys0X9J/OmMuGrcXEar+qMRFRNUm9sX1/DOKgYEiw8qEW+P0L+1SgLzmhwuM4HxliaIHk9JvQSG2PJqrOu6P37HH9Qut6uNYVTAJGX3tt35sRtuCKJAshqfKDQ4OM/KUWWEuVA6pLHIa9xepzGEeUeBepcpTEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746028430; c=relaxed/simple;
	bh=bmDCilixDfDY61OokoxCY+FVTLc09No5bwgp/gpCGHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Dbiz2sArSgyotEtJqwQaaw19l86JXxmbtZfXUuShaMcqzapJNtZExZIESFDcXDN6SMbT2/C+fYSUneRxjoNF1QnGmu3GvOAo6684Uof1wymjfnml9bpZ8Y7Dotw09nR0G3+jehMChXkq9bsWgCiTh1SFbhNx8aG4F8vAePkAE5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TlxLU8k1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=L3VhU2/N; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UFNGpL029628;
	Wed, 30 Apr 2025 15:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=GGA5L+KOLxrxD6EUXuheginGXZD4IGM7Ov0i/QSKZhI=; b=
	TlxLU8k1LnCTqL/+4M/fcrSDnmnXsS8uOUgs/ipTz1upf5T3UwdYaqSx0YWjqluj
	OtGSfiQko/moFWNGHuDdNDyZWjd3HxxhtVHjTO8Ne0k+zZRvMjKu5iQLTMHXQl/c
	W4t7TG0B7+l7paC5X5UXOiMqEjVZ9E4nx+qXoZ64+rtXdN45CX9FK/Ugl+PBAYTi
	NcYrbtwMX5DYpRlazfW5MqX5OFOVstCKw/toQQIpH7F/5Y6wywLFZMT3nM1Fxsgg
	vMiJxjg5XMXwpJ991k8B27lFqhd1+Va25bKb7/jp184hve4i507928lktZ2hYS6c
	A/l08LUdi2jL6LQ5znCwag==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uqhhsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 15:53:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53UFZKEt035387;
	Wed, 30 Apr 2025 15:53:13 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010021.outbound.protection.outlook.com [40.93.12.21])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxb93xk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 15:53:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2bTriWRu8AiQShbvyy/fmrwFdqZMl9xgULEluAc2ONTwDjFHmel69pDf/Y+FoS8KuNsqpartBNXCJ12gDXgSHdwt4Em1CMFNXtWFr+zzJvAd+I9cbW32KKBAfEsWoNenLzpgyUkkiov4fY0DH+0/gSaNZ4LGUx8m/PJx/FEVA0nb+H6FTaYhk+SGzRo+CNB8t1HzF65KA/xuSZ+p3dqWUxqyktnoAEOGwLbdHf8/xIvl/ROXIfXWmCMCDFtguHY6C9dIfxryi1ZBZUHdbUo+4B27Ksd79nl0g4sU0iNeiW9Dhd/XPhDK/vwFO0ItNhj2iC7GPaX+LuCA5uD6IsULw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGA5L+KOLxrxD6EUXuheginGXZD4IGM7Ov0i/QSKZhI=;
 b=QLZSC2Nh7By+RH6c2BuY59AKui/+Q2xIzCcXPqzmeYlPfJOsZcRV6cv6dYsUhXrTGM242difIEcTR+FpxKFsre/l2iUdnoBD6XozF0U6vZqHT+LT5CNl8qH33uP5/9p5SZtutZpQQqU7ZD5jP8tYb+tp6zETJqwBPHQfANTIQE3pmirwqsyL/nFceAqyEZXq8BDVaWpvbQR9sq67/xzosH4u1zxAyqEt0sXtwX11HTP/+Pt4D4IhZMYe3wl1QbGj4nysQHIKE+k9W+sJ2MSwRudz2OLxX4IeutGz8puXKyfuBvQWgqi9Hqa/xaFLWxv3NRAiEgKLmDiSpejqqccmLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGA5L+KOLxrxD6EUXuheginGXZD4IGM7Ov0i/QSKZhI=;
 b=L3VhU2/NjrYA02NwqyAEwhBpQrhGiinc02SPpMmHx37Oe8cbR9miI5GVwbShusxxHrgZYoCzTW05LF6RRzI+LOlALRFbGQ/fna5S8zA8FDD/sZZhyS6PgNCvN6xT62igBMAscMBew5dsRpCae3m9enWzONrcbphmmfWY/iz4xFo=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by PH0PR10MB5682.namprd10.prod.outlook.com (2603:10b6:510:147::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Wed, 30 Apr
 2025 15:53:10 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8699.019; Wed, 30 Apr 2025
 15:53:05 +0000
Date: Wed, 30 Apr 2025 11:53:01 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>, akpm@linux-foundation.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org,
        David Hildenbrand <david@redhat.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, bpf@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH 0/4] mm, bpf: BPF based THP adjustment
Message-ID: <ygshjrctjzzggrv5kcnn6pg4hrxikoiue5bljvqcazfioa5cij@ijfcv7r4elol>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Yafang Shao <laoar.shao@gmail.com>, Zi Yan <ziy@nvidia.com>, akpm@linux-foundation.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	David Hildenbrand <david@redhat.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@suse.com>
References: <20250429024139.34365-1-laoar.shao@gmail.com>
 <D9J7UWF1S5WH.285Y0GXSUD30W@nvidia.com>
 <CALOAHbBfSat7-qOjKseEJy=w5MVF7um3vYKPCb0VMbEgw-KAuw@mail.gmail.com>
 <42ECBC51-E695-4480-A055-36D08FE61C12@nvidia.com>
 <CALOAHbCtBB81MKV5=rTM03qt=qCF-CWctCmF0xjxDo_sXwaOYw@mail.gmail.com>
 <8F000270-A724-4536-B69E-C22701522B89@nvidia.com>
 <mnv3jjbdqx3eqrcxjrn5eeql3kpcfa6jzyjihh2cdyvrd7ldga@3cmkqwudlomh>
 <CALOAHbCNrOqqTV9gZ8PeaS1fcaQJ-CkUcwvFsx6VjHTmaTHjgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CALOAHbCNrOqqTV9gZ8PeaS1fcaQJ-CkUcwvFsx6VjHTmaTHjgQ@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0495.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::27) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|PH0PR10MB5682:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d4e00f1-b758-40fc-96f3-08dd87ff182b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0VpMm0ydS9USFdPWm1yQk04TkpZQkM3KzEvVjE1NUk0SXd1ajEwSS8zSDhP?=
 =?utf-8?B?NE1ZUEVDdHAvZjhsbm5SazZjK2hxVmczRGNqV1EvdytzMXhaMzlnVXNrd3Jz?=
 =?utf-8?B?aDlMR1lIajNwK21abkRsdFYwS3ZrWEFyNzJEblB2c2haeStwR0REUUw5YW50?=
 =?utf-8?B?N2dwN05KcEkveXVYVm9Ic2VxNFYxTW0xaEZMRnJvRm9WZVU5My90M1kyOVQ1?=
 =?utf-8?B?d2g3Q0V6TGgrRjNJQ05IVTJ1QkJJQlh4WGFoOWZRSkFTSlJNV21VSisvcG5T?=
 =?utf-8?B?NFRQanZ3Z2w3MzM0Q0hEaWNEaFhPSGgyZ0hBbGg3RlZUMEhJNFVvTEkrNnlC?=
 =?utf-8?B?Q3E0WWtMbTZWRTArNGtTSzRNREVDZndYWjQ1T2xMQThaUmhqMTkvclJhTjBW?=
 =?utf-8?B?SDlhR3VLOUMxUWMyd1JuMzZZcFh5R09ZYTVFdDJFRGFGckJYMVBRM002YXp5?=
 =?utf-8?B?UGtJb1lOR25yWE9jSUZjQVVxUEx4NlVEWjBKbHdsOS9RdDFmcUZUWVdxbExN?=
 =?utf-8?B?UStXUlMvQllCWmdKc2QxOWZ1L1c4Qmhvay92TEVmZ0gyN1lpSG93dmZaVUtE?=
 =?utf-8?B?ZDhvKy9hVmFIemVTa2oyV1VKY2NuQW9KMkY5OXFHMW1rODZIOVdkazEvbGhv?=
 =?utf-8?B?RnpjR2N4T1RMbGFnYzA4STcySm0wUGJJWXgzQjJ6Y2hNV3NpdEUzQmNhT3dI?=
 =?utf-8?B?NE02OXNQQlRRNHo2b3NLbExxRW8xc001UUZWaDRNMHJ5NExvVDJrelNGWFhp?=
 =?utf-8?B?S09NTUwwMU9NS2FuaGZTcnJ5NHVxMEJ2d2J5Z2Jpc3dPQXFoSVlXNjBzS0w2?=
 =?utf-8?B?VU5NUzBiSjFRWmZTcXI0MjVFWFRpTEhJOVdaeGRBTnBmeVdmOUZ3c3BncGdQ?=
 =?utf-8?B?WUhvRVhpa0Q5OEtUSmg4VjlrYVJCOUtPWkFmM0czbHZJWmkzQ1U3Ryt5dGFP?=
 =?utf-8?B?OGE1TTNhVTVTUVp2ZXkzYmhJQlpjVU5pT3BENmhVUXdSZlFOM1BMNk95UnRB?=
 =?utf-8?B?UUlLZEdLRjRvdG1QTW94dlNCK09nMWs3Q2psd0dZR3ZnTStpZ3RNU3BtMVBw?=
 =?utf-8?B?SjBNbVBMV0NFZ1ZlQjYrTGFCOU1YS29hSzcrQUxBcHIyRm5lYnhkWkkxMTV4?=
 =?utf-8?B?Z25kUzkxdyswdnBkb2laRkhsTngvN09QNG4xeUdSUUhuL0VUMU5Hejc0Nlc2?=
 =?utf-8?B?ZEpYaHBjaThrZU1QdlZNNmtMZUQxdkw5cWNtSG0zTmNkcW1HdjJadTFrcUlj?=
 =?utf-8?B?RXlXOVYrNXhYeWlXaHplaU1NOUdBRnd1RVBabm56KzFzNWk3dm53R2pPZkJP?=
 =?utf-8?B?NVpZMUlQNEcrQzkxRDF6bzBqRzVZZTRxL3h2UXBLUlBWZ1FDTnVEVzBlV2lL?=
 =?utf-8?B?akZSaGwrdEtPYS9lWmpWK1dqV3RnOHlGWnRvR215cHdwUGw2dVhWOG1yM05y?=
 =?utf-8?B?UFFmcC9xOXhKTSswbDNtUUxrcE5idHd1UmdMUURrYlJzVmlDOSttajRWL2pw?=
 =?utf-8?B?dnZocHQ0dzRsdFJQRkdzOXlFMTA4MGc3b29jUkxnOFp0Si90ZjUwU0R2VUZV?=
 =?utf-8?B?Tm5HaDErT1JMRmFpQjBaa1l6aTNONGhoZlpoRCtha1o5RDJTNDhVN2VDWkg2?=
 =?utf-8?B?eUNGbXRwTTlINllDK2ovOHVNc1lxc2k1M3RIMVpZVm1zcjg2R2RnbVRWNEVH?=
 =?utf-8?B?RmtGRXdSODh6RHRraFJuVCtVRWo2eWtvVzNja2xFU1N5UkwxZFdVaWNJWjlJ?=
 =?utf-8?B?MzduWGVOeEc2cjI0OU9BTVIyeWoxZE42cWdtOXQrTkdFS2thVEkrNEhFN2Nk?=
 =?utf-8?B?N1RoaC8zeFAwNnI2TGhDKy9CaWxnV056ckRDT0JKWUFUYjZRcG9zaTdPYjNR?=
 =?utf-8?B?a3VaMkk1RTh6WVFTTXo5YUswaThnZisyaWlReEszU0NzYldrMzVVNUgzd1Rh?=
 =?utf-8?Q?vJD3XV5r8So=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1EyS1pvbFRMUjdJNHErSVlkYWtYSGR3YWZ6Ymg2UTBPdmE2NHlHWXpUcDBR?=
 =?utf-8?B?MS9BeGhjazBMZlRtV3FKQk15b1NmRU1JVmx4aTViTGlpamd3ME5Bb2g1ZkVr?=
 =?utf-8?B?dTZ0cDQrWXgva2hFVlkzQXFKS05XWFFZUlRiTE9sSlBTbzB2bDBUVXJVYXJG?=
 =?utf-8?B?UnJ0ZDJYa2MrRW81MngvUEFIVGNnRDVldmx6RTRMbWhCYkJkUkQ3WHBGaGRr?=
 =?utf-8?B?eUZXNnJjK1FWV2prSzZnUHpva29LdmtSV2VuOWFrUG5aLzIwd2tZVHpScm8z?=
 =?utf-8?B?LzZCQ1Z4ZDN0NGNtZXkyK3NaUEc2NUpmdHpVd3phY2Y1SVUyb2ErY3hMaWd3?=
 =?utf-8?B?dTB0c0toRTE4TER0UGo5amZrcXhPVmdRQlRYZ0RUUXJSUERsb3NqTktuaEVL?=
 =?utf-8?B?a2wvZlNRZUc4TzlTNCtRdFJxSEpDcUZRVWQ0MkRWSS9UanpWUXhyOHBhTmZO?=
 =?utf-8?B?YnFVcXpGYXN4TTE4SzRHelRDTmZjS3B4MFk5UHVNYWNONkxDeXJYY1lWSTZ6?=
 =?utf-8?B?endRQVNSa3B4ZE9wVXJta2NaYWZ1ZWcvamNWUndKSE1KZ1Fpc1dMcXkyaDYz?=
 =?utf-8?B?MnZEZGw4akwyZUVJenoyQkJLaythZzNITFFVcG9zbWRYa3B5bXh5bllJenlO?=
 =?utf-8?B?dHI2NnpkdXBCWWYrTFpvcG95bUVldWNocGh3aXdDL0pJZVM1QnliWWptNGFr?=
 =?utf-8?B?b1JrZXJKYnk3RGhVcnlLQmJIOEVQN1Q3bFp3cjVSU2xlaU5oazFHYWpNZVFh?=
 =?utf-8?B?SEFlRlh1dTdJTXRDWUV6V2VIVEsySFVZODBYMVdNcWZ1Rk5vTWozV0ErUVp6?=
 =?utf-8?B?MmwyOEcrdnlDckYzdFlwdVdrNXBXaTFjNm4vVk9UMU9kQmlJeVRyYmZGT1ZT?=
 =?utf-8?B?TGZ1NTlUby9YRkdhbmcyT3VwOVhEL1VNM0lDS1czRmcxUUlPZUwwZzFpWEFm?=
 =?utf-8?B?eUFJN1lvWGFKQWRpaUZqd2RjM294ZG9CSWxsb0J5SDd6T2VPNGtKbnc0d3Zx?=
 =?utf-8?B?R08wVFdPYVRaZkFPblB5aHpac1ZLYnM2R3UwdUNGdUVjckF4OWoxL0dnV1I0?=
 =?utf-8?B?T005cllOY09RL3ZnTEgvT0RnWE85Vm8xY1BIaThNRWdpcC9wMkdwU0o3WE9v?=
 =?utf-8?B?ZmhLQ2VFYU02bldLd2ZIQ1ZydlB1N1piMUx0N09JQitiM2dNR0hkM3JsRGRn?=
 =?utf-8?B?RnpOUWpJbXJqalpldXdma29SQ3VzZVMrUUlaY25QeWNFS01kdVljSGh5Q0Jz?=
 =?utf-8?B?dFpJQmkyTUQ2cTdpaFhDNkdJaEtKeEJJd0dWakZFY01rRHNFVE0yV3U1NjVP?=
 =?utf-8?B?Vkk0eDI0UFNzTDlDbG5jb0M0anc3WXFkWUI5akJ6V3BHSGwyRlp0SlJxNjNN?=
 =?utf-8?B?bEdlS1dsVytGVWcxQ3ExWHBNOXhuaHBiYTRjM3RJTmZpV2ZFZFkwbWxtMmNY?=
 =?utf-8?B?ZHRRWFVjWkdYandUcm15MU1XWU82Z2tDeHM1RXllcnV0MHd3U0lpVkgwVXht?=
 =?utf-8?B?cmg5SU93Y0UxWERhL2lTd3cxUUc5ZElLTjhxWEVVTWNveVY1UXF5TmRaVkd0?=
 =?utf-8?B?cE9PZ2dPa21obkFObktWbmRwZUdFSWdZUCsrOXJUSDdEY0VRZjlSVld0ZGZi?=
 =?utf-8?B?Y09QS2orMlJsS2NFcENIa1RXNVRlbXNxM1E0bVpDWnJqaGVHQmFabTVXU280?=
 =?utf-8?B?WTFGdHUwdWhhVjNKVjVwYXJyakkyck1DVmEwNml4NDZGZ0xGNGhsbStacXlj?=
 =?utf-8?B?M0czK1NMQjgyTDJlWmlsZ2NJaHBXNmE5RzdYRFNGQm9iSnpnMmZMWXVWTnZX?=
 =?utf-8?B?ZmJWNWFXUTVrbXdoTHNrVWgrRkJnY0pQUVJTblBvbkt6bDZicW9ucE0yUlBF?=
 =?utf-8?B?VmZoZE1FbzdZOGlBTnZIRWszYmhoVlVvdjlIZ1gvQnh1SHB5RkwvelM4bzBS?=
 =?utf-8?B?Ym5ybVJnbGFnWEVJZHpwbzF2ZWJOOE9Xc1BoSlkxU3lzT01wdW0rY0ltMFdr?=
 =?utf-8?B?NlNWVmU5VTR4dXVSQVlQRExUcmc5Nm9OdzQ2MzFISUd4ZzcwVW12bFEwTVNE?=
 =?utf-8?B?TzMzYTc3VnF3TldnN1VRWkYvcGwzR2NyK3dJaVU4aTMvOFRVRmJudzFqWnlv?=
 =?utf-8?Q?JlTSfs4FviEeLMKsQdLwgytMb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SyN6XfUKvs4c+PTT38GTXqfxR7nZJ7fDodh/8lzwIyyp9J0NJt66hkhC8aUmtoD6w/mA8GR9fEdlD35JJegSc18pLBs8xwO+WAe4PKk0ej+BcC5Qrq2XTzpgSAZ+oOZNkaNqgUld5OeuZ/qwnFaNexvdy9tQfOjaK85KmSTIgrdRE9sTVHSYMQCXdBEcWcRD4hH4MV32bbLBvbDOcjosfmVt4zpTRoxY7Y9F5sMnspOLlsLL+gTANErWYhPv46FXMWUlxfy9KJXGkm81A2b9iHy0uL1CjPhb4VRkVAOIZ/tsaChdlrTcuJThkAlV6UxLG0czD8HsZhXlEDARR0fVVjA0XJXMG2F0O1tR4yoteTb0r9sE5AAgXeRvQeZmXa1Uac8CpgSEJ1G6x1MYm9eyS0KQllyPxecmljTVnI7rhqCIcZT9yIB0LATGjbj8bjoRnWP/jl+CQTNsmbZZFO/UXh/Ho3+uAeR0UUcGtbXD78tiOUEsat9i+hYkl8iV6VO/KpXNoCu9gpXgv/yxjuuPtVgHrG0g+D8E0mRluEmY/HWQUMxSdgK5d5i4MTL7QP8xn1b4EGHd75pFGoViQoSg0MeOx91wtg9cMTh8LqpAMoQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d4e00f1-b758-40fc-96f3-08dd87ff182b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 15:53:05.0060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EtGMj53GJOXi6ex9+Pg8UKfOyBkChoZns8huho5Mr8VVSILG6+BZM04fPBZyQ5b0quse1RQrDhzqYHJq3CdAew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5682
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504300113
X-Proofpoint-ORIG-GUID: Mfs4oRSfYTPr8aPPMKlOO9n0FVcXYOgJ
X-Authority-Analysis: v=2.4 cv=Vq8jA/2n c=1 sm=1 tr=0 ts=6812476a b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=XzwWPLk4AAAA:8 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=Ikd4Dj_1AAAA:8 a=6DVhuVspQXVqjtl0eOMA:9 a=QEXdDO2ut3YA:10
 a=eD7Ax5M-l9OxXO5vTfaj:22 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:14638
X-Proofpoint-GUID: Mfs4oRSfYTPr8aPPMKlOO9n0FVcXYOgJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDExMyBTYWx0ZWRfX0fEfCWijMlVP 2ZgRth2TS9yVRxg9g8WthBqSi97vhG2UaxLQh65sYuJbNlxEe8w9sWmmTJfrUF7yq0ckLBFi3TT MFYJ3wTxB+f3fWu4ft5wtCob13CVvlbTerJkWYAoj9Vf693YInVOmDy3qxuOsnCVaKGb1jNZT8I
 amC24DNyNBVcmZzlx9mQ2+EqAIE5wugcR6Gj/ZhcUv/gLdTZ6iZFm7MobCbctb6mohs3x943rIk ISOGDBY+P7Mzy0K2GrjW0P4SyINC4+tQU2w/8vdL/V+rHSFdltkZO4ZSf21DYsthGRNOkLmPEKG AZ5EGHhdwpnxfNTk5kWyZm6Yh2nnuRK0lvuLT4vobCKKsDxsyW7ncv3DaKVE5auwYTMjfuPFGc+
 UWr+TDB7j5Olmqzjg7+aNd+60EpNQX8vgTHe71b+RYCx4cQsGL84w9AZMtsneaR+232oPCry

* Yafang Shao <laoar.shao@gmail.com> [250430 11:37]:
> On Wed, Apr 30, 2025 at 11:21=E2=80=AFPM Liam R. Howlett
> <Liam.Howlett@oracle.com> wrote:
> >
> > * Zi Yan <ziy@nvidia.com> [250430 11:01]:
> >
> > ...
> >
> > > >>>>> Since multiple services run on a single host in a containerized=
 environment,
> > > >>>>> enabling THP globally is not ideal. Previously, we set THP to m=
advise,
> > > >>>>> allowing selected services to opt in via MADV_HUGEPAGE. However=
, this
> > > >>>>> approach had limitation:
> > > >>>>>
> > > >>>>> - Some services inadvertently used madvise(MADV_HUGEPAGE) throu=
gh
> > > >>>>>   third-party libraries, bypassing our restrictions.
> > > >>>>
> > > >>>> Basically, you want more precise control of THP enablement and t=
he
> > > >>>> ability of overriding madvise() from userspace.
> > > >>>>
> > > >>>> In terms of overriding madvise(), do you have any concrete examp=
le of
> > > >>>> these third-party libraries? madvise() users are supposed to kno=
w what
> > > >>>> they are doing, so I wonder why they are causing trouble in your
> > > >>>> environment.
> > > >>>
> > > >>> To my knowledge, jemalloc [0] supports THP.
> > > >>> Applications using jemalloc typically rely on its default
> > > >>> configurations rather than explicitly enabling or disabling THP. =
If
> > > >>> the system is configured with THP=3Dmadvise, these applications m=
ay
> > > >>> automatically leverage THP where appropriate
> > > >>>
> > > >>> [0]. https://github.com/jemalloc/jemalloc
> > > >>
> > > >> It sounds like a userspace issue. For jemalloc, if applications re=
quire
> > > >> it, can't you replace the jemalloc with a one compiled with --disa=
ble-thp
> > > >> to work around the issue?
> > > >
> > > > That=E2=80=99s not the issue this patchset is trying to address or =
work
> > > > around. I believe we should focus on the actual problem it's meant =
to
> > > > solve.
> > > >
> > > > By the way, you might not raise this question if you were managing =
a
> > > > large fleet of servers. We're a platform provider, but we don=E2=80=
=99t
> > > > maintain all the packages ourselves. Users make their own choices
> > > > based on their specific requirements. It's not a feasible solution =
for
> > > > us to develop and maintain every package.
> > >
> > > Basically, user wants to use THP, but as a service provider, you thin=
k
> > > differently, so want to override userspace choice. Am I getting it ri=
ght?
> >
> > Who is the platform provider in question?  It makes me uneasy to have
> > such claims from an @gmail account with current world events..
>=20
> It=E2=80=99s a small company based in China, called PDD=E2=80=94if that i=
nformation is helpful.

Thanks.

>=20
> >
> > ...
> >
> > > >>>
> > > >>> I chose not to include this in the self-tests to avoid the comple=
xity
> > > >>> of setting up cgroups for testing purposes. However, in patch #4 =
of
> > > >>> this series, I've included a simpler example demonstrating task-l=
evel
> > > >>> control.
> > > >>
> > > >> For task-level control, why not using prctl(PR_SET_THP_DISABLE)?
> > > >
> > > > You=E2=80=99ll need to modify the user-space code=E2=80=94and again=
, this likely
> > > > wouldn=E2=80=99t be a concern if you were managing a large fleet of=
 servers.
> > > >
> > > >>
> > > >>> For service-level control, we could potentially utilize BPF task =
local
> > > >>> storage as an alternative approach.
> > > >>
> > > >> +cgroup people
> > > >>
> > > >> For service-level control, there was a proposal of adding cgroup b=
ased
> > > >> THP control[1]. You might need a strong use case to convince peopl=
e.
> > > >>
> > > >> [1] https://lore.kernel.org/linux-mm/20241030083311.965933-1-gutie=
rrez.asier@huawei-partners.com/
> > > >
> > > > Thanks for the reference. I've reviewed the related discussion, and=
 if
> > > > I understand correctly, the proposal was rejected by the maintainer=
s.
> >
> > More of the point is why it was rejected.  Why is your motive different=
?
> >
> > >
> > > I wonder why your approach is better than the cgroup based THP contro=
l proposal.
> >
> > I think Matthew's response in that thread is pretty clear and still
> > relevant.
>=20
> Are you refering
> https://lore.kernel.org/linux-mm/ZyT7QebITxOKNi_c@casper.infradead.org/
>  or https://lore.kernel.org/linux-mm/ZyIxRExcJvKKv4JW@casper.infradead.or=
g/
> ?
>=20
> If it=E2=80=99s the latter, then this patchset aims to make sysadmins' li=
ves easier.

Both, really.  Your patch gives the sysadm another knob to turn and know
when to turn it.  Matthew is suggesting we should know when to do the
right thing and avoid a knob in the first place.

>=20
> > If it isn't, can you state why?
> >
> > The main difference is that you are saying it's in a container that you
> > don't control.  Your plan is to violate the control the internal
> > applications have over THP because you know better.  I'm not sure how
> > people might feel about you messing with workloads,
>=20
> It=E2=80=99s not a mess. They have the option to deploy their services on
> dedicated servers, but they would need to pay more for that choice.
> This is a two-way decision.

This implies you want a container-level way of controlling the setting
and not a system service-level?  I guess I find the wording of the
problem statement unclear.

>=20
> > but beyond that, you
> > are fundamentally fixing things at a sysadmin level because programmers
> > have made errors.
>=20
> No, they=E2=80=99re not making mistakes=E2=80=94they simply focus on the
> implementation details of their own services and don=E2=80=99t find it
> worthwhile to dive into kernel internals. Their services run perfectly
> well with or without THP.
>=20
> > You state as much in the cover letter, yes?
>=20
> I=E2=80=99ll try to explain it in more detail in the next version if that
> would be helpful.

Yes, I think so.

Thanks,
Liam

