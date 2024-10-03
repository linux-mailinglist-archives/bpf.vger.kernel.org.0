Return-Path: <bpf+bounces-40830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018C498F1B2
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 16:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43F1CB22CA4
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 14:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F871A2C32;
	Thu,  3 Oct 2024 14:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ik5pEgQV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NIRlNkZb"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20AF1A01BD;
	Thu,  3 Oct 2024 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727966450; cv=fail; b=cV/mYlyO7cpsIQS/osV8eLHZTxLZUaTHWhnuMAWmgO1lP8V/9tMWzraapIickMrsTOi070RYiv54Us3AlbI1nO8fyGc9AsqdqfTDpVI6irnFEiB4kfHmyOhzek7+v7fS+5BhXUQfWai05h4MJFCrCx4Y2Ly4qeKgPY+b6j/yob0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727966450; c=relaxed/simple;
	bh=pahAYZbkWTVho9fihlJhx9eLdQVHCzVKFswsY7nde1U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o1UH242YIWeZpwHj9HQKFttdhadQ4qJ5vmw5deuTgIGRhW960Kr3sZVyxzOD64mAMWBRW3gOplDKNgVjW5Ny/C68mobdxd2oQmgQFmbB16woKlZUGW4YYPYf6Ov3VPLuL+x6qpT2BnBhhVZg9yATbs/Ki0JrqPeJ95MeZZjc0H0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ik5pEgQV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NIRlNkZb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 493EZ28V028697;
	Thu, 3 Oct 2024 14:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=rDRgnVauy7/Efe7VHLOSkpkkT0IGoHOdvM4L1HjLZQQ=; b=
	Ik5pEgQVTwVOoSzYCwg5e97+TYcu4zahxX5HQzgwL6d1PxmXfQd+KdmQKmH9n4bJ
	QZw/82PbUc82SNVe55GIHQnYQI4aDyTC2JuwOLkrV68Ta9y6KDp/g/LPSYdWgKiB
	/YxZU6MHxprG3Mp3lKTdoBFFDzusvCiaenjknLc2twRqHIUIRQtsi6kIK4rCr20j
	Qosu+PxyZXwic5LaYehq9jebxROPAAIrpctyl2+WQKZD9l2H7c8CJKKlNZU8BWc5
	r/M39kusEdCj+MxcNExqXd23HYOKgy1dPR97VSo90PNmDhKWEAWY1+4Qg4ebXYmN
	jvrupHAIBM9lBCVBHeWQHQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8k3cfca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 14:40:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 493EE5rY028408;
	Thu, 3 Oct 2024 14:40:43 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x88ah8q6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 14:40:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZH79Avt1Py9cSvWnarNIUqwGVP+Uqlbv4+Uq5dV/duui/h1uOexCRhBdvnhN4kn3W/bZwNKbz1vYI4aO2mbQCqZiRdIit9BRZBulHwZehcfmXq2K6WTZYnbUFkdB/4JjUxmiANswG0aDcHwv3qGtATzCG5LSQvqvUIkCmOF0WuNrbhHlEKxF5vuV7pah7rYYc01FeuHs0FhYtY5I3bEHyF/MjISPbbXA6tVMetIn7niW9BQAF7rWS7MtLsod9k7DUXT7fbWMXyTZyQZfprnlt3jCPlDx+s7rra9SmUiqoqCR95UkBUoGAwCj9k9Go1n03hd+DyJuvSnwJOgy3jcl7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDRgnVauy7/Efe7VHLOSkpkkT0IGoHOdvM4L1HjLZQQ=;
 b=kkDP5BDOmnCqfPrBHojtbup5fke9gFpZiik55Kj5M0sgCqg/r7RX55w3Wk0tGFtojNGy5RStVjLTZsQqid3pyQszNUc6OmM1H2eEroDxamEi+PLMNVkPZrvcKae/vOYELb4OXdUYhB+rMhxtWGo++y1JVMtqf6NWVMwtOgQ4z8y1CRSYETCt4WEkWD2W3SzLJ89erq/3PXDNG7stKIr+HK4Bo/ZCzAELwwBrwS9otsLurAOIouicR2GtkhEkGWwrw6XNk+OzBfLfVUfdvCApfYaprNIu5PbYTu15dbJnoGq4zKYixti132dQsfdzaUzey4nm9rt9fSS7558RazR8oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDRgnVauy7/Efe7VHLOSkpkkT0IGoHOdvM4L1HjLZQQ=;
 b=NIRlNkZbGOqKxsvVyT/kqHhdOahSVEwBo/AgzN9QqWM2mfiq+8bTEzFyNT2D4ML+S9EDdHK19GF6js5L/0ednkMeVsFNn3xlXmg2EwKJC72cwABIX61V/ty0+/NnanUYZg1uqxiNKWXy/gZ6u4XoccXDmSfnazr/iV/C47CXySA=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA3PR10MB8092.namprd10.prod.outlook.com (2603:10b6:208:50d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Thu, 3 Oct
 2024 14:40:40 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.8026.017; Thu, 3 Oct 2024
 14:40:40 +0000
Message-ID: <22da229b-86d0-4a0c-b5d6-4883b64669f2@oracle.com>
Date: Thu, 3 Oct 2024 15:40:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v3 5/5] pahole: add global_var BTF feature
To: Stephen Brennan <stephen.s.brennan@oracle.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
        linux-debuggers@vger.kernel.org
