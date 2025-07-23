Return-Path: <bpf+bounces-64136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72795B0E911
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 05:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C273A53CA
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 03:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B0C23F419;
	Wed, 23 Jul 2025 03:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="j3fSz/Jl"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1081A239E7E;
	Wed, 23 Jul 2025 03:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753241388; cv=fail; b=KArnaNryOTuJAHu3dSMzSEb4jF1OLcTWGEW2zsovtDkMCxvsxtsQH5QEJufhSCFupkopgbO+ZLU2yMIFCjcEwmbLg062grKGhryuI0KrWz+DZrF1bVeYCu4b0UFtRTwOSJe3QjaUvLW5ni6Js9F3n9SN93Kofu0JMTwTqvRITF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753241388; c=relaxed/simple;
	bh=28pwXdqWZRiyzLRXJWTq3yfVo9M+T1/3wMLjHBMnzYU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s+oiK37B7NzePkQsunBqtv5MDe5ut+nhvF5d5rbf25w1LM3elV0Hufie0lIo2hcw3vQrItROsbXrhrw9oEmzUYV09XxqftpExEGWUeENuY+TBcyjYKrrAYhq6AvGwuOdI81o3khxyDHOA3z3LashjOMawCkRzuVBqvhRPwtAULg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=j3fSz/Jl; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N2fG5I019681;
	Tue, 22 Jul 2025 20:29:09 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2114.outbound.protection.outlook.com [40.107.94.114])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 482q6102nx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 20:29:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=muYZisH+ri/jCKWxS8iVugRZpmIMx1l32ayhv2/ldPNNBax9f3RsC0ke0b2q/T+Zb+LCKBsTc+pxBEhPG2O5ZmA2Bmw/88W4mOGD6vmrGtP6VWPr3Sew2PYZELavydJJALRLNiFVsEq+e7gEJmlSXDFwDgbKpofHKG8QmK2nxGb5xycQgxFczCcXLvtffy40+Fwh5c3PkYa1Qi4KALhDQBgBp4vJ5IdgNByzopM3WLkj/yXvv5y33buyYnm3RiehHEDcauBTWy/4u5HHRMbEyS4PmJAFD7L8YwjQ/6syZ+3KiWWGN9f2fasJ8xCrKS7t3KMeeX7TmtPclC8up2EH0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6KuguHcs2QVe1pWc+DnqcslUTz7uJLCv1Prykhc9RU=;
 b=q5wpT2ok2g6S7cvbz6hArSBqcaRDMUlfX0VxZiz1dZ6VQlNk06oPZzvclYYRA4loPJh256lErYYbFQ9vnYU4bdcyT3BtIlGJQgZnHWTGyQchK7fAR9K0yQMmet0nt5H+y/ey332SMK1RxMNf46JvjSKnr6sGqZSUnSWuxtzQYr+H4AQvd7+UZUKT6WViSfPG0XmuDv/W8vCS0yE7xG3kfFpJSyW9Ox3YkA5+JXnZ/SRP3be1XnnF2rjOlyvfGN3BF5MGHro5uaKAt27I5VrqkLlxMb1HloRBjr2IQgx4BXncqORUI4Xso8t508l0aJSL1hULLTF863zaLEfwdtVYwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6KuguHcs2QVe1pWc+DnqcslUTz7uJLCv1Prykhc9RU=;
 b=j3fSz/JlmUXCIruRBxo3YbhnuMmFG9xTkaI77pZk07MJHuysU7VGepIeyNN4LSsqgwxhJrjtpJLXR7c7UCbWeQRHagGYP+9QnhIgwrvbTz8CJgOnYGCZ77PoUfcSKH6LF96CQj94g13upFa2ZU1Sprp1dmmJx7UqqSRqt+XobtM=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by SA6PR18MB6202.namprd18.prod.outlook.com (2603:10b6:806:40e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 03:29:05 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%3]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 03:29:04 +0000
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
Thread-Index: AQHb+2lU4wFzGbPA1UmAQDcm5IfxlrQ/BrOQ
Date: Wed, 23 Jul 2025 03:29:04 +0000
Message-ID:
 <CH0PR18MB43399E06C1EDC7DE70AE7170CD5FA@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20250723003243.1245357-1-chenyuan0y@gmail.com>
