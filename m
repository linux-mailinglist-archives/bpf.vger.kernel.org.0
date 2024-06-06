Return-Path: <bpf+bounces-31536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D82C8FF544
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 21:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 875511F25634
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 19:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D694D61FE0;
	Thu,  6 Jun 2024 19:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jGTYqsJv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IOEcgNbV"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0B3446DB
	for <bpf@vger.kernel.org>; Thu,  6 Jun 2024 19:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717702088; cv=fail; b=QmOar52kciI/qVlA50zWa5iD6GeydY5z3J9KZrJ0nCAPX7qloHo4jbPGJ7lBGlwmKKFg8/qmp/jQq7bj52hjr/efDYzdUtA2C/GYi5dNxhxZcsFuGH2NsNv7gN90BcPQa6AwfYKjjQmFImjjDXQn0xf6PvVDnVjIZjCk1Wal0e8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717702088; c=relaxed/simple;
	bh=gdE3+bGzFLcLOKMhg8wCb0MnkRCsAQGRbbiA9dUBwmo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=Ck3t9Phyts2IM0yrkRN0ZU72+TEdvUr2J4Fzz6AKHhMhNFj/fad+GSNAqFr3+ws8s7VON9kkOuHwDOQDS0m5jAPF7jsh8uHA+/soNfsF4zDvsMRnH7gj6W1eiO8k6vrSojvzZMsm6M1+KD+N5uBMpdfuV3VjBQyz5bVpE2poDxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jGTYqsJv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IOEcgNbV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 456I01hR001449;
	Thu, 6 Jun 2024 19:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=gdE3+bGzFLcLOKMhg8wCb0MnkRCsAQGRbbiA9dUBwmo=;
 b=jGTYqsJvHMVe+MxTaung/XBamQu3Fh0nmxI1HfozJjjV7mGxOp9edVhHnns3xH8vsHGj
 An76AcKC36wdsyM+Pzo2V48nmPUzDwCubfQDeuFpTthezCOPRsMUnaB8/hs8kKYbrEqe
 3ojRS1qFxtN/CBtMaHRXr6kP/dmbWlOlRUUUdx/iLt2rcxGExilfQ9/xMCYmoHPr98yV
 bAaJJGoy8vFgGl6qiSEJy4rr8UMAZ5c1TxT7Cr9Ee7+Y47vFagehRjOoTHibVPY25ehJ
 Lg7/WlyQn4t7YDkkxG+GK6Mge380sOE+XEC4rju/p27geTaSkhtrcAm+bLaZZJoSQk2u Ww== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbqn4901-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 19:28:01 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 456Hwt0b025198;
	Thu, 6 Jun 2024 19:28:00 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrtc2kg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 19:28:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYyPC0XH9WdPODKyuPOoL2KDkvlQLh3J5tKYMG2N9lOSjEAmJy+rQsK4LNxOycrKWWhyfBwi5WNrhmecx6hgIjFr1846Bh4YpBZLz79JWZGsaT1GaEmjyTsi6P2fhFWseO+djt3e6H3LGUrIpqHLodI7YEQ7oEVw3WtAJoDytSbxd8f0ACg0Sx3hvUHfsx854u6MkVm4m2aD9S+m2qwSwcET3+tr1Knuua9JPecZ1g7ZZHPKqQ2be6Jcv3+qEHBB28PqYBMhIN+SVdb4Zm8QSsLl8QMLL6NcVnHxVC+SdlnLVHtFVYiq2j7/TxhtoU+irjVAe4xRq6W3xF6VJq60Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdE3+bGzFLcLOKMhg8wCb0MnkRCsAQGRbbiA9dUBwmo=;
 b=BcSPjiHFnA5BwJnfdWcvjFpny1bdS6nPOrA8QZegZMQJpU1o3PM8mp0870qeha8VTobzjFAQ/d1Ub2r8Umy43qLKFQ/FvgR2viG40CLrIa4Uy4eTRLf6mkT5gENeL5DYsqi+M6kVuSOjLGyNRwBwhp9KxZ4Wr1zFp2pqDVexwcBFXaLFccrC7V/gLcyp8VeuT7Bhcdd6ZrlNr/psYmBYTck/Xbnm0exgRZY11SzNq1Ptqz1XNSpz2wRqvBOdOvQ2vgLCymo1ChUkHbs6IbghBDp9U26iM51EMSBWrcMtNfIEUpZZQmXBWbOrA0KOC047fYnwdGf3g3w9L3qOmv8vow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdE3+bGzFLcLOKMhg8wCb0MnkRCsAQGRbbiA9dUBwmo=;
 b=IOEcgNbVKOc4cG24rTe8exXuDktWBIQiN78wt32cd3mSukD6JhK4Pes+BzHwKp0qsMCOmiTikw4BzVIy4AHPOwdAJKi5WRQ+/MUSQ/8S2FCQLOu6GXTW9Z1pb9cJAcO3l+NtOiC1Q/Lz/mX+QD1f8T8qspqRo0huGpdA/v90P10=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by MW5PR10MB5666.namprd10.prod.outlook.com (2603:10b6:303:19b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Thu, 6 Jun
 2024 19:27:58 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%7]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 19:27:58 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>, bpf@vger.kernel.org,
        david.faust@oracle.com, Yonghong Song <yonghong.song@linux.dev>,
        Andrii
 Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Match tests against regular
 expression.
