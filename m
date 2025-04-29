Return-Path: <bpf+bounces-56973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 557CCAA1B39
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 21:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25AD1BC2CC2
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 19:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46446CA5A;
	Tue, 29 Apr 2025 19:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="n/myetK1"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104F1259C8B;
	Tue, 29 Apr 2025 19:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745954047; cv=fail; b=UepkBM8ZUrMx9gMkgbqunoSBXw4bpWgAycZInTvBbrYSfpVlmS75GbFJW20DsrbNOuHzZQt6h3nYwM1izATcILl8TjRz9WtYXlsLBkG1B5jQdiJVXye+UbwZPKAKyq+9NCpb5V9tRi+bxUHp/PKYqnO48vGrD1Q6hfGndvAcsWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745954047; c=relaxed/simple;
	bh=Hh4ff/xfnvsjhdK0a8YPAsslk0ROxtXGaZI+a4gwyM4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FPIzHnoq/D+3Z7wcvPnWgOhDJA2JfkGHtWHFm9gGX5wYE/YoJ+qMzHa5We+BPEZQJcaRP82mK4rvMk4ljUH9cR1NmKI2CYlvLrvnGu9a9OTttublNNHiZydO4EoFEJ3w3ZIInmIiqLi2C8TMNzENdDHsuF8frA6hU0LCHFjM8yM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=n/myetK1; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53THkcpI021546;
	Tue, 29 Apr 2025 12:14:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-type:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=s2048-2021-q4; bh=Wi/lBIi
	6TruvvnvIof/ly6Mz2xMmlnp12O1GHBIXb9w=; b=n/myetK1yOgCOYyw2Y9cINN
	xoIvwh6StATUcHy7ix5K9jJwB3xrUgNAKKUUEvxve+lL0qEuhs6HYrFYF01Kocdr
	jbv0vvGGHW5P6h4o2j9GN5pbf9CFC75LTQOCG9iSQL3GPdDSITXD2EVI4Zio/eLu
	GE7SrACyrT9fTk57QrIjzZ1GQ8Yf/bjQR0M48I3r7NMatPtkMH+RRTZYaBviurCV
	a3UNyx8PGIbWz2d8xk5SldisnLFuySjCGOi53rGa5mKtdf+4y9gA/IRe6Ms+RR/L
	+8LrKUVl6wMbUckA6v4Kh1GdeswkgHexEoS6zGAziMLTqrUNf8teyI9OI1n10dA=
	=
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 46asdjwqcv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 12:14:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AGWVD762tdupBfpjV/Gy4Foeqlb2vtJpuMZ8ddfFEmZl/Ynmo2lLAf4SWYOTTrRFEcX1XXEumtRS9pxJ7T9KTMI0z09rzK83pl9YHKEEbJJA5xmRB6OHPojB+sWAwgac1DeRRyQ/ZsCYN8UbKYPx69w9BtAwIQkY9HeRoNwcYyoFMrFh5OExbpnJloXcodvKoHzueelPHFC7oaZndRVxkkfP8WXyfmucw4NWKgVJmyConQE+hvS1YPqNSA+BS8i6z27Z7zuSWttyA2E6yBMGv5h6677IJSwZUdwE6W9BR9s2lapckhwSPLYc0RuvyrIDe/1K8BG3g4sEYjOIU6HuQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wi/lBIi6TruvvnvIof/ly6Mz2xMmlnp12O1GHBIXb9w=;
 b=dhzpZ1ZwdfKy16xrBZpTCk29Ww0HxiasmlYNSvkQwAydj24+q15terqVrx4/O8y1siKcTD16D+W3t67ir5gcn+sWRVyCbv3fN/3fnSDwgz/Oua2Czq5goCiS8sjsuod4WiEVbCjc+b/EvVk62AvFPFnocwcYLW51Coj2YFRLLlHOGN/n/b0rLfvHNA6v3ejkiMgaCbHJK2SSnc/GXZf03ipQzf9MNo0rft9Ccz5erFJg0jikjp/psfsnNTUhRw1K1xSXYk584yk26XGwsFSDXBv8MZv7sOp+1Dw1Nxu0FvLUM4cELLs6qMugrx33hSCUXUcdPOiBnum0+px0cTTBdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5671.namprd15.prod.outlook.com (2603:10b6:a03:4c1::19)
 by DS0PR15MB5470.namprd15.prod.outlook.com (2603:10b6:8:c6::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.31; Tue, 29 Apr 2025 19:14:02 +0000
Received: from SJ2PR15MB5671.namprd15.prod.outlook.com
 ([fe80::a025:a1d3:960b:9029]) by SJ2PR15MB5671.namprd15.prod.outlook.com
 ([fe80::a025:a1d3:960b:9029%7]) with mapi id 15.20.8699.012; Tue, 29 Apr 2025
 19:14:02 +0000
From: Thierry Treyer <ttreyer@meta.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: Daniel Xu <dxu@dxuuu.xyz>,
        "dwarves@vger.kernel.org"
	<dwarves@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Arnaldo Carvalho de
 Melo <acme@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, Yonghong Song
	<yhs@meta.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ihor Solodrai
	<ihor.solodrai@linux.dev>,
        Song Liu <songliubraving@meta.com>,
        Alan Maguire
	<alan.maguire@oracle.com>,
        Mykola Lysenko <mykolal@meta.com>
Subject: Re: [PATCH RFC 0/3] list inline expansions in .BTF.inline
Thread-Topic: [PATCH RFC 0/3] list inline expansions in .BTF.inline
Thread-Index: AQHbrwS3AlS1roAfS0S+1p7h6I+KLrO0xRyAgATbjoCAAXb7gA==
Date: Tue, 29 Apr 2025 19:14:01 +0000
Message-ID: <D250DE71-922F-44B3-A123-9AFFBDC8051C@meta.com>
References: <20250416-btf_inline-v1-0-e4bd2f8adae5@meta.com>
 <fcjioco2rdnrupme4gixd4vynh52paudcc7br7smqhmdhdr4js@5uolobs4ycsi>
 <CAADnVQJ1y1ktKDgORynENQLC73FZ162XXL2qMSshpb2gKXHBjw@mail.gmail.com>
In-Reply-To:
 <CAADnVQJ1y1ktKDgORynENQLC73FZ162XXL2qMSshpb2gKXHBjw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5671:EE_|DS0PR15MB5470:EE_
x-ms-office365-filtering-correlation-id: 865fb5cb-8bd0-4865-5808-08dd87520068
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?aO6i5tq+52aYB9nW943Sf26wN38iivUti4fQA3XSbrzza0yjTQeOopZdqVRm?=
 =?us-ascii?Q?6kUpiQ3VAgKYn1nACr3KdDWd5h02F7Ezw61r25mbOHHsqjymFQ4318I4kFQK?=
 =?us-ascii?Q?NC32wO3CYJ2oA9YvhkGP0+a2xDwxkGprZKc1+LZpCkPWHhp2mLABo7uw0KtA?=
 =?us-ascii?Q?zrQhb59niKrZ6SmKIFIhyMvLJ9uWgmVJk2XmFo4O9c6NIFrJGyuZHAlHarHx?=
 =?us-ascii?Q?NdqnXbR0rRTziclenqu+sTi74WZQ9fcKzNj4VghpygcThfidvvuqtSJojJ7u?=
 =?us-ascii?Q?vIdHIYrh4f/Z54l3QMzG6LTyMhA9xK5ZsAa+A1pHXCUuH1ZyYWs1pAWyS78U?=
 =?us-ascii?Q?xWXaKhfGfGcNplAvla5w5AS8rwAuuHT+4y7Mwd73SdKM3BNR4mCnNYo+0lMj?=
 =?us-ascii?Q?wICOmWpgh54uStZYQQq6svAWTczh0E+WdFHvyyXdDTnnqoxp2ijjmkGYHLtB?=
 =?us-ascii?Q?z4YzsOBdwIVKFzdW7kuaumz8HFCe/g3bV/aYNebtoCTe1iPiKoFJYNyCP4QD?=
 =?us-ascii?Q?mTL7ReF4MHzKPAyWEb8ZKkXtjlFvIE787o45mbrinQOuVOswiuit0w9Gy9CU?=
 =?us-ascii?Q?h7XIQQkxZZXRHNszrE9bqBURVKeuYGQ4Ac9frzfk0Fal8cNjMwWE1LvyAiHC?=
 =?us-ascii?Q?NSZWEchmlg++2UZn7bRhS65SpuVoioEHf7jpNz6jQJYpPvQmIeFYAm5IGa2W?=
 =?us-ascii?Q?44+RDfLrz1p/pPPH/g/+7MuuZq8ya3QQSyMWv6WFXUhC8TnXIAtY5t06EYwV?=
 =?us-ascii?Q?pzQ5NpCGWR5rcBle20gRfoz1jSBrvYDsQh8hb90QbfOTfIsqb0t/oNYRqUMu?=
 =?us-ascii?Q?Xxg56O3Q3kEbQYIFkcbdnJMCndS3nJwpNnTJ6et4ZLavMkwvTHLHz/zyiVNV?=
 =?us-ascii?Q?gqzUVrykRlc7IHlqfDD72bOFYAURa5kgLhI6cJGsU1kDS9QYphjhp2S6OAQS?=
 =?us-ascii?Q?gBzqIIJJatR3EOuIhzk7THJ/y5eEkskj52STji/Ns2Pk6mB1MiDT2Xm5OuX2?=
 =?us-ascii?Q?R32L/18p3du+BfiPkjKf1z1ytY89tHrNqY6Lr+PotF5X4FYm9/3Dh6PtIefC?=
 =?us-ascii?Q?LwutGQgtvQwKYdWaDKRxu5cuqTXGrwmAfSP/Z9zjSY1QFzMO5TRhpiv+uBnk?=
 =?us-ascii?Q?5FTQJVkbhXd+x7XhKpAQLD+0DHKZKw2azbMmtWXwOUW2pBQqGn3VJ/L/ESNf?=
 =?us-ascii?Q?Li3EriZMZ9VcUy8QXSfFmQZZBq1WtT8MwJaOXFe1EwX3+DYbZ7rMrkROG5YQ?=
 =?us-ascii?Q?g/zDOwxF7N25RUknNhWs18rBydTXAd4d9SPpkaMol54obC04D/8BTrKscUgb?=
 =?us-ascii?Q?4IFfRjflXETGq0EPt+bwZJ4OCuKs1hJryZXNXoojoJKeDyD+dSWYbjzOJ8WX?=
 =?us-ascii?Q?V9QPDdAPe2dpCPgNXwBW2RUVjRwbuaHGHQ8rOGVmJ1qKd7Cg3S6GTb6g5pEs?=
 =?us-ascii?Q?QlrBG7a0clP+0GmHNTEopP8dgCT5YQDrlrFk6B+QylOMFR93Zv+76A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5671.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LIYcRqNx+H1dhoc2BzXdlryL/YzxXA0VaZ1iCuKZBpReKOMHF7lRLPM84LWo?=
 =?us-ascii?Q?7AP/FWbb9v7WmNZ8MvioC+FU+cYGQVy99g2CjP9zf/u+koASVO0gPUCV90TA?=
 =?us-ascii?Q?qov4wxGnKrQH43Beh/KXnT1VKXc+VgsBjgMPR1OqmZ40lnTTM9W74yZO3/vL?=
 =?us-ascii?Q?CQRqYovkEqZT5Ik04sNDVIbrrB+MD5hyWVOU78jNp8KCtHvgSTNX8u7sAyFJ?=
 =?us-ascii?Q?rPSPRfFTbCX2HD+t5RoZQcGthUwg/wDBayGQpsGJwMI0zg1gJwDebZrZuJNJ?=
 =?us-ascii?Q?DjvRQ80t8SeLnmPmQajVB4q7Ooisfxo3tjAfmscSRMzH9jgV4kEv7VPRPv1n?=
 =?us-ascii?Q?ko+Cy0C/h11bcAQNOe9sgz3IBpkE/gYFms55SZVLd7yd62GsxcSZKTL3j7Oy?=
 =?us-ascii?Q?KUXJJaU0d5oI2KTNUzQOBn9wD/UUGrnpFAhSGhqukQWobMFp/2xypPti5fQ1?=
 =?us-ascii?Q?2pL1AzMUem5ASWf3EBEzWLv/QBay0jhLS+9c2dKYbt7Tl2uOTSZ3q6hkEIRX?=
 =?us-ascii?Q?W1fghhzb9lOPnC5TYgD/DRWRwquQHp0WfEgiG1mW8M8Hgel9gA0lN2TeU4Sa?=
 =?us-ascii?Q?Vh41diAW+6CT5bSlT3BS2H5n0nWFbrDVvyVehs4ARLhHY/PUo30udSOebiDV?=
 =?us-ascii?Q?8pr3oZMJNZ4ov5/n0yz9ruEbLW8tuwH6JcXOoCDA11uvrUo4qDBfJtk5XhDZ?=
 =?us-ascii?Q?SCdMgHc1Jigm+SLnY4JJeyUhXNU7vNIjMXMCx1kVWO9iMIL2R8Hk6c2HLpl9?=
 =?us-ascii?Q?hMvUofEePXpyTUEExnzygsr87atZ2tGyl+xmJVJaZMzPehs9NtK1/zR0gMtc?=
 =?us-ascii?Q?9WTyF5K/SLiZbWPKYI0fapwYRJFmJUKE4Yg6TR5Zkym0DKoDjTrzfY3Yy+Gn?=
 =?us-ascii?Q?DvwuFhrCou9EJPXTvReB2M2fAgIuXUxh4R3rzISgB+ptQ6BZ3mGRkjlqVsKW?=
 =?us-ascii?Q?4TyrHulHrqwch6VaEWB69gV8iIYiEUBxxK0d4ExwxxU3OxQWAM/nmMRxzG/a?=
 =?us-ascii?Q?39MQEhChEI8m/OPWm0xwXbfVeU9dkuSRsMmGgqFahsPmudP0LKV6lURAT6gt?=
 =?us-ascii?Q?V11Aa0MHK94XqNSpob7e28rYLhIK/BjJ23+7qb30FyBg6i7gcSJCYkU3e4qC?=
 =?us-ascii?Q?tsVsBG1cF+DntZGLCRO3fwd2RSZwThmveOUGnygQHfcf60jA//ID8c+9Xj8x?=
 =?us-ascii?Q?8tewbjBHLdd45RUDxJfZJjhwkGCv9KBh/ESm2L0E5ssLpi7k6/woIUTYGNm1?=
 =?us-ascii?Q?Xo6d7lqci0xI/43FQDPVJpNEkIxmGj/0MHUm/3e0MfGbJknpcjMqm/ss5VXT?=
 =?us-ascii?Q?dDFff8ul9VTFBzfnLhzAXW50d8OAL0ABag6M2YHvDZ0qCwygdXeLTNGVZk4w?=
 =?us-ascii?Q?keAEQA+hzsx1iCb0gSESxwXe+KICbj0KYe8Z/QwfSFWBjCiMAYCsl6nKp4Gx?=
 =?us-ascii?Q?jdZuLdFkPVkz2viJ4JlSexlNTD439xP3QCKq99vjOQe3/Ovl7cQ9ulUtZ3R5?=
 =?us-ascii?Q?QmLTqpnmse3nECWiy5dZRihMnbIkH8OcZ6AVE+dP8VSlgN9573k3FxKg0m0/?=
 =?us-ascii?Q?XnL1qbs40Ug/Ac2N4Ib+5WrV4vNGIr+Yol9ou+Xuy7sN4gfCq5PdJG8F9pKj?=
 =?us-ascii?Q?nibSPQUlObpNoyVWeOoPYGLiTS/axZU9J/GaJOVoHVqi?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <389D6418C7E45D448CAB201C3B1217CB@namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5671.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 865fb5cb-8bd0-4865-5808-08dd87520068
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 19:14:01.9825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pNCYOcOA64MGHqHva3+wGb+D2sr1oJxiaJDhSqX0v+wyDVnzflCIaDORcrQP+567FOssrNv9riBu3wz49EHQwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB5470
X-Proofpoint-ORIG-GUID: n3EWsSz6rm1QcAHn3W-UVt8HWoRYc-oQ
X-Authority-Analysis: v=2.4 cv=Nfnm13D4 c=1 sm=1 tr=0 ts=681124fc cx=c_pps a=wMNeujlvNozESTkKEiiyVQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=XR8D0OoHHMoA:10 a=zud_8KTm2Pj2ka0jIP4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDE0MiBTYWx0ZWRfX1/9zyCUpf4k9 5o3PWBaETZFfmoVMJ/NN2702CTNQi1xKDkTSRfeVbe3VSnx+1RKa06mb4krGH+AhiHJJZbUW71A r9ePf8pi6bVT2MhZqloUBb8RFddBDuLqPCDJrGEQgkhmEnyn+JhDkMGnhAfkbT+tCXMKhFySiE4
 RsI2FkR4cCouz4Ccx9H0Z+FDoao5+7tgp2cHmhzNvojrUOWHuE5MZ2u92qeEZbsOp1Oex6r36SJ hpy01NBlXUXEROSuLzbKHcH2wCvvO3vFLpwhKj/2Sz6XG+PhxD6OlcWJIaJP2/k04sIqWKS/mUT sSntKwnScR/xeB45ongc0QcUpWP57KZVVnwk0164WRGnpYARw9bAYTdh1gFWfoS069EUDVMgsYc
 SDaspvrt6wxkDEvP9deuaMMQfTDkTgGbpmCgXKNu2FhtthrF1C37Qpupb0VSvRZe+FKietyS
X-Proofpoint-GUID: n3EWsSz6rm1QcAHn3W-UVt8HWoRYc-oQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_07,2025-04-24_02,2025-02-21_01

> It looks to me we only need:
> - register
> - load_from_reg_plus_offset
> - constant

In that case, we can shorten the list of operators:

### | Operator Name          | Operands[...]
----+------------------------+-------------------------------------------
  1 | LOC_SIGNED_CONST_1     |  s8: constant's value
  2 | LOC_SIGNED_CONST_2     | s16: constant's value
  3 | LOC_SIGNED_CONST_4     | s32: constant's value
  4 | LOC_SIGNED_CONST_8     | s64: constant's value
  5 | LOC_UNSIGNED_CONST_1   |  u8: constant's value
  6 | LOC_UNSIGNED_CONST_2   | u16: constant's value
  7 | LOC_UNSIGNED_CONST_4   | u32: constant's value
  8 | LOC_UNSIGNED_CONST_8   | u64: constant's value
  9 | LOC_REGISTER           |  u8: DWARF register number from the ABI
 10 | LOC_REGISTER_OFFSET    |  u8: DWARF register number from the ABI
                             | s64: offset added to the register's value

> register vs register_offset is another artifact of dwarf.
> ...
> - load_from_reg_plus_offset

What is the difference between LOC_REGISTER_OFFSET
and load_from_reg_plus_offset?

> For fully inlined we still need callee_id otherwise bpftrace won't know
> argument types. It shouldn't be hard to emit btf even for fully
> inlined functions, but we need to be smart not to bloat BTF to dwarf sizes.

I'll come back with an estimate for the size increase of the BTF.

Have a great day,
Thierry

