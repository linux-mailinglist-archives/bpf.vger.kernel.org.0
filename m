Return-Path: <bpf+bounces-57531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 182DDAAC826
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 16:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434F31C42E31
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 14:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16122820B8;
	Tue,  6 May 2025 14:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="zODD1vgX";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="JjRwhiEG"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8179F145B3E;
	Tue,  6 May 2025 14:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746542173; cv=fail; b=rTN+8Kffazqa63vHL/yzkxqKAWG7E5W6wcGrpUfyEoHozBWaGxRmq83fBngxfQAdtq36dLd8lIriC0Tbmt9AQ9KwjAklQIK6ETBLo5Q3VBX7u9f3CifQZEHsf9ab7RSXqfqw4GCM6cIBpAD/8VVuwtxPFVio25NVmmagYoQ1hsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746542173; c=relaxed/simple;
	bh=X9BptfYbkhnnBCz9NB4o3KRO/MBl12ZimdzPfIdLG2g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fmPo/oIqtd/8vSbgqxrVIGL2oXTDEAJkrxA230NclcFFVyGiC3JobRdrI9TR/yiFuIUsLlJ5WZLPhqzMqJW+o8UKbwjoreqY2cULCB0C0AwpU8VYRWUHN5G5awjtHN7elsNVUYJ5AgS4sGmQDDow3eyjPA1Y3NpdeJf6yAVIpj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=zODD1vgX; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=JjRwhiEG; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 546BMuen009138;
	Tue, 6 May 2025 07:25:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=equ0BDpJGoRz1bpyUm1mpHb7FI/84acJvSBXhjh/4
	Qo=; b=zODD1vgXq/WxhhUOVUDT2nkQb7SfKgtqPmk3US9r9zel/8fB/ISWQ0n3R
	fU1tYicrpk8wzGP76pR3pm7+Y3DGI5ejt5x1FJvQgXfmzCUlWrTJtzVwVk9kHOq/
	72Mydz184aeETDxWm1nbK4xk46pLscE6/ROItgKsJBIP85wPsCxg2IfA4bMg9wOp
	wXYyFOIVswSJe/hzvSj+FKyLwhvHEqD1wCPhM1hF0Didzg2RsahpFbEFWfYetssA
	FW3qvNLNU36figrjbcT7ejPvsvw5mX50V/9icoNZPZvBTzbAa9fsYiWUrn+v33UQ
	JnIr5QZNfJ0rSHfFZNiT/RGAL6Mow==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46df29664m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 07:25:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aH2TfruktDk8RMuhTcC75IUKp0/ZnsD7PEBYzh5CVUWGsgD7ASzJ65uWUdvhD9kT5yFvz5G3YQ0LQAcPZVAsFMtj1Qt8Uz6a+Sy8UxlQlay+aJ9G34FrsYAY2T8Kd66rXtJfCx9m6x1ZYnk+20wchzJPIVb+I0FX5VHWVdDGX/fB7kVAq/NIPqwXoF5DRPqoxwRjR1LWitFqb5YAxLd8QlRXQgvOfFIFKtbqM9AMpjsdzOk5MWBZvdPMRDLx6T7Jav7WV+0H+QpxpmwLe1/BJfY33GydoIhclTLaIYLOqVPG2jeaJue4yy4gbKduwFjSLx8EsGkPMWyFayInZZ/osg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=equ0BDpJGoRz1bpyUm1mpHb7FI/84acJvSBXhjh/4Qo=;
 b=oDhqz5U027ZKhXKPhKnhO5W34YjaPsY58OjxcdpClDdOuPVX2JPQp1R1KpWVwuxG+TrCqcDHNljpaSYAXSfYeQRX+lIBSeWILVMMGVEGZ5fuwz4sf5ILFIRwa1vbfvfB0MlMWipgHubH1bj4Z6FKCidRM/WzIeqsizOy90woX2jQDcUxoyZuFnCF1BnRe5Hi7figX68j+c2LhKpq449kZqqZmX+E1K7nK4MIIhcffo3tJZDByzp2rMevG7124o8Y2fUVDCO2d2F5K/rw/mWbnasHR1csr3tiLjKbNnAUXBzOUvYdlsrQFxHZ4BLoKfEdHKlZ4V6aCagRmIinh4nS7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=equ0BDpJGoRz1bpyUm1mpHb7FI/84acJvSBXhjh/4Qo=;
 b=JjRwhiEGSuLtTR5BsM9JIFDm3SxeDs0ROBVzevS/y2cw70bzrMcZSxUiph2ubtDKU9sCVYT9BMn3PBKOaZOZf8AltxrL6SUdkxgg6AMhzUWF+fXUL3aNxUNBgJXAWuIQYbK+E88PnA38RS3mAtPwQfR3x8lZ8yfSzSE+XkIlMqhYXlzm2OSt8G5iDywOaadoWqR9QOgOFI+ct1Bkz17wEVazr+o/310r7WfZxdSlZK2MBT33NpvX2gCIA1TRremmJd5bticV2z+R+wksoijDWRIWsE1irZ7q6C6jc8F8lCGcIG3M6n6VLITwm4hfvJTaUViMw0wGPPdDN0RWbsuRXw==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by IA1PR02MB9181.namprd02.prod.outlook.com
 (2603:10b6:208:42b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Tue, 6 May
 2025 14:25:23 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%4]) with mapi id 15.20.8699.012; Tue, 6 May 2025
 14:25:23 +0000
