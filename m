Return-Path: <bpf+bounces-47301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 434369F7509
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 08:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8929A1654B8
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 07:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DAC217659;
	Thu, 19 Dec 2024 06:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="GpcFYKV7"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D60216E38;
	Thu, 19 Dec 2024 06:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734591591; cv=fail; b=Fxf12/NOUGRlR2E2sNElDhFDGRPrc9yUWyYWwbNj1/nMeOipKNO4bV3AlLnaA6qaHERv6vJhds9BKldSe0pDA+DXAW8Obs6HkEUtJHZgXmnGnJMTKjSJLlfSidOZeHEeyiRs6H2BRP4i1TDAHlOV8lXSoldJu50F2jqvo217WwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734591591; c=relaxed/simple;
	bh=vw9T6dCMPGujh7OBL5qqgRuzWvkZGeV/fXPXow+GOGI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fu37RGJPDzFWjHAs2vFTdTxU1MIGjnzdpVn9cwmSeR0cCIqpW8QWCCYXPpu8cwPygM6ewQV/SpPjptoAQ5Gt9f9+ZpZwpn30iORPKpOq7G/H1dqLlfNCU6/88o6r9ok21X0kncrsLdVcDPUwXC9jAYRmhQeUgoSpXxyiT+B+qPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=GpcFYKV7; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJ4rkYk016189;
	Wed, 18 Dec 2024 22:59:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=vw9T6dCMPGujh7OBL5qqgRuzWvkZGeV/fXPXow+GOGI=; b=
	GpcFYKV7xK1avKDfte5GUOlPg+WoaNetF2O6Gu4gdjAzD1wqIStLW6QB/OGLN8t8
	Hz1wXzBc6mG4MGjQr7DlH95uN99ENfu2Kp7V37tonLG6QGzj1XUhD++Z+0pNHAYc
	OxKcnveNXKHMLwV1RF83TdpIl7nr7z78Lx4toH7QHFvmhuxkFvn97SZ8eaBS3ojG
	FXd+ud5p6S9Kgd7RI/hy9zRvUSjARC8cRWlRs+Fcq4EyKRoyRfz5jj+P0ElEkNlR
	pdOzpjARfFlSxnxSPZt4WeA+tetyDFVMRcrVnTEEE7qnAHywwBw02u+cpEKtorgr
	dghIBW85uGS+db9HXyeMBg==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43mcur8p3e-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 22:59:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uc6jPIC7rNgilz3mrnZNn+Bvh0vBfMkkPDM9Uw7cD7TyJTPxS4jh6UsTCsUMOdAXTCMYhemCjRo45DgehPW3UssDxI+nRHzPLwgsSpIZ4lbH3EVtIftgqC041b4aQ2/EWn3J4crIi4VJetnuroGacTKhZ/b+KX4fLMq//aBhimNaAkpNqxabWsu8Gl5ypq4YfhChe4nW+KP9dd/YX4/B0Fz9knW+YTQSSacyGLWxVrsR26MvsiWnRhNN4mEQUSa1HpLnGy+AjQUPCPA561IuNpiwR0aThJJqARjVc2XPSxjmR8ds99MBC3SrnzN4FjBosdUJxFo+KgsbbEfzqeNxAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vw9T6dCMPGujh7OBL5qqgRuzWvkZGeV/fXPXow+GOGI=;
 b=iUdznxcZCZSyyNi29b3Pc8p3XQztFAUdUN7gKXKjW/bKryc0MpYbPjv/A1f5nFJACdm7cE5i7mNQhYIFGBaAfcu/Dy9Jm76GYb1qzMldIKcu97fxzvfo15N+IIGHQJnqAiFPKS2hwcaX+syQnM98bhEIb/30xfgj9NIeO2JuRf8ASxNIGBi5EoZFp81SNSvaifcGhocjhmvakshEL7XS08uc6yvRjdGafUzbEyGCkNfa/QaQV5jD2Fwyq6fDM8ODBaEkaxM/O6JmlEqU7ySrj32QXvIux+u1o7qGQkLaPbBruBBHmLem43znQ3iTFBbC2EUREMYWopk4dYYssT2M3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by CO6PR15MB4180.namprd15.prod.outlook.com (2603:10b6:5:34a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 06:59:44 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%7]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 06:59:44 +0000
