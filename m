Return-Path: <bpf+bounces-57556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC07AACDCC
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 21:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D03F91C21825
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 19:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047DE1F4701;
	Tue,  6 May 2025 19:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="K5oUHzSS";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="vouxSIWX"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B6F1A3A8A;
	Tue,  6 May 2025 19:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746558708; cv=fail; b=c9KqkwRlbWZJ0FIgCh7JCooPoc4Ixaq1+9ncBPiry6IDjB6E+2pBEe3twPtMY+bTQhPmthab4QULgVmtd9Cz2Z8Op5NZCMPPuufGm2bFmEUORf8x3HXWpQcCItkulDzZN16LN2yfpkOVO8jSpk+3x6jrPLzs2XjOdaCzTmi9iFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746558708; c=relaxed/simple;
	bh=HD+HDxguSarOYtA28OqqllTMfXJTV83G2O9fQxiSAKM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PBygsi6xuLtet5zdnO1fi3slhCYtM5j2c3J/9YWJRB5ioV4Xz8VR2sGqSCrBJTUoeAJERz+et7P/u3iWdILHIQcDQtFdCH075SMD5I5DQ7VSsJ4uu6wvEawnnLc7GHoHYWLbLOFBk7k3QjeiRD3HXK6/bUdzzZRnzbTW6WTiB7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=K5oUHzSS; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=vouxSIWX; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 546AruUh023332;
	Tue, 6 May 2025 12:11:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=HD+HDxguSarOYtA28OqqllTMfXJTV83G2O9fQxiSA
	KM=; b=K5oUHzSSiNkrFxojcf27mSECfsFTApqBX3NufYlhqHXi/iTdcKtmfy/AA
	jMWr853cjHoDc/Zc/m7kcNmN/QL0ezcqdz8lzjt5L9o72J1R/UTxLlbjDGdssWtU
	2tsXB2ngmAuBnQmW1xQdXaB0FM2M9toSTvTv2m8R+AunekO6FBUgkMan6t5jlgda
	LBEyG/OvEK/obt8wgjcCMq8cuvyvDpyy61kGx+DxFzDYTiBHgIKzT/mj7zL5Bl+0
	jPnFDbP0BHy+GCOohILqnaf09qWbEt8tdDADJoRgWFDtt71VOSb21fUF159JoOmk
	4ahVHPW2vRGYuHn/xpOUIQbhPWccg==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46dj7kxp60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 12:11:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZpus3G0hSq7Ld7SBX+vEp9KAM7TqfGquWkgj2gUMY3czuEF26vZJ0C7CZ54XQWM3j5oXhh1UWv3hSWKWcaPn8M5TFCSil+XB/U3Y0exRPbA9tlJLUchvKEYRnCo3KxqiFLIZXmjdqIKMuf3eiGvLbmg0h7REtD3JyH4ELpuBk7oA0PX7qUUEuG2Jcyeuck8d6n81IwbFin3Hd3R1KKXx3iUe/elP7k4Lu4dWvENfo/em4uf3SQ9ppb1Cloi0aXOM4Mo4EYbmReoTJV/Q6I/FcGSFklMtKWeuu7ST55vftvR/z/pHFYl9xfDGmC94GHASUQwJXdxvOr4E4+t3Rl44A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HD+HDxguSarOYtA28OqqllTMfXJTV83G2O9fQxiSAKM=;
 b=DNJa/QWMtQR2goP8rAsco37L+s4Rcnxyi2nZNC4sicaYYkJJE6dX+cct8N71pf99OqU+CQiBuvZdZ7gTZc24kB1FNkuhRFEh2LatMVdpITTrkGOds3pxSV7JurwzP1hu9Y1FoKP3YhAr9j4GxdsXoahYfo+3ff7H3vHlkzy1m7j2/WRsV5DLym1ooWtfQzC4NISnbGLihf+lCokLj+PJT4wWc4Bv+AewoV7Djlb/V8VXv/KilgSMsRoHw787+y4PYQOLq2rq015Jk3IXhEsbmPbkOPHdXPgZjJ9jk7nT4TIh1TirFQEs2i4Nqe0IJ9jcmT78H+qa9rqTsWINtsLJ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HD+HDxguSarOYtA28OqqllTMfXJTV83G2O9fQxiSAKM=;
 b=vouxSIWXTtjJKlqprSgtdhewlUY34QbqQ39eirQc/X4EAmE3CHL8D7Uzn4YpzBdKOnNss6eXvroQui+nQnbmEvVEapOe71rkiHgJMQ8zX6YLOXN1Ayy9xOGG+kRI9aAA1GWj0wcZJJ0cS2VIjd2qDnM49hEvOvm7eHTYKl4nAUWExd6Q/SJ7WnGYyh/BtzR5lWL7YwyWYjP1bDRZAZtj+Vl+nO6bxOzrSHOukqoCU5Op1xryDhCIipeiyhp3aC9xJdohgoxME5iZdBqAyVbmsiWBDjPFfVHRWEdiQRm6vnudqtCGP6qJ6jf/RSCvPu2CkxLovbEqwVAnfR8ull/cLg==
