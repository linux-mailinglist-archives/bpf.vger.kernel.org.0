Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E5A3AAC00
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 08:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhFQG3l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 02:29:41 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:8536 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230262AbhFQG3i (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 17 Jun 2021 02:29:38 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15H6NNql012009;
        Wed, 16 Jun 2021 23:27:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ZLdqIWtZVwx4gzFHiW3BDJkqCsNkNGuhUSrYhRMBszM=;
 b=gjsTHN/prffKmR48w+ZY0ckP3c6/w92Q46b31NV1fvP03dBhtTHuxOVQLxIw03Z6aZka
 +nMMD1ieKGpDmOmmA2+esWz5sjTbyJW+9Mn2WZUli4eEUO12gmEwmevf0O0zCMzk5jmG
 3VDxj8dR5sIgj5FYgbbDGon4PtC2QCb3uvg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 397hbanygr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 16 Jun 2021 23:27:13 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 23:27:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=di5rC8mozF3xUtXPxAIbLKnKGkW57seKMVlL8VwfsT4km9rjCGz5cyyNVGKCc/OyTB/SiLnIkPNa2D3KTMSoSHTeUt0yhdLIjq1RWccIwn8RpRdg9JUyO/KGNJ5HCycYPFEjk+TstqeDgCKoELs33GlhLyNxoJu/CFeJSk/+vMQT9ZyfwyCETy9d9wTJtF61aqrOugL3+FCNO99xmJ9aIxnT4DiLwMHFBMtd8/uTn+3UDtk/9Et/LHKtC6/eJJDNWaP1o8wGRvR6zB/L04EZIQH89kju1ZWSFtWnp7+gXCXgq6YfchiMZbTXWxE8PZ/jCIs+JjEIfRcQaSBQ4/bUPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLdqIWtZVwx4gzFHiW3BDJkqCsNkNGuhUSrYhRMBszM=;
 b=UrJJuuM2WLQXn8ZurjFktb0QldElDW6SCdbCXWZlyBgOkVScVGMhxWW8n/I2myT/MBbc4sUcGlLgrDcf1v/Jw3EG7mUih3Nky+ZdBUuYRr2yrUeKjREcPiSgvAXq1xi4Cy9fK8QBAAFDF69WWEex+9FZjPfwEIz71BoxcXYVfk2LxzRokk/nTLDRRTgeFFNh31hX3dHqe/49l/yhhC39BXNsKW0rRi4DuXBj6voQqfHT0z8RHqNWcWRGzzT/QclQRPgNYgFF+bPx+2wUAMs0w76dQfWBwuYr56ja52TMkX1UxCHSNsgKQQ/3ef07lUoXl/pGGYF/jgxPkvakobCnCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: riotgames.com; dkim=none (message not signed)
 header.d=none;riotgames.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB5031.namprd15.prod.outlook.com (2603:10b6:806:1da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.25; Thu, 17 Jun
 2021 06:27:10 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4219.026; Thu, 17 Jun 2021
 06:27:10 +0000
Subject: Re: [PATCH bpf-next v5 1/4] bpf: add function for XDP meta data
 length check
To:     Zvi Effron <zeffron@riotgames.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Cody Haas <chaas@riotgames.com>,
        Lisa Watanabe <lwatanabe@riotgames.com>
References: <20210616224712.3243-1-zeffron@riotgames.com>
 <20210616224712.3243-2-zeffron@riotgames.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <2f3b2cf8-880c-2600-1118-4d43e814740b@fb.com>
Date:   Wed, 16 Jun 2021 23:27:06 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <20210616224712.3243-2-zeffron@riotgames.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:6d3c]
X-ClientProxiedBy: MWHPR08CA0043.namprd08.prod.outlook.com
 (2603:10b6:300:c0::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::12bc] (2620:10d:c090:400::5:6d3c) by MWHPR08CA0043.namprd08.prod.outlook.com (2603:10b6:300:c0::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Thu, 17 Jun 2021 06:27:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d814edd-2134-4059-0be9-08d93158efb0
X-MS-TrafficTypeDiagnostic: SA1PR15MB5031:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB50319383F50580C4A64EE95BD30E9@SA1PR15MB5031.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6QgMewC3kGDbaAelST94WefKOg6v7b5IHjecGM23TXSRuV1x9yRhzNzWTtYCtP0QPal9ojZ63B+jiUCH9/1FpOmRWiOMi2X9blBit98nPAsPdzCLTW3oid6gbWUqvdtr7ZM+zjwIkU1nEXEvAZSdAYOTYz4hE3dM1Cq1oX9b0k2nNxfH8TWzIB1fJV+CeFnwIFZgSL9arJBoxaHlk/puO/q6DA4I1LCz2p2Kes0vLw3qUJv4chm/aPWbuihjodqyje2Zq+Z+tvHJdOvauxrlzrB34EUUzIFPddk8dR3CSxNccGQ1J4hIZ/n5gcam16kon0HiuNiTNshN/fWhp+b3LaOzUCqnrdQ6jpv3QfLvCQpxRJDSeboSofQZb1FhcNJNMzcgj/Xni6xeeJk5sV+eI/GlAM7EIyQQwyAbLI4O4LgoX047AqtqHZ3yNWnn7DmhYdl+BHQ5Q2HWyGAnD/cohAM6tGXym6yCOaXFYgbJtuIXBFdyk+GUFbMbjMd28w5gK7k2bk/PW2I9B0pWVafwaWKMjusBBorYKJuNPWHM7Q3ByEhVesM0tu+Ij3bARs4RFdbdeRlgLZNz7lnsZ+VoLi8sCZj/+wW7Jn282W/VEKAdz6vDoZmWPQn3ouVSD030I/1LYKwvb4y8GRjam0mSQDS1Ka2iQj3QBC1S2MP+HABMN/S0Nb2kluWEvPD/1osP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(396003)(366004)(376002)(6486002)(7416002)(478600001)(186003)(8936002)(2906002)(53546011)(66946007)(38100700002)(31696002)(83380400001)(16526019)(86362001)(2616005)(31686004)(66476007)(52116002)(8676002)(316002)(4326008)(36756003)(66556008)(54906003)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0M5eWJGcGFKUk8wSnNsbUhiUStDRVhtK3FDYlZrdUxLNHJkYjliTFNaR2ZZ?=
 =?utf-8?B?eFFQNUxXZnJoN0ppOVh6MS9WSHY1R3JUWnBFMXV6S1FpZHNWZTExdGMvNVdY?=
 =?utf-8?B?eFZPcmtZdnlXVC93TGZWTHFyZFRoSXdMM1ZRMkpoRlB1Z0lkZ1g1NUxBZDZL?=
 =?utf-8?B?OUpSREF4ZExqS1MxR0doSDJZYVArKzltMmRlM0pYaDkzUEczelRBK0VYKzJ0?=
 =?utf-8?B?TitlTnlwWE9VM1BuUUV6UkVSRHFka2hHUEsvUkxGQm9XQlZrN3k2UFExcHFL?=
 =?utf-8?B?eWUyQjR0WkRWTHEwMVA3ZkNnbnkvQStEcEY2Tlh5dEEwd0lNa0liZWxHd0Z6?=
 =?utf-8?B?Q2RnZHduSFd4YzYyQUtJWGtkcFFIYXYrL3dQMmJST09nQy9DRUVCK0dBb2E4?=
 =?utf-8?B?clJGRmhZSnhuNnFwdytmYklSTTkzZm1KY0MxTzVaaDJDeGhDdGdNbW0rZkhr?=
 =?utf-8?B?WUV1OTd3c2s4MFBGZGpBQ28vZlk3SkhENTdsdldoR09aa3hUNVFRempKWTEx?=
 =?utf-8?B?dGR1ZUtjRzVmVFJhSjFlQnBsOWdUbGlMYlhjK1VFYVF4NUpOMkhxNzh5VmZS?=
 =?utf-8?B?Y05JWi9BTU0waENkQlMya2pJcExnVHI0eUZ5QTc3RlBGZW5mYzBwc2ltWVBZ?=
 =?utf-8?B?MmNNV1dwd2lCMlZPVjQyNjMzeTRKaUMyQnFuNkRKWTdMQVFnMEhQYkh4bzJD?=
 =?utf-8?B?N1ZRRGtGL2JHS1BmKzg5VHlmdFYxTVV2S2pwSVdXQkExVmx2Y2RMQkdQOXY0?=
 =?utf-8?B?Y0ludVlNYzdNWDIvWDd4STB6VWdYdDhHZ1EyZzE1UGxKa25NR01PRFRXello?=
 =?utf-8?B?V2dxT2JvMjZ2c1BMdGVmQVd6OW1LSi85bFNkN3VoVWw0anFHaFhUNFpKWEMz?=
 =?utf-8?B?c3dpaEwrZytNcHRORFVFTjVudmVJa3BJUUxDYXlubjhSdkxrNGFvd00rOEJT?=
 =?utf-8?B?bjQ5V2VDZERweHIzS1lQMVV5bWs1NUpBZkxJV1MvOXdSeGNZbWQzVHFUc3BG?=
 =?utf-8?B?K0R3TjhtZTV3V0tBVEV6QzhhQ3FsQlY2QURNNXdVZ0NyM3NpOGcybUZ6NDUr?=
 =?utf-8?B?RXd1ZUhGYUxSVllRdEd2T3VoUzNLNWRpZUVBUWh3RlhzWFRCQXAxQ2dlZzdN?=
 =?utf-8?B?SDRNOVhTUTNvd3hPYWtobkVIUVEvMHR4ampraTd0YXRiTDMrSnkrUTVTTFpY?=
 =?utf-8?B?cS95ek8wVjFhQmNsaHExRHZGQ1dSSERTOUYvcll0YllGOXhVMitITWo3QUht?=
 =?utf-8?B?b2ViKzJWZW5DdndZRGxOU2hZSi9KSllRQTNGdWhMWnVId3JmYk1MQm1aZERB?=
 =?utf-8?B?N2JzdVliN0Q4VTFuaWRwR0U1NHVZUWFOaUQzcDhENVlwWkh0ZHBBejBkSEll?=
 =?utf-8?B?R2Q5aUxqVzBZZzMrdktHZU9kbzFUTFo0SnFxYVJxK2dqK1BBOEhrK1BTTHRP?=
 =?utf-8?B?SS9tdkVTbnR5elhnYnh0THorZ255aTJzR204OWZ3cGtScVZPejdxbkZ4L0dU?=
 =?utf-8?B?dG9OazJKY0hWUGJwYTM0U0xxanVHREVVSHhzWXBXZ2QybzFKdTgycGpIVnp5?=
 =?utf-8?B?cjNiUUxjTCs1Q2tmMW8zdXhIWlZLUERRbTFDQXhSZVVYMXM5RFE2MUpOajEv?=
 =?utf-8?B?UXd6YmVsWS9BNWFWN0dBZ01SSjhOU2xzQmVtZlExOWpPQVcyaDQwSWdzUGpG?=
 =?utf-8?B?ODdWME9VcCtwTWRva0x3dVdYTWl0Rko1N3FaZDA3WEJheHVlb2xQMGpnb0RY?=
 =?utf-8?B?Y2ErWHZzdVY0WU1OZ1Vyc1JVVDFyUkhGakRqSjd6Y2hRN1hJYWVXRGlQWFV5?=
 =?utf-8?Q?gJ+cg1ZvZD17yN+gEox+J0ODNuggXPwp9HSCQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d814edd-2134-4059-0be9-08d93158efb0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 06:27:09.9010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pmyt3L++/JawBLdiFJ+maVZOTFCHduTNBmL3akQTJeUxhP2iQ9jVdxoKXGGqOYPh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5031
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: NucGlyIgNIOYIHCNk0KZxef1Aoa3uA3u
X-Proofpoint-ORIG-GUID: NucGlyIgNIOYIHCNk0KZxef1Aoa3uA3u
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-17_02:2021-06-15,2021-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106170044
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/16/21 3:47 PM, Zvi Effron wrote:
> This commit prepares to use the XDP meta data length check in multiple
> places by making it into a defined macro instead of a literal.

defined macro => static inline function.

> 
> Co-developed-by: Cody Haas <chaas@riotgames.com>
> Signed-off-by: Cody Haas <chaas@riotgames.com>
> Co-developed-by: Lisa Watanabe <lwatanabe@riotgames.com>
> Signed-off-by: Lisa Watanabe <lwatanabe@riotgames.com>
> Signed-off-by: Zvi Effron <zeffron@riotgames.com>
> ---
>   include/net/xdp.h | 5 +++++
>   net/core/filter.c | 4 ++--
>   2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 5533f0ab2afc..8bfd21bfeddc 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -276,6 +276,11 @@ xdp_data_meta_unsupported(const struct xdp_buff *xdp)
>   	return unlikely(xdp->data_meta > xdp->data);
>   }
>   
> +static __always_inline int
> +xdp_metalen_valid(unsigned long metalen) {
> +	return (metalen & (sizeof(__u32) - 1)) || (metalen > 32);
> +}

Maybe change the signature and function name to
static inline bool
xdp_metalen_invalid(...) { ...}

The function returns true if it is invalid.

Let us just use "static inline bool". Return type "int"
changed to "bool" as it is indeed return a boolean.

"__always_inline" gives stronger hint to do inlining.
Most kernel static inline functions use "inline" attribute to
indicate it is good to inline, but if for whatever reason
compiler didn't inline, it won't be a disaster. For a function
like below, I would be surprised if it is not inlined with
"inline" attribute.


> +
>   struct xdp_attachment_info {
>   	struct bpf_prog *prog;
>   	u32 flags;
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 5b86e47ef079..b4a64a07de88 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -77,6 +77,7 @@
>   #include <net/transp_v6.h>
>   #include <linux/btf_ids.h>
>   #include <net/tls.h>
> +#include <net/xdp.h>
>   
>   static const struct bpf_func_proto *
>   bpf_sk_base_func_proto(enum bpf_func_id func_id);
> @@ -3905,8 +3906,7 @@ BPF_CALL_2(bpf_xdp_adjust_meta, struct xdp_buff *, xdp, int, offset)
>   	if (unlikely(meta < xdp_frame_end ||
>   		     meta > xdp->data))
>   		return -EINVAL;
> -	if (unlikely((metalen & (sizeof(__u32) - 1)) ||
> -		     (metalen > 32)))
> +	if (unlikely(xdp_metalen_valid(metalen)))
>   		return -EACCES;
>   
>   	xdp->data_meta = meta;
> 
