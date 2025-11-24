Return-Path: <bpf+bounces-75322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C226C7F492
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 08:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 490E24E415B
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 07:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232962EB87E;
	Mon, 24 Nov 2025 07:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CNzJBvQo";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PIk3YzXj"
X-Original-To: bpf@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C542E973A;
	Mon, 24 Nov 2025 07:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763970971; cv=fail; b=KKicDEKawD4gtciuwKBPXJFuh6bg2/x2K8M/fLy5TL4/07qgSLuS8vFxeLwRQmbBpF1OYPBFzFDTlvkh5nBlNuZQtftvnV6Riabynw1RHtev6c527bH8WXwts61StkqqptAPXamTJBgMiubqG7TxKQubxOCGJZlEMpNCLzmnPvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763970971; c=relaxed/simple;
	bh=LFwPOas6u+lM5mvUfszmtunUFzwAVV+X8kRFDto4Ydc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OWQ9Gbd1te7gS8N/JsGWbNpang4BWdOa4bY2N9f8VIMl4iCOIPnP5tzSwJlIpOvqTi/3fK/NTGCwaa9qd/uquhnSSwymz2TwWITY0VgE2ZXvtxTOqTzIV3pdLWH5aLSWcy17dn4bKOSfv1TA2DdFi/W9zTxXrmKW2zxu7qCOM7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=CNzJBvQo; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=PIk3YzXj; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763970969; x=1795506969;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LFwPOas6u+lM5mvUfszmtunUFzwAVV+X8kRFDto4Ydc=;
  b=CNzJBvQoYUWZuADr1Ki5a9CH4CBTsYo3/0XTtEYGG0s7u4ANKRXTkOMU
   1ldcDR46O4W91nx4VMQ8zDugt+Tl5lZlltLL3dYDrbJaZF+hih3jsYqPB
   SAhYbe+V6GA8GVbOib8z3VI3Ud59Dgx7RgceVKfuJ5SqmsWfT8z/ZfK2u
   SK1et60LoLVXzHLbFdTo9IEsN95dFbtYwGJStrN6ysB1g7wRaaTiPWcUo
   x07rWmgB1fnpMBNsKrR4kq/tD1F2HF8w510XHByeCg0ehgp9JIqHfF8tw
   PvOUNQX4AMZselU0v1xGzy+FrVTU1dNl3JzgeW5ngq7nHPEcqDwjBF3JX
   g==;
X-CSE-ConnectionGUID: dS/nZd35Rbuvt15oFDhWBw==
X-CSE-MsgGUID: AK+IAauhTiOHt1ieOgZ0JA==
X-IronPort-AV: E=Sophos;i="6.20,222,1758556800"; 
   d="scan'208";a="135269703"
Received: from mail-westusazon11012018.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.18])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 15:56:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NThjko+cc0KszkjBpa7jgV4Ju/DzPCA2C7fKkgfQr1unjJ4TwX8skXmzXjOrhSyONMytWculPLUfjxVkESMUWWjnW/1G5EOmdesRKAQxCA5U7ILWM95uXBWVM2wQwls4EXVu0nA5C77KzGixNdneJmh+FPiPBmsmrJuJiaSyGnY9Yx8bsjuCfZ1qUhhBQo61Q8d9rb/FK8m6WLU5kaIceQaRCNCASxKuiAI40l7OAxllZzZHbPqwbexrVmQO+W5D1ZMWp3pEe4UH3HYl6RRBN6tBVKyRB5vHjcpcuAVppzw5ePWhGZBnwJKwrBTy7KBfFOdaawYfO1PbMOm0083q5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFwPOas6u+lM5mvUfszmtunUFzwAVV+X8kRFDto4Ydc=;
 b=V+CvZPWTufOl9CaIVi5C6TLLuKb1IyKG5hGqVYFSNU9oLEtqIdrWPCIdaTkCeydNfKcgAcCrzr7KR5QedKnbZ/DPFYqfy6aDxtW+oZ65/A+fU5sqzkJTU/P+j9A+TykcU9oMwd9oyEYf9FgxVyT/zfL4iyUh/QreTjOShkYyq9JpbzsS961Hi+AItFQDAyuFKkkRaoM1h1RKLRQVldG5GtDB/NHkVba4RxXZ0OdSgEkBF5iB9IPGFwd5cGXmDR1oO4Oq0qSI3YgoRxs+9mztYEKZtpD0o1Wx9Ml+S/6Ub4dS6S0K5vlruHThsILnPiey71D0v2oe/OZPSo9vTX/etw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFwPOas6u+lM5mvUfszmtunUFzwAVV+X8kRFDto4Ydc=;
 b=PIk3YzXjoF9iwdkg3XfYJKzvYsQS/+O3IxM/tvnefJvBNICaZfchBz6ng0DcvWAW0npNgbd/trP1IC0WRKBVN3xZyqjXW/BADJVaqUd9peIZ1BCA7Eo0SlJcTQ4UMIyBZ+SzPqGCXxECP5XMY6ta+MLW4VbZjoljdmCDgNvSV0Y=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by DM8PR04MB8118.namprd04.prod.outlook.com (2603:10b6:5:317::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 07:56:06 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 07:56:05 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "agk@redhat.com" <agk@redhat.com>, "snitzer@kernel.org"
	<snitzer@kernel.org>, "mpatocka@redhat.com" <mpatocka@redhat.com>,
	"song@kernel.org" <song@kernel.org>, "yukuai@fnnas.com" <yukuai@fnnas.com>,
	hch <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>, "kch@nvidia.com"
	<kch@nvidia.com>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
	"chao@kernel.org" <chao@kernel.org>, "cem@kernel.org" <cem@kernel.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, "linux-xfs@vger.kernel.org"
	<linux-xfs@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH V2 4/5] f2fs: ignore discard return value
