Return-Path: <bpf+bounces-75684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A047C91125
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 08:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 09C5434D79F
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 07:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7402DC33D;
	Fri, 28 Nov 2025 07:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p9Z5FOl8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cw/A77P7"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AA927B32C;
	Fri, 28 Nov 2025 07:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764316431; cv=fail; b=nkRXVaBqR50vGIBi/9SHUQiz5RuwEcKAo9dEW1tU2xL2caQ3Q2a0xTm+Wqjs4vUMeBVs0y2oS+25IoHzcD7gpg1WEgWKs3ZjrtWk1S5mD4DR2AgZolS4JhaSXlKot5i3RkhWhKuupLhe8lzTIjJYWKF88RJNLW/8MoAuxN68O3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764316431; c=relaxed/simple;
	bh=eMZO3r3Z6ghJPws+cDwHxLgG1jMgTfGyHMADF+PgIZE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rvv2wMjEL8SBdQebHDYiasx5rWOreMEM/gEw44o4Qaq2RGT1+P0ngsFaVRM3f0kiVeMI318YB5Jw5oMjFEVWq1O5O8Oegn+U0hKnX9Y1qf7tngLIdnl3Q+/I6y0/tvoqY6A/S60MtqTvOlVu8dn2MYQ8v++itYKyiN9Rxt6XDKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=p9Z5FOl8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cw/A77P7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AS3LrNv2479112;
	Fri, 28 Nov 2025 07:53:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=e5L72eFLvc33b582yKUe8l7ZITCQhCnZbotZONYz9ak=; b=
	p9Z5FOl8HrOcGbjLoHbVK/ce9qStp9/jQWhYpWoyOb/b+UMzWBaicYmGALkEvLbV
	lfobRMreePuk76PD1GMVz8IdZP73nF6wL18NWDeaLhXJYOgkdscN/V/cZzOZc61L
	6yaifw+M1wyhTn9R+L/kH/MnAMLeQEFBuyUdIt28uLIh3zBY6XZdl/mG7CYsUFd8
	7vqn+WI72L7XuXPNu8hjiO3wrGMhO8NypFXnrHuSLb6qy5fnVdVqX2t2BrGDPori
	/Wdbr4Ebp/NGOtFwSKaBONKgfDVqWrseZDzZYbDAj9OlBE5mfbdpAF9/+5ax9sGg
	CQOC7t3Tj760o2IX7eiNUw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aq3s287qa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Nov 2025 07:53:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AS6bfXb022165;
	Fri, 28 Nov 2025 07:53:41 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011009.outbound.protection.outlook.com [40.93.194.9])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3mgs0k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Nov 2025 07:53:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QuRGJLZLJe68iGnG84YuIqJDa3HFfPzZl7Xqfw6JN3j3KP5X3aANDuHMelDkz+3KtJP9E6w2zd6DzpUhiXgb8UNlv04EmE1XlRAyv31uIOJcANEx/RQkj272OTqmIq4B17KVTIHb/RntpnWSv4JKVq0Cr6tHopQFVormHGKstUUD4vko0pjwFQLykTsYTtjl+DHzXl4bf5vGalW6sb5id7hJs5nUuylcG8WB4EwuQdYvJGKBAtZwXihd/eiGamEknSJOwi2B6g3gcR6/T//3sD7lfjD02QUZZHvhURl1o3tJQnGaqIzsMdk6lhYWVNEIVSSm2TRcB4zWdIR2+gNF5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5L72eFLvc33b582yKUe8l7ZITCQhCnZbotZONYz9ak=;
 b=REW0/LCvdoynEpx8G8XDwcHZ/JFZ5m3+HrjnixU3PR+ZLjVvY13tYRUDYyS99z4Ll9Rv+nRPgCktj9zHNriqOdvzN8uW/MUYdiPUR76Z8rESW+qM5ralnbQzJ8EwDitOX+QiCMy9VuvQ1ymr2oJEsuajx4qRPHz5cs9sYBYzudS/0sOP2s/tS7o5JvQbSk5VUjgWSTw/0UuBIHzYVDEXq6M15RWa4lzeQCIpsQq2jcrZi0xDK9T1LO84rcNcdqjQF5r/Qat3TP7l/t6tFlcnxU98OFJEeF7HLjJRjdP9aQ/jovKw7ry0EuV9z6n0vV2WsRl3zxiVjvrMPIJP/L/N2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5L72eFLvc33b582yKUe8l7ZITCQhCnZbotZONYz9ak=;
 b=cw/A77P7I8ZoViCoCBFaJTVQBFzQa/KroIGcv4Bq4XDRK43u/qhameTuA4wnY42gRUv4lLw4ys3vpsgSxkG4TNwnS7XyR4qDdfmxeczlVVtUWMEE3QD9XLJUMzCjYX1tPjR5PiZjkCTIFzTSVaoSVUBVlgiABfp2ZpPIBGxVTeo=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 CH2PR10MB4376.namprd10.prod.outlook.com (2603:10b6:610:a7::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.16; Fri, 28 Nov 2025 07:53:39 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 07:53:39 +0000
Message-ID: <a9643691-f456-4414-a13f-a50abf1ac8b4@oracle.com>
Date: Fri, 28 Nov 2025 07:53:34 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: kernel build failure when CONFIG_DEBUG_INFO_BTF and CONFIG_KCSAN
 are enabled
To: Nilay Shroff <nilay@linux.ibm.com>, Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <42a1b4b0-83d0-4dda-b1df-15a1b7c7638d@linux.ibm.com>
 <aSgz3h0Ywa6i3gKT@krava> <214308ce-763c-47a8-8719-70564b3ef49c@oracle.com>
 <65e3ff98-4490-413e-a075-c1df8e7b2bd1@linux.ibm.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <65e3ff98-4490-413e-a075-c1df8e7b2bd1@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0045.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::14) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|CH2PR10MB4376:EE_
