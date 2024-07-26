Return-Path: <bpf+bounces-35693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC1E93CC89
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 03:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B41B28244C
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 01:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0481AD31;
	Fri, 26 Jul 2024 01:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YCDtAbiw"
X-Original-To: bpf@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021088.outbound.protection.outlook.com [52.101.57.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29844C99
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 01:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721958149; cv=fail; b=biVRuoUpYvm5iRkv6l1aitKc/2CVGpyU/DEY/WS4F4tNWbC/kd+bOUHV0xsUelx39xHxN1aQR7QTwAEEMpZ3uUnYmyLzzs3qjc7nsAC/Hfs7WiIczFVxIDe0JmhwE40SF1w1OHnYmP+UstatLlV/jUVNrJ2qNa6vzaax2ridKJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721958149; c=relaxed/simple;
	bh=CmRBsPQ+C/AEuSjPioZM3V5rZqMj/Qz0j7dOZ80xGzw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ju0dThIIGOTx+1MmX7qNKOUjmNxu3nEzdl97Flmb0hWhFMw6QRnj1haw9Ay5tDMOZTBtDw95T6R2v4HMztAzeQMXzV/tQVsWwGfiAJ4lEVKruj/5Rn1WbIqlQO18drxOx7E9mylPHWl6Ytv4yvuF3GnKEiVFZvlz63VyzM577jU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=YCDtAbiw; arc=fail smtp.client-ip=52.101.57.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RTtP0n1nW/JmpCwbRVsl14xvmhaLedv1kQ7iWgAt9vUKs3fosL1EhtNypeUEiGjcX3K/aaoHafGqKMxLml+F6HD0+yfLrDKwdJfO6J/3XxZvhTkIeTs1gIHl8+26W1Q5C5wp5T7kji9pipdItvMUwJIpcc96l6kXYvx3sux/+xjVp6bV+dJ/mZY/WKZ7z8mpfDgeCkViKuvbzRQWQnwrKxZ482DE+j4K9284ewVyQIopA2Y9II3Fi4PYfGC1EdOE6F8M9+e5yYizyB0EhGlnoWQ3JSuRgskQCgpm8SJdZKsx8cnO5oMUu+lSEQL1fmv+/UX7cAcSElAjm+Ogtj2Wqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmRBsPQ+C/AEuSjPioZM3V5rZqMj/Qz0j7dOZ80xGzw=;
 b=VtBngxzqSyam06F8V369KuxuQ/X23YF71zpC0xjJes69LHLuO0+6uzL4KeejOukkvhFPqRbpQKJcavGnmwrCzf4Dm5yA1VE8Z/JChfV3AXLW+VATaCVjJL7WqJoA6uFqUw3H61gZP6UNrzXLsnPPulhdfs+6ssWFN0NyEWE1y77CZgpoguFSRXDbFQpxMoZYMvhwLzZm9PONfOndVqpYGP8xtPnBuWWC1Q9agfcuBZQ/fB9ZGam6MpDK1d1qo1KFDjzXDjbHcuWdgUqjovUUvzb1rovssmFlZjW6d3kqFj3eWA7AIvvfABerJ0y1dNAW5TiAucW7eDoYr/o+pnThVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmRBsPQ+C/AEuSjPioZM3V5rZqMj/Qz0j7dOZ80xGzw=;
 b=YCDtAbiwk+Cc18SwPv8QH0qMiHgKxv4CmeHvHZZ0+DacTcF/3/NSYzaZy3ViXyY/xlbYrQEsXMFjD+5MKgOwRSfQ4vncirQJ1dSro3jEUahhnJrT9uJBUe5GhunqO98YtNEAnUvtINgX6Oru0mG4swb5XKHmhDkfz5N7fbDg3aA=
Received: from CY5PR21MB3493.namprd21.prod.outlook.com (2603:10b6:930:e::6) by
 IA1PR21MB3521.namprd21.prod.outlook.com (2603:10b6:208:3e2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.12; Fri, 26 Jul
 2024 01:42:12 +0000
Received: from CY5PR21MB3493.namprd21.prod.outlook.com
 ([fe80::103c:c670:fe7a:99ab]) by CY5PR21MB3493.namprd21.prod.outlook.com
 ([fe80::103c:c670:fe7a:99ab%4]) with mapi id 15.20.7828.001; Fri, 26 Jul 2024
 01:42:11 +0000
From: Michael Agun <danielagun@microsoft.com>
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "bpf@ietf.org" <bpf@ietf.org>
Subject: perf_event_output payload capture flags?
Thread-Topic: perf_event_output payload capture flags?
Thread-Index: AQHa3vgKy5tYtpsBAEW6H2nOXoUJ8Q==
Date: Fri, 26 Jul 2024 01:42:11 +0000
Message-ID:
 <CY5PR21MB349314B6ECC4284EA3712FCDD7B42@CY5PR21MB3493.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-07-26T01:42:11.245Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR21MB3493:EE_|IA1PR21MB3521:EE_
x-ms-office365-filtering-correlation-id: 6e0c8e9a-7879-4169-3f64-08dcad142b4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?9KwwSXf4s7Wmk37Rzq/woZK5dxuowAWUJMY9DRFt2qqg38k3crdaLUnIE4?=
 =?iso-8859-1?Q?lZjSDAYTpSpXFzCD8P7/GcUvh1BmRD7OhctMaIR/l7EuKuUDADgG5KRRX6?=
 =?iso-8859-1?Q?c7pdg9A8TU3TiG3ONTo/axWWSRFpRHXKO54fn69KsEo0QxftXW50o+h5kN?=
 =?iso-8859-1?Q?ns/Qw2OemR/TCMeR8wJaAm3oZoFeAR9oQvoBYln1L/CD/PoGzYw+PaoheI?=
 =?iso-8859-1?Q?aa5ix561NIgpCOB8wsjZ+5po2/U5w0jWsp7vhtIs19RNd5wZubNDTIP/8P?=
 =?iso-8859-1?Q?SstUsrZV36c2qAZPrRmluAfIHLGYlP5ska+9Bu0/Zy6auPZbJNthIR58Qa?=
 =?iso-8859-1?Q?Kx8+NyrcUkSxAg1yDDClhzzYcrletiUZxQ18JEo3/Z6VjtZaTCNPjCfQWJ?=
 =?iso-8859-1?Q?m9w/0Wmx+7kU0cdwcl101MRw8Hp1zNouLNTyaHX2gVvPwTLi2SP9wLBkTz?=
 =?iso-8859-1?Q?HoJP+U+kzlXoAzgv8hzm6IPboQK5l2Ww+VOgj0Q1c2K0PtEYkmjaF5avwq?=
 =?iso-8859-1?Q?kiYyPuowpFcliergWihyWzzGdBfAD0+eFaWkkoC94JskOuE70U0iASTiOa?=
 =?iso-8859-1?Q?/GNIHwyjOiEdKl5uPGlZR4R8Ol659O71daUihadJtCkm0kZam2dhluAHCS?=
 =?iso-8859-1?Q?Takg+LimMUGf5Yj7JNCoHyfVZqucJKbC5YAuaHIqu30EwApqhYPuySJ73g?=
 =?iso-8859-1?Q?ifZWsWt5QAzHhe1lpgAgepkADGqlFf12+aTqxcIj82yoX3k3ILTnN5m7WT?=
 =?iso-8859-1?Q?LjBAjl2cfXr2Hi6ao1sveGH11IPfPVoxZwZ9KxqLWu8ov+jl05g/UI5siT?=
 =?iso-8859-1?Q?R+EYeynrzipz7uM+MAYinSDGN9I5Aqqvu6nzxBxfDwNREouCdFaXh6xQ1x?=
 =?iso-8859-1?Q?tHlc24hehCilD9M2uAelxDz9sjuqoxPVlDw/AezaFnAFSZfFxlW6z3s9Is?=
 =?iso-8859-1?Q?tI0RgkBLifpZS9nRC6yGLeh8aN/wlfnuum+wM/RpgZCisYsP9dIroqpOWb?=
 =?iso-8859-1?Q?z/7zjqttdMHSTkP08pD0pv6rfg6+0TRbhTThO7G+AxBODLtPj34SPS2bSk?=
 =?iso-8859-1?Q?jdMLfPCN9OGiLtbfory+BaZhVJCSaPKDvvaUhGbpNsUg9KpHbWdLA2Egd5?=
 =?iso-8859-1?Q?h3oHDgXIk/gn2H5Km0ZtL7krIyckMkLHt0Ur0Q6C7iG5pdVJ7BCnoSiOA6?=
 =?iso-8859-1?Q?KP+/GaRWc/FsdppyW/W/tuf4zSzLZXzxhYl9Hj0hebfyJ7RzXAJNqaxoMZ?=
 =?iso-8859-1?Q?0kVJfjCfF8SOtk04+B225o7F8r6UmbQ7vhNlCeW5PeCZLcxfAZ08VnDFj6?=
 =?iso-8859-1?Q?pQa9xNGIvmP8LejJqCTYzFbqv/nnPVldTuVU9A+fo0x7AUiNQae0MLM7yT?=
 =?iso-8859-1?Q?WgR67/I6HTKUhXSnwAU69rY4wuWg+U7f0qq+9Ry8WXeyDLDzc6STpNaCzY?=
 =?iso-8859-1?Q?sZu1zUc8F/AVCJLR3V6FX8VhlLZ/EVx2YpXNDw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR21MB3493.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?cxtBMzP5CpXwUI+MlcofDd7J+m8TP+iv7OqXWrX3IIKpGijEfKuE2GL7Bq?=
 =?iso-8859-1?Q?1O0sAx/7P0dQV7PzjpIvZjIg8hlqWtd4xZXA7PLieePi8bvTHCR1qZ2O3V?=
 =?iso-8859-1?Q?j7w6bcQ7CVvrj7GBdrtWzVe2mLO6Rq3pTFMQkCLAavNx8/iIKtPTAG9G2c?=
 =?iso-8859-1?Q?k3ddDLG/aDpBqDFtzTW7Hi04KUgHHk31dTh3XPeWOZJ3A4RLyN8SjIDeya?=
 =?iso-8859-1?Q?uBB7NM+iW2u+wglGNMuNEzbMJeKEqM+R3bEu9MWUNbK0SS8SlN5dFfrwEm?=
 =?iso-8859-1?Q?JAB9jYbUC5suTaQrr3zIwweK1eRPa9quPP/3kixLiQn8m9alyLNBfG06RD?=
 =?iso-8859-1?Q?iMeRp7sTfQyWcmKmMSmBkTOfAkHxCrk4Kt/16Xr5sgYzzkHfVEZuTxpW7s?=
 =?iso-8859-1?Q?SF3mgzsPedbP5NpSjWsy2bJiewxOSJeiCYk8nGydZ84CdrLn25e/Q8XP5/?=
 =?iso-8859-1?Q?Z1fzp8rQO9ay84kmCGcT5CPNosqPlLB1EIzbEyiF2hSIjlDwC+Os3NdS/S?=
 =?iso-8859-1?Q?++meMhQcZQeFy0Mp0RsW682n1SsLMvvRjnb763cHJHSbnDWN9t/RIiEzEa?=
 =?iso-8859-1?Q?QmabyYYpP6OA2xf5Ep3NQnrKkafbLTQqsxJT/mvHdT2MM7ISLCa/Kx/V6x?=
 =?iso-8859-1?Q?SY06ZLb6lqavKDTwjYos0OwTrGM8YlHq8Fl6oeGI8X7J74Q2QHeUyazEWC?=
 =?iso-8859-1?Q?W6u/eSYG2vv0MI14UYcBY0UZD7/66sIDdvADetGrbB7NAYdkEfLai7Aup0?=
 =?iso-8859-1?Q?l/zsTLbj6KDz7RY9S6sKT7mIbkJQXcIaH4l672WibzsdIr9DdcfIUVtIfy?=
 =?iso-8859-1?Q?F2W36KpDt/zFt0pPqWk0VSvXo9/ZrmyKuqlyRZtzXCQRiZtn+DswKiix6K?=
 =?iso-8859-1?Q?GFgEaPSQrnJX7TQpAn0AlalxtWhz5+6oLDH+x5IiFg8BUaoe/n18BN9oh1?=
 =?iso-8859-1?Q?b9baKQMEzFU1tb832gjTiHhfKZqyKwgo6b0OEeMAHRK1VUV/Vyn6XxBnoq?=
 =?iso-8859-1?Q?am1St2SVyHFfaUi3HX43DOh2yFcRhocnaTnMqE45auup4td0Bf0BOXChHp?=
 =?iso-8859-1?Q?tFqiBCs7K73PfbTG06GVIX7ns7pjgNKfeZe5v9zElLz17zmu93S17AxaSV?=
 =?iso-8859-1?Q?6ivDNE9TYXDkd44OruY2wi0LFJP5XPt9bBrFnAXq3I0CvpDR0egUmSSaUg?=
 =?iso-8859-1?Q?B1+qcG1MH1KbFcGgp1RvzsE43mPE1qTEr65cvHR8097HDUIHe8QsIZQgJ2?=
 =?iso-8859-1?Q?9ZevwTaNsotDer1Yhq7hNWIYQhC6BXPlIQv4l3+JCrgYQuleI15kezHm0q?=
 =?iso-8859-1?Q?tUNTiFCjVQkceoghTGFtWj4xAlZKo25bmYViK19+N3sHG9xY/p/rIzN1Cl?=
 =?iso-8859-1?Q?ZOaZZOZIcJocQBq9ZQTx+MfLu4xZX2wbXzSfvo+PGwDP3U7gEa8Xc0ZkCJ?=
 =?iso-8859-1?Q?TTha3hc1K+PtLpy1v+dpfaLcBhfTjKQNjMo4DGZmCNZtJwLf/a82dr+1Ia?=
 =?iso-8859-1?Q?+MjgmY+qJ3krunPcEIfADyMm2FWQqCOEVrAgvsgxEUpcygE8Nwh49K1dUL?=
 =?iso-8859-1?Q?twBa4UYCsbmjfV/iO7xWHBbYWuSiqkNHYl2Vpp2W5vSH2oHPz9Qu5Doj6c?=
 =?iso-8859-1?Q?Ao2B2ixq445I2eIWSYfeyqER1s3S72wgXO?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR21MB3493.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e0c8e9a-7879-4169-3f64-08dcad142b4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2024 01:42:11.7078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V7t7HpDjS8cND+EKNGf0hGOGv3ZhKsTd3qqtsPhlW77oQc93HKi6+d49MuOo8kOnJMxxbzCnFSCSMMsjq+TfCmwzztCZI+3V/UkuGpUo7p0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3521

Are the perf_event_output flags (and what the event blob looks like) docume=
nted? Especially for the program type specific perf_event_output functions.=
=0A=
=0A=
I've seen notes in (cilium) code passing payload lengths in the flags, and =
am specifically interested in how the event blob is constructed for perf ev=
ents with payload capture.=0A=
=0A=
=0A=
Thanks,=0A=
Michael=

