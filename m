Return-Path: <bpf+bounces-56710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6EFA9D002
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 19:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 411521BC44A8
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 17:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A9F1FF7CD;
	Fri, 25 Apr 2025 17:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lvetEIrg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HAJ25noH"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB95191F74;
	Fri, 25 Apr 2025 17:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745603443; cv=fail; b=kMqq+F8UAcUrggCxaBJfH8U4eTttO1uBbaw0Ucxm2f8pOdjWHElsODFjYXomSvy/8LRv3ydeIEdhQoDeQgICCzYWuT1798Q9KmDKq1bR4Uy7cZv5haawxy+4sG89ZEnYN+uznw2NKmobyBe01SE3VDSppB8tAk3TbmZgc0C4d50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745603443; c=relaxed/simple;
	bh=KNIW5tFewNiRWcAPjI4tNboPyYt5yTwCroUlbV878wM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WsI7t8IcNvGsQtN+P3Lwb1UANJD2H5oe5mKr+u1OIrAsRFkGjT3PYNPpae7RH+kcnm2uXqrfBMsEcESA7oB1E4rdxrDDiQ9vHtEY6OB6kDvfwlm7uwu8ovJnnsrtQyr1rLZMq+IVN63GLqfpYFOeQQSXTayca6dcCb6Xx9mbZvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lvetEIrg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HAJ25noH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PHN4ln001752;
	Fri, 25 Apr 2025 17:50:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=XtrN7ejSRBAOfDtrk59/nVVCVJc+RKD5T7Gd6B8Jr5g=; b=
	lvetEIrgkadba1d18vb53skrrHv6BdHe8Ua/RZGJUSxxzGjE4FtDugXk989JH7RE
	Pha56zRtaQY00mPKjybgOwM7uwdOGqFxAUB1BncOFn81tkoOE0PR2LtL8LRhFDyD
	5dGGkmE/FXkgHdNZqoBSqWVqNtcnpQ0+8hnwkRbq6Ysb1aBTRraA3hdWDCJKGCwp
	z15p0BButesIrNi39+nCZygDVD2SFElf1FUFxKfctwvGCKzBP0hsUNFogOaTcJuD
	1HUSzsd50kzTGL0hP1AFw4Y2Iprkrj3xfnOq2nxiw7PhHO8iUW+lFuFgufkj/b2a
	ubR38qu7SC29a1IGkzebXQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 468engg45n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 17:50:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53PGKoCf025044;
	Fri, 25 Apr 2025 17:50:31 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazlp17012039.outbound.protection.outlook.com [40.93.1.39])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 466jbtqtpf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 17:50:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=atDWrUn/ndal4we1tS4QKkrqL/qM+ynrVs9byxkLhmtp27r3kbtz/TlUD9RfLk36AWPB6azLwuGFXXbR4mWlC6dEV/VhIbSYyAcS4ivjYVOpQEXc9FKjYtdCDpYqtiGcUE+u3LskqcDnzx2fCK0Srhk9NivjYGiUVDItGqnCxIcANLgyAe3nl2aFS26oi3HswhqVS4CoIuIerls5ukqmEb6DkEzumcxOfjBJwBC1X02lCLUtf0qjMb7lms9VqCQ7dDGz1AyIAsRIjap+0dgOCqfrtoB85HnoVU6kTJ6eJMdZyHhz37tlelBVXLFHmSZtAuJX8u8gl4V6PBte4FIymg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtrN7ejSRBAOfDtrk59/nVVCVJc+RKD5T7Gd6B8Jr5g=;
 b=xXAyFdlejWQykwMEeGCUGhYQPMLCd3bwU1WBQmG36AYGkzZw+LUMbtPFwK+YwUsd2ZcRrEOX/k6TjgLj7L4gjgTSIBO2eqReNfnx+tTlH6WDd+5dJAWmyFkmKXnJRjuMu7aWxpjUtqDv8gkmLbI0zPEYRTs+AKzJvI4sUKuKKsS5MltQ9ZQoR5Aexfb4u/oXY5HL1OacSWaHargwTxwP2A/yzt2QzDJFXG5b0XzMwUs5azwfkOwK4AMoE1/8IthV+EkOb+lVj4A+9jia3q4zdBR8xKtPvXX8oJId0lkI887LTt0erWSkA206sqc7svinUbAhazf7wcYMgbWj/xVOKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtrN7ejSRBAOfDtrk59/nVVCVJc+RKD5T7Gd6B8Jr5g=;
 b=HAJ25noHSzvRwaVyfgLRelBBLQjkgsuT7bB3iqj57UcOlEnjTdB6yOIbKtzfTnMT84Q2lT55jtYSKVjtOJfB6uH+NhnQFsRighH9Y6lGOnaPr0gpudOEc/VS4a/7zMM1U5AoyoecRLAoiEFPJNpal6Nx4eOGtslNUlWdn/yj3B0=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CH0PR10MB5116.namprd10.prod.outlook.com (2603:10b6:610:d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 17:50:28 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 17:50:28 +0000
Message-ID: <076e52f6-248a-4a41-a199-3c705cb3d3c5@oracle.com>
Date: Fri, 25 Apr 2025 18:50:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: pahole and gcc-14 issues
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>,
        Ihor Solodrai <ihor.solodrai@linux.dev>, bpf <bpf@vger.kernel.org>,
        dwarves@vger.kernel.org, Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <CAADnVQL+-LiJGXwxD3jEUrOonO-fX0SZC8496dVzUXvfkB7gYQ@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAADnVQL+-LiJGXwxD3jEUrOonO-fX0SZC8496dVzUXvfkB7gYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P123CA0007.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::16) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CH0PR10MB5116:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e688078-c115-487f-ad2c-08dd8421aa5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ri9iZkVWTTdJR1phMlBqSnNqOHpWdHpEYXBzd0s0ZE14VkorV04zVi9GSnpp?=
 =?utf-8?B?dTlpNVZXRmtFZXcxSlhyTFVrOUt6UUJvUDc2eWo0ZnAvdlpCSjN5NWZickdh?=
 =?utf-8?B?S3VZS3BCaGc1RDUwRisweW1zTjRLNFNZQWN0ZHBWVnhoQ3NSOFMvd2JyL2Mr?=
 =?utf-8?B?b3M2R2REZ3laYklhT1VSalBoTXh6TlFqUy81dHRZclU4Z09nMXdqQWFzY3hH?=
 =?utf-8?B?ZzM5R24ra3BxandBK0lUelNGUU54OXhMb056ZVh1TklBQ1ppN1ZEYkVub3Rs?=
 =?utf-8?B?TCtLdXFuRWFJMWdYZjBHbUtKRnNwekRydWd5OTJjU3M1TVZzWnlRRmhxdWY3?=
 =?utf-8?B?dGVuZG5DSnVvbktlRGp6aEVQTnpEWXYwQUh1NUljRkdwM2lQUkt2SXpNTE8r?=
 =?utf-8?B?WGJKT3h4clRtWVNkQldMUExoaUFiQzVpbVVYM3hZODlqaXE0RldXc2VNaktk?=
 =?utf-8?B?ZkZUZ0VGeG8wcy9sUDlXMm5EVEEzZlBkZlRNbVJ0RWtZV3p2ajJCOVZBdUxt?=
 =?utf-8?B?M0pRTEZPZ3kzSFVXWUxwdVFaQkVCZSttTGJ2a2lOV3lPWjFhUTk0dGxNZjB3?=
 =?utf-8?B?SjFBRlV3U2NXbW5IVisyUjJVd0dsTUxMSjE0WTJ4c2F1U3ZDMHVRNlNlNHRK?=
 =?utf-8?B?VVFCMDhKbVNFRG1hc3JrZlVRS1lQakhHWVVGWkhZM3F4eXlrWkNla254dVRM?=
 =?utf-8?B?TEYxVTQrcnl4bmdYRCtOb3Jlb2M3R05jOGtIRXV1bW5WVm03YnlmcGpqQ0Rq?=
 =?utf-8?B?U21SVGR6dDRBNEJUUTdzc2wzM0c2K2E1SEs4QytKbWRoQk5hQUYvUGgyeXlP?=
 =?utf-8?B?VmhDRjFQSm9OdGFCdVlzRHRab0MxWUxLblJPMGxIZ2dSREdJT3plTU9UK2kw?=
 =?utf-8?B?Y2wrdGFxSUh0OG5PcTgyQXN6eFBQR2FsYkhZWFVQQzFqZ1FJWVVjUnk3eklH?=
 =?utf-8?B?N2p5YWl0MEtxWWZHZ3l6YXhuUDlqNy9kclgzdmdNN05iYUh4WnVjRVZ1dmRi?=
 =?utf-8?B?dDE2c2IzaU91cWYyZ09QdVRPU0wxOFhSZ1g0aWpubUZyRHV6T2loeEIyMVNr?=
 =?utf-8?B?cGxDS3h3N3RqeTRsQTBlSmE0MC9PK0EvdmEzMjRUa213MHV3d3F4dTV1V2c3?=
 =?utf-8?B?Y0Z3SWw1ZHdOY2JMODZLU3h3OGN1ZS9HL3JLZ2NGZHkvVWpoUmUySCtEMjRx?=
 =?utf-8?B?alpTWnNZV21FVlBjaTRsQ2ViaThxT2Y0S2k1QnBiQ1p4Qkcya2RKaXpBMCs5?=
 =?utf-8?B?Um5RdUlpdStBajFBYmM2aHdHNWpIZnkwdE9yNkNTV2JmT3RjUXZpM3MvWDB5?=
 =?utf-8?B?emVwdW83RUtRUWxkWXhxbmV6QWVVMDBCb3pyelR6MTR4NGNUTHVFQXdTeW90?=
 =?utf-8?B?N1k2SmExeEtiRlN1bk9RZzFJU0l1Y1lHTmdDTzhlQzlpTDU1VGM0VzE3clhJ?=
 =?utf-8?B?bjZaS2s4QThoSXNTbTFkSkFpYWdBTW5lUU94eTREazlNNVhmcUw1R3g0MXFi?=
 =?utf-8?B?dWN1Mkt4cDhNOWJ3RE50dW1PWDlIVU5QZENITzBuK0owRWtXZEJyUFNLTEtP?=
 =?utf-8?B?dk43dVdlRStqeXpPdU5XQjkxYzkrbHYvN1pCbmRLVmwwSzhOMTczRmJqZUc5?=
 =?utf-8?B?ZVNhVUtncGdpTEpHTlhuTmpmd3NCNFFsVkNnaTM1aVFkT2pyRWxPVjFoMnlh?=
 =?utf-8?B?WWtzWWpDamNoU3MzVGc0NGQzWWFobitTVFNHQ2tLcWduNFlKZVA1aHdZWWpN?=
 =?utf-8?B?VHVjMHFpdmxQS0tSWldESVVaUWJrL1hFTE5zRFM5cGtsNWZTV2ZoUzR6Z1RH?=
 =?utf-8?B?ZThYVUljUHdjVlVKZlVtVVlPTDJ6ZnZldFk5aHJSd3hqNnp2ckxja294bDBs?=
 =?utf-8?B?bW1OalRnd05tb2dhV0hNdVFvbmlJS0lXMzlTZDdZdFNVZy9DN25jbmdISU5N?=
 =?utf-8?Q?J2S9HmWpP6A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnNNdzJGSHRIdThPTWxRS21Rd0QzRE5yWTR6Q2ZiRFlpRmc0TUt3THM0VGR4?=
 =?utf-8?B?MU9vRFV1RmtsNDNwS3F4SVJQaGNFKzI0NXhaUHlBYzd0ck5ZVFJOTkVRY3F2?=
 =?utf-8?B?VzdKUG1WS2pnRUJMOE9CalQ4Tm80WEwxMmtDNjhDRVNwcCtkNXN0aVZOeHJK?=
 =?utf-8?B?RGQwK0g5alhSeHJFZC9sNEpiM2I3c2pZT3NsU2I3ZEdJclM1NEkxMXdmV2NR?=
 =?utf-8?B?UDlLLzhMb2Z1RC8xUGxPbUZ2bFJnZjBoQ0lCeHBOSkt6VG4yVFlybXArdTVp?=
 =?utf-8?B?Wmo0OW8zOUNoMFhQUS9uS3dvazU0dERtdnJXZ1drSUZRVEhRb29iZEVnS0Rj?=
 =?utf-8?B?MGJYRllXZmJaMHIxRHpPdHJVTU41Q2ZMS08xVkwxVWNjQjFuT0JPOUFlb0ow?=
 =?utf-8?B?QmNrVmhIUWpCdThZekt3a3Z6akNweThkQ3ZITU0wYUIxUFJxSGJzUTN6WXNq?=
 =?utf-8?B?WTFNWmlFeHNhNUVrQTY4TXFweE9xM0RFSzRhRm1jOGZzN1NxNEp4ZHNjREJN?=
 =?utf-8?B?YXZjeWx0bVYzdTVlTHFZME5XR0laaW85bXlhS3VNQzQrTUNUREtadGZMQTMr?=
 =?utf-8?B?WHhGcm11ZEpPaXRNNFAwN25WNVM3V3d4SVluY3d5T25ZaDRXQVFmQTlZMHdl?=
 =?utf-8?B?TVJiUytNV0RsZmc2RlIwMDNuTDJYTHJYUlZTWHVsTmxJeGpvQm9rdW0zYm9V?=
 =?utf-8?B?UTJlWGk1UWpvT0dBelZzYVA0UVJQUmd1WjJtZkIzNXhuWVluNkl4TTVONHQw?=
 =?utf-8?B?MUgyU1k4dWpiSXkzUFQrRHkwc21UTHhRaFExM2htTVh0eTFtUGxUbkVCWlBD?=
 =?utf-8?B?cEdYMGVPemw5bTBJb2NiV0MvTzUzVHMwdDVPRUk0cUZidEZNcXg0bVZvMFB2?=
 =?utf-8?B?YndSeXhZUDhlUTkyQzcrdlc4NjJsNXovaWIzVGtlbk5iK1M0R1VEWnZjU2pn?=
 =?utf-8?B?SzFDVmUzbmUyMCt3S0FKL2h0d3lkQmxqTkU0N01NOFBOcDAweW5VTVhCYVR3?=
 =?utf-8?B?MkgxRjlGSlI0KzdNSEdZVWdTWmNxUU5VbFUxOGIwRlI0aTBITlVLOXpmb2Ri?=
 =?utf-8?B?V2xCRTBGU2lMQzVweVBpVnJuNFl4REZIWm1BVE5reW9GbitMKzY2L1NQNEVl?=
 =?utf-8?B?bWhpNXAvUGc2c2xHbmppUFozSHRPRElyZVdQcHVLKzlPLzFtaFg1K3ZQZTUx?=
 =?utf-8?B?aXEzNms3SWhSUDJyL1MwQUxweVhxZjM2czFxQ2d3eFZZb2kyTjQ4cXduRnJ0?=
 =?utf-8?B?T0ErQ2VqcWZESWZEUjBZOGdnSmRYZnlzOTdNY3hHMm5XYy90WmhpNTBDQTZ4?=
 =?utf-8?B?QXl0SzMxRFVudU5OcW01VDRZTmNlVktaVEw5YlRreFEyaDJnVkdyOEkxVUZS?=
 =?utf-8?B?SXhZRnZpVHp1citQQzdIVy8rTjVNb3N2ZHJyZ3gyODlIS0dRS0dFMEMvTi8v?=
 =?utf-8?B?SGRNekJUQi9ySEQ5Sm5hMUd1Tlo4NTJKQ0l0WGdNcm1xeENWZUduNEVtbXFM?=
 =?utf-8?B?UTB1WmxwSlBtMFYxYWJRc0k3SCtoa3htTVBHREVUbDdJckhYcmVzSkNQNnRu?=
 =?utf-8?B?ZjVjWTNRWlYyVGY5Zk9RWHdpTmFmS1FuYVNwMlp0Q2ZxeDcxb2Vya01VSjR5?=
 =?utf-8?B?QXFKVTdYQUYxSFliMzdjVjJ0WjAvY3MvSDBkTkF5L3JWeTdtYUlOSEV2dGhG?=
 =?utf-8?B?U05obzlTUXlXT2JMYnZWbXdVN2E0S0IwN3loU1U4RDJlMmFaeHBEUTZRUFpB?=
 =?utf-8?B?cTRTcEQyUjBvSS9na0pnaG50NXJiTmU2N1VTbDdyQmRFcXhrS3p0bXVIZ2Fy?=
 =?utf-8?B?N1J5RUkydmsydzAxZTFlUHE1ZFF2bGI2MlJEWFc0WWUzZGZmSHpmaE1tbnds?=
 =?utf-8?B?L3N1d0FwTXlEaVBGTmlpOWRFTndiR0pFeUVqNUZ0anVacVgxeWYxYlhGVElu?=
 =?utf-8?B?cEFLdDZza3NldzQ5eHk5Y3djODVMbmJ6ZzRERFA3dFFOS3luUENPUEhKWUNu?=
 =?utf-8?B?cTg3YWdOVFV4MDVsbEcrT0xBSHpIbVlReUxwY3dqcC9Oc213VTRVMytNUExZ?=
 =?utf-8?B?bTR3bzhwYnJaY3oxZ2V1OFZxTVk4NmRPWVozeERNUDdnNnMxMTFOVmJWb0Iw?=
 =?utf-8?B?OWlPSVBHajRPMzdaWi9YVi9CaURnYUVybGF6WjNFQ1pkbEpzRVhVNWdQTnI4?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lJDNy6t/5AiXCxvopitpH+qxM0yfzN/axLUuvXjTpISOye2s8n6vCe7wHOBGOz47USFIcdDSiRPCnikl0yZGL6y1MarBgmLb5YNIphFz2ERTXVw89nJw+TDgx7NrVpGf8JUKKPsx9MkcqiJj9Nwb1JzVROUd3VZXZol87O21i3imm/taEEzEY6Cgsntt46yJ5OkEnasZksQ+7HiR/Pya3dU5Hbd1S0UM9gGCXk0+eEX5guPbIcZYeTAtcUEwdD9L1Ed5cSa+txyzXz/q5yMAlLcrIcdaQjXLhhCK0TULm5NVR/M75EFCFUoHBzbMh9OaV2cqC8u1B45J4S7BXpWP0x8pl8gSARdZrnBJcWyLfyx3lI0pn+IkLVuw8+RJD8IWtbfBxp4n/UvO/mj6qC4OROmHnjFIJ4psLp2/qgOM52OmkLwxEomcfnQEcRo01G/9saGIKWlkBH55/FS9Jfi6iyyeIabrkQ7DiEhj5Ki7X5cHpBhBpEshWIFNwtgfc459SasOXcEtC4fj7KBdBa38OIUjTnuEzdEj/ezzwICqyW8fuBvt4M9BO6yRfeBEsbYMpaV6jPlkmts2O4SHijdny21be/cPhTmc6D23xgQMr9g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e688078-c115-487f-ad2c-08dd8421aa5d
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 17:50:28.5508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lqEbPzGB+o46Mbsf9/1n9WHvL3jt3WfsDTrOfmn1Wg3GiEgteZqJiKo8FZHfxCAa+YqcLQ28JEme2uYRciQCYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5116
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504250126
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDEyNiBTYWx0ZWRfX3/GlJUqZFjbC AbDO2XQTnGWJdvrTC2t6yWujcRkSAc4Wxtn5g50GQ8K6v8ooLUL2uRuQ3AMeeO8bXRoe7xlMIwN DURlyY43HrrhM/kIuA547LCkRqakts+cq8HOEu/1L1Fw4GEZOLpME5l61Tolb9oHON8taeZ454H
 1EFd62EHl0gv3ap1Nr/gDw9xpDumbmLc80g5v7VT9XGRJ0tQivwpviT34kf1h+M1+SJ4g3iDxdz fxEiTvMfhxXcm89YRxahk+OrMMTOPye5RkyNcyGQa+i3rmbRqbTFnSkew2GkjpADWFtJQcyPLXe O1JlbMtqXK3qonFbYifK880ILF4Z4oohNhggJ4DTmHNiktUnM0IEJtRbnsbP3Z5EOODBoLOghU2 EKrIVvBZ
