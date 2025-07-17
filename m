Return-Path: <bpf+bounces-63593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6D0B08C29
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 13:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8E247B5CCA
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 11:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E367B29B8DB;
	Thu, 17 Jul 2025 11:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I5lWOEVM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XQ5FnmkD"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D012BE030;
	Thu, 17 Jul 2025 11:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752753160; cv=fail; b=DpM8a8qpm9c/jTv7XtRxLo1yWd4gpFsHwrPob7PQB9HvwdeeYqigmzr8y7jsVeI4yYq9e/4HjshI15G64D+WSBncLYOUQKIRL5XuOP56jHOLZ5waxGnZzS4FXiSyfiIc4EKv6hpNVszStN9+m1qpR16TA7Jdiwf2U2t7FHXNmGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752753160; c=relaxed/simple;
	bh=ky830KkTjagq+MbODTmNui69dalICnYZvnM4LnX5+fs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 Content-Type:MIME-Version; b=DCSzLbr/ZqE1MEfo6TX7zMicm1KLyzGiXzxFiH8+yTgBVGR00XQHFSYW+L9kiO2rZMQHrVlcVL8mMETdtS/in2RWvbs3M67Y1doUoscltD+U6MdRN2v3Beuco7OvVcJxIcpVzSaxHNxD7P/QmtEFTL47x2PLV/uyoEirNRkRVTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I5lWOEVM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XQ5FnmkD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H7gTFQ011137;
	Thu, 17 Jul 2025 11:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=qGGRwkjnqGSd+AYOby
	XJC8+WrUHtB9HIuB3MD14vMOU=; b=I5lWOEVM0EGZ7Omlod83lqToqHglDh9wBf
	ifI1IlyMVA1ooC3e50h9VyxSqRy75zoAmGyEfdRKB2TflTnC7u8tskID+e9ChEgf
	kxdODHtdJuriN9xo+GJhZetqFOG89Mcl9+2k4gRbIVzN9CqDjPefMduKDhOeDgRm
	W+gLrHtSb21eT1ElehIPyyd+W2mxVWz4e3KNyBxKq2k35F4DyTyKKmwgKxFTdjZl
	7m4Iuv6Ij2GCW1qlNnqIywhlm7mFoN+24w92wihKomJAzynMw6dEEXwxC/exsUNO
	yXgbnzIF30b8+UGwnLONGR8V7emQ83uENj7OyUHy/ds+zZoxV4pA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhjfbcqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 11:52:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HAdNmT029654;
	Thu, 17 Jul 2025 11:52:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5capqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 11:52:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7hqIXUjRazCwWZ03XRWQgHoNpKUyz51y6lTurWqt89g9oZtvny2FvS1o3x2SZJqYghLJUtTMsOaZnrU0SaOrfSsEygmNAmDs44llX9/Zrw+8TKqewmdW4d8Gf86kwvkRtlnDnHsDIKNsMmxp/6VtUWIR2f4vrOhAkKlQO7K8mbUezPp5CNUcXHCwyVK70Ca6oB1gsrVOluJxvn0e63JC5JXBvCBWRA/i/+OSZqyxI8txa9K3p9IIKYfDT9QW64KBZSiuhqamN62xJam1TxUBnCpIfWpnBqDHApYGGZtVAGRxiio4/disYxzNFeWJh2RMgPJh8g4XdJcTaHEnHZ2xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGGRwkjnqGSd+AYObyXJC8+WrUHtB9HIuB3MD14vMOU=;
 b=VRC+Pgxg414vQtirXHYl4CfPAFpdgPWnmgy6iYPXCFwveCdWN2C4JAkOVrRwzFVM9xMoV5w+rx8/Cse5zad127ULdGEjs7v8NRdiYHOGAFxyNCGdm4Ybqcz+BqeQUcvKK8m/yr98vScy4N2BAgnEw7waU3t9+kNrOXD/y0ReDTUb5yaN6Jm6PeeE96UOtyZ57IqgS7SOb0g9O9d+cuCsFRGVvU+EqcRnrSNHaWiUD/0C74Pw+eE1Y0aTED5cztdGWzClri8qfwMO0iETEEF3mFzjIk3fTJeVHGxQ8S1rZbQGqPNqGeqo7VxTnW2d0IkI5z9wQGPlbbGZ8a9h9L9+IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGGRwkjnqGSd+AYObyXJC8+WrUHtB9HIuB3MD14vMOU=;
 b=XQ5FnmkD+1kjpEaXUa+40B1P4MFNIkGubAXvotMTpzUA41KPQq3P/QFnoFCEnNJfgEMvwFBz8pW2aIDat5fgujbiB8aVtGSKAHQ0uTyDxsIQl3ndpYN873ZnFHeT/T0JRpzOeDo9+lu+3NDawWOGLO/ZnI+362rd22onL9xc0es=
