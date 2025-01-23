Return-Path: <bpf+bounces-49567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8915A1A0B4
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 10:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5909416B670
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 09:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B6420C02D;
	Thu, 23 Jan 2025 09:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="etJhz6eC"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C673A1BC3F;
	Thu, 23 Jan 2025 09:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737623883; cv=fail; b=jjnlBLmxpvQU/aIdYd0kZm5ETJigWuvBWh2zVM2W15vZpUl+dCGSoKfzZ7uJ5wN8NPptjCC2PNidrzQ3eLE94TERLlMbhklkMLt7/asR8wSP1NZQqBLgECPj8ONIULpIdYnjPxj2TPzxdAM2MHtjSDjCRfjih11qMgYbLt7RIoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737623883; c=relaxed/simple;
	bh=Y5mz+t9yOP6ONI74iOM9QvZMf5HP7mUJxpLFJu9s8K4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oTZfnfmwHC7H/K4nVlYFQc8VJe6l8tnyZo2HhPsgmecgbN1cwZ4ku3+OHcoWVFE3IAgd/kVMyiW+i6DVFI4yLaBzHo26DzB+58oeO7tGFr/bzoV7bJHnl1IHFUoBhX4BqDq020LWMza73BNjislOrOTbUT7n9HP5wAbmifBkx3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=etJhz6eC; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50N8Tjdu010961;
	Thu, 23 Jan 2025 01:17:27 -0800
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44bjaag2n5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 01:17:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ua0LvEaDwRz3HUbU8LgOzLR+EseHu4hqZkE5loPAx3mrJdhIra4Irzp6HcQBCWzndqI3BPPhJUyBW0iVRi5FsG1jeqzxmu58fyeZGcvpte2IpdRDeOV/S+r8VnizVsQjnubdxKeYD+h1qsFe4zScP1lSRt7zDuFl+kVlo6qJJtrkYTrqlwCGJuEUSXypGtNJLnhRDRcSMux8/09vGZKlgKI8DQmmFw3oLKc2el0GaqSqvLfq1PJJDm5K0CgvML85DYaVNSK+1ueFDohSjPN150DgRZObX6o9s393qjCFhaz1NykdYvBbKE5hPBfDXPtkGFJCTVtO5Tct+KpX0Q/VMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5mz+t9yOP6ONI74iOM9QvZMf5HP7mUJxpLFJu9s8K4=;
 b=ibhckY0mY2smLALHy0lZEbPut8TXo1woTxAFv+2uqcOpiwDzoy6yLKg2732ACgGy7LBHWAsoUeLYHknqid1THNW3LFZzxXcv9tsbwF3mcVbpww5YteNdWnmvjpJDa1UvjCv28GJTFJhm1IDATVCNjdr4y9bIer+L34flMrGKhmrffDGPjYpw5S/45/gtBYbdEehwUbTo1LKl+Rt0AnSBweKpzenLZ49qjwQOnuYe/UL4LRYiqOaa+SlTwBQHTUOXqBwcvbJ5vusgqNQcwqzjQvG381NdRLRl8IZKkiw9lfWYqtdw3Gcpk+Fijm1uJP8FOeCpRmF+/iceE17s221Xcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5mz+t9yOP6ONI74iOM9QvZMf5HP7mUJxpLFJu9s8K4=;
 b=etJhz6eCR3eTHzhGHNNLfKVfDslsL/67o3fvIJipOnRRhlYTBupGEr0Ow/hP0aibpsyssroUxgPKdcml1mxg3/dywsKyiPCXgjlrwXYAmxVfxw2WNrFRCKrTky3teibfUD6iG7VyUxI9aC3mEh7KEqGXrVqFXIjnYJPPSzuImLE=
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com (2603:10b6:a03:430::6)
 by PH0PR18MB5143.namprd18.prod.outlook.com (2603:10b6:510:168::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Thu, 23 Jan
 2025 09:17:25 +0000
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1]) by SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1%5]) with mapi id 15.20.8356.017; Thu, 23 Jan 2025
 09:17:24 +0000
