Return-Path: <bpf+bounces-63577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B99B08726
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 09:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 135E13AF186
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 07:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E72C25393E;
	Thu, 17 Jul 2025 07:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hRpSEczG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OAzLm+QO"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703711C8603;
	Thu, 17 Jul 2025 07:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752738075; cv=fail; b=r6u7/9SmwCVVsPeWSeN0+7SqGJsyqa/qBnmktVm20iIqrVOpPmFCGzFb2xu6qlXMiHQ2AvMb5c1k69AnU2qr+R7TuYbZlTQab83vRXe3AyUL3psR61iw1lCjy2WRmu1nOfTv2LlzyfsLjIZaoPjSVwn+dYE8LIzBboTBKUGd8BY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752738075; c=relaxed/simple;
	bh=NFWiaDKIwAxrT9Vmd+Nuru5POqp46MXeSxqiQxuYCjk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=iIqAT/4ekVCjXAuGpetTAZwf7qTCOm80SnakLuUojFLvRWvFYl0loR2tynUwyui5W0qgMUwveFWLu2l9XoZmyCf9H1ef/nkJjW3+OPdR29g6RWYpJp9BAG+OgQAVjKTLly0E+/Ni4OKPRg1jrigi63IDalU1JbljylJb3BbU3tI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hRpSEczG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OAzLm+QO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GLfm1B000918;
	Thu, 17 Jul 2025 07:41:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=HsfiQyeEOD/VoDIGr5
	CE9Bg5pN3XfOnspPsW4QsKIBQ=; b=hRpSEczGbj9W/em3qFUQxnBYiBwp3ef61S
	mdABbesCLLBtLBHqg0mQLtPEhZufhtnEkdpwI9t525Ytw+kLzkXp48gOekHV5qaJ
	ikLFXOoG9ZhrZ0VNEfEbz0ywm8umxwlmIB1Iar/rdzEIW87CDY/qzhYKV4wUsSx8
	BXFkP5un2OSv2aBTyObQmUzqavcl/G6azaXtibXGLHb1l1NJ+97Q1+XTUgZ9cS+k
	w6wgnxDi86+R8KD+cE7CiwgzLRRb6SPKCceDpdK+TJ+UoVGN7VjsOh8N9p/MpSXt
	0pCA53STScbEj0GmxMhk5jtmcq3raMVDA/xU8FACvM3b7YUlhoKw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhjfb0p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 07:41:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56H604Yv011624;
	Thu, 17 Jul 2025 07:40:59 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5cd0yx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 07:40:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gaG7gmRDkzQxsw/NB7Vh6wN1JKpk0VdoHk8p1Z1TOxqBIgSBG3XCoF3LjiIIZzOk1tcgWpZUeQVUcJAClqQpTiUqB2Fv0uXabAv0qi+yfkmIEPIN2+J1CXQU7iOxu0Ba71yyZ/HjyUCz12sFe+cN2Ix5TG6GW1smAKArx/2tv8f1Ls1ohHwHjBfVmfUcub1bco/JYylbk3KCB2UvPiRy3dqhMDW8tU8B+KFB8qutJasAET2oEzIsS9Ex7I5rd2DNBj5TOE1lkcwA835k1cnybjQ658scDbqL/c+uNYZoqgxs7Y4Sm/l1cpcNdh9Quj4CWrUkpMQTVaC62N0T1B+3Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsfiQyeEOD/VoDIGr5CE9Bg5pN3XfOnspPsW4QsKIBQ=;
 b=YsfCKZm282qIbIvopHt12WcZ4+s3UAfgMRBE0MKMpXGp5gpVuluFMHcIjz7h1LdnIt+D/B5yPZWMMItvux3Et4J8EX9AoXTYFUEUN0YguesMOPty4CIoOrqrmooPm4jeJf0EAypCCvfVGZTxga1h+NOGzbrdt2/eIu9WYC8iqkTAYjtgKFQb44Z5NU9HnONksR8wcRl1f44h5b8I7ME0jq8s+gNM1Hnl3hPyw0sMh+cIvFV0DLKmPwFT8Ll4B80jXFf2J4KbubmngNQOJoiFJqq6ns5P6rLT6X8htM8DeCI6n6cy3Sf4GGYroWzaC7otJ7sNY5siF/ZqYJczRQLXlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsfiQyeEOD/VoDIGr5CE9Bg5pN3XfOnspPsW4QsKIBQ=;
 b=OAzLm+QOdBVjZo+q+0knQr94jjlh8iPiCLti2UP8PBL9HMXgcF2ay2Saz1KH7vMXtbzGvcduvo+6SdEzS+ZH9E+BKMP2pce8ASDtb0Re8o1+AM9fmp5ncOGdodACbySqFqBR7OxFIR2XPX3GeSakm8vhbOm+xHNsaZQxuef45hg=
