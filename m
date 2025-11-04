Return-Path: <bpf+bounces-73444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B05C31854
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 15:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 821F73BBF21
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 14:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CC232D7F4;
	Tue,  4 Nov 2025 14:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nextron-systems.com header.i=@nextron-systems.com header.b="lPRDtuta"
X-Original-To: bpf@vger.kernel.org
Received: from BEUP281CU002.outbound.protection.outlook.com (mail-germanynorthazon11020134.outbound.protection.outlook.com [52.101.169.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51AE1865FA
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 14:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.169.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762266421; cv=fail; b=dsaQMldA0DcOeKar09bMjpfgECzQ0T4YFk8R+LO23KA5nYOSEr5WR4A5OfZrnEYJnMW99vjWbHcD1ec3wtBf+TqNDA+sdhjQHBj1glu1ZRmaJGWS1HhKnhqHd6W/rfFFHMBVroNlF6NPsLfWUV4Pq7nKnPG6YcGEBjyJvImUhYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762266421; c=relaxed/simple;
	bh=fJQCZYMzSFAtnvxs7IRbcPwk1j4we18Xo0tJgiBnNCw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MHfL4vvYjP5BVYch2daoLwo3JGpszyztUDPglM56mD9hjg4VhpYdQGtYr8L7DPCPvLjTwxRA16VLMi4DaSLgS394JzHmODHKiSW18dpRmJpZhvHSxN3Aq0LO8LBBMDcgzD1DcZLzmECD0xrjk61I8ikM8W+YP3Na7wZg/MCzO6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nextron-systems.com; spf=pass smtp.mailfrom=nextron-systems.com; dkim=pass (2048-bit key) header.d=nextron-systems.com header.i=@nextron-systems.com header.b=lPRDtuta; arc=fail smtp.client-ip=52.101.169.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nextron-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nextron-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtRkfyEKfzEfDOCTksRZgy+MJ7shPQWN5dE+/4h/1NFcvU60JtpCbuSKkjFrQp2HElZ5f5lYkXTeXfSrOkbkYcZDhJrI4KGvoqumpQnSMkDX7fyET4oDgmrmumvYLQ12xB1F9JYu57dbkBFRDrv9wg4j+aFa1DQ2Zy8yW9YQsTkiOuQVS3A2tt0c2nhEFZCmarrzMKXJP453mXf1Eeo4P4Pbfx724VnF1B7awr3NhidqP8GjPN1/TmZb8WsDNWOIdQkHs8XkAnT9Vjs/IXm2uuRSrbFRW03yUx5Y8Qt4oWfr0Uiv2ege6XqzG4t4elSJq1bljG3hjaIFhFWe2ag/7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmzxIzfYSh2P06U+QOj67lWNn9ys820NoMQCcQ6MnxI=;
 b=O2EBNn8GjMP2S2240KspxClRN1v4/sl6tapbBDdDJtKTlHg1Db+q7cf/X8MqzGozeIpU5iR9OtF6TC1kc8I8zswXjA6n1pI96zWocLhIO68ukb5Ib3OrY2FPKiGmU9oMA2hyuzCZ+nUiAPNZX8jwRAt865QXoYPRHJMQgeILAmvk5cFelZOKocKSpkatUsgFaxu66tGlP14LX3kBCFZ0pTIBMB1/QJAG1WxL2DG0MSZi/tEiJJ7Ic0ss/0+B5CrA73f4ZpZqdUY0c1ThIMoGvdsnV90USEsKqo0jV3SPKwIKkS0TlgpAL5eKWOb/wUCe5ncmIE7MlYdYZ6FNzdssGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nextron-systems.com; dmarc=pass action=none
 header.from=nextron-systems.com; dkim=pass header.d=nextron-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nextron-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmzxIzfYSh2P06U+QOj67lWNn9ys820NoMQCcQ6MnxI=;
 b=lPRDtutaSR72U+8Qn0itgP0AVkHl8r8MS3hcUljZ19SvWIXwXVCgxXDNxgwSC7kygSgZWy9gD1JD0+s3f1Oe4KSR/Me9TAPo+ZzQk+ycZMMPjJ7zM4QKyMVCGbzM+eNeA7dyonm0BPVQO1b1elzfMej0fi4J2KyZvQJksYennM7x3KIpRytaDLUYQEhEy1MAMpglRx8a52AqghkKpebRNeXb3+kBL915Rv/x4NI+h87/zWCK3TFh3KyEAuRYJ8Df8n4/VUVOXFKXvNipBhLoclvyxFllXustpGR/lFRLFhfXpLTF0hb1OkLST57gmtKbnMG5WjNdeBhvunp2XpcjnA==
Received: from FR3P281MB3261.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:5c::9) by
 FR3PPFBB50ACF7C.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::188) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 14:26:56 +0000
