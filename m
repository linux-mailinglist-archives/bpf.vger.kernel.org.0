Return-Path: <bpf+bounces-61442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9166FAE7172
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 23:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EFD41BC36FA
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 21:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE5B23BCF0;
	Tue, 24 Jun 2025 21:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="hcbZvYjR"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7603D47F4A
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 21:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750799782; cv=fail; b=HeK8RB9QkBi2Faw95SRXjoHJ5gp0mDskvJ1DCAQS5JrMXH8PB5KEaMDYI926VCd/qBB0V6AlDF73Lmp93yxM2mQNEnRSr+8/byeSPZcx8XLGHTMr1tpd4PPQVmcen0GOiQXVCtSpoqVZmcMOWfZoPZVB70f2Dc0rALUjR5T7N7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750799782; c=relaxed/simple;
	bh=Hfnr6aUNi8phVO+QudpE/lOKH+FeK87Zz/mr61IaIDI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t7N+gBS/qPRYIANd3dmPTTNrq3m6+p4n+XZXZj9kRTCeVoKEjArXHZluv+14rMDyu7+hxsdeUtrzQOBPobtE2TeUG6WhQorEgcJF1mFW0jvu+IsGXetdQeOpr4ua0GuKV37MSGwnftCzJI5gFK+9VB82GiLlUnnlr1Gh3FndaGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=hcbZvYjR; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OKqI8I002790
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 14:16:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=Hfnr6aUNi8phVO+QudpE/lOKH+FeK87Zz/mr61IaIDI=; b=
	hcbZvYjRCjCoZBmm9mxGCXQbnXKOY9nPneOl5hGWFet6aLQOeBODQh604LAOvGyk
	uaDVODX09KoKpr1gsC/Yld1r15m7NobZtH57lBqDWfY61gPrAUfpRheJLr1w59jl
	Idmvm3WZMQe4G5KyIWfT1WMPEfGNraavyYwaAZiAAdTbqfqIERJFOm+0+wRJFUN+
	ClpTC34AqpUFboYaChkpgl42W04QznVuf08R8scRrTLdnaJXE37PkPz/EpqGiB+d
	gZ/JvNO8TF69v9GyLuxIh/9ptOe+UgoNf+wSeEbfjkKueAG3hV841EevqKuNcuPn
	HePQbMZ+lvax2IydR7tGeQ==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47g00e9yw8-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 14:16:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MSuJiTlZyXEd4nnw7Qzqfma70ogbJuUfu4KL06y92wQVVK6xdBTQKTE2HIQ4B86yZZU+jP3N5ER1uH8sHNoIwmqE51bhsVcFfWSXzY4kyhQDCY5i4sIfrVW/QTUKRMyjQ14rjvLEDd8WSFv/5rFiZhDhIh5sBeUjcATpF+uIamH5q96GX2zYwCEgIZ50/sam2HOT2YevAhyXjJrZS1rZhurT+Z+pv0zz6Jna5lzAr5WIFUeT0X4plx4yc+Ptm2Fgz6xfGQmcfsUBve5v4Pud0bD9M+9DlnnEChCA0kjmR/fDvn7Vz+nNDdCPUiVeSjBUWxQsZWA5xrxYV6P20+v7qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hfnr6aUNi8phVO+QudpE/lOKH+FeK87Zz/mr61IaIDI=;
 b=UTospjX8yNpDM25117iJSVwrd2yUuAXDds4JHdZ6KM7g/so9C0SLaSPXhixrVgkbSDD0sgg7dlVK7EvZZ/aYi+Rd0i/40Cx2sxCZIiVkjpPlYRfdC8ZAtDPw+nb3E4aU+kOpAKTRBDKlMzKqOU0bcwwCaHc41ZsxfAyhwUexdNwdaFga81478/7G/o/yoH+9YMZzxgFnd6hWQ9PCFVQr618YUo1BlDzyQN+QuRS2t/Yb1RS+MegjWQwrtxpxpLr/0nnNO2zCP5S6oPCVZnPgfwpUGxyKrwMT0RuRDw5pqeGloCt/xvQfHw64rPwGc28b3X6cqgALdG/faVZvycc5Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA6PR15MB6663.namprd15.prod.outlook.com (2603:10b6:806:41a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Tue, 24 Jun
 2025 21:16:16 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%6]) with mapi id 15.20.8880.015; Tue, 24 Jun 2025
 21:16:16 +0000
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
Thread-Index: AQHb5Sy2ZpOQRSfYyEOckGefD0bZJrQSsqiAgAAWTwCAAAK3gIAABF0A
Date: Tue, 24 Jun 2025 21:16:16 +0000
Message-ID: <9A0410EE-CF87-4FBE-8ECD-44723156BE34@meta.com>
References: <20250624172320.2923031-1-song@kernel.org>
 <96b5c623be2b07ecab82a405637c9e4456548148.camel@gmail.com>
 <11CF7792-6165-499B-96E7-BF28BD74F9B4@meta.com>
 <4be25f7442a52244d0dd1abb47bc6750e57984c9.camel@gmail.com>
