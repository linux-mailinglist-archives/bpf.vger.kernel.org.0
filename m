Return-Path: <bpf+bounces-75491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D270FC86C5A
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 20:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B54833538FD
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 19:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6D133509F;
	Tue, 25 Nov 2025 19:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="g6GrZf3g";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="llHotFGS"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A679334C12;
	Tue, 25 Nov 2025 19:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764098338; cv=fail; b=fITxrel6Ls9lhrvJJRjuGg7G/klwXM+2XTn4VXZDPQ3fw5h1/jSCLsE9F/aMzE7mmhtkWysWXVnbmwLvFsCBXm1Za+QVidU3tWklU5/8o80mzaB1WABm+/Hr9qN2xKCDkXt9Hbfl3mMVOMQ4hJ9tq6erBBAH98McL/LtsyR35JA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764098338; c=relaxed/simple;
	bh=1jHkhRYhTwJBVjzKOFuGiJ5uE6dMG//nKxx9+2Q2K5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uQhTdsuhVoE3q4V6YJ8g6y651l6X0orgDo9LJhxBsl3CFgFaYvIfIOdY9f4fyex1pK7yJ/hur91YFg+mR0VWu4E2Mqe8rwiHS7vMuTPoqhlRBOKuDffsqTA8mqlJ51fhPEmP8yVxtrerADH+Z2TiGS7VxsNKPK6fo4bMa0TLvyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=g6GrZf3g; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=llHotFGS; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APGKoNi2184171;
	Tue, 25 Nov 2025 11:18:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=xV9NrQH8mCFSrmZX92YN6WqfyEQwxktdRVZdV94Ql
	28=; b=g6GrZf3g4nhvsuhnrH7F0UwdumINnG7mNmV3qRonMM9DByMG92XiuMbQt
	XpnQo9i8nhOVXbeOTPEKqxr6AShuR7tAgWkYu4K2kt1oUSqMhEVolcz5mm0pdfI5
	tFPoL36AR2I3aIupDWgZlivSeVQKdZPKzchUxN1AkkruXWxpBOIo/nRCYFiD0vcR
	qV2XpkQbye18pGLYzUePpSJNXxAh6byf30wbOd9vE5Jea4sHWLV9tY2LB9IrpU9p
	KnmFV20Wiz10pbZl+9JusHZfoOmfBd4ow2+m7GroIJSY7JHiRJ5FQMUiqaQMJt5F
	R0yQgzfa9XastqOwRqoBQOS8QYoaw==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11022110.outbound.protection.outlook.com [40.107.200.110])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4anfw40cv0-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 11:18:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jl5ltpYpfdj4o8hUsaXdc31zQ/XfZTRiPTJUhLFpHFC8rvBpfDuHiduKOSn5Rl1v/aGMklVbCr+PxNNMu8kNzhRjBU49KPH0j0VdgW6Xr9lw84p4cD5c9XbB+Hsdk+bWUld2h+01x3Ytnc/2oyF/E5JZ9vilZiyrtXOQyEtMr/sSXizD+ae7JmcpZ8bfP3Tl1Ms3wnQ4j3iamuAdD+fkYmCGLvZSo6sRkOLlx4+qYbM5dC1q5D65fstkwc4uFrkJqldPz6prWyo3xdDz7PvM6MReFKIkzFjEt17avn0n3iajMaDTlU4TdQd6uxvaTEsg5sqsGNv0AOCjuqX/8HAMnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xV9NrQH8mCFSrmZX92YN6WqfyEQwxktdRVZdV94Ql28=;
 b=ovTJAUnQa2lbX/nmRo4RtDkWwFeoSXzKNczt3b6Hh2UKjAP9OhqayBchekpY67y70gqoeFJrTN3PmJbgAiyUouYKgm0QasVnDjqpEAVdLjqUBX01wOsx544n4kPIYGSn6rF9d+HXWEgu+Z1BuoJvYmTvStTglLkQL+VMgAExy7qfDMMof/QiWqsdb0TH+DTPfNF7OwnAw1rjSwXQmcIdM5j0U0yEhskVPLYHNF0HbR7VIKwA3PIilGMov2gAZdfyfQ6fjxElXeh+J5fq0XLm2Y7232wAozF6wUM1GdhgfEX1LiT3SRmcpYTiBa1GQ4Bv/UmXOY3mhejO6XzHHU+nnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xV9NrQH8mCFSrmZX92YN6WqfyEQwxktdRVZdV94Ql28=;
 b=llHotFGSDxpSgVS93Mgcx8W+5f16XOK+018DnxGUQvde2E/qXs4IloYzVeQEeScJMGf7gVIacUgtHNhWgV7fQpL2Q9V1ICoqLcIMKo0ahTlXXK4lhjQ2lwFDTdE6XGgrbdD+SJNn+/XgMzCxNysMLlo4UxyEKhLtJftkg2ofpYbf8HNeBXcL31Ybb5qSv1VUzgsesye+D1h2i11rf2kV70bxMUKkPapNfedqyYIEMBdWpsBnzXQjI9kh8kaFSqo8KTzrAlLzQBh9COi8ptbfPJK+wRzpDCu/wN9wxqw6UvYkXngDjsFgGJadVHTXJ1wWZjsqVcCqk5/voag3U/D52w==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by PH0PR02MB7557.namprd02.prod.outlook.com
 (2603:10b6:510:54::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 19:18:26 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 19:18:26 +0000
From: Jon Kohler <jon@nutanix.com>
To: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        linux-kernel@vger.kernel.org (open list),
        bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_))
