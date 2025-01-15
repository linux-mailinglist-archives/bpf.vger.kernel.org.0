Return-Path: <bpf+bounces-48969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD207A12AD5
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 19:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107D11889848
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 18:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27191D63D4;
	Wed, 15 Jan 2025 18:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="B5NiuJgm"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D5D1D47CE;
	Wed, 15 Jan 2025 18:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736965672; cv=fail; b=ZzPDq7TtVyrdnH0I0WWpiWirE/KJGE8ptm5Et9fHvsR6BhltkkDEEdNn6bzqTR3usSCc6LbbPnMLuv5YkJQR7Fta//lzzIBSk3H9Ey5amhATrIPiQktivv6d1w2Qa2CSJeXZg1idksZNAFEcIMNTXvlBjYLTXu/dFGwg83GrHi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736965672; c=relaxed/simple;
	bh=AMCzjGBHmaXL1EvkDEA0A79//DaqccJa1XtbegzFqLI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ckLdL11931HG2ENnPZjdyND9kv9SHSglnBl8WA7QAPRrdAyPTVRF5Ogy87jrxBK0YzDVAzxC4egrO5+FO6RFU8xrvp/vEUsUq20aleknzX/miLOr0e2lABQ8lNP0XM0Favodfe0tqUsC/S3/X24LSoVRqxgsNRBQJMSd25B+m3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=B5NiuJgm; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FG4eY7005380;
	Wed, 15 Jan 2025 10:27:16 -0800
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 446g7m8bch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 10:27:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eV29zLy5Rde+h2XUweWi4HzJNphsP+e6ShBIauNDFZPFDI3d28SoQ2DoA8wbWxFYAESQY61F/FdnAoXhmYY1Y3Gu2yKAgl8LkMZPqH1/8RhLAT2IgCUqHw6D5pPHF+GqRxFaqw2nRPhZO1SyNY1e1HsqT7nckS08+oIqP2s9d+eOTl6r3ij11f9baxLxe85kGRxkCIs2XVsf9wi7lnvMiaXg+owqj6UQc/UFheF4B03fBWTo3q7cREu1FjAPspz/82fzdjD04T0NeQkq893cMRBFySDC9xwEGDmshHnTMj9SgVqlq67Ee/qrUboY+1V7VOgP2eG/t+UNn49DiB1eqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMCzjGBHmaXL1EvkDEA0A79//DaqccJa1XtbegzFqLI=;
 b=mE25+j4NMHmpXHAdxhv4Q+GWfJJFm3+Yp6XovZ1nr1qAl1+T9+UIspgPGO2TZHrVOtP1c60AictMO5NQLRU/4vRGVTkj+bhJt62rab+XWCc8lXgqVUvL2cjvINqWRdpXJRmUt76f4s5ltGkPfMQ+z29dk0tFbVX/Ta19A2l0r1ab70tC2cx+ekLG6ALQm0Xbncx9n9kaLcSkZQrzm/sOL9fd+OLh8bykIFhf9D7n2SM9T1az+0TQMFbeC4aTYpAOZeOdKudMFjY1gpsaC4aW/U7pXcG4EMsP86wOdtknzVtraANcoVQTs2aSdW5NdXU+JL4b1+iNVtlyQapKOuZpbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMCzjGBHmaXL1EvkDEA0A79//DaqccJa1XtbegzFqLI=;
 b=B5NiuJgmFdOcc9aGE7wThdjHApKf02gDij8HEErIVSm3kONpyxgpzzorgORYjvi5ZAo5Bv9gz1im8dVeEOfFsU+FtJvkNoVh/435hmlD2JloQOXsNfJI7IMi/VLOGi88P7cXefu0xKQqYVZAef33w/xu00cEqbrSGeTOt21yDJc=
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com (2603:10b6:a03:430::6)
 by LV3PR18MB6290.namprd18.prod.outlook.com (2603:10b6:408:26c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Wed, 15 Jan
 2025 18:27:04 +0000
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1]) by SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1%5]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 18:27:04 +0000
From: Suman Ghosh <sumang@marvell.com>
To: Paolo Abeni <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula
	<gakula@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
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
Subject: RE: [EXTERNAL] Re: [net-next PATCH v3 2/6] octeontx2-pf: Add AF_XDP
 non-zero copy support
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v3 2/6] octeontx2-pf: Add AF_XDP
 non-zero copy support
