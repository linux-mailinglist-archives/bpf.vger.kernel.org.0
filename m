Return-Path: <bpf+bounces-27928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7188B3A3C
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 16:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61DCF28636D
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 14:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB46413F43A;
	Fri, 26 Apr 2024 14:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g/ALt0ps";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f+q1zWX5"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E37B34CD8
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 14:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714142522; cv=fail; b=EHsRu8ppG+wftW10GCyWnPyAfTQEBYBYVJBVjpRti/UAlpNj6H+lqKP6rsTKEP3AaLQLivlWxgkp2MPDeazOtczdLecc3KQBvhaUnJvFt63FgOOmba5/jJ8oWzy1XsTFCez997AA6qS9SXxWUwGFbemN3B3p7oLHGhN/P0Q8rS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714142522; c=relaxed/simple;
	bh=a/mUQ4ANBnS78P7nRjmRDUQG3FnxJo88+ojHmTS08HE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=KhDpI74zKSYkmbPZImQ9LZHFvncHmD00/GnsJcfM02/sJgT24p6w9raUBhoPHym3h5IWMn/AxMsCmjciUbOwdtol0mANGzLUGnYhKxzeKGD4j+N3OZ3KuOzD9JdmcOv6dEhbU3hCxDCnmjrttUtLg6ffRYZlI16zBWKhA9WewD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g/ALt0ps; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f+q1zWX5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43Q8Skq2014200;
	Fri, 26 Apr 2024 14:41:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=phZskGVwY9L43G5yzbypmTZyKBP8OJ/3XaQdWwaUhFM=;
 b=g/ALt0psnSbMiyjHRjX3CLSDemc3Hm+E1tpumTkhuzqB4AE8TgS0GXoSO1y448E1KHYT
 kwX9yDShjjJjl3W4Heh/afh7JBGturoakA2+29/6gAaC9krg7Qlk0bQi7xoXwoeKKjGe
 8dKIWf9/KSGOThVUD/32QC+OnnasnnkPUMXopMAWTewdO1R/Vs1+FM1qTzny/DMfVcbb
 byx6bcQkye5kRaNi+QkPhFTXseB7Hjn7yw7jmhkeSlaODX0AdHLj8Y3kG6vQyI5mKYLO
 CDKGPu+Y6OW++oK6OUrYm1pZTTIYX2QvNmDIaZtyNcI7zLO4xBTgMRhiWYZ/F84h2Rxj bg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5re5rha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 14:41:56 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43QE0Mf1025273;
	Fri, 26 Apr 2024 14:41:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45j2fk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 14:41:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWuMxyFWw0MGl9A6wHhwwez+Q+RCLQ0HZC8lTJeuueO51SbsEYeCuXMWM5b2jLeNj34TzlIWrgn5n3mGG/MNCHwvPp6vPLln2LAWry6Vt0APSrWv1ZYyzL9dsWniShZmoXV5taOEV9BldRdJL4+mABV0bAgg0G8vIm/1Ie7go70g8m3c6wPWCMqguzCt2kpjq8LuxgQBrc5Kd0pMMaZTDjiKPxTcqiZk+E01EBytZrkXLlIT+ZhlpG40DnlGKPqh4QvpegnxAT4a/WZgQtrk6yqhj8RAdi0XUJ/Z4Rs1SVQIvlj9xWLmg/BM9Hpnc4DPAoDQhd5mUbuYKRfMSgGDSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phZskGVwY9L43G5yzbypmTZyKBP8OJ/3XaQdWwaUhFM=;
 b=MWh7lY9Pki0RmA6NKvDIQHy9q9bG9fX/079Yd8MZ3XNSFui3t4Pp9hqWFG0N3z4syN4mLmS3ZTYmexTGN2SgHZBWZJqBHVaQgJcYNxFrSv1lYqbUiFgmYV+aPH2Kj3ArcDAbnjELZgAM8MLJfYjfjiqbG6wBRJ1WVl2Ltt3/wVUn3Nia+DoJm2QwqJvhLselqkK0pOIC1JCgLQtDUuG2T9tH19brXfcPtfZ+EiVV+YU0y/sAM1Ki2jrCkDCb2APiplxJ0aWJ2NCsKqKzrfk9n9OMa9h5DwSa8HVpR/TZiHEzGHXbDjWpJwREXlw/qgbqorRQt5Sv0W9bYc0C652M3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phZskGVwY9L43G5yzbypmTZyKBP8OJ/3XaQdWwaUhFM=;
 b=f+q1zWX5MDPtYGn1Y47c39xnYLwTlUVYlEwCV5bRdllN5ynpnAfbtnmZPbpjPiBoW//Ov2FXniuQVmw07JS4XWCnrHMqUd7ddCJqvqrdrtV4rHRCQrNkDFAX4sMGHcYq34rTe2zq48cykeFfZt6fUpyU0m/rVBDW81A0q8DPr+A=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by BN0PR10MB5014.namprd10.prod.outlook.com (2603:10b6:408:115::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Fri, 26 Apr
 2024 14:41:53 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%6]) with mapi id 15.20.7519.030; Fri, 26 Apr 2024
 14:41:53 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>,
        Yonghong Song <yhs@meta.com>, Eduard Zingerman <eddyz87@gmail.com>,
        David Faust <david.faust@oracle.com>,
        Cupertino Miranda
 <cupertino.miranda@oracle.com>,
        indu.bhagat@oracle.com
