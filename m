Return-Path: <bpf+bounces-28038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FC88B4A8A
	for <lists+bpf@lfdr.de>; Sun, 28 Apr 2024 09:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E461B21284
	for <lists+bpf@lfdr.de>; Sun, 28 Apr 2024 07:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2477751C3F;
	Sun, 28 Apr 2024 07:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="la6hkShB";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="fyWJ4IRC"
X-Original-To: bpf@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4560979F9;
	Sun, 28 Apr 2024 07:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714290510; cv=fail; b=Q+GKv2mdFOHt5nQq89O56hpZg8JmOTAD3Wz+3ztGnST6F6EXMhaF7u68VuQZCqWoy4/29qnsZNGgKdjoTFXpamUUAn0tOFLROM5AnE+TH6ZMm61N3BbUlvYoS9ydYvdCMR0/+np8zJByvPvKtp6P/CMlSsudq/3Rnr9QP49hh4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714290510; c=relaxed/simple;
	bh=YDQvaZG3HsYvazlvMgbLYs+SjmYwyOPArJWTMj4tz9Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kht1F/8XQNdAfF6JA1E712jfw/jCNpAJZ7n88XE8H0CpJLNNfVN0h7qBl+rAc68wPDHto4d+TY37RBqIdUMZMYdCn3oBlqAe6RNE1nEVS3D5OnJbvypYlhbo61ZG7w3TAEeu9DBqVS9VF/sfM2R2jZM3B2NcEd+H6Itw54t/OjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=la6hkShB; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=fyWJ4IRC; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: abcaa39e053311efb92737409a0e9459-20240428
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=YDQvaZG3HsYvazlvMgbLYs+SjmYwyOPArJWTMj4tz9Y=;
	b=la6hkShBmgYJLfKoTjQeZbhtstHvhl5VlqFPtN6tJKrJe0Oxls3IDzNFn8WOYoVYxf7SYswWCOZ8iHAJWh3fBikw+3ERjlrWCSoiGPlw5rqmChVqL7p/ORfwVNltk2rfrC0NboAey4RCfpWF325393PdIKhN4/RFCzwT8rBQI1o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:3b199800-dd17-4d7a-844a-93b56743aee1,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:c3d5b286-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: abcaa39e053311efb92737409a0e9459-20240428
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <lena.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1634770474; Sun, 28 Apr 2024 15:48:15 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 28 Apr 2024 15:48:13 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 28 Apr 2024 15:48:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRckSog5DwRfk9bBfb62yMP3tgz/NMY71KXmqTYFIahw6MJzlx8URHsY390uODZvBxyXvwyB9YJo3oaoXumWz6Lv1R+ZY6TmCcFSg1lvUi6cV2y2kA+l6FcBXEUgdGh6hXmUyy0lmem/lI6T5CT1922HxS0RJeQ7qAnw43AAnK2nYuWoIU0wnnpElq55lgxK0gdhaEBGS+4KK+GfVNhljOshpDzETN0lLoGDiSJRbEEr8fA7Kjhy3dzVVa2kCxy1S6w/dv3b20Gm4Tzep18k3HU8zO1u1iEZ8m1UkToYAkV2USSnv7HX7oR3YvQ00PE7a/3E/O+WqkClQ9pCpgpzPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDQvaZG3HsYvazlvMgbLYs+SjmYwyOPArJWTMj4tz9Y=;
 b=PyU7kvcuOWA+IRNxT5N1K8uwhXCxsxdsajA8VEECm+QuwbaM34aOq0so7ADkzKxHf2bNBT1+w2nUR/4s44B+90mrtmQ082nNFtBteyXadQxZZ48wfwPEUM3yNhmn3Rwt7da2OdQ8yB3O8TsDSnXUUvb9PBK70U4mepWfCX3/5mT0IZ+uAPMsOpcKJgLXnz0O+2kU+yMcGCSCVISuc5XTdMOeKDOuZcB7d0anJ4fxiG5SUqvIM7tuhRQg68yd8p9idAXSQvMKxb6eOx72gSPfXd2wlpOOO3WumS6PwF+mjhA9wHL3ZXB4Q8hFuj/g6OB2UUWVn2B7nkeDY9RF7AX2bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDQvaZG3HsYvazlvMgbLYs+SjmYwyOPArJWTMj4tz9Y=;
 b=fyWJ4IRCY5aPMGhQGJ69uFTLR0OmJ1JgYZ34qFqL9q/gvMsKt+O3nr4j8l12x4I8iWs/3dE5QFmEgDzahfTG9L7WR5Zhg2iMO7/CE6fuuLzS5tu5CEkEchVVSih7Aj2UwgxyF5rd6ZPtDjnn6NLdLZloaJt3XSVz/AzSDr3i8X8=
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com (2603:1096:101:4a::8)
 by SEZPR03MB8486.apcprd03.prod.outlook.com (2603:1096:101:220::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.19; Sun, 28 Apr
 2024 07:48:10 +0000
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::3b7d:ad2c:b2cf:def7]) by SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::3b7d:ad2c:b2cf:def7%6]) with mapi id 15.20.7544.018; Sun, 28 Apr 2024
 07:48:10 +0000