Thread-Index: AQHbY0Nrye8zRyX77kqUhKPvfW9BgbMWPCuAgAHzSMA=
Date: Wed, 15 Jan 2025 18:27:04 +0000
Message-ID:
 <SJ0PR18MB5216B2D5720A252E2CCB9D3FDB192@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20250110093807.2451954-1-sumang@marvell.com>
 <20250110093807.2451954-3-sumang@marvell.com>
 <dddca9a4-9ee3-4da1-b68d-26f208566d5d@redhat.com>
In-Reply-To: <dddca9a4-9ee3-4da1-b68d-26f208566d5d@redhat.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5216:EE_|LV3PR18MB6290:EE_
x-ms-office365-filtering-correlation-id: c0bc5e4f-0071-4f88-5b2d-08dd35923618
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZWYwbSs2bmx6SGJTcng0dloxNXUwajh2YU5PeGhkdktHYlNmckV0TDBlTXJQ?=
 =?utf-8?B?b1MwdDgweGV4L0Fpd2RxSk5BZUNyU2g4ajlaczhYbHJSd0ZhU3p6MlUyaGpK?=
 =?utf-8?B?VXRqUjFHejhpVjc4M2FXOHlHOWVvSmpyTW5YQkNCczlWVTZPNUFLQ1ROY2t2?=
 =?utf-8?B?dUUwM0ZjcmlOQUxiRW9iMlZURVVDeW9qTGVvU3FOVm5CZG9nQVhmQS9kMzhY?=
 =?utf-8?B?L1V3bnkxeDJFSEUrWkorakc3VHRxWnNjbjlySzlhYTB0NUJlcFIvMytJTGdj?=
 =?utf-8?B?cWpvSGIrY0dBelhUMU1TejA5K3crRGNkRDJac3RoVExkN0xtUC92bGM4L0dO?=
 =?utf-8?B?Mk1mRmVsVEVuVGluSXFmUTZQcHRzY09yWmloeWUxWXhHTnFXYjN0Yit5QjBx?=
 =?utf-8?B?b2hBM3IwT0lNMzJQV05wRmtXdXprbHd1bmp0L3QxaVc5bjMzM2pWY2lLazVQ?=
 =?utf-8?B?NlByMEROdU5OeU05TnY2RWd6RmozSEVWQ0F0UGdqSmcyWStKZjZhWTl0alhh?=
 =?utf-8?B?YmxiWEp6eUZSNCtSaUJTVDJWclA3a0swWTd4ZEFkczAxM3EvN2QwR3p1aE44?=
 =?utf-8?B?eWJ3ajVJL0t3dlUrZXRjaUNiU2xSaGN4SXBRTVZrMnJHTmpMTm9seDRuUnZs?=
 =?utf-8?B?TkJZSnp0REQwcDAzOStodytNZ3JQQnBmKzQzai83WHRuWENyRVVhbTdPbVln?=
 =?utf-8?B?WGk2YmMyeitRQkdRTllWRjlzTExERjFiMm1nN0ZWeEllUmpFNHpyUXgwelRN?=
 =?utf-8?B?eUltUjViK0dZdTVSZno2R1VQL29qQmRVRS9xakxqRjZkT3krYzhhSUJCd1pz?=
 =?utf-8?B?OFZKYlMvUGxWcXpEbStRWWYvU0lMWmxxR3EwMnZYSHYzRWtVYXNUblBmMk9T?=
 =?utf-8?B?bHBScDlXQjNJd0cyS1M2TGthNDNucW1nc3VGVHlkRGtGZnk5ZWd3VGg4SHhZ?=
 =?utf-8?B?aGFSelZYTFJMczVXY0R3TXI4NVc5S1lJUEZST2RFMHRUS1dscGVyVUg1UFE4?=
 =?utf-8?B?Q1ZUckdIdDRnWWp0WGhXNG82a3Q4MmdWMktjKy9qckFhd01ucVNJT1F0WjB2?=
 =?utf-8?B?VmlJZTArYVNMWGg0Y1RldDRQdFhGWG4zWC9heXpMRE4vclQrZDdtVXordGxY?=
 =?utf-8?B?dDI3R1dlQUV6WGtHeHRiUnpDUWdDaTMwK29tbEJGU2R2eDB6TWF0bHJPbWV1?=
 =?utf-8?B?UElZdUY3MTdJeGlYMUUyNVRVVnNsc1JBaFZWclFQcjZIR3BGU2p6MTBtWDls?=
 =?utf-8?B?a1htZm44SXFOeUJVMU5YTkpQM1VuT0JTeUFaWi9Qek1Pa3p4VWs5VkRXcCsw?=
 =?utf-8?B?aldvczZLeWNBVTI3TG1WNkxJVk9PaDE0QU1ZL1M3TysyYnBxdlo2VjU4bGM1?=
 =?utf-8?B?dk01TDVYdUl1NURCYXkyNkdmbGxQMXo3Q0h2NFl4b2VSRVpsTW1BcWJ4TW5V?=
 =?utf-8?B?RFFlTm1rd09Sd2ZOdE9tT3RuQzNabktRQm1DSCsyaDRSV2FqYW9RdUFCUnpo?=
 =?utf-8?B?bzNWRWFrK2VPWk9pcGVkOUJobUFUQ0NwWkNraGJMUTBaVmZ1cDd0VDJTVzNh?=
 =?utf-8?B?V2liT29UeEVLbUJoQVlMdWU0cG1NS1hpV2VLOENNWWIvYW5GWW80NUkvZHhE?=
 =?utf-8?B?dXpiN3VjSFNFMkhaL0FTbFVaeVovcWdZQXZmWEdaRi9udmE1TlErQlkxTnF5?=
 =?utf-8?B?R3BuYzBNTldiM0tvaWQ3WWlIK2NnWjhoTXR2aUI2MUluWHlPYzNOa052WjBD?=
 =?utf-8?B?YXhUTjlNbGpDSGhIbmtoNW1MM1pkMTlKOUZFZjM5L3J4YytWSlBFSU8rSEVt?=
 =?utf-8?B?ZmtyNFpYbjF1b2haM1ZWblo0UG0rZklDdzZqWEdHS1hQcnQzYm4veUxMWUNY?=
 =?utf-8?B?M2FtMG9GRjhwaUE5RVBxNlpFbWhKMTBZTWhtWit5cXZ6UG5tRC94bVdXRDEr?=
 =?utf-8?B?VEZFV21abXJycWxPeG1Kd2pseEhGU1NPWHRVRFRsZE9lRGN1MDBnK0orNmZG?=
 =?utf-8?B?dCs3TDA5Zit3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5216.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WW11V09RNUJiNzBpelN4V1BvUjhVM0FvOG1QNGpORUhaYm1pZzNQaHBTNm9t?=
 =?utf-8?B?RXJEQ2hoM1R1NzVjQ2E5dGh3QWJyeG1TMnZ1ZDNORkxaNmhJS3BOUjJzcXVr?=
 =?utf-8?B?bTA2aE4wVE5uWlNwQWNiTUVOLzlpSjdZTXlGdGhhQlpTUFhhdHEwVUs3anRa?=
 =?utf-8?B?ZVVjNDRDMGYzazVWVUtJend6Z1dJVllkcy83SmNuREt6dzF6NCtBemhDU2dI?=
 =?utf-8?B?RElSV1dyZ0R3TW9YNkt5SXRHV2NrNlM0bG9UMHpDblVKdlVCT2ovM1kzVG5v?=
 =?utf-8?B?NEtzaUZubW54NmhMWnhMYmVKOVliWlNvZmdjOG1NcDFOQ0hWQUt5M0VkNnBE?=
 =?utf-8?B?UFZaVGV3QjNxcElUQmhNNTFWNVFTM0hvVkJHL0VBa1hia3VGK29kcVplcnk4?=
 =?utf-8?B?ZldMM2dYMzQ5Ni9STFU1bU5oR25SVnIrYkM2OVJ4Y0xKdVg2c1V4a2tVd2l3?=
 =?utf-8?B?dHV3VGtkeVpEcXVjSVRtWmpBREFXeS9VZ0RIYjdMOGNabllmT0hyUVpiQ2RB?=
 =?utf-8?B?KzdNZklHaG5Id1lwOHNRSjlYZWNVL2ZYSkVvVVVuSkk2NUJRYmlwcHZYQWdN?=
 =?utf-8?B?Q1B1RFNLVFluSEhJRDdOVmJPcU1zZi9KVmVrQXBzU3J2V1pqS3gwcEMxRmla?=
 =?utf-8?B?TVlZNFFCNmEveUdlbHFpWHB0RUptZzY2dHBCN2RiUFg2VlZGWlkwbGFpUnVi?=
 =?utf-8?B?L3FhNEJFUG8xbEl4eWc3TFFQeTdQRFUvQVlVMzJSMHBOY0Z3VDdDSWZjSEVY?=
 =?utf-8?B?Y2VkTkVEMDNyd1Y2bDR5SXVxcmN1clJYejdDWWdId0pyTDZZb1Rib3ZSL1d5?=
 =?utf-8?B?WC80d29KeUdNZ2p2aGIrZk8rV1ZlZWFqdGV1K01NS2tUL2NHRHpFRlMxRSsw?=
 =?utf-8?B?WHU1c0xXNkI1SGNPdnJNNkFUT0lnTnNwMGZ5M25LL1BucUlZSmxUNE5yK05a?=
 =?utf-8?B?SXlJQlpxUm5pYitUalZLUGdsaSt4MTRmY1N6RGc5RjMzcGx0NHVMV0QyZFVP?=
 =?utf-8?B?U1JpRWIxeXk4NS9ZVGhtVXlBOFh3RW5uL1JMbU1udFNMZ0JjMnZjb0VBQ2xV?=
 =?utf-8?B?bVBQZDgrN1NFVHFCcjNhZWcvZ082Y2xUZmZ4VGE1K01uMGlsMTRDbEltRU1M?=
 =?utf-8?B?eDJBU2FqRll6bFM2NFZYWklRV2QzS0RWYkxPK0J3Wk9KTmY5TE53VGdsTVQ4?=
 =?utf-8?B?a2UxT3JMempWTW5tM1hzdG1FMWlyUU8yMXJ4cGNlVG5Wa0pBeTdGMi92OU83?=
 =?utf-8?B?Uis3VitIdHlmSG9lVm5xQUdDd05yemdzekZQM1M0VE1RSTlGaDdySE0wVWw1?=
 =?utf-8?B?MC8yK09PcXMwNjV4VWVaRVZnWFBmR1RnSW1ydTBmemlzQ29zTjE5TkQ2UnBQ?=
 =?utf-8?B?Y2pyUnRhMnl4dkpocVltS2dBdHFHVXZYU0gyNnRDdFB4bjJpNkYwd1U1R1No?=
 =?utf-8?B?Y1dqd2F2UlU5UVdtTDZ5b3NJMWFFOXgyZUVoK0RndlZNeU5udXQ4RkIzNkpU?=
 =?utf-8?B?TTRTUFBpVlVhMWR3TjlxUEUxcVFsdWFYUHdpdjE2aE9UejFhSng1N1Y5b2tM?=
 =?utf-8?B?T0QwTUE5QzNxdEtzK2FmUVBqWGgvcWRSY3NhUHluZUVBai9BRzRNenF6Z2lK?=
 =?utf-8?B?TGxhSUQwL094d3lLdWlSSWVPbGx1MnBFUDVqK2hDcXVYUDgzeTBuK0dpMUhq?=
 =?utf-8?B?SllsK01XQ01IVk9KNVM5N1VHYnFEV3NlUTA5UExrYy9UQ3N0TUNTbC94MFBD?=
 =?utf-8?B?UDNkdDd4Ukp3ZmRDT2hHL1BLSENTaWdwV1RxVU1PRW9VMjZyUEZlZ1JvWXBh?=
 =?utf-8?B?Sm4zWjJ5ME9NRktjbC9TK2MyTDUvK3dEQWlNK3N6OWdHSlNKeWh0M0JvM3Bv?=
 =?utf-8?B?YXdqUXVRRnBvSTdQbDZPSVVuS3hndGdUNmNWVWRwSUtnV25TbXZLVVpxTHFC?=
 =?utf-8?B?ekNrSlArMXZMd1JUYU9QWDQxelBxUkFCQ1RqTDQ5VWRhYUkwYmVtTXlzaWNm?=
 =?utf-8?B?NGtYODNBREFLS05CRTZKYmF2U3FSaTFNUHVhTzl5MC9wZkpqMU5TVzB0K1dX?=
 =?utf-8?B?cWZ2dWxxS1MwYk1xdElpTnFwY3Y5MnFFMEpDajVNZXVKb1RLSEM0YUM0Sm93?=
 =?utf-8?Q?ZoaY9079TsYGVQ+HP7iPynZ5X?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c0bc5e4f-0071-4f88-5b2d-08dd35923618
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 18:27:04.5421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RH1WmCAbwHLXDt16+9/cjOzXyB9/uN/6W7RNKPBAFrvQfdn3yq+MQr8HTDgM2PTl+lITEzmFX2KcVr/QHhzrWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB6290
X-Proofpoint-GUID: ewD_vSX36_uKEiwVTknQtsxheH7-3fSz
X-Proofpoint-ORIG-GUID: ewD_vSX36_uKEiwVTknQtsxheH7-3fSz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_08,2025-01-15_02,2024-11-22_01