Cc: Jon Kohler <jon@nutanix.com>
Subject: [PATCH net-next v2 1/9] tun: cleanup out label in tun_xdp_one
Date: Tue, 25 Nov 2025 13:00:28 -0700
Message-ID: <20251125200041.1565663-2-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125200041.1565663-1-jon@nutanix.com>
References: <20251125200041.1565663-1-jon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0128.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::15) To LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV0PR02MB11133:EE_|PH0PR02MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 03276edf-8086-478a-0011-08de2c576891
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|52116014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?os0C3Hfb1Btdu+T6UIyLeEqwdUOLMMSkqkh5Vz1HHGj7jW+RX9W7i8Mr3mia?=
 =?us-ascii?Q?tGE2reylsr5gOTZ00/MDNTPOYuq8pHNEzJ3fI+vgdWCKWsz8DCrC3w5WWFZu?=
 =?us-ascii?Q?1cFjEJ9DOTv3dhVaNFtegzMjSEVBiqn65tofmcgKqVyH7PfvrwkVkrNAPDHF?=
 =?us-ascii?Q?rZ1hPqfwvSNNz3c7hRZuC2gvWT2w7NZeIuKbbH2Qnf5cQARhSUC+3Z4QfgYy?=
 =?us-ascii?Q?RzUPgylYGs2Wy0OokoHIWP8ytJg9QSjECObBP+lg68FQ7v4I+MJCrdrmbWxJ?=
 =?us-ascii?Q?Dcwf9xadGmKO9ybsctKMg50MGJPQNh7rYAlzLrEIUp8gFIpafIL7XSmhk35X?=
 =?us-ascii?Q?dG07lf9RDMOs+BOLgJyEmMrtVw6CaFISGSVKbR+/EwFDF4bV4zqSyJL/cYjZ?=
 =?us-ascii?Q?5naUatP56h7KTB2eWIc8S+xtNXfp8Abk5qWFBhckQ2evhdrUE/yVY7IDsPBy?=
 =?us-ascii?Q?UY9qUjkYVdchn821JXDBzDdrBHxd1eX+ZlnfC+9u4aVQAQB2cIIW+OtknVot?=
 =?us-ascii?Q?gz+4Z/k7wTCpMM2+oS0LMMT7CHw0A7JT3dQ8ejUqzDfxJUNGveFrbxRSexZb?=
 =?us-ascii?Q?N4xGtq7HPWlKUuAENZgJbGFyaAfZoMA8HPSA1F5F22ghCIQWGJ8ulnhbfv9a?=
 =?us-ascii?Q?1V6KZBh+QS1+PJTYxrVzmgvzl2hcZqAWPR+okhZ73wv+guOCl+2K4My0Hka+?=
 =?us-ascii?Q?LpwwNp/1f10hOUMRX2sFBquQv65mq6lgBZqkj+tPxGc0lCQvzRhmoo5qYRPz?=
 =?us-ascii?Q?4bz0Nx/vAjlzTg7oyAQY60tF6nNDBdk6kz2xoA4d67idxZxUrsbgelvwgglo?=
 =?us-ascii?Q?oHCD25VGgeZRAPe/FWTZ19rgAVKzQTDMvgGA2iXYxzcZmh09S8poLHCUGjHm?=
 =?us-ascii?Q?6VhLfCHYwI/+2VF+vQvv0GZXiOGldSF0YrhYGZrV8GNGYXFe6+Swkbo24wT8?=
 =?us-ascii?Q?bMz6/KtxUcquBgW66OZwTCIvyQobUMnVke0nHpF1NNmVYyOWQ1XCe3LLAMZw?=
 =?us-ascii?Q?BOqWVJ+rptJz2h0vdGPJAehp6Wdi7lWT2adgWKlHZHfJsYnFpFKMPwDu0CJS?=
 =?us-ascii?Q?QJ+EFEOy9Ypiv9E+7LECbBybFa6NdM/OKXcFCg9Mc32X/vSQeWgLx9/KptZm?=
 =?us-ascii?Q?uqKhhUuA1Fngk74QsfBBPRPAhW50R4rw3j6cIxfNQ/PzpBPgSzHvM8Y0816p?=
 =?us-ascii?Q?NrpJnV33xBjZj19TaLjO8oZHLHruCJAwE2YS3LqcPCjYLqH/YXLUOFnNKtx/?=
 =?us-ascii?Q?p1jx0cPfXhZB2xw2f8ugS1dWyKOTAbN+AnVcIZooiaw8hBju6EgLE4FsPOdQ?=
 =?us-ascii?Q?9PMyl4skphRtQKfNp6ATvBvhVQG0OCv3QANwG3FkNdZM2yZn+5ouMsBsp7jI?=
 =?us-ascii?Q?Pmx9Yjcfvks5jGnHtVcoUI8Qt6UJHGpggbu3C0t3XpXmB9k4f3a9bAFcswYm?=
 =?us-ascii?Q?Pt78uZ7zghUjYu2AwNiM+EZRUBtPMVXnPpZXuwGl83K5PiEd4WBD/CCwbvTm?=
 =?us-ascii?Q?6IowwPFo7Hsos81zoTMIZqk1HGhDPrmgUCHgDvNm5Is6931Tc8w6EJE3aQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(52116014)(376014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3MVY4AYRWs3XqTf5NoTe9bSEGb1VhINuBNrGjAEMoBKMzWUR4f+D6mYXOTcI?=
 =?us-ascii?Q?wI13rv4kGPrzYe44duITf8LI1Tr21cWH3SQaY7NP2woJDWBhHj7xDYyY5jp2?=
 =?us-ascii?Q?wqpcBOc2FvFqLZa7cHZSG6IUJQiKDGY1S7kLNzJ/kMmdj+uRTkTr3vdaQUA4?=
 =?us-ascii?Q?yVPtVUzsjGWBIn6dnUDCNFJWzuw6ceh3x/8O/58nIbfEZb49bw4Z9SeZGhh6?=
 =?us-ascii?Q?Uaa0WOo2jzdPbqlPn/4nbPjcup6l4VyzsI+aPvHw1pgfNhywkpppZjd53RNU?=
 =?us-ascii?Q?g8de4IMK/daPW1z2XcAFf1hVLE5/9iXPmI3Jc01pNhLh2mXGUy5rgjqCGySI?=
 =?us-ascii?Q?UN4O76QIEKz/AMUK1QpZJQ/7k2mKLeG9Dic8rJ+N265arjFa5VV69a4q/hZC?=
 =?us-ascii?Q?DMyW+e0/MBbbDZfnJ6hLGkIqLoCAfPQaIlmghY9It6vTSeVOO2nZwD1KzoFr?=
 =?us-ascii?Q?wwCsvfiLP2lEJEHcSCkyhXHdXviT8ommGuveg68+e5xxM1e9kbLYTqJOxuwK?=
 =?us-ascii?Q?2frxd3wSU+RZ19KhTMc5cARc9r4bzEfIb8FumGAIVwwONUvHJur5N028/VtO?=
 =?us-ascii?Q?s74cpBjGhFuFYHo9S5U8IHb0gbZZ4S5cXygvxO2iUDcA+v1U57nRbsoFKK+g?=
 =?us-ascii?Q?3lwBGiouZPk12iPvWlRUyp2zf4yrChuFejqoYu8ZM8hmNbQj80mcT9derZDV?=
 =?us-ascii?Q?1QmxeZCZ6WUjY/Z7G3BBz/9wpkeCbzuI73YSQ80AS/yU9j6adOxpIh6nNK/U?=
 =?us-ascii?Q?jOccWnxhmDjLmDuJHkhRlmLMvWs0J6PHjzlCGFbETEN5huU1Vvw/bZ8meHpH?=
 =?us-ascii?Q?9SbTnOsYyBriPT2ADVjZh43MWKXBdpelgbAn7yBaR26GXdXVGJYCuiv9tKQ8?=
 =?us-ascii?Q?c/993/yTvwyH5mhh0gw5unj6kjkZoK1t1t7FMOR8G1/JvJ2dlDA9tuEEh5QR?=
 =?us-ascii?Q?o6mINtExtCdMefmR2ldq4Vw8J7Lczv5rOZwIuX/Qi4hs4juGlFhzOdgzLy7y?=
 =?us-ascii?Q?2CQilK/meo2Vh/I6C3Hr0FAS+VVUxUVS+5Mda00W16m6lKJqPqP3/wRrludN?=
 =?us-ascii?Q?tmAsifMevwr+pbolGXSx2Q+kOFyP1JxoKA5zNlmlCMOa+gOg98UJhxzxHvru?=
 =?us-ascii?Q?o6gMpsb9/KOIaFgTKt17uB60BDA1rqFYSuLDlzza2RKy7MvYbyC6c3nzsE1X?=
 =?us-ascii?Q?/QQ1EC8vMd6Dfy2nXeW/jW3igcyNbmOg22PgmnK5yjICLd1uTkaZTUQpHdZH?=
 =?us-ascii?Q?AVW1Ua9dcdnAB9xMkFtX9atxc1v6C+CDKJ7NfRoAdjkOW3woYwxTn390C6Pb?=
 =?us-ascii?Q?tSFIMRojU56S0/xS2AJpm0hkps80AbpwIrh9WZMKO/l6X2W0myd7oLUy7DYN?=
 =?us-ascii?Q?iRNDH0uJ4eOhvh2dZlAcDwB4bC4+rICCOCoHEIsBudP/Q2MTFZ/Wue9UgJNh?=
 =?us-ascii?Q?1cn+S6H2z2o2FjTxu9Chy/YtL3W9PqxZ8T7moon/LOCI3qsF7PLFAMlDRxnr?=
 =?us-ascii?Q?Sht4flYsbOzTmZ1aQH3eFcUHDcSrKWKOeue9DWv0DwcWsV3MELzqAKP3V7vi?=
 =?us-ascii?Q?p64agUQV9RUi0KEfKUBpHOLoqX2E7X8PnZpshsL/ZLAXRKB4bRJudAkeofER?=
 =?us-ascii?Q?rA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03276edf-8086-478a-0011-08de2c576891
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 19:18:26.2860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6rOnO+EX7UDg1SecdKsbLzuYbUH/W0ySd6iLaP/CtNDGPv1h0n3Q4pc+qDRZ1+hsmy6d1qRf27Bu4WUY4KURK/9Qu9D2arYdvCWqK+HtP88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7557
X-Proofpoint-GUID: 5IqWnarx9TmWac6eZRW3YvlJHWNRNYio
X-Authority-Analysis: v=2.4 cv=NfzrFmD4 c=1 sm=1 tr=0 ts=69260104 cx=c_pps
 a=ZQ5czZ6yTY4ZD+V8z0ndCg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=ZOehAMm5hNGlXI6_TQwA:9
X-Proofpoint-ORIG-GUID: 5IqWnarx9TmWac6eZRW3YvlJHWNRNYio
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDE2MSBTYWx0ZWRfX+nAW1IvM8NXm
 NVA4G+AeY5HwtibFrXTCnl5oMM22Ft9nACq/cLaNwR+Qca08PccGAjNKvAw5aJNCca72jHiQP+V
 VM0AquQtdZHgJzA+QDORkTil3BIixrfSa4KB5RDty9o7SgHwsJapoAjmcG3XOOpqouHE99H8bFO
 Wtt+4Nd7H1JB3/OPfmWXCzyTgp4kIE4+pgQGr/2g3M5P9wN2rLgTIpBCVYQH3XkfzIt9JHFZ0am
 ScCGa5S0D99liHcRDZGP+gnEPmh6yUlbLY40kQvkctcy2cUgoRoXe1QIEssBOu2D6+OEFJca2kn
 inaxgg0cYu/HfjGnSDW+3HBfvJ9gZqkVwcgLJAdIUK/Coyc+eJMqO/tZLaLViQy7jBA1Q8AIgby
 oBDGtTwo7A2rLcmSEpkEbrWpfPbHPw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

Make all previous callers to out simply return directly, as
the out label only had return ret.

Signed-off-by: Jon Kohler <jon@nutanix.com>
---
 drivers/net/tun.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 8192740357a0..dcce49a26800 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2435,8 +2435,7 @@ static int tun_xdp_one(struct tun_struct *tun,
 build:
 	skb = build_skb(xdp->data_hard_start, buflen);
 	if (!skb) {
-		ret = -ENOMEM;
-		goto out;
+		return -ENOMEM;
 	}
 
 	skb_reserve(skb, xdp->data - xdp->data_hard_start);
@@ -2455,8 +2454,7 @@ static int tun_xdp_one(struct tun_struct *tun,
 	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, tnl_hdr)) {
 		atomic_long_inc(&tun->rx_frame_errors);
 		kfree_skb(skb);
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	skb->protocol = eth_type_trans(skb, tun->dev);
@@ -2467,8 +2465,7 @@ static int tun_xdp_one(struct tun_struct *tun,
 	if (skb_xdp) {
 		ret = do_xdp_generic(xdp_prog, &skb);
 		if (ret != XDP_PASS) {
-			ret = 0;
-			goto out;
+			return 0;
 		}
 	}
 
@@ -2502,7 +2499,6 @@ static int tun_xdp_one(struct tun_struct *tun,
 	if (rxhash)
 		tun_flow_update(tun, rxhash, tfile);
 
-out:
 	return ret;
 }
 
-- 
2.43.0


