Return-Path: <bpf+bounces-57760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B4CAAFBAF
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 15:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F36DE3A6AE6
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 13:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FE022C35E;
	Thu,  8 May 2025 13:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="EfRy1mT1";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="PNL+WVu0"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A11884D13;
	Thu,  8 May 2025 13:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746711671; cv=fail; b=lBokSgPm16TQLDU5ei9SbjHy1JwSGEGPKmhTW+AOt5/c9cHVeQJ2uzy3DYu2X0vuRL3jtraKgiJb7vCBu0qV79q/qIYjBcKvXvSP+KFlKfqP3C4Pdv3SZlAqyMk/NBWg5JC9QIZQLHrTGKVHbvWNLa3t3rmuSsmX+tZqchgpotc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746711671; c=relaxed/simple;
	bh=NqVgXzRNVOOEewLoyOB9aD/1tlRFmNlUYgS8uMA1zIU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VPzyuPEycN7wiQtZ0Epo7x/r5CwpVn27wGE+qJWnCCT1XfT8yXUHeXsTjDe9+5GI2Jvf79jqhZ79U3sKirtXiofnXkLkuhSARmJxb+hnAdKYGxsEDR0eHYwAMwW4W9lQLwIjRxjmQOCho56RiSLwThjGcva+FruMZ1xcPnM0XKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=EfRy1mT1; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=PNL+WVu0; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5489t3Ul019662;
	Thu, 8 May 2025 06:40:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=NqVgXzRNVOOEewLoyOB9aD/1tlRFmNlUYgS8uMA1z
	IU=; b=EfRy1mT1y+YO9uZXW2VvtTcjvXCD6qXZ26a0h/9wZNTr37mbJv46/qNcM
	rOBvpwXgRXDZYXs55+ZtLYuGbsUrLV/5mGa3e8uvRbETmwc319jXi+TAkdHxv32j
	hNs1mbwLHRBdPB3SeBwy/qV3FqJai5Ym/M+fcpLSvHqVZzabhBNsLMwd+qa+cjzr
	rsnshDPUOIRMg3PokohVVm3BcHHx+d9kqM8ER0LAGnT2ceRD0bCKWYwaoDLESx3L
	rWtjQr/xrRBa6d1bNsBlqkU6+9JkfMXafIJSucAv0vNoSpANPaTbi8G/Tj73H3Vh
	5ub/fVmkwhtcTHV6MUCW7MIqTP/Qg==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazlp17010005.outbound.protection.outlook.com [40.93.11.5])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46dgp93wuf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 06:40:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emBljnpLQ7qvs0QJP8NmfXl9Z+N73czb4cL8CDaQCM6rhyw34kTRjDEGHtkxbvwdFEXacrHJPvnTe8PVDCZOFTNlnGXpOd0lg3YXfxNIlvWHnwV7Te6QH0GDlZDUwKRTgdzBXp/YYwCt+DQSjPqqkSqAB1RM43ekFs/9b3enaKrKgKkG8c6a3SVVlqo90NYGiLOGwXndQkBRV4p7HB1cz/Q/KyozCTgk1R2NomNcK6eTnkhLQii+8TOx+SEpgeysTs6DZWmLNotxXPEa7HZgQKx+dCXvsC/l4zUpeP9UxDskEriT1fNWCaoM84agYJs2md/fdmkpr+Ufqf8DZBfc0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqVgXzRNVOOEewLoyOB9aD/1tlRFmNlUYgS8uMA1zIU=;
 b=llX7cCDaycq5O95Bl4+sehd+0GI5nwLL8vAjXhDQkB3+zNL35yM2AFGvQDoP6ckZMfzcRAftbSniZHXN0VM8MqonrkrtQOD+f+7W83EG62YtVOOn70us9WOfGboW/PiwApUsdaKJPoimmka4G9RJoMlnzcPnhS4yx5/AHs6Xf7Eguq6LtjwUDCn4daNDi9m67zNIZ0OYKPtTq59sDFrumx/ZEVGJMTN4h2J5vnLrPsEj40uXnU6DINSY5p/toxuvWI9eWMekNCuttLzZhJ4V3FUJkO159jhe/4wZ6qxkb3Qcz1lZJvvovGv9kzMxsmRNIbWcVi/QkMXcqCkCoFgHMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqVgXzRNVOOEewLoyOB9aD/1tlRFmNlUYgS8uMA1zIU=;
 b=PNL+WVu005cJbqRDrDWQNks6OEskBnbCVVG3x7EDG9RXnyIs13hX++aEGlkr530zXWvrT39MHJTNegQpE7OvUF5lQ2JuPdP7X6/ztfnfLvWVe5g3s2nBewxW16auhf9m04Oi02SDWAJIP6ed3uFsQDWcuhIM4wqbWKW9TCvgXa+qtu7ayVMt92lune49OkrfBC6PsWVEaoJgqKf9uIhunDo/uWifJqHJwlnoWkk/1xTR+z88yhWwdFDok1D39ZEmgcDh3Q2PbTZGuWSzhetUGylBizl6uVbvy03wvt93zMWq5n7qCIDM7j2Rvi2yi6a8mHJlC+PpH7HJ/lTWg7VLyA==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by IA0PR02MB9558.namprd02.prod.outlook.com
 (2603:10b6:208:402::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.12; Thu, 8 May
 2025 13:40:35 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%4]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 13:40:34 +0000
