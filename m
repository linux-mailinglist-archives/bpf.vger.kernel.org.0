Return-Path: <bpf+bounces-44853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C70119C912B
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 18:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B78E2B2C459
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 17:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9E7165F01;
	Thu, 14 Nov 2024 17:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dtWtgi7k";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o8ZqzITw"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971FC3214;
	Thu, 14 Nov 2024 17:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731603617; cv=fail; b=CmsHYp76Lw4vgaFLtKwqU49cQuMDH4INv2YVtWq1fXPPX7CLSuWoabGCNpkcJQj1TxtlqVPFQDeTS6YvnlDzcujPSRBSuJXH8BZLmJImJRbhU9NbG4N0xYc4SX5nJZB9bnE8loODNv6ES3OQxptJ3Eb0VTBqqg4qxwN/tByqXAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731603617; c=relaxed/simple;
	bh=ug+2xPIp8N4E+wUQ5YKW4Q/yPeDOBi/aWzzmKy05gSw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TSCvdfYMWzg654BDIIjirVsdz2YUAaSQ2oVLHtj/rezGJX5suq/FX2RasAV1xd4EWo6fZf1DOwzOFJYAdUEUDeavjaPMPAc6I01roiE5sQT3JVLqGPPuVzhf2verpOsq9wnc9+6NoiV53bUNuJhJ4uv9hTw9E6yb3pME1LOyr6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dtWtgi7k; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o8ZqzITw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AECe2Jj007673;
	Thu, 14 Nov 2024 16:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=RlgJC9TzFiXLM0uE0dHJszc3DMl2JeiLIcsp9G17Ps8=; b=
	dtWtgi7k/yLx9GwyTw7tnjgNDRWgLhytPnVoL4h/XRSjw81JPsrb50sjL36BECOl
	GNB5cpPk+Y8z6ay2FAU8eYBxM9ykc9ghzUBQL71f0MukgTsQ6+7dOowdtVxTQOHL
	IgM74ivp551krD3BtIb5y7aI6PClL5/K82GhzNM5LHLfLVZpK589rNbV3K3eTy0P
	hDAh7vmDhgBs49Hth3YXDBYd2S4BdmoZtyRrAFzfzjjE/MDFj52CVVWkGEWDHoBZ
	aEqAfVD3qJus3Kd/inNe4qfzYEwC0tcQ1HKXTcUb+XW1s1vEtDnnzNVTErSdE/u1
	vSM58ocdycp1ap045Dqt6g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0nwsqnw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 16:59:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEFM4Wf005691;
	Thu, 14 Nov 2024 16:59:53 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6bf8cb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 16:59:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJLlC83+4KzKQ8LUYJ1rq4TTA0T39nRGe8eqfubodNPUQ1Bfm/vNmn/Sel55aqG+xa7E0ovmTp0OX+E/36asoM4XL4NWnxylwHEQ6Y8k+JO6BZgbdaijZDLj9EEOfC2rF6J5mIpRJaTS6k+EflIaExrree2U/MYKKKRi8RxGczMS7UxyX2oi5a4FXwMZB5vgtc9d1l1x0Ph/uthQeS17t0L5CoKOCMnDTMhj9GleaFyEd4O8nBlSmxAKNHEfGjLMJximr6msl6+TDabyHgYcyoyRciOKxoDcyPFRgtaMyA3pPNophVuw0pOiWz0HVuJv2nkFNtwJG9TOAJkgeG98FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlgJC9TzFiXLM0uE0dHJszc3DMl2JeiLIcsp9G17Ps8=;
 b=g3/UmQQUB/Qcu8k9Sx4mRYlrfHnfAxxRBEjJE2vVaBqOHhb5wRCxkXzDyYmhyyM7IOgSq74/FXbC5tzCjGK1uNefyKUNpskB19X7CLqExzJtg7nHY21aOcqrezoTp4P2sfESWdPXCM1G7vqK20hquJj5FAFT2X59pLbLu5lhM3BQNeF+WaYq3MlpZ1c9Hz2AW/gLZwRj9/dtDa1OJl92hjVasdTz0GyHhZ6B/gix5QN4xVVchTGEzvC+Nf1+DCIJkBg05WvOgxbfRcsv3uPlvGwIOtkVtahQwJ7Maso6skaNenkG65av8S56A5KZ2os8VvKBqVseIn+0sUdEYEX+Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlgJC9TzFiXLM0uE0dHJszc3DMl2JeiLIcsp9G17Ps8=;
 b=o8ZqzITwVSJurcD6Rd4KpHBWmkd4NFC9/5RpiTyavzdcTOd+BuIyz/0VG8ddw3Hjem5XuK33zOQThZLZnTuh12r4ELFEGpD4RTjE4sV7vsRMrUwYcZSCxNSutUgg8pyaqPhRodt4crvncF+vreiC+e0TRV8CQNTuNIrH4Uak81M=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS0PR10MB7342.namprd10.prod.outlook.com (2603:10b6:8:f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 16:59:50 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%3]) with mapi id 15.20.8158.017; Thu, 14 Nov 2024
 16:59:44 +0000