Subject: Re: [PATCH bpf-next] bpf: add a few more options for GCC_BPF in
 selftests/bpf/Makefile
In-Reply-To: <CAADnVQJJtNc=kqPby5bckOHzUFzdn_mD57c=0U7iyD23yrpKCQ@mail.gmail.com>
	(Alexei Starovoitov's message of "Thu, 25 Apr 2024 08:40:11 -0700")
References: <20240424084141.31298-1-jose.marchesi@oracle.com>
	<744420fb-4b2b-44c8-9e35-1ffd9f086fd9@linux.dev>
	<87v8465u8p.fsf@oracle.com>
	<CAADnVQJzLzrxtHeVcpNBtb-rnwWfApFEy_kv7LzWDee4pH1ezQ@mail.gmail.com>
	<87a5lh4o7r.fsf@oracle.com>
	<CAADnVQJJtNc=kqPby5bckOHzUFzdn_mD57c=0U7iyD23yrpKCQ@mail.gmail.com>
Date: Fri, 26 Apr 2024 16:41:48 +0200
Message-ID: <87wmok1903.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM9P192CA0021.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::26) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|BN0PR10MB5014:EE_
X-MS-Office365-Filtering-Correlation-Id: 48f58dfa-81b7-4fda-331a-08dc65ff0385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZzR0dU8ranpWb3NTTlNGT3E5Z0Z5eFpYdldYZGF2SHVHZVZiVWhEMElWbnFW?=
 =?utf-8?B?MnFzOVhFbWRBcUlneVJVMElDNVBSWEIxZkxWS0w1Y3BuUlpCZVFUVVlsU3Ux?=
 =?utf-8?B?QWY5ZGg3aHpHeWJBRGZGN1ZCZ0lGTzQ4Rml5QUM4QThPcFFRcjhSREx0clA5?=
 =?utf-8?B?eTlLVmFpMC9zc0hINWVyOHJ4eTd1OWdDMFhSL2I3KzlwK1ZyYXZXM0ZINDM3?=
 =?utf-8?B?QTR2eWIrL3VKVzlPeUs2Q29iNlpJRE5pS05ZWG5CazZqRjZpUlk4eUNXbjYy?=
 =?utf-8?B?WlZHRGUvRmMrWHczZW8xRHp1RHc5NDFobWdsNXRCZVJIQStrNjY1OWxQS2p6?=
 =?utf-8?B?TC9GbGlYT3V4dnVLUGdrSlo2YytLWjQrUWZjcHVueUZzWUJDQ01qbHFCdVYz?=
 =?utf-8?B?ZURmcDkxK0t0dnBCYkhlSVdyTjlWVWhyUHpjeWo2K09RaUdpUlJWeHJ3cjli?=
 =?utf-8?B?ZXJIUlFjSElFZTVLNVpnNUtKcUVUT1ZPb045L0lMSHpLdkU1VnlaMUJBSFVq?=
 =?utf-8?B?R0lvTGJ5MndjbG1pOVdxUFNxbHNLQUVvL2JUZDJOU2xNa0JYR3MzanpWaVlI?=
 =?utf-8?B?cXA1aUlnck8zTHlLR0M1QVJrNmJxdytGVXFyLy9rZVJZakhDa3JZU1J2NjZa?=
 =?utf-8?B?RnVoWElzOVRxN21TcC9qVXkrblFYQ0pYUlJDMkxlK0R2RDhHZEw1bTUraDhD?=
 =?utf-8?B?QkZOU2VOWXV4aGxFRG1qNlBKU216K0JVK2JLbU9TblZZckNyVFVNSUNJTkVG?=
 =?utf-8?B?eDlONDZTYjBRcDNmV3JaSnoxWS9sM25MNWo2TWFweEZ3OFNVQVZXbldkakU5?=
 =?utf-8?B?Z3dnVnhYdmJzSVhjdFBnQVhKN21qZnE5SUVsQTBYMGJ6amgza25CWE92ajZD?=
 =?utf-8?B?MFpEMk9INzR5c0s5VEdwSEdIWTcvYm84TGg3K2tTM0Z0dlB5bk5td2dua0NE?=
 =?utf-8?B?T0hNWTM4eGpRQzRBNDJJeDFjdEpXdm9OdnBIYVIxc3VmMDhZWDU2QW00UUJY?=
 =?utf-8?B?bzFOWHd4d2ViYWpzTUg5U3pobEI3aTBiZWhwTU9EaldqR2hMbEF3V1F3eGho?=
 =?utf-8?B?MnIvUWE2N2ZGWHRZSDJ4bjhjcFEyY28zdXJ3UStwZE50TVJYU0VZOTUxK0tk?=
 =?utf-8?B?aEc5T295NVR1WTBiQUFiaEJjQWFpSERoYmUxbGZxd2ZlTTRJaWIyZEFkaVBE?=
 =?utf-8?B?eEVhNG9yNEJzdzJmNjZNemUzSW1CclVLcjlOQ3hDNzBwajB2OG9kTzBKcUE3?=
 =?utf-8?B?MW1qVTNyaG5LSThOdE02OHYvNUY0RW14VFJlQ3lxOC83eE15NEtoMGFoalhC?=
 =?utf-8?B?czhmNGtGdi9FZEpzdmZzSE96LzY5TjBXTWxxdmduSHNkckhJbHRpWSt3S1dP?=
 =?utf-8?B?YVphbWZtU3lZR01Qc2pjUU5yUlo4azdheVgweTZlVEl0ZnM2Tm5Nc1c3cEtM?=
 =?utf-8?B?cTdCV0RjUkVvQzJEVlJ5K2pDaHIwTy9OK1lsNy94Y3A2SEJjN0ZmS3MrYXFl?=
 =?utf-8?B?TFhaU3lUR09lMzZ0VERJOHJkajdyTlAxajgwdDdaU1lXU0o1UCt0VUFMQU1l?=
 =?utf-8?B?eXpCTkpJNS9VS2JiQjFidmQwVHZHZXhIV1RFS0NaV3pZN3hCOFVtSGtZMGIv?=
 =?utf-8?B?R0lRS21tdmExZ2dSbVZLamVvNUl3TTRlVDFYUEczQjZOYW54R0c2Y2p0eGpK?=
 =?utf-8?B?dkgzMHJZR2Y0MDZKNzBIQTFyb0Q1VDhiYTN6ZVdyNVNlMU5Xak9pOGxBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R0gzVmtPbGgyQ1AwK21pUi9CRG9QZzBwY1ZxVmlpelB3QVEvY3QyM081K1Vn?=
 =?utf-8?B?dGJGWFJoRjdJTVd5WGt4ejZyYWNWMEVINlNjcUJIN0EvTURBZnRaYzRQMXZI?=
 =?utf-8?B?V3hBMW52VXYva2tDMFhiUVIrQ3krRmdVZ0kwY0g2UFozSTk0WTJqdU1Gd1pI?=
 =?utf-8?B?K2FhZENmRjFlQUQ1bmR1Yml4QnBtc1BjOWVoUmxzNnRORVdnMVBNbnpTTmds?=
 =?utf-8?B?djhRdzIzSFRkOHRhaVdkRFVwK05EdElob2xacWFoNncxMUplM0o0MXE1Vy9H?=
 =?utf-8?B?dzV6YkRScUpGM2hjbU8zWkd2Qnk5TmlIak9JSnBPMkl0VUlPeXpiSUt6YVlO?=
 =?utf-8?B?eXBIdWFORi93U2RLOGtzMzNlZ2tJeklqcTVHWEs2VjRKNWlPU1k3NjZ1ZWNi?=
 =?utf-8?B?bVlhdmpEVHBqTDdCQ2lNbUxtVlNJaDVGVWtIaTQ2N1AyaHluU2ptZGVTcFRz?=
 =?utf-8?B?RWdKVDB5OUtML0wrYTJQUXBWVkQrL3A0V1llM1BsZmsrS21paEV4MWxiWUgv?=
 =?utf-8?B?T0htV010djNBQ0ZMWDBZRVkzaU5XS0VXNDR1ay91NEJHNCtMNE5neWR3QUMy?=
 =?utf-8?B?bmZWeUtUZHdUREFLL1psYjE1SWIwWW9UbmNKcFhBSFdoVGtSUjUwWlBwZWZD?=
 =?utf-8?B?eWZCQkxLajU0aW5mNjJlVEdrZEswdGhzNVUzSkFLYm5RWWhnRThDWXpLTnFi?=
 =?utf-8?B?WHJDZk1OZ2JYUnhCb2x5OGViTjkwRXlBSU53Tm1ZYm01ZGl1UmdZeGdzUXJV?=
 =?utf-8?B?YmZ1N1NjWDg5ZVBtZUZ2RFVibERBWnlseEFNZDBYVmdQc21xZ1A1UjhVWnk3?=
 =?utf-8?B?WnBFeXJXNUtNeGRacms1VkxiOUFaUC9BbXUvbW83ZXYrQlIrd1VNT1pESk1o?=
 =?utf-8?B?cEd2alJXOUZ5MVJnQWRWL0w0WGZtNDN5UDJ0blJ5TkZFQlk5ZUFidmdrelVY?=
 =?utf-8?B?NDRGUUpuMVVDMUNHMXVyMjdzdTI1NVlMQ3ZxcGdzWFdJQ3lOaWFzb3RKU2xI?=
 =?utf-8?B?ZHJ0Z09PN05ZK3c2ODVUcG0zb0NHUWl5ZXBBMXU5NWZka3BLOUtudEJPVkJM?=
 =?utf-8?B?bUU1MXgyZXFCWXVPc09UUURkV1k1Y0hvRGRNajJkYUlIc0J1N0ExaHIvR2hK?=
 =?utf-8?B?VCswaWJNKzAzNHZGQkplUnBybVNkeEZjQ1g0UzloMnNCMWltbDZCZ0M2NENH?=
 =?utf-8?B?QWhDbzJuT1FXTlhuWnJHNVdsckt5R25RK3ZUblc4eU8yZnBjUitEOVNBd3V2?=
 =?utf-8?B?NWJnREhoYktOVTB3T0Z4K2xWMXdxN2g5anhvMXNZLzJhSGRyZVZJNHpORWhE?=
 =?utf-8?B?QVZrNFdTSFlrRW4zNFF1d0l6NHIyczB1NjdIb2UxRUdlL3QxVTMreGgvdUhY?=
 =?utf-8?B?LytzQzJMaFlmd3ZCeWZXY3VXOFkyai9TMzBLZ1dyVXhuMm9OcXgvQnh6WjRJ?=
 =?utf-8?B?clh1L3VyeGdYM3YvR0lQVmdBOUNzaHNkc1NJVk9iV3VESndackd6c1d4b2Qv?=
 =?utf-8?B?WDcvN3doRTJiRVpzSEdmSlA3UVhWUjJhcEs3djFqaEZHa1BjSlZzU1NjTlJZ?=
 =?utf-8?B?RCtrRkdsUm85YUxuNytXUjMrV2ZKZmVGeGMzaExtSkNIZXFvTXdUUkxSNFg1?=
 =?utf-8?B?YStsV050blk2dmt3RDlORDhNZEZrcThsaSs3UitqZVZHd3JOZ2d3Y3BveXRt?=
 =?utf-8?B?SGZEdnNRYTZCbnp3WktFV2M0M29TSVBRa20zSGFLc25jNWl1bVZDK3F1Q2xu?=
 =?utf-8?B?MGt5RTlKSnRtUHFodFBHaXVncklITi9NVFRib0xQQXo3OVNLY3lnK0tKS3p2?=
 =?utf-8?B?RVkyZlJYd3hqRDZkU3AxV0FkREp4T0FoZE1OOXE1aDNIOU55MjFVMEZTbVl2?=
 =?utf-8?B?RHpGMUNmV2lybzU5aGFQRkd1eHpPVTFxbXMzZ1VyL2RRUll1Y1FVZ2JybEVK?=
 =?utf-8?B?bFBGSzdxdzlOVFkzTVNIS2xnZy9aUCtvT3lVaUtpTEtFZHRKL3IvUDBDWXFh?=
 =?utf-8?B?dW1XUDlkWHhVMnBDS0xWcFpvRlpjcHRTY1lGcjIwWXNsUVlMZzJxMU9YR1c0?=
 =?utf-8?B?Z3BISVI1RXdyUnRmQm9rVFhobERNb2g5Y25oRUMwZU5naU5HRElJVmxMOTJ4?=
 =?utf-8?B?K3N2SzNRb1NleVRXSUxzSlE1bDN4eklXeDdJUUdRVG41QmlDMDFjUWNoM2Mr?=
 =?utf-8?B?OUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YBQuyvqFrK6sKYQTD8FgdJUkecehNGIeqEKZlLeloSFnL9WXoH6tCIUsNNlwM1sfV/2xQyGJfrNDNAC4ay7zS9LHFtLHlvP+1rAPy1wF3w/5H1h5aivBnWJGprkJ3TJk0yETKgHV1g+ouYR3b2jnl7k5HcOsatRoZxqXoifASrUuuR9HD1at3LWS2miK8tdvAAZXwD1QpVbxK2QCPmyif9PMFWEJ3aVcJkiIDzKogHJnqBfDXq45YRqWENdULwumHKw+IqwR0XkjkRFQNj1jpubEksX6uHZQptcBa+ykm1fYpx2SQF/jvc2GkdCHCplHF8JdrgAOEZIAd58VO1IZYhdJfGr+kljWRGFJkj+niihxM7B4Cv70Uvx3Yu3nqA7m4hVD8puMe8wn0czfW9dyfXMWVzeFe5O4pSm5rI/1kcsPgX20V2LhKZaLGPt9w+y+kCVUqeYoCDfCiAs1ln4RnQX9Za2ARX2BdZT5rnSFirZgcuxhj9hr9x4d12WJmvRiYMDBYm90n8r3Io3cLrjDit71HZNZiW85+h3m0/5bWeWV/zsSzdn6+PTlLz1Vsq29014JSrr5NWHZbwGRPERtZqPaBC/+4Gj3uvFUR3tjfs4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f58dfa-81b7-4fda-331a-08dc65ff0385
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 14:41:53.3611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gJeMarPg9xv7ee1x2oSSuIXxBkkTeyJWoJBEPmib3KiucVdl8Zv1fvkUAMZ7atFNxHJvMDpeSalxWlHWXpC76ZvcmbUiviOEerhGzn+AVeU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5014
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_12,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404260098
X-Proofpoint-ORIG-GUID: 2s7_rLCKoyfrQAxDk1-k-QA406Dx6wdI
X-Proofpoint-GUID: 2s7_rLCKoyfrQAxDk1-k-QA406Dx6wdI


