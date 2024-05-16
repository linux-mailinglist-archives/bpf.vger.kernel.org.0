Return-Path: <bpf+bounces-29863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE628C7ABD
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 18:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5DEF2843C8
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 16:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025452E642;
	Thu, 16 May 2024 16:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ETTK65wf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zCAbq7q2"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF644A3D
	for <bpf@vger.kernel.org>; Thu, 16 May 2024 16:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715878534; cv=fail; b=Y7RPlRV5Q0IrhUbh+s2EHrXlULiCqkii5/tMxf601i1VfnxsMObQcXW2A5Zr2bDHwu2M6MmUah4oIY57Ei9MCDGUYRSD0fMaXfsdlJPcpRpXP8vr8KyPBvBjbpaKA2Bh6hIYd/CJFsaYcyp5ByHFhmywLoioYBW6+9mNazwcLj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715878534; c=relaxed/simple;
	bh=34kgyDtdFR3JiS/MFxXvSD1vKg9hnHJPhwL0n0l97rg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OogPm+MkGBnZX1fuXFguPYI7bpUJHaVJ/5VdKinDAX3LYNVmpqSU1hoEULcR1bN2QjkQI21bH4KDG685S28U5i1qE+gTPKEnkpkSDL1iM7z5D9hEep0mcw9JSyF4QzNOky8/JrfpfLN8v2tyzelUV+gAAwUyakQ+HJkTYnvt+8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ETTK65wf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zCAbq7q2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44GGYFrK017485;
	Thu, 16 May 2024 16:55:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=gGqXNbB8LVgCCDAmDJz875YZDn+v4WIVmkz3ZhgQVQk=;
 b=ETTK65wfJ04PYsau3iNC2HTag55Qwa3Anli2iZvIc7ce06IBBoGSB+pdBIsSXwZEXQAC
 PM8QczjcNcmkYKOIcY2Ufhzb6Kco590ke/65o0BQqiYKcVKvQKGlC62E3s/TDBCiXrAs
 FubNfP5ccp4hvPhAUh0yYz4zCEeTu3QGa4QINtGWwd4GTbByXtvSQaxCmo9VNiHzoZXd
 QHB2qCK21oaP6RKu+nxY55KM6NW65Ol7wBBQo1ztu2yjM1teR16VlW9i162TUzp6oTZn
 E88SsxrLMXyWvAyz1VXroWsc9j+Bt5i1IViABD+wFNxx/iy3x3QYWs6XFv9goQ8k6TAR Vw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3t4rx3bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 May 2024 16:55:03 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44GFo7AI019282;
	Thu, 16 May 2024 16:55:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y3r881mje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 May 2024 16:55:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0azTOo5oVA079PVvPuKHGT2VUgYD0fEM811KUm/5t1NjuNOMKt9h3D8BAks4ZHG5kTgQCV4zHpbyOiR/bnb3gk8AZB7NRkyeoMsHQUV0PjxXPXbxynSB185olISFXMyY+yMNmJZJrU30Mp7z6dsGrClF8Ld73Wq/Sw54/fwXsU1Lt2l5uH0M3Q8ydmXsAox1au979+SVm12hP7LA55o4bHCwalKhseivyGZIKqPNymBsTqwnjgnNrDl2F02YZZZtVUfSosMtM44HbkWNEdqYIn8KX4DCg3TdVRneKhIvLKS2LNgRvZ5OabgjU3CJjuLQPGZpwdfdllo2jKKIU+jTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGqXNbB8LVgCCDAmDJz875YZDn+v4WIVmkz3ZhgQVQk=;
 b=Z+2xHzJd2j3b35+yp8m8tcstNJOhO2pi8dpjsEYosVaQykEYSTA8SnSG3eje4Ew0ZRLlqdvSjskLsRHjvpyiiwD26lntZM/oLF7CQu5DDFYmsppqViPg35OpP7IZH+dv6JiGrJ5ZSxB3izhMtkwdrzDkk+f4T/AYJKo4PbYQHkK4Yhr4dxSBmkmA+opA9JXpuZnuHbDVcLzbBjC/vBbOIBE4PMYrivjG53OTsARbZ7TlbQjrCaIkyzwxokb84G9nzkJf/AQGcREysinMMtYQ39J5VUga6FgYqFBK+SvI8cjVp3wEMIwKRwz56A1BLpEN8w3733tYeY+A0a//D+kYsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGqXNbB8LVgCCDAmDJz875YZDn+v4WIVmkz3ZhgQVQk=;
 b=zCAbq7q21L9vtByhIPsx8dFOoXteCVcVmRhbPtCKYoZ3UyFJcTaVVOBAaMO4y2L9S8Tw40POLTb01N5IjkOJ4t5EMsDZxU0YJPRUCD/NumTw1Zps/LVwnvBavEpR2UXlC4ODXa4DS66X55Hd0JpeHYSa38rXVHntcILxdZh5Uw8=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SA2PR10MB4682.namprd10.prod.outlook.com (2603:10b6:806:110::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.29; Thu, 16 May
 2024 16:55:00 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 16:55:00 +0000
Message-ID: <ff24d1c4-5255-4396-ad19-9da99864946d@oracle.com>
Date: Thu, 16 May 2024 17:54:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] selftests/bpf: Adjust btf_dump test to reflect recent
 change in file_operations
