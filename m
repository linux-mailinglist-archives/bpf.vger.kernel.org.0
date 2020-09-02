Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183DC25A50A
	for <lists+bpf@lfdr.de>; Wed,  2 Sep 2020 07:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgIBFav (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Sep 2020 01:30:51 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:19914 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725774AbgIBFau (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Sep 2020 01:30:50 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0825QetU000774;
        Tue, 1 Sep 2020 22:30:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=xv5nrpVg2RPHC5LKd/+T1M/5C7mKpm4ZFrKo9aXNJvY=;
 b=glakjxPqtxXjQPqdS1/FDlO7hYXoGxHX6PT7KGPAcwo4X6CPs6X5JsR5uvTeLm3l0ORd
 qTVXm3zch4vUarSPxAuCe0cckgxrMzM22Zq5+ziUNJY8Uy+M0YGEHYPnydRlUZyZ6LOy
 HoiPN6fAMv0RpJ02w3OPixYkTUmOLOkz9+s= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33a4cn87n2-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 01 Sep 2020 22:30:36 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 1 Sep 2020 22:30:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2+ZGEtoB4TUZ57+objq1aHlS2NXJAhA/f9b7DSzXtq0R6imefvqgHB683DS6uPqugb0yGZHEJyJB/3QodxO3M8MUeR+tn02WuEiorsQsj58zxLnFmBHp5L/kJ3ItJkqjIM9Q85a92o4I6jFp46U4wYoU9zjA7x9ohulSrPixzSWuyVYbS7p1uWPrHP5tIjvVdFj5mmR6X2wKD5+JfhI66ZmCufaooMEARQlVAidJJIm2ReVG91I29X3QN7bvj+Yp4xMrrFW6rV/mxoDI14H838r5+45nsbWNiK/oVOvdVr4ubRLitEfRoGR8eAd6h085OAnBvJO2mlGhvYQ+xeVpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xv5nrpVg2RPHC5LKd/+T1M/5C7mKpm4ZFrKo9aXNJvY=;
 b=SOvYckhO3IDCQKdRMmCymqPaAFt23Su1EtdZD6eetPv50bIFLoikDVCxiLzAI+mFF/zoJ4LWFFvbVZusis7jpEC5Scd58vOjqUtTvLnt+2Q0JBr2thGBasqpdRbSn5MCdRVG8lXYA8JOSNG5Z6sZQJbp3F82I45md2ULqr6NnJx9ZiM6PafWNe+S5lRno4vssJfUMswOVny6e4zHqEHtG5gVR584b751Jy8sIzxNy7goAjoHnBVKhXjXcNW1en9hBXQ+Jq8RbDIFnjfk6l/7jWLBqGetvL+aXbYDGEfkLv6UKfpoW6yTJT8GyomcGy/CMQMYX+/MssfP5owuHWHfnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xv5nrpVg2RPHC5LKd/+T1M/5C7mKpm4ZFrKo9aXNJvY=;
 b=VgG/wRC73hP0JC786W5AYA4EKXhv3Kt7mnuds3lt8Ium1lnB5mu4qzby+tt1PkjJNUttJpdSBz4/TYmKdlt2YBmbI2AOvfhEGrqVrdfoeDiVxHZ1Z/uCLyccfnJHb2DN8M9JfNiBRfH7NZONVjrsEWV5595I/E4+8V7BoukBB7g=
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2727.namprd15.prod.outlook.com (2603:10b6:a03:15b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Wed, 2 Sep
 2020 05:30:33 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80%7]) with mapi id 15.20.3348.015; Wed, 2 Sep 2020
 05:30:33 +0000
Subject: Re: [PATCH bpf-next v2 0/4] Sockmap iterator
To:     Lorenz Bauer <lmb@cloudflare.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <jakub@cloudflare.com>,
        <john.fastabend@gmail.com>
CC:     <bpf@vger.kernel.org>, <kernel-team@cloudflare.com>
References: <20200901103210.54607-1-lmb@cloudflare.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <62c06371-485b-7b0c-d824-864b09b1ee69@fb.com>
Date:   Tue, 1 Sep 2020 22:30:31 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
In-Reply-To: <20200901103210.54607-1-lmb@cloudflare.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0035.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::48) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BYAPR07CA0035.namprd07.prod.outlook.com (2603:10b6:a02:bc::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Wed, 2 Sep 2020 05:30:33 +0000
X-Originating-IP: [2620:10d:c090:400::5:b90d]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26b175d4-7a5a-4da2-d64a-08d84f01503e
X-MS-TrafficTypeDiagnostic: BYAPR15MB2727:
X-Microsoft-Antispam-PRVS: <BYAPR15MB272720CC553F42FADB9F49F8D32F0@BYAPR15MB2727.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 59V1UvxL+lSssztRIL7mtbFuLiYZ4SyKrItRynWpF+r/7KWgZz5dPJDyfwL6y/3pJ8smDbJi4aotOwktaOVT9J4Hore2JmPDcNrjPRClNdMO/It+pkoRyzvaFhDT6QfBh5+5UUN8LPILv4vZesatOxQLd2+yem5aqO4UAgqZkZrrKNWKu1F7c2VycwQjlwKjE7Msxzf9QE1zbUbJ7+zmjGbBEvtn6aRBGU/6FRx2r5He7c1abIvQGMw1k06Aq7Hnsfck+4Dq997etd6ND34EEcKT2iYa1BkyWc9pd+6H4ZCgyNlRuehht+BSxVfZAb2pDvIcJVSkB/eN/aD5m6bk+4oeLVbHoBI13K0y6SLXptcke8i/6fPQ59JlQqM0jkmA95R26U9V9PS64R2FNkD2oiPLRveeAjPgvB8UFn2CbmX3Jd2kp84UcihG9pESLCuZSG5lX+35XKwAXjbvzOcz3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39860400002)(346002)(136003)(366004)(8936002)(66556008)(316002)(2616005)(2906002)(8676002)(52116002)(186003)(6486002)(66946007)(31696002)(5660300002)(36756003)(86362001)(956004)(66476007)(53546011)(83380400001)(4326008)(16576012)(31686004)(966005)(478600001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: ZSvjXTWM2bvbvadymEwLX0Q7hiEr35St/ZHpV44IPcIsHQRP0TUcShrMRf1KCZBCOAMCIa/QhZ+FS7CJ54fbx1xLVKAu7oHWJh7nxM8QTHKMWhAJTl0SkEDBvLrV/pTcZZLcUAY61WyjS2YbzBn/nZPpID8vyUiOhMeJSl4R1jFXLbk/lf3l1a570ODUJjjf5UJQXAFYnaYHfeXXbRqjiHWAJdg1IzTBgNbF63mErttLUGNpJzmvU1CBN8S6DhbPh206YftO+XLaFse7NCQiz0wr1lstpCWIxw3aGs/57rl7svab/hUlKn7wdwG4jWp30JZhuW9PFySwrgkW0fX+tTqqiVXw6tl8kEFOQ3mToPXdVAgA6YWHvG4wefwMknnOlD1UuHgievqDN0JN7NbVZr2gcLZXARwNlGn36aZte3L5YPMpfA5Qn3w8d5NVRIUp1kChUpQ/2BVbhgsSj2uWSsgYwXs+7JmAX2cRf7iFENphj9DR73/jb+iVovA9AR1W/aPYXbr58De0mkrFgwafk4DUbjGQU7+H7k6Pk4uJ71MIEWsmCzh177/5cbT5UpBdoYSEbkfnwQQAAMiS8pqXnGCrE8j+PwXkuF0wOYGA/uibev3BeQ+qKLS4NaqwCoivyq9nddfFJjY2FvOdqry0n9cezlEWCrsjZMDFYeFaDNw=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b175d4-7a5a-4da2-d64a-08d84f01503e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 05:30:33.4481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qwV/EXUQo5mg5uF21oyc8wRIIQmWXiszQRpukirqCeqkfWXHWYHT50fxROX7Wr3O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2727
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-02_03:2020-09-01,2020-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009020052
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/1/20 3:32 AM, Lorenz Bauer wrote:
> This addresses Jakub's feedback for the v1 [1]. Outstanding issues are:
> 
> * Can we use rcu_dereference instead of rcu_dereference_raw?
> * Is it OK to not take the bucket lock?
> * Can we teach the verifier that PTR_TO_BTF_ID can be the same as PTR_TO_SOCKET?

For the last question, I see current implementation is

+	.ctx_arg_info		= {
+		{ offsetof(struct bpf_iter__sockmap, key),
+		  PTR_TO_RDONLY_BUF_OR_NULL },
+		{ offsetof(struct bpf_iter__sockmap, sk),
+		  PTR_TO_SOCKET_OR_NULL },
+	},

The PTR_TO_BTF_ID might be better as it provides more flexibility and
more fields to access. If in the verifier PTR_TO_SOCKET reg type
is desired, you could add a callback somewhere to check:
    if the type is PTR_TO_BTF_ID and the btf_id is 'struct socket",
    then you can convert reg type to PTR_TO_SOCKET_OR_NULL.
PTR_TO_SOCK_OR_NULL is used here since PTR_TO_BTF_ID might be
a null pointer.

We could add a bit in register state to indicate a PTR_TO_BTF_ID
could be possibly null or not. For example, a conversion from
PTR_TO_BTF_ID_OR_NULL to PTR_TO_BTF_ID will yield non-null btf_id.
A pointer tracing will yield a possible-null btf_id. If we have this,
it is possible to convert a PTR_TO_BTF_ID to PTR_TO_SOCKET.

> 
> Changes in v2:
> - Remove unnecessary sk_fullsock checks (Jakub)
> - Nits for test output (Jakub)
> - Increase number of sockets in tests to 64 (Jakub)
> - Handle ENOENT in tests (Jakub)
> - Actually test SOCKHASH iteration (myself)
> - Fix SOCKHASH iterator initialization (myself)
> 
> 1: https://lore.kernel.org/bpf/20200828094834.23290-1-lmb@cloudflare.com/
> 
> Lorenz Bauer (4):
>    net: sockmap: Remove unnecessary sk_fullsock checks
>    net: Allow iterating sockmap and sockhash
>    selftests: bpf: Add helper to compare socket cookies
>    selftests: bpf: Test copying a sockmap via bpf_iter
> 
>   net/core/sock_map.c                           | 287 +++++++++++++++++-
>   .../selftests/bpf/prog_tests/sockmap_basic.c  | 141 ++++++++-
>   tools/testing/selftests/bpf/progs/bpf_iter.h  |   9 +
>   .../selftests/bpf/progs/bpf_iter_sockmap.c    |  58 ++++
>   .../selftests/bpf/progs/bpf_iter_sockmap.h    |   3 +
>   5 files changed, 482 insertions(+), 16 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c
>   create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_sockmap.h
> 