From: Jon Kohler <jon@nutanix.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net"
	<daniel@iogearbox.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>,
        "aleksander.lobakin@intel.com"
	<aleksander.lobakin@intel.com>,
        Jason Wang <jasowang@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/4] tun: rcu_deference xdp_prog only once per
 batch
Thread-Topic: [PATCH net-next 1/4] tun: rcu_deference xdp_prog only once per
 batch
Thread-Index: AQHbvpKqjlwy8c+fkEmxxfKJcSD8ubPHpD4AgABs2YCAAKywgIAAApMA
Date: Thu, 8 May 2025 13:40:34 +0000
Message-ID: <69E5FB29-E3BF-46C6-B6AD-48559DFD2A22@nutanix.com>
References: <20250506145530.2877229-1-jon@nutanix.com>
 <20250506145530.2877229-2-jon@nutanix.com>
 <681bc5f4b261e_20dc6429482@willemb.c.googlers.com.notmuch>
 <CF84F28E-C3D0-44C0-8540-53E184BA1F79@nutanix.com>
 <681cb21f4616e_2574d5294b3@willemb.c.googlers.com.notmuch>
In-Reply-To: <681cb21f4616e_2574d5294b3@willemb.c.googlers.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.400.131.1.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|IA0PR02MB9558:EE_
x-ms-office365-filtering-correlation-id: bb4ccdf4-e5c3-412e-6152-08dd8e35e8f0
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VmxHLzhGdERYK3drc01uaThmRmt1L25wOHFhY2pFTjVFcWx5SnNDTlRKdjAz?=
 =?utf-8?B?NjAwaWVVcVcyZE5uc0Q3NmdJQmdoOUhXOWhBM3U0bjNhcXRaU2t1SnBYK05P?=
 =?utf-8?B?WHoyRTNPYnQwKzNBT3lmVE1ma0lSK0FKNzR1aHpMS0JqWEJtUXRRbWo4RldY?=
 =?utf-8?B?bDJZciszVTZwZUlNNFNGSEtES2RhZVFGVmZvL2N2emtyV1pKaERBY3QxUkJ1?=
 =?utf-8?B?dkZqWk1CbkVjTHRUMDJ1ck9zdFA3SHdhcGdEWmFwRDgrSGtpRFBqdGx2T1ZM?=
 =?utf-8?B?SXhWS1I5VkxsRjlNUFpmQldNc0VjSnhpZldKaFFmV2lmUGNGNmt1Q1VlMnFl?=
 =?utf-8?B?K2RZS1FoOHZwQ01vWWRoM2tYS1JhTUM1OVdYQU1tVnRLY0Rxd2crTHhZK2k2?=
 =?utf-8?B?c0hubGM5RDROMlFQaXZscmg3NW1MRnM5WkViWVZtdWd4ckh2bk05K3VZcUtH?=
 =?utf-8?B?ZmhCOHFsaEVwajJmalBWa0F0Mk5CMkdWQTk2VmZhN2NxTUtBZHdHS25yT1U4?=
 =?utf-8?B?U0I1UllrdDBXMjFWUGlJYTRNd0RjZE5JVzBOUmp1bUZ1VEZPZmtJaDVGSDVj?=
 =?utf-8?B?S21EYlMrMFdhRk1UU0pzQnR1cnBoblNtejZ0eDRxUllLUXBpbGVqOHpKbXRP?=
 =?utf-8?B?RTlJMEtkbEdCeGlmb290NmZSOEZDNldsSWVQQXcvdnNjb3d2dHNWbjMrNnFi?=
 =?utf-8?B?V1ZVYUJScGIzREN6N0plQWU1cmRENDRMb0lIVzR6aDlWc1dIRk1iVWFQTjQ1?=
 =?utf-8?B?SXpPNWs5aEpkK3hPYzd2eVhZWFJZQm1lZm5Wc056WGlYaTdTMzZDVlJJTWp3?=
 =?utf-8?B?TlRDRE5tTEtuQ2lDRGhZOWMzU3U5NWJlRFI4cnhQUm5neEpINjNxT0RtZ05E?=
 =?utf-8?B?a1ljU3ZPVFJQSHlpUFpRdkVaOWh0dTFPKzVRc3BZUVdNaHk1TkxzMk5PR3Mv?=
 =?utf-8?B?TTlFTEN1YWR6RitMeFo4ckFsWTAyU1FYcGE4WEVsb2htWXFiTWRsc0N6Rlkr?=
 =?utf-8?B?K3NmSGZWbTdIWEtVZXlyTGNmTytoZTBXUVF6MU5XZ2VoQVIvRTBSRWpnY2JS?=
 =?utf-8?B?QmxPWCtHTTZFdlJxUmpRbVFaYnIvUXYrWUdPZTlUbTAwMWszOWRtSlJ1UDV3?=
 =?utf-8?B?dXByOWxRa0M1ZHVibmFkVzlzOTBiTEY4UlI1dXJOeEdOTFY4RWVFM3prOHk3?=
 =?utf-8?B?VnJ2TXNIQW96TWFWK3p3Q0htQS9hQ09TYzVITnVUWlMwYTV1VG1CSHFtWkp1?=
 =?utf-8?B?enN2RlR6OFBLYVdKWU54ZjFER0c4SVV6TzM0WS85SmkzbG94ZjFCcG8rbGln?=
 =?utf-8?B?WFU1dU9XTUF5bkh1bDM2dm01NU5nWE9UREQrMEZaYzAvMUp0dEFDSnZEa3Zs?=
 =?utf-8?B?VXIrQnlyWWlEbm9NYnFEVmZuQjBNTit4ZzREOGRUb0U5L3NncXdEOFd5M2ts?=
 =?utf-8?B?ODV6aHJleG1oaDlMd1p5bGFhemtma0p0VFUrRVBnWWVRdjVpNXdxcVNFV1pV?=
 =?utf-8?B?bVZOUDBEejRKb1hRV3l3V2tJRDZheEI5bzlhOGs4OFhXYjZNeEE1aTN5REtS?=
 =?utf-8?B?eXFjbWpJVzVacjFWM1l1VGtNZ2NmNGEwZW1DUW90NnVMQXR3VXZKR2VReXZz?=
 =?utf-8?B?SHk2bW1ZOHVBOTltL05yeCtwSHJDR3FCT3NpaUt4TTZ0cWcvSS8rSUVEYUVu?=
 =?utf-8?B?TzB6enN5ZTZNVHBTUEtaNjg1OTc0OVVxSWFmcklDZ2ZrUXNTM2Y4d0xOVDlV?=
 =?utf-8?B?cGpiNjZ5VjVGTXJuQWNNQXZPNnMwQkMwdGpyekxnQmVZNHdqOVU4akpUOXNl?=
 =?utf-8?B?Ky8xczZtdHRyWWIyWUpJSVlFU28yL2xjb0xHeHB2WHpJSy91eVRJSzdOOUM2?=
 =?utf-8?B?RHhJU2ticWV0YldYc2xyUVBhWTlvd24wWENDUm1pcnNtSmM1N2dUNmY1TkxD?=
 =?utf-8?B?dFI4aS9kWmdFeGR4VzVEYkJyYjNTbVowOXhXbmVBZk93ay9NQW93MHVvanRs?=
 =?utf-8?B?RXd5Z3A2bU93PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L1I3Z0dIRTQvQWV6TGhBdUZzQ3pYTWxRTnZsWVBrNFdrai9ZczYza0hOTE5M?=
 =?utf-8?B?TjFQa2ZpT3FPZkhqVWlkZzR3ZXdWUTkwWVJVOU1lZzdaOG14TDQzUjZVKzIx?=
 =?utf-8?B?c2s4OTlsZFFrTW5yR0xwcGl1Q01aYjAxVEEyNXUzaGVvRk5HSDlDMndHU1Y1?=
 =?utf-8?B?RktjMnJRWW5Qb2NWeThFUjhYc2NXR1A1d1FESGlYNjBuU3BPbHd4Q0tYa2ZK?=
 =?utf-8?B?TDBuV3NDMGJqTTMzWEFETXJXN1pYWTNiTTVnSEVjb3ZFUGdGaW1idWU5amcz?=
 =?utf-8?B?RDgySHpqUmtnQlc5UHNqbFBjNzltOTJDZzg4RDVvS2JDUXBWeStiSHVjb3M2?=
 =?utf-8?B?K3FHYjVZWHUwbmQrVVpkOGhwZDRjWmYwblhkUUNjcm5Qb1AzZVdPdG8vRnEy?=
 =?utf-8?B?Q0IvSmhQQmdFVHFOVGhUeGZRTnF6MlFoWFFaR2MyalNhdHo4cmpzWVhHRjdO?=
 =?utf-8?B?NUhjMjNnNXFIcUsrSHl3bFYyY0swaktFWkRLUWRkZlFzNWJFQUhXeHQxeFM1?=
 =?utf-8?B?djlJKzZCUFdXS0lTd0Y1aU8vMWVTK2RNYXdiS1U3WllMMU5WdmZWcUQ5QTNV?=
 =?utf-8?B?SW8xcHQ4OXVva0NGNStiSFhCZzlhU3ZTbzlvbVYyc2lXNmFiQVlxaXNyV2lB?=
 =?utf-8?B?NTY3cWtSV0xxbU01TkhvZCs4NVBqM2dvZVRwNGVrVTN1M2pQN2RRQzMrWXZx?=
 =?utf-8?B?OHdlcWRGaXltaFc5VndoTS81aGNQdWZ2K2Y1OWJyUGFNZi9pd2R6QXVOVy9F?=
 =?utf-8?B?eVA2MFlCUC9BRFZDZzFpWTZLby9KMWdSZlVLbmdiZnJjRHA2V254SnBuSS9E?=
 =?utf-8?B?TkpudjNRMVUxWUxIMjhMdzZ6MXVLeXlJb0o4SmtMUEJ3U2o4ZGJycVB4THFL?=
 =?utf-8?B?bmUvaVN1SFhyVlRNZ0hmZ2dYTjBSSWovZVlVNXdHSW5tWGtBZ3BvU2tBMzM2?=
 =?utf-8?B?eUVrYi9oWHArL3dtU0JSYVVYakhWTy9lbXZLSG55Mm5uM29pdVRPL2VkMGcy?=
 =?utf-8?B?TUdHdWJKdm5JMVovMkJFaEFXSWl6WTIvbThFYzlieTN4a3BLZ2MxWnVJU0g0?=
 =?utf-8?B?dXVlNGZ3bHU4T1NZZDlRYVUzeksyNDVpWm5POHNDRk0zSjlZRkYwYkttYTJ0?=
 =?utf-8?B?ZEpWSnplNVVVbnozQkJaVGVCTWlQaDFNVWo5Um1aQ1BJaFk5VkpaYitocmJG?=
 =?utf-8?B?VlVac2ZJOGtwRGdkcVY0TXdlUXpUbGJBQU12bDEvRDQyUWdCQlRvb3hLOEJ4?=
 =?utf-8?B?Z29QcEZQcS9YUEZNV1lZaEJrSUtTWDhMU3lFNkFkY09pOC9HL0V1c24xaWxG?=
 =?utf-8?B?d2dXY0tXTFJHWmhYN0ExQlJxOVJ6TjFDYUFuQjdJREtkdHcrL0RwaVRMN0hK?=
 =?utf-8?B?RVNoRDU5cFUzZnJqbmxzQU9hZjBvQU9wYjE3Y2xJNjdxMVhtMk44aTRLeWhn?=
 =?utf-8?B?cmU3aUZKQ2xEVmswbmFIaVp0QmU3TmsxKzJJR3dmbk56K2w4MFQ5bUVobXd6?=
 =?utf-8?B?RFZHSUhTOE9tVm11MHBKMkl5Vm1SMlNiZVA0NWgyUzlGY3Q5SHFSYkFER1lR?=
 =?utf-8?B?N2RxTWdRTjkrUW9kSFZnV0pkMDM2dzdob0wzVGNSblNrcHRraGhrOGs5b3lN?=
 =?utf-8?B?dmNpd1JKZWg5dWthbWpVMk01K1QwMUlBK1FzYitjcVU4OWNTUGhsb3ZwUWZV?=
 =?utf-8?B?UGtST1pvNDdmL3JVc3RRTnlLSkJINGdKejF0dWNsaTlUUk1lUnFkWTlIQ3E5?=
 =?utf-8?B?NndoVzlwOW5lbXNCRjhtTU5CaHpzSEw1K0p4RCsxSlFRdDA1SURvNy9TRkJQ?=
 =?utf-8?B?b3EyYUFmdThHTnNIcGZBdGlnOW9xeGJZa1hmYWNibXh1a3NOd3J6aC9FYzN6?=
 =?utf-8?B?ZHNZSWZOVVdYUUFGS2s1MWJpMzVCSTlrUXhEOFdjNGkvbWZPZHhhb2ptQ2t5?=
 =?utf-8?B?cDhQU3ZNZ2IzanVYZ205V09Jakd4OXJkc25FakM2bkduQXNqYkw3WGR1cXlR?=
 =?utf-8?B?R24wZ1Njc0FtVXd0OVQvakczTnp1Rjk4ODZOdVNiMFBobitXT21RV3BSNTNq?=
 =?utf-8?B?emtTck9ZMkdmaXdNVU1ZYzJ2WHBkWVFKSWNqSUlVQ0NQZ1lwRTlxWlhMS09n?=
 =?utf-8?B?QUFHWlEyQVVscGswZFNiUTBMMW56SGRuWFBDc2xsbStqOWxaUm55dzc4c2Fh?=
 =?utf-8?B?Y2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <41462EF9C2A1234ABD04CF26E45250B2@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb4ccdf4-e5c3-412e-6152-08dd8e35e8f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 13:40:34.8650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0+N0T5wQs+sscNovyfryugJ6uZaBEJa+lM91rGRaIZUsT08csMm2EIythzN9nSE+SWRFlK1f8DMJSb7ZsSj5G01RhoiEGngcyf+vXOhxjFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9558
