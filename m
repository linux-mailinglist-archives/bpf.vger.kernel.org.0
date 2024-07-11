Return-Path: <bpf+bounces-34589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCD392EED9
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 20:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C585281683
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 18:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B5816DEB5;
	Thu, 11 Jul 2024 18:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EGIl0ZaG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QXmfwrbN"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31333200A9;
	Thu, 11 Jul 2024 18:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720722399; cv=fail; b=ACMf7cm7d0Qs4RQeOWedijyL/Dvise/1IguUGk7RWw+YZrLkxGbBS+hPxInW73sb8pUdNcodJhzc+OeLO/kEMjwGa1r3uopO1lq4t/zqKWBNkyiJfGfrBk6VBmG6K/Y84wcnxbJ6QpoX0Ugj0vGgVEae5l9HfJDKoOu6qYjObyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720722399; c=relaxed/simple;
	bh=Y/1998WaCGTdI6CsowrzODUwJQwl3Lf3iX1JUqrL1vo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gf/Ojs5jB2lkgNrg+ComvXGExEVhmq4MoF6dtHW29wXFyPg4q0ikxGKnX6GDoiOou/21svUnzR8m88jY/N92i+h1jUryvp1hojPlce1o8c9xG6SeJy3jNFGp6OIxx8w+BprMQE8iwKkrIVtJi2YxPRXpLQCf9bRzdKjMDODHUro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EGIl0ZaG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QXmfwrbN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BFBYWL027081;
	Thu, 11 Jul 2024 18:26:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=6ZjVFP0sMo0Ga485NQMwuHdEYJLdnhbcsjqQBOtOdJs=; b=
	EGIl0ZaGuEvdT4BDZ7/7U+ptVrb6yyfaroqoC/LAyHlMguDVXxeaRkU8I7WOHkbK
	577xoAq8ZzKFjzHEaXLEzKWf/ujEu0S96navA5xmpvzBcSFY/8utFwI+qvEGxsck
	8KavJbzVU/JYJ5SEcHOFs2sX7mS2WACxuCDqyDIBB5/ncfiaXr8P4fn+azi38o43
	28HhJQtgN/KjXiz5BnFJg6twS9P+Gnc/4+hPGjNicZpYV66zZDlcu2FtalSoHQl/
	E3GOlWWS3UowEeR9kqDVrD/hGtqTYs2wNyAm+c8nTnlMeHREfP8nL+nTwZ6cpJLP
	GF2eefeWdnbJMo00xZTJOg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wgq2anc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 18:26:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46BHUNu1029021;
	Thu, 11 Jul 2024 18:26:18 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vv5cykh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 18:26:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kh5toftapvEmozx/rvkOkpwVsrwkd7BcZ/AhaRwKU+CkOn0o2MUljWutJDAFU4DaQgT2YmA+Sfcbeds9sxmyhXUepGDp7uI5SZX82pZZVU5keabe/js2CK8rz2np7Poqv7AcK/q1wsxDqYgr/osTbBbzxbprEgWHDSU3P3DOxEY0vIrEJeolmKXDdIgf7or6OCliJJrdqTMKLFzD9L96gbV12l8E/krXaXwk8XwI5kbYQQMwBUB+3svWBa12+PMqncpicXoSSjskjSD3C2t/foDuWOAar7ambsX0xKwaOJsrRfOVRgUmp/6xu11wn/AgBjn9CEYSkoEQ5kBUhnSLsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZjVFP0sMo0Ga485NQMwuHdEYJLdnhbcsjqQBOtOdJs=;
 b=JRJJvgHsYhdPNdAuSRGFcWc5P6N87opJt+sBzE4RJwS0zn9c9vfWMXRXZ1MN3idrriIH0eq3UPzwF7rb6vVwxfc3z/s6zHW9PtqlARn9+3AaVlpE5L5dy3ZkiVVgmoclsQBYUijNh0tXZEK1/XTrX25tssd881cWGYTAFrjjObj4Si9ANdEoCrXFMr3duXk3oXqT+gNoxrwPfxgxBmBYrVJkiNr/V0uYpyf9dM6Doqfco4M8E5Ch4sTJvPQlzeSzL8RUy2/20DeqrXjoaavLZRWMpMGItck8YWgDj7S8TBmqTDunorBBidC73i41xiRnNmOIn8mbq1znO/tRALV1TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZjVFP0sMo0Ga485NQMwuHdEYJLdnhbcsjqQBOtOdJs=;
 b=QXmfwrbN/UopU4rVdmMzK1jZnHIk9G4o5W6wnDzimMjlSICOpzNBBM8sooHctKEBPEezEuyfXwsViLYzZdkfsERb84QTgKyME4v2Xi74GTI2GrFuS0BnVqStVy58lTktLjUtKWVajNTCLAanQxxxFoDMRNNp6S3NxnCUdUZaYrI=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS0PR10MB7204.namprd10.prod.outlook.com (2603:10b6:8:f3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Thu, 11 Jul
 2024 18:26:16 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 18:26:16 +0000
Message-ID: <da7aa81e-493b-452e-bf0d-5bbdda04cf8d@oracle.com>
Date: Thu, 11 Jul 2024 19:26:09 +0100
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPROBLEM_linux-next=5D_/kernel/bpf/btf=2Ec=3A7581?=
 =?UTF-8?B?Ojk6IGVycm9yOiBmdW5jdGlvbiDigJhidGZfc25wcmludGZfc2hvd+KAmSBtaWdo?=
 =?UTF-8?Q?t_be_a_candidate_for_=E2=80=98gnu=5Fprintf=E2=80=99_format_attrib?=
 =?UTF-8?Q?ute_=5B-Werror=3Dsuggest-attribute=3Dformat=5D?=
To: Mirsad Todorovac <mtodorovac69@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org
References: <a8b20c72-6631-4404-9e1f-0410642d7d20@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <a8b20c72-6631-4404-9e1f-0410642d7d20@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0173.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::17) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS0PR10MB7204:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bcc3aaa-70ab-4d22-9097-08dca1d6f3d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aUpsUG4ySktuWDAvUDVXcFlVNURqUmJMZEJrQk9TKzNTaURFbXJ6ZGFsY0JR?=
 =?utf-8?B?VWhpTFR3Q1ZSY0lsRmZESXNVa3lSdVdGR0Y5V2VCNWZqOENHWjc5SjNIUDha?=
 =?utf-8?B?R3c0RVQrM2M2TVh3UmorWGVsd2RWZ1g0ZExIWXJuRUZyMnI0NWFaY3lkYldT?=
 =?utf-8?B?Nm9qb09YcEgzMkpRUzU3czJJOW9Oc3p4YmROTURpK2lZRE5wT0VVWWYzSVFl?=
 =?utf-8?B?bzN2aFYreC9Kb1hCSHBHdllhS05mcncwdDBkWG9iTUdwNmlEaHJhRE5QYnVT?=
 =?utf-8?B?Vk93NmRqbkI2TXI1OGtqQ3JwVzc5Rnh2T28rTjlQZEJ1TElxNU40b3BiTlk0?=
 =?utf-8?B?T3BKQjlVT3RsbldmbmRyZFJOcFpLWFJrSERydS9xRnh6WGpNZkduSFI2Ylpk?=
 =?utf-8?B?Zi9KZmM2TFd3ODhYZFBMY29xQUQvcCszSDlKcXRtTGlpdlpxNXJZTzhiaHhh?=
 =?utf-8?B?d0tuNkhIbzdOeE5mN1hOb2ZqdVppYzNQL2N6ZmpjWmpLdFRiU1FXSytMN28v?=
 =?utf-8?B?ZEQ3ejVKeVkvSVFFQkRJYzBOaW0wRVNYblNYYTBRYUx3Qmo1RFl1TVdJejNY?=
 =?utf-8?B?RXM1K2FUM1BHcmRqUkRJVm5xWnJjM1QyeEovdlpHUUVxUG5mMDRQcGswRS9z?=
 =?utf-8?B?SkFYNStOdWpZYjUyOFpaRWxsTVZ0V1pwT2l3WjZvMmc3Z3A1LzMvSEpEc1Zv?=
 =?utf-8?B?ajhteGJ1Sy90cGhMekdvTHlMSytORXcyZEQrMlZtUC9QaThnQTBBSVNjNU5j?=
 =?utf-8?B?TWFySFlueHVzTlhzWVNBdmxNYVdiTmJPK2U0cWxRZXo5WnE4bmRYdkxzTG1E?=
 =?utf-8?B?bmUxb1cyb0ViNFFYM05PMUhEcjdGYlE2MllkZElFRnQ0VzN4UlBMMmJwam42?=
 =?utf-8?B?L2wrNkxsS2lhVXBmbUl5aDJHbm1Pc1NpZDFTMTdMckdrRjE2S1NCK25OVXVp?=
 =?utf-8?B?akZNZld6MDRLVWpENW9lT1hGNDB4VEgwSFFSQ2lmWUxzUW5uTGNrTVlTaCtF?=
 =?utf-8?B?VlFjeU9MMnJnTFJVWWJvT2xYMzU2UFhGeC9SMTBKcFJRaG5sWThPZ3ZJVlV5?=
 =?utf-8?B?SjBWclhncjU0VkVaR0M2QjVEZzluQmNacVhHUmNoQUcwUlorTjRqNTEwbG9z?=
 =?utf-8?B?Vnp4cjhIWmRidXFCY1paUlQyaEk5K2ZaSHAzUVl2Znplb3k4ZFdVY0doWEVi?=
 =?utf-8?B?NlpFOEMxby9IVVhxY21BNHdORmgwSFJaL21GYzJuejZLdTI3SytaaUxsWVZq?=
 =?utf-8?B?VVYwcExnbWFMd2ZybFVtTUY4WDI1ek1tdlZjLzRGak1VYVlPYTNESloxd09X?=
 =?utf-8?B?T3BuR0JJN0M0UmVmOU1weUdDVUFhN2s1NW5QMTNJSnNFM0hGRkR3djkyTmg4?=
 =?utf-8?B?UlhCMUFDK3d4WXNkaWlLd2tqeE1hOEI4cXBMZi9vTkJ2R0JSaE40Q0d1cS82?=
 =?utf-8?B?U1hCSTJNQmMwRG0vNmZ3VHNLNithVGhZeWpXZ2hzZy9QVzVRUUFWeEMranJr?=
 =?utf-8?B?YTIzK2ZuYTZneXNFVms5cTAvTlNDdXZzMjdGWGM4MTVOQmNvRVZxaGpyT0t5?=
 =?utf-8?B?OUxnUHVjRmJMMEYxaVlLV0xwajFuTnBkdDBkUjRrTUtQY3RmTi9UVTFOdTQv?=
 =?utf-8?B?SEtqOWdYclRWRUNHV1FsSkNjRW4zeU5YbURqWEVCTmMvb2lOUmM0UGFrbHBD?=
 =?utf-8?B?RVFYalFBWStraTBrVklGWlVnTmxvb1VwOGlFYzdSWXJ1QlhUVGxGZ3RleWFE?=
 =?utf-8?Q?DotrekuGaXKb8dpcDE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SHo3OTZtanVwdnZreERwK1o1R2FwQWdjZE5Xb0hkNFR4TENaRmpjVVlHdFVy?=
 =?utf-8?B?Y0FjZVVOZzV3bUJFbzhOQzZMbExObXlWaU52bzd6VHptNFZzNFJTbXhBcDBE?=
 =?utf-8?B?Mk1LQ0J1enFEZEQ0RFozRFJUY0Eyd0FVN0YxbHJ0VmFBZHFFL0VFL2d3L1di?=
 =?utf-8?B?MFVVMDVIUFMxd2lPdDN1NHRBVWtYd0RjRHB0RDMyOW56VUdzYW1SUWhuV3Zn?=
 =?utf-8?B?dUdqOHZjaDZEbjJSbUdtY1U3U2R2eFRvNFA4ODNJSWg0RHpGZlRJVzMyME9J?=
 =?utf-8?B?NWYwM2FmWTlISmtVajhPaGZmSkh5Q3QrckdXalhKUW1PeENVaDZHT1AxLzVq?=
 =?utf-8?B?K2NqZ2RuanJQZ2dic1Z2cFhJUXE3MHYxVGxUYmxaTFIyVGZZM1M1eFR3U083?=
 =?utf-8?B?dFhobk42Vk9DK2xyUTZ3WUpWcE9nMWN4TjUwZjQzamFxdkJSSGJxSWdWdGps?=
 =?utf-8?B?YXRURUk0K2NGcHVLV3BKU3BQRVgwRy9CU1FqNmp3MUxkL0VFUm8xZmtGa1Z3?=
 =?utf-8?B?c0pkZmZiVTZuRjNQcVczd29RWTVvYSt6U1prYzNyZlF1WGQvYStHVXdvbEFh?=
 =?utf-8?B?QVcwLzV5Z2ZNVmVBbGZvNktKLzNRUWszb0NQQit0QmVzeDI5UnZqOTlXdDRX?=
 =?utf-8?B?cHBuSkJYbHRYeXRod282aDNKRDZrcjVDcWJ0bXMra2V0UXNvTFlNTTQ1ekJF?=
 =?utf-8?B?TXdBdDRkL212Vmp3clBxQkNnN0U3K3VuK09aRTRHbktsdmVNSGFwRmtndnVR?=
 =?utf-8?B?aEVhRkt5OW56Kzc2Tit3bUtrTGc1TVVyeDVQZzFXS044L2htNUVRT0M0dUwy?=
 =?utf-8?B?dlBOeUZXNmxVSFNiVWkrbithVTlXemtra2RBbmd2YU11cUVoanpKWEVwK2pL?=
 =?utf-8?B?bW9KLzdMMnZuczFjWGVzTnNSVmE5S0FBRDZCNUdhUy9Fai9oeVdGTjhPYlVZ?=
 =?utf-8?B?Sit2WEVOTXlJUFpybFlKaFREdTVyUmN4MlNkSW1TMjBJT01KN2czT0JPM1Zu?=
 =?utf-8?B?bmZMNENNZXdxRDQ3RVBJWk1PdFlBbTRxaithZmdRYnR5Slp0b0o0ZG5VYXly?=
 =?utf-8?B?K3hFSnZwOWZBVnRFTERCOXJXTGtEU0dNOElLOGsxZUgybW9ZdFJqdTVHN294?=
 =?utf-8?B?aWxXMk42T0pVQkNTMUtZdU94ZjRORi9QRXlCbEVxS2JDQkFXb1FETE5zWXZ5?=
 =?utf-8?B?QTVpMzZqbkN5OVN4S1FocndabWJmNTNzUHNkMnZDNytxNUtSMVdwSFNtb2tm?=
 =?utf-8?B?WlNEOUNKdjVoK3YxbXdTNUpZOUdNS2NEYjlIVjFjYXVibGMrMDRqUWYrK2VN?=
 =?utf-8?B?bTUrUUJRSmZsZE1zRTR1OXpUZWRSaFRSSTdIdkllb0FDSmxiTXdlUnhqTDFT?=
 =?utf-8?B?VG5TQ1lyVU1EVnRDamFac0F1U05VZkwrL0FacDZnd3JYRkNzdHJpeCtqb2du?=
 =?utf-8?B?U3R4RTc1bkUzeTQ2K3d2UElTY1BTTkFReGx1VFhxWUFtY0ZrYURUNHBLZ0Y2?=
 =?utf-8?B?MXIzbGFVRU12MHY4anIzNUNlREU3ellSMVdjQWdXT2xtbXEzVWdVTmRFTkdx?=
 =?utf-8?B?c0NZazVKNmdyMlk0SFdxZlV6Z2JXQ1FuNXZTNkNoWHZSdDJLR2daUE8xMUdl?=
 =?utf-8?B?VTFOdk9waC9MNGlZQ3h4UU1INzNtUjdrUUlNSndONnFLMHlSTkZMNlp5K1ZW?=
 =?utf-8?B?OGxnR1pwQjNRcWFFTVduSlZndlRGWjAwVE9lQUxadHlrZUtjMUp0Z05WRHBE?=
 =?utf-8?B?c21ZMW9Ub1Z5T3I0cHl3Nk5sSktyUHZpeDBVYW1GRktKaVFxb0JUMXZMaU1W?=
 =?utf-8?B?WHRrSVU1UTZTeFg5bGJJT0pzVGNQYWExYmZZNnJ5Q0F5RVY3TGtLZ2lwL2xz?=
 =?utf-8?B?ZWoyWWJCMG92aWxYa1R3T2MrRWphZGQyQ2Z0Z3BGNkRzT0Nxd05vRUlZbHp0?=
 =?utf-8?B?ZWdQaVI2RXV3ZkpJQllKbVAxYnNCaDRuVTBFcm1xZEVLSFpoclgzZ3RNSVZh?=
 =?utf-8?B?SWtIU3ZKNjNrZkdnU3Vqd1RvVlVtNzZoem5HcmJ2eXFZYlBwRGVESTBtNFdV?=
 =?utf-8?B?ZTRkUnMxYmVPMnhZRzJPUEN4Z3RHMTVwWGFqWVFUejFYN2pYN1FseHBBSTVW?=
 =?utf-8?B?UEdsRXB4QzlGdGNjOVFyNE1TdmxndzZITzI1MVJFN0cveVBuTSs5eUNzaHdX?=
 =?utf-8?Q?IBtrBd5eEaEZyOFqo/Q4wJo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	BGLAlXU5SaGMxxcGP5KYBcCvd/YMvDqkOl3xAuZ9GWJrk0fg6EZiKyGTqOIelI08gV5xmzGy9I2KHkAeoXPwqfZPgXVtuiknbOOAXyfiHH1pHlkFNPlfWqYqrMKVPOgcHpknlBgngynicYtIRiK8Kheh0HzCQcstrsEkilIXuj2KkGztV8irFKTymUM+GUHHR8GUnzOKgHti1qckYGMMQvTvYUR9B1uskZUGJu0MmnW9o9M12Zmvdun3+m/JHbfsSgSXUPJXnOHIiHHy5IOZ15q4IxnW+//v83ktszYd40KLKELwA/mwyUEDB40T8go9z4mvBlduydVfhYHxacy4T44bFiNw014HmxPmkpL4ddVMeZRzFAg9fvPlmB21KV1LVc3HugI2St3EaK16QY1oBPnzCaYYVDhNMY2ctYGHbG4xitzGj+fQAYH7zLdNJ6MN4Ti1j2jgRuCd7uDAGDdBEJYAe4nm8qqOfrLyKwSkaBuieFvMam2jxoi3/peSQ7deX8qE4D2v9l52bnxDc1/6LsMdIDA7XYfhb0ztz3aThDob/tBDNvncgzPwy0+DDA5fUuKbeJpenDn71ge1+GahHN1s20uSoLKJVRuQArGnAGk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bcc3aaa-70ab-4d22-9097-08dca1d6f3d7
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 18:26:16.8118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yZMWcsboScw98Ll0yThpUpFVt76d8AAxHENT2QChYX05FN2lTGAtJX6C5WKppsQq1L6yYL2aIhlsADAdF7OJdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7204
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_13,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110128
X-Proofpoint-ORIG-GUID: u7aRwfdeB7r6XaimdtpTXOzoM5NeQZvY
X-Proofpoint-GUID: u7aRwfdeB7r6XaimdtpTXOzoM5NeQZvY

