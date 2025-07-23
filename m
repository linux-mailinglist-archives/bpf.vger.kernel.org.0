Return-Path: <bpf+bounces-64140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB751B0E925
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 05:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98BA01C281BD
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 03:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F3E246BB3;
	Wed, 23 Jul 2025 03:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="c62OpTqn"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A324D599;
	Wed, 23 Jul 2025 03:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753241809; cv=fail; b=Tr58EfvBsSy906+Pa95Tv2s7TuWbhwealXnpbNnMXcU49TG6Iz2AHx/aO02wXryl6EyakTjjkLB8Wz8SmyLBsqs2cej07N4tqIPvzjeMPNiwa41/dxu8Km9gclu1q+LMG/HzMr3OatHHKSNQCbd8Lbc+j4qSoe7HS83hGtkHeBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753241809; c=relaxed/simple;
	bh=tb/YGFbsJIY+I1UMmI82085DdFsAoJ9eGKbfk2NYKhY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VYPBgjP1lEXSUDG3J+46ewRl4FpAr1HkVEr0XW3N+LH4M/JnNSmnV6jpiYiAuj/xRAo8NZxCD14rQ0kUalo/e012UhyNonOEB4eUvnnpdOBtTRrMMvk8XP43MyMjh+d2PBJEGdVsx18lvlzX2vQn0XFDV/tIbFRvMIl97icIfMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=c62OpTqn; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MNT4Ct023953;
	Tue, 22 Jul 2025 20:36:13 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2101.outbound.protection.outlook.com [40.107.236.101])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 482mbpgexs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 20:36:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rip2gBNYOSlYPcUch8Qxe8q7PHW39zLQmnpw4uuMT9TzVQ8zaxO9IPcmniFOtmtkkcuZ+sUMrSKXFbkcZ0NOt7SGnY2lDnkKNh5bpTnBWQ5q/rV4FvDx9kdOAaclSwj1hlvIOs0UbIGHT20ELf7AZlank3KlXfRKD9OXe0gTSrV0rYBRM8fz9WZwtEJb+reSwqTJnBE3yvUylhih4yILaFC96EGlJGg/u2sUgjP/ne8PEq4DGQqWCBPWFi1w/jz3x0o6VGKgSu0+OKRXm83KTaLCjovQvfUxJuZaSBd6KJbuqNoeViI040QQDNea25HX2LshSlrTCWL1JdLEBmzCnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O++cWi1jixILC9MuDT54UQxdYj42eSjFD0r1fK3aoAg=;
 b=S/P6DKfM7U7Sr1y9dRq8d/48T0TbMjcRDQ74HQ15VNNrNhODuRqTh7482qN1ZXOxH8nJQQ7njgeb1tYESVZU8GzN9yWuufcFpgb5z4pZTw9ovH6qVv/JrY3VKqZb5EPknG/88WHJYmN9ZdcKfqoKSTareiPkl63c2c6MOjy8tfpide884pMZJpPETDWDRGc6hhtTjFiGByYCkFbbnCpNoPYwINUjWTJ332Nwn9FcJMuXEfyuUOVA6I6er4xoxaClatryMzf8QuavGyvu3jDhf7Met1nqKtuZKaFlidP0Oc0s0xbHF2B50fhf/ZlCfh70awusHhKjeVijKlKjT65/oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O++cWi1jixILC9MuDT54UQxdYj42eSjFD0r1fK3aoAg=;
 b=c62OpTqnhyF0L1pptFsQd08vvbhFkwJAzvsL2R2f3c+AsQkF/LGmrxUXfyVHR02KRn5zjL9qpOzHAzTndAz/AP8uNueVcKFadPkz5HmkBevsyFK/akyoZg22bqu7wV1KU5rSMGS7mQS8VHy/UgZkMlIpwoi6xbeuUuGK4xwPbEI=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by LV8PR18MB5606.namprd18.prod.outlook.com (2603:10b6:408:185::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 03:36:10 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%3]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 03:36:10 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Chenyuan Yang <chenyuan0y@gmail.com>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Bharat Bhushan
	<bbhushan2@marvell.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "hawk@kernel.org"
	<hawk@kernel.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "sdf@fomichev.me" <sdf@fomichev.me>, Suman Ghosh <sumang@marvell.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>,
        "zzjas98@gmail.com" <zzjas98@gmail.com>
