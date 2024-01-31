Return-Path: <bpf+bounces-20855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B0D844651
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 18:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61F0D1F27568
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 17:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AEF12F586;
	Wed, 31 Jan 2024 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l1/uM77/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OZafVL+5"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7320312DDBF
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706722756; cv=fail; b=kh7swGIad5T9hDVsb2m5VRKY7XICLJDSsRxnIxYPsaZa45xrXbuBWG8oR9aMOtaA7GmNOGlu1HPac7zEnVqmAmjhNAgQJZPjC410DbAKsHr8+AKqyXDjhw7DFQ4UqpbkVYKcOnlj/tC9ylHK9LvdgP0IGEVUT5XNSaq9ScNSj/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706722756; c=relaxed/simple;
	bh=MqdVkMAswX1shXVaMLc5kP4APUCVYkp2brvVwlv01EQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p0+Ge65ikq/8GNvssKGifDvrJeUmDoREcreqVBxz39/01Zl3phApCQj4s9M9E7kUrgfenLjBrB7lTe/un+8b2j16EOdU0QxUzgZlVuS+BKgzI8RwG+QZBIvoS3qRp7C8isD8ChyijsrgEBN/ljmaVVQN2GIOKVtRahqZP2ksakI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l1/uM77/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OZafVL+5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40VHBxxo000529;
	Wed, 31 Jan 2024 17:38:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=pR4MA3gHS8t0/++CE4v4n4SVvtQdD2vdoH8VEZtGP6I=;
 b=l1/uM77/KWn8m+ToqNPiSHZ0zwQ8fcStPI5xpXgmLorYxyWgV6Nch5dVfRDWYs+4nSsA
 wvLGMleHVI5JFC4afNAyY/UD86/WZ+xI6A/VXMTSylD/wiJujIpSzmU8Wz1vHaeGlUD9
 SbA3LjO9WYd3+us/7xhTSlEiGcO1Z2OYRlmJ/nA5PlDFqQvO06NlNvBBc0jQyoABfwRc
 MwGsLQaxoJHqGH0zKFGnoC15gQqZ3VbzC9nFt+koy78xp5IGAnQ0QPgxVwQ2rkHFxKPS
 nXdrEPRICcDHAFNGgStIi4GMUDAKfW3DBZi4DtEXTBIsrxvhq9k/DOTyOHoXWWb7L/w4 qg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvtcv2jkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 17:38:49 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40VGoi2R036048;
	Wed, 31 Jan 2024 17:38:48 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9fn7np-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 17:38:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l72fYzWdF0dtR7nixFM9Et8VWfYYYrayDS5XzQfiP6jtjhudzUWKMAttJWbFpr8ohqzzdP/fXqXpBa4ViiWERBvvtcQBH2+NCVl5P6lqLp+dRktZaKAhWCMREcUkiy5pGZR+jcL9bfuZ4i3udXLtnI4G1jzw3A4WaWtduBvj+7X9FSnRlq4/+J8PfJ5NsQVU9ghDsKKzBa5oqkO24w29vSGYvPvu+SJlnL01u8BGX8sSYPyHzt+0yqu4MOAOQlVYNn1D2VrIoohpa0pjj4ak05vSjw1iYVR5o0wUdO94PoYH2xgcKpHXIs/ThJbiKeMEZrMtPKZ7+TD0UWt0b+waWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pR4MA3gHS8t0/++CE4v4n4SVvtQdD2vdoH8VEZtGP6I=;
 b=NJ4mNO5PCrhlRWleScOQXZ3w7XnFJBZRdG2tDG51t0SqJ6gywr7Y16ZEoO+fXA3J8mumRzOo5mre69c4WSb268EDuR5zk+CEqPfqQ3pYK2bwH7KqfBjej7TYk/z5fyLMEgVPo2ZMfhamKXSF6X+Hgdt9bjqhFf6b3My4EJiVUx0Xjtv6h/jkCDF2CT7tqMcz1sN4TOjvLBYBj16v8XvF7yzDGIW+PEl3dp3gq9gcjlY0akjcBren9FGTUZysA7Y4GPlzMasMfOARbJbu+zKNzf1b7bP98RrdqmYe5AXFI72ZraT4IAWe9Yj7qFLqSQO3+8OIGtz/hMTPFjRLqGXWug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pR4MA3gHS8t0/++CE4v4n4SVvtQdD2vdoH8VEZtGP6I=;
 b=OZafVL+54QBUziLUbbEe1qYNe6sbCpmaGO9N3hpXUFRHBNXFPgTs0gfjbHOtFDH5pSCIG4AKOi+sVC0dmMAfmNTOUcPKMUWCjtn6024WeXSnkgg/24ad6mTJ+fQPsVWg72iK/T13ByqcDTkkUjDYG5gnIhkWKA4SuiFhdUj0VUw=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH0PR10MB5819.namprd10.prod.outlook.com (2603:10b6:510:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.35; Wed, 31 Jan
 2024 17:38:42 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70%7]) with mapi id 15.20.7249.025; Wed, 31 Jan 2024
 17:38:42 +0000