On 10/07/2024 19:14, Mirsad Todorovac wrote:
> Dear all,
> 
> On the linux-next vanilla next-20240709 tree, I have attempted the seed KCONFIG_SEED=0xEE7AB52F
> which was known from before to trigger various errors in compile and build process.
> 
> Though this might seem as contributing to channel noise, Linux refuses to build this config,
> treating warnings as errors, using this build line:
> 
> $ time nice make W=1 -k -j 36 |& tee ../err-next-20230709-01a.log; date
> 
> As I know that the Chief Penguin doesn't like warnings, but I am also aware that there are plenty
> left, there seems to be more tedious work ahead to make the compilers happy.
> 
> The compiler output is:
> 
> ./kernel/bpf/btf.c: In function ‘btf_seq_show’:
> ./kernel/bpf/btf.c:7544:29: error: function ‘btf_seq_show’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
>  7544 |         seq_vprintf((struct seq_file *)show->target, fmt, args);
>       |                             ^~~~~~~~
> ./kernel/bpf/btf.c: In function ‘btf_snprintf_show’:
> ./kernel/bpf/btf.c:7581:9: error: function ‘btf_snprintf_show’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
>  7581 |         len = vsnprintf(show->target, ssnprintf->len_left, fmt, args);
>       |         ^~~
> 
> This doesn't seem alarming, but it prevents build with this config.
>

Thanks for the report! [1] should hopefully resolve this.

[1]
https://lore.kernel.org/bpf/20240711182321.963667-1-alan.maguire@oracle.com/

Alan

