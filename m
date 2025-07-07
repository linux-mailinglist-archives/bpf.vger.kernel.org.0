Return-Path: <bpf+bounces-62563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADF4AFBDC9
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 23:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8E80421A10
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 21:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E959288CA0;
	Mon,  7 Jul 2025 21:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ndX+1WJ/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HZMgA677"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F210E2882BC
	for <bpf@vger.kernel.org>; Mon,  7 Jul 2025 21:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751924647; cv=fail; b=iu83Yl3z7sKzhG5nplTfSQn0G6C5wAPvy/54JCSsZVZgCDkpSB6M6AFEyaG3BBZUexGdLNbjdy3KKo0zLD1YDaIB05vSoSQNGxF7N01fwp4FFmct6X0bE47VWTKhGH59Mnblg7NPKuxrUxRxVOyHfyY0jGC8pEU+Fq8z0w0lwpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751924647; c=relaxed/simple;
	bh=yukcRa0TpK9L87HK7680WNl9MJV4bEFz0J5KbsBuh7k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dPl2i1dX6EQ9diqG+hJeYLQttIgWL7A3PZznGPQZQ018wWj8xpDmgFsSre8QLh9ZAW1aoAQ5ExKe/RD0/peDHbzMjE7v+hyWn56POnAy0J303BlSYgJQf1EQXs1JdXYGV0cIfKGPJEyw+of/FirEz/N61H2RuqSmR0RxTe1Sfgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ndX+1WJ/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HZMgA677; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567LYqb4018271;
	Mon, 7 Jul 2025 21:43:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=yukcRa0TpK9L87HK7680WNl9MJV4bEFz0J5KbsBuh7k=; b=
	ndX+1WJ/mqB+nwzXNTm3EBQ6hZpn9bPovAlYk+2oRsxLusuZ+Hxxt3RD5FCwCZFW
	JquPFQ28aXj/Co0BlJWW1uLH+gH6KUn3MU1EJbNqxaRsLpkL2paq+gRIiWpuRyiT
	42N/iptN02oeSZgOJA1mF15QL6DqBAflhYo2Jbmr9WJ3yyyFbtu8t9xImFYweXIA
	VIGUfcOhckMCl+C2gOpATu/XZykJrFLzcsjbCMRtEUn8We8TYv1xuMfi1ocv95VN
	cuJMOSnI+UoZJtlImCRdZHuae8As4NINDpJUvG3pEnmFaXJ9M4wBqth25kz29SbW
	LLk26FsR4BPORjrYETBxlQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47rnuy81sx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 21:43:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 567K09hf027080;
	Mon, 7 Jul 2025 21:43:48 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg8tk3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 21:43:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZX8BPkV7JE2mezUVq1kpmnU6c2Lu5Ch4pjlzcAdp6kHkKW7J3VGi0MoMmiDEz9iA3RaWvgWwh3LbZJwN1QEZ6j0KyTf3aR4DTcSkW4JWaJoQdrHvNlDZLUFRisoaclqNMbMYcv6POXKEugM0TsYYEB2AxVdOjjQyAp/8ZFyjiHB8nwbm7CsGjFIonw8cZwj/fh/YXVK0Cv1LdP6oeNkDkxkwvKbQlt+E4+WE8th9gubw0ag2a8JL0Lqchuw3Vqi/ErA7jbadhCiVM70/JxQNlU3uHWLPbrDbluWT6KHgoZyI5a48Ah6aYTBa+zYmPI5eLzsXb8NN46zUKY6Afz8xpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yukcRa0TpK9L87HK7680WNl9MJV4bEFz0J5KbsBuh7k=;
 b=VXG7VGG9EUq6AfP22mNwOhwvuIXbf2JMD6eKkrk7Jiy7sjOHIl9nQ00A+OSOrVX2EXdLPpJ58uIkQkGpF8zR1zX6tqrzEHs105/O1XZNiOStpGQrqsUVEexrg6jDVAMhkULop3oIgkxARVlSmBLsi8934vnbgwY9Dp4prsgTjRJwQOy14+Mb+cMhotoCeDwHKrk//q7vzGMmJRvxPwxRbBONpMAUpw2r9p15Q0afyrzqZZsmXBsgwPgCHm1LHdevzU50XPG+qwPBId8w4BcyZtXuTewxeIewiBmEvXJw09uu8O1fp3DcGYrceq+hLJhngsRJOCYkd+sUkHYuH1uEbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yukcRa0TpK9L87HK7680WNl9MJV4bEFz0J5KbsBuh7k=;
 b=HZMgA677WjHYKOxV4mY1IaFJ3XgKYLL0VDiynhAaVFobmmfaxz4V9TVsmzf2mTAHS1eYwFvRKnzOmlYzi0OwAstbmpeZhOz6TzZVumQpsUx0+d/wI7Y1UTexW4TP70PeXHsWqg6FPdsm9OIUBp/KDHc19xGGPCiRDPzxWlUZFgc=
