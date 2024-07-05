Return-Path: <bpf+bounces-33972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC08928EC7
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 23:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A6FC2821B0
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 21:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4378C149DF7;
	Fri,  5 Jul 2024 21:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="DFnKjlKu"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2074.outbound.protection.outlook.com [40.107.20.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1830013C907;
	Fri,  5 Jul 2024 21:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720214567; cv=fail; b=P8Nsh2WOHj5Bv87p4JfmqAwMF2Lc+FbxGQsd4bN/dsU39EzZ8rioOGFia4m+o3VhnrM1VE/+D58d8zCXNMy1ulsPPZPDiU4wSDq1i5Ih8qVgiM2cBTqsgPnr1EDIhkriNnPCrQht0Kpg2LNy/keIiCZwgW1YxQKuaOLNMLI3yas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720214567; c=relaxed/simple;
	bh=+TG42dOS+CtmkG7xP1+mkiQNglNj1+9mCQCiR0HPCFs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VTkUMnrMAFYVR4RKAI97ASDXJSeoo3+d7kP1wGRyGcIowSzybSl1znA7Jf9UKxvRUBojqGXz6B/pECQq4+D7XymWiybF5kSorcpu2qcg0D7etFN8JvXMld/bEK3b3EqbPnhRFb2ukNerfx8290OSZO+HiGhxJwFbo0pjh8Ogj6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com; spf=pass smtp.mailfrom=ericsson.com; dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b=DFnKjlKu; arc=fail smtp.client-ip=40.107.20.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ericsson.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUXAHl2OaW0R5N/TkXbXf5qPhEQRHfFWhFGGxfCQdZvuKPnVnOS2TAUxRfe+CTiraeRGJ2JbzGYI/T+k+yyzMh9NwL6FXlSg+1phhTbsWzdMCk2aECSNE1vU1hDCEUG36kFGcEjGirRpwT6DuL0jxbkDvPByjZuBO++MTVMjJQEN5tWBadONodCnSX4p6kPAMRofhUHgs9+7w0QNSDe35QB01Q7fsPPb++rFFLN8SkBejN03wEzO6ua5Y4zdzQDoidAQ36dAi5SBWOOq5EyGusU+VHz4sMtfvzDnjdK6WBb+oFqmUo8HkwzHesVlB6FDyGDEBEA/5a8ZDPID0BsXjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TG42dOS+CtmkG7xP1+mkiQNglNj1+9mCQCiR0HPCFs=;
 b=Tc1tn/17SAJOaUldNL4QYSoI4zUVf0iGF5s2pjLQtiWQa3nNbvsUqaI1mcC3s+K+/Z8+ycVze1LSRsn61KqmLv2lHQi8KcRmrLVPozbZfwQJwhg6QgltLi7jAq3xCGhauvAKSfYo5mwN6O6OJB1oQJRhmc0MdeUX0SR6BGRzUHNEdhlqU4CXhC9216b1jN7P8zecK8VmktlLJHAtvCxFa75GQDe5zp227eXW87i6XVQYMVrYRQSqoJHEXLzr1/Q1EBaeoP2/xkVRi5s11KT8v6sodysQ45p3IjqnWbhgjIXYp2ecfuvFVICaO6UzrnmxZh29ngExtuzdUvnwh863Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TG42dOS+CtmkG7xP1+mkiQNglNj1+9mCQCiR0HPCFs=;
 b=DFnKjlKuAIkTVYymjFtuLpbmv3nt2S+XxRXIOWXvZ0hsO3bRztTkjCCnCUKKIrYi7sE/hKXbvwcV5l4b9ZummbyPdQx2qT45liyCKFYW5t8ZTry7QEJfWXNHP9/C6HhKqSPDIsYwjSScUpSdtmuUO0uBSyjscRNAXms3PvGGt+AH4VcD7fb5I9YZBQyW4OwStmoT9UsuqM2XFCTRnQjCsL5nyonpVJ5xzml8i3TVTgcRi3YcedlPULinCoMMvOgDlLZSGvL3XHWAEjG2pMxoJ1FDg+Hc1Klg7+WxsXldS4Cgcw/vTJh5HgDS4vXgwO3XGXCTevZCbcw9JG3p1FaBPA==
Received: from AS4PR07MB8412.eurprd07.prod.outlook.com (2603:10a6:20b:4e3::19)
 by AM8PR07MB7585.eurprd07.prod.outlook.com (2603:10a6:20b:235::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.11; Fri, 5 Jul
 2024 21:22:39 +0000
Received: from AS4PR07MB8412.eurprd07.prod.outlook.com
 ([fe80::b5b2:28fe:fe9:9665]) by AS4PR07MB8412.eurprd07.prod.outlook.com
 ([fe80::b5b2:28fe:fe9:9665%4]) with mapi id 15.20.7741.017; Fri, 5 Jul 2024
 21:22:39 +0000
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: Kurt Kanzenbach <kurt@linutronix.de>, Benjamin Steinke
	<benjamin.steinke@woks-audio.com>, Sriram Yagnaraman
	<sriram.yagnaraman@est.tech>
CC: "intel-wired-lan@osuosl.org" <intel-wired-lan@osuosl.org>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Jesper Dangaard Brouer
	<hawk@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jonathan Lemon
	<jonathan.lemon@gmail.com>, John Fastabend <john.fastabend@gmail.com>, Alexei
 Starovoitov <ast@kernel.org>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
	<bjorn@kernel.org>, Eric Dumazet <edumazet@google.com>, Sriram Yagnaraman
	<sriram.yagnaraman@est.tech>, Tony Nguyen <anthony.l.nguyen@intel.com>, Jakub
 Kicinski <kuba@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>,
	Magnus Karlsson <magnus.karlsson@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v4 0/4] igb: Add support for
 AF_XDP zero-copy
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v4 0/4] igb: Add support for
 AF_XDP zero-copy