From: Song Liu <songliubraving@meta.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: Song Liu <songliubraving@meta.com>, Song Liu <song@kernel.org>,
        bpf
	<bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        LSM List
	<linux-security-module@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau
	<martin.lau@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Matt Bobrowski
	<mattbobrowski@google.com>,
        Paul Moore <paul@paul-moore.com>, James Morris
	<jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Kumar Kartikeya
 Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH v5 bpf-next 4/5] bpf: fs/xattr: Add BPF kfuncs to set and
 remove xattrs
Thread-Topic: [PATCH v5 bpf-next 4/5] bpf: fs/xattr: Add BPF kfuncs to set and
 remove xattrs
Thread-Index: AQHbUQgH26q3Z2MAsEyHPIKkiJbGP7Lsg1AAgAAHd4CAACoPgIAAcDeA
Date: Thu, 19 Dec 2024 06:59:44 +0000
Message-ID: <A8A5C206-CEAA-472B-A2BE-99D3E8940159@fb.com>
References: <20241218044711.1723221-1-song@kernel.org>
 <20241218044711.1723221-5-song@kernel.org>
 <CAADnVQK2chjFr8EwpzbnsqLwGRfoxjRs6yXDXmUuBRFo-iwV_A@mail.gmail.com>
 <BF2BF0EC-90C2-4BFC-B1F3-D842AE1B7761@fb.com>
 <CAADnVQ+vgt=LV+3srtGQUtKKc3ohZkaMdHyouXThNmYG2qGoYg@mail.gmail.com>
In-Reply-To:
 <CAADnVQ+vgt=LV+3srtGQUtKKc3ohZkaMdHyouXThNmYG2qGoYg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|CO6PR15MB4180:EE_
