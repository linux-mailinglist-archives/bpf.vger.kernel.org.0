Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5236622401
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 07:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiKIGhL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 01:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKIGhK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 01:37:10 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FBE19C31;
        Tue,  8 Nov 2022 22:37:08 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A92IjWK011224;
        Tue, 8 Nov 2022 22:37:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=mboQqO/EU62O/gx2uY/ZuuO3d51063mWmlEg3Q9EnVc=;
 b=QaftDOQ6lL6kfLcdgE6etRtDYg3ejDiEy6kisIqVRviFtF6NzKD16epaoWU40SipC9Qt
 ERM9gdbkwdpvu+mGzS+ZAteJioPEvulQeYD6CYd5eIx2gvQXT34jnYSAdo+ihnBRx9Wx
 EdJ38h6VXun2zm5GepsoOdZ1sBmlc/9OhrldlnFeLFi54mBRuiWGqGyXKGmh0K0r2FK2
 Ldv0T4hcH/VWVVxvT/cgST9zM1dbvem6/C1oVBWFLu2LBIpKSxgbmGCUgBn0eXl4ieju
 3afOgSv0AaIKnYHakUapr0LeFWKml2J4ntFdX94zSOTP6paHJ2J1JJccsnO/0ldUryau gg== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kr3a3sbfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 22:37:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuCh/qXB0sM2nAWGQE2PA1HFZRRK2GALQhd4sfDZi12A8JgtQiqzyUGhgZ0BaJqonLC4HafF8vOtWcI+PzzhRKnrMtPiTN+l2FSkYp+AIkwbM0Vc9cmSGag2BOEwXPKpfbG9qR8lrTPHEWG3EsVm3uxlxoL2VSD/DhjZOwGKs0UwQsxNJntuLT1t6eTX/ZGOP1D/Q/ncSiou9Z/5hLND9Fo42LKxxccfDl2npiEuyQrLlTEWEbNq5wHkGk2nAL7w3HmwmROMq+lMb3q2ZKzcUCkkt0uyseqLOn87CqNWTbvPRAEjgJFUsftLxl2d/q1uQVlmq9SzrwbnZkRUSfCLDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mboQqO/EU62O/gx2uY/ZuuO3d51063mWmlEg3Q9EnVc=;
 b=DNldlUQoWhD7dmL9TWLH9cWIFemKKXIliskSaS9GSOOvhrVn76+6pliWuRBshIUXLpzSLEOa6/LfK4Wk7HbacPGEmEQuI+Ji3m4oD440TsljOLunh9cPHFJ1roPm2MOzH+vltP/2++Z1pnGPJLYT6iL2IXJcGCPch063SI6do45ymEssGZ2yXxobBKhGuRW35oTyw2I8oqw5P1lPYBf6uVwrsYjMJYrDQb0CJsc3oaPW+v/axThSsLB9GfQHdyqKYPMQQsaYKsVlHSiY/twW8W831POB1H1nQ79CpphOv/GO4SAAYnZp/Jt5Txnk++kT569XMcf0phA47LvAuP4kYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM4PR15MB5518.namprd15.prod.outlook.com (2603:10b6:8:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Wed, 9 Nov
 2022 06:37:03 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 06:37:03 +0000
Message-ID: <f3ca47ae-381a-649a-6577-9585ddee4977@meta.com>
Date:   Tue, 8 Nov 2022 22:37:00 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH bpf-next v6 1/1] doc: DEVMAPs and XDP_REDIRECT
Content-Language: en-US
To:     mtahhan@redhat.com, bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     jbrouer@redhat.com, thoiland@redhat.com, donhunte@redhat.com
References: <20221108174833.1106947-1-mtahhan@redhat.com>
 <20221108174833.1106947-2-mtahhan@redhat.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221108174833.1106947-2-mtahhan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0022.namprd21.prod.outlook.com
 (2603:10b6:a03:114::32) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM4PR15MB5518:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c2353c7-db22-4c61-abe7-08dac21cd00f
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YQsLQ9K0WqVFpyfSty0NEm56qJE0+TzgDx4Hcz53Fc61GWVIo3l/PBiLGe0Vt9nPq+5C9Gdz968cneC59j+ajYs9+dEKM/VHMavyu5BTcDtBXRizsShyIdcRLKfv7A5rgQ7UqurSI86UPfrhQVpSklf3z8+BnOGMpOUYoJy3kMIw+cni7LmC7dxtXsVfP54kA+uOzLWij8gVz6MUlnE0LowvyufNyCxGuHcnNul07/nKV1r5G1mLdwAOeX/vjhZmqmv9XN3twbiiET2CxUQUHgBWyf7WP5U5TBwj2HpOpRAjpPVDBmIa+0BJ6l1UUOE7a+D3txRlK7ux0TsjpCj+DDpa8HoVQScCvqW2vBzjSFMYkcVBLxAZt5e8U0uDOg+m238gD0uEupjDit3jtGL1IpcW8u2uGMw8ZS5aSnKzEClFsqxuEidbAOhU2JDAPIO4FeJF7Fz7nEMyMdmW1bH35Sk70OOz9qV333X1R9F6pZSa0EztKF9Rzd3B1dWts8Q4xd7E3Zh4vnRZn2hFFKoMGNSumaPnSO9U/AsiUxS7PMl4AnWWR3y6NYM9YNjpBYAdFZYWosThb9WDpl8ustrxurinJAjVJ3WfmtbxhHF6/1U+IaU1RrZTtolQYpKXOJoi0+7VXgmCpmDM1a0yKFtbLXtftl3891AlTevWZ9KDmfI2FC6Ul7l6Gq4DGtRN//EttNxNm2aIkeQg2l2Z1yu5LmyJ8SeHGhNtJbiKWEEH7Px9vQPSMMAsa3JBrN6MRZ7kglTAJ/084KhGZFK5H2QnZbfgrOMjq9nckDR8jZC6UE8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(451199015)(83380400001)(31696002)(38100700002)(86362001)(478600001)(316002)(6486002)(4326008)(66946007)(66556008)(66476007)(8676002)(41300700001)(6512007)(186003)(6506007)(2616005)(8936002)(5660300002)(2906002)(53546011)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGtaTk9HK2lwcVBONGZTVHNhODVNVGNEczlZMDJiZFpxQkJtbFRzbmhLSkJo?=
 =?utf-8?B?UkEvRTNOL2MyaVVRajNXd1B3UnhSTTExMHgrVGdEV3o1VWZ3M2JzZjFqMXpZ?=
 =?utf-8?B?bHY5MU9TbVYxSmMveG4xbXRVaUFTa01DWVFJTUZDYWtkNHNFYk1KT09takhG?=
 =?utf-8?B?RUw2MzJxamlqbm5Fc1gxTW5SaHN0NzI5bTdJQUE3dGJrZFBEYkVmMXB0WmhF?=
 =?utf-8?B?aXFtODJiL0QvM0Vqc3lXSnNPV1VWQklkS3JlM0NhSUtaNzhCanFVc0x6Y0Ro?=
 =?utf-8?B?ZmhvNTdTQzc1TmN4ZVY0NlhvcFdZa1dLY3NnTmZHVzVXWmVBdFJhdjJwZzh2?=
 =?utf-8?B?akVNeWtZRno5K09ZMnU0aUtpcW4vSndtQXcyYmUvRkhPR1JVWElubE1mT3cw?=
 =?utf-8?B?c1RveitUc1lQRlVQWjdKOGhzdmFrMVJnUWJ5RDArczJVSjNpUHYrOXMwV3Fa?=
 =?utf-8?B?bnBhYXQ5aGpwWEs4aEkrazcxbjY4NDFNS3MraGY3eVVnYzVUcUNJTTNmNmdN?=
 =?utf-8?B?UW43QmFMVllwcE9pdExqKzFQdmk2TmE1Vy84R1dCUnR4WTRRK3BrVE5GdTll?=
 =?utf-8?B?Ny9tS3MzUlRwUjB3T1VoaWtvUGNHdysrakhYdmhwZU9hWGFSSlVJK2xBaE9S?=
 =?utf-8?B?Tks3U2tjUmRVdzZCMlNmTXhqNUR1NzZNVjZvR3pHSWNGeTlaQ2h2aEFWVUVW?=
 =?utf-8?B?RnhVYklsWmdEaTdrTEJZakdXSlBIZFVqaGdIZlZiS0hwNHFvZFVJZ1IwV1dY?=
 =?utf-8?B?bjVZbzFRUUorL25uNmd5Tms1RWQ0YStTYWN2N0IxempadUV0S0RkR2hiUHd4?=
 =?utf-8?B?NW5uUG1nTHI4QXE5azh4OVU4UWM5RzNJWFRQRUY1UGJkT091K3JoSVBLMm0z?=
 =?utf-8?B?T01MeVA5U0FrR0tmSEZWQk9NZHlnay9hM1ladU5KaWxnMHFxVFp5d0VSZTky?=
 =?utf-8?B?bGN0THNHR2c1ell5TldTWVM1MEU0aU8vbktycUdIYjJzQmYyMWRvemRqMTg4?=
 =?utf-8?B?ZEZITE4vZC9zaStoUVdVWEtJTXgzYWpIdHpaMytPNlEvS3FrRWZzbHdCMXU1?=
 =?utf-8?B?THFVUllWajRIVXRNcFFTY0Foa00zdk4wZ3E3REMyYWZhRk5uU0xndVFJV0V3?=
 =?utf-8?B?NDBRRGU0MGYrck8vYmxrMjVMT3RUeVk1c2RGVU03Ujd1K0E0Nms1N0NxSFkz?=
 =?utf-8?B?K0M2UTJXZzJ6bVAxVHZlUU5SbndKYytpZ0w2K0duK2ZlYUhvajcrbUdVeHkr?=
 =?utf-8?B?MmRUTks2T2d0V3Y0WFRPT2pIUVNXdDMxTWhuczc0TU5mU2lTR1pTWG1TSGw5?=
 =?utf-8?B?S2ZBQjkrVmFmamVjZ3Y4ejZ2VmNBOVUvMFNpYlNLYVRxU3I0a255WHVITHFq?=
 =?utf-8?B?T1M2UzczQXJxbXM0cjhpSUFwNXJzcGVlWXlHS3VpMlFId0RDZTdJbDZ2eDBn?=
 =?utf-8?B?bDk4WnlMSzU2YlN1ckpMVEpEK0I4TGcvNi9kNUFuV3lFZzg1bklNQS9ZV2hH?=
 =?utf-8?B?KzU3YzFiTGgvNUphb0RKK3ZHRVMyeWpKMEozTGxqR3BpcXlvelNiMWl3VWxm?=
 =?utf-8?B?WUVQem9TUFlNTW9Ka2tGK01jNWJIbm1sKzg0SnpKdmZDU3YzamdsVmlmS2d5?=
 =?utf-8?B?UFVZZ3B4MWpZSHF2a3QxWG4zZ3VFVGVyL0JpRUorUnVrT1BvcUVjRkh1ZzEr?=
 =?utf-8?B?NTFnWXhhOU12YVFJMlMzQlhzODAxdWFHNUw4WmVMYUhLdDNiT2VORVBLcElG?=
 =?utf-8?B?NDJkY0VuRFduajRYM3d2MXRBbHgybktvNXhkZGVCL0d4YXg2V0ttQm41S2FV?=
 =?utf-8?B?RmRhKytjZDMxYS8wUE5SY2tRdEYyNkNWcEh3TG1WbTZ2TlVTMW1iQ1RUSkZk?=
 =?utf-8?B?TGJ4K3VwbFQrSWxsU1ZQcEh3WlRjSTNNZ2tnNDhlbEsyVlJsZ1VZeXA2RW9p?=
 =?utf-8?B?OFdoVUhIK3NSb2tCL3ptNmUrbXhOL0JZSVNNd2NsYUxiK3NVeit2UVNKMVdL?=
 =?utf-8?B?QzBqR2tza3JvY3czT05tL2MyUEhUek9uUHlyMnREMGVpb25ITlg2UHZXNXJk?=
 =?utf-8?B?OHVyUGZqY21IVFhrdnBxdGg0Snl1d1RVNXgzS0RZK0g2N0U0Wjg3blFZSUpw?=
 =?utf-8?B?UEJTcUZrdW1MWTUwZy9UQjhSRlJBd2dMU2pjQkU5M2x2NTVLYWUxYmNiMmhv?=
 =?utf-8?B?VEE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2353c7-db22-4c61-abe7-08dac21cd00f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 06:37:03.4719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5yKaK96NDiz0D725dmSxrBMfAcUBOnV+Sxb/l5VE3TXIc5QljBeq9G8v+Xf331vW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5518
