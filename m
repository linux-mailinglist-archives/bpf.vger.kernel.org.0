Return-Path: <bpf+bounces-41333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F42995D06
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 03:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A9DFB24809
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 01:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF0D39FD9;
	Wed,  9 Oct 2024 01:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gvNbUgkl"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011049.outbound.protection.outlook.com [52.101.65.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A7118C31;
	Wed,  9 Oct 2024 01:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728437512; cv=fail; b=fhcUC2Es4X7TEgyVttd1Imjjkgz69/MmgJ8TL3e/FKWqqXuzZrFo+/JH2XTIhpYQtoAHBchGWAaW7lIopiVrcvDtt62kHTWkxPZOe/qd2vSvt1TQZURYJd7TO8556QB/lAT/8gKNaignc+3I1PYHMm3FTdmTa2JyU6muUnU00IY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728437512; c=relaxed/simple;
	bh=GU5j24LYhHxSBgP99kAx2fM30LIZGV8P0AdbpYRRmHQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jV3hv/pqkK6ouM1Ic0oV2OHTF2InTsHGuZ7nL+rAiRUu1bYfe7PdVPQCS3nISx6GZohKNC25v+2N4Y/aOcgTSRt2ip0kSCtYTFDgkP4ArIOu2Cyk184MAKxtR53+qp8zkxW733i9KXvzLZn8ZLZpKTcKb82whGRl3bnFSwyiP7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gvNbUgkl; arc=fail smtp.client-ip=52.101.65.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHwUoY9I/Lvnhu5/bvCMNNPEhPVApWZSvAZqYDzWp4yI25DvEw7YQSaYyDBxRgzv9jcQSreEQydDsyxE0RJP8yuhmZGWsPhXEpKCMY11XCJQuondh5Gs6pcfZkwnjp3UIWlSgCL4yCveTf4HME1NQ0WEpYZlSZaFbHQXMUBV42CGhjIdFI7WG5ccBizIbZeUjw5Vz5yRT3epnOGB4LgO337JDej7Vt54MClfPzIe8vtfNUfADB5Z0uoJq9zLRSKzckbwJKhLj7AxelMu+ddG2+51g0V2mHrqa4NM2Xc+KRX+cqHD2j18nNfTtS0M5dG6+k8+9GSrKDTiAW1KAmh1oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GU5j24LYhHxSBgP99kAx2fM30LIZGV8P0AdbpYRRmHQ=;
 b=y41RBVmB8ilDqRUMInsWiJzd58F6tRV3jBmb+3oZyYNsDp+snKFzaSPHEB2TEpFi46GAdc0HGK+iccGUqRQB6ksgoS9n5l7opUrC6SWuvwmq3xRLrMRyiGkyYZwj2itHLcISEhJFPTY3luIfD35lu7C0LvSEmWcAEhuAqUaV+GNdsl+eTJdor4zDaG/blZBYl/YnqWtxqklazoR4z1scKTUPNvHTQBx0UxbAQ2q6KQVfMIZXu7Z5v94kVfKUx3HEtGkCmW6SnKv6zkvzv6+C8CERn4yGXwwBvFnbBNekWkXb6FaZGI+3L3lMzYak5Byc0e3mvhSfgkmS/wA5DBwlzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GU5j24LYhHxSBgP99kAx2fM30LIZGV8P0AdbpYRRmHQ=;
 b=gvNbUgklEptkrb0NhTp7kpQjKPBFDNGnGxEtXROfTK9z1x9mIqLZCO/XZZXIJci+x8RlkiOgZkFSyhV26lU9cT/ofusH/O8ELqK5T+0NXVEd/9ZToLlqCODF13JhXmPYrmfPgVjn5y4HcHchpB2ivbhXBdnpe0Plr9cN/xZOE4BrS2WaGUi6avZAG5izl9kf0NycprH3q8gqcsMBu0s3YzBRHj6WJYABo2jYbqZcPxCTf66gw+c2xkVBRdJaF/GMsJchTGA/BvLwnF//Hs6QQJtliTFNRCnhOD1YoaMmK38SozHIYh3RamP6GkaXpnJYI/Cfzi5pB9bYvpatfTmkTw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV1PR04MB10941.eurprd04.prod.outlook.com (2603:10a6:150:201::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 01:31:44 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Wed, 9 Oct 2024
 01:31:44 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "hawk@kernel.org"
	<hawk@kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "rkannoth@marvell.com"
	<rkannoth@marvell.com>, "maciej.fijalkowski@intel.com"
	<maciej.fijalkowski@intel.com>, "sbhatta@marvell.com" <sbhatta@marvell.com>