Received: from CO1PR10MB4500.namprd10.prod.outlook.com (2603:10b6:303:98::18)
 by PH7PR10MB6530.namprd10.prod.outlook.com (2603:10b6:510:201::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Thu, 17 Jul
 2025 07:40:56 +0000
Received: from CO1PR10MB4500.namprd10.prod.outlook.com
 ([fe80::f005:7345:898a:c953]) by CO1PR10MB4500.namprd10.prod.outlook.com
 ([fe80::f005:7345:898a:c953%2]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 07:40:56 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Nick Alcock <nick.alcock@oracle.com>, dwarves
 <dwarves@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Arnaldo Carvalho
 de Melo <acme@kernel.org>,
        alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com,
        alan.maguire@oracle.com, stephen.brennan@oracle.com,
        david.faust@oracle.com, elena.zannoni@oracle.com,
        bruce.mcculloch@oracle.com
Subject: Re: Linking BTF
In-Reply-To: <5fdc2316c63b27d768503f056771ad6a77c803b3.camel@gmail.com>
References: <87bjpkmak2.fsf@esperi.org.uk>
	<5fdc2316c63b27d768503f056771ad6a77c803b3.camel@gmail.com>
Date: Thu, 17 Jul 2025 09:40:46 +0200
Message-ID: <87wm878dtt.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MA2P292CA0015.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:1::12) To CO1PR10MB4500.namprd10.prod.outlook.com
 (2603:10b6:303:98::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4500:EE_|PH7PR10MB6530:EE_
X-MS-Office365-Filtering-Correlation-Id: 01d865e1-7a25-4f9e-a4dc-08ddc50543f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nQoC0H3QJNJZJwtHS4uyApyNswivW1dsa76eB/hGFkR2qZf9kCdEBU7c47tt?=
 =?us-ascii?Q?o4g59yGtzLgsSnryUbz+uaYYUiUULqmeC3pYWK3jsPZ2OBiB0MmSTHmNxUqx?=
 =?us-ascii?Q?91nsW9xacZ/OjCO+Ezx7aJY2+3MFk6sNZhOMQhx2vLz2F60XeFPzxz+lIA2/?=
 =?us-ascii?Q?JyK/0y2nimY5cMeASH9NZfykoYiOw/bt8PnT0Zt12i432B3+nrqg4zDGyUcq?=
 =?us-ascii?Q?XKR0ZgD1D7OokHO05o5kDYrK4WGn+3DMhv4zMrbi6USvJYOOOkuHdjYBHQJE?=
 =?us-ascii?Q?AsaVgNedbcQgJ5EP8Uhbskbvi3Kdr5hrjuS35f/u0kfjFW7+DIPuHxjBUPVX?=
 =?us-ascii?Q?HMN21Hkb0PzOlMCNdwgetM8KvSUi2FUJLjyH/7KQgia/IMCEjuaO72JU4Ym9?=
 =?us-ascii?Q?iYcTCe3XOeaZKcGBBcuryi9ECDP2E2NhJcZ0A5Yd68lkewlJADFl1txTsJ6a?=
 =?us-ascii?Q?bLv20f+nyHFxafLrXzUZdJCKGPWgINW5YS6c1j2DqVMgIVLKHYvz5imMNEeR?=
 =?us-ascii?Q?FkDwxY9vBQmL5lJSM8KxBKstyoNBBvmF8g2Dj0eZalKA5gP0Ous2+CgEP3cL?=
 =?us-ascii?Q?nmE569/eZZY9qgRyZUBG4xyUYWR26SCirsnwlgY0Z9g9xNMTNyHklt6YRJdG?=
 =?us-ascii?Q?05Qi+kGSRdT6A8WQA16CQMK7CzLRzbweKDZR2uGh1LdJRIvHVBnQRfforpEn?=
 =?us-ascii?Q?Z98a0OBz9Fj32ffYNLQh4ibX8e3UeWV6AMq9N+xaMTJtxhFoyXgtos6yXsRT?=
 =?us-ascii?Q?nua2QNBrT7NOT/Fm5xmxHH9D8Ul7AlFfethrIl1BnkM93eLqJLLGWMBFnjyq?=
 =?us-ascii?Q?4r0PKmKhrv9VZpLPHAQwxM9LcPBMgivt9oa9x2BGAy7KRaD7cM2xMyeK80Jz?=
 =?us-ascii?Q?nI/sOZkTjo/j9zYPS6iCxM0l+TkUkdgV1izdGrSU6Op2PY9bCZEXEWmJAM+/?=
 =?us-ascii?Q?vcU139YclEfXLQ40Q3d4RoBtohMMrLrGS23VDdcqIPVMOLHoAL+CQsLcqO0Z?=
 =?us-ascii?Q?3p4s33GWaes0aGVn9Uhsw+qNVzLWRlHu410ce0YVPY+axV7jL57AJSEclPq4?=
 =?us-ascii?Q?8EFMeT16EiZN04jC7P0Inowzy16rAnhUiYPQ5xw6UsRrT/vXrecGHIFOiYt9?=
 =?us-ascii?Q?7LH0PzkknpahRtv2BW6I43+aOvwKkX0hT75VCQBPPqVUJXc9fNnAe8TteHAo?=
 =?us-ascii?Q?Na3AplUipgQOz0HVCmpLbHFQbCeoyTX6sa54v5hqcUJ0tSfWFKiqs8cHNyEv?=
 =?us-ascii?Q?s+6TCjquk43TVgzUaFqUrCuvROJpkClmSOnpufgCkw6qEqFU9WbQgFQw+RxG?=
 =?us-ascii?Q?NiPd8LYk0GqLUwX/y21WIjYI1hWlc49DdJBe9HKe769J/7t17XHX4c40IXAX?=
 =?us-ascii?Q?PQdiwKi0D5d631yKzjXWtAm8mBWMNEM447wX/nRJmzR+hpkbkKCaGRx191JT?=
 =?us-ascii?Q?Y8HnxzhTZnA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4500.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gna1YixGm0YgWtrxTvIbTKmu6ItyP2xSE2JYgkigw0K9zvqKmt5wuj7EaDEK?=
 =?us-ascii?Q?jisyzZnZUIbHQEfH5PfyHtqKjJUbnjhqtNUkWCiNgMuhbVRoJQSsbWJsQaC/?=
 =?us-ascii?Q?CkDYHHC2QSKBkiWG4VaVe02pjMlJIOoOhlcCLM9x4gN4vRniZcuQ5iTrGYcu?=
 =?us-ascii?Q?EKIgddojJhKgWb3XOkxLj+Vg7E/Q7P5Z2IyRyok4c2uqY+uZiuH1oWjS4dif?=
 =?us-ascii?Q?lJQCsGnkl/Yx47ThHjsxgVgTmgbTZ031Cj1Yhh283c0+GQRWoG8O4OfB0K4/?=
 =?us-ascii?Q?T1K6xC6ZJh5Aeeae0OitvsL2QhXPr8qW0H/VKIj3msXFXv4Sl/pK5RbsaWET?=
 =?us-ascii?Q?QD7eECCbhgqN5Nx1sZmxxPLKsoT4JSAsNH628QrBHGqq5oWzy0SxjjsBbsLm?=
 =?us-ascii?Q?AGvLP+9nhkcnU0lWbO1Lq6AdgU9G2GxeMLlm6hXiufRPRrVvw545DoMxJII7?=
 =?us-ascii?Q?Cj0mAaFucPmD+Bc/FwSa11Dl4kiCakXpZyVCpKLy2C0iFvZjIRHQ/edEO5ro?=
 =?us-ascii?Q?Am1faGc0uo9q2Kdj0SRpy3OxUhAfEgdo+8k8LqeooJxuClTA2pJvkzb57B8m?=
 =?us-ascii?Q?LuybEK86csRSqJXb1tpBd1WSe1fVaAdvrdF5I6FWEz+9+uFdFK14JXdI8u3Z?=
 =?us-ascii?Q?a27XA3XZMzDh9F8gqBNDAdOHjyHF+i1QTv9wwKEnV8f/4W62xMTj0jU1QpBP?=
 =?us-ascii?Q?xCzwn+ueKDITnB0PHeBbzTrSBDoehUNC67WARycsh9i6WWhaRn7t3td0Ouqk?=
 =?us-ascii?Q?6vW57jFOrcTK465XIexbSEugk/LmLz2calxA4/OpRb/mKzeki3Tlro4G0T2F?=
 =?us-ascii?Q?NOUSiDA87kTYnDXtUB/Z6h5u8jSaQcg0ZqXYVJP1lCoy6B+7AAAiSSmfEe8F?=
 =?us-ascii?Q?vuhUTYxXJizbHGx4rD+neM3FsmOKv1dY9D0v54JdeMdYcxl1qmklAbeW1von?=
 =?us-ascii?Q?67XjKmdYtKSML86SdUaaXCu27lq0SdUeoLBbEe05Kto5JJW1mqx5lAjC3C7D?=
 =?us-ascii?Q?PDiglmJRVbCyGTEl7VXCs7shqWZ+kPrzWSaYCNEOzsxGvxXI5ZAAda8kJnfU?=
 =?us-ascii?Q?7KWhuRcyQOjAYrDTEVAROOxnX9ETN4G5CI9AbAFKQC7gkQP7aA9GVSJfMuFZ?=
 =?us-ascii?Q?EszHfi9MA+T8xjme1kCaBNlsRCZ1tDldvqjI4GUA4zLQOGvKUaQyFn7PSdCV?=
 =?us-ascii?Q?ar9Y1ruD7YFkxL9RavKCrKrF9ytcwIMPbEp4y4ZR6F2vqkJv4CN1i77EKXpH?=
 =?us-ascii?Q?l7MFtF334JflT2WHQWg8BUbw14kZYSq5JFizUdeN5Qj5u4A7iHwZ4QuSvb/h?=
 =?us-ascii?Q?dtwhUtQXOlOwie0FEss8XwcMyAL3U8WCyAleL3cSLO2lc94yMSx02RF0IVHY?=
 =?us-ascii?Q?R33wQExqOCJxDfEw7dOba+0U9xFSEBHHSaKM3Mgop8SSXYQ90L5sVYWwvPg6?=
 =?us-ascii?Q?wvcWycJ5JVvbgu9F1vQ0oliTDQabKW2M/TAQg5F5OB8wPy6nXEpb+0lNpjs+?=
 =?us-ascii?Q?V7LXmiOVmXAAMdSvYLU8mZCtR/REvN3nP0QkIHNm8kFXsfTmNIuYzO7zoI4M?=
 =?us-ascii?Q?yQ0FNyLHX6z7fZN/X+ab6gwsI22A5v0USr9p3YwWpKJSOg/AyZ7kmrHiqMA3?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	s53BAKFcCdQ8iL49RAAjjN59/6bCpUG1xsDRIk3398XjtbRITIzp4oHBQZJ6JcqWtqWApsGezvUJBM0MaswEe3zK1l+SGc4ip0VixhUN19gs96dRXvUdX6s4tigRK7FJONI3vnG5uCMX5SBCwY+R3Wll1KDopGQBc9TldRP3aCjW0lyBcfVjaS3hbUEE8o5S+VBgPyx8VQmniHpEoGaWRuP5HCWScWxBWxO4Ui+R3pKA1BInP53ya5griSTMCHG1ZX/qq3nZgQXqfrP/DvVDrM5VmjFu1hu24yqMHMmstGILcFI7lNeTi3Xec1Z1SfOVjffXBCPrpmFLynexndIPFuWOmMhx9Ytl0oKktUobzfTOH7THAGMI4XirhCakmvJjcHC8PjBkF6hw2m6jeXWEqYGYF9YZja/zunKC2I/nTZRK8cM3gYFTP2nTUuwIUcAqbzp8SdyTPzSkNA7UDkwuJSI0u3WkkYf7un+hKCJAqyBAStn2QsYfr86txK+IKHSYwHVFhZfgFxKydS4cMExQ7TPCZLFW+82zloHpcTiP0B1VLAYwf7L0tO54brjpSBTE9b/xb53dkUzSAqwBVwOQMGGbcon76blshOCPgDstJRk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d865e1-7a25-4f9e-a4dc-08ddc50543f7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4500.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 07:40:56.3727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tuf76VmOlBGN27zMFwZbhMQDPrRqJBr0iCxrcNIB0W4NFqPczhPzFEs9ZuTUfNLGmD2OSUdZDxKucH+qUmtJfTC0EnsTgwA601wepTNyoIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6530
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170066
X-Proofpoint-GUID: D_w71atv-j-J0GD9YHrhYOrsGbIJGOTl
X-Authority-Analysis: v=2.4 cv=O6g5vA9W c=1 sm=1 tr=0 ts=6878a913 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=qFK5cPGej9PGuWbBexgA:9 cc=ntf awl=host:12062
X-Proofpoint-ORIG-GUID: D_w71atv-j-J0GD9YHrhYOrsGbIJGOTl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDA2NyBTYWx0ZWRfXzMGgbZtsSD6R +aIaimsQgqThN9OOpGGoqoZHDte99WXmVdeIP4P1kkKOqnJKsJr5fkINhuXYk9T9Q+FVaDAmUoH b5VRPUxQNdd8vN+2+f22C4vCSRD9+571LwJUgQUwb0Z86g9hNgYfHp7lV6LVX2WSLi9killdmzI
 RxYWL0l1qC+whoN2DPZVGJYTqiv2XV9cD8oWuDKnnuFLyzAQ8EZdNM1hM6NsZzoSzdx34Dtrma0 uHQFaog2bbS0ydGsBti3uQRLjTQ9BD2CUQ0BZ5KL+X36reGhJFnnCHcga46MZr6SjjgK5Gt9ZYk iLh8QCcWpHkqIvX+ybfLhchtRwYvOg/r1wNLVq3G/s97hVnr7jV6iQT/vAod20DnBGyWaegj0Wx
 K7J4ApeylGcf4rRzaR7u2s2nWFL4yhbsJwFVH0e7w7n2l0B4JzR7YusqhdeRsqn07ZeY8Rj1


> On Wed, 2025-07-16 at 16:15 +0100, Nick Alcock wrote:
>
> [...]
>
>>  - So... a third option, which is probably the most BTFish because it's
>>    something BTF already does, in a sense: put everything in one section,
>>    call it .BTF or .BTFA or whatever, and make that section an archive of
>>    named BTF members, and then stuff however many BTF outputs the
>>    deduplication generates (or none, if we're just stuffing inputs into
>>    outputs without dedupping) into archive members.
>> 
>> So, here's a possibility which seems to provide the latter option while
>> still letting existing tools read the first member (likely vmlinux):
>> 
>> The idea is that we add a *next member link field* in the BTF header, and a
>> name (a strtab offset).  The next member link field is an end-of-header-
>> relative offset just like most of the other header fields, which chains BTF
>> members together in a linked list:
>> 
>> parent     BTF
>>             |
>>             v
>> children   BTF -> BTF -> BTF -> ... -> BTF
>> 
>> The parent is always first in the list.
>
> Hi Nick,
>
> You are talking about BTF section embedded in a final vmlinux binary, right?

More generally, a section embedded in any object which is the result of
linking two or more objects having .BTF sections:

  ld foo.o (.BTF) bar.o (.BTF) -> baz.o (.BTF)

This covers the particular vmlinux case I think.

> Could you please elaborate a bit on why do you need multiple members
> within this section (in the context of your third option)?
> I re-read the email but don't get it :(

As I understand it:

The linker deduplicates types in the set of input .BTF sections.  This
means that when linking foo.o and bar.o, if both compilation units refer
to a type 'quux', there are two possibilities:

a) The type 'quux' is the same (using C type equivalence rules) in both
   compilation units.  Then the type is "shared" and the linker puts it
   only once in the first output BTF member in baz.o .BTF, the "parent".

b) The type 'quux' is different in both compilation units.  These are
   then conflicting types.  Then two versions the type, foo.quux and
   bar.quux, are placed by the linker in the corresponding "children"
   member in baz.o.

Graphically, the .BTF section in a linked binary would contain a
one-level tree of members, with as many children as input compilation
units :


    parent (common types)
      |
      +---  child1 (types only in child1)
      +---  child2 (types only in child2)
      .
      +---  childN (types only in childN)

Hope this makes sense.  Nick should be able to explain it better than I
do.

