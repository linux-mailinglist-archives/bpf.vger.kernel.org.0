Return-Path: <bpf+bounces-40125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B02697D26F
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 10:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8FCA1F22088
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 08:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA49377102;
	Fri, 20 Sep 2024 08:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L7W21la6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B/i9nONs"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE66C7580C;
	Fri, 20 Sep 2024 08:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820374; cv=fail; b=tvTJCokqi/2xowYu5miejKjXcflwYY4LHInWDNc3W9aTuVcSd92xR+oKmllt9Nl4R3VGzXaPy4GeFUuoMagBQ0qMqOCjV3IMmpZhKeFjDz8h2XhgcTewblQxb1mVLigfjYUYZDkq/BIQ0fn45RAFNiVGJgl38WXM+z7INuFiAkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820374; c=relaxed/simple;
	bh=+hVI9CCNXTLrdP/Wfj6K9tBJjE+b70DlyWPy6Tj2jlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dvian/n5nqKF3VOhVQGndKhYLugy/FzhGtrji9v8tzEmmFsRK0MKV4p0lN98cEQ4FBdYkjeDN2NU+GNoiM1Xg/rLZI4DlJ60ZPmVJqr9D2rwiMHXbOyZun6UAa3b7HpA1SmC9VGKyurtRcHa/B0GocoPi3yFWMM7Mescv5S6lLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L7W21la6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B/i9nONs; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48K7tud9028367;
	Fri, 20 Sep 2024 08:19:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=B8N+iE2ZNu8qW+odU4f7ob/QPwJTZn4AOgstjjH4hG8=; b=
	L7W21la6zKGc6KOMpNj0JEeY/ZCTxqAw1skBsmDhGxTVuqehT/fARFaYu5pMHNmk
	waNFVREDPPd954879Ebnh7L5Dm2Zp8D2mllUEQmNkpSX1hW5Bvre0pAUxWq4aRV1
	59qWxmcySIXs4c6YxB/DRWSKlDoDO8bdCSRma6eeOBrNLgbipRwfEIMjshlRMpsO
	lyxqIFI7UTTPm+hkYuMdaP0idp8wuTrwOfKRu9hPuet/R5nRIGziXL/BFqk2KR0x
	LMxQcbtGlzIYlUxphC/C8m+f+eqVlZlLoUsDfOPr6dzKEDkYJ+udmkBbBAUfQ4lc
	BsScKqYaJ+vTXB67+d6sAQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3rk5y0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 08:19:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48K6Buck010334;
	Fri, 20 Sep 2024 08:19:26 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nybatc4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 08:19:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAvnWEKwP0Q6VD/SAcgKY7r82FvIPpPFWWb+Powa4t4Nua2YpzQ4CP41ewbJ4hl+7t6hV0ffRHYaNViELhuTfhoWpBr6waGmxzWDzqPoTTM6OZ37KwxcGYTxB+Dqyl4Sk/CU2QCe1h8cVjmRppDAo4UMQCdz7zSxbcS0Y4Vb/g2tkq8W+JTQfr20qW6iuccICnRXnKcLoQLKLqGa5WAd0rBsQPykM72PGi8tPmazL+BRTtNaBIukPXCASwvz58TSDpUmGWs2/74z6Z0fZSYB5eun8UqWF20zyduVFFOlg+bGLOp4hHJ8jl08quIYBUcQMSZ2bFjY9wPN/h2yYuegaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8N+iE2ZNu8qW+odU4f7ob/QPwJTZn4AOgstjjH4hG8=;
 b=rVEtbW/YZkY2gCKEloQp2/xI7dl5AHzCSkPPvhdK1l8PDS/C2XZreAluuHyknSizRw11abmVWcE7s/azsPnFhnv2f07AVTtIsivxLlI5KRKDrs+K0d+R+NWeloDVqKBCd9cJk/2/KqeykGTkSgcAE84BjXHougyCLMOW15EKup3z6G3ugPtq0JJbevTr3WaJ9Vefg9GZYevyYqmWyd4g5TD8l0RuJSX8h5ec1k1ea27e6Jt+GMlx9OYds778ojGo3uc/NT4UiIkzApZ3Ck1z10Dy4p2fSz/8WUjaCD+mR0QD07g7QlzbGCPfR3A6JnOTptq40v4LE7PNHRLyJim8PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8N+iE2ZNu8qW+odU4f7ob/QPwJTZn4AOgstjjH4hG8=;
 b=B/i9nONsyRYinv1kVSh6R8KMBmzyBzQFyaptEfua/g4HAc23kqdJ2VoUaRKYNXDKQePpv+LD6Jyp6B9RH2g2phCkgEVP+sn+7m27i0ytg62k0fioBf7Bu/VSoSWyZ8HbWV8y0d0L/Gfwj48pRgvwY9Y+GUf4/NGR1pM6GbSE7AA=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by DM4PR10MB6037.namprd10.prod.outlook.com (2603:10b6:8:bb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.9; Fri, 20 Sep 2024 08:19:23 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.8005.006; Fri, 20 Sep 2024
 08:19:23 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
        linux-debuggers@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves v2 4/4] btf_encoder: add global_var feature to encode globals