In-Reply-To: <2f556a9bd96929bc735f3ab3aca3f385c72e2fc4.camel@gmail.com>
	(Eduard Zingerman's message of "Thu, 06 Jun 2024 10:47:05 -0700")
References: <20240603155308.199254-1-cupertino.miranda@oracle.com>
	<20240603155308.199254-3-cupertino.miranda@oracle.com>
	<CAEf4BzbqhhLsRRTP=QFm6Sh4Ku+9dKN4Ezrere0+=nm_8SzwYA@mail.gmail.com>
	<87ikymz6ol.fsf@oracle.com>
	<CAEf4BzaVkJghcSpLdRdwmRyGVj+SoUnF88d-9e5Xvb7fmuKt4A@mail.gmail.com>
	<2f556a9bd96929bc735f3ab3aca3f385c72e2fc4.camel@gmail.com>
Date: Thu, 06 Jun 2024 21:27:54 +0200
Message-ID: <87o78dvpl1.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P265CA0174.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::19) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|MW5PR10MB5666:EE_
X-MS-Office365-Filtering-Correlation-Id: 20f74811-7b03-48b7-30af-08dc865ec5b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?M2FUTW9URDB6eE1UWnk4N2M1NUpCZ09hODBwZnFHR2RTa3pWK3ZrSnd5b01B?=
 =?utf-8?B?ZGFINjZHSjd2K2ZoRWxqa2ZwK0twTEx3NVZLSjZCK0RGRGlpUllrayszWHlH?=
 =?utf-8?B?VGpMdUN5TytHTkZmdlNUUTBWSHlpR3U2MTB2bCtBMUpFWUpwTEg1dmJCZjNB?=
 =?utf-8?B?ZVNhZ2V6UlNvSWF0TXlxd1I5QisxWDZldEtMVDRkT09tYkIvaFNSRFZadGlJ?=
 =?utf-8?B?NGI2NXdocFpaQ3FlM1FVOGFzNUMyUkt0OXVwV2VsS0xmY3pMS1Z4QkxuTUtF?=
 =?utf-8?B?bGFpclU3TFpQS01yL2xqc0NhK0k2clZBQUg3VlhvQW1YbENHekdUZWVTQTFz?=
 =?utf-8?B?a2NPWFh3UUpoYXBzUU9vR3JnQTJ5VEgzR045VTN5SDNuSWt0QWdZZmh2M3BI?=
 =?utf-8?B?RTNrWGVia0FGSTgrQ1hMcEsvejdwSXc1eGVHVGt1QVBNRlBpL3ZuZlhFcGc5?=
 =?utf-8?B?WVM3dnllZm5SMGV2M3N4T1JoYUM3SFBvZVNjZk5RRGNscWF1bENJdDQwWUFK?=
 =?utf-8?B?b1lSNkU1ZlNoR0lTTG9RSzRUOVpXSU01TnF3blBjemNtdCs5Qmp6L2hUbkpz?=
 =?utf-8?B?ZW8zZFdDNndrd2RWK3F1LzFneVV6bXVmSGhpWmR3ZEdiakpramNocVlMYnla?=
 =?utf-8?B?Sy9sRFFzRE8ydldkZW5Wekx6bTZCRS9LVTNRRm41WHZnTWRQTWZiZkRaMnFX?=
 =?utf-8?B?SDFLbk5EZUJkQktCaHF0TVNUeVdRc3FvZ0tBMFVMZFBobjZTOWt2MU9OUWdo?=
 =?utf-8?B?UldTQisxOEYvUWFMcjlKaXVScjNWWDdVSitxeUR6VjFZZ0J6MFhHUG1SR3RU?=
 =?utf-8?B?OGxlYnc4bERLT1JSMFh1NzFPbGcrTUNpZkplYkZPRzVnc2RmZk16NnFHQldw?=
 =?utf-8?B?NHR0Z1JRY0Npc1pKN2JvZW9Rdzd4Y3NqOXFHMlFRbDlRK29zUFpHTDBHTHRV?=
 =?utf-8?B?bkl3VHFna1FzY0hvTVNvbXdpZzhJdjVJOUZ6aVZxU2Rhb3VmVFZoeWkvRVo5?=
 =?utf-8?B?dlNmY3d3ZE1BWWNrOWZhVjZ5TVhqck1OVGRheXNMZ2ZVbklnbW9udHlsTHFz?=
 =?utf-8?B?NENGT0J5MWNZcm1ETkdJK1I0MVk2c2VqamNPMWtIWENqRWFINllod2hnV3JV?=
 =?utf-8?B?TXQ2UTI3RzFyZVN5VE1zS0VBSHB4cld2Uy9STXQ1T1Z1VjFNeTBxWHpycGhT?=
 =?utf-8?B?cHJVNlVyNzl1OFMvd1dEMzdHU2taVExOQ0phNUdBOTUyWmFBSTZPQXB0SE1T?=
 =?utf-8?B?QSthM1B6cDIrYXZnNktBb1V6aDNqSXFaSFdwMkNkaDNUUVBPMWs1V0dWTmds?=
 =?utf-8?B?Z3NGT1hLWHp2MTUxbm94Ti9RVGNKSGVzRkJVV01MVEs2eTZIWVNNTFlDSGN2?=
 =?utf-8?B?VWQvYi9UYzg5V3RGdjRNb1RUdVJHSXlJRWphY25aaDhCS2pKL0Q4RVA2ZDFu?=
 =?utf-8?B?Y1ROQzhxUThxdW4ybUxjS0dXUzR2WVBLTXdCblZ4TlA0V0ZPbUY1L2d5YUl0?=
 =?utf-8?B?WjA0Tkl0eWpwa3BtTmNpWXQ5dndZRkFJVitqN0dmUVhUZEFqc2lvdzNOZ3hC?=
 =?utf-8?B?SEVtRXNxRTFvd0dlTlh2Z0pQZXJOdndoMHFHYlFwSWRhVm5YRXVkd2VWc0Q1?=
 =?utf-8?B?cFgzMFVXWkNzS29aeDZ3KytNWWM3V2dpajJDaWV0VVp1ZWpjdlRVd2t3aitk?=
 =?utf-8?B?OFZWdGVzeFkvYm5sbXdGZkdHeHU0OSthMWtKUzA5dTJFeEFlaElRNlhCWHE3?=
 =?utf-8?Q?vfXJR2cni4sXh9DTW5PUl9yc7GxiKUwHKGcuViz?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c1ZEYnUrM0ZMQ2E5VFJob0l0Wm92aVV5azk5NGNOMkZpSHdPKzQ4UjFSYnBO?=
 =?utf-8?B?STlRWjRFdS95U1BHV0g3RkxXSzRGRFl0VEk4dC80MjJVVUVlNWhtZDF0cXAr?=
 =?utf-8?B?bUxKOFh6YnUzYXNlc2p2SEQ0eWNDYXJxSHhGMVFJNElBaXFYQXJwSGxsUmEw?=
 =?utf-8?B?UkFQVWduZ1hRR3ZOVmFrWDVCdEdadlU0UlRqQis3Sy95MklrMHVoYlhCb0U3?=
 =?utf-8?B?QUZ1NldsZUR0RDFRcnVhR2pwOStnYlQyb2dFeVNrakovdlNxWFA1NnhkVTVW?=
 =?utf-8?B?MFRUYWIydVZwT0YyeWlGcDlMazFDV1RweDZueDU3NSttK2hWdXFNbFRzWlRF?=
 =?utf-8?B?RmF1RUJxdXAvRVhxR2taUC8yZitRWHg1RXZEa2wrUmJ1c3JlZ3J6UGxZS0Fa?=
 =?utf-8?B?SUhJTGYxZVpuMlltdFB4SFo1SUJ1dWxmbDlSUEpkWE5OeFU4aE5XdS9UT0JN?=
 =?utf-8?B?bnRudUVTZ3hsbThUMjY5YUZRSE41N2FVVkNOZ20yU0VyWmEvT3dlQ1RDMEl6?=
 =?utf-8?B?VHNFQy9mdnBOMjZzOFFLQ0dzL0lJeTRqQ3F0VmtMK3BXN2ZhQTVwMEFXeVYx?=
 =?utf-8?B?QzBQaGhrek1nZ25RMWRBeGdibGI2MXM5RG5HeEN1TFExRisrWlRnanRydmZt?=
 =?utf-8?B?WTZMSmUwYnc0aVBUWnF5REQvaXVVcHpiR1VGT0YrYW91KzdNTkFVcjQ4YVgv?=
 =?utf-8?B?NFhTZjRQT3BrSXgzUk1jYThpSUZRSy9DN1dxVGxXbWRwN280bTFEVnNSZ1lu?=
 =?utf-8?B?T3c5UFBYbjlwRmt1YXZmL2ppL29SMmlSZDVTUWNtOThPT3l5RVl6czk1REpu?=
 =?utf-8?B?Z05pMkZIVXZPR2ZBTVp4ckVycVZ2TWlldWkrdzhhU2grQ0RWT3o4NGJlcDlS?=
 =?utf-8?B?OUg0NjJrejdvZHZXOVFmQzN0L0I5aTdjL0I0WUlIaUNWalJ1Ylo2bitSY1cy?=
 =?utf-8?B?ZDFGeFljMnNNRFFna3N4dDdPT2h4YUN1eHcvZVErTG9QNGxxTU9iUWxTT2pW?=
 =?utf-8?B?eS9pTUw0N296N0ZjbSthbXpoeEpXZ1MxZmcxY1QyaVZqMnZTd1lkR1l2cmdQ?=
 =?utf-8?B?R29GUGFSSFRwZE81NjlYNW9zME0xVE5oQ1dRdnJIZDNhb0tYRmQwc2RseE9K?=
 =?utf-8?B?NTFOQlJRZGRBaHN0c1k4cFZONmU2OGhmK0hEKzJ3bXNjbHRwdFlWUHhTUUp0?=
 =?utf-8?B?UEZOWlp0bzhwQXB5MGtHa0liL3ZwT09qbThvTyszRzZTWGc4cmNQY0lHaXY2?=
 =?utf-8?B?eW9IQzNoT0pkc3ByTy9pUjYwVUNRNzNoUXF4dXlTUlN1ZjY4Um1DZzNFOEhk?=
 =?utf-8?B?THJUT3JuTnd2LzJyK3ZZZitWRWxoOXB6cXk1YmpDU3ZOY2ZYcmduWTNDUitF?=
 =?utf-8?B?YzlteVBrQnI2anFOYi9nTUJoWE5hUzFRSkVsZlZ4U2V5QXFCaFdQQkdqb1hJ?=
 =?utf-8?B?OWZWYXVQZ0c2Vm5wTFo3QjJVOWlzU3QwZ3JOVHhaT0xNZjdEdHNpNi9mWHlj?=
 =?utf-8?B?OXRsQ0hJMXN2dzhaNk15eUNRTEJsU2NqSTd6Skt6ODBqYzlIVDNBQlBoNG5K?=
 =?utf-8?B?TGJ6NDlqRjZLVURCZDBPVGMveTAxRCsxY3djRHFwazBqenhONjFKaEMxaTRP?=
 =?utf-8?B?dWM1U0cxOHZWRkRtNVNWUjJtVmRhTnJJa1UrVmllclFuaHNDQjhkbGZweWhF?=
 =?utf-8?B?NWlOSmdkdmxwZGNmMTVEUk1hd1hJV29zL1krMEpYcXNaSmF0SkN6bEY1WWRG?=
 =?utf-8?B?bSthZDlyK3JNUFl6cGFkUDcycWZjVmZUUEQzTHE3VmVJdzlvajhLR2FaQW1y?=
 =?utf-8?B?S2xTcEN4cVBUMHNYTG5QN0RzRVFyVUNWOEdCbjdBbGozSzB6L0g4VVN5cmZZ?=
 =?utf-8?B?S0hmUGh5aURtVmVSejl1NVB5VjQ5UWVtM3poQTg3dnZjWi9aODNYSHpVbmtH?=
 =?utf-8?B?aFlTM3dHU1RjeCs1RGVHcUViZHNrNkJMRFZPZzU5Y0dPdTBGUjJoZUE2L3pj?=
 =?utf-8?B?aHJGTzJlN2VRK1BGdFZMZWRySmZSQmQ3aVJVdTdtOU5IODgwSjY3OW9zb0pq?=
 =?utf-8?B?U3FmQ1hXV2lHUy8xS0JOUkVMdk1ydFZtUHY1WVMvd1RmNW1abG9KMU9HaHhP?=
 =?utf-8?B?TC9ULy9zakF3ME8yZ0o0ZlRGb1JETzI1b2swV2lRU3ZpREkyWVBtNDErRE9m?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	X742qL5emEApNe69LLDkskg/p0w0Skx2g45iBwvw5TcctTqijwR5D3WZVPQS6hbl2yeUJ9dfLZgSthjfNQhO/qwbe5k2+5dnL0z84ISijq56st7qLhJSb0LhwLPWJTBKABP5JScdR5ZtZ2Fz4coscMihwPwhSweCffjMLA6vzfMaDrPcRm8/qLrK5+OZ/3bsiagmhyX6EHXQvb7iqTTZ0A0UcD72HB+1DlEu0DFV9fjd/+jgGmUrEfQfOy+evinh/QDy1Ff2louMrlVlVy13vc6U/y1vd6JUNEyITwrk2f1Fy83KAoW5cNqlP018JO6rH9iZXS14CmYVSr3Snpa0SbhC5TYDrqixKmboA6GBW0w+x08HEpcURkU2ypnYSH6UhfYxNehFQwm//7pR3JGo6hU7aocUk+mLfTKODBRNUUk4FNsnfMI+IiBGgmctRXfuo1qLY2N0C7OEZTUcMrbm0Q87eZJGDiDL3tmdSMho66S3ttJ+44hGceaFRaICKPlVLZ380Xlz2KkqYEbohtcRYA4qcsKuGeReccvS0uq46glRwjBYCFwZ9N2+AuEAA8ybYk178Q98/Q6YKH43ERw7o5iPh07goA/kj2MrSSqgWpM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f74811-7b03-48b7-30af-08dc865ec5b6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 19:27:58.3816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E7WlXXoLtkBYnTjtDy57iv2B1EF/TIaEDbzu/Pja/fC+KMuF9k3L1MMg69c9VeYTvqHSj7evBANTKeLx7VjNY0xEQivO/ItewmJzDBN04wA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5666
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_15,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406060134
X-Proofpoint-ORIG-GUID: yRSem2XJnWaInGSjNc0_-xi7PNy6yciC
X-Proofpoint-GUID: yRSem2XJnWaInGSjNc0_-xi7PNy6yciC


