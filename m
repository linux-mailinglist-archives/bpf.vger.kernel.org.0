Return-Path: <bpf+bounces-5264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 194CD7590F0
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 11:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C45682810D0
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 09:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4051097A;
	Wed, 19 Jul 2023 09:02:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5C110949
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 09:02:30 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D1A269E;
	Wed, 19 Jul 2023 02:02:24 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36ILeoWl013661;
	Wed, 19 Jul 2023 09:02:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=vf7bUkoUoM2nMz5xvFUMQh4daCGcRCFxaPNuOSR9sME=;
 b=J5ZPgLtCGNl4Ps6oFT1X3DN5/SweYFOq5U99nAid+t0UuqazcxfSMvEU8g9aaH9Xdj/M
 f1epMVm54coSCgftKntaUc91opMQJWrOx67RqcQ7cu54B7KIpslsfnEB70yOeLtHwKGG
 alrFrZbtYCSw5V2to/SDm+aOfs+rrIq1anyiHBhhlh+rQGhJD73m9E2nhcZxMLiDdJnw
 HA4UlApcQXFOnUKJyjNjWL707Fx2KzjUFZaLOkH3n4OIAmoQG96pTnhXpTGkqyPnhWZA
 PNoEBWNw8y8gkwSxs4CW8ru+adwkh8gIKiRi3lWCKQmrjf4lLgqBgzYxWpPtTukvi6ZU ZQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run89y2se-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jul 2023 09:02:16 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36J7XSYV019258;
	Wed, 19 Jul 2023 09:02:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw6yvub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jul 2023 09:02:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFS4E2vaGyEXKp22SgL+mZpQYICtlDeT6okNcH5oXAxv4DSYGubcDvYTXWThmMaH6VnNEEoEvj6ICssA7BercnTkz2W92eAYg8uhFBMSdQxpJt13yF5ASuZX/R/paSZ8Ns2taKH8MoooeRKuIhM/gM5GQMqAhpR10dXz0UdCAhHFjcnZXbICWIYw53+FCJgTRyylnM4Zz8lkBh+bQlXg2zdqd9nR8tr7PfM4wdyLcmSfdIt+AR0SdaRNO2G8Qyj/w83zBTqX5LecZTzwArIYQ2AvQq/yKomSylI46KcRi28uE//6tTccQspI/0MYpbZ8/4hGi61M8aW0qVHoj64MSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vf7bUkoUoM2nMz5xvFUMQh4daCGcRCFxaPNuOSR9sME=;
 b=dgHTS2VjTr61t+IN1jt6poj7cZQdTg06qcmbb99CCt4tprEdQDol1Cr5CKV5TFitYpAgUtWtzCmuL2XZ/vsw30btYH0j0szr4CFliUfIaknrfw3RcdfceHmyzJaLi1e7u5VuQVHL9T2eN8fBk3AA3KgFD9dJOerSW+Iq+GgsciQOYyMymKRfZYzxRXwbiY00FzRpxyE/iOVtK0cRj/mRwJHCaLR+pYT+1SzfdWQi8GHL9R3X1ZsQ5W0F+OnlQFRWpWPOCPr+08xC1Ai/FWAcqrPhG1TkXUFL2HishVHGGQHu98YmNFtgXgmtRReaEoVjYZEcjbydGWBA36HnBl2FAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vf7bUkoUoM2nMz5xvFUMQh4daCGcRCFxaPNuOSR9sME=;
 b=kHFTZ+12ApZcr1/atZgSU7K507aByDTKWyI6mUxMQpNvoibrS+rIWj1GkWfD3gD7Yt/yJlEQYpNZcTdgQE0MQmjzNy0asZBvXnn/Y5updqgJTB8jxUKSDL25NLPEhiDS82iVI1lrnlnG8XCX2QnVSlDbkLjQW4X4OLC8/W5uDBk=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ0PR10MB5648.namprd10.prod.outlook.com (2603:10b6:a03:3e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Wed, 19 Jul
 2023 09:02:12 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f%4]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 09:02:12 +0000