Message-ID: <e09cfb3c-8e9e-40c3-a7f8-642df67a1a6b@oracle.com>
Date: Thu, 14 Nov 2024 16:59:39 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 dwarves 1/2] dwarf_loader: Check
 DW_OP_[GNU_]entry_value for possible parameter matching
To: Yonghong Song <yonghong.song@linux.dev>, acme@kernel.org
Cc: dwarves@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        song@kernel.org, eddyz87@gmail.com, olsajiri@gmail.com
References: <20241114155822.898466-1-alan.maguire@oracle.com>
 <20241114155822.898466-2-alan.maguire@oracle.com>
 <8a08219a-9312-429d-a291-d93a932c849a@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <8a08219a-9312-429d-a291-d93a932c849a@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4PR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::6) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS0PR10MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c16e796-e6a1-41a0-f303-08dd04cdbd1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEJIdTBlS0M1K3Ixelg5U1hhamd3dUdIMk9NVVVvVkJXMG5EaE1pMHBUNHpK?=
 =?utf-8?B?VUQybFVtb203b1BnaERybFZWSGNQSGhsRDJhQlVhMFkwTDFLOFB2YmpVcFUy?=
 =?utf-8?B?NXdJaUcvYkx5YkVrY05DOFZ1VGN4dWF5SjUzSjBLYTlQN1dUZmJXZXpnazlz?=
 =?utf-8?B?V0EzZjc4ZXdESi9tckhVR1d6Q0YreHkvb3FydXJXcVdTdDF3REloQ0Iybytt?=
 =?utf-8?B?NnhYaEF0azBscmhndER1Nm1uWnM1YVVRZzkzM1c0cGxVZ3ZQeUcyYjNEbWhJ?=
 =?utf-8?B?TjdSYVhYNEhhUXdWa0I0ZXZRZjYvamNSUis0Y3JjcFQ4WTFGUmxnbkRPekdK?=
 =?utf-8?B?dFJweUFYWlVmR1hkQzNDTEo0WFp4K09SQUl2NFB3UlE5YlR4SnBIU1BSNmZE?=
 =?utf-8?B?TnFPVU54MkxHaEo5UmFWNFVTc2dlc1JoM3E5THhMYndoMnlTSnNBT0I4QllJ?=
 =?utf-8?B?Vm5aTEl5M3RxeEc5QzlLR3RaaXZYNXR1UE9WYVpsSS9RZUQrMGJmeW9wcmZX?=
 =?utf-8?B?anh6dTVuc1lGSXpxK1hzK3NwejNiNDFvdHRJMFMzbWxVNVdHNUJLT3RVMzc3?=
 =?utf-8?B?L2xSUk9BaGhkdU9XN0FaUXgxWmxoVS9JMWY4OFV0N3dhdnI4aFJXdlRyTjVL?=
 =?utf-8?B?Vk5kdWpGMER4S0lIL1dmTk80dGQ3WGVtZEE3Yk1WVDBhY3ZZS1lpaVRrNWdS?=
 =?utf-8?B?SVRxbW8yTnl1anE3MDMyRnpjMVpSdmswVTNzczIzL2ZjNDd4VDZkOStmb1hh?=
 =?utf-8?B?aUtoc2M3MkpETjNjWWQ2Z2c2b29KUjZEM0lEbWxSWDd6blUzZ2VNMXcwVVBE?=
 =?utf-8?B?c1N3OWNlWVQvS29Jckc4dzE2UGI0K2pjbW9HcENlZ25IYW1yRnQyYXBVaXBh?=
 =?utf-8?B?TDg5QjkzZFVuNklIR0dEZ04yVHU4V2Vack43TS82NmZzRHVpaE93ZlBaZEQw?=
 =?utf-8?B?QnpDWmljNitETUZXWFFmTkhBMkZ4OFZxSFoxOEs2MXRmYjA4aXZLdkpMd25Q?=
 =?utf-8?B?WnRhQVB0WkNWL1hsUjU2OVBETStQakFiUTFENytkeGlHdG4rM05XVTFoTDVE?=
 =?utf-8?B?RGVIT2REV1J5YXprL2RseEFySjhBTnRxeS91bVNyRDhjQXRQcjJoWXFHZVVx?=
 =?utf-8?B?SGZBV1NMSzVzaHIvZFltZ0tkYkhYdUZZeWZvNXJQUzNhYVN4U2ZidTQwYytO?=
 =?utf-8?B?czlYZjFpS0VXWHM1Sk5ZTTl4WWQrYVpxNFJkVW11YXI2Q2RXQ1lrOUxXU1hJ?=
 =?utf-8?B?bmlxSEFURXFSWlYyczdOVkVaa1dBMnJTY1E5aE9NeGJ6bFFESFVDcTNIaHkz?=
 =?utf-8?B?azhDTmo5UGd5eU5pc1ZMNVFtSVhqNkhjUmh1bzlIZnE3NE91dU1vd3cwZ1lu?=
 =?utf-8?B?THJmVDlNSVBYNnU1aFNxRzdyV3JDWDBYd0I5WlRsdm5UZ2RtQ21jWVRiOXYr?=
 =?utf-8?B?cXJTalNFZFBpMFVjdjJ4Q0syWnBITzZ1di9SL1pwY0NIQ1kzd281eXN6a0pF?=
 =?utf-8?B?UTVFTHFTa1JyaWdyRUVBRHlGY01vcjJSQ0FZKzZhb3RVNTBsUU8rdkNlRC9Z?=
 =?utf-8?B?UXFqN3k3Yk5ucUlyRkRweGt0OWQxQS92enBxK1ZLVUdsdS9IQk1veW5YdWNR?=
 =?utf-8?B?VEZKT0RxVnpheUZJY1JDREhtWmZ6dnEvQ1dwbmhwUFpTUStqUzE0NE81RnR6?=
 =?utf-8?B?TnpWV0VDSWxENUk4ajFTZWZaQ1FoOVE0akduZGE2R3ZaNWVZVko5YmROdFhp?=
 =?utf-8?Q?yEAz49FNggVIhG36wxx9HP0nGgpymKBPdecI+cf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXZEWHlNLytEUVplYitmSGlTTC9uZ2x5WDAwL1FRR0hQbHN0WmRjTWV5RmFa?=
 =?utf-8?B?cHBjUHFRS2wyRzluN0tiRnMydjVvUkl3VTJKRXk1NkJjYTliZWNKQlBDTVR3?=
 =?utf-8?B?RE9kRGJJYjRtYktNa1FZT2JpUW9QaXJEdEZPZGFqMkFIYVRGbmFIazJEeW1s?=
 =?utf-8?B?TFpxcU91ZUVoSll1T3FYL2tSQ1VzcTFUVEt1RGRBa0xJTXdrYUhOaUJMZ0ZW?=
 =?utf-8?B?eHp6dWtGdSs4TXMzWFdqekJQTEJPeGQxT2gzdFEwazhKRUpDNVZ3b0dMQkc5?=
 =?utf-8?B?NWNwTllRd0dnRGdWcHplSEUyZXMwWEUzUUhibkZPWjUwZE14MFpLeTFCVFRF?=
 =?utf-8?B?bFpIb1p3NFBUdHEzV042YU5uTC9reFByQklsTmpldE1sT29Eb1FNME83Y1Jx?=
 =?utf-8?B?ZEdWWjNOaHlNWDl3VW9keDdDeXNuOEhMUm5uSjIrcGFVMFUxS3FHUkFmRlds?=
 =?utf-8?B?ZUJ1RTBibjR3UVZQbDdOcm14WDNFY2thdXpTcUhHdFJoUDRLMDJCREo3YU95?=
 =?utf-8?B?cFBYKzdQTy9ib0QzdWlCSTVJbDFmNUdLbmJwRnl4SWdzeHZmYVFmd1Avd2g2?=
 =?utf-8?B?TWZYWW5Mb3pGcTdTdGZDb0RPbWtxWS9rWUUvT2IwSDdpbEJackQxb2pFWFEw?=
 =?utf-8?B?UGNzRDdhSUs2TitybkV4Sy9FZjRQTGpMRTlISWkwYndQREtOVXFGUWRLeERQ?=
 =?utf-8?B?MUtFY0p5M0N6TkpURWNGSjhXMWlxZFZMcC9CZHIzUDhacVJqZTE4S29oUzhG?=
 =?utf-8?B?TXNqTGVIazhZSU5wU1RpdS9KSWZGRFdkK1hxbjRLVnZFYU5NRWJ3NGdhQVh6?=
 =?utf-8?B?czhRQzA3N3VLV1U4ZmtkWS9kZXJKTytVZk5INXBaeWtMS0RONkV2ZmtBZ0dy?=
 =?utf-8?B?ejNzMkFLeVJOeEFldXFkMEM4TXJpdHhKRUNwSVRFTGxyZHNOYko5dlRvVlVV?=
 =?utf-8?B?VGFwcnVraHp5dU5mbHFqSkNsZy9sWGxjc0sxQ1Z3UEFVK3Nvb1hsRWF0SGRU?=
 =?utf-8?B?NHYvdGRtaHhadThJdHJJb2l0NVpFNTRITmR4bUxXbnVpMW40cGlhRzRtRndu?=
 =?utf-8?B?L2YzcG1RTUlPM2JiTTBMSUY3M3FjN1M3L1R3VlNUR3lVSlIzeU9PWDZ0Wnhn?=
 =?utf-8?B?SE9ZNWhUS0phREorQmFUZURhaE1xUUdWMnY1dmlYUHZXeG1WMlN1a250RDdq?=
 =?utf-8?B?cXVlVHI2dFFSK0oxUTlNekdOMXN1cnEvaWpIZkwrNXF4NW82bGlod3JkZXFr?=
 =?utf-8?B?YWhERXN3YjRPYmZndThkTDhlTUlNUUttZmpqb2Eyd29FSGVlK0VWOGVEVzZP?=
 =?utf-8?B?T2VyRzFWOXEyQTZGYzVyTTFWR25EdDl5UjRpeHQ5R1BPdGdOdmhtUFV0WHBW?=
 =?utf-8?B?VlpFY1pZOWhGZ3VSMVVmWHJVNFdrUi9ObnAxbVdIM1pnb25rZjFwUTg2MmxX?=
 =?utf-8?B?TFYvUnQzcTZFQmR3RE5yTXVhR2MvKzB1UjRVckRwK2grRDNLSkJHNWxubWlr?=
 =?utf-8?B?RVJkYmNIdEtnRE16MVlid0cxcUpYVGVzQ3gwQmpiZVdMdkQ5dG9US05KV01J?=
 =?utf-8?B?OTdobUg3L1h0N2JKY3JBamJUNHkrTkY1MzQ0V3ZWSkRNNmN3dk9OMUhUckNV?=
 =?utf-8?B?ZkxHR3FnUWVQdWJ3YXlwdCtTWjdXb3h4cHRlVkpLMDFoRnV2eUVYM1ZzZ1Jo?=
 =?utf-8?B?VHVzN091Rno1ZjdiYnlmOUJyM1NMcnRFUTNVeDRpQUdoWFpZUlBPQWpSNDdK?=
 =?utf-8?B?ZStIS2hxcHhnWTY4NDkwbkJIVVl4VlJZSWpaTnUreUxXY01UKzNmRlNDN3c5?=
 =?utf-8?B?OG42OGZrcThKdmhqazUwbUdEUUVvZ0dNSHVqUG42VHYxc25Bb0ZXN0V6N1FD?=
 =?utf-8?B?KzNjaGJvbkZTS2ZLVENNeDNNS3dGUHBUU3NrMm0zTlRWaC9tSVNMZmxqUXZv?=
 =?utf-8?B?UWVPTkZ4bGRBYnRGNWdMa2dVVWxlN2NOZ2hQRTdoaWwrdTZhbVZidzZDbHpY?=
 =?utf-8?B?bzVCUHkxblVHT25BajhYVjlUakdoemM3c2tWZitUdGNuQy9mWEh1b2kzUGND?=
 =?utf-8?B?WGdaUlZhbW10dVBUOE9vbENDQkdXVXR5c0RuTnFnemdlL2MwZjJFQ0FjeVhN?=
 =?utf-8?B?dWRZd2RDMzFHV0xtdUp2RkFvL2NUblJ6ZitONUo3SU9ycVlGMVplRWdlTjdh?=
 =?utf-8?Q?WPhYrwNhs+W9nw0Ifal8PbA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T2HkrcgW7/m0QJvuwPTOsLCycCpwlV2TmP0zaPfZ9X7M7QyShf63CbQMJ9a6DLLaXFQzRPEv/wUFseM1fln0OMPMweTnxVEmOU5YfaFGO4zz3BYguifuze6j/qPHvG7fcwU8ZDfRklGIqr/hAB9UmNnhCc6VxTHX30/Y6h7e4MrnHRIx7yUeTiu8hyU0nMxVaca24yEAwAur5PM3ZpP8VHIJlYRD5Rc3X4BiMjSr3h1c7KOvuNxPVL/0iGC7Uj+ZyQ/rRUw7dyGvm1ZPLz4YKXwurVbfMW1qd2pNLDipu+PJ640zgU80xhSV2jUTYfkFtazT/ZVfBlqJTvUHsq0eZGKt4l9rNbCuwMLu0u1jEmUAeupRWJXbYR0u8mGu3MSfygvFBzPpkbC1p2JO2zAAEIEnBBbwckdKzo2ndfgaN3hlbvZ1sxyJsBlJdPn70NTXaiYI6X3F2vblNditm5J03NxTUCW+oidWHt8W7EgDtkdtdRQhe4gY9tnLRuKRwnYIryJkQzIRVccPOuK2ByyGEEh9MM0CQRprVHsO2m1YQJvsb1fopJhbD8+V1S0XctlXsRaSWYX4NL9t5zraObsalN7Ao13SvedVS8NswBBWEdY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c16e796-e6a1-41a0-f303-08dd04cdbd1e
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 16:59:44.5410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4xeQqkYT6ZSa7E1x0gciKZ5MUx/4gkj1HFVZ8oIuUCYW+d4bKs98k5aMIZBjSo6Uy7lThmwNb3meZK//juR+WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7342
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411140133
X-Proofpoint-GUID: 423ayLpALirr6dTPOIjY_XVgVX-bzw4o
X-Proofpoint-ORIG-GUID: 423ayLpALirr6dTPOIjY_XVgVX-bzw4o