Received: from CH3PR02MB10280.namprd02.prod.outlook.com (2603:10b6:610:1ce::6)
 by MWHPR02MB10426.namprd02.prod.outlook.com (2603:10b6:303:285::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.12; Tue, 6 May
 2025 19:11:17 +0000
Received: from CH3PR02MB10280.namprd02.prod.outlook.com
 ([fe80::44c0:b39:548e:2e8b]) by CH3PR02MB10280.namprd02.prod.outlook.com
 ([fe80::44c0:b39:548e:2e8b%6]) with mapi id 15.20.8722.011; Tue, 6 May 2025
 19:11:17 +0000
From: Jon Kohler <jon@nutanix.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net"
	<daniel@iogearbox.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>,
        "aleksander.lobakin@intel.com"
	<aleksander.lobakin@intel.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S.
 Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next 0/4] tun: optimize SKB allocation with NAPI cache
Thread-Topic: [PATCH net-next 0/4] tun: optimize SKB allocation with NAPI
 cache
Thread-Index: AQHbvpKn5zJ9Qbdf9kS8CVZmWPwcK7PFsGwAgABHqAA=
Date: Tue, 6 May 2025 19:11:17 +0000
Message-ID: <3A17D540-12F6-46FE-8109-CCAEBC168754@nutanix.com>
References: <20250506145530.2877229-1-jon@nutanix.com>
 <681a22ac9964d_15abb629445@willemb.c.googlers.com.notmuch>