X-Proofpoint-GUID: vcVpcfYxDxO4W0RFCS9klJMOzBLXTx6x
X-Proofpoint-ORIG-GUID: vcVpcfYxDxO4W0RFCS9klJMOzBLXTx6x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_01,2022-11-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/8/22 9:48 AM, mtahhan@redhat.com wrote:
> From: Maryam Tahhan <mtahhan@redhat.com>
> 
> Add documentation for BPF_MAP_TYPE_DEVMAP and
> BPF_MAP_TYPE_DEVMAP_HASH including kernel version
> introduced, usage and examples.
> 
> Add documentation that describes XDP_REDIRECT.
> 
> Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>

LGTM with a couple of nits below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   Documentation/bpf/index.rst      |   1 +
>   Documentation/bpf/map_devmap.rst | 221 +++++++++++++++++++++++++++++++
>   Documentation/bpf/redirect.rst   |  81 +++++++++++
>   net/core/filter.c                |   8 +-
>   4 files changed, 309 insertions(+), 2 deletions(-)
>   create mode 100644 Documentation/bpf/map_devmap.rst
>   create mode 100644 Documentation/bpf/redirect.rst
> 
> diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
> index 1b50de1983ee..1088d44634d6 100644
> --- a/Documentation/bpf/index.rst
> +++ b/Documentation/bpf/index.rst
> @@ -29,6 +29,7 @@ that goes into great technical depth about the BPF Architecture.
>      clang-notes
>      linux-notes
>      other
> +   redirect
>   
>   .. only::  subproject and html
>   
[...]
> +
> +User space
> +----------
> +
> +The following code snippet shows how to update a devmap called ``tx_port``.
> +
> +.. code-block:: c
> +
> +    int update_devmap(int ifindex, int redirect_ifindex)
> +    {
> +        int ret = -1;

There is no need to initialize the value to -1, the below is 'ret = ...'.

> +
> +        ret = bpf_map_update_elem(bpf_map__fd(tx_port), &ifindex, &redirect_ifindex, 0);
> +        if (ret < 0) {
> +            fprintf(stderr, "Failed to update devmap_ value: %s\n",
> +                strerror(errno));
> +        }
> +
> +        return ret;
> +    }
> +
> +The following code snippet shows how to update a hash_devmap called ``forward_map``.
> +
> +.. code-block:: c
> +
> +    int update_devmap(int ifindex, int redirect_ifindex)
> +    {
> +        struct bpf_devmap_val devmap_val = { .ifindex = redirect_ifindex };
> +        int ret = -1;

same here, no need to have '-1'.

> +
> +        ret = bpf_map_update_elem(bpf_map__fd(forward_map), &ifindex, &devmap_val, 0);
> +        if (ret < 0) {
> +            fprintf(stderr, "Failed to update devmap_ value: %s\n",
> +                strerror(errno));
> +        }
> +        return ret;
> +    }
> +
[...]
