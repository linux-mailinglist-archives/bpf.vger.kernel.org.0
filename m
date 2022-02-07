Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49494ACAAF
	for <lists+bpf@lfdr.de>; Mon,  7 Feb 2022 21:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbiBGUsB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Feb 2022 15:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242379AbiBGUfQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 15:35:16 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7E2C0401DA
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 12:35:15 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 217Id7Y4029792;
        Mon, 7 Feb 2022 12:34:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=IvbIEB+a3t1piREfSn9hnajQZLadshVbRUrYnqIaXUU=;
 b=oD/ztO/sBiBaDwCz9iLbheOY1vsX40jbh8Vk1rHcjI9IVB/JGkAh1wAvGNfTaYVOgWVq
 51RnznshMPWtbQ+G9x2sEF0YP5nUceFk3l8lcIZsD/EZEb0YNZtTFFWXek78NfGF409F
 2zsGZ0yB6K9WiN8F15696XLAmWTdyvBJwPY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e2t075vcr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 07 Feb 2022 12:34:56 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Feb 2022 12:34:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivfsx7newm0YBhYtOQnrLoyUjyXgUeZ/LumZYzNA4Apa8HqIaA1cuA5VdhV789eQeP2WInGLai97nqbjv7FwXTOjwEk+4d3zIeSXNnJj0NWZbNY2MVMQlQx+yDK/9Ckc0SQQgVMcP+qpRtPvpZ6lyD4t7IfkootFta3zUDUZ+5gpQ7IdDeu+J8VRJ0A/A+gDviKccjJgSPp00PQKtsKHa6ZqeKl/7qbaIw/KEb5ENYgKmGojQJ++xPpOwmUx+7xyPh+zjY/bz2u8uv/2HO3vun1h38iCHBzyupWO7J0JJ0//oFLPzcu4qHB2l+ZU8uli4aPJ/qvIcCRJncm8UD/+Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvbIEB+a3t1piREfSn9hnajQZLadshVbRUrYnqIaXUU=;
 b=W8NDR+X2NApCEMpaoqhc04xzlt2W6Zst6dznY+/WgYVoxCYuOiGnqhJkkG6JCn5A2PAzivtFdYOwokP3BECIwECP+ypjkZk6DTl404GeXPRxNFPpq/VU6PQ5cK0wM08RYG6alceiNfvItJ9H/t7XUrVYGaKtue+xddbSUjabABArhp+okQ5hqQMmJ4GGZdMj9KRI9tAgUgon8Bhw6KogYEsBsZLTI2qM8ImuCqgqt84KVUNZSkT+I99XJR+lYsjuFvvNJjZtTlIlSHEl5patAXY4pWfBz4QlrEZekGmze2hdDDvxI3EkU3hA0hqrJu4P8qkDjoRtxylUlYwR5CLiyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN2PR15MB3423.namprd15.prod.outlook.com (2603:10b6:208:fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Mon, 7 Feb
 2022 20:34:51 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::11fa:b11a:12b5:a7f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::11fa:b11a:12b5:a7f0%6]) with mapi id 15.20.4951.019; Mon, 7 Feb 2022
 20:34:51 +0000
Message-ID: <ab1e74e8-ce5a-44b8-47cb-3f326973bb59@fb.com>
Date:   Mon, 7 Feb 2022 12:34:47 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH bpf] bpftool: fix the error when lookup in no-btf maps
Content-Language: en-US
To:     Jiri Olsa <jolsa@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Yinjun Zhang <yinjun.zhang@corigine.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, <niklas.soderlund@corigine.com>,
        Simon Horman <simon.horman@corigine.com>
