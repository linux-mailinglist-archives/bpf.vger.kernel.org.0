Return-Path: <bpf+bounces-61512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 311E7AE81B9
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 13:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 133CE6A0881
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 11:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4921F25B313;
	Wed, 25 Jun 2025 11:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ecWOvBX6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vTUTqIok"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C579307487
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 11:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750851550; cv=fail; b=CjQ946SJ7pmNz1qesrf0VR//V1EwS8B92QM7ik8JbCsq2MSB1vf/2LZIWUImg7C800/zA5R0ur6f5sllb871pqwBu4ky21/Bwu3RTkYg65WRPEctfzyOr108vkMhgA7aeQSKbnErFZZairzNgYtNwfzp32TzjAZBSGPKH4/tBkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750851550; c=relaxed/simple;
	bh=1Y/hh/65wKxhD6ohMYmLcetWl6Z9o79cbi/d/6c/j30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R10nlqPVJcKSeY+zqUKLJN1BIQefE9j7XANltZQCagJIlAPncDff4TNiBu6kK/j+OnZOY3xhJElYibJvYY6JPXfEv9YkKzN1aAQImlBXobGR/cUZtLDi0JZtcZFS0CUuSNnNrQVHewDwB4HtllfseBShKQXDYq+tjU6OoeVsLzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ecWOvBX6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vTUTqIok; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PArGEP004737;
	Wed, 25 Jun 2025 11:38:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=8BU7RiBbQuoh4SrXL5QDLAANFdsrjVf/JLlSkKjO7sw=; b=
	ecWOvBX6SwoxuLE3G9GB5wD9bRXxVVA7CzRKSgk/BO4zgj8jQJXLyTquSwPpO0gY
	JV9/wfPIARsonJIWgJsUcaEmBo3A/wWmR8vEQ6UPCqI9KwiuqXmfo/9i+2IcM5iC
	waKdZ4UW+gdUgRncjqV+B+SGtCKDqlMC+XfTQbxQfbQzH3wo5aITtaJwlL08ZY3X
	gBAznwR4N5Yb2kSr2Qalx2FdJAbVe/2RrGgVcpQp6asinoHsVQHp1RE4JeE20W9L
	F55AxrpY7tUO58JyyKaxLGADEqqDQCzwhgI7hNGlzK+O/nMdzm7dQ2Y7+1qq/Y97
	kFJ6xWoDbaifNy78LlfsdQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt1e3cn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Jun 2025 11:38:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55PB5WX6013383;
	Wed, 25 Jun 2025 11:38:37 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehvxf40p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Jun 2025 11:38:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HzVSyVpFP8Nm04LJg+IXu3h4SkBgu0WWZZesf7WHpOHlkXiQHqRWawPhtxkTy8rf06h+avstLiPJVAvl6lYF/AE8WXXW5OWXSc7JWJk4GmjamcaTbZZt/eSwO9K0BRGxUUab0U2/mWqJAvAh738LHl14OeM9yxQrFLCOLMqRoV/mYw5ATCaZgQ79Jknvzun683zYpA6Ey+c0lAMGODD1Hybozb0GykGd4IEYtWktx1OefvvD0PNHlxoTdrJkgE01QQUHMcnUUEtQWGwwqwAM1NRC/Ua9z0CM53dxkgSBm5YGlqbRUs74rJk2VMZ/MI4/dX0nyV0woli3X0e8rxz6cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BU7RiBbQuoh4SrXL5QDLAANFdsrjVf/JLlSkKjO7sw=;
 b=jccnYUVwZe7ttafgenEbp7jDUWYvIzhc33OeRfV7piQm9SvpVgVSYg5/O40c8mkr9qOMCBMns0pj+QNvF84brEJaHURMzL/YCSgmflEEORcmYc6PmxakT/yjiuxAhFWbYyDnr+axoqZDby7phBx9OX1eNWbm3YD1AeHklLl2UNy3gzjRQWylEDlHNV/ncSmOnQlzomlZ81n/9rumkHdl6ThXDhgtRerwEhvPKUA3D1hGO729dEPSzvPx4Y24H4Rxko9HOayl9IQ//bz/MxqHFeX4R8HYLedj1oynRWCurQ/8B0pgZ6XtBrA4n7A9yQnLoJJWeKqyXrAvRw7GqOM4Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BU7RiBbQuoh4SrXL5QDLAANFdsrjVf/JLlSkKjO7sw=;
 b=vTUTqIokqdGUGe5s57ygn5qlaa/+DxuMMVOCXLcJIpWPFupWbSIP6sxp1c8RgVzDRrvkGD1vbUJaRlwUcJxWBITKK36bP4Ok2U3qMR14dj573UV6A7iOYR2//bkIweZPgKZjn4hovHsS9y/QeFiEyerhxTCNOIj8IgP1QSxJ+c0=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by BLAPR10MB5123.namprd10.prod.outlook.com (2603:10b6:208:333::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Wed, 25 Jun
 2025 11:38:34 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8857.025; Wed, 25 Jun 2025
 11:38:34 +0000
