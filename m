Return-Path: <bpf+bounces-48246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7365A05DA6
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 14:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935551882ECF
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 13:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526FA1514F8;
	Wed,  8 Jan 2025 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bTLu+2ZE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EKi/TIHt"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA3E1FCF65;
	Wed,  8 Jan 2025 13:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736344574; cv=fail; b=omi5VT2/+aCofM17HWoI1SwkrDtGj/VAUSJr3aPA7aoWDoG0P38RRKAVwdn7sfge4PX+kA6ps85Mb5SRHIYgJBIKT6ug59TvZ7CKBhhRUuvir/4hgIwqMUqH7UzhBgoMS87LgSz2chB39d+yW/VD7YSL7ilAxYsQ+jIBQN050ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736344574; c=relaxed/simple;
	bh=UU66kmCZA2r5LEcmqxmGIBT1E//iA1beA9hmbpHct6A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WsR+BaSUZICVG3TCwN7LEc9mBau2BLQAM8Yc45jZtu8nZq5lAq6Bw+X8Qy7Jd70qLTnipdFbh6uWxDO7qWPDIDrmKBez9gZeK/gdNmjIs6KLJiIb9yzvLyToePuDoE+5snh8ukGmx4Z5qoL8MIAaUyV/FBNzRVJXVkhYmwtq/WY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bTLu+2ZE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EKi/TIHt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5081uWIM023407;
	Wed, 8 Jan 2025 13:56:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=oT61o7U1aVB3dn2LdHimTN8McTrPT6i0jjJJbtfUBCM=; b=
	bTLu+2ZEb4JsJEZCeeNufe8AGOdWdx5WNer5FFjICogDl7Rcwd4Pch45Ed0ezVEN
	vfsXEMTmkipmzbY0GWr0ydH7lHbZWM/3UbETot35ITd/Sdi3A98+WVtP/72yWllr
	guGtLI3ItNHxt8PwJnvnhCbmfw2px31kNjZ9s+pnF7bq4OqH3xbW09KU1v9DSesW
	JBA2XdyezBXUG5JbmPEjiTHeBii0NOPzL12SnpXiyFxZro/hU0+pMba5Di7Cf0pn
	o8w1k2I3JLwVzu3sNgixWIsScKefLU2B9JhZt9EGrcWvqVc6Q6gyl6tmWwFdtXsf
	lyG4ZVajdH5eyxLBKEoXLA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xudc71em-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 13:56:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 508BpHQ5004828;
	Wed, 8 Jan 2025 13:56:03 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xue9sxe8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 13:56:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/gbI7pD0r+gphP0RbWo7I69nNKaJPNXjwqD9F7Wi6v8vxpnajom4PBuF5UFiu+EWxV0InuDhwvjb5/NyEperCpnL4RpDZuOiXEcjqOIqhCpSC90jCQZboeMPoabTnzFM7GtHx0jO4OE4h7nJTyVVEIAUY6/S2BJtxs6EFWJ2hGmKxI3NSEkuFP93m5j71wy+UD+F4gHDg3u6RUAbHR8ztQU/4FVH0qo7nyfGajm4wVnnfkRwbgidJBpomNTVLcD6eXAQrPziqNJSsT24GAFiZTTIF4OqSZooOB3lYKLTBQw1woxTOdNFSJzmlr0LFm5ncgqGHapzF1wLxzMkNxD4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oT61o7U1aVB3dn2LdHimTN8McTrPT6i0jjJJbtfUBCM=;
 b=Npj8fPsmEEBJssshOALfLHZaxiUfwczovjTEOEEBmhYPW2fJEjLWBD4RAL6is+AIj1ZFphfhs6Gvpr199biTaaj7eRIZgT3zcnDb18HRf8jf4Gk5l5ICV0EyKa9gt1DDdncFYH1nIatvyGqovHFa6RI5HfFOrupbrYIXJt7cSLdOhMWXXjG2ykG7tNbNkz9Xws1ehE9FdJpeZXEW11qmD99f1jDuUN9qjwdFscuS0SjpFTNKghyui094iQFnYIgxZKW67TOs0C6e4T/DAiMtZr7738sGwOjaglF0AVQ/bdatLnbnkMnVnDog/llSpCIc7BELR9sBUx1So3otobgIiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oT61o7U1aVB3dn2LdHimTN8McTrPT6i0jjJJbtfUBCM=;
 b=EKi/TIHtALK+ZMxXK+TYm2yWomUR6oVkJ3jfX9NWayoQTaSrVEnoWCLBoyP+ZRZj2VpRQHkJT40+XDBF/MLqcplq1tKuI3s0hzAFdw0JBw0mApj+HiEo8YDI+JawIlgESsGwiHPnPPQS7I1u8Y5LH+6yESPG1wPrfNhOU2nFEXo=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DM4PR10MB6038.namprd10.prod.outlook.com (2603:10b6:8:8f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.11; Wed, 8 Jan 2025 13:56:00 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.8335.011; Wed, 8 Jan 2025
 13:56:00 +0000
Message-ID: <92a6a095-3a49-4204-af49-643f2db1e3a9@oracle.com>
Date: Wed, 8 Jan 2025 13:55:55 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves] dwarves: set cu->obstack chunk size to 128Kb
To: Ihor Solodrai <ihor.solodrai@pm.me>, dwarves@vger.kernel.org
Cc: acme@kernel.org, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com,
        bpf@vger.kernel.org
