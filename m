Return-Path: <bpf+bounces-28923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5A38BEB6E
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 20:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A59B1C20D64
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 18:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F3516D319;
	Tue,  7 May 2024 18:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ibyg3XpI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VRxBQ7Lt"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09E616C870
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 18:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715106027; cv=fail; b=gImvu5nMOWsj7JbclFbGSGrvvRDWJk6f2so6PY8EqFBdVlvF9imqVOrQ5t62CSXDi3brjh3k+dQEQMAAEkf21HgpHkaj/KOloaIkX4XHnX7kXxG29iXar9A0sarJF175NVAoK/giJUE85f5z6N6D80UFPyMzlFJwcJXDKYDv6BU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715106027; c=relaxed/simple;
	bh=NcIg8BYriqx8QumgAoeLcxD3SKBz/1aZzVOmv7H5kyM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=Ncc7tsDkaSpkDS++6CaiDfIiJsSXRcqE4VQtOhxGtTOFJ+Kng6tm9Bsa6M52TmqMOPVwU92D1cN7X4H9A+/gcKWmwLL/vAFIk/Te9maDZji5NIQm1f3MKR4jZ2zWnLZlP9n3m0kPI4z5B3Eh0zmcXmVvdf5CzTdqSpTstt0bPYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ibyg3XpI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VRxBQ7Lt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 447IJl5d022002;
	Tue, 7 May 2024 18:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=a86hnqWmAn/qAD8ufdqTLqvB9m1IfnUgUi5gkjigA7I=;
 b=ibyg3XpIVmDSxsPWDYqh3wlZbTC4oArTfbXk1JxnuG4BnV5k+ZaXDnrKtDLBhrB4Xb2y
 mDLF3hAmmO9tJNZJ2SRrBbcerJeRlfSkpRoOfhOuGEWZ53cgrG1fAjp4H38c6rWlYQWc
 IndVQeNb5mqoGGUnzfYVU0ou63wCC5OUw9QwJuIuZuveq9gegdztnbMPT4oSv65+5qln
 JiAD+8SR18qZR1C0TW37Ks7W68nl/loGwR71JaBdZuPmq7gLPQKbIGSqiuV3RFnYrK+R
 coF1qgdfjFM1W3KCVXO9bCA825fVGQ6u+c5N0zrzHu3nj3XvMmbzuKuskHW5cHNNi1Wg Og== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xysfq000w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 18:20:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 447IJ1ZL030924;
	Tue, 7 May 2024 18:20:22 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfk01pt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 18:20:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmEr07NsvSkmH63d5ijeRqJKlyrH1G/hOic4SymHHd37/XzkZ6pujY/AjyBWVUDMjO2Moeay73F/rRMVJHoYJ2JSroem/5uMsrPFH+0ohdAacqItutOWI7euQrVUN5QA5KzBkoM1Vo7hXcBxSk7QMu2VYnQHPSzMUKDjd0pw1sQ+Kzdszfcjs6Vy3jixXOSBAct3yqakEUvauQPOMcnsZJGCyb46HG2im8ooWIDdJyAsd6ZfX5ESEG4jB+7VQvP9kZVr9oFDeRwG37N3AT30F42+mstXyfHclGAWaPrSSvH+i8aH0X+AxkN2gxgwooAN+OCbfppSVvgAREQifN4vsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a86hnqWmAn/qAD8ufdqTLqvB9m1IfnUgUi5gkjigA7I=;
 b=AYHyHmkV34ZkIaocX+LoPRbAMyl2K9tOkLm4uIHx/pgsc+KkIQXsos0UKdqSKH3ZcI+TJtpPiuWyy2tUK2xg8r6T8r6uTEvgaoXm0dOIX/+xaVfL54bRECVC8MefiPzKPYXzFB+5GdDOqqz5IEg56ph089KZwNBMXw/fvyqYlcKaqESjE4iC+vxBikOyYNVJIvr6r7V2yrC0WvOlruL2FPqdus6OLDgMOXIwqteRIh4olhqthBjrRg9x6iekgfq6cdjjYBGOMMGTWK8cHMYafhs9KN8fXUAdVhZYY1zlHnPuOxeFCThzIXESkIM+NI4jOkZWmEFvKx8ATXtJAwM18Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a86hnqWmAn/qAD8ufdqTLqvB9m1IfnUgUi5gkjigA7I=;
 b=VRxBQ7LtWN+nnaVit8I3f8q0lbldGZ35Y9N+XV7wkZoeiYEzS6pkvTkCve2WmO0oY8DvG3GA5y9FbkhmfNXXE6gdeObC9ESLhLfDWPylFGGw+PHoFWUFrT7re4njuksn0lWC7+XGbhfLUfscGr8xuzICIAyTBy1FYu0Ix3bft1Y=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by CO1PR10MB4801.namprd10.prod.outlook.com (2603:10b6:303:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Tue, 7 May
 2024 18:20:20 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 18:20:20 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, david.faust@oracle.com, cupertino.miranda@oracle.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: avoid uninitialized warnings in
 verifier_global_subprogs.c
In-Reply-To: <223e5ab8-83da-40b7-b10b-0f6341aacb27@linux.dev> (Yonghong Song's
	message of "Tue, 7 May 2024 10:41:11 -0700")
References: <20240507140540.3972-1-jose.marchesi@oracle.com>
	<223e5ab8-83da-40b7-b10b-0f6341aacb27@linux.dev>
Date: Tue, 07 May 2024 20:20:15 +0200
Message-ID: <87edadcwm8.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0045.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::33) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|CO1PR10MB4801:EE_
X-MS-Office365-Filtering-Correlation-Id: d580fb23-b6a3-4c52-ef1c-08dc6ec25a8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?gPqvKtmSIZWVFBIabehOndgyUIi9cfCcQtiF4qOoEkmxsNC5jXVwnP7w9sjH?=
 =?us-ascii?Q?G5FaXgbnxAJUSV5NLky7MruBNwNdl9qWS7qOzTuM3tF62QrUBa3e0/SqDzVz?=
 =?us-ascii?Q?N57/RhH69LkccXVbRdHpGAed4nCcE9LZ3iBd7EQEKfmZRwxkYpBQbMLjvVSV?=
 =?us-ascii?Q?s1E0ZciCUNhoazX3pLVWZwXB/KMO8Rll6JUJo54cHO+JqfmppNBYpKJu0ZdW?=
 =?us-ascii?Q?HexsveNs/fEpJzYC6Cmq00dhhaVlx2i61R4a8NwfIH2OWi4PuScNhzO6vg66?=
 =?us-ascii?Q?wCa+lpk50IPKMbJMxOKUftbQjxcs2ZLSTCLfO5g4voUtYoLW7pTeyhkE0kar?=
 =?us-ascii?Q?BF2NMeV2kD+8DnZMwKy8p7BPO8bvx6OuRtMjalDjyBBuoKDxXoaqkYinCKjI?=
 =?us-ascii?Q?bUk/Me94ZIy8MD/ZY4N/LyqrvakXDHfI9yVy5wF96te+VaCbjbWeMzFHkwSd?=
 =?us-ascii?Q?r86iVYxDxJ2NTKXTmhG+28yUz7v/6z3asnSr8nSn96oxU/94iTjvhfsbDSwu?=
 =?us-ascii?Q?TvO+KeojU1BJYz4hzHVTt2lYMwEPacHXK7BTiRID7VIJWafJSV+LhUgvE36y?=
 =?us-ascii?Q?RDHowINrnRr3CmGOVDY960XTQMFp0k7H8jjU97YWMw9fAWkk5A7D6ZCjoa6F?=
 =?us-ascii?Q?3Ol5LyIM07VXdnY4Wqo+bPRnj+54Uzg0wHxQERueiSiKhvmL5N+GQGOouuW/?=
 =?us-ascii?Q?FlFfcf6SoU6zfzwvFMhYrtITx6p09Cz6RuKKNot4uC5XAFMXcqaCa+98iHTn?=
 =?us-ascii?Q?ROYZyhHM4c9TpFc1Z6Zlu/0KnlRriefR7bFPKkK5djfyPw/T6o0wGszL3/zn?=
 =?us-ascii?Q?MyzoefZbqEtJsl6O2U71LVWBWr5SYlwF7t3CNIVHcBHzs1foaywmXPbE2ssc?=
 =?us-ascii?Q?1GDwhCTbHBzTx5J7xQdQ2tWlhZatLmt+JkO2PIEHSPrElY68nhqUxue1i71Y?=
 =?us-ascii?Q?Gc4Z8JyVayBKTZvWwW7t+IctJGq9jl7uZs1HeCffvhvFRLyvDZ6hG42swP4q?=
 =?us-ascii?Q?u7XXLT2stnReZnQEquQrAs1xVcS6QENpxi30wJsyayISgKQtSmivWyLMm35R?=
 =?us-ascii?Q?SBeC1HU1XA16tALKHFUsd2lzWZbyGp8na2S0rGdxYDLh44Zs9JHkv0LfYXI1?=
 =?us-ascii?Q?pQWMEcMkwwlVwFzVytinw5vtUeB9l5+CU73bH6J6bSD0EnthlW63VfsWV6Sy?=
 =?us-ascii?Q?1R57hon3Eo5LHG7egbPuxC/+gfMC+qwBKbjYozAVEMqJf56QdV0SsU2SzLJ1?=
 =?us-ascii?Q?DkJcjImcp3whNVlvqOq5sL5VhV4TaYZ5f19HaVJPwg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?j2G+DtE+VmLUZCQqwpXsU1TWlrsURg6sbL0fri5YvBGUD6fHq/lRpxT9Igmp?=
 =?us-ascii?Q?T12rus3CYBnXQVm0rImII/j1OnMkL78OYGay/sq0m00QYw4Qvtri9LmS7OIR?=
 =?us-ascii?Q?g6C/F2DgxwprkyJaxAy9SFtLqQMlZ9ODAf3S0GYWWKrx3pOaodjFUxYI0t6O?=
 =?us-ascii?Q?h/v2u0IiWeqJvJCjjsGphiMtaWHLqotDxY44dURPmNI0k46iV59YM7TbPIzS?=
 =?us-ascii?Q?AdSMVR7Y3Rv3s6m+Nw2wXXf0SHtTIJRF63yR8qPhAqwNR/oyFCT3UtbrwDh9?=
 =?us-ascii?Q?/ilOSAIcn/TICNqyQsVIIFb6rD6zoFjp26koD8PpQdSKU822/i68l+eluY9c?=
 =?us-ascii?Q?Z3bK+hllQJyFi58nQEkwH8n28W//kTfnQgueM4kJJtkhoCkwcJzFFAwW9ehc?=
 =?us-ascii?Q?TxPLGfREnQrKtCURaj5J0Sru1EkZn83Aw6LXSZo7HA/fagnrxfmWOgtXroHZ?=
 =?us-ascii?Q?y4GbA5KMVSqJMPXPM5/Jecq4Czh+wdSy7xGHzW2zTSWpmbeykMaxvwL04edj?=
 =?us-ascii?Q?sTYdNmAHVuVXkWW+zjjGwUr3fJ+ExXlTzmv0Mmpe5NzCM2x2wiRIfKfKfPC3?=
 =?us-ascii?Q?LQkaBljWBiSd7pxhnUdBqIwXWYPSjc+Yo2AVsjeKkTDhYNSGl3ddmg4izsMD?=
 =?us-ascii?Q?xwf1Gs8rvcK/w+FWAm2fndPIy11V3fLtQDOekZ9IEb806kToxvkcmHb656Ju?=
 =?us-ascii?Q?YGDI4xJLqml9I9KHG49bC19/rnMvg7bV+g/c0H2N0dCSE2Ny7iwXpgQVBcYr?=
 =?us-ascii?Q?dgw1pDGOJQhi/oU+SoPuMXsTc1H/55s896tzp5J0mnWq18dGhArqdsiFMMdl?=
 =?us-ascii?Q?QcLk3cyMuUnhu1w5PM/inejDHV+j+dQgx0cB/HcdWvvZ1xfDdENfgsChETQv?=
 =?us-ascii?Q?DRXIdpuXR6mGYk0VZ0ca2OIlQbg+y4nqOWFr44xbWRkgXK7LPiibxRLJve/n?=
 =?us-ascii?Q?0sa08GW9skIloB7AWdPatl9vrzCVWNT2X0zUsl9FIYz52ScujZyJnDvoCUdJ?=
 =?us-ascii?Q?7w1qOXyex0ODaVQKh2k30+msGjHzkvUW2+2SXQT3Z0VrKT2fJ6/w9oemeRq2?=
 =?us-ascii?Q?L9jFG6A30tXiBQKjgqPZ83BYMPco41jGknfMoJA0J8j8HoZDzkfvs++HFFNG?=
 =?us-ascii?Q?jPvTsfPBsXQ920Xzn2oFYfS0KWc89i+n+lud+RatLmAZqDR0fCeLZJu6u2He?=
 =?us-ascii?Q?NdxFphpECyhgd/W46rFBM9sULIINSAkKfJqwRgNz4thRvtEZGJKY1KuItWk4?=
 =?us-ascii?Q?mlvGptvm+/tz/xq0qqrtU5oeIlo2j9DD6nlHnBAz1tmSVI0fISMtdx68uy13?=
 =?us-ascii?Q?mhq4Cs+DWtcCyt9t0+afK4kISkXdMBR4ZzO836OEYgrFQZ8WPwBiWB9kzUUx?=
 =?us-ascii?Q?yhpIi4hAOph9Mg8plK5xe+AwTHsIw8Q4g6xqsqCl00vMeevUXvnxQJPA+Cbc?=
 =?us-ascii?Q?bYw81v3zPx279hx1ZTkmFY8UXlmza4+jJ3N+sjJPqS/63nwQjzWuy8tMKX2z?=
 =?us-ascii?Q?kH8+CThNJhgoX4o4wnFAYAndk5pvMqZEM0OTTTDAGCnc3zRNo8sCjR5NYoQX?=
 =?us-ascii?Q?Z3WAZ3/Xm1scqqNqPU5D5xqQPmbcW7EVsd33DOmWGLgYy6nDT7Ga37UCrGW8?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DVHrBpFEtRsPJ3+92FsF1iJp1f88QaFSOquBpMgV1HxfYsyqRLc41P0DJWdD03IFbMDmLkJ+eF2GnNrq8ZIJkwmIn4x3sCJJ+YV7IQ+Fo8xJm249QcEcn2U5Gy0nDF/dGieYmYjSY4YiSW7TvKQxesRTpM+dewZOR2fU4WTimWc2JGfzKf5Sw0n/DfArVxYPxrKNCp9E8xj63qgUx1bjqXjB4u/dmMcO4DzjKThJcmH+R5VBKwttqsYcu1CV+KtZTJw2h0Rq6YYSdIZn9OAIt5ZE3iSV7TCMBuXnhYGrQoIhWCwWRbs73xYh7sudT9ssApI9eEYFf5201FHUC0moqgkvSRmfeSI+pt7CtTjv12C31lP5E5zywnaY2kh/MiAN9ycna6omkNSe6c7PuU2Mwckk2DMmVgknuceZmTHUZahDLH9k+jI9AJ9Ut5z85eT1Sk8YywMQSFlufOQLLmKDtpEamW5PyLJDc81WlUQfTCk3JKe0OkG+fxgon600SPb4FxNqsNeJBMbNO++zNKnTDRS+MiZJhzd3WzI6BwUjNRSvy9eFibWrMUcajjv7p6zRXZvG2j8rOiLXRu2N8z3oY5qkoMOKKcHJqHIvfv14Wjo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d580fb23-b6a3-4c52-ef1c-08dc6ec25a8e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 18:20:20.3818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ozvlGHJgJhRRU3K+Lj01cBWGgJGWaEtuVhlFxKCPa608LujtxLG1OWDnNOTq8x1PC9yqEcFISSPF+PjIdCo96XurTsQx2eeBVp5HfD7SGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4801
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_11,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405070128
X-Proofpoint-GUID: srNCwtoloUX00iaX3dS5TvWj5K8OHPRE
X-Proofpoint-ORIG-GUID: srNCwtoloUX00iaX3dS5TvWj5K8OHPRE


