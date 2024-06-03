Return-Path: <bpf+bounces-31180-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFA58D7BD6
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 08:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11546282FC0
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 06:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BBE2D052;
	Mon,  3 Jun 2024 06:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="vlMwdhqT"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ACA5CB0;
	Mon,  3 Jun 2024 06:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717397144; cv=fail; b=KqtQCy+d83I+m52AxpgA9VwulVpekrTayym+2e1VbkKxymoRDD46+loXxvtBQTpPEXVz91di/Ut7zTnzEL1jkK5LzfpkgmSDNPeh4RdFKMBPmLNb02Cd7rZadRUlUa7XYyBm3DkmK6g3S7y1O51dLCHEjwu8013okejjEtqN3B0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717397144; c=relaxed/simple;
	bh=ITeOG9xtF0haWEqwG/V7qhnsByCJ84jRz/HET+l2ypw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=chZDP5cJEeRH0DDsSK8NK2iylgKrDr+shms2IR76yYoflAzOuBPJl5jSI8LUxgGtNqU4PLvGs0nT5w2TTVbcKlRVskDzEPqwkzrO/UtjVGONYp4+588UhDdJn+oQGBErm3uf5JvEb/f2JsttaVR+Xy9G+l9FlCzqA0x4gjEnaPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=vlMwdhqT; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 452N02am016268;
	Sun, 2 Jun 2024 23:45:14 -0700
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3yg35hbvnm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Jun 2024 23:45:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdsB5HbvoDKPwGYbkiov5bxwpw6+Gttwx/2ocgaQ+TOYUM/LIZh5I41L6fCJcYHVO/HQ0Ptvf+DHstlGJCzFyaOPIBqD9WNHhQckHaE4BlM194UyAheW+gbaX9elRqnLxIkXOmKK5lcqlbgluaL0nMoTNw++9PTm0LM8igAnBlNH84p7N2tLMUcWVfJshDs19h67xTR2VMglGfZtig6uhFJ2Yp/ZE6nqodd9EVemGCfKH6sCDIXkOSLsPesHf2THh6ik4wSuFJsFTt5831Cyz6ezhbmBlR+YEE1hHdb6ACfbUeeD4kZOI2gPSGXVIaETyQz06rf7EUVWGKMIsfst8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqOtGdWokWpZ2LU4r/SHz9HmQilBFzPUmprUCBEBDhY=;
 b=MsP0ibZbn73dYvYoh1rryXwFpZ58Xad5S4w+118I27/u9kl0c574hKbGrUd8mEpR0r84C2qfbTeRAuZ+lHv5XMBne36nsh2aDvu5RLPQsGn6kU1SgxCizGMy/e6ReX7W56uD0MLZ/Or6WY5oFOEo2qWQ5v/ardLexoJStHcDZVUptPWiL9Zp14EFh0viI8UWP+fkZ9ahbmfpKfOKIajdA23StEEi9y+/UwzhlmRn6Vq8UMiag2W56/+huw6Vz9HRFkC815SUNwZkRXvnE/w7W1IhEh1jQVx4iKM7ouXxlGs+LOhoafBd8WKJ4FGnUPSFZWyVgFarNPv5yKzL/g958w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqOtGdWokWpZ2LU4r/SHz9HmQilBFzPUmprUCBEBDhY=;
 b=vlMwdhqTLbkuEboCZZuBJ8EsarFBIBgjHEWE3GZFhd78VPys7QtvHoBnJzgwKSrmcw3/qUR/bP8nDYDyqvd2xdM8N+du9vNeG/zHeDq4I3qjgWehtUJNWxPPXVGHOHVfM0XG/cxnb42on8F5hSW5wDeLyF5Rcf57bf7eWcV07I0=
Received: from PH0PR18MB4474.namprd18.prod.outlook.com (2603:10b6:510:ea::22)
 by MN0PR18MB6116.namprd18.prod.outlook.com (2603:10b6:208:4bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 06:45:09 +0000
Received: from PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::ba6a:d051:575b:324e]) by PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::ba6a:d051:575b:324e%4]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 06:45:09 +0000
From: Hariprasad Kelam <hkelam@marvell.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        David Bauer
	<mail@david-bauer.net>, Ido Schimmel <idosch@nvidia.com>,
        Nikolay Aleksandrov
	<razor@blackwall.org>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH net] vxlan: Fix regression when dropping packets due to
 invalid src addresses
Thread-Topic: [PATCH net] vxlan: Fix regression when dropping packets due to
 invalid src addresses
