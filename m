Return-Path: <bpf+bounces-30025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEC68C9A76
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 11:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4232B1C21448
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 09:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E981CD0C;
	Mon, 20 May 2024 09:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UBLjcFc7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oS+jGGap"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD42F468E
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 09:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716197851; cv=fail; b=mH84Yx1UHhzU5o98bTNMYf/c0NRF8ieUGyx6G+ZI3oGyfOqXiKTjh8RG84ZbeQagnlKFjYTXyu7MPN1QBlk4HgOtfnzK7fFM32wmJdOLILNMtbZ2aQEucS21F7PWSoYPq4EpXYiEVvN/mAF394KHnDTRl4TIdAdAjxkmQdTCZC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716197851; c=relaxed/simple;
	bh=9haxxKIoE4htHbi/qpUSw16PV7Eas6PMuX8hf/VrR1M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YcRHcc/aGJiEMt1F2BTtTTYaTuj+U/OpxzZMPx5uECyN0yDEkPYyLOxtqTDkHM4663w2t3oyy2mvfRsCdFmET4SlZ991sfgRGn7zpJFiQnFzq0nkZ+ypntKZ0VjjLhJnhip8JrhZ2jsXNRIETDwv7oXN3zxzP7BUe7hJiiZn7Ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UBLjcFc7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oS+jGGap; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44K7eF3C027170;
	Mon, 20 May 2024 09:36:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=tLDu9t2/Jort0dTs1cw2MQ6VwyVlR2q4o843aUSh4dI=;
 b=UBLjcFc7jDHoyHPndok8aZJ8fhjfnc0rawzDARcqXFE8OANgHtTnHpLAtIEBdSLHT25q
 vLliOmH9e8G2C9nhvedQ6Zz6+cOgemmoqaIKm3f6+U9BmiL8BDwgIm/Bg03rv9wejl6D
 qSxRd7M7xDU3ZFW/nicSeDWclV73jpT79Mm5QWGBvy0fl9KL+nCMlBeqCuR+TKBPY1Xg
 gBL4ue3G+GyJREwOpjzOhfQNNRbVSEBkkdfW+33eAaJllkFYaoDuD0l8HEVSq6FZb07t
 GbMz4iLJrKcVoGSG7KpsizUBl4vext41k5rL8ZBOhyyob+UKuVGTdo3TNLFiERXyDpH+ +A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6k462ax2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 May 2024 09:36:56 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44K9Y9WS037830;
	Mon, 20 May 2024 09:36:56 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6jsc1pbf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 May 2024 09:36:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/fUVzK+0GeLlVZtGYhlDawrKE70v3I8Qczmrh7rVKk+O+cDxZ3/zLsZZNEweXGQrp50hNY+gyQ+iWv4luzEolTon+4uCJ07H6aDxmWcOCWKn6pod0Be2KB39pyZQrV2R6JNBGgAfiQB6THV+BFDSWmXapIc3gIYQSlklliuPcwMeOx4SEq1vMwI0eBSUh2o5LemcfLd/0IAsGxPDtpqD7lXZcJoQcKGqggXpDVGvaCGab/Jh1ej9rRKX+P4BNytFo3IXUPVjRQ+bKH606ZnKiyqyXguph2W1kXBDUIiGI3ZTlpL5PwYppZwMGU1+/9W0Hq+MoqIkzUCpZw2H8GRkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLDu9t2/Jort0dTs1cw2MQ6VwyVlR2q4o843aUSh4dI=;
 b=DHlkY7I9oP6L0fvdeEbXCkc7o1j5v9KIMmrOKSwkKDv7itbKZyg9WlE0ohI/BF+pnkUXzu7h9xPEUtaD8QjjnjbxidUhqP5zluZOgD/qfTbf6tGn8RdWSd3ThnkK9LfnR+tysgRCXnBp6kZ22zJUH97FjyLfRNbBJnVQFCK47yiS5igyjAqM1XXcrobpn1Snge5QgB1XZ7JyuaZ8TEFqy8f7XvbNWklNw+BHZXOR8tYG+xWCEiATUJ4QQ2MjGVa8hMgf7dWmvnRTOfU1GlQKbXQ3+UNfDMLfri9EIwQcLt84McUhSbNx2GoMa69ZYe1lMNFWOhTliqVKEwJJ3Ld9/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLDu9t2/Jort0dTs1cw2MQ6VwyVlR2q4o843aUSh4dI=;
 b=oS+jGGapm7/jTvL92QtbZeDdTVKHiA+PVmYgEM2VngK0kj2R3SvBv6/2gB5UDgKPYCSqFLE/bA8NSg5hFbA8jaQcv8vOlJwDicF7NfF7MYrvT87HLgomzJIrrtho5C0ObauYQDqSbU9jVkNpSsldsOEpqgkabbSQwwwHlZOj1Vc=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SN7PR10MB6497.namprd10.prod.outlook.com (2603:10b6:806:2a4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 09:36:54 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7587.035; Mon, 20 May 2024
 09:36:54 +0000
Message-ID: <0c0de2c3-b561-4424-907f-eeadf7376477@oracle.com>
Date: Mon, 20 May 2024 10:36:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 bpf-next 00/11] bpf: support resilient split BTF
To: Eduard Zingerman <eddyz87@gmail.com>, andrii@kernel.org, jolsa@kernel.org,
        acme@redhat.com, quentin@isovalent.com