References: <20241002235253.487251-1-stephen.s.brennan@oracle.com>
 <20241002235253.487251-6-stephen.s.brennan@oracle.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20241002235253.487251-6-stephen.s.brennan@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0193.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::30) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA3PR10MB8092:EE_
X-MS-Office365-Filtering-Correlation-Id: dcc2d0fb-1322-4587-873b-08dce3b95a65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?byswVjlpWDNwSGRCOWJ6bGk5bHJUZUh3RFExdUlQR3BPYWVrSWxyeCtxSmtH?=
 =?utf-8?B?NVJzWkx3N3ZHc3JrYXBqZUw2YVhzTTRFS0pkeE9lcFQzYUxvVkNGMldmSUN3?=
 =?utf-8?B?S0w2L0VZcWpsZjRNM29QY3dHRzRFeGJyTVV3bHcvYTczMmM5YVF2MTcrWFM1?=
 =?utf-8?B?Z3dLWVFnblRienh6U3VpT0dkU25JbGIwVzBDT1BCV3NGQndwVkdnODc1WWNZ?=
 =?utf-8?B?bTZyNmJPcWFmSjE3WDFBN0RuejBUdTJCQzE1NTZIRERWZURiTUFpa3JadXE3?=
 =?utf-8?B?Sk5JN1pva1V6OFpKbjZLbEh0Rk9DQlpDQW16UXgxUzVTZ2hBRzllSjRhV2J1?=
 =?utf-8?B?Ui8rUS9RcjVySlVKcFN5VVNueWxFV2ZzOUxKWmU5dk5BcDkrUW9zMTVjQjhF?=
 =?utf-8?B?OVIzK25tcHY2anBnYmN6MTgrZGVVOTVKay9VTzRXZWlQYWtwbzE5bVRLMjZm?=
 =?utf-8?B?WGNTWkZWd0lBdVFUWS9OZ1p2L3plNlc0a2s2N09VaXdOWVFGZHFtZkp5bWcz?=
 =?utf-8?B?SE9Zbkk3Z3BUZ0JzOUM2WDQvWkRsaC9TWkQ1aEhtY1AxZFd1WVRmZnJLZXZH?=
 =?utf-8?B?ZVlGa0VaMUdBbitVeXd1T1RNanJtK0NaL2hVcms1VklzSEhaZEY4SXNxZnBn?=
 =?utf-8?B?ODhIZ3JzV1EyTHUrdjVvdnF5UmVXLzBTMk5SU2svNGpWREJuNnFrMyt3RU02?=
 =?utf-8?B?amZkdi96UkVFeittQUtaVXpBNkdiUmhtamhIMkd6Ty8rUnBZdWFTSURVeTJi?=
 =?utf-8?B?M095cDZVOUFyWURucDE5ZmNCM0pyYnM1NkdGUnhPME9nRW1PZmdTY0cyK1ky?=
 =?utf-8?B?UWYzM1NseDVmcHVsUDRkMFh2aTU0UmUwWGZBSWpYVXh6MldtWW9seGl1SUIr?=
 =?utf-8?B?cFJVWiswbkpqaEtPWEtka3JUNFZPVGRpV3NVT1JiQUV1U0k1bE5BUmZQb2gr?=
 =?utf-8?B?bEFHZTRNb3M0OFNHMjZCajZxemU1dk04WldQZG51aVQ3UDhaU0dxSnZmZHN2?=
 =?utf-8?B?elNxY3BYY1k4SkVqZC9JTjVkV1c3Y2JHbld0N29wUGU5dVRtdFlzVC9ObVd3?=
 =?utf-8?B?Q2puUkd5aVJnRjJ3SzgxVFgvQ0hCV0ZGTWZTb2d0RmZZSHlNa0FrRTVhUXEw?=
 =?utf-8?B?bEFzOGhuL3YyeCsxQmJyMmd1c3J1Q3hLbG9JOVpxMWg5THU5a1BUeEVFUnZj?=
 =?utf-8?B?aVNRaWFBMlpJd01abHRYekVhalFUTkRrdXg2d3VLV2k0UjFBNlNNenNIaEp1?=
 =?utf-8?B?dk9oS0pNbjJVWnZ2TE5KcVV2QkIreE9pdlpHVU0zQzVSQXM3Rkh1UkRTODVD?=
 =?utf-8?B?eEZkeW5Da0d1MHFQMHUrUmluVEhnWGs3Qm9wdGs2TEpwTlZISDFkWVlpc3pS?=
 =?utf-8?B?aHZ5SnBML3Y4ZGRDMmJjcnloSnpwODAvZG5XRStUSEJIck5XeTI3OEx6SFF6?=
 =?utf-8?B?dHRUTVhackdOVFU0eGtZQVFTR0JPUGw0OXQ4NXFVZjI3R3draWQyNHRjVVBJ?=
 =?utf-8?B?QmduZHhHb09WK1BWQjJNbFE4eE40SXFQbWhJSXhCK0w2R1gyaUJBbWpoci84?=
 =?utf-8?B?cjNzMVdtOVZEWFQyK1JCb3JrMlVTakg1aElzcTlrbFZKWFY2eDR2ZFRFeHJF?=
 =?utf-8?B?b3kwZ1cvQnAxbFVPOXF2emltdTIrY1hheFcvbWM0bEY4NzY1amhXY21hN3BL?=
 =?utf-8?B?RmVsRlF6ZUM5NmxuTFUyWGV0dEhFa2R0dzFvMy9ETE1leG54eDUzaS9nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGtrZTRicmRXUGNmSGpPb0g3a1AvWURIYnRyNWVjcUMzQURjS0NyN0pJZ1ZH?=
 =?utf-8?B?NnByOS9xSEZpaTdpZkltVFpkeWtJMWw3cS9Zc3Z4T2JvMnpkVms0d1RhMC9n?=
 =?utf-8?B?ZlBUZHVUZTRnN3FvMERWR1UwdHExV1c0R0lmT0FxaE41RHFPZkRkclpWN1Ft?=
 =?utf-8?B?SzRsUG9NeFg5OGVRa1pRZ25uSFlNQmdQcDV3RWs4OUxialZHYTg5MnRHZHhs?=
 =?utf-8?B?OVh0a0ZYOGFPcURxemhCWmZuZzBVSVI5eWd3NTBuTFk2UVhZMjZ3ZXZhMGhy?=
 =?utf-8?B?cXpXSVI4NGRUT1pkNWw5Skd5YjBXaDZlbW1Nc2RlSU9Ib3pBTENiWDdKamhj?=
 =?utf-8?B?SzlXMUZXVGI1RnFjcGhpOTNUSjNnZ0J1NlViQUlxYjUyV0h6d2ROKzVtWG4y?=
 =?utf-8?B?Qlpna2FjZmRBaVNKSjBaWXFsSDRtLzIwQ3ViRXdmaktOci9IMnV5UkxUVkRY?=
 =?utf-8?B?aFB1bGUwVUpiUUQzMksxYVVUeTUrZ0tUblR6K1diUGNhMlBlWDdRZlp2Y1BX?=
 =?utf-8?B?UGJNWHJWQjFHLzczRlRJTkZobU1rUVF0TlorTER2V3VyajZZb0U0VS9hcHhS?=
 =?utf-8?B?U0xwV0d2dHZHTkZxK3pHVUlYMG5rS1NQNHA0L25DUnpmZTQ3UTY3V3QxQ05S?=
 =?utf-8?B?bDF5QXdUd2NvUThmYTJpbks2eFpzK2djYUdrS3Z3OEtSbmpaTU5DOEJTSGJU?=
 =?utf-8?B?eC9hTEVQN2Q2Z1dKMkZJNjk0Y3BmQ0IzZ01aZ0djN2JBeWlyNTd1VW54VDNz?=
 =?utf-8?B?YnRFdFBrM1V3cXlEMDRhc2RUOFhROHkwTzZDb1FEeUI1M3Ywc1QzbldHSysy?=
 =?utf-8?B?UjVjSFhLckttZzV6Tnp3ZG1PcXFmbmNNZEp6TE9RK2xnY2NQMFdtMUJVbUVn?=
 =?utf-8?B?Q3E2K3QrS3VKL005TVU2akVDbElnU2o0alJDUFpkNThGN3B4K0tOV3hPTHdL?=
 =?utf-8?B?QUZUOEpvWW51eTlEbjBKU3RQUDhFSEMzTkx5cTV6ZjhnQ21NeFBoYytXZ25s?=
 =?utf-8?B?OXJGRGd4T1pjSWx6NFVBd3hqZWtYZkdseWdhTWVHTlFpcllZTk1FWFYvV2Jt?=
 =?utf-8?B?NW1oZ1RZSjZxY1RCaGZyNjdGeDNMZTErZ2Q3Tk4wTHIyL3lNTUpsb1cyb1Bx?=
 =?utf-8?B?YWVsUXJxbUxESW1uZW9xRXhBd25CazZBWE9YYzF1QnpqUGdLMisxTHIxd1dR?=
 =?utf-8?B?L3Z0WnhtelIvTC9pNDQ2M0d6Z3dwTU9PMy91bEpnNkxwanJpUkdTZ1NFcElF?=
 =?utf-8?B?a05NMy9PWnZTRmZvR0M5djZydjVnRitGK3E5cnhobWZCS1FDZDVaTTZLL2Zh?=
 =?utf-8?B?cE53V1IwOS9oSWZGY0NHeFcwUlRDbTVBbnErR1ZFQkVtR0FsSGtsZDR0TzZP?=
 =?utf-8?B?aFBablVFSjF6V3R5QUxGS1FnYUREYzhza1lsR2xnUHN3ZVpVY21MNTBDTGNL?=
 =?utf-8?B?MEhvUGcrVkV0ZElOeTJVNllFaWswSW0vNXYxYnZOOUl0dHdPWG16d3hXVG5o?=
 =?utf-8?B?QWtRSWx5QU9DdU4xYjJ6U29OeGxUZEJTRldQQVUzZGxncnk3T3F6bGdQekJx?=
 =?utf-8?B?OTBMV0xYZ21iSmU4SmhtZ1d3WWZ2OXhtWjA1OGQvdWsyYkhpRlQ0dkJvQTdp?=
 =?utf-8?B?TjZPTWhYaDQ4d0VlY0MxdC9EcTFZS2VSbjgzaDBaSHFzMWlXVzhGeHd4V0px?=
 =?utf-8?B?cTd4WmJSeEVTN2NkTUVkRG84TlJiUzJqYmV3cVMxeVdBTjRJMFlMYnE3VTNp?=
 =?utf-8?B?RnovbGhJSVdaMkNRMERHY2psdUFsV3JnY2ZDOW1WOTRBYVp1QTlKL1FCZlYv?=
 =?utf-8?B?SnRsTmphRlA3SUo0OUZLYkxJZGFuRkJMQUZWNjhUZGlkMzZvWStlVmlZeDNW?=
 =?utf-8?B?VUpHTlpLQ2dSb2RuSnpra3h4Y09QRVM0Z0NKN3gvb3JCSWZxL0wwMmpTUVNM?=
 =?utf-8?B?MVBqZUgyVTRtelRPT0drTE9FUGhDYm5QRmR3bkZCNEtoRzR1MW1LSWljMDRL?=
 =?utf-8?B?aFowSHJPMjU1QnJDaWlhY25EN2xYQjlhUFJnb2QxRFBPbjZtZkszMVdBczZM?=
 =?utf-8?B?NThZODlqRG1vTUhDWmZzSEMzWThMeG15VEhzeUNWY2pNdGZPSmpsMDVMdk5w?=
 =?utf-8?B?Q040Zkx3cTVlTEd1eDNrUFZuTU9xWVJ3MnZvZWs3bGd1cC8wOGd1VEp5Z1Vt?=
 =?utf-8?Q?xNp+Zj7YTp/4pfe2xZDgNeA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qVo85FsyJ8WZokqk8fq+P1VsWjNs5Zq87k+S9RAyRv164yxSBD2WOSUCtgd+myfftsXCroyGuve29H3t4YeTDU3letdyiUAiO5skPeoG2NEfubJJWUMaz50rCtU0e6+p+sCmQFMJ+urCwur+1maFCcJ7vm5QCpWs7Z621zIXX0YhzGBi6Qmg00BWYVSBhsrgU4MefNWuZizMFKGXjUuaSJ0NhQpRWFqOwqYFLGBAaPQTUSDHAOQpzsaMO43TSS9OhgYbhUK2lNBR/NtLrTuCNMMoH+2LD3jMZRTNkh33sYlAmfW3mnmDxCivM+KxuGP8pGh7vUqavfe2u8cvQxeAB+AKMdIcAE8JapoLl8wJXOC1blj4i3JFjw/pii/ytFTExjFBV8JrnF2fpGUawY10+TZoMO2RcfS4HbHmIJxocmsRIHhdZos5WJvjCCKXztHXBO8N3uMQBZt3gP3g7L2GK0MEJrx/ifA/aGWMd0J0DZuxdXariD41pt7xfehV6LSHnDGwhp1Si483qGx/OO/k77Zb9huEgbP2ZO4pZxlcKob3YcQ3aI0flcQMPQuGLuNz0LDkYjpmVWasXBv6fRw38srqvgFx/BfHSHxc0r76lOU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc2d0fb-1322-4587-873b-08dce3b95a65
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 14:40:40.5668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /BJenlraPvn2LD1EMBSA8ZTtBWQhS+RgsU9DLX0pDAhXc0V193daD8LkUPWaOEBiqa1Kzcx4ODsbWVmUC8JyQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8092
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_06,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410030106
X-Proofpoint-GUID: R6_XT6A1_-PBBvaT6hFQzy1g7yubudgL
X-Proofpoint-ORIG-GUID: R6_XT6A1_-PBBvaT6hFQzy1g7yubudgL

