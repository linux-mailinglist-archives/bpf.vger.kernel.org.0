Return-Path: <bpf+bounces-61436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 901FEAE7115
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 22:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 060EE1BC0656
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 20:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CB22E3B14;
	Tue, 24 Jun 2025 20:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="kD6Mc7iG"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8549238C3B
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 20:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750798329; cv=fail; b=cC/PFblH7Uk+sJZ528VxI5AxLBpquzcrgYU4tT4QfLdvP+k9AZGqE+cwuAW1jK1hAXzebwJf8KwL4hP8Y52scD0EB5UvN+YD9kkVCdryABRijWZrX4wMuPuCl2cfaNXWDY75dUAda6rgrClocQ8EjiwCdRLPKku5eZ/xfHkcQpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750798329; c=relaxed/simple;
	bh=nHusVMPlMOeIB5bRrdZtlm6hN5dynhf/1iizSsjVBVY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OsGrejuhmLS/tih5em69Zqqt7Pi2a7JsokiqJiKSPpdybE6w1L8W7FERJ7m2zwQ6g3xaneZgcz4NG8lklHhzE4pja9+UgFpT5pZ9S+zhgWVTlB5WFwtwxnT8LN70ouxG+ZzgruZMO7oVnuIm9QdoUyWsgFluPOYAOYxH3r68AIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=kD6Mc7iG; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OKq4tr031408
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 13:52:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=nHusVMPlMOeIB5bRrdZtlm6hN5dynhf/1iizSsjVBVY=; b=
	kD6Mc7iG7wkhdZ4s1VfrpxkEfIillHWO1zPLU53vAJtQX0P96mOYcgk9NN2lOEIf
	frjKDJMoJdYxYBDymHyRrJlF84awmINFDrarD8WEzMskkeZ+GHABVDukOf8B7hbB
	w6tdGWvDyeYlGY+27LoxZ0VDyQ/FcsHsI3hCz4WvcAm00xaWzMNkKRU6COnSw9gt
	tuO1RlS2qEyYamb57HEuRLOJY9hE3oygWfUIoxwwNVh9ctQz0I+LdMXsbOnZfu0w
	8/GCr2x/kqITfQuyjYvZYQkKpjV1rxOsFYGzcLKPYdey66Jlsq5oeo7gqFBM7lGr
	wCxJzSZwbqKEswUAvtUMdg==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47f9njum07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 13:52:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8d+GZA00brddJS1/w+CPkf9P+JnBtKTr0TzQb7xc1tN0uOyTpLug1mJ6daT+d04wRmXhykAKLCxmSDKRLIDKISJJGQ4Me4FLAgi+I1ij6wVPwABzwomcMm+meP/q4+SRUexxblnPjuMwpQcDnkm5nRu9cpf0naKLuH8qngwEbSKir1fEts1QfOhvdLSzgglOAWae32A9+xZ8LlVLQByKcmoPSp1TctSq+POx+1dwtccpSbwdzwt1fCuhhTu/ORccaYAEf9jbCJgk4lKw7DKK4oVtM7aT/MsNxF2kcJoq7p5kgBB4wjAM2zbFYUjCo6W9QS5SqcdmZNU75KC/m7dlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHusVMPlMOeIB5bRrdZtlm6hN5dynhf/1iizSsjVBVY=;
 b=F2MwwHW0WaCDLzhxAPaZmiSL6ddcpEXjnodSyBeZ5RwhShueAX2l5Lbf+t7vLZrpbsc9FvZHkFN3b4KeaEenbsHpHHe15e7TsliVWYT/xvdmKcWTFkUR1CLhv4xhE4wJkitM7AKbcd+b3bdaayI8mKvfSBYR3xYoUiFzFY2zW+kDxMI/WRnBwWM5ypUYy836TUqHkwT2Y+IQFLphg30NtaYyFBgjGmMcQ93fslu4WoQo8r/6yDPxrJ8hV7pLbMVXa14oEwxmBYaotT97YYXnZzIoXdh+yd/pQB3upjoM56RwFwNNpLkLoJowBUtBfjY5nrOLMm+47Zax6Lb+JPxvOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DM4PR15MB6255.namprd15.prod.outlook.com (2603:10b6:8:17d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Tue, 24 Jun
 2025 20:50:56 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%6]) with mapi id 15.20.8880.015; Tue, 24 Jun 2025
 20:50:56 +0000