x-ms-office365-filtering-correlation-id: ca47a67c-6fd1-45cd-ddab-08dd1ffab7e8
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SHBUcm9NYjk5cllVWDNQMkdvTGpHcHNPU2hFdXhLQmsrZXZ5U1dibnBYcmYx?=
 =?utf-8?B?Um5YdnlDRERETVlPNE5CZFl6M0h0eEFCUWJjUnlOMm5ZN3VLZnVmSGpFaGZC?=
 =?utf-8?B?bFBRL2VSZWdIYTZ1bzZaYTVvZTY3aUZRY1FHMnYvVFJnYUdmSkRuaG5vWGo1?=
 =?utf-8?B?amZVSHQ2TGFtWENjRWFidk5HZG5sR1dhZWhuT2MwTmpPQTU0SFl6WEVCN1o4?=
 =?utf-8?B?cEMrSTM3cktNdnJxQ2QwUEVJa0NGdjBZOWl1SHZaaWpyT0dxVSt6bVZxNWNs?=
 =?utf-8?B?TUlPNTVSSzJRNzZJc25JSEtoVExwanVrVjhjbnV6dVRGUkxBcUpmdy9GalA4?=
 =?utf-8?B?cmw5TnBkbjBhMWFxMmhYeEIyWjVzaGJLS2dxMDJxdTRYV1l6cUZ6dUU2bFhZ?=
 =?utf-8?B?SHozdDRxc3pWdEVzZC9qb2l1cVRmV0VnTWRKRUx4N2YwMnhaelpaL3VhT3M2?=
 =?utf-8?B?ejQwT3kyYnJ5cHlnbHhDaVlId1BVZFFMS085RnVZQmt6SnRnMkRjSkFBcVk0?=
 =?utf-8?B?SmVJTis1N01XdGR1Uk1tMUVxWkt2cGdad0ZFdG5XU1c4SVFLcTNIQktaV3Bv?=
 =?utf-8?B?d0tEamdISnhyTzBHL1hzQVdjSEJLVXZBK3NGaHU0d2ZsMnUzd21sd3NEZTdS?=
 =?utf-8?B?blRCTHhKK3UyTDZydUVFTUROR0V4dk5zKzdDTDFnOWZpdHZKemFSZ2VWQ2dl?=
 =?utf-8?B?S1A2Q0MzS3E2RVNEM29kTnRLUThkaVhKMG1kaFVTRWhGbWpmNlBoT3c3emxr?=
 =?utf-8?B?dHlSUUNCMEFEUDFFM2owNm5vMUxHMVpGOUx0eitWQTVaVkh5b0gxaHNVNXls?=
 =?utf-8?B?d1U0UXRXTlJFRWw2ZFk3UHE4eXpaUjVBU0pva1g1RVVpeTlaY3IvdE1VakVi?=
 =?utf-8?B?QnFHVlJ0RjhSNTNROHJtZmxTNEM2YlVkOUhNK283SHNudE5rTzk2aUFtRmt4?=
 =?utf-8?B?UlJlM0ZJdUhwK3hqOHp5SEo5TzRidHBzOFk3T2ZBcFRELzMzQlpFbGpMME9Z?=
 =?utf-8?B?WS92UGQ4YTFJUk1YdEhHQk4vOUJXd3ovSzlRSndEc09nYUUyT1RpaWJXSkRp?=
 =?utf-8?B?bGRUUXhmbnVuazF3NHhsMlllcUxiTmQ0ODR6TEhCNjlmVGd0NXNCR01Mc041?=
 =?utf-8?B?VVpwa0ozVFduMVpwNEZSYmxqVFZHSllqUEI1NkkwY2g2aWVlNTBHK1FpNjkx?=
 =?utf-8?B?QUNUaytaSWYvc212cHJjWWlPQ09ueGsrMyszcTM5YzVhZjZPZEtMZzBSUFpy?=
 =?utf-8?B?MXdmK1gxakxWVjBia2MvcnF3Wm1jVVhPdW96ZjNKTzdyRWF4Y1FBdGpERGUv?=
 =?utf-8?B?bzZQUzFaV0VjVTJINGtKVU9aSGdSR3kwcHBweVVFbGZrbUI4RlAzaFNPYm5v?=
 =?utf-8?B?NHByRUxpRlNDVXJrajdZckpXK2xCUGRYcEQ3eUZYR3RhTTd4T2laS0NrU016?=
 =?utf-8?B?WklhK0Fna040a1plbGFQZmVST1pVWldkVytRYWhpOS96UTViU0dNQXB2Sm1Y?=
 =?utf-8?B?dno3SUxFQmQxaTV4T3VSV0hUUkp3WUxnZE50Ni9pMXUvaVBtN1hTTGNhRkNI?=
 =?utf-8?B?bmJ1aUdQcFozTGFnMFEyMVZ4NDArTnhxWUNZZnU3NzAwSVU5NXlxVEgybHV5?=
 =?utf-8?B?Ti9zTjM3YUlKWDltUlZiVjNsbkVpeSt2M1o2TXpUZDhFZFZZWmpqeUFKUDhN?=
 =?utf-8?B?eDA0c254Z0VqS0tlT3psLzFJTnpoNW1EdFFrSXJuYkRSTTA3ZFFMVks3MU1F?=
 =?utf-8?B?bTRIdTNobkd3b01sMmN1ZGpmNlF0UUJBVW1ibUZXTmdFb0VrYU8yRUFSdS9L?=
 =?utf-8?B?U08vZTJKL1FJSDdpN2hpZ1JJOHpDWmg2SHlvWWM1Nzd3MmdSRjg0KytSMzVk?=
 =?utf-8?B?ckpZTlZwOVVZM1JFWFFvQ0JoWEkyM21Ndlc1dzkwVjVEbGNVc0FxeXJLZUJG?=
 =?utf-8?Q?j6lsEJx2usNK7RZq9bxezTFMTf2+Byh1?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U3FmS1dHTHlDSFVDV2FEa040MlhqcXp2cXdrdHZ4NFdqWmhpY296S3k3YkZU?=
 =?utf-8?B?TjBaSXY2cjJzYjIyT29zSGNTcDd0WG5uWUlOQXNyZ25ZN1FPMDJJWDgzTTdl?=
 =?utf-8?B?ZFZ4TkZlMzB5TVpBTHg3amo4b0N4aFNxVFV0V2wrL2RyWnFSc01MenQ4MGNk?=
 =?utf-8?B?YThXVW42WTYwODBKMjhkUnl2UEFiQUt1V2ZTMlNDRGdsVnlUeGVBSU5HWlhk?=
 =?utf-8?B?L1ZrQS8vL1RZcnRtVnJ0T1RGdVNIMFcrQTZsbEZwMENFMzlnZXdxbmh1TVVO?=
 =?utf-8?B?bFdrY29yMkJaalZ6S2ZZdE9hYzI2UzcrR21hdkJKeUJ4VnVBMDhQdGJqZTNo?=
 =?utf-8?B?bnRPUmUwNkEvczkybmhPdXcwSUlpajJQakU3UG41V2t1c2NyMnB2SG1kWVdz?=
 =?utf-8?B?NVA4ZEdkYzJ1NmVlNmRrOUthaXlEOThRY0xBY3dNeUhYR1dWdkh0NmRmN0pO?=
 =?utf-8?B?QmFTVU5mL1daSjFlcDltb2RLaHgxNnVYUXpKUndCMVRXRHd4elJzRDY1NXc2?=
 =?utf-8?B?RUxDODhBWFlLSTduSGFQT3F4MDlITHNrZWJCYU5sZ3h0KzVhMHpJN2tmei8w?=
 =?utf-8?B?MmFsMkpFUXhHaHdSNHNtL1luVDRQQ3FXU2Y0S3lxcnN6VWZ0TzV3RWxLVVdJ?=
 =?utf-8?B?bGg5VWZ6STQrcVpsZE1yd1hnSjUwNmRHdklweldodlNUdXJVZTc3K0hiQ2Zk?=
 =?utf-8?B?cU9Id2UreTJydTQ4MVk4Wkc5SWQvajhvRE94UFdQemtIUExiY09VZ3IxdTVt?=
 =?utf-8?B?R1BJNUdMZmd0QmNIWER6aVQrckI3QjF2My85dGlGK0J6S0VHOEFkS01YMG1N?=
 =?utf-8?B?Q2VGTTlVQ0FQVXJMU2wvekd5SEpFaHFPbVY1ejJnVTQxNHp6alI1eGs2b2RK?=
 =?utf-8?B?TEcwcG1IYlQ0OEhSQVdUanl3cGlLcDBWV0dzUDdDSHRBakt6STBjL1ROUm02?=
 =?utf-8?B?SmliRjZZRVBrOG5reUYyUkQ1RXZ6WjM2T3l2eDkrUDhIU2Q3K2FwbGtGaWZB?=
 =?utf-8?B?Zjh4aUlQOGFHVko3S0pCb2FEUkZHcFhmMmdSTmFBeFJUSFk5VG5pajUvOEp6?=
 =?utf-8?B?YUhwajZpdXRYb2tBbHRBdkhHUWR6OXNGd1VsdDZWS0gycE5na2tuaVY3THg3?=
 =?utf-8?B?MTB6ZXBYSHc3MmsyWWl3a3prR3RoRld0STJJT3VQQXdFZE5BVW0wYi9wT2d5?=
 =?utf-8?B?emw3S1N1TXVoc0RucG95eEsveFlqWlJiUERXY3k4L0ovTkcrYklYV3hmVWVo?=
 =?utf-8?B?Q0FsKzl6WitmYmlwSUN6bjNUa0o4RXYrd2pTQitKSGpwbzVNQXVBanAwMUpL?=
 =?utf-8?B?M0RIa24vYnZUeW9TdWVGSno3NWk0bEdIK1pld0xEQVBwQnhObU4vRnJVUlMx?=
 =?utf-8?B?KzBtTmN5Q1ZkNTVEaC9VNUNqOVpvb0Rvb1cvTXVhVlZnMFZHd0hPNEhaWGVY?=
 =?utf-8?B?anF4VC9Xd0cyUDFrVU1ZOEhCQUlKTG5KNWtRZFZiYUlyZHh2MnlZUUpPV3dv?=
 =?utf-8?B?cWV0R0lhak5zRWF1WiszNTlGR1pVTEpDc3Vrcm9rZVZEVnBMbDYzOGlDS1pm?=
 =?utf-8?B?UFFwMklUdW9UUXQ5UVlubEp5a1V3aXk0M1IrM2RaWkMweHpNVnNZYW5ML0s2?=
 =?utf-8?B?Q1hDdTFpQUZzeFhXelNXVGNPbHFVN2lIb01qY0U5cmt6TDRVUGUrNWR4Uy96?=
 =?utf-8?B?NkRjeDNpdUllOWY5a0IwdnJ3R2ZKYzZRbGE0MmZCWXBIaTlNWG1kcTc2Um5m?=
 =?utf-8?B?R1BNUHByZTlaVUFMNGN1N1pBQkRPeTFrUk55eGEvYkk1YlhwNFdWWEJoRk1V?=
 =?utf-8?B?bFpzMitiSFk5c2tTY05FSUluclRPSTJLS21ObENFWDN6czBaVm1HUEpodjFQ?=
 =?utf-8?B?SjZKSE1tUnBzTkNTc3hPUGdheG85RkY3QTRtMFUyNzFrbzRQQlk3bU5Ka3Ra?=
 =?utf-8?B?U04vSVc5c2l0bksvRVd3QWs0NW9HSCtQL3VQbVN2bzRNTHFLZUR3OUh1L1Qz?=
 =?utf-8?B?cjU2TXNvcEZKZGZhQyt0aFFVSjJGZkNhU3dCMVE1RC8xUm83MURWeE16T2JI?=
 =?utf-8?B?d1Z3NUIrejJJL2RaUkRqRlh0eGJ6OU9jVG92bmZHS01zZ3p3bmc2eVcxTHQz?=
 =?utf-8?B?bVJ5eTFsaE9qbEVyUXlPM0NyQktFRnlzL2k3V0ZacVI2aXcrcW94MEtEc2dj?=
 =?utf-8?B?OHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D48C7F759D59114DA5C95C118AA448A6@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ca47a67c-6fd1-45cd-ddab-08dd1ffab7e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2024 06:59:44.3704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E22QibR0P9bbVKtQEaRK4Vu030jERoG75yGXSAVCaEBwYh99sPtJe4k7OHIqH2SiEFrRCAoOHz8CI2E4xOAKHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR15MB4180
