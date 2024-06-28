Return-Path: <bpf+bounces-33372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F6591C4B5
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 19:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4276DB2324C
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 17:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC07B1CB315;
	Fri, 28 Jun 2024 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="awj+LVPG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GiuemcAB"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5B819AA4B;
	Fri, 28 Jun 2024 17:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719595218; cv=fail; b=S5dDN91U+YXKJZYwOkluvZF52jSVLU46k6UyVLUxAwD/TlN6/dj8CExorF1DUGyJ6SiU4MN/zNYICNhos/TOJAzZvlXBh+zVhCZOs7Tfo+QWI8ya09Xo4Q2k+HvS3FZuDX68gDLd13HGhP5QokUxbkfMTxmlDYtx2XuOVSaaF2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719595218; c=relaxed/simple;
	bh=UI2mCpHWvruLU2MhRbuj1gEZZYUE5zVmfzAAEy1xggQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nAUUVTOARq9+XvyUusMZSAsOZeguKFaF/GMo7LguRqGV3/UIBrRAG1wVZjeuzhnJndcwrhdJhFO1EihzNTAriUzmkl6+GAv3tBSNgt8KNPRDtMR/yQq3+CzKhONB2FwJZLkcQ8BQgwDQ5nCSAGtdho2iZBZmzVjuLsrj0AFs5Bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=awj+LVPG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GiuemcAB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45SH6QXx017141;
	Fri, 28 Jun 2024 17:19:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=fCVXi8+o2xPUb1n
	7ubvGzkmBCtRxySPneWy++sqnB3g=; b=awj+LVPGX3pSREkUqG7vZt5V443er/e
	1Kku0a/5R7Y0sPJqH44b9cakzXecIj8/yzeRb1uM9icqvyIa3rHF9zA5I7Ee4AQd
	VkPcVapPNW0HZJUM/+Hyi7V2gjDsqXDJu75NQdx+7cQHAtrGqyc/dWsNDElFU3mo
	bDuIX0iPpAHclbWUnrllej5IpcgU/aYyMlIMqFrJqt2jl7q7wdJZPvDf88ECvgJd
	bKLEOg32qXJ9mT5QvUj2K22i8jl72U6F36YypHrCa7BECteXXZzezOIq4vHSQ3od
	CejnRIbGM6iMYL31UVWFK/RPH1HjcV7BqhsDLyHPYj0VXaROEnwojLg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywnd2rsad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Jun 2024 17:19:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45SGU83P023334;
	Fri, 28 Jun 2024 17:19:55 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2jjsdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Jun 2024 17:19:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8R1TNoKFyOqoPim7uW+tTy1RcXPd1umbCE8HyC/gJ8ifqmZijcQJdp8HMCsNxXId53bSF1NsP0XyD8aHzpEMoy10Iy8mOXvKm7O3mP560Eyz324uWWYlWhFBa0jZTSwnXQw2T/Ttynmfyv5l8jq+UyeNHqATYJ8gnu03KgKvCBMjaoWoVeEMDePgMlKtWAzF5CEb46X/7eel2rcHZS5BbCrp1WWQZoojgOWdajl4wQUMN9zCHTo/MBhwtYIYDzp0SUyx5y/GAJkcJ7HCOzHSJ/fulCFyudGnqyQyeQQFzVeIIgYE6PXYbW+bvvV12D2qaH68n5U45tHdxTmXfsjnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCVXi8+o2xPUb1n7ubvGzkmBCtRxySPneWy++sqnB3g=;
 b=gWd+1tkK5j3iiE/+ey0SRVUfTBoMsWn2nBAP76I9pARVUxITLimUGNl4I0A+VsW754jgkr4W7F04xXPsNHH1ARJ7toUlapn34vJjoycMXpmjslpFOz2AwHDaQJIv+drM16x0ylLfA0CNK2sCO3sZyLiUMi0Z43NowQqZeVJqxSUtG887hkAF3ywTTmagxyeRtU71bXlRnT4ZCvcFhpUaO3Z+WREISe/B/dzoRq/9Bt9AKY/OIZ5anZmCeTReDt+VBWTamRsYcyQa5J2Qn0dWXMhh9RyxWc2xeWf7/p/MKkKE2F9A/yUVfhqwueoeYZs1JvvCk4O7kCETenyrADga5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCVXi8+o2xPUb1n7ubvGzkmBCtRxySPneWy++sqnB3g=;
 b=GiuemcAB7bw/syWoV0+KHOlidpq743gjKPSkfq19jd3lERE4WJ5PjgPiAvr+bBodtD0OX5iCX599kNtRHtuAR4rXFR83wgaNlkoSkqM00T/djd1jUFu2OwDWgI6CFjsRQ5LAoaiqudhaXv0rdjwFaDLkdLTibjMk3Q2tb49+TFA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4134.namprd10.prod.outlook.com (2603:10b6:610:a7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.31; Fri, 28 Jun
 2024 17:19:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.033; Fri, 28 Jun 2024
 17:19:53 +0000
Date: Fri, 28 Jun 2024 13:19:49 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kuba@kernel.org, neilb@suse.de, jlayton@kernel.org, kolga@netapp.com,
        Dai.Ngo@oracle.com, tom@talpey.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Lex Siegel <usiegl00@gmail.com>
Subject: Re: [PATCH net v2] net, sunrpc: Remap EPERM in case of connection
 failure in xs_tcp_setup_socket
Message-ID: <Zn7wtStV+iafWRXj@tissot.1015granger.net>
References: <2e62f0fc284b2f27156cd497fbb733b55a5ade43.1719592013.git.daniel@iogearbox.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e62f0fc284b2f27156cd497fbb733b55a5ade43.1719592013.git.daniel@iogearbox.net>
X-ClientProxiedBy: CH2PR12CA0019.namprd12.prod.outlook.com
 (2603:10b6:610:57::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH2PR10MB4134:EE_
X-MS-Office365-Filtering-Correlation-Id: d4bd35f5-0cfe-4683-29d3-08dc97968621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?/G5dcesInbtOloDPNhl9+gleY3DeFOF8JGi+hMIlg72l3ZYFQD5UKeF/e9Hv?=
 =?us-ascii?Q?cskbd/8x6j+BXYFnc0Ns3gtkQCorJpspvs2PgUwFauSmFhMiY5be7kdcNpJL?=
 =?us-ascii?Q?pPpAj5DPwaia3sPkyHuBiU/9gEyIzijHJUQS7cRhjlq3Qzx/pFX7SynpsZif?=
 =?us-ascii?Q?fQJdC5uISUhgosNcvqQzYRswfH38QBWhMk4ca7/zfBeOSkWkcN1l2Smg7AIJ?=
 =?us-ascii?Q?+aqpx6vo2xXRkrT5JxpJBUszWYblhwL4OfdG9IwoVIPD/3DlM4MxnPQXdm02?=
 =?us-ascii?Q?DqPMWooWTkflZTQsNlVxXLH9fMJ7hnwymbfMBIZa4IFaEN9z/vZ7AgE/Q9/d?=
 =?us-ascii?Q?A+iG18OZn1qivolJrZubCgdzyVrPTnyLeNOaFVmijAzyrh1Y2qRHaJbnspwF?=
 =?us-ascii?Q?a/Jy9sa+7rfe4JBHP9ErA4qcMjkLdoYdceLiqiJapTKfvGwVCITwX/Yufjn9?=
 =?us-ascii?Q?npAUjGuLEv75BZakFFXT4EJvd+V4aLIKuHhYIB+KhaY66psnsX3xnR/Ff5J/?=
 =?us-ascii?Q?XkncvBrIVXYyNyKaYCKMb0sVASyqikGqFLsqw0TS/J/GifYkqh+V6jlXdG6C?=
 =?us-ascii?Q?hpI9c7UunmlQsDSTR+Fu78QjzYAqRcQEKqjV3FWzBis0Tv5hQ53jQSvpj63T?=
 =?us-ascii?Q?QKExbXcKnRo4LbSFfnb9dKErNwZFLHhaKKymhjDT4+3QtwmCHGhTSt9PVHFc?=
 =?us-ascii?Q?2ZXGY5FUXSNLft1EKMRVyAbtN5ODbnoPMD/XAvU27v4yWyxiNNluQNH2rKBI?=
 =?us-ascii?Q?QvUyHfYsdAa4YWY0hRY6fHQ4+ehhPg8Vu/C5mxnTi0/RUS8SxJ7Z6INRXlmv?=
 =?us-ascii?Q?zAf1LgYC7Q03IIZSwUL0wOE4CDp0KfK1JdHFm2K5v+/Ug2sjfPEmWnRPuHxC?=
 =?us-ascii?Q?S6jeOkfQlHYWmR6J5RmNB0f4oQ6xJc8KD6Kf42fZkUFoJn01vdCWwqCHpc2l?=
 =?us-ascii?Q?xdn5MpjHzzWV4YDvk1vKw1phxet0hyJoeY+GmdZAc+/Oc1xVRloQYl8rxx6I?=
 =?us-ascii?Q?WSSFEP6MZplQgvVBD99b9/Q7kzO+Y/n0IyPbtdCJuCyC+rmcWn0hKMXNTlrP?=
 =?us-ascii?Q?pjVXp5LcJfex+1jC55GkKMCZ2TeISvvlmDhC7CJRGTk6D/L5mjy+4vPNmxOv?=
 =?us-ascii?Q?y1Z83bahchj78VPgUJnRV7C5g+uiYXUdTqz6fd6L85QSXVinEyCnnR9FjMLm?=
 =?us-ascii?Q?9UcU2MqvvNuL3oxeYHlSbJSQ5fLZJb6DJ0af3L0ToHE04aQD3axzf0v4dcrv?=
 =?us-ascii?Q?nnx38AZMhBvavLoH7TuO5FzMU7AfbEe0YSjRaDtSnawo4NGSrWt261TOIOqO?=
 =?us-ascii?Q?8AmyaHfmxNPttCxMcVfaBkga?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1rWtiMbcwfs57ovgIXD0QVwKsvt1Lb45yTfKB1kqQ5gdJMvfwAsyRvKC6JUU?=
 =?us-ascii?Q?kS/S4Zw2Kir7FcSw6byEP0XnSScOfo7XgKCR3uDpSFi9Se0X2KD+LJc/qWnz?=
 =?us-ascii?Q?F8Jf7Z06H5wRL3bfDDYtszpLA+ofJyM2+jBhZjZiGhebB1LK2bTNmOoUi9XW?=
 =?us-ascii?Q?9epNzxPdP4DPcPvWrnYWncLnz3IFuLxxgtzPPqrxYlpBdjhCl6wNHNjPoDOB?=
 =?us-ascii?Q?1qDBG5kDDBvbO63P9Kq2HDFcMhkSwDg19LW2mEl/EI8uYkt7YfblrPGqSBsD?=
 =?us-ascii?Q?T4NlXm6hcxk+um/dvuFZy+FAVCTAKe4v/WGvuKNEZSSUDPgg6zjY9gpk+pPQ?=
 =?us-ascii?Q?CcXvw2s0MiPXfao3PXLFfzdPYeID6/p4Vx8kQIt83MGAffaTtAuM5KdFmr1q?=
 =?us-ascii?Q?gr6Phvyzzkgd9y/qY9g/xu3Jbp8x6fvvS7EVPoXCyOwKKARhx7oO8R7Z9a9V?=
 =?us-ascii?Q?Mviu61U1NgJxui6fUN+5/A/k2cf7QESUcvuaLH1jvaTewB4glEucPmka6Fxx?=
 =?us-ascii?Q?Eff94QBwH5I/LG6EkbbFjwe3DGUJ1f+DxHJ8bIKbPlnXr6BhPf7/IORPZPlc?=
 =?us-ascii?Q?4lHJGyfL524HL+fuJI38xFFIXcF5XQKHGxRtHhzbp5gL+ShHpYFBs5ld5o0K?=
 =?us-ascii?Q?BTmuWry7xjonFq047qoiE8OLkowy13HdCZBaTM/Dz02zptuc2fQddF+RpLYa?=
 =?us-ascii?Q?jyW/3GuAcofBDHu3ZQLBGQEey09z1yul8WwkNm2SdzQLULUnKe2CxRtkNJEF?=
 =?us-ascii?Q?U2u1Sm82EudsZfpPX1woVqDoKnUdD3noCkNCf8WXmiEs06FV04AXndA7asZZ?=
 =?us-ascii?Q?NmxKWY3XketesA+YwdgvZv8+lBNT3wtpr0cez6aMoLuOKyTmZagOqojPPbfF?=
 =?us-ascii?Q?8P55Z6fef5JfMonY0dCjfTG6r8cihes7A9JBjtu8uCD5w/yMHExJCDZzfJhE?=
 =?us-ascii?Q?pYsKvJJ/ujsrOZFydiTMxTB0OTmKAaoRkJ/TvHwjNiZFRrd49kkwCpQVQXxn?=
 =?us-ascii?Q?75pe5Nhjul71bGDWBRK6jNfmnf9hYAxrgXNxSDF+xA8CCHY2Fb/MCSy+iMqP?=
 =?us-ascii?Q?dK0BR5lI0fz58StlaXEoPpfiYStBP5G8ZzPMFmH1wLwpS2JX10bgrqai2beT?=
 =?us-ascii?Q?USImDXZ/jIsIpg2hl48ZYt356iBxoW8ozzgyhC1caz/Ra7okGFoKGAXM6Y6i?=
 =?us-ascii?Q?fG2+Laiw5D9KcZnVIcNJxZTmE9cTc8areS85Z5cIe1aydvNCEHG/LXMz9suE?=
 =?us-ascii?Q?jQUD7y6geOGL9sHJ3wmPA9h/l0zODqyFk7VCLkz6HENp5N/IvXLsds/jYPGp?=
 =?us-ascii?Q?E2kD/77cocjhWCQ5R9E1al3w8va7LhRnIlElisGdhC+6RxmVZAgqIG6d2E74?=
 =?us-ascii?Q?x1Jopzgh49/OEqmxFKh5Msd3nRnIS5Rx1HDfP/78+omLS9WF5kYG5Np8b2Ax?=
 =?us-ascii?Q?TNgkpCDFc5iO5U3dKrabcBz04EDrwdtYROmxnwlPt4alLjF8bMjIKUKpvjE+?=
 =?us-ascii?Q?1CSACpo0EwHc4fvyHakCjaz14yU8MjhrPXC6xDbNrVOxlRH5QhW0NexIxt0L?=
 =?us-ascii?Q?rxdleq69xCgmJuYApZKqw/dygqPN/R2ePHIP5jzN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	n9ymVfWl2+KCFTyO9SbAo4lTSTzyc1Un4Rnoin40RLfTimRnLrMyGnZK6jXAOhOz/h11SGk0l9o46D2vkLQ3wUc7zcwUxWoN8hA275Z6QKGm9aM0vaEaBcOATGSdl/Y/t9VHR+9DV9tW1f2b+koHLuZDrLwIEQx4/UMI80HPY05b/4BUXzziBbjKiv5TDnwDzE9kLWrutFMktIT6sfb2wsO0iQrUe67gpQOILm8wVJ+3LTDkXvORr8iU74PCTTgYx05ebzRdYS5rnn/XCPuUXhJ9AL3mi9S/+j0N5+AaQP020GcCv8Y8WepdkkVDFxUNMN9bQ0rI437cMUovuAZPu3NS4ncN+j7ps2J3Htc+HqpxarUyDM3v0SBrwwYMnxo9DjHnhAurKSSE3H/JldShTPiOCUOpoW4WZozMewtN9vXvRtxL5lWRhVlCvzbwdS6knbBQaNoHlinv6IuWdd8yM/sOjhpNr2J5RUVhW4oTHK9YeBQOxiy1I3LVtgSueNuXRNj9Zn8IyirD6eIxDi940OphzMxIlPnKjzNtPasDpt3Us6pnfBe/8vp1V0MAHJIfmSEHzbuWx+JNyhacJ9+jo7jLO6q0/Pmw/XVrROyR3mE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4bd35f5-0cfe-4683-29d3-08dc97968621
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 17:19:53.2249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OaZaJcwFU8Vjgmnkur6zSo+9w/sIpbitO76WKYHdAlCu9RDAuTBbv7b5++Ehi+37H6U7x3s2CksO+jxODEsavQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4134
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_12,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406280129
X-Proofpoint-ORIG-GUID: B5LyEl4n-ylz97UtrsKl7IdAnGvjHQSc
X-Proofpoint-GUID: B5LyEl4n-ylz97UtrsKl7IdAnGvjHQSc

On Fri, Jun 28, 2024 at 06:31:23PM +0200, Daniel Borkmann wrote:
> When using a BPF program on kernel_connect(), the call can return -EPERM. This
> causes xs_tcp_setup_socket() to loop forever, filling up the syslog and causing
> the kernel to potentially freeze up.
> 
> Neil suggested:
> 
>   This will propagate -EPERM up into other layers which might not be ready
>   to handle it. It might be safer to map EPERM to an error we would be more
>   likely to expect from the network system - such as ECONNREFUSED or ENETDOWN.
> 
> ECONNREFUSED as error seems reasonable. For programs setting a different error
> can be out of reach (see handling in 4fbac77d2d09) in particular on kernels
> which do not have f10d05966196 ("bpf: Make BPF_PROG_RUN_ARRAY return -err
> instead of allow boolean"), thus given that it is better to simply remap for
> consistent behavior. UDP does handle EPERM in xs_udp_send_request().
> 
> Fixes: d74bad4e74ee ("bpf: Hooks for sys_connect")
> Fixes: 4fbac77d2d09 ("bpf: Hooks for sys_bind")
> Co-developed-by: Lex Siegel <usiegl00@gmail.com>
> Signed-off-by: Lex Siegel <usiegl00@gmail.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Link: https://github.com/cilium/cilium/issues/33395
> Link: https://lore.kernel.org/bpf/171374175513.12877.8993642908082014881@noble.neil.brown.name
> ---
>  [ Fixes tags are set to the orig connect commit so that stable team
>    can pick this up. ]
> 
>  v1 -> v2:
>    - Plain resend, adding more sunrpc folks to Cc
> 
>  net/sunrpc/xprtsock.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index dfc353eea8ed..0e1691316f42 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -2441,6 +2441,13 @@ static void xs_tcp_setup_socket(struct work_struct *work)
>  		transport->srcport = 0;
>  		status = -EAGAIN;
>  		break;
> +	case -EPERM:
> +		/* Happens, for instance, if a BPF program is preventing
> +		 * the connect. Remap the error so upper layers can better
> +		 * deal with it.
> +		 */
> +		status = -ECONNREFUSED;
> +		fallthrough;
>  	case -EINVAL:
>  		/* Happens, for instance, if the user specified a link
>  		 * local IPv6 address without a scope-id.
> -- 
> 2.21.0
> 

Hi Daniel -

I know this is not documented in MAINTAINERS, but changes to
net/sunrpc/xprtsock.c go to Anna Schumaker and Trond Myklebust,
cc: linux-nfs@vger.


-- 
Chuck Lever