Date: Wed, 25 Jun 2025 20:38:23 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@suse.com>,
        Sebastian Sewior <bigeasy@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: SLAB_NO_CMPXCHG was:: [PATCH 6/6] slab: Introduce
 kmalloc_nolock() and kfree_nolock().
Message-ID: <aFvfr1KiNrLofavW@hyeyoo>
References: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
 <20250501032718.65476-7-alexei.starovoitov@gmail.com>
 <aB1UVkKSeJWEGECq@hyeyoo>
 <CAADnVQKQ-kqpO_vkyDcaUdvrvntWjwUfDy00SOawuRMrx0rfzw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKQ-kqpO_vkyDcaUdvrvntWjwUfDy00SOawuRMrx0rfzw@mail.gmail.com>
X-ClientProxiedBy: SL2P216CA0223.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:18::6) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|BLAPR10MB5123:EE_
X-MS-Office365-Filtering-Correlation-Id: bf9d153c-6e2e-4f26-f25e-08ddb3dcd177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cCtWNGdKYjF6a3hBNGpFVmt5ZHIwY0VTc0hOSmdzR0FjOEVEUytjL0R2NDdp?=
 =?utf-8?B?M0tzNTlOc3Vid0xwbUVWdS8wZitqVCtxVUxoSDZteG5iZzN5OU9JRU9YVzhl?=
 =?utf-8?B?cGFmcTJ1cm9MT0FzRDRVbTU5MmJWRDVqZ3RhN2o3d3pFSG5iSm1KdWFTYUNz?=
 =?utf-8?B?aVFId0RycTV2OXF0cGdvMGtpV0ZCdWxUVFNUMnUzWngxQmtXU0M2b1N4VzZR?=
 =?utf-8?B?cDJFbHhkNzJFaTgrWUpYdzNHYmluYk5GMS9yckZ0VHErM28zbzFPbTFBTEx1?=
 =?utf-8?B?UXNSYXp1N05RbTlqeG92WThnc0hLV2Q3a3l1cUw1ZG9wako5R2E4Y3l5K2w3?=
 =?utf-8?B?KzdHOVZQb2xwa2ZFNTB3NmFFUzlMZnJCeTFRUGhGWXkzaFVqb0xKcWVGcmJD?=
 =?utf-8?B?cGtwOEdPS2Y4d0pPeEJZZ3VtSU1tcDBqL0c4bGR5VGVYZC9EcDcwZ0lnd2pz?=
 =?utf-8?B?cnFUdXI4NFRnSEtLaE1zSXcwbHRlSDlqV1dMM2FWWlhqQWEza29PVmw2QnAy?=
 =?utf-8?B?cG4yMXJhODU1RkhWOHBMWE1KbVd1NXZMNm1FRFd6bFBVZDhXaHBQSUh5cmN3?=
 =?utf-8?B?dnFabXJSdEY1RjM5Tklpbkk3Z3ZuYTk2cWZQY3l5elRySUREZ2hWVThVanRv?=
 =?utf-8?B?RmQrS0RaRW8xVTJSZ1FYOXdIaUt6V0pnK3dBallVd1V0V015ckR0RlVPbjhN?=
 =?utf-8?B?ZjZqelRSNmJnVnhOUmRFQWM1R3pqYVU4T0pEd1VVUjBDN2hna2hWNGJWUW1M?=
 =?utf-8?B?bGFZS0Fvd0ZERllDSEJORVFPZVdCL0d1elJOWVNLbktWRWxHaE8vRmx3dDlJ?=
 =?utf-8?B?TlpKbnk3U3hjZ2dhM2pjSGlpQnNScURORlVQNGVDTE1yMkRoR3F4RFRpM1lM?=
 =?utf-8?B?Qm9HZWpSU0ZSZTZUL1BrQjRQdkV2QXVydExRbzB3TUdHNUdzc203U0VOTnNP?=
 =?utf-8?B?bzVuSnRldmhFODhGN3drdExGOE1iOW5GQjRIQTdEMnEyT2pzRDNCQjJjU3F2?=
 =?utf-8?B?SUQxNzBWRFRoMUwwSGJXc3d5aGpzTThhRDlRQjJWdTBRcmM5bjkxRWxIejhO?=
 =?utf-8?B?TUNQUmEvOEhsUUl0YW9yd1d3aUwzck5naCt3Rkp5R1lQL0k0c3ZvcWFhelJr?=
 =?utf-8?B?clNJMmV2K3d3ekVTYXFQREViUEhqZDNZanhtOGFNLysrL043Sk8wK0c2c0My?=
 =?utf-8?B?SXNTRU5PR1FkY05vWnZiYXNneGpSTDhwRnFKZWwrN3hzdEJHblZ2YlJSeUZ2?=
 =?utf-8?B?U01tOEpHNDJnU21ZemV3K1cydGlFazl2aDEvUitRVzJOV2RrZ2VMNVNiMUxP?=
 =?utf-8?B?V0UxRDJDRnVXWVI2U3p5aHVqcWN0TitJbzNVakhkS3Q4ZU1UczVMV0NTTTNl?=
 =?utf-8?B?RXJHN1RHVlc0N253ZVl4ZVpZc3ZSTUFUMVNGNEwxait2U25VOEdZeXQyK0l0?=
 =?utf-8?B?Sk5ob2t5WHRXMFVGU3hMNkdVSWdtVlVBWFdWdHVNQ2VKMGZLV2p4OGI4cFhD?=
 =?utf-8?B?MVJLa2w3ZllqOTJ5YnJFV1JpUWEwb2JqSlplazB5THdwK3B2U0N5N2JGQUJY?=
 =?utf-8?B?Y2NBeWw1dWNJNFpvUmZhZHJCZG5xMVF6ZFlNZjAwcUJTaUtjTlFtYi9EZ2Rt?=
 =?utf-8?B?dHZUckZoRnEzRngzSENibWRxc1p6SFBHZkJWWVYvUmxYZzFxa0NvRzB4aUd4?=
 =?utf-8?B?Tm1NTTAvM0tBQlYxLzZpMDVhV0ZIVjZsSTRTQ1RxVGxYeDNkRElyQzJqS25t?=
 =?utf-8?B?ZTkrMmZzVDJlcVRNcWV5dXNWVllzTGFMQ0tsc3I0djNETHFzNm4raDV2MWtR?=
 =?utf-8?B?UkVZeWlSdFdCQVNkeFEyaFBSeTdVazg4QTVMcWQxSlNLdUdtMmlBUis2MzFs?=
 =?utf-8?B?cFNycDZIeVlUUUVxOWNpYnNPN0d0d3puSGtVQm5LTjJGTmY2ZVFFdHZhOFJD?=
 =?utf-8?Q?GEQly822+fs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHZMREVjMUsrZWFzaTB2ZmY3MVA0V3ZOYyt4bFFXRHlEbGtwaEFnc0VjOStt?=
 =?utf-8?B?RHIxU3kxSHlUZGRqL0lRbnd0MkY1THphV0Z3QTlmb3B0VWdiSXE2b3Q3U0ww?=
 =?utf-8?B?YUI4MWF6N2Jpdlc5WnE1NHdzZGhiYVhvVUZjVmNuOERVSElxVFFXdDN3WC9F?=
 =?utf-8?B?NzFtOEFKUlNmNmh1cmx5bnFVTWo4Z3ZTNGxTTjRXdStLMFpqRllFRzFtV01u?=
 =?utf-8?B?L2N4QWZ1LzF1VS9LNjZveThNRzdpd3lxNmpnYmZSSDBNbEo1Unp3bWlORjI2?=
 =?utf-8?B?ZERmTjE2K2F4cGd1WW9KUXFKTXJIL0ZGcUlSWUlWbjA3QUZIcnRTQzByOE4v?=
 =?utf-8?B?SVduWUJWd251cW4xTXNPK3ZHSHAwTURUNXJ5L0QyK2Z2UVJyQk1RbmVCbSs4?=
 =?utf-8?B?b0cwWGFEOTQvQ3Y4TlRjRCtqTXd1djZ3T0tlcWtsWjFsdEEwQyswQ1UxRTRH?=
 =?utf-8?B?cmZBQ1UreHR5YjFLQVg3T0dwMzduU3plWEtHT1EyUis1WnZHWFRMVEhZdjJm?=
 =?utf-8?B?VWp3YWNhZjJjOFM2NVZGWGVPbFdLQnFyNDNNMG8xbTdKaEZFa2sxanVTVjM3?=
 =?utf-8?B?U2pKQXZqdVBrZ25mTkxEMjhDZGRiL1pXdGxKWGlrK2RtSm1JcEUzSnVvQUlr?=
 =?utf-8?B?MW83blhpUFJxcUQxSkFUcnRQcDgxbi9xdndkQlFzOUZIaVI3a3ZkMjAvVUor?=
 =?utf-8?B?WEZCcVRYZFd4OEVZSkFXdzBoU2J1UjZRQ3djKzUwRmxaTm1HbDlNcmZVZmFB?=
 =?utf-8?B?Mi9vWlFFQjJ2alpoLytYRTZHTW8wNHJrMVlVNmdVRlJ3K2wveE9NcyttTUNE?=
 =?utf-8?B?Vmo0bEphY1A3MTVlZldpK242UWFKTDZLVmxzR3Njby85Yk9lMkNBdzNRN2JX?=
 =?utf-8?B?ai8wdjB4eXVEcjllNEUySXk0Tm9VMCtQY1NnOW9WYldVYzBQR3E2TUtlMjFJ?=
 =?utf-8?B?VnR6RU1VTmdKSXYwOWhSQ3RnKzhVdjBXUnM3cWcySkd0NGFiOE8rMmxWRG9x?=
 =?utf-8?B?OWFGUnRqNDF0YWR1ZnluV3Z1WUwvdkVLREFna0huM2xCTFRzQmxqK1ozUnlM?=
 =?utf-8?B?aThZUy9Kcmhwc2M4bFc4YXJwWG9yOE1HL0VGQVRkd2ZOa2R5SkF0eExINlpa?=
 =?utf-8?B?djJIYTl4b0F5OWovUWxZY3N2Qit1SXFscjB5L3FERGZ0YVY1dytpN0U0bG5y?=
 =?utf-8?B?blZZU0RDZnk0Ty9tU3RuQlh3SVdlSTI2VkYyRXp2S0JKSTErOVNnS1BTc0Fq?=
 =?utf-8?B?ZDdUTVBwRkloN0lQTmdPMUtpSFQ1eTF4M2ZIaWpnSmRrMjJ3S25FUllxTGNi?=
 =?utf-8?B?WVpDaVFnRFNXYWFmQkdpVXQvWXlLUjRoR0tXRXVYL0xTWFppSkoydGtnaE5G?=
 =?utf-8?B?U1VZckV4MFJtY0FXUE0ySDFEOVlqdjdFYWF3WkhWZzdEbjhwM0lKMGpPc0lP?=
 =?utf-8?B?bHNVYVZ2NUJya25XRDllWHRPVWx2RzZPaFVDTkRlTHY4SGFoVWkrTFNlSENi?=
 =?utf-8?B?bUZmKys4ckJzRURTMUV3WGpGNDNDQWNBUjB4dHRHRjFheHVuL3phR1JuSDZw?=
 =?utf-8?B?b1VSWVhFNGZVNzNINDdmRGNMVkJNd1hreE5OdjVUQ3ZpcjA4LytsREttOFNV?=
 =?utf-8?B?TElLdDlZSGZKWVZzNTZidkpaL093MDNYODlYeGh6MWFRZ3NqUDJSK2FNWklu?=
 =?utf-8?B?NCsxSlZkUG10UFFBWnd1dE9OZk9PUmM3dXM0U29mWVdrSkNlM2hib2dOVXlm?=
 =?utf-8?B?cmtobjQ4eVJad2NrTHN4L0J2KzRDdnNxWCs2MnF6YVlXUnJmWlduNlpmRG8x?=
 =?utf-8?B?NjNQemU1cVZqbFNlN2djRjlJTVIzZFNOdkZ1b2RKODVMcUZMRkFQTVNwQUR2?=
 =?utf-8?B?bEVZT2dtTkxDVldITGRSYjlrRExycGdTYlNyUTVkL0VoMXZFay9oZDFrQ0V6?=
 =?utf-8?B?NDdOYmN1MlJuVkFUOHA0ZkhMQTlGdTNhUEpkTENxZ25aVTNCOWJHRGZBaTNo?=
 =?utf-8?B?WGdRN2FWWmM4WXhOcysvdEx5azkyMXdqdXJSK0JBbDZqb09xT21NdmExbkxE?=
 =?utf-8?B?OG1OaVlxY21XNldBSVNRRGJiUStmSXphS2VUNjVFM3ZJQ3V6U1hMcS9Jc1lG?=
 =?utf-8?Q?pYvl9nMNsoVzZrdNW2iBeaj5i?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+sVXs8CZ90jko2P9AnEdWMwSLKE1l2l0RKsWFTE+IN5QZs7GQ0JDHoiGW300/cY2FYttZ/hqNK3qwSQ8ECtPWjbenN28Nmh8d89ibueEWFyJCIyLAziakwLMaVdB515mz3gUml72BNDd0GoupvLrDaUzOB8zztLubZxnulkUz3T4It14wGr5cFb7BB6SYUa9E7FS+vP3Y2Wph4o52ed1IU9fJOkmWEscfN43UlXNFCcseO60ztoCCDCw1hnu6I5PtifE9fy5fHvje+IHjsagDVzZB9U771YZP+F7nuytdm8oND08J74TqytRsfZHZ4uJLGvrWwFl3YIm747yBklcNuMSxgAYLkCZ8SMvzrj+1t420CYOZgFaxU6/UEufhBFtjpdjbv94JHuFp6FC4M10uJE06amqQDOoO5oVf2dfpXBZpvMc/0IiSFx4BmzHBiwcNaXwOfuvCQEVlCGrAhCyFvnlPgBoGj1lNvLVbBhtZfSlwMoTBL+jYs7aIKA/Yf+yN+wHJyVmvKP05+IUt+gtFO/ZgV8C07zc5MEey+BrtQR4r/iCJXYkpRWGdqgGFES+ssqU2VS9qztcESv4+QlNVX0MA/kuASzEJsqxOkisTik=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9d153c-6e2e-4f26-f25e-08ddb3dcd177
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 11:38:34.6520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fh8fyK2xZW+7+QdDzYG5+6fx3u5sNfcAxr0SqowDHWwywtenObZN76Asu+bSBjBqjir/uvsKHBvxahH+zKDT3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5123
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_03,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506250087
X-Proofpoint-GUID: AvSaZQCTIVO-wGbD0qPtovOgGFWprgz-
X-Proofpoint-ORIG-GUID: AvSaZQCTIVO-wGbD0qPtovOgGFWprgz-
X-Authority-Analysis: v=2.4 cv=cpebk04i c=1 sm=1 tr=0 ts=685bdfbe b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=vnjeP7hQ0c_AjKHtDUAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14723
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA4NyBTYWx0ZWRfXyQ0SvuiZq/0r FHeOrz8vOs1680pg+Z7JEyhzowJQyoe0s3zkebPnX0KBs2M39bU5d+ed5mMlj0GxFpC185cvnTh +YY4CC1STVN5FK4VoJXapyXyE+XWQuYDOhYsMbPzu2NSbSe3ihl89ef1vvSrPIMfoJjsXI7pPxA
 kE1DvXe0d0zDhPdn+vdjyXa/vziZFcQl97BH1Ab5F5CO5M1/EVPfSmhJuHbKnaoeXVTTiv2D0M+ ShH6N8MX6FTqE/SjK1oB8ghANN/sDv0K1Is8VQ6QKKQQzTdfyPoVfebj65kyOwBfGyQwELbThxo 7s8J+Jy37dVfrkFuWqX/b7fgQdhIf4Qh+10iHIC3WVh0xV3xNoWF6IeTldtRSTPVNgDM5shYSIb
 NyACRzuB2TJ7B7atGeO1KZYog9gbYSZXDN6aAIUf+s+Ln4c7Qgvh7Y4J+WtK104rbw0kpz0y

