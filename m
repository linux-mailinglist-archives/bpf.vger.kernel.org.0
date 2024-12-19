Return-Path: <bpf+bounces-47363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4099F87A7
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 23:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B74DE163400
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 22:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDBD1EE7A9;
	Thu, 19 Dec 2024 22:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="a6wzVQ3R"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9001C5CB6;
	Thu, 19 Dec 2024 22:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734646487; cv=fail; b=WHEE+gxAMAzN9VWnLAnOKrCsKq5RTGNP5uVD8JsDhgmC+BMfpYFFUHYmAT2V7wKh2dcgIF/5GUT1u1dj+CPMbs/0U9k8YfLZHqRZsbXe2CkSHwZprf0XpLFJepxf4I/0esQos1L6Z0Z7fDNvM83+fgFrFd7NsVcBuaBHL+2JQjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734646487; c=relaxed/simple;
	bh=r7nI+X9ShMGkdm2IyQ8Pv/jypEj+D0Hrz0tdD2tJ1EQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aTwMO9gvwyLR6NSnmpurkEgWeHDyoaSYGzCU9yoo4OJti8VCBPO+9bo3Ad2P5ZQZHRxJVjCmv9yt3+HW1fySIi0SXCB0pICDp777/m7+C+HzSMN0XtC1EHusouNU9+SxpSD7ZJFh/aSfi+u5P7KkOCg/wVVvTBwdoANAfXPrGBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=a6wzVQ3R; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJKkQKq007824;
	Thu, 19 Dec 2024 14:14:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=r7nI+X9ShMGkdm2IyQ8Pv/jypEj+D0Hrz0tdD2tJ1EQ=; b=
	a6wzVQ3RXRTv2hDy+pmu1oS7SXJRMaWzHqojujjefZ0M3KHYh81g1vW1/6y+HYSX
	IRrejlLnifRtgoH0TOsi6yz5/rQ5fYCsCriKD3uStVmyWU4Ph1W4MFNzjGkB2E74
	qfys6vkxWi0NrJdCiy1evlHqZTsVGax1kp/UsCmNwLV+fexo8ACBOXd9bAWlChLP
	eC+PhyIilvCzc7MSk5bI94PWFAoQIb7v1CFqiIhnvwpCAt2+rTLyyytVPc19KLef
	yQtjhPb91N5Me4hUwfeNMbAsBCt+Bpf7rlUo+AbopYSMGLkpx3dkJm0/aD3xQUoV
	TO93papEpsKx6oiinZnD8w==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43mttr0hh4-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 14:14:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7UfD1ymdona6UowrTVYeSynCVMndM6TeUNEDSIC8CCOpoJuAJzH+o0GtdZ347skvoHB5QAEqZGk8XN47D6m5sAn7qJx3spxWZntr4KFPbO6AnEVe5l9yUmjKpJMPFyMj3byMuMqDSQkgwpuoh52k7bKJ9mNhLIL2GhOinLH43wlgRKg26v1Zf40da2LvQ1KKOlKLDCeFVHH7elUyOVZKa7VM5NJUimvIVLfcCv/T/OZAJXMxb7VxusjJPMegEK5vil5Zviv3VZtTW78MpP2cpBdCtY5bf0Ap4y4lz2t3cFmb2AvD0o21KSHG4nPMQGi/ItRaGCofaLzK4fnAyApcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7nI+X9ShMGkdm2IyQ8Pv/jypEj+D0Hrz0tdD2tJ1EQ=;
 b=h5njp4BLQM5Q8qFB8peYRpqQNVoRRFuvXjld4lUQ4ud1wZMYSNotV+/ISks3t4SlaBGp4IENvpRvESoHNi8omEYo0NoiQCbZdeJ4LpW5ymiCzNhlxLOWhyWBUi+uYJSLybcOJXFg5r+meSRQlv9IxpsGY2w1RZc4x0hRq/eZecPy6uxqUnFNbicfGFry2sAKLVkSx0PyNBrLhnpraRV2mPg2UwVYemsyWObjEEzp27VWD7xuzMXPsgFNltXRGVgzbU4W4lPg4OOO+rkyfnHF+KHtjJxnWT1Hw3CCatj/JmDJaTJPqZ75M++PhP8HUsI2Fr3pzOE4FevqTvfupfvWgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by MW3PR15MB3851.namprd15.prod.outlook.com (2603:10b6:303:4f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 22:14:41 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%7]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 22:14:40 +0000