References: <20241221030445.33907-1-ihor.solodrai@pm.me>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20241221030445.33907-1-ihor.solodrai@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0081.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::21) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DM4PR10MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: 01c5ebb9-fb05-4b01-b828-08dd2fec2eb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjlGNGY0RVlMTjFSdmpqS3hTcmlRSzRTSzJhMFhuQXBLUU5HNTdhRnZKN2lj?=
 =?utf-8?B?MVJoY0dCWE1yVU5tVXBuZ2pmUWlmaU9nL0FFNHlzTFFVa0hqVG5LNGpkMndw?=
 =?utf-8?B?S3VHdDZQcnMrTFNjUDBrdmUxbEkrRTRPdkROQUdNeUg1cFZFeFgxaFhQTTVQ?=
 =?utf-8?B?THRYQzBkY0ltUk9KQityUGF4UWZXZC9oV1dmeVcxZWM4dENsblRscWZ5RzF1?=
 =?utf-8?B?U3ViQ0E2SHU2cHNvWUVENVFIclIrd2pUZFFmNUJ2T1d4elkxVURhNjVjWko5?=
 =?utf-8?B?MXMxU1lXTUJBU0srQUZJeW9xUmQ5Q3p5eWgzenBObUdlNVZzVmpuT1ZoMExz?=
 =?utf-8?B?NVFwak5qVG1KT1lWcWdKS0dCWHZBeEVKeHQzTjFWcHJOcGZnL1g5YVI1UFFV?=
 =?utf-8?B?L0QrdW1Ra0dXSmEycDhYdHQ3QXdlZU50aTRRS2t6R2VVZVpySnNKdlJRbTJn?=
 =?utf-8?B?YVZkUU1NcHExTkpYempTTTFjYlI2RnY0dUFNVnMyME4xNisxVTdKUnNBQWFm?=
 =?utf-8?B?QzhxNGZPUG5qTDdBaEJ3QjJpZk0vZXEwOVRTVkQzeUJHZnJXZGZXV3BrVDFk?=
 =?utf-8?B?dXZPQkxHTUxxMnoyd1JReDNuMGUzZTU3UGNhV0pwbytvVXRnUjltRmxNOHFp?=
 =?utf-8?B?RWcvc3BoN3ZLZUZLb29SUmVreWt5dm5PSHF6T2lHN1V1cWI5T1M5dVJ4QkFM?=
 =?utf-8?B?bmNBMGxvOUVXUWloZFNkUGRlTnNUc2RRWDFVcncvNVVIb3F5c2hJWldKd0Nq?=
 =?utf-8?B?NkFTQ1ZiZW9TQndRZndQKzNrMWdSU0V3ZGV2NG1FQ2tFSGpydHlZbWZUMlBo?=
 =?utf-8?B?bzVPanVUVmszbnJBcDBxM0xUdDhmOXhCUjhpc0dXUUpvOHp5eDRMR1NDTzdG?=
 =?utf-8?B?K0NWQXFkVHFuN01uRG1rYlpsbVZYWncxeWQvWHhNNDVWbFR6aWlZdHpXb1ZR?=
 =?utf-8?B?WEQyenJOU3dlZVRFZkdVUjBVaU5USm1FalRGTm9FVVU3Y0JHZXAxZ1Q1K2d3?=
 =?utf-8?B?cFVrVnZpam9YREU4c1FVOW84M2JQV0hKMjNXMFBic2xTOHc5SXhNU0FRMUNp?=
 =?utf-8?B?Q2ZVeUZwVzRFTVRESnNjSzY5K201cmozc2V1bFl6QXlGSFRKeCsySXhyZ0FC?=
 =?utf-8?B?US9NWFNkbGJkRzVFQWJHb0JlblFPTVN6V01hWFJwRXVsblFvemN5bFpYTnFy?=
 =?utf-8?B?N2U2Y3FuTTZZMTFPVE5RUEpjS0hGaE9PZHEyUTJoV0ZCWU1RSm1PSWVuMVpI?=
 =?utf-8?B?WDZCNm96T0FuYTBMN0dJTE5ua1B2ZjJXMy9tYnBjWG5EVEFtNWNmTENFVHcz?=
 =?utf-8?B?N1BJTmZ0UnoxSkppb1dWUGlpTzBRZ2QwYkVHQWhrcy9CcFdNVU40b1ZDK2Zr?=
 =?utf-8?B?bS9DdHZ0SlJWWFd6R21aTlpQNWVqVnYvYjlHSTRVa0JuYjVvaVZNM2VtTTFs?=
 =?utf-8?B?RzNKNzEwdE1JUXFna1RISTdTdUJYWEpORGVIY3JyckJCNGc3RmhIcWdYWUJV?=
 =?utf-8?B?M204bVlFTDE4bllCcWNUTVN1R1RUQmJ0eHJPZkNPTDhQOG52dzBESkdlY1Vj?=
 =?utf-8?B?MEZDZmJMWDA5ZzY5S1lPSXhLWmFLOGZKcHRTZy9lT1VjeUpVMFFaMHdJODBj?=
 =?utf-8?B?Wnp0cVJhTU03b0VLaXN0bW1qNm16aW56dlNSM0dhelBpL3RzbjErYzhZTXV3?=
 =?utf-8?B?UDZaYVhZdSthWmcwMnhFUS9vUDdFVFRESjNZSDQvNGFJZXV6c0FkRE5oRk5R?=
 =?utf-8?B?TndoNHpTMTAxNmYvc1dmTXFvUFprOXhWVXdyeUlzaXpRYThLbFdOU2ZuMW5J?=
 =?utf-8?B?QjNiMWYxRkxwRVgwYW9zUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFM1ZXJUZkQ1SDNrWTM4VTQramx6R0dXTWIydzRiWXpkdzkvMnYrNGhuamF2?=
 =?utf-8?B?UnlJdkhqK3gwQ29aMWhXWGNLQ05DRW9IbHNqeTVTMi95b21NRkY5NHF1d1da?=
 =?utf-8?B?Qng5d1JrN2poUk9CbVEvckhveFFEbjg2cjhYOFpveWZ5TWVrdGZ6MVlreUVB?=
 =?utf-8?B?SDU0V0V6U1V6V2xiWHFFRmpNbVg3aXRyNkgvOHVTNU0zNTNka2Y3ZnpybE9Z?=
 =?utf-8?B?QU5hbnVuQjF5NmViaUc4d010M1BzQkxkWVRyOWFWaURVdjNidkVzODVxVkFS?=
 =?utf-8?B?YU40cVR6UkNFMDY2dHVvdWQyQ0ZFU1pYVzc5c3RCRklPODN2WGtYZnVOamZY?=
 =?utf-8?B?WHFQQWp3eG0vS2Y2WFQ4VnhLM1B3akw2RVJuWEJTaENGczZBNks5cW5ORWdH?=
 =?utf-8?B?amZZZVg1SFg2Mk90ZUhmL1dYZzVJZjBhWjJOM3hOaFZlYmdLNnYrbXhDamMy?=
 =?utf-8?B?dHBUSlowTk5GWnltRFkrV1dCenR5TDdXak1rblZWMHFvZDlJTllWQ2YvcEpa?=
 =?utf-8?B?VVF2K2NsS2l4ZjdFaTZpVksrNWg3Y25Hb2lPOGV4eWxxTWZMQk03QzFiREhE?=
 =?utf-8?B?dzBFdkRkT0t4NExkcERxSzRBTEVLUHFiVDVadWwvOHh3TExzemk1YmlYUW9Z?=
 =?utf-8?B?NnFyM1dVcGJlaFlodkh6SWJkbEZnOTlra1dlYUxySCtMN1I1Y0hGRVNKSWRT?=
 =?utf-8?B?TTNTbmNLdG4zUVNzMjYvczlnUjQ4YlJFMFVmdG1qTkVTTmFUdUdtM1RmL1pX?=
 =?utf-8?B?TGVqSUo2Z3ZJKzVOd3ZPQWxiUk9vWDB4ZXY3K3kwRWl2cE9kWVJBY2Via2FV?=
 =?utf-8?B?Y2RMWHVDNG95bVdMUzhkbGp6Sk8rNmFtcmtGOGlDOXJxcXpsekFNNzdrSVpm?=
 =?utf-8?B?dU1ScVVVUWJRNnFTclhKbCtCWTJYbEtrbGhoZitjVWNzUURIR0pVdk9RM0Ri?=
 =?utf-8?B?aWRPTHJQMVBMRzJHczlFTVlrV0NTUnduR3NVSW5rS25aRzdzTjVLZkxRMmxq?=
 =?utf-8?B?RWFveFErTjVlT3VlbkJxb0MraXZhRWZHd3ZqSWxvUkwvcFdvQzlCbndnTlJU?=
 =?utf-8?B?eEhURHFYdm5xOW5MWWJ1YXFwd09iQnRqeW5adEN1ZHlkT2lROWhwaVJzSVdN?=
 =?utf-8?B?Q3ZGRmF5S3dCd3oxNitIVGxoem5mMkI3WmZNNUE4VnlNSThyWmxibENxWFJ0?=
 =?utf-8?B?YkZ6NENsMDJ5eUJiUWZSdm1qelBKZytnemJzYmp5TEhQSWZaNkRrUGQ4S1Zh?=
 =?utf-8?B?bGtYTjFRWmQrRE5mdmZqNG5MUkxiek5JT09ZbjdmOVprcnZRRyticXlUNWZN?=
 =?utf-8?B?K0Fqa1ZXQUxnZ3FySFk4SmxvUXUxYXF5VG5vc0RsRkZwLzBENlZJRWZIdVE0?=
 =?utf-8?B?S2NBZ0NGNnZmZW9SYnRidTVmY3YyYk1BSW92MkQ2eHM3RWI4MmVKQUxrd0c5?=
 =?utf-8?B?K0g3WW1NMVBrdmJhM1JqK1VScFJENzVHdDUxTlgrVGhNb3E5MllnNm5wZVJk?=
 =?utf-8?B?LytYQVJhOFpKcjFTc29qbkk0akVsdCtrY0Z1K2dnUE5oOS9XeXhPN3daamZP?=
 =?utf-8?B?NzgzRFFDL1UxR0JTM1p2VW5JbGFCM0V0aWhUK1FDcEhnMUhTd3oxUy9UWGMw?=
 =?utf-8?B?ZmlEYnAvVFZ3bkM0SVNZK0toMG9MdlNxcTJaMEYwcHhHcjVEWTJqWUpEZEQ1?=
 =?utf-8?B?SkxhN1VYWWNNSTlMM0xJdEVRMjlzcGNTZ3FYYURyR21oaTFVNlpZTXpuczFO?=
 =?utf-8?B?R3pieGhlL3p3UVRFRG5vbk1odU82cEtpUndtVEtwdjdsTDlzQmNVeS9Sbkg0?=
 =?utf-8?B?bm9TZVZnT1ZaM0dodDlXSkVwTGRBaFVkcURIS0FTTk11R0hsOU1ZMGxFUHpt?=
 =?utf-8?B?VkRxRWJUbHBDMVRUZllCUmZOeS9Hd1NJcXZ1bnk3NHh0bUlOTDQ2UCs1SGFh?=
 =?utf-8?B?QkVzcE9NdUV1TVVwb3ZWOFF6ZUpTbG1IczdIZXY2ZlRuQ01IS3hJN01pS3Rs?=
 =?utf-8?B?blZXaDJRdVZ0dmxKQmdBeXhWTTFQTXRjbkE4QmI3Wll5V1I2T3U3NmlaMjJ2?=
 =?utf-8?B?SS81QmF5dnVudTJmRnhMVnN0d1F1eWJydDd6U3NacVpFS25vTDl2UmZCQnNm?=
 =?utf-8?B?NWZQOVA3ME5mVjBKaUdyNkJKK2UzRUl1RjlPNVY4UnVaWGhhOFFzTENodWVR?=
 =?utf-8?Q?15ZJoW5OuPakogpSgQld05g=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QBb1Hq/11k/yD6BDBz6NFk0WVfg9hF03Ua0vM7E4Em1pcImz1Qz8+tHgyDtiHDrJoeVJm3WkgA+4yLZB5F7/7D536ltN4KRsJgHHjnqw/3BE6t/033HhxrDDS7hNRkBmhesRU1g6dibYrPMWG6Hfw+l3+8gvTKlwSKd82UXFQLnvk7luVNlYuoNKi0qNs02dAhyfGMQ66mAZbEBRCidwcbCrnilgpBRvWy8KXjkW22DuQl9/aktminV8xZqFJUhsfiJ7vARd2XTOI2EJoox0fc3hrmOP11m5GHmVpbGD14xbz6TlnTtJd4BQg6GiUE2knZ3ezzk3YAkzreCdJfET6Zh9mfz036kdDkApfCBzYFtUFPlyoUmzY+idlPSW6DtU04B5lQvZz18245obcD4PczT/bwxPg6hZ89qj9OLha1WgJRAbVfMTeBWwlwrg6eZUoyJ8W6bUByoif+aAYIz4i1WMk87fs803l/UR4U6M4ypyBVAyIxAjJ61v8686YbLpCSHHOcH0GKTnjq+j9pjp6lPbg8h3pdPZ6QwxU5U2sRAVvmGOD9AaXaDH3b4rDXTt01lJo/bS+kAMrdcpFpEMK9alY01I9hIKHK2tPWSAlvw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c5ebb9-fb05-4b01-b828-08dd2fec2eb4
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 13:56:00.1737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s5kwoe9fcR4OqxWqENTGogamXkckrxXju46x0SC7GWDuIsxIIWvM9aeWYai5tjU2hRV65QoMZhXhnpNK55lmug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6038
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_03,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501080115
X-Proofpoint-ORIG-GUID: 04-ZK1RhOka1S2Tpf90JAN0OdY8g-9tV
X-Proofpoint-GUID: 04-ZK1RhOka1S2Tpf90JAN0OdY8g-9tV