From: Jon Kohler <jon@nutanix.com>
To: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
        hawk@kernel.org, john.fastabend@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, jon@nutanix.com, aleksander.lobakin@intel.com,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 4/4] tun: use napi_consume_skb in tun_do_read
Date: Tue,  6 May 2025 07:55:29 -0700
Message-ID: <20250506145530.2877229-5-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506145530.2877229-1-jon@nutanix.com>
References: <20250506145530.2877229-1-jon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:40::19) To LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR02MB10287:EE_|IA1PR02MB9181:EE_
X-MS-Office365-Filtering-Correlation-Id: c6d1db6d-c2dd-46a9-7ffd-08dd8ca9d64e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lKRkSttFf3MLjn362oD9p6ul4PMcFmlGI4k44NeV0SCLc/pTrCzHzK/ayy25?=
 =?us-ascii?Q?UYUBeoROTllhZsHsnsGjzqFJH7RrFo/+7nHhDX6iVr1uy4a+DX0mTfvBaxXy?=
 =?us-ascii?Q?k0CcmQeNg+QTkErJwEdsbsox+fJvwaX3O+F3gMdMZZEx2F1UKHLWQQrPAQbX?=
 =?us-ascii?Q?cGJsP69VqeTJVLqF9ntfiYyWhuuDCevI9Pk5VAO/T89wDdfR268H982gaUgQ?=
 =?us-ascii?Q?M81z+FrsyViVhHRtBL3urEUMA/Ibj2X/sp8eukfgX2RL89TBpsbRCjQGqxFd?=
 =?us-ascii?Q?ptQQNKBXca4+5k1VZAELC+/4ug8z5rv24h9qZKe05T1oAL31H5wdUt7O89TV?=
 =?us-ascii?Q?Tus6mDWyMeACKfBeWtee/KKTFMCS6MYKA7tCDMFGPm4/CikkP28VEKMR75Rl?=
 =?us-ascii?Q?24nN+09DdwpFerYGg3s3z9+rlo6eeLhHceOXTmzTF8fD/gMeswGNJP9lxBpv?=
 =?us-ascii?Q?vxyHtc6hKEMBgpNykCvxiOXom5a2aMsi5ChgO875jkYpEu130Zl4mzzd6Nv8?=
 =?us-ascii?Q?4zmGUC8WHZ2ZAGvhvmSTm97maUiZw279X36Lai6NMAwgxw//asS+Chkc6Hu3?=
 =?us-ascii?Q?gVY6kUm27qBjKKKpPVdlq5Eo+w1aBZwxChWWcs6sjRYlJVsUYO96rp/UuY7V?=
 =?us-ascii?Q?9Ohv2itw2ezwpiXpH1UtCPLBKaDXxazDNoMOd8JOr309DYojCkWgTYeOlmTG?=
 =?us-ascii?Q?omaWBiQ7jRpOXMfRaEhWg0R3d4v9FK6D8rk5Nj2AQkDM2/wMCFgUieTE92ys?=
 =?us-ascii?Q?0HJ3q2fqGCAu5l8roIp9bXT9wCktMotH3m487j56winPwNlFaf59q87vsXqv?=
 =?us-ascii?Q?9AXc5EDQq1iMHg+StlnbQFUqiOayMwS0yY8zQh6fX0sAsFelGiBvdADNHf2l?=
 =?us-ascii?Q?2OD20G8Iya3sn5Apb9Uv3RnxJTJ/WbeQEschlqhRUKD+3Uwsh2U+7LLpzFdv?=
 =?us-ascii?Q?O+/XCsa27z3GDSOCtfYmzKI8a8qgYsLM21M55iK5R+e44giccU+fXaYfSFao?=
 =?us-ascii?Q?DcHIxt+o6HBcNXyymVS6tiw2Hjtyg9cDuQeqT/uAAjJdkDSalJ842DuTT7rR?=
 =?us-ascii?Q?Ej7GqWr2JJ7TETGjoa6blfVM3kkFqysya10YC/G0XpSaV73mOi9ounwy1m8D?=
 =?us-ascii?Q?pRCouvvX9DGVs179AW7Wr/WJpbJx477XfH/YFmC7bgR42FDRVvBjx4oMdq70?=
 =?us-ascii?Q?vP4GPlShwCE6U0qAi9801I8zp35KRdKp57FrKRC+kRBYDVOz8WDcnKIFooyL?=
 =?us-ascii?Q?6mvv13ux+gbyjB8uTHjTXjHV5xZOC6FKuCCk2jQi0+lZ0BILj/17+C1L3yGh?=
 =?us-ascii?Q?GAl4avyZ6b7166uXxSZOv1mf3DFFCoYf9U4OzdPeQmzzfgRS56fA2OzexuTc?=
 =?us-ascii?Q?jfPb2HWriT+nFHI1kAE+8+32FV0b3+VHRLQItbu2NpQOPtYqN3olv54df1HM?=
 =?us-ascii?Q?92LeglOt8DQzH4tOaB0KDTHmXgj6lDx2rxoNUBmR/CzPQhj/BAD0Ge3rIvL6?=
 =?us-ascii?Q?b2g0H9q9XMecdAM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YJdG1OMtRm7XKZnYR+xEA2Od/ITLHr/EYBU0skeL7RBeFOY+lkvtnjt8mUeN?=
 =?us-ascii?Q?XrHgvQm1matT/9/sl6UR2prOhEMPOgu9FKTq/O3bFh8ZGdBdj7viuB2Fh7su?=
 =?us-ascii?Q?csblSoVYED1lbQnQxN0nT2NWxwRyLwDyWJX7e8tcI3Vt1nbL1yrPE/vFA6Fs?=
 =?us-ascii?Q?IAB+SE4RW6zvPrOThwpMIrqUij5IwiXuFV0/3uZDzkTR/6DLQwBsCm5MP1K+?=
 =?us-ascii?Q?Rjdx8JuFeKX9YuZJI5wNqs/BdSTbyOWnA0NhAbrk1WG9NNIqVoKFH4kl55Us?=
 =?us-ascii?Q?iqC9aqSO+SMSqu53ZxD+IjySR0BaQ5zX3UreuWH0MR/KTvlyvv6yF4aMeBbc?=
 =?us-ascii?Q?mGuCHJqUCY9V9HvfIAY4QMU8yuUiUd06b3nMAfQPRMXGcyXMb931X3+QQFPx?=
 =?us-ascii?Q?QEJb7d/Dq/mku7O5/C3a5xghp/CKUjtS/rIqkFjz6RADsiVgWQGQCzt4uNu4?=
 =?us-ascii?Q?CO+uf+hQcvKfAR1oGHDn1EfOysUeCUgVyMUxSZ74sNGANUzCK6YFG3VaW1Hh?=
 =?us-ascii?Q?DjHcEwZ52KS6r3jh2NhHZsGuepC8rbpoD3d8rSf7Xlrf5onkQqxCv2D3Z9/y?=
 =?us-ascii?Q?iNHTFnwviDaDC9IYvoFJ+WnALRADaLxUO+ldyopBpdrbGz0gAm3qAbQUyCPC?=
 =?us-ascii?Q?Re0G1Bt7VV4uMwQttBfGSvKv/Ob8AKFW1vkKXiEQYDyMhj7rbMwDFaVs07Km?=
 =?us-ascii?Q?6Hftb+HCklHSN1a5IwHfV65jqfriXbtzD90lXGU8236KQi2zl/cs/nnWMCM1?=
 =?us-ascii?Q?dUrNAyqG45DpUmBhz1MBkk9/HKyxvcTA7q6PS+oAtQI4Sxgh7ql3Se/hUlf6?=
 =?us-ascii?Q?8zU3+TQKonawXvvm4hgANQK7w0yR0ZgQh1FQDqgTxm8cnf34Zy5cOOLg5G4m?=
 =?us-ascii?Q?cVkCdPwMRN+VuFuiAkCNhzGNcxn6HqO284EwjfEaOhGCh2T9+qMp2eQGHLEr?=
 =?us-ascii?Q?suoajlkzMsJcK+LRyz4mm2Lrrks1+Wdfpp6rR5VxXcd3xbgouPGtsECiza5G?=
 =?us-ascii?Q?8jqMrvi2gjgJSE+1VYus2mofy75kBHTNWmrXka+mB3scZaMpXV8fXue39YcA?=
 =?us-ascii?Q?GvcEKA94X+fyaeGNRTRlucfgIphZYwqpjCdLHadmsdWHXwhcUiuiX/wiYQtH?=
 =?us-ascii?Q?N2gbBC9cUvvkR0syAzRYt8CWuo6Q3ECaSAH2KTYjHXq4MEaf9SO7CMVRbIGw?=
 =?us-ascii?Q?JyWV4UQEKYjsC+Ld0omnB7VSbiQ+SuRwWyMyB4BMlyWQP1r622NKkg6X56h0?=
 =?us-ascii?Q?fqennQF11uVOmsuYAwOoGqWdG0Ayu6JeLLquKDXP9ZJcjgYHziOXDw4k5igq?=
 =?us-ascii?Q?3C0OAbK8q1Sr/p8Z1jQFEUuKTgTsmfi1pyOVzK9/BWC+ROH9LE1jMuWPiOcJ?=
 =?us-ascii?Q?o7pHuaXO5zr9fxhEOluDkqa59pHpZ0wGqbe8OBtxjSggubnrHZ93JrP7u8mx?=
 =?us-ascii?Q?dIpW0v1aMikVhoUDoQ4dcwKOX//yMncsRPaH8rFmztvTxZbaDo056jcBfAaI?=
 =?us-ascii?Q?t6GiiX5Ew9SSQaEyJuE2T/cs7j+Wd38+wrErgxRtKET9weTfp0/Uhr7422L/?=
 =?us-ascii?Q?TxutgpI9ESB7Nv7KG7roE6ZahWb9JOPQbTTBx7Fl791zEjvikrO5eOLEWSiH?=
 =?us-ascii?Q?3A=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d1db6d-c2dd-46a9-7ffd-08dd8ca9d64e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 14:25:23.2737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iolsSJ18qIlIOhMMFqmruRNtygXSqdPhkHJb5s53DXR5lvxmgmG1Sad0BI/sXVhqyEf63Ab0JalTDqzEAEF/UYGxjH7Ack4jX+xmeSRCjfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9181