Received: from FR3P281MB3261.DEUP281.PROD.OUTLOOK.COM
 ([fe80::4c9b:2ac1:650d:b0fe]) by FR3P281MB3261.DEUP281.PROD.OUTLOOK.COM
 ([fe80::4c9b:2ac1:650d:b0fe%5]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 14:26:56 +0000
From: "Altgelt, Max (Nextron)" <max.altgelt@nextron-systems.com>
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf] bpf: don't skip other information if xlated_prog_insns is
 skipped
Thread-Topic: [PATCH bpf] bpf: don't skip other information if
 xlated_prog_insns is skipped
Thread-Index: AQHcTZcSNjfvFLjJJUuXklubq0qkZw==
Date: Tue, 4 Nov 2025 14:26:56 +0000
Message-ID:
 <efd00fcec5e3e247af551632726e2a90c105fbd8.camel@nextron-systems.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nextron-systems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB3261:EE_|FR3PPFBB50ACF7C:EE_
x-ms-office365-filtering-correlation-id: c2940adc-d02a-4d10-baae-08de1bae3508
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|4053099003;
x-microsoft-antispam-message-info:
 =?utf-8?B?dytzRzA2dWQ2Z092OTBwcjRSR2tnQURZN1VGOXM0WUErak1lSXFrd2Z0UmFD?=
 =?utf-8?B?eTFqL3FRL09SSFRwd2tsMkRVWUlyT2EyTnJkUHBTdFFQM21INzBCRVZKUUYy?=
 =?utf-8?B?V0VhVmhNZ2FwQVE3bFBBMEtSY3J0ZE5zemQvY2JmRkExTlZWREZZQkFkZTFy?=
 =?utf-8?B?Mm85dGdsbDUwRDFYNEVnL3g4Zk80eUVrakJ1Rnp4ZzI3ZisrRmwxZjJmUzZm?=
 =?utf-8?B?NnpFUDBPZk42MWdyUFZwYkp1WE1GN0R2V0dTczdXbHBLbVFLNnE1VU52Q0F4?=
 =?utf-8?B?U285M2JYRWJKWHZ6L0FzNWsxQ3ZpQzR4S1RCTUx0clhFa1ZSQzQ4VzNwdUV6?=
 =?utf-8?B?V21WT2liSVdQT0xkWjJlU1FGY2JYNmpNOXBEck9KU2Ntd0k2dGcrbEg0S3or?=
 =?utf-8?B?L1o2TUVrcFVxZEZCbGNiczcwUEgwNTcybU1SVXJGQTRLVGl4WURWNXFCMzNm?=
 =?utf-8?B?cUpBYkdrU08yS2xvc05qaGw2OS9rVGQrQnRhMTYxc3RIUGN1MkF0UTNteFEv?=
 =?utf-8?B?eTF1MnlWbUFGOFJnMWFHVVJndFd2QzJxZWtIOGFtc0NJbk90YWVBa0Y1WHdH?=
 =?utf-8?B?WEd0d2lUNklCbXduV2QrWmhkVXNHVGpUaFZPRnQrTDh4T082M3FKZ285OE5T?=
 =?utf-8?B?aHZyTzdidTdyc2pXeFE3Ty9zWmVhTVFHSXJlR205cGF4UTZmT1Rkbm5tNE1l?=
 =?utf-8?B?MWdsd1RSVFRPblRISllGY3hJV1VDc3NPSlNTMy9qaFNSQ1ZLdmFWd25TSWxh?=
 =?utf-8?B?b1MvTHA1TzYrem1OWGdEanpWVnBoUjZYano1aWNlcGlwTmRSdXZYbnp5YkpI?=
 =?utf-8?B?Z3RlYU5abVlrMW1RYXgwM29kOXpQMTJDTGFGQ3FUL1Vhc2pMUENES2ppUnpq?=
 =?utf-8?B?ZllDcHNJcWhyVG12QXFXVS91cGp6ZkRhWDVnaWl5SWVKZTQ2TmJJbExpZnVR?=
 =?utf-8?B?Nlc5dzA1NXhQWkV3ZS8xQ1k3ZGx4T2tad2VjcElsZEV4ZzN6U3JrUTMrNUxG?=
 =?utf-8?B?RVZkWWIvMGpPV0hheVVXdnZQRS9Fc0FIaDNKZGxnZnIwaHlRbTBjN1NJWXJZ?=
 =?utf-8?B?NHhmZFpMNjNCYS9JbE5PSTI3TGVZSEROOWFJT2J4WFNtZlNYc0dEUFV6TlB1?=
 =?utf-8?B?dUtMdWZockovWExpMldENmk5cUhmRUhka1VtelBRN3FDam15N3BNMzRCOFVP?=
 =?utf-8?B?RGNGaWRxNHJVWklubmRPeXFsUFBiWFpJUi9raW13RGZJT1RRR0oyREFBcmg3?=
 =?utf-8?B?bmZZK0FtYXdVOTFwalpjK0VhdldxdDJuRDQ4V05FTGU4cVM1WG1DQkFZaWM5?=
 =?utf-8?B?VFNsaDFubS9LZ05zZ2pvQ2dIUExraFBRcElydE1lbVIrS1Arekg0ZFJnYnIx?=
 =?utf-8?B?cEd3Q1FnUmhiS1dlNzlGWGRQa2Q4VTB6V2trVWJKWWYvUDhZcXdYQ1NGWDBj?=
 =?utf-8?B?MElCUUxGRE5PMExLYjFxMlg0Y3NjQkVBNXJWT2NqQ3JiQXRaSmI2eTFSRmU1?=
 =?utf-8?B?Y296UGNQaTJGMEcwRTdVd3VXU05SVWdsTERPeHNmOWk4dytSeDMxcXFNVHh5?=
 =?utf-8?B?a29EYVBFTVI5cm9JV3ZNQWkrNy9wT2lIZXV0dDZ5aHdlMmJmbkxUMEx3QzdH?=
 =?utf-8?B?RVVSaGhCMytnWElUL0Z2c1R3YTJOWmRORGszVkY0ZWtFQk9GeWN0UDJjbXRZ?=
 =?utf-8?B?U3QyNlZTNUlPK2hFdjZaVHFiaElNTjFzNnpQQ05NaW4yOHo5OHdMWUJMR3By?=
 =?utf-8?B?dzhkQmxkenpVMFpiV01TZHFQYlhzejlONVFHSEVvS2dyMGFmRzI1UFNPSDVZ?=
 =?utf-8?B?S1pwV256MzJHbm9iWVlwQ21YYjN5TkNIZ1pCUEFMdDJ0VERrdTlMQnNsK040?=
 =?utf-8?B?QXFPd2F1WHo2eXRWNHJGcS9yTUI0Ni9mWllNKy8waEZDY1I1WjV0d1FmZzJK?=
 =?utf-8?B?RUFkWG0ycFlPS0NYWE1OV2M1QkprNzNvbHJyRkp1THFrcUlSK0VmWVJSVW44?=
 =?utf-8?B?WjVKeVROdWlXQVZQcTI3dlZrTUx5bk42d2FpZ2NCL3RhVGhHa3lyRGtBNE9Q?=
 =?utf-8?Q?T3M+EE?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB3261.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZFJ4MGNRYzErSUNZWHFaNU43Z1ZxdVZXVlMvdkdoQ1d6UlpnQmREY3g1Vytz?=
 =?utf-8?B?ckJPMWdLa3FFQzNyVzhXQjBiWDZXNVYyajhlOXJtbkRQeXk2WkNZWFp4T3By?=
 =?utf-8?B?eUNockZFUUVHbzU1elVRY3JhcDlZVE1Kcjg4OUNqMHZZenNqZlgzY3g2Ui9V?=
 =?utf-8?B?OEJIQS9BdnlkNFM3R05udmlkTUFRc3g5UUtLK0RZWGplYnBYR2hzV0gyQS8x?=
 =?utf-8?B?ZUQ4ZmorQnNDOFhUNkp3V2dZay9qaVRQei9GL1pqYk8vdStoZEgzTjQxS1Rs?=
 =?utf-8?B?RjJiQU5veHFma3N6VnA3WlpDWTg1c0h3WFY3ZGtMaTZjS1drQ2pLQzl3MU5R?=
 =?utf-8?B?ZnFveERyaU0xdC8wbTBmVzloUzlsbVlKenVHdnoyTjhTc2hsby9CSzlPWGlN?=
 =?utf-8?B?U0pWY2U5Qk5IQnBmaFp4bGxtMlJSTit5UG1Hck43WU9kcnl2eHd1aXBqaXNi?=
 =?utf-8?B?Z0x2RjBuOWE4RWRSNlQxQlRIMGNzWG1Td3JTbnkzQ29jc0VIK1JYT1E4cWZR?=
 =?utf-8?B?TE0zcWlmK0I0YldHQ3ZsNUdaMDR5SVh5SWJnTklHTTJ1VjR0S1A1NE1oUzFE?=
 =?utf-8?B?T0hyRzhVUkZYdGFCckF0NWdnbFlVRnArZ0diVzljWmRmM2FCekpqZm5VOVF6?=
 =?utf-8?B?eFdPbW40RmJZSndOZzZULys2WHNTSXFVWG9kRlVLYmhWeHhPaFZLaDVkQmVv?=
 =?utf-8?B?VDRHenNtQVc5dHltQmFCMVVVOWljbG9SaVZpRERZS0U3eFdyaFpySHJ2Qms2?=
 =?utf-8?B?dFlQWEFTZmthOHYzQ01GMU5HMUxOMG5IZXdCeEFkSjgwdkcyc2doV3ZDQndY?=
 =?utf-8?B?aEU1eTNFbjVuczdTdWVnNVQrbm51eWtlWE5odTZNOXJjQnpoR1VteHRLSzFw?=
 =?utf-8?B?TldvVEQvOWhDMU4vM3B5RHVkM3BuN0Vyams1Ymd2R3AvdzgvT2VEUEp0UHRT?=
 =?utf-8?B?RGh2dFdvRkF5czFPcnBsSW9XK1ByVEhVMVI1ZXR4K3JjQ1hEdXVhVmtUcHlv?=
 =?utf-8?B?dTUyVS9LVUZsNmVvZ2Z4Mm9rSk5TcUxvdUNtYk8zNUJ0S216b0FTd2xoc0Fn?=
 =?utf-8?B?bjZLNG95aFpyblNzYWppMHozSjFNUEw0ajZJMEhkeTRIUjVNQ0FmcER4QVN1?=
 =?utf-8?B?aGhTMzhGZTFxcm5zQkVsYzVjVFNqTnVhQmhYdm0vVHBucGJ4VmxDdUpra3RS?=
 =?utf-8?B?TEkvZXF1NlRzTWtsbGpFSHBqU1g2WGJ6NGNQUzNUazhkMHQxRW50cktYcE8y?=
 =?utf-8?B?eWFJaG1weUN3dTF2dHZIMEhhVEZMVXVVQkxCNktUTkcyQVdkKzVDeFRSV3Fm?=
 =?utf-8?B?U0U0YVBkampZK1RqTmlCMXJKSitQL1AySkJtVzlsQUR3SFlkbHlOaWU1UStJ?=
 =?utf-8?B?dnpoSFJnYThXa0c1MkJWY09vdXpUNnhhR0pEcE1qOWdjUG02MS9zOE1XRUhT?=
 =?utf-8?B?SHQyOElEREVqSDJpbzZyRXlkSWRjL00zNjF2NWVWcjJ6THRLbEhjdlhjVk1E?=
 =?utf-8?B?T0p1cGdTZEFUSG1hSVVPdnlOUWM2di9OVTNlejdxT1EzVEluMXVranl4cFEr?=
 =?utf-8?B?a2dQZ2pxOGxNdE1EdGdFRUZRV3ZsZ2VzUnZPaG4yTEU2RGtmQ3ZnTnlUaXRR?=
 =?utf-8?B?ZmJLV1QvYmU2TlIycTBnSzNWaUdGOFZ6N1oxTGE1bUNhMUhiUFVjNVVvcUY4?=
 =?utf-8?B?V09FR0NFL0dveDZvWi9rdVh3R3BMbDN6SUc0OCs1ZHRZRmw4MHNkMU1MV0Jn?=
 =?utf-8?B?V3BrY0FMb0N1Q3R2Ynd6RDhKMEVvem5lUEpELzlvVmpGV2NYbHdhZFJIeDlD?=
 =?utf-8?B?M21GWTBvdENreEVaVTNDR1BEY1ZJQWZzY01zYmszS3drREtmWnpHWURzVWFs?=
 =?utf-8?B?aFkwM1RUdkpzOFdmVGtVN1dOdzhGQ2RValpBUXczYjF5ZHF1UHA2aks2NlBU?=
 =?utf-8?B?cVNOSmFkd1owWERoY0xWOGovZ3pkSWt6ZmFmTkovZjB1L0g4U0ZQcVBwc1Nj?=
 =?utf-8?B?bEVKb3d3L05tUmdkNzJVN1JPWVRqdm9LVFRIbkNRaS9KN0NpcDNLalphb0xG?=
 =?utf-8?B?bFV0NXF5R0FrbndhWGRtSzBQa1N3UDdjQklxUmFxb0s3SDI4YWtRRXhnSUtD?=
 =?utf-8?B?dWFVZTczU2U3dWlma2p0QkFXRWo3V05BNzFTa2QyeXBnM05pWWVNRjBIZElR?=
 =?utf-8?Q?AhVwEC1a8hkxXu6YbQZ73s4=3D?=