X-Authority-Analysis: v=2.4 cv=R6cDGcRX c=1 sm=1 tr=0 ts=681cb458 cx=c_pps a=8NhCg2oU0sQOR5chO7ltBw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=pGLkceISAAAA:8 a=X2eDsk_wExgeY_xjlMoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDExNSBTYWx0ZWRfX0zy2xbaXDN/f XS8ZK/pF0Po3mePgmNFo3+rCuCJ1UexzoIi7odTRuGzz36TEURcNfPYbvu9fOEFPi2syvkvbZGR cgPePWgg27Ea3y80oADq0SK+w8yTlAX2sEaj77spS3zwf4Z7j1Hy33AskXfqE3eezg5THduJwNc
 Gfl6gDGe/BzQklsXVaZ2hMx1TZ/HNaCFKA8T3TzBr4o1bJCGYUIGfb33g65c/acZzKJ0pBZXKEP ig75fbbAacdGmyOKe4UJzNt7D4wNV7+pmP/tktKAQf97oW3bZm5Dm2OrzWbv76ZG57+w6A/SN6g FzWEh5R9KtQeEvF9hEvPN5IH2BlvYA/nOMiWOwpWGBr2e0oG4UoSoc4WTUNxPZBpSRsUa8u1cIm
 bwFViOtpCpGHNRmpoOtOKsmpi5YHM1eygjoKmKcHlZ7G3yS9kEb/y5ayb+eWGUaDUPXQPQcw