Cc: mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        houtao1@huawei.com, bpf@vger.kernel.org, masahiroy@kernel.org,
        mcgrof@kernel.org, nathan@kernel.org
References: <20240517102246.4070184-1-alan.maguire@oracle.com>
 <4df9f4e6357cc0c8e1b2d3ad0384bee164571399.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <4df9f4e6357cc0c8e1b2d3ad0384bee164571399.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P191CA0027.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::32) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SN7PR10MB6497:EE_
X-MS-Office365-Filtering-Correlation-Id: cad47228-3031-4987-706f-08dc78b06251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YmZBSmVEWEFyTkQ5SGE2KzkvMFZKWWJETi9XYXJIbDF4THVTZWl2MW9LQ21H?=
 =?utf-8?B?cGt3Q1BXa0dlczg2d2xhTFlwN0pGdEFRZWpjRUQ0cEMxWFBzd1RoWm1DNmdk?=
 =?utf-8?B?ckdSM3RpdXJBMHdFMDEvZXZ6UU5pQTUzbzBMMEpYdFlJQy9zTmh6U2VBMkww?=
 =?utf-8?B?djlrWks5SXdwZ3p2M0FrNmJFSXVRdlBCdEJFNnZ3MHVRY01QcStkbDlZTXJp?=
 =?utf-8?B?SWdsR1lnZjE1MXZJdnc2OHNPeHdlWnZaS3h0Z3MxOGpCQTBIa2dBK0VvWTY1?=
 =?utf-8?B?N3hkOW9wOUhNdkpiVDVQL1VucmF3cnc4K3VpNGVwMy9ydmFtSUFoa1c2SkMw?=
 =?utf-8?B?UVEyUCtGc3lxTTVNVVZTRU9SR0k4ckNnOEJYaWZQa0lsRVJqVjFUaTNJV1JM?=
 =?utf-8?B?SDlIZmRpRXdadTczbmlNSkxJUHRFTXF0UXVteXl1U20ySnJUbFVkNFlneVgz?=
 =?utf-8?B?Y3VXV1hidmVtZXNYY0MzYThIMWV3bGZFdWY2RVFDaHQrbWViM3NpOGZlR2Ra?=
 =?utf-8?B?UU16U3gwVm5Tc0F2VTNubmJTTFd0VnBzT3ZsNURIZnZqeGFzOGxldDhmNVpV?=
 =?utf-8?B?LzYxMWNqNmZNMVZxQTJZVTYvaDhOR0ozMXZSZ3I4SU14dEE2Wk9nSHR5ZUd2?=
 =?utf-8?B?UXFNcWk5SzU3SUdDcW9hUlM2K3RKU1p0TlFId3BmZjdybi9Fd2gyUWlJdHE5?=
 =?utf-8?B?dVc5Q3FZSTRjSGI1bGM3ZjBtc2d6bkJNRk8yMXBLK0lHRWQ0R2h3NTNKNCt4?=
 =?utf-8?B?VGxuTHU0b3ZLRWVweVNWQ2FUVkNrbG5mQWxPY1FhaGFNR1lmYk5oZTdwTUcz?=
 =?utf-8?B?YUtpUjBVSmR3Y0tEdXkxRUJQREMrazdVdE5YQlJSbFJFUVFkUmprQjNBbVla?=
 =?utf-8?B?ejZHSlhGWllPUncrV2c2ODZjeXBINndkNlBCL1pkbWFEK3NOUWVGVjdiRDZ4?=
 =?utf-8?B?U0p4WTJHZk5SalQydmdGZ0RlNC83QzZzVnFNMlZDY3JmYXd4ZUlCeitQak1x?=
 =?utf-8?B?SHMrNkFDR0hyZitzWURKVHBIclo5TmhMUWNWdmRCSG5tV2tkNW14czFPeURO?=
 =?utf-8?B?UmRLNGpScHVqdzIwU2VTeGFjbnpQcEF0K0p6REdaMkNZcStQaEc1RUdwQ1V6?=
 =?utf-8?B?NGlKUTMxOWdsMXg2Vyt5NGxrNnFmNHE0dGdHeHJyMGxJQXFwZnNvWW00K0NG?=
 =?utf-8?B?NTQyVWNjOHVCU0xreC9zcjM5U21sVmhOeC9IR3R5T3VXTFdHUWNqN21Hb05p?=
 =?utf-8?B?R2lVNFBmWTBEU3FQMHF3N3lSSzgyWUdSL0cvTjUwZHlPSW9RVm02Wk9YSXlT?=
 =?utf-8?B?UHhzQVpJTTI1WURyMXhZSUZsSHpVSjNIdzlWNzRkdkpBRFRjZWQ3bGswdlJn?=
 =?utf-8?B?QkRZeVIxaGJIYThPZW54WkloQ3JmOEM3Q1IzVEt2OHVvbmE5WUh4Tld5ci84?=
 =?utf-8?B?SzZUVXVVWFhYOWF6aHRGVk1TVG5kK2pLRkhIVy9TM2kxaDVzT0R4cHhnQ3Ru?=
 =?utf-8?B?ZWZDQWtyY2JmdDZubkxxMlV1dVNVK25nWkg2MEE3NktOS0tWZENMWlFEdkxs?=
 =?utf-8?B?WTFsRkZkNGQwYlNuVWNPQklUcUxVV2xRTjJ1dHVBMExBWHhUdUxpbWNmZXpC?=
 =?utf-8?B?dnN6VzZOL2hyc0dGbzhHQzlOVllrNjRoSXJtMU5jU21DcVlnS2lDK3dXUU5l?=
 =?utf-8?B?S1dwa3ZnZTVoQU40SVFSSEh3NnVSODhHNHBFbjNvQmpvRjUvN3BWQmdnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?d0ZsTDl2WHo0UWtQc3d0RzdlZE5FbjNSeXhhTlRPa014b2MvcDNpTk1ON3E3?=
 =?utf-8?B?cGNRUGczenVNb1VJcEtUSHFyU3NLajZGaVJiRFhUcEpZcENaeTNJanJReDE0?=
 =?utf-8?B?dUdqUnkyL2xCMm9sdWpKRXR3NkdFQnAyTFlVTXhsLzZUa0JxVE5NUWhTbk1s?=
 =?utf-8?B?d3gwVnRyUDNqejFhUnFCbEVpVTExdE1QNk42blJWQmx1eWdkcnU1NlZLQnZT?=
 =?utf-8?B?L1BxdUpBT01sR0ZydnlpUDBLMHY0TS9hOGV1eGdJdnZ5MWlzbHUvaWhQZklS?=
 =?utf-8?B?YWNsTmpjOG13Y3RoQ2NCYWRudFBGM3FNU3NEb2xidHhacmh4UEhBMXdyK2to?=
 =?utf-8?B?clNwY0ZhNXlQMVpVcnBJODkzRDV3ZXozNlErSzBOcEtnaWJaWXUyY3lBdGVC?=
 =?utf-8?B?cjZsRUkraCtzSWV5cUFXci9NMGM5QnpZK1BMUVYzSlpsdjBXUzRJNzZ1T203?=
 =?utf-8?B?aEV0NUxuQjZMZEwxbDlsNVhPcEp4YU1SV01keUpQNjdxdzRWVWVPVk9makRv?=
 =?utf-8?B?aWtRa3lXS2F6YVY2WTBtU01RWDB5Y0diTjk1YlRqSk94Wks0eXBpUSs4Q1Iy?=
 =?utf-8?B?ZXpTTGUwS2xxU1hPL0hnOEdwcVRkNU9FV3J2ditJSCszdDBMRGlrSTVYbkI1?=
 =?utf-8?B?bURuSTNzUVBEM2kzSCtIMzRyQkFreTFsUHZuYlhiU2ptYXE3K2JJaUgwbURX?=
 =?utf-8?B?Z1I1cDJJY1ZvMjhBK1pVc3A1RlByZmQvL1NRcW5YKzRscmNqUUowd3BEZmc1?=
 =?utf-8?B?VlErYzNhdXFFYnBxMjBxZ0xlSTVPRkxZM2JyQ0tnTWlJSWcvWTZoVTRpRmxT?=
 =?utf-8?B?SWpxbWtHLzZiTUNCcUUxYzR6NHI4QTRXYi95V1cwWGFKK21NNlBvY1RzWnFZ?=
 =?utf-8?B?NEczRXNHcXR5dEN2cWUvZVdqd1NYZkFKZnZWTW44NUVTbWxYVEZ4ZFgvUWt0?=
 =?utf-8?B?Ymh6NERlQVZ0SkthOWVnZFIvbEdORk1nbWhkR2h4di9EVHFkeXhVZU0rbTI5?=
 =?utf-8?B?VXFaVCtpOWVwNTQ0dThhZTZEbURVeXl2QTdDWkZlOVBTVHlSdTk0ck5Ya2RU?=
 =?utf-8?B?bjczYUVITzVueUlRNWFCbUFuUDBhSTlZWTV0ek1WMTcwdmo2cHgrYzYzMFk0?=
 =?utf-8?B?VnkyRit3eDNJRy9hNlZGekx2dHc5cDIrb0JMaE05VGNSaG5yVE0vc3laK3lP?=
 =?utf-8?B?OGRRNHVXV3lFaDYvcWtyTnV0R3h1OEZTYkM1a25pbDRqdERwR2xEQm8rZk56?=
 =?utf-8?B?NWQrL3NMbGRJeHFsOHdxamZBdTExc0gweTRLY1l0UnNPMGZMQWUyQzNMd25Y?=
 =?utf-8?B?SzRQOVRObWFmTFptcklhTUxjOXN2bmJVQ0Y5YjRubU9DQVNwaFpZYmphSkdL?=
 =?utf-8?B?bEVienE2R2o0dHJFa05GYlpzbC9BWGlpNWpFNGg5c1NOakRMNTdnQU05RnBC?=
 =?utf-8?B?bytMcTZ5WVkxK1M1RnV5aEdWcTkwN0RlZnhvcGRDY2JYUzdWQ2VGSWY0UzV0?=
 =?utf-8?B?TmN0WEdjTzl5OVYveHlTSlFaMzB4YVNtSnNqMGk4RlFZTGJmckliT2QzY3I3?=
 =?utf-8?B?ck0zVDNFb0s2Nkxxb2VyVytRc0VPWUpZTE05UGwwdUFWREtpemZtZUZjVGNV?=
 =?utf-8?B?eHduQ2JFQ3M2S3JpbUhOOTRKd3lqOVE0NlBPYTRoT1QwWmlzUzRZVU15V0ty?=
 =?utf-8?B?NnN5aG5MYmNRR1pOaEFOZE11VnpVL1Y5TDBDR3dwN0VSUU8xTUU5bFAvZXc5?=
 =?utf-8?B?RlhTWGlwdTJTNGtiYmc2blZrZER4ZHBjNmh4RWtuS2dRUzNlNXI2TnBDbHV6?=
 =?utf-8?B?QVFZWE1aOWZjSDUySEZiUjR0U2pUZVFnRGVvYnBZanN3NkQ0aFRwM0R1c3Qy?=
 =?utf-8?B?MTljWFNPa3Z3ZU1MTkVHTWZxL0lxRHlpRXRiNkN3SDM2d2tLcGpacjdZOGxX?=
 =?utf-8?B?ZHVuNGtMNlNSdTdvVkR3ZWhaeW1SbG1hQWxhakxXVXY3TmVxYml3SXhlL0Jn?=
 =?utf-8?B?dEVRVHR3eDZYallvYWo1TUhxQmx4RWh3bWpsL1lRd1d6UGcrcVI3T3o1Q3JP?=
 =?utf-8?B?Y25rY3pPaEhUMVEvRTNtOTAxZXM2Ri9KeVBXQXhCWjNTNjBsMVdYQnJkTk1v?=
 =?utf-8?B?SG5wdUJvL09EL0l5ZFVtOEhWemdJZkVtY01BN2pRSE1ORnlMNUNBNGhvN1o2?=
 =?utf-8?Q?OKNP1weeW/U/oe+3r38OutQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QEji6Xhos9xo0u+NtkFszdLo8EVJ7+nYT59PiuEy7q3Va3YNMQKaxs272+V+uj+BDsVx3tXHmMLJGepnJVKFXl1ZmXpY+dnevWfkNh5rnwnyALm2jdeN2kZBDtTrzLkiKzofdSuQCCmb4QfdMkC92EqeJIKgOk3pjc0vBqLYzr2tyvo+3ppWIi2Aa+N/GB4S1Za/y3vvkP2HLwkcES6LzbTUTtB6U/xU9dm1QCWdhwzFmy7DZv8ySl+h+MDz9cjy+HVTyV7/rBgVxgU46LOzJolbL48NoQKzVRnDnURJ7wJmrQwydxoZYrE5O3FIdPCSf9nqGRie+O/LaOCbbt9fFe7GY/T7SYnBTaVAYwNxE+N3F0Ppckcox5ypyXBwB5Km3u5zmu1UfPIaPqjdBHoCFj2DMXCZPN9lUr46TJwv317nXfsFE2/h382/sgb5O7JhtTkKdFXuqP5rvrM35x4ISOslraNLfmy5miowJFrx8j4IhRTNPYCoa/PqkN7y6iIeM6+GCncnI4ftQ97LmSXQ7ZwRqT6MyXWuCq0tDDX2cAhF0DOsuv3+hVs9k3mXcdSF1+iAs74Ps1w2yMzpOnaXUD/bZLjL14/oEXmRtV1thTY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cad47228-3031-4987-706f-08dc78b06251
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 09:36:54.0764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rhvRTZlomD5Fj8HbZfOmlUBzUoE6iPSRXtn+3HtrWZnv4ZUS7VEKbh/v5t/lLk4D+5XigqGL61MDHjpeAEhtNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6497
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-20_05,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405200079
X-Proofpoint-ORIG-GUID: FHyG8lj1Iirg7L1YSji9zvw7PC8kdSmn
X-Proofpoint-GUID: FHyG8lj1Iirg7L1YSji9zvw7PC8kdSmn

