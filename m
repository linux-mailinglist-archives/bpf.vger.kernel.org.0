Return-Path: <bpf+bounces-61958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E809AEFF3B
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 18:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84A77188AA18
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 16:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F30927A918;
	Tue,  1 Jul 2025 16:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZFGZ8sCb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WL/ILu7+"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1441E26AD9;
	Tue,  1 Jul 2025 16:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751386469; cv=fail; b=l8RXWDXqvC/2fekLn4IyQAJBbM3mmShZKPOwhBpB1TLOee7/2qONZPYNDQlXKmRW5YqKfOcQdUk5cr9rDTNTxPdGKOxE9ITxX+AltopcaailKlgmqXEHDaDpdWU11p8z6ROByFFcF5GEjOdGEHZ8PiZy6TfnFgOx3iuTUUrznug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751386469; c=relaxed/simple;
	bh=nZuNg16SQA0/vZgTZrafsd+BVPhwLF4Icd0J0KFlwEU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K/38DaIH9H391KEPpHKq+MI1Md5aDZo91Tl5HPBrQ4Vd+Y+C4IHdcgBBc6yQXiAGlaVFozzMm8r/NT3eCbN5i8M8FreM3WrAVnXOI31DISJBulfDNp2kKkkFaM1iGW5TvXpchpsazSnqiVXTaD7RADaAVsiGt/rVmImDkoKcpAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZFGZ8sCb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WL/ILu7+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561D9BTX019324;
	Tue, 1 Jul 2025 16:14:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Fbt/tnol9le6uOFXCJZSbcd/0W6vrEzuxj6Lbffj6hc=; b=
	ZFGZ8sCbQY1YyjUnTfIMoBt1cZ6EN/bZlAl51231LcC694VmiQt49sh5fdjBh4Qq
	JgbJfrMFeZE4l4MU9shlzjNx/z8/Z6eqU9tdPcNRbH+zxdUAlCN1EVL/4/pbrs80
	1J9iSkZyk55CrzDmTuzPJFqzxC8pESzdTPLp/wdK5N74ppYXPhQKbUG0EWk4oVYP
	55AQzORPP54ghvTRxvuigfZQOJGgBI9t12WAXoQvB0cr0lLF4UHgYMheWDvzZu6W
	mvUxbizkjeYAvchEMsSD827TNVeQVSt64VFij1nFLLw/P3gbV9LcQwHrlh5S6p3W
	yprViU/hzim3qKtPbjwWHA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j8ef54xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 16:14:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 561F0xHn025146;
	Tue, 1 Jul 2025 16:14:18 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6uh8ce8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 16:14:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7RPpa3dI7Tc6nJIEboAXWNISPIJYe4AB/vIe1BOw8I6Tdyiku8rKWNIyRLRtAA/d9ukIAFoTdDx8j/oJTvHFxuo1jK0lDKmqz/HhJYBel7GN11El7rhqJaKe/3Z7nO9XqewI85JkloX9xpsvsYTqNVMRwtY+8v29ozR4p3TqjQA+My+72B5tHk1chTng9YCWihi4WcCIQn6xZ3AOtTye8oea4OHQiMWkkQeIdCNJNyXgj6dxLp5vxl6R5mnhWe2AWMGt76o1xbdHUDCZlWoDs1GNdu89usr3E9yuicDo/hyA25o4t59TC5kesn+jYQekp5RQbv+42kbvjt6WWPHqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fbt/tnol9le6uOFXCJZSbcd/0W6vrEzuxj6Lbffj6hc=;
 b=g5uIQoUexF3xee0vmKKeeeIFFMOjxIyR0U00iyKUTF86YMmPvOQoKd12mljAwzmkKe6tyJ3vIPOZzzZ4gilIExY9RJYcdzegLi5wU2tW4VvCdAtG/REJQseGdeFD6mhK59mfDMKK1qH6oiliwadf9i0WmD7nSRBKqipz3meR6BukOAA5d2w3veuglP/YROPl5bbBwRr3e/STGu7BvSfjTJmJPQ6Diq2YJwHw7eziC/qYqkWpNpcr2EdJDBtfHrLQzUttWbL83Uen9miOBmrubRbiavnlBgxNKFBsoQui/1+F4XaMDfJpbeZsxGrcVFHtoY3hBqw8+u5FFRLvBYsldA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fbt/tnol9le6uOFXCJZSbcd/0W6vrEzuxj6Lbffj6hc=;
 b=WL/ILu7+VxEb0ATMvfa08r5vLLIYWpQ1aOeskvVlyNW6zxqemUSjsMOfV9qlxAkiRZJnsXDHh+aiAWdxjADxjImazYtf9AlxJ/Dpc4SrgwOX1/ug7LdTr/qkhN17gGwFz6TJxgB4AtmnjS+fEB6J9tyT4WIoy6zFLRaPXTWttiM=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 SA2PR10MB4811.namprd10.prod.outlook.com (2603:10b6:806:11f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Tue, 1 Jul
 2025 16:14:17 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%6]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 16:14:16 +0000
