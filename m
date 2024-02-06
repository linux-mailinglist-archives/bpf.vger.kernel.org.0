Return-Path: <bpf+bounces-21296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A81F884B199
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 10:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFF77B23275
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 09:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A352D12D776;
	Tue,  6 Feb 2024 09:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iLRhNuP2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dP/OIZXO"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C250812D749
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 09:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707213014; cv=fail; b=EVGJXSoHJ8V3WpoyPEEbGA7iJi6nwHcttm6WclXGY72CjReT4inXiKAnaifHpNwVRpDadrb/3WP8isk2pqlz0MpbNpY3dbXZ8qT1kpf52E/8JtqtQxMeBUiVAn74Nm+EGNg1eGUMRddoIJxIhZENcFKVJA9f0CITjr3H0SpuFGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707213014; c=relaxed/simple;
	bh=Ke96dUE8LQll82BVeDMdtZlrvggEb9R4zMy4siiyApE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KUQ622PTN/Ql53lJtsAhJuwEg5yh2PepF/fdCgX2sVaR1ujEK2WVDZ19rnKjR2qXFGR0lQKJGrWRtkXfIPdSz9/fR5xdh0qEPXnPeKYVr39O+gMe8Gob2uSP0AhADXV2iTB8tnYaPl9So8I2HhoK9SfO3aSa3XHMKpI/tbvrt5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iLRhNuP2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dP/OIZXO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4161Ewlu023386;
	Tue, 6 Feb 2024 09:49:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=bjq2Xd34Ki4mEMjMrmCUIHa4ZSax8mjJ94X3nPZqJkE=;
 b=iLRhNuP2v8v1POmzf5yVpNuveGvwzdKNIY51yDT/IYHBY3LK8z8MU882XkoSIDCsmP1P
 wkG2E2tn+/HZsnRaZDCrIAIkzQoiTDdYycXrhL5tOphALef2Wh67i2anN3wnpYVtAP05
 kWpiZQSfTXhidKDp9v/7oHT+ekTsjlXD6l4024wX0lkELafakEX02apQvy+eF5EYrNeG
 nOJq6WekbwMSfCGSWV0FbC17qQuLIqj3ecuWZ8ZQO8RwjPvyja6NwEyKPi43o9voJkoX
 F/ypF9bqs/YeHrqfZPxzMrHzFtSK6adRcSLs6kWCPgxt1Bb/1eTgtURKnMthNUi7aImb eQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1dhdef54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 09:49:53 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 416932ej036711;
	Tue, 6 Feb 2024 09:49:52 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx72ned-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 09:49:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nl67BZHzfhgGg3tCL+iq7diRNtkvCD+cpYkA5IBbxQfDG2lYxpYvnhgxLLrAgUowg2iCCxaFx7tsQ4ugz6w+1VIbqoIymwu43FmjCQOCtqNNpHT5CVTHBQEEO7wS4Q3khPL14buA4xAD003WBE62JDLRAxnNZ0S11jC2CzYbXtio578T/2gc3lCxLZQs5iMw5/cMUU0Ct47V5CNlhdIIhlIK/UiGiGq7L/J9txpSYQ+dEIGmEuXCZ3s8R1nd90ZSG6nNuFZjE/BOxP1+oCGVAAIm0LAr8KIs0yWwnt1IpDTFIXr6khV1BRBg80H9rHINvFIRyTfK6posiBoi5aUs9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjq2Xd34Ki4mEMjMrmCUIHa4ZSax8mjJ94X3nPZqJkE=;
 b=IBsD5vmiSYS2JVlfi6akeTJUTpFXbg89CG9OVJSHAGRqG9StXz2rXU6fd/RvdBslEgdFF3oUEo8+7LgeZdFLjp/qiMPRj8fape0tk4qOO9KMFR6JVCCLKw3v1iozbopgtdACpxOETxvF30J+BRSPjc1JvxjbUqsFHnLZCAarvHvoip9ywLkl4jnvvkU/EF87+5RLHoo/LNCx+MaELieeEqWPQ2sDjgmajT76zenEXJrKebdPvyqxXkT3PU6gNZ9ZP3kmqzKxC/KQil0zuLr17/bXVdmM0R883qmwGfzLFNHQdh3zhSNKDbDsSld1APTXffA55vkdZJCCUoT4HCousQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjq2Xd34Ki4mEMjMrmCUIHa4ZSax8mjJ94X3nPZqJkE=;
 b=dP/OIZXOrZwvd5MfHhfdpjOw2fOAoW8qw+NoiivvxUN3okfsVPym2uJko14yrUJsAF2mIw4t9S9HiumsPH/EL3uU6L7UebaDVb3xNrF+ni29+mrPVZFBq4ABF3dTCaG1IKYnsvSUOaANIU2QB38o0IZKHOKobTv/am1k0z/Cfgk=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MW5PR10MB5714.namprd10.prod.outlook.com (2603:10b6:303:19b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 09:49:50 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70%7]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 09:49:50 +0000
