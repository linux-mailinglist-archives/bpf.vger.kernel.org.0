Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1956F0C2C
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 20:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244283AbjD0SzM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 14:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjD0SzL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 14:55:11 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024FE40E5;
        Thu, 27 Apr 2023 11:55:09 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33RIPrx8018514;
        Thu, 27 Apr 2023 11:54:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=CmGdseHKCWVmuIOM+9VoWMLXLJiMs07+G/RQ7xB3rQ8=;
 b=NeA/Dxv0CQ8ErVR4yad2ZL/dYldA4YvRiPhnwa7INN806vG9TF5y2EAqijH6dJdQM2q1
 4AYwcSp4bc3t4f7OK7k61Zecn7QDEu2eynDcqPwEOItUueSuKfSVs0/Id9Nyy3BtSeKp
 UwDo1KvCx+X1NjYVjLG4GykwYrAnLy8nbCjUVDQ9Ir9YDDf3Gbk6OQb92Dv3stFaLjI/
 RyD6I9Y5R39fyOyaLQz7t2b1j4fRvcOCipniH0IR0Bp5QNBbGY2Q8WP+FZzlf7Gqy9s4
 sZ0yl4LQhLCCmYebQu3soCb4e/tjmYHTzObQYK84dr2AmW+ompXOMSppcp9sbkh62E27 Kg== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q7av587m3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 11:54:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eo1yTAoVx24bPVbiy/4xrAVU+L0lWtwVKYNXYK2KJnvKhHhHFRGfP+8PrCsFvB2evrBanVE3NbqWyfy6evNYMoJtwRaa3uUdp6/wlk9lJpAMQ7S5KR2WTUUeNjILMcrf+cZGgzu1r0WmWR44TeBB/ZytssL6VETxjukpLJu//3uGNOdnCGmG4Bsj1KzQI3j4PkFX1ZxrRxutTQs5TnvmiEoU3oZDtN6ZWHsZQHxM45YMNUijSaoASc5hhCNID6ao9H/lupJ8Q4aeyQrNn/9KU2EAQ7ZJoBSkiC0NsxEsYr2MVUf/m1N1QpRFrLdv0de13RnPI3J7HkVqS4adV80ZWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmGdseHKCWVmuIOM+9VoWMLXLJiMs07+G/RQ7xB3rQ8=;
 b=WTfoQXOL0Furrdc/OCpOU7yvI1xCZpJ1A6bS0AFA/ohqYVIi+JBd75WjZPVp6EzWaokm2df8l4OrLrc4PAx8Q8cuirBVzrCysdsOYBDdu5kCi80qXwCR7Q+u1VkSmnbCZjUz1mN/q5NunJ3WtYuAn5zm7gOg2dnh4glHJnQGQHDwnY8ypQFNA/dKjhg07R2aaEsLsrbdZzKk6G1BYWvsNnq5bhroV9VQ80cLlgGTtaCa2b3kMnWw3a3Zlwe1XneHexJ1Ml1LBYZx0yHRt+NIZyJEzFIQz12yedipnrjIGv2H6VKMkNbfmGcCUqYL+vAWK38I9b2ZI/HpSNtV91PCtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DS0PR15MB6040.namprd15.prod.outlook.com (2603:10b6:8:168::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.28; Thu, 27 Apr
 2023 18:54:20 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 18:54:20 +0000
Message-ID: <9e36407a-22fb-0fc1-b147-ebdc12ea0823@meta.com>
Date:   Thu, 27 Apr 2023 11:54:16 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] bpf: Unregister fentry when bpf_trampoline_unlink_prog
 fails to update image