Thread-Index: AQHatYGTnYHLz6wfiUqfZHIAnfyM0Q==
Date: Mon, 3 Jun 2024 06:45:09 +0000
Message-ID: 
 <PH0PR18MB4474EF3DC991F456E6D1C524DEFF2@PH0PR18MB4474.namprd18.prod.outlook.com>
References: <20240531154137.26797-1-daniel@iogearbox.net>
In-Reply-To: <20240531154137.26797-1-daniel@iogearbox.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4474:EE_|MN0PR18MB6116:EE_
x-ms-office365-filtering-correlation-id: 19f2e590-a404-4f94-f9d7-08dc8398b659
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?z9eyJGrJ9CCf7mS+Wx54R6ddxM6ljUh4+px4QxQmSlnyEpoPb8mOgthS/dns?=
 =?us-ascii?Q?H7vNUuidRulb4OSdNDBp39+L6nR7USzmI2vmCT8lVFxTl86BV+U0DaTEO/Ks?=
 =?us-ascii?Q?bg7pJWpKHu3+P62WuTUKx+zMn/8nZaY8+RQcLwrBrMhDFAculdJ2ltO5X9Ot?=
 =?us-ascii?Q?uvCZxVLNNkTdFEQpOi+Hdh433JTR5dSXr+MH4r+lDZ/Pegysa094ToI1pNDb?=
 =?us-ascii?Q?m+VbEEGUWrH3MeGQDLiIsuL9H78E6eQQunnvi0BlhmbZegwV+YAr1mIxWj/J?=
 =?us-ascii?Q?WvAk+qQtqrjLgOhf+wD7RlUSHTkzxyQbllOJ+3eYzL2TwRgk9lDBcHgv27fv?=
 =?us-ascii?Q?LXVHk4M6xEjJsIo52RQzxdGr30BWlfKbSf1YuOuXksmT5+AOddLGrNUxUVKK?=
 =?us-ascii?Q?/MwTQUVFzPf9sTWZWpMWJoRdCYLxog9b3G1iMYoEj7WYj3WiIU9JJq89a8jE?=
 =?us-ascii?Q?uuwWbfYSSpuXOQlDr1nM03nm7F0xXaW/I1N6SvcvDYVmQ/K1FqNl7Kqgd/nu?=
 =?us-ascii?Q?nRnwVJFZBXpXgHYXcr6H6NUFmH6Th72R8MzPGfd1EG9EblzLunI5SPvSGJzB?=
 =?us-ascii?Q?+ylFgYAjrgg2X6H6ek/WBP6Q3JSBT6Raqvzwy8V85Stbig/X3JXVNN+VEiI5?=
 =?us-ascii?Q?5gQzCEEHp3noAnVzidnEQCEePUIlmS7iVG6mCpimpoe8qWcDfgrMdS0s0yCu?=
 =?us-ascii?Q?Q+qXC9L1zeKo5QUdStL0oRFf/5gZcbh2/SrnM4A0xU4bR7yN23yb87eqDhjY?=
 =?us-ascii?Q?DJVvRoYJZd5u3OSBiJw6GPMA9TSTVZ/ApjPR+Sr8N5eoL3mg3VI5VqceFrul?=
 =?us-ascii?Q?ik6LAdpExmIcdXJ6AdJuQwwkSmovXK7EamUL5luHkFwtwcBfpJIfH+uwlpkX?=
 =?us-ascii?Q?an76KRG3ytA2hJhM8vr0/wF7JpcSd7VP7KRFor+FULF1+5+EyG+cDz1wSKSg?=
 =?us-ascii?Q?2vMq8SS2PMsEn4jLYAwrfliCOgf2H14yChPueeGSf+dRrj5rBXEvq01Mpd+z?=
 =?us-ascii?Q?YovKcVT0pFvZLSzrdbeftS/LeLWJ8gMG6beWKvngbFkE2R+vEaisLG+Nts6J?=
 =?us-ascii?Q?nrMF/J1ZGCh2hGMfTU+pU5aIXQYt7HYk9ltfM6FRt/sl63tM5ckf3qzomPE7?=
 =?us-ascii?Q?oadfsx5ruZTZ6xpzquvOBIPjaaA3TaWve4V8heRvC1iIfjQJeevnGOvhXHAQ?=
 =?us-ascii?Q?H5MDYWi0jljVdwGfnqGWv+fcGf/KmdVFcLxF+J58s+ar9lnHMKoyIuNEyIMn?=
 =?us-ascii?Q?+0rZl3POb0pd7+2Q/U6HEzyv6r33WvtRu17u9EKK6pryHx6l+LFMm3Rbmk8M?=
 =?us-ascii?Q?K8gAHbmXYbMOzkYeAN98EgaT9PiZOgcHDka5HHhG8g6Mrw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4474.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Q89s+nTIyvi1WeR88RF+m2Kw8+HUNgvKgSW9Rs2tmq9eiF57jMYnrDIbGpJj?=
 =?us-ascii?Q?Jikdmcfu2KmDVg75MRro47tL9d1nFVjHGSSihxQGEMLltxUPNpkdFY6i63O6?=
 =?us-ascii?Q?DOI7bpcfcLp/xOo6EpqZqrElNE0vW9AIrDE7CNBzfuaI02WBqGjLijNPw5zt?=
 =?us-ascii?Q?a53eNpDhGIH51KcPxooFstyFu4IZEVuYkwnR8HcBXS90nFJiyMcZ55yOgBwN?=
 =?us-ascii?Q?yJf9zgulgYiFtt+vEY3Ss56CeBcXvGcYkuxn7jKz7K2vymJyKbE+2FXgOlKI?=
 =?us-ascii?Q?YHQ3R73VSyelgYApA9v/E1FPlmeRR3cncB32T9DSCGjuZYhIlSlzLrn3hDXZ?=
 =?us-ascii?Q?QfNH6dCGdMtfBjoFHoVNPa8HepPQyt951zekSubbXpTEdx/pdpijzl9c/YB4?=
 =?us-ascii?Q?0FqE178I+jI7HpPRgnsBV2bwBF8Vxw5Ki1q3s9FS91xk2z0Opm/nic0Hu5R1?=
 =?us-ascii?Q?N7ihIXfjUbLmp2EnvWsZM9DlJICcDETEonS2Su5bPuOUNCVDGM/coLvx+q/H?=
 =?us-ascii?Q?07j20Fx9HqD9Fp6ShKh2KiE5Ve3OMV2VZdpZ4gZxUPRAoej5a5NfaUMIGI94?=
 =?us-ascii?Q?bWgv672kl48G9+2MStBIXiS8kF6nr1d16yUdCc5CW2mpgixuIlcxOqPtaXka?=
 =?us-ascii?Q?rHwJo8GvQsmrC/7Pasf6rNFZAUB7vDW0Xfwyc7So/XUz+yo/WcMyYCwzu3cm?=
 =?us-ascii?Q?Qorzywtr/sQ5YvJYvKsUeXOIaeSTNIgbt1LIqayUoJNsq4LHJtRHLlDwUQjy?=
 =?us-ascii?Q?2n+Yu1cLSq1oCp0Wb1a3vQB1XLYuMNjmGAyaKCtl2xhzq6T8ngkexQbbQZJD?=
 =?us-ascii?Q?gvWPcBpxhhxh/FZw5FbkkGyYSC0f2XhHsqaU8/lJbjppl3B9eK8UYHCAfmf7?=
 =?us-ascii?Q?yWpmGMEhywTxy4yn6IRKRmZc8tpZd1muGK7Kgb+8mgirdFQgzqeWti+Eo+2a?=
 =?us-ascii?Q?CmzIjqs84uXTD7KideIWSy0GOZM/xGEGPsD88NMAwxO8b3ICPLC9hSuqcldo?=
 =?us-ascii?Q?XchRWJ7glWgXt7K+r7Mc0Elir66emxvEM82aNX6yPriNDwyezHvsNVeOrMc7?=
 =?us-ascii?Q?wkj5oPnomlSGh8hmolk0kiWatJoGmwMTTvur6XQG12Y8ngV3L68igPA2X7ZL?=
 =?us-ascii?Q?AczHjxME0KTdRe1+f9EHXrImdW0fqCJCJmpM4EqDm+8X2E0YqvFh7uAPB0dB?=
 =?us-ascii?Q?VOWGrJN6NMCYSwmbrYo1TiwvY2p/27Kuc/EE6NU23jJ+hFVP4z+BhO6VXQEF?=
 =?us-ascii?Q?OwVHf6jjiOgD9Jc0lBWwOHDmy7rTZjRpZN9MHwr4g+R3/dMH7dTgRVRIaHdM?=
 =?us-ascii?Q?9UoRzuj5wFw8qmaahGRNYLsTtSOkwQIkwumsadMby7lEwoIoy6D0WhW0wONX?=
 =?us-ascii?Q?8cqCuu9sobswstKTHF8TKjNYYFBeKVF4ZvrhwMRzXShJNIagnQ6Ru2FqCvUS?=
 =?us-ascii?Q?kfWhNaDLeL7MFxuqF1VYzRPfxReKTsaShqZ7Vubq0njfOf2YjlrVr3pKa0A0?=
 =?us-ascii?Q?1et3HJ0PA7PMn88BoYyJChKh0h8OWwOmf3wBf7FkelrsSALHIoANn+jKFFTk?=
 =?us-ascii?Q?+GMjourM8SfnGcwv8go=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4474.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f2e590-a404-4f94-f9d7-08dc8398b659
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 06:45:09.6825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /0RTf9Ikbpg2OgAJa2469hGHjF7YMGn/dHTvWpX5LiXh/Trk75j6t5c6lsWE0CofRFfjBf88gQxx2xeK2w1nIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR18MB6116
X-Proofpoint-GUID: xqs6h2kfsm87erP9gGBsbWXmrXOswWS0
X-Proofpoint-ORIG-GUID: xqs6h2kfsm87erP9gGBsbWXmrXOswWS0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-02_15,2024-05-30_01,2024-05-17_01