In-Reply-To: <4be25f7442a52244d0dd1abb47bc6750e57984c9.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SA6PR15MB6663:EE_
x-ms-office365-filtering-correlation-id: 83b5a966-93ce-4983-209f-08ddb3645b34
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?akJockZUUnJGZFMxdVFmcDROOFJmQ1gycG1QSW1zWjc5Ymorbm9ndk9pdzA4?=
 =?utf-8?B?R2ljT3VqbUFrV0NWUS9mUmxsMEJSdi8yTEU4emdhYWhtcEk5akFWVVJVZWI0?=
 =?utf-8?B?RG5lTlVEakFPWUxWYlRkSzlnU2llL090QXBVaUI3Wjh3RDY0TXd1M0ZFWEpu?=
 =?utf-8?B?L2luMDZENVFDdTh4djR4SE5xVks0WVI4aWZtaXlpcndITlNpSGsvMzh5WVBQ?=
 =?utf-8?B?V1hVc0ZNeXV6ZVZQTVdWSDM5VFJReHpRdDYzdTFXR3ZPTnc2MXJhR3NVZmZj?=
 =?utf-8?B?RVN1VG80WGEyVjRWREVFWmZzTGFCNGR2NXg2M29kZDFoZU1FMm9aWjNrQitI?=
 =?utf-8?B?SWlZaWhla2ZpVG1OOEhZTjBLekxNLzdOaU9VUzJkTDhtdk1kZURUR1VrYkJk?=
 =?utf-8?B?R2k3QmQrbUhKclArMHl3VVBnSXUwSytvaEpDTG1oNE5iMFpXQmhsbjYzZUh4?=
 =?utf-8?B?OSs3Z1hKSGh0ZnYwR09ycFNiNzJtd0pxM2syOU1oa2ZGcU1UY2hyNTBHTnAv?=
 =?utf-8?B?VFEvVTBhOWFpaFAwTDVhNHIxbXR6QUZIWm00V09QK3pXYWhhYXYySUpVV1Br?=
 =?utf-8?B?Q2pyV1RaQjRkZEluY1h0MEdtUnljMGZ2cTdWNittZmRSYTNtL2VCMlFCVjMw?=
 =?utf-8?B?a3RQbVVuNVpsclhpYVR6THM4akY2OFFSbVhPeGIzbHVoMGlFS3Z5OE5nSXlO?=
 =?utf-8?B?cVB6SU5mNGV1SFIrQzZHU3VjaEQ2WE4zQzNPMlpIWkRUTkdELzRGTDkyU2cy?=
 =?utf-8?B?RGpkOTZhMTVNSUladlhXVTR6c3VzOE5KLzV6MmJUSjJxSXN2UyswcTd5NUFv?=
 =?utf-8?B?bC82bk1VVUtCakNXWDYwQ296TEx1STZSSU8vRGdyL29Fcnp2dVlZdlAwaGlZ?=
 =?utf-8?B?WEo5cDY2Y0grZVNvZmVXcmVUd2szMFV5QTdsNkdKSDNHTHBTUHMzbDRkcGI1?=
 =?utf-8?B?NE01OFEvQ2RFVlg0MXFIQ2ZEN3dvVzJ2MXZ0aW1lZERDSVE3aTBpdGVSOUJU?=
 =?utf-8?B?SENxOGthb2MyMXJSZ0ZNL2l4Snl4MHRhdlNZR2hTS3hITlZQSmlqVytBdXhK?=
 =?utf-8?B?cHhzWGw0cFdBMG9XWHpWdEE3cFpaSTYzYUxOaldJNGRFOGNqZ2hhSm5RdGVM?=
 =?utf-8?B?MU1ZKy91b3RYbWYzM3dCR2U5L1BTZEFEV3R2RjkrdjhxTGRDeS8xMXVSL2Jl?=
 =?utf-8?B?Uy9yWmFNWE9zb3dzcW5DT1RsTDZjb0dFVisrVnQxZEM3TFlrUmN3M2kyRG9w?=
 =?utf-8?B?TEl3ekVyWFhSWDJIMWIwSFRIT0F4M3FlcjVBZVkxUWtDbVdDSTJTUHdYYTBB?=
 =?utf-8?B?YzB3UXhGZnRwVHM4alF5N3RoU2hzMWZsNWtZUElsYytKRSt4ODRwSzBUZzRX?=
 =?utf-8?B?UVlaUSs2dEIxa1gxUUY2ZmJQZkRRZnVKSjQvMWM2Y0xZeEVsamRlakRJY3R1?=
 =?utf-8?B?SXgxTkZBZ1h4amZCVHo5azQ0ZVM4cjIzdlRSNEhBb1hiTWR5TENjUVdpci9F?=
 =?utf-8?B?bVczblZScy9qSlJTcDRmMGZRYmhKRWZWdWc1Q2N0Z3VCZHdCQmJoRXZDRUpT?=
 =?utf-8?B?b2Z5REExTVhCL0FqT2RNb2hwQWZPeE9QV3V0d1plUnNWaEFiSGdnWUg5Mkkv?=
 =?utf-8?B?Tk14SGtVYnF6NkhlRDMwL29zMmY1ZThkcHJTT2R4ZFg0Y0hUZ1JmcEJ1bnlX?=
 =?utf-8?B?Tks0TDFROGY5cU02bFhZTjE4TjNwazkwU1pGZWdwN0xFcTdtSjhlRXAzbXNk?=
 =?utf-8?B?aVE1MnNrMzluUzVIQzA4TTZmSFFaT1pzOGF2Z2lzb0hjSDRYTm51V3FLVzJi?=
 =?utf-8?B?TXo2QXFSMEZZMnc4V0M5QTRKdW0wd21wTnVha3J0K1BHV1BnOFlWOForNmpR?=
 =?utf-8?B?bHoxa2FsL0VNRDVueXErOVExV0E3UmZsS0hzbUxadWEzSitKK1NYcndYQ3l2?=
 =?utf-8?B?R3lJQWFGVE1ianpyRlFlSjlVcHpzYkZQeFNHM0dvSk1pUEI1dTA0czljNXA4?=
 =?utf-8?Q?VRopT3rRDFScj4wzIN8Ahf5kpO9sKc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MithVTd4MEwrOTlRVFpGR3l6a2JwNDRlTXFLSnZmc1NDNTNUN3R4RWFCb2hH?=
 =?utf-8?B?Q1ZpTVd2OXFYc2pmaWxIN2pmUDBUTTNmTExRQlExbGhvNnBXSWVQakt2eXln?=
 =?utf-8?B?TmVwWjNrSWRpNitBQzV4WnlHNjZodGEzY2ZKNHhENnJzQk1FTXQzYWsyRnd1?=
 =?utf-8?B?R002cW92VExFa1g3MlphSW5IVWNleHpLOS8yL29EVThVbDdmeUFGTXphT040?=
 =?utf-8?B?UHhKVnZrTE0rTUI0OEd4dUZQdXJSeURJamVZWkRUYTZyV3FUR2UxaTdwMjJC?=
 =?utf-8?B?Uy9MeHhpVjJ3MHNaQVMrNE9LS04zV2dLV1gvcVVKNWErUzhJTjVIdmVuaXBW?=
 =?utf-8?B?R0ZrRVFrTlhEUXBRMW5NdzZjSlo3ZzZtUjNiSmIyaExnczMzZGNwdkVyUER0?=
 =?utf-8?B?QldvRCtjUmZ3WTZPa1NsQzVTTkF5RHNMRjU0aWw1YVplaldsUUwxWXY4OUw5?=
 =?utf-8?B?K3E4YTFFQVRtRlRURVR3Ky9yaGhWNXg0NVpqbVBwUGw0enRJTEdPTDVDWE9C?=
 =?utf-8?B?Nnk2dWdQU3I0ZWFiM2VlSGtsc2dyN1RjQ3czcHRrNzEwcWZ6OHpBNXZzNGx0?=
 =?utf-8?B?M2cwU296YW5ya1FxNVVta0htUERWY0lHV1dSOVREbVNpM3AzKzAxMXBzOVdj?=
 =?utf-8?B?aDZUeGdvQW9tTjJhdnUzTGdIQTFwSWpWMzIwTDZ1Q2lvOW95Q3BJNktPa0l5?=
 =?utf-8?B?dkR3MGd3OE4xYm13MENURDNtSXArVHk3OEtXTjJQVGFrTzhDWmhCYWY4WXg1?=
 =?utf-8?B?NGVIcERRY1N5SHJmZ042K2wrREc4bGQ0WWcxSlBBZ0h5SWVaOHJDaTBvNjN5?=
 =?utf-8?B?WFJWNDhuVXV5N0tLK2tNeFNVTWtsZWh6aTdZSjVnMUNpRE9CcTZCM1FpVjh5?=
 =?utf-8?B?NVZHS01HSDNEQkNnSUk5N0RqQ1V6aVF2dnBXUEhyOHRhRTZLMVM0Z3Z0YkNY?=
 =?utf-8?B?WjQxVjljUU5vT1l2cVZsT0hkcXZVWDZTbHNMZ2JVRldWQmV4ZUttdk03VGV0?=
 =?utf-8?B?cjBOMm9TYVB1QUZHQXZpckx1U1phekh4M0gvOHp1TWFqcjVkRTBHd3hxdkp3?=
 =?utf-8?B?eDB6Z09DNzQxSWdDYkJzdld0Rkg1NGxhMG85UGZ5UTlxdC82bXpyTXltTTRO?=
 =?utf-8?B?NE0ybE01ZHFEMnVTQVVzVGVQT3BZamQxV0VSd05UQ0ZjdWtsRHlYdFFYek5S?=
 =?utf-8?B?bTNHcDc3b01mRFJDbnF3MWhBT053TzRQR09iTkdVNkswaGxKRklTK05Ic0pk?=
 =?utf-8?B?NlMwWFFpejhNcytJcmJTMlFsV0tQNVVmazkzRUNmejhYc0g2Qk5TQnVwRG9v?=
 =?utf-8?B?amtObVJvYlBlYUNxaEVwTUN3NWt5YWtQT3NlSjczaUx0VlY5Y0xtZzRBM09L?=
 =?utf-8?B?a0ZiUWtYR1hhWEdkSmhLbDJDQzZPZjNDazI1a1AvSXZ2ZGI1eXBEeUlnWFkr?=
 =?utf-8?B?M0VwQ0VDOE1TTWxhUXFhK0xpTVlQSEJLTUhzN000SGlnZ1N3RGZReGxOdm5D?=
 =?utf-8?B?UnBGNjdtYjZoa2UyYWw5SGRWSkdrWUFSZFVscnV0dVc2STBjUEMxVm1lRGdN?=
 =?utf-8?B?QVRpVkxVRGYrTERtbXBVTGw4WmVENmd1TkpNNEpqZEtWTWZ6UW1HalB3L3E1?=
 =?utf-8?B?eDc3QTRWclBSYWE3YjBrd2VwTXlFY3JUSEM2cnN4UHljTDhMSWZPV2h5UUNO?=
 =?utf-8?B?NE9GM3JVTHBGQ0VlenkxNTI0NU1TUXFzWHNURVJZTGlPbDdqTnBncGRxRU9T?=
 =?utf-8?B?SkxGd0pHTXd5TWs3Znk5RC9Fa2F1TVpsOEhFRVFzL0RnZVl3VmN6WlpvRERt?=
 =?utf-8?B?cHFhL05iL0J1a2lOUTVaUVNXeUZsUmRLanE5SHpXc3NlTWF0NzhsQm5RSWNT?=
 =?utf-8?B?cEJjeG5Lbi9mL2s3M1RmSW9ua2dBNVRtRnlGRldGY0g3QTF6ZTBNVzl5cmRN?=
 =?utf-8?B?dy9LcXhKaDhvbUQvMy9wQ1dmSSt3dWJQRmFWa2xDamxjL3hRWVRad2tOQkE5?=
 =?utf-8?B?STZPYjJ5M1pXWHVSVnZ0M3pvcUxDN2FYcm4wVkRvSzNXc20vZzg1U0NaSUd1?=
 =?utf-8?B?VVllS244R3F4S1c0NElCeDlqSFpnODZ3VHRTUjBRWTVTOFZydzNRSUhKUHM0?=
 =?utf-8?B?Szlpb3NPVldJQlBoNDlsbC9TUW9JUFJqZDUwQWhqbE1PcWk3ZlFPY3FacVhi?=
 =?utf-8?Q?A6H+QgEa2jE9VFHshUZN+zU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A28503DBA655248B61B52CBFB31291A@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b5a966-93ce-4983-209f-08ddb3645b34
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 21:16:16.4514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cKa+8iGY0kDJUPDSaDPQTJmgmB4Xh0OIkO0nACPo0jrzyKPisU2WHbvKSNqO6qv1IG0mLRkXEiINWk9BgQx/RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR15MB6663
X-Authority-Analysis: v=2.4 cv=aaxhnQot c=1 sm=1 tr=0 ts=685b15a3 cx=c_pps a=JdlQBdRp28aqpLEMyktm7A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=AMiEKIR2ZuffMduIeUgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: elju4Ywcoc4MKUAEUJ4gyqq_X_-6Uwfa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDE2OSBTYWx0ZWRfX9KXzaWCU7J6R vGB4W7bBWeJHJFVTjUI/hE6FLFb1W/TEQslyfE/RHW8JIvKTzW9kOG38q9NYNXU7Kh+yf8/AMCX h4yd6J/8G9M47dznJVDsMBQcsDab3CIGPEOZmUVqe2Bw4M/qeNfsGxaKWnn/p9Ka1P+siXzCB2x
 g301TbCWp+yzGlycahKuONap+5p1yUV9iMefA7Kh6WHQAb/IEOTw8gONe7L6KDruAOlrKPd2N+9 KDEbL0TuFbVTlBeFsvZilMRRZ5npCUDR0lhR8xLfvWi3B+L2S075cGOzupc/IYfDRttMmA/nyre 6Nzk2sZcpJIFsjuq4HsXEVQFdx/lQkFnaxko8QBlcqg7erbnb9v31cGtCdDURF12Z6TO/umU5QJ
 zQqLiXIT+RAbWWYhpujQZME0208CRe1/OTCn5cXIV4dgM/mpo8fUKjOsyF0BkhQlVaxU8p/D