Subject: RE: [EXTERNAL] [PATCH] net: otx2: handle NULL returned by
 xdp_convert_buff_to_frame()
Thread-Topic: [EXTERNAL] [PATCH] net: otx2: handle NULL returned by
 xdp_convert_buff_to_frame()
Thread-Index: AQHb+2lU4wFzGbPA1UmAQDcm5IfxlrQ/BrOQgAAHPVA=
Date: Wed, 23 Jul 2025 03:36:10 +0000
Message-ID:
 <CH0PR18MB4339EE7E08DBD7A4F6E3EA72CD5FA@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20250723003243.1245357-1-chenyuan0y@gmail.com>
 <CH0PR18MB43399E06C1EDC7DE70AE7170CD5FA@CH0PR18MB4339.namprd18.prod.outlook.com>
In-Reply-To:
 <CH0PR18MB43399E06C1EDC7DE70AE7170CD5FA@CH0PR18MB4339.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|LV8PR18MB5606:EE_
x-ms-office365-filtering-correlation-id: 87b4b412-482d-4836-5a86-08ddc99a10d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?W8wrR09ocAXj11CV5s9GCQA7yDBwxid7UJPqc8JLRXqrqyYV4w0C0Hy6epCu?=
 =?us-ascii?Q?O9gRAlGdxqO6ExB923ni3FKFZEaQJmVlrSyMmQNINyyO2SN7adQ7QzHPrjeL?=
 =?us-ascii?Q?+pDyo03KdNDHWF5ETCMl9UEKqWAtkHf/nVLnZMN9hw10zYdLExWSq9NkfNp4?=
 =?us-ascii?Q?wjcv2D5KHiOKfyINGs6pdhj6RHoK2yY7QM5Ae1J7OWo6BbCcdfxk5fuax9zN?=
 =?us-ascii?Q?BSVpNxccr1cpnw79lyOJ+wF8mkQkqBaR7gmd//feM9M+QYihzPNd93rWpiVE?=
 =?us-ascii?Q?2NgWShM+IRhzyKeYtHPskfpOVa/Lw3sNSGS0Ju0n7aOY7U+MqWxg5sfh5IaW?=
 =?us-ascii?Q?Qz8yB85vQKVzz3BXxZEbnoIhLLuC9VdUX31nxELlNTIn2qSULMVKJNKP+lT5?=
 =?us-ascii?Q?i/XwlvzXlouluuHTEKhHP7f3dPiPjUO2e7eZMzxA0hyCAs/EWrFJImS8eMbg?=
 =?us-ascii?Q?0XFRFSsUCUNHZLgIRe9uJNH+6T8DpkHAVw/2fcUJp9e6QIet65rE/8YrKSFb?=
 =?us-ascii?Q?+6q0Y8Y/fEBpNdaShfl5n/0mbZwMiT4q5EUoHoDqfCH2Ckr+fCGjIujmtwva?=
 =?us-ascii?Q?fTQx/pvo1IXRh8+LPbD01tv4ZwgRSctr+zGY750SIC0nMBamqNoYkGTFE0rk?=
 =?us-ascii?Q?HGg44BkRKQMS3YYJqGmG4XeVX6R9dJWHF/ONNSrGWi8iSm/BPSOKXmQIMCbB?=
 =?us-ascii?Q?M0S/JbExICauDqIlRv0TTDbou7JPzhgs7PyYaCkpEIifHrD1874RvJSXp0mx?=
 =?us-ascii?Q?2HbxJ9RPQ7BMVvGorvyEXKVzEGHLTe1c8p4y4gTVig5svSsb7A0Tg90wmh5+?=
 =?us-ascii?Q?zX2UaVI7tsZi8FXZJgwQR3VB5JpwGcPic8bXSU0fXxtI+CGygrxGC7wavKPw?=
 =?us-ascii?Q?NVNMcuTMf/YoWYfajVPt/hpug5rw8L38seV8lURYNNjN6wLGtOcMlye1uomy?=
 =?us-ascii?Q?ZHHPsmKoUsHbz7y3P1lsy4afWqOEsbWs5mv264ZPVlk3zVSYYbghlaGyjet3?=
 =?us-ascii?Q?T6KfZx8SPnzYHYU4TzLh23Zidc0ExXbqENV9y4oMRpn4zhqstKFEHSQseZq3?=
 =?us-ascii?Q?+FsxBy4Pr6CZtdsfP8TkkEfyjdl27neuUP/nCKK4s0WiP4P/HJ6N3lZfAQDn?=
 =?us-ascii?Q?wZ5KUkYGYKjVrzclXRUSQyqZ3HyMqQ+MG+cw9N0aOgNw8Oj5QxgIoDXLfVfR?=
 =?us-ascii?Q?AxeqHM7xjHESQ0NlKW+dQ1I2fMHinyTOb0ai2H0SriZtNtxUpuE7J9gOs/u+?=
 =?us-ascii?Q?yq/2tr77kC+bidwaMrpHhpligYzaoyTA4OywMPaw9t4/ksc4ahgkmI6SBEl8?=
 =?us-ascii?Q?BfPAAbvnBCliXevH/2NfgrJPqxbfmvu8dFRstjQEKkmAMnP30mgVqQoJkcol?=
 =?us-ascii?Q?xbbojWPP3KHM+D/allJGV0Ao9dGVu5rKB9p7vF+P461vZJjAW7NyXKHFS6lc?=
 =?us-ascii?Q?AzCCxSmLNWucCAbuRpEntjJXqLzMbDmzqIZncjWAZHO288f6BAXIOUKKkOoI?=
 =?us-ascii?Q?TBKxewG9JNdK2t0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?USYXqP20rRU9E2q/LUcjM3izxpk3bBmzmfaBq/EIjBtGN4+6JnECWoRwC/g0?=
 =?us-ascii?Q?yHW1wyTxtQcPd9RFarntQJ+b2uwnzZisW8ZYmm2VnlpI9f+WyUfQIJ2YE0IU?=
 =?us-ascii?Q?bWg0wfTXlAdyn4NJcI1xKtEjBLmkyTdkiM6iwzsU2TIlM5UZS5p/u3VkBqyT?=
 =?us-ascii?Q?ZIZuCzC31zxFTkBGDXIDCaqW6eaL4d4eJJd568L8lZeU0cEpVf+wrpBkA6zk?=
 =?us-ascii?Q?zlwSUC90jATmOOSnjZSHUHjyMNBih7X0/RlxEei5rLIbaDNeyHAZKgC1nb25?=
 =?us-ascii?Q?G3GR8MYGCNMBIA0+ewUHt8PGqBW3BRcKsHjhU7IOOZNacj00vhq3jctJxjsk?=
 =?us-ascii?Q?n6f/Bz+oYKxpxfzmDLjxrDS8fUtxQo/ehTk10r7lYKcbucpgbb2JOXqPczMa?=
 =?us-ascii?Q?xw0swhRcFwrViitQ0UUQQfmfxcygTo/rOjkI3x1lOY/XH9rA58gq/ZxXgw1s?=
 =?us-ascii?Q?aYElyfm5ORGiLK4OQea/GqYtcTrLl1ZEFg0F6Isv4BiQY3kK8Qpgjoj5A4SJ?=
 =?us-ascii?Q?dMIv6sjuWGLi6WeQOCqHhthMbtBM0QNNRFnFRNp8E783v0R4VjQ6nwPd/w9n?=
 =?us-ascii?Q?IlWYocaFSfGExLfkstV8DQqCFtuiv2ZjVbR7Ktli3t3D06Ie5MVFv3r2i4fE?=
 =?us-ascii?Q?0VrUNX/8B6S70O6//AHisBeY/n4kIPATRklpu5Ux9kyWihb33UhBJHEa7S66?=
 =?us-ascii?Q?8nRFCDmLIaO1gCa38bVTTPeUK58mqYSY7odeWg92Tc2j4sJm72OTOsZGc1V3?=
 =?us-ascii?Q?29QNXzJdfrZJn3li7bUcY8HdNID1wNdPq7V7Y4xhQZcoj+hGa5CeFpHCGFzx?=
 =?us-ascii?Q?isKVVKXxRg8VUBdbRIsLXVcSZYouiXe8qJKPzofHIZ6jy4b65aHJOD39xMUe?=
 =?us-ascii?Q?dlFJMlzZYUJMT/14/jnDDtl5ZLVi8KjwOTnOP5L19yrfATz6nz9/VQk40wJv?=
 =?us-ascii?Q?LiO4QrH7S62/CNJ3e5zhv7BKN5T70xX4aL2XMVle2fSnlkmj+iSUuCqdtKmh?=
 =?us-ascii?Q?qRvw5uqxbPm60qwfOINoqonw7kS7CqEBMSUGadhiTxOguoPfzfGhwU/0QKex?=
 =?us-ascii?Q?Qmq6MryOjeublpTZQ9GIdhNcIa6SLFmp3DWQih0HStN0snP4XBnbDRWpSdmn?=
 =?us-ascii?Q?cLxtlDnlH5D7lDFa4pZylaGH+E8dkM3+LPmqdgPeCc9yM8/jtJxgQWbPAlC6?=
 =?us-ascii?Q?/OXM3tfKkc4Es7Q/VPJXWGIgAB9EiL4AU+wYR5RDI6SjmQI4kqgbjb+SuoeV?=
 =?us-ascii?Q?Dl6KaGN64DtJm+jNa+CUu29FM1htojmnyjc2oTUwXWA8HgO9/i8KMZ64Ft6P?=
 =?us-ascii?Q?jFIjBl2xqfyIVPxtGPSEOb2iJWGjayr+Duf4tTXXvw0RHPDGhv2pViOMmktN?=
 =?us-ascii?Q?kbnFeYP48hnPSsFDq2iZhrmkeev3XBRYWbpFoJjYpNRjtljKTIkGvOh9VL1r?=
 =?us-ascii?Q?jHBhHTFi4j7/5Gov4CLxLpDUlrIvVojVvLFZk1nohh0l0SUX6C1cEtDSp+R6?=
 =?us-ascii?Q?U4vjxGYVg+9vZa1uijyXaWgqgZzgpVn4oBaE54BzZH8TE8oCnxSFGZu4FvSH?=
 =?us-ascii?Q?0X7IFQAWRYdkdejY0qk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b4b412-482d-4836-5a86-08ddc99a10d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2025 03:36:10.0337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: miN/YnPL7FvNJn8IoAHKytY18v5KEIemOfolhyUzFTkQoKGrSFc+LEb25kiKzvt4b8MvtHqBtfSN2Y/BfpY2xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5606