Thread-Topic: [PATCH V2 4/5] f2fs: ignore discard return value
Thread-Index: AQHcXO5FGfbCkio2IkK9BtGiPp9CALUBdbWA
Date: Mon, 24 Nov 2025 07:56:05 +0000
Message-ID: <b28f4f1a-8224-4205-a3e4-4894b6cbfa89@wdc.com>
References: <20251124025737.203571-1-ckulkarnilinux@gmail.com>
 <20251124025737.203571-5-ckulkarnilinux@gmail.com>
In-Reply-To: <20251124025737.203571-5-ckulkarnilinux@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|DM8PR04MB8118:EE_
x-ms-office365-filtering-correlation-id: b11ecccf-1c99-46d1-a5c4-08de2b2eebd6
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|7416014|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?eEZ5U2VxelJNQlpvejM0K2E1L1FzYnpKT1lrZ3hGN0IrMmJCYnNETkVlTDVL?=
 =?utf-8?B?NGJBV1hLVFlLUE9HbnlqSy91eXNZdVowWXZNNFBQS29jZlQwSUR6WjlicHh5?=
 =?utf-8?B?WlNsYkROdG4xYkxBc3JVNFJpNHZvQ0NOWjM0UlhzT0NzZ2VBeWRwRlJoS2dr?=
 =?utf-8?B?MEU1S1B0dUVzVEx0V0F6ZStoamdhNmZDQXZ3ZlVXNXZ2MDR2UFN2U0pCODg5?=
 =?utf-8?B?WFdTRFNYVC9lQ3hRaENqYWorK1JKaXNUbWRpTFdLN3dtWk5tTW1QZDVadmxY?=
 =?utf-8?B?dW1IM01GRmFDcC9ZTmJaSUpTbnUyTHBpTEVDOEt5amZVQ2ZadTJVN0MzdU8z?=
 =?utf-8?B?bEtxLzNrK1FiNXZuQVdsOEorWERGY0VLd1ZmVGpSMU54aXFxVHZ1aFNkc1o2?=
 =?utf-8?B?V3duSXBGOVJab1lsTlJRYzFDdHBBMDRvbjArUnJtZ1NkRVo4VVp5aElkbm1H?=
 =?utf-8?B?RjJVbzRQd0xQQWtRNzBhOVZxcGQ5bkJ0S0FkYnlCNElYVmJHTVYyeHRvYkEr?=
 =?utf-8?B?MVZuM1BFQUI2cGI2N2RTaGt5TWg0clBGaUlPTFZrZit2Rzk0UHZQU3crN2dR?=
 =?utf-8?B?YStsWEJVRnpld0QwVnVFK3gxTFJLQkpUQ1JyNnR5c3BaRDNNSjcySlY1ckdB?=
 =?utf-8?B?MEh4cTcwQTBha3U3aHpSRUpFZi9vd2xrRTdySjJmR05IcDI0aDlKWEpCRmNP?=
 =?utf-8?B?aWVIT1ZmYmtPMHBVQ0xBdjhIT1NmYVc1alNEN1h0a2MwM095QlpxQlU0dS9W?=
 =?utf-8?B?dFo5TE5sN2RsamJaUjh1K1k0SVJMV3VDZzdheVRhTGE1dkxaODU1bmVXa0Jh?=
 =?utf-8?B?ekVQYVpNWXQ2YVNqN1BZdTNvREt5YkF3NG1RbHM0TUN0YS9hSkZJUHRhVmVp?=
 =?utf-8?B?YUxkcXNmUzNsNkZaY1loZy9SSy9UMmRlMC9PbXdBdnEzbk0weHY2QmRlcHJR?=
 =?utf-8?B?ZVorenF4Vi82anAzcXJjWlVvYXVIZkFXeXFGQmlFbUsxODgvK1k3ZFNsNEow?=
 =?utf-8?B?b2I0ZU9ocFR3aUY1TXNHckd3eC9VTkRSWkl0L0hOdTFIY3VUd0hPVVZzUGZ5?=
 =?utf-8?B?TEhmNDdwemYvTjVkZHFhdFpwYS9pQWVhNjVXbFE3ckpDWFV1UnppUVdvZVBL?=
 =?utf-8?B?b1BuVFpUR1h4bG52RlplaVN5Qm5nS1RxNjNkb0dFaW4xMEl1aWw3dnBGWVFw?=
 =?utf-8?B?Y25qaElic0VvdStYRUhuMHdLeHZWcjdOenVYSDErQm1JbW1sNjhnQWJhWkVV?=
 =?utf-8?B?WXJwdTE3NU1Lajl0Um9NWFZVNmR6b3VxeWhZeTJnd2wxNEl0aDNqNlZXOEZz?=
 =?utf-8?B?TEpxVk5JMTFBTDl1Nnh6SjBPRUpMUlRhaXhtTTdEMEhoR2ZpeVlDUEtSZ2pu?=
 =?utf-8?B?SUxsL2Y1dEQ2UnMyMGIxWVR5ZU9SWG9rb3RBNHBQTFVoQnRYT3kvZ3l1cUtk?=
 =?utf-8?B?Zmc1QWRabWFkZ01obDFXTTc5cG00TmdDTWE3aHAzWXdDOU5aM0JObVJxZk1s?=
 =?utf-8?B?b09MSFhOa0t5djAreXQ0T2VmNGhlVTNmazVZYnkvemF5SDJzSk1tNmJLZjJu?=
 =?utf-8?B?TGtZOGtNcEhZcXpkRWhFVFM2QWVMNGphbzU5ZGVsVElNODREaDd1WlhNZTcv?=
 =?utf-8?B?a2RDSzFZR3kvdFZwT2lFTEhoNlNkUG43UkJaVlZ3VG9yREJjU0VqN2p6c3ZV?=
 =?utf-8?B?TDVLbGwxMDk5R2RDS3pNc1NRUzJ2blBrbWdPSjJ0eFc0K0ZnZlArRzQvZVlG?=
 =?utf-8?B?QkYyVjA1bDFBS2VtV3o2aUE4RG9tblAvc3J4Vjd4VTRVSGlzSG1jcW50NzNa?=
 =?utf-8?B?bmxEeTVPTTUzbWxZMStINENZN1dMWWYvWG5XQWxhZWZrQU0rTytEUWpNazFI?=
 =?utf-8?B?dndaSGF4clBEdzZ3amJkYkhYNGxRSDhOQ2wyK2dXT0ZCOEhrZkU5ZUszNUJH?=
 =?utf-8?B?b3pUVGYwckplK01oUVpGUVZseTNLTkRWVCt1TjdMdXV6RDY3ZStadnFTczRH?=
 =?utf-8?B?bFdUc2tJZXZORFNLRzFwWms4MkZmVndHWUZwYnNLakNweFllNmt3Mzd0V2J4?=
 =?utf-8?B?MTdVZFB4dDVTZ2NvOVpDdDFMK1JLNWl3QlVwZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VVVybUorYW80T1BMeFZGWlVOeFExdGh1NkViMEEzblRET2tPZEcyb3pBanJq?=
 =?utf-8?B?UDQ0RTBGK25ndisyM2lCREhYR3BycjV1bXNOTWw2SkdzQit1OXZEUzVGTUZQ?=
 =?utf-8?B?L0tGMmVOV0pGSzVJL0ZrS3BZVjFnSkkvRG8zR1FiZkdiaXBwaE1yRG1mUi9j?=
 =?utf-8?B?N3BUbmdGVDliUXEzODNZOG1XT2ZTbWdpY1ZhOUtqSzRwWnpmTm9aSEdKTkxl?=
 =?utf-8?B?QkFnWGZHWVpFd0c3d0FNd1RWSUE3TVlHdmY0S1cwdkE4NERGeFZIOU1kbHVD?=
 =?utf-8?B?Ry85Yi9URnYvOGZtblV2eGROWSsyVmxWc3hFNmpsR0xLU1MzZmJ0UGd3VTZ6?=
 =?utf-8?B?R3NSK3RCMTVvZlpyemtoSmtMU0E5NjZHditqNC9BRjl2NDAyNnAzS0x3djcv?=
 =?utf-8?B?V1doV0lham4zVzdGbTVEZFlPMWh2UDNCL0QwYzgzN1dSZzRYMmVDeXNIZHA4?=
 =?utf-8?B?Mkk3U085M1lDaFB6cXdCSkZPd3FFNXBJS2hOVUFmRjg0U3o2VUJNN0lWNmsw?=
 =?utf-8?B?Nm5aQVl3UktwYjFlSi9VaE5sYnhVYUovRDgvdTRVUmVkZDFsYUExZzlsWVk4?=
 =?utf-8?B?WEt3L1VaenlYcG1UUUdPQXZKUGJzTkRCbHR2Yy8zbUM3OE1lTjBBUEpBeWZG?=
 =?utf-8?B?NFZRWDhCL2FYbXErWENraHVwcVk2djVXUjcyNnlpUlBqOENSamExUnJLdjA3?=
 =?utf-8?B?WmFtNGxPdi9yWlJjWnBmODZlY0Q1a0tlcDZoTmROK0Z6OFIxSTNMN1FPY2Qw?=
 =?utf-8?B?VXFtUzV0Y0RMR1RHUVdhL1FCR1Q4aTRqeTQ4K2JRMEJid29ZRXdmVkt1RjVZ?=
 =?utf-8?B?MGQwWS83UXY1N3FieGVaVmVUUnZuZytCYWwvZUtCR3JEVmZxQjY1bmZWUFQv?=
 =?utf-8?B?bGdINU15ZmE2TUpHUGo2MTUweENxTXVvazlSWGgxVHUvWmFJQzY4bktxbjEr?=
 =?utf-8?B?alBqYW94RDhZNVlyU1BqdVlmc1B3ZGw5RG5LNlpVOVZ0eGZrZjVqRXFlVlhJ?=
 =?utf-8?B?M0YwSUl6ekRYN2NYQ3YvbTFOYnRUUlBwS3JHdWM0LzdLZGdXTFQxT01ueTFr?=
 =?utf-8?B?MHF4TUJQeno4eldrYjJIdTRsaENKbW5UL2pNbndodCthM0RrSjM2Qjc5WWRH?=
 =?utf-8?B?SUhLNGpwT0UycUM0RjV6ZGZRa3VuNXJLWjhwQWJTN1E5TU16OGV6anAybDZv?=
 =?utf-8?B?RjBZOFFYRFhVZFdyTlVFVzlXMjV1MTI2RUpyY215cnJ5KzZlejVkUFNXZzhH?=
 =?utf-8?B?SFRkQi9DdlplVGVWdi9MSHU3aHNhSndkTzNZc0FrcW9QQjczOGg3QXJSd3Iw?=
 =?utf-8?B?YVFoYU41UjNmNHNGRUdQcWZFR0lXcURJYXdqREx4N09ZWE9PTG9QaXZ3QUtP?=
 =?utf-8?B?STJkTXJrbWlud1J6RlJWZFlPNWlwRHo2aDRNTlE2VGo2WHFqeUpoem92NDEx?=
 =?utf-8?B?MWNzRHRuMEk2RWw3NXBCY1hWbzg1WWsvZlNTMGR4Z202N2ZmRlIxbktyR3FP?=
 =?utf-8?B?ajlSVi9VMHprOVQza3FGSkpSVmRHUUZDWTZlQk9IV0pGeXpZL0xSSVQ0Z3hM?=
 =?utf-8?B?TUhSbC8rd2I4TUFvdVpHOVYyd0N2VHQ2MmlPa2xrM2x6QmE1RXBWVlJ1Rk9v?=
 =?utf-8?B?d2dGemVrUVJFNk9PTHZidmVHWmg3VUZNUXN4SloxVU5Tc0tBZ0NJcFVIajQr?=
 =?utf-8?B?cDEwY3UvUm5xVzVBVEt5UGhoNTBNVzd0NFNuTXhpV01udWFEYWJMUjNpVDht?=
 =?utf-8?B?NGplZVBPSFB0K2M5SXVUYUZDTGI1QVVWNDhhN0lsV3o4VWU4RU5VbmFkOVJm?=
 =?utf-8?B?ODNnb3Jpd0ZRcWg3Z1ZxR1hVZE1JNDhuUmRNMXBuSGhrNEMzd1dyeDdJc3Rj?=
 =?utf-8?B?eFFuZXFLdkRRVWpPVGl2RytqYU5tT0EzTEtnRU5OckxnUk1xWHllbmJ5TE1t?=
 =?utf-8?B?QmJpQVpGdnlGRXYyQlNhZUZ2YmEzVWw1LzU4U25GRUY4L09BNFFiL2t2Tzlu?=
 =?utf-8?B?UHhEeGw4MmNIQTgrclpUYWs4SjZJekVRbGJ4aHZMQ1ladkt1cWFISFhkaHc5?=
 =?utf-8?B?MmRyenJYNjljdCt3OWtZMkFOTzdRUFUxeXJEUXN3QUhCV21KYS9qeW1CbTFG?=
 =?utf-8?B?QlRzVWtkckU2MEo0NVdIRy9oRmNON2JiZkFlYXJHVWVPcEc1d1NkeTBPT2xo?=
 =?utf-8?B?ZGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BA3FCC03EF64041A2966E020664C4FF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RScVdEiKxeMiNqDwvu6BRayNsoxeVtzJhANss80rWG6TYgtfKcqbdFIx5XScARIdexWwlM0azs69x/1SARIh733TYcZG7ducIBlh/tOaA70UjaeaelxkhZaMnbG1WAGwebcnEkp6TtsSw0tdw9V1uOz7qPu5GlrLYJi1avpFAfVEHaOrnweapoQSpkyTLGEYyK1B7757YyCv8S0PrHFWqXnLRXUYe9gu6Kbd6CKVj0+9ocL+3HHF27rsUivYs1RikrGEb3A0UVgm3zmxAI7Jo6J7QLnRE0JoZcW+f3tB6HM4qz2UNSzx7wxU0i2o7qriK8OaivvKUNSYRWTM0QJld7qco2b+VO5ziqmZLT84OsakBnQAYrl5lq54Q+MlOL1Zxepm1jQoJle5VTgYplGKXcxzZ1ALFX+onbL3o2V+iceyjr/1mQRkOJgIfRuerNyD7qXr1eR8nsGq0XPBcDSaLJcItN0ZxIv56Lq08BTaof+/L2WdWrv/or+MHgrdITW2ApvTkjqFtqjyg2diQ5CNZIAutw5dLrtFEhq3roosmmlHBX1B6RmSE6y1Kp0zhMyCphjvCZlFsFbYmXMFe1Si7p9NQ6t/M5GYDQyFUhBxqKe+xPcw8Cf5R8OYT3lW9kov
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b11ecccf-1c99-46d1-a5c4-08de2b2eebd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2025 07:56:05.8165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WMRj7y5QXow8godR4QC6xJuvB7ARfSo6iHhMq6NzEkJ8m5f41JVJE2HTWgcpK6j5+SMVDflhRsDoM9fQ9nw/sxRhxLZCNsS2XW4ddtIMgJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8118