X-Proofpoint-GUID: elju4Ywcoc4MKUAEUJ4gyqq_X_-6Uwfa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_06,2025-06-23_07,2025-03-28_01

DQoNCj4gT24gSnVuIDI0LCAyMDI1LCBhdCAyOjAw4oCvUE0sIEVkdWFyZCBaaW5nZXJtYW4gPGVk
ZHl6ODdAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgMjAyNS0wNi0yNCBhdCAyMDo1
MCArMDAwMCwgU29uZyBMaXUgd3JvdGU6DQo+IA0KPiBbLi4uXQ0KPiANCj4+PiBOb3RlLCBicGZf
cmVnX3N0YXRlLT5pZCBoYXMgdG8gYmUgcmVzZXQgb24gQlBGX05FRyBvdGhlcndpc2UgdGhlDQo+
Pj4gZm9sbG93aW5nIGlzIHBvc3NpYmxlOg0KPj4+IA0KPj4+IDQ6IChiZikgcjIgPSByMSAgICAg
ICAgICAgICAgICAgICAgICAgOyBSMV93PXNjYWxhcihpZD0yLC4uLikgUjJfdz1zY2FsYXIoaWQ9
MiwuLi4pDQo+Pj4gNTogKDg3KSByMSA9IC1yMSAgICAgICAgICAgICAgICAgICAgICA7IFIxX3c9
c2NhbGFyKGlkPTIsLi4uKQ0KPj4+IA0KPj4+IE9uIHRoZSBtYXN0ZXIgdGhlIGlkIGlzIHJlc2V0
IGJ5IG1hcmtfcmVnX3Vua25vd24uDQo+Pj4gVGhpcyBpZCBpcyB1c2VkIHRvIHRyYW5zZmVyIHJh
bmdlIGtub3dsZWRnZSBvdmVyIGFsbCBzY2FsYXJzIHdpdGggdGhlDQo+Pj4gc2FtZSBpZC4NCj4+
IA0KPj4gSSB0aGluayB3ZSBzaG91bGQgdXNlICJfX21hcmtfcmVnX2tub3duKGRzdF9yZWcsIDAp
OyIgaGVyZT8NCj4gDQo+IFRoYXQncyBhbiBvcHRpb24sIHllcy4NCj4gDQo+IFsuLi5dDQo+IA0K
Pj4+IE5pdDogSSdkIG1hdGNoIF9fbG9nX2xldmVsKDIpIG91dHB1dCB0byBjaGVjayB0aGUgYWN0
dWFsIHJhbmdlDQo+Pj4gICAgaW5mZXJyZWQgYnkgdmVyaWZpZXIuDQo+PiANCj4+IEkgdHJpZWQg
X19sb2dfbGV2ZWwoMikuIEhvd2V2ZXIsIHRoaXMgcHJvZ3JhbSBpcyBzbyBzaW1wbGUgdGhhdA0K
Pj4gdGhlIHZlcmlmaWVyIGxvZyBpcyByZWFsbHkgc2ltcGxlOg0KPj4gDQo+PiBWRVJJRklFUiBM
T0c6DQo+PiA9PT09PT09PT09PT09DQo+PiBwcm9jZXNzZWQgMyBpbnNucyAobGltaXQgMTAwMDAw
MCkgbWF4X3N0YXRlc19wZXJfaW5zbiAwIHRvdGFsX3N0YXRlcyAwIHBlYWtfc3RhdGVzIDAgbWFy
a19yZWFkIDANCj4+ID09PT09PT09PT09PT0NCj4+IA0KPj4gU28gSSBkaWRu4oCZdCBpbmNsdWRl
IF9fbG9nX2xldmVsKDIpIGhlcmUuDQo+IA0KPiBXaGVuIF9fbG9nX2xldmVsKDIpIGlzIHNwZWNp
ZmllZCBldmVyeSBpbnN0cnVjdGlvbiB2aXNpdGVkIGJ5IHZlcmlmaWVyDQo+IHNob3VsZCBiZSBw
cmludGVkIGluIHRoZSBsb2cgd2l0aCByYW5nZSBpbmZvIGV0Yy4NCj4gRS5nLiBzZWUgdmVyaWZp
ZXJfcHJlY2lzaW9uLmM6YnBmX2NvbmRfb3Bfbm90X3IxMCgpLg0KPiANCj4gSWYgdGhhdCBpcyBu
b3Qgd29ya2luZyBmb3IgeW91IGNvdWxkIHlvdSBwbGVhc2Ugc2hhcmUgYSBicmFuY2ggb24gZ2gN
Cj4gb3Igc29tZXRoaW5nIGxpa2UgdGhhdD8NCg0KQWgsIEkgd2FzIGFzc3VtaW5nICJ0ZXN0X3By
b2dzIC12duKAnSBpcyB0aGUgc2FtZSBhcyBfX2xvZ19sZXZlbCgyKSwgDQp3aGljaCBpcyBub3Qg
YWNjdXJhdGUuIE5vdyBJIGNhbiBzZWUgdGhlIGxvZy4gDQoNClRoYW5rcywNClNvbmcNCg0KDQo=

