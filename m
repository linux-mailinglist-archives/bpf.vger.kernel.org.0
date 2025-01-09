Return-Path: <bpf+bounces-48376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 528B3A0714C
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 10:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 041471883954
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 09:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA16221518B;
	Thu,  9 Jan 2025 09:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="haYnw3Uc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KGvrk327"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B921A216384
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 09:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736414252; cv=fail; b=RIEP/vqCWb3iD2Q6uOyftHXz8iptxaJHGShzYS0X93ziKj8fpyaPcZybNWVuh5XUOBUcqm/AxG0KMl27OhMc+wjMDtHzzryj5xMjOXyylTZzq9uye16hBb6AAoRWMN/x/6tfGkNiX4jxCD6UO94t3ryc4j1rhRFzNTMSCGrUPFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736414252; c=relaxed/simple;
	bh=i+pAPT8Txpo3q00qnI4QacCEIglOiFUB/HSWshYjm/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ePsLqz6+pdh8w+7MRZWXAAfcgfDa5zz67wE3LL1MhWov32D3yPtTEZoId1yeYhXQfDEYE8aPAiyPeE0J82cC068LLHymnUxZO67XnLPB8P4OnbHRWOXth/1ywbeWZ+Agqc9k6ngtKm+ne7aLWZtNQbI/jqdMWPjX9P4tDP+MCyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=haYnw3Uc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KGvrk327; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5094ftHi020359;
	Thu, 9 Jan 2025 09:17:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	corp-2023-11-20; bh=aFj4uOsiPdmhch7g/nUVHnwTqhzTy4oiNq6C800+SaM=; b=
	haYnw3UcW3yPsr9zbq3tFSwl1pqy2piec0f8prfb5nH4fUvEb2y3usTNIJZco3OA
	FyxVrRCDnh2QOiZyc51ea6OhE61C7Idvmt4oHWMU4lFUXKzWovrcmFWlOH6yZ3PQ
	cd8l3bYMJcK4rEfrgy7h3iPA0FRm41AgGLoKFyeuhQQAmXuLn0qjzP/ev1kNbUCa
	KCtSKCHY9s+Xn8DHspJnSfjf53MjMVHqCbqmSr7jy9+VzTHkDE3Nmj/Hx5kgj2a8
	+2FVc8xQRWUce6AOajM7/q9nWa6yU3iK8dtjWZoWYzgPzGJu6kEKTPPSllm+/UEg
	jf4rhQ5V8SepUgDj6mLQ+w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xuk08t7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Jan 2025 09:17:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50993OCC020207;
	Thu, 9 Jan 2025 09:17:20 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xueh75jt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Jan 2025 09:17:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pi7nZGrx0P9Es5C1oHb9x2XR/0eQnVXe4IUvk7YA6Q+84sgyQOrB20sJzF4TMFQqeSNTEvCofpssTD66uKMC7DN84xbRg2yV2Nvw8NQ+LCiOo2PWSYIWVpVBK9a4gadIocoi6R6keulsUe3KlqLTN6u4FkTXjfbraBHDrJ0aiB8/VWREnrcVbo7+FiNpl5YUZvaLlnTpdEDcYI4+MKYdNQs4GOUnwsJjI9DwgII43+GmB9FOJUXN2gWhTVG1cmZml7eHUvdR4om+hS+AjwuJvSIWgwG2/529owUq59VepL3dEEqdobKmSYlPmSLPLtjUWukaCZVR/HWO2aONDWmSsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFj4uOsiPdmhch7g/nUVHnwTqhzTy4oiNq6C800+SaM=;
 b=vwym7qTchS4ezEePGerLZLaaytLIZ4M/0HahyxTYUBk6qs/uY6xs3pb2Fzk0LPmCgHwY/Ee9jSK+d6kW7XuBMf1y7PT3K/N6J/I6wfb8ALI7cVRPzhGDZTEwuGIlapNjHYQ8uyKPLQWd9iQOBFgfBqLlyh1PVbKPbJ8uUZXQK6Tq3yetQWTF+kBqpXuEoxGHUTSu28vxc39nHPCNdSC84V3Oii5j8vjTyss6vQKFW3LduyEftiUNmLu48+sXBX1wL6ifflo0kGbUmNIJfa00MqN4Vh3+N+OjXPu+MwI1RrtixyxsaWZaW4oDMArEtArjbu4dWO8nNBEoIGPxbIQFSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFj4uOsiPdmhch7g/nUVHnwTqhzTy4oiNq6C800+SaM=;
 b=KGvrk327pG2XedIk3MiYpBC7NlvedF6h1zz3HyRooQjNyFdz3ElDyGQeLOfPNaV3HGy8Yk1usZFqfBpj1qMMzAjs3hps7N1jHVBIac1h1yg+oqdUDYVzBFugkBNWdz0ABxzoAo7jLv3mSalGHxt3K1s0vMKP4C+V7CNHPMIkB/k=
