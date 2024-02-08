Return-Path: <bpf+bounces-21541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D61384E958
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 21:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65F841C21C5B
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 20:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2096F38391;
	Thu,  8 Feb 2024 20:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Keg0jFeR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Fq9wegwr"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9076337711
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 20:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707422805; cv=fail; b=Qw0QTZK0r5hfKJdM1tyPvOnQIQd8fYFaJRe8tLtVlYWi54PKsQQretqhfr0F8sWa3/TIWFfz+8cFYwujR/C/E4Nl9aKogfwauZdgK4bUwDaTkWpOrkNe4j9jakQs0p/NTpX43MG4dQ7k3v1ZzEbCL6XhtnOvxSUcfQev9yTHn+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707422805; c=relaxed/simple;
	bh=kePy2K6Sl3uSKewF6ppjcVNpcEv1PRz+BkPoNwOl3M0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=qcOH78YPkhO3VaP/UQJ33bjySQeHK58913M8ya7Ff6L+kErE9bmnZoHXJwtiSjcOEVtK9Fe1AcOlwL7qLrZEncNAbuO/bQw+eyzph9R5U9C6tvqmgLS6YQXMLTDZX706dPuiKsvNEx7W+nWKPC592wtxzAPFu8cLlpSXbA2Rtyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Keg0jFeR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Fq9wegwr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418Jnfva029438;
	Thu, 8 Feb 2024 20:06:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=kePy2K6Sl3uSKewF6ppjcVNpcEv1PRz+BkPoNwOl3M0=;
 b=Keg0jFeRYkzyE2Hi0B4unRa6r+FwAX5cwjlQGJE0lI/S2Dv/t0iMWHmhKzONyzinX7cc
 LMrkXTcUPIEpAO0ohCUwYymGfJ99sbhP1F1WRlqZZce/2nunAQPR6bbjoOZrpXPfqNHh
 DXTYA8LE4+dnCqYV9kENowUx51+tX4eipySKJdKepG10wtRk3lOTLUA/1QutRO0ZNynR
 BZAcfMbla2ARyIzuyEK4PpvhCgR4hp68TlZmwnRFRlUnHye3XpveP4ZGmdy/PnfCm1Ig
 B+Zh9D7nCyZSrdVAUu0d5TLvbEn9HY01+CPkV1klqGtf2Cm2JWCHlOEDWsPfdIOWM7n6 Ng== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1e1vdnwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 20:06:38 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 418JK1H6007082;
	Thu, 8 Feb 2024 20:06:38 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxbkjut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 20:06:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtKIbV0+g2WxO+bLqImcXZqaz/PY8z9w+zhS1/OUYUzPVc53Ye25YMuYKhwE7HyEqlnXWUprUzg3PtV0dqayV6fHOVH60j5kOCn+7nJ46+ziVWmJ+lJpYrJt2uqMR3YfvMlAaZsRm0MqFr0ikb66ya8qbtx3Di6QOniZkhaAK+B+PXKO4/kEolOz78VlCQ4LML0b7fsBCiiBWE1rhwcv9Y6sg32eaqmeTWeA7hEnIAxBcjqwHVQN1FV+KkyrFnzIR/scBREQ+AL9iShgonC9w17lG/MMYjMXj+T3E7iuten1x3g4TD07KPKS50h8qOWQRjnm1WPbddQievWOfbzk6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kePy2K6Sl3uSKewF6ppjcVNpcEv1PRz+BkPoNwOl3M0=;
 b=QVZVQlwMLvLd//M/0B+enCjCLkfOjGKUN3yOgA/i3ce/m4zSo919HAVotzYPUBTndCnBEgRN1z2RkHjLs0mym4tkFd1zEc8IemHEpPp2ocKbyLGGfeU4YSnu6GhpgpJC5YeTXqmmD7kmtkyUVgkIQrNTOktn37P4VggBuGJG1fEifKVaTVAfdSi4LUX1qpg0ByVdiWqycKj7lcDmDRulstk5eEciMDucSbTxprytrS49IS1a+H+lZg9Bs7lz+j6OIWus0wZ6JhkqzSS+8P1uqtJ4S1OcREbJFNa4rGP84MeL6TqrhTaQijTjBJakgVs5fsPdAaIME8IC9yu2ShGkQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kePy2K6Sl3uSKewF6ppjcVNpcEv1PRz+BkPoNwOl3M0=;
 b=Fq9wegwrIScnYhA7HH76E/jL8COD741F5L6/3WMLEuCv6bxUe4WUpfkvMzPfettmV2UAQzGex10uPNxXyNRa45r4t/nulTgyooVgDJ2uPwxe40qlxOhD5yXYRZxdMa/wE41mkF8xTDuuKGvOHWdQLFQCFlLHZG21T2QhBWhip6c=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by DM6PR10MB4379.namprd10.prod.outlook.com (2603:10b6:5:21e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Thu, 8 Feb
 2024 20:06:36 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7270.024; Thu, 8 Feb 2024
 20:06:36 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Yonghong Song <yhs@meta.com>,
        Eduard Zingerman
 <eddyz87@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        david.faust@oracle.com, cupertino.miranda@oracle.com
Subject: Re: [PATCH bpf-next] bpf: abstract loop unrolling pragmas in BPF
 selftests
In-Reply-To: <a61a0d43-3fb1-4b6e-8440-b574c5fe8d30@linux.dev> (Yonghong Song's
	message of "Thu, 8 Feb 2024 11:49:13 -0800")
References: <20240207101253.11420-1-jose.marchesi@oracle.com>
	<c3d29d43-ffa3-47e5-9e44-9114f650bfc4@linux.dev>
	<a61a0d43-3fb1-4b6e-8440-b574c5fe8d30@linux.dev>
Date: Thu, 08 Feb 2024 21:06:32 +0100
Message-ID: <87h6iiafg7.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO3P265CA0009.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::14) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|DM6PR10MB4379:EE_
X-MS-Office365-Filtering-Correlation-Id: 79cd6479-40cc-4942-e88e-08dc28e17418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1E9sVKI35lrvBobeFXDPgbAHaNzONSa4KPxwMVnb8Pa1zGCtGvUgcvAGghp0a+2E6gCxELaq4KLLjpXT5c9mwr23Vx7Y4LQ8l1SQcvjzTgUWmF+P89WoqSUrqUSEY7HFdmiIUBvd/peVGzIho7zCv3EcCFVR640RRGoOu8mVGdBzhK0Sxmn9PM3bjfPBDofc+UZ0Q9LHym1cxw3HzjCdEklytpSmRAGOTLedMpkc1Uux/kzJIlUgEPCZOCpUOq5iQqHv2iVcnSomZ85xSZ1g0gwIK/Sc2aKVwGvBFkaeYjqyXUk2qp/2UCMR5bxGv1vCc73sIO7hNkqkcmz7K09/I/Tr/RlUPAHUljaCz0ZUMVEhY4vUYua8ZcGZBSqG0JK5OS7eEHCum3kz+sb0WALh8G5p3mYBGEWGBiucWsGjCPc7IiPWZ5JeaOgy1dMd52cYfkYmJGqVcJTCmF94yGx1fsJ7/eVXoVpf06jkJoJczOELPUg4WsMbLkriKh1mGFHmdaRqkm0wRJPHq6JkoghGG1UhPVAcu0W/uiDhkoX6hgEp/MACUR6Xqq0C3EBQufVx
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(346002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(5660300002)(54906003)(316002)(41300700001)(2906002)(83380400001)(2616005)(107886003)(26005)(38100700002)(86362001)(36756003)(8676002)(4326008)(8936002)(6916009)(66946007)(66476007)(66556008)(6506007)(53546011)(6512007)(478600001)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UlU0NXZpeS83YjVHMzMzeXdIMUdpbWs4MnRKNGo5YlB4N1FQcXBzdnpSL1Ar?=
 =?utf-8?B?MzlLMkI0YVNFMXdQbGY2cU1ZTXlXdy9Ca3gxa1ozTS9zTzJGUndRSVlBMitR?=
 =?utf-8?B?VlRqa2ZpVEQ5ZDkzTmc1TmNvWG1IVGpDa2poSFJwMjdoREhUMGJPMzVCeUpw?=
 =?utf-8?B?REUvbzV4czZLbC9TRGtCdEFpMExFNmtzWlRGOUt1T0cxZHVhTjU1QlJDWEZi?=
 =?utf-8?B?dkh5UkpOR0lZZXdsZXZ1TkxHc0k4TzQ0YldQdTBvclo2bGtPeE5SRGlqOTdv?=
 =?utf-8?B?Nk1DQzNsT29lZWxoeG1mT3o3V1MyY0dVeXN6SEpWRDQzNHNiRlpMdWxCUEty?=
 =?utf-8?B?SzYwT21NVElzOTFQSkVZaUQ0Rk9ZUm1USkZuS0tGYlI4REloZzc5YmU2SHpn?=
 =?utf-8?B?bmZXaHROdEJLUllGOVo4QnRBTlFEMmZ1QzBKTVFNcXdzbTZudHZmTytvV2x6?=
 =?utf-8?B?Z0pVMnZleHNtb2lqOG52N21KZHFqWWNYVnB4dnpCcEVaOTUrVWV2MG5zMlI1?=
 =?utf-8?B?UnAyYkFFTDEvTzMycytaRGdEUi9DcU5ZMXdRZWRXVi9qajNQVVVxQUtlcm1h?=
 =?utf-8?B?d1hJR3BsU042TC94YndnQjhrU0x2SFRhQml4dlREL1JzOGxWRGJxcmQxSjRB?=
 =?utf-8?B?SVMxYiticmgxQ3lNc1BPaFp1Wlk4b1FWUGhPKzF6b1NhZlpSNTY5elJnWFhU?=
 =?utf-8?B?cS9sRVR1d1NqNUF6NGdPRk9yMXdIYm5Pdy9Ba2E2ZGJQMHlMSmRDZStIQUFS?=
 =?utf-8?B?bzVzNVNhdGY2NGpUeXhxdTcrWmswb3RkcXNsS2xYMkg2ZzlZeEVsUUdRSUYz?=
 =?utf-8?B?NldYVlNmNjAzR1Fob3oxVFdiN25OYy9YdEtrNkYyOW13M2xSSEs4T2d3ZUpH?=
 =?utf-8?B?bGRrNENGVFB0V3dYcXJNOUlrOGpDdmpLcUhQMVRady83NU9tMG1aeERXa21L?=
 =?utf-8?B?TDc3S3kxZDQwNXdWZk1lV0t4VU5Pdk5RWTAwRHNKZzd4VTd2SUR3VmQvKzUr?=
 =?utf-8?B?M2VOalNhVGFGTzg0RXBYNDRSc1hjZ2N5UFBjU3ZHQ0NIZDhzLytiVFY4enph?=
 =?utf-8?B?RlhGclZvR3RQTkt2WWp2K2xvVy9lblZRbGlJTmRUbGtnWDRJU2NmbVBlMmRB?=
 =?utf-8?B?S0FFWUg2dmc5aFFncVhmbDk0RXo0c0lTaERGaTA0cmtjYlhYMjQrQWpLSmha?=
 =?utf-8?B?ekhNSjBaUDF3c2dteVFzNHNxWXl1L2t1Uy9ONkJEeVhNbUFoL0wzaFVNbnJy?=
 =?utf-8?B?VXlJWkpoMm9VcnhpTlZySGhZY0RnQlFLazBTeEhxdGNLVnlRSi8wRmVJUUpB?=
 =?utf-8?B?eHFCL0Ivc0VnMmtzaFRTb000M01MVitIRmhQSE9YMGNQQVFVbXNjclVacDZT?=
 =?utf-8?B?b2Y4enJHdnlSSHhsZ1JCb2d5c0R2L2lrdngxcGNUU05hdm1DQ2VON3hIbklY?=
 =?utf-8?B?UTJyem1kUmpETUh6WnQ1L2wrdlU4a05aelI4eWZhS0dqQVVTOGIyc1lsRnZW?=
 =?utf-8?B?NXE5cERCd0pFNzhjczhRUk9QQVlYRjZCMEVGS2J3cVQyZkVLZXlGWVArR0N4?=
 =?utf-8?B?SThYQ01US3FXa2JiMFBWbzhDSmdHVE5KclVjRndYc0ExaE8rZVJlcmxQcnMv?=
 =?utf-8?B?NjVSVzRJK3dCN210TkQ5MWJlb1ZnYkRLL3B1cm42UUxXWWFkZVgxNThPT21p?=
 =?utf-8?B?VkFMeVRIWkFYV0x1QzdmWEVkZWwwTXlobjQvNGwzRnJQcWdPZ2xLaHBnd1Ar?=
 =?utf-8?B?Y1I1R2Fsa045bWNpcy9yQ2xhc2ZkN3NmbXVIUE9XMW8yMXlXSkxkbkpWd2JL?=
 =?utf-8?B?NXJCYzJPSmlCQkhRUHFEMjM0Y09GVTdHZFpDNG9mWStkMGp5VmRyMjIycGhL?=
 =?utf-8?B?TVk4MXFMVk9UUktqaXVFR0h2aEhUZ2N6cnJOb21FcEtHVm9NMExqS0RRV1ZZ?=
 =?utf-8?B?UmRScDBMQ1hTclU4djMwOFpiMUFVOVgxNDk2MFpvU0JHRERabG1YUGQxN1lv?=
 =?utf-8?B?UDFCbCtXWFBxM0RIdms1VEFxTnZGemR4TVpXb2NaVjJZNnhqV0NhakZMZkVK?=
 =?utf-8?B?MUNRUzlBcW8vSHpUeThBTHdEMW9xNjFsUzZZOEhGQ2pkSThYSnlzTHZRUWxL?=
 =?utf-8?B?RUFJUC85N1FGMlRKSFdrYkJwa09KS3VIZGptekIzL09adlJxMHIvS0EzckRV?=
 =?utf-8?B?MHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cInoZrxXq31L+1Brch4+HCrmGKO9qEPUgXykQFvCPZOAZPGSPjHCnp+vyoIsKtnTSBqww/GM2fAgCyRbpkmpwmytHegjAirBFRNgRvtDlpfZsVyB1Yma4SX8TaWnMO9RyKPNwM9SqjD4VpGvgh/l6xKV55z8YFlzy7wkbEgyHRp7VdkVh8Q8h2vs80z3NdjSdjAhGq9667gFy6VeohE1ERHyyl0v73u5XQAQm0D0JeQLmRPbm2KbYxfvW0OgATTWDAIR0AJzSKdrT2mv/izuaEQBsi8DCJhQ2hN8cxeEKE0TSHyGBumXAP0EcwInSlJHQCOzt/sImBprxr9OAw1XKPDronz73XKpFAEFshWuMHrCDAt2rTQvdJGMiVuTPiil/Kjr2G+4/YHiV1NnHHuUSqVrdLxs19DqestwqS4Wt4jtCjr5GPJwxGniT+t8X11CnbY+H0Nxi+GWqiank77UeqJtJcascA0wClfuPltEvbvamFudG550ZCOa+EssfUhj6bmRQlBsEPpv92X1ha17NQygBOwSD+P/EkNy4NQc1bwWItsz4KShN7m8u6SrQXwzoh2Z4jajyP/HFFH3G8NG5B7xIRvpFMHga/eMNoseV7I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79cd6479-40cc-4942-e88e-08dc28e17418
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 20:06:36.2149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: atv9I5kuz9kohA3iKKtRm2Iy8mL1cBEMyowC3NKj8aD51M4kc16Fy/I60+eRB+Lro2YRX4YdEr0LjIDbIMZ0gi8F1tM2ssrv5Hx2L1sYJdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4379
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_08,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080107
X-Proofpoint-GUID: dIS5MI8zZcFIvy8wxqp0LsrSzHieRxa4
X-Proofpoint-ORIG-GUID: dIS5MI8zZcFIvy8wxqp0LsrSzHieRxa4


> On 2/7/24 1:45 PM, Yonghong Song wrote:
>>
>> On 2/7/24 2:12 AM, Jose E. Marchesi wrote:
>>> Some BPF tests use loop unrolling compiler pragmas that are clang
>>> specific and not supported by GCC.=C2=A0 These pragmas, along with thei=
r
>>> GCC equivalences are:
>>>
>>> =C2=A0=C2=A0 #pragma clang loop unroll_count(N)
>>> =C2=A0=C2=A0 #pragma GCC unroll N
>>>
>>> =C2=A0=C2=A0 #pragma clang loop unroll(full)
>>> =C2=A0=C2=A0 #pragma GCC unroll 65534
>>>
>>> =C2=A0=C2=A0 #pragma clang loop unroll(disable)
>>> =C2=A0=C2=A0 #pragma GCC unroll 1
>>>
>>> =C2=A0=C2=A0 #pragma unroll [aka #pragma clang loop unroll(enable)]
>>> =C2=A0=C2=A0 There is no GCC equivalence, and it seems to me that this =
clang
>>> =C2=A0=C2=A0 pragma may be only useful when building without -funroll-l=
oops to
>>> =C2=A0=C2=A0 enable the optimization in particular loops.=C2=A0 In GCC =
-funroll-loops
>>> =C2=A0=C2=A0 is enabled with -O2 and higher.=C2=A0 If this is also true=
 in clang,
>>> =C2=A0=C2=A0 perhaps these pragmas in selftests are redundant?
>>
>> You are right, at -O2 level, loop unrolling is enabled by default.
>> So I think '#pragma unroll' can be removed since gcc also has
>> loop unrolling enabled by default at -O2.
>
> My comment in the above is not correct. In clang,
> at -O2 level, with and without "#pragma unroll", the generated
> code could be different. Basically "#pragma unroll" seems
> more aggressive in inlining compared to without it.
>
> So the current patch LGTM.
>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>

I need to send a v2 with the conflict resolved.

>
>>
>> Your patch has a conflict with latest bpf-next. Please rebase it
>> on top of bpf-next, remove '#pragma unroll' support and resubmit.
>> Thanks!
>>
>>>
>>> This patch adds a new header progs/bpf_compiler.h that defines the
>>> following macros, which correspond to each pair of compiler-specific
>>> pragmas above:
>>>
>>> =C2=A0=C2=A0 __pragma_loop_unroll_count(N)
>>> =C2=A0=C2=A0 __pragma_loop_unroll_full
>>> =C2=A0=C2=A0 __pragma_loop_no_unroll
>>> =C2=A0=C2=A0 __pragma_loop_unroll
>>>
>>> The selftests using loop unrolling pragmas are then changed to include
>>> the header and use these macros in place of the explicit pragmas.
>>>
>>> Tested in bpf-next master.
>>> No regressions.
>>>
>>> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
>>> Cc: Yonghong Song <yhs@meta.com>
>>> Cc: Eduard Zingerman <eddyz87@gmail.com>
>>> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>>> Cc: david.faust@oracle.com
>>> Cc: cupertino.miranda@oracle.com
>>> ---
>>> =C2=A0 .../selftests/bpf/progs/bpf_compiler.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 33 +++++++++++++++++++
>>> =C2=A0 tools/testing/selftests/bpf/progs/iters.c=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 5 +--
>>> =C2=A0 tools/testing/selftests/bpf/progs/loop4.c=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 4 ++-
>>> =C2=A0 .../selftests/bpf/progs/profiler.inc.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 17 +++++-----
>>> =C2=A0 tools/testing/selftests/bpf/progs/pyperf.h=C2=A0=C2=A0=C2=A0 |=
=C2=A0 7 ++--
>>> =C2=A0 .../testing/selftests/bpf/progs/strobemeta.h=C2=A0 | 18 +++++---=
--
>>> =C2=A0 .../selftests/bpf/progs/test_cls_redirect.c=C2=A0=C2=A0 |=C2=A0 =
5 +--
>>> =C2=A0 .../selftests/bpf/progs/test_lwt_seg6local.c=C2=A0 |=C2=A0 6 ++-=
-
>>> =C2=A0 .../selftests/bpf/progs/test_seg6_loop.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 4 ++-
>>> =C2=A0 .../selftests/bpf/progs/test_skb_ctx.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++-
>>> =C2=A0 .../selftests/bpf/progs/test_sysctl_loop1.c=C2=A0=C2=A0 |=C2=A0 =
6 ++--
>>> =C2=A0 .../selftests/bpf/progs/test_sysctl_loop2.c=C2=A0=C2=A0 |=C2=A0 =
6 ++--
>>> =C2=A0 .../selftests/bpf/progs/test_sysctl_prog.c=C2=A0=C2=A0=C2=A0 |=
=C2=A0 6 ++--
>>> =C2=A0 .../selftests/bpf/progs/test_tc_tunnel.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 4 ++-
>>> =C2=A0 tools/testing/selftests/bpf/progs/test_xdp.c=C2=A0 |=C2=A0 3 +-
>>> =C2=A0 .../selftests/bpf/progs/test_xdp_loop.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 3 +-
>>> =C2=A0 .../selftests/bpf/progs/test_xdp_noinline.c=C2=A0=C2=A0 |=C2=A0 =
5 +--
>>> =C2=A0 .../selftests/bpf/progs/xdp_synproxy_kern.c=C2=A0=C2=A0 |=C2=A0 =
6 ++--
>>> =C2=A0 .../testing/selftests/bpf/progs/xdping_kern.c |=C2=A0 3 +-
>>> =C2=A0 19 files changed, 103 insertions(+), 42 deletions(-)
>>> =C2=A0 create mode 100644 tools/testing/selftests/bpf/progs/bpf_compile=
r.h
>>>
>>> diff --git a/tools/testing/selftests/bpf/progs/bpf_compiler.h
>>> b/tools/testing/selftests/bpf/progs/bpf_compiler.h
>>> new file mode 100644
>>> index 000000000000..a7c343dc82e6
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/bpf/progs/bpf_compiler.h
>>> @@ -0,0 +1,33 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +#ifndef __BPF_COMPILER_H__
>>> +#define __BPF_COMPILER_H__
>>> +
>>> +#define DO_PRAGMA_(X) _Pragma(#X)
>>> +
>>> +#if __clang__
>>> +#define __pragma_loop_unroll DO_PRAGMA_(clang loop unroll(enable))
>>> +#else
>>> +/* In GCC -funroll-loops, which is enabled with -O2, should have the
>>> +=C2=A0=C2=A0 same impact than the loop-unroll-enable pragma above.=C2=
=A0 */
>>> +#define __pragma_loop_unroll
>>> +#endif
>>> +
>>> +#if __clang__
>>> +#define __pragma_loop_unroll_count(N) DO_PRAGMA_(clang loop
>>> unroll_count(N))
>>> +#else
>>> +#define __pragma_loop_unroll_count(N) DO_PRAGMA_(GCC unroll N)
>>> +#endif
>>> +
>>> +#if __clang__
>>> +#define __pragma_loop_unroll_full DO_PRAGMA_(clang loop unroll(full))
>>> +#else
>>> +#define __pragma_loop_unroll_full DO_PRAGMA_(GCC unroll 65534)
>>> +#endif
>>> +
>>> +#if __clang__
>>> +#define __pragma_loop_no_unroll DO_PRAGMA_(clang loop unroll(disable))
>>> +#else
>>> +#define __pragma_loop_no_unroll DO_PRAGMA_(GCC unroll 1)
>>> +#endif
>>> +
>>> +#endif
>>> diff --git a/tools/testing/selftests/bpf/progs/iters.c
>>> b/tools/testing/selftests/bpf/progs/iters.c
>>> index 225f02dd66d0..3db416606f2f 100644
>>> --- a/tools/testing/selftests/bpf/progs/iters.c
>>> +++ b/tools/testing/selftests/bpf/progs/iters.c
>>> @@ -5,6 +5,7 @@
>>> =C2=A0 #include <linux/bpf.h>
>>> =C2=A0 #include <bpf/bpf_helpers.h>
>>> =C2=A0 #include "bpf_misc.h"
>>> +#include "bpf_compiler.h"
>>> =C2=A0 =C2=A0 #define ARRAY_SIZE(x) (int)(sizeof(x) / sizeof((x)[0]))
>>> =C2=A0 @@ -183,7 +184,7 @@ int iter_pragma_unroll_loop(const void *ctx)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MY_PID_GUARD();
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bpf_iter_num_new(&it, 0, 2);
>>> -#pragma nounroll
>>> +=C2=A0=C2=A0=C2=A0 __pragma_loop_no_unroll
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < 3; i++) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v =3D bpf_iter_n=
um_next(&it);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bpf_printk("ITER=
_BASIC: E3 VAL: i=3D%d v=3D%d", i, v ? *v : -1);
>>> @@ -238,7 +239,7 @@ int iter_multiple_sequential_loops(const void *ctx)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bpf_iter_num_destroy(&it);
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bpf_iter_num_new(&it, 0, 2);
>>> -#pragma nounroll
>>> +=C2=A0=C2=A0=C2=A0 __pragma_loop_no_unroll
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < 3; i++) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v =3D bpf_iter_n=
um_next(&it);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bpf_printk("ITER=
_BASIC: E3 VAL: i=3D%d v=3D%d", i, v ? *v : -1);
>>
>> [...]
>>
>>