In-Reply-To: <20250723003243.1245357-1-chenyuan0y@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|SA6PR18MB6202:EE_
x-ms-office365-filtering-correlation-id: 46ea1235-fc94-418b-6245-08ddc999134f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?bMpA/uGJLkd9l6M5fAJUsTLhvOMnH3MQZMKlMiYEHf/FGIGGS3b/5lvblDfl?=
 =?us-ascii?Q?w4n8zJZuO6s/cc/i/Rqu4ZaIJx9ox6KYeSwGNOUYSGVuzzBY4CsjmaX0NtRy?=
 =?us-ascii?Q?NAhuZ63ZpfnQ4gg47HhgAKlhnM1BXxcm6ZBhEDF9VSIachXunS7w/Uu3WQqp?=
 =?us-ascii?Q?yOl4KY1Z5dyIAHKtr2JN8P+g9KBF5KPPQMGfqrWpjwcMSZzFgO+ygfYGHsrP?=
 =?us-ascii?Q?4HZ+xdZkAF1FqkfhFM34MHZNjeC+hZVa+b8LzhZ5XDa0CbI8wRBFvjvynDIL?=
 =?us-ascii?Q?yvBjcwgA9y5kGZqc4osBdlam6xZ1kVEX4XACfyeDSkLKSV6yYanLXPnBSr+Y?=
 =?us-ascii?Q?xK2tMWZwrtj4j2W6YbMdEjFRV3hJlwfOU4kpMUYXK0mnQHmQkC/FIA/X5aAj?=
 =?us-ascii?Q?UTSTLcmxu81lvnqosu2tHeoUrSu7wWru5K62uZTLs7KgDPFixOyhu5dI2sov?=
 =?us-ascii?Q?6CyksMkZiXJnWpeSK8XM4JWgBBIdu1WKjKvfm5RPIaeNcQQ/ulrT0TCA0eVO?=
 =?us-ascii?Q?8rbwnFMizHmDugUAnqxy+RcZUtxf+NEaTLixTEZFXQu/P+I7fDCLp7Tsd5y6?=
 =?us-ascii?Q?hAFVzHPlKgxjsz4nCVc40PqNZdyuaQcsdcqXZvcbZivoCbyyvkEUVWU2OiX6?=
 =?us-ascii?Q?gCQluMumD/sE7nminXLxFYVQH+LZrr3gAvMBn40EXv9PsTCFYNoJXakxl6GR?=
 =?us-ascii?Q?5ahdALBLvWLVb8O9wGFrAqH1jfl++/y1qozpHsjsLHCDO7PTpEVNGijd4dw8?=
 =?us-ascii?Q?PdBxFtaY2DK9UUBmWV3nCWN6ivXfhpN9EfYR66lSUcFKBAYWAy1z+U7sSKTq?=
 =?us-ascii?Q?4k8C55CmX1caJV201SmOy1nYiewDh8YAoF9aoOZcDQKNPJio1wZPzA0sBgkZ?=
 =?us-ascii?Q?m3s4HOYtvi+fpddaukozXDrgWv9d5hXfuc+49bOJGxnaJweWC2iJaH2qgS4I?=
 =?us-ascii?Q?JI8qNH7PSFwRJMgvd6yGwdnhnOAwe2+/c273WUzIUUgiYyS5d9TSlj++e6Ys?=
 =?us-ascii?Q?jChQ0nL9Li3UnH2X0Z4EI9y2XgMwRyGxuZB3HZIXdujvrW3yHk3u2o0GyURt?=
 =?us-ascii?Q?5hQ9Ip+qha6NcpXj8fPyYWCqg8htSDSwgae9LTW/O8d5HCNN+NKlamhc181S?=
 =?us-ascii?Q?WB2E//7bNSn6Xm6iiCIun7mtbYr8QBX2CBfaq0b56LcaMgc3wOHt+JXVh20/?=
 =?us-ascii?Q?xQrhDe6BytUjZk5GWkmp28dwS/fq2RlD7tlfM+SD80yANqRg3l9l7Wwgq3zg?=
 =?us-ascii?Q?+SS+yJFajzHTwnnCSbDD+gumFwfwjp7NXIgFMg3kcCHm9raTRWCm6bXQRpVH?=
 =?us-ascii?Q?pxJRN5OubEl6vZ/TuGo1I7f4cbu6e9TyFir50SIyLAoCfmlG2I6ijzmX1WDG?=
 =?us-ascii?Q?lfXZnXZ619Sb2GiDLrbhFPJbe2DISTLg4j0ukBuVE3cpjz4LNUSa1FKVUTm6?=
 =?us-ascii?Q?CyEO+9tGpbpWwYTKP+FH1rEEfvcjC17lZq4f0sLdUE282CAjfEjdqNtpEr6O?=
 =?us-ascii?Q?hkr2DknWyAbfc7s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2xZgnjfGz2P1l2uua9vUUOCYr9rMhrGLHeHsGbcJp9Ypdo7f0uADAL3Q+OQJ?=
 =?us-ascii?Q?19ft2djELBhmkYAVy0SxCotR8TKAFMam1dWUJH3DfSmQhJJf2CD81n9DFmZY?=
 =?us-ascii?Q?RslGiJyQJvjohV4BQMZC2HQoxrspTqoXrN0gDdRZ7XMJimhKA1x1U+W59+ji?=
 =?us-ascii?Q?W72oqTeYU6gJy6EdrALP3RR22Xk3/lk2OL+WBbSVVSxu/aZ8YrRT7RYJ6Qne?=
 =?us-ascii?Q?5T1t04V2zH/CFJ0ddsd/+Brftm0O+bxpTZeRN9KumIsbalC69hhJ4Wv0NEUv?=
 =?us-ascii?Q?FOrX/dgOFC4TDJgGjRZ1khIBml0xvgQVc7BtBVWTCVspVd5YQwnrLjE0GnbH?=
 =?us-ascii?Q?lYCp1Lh5DXJT8K20mYYn2K2Fp5JtHm5VPzOjazwr1yx+Bv9TecNox/vI/75l?=
 =?us-ascii?Q?FHKAozq9NvUDZIhVLaht4yKVzl1xsdbTr/w1ISwhr/sYGUhS2E2e4j8Aim/I?=
 =?us-ascii?Q?ipa/Dk66wA5gQ2RWRCqfwj7R05e7gI6RkXFhTnqYyDdA+jV0DgFPGH1rISB2?=
 =?us-ascii?Q?m1GlbSCZ7YLvj+n8beZvBcUhD6g8IWBQYGzeElPt/YPaeSJDaw/2vdlOcImA?=
 =?us-ascii?Q?oFh177dgRb7+L5e+wYZyWojYji7TZT4vCD5tS+E2vA7dzylNpE3SpZpHyWWM?=
 =?us-ascii?Q?Wzws7K7+NSyi1FdkaCP4vwzKq3NO5su6Ui9V3mZpUCbJ6ygx2cVbcFZVxNn3?=
 =?us-ascii?Q?B0bSlTt5nFnUkdJZRGmDuCC5Pz+r4U1xgWZv/a4cl8awEjQ6qggLYURKT/IP?=
 =?us-ascii?Q?shNgBpN/8TNIcwM6jLct/3Fj2nQwJ3doP/oPW+nMMSEAldcApwIW6wLQYmrU?=
 =?us-ascii?Q?EkMdsufUd3mT7lxSFh8y1r1PK6FmvMSycFq6qqO9kvvYSnjmXPVqJb+aJITz?=
 =?us-ascii?Q?2Y+vCMLYGi4n+wP+txrn/g3Oymew6AG3lkRvDAFAGHHsPlqNaLc4Rcmpp3+t?=
 =?us-ascii?Q?GUSyepJ+aoKmMOIk5Yfj4UcajlSdq/1r+B9l5BVj13d9yokNHKpLVFPeOJJ5?=
 =?us-ascii?Q?n3cQOfq/XZOdVQZ2+zaO22jO7f4bkO6UXE4crZ7hbOxU5WlhQiPSqZSN1iF5?=
 =?us-ascii?Q?jKBietrEGtXLwUV6JrJ+LOJ1bNXJiknGHlDjnhtQ5OswDIX1QvPbET5oudSf?=
 =?us-ascii?Q?QoCNbS1bIFAdNhqg6Su2lg7t1cGLAm+y7dYKidxB4n28P1Lu9wDaY4wEjWnq?=
 =?us-ascii?Q?/WXdX9yXJJ/qFyVB4lDlZt4RHxtmUOI2mxa51WN5MKF5UZXC1t/tmefcLura?=
 =?us-ascii?Q?wo7F2qTw7bnfEzP1VdK2fX/IOP1q3u2Q14lXgRwed1ARaBaIwgOjnMgdEVhs?=
 =?us-ascii?Q?9wk/eskkFtSIcqLtq+X+y8ti4tEkz4DsgQkNc7EIF5HboND64ehKZHY6rRol?=
 =?us-ascii?Q?vXXbdDiVIWzEBHu3NVr8kx9nD3F/k60Z6Enc2bmNC97f3HXLprxFQFVWgwuZ?=
 =?us-ascii?Q?opDh0ZhtkbS87M/330wx1huMWZRkZtBQiXqmRUqUTciWotJtyo+Fy8dvor3Y?=
 =?us-ascii?Q?8hRGE1/ISzH9ShPNJb3D4d5/PdaETgE+dWuhkcj/z6AzRA5uQIdThgmtp/i6?=
 =?us-ascii?Q?iQ9PQPVU1XNn7/p07F4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ea1235-fc94-418b-6245-08ddc999134f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2025 03:29:04.7008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AkeXNEace+KhqVEPyacMYINRDCgx1gDhLtcSXb9xj5xsYqH7Og0LaR+cNEWOyA3sedGsnwsNXzLTY/lON52haw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR18MB6202