Message-ID: <e002b414-0e12-0ee8-08a9-2a2b2f21c7bc@oracle.com>
Date: Wed, 19 Jul 2023 10:02:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 0/9] tracing: Improbe BTF support on probe events
Content-Language: en-GB
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>
References: <168960739768.34107.15145201749042174448.stgit@devnote2>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <168960739768.34107.15145201749042174448.stgit@devnote2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0679.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::12) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SJ0PR10MB5648:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b3f8816-a9fa-43a7-5c73-08db8836d69a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	k24F7f1o0hAULFyG6BiP+/N81e1qinKh69dNfJxOgsHxJaFO43jPlzGqOhS01NS/2PbDXJpaTqS6aWTRtXWqEBnuLdJZi49znxLo4Zvdqhq8k5Hjg2X52kIX0XR1+WpBwCxqXuv0i3fsr6dYKdCALkmk7wEGEW6BCTSf3tREzld2pklCBnc/b8/TKl9H26/HvuDdEbqmK02KML+CRjqftq43nZd9ci1fTR21KVkSeLtEHrcbdqK53PkO5GK8MFoSxVsLtmArUS359ShU7maGlUrFlTBvOOpcPjaRZXaZnb96esa06Gp/NzWMUZWIM2hXY0rpmvm4ZR40fIsyS8XpIqou7hTPwLBSeLPf12ggo8Duqj9B5WV07CoUxnMKqXMuvaSKHRkL5tmazMoGe5d3HN5ZNGHZUl1NIih9hTTZp6iaZqKCuHOPCzaiEQ7ObdCkk/OPtgvhgfArrYts7CdMcKIzQOhVuY97Izi44AZKDJOXk3TinlKAxcWCI+YBHRuP4S4gTFVRn9v9QvwPi6MC/2ytMry0hXHDPO791X75XBuGOEWBsaOU4bUXR5xfglxUDKUhiotMR4x/UeGQu9Ctpvj2yx/zef6sobisiKEYHWBg/uDLFNq+6nRRsiWeueERSXltNj+n+drLMMiG8PnXn/0KB+3WUoDnxK+gC6aBbuHsBpuKxiY4Xv+rY4ujOyKS
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(396003)(346002)(39860400002)(451199021)(53546011)(6506007)(41300700001)(316002)(31686004)(186003)(966005)(6512007)(2616005)(83380400001)(6486002)(478600001)(54906003)(6666004)(66556008)(66476007)(4326008)(44832011)(66946007)(38100700002)(86362001)(31696002)(8936002)(5660300002)(36756003)(8676002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TGpaR3NNQXM4SDRhcWxnVnAxTzFFeHFZWEhCZmNrVmR5Y2QxdFY5SDZ1YzF1?=
 =?utf-8?B?bkZGSFdzcnphNUl0UUVLb0I2UG1qRHlmR25nV1JZdlI2cnZ4SDlLZWJyREw5?=
 =?utf-8?B?Y1FIMFp6VmgxdlBKN3dIOFpDakF0V0FVN2cvZGlEVTYyUlRpWW0yQnZCNXlv?=
 =?utf-8?B?eVJOSjlETW9NaUhkZ3FEOEhLUFFRUFVZL0k3NDl1NEtPbm9oSWJlYlk3Y0Vh?=
 =?utf-8?B?UXRaazVVTGpVQ2pSdWNrWk52MmNtV08vbEV4N2lwaExiSHpod2FIM3BHQTFE?=
 =?utf-8?B?UzlrTGY0ejRONVpqR1JNZVZBRVIyY3VCaHAwTjdWWklEVjBZQUdKSWo2ell3?=
 =?utf-8?B?NS9aOWd5VisrL1Z2NTBGNjNrM2ViK0dVdVh5VU5Wa3BORnVwYXgrOWZ0NDBK?=
 =?utf-8?B?L3NsRmQ2TGc4czBPSHB5aWN1eXk3Tk9pTmNWRW0zVTk4MUhBVWRPbnhHdk45?=
 =?utf-8?B?MGdmZUs5UU45alpwdGk3akRnb0tMMGJzMzZXSnZZUUE5RnNJWFRLUk16Zysv?=
 =?utf-8?B?NHNiR2Q2a2NROHNrRVlWZFk0M1J4TDMweE1vMXR3azd4bW81L3Rybjh5Z2FX?=
 =?utf-8?B?a2gxQWV1K0RoUWNNczZKRXgvRUlCRzJRL2hZTXRZM0hEaHoyS1NmRDFtc0lW?=
 =?utf-8?B?TW55blU5NU94M0ZBcE1VbE9DUWNCWXBuV0UrakhoRGlWL29XSjRjY3JOQnM3?=
 =?utf-8?B?azNXYkE4TkJtcGRVQmFFN1BGUzdzQ0ErQ1lFOTBSWXVaa1cvcDRpN0RCOENi?=
 =?utf-8?B?VHc4U1lUL0c4TExMUWlwY0pIdDlSWXhRcjZGMWhZVU1GNkNOcmU3MWl5cGEw?=
 =?utf-8?B?eGhYNDZGblN6R2U3YlFRSGt1bzlvZzllMzFMLzk4b0Z1ZGcxbFVmOGVxT0g0?=
 =?utf-8?B?ZUZrTnU3bDlmclhrQjM3cmtRRWxSQWJkTFhOcTExWHc4cWRVSUJ5OThCTTha?=
 =?utf-8?B?UEhqOUZvUzBBc1BhdjFWUE44amVoaE5mbkNjOFRLbDJQYTlpK0pBQ3pKSHY1?=
 =?utf-8?B?a0VXM3ZMQlNJd25BQ2hjWVFpTmZsaEZ3Q3YvaU1abVJUejY0WUw3ckRDQzVC?=
 =?utf-8?B?VFZWSUw2YTVVaTRVVW5tc1ptOHFYM3VzL1d0ZWswWXBlZ3JwL21iY3JFSk1K?=
 =?utf-8?B?OEJIeWJCT0JQZzZlTHUrVFFYeDJlazNJejdJUXdmd2tQV2dYNjJFUEN6OG5y?=
 =?utf-8?B?SGRmSi9lOFo3VEpraElTRzlvVWFVZ2I1T1R0ZWxJL2RvRVFDSmRXTDBHMzVU?=
 =?utf-8?B?R2xuVmI0N3V5M0g1a2xFVVB3OUpsWUQva2QzN2ZPWG1UaUlOOTE5RkNtWGtG?=
 =?utf-8?B?RE12YmpVV1pYT3JCWjZDeWw2VmhjS244a1BabnlxaDB0NXJERnRoV3QyNGNQ?=
 =?utf-8?B?TEFyZUNleDFMRDZUemtzZkNyUXRHTXUxM1d0ZFBsNktmeENWRWkvc2t3Q1kx?=
 =?utf-8?B?Mzl2cnpLSlZsNElsZ2hYeE00TkhGU2RZREI3VWVjYmhBMFRKanRZNE11ZWZ6?=
 =?utf-8?B?VWxlM2o3dEdsTEp3Z2c4Vm83MGI3ZE55WWsrNW1TNTJ2SlRuck1vTFpvb1g0?=
 =?utf-8?B?WnpSTmFaajF2VkxFTFRYcjA5MEJtS3pLNjlPZnZMOVVDRmRZdWJPbEFNcU1B?=
 =?utf-8?B?RzBVV3RFWGhyNERoeGkrbGxvVjc3a3Z1L3Q5MDJON3VXVGtURzJHTTRoaENR?=
 =?utf-8?B?QVBEUVQrNnFab3hYUUVxS2xTT1hFMHFIc052b0x5c0pnUWJpeW9OcGxMemRv?=
 =?utf-8?B?cnlpL0dIMThyWUJTR3ZLZEtHOUNBQitEQ2p5WW0yVlh6S1U4SXp3TUdzcXM0?=
 =?utf-8?B?ZXZCeHJ6bDRpV3NDZzRabm1TNmltUEFtanY3alVZdHRjMGROKzExSHBnMzVz?=
 =?utf-8?B?cmh0TnF0Kzk0UXpGcE9JREc0TnE0SzBSakhTdnY2KytRcnVuUlQ4ZmJWTTU4?=
 =?utf-8?B?dmdwNWMrQ2RqeTlZU3FmeDlNRmRCQ2YyZDgwWVpBdTNJZHhkOWtYMG5WQlY1?=
 =?utf-8?B?b2duSEdBMTlNZGNJY21wMHJzSWw4NWNxTEVsSXlnSTVYMmRrdkt4Zk1PSFNq?=
 =?utf-8?B?cXJhYnJ0K1JJakdpcC82YU9KWmdXUHl5M3JwK215RXZEazVuYTdCVkZKaENB?=
 =?utf-8?B?RGh3aDhoa1NTNnRlTURPSzFzMy93L3N1c0E2SWRhKzhiNXNjNEZGaUJpY0xZ?=
 =?utf-8?Q?C8T1mLExbT6ZiQvzuR2dr/g=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	4h1lbUV7aoxP8VLwpM40MSDpQImFNdIcZUBs9ZK20hjUjT5Hs0a5yw1FfN/NTx8Slb1pUUSUmKOjiqgP9MkrgZZ9rKhG8NdaGKEcbH7NXZPfvXzBPYaUJrESwJogJtD/6XTX+YKgsRRdSfpkzl2bU1zjiHvCFoCCesBhbt8w/zWIkPCBi+PnLOpprv9eu2byuyT8BGxPEEdnDBdGDe60cl8M4wbNGUf6dARPfHHrZgRy1wKT91JCdH3hOR1v80WEu4CwiCT6iuFIm7ERMaM6Py2VDofFgnHezcRqXRWE39gURSOaiC91tp+agyvtZcH+YYY0FAU0m7dmiCH0A8TqegFW0j27ELWUEJ3NJ9c/5XDry0MN7SIgAht2yTZtEN7aEKw45HdSOLwG/8EcMwY+aYOyiyiuu+dXTn0JKWXjr2trdMO8u+Q54qD0vKfirtnBfioX5YSZG4YDPfKHAIZt71U22aokEiLBS1f06n7ubX+ZlBg7Pb5sdkf61uP3a680ze8BDl9YVDs0kvBeJBp01uS9Cou7bvauLQWyRlKcAgTZmFHgfSUrHWJ0YphTPpRiV0fwMdWN4jfYpXTurx/OJg/EV4ucGzzOWHyL8qxVnXCkt5UEUOZHaCK8myCfPNMN6EuqAZ5uw0lwlcF50iNXT+xRMAFA2yc8sKg62WsARRnKKObS7Rltz4VqhE1h1wtuHMAPctTl3op6/wUAyWWq5YIMD2+JOrE54rNZIphOkiuJxg81L/Jl6ump4GUkuFKe5zN5f3u4lQMdV9Z913a1nqMEzAOMdyZoNwaWWp2uSQGDUQpVYfLgO4IvSs387E18EYQMbkpeuXnfjSVL5nbq38lYRMF+z5vfPSeAr79xZmyZhUeqmjzkpInbgUII1oTr
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3f8816-a9fa-43a7-5c73-08db8836d69a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 09:02:11.4995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R58+0v3oGJRCxq+Z9K2r/QPOcLDb9b1SJb0ZOcF0oh1hu3/8hpY2fal+lfV04jf9wFIQZy7SQBPcyPP2DTzq1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5648
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_05,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190082
X-Proofpoint-ORIG-GUID: UUipyJw9d919Rp3F14AXo28CSEO5Qg7G
X-Proofpoint-GUID: UUipyJw9d919Rp3F14AXo28CSEO5Qg7G
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 17/07/2023 16:23, Masami Hiramatsu (Google) wrote:
> Hi,
> 
> Here is the 2nd version of series to improve the BTF support on probe events.
> The previous series is here:
> 
> https://lore.kernel.org/linux-trace-kernel/168699521817.528797.13179901018528120324.stgit@mhiramat.roam.corp.google.com/
> 
> In this version, I added a NULL check fix patch [1/9] (which will go to
> fixes branch) and move BTF related API to kernel/bpf/btf.c [2/9] and add
> a new BTF API [3/9] so that anyone can reuse it.
> Also I decided to use '$retval' directly instead of 'retval' pseudo BTF
> variable for field access at [5/9] because I introduced an idea to choose
> function 'exit' event automatically if '$retval' is used [7/9]. With that
> change, we can not use 'retval' because if a function has 'retval'
> argument, we can not decide 'f func retval' is function exit or entry.

this is fantastic work! (FWIW I ran into the retval argument issue with
ksnoop as well; I got around it by using "return" to signify the return
value since as a reserved word it won't clash with a variable name.
However in the trace subsystem context retval is used extensively so
makes sense to stick with that).

One thing we should probably figure out is a common approach to handling
ambiguous static functions that will work across ftrace and BPF.  A few
edge cases that are worth figuring out:

1. a static function with the same name exists in multiple modules,
either with different or identical function signatures
2. a static function has .isra.0 and other gcc suffixes applied to
static functions during optimization

As Alexei mentioned, we're still working on 1, so it would be good
to figure out a naming scheme that works well in both ftrace and BPF
contexts. There are a few hundred of these ambiguous functions. My
reading of the fprobe docs seems to suggest that there is no mechanism
to specify a specific module for a given symbol (as in ftrace filters),
is that right?

Jiri led a session on this topic at LSF/MM/BPF ; perhaps we should
carve out some time at Plumbers to discuss this?

With respect to 2, pahole v1.25 will generate representations for these
"."-suffixed functions in BTF via --btf_gen_optimized [1]. (BTF
representation is skipped if the optimizations impact on the registers
used for function arguments; if these don't match calling conventions
due to optimized-out params, we don't represent the function in BTF,
as the tracing expectations are violated).

However the BTF function name - in line with DWARF representation -
will not have the .isra suffix. So the thing to bear in mind is if
you use the function name with suffix as the fprobe function name,
a BTF lookup of that exact ("foo.isra.0") name will not find anything,
while a lookup of "foo" will succeed. I'll add some specifics in your
patch doing the lookups, but just wanted to highlight the issue at
the top-level.

Thanks!

Alan

[1]
https://lore.kernel.org/bpf/1675790102-23037-1-git-send-email-alan.maguire@oracle.com/

> Selftest test case [8/9] and document [9/9] are also updated according to
> those changes.
> 
> This series can be applied on top of "v6.5-rc2" kernel.
> 
> You can also get this series from:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git topic/fprobe-event-ext
> 
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (Google) (9):
>       tracing/probes: Fix to add NULL check for BTF APIs
>       bpf/btf: tracing: Move finding func-proto API and getting func-param API to BTF
>       bpf/btf: Add a function to search a member of a struct/union
>       tracing/probes: Support BTF based data structure field access
>       tracing/probes: Support BTF field access from $retval
>       tracing/probes: Add string type check with BTF
>       tracing/fprobe-event: Assume fprobe is a return event by $retval
>       selftests/ftrace: Add BTF fields access testcases
>       Documentation: tracing: Update fprobe event example with BTF field
> 
> 
>  Documentation/trace/fprobetrace.rst                |   50 ++
>  include/linux/btf.h                                |    7 
>  kernel/bpf/btf.c                                   |   83 ++++
>  kernel/trace/trace_fprobe.c                        |   58 ++-
>  kernel/trace/trace_probe.c                         |  402 +++++++++++++++-----
>  kernel/trace/trace_probe.h                         |   12 +
>  .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |   11 +
>  .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    6 
>  8 files changed, 503 insertions(+), 126 deletions(-)
> 
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 

