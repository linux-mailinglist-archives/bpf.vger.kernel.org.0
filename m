Return-Path: <bpf+bounces-53958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 685B4A5FA0E
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 16:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DEEB17DAEC
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 15:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C059266B5B;
	Thu, 13 Mar 2025 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="F1ttXctD"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C6C28382
	for <bpf@vger.kernel.org>; Thu, 13 Mar 2025 15:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741880044; cv=fail; b=s4iFgsVTEMRD6ADXFUFhwfgqFTDoyN9NaN7CSWfrrSiNj3E/yYGAAoZLQW4ff7HePsTDoEFlNJ5NthL7LWSlJlWR0r6voVV+lxbO0I176HNzbmK+FheNObZUWcXLWxZQen/m/5gFlu5KBrZ4e4YfV0TemxBmp0NEn5QqiwmH1wQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741880044; c=relaxed/simple;
	bh=AssBjzJpBnVcC8j/RGURr0vTijqfM6G/893O4sYtODw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NScX/eMRqxRSPx5dD4DZ1stjBUPIaiINh2KrlGY8DI+BlG2js1N5nyKB67SWDn84EDa87pVoEBEpB0DGKIr3OEoK4BrmS3nC66weUM+3QV76MYsm3zF9uVLAymIY961AM0c5NWLiZdRULD3Zhmf5643gCp4JmyBYw0lil0ycEoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=F1ttXctD; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DFD7O4001000
	for <bpf@vger.kernel.org>; Thu, 13 Mar 2025 08:34:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=
	content-id:content-type:date:from:message-id:mime-version
	:subject:to; s=s2048-2021-q4; bh=AssBjzJpBnVcC8j/RGURr0vTijqfM6G
	/893O4sYtODw=; b=F1ttXctD1ygYS6lUsPab0QNUE94SY82wo0BtyPt5MP9J7SU
	vaoG5eeNU7ru8K50m2BmhvpZcjLfrh+PDUoNHWU5zvKmduMR6qgBq5/yJsYDfDr3
	O3JxXF2Y7CVOUe0r4X9NDDr/wH09qvFDFZn0YUTWqItO475zFUsfRMrUgXv9xD39
	JCCUNY2UW9naf55l0D8ncXHOtHqK3Rz7O0wVTzBf/2HSVsfzlzvfoHIC+PFxAFEf
	qucNeqlsF8vxtw2i0Z72PCyw3+6nhl+sQEf65Lp02ntTkNftPUyQgPupxgD2Xuck
	hnHmieyVkAtGowAVZWNdtJerC4QFLSFmuEvef9A==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 45c1mc8ap7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 13 Mar 2025 08:34:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SaI6XzLHZmVIyZND6Sk8aUVRTFvDk1o2f6v14U+RO+GifKNN6HowcXY3HI/043bT2MNPLBXj3Ihi0kjaqmYGgP5o0jglATvLkWy8xEPm2AN3kVRh0aC+WIeMY3fRB8kO/PMiU/+gXbmR/k/zwydsvUUBXDv5Fn+m+sTcoZ2vVY4F4IgqO3HdLVv5sWgSmlnMaehqKTTAvLH9OX7UlnrVNO8Fo8fVL9eVvWSoYMc2pmtv005kXmCosA3MBlAoNY9aApV7rLjUL2mWlKDBn0Ta57UPZjh+USCmbMWBfyRivojrYRdd1xk9D5CTc0WgpsSnGQjGHExHhkzYNHFuL4GmQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AssBjzJpBnVcC8j/RGURr0vTijqfM6G/893O4sYtODw=;
 b=ivAWayuBcEdy1xNatJe/qm38b7PL31+SDK1sTrE3pPiKNk6BCJddVhDJDJklgC3Hm5h6HowPsou54I+p5Blx47pJki1jwGdvaTFGKLP/uQ6RgdL0MocLe9FFrDoQC0/hJfpv9cUBNsluCO4zrvJeuBfBOGil97jOgHNaLKn8P+wqd1Z8Wx66Pz5GkRkGjrQFQzJtECM3skkwvLnZIgXzcPVbL8u2MGvrgyVfdQvSOQmqfc4Qp5FNfDvMFvGGUV8j924uME8k2BBbbAX2fd+MQbr1ff1km74H4e3cSPcltawf6PA51uBCCVLtIPx+mIhptrSJ22IDj1oPVJYEf5nE9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from CY8PR15MB5553.namprd15.prod.outlook.com (2603:10b6:930:95::13)
 by SA1PR15MB4481.namprd15.prod.outlook.com (2603:10b6:806:194::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 15:33:58 +0000
Received: from CY8PR15MB5553.namprd15.prod.outlook.com
 ([fe80::a64a:22ec:3eb2:eb21]) by CY8PR15MB5553.namprd15.prod.outlook.com
 ([fe80::a64a:22ec:3eb2:eb21%5]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 15:33:58 +0000
From: Mykola Lysenko <mykolal@meta.com>
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: BPF office hours discussion for "Reducing BPF register pressure"
 moved to 3/20/2025
Thread-Topic: BPF office hours discussion for "Reducing BPF register pressure"
 moved to 3/20/2025
Thread-Index: AQHblC1Wmkq+ISYrqkWy7GBYBRXKBA==
Date: Thu, 13 Mar 2025 15:33:58 +0000
Message-ID: <0907D3DC-A5FF-4B5C-8F6F-16D5CDA5DDF4@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR15MB5553:EE_|SA1PR15MB4481:EE_
x-ms-office365-filtering-correlation-id: 466db5c8-b06e-4bd9-e392-08dd624478e2
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?MtQdgtn67XpULprTBPeNr57uh86wziesMnk1zigEPgjVvf5m6XwrmWWnHqSU?=
 =?us-ascii?Q?WDBAINC5J5T8GxRHayqNLON8H1A0PD5NoDQ3qBBkJfzGyMc//Wlv83m5AdKA?=
 =?us-ascii?Q?pQZ7WLBG1b5n903pLSHHsjJKCRfQA91+glOZF/otJVTi4G6stxoR37MYLNXu?=
 =?us-ascii?Q?3p+0NkCVd879W2y3K3SQYwDJj3GFZbBg9EHThuNigZGeKMpMKHIa4hueFdSZ?=
 =?us-ascii?Q?ZuNMvxA5I/xKdYe738pnDHFiP19p+Sd1yagULcR/434N3TjeKUX6mIk9d10z?=
 =?us-ascii?Q?w57IsoHQMoopHKN5RaZldN6rOHDFqE/BD1cwI18/h8EZHHM2QfUvhAhO2PYd?=
 =?us-ascii?Q?Q1gIGLHuroxmlyIokk4ZyBdqt2TS3Ug5xUcgCa/VfY+S6Ki72knvcODWnbd6?=
 =?us-ascii?Q?dypxGuWeEc09xkyOTKrrXP8FQ/EkOzNOT6znafH7E0Ro28N8A8xuU3ScDU2B?=
 =?us-ascii?Q?90bj7Jt+OFffggG8en82OU2oJH2Jzdxla7JjZ/DyE9LiwULPCjJ6weWX8JYY?=
 =?us-ascii?Q?zkne46YjHCb0rYUFa68bLlfI8aM6XC+MbyyUiDKhwdOW8RZ02DTyeQ85Xxao?=
 =?us-ascii?Q?BYFXAclWOg60m1FiNEw0EOef2u4OM1NGjchA8CdrLALxToSJFMaM/wVFzsg8?=
 =?us-ascii?Q?1SVDgYD8C0zspF/dtihGWiNKOgNeTY3v/LLO8VO3N1nO/2LFpPBj+fQOGyi4?=
 =?us-ascii?Q?E/pnRp6bImxF96UdR5MVtv5e6Z9zmoDSZObWztFQXOxwLy/wvQZAEdLfKATS?=
 =?us-ascii?Q?McNXpFk+X2hNIVu6GKkMSQNZJ9LQSLvRim+Igh/Cs+3bLSnvRxKEJfFqM5RV?=
 =?us-ascii?Q?Ms9uX09XsAtALe5a1KAe0+ierRwKu3KNCW4C2dUOevLZQI+GutLNIo9rxbiL?=
 =?us-ascii?Q?tbQSk6cS5SFhhEcAZMVw5aboY20AZ7L+1vzqALaRtKr+VUrwIRDjk5V6YcIi?=
 =?us-ascii?Q?CuCn4wsyvkmrBa6DzUmDuSvmArLohWJhaESufZf+8p7NkLlLMc3XJruNjKAb?=
 =?us-ascii?Q?C5+YUMbrbPxPxFyCi8ySnmnKxf7Vuq/ODMy2SyARwjZRd5eSy6iMF/i96+1y?=
 =?us-ascii?Q?xnKnXDts7iQmO24XEiFzze+8lfiL2eMaeJcj6lHlSWts0ESea9dTulAXxM/3?=
 =?us-ascii?Q?0TfQbJZ12Fd9bqiajRIKnpy3FqeVKDA/XwDGsADsbtkBcUbRcWWfv58Hl+DJ?=
 =?us-ascii?Q?de9g/WzBzeitfEA9ZZmZIcf0OjfEoiQwTK4NHXgf9WCqvc88+PEyVzgdxx0w?=
 =?us-ascii?Q?Au2uAmQfE8lDhTe/Ll4cdz+JeuHPqvdU/sJd79BwT4R6bNO50HOGiAYcSIuz?=
 =?us-ascii?Q?FORg/ZV7Y3iBxAHHD92j3gd7z4QxAmmXr6zkAAJQ1yW/c9Hr0/AJ1p39bCRp?=
 =?us-ascii?Q?tZabXibyTObD4VmSurMivKYJevoRmApEpHzMCUMgX3b1wAyMtJzPmq255oZZ?=
 =?us-ascii?Q?k30deG2DeqUqT/tyyYwgXJSDvog1ieGY?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR15MB5553.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nSKsLXOs9zoz1NCiS7wBPH29wuNhIFVeit6YpMxhM6fr87vaKQQ0O+etSnsU?=
 =?us-ascii?Q?S8lxIF6EyjufMackot+yLVLqw4LVPc3jlkgGzVdJ6qux9sJMH/hWAiwtMB7+?=
 =?us-ascii?Q?EtOjNTY59q+R2sdH3DIBzIoRqbFwpBfG95Xz4yr9rGwAefgKOpKQBtNMiu5G?=
 =?us-ascii?Q?CWiGXPtuD0jgd4nT5crtet0lG8iFfU8ija+/WJTJXJELVJv363GlFBEC1j2W?=
 =?us-ascii?Q?MUZ9dzLad5UnKt1+35jx43MbfObPniNb2e8AElht7RvPpxtcCCbVCrw0ri7n?=
 =?us-ascii?Q?H35gLX1LS7veZVpNpoJ/7bz5m1rj9LbG9bifBbuHogKqsoiD1XK+Yf5OhR1z?=
 =?us-ascii?Q?ZAE47oCTTrJpQ0b7nitwtjkMEdv0xb+Y/SdReI/3TD4uBoQKHrl/kYnPeRlc?=
 =?us-ascii?Q?6/Q9auGcsUjdK/+eJnh1fNf67NMdi2NGRpcsNBDRMjWbT+NqTaTv/uC5DS24?=
 =?us-ascii?Q?VA4mizXt3DH0QtKIUb3RljDhSav+TrzwhNg0MXAYXuyDHVpcL8N4aRBoyCYs?=
 =?us-ascii?Q?OUvxX1VE9osA5w95Xpe8O2kxioxVjZNeoop+plcrC8PQHFWbL8MRZ1RZvFqA?=
 =?us-ascii?Q?DVsMK3aXaDAZypBirKl29UIQC+XrHyCve2U/RseJGKYt0BADprq26VZKquCz?=
 =?us-ascii?Q?QR18mb7oIsH577xmOrFsh0kNItz5SUmDUrWJ1grlgTDLmqXlneFqG9RjzLkP?=
 =?us-ascii?Q?RQmWJfWOts0wgutoQJDt0hZEW5p83uKLky1r0/q6q9w54kRDRra1kHF9qfF4?=
 =?us-ascii?Q?EU1Z4mR/ue47NBTZXc75DIjjUB6IWvUB2Sk++FdzScdGWN3m52KWB4J9zFhT?=
 =?us-ascii?Q?eygjVsrIE8zO06CjreWDZuosB/9xa1T4RdLKfBW+N5eNXjx/+drd/Sdhqakq?=
 =?us-ascii?Q?UNQjKB/wtg+/R1JQT1uyHUSukL1kVGjeTueEEJhwLhWoY7BeYy/FgLNOvyEN?=
 =?us-ascii?Q?v0XF2QJZw+4aY4BrFlQLOS/gQNHr9pLvm7KszFa93wMRhCYUyCwWdy+aJMw9?=
 =?us-ascii?Q?ZzGIj0WlM74TA7tpeX0SCx+vHeOy8pTXdvwBuY1lyuzADAgdgIZ38KgwgwoE?=
 =?us-ascii?Q?1G+EOQszoWHWsoUHiC65bHzW4u8sXHPIdkYVYXhuasrlN3g4etLbFD3oGNW5?=
 =?us-ascii?Q?X4QnrUfQ6XOz/eJme3k9qF/ErwLk5eshL2t/wKUGJiAl9Pds9XkJkN8eunHI?=
 =?us-ascii?Q?9RVgWcwkWNCjrgj6VzE923GgLdcZfZb1Ag1EWpQGFbAGWMF/IQn8lJfWOlnL?=
 =?us-ascii?Q?ANg7g7BgopYV9FQLLtwfCrPDo+a3dC//+kZb1WOFebku7Zf20X6ThCDiRps/?=
 =?us-ascii?Q?L+zvBjsQuBgAukaC5wnagesfY2sRGnWB1a5wYwf4iowkOtuSwysO64pjbB7B?=
 =?us-ascii?Q?sS0qF9hr9gj60XA3NSMIQwOfGSVDaT3EmMrpHeez/t6RS7wbxDb0FIMzJ+el?=
 =?us-ascii?Q?VIzLqMnHuIQolD9PAEckcXF5wyqJsnFvh4D1gkDrHaxLihIVa966vNdEopK8?=
 =?us-ascii?Q?hFOjpyturnGEBecdmHloUhsKely5qjJ+2BIdNqP33l+wEYu6Um/K5FFrXMyb?=
 =?us-ascii?Q?hTnBAT56bCjITbkKaLlNrn6szuO5XMDKLQ5dVG9i?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F9A0B2EEF54B4341A3A959B98D45FD43@namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR15MB5553.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 466db5c8-b06e-4bd9-e392-08dd624478e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 15:33:58.1845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dcz+63DtFnrgkJ+78Ie94eEoeo0d6EXHaD6aE+QBAl0NSOn7f7dP9sFQ+lQ1sbL2vTIkmLGNRRjmqwiVNTeHRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4481
X-Proofpoint-ORIG-GUID: 5l6YxUzUFsTgjfecJjUvmOoNIMU6Pd8j
X-Proofpoint-GUID: 5l6YxUzUFsTgjfecJjUvmOoNIMU6Pd8j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_07,2025-03-11_02,2024-11-22_01

Hello,

Heads up!

To have better attendance from maintainers, this instance of BPF office hours moved to the next week, 3/20/2025.

Sorry for the last minute change.

Thanks,
Mykola