X-Proofpoint-ORIG-GUID: xt1zUO-eir406n7TnLEdvH_xa0ye4JU-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDAyOCBTYWx0ZWRfX5MedzETM2i2x EBXMxqkBq81CdBavMI3rMhDMpSD7m3bBvaqc20EN4+rGRKFFIdO9kLoezaq1PcUfTZoM4hvSk7i 3k8NjjdsI7Pv1BK5Z5gEiui1oXZWBJ+3jm7skKSNYBPQdnlw0Wdu6mZyDM8nv67Qk2n5pzis8GY
 y2TSddNM6+CWntXWYrf+D8+QreUmv2gkago6NIBtGs/HMpv5AlBl2MLz0OSQaDTBRA2Tj5l/hyh PzSd2uAj/QY8fxIiuHHfCbr5Ay8njLm4lMc5JD1GaGFviATrk6R6tGibPSS/htQQYQWi+bXe/sd YfcX/4JBf8gRyHKyohIcOC9m267MH63er/hTG/Xu2ZfIofY5sMCjbgRtHY+UBlkh0YxX03w22Xu
 YeybQOZPr6a+VeAhFUsTlnZ0lFHja0IFQR77+AzJm3DNnXqckdaIxyQJbGyqksZYSyadzr7t
X-Authority-Analysis: v=2.4 cv=dYKA3WXe c=1 sm=1 tr=0 ts=688058ac cx=c_pps a=UR/7QJurQQQpTDv4aqHftg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=-AAbraWEqlQA:10 a=pGLkceISAAAA:8 a=M5GUcnROAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=hWMQpYRtAAAA:8 a=ajnLPPL6W8prcFB2n4gA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=y1Q9-5lHfBjTkpIzbSAN:22
 a=KCsI-UfzjElwHeZNREa_:22
