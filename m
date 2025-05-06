Return-Path: <bpf+bounces-57532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C264AAC82A
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 16:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B1131C4220D
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 14:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F224283149;
	Tue,  6 May 2025 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="N0XgZgXU";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="MmO8mHRs"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1F41DDA2D;
	Tue,  6 May 2025 14:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746542173; cv=fail; b=TiBfo7P9oGl+NS3aEjuAZ7gcex7dVH0A0uTfu1O46GpyhqPGddVcw/LU/JHvu8WgVcxOSLnRjaozHUGXFZshh4mQpkT60G0MR0uaapl8dEQ9KVf4F0NvsDA8gNALa5PSMdlYz0DXva7EfWkjwt7tfRZb40vLPI6t4Ka7GaFmouo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746542173; c=relaxed/simple;
	bh=4fFyf19ow5qMuqSoJeXWEP34lark8KJwPlWkcd8WrM0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sa92el9LxI0AVBVrhtBIAUImiYXCcvWm8KpfaFV+CsGnyUM1gKUkrLB/2dyfZHnlNmoTzfvO0kGMoSfURW/n0mqbGJ9fqja55PH8TQerq/woESDaHBc4AnE4+8ZX1loZKFkIh3k0uf/O/Oxzs2/dfkptcuPFBijv6a0dYQUpWxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=N0XgZgXU; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=MmO8mHRs; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 546Aru21023332;
	Tue, 6 May 2025 07:25:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=aQ5DbLom8Ahcibhanmw7HsifA0NU5npO57kt94U8g
	PY=; b=N0XgZgXUbECnbBkE7tYwQxWXTEa5iDTcTyznjBIYEzWFUSvcosrebZVlQ
	O/eCIrTC3csknHkiV8raLBLYUkG+fx+vgj00v611u3eMuExVU7FN+KEKw3+v7vM3
	520wVizrDdvXcAjg07OYu2pyyo8p+qf97vXFCnphuano7Ikb9DCiSNNNztKx5Xph
	A1wu+HuuSnu0qQRO41s4BGd4ZCGOKDz8r5iF2GkH2tnZ8vauk/y7J6kZKNMNYr/H
	2R9kW0MlRRW+OKU51DOmmKLi1sEnPPsfP23QxFo2vZ9Fao24NMz3U3MmlAENNKPP
	XsOZDJvNsKtoeO5MnXG94KWuWOKNQ==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46dj7kx0kh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 07:25:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WfHpDIfQ+hd98IntNQby67O78dkGCWTCM+Xy/I6p1UtWYkgCh9mfezKlBcgP8qt9Ga2I7gc9LcggkONvDrv0rfefN/vN/txMvaQE6KfOzou4XT9KrX8c1TtAn+Jod4GCJyVIYGVrlCDSnLpr8WZJZBr34cNfgh21GWLhggoP0QJ/lqf8GJbI/A1ho63MvUMtiNmXummk66AMnqHHeZGoX+fnjZChjj5FUHgw7iYorbOJHyQHN540HXDGiLGc3iw8MYti+fowHByb4d30JD19Q7zXr6gB1SqhIgy+TGQhE6md3fDBsoIvuEeQPrGO4FEeebX+pKYURytEsOUPw3bdwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQ5DbLom8Ahcibhanmw7HsifA0NU5npO57kt94U8gPY=;
 b=grneSUZ6E8poOv6YgPEjvub2oraIKn8sZDI0I9DOdt3y2IfX6vHLgEDyn9sXzZifS/mA4HiLVtJDB7RJMC/CaXs0v7Gn0g9krmcf7q28xF3ftFF5/mNVrSrV4RednH8Evq4rxahqmKDAREIgsk/bisewZG+nI94+VIBzs/oV/9A9lSxT4aTSYqkCi+7/lYouix5rG8eqPl5QHpo4BZf2fw5v4OAg/OqE/Oi67eOfFuwLdTN0UE0BXj6q75s82KRLTy5AnJdChzzGtMGxgTtUOUeGxDFwKOj3R+MnFS4rGKVoZNLGyZmwOjai6I5SZYJtx6tsoXfexPLQJ26DSfnJMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQ5DbLom8Ahcibhanmw7HsifA0NU5npO57kt94U8gPY=;
 b=MmO8mHRs7wouJE3XmO9I2B1pPf0rL83oJk3hXVRCI82r7STQU3x2P3r/4mFw4MFjV1/HWJwXAZ03r4QCHib8pb7GBKwRWQJSDxd/bnZuFx4HKujq+LkFf1SiBOL+fZZH3djtO42u4IGxg4USnbRQTFesI0ChBZN9QtO1eFc/OqIUjgKy+Nbz+S2J7WxeEZ5BmwMkw4aWpaFPbflK2QFo1/5EUgC0fH96qGHaa9PBSEAminoK4LHZiWCdgkOmhUufP8r86KAcb5RpjpqMoC+dBmAJEtZI1M99sNFhizoA+UmwyoYnagfJNKmt0YL1Qpn8pSORl6pICf4qQl7AsMYw9Q==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by IA1PR02MB9181.namprd02.prod.outlook.com
 (2603:10b6:208:42b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Tue, 6 May
 2025 14:25:18 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%4]) with mapi id 15.20.8699.012; Tue, 6 May 2025
 14:25:18 +0000
