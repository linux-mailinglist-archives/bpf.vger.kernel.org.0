Return-Path: <bpf+bounces-21528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F19B884E8AF
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 20:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAF06B29502
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 19:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E752421D;
	Thu,  8 Feb 2024 19:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RE+/VPQU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AAWDYJoK"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6BD20B17
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 19:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707419003; cv=fail; b=kaPv11K0r4Hvkq2hnfYB0lGSYlP2KPfcIjpvlowSZkgJvPQ55gMoJDYlD2Sr7cx4AKs4eXHTJiaEAAN1q3CYc4067YE5CEqPPasvacIdJDy0/oT+pllesgLo0ngfp+6xn8RiR3Lf5UfpI0H3oBIAsoFX06Jq3VPZh6XECNIlkk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707419003; c=relaxed/simple;
	bh=h5/+UpylhiuJiHsQTl/hxI+uI1AtoaLqrbDLdjU8mhA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=J2HPWkp4Mm0UGsJnyDojY3Oe7ghHHC0Yf3f3sUhD56srwcfBU/U5nWrgFuehvuna9G/LBwEz1a5sYKkRksD0VKivkc5rDLXvdRZkaWErneFcF8x828XPVtILT1//D7YqPUJDjPAv3gEv2Hecn1K6CahX01KfRmhSp8wPyHZTRQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RE+/VPQU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AAWDYJoK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418Iwuna021881;
	Thu, 8 Feb 2024 19:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=3FmYNdfu+H5hehKhjL4D8fcXQOR94t2K/0qN6bA0oxk=;
 b=RE+/VPQUcvjFmGZxc15i1Yx1z7JwCSQdKyyoQdV7nXmFRknw9bUknD7xPO64FaRWgIjJ
 GF9xu6qrZzPDi7NaOUoIx41NJkt6GVROX8rnS+uZdPiaSQe4WKFXNWuHXfDBUtNupoK3
 RefbR/UvysLDNiyn/i5IdPOOQSCzRQgmvMJ2IWszOEAhkKmSh/k+xlhpaTqxwvlLinX6
 KzZoEfik7Q17ceRI5RoYuNXhowG4jSQ17nDxQIGqxOHE+vW3Q6yvzOBnc8Q7J1NacClM
 GN7Yze8/7PgRNc1MgKCLaijPwWH4uqeJ0hcKek0yYRlcZD8Oe+Jqvorv4+e6xGYP5zCB bA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1dhdnrjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 19:03:13 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 418HUn5I036822;
	Thu, 8 Feb 2024 19:03:13 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxb4mw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 19:03:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d51mbV2wJ37/ZWcywXcUWI4E3W6u/Hmhd3MtqhwhgHQsCZ0j2XtJERPnMF0YL1SG5V3HE2GBPxzxOSI+6gnAbVCPN2TgRzf4ccPvkjkOqYdS1sMiHkqXr0ZINUCwEMJvKSwfMDWXtqvk9pW0g+5MTy0+X6AZYd/k/v9D6uFUnI8fBEmpDqn/J1PCVt4wOhFbGjgUBCQpmJEk8K8/a095vxh7mNC8t7p36Z3xTsITeeYhCdahyEJgZPsUrJALIMuVeaoAoLt8zFGj8gf62Bgq4nw9L2MKuIKKcKSSthll74YMEEwsgIcnKUD/pGDof8fdsR3I9qooNhNjU3wdownm8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FmYNdfu+H5hehKhjL4D8fcXQOR94t2K/0qN6bA0oxk=;
 b=kh82tw9on2+dy+xf1di070O0H1M3bWZwzQFHdzBqF5NZjXo8hUgjOZidfWq6JHPMkpGj9MFjc51h2w/cR91UWEXRWXNo68Ex6c/vncefN4+zfyg7wt9acrbSweNguFQsIwfAq9w02M274r+KYE1Z3nDlfFjONSYMV/Jkx5RATeYpQNkMqS5P5LIThRMUFXpN2Dy/uLbchBT6CJF4A1ttcuBliM77BhjdmnbDMD23ONdcfyOLv4YBTukwvcAUbDrvYDFNdFj4Ht+6GO8TB9vz4M2K1ozD70xEHa2fPI0ZAS6LryV3cd3HUtoEK01g9BysV9BwP56/NyFuPW4ZwDszcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FmYNdfu+H5hehKhjL4D8fcXQOR94t2K/0qN6bA0oxk=;
 b=AAWDYJoKBGGNcczkGDWuR+wOByh7Ptvc+hkQqhXnIQKDLjGpBaOzNGa/nnjNtBDmnYh1DPkXyUCaqs9lLcH+oHqNQLXtJN7VVeUcChyI72dAggmoA5jLshmbYnnBZOWXbQeMhcAPGrncrYoegmWnQBD6k2QZ855dvSUAZVGhV+M=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by CH2PR10MB4248.namprd10.prod.outlook.com (2603:10b6:610:7e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Thu, 8 Feb
 2024 19:03:11 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7270.024; Thu, 8 Feb 2024
 19:03:11 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
        Yonghong
 Song <yhs@meta.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        david.faust@oracle.com, cupertino.miranda@oracle.com
Subject: Re: [PATCH bpf-next] bpf: abstract loop unrolling pragmas in BPF
 selftests
In-Reply-To: <87a5oadboq.fsf@oracle.com> (Jose E. Marchesi's message of "Thu,
	08 Feb 2024 19:59:33 +0100")
References: <20240207101253.11420-1-jose.marchesi@oracle.com>
	<c3d29d43-ffa3-47e5-9e44-9114f650bfc4@linux.dev>
	<87h6ijfayj.fsf@oracle.com> <87wmrfdsk7.fsf@oracle.com>
	<4ad9dad64b38ae90e4a050ce5181ced750913b23.camel@gmail.com>
	<87o7crdmjn.fsf@oracle.com>
	<eea74ef852fc57e9fb69d18e1e5960523c4f7abb.camel@gmail.com>
	<87il2zdl43.fsf@oracle.com>
	<7d2b05bf2e7ae7c95807ac4b2a9664f203facbfe.camel@gmail.com>
	<871q9mew62.fsf@oracle.com>
	<8297be08-cd05-4f08-8bb2-5956f13bbd25@linux.dev>
	<514b171d-8a3c-4134-a0b4-9b6531b3fc38@linux.dev>
	<87a5oadboq.fsf@oracle.com>
Date: Thu, 08 Feb 2024 20:03:08 +0100
Message-ID: <875xyydbir.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR02CA0123.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::20) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|CH2PR10MB4248:EE_
X-MS-Office365-Filtering-Correlation-Id: e61b8c68-bff7-4a0b-1d17-08dc28d89867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	a1fkqLqlGFCdPm3/FSJWs8Oqz3toFKzPQ+anVRMIIwk4BM5RFrG5ZfexMQZ3vPRz65Oa3pZqTc2IBmg9SZwwKqeeQ48bXl8RYN6SA2YNjup6vWCN/s9nD2jd2c3gVCFJzAD0DMSdWh6u1wlaMBj9nOtoHBXvblf59l0hfOux3g7IWq52AO10ZS60LdYxhOIT1Ghtx/u6wXk0Q/HsZdekbnVFSCBO3UhzEifMyTAQQvw2ytqPfCSh+C5MH06d8F1TcrShEfn5uJJrGk63j+o7Gz9geIoWXtOa4ZRx1NUSjcEvbRKK9j82mZj3tCztJhpI9adf9ZNDY0kCNg8mZWFJQ7rr/2dKmTCdolQdDLSpzIOhX+kkCKyW33YqKSt7pXFKTiQBRpC64GhM/eeCc3ZR2LHWbfDv3QqBGMXxhK/VU/+jOQ0ZFXWO5bGA4PPuLWO+clcXFm4llQdjDlkpM0w+6NA2HUrqnXJtHP6hyAm9AjeyNvfCol4/+EPS8fHZ3FP2VpnTlBreJ7M1pN1nLDiUyP8n0LRqBR4g1rJtb9eqLnV0xJevsr5BZKzIO+6YKpCr
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(366004)(39860400002)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(2906002)(5660300002)(83380400001)(107886003)(2616005)(38100700002)(26005)(86362001)(53546011)(6506007)(6512007)(66556008)(478600001)(6666004)(316002)(41300700001)(66476007)(6486002)(66946007)(6916009)(54906003)(36756003)(8676002)(8936002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?REc0eDd0TjhiQ2RlVEtHZlgwZUdPR0gzL251S0xVN2tvaXcwdVU5bjhSdndW?=
 =?utf-8?B?bWZvRTZiVkg2VkxFcDdqYTNVNkQ0Q01oRjZPSGZOZ0l5cnAvaG55Q1VqQVRm?=
 =?utf-8?B?dnJsSWpLdHdCWU04am9Sd1FtL204bHIvUGZ4SUZXcDkrcUNiNnZQUlVjMVMx?=
 =?utf-8?B?M0swcEllQXpwTDBTdDErVDc3dE5zOGlnOFZQV1JzOEJxYUJRcUM4YWhLZnJK?=
 =?utf-8?B?MTF1WjA2aXBtdm40VDhhVXR1eFBuTHVrRUJ4bEhoR3BuTDk4RlkrNnF0ZnRs?=
 =?utf-8?B?TExWYm45eEpGVVZaNFNNYWF6SzB5c1FTQjk5YU5odUxaYjZFZE5DZThrcFZ3?=
 =?utf-8?B?QWtGUEkrTGcwMHJmQk9DNUUwd2EvajZMMHFLMGt6MTU1ZTF0eHZUN3ZFWTV6?=
 =?utf-8?B?Ykp5cEtQeG5DN3NEVU80Rm1ZMFg3Ti9vcE5TU3Bnem5mR2E3cVNJOVhGQjBC?=
 =?utf-8?B?cnJnR0hzL2hKaU1Rd2xlSzAxbTJUaTVJL2tRSFhlVXc1L0ovbmYza25IVHRV?=
 =?utf-8?B?cmVZOWFPM2Jwb01IT091UHZDMEdPeko5aldNbkhCYjlIaXMycUtCbFc5NVlw?=
 =?utf-8?B?aGtuSUNPYzlGVUdxV1pPVUFWQ1pKZW52VnFWaTY3YkJFYU1RVVpnYkVTNE1n?=
 =?utf-8?B?RTlWOWsrVWU1NnJmaktKL0tGVHRUVGh1WGFubUprelIyNTAvVm8ySUVYMm1H?=
 =?utf-8?B?Z1hBMUN6UTdOVjVPSjR2YjA5VnJIQ0ovckpZTis3bGpsb3QvUWZyTGxiK1Nh?=
 =?utf-8?B?U1dDOXFmWFJCZlJTa0k4VnZFSEVwSW1sNm4yaXpZc3JFaWVlLzN4MmZNUlN6?=
 =?utf-8?B?Tmt5UHNRZFFIaFlZVUVUdmFtcHpQZUZmNHZqbC95Qmt6VTZLdjBIRUR4cS84?=
 =?utf-8?B?cjlnbjF2Yk9lOXZNYjNIeURtQkFjMGduQ3I4Zkozd0ZwcDlZSVFEaEdOaG5I?=
 =?utf-8?B?K2RmOXN2RWltaW1QMWQ4eTFCcmV0QTZ6aXRNeUZUeUxhYnp0WHJTMkxleTRP?=
 =?utf-8?B?WXJTM1oxL1Iyc09QeE5uaFFTTG1hRnp0SHF5dXZ5Yk5ibldzMVF4eVhRZ1hU?=
 =?utf-8?B?cUZ0ZVpCNFV5d0FWTCtPckliaGEvN204bFRYdjJmblRWaHZwWllWZFdxcjd6?=
 =?utf-8?B?YThBNVBlZGt0aE0vcU1oMkpidE9SY2QwZ1hLQWRsWWJaNEdUTGdFcnFxejFT?=
 =?utf-8?B?TTRwZEdwWk9Ya0twc0xaQW8vb25XTmpsRHU3eHpod2kyamVqTlhHbkNpK3hZ?=
 =?utf-8?B?SGJkL1dWWW42aVJRVnl3YWZQOStlR3hWNSsrNFUrTVlWcVY3UE5JMDhpQTEz?=
 =?utf-8?B?WnM2WCtEKzZaWWZWbENGS2NsbjZNQ2hjNU5QNzZTVXJFaTduVXNMdUl4SWRN?=
 =?utf-8?B?NWQzY1pLRHhHVHZqd1BmRXRvNXRrQ0owUkFCUUU1Z2wvNEl5bXlVb2JDbHVR?=
 =?utf-8?B?QXM4Q0lDT3lINnlEeG9UdWJPaSsvdzdQeG12VWh4M1JVMG85cVgvTUU1QzVx?=
 =?utf-8?B?dzcyUm0rTk5mM24vRFY5Z3RVY29udkZ3YkhEMWVJek9ZRnV2RkRZZDY2cGR3?=
 =?utf-8?B?SWw3YTl4NVFGMEdiZ2hDcnZxQ3RhMGJBVDdwY2NUOWlMaWM4cldHQ3Z4YlU1?=
 =?utf-8?B?NnVyWEU3c0NkV3JtSXY1RXFVWUFTK3Y5cEpqVXgyelE4d1k5eVJlTjBHcVNP?=
 =?utf-8?B?NDBVWVl5NDlOVWpwRmFRSGVweGpvOW1uU0RndFEyd2NqRVFvb3BWM29nVUxa?=
 =?utf-8?B?OXVZRzNRUlRqMlRKc1JObWlQODFKeEpXWmV6azJvS2lJOFhXMGplUDBXSXVD?=
 =?utf-8?B?QVg3THdzdWIzWUtjbE9EeFN1eXF4cERvbXpORkpNcW9nMS9Rc0I5TThYZ1Z6?=
 =?utf-8?B?NjVuQUhhSWhCb1BPYUlIbUNzcUlmblZuNGdyQmxnQjRxT0twSlVOUkxOTytl?=
 =?utf-8?B?UVZyUWdGSHJxQ2l0UHhWMWU2QTRGTmtMRjMzZEtlT0dhcm1xeXprZUxRNWU0?=
 =?utf-8?B?LzNUc0NzUzF1c2gxMjF6T1BOd3B5MUxMblBhdFRFblJzWmN1UGowYzVyL2lp?=
 =?utf-8?B?cklMOVZSUWdubE5xTlVQYzlaYk93NVZnbk1ibHlvNzZpKzdrM29IallkemZh?=
 =?utf-8?B?aE5rTmQ1Z0FTQk9ROFdxd1E4N0ErczVzaExYcWpuOFJ4ZmJCUThxc09DenVC?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hwqqSvC0X8t+rJ6ziypKvt0Y2oopgonBC7EuDl7rAj/nEiJZRbk1C7X3falj17NZAfvHVJG9QLvCNHXsWtDIalvK44+L+aZf4/E71rVD0tn7NVCJD/fpLMoqqTUnh9/nmezvXzzCfmPd2OR01DIqQzD84L+HqxY9qBX4hydoQYCUi3BaLxj7jE2NQLhgshG4lY/fJbv+h+dZKUE6yXDAVbure7ekhgTnk2YEHCTECB1F2SIX7u+K+IhuPCAJxnWHQOgdC/xAWbZpFy6YkFrhjZppTTFjWDAothow05fnB1m5MB0FIeKl0fzEh4jh9dLIgTjyR9Y+c9MYz4m0pRHOWr13A2o7kmRtaC3ZrXeKn9ZrPDWniwYmeO8Nk02itCmPr2ae1ClYF2ryjHWR5ufG3hWcswsjCvQocfqSXXjVEd8FeZbmwOkFWJRSgqrnnTMjbSpNZmknvIBdiTUvTauSGccaweJ8i+9opDXUup6mjMRHJFfmma3swiPiN2YXMNhWAOq0DZhtg3nusEiP9Unl3V5Dw1isxtsPAhV7pB1u3+PM1idOpOn9JEkAKoaFKx3wOeoO8aFiDv+QaC3xy/7zpXdYYNbzTOmcGkjN8VN6pHs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e61b8c68-bff7-4a0b-1d17-08dc28d89867
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 19:03:11.6097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SttzpuWJt71AxN8pQZaXaN8gcvBbepR1tPwBbg/ujPN0YqdgPYB8e+PiijhJmAV+koS8ha/BHsK98XSAymzD0zDYPSSWjl3R7VAExA/iG10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4248
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_08,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=850 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080100
X-Proofpoint-GUID: udsuOcBEd6aziqNwx87xFmxThQK54t8G
X-Proofpoint-ORIG-GUID: udsuOcBEd6aziqNwx87xFmxThQK54t8G


>> On 2/8/24 10:04 AM, Yonghong Song wrote:
>>>
>>> On 2/8/24 8:51 AM, Jose E. Marchesi wrote:
>>>>> On Thu, 2024-02-08 at 16:35 +0100, Jose E. Marchesi wrote:
>>>>> [...]
>>>>>
>>>>>> If the compiler generates assembly code the same code for
>>>>>> profile2.c for
>>>>>> before and after, that means that the loop does _not_ get
>>>>>> unrolled when
>>>>>> profiler.inc.h is built with -O2 but without #pragma unroll.
>>>>>>
>>>>>> But what if #pragma unroll is used?=C2=A0 If it unrolls then, that
>>>>>> would mean
>>>>>> that the pragma does something more than -funroll-loops/-O2.
>>>>>>
>>>>>> Sorry if I am not making sense.=C2=A0 Stuff like this confuses me to=
 no end
>>>>>> ;)
>>>>> Sorry, I messed up while switching branches :(
>>>>> Here are the correct stats:
>>>>>
>>>>> | File=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | insn # | insn # |
>>>>> |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | before |=C2=A0 after |
>>>>> |-----------------+--------+--------|
>>>>> | profiler1.bpf.o |=C2=A0 16716 |=C2=A0=C2=A0 4813 |
>>>> This means:
>>>>
>>>> - With both `#pragma unroll' and -O2 we get 16716 instructions.
>>>> - Without `#pragma unroll' and with -O2 we get 4813 instructions.
>>>>
>>>> Weird.
>>>
>>> Thanks for the analysis. I can reproduce with vs. without '#pragma
>>> unroll' at -O2
>>> level, the number of generated insns is indeed different, quite
>>> dramatically
>>> as the above numbers. I will do some checking in compiler.
>>
>> Okay, a quick checking compiler found that
>>   - with "#pragma unroll" means no profitability test and do full
>>    unroll as instructed
>
>
> I don't think clang's `#pragma unroll' does full unroll.
>
> On one side, AFAIK `pragma unroll' is supposed to be equivalent to
> `pragma clang loop(enable)', which is different to `pragma clang loop
> unroll(full)'.
>
> On the other, if you replace `pragma unroll' with `pragma clang loop
> unroll(full)' in the BPF selftests you will get branch instruction
> overflows.
>
> What criteria `pragma unroll' in clang uses in order to determine how
> much it unrolls the loop, compared to -O2|-funroll-loops, I don't know.

This makes me wonder, asking from ignorance: what is the benefit/point
for BPF programs to partially unroll a loop?  I would have said either
we unroll them completely in order to avoid verification problems, or we
don't unroll them because the verifier is supposed to handle it the way
it is written...

>>   - without "#pragma unroll" mean compiler will do profitability for ful=
l unroll,
>>     if compiler thinks full unroll is not profitable, there will be no u=
nrolling.
>>
>> So for gcc, even users saying '#pragma unroll', gcc still do
>> profitability test?
>
> GCC doesn't support `#pragma unroll'.
>
> Hence in my original patch the macro __pragma_unroll expands to nothing
> with GCC.  That will lead to the compiler perhaps not unrolling the loop
> even with -O2|-funroll-loops.
>
>>
>>>
>>>>
>>>>> | profiler2.bpf.o |=C2=A0=C2=A0 2088 |=C2=A0=C2=A0 2050 |
>>>> - Without `#pragma unroll' and with -O2 we get 2088 instructions.
>>>> - With `#pragma loop unroll(disable)' and with -O2 we get 2050
>>>> =C2=A0=C2=A0 instructions.
>>>>
>>>> Also surprising.
>>>>
>>>>> | profiler3.bpf.o |=C2=A0=C2=A0 4465 |=C2=A0=C2=A0 1690 |
>>>

