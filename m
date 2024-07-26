Return-Path: <bpf+bounces-35766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A514C93DA1B
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 23:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 169BCB222AA
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 21:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EB2558B7;
	Fri, 26 Jul 2024 21:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unl.edu header.i=@unl.edu header.b="r5PeMBy8";
	dkim=pass (1024-bit key) header.d=huskers.unl.edu header.i=@huskers.unl.edu header.b="g4PYVRSh"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00246402.pphosted.com (mx0a-00246402.pphosted.com [148.163.147.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A81C1CA80
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 21:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.197
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722028545; cv=fail; b=BwVFsLNLlnJ1IImaQZD+IHJAYuKNp6uim/oRTgxXkvtYYta9o2TvBI0JuNqEepNRW8W4rO/foYUDcGlS++rX45btDc6Y87eIiKCbcaXhLVkoXVkdQqGNKxELwe7qxwI+YpPnvXy+lagBDNOUS7FIHEmOyLtgUtrRd/43uQt20gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722028545; c=relaxed/simple;
	bh=MMyxjI0ToCk6PR3/A0S0NO7jRt+5G/HuiBNAlcgb/f8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kpoth7WzvxUT2Gi85w2bugWIyE+Vt8wH1qNz06aknfyM9qrdy4GPNSySDTunrIxvGM0yyAtYA5Q6Yt+IIYxARVjxEuUnhRcHl5zDNJO5mn2HaHkTC6uucC5wcD8ssAeTJ2XIGFsH1rvVv9Xuu7ilU5ILuadB0xjHP7qdCO2B69w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huskers.unl.edu; spf=pass smtp.mailfrom=huskers.unl.edu; dkim=pass (2048-bit key) header.d=unl.edu header.i=@unl.edu header.b=r5PeMBy8; dkim=pass (1024-bit key) header.d=huskers.unl.edu header.i=@huskers.unl.edu header.b=g4PYVRSh; arc=fail smtp.client-ip=148.163.147.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huskers.unl.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huskers.unl.edu
Received: from pps.filterd (m0136266.ppops.net [127.0.0.1])
	by mx0a-00246402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46QHW2nk003462
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 16:15:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unl.edu; h=from
	:to:subject:date:message-id:references:in-reply-to:content-type
	:content-transfer-encoding:mime-version; s=pppod; bh=ellPbE0WC4g
	HCOTcidcrsmNPib9KJl8Scc23y6bFgoU=; b=r5PeMBy8wOB1HVkec9g+wirZ/zh
	KJkPTq6GAEMo0VYxCm1eKGTx+3PPI036TGICDxsy42dBrjPLtFG2bA9LvRmDW/z6
	d7UiguEfiVIOg8cSteeRwfULpR9FL1VBTpPOYaasf47ifhbg3ClHZNpyWfwcITxX
	xZMvUjoNn1KcBc8ZmJFq9WbyCmvFZkASCqDg+Z6ksBGKgnqAiOKQNAc+Ya2LFepA
	nu4ZcbvlmLiyIfxlQ+Fl06z1TRl4yI8EdclBC/UFUDjh++WdHkwdyY0o2J3GHGpS
	ydOjZMGE1tdHPsS7RCAjyfteO8J+ydc45hGA6+vHIZ+fip3VP5dptQbmbtg==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by mx0a-00246402.pphosted.com (PPS) with ESMTPS id 40kuf0btsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 16:15:42 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kp8KQXPt1RI4QQ6rVEPSLUBX9KR4BqDsuUCmfU+hrF38X4kBjOUbgCGAg3QU/kJkdiRS8MqFY3vHyVWDm7iN+M9Z32kwFY2M1O+3zhf0qmFGuJI0ZrC08yE/sdy5MH31JTOwzz9DVU/wcONBZ0YITmcDW6ubyyxr6on1OI9SvCCr+NBVBohPu5uJZvfa9VUKvqxRj4nuTQP0F0AoPpWF8bGnFKBlnzYdx0lR2IfzEQTjcSdXjaZz4GS44YeUDOxu4NOZHzy9YLEOGt4hhujZhQ3gpLzXsXJno1OQawqy5cWgHqcQZDoMuc9qX4GCbAhxA6vfDqDgYVXNyYgkbCur2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ellPbE0WC4gHCOTcidcrsmNPib9KJl8Scc23y6bFgoU=;
 b=cyGjNEc29irVEoAIOIPm/gW9Au4bySLgC9H705eIcF/jozV5ypdJL5Hh0fTVzWoDghXm87lRriN4KH/FMq0ifgu9vJCl9caRQrNNjevSs0kkF/Vpu5MNhJBXmUBPfNQESyrH8a2wZfzZT2bL34aG3OVXs+oqs1h8lpegG6nCe+22Xvepl8W2gCun4uNazlTe6TpSR49Im4ypPxRJAaeVMQS28lBIrp5G+XjBL6x9jwwHGs/v+/ov99oscZdXud9yseqDHL9egyK2FJ7WnVl+/czPH7Z/1pUfepV+0FMLRudZNvaTxwIStZXWgajYN7Cdtbb4PyFS3zD3fon7D1ErGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=huskers.unl.edu; dmarc=pass action=none
 header.from=huskers.unl.edu; dkim=pass header.d=huskers.unl.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=huskers.unl.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ellPbE0WC4gHCOTcidcrsmNPib9KJl8Scc23y6bFgoU=;
 b=g4PYVRSh0dUbmEusbj3KVSj1MnzajEiuJ85qQzCmXrFTfmcP/hrz3haMiRNffqrhgvzrfaOW+AxyczP3Vp1oE6g7kMaFzgwzmfwLtN63rw+iQmn2v3Vk2C8fUs0YcKhz+ABJO3WwlQRs3n7XRvVzh3c3cEGAHwGL+65EujuAZQI=
Received: from CH0PR08MB8662.namprd08.prod.outlook.com (2603:10b6:610:190::22)
 by SA6PR08MB10379.namprd08.prod.outlook.com (2603:10b6:806:43c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Fri, 26 Jul
 2024 21:15:38 +0000
Received: from CH0PR08MB8662.namprd08.prod.outlook.com
 ([fe80::59a8:55f7:b002:71b4]) by CH0PR08MB8662.namprd08.prod.outlook.com
 ([fe80::59a8:55f7:b002:71b4%7]) with mapi id 15.20.7784.017; Fri, 26 Jul 2024
 21:15:38 +0000
From: Mingrui Zhang <mzhang23@huskers.unl.edu>
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Assistance needed with TCP BBR to BPF Conversion Issue
Thread-Topic: Assistance needed with TCP BBR to BPF Conversion Issue
Thread-Index: AQHa34AHe35J9A4oDkyPgvojAqBo2bIJcosw
Date: Fri, 26 Jul 2024 21:15:38 +0000
Message-ID:
 <CH0PR08MB86623CB07E3EB7CC3D370AF78EB42@CH0PR08MB8662.namprd08.prod.outlook.com>
References:
 <CH0PR08MB86628C12C14CCAB20681BCA38EB42@CH0PR08MB8662.namprd08.prod.outlook.com>
In-Reply-To:
 <CH0PR08MB86628C12C14CCAB20681BCA38EB42@CH0PR08MB8662.namprd08.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR08MB8662:EE_|SA6PR08MB10379:EE_
x-ms-office365-filtering-correlation-id: fb21b11e-8375-4c0c-2e1d-08dcadb81937
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?VUt0Cn1GznzespGdFHQL0yTVXoLlCoTZb2SGufLG70OuWoKotVjFT8zw6E?=
 =?iso-8859-1?Q?DU0M6C51QD4VzCJlV01hPFVlOmBGzOHe7/xn6ku2LGkEGobdf2wYwxwbx7?=
 =?iso-8859-1?Q?KmqIHLZjagnL9+OaGFbBDzoEGLf8Amw1vm0h6o6TS598A+qC6yKi0KmBr7?=
 =?iso-8859-1?Q?7SO1hEHUsQ0M2QTpNDkxggv32zMYHcWMQR4wKvxuzgBJlpTDgDwUhOyA4/?=
 =?iso-8859-1?Q?Z6QT72aJb9gkt8O6xwVoVXlv3IHxtrZAaIPmvhxhxxeCEMD7aNuGXAB1ru?=
 =?iso-8859-1?Q?Qyt4ZF9WqHyakaNL0ZDT/wsHAYvkdRGQ+dGx90fNR/fA5G4hqtxtQP/j27?=
 =?iso-8859-1?Q?bnVtBQ34hH3qWsOhHvu2N0MQy41cwzn8t1Yvl0a2RCxYJaVCySyz5WpVQZ?=
 =?iso-8859-1?Q?SLDCFqw/vPIA/M50H2btElp8plOiKkMPaVQhJ1eIPuVrKWw2fVFX36a0+r?=
 =?iso-8859-1?Q?h4UAdAJAqgK1RP/A/AKDWlGQp7D1ADUYGB9zoS16iLvfNtxoBoaaerye/Z?=
 =?iso-8859-1?Q?po4JWR6cbsr13wdVdLAU9RJqWNxAY18C5R9SOvccHzZ56A/IVz9UxHiFIM?=
 =?iso-8859-1?Q?A4vdVwLC+h4t+s4CCIuyw5oa/aVVJsnZ5m+WAsKdwhlSnvEn8wqe0WAOCi?=
 =?iso-8859-1?Q?qtMrSwFLbMgIMLFnWvmzew1csJHVlLrRsH/julEKdF1Lz2ImjJya26Wa/O?=
 =?iso-8859-1?Q?5ZD7W22o0V2CZAOIEx+H9Q3dxF9jPM813H5c9sFnHWqotI6wVNxdOiRJ0C?=
 =?iso-8859-1?Q?MmwvLpKisp9Ka4qMxPFG0CYvyCz5wr/7t2U50KPfYShogilU12a7ah42cQ?=
 =?iso-8859-1?Q?5mW/fqWB1Wri+QS1puQLf2k693ARi8vA8Jg5VnBesNVlIRWuQwQQojLjZi?=
 =?iso-8859-1?Q?dHX2ih0Mzv6Qz/v2DvS5jdjHS8dvuNEdtdJztKsnG4MqS6beMU/3guDgrK?=
 =?iso-8859-1?Q?bEnybItFXURRhYr9CuuS+kXJGbazyylXCkFsAC1dHweSJeiQTBSIeZVL1y?=
 =?iso-8859-1?Q?91uo158caFpuQIgbNBmGZlcAbuz4f+QS9bSr3Vp5g5msg4aJmjiUUpepAC?=
 =?iso-8859-1?Q?GVOEBJf8HpQOUw9E/9U8ehCIhnykgCb3fZnGwzfJp+T6+RY0XPwP5AvrqA?=
 =?iso-8859-1?Q?q2p2wkwB/OhKtMsWuxnzISRAR1xo8dtvTKdtbUQDDOwJ1ARG83V6/SSXOG?=
 =?iso-8859-1?Q?ZDAqfKRZjtgRRFzFfYpYIV2m1tKtvNGeQEAKPeoEXkHZvdVmN4VDeO45aK?=
 =?iso-8859-1?Q?8LKT6vRFlcQsgBreUEwFS5u4I9XRV8PJyT6JCavMcmW1Kl7oiCr3SDlU0a?=
 =?iso-8859-1?Q?sP90MUE9KMHr53qDTTzbVX57eshmTJZUZShL7xBPkdTz8tAdKQRSyb+zn2?=
 =?iso-8859-1?Q?0+lmM4x8HbFQ6qxPpUBAhQ5w0ENVTDhikHta+BLbILNGJWwDOZj9k=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR08MB8662.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?V1RgRIl8EwG9wJ72cuTu3v9aubbY0/W1lC9+I0sEPUv1rZCZIzoQ621Bhs?=
 =?iso-8859-1?Q?n1xstH7OksBkui08VLuiWu8+nYBPsRXdhEsfxa6/pSvuJv7FrqRq2CIToP?=
 =?iso-8859-1?Q?o95CEztGufpd3XmCqbsS/cM+uralmHro9uvpxGn3q3c7ebXZZBZgaceHL9?=
 =?iso-8859-1?Q?NNO1kcmYsYcw3sqatbDQ5+ThQTQ+hUZa5Q8k04wfokHMdLTiS1lppjRU5p?=
 =?iso-8859-1?Q?wHC66iVc9i6KRh1Gv/isEQctrSbekQw6TrxPYZxcPJ5FK2MLysDvQSXDk3?=
 =?iso-8859-1?Q?v2L1J1SxtIVJmeyWhvigcMpia6G6iMgqvaZiKZr88HHy5Gvxk4yjOOO/+F?=
 =?iso-8859-1?Q?R7ae4ZXfD9PWXEvooeIZKeBqbWyGC6R//F/mmbtpi0GEM+92GYES+0oDtq?=
 =?iso-8859-1?Q?nELhAfVFdybD9DmM7Iutaz5IKIE8s4yF3OV/CMk6aDOiKKEJXbFp05FJY/?=
 =?iso-8859-1?Q?olEYqIwg+nYip+5V9DUlMauXK3z0x9Mw1A4Czog97DH37n3yaLSD/s1STP?=
 =?iso-8859-1?Q?JdCU3rsa07GEnbOR1sQcutdD1CTpLJn9qFw8gto+Xrt7vjgmwbPJxi4deG?=
 =?iso-8859-1?Q?fN/TQt3QVKz09ua7RMyb1Fc+xF3n42s+U7as91N2UvPZdcTaYp4bzc7Uep?=
 =?iso-8859-1?Q?nVNj6h5WJ/mdOyz7viLni/jrikUNIp4eCnG7ZnWv18mpuIBkoz+XHLvo7q?=
 =?iso-8859-1?Q?VD8FvTp9XSiKruYeHWIYS0xC6R6h7Cqk+7XtzuaTBiupxSX+x3LzAKZ3yC?=
 =?iso-8859-1?Q?MHhuzkUScFWjGAD30MtGX5CFrFRahffBq6YAf4zqNR8jSY20rJoUJ2v1/l?=
 =?iso-8859-1?Q?pk2sWW5elGiJGsdL3E5Puxz8Ucjckb4eJjsGuUfvIhfPKHoul8BsVSkOPX?=
 =?iso-8859-1?Q?zkzrwMDk5GUnYA7IkfqddSF5FDNbvlAHjg2H8A2nus7hfnZpTh28mCmr1r?=
 =?iso-8859-1?Q?E+hq7v7lv+5l0F7gkOlNTvFg5wU+1jcWpZrPr4lJjF3t37gMeLDhyqR0jU?=
 =?iso-8859-1?Q?FLjlCzn/2Z4pYTl7qsOwLb5u18W9zzUr0xrlufqfzf1Sz5IH5S7wCv/sNP?=
 =?iso-8859-1?Q?L5bi13vrokK8A8HbYrH3jBDQsksJJE1PNBqTjaYeotHhjNSvJMs7A0Ofdf?=
 =?iso-8859-1?Q?n2EFXf7n3oqEK08PJVU4TWSJ0vcmNONor6b/qF9B2WeN4LeZjdDTo174zp?=
 =?iso-8859-1?Q?ouxRuGukJ2j8PiAJ5RDKGqoQPiVufqnz0kRYVQqozv/XtXmszLXYG4BfZg?=
 =?iso-8859-1?Q?LX4wrWCbLSG0qHJuO39BR1JrpzffcYymx1SEQUahiyu8jWwIu6Y+0Gp4vr?=
 =?iso-8859-1?Q?kyYzIYLdBMd7vczSfXOhBQARjg2tHq3UFBFk7bAvIRsLc+8cC/8SncE1gw?=
 =?iso-8859-1?Q?HRRazHN+O1XzNbn31xMiuoMx8n4HTH8jPYj7EzMoz4nhuGF1yNQbDBkLnj?=
 =?iso-8859-1?Q?4mUG08BEWr3wkg3hHunoRZf8i51zyQS34yZBFPNr3D8xP9uI7JAighHI7R?=
 =?iso-8859-1?Q?WiVyfZjlRnfpm44Vccr7O2fZQxDCMwELEb/+iCgHykEwx4YlPeHF3myQRZ?=
 =?iso-8859-1?Q?NuIJVFz4sftH+SO48xu+luAiq2mEMIv5NlyNr5/8CgmkD/p/LBOjn028UB?=
 =?iso-8859-1?Q?dRi899LaFgV8U=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: huskers.unl.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR08MB8662.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb21b11e-8375-4c0c-2e1d-08dcadb81937
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2024 21:15:38.8100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fddb01ad-4983-436e-ab35-1af043b818c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: efA/q0jNmdDSOOV1OgBuka8JspB4MaTgu0zIJ0TGMyTQ7iRywLExD2FBVbe5XTYmJ8crRr0O7XkWeu3LQ87Scw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR08MB10379
X-Proofpoint-GUID: WgD8Qx09jbRnpVhhKGF9f02xMDvZb8pf
X-Proofpoint-ORIG-GUID: WgD8Qx09jbRnpVhhKGF9f02xMDvZb8pf
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=584 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407260142

Dear BPF community,

I am a student currently trying to use the BPF interface in the TCP congest=
ion control study for faster Linux system integration without compiling the=
 entire kernel.=A0

I've encountered a challenge while attempting to convert TCP BBR to BPF for=
mat and would greatly appreciate your guidance.

My modifications to the original tcp_bbr is as follow:
* change u8,u32,u64,etc to __u8, __u32, __u64, etc.
* Defined external kernel functions
* Removed compiler flags using macro (e.g., "unlikely", "READ_ONCE")
* Borrowed some time definitions from bpf_cubic (e.g., HZ and JIFFY)
* Defined constant values not included in vmlinux.h (e.g., "TCP_INFINITE_SS=
THRESH")
* Implemented do_div() and cmpxchg() from assembly to C
* Changed min_t() macro to min()
This is the link to my modified tcp_bbr file https://github.com/zmrui/bbr-b=
pf/blob/main/tcp_bbr.c

I use "clang -O2 -target bpf -c -g bpf_cubic.c" command to compile and it d=
oesn't output any warning or error,
and the "sudo bpftool struct_ops register tcp_bbr.o" command does not have =
any output

Then the "bpftool -debug" option displays the following debug message at th=
e last line:
"libbpf: sec '.rodata': failed to determine size from ELF: size 0, err -2"
Additionally, the new algorithm doesn't appear in "net.ipv4.tcp_available_c=
ongestion_control" or in "bpftool struct_ops list".

I did not find much related content for this debug error message on the Int=
ernet.
I would be very grateful for any suggestions or insights you might have reg=
arding this issue.=20
Thank you in advance for your time and expertise.

For context, here's my system information:
Ubuntu 22.04
6.5.0-41-generic
$ bpftool -V
	bpftool v7.3.0
	using libbpf v1.3
	features: llvm, skeletons
-$ clang -v
	-Ubuntu clang version 14.0.0-1ubuntu1.1

Best,
Mingrui

