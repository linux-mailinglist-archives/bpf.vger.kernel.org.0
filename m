Return-Path: <bpf+bounces-58532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1430ABD299
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 11:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 492987B3F1F
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 08:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6B1265CDE;
	Tue, 20 May 2025 08:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UEHY3VSO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bqTOVOll"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA1B64A8F;
	Tue, 20 May 2025 08:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747731597; cv=fail; b=sfbRVFp45xPqanjD+SCrlrXG5tYzzY6CI/GKuVW1YKMrhJtPI5iT7oCI9+LBSGUj8HRlxljFy3hpkRHDKLvQfXO269VcBaxbGXqKrQb+ps21uu51mDMm6PedSCE0eMKAHiY1x63jlJiw+GhsGiKRmcHvxl0nP4dCfFBLHxAuNpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747731597; c=relaxed/simple;
	bh=SW5aERmtjLBaU0swQZ/SDuI0izmxHP9mmu01vk6I/Lo=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r/MrupxmILkz1JEF0LLn4ba9En71+pxp2k4M3hQybC9/WI8YBTo14TW+KwdSVrO+0hvGCzV7OBpBHeEOK8mhG4I28vzQomGLZ9CWnCdFGaSFJflYkgvusXU3Y+O+BJzwjNO3sdAFWOfDqIyYVmi+WouufvYEDgo+xScyn7SX6OM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UEHY3VSO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bqTOVOll; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K8fWV9022612;
	Tue, 20 May 2025 08:59:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=u/0UyvJ+/9JApst1nMpDzLa1irscVb/2s35VeHMdmlI=; b=
	UEHY3VSOBx9DgcdclDxTKCah4aM4u5lmvbUZz5HcRa1Og0VL1RrdmRXrsB+L4MAd
	MJ3T/+yqu2vUsZ1F0ApWurWkyIB+AGYK/RBgnVVSSMRLdHemkjw//Y7eADbHbjjz
	opKOomm/6IrCN7bXvB+Zq3IFDiPqwP2lqMEn6lpgaFfI6nED0MR9rDsfW1c5iLWY
	wxr943e/kCY22ixKO0QEmh1gLuoyvUKJocPLLSZ9IfodicCU7Ts48fQKSNDeNKcK
	br5kuqRh1cFssL8tqBjSBwwZUDNvy41Y70qAAKnMGU2IqUd6MoTLOlyN1vv7Sb62
	JNZBwOLlWUC5ve2BhiFAow==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46pk0vvwm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 08:59:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54K8Hcsj002414;
	Tue, 20 May 2025 08:59:41 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw7g7wy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 08:59:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjW5T1JyccTROmTFtiFJF5qAhLRvATBv/kFGPOaXUJ3v/2AS/NBIMsUTt4n4AY+7ifBFJnGKrwmaAnkafI4Q2/Ls0Egdg4/SpKX1GBgsHlLSS9XDvSFLDupZ7n5le3L786abBvnqPvmr+1JvRwJXkhxpmXbxePajhcaR4cNnA9q/zCxjo0HIG4OKO7FP7b1i1ahPrTeiUCBG5oxKn7P1ZKXTaO5nRD8coeM470IM1DiMJRqTUgxT2XT/oe5y1cw3ylbBpY+Xu6UNX4GijN+ft/sZxaJlOuBedbieEB0TL5zlRN81iCqtuGcJcBbShwvWLtQC84MWvQDrcFtcfVGRtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/0UyvJ+/9JApst1nMpDzLa1irscVb/2s35VeHMdmlI=;
 b=COdYOvLJAFyriJEVIQPqRV6m94CnvvwVC2TOBZlhph5m/22a6HdChia3jXD3bBDm4IWG839KI1/vHnmCb/EpR4uQtVCyzojs4ZpgOJk4Y8Ena/IrF91I5WCGE4yeN67idJD+fS+GTql0zua463CHeJ4IvEIIkr2zFR6t+JUeZ214OqsfdD+Rg4KZiglU19jHWxK2Pdxc5swSQUy1P8yCvC8mAgS6SA8DtvlnBY4Es4J8OtI0U7BzSR4H/AwfTVH1JeNuhkrZULoV8ioZ3GL7goMz/PN1VhuF+D5knIWYJb3jNkwZ8AQPsT1SnfBgQhhcoKe7B0hYFO8RJdy1bA5HCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/0UyvJ+/9JApst1nMpDzLa1irscVb/2s35VeHMdmlI=;
 b=bqTOVOll7n9ejVtOqNcCls9t4Wf6Y4S6rXT23330v0g3jTonjT46hRhnJ9AVin6aO8o4DgUtN/SLK7iaKMHoMoE4xMvb3Hu6uvLJB/U6fCb38W1q9DVG9rZmD0PAgAUYbC6yyta3yPolXLDCEFp2kc5qg6XpmGQ6L1F6a09I5PY=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ5PPFA7DBF91DC.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7c1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 20 May
 2025 08:59:33 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8699.022; Tue, 20 May 2025
 08:59:33 +0000
