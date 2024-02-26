Return-Path: <bpf+bounces-22738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5FF867FEC
	for <lists+bpf@lfdr.de>; Mon, 26 Feb 2024 19:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B681B1F26D87
	for <lists+bpf@lfdr.de>; Mon, 26 Feb 2024 18:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F471DFF4;
	Mon, 26 Feb 2024 18:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="XyGqod01";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="KPvvSXAV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="roUteRnV"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A707A1292C9
	for <bpf@vger.kernel.org>; Mon, 26 Feb 2024 18:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708972798; cv=fail; b=egEumfqnDeYGBjmeAJ5HkskKs+RWXAjY2OMk1e4mmuLh+VZPBxJZyUshm4ORqNiOXGyWXA9NkMwCf/AyaQ9I9KsJu2hxfqs7JxUFBq9Gw6aDttPgSCaen6mbryW+NTMCOIVlGsXxaslLrPRP/2pqzq2E+oWimeqb1WXb0yujW8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708972798; c=relaxed/simple;
	bh=J+kXdziyHrXASErQpi0pS+t2/8Nj/nbF+QdXJ87kEwk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mOXss1YkBg1eijUOjQYKZ0h+5/AgohA1CeIjxEwhBCGuwfMjlTuWkExE9P3Lf+012JNa6Z1RqLrSBf0JiX8zQoDPWx0yEZArUgmbciZcLe78pMltMSGr/SN6O+jg7nl0g2m6tgvCusStjtuammyMc2QmWOdmJJfx0z3s7bMPuU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=XyGqod01; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=KPvvSXAV; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=roUteRnV reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41QGnq8Y010804;
	Mon, 26 Feb 2024 10:39:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=J+kXdziyHrXASErQpi0pS+t2/8Nj/nbF+QdXJ87kEwk=; b=
	XyGqod015fTG4Un7dxmpAIziTR7OlOuzMYHt7GlsGVOOjCAbLEtLgdIztMNEiARs
	apTi1RZNZWJTph8mxkHVf8mPT/GqdMkDEilnjSFZQwV1T43dSztcpZELq59PNbup
	wi2JPWT68bpWqxCmywJEA03KIwdJaKxxMWZhuFUhCsLFyreQLaJ91XorpwFwYkWN
	F9rXSNfpqfK7cuu3748jXML1nhohFzHpOGwQ1qRI/RlZjmjGJoRftxI8pPHGKL0A
	DAhbH0ByX58M1hu5BY9AWnoA6mCiFxz0G9ivi0Gc+y6InwGDFVGM6VvpuOj/gMVf
	wMIhR6mge8PyoK1rXLwCmQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3wfgbpq7fb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 10:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1708972766; bh=J+kXdziyHrXASErQpi0pS+t2/8Nj/nbF+QdXJ87kEwk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=KPvvSXAViEkw2C3XfoYE2ITxcvrQZFi+yhCM8y/aZob6+N4fmsAkiVQVrN5cHe5Gk
	 JxSBlTPw240D2HLhQimmbHtiixeOVJzjJ5L7zSagox7LlGbZ1nu1UnfSnuqeq8ijQi
	 woDvSn4XxmMGPDAHgSF9ETXVZmi99mz1prXQ15WqsRsadUGosALzEUE3w0eofDpNnW
	 hGTL/enbeQRIMET6RCVVrMQSpismb9+IJq6INbfyJQVD5fD6LJ1ho95poZxvnlCd94
	 RzlqpjH5yj+HlqYomNTYBPz+p/gFLiQy0HtMs1Gp4gXkqqVybeRw6JZFGPIJk+iPT3
	 6aSQEjFxpMSiw==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9B6CF4041D;
	Mon, 26 Feb 2024 18:39:24 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 465E9A008A;
	Mon, 26 Feb 2024 18:39:24 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=roUteRnV;
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 4B8DC401C4;
	Mon, 26 Feb 2024 18:39:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIi3nfWzKh43PTN9PADBDaNugp9efLy1bxan07nIHhVAZj4cHxDOEM6sWvaPMjlJC/dCAFMB0u/+nBQfw9aMV+YkIjQYEDMjuW1HsbvvpW1vbKpHtTloZ7lj/J+ZU24kiUaff9pG62vN1sPazhZQi7osqJOzkMc4za3vjyA/mbOdDqpKsjB1jriz7gz/atn14fzO4tYY26eruG3Xk+/2wiDraeNkLW/q2I5fJRJweM+WEZ7eoBqKEswez36knEKCO6IzKD785c1nenylYqZjUXIM7jOT4bREwL0fs1nLTGC/dMVYvRXJuVNOJiS2FthfmLgeicTijKGEqXDpKxcDBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+kXdziyHrXASErQpi0pS+t2/8Nj/nbF+QdXJ87kEwk=;
 b=IqQGEeJ/i0Gj5sdF/9w+al109d1gm/A3VbQUJgNoOE/ZXKfky+CCja99jxfm9/eDg5zlywd64AVOB1i8NhUbo390T7SYkA2ByJibmfNPFc1m9eSYK2Y7ujiMY895FUF1SMOTZN+YjDumLJ/6ZzdySxotumqvZvaptAHgloTLKpdq8TqFZo+Tx9tJx9bECYTurcdt6ZJuULrBwtwtzMSSgwSa0GV8h8ITx+3GZcZZfAIRXxUEuRJQhH8BC+5mxBT0Ca5VxAJoI79OH65gFl/j4sUMzDkYKgBKYS89cgAlWp/59OOykrR+17Mmj8LqhOKj/6/RDC4gMQE+27uVg4c9iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+kXdziyHrXASErQpi0pS+t2/8Nj/nbF+QdXJ87kEwk=;
 b=roUteRnVPx9zyShIXSigsxwphCUW8m3z85vv0lrO3fAbK5AKUc13Af/sbbMiWMoKoOom5HjC2izKBxs2zqHf9ad20aSNHLtCGOJXABR4MuViPZ3p7u808myKWfBnrD/3ylJos9GfVRpJ9KCGH5bzCYdKuCOhwaFvz+EK82ySftU=