Thread-Index: AQHayGDCrrd4wKyst0qeyB4qGdOOc7Hb0yIAgAAINICADNGQUA==
Date: Fri, 5 Jul 2024 21:22:39 +0000
Message-ID:
 <AS4PR07MB8412F92231A7C6E9FFAF13ED90DF2@AS4PR07MB8412.eurprd07.prod.outlook.com>
References: <20230804084051.14194-1-sriram.yagnaraman@est.tech>
 <878qyq9838.fsf@kurt.kurt.home> <3253130.2gtjKKCVsX@desktop>
 <87cyo2fgnm.fsf@kurt.kurt.home>
In-Reply-To: <87cyo2fgnm.fsf@kurt.kurt.home>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR07MB8412:EE_|AM8PR07MB7585:EE_
x-ms-office365-filtering-correlation-id: 9e9f1dba-3118-4b6a-e92d-08dc9d389965
x-ld-processed: 92e84ceb-fbfd-47ab-be52-080c6b87953f,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SEZWVCtiZHdnZ3hFWVc4dS9DaVNrcnBqazZmQzg4N2JGNi9KWkh0YjZveldI?=
 =?utf-8?B?eWxoTHJiTnNGa0N4OEExSDh4UWJYWXljS01rUnFzSzVob1A1bWp5K0wzZGo4?=
 =?utf-8?B?VEFQTlJaYjVCLzNvbys3TEhTMWVxRkZ3SE12Szk0eWt1TEltS1Boc1pCUkVa?=
 =?utf-8?B?U2wybUovL3pHN0plSWpqQk5nU0NaT1BKbkZqckRLNUpxdUpvQmZJZUgxSmF6?=
 =?utf-8?B?YTFQVEFTM3NWTDdmZzFGVDMrakRRUWhQNzdwb3ZlbnRSMWFJVnRPb3Y0aVlL?=
 =?utf-8?B?OXQ0RnF6REpVMHFIZ2hzcldhV3ZRK3o5UlNlWWdMNnpOeGRBYnNyR3hWNDIv?=
 =?utf-8?B?TFRiVjNwUmdpcHZjTjBlVFZnR2VsV05iTDNnbjRpcHAxdGlkdTNmVkUzWXgw?=
 =?utf-8?B?ZmYzaStSUnB2QXVFYUFEQURKOGE4elp1WnF1MXVnUEk2YkorTjFvQnN0b0NR?=
 =?utf-8?B?MSt6UUJSd3JOZkhMSjJ2b3dNK3h5OUtnR0drQXFKRjdaaWtaSUJyQy96c0RO?=
 =?utf-8?B?WFBhemVxM3RXN2hrOGlpckhLSnY5SFNBT0dRRXVRMFdXclR3b1JyTDBWbTVo?=
 =?utf-8?B?OVBYckljY1BXQzVsZXd6VXVRckw1bWh6TXE2cWNkQzlaME1hZENrRkh5N1hy?=
 =?utf-8?B?ZXhSNit2ZDREd3NsQVY3d21TUEwxcXN4RHhnZnZnTlNBTC9WK1dENWpxNVQ3?=
 =?utf-8?B?bHhKMkIrblExTHcrUXFKRVBYejZFMmY3cEVNSHVmMUdTTWlsdFpYcGtsS2VH?=
 =?utf-8?B?RXVLYWZRc2d4YUNhbzRtSGFCK3k5KzNGYmhpWE9ybUc3UFFFaFA0T2hBMFd6?=
 =?utf-8?B?djNVN2RQL1A4N0tDY0wvNFphcXpNUVhkWXpwbFJVckZuN1hMWUM0SDVrYnBQ?=
 =?utf-8?B?MUtKZ1c1aWw5aTJlNGdWUFZ5aTJmblFBUFpxNmZYcUVFTU9janhrR0drRE84?=
 =?utf-8?B?V2NOYVBzL1lhc0thbnBqZkRxVjQ0MDI3QW1nUi9ZMkowaDJSRFoxMmcxL1k3?=
 =?utf-8?B?RWEwamJiYlgxenQ5bE9xUVpUaDhrWEdubDU0eG5YOHJwWGFnQTh2Z3RKdGJk?=
 =?utf-8?B?c2JmaWhPS1lWamNKY0s2NnZreS9MdWRRTXlhMDhNMm9mY21KU2JXSXlXdU5F?=
 =?utf-8?B?bG1sT3hpMG1rOUZUNmZBK3UyZHNrSmk4RG5sSlhsUVJ0dlhwcldlWnpQdmdW?=
 =?utf-8?B?ZzFVb2grb0lrbWRoV0pGVEZydW5uU0RXNnJNK3FiVG9wNUlOb3NwWHByNVY3?=
 =?utf-8?B?SHBkMTFsVXBuMVQxUjRkYzU2MTRlTTVKZmZQelE3K3BaK2lSbThUaU9hRDZq?=
 =?utf-8?B?bElIOURjZHJPVmFONUYyeWVEVzdOSGZMbFdoY1cvR0k0Z2J6NWxoRTloOGJl?=
 =?utf-8?B?a3d1L0s3bjk5UG54cWt6UmgxSDRqU3NXTzF0ZVRNbjJxZVBlTGxLT0g5SUxK?=
 =?utf-8?B?czRtb29YNFZoK0c3WDU1bUNpcnNEUnQ1TzhOV3g2MTNuczcxUndWOHhSdUFX?=
 =?utf-8?B?cjFjam1zajNrQTJYOXZvNkQ0VStaNkVMdU1RcnpoMFYxdElsbDRwYStLcnlM?=
 =?utf-8?B?ZDI5UGVlN0FBMG8xMk45alQvRWNDR3ZmQTIwajNOWFp5bUE3UExQdDA0R0xU?=
 =?utf-8?B?VWdMem11S3FDakVpVlByL2R2RlI1N1FkMWR3MkIxUmxxS2t5c253SEZPdnlT?=
 =?utf-8?B?aGVCOGx3cFlRc3djTmZyeXRITmxNNFh4SExPbnU5aDg1Nk1RUURkNllwTGxV?=
 =?utf-8?B?Umc4Vjl3dkRIWUxNeWxDaGNDTDc3eTNDS0kxeDVaVUdBNkFQS25iQ1lEZG5K?=
 =?utf-8?B?NGErOFdjaHloRkozVkVnMmJZTndGcWlBcmdyZU9tNkFoa2ZicDFYazRWb0ZJ?=
 =?utf-8?B?LzFrSENaNnZWbC9vdGd2cmcyRWRIZGFvS2lWZVpPZTNzVkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR07MB8412.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WUE2eDFWMmI4ejRLK29Dd211cWd2M3dnR0hHc0hsSmhGM29RMkpPNk1EbHA5?=
 =?utf-8?B?ZzM2VlR0czRIQ3BRZ1lNczNWcWdJaEtVempQMGhzWTViU0pvNXJoblZtazZN?=
 =?utf-8?B?cmJPL0poYzZiVzRqbEtzNTFHZ3N3T1VzWDV0WFNKbVNId25tSVlpQWNMMnJp?=
 =?utf-8?B?YXFudVk1ZEFzMWFTQXJYUTBIclROK1NybHZjckhzejJ0OEJsT2dhTzFSUGln?=
 =?utf-8?B?MDhiTWhrdFpDQXFkZFlIRW94cFJIR2tJTS9lYVREYmE4aFhWWUw1K29jc24r?=
 =?utf-8?B?dkRNcVEyMmJTMnc0UzNNL2VtTEZuc3JrUzJub01lRFBaaGtCZjhFeGVhS0sz?=
 =?utf-8?B?Qyt1aTNTY1ozS3NBZTUvek9SeWkrQ04yS3pXQVBiL0trL3RLcGkvM3Q1bEla?=
 =?utf-8?B?VUpITHhya3REcWFnQkpkbmRHQ00zQUVnbzBTOEsvWGthMllxdkx6UFhxVHk4?=
 =?utf-8?B?OHpPaHBMVkhBc3Q2c3FiQlBvN3d3c1Q5MWRvYko3ODFPUkFOQ3k4QkRFZkJz?=
 =?utf-8?B?SHVLdTl3TXdvT1E5dkdEbmkyeEJjVkQzaGMvZksvMDRTT2lkWFN0T005KzNq?=
 =?utf-8?B?TmVnaFlDSTZidmlPNFVVMlJwb2hnTVhhNHJ0TnhiSWdqa3dZY3kzT3dNdEYv?=
 =?utf-8?B?Sk5FUndVbmhsZjZCVWRIbE9hZU9UNXI1b1BjZGQxMEV4NitJblFvVG9DbXhK?=
 =?utf-8?B?SkgrQ1ZVMjVQcU50SVU5UDhranVaWjV4MEZ5NWtoNUZUdlhGV0tyYVZXby9w?=
 =?utf-8?B?eUVVUWo5aUljbHgxa1JJT1hzekdGT1ZDcHUzWUJtZHllY28rbFNveWRYZ1Ux?=
 =?utf-8?B?NkxWYU1QU1plWGVqRVRNdzE1YTBTTDB0N01VeityRzQyOVlzZk1ObTlOYytu?=
 =?utf-8?B?ZExWWXl0YlFiNThVSURIMldGUDR3bVRoSXphWlJxbnZQbTIxZmpEb1NSNTBM?=
 =?utf-8?B?c2dpVkdFU2FqMGJqVnhRaHVYWUIvbXJSbVdKeGhENWxDaGYxUk5GbzdJazdQ?=
 =?utf-8?B?SEJ3a1A0YUpBOTJPbzdQUmdwcE1Eellxc2o3SkpLaUgyVGRsek5vVW91czZi?=
 =?utf-8?B?b3ZLeTJSRE1FUi9EYnNCSnp2d1BPY2FmTXdNU2tQeUpKTFpaR3A0Mk9ZRVE5?=
 =?utf-8?B?OFFKQXBiN0lCTVJ6YnF1TlhDaXVabEZlUGlQSlVIT3M4N2JRNXlQeW9ReDR4?=
 =?utf-8?B?Uy9VYTM3eXhnN1Flc0F3MDYya3plUllFNmpTdzIrbENRLys3RU1KVk5pUjJ3?=
 =?utf-8?B?bVlITGNoSGxJdlNGTVR0SVNBOXhGamNqRDJNckVjWmlzT0wrQW9ZS3FxTytw?=
 =?utf-8?B?Rjc3NnI4bzJxby96VmoyT2ZIT00rc2hMOEZ5K3hjMHUwM09sMm1hdVlUb1po?=
 =?utf-8?B?YjZkbG5uQU5zQTloVGJONFBab1hrZ1NoMzVGUTRRdkZaL0dYT2dLQkliVThu?=
 =?utf-8?B?ZkR5VDMwekk5WWtKZk9nTThiWlFMZU80QS8wTGJoYXdDaENwWFV1dTBNR0x4?=
 =?utf-8?B?eURWT2dKQVhNZkd4MGp2aDM1VnRFY29HQjFDNHU3WDh0ajQzM1J1MnFTWEtW?=
 =?utf-8?B?RHkva1FhQ09TTXRCS1YxNXppNkZUVVEyd1o5YUJxMi9BcHVHNnE4bitLN3hR?=
 =?utf-8?B?ZDFvTy9CTENTLy9zc09VZ2FpaXd6RWtxRExhTUZmMUx2QTJOM2FpWW9XYzI5?=
 =?utf-8?B?UWM1QkNpOGlXS1VudGlIdnR0czB1c1VWWnYyaEM1bFU5ZlA1a0o4WUFMdzlD?=
 =?utf-8?B?Qm54QUk4R3VBM0RmZGJqZnBibmxwMTJJQkVTRzVselY0YnlTbFBnU2x0czBv?=
 =?utf-8?B?anJjcmxkL3FMeGNWdnRkSVZoSWs4NFRyUUNYenpNZitYd2h6VlBQdXZIei9x?=
 =?utf-8?B?WkhQM2U4NFRBVnNBeDVreDJZeDVIN1ZmTGZFNkQ3aSt0dGtkZUVwTEt0UnRN?=
 =?utf-8?B?b0N3aElBdVZadG5POFJoS01oajRGU0FuV0dUUGtVcWZlOUppWkxMWUM2RnFs?=
 =?utf-8?B?WE9jaVNZb3k3OFI5NEpNM2FBM2NmQWVsS1BFTU1wL056c2Q2K2pxbUFvVlQz?=
 =?utf-8?B?TjBmU3RhcU5TMUNJNUxCNEVIRGpmUVg3OE5EVFBEeGdYRnZGYjhReEFnZ3Jt?=
 =?utf-8?B?VXFBeTMxcnNLcHBaQU53OTNOSms5RUlaaktIYkFONmRnenFUeitEdzlXemt5?=
 =?utf-8?B?Q0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR07MB8412.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9f1dba-3118-4b6a-e92d-08dc9d389965
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 21:22:39.6740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iU+m23HPcba6TendFLpRDrnr2zKbrY4Z2vffSwy3c16RLxNZ1oGmdZXZ6Tsy1GZWj1Sd1S1c8ZTp+vZWh3HZzBwUIHWnu3aapy8EIOJJABw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB7585

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3VydCBLYW56ZW5i
YWNoIDxrdXJ0QGxpbnV0cm9uaXguZGU+DQo+IFNlbnQ6IFRodXJzZGF5LCAyNyBKdW5lIDIwMjQg
MTk6MTkNCj4gVG86IEJlbmphbWluIFN0ZWlua2UgPGJlbmphbWluLnN0ZWlua2VAd29rcy1hdWRp
by5jb20+OyBTcmlyYW0NCj4gWWFnbmFyYW1hbiA8c3JpcmFtLnlhZ25hcmFtYW5AZXN0LnRlY2g+
DQo+IENjOiBpbnRlbC13aXJlZC1sYW5Ab3N1b3NsLm9yZzsgTWFjaWVqIEZpamFsa293c2tpDQo+
IDxtYWNpZWouZmlqYWxrb3dza2lAaW50ZWwuY29tPjsgSmVzcGVyIERhbmdhYXJkIEJyb3VlciA8
aGF3a0BrZXJuZWwub3JnPjsNCj4gRGFuaWVsIEJvcmttYW5uIDxkYW5pZWxAaW9nZWFyYm94Lm5l
dD47IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7DQo+IEpvbmF0aGFuIExlbW9uIDxqb25hdGhhbi5s
ZW1vbkBnbWFpbC5jb20+OyBKb2huIEZhc3RhYmVuZA0KPiA8am9obi5mYXN0YWJlbmRAZ21haWwu
Y29tPjsgQWxleGVpIFN0YXJvdm9pdG92IDxhc3RAa2VybmVsLm9yZz47IEJqw7Zybg0KPiBUw7Zw
ZWwgPGJqb3JuQGtlcm5lbC5vcmc+OyBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+
OyBTcmlyYW0NCj4gWWFnbmFyYW1hbiA8c3JpcmFtLnlhZ25hcmFtYW5AZXN0LnRlY2g+OyBUb255
IE5ndXllbg0KPiA8YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+OyBKYWt1YiBLaWNpbnNraSA8
a3ViYUBrZXJuZWwub3JnPjsNCj4gYnBmQHZnZXIua2VybmVsLm9yZzsgUGFvbG8gQWJlbmkgPHBh
YmVuaUByZWRoYXQuY29tPjsgRGF2aWQgUyAuIE1pbGxlcg0KPiA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5l
dD47IE1hZ251cyBLYXJsc3NvbiA8bWFnbnVzLmthcmxzc29uQGludGVsLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSCBpd2wtbmV4dCB2NCAwLzRdIGlnYjogQWRk
IHN1cHBvcnQgZm9yDQo+IEFGX1hEUCB6ZXJvLWNvcHkNCj4gDQo+IEhpIEJlbmphbWluLA0KPiAN
Cj4gT24gVGh1IEp1biAyNyAyMDI0LCBCZW5qYW1pbiBTdGVpbmtlIHdyb3RlOg0KPiA+IE9uIFRo
dXJzZGF5LCAyNyBKdW5lIDIwMjQsIDA5OjA3OjU1IENFU1QsIEt1cnQgS2FuemVuYmFjaCB3cm90
ZToNCj4gPj4gSGkgU3JpcmFtLA0KPiA+Pg0KPiA+PiBPbiBGcmkgQXVnIDA0IDIwMjMsIFNyaXJh
bSBZYWduYXJhbWFuIHdyb3RlOg0KPiA+PiA+IFRoZSBmaXJzdCBjb3VwbGUgb2YgcGF0Y2hlcyBh
ZGRzIGhlbHBlciBmdW5jY3Rpb25zIHRvIHByZXBhcmUgZm9yDQo+ID4+ID4gQUZfWERQIHplcm8t
Y29weSBzdXBwb3J0IHdoaWNoIGNvbWVzIGluIHRoZSBsYXN0IGNvdXBsZSBvZiBwYXRjaGVzLA0K
PiA+PiA+IG9uZSBlYWNoIGZvciBSeCBhbmQgVFggcGF0aHMuDQo+ID4+ID4NCj4gPj4gPiBBcyBt
ZW50aW9uZWQgaW4gdjEgcGF0Y2hzZXQgWzBdLCBJIGRvbid0IGhhdmUgYWNjZXNzIHRvIGFuIGFj
dHVhbA0KPiA+PiA+IElHQiBkZXZpY2UgdG8gcHJvdmlkZSBjb3JyZWN0IHBlcmZvcm1hbmNlIG51
bWJlcnMuIEkgaGF2ZSB1c2VkDQo+ID4+ID4gSW50ZWwgODI1NzZFQiBlbXVsYXRvciBpbiBRRU1V
IFsxXSB0byB0ZXN0IHRoZSBjaGFuZ2VzIHRvIElHQiBkcml2ZXIuDQo+ID4+DQo+ID4+IEkgZ2F2
ZSB0aGlzIHBhdGNoIHNlcmllcyBhIHRyeSBvbiBhIHJlY2VudCBrZXJuZWwgYW5kIHNpbGljb24g
KGkyMTApLg0KPiA+PiBUaGVyZSB3YXMgb25lIGlzc3VlIGluIGlnYl94bWl0X3pjKCkuIEJ1dCBv
dGhlciB0aGFuIHRoYXQgaXQgd29ya2VkDQo+ID4+IHZlcnkgbmljZWx5Lg0KPiA+DQo+ID4gSGkg
S3VydCBhbmQgU3JpcmFtLA0KPiA+DQo+ID4gSSByZWNlbnRseSB0cmllZCB0aGUgcGF0Y2hlcyBv
biBhIDYuMSBrZXJuZWwuIE9uIHR3byBkaWZmZXJlbnQgZGV2aWNlcw0KPiA+IGkyMTAgJg0KPiA+
IGkyMTEgSSBjb3VsZG4ndCBzZWUgYW55IHBhY2tldHMgYmVpbmcgdHJhbnNtaXR0ZWQgb24gdGhl
IHdpcmUuIFBlcmhhcHMNCj4gPiBjYXVzZWQgYnkgdGhlIGlzc3VlIGluIGlnYl94bWl0X3pjKCkg
eW91IG1lbnRpb25lZCwgS3VydD8gQ2FuIHlvdQ0KPiA+IHNoYXJlIHlvdXIgZmluZGluZ3MsIHBs
ZWFzZT8NCj4gDQo+IFllYWgsIHRoYXQncyBleGFjdGx5IHRoZSBpc3N1ZS4NCj4gDQo+IEZvbGxv
d2luZyBpZ2JfeG1pdF94ZHBfcmluZygpIEkndmUgYWRkZWQgUEFZTEVOIHRvIHRoZSBUeCBkZXNj
cmlwdG9yIGluc3RlYWQNCj4gb2Ygc2V0dGluZyBpdCB0byB6ZXJvOg0KPiANCj4gaWdiX3htaXRf
emMoKQ0KPiB7DQo+ICAgICAgICAgWy4uLl0NCj4gDQo+IAkvKiBwdXQgZGVzY3JpcHRvciB0eXBl
IGJpdHMgKi8NCj4gCWNtZF90eXBlID0gRTEwMDBfQURWVFhEX0RUWVBfREFUQSB8DQo+IEUxMDAw
X0FEVlRYRF9EQ01EX0RFWFQgfA0KPiAJCSAgIEUxMDAwX0FEVlRYRF9EQ01EX0lGQ1M7DQo+IAlv
bGluZm9fc3RhdHVzID0gZGVzY3NbaV0ubGVuIDw8IEUxMDAwX0FEVlRYRF9QQVlMRU5fU0hJRlQ7
DQo+IA0KPiAJY21kX3R5cGUgfD0gZGVzY3NbaV0ubGVuIHwgSUdCX1RYRF9EQ01EOw0KPiAJdHhf
ZGVzYy0+cmVhZC5jbWRfdHlwZV9sZW4gPSBjcHVfdG9fbGUzMihjbWRfdHlwZSk7DQo+IAl0eF9k
ZXNjLT5yZWFkLm9saW5mb19zdGF0dXMgPSBjcHVfdG9fbGUzMihvbGluZm9fc3RhdHVzKTsNCj4g
DQo+IAlbLi4uXQ0KPiB9DQo+IA0KPiBBZnRlcndhcmRzIHBhY2tldHMgYXJlIHRyYW5zbWl0dGVk
IG9uIHRoZSB3aXJlLg0KPiANCj4gPg0KPiA+IFJYIHNlZW1lZCB0byB3b3JrIG9uIGZpcnN0IHNp
Z2h0Lg0KPiA+DQo+IA0KPiBZZXMsIFJ4IHdvcmtzIGV2ZW4gd2l0aCBQVFAgZW5hYmxlZC4NCj4g
DQo+ID4+IEl0IHNlZW1zIGxpa2UgaXQgaGFzbid0IGJlZW4gbWVyZ2VkIHlldC4gRG8geW91IGhh
dmUgYW55IHBsYW5zIGZvcg0KPiA+PiBjb250aW51aW5nIHRvIHdvcmsgb24gdGhpcz8NCj4gPg0K
PiA+IEkgY2FuIG9mZmVyIHRvIGRvIHRlc3RpbmcgYW5kIGRlYnVnZ2luZyBvbiByZWFsIGhhcmR3
YXJlIGlmIHRoaXMgaGVscHMuDQo+IA0KPiBHcmVhdC4gVGhhbmtzIQ0KDQpJIGhhdmUgc2luY2Ug
Y2hhbmdlZCBteSBwb3NpdGlvbiBhdCBteSBjb21wYW55LCBhbmQgbXkgbmV3IHBvc2l0aW9uIGRv
ZXNuJ3QgYWxsb3cgbWUgdG8gY29udHJpYnV0ZSB1cHN0cmVhbSB0byBrZXJuZWwgdW5mb3J0dW5h
dGVseS4NCkl0IHdvdWxkIGJlIGdyZWF0IGlmIG9uZSBvZiB5b3UgY2FuIHRha2Ugb3ZlciB0aGlz
IGFuZCBnZXQgaXQgZGVsaXZlcmVkIGlmIHBvc3NpYmxlLg0KDQpHbGFkIHRoYXQgb3RoZXJzIGZp
bmQgdGhpcyBwYXRjaCB1c2VmdWwgYXMgd2VsbC4gDQo=

