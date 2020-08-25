Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5980C251F1F
	for <lists+bpf@lfdr.de>; Tue, 25 Aug 2020 20:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgHYSfK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Aug 2020 14:35:10 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:64858 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726432AbgHYSfJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 25 Aug 2020 14:35:09 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07PIUwQh024609;
        Tue, 25 Aug 2020 11:35:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=wRV1DPHKK+2kCdLh1p00Qti68fTOI47k/fhYbnmuIh0=;
 b=XKMgvtrejE644ZWx7hVCigGSTfBIbc6JZxueQJQjMvcJyAozBArtNd7PApWvkLkiUjgk
 uxNfsz4Nq52UXY1nJmpD9bNyGjWHfE7vgYs+O3mK+DGwuU6TKHoCul/l7oF+78lTTuDr
 UbMt8DdSpwLKvGzKr4ZUTfOcOZx2XodKT1I= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33313tqc0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 25 Aug 2020 11:35:07 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 25 Aug 2020 11:35:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+pmUf1SorHeKvqs65huCBD2AxT4QZew+BvtKpBkioCyFdSB1xvYcD3goxT0zFukejN1fS8Mik/iaqvgWgsK1cxfeAZxIIfflBaV+m0ZgEAK9rFsfSxb5A8MO+MYdI2BptQk4k7lkASXmBoeJOA4E4N3ivk8Kpai1Phrg6Pdpc5gKIkLiwC6I38MECKt+RfDRJtbzyRQFtQfZApOGG2540ZpFTnJE/GE1BGDs/pTbdENjVesHjASipQVBo0Rx7gj7htemTHKHT9vKmL/VVITaGyH/RVsS9CAAyVxOs6UMuFsbrYZrNZg9JI2NZoS3MNCpWYYpwVh3KK2VuFDtpqBqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRV1DPHKK+2kCdLh1p00Qti68fTOI47k/fhYbnmuIh0=;
 b=EbtXP8mMrCkSXvaesPw9g0pTnbWmG8LWMrusYh8eGdpvn9K90RVZyuuPz41u3VsJdihHBV9pmWqsxU8xd/pBMUOjOTZZBqS/iK7vfiKOYm9FDxNNbXW3oWDZEZu7Gk/rufWM/4kUXDUshSZe2JWtkVHjTdMxTghjRhm7s62AEq2VgNBZmTg29Yao173WXfFaCYROwwqMY9i4mGm8Wayu7cLJwd6A6lq/FLEnKIbrJeubw5og2BABzSTJg6UL4UYZ1R/74OCLoyqab3NllylFkJD+0azljY4nDIKtnTrZobhtpGyVbvikm09Nv9ZIlLAeIARggDmD8NvRyWdSBYJenQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRV1DPHKK+2kCdLh1p00Qti68fTOI47k/fhYbnmuIh0=;
 b=LUy8Bmy3VGAPL05uLWYEt1QI539PD1cK0Rr0y/jUWuqD89lbhqgPzvVwXgQyJ3WtFkW3WQUdr/CaI0pyClspteq/pihoiwXSaLF6Iq6oUxdSFkQ+DTjYfYwC/t0suMYnIZvgpg9pcVjUs/EhLI5GYDFxb/VT4Q3OGn7BoB+Yumw=
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2887.namprd15.prod.outlook.com (2603:10b6:a03:f9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Tue, 25 Aug
 2020 18:35:05 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80%7]) with mapi id 15.20.3305.031; Tue, 25 Aug 2020
 18:35:05 +0000