Message-ID: <639d1941-f08c-488b-af54-66fc0709e498@oracle.com>
Date: Wed, 31 Jan 2024 17:38:37 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 0/2] libbpf Userspace Runtime-Defined Tracing
 (URDT)
Content-Language: en-GB
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org
References: <20240131162003.962665-1-alan.maguire@oracle.com>
 <vtkysqjcvf7yi6cwa4l5w44nuk6hvpe47f6ikchob3djzxfi7q@udajgkhv2rdq>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <vtkysqjcvf7yi6cwa4l5w44nuk6hvpe47f6ikchob3djzxfi7q@udajgkhv2rdq>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0072.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::10) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH0PR10MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: e67d10c1-5a97-4cf8-b28f-08dc22837760
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	IWJjb7paIA7xJfEgkuZDXmJupTc9MVjvZl2ilIHbA6owxezSkvXFZpkD76Sk2WI+nB0dJFeeXt+GKJMgQw/8zwYaQnMcMdVDuHSa/W9/kiQpnfAbZSR2lMHUP/erjfM87GEt7mVcT2oKcMBeUEvKipLJusmoyjzY1OSu17fPd7IrwtC1jRRzkhRFQlQc+QcO4v+LKP9H1Haqy+kWPftQtj157KYIpmLEBzImIRz/lA2aFvxfMJqUYbBCv2f2NAueZTCmeewq+19PNsPBikjUXLvxnyo4eVwwjr5a4ZASJh0xDzFeCgIQvs0z2qQCvsRwWyFpfs9nWgthRsEk4bwhnyhsyoTszrP+Scs4vg1hT7zPTrat6pU/KTAGRt1eJD0XYtWEniTG8G4pSq66VGEBIO9+GU4utvwB+7CObMCiIr04P7IyaYQFhCL+XSsHKR+ALGxaViwx5YbNh/emEnBzUc82zFmiaIpyxQGw3+A07fIwfSSg3xePT/sHaqjZRa1qL53Nh2oi0FqRrsiA5EOOvbYFpyZkkproLYAJZrYJfRbnfXdujzxCWvlQ+gpzE9tUq9L6yTpMlPCajJm9HU67c7fpoBWr0AF/fHGomSvq1bXTbLOeD0c/wE316NYkeLGlTjIld0bzjpUHlfLEOl3psQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(136003)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(31686004)(83380400001)(36756003)(86362001)(31696002)(6512007)(38100700002)(2616005)(6506007)(53546011)(6486002)(2906002)(6666004)(316002)(478600001)(41300700001)(6916009)(66556008)(66946007)(66476007)(44832011)(8676002)(8936002)(4326008)(7416002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q3Nzd1AxN1RmVXovUkN4UFhsMGVZOVBzTmp6ODl2NWJ5ZkEzSWpFdGxPQUhF?=
 =?utf-8?B?VGQ2N01FVnFST0JXaVJlT1oyaDE0a1pXUUpVTEpYdHRZMnJLVGFWN0l6NU16?=
 =?utf-8?B?TmFlTVE4MkVoZHI0K3k1ZmRhYUxYd1pHcm9lUXFlKzB5Z3V4MHMxYTV6V0hX?=
 =?utf-8?B?OVhJcytMVmxGaWRNUUJqT2NYN2hUaVNYbm5ZdERNa0FONkZRVFhZS1dRK0w0?=
 =?utf-8?B?bndMSTZtaUZMUGVaSlZ2b05ROEU1eUhnK1hmRTl3ejl5a1d1MDFDZTZXRzNS?=
 =?utf-8?B?R0NOOU5BV25Xay9aTWFNTm9lbEQ1S2krVzVRVlQ1N0IrOE83R1dzdlJrRngx?=
 =?utf-8?B?VVRzaDFYeUR1TEdZd1cvaURhb2ZLbWlWR0ZHNGR6MER2YTdMYldTdnpZb2Rz?=
 =?utf-8?B?NDVFL25kRkIzZDdpQVRhNkVFODNuT0k3YWRDQys5TWRuS3RSTWliVUZHN3dS?=
 =?utf-8?B?TElRUktBcnk1QzFNZmR3RTNlQXRiQXczaG9vOUJ3cng5aDhTOHp6VFRaSGNv?=
 =?utf-8?B?MXJhdXpIVXN5bmZiTWcxTWViOU5ZM1RVVGptQys4WmxmSlhVTnRlT0NNeTgr?=
 =?utf-8?B?a1N4SU5iZytPaVNiVHFWM1BveGJqSjZYNEdQU2kyRjVlcjJRblZHQ3F6TnZJ?=
 =?utf-8?B?eDR4ekJJWFFid2MydStITzlkUDdZa05ZQ1VRY1ExU0xjVnpFd05oT0VacVpk?=
 =?utf-8?B?LzlIOFR1NHBpZzBDKzBibVI3Y0xhR1BuL2RRSjB3ZkE0ZFh5N3lWczJRdTR6?=
 =?utf-8?B?VXptbFFaUm1GN0pUQUtJSUExTUhCQXRCM2N6YisxWmFvUFFpRDY2Yzhpdytj?=
 =?utf-8?B?b0xaWkJtU3d1U0pVRExtMTUzMS9ZejBsTGNkMnJoekR6Vmxtc2xaaEtCOVVn?=
 =?utf-8?B?ZWExb21lajVLSEhIY1F0T2F5cUtLSnVmR1VSQ1ZZUEkzS2xuQnBsSWFlaXJB?=
 =?utf-8?B?bmp0ZnBzUTN0M1M3UXlITnpVMjRxblBvbVB5MkhxQmZ0aEZaTUdQcFRUS3Va?=
 =?utf-8?B?M0xqNzRZTlROYnFLNXJlNU9KQjYyeXdacU56R3NKQlFab0J4VUVNanJsU0lj?=
 =?utf-8?B?WlI0RUZjemloYm94VVVISGZINTJpVVJVV0hHYkdCVEtrRy9pRVhlTnF0emZq?=
 =?utf-8?B?UXFPNjFQOWdPSEZOY0t2eDd2dG9CN3lQTlQyNjJkUGY0bk0zcElhc1doYWpz?=
 =?utf-8?B?Rmg3THNReURna1dhSUx6ZmdQZGV6dFZCUjZVMWZaYXJ5a3NHTm8rTjREcTJX?=
 =?utf-8?B?dm11YlFFd0ZYQjc4MENKZkFWb3VuRmFCMHA4Y1cva295Ty9mQmhiY2hDazQ0?=
 =?utf-8?B?TTFaa3o0TE4rSUw0UFlYWStJYmRNamlyVHBSNkppL1dUYm1sdGdmYnRtY0p4?=
 =?utf-8?B?cC9tNDN0NjJLUWprTWJQd0E2VXFRRWFZV3U2bnF5U3pxQUJXN29TZkplcHJk?=
 =?utf-8?B?OTZSUnRXbXg2R3pkZzU4TnFYTm13WVMrSFErVGVBTzNKYmZVUkFubDcxY0FT?=
 =?utf-8?B?VTBtbEtuTXFPUmRjbHdRanV1d1VocE8vZnF3dlJMT3pocG1VYlpCa0ZsY3hV?=
 =?utf-8?B?SWFjbll3S1Zibk9rczRYeW5DbjVTMGJGZC9DbzAzK05HZWlTODlXckZQTmRZ?=
 =?utf-8?B?WDlKTnMvZzd2UU8yT3ZVM3FuT1U0ak9uWjBHS08vU3BxT290ZkxRYmFYMG01?=
 =?utf-8?B?Z2dncHFIOW9ERmJVZFh6c2pqM3AzTXpleUR4OG9oTCtyMHhpYzdUd1ZSRnNm?=
 =?utf-8?B?ZzljY2E0RmxoamNkWWF4dUl1OWFyaFpZU2pxUDhVVnRaQ3RFUTNHU0lGQ3A0?=
 =?utf-8?B?MDVlMzFKQmMrTDljOWNLektGUFdUK2VmR3ZmeHhwcFU0MXoyYUsxQWluZFdC?=
 =?utf-8?B?S1NoQXE3QTdyblk4MTdibGYza0dHZ1ZlWDhJNS9UcUN1WTBpT001VVUvc0lS?=
 =?utf-8?B?UTFVS2ZKOXdXeG5mTWlma1NNbEZOMDdtL1J6bkcwSTVURGZNdER6dzFjREYr?=
 =?utf-8?B?YWFuSllvT1BHSTJnTnd5YTU0K3B0M0M3cEUrME5zZUFrNS9KRVlEcmtDTmVU?=
 =?utf-8?B?WjBQdWVyZ3UvcldjeEpFemFITFB5TDBFMmpRS28zakNkZEZkUFVuL2sxQzY3?=
 =?utf-8?B?ZmNhTmVzOWttNE8wZERNSzA5K3RZRk5PY0c2M2VRWDV6RDJJOFNHUVNRVjNN?=
 =?utf-8?B?cVNXbjh3elNUdzRQNDdpejV1U3p5V1ZKL0RFZXphc1lEeS8zSjBCNXNMc0Y2?=
 =?utf-8?B?ZGlTdjJ5U2xuM25XRVp5aHI5eFBRPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	HGmHm2wGyZqnpHA/Hu3SxEgbPKETc0b5GnXAPRmNRN89HdM7agbnmguwEZ7lyqQGrvy13Y7ohzd8ZGOFn3Zse40+0eYOUz7tFuVNxRhRlVqE/VWZQDwKQ4VucyyiW3ylsGjQFezF7b7B1tkWmFFRg27ZITcW/pGZqhiw/j3tfjNymG4C4y+q/x/YfxAjXCQna6CZLHZB6kJcxDxqr0FHhrtUhsnIAq8gNk05J2X6hBkJc6ipKvbaSGK0Be46/HvOON5/IA305E/vGtdKE58/KxIgeykNqVBlgi4//hSTZSqeBOyxyQfPKuHQdltIRTo8ulpiHv6GRnS/xZ5HTzUXSVfPZxZmYcJswsDyqrpo2VHnoupebUr4uSBVBTbfAEvo4oiTfKUqRmK02cCizAyN/WWRLdz8kKYw4DRD/YvWsjSrkpunezeqDY5T9b0/w8Rk7nRrLd0FET5Ncn+uAa+gFxkal+1PApO4Ndrsuw0iLcPsJ85oiKkCPY30r/Q3OlgoNJuBD/DsoMHw82IdTy+BmVapJhItHWf1qq7eogW47u27Sce7GVfxhj2RbmR/yAUHkvZDpDb8x6eKNgQQG0/7En+hA8d3QSFP2WAVCg9yPLA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e67d10c1-5a97-4cf8-b28f-08dc22837760
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 17:38:42.0488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 56A+HWyKt0RNcKkePgoFroAoq2ZZ2eBUy2VnZMHFvEo2WNNx/YEnTLX1hM0ZlY5w/Y2sRLZgwrdoMHkwdTLeNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5819
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401310136
X-Proofpoint-ORIG-GUID: C0vAI8odeb1Di9OUqoGAUdlHO3vgER8w
X-Proofpoint-GUID: C0vAI8odeb1Di9OUqoGAUdlHO3vgER8w

On 31/01/2024 17:06, Daniel Xu wrote:
> Hi Alan,
> 
> On Wed, Jan 31, 2024 at 04:20:01PM +0000, Alan Maguire wrote:
>> Adding userspace tracepoints in other languages like python and
>> go is a very useful for observability.  libstapsdt [1]
>> and language bindings like python-stapsdt [2] that rely on it
>> use a clever scheme of emulating static (USDT) userspace tracepoints
>> at runtime.  This involves (as I understand it):
>>
>> - fabricating a shared library
>> - annotating it with ELF notes that describe its tracepoints
>> - dlopen()ing it and calling the appropriate probe fire function
>>   to trigger probe firing.
>>
>> bcc already supports this mechanism (the examples in [2] use
>> bcc to list/trigger the tracepoints), so it seems like it
>> would be a good candidate for adding support to libbpf.
>>
>> However, before doing that, it's worth considering if there
>> are simpler ways to support runtime probe firing.  This
>> small series demonstrates a simple method based on USDT
>> probes added to libbpf itself.
>>
>> The suggested solution comprises 3 parts
>>
>> 1. functions to fire dynamic probes are added to libbpf itself
>>    bpf_urdt__probeN(), where N is the number of probe arguemnts.
>>    A sample usage would be
>> 	bpf_urdt__probe3("myprovider", "myprobe", 1, 2, 3);
>>
>>    Under the hood these correspond to USDT probes with an
>>    additional argument for uniquely identifying the probe
>>    (a hash of provider/probe name).
>>
>> 2. we attach to the appropriate USDT probe for the specified
>>    number of arguments urdt/probe0 for none, urdt/probe1 for
>>    1, etc.  We utilize the high-order 32 bits of the attach
>>    cookie to store the hash of the provider/probe name.
>>
>> 3. when urdt/probeN fires, the BPF_URDT() macro (which
>>    is similar to BPF_USDT()) checks if the hash passed
>>    in (identifying provider/probe) matches the attach
>>    cookie high-order 32 bits; if not it must be a firing
>>    for a different dynamic probe and we exit early.
>>
>> Auto-attach support is also added, for example the following
>> would add a dynamic probe for provider:myprobe:
>>
>> SEC("udrt/libbpf.so:2:myprovider:myprobe")
>> int BPF_URDT(myprobe, int arg1, char *arg2)
>> {
>>  ...
>> }
>>
>> (Note the "2" above specifies the number of arguments to
>> the probe, otherwise it is identical to USDT).
>>
>> The above program can then be triggered by a call to
>>
>>  BPF_URDT_PROBE2("myprovider", "myprobe", 1, "hi");
>>
>> The useful thing about this is that by attaching to
>> libbpf.so (and firing probes using that library) we
>> can get system-wide dynamic probe firing.  It is also
>> easy to fire a dynamic probe - no setup is required.
>>
>> More examples of auto and manual attach can be found in
>> the selftests (patch 2).
>>
>> If this approach appears to be worth pursing, we could
>> also look at adding support to libstapsdt for it.
> 
> This is quite interesting, thanks for the RFC. I hope to take a closer
> look at it this week.
> 
> At a high level, it looks like you're basically defining a scheme for
> well-known USDT probes, right? Since, not all languages enjoy linking
> against C (looking at you golang...), perhaps it would make sense to
> codify the scheme in a "spec". Probably just located in Documentation/
> or something. That way there can be independent implementations.
> 

That's a great idea. If tracers or libraries like libstapsdt wanted
to define their own probe firings, we could add option fields to
the urdt attach function to specify the USDT provider/probe names
for attachment for runtime probe emulation. If another entity was
specifying USDT probes like this, it would also need to pass through a
hash value, so that triple could potentially be added to the urdt attach
options; doing that would give other entities like libstapsdt a free
hand to define their own trigger mechanisms, and not have to link to
libbpf. That said, the benefits of a common scheme are that libbpf does
not have to figure out which USDT probes to use in advance, so having
defaults that are documented makes sense. It's especially useful for
auto-attach by SEC() name.

> This is something that would be nice to support in bpftrace as well. I'm
> sure other tracers would probably find use as well.
> 

Yeah, I was aiming for as simple as possible to make it easy for tracers
to adopt. The aim is to try and facilitate wider support for runtime
probes, so I'm curious if other folks have run into issues in that area,
or have suggestions.

Thanks!

Alan

> Thanks,
> Daniel