To: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
References: <20240516164310.2481460-1-martin.lau@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240516164310.2481460-1-martin.lau@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0147.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::14) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SA2PR10MB4682:EE_
X-MS-Office365-Filtering-Correlation-Id: f371718a-af5b-460e-acd8-08dc75c8ec6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZjNBbFR1WnlRZEtuSGl2QzdYdTZCNkJFaTFSYnJodVdlNTdETzVlNSs0Qnhl?=
 =?utf-8?B?WGM5TUJXNXkvMThVRmI3YzVhWmtEQ1hOYkhPYVBRSnpxUXZtSmpkQTNyZlBp?=
 =?utf-8?B?QnFGMFQ1SnpuMUdWeUpiMU9PUmVtYXFITlR4U1ZhZ05ndUpCaE1mOWpCaktD?=
 =?utf-8?B?emcrSU5oOHdhd2V4bHI5Y3hjd0c0bHhoT1AvemVYZkxSM21sWkxCNGpDUTRD?=
 =?utf-8?B?NVUrMXYyVXFJd1NYQWthckV0dnVZM2VxditQKzJJL0lnbkYzT0JEaHJLNnNL?=
 =?utf-8?B?OWFWcnR6VzJtTjZONDZsY3EvcE9zVXJNcE5XT2dYUXhaZHBBMFd3KzludmNX?=
 =?utf-8?B?eloxcTAzM3RiSUVUbEoxcHpqcFFydXV0N3U4NnRVMFBTL0hYOXdXNm1GVGsy?=
 =?utf-8?B?UDcwcUczY0IvRUtRTkdCVXQvQU5qNXRLNmNoK2ZrS3hISHVsYVA4eEtyT3Y5?=
 =?utf-8?B?a2h4a0lLMXg1NW1zb0lQaEdnWkJBZFFwcFBmdFJzRG1LYTY1VTJEVlYrUzNt?=
 =?utf-8?B?eHhlUzcyRW4xVmxUcmZBMDJpVjYrenhMalJETnBtOGRWd0xTcWI1dkRGRTRD?=
 =?utf-8?B?TERwY2luNHJUUW5yZGFUWXJkOHJUbkUwc0tsSjFKZnN2anU0ZDJSdVJzRjhJ?=
 =?utf-8?B?NFhQMk12amFZazBDbytVNXQ4L2kwSlo2NjVMb3NwSnQ5MGdVSEkxTk1RN2N2?=
 =?utf-8?B?azhZUEt1SUFMa3NPYUNEaDBzSlZhOFltdXA2cUFvRkcrMW01bDVmLzJaQWNB?=
 =?utf-8?B?c1JZQkhqZUQyV1ZFL2l1dUVzQ3FicmhFaGN2ajlleXMwZUpCeGJkcXNxMnhl?=
 =?utf-8?B?TzFTdXB3Tjg2ZFRrTkhRMXVvWlJOM1Z6MWI2TlFtZXE4YnVlYUJMYkxFSnQy?=
 =?utf-8?B?K0FlVWcvOTZtS2RTUlRJRk1tMFFaTXdPeVl0Zkp2UXJSbFZWbTI2Sm9iVHFp?=
 =?utf-8?B?R3piVVNGQXZmOW90cE1MSXcyRExWOUZhVUJYZDZhclRRL1ZZcUxQTWpxbm5J?=
 =?utf-8?B?QWNQdG8rWVYwK3IrSkV3ZnpjUG54UkRVR3EvY1E1SWZtMGdmbzJ6QWxxSnQ0?=
 =?utf-8?B?L2QwdlYrZlc5RURtbzFONERtQmFWN0dpNlpXY2s0cFU2K01zMmIxUDZ2bjlu?=
 =?utf-8?B?b3lKczdRWVhXZ25BZ3V2Q1ZSSThvL3FjMkZWSEhjbklGeXVvNG5mRTd0Zmx2?=
 =?utf-8?B?NEdXUUVSaXBieEVNRzNxZ2JJblQzTTFBbzdSMzhyd0w4YkpVanp2Mnd3N2t4?=
 =?utf-8?B?QXBkUnoyMThlaThvL0U1cVZsWmorbDNRb2VRa0xpL3hOdlFDRU5RNTVDOW5q?=
 =?utf-8?B?NVl2T2RYZUMrNElzRmN0NHk3ZW1QVE1LV1hWWnVlS3dqbFlJNVlFdFRrZTdt?=
 =?utf-8?B?bDRLQmE1cG9zUGhwQWw4Z21PdDFjTHdRYTdNUkQ1QWpaV0dqeit5UG05VTlQ?=
 =?utf-8?B?UWxaeEllemRmQjBxdUdHYUtyallHYjQvQTQ4U2MwTGZsVFF2THdFVnA5S0xi?=
 =?utf-8?B?Rmo1aTV0aXhMVmo2SEVKb3lxMjA1ckNRMlprT2R1ZGlqNWdWaXh0d3FsU2ls?=
 =?utf-8?B?ZWdUOS9PRHB3NnVUZm9jRFVycFBwcTRtRkZvN2d0NXRhUlFZZGd2K0NMSTVN?=
 =?utf-8?B?MU9zSjRwRDJ0dXdtekRkQmswb3Bubkw3bDN2QWVRM3h5WCt3UWFzdVV5ZU42?=
 =?utf-8?B?OGZDMnhRNEYyK2EyZVRZVEZCSUUrbEhkb3hwQXh4T2dLQU56VEROVHFRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K0tqRzgxRy9EdC9KNGxkNFc5Rk95RHRSbFl5SFJJc0N6bVRCSjR5WUJLQ1Vp?=
 =?utf-8?B?QmhsZ21JU1p5RGRmc3ViNTgrREVySzNIZU1pWVNoNTg5ckV0ZlNNejNXdVpu?=
 =?utf-8?B?MWlJR3VPay9mMU51U3IyYjkrUFNDMER4bzVRWElKRmJ5M2pGanFVaDdUWXVW?=
 =?utf-8?B?VU5Pa0N5MURmSlBnZzMvbitLdnRNdWJoU0I1NmhjQXdPN0NwTTdTRVVQYjVN?=
 =?utf-8?B?SUZGdUxEd2hRMHQyVDFsSCt6Yy8xa3I3SWdxZGo2UjZaeW1yTGk0aFk3TGFX?=
 =?utf-8?B?NWc2SFhEeG9PTDBZZ1k5VGlaNDlveXBycGtBdkFPaFVoRWlDUUZnZFhhSjFl?=
 =?utf-8?B?cENtUExQNkRaSU04bjYwbjE1U1llUTJ1V2ZDMWVLS0l6TlFod1VlQWdsMlJF?=
 =?utf-8?B?K1JQK3hkLzE2TEN6dTVtTHhyNzN0OURXbHM5a0NHOVhiQ2RBYlJoN3ovUlp5?=
 =?utf-8?B?NnJRWXh1OWFDMFd5cDNURDZ1Z3lObWl2Y0o3VC9Vbko5WlI1aUtHTFF5NGgv?=
 =?utf-8?B?QUpnZ0dmdGJoZkpkY01uY0dwRk55UGRiQ291Yzl6Ukt5SzB4OGR0SjNrbTk4?=
 =?utf-8?B?WGYvVm1IWHZMa3FBZ29qS3FUeDMvaGRock9lM1JqNWdJV281c1JuWlBhUElC?=
 =?utf-8?B?SHRmd29qdXVqOHYwS3BOTlFvajhIeW1pM1BIb1hzWGIrYTgyZ3BSTzU1bDNj?=
 =?utf-8?B?bHRETGhSc01sWk00UTFvQWE0NE5mNm50Vk4yY3lsK0huL2wxK2hoc1BKcnpl?=
 =?utf-8?B?eW9QUEdQSDRvRjBpcnNpK1lnUjZLLzllc215L0NQU1dzRS9LaHlQR0hKZTVa?=
 =?utf-8?B?U0gydWhUMEFPMDF4d2pjTk9aZmFVSUEwQ004bklTVUs4K3RMcEJlSlU1YzNV?=
 =?utf-8?B?NkpLcUlhS2tYeDV6bGp4bE5BYzFOZmFKUFR2b2w3Smk5cVlJZGVhVUFqRkJm?=
 =?utf-8?B?RXVySjdnam5tTm1CZnl1UDFWSktXSm9IZ09mQnJKaTNSeTc4OTdSZ240WU1Q?=
 =?utf-8?B?aW8zdjY1a3pQZDk4RytSRWlLTXRmOVdod0pJUFg3L3UweWFaZWUwNHoyV04w?=
 =?utf-8?B?ZXErcFYxUHFRSUZvV0duR0g3L200WHRhV3hSbUhEUDB4UkV5NElod3gySkxL?=
 =?utf-8?B?ckRJUEpZejRaenlJRFdpd2g0cVVYa2Qxa2lUQkxUakRtdUc3ZjRGQ2VmdDdQ?=
 =?utf-8?B?UlFNSVRvbUtESkFhVEdhNFUwQVdZRk1ta2wrenY0SUZxOGs0SXVoYjBwZXJk?=
 =?utf-8?B?UHVGVFpTU2w1dC9RWDdpUmxVUVN5VTY0OTZJOVptcDZBZ0V1NElObE8rS3Uw?=
 =?utf-8?B?REJmZ3g3Y1F0NUoxRSs0dUFmd0gremV6OXFRR1VQSlBPVHZ4L0xHK0tuazV3?=
 =?utf-8?B?VnZxSzhjZXVwYUwrU3RHNGJNWUdEcG1SL0JpQ2FoVDlCb2piTjJZQTYvdS9E?=
 =?utf-8?B?SDZnOWJjMWMvWi9TdjhEM0JYWkRndWlKSGpTb0hXZ3dFY25DRHBXNmxnV05D?=
 =?utf-8?B?SGVVbnpRL2RtQ3VOc3BicGRWZmVxWm5NVm1Eay9Od1ZEZ1YyTENHdHB3SE5Q?=
 =?utf-8?B?ejFGUkVRMURCRTYvSjBpVTFVNlByTlliUURIQjNSM1VOdGIxbDR2cTVhUk8y?=
 =?utf-8?B?ME82T2dLRE0ybVIwaGRPenBmeGdmLzkwVEYzU2JQblJwQnAzdVRKUFpsOCs0?=
 =?utf-8?B?c3gzVmluczhkeWpOSVFmLzQrSTBCYUhOcWhXQlpHSS9vOWdNdWtzZlN6RWli?=
 =?utf-8?B?NmFSOUV3c3IyQnNPeXgzT1FKeFEzd0xCVDZMT3ZwcktYeG5Gbk5PaWxnME14?=
 =?utf-8?B?SUxRL1FBaEpLMS84NlZWT2c5M1JsbWZZUG5IcitiU2RpQTB5SlFOZ3ZwSlpx?=
 =?utf-8?B?alZLMEE1NnUzZ1FzL1ViZnZRMVNLVElEVUc1QVRrd0RVVE1mcittWGdEK0di?=
 =?utf-8?B?ejROa0MwSlBUOWNpaXRUd1d5aC9zOFRpeWdLOWpwL2h4QWJlTi9wSkhwNVgw?=
 =?utf-8?B?TGQ2eEFYaUdyQWdFajJpL0xydGxGNllzVC83Wi9XWEFjdlVWQmh4M2x2dVAz?=
 =?utf-8?B?U2E2bzd4aVBxWFNwYTJ6dzFudjIrSGxUeHNRK2h6YkVBa01xZ2Q5Z1pQcWho?=
 =?utf-8?B?WEtxQVhvRmNvSlRwY1dRd3RMVkE5NUY1SlZuVlRpRm90V2xsa3BQVURyRGdT?=
 =?utf-8?Q?9+LiBxPg/K7WZPfOt+WuiAs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	snVi3mBRj0ARiR1L2Vbh2sO1NiPmLK4+PnGuq0A3KwY8QFDKxpesR5REdIcOZf9SPFW/c1e5JDiTU1ydYudU4FW9WKrHoKUQP1lM9k7Eem/yFa/Eg/B+GOZSHYdhGD5BNzOwTPIUbZV45REzNfV0mBv0At+2sBvi5s3RO0IkLYWFTz9Et6zrgYiWFPOJjv7rOoMSjCfScSMGg9bIsdpLQgxdehVQXxcjcMOKsHzgeibuUAZ8BVnfFcPsGHN+GmCnZO8W+rd4nDQC0HruXN0pHHM95rpsIZ2nvJF+9MOBnaIr2c5Skd375OqrEw3B/61li1D+xuR204LIdgpK8/joLO2NNV0whLxFc5UV40FTZPQBK3krqDv03CBIPrvKpqj9cP5FeBwSB6W5p4XB602r2Bt/5Gfv6JjTEuyxIGfgRBpKCIAL8aOsM8RiCQM976QFw6BNGDxZfr3uJKg6718U/fUmRH0BWM9MWQNsvAPE4lMYDLR5KsoBl8GVvtCIFn8LH+kIZqjKx6VK6zbqB3YFURxZrXo4tQD3TbFQQfkP2l13FhWb6+QpGXiVBTz9NZ297C1qbo90MFMAkK/51WpF84to4aJdQ68k87GbGe5zBcc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f371718a-af5b-460e-acd8-08dc75c8ec6a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 16:55:00.2349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g4BBi5EabBf0gfpq9kEeMKLm2HdTivfKtL8xP2idnO3hbq+Kj2EheyyLRzZb7QPQ9uCLhR6QsqnyTvpcDsp+pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4682
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405160121
X-Proofpoint-GUID: ThAydskgU_pkFa33vDI5T_BSIFKp8cyK
X-Proofpoint-ORIG-GUID: ThAydskgU_pkFa33vDI5T_BSIFKp8cyK