Message-ID: <bd4d548a-0f41-4086-bb34-ac2a7384157a@oracle.com>
Date: Tue, 6 Feb 2024 09:49:45 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 0/2] libbpf Userspace Runtime-Defined Tracing
 (URDT)
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org
References: <20240131162003.962665-1-alan.maguire@oracle.com>
 <CAEf4BzbeBiNj2GHJkDBAWASwLMy6nDNMbmqtQGOABZsRGAEytQ@mail.gmail.com>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzbeBiNj2GHJkDBAWASwLMy6nDNMbmqtQGOABZsRGAEytQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0112.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::9) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MW5PR10MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cde0c34-2840-4fbc-6983-08dc26f8f5f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qcHkz+tRFh2bxN7IEkymCuRheWmYP1MmX0QzjXvGz+UlzZRw3q/3mpc79gOaDZxmUJdZL1a0hB3mbCduzNMNWP6Zpkt0ivPQyOTIcC1Mm/jJGUGq4VhCCNs5fjpoiHMi/z2r8UQDgPFbNeO0pfAmD8c5zdpl9heBp82e+OUN0i+KMKTT3grjvt0eeEZFi6DP9X+7+uc7D9Hrw366VkeycKa1Wake+i5WVtTvlwcqSjWnHdsqZYDiZqLQKYu/WVfGWNSHeG+L8s9hvyiBqA5/A7hEkdDQ4HiJdcY6+SONqh6LGmWGjx52Mn/V2nFmoS4KeU2z6tCDPeCIgN2U46PkUt9NIPnh+E3jX/f4S0kMAhwGITI0sksAKNrU7yAje7rC49LsH3LQieP9lHWDNndQJFcZOTPBKZWo8SfTS5x8KpDIasJ0yFxnxGjEkGjaosmhciWbdHoKMbMU3quUMfGYZyHQWVhnPI3CpKi480txSQ7p81c4V0kWmi2DY9yTXKm4J3jPPUIuqp1WkkuJ16tRFTj8009sBUntraDzxJdDeeoKERtgplwy75oHOoVH0mrXpwTMAu+BjOPTzLpQPZ9oDMNSIt2L9T9Ei9XhvK8QuU+dDXcqhbtmwQRKEeWuX5/b8lsSJuMK1dImR4Tnk0iUiw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(346002)(39860400002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(2616005)(31696002)(86362001)(41300700001)(7416002)(6486002)(5660300002)(478600001)(2906002)(66476007)(66946007)(6916009)(66556008)(44832011)(316002)(36756003)(8936002)(8676002)(4326008)(6512007)(6506007)(53546011)(6666004)(38100700002)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cmpzSUlLc3FqZXZJMmU0UURKK2FTQTdpZlBrakJjZ3ZMQVZEbDBGc2NvT08v?=
 =?utf-8?B?dnRZWDU1cWVQc2VlZ0JCVkRCRjIzS0Vud0JvcTlPWUtNUmNuVHg4WmkwSHQ0?=
 =?utf-8?B?VlJueGdZRW1ITE1pdW95UlU5aEdxR0VFT0JDQm5yc0pQWERFUlJ0clVvQ25x?=
 =?utf-8?B?NTg1dXVMYXRqSm0wTzIwdzJvWEdibmMzWkQvNjErRUd4VDk5NUFrY2RmdUJi?=
 =?utf-8?B?ZmlJNjRPQm0vV29DMTgxcy9rNzA3dmlXK04reFB1N05mTXJsZVpqQ1VSbmgy?=
 =?utf-8?B?Q1E3VWRqcXVxeDVSZFp0Z2JWYnc2TVI2TVhLT2QwcXlCbXdtLy9jU3FqcVdW?=
 =?utf-8?B?dlZTSmZ6SURPVVFPM2hjWEFRaCs0VHBJNXVWMEJTR1JPV25qS3h3bUlwckZE?=
 =?utf-8?B?eVdwb205ODFzOUg5czVzQld0OTJYQWNZVzd1cE43bGJhVUhjcWpIMDJZWThy?=
 =?utf-8?B?c2llSDE4Q1dMb2hNOE5tek9QaXBEUXVZQnlFV3hNTUd1QW5pcCs0anYya3RT?=
 =?utf-8?B?SmlUT2luKzAyOUlKQVJZY3BneW9GM01EUVFXaU5EQVBmOGVQU0h0YmlrR3l0?=
 =?utf-8?B?UEc0bkYwSDBxVDhOZTFuaHZlUVQwU3J1ZDZ3Z2laR3dWOHBMWUI5UkxCUkl2?=
 =?utf-8?B?Q1d6T0dTVW92V0creUg1YzNib0t5VkQvR3E2amZjNE82STd2TW5lMkxtd3lr?=
 =?utf-8?B?QkNpaEU1UlBNaFZpdGxOazRvZHN3d1ZPSk9CU2hQYkh3SmdCb2xobGZxWWQ2?=
 =?utf-8?B?elUwZi83eHpXVG1Fd1JScXZweXBCWEVZZGZPNERJemZ5Sy9IZHBYcFQ2ZlNY?=
 =?utf-8?B?ck5sWGVzZk5zMHBzZ1Bualk0SVlRUDM1REdWMDN5TFRkRlpqWFJBR1daSldO?=
 =?utf-8?B?ZjJ2bmEvNmdsVFpLMUpVVDZUYXY2NUFzSHZFMnZHWHBHMHNzN2tvUFhGaVdp?=
 =?utf-8?B?dUt5NnVwaVJNdXBnRjFCbDFOd3pOYjhrUDJDV2RRcVJwTTdlYmg2dVJFZ2tu?=
 =?utf-8?B?RU4wNWFKQndrMjZMMG5hcnZKSEt4WkM2TjduTWorSkNLZWl4dXhoZE1FYUpk?=
 =?utf-8?B?SEhZeXUvR0ozMEFYQjNXdTNUWE4rMzZ2aGFwNjN2TDhhWUlISkx1dkdFK3g4?=
 =?utf-8?B?VElkTzlJKzB2RllmM3dESTBKaEtCd0RGa1k1cHlhQklORzNRanFKYlRLWTNj?=
 =?utf-8?B?VXFzQm41RGNVM01hRkN6ajNFVG94Q29FYjN1RTA5OGFWYVh2eWREUDFSZUJW?=
 =?utf-8?B?QWx4Y3NSRHozRzhjRS9CcDMrSXNyZWdtTVllYkZ1N3hJbzFUN0w2eFZWQzdp?=
 =?utf-8?B?cHVpVHc3bFZBL0N3WTJtc29wckN3MnNDU2xxQVhKUmhva1M4Y1BuTVg5YVNo?=
 =?utf-8?B?bHUraHNSN3p1ZkQ5WXpEVVpQS3RmN2plV3FvbUlYVVBuZ29CVittT210d3FV?=
 =?utf-8?B?S1IxZzFXanRVWXVVODBQeXNZbjlrZWJYNTFkRkpCeHNpT2VmejZzY3RNb2x2?=
 =?utf-8?B?ZituYVhORkt2MlBVRGNxb040bHRtc3UvditIei8zWXBmMnRnN3VaakNtc0cy?=
 =?utf-8?B?U2NaK3ZnZDFobWYzblRZUGZSVXcrRGNMVVpDS1AyWFFpV3BxbXZ2NmZ0czBi?=
 =?utf-8?B?NnhJMndrVHZDd1Z1SjY2bmRwSzlsOE9QQ1NpeStCZVRKampHUzJrNHd5UGF0?=
 =?utf-8?B?RFZYNzdhWlVtclQ1TEJ4b0wwZStqV2RVV2RkYmlZYmNSOUJySnM5Z0JGbVBV?=
 =?utf-8?B?dFMxWFA3NTI5czNYcjNIUXRzV1hmR25FYU5pV01OVUM3WFJRWFZyVTlPT0xn?=
 =?utf-8?B?TUpIeGU4SnY2R0pPWTg0VGxmMTVyUHUzaVUzSjhTMlBOWmdRcmd6NzNvTkZX?=
 =?utf-8?B?aE51bGkyUTBLQVhlUXEybHAxbUhGYzR6a2pzL0N5d2VUOGt5dW50cC8zS1o5?=
 =?utf-8?B?VENVZ0lHQUUyem55eWRFTzhwb3JzUmViWFhtenBLa0czNUtJc0RkWkdNSWNP?=
 =?utf-8?B?eTIvUGh5S3NUVTJIaVM3eURleWw3R0ZOeS84UEppSkJtOHVGVGpob0FmQS82?=
 =?utf-8?B?N0VsOHdaalNGeEYrL24vZmFSY251cWlHaVlXM3EwK2JEbHFGZFVUMGhkTTll?=
 =?utf-8?B?VXNiRUpKSEhFemw2SCtaTFE0TnBBQnhWTFRSdUpZYmh0VmVPOHhGZys3emZO?=
 =?utf-8?Q?T5en3HnRCJD3GCAr2Q1duTQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	x9wp43wZXgpyMpe0s6hWcSCKTocXiIIdJcgPXu81ICLqL56jqvLDClXOm26gTwmlCTCWlTi2IbyH3eaPkbQhiqgJPLUyO21jztOS3eJETwtCaiDITnQ5UW6KytWcP8haV33xwOodtljRJOhwlzpEQFfBnLamxPJ2avEmw1lCvsa0z2WRdZZfSve4idAZBv4F8VB5hkVinjiDYt0QqAbvS/Qc8UXYQ0UVCZxqDYfGGEcdvz3aIN4C1kZOsWvJZFwMOtBfznEIAcLONM+6INH5gVhvhiKCbDo3FyTxJWeMLnzyz1cYQ/rU5bZQf9XeYjzDW8wyFx07d2wEy6Wy1e99Olxfq0Wb+0vkf67LtmGXH1Ioey1OvKJgkPBU1scXbd3HI6xDLHaPmKspOqVyFdxOLwwkMEaeHu+Tgdk2ni6HT6/b6jTiGjv7xORXI8ra5/JbAfLQMkzpuYc3SwznSf7V2cvvt1fWP51s5p5mOyWyZuEh8GvIc0FQb7Xz0DbXGfVQeJ4yJwzcE79p3NDNJ9GuATRRCkM24ysv7gEK3EM3sWsuyJ9aOIOeey2GvVpWz1OFcVA27gkAGcVDdwP02jhHoTvBpGnWabzZgD0IsprPBJc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cde0c34-2840-4fbc-6983-08dc26f8f5f3
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 09:49:50.1344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mvDedVtIhibJjMzqPRfRDDDIYCVZutG6g1EpEZzZfC4HJvnxwEGQu0DOvrPPeDFR5itOFt4VopVabfzUI8DUvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5714
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_02,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402060069
X-Proofpoint-GUID: AYelePpwt5G25BLXFxqa7s6iC-54P9Ot
X-Proofpoint-ORIG-GUID: AYelePpwt5G25BLXFxqa7s6iC-54P9Ot

On 02/02/2024 21:39, Andrii Nakryiko wrote:
> On Wed, Jan 31, 2024 at 8:20 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
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
>>         bpf_urdt__probe3("myprovider", "myprobe", 1, 2, 3);
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
> 
> I'm sorry Alan, but I don't see this being added to libbpf. This is
> nothing else than USDT with a bunch of extra conventions bolted on.
> And those conventions might not work for many environments. It is
> completely arbitrary that libbpf is a) assumed to be a dynamic library
> and b) provides USDT hooks that will be triggered. Just because it
> will be libbpf that will be used to trace those USDT hooks doesn't
> mean that libbpf has to define those hooks.

