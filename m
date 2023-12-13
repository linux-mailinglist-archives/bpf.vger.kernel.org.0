Return-Path: <bpf+bounces-17696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D16B3811B8B
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 18:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE8C282656
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 17:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33EF58AB1;
	Wed, 13 Dec 2023 17:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nJeHonNi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n0fwzT4i"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8DEE8
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 09:52:27 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDER3RM029849;
	Wed, 13 Dec 2023 17:51:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=YIClT8qzQTpn1TNsSAloGdExYgYSol//JWfipyM7mq0=;
 b=nJeHonNix1jf0ysCvYkARbhpE9JGn+Gjcv+HruGQ69wAFTNWcX4ht8G2t7TZQmdKV8Ky
 k9kp2okPjuTowTj9ltvzrHlJVeCwJLcH4/nAodvi8jza5d0j0QKCS+Jh+Q8ozH4g7S6A
 /Dsg8yTOIvotzkdFReIbKgu7tZGYh0hZW2nEvsVJGY/DvSWlQZGGVt41lo99ShqX0nh5
 aBfIT8qSdWuxHAxsFU11Y7M4x+EMbmjBBpHK1FNJ8canSVY21u6uBVAjEXP00rs3vP4V
 Xv9MbSX8lhOIjCIhHGt1jODJnZqiU4L/Av09ubCmIBvCe5x6N3XpIEDYZwUBOpJY+SSd mg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ux5df5hkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 17:51:36 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDHCLVI009797;
	Wed, 13 Dec 2023 17:51:34 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep8pq78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 17:51:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cs/YDytK1q49Om/lxIwJwdC61GFJUlt8IV0AKnGKYSYmTXq+Prsc+iXtXjJbDTlq0N3QH3Hir0aCsUnpM5u62t3Lx0XtaOCA+VSZ7kwU3ptzfVlmr078hsXtjZqw11Vqra1up0QqtQ5Pw8A5aivXj4WQA0OsFv0Tkh3ujgI/jQvA2LPf3zlVmt1RgEJAIRzMeP9Gd9Zl67gBQQxnnaNjKUyCrBbLWS59X1JsvjhL6A17+bJG7EwYqJS+oHsea9jr1kebpDvLb43mdBur06KMG4Pu29ThPwUz8A4Kyakmeqv++5fq0oTJTlHCKhE0/YN9Y6+7wlHd7oUJMeZFhdvHyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIClT8qzQTpn1TNsSAloGdExYgYSol//JWfipyM7mq0=;
 b=KWdIg3errj6rR+VGaO9rnQoIGL29kF8gCySlLdiap3lN04h19uVGmKuGamwuBDo+mIZwuMGIZxfaAvwemJblQTosgSaeIJG3y/KIF45GYyKRxlKLQKXimuoRwlnihb/FmqMVYBGhaH6h2ixjIaFNu8gIWOC871zE0qbKzoRpijpnmPCq2kGjyylq2JQ/kw3yZ8cjSYi78bpBe6zGJ1ZVF25qxDn9p+Ix7WjldhBUf/fg1+h5t7ha4k3lLWNR8iOmM+eG9FmvPPSVstqJnQYDIg+psfBJpj8BVF5gnTHDYKQNOcE3VaSbdx+C106xtMI33CGJXSggMz3Y4z75rhVXfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIClT8qzQTpn1TNsSAloGdExYgYSol//JWfipyM7mq0=;
 b=n0fwzT4igPwELmZw314WnA4qjyhXkDqoM45eK9HdgU/CozGhykQ9ucfds8RA72XxvHJPZr/6o08J96dHk4qzt5Dn/r+EGPEwijE2JZpSjKHficMbwz6tOYbRg1RVFqhWU787cx6UXQ8+2UzZ/SJ9dNaIVWcDTWl4jeToRUjgq14=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CY5PR10MB6093.namprd10.prod.outlook.com (2603:10b6:930:3a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 17:51:32 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8f9a:840c:f0a6:eaee]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8f9a:840c:f0a6:eaee%6]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 17:51:32 +0000
