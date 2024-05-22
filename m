Return-Path: <bpf+bounces-30306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F0D8CC4CA
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 18:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B05F281191
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 16:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0FE12E1F1;
	Wed, 22 May 2024 16:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M/db1B5H";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yGR4ELRY"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F8942AB9
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 16:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716394624; cv=fail; b=enisJ3d6hiysiBqS18wbOpV89j2QLvgtwBCSFW7lQC01tGGLqMIhzoldMgR38b2dDP41s9xScPMum7i4YSL5wyy96hUu4Qb5q4i1qvfIbKc0rQEWTJhchOTXYt+hLLuOH/r1WbqSB+w6rmj+45JgAPUtaJp/pd+RgpPj7vigZwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716394624; c=relaxed/simple;
	bh=ysWBT4yub8V8WvOtSwSytc88iekRgEPLIg15zCVKjqs=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U219f6mvhjVCHHIZFs/F8ZUI+ee8RmFrbRbY8hCGjnnI7eBXtNM2tGBT6491T71XPpR8UWJpHc1Fuii2mCfrwaD9hI26KrxXM0Y7oAsPoSipoBM3UVRy2H21B4Rq0v0bcsFhFSCUTiCc6/N9RESCw0XJRcXRraItzn/97NcDHEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M/db1B5H; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yGR4ELRY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44MEmopd004289;
	Wed, 22 May 2024 16:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=C6Ax8QkXZmRKb5RlAD7yBPDOhUD6oyM2piI4+Lozgrs=;
 b=M/db1B5H8+hn1lBhm4w0b2vKR4F8bwBT9yPa7vTjjUcN7AdtvvFN9iNaS3+UqpZs64ZO
 4fVSZSdtZTHbawvNVEpeEbEWyFQb5xuxnTmMHsklXJVpWOJvxn+KGJdXmG+zN3eKe3Hf
 E713f0+O+Ia7dJ2ETR9E/dOz+a2gTcMb3XdfdNDXepeXzt0Atm1GKBncH4kK9JDyi5oN
 Y/vZn43RvAjLWG+S+OhGVtOM29/s0yIM6TWizz0cyqA+xeRPPTHYNxRg9WWYIGyITsG+
 XTxv2dNzB6tYUTEBmIngI3cYJ24PF4HdBLD0Bl/mY0ueay+1fevxHFY7+FYknPnePGJm 8g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6jrer3e5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 16:16:37 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44MGFBK0002741;
	Wed, 22 May 2024 16:16:36 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js9dfw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 16:16:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+5Te9fGU6YD6KYu7TMJUGo8DwgY1m54YwxTm013esDmNafdvliFsN6bpH335TCxGdCsUDhR9WqI3VO6jHD0RLxlOPmjEVhruYug3vILJqfqzStVFov505uSc2Vb3BeNZqM9gDmQ9f77FA5MdNXHrEpscRdm361lqXAYDJ17j84//1MkKvwXpYiHdZRiVV+180YlUXljirQxtO0c7otKFkksSrGxtBr7HioVrBhOrYmLzqeLk4Y3wmhQK88SqBVkV1XGSoue0L4r+fjdWzQzEittaCG2HnT8rA/0PsKz3S5dTBdWLjrNxW646qSAjccLWNIYa6+Vx0ZyBdMXxdQA9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6Ax8QkXZmRKb5RlAD7yBPDOhUD6oyM2piI4+Lozgrs=;
 b=MZ02pjHGukuyHNEYs73mCdoozEcXiDHQvTWDfXlyjBsTD0Pf8T4ekaQG/5N66hJ2gZVAEhy0fhO3wRaU4spJLCw+xQDpKq2Fxtrt5WWLPEqViivssmosX/JklLwmzm8mRuwQ5Ef9Fkj3YU4DwbKAtVHbyZAmyNhWrs/pcT7NTH6f8fa9PScib4HfBxt783ZJ3j67eRSwXpU5JQ4v9myq3iXt1BGntmadUWsqBqwWXCm2yY6jQ7orFdEp+PHOiNTfrfA0kYXvZKcf46DAX0wmfxAi+KmwGnS8GmFAeEnbPM0L14fS70Npmc3F4BZBWQ/hZBMNjIZKN3w5H81Ig3D3xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6Ax8QkXZmRKb5RlAD7yBPDOhUD6oyM2piI4+Lozgrs=;
 b=yGR4ELRYAdEC76M+ltRtjZzSI0ZyE0FF9c20k+7AuJl2Ui0ezxL7SF+RPSkT1AIjoGRh3zcZwVj+68MeI4Rd4zKrtXekAHdbVaeA91uYbv6p/DxGVgBrU3hpMBcouK4Xks8xOZbnm28GPuIEEvLH4J23T+cH0HUIMw60jp8+6Gc=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS0PR10MB7407.namprd10.prod.outlook.com (2603:10b6:8:15c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.37; Wed, 22 May
 2024 16:16:34 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 16:16:34 +0000
Message-ID: <f97dcbd9-5bd0-4ff8-aeae-ee36bf3e12ac@oracle.com>
Date: Wed, 22 May 2024 17:16:28 +0100
User-Agent: Mozilla Thunderbird
From: Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH v4 bpf-next 00/11] bpf: support resilient split BTF
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Cc: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, houtao1@huawei.com,
        bpf@vger.kernel.org, masahiroy@kernel.org, mcgrof@kernel.org,
        nathan@kernel.org