Message-ID: <3b108e2b-f843-4fbb-a84d-a55783667f62@oracle.com>
Date: Tue, 1 Jul 2025 17:14:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 dwarves 2/2] github CI: Add comparison of generated BTF
 functions between baseline, change
To: Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org
Cc: bpf <bpf@vger.kernel.org>
References: <20250630101537.2680289-1-alan.maguire@oracle.com>
 <20250630101537.2680289-3-alan.maguire@oracle.com>
 <b9b2e516-5591-4c0b-a1aa-6fa89f002181@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <b9b2e516-5591-4c0b-a1aa-6fa89f002181@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0121.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::18) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|SA2PR10MB4811:EE_
X-MS-Office365-Filtering-Correlation-Id: 34367038-9d86-4262-fda5-08ddb8ba53db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGg5Q3QzV3VmYmZUcGs1eDV6VGtyRGVOVWdNMzNDZ080a01ORC9PWDJtb2ZG?=
 =?utf-8?B?YWN2ZlNhNGx4N1dLZ1NHVTExdzM4MXlpL3ZPUFNhYlgzZkRGS0xwVXBqOWYv?=
 =?utf-8?B?Q3Q2b2hOdWJweTk4dVZaZW1kUVhJR2xEdTBFd2xzcGtHSlZNdjlqU2dnWE1U?=
 =?utf-8?B?SWcyM0JHTks4anE0Y0Zockc3SUcwTkl1V2RneUFLSnJhNGJrcXhickN3N1dR?=
 =?utf-8?B?dDl0eDlMUlFnK3J3Zk1rRkhpYURjdkxWVldSOGprOGZsNTZKbDdsWnJaWWMz?=
 =?utf-8?B?ZWRWdzRWMlQ1WDhiSWZ6NmJhME16TElIWTZsZG9uc3FIQUpReVNFbkd6V09q?=
 =?utf-8?B?ck5ibkR6dStIa1RpQUtHb2ZqR1kzNTN1cU5rbXoxSXpIaW1ZWE93S3RmOEJU?=
 =?utf-8?B?RFNKTmhEUWhiQXcxSGRFU09PNFo0WUV3UUd4aVZaaUE2Z3BSZUlqL2xsZ2Zo?=
 =?utf-8?B?M3RpczFBVm9oQ0RmY0NOZlVlRjBBd3RrRXdxNjlFVTJ4emdvYzVRZVBnOWlu?=
 =?utf-8?B?cE93TWE1U1RBWXh4aHA2cUVoa0NyMWxPdytDRFg5TzB5V05qczVMNDRxTHJj?=
 =?utf-8?B?R3h6V0xQZjViQWE0VlRqTXVRaTJGVnNYQWJQb1dXZWNpamcvRkhLYnh5ZUpC?=
 =?utf-8?B?dUxwK2hQbnp3anRIVHNtN3RSeGFsaWpWN3c5d1JqdUFSM0xUZ0lxR3IzZTVV?=
 =?utf-8?B?c25oRmlvSlNLWk8wM0luRUE5eDdmZHh6d3NsY0tmNjVZY2VTVWVzd2svRWxu?=
 =?utf-8?B?VmtObytBbjkxcTdzdkx5VHBGOW1lVWN4UitwZkswUFNUWGtwcHd1d1BkbldF?=
 =?utf-8?B?NHhGbi9FdWF5bGRobmx4WWhKelk4ZzI4Q2VjNG0rd01hVFN1T2NhZFFKYUxu?=
 =?utf-8?B?VExDSkVMZ3puaXVQYnkxNUUxazNlZWRobTk1ak1YaVZaeDgvcXMvaWtFYzdj?=
 =?utf-8?B?a0RXT1FpdXFMeTRUYk9XYmFGN3Uxc0d3aHRKdURoc2J1MjlvYTZXMWhJZjB4?=
 =?utf-8?B?Y0pWTzc1a0xxMUgvdTlDcWdtNXdZNkZ1V2wwNmt6eGZhRFFoVWpSV2g4RHN1?=
 =?utf-8?B?YnR3M3BWNkZ2YzZtczhkQWc5S1dKbSsvQUk0aUJnWC90S2l2MTA2RFRnSkVr?=
 =?utf-8?B?cWYvazZGUExqSWZHS1BOUVlHL3VJeHc1REJ1UHk0QnJmT2RhdktLTEIwZ2Zi?=
 =?utf-8?B?MU5IN2pKMVdlclhBRVg5aTJVM2JPaHdUenEzT3MyY0JoNWZra0dJTEU5cTJa?=
 =?utf-8?B?d2xkbGpFb0VJL0hlSWFhN25sdElIa3R1NCtOcS9TS0ViQjcxM0cyYndZZ1pr?=
 =?utf-8?B?aWZrSnQwQk9RZEI5Y1BpaGVIOGNUK1VROUQvQlA5cFp4dkRUNzh5VVVhS0o1?=
 =?utf-8?B?QlBaZTJhbWpPL3R4aEZjK0FtNjVQTGRMbGRCMDZpSktsU3l3NXBGWVlaNUV1?=
 =?utf-8?B?OWJWUHJmRWxLVnZFdWU0NFZrWmJyV21vcFcwT0F4U09tNnBLUFlMdHFPczRB?=
 =?utf-8?B?S05EUHFPejZTUk9EejczVW9raEp1ZFJZazFLZ2FPL2hnWmNjU2pKQzF1S2lW?=
 =?utf-8?B?Z0paL1g0ejgyMUcrTjgvQTFUdmV5cU8zVXJvOFFQUVE0QTB6bDBOQnF1NFd4?=
 =?utf-8?B?OGNBQVhUeWYwTWtMVWZXMWcySmtPRmVJdHFha2dNVURPWFBxTDVnLzltL0dG?=
 =?utf-8?B?N2UzR1JSOFNoci9jaXdLNnRYTnVSWjJrZGhNM2ZaTTNKYVNMVXZZSC9KcWQ1?=
 =?utf-8?B?SysxMjZLRjJZd0dpS1lpZVdrTVc0NmxXSGhTM1Byd3VJSEtlYUh3WXNMeElI?=
 =?utf-8?Q?OiGJ9kZULGnutt1RzyOM8A4F0hvIQxXX5pH8E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTE5bzFQVkFqcXQwUy85Ky9yOG4rUHI0a3Z2cGdaMU5iQWNzMUhvTm9jbWky?=
 =?utf-8?B?NER5eUZBVmNLNW1kMzFSRS9saXhkaFgwaUtUdmJPd1VLOTlhSWQrY0IzeFBk?=
 =?utf-8?B?M01YOEJqT2hpNDBQaVhKZ09PN0JsVFltQndCNlUrUUVXUjdOT0hZbk44T1BK?=
 =?utf-8?B?MmIrdGlZWmxid3Q0MlFNN09SK3N2bUkwUnlLL0owSjBvYkw5VUZKbGdGdGFN?=
 =?utf-8?B?ZTJmR0IwTXpGMEJ2TDVuK1llcjdPQWNxNWs2Y1RSWmg2MmgzeEZxUWlkUHpq?=
 =?utf-8?B?cFR3WHZwekl4ZjlBRmloRUFWUDRVZzE3THd2RmduVXNrNUpOYWxUL0NkNFNi?=
 =?utf-8?B?bzVCaE5pTjNKWGtiVENXRjQ1YW9tT3UrejdpaHBHak84NTBlM0J0Q29WWVdI?=
 =?utf-8?B?eGVCN2tmbEo1QUt0dEVPVHdkdlBCTVRUcmM3RUd1Zk0vZXZnUTE0cWpjaGVM?=
 =?utf-8?B?cGRRUG1TbWV2dVhFUklCVG9obGRCS0o1dGlZZ1ZHVDRxK2czZkpRaUNSTGpC?=
 =?utf-8?B?YWpTcUF4V3AzOFc0c0Qwc1FSYkxyczNVNlpZdEN3cm9BVWVwR0NFYjB3OTZK?=
 =?utf-8?B?dVpDYjhnSS9rb0w4VlNyMXJkRjl6YURUZHlvMER2cjFqc1JSOHluWHl3S284?=
 =?utf-8?B?K0wrUjNBeTdybmZJUlZNU3BKeFpHMWFPdmhVNm5oaWNGVngxMkUwK1RrSGhV?=
 =?utf-8?B?STNvWTU3ak1LMVR4Ung2VUU3Zyt5KzJXQ3NJRGh2bnhRdDkxZzNDcWxObWNn?=
 =?utf-8?B?d2REaDdqNGYyMEdQbzNwS0M4K2UzcHEzTU5Yeko3ak5tTjRFU0RoSFNId3pR?=
 =?utf-8?B?STdJZ0NsVlUxRmp0dGZsc2JlK0JjRmFUa1N5TlZTVHNxT0VUNlIvSHVxcitq?=
 =?utf-8?B?RTNHOUkyQzlGZzRNWnQrMGlocVdmdlhnMFNLMldaWlNYMDZYL0VTTWVRaHBQ?=
 =?utf-8?B?eG5HMVNybysrL2VPZlN0WlViOWpJMlZGRm5jV0UwRU54cnBOcFc2N1BpRXpN?=
 =?utf-8?B?cTkyaXVJR0RJelcrK2R6dnpoZnltR3RQaGExM2tBT0puVmFiYVJoZzNBWFBq?=
 =?utf-8?B?U210Y2VLcmhuY08zQkZoaXA0TkhvL1lrUC9YSWFpSVJsV1hzWmRQNjdHTVVN?=
 =?utf-8?B?Y3JYSU5KVlV0UlNqQkllK0NOc21JcmhsOGZkQ24zeWNTYlpUVnc3aUNYaUVm?=
 =?utf-8?B?V3BwZ3h5RzJ6ajcrRzFTbzY3aFF0VWl6ZHVQT21JZGtQUWFZbVhXU1NPVG9M?=
 =?utf-8?B?WDBFbktSc2RBT2F4TUxzbjJSQmlrZTJ0MU9qWTNieXVQZTVDQkh2OFBSd2NG?=
 =?utf-8?B?eWcvNnk1MU9RTFphSWtXMzVIbDFyVGxUaEkxSjFuV3VpNFQvNnMvNUJXbFVW?=
 =?utf-8?B?MFIySjJjN2RvbjRYK0VHRkdndEJLcnp2U0p4QzdJOFJmRkdHVFFKem9lL1hF?=
 =?utf-8?B?azRkVjEySVkvT21ZSHk2UVhQQVlYOG9Cc2RNSFJZWGxpTExKZFFaREx1K1NE?=
 =?utf-8?B?K0F2aVQwTm94bHU4SmVuL2Z0bmdvR3ZaOGlNQkJoOUxEU2lYQSszQ1p5dlFu?=
 =?utf-8?B?ZTJPc0RwYnYyNmNkazBMSzJQSFFrSW9MVTI2djlyK1QyQkdWTHZVYnZuMUpH?=
 =?utf-8?B?QjRJbFdUMStxOXkrRWkxZC9HdHpaT2RqUEdPcVMzVmpEVXJxeGJuNkFzRGk0?=
 =?utf-8?B?K0JzUHI4YlAxYmp3WWIxRnZWZFhqWmNjS245eTRSSkp2UitQWjdaUTJVSnFX?=
 =?utf-8?B?b2phOW9iUWdycjlBV1FpOTJJdzF6aW9lRXRwN3VpVFVRRE5yMjd4dTkvUEVC?=
 =?utf-8?B?T01MRTNBYkJpRzhWanZBeldaYSt6eTE2Y2t1aFNVQVlBMW5FeGxzc2U2RUY3?=
 =?utf-8?B?eGNhYkQ0NjRRU2pobnc4ZEQvQ2Jocnp3SFVYb3dhc01aMEczUVgyRHlza2ZY?=
 =?utf-8?B?dXcwbzhZaWIwdk1vN2hPc0ZuZDZmWnRrOHJIY2RzbHlDUnJhc1NIZXc1Zmtz?=
 =?utf-8?B?YllwdEpreEQyMVNReWN1TXR5U2RBT216cVlZeGo4aDh6YUROUGNWNEFCNTNQ?=
 =?utf-8?B?ZDBHZm55QVVSVDJqdXAwZzRKYVNrRjU5MFJsUzEvd0ZpaVc2TC91T2FzQmgz?=
 =?utf-8?B?ZEdxSkgvNXVUSzFqM2lNaXJMdFNlRWkwTm5Ub0VQK1BDcW80OEhuQ2VSMllX?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zW7OyDLTRZ4h+EtJQj4550CNMU0aw+YBG7EAhLa5OukBGDJnOCCDg200iSxr+fO82SP51ZXe5bWjfirDZe83PBhkledoC2sPZbLPls4fp8k7FqXYO4WM0s8jUllin0LskXGKJBZYvAapSRqLX9B4x6LHdZ7tSw4h1pX3cev0Osrp69liJOD6CGW8W+jq9PRpwNf2Wf98q9HQj5tJzOw379Bfo9iy1iIh4dahnTeri8FvQ5ORludMnZVCFEZYK2O8kHER8WSyWVwhNe80O/IURv5PlD1cO2R4HSnMsPuJQGGXI0HOLfiUEhuNUM9QSK1qF4zgG1w2XzIfzoFK0TE7QqdcC2ywGKKCcBdtgJGNWhgVk2gJEbRTuH4YtxBp7nUjDA/Dh1+zC8r1bvI7JJCk+kS4uwQ0Rygoxcg6rRyhvKvQQZWo7+qPHWoAP+DiOLJ5h/8MZcHrijiQJok+Tc109sYl7lL/6oMz+obmYHrv00AlMwakkXXCG5O7m8zju9bDVAb9nv8c0tajK63oLdzUHKw35sxogM99ZY2mRGma8dX25S1LbujyRGtyTfUyd9aM08ljAk667MdEo7MGQwhukI+HiZvhTe6ZHQCFHvXZuyE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34367038-9d86-4262-fda5-08ddb8ba53db
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 16:14:16.8724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hAPlEAm6KU16Iv0O26rZC2AotBsco6xKdjpKjNCAl7w6ICwgyodDQy+uY4xy1AbaoMNl4Jj6oPo7Y00qgOcupg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4811
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507010109
X-Proofpoint-GUID: JTclMkD1R9-YsX360hpX4lkhtE8lZUkp
X-Proofpoint-ORIG-GUID: JTclMkD1R9-YsX360hpX4lkhtE8lZUkp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDEwOSBTYWx0ZWRfX9x08rIkiKV/5 5ttVYDGiNnt9wrUk6Y1geb88Sterhl3KGzkTrsCIwGau1Kykwjkj62A5UyiZBPRpF8+trReqqJh uRONS2+WcKEP9vXM4VcCg3pRL7r+MHeXmnT4QSg3f5eX5BIXAmMzhdI3AY1IjeX0/eFHVJOP4sQ
 mKkRcAjwQ2FbxWceaXSEMIvCvFCwxkzUHSAodSvbiHTR8hyCN54ESQDLKLtKE3PFGn4yKICz+jc 7G8U5d/QYCDnhD2BvzhJI1B3GmABIHWG9DVGizyXds4lAIoOmiv+dbd0nHr1sYX0H/Pj6tJmntw 6gKyec3Jt7W4o/nIh6B0Snyiod+UWxN8o6HjFdJw0hCr6yl+di6C6CFfmnANT/EyZjbTDPkVVPt
 oKjf0MF3RjIXTQsd01R84qsSgbcRVZizXzC/gw5boaWRm4kvKNP9xl8KimZnQ40KLZs+JBeL