In-Reply-To: <681a22ac9964d_15abb629445@willemb.c.googlers.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.400.131.1.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR02MB10280:EE_|MWHPR02MB10426:EE_
x-ms-office365-filtering-correlation-id: 548c7b62-1453-42f5-d6b8-08dd8cd1c735
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dkRlK3gzSGFCR081VzQzbnVSSXliTXcyNnNYOTZ0RkZSc1Y4VGJGMEdBZnVt?=
 =?utf-8?B?R25Gd2w4YWRUc2RMMnNUQ1RDZnpET1VhMi83MWFob3ZaWktqSnBUSS9jcG55?=
 =?utf-8?B?UGZCT3ZHakFRMkZsOHhBMnFUSGsvTHRHSFdQbHBNL3c3Um1Va2w2YWVZVFZM?=
 =?utf-8?B?dHg3UjJVa1BISWsyZmhGMTZSZHhmSlZlSlo5eHF2RkdJd0NlUTFDb2dXWkZn?=
 =?utf-8?B?bVFMRlkyVmo2eUxDMEdHSyt2aVB3S0FsaVRoSi9rOWo4eW1LZ2RnSGVLbGY0?=
 =?utf-8?B?RFRJVnViQ1hucEczaGVodlZNb2Izd2VxNUdkdXp2TkJIQzhscmFsOEhWZnM1?=
 =?utf-8?B?a0NIWFd0OHlCZE5tRS9haFJDR3pJSmpvZ0pCZFh2RE0xT29TdjllRFk5dzF0?=
 =?utf-8?B?c0hTRXFBcm9MSTVaYlpyTXI1ZGZzbUMwZ3FScDF2LzA2Q2JTcW9WSTl3ZUZF?=
 =?utf-8?B?U3F6bjNUSjZZZy9sQm9Nc1FPOGdVMCt0Sm1sUndsY0Zvbks5RFE2bUQ4Vkto?=
 =?utf-8?B?cEhWVHRCVzFkWUlLS0E4aVpPdmJTeENCNUo4NEoyNzVIeUhSQVZHb1RrdEU0?=
 =?utf-8?B?WmJBTjM4UkJSN0dEZVJHQlVsM29EOFVVa0RPY09iblAxNGNnWU1wL1lqUkZS?=
 =?utf-8?B?WDBxejR0MlBCQVRXYkNGZmpwaU10NkZCTmtZakxhRXFSdlB2NUw3aS80NWlK?=
 =?utf-8?B?dXhZNnZVR3pXZzhaSWJXUlN4OUFJSTJrc1g1UkJ0dWxUcFpXZXBmMUR6WjJO?=
 =?utf-8?B?RlcrVHBpanVzaXFlNms3R2dsbXU5STY0L0F2UUhYMXoxTlBlUG0rdittMnY2?=
 =?utf-8?B?aDFjSmcvcUsyaXJQTjZ3U1lKWE1DUlVvcDRGaGhkak50Tk1scmhoRTZrcnlP?=
 =?utf-8?B?T29wMC9mNjMybmk1V2c0WFR2cXpWcktpeWMwaWRoaWVxZ3ZoSjJXam5TbSs5?=
 =?utf-8?B?U1V4U0JvYmZkY3VZc050M3pvUXJENXRUVEdjTzgyb3FzNHptVFduUVNjK2pJ?=
 =?utf-8?B?d0lFd2IyVzJkd3R5OEQxcGwxdG5WdW04M05qMitpaFJJdFd4VCtjOHZ1MFpj?=
 =?utf-8?B?RFptZExFSVJlY0MrK2V1N0hJd0xWcFRBc3ZBMWxMeFFDcXlMajJ6dy9UbG5x?=
 =?utf-8?B?eVhnSXJBcENIYlEweU8ybDdEMWFnQWV1WlJPK1N5VXByamZCck1HQXZ1eTNo?=
 =?utf-8?B?NnRBVEt4ejV2dUZUV0l0bEtGUTNFcWlocFpZc0x5Ykw4UGZaYytFazkrN1Zn?=
 =?utf-8?B?Q1pWdERSTnJVTDZoVGV6TG5FanZxVWd1bi9SNU5iVStHM1JwUldKRE5wbmVw?=
 =?utf-8?B?V1ZkWGE4VzRYV0xEd3dsM21TVzdIT0hIWjdGQ3llRU5keERMUllnWndRdEl6?=
 =?utf-8?B?cXk2T1RPL29mOUxNYmtla3dKdVgrMXhCVWRKblhQTUEzMk1pZWQyeGFyTGJV?=
 =?utf-8?B?eGhKUjlaZmg5QU42bzhkYWdoYysxdVhVdUdWOUx2SzZVSlNqOVRrSjl6aXFT?=
 =?utf-8?B?M2h6QWJtQWNBVWNIckk5S28zMUtlY3pENUxJbWxKck5Ob0xaWGw0QUxtYW5R?=
 =?utf-8?B?SzdtZUh5L2p1NDYxNXlZVk1nbTJnelBuRnNEdGR2QjFaQ0tES0EvY2diVUJv?=
 =?utf-8?B?TWFzRlRPKzltMDZXLy84ZXBhbmtObnFNeHRCSFFmby9WdDV3TzlxRHg0L3J3?=
 =?utf-8?B?NjFHRDFyQWpHVGFiR3V1WldOd3grMy9NSHhrdWc3cDYzRkVIT1kzOFBhTEtx?=
 =?utf-8?B?SFJjTzBNZ01sTjNUVCtwL1F1UkEzR0xTWWVaOXNySk5vYit3dFozZHd3NHlP?=
 =?utf-8?B?ekg5QzFmbSt3Y1hPaFFxb2JQMjJvdmsxU2RHVWl5V244M1pCeWlETEhWNGtw?=
 =?utf-8?B?Rkgwcm9mdCs2eWZaZytDV2o4ZVhGNXlQUmNoUkpxbzh4YW9Rc1RrMlJHdmtY?=
 =?utf-8?B?eDdTUnVRdlFTQ1A3ZzFPM083akdsU09sYXZNeEk4SVR3aGhCa0VYQndycG5k?=
 =?utf-8?B?UUs4YVBkSy9RPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR02MB10280.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RjFNZ3htYXE0OThVeGszWGNqa3llekI5cmJyRGd3WkpXSit1UDdVMzM1c2Rh?=
 =?utf-8?B?MkNIVTFlbVdoRzNtUkUxeHFsbGRtUG5LMzM1OWxSUVRLQ2pmb0dzZXoxZkh0?=
 =?utf-8?B?dWh6dVJhVk10U0hwdlNva1kySVFxV01UR0ZYN3dPaUN4NmRmTVRMenRsSTk2?=
 =?utf-8?B?Rk9BL3g0dnM4Mkg2QkhSd3M4cDFieFIwdUFxWnVIODl2M25YcWlnSFVuUnkx?=
 =?utf-8?B?TStUTUdZR3oyQ0Y5b1kzWUFyclBHUzBwYTcrL1BVSUlNdGM4Uk5sYS9MR29p?=
 =?utf-8?B?c2o4aUI2WWgvV3JHRFcvVnFiY1liZEY0U1BXZWt4NHZxMnBQSHY4NU5QU3FR?=
 =?utf-8?B?eHVOZkZIMDd1UEFiUTFLa2J1bEptRVQxWUNkb3d0UnNveFhjdGFDejlzbm9T?=
 =?utf-8?B?dUtlUHUvaUZUanhOc0hUS0Fwaml0elVjbGRseitmT2VocXBuTjc1bEIxTkxT?=
 =?utf-8?B?RGJJTjVITVNJTEdSZ0lRTFRsOS94cFE3Z2lQRzlTNzAwYmNZdUh4NTF2eTkw?=
 =?utf-8?B?WERDZ1J3QmtzRndPSVlhVk4vU215UktRa3pWOXpMV3dIcUpkU3J2elJ5Smxh?=
 =?utf-8?B?ZStpSENjNHhQOXk1MDRsdWY3SDhncGRCNjJyVmYrRTZOU1hYR0lCTGI0Wk1F?=
 =?utf-8?B?bHpHUytkREhRelVnYzN3NnBQcWs1d1BkWTVJbTR0Q0FHZE5taTkzM3hndjA2?=
 =?utf-8?B?OUxlbmtFMEdLSzlqWWNNVUE0NlFYNExRai9RT0MrVHZuZkJzVzgrL0JQN2gv?=
 =?utf-8?B?ZEtlZHNrMTNpYmJZcGthRDVONU8wQ3E2Rm9LclhPbWhIWEF3L3pCZnUyVllr?=
 =?utf-8?B?b1hvMVpKZEVQeGNQUmNGaFJjS0JnTk9JbWdVM2FackNRakZaRmJ6eUdkN0Va?=
 =?utf-8?B?TSs3QmF5ZElqWjNoWENyaEJNVVozTEhyRGVTYTdiT3JTSnprRVRQK2ZUcDh5?=
 =?utf-8?B?SEx4anZNZ3hPWWhiTlN5WStjcEpyc0kzWXB3UXFvbjVCcHZjdVJxdk5oVUdV?=
 =?utf-8?B?RHlXWnYxVnkzSmpDK3Y4WGRYQWJHSVRwWW1UVWRXZG14M3hBYUlObStEYmxE?=
 =?utf-8?B?akNNbTlITkxPZlNCbTZoN0lCNUxMSnZXV1grSkFHMVROY203ZWV0YWhIQzh3?=
 =?utf-8?B?WlMxMjM0NnFzeUx3aEZPcHhJeFcyc0xHZkUvb09XTTBqWTRIcnBSd3ZOakJn?=
 =?utf-8?B?clliTzFyRENVcmxOQ2wrT1Irb2s4SFhXY25LcXk0M1FaaVNoSWlXSGVCTmZT?=
 =?utf-8?B?RE5BMS9vTlN3bDZ0N1hlYUVjT1FwdHkwd1NhMmpDN01tdVptSTZPR0k1N3Bj?=
 =?utf-8?B?ZHRVNnE2MlhOQ0I2ZjJEVGdwamtvYXZIa2RPdnNDRWJkZU9iY1JVdmd3VzBQ?=
 =?utf-8?B?b1JKWUpDS211VS9rbktna210akhja0dzNXRKNUhpRTRmSWc0TnBJVmNnaU9T?=
 =?utf-8?B?SEFPNy9ZbXRzK0xEelBpODFVNnhQMklzRjRQNXNmYmE3bnRObk8xTFF0aTdO?=
 =?utf-8?B?Z0Z5N2t1K3hGREdnZDJVMTlVeFk4Zkd2cGViL2ExV1QzSUlEQmNwdjV6V2sz?=
 =?utf-8?B?UXJXVUM0M3dYdHVxSjFHTm5iZHNGVlFEN21mbWx3ZldHbzNwak5PWGlaaHli?=
 =?utf-8?B?TVhRREFlaXAyQURvQndFT0VWejBBMWlIRjh2QVNKc0E1VEVuckRodlMrTnFD?=
 =?utf-8?B?anREcXRWL2hnN0dUeUE1ajRSZjhxNHV6bHlJeS9udUJaQWFtaVg1WlJsTi9H?=
 =?utf-8?B?UXA2RWtNK05sTi8wMVJtWkJLZ1hBY0VmMXRjVFdlWmNWMDJIWitxdGJXZG9w?=
 =?utf-8?B?ZkRJWlNMRGdNK3gxZWhDZjdLNTN2YWYrRWlWeGpCNUYzZmJNS1drMkRDQXNl?=
 =?utf-8?B?NzNmcGtyU0x5bTB4a21xcVF6eFZ6c283SzkxRitLZjd6dVJwa0dkeDI1NFQr?=
 =?utf-8?B?NGkrMmxQc2ZKVlRnSmQ4S2VvczNXenBXbkc1dzBnNC8vVEVPMzhjOU1MTGt4?=
 =?utf-8?B?bnlXdjFnNkdibUtqQXMyN0k2cHpjeGR2Yy9BZlkzTFpPS0tpd0srd1FSTFVD?=
 =?utf-8?B?b0N5cUovK2VqZWc2MkJOd2I5UGc5KytyY2t4ZUk0NVZ6NVpsK1drc05qT2tH?=
 =?utf-8?B?SmE5ODJRbjJkalVueFRPQTROTW13VFNvZjVhY0pxSUJJOXIzTWV4NGc4YWpv?=
 =?utf-8?B?OFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0743E29736B7E44821874DDBAD7B87B@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR02MB10280.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 548c7b62-1453-42f5-d6b8-08dd8cd1c735
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 19:11:17.4533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rr5IMg08AeGOrujU7NsBR3Am6Xczpi92QIAtix4pmOYrlMWUuyApzfCreERC0iyA2l2gn5NccIlCyPrEZM3gDFURr6x5OJu8y/yFV/s7hGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB10426
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDE4MCBTYWx0ZWRfX4CYxOwYWmSqh NEt4F948AS0Ob9Egt+fpzRIuo+s9V7ALRZk0ET1LC+VdadPgbD/9atjAgT4uNIPJiPIboZsAYGW nQphK0NLQ5n+7MOgt+WoRrfc1FCGMnBJfbUnCXWfihxHX+pSEteRDzSt0F4kvGsl+Pl4B7P0c02
 zKQzDzMSvFJB6xAY5zeTxxtHeMwl7Gvfh401eQVGmxo6HD0/ZXUSGjSl714udR13Ssafqe5nksV 0t3xTxlnAqxd0h5gmlBTK4kV1Z+SW5EsJXRD6YtlI9t7AKzhFrxsYU9c6CxaFvHmrXqRkWiWG4q Bxwan9JDbPFNtpsmIOGmZHqT/LdCaUI2AU8OBHp1eAZfnFDtrBlLggesLtAaHXaRE0oVjHChCdT
 oeG0RMJ5CcrKYstRglBn3oac8Fe9fUqYN8HQ3Gm8vftISsxWbt4bP2ZVY8R2qg0IjdDinHkO
