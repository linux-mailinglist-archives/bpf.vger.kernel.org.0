Return-Path: <bpf+bounces-37538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AADA895747E
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 21:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6021E282999
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 19:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815971DB45F;
	Mon, 19 Aug 2024 19:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="jOPFtVUk"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2046.outbound.protection.outlook.com [40.107.103.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813AD176AAE;
	Mon, 19 Aug 2024 19:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724096058; cv=fail; b=i9bj5YzBPPKGRQO9oeqiThfcjhs8kTgS8uq44BVHeJ19PlJdn5P0gCwz2Axs6/h0J3aUE2vKTC0JYPxCausc+yggVImtrQ0+yILgc5/lYTBefTC43gcBhGe+Z8hD444YLIQmB2gsNtNQrFugI6SWnwZsKysZJ06fA5g9WD+CwSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724096058; c=relaxed/simple;
	bh=ufBXncNclDefI4SedLZ5fZjCy1gGd3xSRO61HX5uDbc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZcSqYH//PiZLEk4aOmQALERUBpx0WTMbC5atSVOc+glhQvktt/eF9fFaSmf1kaN67TAtYFcSpi21gxpuPSla42PjQLvZ2dXVivjCfEpeA7zoIzfpim6ZUDdrZSfVk44exM7K5zCBj6vv1hJdaZeeJN2CwXQkzghhYZwqJk1kxn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com; spf=pass smtp.mailfrom=ericsson.com; dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b=jOPFtVUk; arc=fail smtp.client-ip=40.107.103.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ericsson.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSkONsuV98wCUwIvZ/9dAthI8k8nMSzganbikKVMGj0/kMV1gratzuWUTh3e1Lwl43EyMtXwMAzz2SLEJY23aowKGZgRotsVjaPNR+z949x3M1mTWPowM2sqpT45QUo1blczStjCiFXz3b6D0QLZawdXtDA13lhMP+l70TfD+zZWU3K1YGUwetOMCr4rSFDkWsqUoRuLPMQOHO3HYLD27A1cd1H9IyniEBs3vbjGmHqWjcJRoJOx8qqezjniHZeUhrBPQLtt99P5As3RERWaN0c3bic+lLRu4VnnCYmp2xoypMMyw/2X3jOrjNyv+4bsHhHc0IJYjmtrRJC49Bt7qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufBXncNclDefI4SedLZ5fZjCy1gGd3xSRO61HX5uDbc=;
 b=dfdYF4m32y/ALZhPh2iaXB+ZCUV2Wa6L32310Imw3skCKVfwTFIFnh9jIuR9ywh2StK7bEyWRP8VBUmDHTrWMgjDiYuc57fbR/k3htRR31mfAVY8CCEDMoF3ts2mVdHJWqIkN2QNlhy9MeQnwiG+QOUFVUeuorSK7k+9F8Z+65dfuVTjPxzB0nqow1RCIqf5jyTgv2cjzKwWYSiX7mYM5yFjlLfmA+5/bf56Y1TaAevYQ5ODaE1GVfHHKuBiiZmsVkhiJKd5EmOfzbBPjv4zQtU/lgU7Gs7G8zmq9khLSEyum4u+rB4gBJntCWLeY7jDgeyyHeoF8pMo50o3TeMTTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufBXncNclDefI4SedLZ5fZjCy1gGd3xSRO61HX5uDbc=;
 b=jOPFtVUkQREc+jB+56ef9ZJoka/9koysN7o6ae1XovNxzQSggugN2G395u6HvjSGIgT7omMaPxaiaHprS7rNnQza9gbTCto869jeQYkGcc+G4RO7/Ct4W8l3dqg0wo6/NbpcLzMa3EVatfWhQCLDoDzDdPSo7OXwtxpKVhCfR8NWVMhX6p8jiBWul0e8dJxrZ4fAEJf4UOcIHT3L/jeF3WICrQAO3NGIPrAw+tkMvThe4qzLWzr1tBA70M7OqTeaWzTNV13NLpenzBDwbOaZCDJ/CyJWUYCTbjn1OM4CIAoi34nLObNQbbJN2m2J0aAl9pgWdd8T8V/bQlEEwMx/nQ==
Received: from AS4PR07MB8412.eurprd07.prod.outlook.com (2603:10a6:20b:4e3::19)
 by AM0PR07MB6419.eurprd07.prod.outlook.com (2603:10a6:20b:144::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 19:34:12 +0000
Received: from AS4PR07MB8412.eurprd07.prod.outlook.com
 ([fe80::b5b2:28fe:fe9:9665]) by AS4PR07MB8412.eurprd07.prod.outlook.com
 ([fe80::b5b2:28fe:fe9:9665%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 19:34:12 +0000
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Kurt Kanzenbach
	<kurt@linutronix.de>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Richard Cochran
	<richardcochran@gmail.com>, Benjamin Steinke
	<benjamin.steinke@woks-audio.com>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, Georg
 Kunz <georg.kunz@ericsson.com>
Subject: RE: [PATCH iwl-next v6 4/6] igb: Introduce XSK data structures and
 helpers
Thread-Topic: [PATCH iwl-next v6 4/6] igb: Introduce XSK data structures and
 helpers
Thread-Index: AQHa774OYoAj/tne9kus0csPYXMgKbIulX+AgAAF9wCAAAhIgIAAWTGw
Date: Mon, 19 Aug 2024 19:34:12 +0000
Message-ID:
 <AS4PR07MB84123D29A27BEB30CECC5FAA908C2@AS4PR07MB8412.eurprd07.prod.outlook.com>
References: <20240711-b4-igb_zero_copy-v6-0-4bfb68773b18@linutronix.de>
 <20240711-b4-igb_zero_copy-v6-4-4bfb68773b18@linutronix.de>
 <ZsNGf66OjbqQSTid@boxer> <87r0ak8wan.fsf@kurt.kurt.home>
 <ZsNSc9moGwySgpcU@boxer>
In-Reply-To: <ZsNSc9moGwySgpcU@boxer>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR07MB8412:EE_|AM0PR07MB6419:EE_
x-ms-office365-filtering-correlation-id: 21c1ea2e-0c4b-481e-b6db-08dcc085e721
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cVJYbVhIM3NrckQ4bzN4T1VuMVNWQTBmZDVlUmE0QUN0Z09QS0ltUmx6ODdF?=
 =?utf-8?B?U1c1ZUlYSnU0RUhUeXo2ZEoyQlBIQTJUN1N6N09SQ3EyUndPNG43NXNSVkN5?=
 =?utf-8?B?YzJ3eGFkOCs4c0NZN1Y5R2xHZnJNVCtvRExjcFBpN2l1QnNNSXpFalI4bUsr?=
 =?utf-8?B?YUJiaVVLR2gvNUlSZXBOTlpHYzY0ZGluSDhhWXBVb3MxNjdYZ0ttOFYzYVdH?=
 =?utf-8?B?VXNUSUFXK0JEWmsvNGVGWFdJYktORHc2dm82d2xRNUJWNW4wU3AvK2JoV2xB?=
 =?utf-8?B?VDRsMVlTYzVqVkhLNndIV1JJN1E3N0pScjRtSDdXOUhpamRFUC8xWWk1dHJj?=
 =?utf-8?B?UnJ1QnNTakQ1N1BSQUhaQ01QZXNrNzRNMk1uL2NBdW9iOENvczdzMmdSQ00r?=
 =?utf-8?B?Z21Ic3NBajh1dHI0Y3ZneS9HZlNKVU5aWmM0bDQ0K3BOZStqdzJveFZTb1Iv?=
 =?utf-8?B?ZW91bnFIK2IyK1l3TW91czltaTRGWURiUmhmWUlMTjlXbzdib2NTZU5DQng4?=
 =?utf-8?B?blFicUl4dkFoZmVpbml4VHAvUFRIVmZoNmg2VVNyUjk4MWFpR3hpS0FKRVgz?=
 =?utf-8?B?OEJBTFhrY0lFYnZiMis2U2UrZEFBbHhMc3MzZkNhZE1xbitmcDFwZTN4N0dE?=
 =?utf-8?B?KzFwWFRFb1VCcHM0MmFzUlY3eUVXWXRyalBNMEhYZHFqZFFiMUtlelBKdXF5?=
 =?utf-8?B?Wk56ZEFKb2Y3L3h4cERPcU5hdFFSTXk2d3gyYkI3c2hCM1dISnUzaFhUcTFK?=
 =?utf-8?B?M1QwL1g4M0ZvQ1JQMzRyeXpjWDNjVkIyVWpneFdkbTJuNFhFZWJ6OVZLNzJi?=
 =?utf-8?B?eTdKdHJHRjlOcDcwRENwcExBM010cTYrdk5LWW1teEJzankrclpWemFZUXBI?=
 =?utf-8?B?RThnVVptNkNhY3RBMXdnL3NzaFpKWkdxdE5NZnNMSStCV3p0clhTSWNYSUM1?=
 =?utf-8?B?eWtqSzdVMnltbmNacmM4WlhCbHFUdjExblJKZ29ZZEFrUDgzWUdMc2J5bTA4?=
 =?utf-8?B?TGhHZHZ3dUdUZ0Z0a1UzUDVUbkdPYlMvTVVtcjlDUWJoOEI4eE1jMXN6MVVy?=
 =?utf-8?B?ZTZWWDFZeXF3bFFFV0JnUXhEeE9YTi9ucjY2Y0lkWi8yU2hkV2RVK21obUpl?=
 =?utf-8?B?c2RVZUx0SnBQSGFBMnk3cE9ZUUk5YXFsUXhvUEZuRllJNHkxZDlNemZIdnYw?=
 =?utf-8?B?Zm5GUVBGVGV3VnZJdlo0b0p6SmZkMGdoZ1FTZFlqYWQwdC81alVtSExtQmRs?=
 =?utf-8?B?U0FFcEdwNWxXdTloM2tSRzdONVRjTEFMMkU1dnpCemxaMzc3aUJvSkJOUXIy?=
 =?utf-8?B?UmhNVjVvRHBRMXU1LzUrMDlKQjBGOTNaZHdXdVU2RjUyNVI2YWhCdWs1MUlD?=
 =?utf-8?B?cnEzS0w5a2RuSGV0b2ZzWEV4YzA3b1Vwd1NqV2VHems5TmJJUWZUTmxMckQ4?=
 =?utf-8?B?VENaemFaVi8zVTdGcG1SNmUvK0loYlNTaFhIY0VydWpIOU0vNnNoWGhZRFU5?=
 =?utf-8?B?dWliZ1ZWUWJ3M3QyR0o3eFhmeVlIa3doSCtHejJBdjFYa29sTFBMdW9rRU5k?=
 =?utf-8?B?eTl3VlcxeDArZ2R4QUd6YmprSkttTXJpbm5QQjR6eUJMNmdwb0NCTWcxWXR5?=
 =?utf-8?B?K2RsdytnSGQvbEduREErUkM2RUZGd3BLM0hRZ1Q5b25ic1ovWm8xUlc1RUsy?=
 =?utf-8?B?bjd3aXV6aGcvbDhoRERGeUIwZjF0Yko0cUVKKzV1M01lZW5ERTdYL1oyV0NJ?=
 =?utf-8?B?TXRpVTlHeVcwM203Y2hsUmN3TFl0aGYzd254bTRrTHRqRVhDNzdkUUlBL1oz?=
 =?utf-8?B?VW5pdWxvRE5tRlZjck5YdGtGa3BJQUFVSlE3UXhtWjFpZHYwRmFkWlk2a1o0?=
 =?utf-8?B?QXRkRU8wUGZCQlhFZDFOaGdiVmFLRGV3ZXYxU2FRNFVid0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR07MB8412.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MXhPcGNRNDlGclpNNjBRNFdYTDRWOGVid1l4VWxxK2VxTjBFY0xyOEkvNWRy?=
 =?utf-8?B?VWxlQktlSDVqaDJPTVRhZEFZMWN6YVhHbjF4Q1FBcHJsR3phclBvUEZHK1F4?=
 =?utf-8?B?dk5GSUtRblFMc2p4YWRUQ3NRS1hYUCt6SjRaOWF6RDlzMVozWlIzZEVwWGZs?=
 =?utf-8?B?d0JIOTJDTVIvRjdURUdHZjlxUnJxcG11R0JYOWF4QkdnTHFLYTZwclMwOHYz?=
 =?utf-8?B?ZmFtVWYvcmdxcEFsVUZtVXQyRVRWN2NYZ2FvL1NjTm9HUityeWFlWmY5bTJT?=
 =?utf-8?B?OHpuUVpiZjdYc3B4bklud05xQVEvWFB5NjVvMHBBSzNPRWN0WE1zRTAyOGJB?=
 =?utf-8?B?VEJoZncyS0lHMGJkMzRERUxSN2tsSjQwa3RFTzdBRklWek9YL3hFdHpvTzdv?=
 =?utf-8?B?SzZLOGtFUXcwK0xEenI2c2lzSnBCakE1Z3VWbFNMdTBoTmdhMytCNURYSHRn?=
 =?utf-8?B?VFF0OFFiQ0dRUGp2YmJaaEwrZ2pTR0F1MVVJbXJpTnUxK2MrRFFaZ0ZjY3NO?=
 =?utf-8?B?ejY1UW1XU0hjWkI5MGN4NUNrNEVzNFpyZzltNXAvZXZLUWxKYlBRY0VGS2w0?=
 =?utf-8?B?VkZpdHpoNWF5dGRIMG1tTFpMdVF1SE93cjcxM3QxanlEMXhLbjhzTjVwaCtO?=
 =?utf-8?B?RGhDdDBvdENGczdzT3B0ZzVwRXc2d1Q0WDNHS2FpcllDcit2SjFaNEZQYTk0?=
 =?utf-8?B?ZVlwU0huQktUeVU2VmF0K3E0T3phcTFjNnYrckt5V0M4dFRQK3VkQ29Ua2Jm?=
 =?utf-8?B?Tlhzamh1QVd1QmdHYTRMU3RYT3Z2bUljVmZuYVNWU0FocHp0aERPdzJJU0li?=
 =?utf-8?B?SHdtWlFqcEVVbnhZVGxjK20vTEFIUE0yeGJUWExGZkJ2THVFdUdaNnFyYW04?=
 =?utf-8?B?dmYrenZXQ3VOV3JRVENVR1pwTlFMTWdRck5MUHhvd296V0lPdnd6bE9oZTF4?=
 =?utf-8?B?Qjd0WHBiUEVqUHM1WitZYkZrUWhveEc2SHVJMXZjeXM5MUd1cWlUVDJLbmNT?=
 =?utf-8?B?am1GcjRJOVFWN3dkR2UrSUhDMEJQVlNoQi8wbWFwRmtsamRNRmNrbkRldkIw?=
 =?utf-8?B?amRwdmt2SUJPTzI3SFZabWNKc3FZbW1FNE1qTmM1clQwRmwvSE93UW95K0gy?=
 =?utf-8?B?b2FwU3huQ1laU1JvTkJNVlJ0aE9UMlZwUU1VdHcwOUpWUlUzOHpPeGdNNnlj?=
 =?utf-8?B?dmx2dHJBWCs2cDJ4alJmenU0MUhWVTQ0aVQ5aS9zZXZtbVdRWHU5YTNEUGhN?=
 =?utf-8?B?U3pFVmNFWW9QTENsU1NENzhZZVQrdGJUT0ltODUrYkpVQnpaTGFzN2JFMnAy?=
 =?utf-8?B?QkJGaTNyR1F3U2g2MUdCdm5xQ3FyTWxxci8zdnlFMll2QXdEeURuYmpvZGRi?=
 =?utf-8?B?QVRjWWszb0toUklaVEo5ak1nVFVtcS9LU1BpT1l4RGRpeGEyMSs0VjlFa1JT?=
 =?utf-8?B?OFllK2tVMGN6T2F5Uk84Q1cxS09oUVc3SmVwaEQ3YmdybEhrUW1sdm5lZUVM?=
 =?utf-8?B?Yzg4RVY1QmJrOFM4Vi9XNmVHZ0t3SkVnT205ZFpiNEFwbDB0cHptdFpuUER6?=
 =?utf-8?B?SlFxNTlDU2wwNVV4SXpCVUJmUkt0SFJoM0pBeHEwTEkzS1hzd3B0U1RZNW1w?=
 =?utf-8?B?ZTdmVzVRTzdUR2g5eWNPOVVsd3UxZi9BdlI4aUVKdUhORGMwUys1Z240MmJt?=
 =?utf-8?B?dm9mdC8yY0FwSHhTUnh2RnZzdmk3ZWVjdDVzUkJUS0k4TjdwQ3czc3BUSi9i?=
 =?utf-8?B?cVZtREdYRHdLZmRKRHdRTGNDMnd5ZUJHZllIaWtsNEZsU0lyQTVCTHNxMG5X?=
 =?utf-8?B?OUdVYmVvK1oySUJ4T3ZqbWpEclN6T0syQ0QwM09UOCthU08yVEVzNXhZMFlx?=
 =?utf-8?B?djIrWG9zTlJrOVVkTUtrM1VtUXJDZDlOTi9vb0FrTitrc3VXV3JkQUl2bGxh?=
 =?utf-8?B?ZTQ2S3ZTL0dMMjN0alB0RU4rTm9CL2dUS0xDTzZxQkhOOUZPOHFxRzZtYnUz?=
 =?utf-8?B?NUd0SmY0V3VXZUQwL0xzZFBTdEFSdy9vZGdtYkFDa0F6WGhFNW01RVNZODQx?=
 =?utf-8?B?bWh5Mm9lRjZSM21qK3hTWEJYQUJrdSswa1FFMDA1MTRnOHNUL0lvSXo2VE4z?=
 =?utf-8?B?Y3ZYaDdkUm92SEpJMXZKRHFhK2ZUL2p0Qm0ycXVucGt3TGY2NWI4Vlg1MUpC?=
 =?utf-8?B?RXc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c1ea2e-0c4b-481e-b6db-08dcc085e721
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 19:34:12.0511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /7FnqIVdvcVfWWeRa3/AAoz9/GXcfIIq7GoNpQWlU5FdjE3O4+o5FBJqyRvGFju+tGDaB7/vc7IVM0Vzl8dUfuJp/5Y+laGfyqFSGOHflI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6419

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFjaWVqIEZpamFsa293
c2tpIDxtYWNpZWouZmlqYWxrb3dza2lAaW50ZWwuY29tPg0KPiBTZW50OiBNb25kYXksIDE5IEF1
Z3VzdCAyMDI0IDE2OjExDQo+IFRvOiBLdXJ0IEthbnplbmJhY2ggPGt1cnRAbGludXRyb25peC5k
ZT4NCj4gQ2M6IFRvbnkgTmd1eWVuIDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT47IFByemVt
ZWsgS2l0c3plbA0KPiA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT47IERhdmlkIFMuIE1p
bGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47DQo+IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29v
Z2xlLmNvbT47IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+Ow0KPiBQYW9sbyBBYmVu
aSA8cGFiZW5pQHJlZGhhdC5jb20+OyBBbGV4ZWkgU3Rhcm92b2l0b3YgPGFzdEBrZXJuZWwub3Jn
PjsNCj4gRGFuaWVsIEJvcmttYW5uIDxkYW5pZWxAaW9nZWFyYm94Lm5ldD47IEplc3BlciBEYW5n
YWFyZCBCcm91ZXINCj4gPGhhd2tAa2VybmVsLm9yZz47IEpvaG4gRmFzdGFiZW5kIDxqb2huLmZh
c3RhYmVuZEBnbWFpbC5jb20+OyBSaWNoYXJkDQo+IENvY2hyYW4gPHJpY2hhcmRjb2NocmFuQGdt
YWlsLmNvbT47IFNyaXJhbSBZYWduYXJhbWFuDQo+IDxzcmlyYW0ueWFnbmFyYW1hbkBlcmljc3Nv
bi5jb20+OyBCZW5qYW1pbiBTdGVpbmtlDQo+IDxiZW5qYW1pbi5zdGVpbmtlQHdva3MtYXVkaW8u
Y29tPjsgU2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvcg0KPiA8YmlnZWFzeUBsaW51dHJvbml4LmRl
PjsgaW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmc7DQo+IG5ldGRldkB2Z2VyLmtlcm5l
bC5vcmc7IGJwZkB2Z2VyLmtlcm5lbC5vcmc7IFNyaXJhbSBZYWduYXJhbWFuDQo+IDxzcmlyYW0u
eWFnbmFyYW1hbkBlc3QudGVjaD4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBpd2wtbmV4dCB2NiA0
LzZdIGlnYjogSW50cm9kdWNlIFhTSyBkYXRhIHN0cnVjdHVyZXMgYW5kDQo+IGhlbHBlcnMNCj4N
Cj4gT24gTW9uLCBBdWcgMTksIDIwMjQgYXQgMDM6NDE6MjBQTSArMDIwMCwgS3VydCBLYW56ZW5i
YWNoIHdyb3RlOg0KPiA+IE9uIE1vbiBBdWcgMTkgMjAyNCwgTWFjaWVqIEZpamFsa293c2tpIHdy
b3RlOg0KPiA+ID4gT24gRnJpLCBBdWcgMTYsIDIwMjQgYXQgMTE6MjQ6MDNBTSArMDIwMCwgS3Vy
dCBLYW56ZW5iYWNoIHdyb3RlOg0KPiA+ID4+IEZyb206IFNyaXJhbSBZYWduYXJhbWFuIDxzcmly
YW0ueWFnbmFyYW1hbkBlc3QudGVjaD4NCj4gPiA+Pg0KPiA+ID4+IEFkZCB0aGUgZm9sbG93aW5n
IHJpbmcgZmxhZzoNCj4gPiA+PiAtIElHQl9SSU5HX0ZMQUdfVFhfRElTQUJMRUQgKHdoZW4geHNr
IHBvb2wgaXMgYmVpbmcgc2V0dXApDQo+ID4gPj4NCj4gPiA+PiBBZGQgYSB4ZHBfYnVmZiBhcnJh
eSBmb3IgdXNlIHdpdGggWFNLIHJlY2VpdmUgYmF0Y2ggQVBJLCBhbmQgYQ0KPiA+ID4+IHBvaW50
ZXIgdG8geHNrX3Bvb2wgaW4gaWdiX2FkYXB0ZXIuDQo+ID4gPj4NCj4gPiA+PiBBZGQgZW5hYmxl
L2Rpc2FibGUgZnVuY3Rpb25zIGZvciBUWCBhbmQgUlggcmluZ3MuDQo+ID4gPj4gQWRkIGVuYWJs
ZS9kaXNhYmxlIGZ1bmN0aW9ucyBmb3IgWFNLIHBvb2wuDQo+ID4gPj4gQWRkIHhzayB3YWtldXAg
ZnVuY3Rpb24uDQo+ID4gPj4NCj4gPiA+PiBOb25lIG9mIHRoZSBhYm92ZSBmdW5jdGlvbmFsaXR5
IHdpbGwgYmUgYWN0aXZlIHVudGlsDQo+ID4gPj4gTkVUREVWX1hEUF9BQ1RfWFNLX1pFUk9DT1BZ
IGlzIGFkdmVydGlzZWQgaW4gbmV0ZGV2LQ0KPiA+eGRwX2ZlYXR1cmVzLg0KPiA+ID4+DQo+ID4g
Pj4gU2lnbmVkLW9mZi1ieTogU3JpcmFtIFlhZ25hcmFtYW4gPHNyaXJhbS55YWduYXJhbWFuQGVz
dC50ZWNoPg0KPiA+ID4NCj4gPiA+IFNyaXJhbSdzIG1haWwgYm91bmNlcyB1bmZvcnR1bmF0ZWx5
LCBpcyBpdCBwb3NzaWJsZSB0byBncmFiIGhpcw0KPiA+ID4gY3VycmVudCBhZGRyZXNzPw0KPiA+
DQo+ID4gSGlzIGN1cnJlbnQgZW1haWwgYWRkcmVzcyBpcyBpbiB0aGUgQ2MgbGlzdC4gSG93ZXZl
ciwgaSB3YXNuJ3Qgc3VyZSBpZg0KPiA+IGl0J3Mgb2theSB0byB1cGRhdGUgdGhlIEZyb20gYW5k
IFNvQiBvZiB0aGVzZSBwYXRjaGVzPw0KPg0KPiBPa2F5LiBUaGVuIEkgYmVsaWV2ZSBTcmlyYW0g
c2hvdWxkIHByb3ZpZGUgYSBtYWlsbWFwIGVudHJ5IHRvIG1hcCBoaXMgb2xkDQo+IG1haWwgdG8g
YSBuZXcgb25lLg0KDQpQbGVhc2UgZmVlbCBmcmVlIHRvIHJlbW92ZSBteSAiZXN0LnRlY2giIGFk
ZHJlc3MgZnJvbSBGcm9tOiBhbmQgU2lnbmVkLW9mLUJ5Og0KSSBhbSBqdXN0IGdsYWQgdGhhdCBt
eSB3b3JrIGhhcyBub3QgZ29uZSB0byB3YXN0ZS4gVGhhbmsgeW91IGZvciB0aGF0Lg0KSSB3aWxs
IGNoZWNrIHdpdGggbXkgY29tcGFueSdzICpsYXd5ZXJzKiB0byBzZWUgaWYgSSBjYW4gcHJvdmlk
ZSBhIG1haWxtYXAgdG8gbXkgY3VycmVudCBhZGRyZXNzIDooDQoNCj4NCj4gPg0KPiA+ID4NCj4g
PiA+IFlvdSBjb3VsZCBhbHNvIHVwZGF0ZSB0aGUgY29weXJpZ2h0IGRhdGUgaW4gaWdiX3hzay5j
Lg0KPiA+DQo+ID4gRGl0dG8gZm9yIHRoZSBjb3B5cmlnaHQuIEl0IHByb2JhYmx5IGhhcyB0byBi
ZSBzb21ldGhpbmcgbGlrZQ0KPiA+IENvcHlyaWdodChjKSAyMDIzIEVyaWNzc29uPw0KPg0KPiBJ
dCBzYXlzIDIwMTggSW50ZWwuIEkgZG9uJ3QgdGhpbmsgU3JpcmFtIHdhcyB3b3JraW5nIHVuZGVy
IEUvLy8gZW1wbG95bWVudCBhcw0KPiBoZSBzYWlkIGhlIHdhcyBmb3JiaWRkZW4gdG8gd29yayBv
biB0aGlzIGZ1cnRoZXIgYW5kIHRoYXQncyB3aHkgeW91IHBpY2tlZCBpdA0KPiB1cCwgcmlnaHQ/
DQo+DQo+IE15IGludGVudCB3YXMgbm90IHN0aXIgdXAgdGhlIGNvcHlyaWdodCBwb3QsIHRob3Vn
aC4gSXQgY2FuIGJlIGxlZnQgYXMtaXMgb3IgaGF2ZQ0KPiBzb21ldGhpbmcgb2YgYSBMaW51dHJv
bml4L1NyaXJhbSBZYWduYW1hcmFuIG1peCA6UA0KPg0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IEt1
cnQNCj4NCg0K

