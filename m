Return-Path: <bpf+bounces-75493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D739C86C60
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 20:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 356724E672E
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 19:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF4D2D29C7;
	Tue, 25 Nov 2025 19:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="D6nRMIls";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="LqrjXl+o"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078DA335071;
	Tue, 25 Nov 2025 19:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764098339; cv=fail; b=uZGWfv0lPD7gazSY7fcHmSX9llOzm1pQeaQUlWPo0CcIp2LbIiNa1yr9Cqn7qs63U6eT/UcvW1Meg6mo5b7+1X+i6Rr1wPMsteG2k4o7jGzvlCHPNDK6xUGQNnjqPa7jDe8P4uuKfZU8efqhzZWzT/7xuVOyiTklaJWFReO02lQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764098339; c=relaxed/simple;
	bh=LPSdluYNEtnRpGUyEBjIXxzJbCpB0gTInzCOGoxx8S8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j46kmOavTVK+GdWl8ng/KylnAY6BID1U1WgJu46coz9+YGO9i52ouNlYzfu93PdFyFSXfF/EBNOKSR57tAn9iNAVgPWWOFJEL3vcQeLa6vbUY9qGcKLZVGBVXL0fNEyZbNaJ7Xc/m/h1sjiW5YHxjVnee4F+M2F1ieZ3pdJvFhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=D6nRMIls; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=LqrjXl+o; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APGKZKA2183761;
	Tue, 25 Nov 2025 11:18:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=ZuAkCQhZwTgF4XMvPpQyQ+5fcox0K6xLxbvOD8h4Q
	ZM=; b=D6nRMIlsfPd8H/eX9MQRi8T6N5uaQcxbbfCR5raGNe3pj2U6eOFobTDak
	YsAc2/x3A5vQQ+swqKswG94faaSWit7c99JY7NhPETrgL1Qr0B2bJRXiOrt1Ewg5
	j+AeJOTLyLSd5N6SR+0/1SYoS2kdZxD7TT/jrhwSR3LSjkd0iVKPxuPxCqgfH2+Y
	GqDSox6LFkEqMt+1vY3tYjYePYE+w9+uZxL8Kzis/4H+BtLmrxQUixeAVYcA5OyO
	8lKFH2dNT6LFbHYBfcg6Z6d/1vhkFZLUQidBbJGiycC1YJoia46+IuYKqiQW7Vtb
	4WYm3jLablA23+fU/gICQNFrLcO+Q==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11022075.outbound.protection.outlook.com [40.107.200.75])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4anfw40cv3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 11:18:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPDMZ5HchYtMFP4P2QAkVCkmqjcASdVVhhwcrmX4TqqW8IRJNC8VoXC6jWWxUyXa4Ix0WQYCUkkyfnNJZYJ18aRuxkxXGgDKdb/OGV3ovhEiGKusZJfq5O3thS2xbJIM5tKbL/H3NXmWlsemlirTQulVOsvy4spBMjqp7yCAZaQqgOqmhk2T6FXsb7dY5kkuTR9Pwda5MedK88w+JlddaJrxZcvFPlwcso2CMnJ6+PX+0yxUJDdB4LURHhx0IaV81ZoEaSgMIHve4Tgappx+o/gQgXb3PP8FqntjV4f3Mn+cHxkLc8eWSgHD25cdxSgZkvdRVX9RxaHRLdATOw2NJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZuAkCQhZwTgF4XMvPpQyQ+5fcox0K6xLxbvOD8h4QZM=;
 b=ukN5sKY6N/jB1teHCfa6WC4iCGE8BMsUm1Q5mJ/RzFVbKEcP/ZhjXM+CIx6XRuNUomaFfaPyR7k/m7fp0uXFAzwHhe8CrrCMswQIzvc7u2ltu2jdyeM8lFbPbpM8GUfKdxLHF92jTsDN10LB370G/fK8O129QIWIOt+Nbf5F80Ku2OzWRf8SnDC5GrTNWksJAdsXxIV+ETwrTZvvsLFdbL3eKYweGZJSuS/7RfYE9A/C1ALBakqNatvRSZtw7y3dafKZ27Zw/RxjPghcxXei22g/piVhZA+Be8Z1biFwutNFJs3w5A3YP+qOeQHRCv4RnXaChjHM+JFmYqbfEFZ2vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZuAkCQhZwTgF4XMvPpQyQ+5fcox0K6xLxbvOD8h4QZM=;
 b=LqrjXl+oLTTefbDpycq7J5xvAiLuiPViI7qsP9h6S0D0musbCUdtgQrcIfDn9xyNtqeBr8irxQtvAXvFq7ANZlYEoOrgwB5NpNV1eirnHMlY4hR7AgCXA+myOMYgEFfJXN1IBjF3UDFnkvAgaLi/V7BZDPkjO1OEYR0RKaDFs5/uacRiATUbQcwdyaNaAny88ddXpL9ja+CCorHFSqpYVkGv1/ke1x8ksqKExaRivWcRLVccbOGzHfB12ZbmoQWUJ7yfj14pctYabrYLGkHM/7meP0o/2IR5vDSsbGnIQFvTasRObPat9+T0SSwHuatyVdgJR7n3WL2YOt5ZpKGKXQ==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by PH0PR02MB7557.namprd02.prod.outlook.com
 (2603:10b6:510:54::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 19:18:30 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 19:18:30 +0000
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
Cc: Jon Kohler <jon@nutanix.com>, Chuang Wang <nashuiliang@gmail.com>
Subject: [PATCH net-next v2 4/9] tun: correct drop statistics in tun_get_user
Date: Tue, 25 Nov 2025 13:00:31 -0700
Message-ID: <20251125200041.1565663-5-jon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: bad9a376-0781-4e36-a378-08de2c576b2d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|52116014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NWdl34Cf7lUE8dmq9cfJ8YLxcxYPjwYfJ/3GqNrPwBDXPmcvx6/B6N+Vy98A?=
 =?us-ascii?Q?OCgg+dsKpIq1rjDXfWDpadfBnVT403HPiP0KtjGjMk35AwOfreYBo0/j4i48?=
 =?us-ascii?Q?xX4J7Y5O/ejjD9GQl9EmDCUFVRCUvNIMceaYvfbbRQ6aVBckdNWAVqczi3wI?=
 =?us-ascii?Q?4ToJdQIokByMbbX0i+lfn2iktdmGbsvzk7+6oU8X4ET1h9XDprW66Sm5pHg/?=
 =?us-ascii?Q?g8kxoBY7c+QYwO6GNM35SpDQQSIRF8EcmWCLif1WkEIXgBEXrXHpK+U/+Zle?=
 =?us-ascii?Q?mQ0KW2spjFnWKIwik0HESYWS6+CxjJFw7Fs5ygpltkVO6qKsVAkJGsdeZdXS?=
 =?us-ascii?Q?Dj/y7EqRnFjRLaKT4rFr5944RTO5duHZAQBKB3MOlU4hybT8nJf17lrLlOkR?=
 =?us-ascii?Q?Md0GfUrGIOP7FDggKclT89j5YYA2HzwnrvtfSx5TAuJzDQwjKGFa5yULB/+d?=
 =?us-ascii?Q?QcwcgTV16U9sJJqg29NpVbCj02w4PP0AfXRpkF/Ypy6f7sKTJroi0pQgjA1p?=
 =?us-ascii?Q?u9mcE4H+kN1he2Aw/gPGoNzbbDmhfpJ2YkEu361k8c+1DGGt++no7BkChiJh?=
 =?us-ascii?Q?rLopHXlTrvDo13GwXzk8TK5nV6wcKdYyky+WqdBb6FVXdOgakr0CoXCypWrT?=
 =?us-ascii?Q?eBCjFcet/Aj+PUbigYKUTEIaCOYH2VwQuXKFMiUEZ3bA2aOF3C60gzNYLLD4?=
 =?us-ascii?Q?ruH3aZiDwFmV72BksVVsOZ6iIiUuM8zlwMn8Sy3SemEocGgboMOh599QEBMa?=
 =?us-ascii?Q?0hOQ+nm9/u5HAkt9//dmH7lsucMy7tKjsunIfZFuWUaQSbSW7TwxTX5CQqwF?=
 =?us-ascii?Q?tLpAbr1cn2suninnUUQFoJSixALzet+pLZKiCBbqRhizc9ShNThtZZlHpSxN?=
 =?us-ascii?Q?ZsGGohjrfcFXc4SeuP+ZmEaTpu+qeSRdfyyNfh+y8lzzddPuBPw7DpBHda/m?=
 =?us-ascii?Q?/shuBaMZMSi7sO1z3k+Ni2+4FWmQ3QX1spN2XTmvoErVp+drIbHfedhJP1sb?=
 =?us-ascii?Q?7SyP9CZRriB09e54VOQfJ6tQ3d1A9gQq1PYovA0S56vzVjX4xVQ91elgKswA?=
 =?us-ascii?Q?LD74PtXF7knj2PZy7j076iFi/3+eLbIfEi6KH5Diwki9CbzLeRU/yzxwYHx1?=
 =?us-ascii?Q?RTNmWgwVjzq+Ja2L8fJ4FhtXh5DQ+4/86Yv52xu+r84mFdZf5XSMASETAHq9?=
 =?us-ascii?Q?WdnHMEAfw3cIsRgtqni6VXLA2jBTWXystrOJ2eFRQfczkCPGX61EAQaTQIvx?=
 =?us-ascii?Q?Of/YbYfm1Liy3o+kWWA9PBD3vKxYeLYq8UtyEr3HCUedL2qdsj8CYQJ4RL6K?=
 =?us-ascii?Q?1SRnK0sxu6ZxwQa7t6Vy5YIPyW0eCmp1J4xYbQJv7eekOWjKrjHFJs8Lir6E?=
 =?us-ascii?Q?hWVoe1HhSd29waBxjDEC7ecJCJhY4sWZgSgBgCHCR5d0FUNAm6n+UMs/S9Qq?=
 =?us-ascii?Q?jAC5yR5qtnJ9zAEYqowQXm23Vo9Y1KoWbVDthIx2Vft3LWCvFtLm25TOXsQb?=
 =?us-ascii?Q?WNlp8AwFzRo88YxSHEytJUy7RmfiWRT8zJrdCUEJUeyKkR5Q69oIJ5HOGg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(52116014)(376014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mj002PVx83hVY5N/c2X0Cxfp23uHPt2yxHRwJTWLdv5OJNFDbqJInsPJ8R8i?=
 =?us-ascii?Q?YNZueHtpX4lVb3WtM5wUnLuritgGWzKouaJhqZAx6gYOlaCXiFNJ6G7yO7A2?=
 =?us-ascii?Q?R+ETIft8Np2LEyHl5Ij/y4uTikXldsypdiEDLX6LIPqDx6nrqBRWfYOW72nm?=
 =?us-ascii?Q?WZQLrVl6rt0RrDISiA8RDifpgpLQjeFG+tO8/g64dtBfyPIMdMAMyNOQ4aT1?=
 =?us-ascii?Q?12HhxX9ufVteHWepdsJ0LcyrzAz+086cdBPsokxOGVKoTdQeGBnDp0TQSMNz?=
 =?us-ascii?Q?UR/Y34jn5p/E4DnsG9WT9tctpb9LuMpEmX1PwK6cM1qIvnPgl/nn89jzqneq?=
 =?us-ascii?Q?bbk68KR0JK2DUBgR9stJBwDoWkCj5jT7qVyodtFyFzUU/WFdiV7SwHU3k9jJ?=
 =?us-ascii?Q?yHq3eeSGB2nss7uf4D4oy76xn6jdw/gL8ftMEKY4CFKa7bnJ7P06Y3YdyZrQ?=
 =?us-ascii?Q?PfXr8rWUcHclY5BnnYoNZRiwBfDtne8GlQ/MhYShKqmmAj6LEpzIiyxWnO40?=
 =?us-ascii?Q?JmM8Zw+e/S3W7vx6iw0kteBhDM9uylQYOll/cvYui59sLdlEbca77pxxF9tA?=
 =?us-ascii?Q?oHoJ5qwh2NXoXMfWuYY20yRgDRminYgymILT1uyvyrXTUHFYaJcDk24sEG9N?=
 =?us-ascii?Q?LWIWMqfXP1QQdAO+2n9omNfGZDKIRNwi6vVJAPSdGqMpkx6x/Sgamf090P20?=
 =?us-ascii?Q?JjEJuh5rK7SX2+ln+Tef8KI3Q9+chM210IKABPY6GusEhir6rgQCJYrjbNEQ?=
 =?us-ascii?Q?n3e2+h67kcdlVJXjWadXzNydmvE5N466x1la9jpLeiyJLxln18ajrRqW3aMO?=
 =?us-ascii?Q?kFLKysUiM9N8OSc8qFzoH/lYh3zSYJuB/lbssNt2x3Rm55kIheX/2ocxobdg?=
 =?us-ascii?Q?dBXgGaduYARYqkdGZqY7XKL9aVnma6qgkqbDqGhE3k7YA6ND1ToJ3CJSv4bB?=
 =?us-ascii?Q?mPuzCF2P/4K8Y4JfIxZlVplw5TMpDp68EeI8h1Rj8D585xeh0MeQY7LferT/?=
 =?us-ascii?Q?E4dPESSaW7B+BftHYg9G2EdZQuoKG0wBp2YSpeOu6HKCYMqyIBUrrIHUdFnB?=
 =?us-ascii?Q?f8HIQ9jBCwP93zFKKDOcLP2Xqe3KlkJpXgOX+5DBfmmqnQyRkiMVRbtrc24w?=
 =?us-ascii?Q?8lH+LhV1kFHRxfYvAOiaXxVCas/G52MqyJsLeCXbI11UtUpugEbU9uv8qSol?=
 =?us-ascii?Q?gi5KD0GLGANeomulq6j5rsidWpt4aMcsvzHm4d0Q0rx8xgGUYscEyJrF5JWD?=
 =?us-ascii?Q?GD2V1TxexcaLelrTWhGYgQLnHn+RekxDRShkWQG1d2j6V4W+yvYP8CC5FUS6?=
 =?us-ascii?Q?ZfOjxlvEWIlOKs3ZKKeP9rj2coSF4778MWkJcjumCxoFsiGypAuLhqmiGJlS?=
 =?us-ascii?Q?jVqN3pgu48gfB/TWEhbJ90B+1cdod4Ebeu9UfJy+B1m/pF/8AH55+Yl2wUYL?=
 =?us-ascii?Q?fo1qdz3yuL72LCEiXsarCEP1D8CML8U3xZTZleRFKNIvZX0s9y21rnijo5HR?=
 =?us-ascii?Q?qE2D0DM03qoeXkkS90tTyUSY87jdVZoRrEarbofVzkjUS6QOSmj6IvZnfITx?=
 =?us-ascii?Q?1wJEZYDfeTdB50YNXlKmLricu8CqWaU0wOlbbo48mFoV6848EnN9OpCMaWLt?=
 =?us-ascii?Q?+A=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad9a376-0781-4e36-a378-08de2c576b2d
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 19:18:30.6208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6X+HhTXIBRun14nLYbSt1hnAe41juhryWX/1f4ocHFcAOxNiikYZDNHbLMDP8mLEux3FdY8yy384sOZweNc6ACF566uZnhbgqqiqhIRLDQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7557
X-Proofpoint-GUID: U6sGLsNkcPdu8RNNPB4S3tbZ1xuJaPk2
X-Authority-Analysis: v=2.4 cv=NfzrFmD4 c=1 sm=1 tr=0 ts=69260109 cx=c_pps
 a=5czeKszRpWsvzRcawb/TzA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=64Cc0HZtAAAA:8
 a=ZoeE39jbJhzuP10RqroA:9
X-Proofpoint-ORIG-GUID: U6sGLsNkcPdu8RNNPB4S3tbZ1xuJaPk2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDE2MSBTYWx0ZWRfXyP54WLmDeLR/
 NOByDuVmzz7hEHE4UpUXVgoikhoSojFcBvo7+b8ISgmv+hktkE+r9JHjm1lL0JX1XPvyEsluH3d
 dAfZuCfM7sy3co76FWl/PcdRRBQ7E4R7rgmFBchA3hAr29CiAqwLSkdfUNkR69tCwWeu/y6fMHJ
 VvqtCZGyVJYn0lxD+B9Sdb3Eno6WlS13l927N7qZ51QS6LXVcmkprl6aG/xRE6skB3oxlytg7Fk
 rtGwdycyuYvpO1SySRgIhrYDwQdvnefaWuqAbLUwonafW2wNyfQj67troJAozw1Ri39pZIffMVP
 IBlwhCLrZ/C/oxTQ1eDFIKETuSD1SAXqSENTSmMD7zIjiZ7kaFcqms8rei9ri7D7RBGhBFBhpWS
 /iEdW2x33VHNMI1b9fQxrAQY7j5F8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

Improve on commit 4b4f052e2d89 ("net: tun: track dropped skb via
kfree_skb_reason()") and commit ab00af85d2f8 ("net: tun: rebuild error
handling in tun_get_user") by updating all potential drop sites in
tun_get_user with appropriate drop reasons.

Rework goto free_skb to goto drop, so that drop statistics will be
updated. Redirect early failures to drop_stats_only, which doesn't
need to worry about skb as it wouldn't be allocated yet.

Cc: Chuang Wang <nashuiliang@gmail.com>
Signed-off-by: Jon Kohler <jon@nutanix.com>
---
 drivers/net/tun.c | 53 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 13 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index e0f5e1fe4bd0..97f130bc5fed 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1657,6 +1657,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 		}
 		err = tun_xdp_act(tun, xdp_prog, &xdp, act);
 		if (err < 0) {
+			/* tun_xdp_act already handles drop statistics */
 			if (act == XDP_REDIRECT || act == XDP_TX)
 				put_page(alloc_frag->page);
 			goto out;
@@ -1720,12 +1721,17 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 	gso = (struct virtio_net_hdr *)&hdr;
 
 	if (!(tun->flags & IFF_NO_PI)) {
-		if (len < sizeof(pi))
-			return -EINVAL;
+		if (len < sizeof(pi)) {
+			err = -EINVAL;
+			goto drop_stats_only;
+		}
+
 		len -= sizeof(pi);
 
-		if (!copy_from_iter_full(&pi, sizeof(pi), from))
-			return -EFAULT;
+		if (!copy_from_iter_full(&pi, sizeof(pi), from)) {
+			err = -EFAULT;
+			goto drop_stats_only;
+		}
 	}
 
 	if (tun->flags & IFF_VNET_HDR) {
@@ -1734,16 +1740,20 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		features = tun_vnet_hdr_guest_features(vnet_hdr_sz);
 		hdr_len = __tun_vnet_hdr_get(vnet_hdr_sz, tun->flags,
 					     features, from, gso);
-		if (hdr_len < 0)
-			return hdr_len;
+		if (hdr_len < 0) {
+			err = hdr_len;
+			goto drop_stats_only;
+		}
 
 		len -= vnet_hdr_sz;
 	}
 
 	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP) {
 		align += NET_IP_ALIGN;
-		if (unlikely(len < ETH_HLEN || (hdr_len && hdr_len < ETH_HLEN)))
-			return -EINVAL;
+		if (unlikely(len < ETH_HLEN || (hdr_len && hdr_len < ETH_HLEN))) {
+			err = -EINVAL;
+			goto drop_stats_only;
+		}
 	}
 
 	good_linear = SKB_MAX_HEAD(align);
@@ -1769,9 +1779,18 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		 */
 		skb = tun_build_skb(tun, tfile, from, gso, len, &skb_xdp);
 		err = PTR_ERR_OR_ZERO(skb);
-		if (err)
+		if (err) {
+			drop_reason = err == -ENOMEM ?
+				SKB_DROP_REASON_NOMEM :
+				SKB_DROP_REASON_SKB_UCOPY_FAULT;
 			goto drop;
+		}
 		if (!skb)
+			/* tun_build_skb can return null with no err ptr
+			 * from XDP paths, return total_len and always
+			 * appear successful to caller, as drop statistics
+			 * are already handled.
+			 */
 			return total_len;
 	} else {
 		if (!zerocopy) {
@@ -1796,8 +1815,10 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		}
 
 		err = PTR_ERR_OR_ZERO(skb);
-		if (err)
+		if (err) {
+			drop_reason = SKB_DROP_REASON_NOMEM;
 			goto drop;
+		}
 
 		if (zerocopy)
 			err = zerocopy_sg_from_iter(skb, from);
@@ -1814,7 +1835,8 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
 		atomic_long_inc(&tun->rx_frame_errors);
 		err = -EINVAL;
-		goto free_skb;
+		drop_reason = SKB_DROP_REASON_DEV_HDR;
+		goto drop;
 	}
 
 	switch (tun->flags & TUN_TYPE_MASK) {
@@ -1831,6 +1853,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 				break;
 			default:
 				err = -EINVAL;
+				drop_reason = SKB_DROP_REASON_INVALID_PROTO;
 				goto drop;
 			}
 		}
@@ -1938,7 +1961,8 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 			spin_unlock_bh(&queue->lock);
 			rcu_read_unlock();
 			err = -EBUSY;
-			goto free_skb;
+			drop_reason = SKB_DROP_REASON_DEV_READY;
+			goto drop;
 		}
 
 		__skb_queue_tail(queue, skb);
@@ -1969,7 +1993,6 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 	if (err != -EAGAIN)
 		dev_core_stats_rx_dropped_inc(tun->dev);
 
-free_skb:
 	if (!IS_ERR_OR_NULL(skb))
 		kfree_skb_reason(skb, drop_reason);
 
@@ -1980,6 +2003,10 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 	}
 
 	return err ?: total_len;
+
+drop_stats_only:
+	dev_core_stats_rx_dropped_inc(tun->dev);
+	return err;
 }
 
 static ssize_t tun_chr_write_iter(struct kiocb *iocb, struct iov_iter *from)
-- 
2.43.0