X-Proofpoint-ORIG-GUID: IQBU22L4txlGHGAlHy-1JVaBUgFQgrrx
X-Proofpoint-GUID: IQBU22L4txlGHGAlHy-1JVaBUgFQgrrx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_04,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gTWF5IDgsIDIwMjUsIGF0IDk6MzHigK9BTSwgV2lsbGVtIGRlIEJydWlqbiA8d2ls
bGVtZGVicnVpam4ua2VybmVsQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiAhLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwN
Cj4gIENBVVRJT046IEV4dGVybmFsIEVtYWlsDQo+IA0KPiB8LS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSENCj4gDQo+IEpv
biBLb2hsZXIgd3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIE1heSA3LCAyMDI1LCBhdCA0OjQz4oCv
UE0sIFdpbGxlbSBkZSBCcnVpam4gPHdpbGxlbWRlYnJ1aWpuLmtlcm5lbEBnbWFpbC5jb20+IHdy
b3RlOg0KPj4+IA0KPj4+ICEtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfA0KPj4+IENBVVRJT046IEV4dGVybmFsIEVtYWls
DQo+Pj4gDQo+Pj4gfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0hDQo+Pj4gDQo+Pj4gSm9uIEtvaGxlciB3cm90ZToNCj4+
Pj4gSG9pc3QgcmN1X2RlcmVmZXJlbmNlKHR1bi0+eGRwX3Byb2cpIG91dCBvZiB0dW5feGRwX29u
ZSwgc28gdGhhdA0KPj4+PiByY3VfZGVmZXJlbmNlIGlzIGNhbGxlZCBvbmNlIGR1cmluZyBiYXRj
aCBwcm9jZXNzaW5nLg0KPj4+IA0KPj4+IEknbSBza2VwdGljYWwgdGhhdCB0aGlzIGRvZXMgYW55
dGhpbmcuDQo+Pj4gDQo+Pj4gVGhlIGNvbXBpbGVyIGNhbiBpbmxpbmUgdHVuX3hkcF9vbmUgYW5k
IGluZGVlZCBzZWVtcyB0byBkbyBzby4gQW5kDQo+Pj4gdGhlbiBpdCBjYW4gY2FjaGUgdGhlIHJl
YWQgaW4gYSByZWdpc3RlciBpZiB0aGF0IGlzIHRoZSBiZXN0IHVzZSBvZg0KPj4+IGEgcmVnaXN0
ZXIuDQo+PiANCj4+IFRoZSB0aG91Z2h0IGhlcmUgaXMgdGhhdCBpZiBhIGNvbXBpbGVyIGRlY2lk
ZWQgdG8gbm90LWlubGluZSB0dW5feGRwX29uZQ0KPj4gKHBlcmhhcHMgaXQgZ3JldyB0byBiaWcs
IG9yIHRoZSBjb21waWxlciB3YXMgYmVpbmcgc2Fzc3kpLCB0aGF0IHRoZSBpbnRlbnQNCj4+IHdv
dWxkIHNpbXBseSBiZSB0aGF0IHRoaXMgd2FudHMgdG8gYmUgY2FsbGVkIG9uY2UtYW5kLW9ubHkt
b25jZS4gVGhpcw0KPj4gY2hhbmdlIGp1c3QgbWFrZXMgdGhhdCBpbnRlbnQgbW9yZSBjbGVhciwg
YW5kIGlzIGEgbmljZSBsaXR0bGUgY2xlYW51cC4NCj4+IA0KPj4gSeKAmXZlIGdvdCBhIHNlcmll
cyB0aGF0IHN0YWNrcyBvbiB0b3Agb2YgdGhpcyB0aGF0IGVuYWJsZXMgbXVsdGktYnVmZmVyIHN1
cHBvcnQNCj4+IGFuZCBJIGNhbiBrZWVwIGFuIGV5ZSBvbiBpZiB0aGF0IGdldHMgaW5saW5lZCBv
ciBub3QuDQo+IA0KPiBUaGF0IHdpbGwgb25seSBnaXZlIHlvdSBvbmUgb3V0Y29tZSB3aXRoIGEg
c3BlY2lmaWMgY29tcGlsZXIsIHBsYXRmb3JtDQo+IGFuZCBidWlsZCBjb25maWd1cmF0aW9uLg0K
PiANCj4gSSB3b3VsZCBqdXN0IGRyb3AgdGhpcyBhbmQgbGV0IHRoZSBjb21waWxlciBoYW5kbGUg
c3VjaCBvcHRpbWl6YXRpb25zLg0KDQpPaywgdGhhbmtzIGZvciB0aGUgZmVlZGJhY2ssIHdpbGwg
ZG8=