> Commit f58f45c1e5b9 ("vxlan: drop packets from invalid src-address") has
> been recently added to vxlan mainly in the context of source address
> snooping/learning so that when it is enabled, an entry in the FDB is not =
being
> created for an invalid address for the tunnel endpoint.
>=20
> Before commit f58f45c1e5b9 vxlan was similarly behaving as geneve in that=
 it
> passed through whichever macs were set in the L2 header. It turns out tha=
t
> this change in behavior breaks setups, for example, Cilium with netkit in=
 L3
> mode for Pods as well as tunnel mode has been passing before the change i=
n
> f58f45c1e5b9 for both vxlan and geneve.
> After mentioned change it is only passing for geneve as in case of vxlan
> packets are dropped due to vxlan_set_mac() returning false as source and
> destination macs are zero which for E/W traffic via tunnel is totally fin=
e.
>=20
> Fix it by only opting into the is_valid_ether_addr() check in
> vxlan_set_mac() when in fact source address snooping/learning is actually
> enabled in vxlan. With this change, the Cilium connectivity test suite pa=
sses
> again for both tunnel flavors.
>=20
> Fixes: f58f45c1e5b9 ("vxlan: drop packets from invalid src-address")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: David Bauer <mail@david-bauer.net>
> Cc: Ido Schimmel <idosch@nvidia.com>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Martin KaFai Lau <martin.lau@kernel.org>
> ---
>  drivers/net/vxlan/vxlan_core.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_cor=
e.c
> index f78dd0438843..7353f27b02dc 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -1605,6 +1605,7 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan,
>  			  struct vxlan_sock *vs,
>  			  struct sk_buff *skb, __be32 vni)
>  {
> +	bool learning =3D vxlan->cfg.flags & VXLAN_F_LEARN;
>  	union vxlan_addr saddr;
>  	u32 ifindex =3D skb->dev->ifindex;
>  =20

  Not related to this change,  can you adjust existing declaration align to=
 reverse X-mas tree?

Thanks,
Hariprasad k


> @@ -1616,8 +1617,11 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan,
>  	if (ether_addr_equal(eth_hdr(skb)->h_source, vxlan->dev-
> >dev_addr))
>  		return false;
>=20
> -	/* Ignore packets from invalid src-address */
> -	if (!is_valid_ether_addr(eth_hdr(skb)->h_source))
> +	/* Ignore packets from invalid src-address when in learning mode,
> +	 * otherwise let them through e.g. when originating from NOARP
> +	 * devices with all-zero mac, etc.
> +	 */
> +	if (learning && !is_valid_ether_addr(eth_hdr(skb)->h_source))
>  		return false;
>=20
>  	/* Get address from the outer IP header */ @@ -1631,7 +1635,7 @@
> static bool vxlan_set_mac(struct vxlan_dev *vxlan,  #endif
>  	}
>=20
> -	if ((vxlan->cfg.flags & VXLAN_F_LEARN) &&
> +	if (learning &&
>  	    vxlan_snoop(skb->dev, &saddr, eth_hdr(skb)->h_source, ifindex,
> vni))
>  		return false;
>=20
> --
> 2.34.1
>=20