From: Song Liu <songliubraving@meta.com>
To: Eduard Zingerman <eddyz87@gmail.com>
CC: Song Liu <song@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net"
	<daniel@iogearbox.net>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>
Subject: Re: [PATCH bpf-next] bpf: Add range tracking for BPF_NEG
Thread-Topic: [PATCH bpf-next] bpf: Add range tracking for BPF_NEG
Thread-Index: AQHb5Sy2ZpOQRSfYyEOckGefD0bZJrQSsqiAgAAWTwA=
Date: Tue, 24 Jun 2025 20:50:56 +0000
Message-ID: <11CF7792-6165-499B-96E7-BF28BD74F9B4@meta.com>
References: <20250624172320.2923031-1-song@kernel.org>
 <96b5c623be2b07ecab82a405637c9e4456548148.camel@gmail.com>
In-Reply-To: <96b5c623be2b07ecab82a405637c9e4456548148.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|DM4PR15MB6255:EE_
x-ms-office365-filtering-correlation-id: 94aa12a6-bebf-488d-4d54-08ddb360d168
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cTdpanBvTS8vT2gwRElwSFFrR3VVLzdDeVlOcDRHOVMwL1FkNUdENTBkcGJE?=
 =?utf-8?B?VHV0S3lnaExWV1NVeC9xekc5Q1pyYkxPRU8rU3RTMGJjRmh3ZlNBQjI0VnRw?=
 =?utf-8?B?WGt6YU9ZaHN6UEhGaThvdVZuSWhvT1NqYTdKeFRSNUgrdjNnaVhjOXEvUmVG?=
 =?utf-8?B?UHRYZGg3azBvTmpRQ3VmN3U0OVEvb3NoSXNWZlNlNVF5WjRnWENGNVNETGdQ?=
 =?utf-8?B?dEFuM3NucDJNRDlyaFFWNHY1bkllL1Bya05EaTkrOVZuRUUwYTFxYit3Tzlx?=
 =?utf-8?B?SFMxazNSeWdyQzIyQlhnY3NEdHc5WExpc2tqaW5nYmZ4QzhMeDcvZ1g4S0Vt?=
 =?utf-8?B?NU1Kc28xSjMzWStacG8wWGJ2dmlEWW1CUXNld1RWZzVtOHRRY0JHZ0ZBMTFt?=
 =?utf-8?B?eEE0b2R2Y2srcm5namlPY3AxL2ZOSGZOY2w1eVRkS3lJRGZkQWpJOExvNVUz?=
 =?utf-8?B?aHpzUDZic0ZlNzRudmkyQmN6ZURNUFBkRGQrWmdsUURLaXNSOHloelRaYUNS?=
 =?utf-8?B?Q0lYaWhhajkwdnp1OVAzNm5zeVdhUk10WDVGeUtBaUUvNllndjRjNE5vSnEw?=
 =?utf-8?B?czNXNzhXN3ZGU2hkemJxTmQwOC8rSFZwVnI4VlVadStyK3hsaFBEQ09vQzB1?=
 =?utf-8?B?RTNIbTMwZ1NXbDFKek5jR29xRWNrR3kwcXFqemZjNDhZeWdkRTRoU3hVaWp2?=
 =?utf-8?B?c3liTmc2STNSci9MeG9FU2l6WnRiM3JrdHN1THdZTnN6TElLOUJxWUF5eW05?=
 =?utf-8?B?MVdTUDUranZtaUFLTVRtZjJEOE5FUC9yVHJBMDRRcDhGNmdNNENLZDFaU3VW?=
 =?utf-8?B?b21HY1crWFhsNjlwVnd4T1JkZzdLbDlaQWE0dnZxOUNVOE0vMFFKWGtFcEhn?=
 =?utf-8?B?eWNORHl0TVRXTkNpTnE5T0VjZ3VGSjJGSFVURkdiUXpRTXBTNVZBUnV4TjZw?=
 =?utf-8?B?U0NjTW83R2ppbEV1clRodHZvZ1VEa1VxZU8ydWl0WWI4K1JOaCtZQ0FYSVlR?=
 =?utf-8?B?K1RwalVVcUZtVWZBSGMrL24wZHZsQ1orK0t2QW5STDN1LzFaQnZVTkM1QkVV?=
 =?utf-8?B?M2dVUzZBcFZLbUwvUThEbjFSbzQvNzM5Y2pGYkdoK3FsNWQvaWt3NlpmOS94?=
 =?utf-8?B?V1lYWWxaam5DeDBRa005Yk05bEVGbExoMFJlZnN5QWJ4VjFKeHJ3a1hqYmJJ?=
 =?utf-8?B?NlR4Q1VFZHFmVUNMNStJUEVqN3pyQ05Nbm9iV3ZmL0U3eDczNjFyZDVSckU4?=
 =?utf-8?B?Tko4cVlFa0JPUDJSMkQ1K0pJbmFHa0E0Z3VLNzhPQUczNTB4QlZCZWZWajFh?=
 =?utf-8?B?YVNYc2FPWCtGdjBUQXZQWjF3ZUtpKzF6QUZ6Y1M3bDY5dkxld09FajVFbE12?=
 =?utf-8?B?VTdZUUorU2ZyNzlwSnU1elpHcWppTjdRUFdlNHN5OTc1TExJLzVVYVU5SFJM?=
 =?utf-8?B?eWxUN25VVjg0cU5nZFQrYzBUZUoreE9hWUNDUEhhemx6dXBhMkFFYTNjdFNQ?=
 =?utf-8?B?ZVdKRkhzQkxYUExoYitvTE12RENTTWxzb01qN2V3MmVWdXAyZkZGdUFOUkxt?=
 =?utf-8?B?KzYwdWsydS8wRTEvZldOT3YyMlJkMHJJbnFHejhIOGpNRDl3OStZcGtXcjZW?=
 =?utf-8?B?Y0ZlaEZoelBQZSsvaS9NK3hUL3g5cWlDVWVUSHlscUs2SDV1aVk4Skg1SWJi?=
 =?utf-8?B?eGdjTGFRRVVuck9IeVZYTDhyWnB1elNFT1hRNnhKcTI4SVlKM09hVkhHaTRP?=
 =?utf-8?B?Ykt3cHhHcFR6WlVoMDZuSEN1K0hJd2dBK3lXM0F5N29XTjExMVkvYWlRejVm?=
 =?utf-8?B?SjFlZEUyUXVwUUYrMWJCRlVtZjZJTjVERTRKdHk2V0ZtdXgvWEtXV3pkbEFC?=
 =?utf-8?B?RTc2d3lTMFRuWFFIcG1reDNKVDRDQ293dDdwTEJSQjZUbjR2MHJ0c2hIYVFH?=
 =?utf-8?B?M1ZlYkNQTEIweHozcy9RNGx1THU3NVl5L0tvVXU3NmVUVmxxUjl5MHNtSHF0?=
 =?utf-8?Q?T3tQeCAS70xqs2XmkntGDjSuiTBtJI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SUdDK1BZeE45UldkU3p6NUcrVmpjZjM4L2lOUWJuN0djNFE2YXRyTWNSblFU?=
 =?utf-8?B?dmJUQjdYVmI4MGpEWDBzR0JRQkpTSHEwQVBtTFFhVndqN3NaaHFNME5GVWNG?=
 =?utf-8?B?UXdjZXVTd0xtVHFGQU9NOHZFanlNVGZLOWM1Z2lRZmdwZm83QVlVbkdLTkVw?=
 =?utf-8?B?UkkvNHVhdlFMUnRhRnBKd3F0TXBzQlBpVjhVV0xNa2NPR09VS1JxdjFkTGE1?=
 =?utf-8?B?YmY0MjZuUXlJa0h2NGk1TTArZ1g0R2NzLzl2RW9vQlJvMHlRTDd4aGoxOVBV?=
 =?utf-8?B?WGFlaVJHU2xwaWtJTlVTMGNMOHJmbVE0dDZJYThZSFZqY3RnaUZycklmZXlu?=
 =?utf-8?B?eDJBdUFwSHkwNG5CRTNzRmlzMGVJZlZ6dWIzRDgwVVNxbS8xYmNjSngzOHFt?=
 =?utf-8?B?RkxNaEVPeG9YN1F1Z1A0bWU5OW1ldXJiSmNYKzR1WUNpZ0RkVEVqUCt4Tnhq?=
 =?utf-8?B?OHZjUXRNSGo1YTkxeGdCT3gvYnNrblZBdEtmdktoc1lBM2VsZ0VlNFoybzJp?=
 =?utf-8?B?ZkZBR3dKMWprcXZZc2xUUTlTZW5rbjU0dmphenpjRXp0VWhDeXp3ZHdmOUhw?=
 =?utf-8?B?aDZ4cU1TNVZud29oZFZJaEpadGVwdk0wUHdxcEtDYWpvelVjK3ZXZS8xeGo5?=
 =?utf-8?B?U2xVZmtwR0VwRFpCektrUisrN2Nmbk9oNHhPUHM1L0NIaEthK1hUQ2FlakUv?=
 =?utf-8?B?MFFsSHBmMU5yL3AyY05VamVDS1ZueHQ3cjdwSHl0L3F0VlZ0M21KdlRUUkh6?=
 =?utf-8?B?NTExZFMwbGhHb2RRUFRSR1gvSUg2VFNLcVdpWjJMQlRUbjFISGp3QmlLdm9w?=
 =?utf-8?B?TFhLWTJzVU9OdWhWVkxPWEw2aTlsb1d6b2RDVU5tOXpxamE1Z2JtcXo5VzhN?=
 =?utf-8?B?Z2JQQlVkZTJ5M29RaTZJc1VVRlJoeEc2VjdXcXJhWml3Ty9ZaVlpbm9na1FK?=
 =?utf-8?B?dFkrSlJPZkkyaXVCQzJpTmxYUlBQVHBiVG1JZlpTeGZEM3J4eUowU3ZIQlNW?=
 =?utf-8?B?V0hTZUFrcGYvdTFJSUZkNUlaS2oza2FHV0RkbVo1YjREeDZzWWpEMTllWkU5?=
 =?utf-8?B?eU0vcWRlU3JXNnBWOWN2RmxCSlE1MXVKYnVhd1pucVRjNEpROWhaR2tVNlhC?=
 =?utf-8?B?M2tkNTNMOThtYnIwUkxQODZyTXhsRGdVMXI0eHlCcHg1eWpQQ3FDNWpVV2lP?=
 =?utf-8?B?aW01ZThDSXFLVUw2SDdhNG9GWWJHaGFBR1YyeGpEUmZpQ3duYkJQQW9kVE1p?=
 =?utf-8?B?ZkIvQmRoZ1Viam0wbzhSd2pUVTVjRVZOT2R4a0t6UEJPTCtudmFPRzBqR3RS?=
 =?utf-8?B?bDMzL2d1OUZoSHpTV2VJRWZCNzhVWXVaeEV0a000SDhQbytTUWhuMzdrcW82?=
 =?utf-8?B?NWRqSlo4Q3crdktRMHZxYjlhWFZKZ2t4M1JVMDhnb0NXaEw1N0VHMUJWTFI4?=
 =?utf-8?B?dEpxOXluaEFsdjBsVStndW9QM1pvT05WVU5sMFRzcy8xWGU4eG1XMnFibjdG?=
 =?utf-8?B?aVFoMXJVMVh1QTlqeUdvQjV4clp2NjJya3lSMHpEZUNqOEl6a2RuazNON2RX?=
 =?utf-8?B?Zmd6WkMvV2FtZXZ3QXNRM2hGTDZjSmE1Y01TZ0o3bUlIMENKenJPS0JyK1Vn?=
 =?utf-8?B?My9qTCs1Zy9idFR3dCs3UlB5dm9tcW96RW9Za0QydWZETzRqN0JNNUlJMENQ?=
 =?utf-8?B?aUxpbzhQYmQ0QmFIL2FGVURDQ1gzVUxDUDJLeUpoVktSZXMzWTVpa296eVVa?=
 =?utf-8?B?dEVhaWZkN1FKWmltVEJ5cDlEak9PS0VUWTZyMm1SSEtKRXZYbGJvanF6M3d1?=
 =?utf-8?B?SUFjWjFrSVh4Z0ZMZ1pjZFFMZWpPUVUxZjBMNDU2NTU4U3hSZ0k0VUliOFQ3?=
 =?utf-8?B?TlE2TEN5TGozZTRDT0c4VVpZbUdXcXhmcVZJMUNRUTNUaisxV0lWT1gxUmpZ?=
 =?utf-8?B?NXlkbTc0N0pJVjkza3E5NWpFTklrMm1IU2xkd29DcUtyTHJqYkFvbnV0Q0VP?=
 =?utf-8?B?OUVVVnVRZnVGYWF3UnE0M0JNUm01SHA3WVhGTFpPSGRYOEFhVWpDTlpiSk9v?=
 =?utf-8?B?Vkh2YjFPbEZJbHRwai9lajlHSllPTXhadUhKQUZWY25HL3JYNXlnWkdzMmRU?=
 =?utf-8?B?bDVNb3U1TWlOTXlsdHNsdzVOU3BJblNOWkpBNVdJeFllN05vSFdQQkZPdXd2?=
 =?utf-8?Q?EFOhAv5RBmxoIVXgV+8rOrA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <67FC7423491D4A459D2C53FF0AB9D8C5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94aa12a6-bebf-488d-4d54-08ddb360d168
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 20:50:56.7964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8APWGfc0fVfhMgttyQp9bXJ260h28faABeAp0GctEgracWtZ6tCXpEOkbHMTiRRLqDlWq6BudEVF+VubIZSp4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB6255
X-Proofpoint-ORIG-GUID: w7zCE1p5r79SdAwgc86T0iEl4ogfvdoS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDE2NiBTYWx0ZWRfXwdQBdfgAUVF5 Eni2gqmuDvkoMsK68uer6AYCvgrywYhE8Xt90J5rmPhBkrS9ZS1DoNAUspXRghp9oqFiVKjLHcf +835O3NRkIwF99GdONLvWqShGU2tUlLfxKOPJUh3hSTEAQPPipmW+McWwa3jDQsiZIErn9yv7MB
 li8hZxGBSFZIvaZXjwm641OC9qEPBfv2AaOQi0ALEnSHLvzzm2tdgI392NRNu4Ko3iVhTH7kO9j m4wFS54zCdjfcGcfH2SWs8RFrLDKc2oOiOwrvesz1ePWbWVzaUfVj1g3hbjkwTZUES0eq3spCjR blW9FnSCskX2KINHlXhfUzZcPD+vnJdPotirTgiYgwduts/C3VEvxyw6ReK+Q+TwM8mO9dX3pLR
 x9Rwa+Ut3uizBcM8dKqpDos6LeIeCEx3Hot1GHe0qS45e8/CNDgWEa59uTtYC5FGTqRuBBO5
