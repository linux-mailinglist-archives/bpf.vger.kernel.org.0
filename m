Return-Path: <bpf+bounces-50028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA64FA21AB5
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 11:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 647387A05DE
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 10:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0851B4141;
	Wed, 29 Jan 2025 10:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b="APP1p6p0"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00007101.pphosted.com (mx0a-00007101.pphosted.com [148.163.135.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06081B0406;
	Wed, 29 Jan 2025 10:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738145243; cv=fail; b=DNdd+f/QPwOPH2WzyLIzpodc4CnI07/in+2SpKW8b5s7yXC1hX7HbqSTOpMNyz7QuARza1HeYFzElX/TYFGCXnaU9CNRf2DZFN5RY0rpNEOSeBvBryw2zY/NwNQdtWyi0XSJ6WDPW++yLAypvPNMF5xZwKTIUWGIn77D3/p5b98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738145243; c=relaxed/simple;
	bh=p8F8Ma4PvNTDtOXj8ePNTS7GCYcw4bBm5V6zLPdZ5lU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jmm7dbjpHy2tOEKH3k2G0jWxGjxPe7guxSlJDoV4tF43Zm3Ta5qP0MbiA/4vxmF/fKWWFuEwUBS32hYG1nyZ1ddQ2SGiUj6CNnu+EK/NinH4tdi5TGCyUjeoy1JMLAEsfPVN972aIl4Vk9ZdVjhd9UMPRvutTXayDZUWP752QoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b=APP1p6p0; arc=fail smtp.client-ip=148.163.135.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: from pps.filterd (m0166255.ppops.net [127.0.0.1])
	by mx0a-00007101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T6VoqK029120;
	Wed, 29 Jan 2025 10:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=campusrelays;
	 bh=1rw1FguxNlNqBt7SpYzcUlvlpiaG9Fc6k9ClbpnTMFk=; b=APP1p6p05BTI
	WBKnYc8vDtN/PZ7uCc5J/xv/T20AxSU40jtt60tNEbx8tnoH06xYbZRzTQnxz3n4
	uELp8aI73G0FTyAMxsVr3HDbNnlmsP7GllnohCqcI9H1wMQ7V1KuKfY/KmxmC75a
	sHA88oVW9D95fmm+mrGEXphLQQojDPOPb719GwchhURLkn3fRGk31BzO/HBM8/Qw
	KT0HMkquf7wuEOj7oC/ZDH3cm98Gc1LZuuBi1bMYYgqozluH9G4m7699S2Yj1wVg
	/pzD74zxdunRZfdTIhRuAeIKtXpgkePVnodJ75dPbtPuAumLpyQGtJYbzj/sI4mo
	RWQjX5oGqw==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by mx0a-00007101.pphosted.com (PPS) with ESMTPS id 44faxhhmt6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 10:06:36 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5zJx7/h42YVR4O30e7Oc2XOUzCJMYvQAhAvOQywoxEg0AOU0N7fdyExywHC1VrESKFBpKImHEk1D55FXAnmJLRavC3bDsm2JjFcugVq1cfFVHTtpbwVBoU1l0lzEEAfv8bqvkTvBGpgXGuklof2rGlAw4sS3dJprz3EmBAOLERh5XEkrI+K4bw9ehR/PmR0qHncZpRhNW0GuA6/PfT7bH+/cIQFm+fzV/qjoPRoXcRmbxADb/1IEgZ1/Ch3Q2czfhW2vcdKHGKBaxbKEgzaOx0mLlorDabdS8iWAv2QvV0DuMM8NYBZFO7HFNWrlgl3tCgIVeFZ31pr2fI76KvylQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rw1FguxNlNqBt7SpYzcUlvlpiaG9Fc6k9ClbpnTMFk=;
 b=Rn3vXD0ERWBO38LAIX+U0dvfufcWmDULyUSuLvsTJJxOqdncsGSNMR1xc4QriTBvWqJskVYlNm2wkJuVvbhGoqC+eJsUrDAUC3Y6Z7FzQXFgLPq36Vm1Jh74XdcGUImeLBKJ435eVyWbj5Ct83UmXeIq2+eeoiyK8cW4WGyuIqRyMsKQMaQkhqikumoLNkn2gYJdId7w16nnPQcCcEIQQ6+8omFisYkXU6dcLbWGuA1vJYEJtE0VZZTgMns2Z6SatNFvHiK6AWqPi0V3uIXUKuFD1nj3rNTs10QKyLaNNiSdoxbDbTVVp5qgYkR7SpGISz0TyU+y7bS5Jp90V2Y4Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=illinois.edu; dmarc=pass action=none header.from=illinois.edu;
 dkim=pass header.d=illinois.edu; arc=none
Received: from DS0PR11MB7286.namprd11.prod.outlook.com (2603:10b6:8:13c::15)
 by SN7PR11MB8025.namprd11.prod.outlook.com (2603:10b6:806:2dc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Wed, 29 Jan
 2025 10:06:35 +0000
Received: from DS0PR11MB7286.namprd11.prod.outlook.com
 ([fe80::d52:d2da:59c7:808]) by DS0PR11MB7286.namprd11.prod.outlook.com
 ([fe80::d52:d2da:59c7:808%4]) with mapi id 15.20.8377.009; Wed, 29 Jan 2025
 10:06:27 +0000
Message-ID: <501166cc-02fe-431c-9258-c2f44227ebc4@illinois.edu>
Date: Wed, 29 Jan 2025 04:06:25 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 2/2] samples/{bpf,hid}: fix broken vmlinux path for
 VMLINUX_BTF
To: Benjamin Tissoires <bentiss@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jiri Kosina <jikos@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <n.schier@avm.de>, Ruowen Qin <ruqin@redhat.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
References: <20250123081950.173588-1-jinghao7@illinois.edu>
 <20250123081950.173588-3-jinghao7@illinois.edu>
 <CAEf4BzbCm4=NLV4DOyRxvxEtZUONzqmXBOFMp5cg=4hPEEYUtA@mail.gmail.com>
 <2sxhtfdzspkn5umtfpxiueb67v4jhl3nad6i66qtfry52o7sip@nm5oeplybppa>
Content-Language: en-US
From: Jinghao Jia <jinghao7@illinois.edu>
In-Reply-To: <2sxhtfdzspkn5umtfpxiueb67v4jhl3nad6i66qtfry52o7sip@nm5oeplybppa>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR13CA0038.namprd13.prod.outlook.com
 (2603:10b6:610:b2::13) To DS0PR11MB7286.namprd11.prod.outlook.com
 (2603:10b6:8:13c::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7286:EE_|SN7PR11MB8025:EE_
X-MS-Office365-Filtering-Correlation-Id: a31047d9-579d-4257-36d2-08dd404c9818
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjVvUkY0RVFZWW50cE5nNzcvcm1aR2lKNTZ0RHNIZmU5VGc2K0w1TXBLU29x?=
 =?utf-8?B?bmlaWEN5OFY4blJKS2RocjRQbUNad0xaL1BacEJrN3AvZ1ByeDM1L25HNDVt?=
 =?utf-8?B?L3VVTHlLNXRmQXgzWWo0Q0JJdWVsb2g3a0dYeHh2QnJPZ2YzL0lFS3B4eUl2?=
 =?utf-8?B?R1RBYSticThicFlnS1NqUTJNL0xkSXlWR3Boem96cEs0dy9UaExmMG9SL29m?=
 =?utf-8?B?UVVOT2d3N1U1ekZkRXRoOTRxQ1dSdnpKektHcnFsZzJ3bjNDUFN4bkJqa3pL?=
 =?utf-8?B?OWl4S3BjNG5sRHBZci9zaXFIVFZXMXhHSzV6Z1J5VWltL1l3QUVGd1RvMFNJ?=
 =?utf-8?B?VEhpdUpTQ1dYVngrZy95WUFTU2hGL0wwQlV3NHF1ZWlIWWNQa2VGbllBcGlp?=
 =?utf-8?B?RTRqR0pTTU1PZ05ySDRWZDVGa2VVcDRIOXF3cDRmZldYV0xjemJ2bFB3bHRE?=
 =?utf-8?B?RnVxeTduMTN4bGNpUG5VV1lxSUdyKzducWlCN0lCMlF1Ti9nVlJ1SXo5K3dI?=
 =?utf-8?B?Ukc4S040VSttdk91NlFHNTNyNHlIQ0s1WElhYWQxendKSU9qblJHNm5PZ3Nk?=
 =?utf-8?B?dDNhbjlackdVTzlsTzJLOUo5SGJMQmpQemdCUGN3aU5mM2lxNjQyZ28vTzl2?=
 =?utf-8?B?N0hrWVNMR3lXb1p1ekV2TStGeWtMTDZSdmlMZWE1TlNDbE5sRG1rb1JpcE1M?=
 =?utf-8?B?SEs4QlhJZDRPWkdOSTNVbXowZHBNYWp3aHk1N01lOTVWbEM4cFZPRWNvYW1L?=
 =?utf-8?B?eXdtZUx3c3I0OHhka3NGQjBKdzZPOVNQd0dWNGRmVC9tQ01EM1QyUzhxWmc3?=
 =?utf-8?B?YXVFZlBjZ3Z2VGR4SWN5aFVUZ0J6aXdLdzNGY1hON2MycitZSzFPUTV5aW0y?=
 =?utf-8?B?RkxIV0dHM1F6WFVyRzkvVkRyb00wcG5oaExzb0VzNWJncEd0T3g0WU1ha3hq?=
 =?utf-8?B?cGkzN3JRRXRRNlFjVlZJa0IzdkMxNnhHM09WdWVUb2lUZkNKL2ZjbFFFc0VS?=
 =?utf-8?B?Z0JRUDhyc0xXdjNBbVdmL01KU3p2ZGg0eUJOZGMvS3Rnbi9Na1VXN1duMHRN?=
 =?utf-8?B?dyt3bmV0dWlsdlVQYnpsbS8yVzB6eFN4dU9hWlpVbCtkdVRpM0toUHhKNWhi?=
 =?utf-8?B?V1diOGoyOXNMK1Z5ZHhVWlB5Qm1Xd012ZVpjdE9jd3dRV1g0QzR5cDA5cGpO?=
 =?utf-8?B?VHp4ZHFSa3NZdW0ybGpJSUtob3JROGhFeWxJcmtyZll4Z2pVeDgwWnFQWmlu?=
 =?utf-8?B?K2FtYUFvNlJ6VTZ6bnNFdU4zbFZyZm1Jbktlb3FnVXEyamxNd09pRTk3Q1B0?=
 =?utf-8?B?NFZpSnNPYXVMWCtLRjBsUHRIZXRESHJySVoxL0ZXY2JZRHUvZXFPOCtMVDJI?=
 =?utf-8?B?VUE0TGtiRnJMbUhIYzRQUnlRM3NWbUl5azY0cVV5YUVzOVZ5WS9Tcm5wSFJx?=
 =?utf-8?B?Z0JQZThMZHpucXU0TDUyYjFYdEt0T2h4ZEUzT0t3cVgwSWJKTk1qUm9leDQ3?=
 =?utf-8?B?RUp4U0MzUU5PWndtTE8rYmtZNk81UWJoUHBlRlZPMElRRHQ2R1NBZVdvbkhI?=
 =?utf-8?B?d1JZcGtOYXlVUmJhN2hRSVV0OE9za2o5ZWZnNUM1SitocHA2c0huZHZnRnI3?=
 =?utf-8?B?SVM5a0wzYmhoN2FkdmplUDBYdDF0Z0MxK1JIMksxWlhpVHJ5b0w2ZDd1MEFF?=
 =?utf-8?B?KzhvMEFBVUlEZnRuR1JKa3pwMkFMdG9JWjFkRlFzc21DVFBieWhZTUh2cHJ0?=
 =?utf-8?B?TGZoTnk4TDNWaXVIaEVqb3FHUVBwaEdiT1ZKUjUxdkI4ZFRTU2szS1hONFJL?=
 =?utf-8?B?a2orZnZHMTNwd0ZtbVJPejNVTy9VNzIyQXdYejR1dmZOUVZMa2NxUVBCYUEw?=
 =?utf-8?Q?hRLq71E8NFODU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7286.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUJtMmlEQWIvcnBHMmRzbzVVbzhtcTk2RG52V1NSOEJNdHhKSzRtTzBaY0Nr?=
 =?utf-8?B?YlVOVHZ3OVV5SWlhbm94dUxSNDZnSmxUdGpTQ2dPTXY4ZHJQR0xxOVp5ckdB?=
 =?utf-8?B?ajZUWVBPVmxTSTJGL1FXQ29Ta0FFaFpYeEt5NjBENjh6RVc5Wi9LekxZWjQ0?=
 =?utf-8?B?c256NHBGdGpOSlNhcnBQMG9YOENBVGIyMGszNmQ5V29UZFp0aXFSMXo5ZGEx?=
 =?utf-8?B?NFVSc3Fpd3BUU1haZ0E2a2owUFFueGZMMTdIZmlKV2hISnRIL1NJdk1ncmJG?=
 =?utf-8?B?b2F0NkxKWndBdXk4MVIrUjRsdmw4U0pCeTF3WEprMDR2NDNUNW1yd2ExQWdV?=
 =?utf-8?B?V25iR3QxcUljYmU2VGdqUE11TVRBUDluZEs2MzlrakxqTUF6V0dtN2FxK2Uv?=
 =?utf-8?B?YWFtL3gxNEY4ZEV6TUd3Q3lIa09XcDdLVXIzMWZWTjA0bmUvMVRxYkw2MFpS?=
 =?utf-8?B?UHIvSExMZEhCUGk4aHV4QjRqTXhQVk5jQjl6Umx0bUtZVzJkR0hYNDJFb0FC?=
 =?utf-8?B?UEVwVkF5RTl1SHVwNTFNT0lua2RHUUU1Umc0VE5UOEVHZVU1dnNFSEdpdjVs?=
 =?utf-8?B?a3pNWmNnZEtEelZtcnh5bGljRnk0YkNJNlhNTHdUU0xBOEpEWnRLcmhLMWZu?=
 =?utf-8?B?YlFUMUdrV3MxdnRybUdhbTlMSTJNRVl2bzMwT2Fkc3dZVXZuLzBDOC85RG15?=
 =?utf-8?B?aE9jNllwRlVBa1pzSHdjM0lVbC83Q3lvT0FTa3JOdFJQODYxR1FsRnI4eURH?=
 =?utf-8?B?OGNPWHlZQ0xYQTNlZGdnSDBaNGQ3SzBvalpBT3BTeGZHeWhTaGU1QjI4YmZo?=
 =?utf-8?B?OUR3N3RyaWFXdGVKQmlWaHVYTDQzL1h2dHB2cEE1eiszVThBS2hLQ3pudWV2?=
 =?utf-8?B?RWdNcG9KK0lLN09RNXBZdWIxRmlnTzM0U2VPWFVSRG54WWpHOFBqLzBKUVJ1?=
 =?utf-8?B?LzJWTWpDcDk3YXdBcndwbWNHSTFTTnJhVmxNQnRoSUxTL3BKVms0aWpLNUJl?=
 =?utf-8?B?MkVycTBuNHEzZ08vSExFNkl2MFdpL1NqZXNlKzZTQlNhUXJCNFdWcWx1WUJK?=
 =?utf-8?B?NVkrMUVSNnVvR3lVUzB4azQwdzdkNEJkNzI0Z2NWUzlVZzIvN3FsbVNQVllw?=
 =?utf-8?B?K1lRdzJDdE5IMS9KaVN5TkVzNENiVi9IVEt0S3cxcGZFY0lrYVpMSTBXcDZw?=
 =?utf-8?B?aWtSS3dxOUY4d0Z3RnlkUitZajRBT3l0VXdGTGp1amJBZERoWjZxSzJJRUlj?=
 =?utf-8?B?RDJQYzFyd0w5c0R1UEhkTGRBQ2t2Q216RWRiNTIvekFHSFczTUM4NVU4L3Nk?=
 =?utf-8?B?ZkdSbE4xRW5GeTdRc0R5SEM2Q1B2Y0ZhMWNiamlJUEExbWNSWFEweXJtNkkz?=
 =?utf-8?B?T0YzZDdFMlVDcHNRamtRbjFVUkJ5RGN4ajJkZnFjd0M3N0wwbng5aGRkelYz?=
 =?utf-8?B?MnZ6TEt2WTNMNTFvcXRsRnBzMHlEVG9DUGNGYnByN3IraThKMXJFZjl3aXV5?=
 =?utf-8?B?Uncva3VHTzg2L1hTR00yRDJER2hVeFRSWlo5bEFMTFhsOWYwOS96VDZOcS9r?=
 =?utf-8?B?Yi84Q2xRREl0Y2VzTmRJYVFmTHhJRkV3TWh2UFhvZlMvd3RmMTdEbXRRZ3Yy?=
 =?utf-8?B?anR0WjdkZGxZYmIvRVpUeHVEbzBDSDBsU1ZSdlpCdjZud2FYRGVNSk9BbE02?=
 =?utf-8?B?VXF4QzhxTDVxa3VrbzJoekhNdGtFR3IzenBybnpIS1ZORENlMmpIc2pUZ0F2?=
 =?utf-8?B?d2dQMzRKVmJVVWxpcDNXbVltNTgrd1dvVHRJSnEyMS9GRkRiYndISG9uK3Q5?=
 =?utf-8?B?U00zL2NzTGs2NmNIcThZWFY4UDFKTncyck42YWJYSk9LcG1jQmduQW55NXNZ?=
 =?utf-8?B?d244bWNBWitwTTBmVzRmVGl6SXU1cExkbnVETEcwSXZkQ1llak5QWkZwa09p?=
 =?utf-8?B?ZGoxL2xIK0lKUXN5R1N1VmpEK2U2bGQ2U2FTbWJJQ1BvT3M4UHM2RVk3SlU1?=
 =?utf-8?B?UnJMeWZiZklzNFc5K29PRUZrU05yQTltZW1CVjQ5KzFNcCtaemFxTW9wazB1?=
 =?utf-8?B?NEo0SENaV0Q3K3N5R1dUK2JMbS9EZlJ2SE9oNjllN1c0WWRLN1pUZFRyR2dX?=
 =?utf-8?Q?DiZ8Fli91aG6HWemEr6hIG0GZ?=
X-OriginatorOrg: illinois.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: a31047d9-579d-4257-36d2-08dd404c9818
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7286.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 10:06:27.3018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 44467e6f-462c-4ea2-823f-7800de5434e3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6T3+6OU22bNCZNpNLwBYBlR52lMGQZdeEj1CE8ln4TqAmh8TG6AblGK1sMiHMByv5SCKsmE/DmTBfuPeegVTFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8025
X-Proofpoint-ORIG-GUID: jW2-kahBbC7X61TPgNiq_VvDWnb2DnSe
X-Proofpoint-GUID: jW2-kahBbC7X61TPgNiq_VvDWnb2DnSe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 mlxscore=0 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290082
X-Spam-Score: 0
X-Spam-OrigSender: jinghao7@illinois.edu
X-Spam-Bar: 



On 1/24/25 2:04 PM, Benjamin Tissoires wrote:
> On Jan 24 2025, Andrii Nakryiko wrote:
>> On Thu, Jan 23, 2025 at 12:20 AM Jinghao Jia <jinghao7@illinois.edu> wrote:
>>>
>>> Commit 13b25489b6f8 ("kbuild: change working directory to external
>>> module directory with M=") changed kbuild working directory of bpf and
>>> hid samples to samples/{bpf,hid}, which broke the vmlinux path for
>>> VMLINUX_BTF, as the Makefiles assume the current work directory to be
>>> the kernel output directory and use a relative path (i.e., ./vmlinux):
>>>
>>>   Makefile:316: *** Cannot find a vmlinux for VMLINUX_BTF at any of "  /path/to/linux/samples/bpf/vmlinux", build the kernel or set VMLINUX_BTF like "VMLINUX_BTF=/sys/kernel/btf/vmlinux" or VMLINUX_H variable.  Stop.
>>>
>>> Correctly refer to the kernel output directory using $(objtree).
>>>
>>> Fixes: 13b25489b6f8 ("kbuild: change working directory to external module directory with M=")
>>> Tested-by: Ruowen Qin <ruqin@redhat.com>
>>> Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
>>> ---
>>>  samples/bpf/Makefile | 2 +-
>>>  samples/hid/Makefile | 2 +-
>>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>
>> can you please split samples/bpf from samples/hid changes, so we can
>> land samples/bpf fix through bpf-next tree independently from other
>> changes?
> 
> FWIW, I don't mind if this goes through the bpf-next tree all at once.
> 
> Acked-by: Benjamin Tissoires <bentiss@kernel.org>
> 
> Cheers,
> Benjamin
> 

I wonder how we are going to move forward with this fix? Do we want to let
it go through bpf tree at once or split the changes?

Best,
Jinghao

>>
>> pw-bot: cr
>>
>>> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
>>> index 96a05e70ace3..f5865fbbae62 100644
>>> --- a/samples/bpf/Makefile
>>> +++ b/samples/bpf/Makefile
>>> @@ -307,7 +307,7 @@ $(obj)/$(TRACE_HELPERS): TPROGS_CFLAGS := $(TPROGS_CFLAGS) -D__must_check=
>>>
>>>  VMLINUX_BTF_PATHS ?= $(abspath $(if $(O),$(O)/vmlinux))                                \
>>>                      $(abspath $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)) \
>>> -                    $(abspath ./vmlinux)
>>> +                    $(abspath $(objtree)/vmlinux)
>>>  VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
>>>
>>>  $(obj)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
>>> diff --git a/samples/hid/Makefile b/samples/hid/Makefile
>>> index 69159c81d045..db5a077c77fc 100644
>>> --- a/samples/hid/Makefile
>>> +++ b/samples/hid/Makefile
>>> @@ -164,7 +164,7 @@ $(obj)/hid_surface_dial.o: $(obj)/hid_surface_dial.skel.h
>>>
>>>  VMLINUX_BTF_PATHS ?= $(abspath $(if $(O),$(O)/vmlinux))                                \
>>>                      $(abspath $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)) \
>>> -                    $(abspath ./vmlinux)
>>> +                    $(abspath $(objtree)/vmlinux)
>>>  VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
>>>
>>>  $(obj)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
>>> --
>>> 2.48.1
>>>


