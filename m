Return-Path: <bpf+bounces-59725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D396EACEF0B
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 14:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1467A3AB073
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 12:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD4B217707;
	Thu,  5 Jun 2025 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AENp5wye";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dimftDr0"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB8349659;
	Thu,  5 Jun 2025 12:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749125889; cv=fail; b=B6mXbWTbZkfx7b7ka+R5HQojgtxPurYU7aDnuzABw+5UANd0Uc50BT73smDK0qDIqe9LSuSRIeX2G3KqQk0q+576BEfsJf6CuioYtcXxLzKoHXpVNPOqvAf1S5/IarhusFhCE0yrfPheX9XmxrQz56gvuMQy/TmwCPObJAavdrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749125889; c=relaxed/simple;
	bh=fYjjhjf3FBFJTlQKf1wUz2W66++lrfGG8zYEPkMuXow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n6GKT30YkRzFBMklQaMwxefs+2H7bNZMEAkUgRTV/uhqlDKsLZ46gTMBcLEmG3ApNfmZKgRKhBryd66PVa/DDoVLcoWjXt5LPYCA+9BwyV2iJJ4w7iWK7s15JnXiz0rgRq7WOtEK/IqfsojgVkrbjglkNW5yY56Mf3oEevcvQRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AENp5wye; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dimftDr0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555AtWhj001121;
	Thu, 5 Jun 2025 12:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=8XxwpNTtRA4A7vGITF
	o5ILz9s8yfac4bgR3AgK8hFGE=; b=AENp5wye9HFMqd04bhiEHFWRk1C3zP7CQY
	ZM8VNt4yyVqrgYbOWN1WebMwgzjKC0yW2Hu4//WjykBTvNYZZfllC/dBh2sllBUH
	UMwtLsIKPM7udL+OlP8BTxDUCV4j+rfqn+PBeLbYGM6mbe+lWhI5EjzFw7MZDPQf
	0jbT8BAHLbEEgCNzYL/5MEaR5lGd+XykmSCLCw0yUUwXOHlpC7FgR0+HKx1tX7gD
	uxKfqL1U7soXeia0lzSqiSsRMiaLldDCVeWRKl3gyyKiMp6RXt2XvWPgRkivm6tD
	e5W4AZOdutidV9sEeMaVC5Z+tE4F5Mv5BtaRAdhcIiQHlDv/1uLg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8dx23p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Jun 2025 12:17:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 555A8nEV039147;
	Thu, 5 Jun 2025 12:17:26 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7c17pr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Jun 2025 12:17:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySDAMaq2b9ZkSxWELtTUUjue4zDStdIKI+n1jkrHHwl0qAmwfTvnKWmS3nZn0pR6LwDWkHGRGUXBhF8pKCmi5M9Lzfsigw+B9IwmVbzuGYmrWRZeNRRARlr2he2BAq5UFglezQcysVA9NnnOJRNPIkKpb2LhMu+ECTiutX18lWlzU4NwP9SihSa8xMZeFfV1k8WuRXpctkh6WuqqI4Wx9Rj/9sfCRw5zG7IzOPQbmcp3PrPcrL/5dzAnHw1HauGiYzNoElMlS5kId3YVvSZTgSk4deFKt5Abfn4WxnVlaeBbZ0+Y4mgIdqqrYZGKbc/qUgZ+KVsq4W92JRdUoaJF/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XxwpNTtRA4A7vGITFo5ILz9s8yfac4bgR3AgK8hFGE=;
 b=DS2PFnc4QgAtcxlkqTuji0aVKNDx5+XUwSWcoBnqqHB3hWT9MtjYcXGCvig92O6yEuOZE2XKrWJKi+3mQ7Hb3l85El3rfkmVUrDMnsSSf6H/BirrrTcwzcMYGeO7C8MD8vYQSTcUwI37LlSbLnW3g6EKTQj2o56vqJqrI3CNBd8DSnLkKbTkDVmG/cTxk15fPgTLKPKrs+8KBilTphXUtdl9OoviRzCL6tIz5pJ9d+tDPoo7Sa9Qmm2XF9+cwHRfmLnYmeT/ynVN5tNHemt6eZvNTNwp0tqhk+9rimQjpmW521ykV/2Vn8SUJC7ltECytkSkkzK1VS235HkPr9Bb3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XxwpNTtRA4A7vGITFo5ILz9s8yfac4bgR3AgK8hFGE=;
 b=dimftDr03YugulxEVUe8VcMM91J75nrLnCT1ALUFLoOOmm8oLuOWJ5suyDRt83+Y8VOcwSb0XHiFxcFWKheS5m8vAKdRsrdDAy2L9M5aWRjd9wD4758A6MyGLZovVN1DgKbZUAqady7j5+K686EDL9g3O5QFdocOoEPcMhR9V8k=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SA1PR10MB7829.namprd10.prod.outlook.com (2603:10b6:806:3ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.22; Thu, 5 Jun
 2025 12:17:22 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%4]) with mapi id 15.20.8746.035; Thu, 5 Jun 2025
 12:17:21 +0000