X-Proofpoint-ORIG-GUID: j5VanV7tGH1Mca294Y7XQJ2ziV2fXYau
X-Proofpoint-GUID: j5VanV7tGH1Mca294Y7XQJ2ziV2fXYau
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

DQo+IE9uIERlYyAxOCwgMjAyNCwgYXQgNDoxN+KAr1BNLCBBbGV4ZWkgU3Rhcm92b2l0b3YgPGFs
ZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+IHdyb3RlOg0KDQpbLi4uXQ0KDQo+Pj4gVGhpcyBw
YXJ0IGlzIG5vdCBuZWNlc3NhcnkuDQo+Pj4gX2xvY2tlZCgpIHNob3VsZG4ndCBiZSBleHBvc2Vk
IGFuZCBpdCBzaG91bGQgYmUgYW4gZXJyb3INCj4+PiBpZiBicGYgcHJvZyBhdHRlbXB0cyB0byB1
c2UgaW52YWxpZCBrZnVuYy4NCj4+IA0KPj4gSSB3YXMgaW1wbGVtZW50aW5nIHRoaXMgaW4gZGlm
ZmVyZW50IHdheSB0aGFuIHRoZSBzb2x1dGlvbiB5b3UgYW5kIEt1bWFyDQo+PiBzdWdnZXN0ZWQu
IEluc3RlYWQgb2YgdXBkYXRpbmcgdGhpcyBpbiBhZGRfa2Z1bmNfY2FsbCwgY2hlY2tfa2Z1bmNf
Y2FsbCwNCj4+IGFuZCBmaXh1cF9rZnVuY19jYWxsLCByZW1hcF9rZnVuY19sb2NrZWRfZnVuY19p
ZCBoYXBwZW5zIGJlZm9yZQ0KPj4gYWRkX2tmdW5jX2NhbGwuIFRoZW4sIGZvciB0aGUgcmVzdCBv
ZiB0aGUgcHJvY2VzcywgdGhlIHZlcmlmaWVyIGhhbmRsZXMNCj4+IF9sb2NrZWQgdmVyc2lvbiBh
bmQgbm90IF9sb2NrZWQgdmVyc2lvbiBhcyB0d28gZGlmZmVyZW50IGtmdW5jcy4gVGhpcyBpcw0K
Pj4gd2h5IHdlIG5lZWQgdGhlIF9sb2NrZWQgdmVyc2lvbiBpbiBicGZfZnNfa2Z1bmNfc2V0X2lk
cy4gSSBwZXJzb25hbGx5DQo+PiB0aGluayB0aGlzIGFwcHJvYWNoIGlzIGEgbG90IGNsZWFuZXIu
DQo+IA0KPiBJIHNlZS4gQmxpbmQgcmV3cml0ZSBpbiBhZGRfa2Z1bmNfY2FsbCgpIGxvb2tzIHNp
bXBsZXIsDQo+IGJ1dCBhbGxvd2luZyBwcm9ncyBjYWxsIF9sb2NrZWQoKSB2ZXJzaW9uIGRpcmVj
dGx5IGlzIG5vdCBjbGVhbi4NCg0KQWdyZWVkLiANCg0KPiANCj4gU2VlIHNwZWNpYWxpemVfa2Z1
bmMoKSBhcyBhbiBleGlzdGluZyBhcHByb2FjaCB0aGF0IGRvZXMgcG9seW1vcnBoaXNtLg0KPiAN
Cj4gX2xvY2tlZCgpIGRvZXNuJ3QgbmVlZCB0byBiZSBfX2JwZl9rZnVuYyBhbm5vdGF0ZWQuDQo+
IEl0IGNhbiBiZSBqdXN0IGxpa2UgYnBmX2R5bnB0cl9mcm9tX3NrYl9yZG9ubHkuDQoNCkkgYW0g
dGhpbmtpbmcgYWJvdXQgYSBtb3JlIG1vZHVsYXIgYXBwcm9hY2guIEluc3RlYWQgb2YgcHVzaGlu
ZyB0aGUNCnBvbHltb3JwaGlzbSBsb2dpYyB0byB2ZXJpZmVyLmMsIHdlIGNhbiBoYXZlIGVhY2gg
YnRmX2tmdW5jX2lkX3NldCANCmhhbmRsZSB0aGUgcmVtYXAgb2YgaXRzIGtmdW5jcy4gU3BlY2lm
aWNhbGx5LCB3ZSBjYW4gZXh0ZW5kIA0KYnRmX2tmdW5jX2lkX3NldCBhczoNCg0KdHlwZWRlZiB1
MzIgKCpidGZfa2Z1bmNfcmVtYXBfdCkoY29uc3Qgc3RydWN0IGJwZl9wcm9nICpwcm9nLCB1MzIg
a2Z1bmNfaWQpOw0KDQpzdHJ1Y3QgYnRmX2tmdW5jX2lkX3NldCB7DQogICAgICAgIHN0cnVjdCBt
b2R1bGUgKm93bmVyOw0KICAgICAgICBzdHJ1Y3QgYnRmX2lkX3NldDggKnNldDsNCiAgICAgICAg
LyogaGlkZGVuX3NldCBjb250YWlucyBrZnVuY3MgdGhhdCBhcmUgbm90IG1hcmtlZCBhcyBrZnVu
YyBpbg0KICAgICAgICAgKiB2bWxpbnV4LmguIFRoZXNlIGtmdW5jcyBhcmUgdXN1YWxseSBhIHZh
cmlhdGlvbiBvZiBhIGtmdW5jDQogICAgICAgICAqIGluIEBzZXQuDQogICAgICAgICAqLw0KICAg
ICAgICBzdHJ1Y3QgYnRmX2lkX3NldDggKmhpZGRlbl9zZXQ7DQogICAgICAgIGJ0Zl9rZnVuY19m
aWx0ZXJfdCBmaWx0ZXI7DQogICAgICAgIC8qIEByZW1hcCBtZXRob2QgbWF0Y2hlcyBrZnVuY3Mg
aW4gQHNldCB0byBwcm9wZXIgdmVyc2lvbiBpbg0KICAgICAgICAgKiBAaGlkZGVuX3NldC4NCiAg
ICAgICAgICovDQogICAgICAgIGJ0Zl9rZnVuY19yZW1hcF90IHJlbWFwOw0KfTsNCg0KSW4gdGhp
cyBjYXNlLCBub3RfbG9ja2VkIHZlcnNpb24gb2Yga2Z1bmNzIHdpbGwgYmUgYWRkZWQgdG8gQHNl
dDsNCndoaWxlIF9sb2NrZWQga2Z1bmNzIHdpbGwgYmUgYWRkZWQgdG8gQGhpZGRlbl9zZXQuIEBo
aWRkZW5fc2V0IA0Kd2lsbCBub3QgYmUgZXhwb3NlZCBpbiB2bWxpbnV4LmguIFRoZW4gdGhlIG5l
dyByZW1hcCBtZXRob2QgaXMgDQp1c2VkIHRvIG1hcCBub3RfbG9ja2VkIGtmdW5jcyB0byBfbG9j
a2VkIGtmdW5jcyBmb3IgaW5vZGUtbG9ja2VkIA0KY29udGV4dC4gDQoNCldlIGNhbiBhbHNvIG1v
dmUgYnBmX2R5bnB0cl9mcm9tX3NrYl9yZG9ubHkgdG8gdGhpcyBtb2RlbCwgYW5kIA0Kc2ltcGxp
Znkgc3BlY2lhbGl6ZV9rZnVuYygpLiANCg0KSSB3aWxsIHNlbmQgcGF0Y2ggZm9yIHRoaXMgdmVy
c2lvbiBmb3IgcmV2aWV3LiANCg0KVGhhbmtzLA0KU29uZw0KDQo=