Message-ID: <9a41b21f-c0ae-4298-bf95-09d0cdc3f3ab@oracle.com>
Date: Tue, 20 May 2025 09:59:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 0/3] bpf: handle 0-sized structs properly
From: Alan Maguire <alan.maguire@oracle.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org,
        tony.ambardar@gmail.com, alexis.lothore@bootlin.com, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, mykolal@fb.com, bpf@vger.kernel.org,
        dwarves@vger.kernel.org
References: <20250508132237.1817317-1-alan.maguire@oracle.com>
 <CAEf4BzZfFixwy4vQG8jrUBtAOUFx=t1KG2F+AtKPVNCsMz0vQw@mail.gmail.com>
 <8faae89d-3515-480c-9abe-4d0e7514e41b@oracle.com>
Content-Language: en-GB
In-Reply-To: <8faae89d-3515-480c-9abe-4d0e7514e41b@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0535.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::20) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SJ5PPFA7DBF91DC:EE_
X-MS-Office365-Filtering-Correlation-Id: ce237778-d657-4444-ae82-08dd977ca373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?em1TM1NrTlplVUVyN2tFbUFMV2JMMi9LUU1GYnR2V05DZFpwMDVZWUhHUlcr?=
 =?utf-8?B?TmtiamkzZ2JQemxxWkRRcnE4UW5wemt5SDY3WDRGdy9GclpEamt6b29Qc2ZF?=
 =?utf-8?B?ZGd0Tm45VEY5a2NmdDc5Yzg3NEJPUThjZzlqSUpCeWdZenJTUldSRXRCWVdS?=
 =?utf-8?B?ZHpqQmI0ZlJOSXJKYzFlQW1tejRFQmQ1UnNuS0IxSG9wZm4rR1puSHd4ZHYz?=
 =?utf-8?B?d0lHbW5xQ2NhNTUvRDlvUzdyN1B4ZzBZVTZIVkFZZW1tdlFDZkRFclZEQTFo?=
 =?utf-8?B?c0ptQTBMUkZJZy95TEdDSnlLVVJnZFgxcmxyTWlacFFWRWJMVjVSSWdoY0VP?=
 =?utf-8?B?aEh4YVVTWCs1TlhqaTZGd3NiRW9STTFBNUdsR1hNdXVFQi9tblR4bzFkdFJN?=
 =?utf-8?B?bEhwYWtFT0ZsYjZsNlovYjBjQ3liNzFQTUhOQmplSXpIWVExV3FrWkhjazFo?=
 =?utf-8?B?bEMwN0c2ZmxIT0UzV1NDeFU3Zk5WUVpMdGRYWTBRRENxbFhWZC9aNHMydk1N?=
 =?utf-8?B?Mzd2SmxYQjNkS3dWajBac1ZMZE9xUGRIVmhlUG51ZTZxc09jRWdudGxzeXVS?=
 =?utf-8?B?dU1XQkErcC92Qkl2R1VacjFOQ3dDVklVaDZ4OHl6WjlzNDUwM3kxdjlZYVJV?=
 =?utf-8?B?T1N5SEtpT2pOZlJvaHBTUVZHdW5xRmF1T2phZHA1NjFST0xEcUZiR2Zrd3o2?=
 =?utf-8?B?Z2tPMU16L2cwbGo3TFBjdjBjanIxUjVPa3FxVmNOTVlWT3orTnpLQmx5Q1Fv?=
 =?utf-8?B?ZzZ5MEd6TFllYURHaDZCbHg3cmJMMkZva28xakxmcmFIR3FhS3VJZTk3bVZ2?=
 =?utf-8?B?dUJCckNvdVF4ZVVwU2s5SFB3M1oyWVQ3cEFhRElzRTJvQWlFdzRxeTdBekVG?=
 =?utf-8?B?MXhyVytzcTdtVjRnWjd1TFhhVGFsQlJtWVlsSDZ1dmZIMkNScFZrc0Z4cVNI?=
 =?utf-8?B?Q0dtRnJibG11Z3pFKzdEUk10TGZZaU1HeWNBd2tiZlVhQXYrQ09KWUE2dXlk?=
 =?utf-8?B?UGdTMlVNQjBRdTJWR3NBR2xtOTJVdjJDQWJXayswRjRJM0RPa3hvaG1oZFJS?=
 =?utf-8?B?aEhHejAyWjloVlR3bnRGYTQxK2tBRmhuZEtzUlJVRXdVbElDbXYwZ0ZDMkkw?=
 =?utf-8?B?V0tmR1JNblBFUmQrd29COHRkK3Q2Nk53WVBvTkhCeThtUUtZS3VYaGYrUitG?=
 =?utf-8?B?MDQyYW9EZ1ZVL3F0UTFtVk5lNkhEQzhYTm9lV1J6SmpEYU9UTEdva3lBOVZK?=
 =?utf-8?B?UGtBVlp6azR4OENCc1BXemV5VHFEYWpyRlp0SGpzR0xtL1l4UUx2cjUwK0lE?=
 =?utf-8?B?cGZPN29VYUN4SUdKYmFuVGVkbEFOcW1xT0VpQUVOMC95SVN6Y3A1cEozSjFH?=
 =?utf-8?B?VG1mYXlkdkNZTFpOL1lOdEdiQWlmQTF4QnpPWXRWZGdRcFgxNlk0Q2dXd2ds?=
 =?utf-8?B?OThDV1djYitQMkFmZS80citmWGhCY3VmRE1rZEFOc3A2UUxkNHhHVzVRbGpP?=
 =?utf-8?B?RVE5dFgvanR5ZlZMdmVGNXdhVFpzK3RicS9RMlRZUnMrR0JSZllrMGwwakxI?=
 =?utf-8?B?TDR4ejFMSmtLU3A3MnJFckN4WVlqZmRDNEc4UEhsVEhGRklKdnFQTFlYOUFw?=
 =?utf-8?B?dEJJc0k5Y3BiK3BBUXZKcUdtRUI4RktidjZleUhkaW0vR29zRDJTQ1hEUDFp?=
 =?utf-8?B?akVQbXRBT3F2UlZLUnBQdTlLS1g1eUJDdjlOYnVEUzNJMlc1MmpMQ1JBT1Fa?=
 =?utf-8?B?aGdLalRCS3NwcW1HeHJLUEptVU8wSWVITVBvdzk1UEw2Y0xRRnZOanVCUlBJ?=
 =?utf-8?Q?A4oMuGJ9XZ72Amw5rIO5hV4L0mBmB047SQDO8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmlGS1REaHpaMlJUOVdoKzhka21kSlVpRHVwTnFqSEFyaFBQQnlCd3ZmZWdx?=
 =?utf-8?B?L0hacEczdXdCVndabnNqVFZzWEdPT1c0bGU3U0hRSEk1VDVoekl6WTV5b2hu?=
 =?utf-8?B?VUJRZW8yQmRuajFGVU9SMzkvUjdYUU9Gamt4blV1K1FNVGVWblFKamZzalNp?=
 =?utf-8?B?clRnOUYrYWRuRmlWWDViWVg2MVkzazVSV05wOGcySFUwK2Zua2hieitvQzhD?=
 =?utf-8?B?bkFRWUgvZ05pLzJnZllaS3NOMExGUlpnbUVzSWlNanQyK0JxMU1DY1VYSE8x?=
 =?utf-8?B?clFEWGJwbGt3a0JLc3JzOHVRdjBwSlRpT2Q4bThiWmpKVDV5SGpLRjRmU2d2?=
 =?utf-8?B?UWc4RklzWHlkbGdPQjlnTTlheDQyVGNhaTBvcHRYdE1mRHdQTnRHV0hjSUZR?=
 =?utf-8?B?TXZ3YytIOFV5R0I1ZE5XS0Ftb3dtYXk3QVQ5eFlXenFrTVhFVmxGdm85am9X?=
 =?utf-8?B?ZG1hT05xMU5QVnZtU1VCRStPV1k1OHFvRFkxTEowQUVoZ1l4TlFta2VDM3Rj?=
 =?utf-8?B?VTBzSURIY1F6TDlhTDJUYzdWb3oySWFkSlJJOWhJSlVRanRSblJQWWFjbVg1?=
 =?utf-8?B?VTZPOVBob20yRWRRTTQyVi9rdTZ0bHo4UjFnR0ZxRktUcWVkN3NweHZDWERR?=
 =?utf-8?B?aHlmYkUzZWJZN0t0SnQ3aEl5L3pEb3ZoWmp3blVFQlpUSklzL3A2Y1l5aUJZ?=
 =?utf-8?B?N1hZMXJNOHBrRFJqSURMd253RE8yazd2WUYwbHEvVmxkZGIxaStzczk2WUhN?=
 =?utf-8?B?QktaNjgvL0lyU1JzOHFmQWNYcHc0ZERoSFFueElhYTRJRkx5SEQ4c2d1WkdB?=
 =?utf-8?B?dUw1ZDJSa0ZtT3FIOTdzNTdyaXJBcnJTNGg3SmJaS2RqWFIwV1VwbHQ2UU81?=
 =?utf-8?B?L1JxYXUya0c0MXpTcFJSRWFVKyszMXNBY05SbmhOS1E2NFBVUE9MOGVWRjBn?=
 =?utf-8?B?VFJ0Q1kyWWFsZHZlM2FjcHd4VE4vL1FJTlFQaGYwK2o4VjdxQ2hQbHIvY0Fp?=
 =?utf-8?B?TS9aRURvMnZsOVR2bjYveFNaU0h1azZxcVpyL3Y2eGY2Y05wblovTlA3RmdM?=
 =?utf-8?B?UGZOTWhxK1BlR2E1UGl2cDQvSWRacFE5eXByTytoMlN2YU0wWjZSK25yTG5T?=
 =?utf-8?B?bXF1WUs3YTN1eUpnd25sMHc4VUczNnhoMGVaU2YveWx5aVpTNWNzV2lBclRh?=
 =?utf-8?B?UXV6eWNMY29Lajc1a2gyZzVLbkIrV1NsOVhaTklkMDRJeGJyM043WTZVN2V1?=
 =?utf-8?B?VXp5TVQ0Wm1pQlh1Zk5jSmJYbWNaa2t3RzM4Q0RhME5wOGNYSnUyYVpXOXJq?=
 =?utf-8?B?Z2hlYTREQTk4WVl2Y29ONndaaG5ub1NVOE04ZzNJWUZWYjd5b1NlVWRLeXB5?=
 =?utf-8?B?cEJWMEIrbXp2bndQY3ZwdjZIQ1dhRDJ3eDZwUTlpL0NRUDA5b084WGJmb2tV?=
 =?utf-8?B?bjFFTHpXRDNsTHZJZEplRFI0VHQ4Rks1QUhUcHd5SXZzUlhYS3ZUdlRqOGY4?=
 =?utf-8?B?OUFLZklrYkZmNFJvTVRLN2UzdFk1RC9INUhLV013enFXcE5lbS81TCtsdFZ5?=
 =?utf-8?B?ejZsd3BPMEpvMFVDVXlnVk1pdmhJM0RSR2ltQ0QvaEs5TFBQQTJwd2QvMDNF?=
 =?utf-8?B?WlR6QTllM1pBdGFrVkRaZjhKR0pLbm5aT002Nmo1SUYvanJxUytOYjI4MmhF?=
 =?utf-8?B?d0FVWmpGSlNIWWkrQ1hBdHdmYmd2ZmUxZitSbEtYTUxFekJzUXJOaWx6NUFs?=
 =?utf-8?B?aWE1VlF4WmI2ajdZUGRSR0gzS1Rjb21pZ3hORkNadm5ickMydEdwTWdnM3l0?=
 =?utf-8?B?OEc5ektpZ2FqNWl3aWZGelk2VnJBZ1ZjTHN5LzVDMitlYXBYZlNBZUM4VzQr?=
 =?utf-8?B?QUxFaGdFSnZRMUVkTll0Vm5WMmtkZFJtSmIzc01qUUpNOWl4b1l3SnV1Zkk1?=
 =?utf-8?B?QmNNTjhpMWRybzBLL1h2NUw1OGc4MlI5RlRDRU5zUXRQbXJBK1pEVmFOamhH?=
 =?utf-8?B?cmVnYlpSNWg3SFhqcnR1Rm4yTXMwZDczcllDRU1abnBHazJBMDhiQTJhWUMr?=
 =?utf-8?B?Yyt6akoyVU1SRkpEK0FrK2p1Wmd0QWN1dDNLeFhVNXFKcVJneHZxOGFFSE1w?=
 =?utf-8?B?RUpodFV5cC9jTHp0Z2xpS3czMHNoTHAvckNYS1hIRmU3WnRZcFkvTE9ZVHlh?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WRGCNOrjEvSUnNHYQ+7PRcGHzEsjslDwz8f1COm++PJYI2LvB+aK8Zsj/g33+8wcAlO5cohV4L9KPY8aJpPivzGHcKAVOTniYWZgRkK3lVbEf6ZjfPTea/NBhUS4I4070YkvTOQkvn7U6beH3K0PsuXa16lC7QdmeFVskpoNdIBDPpKbSrPHt/3IbfuexfCFMbdojTtNOg99r3BXuK/raMSgRY98OJucd5unuWw4ad8aklqOS6Y3WJyhEGFRCjDep1WYwsPHxRGeiztWDUmDWfM1aXmQanzx5I1ZEMXFb8ngQbeCi2WYihv8onlsKLrNxALwrHih8T+Leack3q67urCQ8+AuqxVCQgNY5HpSXJHYXm8F1GXSpfm0com5ratKj5Ixb5WxK7Uh5faDrsRHOmEud5WeO1FI1DW6COdZ1IiS5/1eidAYHSw1MLtITL4iAmzaFIe59s3elUc0imr+ltxkgz7oQ6KgpBnSJH1P6oibnz0/ZH7ak7YRjiXm8z/uo4O5ZMy5rJ0zGLoI+hU/6rd7aR1d8oaZcmbnld/xlOwm8wEDTs8wGFwivAKM0nBNvnXnsHUvdmfJEAVUSkZ8mAfdtcOSSx3XKJh0mYdLiPg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce237778-d657-4444-ae82-08dd977ca373
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 08:59:33.3245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p18XXm6j1NBdNBBDhgaroVs7LCByqwEiJebw757eq5rhkg+dbYquzfuKqJcpnAt0KgOiMM+kLgtGC5VreXBhjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFA7DBF91DC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505200073
X-Proofpoint-ORIG-GUID: 4WDS_esaOOj3SximPqttoEG6ak_ZbGRi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA3MyBTYWx0ZWRfX14IDTxZ04a8J G/DKf+1LdLkF1lb1zZ5Gmh14kG1Bh3kPtBI/zxnJ8e0PGpbm5GBAZlXdoZrbqVJ3kfmc9xqyfCu pNcGuaAlNVNMMuwLO/01YLkcjk1IPxgnYtWz8vB7tKYAxceTJkb5WQ2t9fLAigNLPE48DkUFLBx
 cB2Oi3qtCzhHI78neXOmKNC7bgjG+QcLt4va0bC4GtGgEhpNdfwCYctfualJT201+5gZsZY8Djx +qS3YZewoeiZZ/EmfOCw+8jZZsQc1OsB0TVbgYpfcTvmjhQFZ+JVSJBQDQZAYbFSCJ8pF96FnbI w6d8ZJkioNFXKioo3p9b4GNn3yr9FzeGBVeFW8dKhJmo/OKyclUWEarD+CKJ6KSCUnwh/25JFGn
 ybdsrAuVB9JTQ/34TQlebGqeqdZHKjQQXmWqjbEnpxA7TDkIc6n+56h0uOozBGuD3C90VoCA