From: =?utf-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
To: "daniel@iogearbox.net" <daniel@iogearbox.net>, "maze@google.com"
	<maze@google.com>, "willemdebruijn.kernel@gmail.com"
	<willemdebruijn.kernel@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "steffen.klassert@secunet.com"
	<steffen.klassert@secunet.com>, "kuba@kernel.org" <kuba@kernel.org>,
	=?utf-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?=
	<Shiming.Cheng@mediatek.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "yan@cloudflare.com"
	<yan@cloudflare.com>
Subject: Re: [PATCH net] udp: fix segmentation crash for GRO packet without
 fraglist
Thread-Topic: [PATCH net] udp: fix segmentation crash for GRO packet without
 fraglist
Thread-Index: AQHaj0XOIxnbbRpuOEqwUbC2K0Us3rFpz0sAgABZ6oCAAArbAIAA8PYAgAAJ3wCAAAGxgIAAWJUAgACHpICAANEgAIAAdp6AgAAXCgCAAdtPAIAAXxYAgAA10YCAAANdgIAGGNsAgAA/VACAASp9AIAAIwMAgADr+gCAAKCBAIABSysAgAC8pYCAARHSgIABM2mA
Date: Sun, 28 Apr 2024 07:48:10 +0000
Message-ID: <afa6e302244a87c2a834fcc31d48b377e19a34a2.camel@mediatek.com>
References: <20240415150103.23316-1-shiming.cheng@mediatek.com>
	 <77068ef60212e71b270281b2ccd86c8c28ee6be3.camel@mediatek.com>
	 <662027965bdb1_c8647294b3@willemb.c.googlers.com.notmuch>
	 <11395231f8be21718f89981ffe3703da3f829742.camel@mediatek.com>
	 <CANP3RGdh24xyH2V7Sa2fs9Ca=tiZNBdKu1qQ8LFHS3sY41CxmA@mail.gmail.com>
	 <b24bc70ae2c50dc50089c45afbed34904f3ee189.camel@mediatek.com>
	 <66227ce6c1898_116a9b294be@willemb.c.googlers.com.notmuch>
	 <CANP3RGfxeKDUmGwSsZrAs88Fmzk50XxN+-MtaJZTp641aOhotA@mail.gmail.com>
	 <6622acdd22168_122c5b2945@willemb.c.googlers.com.notmuch>
	 <9f097bcafc5bacead23c769df4c3f63a80dcbad5.camel@mediatek.com>
	 <6627ff5432c3a_1759e929467@willemb.c.googlers.com.notmuch>
	 <274c7e9837e5bbe468d19aba7718cc1cf0f9a6eb.camel@mediatek.com>
	 <66291716bcaed_1a760729446@willemb.c.googlers.com.notmuch>
	 <c28a5c635f38a47f1be266c4328e5fbba44ff084.camel@mediatek.com>
	 <662a63aeee385_1de39b294fd@willemb.c.googlers.com.notmuch>
	 <752468b66d2f5766ea16381a0c5d7b82ab77c5c4.camel@mediatek.com>
	 <ae0ba22a-049a-49c1-d791-d0e953625904@iogearbox.net>
	 <662cfd6db06df_28b9852949a@willemb.c.googlers.com.notmuch>