Received: from MN0PR12MB6152.namprd12.prod.outlook.com (2603:10b6:208:3c4::21)
 by PH7PR12MB7306.namprd12.prod.outlook.com (2603:10b6:510:20a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Mon, 26 Feb
 2024 18:39:18 +0000
Received: from MN0PR12MB6152.namprd12.prod.outlook.com
 ([fe80::ddf:5ad3:7769:6890]) by MN0PR12MB6152.namprd12.prod.outlook.com
 ([fe80::ddf:5ad3:7769:6890%3]) with mapi id 15.20.7316.018; Mon, 26 Feb 2024
 18:39:17 +0000
X-SNPS-Relay: synopsys.com
From: Shahab Vahedi <Shahab.Vahedi@synopsys.com>
To: bpf <bpf@vger.kernel.org>
CC: "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Shahab Vahedi <list+bpf@vahedi.org>,
        Shahab Vahedi <Shahab.Vahedi@synopsys.com>,
        Vineet Gupta <vgupta@kernel.org>
Subject: Re: [PATCH bpf-next v1] ARC: Add eBPF JIT support
Thread-Topic: [PATCH bpf-next v1] ARC: Add eBPF JIT support
Thread-Index: AQHaXn9vAbQQ4sgF1keKpt5BE5H927EJIRaAgADNLoCAExqlgA==
Date: Mon, 26 Feb 2024 18:39:17 +0000
Message-ID: <ccba43ce-89f0-43f1-a40f-c6fdd33ee256@synopsys.com>
References: <20240213131946.32068-1-list+bpf@vahedi.org>
 <CAADnVQLvh3dd5tXcJnKJis9bJZNV-_dR203PXVyrubZHBuU2_Q@mail.gmail.com>
 <520bb8de-3515-47a6-b9e1-ede9d26b4658@synopsys.com>
In-Reply-To: <520bb8de-3515-47a6-b9e1-ede9d26b4658@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6152:EE_|PH7PR12MB7306:EE_
x-ms-office365-filtering-correlation-id: 754f3f2d-1be0-4e66-c51c-08dc36fa3d3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 drsJ2AmVwIBxeBHX50uOtWYg1uSC/UJYUVlqOSgIV3urjXvZqRFE9Ttj0KpZdtrKK7oRDos9ataeJPpRykmmq8htMYutxkntM5+OkwQ4hJk3fyoDKcxIZRGB6nDcNwyMridq2MM+cNmmTxNVUFTHAZtDePVn4zQaMu7mJw3g9TU3dQxcmLglmONWAt/ef3fJZUxNpc+awTpCU8hOMOoRMcnsy+SNChZM47f/Uun6q+JEgMHSHKukRkvsjajGxEcMYRW3Foax90oZFZAmkq9ZihDjJbP68BwLPU2rsg6n2Em17BxHikEcltXgdLZDRmuWGkU+V2q3cjVMMKWCrYpZ/ZmE+817B0FCzQt5LrygvRYfjaPfYdkJG//N8Nj1PDKWPB+jgzx41ewkfAP2O8OX9xTgEqeMV2Fn+UVeEwd7UZZtxiOezAYbnKSkGIhuO0AvGM5tHvCy8x6R9NR7npISEBl9ScpdsWrjhal6j54iVi0F6VgFy2G+HoKdSVqLinsIK/1LYTuTqWA86o5Q4glFVOIiV211Jr5eDBunaPUcsOIaOW+ZzahAAGNF5MwuEaqgOTJ5q28QBXtay+52/nwPlBEjqvUeZ8YJ1W9RRVS73D2+4eAD4CZUYgnNvi6qOEyAfHDbmwEsG5SOaKHqj2Su5QIPhMsRvmXnz98H1Vtx8wWaOrZnyDF3f1IMjMWJudzlE+6TYcoPgDNpB/5298VNnQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6152.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NkpmM3cwNFJiQkQ3UmNBNDVkVnpYZUljbWlzdEhheHYzT3lIVk9BdkhHYThC?=
 =?utf-8?B?QTN2aGt5K3pHOVB1NUF3SjBtY2VuZFU1amMvZnVYKzJKenZFMG9LTko1TDE4?=
 =?utf-8?B?RG9ZTmphdkFjMkpwRzEvdWdob1lxSHJCd3ZDb1lleFNSeFlWbzc1REdLTHl1?=
 =?utf-8?B?N3QzTis4OHpHUjZzOUxGT1JqWS9Bd2x4cysydXN0cjNkMjZGY1FpYjdOWEdB?=
 =?utf-8?B?aHIxcng2T0tyN3JkUWMxVEJvWkk3SzRZdGYrZkN3amM4ekxZaHNIbncvQ2Rt?=
 =?utf-8?B?MXdpenNra3lEQmF1UDl2c0hRcmZSWW1wSkRPWUplV3lMaUJOb0JOK3NnL2Zr?=
 =?utf-8?B?c1UyTy9DVS9HNy91ZkZQSnFONVZIVWdNcUp6ZEc1TjFYWDZBb1ZSNlZjV0wz?=
 =?utf-8?B?YjY3WFp4SHFGWFhWczd3U2Q0K3FHK1JmRnYzYXZUUVVRdlNCOXhrcFNJSUlU?=
 =?utf-8?B?YUg2UTRzaW5vMHhsMmJCdTBKSlQ3QnJpYjZLdGdkNU8vK2RHWWs3TWIwM2ZT?=
 =?utf-8?B?UHgvd2Zxbis3bnpJMnV2M2dHbUpXTnRla1l5czQzcGd2YnhmY3I4bEw0QnNE?=
 =?utf-8?B?bGVINHVVT0xpYnhHTGh0ZE1PUzdOQnZ2WERCZDBrVHpMN1dlQWprU2VTOHMr?=
 =?utf-8?B?MHdGVkUzQ09lZTJsYTdFZmd5TEYzS0QxSFlJbmdlcnBHcGQrelVpUFE1Zi9i?=
 =?utf-8?B?ZnlMTjY1MXFZMmJvVUwyV2R0NTVuQWdTVE5zYlE2aGNOVm1GdVR5U2htWXBO?=
 =?utf-8?B?bjRBY1M2MlcvN0pKZUcyQjYvVzNkcWZxa1lIaXBKZ01ybmFENzVFaUJQcHE4?=
 =?utf-8?B?M2QwTXdDa2gweTFGSVJIdVVlRmpoRHBzb0VYaVRIdVBVOFIxcEdLNEhqR0py?=
 =?utf-8?B?NTZzYW1qTlVLYkVQSk4zaG1lRk94Vy9hZ0pIL2t6ckFkU0YvTDBvbDBFWkYy?=
 =?utf-8?B?Q1Vsdkhvem5LOXpQUFVjT3ZFa3R4N1NYekVYYzNtTlYwRkcxcnFkWHhsMUpu?=
 =?utf-8?B?Z3R3Sldqak5SbTNCQTUyamVBRS81c1hTTkcvUmNvN21IRkRRRHZBczVCQ0NH?=
 =?utf-8?B?S2lyWjVzeVBKUE5hUU5Kcy9kVE9JTFdkb1g5djJmSXh1U0cwN01pSEhVRnpi?=
 =?utf-8?B?NzNwaFpoelBWeHpKcHRGTFUvMDFiZUdJR0hJVWN2SmhhQnNWTkNqdE8wRTRv?=
 =?utf-8?B?TGsyTjZrN2ZORmtCZXR1SmpBaWJBdUY5RTMwQzQvRkVMNWowaFcyMi9yZlJs?=
 =?utf-8?B?dE94SjVCQjRuMmpWZkdmU1Z5Z2NXTGJhSzFEM1RuSHVpeDhJcUxSVmhvZ2pz?=
 =?utf-8?B?akE0aWhxdDF1MjE1RVMwTTAzM0U4MmRoKzRQNmc0elRvZmdwdUNqRCszYkVE?=
 =?utf-8?B?Y1d3M3JmaGcxR29TSU5VZzRoSUZMVWRLdU55a1JzNU9kbHg1YzN3RVNoamhw?=
 =?utf-8?B?UmxHQ2NXQ1F5OGh6dWhaa0ltS1FuTVJWYWpPaDFIUjMzSEFZdE5UQ0p5dnFa?=
 =?utf-8?B?YmpPUHFpK1FjelAzQUs3TUtHTFlBaytCaUpTcDRUWkJiT3hUb2lFNjZSUWsx?=
 =?utf-8?B?dU9zSGJCQjltRVNsakFTUlo1ZDcwbVcxaFBHM2dnSlVsRHE0ZkRCVnVuWk1a?=
 =?utf-8?B?WnBWdHQxRkJ4cVBPNUo0KzI1VS9JdEp4amdpYzBPbmpaNjUxWjdCc2VVMXVu?=
 =?utf-8?B?K3BsZGZ4NWMwVW03c0o1UHNYUXZMQzhlTUV3NTd2UndNeVFRcG41ZmVNdlB1?=
 =?utf-8?B?bG5uWmdDTHBsNXA3U1NFdjR1QWgxejYycmdhRUw4OEgyS3g0NlI4WVlDWExO?=
 =?utf-8?B?djJIYVlPb2wwNFMyaU00cXlEdkhjV1dGT0Z3b0F6U2tJSjlNTlJ2VkFJZ2I0?=
 =?utf-8?B?d0Z5YzlTMXBmWU1MeElxZzdOUkt4M2FaMHh0dGUweGMrZ1ZyUzh3VXNBOE9S?=
 =?utf-8?B?QXNLTHp2U3VTS1VFS2k1bHBWblNsdHVCT2hpUDdXK2x6R1VDdnhQaEpPUVgw?=
 =?utf-8?B?RFI5U1pZMER2cWw3dmRxZG1IRk5xQ3VzTjUzT216VHdiSU9xeGI3YngxU1ph?=
 =?utf-8?B?RS80TzZyamVERGdhVHdraGlpQm9NdmJXTzFodHc4RDc1S0hrbEVCMit0dWtF?=
 =?utf-8?Q?lKhZpfpssIthQ3BQHAfjY5dgQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <64B077F9D3FB6E4B8FDD8028F4B6A754@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	l3huxpvG7gBYAan6Qo4Ph2RBRdCaS5U61jafdb17A/vELI4eytwEAAAQANOUQXY4AP7jiTTw+EM1S/c/GFdsHvgWLugEWu/JWTf8WGvbVg12J0TF3YVA6BFOYkYh5mxiFvX8ec//yRay3yQoRPotcXfQ4Gwf/09RPOPxW/wcsHdThaPO6OAnRY91LtLMr73Aud7PYN6bH4IMui3HFeMrKRb52LktXqY5/5bnFI1Ve50RsTRziWkNQy3DJ+07GIffzMq0gauAEewxrJwLL9fOB0qV/ZSaGpJKWhZxeKOogYTShB/NNMBKPqwVfej4nMOeAP5uZ19TEsBwSTEZwhujYLxLI2RE6luSXD214pqDLKL/wyZPZw+gKBARTFfE6GS40l0MLi+q11+3G0CIuzuEL8WHitgo5+KlzUEH17JXKrN5+vf1lYtgYyJzXU4rZuZZgbe6m6X176Ks+buSYNVCj/lr7jmUXflkKC6l2eLRK12xsm0lJcBjEK8wAGWECgCnggiZMw3mBodVL1YjNpmNk/77/f351vpQMb0G7wmmQEXR6P/QoTPPmRVbLcGet7/yX1wYpCdNzScA88K3JN58c8rdsr3wGhPcgbpFqQ5zstrwWGspep/TnMkmNvxcDLRJUFFWs1syHkd/LJb79aJ0Eg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 754f3f2d-1be0-4e66-c51c-08dc36fa3d3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 18:39:17.6478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q/ogrtxjAOqO4SOR6D+PSWDStzUKaq5EBBxmrcX+CSEwvQUI7g1taL0OUcdI6RwBDDDT7K32Lrcimm5jbGi43Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7306
X-Proofpoint-ORIG-GUID: kKn6rkvo4_8Qx00LYba36igOIknHLfGL
X-Proofpoint-GUID: kKn6rkvo4_8Qx00LYba36igOIknHLfGL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0
 adultscore=0 clxscore=1011 mlxscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402260141

SGVsbG8gbGlzdCwNCg0KSSBrbm93IHRoaXMgaXMgbm90IGEgc21hbGwgcGF0Y2gsIGJ1dCBjb3Vs
ZCBzb21lb25lIHNraW0gb3ZlciBpdD8NCklmIHRoZXJlJ3MgYW55dGhpbmcgdGhhdCBJIGNhbiBk
byB0byBtYWtlIHRoZSByZXZpZXcgcHJvY2VzcyBlYXNpZXIsDQpwbGVhc2UgbGV0IG1lIGtub3cu
DQoNCkkgYWxyZWFkeSBpbnRlbmQgdG8gY2hhbmdlIHRoZSAiY29tbWl0IG1lc3NhZ2UiIGluIHRo
ZSBmb2xsb3dpbmcgd2F5czoNCg0KLSBGaXggYSB0eXBvOiBpbnRlcnByZXRvciAtPiBpbnRlcnBy
ZXRlcg0KLSBNZW50aW9uaW5nIHRoZSB2ZXJzaW9uIG9mIEJQRiBDUFUgc3VwcG9ydDogY3B1PXY0
ICh0aGUgbGF0ZXN0KQ0KLSBTYXlpbmcgYSBsaXR0bGUgYml0IGFib3V0IHRoZSBwZXJmb3JtYW5j
ZSBpbXByb3ZlbWVudDogMi0xMCBmb2xkDQoNCg0KVGhhbmsgeW91IGluIGFkdmFuY2UsDQpTaGFo
YWINCg==

