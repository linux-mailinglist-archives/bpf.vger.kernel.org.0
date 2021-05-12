Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBC037B4DA
	for <lists+bpf@lfdr.de>; Wed, 12 May 2021 06:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhELETM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 May 2021 00:19:12 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:22364 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229626AbhELETM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 12 May 2021 00:19:12 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14C4GM3x011607;
        Tue, 11 May 2021 21:17:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=FwsVcxIaG68dNDOjmShWnH458cGkcfrtRzNkFNDrP5U=;
 b=TCAwzGd2HI5nH8SQIFBtLfvMy0gDFvyqaIM1NwMP/k2VUvJuYDBEWER8tgsxglH4sdxf
 aqOq80RP0TxyOmlne0NnDE03PCykNQoChFaulIo0i9qkYnTvWk/lVfUBhtWhH1gpLj7Y
 mlrR3twAcprIHWIvBdce+ADlRU+TfMn7GLs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 38fajvs7x6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 11 May 2021 21:17:51 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 11 May 2021 21:17:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTi/85Q1biysVtX55qteWkUyYKB8CSQv7claBzn5u4WGziamxiRd0oFyMxf4qRDrUqP+u4/cQvFdgeYwfIwfKQUWoqpCCrsyYmPzoW0JgHEtR1weEnNQJ2F8MHGmlTmUdpuy2SlSp7JqBtkj/o+8JyIY7UKY/cx9WoLcYdQsig1qgc/vUmqFwLLRkKScpVJZGt4JiwYXTRiw95xRw1XtruJVt06DM4/l91Q9+QVz2Of9Btw8BpxjnWfgJmVkpBOiJZoiy1TF/pt/2hJodHbanVaNnLEqWTCYIhMmDEqEysi0OS/Nqr8EGar/AEFEbTedxJ+9AJ3pLkK/JwbjmPwh2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwsVcxIaG68dNDOjmShWnH458cGkcfrtRzNkFNDrP5U=;
 b=Jt5/PVSRMrAzjGLG5hiUL/qV/+vD2yxLnGtWz4Vg9gCMjxzIhWF3hO8E+odEImTsDEZsF77YSL8OjhgNdkhS6tJunUvsJvTSsJipXs2hFi42t2YF/qtN192dadg5MccxvsjKJcweF8bySxdYtmDYRv9tcfJb6zcnp4il+EtwdwX50kXg3POv+tGd+D4bT0aMxMVyDi+LaEIQmcuX/lNBxc+rp7QZ1TagxaiGNYt0QDHFAShUf/7Uq4oERFb3kTSsOl8DkIXOlxYr1LZaQC6bnu5BqvAr2YvbwRc28HfuhY0R/LMm9fJYDzErqoiv//bnfNJK0DPY90x5mk6rn8UZ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BN8PR15MB3282.namprd15.prod.outlook.com (2603:10b6:408:a8::32)
 by BN6PR15MB1587.namprd15.prod.outlook.com (2603:10b6:404:c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.29; Wed, 12 May
 2021 04:17:47 +0000
Received: from BN8PR15MB3282.namprd15.prod.outlook.com
 ([fe80::d427:8d86:1023:b6b5]) by BN8PR15MB3282.namprd15.prod.outlook.com
 ([fe80::d427:8d86:1023:b6b5%6]) with mapi id 15.20.4108.032; Wed, 12 May 2021
 04:17:47 +0000
Subject: Re: [PATCH v4 bpf-next 15/22] libbpf: Use fd_array only with
 gen_loader.
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20210508034837.64585-1-alexei.starovoitov@gmail.com>
 <20210508034837.64585-16-alexei.starovoitov@gmail.com>
 <CAEf4BzaBS4hhiSvsLcdZvSQv598+ODAyXstLcFgEhzEmzmj2yw@mail.gmail.com>
From:   Alexei Starovoitov <ast@fb.com>
Message-ID: <8122c5c0-1429-9f2d-c73a-9d8ada4f318e@fb.com>
Date:   Tue, 11 May 2021 21:17:41 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
In-Reply-To: <CAEf4BzaBS4hhiSvsLcdZvSQv598+ODAyXstLcFgEhzEmzmj2yw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:aafc]
X-ClientProxiedBy: CO2PR04CA0168.namprd04.prod.outlook.com
 (2603:10b6:104:4::22) To BN8PR15MB3282.namprd15.prod.outlook.com
 (2603:10b6:408:a8::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::1acd] (2620:10d:c090:400::5:aafc) by CO2PR04CA0168.namprd04.prod.outlook.com (2603:10b6:104:4::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 12 May 2021 04:17:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ead23442-e535-4ffd-5eee-08d914fce602
X-MS-TrafficTypeDiagnostic: BN6PR15MB1587:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR15MB15879DCDC23A7AB031974E80D7529@BN6PR15MB1587.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CPDT0hVTJaX457RGE/QgLFYxZaoJ3RqqxNLK7Jt/ILJmHyVmi/FtgEtRKJ3Ohulix+IgplilsMV8PhZQuwV03OnNbljbXO1W84j5jFLpioypB7fBZi2CjjbJQwzd0GUvyU1CWW0fjOS3CslfKSwebIkSWmePC97Z8ZKxjxYQ9jsTemlveuNmifyzqD+hfFP/E8NUyzQjURlLxQx0qCJBN68Oy4XtK2T5qzeC7PGLsNP9hZvPKQLTAZt4bnL5sx2HoVnFzE5cpZF4DpKhS0x4OFQPfjM2J6rhLsJR4GP1bukX43WQ483kzRlzu2BGyODWXOqNTGmK7iO0IgBywoL/xy24GEfk530siqMq80KHk2naUM8LNcyVJW7YliIQ8b/hbVNLVZVdrWGkqEYpMdldkcAkGgulF8n0vSQ8OyWw/bwP0kYnzkuiyCZfotdk+8UZD+nCrtS52TDXz6Aezarahdv0lQnfboKahBYirOJWC7r9jp37ikmWu//uYqZ7No7S8jfHQK0RGY2J0sPg3Cygs38pnrJ73/rZLdFLn7tTcTeQ+puk3QVWo9eTe7TGQtsV4z/pZK7r9ayiQ/XYNgopJM7m9DuBI5GItJxTnn+zKFpVijvk/nknmYvKRpo6R3BBCrlmdgO9nS/Yaf5Nfh1a0B4XvJ6ctPEXh98WUFeqVmH7LEk2LxWwV7bWP21lpsFE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB3282.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(8676002)(38100700002)(31696002)(66946007)(53546011)(66476007)(4326008)(86362001)(36756003)(316002)(8936002)(186003)(16526019)(2616005)(31686004)(6486002)(6666004)(54906003)(83380400001)(110136005)(2906002)(5660300002)(478600001)(52116002)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TzJhb1hwZnNPS0x1YklEN292WUwrb2FpemV0WU9XRDJkYnFUemNyTzJHSEhz?=
 =?utf-8?B?eWIxeU9ZOE1uL291NjY4YndjbkVHd1hnTWZNdWNCeGQzREl4TFBSWkVyRk15?=
 =?utf-8?B?cXdiUVlRQXB2djdwMWdIcXdSei9WT2dSTVVrUzVZd3g4RlpPa2tyenJFdXFK?=
 =?utf-8?B?SW5nNkUvamczQUhFanlrTHJGckJ0eVNZL1RSN2MvYW5qeFk0OXdHTGx1YlhL?=
 =?utf-8?B?eHVYMmFONTc1a0ozT2R0amJjYUh3MUlycG03V0Zxc1hhQXM4L0J3RFNrb2ls?=
 =?utf-8?B?bCs0aTU4MGZQZlFBTS9idHlYbzNWTmpqWDJ5RzVlajlYUk1jLzVMVnZXOEx0?=
 =?utf-8?B?anpWY0RXY0hTK2FieXdMYlErOWN0YmQ1MEpnaTNHcGZGRklSVUdlUU1Nditr?=
 =?utf-8?B?djVHeTNuaTkzQjN2azk1RDJ5THc4U2lMZ3ZyUVlneU5OT0lXck1WOFVXeFdQ?=
 =?utf-8?B?empucHhUclNBa2srYVVyNjVsVzdDbVMyMVNBOWNnRnlsdjhDeG1kWHQ1NW1H?=
 =?utf-8?B?R2lVRjBYQVpveTFJUktKbk5tYmJSaEhVUTA5ajNscDNCeXorWExOV0RhbWZF?=
 =?utf-8?B?aWlMNnI5OVRFbS9nOGM1ZUVhQXlDcHRLdnNKQWpSMCtJSTNmbnRYOUYzenh6?=
 =?utf-8?B?cW8yWHZONjlVRmY5VnplbjhlajlUT2MxckF5eG40bm1WWXlaR1k4NVZPcWNL?=
 =?utf-8?B?VG1hbjhraUZ1MmREb01UaUlqaGVUS0JlNENmc2NxVnExc1JraWlwWE4yWlBw?=
 =?utf-8?B?UGxNWmZwODQxVURKMEdQWnRCOXBOKzZHQTVpN2h3TUIwWlJiYjRteldGaXBG?=
 =?utf-8?B?ajdjNlF5N2dhMkJiV0p3Qnp3U2tOYkpvUEFDZU1zckV2N3hKRjZNMUM4ZGFZ?=
 =?utf-8?B?VEVPYklGd2lzNVpKL0xHaWlrQllSdFlZeWtTM1RVTDF0OXljYnp1MkRPcEZY?=
 =?utf-8?B?aFdhZzdyWnRRNHhiRGJjbVJ4ZW0xMDNrUGVURWhwMlptU2Q3Nk5MNy9VTTly?=
 =?utf-8?B?aHJSYmoyazhteWdNK1pWeDZscUo1TlJ2NUo4WlpvVjlLWHg3TzRwclFHOWlU?=
 =?utf-8?B?RlVSVnNhMUpxK3ZDR0lONTVlSjFtaTl5QzJlQ3hiUUF6V2N1VEZwdDc3Qk5k?=
 =?utf-8?B?SWgydUtlKzMxcVV4dGYzSzdMd0ROOFpWc2wrWGJoMkRiVlBuc0F2a2o3OFhR?=
 =?utf-8?B?K05ad1pqeFo5OGVkeXdQSjBlaE1leGNxRE1YUS9UUzhUZWVmYXRlUWZlSitP?=
 =?utf-8?B?Q1EralVCRVpMZHY0dnlaZ2Z1a0l6b2N3VlNYV2lYenRIZWVQVHJJOVVsUmFJ?=
 =?utf-8?B?YVR5U0xjRzNnNnpHM1BjZXVrUnJLb2pxbU5EU3k2T3l6aTNSUmkrRzhXNWxL?=
 =?utf-8?B?dGUvUWNNU2RpcVhHLzBSL0lLaXZKeVJ0WXRNUnZ3c3RuWjlTT24xUXVVYlAv?=
 =?utf-8?B?a0x3VGlaQlBqMmsyaXRTQTdIaFlwV1oxQUNpYXBLd1BOZW85UE5TcC9qWER4?=
 =?utf-8?B?K21qUUpqMU1OSUErdUNrZU9YaW15a0p3NmYxdDBBSEE1QkhWbFRSSXJzd0Zj?=
 =?utf-8?B?UXBkc2NSQmgzQ1Z2NFp6eWpkSUdrbnhFZEhnU1V5bUVXK2M0N3Ztd3pqLzBG?=
 =?utf-8?B?VVJoa3BDMDZ6REZIckVFWGJMTUN0V3JrRytNd09JRkZNR2dSMU1PZWpxL2tj?=
 =?utf-8?B?dDhlUjJpRitWK0tIcWxtb3VLRDdEWVNpSUtMWWZCQnBrakRlWG14ZEVUYjF5?=
 =?utf-8?B?Wk83VTk2MkZ5ckc0MS9tbGErREVaWndLK3huelJ2dlcyTzBENlVacnJkR2dJ?=
 =?utf-8?Q?NQlkNT0B7fFTNq12bYamOEKsXO761jYM2HEqc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ead23442-e535-4ffd-5eee-08d914fce602
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB3282.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 04:17:47.4414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xLM1bJUs3RWIszRigiix7/Xpmk4tuJea3iNAJmZZuIiDz45txpROCSOdXVAKFAVv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1587
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: uJ0CpXvJIY9TPpHlRFXDtCHd0LxAagDN
X-Proofpoint-GUID: uJ0CpXvJIY9TPpHlRFXDtCHd0LxAagDN
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-12_01:2021-05-11,2021-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 spamscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105120030
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/11/21 4:24 PM, Andrii Nakryiko wrote:
> On Fri, May 7, 2021 at 8:49 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> From: Alexei Starovoitov <ast@kernel.org>
>>
>> Rely on fd_array kernel feature only to generate loader program,
>> since it's mandatory for it.
>> Avoid using fd_array by default to preserve test coverage
>> for old style map_fd patching.
>>
>> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>> ---
> 
> As mentioned in the previous patch, this is almost a complete undo of
> one of the earlier patches, but it also leaves FEAT_FD_IDX and
> probe_kern_fd_idx() around. Can you please try to combine them?

I cannot combine 9 and this 15, because then 14 will be broken.
I'd have to combine all 3, but then the fd_idx won't get its own
test coverage.
With patches 1 through 9 I've tested the whole test_progs
and that gives the confidence that kernel and libbpf side
are doing it correctly.
Then with the rest of patches and without 15 I test everything again.
Such testing approach covers lskel and fd_idx together.
I think this patch 15 is rather unnecessary. It's here only because
you didn't like patch 9.
I think patch 9 is a good default for libbpf to take.
Eventually llvm can emit .o with fd_idx style.
The libbpf would just call probe_kern_fd_idx() and won't need
to massage the .text after llvm if kernel supports it.
It would need to sanitize back to BPF_PSEUDO_MAP_FD only on older kernels.
That's the reason I'm not deleting probe_kern_fd_idx() in this patch,
because I think it will be used fairly soon.
But I can delete it too if you insist.
But combining 9,14,15 into one I'd like to avoid.
I think there is a value to have this in git to easily go back later
to test everything in fd_idx mode by reverting this patch 15.