> On Thu, Apr 25, 2024 at 5:32=E2=80=AFAM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
>>
>>
>> > On Wed, Apr 24, 2024 at 2:30=E2=80=AFPM Jose E. Marchesi
>> > <jose.marchesi@oracle.com> wrote:
>> >>
>> >>
>> >> Hi Yonghong.
>> >>
>> >> > On 4/24/24 1:41 AM, Jose E. Marchesi wrote:
>> >> >> This little patch modifies selftests/bpf/Makefile so it passes the
>> >> >> following extra options when invoking gcc-bpf:
>> >> >>
>> >> >>   -gbtf
>> >> >>     This makes GCC to emit BTF debug info in .BTF and .BTF.ext.
>> >> >
>> >> > Could we do if '-g' is specified, for bpf program,
>> >> > btf will be automatically generated?
>> >>
>> >> Hmm, in principle I wouldn't oppose for -g to mean -gbtf instead of
>> >> -gdwarf.  DWARF can always be generated by using -gdwarf.
>> >>
>> >> Faust, Indu, WDYT?
>> >>
>> >> >>
>> >> >>   -mco-re
>> >> >>     This tells GCC to generate CO-RE relocations in .BTF.ext.
>> >> >
>> >> > Can we make this default? That is, remove -mco-re option. I
>> >> > can imagine for any serious bpf program, co-re is a must.
>> >>
>> >> CO-RE depends on BTF.  So I understand the above as making -mco-re th=
e
>> >> default if BTF is generated, i.e. if -gbtf (or -g with the modificati=
on
>> >> above) are specified.  Isn't that what clang does?  Am I interpreting
>> >> correctly?
>> >>
>> >> >>
>> >> >>   -masm=3Dpseudoc
>> >> >>     This tells GCC to emit BPF assembler using the pseudo-c syntax=
.
>> >> >
>> >> > Can we make it the other way round such that -masm=3Dpseudoc is
>> >> > the default? You can have an option e.g., -masm=3Dnon-pseudoc,
>> >> > for the other format?
>> >>
>> >> We could add a configure-time build option:
>> >>
>> >>   --with-bpf-default-asm-syntax=3D{pseudoc,normal}
>> >>
>> >> so that GCC can be built to use whatever selected syntax as default.
>> >> Distros and people can then decide what to do.
>> >
>> > distros just ship stuff.
>> > It's our job to pick good defaults.
>>
>> Yeah it was a rather dumb idea that would only complicate things for no
>> good reason.
>>
>> The unfortunate fact is that at this point the kernel headers that
>> almost all BPF programs use contain pseudo-C inline assembly and having
>> the toolchain using the conventional assembly syntax by default would
>> force users to specify the command-line option explicitly, which is a
>> great PITA.  So I guess this is one of these situations where the worse
>> option is indeed the best default, in practical terms.
>>
>> So ok, as much as it sucks we will make -masm=3Dpseudoc the default in G=
CC
>> for the sake of practicality.
>>
>> > I agree with Yonghong that -g should imply -gbtf for bpf target
>> > and -mco-re doesn't need to be a flag at all.
>>
>> We like the idea of -g implying -gbtf rather than -gdwarf for the BPF
>> target.  It makes sense.  Faust is already working on it.
>>
>> As for -mco-re, it is already the default with -gbtf, and now it will be
>> the default for -g.
>>
>> > Compiler should do it when it sees those special attributes in C code.
>> > -masm=3Dpseudoc is a good default as well, since that's what
>> > everyone in bpf community is used to.
>>
>> We will try to get all the changes above upstream before GCC 14 gets
>> branched, which shall happen any day now.  Once they are in GCC the only
>> extra option to be added to GCC_BPF_BUILD_RULE will be -g.  Will send an
>> updated patch then.
>
> Awesome. This is all great to hear.

The GCC 14 release branch was created today, but we managed to get the
changes for -g and default to pseudo-C just in time.

