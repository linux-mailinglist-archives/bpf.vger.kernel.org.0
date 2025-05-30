Return-Path: <bpf+bounces-59360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8D9AC94A2
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 19:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0B775056C2
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 17:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836C02367DD;
	Fri, 30 May 2025 17:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YZ/Qfnua";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MsSa/wTZ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066A42367B6;
	Fri, 30 May 2025 17:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748625689; cv=fail; b=rfI2tUIpAEaN5XLfyBzNXxefDMRv7Nxwavf/KSIWle4oWc2lcc30na+N7wOW3nN2AVlqSv5kZU+rGnMjSjtQlf0gtev9Uvmt7fclOASnXte8y5nj/HJNm9gK557iOQv61K8cy0CfmdFXkNl+02ZnBa48K5+M7odoLK6Li8dQSuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748625689; c=relaxed/simple;
	bh=FnM2tifHTlmdkLbUzDvDv7CH7+sF5IJXyKONujMi4Js=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WGFfbsKb/4qsOCUuYx5ijFbsyR6lN5AJpOXCml02Ex93EXJzK/ytWrbbi8J8ifBVJ4yv/pmYjM/P4d6w2A2lSu2H3rxEvkKZNQ7Fm+dMA/0576IqTOZ/9T1UhCIH4roP4eeCeEXOHdFjmLePlbPv8K/uAkMuPneMjv/O8OO2pBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YZ/Qfnua; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MsSa/wTZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54UGfiSA019506;
	Fri, 30 May 2025 17:20:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=TC/iBgL7AfC+pT98nOhmklOFHYvUDOuxuvoyPbWavUQ=; b=
	YZ/QfnuaOarNRdlc8wz4qQjC79Zb4G5stKHlAWl8aavrs3JPL2Dp4jcPc3AcDwgO
	Z4B60YYvLTdEXd1vxJS/CMX4uY7xDkgGG1DBL4e9pTAwYJqLnqvbi1oniHo95G2S
	ynBEN5plkGrVT5X6ImanhpkeNwQ5xULDFegdfx1SuVUrG3D14iRcPpvgYuZcTqcG
	QlDQLSuWYnzw0Nm+i0ZOJxXAvudHu/IroM5tmJS6n3t0cydJaSDrfoSWsc9MzD4a
	tb6CQF1ozu+5pRFBkEVcMJUquQL3LSPlPqB7ZklXDETAw+xNUhBk+BlNGpAujfGj
	H9PcQIJkAOt9NPoGNhJVxQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v21saj78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 May 2025 17:20:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54UGdgql020325;
	Fri, 30 May 2025 17:20:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jd9ys9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 May 2025 17:20:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pCoDnAFu13TJF/wQYu7Z/+RibupGnHoEeXljDSUGLsQs7rGqTXKhYs6IbcZCB71me/UYAWyscBBYgU2eK2gy9cmCYiX3CthGnuAMm3ET5ETu9R1YC7k5/qDb5jUlRNGW18fb5pE4DyEzLk++qPdQtCUr1Zj7jrPyDg1yxQsUx+p/ZVVue43BsCkNbdaq5Hzy3obI8hBRsoro3IXs5+Q6NGovxZi5UELT/29Qlze+AU7cAS+jzi1Mo20gYBeBAgkeo6YSvnXtY0VIeh1Ip1weowrVlGLHC6ILF3WgH2mqfpREoyj07tvj9lXI8x3G+pDPgYo+9aBSCwU9zXZ5eWlMsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TC/iBgL7AfC+pT98nOhmklOFHYvUDOuxuvoyPbWavUQ=;
 b=O+njhSo26fEWg4DRpdaPoZDPQRtCqT2sDu1BBIn/7+lvoQY0SAtgj2pZ/2loFfbZiNDzJOqwqCYeBo8eq97ejMNbNUpfKQNoCUM6AYwr7AMLOUt2WavlwsKCH8q3MkZkgS5b6InMpjg1vapUgywNUbK/05z2SbQQ4eY4taPIpRFzHCiloAXBMtmnu8kUrOn1gOC7BNxt6bcsBwp83dwFwDiJa4w6vfNAI0qOB+3LCIbmzsNzgCAYgaqu/BZlbkYaKdWHUQeTdsXzPItXpgzhxcAt6E/7mXuOqD3XnlmKOeCu3z7Yi+5i4JdXKVLnnmsGZCAqZbKofDtBL+CvoG3rFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TC/iBgL7AfC+pT98nOhmklOFHYvUDOuxuvoyPbWavUQ=;
 b=MsSa/wTZrwsKGAfB9PfEHEYbPG7ojC4YM2M8Jult3gmBHu44mk7UnGJJql+RY7FsgxhZ/9QCCo+WF833OXzcaxtFDd5FX4s5KOtbPeotmTuS21lXDhUgSCLbRJonWsrjpRm78N4vvcqGw39rUMToQPe2SjMU/C9wS0ZOXYyyVg4=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA1PR10MB7486.namprd10.prod.outlook.com (2603:10b6:208:44e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Fri, 30 May
 2025 17:20:45 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8746.035; Fri, 30 May 2025
 17:20:45 +0000
Message-ID: <c4c19b47-79e9-4643-b102-3bf3a0bb04b7@oracle.com>
Date: Fri, 30 May 2025 18:20:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 bpf-next 3/9] libbpf: use kind layout to compute an
 unknown kind size
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
        Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Quentin Monnet <qmo@kernel.org>,
        Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Thierry Treyer <ttreyer@meta.com>
