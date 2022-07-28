Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B34558393C
	for <lists+bpf@lfdr.de>; Thu, 28 Jul 2022 09:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbiG1HGH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jul 2022 03:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234876AbiG1HFn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jul 2022 03:05:43 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737B95FAEF
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 00:04:52 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26S17uT9010636;
        Thu, 28 Jul 2022 00:04:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=LzfX+0IZYmZph4hoYJJr60ZQlG3AFR1vvvIGdYG1VV8=;
 b=adMxb8vcXkVsZPKrMXw/zCzRYLS9iBQ3/ye9SZFT46ZEnlJj1Yv56jQb/nQeg/mi3s7q
 EaqWwixraOMb4uqmqggUMuZpwigppP3Luh14+r68C27VVTD3EItBDmRdUiL0sBXjy16u
 tVV/Hhh4/m7OgLWVmyh+EAD6uM8aY2BymuA= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hk3ck7g5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 00:04:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nu6akkh13Ng/LTPwajHF3Mi309z/v5NmQXtDBAUBeqqjzrEyb7cJ8zbArf5yY/T/0TGEp/wNISFsTUGvZWErpKs3I3Chfq3b7wjeCB3gBpoV8UEPrBGxyGP91a1Nnl2jEirO2JMLk+lpoxt1tfmbdXtIUxhR1/rHIyzD0BlIqJDUe4dvxKiLFOxwePGBQZvuH5SMKKPJZk47lzBv65Ontv09GaFqTsdZdF13PWvkU4bvgjUIkmVUnXJoRyaGqVeNy4kmKW+HK9muZwJXClYGdhNZiyA2C5DHcx7WcsLpUVWRZx8lq+2N1Xn8YPp82Sbv2e+gqwcZW9K0CUr3KqxTjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzfX+0IZYmZph4hoYJJr60ZQlG3AFR1vvvIGdYG1VV8=;
 b=fIJnQ7moOhjM5eYA+3GK3B5smoSx8Ttjwueiyow3tK0rkemU1tuOqP9JyC3oT7awgu1E/9QoaKnWz6SB7rOdQmYFkjMJB9kF3I/LtjR1cSchVIt6NFm8lfVontl2bhZRFzShXSl5YB6SdadRZd7B10LTiJHLtNDnyVJjLJpJZtuDoZ0x79x+dDa9DJ3OFtdrJswfw1+QRIoJioPk2MrTr48qotaOQgrhd4+C+sqhxKLsBV0uZRIP4hJUjvnBvR65WoNvNn5jg+nhVOa+VBF/IY/A5GTyDxJ3oFADctAVrfGDnSdIpA7sjobtXOjkf+vRIKqISvzfokqi06LI2ggcBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN2PR15MB2878.namprd15.prod.outlook.com (2603:10b6:208:e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Thu, 28 Jul
 2022 07:04:35 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5458.024; Thu, 28 Jul 2022
 07:04:35 +0000
Message-ID: <e7d884ee-e0d3-02b2-c3d4-3c7bac8f13fc@fb.com>
Date:   Thu, 28 Jul 2022 00:04:33 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [RFC PATCH bpf-next 00/11] bpf: Introduce rbtree map
Content-Language: en-US
To:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
References: <20220722183438.3319790-1-davemarchevsky@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220722183438.3319790-1-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::20) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 338f452c-410d-43e4-a75d-08da70676deb
X-MS-TrafficTypeDiagnostic: MN2PR15MB2878:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JR+NQthk9RbNNZWEE15ZS8SV7y0TTjeR6VoxpMy8z6+POE/nhbxDQMR9CQ7dlZ2vJd4UWkgP9/0Yqw2VdPz+JuwW91CZtO0XjBDxJnvQBGWuyEHqb43E/Tm9j4QQkqXFAxIwDH5OYyuBjtMp1LFTP2P3LEAyav5leKFKuBZ7xGDx5SjH/taiJM36344bUXD7QsLmR2Gz4JDWjDoOqs+CqLCKLN1xJZcc4z4ixeCL7F4PItiinYnEGYMxU4u3MkSItV8lRROm/m9JJDnOt7KWFNWt/TkXEA70sjILfds6RCU51zADgiQRk/K6TNs2Lufelhsc84IPjIMmap8w65xyefmPqHSBjVIdlu6q2IG4TdLCi788XLBZLMR1K3L8isexkah5LACpGDgMNALCKP4NdVeFCIppXLGDmpw27OqLOwWAjqYLzgxcBmErZh6aWNir1llnGJfC6t1jWdjyYPXT3tjo67ZkAcI/JqekpstcyRJJSMGC+HcvShuDuC+aurqMJ5wnhKa/F4A9Vuc9kB+A31hVAUHBHfS3O8HSuNxQNqH6DpdzH7toHRg9Yjnr4tsSIigPycGmOAvgSRM5pOVJ4Kdy39m5j9eIEu7iXkjwsJuP3L87iRVMpdv9GXSypPYi7yIAIJwZC6ozOGWKwW/lOEo+Py1R1bqI++zPmV7UacrzYo7A/72b2DTWoYRHrheqGyLygmLJjXr4mp/Cma04iqBttiZo96pIoSRwu7TbziRktlwscK13C9ECLbEEjsuA+X2N8MO+ZtqZnGx98n/iwPnVXplhyszEKU2BPEBMkNHz2pezlQ38T8GMfgH/Zsb0Vgy5BvM8iiCQyJHjHRDTCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(2616005)(66946007)(4326008)(8676002)(66476007)(66556008)(5660300002)(2906002)(36756003)(8936002)(6486002)(38100700002)(31696002)(53546011)(6506007)(86362001)(478600001)(6512007)(41300700001)(83380400001)(186003)(31686004)(316002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SE9Vc05BRzBGck1OQ0FMQXJwY3BMd0FrQ1BQb0VjajNkSkV2R0psSGNFUEVx?=
 =?utf-8?B?cFVTSjlVd3pSN2g3T3VwR0w3aTk1eTVkMFJhdmYwY0xMUkhoakIyd2pGOGdO?=
 =?utf-8?B?NmwzOWZ4QmRJSncxVkEydm1GeEc5YW8vMHd2cnprNHdZeGgrdWJFS0FrbWZ5?=
 =?utf-8?B?ZHJmcS9jRWZianFkRjFyWWhoeU52ZDJWL3NJTnNFbEdndEt2VWJ1ZUNRUW9r?=
 =?utf-8?B?WVBUQWhjTm1hOWRkU1c4M3NhWDM3MFAzVDBPKy9Nb25kc2RNbjIwVnNMUE4v?=
 =?utf-8?B?THJFeitNODh2V3J6d004R28rVzFJYUhYTUdXZU1IZ29HU3NKUytyM2VyN0Z2?=
 =?utf-8?B?WERtbkZtOXBlQ2NnaDR5MHJSQ0JkZ0RSSVJnYXBnaUtqMmRHMDhrRDB4Skpq?=
 =?utf-8?B?UGIxU0N0b2tyenhJbnl2MFNDdmplS2srOGIxaWlVeTNGM1FWZVExcHhMamw2?=
 =?utf-8?B?OCtRSUNlTkFoMUFEeDh1WFFpNU1teU1DNVZSUFZ0Y0M3YjVGSVpzYUtRR3l0?=
 =?utf-8?B?WkxSUWN3d2lMZlBPWVRpcmxOeDVHMUFGTmZPcWwvemw2RUM5S2tJNklrT2hv?=
 =?utf-8?B?VDlUQzNkY0NxbXFrSVNHbEVQcWhSSnJzbWFQa01KSkhZcURPc09zTjduZW1r?=
 =?utf-8?B?SjArQ1UxN3F5V2ttS2dXVVhtMFpYaGpjODFCVXBHRktwTm11MkpZK21qWGZj?=
 =?utf-8?B?bXloUjVQaWxkNFhKR0dITmRUOEVNeXE0WjRRZXk5QUpZWmxHdU0ycEN5RGE3?=
 =?utf-8?B?RzBIOW05MDRmNDBzcVc0VjA3Tk52ZTVhMGxQK2VqYVo3TjIvaGJCaTVyRVF2?=
 =?utf-8?B?WTdkVGJzRVA4RjlnSEpNMjdGYU5jNDIzUkdmUlhvUUJBRFA5SS9WblhSUnE1?=
 =?utf-8?B?L1VLZG1KWmdtK1ZQNjFkbTJDK2h6b0VGdTVxN3FkaEg2UWJYWHU3MVNDd1M4?=
 =?utf-8?B?M2lGb2ZXUkIwdzc3M2lRejducVZVQkdRNm1QcVNaaG9HR1NHQ0IwNmVTU1Jh?=
 =?utf-8?B?TTJsOHpqQ01Ca1B2bnNoRlJpTEQvU1ZPa1NpdUtUYjh0alR6aENpOU8rOTAz?=
 =?utf-8?B?cmEyNVJLNmp4Vnh1ejY2TUdJR2wvN1dLSzBiYngvNHpCUlBuV3llNWNSUmRE?=
 =?utf-8?B?R2ZSMi9UM2VtSytXSFR2bW5wT0NZbDRUZ09sdWVtTjNGVkpjQUJwQW1kUDI5?=
 =?utf-8?B?M0RaYWt0Y0xpVjQ0ZjFaS1h0Rm5tNUpBYjh6UlBXNHRiZUpXRGQ3UHUxZ2Zh?=
 =?utf-8?B?bE1YYXNqcWZiaFdIRGtpL1NHSnVzaUR0UlRicmhHN1BadHVhU3QrQzhjTjN0?=
 =?utf-8?B?eEgrdlhUcjV5bDhlTUxZMmhBV29VMXBTemYwVUpGSGoxK3FPVWJ2K2JKOGIw?=
 =?utf-8?B?TlVyN25nWFdqSko1enhjbkdwSjZUMkd4RkI0QnBxemlycS8waTM0eU9YM2VW?=
 =?utf-8?B?MHlBR1dic1RSWm5icjNLZlpvaHNmQjNSQzB2TTk2dDROVWtnamZ1VFpiNUh2?=
 =?utf-8?B?amdnai9ZVmVSQ3h2c0I3eDBiU0ZWWGxkZm5tZ2lZbDkwd1V2TVlQS3EyalF2?=
 =?utf-8?B?YmZUNTJqcEJ6U0xaVS9GUHo5ZTI5YlArRFdwSzdLN3ZlV2JFb0xKTlJtZGdk?=
 =?utf-8?B?RmtRWEVqVXhEejVVMXF0Z05iMlJ5UUZXQ2FZK1RHblAyc0RZY3dNU3hON1gy?=
 =?utf-8?B?LzlqT1BydE5tTC9PbzVrT3NJd25oQzFNSVBEaFNNc1hXenRkd2E1V3JyRk1H?=
 =?utf-8?B?SXYxN29EUDVCUTNndWc3aVdMcWdWZSt0dlgxbUpaU0RCWmwyVFRWa3hYU1BR?=
 =?utf-8?B?SzVXTDFTMGpUamlrYUlxeGN1V2NyUVpPQ0liYWtaSFFVeHdZRDdtdW9INWxz?=
 =?utf-8?B?Nlh6SDVUU01XV3lvOUlXK3RjT3dpcjBaaEZHUkZ5M1ZIYXFMaUVoNDM0TlZr?=
 =?utf-8?B?a0g3ZDBSVStWWlNUdDBaTlR4bWxZSGdtNmtxMnoxaFVWVXRVRlU1MmFNcTVv?=
 =?utf-8?B?Y1NsSnNIa013L1djSTdZTUw3RWpkMmM5YVQ0UkQ3WG9PQlJXTmVRSEhFbGFW?=
 =?utf-8?B?TVRSOU9XZ1NoR1NJN1JWTUxNTUNFRTBWazZGSzFPaXVNT3dDeUprL1RBbm41?=
 =?utf-8?B?N0N3bWZFQndidzRkaTIxOU9zS0haTDJSYVJVdmhOa2g0SUhaazNqMWxGSmw1?=
 =?utf-8?B?b3c9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 338f452c-410d-43e4-a75d-08da70676deb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 07:04:35.5386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pV6ZnD2ebiJGKXpInYm4LmhnRmM1+F49tV1udxeXjiGSwaUV6RiOwvjbiJB1Qe2G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2878
X-Proofpoint-ORIG-GUID: SqJY53KDKP4COhFfw4nGWnD2Veif6f_o
X-Proofpoint-GUID: SqJY53KDKP4COhFfw4nGWnD2Veif6f_o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_01,2022-07-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/22/22 11:34 AM, Dave Marchevsky wrote:
> Introduce bpf_rbtree map data structure. As the name implies, rbtree map
> allows bpf programs to use red-black trees similarly to kernel code.
> Programs interact with rbtree maps in a much more open-coded way than
> more classic map implementations. Some example code to demonstrate:
> 
>    node = bpf_rbtree_alloc_node(&rbtree, sizeof(struct node_data));
>    if (!node)
>      return 0;
> 
>    node->one = calls;
>    node->two = 6;
>    bpf_rbtree_lock(bpf_rbtree_get_lock(&rbtree));

Can we just do
      bpf_rbtree_lock(&rbtree)
      bpf_rbtree_unlock(&rbtree)
? Looks like the only places bpf_rbtree_get_lock() used are
as arguments of bpf_rbtree_lock/unlock or bpf_spin_lock/unlock?

> 
>    ret = (struct node_data *)bpf_rbtree_add(&rbtree, node, less);
>    if (!ret) {
>      bpf_rbtree_free_node(&rbtree, node);
>      goto unlock_ret;
>    }
> 
> unlock_ret:
>    bpf_rbtree_unlock(bpf_rbtree_get_lock(&rbtree));
>    return 0;
> 
> 
> This series is in a heavy RFC state, with some added verifier semantics
> needing improvement before they can be considered safe. I am sending
> early to gather feedback on approach:
> 
>    * Does the API seem reasonable and might it be useful for others?
> 
>    * Do new verifier semantics added in this series make logical sense?
>      Are there any glaring safety holes aside from those called out in
>      individual patches?
> 
> Please see individual patches for more in-depth explanation. A quick
> summary of patches follows:
> 
> 
> Patches 1-3 extend verifier and BTF searching logic in minor ways to
> prepare for rbtree implementation patch.
>    bpf: Pull repeated reg access bounds check into helper fn
>    bpf: Add verifier support for custom callback return range
>    bpf: Add rb_node_off to bpf_map
> 
> 
> Patch 4 adds basic rbtree map implementation.
>    bpf: Add rbtree map
> 
> Note that 'complete' implementation requires concepts and changes
> introduced in further patches in the series. The series is currently
> arranged in this way to ease RFC review.
> 
> 
> Patches 5-7 add a spinlock to the rbtree map, with some differing
> semantics from existing verifier spinlock handling.
>    bpf: Add bpf_spin_lock member to rbtree
>    bpf: Add bpf_rbtree_{lock,unlock} helpers
>    bpf: Enforce spinlock hold for bpf_rbtree_{add,remove,find}
> 
> Notably, rbtree's bpf_spin_lock must be held while manipulating the tree
> via helpers, while existing spinlock verifier logic prevents any helper
> calls while lock is held. In current state this is worked around by not
> having the verifier treat rbtree's lock specially in any way. This
> needs to be improved before leaving RFC state as it's unsafe.
> 
[...]