X-Proofpoint-GUID: w7zCE1p5r79SdAwgc86T0iEl4ogfvdoS
X-Authority-Analysis: v=2.4 cv=XKkwSRhE c=1 sm=1 tr=0 ts=685b0ff6 cx=c_pps a=ry3IMkS3Xyrd+17OzgfrlQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=2eHh0-lpp3fWPgj6YqEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_06,2025-06-23_07,2025-03-28_01

SGkgRWR1YXJkLCANCg0KVGhhbmtzIGZvciB5b3VyIGtpbmQgcmV2aWV3IQ0KDQo+IE9uIEp1biAy
NCwgMjAyNSwgYXQgMTI6MzDigK9QTSwgRWR1YXJkIFppbmdlcm1hbiA8ZWRkeXo4N0BnbWFpbC5j
b20+IHdyb3RlOg0KDQpbLi4uXQ0KDQo+PiAtLS0NCj4gDQo+IEkgZG91YmxlLWNoZWNrZWQgYW5k
IGJhY2t0cmFja19pbnNuIG9wZXJhdGVzIGFzIGV4cGVjdGVkIGluZGVlZC4NCj4gDQo+IE5vdGUs
IGJwZl9yZWdfc3RhdGUtPmlkIGhhcyB0byBiZSByZXNldCBvbiBCUEZfTkVHIG90aGVyd2lzZSB0
aGUNCj4gZm9sbG93aW5nIGlzIHBvc3NpYmxlOg0KPiANCj4gIDQ6IChiZikgcjIgPSByMSAgICAg
ICAgICAgICAgICAgICAgICAgOyBSMV93PXNjYWxhcihpZD0yLC4uLikgUjJfdz1zY2FsYXIoaWQ9
MiwuLi4pDQo+ICA1OiAoODcpIHIxID0gLXIxICAgICAgICAgICAgICAgICAgICAgIDsgUjFfdz1z
Y2FsYXIoaWQ9MiwuLi4pDQo+IA0KPiBPbiB0aGUgbWFzdGVyIHRoZSBpZCBpcyByZXNldCBieSBt
YXJrX3JlZ191bmtub3duLg0KPiBUaGlzIGlkIGlzIHVzZWQgdG8gdHJhbnNmZXIgcmFuZ2Uga25v
d2xlZGdlIG92ZXIgYWxsIHNjYWxhcnMgd2l0aCB0aGUNCj4gc2FtZSBpZC4NCg0KSSB0aGluayB3
ZSBzaG91bGQgdXNlICJfX21hcmtfcmVnX2tub3duKGRzdF9yZWcsIDApOyIgaGVyZT8gDQoNClsu
Li5dDQoNCj4+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3Mv
dmVyaWZpZXJfcHJlY2lzaW9uLmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3Mv
dmVyaWZpZXJfcHJlY2lzaW9uLmMNCj4+IGluZGV4IDlmZTVkMjU1ZWUzNy4uYmNmZjcwZjhjZWJi
IDEwMDY0NA0KPj4gLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL3Zlcmlm
aWVyX3ByZWNpc2lvbi5jDQo+PiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJv
Z3MvdmVyaWZpZXJfcHJlY2lzaW9uLmMNCj4gDQo+IE5pdDogdGVzdHMgYXJlIHVzdWFsbHkgYSBz
ZXBhcmF0ZSBwYXRjaC4NCg0KQ0kgZm91bmQgdGhhdCBhIGZldyBleGlzdGluZyB0ZXN0cyBuZWVk
IHVwZGF0aW5nLiBJIHdpbGwgaW5jbHVkZQ0KZml4ZXMgdG8gZXhpc3RpbmcgdGVzdHMgaW4gdGhl
IHNhbWUgcGF0Y2ggYXMgdGhlIGtlcm5lbCBjaGFuZ2VzLA0KYW5kIGFkZCBuZXcgdGVzdHMgaW4g
YSBzZXBhcmF0ZSBwYXRjaC4gDQoNCj4gQEAgLTIzMSw0ICsyMzEsMzQgQEAgX19uYWtlZCB2b2lk
IGJwZl9jb25kX29wX25vdF9yMTAodm9pZCkNCj4+IDo6OiBfX2Nsb2JiZXJfYWxsKTsNCj4+IH0N
Cj4+IA0KPj4gK1NFQygibHNtLnMvc29ja2V0X2Nvbm5lY3QiKQ0KPj4gK19fc3VjY2Vzcw0KPj4g
K19fbmFrZWQgaW50IGJwZl9uZWdfMih2b2lkKQ0KPiANCj4gTml0OiBJJ2QgbWF0Y2ggX19sb2df
bGV2ZWwoMikgb3V0cHV0IHRvIGNoZWNrIHRoZSBhY3R1YWwgcmFuZ2UNCj4gICAgIGluZmVycmVk
IGJ5IHZlcmlmaWVyLg0KDQpJIHRyaWVkIF9fbG9nX2xldmVsKDIpLiBIb3dldmVyLCB0aGlzIHBy
b2dyYW0gaXMgc28gc2ltcGxlIHRoYXQNCnRoZSB2ZXJpZmllciBsb2cgaXMgcmVhbGx5IHNpbXBs
ZToNCg0KVkVSSUZJRVIgTE9HOg0KPT09PT09PT09PT09PQ0KcHJvY2Vzc2VkIDMgaW5zbnMgKGxp
bWl0IDEwMDAwMDApIG1heF9zdGF0ZXNfcGVyX2luc24gMCB0b3RhbF9zdGF0ZXMgMCBwZWFrX3N0
YXRlcyAwIG1hcmtfcmVhZCAwDQo9PT09PT09PT09PT09DQoNClNvIEkgZGlkbuKAmXQgaW5jbHVk
ZSBfX2xvZ19sZXZlbCgyKSBoZXJlLiANCg0KPiANCj4gTWF5YmUgYWRkIGEgdGVzdCB0aGF0IG9w
ZXJhdGVzIG9uIDY0LWJpdCByZWdpc3RlcnM/DQoNCldpbGwgYWRkIHRoYXQgaW4gdjIuIA0KDQpU
aGFua3MsDQpTb25nDQoNCg0K