From: Suman Ghosh <sumang@marvell.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
CC: "horms@kernel.org" <horms@kernel.org>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Subbaraya
 Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Linu Cherian <lcherian@marvell.com>, Jerin
 Jacob <jerinj@marvell.com>,
        "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [net-next PATCH v4 1/6] octeontx2-pf: Don't unmap
 page pool buffer
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v4 1/6] octeontx2-pf: Don't unmap
 page pool buffer
Thread-Index: AQHbaEp2gOR/FkAyj0uz2Q2jmHGICrMbP0OAgAjepKA=
Date: Thu, 23 Jan 2025 09:17:24 +0000
Message-ID:
 <SJ0PR18MB5216CC5ABBA7AFB8E7BAA4A8DBE02@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20250116191116.3357181-1-sumang@marvell.com>
 <20250116191116.3357181-2-sumang@marvell.com>
 <Z4qXxaOm1iih4xWl@lzaremba-mobl.ger.corp.intel.com>
In-Reply-To: <Z4qXxaOm1iih4xWl@lzaremba-mobl.ger.corp.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5216:EE_|PH0PR18MB5143:EE_
x-ms-office365-filtering-correlation-id: 97c970a7-bbaf-4f03-793f-08dd3b8ec002
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q2JWYVFVR1UzZ0VJVzFUOHFBZSszeWhnUjcvZVJ3ZnBHcUVMNmQvR3hkY25Z?=
 =?utf-8?B?bmM4UjRweW5ndG5UR2ZDVThFMXlqUzhWaVNvR2trbjlWT05YRys2YitXc05L?=
 =?utf-8?B?WTNqK013RnhjeHRha0xBT0JXZjdRV0pzL2diMUh4cjErUHpKSWp2MVMwK3Ra?=
 =?utf-8?B?ekFTb2huM3p5NEhjcE1XN3BCaVVpZk9IL1lRZ3FMNy9wZDFFM0cxd3lzdVFI?=
 =?utf-8?B?VkI5SGlYUE9qUEVyU1RyMTc1OW45cGtkQzZrK3ZaOEZyL3A1NTVONytpbkhj?=
 =?utf-8?B?SVkzS2NzWW94MG4xa2tJWnQ0dHlDQXFlUDArQk5PN0d0NGZTSlVyTzgyNWVn?=
 =?utf-8?B?N3h4aTFJN1JFck0xc1ZidlpNcmt4RldvVnlFbTlRVHlmeFJ1ZktMN3JJcUVz?=
 =?utf-8?B?UHM1Z2FOVTdZTGMvSjUrUTVJV2lyU1F5NlgyZW1XVTRwTEJFVkhCaVZDV3V5?=
 =?utf-8?B?aSs4bjErcGdxa0VhV2FtOGRGekNlc3V2THFhSWlJUjhQOFlzcjdodTJuR0lE?=
 =?utf-8?B?R2FqZTFmRHJETTB5cStRM1BRZWh3TXNER0xOa09laFlEZXMyWklBUHAwRkgy?=
 =?utf-8?B?dHFJWENZeVRNSEJGU3VpeHd0LzY2cU9TTDNHN05WcWMvcXJ3REJNWEd5bWRQ?=
 =?utf-8?B?YjZURFdzMXBHN0VNa3FZUTQ5WkNPT2tYU09YVFJ6WTR3NTliR3o4Q2l1NkZ6?=
 =?utf-8?B?RUV6YnlpR2xncjAzc2hVYnBxTzVCaDdMUGgwNEVXWnZYbmYyYkZPTnA3MTBq?=
 =?utf-8?B?YXREbWNHRmFNZUp6MmRNNzZ2R1lzNVZIRy9qTWNuaEFJWVlPbXJiNHltdmN1?=
 =?utf-8?B?OGJDcUliakxnVjJnemhVN3psWWN6TlhWQ1luYWMxdm1NVGpvcFVMdDljYkh3?=
 =?utf-8?B?VXhGaXErTXZBb25OaUlqdDJWVkVONzlFQUExMkdnSkZGYzBGRlRYMnZZN204?=
 =?utf-8?B?TmZXQkJhMytxQUtyUnJBMXlnRDdXRlIvZTloL1RuWEVWaU9jZFVFU2J5R2p4?=
 =?utf-8?B?TXV4WGIrbnNxZ3hDS2dMb3U1SWtBWkJJRnBFaHBIME5NVitaOEpNNjJYZ2ht?=
 =?utf-8?B?RDZQaGNQWnVXalc3VGgyY0hyUUpocDBPdyswZnRybGNqRngwUm5ZcHhiNFZY?=
 =?utf-8?B?QVNKVzZOTkF0RmZER21OTTBKVmRlVUM3dExWK2pjUjRBd3lqUlhCT2xOOTYz?=
 =?utf-8?B?aVh3UHpkbWJ2YXYrOHgvUlUyV1ZsNUk2QU9zNUR5VEZtaWpoak1ZSTFUUWNT?=
 =?utf-8?B?WEY2T0Jpa0xQeCt4ZG5zVnE4SHJSZTJkR3Nvb1QxYURUbXNXVUtuZXBNS2Zr?=
 =?utf-8?B?bXpGU0VPb0JaKytEMWlsZ3EwZ01vYXB2RGxTUnJ5WjVuaksyU0dRQ0l5RE42?=
 =?utf-8?B?RTJiQStCVTBpcEVUM3VXR29WRFdzWFA0MnZ2ZUhoN3hodnorSWxXcWIrbVdG?=
 =?utf-8?B?SDNFQnc1QVcvQkVvRTF5T0pqOXBDWGs3d1VnQ0FiTTdWenpyY3RmUHVWZ2s1?=
 =?utf-8?B?MVFhTXNYWVdKNFZ1RUFFMzJmRE5xV080djJHMGI2eVM2TlZNZFNRNjdtenQ1?=
 =?utf-8?B?aWNHOFFSRXF1MlpYVTZHTFFHVEkzaWh5K2FaeG0xS000QXdPTzVVNUhCUGVl?=
 =?utf-8?B?czdNQkQwUjhvaVNsOE5OVG5oUDhoYjBucFo3clRwYWxMTDBQM2dOTis3Kzg4?=
 =?utf-8?B?dnQ5MVFVS0NyMTVsd2pqaW9zRUo4ZXFwVDQyYUUwSjFlTTYrSmNJc1Z5K1g4?=
 =?utf-8?B?VHBJMFlNWmdnbUlhdXZXQzZxdnRCM2xQK2hHUFRHaEpCSWRXbWhVcTI4bjJp?=
 =?utf-8?B?Ny9OUUhMbkQwRWZvWFZ4SG5oT1QvSWYzZTNhUHp3TGVuWTFYMzJuTktvV0NV?=
 =?utf-8?B?QWIrdnBLbFo1UlEzeUoyNXIxenFQUjBBSmRadTlVdGJkakJOVlE2cjN6amNO?=
 =?utf-8?Q?9P8LLhXTRMd45ZLfm1x7qaz+QIYqq3Yv?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5216.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?akFQNlpmQWszbVpnczQ3VFl6NTdnM0hiYlNSRGdqbENudUVmREMyeE13amN5?=
 =?utf-8?B?SXhYaDN4ei9GQWwwVkR1KysxWk4yVDBlZHhRQWlUUXJrT1YxcXM2cGxQWlVy?=
 =?utf-8?B?c1FjK2J5azBITmprMWhTQ08xYmlnUUg2Z3dpYTJyMHJzMUtTNVhXTUVFbFJa?=
 =?utf-8?B?ckRaQklDMXk5UmJLZ3o3MFdjdDBYbnA5SGpSTlNBRE44NXdQalNMUC9nVjRS?=
 =?utf-8?B?ZG5pS1BiTm1xYVFhejFiZ2dUR0ZucHRWdTVhdldHN1JPRmgxWDJ2NGZ2dzRo?=
 =?utf-8?B?VDlhTnV6TkVtTEx6SGxKOHdodUdYNTI0S1lyOTFhVEliMjNRK1FYdHZJS2Vq?=
 =?utf-8?B?SUpnWFc2SkR5eVEwcGgrSVAwTjltSUpGcXkwcXg5K05ZMzk4MjNac2pTQjlq?=
 =?utf-8?B?NGMreVpCWXZrdzdaT1Y5ODFxVHFGZktMM3FZUWRnSjYxZzl4OVpiUGNQUEdx?=
 =?utf-8?B?OUlxZXRIUlExeE83aGR2cDlWeGdVQmV2QkFCYkZiZ0E5Y0pwcUxFeVYyM3FY?=
 =?utf-8?B?eXV0VUpWNUoxbmVQaUZSZkQrUkY4R3dmYjF4TmhQYkk0Qmo0UDVlVzQ2cVEv?=
 =?utf-8?B?SnR1QlozaHREcTkzQzdhbmVlUWdwS0k3eEtmQmFoNnlFaHJVNFRoRlNIanM3?=
 =?utf-8?B?ZVBNQkJUS1k0V3hETWlBczVtQ3p1N2o5WGFZSHp0MXp6aDFWVW5pNkxEN2sx?=
 =?utf-8?B?UmpwMUtGMUZFVnJrNzQ0NjE4bGxvdFIzL0NMd09PVlR0SlZBZzU4ZkFPYkdL?=
 =?utf-8?B?ZmxvS1Z6d2ZneHlwQUVEUFFPc25IMHk1ZW5ZNC9TS0dkTmVERzFYMCtmTVB2?=
 =?utf-8?B?dXg5eFNnQzVpTGZHbDhORjhuUHVjRGhuU08wNENyNXN4MVI4U1p1TW4rd2lR?=
 =?utf-8?B?aGlLY0NUTEVuM3h5UVlra2Z5Vi9rc0FzOUZ2YWZKaFZ2bXNYZHJSVUJUTnUr?=
 =?utf-8?B?d2dSUXVleU8vSEYzSkVkNWYya2d2SmFzeG1Uc1BkQ3ZCeFA4azh5Y3RSV1po?=
 =?utf-8?B?enE0QW5YZ2d5OUJJTXFaS084STRvYTVIeUhHRVNJMW1yV2pkSENiS1FhUXJ5?=
 =?utf-8?B?SDhLakkwcTJBWkpLMFRtS3M0Ykd1T3k3S3VtaG5FeE9DOUJ3UDVQYnVGV0Zu?=
 =?utf-8?B?dWlsTngwVkFLOGxoM2FwSEs3YjlpS2d0bDNBcXdUaGZ6b3UwOWU3aUhHTWtp?=
 =?utf-8?B?QXRnWkhCQzdBdSt0TWFVRVhPVmJVUXU3UW1tNXhkbVhianVyUTRieTRYSVgy?=
 =?utf-8?B?eVpMZjBQOXcyZk9jUFgxMlVGNHA2NFgrcVcvbEhKMzZYMTdLSWxOMFpZbVFX?=
 =?utf-8?B?Z1pqMnFnd3Y1d1d1SXR6Q3k4blA2Tkt5Vk9jempLYjZ0RzNOQnJwdGVwN0lC?=
 =?utf-8?B?RDFCbjVjWFl1QXJ3Y0lzZnRLZnZkT2E5RDAvcjdEajNrbmw4dFZ3Wi9UL0N3?=
 =?utf-8?B?UDNvWThjdjNaUDB3VmE1eHJWL0FEZUdPRFNnYnRFclJmcUNxTnQ3b2VOWGRC?=
 =?utf-8?B?OVY2YmYyUUlMcnRJaFN6WlVEQWtpRW5saDNXbjYxNEdmYWNOMnk3WHdacy9V?=
 =?utf-8?B?RDhIRGV0MUkrOE4zZ1VoMU54eGFqNms0U01TQm9zdFVZcEE4b1lWdDZiTmJm?=
 =?utf-8?B?YzU0b3JhYVpnanIyMVgvR09DNGlqSFhCSFNKcVNJWTZ3aHhYTEtnbE5pQS9V?=
 =?utf-8?B?bk5Ub01CUERBV0xPWWZIcVFuQ09Kdm1BcWk3aG55OXovTWYxdU9oc1NSZnZX?=
 =?utf-8?B?LytPdWt1My9LWDZMcGFlaERsbHNzTkJRc28wenBiTmYrNzZ4WmZIYzhjVTdq?=
 =?utf-8?B?U3FEZmc5K3Q4WU1FK1J3V2x6blk0cHpVYiticmRmVms2eFJKVkIreGxQdkdz?=
 =?utf-8?B?RGx3REx3S2plMnY3bWdEdFgzY3NLUThGOEw3VzZGdU5CZUQ5M3BSM1B3Zjl6?=
 =?utf-8?B?S2xSZHFRaTBZQ2R5bUhhVmxUa2Z1U25IMmdWdCtickY5L3J0dTkvRTFnMU9M?=
 =?utf-8?B?c25HMCtVSklETmoyWWtGMzJZa2hBY1VrUkNQYWJEVUhFMFlGV1MxcXJFQStu?=
 =?utf-8?B?Q1hhVUtvMzlWRFkybUluT3NKbVRxdmI0MnBGZkYwNmVtbUNOOWsyVjVXSVZY?=
 =?utf-8?Q?Pn+8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB5216.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c970a7-bbaf-4f03-793f-08dd3b8ec002
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 09:17:24.8981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 34nPhLtio2L4v+OmAnu0f/C0jup10SIGByEtb8sMVmMHcGpk9HffJXRkjA9rk+B/IpqRxwwPif4JhbMPzT0CRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB5143
X-Proofpoint-GUID: GZVrzzopszXYNR67Be6BCgU-7-6TNEbH
X-Proofpoint-ORIG-GUID: GZVrzzopszXYNR67Be6BCgU-7-6TNEbH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_04,2025-01-22_02,2024-11-22_01

