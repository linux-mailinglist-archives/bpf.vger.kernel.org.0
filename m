Return-Path: <bpf+bounces-20355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B732583CFCA
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 23:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A419D1C23D41
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 22:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F2E12B78;
	Thu, 25 Jan 2024 22:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cOyfg6Jd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A8zaK7ba"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC1912E48
	for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 22:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706223431; cv=fail; b=US8xHCtBAJ2XXjQu0fRypqFViCMGT2PYCCj5wPcnbcun3mOzSwgJMPaRwvwe6aQfnGYt/8b3JIYCj/xJI3Yj529h9E3tbnSopBdntp1ZnpMHPVANc2lv2Pc4l9cCdqGUakh0a9siJ1AtRyRMckfeL0dJG18ueBqAsIe/CORTBKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706223431; c=relaxed/simple;
	bh=ZFtNx9IzYA4R+rctos4m610TggLfSTfaGIHBDOEH2uA=;
	h=Message-ID:Date:From:To:Cc:Subject:Content-Type:MIME-Version; b=AZCh89UjQr6rG4MnUAT59Wm+Be8GIh18CdIsUoXDZA8EQTBUbfg91VaITxUmdG50x0t7ZumgLIGGS02Nch+FdLAwMUtHLLlXRddzoOYEs0ndlRpUD8QEbVhuo/MAEL/ZZmqHyBLr2nioiNhfSU3FYGCoj+QQHGJu1pN1KmrdMMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cOyfg6Jd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A8zaK7ba; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40PK44w2013704;
	Thu, 25 Jan 2024 22:57:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : to : cc : subject : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-11-20;
 bh=1WQqLDDGtP1+xKFA/JGeHvjagq8E+oOL/9grbKE0c7k=;
 b=cOyfg6JdXD4AiORzlJLIkwojS/S8GUk1vWeaaeWu0cvxn9ufRsRUrD5cZ6PU2UBZiET+
 S8mP2zrA+w4qfMZ4bYTAdMP9HU3Vs/MDeaZGO13v/UFFQcIohhekTB5w9bGqHYmMX3aV
 QmEQ06tBcQRDWnPZ11h/DcR6C2xv03ueLKo7iOPowiSWjYUC6GrkzGZmR3ylKG9WYUXg
 lwiLgHP5RE+W4T81RgPsWEO8RAKnNByvoFvh/xlfqqgMghTb1OrhkbHYXN5BJjwwcGyh
 jkF25VA1D93/Ijd8xMIqiX29XEFd8UcGB32c41gQcck1M8ZYUrS5itbSoMZjN0V9Eegl kw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7ac95m6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 22:57:04 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40PMTccP014166;
	Thu, 25 Jan 2024 22:57:02 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs3755ep9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 22:57:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=diyGJDIK/s6BCF4UoeNJRM257Squca8wJ3q8wGUPcVTzoObgRSWla8r/QspgPBUo4DnLLxfxTekz2iw6EpLbEbWNmr7Ik5vUPngQ2tlU6fOPVEE1L/Pv+rKk2yTJyMQISTTvHmyINWidjggNh5LjkDNEvajLsdDZ7S7GA5q/BrQmXdFCOUwxzBb+JG3jYSGnvyZ7KnwnTRtuzOH6wHjYOn4WdsITrSTdT5uZldu7LrZKY8zPPWRFrE14G3tuIKRvnfmkXs5foDMKHTgNQk4k8q4TCAhA4UzmGBFviWTun17z4iro0x48NRobpMLzLcRYAL3QKhvgFep60FFcVnS+eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WQqLDDGtP1+xKFA/JGeHvjagq8E+oOL/9grbKE0c7k=;
 b=h6/FGMXD2GcW3Q5bhvK4OO3EhEKhpR1Gz+ZLpIn/zGjuktq0vwc2tcMpqM5EExLE3DO8uuJlgCRe+34KNyF8C6qbY8z4YlD87S9GPSCbgf29qCCSl4TWgWVASgmAKTYSqLXpfWzpfFzU32b2kLuqRqnF39LAEaw5YRq3vaft6OioWw7LUFqMjzmTc9/QPXBjnzWD1nWJaHB/YMRgXOX5NrZ2YOs8dIUewXoBaKzwJ+NU42n8T/uiIWQ1elIuTx9S5om+nZ77S21t13JoWxWxfU5NUBMUctHt5D2MOy1BOdoIwiqKgbVL9p7bdSZqNQBI29S8wgF8q8BqErLyJKdKOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WQqLDDGtP1+xKFA/JGeHvjagq8E+oOL/9grbKE0c7k=;
 b=A8zaK7baf4iUUJGTjh9ooVc1R4ZeAUTzfwLvJIWf0X6RtqAvDaAp1sNvvv2QIeR0Hb7YofG7Pc2MKVKX86Fv2FFJm0U1fYQ1g/uKVOGIkKiIoApPmKFIJSFeNpXJmwMooCG0XyBGO7T+OD2QcQeqhsZ6jrb+WiY+AQZL20FyVSs=