> On Thu, 2024-06-06 at 10:19 -0700, Andrii Nakryiko wrote:
>
> [...]
>
>> > Some other test, would expect that struct fields would be in some
>> > particular order, while GCC decides it would benefit from reordering
>> > struct fields. For passing those tests I need to disable GCC
>> > optimization that would make this reordering.
>> > However reordering of the struct fields is a perfectly valid
>>=20
>> Nope, it's not.
>>=20
>> As mentioned, struct layout is effectively an ABI, so the compiler
>> cannot just reorder it. Lots and lots of things would be broken if
>> this was true for C programs.
>
> I'll chime in as well :)
> Could you please show a few examples when GCC does reordering?
> As Alexei and Andrii point out in general C language standard does not
> allow reordering for fields, e.g. here is a wording from section
> 6.7.2.1, paragraph 17 of "WG 14/N 3088, Programming languages =E2=80=94 C=
":

GCC does not reorder struct fields.
The option -ftoplevel-reorder enables reordering of data declarations.

>> Within a structure object, the non-bit-field members and the units
>> in which bit-fields reside have addresses that increase in the order
>> in which they are declared. A pointer to a structure object,
>> suitably converted, points to its initial member (or if that member
>> is a bit-field, then to the unit in which it resides), and vice
>> versa. There may be unnamed padding within a structure object, but
>> not at its beginning.
>
> So, I'm curious what's happening.