From: Song Liu <songliubraving@meta.com>
To: Song Liu <song@kernel.org>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "martin.lau@linux.dev"
	<martin.lau@linux.dev>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "mattbobrowski@google.com" <mattbobrowski@google.com>,
        "paul@paul-moore.com"
	<paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "memxor@gmail.com" <memxor@gmail.com>
Subject: Re: [PATCH v6 bpf-next 0/7] Enable writing xattr from BPF programs
Thread-Topic: [PATCH v6 bpf-next 0/7] Enable writing xattr from BPF programs
Thread-Index: AQHbUlQ2GKQTboBWcUC7ohlBEL3wN7LuIhWA
Date: Thu, 19 Dec 2024 22:14:40 +0000
Message-ID: <6072BD6D-6DB8-485A-A7D4-3E790488E0DE@fb.com>
References: <20241219202536.1625216-1-song@kernel.org>
In-Reply-To: <20241219202536.1625216-1-song@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|MW3PR15MB3851:EE_
x-ms-office365-filtering-correlation-id: f045c595-6019-4be7-a943-08dd207a88b1
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y1orTkFubk9hNVB6T3ZueXMwa0FHRXhtanhuWnVnek5BaEtpM2JCU3pMZjY2?=
 =?utf-8?B?cnl2WC8wcFZKS0ltNFJxd1ZSeUE3U1U1RGpubnUwZVhDMkZZRnh1WkRWM3lw?=
 =?utf-8?B?aHpsOVY2VVlEZ1hYc0NtM1NlUEdNNk10cW00MXEyOXBsclp3WHZZcXlFTERS?=
 =?utf-8?B?YWhJcTVKUFJQNy8vYVF2OHhRMWhRSFhST1NoZ3hSQlQyN0ZhbzlVZ1k0Ri9U?=
 =?utf-8?B?eStvZlBKVzdodzJQQm1oNzE3MldEYTRoTkJYUWdiVzRJK0xhcnJtNHkvUWZt?=
 =?utf-8?B?RXA4cU9oR29mODJQV0UzZlNoQURQTXJzUkRhOUUwN1RjOWFDczloT3ZnOVdD?=
 =?utf-8?B?VDVCNldXZEhpUEF2WlVmbm1hVlJPZTY1TjQ3T2V4RjNXa0FPUG1kb3hLQmtw?=
 =?utf-8?B?RjNSK2pWTWNxeUdjWTU3N29uMTZJVDNlSHBRVGp3MWlETjNVcjJxYk56WTVm?=
 =?utf-8?B?bTViaGZROUZINnpIbFFxTkM4b21oOTJsNVhQZURId2FzTTI3cjFxcjhhejJB?=
 =?utf-8?B?NTNFV0FzTEZ0c2NDTVdJNjlzSVRVdjZ5WkUvcGlaN2dTVnBPeC9INGg5L1Vx?=
 =?utf-8?B?aWt3ZjFCcXZ2VUdHTjdHZlE3QzFNeFZUNVQxdExIN0V4K3JUNGNkbTZidGVz?=
 =?utf-8?B?MUt5Z1dpbzFYNlJVNmowbWdKVVM4M1JSY3FHNWFkTSs0TEhHOTRQZEhObWNk?=
 =?utf-8?B?K2JhMktEWHhZR0ZIa1hBSDlXd082VW83a09WallrMXRzZGZ0bzhpbWowN05a?=
 =?utf-8?B?QzBvcWx0aGxySVlqcVZ4V1lISm5UbmRJSlJWcGZXdldIcGFmVU5icTRrT3ow?=
 =?utf-8?B?NHZXbFVTWmxCMERZUGI4aFdGUkttMkhZN1Npb3lGTWhVY2xrRzczaDlQU1NN?=
 =?utf-8?B?WitZWjR3d1E0TnRBMFd4QUVMdmdNK2p4aXNLSnVMRmVZZUZPRTB4TmNsWUw2?=
 =?utf-8?B?K1hlK1hPMW14TEhwUHQ5QmFNTm8vbTAydTFicElDMWlZV3YzQTlua21HdHAy?=
 =?utf-8?B?dE5xQVpBaDd5bGdZRmxnek43aEExL1VhUitGdjhPMTBFbVkvK0cvMkxYRGpF?=
 =?utf-8?B?Vnk0bWxONFlaTllVZVFmK3NRTnk3QmViVHZzVUZab1hjejFOanY2amlYUmFt?=
 =?utf-8?B?d3RZTnppaEF2OTJHL2xHS2lkQlRqbngremFHZDRCR2FRWHFvT01oTmp6MVhF?=
 =?utf-8?B?QWF6eEZrUHlOTHREbkFDM2Q0dkZKSVp6ZEkvMVRMSmlJeVdRZmViay9DSFZJ?=
 =?utf-8?B?MzcvaTBlWHJLOTg5bmR3RVdzYS9maEFHRHozZHRiQ2xST1diNE9oc1I1d2N4?=
 =?utf-8?B?WktHLzZTQlFmbDl5aFprc1ExYjhodHRXN29NOGRHN0Z2QmhDUWN1N2dEMmRR?=
 =?utf-8?B?bmlYZnRkcHVlUCtBNHd6eUdKUmczdHZKckFwYTdocGxjYjNybnNZK09mdmFF?=
 =?utf-8?B?eVhqMzU2bllOdjFBRDBxZStveDVGTk9Gam91NGVFZ1JHR0FmaTdoZ1lnZFk3?=
 =?utf-8?B?R1pnMzhnR2pONjQyY1FvSVFUSENIdUN6bXFuZkkyWXMvSEpwVE55emdLanZK?=
 =?utf-8?B?ZVhVN3BmeEw0aHFEd2V2M2N6QUtGMXVqS3RaREhIamY2UEthNnhNNmhJWDFI?=
 =?utf-8?B?L3UvZk4xMmk0cDFRSHYxSUhIRHNRaGZweXBHWksxMmRwUjBJbklWRmNIazI2?=
 =?utf-8?B?VFB0Ny9hWG1aQnVEZ3NXWWo0OC9NaWdZcXlDclErY2pzODNXbzZ5Wm5HN2g0?=
 =?utf-8?B?eWtZVXdRYkVSQzFRVnRIUlBhais1U2FYeU9TeW84cGMwRzFLM09Vd2RxeGtv?=
 =?utf-8?B?M055MThDWC9MV3E0WlllM09aUlNTa3RMS3V2emtoaTN4WmxUd0FIRWdxczRO?=
 =?utf-8?B?NzhVeDJFaS8ycUMzUzBPM1hlVDJlKzNSU0pzc3hRUVpGZW1Rdk1xLzFvRm1s?=
 =?utf-8?Q?/iB7/Yb22+3b2dj8jGoYrZs0Yvca4BVo?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZXA2UGJZZGZjYTU0TW8yTmF4WEloYi9jYlRFOHFjbGJocXV6L09TZUJJMlhs?=
 =?utf-8?B?akNDZ1U5eEV2aml6cTY1dDZJcWFqQnd2NWV0K2FsQ09ia1dnbDRabExxZWFC?=
 =?utf-8?B?M3B4TzMrUnFTRm9nZ1Z0bjVpZTJOaDJURkVrYlJMcW5ZMHZVeHZ6eTB5WEEy?=
 =?utf-8?B?cCtjTXpCRC9temlLL2dDZFMwOUVvNGhCb1Fna3VOVGdFZTFHUVREY1hIVlVT?=
 =?utf-8?B?QXB4SWFOVnpjN3lXVEtzaU04U2diTkF4TGp4Vks0MUM5ZEVZUTVFMlY0Ymly?=
 =?utf-8?B?bkZvY0xVQmhpTmVBTWxKUVBnOUhkaFZGNGFxTnJ4bFZ5MThuN3Y0YWVmVGh0?=
 =?utf-8?B?YWhTcHdBOGpqSFlQMnlPSXpSQ2NSYkJDNVhNN0VDSkFFclkwYjNJOXduWFZV?=
 =?utf-8?B?Q2VCR2RNM2xkQkFXK0xjUSs4VGF2U2pYRUcxTm16TDQ0S3dMUnl3UHJNa0Zi?=
 =?utf-8?B?dGVuSFpodUtUSjc5cWtOdDFmWGZ2ekF2TXdzanlCWVVNdHp2Rm5hY00rMFN6?=
 =?utf-8?B?c3ZJT1I1QlIyWDZ6aEc1SG9QT0taekpHN2NxSSt1bzFXa2ZiaUJlNTF3U01m?=
 =?utf-8?B?TG1YM1ZiMFRDMXJnZEJ5WFN6VUROV05VU2E0cXhheTFPZ3JXY2NVckRLUlRU?=
 =?utf-8?B?M0pZYXhlQzgxZ0NzWnlnSFNyN05SaE5SeUd0bFp3QXVBK0luN1Z2bkUvVXJB?=
 =?utf-8?B?eDVYQUJBVTU1Qmtub0VxZkVDSEVDSEdxZVkyK3BGWjVJbk1nVTNKbS9LL1hY?=
 =?utf-8?B?d1F2RDU0dFlXVHR6Z0lrYXNjaFEzTXlYR09aOVhvTmRrUGpiNXkvTXl0eWNz?=
 =?utf-8?B?RE1CWmQxREZjWmZFbmNTTXN3c0cxenlBZm93cXRYUkYxaFlHTlRDOGR4U2Zh?=
 =?utf-8?B?S0NLWUxzajNFZzkxcE9QQlB5MGI5aUtHRjJMMnhqdkxTOHBGekQ0ZWM2bWFH?=
 =?utf-8?B?WE9obWNRTmNpZkZrRk1MUHJQcmFVRUh0WjhGQ2FmcUZnWDgwYVpvRjlFV05N?=
 =?utf-8?B?b2hzY0dYMVZtTi9NMGFEelI4YVBRMjZ4SDlyVzlEZzdyNGx1UWF5OXZFY2wv?=
 =?utf-8?B?MEQ0aHdyQnhROXpDbDhLeXRJRXlCVlVCYk9sK1lXbWdQcTFGK2VCYXRibVBQ?=
 =?utf-8?B?MVVyY0drYmNyOGNUYkN3S3hncG5saTdEWkIySkhSY04vNDJqSVAyQXV5a3JE?=
 =?utf-8?B?STVRQm9ucW1EeE1VYXR6LzBxUXZIVGVLcjQwaWhYa2d1alVWTW5TUTYrWjVK?=
 =?utf-8?B?Y1E1VHlNaFFzRFdiQ0xKQjBqZjc0a1VIcVZiNGF1dWVob1ZPcTRxUFVRTFZ4?=
 =?utf-8?B?OElQL085VVhtM3hFeEUydVZ0WVp1Q01tdWdFemVvb1FBUUxxOXBGMGZET0lR?=
 =?utf-8?B?V3RzQitoRk4zSHVQdEtHbDVIN0hsekdNajdFYVBHTVpFTi9CODU0bTZBckll?=
 =?utf-8?B?S0EwNUNXUzRlaHdZQ2pFSGFIeXBXS0dWVVBPaGpaRCt3VnhzQ01DZTFxS2Mz?=
 =?utf-8?B?bHQ0WGZzZTBudm43TWg4RlJXNEN1NGg4Z3h0dzRVTm9JNGVURlFTR2krWGNw?=
 =?utf-8?B?R21uUEd0SlN4R0FzNHc5YmJOcS96bXVrekdvWlNUenZwRW9NKzVON3JhbTJz?=
 =?utf-8?B?SjQ3MEtHZTd0TkhRQ3d1TUdEb2lqU1dWV1Q2UWFqeU1SS0c0bkwxdUd1Zjhs?=
 =?utf-8?B?Tmw1ek90TE5NZ0w5K3ltNk9HRWVab1B4Q0h3dDB4SnFZaUJ0bEk4RTB6ck41?=
 =?utf-8?B?OXB6aEJwNVM1ckhVeXh2cC9TUUxOUHVaKzN4ZlJGblcyeWFsKzRNTkxuU014?=
 =?utf-8?B?bkprYlJrazVGMDBUSTdoV1h6M1FubHpkNEJ2UE9YUlRERVRTTjBLaE9WYkFl?=
 =?utf-8?B?bVdBUk1kSFB1TlkvUHVMK0daVGkwRnJCOVJtTGlSYmVrM1hNQzY0R2V0WG9M?=
 =?utf-8?B?Q1NwNXJMZ2xaSjdsQWZZVUVHRXBnSVd2OGJnNVNHSnovNkJpNnB6aHJvK3Vq?=
 =?utf-8?B?dHhmQWtCOTZNeEs3UmVUaWx6UHo3T0ZRU1ZNNi8ySGRoVGpJQ21pcUVxT1Ur?=
 =?utf-8?B?bERxWm5UaCtyN2JpYUoybXlhMmQzRDlDcFozbTlBTUFESTk0U0JxaU1PT2Jy?=
 =?utf-8?B?b0xsMXhOVkRzcW9PcFlMRjdHZDNIWW0va1BHS3Fsd1MyVUdNU3NkYXY4b01j?=
 =?utf-8?Q?NBldf/pYhj2H8Ekj0dBwWls=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <035A9B1A57DD394587764B42749B9039@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f045c595-6019-4be7-a943-08dd207a88b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2024 22:14:40.7647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nat6INIdao01M52/TRmO/TzWFcdYq9Y8PzvYoNgcAluuzn5Vofl+zg+Suw4RdWjfh/YhvHOEsIzsdLOLB6+IrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3851
