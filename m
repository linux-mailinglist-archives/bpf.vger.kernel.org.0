Return-Path: <bpf+bounces-40181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5296597E4BA
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 04:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B988EB20D79
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 02:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CA44A1E;
	Mon, 23 Sep 2024 02:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mxmoTNNV"
X-Original-To: bpf@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011034.outbound.protection.outlook.com [52.101.70.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61FA4C6E;
	Mon, 23 Sep 2024 02:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727056808; cv=fail; b=S+k1aGLfj2eljT/md6f+0jAMsKTgoPInmBUMx6UUiiBD3XYuIdee0Wge7cLHiXcEI9ojtxb8/5mIQAkxyv0EpPyV3l/NATfNBAIe1R3TONdYMUS9O0tQssjIsEWfpX+bsr1HHYHAgBuTOEuWiaoqqZ+MFUy80+ABmxoBv7lSR60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727056808; c=relaxed/simple;
	bh=4yNsEtF4WmHdKxXBO0CMSSDJT9u+KOuvGuZg65iyB8Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L50SeyiCaEajcGRHs/qVNHjFlAeMLkbPemBYZGOlxRTEbayo43wV7f3qOXiER646DN4w7tWjRN3uXUskiGhKwRSsh0F8Hto6OktS8XkZJJMiYtd8GimTNToKFTOXwfbDlXZl91Lld/oS1wkvYpogrbRhbXZTGoNAI0tbjkywjio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mxmoTNNV; arc=fail smtp.client-ip=52.101.70.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oc2s78iiQvUkbjb4rtj7sd5m8WVQ0XImyo/IeoKiuhhioJs9sB42U8IwoxW+y+mClewBgKx1NuFNRQr8p4rjdw6RRAlsiUZ0oaw1acBuWHykIgd6yFZ+UhxlGVKdISsqTpMBgJCcAGcLln1+PptxiQExcPUwiONTFtr7PNiR3fO6t8xn1eV0GvqREnxjeOhfOiWJKPtwujkEG0dlEqSz7HgKbtBPbwAski8WG8kLHfmO8SvzHAbtmUCigLL0DmKBeUKIcMQ5n8N/tJcC+WAZCKxoKEbegDT5k3sIoGkzhmqBPV9T3SYRhMGe6hxXoVc08g2yd6VN4Q00pzvRR8+eDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yNsEtF4WmHdKxXBO0CMSSDJT9u+KOuvGuZg65iyB8Q=;
 b=a2b5hqnxil0J5/RRthbdXdylQ554/Kgkvjj4SMuvZVmiQhbMixbmIFlNObLu8u/a+OBFIrWDt4+HnZCGLi6wEsabHcVJ8JTG3vtnjqqD9miP6oegU6AYGFxf7IHA2HRm+GFlt2HWbBZOxoIDNiokjdGeMHQ80IbAwXhTshCJL1CA6p3ZyKpzUGPHIjJd4FWt3XjLPbuflE7YLB5M3udr+1N8giH3iGbAZfzzXU2axb2csd0BrwcpAq5zZJSceU0B72jTKiWNmZjklesfbJbgWtRvlkzVqbW0mRAicTqgfWAyIr9IV3IZ8V71pKJBFc/3tpO/bsCP6F435b9YPfhEXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yNsEtF4WmHdKxXBO0CMSSDJT9u+KOuvGuZg65iyB8Q=;
 b=mxmoTNNVBgnh4tsqbhsA9jL9c0qDCgOe9ifI0xBYmKm6K8cu1qJ++EWhoukHuexhUrsY7Ti/sLT06GCouUeHoiZJ6a19bTOtMxbvdp5WYkVYW2HdvFCpwHG8A+JduzuHD5/LH1mr6lslfbgr0iNmO83pp4uKxykzcAvnxbAONZTq6CqRYqFVykYSmWamR1u9XAx9ZCUTpUn/4Mn6Tki9pKDZ0FGUc2nL364JCBO/8tJN78gvqkisIGzDasIA3RW1fXvbN67cIaTuyh/moJymaWHH51dRzi5YzRXulMtmLbDuvqnRtQfzDs86w6CjG+paeJIYR3On9bx+n2Wchz4fCw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10525.eurprd04.prod.outlook.com (2603:10a6:102:444::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 01:59:56 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7918.024; Mon, 23 Sep 2024
 01:59:56 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "hawk@kernel.org"
	<hawk@kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net 3/3] net: enetc: reset xdp_tx_in_flight when updating
 bpf program
Thread-Topic: [PATCH net 3/3] net: enetc: reset xdp_tx_in_flight when updating
 bpf program
Thread-Index: AQHbCnHT295KDDvRD0aXaVmRMCCprrJgpnMAgAANdRCAAAkBgIAD4MDA
Date: Mon, 23 Sep 2024 01:59:56 +0000
Message-ID:
 <PAXPR04MB85105CC61372D1F2FC48C89A886F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240919084104.661180-1-wei.fang@nxp.com>
 <20240919084104.661180-4-wei.fang@nxp.com> <Zu1y8DNQWdYI38VA@boxer>
 <PAXPR04MB85101DE84124D424264BB4FD886C2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20240920142511.aph5wpmiczcsxfgr@skbuf>
In-Reply-To: <20240920142511.aph5wpmiczcsxfgr@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA1PR04MB10525:EE_
x-ms-office365-filtering-correlation-id: 302dc35a-4ae0-4b46-bcef-08dcdb736c84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?S1BaUUg5aTZEalRTSDRoalpSbE1VVXNmTUxBekRGV2d6VmpSRlQ3NlVpaHZ0?=
 =?gb2312?B?TnNvMTZRbFlHM3RrdmxsZW9MN0JnVzZveDZiWGdCNFFYVmFheVdVYnBSTzg0?=
 =?gb2312?B?NHQwak1FbThWWjQrMUJOUURIcmVYS0UvRWUrTE5ZcmtkNVMxUCs4eGVxcWhI?=
 =?gb2312?B?Q25xZVQzYnA1M0tZdWVMVnhYdjJielFncmZmRUhxektlYVJCS1N3VkRNOHpi?=
 =?gb2312?B?SjErQUh5aW44bmVIVmtNZGZwa25TSkxMZU9IQzBOdlAzUWNNeTB5dlBkRE1x?=
 =?gb2312?B?NzlRaitQb1lETktuK1Q4UzJOclFOL0o1Z1Z2MkpyN3FzMkh1TWl3WWppYnpt?=
 =?gb2312?B?NS93V0JNTVRsM05JUnNBNGtnMXYvaVZWS3JvWXBRTExuRVcvM0VCNnk1VmNi?=
 =?gb2312?B?bFVYZEJla28xSkdtRzRKd2FqdmlVVGp6VDZ2VG16ZDR6WlNBVGRydnNJWDR6?=
 =?gb2312?B?NnQwRUZTa1NHYXNCNklQSy9NZW5PS2ZJVUphWmJkSi9pYlNSMnVMbjlVbm1z?=
 =?gb2312?B?bHJRV1hpQVZwa1lUdndjbnVadGpPT1E1L090Y0FFTXcvWW1JZlA1cjRValFN?=
 =?gb2312?B?aDN1SkUvWGZIUmxSVVhlRWUrY2d6MXR3NGdlbXlkSDhCWTZTOHV3N2pYWTBs?=
 =?gb2312?B?V2RGN1dQM2xwbDh3aTFubnNwVDE0Ly83N2RhbDlLZGdDUWdBemlZbzRQck1v?=
 =?gb2312?B?Yk5xVlpPa0lDMTBra09nRllBa3NuRDBjZTZrKzZOSDhMYnFxNjNqUSttRGo1?=
 =?gb2312?B?aFRLM3VhU0pKcG9iME5jWEhZNklmRE9mdXkvdmJrejJ1czl1SGRodjVqK2Vm?=
 =?gb2312?B?aWVMR01GOHlpdkJPc3l3SjMrd2hleWorUmthQ2hIUWdqRHRndVdGVVk3K0lL?=
 =?gb2312?B?cnBGbXovY2Z0b255U2ZRcS9NU0o1a3ZIbk4vajVxUHg1VEs0RVhMT2pPQVNG?=
 =?gb2312?B?NThqUkkwbGVxTGtGRHhrNllveTJCb2plM1NaMVdtUUw0T2t1NFA1QWJURWxM?=
 =?gb2312?B?RC9qdFBlUjREQkZnRitLbitTL3Rtdjg5ZlR6NWlqcWhIM05VN0l0SVVjOXgw?=
 =?gb2312?B?alpnRDEycnZ6M2s5YStEcVFFaVM0QVFTQjl1RW51OWdxNnp0RHBRSmE5cWFj?=
 =?gb2312?B?eWpRWDNYSFFwVW9qMllPMVloZndmNi9VQUVPVzFzNEQ2TTNiV25hVTFlUmVS?=
 =?gb2312?B?a2s0TmhrblRwcFo0YWNGQzlhNG9IV0Z5cTZFbXVKenhvQmZlSHAxaG5ua0x1?=
 =?gb2312?B?a2hHRHZFUDB0UW5COVB3QXluMkdhRmtxNjFyNldvdGFoL3NldnJQU3psa2Z5?=
 =?gb2312?B?NWlrWjV5bTBnU2pKTkpOKytpOXQxVUk3bGhOTzVpbDlaVDZIRjV4YVVYYkda?=
 =?gb2312?B?V0FYRWZTQ0RaSHhneDlaZVhYSEJVT0VXL2NIVGpueklQREpkb2p0dnh4cFZz?=
 =?gb2312?B?UnVya3RGR09sdDc3a2JHWjd6b2xCOTk5VEJNVC9FdjhKaktIS0JFOStsaGpp?=
 =?gb2312?B?TnBPOXBNR3RqbUdKdWs2LzVmZlIyZUJaUWF1TkdMZ1gyNk1YWXZ3RS93SHJI?=
 =?gb2312?B?ZU5qdXZ1c1NQcXNZd2NOblhhRjdDK3lBdWg4YzVJN2dBa3M2TkhWWkdUODRZ?=
 =?gb2312?B?Uy83Znd3czN3UU5RZVY3N3FTU2kzQ0FobDdSdERSbWo2bGFCSGRpbmJrdjJu?=
 =?gb2312?B?c01URFR6TG9LbmJkT0s4VmJJZGEzYnV0dHBRNUR5cDkwVUdiNVVqeDdkVkVj?=
 =?gb2312?B?Uko2N05iWWlaNUNnNlB1QUVRWVR3ZTZRNnRyRTRNTi91YXFvUWR6Z25rRUI5?=
 =?gb2312?B?ZXdEZDBSNWRRN1FHZ2NzanVlcWlZcFdCbE1kM2lpSkpySnNMcUQ4Z2JQOXp3?=
 =?gb2312?B?bWZPd1BCbVdnWXA1OWtJVjlaOW1xc2NBN1daSHYzUE1Pb2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?cmdGOGhhUGJMSytNLzVpamFaMmFjeDZnTTd5NXVxcVJwaWl2VXI1K1cwaUdM?=
 =?gb2312?B?N3NLTm5ldnZQakNIZEpmczB4d25xaEdadmI1Y3hjME1OWGNseVVMQ1V2ajhL?=
 =?gb2312?B?WUNNRVVwaURtRHJXemRiQVl6dm9IbGI0aWNudlgxOEJiQ0kzbjltREpsZVdI?=
 =?gb2312?B?eDVMWGIxZHBnV0IwUHR5ZHlPOFpYVkRnY0JyVTA5aHpUK0E5RTgyV2IySmEw?=
 =?gb2312?B?UDdac0VMdG9QNll3YlJ1MnRHOXpHeWRMbEFDMjZBMUk3Z3podEc1RXVIWExy?=
 =?gb2312?B?MHNWVXVnT2Q1Mng5a3gxWEFXTmRiRXZ4NGNWTkhlVDR1MUY3c3dwTmpLR2RY?=
 =?gb2312?B?aEE3R2RvdktRRlRuU2xnNlZ1M3YyOUNqZk9VUlhzdkNPeDNoTGdkUzZKc09u?=
 =?gb2312?B?eFk2QVZCU2toWWZ5QjBST0RtMXhLRWVzU2xJdFcxeUFOS2NoajVrNlVkWGFF?=
 =?gb2312?B?Q3hlMzZTWXYzSFM0cUNMSldvbWhYVVMwcWpZWFRRbHhRYzJqVDh6Zjh5anVB?=
 =?gb2312?B?bHdHYlVUcnlMcTUrM3RFOEQvZk5IcEJURitXQVgwa0xJa2JkckdkQ3VjRGFy?=
 =?gb2312?B?L25WTWxhdGs5M2I2Ukd4RWFLRUNqdkduSUxtTG9jdkhTZm81N3U4THQ1U2dX?=
 =?gb2312?B?SitQT25oWkpnUWM4K2NQZVFidXVDOHBPYW5kSlFzYjZkVXFCSVd6SytBTFg2?=
 =?gb2312?B?bkFBL0ZhejVCQk9OaGFUWWNYMHVJTlF5Y2FwaU1tc1Arc2tDTkVzSVZsV2ZT?=
 =?gb2312?B?STBVSzA4czVBZWtZM3FzMGpBOC96QWlsc3RxMlpmY0psWEZVdXBiVFNTNXZy?=
 =?gb2312?B?b09wWWpKRTdYbmY3Q2QzWXhucFBMU05aN2QrYVJKZ1lCNEMwTW1JcFc4ZHA2?=
 =?gb2312?B?bGdQOGxFQW5zUk9ZQXV0L0pSNzRsRlU0a0pIVUx6NjBvekxiT3BtS0orSDk4?=
 =?gb2312?B?N0ZiYkpLNXJtTjRGcGJQSzRwWHpwcUpJVk8vSkhkWkxMUzBjOGpLUGwwVzA2?=
 =?gb2312?B?V3ovakxjTXNFV1hHdTJPSm9NNjQrdnF1Ynd3U2djUWRvNVd0WkUrWWZ2QlJB?=
 =?gb2312?B?MDRLS1hMaU41aHp2QXR5YWVDOVByOThPcVJkNjVUUFQ4eUFuREVoQUljTDAy?=
 =?gb2312?B?ejlUZkY0N0lRNDJ3ZW5nd0c2bUZtaTgvOUhiSmhaa2ErMDRIYlMzYUE2b0hZ?=
 =?gb2312?B?VlNBdnRGdDQwei81blpiTmFacHNndVY3aWRVa3BZU0RDQnk1SVFncmdObmZt?=
 =?gb2312?B?WDl6Ti93MDVCcVkrckFEcnpEYy92eEJ6a2Y4YUlvS3hVL3FlQTFHVHFmN3Jk?=
 =?gb2312?B?bjR6a21FUWVOV0RERE5hYUtCWnN1Z2J0czdwaVR6czIzbUNjdnY1WWdmYTZO?=
 =?gb2312?B?WFh6czZ1QmxiT2UrZ2dkNjQ4TStkZlhHU0xtUSt2S3BRLzVadFhVQ2tkdUVt?=
 =?gb2312?B?UUdtVjVKVkJtalFwdVVGRlFBWVRLa2JJSkY1ZnMzbGt1RFZEN2l3Q2t6ZUpT?=
 =?gb2312?B?VVZsMTQyVFVxUGF4TnBpdTFjQjN4ZDZaVklHSVVWQlg4TktzNm5sdDRzWFNw?=
 =?gb2312?B?SVBSdTNKNGU0RjI3SVVXM0pMeEFZKy9DVjkxM2wzVE5NTms4RzY4aFNRL2d4?=
 =?gb2312?B?N1JoWWFxK3piQ3Q5dlpWUUpCRWNCSk05VXRHOEFXZzlDOGdmTk82elpNU0ly?=
 =?gb2312?B?Z3hEcGpLMm95elA1MTYxdG5sNVVrck9pc29LUHd3Sys4TGhHcTRsc0JSRy91?=
 =?gb2312?B?dFI4N2hCdmdPU2pTbCtVVUFPcDhEbjR1Zi9pUEliYXhOS1VFNDM5QTl6ajc0?=
 =?gb2312?B?dFVDZEtkejZ2ZSt5ZVBLT0VLdjVmbjlmbkVaUlFlTXJleGVkMDc3VURicGlR?=
 =?gb2312?B?Z0hXUzhrUlV2SjZpZUppbUlBMFR6cjk1cmlwMjl2MWFYMDBvNFlmYmRTQTNM?=
 =?gb2312?B?R0xybm1XSG11ZFNqRk44MU1tWEtPWmxMekJjSnZsQXJwVTZCekJ1RkNzSkQ0?=
 =?gb2312?B?dHlaQnU3SExyWTE0TENGbVlpQlMxbHhhZWxhRTJTY1c0OHdxUHpqWFRsQXlS?=
 =?gb2312?B?aHYzY2FFMUR4V2F5bVRibkE0eG5BOGlCUWVWWHFSa3lkaVBsY0dYWXRES0lK?=
 =?gb2312?Q?aac8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 302dc35a-4ae0-4b46-bcef-08dcdb736c84
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2024 01:59:56.8041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MptPiOHZ80KPtQIQcHb4zfqKGbyHnT47H8OUcPEzCgdpuI7touUzbkON7Aov8P8hUOas9+CsGG1vOcPyQJD5Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10525

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWbGFkaW1pciBPbHRlYW4gPHZs
YWRpbWlyLm9sdGVhbkBueHAuY29tPg0KPiBTZW50OiAyMDI0xOo51MIyMMjVIDIyOjI1DQo+IFRv
OiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4NCj4gQ2M6IE1hY2llaiBGaWphbGtvd3NraSA8
bWFjaWVqLmZpamFsa293c2tpQGludGVsLmNvbT47IGRhdmVtQGRhdmVtbG9mdC5uZXQ7DQo+IGVk
dW1hemV0QGdvb2dsZS5jb207IGt1YmFAa2VybmVsLm9yZzsgcGFiZW5pQHJlZGhhdC5jb207IENs
YXVkaXUNCj4gTWFub2lsIDxjbGF1ZGl1Lm1hbm9pbEBueHAuY29tPjsgYXN0QGtlcm5lbC5vcmc7
IGRhbmllbEBpb2dlYXJib3gubmV0Ow0KPiBoYXdrQGtlcm5lbC5vcmc7IGpvaG4uZmFzdGFiZW5k
QGdtYWlsLmNvbTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbmV0ZGV2QHZnZXIu
a2VybmVsLm9yZzsgYnBmQHZnZXIua2VybmVsLm9yZzsgc3RhYmxlQHZnZXIua2VybmVsLm9yZzsN
Cj4gaW14QGxpc3RzLmxpbnV4LmRldg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldCAzLzNdIG5l
dDogZW5ldGM6IHJlc2V0IHhkcF90eF9pbl9mbGlnaHQgd2hlbiB1cGRhdGluZw0KPiBicGYgcHJv
Z3JhbQ0KPiANCj4gT24gRnJpLCBTZXAgMjAsIDIwMjQgYXQgMDU6MDU6MTRQTSArMDMwMCwgV2Vp
IEZhbmcgd3JvdGU6DQo+ID4gPiB6ZXJvIGluaXQgaXMgZ29vZCBidXQgc2hvdWxkbid0IHlvdSBi
ZSBkcmFpbmluZyB0aGVzZSBidWZmZXJzIHdoZW4gcmVtb3ZpbmcNCj4gPiA+IFhEUCByZXNvdXJj
ZXMgYXQgbGVhc3Q/IHdoYXQgaGFwcGVucyB3aXRoIERNQSBtYXBwaW5ncyB0aGF0IGFyZSByZWxh
dGVkDQo+IHRvDQo+ID4gPiB0aGVzZSBjYWNoZWQgYnVmZmVycz8NCj4gPiA+DQo+ID4NCj4gPiBB
bGwgdGhlIGJ1ZmZlcnMgd2lsbCBiZSBmcmVlZCBhbmQgRE1BIHdpbGwgYmUgdW5tYXBwZWQgd2hl
biBYRFAgcHJvZ3JhbQ0KPiBpcw0KPiA+IGluc3RhbGxlZC4NCj4gDQo+IFRoZXJlIGlzIHN0aWxs
IGEgcHJvYmxlbSB3aXRoIHRoZSBwYXRjaCB5b3UgcHJvcG9zZWQgaGVyZSwgd2hpY2ggaXMgdGhh
dA0KPiBlbmV0Y19yZWNvbmZpZ3VyZSgpIGhhcyBvbmUgbW9yZSBjYWxsIHNpdGUsIGZyb20gZW5l
dGNfaHd0c3RhbXBfc2V0KCkuDQo+IElmIGVuZXRjX2ZyZWVfcnh0eF9yaW5ncygpIGlzIHRoZSBv
bmUgdGhhdCBnZXRzIHJpZCBvZiB0aGUgc3RhbGUNCj4gYnVmZmVycywgaXQgc2hvdWxkIGFsc28g
YmUgdGhlIG9uZSB0aGF0IHJlc2V0cyB4ZHBfdHhfaW5fZmxpZ2h0LA0KPiBvdGhlcndpc2UgeW91
IHdpbGwgc3RpbGwgbGVhdmUgdGhlIHByb2JsZW0gdW5zb2x2ZWQgd2hlcmUgWERQX1RYIGNhbiBi
ZQ0KPiBpbnRlcnJ1cHRlZCBieSBhIGNoYW5nZSBpbiBod3RzdGFtcGluZyBzdGF0ZSwgYW5kIHRo
ZSBzb2Z0d2FyZSAiaW4gZmxpZ2h0Ig0KPiBjb3VudGVyIGdldHMgb3V0IG9mIHN5bmMgd2l0aCB0
aGUgcmluZyBzdGF0ZS4NCg0KWWVzLCB5b3UgYXJlIHJpZ2h0LiBJdCdzIGEgcG90ZW50aWFsIGlz
c3VlIGlmIFJYX1RTVEFNUCBpcyBzZXQgd2hlbiBYRFAgaXMgYWxzbw0KZW5hYmxlZC4NCg0KPiAN
Cj4gQWxzbywgSSBzdXNwZWN0IHRoYXQgdGhlIGJsYW1lZCBjb21taXQgaXMgd3JvbmcuIEFsc28g
dGhlIG5vcm1hbCBuZXRkZXYNCj4gY2xvc2UgcGF0aCBzaG91bGQgYmUgc3VzY2VwdGlibGUgdG8g
dGhpcyBpc3N1ZSwgbm90IGp1c3QgZW5ldGNfcmVjb25maWd1cmUoKS4NCj4gTWF5YmUgc29tZXRo
aW5nIGxpa2UgZmY1OGZkYTA5MDk2ICgibmV0OiBlbmV0YzogcHJpb3JpdGl6ZSBhYmlsaXR5IHRv
IGdvDQo+IGRvd24gb3ZlciBwYWNrZXQgcHJvY2Vzc2luZyIpLiANCg0KVGhhbmtzIGZvciB0aGUg
cmVtaW5kZXIsIEkgd2lsbCBjaGFuZ2UgdGhlIGJsYW1lZCBjb21taXQgaW4gbmV4dCB2ZXJzaW9u
DQoNCj4gVGhhdCdzIHdoZW4gd2Ugc3RhcnRlZCBydXNoaW5nIHRoZSBOQVBJDQo+IHBvbGwgcm91
dGluZyB0byBmaW5pc2guIEkgZG9uJ3QgdGhpbmsgaXQgd2FzIHBvc3NpYmxlLCBiZWZvcmUgdGhh
dCwgdG8NCj4gY2xvc2UgdGhlIG5ldGRldiB3aGlsZSB0aGVyZSB3ZXJlIFhEUF9UWCBmcmFtZXMg
cGVuZGluZyB0byBiZSByZWN5Y2xlZC4NCj4gDQo+ID4gSSBhbSB0aGlua2luZyB0aGF0IGFub3Ro
ZXIgc29sdXRpb24gbWF5IGJlIGJldHRlciwgd2hpY2ggaXMgbWVudGlvbmVkDQo+ID4gaW4gYW5v
dGhlciB0aHJlYWQgcmVwbHlpbmcgdG8gVmxhZGltaXIsIHNvIHRoYXQgeGRwX3R4X2luX2ZsaWdo
dCB3aWxsIG5hdHVyYWxseQ0KPiBkcm9wDQo+ID4gdG8gMCwgYW5kIHRoZSBUWC1yZWxhdGVkIHN0
YXRpc3RpY3Mgd2lsbCBiZSBtb3JlIGFjY3VyYXRlLg0KPiANCj4gUGxlYXNlIGdpdmUgbWUgc29t
ZSBtb3JlIHRpbWUgdG8gYW5hbHl6ZSB0aGUgZmxvdyBhZnRlciBqdXN0IHlvdXIgcGF0Y2ggMi8z
Lg0KPiBJIGhhdmUgYSBkcmFmdCByZXBseSwgYnV0IEkgd291bGQgc3RpbGwgbGlrZSB0byB0ZXN0
IHNvbWUgdGhpbmdzLg0KDQpPa2F5LCBJIGhhdmUgdGVzdGVkIHRoaXMgc29sdXRpb24gKHNlZSBj
aGFuZ2VzIGJlbG93KSwgYW5kIGZyb20gd2hhdCBJIG9ic2VydmVkLA0KdGhlIHhkcF90eF9pbl9m
bGlnaHQgY2FuIG5hdHVyYWxseSBkcm9wIHRvIDAgaW4gZXZlcnkgdGVzdC4gU28gaWYgdGhlcmUg
YXJlIG5vIG90aGVyDQpyaXNrcywgdGhlIG5leHQgdmVyc2lvbiB3aWxsIHVzZSB0aGlzIHNvbHV0
aW9uLg0KDQpAQCAtMjQ2NywxMCArMjQ2OSw2IEBAIHZvaWQgZW5ldGNfc3RhcnQoc3RydWN0IG5l
dF9kZXZpY2UgKm5kZXYpDQogICAgICAgIHN0cnVjdCBlbmV0Y19uZGV2X3ByaXYgKnByaXYgPSBu
ZXRkZXZfcHJpdihuZGV2KTsNCiAgICAgICAgaW50IGk7DQoNCi0gICAgICAgZW5ldGNfc2V0dXBf
aW50ZXJydXB0cyhwcml2KTsNCi0NCi0gICAgICAgZW5ldGNfZW5hYmxlX3R4X2JkcnMocHJpdik7
DQotDQogICAgICAgIGZvciAoaSA9IDA7IGkgPCBwcml2LT5iZHJfaW50X251bTsgaSsrKSB7DQog
ICAgICAgICAgICAgICAgaW50IGlycSA9IHBjaV9pcnFfdmVjdG9yKHByaXYtPnNpLT5wZGV2LA0K
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFTkVUQ19CRFJfSU5UX0JB
U0VfSURYICsgaSk7DQpAQCAtMjQ3OSw2ICsyNDc3LDEwIEBAIHZvaWQgZW5ldGNfc3RhcnQoc3Ry
dWN0IG5ldF9kZXZpY2UgKm5kZXYpDQogICAgICAgICAgICAgICAgZW5hYmxlX2lycShpcnEpOw0K
ICAgICAgICB9DQoNCisgICAgICAgZW5ldGNfc2V0dXBfaW50ZXJydXB0cyhwcml2KTsNCisNCisg
ICAgICAgZW5ldGNfZW5hYmxlX3R4X2JkcnMocHJpdik7DQorDQogICAgICAgIGVuZXRjX2VuYWJs
ZV9yeF9iZHJzKHByaXYpOw0KDQogICAgICAgIG5ldGlmX3R4X3N0YXJ0X2FsbF9xdWV1ZXMobmRl
dik7DQpAQCAtMjU0Nyw2ICsyNTQ5LDEyIEBAIHZvaWQgZW5ldGNfc3RvcChzdHJ1Y3QgbmV0X2Rl
dmljZSAqbmRldikNCg0KICAgICAgICBlbmV0Y19kaXNhYmxlX3J4X2JkcnMocHJpdik7DQoNCisg
ICAgICAgZW5ldGNfd2FpdF9iZHJzKHByaXYpOw0KKw0KKyAgICAgICBlbmV0Y19kaXNhYmxlX3R4
X2JkcnMocHJpdik7DQorDQorICAgICAgIGVuZXRjX2NsZWFyX2ludGVycnVwdHMocHJpdik7DQor
DQogICAgICAgIGZvciAoaSA9IDA7IGkgPCBwcml2LT5iZHJfaW50X251bTsgaSsrKSB7DQogICAg
ICAgICAgICAgICAgaW50IGlycSA9IHBjaV9pcnFfdmVjdG9yKHByaXYtPnNpLT5wZGV2LA0KICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFTkVUQ19CRFJfSU5UX0JBU0Vf
SURYICsgaSk7DQpAQCAtMjU1NSwxMiArMjU2Myw2IEBAIHZvaWQgZW5ldGNfc3RvcChzdHJ1Y3Qg
bmV0X2RldmljZSAqbmRldikNCiAgICAgICAgICAgICAgICBuYXBpX3N5bmNocm9uaXplKCZwcml2
LT5pbnRfdmVjdG9yW2ldLT5uYXBpKTsNCiAgICAgICAgICAgICAgICBuYXBpX2Rpc2FibGUoJnBy
aXYtPmludF92ZWN0b3JbaV0tPm5hcGkpOw0KICAgICAgICB9DQotDQotICAgICAgIGVuZXRjX3dh
aXRfYmRycyhwcml2KTsNCi0NCi0gICAgICAgZW5ldGNfZGlzYWJsZV90eF9iZHJzKHByaXYpOw0K
LQ0KLSAgICAgICBlbmV0Y19jbGVhcl9pbnRlcnJ1cHRzKHByaXYpOw0KIH0NCiBFWFBPUlRfU1lN
Qk9MX0dQTChlbmV0Y19zdG9wKTsNCg==