> On 5/7/24 7:05 AM, Jose E. Marchesi wrote:
>> The BPF selftest verifier_global_subprogs.c contains code that
>> purposedly performs out of bounds access to memory, to check whether
>> the kernel verifier is able to catch them.  For example:
>>
>>    __noinline int global_unsupp(const int *mem)
>>    {
>> 	if (!mem)
>> 		return 0;
>> 	return mem[100]; /* BOOM */
>>    }
>>
>> With -O1 and higher and no inlining, GCC notices this fact and emits a
>> "maybe uninitialized" warning.  This is by design.  Note that the
>> emission of these warnings is highly dependent on the precise
>> optimizations that are performed.
>
> Interesting. The error message is 'maybe uninitialized' but not
> an error to complain out-of-bound access. But anyway, since gcc
> produces a warning, your patch silences it and LGTM.
>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>

Please hold on.  The right warning to inhibit is -Wmaybe-uninitialized,
which is GCC specific.

So it must be:

  #if !defined(__clang__)
  #pragma GCC diagnostic ignored "-Wmaybe-uninitialized"
  #endif

Unless you disagree I am testing this and will send a V2 with your
Acked-by.

Sorry about this.  I hate to be erratic, but so many small patches
today.

>>
>> This patch adds a compiler pragma to verifier_global_subprogs.c to
>> ignore these warnings.
>>
>> Tested in bpf-next master.
>> No regressions.
>>
>> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
>> Cc: david.faust@oracle.com
>> Cc: cupertino.miranda@oracle.com
>> Cc: Yonghong Song <yonghong.song@linux.dev>
>> Cc: Eduard Zingerman <eddyz87@gmail.com>
>> ---
>>   tools/testing/selftests/bpf/progs/verifier_global_subprogs.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git
>> a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
>> b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
>> index baff5ffe9405..d05dc218b7e9 100644
>> --- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
>> @@ -8,6 +8,11 @@
>>   #include "xdp_metadata.h"
>>   #include "bpf_kfuncs.h"
>>   +/* The compiler may be able to detect the access to uninitialized
>> +   memory in the routines performing out of bound memory accesses and
>> +   emit warnings about it.  This is the case of GCC. */
>> +#pragma GCC diagnostic ignored "-Wuninitialized"
>> +
>>   int arr[1];
>>   int unkn_idx;
>>   const volatile bool call_dead_subprog = false;