Received: from DS0PR10MB7953.namprd10.prod.outlook.com (2603:10b6:8:1a1::22)
 by PH7PR10MB5879.namprd10.prod.outlook.com (2603:10b6:510:130::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 22:57:00 +0000
Received: from DS0PR10MB7953.namprd10.prod.outlook.com
 ([fe80::9722:fdc5:e685:633]) by DS0PR10MB7953.namprd10.prod.outlook.com
 ([fe80::9722:fdc5:e685:633%7]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 22:57:00 +0000
Message-ID: <a513d5c8-cae1-4c5d-a0aa-170c678c278b@oracle.com>
Date: Thu, 25 Jan 2024 14:56:58 -0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: David Faust <david.faust@oracle.com>
To: bpf@vger.kernel.org
Cc: "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        Cupertino Miranda <cupertino.miranda@oracle.com>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        Yonghong Song
 <yonghong.song@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: BTF generation and pruning (notes from office hours)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0213.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::8) To DS0PR10MB7953.namprd10.prod.outlook.com
 (2603:10b6:8:1a1::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7953:EE_|PH7PR10MB5879:EE_
X-MS-Office365-Filtering-Correlation-Id: 9745a61d-d4de-4b22-20f6-08dc1df8f09f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jUr2qfNEgfOfKuzHALLib7a3GPh6prCEwpiIgYAtjhe9Zosfb8SGtuySKbSettP1CMxW1bA+p017Sw8BdSyxsmLX39gCNf33CP4VwzlxZLEcqOOc+cDOIyDkzMEHFQBEE5neLPUtovXBw60yPYGAG20ztkAtpTBaf+lwG0QN03Dbwnvs9kkef3rR1DNmi9U4loGdlgZa4MVdbKKrJ0R+7C3SfmbQQdNpwzhRoElR8JChKxZ/EDouRo/UxNysE4NkFZ0SKqAnARBbGd6p21w5Q5QS8jqmOO8d+/JF/Zu36lcM23GS+5Eg9XYo1Q61Zz20RawXoVV1DG24fCpt6V6WHzvC9oRiclcIWppJLtM3praISVgpsWQJuUwH18PmnrZPiF9ESNgUqRmnXzNqXSI2m3h0J1hM2SwaKtV8sByWAMQu3gZk2O5idEnwvzg1lGIUDzrz9ufbxrlklbqg0LoNSSUGTWgibZqliy3GIl3Lz4ZXmOLQGrgfNUldB211duDvxFWxGE7vztRTuQGN2j764YM3xN/W8AvXRLYVkXxUmh9170c93cgN+8f3OzXiO2Ej+slUKAj57WD98piHv9ktivKMCPE1SvxIPNijl+AUHE3QFYoOmVBXP479QKzwT6yzGKb1zaKSwXeEaYTdYYqjyA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7953.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(346002)(396003)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(44832011)(478600001)(4326008)(6486002)(5660300002)(8676002)(31686004)(38100700002)(86362001)(31696002)(8936002)(36756003)(6506007)(6512007)(26005)(2616005)(6916009)(54906003)(316002)(83380400001)(41300700001)(66556008)(66476007)(2906002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K1ZBM2kzQWF2R2ZlY2VrcjY1MlFMbSswdXJ0SGVyL3NvTTBBblhLOFZ5QWFX?=
 =?utf-8?B?VUF6cnpLN0ZlbHBEaGVnRCtNa2QxbEV4L3F2N3FwTEhpM0lCRHZzU3ZPdDJG?=
 =?utf-8?B?TVpOcXA1MFE3YnkxWFJCY3JPdzdxdWtrdnVaSFZtYkFzdkE5RXVvK01tcUxG?=
 =?utf-8?B?RTBrazN1aWgzNnlkWGs4OTAreUhiTWZPa3NVQXB4MzFwUjE5aGpWU2Rtdk1Q?=
 =?utf-8?B?UVpWUmVQWVNJRzQwSkNwR1E1czVzSVlZM1E1TVI5ZUpOYjlLNGRhSU42OHlx?=
 =?utf-8?B?c3RrSWc2OFNaZVIyWjg3ZjVZd1kvQ3VjOUtvdEV1WGt1bXltNFpCM3RmSzIx?=
 =?utf-8?B?MGEzbVhJYkNoYVhyeUNpVFh6L2srWE12ZDlOZVdnNlpxSE53cWh6Ylp4aTVa?=
 =?utf-8?B?bTk0cXFYS0MvWm0yUE5mWXNXT2NQZ1NxTzdBNnMvTGwySjhMbmhYZlJlZk9s?=
 =?utf-8?B?bEQxeXRDSGhJc1VHVDhNVytsajB2Y3lLSFk0Y0tjdXBVWnBzVzQ2NjBtQXhw?=
 =?utf-8?B?TTIyY3Jma1d0RVQ5VDMvS2NRWUJvOHJhR05XZEJ1blNpMlJ0bXh2VWJEeUgx?=
 =?utf-8?B?djYzcGRNNm9SeFlrRUhEbjFSRGRPYjU3K2NQNlMrNEdTSUVTUU40RmdiekZM?=
 =?utf-8?B?eWtxZmZnejNZZnBvUHk5WWtIV0FnNGhzdDdTeTlNRUs1THhQZWhXUE1YZHhJ?=
 =?utf-8?B?bTg5VVNoOW1pN2JabG1yekpuUXArNTZqaTFhZ3hTSVQ0R21TYUdkVnVoYjR3?=
 =?utf-8?B?QTBEWm1YZ29sTFQ2RUl0SHZsT1Jmb3hJL3B1YnZmOWo1T2VLTFZGNEgvUUEz?=
 =?utf-8?B?ZlU1R1B1RjlRNTJFeU5kSzJBajlyWFpFQWdhZUV1WmFQOUVsSWNRMFh5dEVx?=
 =?utf-8?B?aUdSWkNkU2RkMGlQS3JDZCtLUU9SNkpsSzJvOTkrYUswZCs4L2YzUEk3QWp0?=
 =?utf-8?B?S2JERVNJVHRWSTBlMVJlWStnQ211VWhtYVRrZElFTVdNWHFLcExqTU9TOFNy?=
 =?utf-8?B?OHovTTJSUlRPaFBqa1FTYXZ5MTVVbktXd2pJTmVodzFLWThaRGx3S05kSkJp?=
 =?utf-8?B?bWRWcnlRaisxS3RiZDUvYW9vcHNYQVBuUEZDdFlzaVcvWjJ3U1p0SE1VbVYw?=
 =?utf-8?B?dVlzQ1lMaHJWbXNDT21xRXBhZXJ0T2tOUWs1b2NJOGdSOW5WbnRIbldFQmlN?=
 =?utf-8?B?WUM1WVpYZWU0ODBwR0hGckd6Q0dmUVd3ZlhRYnBzd1VlOFZnRmlObmtSVmNp?=
 =?utf-8?B?TlFzTkt0TWNtRXZIaVJ6bWFZZDJuZHR4cldVSnQ4OXVHaDBIckVyR0hXY1VU?=
 =?utf-8?B?aVBDbk5yejN1aVMzYnQ5NWhZUGd0WDRzb2RyOEF0eHJPZXNwbGdlQmFYVnd2?=
 =?utf-8?B?SGVJbXpyYmJSUld0czhqS2k4MmxVNmNPU0ZPY1JOWnkzcjhmTkJhT0FCckFZ?=
 =?utf-8?B?ejBNUWdsR0NwSmZWWUVWam02VEdrVlFMQ3R0Lzh5c1p0Mjl2b0g0dGdaMVl2?=
 =?utf-8?B?NHY1K2VlaXgyR3pzYlhLS2FKN3dkS0hYdTk5NnoxSEgzckVuYmpGSVViQm82?=
 =?utf-8?B?bTRJd3Rha2RZWENQMWw5TDhQS0tBVnVyUjVMK1gycnJqREV2RjJwa01CVkw0?=
 =?utf-8?B?L05Lc0dKQzBVMFJGdWpZSGl5UzJ5cVg2WDJPSHBoUndiWUJYUXRiRU55UzJP?=
 =?utf-8?B?c3pIZ011WVZHZzIzQlRkenNZb1N0amt5RGZNTFBGOGs5Y3B5NUV1dkhFQnJL?=
 =?utf-8?B?MDJKTTk0TU1JS1VrT2ZyREZzRE94V1pDdkxmbWJCVzFFL1ZOVWVQNDN6Zm5h?=
 =?utf-8?B?Q0NLcXZPbS9jMUpDSHdhMWp4cng5ckVhS3M2aUhmTWx5ZGNTdlR0YnVNYkRO?=
 =?utf-8?B?dk9ER1NJQUJFZlRVdVpDRnhCdjdkd2xnbzVTOFptTHBHQzlzcTN2MkR5UzJ2?=
 =?utf-8?B?T2tMMGNpbkNPajhDUC94Qkx4ZXBEQ1NkaFhpYk11Y29aazBWUG9hL1dXT0dx?=
 =?utf-8?B?U0x0Njd4bGJNNmpCR0dRSzVzak1Dakx0a3EyVXRtTWVzWkRkQVNnWHBLbUJW?=
 =?utf-8?B?ejFVMUpPOTU5dWpWMGNmUmljS3NQT3k5eFBqVEd4RWQxcklSSVJvZWpqOXUz?=
 =?utf-8?Q?XEbSt4srX/2JVitKYpspp5ZLN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	kkf1erz25Fp9o+Tt7Yhl3B2Bonxv/F/Ah/94rpJWmeM91GJjABZ+Wf7yOWpVw5c7wojNwoA0jJyBMVf6w4uetMCjtuKcwQn1ivoYAAaMNyW8xGhqlLfjyUVUTPf6l3t35bzMb27Jhwhs5NmO/o6r/CVEvtc1gRVIw4ksg0U57c8ERjRSTqPMHA/4vW2qzqo0dpYqiO6pbcewLpjs05Jnohw6KPGN4xe4Clp6DAEjUt9KlknZca2Ihp8q7kg02D4r0ApN3OR1I5CSCEQFZh05Y53tOKS2bzjCsP+5GRbYE/hhVNHvQc9Ew5566oy/2npJQUnH0sejXD45LWd4glUqUcJ+U2ba+9DB0pTAe4AvE+KvA/ZRevv52tjpxtyalhvZj3LMu0b8Dxjtk24V8IAxCz2zPrnS1FbRQ7D3b0GqeMExSrMfTLBS8L6vcXGnUoXVI8zV2OjqJ3Pmh5eiKWdk7PI7+4DCj6PBpmk9ydT5Gl8gXTYycUHOWmgZFiGU/W80se0FV2/HaBYGaYt1Ksn8dU0KXpNq7g+y1Fqerv1EGGTuAkNkv7eWQRUWihjz7m9cBCCNRTBMXDjKAb5HD2WTSpBUavo68YBlQoZmFSMTByA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9745a61d-d4de-4b22-20f6-08dc1df8f09f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7953.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 22:57:00.6962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qev1pUlm6FjD4zKfrbHfo0h27yjUFPu2EmumEWMvlpW/4XEVxvs1mte8qBzqRtUODggYXpOok342voqjip458A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5879
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401250165
X-Proofpoint-GUID: X-dqcmAVj85iid2SlS8StrM6c55VLiVs
X-Proofpoint-ORIG-GUID: X-dqcmAVj85iid2SlS8StrM6c55VLiVs

This morning in the BPF office hours we discussed BTF, starting from
some specific cases where gcc and clang differ, and ending up at the
broader question of what precisely should or should not be present
in generated BTF info and in what cases.

Below is a summary/notes on the discussion so far. Apologies if I've
forgotten anything.

Motivation: there are some cases where gcc emits more BTF information
than clang, in particular (not necessarily exhaustive):
  + clang does not emit BTF for unused static vars
  + clang does not emit BTF for variables which have been optimized
    away entirely
  + clang does not emit BTF for types which are only used by one
    of the above
  (See a couple of concrete examples at the bottom.)

One reason for this is implementation differences in the compiler.
- In clang, BTF is generated late, in the BPF backend, after most
  optimizations have happened.
- In gcc, BTF is currently generated similarly to DWARF. This means:
  + It reflects more closely the types/vars etc. in input source
  + It is earlier; many optimizations have not happened yet, so
    variables which eventually get optimized away are still present.

Another reason is size concern. Clang deliberately does not add
some types or do pointer chasing in some cases to avoid adding many
BTF records for types not immediately relevant to the program. The
obvious example is bpf_helpers.h or vmlinux.h - programs often need
just a few helpers and ignore the rest, but by including them end
up pulling in thousands of types which they do not use.
- This also comes with some drawbacks, in some cases BTF will not
  be emitted when it is desired. There is a BTF_TYPE_EMIT macro to
  work around that. It isn't a perfect solution.

So, the question is twofold:
1. What ought to be represented in BTF for a BPF program?
2. Is that/should that be followed for non-BPF program cases, such
   as generating BTF for vmlinux?

Discussion / things that were generally agreed on:
- BTF for a BPF program should represent exactly what is in the
  final program; things like variables which are optimized away
  entirely should not be represented. Note that this differs from
  other debug formats like DWARF which more closely represent the
  original source.
  + In addition, things like static variables which are not used
    are not represented.

  Reasons:
  1. BTF for a BPF program is primarily of use to the BPF loader,
     so representing in BTF things which no longer exist in the
     actual BPF program is counter-productive.

  2. Size. BPF programs including bpf_helpers.h or vmlinux.h pull
     in many many types which are not used. Representing all
     those bloats the BTF significantly for no gain.

- BTF for vmlinux currently is similar, and aims to represent what
  is actually there. The end goal for BTF is to to have everything
  needed for full visibility for tracing. Size of BTF is also a
  concern; there are many things which pahole omits, like global
  variables. 

- BTF itself is not specific to BPF. gcc supports -gbtf for any
  target. So it does not make sense to always prune types as though
  generating BTF for a BPF program.

- There are also cases for BPF where it makes sense for the compiler
  to not try to be too clever about what to prune, and rather
  leave it up to something else. For example, if in the future
  BTF for the kernel is generated from the compiler and pahole
  is used to do BTF->BTF translation, it makes sense to have the
  compiler emit everything, and let pahole decide what to prune.

- We could add some sort of compiler flag, -fprune-btf or so,
  to control this behavior. Initially we thought of 3 levels,
  but narrowed it down to two being useful:
  0 - compiler does no additional pruning, BTF is closer to source,
      how gcc behaves now
  1 - compiler does pruning as though for a BPF program,
      represents only what is in final program
      how clang behaves now
  (With only two levels, the flag just becomes an on/off switch
   to control the pruning step)

- For this flag, we need to have the precise criteria used in
  clang to determine what to prune. Probably this should also
  be documented somehow(?)

- LTO, the linker (as in ld), and BTF deduplication. 
  + For DWARF LTO is more complicated because of call site info.
  + For BTF right now: no LTO for BPF programs.
    Supposing linker did BTF dedup, right now nothing additional
    would be needed for LTO.
  + If at some point BTF adds call site info, linker could simply
    discard BTF from the first compiler invocation and dedup BTF
    emitted by the second compiler invocation (assumes BTF emission
    in finish() rather than early_finish() for gcc).

- We had some discussion of how all this could affect/interact with
  things like split BTF for vmlinux, but I don't think we reached
  any conclusions. Input appreciated.


===========
examples discussed, for reference

1. BTF for unused static global variable and its types
$ cat reduced.c
typedef long long unsigned int __u64;

struct bpf_timer {
  __u64 __opaque[2];
} __attribute__((preserve_access_index));

static long (*bpf_timer_set_callback)(struct bpf_timer *timer, void *callback_fn) = (void *) 170;
char LICENSE[] __attribute__((section("license"), used)) = "GPL";

gcc
$ ~/toolchains/bpf/bin/bpf-unknown-none-gcc -c -gbtf -O2 reduced.c -o reduced.o.gcc
$ /usr/sbin/bpftool btf dump file reduced.o.gcc
[1] INT 'long long unsigned int' size=8 bits_offset=0 nr_bits=64 encoding=(none)
[2] TYPEDEF '__u64' type_id=1
[3] STRUCT 'bpf_timer' size=16 vlen=1
	'__opaque' type_id=5 bits_offset=0
[4] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64 encoding=(none)
[5] ARRAY '(anon)' type_id=2 index_type_id=4 nr_elems=2
[6] INT 'long int' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED
[7] FUNC_PROTO '(anon)' ret_type_id=6 vlen=2
	'(anon)' type_id=8
	'(anon)' type_id=9
[8] PTR '(anon)' type_id=3
[9] PTR '(anon)' type_id=0
[10] PTR '(anon)' type_id=7
[11] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
[12] ARRAY '(anon)' type_id=11 index_type_id=4 nr_elems=4
[13] VAR 'bpf_timer_set_callback' type_id=10, linkage=static
[14] VAR 'LICENSE' type_id=12, linkage=global
[15] DATASEC 'license' size=0 vlen=1
	type_id=14 offset=0 size=4 (VAR 'LICENSE')

clang:
$ ~/toolchains/llvm/bin/clang -target bpf -c -g -O2 reduced.c -o reduced.o.clang
$ /usr/sbin/bpftool btf dump file reduced.o.clang
[1] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
[2] ARRAY '(anon)' type_id=1 index_type_id=3 nr_elems=4
[3] INT '__ARRAY_SIZE_TYPE__' size=4 bits_offset=0 nr_bits=32 encoding=(none)
[4] VAR 'LICENSE' type_id=2, linkage=global
[5] DATASEC 'license' size=0 vlen=1
	type_id=4 offset=0 size=4 (VAR 'LICENSE')

Note how clang does not include any BTF info for bpf_timer_set_callback,
since it is a variable which is not used in the program. This elides
all the types used only by it as well.


===================

2. BTF for variable which is entirely optimized away
$ cat optvar.c
static int a = 5;

int foo (int x) {
	return a + x;
}

gcc:
$ ~/toolchains/bpf/bin/bpf-unknown-none-gcc -c -gbtf -O2 optvar.c -o optvar.o.gcc
$ /usr/sbin/bpftool btf dump file optvar.o.gcc
[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
[2] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1
	'x' type_id=1
[3] VAR 'a' type_id=1, linkage=static
[4] FUNC 'foo' type_id=2 linkage=global

clang:
$ ~/toolchains/llvm/bin/clang -target bpf -c -g -O2 optvar.c -o optvar.o.clang
$ /usr/sbin/bpftool btf dump file optvar.o.clang
[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
[2] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1
	'x' type_id=1
[3] FUNC 'foo' type_id=2 linkage=global

Simple case, variable 'a' gets completely optimized away and
replaced with literal 5 when used. Clang does not include a
VAR record for it, but gcc does.