Date: Fri, 20 Sep 2024 01:19:01 -0700
Message-ID: <20240920081903.13473-5-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240920081903.13473-1-stephen.s.brennan@oracle.com>
References: <20240920081903.13473-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0089.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::30) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|DM4PR10MB6037:EE_
X-MS-Office365-Filtering-Correlation-Id: cc196f4d-c24b-46db-3839-08dcd94cef0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8cL8whS0gCUSNowKcOBy/OOTxANC/G4o5I98Waz/b8JvZSNybf/PpiGGQNPb?=
 =?us-ascii?Q?Z5AsfZw0WvHMBxxMmJUxGM+qWRo9xMH2ujqHjzlsIn4NKd0Wpird05dhVkBM?=
 =?us-ascii?Q?m1Nyp//T0rZjXchBv9uxTHFMIivBHIHzvXsmMDkgssegJAcqSENQMqje5z1+?=
 =?us-ascii?Q?tu6uZdrZvh6iK6djdAT3b/GijOiqBpAvflBR80u79zEiB8C9/svyxhwJr13A?=
 =?us-ascii?Q?92iewPndG6ZmY446zTHV/AqHnQCKNGFK7ab51HljDGmO2UR9Rb2AivTkmWSg?=
 =?us-ascii?Q?iwcxvODJWp3CCkUuwPjd6TkNRvXX9AVpsDpttsugdPj+4wNydnu20yIrCwiZ?=
 =?us-ascii?Q?o4K06YMsUlrCGj3XHQUrOlrJnMQC1WOK0HIdayqiS5/5h+ECvpFd9AbM6HBS?=
 =?us-ascii?Q?eDj/p1JB4v3baq6pTPiP9EPV9F2JTwSU9u1wG5LhNw8UnMkCC7HplMQeuMtc?=
 =?us-ascii?Q?jjL/1TR3Bq7Iw9l7IsoQRPYmvtlvafNBZzr6dK2Bj8MVp8jNnTnIZshS2bQD?=
 =?us-ascii?Q?CIu32fOANdWuWYvsfPjQVROHoJdgbh5VYbU8ZDBoFgUrouG07GM4suz6YXmm?=
 =?us-ascii?Q?aeMTGR2tvfy0xtxsH3vMOn1+o8JRP/8M/X5/NTadGlHt36lZT4xV/P2oxNJq?=
 =?us-ascii?Q?OkI6/CipCwS/9S+qivGV4K3MG1LobDtHC3XltK8qfw8NNaTgcPfXR2qaMxs8?=
 =?us-ascii?Q?B8ohvojrivHnfwUFhEYxaw95/gEIO+xZX/Pd5GsV3N+saiCIaYcj2KlhK0dC?=
 =?us-ascii?Q?naUf9xLVICSmKjQCdP2CgnC52yMGuDvvFqo8ubQIzyIxrV/JHDWPniJQpeLs?=
 =?us-ascii?Q?fkXcAAGKRxD9ezC0roM5965JBCtClIpd8qBpqB+uJ1NOLj620TcqbssGNAXy?=
 =?us-ascii?Q?1JGTG1Bl34SP86I1Vj/NfhSmrwhmDXJxumrY1qntfDJm3zAk0S1Fg/UZoRSH?=
 =?us-ascii?Q?k0jpP50fdEu2TrIlq82oLvhWUKkwpWRiuNSdJim0eH3+odMIDRKhODvW6VIP?=
 =?us-ascii?Q?HyAtn7ZJ71P45ML1QwU2aAYhuf/0XqPxdzPIUMfuPAC/ojHUFF+vnu31zxJh?=
 =?us-ascii?Q?4HlwsQG0YzIdp899lqNQ/Q5r6I74KfrMWHUFDuzH1YrNK/sxzR2ymoUw5kVH?=
 =?us-ascii?Q?l74D3BkYCRE6AxWLm44RWV5CL2z+Ua1F1H6sA4oC0ycDnu0W17d30CJH8OZR?=
 =?us-ascii?Q?spWxTqXmpQKDQx1l/HSUg2kPU9ocLurz1PufMy5jzHiCu6o85TfxC5hc+pY6?=
 =?us-ascii?Q?XhNY7UA9zCAnPHWjBCVs51bsJ35y2UbGbqi2jSXUdA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vXOxk6JxnfyyvklosQBZPztcuG7vja2mE90rMuloOL72t6u9EdSOkpUQtqYO?=
 =?us-ascii?Q?txDRaCVWhDICz+0OPtyIK9+oUVzEgzsf4IcHKx1buyF4c6ajjiUmMA9+OhhJ?=
 =?us-ascii?Q?v2B/nz6pgB0SWmC1BYL91uzPn2e4MOD28GlKP3axSu3SIQGcqeeIardbFMLJ?=
 =?us-ascii?Q?4ZrgBYZvttxnNz8iGczbFMEhTfbzsbGGjkGyllE64CCXrkpZVRvy4JHog/Hk?=
 =?us-ascii?Q?0yfz3AFLmi9OfDAKflKKryZDaTpX3kotZZWpwAWQDSV77Pk6eGl+hmCOWcnD?=
 =?us-ascii?Q?DDZCi+P46OpVAEPQgpJF/8L/gjzXETvctkK9YrB/oUCigB0AnTX/rSzov7ME?=
 =?us-ascii?Q?L84kGiDC5tme3Sybc/vGJEvOLSaN7eUrzHhPoZpKWk4rZMevj8M3fk9nnq1V?=
 =?us-ascii?Q?lZmM3b8PXxNAC8fV1cU/7W5Kn2I+foL4mlFOO9/LyJNl+ZfOY8cRpE1p6JtI?=
 =?us-ascii?Q?QGljtAH1srCJelYe8/qaMju20wan+XyE9Lze1SFR/4KtGZSZKnqyqYWHgH3Y?=
 =?us-ascii?Q?Q71+q7dgH+NS0ybCrkXrQg4FBeApAf8vR6NboC6TCH1BdHTOohd8HJa3lYYY?=
 =?us-ascii?Q?es0/y8rqgbyo3f3/64nyuXH0jkOwh7QRy3Yg1QyEkXdp9FxS+c1VtXYWZD5K?=
 =?us-ascii?Q?ttUPRHZZTgXLIDZIKR2/q6T22JMRTONnyA/qhpUQ3B/isSh8XZsjK0x1xueg?=
 =?us-ascii?Q?TzU0NwVLVdlynHels67gl+2nLUewPS7iWJndDxT8Ij/ZQiQV76vs2KO8D91N?=
 =?us-ascii?Q?SaacoBGSOegj7ozH7lwAURWVs7u7ayPso2mqhQiVVhO6zDSMuUdWMavIV1+T?=
 =?us-ascii?Q?O4Zao4NxX35Yr2e64aEzVm1P27JukIq9P0t4DyP335drEb0CnwoKfLaHERKi?=
 =?us-ascii?Q?PS8HstFbg6Ozje18L4PVOMZSpayfgGEjdqMeUNviF7RjGLz22hEqBy5207Gg?=
 =?us-ascii?Q?LxtnsjWnoBQa7DndbgIC2QTGfyU3UCK3HURv7bFyCDyVzflwQVsClFnYyX3d?=
 =?us-ascii?Q?gg1OWsBER+CxkiRzRLWfm9lOCfgeGA61CE/1+YJ+i+PIspeIYXKmKsQkay08?=
 =?us-ascii?Q?VrWzM32a8/uywhvj8PpVnHE4BALyyPP6bSqi5JMlQNljvBNfhWNacVEqJglj?=
 =?us-ascii?Q?I5b4USwlQwiuWUoqSN/x4UJhIq3SIwl+Sft9I5WXICXP4IyZPFZHfeSm3sr5?=
 =?us-ascii?Q?OZhg/HWX5oVh2ZzRwNNzIXIjFPYNfiSwMzGc85jBqyTNqyS9e2IZiFgjFCWp?=
 =?us-ascii?Q?gNZHJuoW4gmukslhnflfFyii4Z3FAiIXgB5++vQSO5jXJ9rRFJetk75EaBJ+?=
 =?us-ascii?Q?/e6eT70VlfwIohq694CrUVGud4Rl3c10rWC+pSV18Kik31E0yw0kIQyVUHJV?=
 =?us-ascii?Q?nveGaEYJfgNj+BTXgHDhWgJKaP2RGhY+HIAzw5/vPNM/rXi7r64To3H0N41Y?=
 =?us-ascii?Q?C8VU3eWPA1yUdhMjhXT44nuZ+R0ZfYIYD0Ri7g30fZehHQWw9bOG1L5wMXgc?=
 =?us-ascii?Q?Gjf3dfaBFTgSd0oOkWo5CyeZS2X+uenXu9N/vDJk+tXQy61F8jnFw42ciW19?=
 =?us-ascii?Q?QfsrA6C2u1SFZMkYybHkwkamD06WLFzwNpYgmVatbNz4CKYOJZfQsB0eAcCp?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	z+9Z2i3s+kAWsNl+RUyLoVsTiPQemcvlv5ws/h2UUYyJmrjpRKLbhnemdemmy8kyjB+W1eNSFAKqKDHteW5Oq7PNh/qOjkrQTg7aGWrDQVigd1VeOYe0/QwrsTpoYXeqDlaCu1zve9ZKUkf+vNudAaPaBRzRNGBCREiSIIXboMcnofQZRKLotUMbiWUhHu9HwUY6k43y3asNzNH+rwYOgDEW9pgWdXZz00DqK20JzZ1FEA6Xl3Yw8ldZaI6blv54o3R3zQpesVowqIEpdhQrUAwjb3LN/xNdnUwheG+3IAHkMdM9Kgg1yaDY3+jhnIkcas+xAxYEVMB4tUr6WgC2ncD8SLYMptw7RS7TbJfMn2oEqR5u+3j9Vpw/FaOSJh3nZupH1V/6oYBCcPACtjLjoTw28KlaXC999B+jTb4MZjlecs1fyuRe5JedKPh4AndXWBkYGGlbL32QX10vS6iGt95bXbfj6n54FnNFYiRzn1IyCnP9fyd9jARa+g28pd4NFNpncd4EvLK6+MZjhOSgK9Vj+V/xsd+OAWu4K1xnkaSJxeOFfBYxTAXec7ajghxTbn4UM57kVTDbbYGjzIHEY8ZCP/Qmc4USHdU3hIqxfQw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc196f4d-c24b-46db-3839-08dcd94cef0b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 08:19:23.3543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qKiFT0p5Ut9uvqwCQHcI76ozMG4dxUBFKzYcuj09utn/bn8q+t1hbsP4SyOXm4GPI++l2nDDyJfWUnJ9iq6elYMSOouhugwCutK+4RGRihI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6037
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-20_03,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409200058
X-Proofpoint-ORIG-GUID: rj5C-ZUykS9adhi4OO28wicRtNPL4A8x
X-Proofpoint-GUID: rj5C-ZUykS9adhi4OO28wicRtNPL4A8x