On 03/10/2024 00:52, Stephen Brennan wrote:
> So far, pahole has only encoded type information for percpu variables.
> However, there are several reasons why type information for all global
> variables would be useful in the kernel:
> 
> 1. Runtime kernel debuggers like drgn could use the BTF to introspect
> kernel data structures without needing to install heavyweight DWARF.
> 
> 2. BPF programs using the "__ksym" annotation could declare the
> variables using the correct type, rather than "void".
> 
> It makes sense to introduce a feature for this in pahole so that these
> capabilities can be explored in the kernel. The feature is non-default:
> when using "--btf-features=default", it is disabled. It must be
> explicitly requested, e.g. with "--btf-features=+global_var".
>

I'm not totally sure switching global_var to a non-default feature is
the right answer here.

The --btf_features "default" set of options are meant to closely mirror
the upstream kernel options we enable when doing BTF encoding. However,
in scripts/Makefile.btf we don't use "default"; we explicitly call out
the set of features we want. We can't just use "default" in that context
since the meaning of "default" varies based upon whatever version of
pahole you have.

So "default" is simply a convenient shorthand for pahole testing which
corresponds to "give me the set of features that upstream kernels use".
It could have a better name that reflects that more clearly I suppose.

When we do switch this on in-kernel, we'll add the explicit "global_var"
to the list of features in scripts/Makefile.btf.