Message-ID: <c13eddee-f61d-b209-11c4-5ea5a9f389da@oracle.com>
Date: Wed, 13 Dec 2023 17:51:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC bpf-next 1/2] bpf: Fail uprobe multi link with negative
 offset
Content-Language: en-GB
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Oleg Nesterov <oleg@redhat.com>
References: <20231213141234.1210389-1-jolsa@kernel.org>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20231213141234.1210389-1-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0043.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::11) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CY5PR10MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: a69ab524-72e5-44b9-722a-08dbfc042492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	yyxlSS7MhHTGLMdhgL5TG1z6VvnXPIBn9oVct8gYcWPZeZZpvgpCjaVAa6FYOrz+KUpvol+3CDHZi3mGaBJQhNTh9LRvlesvYOnF6O5RtlOVXboxJEIn1Vvf4vJ8hXxMByerbyVwK8sFEZNPWh3EWkrvi2aIGNyQbhvH0kbtu6ShWYrKZmE6EVml/GmcfWaXY3NM1TYOIVo1LWVPRMxZ6No6RRe+g5AYxLo+XDy+VVoddrHbq7nakmQWVu7+/mSB0iK716NZV1X51rc/iMf3swMJSjr+7vN2YtmQRt2iZpwUyH92KxAvM7s9TQRte9ZfA5xen6ZxhEFKWSACEPvF+qc38xN8GAXdT0tsgr5gIsK33VI1sjfvE1/tZw31/NpFN15XSbYscaDMD8obvAP0kKY11NYr03vWZSYj7Uf8IDahS9q2F+7nJR+Bls2ZtxVOowywSF+U8/uFPRxhwoAftU+0UQq3Ecw5fTJEJGcUyWTP0xY6ccH8UkrJXKHOYHjLjSsLNqk+BJCeeC9jpwGKikmYKgYiEtM5Wpw80S1lxeecI7rLUO9MSVQPy6lR3q0dmxA5zQ8pdubjx69BtpPBSTxIm6aVM9ceMJVW3lFqffO2YIM3BAnuBy151lMLOawZF6Qr3bBjnl4XzTxJPz2AAw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(376002)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(4326008)(8936002)(2906002)(44832011)(7416002)(8676002)(6666004)(5660300002)(316002)(478600001)(6506007)(6512007)(54906003)(66556008)(66476007)(66946007)(110136005)(6486002)(53546011)(41300700001)(38100700002)(31686004)(31696002)(36756003)(86362001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bGNmZnhGQTdHNkcyc1o3c0premJvNkozTXZGeDV0R2tFUnhvY3FsaGhoRS9Z?=
 =?utf-8?B?ekZ5SENhNGpSWWxjOVBoMmo5MXlsU0NlQWVsQnBLYW5DVElwS3hvR2NIUm1O?=
 =?utf-8?B?bkFVUlhoQjZ3QnNSR0hpTFR5WEpNVUtnZkQ1c3d6Zk56MlRxemFUaTFmZ3gz?=
 =?utf-8?B?ZGs1TjUzcnZCNFlwSGNNMFRJY0NHN0pxa3pubWgzVEc0SDJjallnNjlYc0Uw?=
 =?utf-8?B?UzkwVXdWSzVrRnVOUGZTRndxV0FrSDdoMktkVjhwYnJvVEtlN0FMNGVZQXFD?=
 =?utf-8?B?TXg3b2hISEZ3SWY2LzI0NzNLNzhVbkxKWkdWVHVBelRNL3hlbFBMM1MzdGJJ?=
 =?utf-8?B?MUNOeHhwQjYzTTgrY0pyci9adjg0L0NIRFMySHhaWis5V1dneEJUc1NkVnRp?=
 =?utf-8?B?dVpzYnlTdGFKSmhYK1ZBVlV6ak05VlJjR2JURkh6aTFzTjBVQUk4ajRZS01z?=
 =?utf-8?B?a0hqQllEdTU1eEhJSEROQnVJRU5DYVNPcUpieVhvVVFheVJHSjJZQWJnQTFL?=
 =?utf-8?B?b1VJUWhFczM3QXNKU3p1a0NzVWsveEVOSSs4dkVpa2ltc2JoWG1HN0Z2b2w3?=
 =?utf-8?B?d0ZERHpVM0MxY2RQcFNURUNiSnRackFDN0VRVVBGTWxkUjA3RW9KdnYzZWZE?=
 =?utf-8?B?amNOV2xJWUZBMk41UTZxbmR5RitsR1p0dDQ0cjVZTU4wT1lidzM3SkJnVTJw?=
 =?utf-8?B?YTE1ZXMxN2VScXVvSERNUVRQYjRXVWRFY1lEMjQxNUg0ckx0OUdIWTc3RHJP?=
 =?utf-8?B?ZzV0aUhqa0NxVmZGblo4T3VkYVNTbG1YREFSeFhDUkMxQTYyZEl6c1l1SXRB?=
 =?utf-8?B?OHJmV1l6RnFOQ2pLSHc2NW80VjRTRElKRWc1TGlMQjg3N3VMUlRzcmd1Ty9y?=
 =?utf-8?B?VnJFL3FJb0J6QlEvRzR5R0ZYV3VQOGx3RnBWYURCdXIzM1V4QTVqSEt6Ly94?=
 =?utf-8?B?RE5RVGp4WEZ4TmRhQy8xYTA5cG45L3FTTVRDT2Z3Y21wY1JwdUwzVmcxTGd1?=
 =?utf-8?B?anQ0Ung0R0dtamIwL2p2TlNIYnR5SzRBbGcrRjNOaVo1R2k0citGTHVVUGlE?=
 =?utf-8?B?dy8vVXU4VFVsd2hvVllKRTluamJaNDdsR2ovK05FSGgvd24vUkZDU2g1aHgx?=
 =?utf-8?B?T3lncTIwbU5JOEZrTTBjb1lMTlJNR0F5cERsY2JyTmlDbTRkRFlvR3Vza0xV?=
 =?utf-8?B?cTVJdHMvMEdtYmx6UjhPVTM5dGJwd3cxZUM3YkRMVHRBM0ZoeDJYWXU4eHdR?=
 =?utf-8?B?aGpUeVRsUEVFWTMxVXZVekZwOHMyVlJPSndZY0xiL0hTVTNKRUhwdGVEVWVu?=
 =?utf-8?B?Q3NjbEpQUm1QM3pjV3U4cFdOeWlQandydDVFZG9TUzBZaFlYZVNwU1ptQWhC?=
 =?utf-8?B?TWE3dlQ4Y0hBbW1Nb2F3TEx5TitpWTJPWFJNcUkzNDJZUTdqbGw3dmQ1aVNY?=
 =?utf-8?B?MnRlNnVIWDJqdjN6TzJFeWxqU012bCtDZmx0dktxMCtFZm4yMEREa1lMc2ZJ?=
 =?utf-8?B?OFYvcTkxRmd0UnU1L0ZtUGtqc012bnJNaitHTytGbjFXcUFkNGlHUU1OZ0Vt?=
 =?utf-8?B?WDY4bHhtVkpQQ2wxK3lzMTFxb2IyYklwZVlHZW1ZVTFESFlRTEtaNEtzNEpi?=
 =?utf-8?B?M0RPRms0WGdXTG90TGRJSFRqbmJYQi9PVE94bWZJaEwvZFJSdDcwRWFVRER4?=
 =?utf-8?B?WkxFRXhxRHVBUjg0eGQ4QktmWG8xMGkwTyttTFJPOWxTRkQxL01QV1A4cnN0?=
 =?utf-8?B?dHdPWS9jcDR5ZjdZUHNtNG9RTEpnbVc3Q056amI0Mnl1dFN5MC9TVld6YUtq?=
 =?utf-8?B?azVGVkYwU0NNZEdCS2NGRUdUT1ZHYS9sTGNuZnFFWHpMdTdYR3FlYm5PZS9D?=
 =?utf-8?B?V2IyNHNVQUw1OEpJbmlXSWppNkt0VU5ENlUzejFiUmZTSWNNc3dlWUJSMTA5?=
 =?utf-8?B?T2RoeXJ2RndyZkxFMDEyemIwWlN0RHhtNzI1R3h0dmNUdGYrMlRiTTMzY0Z6?=
 =?utf-8?B?ZTdEUEZxRzJWYkthZlhqTFEzT1RQd1M3NVVTZFcva25mYzY4bi8zSTh4OGlR?=
 =?utf-8?B?ZkFJYnpNc3huamp6QXV0Umx6RjQ5RDlhYUVwWU52WXVXY3kzdGZPaW5JK0Jx?=
 =?utf-8?B?Sld5WWYwTDJCSm81UGRVQTk3V3FLQ3c2TmNOMGh2aEpHYmZwbk1BeUtqbXRs?=
 =?utf-8?Q?G2BQq1s3j0TUR3wRkrwGBH0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	oHrDIrbmt0uHTQBoKvBN32ag5dbINhwXLz8oT604niVm70p7N5fP3lul55DvuQrRBZ/5v+UfMg7Nxul+6MVK9xKfmGjkeavzhcu9SPLfBNAV+yBMJB5+kDvuNYUq6e3Cmy3/85LfBpbrFVnTXO+QeiaEx2f6+7wpmFXM2w6zkOkd5u7FS3vb6EwEXw5Vq09hEUWDEPpJe6u/fqyW3OoVDTbxnyduvfd8kD41zKtgAEDrYNioxX8TxxWgQ20zn5JNkaXEPOYMO2Sz9z+UizM9GltiN8EwH+zETyXlPYvk8dXEjPnibhu9z9Tkeh0nYpPFn4fp08CcQS0RvSuV6be+hCJgHrhne48+RR2aqS6JZLPf2npyQJk3oJRw+iIIFCBV/3LJiBhQjuw8ndSDK9SeRGDR/v+00bRgXhQaKj2FG0eEt/KvwkSMALrdXKpMEosqXIvuC81lTnMQ72k/XyFRwDg4JExPIPENBbvbMKGm7eH5q1JFPyTTtklN4jxdtYBrQDlDwEbc8g1r1u8A7XT6XcIfJLNIhd0OdcHbDhElymVsEeB3632cA0oTwVUv2vTfY7rCXkJsHBQBNBCrbhCeJexnu1vKr7YIFfebciYrXWw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a69ab524-72e5-44b9-722a-08dbfc042492
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 17:51:32.8575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UE9xxEc6/BC/7B0Kr7ZsoSJ0820edePddaHOXCNqAzADt8IZzz4RpK8fecwYg0TYorW6dIH94ObD9ycbCbtRnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6093
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_11,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312130127
X-Proofpoint-GUID: TLhk3zRLrvT8_I5krV1fLobIQd-kvSGX
X-Proofpoint-ORIG-GUID: TLhk3zRLrvT8_I5krV1fLobIQd-kvSGX

On 13/12/2023 14:12, Jiri Olsa wrote:
> Currently the __uprobe_register will return 0 (success) when called with
> negative offset. The reason is that the call to register_for_each_vma and
> then build_map_info won't return error for negative offset. They just won't
> do anything - no matching vma is found so there's no registered breakpoint
> for the uprobe.
> 
> I don't think we can change the behaviour of __uprobe_register and fail
> for negative uprobe offset, because apps might depend on that already.
> 

just my view, but since passing negative offsets never made sense, I
wouldn't be as worried about breaking existing consumers. Regardless of
what a user thought would happen passing a negative value, nothing did,
so that can't have been their intent.

> But I think we can still make the change and check for it on bpf multi
> link syscall level.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  kernel/trace/bpf_trace.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 774cf476a892..0dbf8d9b3ace 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3397,6 +3397,11 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
>  			goto error_free;
>  		}
>  
> +		if (uprobes[i].offset < 0) {
> +			err = -EINVAL;
> +			goto error_free;
> +		}
> +
>  		uprobes[i].link = link;
>  
>  		if (flags & BPF_F_UPROBE_MULTI_RETURN)