Content-Type: multipart/signed; micalg=sha-256;
	protocol="application/pkcs7-signature"; boundary="=-GslGxmFo8w05lrxKrWOH"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nextron-systems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB3261.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c2940adc-d02a-4d10-baae-08de1bae3508
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 14:26:56.1164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e2636294-1b72-4afa-9152-75b8e76171c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9EQQ2PzGAkJtviLKP9DVh/YRRnCy/c4b5PysThpwrANjhNhTzYU3nzyifKC3pwJyX0amTzVehaf4RUqrWdf8/1DKkgHrUcvNFoMoR6ii3ko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3PPFBB50ACF7C

--=-GslGxmFo8w05lrxKrWOH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

If xlated_prog_insns should not be exposed, other information
(such as func_info) still can and should be filled in.
Therefore, instead of directly terminating in this case,
continue with the normal flow.

Signed-off-by: Max Altgelt <max.altgelt@nextron-systems.com>
---
 kernel/bpf/syscall.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8a129746bd6c..5a0dc3ad2eeb 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5034,19 +5034,19 @@ static int bpf_prog_get_info_by_fd(struct file *fil=
e,
 		struct bpf_insn *insns_sanitized;
 		bool fault;
=20
-		if (prog->blinded && !bpf_dump_raw_ok(file->f_cred)) {
+		if (!prog->blinded || bpf_dump_raw_ok(file->f_cred)) {
+			insns_sanitized =3D bpf_insn_prepare_dump(prog, file->f_cred);
+			if (!insns_sanitized)
+				return -ENOMEM;
+			uinsns =3D u64_to_user_ptr(info.xlated_prog_insns);
+			ulen =3D min_t(u32, info.xlated_prog_len, ulen);
+			fault =3D copy_to_user(uinsns, insns_sanitized, ulen);
+			kfree(insns_sanitized);
+			if (fault)
+				return -EFAULT;
+		} else {
 			info.xlated_prog_insns =3D 0;
-			goto done;
 		}
-		insns_sanitized =3D bpf_insn_prepare_dump(prog, file->f_cred);
-		if (!insns_sanitized)
-			return -ENOMEM;
-		uinsns =3D u64_to_user_ptr(info.xlated_prog_insns);
-		ulen =3D min_t(u32, info.xlated_prog_len, ulen);
-		fault =3D copy_to_user(uinsns, insns_sanitized, ulen);
-		kfree(insns_sanitized);
-		if (fault)
-			return -EFAULT;
 	}
=20
 	if (bpf_prog_is_offloaded(prog->aux)) {
--=20

--=-GslGxmFo8w05lrxKrWOH
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCD7Iw
ggfVMIIFvaADAgECAgFZMA0GCSqGSIb3DQEBCwUAMIG/MQswCQYDVQQGEwJERTEPMA0GA1UECBMG
SGVzc2VuMRQwEgYDVQQHEwtEaWV0emVuYmFjaDEdMBsGA1UEChMUTmV4dHJvbiBTeXN0ZW1zIEdt
YkgxFDASBgNVBAsTC1NlY3VyaXR5IElUMSswKQYDVQQDFCJORVhUUk9OX1NZU1RFTVNfR01CSF9F
TUFJTF9ST09UX0NBMScwJQYJKoZIhvcNAQkBFhhpbmZvQG5leHRyb24tc3lzdGVtcy5jb20wHhcN
MjUwMTMxMTAxNjUyWhcNMjkwNDIzMTAxNjUyWjCBwDELMAkGA1UEBhMCREUxCzAJBgNVBAgTAkhF
MRQwEgYDVQQHEwtEaWV0emVuYmFjaDEdMBsGA1UEChMUTmV4dHJvbiBTeXN0ZW1zIEdtYkgxFTAT
BgNVBAsTDCBTZWN1cml0eSBJVDEoMCYGA1UEAxQfbWF4LmFsdGdlbHRAbmV4dHJvbi1zeXN0ZW1z
LmNvbTEuMCwGCSqGSIb3DQEJARYfbWF4LmFsdGdlbHRAbmV4dHJvbi1zeXN0ZW1zLmNvbTCCAiIw
DQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBANBQZwfpGcPWK5tEqopGv7gXIqEn8rqUk3FluWeM
kbDKkKzORZjc2s5NeNu9Htif87fyxy5jKqXcwRluhN07fsE8t9TMotl6e4e7r9FL9QupkGl0iuDJ
pDsWAtNrH4QV1wDBfcCRtpLiKBe5WqwyxfUhmG8WcB9rHvBLRCSwxqeKdhsSxR6avkndgkXFhQez
F2UhckEB8VxuD+CQlmIskGRbyg3kOvzFq54BzBQOhWn4iSxVTCXoj7WrgCV4XM+T0sEmmklrm1ea
GUARXBd12gypn44LfujNEYIHPJNJ2hdhw23a0/N20r/dNMwP3ia1DOhAbiG2TIyNawh+uGlQmQAR
LXcaH+HVuSoxX5fYlKX9lWyn/77Dxh1+civx/Ixru06LpV5A12mM2GuJKegTiKuMjEdqOZj6LBIv
WStFFAiiepy1jhsQm4+P0bOhanjCSbuFxUp838Vk+w8Gyt/6pGGs4dQwBXyRc3+GZjVuHAdcVX2q
nwyL8rT8YqoHp218fnUROAvIrDKtTlK88PJ8I9Hh+8IjJL5ewhQia5/2kc2W07b8GkmuBV4DRX7T
Uk0zgE19jaSiQLlS+wb1rCyMcDmnZOLnT+m4iWnfll1YuTGgy2VkXKgWkNc4FCNNM+0Brkg//7yZ
H4/VJ0U9OguOfzgMOHN8z9FyqFP7U22KymtLAgMBAAGjggHXMIIB0zAJBgNVHRMEAjAAMBEGCWCG
SAGG+EIBAQQEAwIEsDA8BglghkgBhvhCAQ0ELxYtQ2VydGlmaWNhdGUgZ2VuZXJhdGVkIGJ5IE5l
eHRyb24gU3lzdGVtcyBHbWJIMB0GA1UdDgQWBBSo9gQja30RqgCHrIpyPzuwJSFP/DCB9AYDVR0j
BIHsMIHpgBQl8bGvEBkhVTn+m8l7fL3EOjrot6GBxaSBwjCBvzELMAkGA1UEBhMCREUxDzANBgNV
BAgTBkhlc3NlbjEUMBIGA1UEBxMLRGlldHplbmJhY2gxHTAbBgNVBAoTFE5leHRyb24gU3lzdGVt
cyBHbWJIMRQwEgYDVQQLEwtTZWN1cml0eSBJVDErMCkGA1UEAxQiTkVYVFJPTl9TWVNURU1TX0dN
QkhfRU1BSUxfUk9PVF9DQTEnMCUGCSqGSIb3DQEJARYYaW5mb0BuZXh0cm9uLXN5c3RlbXMuY29t
ggkA2eXUTHFjRpkwIwYDVR0SBBwwGoEYaW5mb0BuZXh0cm9uLXN5c3RlbXMuY29tMCoGA1UdEQQj
MCGBH21heC5hbHRnZWx0QG5leHRyb24tc3lzdGVtcy5jb20wDgYDVR0PAQH/BAQDAgWgMA0GCSqG
SIb3DQEBCwUAA4ICAQCDLp3G97uq0FLDD1Dm+vx75AxJaD3mlpKHfy0TC+pZSxPjM+KFujx+atXe
1kqDfvmjy3i0iBinLVZ72jfouHH9ZahfS1mZeCoR5L66Lc+xPTFW2oR4oXXrkzZxdfvzcSz7fXtw
ffthOoEhcAfSbemskEt+KpyQINceHRD/XDRoJF3e0t1eRApU29dmu43BSomjBhBE2SX6A4J2nnIq
B/javcFpJYHeQvi54z2YTzN0ndWfi4EXpxKyZC78Z3Hci0qAjHmLSlcz86OBnjex6PMu0vIpnajK
Xki8ItLrf1uhe3CjM3zem6tu3Cioun5mFdug/0ni/fYzedgfIGxQzQWMmGqZ+VHeHzSla+cG+9yv
9v9hGYulttSujOGNckStyABuGe/k/6tEHjgccSLFXXfJ/uSo1zL4dGehS218lrBN7C4Vi7DeaeJ8
xIwnASCz9L4JK22A1w9WZbaNHnsPhXUiUy1VqHNXPN3+OOJlV6ddipqKsErvk5CqNiND7mE5ZUaB
Z7zUs8pTyTy/GNq5gXbv8bfLa443CHfteQNkJWnlokbEp9dPIuXbeLBBI0OzdBYMOzy8VD2rUwyG
hAfioYSPGPJ74GwsHfb1/MBqEdBLJrDYlvvV6nBSLIal/fIiGteFg0iCkDc0QAPA44ZLuqPWVBLu
LddJqZcM8zf8Kc1WGDCCB9UwggW9oAMCAQICAVkwDQYJKoZIhvcNAQELBQAwgb8xCzAJBgNVBAYT
AkRFMQ8wDQYDVQQIEwZIZXNzZW4xFDASBgNVBAcTC0RpZXR6ZW5iYWNoMR0wGwYDVQQKExROZXh0
cm9uIFN5c3RlbXMgR21iSDEUMBIGA1UECxMLU2VjdXJpdHkgSVQxKzApBgNVBAMUIk5FWFRST05f
U1lTVEVNU19HTUJIX0VNQUlMX1JPT1RfQ0ExJzAlBgkqhkiG9w0BCQEWGGluZm9AbmV4dHJvbi1z
eXN0ZW1zLmNvbTAeFw0yNTAxMzExMDE2NTJaFw0yOTA0MjMxMDE2NTJaMIHAMQswCQYDVQQGEwJE
RTELMAkGA1UECBMCSEUxFDASBgNVBAcTC0RpZXR6ZW5iYWNoMR0wGwYDVQQKExROZXh0cm9uIFN5
c3RlbXMgR21iSDEVMBMGA1UECxMMIFNlY3VyaXR5IElUMSgwJgYDVQQDFB9tYXguYWx0Z2VsdEBu
ZXh0cm9uLXN5c3RlbXMuY29tMS4wLAYJKoZIhvcNAQkBFh9tYXguYWx0Z2VsdEBuZXh0cm9uLXN5
c3RlbXMuY29tMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA0FBnB+kZw9Yrm0Sqika/
uBcioSfyupSTcWW5Z4yRsMqQrM5FmNzazk14270e2J/zt/LHLmMqpdzBGW6E3Tt+wTy31Myi2Xp7
h7uv0Uv1C6mQaXSK4MmkOxYC02sfhBXXAMF9wJG2kuIoF7larDLF9SGYbxZwH2se8EtEJLDGp4p2
GxLFHpq+Sd2CRcWFB7MXZSFyQQHxXG4P4JCWYiyQZFvKDeQ6/MWrngHMFA6FafiJLFVMJeiPtauA
JXhcz5PSwSaaSWubV5oZQBFcF3XaDKmfjgt+6M0Rggc8k0naF2HDbdrT83bSv900zA/eJrUM6EBu
IbZMjI1rCH64aVCZABEtdxof4dW5KjFfl9iUpf2VbKf/vsPGHX5yK/H8jGu7ToulXkDXaYzYa4kp
6BOIq4yMR2o5mPosEi9ZK0UUCKJ6nLWOGxCbj4/Rs6FqeMJJu4XFSnzfxWT7DwbK3/qkYazh1DAF
fJFzf4ZmNW4cB1xVfaqfDIvytPxiqgenbXx+dRE4C8isMq1OUrzw8nwj0eH7wiMkvl7CFCJrn/aR
zZbTtvwaSa4FXgNFftNSTTOATX2NpKJAuVL7BvWsLIxwOadk4udP6biJad+WXVi5MaDLZWRcqBaQ
1zgUI00z7QGuSD//vJkfj9UnRT06C45/OAw4c3zP0XKoU/tTbYrKa0sCAwEAAaOCAdcwggHTMAkG
A1UdEwQCMAAwEQYJYIZIAYb4QgEBBAQDAgSwMDwGCWCGSAGG+EIBDQQvFi1DZXJ0aWZpY2F0ZSBn
ZW5lcmF0ZWQgYnkgTmV4dHJvbiBTeXN0ZW1zIEdtYkgwHQYDVR0OBBYEFKj2BCNrfRGqAIesinI/
O7AlIU/8MIH0BgNVHSMEgewwgemAFCXxsa8QGSFVOf6byXt8vcQ6Oui3oYHFpIHCMIG/MQswCQYD
VQQGEwJERTEPMA0GA1UECBMGSGVzc2VuMRQwEgYDVQQHEwtEaWV0emVuYmFjaDEdMBsGA1UEChMU
TmV4dHJvbiBTeXN0ZW1zIEdtYkgxFDASBgNVBAsTC1NlY3VyaXR5IElUMSswKQYDVQQDFCJORVhU
Uk9OX1NZU1RFTVNfR01CSF9FTUFJTF9ST09UX0NBMScwJQYJKoZIhvcNAQkBFhhpbmZvQG5leHRy
b24tc3lzdGVtcy5jb22CCQDZ5dRMcWNGmTAjBgNVHRIEHDAagRhpbmZvQG5leHRyb24tc3lzdGVt
cy5jb20wKgYDVR0RBCMwIYEfbWF4LmFsdGdlbHRAbmV4dHJvbi1zeXN0ZW1zLmNvbTAOBgNVHQ8B
Af8EBAMCBaAwDQYJKoZIhvcNAQELBQADggIBAIMuncb3u6rQUsMPUOb6/HvkDEloPeaWkod/LRML
6llLE+Mz4oW6PH5q1d7WSoN++aPLeLSIGKctVnvaN+i4cf1lqF9LWZl4KhHkvrotz7E9MVbahHih
deuTNnF1+/NxLPt9e3B9+2E6gSFwB9Jt6ayQS34qnJAg1x4dEP9cNGgkXd7S3V5EClTb12a7jcFK
iaMGEETZJfoDgnaecioH+Nq9wWklgd5C+LnjPZhPM3Sd1Z+LgRenErJkLvxncdyLSoCMeYtKVzPz
o4GeN7Ho8y7S8imdqMpeSLwi0ut/W6F7cKMzfN6bq27cKKi6fmYV26D/SeL99jN52B8gbFDNBYyY
apn5Ud4fNKVr5wb73K/2/2EZi6W21K6M4Y1yRK3IAG4Z7+T/q0QeOBxxIsVdd8n+5KjXMvh0Z6FL
bXyWsE3sLhWLsN5p4nzEjCcBILP0vgkrbYDXD1Zlto0eew+FdSJTLVWoc1c83f444mVXp12Kmoqw
Su+TkKo2I0PuYTllRoFnvNSzylPJPL8Y2rmBdu/xt8trjjcId+15A2QlaeWiRsSn108i5dt4sEEj
Q7N0Fgw7PLxUPatTDIaEB+KhhI8Y8nvgbCwd9vX8wGoR0EsmsNiW+9XqcFIshqX98iIa14WDSIKQ
NzRAA8Djhku6o9ZUEu4t10mplwzzN/wpzVYYMYIFEjCCBQ4CAQEwgcUwgb8xCzAJBgNVBAYTAkRF
MQ8wDQYDVQQIEwZIZXNzZW4xFDASBgNVBAcTC0RpZXR6ZW5iYWNoMR0wGwYDVQQKExROZXh0cm9u
IFN5c3RlbXMgR21iSDEUMBIGA1UECxMLU2VjdXJpdHkgSVQxKzApBgNVBAMUIk5FWFRST05fU1lT
VEVNU19HTUJIX0VNQUlMX1JPT1RfQ0ExJzAlBgkqhkiG9w0BCQEWGGluZm9AbmV4dHJvbi1zeXN0
ZW1zLmNvbQIBWTANBglghkgBZQMEAgEFAKCCAh0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAc
BgkqhkiG9w0BCQUxDxcNMjUxMTA0MTQyNjU1WjAvBgkqhkiG9w0BCQQxIgQgw81rw1pVuUIPLLhH
qqavSgNdJ5bq40BHZKTEuCl7Ru0wgdYGCSsGAQQBgjcQBDGByDCBxTCBvzELMAkGA1UEBhMCREUx
DzANBgNVBAgTBkhlc3NlbjEUMBIGA1UEBxMLRGlldHplbmJhY2gxHTAbBgNVBAoTFE5leHRyb24g
U3lzdGVtcyBHbWJIMRQwEgYDVQQLEwtTZWN1cml0eSBJVDErMCkGA1UEAxQiTkVYVFJPTl9TWVNU
RU1TX0dNQkhfRU1BSUxfUk9PVF9DQTEnMCUGCSqGSIb3DQEJARYYaW5mb0BuZXh0cm9uLXN5c3Rl
bXMuY29tAgFZMIHYBgsqhkiG9w0BCRACCzGByKCBxTCBvzELMAkGA1UEBhMCREUxDzANBgNVBAgT
Bkhlc3NlbjEUMBIGA1UEBxMLRGlldHplbmJhY2gxHTAbBgNVBAoTFE5leHRyb24gU3lzdGVtcyBH
bWJIMRQwEgYDVQQLEwtTZWN1cml0eSBJVDErMCkGA1UEAxQiTkVYVFJPTl9TWVNURU1TX0dNQkhf
RU1BSUxfUk9PVF9DQTEnMCUGCSqGSIb3DQEJARYYaW5mb0BuZXh0cm9uLXN5c3RlbXMuY29tAgFZ
MA0GCSqGSIb3DQEBAQUABIICAAPVFhhsl0JVXPh8B1IYxxbN6KD/MbnrVTKgKnLJPo2/1t9kfBCU
a56vQtCW9/D9oaqg69kwjbwb0EiHyTmZOA5ME4xVQYQxqenEmlJROLjC6t2CUwxMEVX5r6vwzDk7
yp3uVgV8jlpcqTYmat68clEBMJ3fXp1AhrGjUwgSJ0SlXmwmHNN8EtUDy/1/oVS0QSHa9eYyxqK2
odGs82w5ZPmLyPj+3NTHQ4WTI4kJ3DQY9PMUDXofknHYQH4B4cgCX5bcu3M7mcOTSDX5It051QYV
llE3TqmbMrOIjUPX4MiOYHECN+OUWYX2IigqLPu1zUHGnfw6eKE5ZzS5uyd4SDZ3aUhzbMmKqHJ+
QZwE1JeYjcPD2QDy1qCzAs55We/ZriM0sZqyaTDSm0DfOPkHzX15qFQBVyirrS96TlZbUR2N+v40
1tW86vxO0Or53ZCOOBgsnjXmSNuufdt9lyKGFzeh0dUh1A99s6B+o6G/kGJU/B4WwNS5DeMnvvcU
6NU4XPHb24jWkY88Ddsq+qSwag3OfwAoKmd2A8OrWlYjHwH7NcSLSlBOfp08V9Gs7NdUkEHRQQ+v
0XLQYKdayYe+IyuYfCvPyJ7lzK0l0nfRDi5eowG437QHXhEaxjsT5f64WQYI81GJ9tl7ecGnFNXr
29ouLmo+gVJHcPCgLOyJNoAxAAAAAAAA


--=-GslGxmFo8w05lrxKrWOH--