Pj4gU2lnbmVkLW9mZi1ieTogU3VtYW4gR2hvc2ggPHN1bWFuZ0BtYXJ2ZWxsLmNvbT4NCj4NCj5U
aGlzIGxvb2tzIGxpa2UgYSBmaXhlcyB0aGF0IGRlc2VydmUgaXRzIG93biBmaXggdGFnIGFuZCBs
aWtlbHkgZ29pbmcNCj50cm91Z2ggdGhlICduZXQnIHRyZWUuDQo+DQo+SSB0aGluayB5b3UgY2Fu
IHN0aWxsIGluY2x1ZGUgaW4gYSBuZXQtbmV4dCBzZXJpZXMgdG8gc2ltcGxpZnkgdGhlDQo+bWVy
Z2luZywgYnV0IHRoZSBmaXggdGFnIHNob3VsZCBiZSBhZGRlZCBhbnl3YXkuDQpbU3VtYW5dIE9r
YXksIHdpbGwgYWRkIGluIHY0DQo+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfdHhyeC5jDQo+PiBiL2RyaXZlcnMvbmV0L2V0
aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX3R4cnguYw0KPj4gaW5kZXggMjg1OWYz
OTdmOTllLi43MzBmMmI3NzQyZGIgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5l
dC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvb3R4Ml90eHJ4LmMNCj4+ICsrKyBiL2RyaXZlcnMvbmV0
L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX3R4cnguYw0KPj4gQEAgLTk2LDcg
Kzk2LDcgQEAgc3RhdGljIHVuc2lnbmVkIGludCBmcmFnX251bSh1bnNpZ25lZCBpbnQgaSkNCj4+
DQo+PiAgc3RhdGljIHZvaWQgb3R4Ml94ZHBfc25kX3BrdF9oYW5kbGVyKHN0cnVjdCBvdHgyX25p
YyAqcGZ2ZiwNCj4+ICAJCQkJICAgICBzdHJ1Y3Qgb3R4Ml9zbmRfcXVldWUgKnNxLA0KPj4gLQkJ
CQkgc3RydWN0IG5peF9jcWVfdHhfcyAqY3FlKQ0KPj4gKwkJCQkgICAgIHN0cnVjdCBuaXhfY3Fl
X3R4X3MgKmNxZSkNCj4+ICB7DQo+PiAgCXN0cnVjdCBuaXhfc2VuZF9jb21wX3MgKnNuZF9jb21w
ID0gJmNxZS0+Y29tcDsNCj4+ICAJc3RydWN0IHNnX2xpc3QgKnNnOw0KPg0KPkZvciB0aGUgc2Ft
ZSByZWFzb25zLCBwbGVhc2UgbW92ZSB0aGUgd2hpdGUtc3BhY2UgY2hhbmdlcyB0byBhIGxhdGVy
DQo+cGF0Y2guDQpbU3VtYW5dIGFjaw0KPg0KPlRoYW5rcywNCj4NCj5QYW9sbw0KDQo=

