Return-Path: <bpf+bounces-59853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E37AD00A0
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 12:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520F117235B
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 10:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF04C2874E9;
	Fri,  6 Jun 2025 10:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fEP5eueZ"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D785220297C;
	Fri,  6 Jun 2025 10:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749206642; cv=fail; b=IrN184GO2WdGSB+S5lAzTgNGzMREtBt9M9RkuB6dXMol39ipPrGMTYCR7g4OPGP+hBxTE5rB9nHUiXTiNmvWz17OoBVQ9rNyzq36v56iDDT/KG/uqNiPZLPBmj/H6vRg5p/mpUh5jYucSWvdtHl5jNjSfvei1kmauidEGWRxBt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749206642; c=relaxed/simple;
	bh=UOthyO9ecjNpvPpbB18jjIcb00RU7+BW+neDeAYFcTo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qzhc8utPkUUAI8NgcPWDGUBOwJ9Ty1lpRBoAvzdjRzAbYLCmEwlYfC6Y4/tTXexcIkGhferay0lAfZw1lTXm3b/l5KhRmJHVfKbRmdgCH3meooSFbrzr5rOGgbQHWVIVX0IfuctzuZe+WN2ofC7RKYO3RiVnjTTNpN1LtMxmJGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fEP5eueZ; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNgUlAwF+sdRWaS8+7FI4R9PPjZZwpXqfdCAwYLuXaG2pPAykLGXRCrUehGNhgkMMkSkfzKTXa9TFRNxMhekY26NJWOHMNaFDwOAMtO0ivPcdSDKxUuBFxHZJDdRbPkZixVFtL6Ij8KXQpA4oPzI5o+rD44H3QaHMTaLrVj/6FfByep/51gJIj4oplp1pqT6ZpewOaFGv3UhmFrVnkVF7WvnM2rtRQjLDBFcUxirfOnyykniga1a7aqx6yc/7YJfB4v48/YJLnd026tvvNb0h16KYGm9oR7hWzNjuFxUgwzR+H3863mi8st16yYpmY676GZ6maptGQAaZSTKpeynDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOthyO9ecjNpvPpbB18jjIcb00RU7+BW+neDeAYFcTo=;
 b=ucUo5MTvvhr749HMMpEbuASqSXzEEoW+ItikZh1l2Vmftz+Tr2NFPDjXpzOTQJ2+zqL9OGmLUUwZx/pyT9YYnRgA5f4gJ77iXe+OA4ivbOwLhaAcRFCzCuHv+OFQOTB1iquBOeZOKV3bH9qC//PCzoiUegd48NCSexd9YXWLbig1g0HdEemKXpZIOolLrJlO0h4URwXhNc5n7vxLsGtrQjMTXvYToRMa4YIeZtIcgH8RF3Na2yjY7jGqo2/6LgCoymbAaXzCRecAUOj1PErB+PUu2Cpbvymt2vU+TkX8gkfyd5P/pEygAX0FJWxofbBfPmTV9K46BK2YbvWtDETj/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOthyO9ecjNpvPpbB18jjIcb00RU7+BW+neDeAYFcTo=;
 b=fEP5eueZwQ6MN75h8EKqHFpSerw1hbU8/NzLcHuFETculcQHlUBJ34nt0YAWrwDsMM8zY+7UW5T0G/BM3RxcMh1LpX1XDBTHQ/cc9obg/CaH2TkL70G+u+8gCoQ231YkMyUzA/rNMxMJgSCsC2UkS8Zs3Gee0WDr5NTVwPRciN7XNSB+eGNK2Qb11r24NFyjK7UssAOznzApFhh8AR7CL+nzyTGZTviA1MnbvYb2V/i/JtNs4R+PT26tmWWfJyiHCkPJQJqASY0RlK1DbduM+n8z2l9plieCqlSg5pfgdkzCUuh0tknHcNNVcsrmsTdVUK43oPF53svI1IbjBOmSvA==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 10:43:47 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::a991:20ac:3e28:4b08]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::a991:20ac:3e28:4b08%6]) with mapi id 15.20.8655.033; Fri, 6 Jun 2025
 10:43:46 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "kuba@kernel.org" <kuba@kernel.org>, "saeed@kernel.org" <saeed@kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "hawk@kernel.org"
	<hawk@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "leon@kernel.org"
	<leon@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "ast@kernel.org"
	<ast@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed
	<saeedm@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Gal
 Pressman <gal@nvidia.com>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [PATCH net-next V2 07/11] net/mlx5e: SHAMPO: Headers page pool
 stats