X-Proofpoint-GUID: xt1zUO-eir406n7TnLEdvH_xa0ye4JU-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01



>-----Original Message-----
>From: Geethasowjanya Akula
>Sent: Wednesday, July 23, 2025 8:59 AM
>To: Chenyuan Yang <chenyuan0y@gmail.com>; Sunil Kovvuri Goutham
><sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
><sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>; Bharat
>Bhushan <bbhushan2@marvell.com>; andrew+netdev@lunn.ch;
>davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
>pabeni@redhat.com; ast@kernel.org; daniel@iogearbox.net;
>hawk@kernel.org; john.fastabend@gmail.com; sdf@fomichev.me; Suman
>Ghosh <sumang@marvell.com>
>Cc: netdev@vger.kernel.org; bpf@vger.kernel.org; zzjas98@gmail.com
>Subject: RE: [EXTERNAL] [PATCH] net: otx2: handle NULL returned by
>xdp_convert_buff_to_frame()
>
>
>
>>-----Original Message-----
>>From: Chenyuan Yang <chenyuan0y@gmail.com>
>>Sent: Wednesday, July 23, 2025 6:03 AM
>>To: Sunil Kovvuri Goutham <sgoutham@marvell.com>; Geethasowjanya
>Akula
>><gakula@marvell.com>; Subbaraya Sundeep Bhatta <sbhatta@marvell.com>;
>>Hariprasad Kelam <hkelam@marvell.com>; Bharat Bhushan
>><bbhushan2@marvell.com>; andrew+netdev@lunn.ch;
>davem@davemloft.net;
>>edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
>>ast@kernel.org; daniel@iogearbox.net; hawk@kernel.org;
>>john.fastabend@gmail.com; sdf@fomichev.me; Suman Ghosh
>><sumang@marvell.com>
>>Cc: netdev@vger.kernel.org; bpf@vger.kernel.org; zzjas98@gmail.com;
>>Chenyuan Yang <chenyuan0y@gmail.com>
>>Subject: [EXTERNAL] [PATCH] net: otx2: handle NULL returned by
>>xdp_convert_buff_to_frame()
>>
>>The xdp_convert_buff_to_frame() function can return NULL when there is
>>insufficient headroom in the buffer to store the xdp_frame structure or
>>when the driver didn't reserve enough tailroom for skb_shared_info.
>>
>>Currently, the otx2 driver does not check for this NULL return value in
>>two critical paths within otx2_xdp_rcv_pkt_handler():
>>
>>1. XDP_TX case: Passes potentially NULL xdpf to otx2_xdp_sq_append_pkt()
>2.
>>XDP_REDIRECT error path: Calls xdp_return_frame() with potentially NULL
>>
>>This can lead to kernel crashes due to NULL pointer dereference.
>>
>>Fix by adding proper NULL checks in both paths. For XDP_TX, return
>>false to indicate packet should be dropped. For XDP_REDIRECT error
>>path, only call
>>xdp_return_frame() if conversion succeeded, otherwise manually free the
>>page.
>>
>>Please correct me if any error path is incorrect.
>>
>>This is similar to the commit cc3628dcd851
>>("xen-netfront: handle NULL returned by xdp_convert_buff_to_frame()").
>>
>>Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
>>Fixes: 94c80f748873 ("octeontx2-pf: use xdp_return_frame() to free xdp
>>buffers")
>>---
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c | 8 +++++++-
>> 1 file changed, 7 insertions(+), 1 deletion(-)
>>
>>diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
>>b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
>>index 99ace381cc78..0c4c050b174a 100644
>>--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
>>+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
>>@@ -1534,6 +1534,9 @@ static bool otx2_xdp_rcv_pkt_handler(struct
>>otx2_nic *pfvf,
>> 		qidx +=3D pfvf->hw.tx_queues;
>> 		cq->pool_ptrs++;
>> 		xdpf =3D xdp_convert_buff_to_frame(&xdp);
>>+		if (unlikely(!xdpf))
>>+			return false;
>>+
>> 		return otx2_xdp_sq_append_pkt(pfvf, xdpf,
>> 					      cqe->sg.seg_addr,
>> 					      cqe->sg.seg_size,
>>@@ -1558,7 +1561,10 @@ static bool otx2_xdp_rcv_pkt_handler(struct
>>otx2_nic *pfvf,
>> 		otx2_dma_unmap_page(pfvf, iova, pfvf->rbsize,
>> 				    DMA_FROM_DEVICE);
>> 		xdpf =3D xdp_convert_buff_to_frame(&xdp);
>>-		xdp_return_frame(xdpf);
>>+		if (likely(xdpf))
>>+			xdp_return_frame(xdpf);
>>+		else
>>+			put_page(page);
>Thanks for the fix. Given that the page is already freed, returning true i=
n this
>case makes sense.
This change might not be directly related to the current patch, though. You=
 can either=20
include it here or we can submit a follow-up patch to address it.
>> 		break;
>> 	default:
>> 		bpf_warn_invalid_xdp_action(pfvf->netdev, prog, act);
>>--
>>2.34.1