Currently the "var" feature only encodes percpu variables. Add the
ability to encode all global variables.

This also drops the use of the symbol table to find variable names and
compare them against DWARF names. We simply rely on the DWARF
information to give us all the variables.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Tested-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_encoder.c      | 347 +++++++++++++++++++++------------------------
 btf_encoder.h      |   8 ++
 dwarves.h          |   1 +
 man-pages/pahole.1 |   8 +-
 pahole.c           |  11 +-
 5 files changed, 183 insertions(+), 192 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 97d35e0..d3a66a0 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -65,16 +65,13 @@ struct elf_function {
 	struct btf_encoder_state state;
 };
 
-struct var_info {
-	uint64_t    addr;
-	const char *name;
-	uint32_t    sz;
-};
-
 struct elf_secinfo {
 	uint64_t    addr;
 	const char *name;
 	uint64_t    sz;
+	bool        include;
+	uint32_t    type;
+	struct gobuffer secinfo;
 };
 
 /*
@@ -84,31 +81,24 @@ struct btf_encoder {
 	struct list_head  node;
 	struct btf        *btf;
 	struct cu         *cu;
-	struct gobuffer   percpu_secinfo;
 	const char	  *source_filename;
 	const char	  *filename;
 	struct elf_symtab *symtab;
 	uint32_t	  type_id_off;
 	bool		  has_index_type,
 			  need_index_type,
-			  skip_encoding_vars,
 			  raw_output,
 			  verbose,
 			  force,
 			  gen_floats,
 			  skip_encoding_decl_tag,
 			  tag_kfuncs,
-			  is_rel,
 			  gen_distilled_base;
 	uint32_t	  array_index_id;
 	struct elf_secinfo *secinfo;
 	size_t             seccnt;
-	struct {
-		struct var_info *vars;
-		int		var_cnt;
-		int		allocated;
-		uint32_t	shndx;
-	} percpu;
+	int                encode_vars;
+	uint32_t           percpu_shndx;
 	struct {
 		struct elf_function *entries;
 		int		    allocated;
@@ -735,46 +725,56 @@ static int32_t btf_encoder__add_var(struct btf_encoder *encoder, uint32_t type,
 	return id;
 }
 
-static int32_t btf_encoder__add_var_secinfo(struct btf_encoder *encoder, uint32_t type,
-				     uint32_t offset, uint32_t size)
+static int32_t btf_encoder__add_var_secinfo(struct btf_encoder *encoder, int shndx,
+					    uint32_t type, unsigned long addr, uint32_t size)
 {
 	struct btf_var_secinfo si = {
 		.type = type,
-		.offset = offset,
+		.offset = addr,
 		.size = size,
 	};
-	return gobuffer__add(&encoder->percpu_secinfo, &si, sizeof(si));
+	return gobuffer__add(&encoder->secinfo[shndx].secinfo, &si, sizeof(si));
 }
 
 int32_t btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_encoder *other)
 {
-	struct gobuffer *var_secinfo_buf = &other->percpu_secinfo;
-	size_t sz = gobuffer__size(var_secinfo_buf);
-	uint16_t nr_var_secinfo = sz / sizeof(struct btf_var_secinfo);
-	uint32_t type_id;
-	uint32_t next_type_id = btf__type_cnt(encoder->btf);
-	int32_t i, id;
-	struct btf_var_secinfo *vsi;
-
+	int shndx;
 	if (encoder == other)
 		return 0;
 
 	btf_encoder__add_saved_funcs(other);
 
-	for (i = 0; i < nr_var_secinfo; i++) {
-		vsi = (struct btf_var_secinfo *)var_secinfo_buf->entries + i;
-		type_id = next_type_id + vsi->type - 1; /* Type ID starts from 1 */
-		id = btf_encoder__add_var_secinfo(encoder, type_id, vsi->offset, vsi->size);
-		if (id < 0)
-			return id;
+	for (shndx = 0; shndx < other->seccnt; shndx++) {
+		struct gobuffer *var_secinfo_buf = &other->secinfo[shndx].secinfo;
+		size_t sz = gobuffer__size(var_secinfo_buf);
+		uint16_t nr_var_secinfo = sz / sizeof(struct btf_var_secinfo);
+		uint32_t type_id;
+		uint32_t next_type_id = btf__type_cnt(encoder->btf);
+		int32_t i, id;
+		struct btf_var_secinfo *vsi;
+
+		if (strcmp(encoder->secinfo[shndx].name, other->secinfo[shndx].name)) {
+			fprintf(stderr, "mismatched ELF sections at index %d: \"%s\", \"%s\"\n",
+				shndx, encoder->secinfo[shndx].name, other->secinfo[shndx].name);
+			return -1;
+		}
+
+		for (i = 0; i < nr_var_secinfo; i++) {
+			vsi = (struct btf_var_secinfo *)var_secinfo_buf->entries + i;
+			type_id = next_type_id + vsi->type - 1; /* Type ID starts from 1 */
+			id = btf_encoder__add_var_secinfo(encoder, shndx, type_id, vsi->offset, vsi->size);
+			if (id < 0)
+				return id;
+		}
 	}
 
 	return btf__add_btf(encoder->btf, other->btf);
 }
 