Thread-Topic: [PATCH net-next V2 07/11] net/mlx5e: SHAMPO: Headers page pool
 stats
Thread-Index: AQHby2KBqo+uwhRiLEu0s5b5lYH7pbPfO9AAgAAHioCAFsWjAA==
Date: Fri, 6 Jun 2025 10:43:46 +0000
Message-ID: <2c0dbde8d0e65678eeb0847db1710aaef3a8ce91.camel@nvidia.com>
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
	 <1747950086-1246773-8-git-send-email-tariqt@nvidia.com>
	 <20250522153142.11f329d3@kernel.org> <aC-sIWriYzWbQSxc@x130>
In-Reply-To: <aC-sIWriYzWbQSxc@x130>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|DM6PR12MB4250:EE_
x-ms-office365-filtering-correlation-id: 8e87ada2-cfea-42b9-d92a-08dda4e70409
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dWl3Tzg3bVBoYkdLUGxTSnhNS0dCSUNMdHp6REFSMWUvOFJJcEZnWGl4bXpT?=
 =?utf-8?B?OTFnM0d1aHgwSlp5SmZuNjh4ZUVaaXk1UWN4U29wczVJNng2bTI5YWlLbE5k?=
 =?utf-8?B?enRpS09sc1F3bmRFa2l6VnFaQldrS25wcWxJMVdwTDl1WVErNkF2b29TWjhY?=
 =?utf-8?B?MXZjNWJmMmFBa1lySFU5UzRmcjl1SHBSUFgzd2VSak5vWjkxd0paR2IvR0lZ?=
 =?utf-8?B?L2dmeDUxRHlCNmplSDJYcWpWN2h3endVbndsb0Z3NzdQd2xqMFVHY0ZyYWg4?=
 =?utf-8?B?MHNkZElROWE3UkE3MHJWREhES05abHpKMWlTOVpiS3VoMG9ZR0JlbjdzUWI5?=
 =?utf-8?B?NklmV2FacEwvY2NneGRVbTB0TXJ5cWROOW5sZUs5M3NLb2ZsUCtqS0NHSTg1?=
 =?utf-8?B?R3J5d1BtUE9QdlhNVklJY1A2aVN0c0dLVlB0UVNDaVh2a0gxY01nWkFUZXEw?=
 =?utf-8?B?NWdkNW8vNnFEeG1BWGdRUHZLV3FkOVg3blFxczNKR2lRWk9BdHdQanJJaHln?=
 =?utf-8?B?YW9yZEZnNHNjSHhGSmcwTnJsYmE1Vkp2ZFY0VmRNdVNOSHNDcnpsRnZkQmRa?=
 =?utf-8?B?NjJYRVp1WGZCZUFESTkzVjFrdE9ZNldmRmNPMVVmb2JONXI5Z1JHNWorbkRI?=
 =?utf-8?B?bmhGcFdtQnk3MmJkNXJtQ2FDSStHZFJzTURtTWE1eHJJdzFxZ1JUNVJDbC9Y?=
 =?utf-8?B?cW9OUEZUWVlrTmZHREYram95SmthQnRRRm1aVkV3dW91SThQaUhPU3hPVm52?=
 =?utf-8?B?SnpFeUhFd29NNWxBMlJGMjFZL3g5RkMrMjVoUHdKeWs5UlgyRlMzLzFZV3V3?=
 =?utf-8?B?elNkajl4MHIvV3lQWjZaQWk0RUJJR0lPMkZsYWJja2x2YjFMYjl6c3hsVi9u?=
 =?utf-8?B?SGZUU1NPSHpQMGVhcXVNNW94QVFBdEs4djRiNGZJSUU4VEx6STQwOWlwQTZn?=
 =?utf-8?B?bnpVTjhrYm4rUUd4REVsUVl5UkhvVG9mUWJhRlJaNTE1elZYSDN2NzQ5Ykda?=
 =?utf-8?B?RXFZU2V2dlNITzd3WjNKUjBuc1l4YmtpWEpIQTJIaDh0YnN1N0lLS3NjL3FW?=
 =?utf-8?B?ZThnR1VEanA2Zlljd09tbjhjK0NYZDNSdzQ1SE5xWmhJQUoySGpvWmNqRnRM?=
 =?utf-8?B?bEhTdU5hbmxxTVdLRm9SeVdGakNPbHlJSlR3ZCtoa0QweDN5bkpaUWw1K2c2?=
 =?utf-8?B?ZWZ6MXNmOTZwdi9TU0E2UHAycHIvKzdqeEt3ZnJlSjhUSjFMS3YrNm45K0c4?=
 =?utf-8?B?TUJuU3NxckF0a3d4dWYyME43dWhVK3FVYmVlNStodXk2NTZweGRqRWlEY1FN?=
 =?utf-8?B?YjdKMFZNQitWNTB3alA0NFRqN3hON3V5NXZOS29xVWtJNFkxb2EvMEljWEc4?=
 =?utf-8?B?Nks1QmdLTk1UYkFwM0FaSjl3UGpVOEQ5eUIyTmpXUnVDSVJvTWRacGY0VXJY?=
 =?utf-8?B?N01iMlJwWDFJSDVxdnNZMXdxUGNhTWlENEs3WUZvb0F4VThZMFlSRERyb0ky?=
 =?utf-8?B?L1lnVlVyd0xMWGU5dVZoS21YY3VydFh4QkZYRWtkQlR0c0hOZUZsdkJIOUMx?=
 =?utf-8?B?QTFJclRZU1JDcmNDb0xGUlFEOElxZHBibFhoOWNtaDhzMnFGYUoxT3NaOU9t?=
 =?utf-8?B?KzVWZE9hNWE5dExYTDl3NTVaUmI2aFoxbGpnMGxjTmhpWllxSm1UQU56NkFC?=
 =?utf-8?B?ZlZSaTkzRDZYMXpHTTF2K2IrNFpRM0ZhQmQ2cWZsaGdRTW5kMkxOT0kvbDZR?=
 =?utf-8?B?VFM4WktpTWpjZGsxOTFpcWptdVZHR21vT0ZNaGN1SkErVnNBdUMrelh4Q3pE?=
 =?utf-8?B?ZTBtejZIMTU1L3VzK1lMMndzTXlFY3prN2xiaGozRUxVSzZ4RDZrdTdmKzM5?=
 =?utf-8?B?dGdOWTFMT0gxZmt2VXluMWUrMGRWY3NiM0FjaFF4SEkrZ1Z0ZC9Wc29jU1Q1?=
 =?utf-8?B?S3NQc0FFWnR5VGVQTzc1ZGE1Z1Z2Qlo4MDQvUFFTL2VaemZlQllqRCsxVUw0?=
 =?utf-8?Q?Ot6oRQVsZNJJhHoW2xrLpKCs6Jgytk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UkJJNUFhOG9kTTc4eEljQmMrQ3o0RlluWXIvTnlLTHg4ZTdLenN1QVZ2L2U5?=
 =?utf-8?B?QWoxbC85U2JPOTVoMllNVmI5NTJhRHlhejhXUFlveEYzN2ZFTHNaUTY2dWNt?=
 =?utf-8?B?Z1I2RkViRzNRSkJEam5MV2RhQ2tKMTRNUnFCNCtraDFnQjI5YnA1T3RWQ1Fy?=
 =?utf-8?B?ZVUxYlhvN1FiRXNsZ3gveHQ5djE4ekZ2aUF2eHNwTDZlWnNvZzdZY2dYbDQ3?=
 =?utf-8?B?VUJRckxwR1NxOWtSRDgvbHg3SGpoN3BZU3FFV0FRSnJpZ2N0cVoyVkpqVi8y?=
 =?utf-8?B?M3ZVUG1HZzV5WkR3UEFCZnNyVGQzbzFGT0hXdnUxVGxZT09hMThHV3ZwZmc5?=
 =?utf-8?B?dXRjUk5tczR0MlVaTURMZHZGeVdMZ1pKaGZwSkh6bUZTVllHUzdHU0JBcGcv?=
 =?utf-8?B?NkZOVk1WSjRIU1lWV2lZZmlId0xPeFRmL1N4OHdzWjJ2ZksyMXQ4Nzc4UHFK?=
 =?utf-8?B?Q25qTlpQcmcrZ1JZam1OUXdTS1g3cEdDY1NOVHpnZEdjUjdzQmQyUVQvdWZS?=
 =?utf-8?B?UHdqM3JOQS9ZMmZSQjRGVzlhbGM5ckdSaG9TbGxrMUFFSWF1QWhnUDJCekQ5?=
 =?utf-8?B?SUcrcmhqRDJvQk1WY0pPcG5SWjFtN1ZaU3Bac2FTQzNwUjVTVmkvYWpHQ0hL?=
 =?utf-8?B?S2R4V210TFNMb1QzM3B3UFFUbThkRGU5b3EyK1hrSnVjZzJaa3pXeGw5QTVa?=
 =?utf-8?B?bDAvYWJjeGFOY0ppSERKNW1KT0VLOEFFUTJIR0pMRnorbmVpQXZ3eFBaT2dC?=
 =?utf-8?B?SzlKd3BoMjZrSytRRkU4amVsbGNVcSs3MGxzOUFucXNUMytXRzl3ajkxM2Nz?=
 =?utf-8?B?cVpsT1ozaXFraWxpbkhBZTMyM0NrbDU5UzMzQmp6c0VLblU4Sk5zVmJFOHBz?=
 =?utf-8?B?QnFFWEIwZVIrRWlTR1BUUWkzMmdmN0g2cE1JMU04WGRLQUpzdEZCY3owRkVB?=
 =?utf-8?B?WHdtY2l6RTZNV0llam9VdHpWbGEzZEVOSHRJTElBRTNNQmNEb1pJU0w3WG8w?=
 =?utf-8?B?cXlySzZMOXdEcDJEMHhtTGRqQ2V0TnVmak02ekZWamdVdThiUWpVSW0wSUcw?=
 =?utf-8?B?c1llWmp4UWxJQk9PdnVjcnRxTmVncHEva21MNmpvcDQzZDJ2bnU5ZCtheUhp?=
 =?utf-8?B?WUZENW1ac3FzUFFpNmV1SmhJaUhXNXpWL0Y4aGxpOUZ2V01QN2EyRWY2NFUv?=
 =?utf-8?B?TXNnS2NBNldoaW05OXEzQkYxcWxYYTR3dkY0LzJWWk1ZZXI2bmdvUDlrNTJN?=
 =?utf-8?B?MHE3Tm96NEN0enpUWFY4SzFQRzZ0MVU0NVJsWFFZVXlydWM2QVVWWXh3dEx5?=
 =?utf-8?B?SFFDczBTRmRLVTlmTUt4enBncWs0MklPOVd5WTVmMDQwbUZKWDIzc2RsT0tN?=
 =?utf-8?B?SlE3OVV3aHVrVVBCRHI1bHAxMGN3RldCYjcrcU1TMXo3UmZBMXVscDZiVFRX?=
 =?utf-8?B?K3NZbjMwNDUzWkM2VEZUNmxKbFZGRDNqS2pDMTFibTFBQWxTWktwS01OOGFh?=
 =?utf-8?B?cEpKbTF6Q29XeTFpSGtac1ErbFpDaHZFbTVHblNHSlljS3ZBeHFqRGp1eGly?=
 =?utf-8?B?WDNhem1EQk42QmNGVG5LY2VPcnFBMlduSUhjU2xEV012TkhNQWlIOGFCZmFZ?=
 =?utf-8?B?SEFJSGVXY1U4eTVjd2VvUlhmZUJsbHdaQWpHc1F5aFNUSUpuTWllNEhKaWox?=
 =?utf-8?B?aEdPQlptT2NmTG5pTDB5Tm1jdkhzdlBqbGRzeWJKU1oyRFF2RUdUbStYSi8x?=
 =?utf-8?B?aFVraEhBS1FOL28zZ3VTeG5JdWZIODJiQjIxcDhub3pjVkd4UnRpa015Qzhx?=
 =?utf-8?B?c1ZOM3lmL2NodmxETTV6R2tKMWE1ZWFvdFNZKzJTRXVESHRTM0Y5TFJrRGxv?=
 =?utf-8?B?dmgrRGx5OVJid2o5V2RYbFVWYTh0ZUlKTWhvSVpybmVtMFgxSnYwV2RpZDdU?=
 =?utf-8?B?Yk9OcWswYXFTMWQzMUluUGdGR0lLN0tPUjA4WnhlbERHd09KVWhlaDVFM3F0?=
 =?utf-8?B?RVBQSEpSZkpFc1B2ZUNjNFlueTN0UDVUWGZSeTRXTi9FM09oZ3pKN0hMNEc4?=
 =?utf-8?B?VWVTN2QrQUVVOSsxUVlRRnlzYm5KYnFKM1ppakhYTDMveFhlb1A4azdsRUpG?=
 =?utf-8?Q?VvZy3+Jld0Z+HxBBsqOnhKleC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10E04FD912DA2241BB64AB893A059987@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e87ada2-cfea-42b9-d92a-08dda4e70409
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 10:43:46.8035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RSrbj8MCCl26x5jS+OVGL32/Pok90PFCmzQ/xxOYnyDJJbPuW5bWxqEpBSSrVQhwHS8ZdEEy+bw9CmjtQZTbsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4250