Received: from LV8PR10MB7822.namprd10.prod.outlook.com (2603:10b6:408:1e8::6)
 by PH0PR10MB6434.namprd10.prod.outlook.com (2603:10b6:510:21c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 09:17:18 +0000
Received: from LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e]) by LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e%4]) with mapi id 15.20.8335.010; Thu, 9 Jan 2025
 09:17:18 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: lsf-pc@lists.linux-foundation.org
Cc: bpf@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] Compiled BPF
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Thu, 09 Jan 2025 10:17:15 +0100
Message-ID: <87y0zkxs6c.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR07CA0020.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::33) To LV8PR10MB7822.namprd10.prod.outlook.com
 (2603:10b6:408:1e8::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7822:EE_|PH0PR10MB6434:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f3e8f49-451c-46fd-d9c0-08dd308e6a18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mvnw9t/LAId8K3sYZiI/B6GTkG6Uv0nuPTl3gZGG3NyPk2y+Kr/Jo/ZovOWV?=
 =?us-ascii?Q?GJOUwyye1ofJJRpNUmYH5Tsxpb34/HGDzhGrsnX7kPVfmVGGkio3J6Ib20gj?=
 =?us-ascii?Q?BHykbZ/9782/faVbA97LukkStoa7O6QXCznjw/EuThR2pfccb3taH/A7ATg1?=
 =?us-ascii?Q?jXWP1c33GVIz1WdlfX+eGWuJEOupL4u2EbDH2P4XPCKJh63oOEzcBvfU5EfV?=
 =?us-ascii?Q?kkNTX32PgYqVgrcawmnNgeE4laqny3vp06aJfvmGCghx9zqCD8ZAFdt+bl8s?=
 =?us-ascii?Q?Tu5e4ShVqauew3fJ4lX6lC3dZokmr/4u1KLNTmPbon4mxbHr43clDwnTl+9p?=
 =?us-ascii?Q?n4aH0FompXgJRKjABUo4brOPsmUglSCEB78zYWGly/7IPYwvih5+0PFqwHB8?=
 =?us-ascii?Q?iPaLE+WKYvXNvD0HhWJG3WMYr/zrI3rGOF2srcxImSUjJCafniUXTHs7+7Xz?=
 =?us-ascii?Q?o9blqoHJVSC5fnZ/TxFRHaD2DT4flASRKlBai9ojhOopPyosnnk3QyD+uNUg?=
 =?us-ascii?Q?uzW2PoWCUq8FCjX6zPopSqH19GFtygKqw7q7GEDHwEij067ojAFxFXLIs0Ho?=
 =?us-ascii?Q?aXsr21w3Qs5WLkJ2gnV01olTG5kWosKvNjuRqkyZUKLDhswbXB5wT99r1BTj?=
 =?us-ascii?Q?Z0imgEHSyGve8EZPCEJ9CgoobiHKu/sIiq+QHeGl6Zc+bIeMozvrxDj5Cc0Y?=
 =?us-ascii?Q?Z/7IVeKSueiyxvnOuwpv6hMv2ZxhCqXi/EuIKhd1c8ipmZ8Fgjs59Hw2cxB6?=
 =?us-ascii?Q?yGvktTjusmIk3m0W5uYkKnN/uzAWhNm4zgdXF/kemGz8fdM6Y/ZOYcWLKlrY?=
 =?us-ascii?Q?NQqhunxNpJLs6ao49V4+fnDATVexHLeyix9QFs7T6tmpnsJtV8zFMR2Kk2hs?=
 =?us-ascii?Q?IBHbaEBcJVeYDSZDOCnYJkBXPb9+FAXzDDICNunmJhvD2hbaMTiFpIGAAEDN?=
 =?us-ascii?Q?Tq/4mEA9HH7gtrS6ZODfmDTg4OrUTtomwX/YRijywXqbdsCu7H1jN7hjXnYG?=
 =?us-ascii?Q?Oj9sIANMQBTX72ES/ctxKfFrKKMAXTTi35p+9qlOvHaYTApYuBdqGQpqm2I+?=
 =?us-ascii?Q?gqPa95tkZpjEM/+jzYNCnFhlq9roi1B0QcADsWJUDmRaBDNVao9iyibBMfBv?=
 =?us-ascii?Q?hqoW2xE0ySKeB70uwfdPiPJwyqWLd3dZLOfyOFhYkDjeztGdiL403+ydmQ6i?=
 =?us-ascii?Q?5gTkZTIsfSB3CDMZFy6LvBeVlakR2E8GpoY/W0ob9K5M1ga87SCkMXe3YtaW?=
 =?us-ascii?Q?FtMA0e7nQ5eRkeEiGsDbZFg4lAn9sH7DeoyrNmhwZxFtgJ9Q8XnhgLK0iYgP?=
 =?us-ascii?Q?A4G2s7rnzEooWKglGNsrHZ+SJ3XXNZC5lgapyN+xxGUPNie+u955a7V2h+Zm?=
 =?us-ascii?Q?tYQD35yF3WxpiTzTh/to3MiQm6/G?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7822.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aDYHh7GlJylnpAK275PM+66vSkcXYag7bFOxceLmK1UEJ+RZiXBul2vZ9rNi?=
 =?us-ascii?Q?HqU3m8UBaaqOZbNDXr8diMGs9yPkr8wfQv7xQDI0S68wNOFBwgmuIw5/+CKe?=
 =?us-ascii?Q?1tppuCfMsD0P+l5qltFoNRHMyZJ8WzfW2WcFAjdxbpnGGjsNFCGQvPv/PcUQ?=
 =?us-ascii?Q?chiOsQhRUO1JH9iU74iAlI1EzgO6MZz6ErTnojzTdqGAHeGugJsVbSAHO2vs?=
 =?us-ascii?Q?U5A1eccdWnOwhuArYg0Q/EACRTO7Wykz1+NS7v31aemfkGIK35XoT90+3+MV?=
 =?us-ascii?Q?wvVVZ3yFy2TfV+xpXKzrdlKLKIptXC2MbYh+vEzAL/L+j+6EOJIwI0HOqIw8?=
 =?us-ascii?Q?UvQV/LsHc+4ObzLBpka6jYqODbSgKPmMMTweePihmyIEh5MrvlVHjyIfGoJf?=
 =?us-ascii?Q?iNx5omDDFW4Ah3xphR7nppfEECwzav9nfYmktWSU8C+o6GPSy85EuLQPboXC?=
 =?us-ascii?Q?HwmT7lQ/TZRE76TuSYPlhu8DVke9BP8yOvpw1OWTmFDOlYO7Pv5eJA73Ednb?=
 =?us-ascii?Q?8bGzlxIkGDURfvD5JA/iLRTsI1nwemqeOHLWEAHC7GqAT3kQzrQGf0bTGtv4?=
 =?us-ascii?Q?70XXkBFnOZzgfcCoO+mdXvzT3ychSeAMJoVYKNFHJkv0poDa0HiMIETK7vA1?=
 =?us-ascii?Q?ooG9YeZ+QlCHXpQx/dmK65mtHW8dK26xK78hj3AWTB0KhLnL8f4sBuco2fFq?=
 =?us-ascii?Q?/4IHUp3TgZQeKCfa5dJBgSGDwnApiESdmYPaMG1oT31kwxdIBiawORs1NpPW?=
 =?us-ascii?Q?5HZuTV823wBiv6UzMjzhNDwCDyI8oou8iA+mYdFpG8iTbt+0NO8+PanhfOQY?=
 =?us-ascii?Q?30UsUyWTU0LDJPw/OKv3hRIrUs8XJVCVz/i635dYrj4DgDksh+5zncndIKTX?=
 =?us-ascii?Q?JuLP+O4B8MmsuuMvLGdRMqGJuTt75N1be2kzumKPi8wg64KRRuh/fBqFeISB?=
 =?us-ascii?Q?2pSiKrlm4e3KC23KuHW2j0mNkOJuigROxBziKiVMdJgkSjTfrU6UO+lwvxPT?=
 =?us-ascii?Q?V5BEU5BPVYFRDPvypbAciMrWrgM+NTZ09S4aLSxL55NDV6xIIKz+l+PWU9rY?=
 =?us-ascii?Q?ly+7XfHEvN/5DerUgCpfePuYWvQCfhmtFvITWLHeLLG9WuAXp7Vk+jj2jp3n?=
 =?us-ascii?Q?QWcIcBhi75fX4QwOHa1lipkkC5X25j2Ug9CLOYTDp8JENR1Om3F9Yea3hQZb?=
 =?us-ascii?Q?AendUN7PYtuoewf8BT+wGR+eSpCuZ+fu4mRlcGeN30oKXokWT6y8Xk1iX4Gm?=
 =?us-ascii?Q?Wj/jnh2UG9WOxdCUlIvzMbDX/Ljzqc9BYR3Jrjvp/zntjQsOTGB0La6OzxsX?=
 =?us-ascii?Q?M6T3FhuzMZHGmJVf6qf9K1T+bLbRL3uOyglv4kt3EdYrSRYdcnf9kMtvdaLV?=
 =?us-ascii?Q?LtGbi9l9hHIQbhqHkjHt9VTaN177+3PU9xfSnMcqme/FMB86zh4k9jTfeo76?=
 =?us-ascii?Q?m48E8TYaSIFk/p6HaqMdiQtfeLeF1obquf9xTcJc6tUYekWLXz8Gs6Fn9ydr?=
 =?us-ascii?Q?BTeyXhqP3/90ee3RntJ1dp6Es/a/doE4pCx0MqkBcMWnPBI++M7qekbQd0pv?=
 =?us-ascii?Q?U9SfpLiy8HcN3WGYfHnwHB+kcRopgltL1V/vvEPJCubfGGRIrzg1R0Iom/gI?=
 =?us-ascii?Q?tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9PfPGOl0z4/eRupBhJPsQks6i8J46JfUvzX1mevkjc4MdADleWq4u2iIOIAa2usBonIgXO4CPWsyEWQtaOsU9hJCOtyeW2DXN4ORNIoTL7HoJgaYgNZVz4XLIpLK304P4Q0IbhT0aimPIXyRK981P5Tu6NvrYbAbPSMymoKiLty8lHD/v99/KQY/keWJOzN88jTz4xnXYmPV/RePFg8fc13OnZvVwS86cPBK0ij+8W4QcV5BBNCFE2ZviOMwbSba5ZDtV7tvdx74KZHLBWxXCXq2fg9dq7ykrdczEfhjoCG2pfE+uJJ7gFaCvgrPUf9WixGAZRCwfUvwyGxhG9w0dPJPdmG/B4Bgs5sWCx1Ji0rUahkN1vIez1/aAAqJcAMfVEv6nOITM2LiUY8+1ZxToSXp6qyv861p+kWrWChR8UAmwv6OQCSQUCZWW9cYQxNtbcaha7pr+YnyG6FxHS13s9z90GidUz/RKBwQ52824FhHtNabc/GcmezTRUcuKKPN46SoW+dtrJvVIgc2l0hfi2SxMXaEbXdjTshR7MxVbe7Kf+DBpyLaRPZW22LhJbASdnajwXzvh8biGc4utCAf0Wci2yU8jYcxuv/UGLCsgXI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f3e8f49-451c-46fd-d9c0-08dd308e6a18
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7822.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 09:17:18.1997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R09yE8lrMaWBKr1USUCQkQkOACGusFzWVHE9U7e1bAMUoqzgv8F3S1H7Bs11hnVzeDwInaWtOA57io1dr8V+hJbIBxE+E/62EvEdW8otZrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6434
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-09_03,2025-01-09_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 mlxlogscore=905 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501090075
X-Proofpoint-ORIG-GUID: 36usqsJ-EGphF4GX8PD_6NwaKfjK1YbL
X-Proofpoint-GUID: 36usqsJ-EGphF4GX8PD_6NwaKfjK1YbL


[Resending because I don't think the message reached bpf@vger]

Hello.

I would like to propose an activity for the BPF track at LSFMMBPF.

As in previous editions, the purpose of the activity is to do a quick
recap of the current BPF support in both GCC and clang/LLVM and where we
stand, to discuss and clarify any particular issue that may be relevant
to either compiler, and to collect and address comments, requirements
and other feedback from the kernel hackers present.

On the GCC BPF side we would like to pay special attention to the topic
of divergences, as we are nowadays being bugged not so much by missing
features anymore, as it used to be, but by divergences in the support of
certain features between GCC and clang.  Some of these divergences are
trivial to fix just by following clang's behavior as they are found, but
others require discussion and agreement.  Also, we would like to expand
a bit the scope of the discussion to cover a few topics related to the
"environment" where the compiled BPF programs are built.  Examples of
the later are external linking and the inclusion of host standard
headers by BPF programs.

Thanks!

