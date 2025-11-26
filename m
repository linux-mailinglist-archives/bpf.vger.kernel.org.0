Return-Path: <bpf+bounces-75535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B4FC87F7B
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 04:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C1C9D354025
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 03:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1A030E0E0;
	Wed, 26 Nov 2025 03:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CgPyoVt0"
X-Original-To: bpf@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013027.outbound.protection.outlook.com [40.93.201.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084211A239A;
	Wed, 26 Nov 2025 03:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764128245; cv=fail; b=eZyOGQGUrD+dQLWc4Z1sW2wPGjy9f4P0wZ81itOU4hgM+tiW31bYit1R59yyY7o6YR/hlBPIyOV81HOPLd3sIv9K+l1n0E6BVoYour0wWSqaSRCZH1kq6DHGYst1AcnIO2TbsK1SBFsyx9JWAejXXc+j1etD+J7Ww5qRSrFBMEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764128245; c=relaxed/simple;
	bh=WNB/x2UZ7Tj9t8UsuaiaR4gzlQcVC4bLvg/QEEQ8+zE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ytf9LlbP2E7G7jwLRNBsXcfj6p1QvdeoA1lCrfFCD2Uwucsyg4+n+yjc7Mn1xJiffAWnSb7vHbGL5VOFTjm22ztubOwWe/VleixWwOGYhcGLm6G2CFEAY8yfMmj1Xx9vbSkEaI64C4TYx59tDjPnWdwyyuTyiiT20jmmeHgLU4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CgPyoVt0; arc=fail smtp.client-ip=40.93.201.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6HalFCwHRKtzatbkEH0IU05YBwMZVrhs4G9kYyOr+37vueN95qLXnCJcqqJ/+ComgnLWW/2cqVJT+TT4kFBP9sW2EK++nEfQZCkWAu9+VtjiaLVYDqoqp+LoRs6UdLHY7ETpdQFPiiJZN3U9OMcfow2UflVyP1ybDoZAU/6TUJcw7kTfvbZJwoWYXflu6vuWiyRn+YRKfuoqI+xjMmJYo4qCz2ua8N7+5zz47psaMDDJaQ/GwwlF47Ut/iAv/7Kp+X6iv/BcKuR5/Jfzkx2fUI0EWSZvNlUEk0GukVMaLYs3G6hIFPkvezM89h2QZk3JMfZdSomqZxjlN7MYhM5ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNB/x2UZ7Tj9t8UsuaiaR4gzlQcVC4bLvg/QEEQ8+zE=;
 b=ZD4b2VSozi1TTJeowGEjdjhXff21wYxUt+e38yVtcsz0ckxT5zXPtyqRQELgos9I3XRTLJA+aU7k49K0u3XPUL/WE6gvVVz2QIC0EEcxz5i+k3hEmYGxkh2NUS5Bgih2GBHSyK1LX9I3G2mb6Ssz7M8Es9EbOv5POu5w5IKEr/zk0d5la+3lyDXd47PjOPd3FJOXhrVNYRCXy/U97/5L8UuAaiKNYMPhvhPc9Gmru5mp4Z3EPxy1T3O/iwAMvJefsucqrZpBWQiVf+pHPVeuMDUcun1kG5BpXnrCD5d0Aaot1JMbjyvL5Q6OvRuvqEYkm3DFlaetILUbiRpZGtBHqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNB/x2UZ7Tj9t8UsuaiaR4gzlQcVC4bLvg/QEEQ8+zE=;
 b=CgPyoVt0vMRtdGeKGpsMSEbKsHedPF1YuePyzJilj0uU3veBh7nlqmqRK0A7eyoqhkvl4z777wAgo40Cosyta87rcAlz10jS1u0ks6f+UxNYseuuDW7GZnlIvuc0/T8qvVTz8YkKWT1WGPQiuNgyiHIpFaRoSy/9SFaglB0OjEB43y6bxwJ4iM2NcVGNrlcl7ZD2xsppINWpB7k1uHQxsJpVtktLf9JVPiakODwuXKARQnTmYRLnH7L+MDEFrFugyNbj5PFfsm0O31x9K4EkMVmSKE0LYTnVQGwYfKQs5NnEiR0NCBjpE0gfja8ofstSXWIQlPrvjr+2mXZMretf+A==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW6PR12MB8959.namprd12.prod.outlook.com (2603:10b6:303:23c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 03:37:19 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 03:37:19 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Chao Yu <chao@kernel.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"jaegeuk@kernel.org" <jaegeuk@kernel.org>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "hch@lst.de" <hch@lst.de>, "song@kernel.org"
	<song@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, "cem@kernel.org" <cem@kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "yukuai@fnnas.com" <yukuai@fnnas.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "mpatocka@redhat.com"
	<mpatocka@redhat.com>, "Martin K . Petersen" <martin.petersen@oracle.com>,
	"agk@redhat.com" <agk@redhat.com>, Johannes Thumshirn
	<johannes.thumshirn@wdc.com>, Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	"snitzer@kernel.org" <snitzer@kernel.org>
Subject: Re: [PATCH V3 5/6] f2fs: ignore discard return value
Thread-Topic: [PATCH V3 5/6] f2fs: ignore discard return value
Thread-Index: AQHcXZzXmCoF0wg4KkOwIq06KMelyLUEQtCAgAAN5AA=
Date: Wed, 26 Nov 2025 03:37:19 +0000
Message-ID: <820ffbc8-56cb-4f47-9112-2f4a79524025@nvidia.com>
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
 <20251124234806.75216-6-ckulkarnilinux@gmail.com>
 <09e48eba-6f00-455a-8299-8b8bb4122c7e@kernel.org>
In-Reply-To: <09e48eba-6f00-455a-8299-8b8bb4122c7e@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW6PR12MB8959:EE_
x-ms-office365-filtering-correlation-id: 73e9fc54-b35c-4211-937e-08de2c9d1a40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Nm1mUG1PMS9SV3RrMWhoZ3JmczhMNE5RbDRZdTlvUFVveFIxY1ArRE5qY3c2?=
 =?utf-8?B?VWdYU2VnYnhiUnZBaDEvcWRDU01lR3J5TS9DOENCKzVOLytNWUd1cStwZkhO?=
 =?utf-8?B?UWMvbWxIS052QVJqczVZYkRvejJzb2RUSDhxU1hUR3lWMEQyM3JGQWx2eFNh?=
 =?utf-8?B?bUhwdWxNaHI2NUJCcy93WkdsRmJDS2ZIQm5UY25uVDNsTWJ1Mnhsakk4cnZ2?=
 =?utf-8?B?NHE4dlBoR1RoaStnekRWT2M2dlJwWFUyWlBkbEtja0ZVa0ppd05NQkRWakhw?=
 =?utf-8?B?ekNtdkhLY3lDeDBocHZBSGJYakYzU3VOcnBlYXlmTGZIRWZWV0FtcFVNNlRE?=
 =?utf-8?B?QXhpNW5DZDY3UkgrME0xVUtONGgzaXEwUkgvclJPVHBFZzJETFoyS21RRm1J?=
 =?utf-8?B?M3NjcndOUUZkTWE0TDJaVnYybzhUeWI3SzgwYUNwRHQrQ0psM2NGam80Q0Zs?=
 =?utf-8?B?U2d5VjlaTTRoUXFvVnl4TXFwZDVqQ2xKdWwwaFI4TDRuc2N0OVRrQmYwWWI1?=
 =?utf-8?B?eG5RQjNQUnRxMXNkaU9KYnZzUlVhQURBaWp2MDBSSjdNSzBPUzJ2cUFqZ3VE?=
 =?utf-8?B?TUNqbXp2Vi9VNzRlMGlvTnl2Y2hOUG1ZUVpoUU0xd01qTXlFaXpJcUh6d2lY?=
 =?utf-8?B?a2JEOWhLWUtCT2Z3N0dwR0E0TWtjQzY4b0dBd0RpaTc2cUEzSldHQlZ6Q0pB?=
 =?utf-8?B?YWFPYVJjL3VKVFBZZ0w4M1NSU2gzL1lpOVB5a2o2WjlFc3lKVFZLZW5DK0x6?=
 =?utf-8?B?cnNCNFJkaXNXWWFjRGFQNlhUTGRpR0J6M0tuUjM1dzlvTEZjbzFLZXQraWxm?=
 =?utf-8?B?VWEyYk9WOFcwdjFKTUhPbW9WUzl2bW5qZmdLZWp0ZnUrV1RMbnlVQ2o4VHlP?=
 =?utf-8?B?S2JIT2k5YkNLcW56N29UTnJCQWlhR1l0YXkrQUtReEphVXFPRUd0MGV0WUlQ?=
 =?utf-8?B?bmxiMDBtNHV6SFN3Z0k0QWtJdjdxWG9tdG9JSjBNcHdzc1F0QmZ4M3NMQTJa?=
 =?utf-8?B?Uis3MnFRcXk0MHVsdXhzSUIwRFZid3phdlI1Q0dBMEgxdjZReWVkSVlYY0o3?=
 =?utf-8?B?bW9CYWhGSlIwdzJrRU9USXVpQmJBRDNrbFlYNzlFbGQ0d3U2cU4vYkp2NTFY?=
 =?utf-8?B?YW1iWVJJT0V6N295RFBIZHBoZkQ5dExoS0txY2c2SXBWb0liM1VLdmhpeXRC?=
 =?utf-8?B?bXFRcm1xZG5rVXJoYjVzeTNEZy95anpWZ1dhczJyUUZaWGIyMWpqdVVNSE55?=
 =?utf-8?B?ZmMvdDBIdGxIU3JVdnBTZDc5Z1JtcHBRd01lZnBJb1VJenlROURibXdCektV?=
 =?utf-8?B?bmZsWGlPbUhqMDlMWEVLam5rL0tBUjg0R2R0a0JXd2RUU3ZJOFJCOTJOZGpx?=
 =?utf-8?B?UmxSc0tlREpnamhyanRXeUE5V1B5MXhjWldmdmdTc0xXbTd0SytwYVB3a1Rx?=
 =?utf-8?B?b0xpMHNtVWNDR1JvaVY0VnljUWFzOWJCSWZVQVFpOUJERFdmNC9ZWWVmRXRp?=
 =?utf-8?B?MVBESXh6Q1hWak94bGo2SlR2OVNZQW5GQ1Y5dzg1RHkxR1FFcjlZak91VVU0?=
 =?utf-8?B?bnhkK3grMXZOUmQyQ3BIVmxvQ1FManVXS2JFeTBjMHNQUVN0RFJaMlVWOVox?=
 =?utf-8?B?SGhXWkxCTmY3OVNuQlU4UmFaQVNsb1VmVFdreHZ3aEJGV1pjTlBuZGVrTEZ3?=
 =?utf-8?B?MUhqQUt4T2NJem5OZldKMHhpemNGM1BhSFBSZWtETnI4TnpIRnVSbmc2MGRk?=
 =?utf-8?B?MUhCcXpSbHhwSjVvckp1QzdVRFFWRFlTWW14cHhzV2tSdVRGejJKS0c0aG9X?=
 =?utf-8?B?RzRrMFdGaDJ1MTBUelVFQ2NXWWlkdWxGVUJ6a1NvVFJCS0lROVVzNTJMNDRm?=
 =?utf-8?B?Q3V6ZzQ2VUFKVTVCZm9Udi9RdHp1SnhUY1YvZWRMNWhnTDdkUCsycGlxdEtn?=
 =?utf-8?B?VldMTW5IYW1TL0hxT3gwN2dZanFLem9KanpPVnpzWlp3RjdQREJoeEI3R0FF?=
 =?utf-8?B?RXdEV2N6NVlILzNaQzVFc2t2c1BQNXQwSGhvMFEvVGRQN0w5K1BtQ1BnTkhT?=
 =?utf-8?Q?5wKw04?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QWtVdGJaejVsb1gxdzRyUEs5V1pnbHFsSG5vWmsrOFNZQ3pZeGk1UnBRd2hm?=
 =?utf-8?B?WHNNazhiNmJTT2hMQ3RSZWhPRkhOQ0ZkOFZDSDZvOExzQ01LTkNjMTl5OStD?=
 =?utf-8?B?RlAzY20velJHeHA0d3BuK2NsU0RNWjFtRXBMdWJwamZhQTBTandZb05UVWdw?=
 =?utf-8?B?QTZnb2NOQThmaGdDNUlnbGdFb012SE5GRU5oMTZRQytXOTNxaEp6blBVL29T?=
 =?utf-8?B?K2JQSkdUUVJGUnZmWkZoUHNDazFLS09FZFk1YWVDMzR1Qlg1b28zSzZQbm9C?=
 =?utf-8?B?WVRSNUZQdzNIai9mR0JVQUJXS2hxM2g5SmMyY2xLejNBQmF6R2Q1dWpoTlZx?=
 =?utf-8?B?Vkc3NVhFeWdQdGp1Zzd2MHUzbytWNVcyaTAwWnFQcmN6L004ZjRnWk03ekhm?=
 =?utf-8?B?aWNHZDJrL3Y3a01SNEVXVlM3OUFxS1VpQm96THFuVjVBRXVRNzBsM1J3bVlr?=
 =?utf-8?B?VTJGbzh2OHBuVExMdmgxWFZpRGV4NjRLZ3FLSHQ0Um1FblhBNERwVHJyK2Rp?=
 =?utf-8?B?dzhpNG1zbEdTZWZPcGVmSEllSkUwTnBKS2tOUTd2eGtFSUIvSkZGQnJIN3RL?=
 =?utf-8?B?Ump1ZjFCTi9OdkFYYk5yWEpEMHkvRWhXVWlYaHpRZEVNRmp6YkFDMnFYaFh4?=
 =?utf-8?B?SHRWNmJvNjJvb0ZUZjRzcDUya1ZTMktGZEdjdXIwU2FiWllJc2FVaEhxVzVu?=
 =?utf-8?B?dTh3ckJNV1ZOZHRST1pXT2dlUkI5STBpQi84ZXh6eVZhRkRXbk5COHpCN0Zv?=
 =?utf-8?B?YVhISi9udnBjSllKMVkwenBMUDFKUFlsTmJkdkxXUkQyVnVHWVAvZm1XeXc5?=
 =?utf-8?B?bGFQQ0IvdEQ4ZGNiYmN2cVFQeWtaZFpnSng2YWVHUE9qWmNueHIwbTFpckZU?=
 =?utf-8?B?UXNueDVsbEQ0bDE2N1Y3UXB3R1Vici9wNk5YVTdQNStVWnk1dkJrdHRyVFpy?=
 =?utf-8?B?bUozTEhJQzRtOHV6MG42YzNBTS9KL0lYaEpnK3U4dllxSXVyMVoxd3c0dXh6?=
 =?utf-8?B?akxTRUIwQ0ZPaGI0aHp5OTN4cE5UQnNzY1VZRjhERFQrZCs1MzFINkJzcUZF?=
 =?utf-8?B?TkY2YnFaZ2xZTjIxMWxvb2NqQmFjdFVVUkhoYXl1UWcrLyt4QlFkeE5ISGlh?=
 =?utf-8?B?K0x6RHk1bmpnZ3FJK2hQN05mVU5ZRFVLZGswWEZwbG5yL0g5d0VKR3BOd1B4?=
 =?utf-8?B?dW54ZW5wK0xqVDEvT1huWGhaMzhJaE1MUnJXOFBtODdyV2c3U1hnWFIyeXZY?=
 =?utf-8?B?VVhDQ2lzS3R0ODhsRU9iTDNkalpGdTFHamNwMm11YUx0QlE0SGdsVlFiNmVY?=
 =?utf-8?B?dHZ6WFZFQTZWY1BoRlZmWHdCd2J1SFR6VDM0dHdRcnVFTVBEU2dUU3Nqek5C?=
 =?utf-8?B?TEJxVFRoem50L2ZGZVFYU095azMrTjVjV3NrZThjbjBOc1NscjFzWjQwMGlR?=
 =?utf-8?B?VzNRZFFhT3BtN1BuY1BiRU1Sbk1kRVB0cCs3bWxYMjRSKzJRYzZzU01QZTRj?=
 =?utf-8?B?Zk1md1ZCaGZjeGY3dmo0M2ZiZmw4bmc2WUFSallPWGZBT0VySEtpWlczaVdH?=
 =?utf-8?B?QVVKK09wR3hZL1NTTVBNL1h0dlRmNVZMbm5PYjkvSHhCbGVBZEx4MFpMTk5Y?=
 =?utf-8?B?VVlucjlIZkVGa3FyQnBmbGdCeGdaUHVQMW1GVUp5WmJYeFVOdjc0b1dNUGFv?=
 =?utf-8?B?Wkl2aXQ5WkNKZ1ZuWWlOZFc4c2w4cGhVcUI2bEhaU0kzMkRsb1NFNkFCNmNF?=
 =?utf-8?B?L3dVNkQxLzl6NSttU2ZBWjJOUFJrM3EzeW9ZQktXTDNLRVF0Nlgvckk1dW1K?=
 =?utf-8?B?disvaDE3bUxXbDJtbTNNcnBNSVJTdmNFV2k3Z0xZTERwOUVydTMyT1JaK2Ro?=
 =?utf-8?B?Z280Q2tNQzc3M3ppSncySnV0K2tQRnNheWlQbmlwa2ZwclJFZHhJdXY4V3Fs?=
 =?utf-8?B?WGhGY01RMitGQTZrd2NDN0dXbllabGFlZVZxUGt5ZlNoRDd2b3ZwWUdhT2ZW?=
 =?utf-8?B?ZjNvalkzTjhBaDJKVnV6bmVqdEFrdzN0b00rWG1qRXptdTkrbGtVdm1GR1J2?=
 =?utf-8?B?WHNQZEtXNlN1NENhYk9IUVJoQk1VVVFEK2hOakNKUmo3QVlKUWd6U3RhOGJa?=
 =?utf-8?B?QnVqN2dDeGpmN2dEclNUUkNVa2pvMVhWNFJwZ3RFOGlrM0VNOEtDMDJUcS9Y?=
 =?utf-8?Q?uPb4wJmBKZ/EATaAbhsaUL3oWrPx+yBmmFqYtBLlCVla?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <28F68F3103F5BC449EB1FFE745677DAD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e9fc54-b35c-4211-937e-08de2c9d1a40
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 03:37:19.4648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c6l5T1zPk/9RgMWdR4AG1EEpJGnw/L51Anmfo7A98TogefJ79JTd2koO91JKi0/Rk9z2DJ3zei4bSqVrfZ478Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8959

T24gMTEvMjUvMjUgMTg6NDcsIENoYW8gWXUgd3JvdGU6DQo+IE9uIDExLzI1LzI1IDA3OjQ4LCBD
aGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+PiBfX2Jsa2Rldl9pc3N1ZV9kaXNjYXJkKCkgYWx3
YXlzIHJldHVybnMgMCwgbWFraW5nIHRoZSBlcnJvciBhc3NpZ25tZW50DQo+PiBpbiBfX3N1Ym1p
dF9kaXNjYXJkX2NtZCgpIGRlYWQgY29kZS4NCj4+DQo+PiBJbml0aWFsaXplIGVyciB0byAwIGFu
ZCByZW1vdmUgdGhlIGVycm9yIGFzc2lnbm1lbnQgZnJvbSB0aGUNCj4+IF9fYmxrZGV2X2lzc3Vl
X2Rpc2NhcmQoKSBjYWxsIHRvIGVyci4gTW92ZSBmYXVsdCBpbmplY3Rpb24gY29kZSBpbnRvDQo+
PiBhbHJlYWR5IHByZXNlbnQgaWYgYnJhbmNoIHdoZXJlIGVyciBpcyBzZXQgdG8gLUVJTy4NCj4+
DQo+PiBUaGlzIHByZXNlcnZlcyB0aGUgZmF1bHQgaW5qZWN0aW9uIGJlaGF2aW9yIHdoaWxlIHJl
bW92aW5nIGRlYWQgZXJyb3INCj4+IGhhbmRsaW5nLg0KPj4NCj4+IFJldmlld2VkLWJ5OiBNYXJ0
aW4gSy4gUGV0ZXJzZW4gPG1hcnRpbi5wZXRlcnNlbkBvcmFjbGUuY29tPg0KPj4gUmV2aWV3ZWQt
Ynk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo+PiBS
ZXZpZXdlZC1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+PiBTaWduZWQtb2Zm
LWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGNrdWxrYXJuaWxpbnV4QGdtYWlsLmNvbT4NCj4+IC0t
LQ0KPj4gICBmcy9mMmZzL3NlZ21lbnQuYyB8IDEwICsrKy0tLS0tLS0NCj4+ICAgMSBmaWxlIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0
IGEvZnMvZjJmcy9zZWdtZW50LmMgYi9mcy9mMmZzL3NlZ21lbnQuYw0KPj4gaW5kZXggYjQ1ZWFj
ZTg3OWQ3Li4yMmI3MzZlYzljNTEgMTAwNjQ0DQo+PiAtLS0gYS9mcy9mMmZzL3NlZ21lbnQuYw0K
Pj4gKysrIGIvZnMvZjJmcy9zZWdtZW50LmMNCj4+IEBAIC0xMzQzLDE1ICsxMzQzLDkgQEAgc3Rh
dGljIGludCBfX3N1Ym1pdF9kaXNjYXJkX2NtZChzdHJ1Y3QgZjJmc19zYl9pbmZvICpzYmksDQo+
PiAgIA0KPj4gICAJCWRjLT5kaS5sZW4gKz0gbGVuOw0KPj4gICANCj4+ICsJCWVyciA9IDA7DQo+
PiAgIAkJaWYgKHRpbWVfdG9faW5qZWN0KHNiaSwgRkFVTFRfRElTQ0FSRCkpIHsNCj4+ICAgCQkJ
ZXJyID0gLUVJTzsNCj4+IC0JCX0gZWxzZSB7DQo+PiAtCQkJZXJyID0gX19ibGtkZXZfaXNzdWVf
ZGlzY2FyZChiZGV2LA0KPj4gLQkJCQkJU0VDVE9SX0ZST01fQkxPQ0soc3RhcnQpLA0KPj4gLQkJ
CQkJU0VDVE9SX0ZST01fQkxPQ0sobGVuKSwNCj4+IC0JCQkJCUdGUF9OT0ZTLCAmYmlvKTsNCj4+
IC0JCX0NCj4+IC0JCWlmIChlcnIpIHsNCj4+ICAgCQkJc3Bpbl9sb2NrX2lycXNhdmUoJmRjLT5s
b2NrLCBmbGFncyk7DQo+PiAgIAkJCWlmIChkYy0+c3RhdGUgPT0gRF9QQVJUSUFMKQ0KPj4gICAJ
CQkJZGMtPnN0YXRlID0gRF9TVUJNSVQ7DQo+PiBAQCAtMTM2MCw2ICsxMzU0LDggQEAgc3RhdGlj
IGludCBfX3N1Ym1pdF9kaXNjYXJkX2NtZChzdHJ1Y3QgZjJmc19zYl9pbmZvICpzYmksDQo+PiAg
IAkJCWJyZWFrOw0KPj4gICAJCX0NCj4+ICAgDQo+PiArCQlfX2Jsa2Rldl9pc3N1ZV9kaXNjYXJk
KGJkZXYsIFNFQ1RPUl9GUk9NX0JMT0NLKHN0YXJ0KSwNCj4+ICsJCQkJU0VDVE9SX0ZST01fQkxP
Q0sobGVuKSwgR0ZQX05PRlMsICZiaW8pOw0KPiBPaCwgd2FpdCwgYmlvIGNhbiBiZSBOVUxMPyBU
aGVuIGJlbG93IGYyZnNfYnVnX29uKCkgd2lsbCB0cmlnZ2VyIHBhbmljIG9yIHdhcm5pbmcuDQo+
DQo+IFRoYW5rcywNCg0KVGhhdCB3aWxsIGhhcHBlbiB3aXRob3V0IHRoaXMgcGF0Y2ggYWxzbyBv
ciBub3QgPw0KDQpTaW5jZSBfX2Jsa2Rldl9pc3N1ZV9kaXNjYXJkKCkgaXMgYWx3YXlzIHJldHVy
bmluZyAwIGlycmVzcGVjdGl2ZSBvZiBiaW8NCmlzIG51bGwgb3Igbm90Lg0KDQpUaGUgZm9sbG93
aW5nIGNvbmRpdGlvbiBpbiBvcmlnaW5hbCBjb2RlIHdpbGwgb25seSBleGVjdXRlIHdoZW4gZXJy
IGlzIHNldCB0bw0KLUVJTyBhbmQgdGhhdCB3aWxsIG9ubHkgaGFwcGVuIHdoZW4gdGltZV90b19p
bmplY3QoKSAtPiB0cnVlLg0KT3JpZ2luYWwgY2FsbCB0byBfX2Jsa2Rldl9pc3N1ZV9kaXNjYXJk
KCkgd2l0aG91dCB0aGlzIHBhdGNoIHdpbGwgYWx3YXlzDQpyZXR1cm4gMCBldmVuIGZvciBiaW8g
PT0gTlVMTCBhZnRlciBfX2Jsa2Rldl9pc3N1ZV9kaXNjYXJkKCkuDQoNClRoaXMgaXMgd2hhdCB3
ZSBhcmUgdHJ5aW5nIHRvIGZpeCBzbyBjYWxsZXIgc2hvdWxkIG5vdCByZWx5IG9uDQpfX2Jsa2Rl
dl9pc3N1ZV9kaXNjYXJkKCkgcmV0dXJuIHZhbHVlICA6LQ0KDQozNTQgICAgICAgICAgICAgICAg
IGlmIChlcnIpIHsNCjEzNTUgICAgICAgICAgICAgICAgICAgICAgICAgc3Bpbl9sb2NrX2lycXNh
dmUoJmRjLT5sb2NrLCBmbGFncyk7DQoxMzU2ICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChk
Yy0+c3RhdGUgPT0gRF9QQVJUSUFMKQ0KMTM1NyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGRjLT5zdGF0ZSA9IERfU1VCTUlUOw0KMTM1OCAgICAgICAgICAgICAgICAgICAgICAgICBz
cGluX3VubG9ja19pcnFyZXN0b3JlKCZkYy0+bG9jaywgZmxhZ3MpOw0KMTM1OQ0KMTM2MCAgICAg
ICAgICAgICAgICAgICAgICAgICBicmVhazsNCjEzNjEgICAgICAgICAgICAgICAgIH0NCg0Kd2hp
Y2ggd2lsbCBsZWFkIGYyZnNfYnVnX29uKCkgZm9yIGJpbyA9PSBOVUxMIGV2ZW4gd2l0aG91dCB0
aGlzIHBhdGNoLg0KDQpUaGlzIHBhdGNoIGlzIG5vdCBjaGFuZ2luZyBleGl0aW5nIGJlaGF2aW9y
LCBjb3JyZWN0IG1lIGlmIEknbSB3cm9uZy4NCg0KDQo+DQo+PiAgIAkJZjJmc19idWdfb24oc2Jp
LCAhYmlvKTsNCj4+ICAgDQo+PiAgIAkJLyoNCg0KLWNrDQoNCg0K