References: <20250528095743.791722-1-alan.maguire@oracle.com>
 <20250528095743.791722-4-alan.maguire@oracle.com>
 <CAADnVQ+GDezR0e+SgqDB5h885Gd500cGYpFs4_LiXpLuD5gYFg@mail.gmail.com>
 <4cc43d09-50d3-4d92-8785-056cae97808d@oracle.com>
 <CAADnVQ+QNFz7OpCS8L-i3OND=09iACF3VdLT+EPPmqXhO8czbA@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAADnVQ+QNFz7OpCS8L-i3OND=09iACF3VdLT+EPPmqXhO8czbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0630.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::13) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA1PR10MB7486:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bccffc4-8ec7-4178-1cfd-08dd9f9e500e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VU45Q3pVclh1bndiSjRVVHFZMEZ0YUlERmRxY1BrRnBmODl1eU9SUlYzTUlP?=
 =?utf-8?B?SCs0eStnaEw0RmtmSms5Y2V4cEpHcXpHekd1eUZBNHVjZVhhYjBGZDZ6a2xM?=
 =?utf-8?B?a3BaUm9PLytjcXFQK05BRjFYelFsZi83WW92QzYrb0Q2UDVoTS93clpVbzNp?=
 =?utf-8?B?bVdocnZqNy9UOExMbnBETS90OFFsV0psVitJYjVqSjdJK1ljQU1QQzI2VXF4?=
 =?utf-8?B?L2Y0b0t5KzdHSGpTbzFKS21rbTVDZzhuZG13dDAyRjNGV1lpNlZkeDlyblF4?=
 =?utf-8?B?QjNHdVJjV1k3OWErYk5udFBFZllYL1YvYXlzN1dXQkV6czkranpBTmNFTm1h?=
 =?utf-8?B?L2ErMlpDVktWb0t5eW51WnZpczQrOXoyd05tUk1EM2tUazQrQVRUQUhxL0xO?=
 =?utf-8?B?aldaemg5dGhhU1dndlFOb3VIU2FRMG41M3hFcFVKWFArTXdLUzc0ZURDd041?=
 =?utf-8?B?emh6TFA1TVBjL0g3bFFZVjhMb0c0MVFWdUpodzA0RUlxUkFEMHNnZ08xbnhq?=
 =?utf-8?B?NXF2aFE2TktuekJmcTMwNVBDNUlERjI4dEVrT0JtSEhBWjVRQzh3UWVhaklM?=
 =?utf-8?B?Z3F0anFPczR0MnkzWHI1Ny9uMkNPeEN3U2xWNXhUcHpmTlhiVHlEVDByWTZ0?=
 =?utf-8?B?WERWTEtzd1cwcTBHam44a0dLYkNqSjZCRmNMSllPMFNKU0NUTlV5ZGZaZkZZ?=
 =?utf-8?B?SGFzRVpVRE43WHk2TEwvb1NENTJjNTRtRnZkd3k3QkEydld3RG1RLzhuVjJK?=
 =?utf-8?B?WjJFcDY3TTNvNmk1OC9nK05hSkdCK2FZZVBsMlBUeWFTV3JyYTV1cGQ4VEdx?=
 =?utf-8?B?OU53ZTdFbG9CU1A3b3ZkSXRFUmFwMkYxMWh0NGhkQytadlRIeHlsenp4OElD?=
 =?utf-8?B?dVFvWTU4YkI3ODlQMTVYVUxGNytZWHJSTmp6QlVVSlorTTc0UC9YZ3pwR1Rz?=
 =?utf-8?B?SDluNFJCeVM3c1N3ZnVpTDNHTVZHVkNzL3pud3poOGVWMm1qMjJONjFLU1Jv?=
 =?utf-8?B?Y3BBbkZOZUg3elM4amxsN1B0d1pvcVRGUFpRajMveVVWVTM0bVR0WEFycklq?=
 =?utf-8?B?aVpvaHlLbFpMSFNhcUJLL0pFQXJ5RjNSdkFJRVlCUyt6NEpVUzY0L3o1QUJ2?=
 =?utf-8?B?Q1hyWi9FSzVLc3hhd1VNZEFHQlA3eExNN3gyU0w2dyttczJaMTV3S3JnNEFh?=
 =?utf-8?B?TStocUpyU3c5Y1VEM2JmN21ObGlEL25id20ybUpBRC9OVy9uQWloeUVjK0tG?=
 =?utf-8?B?cVoxU1QzaVA4RFA4Y013SVlzbStUNVFyMk1rclJLOUNydTBhZlhDUjEyM0hM?=
 =?utf-8?B?ajR3TkdYei9ONDcxN011cTRtYzA3MXpCMVVSVUh6RlJTeWI4WFlWYzZDSUlW?=
 =?utf-8?B?QjFPTkdMN095R2N5dGtOb0d0c0YySFhqR3VWSSsrQU84c0RWRXcyV3JKTWVq?=
 =?utf-8?B?dTZmRXV1a2VuMHFxV2IreDZTNmlFOERtNjNkUFJDNzVYdjJHMDBsUlJyL0NC?=
 =?utf-8?B?anF5S0xoOXNqTVc5RFBYc2dnUXkwMFp1K3hwZXZhTVN0Zk1XRFVTTm5RUk9S?=
 =?utf-8?B?Vi9WQUxXYUVKb1dDRmJ6bFdlSUpOUHR3VjZxbEkxUDlBMHlUYWNhazFjZXNj?=
 =?utf-8?B?c2I2TGpJSDNoQVZvRnN0RWhDM0lQK0IySnRxSEgzL2xiZnByNjBFRWpvaFQ3?=
 =?utf-8?B?UnNtdUZ4YWtBTVY5QktxTW9kQno1ZmNhRzh3d2txV3N0YjBJZDV2WlJKcGM0?=
 =?utf-8?B?Q0ZYam1xSmt4a2NvMXhZVlBVb2N6eTBwdG9nSld6dnBDSGU3M0RFeDhPSEwy?=
 =?utf-8?B?d3RuMEx4aUM1bDAzZ0VUSTZoaW5OT3JkcEJMTXM4S2J5SGVQazcxS0hVNlJI?=
 =?utf-8?B?eER3VSs5VVF3L1prY0Z2KzJBVC9PamlUeDZ3UXlyTHdKSThNQ3hhLzlKQ0Jo?=
 =?utf-8?Q?4T/ochzRjJM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MktsL3lhek8vT2JzSEtVWVl0aDdPeVdYRXJzM1Yrek43YlBKUUNEeDNOMWVG?=
 =?utf-8?B?bkZXRmhwQ2lNL0w2S3lDRkxPNHBVTEw0ZlZnS3QwZ2JvYWU0YUhIbkxYbytD?=
 =?utf-8?B?L2ZFQmJ3N3VEOGh2Y3lZNXNiWWlkelcrNExoVXVydUdmWFVDSVUxajJSQVNC?=
 =?utf-8?B?VWdvYlUvczgyMSsvSEtoeE5Qc285U21ZRjNuQUNvNk4vSmFWZk80MkFUeWdO?=
 =?utf-8?B?T2o3MVpMT3JpeTRUY0lSVTdxcVNTQS9qZHc4b040dnAxYXhVOTl1bUJKZXpv?=
 =?utf-8?B?emg1cHRKM01JV1R3azBVSG1MWVdkNGFEd3BZSFlra0lsQzZYK0pNYVRzcmJI?=
 =?utf-8?B?N3JsMTFHbnVTRWlYSHY2MWduSFNuaE5KbTJSY0hLeEtiRGJsV2hpY1lxa2lL?=
 =?utf-8?B?eHhSNXM4UHBkUWx3SVNuUVo0enIyU2lKOExydUVudE5ObmtZak8vNmVMUnEy?=
 =?utf-8?B?Rml5RWVZOWVvZHJTVDAvU2xnY0hzS1Zrdi9CbkJIdC9YNUNoRytlM1hqM01w?=
 =?utf-8?B?b2h2L0xmNkJucmxJZUQyUEdpSVBaYWpBMDYvcHVlUUxQT21abmNPdVozYVhG?=
 =?utf-8?B?MDlWODlYdlN1MGErMnlwOGp0OVZyTkVIRXZVbEM5YVdEeTlIS2wxZE5sZlVo?=
 =?utf-8?B?ZlFMRWlTTnRuM1hRNkV4S3ZHaVVocStGZFQveUtsYUNYZ3dGUGQ3R0pKMEts?=
 =?utf-8?B?eHBZR0ZiektBK0lyQ3UxWlppcjlKQlA3VHpPWHg4Y0JQeWFjeFJ4bzFUQXdD?=
 =?utf-8?B?eFYreStEZVBqVUdIZTZOdVlmdW9kSExnZXViM0IraXVscVlqaDlHbi95cXV0?=
 =?utf-8?B?dUFHbE5CZmVrc0loRy9abU1TamduL2FJd3lTR0R6YjRCNDZVNThGdVJYNGtx?=
 =?utf-8?B?aE0vRmkvdFBjbFVLd2E1K1JWVzIrejVRUDVCdWtlcG5qWnNIYzVKU3lORWxx?=
 =?utf-8?B?MUNSa0RNZFBIakpDWWlnU1FDbklFd0NpZVByRHM2RGE3REJZWlRqajRpNHJy?=
 =?utf-8?B?eVRUcDNQZ1dpMyt0YkpjSzRDMkZCOUhldkJ4THFENUZWRkl4VWhVZXhCL1kz?=
 =?utf-8?B?eGRPOUFObWpGN0RNRUx6b1hhR2Y3cHNRbG41dFBQZ2UvMjI1eTZRWWE4K3hR?=
 =?utf-8?B?emhGSjc4SFpxakNVWnZlcXlQaGF1bDJ3Qm5KeWR6YjBiNDc3dmdlMkEvQURj?=
 =?utf-8?B?S3JxUmFhbXQ1RkZtSU9oL2Zud2xaWVdGMDc0eW9HUGEveE9jamRNZEtETlRF?=
 =?utf-8?B?TWhNd2xPbjVRb1VSeE5VV041TU4vaTg0WUtVNXRSQ3dmNWFNaVJSVkxvMTRK?=
 =?utf-8?B?ZFAvMEF1NGpBZGlpcGlxM0d1K3lVbzhxWEhGeTJJMEVGYXYrUlRUQmFmWTZO?=
 =?utf-8?B?eFozQ0RrVU1LSmlmL3dmL3VDNDF2ZnZNaDJXTXBzQ1hYbnVrMEIvT3FXRXBI?=
 =?utf-8?B?NUk5Vk1hTVRHbHNiajZCVG9rNmxMQmpXTU1hQ2UxZTJzQWlHYUVSbS9KMlYx?=
 =?utf-8?B?bU9uaW4yUXQ4eXRBU1RYcUxnVDB6cnBWcHpYQmVqeThKbnZHSEZ5bVZrM2Mv?=
 =?utf-8?B?a1M1ME5adFYrRE1zNUE0V09FV1o5dU5JYnhSRjRKWnVMb3U0YWVnM3ZKTWtk?=
 =?utf-8?B?UXBEbHZvaWxqYStKYm55VzZKRUE4aGZ3em5lTTgrby9ldWZPY3hObDMvSWtB?=
 =?utf-8?B?THA3c1U0TldwTG1xelFjZGlDeExBaGtjY2JsNmpiNG1zVjJ0dnlLTEhhSWRK?=
 =?utf-8?B?SW1pTi84UWxZOWlVR09zeEE4MmwrRDcrRkFOckdvdEdFekRON0M5RFNzbjJR?=
 =?utf-8?B?QklOd2ZZM1Z6TGdWbXlLdEgwK2NZSVV2K01TWXNHdEtXZ2d6RE5vaHVFSlY0?=
 =?utf-8?B?R1hwUkpBbmNoZ21hQTdzNWN0WDBCMkFrRTVYMFZuUkZrcUI4TGEvRkNIbFls?=
 =?utf-8?B?NlJNV0ExSm14ZHA3QUU0N0xXMCs4THFyTVhEcWw5bTA4NVJWekNrbG45bitk?=
 =?utf-8?B?U0FqL0VJbmFJMTNGeEVibEN6ZzhEYms4YjdLQUxUck03NmRLU241UWtoUVQw?=
 =?utf-8?B?UFhWWmk1VmZSU05uWDJMQmJHclZJV1BJTzVYM2pTNWNTajRiSWs0RWY4amwz?=
 =?utf-8?B?SnhUMitrbFhreTVPT0loc2tJSFdUdnBVSzhpdXQyQUJ6TzJBZUlkVHMvUWtG?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ec1cdhTSdju2j8owkgQI0DZh15eXCpH2Q/f3txnd1AGeaDEvoRbrgAHUcrUpgxbM9qYH4GPNa1FuVl2+1kXrPZ5trdB84ZQ8CvsYcdX99fUygEDccCNXVVRxEG2dNKBTzxCL6OYFDPnIZ9/M1lfwkOG+7abjFpRBLDtVxZuFqCg1rTC10HFZgPmau8amKRfyvlYkJ2ma01fN9SU7fO40W7UkP/XWVXUwDy39kbTpqXmWh5fE6vvHwhxLGYL7t9Md2k8dOMZcOJC1lhEO6ba8+CBeKAhiF0sJZkv+KjLG1KvrpXHiIAchb7mavxUzmukDfCsGyamV4oXPRQlC1SmVc6W/TrAYlvC6r3RILPQYf2/fOCMDuGwNtG82R67fKek/WjDJtJAdjMK9STP2V1rk+Ma7BQ4ERc6m9IZzk7VJIE+R042Teo5apO7zl3jM0LeimXt48TpmxsBTg/D+Dw0Zvefg9Qif1i971TBxyvkNHKUwpuryUbs7K8nVTi13m232rSY8/CuuxI6SdECwE0deP0j68uoBTfq3aqvZq1CEz1D+FOXLzqZ99JUVVPc01X1b46/MxITr7RNBfDxINCgYbpwzo3kbxMRYS4VZTgv5VbI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bccffc4-8ec7-4178-1cfd-08dd9f9e500e
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 17:20:45.4987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 96pvzlcAz7ZyqAEm7qPIyVaKP89nKQ4HsnbceaL0OyX/yp4srvs6sQ7XuTEGbdVu0tff8lLjo9wHKOmZA5TxZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7486
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_07,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505300152
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDE1MiBTYWx0ZWRfX5tCYplhfMuM+ siOYFT++F9/RM5g7NtP43GkeNlkvA6yRH0Ks2zw9CIgJYbAInSEpdeSPBruqhQP1//rUtkzgBfG 1WF7EU5Vg2rG/uuDxtFz3nYJPUrCeZmIOM4WTEhGHS52S4vUnd3EWO+LOjizeHnXvf+tCCQsGs/
 6D9rQxn9p15/qBfkK2HNwpKopTLGqCEoziH5kDqdwzYYHZpZJuT3SrqFPC5Vke1mz8eMb6jjS/g hi7Og1iVuOs5F0VPUF6XVB23GSu/kQGzuqf8QRkoYF24W1g/xiiue+2SbjefqVLKTFjtLCucseT ES+DofOd5C+O5AirOng/v/VhJea+TWjdSeW2lFXhgqoKF0hjMfyxpKtGghw8Klpm7mkE4LRsoSL
 Bl5SzDq0zq9qcELWf5WezSojmJF5bTgENmCtoeLuj3tgP4HFuf9vy8WI8OVqCQL5VZLVxANJ