References: <20240517102246.4070184-1-alan.maguire@oracle.com>
 <b647e0d1d225f9d21e78c6ffedb722507f42eff0.camel@gmail.com>
 <3ae296b2-402a-4e17-b874-e067c57fc091@oracle.com>
 <81bbbbad95244dd74801497414c2cdad88815f83.camel@gmail.com>
 <CAEf4BzbdoXTeTSx-1Vu+sA6MKphQq91p1TwnSkK3Yv3msa7h9Q@mail.gmail.com>
 <eda720142ac52a9bd9599f5444a2c2897255b5c4.camel@gmail.com>
 <CAEf4BzbghAqpTSfWH_v10uK4ynXqG5Nm2e-_xTWFOF=bmLqd_Q@mail.gmail.com>
Content-Language: en-GB
In-Reply-To: <CAEf4BzbghAqpTSfWH_v10uK4ynXqG5Nm2e-_xTWFOF=bmLqd_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0259.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::31) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS0PR10MB7407:EE_
X-MS-Office365-Filtering-Correlation-Id: e64dad95-6bc3-4284-761f-08dc7a7a8c7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?T1VwRnk5Y0RKT3ZKWVZkc3h4YlFRWWNBRlpNYVg4eEpsYk1UbTRpOUw5SHhK?=
 =?utf-8?B?c0ZRM252YTdtSUwrSDNuczgvb2YySG8xR0drUWVlY0hPYU1RWU8zRmdPcStL?=
 =?utf-8?B?MkxNMlEyUU9JSDJRVFZLNmZ2Si9OQ2JNSDFqQ1NrbjlXY3lFUHd1c0UwZjdi?=
 =?utf-8?B?VFBMVDhyRWJ4aUdHUUEzeUFZK0J2anlENVlsL0QzMXNwTWJ3Z2xIVVd4WElY?=
 =?utf-8?B?UVJWTDlrcy82M29PMGFPWnhkQkphVUtaTlg1anVSaEQydTB4QlVHa2FWL2F0?=
 =?utf-8?B?NXZXaEtyZVN4aGdnZDVIakRkUHdreitySEZKeWxSWWR3WHNhOXp2SmpERVRM?=
 =?utf-8?B?VjFJZ1ozTm1pTm9vb2ZRWnV6alFsK0wxR3BYVDVITTduM2Evd2FMQjE1SzJw?=
 =?utf-8?B?dTFvUEo2ZmdyaVV3TVkyMTB4QWltNDU4NHBjeUhUUmtReEM1bmR6b09rTkUr?=
 =?utf-8?B?Q2o2WktJeDBtdEE3THgyWmlZWnVoaGhCT1MrMC92Y2x6anFoaVY0TnJSajdQ?=
 =?utf-8?B?cnF3Zi9ZYWZ5eXRrMEFvVWxUdldtQVZnZ0RHZ0VBK2VMcEZsS2EyZmovcXNq?=
 =?utf-8?B?My9hT1ZKamQ0UkxlT0tIWXlaTmZHRWUwMXJJdFI1a3FyWVE3UkdCOXhrZWtF?=
 =?utf-8?B?VHZLdTVnekJxUjh0TkxvSGViUVBvOUxzSVRmdThrQWxTTkY3VEtjdXYvV1dk?=
 =?utf-8?B?TEloS243QXF5K1EzZitBRmd4VjBEaFBvT2FrNUkwQkh0M3Nod3kzcTBhWjNp?=
 =?utf-8?B?UFlYZ0lmVjVicHJGWGZzL1dHalhoS2hjMDRTRnFCc2Q4WHMvQ052bDN5RHFJ?=
 =?utf-8?B?YUxMSGpyMXNGVE8yYWpSVjlLK2ozaWhjeVVYTkozcmUzd1VrYW5kaENpRFZS?=
 =?utf-8?B?cldzbUxBbzU5VHRJMkIvRDdabTM3ZHZDWGVGVXU5TVQxKzNKcCtnMjk2dDBz?=
 =?utf-8?B?empha2c2U1ZlZUdNbjhScS9BaUl0cE5HcXp4WUdGdHRUTGtZMUQxTWpYMUhQ?=
 =?utf-8?B?K1VMNjlteUJrRXFaQ2xjRWxYNXZZMjFuTmt0eUl6YStxaWdnRTBCNTI1VERy?=
 =?utf-8?B?dFZNdG9haEtCQ2ZrczVXeFYxUXJId1p6d3o4UXpFYzJkZjhMN2RvdDhoK010?=
 =?utf-8?B?SzZXYzFEdDg0OEpuc1JOa1dIcUhxVkR6WGlFQ3RtNGMvTnczclBzYWl5ekxu?=
 =?utf-8?B?RVZqbXdEMTAzWXk0Y0NLdjMwdzJWL2dZcVp6dWhJR1ovMmxXMzRCelJXTHNa?=
 =?utf-8?B?eFZidDBmNWgyRXlrNzNoRWYwRGErczlqUWltRGtBL21jazVPejc4SVRMaW1q?=
 =?utf-8?B?MDRhTVpyTnlFUmdtSiswWDhMYTQvb3h2Ly9BL2pGRFd6THJFQkhvTkhIdWVJ?=
 =?utf-8?B?YmhqendEZjZRV0U0c0pES0Uray9ySFp3RzM4QTd2SWJQZEZONUlFMWl5TkhY?=
 =?utf-8?B?a1ZsakNnR3QvdGdhTXU5T3NBYThBQ21RVzBJeEYraXI0NFRYUkZvYjBPZnpq?=
 =?utf-8?B?MHBUSmFRZUNoU2FEUUxJNXJGelR4enp2K0xVeWQxSHk4RWJjMDlkL2xnRnJW?=
 =?utf-8?B?VysrSElYeWJ0ZGNxVnVWS1o4Qk1XOEIyajkyc3NNTThuUEIrckxTb1ovckUw?=
 =?utf-8?B?K0g3b3FZU0N0NUVFZ3cvUkRpSGU4N1lNVllNazFWNkQzZTREM0c5azE2Ri9M?=
 =?utf-8?B?bUYvZGxkSWRPQkJNUzZob051OGdsb0RoU3l2dm4vT1RoaWVQenJqRnlnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QmhjZ2EvWFdZV2VtVzROcHVscEd4MCsrVFpWU1h3YlozdnR4dnBqZXRKUjJQ?=
 =?utf-8?B?UlJGTzFHRGpUNjJiQnR3NFREQkpiYWJaZUYwV3RQK3VMeUtwSEF4akRydkYr?=
 =?utf-8?B?TDVuZWhZQ3huSDBpRGhhVjFGa0FJZjRTaE1oZHgwekpkS25lMmpneXVNbzQv?=
 =?utf-8?B?dGdXTE1FNkxRcUxJNHEvYzIrOGJXTmNyc3lDNjh6ZGVXZEZJTTFrTWtWY01D?=
 =?utf-8?B?Yi80Zk5vNk1MV1JLMVd3SUJUWG53cUFQZWhhUERZdUczY29zVm40OXEwaDI1?=
 =?utf-8?B?M05SUWJmQmthRzJKdmg3amhMYnp6SHJGQnZHOERTU2VRbUdDYXZrT1hnMW5h?=
 =?utf-8?B?Rng1b0VGd1hLU054L2F5aFU5ZDhXVmVNbmRTRkRIeWlGYnhFV0V4MXptUTl0?=
 =?utf-8?B?Qkg1VGU1NUxiblZjUGN4cjdQZlRvSFdmSkJIcERxNm12VTduY2ZScVh0aHM3?=
 =?utf-8?B?NWxqUVZFa1BOYVlvd0xUOHNhd1lUTEZHdkdZYmVGN2pnVVMxYTVkTytuVEd4?=
 =?utf-8?B?SGEyOEdicGgya3drWWhKUTZNRFhSaHFaeEpXYzdaa25BajI2V2RCYW4rYXRM?=
 =?utf-8?B?WTBja0ZWdVc0cHEvRlo4b2lBdkczdGcrOW1ST0FqQlpmSWVLSTBEV0JnSWJS?=
 =?utf-8?B?ZTdhc0ZhRVVWMzE2Sy9DYVhGUDZOd3p4YzFWVnFMYjBCM0tSRDJKN0l0V2Nq?=
 =?utf-8?B?T1I1VGgwOGJEQ3Q5aTVTYUxvSnM4WkVOY1htZzZWTjNWVHpvL3cyZTRESDdT?=
 =?utf-8?B?TS9HVmtzYnhtRmtiQ3BFZXlxdGxJblN6VzVieVdqMmFsSXpJdFIrdmR6U3c4?=
 =?utf-8?B?KzdGclo1UFJza3BDYWNNZWJLTTlaSzFPQWpOeVFobTc2ME9JeWx3N0NlT3Vk?=
 =?utf-8?B?aHJCclRIVnhRL3M3eEQyQW5mMld0ZXNqakMrdGdidktVT0xLK1pxTFNSUURy?=
 =?utf-8?B?VExMQndXL2tpeE05WlhTdUF1Z3dkc1B3anc0aVZJcmZIMHF1M0kxaHdaOGRu?=
 =?utf-8?B?UGJRdGJEK2pycXVkSWIwTGRtYmNKMkQxNVN4b3ZFUEFoZHpZcVU4bGJFeHBl?=
 =?utf-8?B?QTk3WlVSNUdTY1Z4RmkvUGNmRVJtZ09ZSWtvbFlHb3NBUzFKWnFXOWxsTFJP?=
 =?utf-8?B?ZVBlTEkvTTdUU2RMM0NiRFZoVVZZUWtmZ1RnVFNBTGM0YktCZXEvbTJVUTlk?=
 =?utf-8?B?ZFBLUjR4SXdSZkpUUFExRCtLRkVjdVc4T2pUZ3FHNTlxV3h0ZDlnbVc2SGgx?=
 =?utf-8?B?T3VuV09UcmY4MVVZazcwQzRwV1dXYndwZitHbkNKMXRuT3FZMWR6WmJZeks4?=
 =?utf-8?B?OHRUY2t1NUFKOG9UYUxPYkRNeGJNYVdiMDhlOGYxZExzN0M0VzB5UGhyaVk1?=
 =?utf-8?B?RGNvVUhBblVKbHAvSW1zY1lBdGhjdHFWdG9IakFVSEh2V1JqK0xDNEc2VnpW?=
 =?utf-8?B?UkU4dkdZeGtNc2tCTm0wY2JLNDE5NWJ3ZWJaY3pEQTFoQzRhbGFTV2ZpTzlz?=
 =?utf-8?B?bTlGckI2ZU80bnk4TlZjRHJpVmI2aEpSVjlPejAycEw4aUp0Mmx5dEFEQUtP?=
 =?utf-8?B?cGc5L0JvU0tVb2ZCOSsyRUtieW5aNXRKVlorY0NFR2xpNG9jUDZBYnJHS29m?=
 =?utf-8?B?VjJVT1grYjAvcjNOMjcwNWUxY1IzZXBmZWFNV1RtNURjajA1TTdSdGNmMm5F?=
 =?utf-8?B?cmp0WUM5QjNGL3gxK2dzUFVac0RRY1R5UGx3dENidHlYRjBobnJUYVlZcDRE?=
 =?utf-8?B?N2pxVXpnQ09pWWpQaDkrVnlDcThkVjNjNGpPK205L0lRUFdZQldMNytkd1ZZ?=
 =?utf-8?B?ek9QQ2tENTRrYzB5aC9wVXpxN2ZtOW14cTVETFFHTHYwczBBZ2NLdGljK2tF?=
 =?utf-8?B?bWg4cUNxRlZHRDlRMENWSVY4dkU1SHFmVjNWdlV3S2FFYlczcWxWeTR0UG5y?=
 =?utf-8?B?VlNJaDNWTE5UeXRYbm9ONUZkV0VhRmcxRG9XLzZYTnlLM2pOMDRkandMd3lE?=
 =?utf-8?B?SVRhNkU2enBWekloUHQ3SXoxREx2NUQ5bnNSa2JXT0xyQy9IOHVtRXorN0Y2?=
 =?utf-8?B?Ly9lVVl0MFBLNnhsdTU2L2xWbE5ielR0UDBmVmdSWUZjMDI5UWtSYWhlb0FS?=
 =?utf-8?B?R2NiaVdnU0Z3WEhrSnNwYjZMb3JSc1ROUHZjNGFYOUliNzloQ1hSV3JxR2Zj?=
 =?utf-8?Q?cSjzc8xJ5cQ6T31DERDGCGg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	iup7WM3ZBxc3YLxuCKkSzzddjFSAPKybEWZ6gzNA0hCbxVrOhUPAPXw6+L3kDbNR63e7Gd9XCeLm8mM3XqsuYDpCTbAg9w964vrLM7skyPO/bGogYL/geboCQQyiM2148bSlo7gB2Swt+2YZ/qVpKS12UXUqG9cZZfAao5IHOCRtEjT5YYg234jyW413h9kOnSD5/Eaj5F0B28euy+MHaMWA5Pplq4QNZZ220qCRIPcHqaE3pvZQlmL7CvpWowAZAtUtJBPCB20N7NP/Bf1x/MX9yqKdH93uBcY5J0cM+SW2+iiPRT33EYu726YOBeQFWDKtbCB3rCbhb7OBDOZIBUzwhwa5uTCNQ1+4EzsMIhOIfD6/iU5bdtomCrd7yvTYh4gDZyVGY6msCYeia9FAor+pWxZyj7x1b2G9Bdx5pJ7PraOz3jbzc5v7FrVVHZYCLVP9Q1tK8BeQht65lxJBUptN5IQ9B8hrcHAEPxELGF/bPtFHIPoIq8vTs6pRO/Hjzsdrg8XYfg8+o4RqfWtmoHyQaWcUpu2YVmBUuaIPBYtB+mdJhtphuR/pIHS14PvhShHGwBUC37FcHV4MU9ju8132QDt5wn4ilUZbganjMeM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e64dad95-6bc3-4284-761f-08dc7a7a8c7b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 16:16:34.3594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XqlswRIIzjXtnxYh9NbDyaObg19iOsVjdwlZWAnBKumqrzhEeFW9xJOVHYfOESAGtMmFlILFLb6ZVrXnien/Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7407
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_08,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405220110
X-Proofpoint-GUID: B9yECobgCZw1jKMe8LlCtjrnyXYi3NXt
X-Proofpoint-ORIG-GUID: B9yECobgCZw1jKMe8LlCtjrnyXYi3NXt