Subject: RE: [PATCH v2 net 3/3] net: enetc: disable IRQ after Rx and Tx BD
 rings are disabled
Thread-Topic: [PATCH v2 net 3/3] net: enetc: disable IRQ after Rx and Tx BD
 rings are disabled
Thread-Index: AQHbEhvKg7CI8w3+3UGT+l2bnqYKr7Jw5MKAgAEBQGCAClYY4IABR/UAgAAtAFA=
Date: Wed, 9 Oct 2024 01:31:44 +0000
Message-ID:
 <PAXPR04MB85101E82059358F959C0502B887F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240929024506.1527828-1-wei.fang@nxp.com>
 <20240929024506.1527828-4-wei.fang@nxp.com>
 <20240930220249.dio23fh7mqw4pojn@skbuf>
 <PAXPR04MB85102EFDDEBED7C602ACBD4888772@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <PAXPR04MB85101B7AC1C1F46E8DD59958887E2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20241008224806.2onzkt3gbslw5jxb@skbuf>
In-Reply-To: <20241008224806.2onzkt3gbslw5jxb@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GV1PR04MB10941:EE_
x-ms-office365-filtering-correlation-id: 77e5e9f7-2105-4ddb-21ba-08dce8022256
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?bDNPdlJlQTI3RllDM0FkUUNrT29weW8vVkl6NGwveHpKV1BMRW1kcHBRZnd0?=
 =?gb2312?B?YkxsWlVra1hVdjZVK1ZVRjFycTQxVDQraHFNZys5Y2hlSDVoV0UwdUpQWjYz?=
 =?gb2312?B?NjRkTDhaWWVBMGNMSjduWjVicC9sRG5NRXhVYTZkU0JRTW1ldXA3UE11azU3?=
 =?gb2312?B?eTJaMHFraVJxRDFvUEx2ekZSeGt1TFoxcUVJUVltbUxML3ZvQ3ZxV05zQXBu?=
 =?gb2312?B?SElnc25ENFBHNTEwYUUwSHErS001NnZneGx4UjJjUkx6d0ZBNXY1YnZPeUpQ?=
 =?gb2312?B?SUc0MjRZVHNRc05oQXlISm54eU1CSC9nQVdYMHlUVzA4d2J1TzZ5ZGpyTGVq?=
 =?gb2312?B?Q0sxSmhaTHkwcEdEZDN4TytnTGJON0ZWTVJ5WlBmTytNcm9TeUNoSFZURkNp?=
 =?gb2312?B?UCtYYWtqNDhINVg0YS9mYjFmUTEySndCNGFJOW1wbzNnTklXZnBOSFB2Rm10?=
 =?gb2312?B?VFlmcjBJZ1BSR0ZYMWZObGlMQmJ5cTJUTW56aGY2cDdaMytnN0ZsaHp0S3JG?=
 =?gb2312?B?M3JwTkhrYTBRcmxtNE9HSjcxbjVTTklhOU9DbkVPVkpIa1hnT1gyZGx4WFNp?=
 =?gb2312?B?ZGlJek56WFV2b0M2M3NWaTJiRDBtUW5JaVR0V1ZVdGVlUWx3STBKK2VvV0Zw?=
 =?gb2312?B?QWoxL3hwZnJjdm1Bcks0cnNFNUVyd2NMUi8veUhKZ3BwY2lFT281QW8vV2Fo?=
 =?gb2312?B?TVVjUDJlWVBZL2crcGxTWXJQdWI2MmVHWHlueVZMM2JvbnZUNE1PTVJDRW5Y?=
 =?gb2312?B?STVEK2xmUGJwQSsvZ043QUlHeEdHTUZwS24renIySzVRdDltTERVV3dOVVBM?=
 =?gb2312?B?NFc1Y1pCRjlpT2lWMDQ4V0lDWm1pTXczZEpHTWtpdTBrTjkzekxTYVBua1VJ?=
 =?gb2312?B?QUZXUDhoTVp4VXIwKzN6QjZuRzhkZWxGMDduSDlRODZzMVc5UHhmSlEvN00y?=
 =?gb2312?B?WldXOG1zdHllTGV0Y1BleUFIM3dpblpUZ2dvekIvYnpYQzBtaDVMYm5pRVd6?=
 =?gb2312?B?ZkpFd2RCdUFVZ1pOd1FzM0pXemlWNTBCeGIxMEUxUzdzYmZhQVF0OHBpS0pF?=
 =?gb2312?B?cWFOYUxsWUxEc1p0NUs1MVowWGdJUFZMWVFib0dJVExOdG82RWtGVFlibzds?=
 =?gb2312?B?NnFrbjEzSlJPMW9WZmdFVm1BRXVJL2RyRWJkYnJFenByanB5QjZQK08xVVlX?=
 =?gb2312?B?ZjVzWHNXLzl1S0pnNlRUc0g0L2JzYnB3dHVFSjRkVG1DQUNwOGtwajY3V0FO?=
 =?gb2312?B?QmdLT20xZjVjRGRHV0VqT28rOTdGNE9JMXVxeC9pcXlnbEpSU1JGaE04K29V?=
 =?gb2312?B?dnFaRnRSTHY1SWdaai9iL2U1MDAzaU1FUjdTUm8yVHprUVV3cHc5TzAvdGlq?=
 =?gb2312?B?L09VQ1FlL0VRdmpmck00QkVXeUhmUnNMa0llMjRzcnlCSGpjUkliOGJvMXh3?=
 =?gb2312?B?NVNYbVptM2JoZUlOREU4T0JiT1VhKzZ1L3FUcGVOeGwwTXU3OGkwTDNIemk3?=
 =?gb2312?B?NkRnRW9FelU4aStZZUhDS0lVMjNHOFJnVFYxNEpMOHdlcEM5M2dKRWVCRVYy?=
 =?gb2312?B?Y2ZjS1dSQ0ZrVHZLdDhBTUVFUHB5eFlReG44T1AxTnJ2dkpRZ3pFVVFXTG1L?=
 =?gb2312?B?U2VZVzZpZTFKT1k3OUF5VlJoZmlhUmtWSm95NzFBdnRHYjRtNWIzUkxseUdi?=
 =?gb2312?B?QkF0VzF3dlB0azRPNVJFdW93RmFHVVhuUmplbEhCdVNVV0xGUmJBbTl2Q2Jm?=
 =?gb2312?Q?f3Z7NmRwitp0659HrurBWZDcDj2v84w01WqERbc?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?UDBWUlJ5LzZLTXBicjZ3eCt1eDdSZHp4RGRsTDJ2K0ZHVzc3bDY4dWg3SEFN?=
 =?gb2312?B?akJQajNlbEhnT2NYOGhCU0Y2alhPUEo5bWxTbXZRR1laSXZ3WlVDRnhuRHhs?=
 =?gb2312?B?bmVWZlZsUjhoTmwrNWU5Q25ZdWk3dnFSWU0vZEpkK29XUnJsY1VGYXd4czdN?=
 =?gb2312?B?M1FsWGZRWXJMMi9uaGJCVDBrRDdhVGlVblNWK3l2WDVzNFVzeHE3Qk16M3FW?=
 =?gb2312?B?Yzg5bHZRbzlRejhFaXVWNW9KSjAwdkxpcEVnQnZRTmRBaFVoUE5sL045NWEx?=
 =?gb2312?B?d0pzSmVOaWI4aTJLa1pYWm1nR2pVU1o3OWlKWjZ1RnFhVkkzaHIzUldUd0FF?=
 =?gb2312?B?VCtwOEFSeG5LRnRySSsvU3dCT0hZaldFMEJWNmdUNUNlK254Umo2K3I5RXl2?=
 =?gb2312?B?dzhVL2dJNDJIdHVvWTZRcHNwZC9pTmcydGpLZ3dwekl0VlgwbXlKY0VSWTJD?=
 =?gb2312?B?VG9pall4WEdHdkxqdGpOZWhtZzhqdW95ZUg0SFk2T1I0dmdGQ0FxSWMwUy9R?=
 =?gb2312?B?dzRXZGdTSkhCNndTU2VUeWdkT0lpQ21ENGtDQ2xBb045Y2RDcldMb050TE5a?=
 =?gb2312?B?WitBUHlWd0ZCeDRBS3FGaFg4RGVqTUZudnJZWWdnclFobDdjRExBTjNWcGdp?=
 =?gb2312?B?RkpTbm50YkdBVVZEWEJqenhseVZDVTM2eFcxdGM2N2RsbGtCZU1TZzdveUVL?=
 =?gb2312?B?UGNidU1HcjJlM2dJTXJkblVPeWRuckk4aGh4Wm5ZTmNtSVdhUXUrczlscUpY?=
 =?gb2312?B?eGdVb3VIZGQ5d2ZUazJwMm9Ra3lkck9yeHpHSW9XOTUzMlE1ODdEN0czampV?=
 =?gb2312?B?M1lhK3QyV3BCZ1BLMVA2blZwbGFBSjdTT3RJVCt4ZUY3amxzTmZGKzNOazE0?=
 =?gb2312?B?aXZVc21UOXBEd2N3TlpTVXRhZzBSU1ZnMEtqdDY3M2dLc0ZBYWZWMXZNOXgr?=
 =?gb2312?B?M2ZsMlViYzJ4UkVaaTlTZEQ1MkZRNGcwS0V6S29hcy9lK29BRkhxbUxzZ3RE?=
 =?gb2312?B?SW42Q3l4U2tka2dCWHNyMEE4SnJZU05KT0dFUGZvYVA3eG5aNitrUWRHaExP?=
 =?gb2312?B?Z3VDbmJqdytWcG9CSTB6d0VGRjFlRXFrYitydk1lSFdOZEtZMGxxN3JZL1VB?=
 =?gb2312?B?V2NLR1V6OUJLQ2ZEMmQybWlMZzEyUmpxNjYxUHo0WVJINXZldzhVMEovV3J4?=
 =?gb2312?B?MXNoN0xmZExNYzlJR09CRjFXNVlkaXVyS1N0NmxaenpBMWkrOEQwRG11QktE?=
 =?gb2312?B?aERZTGtrQndkbVp3R3BDRnJJaU5ZL2FqV2puc2VORnVtQUpBU0NucjBXVk8v?=
 =?gb2312?B?NEhxVXFmY2FSVHhrWTVKdjVUM0dyeGdIbWxIdUFIeVY4QzFXR1Z4Wk5qdCs1?=
 =?gb2312?B?cS9NS2tDUVV5Y05sNHBRRU9tSlhWU3hSUkJKcCt2VzlES1VoaGdDVmMzbXB5?=
 =?gb2312?B?ODA0L21oUlBaWGFtQkRJQTdNa2dvb3pITWs1L2pJb1VLYTVGamRjcEFFdis2?=
 =?gb2312?B?NGV4bkJhQ1dMcXRrYWVFTHFqYlAwRVFqZlNQY1JKNm56VlliN3FWbk5UQVND?=
 =?gb2312?B?SGNDc2toVHRoRUtCZ2I5QWR4QTJNOG0veTFlcVdOZVcreGh6U0ZkTmtVb04z?=
 =?gb2312?B?YTl6TEVoZ09pUVlLVXVVN0R1eFlEU0dtenVBTHgwaGlkSEg1cExCdHlTTloz?=
 =?gb2312?B?YVdIazl3dmt2SkF4RHd6Vi9NZ0MraHdoSVFOZkJMS3RNQlNocGxuSlc2aklu?=
 =?gb2312?B?ZTdyd3orWGg1UXptTHdJY1FWVUdVdWNwbGE1ZW1RdFY3VDJSN2Z5QmVFbzNR?=
 =?gb2312?B?Vm04c3g0SURSQ2RRTWxUMDJXWDRHUmZLWGhWRUZEK1BHOTkrRkV6MzhocWxj?=
 =?gb2312?B?V3kxcUN1WmRoU2ZiVkxWN2JkbzlXT3JMVmlzNWFrVE1iSlMvV1ZwMkVWSmg2?=
 =?gb2312?B?R1VJT1VBaGxWU3FFZFNyZVBpaFZFcFVCUVFWbzNMT081cDM1ZHNnZVgydDFj?=
 =?gb2312?B?M3N1S1RzZFpScWZQWDhCcVVaUm9TQmZvcDduRXFBMmNQRDI2c3dvdWl6UkNM?=
 =?gb2312?B?NUlIMjRmKzg4YlZoQTMwRUcwME5JMkRTdzBtQ0pSZ1A4WDgwUkJlWXRMZUdO?=
 =?gb2312?Q?s+8g=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e5e9f7-2105-4ddb-21ba-08dce8022256
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 01:31:44.3365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 61EWe6FfrDjTuR5wrU9XUKjkatOyy8AyhYORYu5wM4slFUEbJLwIpM8CwMloRjfKDr5i/hF3MsbcTg5N93Sr/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10941

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWbGFkaW1pciBPbHRlYW4gPHZs
YWRpbWlyLm9sdGVhbkBueHAuY29tPg0KPiBTZW50OiAyMDI0xOoxMNTCOcjVIDY6NDgNCj4gVG86
IFdlaSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29tPg0KPiBDYzogZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsg
ZWR1bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOw0KPiBwYWJlbmlAcmVkaGF0LmNv
bTsgQ2xhdWRpdSBNYW5vaWwgPGNsYXVkaXUubWFub2lsQG54cC5jb20+Ow0KPiBhc3RAa2VybmVs
Lm9yZzsgZGFuaWVsQGlvZ2VhcmJveC5uZXQ7IGhhd2tAa2VybmVsLm9yZzsNCj4gam9obi5mYXN0
YWJlbmRAZ21haWwuY29tOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBuZXRkZXZA
dmdlci5rZXJuZWwub3JnOyBicGZAdmdlci5rZXJuZWwub3JnOyBzdGFibGVAdmdlci5rZXJuZWwu
b3JnOw0KPiBpbXhAbGlzdHMubGludXguZGV2OyBya2Fubm90aEBtYXJ2ZWxsLmNvbTsgbWFjaWVq
LmZpamFsa293c2tpQGludGVsLmNvbTsNCj4gc2JoYXR0YUBtYXJ2ZWxsLmNvbQ0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHYyIG5ldCAzLzNdIG5ldDogZW5ldGM6IGRpc2FibGUgSVJRIGFmdGVyIFJ4
IGFuZCBUeCBCRCByaW5ncw0KPiBhcmUgZGlzYWJsZWQNCj4gDQo+IE9uIFR1ZSwgT2N0IDA4LCAy
MDI0IGF0IDA2OjMwOjQ5QU0gKzAzMDAsIFdlaSBGYW5nIHdyb3RlOg0KPiA+IEkgdGhpbmsgdGhl
IHJlYXNvbiBpcyB0aGF0IFJ4IEJEUnMgYXJlIGRpc2FibGVkIHdoZW4gZW5ldGNfc3RvcCgpIGlz
IGNhbGxlZCwNCj4gPiBidXQgdGhlcmUgYXJlIHN0aWxsIG1hbnkgdW5wcm9jZXNzZWQgZnJhbWVz
IG9uIFJ4IEJEUi4gVGhlc2UgZnJhbWVzIHdpbGwNCj4gPiBiZSBwcm9jZXNzZWQgYnkgWERQIHBy
b2dyYW0gYW5kIHB1dCBpbnRvIFR4IEJEUi4gU28gZW5ldGNfd2FpdF90eGJkcigpDQo+ID4gd2ls
bCB0aW1lb3V0IGFuZCBjYXVzZSB4ZHBfdHhfaW5fZmxpZ2h0IHdpbGwgbm90IGJlIGNsZWFyZWQu
DQo+ID4NCj4gPiBTbyBiYXNlZCBvbiB0aGlzIHBhdGNoLCB3ZSBzaG91bGQgYWRkIGEgc2VwYXJh
dGUgcGF0Y2gsIHNpbWlsYXIgdG8gdGhlIHBhdGNoDQo+ID4gMiAoIm5ldDogZW5ldGM6IGZpeCB0
aGUgaXNzdWVzIG9mIFhEUF9SRURJUkVDVCBmZWF0dXJlICIpLCB3aGljaCBwcmV2ZW50cyB0aGUN
Cj4gPiBYRFBfVFggZnJhbWVzIGZyb20gYmVpbmcgcHV0IGludG8gVHggQkRScyB3aGVuIHRoZSBF
TkVUQ19UWF9ET1dOIGZsYWcNCj4gPiBpcyBzZXQuIFRoZSBuZXcgcGF0Y2ggaXMgc2hvd24gYmVs
b3cuIEFmdGVyIGFkZGluZyB0aGlzIG5ldyBwYXRjaCwgSSBmb2xsb3dlZA0KPiA+IHlvdXIgdGVz
dCBzdGVwcyBhbmQgdGVzdGVkIGZvciBtb3JlIHRoYW4gMzAgbWludXRlcywgYW5kIHRoZSBpc3N1
ZSBjYW5ub3QgYmUNCj4gPiByZXByb2R1Y2VkIGFueW1vcmUgKHdpdGhvdXQgdGhpcyBwYXRjaCwg
dGhpcyBwcm9ibGVtIHdvdWxkIGJlIHJlcHJvZHVjZWQNCj4gPiB3aXRoaW4gc2Vjb25kcykuDQo+
ID4NCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMvZW5ldGMu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0Yy5j
DQo+ID4gQEAgLTE2MDYsNiArMTYwNiwxMiBAQCBzdGF0aWMgaW50IGVuZXRjX2NsZWFuX3J4X3Jp
bmdfeGRwKHN0cnVjdA0KPiBlbmV0Y19iZHIgKnJ4X3JpbmcsDQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgYnJlYWs7DQo+ID4gICAgICAgICAgICAgICAgIGNhc2UgWERQX1RYOg0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgIHR4X3JpbmcgPSBwcml2LT54ZHBfdHhfcmluZ1tyeF9yaW5n
LT5pbmRleF07DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKHVubGlrZWx5KHRlc3Rf
Yml0KEVORVRDX1RYX0RPV04sDQo+ICZwcml2LT5mbGFncykpKSB7DQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBlbmV0Y194ZHBfZHJvcChyeF9yaW5nLCBvcmlnX2ksIGkpOw0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdHhfcmluZy0+c3RhdHMueGRwX3R4
X2Ryb3BzKys7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICB9DQo+ID4gKw0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgIHhkcF90eF9iZF9jbnQgPQ0KPiBlbmV0Y19yeF9zd2JkX3RvX3hkcF90eF9zd2JkKHhk
cF90eF9hcnIsDQo+ID4NCj4gcnhfcmluZywNCj4gPg0KPiBvcmlnX2ksIGkpOw0KPiANCj4gWWVh
aCwgaXQgd29ya3Mgb24gbXkgc2lkZSBhcyB3ZWxsLiBUaGFua3MgZm9yIGZvbGxvd2luZyB1cC4N
Cj4gDQo+IEkgd291bGQgYXJndWUgdGhhdCB0aGUgYWJvdmUgc25pcHBldCBzaG91bGQgYmUgYSBm
aXh1cCBmb3IgdGhlDQo+ICJuZXQ6IGVuZXRjOiBmaXggdGhlIGlzc3VlcyBvZiBYRFBfUkVESVJF
Q1QgZmVhdHVyZSIgY2hhbmdlLCBhbmQgYQ0KPiByZXdyaXRlIG9mIHRoZSBjb21taXQgbWVzc2Fn
ZSBpcyBpbiBvcmRlci4gQ3VycmVudGx5LCBhcyBhIHJlYWRlciwgSSBnZXQNCj4gdGhlIGltcHJl
c3Npb24gdGhhdCBvbmx5IFhEUF9SRURJUkVDVCBuZWVkcyB0byBjaGVjayB0aGUgRU5FVENfVFhf
RE9XTg0KPiBmbGFnLCBvbmx5IGZvciB0aGUgbmV4dCBwYXRjaCB0byBjb21lIGFuZCBzYXkgInJl
bWVtYmVyIHdoYXQgd2FzIHNhaWQNCj4gYWJvdXQgdGhlIFRYIHJpbmcgbm90IGJlaW5nIGFsbG93
ZWQgdG8gYWN0aXZlbHkgdHJhbnNtaXQgZnJhbWVzIHdoaWxlDQo+IGRpc2FibGluZyBpdD8gd2Vs
bCwgdGhhdCBwYXRjaCB3YXNuJ3Qgc3VmZmljaWVudCB0byBlbnN1cmUgdGhpcyBjb25kaXRpb24s
DQo+IGJlY2F1c2UgWERQX1RYIG5lZWRzIHRvIHJlc3BlY3QgdGhhdCBmbGFnIGFzIHdlbGwhIg0K
DQpPa2F5LCBJIHdpbGwgbWVyZ2UgdGhpcyBzbmlwcGV0IGludG8gIm5ldDogZW5ldGM6IGZpeCB0
aGUgaXNzdWVzIG9mIFhEUF9SRURJUkVDVA0KZmVhdHVyZSIgYW5kIHJlZmluZSB0aGUgY29tbWl0
IG1lc3NhZ2UuDQo=