T24gVGh1LCAyMDI1LTA1LTIyIGF0IDE1OjU4IC0wNzAwLCBTYWVlZCBNYWhhbWVlZCB3cm90ZToN
Cj4gT24gMjIgTWF5IDE1OjMxLCBKYWt1YiBLaWNpbnNraSB3cm90ZToNCj4gPiBPbiBGcmksIDIz
IE1heSAyMDI1IDAwOjQxOjIyICswMzAwIFRhcmlxIFRvdWthbiB3cm90ZToNCj4gPiA+IEV4cG9z
ZSB0aGUgc3RhdHMgb2YgdGhlIG5ldyBoZWFkZXJzIHBhZ2UgcG9vbC4NCj4gPiANCj4gPiBOb3Bl
LiBXZSBoYXZlIGEgbmV0bGluayBBUEkgZm9yIHBhZ2UgcG9vbCBzdGF0cy4NCj4gPiANCj4gDQo+
IFdlIGFscmVhZHkgZXhwb3NlIHRoZSBzdGF0cyBvZiB0aGUgbWFpbiBwb29sIGluIGV0aHRvb2wu
DQo+IFNvIGl0IHdpbGwgYmUgYW4gaW5jb252ZW5pZW5jZSB0byBrZWVwIGV4cG9zaW5nIGhhbGYg
b2YgdGhlIHN0YXRzLg0KPiBTbyBlaXRoZXIgd2UgZGVsZXRlIGJvdGggb3Iga2VlcCBib3RoLiBT
b21lIG9mIHVzIHJlbHkgb24gdGhpcyBmb3INCj4gZGVidWcNCj4gDQoNCldoYXQgaXMgdGhlIGNv
bmNsdXNpb24gaGVyZT8NCkRvIHdlIGtlZXAgdGhpcyBwYXRjaCwgdG8gaGF2ZSBhbGwgdGhlIHN0
YXRzIGluIHRoZSBzYW1lIHBsYWNlPw0KT3IgZG8gd2UgcmVtb3ZlIGl0LCBhbmQgdGhlbiBoYWxm
IG9mIHRoZSBzdGF0cyB3aWxsIGJlIGFjY2Vzc2libGUNCnRocm91Z2ggYm90aCBldGh0b29sIGFu
ZCBuZXRsaW5rLCBhbmQgdGhlIG90aGVyIGhhbGYgb25seSB2aWEgbmV0bGluaz8NCg0KQ29zbWlu
Lg0K