In-Reply-To: <662cfd6db06df_28b9852949a@willemb.c.googlers.com.notmuch>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6466:EE_|SEZPR03MB8486:EE_
x-ms-office365-filtering-correlation-id: e197b371-38ae-441f-0c23-08dc67578cdc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?TDRZT0M0QklkSXk4eG9Ca0N4S0pNcVVGRlZLbXZQUklQSEhab2tQd3c4WTFt?=
 =?utf-8?B?MDB2bkVZTUhpd2pWK1c2bjdyeXAyWnRQK0llRXpmTFhCNmhVWU8xTkhtemlP?=
 =?utf-8?B?Tm5YdGUraUI2Q24xaktLREt4ZWc4Y25jdnV5QTlwZVl4OUMwYk43WUdvL0JH?=
 =?utf-8?B?YytGeXhOejA2dnd4ZXAvb0FmVllqSkNla0x5NWJXbmpMN1hNQ21zNUgzV2xF?=
 =?utf-8?B?eUtHM3pnbFE0Q25zMEEvbmEwSXJjN0RkWFI2eS9NU3puaXgxd0Q1TXFOSWEv?=
 =?utf-8?B?S1lWZTgvUDdxdHpUeGJ1ZmJiRlcyWi8wNnovSEhEczRkT2JoVzN6Zk5IL1M2?=
 =?utf-8?B?eSs0Q0wycHVPR0E1eHZpQVovQ1k4dWV4QUdHR05DU2dKUDBtTFVkcGVIRU0v?=
 =?utf-8?B?Y2pPQjlCdWFMSmxKUlhTdUVqYUVuVG41VmQ4RWFqWHR1SUxTNFZZQ2hwQnlP?=
 =?utf-8?B?N0g4N1h3a2VyOWZBRGxpSmtlNHhnTGpqdFFhYngzMnBsbnBDLzEySmVhOTJu?=
 =?utf-8?B?ajgvdzIvcXN3RDFMMjZ0anNxWEhqeHdRQmtNa2hZSDF3MkliNUVSekhua3lZ?=
 =?utf-8?B?ZGJWd3kzaGgzc1BOZ3JrTjNXNDdYczhobnllWGRMZDhiSmlVSlUyR3hHMng1?=
 =?utf-8?B?dUZ4RDFkVm0zeXgvUS9ndFF2N201TVVmUitlbXlLNjI5ZnBEQTVEM2VFVlEy?=
 =?utf-8?B?bys4N2FPRmhKUHlWcWEwZENUbFFVWGY4c0t1RjhlQXBITFNnME9HQUZJWWx3?=
 =?utf-8?B?cHppcVpaZVU2MFQ3YTBGemxsSHBMa1d5N0laUDRSdExpRE8xTVcrU2tqdmlu?=
 =?utf-8?B?Um4vWXhTQVp2YXhRZUMxdG5nRmJ2aVdPclVyUS9zdXdiTmVPOFlTclpDQTdo?=
 =?utf-8?B?NTFZa0swUE5PbCtmOExjTW1ONHVaV1d4UERxc1h1R2ZMS1lpQTFQbzM0WUJu?=
 =?utf-8?B?cXVrUnl6Wk9KNHdMcUJ2QnY0NUlibEc0WUxYT3lmSDlRZFFpVkwyM0J3Zm8x?=
 =?utf-8?B?R21hcEhRRC9UVW84cE9GMzNCaWpKNloxbHJBQlZiU3kyeG1ta3dOR0paM3dW?=
 =?utf-8?B?V25TSGFjVTMxVGIyamU2dXdydFBjV1cyQWZaOHJFbHNhbHg0WWlmMGsyU014?=
 =?utf-8?B?bXJMMWtpZ2dVajdUUEQxaDM1TTNrVDNuUUhwMkF2dXZnSVMybFFVb0VlTFNs?=
 =?utf-8?B?VzJXVFBBMlFwU09abzNsUnFRKzNXdVMzNmNTRmxEdFJzd2VuaWp3TVZqOWFW?=
 =?utf-8?B?Mzc4OUZ2amRUbW82NGNrN20zakdWYzM2amxBMVhKSUZsa0FMTXVrN3RMczNy?=
 =?utf-8?B?ZEtVQ1lCQUtkWmM3cVpsYVR1anFDTlp4SGl0SkpYMTVmV2hHYXk1Y1ZHdzRI?=
 =?utf-8?B?V3ZtS1NKRmNZSXRFUjFpYzVYVVdSYzVRZkF4eVVkQzhFaHhUZEV3NzBXb1NT?=
 =?utf-8?B?aXQzdktpU1ViU0EranVBQTM0aFJFbVZCNFB5OTc2WmdFVEV4OTZ6NDRjd3p3?=
 =?utf-8?B?cmRNbHpEeG1BUWtNWXpSckI0THZRYm1DcXZxaXlKZlN6QWdvRU84cG9VYWJo?=
 =?utf-8?B?NjhzclpNZGtBRkxuamFDRUgwclFER2lmSVNwMXROU20yVk9CNXl4cm0rMEIv?=
 =?utf-8?B?Skx4MElVL3VQWDMwMUdwLzFJemFVYkNBZlZlcno2em82amxrVlVWMndyemFR?=
 =?utf-8?B?c0o2emlmcjJWaU02aGZWUlpObEZnU1UzWFkzbUlNVUJLb2IrRnhuSlpqdUJJ?=
 =?utf-8?B?R3h3VytneVVPQmdtNU9FYkhuK1F1RUxnY2NUcHd5QXFzK09LaXZ4YVc0WUto?=
 =?utf-8?B?T0ZiZW9LS2tOWFJWQk9hUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6466.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0xXLzRWdElvbmVicENzNWs0TmxzVG9HWGNnaUlCb2RTRCtZU2ZzZHA5Sk80?=
 =?utf-8?B?clRtcjE2R0NRRnpoempUT0ZQeERJVmpLOGd3UG5zaFkzNmhaRU0zTGpRcFBR?=
 =?utf-8?B?ME9oWjYwcGg1STlCS1MzSXdTWTVrNUhhSXBqNXRkWEh5YWpuZkR4ZzhTZG1H?=
 =?utf-8?B?K05TSXI4cnExWVBEMi9UN3JFbkNHRGo5OUtMZE5OR1QrdjNzZ0pFaVNqOXRY?=
 =?utf-8?B?V3JYOHZDeUhuaTRrejBERFFDT2lLUXd6cmZoa3NVbzhvbFlld2F6V0ZkRVh5?=
 =?utf-8?B?SVE2ZS94Ym1UUFBpRHc4bzFNUU1Vam00aUNtbkVIVWx2dVQ2Z1BJSlpxNWdE?=
 =?utf-8?B?ZzJQMjNYQ2t1MmdKQ1cwMENqVHZjSG9wejdmc2RWOTZhL1RCbFd6WGtBanJ6?=
 =?utf-8?B?NUZVUlMrTGNpTXpaNUE2dHpMd0NNSUtBZDRtQVZ4eWtRM3FwbzdUYzd1QUF2?=
 =?utf-8?B?UzVWZFJZYSs1VmJYUnVsQkJtT3ExRE5wRGxuSGIzMW56RytCRTdYS29oeXJv?=
 =?utf-8?B?M1l1Y3pqZjU5U1VJeDVISUg1dFRUYVF3Tjg0ZEM2NVVqMjJ1TFduVEF6YzhD?=
 =?utf-8?B?K1pLdXZKdC8wVGw0Vzh5aytCT0hpdjBOc016U2VQYUw3VnMwRFdyL2tSVWlB?=
 =?utf-8?B?QW5jNkVQN1RTMGJMSDNhTm9UdHhiN1kzMUwzcmI2VGNjc3gvcTBDRm1saGVN?=
 =?utf-8?B?ZzgxaDFzYnpzbkRaQTZLUFppZUZNRmZhenRlM3VnUDZaaW9aZktwcDJNUHhj?=
 =?utf-8?B?WjJyVnlFd2gwRHduemlpcC83d0d2NG02VUV1Y3dVYnAzYmFjQ0w1R08yY2lH?=
 =?utf-8?B?aU8zZnFCK2Z2M2xCczJwc1JvbnlxMU1BcHpUaDZPU211SzQ3OXQycEhXbFNl?=
 =?utf-8?B?eGV3YXNTbkJRK3g5ZXFveW1hQlNWWFlIbG5mZG5KMmtvd3JwclhHMTJQSk13?=
 =?utf-8?B?QitIUEFVemJvSXJ3c01oVHZXUHBRY0lHU2YwY3Y3QTFiUXFxUWR3RWYrWVVC?=
 =?utf-8?B?RWR6ZjVhcTFvV0VCY3FoZ09tL3hBQkJGcW5FMDVDK3JIOGdiZDRhTHdZZ3Fp?=
 =?utf-8?B?bzAxQ2MvaXBaWDNQTkErOU94dVNjeXp1SitaU0F1VUdyTE52bU5XelA4dmRk?=
 =?utf-8?B?OVpTNkprTWIrSnpQZ1lTUmM2RlA2MUlsUzY3RWtjTFVWdC96OXJFS2N6bHY5?=
 =?utf-8?B?M3RxQ09JQjFWekNNeHRVZVhIcFlzck1VWjdTaGowTXRrVWRjU0tCZkV3MXh5?=
 =?utf-8?B?Q05JWkp0RXRxYUdRYXhBdkR4TlRsRXN0SHpnc2R0NGVNbjlnUXlkZUx4NlFB?=
 =?utf-8?B?aGpZQXlzTDRVUXRiaGV6TE5aL2FndHpTR3FJMmRJQVhMK1ZyV2VOS2lLWTlq?=
 =?utf-8?B?bHlybGhPUUtPSXJpS0xUOUZHcHlrYjg5R1V3UmFJVzBPNGhBWFpMUGV4VWQr?=
 =?utf-8?B?UFFoS3ZlMm5GdmtVWHVTMmFVeVJ2cys4bjJ1SlJQK25pWE9aaWxhMko4dTR1?=
 =?utf-8?B?cXVpaGk2TjcrQVVSaTFySHY2Z3BSUkhDckZQaW9kdzlwUDRFc0JMVjJrUlNR?=
 =?utf-8?B?Y0dzSHRuZHdiNGNlVWJlRXcvd0JkcHJSTjhoMHlkVld3YU9lRDdHQlgxM0sv?=
 =?utf-8?B?RGdrUWJIdmhhMmdQeXJmWldWdTVsbS9JQ2ZqVitsMlBnNTMrdGNZQ3ZFNTI4?=
 =?utf-8?B?a0xlMnp2NlBHS3lCSWRSaXo5M2sxaFE3aURpS29mbk1pMXlJQ09OblVoY3RE?=
 =?utf-8?B?SHpGN2FnM0dtUUxPdWJKaDBRNTAraGYzYXRKa3R0ZDB6WWEvMkl3L0svak9V?=
 =?utf-8?B?NUY1NGtUSStxa0RyMUJCOHlleUZCYzUzRm9mUGt6UEI4dEhHTkJUenpoeGVT?=
 =?utf-8?B?WmNRUUljcEZvQ2FCaUh0SzJmZlNmOWV2Rk1nVDc0TUZ4Qi8wTTlJd0hIQmEw?=
 =?utf-8?B?VnVPQXZDdGcrc3ZwN3ZzQVNhd1ZOazNGQ042MnhFVUN6V01rMm1ISkFldE1Y?=
 =?utf-8?B?VkFnaWN3V0VuN0JsOUl0NDB6WjJNMXB6TjJGSHAyKzduLzhwV0ZzMTNBNEVF?=
 =?utf-8?B?NE83Z1FRWDM1RDVYbE9RQzJHRzZpbG9aTEgrejJIRHRwZDhmMGVvb3F3c0xF?=
 =?utf-8?B?bFEzeHNhaHNTd1FGZjc0SUIrcmJFYm1RY1UzWG1UMTR2QXdZRmdOZG5KRXll?=
 =?utf-8?B?NXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <571ED8B049A9B14494E2072D5F57F76D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6466.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e197b371-38ae-441f-0c23-08dc67578cdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2024 07:48:10.2630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KdIg/h6gorKosEf0O5YvokFyNEXzxkdLFYXSiaNjdyiRoFeBEf1h2aToYEf11iTq+7IKTXRbpLmvR99F1PD3pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8486
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--18.101300-8.000000
X-TMASE-MatchedRID: L8tZF6zWW2oOwH4pD14DsPHkpkyUphL9meN8m2FdGic3xO2R3boBWFbu
	qIY+/skQkABPgKBt/0rbaVyalxbpdAxAtdzYwZJsA9lly13c/gEZmNqpqQL8xrV5fSMRD1zq/Vf
	PwSZZsgguXHgAr73H7UIozxQvujgLrYhfqfvQWOmvnWBILruGleNlVbqPGsKiBfoAvdqdJ5f+GQ
	FLLcthDaNgoT8G4NpHYDkHcBjdShSLwgJA7qJvFIQ6iEG+7EHnkos2tunL8DSYN5o4ZKM2rqPFj
	JEFr+olFUew0Fl/1pE9wJeM2pSaRbxAi7jPoeEQftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.101300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	3E2F06C62AE49CFB413E50019AEBFE43BFA32732F5D59293CA34927FB1FA00882000:8