On Tue, Jun 24, 2025 at 10:13:49AM -0700, Alexei Starovoitov wrote:
> On Thu, May 8, 2025 at 6:03 PM Harry Yoo <harry.yoo@oracle.com> wrote:
> > > +     s = kmalloc_slab(size, NULL, alloc_gfp, _RET_IP_);
> > > +
> > > +     if (!(s->flags & __CMPXCHG_DOUBLE))
> > > +             /*
> > > +              * kmalloc_nolock() is not supported on architectures that
> > > +              * don't implement cmpxchg16b.
> > > +              */
> > > +             return NULL;
> >
> > Hmm when someone uses slab debugging flags (e.g., passing boot
> > parameter slab_debug=FPZ as a hardening option on production [1], or
> > just for debugging), __CMPXCHG_DOUBLE is not set even when the arch
> > supports it.
> >
> > Is it okay to fail all kmalloc_nolock() calls in such cases?
> 
> I studied the code and the git history.
> Looks like slub doesn't have to disable cmpxchg mode when slab_debug is on.

A slight correction; Debug caches do not use cmpxchg mode at all by
design. If a future change enables cmpxchg mode for them, it will cause
the same consistency issue.

> The commit 41bec7c33f37 ("mm/slub: remove slab_lock() usage for debug
> operations")
> removed slab_lock from debug validation checks.

An excellent point!

Yes, SLUB does not maintain cpu slab and percpu partial slabs on
debug caches. Alloc/free is done under n->list_lock, so no need for
cmpxchg double and slab_lock() at all :)