Received: from DS7PR10MB5037.namprd10.prod.outlook.com (2603:10b6:5:3a9::23)
 by PH7PR10MB6602.namprd10.prod.outlook.com (2603:10b6:510:206::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Thu, 17 Jul
 2025 11:52:28 +0000
Received: from DS7PR10MB5037.namprd10.prod.outlook.com
 ([fe80::824a:572e:d9d7:e9f1]) by DS7PR10MB5037.namprd10.prod.outlook.com
 ([fe80::824a:572e:d9d7:e9f1%6]) with mapi id 15.20.8901.021; Thu, 17 Jul 2025
 11:52:28 +0000
From: Nick Alcock <nick.alcock@oracle.com>
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
        Nick Alcock
 <nick.alcock@oracle.com>,
        dwarves <dwarves@vger.kernel.org>, bpf
 <bpf@vger.kernel.org>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        <alexei.starovoitov@gmail.com>, <andrii.nakryiko@gmail.com>,
        <alan.maguire@oracle.com>, <stephen.brennan@oracle.com>,
        <david.faust@oracle.com>, <elena.zannoni@oracle.com>,
        <bruce.mcculloch@oracle.com>
Subject: Re: Linking BTF
References: <87bjpkmak2.fsf@esperi.org.uk>
	<5fdc2316c63b27d768503f056771ad6a77c803b3.camel@gmail.com>
	<87wm878dtt.fsf@oracle.com>
Emacs: because Hell was full.
Date: Thu, 17 Jul 2025 12:52:26 +0100
In-Reply-To: <87wm878dtt.fsf@oracle.com> (Jose E. Marchesi's message of "Thu,
	17 Jul 2025 09:40:46 +0200")
Message-ID: <87ldonkpad.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0185.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::14) To DS7PR10MB5037.namprd10.prod.outlook.com
 (2603:10b6:5:3a9::23)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5037:EE_|PH7PR10MB6602:EE_
X-MS-Office365-Filtering-Correlation-Id: 37a137ac-aeb1-4e43-aaf0-08ddc528679c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z0z7wozM1VWZ2gbkFuOUsuAaXPpeAHcrEi445RmbEzF/WzfQ3TXaa7XHuvEW?=
 =?us-ascii?Q?txMTJUburKiThYrWEKMEawNdF6WG05czuLsR3B3ZbVx3sYvT3W4dOAUfvU0i?=
 =?us-ascii?Q?CgZk2MR9ZUGbsRAku3MLlSaJJzJ8fd5HvA06Uggdx6Yx2fL2vVlYlTMZAFJh?=
 =?us-ascii?Q?akzhUoMmNFc0KGcaR5MKH23aFMPQaqOS5BafST11iQV1guIBvmb9lgyP6jQX?=
 =?us-ascii?Q?1Y0io7/7A/3oUipVDhVavno6zmgo5S27s1cuyv/UFx7tZsjMfmW8i81K/WRq?=
 =?us-ascii?Q?pGKS9uBGuJU2W+Sx8Sl2DmtZjT8WLlNeMQEsM74D7nF1UTkrp1nTZM1Zj8c8?=
 =?us-ascii?Q?lstGrq+9TZ3BRv+DEBSZF9uVrFR079iMB7ZKEeksz989DjoQ+itnpBU0GVdj?=
 =?us-ascii?Q?qat/7Uk1+kV/UN62bp8GUwo+BOPAErNDFBI6bOvhC/uORfahsGeY5lQf73uI?=
 =?us-ascii?Q?Q+aPV1thDNeNlSPG5Bb3G/o1KA/ZE3LFxRec7IFut4cPkBeS5ikHeOYvplPE?=
 =?us-ascii?Q?+EZPn0KcEE92fjbEQcR8wZWcyVivvWzp2KD1qdeGFFWXxhEI+NuRfg/uBktn?=
 =?us-ascii?Q?AeV1c/g/PhVpSeG9h3gVn4RUyikdVvacDAWxxXbTPmgOPZwpG0cbYm1vJOb1?=
 =?us-ascii?Q?1WGn+WDd7lOcrPHrBwYeGadLMkcvvFyT4p1oMAk9zClN00sj9gyVNw0zZoap?=
 =?us-ascii?Q?w/X9S/tvYkwCaP5pZ+V73MKwfdmDy8xtYjdWRWyz+p2CgY/QUzgrwi3lJFly?=
 =?us-ascii?Q?k+bjurPxj7FtsZx1DJijsPWm7xGa8kPfamV3dCQBTjMZ2tW3jfqJ3hu0JYjT?=
 =?us-ascii?Q?pfgsEefBWq21+N6RO8fJuDmtNf3/vp7svK/9b/+7QPKct+vbZlR5jPH+5jV8?=
 =?us-ascii?Q?+TTga2vCWP98uQ6S9btfv+O7bHAq14Bg/XEjprbGOJiPjmZTSw04bGYlyo7s?=
 =?us-ascii?Q?qtzYTJ5zfFGy2xYJMIH04XJMDk3LQYelU3ut/2kOFiLU+W7ecrHrvJrbhuLe?=
 =?us-ascii?Q?vOwbQY2Nec0LH6EP2wW1M1Bpaux3LYK3KeGLMc1x8rdfsThBBaUYJytU4v/o?=
 =?us-ascii?Q?Vhrw5Q/46fSyIWB81DQAUCqNlsVYlk/bqs8iE9Q1c2Yrssu4wxrB+PQSTut4?=
 =?us-ascii?Q?3ovgp+2uWqERBu1B3NTY0ZlzZxa2fB3PEubG2/G3NilB4BujmZC9lq0s1GNl?=
 =?us-ascii?Q?qfkbVxuDO7KgRggP9vJHR+nFPNgbrr4gQ9dfPqBQkGT1xyCH7oIjuKDZoIlu?=
 =?us-ascii?Q?hH7jAq8Wr77YmpUMwmdEdfabsD0Z2eoR/6+HpIXMzWCZ5GWufazVRrj0jA8D?=
 =?us-ascii?Q?WBuJfZLQYp9kSdXbNvQ135qugoKl1FNqG7g9i0YfdTvUp/ymymNejWzgmOuK?=
 =?us-ascii?Q?9wwhdZ41J1Pj1gCZxFmqhegD3WT3BIsY2iirgDMrrPucDd3onkN9leeR/Rw0?=
 =?us-ascii?Q?ll28BhkROSI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5037.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5PEMp8GnF8Y2azoxU3ThL5M3Op5hbEF7gza2Amkw9OtJsBvqnIFvawRE17a9?=
 =?us-ascii?Q?KdocHbb8Ia8JKejcPVsLc41Hb3MFPdNT97Q1tr0HJFFHYSq6fwPbxgFqv3Bu?=
 =?us-ascii?Q?skw6QH0fk6ps9wwc8NjbTuvJo4vownUvtJJBJ41RoUaLOGyagOLmTVi03YX5?=
 =?us-ascii?Q?2ShX6jh6NfWjsLcgsPrGZD4iIWXtxr1bEVAltVJz/IBc1uAD1EPuj6usKVkj?=
 =?us-ascii?Q?GB40schsqqf1LxdkX0AqHhvrAqX6necHmCqACuyB3QExaOqAW8KQ902Rpvya?=
 =?us-ascii?Q?0+rAcZumXyqjBFORnQbL9Rt15oiIcfDzfpQWPoqcf9z7aweQnEH9SQ1568yE?=
 =?us-ascii?Q?D+Do9UTAoQuy5CSufG7n4ni/4aW0+BHSWZIXJKPHAi5HuzTcwxY0kQEt19RC?=
 =?us-ascii?Q?6gA234UrNpnFU87DXPncRO/j1g2YiS6GEGEATLLWKQik3igAaJ1iJryMHo99?=
 =?us-ascii?Q?8/VKYSKlfSkTGSznSP50c3RTunFH52C/fV4KSpIRYlGdUxYkj0hVWFU7mwvE?=
 =?us-ascii?Q?zfnKqg6c6FqSydcrUPhOVb+G3PKOOuG+VfA7mVJ8z2x8oM+TjeyNHEC86TfR?=
 =?us-ascii?Q?zbBHHboX7sK1APpXL0sGtwit4z++GCKu8Tqi/DXESRWaC3CeCaIrAiXykea2?=
 =?us-ascii?Q?CVZAQh68Nf3nR6WxlZQB0LYyvzWE1dvGw20NNx/xQbw1TQZtdcJyyzdtFY+t?=
 =?us-ascii?Q?/OeZe0ZaVi0ZhgLJdwjs42GFxuZhrOWX97tqauISkzzovP47EyY1Nke5o/Dy?=
 =?us-ascii?Q?sKqWsdlbCYjpXv2jpx2PE2Khs/XniPFXwzjF/k3YitzJBKC5iSPlbkkT5HMK?=
 =?us-ascii?Q?FuRPDQXD7kCDrCDuDkwFJyeLyUqWWpjOZ2WbYyGvqwhfXFdn36iqaK5f1Bpf?=
 =?us-ascii?Q?lvKbZG75V/APIUpGk6aEnt2aGVHQv+f01jsB1DoYhhB4Vd01fhhVHsnI7RXg?=
 =?us-ascii?Q?bXiLLgjnQ8uehnYSw89zsmTpakeDI0YHal9PFLRxWNMqseUCQnzOkT4Hknal?=
 =?us-ascii?Q?gTdLX+G123E/0CNHJxLF2UVFu0Ly/ZIpNu26PmFAzpmUvP0+9Bundy3u9r0q?=
 =?us-ascii?Q?uL2VliNd8R7NNCj24hBOL7jSL+eiSvkUaF94ux1OTihGtpU7IPbAEZzBov4A?=
 =?us-ascii?Q?LWWWBT1z6cpCcCrfoZxUh9fDaVOdQL78utVRHEbLmwoKu345ABqg7njDphw1?=
 =?us-ascii?Q?52L2OoKLQmzHtZEq2XrN/DMsc805nZMEQnA+neJYRg6PBDr255IqW8h0xRAh?=
 =?us-ascii?Q?bJMVn4oaPND+3SpoPSbu7Iq8dZhKsi4JDbPhGeLs3NXMaHYvHn5keUzccy/j?=
 =?us-ascii?Q?woi5q5gWo378o+tv5+oS4LP0I1K5YLBoLt7Y0VVg9WkMgn+zzF1ETy8x2FZU?=
 =?us-ascii?Q?3zvi0Tu0p6NExIRQORNxgMrXo3GLGHoaw5VyDioG4+vRZ0KWIza+Cag7gbpa?=
 =?us-ascii?Q?ZQ/XqZDrqSCk6q3se3B/9+MAJEcAGp9xd7iK+1885YhcGWa6s3eCsXg9ZMFO?=
 =?us-ascii?Q?pkw+iG340PsSXHmCKnq01Kju6/2ArhpWGT5k1MqHJuD8w0Wj/p+dNcoid3MY?=
 =?us-ascii?Q?XBeS5SpQHBmS9RySYN8fXStKwfH1mBRzVxhrb842YB3jguuK/0CiQoX8fpR8?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rIgy2i+kCwtXNiGq4v6ZD90RoFfTHakXn0utiX3XnYSX926sYDZx3BU3DchKtiDDB/16MQP/JntSgGcLaZ0qEIIp3d5uClaGsE1OmbO65pPFXdm4t3e3c5Priy/tkdMhWNv8MGNGFig50J9lpv39qsWGy3/tOl4FCM3Zfsrt/kvy6ig236p78v+eS8gvMuRkrTKVcZzQxgULbSdXaIbtBMPkZ/oVvSglB8IqAdeWsRZIAKsJV4ERnz6YrmnQ437iuKQITejbOt3aCsNMradNqgN3eYfSxX1pkQZxCqajSa8HJsoQlDxjOPPV18uhNnTRIaXtaNpzXL7DmHorV+7fAOHQmCNDsCC0bPl+8q5GrKPFrQTszNW151ySFI0bKWayTgTaIcD5Kj9jQIBfUQWjbmkOp0FhixagkZLnffYGcVYBTeIsUDsz8ydrSvzo/kAfYLaVXE+XXQfnmJqYCPzlci+eqi9vnHvQO+VmQiDivIiFPwRultiYM3VKNZN33KaRQ/9tkODJOH+OwymoX+dm+99L0ZyvNJyyO1f4zNMCxIXvKEXXhUlYealegt6itS6rrcaQmZpDm+NC/TjeXQJbmK8teTvfzMTVWHWtvZvpl8w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a137ac-aeb1-4e43-aaf0-08ddc528679c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5037.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 11:52:28.5563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qXbz+9weiUwBcWUZJ1hEQBWLOtiW1kG9hp+JoVd2wI1ooiBAyEq396RNRNFSeFLFWBpDxDUHw25FDckk0njt3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6602
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170104
X-Proofpoint-GUID: M9AiPs9N2fMGrMQSbcRxwfsAlQwaOI9g
X-Authority-Analysis: v=2.4 cv=O6g5vA9W c=1 sm=1 tr=0 ts=6878e400 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=4P9oCMlldSTgEBlRx-AA:9
X-Proofpoint-ORIG-GUID: M9AiPs9N2fMGrMQSbcRxwfsAlQwaOI9g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEwNCBTYWx0ZWRfX2uJLygjsnzvY jjkOOYT6Rx8IkAMRcacqPFkFOIOOixPEmJuISbfLjByoJZfDYIlNx30urqncM5UzjSg2PQN2nGT KwwLDnwmsnwDiLrSIEUqCjM8aOSTXZTivtznrvNRfpeihXJiIDMUTgdzY3nOOO0G1W9+gS+xs05
 Pq5cjVVtBSZ7TkTRW2lGmh7rkWtK5BJF14D+94uvGSx3QAfjqHX4jLuYG7YkXSdthKiiCCm+9+j QXo5C13H4GEpGtEgdIgHBXi1dWIksHVL3O8c1DSFynQD63MShtCUV0oLBzP0ZDdTcLSJop7G4j7 hwGvHARH0qsnGzkMulkSUXZxjbRuoC15VE1xortAXxoPh6+JQc3H83hrI3/Mqlj2VZI+IYNvJDm
 IZPESB4a8DugAmaOP/0yzQaM+uBhEtMyE5v0JPx7t0VBzp0IbmRQ+YJvRXD50DgEncgeaCLJ

On 17 Jul 2025, Jose E. Marchesi outgrape:

>
>> On Wed, 2025-07-16 at 16:15 +0100, Nick Alcock wrote:
>>
>> [...]
>>
>>>  - So... a third option, which is probably the most BTFish because it's
>>>    something BTF already does, in a sense: put everything in one section,
>>>    call it .BTF or .BTFA or whatever, and make that section an archive of
>>>    named BTF members, and then stuff however many BTF outputs the
>>>    deduplication generates (or none, if we're just stuffing inputs into
>>>    outputs without dedupping) into archive members.
>>> 
>>> So, here's a possibility which seems to provide the latter option while
>>> still letting existing tools read the first member (likely vmlinux):
>>> 
>>> The idea is that we add a *next member link field* in the BTF header, and a
>>> name (a strtab offset).  The next member link field is an end-of-header-
>>> relative offset just like most of the other header fields, which chains BTF
>>> members together in a linked list:
>>> 
>>> parent     BTF
>>>             |
>>>             v
>>> children   BTF -> BTF -> BTF -> ... -> BTF
>>> 
>>> The parent is always first in the list.
>>
>> Hi Nick,
>>
>> You are talking about BTF section embedded in a final vmlinux binary, right?
>
> More generally, a section embedded in any object which is the result of
> linking two or more objects having .BTF sections:
>
>   ld foo.o (.BTF) bar.o (.BTF) -> baz.o (.BTF)
>
> This covers the particular vmlinux case I think.

Yes, though I wasn't expecting to see this in vmlinux yet! It might
happen in the end. What this is used for is *communicating with pahole*:
the .btfa file pahole receives is one of these, containing deduplicated
BTF for the entire kernel plus all modules, and it's then up to pahole
what to do with it.

In userspace links (and in intermediate links of multifile kernel
modules, used only as input to the btfarchive deduplicator), we do see
this sort of thing heavily.

>> Could you please elaborate a bit on why do you need multiple members
>> within this section (in the context of your third option)?
>> I re-read the email but don't get it :(
>
> As I understand it:
>
> The linker deduplicates types in the set of input .BTF sections.  This
> means that when linking foo.o and bar.o, if both compilation units refer
> to a type 'quux', there are two possibilities:
>
> a) The type 'quux' is the same (using C type equivalence rules) in both
>    compilation units.  Then the type is "shared" and the linker puts it
>    only once in the first output BTF member in baz.o .BTF, the "parent".
>
> b) The type 'quux' is different in both compilation units.  These are
>    then conflicting types.  Then two versions the type, foo.quux and
>    bar.quux, are placed by the linker in the corresponding "children"
>    member in baz.o.