References: <1644249625-22479-1-git-send-email-yinjun.zhang@corigine.com>
 <CAEf4BzbjVnkb8Oz67p3jDhL-Pv9RG-wq1A7KMV06zowRK9psew@mail.gmail.com>
 <YgFdgOVdEWUx63Ik@krava> <YgFkVXggmihEpO/o@krava>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <YgFkVXggmihEpO/o@krava>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: MWHPR11CA0042.namprd11.prod.outlook.com
 (2603:10b6:300:115::28) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bf4a11e-d882-4bb8-6bd3-08d9ea794a9f
X-MS-TrafficTypeDiagnostic: MN2PR15MB3423:EE_
X-Microsoft-Antispam-PRVS: <MN2PR15MB3423A018A7B5288BE8263209D32C9@MN2PR15MB3423.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MU161geLoorCiyR8Y++FyyENmXkFpjOL6hK+66V5oL+il4zfexeKbQOhL5bRyiwNxGv8JidFx/KO8jAf6UAXBFWeWrDsl30ES207msemz2Onxr7YI3NedsBlrvd8IgBvFnAZ+ggq9KWwbWOw/LaPMbNUM+tf1Vp33SAGGbMdZ1xz5Xdle2ii+kj/k43MYhGRJ0O+BQNNKZMbmKm9Dt9Wo83PxgoZQUqu/b67AOumaRMoAshtRfyylnwjR+J9anU3F8VhE1h1sjHavbm/Gppn1JQwN4aljjszHXzSlUcbyb4wIUAAl/N8r5zPVeHPqhAL1xGjzZMvVzAxkfXyRN4w5vZCULXo4cEI7jUlLUkCAUcHHIc6XzMmAaiKuxRi21rfsYOxADcwS+7Ovui2C699LPRrrFEwgATwIt3WrV9v+9CntLJylmcSzdHC4iiZnc22ju8QsbVFhU/0UtUAj6g6jwcfHrkt9o/3QyXQgsP82mBN5o7C/eBtU+8fOGVgJXjXKZX7OLw2Q/jTmovcGhbbfOX5UvQRx1OWazMqPpz4SfAWQMxNFJFKLVO/pzEQe2948Dg2+JeQ0OL/i0wop9z/O+U/gbAej0i65n0VL/XHHz1pUmldxd8rMF4Rgbh6qRiBpL4BsLRm6x8AnSliKvjpO0ZPoFRaF5i4mZLHwXSGDTRr0lXsXaYteaSLKorS9O7iHigT4PPK6aYGM79lmA1sSTS4be6GVThywXT42ZZI6mdyYy9HSRKBli5icYTzKzRnlwLb2W6aWZ40EovPSgXmHf/TxDJPU+AE3dKDBq2xqRtL8QCbxW0DOS1BJjOVmPNN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(8676002)(53546011)(52116002)(83380400001)(6512007)(31686004)(6666004)(8936002)(66946007)(6506007)(508600001)(186003)(66476007)(66556008)(38100700002)(4326008)(54906003)(7416002)(2906002)(2616005)(316002)(6486002)(966005)(31696002)(5660300002)(110136005)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjFGdnRkVTFEYm5XRHZibFM0anAvdURyM1VjcmZqYStwVmpCdHU0aFprcTFI?=
 =?utf-8?B?UlBibGVZbFFPL0lOeTh0U1lPVkVGZE8xUWpmOVNOL2ZnWTY5YnkxbHdyYzFE?=
 =?utf-8?B?WmJHMnZaczFkendZcDIxWjdjMWMwa0FPTUhFclg0NmlKY0pLeXFta21wdGhp?=
 =?utf-8?B?U1MvTSs5MG1kR0cxNkNpNzBFSGNKZklpMzJKNVZQWUdZQUR5dFlOek1vTDBn?=
 =?utf-8?B?OHdpSm9NU3VlZndnL0Uwd0VMVmxpRm1VZ3J0dWZBZ2tCZ3hWRmJzc0ZZdllt?=
 =?utf-8?B?ZldYMlZtNkk2ZXl3MUVmMGExTUYveHJtcnIzNk4zYVZWcGxFdTcrOVdaaHVJ?=
 =?utf-8?B?V0V3RlNuL3BXMlUrUmFZSThkOVFsMG9JMHZPb0pFclpMSTJuMFJodm1FcUNP?=
 =?utf-8?B?NE4wdUhZMzdjc29EZTQyaUdwTW14ZXBaZWpGRXg3NWxRZjIyTkYvQW9BanpK?=
 =?utf-8?B?MTNOQ3QvLzVzejhWendJeEJTdzV2VURsRU9ab3FjTjduVzV6SFBMUEpmSWdh?=
 =?utf-8?B?Q29RWWxDNWRxTnZNQ2xLVXQrQzBjWjk5MWppYk9oOEthQ2JCMGdKUVJMOE90?=
 =?utf-8?B?YTB4K0hrMGY4VGdpcVB2amFZY2dxOVRuN2IxR1B5Tm5Md3JYdzVWV29IOVNM?=
 =?utf-8?B?RWlSNHQvNkl2ek4xSk1BL3VQME9DenlLOEtiWUo2cFNGazdVQ0U2U1RubHFu?=
 =?utf-8?B?ckVpanhiSDI3UWF2alVqTElvdS9RMjNGY1JqWnRiZFdzLzg1QjNsVW0yMEVy?=
 =?utf-8?B?a1BETHBjM2ltaExwRldzVll6NmNQanlkVUl0N3BMSjAyb0NPeXFWdm1ERjhD?=
 =?utf-8?B?VXgxZURSMVVtNWhhR2VQaHFIWjIxMmZPMFRkL2tqcDJnZ2pzV0xTekZBcElB?=
 =?utf-8?B?anladDE4OTJZVXdybjlXRmZLaSs1RnMzdzZKaU9hMHV3SERQcVkwdkphQmcz?=
 =?utf-8?B?R2xWL3ZSdTNmSTlBUWxWMVpRMk8xUlVQTUdFTlpXMlBjYWFmL3JWdzhxbHVE?=
 =?utf-8?B?b0JYb2ZyVjZBdG82K05JdituZkNYb1ViWWJOcE5mMXFUNy9CSThmaWFIUGNY?=
 =?utf-8?B?MTB6S1JxMVBVL1QwdE1Oa21aMWVlVHp0VmYrNytkejhTNXZLNEVnVVRHRGVz?=
 =?utf-8?B?RExhSmI3ZnhVQTc1VEpJRTFqQ1R3dVRRZ3dWTWcxMU1MZDU3UXhVcmllUlFT?=
 =?utf-8?B?VnhWSERpMFNYd0FiNVZnUkZOaDVpWjlmZjI0d0lYQzEzZWdpTkk3dDhyMVRo?=
 =?utf-8?B?c0o0VFpKQlNiKzhpSE9sUTdWYTc5bXJRYTZ1cTAvWDhzU1BIN3FvZjNnTzBi?=
 =?utf-8?B?R3Z1cEZ3RzZYNytIUXRwMzFKdk5aajNKR29RMkQ2RDlrc21MTmlpZml5Vk1a?=
 =?utf-8?B?Rm8xSE9hY3ZBNUtoVWdJdXZWcW80N0djbEZtRzQyajE1SVZvTzFVMUw1eDRK?=
 =?utf-8?B?bEhyK2FMS3QxNjM2SmJpOSs1N2Q3RlFrRXVZRkZmVkdEdktNYnBMRzRySXdG?=
 =?utf-8?B?TVpzRm1xVVd2U0NqdllKbWxreFdNQUlNOXJ6WFpjTEVvcVA0MGpRWXBYUW02?=
 =?utf-8?B?ajRJL1VKU2VkbGRsVzFVZHh4VFRxcE8wbTFFK0lXcENab3NHbkkweldTNUVn?=
 =?utf-8?B?ak1sVy9DSldxTXlZMktnUFZiUFhxdVVmL0ViQlZCZG1hbmpWMGhVR1JseVNF?=
 =?utf-8?B?bXRVQXNEbEtOeCtMZXc1TlZ3TmhwRmhhQnpma1JRejNIaE44QXh6b3pkS1Jv?=
 =?utf-8?B?VHlFdGFMNHVCdzF5TWsvYkE1dlpvaUNKb2dmcUsvcGZFS3FiclRITDgzcE5E?=
 =?utf-8?B?U1NXWFZVc1ZTSVFZQUxyYnFIbExJcVZFc3RuUndzZnhkM1NRUFJEanQrODQ1?=
 =?utf-8?B?bVA4YVJxdWNEL3RSdGRmSHZXeTgrakQ3TWFZbmRJUC91Rm4zSzkwKzdySlBQ?=
 =?utf-8?B?cXlOblVudlhmbnNpU1VFbTdMVDRmcWtsd0k5SktGVUd3OHRIS1RjTHJKcmtH?=
 =?utf-8?B?M2wwb1lNb21vWUZ5VHRnUlIxQ3FDU2p3Z1FDbjc5Ti9jbTZPZ2c1ekNIdFE2?=
 =?utf-8?B?NWE0T25ZcngrUU5xSGR2ZnFHazFqTTNxdDZtdTRzb2xqazJsSmVHbHdaZWhN?=
 =?utf-8?Q?t6QIkK0XGQN1PpBIPpG/PxqcK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf4a11e-d882-4bb8-6bd3-08d9ea794a9f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 20:34:51.5727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQfzD/Qo9SOvjGyS3HsFxTiPhNyFPZSUKLiNjS4aNpP2tzadjeF6dgaK8kuZUkNN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3423
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: YTLnuHg3-KH2GcBOeV0Gzlj3ny35jq3l
X-Proofpoint-ORIG-GUID: YTLnuHg3-KH2GcBOeV0Gzlj3ny35jq3l
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-07_06,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0
 phishscore=0 priorityscore=1501 clxscore=1011 suspectscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202070119
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/7/22 10:26 AM, Jiri Olsa wrote:
> On Mon, Feb 07, 2022 at 06:57:20PM +0100, Jiri Olsa wrote:
>> On Mon, Feb 07, 2022 at 09:42:25AM -0800, Andrii Nakryiko wrote:
>>> On Mon, Feb 7, 2022 at 8:00 AM Yinjun Zhang <yinjun.zhang@corigine.com> wrote:
>>>>
>>>> When reworking btf__get_from_id() in commit a19f93cfafdf the error
>>>> handling when calling bpf_btf_get_fd_by_id() changed. Before the rework
>>>> if bpf_btf_get_fd_by_id() failed the error would not be propagated to
>>>> callers of btf__get_from_id(), after the rework it is. This lead to a
>>>> change in behavior in print_key_value() that now prints an error when
>>>> trying to lookup keys in maps with no btf available.
>>>>
>>>> Fix this by following the way used in dumping maps to allow to look up
>>>> keys in no-btf maps, by which it decides whether and where to get the
>>>> btf info according to the btf value type.
>>>>
>>>> Fixes: a19f93cfafdf ("libbpf: Add internal helper to load BTF data by FD")
>>>> Signed-off-by: Yinjun Zhang <yinjun.zhang@corigine.com>
>>>> Reviewed-by: Niklas Söderlund <niklas.soderlund@corigine.com>
>>>> Signed-off-by: Simon Horman <simon.horman@corigine.com>
>>>> ---
>>>>   tools/bpf/bpftool/map.c | 6 ++----
>>>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
>>>> index cc530a229812..4fc772d66e3a 100644
>>>> --- a/tools/bpf/bpftool/map.c
>>>> +++ b/tools/bpf/bpftool/map.c
>>>> @@ -1054,11 +1054,9 @@ static void print_key_value(struct bpf_map_info *info, void *key,
>>>>          json_writer_t *btf_wtr;
>>>>          struct btf *btf;
>>>>
>>>> -       btf = btf__load_from_kernel_by_id(info->btf_id);
>>>> -       if (libbpf_get_error(btf)) {
>>>> -               p_err("failed to get btf");
>>>> +       btf = get_map_kv_btf(info);
>>>> +       if (libbpf_get_error(btf))
>>>
>>> See discussion in [0], it seems relevant.
>>>
>>>    [0] https://lore.kernel.org/bpf/20220204225823.339548-3-jolsa@kernel.org/

For the patch in the above link:

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index c66a3c979b7a..2ccf85042e75 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -862,6 +862,7 @@ map_dump(int fd, struct bpf_map_info *info, 
json_writer_t *wtr,
  	prev_key = NULL;

  	if (wtr) {
+		errno = 0;
  		btf = get_map_kv_btf(info);
  		err = libbpf_get_error(btf);
  		if (err) {
-- 

Do we know who sets non-zero errno in the above?
Maybe we can fix the issue in that place?

>>
>> I checked and this patch does not fix the problem for me,
>> but looks like similar issue, do you have test case for this?
>>
>> mine is to dump any no-btf map with -p option
> 
> anyway I think your change should go in separately,
> I can send change below (v2 for [0] above) on top of yours
> 
> thanks,
> jirka
> 
> 
> ---
>   tools/bpf/bpftool/map.c | 31 +++++++++++++------------------
>   1 file changed, 13 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index c66a3c979b7a..8562add7417d 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -805,29 +805,28 @@ static int maps_have_btf(int *fds, int nb_fds)
>   
>   static struct btf *btf_vmlinux;
>   
> -static struct btf *get_map_kv_btf(const struct bpf_map_info *info)
> +static int get_map_kv_btf(const struct bpf_map_info *info, struct btf **btf)
>   {
> -	struct btf *btf = NULL;
> +	int err = 0;
>   
>   	if (info->btf_vmlinux_value_type_id) {
>   		if (!btf_vmlinux) {
>   			btf_vmlinux = libbpf_find_kernel_btf();
> -			if (libbpf_get_error(btf_vmlinux))
> +			err = libbpf_get_error(btf_vmlinux);
> +			if (err) {
>   				p_err("failed to get kernel btf");
> +				return err;
> +			}
>   		}
> -		return btf_vmlinux;
> +		*btf = btf_vmlinux;
>   	} else if (info->btf_value_type_id) {
> -		int err;
> -
> -		btf = btf__load_from_kernel_by_id(info->btf_id);
> -		err = libbpf_get_error(btf);
> -		if (err) {
> +		*btf = btf__load_from_kernel_by_id(info->btf_id);
> +		err = libbpf_get_error(*btf);
> +		if (err)
>   			p_err("failed to get btf");
> -			btf = ERR_PTR(err);
> -		}
>   	}
>   
> -	return btf;
> +	return err;
>   }
>   
>   static void free_map_kv_btf(struct btf *btf)
> @@ -862,8 +861,7 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
>   	prev_key = NULL;
>   
>   	if (wtr) {
> -		btf = get_map_kv_btf(info);
> -		err = libbpf_get_error(btf);
> +		err = get_map_kv_btf(info, &btf);
>   		if (err) {
>   			goto exit_free;
>   		}
> @@ -1054,11 +1052,8 @@ static void print_key_value(struct bpf_map_info *info, void *key,
>   	json_writer_t *btf_wtr;
>   	struct btf *btf;
>   
> -	btf = btf__load_from_kernel_by_id(info->btf_id);
> -	if (libbpf_get_error(btf)) {
> -		p_err("failed to get btf");
> +	if (get_map_kv_btf(info, &btf))
>   		return;
> -	}
>   
>   	if (json_output) {
>   		print_entry_json(info, key, value, btf);