X-Authority-Analysis: v=2.4 cv=LNpmQIW9 c=1 sm=1 tr=0 ts=681a5edb cx=c_pps a=o9WQ8H7iXVZ6wSn1fOU0uA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=pGLkceISAAAA:8 a=yVxGsCT9haX7Gsjosb8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 46bpvavnerQu3GZxYCQwcbdyaVGbbo59
X-Proofpoint-GUID: 46bpvavnerQu3GZxYCQwcbdyaVGbbo59
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_08,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gTWF5IDYsIDIwMjUsIGF0IDEwOjU04oCvQU0sIFdpbGxlbSBkZSBCcnVpam4gPHdp
bGxlbWRlYnJ1aWpuLmtlcm5lbEBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gIS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18
DQo+ICBDQVVUSU9OOiBFeHRlcm5hbCBFbWFpbA0KPiANCj4gfC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0hDQo+IA0KPiBK
b24gS29obGVyIHdyb3RlOg0KPj4gVXNlIHRoZSBwZXItQ1BVIE5BUEkgY2FjaGUgZm9yIFNLQiBh
bGxvY2F0aW9uLCBsZXZlcmFnaW5nIGJ1bGsNCj4+IGFsbG9jYXRpb24gc2luY2UgdGhlIGJhdGNo
IHNpemUgaXMga25vd24gYXQgc3VibWlzc2lvbiB0aW1lLiBUaGlzDQo+PiBpbXByb3ZlcyBlZmZp
Y2llbmN5IGJ5IHJlZHVjaW5nIGFsbG9jYXRpb24gb3ZlcmhlYWQsIHBhcnRpY3VsYXJseSB3aGVu
DQo+PiB1c2luZyBJRkZfTkFQSSBhbmQgR1JPLCB3aGljaCBjYW4gcmVwbGVuaXNoIHRoZSBjYWNo
ZSBpbiBhIHRpZ2h0IGxvb3AuDQo+IA0KPiBEbyB5b3UgaGF2ZSBleHBlcmltZW50YWwgZGF0YT8N
Cg0KWWVzISBTb3JyeSBJIG1pc3NlZCB0byBwYXN0ZSBpdCBpbnRvIHRoZSBjb3ZlciBsZXR0ZXIu
IEZvciB0aGUgR1JPIGNhc2UsIEkNCnR1cm5lZCB0c28gb2ZmIGluIHRoZSBndWVzdCwgd2hpY2gg
d2hlbiB1c2luZyBpcGVyZjMgKyBUQ1AgcHV0cyBhbGwgb2YgdGhlDQp0cmFmZmljIGRvd24gdGhl
IHR1bl94ZHBfb25lKCkgcGF0aCwgc28gd2UgZ2V0IGdvb2QgYmF0Y2hpbmcsIGFuZCBHUk8NCmFn
Z3JlZ2F0ZXMgdGhlIHBheWxvYWRzIGJhY2sgdXAgYWdhaW4uIA0KDQpjbWRzOg0KICBldGh0b29s
IC1LIGV0aDAgdHNvIG9mZg0KICB0YXNrc2V0IC1jIDIgaXBlcmYzICAtYyBvdGhlci12bS1oZXJl
IC10IDMwIC1wIDUyMDAgLS1iaW5kIGxvY2FsLWFkZC1oZXJlIC0tY3BvcnQgNDIwMCAtYiAwIC1p
IDMwDQoNCkJlZm9yZSB0aGlzIHNlcmllczogfjE0LjQgR2JpdHMvc2VjDQoNCkFmdGVyIHRoaXMg
c2VyaWVzOiB+MTUuMiBHYml0cy9zZWMNCg0KU28gYWJvdXQgYSB+NSUtaXNoIHNwZWVkdXAgaW4g
dGhhdCBjYXNlLg0KDQpJbiB0aGUgVURQIGNhc2UgKHNhbWUgc3ludGF4LCBqdXN0IGFkZCBhIC11
KSwgdGhlcmUgaXNu4oCZdCBhbnkgR1JPIGJ1dA0Kd2UgZG8gZ2V0IGEgd2VlIGJ1bXAgb24gcHVy
ZSBUWCBvZiBhYm91dCB+MSUNCg0KSW4gbWl4ZWQgVFgvUlggd2hlcmUgdGhlcmUgaXMgY2FjaGUg
ZmVlZGluZyBoYXBwZW5pbmcgZnJvbSB0dW5fZG9fcmVhZCwNCndlIGdldCBhIGJpdCBvZiBhIGJ1
bXAgdG9vLCBzaW5jZSB0aGUgYmF0Y2ggYWxsb2NhdGUgZG9lc27igJl0IG5lZWQgdG8gd29yayBh
cw0KaGFyZC4gDQoNCkluIHB1cmUgUlggc2lkZSwgdGhlcmUgaXMgYSBiaXQgb2YgYSBiZW5lZml0
IGluIHRoYXQgcGF0aCBiZWNhdXNlIG9mIGJ1bGsNCmRlYWxsb2NhdGUsIHNvIGl0IHNlZW1zIHRv
IGJlIGEgbmV0LXdpbiBhbGwgYXJvdW5kIGZyb20gd2hhdCBJ4oCZdmUgc2VlbiB0aHVzIGZhci4N
Cg0KSGFwcHkgdG8gZ3JhYiBtb3JlIGRldGFpbHMgaWYgdGhlcmUgYXJlIG90aGVyIGFzcGVjdHMg
eW914oCZcmUgY3VyaW91cyBhYm91dC4NCg0KTm90ZTogSW4gYm90aCB0aGUgVENQIG5vbi1HU08g
Y2FzZSBhbmQgVURQIGNhc2VzLCB3ZeKAmWQgZ2V0IGV2ZW4gbW9yZQ0Kb2YgYSBidW1wIGlmIHdl
IGNhbiBmaWd1cmUgb3V0IHRoZSBvdmVyaGVhZCBvZiB2aG9zdCBnZXRfdHhfYnVmcywgd2hpY2gg
aXMNCmEgfjM3JSBvdmVyaGVhZCBwZXIgZmxhbWUgZ3JhcGguIEFkZGluZyBKYXNvbi9NaWNoYWVs
IGFzIEZZSSBvbiB0aGF0LiBJDQpzdXNwZWN0IHdlIGNvdWxkIHNlcGFyYXRlbHkgZG8gc29tZSBz
b3J0IG9mIGJhdGNoZWQgcmVhZHMgdGhlcmUsIHdoaWNoDQp3b3VsZCBnaXZlIHVzIGV2ZW4gbW9y
ZSByb29tIGZvciB0aGlzIHNlcmllcyB0byBzY3JlYW0uDQoNCj4gDQo+PiBBZGRpdGlvbmFsbHks
IHV0aWxpemUgbmFwaV9idWlsZF9za2IgYW5kIG5hcGlfY29uc3VtZV9za2IgdG8gZnVydGhlcg0K
Pj4gYmVuZWZpdCBmcm9tIHRoZSBOQVBJIGNhY2hlLg0KPj4gDQo+PiBOb3RlOiBUaGlzIHNlcmll
cyBkb2VzIG5vdCBhZGRyZXNzIHRoZSBsYXJnZSBwYXlsb2FkIHBhdGggaW4NCj4+IHR1bl9hbGxv
Y19za2IsIHdoaWNoIHNwYW5zIHNvY2suYyBhbmQgc2tidWZmLmMuIEEgc2VwYXJhdGUgc2VyaWVz
IHdpbGwNCj4+IGhhbmRsZSBwcml2YXRpemluZyB0aGUgYWxsb2NhdGlvbiBjb2RlIGluIHR1biBh
bmQgaW50ZWdyYXRpbmcgdGhlIE5BUEkNCj4+IGNhY2hlIGZvciB0aGF0IHBhdGguDQo+PiANCj4+
IFRoYW5rcyBhbGwsDQo+PiBKb24NCj4+IA0KPj4gSm9uIEtvaGxlciAoNCk6DQo+PiAgdHVuOiBy
Y3VfZGVmZXJlbmNlIHhkcF9wcm9nIG9ubHkgb25jZSBwZXIgYmF0Y2gNCj4+ICB0dW46IG9wdGlt
aXplIHNrYiBhbGxvY2F0aW9uIGluIHR1bl94ZHBfb25lDQo+PiAgdHVuOiB1c2UgbmFwaV9idWls
ZF9za2IgaW4gX190dW5fYnVpbGRfc2tiDQo+PiAgdHVuOiB1c2UgbmFwaV9jb25zdW1lX3NrYiBp
biB0dW5fZG9fcmVhZA0KPj4gDQo+PiBkcml2ZXJzL25ldC90dW4uYyB8IDYwICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tDQo+PiAxIGZpbGUgY2hhbmdlZCwg
NDIgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pDQo+PiANCj4+IC0tIA0KPj4gMi40My4w
DQo+PiANCj4gDQo+IA0KDQo=