-static int32_t btf_encoder__add_datasec(struct btf_encoder *encoder, const char *section_name)
+static int32_t btf_encoder__add_datasec(struct btf_encoder *encoder, int shndx)
 {
-	struct gobuffer *var_secinfo_buf = &encoder->percpu_secinfo;
+	struct gobuffer *var_secinfo_buf = &encoder->secinfo[shndx].secinfo;
+	const char *section_name = encoder->secinfo[shndx].name;
 	struct btf *btf = encoder->btf;
 	size_t sz = gobuffer__size(var_secinfo_buf);
 	uint16_t nr_var_secinfo = sz / sizeof(struct btf_var_secinfo);
@@ -1741,13 +1741,14 @@ out:
 int btf_encoder__encode(struct btf_encoder *encoder)
 {
 	bool should_tag_kfuncs;
-	int err;
+	int err, shndx;
 
 	/* for single-threaded case, saved funcs are added here */
 	btf_encoder__add_saved_funcs(encoder);
 
-	if (gobuffer__size(&encoder->percpu_secinfo) != 0)
-		btf_encoder__add_datasec(encoder, PERCPU_SECTION);
+	for (shndx = 0; shndx < encoder->seccnt; shndx++)
+		if (gobuffer__size(&encoder->secinfo[shndx].secinfo))
+			btf_encoder__add_datasec(encoder, shndx);
 
 	/* Empty file, nothing to do, so... done! */
 	if (btf__type_cnt(encoder->btf) == 1)
@@ -1797,111 +1798,18 @@ int btf_encoder__encode(struct btf_encoder *encoder)
 	return err;
 }
 
-static int percpu_var_cmp(const void *_a, const void *_b)
-{
-	const struct var_info *a = _a;
-	const struct var_info *b = _b;
-
-	if (a->addr == b->addr)
-		return 0;
-	return a->addr < b->addr ? -1 : 1;
-}
-
-static bool btf_encoder__percpu_var_exists(struct btf_encoder *encoder, uint64_t addr, uint32_t *sz, const char **name)
-{
-	struct var_info key = { .addr = addr };
-	const struct var_info *p = bsearch(&key, encoder->percpu.vars, encoder->percpu.var_cnt,
-					   sizeof(encoder->percpu.vars[0]), percpu_var_cmp);
-	if (!p)
-		return false;
-
-	*sz = p->sz;
-	*name = p->name;
-	return true;
-}
-
-static int btf_encoder__collect_percpu_var(struct btf_encoder *encoder, GElf_Sym *sym, size_t sym_sec_idx)
-{
-	const char *sym_name;
-	uint64_t addr;
-	uint32_t size;
-
-	/* compare a symbol's shndx to determine if it's a percpu variable */
-	if (sym_sec_idx != encoder->percpu.shndx)
-		return 0;
-	if (elf_sym__type(sym) != STT_OBJECT)
-		return 0;
-
-	addr = elf_sym__value(sym);
-
-	size = elf_sym__size(sym);
-	if (!size)
-		return 0; /* ignore zero-sized symbols */
-
-	sym_name = elf_sym__name(sym, encoder->symtab);
-	if (!btf_name_valid(sym_name)) {
-		dump_invalid_symbol("Found symbol of invalid name when encoding btf",
-				    sym_name, encoder->verbose, encoder->force);
-		if (encoder->force)
-			return 0;
-		return -1;
-	}
-
-	if (encoder->verbose)
-		printf("Found per-CPU symbol '%s' at address 0x%" PRIx64 "\n", sym_name, addr);
-
-	/* Make sure addr is section-relative. For kernel modules (which are
-	 * ET_REL files) this is already the case. For vmlinux (which is an
-	 * ET_EXEC file) we need to subtract the section address.
-	 */
-	if (!encoder->is_rel)
-		addr -= encoder->secinfo[encoder->percpu.shndx].addr;
-
-	if (encoder->percpu.var_cnt == encoder->percpu.allocated) {
-		struct var_info *new;
-
-		new = reallocarray_grow(encoder->percpu.vars,
-					&encoder->percpu.allocated,
-					sizeof(*encoder->percpu.vars));
-		if (!new) {
-			fprintf(stderr, "Failed to allocate memory for variables\n");
-			return -1;
-		}
-		encoder->percpu.vars = new;
-	}
-	encoder->percpu.vars[encoder->percpu.var_cnt].addr = addr;
-	encoder->percpu.vars[encoder->percpu.var_cnt].sz = size;
-	encoder->percpu.vars[encoder->percpu.var_cnt].name = sym_name;
-	encoder->percpu.var_cnt++;
-
-	return 0;
-}
 
-static int btf_encoder__collect_symbols(struct btf_encoder *encoder, bool collect_percpu_vars)
+static int btf_encoder__collect_symbols(struct btf_encoder *encoder)
 {
-	Elf32_Word sym_sec_idx;
+	uint32_t sym_sec_idx;
 	uint32_t core_id;
 	GElf_Sym sym;
 
-	/* cache variables' addresses, preparing for searching in symtab. */
-	encoder->percpu.var_cnt = 0;
-
-	/* search within symtab for percpu variables */
 	elf_symtab__for_each_symbol_index(encoder->symtab, core_id, sym, sym_sec_idx) {
-		if (collect_percpu_vars && btf_encoder__collect_percpu_var(encoder, &sym, sym_sec_idx))
-			return -1;
 		if (btf_encoder__collect_function(encoder, &sym))
 			return -1;
 	}
 
-	if (collect_percpu_vars) {
-		if (encoder->percpu.var_cnt)
-			qsort(encoder->percpu.vars, encoder->percpu.var_cnt, sizeof(encoder->percpu.vars[0]), percpu_var_cmp);
-
-		if (encoder->verbose)
-			printf("Found %d per-CPU variables!\n", encoder->percpu.var_cnt);
-	}
-
 	if (encoder->functions.cnt) {
 		qsort(encoder->functions.entries, encoder->functions.cnt, sizeof(encoder->functions.entries[0]),
 		      functions_cmp);
@@ -1923,75 +1831,128 @@ static bool ftype__has_arg_names(const struct ftype *ftype)
 	return true;
 }
 
+static int get_elf_section(struct btf_encoder *encoder, unsigned long addr)
+{
+	/* Start at index 1 to ignore initial SHT_NULL section */
+	for (int i = 1; i < encoder->seccnt; i++)
+		/* Variables are only present in PROGBITS or NOBITS (.bss) */
+		if ((encoder->secinfo[i].type == SHT_PROGBITS ||
+		     encoder->secinfo[i].type == SHT_NOBITS) &&
+		    encoder->secinfo[i].addr <= addr &&
+		    (addr - encoder->secinfo[i].addr) < encoder->secinfo[i].sz)
+			return i;
+	return -ENOENT;
+}
+
+/*
+ * Filter out variables / symbol names with common prefixes and no useful
+ * values. Prefixes should be added sparingly, and it should be objectively
+ * obvious that they are not useful.
+ */
+static bool filter_variable_name(const char *name)
+{
+	static const struct { char *s; size_t len; } skip[] = {
+		#define X(str) {str, sizeof(str) - 1}
+		X("__UNIQUE_ID"),
+		X("__tpstrtab_"),
+		X("__exitcall_"),
+		X("__func_stack_frame_non_standard_")
+		#undef X
+	};
+	int i;
+
+	if (*name != '_')
+		return false;
+
+	for (i = 0; i < ARRAY_SIZE(skip); i++) {
+		if (strncmp(name, skip[i].s, skip[i].len) == 0)
+			return true;
+	}
+	return false;
+}
+
 static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 {
 	struct cu *cu = encoder->cu;
 	uint32_t core_id;
 	struct tag *pos;
 	int err = -1;
-	struct elf_secinfo *pcpu_scn = &encoder->secinfo[encoder->percpu.shndx];
 
-	if (encoder->percpu.shndx == 0 || !encoder->symtab)
+	if (!encoder->symtab)
 		return 0;
 
 	if (encoder->verbose)
-		printf("search cu '%s' for percpu global variables.\n", cu->name);
+		printf("search cu '%s' for global variables.\n", cu->name);
 
 	cu__for_each_variable(cu, core_id, pos) {
 		struct variable *var = tag__variable(pos);
-		uint32_t size, type, linkage;
-		const char *name, *dwarf_name;
+		uint32_t type, linkage;
+		const char *name;
 		struct llvm_annotation *annot;
 		const struct tag *tag;
+		int shndx;
+		struct elf_secinfo *sec = NULL;
 		uint64_t addr;
 		int id;
+		unsigned long size;
 
+		/* Skip incomplete (non-defining) declarations */
 		if (var->declaration && !var->spec)
 			continue;
 
-		/* percpu variables are allocated in global space */
-		if (variable__scope(var) != VSCOPE_GLOBAL && !var->spec)
+		/*
+		 * top_level: indicates that the variable is declared at the top
+		 *   level of the CU, and thus it is globally scoped.
+		 * artificial: indicates that the variable is a compiler-generated
+		 *   "fake" variable that doesn't appear in the source.
+		 * scope: set by pahole to indicate the type of storage the
+		 *   variable has. GLOBAL indicates it is stored in static
+		 *   memory (as opposed to a stack variable or register)
+		 *
+		 * Some variables are "top_level" but not GLOBAL:
+		 *   e.g. current_stack_pointer, which is a register variable,
+		 *   despite having global CU-declarations. We don't want that,
+		 *   since no code could actually find this variable.
+		 * Some variables are GLOBAL but not top_level:
+		 *   e.g. function static variables
+		 */
+		if (!var->top_level || var->artificial || var->scope != VSCOPE_GLOBAL)
 			continue;
 
 		/* addr has to be recorded before we follow spec */
 		addr = var->ip.addr;
-		dwarf_name = variable__name(var);
 
-		/* Make sure addr is section-relative. DWARF, unlike ELF,
-		 * always contains virtual symbol addresses, so subtract
-		 * the section address unconditionally.
-		 */
-		if (addr < pcpu_scn->addr || addr >= pcpu_scn->addr + pcpu_scn->sz)
+		/* Get the ELF section info for the variable */
+		shndx = get_elf_section(encoder, addr);
+		if (shndx >= 0 && shndx < encoder->seccnt)
+			sec = &encoder->secinfo[shndx];
+		if (!sec || !sec->include)
 			continue;
-		addr -= pcpu_scn->addr;
 
-		if (!btf_encoder__percpu_var_exists(encoder, addr, &size, &name))
-			continue; /* not a per-CPU variable */
+		/* Convert addr to section relative */
+		addr -= sec->addr;
 
-		/* A lot of "special" DWARF variables (e.g, __UNIQUE_ID___xxx)
-		 * have addr == 0, which is the same as, say, valid
-		 * fixed_percpu_data per-CPU variable. To distinguish between
-		 * them, additionally compare DWARF and ELF symbol names. If
-		 * DWARF doesn't provide proper name, pessimistically assume
-		 * bad variable.
-		 *
-		 * Examples of such special variables are:
-		 *
-		 *  1. __ADDRESSABLE(sym), which are forcely emitted as symbols.
-		 *  2. __UNIQUE_ID(prefix), which are introduced to generate unique ids.
-		 *  3. __exitcall(fn), functions which are labeled as exit calls.
-		 *
-		 *  This is relevant only for vmlinux image, as for kernel
-		 *  modules per-CPU data section has non-zero offset so all
-		 *  per-CPU symbols have non-zero values.
-		 */
-		if (var->ip.addr == 0) {
-			if (!dwarf_name || strcmp(dwarf_name, name))
+		/* DWARF specification reference should be followed, because
+		 * information like the name & type may not be present on var */
+		if (var->spec)
+			var = var->spec;
+
+		name = variable__name(var);
+		if (!name)
+			continue;
+
+		/* Check for invalid BTF names */
+		if (!btf_name_valid(name)) {
+			dump_invalid_symbol("Found invalid variable name when encoding btf",
+					    name, encoder->verbose, encoder->force);
+			if (encoder->force)
 				continue;
+			else
+				return -1;
 		}
 
-		if (var->spec)
-			var = var->spec;
+		if (filter_variable_name(name))
+			continue;
 
 		if (var->ip.tag.type == 0) {
 			fprintf(stderr, "error: found variable '%s' in CU '%s' that has void type\n",
@@ -2003,9 +1964,10 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 		}
 
 		tag = cu__type(cu, var->ip.tag.type);
-		if (tag__size(tag, cu) == 0) {
+		size = tag__size(tag, cu);
+		if (size == 0) {
 			if (encoder->verbose)
-				fprintf(stderr, "Ignoring zero-sized per-CPU variable '%s'...\n", dwarf_name ?: "<missing name>");
+				fprintf(stderr, "Ignoring zero-sized variable '%s'...\n", name ?: "<missing name>");
 			continue;
 		}
 
@@ -2035,13 +1997,14 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 		}
 
 		/*
-		 * add a BTF_VAR_SECINFO in encoder->percpu_secinfo, which will be added into
-		 * encoder->types later when we add BTF_VAR_DATASEC.
+		 * Add the variable to the secinfo for the section it appears in.
+		 * Later we will generate a BTF_VAR_DATASEC for all any section with
+		 * an encoded variable.
 		 */
-		id = btf_encoder__add_var_secinfo(encoder, id, addr, size);
+		id = btf_encoder__add_var_secinfo(encoder, shndx, id, addr, size);
 		if (id < 0) {
 			fprintf(stderr, "error: failed to encode section info for variable '%s' at addr 0x%" PRIx64 "\n",
-			        name, addr);
+				name, addr);
 			goto out;
 		}
 	}
@@ -2068,7 +2031,6 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 
 		encoder->force		 = conf_load->btf_encode_force;
 		encoder->gen_floats	 = conf_load->btf_gen_floats;
-		encoder->skip_encoding_vars = conf_load->skip_encoding_btf_vars;
 		encoder->skip_encoding_decl_tag	 = conf_load->skip_encoding_btf_decl_tag;
 		encoder->tag_kfuncs	 = conf_load->btf_decl_tag_kfuncs;
 		encoder->gen_distilled_base = conf_load->btf_gen_distilled_base;
@@ -2076,6 +2038,11 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 		encoder->has_index_type  = false;
 		encoder->need_index_type = false;
 		encoder->array_index_id  = 0;
+		encoder->encode_vars = 0;
+		if (!conf_load->skip_encoding_btf_vars)
+			encoder->encode_vars |= BTF_VAR_PERCPU;
+		if (conf_load->encode_btf_global_vars)
+			encoder->encode_vars |= BTF_VAR_GLOBAL;
 
 		GElf_Ehdr ehdr;
 
@@ -2085,8 +2052,6 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 			goto out_delete;
 		}
 
-		encoder->is_rel = ehdr.e_type == ET_REL;
-
 		switch (ehdr.e_ident[EI_DATA]) {
 		case ELFDATA2LSB:
 			btf__set_endianness(encoder->btf, BTF_LITTLE_ENDIAN);
@@ -2127,15 +2092,21 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 			encoder->secinfo[shndx].addr = shdr.sh_addr;
 			encoder->secinfo[shndx].sz = shdr.sh_size;
 			encoder->secinfo[shndx].name = secname;
-
-			if (strcmp(secname, PERCPU_SECTION) == 0)
-				encoder->percpu.shndx = shndx;
+			encoder->secinfo[shndx].type = shdr.sh_type;
+			if (encoder->encode_vars & BTF_VAR_GLOBAL)
+				encoder->secinfo[shndx].include = true;
+
+			if (strcmp(secname, PERCPU_SECTION) == 0) {
+				encoder->percpu_shndx = shndx;
+				if (encoder->encode_vars & BTF_VAR_PERCPU)
+					encoder->secinfo[shndx].include = true;
+			}
 		}
 
-		if (!encoder->percpu.shndx && encoder->verbose)
+		if (!encoder->percpu_shndx && encoder->verbose)
 			printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->filename, PERCPU_SECTION);
 
-		if (btf_encoder__collect_symbols(encoder, !encoder->skip_encoding_vars))
+		if (btf_encoder__collect_symbols(encoder))
 			goto out_delete;
 
 		if (encoder->verbose)
@@ -2156,7 +2127,8 @@ void btf_encoder__delete(struct btf_encoder *encoder)
 		return;
 
 	btf_encoders__delete(encoder);
-	__gobuffer__delete(&encoder->percpu_secinfo);
+	for (int i = 0; i < encoder->seccnt; i++)
+		__gobuffer__delete(&encoder->secinfo[i].secinfo);
 	zfree(&encoder->filename);
 	zfree(&encoder->source_filename);
 	btf__free(encoder->btf);
@@ -2166,9 +2138,6 @@ void btf_encoder__delete(struct btf_encoder *encoder)
 	encoder->functions.allocated = encoder->functions.cnt = 0;
 	free(encoder->functions.entries);
 	encoder->functions.entries = NULL;
-	encoder->percpu.allocated = encoder->percpu.var_cnt = 0;
-	free(encoder->percpu.vars);
-	encoder->percpu.vars = NULL;
 
 	free(encoder);
 }
@@ -2321,7 +2290,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 			goto out;
 	}
 