On 14/11/2024 16:51, Yonghong Song wrote:
> 
> 
> 
> On 11/14/24 7:58 AM, Alan Maguire wrote:
>> From: Eduard Zingerman <eddyz87@gmail.com>
>>
>> Song Liu reported that a kernel func (perf_event_read()) cannot be traced
>> in certain situations since the func is not in vmlinux bTF. This happens
>> in kernels 6.4, 6.9 and 6.11 and the kernel is built with pahole 1.27.
>>
>> The perf_event_read() signature in kernel (kernel/events/core.c):
>>     static int perf_event_read(struct perf_event *event, bool group)
>>
>> Adding '-V' to pahole command line, and the following error msg can be
>> found:
>>     skipping addition of 'perf_event_read'(perf_event_read) due to
>> unexpected register used for parameter
>>
>> Eventually the error message is attributed to the setting
>> (parm->unexpected_reg = 1) in parameter__new() function.
>>
>> The following is the dwarf representation for perf_event_read():
>>      0x0334c034:   DW_TAG_subprogram
>>                  DW_AT_low_pc    (0xffffffff812c6110)
>>                  DW_AT_high_pc   (0xffffffff812c640a)
>>                  DW_AT_frame_base        (DW_OP_reg7 RSP)
>>                  DW_AT_GNU_all_call_sites        (true)
>>                  DW_AT_name      ("perf_event_read")
>>                  DW_AT_decl_file ("/rw/compile/kernel/events/core.c")
>>                  DW_AT_decl_line (4641)
>>                  DW_AT_prototyped        (true)
>>                  DW_AT_type      (0x03324f6a "int")
>>      0x0334c04e:     DW_TAG_formal_parameter
>>                    DW_AT_location        (0x007de9fd:
>>                       [0xffffffff812c6115, 0xffffffff812c6141):
>> DW_OP_reg5 RDI
>>                       [0xffffffff812c6141, 0xffffffff812c6323):
>> DW_OP_reg14 R14
>>                       [0xffffffff812c6323, 0xffffffff812c63fe):
>> DW_OP_GNU_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>>                       [0xffffffff812c63fe, 0xffffffff812c6405):
>> DW_OP_reg14 R14
>>                       [0xffffffff812c6405, 0xffffffff812c640a):
>> DW_OP_GNU_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value)
>>                    DW_AT_name    ("event")
>>                    DW_AT_decl_file       ("/rw/compile/kernel/events/
>> core.c")
>>                    DW_AT_decl_line       (4641)
>>                    DW_AT_type    (0x0333aac2 "perf_event *")
>>      0x0334c05e:     DW_TAG_formal_parameter
>>                    DW_AT_location        (0x007dea82:
>>                       [0xffffffff812c6137, 0xffffffff812c63f2):
>> DW_OP_reg12 R12
>>                       [0xffffffff812c63f2, 0xffffffff812c63fe):
>> DW_OP_GNU_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
>>                       [0xffffffff812c63fe, 0xffffffff812c640a):
>> DW_OP_reg12 R12)
>>                    DW_AT_name    ("group")
>>                    DW_AT_decl_file       ("/rw/compile/kernel/events/
>> core.c")
>>                    DW_AT_decl_line       (4641)
>>                    DW_AT_type    (0x03327059 "bool")
>>
>> By inspecting the binary, the second argument ("bool group") is used
>> in the function. The following are the disasm code:
>>      ffffffff812c6110 <perf_event_read>:
>>      ffffffff812c6110: 0f 1f 44 00 00        nopl    (%rax,%rax)
>>      ffffffff812c6115: 55                    pushq   %rbp
>>      ffffffff812c6116: 41 57                 pushq   %r15
>>      ffffffff812c6118: 41 56                 pushq   %r14
>>      ffffffff812c611a: 41 55                 pushq   %r13
>>      ffffffff812c611c: 41 54                 pushq   %r12
>>      ffffffff812c611e: 53                    pushq   %rbx
>>      ffffffff812c611f: 48 83 ec 18           subq    $24, %rsp
>>      ffffffff812c6123: 41 89 f4              movl    %esi, %r12d
>>      <=========== NOTE that here '%esi' is used and moved to '%r12d'.
>>      ffffffff812c6126: 49 89 fe              movq    %rdi, %r14
>>      ffffffff812c6129: 65 48 8b 04 25 28 00 00 00    movq    %gs:40, %rax
>>      ffffffff812c6132: 48 89 44 24 10        movq    %rax, 16(%rsp)
>>      ffffffff812c6137: 8b af a8 00 00 00     movl    168(%rdi), %ebp
>>      ffffffff812c613d: 85 ed                 testl   %ebp, %ebp
>>      ffffffff812c613f: 75 3f                 jne    
>> 0xffffffff812c6180 <perf_event_read+0x70>
>>      ffffffff812c6141: 66 2e 0f 1f 84 00 00 00 00 00 nopw    %cs:
>> (%rax,%rax)
>>      ffffffff812c614b: 0f 1f 44 00 00        nopl    (%rax,%rax)
>>      ffffffff812c6150: 49 8b 9e 28 02 00 00  movq    552(%r14), %rbx
>>      ffffffff812c6157: 48 89 df              movq    %rbx, %rdi
>>      ffffffff812c615a: e8 c1 a0 d7 00        callq  
>> 0xffffffff82040220 <_raw_spin_lock_irqsave>
>>      ffffffff812c615f: 49 89 c7              movq    %rax, %r15
>>      ffffffff812c6162: 41 8b ae a8 00 00 00  movl    168(%r14), %ebp
>>      ffffffff812c6169: 85 ed                 testl   %ebp, %ebp
>>      ffffffff812c616b: 0f 84 9a 00 00 00     je     
>> 0xffffffff812c620b <perf_event_read+0xfb>
>>      ffffffff812c6171: 48 89 df              movq    %rbx, %rdi
>>      ffffffff812c6174: 4c 89 fe              movq    %r15, %rsi
>>      <=========== NOTE: %rsi is overwritten
>>      ......
>>      ffffffff812c63f0: 41 5c                 popq    %r12
>>      <============ POP r12
>>      ffffffff812c63f2: 41 5d                 popq    %r13
>>      ffffffff812c63f4: 41 5e                 popq    %r14
>>      ffffffff812c63f6: 41 5f                 popq    %r15
>>      ffffffff812c63f8: 5d                    popq    %rbp
>>      ffffffff812c63f9: e9 e2 a8 d7 00        jmp    
>> 0xffffffff82040ce0 <__x86_return_thunk>
>>      ffffffff812c63fe: 31 c0                 xorl    %eax, %eax
>>      ffffffff812c6400: e9 be fe ff ff        jmp    
>> 0xffffffff812c62c3 <perf_event_read+0x1b3>
>>
>> It is not clear why dwarf didn't encode %rsi in locations. But
>> DW_OP_GNU_entry_value(DW_OP_reg4 RSI) tells us that RSI is live at
>> the entry of perf_event_read(). So this patch tries to search
>> DW_OP_GNU_entry_value/DW_OP_entry_value location/expression so if
>> the expected parameter register matches the register in
>> DW_OP_GNU_entry_value/DW_OP_entry_value, then the original parameter
>> is not optimized.
>>
>> For one of internal 6.11 kernel, there are 62498 functions in BTF and
>> perf_event_read() is not there. With this patch, there are 62552
>> functions
>> in BTF and perf_event_read() is included.
>>
>> Reported-by: Song Liu <song@kernel.org>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>   dwarf_loader.c | 104 ++++++++++++++++++++++++++++++++++++++-----------
>>   1 file changed, 81 insertions(+), 23 deletions(-)
>>
>> diff --git a/dwarf_loader.c b/dwarf_loader.c
>> index ec8641b..bc862b5 100644
>> --- a/dwarf_loader.c
>> +++ b/dwarf_loader.c
>> @@ -1157,16 +1157,88 @@ static struct template_parameter_pack
>> *template_parameter_pack__new(Dwarf_Die *d
>>       return pack;
>>   }
>>   +/* Returns number of locations found or negative value for errors. */
>> +static ptrdiff_t __dwarf_getlocations(Dwarf_Attribute *attr,
>> +                      ptrdiff_t offset, Dwarf_Addr *basep,
>> +                      Dwarf_Addr *startp, Dwarf_Addr *endp,
>> +                      Dwarf_Op **expr, size_t *exprlen)
>> +{
>> +    int ret;
>> +
>> +#if _ELFUTILS_PREREQ(0, 157)
>> +    ret = dwarf_getlocations(attr, offset, basep, startp, endp, expr,
>> exprlen);
>> +#else
>> +    if (offset == 0) {
>> +        ret = dwarf_getlocation(attr, expr, exprlen);
>> +        if (ret == 0)
>> +            ret = 1;
>> +    }
>> +#endif
>> +    return ret;
>> +}
>> +
>> +/* For DW_AT_location 'attr':
>> + * - if first location is DW_OP_regXX with expected number, returns
>> the register;
>> + * - if location DW_OP_entry_value(DW_OP_regXX) is in the list,
>> returns the register;
>> + * - if first location is DW_OP_regXX, returns the register;
>> + * - otherwise returns -1.
>> + */
>> +static int parameter__reg(Dwarf_Attribute *attr, int expected_reg)
>> +{
>> +    Dwarf_Addr base, start, end;
>> +    Dwarf_Op *expr, *entry_ops;
>> +    Dwarf_Attribute entry_attr;
>> +    size_t exprlen, entry_len;
>> +    ptrdiff_t offset = 0;
>> +    int loc_num = -1;
>> +    int ret = -1;
>> +
>> +    while ((offset = __dwarf_getlocations(attr, offset, &base,
>> &start, &end, &expr, &exprlen)) > 0) {
>> +        loc_num++;
>> +
>> +        /* Convert expression list (XX DW_OP_stack_value) -> (XX).
>> +         * DW_OP_stack_value instructs interpreter to pop current
>> value from
>> +         * DWARF expression evaluation stack, and thus is not
>> important here.
>> +         */
>> +        if (exprlen > 1 && expr[exprlen - 1].atom == DW_OP_stack_value)
>> +            exprlen--;
>> +
>> +        if (exprlen != 1)
>> +            continue;
>> +
>> +        switch (expr->atom) {
>> +        /* match DW_OP_regXX at first location */
>> +        case DW_OP_reg0 ... DW_OP_reg31:
>> +            if (loc_num != 0)
>> +                break;
>> +            ret = expr->atom;
>> +            if (expr->atom == expected_reg)
>> +                goto out;
>> +            break;
>> +        /* match DW_OP_entry_value(DW_OP_regXX) at any location */
>> +        case DW_OP_entry_value:
>> +        case DW_OP_GNU_entry_value:
>> +            if (dwarf_getlocation_attr(attr, expr, &entry_attr) == 0 &&
>> +                dwarf_getlocation(&entry_attr, &entry_ops,
>> &entry_len) == 0 &&
>> +                entry_len == 1) {
>> +                ret = entry_ops->atom;
> 
> Could we have more than one DW_OP_entry_value? What if the second one
> matches execpted_reg? From dwarf5 documentation, there is no say about
> whether we could have more than one DW_OP_entry_value or not.
> 
> If we have evidence that only one DW_OP_entry_value will appear in
> parameter
> locations, a comment will be needed in the above.
> 
> Otherwise, let us not do 'goto out' here. Rather, let us compare
> entry_ops->atom with expected_reg. Do 'ret = entry_ops->atom' and
> 'goto out' only if entry_ops->atom == expected_reg. Otherwise,
> the original 'ret' value is preserved.
>

Makes sense. I'll wait for other feedback and roll that change into v3.
Thanks!

Alan