X-Proofpoint-GUID: coEfY0o3b4FoIhdwKiSCtxzYASnJSxpM
X-Proofpoint-ORIG-GUID: coEfY0o3b4FoIhdwKiSCtxzYASnJSxpM

On 25/04/2025 15:50, Alexei Starovoitov wrote:
> Hi All,
> 
> Looks like pahole fails to deduplicate BTF when kernel and
> kernel module are built with gcc-14.
> I see this issue with various kernel .config-s on bpf and
> bpf-next trees.
> I tried pahole 1.28 and the latest master. Same issues.
> 
> BTF in bpf_testmod.ko built with gcc-14 has 2849 types.
> When built with gcc-13 it has 454 types.
> So something is confusing dedup logic.
> Would be great if dedup experts can take a look,
> since this dedup issue is breaking a lot of selftests/bpf.
> 
> Also vmlinux.h generated out of the kernel compiled with gcc-13
> and out of the kernel compiled with gcc-14 shows these differences:
> 
> --- vmlinux13.h    2025-04-24 21:33:50.556884372 -0700
> +++ vmlinux14.h    2025-04-24 21:39:10.310488992 -0700
> @@ -148815,7 +148815,6 @@
>  extern int hid_bpf_input_report(struct hid_bpf_ctx *ctx, enum
> hid_report_type type, u8 *buf, const size_t buf__sz) __weak __ksym;
>  extern void hid_bpf_release_context(struct hid_bpf_ctx *ctx) __weak __ksym;
>  extern int hid_bpf_try_input_report(struct hid_bpf_ctx *ctx, enum
> hid_report_type type, u8 *buf, const size_t buf__sz) __weak __ksym;
> -extern bool scx_bpf_consume(u64 dsq_id) __weak __ksym;
>  extern int scx_bpf_cpu_node(s32 cpu) __weak __ksym;
>  extern struct rq *scx_bpf_cpu_rq(s32 cpu) __weak __ksym;
>  extern u32 scx_bpf_cpuperf_cap(s32 cpu) __weak __ksym;
> @@ -148825,12 +148824,8 @@
>  extern void scx_bpf_destroy_dsq(u64 dsq_id) __weak __ksym;
>  extern void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64
> slice, u64 enq_flags) __weak __ksym;
>  extern void scx_bpf_dispatch_cancel(void) __weak __ksym;
> -extern bool scx_bpf_dispatch_from_dsq(struct bpf_iter_scx_dsq
> *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __weak
> __ksym;
> -extern void scx_bpf_dispatch_from_dsq_set_slice(struct
> bpf_iter_scx_dsq *it__iter, u64 slice) __weak __ksym;
>  extern void scx_bpf_dispatch_from_dsq_set_vtime(struct
> bpf_iter_scx_dsq *it__iter, u64 vtime) __weak __ksym;
>  extern u32 scx_bpf_dispatch_nr_slots(void) __weak __ksym;
> -extern void scx_bpf_dispatch_vtime(struct task_struct *p, u64 dsq_id,
> u64 slice, u64 vtime, u64 enq_flags) __weak __ksym;
> -extern bool scx_bpf_dispatch_vtime_from_dsq(struct bpf_iter_scx_dsq
> *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __weak
> __ksym;
>  extern void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64
> slice, u64 enq_flags) __weak __ksym;
>  extern void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64
> dsq_id, u64 slice, u64 vtime, u64 enq_flags) __weak __ksym;
>  extern bool scx_bpf_dsq_move(struct bpf_iter_scx_dsq *it__iter,
> struct task_struct *p, u64 dsq_id, u64 enq_flags) __weak __ksym;
> 
> gcc-14's kernel is clearly wrong.
> These 5 kfuncs still exist in the kernel.
> I manually checked there is no if __GNUC__ > 13 in the code.
> Also:
> nm bld/vmlinux|grep -w scx_bpf_consume
> ffffffff8159d4b0 T scx_bpf_consume
> ffffffff8120ea81 t scx_bpf_consume.cold
> 
> I suspect the second issue is not related to the dedup problem.
> All 5 missing kfuncs have ".cold" optimized bodies.
> But ".cold" maybe a red herring, since
> nm bld/vmlinux|grep -w scx_bpf_dispatch
> ffffffff8159d020 T scx_bpf_dispatch
> ffffffff8120ea0f t scx_bpf_dispatch.cold
> but this kfunc is present in vmlinux14.h
> 
> If it makes a difference I have these configs:
> # CONFIG_DEBUG_INFO_DWARF4 is not set
> # CONFIG_DEBUG_INFO_DWARF5 is not set
> # CONFIG_DEBUG_INFO_REDUCED is not set
> CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
> # CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
> # CONFIG_DEBUG_INFO_SPLIT is not set
> CONFIG_DEBUG_INFO_BTF=y
> CONFIG_PAHOLE_HAS_SPLIT_BTF=y
> CONFIG_DEBUG_INFO_BTF_MODULES=y

thanks for the report! I've just reproduced this now with gcc 14; my
initial theory was it might be DWARF5-related, but dedup issues occur
for modules with CONFIG_DEBUG_INFO_DWARF4=y also. I'm seeing task_struct
duplicates in module BTF among other things, so I will try and dig
further and report back when I find something. Like you I suspect the
issues with missing kfuncs are different; may be an issue with our logic
handling inconsistent functions getting confused by the .cold
components. But right now understanding dedup issues is the top priority.

Alan