From: Jon Kohler <jon@nutanix.com>
To: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
        hawk@kernel.org, john.fastabend@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, jon@nutanix.com, aleksander.lobakin@intel.com,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 3/4] tun: use napi_build_skb in __tun_build_skb
Date: Tue,  6 May 2025 07:55:28 -0700
Message-ID: <20250506145530.2877229-4-jon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: d1e618cf-9ce8-48ed-9125-08dd8ca9d39d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/WMfrJiZGjDW5zutSvvwPPqESitu8QEhBeIp1T5EbJqbtATr5ofKKuoXnKWU?=
 =?us-ascii?Q?2vt661hSWIbEOlE6wi5MoftUbaTB3QH44PTmOsyTtDIEMC06cfXbOT2Thtwt?=
 =?us-ascii?Q?cFwDBgjkvUIFZDy8tLa6LVPKj1hJgPY9ZtQsjwqNFXL/2ZJZ7DpmC748k/Ca?=
 =?us-ascii?Q?008ztvykR8YTZ3L4O/f6J10qbTSNHZ7DzxwwZl2DTpOyutbdX2Sr42hKItoy?=
 =?us-ascii?Q?QHGtW9fFQy5ZXOozMKwXzW0SqyxjZBcaYO+un7D9zxqCOFn4sbtSYd53X7Pj?=
 =?us-ascii?Q?XTvgK5ETtr6ZPhv+xMfMhvvh7fLLE9ml8QPShn01UC3qS2BH11EzntoJwAee?=
 =?us-ascii?Q?8oIxz3+42+Dqfiv3p5Vqr9Mm9xj4GQJJAkUpuIwGD7inG+t0jVqswkZXs1Rd?=
 =?us-ascii?Q?IsaJnxpb6529MtMEl0480KSdWSpjGxln+ssZH0taiXSHad0Hc1ndGcrnDRkJ?=
 =?us-ascii?Q?np6xgO1SDVssK2/XXpCHtRHw/fvxbjvKWVIlXN4gzOiQtBzhP8EOHx3f86qZ?=
 =?us-ascii?Q?eHP367mpN8N95d+2OLRMWtFXBwAHfcadKX/JEwIxWS4n41f1OQJFrWprqOxO?=
 =?us-ascii?Q?mTq6bl8SZR3IT0fjFUvh1oxlDzW3qwrIod58o1vyocisZ5jZ8ltkwGxVdJRQ?=
 =?us-ascii?Q?faR7KZ6YFUaPFv2SIM07LpWR3kuaXAbIF+4WmtgrgzQQFrZUhdxknwrFLKTf?=
 =?us-ascii?Q?TV8bbv6TJ5hWOuPIxesTspviKVcHdf4qc10YXPb+g9DRFkuxgajd15FaWrkP?=
 =?us-ascii?Q?dWzUI+9dAwFZUW3mttA79FGwQeLiXojbmLO1/x15FuidC52B5eIjwQLFlhb+?=
 =?us-ascii?Q?wFPwKJ6ARGT8oRhcv+kM285F8xe0lFVQU+shpAeh3LuaBuXGtzu0Zab9d4Oh?=
 =?us-ascii?Q?oYH0mZNdMdRavrh89m3mWNkU5Hc0VKuYKyDqp9q6NhQZ2e3Lgvf1JYG30xS6?=
 =?us-ascii?Q?1sOkvaaaWJKk75aJT4zHWDNwUWn/FT6qTiOOfEr42woCYd0i2/Fi5tXLf1fn?=
 =?us-ascii?Q?d1mtBe7yW24cCW1kpn/xhnvIOJou6ztudfu2EmTYtSR3slhrTDk/ap35YBWC?=
 =?us-ascii?Q?OhXpN4iNwcdYu21FE8LHr+IfWvWSnMCC9k9zXWoZZBujQgfHOOtrDl9I2e73?=
 =?us-ascii?Q?VY6gFSvE2qV9SvpN4QzcFF6V/nPZ/o076YvNGv60pgLOY62g/F2hCUDKcXzk?=
 =?us-ascii?Q?HthwaDEerGVAxlbmHwp6vY3+UDCc7CaIc80uKL/2yNdJq09XExY59BqaqeFh?=
 =?us-ascii?Q?ueGyFAYyYAE2TNYKjjNYRs5FtMgWGWmL7XHeG4eCVzZB/p3y7LytiQaakigL?=
 =?us-ascii?Q?ccVTfBWOZCO2n6qNKj9F9LKLhxqxY3h1XoJSrV4zyMaEB8P8li4AF8r3cgu7?=
 =?us-ascii?Q?qs2Sm8Bz/o8Pgk8/gwXFpcftPvDxBpcilIumvU8o5leQac817qG2/KBWz7Bg?=
 =?us-ascii?Q?Q+9LNPykOciflKDK+pbKhmoMD/6z4B3LBA7oaoNu6fZugSrmDVHcP69w2SRQ?=
 =?us-ascii?Q?4W0TYblAEEYdAJU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?od8iocwLtnG4rtuc2KRktOXocxk7zN82UFNSIj3Mmbq2RjCGyGovRDm/F8X4?=
 =?us-ascii?Q?InzUf+JxHKp4vByCoJhcL1P+eDEdFGLnM8Yd1NajnDDtaBZU29vYg2LGBCW6?=
 =?us-ascii?Q?aWkk7StVKmKN4ZvJeZbsvJiTj2p0Mnn5LwhRME/KjrwQ2/d1DiAKKLfK6Oau?=
 =?us-ascii?Q?+uyP8+coK1sGb0/OFC/2Tcln5ismR9t7jOEYIqvDO3vIgfD+T4qacM2Ar+Z/?=
 =?us-ascii?Q?DPu1TzYEDXRnSuDmvW7VjTlYioefs3GkbCUZ4zKeG/TfNGSIyz/j932NpI4C?=
 =?us-ascii?Q?/EyxvVDctOsiI4ydZltpYNYGn86VY2iMZcloegNf2MybZCld078DoJjJ/rDg?=
 =?us-ascii?Q?RjHi4C4mU0+Q3aH+q7LKM+YSI2QG/bAPq9JKavrPnt/RHY8lQVgVq2VCkgOu?=
 =?us-ascii?Q?Y+w1TmTQM7IO74ZT+AhBXLERPTfBepWRlBKHCAPdxUp/lwx7rXct366hZJg9?=
 =?us-ascii?Q?kszxxR5cIOGt8S5nh7+hNJpAPuNZWXXXttMfViyK7KAoHi5GqNNeUNV09E42?=
 =?us-ascii?Q?Tx00ZGLDP8PQ00LydAOLUVRtspCcKE+2Sgvtz7pZf4a2ZCwXFqHLu1cDOTjp?=
 =?us-ascii?Q?nlVLQbEPIFOmrGrQMqhkzRfDe238zEVxCWt+rfOBbgrVVYc3VCUFiMjxf3kl?=
 =?us-ascii?Q?JuiIHOPyTdwN6jBHa/VohkKymhEPJq2+rFu7x6F1BbSn2fuiBT2qKRMpTaoc?=
 =?us-ascii?Q?zmRhEqWjlbMtBb4a+pcraMzUNfKZOA7qwlfkAk6RMHwvBI8arJYfjOWjderS?=
 =?us-ascii?Q?oi3/UIgXlsW1niBMGDj/gQVEgA8Bk6xnMwxT4mXRj079n2CZSXQ5yOxYhYlP?=
 =?us-ascii?Q?jP2z7ORJXr0SFY81zsdYm1UvHfB+5zPcDetT8kRNA1jNCSpjErJMn4xSrhL6?=
 =?us-ascii?Q?aQ4ehhndfMl/UlRBeN4Am658IdsBDU0B1BOIucGC1JekTehUeG5nWD4oTFwP?=
 =?us-ascii?Q?DkiSCIFpBoLkn7PJ5I1dE+dmHbc10OSJ1DXKR/6Gp95dpSwSUocr73w1xkwq?=
 =?us-ascii?Q?sGMGswMukfZh+OXh5nSJqUVBr2Z5Xg7DWH0OYIFVKFiqEiXkDdpwPSBP5yUW?=
 =?us-ascii?Q?rLd6F5RfrgtcYsDpvploBKUcJLCo97J1ejh4G8ipRrLN3DBIkT7WdaV07mgv?=
 =?us-ascii?Q?BgjjWQo1N+rYZDJbVMQEvSsQbYbiwUjXu4pUl4KsU6insW4zHD4qMVti5LIF?=
 =?us-ascii?Q?wxyAeqj3eemAL8eRcbSxiYaqC/sk1MG0C4wxKcDmQhdTXTHYHWhtbmnb/Ymh?=
 =?us-ascii?Q?Z/UXELklM5hRmKdoPkDKhSwAsyDrbDoK/mzrB5pnO4FUlxK82ChG9s+qfIf5?=
 =?us-ascii?Q?r3BQtg/e1L/FynRbRo2FkHv63OUnOzysSSSeZiuXodqEYh175s4bKJ/ziJYU?=
 =?us-ascii?Q?m3eNogIMHnY6oNIZ5dH9xv3cgoF+B8HbY9KtvKMCw8oTCKc9td7vKa5ncPeQ?=
 =?us-ascii?Q?BzZWf2G79r0q1Q9qWs/i9/K90ft2K3yWP5fVT7F6AGs58yFnCfG4ySBPyUxk?=
 =?us-ascii?Q?LC275I0A3wXKL9XcNqZwue3uqOmhOGL8bJBIVBI+uab+JVSJaTcOaB0h3Mnt?=
 =?us-ascii?Q?ju5aQ/RNaOD/LTmzv2VPLpNENFv9PgAGcBj3FdQ+LpnmV85py/hDcI+6qtdX?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e618cf-9ce8-48ed-9125-08dd8ca9d39d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 14:25:18.6794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lHI0jby9eVNm/Bkaqnx9szGHhzoODTI23EDcUsNwSUbfQEkaJiCdLyex6A4P7EfDn08/eJ0ed5I4VkOaMSwAPA0h0gvnMOq9hzgH3iXU6BQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9181
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDEzOSBTYWx0ZWRfXwhD+hVeiMx0C hIMNzWn3A1E1ZPYWFgFHVK3E6VHaIIKH7yJQ2xF8ytsO2zkMiQLOmnWR1gHJwDc1NVJ74cPaNPY NpFBWntPYsmqFCeQQI6bQmKTtS02BBVAxO9JeQm6+N3C36xX8sXmPzc86BzCVwmCUHFy1lCv/Nu
 k1Zoha9oLk9wtJR+j4h5ud8cGsQzx/8ZkKRDDvidzCl3yqWqf373DZ03Ysq5R41tVyRgO+9/8nO QyfZTLeTIG4rN8TjtZdCFdiP0PKWIp57uSkAOMIOjlSrYLQpRAOXzY5Ahr2BKbt5C9FrondJC4w A3/YIGU9dnyaFll7AZpvGIEVNlMR8l3ZxAiHBW6RcX/A4u3oYXEb3kUERHddSkvrOKHePtQSeet
 GDhDr5s97b5hj9Iwa6VsrtyJRsU2pdYAqudUbuqL6fu1dUS0AAvatTEh+o3kIHxOXZ54xJD2
X-Authority-Analysis: v=2.4 cv=LNpmQIW9 c=1 sm=1 tr=0 ts=681a1bd0 cx=c_pps a=AHWEOuZXH7ukEk4XErmcRg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=DtH-ZNJ2jHKKiKdS_QUA:9
X-Proofpoint-ORIG-GUID: o-UE0N6u_dGMJ99VKXig2001MizTYuwM
X-Proofpoint-GUID: o-UE0N6u_dGMJ99VKXig2001MizTYuwM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_06,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe

Use napi_build_skb for small payload SKBs that end up using the
tun_build_skb path.

Signed-off-by: Jon Kohler <jon@nutanix.com>
---
 drivers/net/tun.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index f7f7490e78dc..7b13d4bf5374 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1538,7 +1538,11 @@ static struct sk_buff *__tun_build_skb(struct tun_file *tfile,
 				       int buflen, int len, int pad,
 				       int metasize)
 {
-	struct sk_buff *skb = build_skb(buf, buflen);
+	struct sk_buff *skb;
+
+	local_bh_disable();
+	skb = napi_build_skb(buf, buflen);
+	local_bh_enable();
 
 	if (!skb)
 		return ERR_PTR(-ENOMEM);
-- 
2.43.0