X-Proofpoint-GUID: _J26JgushL3AYFQKER6pgKcFSUZaJiYZ
X-Authority-Analysis: v=2.4 cv=UvhjN/wB c=1 sm=1 tr=0 ts=6839e8f1 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=qbyHiAj7Cho-2BI73QIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: _J26JgushL3AYFQKER6pgKcFSUZaJiYZ

On 29/05/2025 17:30, Alexei Starovoitov wrote:
> On Thu, May 29, 2025 at 5:53 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> On 29/05/2025 06:35, Alexei Starovoitov wrote:
>>> On Wed, May 28, 2025 at 2:58 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>
>>>> This allows BTF parsing to proceed even if we do not know the
>>>> kind.
>>>>
>>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>>> ---
>>>>  tools/lib/bpf/btf.c | 35 ++++++++++++++++++++++++++++-------
>>>>  1 file changed, 28 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>>>> index 43d1fce8977c..7a197dbfc689 100644
>>>> --- a/tools/lib/bpf/btf.c
>>>> +++ b/tools/lib/bpf/btf.c
>>>> @@ -355,7 +355,29 @@ static int btf_parse_kind_layout_sec(struct btf *btf)
>>>>         return 0;
>>>>  }
>>>>
>>>> -static int btf_type_size(const struct btf_type *t)
>>>> +/* for unknown kinds, consult kind layout. */
>>>> +static int btf_type_size_unknown(const struct btf *btf, const struct btf_type *t)
>>>> +{
>>>> +       int size = sizeof(struct btf_type);
>>>> +       struct btf_kind_layout *k = NULL;
>>>> +       __u16 vlen = btf_vlen(t);
>>>> +       __u8 kind = btf_kind(t);
>>>> +
>>>> +       if (btf->kind_layout)
>>>> +               k = &((struct btf_kind_layout *)btf->kind_layout)[kind];
>>>> +
>>>> +       if (!k || (void *)k > ((void *)btf->kind_layout + btf->hdr->kind_layout_len)) {
>>>> +               pr_debug("Unsupported BTF_KIND: %u\n", btf_kind(t));
>>>> +               return -EINVAL;
>>>
>>> I'm missing the point around kind_layout->flags.
>>> I was expecting that this helper and others at least
>>> would check that flags == 0, but none of it is happening.
>>> The patches say that flags is unused and do nothing.
>>> Why add flags field at all?
>>>
>>
>> The intent of the flags field is to provide space to add additional
>> information about BTF kind encoding that may prove useful. E.g. at time
>> of encoding for this kind, was the kind flag supported? Perhaps if the
>> size/type field specifies a type or a size might be another useful flag
>> setting. But basically the idea is to provide space for additional
>> information around kind encoding for future use.
> 
> I feel there is a desire to add "flags" as an escape hatch,
> but even for this example of "is kflag supported by this kind"
> I suspect it would be incompatible to add it later.
> Currently kflag is used by some, but not all kinds.
> Say, we decide to make kflag meaningful for kind_int.
> Currently kernel BTF validator will reject such BTF.
> If we add a new flag to kind_laoyout->flags to indicate
> that "at the time of encoding this kflag is supported"
> the older kernel will ignore kind_layout->flags
> and will error on future BTF with int's kflag.
> So kind_layout->flags is really only meaningful for user tooling
> that may or may not act on it.
> Long ago there was an idea to use flags for "is it ok to skip
> this unknown kind". imo it's the same issue. If we don't define
> this flag now we won't be able to add it later and give it that meaning.
> The "ok to ignore" flag will appear, but different versions
> of libbpf/bpftool will either ignore it or will act on it.
> That breaks the semantics of "ok to ignore".

Right. The challenge here is that there are two problems we might want
to solve here. One is the easier one; separating parsing BTF from being
able to use it. The basic kind_layout info solves this because it
associates the singular and vlen-specified lengths with each kind.

The second, harder problem - which I had hoped we might be able to crack
- is how to make BTF _useful_ to older tools when it contains kinds they
do not support.  We've often seen the case where distro kernels are
built with a newer pahole so have newer kind info and older tools run on
those kernels then fall over trying to read their vmlinux BTF. My
original hope was that we could provide enough context in the kind
layout to sanitize BTF with new kinds, but the challenge is to ensure
that they do not participate in the type graph (and then whether they
can be safely skipped) we need to know where type references live in
each kind representation.

Another more dynamic sort of approach to this problem would be a kind of
auto-negotiation with the kernel. Since the kernel is the source of the
newer BTF info, we could imagine asking for a mostly-equivalent BTF
representation that supports the more limited subset of features.
Because it knows what the kinds are, it is in a position to generate
such a subset. This would be in-kernel BTF sanitization similar to what
is done in libbpf for BPF program BTF. We also sometimes have the case
that BTF generated during compilation is too new for the kernel, but
libbpf's BTF sanitization helps there.

I guess what I'm getting at here is we can potentially separate these
problems and focus on making BTF parseable for now.

> 
>> So in that context, should we check that flags are 0 now? I'm not sure,
>> because in some cases we'd like to have older libbpf be able to handle
>> newer kind layouts which might make use of flags.
> 
> yeah, if we make libbpf act as not-an-error on flags != 0 and
> future version will make use of it, we're introducing an unusual
> concept of flags that was never used in the kernel and libbpf.
> Maybe it's ok, but I cannot wrap my head around it, since
> prior knowledge and concepts don't apply to this scheme.
> imo if we want extensibility for kind_layout we better use
> known techniques like adding a size_of_kind_layout field to
> struct btf_header, so we can add new fields to kind_layout and
> do a similar check to bpf_check_uarg_tail_zero().
> Then we don't have to add 'flags' there today.
> We can add them later and bump the size.

Makes sense.

> I would also make
> __u8 info_sz;
> __u8 elem_sz;
> to be __u32, since size is already __u32 in btf_type.
> There is no need to save these few bytes.
> With these two fields libbpf/bpftool can skip unknown kinds.
> I would also add name to kind_layout, since extra hundred
> bytes of strings is cheap, but warning about unknown kind
> will be readable.

Sure, will do. Thanks!

Alan