X-Authority-Analysis: v=2.4 cv=CMIqXQrD c=1 sm=1 tr=0 ts=682c447e cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=9hUN_IrMVSbGpGRg_woA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 4WDS_esaOOj3SximPqttoEG6ak_ZbGRi

On 15/05/2025 11:56, Alan Maguire wrote:
> On 09/05/2025 19:40, Andrii Nakryiko wrote:
>> On Thu, May 8, 2025 at 6:22 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>
>>> When testing v1 of [1] we noticed that functions with 0-sized structs
>>> as parameters were not part of BTF encoding; this was fixed in v2.
>>> However we need to make sure we handle such zero-sized structs
>>> correctly since they confound the calling convention expectations -
>>> no registers are used for the empty struct so this has knock-on effects
>>> for subsequent register-parameter matching.
>>
>> Do you have a list (or at least an example) of the function we are
>> talking about, just curious to see what's that.
>>
>> The question I have is whether it's safe to assume that regardless of
>> architecture we can assume that zero-sized struct has no effect on
>> register allocation (which would seem logical, but is that true for
>> all ABIs).
>>
> 
> I've been investigating this a bit, specifically in the context of s390
> where we saw the test failure. The actual kernel function where I first
> observed the zero-sized struct in practice is
> 
> static int __io_run_local_work(struct io_ring_ctx *ctx, io_tw_token_t
> tw, int min_events, int max_events);
> 
> In s390 DWARF, we see the following representation for it:
> 
>  <1><6f7f788>: Abbrev Number: 104 (DW_TAG_subprogram)
>     <6f7f789>   DW_AT_name        : (indirect string, offset: 0x2c47f5):
> __io_run_local_work
>     <6f7f78d>   DW_AT_decl_file   : 1
>     <6f7f78e>   DW_AT_decl_line   : 1301
>     <6f7f790>   DW_AT_decl_column : 12
>     <6f7f791>   DW_AT_prototyped  : 1
>     <6f7f791>   DW_AT_type        : <0x6f413a2>
>     <6f7f795>   DW_AT_low_pc      : 0x99c850
>     <6f7f79d>   DW_AT_high_pc     : 0x2b2
>     <6f7f7a5>   DW_AT_frame_base  : 1 byte block: 9c
> (DW_OP_call_frame_cfa)
>     <6f7f7a7>   DW_AT_GNU_all_call_sites: 1
>     <6f7f7a7>   DW_AT_sibling     : <0x6f802e6>
>  <2><6f7f7ab>: Abbrev Number: 53 (DW_TAG_formal_parameter)
>     <6f7f7ac>   DW_AT_name        : ctx
>     <6f7f7b0>   DW_AT_decl_file   : 1
>     <6f7f7b1>   DW_AT_decl_line   : 1301
>     <6f7f7b3>   DW_AT_decl_column : 52
>     <6f7f7b4>   DW_AT_type        : <0x6f6882b>
>     <6f7f7b8>   DW_AT_location    : 0x2babcbe (location list)
>     <6f7f7bc>   DW_AT_GNU_locviews: 0x2babcac
>  <2><6f7f7c0>: Abbrev Number: 135 (DW_TAG_formal_parameter)
>     <6f7f7c2>   DW_AT_name        : tw
>     <6f7f7c5>   DW_AT_decl_file   : 1
>     <6f7f7c6>   DW_AT_decl_line   : 1301
>     <6f7f7c8>   DW_AT_decl_column : 71
>     <6f7f7c9>   DW_AT_type        : <0x6f6833e>
>     <6f7f7cd>   DW_AT_location    : 2 byte block: 73 0  (DW_OP_breg3
> (r3): 0)
> 
> 
> ..i.e. we are using the expected calling-convention register (r3) here
> for the zero-sized struct parameter.
> 
> Contrast this with x86_64 and aarch64, where regardless of -O level we
> appear to use an offset from the frame ptr to reference the zero-sized
> struct. As a result the next parameter after the zero-sized struct uses
> the next available calling-convention register (%rdi if the zero-sized
> struct is the first arg, %rsi if it was the second etc) that was unused
> by the zero-sized struct parameter.
> 
> I don't see anything in the ABI specs which covers this scenario
> exactly; I suspect the 0-sized object handling in cases other than s390
> is just using the usual > register size aggregate object handling
> (passing a large struct as a parameter), and in s390 it's not.
> 
> So long story short, we may need to take an arch-specific approach here
> unfortunately. Great that CI flagged this as an issue too!
> 
> Alan
> 
> 