X-Authority-Analysis: v=2.4 cv=ONgn3TaB c=1 sm=1 tr=0 ts=6864095b b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=yPCof4ZbAAAA:8 a=OVtxXx6tAogRlQXLEZAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13215

On 30/06/2025 19:36, Ihor Solodrai wrote:
> On 6/30/25 3:15 AM, Alan Maguire wrote:
>> Sometimes changes can be introduced that modify the set of functions
>> encoded in BTF, or change aspects of that encoding.  Add a non-fatal
>> comparison job to compare between the change and the base branch,
>> by default the "next" branch.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>   .github/scripts/compare-functions.sh | 30 ++++++++++++++++++++++++++++
>>   .github/workflows/vmtest.yml         |  4 ++++
>>   2 files changed, 34 insertions(+)
>>   create mode 100755 .github/scripts/compare-functions.sh
>>
> 
> Hi Alan. That's a good addition. See a couple of comments below.
> 

Thanks for taking a look! Replies below..

>> diff --git a/.github/scripts/compare-functions.sh b/.github/scripts/
>> compare-functions.sh
>> new file mode 100755
>> index 0000000..062f15c
>> --- /dev/null
>> +++ b/.github/scripts/compare-functions.sh
>> @@ -0,0 +1,30 @@
>> +#!/usr/bin/bash
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +#
>> +# Copyright (c) 2025, Oracle and/or its affiliates.
>> +#
>> +
>> +GITHUB_WORKSPACE=${GITHUB_WORKSPACE:-$(pwd)}
>> +REPO_TARGET=${GITHUB_WORKSPACE}/.kernel
>> +VMLINUX=${GITHUB_WORKSPACE}/.kernel/vmlinux
>> +SELFTESTS=${GITHUB_WORKSPACE}/tests
> 
> nit: SELFTESTS isn't used
>