On 21/12/2024 03:04, Ihor Solodrai wrote:
> In dwarf_loader with growing nr_jobs the wall-clock time of BTF
> encoding starts worsening after a certain point [1].
> 
> While some overhead of additional threads is expected, it's not
> supposed to be noticeable unless nr_jobs is set to an unreasonably big
> value.
> 
> It turns out when there are "too many" threads decoding DWARF, they
> start competing for memory allocation: significant number of cycles is
> spent in osq_lock - in the depth of malloc called within
> cu__zalloc. Which suggests that many threads are trying to allocate
> memory at the same time.
> 
> See an example on a perf flamegraph for run with -j240 [2]. This is
> 12-core machine, so the effect is small. On machines with more cores
> this problem is worse.
> 
> Increasing the chunk size of obstacks associated with CUs helps to
> reduce the performance penalty caused by this race condition.
> 

Is this because starting with a larger obstack size means we don't have
to keep reallocating as the obstack grows?

Thanks!

Alan

> [1] https://lore.kernel.org/dwarves/C82bYTvJaV4bfT15o25EsBiUvFsj5eTlm17933Hvva76CXjIcu3gvpaOCWPgeZ8g3cZ-RMa8Vp0y1o_QMR2LhPB-LEUYfZCGuCfR_HvkIP8=@pm.me/
> [2] https://gist.github.com/theihor/926af22417a78605fec8d85e1338920e
> 
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> ---
>  dwarves.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/dwarves.c b/dwarves.c
> index 7c3e878..105f81a 100644
> --- a/dwarves.c
> +++ b/dwarves.c
> @@ -722,6 +722,8 @@ int cu__fprintf_ptr_table_stats_csv(struct cu *cu, FILE *fp)
>  	return printed;
>  }
>  
> +#define OBSTACK_CHUNK_SIZE (128*1024)
> +
>  struct cu *cu__new(const char *name, uint8_t addr_size,
>  		   const unsigned char *build_id, int build_id_len,
>  		   const char *filename, bool use_obstack)
> @@ -733,7 +735,7 @@ struct cu *cu__new(const char *name, uint8_t addr_size,
>  
>  		cu->use_obstack = use_obstack;
>  		if (cu->use_obstack)
> -			obstack_init(&cu->obstack);
> +			obstack_begin(&cu->obstack, OBSTACK_CHUNK_SIZE);
>  
>  		if (name == NULL || filename == NULL)
>  			goto out_free;