X-Proofpoint-GUID: XyCPDOn40u2-xC-Voy9bTqrHjzOaHh1x
X-Proofpoint-ORIG-GUID: XyCPDOn40u2-xC-Voy9bTqrHjzOaHh1x
X-Authority-Analysis: v=2.4 cv=X9NSKHTe c=1 sm=1 tr=0 ts=68805704 cx=c_pps a=1obilpf1NrUQh1sC5XeFKg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=-AAbraWEqlQA:10 a=pGLkceISAAAA:8 a=M5GUcnROAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=hWMQpYRtAAAA:8 a=slfM8D7z6D07jJf_prsA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=y1Q9-5lHfBjTkpIzbSAN:22
 a=KCsI-UfzjElwHeZNREa_:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDAyNyBTYWx0ZWRfX9vzGytT7mklv Oeck00s32HnR4Ln7muwrgxYqbpjyhIbitLufeH2aMBL86AVcSTbRw3bcnCuNeiheWPSGFcozbiC em14kHTqf9nOhXbzAuYr9je4jPpcJuycM2cOUR1cmBWpixikZJ+hIxj1/GD0ac0jaVDDhUdG2b8
 Zh/AcFffS7faR3V4fQihFbLFgLz645v2FXLrHZps83QzOwsnzoPLB+OB9b+myo2XvJrVyovc8ed uPuP8ty8sbhUfvUB3x4VUh2llVMT28tACAMq0XHzpEIiVwv+r0tUPu6R7666BGp02LgZjDkcAoy gYX2ImaLXCYdCi/VnBE85GuaeNW7IYk6ndRO2On79FPBUgZAUIlD2MOrl2Pvzgy5P7/ofLT8Fwn
 9Q57dgTBIZ8s06j+99VvxJZp6OLPs9amsNE6UStDtZDdZMW5g4BR6+6JVUW2W7gwUb3pbjNT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01