Date: Thu, 5 Jun 2025 21:17:11 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org,
        almasrymina@google.com, ilias.apalodimas@linaro.org, hawk@kernel.org,
        akpm@linux-foundation.org, davem@davemloft.net,
        john.fastabend@gmail.com, andrew+netdev@lunn.ch, toke@redhat.com,
        tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
        saeedm@nvidia.com, leon@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, david@redhat.com, lorenzo.stoakes@oracle.com,
        Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, mhocko@suse.com, horms@kernel.org,
        linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
        vishal.moola@gmail.com
Subject: Re: [RFC v4 18/18] page_pool: access ->pp_magic through struct
 netmem_desc in page_pool_page_is_pp()
Message-ID: <aEGKx34Zz3v4hPTK@hyeyoo>
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-19-byungchul@sk.com>
 <390073b2-cc7f-4d31-a1c8-4149e884ce95@gmail.com>
 <aEGEM3Snkl8z8v4N@hyeyoo>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEGEM3Snkl8z8v4N@hyeyoo>
X-ClientProxiedBy: SEWP216CA0115.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b9::7) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SA1PR10MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: 51ee1a86-e1dc-4d28-ab27-08dda42aebf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fl25oNvGim9t4FAs4g49W34wtECWRPoyC4OersVk8Oi1IrmY/uLbk05Lfu76?=
 =?us-ascii?Q?38K8wj4CyT3v6jusmv4AGJdtc8zdC9VdDkT/flLfgMETQ51Q8wgGoBBGJC6F?=
 =?us-ascii?Q?9390RCTnWp5YVLm7wcFCyTEZehJUFTDG6G7QJ2veuafhRWMwes/ag8m6jr5x?=
 =?us-ascii?Q?w1xoxSflK/XOuzFl6WrMICIxlvSm6x7Bm3xaMVH3TyaOa3x5+BvU4N/XuTjl?=
 =?us-ascii?Q?AfJPV8nSw+qzuacKrzMH3A3BFQm8A02lvF4PiRhmI1D6cNnM2hYZ7SJLxJx+?=
 =?us-ascii?Q?L7dsUYo88Z83w2EaGYSYdiOkYa1PpamZsyrKJQTcHH+H2QZg3S4EjtPuDwSM?=
 =?us-ascii?Q?O9+FPZ60N+qaNCN8aHW5nSZm8YESY4ev7c/sy0j6bJTrNXL8rULfxwu7kzCz?=
 =?us-ascii?Q?PxGLG/DLBHDn4EGZV/dB9vDcRCJZ3dTutLgQDqFciJ5Rmwf38CC5cNMI18mC?=
 =?us-ascii?Q?1h59N0FEr96S34EpY0+GUr6QTn7xg1XLTzs/WhYnkibasdbLT00rZSuB1yn9?=
 =?us-ascii?Q?79JW+Yq/Udykufya9/VLSrBanLoLs2Wi1IYxXdI/fAbzPZv7clQnU3KLte4f?=
 =?us-ascii?Q?eNO9rHjEIZ4VXhFn75usDY2OAI2bo4OYCGlMY3ypoes7OdiEakvV83TslCDX?=
 =?us-ascii?Q?Lk27sRtFcrS0/2PdOLqvTsD52qcmFgTl/7vI8einN28N543pf+CCxWW/wKYc?=
 =?us-ascii?Q?NuwvQoS/E/Ug8KTuizqqrib9vhtUUqSSvbdPoCABRaToRVwqweE7Rugr8H7w?=
 =?us-ascii?Q?JvZg0DeCBdk3T+S0ePhwaYNF5WUycdoT3zqApxgZluM65AW2CIVgxxIETFvc?=
 =?us-ascii?Q?tQau9WL1pFpPE1ICwkZOcHib6RcurC0jD2ZLxmlFIw782LWHqeDv4E3BaU2/?=
 =?us-ascii?Q?Ecrp3C0IzkNcPmphTXcu5KeY74OxGi4QLSb83AxWu4gGZhtzlloKfMigeT8Z?=
 =?us-ascii?Q?8IEIMpT1/UkjwA5hkHoDdmg/rFuBLOxqDDJ9SaEmQOo7OJAGO1t7iAonPL4h?=
 =?us-ascii?Q?gFT4H+rJjeR8zaI5TsiwAuYNYn15yGtQD36+YWiOKMZ9PBWgCypkYSPaOnFK?=
 =?us-ascii?Q?kVhhH0GLRjOp9bNMMtAYiSCoWAH/8R8l9oTy/s0wP8AW0o5OWd26yeTb6xML?=
 =?us-ascii?Q?Hh01s17/eywmiEU45CWwizrngVDSrsrVCYUfTT37nhLibwPbANfLb9dz+E+C?=
 =?us-ascii?Q?3n94kIWyTvAOSHeiM5Qhm8d8gGYSjzjYwfoNTv695f1CSbWR0JFCk9H+VJIB?=
 =?us-ascii?Q?pzbYf3Ak1/Cufx9nFyXVqWIEM9z1bemUPT5AMFY9VhqTQRru74WRPg5Dlhwh?=
 =?us-ascii?Q?aEQeBnqSKvesAy53XRHJLiBQObNqVgzBJ4FWBcMsKwevZmJAHCpkQmsaXxZb?=
 =?us-ascii?Q?P1Arv60=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aVnqz1faMDhK5sPxLF5YbzYXxtGMH5YM4zAARd7cVyEmE6UWvT5joxAumIwl?=
 =?us-ascii?Q?ekU4ab5G0k22QC77watVCU/J+NOJvE2Ra7sLZoZQH29h5PfARRO8Q76lPYvK?=
 =?us-ascii?Q?LrHCE9CCIrhGlzdWOz3WMsCYlvJT0IqbmqUiEPPA+phTiWNqnOozfZJDNIrB?=
 =?us-ascii?Q?Hg80PuT/+WP8d1G1nJKaC1bW6CfTf2Txkk56pPiTVtkXATSxSwywNArBWRJU?=
 =?us-ascii?Q?vj6JMlwGL+gbWu/EssxbbG+QohGvcCVE4z0IGWkufXn5ZrBTalU9ZeJT3AJE?=
 =?us-ascii?Q?Sb1AZG5R3gj/f0XW96Ln78LY6BzYm3iCVtkMjFZk+Hs7N8NxH5nTf7IHBTXg?=
 =?us-ascii?Q?bIf/HA9+MX6d1KC4Kmf8IxBPJ65O9ulZjBqjhrbMRQM+1bZMO/F8y+7PPb6l?=
 =?us-ascii?Q?6gaimPMQWHzMlQq0cNi0XgWWQcrNBc4pfTTObzQSvTpYYSW/ZGiLyH1B8HQA?=
 =?us-ascii?Q?q4k14QkttrHgYHK1izmFrtqFy7198DblWQWznm4dJ9WGsS6TKX9ULSfsZL9g?=
 =?us-ascii?Q?MrTKE7wEc4vgQcbmc6O/vgOlaerYaoREMpjhYL1vvtTsUPfsvXNdXJgMuRkE?=
 =?us-ascii?Q?zfueoBB22rlOK6WOVQ2IA7tdxUjEyorNo927Hy4G6ikkjzp7lMsUZvzxmSyf?=
 =?us-ascii?Q?ZJuKzoRDbfnT6qmwdxBEoJKvg4SEAuT3Q/3uIOaH2CnssODUfDQKQxGhSMvD?=
 =?us-ascii?Q?0kZ6KsVIxLS/uHZHwxSwAf53xh4U4olIDiZmMAPrD0wb8m16pg3ne211hAz+?=
 =?us-ascii?Q?Y6PeGg2Jx7bNXBVFZ0QY5k9Xf2iSeETgdm0mjLqmTm/jyGe9ADARwxw9yhnd?=
 =?us-ascii?Q?oulyIaoKSbPhpP3+gd3xWHJfcxTc/D7xXGro7yN5YHkDnbaDEbBJbsQpupje?=
 =?us-ascii?Q?Ifh5iTaLdUEJ3K0T0GWYlgHg2wTH4eAR/q+hdlZVgV7hkEiJMbP5PGvu4kf3?=
 =?us-ascii?Q?Z4OgvAs2e3Ce3/Qpy5wsowlyLQJtJi9NzE82TpaoxzyUogBLQabrAg+E52hK?=
 =?us-ascii?Q?zR2Anv5flD8hdm7wESjHY/Y0JM8i8B1UsGJw3PPFvbs5nyEFNy4RUqhAq+Tz?=
 =?us-ascii?Q?wtqTEPvZXgMS0JMAMpTggyplnzhMayNflNetuvUtfRkre/VXyGWVwsmaKeS1?=
 =?us-ascii?Q?oOd1fWipCNhPkWS6FMzZkvA2qElhE4qk1vPB61J35I/NZbgKncnICKxIaU0b?=
 =?us-ascii?Q?cLGtVFkiCCaYN7jMel+dS2kZEhd6yXg8vJSxPIwp6cbE81Tf7x4vUGlTQ/4j?=
 =?us-ascii?Q?iKFoNPhzff5wtJoMYpme8anBCYrqBpS4RCr4bIN1QDiKpcZd+IIccSrrxQFC?=
 =?us-ascii?Q?3XzcZLqSBj+i/9tHL/3JEnez5gYRW6sGAjsP6c4G3Qh66gjWke5rhMvEMRK8?=
 =?us-ascii?Q?SLvGa5oEmGi7k+nFygS0dkEtQ5TcDYJUzVPqwFvah50/NCjf5U4qrJT7XQy9?=
 =?us-ascii?Q?Z5vC7G376pkyQ0HB8DuLoPhrQ9HzVyJMiVVs7fjSacy9zz3EIC3A1+X8+peS?=
 =?us-ascii?Q?7vG1urVx54VTFrH//L1TwlPV/T0LC9GnzdiK0Pvl814m22lDXPokozwoRQWX?=
 =?us-ascii?Q?icoWCgJsAY/SF7x2HHRmlGVzMMT0Kpjq7Un73kPF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EEV5t0JjpAD36OOWdtLEyW/MV6VRng8+kRaLXQSr6w01z4hWIOzMqF5c1pqzQzYMgdcU01c8fagDAJr9q2Rky7qFHuVX1HCe8ArlL7jMcIfhG6n2RT3Y/BmwKJQbDFPl8ot3dTbWKDC9bVoHmgb23MlSQNQYwvCKuZII3JyE94d45oQDK3Us9XuVWme28b07IBgoYse/TzTxNNzND6GQFuEd68u3RXG+rj+o8nXJawnFR0XunZw0Oh2ETYZ17eUy1Xjh6J1yBuAVZFL3NtNaIFOeq/ehIqblQ/rGKCMyGiaZEsdfE2916rd8gwi+xhLkkWp9MV5hgIAvcoj2DEXI7h+VUxfqMjHVe9vgd6NFcZWaLWznUJgKA3JvbC2VbIIL93kzQP5MykiicxVYB/I0ywUk+XynxQ/JXTk9nTjuc7nVXHTrawOfqfeG5KZG+rI+vK5/0rU8Om+3t57WEQpV8zUmUJqNbzvFXT4+KgRXhY1qug+oQuxCdT0nCi2oJ7aPPG8A6J/e3Kz5IaWhvVvsMt54eGcHa/8/TWReue6dd523wSeKHBwApjaqQhTQTPcLbVLiEN/jrSP85eqCrAMdjwKxiJDudJ5EOr2oqm+NQF0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ee1a86-e1dc-4d28-ab27-08dda42aebf2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 12:17:21.5155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +L+ILYwmrXsnh4IcfMqUIpS6l9L+AQr/ORS5WD0i9zEu5QJck9DvlpbR2ofbkGSi8AOtyW79vrKjjxhgQnetSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7829
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506050104
X-Authority-Analysis: v=2.4 cv=Va/3PEp9 c=1 sm=1 tr=0 ts=68418ad7 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=SiqW3_QkAAAA:8 a=tAuyAf1UAJeO3xpge-0A:9 a=CjuIK1q_8ugA:10 a=0-oVHmElw7bdUHZZ8WX8:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDEwNCBTYWx0ZWRfX7FnqCvIAxeXt ai4A01vb/92VYF9a/i20/z7qikh8ofQ/pq50pKWSNa6s90qQ5K0Ltqc4AriEyKu/Xqep2+qPT88 XVhTGujVrLnWA5H4UmygmikUaSz8RBHxFnsq+tp+xcGUq3jMN52OPIgjmYa+XNpk6QR2rkpD//4
 ewGA79JTqNlc2F2VcjiZwvB5wJfFr+2IRdcrkL3+axwyWsNHSUIr9JQxJTvGCLvD9i7blms8nZI tQjuddjUJdCtja1qtIYxFlArkOl71rTcbpqdMcnDksFeSZQ5UInA10qXaEWdYsJnlSr7u0oF1qg Jd812WzCifVh0YBKBhGw0p4vyHE4B+VIAhta9TxNw7M0Rq2QP7PUHDUZ1m3wwgKdj0736i4GwXc
 z8oU9BbU5awUOJ9MAayXnxOHXDYzUJQbbD4UOGwJ2MIZ9Zl4fYl2c3PDCBy+gieta/A2XHPt