> So right now slab_lock() only serializes slab->freelist/counter update.
> It's still necessary on arch-s that don't have cmpxchg, but that's it.
> Only __update_freelist_slow() is using it.

Yes.

> The comment next to SLAB_NO_CMPXCHG is obsolete as well.
> It's been there since days that slab_lock() was taken during
> consistency checks.

Yes.

> I think the following diff is appropriate:
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 044e43ee3373..9d615cfd1b6f 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -286,14 +286,6 @@ static inline bool
> kmem_cache_has_cpu_partial(struct kmem_cache *s)
>  #define DEBUG_DEFAULT_FLAGS (SLAB_CONSISTENCY_CHECKS | SLAB_RED_ZONE | \
>                                 SLAB_POISON | SLAB_STORE_USER)
> 
> -/*
> - * These debug flags cannot use CMPXCHG because there might be consistency
> - * issues when checking or reading debug information
> - */
> -#define SLAB_NO_CMPXCHG (SLAB_CONSISTENCY_CHECKS | SLAB_STORE_USER | \
> -                               SLAB_TRACE)
> -
> -
>
>  /*
>   * Debugging flags that require metadata to be stored in the slab.  These get
>   * disabled when slab_debug=O is used and a cache's min order increases with
> @@ -6654,7 +6646,7 @@ int do_kmem_cache_create(struct kmem_cache *s,
> const char *name,
>         }
> 
>  #ifdef system_has_freelist_aba
> -       if (system_has_freelist_aba() && !(s->flags & SLAB_NO_CMPXCHG)) {
> +       if (system_has_freelist_aba()) {
>                 /* Enable fast mode */
>                 s->flags |= __CMPXCHG_DOUBLE;
>         }
> 
> It survived my stress tests.
> Thoughts?

Perhaps it's better to change the condition in
kmalloc_nolock_noprof() from;

    if (!(s->flags & __CMPXCHG_DOUBLE))
        return NULL;

to;

    if (!(s->flags & __CMPXCHG_DOUBLE) && !kmem_cache_debug(s))
        return NULL;

Because debug caches do not use cmpxchg double (and that's why
it survived your test), it is not accurate to set __CMPXCHG_DOUBLE.

And it'll get into trouble anyway if debug caches use cmpxchg double.

-- 
Cheers,
Harry / Hyeonggon