X-Authority-Analysis: v=2.4 cv=WtErMcfv c=1 sm=1 tr=0 ts=681a1bd5 cx=c_pps a=XlWNgFwcAB8XWrBhwjv7Vg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=b33TgMU32a3rZkJSB7EA:9
X-Proofpoint-GUID: 2jMf_MzjJx_2fX8WmaYfT5kjYkeOwEoC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDEzOSBTYWx0ZWRfX8p62AOECIUcE NbMxQzCDECxfvQj/r1/8Pjz6fo7ZvQPGRNQ0spVM4YkdEmieD8n/xCtsfYdW+y8B6o6wh92zvwV e3yhtKjDCfFm9BiNpWIC1g9WdEdiG6UMETSYZfP9h70WNxNkZO3stNE8Fmv+FzM77Awp6EZdqCJ
 rZ9yJaqtY7CrIn/c8MwSdYr4kQmKRCvvzbIhnuNiUzcRHiMPBj/zdBUodJjDcW+qiqEZc9O9JXu rwZ3cDC8RUbwVdi86m+RLM8xbsIJTeTN5PHc/h2UN6pLRFrR8ktDIMoyE0RIXjCxGrstNTaVuI2 PNk09fucTKXssZnry4NqeYwohmeuopqmkyeMCpvrJ0oMHjxQRYER60rHhm++o8RowQNOSjldJhP
 m1uOoAuQJuzt08GdWS2GEiaeUIwCNRNyQvNN/cyyc9u8pmzliDDn4yPE08esx2kkuEyXi2WI
X-Proofpoint-ORIG-GUID: 2jMf_MzjJx_2fX8WmaYfT5kjYkeOwEoC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_06,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe

Now that we have the build_skb paths using local NAPI cache, use
napi_consume_skb in tun_do_read, so that the local cache gets refilled
on read. This is especially useful in the vhost worker use case where
the RX and TX paths are running on the same worker kthread.

Signed-off-by: Jon Kohler <jon@nutanix.com>
---
 drivers/net/tun.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 7b13d4bf5374..f85115383667 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2163,10 +2163,13 @@ static ssize_t tun_do_read(struct tun_struct *tun, struct tun_file *tfile,
 		struct sk_buff *skb = ptr;
 
 		ret = tun_put_user(tun, tfile, skb, to);
-		if (unlikely(ret < 0))
+		if (ret >= 0) {
+			local_bh_disable();
+			napi_consume_skb(skb, 1);
+			local_bh_enable();
+		} else {
 			kfree_skb(skb);
-		else
-			consume_skb(skb);
+		}
 	}
 
 	return ret;
-- 
2.43.0