Right - that came up with the discussion with Daniel also. Adding
probes in libbpf was just a means of providing a method of last resort
for runtime probe firing, it's not strictly necessary.

> Just because libbpf can
> trace USDTs it doesn't mean that libbpf should provide those
> STAP_PROBEx() macros to define and trigger USDTs within some
> application. Applications that define USDTs and applications that
> attach to those USDTs are completely separate and independent. Same
> here, there might be an overlap in some cases, but conceptually it's
> two separate sides of the solution.
> 

I think the point is though that USDT got its start by establishing a
shared set of conventions between the to-be-traced side and the tracer,
and built upon existing uprobe support to make that work. Is there a
similar approach that we could apply for dynamic probes? libbpf isn't
necessarily the right vehicle for establishing those conventions and I'm
far from wedded to the specifics of this approach, but I do think it's a
question we should explore a bit.

> Overall, this is definitely a useful overall approach, to have a
> single system-wide .so library that can be attached to trace some
> USDTs, and we've explored this approach internally at Meta as well.
> But I don't believe it should be part of libbpf. From libbpf's
> standpoint it's just a standard USDT probe to attach to.
> 
>

For now we can pursue the approach of adding a static probe - triggered
when a dynamic probe firing is requested - to libstapsdt, and this would
give us libbpf support via USDT tracing of libstapsdt.

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
>>
>> Alan Maguire (2):
>>   libbpf: add support for Userspace Runtime Dynamic Tracing (URDT)
>>   selftests/bpf: add tests for Userspace Runtime Defined Tracepoints
>>     (URDT)
>>
>>  tools/lib/bpf/Build                           |   2 +-
>>  tools/lib/bpf/Makefile                        |   2 +-
>>  tools/lib/bpf/libbpf.c                        |  94 ++++++++++
>>  tools/lib/bpf/libbpf.h                        |  94 ++++++++++
>>  tools/lib/bpf/libbpf.map                      |  13 ++
>>  tools/lib/bpf/libbpf_internal.h               |   2 +
>>  tools/lib/bpf/urdt.bpf.h                      | 103 +++++++++++
>>  tools/lib/bpf/urdt.c                          | 145 +++++++++++++++
>>  tools/testing/selftests/bpf/Makefile          |   2 +-
>>  tools/testing/selftests/bpf/prog_tests/urdt.c | 173 ++++++++++++++++++
>>  tools/testing/selftests/bpf/progs/test_urdt.c | 100 ++++++++++
>>  .../selftests/bpf/progs/test_urdt_shared.c    |  59 ++++++
>>  12 files changed, 786 insertions(+), 3 deletions(-)
>>  create mode 100644 tools/lib/bpf/urdt.bpf.h
>>  create mode 100644 tools/lib/bpf/urdt.c
>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/urdt.c
>>  create mode 100644 tools/testing/selftests/bpf/progs/test_urdt.c
>>  create mode 100644 tools/testing/selftests/bpf/progs/test_urdt_shared.c
>>
>> --
>> 2.39.3
>>
> 