-	if (!encoder->skip_encoding_vars)
+	if (encoder->encode_vars)
 		err = btf_encoder__encode_cu_variables(encoder);
 
 	/* It is only safe to delete this CU if we have not stashed any static
diff --git a/btf_encoder.h b/btf_encoder.h
index f54c95a..5e4d53a 100644
--- a/btf_encoder.h
+++ b/btf_encoder.h
@@ -16,7 +16,15 @@ struct btf;
 struct cu;
 struct list_head;
 
+/* Bit flags specifying which kinds of variables are emitted */
+enum btf_var_option {
+	BTF_VAR_NONE = 0,
+	BTF_VAR_PERCPU = 1,
+	BTF_VAR_GLOBAL = 2,
+};
+
 struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool verbose, struct conf_load *conf_load);
+
 void btf_encoder__delete(struct btf_encoder *encoder);
 
 int btf_encoder__encode(struct btf_encoder *encoder);
diff --git a/dwarves.h b/dwarves.h
index 0fede91..fef881f 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -92,6 +92,7 @@ struct conf_load {
 	bool			btf_gen_optimized;
 	bool			skip_encoding_btf_inconsistent_proto;
 	bool			skip_encoding_btf_vars;
+	bool			encode_btf_global_vars;
 	bool			btf_gen_floats;
 	bool			btf_encode_force;
 	bool			reproducible_build;
diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index 0a9d8ac..4bc2d03 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -230,7 +230,10 @@ the debugging information.
 
 .TP
 .B \-\-skip_encoding_btf_vars
-Do not encode VARs in BTF.
+.TQ
+.B \-\-encode_btf_global_vars
+By default, VARs are encoded only for percpu variables. These options allow
+to skip encoding them, or alternatively to encode all global variables too.
 
 .TP
 .B \-\-skip_encoding_btf_decl_tag
@@ -296,7 +299,8 @@ Encode BTF using the specified feature list, or specify 'default' for all standa
 	encode_force       Ignore invalid symbols when encoding BTF; for example
 	                   if a symbol has an invalid name, it will be ignored
 	                   and BTF encoding will continue.
-	var                Encode variables using BTF_KIND_VAR in BTF.
+	var                Encode percpu variables using BTF_KIND_VAR in BTF.
+	global_var         Encode all global variables in the same way.
 	float              Encode floating-point types in BTF.
 	decl_tag           Encode declaration tags using BTF_KIND_DECL_TAG.
 	type_tag           Encode type tags using BTF_KIND_TYPE_TAG.
diff --git a/pahole.c b/pahole.c
index a33490d..b123be1 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1239,6 +1239,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_contains_enumerator 344
 #define ARGP_reproducible_build 345
 #define ARGP_running_kernel_vmlinux 346
+#define ARGP_encode_btf_global_vars 347
 
 /* --btf_features=feature1[,feature2,..] allows us to specify
  * a list of requested BTF features or "default" to enable all default
@@ -1285,6 +1286,7 @@ struct btf_feature {
 } btf_features[] = {
 	BTF_DEFAULT_FEATURE(encode_force, btf_encode_force, false),
 	BTF_DEFAULT_FEATURE(var, skip_encoding_btf_vars, true),
+	BTF_DEFAULT_FEATURE(global_var, encode_btf_global_vars, false),
 	BTF_DEFAULT_FEATURE(float, btf_gen_floats, false),
 	BTF_DEFAULT_FEATURE(decl_tag, skip_encoding_btf_decl_tag, true),
 	BTF_DEFAULT_FEATURE(type_tag, skip_encoding_btf_type_tag, true),
@@ -1720,7 +1722,12 @@ static const struct argp_option pahole__options[] = {
 	{
 		.name = "skip_encoding_btf_vars",
 		.key  = ARGP_skip_encoding_btf_vars,
-		.doc  = "Do not encode VARs in BTF."
+		.doc  = "Do not encode any VARs in BTF [if this is not specified, only percpu variables are encoded. To encode global variables too, use --encode_btf_global_vars]."
+	},
+	{
+		.name = "encode_btf_global_vars",
+		.key  = ARGP_skip_encoding_btf_vars,
+		.doc  = "Encode all global VARs in BTF [if this is not specified, only percpu variables are encoded]."
 	},
 	{
 		.name = "btf_encode_force",
@@ -2047,6 +2054,8 @@ static error_t pahole__options_parser(int key, char *arg,
 		show_supported_btf_features(stdout);	exit(0);
 	case ARGP_btf_features_strict:
 		parse_btf_features(arg, true);		break;
+	case ARGP_encode_btf_global_vars:
+		conf_load.encode_btf_global_vars = true;	break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
-- 
2.43.5