X-MS-Office365-Filtering-Correlation-Id: fa858a92-a1e4-4529-c563-08de2e533e08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|3122999012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bG44eDEvQzFGSHN3ZWVEc003SG1ZMnV1RXJRcEF3N2p0QWNtYVNNTFpxbk9B?=
 =?utf-8?B?ZndwQmZPU1RuaWRPZ2FjN2VCUU5EV2g5eE5WVWZjb3U5clEvZExnOTU0c1Ex?=
 =?utf-8?B?MVZpTFhHbGJDMHkzNEcycTd2Uk4wZ1F2Rkc4bjZINUx5d1pWWlpSbldxbG5H?=
 =?utf-8?B?MGJmTkNVMlZBdGZXY2N3STAyRmxCOWpvaWphdVhmaTJnWHhrNU1OWGxJYy9Y?=
 =?utf-8?B?RE45eElrZ3hrWXJXTXUrSGJQdUhXWGZhejF5M0oxRk0yREY3TGNFVWl0NC9N?=
 =?utf-8?B?ODMyWlNScEVPcnpHdFlIbSs1MFRTZWl6WDNiekRoRkFzY1pwdXl0MEwwQzM4?=
 =?utf-8?B?TGFMd3Y4VGVVejJHOHU1ckpzcmd2U0RvajU0WDF4TjcrOUFIaGlGT3NKOGl1?=
 =?utf-8?B?bHk1T3MxMFlta1lhODBkeFFVU0FmNXY4Vy9TSWVoeEU2R24xQVAwVGxoWXJa?=
 =?utf-8?B?UDJPdkdHZk4weXgzVlB1MGpoSVJYYnY0UHZrUXRoVmZKNko5TXpxMVRvUzUx?=
 =?utf-8?B?NUNrQ0dyYzVxUmhQd1NCOENUdGc4OEdvQ1lnZnZiR1hZcDRZRnZoUGtZNXJR?=
 =?utf-8?B?UTdLNXB5V09YZVV0R0FhdHRCdi9scDlUVzAzTnVsckhVYmY5cmhHZjNQcERJ?=
 =?utf-8?B?cE1ES2JuK1hJNktHT3UzN0ExM3d5V2NWQ1gxckFmdkRoOGl2QXBESm1SdFZy?=
 =?utf-8?B?UE9aK3lrWEYwNG43dXhnempzSGxaZFNMclBZa25KTll4bm84LytUaTJQS082?=
 =?utf-8?B?ZTNoa1JPYzdQN3Bva0dYb1d4U2FNZWdROEFBTDErQ3ZOS1czWUVzVVgyeE15?=
 =?utf-8?B?N2wxWklPcWdjVnhRZGNNZ28zUFg4T0QvejRwem9ObUorbHNROUZZaU84QlpQ?=
 =?utf-8?B?cW5GdUp4R2JOc3B3TGZxUnJMZHgzZlBYTTZEcmt0bEU2TnBuZEgySzhyVXRy?=
 =?utf-8?B?TjRTQzhRNDgxMEJqd3FveW5kUTAyTzQ0OU1yVjVCK3ZYbktlTWYvYTlvdGNM?=
 =?utf-8?B?ZExFbzh1SU04UkU0cmozWXpkTldkTVBaUjJIK2I3RkhiQmwvbU9hZGxLKzJl?=
 =?utf-8?B?b3h2OXFRSU91L2hEeDFPcjFnTHBvTjk5VjJtVWZkdHNUK1BoKzBzeEt2blVK?=
 =?utf-8?B?RG8wNzdlaDc2UHFrWUVBMGZrMHMrS0Y2YndXcUVpczZDSlg3R1F2RC9vZURm?=
 =?utf-8?B?clpkQk9PRFNyNXFONXEvY2lsWDVJaTVDMkJDMy9FNWVCRFhnK2lsbzJIY0l5?=
 =?utf-8?B?VithYjFXdzNncXZTYVlXMnRJd2RFYXloN0piajdobEJTLzFZUjVmWFdlbjVz?=
 =?utf-8?B?TWdTRGdhSEtrZ3ppUHA5VkhyYkllbFBVSzJaMXh5TTI5d1lvTktOejNaNGx5?=
 =?utf-8?B?OEhwYWxEK2hmUTA3RVBaMHpUejYxTUcrTEdHWjZGRUtOSGRySTVIWTFxanQ3?=
 =?utf-8?B?Z3JjWHlJRWpqRG5nT2prQm1NVVNleEdSK2djNGVrS0F6NEYrRzBIWjJGaVcr?=
 =?utf-8?B?Mnhoa0s5MGhKYlV2Tzk5dUd0cUkxb21SRVBmRXJIK0grRkI2SFN3WDNrM1hT?=
 =?utf-8?B?djM4dTJ1a1lpVjdtQWFQUi84NFRrVmtrWkdvYjdRVkpHV2I2NDlHT3VUa3hj?=
 =?utf-8?B?SzYwdlUzOHd1UEphWEhSWWhUNFFxTE8wcmU3SXNCc094aXl4cDhidVovS2dR?=
 =?utf-8?B?ZERWbDRTUjFKVW5tOGtmYTN3SmNPaUpaejB4aDlHRmZhWnBhSWo0VnFOb2Y0?=
 =?utf-8?B?anZvQWZxaEpsTVowUExYdVFtckZrQWZ3TEtUUzFkMlIxckkrNlEyOVBTdUVT?=
 =?utf-8?B?enRpMStUbTdHZURyN0ltYVB4VHRJVUpGbFpzaWpXUWNGUUl0Zkhwb1dzenJz?=
 =?utf-8?B?Ynh0TlhBSG91K0hpVXNsTS80eTQ1V2o5a2M4cTVwcWp4TTQ1ZmdKVi9HOWs2?=
 =?utf-8?B?bDQ1TWJzNlF5ajNwYnE5THRFcmd6OGdvUEJ5bDJGcVQ2Tklmcmd1WDc5bmdO?=
 =?utf-8?B?TnRmei92a1d3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(3122999012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnhMcnJSN2hKd0VWOGprbVZBenBNTlpZVFJxU1BRZk4yeDg3NTcwWWIzOFRJ?=
 =?utf-8?B?aE1CVUVZWUFqUlJCcXRtVGVscmFvMVhJcjNXZ1UvczNSYjlsSmFMMEtUaGUv?=
 =?utf-8?B?M05tQzY1VVBPUTQ3cDBYWFNWRXZkNE1vVU9PbzB3WG1tbkMvZ3BYTjZaZkEr?=
 =?utf-8?B?K2pGbG54WVo0NVVZeFFLUHZ4NS8xQ0xDOVhyLzB1OGRWL2dTY25OaGRuL2k5?=
 =?utf-8?B?YkpGNVpQQkx1R2FFQXpYTVJIOFpVUmVValhJL0xFZWVpWnUrallSaDNoWGw3?=
 =?utf-8?B?V1RpK01oa1R2TGY4UFRHSjR3MU85Z1I1WXA0ZDE3VjU3ampDQStzZk01emVU?=
 =?utf-8?B?OWw0UnBtZTlMOG5palYwVDY1aWhIYzFYQ0Q3WGFmS0NRRFpnSnlzRjJoWS9w?=
 =?utf-8?B?YWxjdkU2aUJFOFc4bVNQUXZVZy9vZFIrNHpsTlR5NzNFSlJLL0dwTUtIMkZp?=
 =?utf-8?B?b0J0QmdqS3FyQ3VXQXQ2Z3BBMVQrWkVzZ1BJR200ZG4vd29hV2xRV2dsV25w?=
 =?utf-8?B?SDMwNTlvQmpwWklhWnQ5dkFZakpwOHNEdmt3dk01a0ZzaDVYQjBQQW9ZTVZy?=
 =?utf-8?B?ZTQ5a3pITldsdGl0UlpPVFZGR3hBeTRqdUVlZTZ0YzgyN0dvMzBoTXEvN2VV?=
 =?utf-8?B?d3Y0L3JEUWcrbjlhVUFEczJjVjVXRm12UE12UkF6M1VBeTNqajRuZEFOdlhU?=
 =?utf-8?B?V1pvb3pTSkk0ZDExay9PSG0zRkorYXZzK1ZYYnE1a1hCcjNsN0c2dzRMOXc0?=
 =?utf-8?B?ZVJTbGVvemUrRkZLQ3ZyVlQ1N0FlcndJNit0UHJBM3RmRzlWa3phOGdnMmNC?=
 =?utf-8?B?bTRoWkNZdDVyaS9wYW5LZnRmcFc5aHdjYW5UNTFxODFnNEtONTk0a2REWVN0?=
 =?utf-8?B?Z245L2ZRQm9uMGd5M1lHU25QcWN2UmR2V3dkbUZUUXZ4OVNWNi9Wak5zcGtF?=
 =?utf-8?B?bG5XUzhYT2FUYlhGZE0yOENaTzBzS1BEdHFRYmduS01YZGRzb2xycC93UmY1?=
 =?utf-8?B?NEUvQ0FyV0c4ZjlVR2lGTEdWc1lMVjZ6QTB2VVVocHA3dnBsakFCcG0yUGRC?=
 =?utf-8?B?ZkJTNTVMV3dLcUY1dlVtcVVTUUJhcW1YTHNDSFIzRGV0dzRkTXd2NTZRajJ5?=
 =?utf-8?B?Z2c4S2FMdzRDcStGcXZTTlU4UnMyek9lOWZOY0NGb1lBNXBWd0o3R1lWZ1h0?=
 =?utf-8?B?dFl2cGJ4MDVWVVlORUFEYTA5NUhrZmxlOGY4RTlNdzhJejBlRW1OMVBvQlM0?=
 =?utf-8?B?dzlhRnhac0JBOFNVWmRHWm50bnFKZm4rS28zVHlncy9keFp3WXNuZWZpNlFE?=
 =?utf-8?B?c1hoU1N4S0FZZ09CWTBKL2V0NGsxeGVvdm9mcThoU2tvMmVXNHNXQTFxalJz?=
 =?utf-8?B?eTRoSGxKaEFXZWkwam1EZXprS1g0WjBKYmdGQkg2Q3hSS3hLcFBHYnRBS3R1?=
 =?utf-8?B?VWpuMTFOVUZqbVQ0ZjdQYlo0aHNkTWRDMmhkOWg5OWd3NFpvUW5PWWcwdTZt?=
 =?utf-8?B?YnUyZVZOTVpTWThqQWdEcE8ra1ZQczBlckxncklDampjell6RmVkQ0E1ZGJU?=
 =?utf-8?B?aHI3N2RLNUdaMTdRUUZiUE9ITFNlQUkwSVZPTnhQOC96SlR2d0Q0NHZVN1FO?=
 =?utf-8?B?cy9SOUVGeHVaejBHUTFnbjhJbnZKdXVEY0lPRDNabHVmUU5zdlFjUnpOaExh?=
 =?utf-8?B?R3VjZ2pDam1xcno3aVFJY1N2bVFobk4yRzM5YW9WUUhySnArQUR3M1N2clZQ?=
 =?utf-8?B?bWRCRm9tTldGUTROS2tUUjdtazZoaG1WQmFwR3o3dXpvOGZpMHpacTV4TGsx?=
 =?utf-8?B?bDk5YzQ2My9SRDVIMDQyWlpHNmlhdDkyK1l3MzNsUzYvMzMxc3NGWXVLLzJi?=
 =?utf-8?B?MXZLUmZIWFN3WXVoZjlLdU5TSzJsK29Ta3ZzU3ZObDRtMDcwc2JZdWNDQkdm?=
 =?utf-8?B?a3g5cEZJNW03Zmtubyt2aEpYenZnRVhMc0ZrY3I2Skc0ODM3NlFlMm5rUVFW?=
 =?utf-8?B?U09OaXl1UlFjUjAvQXpFNS85aGpUenVuODlENW5RSjlwNVNjRlZlcUdjZjU4?=
 =?utf-8?B?eTNTaFJ0YytmSlJvU20wdS9HZ21lUlBpclp1dTBsNnBaMDMzWlVLZzZ4YldR?=
 =?utf-8?B?R055RVV1MktjZ000SERpTFZvQjJqeVNiVnZNNEtUZit1UnNaeCtiOVk5Ukw2?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AE3MMc5zxFheUg+KklIlcwCBzdm7bgMQXz23LUhxnn/RlRvXcEmUEjlHV3YihaJzbRsdNuR1q1PNc+p46mRlOHusLHLxiI2YJ4wLB48d1UXSbRM/LK7u4u4qBshhxi1eDjCUumrojTaQ3Yhe/XmZLbG09Tz468D6e1OIrY4sp6cWwAmHBNjxFKjC23p8nbwa6jjbXepEK1dLOOhzk2MuIiEBZykJ2Qhk1epQ03IibOtaZadlFA4Tn7GNXOsp583kLXjpxDZcpJOF44D/APKkIA8ksbdlO0yUZ1lmEEUuIvBSXIeAmNA4HGkiX92/GHhJaL+Iy5XumXMOMbZpy/mrtcdnBUCXSPmBB+/6a1r+CAFnXAM18l5oBmA1ttE8WVf2+p7QDd/yoRfpfJUF9gMLd5Bd9OeIz2g0W/VfhcSbfpPPE1gf2FD7GKMXK22g6yqLrqOLrR2nAyF/UBdkSw36QQnZZXWFVzrW/C36qWksP71KZbXKk9yXaaAMYgUgg2ikFU2hEJQwGg7gnXbK/VkvNM6Iee9Ksvqs3bY1K932G3wJNLlE45ucFcF5tduDodAe+7gZj9zA2C9NmnWOGnSjCQPmJjVcG7AKIKsvYdOLAko=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa858a92-a1e4-4529-c563-08de2e533e08
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 07:53:39.3075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MGeE6RhMe/lnNXfquCa6/qDnikFp94/bkFvXUpm6Hepv3OQ3SdWCRFhwaS0DeO4MWUc8KEhrIDAdhvkNjNN33w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4376
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511280056
X-Proofpoint-ORIG-GUID: ueCyNdCr5-b8VwmN70fm0IzbmJVrfcrj
X-Proofpoint-GUID: ueCyNdCr5-b8VwmN70fm0IzbmJVrfcrj
X-Authority-Analysis: v=2.4 cv=SLJPlevH c=1 sm=1 tr=0 ts=69295506 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8 a=g1_aQYOHg78x2AqTch8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12098
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI4MDA1NiBTYWx0ZWRfXyVU8BNQpMDT6
 b0fAn/LfMF2s+AaD6/jM5+y2YHqTmmhLQgiDR/E2Vw2QO0ZhU3CVRTlAzJCMlILc7g9zyuhREaJ
 ujl3M4PaPUlVhzhc6mvIyC+wmwk7cx7S1ZGICZW9pr+xzJlDQSuCl6qQyJNIBJ/K87l4JXosV/c
 kpGb+GAUv9EF5AmnWEX0OXQ+u8ioBBn8l3j8p8mGx+JPQXDjz69E4ZxDMOI5ykPiBuoLu6EGw25
 0dlXQlotM3Y4VIjWD1YENfTPy6g4GeoC3Xfe1qKMTqpxztjTYCFNMJeVzV4cVleUAJINtUAhwl+
 L8K0S/LjNnfodTJtIkHT+1k3WQjxcLylCNnJSaR0pzqXX55sphrGOeD2pcYC+qwcQoXi28oZsCh
 T9W8Jgljnq47Z8FZ7bwNLZawCyu4dFnux4wBG93L2wxBjuF2tD4=

On 28/11/2025 06:27, Nilay Shroff wrote:
> 
> Hi Alan,
> 
> On 11/27/25 9:06 PM, Alan Maguire wrote:
>> On 27/11/2025 11:19, Jiri Olsa wrote:
>>> On Wed, Nov 26, 2025 at 03:59:28PM +0530, Nilay Shroff wrote:
>>>> Hi,
>>>>
>>>> I am encountering the following build failures when compiling the kernel source checked out
>>>> from the for-6.19/block branch [1]:
>>>>
>>>>   KSYMS   .tmp_vmlinux2.kallsyms.S
>>>>   AS      .tmp_vmlinux2.kallsyms.o
>>>>   LD      vmlinux.unstripped
>>>>   BTFIDS  vmlinux.unstripped
>>>> WARN: multiple IDs found for 'task_struct': 110, 3046 - using 110
>>>> WARN: multiple IDs found for 'module': 170, 3055 - using 170
>>>> WARN: multiple IDs found for 'file': 697, 3130 - using 697
>>>> WARN: multiple IDs found for 'vm_area_struct': 714, 3140 - using 714
>>>> WARN: multiple IDs found for 'seq_file': 1060, 3167 - using 1060
>>>> WARN: multiple IDs found for 'cgroup': 2355, 3304 - using 2355
>>>> WARN: multiple IDs found for 'inode': 553, 3339 - using 553
>>>> WARN: multiple IDs found for 'path': 586, 3369 - using 586
>>>> WARN: multiple IDs found for 'bpf_prog': 2565, 3640 - using 2565
>>>> WARN: multiple IDs found for 'bpf_map': 2657, 3837 - using 2657
>>>> WARN: multiple IDs found for 'bpf_link': 2849, 3965 - using 2849
>>>> [...]
>>>> make[2]: *** [scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 255
>>>> make[2]: *** Deleting file 'vmlinux.unstripped'
>>>> make[1]: *** [/home/src/linux/Makefile:1242: vmlinux] Error 2
>>>> make: *** [Makefile:248: __sub-make] Error 2
>>>>
>>>>
>>>> The build failure appears after commit 42adb2d4ef24 (“fs: Add the __data_racy annotation
>>>> to backing_dev_info.ra_pages”) and commit 935a20d1bebf (“block: Remove queue freezing
>>>> from several sysfs store callbacks”). However, the root cause does not seem to be specific
>>>
>>> yep, looks like __data_racy macro that adds 'volatile' to struct member is causing
>>> the mismatch during deduplication
>>>
>>> when you enable KCSAN some objects may opt out from it (via KCSAN_SANITIZE := n or
>>> such) and they will be compiled without __SANITIZE_THREAD__ macro defined which means
>>> __data_racy will be empty .. and we will get 2 versions of 'struct backing_dev_info'
>>> which cascades up to the task_struct and others
>>>
>>> not sure what's the best solution in here.. could we ignore volatile for
>>> the field in the struct during deduplication? 
>>>
>>
>> Yeah, it seems like a slightly looser form of equivalence matching might be needed.
>> The following libbpf change ignores modifiers in type equivalence comparison and 
>> resolves the issue for me. It might be too big a hammer though, what do folks think?
>>
>> From 160fb6610d75d3cdc38a9729cc17875a302a7189 Mon Sep 17 00:00:00 2001
>> From: Alan Maguire <alan.maguire@oracle.com>
>> Date: Thu, 27 Nov 2025 15:22:04 +0000
>> Subject: [RFC bpf-next] libbpf: BTF dedup should ignore modifiers in type
>>  equivalence checks
>>
>> We see identical type problems in [1] as a result of an occasionally
>> applied volatile modifier to kernel data structures. Such things can
>> result from different header include patterns, explicit Makefile
>> rules etc.  As a result consider types with modifiers (const, volatile,
>> restrict, type tag) as equivalent for dedup equivalence testing purposes.
>>
>> [1] https://lore.kernel.org/bpf/42a1b4b0-83d0-4dda-b1df-15a1b7c7638d@linux.ibm.com/
>>
>> Reported-by: Nilay Shroff <nilay@linux.ibm.com>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  tools/lib/bpf/btf.c | 27 +++++++++++++++++++++------
>>  1 file changed, 21 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>> index e5003885bda8..384194a6cdae 100644
>> --- a/tools/lib/bpf/btf.c
>> +++ b/tools/lib/bpf/btf.c
>> @@ -4678,12 +4678,10 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
>>  	cand_kind = btf_kind(cand_type);
>>  	canon_kind = btf_kind(canon_type);
>>  
>> -	if (cand_type->name_off != canon_type->name_off)
>> -		return 0;
>> -
>>  	/* FWD <--> STRUCT/UNION equivalence check, if enabled */
>> -	if ((cand_kind == BTF_KIND_FWD || canon_kind == BTF_KIND_FWD)
>> -	    && cand_kind != canon_kind) {
>> +	if ((cand_kind == BTF_KIND_FWD || canon_kind == BTF_KIND_FWD) &&
>> +	    cand_type->name_off == canon_type->name_off &&
>> +	    cand_kind != canon_kind) {
>>  		__u16 real_kind;
>>  		__u16 fwd_kind;
>>  
>> @@ -4700,7 +4698,24 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
>>  		return fwd_kind == real_kind;
>>  	}
>>  
>> -	if (cand_kind != canon_kind)
>> +	/*
>> +	 * Types are considered equivalent if modifiers (const, volatile,
>> +	 * restrict, type tag) are present for one but not the other.
>> +	 */
>> +	if (cand_kind != canon_kind) {
>> +		__u32 next_cand_id = cand_id;
>> +		__u32 next_canon_id = canon_id;
>> +
>> +		if (btf_is_mod(cand_type))
>> +			next_cand_id = cand_type->type;
>> +		if (btf_is_mod(canon_type))
>> +			next_canon_id = canon_type->type;
>> +		if (cand_id == next_cand_id && canon_id == next_canon_id)
>> +			return 0;
>> +		return btf_dedup_is_equiv(d, next_cand_id, next_canon_id);
>> +	}
>> +
>> +	if (cand_type->name_off != canon_type->name_off)
>>  		return 0;
>>  
>>  	switch (cand_kind) {
> 
> Thanks for your patch! I just applied it on my tree and rebuild the 
> tree. However I am still seeing the same compilation warnings. I am
> using the latest for-6.19/block branch[1].
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git/log/?h=for-6.19/block 
> 

hi Nilay,

The tricky part with testing this is ensure that pahole is using the updated libbpf 
rather than just the kernel itself. Did you  "make install" the modified libbpf and 
ensure that pahole was using it by building pahole with the cmake option 
-DLIBBPF_EMBEDDED=OFF ? That's the easiest way to ensure the change makes it into pahole; 
you can check shared library usage using  "ldd /usr/local/bin/pahole". The other option 
is to apply the change to the embedded libbpf in the lib/bpf directory in pahole.

I tested the for-6.19/block branch with your config before and after making the
above change and applying it to pahole and things woorked. If that's doable from your
side that would be great. Thanks!

Alan


> Thanks,
> --Nilay
> 