On 16/05/2024 17:43, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> The btf_dump test fails:
> 
> test_btf_dump_struct_data:FAIL:file_operations unexpected file_operations: actual '(struct file_operations){
> 	.owner = (struct module *)0xffffffffffffffff,
> 	.fop_flags = (fop_flags_t)4294967295,
> 	.llseek = (loff_t (*)(struct f' != expected '(struct file_operations){
> 	.owner = (struct module *)0xffffffffffffffff,
> 	.llseek = (loff_t (*)(struct file *, loff_t, int))0xffffffffffffffff,'
> 
> The "fop_flags" is a recent addition to the struct file_operations in
> commit 210a03c9d51a ("fs: claw back a few FMODE_* bits")
> 
> This patch changes the test_btf_dump_struct_data() to reflect
> this change.
> 
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

Thanks for updating this!

> ---
>  tools/testing/selftests/bpf/prog_tests/btf_dump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> index e9ea38aa8248..09a8e6f9b379 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> @@ -653,7 +653,7 @@ static void test_btf_dump_struct_data(struct btf *btf, struct btf_dump *d,
>  		cmpstr =
>  "(struct file_operations){\n"
>  "	.owner = (struct module *)0xffffffffffffffff,\n"
> -"	.llseek = (loff_t (*)(struct file *, loff_t, int))0xffffffffffffffff,";
> +"	.fop_flags = (fop_flags_t)4294967295,";
>  
>  		ASSERT_STRNEQ(str, cmpstr, strlen(cmpstr), "file_operations");
>  	}