So with all this said, do we make global_vars a default or non-default
feature? It would seem to make sense to specify non-default, since it is
not switched on for the kernel yet, but looking ahead, what if the 1.28
pahole release is used to build vmlinux BTF and we add global_var to the
list of features? In such a case, our "default" set of values would be
out of step with the kernel. So it's not a huge deal, but I would
consider keeping this a default feature to facilitate testing; this
won't change what the kernel does, but it makes testing with full
variable generation easier (I can just do "--btf_features=default").

And on that subject, I tested with this series, and all looks good.
vmlinux BTF grew by 1.5Mb to 6.7Mb for me on a bpf-next kernel.
Following datasecs were seen:

[156581] DATASEC '.rodata' size=7379360 vlen=5472
[156582] DATASEC '__init_rodata' size=496 vlen=3
[156583] DATASEC '__param' size=15160 vlen=375
[156584] DATASEC '__modver' size=864 vlen=12
[156585] DATASEC '.data' size=5955041 vlen=15839
[156586] DATASEC '.vvar' size=656 vlen=2
[156587] DATASEC '.data..percpu' size=229632 vlen=389
[156588] DATASEC '.init.data' size=2057888 vlen=5565
[156589] DATASEC '.x86_cpu_dev.init' size=40 vlen=5
[156590] DATASEC '.apicdrivers' size=56 vlen=7
[156591] DATASEC '.data_nosave' size=4 vlen=1
[156592] DATASEC '.bss' size=3788800 vlen=4080
[156593] DATASEC '.brk' size=196608 vlen=2
[156594] DATASEC '.init.scratch' size=4194304 vlen=1