Subject: Re: Adding sockmap element iterator
To:     Lorenz Bauer <lmb@cloudflare.com>, bpf <bpf@vger.kernel.org>
CC:     kernel-team <kernel-team@cloudflare.com>
References: <CACAyw984Z3YiQPtVOZkSYzxOECHOhJKKe8d4=g9eDu0OK9Nq6Q@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <b8525d39-5380-c1fe-55e1-c3be47f69c56@fb.com>
Date:   Tue, 25 Aug 2020 11:35:00 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
In-Reply-To: <CACAyw984Z3YiQPtVOZkSYzxOECHOhJKKe8d4=g9eDu0OK9Nq6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:208:160::32) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR13CA0019.namprd13.prod.outlook.com (2603:10b6:208:160::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.10 via Frontend Transport; Tue, 25 Aug 2020 18:35:04 +0000
X-Originating-IP: [2620:10d:c091:480::1:67a7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 841a8dee-4710-4b02-fee3-08d8492595b7
X-MS-TrafficTypeDiagnostic: BYAPR15MB2887:
X-Microsoft-Antispam-PRVS: <BYAPR15MB28872D84126DD62ABB087717D3570@BYAPR15MB2887.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UkFOG2XUXuSZanv6yFt9XdbvcS4dsmt0+vPfX0fw4TQ48F/cevoMqJ4aQ53+mtixbfVBmctvyLXRH9xhhdrcwiIW2fIFqsJSWYCadWxgIy9+ed+3uUPDb/WzkDyvFqtHMi3HgWmBp6EasuvmTMKBTepjRH+JhCdvUwbywVyD7IA/mAr7sG9VkHFQz56LpzyAMjkV2q+uWoLO/6A6l2VoJQE8nFloEDkVXb4PrX4E+jqMD0rUGizEY6t46l5exWmIeyAfdZ4GV1gS9w7v73n7KQZn1tWgHwvH4NEz/v/fRas5qz02rWCL2XvLXdHJSCbSz/UEJMdHO6z/CgSlxT+PVPHBjB2mmnsB1ViouCl2pIAFZrHadogMkEdV8Su8O7pT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(39860400002)(366004)(136003)(36756003)(86362001)(66556008)(4326008)(83380400001)(31696002)(66946007)(53546011)(6666004)(66476007)(186003)(5660300002)(52116002)(6486002)(316002)(956004)(110136005)(16576012)(8936002)(3480700007)(2906002)(478600001)(2616005)(31686004)(8676002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: lpft4d/23Xm596pJblRV/SvthVN1hRzlf9SlpO/WWpMmhy69qO/7wXMJOiEbQyp3wGEaDAAtAppCB3EPLPcLPwE+ICyuBPSYvQA+TO8uGiuHdifzI5+RcNvBuuzYYP8wpKv/Ylfcs0MtS4Ae2tGNwHagIWw4TlLZooQQTdj+LAEGKcIIdcK2MsQUcCQr0vW9APUp7ffVgue620SEPgDT42HpgLKloenRhIwMY550IL7wRdr12QjAIRX0RvZbYfI5yhkfdQzLnS0c1YJeu7eu0rTUqcdRKw27Dgri+FVGLJali1l6nk2vOaYwCwfQFzBue44xyJOPteao6Wpge2HJLk9/bp5JlB4PseoKZbS+H6Rk/WFhenfVOQQcoQgxfHFcmQRC3QkdpzhuWivHm3XMIvi2xdvG/eu/u72erJ9Y5PlKXiBgXscLLJdm8vwqlMbtSmpPG578qk2RattLH91IR53/DLnfWdEocK2AiVaMPQJ6NTsZg/tepRKBZpUG6yIN0U2GPT1VNsSTeNaJAGMQ471umK2hGCIIDrfXt+jFOS2mEN+Z53rjldnQL5k204WsjyUqFbXYTgIgRQMk3e/dOiVnppdNBb7+myP7N1qDJKgQJ9+lEj4PYVG4uyCtMcVFh0O1OBPikBd9PZCJf/wUMPI1Unre9mhtc9z0TkI+Q8AXd0k7vlG5NAKUBw0AXdhW
X-MS-Exchange-CrossTenant-Network-Message-Id: 841a8dee-4710-4b02-fee3-08d8492595b7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 18:35:05.1733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZOlgyOHFxJgHdp2ukpY5tpbG747eAguqZazzPDJF+u8cphPmXYwv7D8xz/OZytM5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2887
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-25_08:2020-08-25,2020-08-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250139
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/25/20 10:44 AM, Lorenz Bauer wrote:
> Hi Yonghong,
> 
> I'm currently looking at adding support to iterate sockmap elements.
> For that purpose, the context passed to the iterator program needs to
> contain PTR_TO_SOCKET, like so:
> 
>      .ctx_arg_info = {
>          { offsetof(struct bpf_iter__bpf_map_elem, key),
>            PTR_TO_RDONLY_BUF_OR_NULL },
>          { offsetof(struct bpf_iter__bpf_map_elem, value),
>            PTR_TO_SOCKET },
>      },
> 
> This is in contrast to PTR_TO_RDWR_BUF_OR_NULL. I think I could just
> add a separate bpf_sockmap_elem iterator, but I'm guessing that this
> is counter to how you would approach this. What do you think is the
> best way to achieve this?

We already has a special case for bpf_sk_storage map which has
         .ctx_arg_info           = {
                 { offsetof(struct bpf_iter__bpf_sk_storage_map, sk),
                   PTR_TO_BTF_ID_OR_NULL },
                 { offsetof(struct bpf_iter__bpf_sk_storage_map, value),
                   PTR_TO_RDWR_BUF_OR_NULL },
         },

In this case, the key is a sock pointer represented as a BTF_ID_OR_NULL.
This way, the bpf program is able to access all fields and do pointer
tracing in sock structure.

In your case, sockmap and sockhash should be able to share
the same bpf program signature (similar to hash map and array map
sharing the same). It is totally okay to define a different signature.
The general key/value as a buf signature won't work for bpf_sk_storage 
either.

Maybe rename it to be bpf_iter__bpf_sockmap? For the value, there
are two ways for the type, one is BTF_ID_OR_NULL which is tracing style.
Another is PTR_TO_SOCKET_OR_NULL, which is networking style. I guess
you like it to be PTR_TO_SOCKET_OR_NULL since you want to do map_update 
with that as a parameter. I guess this should work.

> 
> Best
> Lorenz
> 