Pg0KPk92ZXJhbGwsIHRoZSBjaGFuZ2UgbWFrZXMgc2Vuc2UuIEhvd2V2ZXIsIGl0IHdvdWxkIGJl
IGJldHRlciB0byBjb25zaWRlcg0KPnVzaW5nDQo+eGRwX3JldHVybl9mcmFtZSB3aGVuIGhhbmRs
aW5nIHRoZSBwYWNrZXRzIFhEUF9SRURJUkVDVGVkIGZyb20gYW5vdGhlcg0KPmludGVyZmFjZSwg
eW91IGNhbiBsb29rIHVwIGl0cyBpbXBsZW1lbnRhdGlvbiB0byBzZWUgaG93IG11Y2ggbW9yZSBj
YXNlcw0KPml0DQo+aGFuZGxlcy4NCltTdW1hbl0gT2theSwgd2Ugd2lsbCBjaGVjayB0aGF0IGFu
ZCB1cGRhdGUgaW4gcGF0Y2ggNS4gSSBXaWxsIHN1Ym1pdCB2NSBvbmNlIG5ldC1uZXh0IGlzIG9w
ZW4gYWdhaW4NCj4NCj5BbHNvLCBhIHF1ZXN0aW9uIGJlbG93Lg0KPg0KPj4gU2lnbmVkLW9mZi1i
eTogR2VldGhhIHNvd2phbnlhIDxnYWt1bGFAbWFydmVsbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBTdW1hbiBHaG9zaCA8c3VtYW5nQG1hcnZlbGwuY29tPg0KPj4gLS0tDQo+PiAgLi4uL21hcnZl
bGwvb2N0ZW9udHgyL25pYy9vdHgyX2NvbW1vbi5oICAgICAgIHwgIDQgKy0NCj4+ICAuLi4vZXRo
ZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfcGYuYyAgfCAgOCArKystDQo+PiAgLi4u
L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX3R4cnguYyAgICAgICAgIHwgNDMgKysrKysrKysr
KysrKy0tLS0tDQo+LQ0KPj4gIC4uLi9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvb3R4Ml90eHJ4Lmgg
ICAgICAgICB8ICAxICsNCj4+ICA0IGZpbGVzIGNoYW5nZWQsIDQxIGluc2VydGlvbnMoKyksIDE1
IGRlbGV0aW9ucygtKQ0KPj4NCj4NCj5bLi4uXQ0KPg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX3R4cnguYw0KPmIvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfdHhyeC5jDQo+PiBpbmRl
eCAyMjRjZWY5Mzg5MjcuLjI4NTlmMzk3Zjk5ZSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbmV0
L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX3R4cnguYw0KPj4gKysrIGIvZHJp
dmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfdHhyeC5jDQo+PiBA
QCAtMTAxLDE0ICsxMDEsMjAgQEAgc3RhdGljIHZvaWQgb3R4Ml94ZHBfc25kX3BrdF9oYW5kbGVy
KHN0cnVjdA0KPm90eDJfbmljICpwZnZmLA0KPj4gIAlzdHJ1Y3Qgbml4X3NlbmRfY29tcF9zICpz
bmRfY29tcCA9ICZjcWUtPmNvbXA7DQo+PiAgCXN0cnVjdCBzZ19saXN0ICpzZzsNCj4+ICAJc3Ry
dWN0IHBhZ2UgKnBhZ2U7DQo+PiAtCXU2NCBwYTsNCj4+ICsJdTY0IHBhLCBpb3ZhOw0KPj4NCj4+
ICAJc2cgPSAmc3EtPnNnW3NuZF9jb21wLT5zcWVfaWRdOw0KPj4NCj4+IC0JcGEgPSBvdHgyX2lv
dmFfdG9fcGh5cyhwZnZmLT5pb21tdV9kb21haW4sIHNnLT5kbWFfYWRkclswXSk7DQo+PiAtCW90
eDJfZG1hX3VubWFwX3BhZ2UocGZ2Ziwgc2ctPmRtYV9hZGRyWzBdLA0KPj4gLQkJCSAgICBzZy0+
c2l6ZVswXSwgRE1BX1RPX0RFVklDRSk7DQo+PiArCWlvdmEgPSBzZy0+ZG1hX2FkZHJbMF0gLSBP
VFgyX0hFQURfUk9PTTsNCj4+ICsJcGEgPSBvdHgyX2lvdmFfdG9fcGh5cyhwZnZmLT5pb21tdV9k
b21haW4sIGlvdmEpOw0KPg0KPldoeSBjaGFuZ2UgdGhlIGFkZHJlc3MgY2FsY3VsYXRpb24/IEkg
d291bGQgbGlrZSB0aGUgYW5zd2VyIHRvIGJlIGluIHRoZQ0KPmNvbW1pdA0KPm1lc3NhZ2UuDQpb
U3VtYW5dIEFjaywgd2lsbCBzdWJtaXQgdjUgb25jZSBuZXQtbmV4dCBpcyBvcGVuIGFnYWluLg0K
Pg0KPj4gIAlwYWdlID0gdmlydF90b19wYWdlKHBoeXNfdG9fdmlydChwYSkpOw0KPj4gKwlpZiAo
c2ctPmZsYWdzICYgWERQX1JFRElSRUNUKQ0KPj4gKwkJb3R4Ml9kbWFfdW5tYXBfcGFnZShwZnZm
LCBzZy0+ZG1hX2FkZHJbMF0sIHNnLT5zaXplWzBdLA0KPkRNQV9UT19ERVZJQ0UpOw0KPj4gKw0K
Pj4gKwlpZiAocGFnZS0+cHApIHsNCj4+ICsJCXBhZ2VfcG9vbF9yZWN5Y2xlX2RpcmVjdChwYWdl
LT5wcCwgcGFnZSk7DQo+PiArCQlyZXR1cm47DQo+PiArCX0NCj4+ICAJcHV0X3BhZ2UocGFnZSk7
DQo+PiAgfQ0KPj4NCj4+IEBAIC0xMzYwLDcgKzEzNjYsNyBAQCB2b2lkIG90eDJfZnJlZV9wZW5k
aW5nX3NxZShzdHJ1Y3Qgb3R4Ml9uaWMNCj4qcGZ2ZikNCj4+ICB9DQo+Pg0KPj4gIHN0YXRpYyB2
b2lkIG90eDJfeGRwX3NxZV9hZGRfc2coc3RydWN0IG90eDJfc25kX3F1ZXVlICpzcSwgdTY0DQo+
ZG1hX2FkZHIsDQo+PiAtCQkJCWludCBsZW4sIGludCAqb2Zmc2V0KQ0KPj4gKwkJCQlpbnQgbGVu
LCBpbnQgKm9mZnNldCwgdTE2IGZsYWdzKQ0KPj4gIHsNCj4+ICAJc3RydWN0IG5peF9zcWVfc2df
cyAqc2cgPSBOVUxMOw0KPj4gIAl1NjQgKmlvdmEgPSBOVUxMOw0KPg0KPlsuLi5dDQo=