Content-Language: en-US
To:     Chen Zhongjin <chenzhongjin@huawei.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org
References: <20230426095548.176045-1-chenzhongjin@huawei.com>
 <b594a56f-5e1f-da7f-0ab1-71751bd0c5e2@meta.com>
 <be9efa60-14ec-ba46-91e1-9feb56c40fb8@huawei.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <be9efa60-14ec-ba46-91e1-9feb56c40fb8@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR08CA0030.namprd08.prod.outlook.com
 (2603:10b6:a03:100::43) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DS0PR15MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: cafbd777-e93b-4f24-c24a-08db4750cf0a
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HgCwP6nz2R+Lf5FqnXV2QS7+ODR/Jlc3JR5tVB+8ZjtXsElFDO7BAWqygkftN2nB1Rsbr3RRSyhS9He6aENgo9B9HGP/E8B40sHW5TYtzyCgubhVhhlz/A5TQ0mYAATRmPr3dVqhtktZKh0Detu336ffQCwX3SWsWfgi1dSw+ud9M84SA3fvsIdSIYQy7c+Q41aHv72lldVVg2yxgD1/vsV/SOAtApP9PDvjGhmv7nDD79SC/HkiH4MXaaSP/mkAnNQrIQVavbGvKenoIZPcRUeY6X6Uo2pTo7L2YgA7SpP8IVHdlLmg6uG6Mq6tn3vj+/AvGSJiZcbWSnfI2ftf2z2EhKeV/ropRn1s7rPpMigYspzZ74Bqm/pj+6mfuW6ZjrSsjx4QUywUCN3f6A5Vhzd35857FYo/5dIKvMYdRZW1/NYlHBQIwpNx17isispSPTb4dmEgHjOX0Bq4PD7sacsWvDtOgpDJwJF1FVIe+rr+md017JAvvZTL/EvcRPZUMiBuG4aQuKrpVFAkYw+I8hUJjM0H+PLIC60QkJYx73kcmABFG9Lhf6XJcqbTlOYIlsjbATIgfP2Y1vkVxokf1TKMWR+hX0PxRKjozTr/An27Zstv/o1UU+dTHsFq8p82/7wciNkXE9PboyglOkBDEUIf5QtvY41KJKm45d05oIw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(451199021)(31696002)(5660300002)(7416002)(8676002)(478600001)(8936002)(86362001)(38100700002)(15650500001)(2906002)(66946007)(6666004)(316002)(31686004)(6486002)(66476007)(66556008)(4326008)(41300700001)(6506007)(53546011)(6512007)(186003)(2616005)(83380400001)(36756003)(3714002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjZOendHN0g5bUQyVTI2K0lMK2ZXSDA5QkRCM2kySTJkTnczaCtrbHVVTkpj?=
 =?utf-8?B?ZlJJa1JCRWFKbGFRQTNCbzM3RDZwVDBmRkt5OE8yRU4yNkFEaGFLSXNTZVJD?=
 =?utf-8?B?eEl0NHVOOFFUTit2cHBreVpxUGdRZTlOMlpRaTA0ekd0UE1hUytoSHFuWFdN?=
 =?utf-8?B?MEQrRzE3bjdkN3E1TElSVmU5R1o3bEhzMzJJZGNCN3NrTDVGM0hDeWVRK2VC?=
 =?utf-8?B?MThvMDlyK0FJSlF0N0FWdk5YNUtZaXB3aURHUllVV2d2YVNSUnRNaUowdWhp?=
 =?utf-8?B?dVAyUkpiejQ0ZU85SjlJQWcrd2svZC9SZUVPT0VpdXZ1bUNQV3BnWExmQTZp?=
 =?utf-8?B?a0FiNkg3SkV1QkRTSXJaWENLODZ2cm54TmZadEs2Y2dVVHphb2xDWEJ1SnNk?=
 =?utf-8?B?T1pzSXBXLytqNDNJSTlLUXRIa0sxaVZ4WTg0RDYxT21yb3NjR091dlZNYi8v?=
 =?utf-8?B?cHZVTDdqa2grNzBNSGI1b1hTYnRJY2hwcmFkNDVJbTQ1THgwSk01QXpxdC9G?=
 =?utf-8?B?T3hWV1d6U0FGVUxwdEVDbEFubXdVWFV1WlBVTWw4VGRQU0FPVmJaek9Ka2Vh?=
 =?utf-8?B?TStjdGxlM1NVQ0lUbjgwaklkVzY5RmtaeVdrTm4rVVRjcXkyTW0wdm9sajBl?=
 =?utf-8?B?N1ljcVNtNUlYQ0NOMXUxTlA0YWVVZkhWQTAwT3lvSWFjRzJzZ0JUUDcrZ0pS?=
 =?utf-8?B?S2Zlb2ZCVStDb2NBcVVxOUNlUlZYRVlSNUJyblRxbWFqaFlOL3dTM2tWbUVw?=
 =?utf-8?B?N0FlTmV0eDZoOTVFek5nZ01INkhUMzNPRm9Od25jdkJwZlJqSHc4Z1hPYkZy?=
 =?utf-8?B?ZGc2ZE5PZGxLVi9SUWgyMGVpTm4zaEpXOHNvblg5azI1dmxpcTZZT2Fib0pK?=
 =?utf-8?B?ZDB4TVhvK3liVjBZVWQvd1NPMkt3azZlZ2lEeUwySXMvTGRPZGpoWWFJQmZX?=
 =?utf-8?B?aitlcHpmMXNTT3FBak1TZm5oRW1Hb1ZqZjFUc293Mi81TUtFSTlTNy9nbTRa?=
 =?utf-8?B?NHNUd1lmLzROSTdMSitlNXVKU3BrVXpKTnhnRk96azlJaUYybGV1MEJTWG42?=
 =?utf-8?B?MVJ0WmlpNEg2U2xYZGliQVdnRDZXN1ZaUjUyU2MzVXRHT0g0bjN2U0hmdzZR?=
 =?utf-8?B?S2ZjUFVaNXF2cmdlUEFrRitoWmRaZlF1QnlsNmtiSWp2c0xJY3RwczlsaGJK?=
 =?utf-8?B?QUNCWTEvWXNXUklTQ0NpeWExaDhZVlRBaXNyUml2OWhzQytHZ1NTaCszcUlj?=
 =?utf-8?B?Ky9LR2xuSENFVDJyTVA0ZHlyUjBCRGNBK3UxVTNNc1loQnZOd0VGUEh5M1Zq?=
 =?utf-8?B?Tk11bUIxNC9Qdkdta2ZaTW9TN0FrckU0aW8relJ5Nmh1enNrcllUc3RMQ3M0?=
 =?utf-8?B?MEZJV1J6VFB5N21CczNhRm43K25YYTBjWHQ5TThRbHdLYkFRWEtEdnNxMnc3?=
 =?utf-8?B?YW9TVEU3ajJ5OFZWT3RRNXFnU2FFMGlsVktwL0hNdUJIaHBDR1d4WCs1MGUv?=
 =?utf-8?B?clBSR28wZGtHd09mSVBqVXVtMFN3eXlPMnJjUUE5MnF0b2FBM3JhSElJYUpU?=
 =?utf-8?B?bzJ3a2puNmZ4TjhhUytpU1lTdVVGaEhEa0VPVmFKTStWeC9TTjVUbUdjMm41?=
 =?utf-8?B?QU1LK3pwTW5ZUFV3ckc3RmowVGtsaU5UdHdUR2xPVXI5YStjQm5WVzBOTTRu?=
 =?utf-8?B?aUhRcVZjZWZnMUhkbXpGc21oOCt1SWFpM05ack9jcFU5V2hRTytwU0sxdXow?=
 =?utf-8?B?L2lMczZ6bWI0SjFraTdGbFR5QURVKzBzSlBPNHJpVFdDMnExVm5tSHpqV1Zl?=
 =?utf-8?B?ZkNYR3dhcnMxQWh1WjR6SUFVMTNPc2dhbTV6YjBlakFFWUd4OFhBYzJiOVpG?=
 =?utf-8?B?QVhKUWZRWjU3a1RUMkpVVDJ4Z1NIZ3dBR3N0SndZS2VRZEx0RW0rMEVmbjhW?=
 =?utf-8?B?bmRraGFRb2pQcExxemUxeFlLVGlUNXAxM3FtbzFkZllxb01jRUIxbklVK0gw?=
 =?utf-8?B?MDhtbHE4ZmhTUmhCUzdTMEdRTFJ6Vkk0S0U1aDMva0VCVHhXZTU4QmR1Z2ZI?=
 =?utf-8?B?QlY5dlN6UGIvbE4rY0FFdXFKQnlvNlBZMS85Rm41Q2RxR3FkM0ZPMDIyaW5M?=
 =?utf-8?B?bnl5NGplbmlkRENzQjBTWHBlRy9ldWVQckpQcUNkdjByZGxXSlFmdzlOQzN6?=
 =?utf-8?B?dFE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cafbd777-e93b-4f24-c24a-08db4750cf0a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 18:54:20.1378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yX9HiFGLvvEONl+GEKbtjovc+DFOFrC02aZNDxYvknfMXmyQWzLjXwpDoegJfXAZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB6040
X-Proofpoint-ORIG-GUID: KDrxYpGSr17mX9YJ51fa09Ofi5QG--9C
X-Proofpoint-GUID: KDrxYpGSr17mX9YJ51fa09Ofi5QG--9C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_09,2023-04-27_01,2023-02-09_01
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/26/23 6:40 PM, Chen Zhongjin wrote:
> On 2023/4/27 2:17, Yonghong Song wrote:
>>
>>
>> On 4/26/23 2:55 AM, Chen Zhongjin wrote:
>>> In bpf_link_free, bpf trampoline will update the image and remove the
>>> unlinked prog.
>>>
>>> bpf_trampoline_unlink_prog is committed as 'never fail', however it 
>>> depends
>>> on the result of image update. It is possible to fail if memory 
>>> allocation
>>> fail in bpf_trampoline_update.
>>
>> Could you give more details which memory allocation fail here?
>> bpf_tramp_image_alloc()? Are you using some error injection or
>> this happens in your production workload?
>>
> I guess it's an error injection because syzkaller reported this.

Okay, this is what I suspected as well.

> 
>>>
>>> The error result of bpf_trampoline_update can't be passed to 
>>> bpf_link_free
>>> because link release callback returns void. Then it will free the prog
>>> whether image updating is successful or not.
>>> If the old image tries to call a freed prog, it makes kernel panic.
>>>
>>>      BUG: unable to handle page fault for address: ffffffffc04a8d20
>>>      #PF: supervisor instruction fetch in kernel mode
>>>      #PF: error_code(0x0010) - not-present page
>>>      RIP: 0010:0xffffffffc04a8d20
>>>      Code: Unable to access opcode bytes at RIP 0xffffffffc04a8cf6.
>>>      ...
>>>      Call Trace:
>>>      ? bpf_trampoline_78223_0
>>>      bpf_traced_function
>>>      ...
>>
>> Could you explain how 'the old image tries to call a freed prog'?
>> IIUC, the previous bpf_link_free() should not be available to
>> call the bpf prog, right?
>>
> What I mean here is, if failed to update the image, the image keeps 
> unchanged but the unlinked prog will be freed later.
> Next time when it enter the trampoline the image will call freed prog.

Okay. This description is better.

> 
>>>
>>> Fix this when bpf_trampoline_update failed in 
>>> bpf_trampoline_unlink_prog,
>>> unregister fentry to disable the trampoline. Then other progs on the
>>> trampoline can be unlinked safely and finally the trampoline will be
>>> released.
>>
>> Do we still leak tr->cur_image here?
>>
> No, bpf_tramp_image_put() will free everything when all progs_cnt 
> decline to zero in bpf_trampoline_update(). It is a release function, 
> but called 'put'.

Okay, I see. But it depends on where memory allocation failure
happens. For example, see below:

     static int bpf_trampoline_update(struct bpf_trampoline *tr,
     bool lock_direct_mutex)
     {
         struct bpf_tramp_image *im;
         struct bpf_tramp_links *tlinks;
         u32 orig_flags = tr->flags;
         bool ip_arg = false;
         int err, total;

         tlinks = bpf_trampoline_get_progs(tr, &total, &ip_arg);
         if (IS_ERR(tlinks))
                 return PTR_ERR(tlinks);

         if (total == 0) {
                 err = unregister_fentry(tr, tr->cur_image->image);
                 bpf_tramp_image_put(tr->cur_image);
                 tr->cur_image = NULL;
                 tr->selector = 0;
                 goto out;
         }

         im = bpf_tramp_image_alloc(tr->key, tr->selector);
         if (IS_ERR(im)) {
                 err = PTR_ERR(im);
                 goto out;
         }

	...

In bpf_trampoline_get_progs(),

     static struct bpf_tramp_links *
     bpf_trampoline_get_progs(const struct bpf_trampoline *tr, int 
*total, bool *ip_arg)
     {
         struct bpf_tramp_link *link;
         struct bpf_tramp_links *tlinks;
         struct bpf_tramp_link **links;
         int kind;

         *total = 0;
         tlinks = kcalloc(BPF_TRAMP_MAX, sizeof(*tlinks), GFP_KERNEL);

If we have memory allocation failure, PTR_ERR(tlinks) will be returned
and there is no chance to reach 'total == 0' so tr->cur_image will not
be freed.

But if the memory allocation failure happens in 
bpf_tramp_image_alloc(...), yes, it is possible eventually when
all progs are unlinked, 'total' could be 0, unregister_fentry()
will be called again (hopefully no side effect) and the image
will be freed.

> 
>>>
>>> Fixes: 88fd9e5352fe ("bpf: Refactor trampoline update code")
>>
>> If the above is a refactoring patch, you should not use that
>> as 'Fixes' patch, you should pick one truely introduced the issue.
>>
>>> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
>>> ---
>>>   kernel/bpf/trampoline.c | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
>>> index d0ed7d6f5eec..6daa93b30e81 100644
>>> --- a/kernel/bpf/trampoline.c
>>> +++ b/kernel/bpf/trampoline.c
>>> @@ -604,7 +604,10 @@ static int __bpf_trampoline_unlink_prog(struct 
>>> bpf_tramp_link *link, struct bpf_
>>>       }
>>>       hlist_del_init(&link->tramp_hlist);
>>>       tr->progs_cnt[kind]--;
>>> -    return bpf_trampoline_update(tr, true /* lock_direct_mutex */);
>>> +    err =  bpf_trampoline_update(tr, true /* lock_direct_mutex */);
>>> +    if (err && tr->cur_image)
>>> +        unregister_fentry(tr, tr->cur_image->image);
>>
>> If error happens for the all subsequent programs,
>> unregister_fentry() will be called multiple times. Any side effect?
> It will fail with no side effect. Actually if there is no error, 
> modify_fentry() will fail in update() as well. The fentry is available 
> until all progs are unlinked and the broken image is freed by 
> bpf_tramp_image_put().

This will cause a sudden behavior change if there are other active
programs. For example, prog1 and prog2, prog1 unlink triggered
memory allocation failure and caused unregister_fentry which restored
the original ip. Then prog2 even does not have a chance to run any
more even if memory suddenly not an issue any more.

> 
> However with an extra state to record this happens, it's possible to 
> re-register the fentry with new image when the next link/unlink calls 
> update(). It will generate a new image and replace/free the error one.
>>
>> Overall, I think this is an extreme corner case which happens
>> when kernel memory is extreme tight. If this is the case, not
>> sure whether it is worthwhile to fix it or not.
>>
> Yes, it's a really rare case. I'm just not sure whether it needs some 
> best-effort to avoid kernel panic at this point.
> 
> If you think it's not necessary. Just let it go.

At least with current patch, even we could avoid kernel panic, the
user expected behavior might change. To handle all error conditions
in bpf_trampoline_update() might be a big task. So I suggest to just
let it go.

> 
> Thanks for your time!
> 
> Best,
> Chen
>>> +    return err;
>>>   }
>>>   /* bpf_trampoline_unlink_prog() should never fail. */