T24gMTEvMjQvMjUgMzo1OCBBTSwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPiBfX2Jsa2Rl
dl9pc3N1ZV9kaXNjYXJkKCkgYWx3YXlzIHJldHVybnMgMCwgbWFraW5nIHRoZSBlcnJvciBhc3Np
Z25tZW50DQo+IGluIF9fc3VibWl0X2Rpc2NhcmRfY21kKCkgZGVhZCBjb2RlLg0KPg0KPiBJbml0
aWFsaXplIGVyciB0byAwIGFuZCByZW1vdmUgdGhlIGVycm9yIGFzc2lnbm1lbnQgZnJvbSB0aGUN
Cj4gX19ibGtkZXZfaXNzdWVfZGlzY2FyZCgpIGNhbGwgdHAgZXJyLiBNb3ZlIGZhdWx0IGluamVj
dGlvbiBjb2RlIGludG8NCg0Kcy90cC90by8NCg0KDQo+IGFscmVhZHkgcHJlc2VudCBpZiBicmFu
Y2ggd2hlcmUgZXJyIGlzIHNldCB0byAtRUlPLg0KPg0KPiBUaGlzIHByZXNlcnZlcyB0aGUgZmF1
bHQgaW5qZWN0aW9uIGJlaGF2aW9yIHdoaWxlIHJlbW92aW5nIGRlYWQgZXJyb3INCj4gaGFuZGxp
bmcuDQoNCk90aGVyd2lzZQ0KDQpSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hh
bm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg0K