Biggest contributors in terms of BTF size appear to be

- .data (15839 vars)
- .init.data (5565 vars)
- .rodata (5472 vars)
- .bss (4080 vars)

> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Tested-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  btf_encoder.c      | 5 +++++
>  btf_encoder.h      | 1 +
>  dwarves.h          | 1 +
>  man-pages/pahole.1 | 7 +++++--
>  pahole.c           | 3 ++-
>  5 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 2fd1648..2730ea8 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -2348,6 +2348,8 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>  		encoder->encode_vars = 0;
>  		if (!conf_load->skip_encoding_btf_vars)
>  			encoder->encode_vars |= BTF_VAR_PERCPU;
> +		if (conf_load->encode_btf_global_vars)
> +			encoder->encode_vars |= BTF_VAR_GLOBAL;
>  
>  		GElf_Ehdr ehdr;
>  
> @@ -2400,6 +2402,9 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>  			encoder->secinfo[shndx].name = secname;
>  			encoder->secinfo[shndx].type = shdr.sh_type;
>  
> +			if (encoder->encode_vars & BTF_VAR_GLOBAL)
> +				encoder->secinfo[shndx].include = true;
> +
>  			if (strcmp(secname, PERCPU_SECTION) == 0) {
>  				found_percpu = true;
>  				if (encoder->encode_vars & BTF_VAR_PERCPU)
> diff --git a/btf_encoder.h b/btf_encoder.h
> index 91e7947..824963b 100644
> --- a/btf_encoder.h
> +++ b/btf_encoder.h
> @@ -20,6 +20,7 @@ struct list_head;
>  enum btf_var_option {
>  	BTF_VAR_NONE = 0,
>  	BTF_VAR_PERCPU = 1,
> +	BTF_VAR_GLOBAL = 2,
>  };
>  
>  struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool verbose, struct conf_load *conf_load);
> diff --git a/dwarves.h b/dwarves.h
> index 0fede91..fef881f 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -92,6 +92,7 @@ struct conf_load {
>  	bool			btf_gen_optimized;
>  	bool			skip_encoding_btf_inconsistent_proto;
>  	bool			skip_encoding_btf_vars;
> +	bool			encode_btf_global_vars;
>  	bool			btf_gen_floats;
>  	bool			btf_encode_force;
>  	bool			reproducible_build;
> diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
> index b3e6632..7c1a69a 100644
> --- a/man-pages/pahole.1
> +++ b/man-pages/pahole.1
> @@ -238,7 +238,9 @@ the debugging information.
>  
>  .TP
>  .B \-\-skip_encoding_btf_vars
> -Do not encode VARs in BTF.
> +By default, VARs are encoded only for percpu variables. When specified, this
> +option prevents encoding any VARs. Note that this option can be overridden
> +by the feature "global_var".
>  
>  .TP
>  .B \-\-skip_encoding_btf_decl_tag
> @@ -304,7 +306,7 @@ Encode BTF using the specified feature list, or specify 'default' for all standa
>  	encode_force       Ignore invalid symbols when encoding BTF; for example
>  	                   if a symbol has an invalid name, it will be ignored
>  	                   and BTF encoding will continue.
> -	var                Encode variables using BTF_KIND_VAR in BTF.
> +	var                Encode percpu variables using BTF_KIND_VAR in BTF.
>  	float              Encode floating-point types in BTF.
>  	decl_tag           Encode declaration tags using BTF_KIND_DECL_TAG.
>  	type_tag           Encode type tags using BTF_KIND_TYPE_TAG.
> @@ -329,6 +331,7 @@ Supported non-standard features (not enabled for 'default')
>  	                   the associated base BTF to support later relocation
>  	                   of split BTF with a possibly changed base, storing
>  	                   it in a .BTF.base ELF section.
> +	global_var         Encode all global variables using BTF_KIND_VAR in BTF.
>  .fi
>  
>  So for example, specifying \-\-btf_encode=var,enum64 will result in a BTF encoding that (as well as encoding basic BTF information) will contain variables and enum64 values.
> diff --git a/pahole.c b/pahole.c
> index b21a7f2..9f0dc59 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -1301,6 +1301,7 @@ struct btf_feature {
>  	BTF_DEFAULT_FEATURE(decl_tag_kfuncs, btf_decl_tag_kfuncs, false),
>  	BTF_NON_DEFAULT_FEATURE(reproducible_build, reproducible_build, false),
>  	BTF_NON_DEFAULT_FEATURE(distilled_base, btf_gen_distilled_base, false),
> +	BTF_NON_DEFAULT_FEATURE(global_var, encode_btf_global_vars, false),

see above, I'd suggest making this a BTF_DEFAULT_FEATURE() to make
testing easier.

>  };
>  
>  #define BTF_MAX_FEATURE_STR	1024
> @@ -1733,7 +1734,7 @@ static const struct argp_option pahole__options[] = {
>  	{
>  		.name = "skip_encoding_btf_vars",
>  		.key  = ARGP_skip_encoding_btf_vars,
> -		.doc  = "Do not encode VARs in BTF."
> +		.doc  = "Do not encode any VARs in BTF [if this is not specified, only percpu variables are encoded. To encode global variables too, use --encode_btf_global_vars]."
>  	},
>  	{
>  		.name = "btf_encode_force",