Yes. (We don't really quite use C type equivalence rules -- we're
pickier, since types can be assignment-compatible but still different,
and we want to preserve that difference. But that's nitpicking.)

This happens really quite a lot in the kernel (I was surprised how
often). It happens even more in userspace, sometimes to an almost
pathological degree (hello, Ghostscript). LTO may make its prevalence
lower in the future, but I doubt this sort of thing will ever go away:
it's still with us in C++ programs, and there it's outright undefined
behaviour!

> Graphically, the .BTF section in a linked binary would contain a
> one-level tree of members, with as many children as input compilation
> units :
>
>     parent (common types)
>       |
>       +---  child1 (types only in child1)
>       +---  child2 (types only in child2)
>       .
>       +---  childN (types only in childN)
>
> Hope this makes sense.  Nick should be able to explain it better than I
> do.

There are really two cases, because the purpose of "being a child" is
sort of overloaded. The kernel is, as ever, different...

- Kernel-style builds (the traditional BTF case):

  vmlinux (parent) (common types, any types shared by more than one module)
       +---  child1.ko (types only in child1)
       +---  child2.ko (types only in child2)
       .
       +---  childN.ko (types only in childN)

  Notably, if a type differs (conflicts) across translation units, and
  all those translation units are in the core kernel, we can't put them
  in children because none of them are in modules, and children are
  reserved for modules: so we actually emit them as "hidden types" (a
  concept BTF doesn't have and that I am not currently proposing, which
  lets us say "this type is not visible in any namespaces, here's the
  name of the translation unit it was found in"). The same applies if a
  type differs within one module.

  If a type has conflicting definitions in two distinct modules, we can
  indeed just emit them into each module in turn. Also, if a type has
  one definition in a lot of modules and then a different one in one or
  two, we realise that the first definition is "most popular" and emit
  it into the parent, then emit the conflicting one into the few
  per-module children it is found in.

  Types that are used only by one module are placed in that per-module
  child, both because that's what pahole has always done and because it
  makes sense for a loosely-coupled project like the kernel not to
  clutter vmlinux up with thousands of types for huge modules like
  amdgpu that might never even be loaded.


  I am not expecting pahole to preserve hidden types, at least not yet
  (BTF has no way to encode them and no consumer understands them), but
  it can see them on its input, so it might use hiddenness as a flag
  that "hey, this type is conflicting, take care with everything with
  the same name" or something. The concept is not useless even if pahole
  largely ignores it: it does at least preserve the type graph and
  ensure that any type that refers to a conflicting type still refers to
  it after deduplication: it doesn't end up pointing at some other type
  with the same name.

  e.g. if we have these two TUs in the core kernel:

  a.c:struct foo { int a; };
      struct bar { struct foo baz; };

  b.c:struct foo { long a; }; /* Different! */
      struct bar { struct foo baz; };

  one struct foo (the least-referenced one) will wind up hidden, but the
  struct bar in that same TU will *still point at the hidden type*. Both
  types are *still there* and we don't end up pointing at the same
  struct foo from both struct bars.


- For normal ELF links outside the kernel, the model above doesn't
  really make sense. Most programs don't have a concept like kernel
  modules, and most programs are more tightly coupled, so you want to
  see as many types as possible. So for those, the distribution is like
  this:

  parent (all types that are not conflicting)
       +---  child1.c (conflicting types defined in child1.c)
       +---  child2.c (conflicting types defined in child2.c)
       .
       +---  childN.c (conflicting types defined in child3.c)

  i.e., conflicting types are placed into children that are named after
  the translation units they come from. Within those dictionaries, there
  are no hidden types and there is no possibility of conflict; the
  shared parent corresponds to "all TUs together" and there can be no
  conflicts there either.

  In many ways this is a simpler model, but it just won't cut it for the
  kernel.

We could in the end combine the two schemes, producing a multilevel
tree, so that each module, and the core kernel, could contain an archive
like userspace links do, with each conflicting type hived off into its
own translation unit. This is *definitely* more work, and would probably
require consumer changes too. I am not proposing it, at least not yet.
But it shows where we could end up:

  vmlinux (parent) (common types, any types shared by more than one module)
    +--- core1a.c (conflicting types defined in core1a.c)...
    ...
       +---  child1.ko (types found only in child1)
         +-- child1a.c (conflicting types defined in child1a.c)
         +-- child1b.b (conflicting types defined in child1a.c)
       +---  child2.ko (types only in child2)
       .
       +---  childN.ko (types only in childN)



The distinction between the two link types above is largely controlled
via this linker option in GNU ld:

  --ctf-share-types=<method>  How to share CTF types between translation units.
                                <method> is: share-unconflicted (default),
                                             share-duplicated

The final stage of kernel deduplication (the btfarchive tool) uses
share-duplicated mode (and extra stuff to smush multiple translation
units together into modules).

(that's from current upstream master: obviously I'll have to find some
way to say --ctf-or-btf without making it too verbose :) maybe I could
just add a --btf-share-types as a synonym?)