X-Proofpoint-GUID: x-pdv-gp5kgBbAxAyUumJRKnF3Dg6B3i
X-Proofpoint-ORIG-GUID: x-pdv-gp5kgBbAxAyUumJRKnF3Dg6B3i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

Q0kgZm91bmQgYSBidWcgd2l0aCB0aGlzLiBJIHdpbGwgcmVzZW5kLiBTb3JyeSBmb3IgdGhlIG5v
aXNlLiANCg0KU29uZw0KDQo+IE9uIERlYyAxOSwgMjAyNCwgYXQgMTI6MjXigK9QTSwgU29uZyBM
aXUgPHNvbmdAa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBBZGQgc3VwcG9ydCB0byBzZXQgYW5k
IHJlbW92ZSB4YXR0ciBmcm9tIEJQRiBwcm9ncmFtLiBBbHNvIGFkZA0KPiBzZWN1cml0eS5icGYu
IHhhdHRyIG5hbWUgcHJlZml4Lg0KPiANCj4ga2Z1bmNzIGFyZSBhZGRlZCB0byBzZXQgYW5kIHJl
bW92ZSB4YXR0cnMgd2l0aCBzZWN1cml0eS5icGYuIG5hbWUNCj4gcHJlZml4LiBVcGRhdGUga2Z1
bmNzIGJwZl9nZXRfW2ZpbGV8ZGVudHJ5XV94YXR0ciB0byByZWFkIHhhdHRycw0KPiB3aXRoIHNl
Y3VyaXR5LmJwZi4gbmFtZSBwcmVmaXguIE5vdGUgdGhhdCBCUEYgcHJvZ3JhbXMgY2FuIHJlYWQN
Cj4gdXNlci4geGF0dHJzLCBidXQgbm90IHdyaXRlIGFuZCByZW1vdmUgdGhlbS4NCj4gDQo+IFRv
IHBpY2sgdGhlIHJpZ2h0IHZlcnNpb24gb2Yga2Z1bmMgdG8gdXNlLCBhIHJlbWFwIGxvZ2ljIGlz
IGFkZGVkIHRvDQo+IGJ0Zl9rZnVuY19pZF9zZXQuIFRoaXMgaGVscHMgbW92ZSBzb21lIGtmdW5j
IHNwZWNpZmljIGxvZ2ljIG9mZiB0aGUNCj4gdmVyaWZpZXIgY29yZSBjb2RlLiBBbHNvIHVzZSB0
aGlzIHJlbWFwIGxvZ2ljIHRvIHNlbGVjdA0KPiBicGZfZHlucHRyX2Zyb21fc2tiIG9yIGJwZl9k
eW5wdHJfZnJvbV9za2JfcmRvbmx5Lg0KPiANCg0K

