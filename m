Return-Path: <bpf+bounces-40843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C098898F270
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 17:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85901281E64
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 15:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29558286A;
	Thu,  3 Oct 2024 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oFNlm74+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eU1IQdmI"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554861A256F;
	Thu,  3 Oct 2024 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727968882; cv=fail; b=hVZXiagQbHiLIdu2k9DFR2+a8f+Vs90cZDJk+6dw07DHh/1LjlZcwsMeXvtdGUNO02iv8rixsxrzElrx+JxKpsfFSbNARvhOR55Vs7TSRa+NfkDuzo8f9AIrwZyWBrDJOL5Op2wsYMQfQK7AR/lOG+Moqvm/s/WkkMdJzr8JgCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727968882; c=relaxed/simple;
	bh=WtmJg2PEp3vPzn4fwx76a0qiDppM9hWjfzjRq8Nnyr8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dgp+5sWX7Hvo2b+g6GMXimEH9efsexpULkpeTjdTpTqGacIFS0EgrVAGYyfTVBBX4l8wLfXXOX4locxJYpkqatj+vt7sqT8VI/zMl1GgUQ+nD5CxNPwMTmFlDl76HqPOCZVD14TyCAlOL0YimODvodWObq14HxSCQMBAMemIDwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oFNlm74+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eU1IQdmI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 493EfdjB030451;
	Thu, 3 Oct 2024 15:21:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=NJO1l0wGmtQZqTcXXvUWpAX3Rv9yFmXV92J7GdEA3bU=; b=
	oFNlm74+fR+NmpGUExEQGd9la399pmyCXr3iuMPQBT0bwGs6VvVkPRpRa0lWoNJO
	BnDib6uDIAcOAOIJMVyRtlqRxwd3G6qunAFS38Furyse84RrXtm3zUS/73wTTwko
	tHHVjcMaGVbWfqBY8cR4Csh/2YUGI3+3Pg4zOj5Eqv/fKdIVTcUQir4hzNn59/fv
	46jV1b56tZtc0t/WIi23ps2G9SLCwKzw7b2j5I2sCRUSRnF7V5U51TBO+BaBu+mc
	UeCzxbOCXNCZi8q4VRttaVlPaDygMYPMBLOuDYtLNlWNCMpuXpP6TodIO5E2bA+G
	wMkWfvw0dx1PQSZSlirMjQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8qbce7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 15:21:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 493EDWHl038670;
	Thu, 3 Oct 2024 15:21:15 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x88adrs5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 15:21:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJcQRQ/WSHPyOXt8P1pkyWYeEMII1JOdn3mJCyyLsJs8Rkl666h0J4JmTTKZsgEvOt1L2pkx46Swkqi1z28T6CvuitV3E+KSUT5snL4wLs7RpssrEhBHBGN9kL+onyDqea4YIHy/WX6bxz9Lq8MKhQ4uLtO5tNwz+ypZi0Ojao3Mr4i0sYxilejIq6Mc3I3nCo/78Qm5lnsqFV4nwS4EtjGjFhu/FmXZxhD/3wS9Etor+4hfS/ggHlxj11jG+qYuLNRDiBvHEYX9TUbMI6TVDStWqVz+IkTLvvIIKQbgvPpA0OSh0ivHcpIXnk9twV9JAh/zPOAeRmI+OdkJWCXyfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJO1l0wGmtQZqTcXXvUWpAX3Rv9yFmXV92J7GdEA3bU=;
 b=t3wJz240VM1GZrDEF0wgSbEzXISyYyRNOYUHhN0GnRBgvdH3GDoviyKqbMlc1Aa1QvWrKwdD5/ZxhsmOdLB5jF2Yb5NQ59VXqax6dIMbwZyIdojOgpYz2JC+xTxLBUYeWEWkfqc6c20JjHDDA5Nxc4vlfIjBhUu/MQSoS4KDn5Goxm8QjT3Cpp13TkD+LJ7XOO/b/iHsV4QViI6Ih/inxbENAdqiEwYKQlmBAN/Ppvt3YQ2FURnTLq6+qKUhcDSrP38Fv+hLAh8ClDF0VHscC/zsdBO8xiDiOOEQ+U7rqUHwLsvWINCtY/1HigXu/qGu4KNH4iaxfQNeHo9twIz5pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJO1l0wGmtQZqTcXXvUWpAX3Rv9yFmXV92J7GdEA3bU=;
 b=eU1IQdmIvt5OMX2o1XyC+oK1uvqAnw9vfDtdkmVCzTJOqIUXfg5DoK8aXaIVqokYhhHmMalUpD9CL817X9UM5yFp0RlDPnFarWgNRdHULF0UjPuhUvvRfTfodyGuf/KM/Q/GB2a0hUyp0yzjh1l9FO2YMiit6v/ap9U6fJ5pa6M=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA0PR10MB7644.namprd10.prod.outlook.com (2603:10b6:208:492::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 15:21:12 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.8026.017; Thu, 3 Oct 2024
 15:21:12 +0000
Message-ID: <9cda0821-4b25-498e-acf3-cd8055d82ca5@oracle.com>
Date: Thu, 3 Oct 2024 16:21:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v3 5/5] pahole: add global_var BTF feature
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>, bpf@vger.kernel.org,
        dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org