On 21/05/2024 23:01, Andrii Nakryiko wrote:
> On Tue, May 21, 2024 at 12:08 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>>
>> On Tue, 2024-05-21 at 11:54 -0700, Andrii Nakryiko wrote:
>>
>> [...]
>>
>>> I'm probably leaning towards not doing automatic relocations in
>>> btf__parse(), tbh. Distilled BTF is a rather special kernel-specific
>>> feature, if we need to teach resolve_btfids and bpftool to do
>>> something extra for that case (i.e., call another API for relocation,
>>> if necessary), then it's fine, doesn't seems like a problem.
>>
>> My point is that with current implementation it does not even make
>> sense to call btf__parse() for an ELF with distilled base,
>> because it would fail.
> 
> True (unless application loaded .BTF.base as stand-alone BTF first,
> but it's pretty advanced scenario)
> 
>>
>> And selecting BTF encoding based on a few retries seems like a kludge
>> if there is a simple way to check if distilled base has to be used
>> (presence of the .BTF.base section).
> 
> agreed
> 
>>
>>> Much worse is having to do some workarounds to prevent an API from
>>> doing some undesired extra steps (like in resolve_btfids not wanting a
>>> relocation). Orthogonality FTW, IMO.
>>
>> For resolve_btfids it is a bit different, imo.
>> It does want some base: for in-tree modules it wants vmlinux,
>> for out-of-tree it wants distilled base.
>> So it has to be adjusted either way.
> 
> Ok, so I read some more code and re-read your discussion w/ Alan. I
> agree with your proposal, I think it's logical (even if relocation
> does feel a bit "extra" for "parse"-like API, but ok, whatever).
> 
> I see what you are saying about resolve_btfids needing the changes
> either way, and that's true. But instead of adding (unnecessary, IMO)
> -R argument, resolve_btfids should be able to detect .BTF.base section
> presence and infer that this is distilled BTF case, and thus proceed
> with ignoring `-B <vmlinux>` argument (we can even complain that `-B
> vmlinux` is specified if distilled BTF is used, not sure.

That's a good idea; we already have ELF parsing in resolve_btfids, so as
we can detect the .BTF.base presence there easily, no need for a
parameter. I put together a quick proof-of-concept and it works well.

This simplifies things considerably; we can eliminate the bpftool
patches completely since ELF parsing does the right thing already, and
the resolve_btfids change is small, with no user interface-visible
changes there.

Thanks!

Alan