Received: from SA1PR10MB7634.namprd10.prod.outlook.com (2603:10b6:806:38a::17)
 by PH7PR10MB7782.namprd10.prod.outlook.com (2603:10b6:510:2fd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 21:43:46 +0000
Received: from SA1PR10MB7634.namprd10.prod.outlook.com
 ([fe80::5d7d:6585:d28f:3d9b]) by SA1PR10MB7634.namprd10.prod.outlook.com
 ([fe80::5d7d:6585:d28f:3d9b%5]) with mapi id 15.20.8901.021; Mon, 7 Jul 2025
 21:43:46 +0000
From: Yifei Liu <yifei.l.liu@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: "ast@kernel.org" <ast@kernel.org>,
        "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>
Subject: Re: [External] : Re: Potential BPF Arena Security Vulnerability,
 Possible Memory Access and Overflow Issues
Thread-Topic: [External] : Re: Potential BPF Arena Security Vulnerability,
 Possible Memory Access and Overflow Issues
Thread-Index: AQHb73/hh4SJLhGcm02fmIUrcyDtCLQnKrUAgAAGrIA=
Date: Mon, 7 Jul 2025 21:43:46 +0000
Message-ID: <5B89E759-2B80-433F-92AD-9B0CB16C2308@oracle.com>
References: <1A9DA34D-7AC9-4A77-A07D-46B4DD0E3136@oracle.com>
 <CAADnVQKDeKmz95rHT4sRX9JhrRiBR06wngVck_cVzmGtDMiK7w@mail.gmail.com>
In-Reply-To:
 <CAADnVQKDeKmz95rHT4sRX9JhrRiBR06wngVck_cVzmGtDMiK7w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR10MB7634:EE_|PH7PR10MB7782:EE_
x-ms-office365-filtering-correlation-id: 324bbaea-ba62-4c20-86df-08ddbd9f59e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aDM3Ty9SVUhNS3RDYnltajVhc2lMeERHR0Z2LzN4M05jYU12c3FyVlBKQkRp?=
 =?utf-8?B?Q1N4d0k5OXkzUkpuYUN2N253YlN5ZVdFTGErQVRlOHRud0dINENyS2Q4c2xX?=
 =?utf-8?B?VzQybGVzckhPdS9VV0lKV2JSb01RcFhTM09JUFppZEtUL21rQU5OMFNLQm5m?=
 =?utf-8?B?dG1hOUJ2M2pOa3pvVU5VV2VKOHB4NmJRbFNLeVB5T21OUFdIRVpwa0JZZktY?=
 =?utf-8?B?OXRlSS9qRzZncUNmU0d0cWdKTDN2KzdDdk5EbGdFQ1h5UmhTSU43ZTh5Vnlz?=
 =?utf-8?B?Mk5teHg4ckFFTktaYjlNSXJKejZmNUVBTTlCOW1XNmFTKytFRHprVnJMWmRJ?=
 =?utf-8?B?aklOckN2QnJUV25UK090ZnhhNlRuOVRZZ2svS0pUUnVaaUFOeDIvMEs0eVpn?=
 =?utf-8?B?bm01aGRjeFJPUTZkSi9STURFRTFMQmRPTkxqcFBRSWQ2NXM5UWVpM0lCVlR3?=
 =?utf-8?B?RVFFbEpmT3FYaGFlb0VMWnFiU25oR1BrZlMxaWEvSy9TeVFUN2xzbWMvR25Y?=
 =?utf-8?B?Y3laNGxWMFdVSlZNN2NPeWp4bCtUSlpOeW5oalF2T0xxczVhcktKSEtWWUIz?=
 =?utf-8?B?eG1BRitZeExubjVnVFF4T3JyMFRkcis1WFU0V3ArcXVMQlQ5MWk4UGhTamNy?=
 =?utf-8?B?cWw3eHZnSHZqY1kvZkdGYTRhVjVUZjJIWkIyU1JpUU9BT08wQW9HTGlxR29G?=
 =?utf-8?B?WTN1MFlzUHQvY2h0cDgvaEdDS2dNTndaU0lRRDdMSEtvMXVVRW1wdTZ2bVlM?=
 =?utf-8?B?Mm4zTlIwYlRCTzEwaGdISWxLY0dIbWhLY3MxT2Q0OTY4L3RVd1hIZ2RuRk5V?=
 =?utf-8?B?NG0yMDJvRWFtWHA3K3lCRXBXODJlVk1DWFpxUExYTmwvWGF5anJOcDh5Q2FP?=
 =?utf-8?B?dkhyUklWRndQMTBYNWE1SzZhU3pSWHFWbHRodkQrSlVkMmZKMmJKM1RtOTd4?=
 =?utf-8?B?dG5MZEkxT3ljalVocVRJbWU0VUFYNXJodjA4dVJTMG9tdlRGU3lMS2N4RjI0?=
 =?utf-8?B?Vkl4T2JKSUlVQkNqSnJhYzZhTktqRTZUREE4ZTFPeEM1aXVoOW9aL0tXM0NZ?=
 =?utf-8?B?bGdEeEI1SHUyaUd0OUoveEVRZXlnQ1YwaWFBd041V1ZIRFpLRVJKMjE3RmdT?=
 =?utf-8?B?U1NYaGl4UnVVRmxoWG9BMEYwNUlKM2s2RXBCeGlrc3MzbEZaNlBtZEZYODBW?=
 =?utf-8?B?STBoS1JYaW5nYTRuTGFQTFAvSHZWdWtiWms0dlpNTXNBM0U0ZGNNdHo0TWVy?=
 =?utf-8?B?OWRKOE1wbEhVTkY2S2FScTZMTzQrVVBndDNTQW13Ri82Y050RFU1a3Y4eHNW?=
 =?utf-8?B?TDY5Rld0ODhEYTRxRHRFRmhnc0pzN3l0TnZHYURHNklVTnByS3pjRWRKSWlD?=
 =?utf-8?B?aHpQZnN3K013L0RBMCtqRndSbloycXNJcVVGNWZQNUVpSTZxeTFBUVFxVDZ4?=
 =?utf-8?B?N3kyWHF3M2dheHA1ZE1RR1c5aHZwRU52Mk9XOGRqdjJFN29FcmhaKzFacWts?=
 =?utf-8?B?Nk8zdzVFbjZXZ3ZpT09SRDJNQXJPR25NMlYxVU41T1dpZjh1R2k4L2JZQlEx?=
 =?utf-8?B?YVpJaEtwbzF5RmlLOWw1T3g4R3MxYW9nSkJSeHpjek1WaXRVN254TnNoVnpG?=
 =?utf-8?B?Y2g2UWRra0R2VFFwWVZGemVoUWZtS0JrUStQeU1nVFp3S0Z3YWU2ODRGYXVN?=
 =?utf-8?B?TS9uREcrRmYyVHQzTXlMMVFlVU15clJEMzJ1MmhlOTRTWmw2Z2RZaXdHK2t5?=
 =?utf-8?B?R0pFdGQ2S1ZDZ3BmUjdLR0FTaFNrM2ptRHFCaExEeFFLTlRxL0xmUFdjeDBk?=
 =?utf-8?B?TW5LWTZuemF2WUlaczdKRTBPRFBSbkROVFlaNGhLMjFnUXBaSzd4aXJudHNR?=
 =?utf-8?B?cllIRDhVYjFZMm9oWmNsYUNBamFDajZDNkw1RDhVVkhOczBuekN2ZzhxVzZ1?=
 =?utf-8?B?cXpCdHBjSjRodzBQVi9ML0UwR0RReXB1RnphTkJNVm5aZTNHRUErUUloeE9E?=
 =?utf-8?B?S3VHWXJBVUZ3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB7634.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OWZJWWVDUThhZ0tBaEJMa0txQ0Z2WVF1K1BHNWN2QVR5di95MmhUVXJNbmwy?=
 =?utf-8?B?bENlZklIWHJXcEJ4N041TzR4RTNKL2FlQjVZTjk0OHlkL1c5S2RvTTM1TXdZ?=
 =?utf-8?B?MHgwSjl1dHJWZ0dJSUZjbUZmZ3pSOC8vT2l0WU5XT3BmUkhQMWwzZ1ZjdmFJ?=
 =?utf-8?B?OCtrcjBGSWViVDJZTHpJeWVBcjQ4MkloeUhZdmhGbS81czMyWndxQkdQc3Vr?=
 =?utf-8?B?SXNPYTZKV1lYVzBBc0tQeDhWbUVHYlFQMmhNaWJzYjEydFNCNzM1UnYycG5U?=
 =?utf-8?B?R1ZUeCtKalNVdzdYUDlpU3RhOERHZDZSNkFDN3VWVGRjQ1pWcExzd0RoU0gx?=
 =?utf-8?B?bWgrV2pocFJMbUhQWXowRkhnd1BWSjhiRFNoaWhHdTdKdU9YTDdicEdUV0xP?=
 =?utf-8?B?L3NWc2oxeERaS0JQTTZ0Sm9RNUxmSHlZbFQrQ0NjYU9yNFNoYWoyaGN2cU9S?=
 =?utf-8?B?b0U4L1VETVdDVjVoQ3VqR25wd3FwMDR3VC9XN2MyekxlVElmTmNFblcyZllt?=
 =?utf-8?B?VUk5UUU5TzhiTlhqUjZ3NEM3c2tQRWMwRndYNzJXU3ZNT1Y5UDJOQ3hkb1NC?=
 =?utf-8?B?eWx3a2hKcWJRTTljVDdiYXJaVmVLcis3TG5DY1BoVUIyV3RaNloxdDN2bUhq?=
 =?utf-8?B?dk5ZbVBod3lTdWpGY1lzYUFZVVRwUGlNMGwzTVphVjVybjlscjRoS1ZGTlZm?=
 =?utf-8?B?MnExWlJPWVViRlBYTExleHBwbEtCMGgyZG1FYTNvMjY3OHl3KzJ5Y1lUYXlB?=
 =?utf-8?B?My9mYkxXbjNnem13ejMybktXaDYreWlCMWNBaXZjS3V3cUY2RWJGNEVWaEtx?=
 =?utf-8?B?VHFQdmN0Q0lHQmpzZUc4QmM1dDlSMlBKZzdUQ09qeTJGc2cvTkJWN0l5b1pB?=
 =?utf-8?B?SnNoWW5uaWdFcFVhWG84RTUyMjNGaXFKbGowdGQvNVRXWDA2bjF1Tm9sYjds?=
 =?utf-8?B?aTRXU2hlL282ZGZHeWVTaFdMZFRRR05CRUhrQ2V6T2lRcTZ4Sld6K2xFaHhX?=
 =?utf-8?B?NG9VWVpUbFZIbWUxbTZScVloYmN6eXdWTGdMYmpaUFZVTEJ1V0IyV3Zxa29t?=
 =?utf-8?B?SW91aTdIbFNKNTFGVHJxaVFXZFBOTFpRRlhsQS9KVU80clZZNTN3YlFZL0hN?=
 =?utf-8?B?a2NQc1hzSStJMHdyWlk0N0huZHpQUjY1OWN4cjlDNVVsd2RKTWFtQW1JMkxh?=
 =?utf-8?B?cEhUdVJRdm4ya3lYZGpoVHVDUXE0VkY3a0JPZWduNFVLZ0dwKzFGSFpxdElt?=
 =?utf-8?B?NUxHOTBScmU3Z28vVThGclFDdWdkVVduekFMMVJLTVZkY0l2NklLYW9kdTd0?=
 =?utf-8?B?Z0ZReGRIcWc2cXplZFNycXdFZkxkbTVQT0dVQU1kNUNhbDBCekU4NTQzZmZj?=
 =?utf-8?B?RUc4d0ExOWVoWHptS1FjOUQ4ZW4xc3FaZ1p1R2Q4VE12VGdoZ0NzTmRxeEFZ?=
 =?utf-8?B?UHc4SDZZTkozTnV3Z0FyN3c5UDNXZkg2dlh5SisyK01ReVo5eC9xb0YzcXk3?=
 =?utf-8?B?UGVydFhTaS9UUjRrNG8xRkxrU24raFYwbVloQ3B0LzIrK0c3RFRoS2xIUnI2?=
 =?utf-8?B?Z3RRRlFBakJmWWhTNjRQWTM2MVpzMWR3SFIwNEltOHd0azlwamRKZVpuWWRD?=
 =?utf-8?B?WmNwOS9uREhDT213amJjakk4VmNUMk9JcWJvKzBaUkpXd1UyUVZPUzlLcXA4?=
 =?utf-8?B?UTJMQ2tuTmdhOXJmRWZFL1doYjcvVEovS1p0LzFNUlQ5NUN6Q2NrUXRtTENT?=
 =?utf-8?B?Uk56SzFNaklzZzBGUTZKV3c5SnpHeFpNVlFKUjcrZVE2anh0aEpGVSszc0l5?=
 =?utf-8?B?bHY1d1g4VXNITlNuSEZVeEJUN2FSQ0Q3dWpYVmsvTEZQd2d4MkJUMXZCN1F4?=
 =?utf-8?B?aXByclFzVUZ0OUVzc3VtREg3ZC90TUxFZVdQYmhZYmlkeWZHTW5abWxmcUJG?=
 =?utf-8?B?L05UUFlRWFZTQ0RETi9zZ2hPeVBUazYza243MXF6bTQ0cDFJUjA4dC9jbEJi?=
 =?utf-8?B?RlVzQzZZclM4UktpUTBteU1FdGtoSU0yWkVXblJWeTI4UnkxcncreVlBZGtZ?=
 =?utf-8?B?VFdSRkNTZVlNbm1Rczdpb2JzR2JoQjFGSkt3bGVhU2NlM1hjYjJ5MHBva2Zl?=
 =?utf-8?B?Z0dISTd1NW5remo5cklNRkJkNHdFaEZBbTBlTEFhVnpkR1hCMHQ3MGxta0Vq?=
 =?utf-8?B?aWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F02B66D8EAD2C74C900DF87B5FF5E9A0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	a4rOK+o+KEdZCa680VSSFisyEEZc8zAiVydHaySZiyWqXZXaXc7Pe13wfLgK++IHumzWtAoMw9fdd/e2a16ZV2cRFhHwUtH9978JWMVbzg3mqbWXNn+5/5aXC25mYUu6+VaD3wa8EtYnYPT/n9/TJLSk2ERzFoUtAZU5EkiZgmkdPjYd5bh83K0W8ZFy9EA+2wXcfzLdCskbUxCAI/Y5z0QMlBeS5ECIneO+Le3I9RR9egbmECi9HNWZ6RMypU/aDS8G/th+T4nyC7qEuLvwofuNlgWn//y57ZsySbWKjSX2AvEMD4tJF3zvpju6aLsQRGliQrGfJhdDNjjtrlqdhDNifoqIdkyNf8Q+4OfAwxwZ38pdO5tR7NU9KPq5fZqwj6jIerQkJy++u9cmkXQhzwKaQsqpemgkwszYxhA7o8+MHt+Jqmss62oS/IKEKj5Qjx8Cp4e6vsgZWeHQZ/YzHiR404dopuc7lrZ0HQwR3GIMX+1nQTQC1j0KuyHT8rh3Gi5RaKg7zDsT8hy/vznY4heunUvgOPh74WNP+pkvvj9j830INXFEDeClnGFmm8xafRRBSPRNx4gTcDWxv7uuoJsSo2F9P/p732cbOPHgIFU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB7634.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 324bbaea-ba62-4c20-86df-08ddbd9f59e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2025 21:43:46.2156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 38JzXNGw2it2isg+My62RLMQoTAGYmFeQvZ02sY13xba2oUAER5m6iHWJdLIiYfYwQf22YZLVk3VSi7N8xE4Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7782
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_05,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507070147
X-Proofpoint-ORIG-GUID: hjMZXK21v-uY_Ev4Ryc92YjDUDwEFZQc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDE0NyBTYWx0ZWRfX2PFkQFpcolKJ rx896Ofahc6QHUti79iUfqQTUn1xTBawQ+kP3uB9UeFc+oZFi87xCbRVMh5Ae1hhbsZWIn/X2A5 XH5uD9msjK/h9zbT0G3vZizzmVahw3lwWXbhtbiMrDrRObRhRxkwqx8KEZrjl9xnwth9TIvdSuP
 XROWqgwSTIKd0Wh0U/P816x0WpZaUDs97eD8Wm5COV52AgVYy+yOoe+iSbEbQNB9owo8zaeM50I sdwRPmMaj29rN68CIBUlm1Tm4L/TkSFRucF6YDg1E7DPprnRV+sFaASfm+wEgqW9NRiUgI2s0sK onom2PJXR3YO8+iHD4FnXMojx28N+peZaNgD4tvuCeaRmVvSbnbWaA2NnwGzU0pG4C5zRHTlIaT
 7wPoqGva4xaKOH3NmN1o9rXycgV5vjuq0dVgU4y1xeQWBEiQoxQPBCx9YTriU8wCQk2+4L2u
X-Authority-Analysis: v=2.4 cv=KoFN2XWN c=1 sm=1 tr=0 ts=686c3f96 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=MVgtdNUhuaQY8CKvJRcA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12057
X-Proofpoint-GUID: hjMZXK21v-uY_Ev4Ryc92YjDUDwEFZQc

DQoNCj4gT24gSnVsIDcsIDIwMjUsIGF0IDI6MTnigK9QTSwgQWxleGVpIFN0YXJvdm9pdG92IDxh
bGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIE1vbiwgSnVsIDcs
IDIwMjUgYXQgMTo0NOKAr1BNIFlpZmVpIExpdSA8eWlmZWkubC5saXVAb3JhY2xlLmNvbT4gd3Jv
dGU6DQo+PiANCj4+IEhpIEFsZXhlaSwNCj4+IA0KPj4gSSByZWNlbnRseSBub3RpY2VkIHRoYXQg
dGhlIHZlcmlmaWVyX2FyZW5hX2xhcmdlIHNlbGZ0ZXN0IHdvdWxkIGZhaWwgb24gdGhlIG92ZXJm
bG93IGFuZCB1bmRlcmZsb3cgc2VjdGlvbiBmb3IgNjRrIHBhZ2Ugc2l6ZSBrZXJuZWxzLiBBZnRl
ciBhIGRlZXBlciBpbnZlc3RpZ2F0aW9uLCB0aGUgc2ltaWxhciBpc3N1ZSBpcyBhbHNvIHJlcHJv
ZHVjaWJsZSBvbiA0ayBwYWdlIHNpemUgb3ZlciBib3RoIHg4NiBhbmQgYWFyY2g2NCBwbGF0Zm9y
bXMuDQo+PiANCj4+IFRoZSByb290IHJlYXNvbiBvZiB0aGlzIGZhaWx1cmUgbG9va3MgdG8gYmUg
YSBmYWlsZWQgb3IgbWlzc2luZyBjaGVjayBvZiB0aGUgcG9pbnRlciB1cHBlciAzMi1iaXQgZnJv
bSB0aGUgdXNlciBzcGFjZS4gVXNlciBzcGFjZSBjb3VsZCBhY2Nlc3MgdGhlIGFyZW5hIHNwYWNl
IHZhbHVlIGV2ZW4gdGhlIHBvaW50ZXIgaXMgbm90IGluIHRoZSBhc3NpZ25lZCB1c2VyIHNwYWNl
IHBvaW50ZXIgcmFuZ2UuIEZvciBleGFtcGxlLCBpZiB0aGUgdXNlcl92bV9zdGFydCBpcyA3Zjdk
MjYyMDAwMDAgYW5kIGFyZW5hIHNpemUgaXMgNEcgKGVuZCB1cHBlciBib3VuZCBpcyA3ZjdlMjYy
MDAwMDApLCB3aGVuIEkgc2V0ICooN2Y3ZTI2MjAwMDAwIC0gNjU1MzYpID0gMjAsIEkgY291bGQg
YWxzbyBnZXQgdGhlIHZhbHVlIG9mICg3ZjdkMjYyMDAwMDAgLSA2NTUzNikgYXMgMjAuIEl0IHNo
b3VsZCBiZSAwIGlmIHRoYXQgaXMgb3V0IG9mIHRoZSByYW5nZS4NCj4+IA0KPj4gQ291bGQgeW91
IHBsZWFzZSB0YWtlIGEgbG9vayBhdCB0aGlzIGlzc3VlPyBPciBjb3VsZCB5b3UgcGxlYXNlIHBv
aW50IG1lIHdoZXJlIGlzIHRoZSBwbGFjZSBkb2luZyB0aGUgYWRkcmVzcyB0cmFuc2xhdGlvbiBh
bmQgSSBjb3VsZCB0cnkgdG8gcHJvdmlkZSBhIHBhdGNoIGZvciB0aGlzPw0KPj4gDQo+PiBUaGFu
ayB5b3UgdmVyeSBtdWNoLg0KPj4gWWlmZWkNCj4+IA0KPj4gTWV0aG9kcyBvbiByZXByb2R1Y2U6
DQo+PiAxLiBVc2UgYSA2NGsgcGFnZSBzaXplIGFybSBiYXNlZCBrZXJuZWwgYW5kIHJ1biB2ZXJp
Zmllcl9hcmVuYV9sYXJnZSBzZWxmdGVzdCwgaXQgd291bGQgZmFpbGVkIG9uIHJldHVybiAxMiBh
bmQgMTMuIE9yDQo+IA0KPiBBcmUgeW91IHN1cmUgeW91J3JlIHJ1bm5pbmcgdGhlIGxhdGVzdCBr
ZXJuZWwgPw0KPiBUaGlzIHNvdW5kcyBsaWtlIGlzc3VlIGZpeGVkIGluIGNvbW1pdCA1MTdlOGE3
ODM1ZTggKCJicGY6IEZpeA0KPiBzb2Z0bG9ja3VwIGluIGFyZW5hX21hcF9mcmVlIG9uIDY0ayBw
YWdlIGtlcm5lbOKAnSkNClRoYW5rcyBmb3IgdGhlIHJlcGx5LiBJIGRvIGNoZWNrIHRoaXMgZml4
IGFuZCBpdCBpcyBub3QgcmVsYXRlZCB0byB0aGUgb25lIEkgbWVudGlvbmVkIGFib3ZlLiBJdCBq
dXN0IGZpeCB0aGUgZ3VhcmQNCnJhbmdlIHNvIHRoYXQgaXQgd291bGQgbm90IHNldCB0aGUgc3Rh
cnQgYWRkcmVzcyB3aXRob3V0IHBhZ2UgYWxpZ25tZW50LiANCg0KPiANCj4gSW4gZ2VuZXJhbCB0
aGlzIGlzIG5vdCBhIHNlY3VyaXR5IHZ1bG5lcmFiaWxpdHkgaW4gYW55IHdheS4NCj4gMzItYml0
IHdyYXBhcm91bmQgaXMgdGhlcmUgYnkgZGVzaWduLg0KDQpJZiB3ZSBkbyBub3QgY2hlY2sgdGhl
IHVwcGVyIDMyLWJpdCB2YWx1ZSwgaXQgd291bGQgYmUgd2lkZSBvcGVuIGZvciB1c2VyLXNwYWNl
IHRvIGFjY2VzcyB0aGUgYXJlbmEgc3BhY2UuIA0KQW5kIG1heWJlIGV2ZW4gdGhlIHVzZXItc3Bh
Y2UgcHJvY2VzcyBjYW5ub3QgYWNjZXNzIHRoZSBtZW1vcnkgb3V0c2lkZSB0aGUgNEcgYXJlYSBi
ZWNhdXNlIGl0IHdvdWxkDQp0cnkgdG8gdHJhbnNsYXRlIGFsbCB0aGUgcG9pbnRlcnMgdG8gdGhh
dCBhcmVhLiANCg0KUGx1cywgaXQgd291bGQgY29uc2lzdGVudGx5IGZhaWwgdGhlIHZlcmlmaWVy
X2FyZW5hX2xhcmdlIHNlbGZ0ZXN0IGZvciA2NGsgcGFnZSBzaXplIGtlcm5lbHMuIE1heWJlIHdl
IHdhbnQgdG8NCnNraXAgc29tZSBvZiB0aGUgb3ZlcmZsb3cvdW5kZXJmbG93IHRlc3RzIGlmIHRo
ZSBwYWdlIHNpemUgaXMgNjRrPw0KDQpUaGFuayB5b3UNCllpZmVpDQoNCg==