References: <20241002235253.487251-1-stephen.s.brennan@oracle.com>
 <20241002235253.487251-6-stephen.s.brennan@oracle.com>
 <22da229b-86d0-4a0c-b5d6-4883b64669f2@oracle.com> <Zv6v0WdEBg4dEJAP@x1>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <Zv6v0WdEBg4dEJAP@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::27) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA0PR10MB7644:EE_
X-MS-Office365-Filtering-Correlation-Id: 146e7b87-3a34-4701-84b9-08dce3bf03b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aS9lUHpTQURSdlU4bUZrRXNkVkpUMU15b2YzaU5SK1FVWjM0WnlOZ1dqcFhW?=
 =?utf-8?B?OFJGUjlFZXE1cnQrSWREWDFab01ZS0h2cXBZOVl4WnMvTXdlYXRJSjVIUjZn?=
 =?utf-8?B?dEpQb1dPTEF0elBWcU1ib1BwTDdjUmtFcmZnRkJBcGhJbzBZOWtKa1hRMEJN?=
 =?utf-8?B?eXZWVDJXelRPazdPV3ZjckRPWXRxRmswMTRwZDRvNU9yRCtNYVdPZzErT0ow?=
 =?utf-8?B?VzdlTVBnSGtmY2ZiMTZOWkx6b2lSWXNiQmZYaFlJcXQ0RDI4ZElpZUg1TzN5?=
 =?utf-8?B?THBRYjhtOGZ0RDRiekoxNHErS3JNM3dyWEx0SVQ0MGV2UVpQSGVGSWk2TDl4?=
 =?utf-8?B?K1k1bWtlZVFuSWtaN1J2dnZtb2J2d2drQnpWcGRIMUU4MlZUQ2hHSG1WMmll?=
 =?utf-8?B?RjFoa1IyNzUxUFR0V2g3ZEQ0MWhVZUtWTVJBVjBUTjZXdWhvMUJuUlZUT1VP?=
 =?utf-8?B?SUZ1ZlZKL0Q1UE9NTkRGRndma0lUd25oZERRM3BDRkU0RFl6RjE3UzBUZXNv?=
 =?utf-8?B?Ujluc01oeHlXRWg4WG1tUk92VitQK0JFbnJlL1pBYU93eVdoRE92UkFUK2x3?=
 =?utf-8?B?c2YyZU05b09zWTJUbkdXdFBMZW1mYnVmUGtoK0xEbFRlKzZTcHkxZ2hUMy84?=
 =?utf-8?B?cGNGSGNSekQvTnd2b2cxZUZPSGVhYUR4VXVPczBZMWt6ZDRoM2pBZnp6M3FR?=
 =?utf-8?B?VWovckMrM1p3UXk0bW1RVHpxU1FYYzNSRmtXTlI1YW0rNWs1S3gwL0E2YkIx?=
 =?utf-8?B?dGk5T2pLNG5XS1hxSkl1a09xQlU2b2tRTjFLLzVKNnNUU0F5bkZLMjdwR0Nr?=
 =?utf-8?B?SnpPMk5yOFZOaXdseldNb1grM3FPaDJaUzMxYlh6VmJnZEF2cmZzY3dHalE4?=
 =?utf-8?B?RkY3NWVybjNNN3lTSzJBYldLUjI4WXA4QW90Z1ppcUMzaXlGRm1HakU1UFF0?=
 =?utf-8?B?ZzRZSThrVWpkV0dYcWd6R25zcEt6RUtmUk04alFBbDZDL1dtdXdlUWU4VmdU?=
 =?utf-8?B?L2VYY1dMQ3c3NW8vTngyV2x6cjNqQ1JMMjFQMjREa2crR1hGWkEyeUQrZXhy?=
 =?utf-8?B?dXhDNnJnRDFYNnpxOHo3bTJjUTVtSHdKMnJXUmRDeDN2RU9WN01Pb1dGSnY0?=
 =?utf-8?B?dUExNnlyL3k0UlNiUUhLWGQ3ekV4WENGQW9kU0V5NnRoQXNSK05QZ0ljcXRu?=
 =?utf-8?B?MDZoNHUwdGpEYmZKcjBZdUtLVENKZGhyV05ITTM2bTAxbTFnZGJnY0cxaGZm?=
 =?utf-8?B?dE5YTzVoVG96SDZqYTlpbFVtYk9Ib3RldlFNNXplSW9YRWVTS1UydE9oL1o2?=
 =?utf-8?B?UXFoNTlvSXJyUkNTNVFZTndWcVlMVTk4YWVMVHdkY0hNTVFmbERXcFMzUFVP?=
 =?utf-8?B?MThXK09wTzFnRTlreGx3VFFmalArVkJzS2R3aUlLbjZiZ1VpNDVBQlVQTlR6?=
 =?utf-8?B?MzRPN1dzUk1UWG1wUTl0RzBGVDk1cXBCSXVacXNITjJ1VjY0bUFrU25Wd3RZ?=
 =?utf-8?B?NjNXWUNpcWpERUVYaGFWVlFGNG1Oa1l3OWRJSEtnKzFkRmNod0hXaHlVNWhB?=
 =?utf-8?B?UU5Wc1d1Y1YzUkJZY3VQZXFaUHFYNGRDbUkvSHRFTE5xRnpvV2RlRFhSY1dk?=
 =?utf-8?B?ZEc5SUIvWkNRcWtYdDFsTEhFdkVWVklVbG00S2c1dW9zbU41c3RkVzRmVHJO?=
 =?utf-8?B?YldKSk5BSkROVTJtSWNHUi9mdUs3djNYTkF5VW9hMlczSWNMUlhqeElBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkRrRmN5a0tZdGJ1b2JQcXEvK0hieGp0NnBjOStrWkhJWkdLRUVRcUtFRU0w?=
 =?utf-8?B?bThEK3E4TVhDKzJkWkpqSi9qVDJMdytWRDM3RTBoRDFISTFhWTRmdzI0aGtT?=
 =?utf-8?B?NDJBUWdLY1Mxb3hwRUdHcldQaExxSElrbkdTVElkNDJIdnlZczNhSUVXN1Ro?=
 =?utf-8?B?NFpwV2wxeWFseXFUeUhCWTlSSUxCNnFjK3E5NmRQYjNGcDVKb3pMSTJQVHRU?=
 =?utf-8?B?S2VpcEZVUmVUSHF1YStLWVR2MnYvQ0E2OUpqQUwzY0k2SlJMdFZkV3prN01s?=
 =?utf-8?B?eTF6Rk92N1dXQUZYemluVlR4VnhjR1lJRWh2SGVaOE8vQm1takhlQTRoNE5I?=
 =?utf-8?B?eXRGUDBKZmJ2NEt4UTlla2dRN3FNZzdjMWhFaW5taWZKZ05Ba2xYQ3FrcVdY?=
 =?utf-8?B?bTl3NXRwdnZPenoxR0lDMVlMQ3VxYlV4UGhPYitQUldxZ2lsTjRQVGQ0RHEz?=
 =?utf-8?B?UkNVQWR3alVDRjJkZUxBdnlpT2M3OFZBRWV1cFQyVGVtSUhLZHJNVEZac3RR?=
 =?utf-8?B?QVN6NGNuVEU5ZGJ5R2RsUWlGRUxZRkQ5YUZaY3FlSHB2d01NZXF3cEtrK08z?=
 =?utf-8?B?RUEvUGVQYXRqK0lLRFVPcVI2ZkdwMXdkSnM5Y01tSjVFN1B5a1BsZ0hLYlIz?=
 =?utf-8?B?MzhyUGV1RXF3UUl2aWNLSjg4bzF5RXlOeWZLaWhqUHorMjVDa1VkVGQrTFc1?=
 =?utf-8?B?SS8ybEVzbkx1ejJ3WkRJT1Q1UmhXbDFvUDNrV3FvMndjMWYreEZSaFo0OWFQ?=
 =?utf-8?B?UDNyQXArSWpnVWtQbUhTaXI3YnpSOTFHcGdseEdSd2xsTDlWbmtyTHRHcTdH?=
 =?utf-8?B?UnkybUhkSmpmNERXTjhwa1lJUk9DWTUyN0psOUJUWDRGQjROTUhXcVJrVjUy?=
 =?utf-8?B?czRVNDFTc04vSThiUE43dHgwRDdidldOd21nSlRZeWI0RWw5MjdKbHZIZmp1?=
 =?utf-8?B?ZFE0WFBiZmd4RVhwUWtmU1dRSXdCL3l1Wkk1SUhCd01Wc2NhMGVLVStlWHUr?=
 =?utf-8?B?NnluNXlvNTRWa0VWU3c4N3JSYVYwamtPeDF5ZUxubnRtcUl6V2pianlqbTcz?=
 =?utf-8?B?N0FXUDVFQzgvSEJma2piM1JNdm9UUXFFMXhIdEJDaUw4MCtIb3l3enNEVjQ2?=
 =?utf-8?B?R3lIVmNvUFBPeDUxSHJ0djZOVkx2bkhuTVZ0QXIrSy80YnM3YUtRTzVOQkE2?=
 =?utf-8?B?MFlvSEc5cHdIZmpRT05nN1pjSjRLTFJVa2FYbEllY3NRN0kwcnhBMm82b29I?=
 =?utf-8?B?bnNVWDZGNVlZMy93bDFsVnBCVjdPSVVBRTFNYkNwcE5tOXZ0aytCbysycVRh?=
 =?utf-8?B?V2huQzZ1VmFGR3BhMllLTFM0ZjM5TGQ1bTBsdStXRCt2M3ZKc01NVDhldDJh?=
 =?utf-8?B?OFkzM2Q2RXR0eWpoQm1yTFl3aWhkcjQycUpOQWt4VHVPcjdMdXQ3UTh2K0o4?=
 =?utf-8?B?WENBNFNqa3NjaVRQZFFPd1FyOThXSmQzNTJsVHFNTVdxemtjQXRpUktRRWxx?=
 =?utf-8?B?d2NVcEw0cGxVUVdGbnpmUGp0WGprWmZuSEJQdWhObjdKY1JSVnRoSzIyK2xo?=
 =?utf-8?B?emVzVDlKUTA5c0pyVFc5cTR4VXFwVzZscCtRUytyRElVY09IS0ZVOEdLNHVM?=
 =?utf-8?B?SWtpOWphNzFZQU5DcUc0Vm9GVW5xZWNDZnY5a010eGdNUDR6N3pMN3ZHeS93?=
 =?utf-8?B?Yk04QlZWUDFQL2hWbHdIaWhXUnVwNVJkUUVnTEw2R0x0RlpPTXNpcExvU3pS?=
 =?utf-8?B?ZENQbXZTZHVhajRPSEVUV01HbnNCLzBnR2U1ZGFwN1YyY3FReU12RUR3a01R?=
 =?utf-8?B?R00zVUVZaTV0RlF4NkthWHQwY1pibDlIK1poU2R2R1p4NUdjbVBJdS8raEpM?=
 =?utf-8?B?UHkyVVloQzhHdHJRbTladGlzaStQOWcxaXVJa1pIRTk5RGZpSzZBWGgrSk5l?=
 =?utf-8?B?M2sxYWhsR0tNN0JPZEswWU1oOGtMYk1uRlBSSmdZV1ZxRVdqcmhlYklFSE5W?=
 =?utf-8?B?bWd5cEwwSy9SbktESEk3bG1KdENtMS9SbGtpaUF0YzNoTHNXc1U5Y29XT3NU?=
 =?utf-8?B?MW1yM3ZMNlFlNURxUjRCa2Y0TmdkTThmSzgyOEhxamRJKzhVTStzRnpncXpi?=
 =?utf-8?B?VnNyVGF6WXBNNFBnWkV5WlZzZjR3dVZacDJsNUlMQUVINFpHUGUrWUd6Z2Rp?=
 =?utf-8?Q?Cfo+eJGQoFd0ArpXuIBgGBE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Eg9nXKJsg7frTEeqhD3T9OK5WNHkpzL/002/txihjQJGGHcvjEVbhdShb+0jUFBTZfK2rNVNUAiU9hPCF7dA3DDct/AmkrNlpsGFAdwp84hZ7ky0phA6CXRDvyVlrKnXdnPf5UZ4Rl2kNKRVUa4u4FYUoldnR7/RucrPZEkdPfgD8om+AQqBjn9F+r9GzsB/JAQmTcxDDGd1Y4kpmgPbmV+5ROmhi1w/6grGhB3khmnt+PbwwudNlPZ58qMVihkgryfdLmPR1+n509yLCNiwpAJg/Db4i0/eZPj/r/MUp/oY91uLR/cNg/PYc5rfEDesJD4PZe1KHNjVR3f0Z4O7R3zk9c/PwaVQmOqIuM84RSWJPm+e7DkyZ6hSdx27RwKufTD/iPXbJzDGiiZmP3sSFeMexqKknJx+sSMYcipQ1pR5aezKx7GgWy7L0ujjBWwHKricATmSXq7ynuSx+6KGEE0NaMcTO6sMoJUAFHxIxIllZchr58H3PeLDZfhF5ao7seU4msSKMp2uYEccZx6IFMa3V8j957/JNuIljx7A2PQTSGQChN9+dDw0UoEvinu1fjw8ijqiDWxjonjbLIqL5kjt2ioUeYXy1gS1Rr/0DwE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 146e7b87-3a34-4701-84b9-08dce3bf03b4
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 15:21:12.2020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oGKUlPrRVGLNG3eVsWUzlDi+RWR3xOzKNIYpy+6f5EjyWtP0fZMKAeRUdDizbGIIOOi7XdojRD/yXy9ukJq7tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7644
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_06,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410030111
X-Proofpoint-GUID: D5sLAiR2pOZ9kRdSQeNEKdSR6efABJ5c
X-Proofpoint-ORIG-GUID: D5sLAiR2pOZ9kRdSQeNEKdSR6efABJ5c