T24gU2F0LCAyMDI0LTA0LTI3IGF0IDA5OjI4IC0wNDAwLCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3Rl
Og0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gIA0KPiBEYW5pZWwgQm9ya21hbm4gd3JvdGU6DQo+ID4gT24gNC8y
Ni8yNCAxMTo1MiBBTSwgTGVuYSBXYW5nICjnjovlqJwpIHdyb3RlOg0KPiA+IFsuLi5dDQo+ID4g
Pj4+ICBGcm9tIDMwMWRhNWM5ZDY1NjUyYmFjNjA5MWQ0Y2Q2NGI3NTFiMzMzOGY4YmIgTW9uIFNl
cCAxNw0KPiAwMDowMDowMA0KPiA+ID4+IDIwMDENCj4gPiA+Pj4gRnJvbTogU2hpbWluZyBDaGVu
ZyA8c2hpbWluZy5jaGVuZ0BtZWRpYXRlay5jb20+DQo+ID4gPj4+IERhdGU6IFdlZCwgMjQgQXBy
IDIwMjQgMTM6NDI6MzUgKzA4MDANCj4gPiA+Pj4gU3ViamVjdDogW1BBVENIIG5ldF0gbmV0OiBw
cmV2ZW50IEJQRiBwdWxsaW5nIFNLQl9HU09fRlJBR0xJU1QNCj4gc2tiDQo+ID4gPj4+DQo+ID4g
Pj4+IEEgU0tCX0dTT19GUkFHTElTVCBza2IgY2FuJ3QgYmUgcHVsbGVkIGRhdGENCj4gPiA+Pj4g
ZnJvbSBpdHMgZnJhZ2xpc3QgYXMgaXQgbWF5IHJlc3VsdCBhbiBpbnZhbGlkDQo+ID4gPj4+IHNl
Z21lbnRhdGlvbiBvciBrZXJuZWwgZXhjZXB0aW9uLg0KPiA+ID4+Pg0KPiA+ID4+PiBGb3Igc3Vj
aCBzdHJ1Y3R1cmVkIHNrYiB3ZSBsaW1pdCB0aGUgQlBGIHB1bGxpbmcNCj4gPiA+Pj4gZGF0YSBs
ZW5ndGggc21hbGxlciB0aGFuIHNrYl9oZWFkbGVuKCkgYW5kIHJldHVybg0KPiA+ID4+PiBlcnJv
ciBpZiBleGNlZWRpbmcuDQo+ID4gPj4+DQo+ID4gPj4+IEZpeGVzOiAzYTEyOTZhMzhkMGMgKCJu
ZXQ6IFN1cHBvcnQgR1JPL0dTTyBmcmFnbGlzdCBjaGFpbmluZy4iKQ0KPiA+ID4+PiBTaWduZWQt
b2ZmLWJ5OiBTaGltaW5nIENoZW5nIDxzaGltaW5nLmNoZW5nQG1lZGlhdGVrLmNvbT4NCj4gPiA+
Pj4gU2lnbmVkLW9mZi1ieTogTGVuYSBXYW5nIDxsZW5hLndhbmdAbWVkaWF0ZWsuY29tPg0KPiA+
ID4+PiAtLS0NCj4gPiA+Pj4gICBuZXQvY29yZS9maWx0ZXIuYyB8IDUgKysrKysNCj4gPiA+Pj4g
ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+ID4gPj4+DQo+ID4gPj4+IGRpZmYg
LS1naXQgYS9uZXQvY29yZS9maWx0ZXIuYyBiL25ldC9jb3JlL2ZpbHRlci5jDQo+ID4gPj4+IGlu
ZGV4IDhhZGY5NTc2NWNkZC4uOGVkNGQ1ZDg3MTY3IDEwMDY0NA0KPiA+ID4+PiAtLS0gYS9uZXQv
Y29yZS9maWx0ZXIuYw0KPiA+ID4+PiArKysgYi9uZXQvY29yZS9maWx0ZXIuYw0KPiA+ID4+PiBA
QCAtMTY2Miw2ICsxNjYyLDExIEBAIHN0YXRpYyBERUZJTkVfUEVSX0NQVShzdHJ1Y3QNCj4gYnBm
X3NjcmF0Y2hwYWQsDQo+ID4gPj4+IGJwZl9zcCk7DQo+ID4gPj4+ICAgc3RhdGljIGlubGluZSBp
bnQgX19icGZfdHJ5X21ha2Vfd3JpdGFibGUoc3RydWN0IHNrX2J1ZmYNCj4gKnNrYiwNCj4gPiA+
Pj4gICAgIHVuc2lnbmVkIGludCB3cml0ZV9sZW4pDQo+ID4gPj4+ICAgew0KPiA+ID4+PiAraWYg
KHNrYl9pc19nc28oc2tiKSAmJg0KPiA+ID4+PiArICAgIChza2Jfc2hpbmZvKHNrYiktPmdzb190
eXBlICYgU0tCX0dTT19GUkFHTElTVCkgJiYNCj4gPiA+Pj4gKyAgICAgd3JpdGVfbGVuID4gc2ti
X2hlYWRsZW4oc2tiKSkgew0KPiA+ID4+PiArcmV0dXJuIC1FTk9NRU07DQo+ID4gPj4+ICt9DQo+
ID4gPj4+ICAgcmV0dXJuIHNrYl9lbnN1cmVfd3JpdGFibGUoc2tiLCB3cml0ZV9sZW4pOw0KPiA+
IA0KPiA+IER1bWIgcXVlc3Rpb24sIGJ1dCBzaG91bGQgdGhpcyBndWFyZCBiZSBtb3JlIGdlbmVy
aWNhbGx5IHBhcnQgb2YNCj4gc2tiX2Vuc3VyZV93cml0YWJsZSgpDQo+ID4gaW50ZXJuYWxzLCBw
cmVzdW1hYmx5IHRoYXQgd291bGQgYmUgaW5zaWRlIHBza2JfbWF5X3B1bGxfcmVhc29uKCksDQo+
IG9yIG9ubHkgaWYgd2UgZXZlcg0KPiA+IHNlZSBtb3JlIGNvZGUgaW5zdGFuY2VzIHNpbWlsYXIg
dG8gdGhpcz8NCj4gDQo+IEdvb2QgcG9pbnQuIE1vc3QgY2FsbGVycyBvZiBza2JfZW5zdXJlX3dy
aXRhYmxlIGNvcnJlY3RseSBwdWxsIG9ubHkNCj4gaGVhZGVycywgc28gd291bGRuJ3QgY2F1c2Ug
dGhpcyBwcm9ibGVtLiBCdXQgaXQgYWxzbyBhZGRzIGNvdmVyYWdlIHRvDQo+IHRoaW5ncyBsaWtl
IHRjIHBlZGl0Lg0KDQpVcGRhdGVkOg0KDQpGcm9tIDNiZTMwYjhjZjZlNjI5ZjI2MTVlZjRlYWZl
M2IyYTFjMGQ2OGM1MzAgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxDQpGcm9tOiBTaGltaW5nIENo
ZW5nIDxzaGltaW5nLmNoZW5nQG1lZGlhdGVrLmNvbT4NCkRhdGU6IFN1biwgMjggQXByIDIwMjQg
MTU6MDM6MTIgKzA4MDANClN1YmplY3Q6IFtQQVRDSCBuZXRdIG5ldDogcHJldmVudCBwdWxsaW5n
IFNLQl9HU09fRlJBR0xJU1Qgc2tiDQoNCkJQRiBvciBUQyBjYWxsZXJzIG1heSBwdWxsIGluIGEg
bGVuZ3RoIGxvbmdlciB0aGFuIHNrYl9oZWFkbGVuKCkNCmZvciBhIFNLQl9HU09fRlJBR0xJU1Qg
c2tiLiBUaGUgZGF0YSBpbiBmcmFnbGlzdCB3aWxsIGJlIHB1bGxlZA0KaW50byB0aGUgbGluZWFy
IHNwYWNlLiBIb3dldmVyIGl0IGRlc3Ryb3lzIHRoZSBza2IncyBzdHJ1Y3R1cmUNCmFuZCBtYXkg
cmVzdWx0IGluIGFuIGludmFsaWQgc2VnbWVudGF0aW9uIG9yIGtlcm5lbCBleGNlcHRpb24uDQoN
ClNvIHdlIHNob3VsZCBhZGQgcHJvdGVjdGlvbiB0byBzdG9wIHRoZSBvcGVyYXRpb24gYW5kIHJl
dHVybg0KZXJyb3IgdG8gcmVtaW5kIGNhbGxlcnMuDQoNCkZpeGVzOiAzYTEyOTZhMzhkMGMgKCJu
ZXQ6IFN1cHBvcnQgR1JPL0dTTyBmcmFnbGlzdCBjaGFpbmluZy4iKQ0KU2lnbmVkLW9mZi1ieTog
U2hpbWluZyBDaGVuZyA8c2hpbWluZy5jaGVuZ0BtZWRpYXRlay5jb20+DQpTaWduZWQtb2ZmLWJ5
OiBMZW5hIFdhbmcgPGxlbmEud2FuZ0BtZWRpYXRlay5jb20+DQotLS0NCiBpbmNsdWRlL2xpbnV4
L3NrYnVmZi5oIHwgNiArKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQoN
CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NrYnVmZi5oIGIvaW5jbHVkZS9saW51eC9za2J1
ZmYuaA0KaW5kZXggOWQyNGFlYzA2NGU4Li4zZWVmNjViM2RiMjQgMTAwNjQ0DQotLS0gYS9pbmNs
dWRlL2xpbnV4L3NrYnVmZi5oDQorKysgYi9pbmNsdWRlL2xpbnV4L3NrYnVmZi5oDQpAQCAtMjc0
MCw2ICsyNzQwLDEyIEBAIHBza2JfbWF5X3B1bGxfcmVhc29uKHN0cnVjdCBza19idWZmICpza2Is
DQp1bnNpZ25lZCBpbnQgbGVuKQ0KIAlpZiAodW5saWtlbHkobGVuID4gc2tiLT5sZW4pKQ0KIAkJ
cmV0dXJuIFNLQl9EUk9QX1JFQVNPTl9QS1RfVE9PX1NNQUxMOw0KIA0KKwlpZiAoc2tiX2lzX2dz
byhza2IpICYmDQorCSAgICAoc2tiX3NoaW5mbyhza2IpLT5nc29fdHlwZSAmIFNLQl9HU09fRlJB
R0xJU1QpICYmDQorCSAgICAgd3JpdGVfbGVuID4gc2tiX2hlYWRsZW4oc2tiKSkgew0KKwkJcmV0
dXJuIFNLQl9EUk9QX1JFQVNPTl9OT01FTTsNCisJfQ0KKw0KIAlpZiAodW5saWtlbHkoIV9fcHNr
Yl9wdWxsX3RhaWwoc2tiLCBsZW4gLSBza2JfaGVhZGxlbihza2IpKSkpDQogCQlyZXR1cm4gU0tC
X0RST1BfUkVBU09OX05PTUVNOw0KIA0KLS0gDQoyLjE4LjANCg==