I discussed this with Jose, and the gcc behaviour with zero-sized
structs varies a bit between architectures. Given that complexity, my
inclination would be to class functions with 0-sized struct parameters
as having inconsistent representations. They can then be tackled by
adding location info on a per-site basis later as part of the
inline-related work. For now we would just not emit BTF for them, since
without that site-specific analysis we can't be sure from function
signature alone where parameters are stored. In practice this means
leaving one function out of kernel BTF.

So long story short, I think it might make sense to withdraw this series
for now and see if we can tweak Tony's patch to class functions with
0-sized parameters as inconsistent as the v1 version did, meaning they
don't get a BTF representation. Thanks!

Alan

> 
> 
>> BTW, while looking at patch #2, I noticed that
>> btf_distill_func_proto() disallows functions returning
>> struct-by-value, which seems overly aggressive, at least for structs
>> of up to 8 bytes. So maybe if we can validate that both cases are not
>> introducing any new quirks across all supported architectures, we can
>> solve both limitations?
>>
>> P.S., oh, and s390x selftest (test_struct_args) isn't happy, please check.
>>
>>
>>>
>>> Patch 1 updates BPF_PROG2() to handle the zero-sized struct case.
>>> Patch 2 makes 0-sized structs a special case, allowing them to exist
>>> as parameter representations in BTF without failing verification.
>>> Patch 3 is a selftest that ensures the parameters after the 0-sized
>>> struct are represented correctly.
>>>
>>> [1] https://lore.kernel.org/dwarves/20250502070318.1561924-1-tony.ambardar@gmail.com/
>>>
>>> Alan Maguire (3):
>>>   libbpf: update BPF_PROG2() to handle empty structs
>>>   bpf: allow 0-sized structs as function parameters
>>>   selftests/bpf: add 0-length struct testing to tracing_struct tests
>>>
>>>  kernel/bpf/btf.c                                     |  2 +-
>>>  tools/lib/bpf/bpf_tracing.h                          |  6 ++++--
>>>  .../selftests/bpf/prog_tests/tracing_struct.c        |  2 ++
>>>  tools/testing/selftests/bpf/progs/tracing_struct.c   | 11 +++++++++++
>>>  tools/testing/selftests/bpf/test_kmods/bpf_testmod.c | 12 ++++++++++++
>>>  5 files changed, 30 insertions(+), 3 deletions(-)
>>>
>>> --
>>> 2.39.3
>>>
> 
> 