On 03/10/2024 15:53, Arnaldo Carvalho de Melo wrote:
> On Thu, Oct 03, 2024 at 03:40:35PM +0100, Alan Maguire wrote:
>> On 03/10/2024 00:52, Stephen Brennan wrote:
>>> So far, pahole has only encoded type information for percpu variables.
>>> However, there are several reasons why type information for all global
>>> variables would be useful in the kernel:
> 
>>> 1. Runtime kernel debuggers like drgn could use the BTF to introspect
>>> kernel data structures without needing to install heavyweight DWARF.
> 
>>> 2. BPF programs using the "__ksym" annotation could declare the
>>> variables using the correct type, rather than "void".
> 
>>> It makes sense to introduce a feature for this in pahole so that these
>>> capabilities can be explored in the kernel. The feature is non-default:
>>> when using "--btf-features=default", it is disabled. It must be
>>> explicitly requested, e.g. with "--btf-features=+global_var".
>  
>> I'm not totally sure switching global_var to a non-default feature is
>> the right answer here.
>  
>> The --btf_features "default" set of options are meant to closely mirror
>> the upstream kernel options we enable when doing BTF encoding. However,
>> in scripts/Makefile.btf we don't use "default"; we explicitly call out
>> the set of features we want. We can't just use "default" in that context
>> since the meaning of "default" varies based upon whatever version of
>> pahole you have.
>  
>> So "default" is simply a convenient shorthand for pahole testing which
>> corresponds to "give me the set of features that upstream kernels use".
>> It could have a better name that reflects that more clearly I suppose.
>  
>> When we do switch this on in-kernel, we'll add the explicit "global_var"
>> to the list of features in scripts/Makefile.btf.
>  
>> So with all this said, do we make global_vars a default or non-default
>> feature? It would seem to make sense to specify non-default, since it is
>> not switched on for the kernel yet, but looking ahead, what if the 1.28
>> pahole release is used to build vmlinux BTF and we add global_var to the
>> list of features? In such a case, our "default" set of values would be
>> out of step with the kernel. So it's not a huge deal, but I would
>> consider keeping this a default feature to facilitate testing; this
>> won't change what the kernel does, but it makes testing with full
>> variable generation easier (I can just do "--btf_features=default").
> 
> This "default" really is confusing, as you spelled out above :-\ When to
> add something to it so that it reflects what the kernel has is tricky,
> perhaps we should instead have a ~/.config/pahole file where developers
> can add BTF features to add to --btf_features=default in the period
> where something new was _really_ added to the kernel and before the next
> version when it _have been added to the kernel set of BTF features_ thus
> should be set into stone in the pahole sources?
> 

it's a nice idea; I suppose once we have more automated tests, this will
be less of an issue too. I'm looking at adding a BTF variable test
shortly, would be good to have coverage there too, especially since
we're growing the amount of info we encode in this area.

> So I think we should do as Stephen did, keep it out of
> --btf_features=default, as it is not yet in the kernel set of options,
> and have the config file, starting with being able to set those
> features, i.e. we would have:
> 
> $ cat ~/.config/pahole
> [btf_encoder]
> 	btf_features=+global_var
> 
> wdyt?
> 

I think that makes perfect sense, great idea!

Alan