X-Proofpoint-ORIG-GUID: xeAv3gjByJqk_wk2Q_FF-bcQEQVS08gz
X-Proofpoint-GUID: xeAv3gjByJqk_wk2Q_FF-bcQEQVS08gz

On Thu, Jun 05, 2025 at 08:49:07PM +0900, Harry Yoo wrote:
> On Thu, Jun 05, 2025 at 11:56:14AM +0100, Pavel Begunkov wrote:
> > On 6/4/25 03:52, Byungchul Park wrote:
> > > To simplify struct page, the effort to separate its own descriptor from
> > > struct page is required and the work for page pool is on going.
> > > 
> > > To achieve that, all the code should avoid directly accessing page pool
> > > members of struct page.
> > 
> > Just to clarify, are we leaving the corresponding struct page fields
> > for now until the final memdesc conversion is done?
> 
> Yes, that's correct.

Oops, looks like misread it. If by "leaving the corresponding struct page
fields" you meant "leaving netmem fields in struct page", no.
It'll be removed.

> > If so, it might be better to leave the access in page_pool_page_is_pp()
> > to be "page->pp_magic", so that once removed the build fails until
> > the helper is fixed up to use the page->type or so.
> 
> When we truly separate netmem from struct page, we won't have 'lru' field
> in memdesc (because not all types of memory are on LRU list),
> so NETMEM_DESC_ASSERT_OFFSET(lru, pp_magic) should fail.
> 
> And then page_pool_page_is_pp() should be changed to check lower bits
> of memdesc pointer to identify its type.
> 
> https://kernelnewbies.org/MatthewWilcox/Memdescs/Path
> 
> -- 
> Cheers,
> Harry / Hyeonggon
> 

-- 
Cheers,
Harry / Hyeonggon