>-----Original Message-----
>From: Chenyuan Yang <chenyuan0y@gmail.com>
>Sent: Wednesday, July 23, 2025 6:03 AM
>To: Sunil Kovvuri Goutham <sgoutham@marvell.com>; Geethasowjanya Akula
><gakula@marvell.com>; Subbaraya Sundeep Bhatta <sbhatta@marvell.com>;
>Hariprasad Kelam <hkelam@marvell.com>; Bharat Bhushan
><bbhushan2@marvell.com>; andrew+netdev@lunn.ch;
>davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
>pabeni@redhat.com; ast@kernel.org; daniel@iogearbox.net;
>hawk@kernel.org; john.fastabend@gmail.com; sdf@fomichev.me; Suman
>Ghosh <sumang@marvell.com>
>Cc: netdev@vger.kernel.org; bpf@vger.kernel.org; zzjas98@gmail.com;
>Chenyuan Yang <chenyuan0y@gmail.com>
>Subject: [EXTERNAL] [PATCH] net: otx2: handle NULL returned by
>xdp_convert_buff_to_frame()
>
>The xdp_convert_buff_to_frame() function can return NULL when there is
>insufficient headroom in the buffer to store the xdp_frame structure or wh=
en
>the driver didn't reserve enough tailroom for skb_shared_info.
>
>Currently, the otx2 driver does not check for this NULL return value in tw=
o
>critical paths within otx2_xdp_rcv_pkt_handler():
>
>1. XDP_TX case: Passes potentially NULL xdpf to otx2_xdp_sq_append_pkt() 2=
.
>XDP_REDIRECT error path: Calls xdp_return_frame() with potentially NULL
>
>This can lead to kernel crashes due to NULL pointer dereference.
>
>Fix by adding proper NULL checks in both paths. For XDP_TX, return false t=
o
>indicate packet should be dropped. For XDP_REDIRECT error path, only call
>xdp_return_frame() if conversion succeeded, otherwise manually free the
>page.
>
>Please correct me if any error path is incorrect.
>
>This is similar to the commit cc3628dcd851
>("xen-netfront: handle NULL returned by xdp_convert_buff_to_frame()").
>
>Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
>Fixes: 94c80f748873 ("octeontx2-pf: use xdp_return_frame() to free xdp
>buffers")
>---
> drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c | 8 +++++++-
> 1 file changed, 7 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
>b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
>index 99ace381cc78..0c4c050b174a 100644
>--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
>+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
>@@ -1534,6 +1534,9 @@ static bool otx2_xdp_rcv_pkt_handler(struct
>otx2_nic *pfvf,
> 		qidx +=3D pfvf->hw.tx_queues;
> 		cq->pool_ptrs++;
> 		xdpf =3D xdp_convert_buff_to_frame(&xdp);
>+		if (unlikely(!xdpf))
>+			return false;
>+
> 		return otx2_xdp_sq_append_pkt(pfvf, xdpf,
> 					      cqe->sg.seg_addr,
> 					      cqe->sg.seg_size,
>@@ -1558,7 +1561,10 @@ static bool otx2_xdp_rcv_pkt_handler(struct
>otx2_nic *pfvf,
> 		otx2_dma_unmap_page(pfvf, iova, pfvf->rbsize,
> 				    DMA_FROM_DEVICE);
> 		xdpf =3D xdp_convert_buff_to_frame(&xdp);
>-		xdp_return_frame(xdpf);
>+		if (likely(xdpf))
>+			xdp_return_frame(xdpf);
>+		else
>+			put_page(page);
Thanks for the fix. Given that the page is already freed, returning true in=
 this case makes sense.
> 		break;
> 	default:
> 		bpf_warn_invalid_xdp_action(pfvf->netdev, prog, act);
>--
>2.34.1


