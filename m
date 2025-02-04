Return-Path: <bpf+bounces-50432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A36AFA27856
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 18:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 067B118872F3
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 17:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43742163AB;
	Tue,  4 Feb 2025 17:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O4o6iEIr"
X-Original-To: bpf@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2089.outbound.protection.outlook.com [40.107.96.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA197215F7E;
	Tue,  4 Feb 2025 17:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738690009; cv=fail; b=PltFfNUQ9SiQZeXKCWBhP2ld9WwWEG0jbDUuxolR8JPdJfhCKjdSiDmFONZs4JifcaiIq+PsA8HOfGuwVMZU0w/9UWCi0VlH/x6iVPnMByB8j9HFKFRqmNCVrP0FLbT8SJRYeNZMbMhS7VtzlipQU3SDWl77mgqzvrSA27ycRlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738690009; c=relaxed/simple;
	bh=RJv4b2+JCnbRa8cEMxqRo74aYw1NwlWlkGG1VZtI/JM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g/dWxxDZge+itcklRB4TMVd8KnM4a3cBJlRh/BLNfvLnaop5rjsqm2yTlZVdn5SGQujAt4/o3T8oEB2EKHeHv/6OsVGOjlcMdM53Fw5YtQF05vvWwWfhY7aqRz3ON68zx74gJnrOVJTkava69sO5WiQcnUuh+hbiFqr5AnWqAko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O4o6iEIr; arc=fail smtp.client-ip=40.107.96.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJmjf45a8Zq3Pn7/F8voimCEn5W0CzVkwVTY54AhNMNnoiuRwrP21RlCMMgKbCS9dpMH7KdSAP3u0Ojw9yj45pAQiFGasQkfDZbsKQe319VSsld7fYpBF/W49kNE7PAgc0Qfhm7E0ZWtBnvl+da4kFsXhazRObBomwDKFW5PA2TD2RD/l7G1TZTEwwM8o++wOO37+502f/zMCBLIKIrTYFjeCbqISntRbqZCb0SVYU4Ugy012vzSVmVyy3hbkPl1nWVz5456MUgjRSSZ+epBaOd5tE0LnGOPSrVQOUN/G59JKY0h2IosZmzdCdN+qF5ffZCfl2O+he8jvr46ANzfjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJv4b2+JCnbRa8cEMxqRo74aYw1NwlWlkGG1VZtI/JM=;
 b=d4Xai02gSwJqimcj2I9MzqsNVqp8tsJXWh9LY2HMWHmzyAgwEdTQJBiIIEeBe6gR/hDZvv2Psjkk3vPkmjo86brtjZMlObJwAFvy+dsjO00fADr1+b+E8/I/X7r58IQe+qrgbW5BlCFNTYRH7uHfCffgtvFOkduljS3kpCCFBrjaksn7SGdzL23fxIWGJxFdnrMCfY2wwT05wvMZpCsBap49IESNC1R6uldWCTr7VHwZVsbcAcTdRXoqCTAo5vc19lg78tRT2hpEM1VzBLfy+tZzsFjhlRRbgYYgB1+xZM7qGoQJYP/CMcn4qkk/iHPMvXQMOSxgNoa5sHZxZZEhSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJv4b2+JCnbRa8cEMxqRo74aYw1NwlWlkGG1VZtI/JM=;
 b=O4o6iEIrF5xW5EMK3+LnyraL/lA7ytKu0YrCTbAVi7OznoQPm45Y9CtqWp3VXcdFRbxn9sy9MrrtgUbQ5Ru3/t0UbY4OxVgMWBvCOxqZ3v9IDUvwg7IrwUcKq+q9kgZ0L+/hkGM/JllT/OrJz2S7ATwX/DnSML702C3LKMMZHCl6Ha4Q6ldWpF4p2JpKVyE+26ONRc/YgpdcfOU1EO9GGExLkgZ01ZHH2RMCNjn6vFY0n8fNPxScjXEZCgkBjw9UHWUXxwzfLjzAipoxpYNzef88kNwFmDKLIWk2FaHyWIZWNVOxbtWS+a/roa73S+o0qD4Csnz5jAg103iAQFXa/A==
Received: from BL1PR12MB5922.namprd12.prod.outlook.com (2603:10b6:208:399::5)
 by DS7PR12MB8322.namprd12.prod.outlook.com (2603:10b6:8:ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 17:26:43 +0000
Received: from BL1PR12MB5922.namprd12.prod.outlook.com
 ([fe80::5851:fa86:f137:1858]) by BL1PR12MB5922.namprd12.prod.outlook.com
 ([fe80::5851:fa86:f137:1858%7]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 17:26:43 +0000
From: Amit Cohen <amcohen@nvidia.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Network
 Development <netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, bpf <bpf@vger.kernel.org>, mlxsw
	<mlxsw@nvidia.com>
Subject: RE: [PATCH net-next 00/12] mlxsw: Preparations for XDP support
Thread-Topic: [PATCH net-next 00/12] mlxsw: Preparations for XDP support
Thread-Index: AQHbdvTSSF23zIgvCUCVpF8bzJYgQ7M3TLQAgAAAhaCAAAEqAIAAALmA
Date: Tue, 4 Feb 2025 17:26:43 +0000
Message-ID:
 <BL1PR12MB5922564282DA2C2C5CA671C1CBF42@BL1PR12MB5922.namprd12.prod.outlook.com>
References: <cover.1738665783.git.petrm@nvidia.com>
 <CAADnVQKMN4+Zg9ZG4FpH9pJw4KdmwWmT2d4BiJgHUUQ-Hd7OkQ@mail.gmail.com>
 <BL1PR12MB59225F7D902ACBC6A91511C3CBF42@BL1PR12MB5922.namprd12.prod.outlook.com>
 <CAADnVQLJfd201t_-bgWHRJRDHm4FQDNapbmAQhPd18OEFq_QdA@mail.gmail.com>
In-Reply-To:
 <CAADnVQLJfd201t_-bgWHRJRDHm4FQDNapbmAQhPd18OEFq_QdA@mail.gmail.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5922:EE_|DS7PR12MB8322:EE_
x-ms-office365-filtering-correlation-id: 28247587-0310-4fe3-76b8-08dd45411823
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QjlnNENrd1oxeklyV3R0ZWhqZDIrM24zVzQraFM1M2VHM09oT3hMY1FoU0gz?=
 =?utf-8?B?R2RFRURJVENwMFE2Tlc1V29lTGt2TGJvTmtpVUZlWWVpalpWbjBlbFByVDh6?=
 =?utf-8?B?YlA5V3hjRDNubmlwT3cvc2tRVUpWQTROcEQ1NU1Td0tGaW5CcHpoL09UdmRo?=
 =?utf-8?B?ajlOUWlQeXpySkUwUktOSTVpQk5LY0ZWd0pYTVJzMUF2SSt6RDdlT29NUERM?=
 =?utf-8?B?REJ2WGcyYVVkUEpOZmRWRVB0OFhwczJnQzBWdnZRVFRNa29yWkdxZ0xSZ0JV?=
 =?utf-8?B?aytkY0lkTmU4aWdobGtDTVl4aXVRZVJwYXp5MTRIU2ZFL2hVcE1QVXdwSnQ5?=
 =?utf-8?B?YnM0c0xRTkUvL3hwMTJyWWhhSmF0RVg0OEFnRVBnU0xqOVFhSkNpdHFZcGVi?=
 =?utf-8?B?UERockh3eEVTck5ZZVVaUDJWaVBUZG53dVRRKzlkR3ZLKzloVlpGanl4eG0v?=
 =?utf-8?B?dWZZdGw3YUxJY3FlTGtQNDlCbHYxQlhUcGxkdmd0SEJLVEw3c1Q3aUVsSmNt?=
 =?utf-8?B?WlV0cms3V0dzT2IrcWpBbmMxdW5UZHl5eEZZL0RFNVlzVzR4TlNWVzN1aUtn?=
 =?utf-8?B?Nm9XWVlLRzJGS001Q3QyeTBBL05UU3RHcmlCc0dXMFVUQ3FHcDBwZmZrWjZz?=
 =?utf-8?B?dXRHV2trU0taV0NiUmJtUmd0R25MQUphdjM0Z2hDU202Y2cvekZyRjd2Y2lD?=
 =?utf-8?B?aFoxbDFCN3JacVBWUGUyakI0Ulp4NTRRTm9pejlKTjg4VVk4UkYvazdVZmJn?=
 =?utf-8?B?V2FlcEkrYzJ6dU5Wd1pwNEVySjJQZ1pFTmNINHRramR5K1F0NEhzVVdoVDVW?=
 =?utf-8?B?WE1WOFVqamFVb0RiTFhheG5xV0dNaVdzZHV4YUlBaFZrUXRwM0lFQWVMZWxu?=
 =?utf-8?B?WnFRMWR3M3lPUFZaUUloNTQ5a3FxeGhKZG1XR1Y4NlBzUjIxN1M5WUxzZG1y?=
 =?utf-8?B?OWhZdzhqSWFsWUpHRk52MzdudHZtRDZuc1BjZTJBeGM3QVhaN1JUM2t4QWJ5?=
 =?utf-8?B?Q1h3VHpaSDlYVE9Kb09xM1BrdWc4TXIxWEVnYjNlTnVEVldvRVl3dWR3S0pD?=
 =?utf-8?B?dGRCYXpaV3hQdSs0VlNaOWU1cm14eWFMMENPazErK0ZDMmpjeGRVRFpjS3RQ?=
 =?utf-8?B?OUFwdFNTa0xuOVBFa0ZpaUI5YzVzNDB3N0tUSkhvdko1QzY2RmE4SzlDUFRk?=
 =?utf-8?B?SG1vSVBmUjRQSk52ZVhTUE9PMk5GRC9xdkdYclFaeFNFZXY4OWpLYkVrbDRa?=
 =?utf-8?B?RzFZZEhyYmxlT2Q1UlkzN2lHN3kvMVI2SjZ0SnljZ3g0YXAwVlNoakJPN2hX?=
 =?utf-8?B?QzJCbWllTVZnVmIrVmpuOTZDZzdFbFd2ZUpuMXZlSnpJN3dRY29nUUJmTnY2?=
 =?utf-8?B?Qk1mRFhhTWhmQVpzV2JoOTFYVXhzeHJzVXZ1cjlHZ0oycU1uam5uMzlsUVRr?=
 =?utf-8?B?WUdSU1Noa1IrZnE2WUVCVm9acThZY05PYXZOK0dZRlFwWFZzTTRnOGxoY29D?=
 =?utf-8?B?dlZRNUlKeTdLQUdRTWFjemx1MHhuNDN0RFFPMXZiaVZtWDZYbmlkVHlvTGZw?=
 =?utf-8?B?ZGJPWVJQRHZyL0N2K1RxMkc2YmdDOVRFbGVRTDVUWUJNcllwOEJKTnRaS2FC?=
 =?utf-8?B?OHRyRUpyRWZIWE92QXdObElkL2pjeDVlZThqRTRPc28rZWwwejNsdDZmMnAz?=
 =?utf-8?B?Rzk3d3ZCa0xnNW5wVkhhZEUxVU5RQ2lPZXo0d1IxTlZNZE4yNVJSczd6a0VQ?=
 =?utf-8?B?ZjBXb1RmVmt1c2VNVzA4Q3Z3a3JoWW80eGk4ZXMxdmNxaVFsNy9jdHF3TVFI?=
 =?utf-8?B?NTRSM3JzbWdZZndiQnVwZ0pWT3F2NENOc1dvQmdUSzZxblhZc1UzOUppUzF1?=
 =?utf-8?B?cnFUNTRQYzdrRmlnQ0FFN2VqTXQybkQ3RG1rYkkvK0JnVklzV2ZLUkZ1WGJ2?=
 =?utf-8?Q?XJQk+53BGG4+871fXo/NWSael6qnM0bd?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5922.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VXU4ZGwwL0V1c09RZFRYNmZqS3FjaXFVa01uSktreXkweWF2UjE1L1REamFl?=
 =?utf-8?B?enA5cFdOb0ZJYmtBUTlzRHRhLzJHV3RGWkJGb2lYZlBVS1Y3QXNwZDdhNlBx?=
 =?utf-8?B?ZEhVamZEbHRNTmtkVDZrOWhMUk1sTEVlT05DRlM4Vm5xZ0tVNmxBdWhWOE5y?=
 =?utf-8?B?SUFXcDhGbU05emY1dThFQ1NyeDBYRC9tWXJBUnVxWmx3b3BnMHhsUUgxajRh?=
 =?utf-8?B?RDBnS01SWmRvVFMvRXRVTTM0QjE4aEg1cFI5OENuYnhUdmdzRUtON2gvNmRI?=
 =?utf-8?B?RHA3QkkxRUN1RlBDRkJIckhsS1hDWS9jd0pVb3BzblJMVDBxcXMyZnBycnBO?=
 =?utf-8?B?aFd0dmpaUzY0bCtuZ2hCdnc2VURXMG9GVlJuM3BNTVc2Q2dhZFdWNk5JR2JQ?=
 =?utf-8?B?aWpOTUxXYTU0eC9pUVk1KytXS2ZpY2ZpbXBDcVFyRWhTSy91bkRjcXUrUGs5?=
 =?utf-8?B?TUxKZnZZd205TkFNT1FjV2cxdHJxTFBXd2RZQlB0THBCdDBibEtHcmwzczdE?=
 =?utf-8?B?eXNDSk94UlkvRTJaK3paQWlDeG9BcHQvMDhERTBsUmNlNmFKQmZCb0hzTE9P?=
 =?utf-8?B?Zlcwa2d5TkF2QnFCMXhQOGxzdUYySytkZ21hY2RKdW0rbWc5ak81ZU1mK05v?=
 =?utf-8?B?RFRoTlR6WHAvSkNIelZ2M2w5QUduRktCN0hpRFZ4Y01BaFdmV2FJOVA1SVdN?=
 =?utf-8?B?M0VJVGhic3JoN1JwOWkrN0JGak8xdU16S0FVQWk4VmtHVktheFM2N0pzN2p0?=
 =?utf-8?B?VzE3TDFiby8xWWwvaDhHS2J4TmhKZml2WC9UR3B0VktLdm81bWo3THlpN0Rt?=
 =?utf-8?B?UkRhS3ljUnJieDdXYXFFV0RxQVgxSDJPNjdCbFdlYllnZnNkYnNhMUEzeGw4?=
 =?utf-8?B?NTZhakFtWkh1QjIwNCsxOWZ4M1VTUVVYSTh6Zkg3S2hNNk4yWmwrN1hUdmg2?=
 =?utf-8?B?a2ZVZXdHYWtmd1JtdklpMVQ1RFpuSnJFK29IL1piR2w1Sy9GeWlRNi9yL1ZY?=
 =?utf-8?B?YXk5RmFxY0dIUTFjR3lFdVZJUlZPa2o5K3RaZlpPbFk2TFBBdHNWU3hjV2t2?=
 =?utf-8?B?M0lMdXk5R1FQYTFNWFZRK2ozM2wvbFMvT2ZaeGVQL3cyVjJ3RUFFWWMvbDYw?=
 =?utf-8?B?U29vcWUxVmZsMEZ0clhCUXdSSVBNSFN1emFvV0hSRTJWRHI2a3VKYmtnYmhL?=
 =?utf-8?B?d2pUdFMyUHdQcjB1Q3RBTkl1SUNXUE9GdXZkUytqN2o4YzArTjFtd0NISHU5?=
 =?utf-8?B?alVJczl5Ynh4ZGxlb01jeTMxRHlZaHhiL3k3YXJNdXpXck5WMDhyYmY5dVdL?=
 =?utf-8?B?ek54UUh2bXF5VmltTldoZWFJeUJJa0k5VnFFL2JaR3pySVl3Z1psNG5mNC9s?=
 =?utf-8?B?VGZXUUpBKzRueUphMzROMnhhcytQR2dIeDBBSWVBMHFKaGN4Sm50K1VoR1JP?=
 =?utf-8?B?VGp6UFl2QXhFOXIyNjZXdmdkaER2aDYvRHR2Z1U2aHhXS1VUL0lDbC96ZDFR?=
 =?utf-8?B?cmlLYytSL0RRM0NDa0xsMTU4cnJ0dVdYSW95OFVwV3lMeDNhVDhrVzFubXBB?=
 =?utf-8?B?c2xhT2dWbzdmTm0zai9ZN1dHSVVvQnJORGY1cytad0ZhZUJCZS82dHNnOXpR?=
 =?utf-8?B?WVczM2Mremhzc3BpOUV0d0dHWnZodlBoV1dvTXFuVFo5NUdIQmVCdFdCN1BE?=
 =?utf-8?B?aVpxRDhabWJ3M2gzVERRQldXQW9sOE5jVU9FTWdsZWRnenh6ODB6a2tGOW5k?=
 =?utf-8?B?OTRqNDMxYmdQSmV5M2tsK2IwTnpuc1RmVzZqRjZubEt1aE80azg2N013ckxW?=
 =?utf-8?B?OFpDckpreXR2OEIzcTJkeGtVYWFqNU5Wd3dKMytMOGdJdGoyS2hhUWhRV3Vr?=
 =?utf-8?B?dVNzc2hSTHJTdzFERW5hZWI4L0pyMzRnbjlRZXVaQktaWTlpSkt2UEh3WTVO?=
 =?utf-8?B?d1kwQ2JqNjExaElxQnlIaWlRZHdBUklZZ2laSHVleElJY0JLVzJnOWFoVmlv?=
 =?utf-8?B?cUVIajh3L082cDFDcloxc1I0UWxFS3BlSzFtL0grZWw2UUVidFNxbldHd2lq?=
 =?utf-8?B?QVByTVFZNGNCWHp5bkF1V2JOZUkxNGtKdTZDTEVqMG5EWWpIQ1VtOThYMDFC?=
 =?utf-8?Q?4Am99u3Hp+LerQFhpvzanXS8t?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5922.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28247587-0310-4fe3-76b8-08dd45411823
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2025 17:26:43.6040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jpx3nKvRpnn5WHs3a+TNWp8FLHJjjy4xom6ZknZDBA14T/vNudBeH7D9fACh3lAMc/rICvhzBzxiidQqud6t/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8322

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleGVpIFN0YXJvdm9p
dG92IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCA0IEZl
YnJ1YXJ5IDIwMjUgMTg6MDINCj4gVG86IEFtaXQgQ29oZW4gPGFtY29oZW5AbnZpZGlhLmNvbT4N
Cj4gQ2M6IFBldHIgTWFjaGF0YSA8cGV0cm1AbnZpZGlhLmNvbT47IERhdmlkIFMuIE1pbGxlciA8
ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47
IEpha3ViIEtpY2luc2tpDQo+IDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbyBBYmVuaSA8cGFiZW5p
QHJlZGhhdC5jb20+OyBBbmRyZXcgTHVubiA8YW5kcmV3K25ldGRldkBsdW5uLmNoPjsgTmV0d29y
ayBEZXZlbG9wbWVudA0KPiA8bmV0ZGV2QHZnZXIua2VybmVsLm9yZz47IElkbyBTY2hpbW1lbCA8
aWRvc2NoQG52aWRpYS5jb20+OyBBbGV4ZWkgU3Rhcm92b2l0b3YgPGFzdEBrZXJuZWwub3JnPjsg
RGFuaWVsIEJvcmttYW5uDQo+IDxkYW5pZWxAaW9nZWFyYm94Lm5ldD47IEplc3BlciBEYW5nYWFy
ZCBCcm91ZXIgPGhhd2tAa2VybmVsLm9yZz47IEpvaG4gRmFzdGFiZW5kIDxqb2huLmZhc3RhYmVu
ZEBnbWFpbC5jb20+OyBicGYNCj4gPGJwZkB2Z2VyLmtlcm5lbC5vcmc+OyBtbHhzdyA8bWx4c3dA
bnZpZGlhLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQtbmV4dCAwMC8xMl0gbWx4c3c6
IFByZXBhcmF0aW9ucyBmb3IgWERQIHN1cHBvcnQNCj4gDQo+IE9uIFR1ZSwgRmViIDQsIDIwMjUg
YXQgMzo1OeKAr1BNIEFtaXQgQ29oZW4gPGFtY29oZW5AbnZpZGlhLmNvbT4gd3JvdGU6DQo+ID4N
Cj4gPg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTog
QWxleGVpIFN0YXJvdm9pdG92IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPg0KPiA+ID4g
U2VudDogVHVlc2RheSwgNCBGZWJydWFyeSAyMDI1IDE3OjU2DQo+ID4gPiBUbzogUGV0ciBNYWNo
YXRhIDxwZXRybUBudmlkaWEuY29tPg0KPiA+ID4gQ2M6IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1A
ZGF2ZW1sb2Z0Lm5ldD47IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IEpha3Vi
IEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbyBBYmVuaQ0KPiA+ID4gPHBhYmVuaUBy
ZWRoYXQuY29tPjsgQW5kcmV3IEx1bm4gPGFuZHJldytuZXRkZXZAbHVubi5jaD47IE5ldHdvcmsg
RGV2ZWxvcG1lbnQgPG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+OyBBbWl0IENvaGVuDQo+ID4gPiA8
YW1jb2hlbkBudmlkaWEuY29tPjsgSWRvIFNjaGltbWVsIDxpZG9zY2hAbnZpZGlhLmNvbT47IEFs
ZXhlaSBTdGFyb3ZvaXRvdiA8YXN0QGtlcm5lbC5vcmc+OyBEYW5pZWwgQm9ya21hbm4NCj4gPiA+
IDxkYW5pZWxAaW9nZWFyYm94Lm5ldD47IEplc3BlciBEYW5nYWFyZCBCcm91ZXIgPGhhd2tAa2Vy
bmVsLm9yZz47IEpvaG4gRmFzdGFiZW5kIDxqb2huLmZhc3RhYmVuZEBnbWFpbC5jb20+OyBicGYN
Cj4gPiA+IDxicGZAdmdlci5rZXJuZWwub3JnPjsgbWx4c3cgPG1seHN3QG52aWRpYS5jb20+DQo+
ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldC1uZXh0IDAwLzEyXSBtbHhzdzogUHJlcGFyYXRp
b25zIGZvciBYRFAgc3VwcG9ydA0KPiA+ID4NCj4gPiA+IE9uIFR1ZSwgRmViIDQsIDIwMjUgYXQg
MTE6MDbigK9BTSBQZXRyIE1hY2hhdGEgPHBldHJtQG52aWRpYS5jb20+IHdyb3RlOg0KPiA+ID4g
Pg0KPiA+ID4gPiBBbWl0IENvaGVuIHdyaXRlczoNCj4gPiA+ID4NCj4gPiA+ID4gQSBmdXR1cmUg
cGF0Y2ggc2V0IHdpbGwgYWRkIHN1cHBvcnQgZm9yIFhEUCBpbiBtbHhzdyBkcml2ZXIuIFRoaXMg
c2V0IGFkZHMNCj4gPiA+ID4gc29tZSBwcmVwYXJhdGlvbnMuDQo+ID4gPg0KPiA+ID4gV2h5Pw0K
PiA+ID4gV2hhdCBpcyB0aGUgZ29hbCBoZXJlPw0KPiA+ID4gTXkgdW5kZXJzdGFuZGluZyBpcyB0
aGF0IG1seHN3IGlzIGEgaHcgc3dpdGNoIGFuZCBza2ItcyBhcmUgdXNlZCB0bw0KPiA+ID4gaW1w
bGVtZW50IHRhcCBmdW5jdGlvbmFsaXR5IGZvciBmZXcgbGlzdGVuZXJzLg0KPiA+ID4gVGhlIHZv
bHVtZSBvZiBzdWNoIHBhY2tldHMgaXMgc3VwcG9zZWQgdG8gYmUgc21hbGwuDQo+ID4gPiBFdmVu
IGlmIFhEUCBpcyBhZGRlZCB0aGVyZSBpcyBhIGh1Z2UgbWlzbWF0Y2ggaW4gcGFja2V0IHJhdGVz
Lg0KPiA+ID4gSGVuY2UgdGhlIHF1ZXN0aW9uLiBXaHkgYm90aGVyPw0KPiA+DQo+ID4gWW91J3Jl
IHJpZ2h0LCBtb3N0IG9mIHBhY2tldHMgc2hvdWxkIGJlIGhhbmRsZWQgYnkgSFcsIFhEUCBpcyBt
YWlubHkgdXNlZnVsIGZvciB0ZWxlbWV0cnkuDQo+IA0KPiBXaHkgc2tiIHBhdGggaXMgbm90IGVu
b3VnaD8NCg0KV2UgZ2V0IGJldHRlciBwYWNrZXQgcmF0ZXMgdXNpbmcgWERQLCB0aGlzIGNhbiBi
ZSB1c2VmdWwgdG8gcmVkaXJlY3QgcGFja2V0cyB0byBhIHNlcnZlciBmb3IgYW5hbHlzaXMgZm9y
IGV4YW1wbGUuDQoNCg==