good catch! will remove

>> +export PATH=${GITHUB_WORKSPACE}/install/usr/local/bin:${PATH}
>> +which pahole
>> +pahole --version
>> +cd $REPO_TARGET
>> +pfunct --all --format_path=btf $VMLINUX > functions_latest
>> +# now use baseline pahole for comparison
>> +export PAHOLE=/usr/local/bin/pahole
> 
> So we assume that the baseline is installed at this path?
> And that would be an installation done by
> libbpf/ci/setup-build-env action?
> 
> I would not rely on that behavior.  I think a better approach is to
> build and use master (or whatever is the baseline) explicitly.
> 

sure I can change this for v3; likely patch 1 will be changed then to
pahole: 'none' since there's no advantage in building pahole as part of
the setup-build-env step.

>> +rm -f vmlinux vmlinux.o
>> +export PATH=/usr/local/bin:${PATH}
>> +make oldconfig
>> +make -j $((4*$(nproc))) all
>> +pfunct --all --format_path=btf $VMLINUX > functions_base
>> +echo "Comparing vmlinux BTF functions generated with this change vs
>> baseline."
>> +echo "Differences are non-fatal to the workflow, but should be
>> examined for correctness."
> 
> You might find it useful to dump a formatted diff to
> $GITHUB_STEP_SUMMARY, to get a rendered output in github UI.
> 
> See here: https://docs.github.com/en/actions/reference/workflow-
> commands-for-github-actions?versionId=free-pro-
> team%40latest&productId=actions#adding-a-job-summary
>

great, thanks for the tip!

Alan