On 17/05/2024 22:09, Eduard Zingerman wrote:
> On Fri, 2024-05-17 at 11:22 +0100, Alan Maguire wrote:
> [...]
> 
>> Changes since v3[3]:
>>
>> - distill now checks for duplicate-named struct/unions and records
>>   them as a sized struct/union to help identify which of the
>>   multiple base BTF structs/unions it refers to (Eduard, patch 1)
> 
> Hi Alan,
> 
> Sorry, a little bit more on this topic.
> - In patch #1 two kinds of structs get BTF_KIND_STRUCT declaration
>   with size: those embedded and those with ambiguous name.
> - In patch #7 btf_relocate_map_distilled_base() unconditionally
>   requires size field for BTF_KIND_STRUCT to match.
> 
> This might hinder portability in the following scenario:
> - base type is referred to only by pointer;
> - base type has ambiguous name (in the old kernel used for base BTF
>   generation);
> - base type size is different in the new kernel when module is loaded.
> 
> There is also a scenario when type name is not ambiguous in the old
> kernel, but becomes ambiguous in the new kernel.
> 
> So, what I had in mind when commented in v3 was:
> - if distilled base has FWD for a structure and an ambiguous name,
>   fail to relocate;
> - if distilled base has STRUCT for a structure, find a unique pair
>   name/size or fail to relocate.
> 
> This covers scenario #1 but ignores scenario #2 and requires minimal
> changes for v3 design.
> 
> An alternative would be to e.g. keep STRUCT with size for all
> structures in the base BTF and to compute "embedded" flag during
> relocation:
> - if distilled base STRUCT is embedded, search for a unique pair
>   name/size or fail to relocate;
> - if distilled base STRUCT is not embedded, search for a uniquely
>   named struct, if that fails search for a unique pair name/size,
>   or fail to relocate.
>

Hi Eduard,

IIRC I think Andrii suggested something like the above; then the idea
was to use a 0 STRUCT size for cases where we didn't care about matching
size rather than using a mix of FWDs and STRUCTs. As you say though,
conditions can be different in the target base such that we might have
wished we had recorded additional size information, and we can only
really know that at relocation time.

That being the case, I think the most robust approach is as you suggest
to always record STRUCT/UNION size at distillation time and then only
require size matches for the embedded and duplicate name-kind cases.
This requires moving the embeddedness/dup logic from distillation to
relocation.

> If we consider above to much of a hassle, I think v3 design + size
> check for STRUCT is better because it is a bit simpler.
> 
> Wdyt?
>

The main goal from my side is to try and ensure we maximize the
opportunities to reconcile split and base BTF where possible. The scheme
you suggest above - always recording size but selectively using it in
matching - seems like the best way to achieve that. Thanks!

Alan

> [...]

