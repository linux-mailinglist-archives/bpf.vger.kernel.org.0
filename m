Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1EE601787
	for <lists+bpf@lfdr.de>; Mon, 17 Oct 2022 21:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiJQT0X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 15:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbiJQT0K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 15:26:10 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C985476970
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 12:25:58 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HJP4AB023827;
        Mon, 17 Oct 2022 12:25:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=pyk8UK+a+sd9jSGvZ1Gb3D2cUoEnXf5bAyrHSfPOFX4=;
 b=g9cM10uAHxbRl2tZwUD8uX1YygZUkjK2WkS3gy6gzzQnoW7gO260N1HLqx5p6UwVaAR1
 jAH7ypyBEYrw2QYTLNnZdfPWbuvPzqu6YZkMGQlH1fis17sIMV9yx3nGPjp+ZoZfXVim
 ISHd9d6w02vy9DXQ7o/0FyaiF4uw0I4z6Zxw5SjasYsqP+a7E481a8LRzZKn1gcGo7dG
 5ov214nKxn/0qukSyAHlwROC+tlRxl8sarC+tDciflFU5FSJiyweCtPqYt1DUycZKnz7
 BfV4ry3qQW8QI/ba2f086k5cheuMEjMqkzoLwxqzCeuuExbEzzQu+AM0LxrGObBBvbgE bg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k7tpv3gh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Oct 2022 12:23:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6+PjKHDPgRYHtJszgMFNy++8k6ZBOTwTqT8YKHyZflwadCsUQ6iA2SBq6H3DZ9WHq38Sm7d75ENNTeBp7WtBcFzy+/BgiTeqiChtKrXltaJSuJr8EludkUdnSxPpPseOSL4mo97fA0KUQAUgBnnuz/sg+Qxc5QzKHaFVANJQj7nQcvnKKt0ol+TKuiVU+d+vABpFi7XWtquMwkcSHgToShrG0bc6k+MP4JFiTkEdBtb65cterGXrnAK81WB8NDAC15R68SRTQQtVqf4couCdOEW8bAqqrnLe5bJHv8t7etuH4vU1cRHRGtOaPMtrBAnnBo3WRuwgdmCv+tKJLEXNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyk8UK+a+sd9jSGvZ1Gb3D2cUoEnXf5bAyrHSfPOFX4=;
 b=PFrMjSTuHsPe1fvE8B1Yh9k5hZCh3BIBulx4vn86GmCBva569SDxIfDNdRgLfos2EBO0+JIUO7i8yy8OOeodOqm1FJb1dQFbw3Ch+gdesi0e1KYy0Xi9FAOyG5Ab3VLAMxRqsC3q5ULq082SPU1eKDgdv3UjCdojObWbcRrn9OH9fjdUHzlfR+Fwj1Vs7brLru7UZuZyrSN9sD+VASOEIlgsKu6S7udn2YI6hQ44lCEmbnDhnvHqcA2twq+8P/yQ2ebl0yKQjsYefF/bYdIAbrmkhCv3FEyiMTkYxxzEEwqjxYQqlHYNwFcXd5vpgIW2Mp/y+qqF630aUOY3G6BfEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB5237.namprd15.prod.outlook.com (2603:10b6:510:141::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Mon, 17 Oct
 2022 19:23:43 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::6e08:a405:4130:f36e]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::6e08:a405:4130:f36e%6]) with mapi id 15.20.5723.032; Mon, 17 Oct 2022
 19:23:42 +0000
Message-ID: <b997fb5e-ce9c-a693-cd6f-8c1405bbc13c@meta.com>
Date:   Mon, 17 Oct 2022 12:23:36 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [PATCH bpf-next 2/5] bpf: Implement cgroup storage available to
 non-cgroup-attached bpf progs
Content-Language: en-US
To:     sdf@google.com, Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
References: <20221014045619.3309899-1-yhs@fb.com>
 <20221014045630.3311951-1-yhs@fb.com> <Y02Yk8gUgVDuZR4Q@google.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <Y02Yk8gUgVDuZR4Q@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0279.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::14) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|PH0PR15MB5237:EE_
X-MS-Office365-Filtering-Correlation-Id: bd350c20-0927-4b2a-cf68-08dab0751a35
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nD5tLtn8oJkgQAS/6UbJuGG+zDH5xLGR7TsLbq9u1JS1I5DG46rncJuAzqoVRU2TP6g73GE/FhvHkTrRKB1CeogW/tsQQy/KnL3XoCg45I1A09pq46S3hpAbpsSEDPwGzTxtpTAPtLTUm5cQ6+90zKTvUUAfuCk9ZJIEWy1tYTjxFa2RPJd70t+XzzWmh9U5+JddYhUhjysDEf/E4X1bbAZTbMVMg1hlLvf+APzdtVv7Sf8J3oRHuEl9RkZtcVMFfgxiqI+4mv6iVR7DYSxB+vK8NxT5TSNE7Ocl5yXS3xBNcWUCek7HIAogkmTASKEZo1HvWf6Lntqr9ims7ieIf1TPQmbZYkTjPgU6wEDCotGRr+oi4ZBYuNlXBMsXjBfC6HSynpSywfANM+Tt/7XZEahgTSBHE/4tO+bru0cQv6aXWM9fwEW736s88dFfhOZsnZnsZbf8Z3mRDVqY4qnnQ7jZN5HNmFk2RYguclfTbDai/HMpDlMV3C0Zwndbvu9DXS/EoNtJ6biXoTddHtH9om4w/Iv2i1NtwWxo+9Wf158Jc472+XfVp/RR9SSwRC86k1MCi3+X/i4ul6jp4TId92epShnYa3iEkNaZU1dUJr3YQ/II3TzT0/zlBXKXq2o0n3YNW+hVBxVAYpXQN50uvR4Eb8PP3pYiY5j51Aq5So3vuvLYHtoAMWNzEF6MhOqtpRW2bHor2kM/qCtTf/774xKCMJYHmQYGBbqsicYxAbMyUaAnJSX5dBc6nwcb5sEtR1B1+Rk3zvSgcKefDnkx9ATV2PNRJzs3DBB4IuH2yzw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199015)(38100700002)(186003)(2616005)(2906002)(31686004)(6486002)(478600001)(66946007)(53546011)(6666004)(66476007)(8676002)(36756003)(31696002)(83380400001)(54906003)(30864003)(6512007)(86362001)(66556008)(8936002)(6862004)(4326008)(5660300002)(316002)(41300700001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEc0RzNuajFHSTRjK1NuVXAzU0k5ZTZSSktwK0gzTWNjdWd3TXpaNmZ5VEFx?=
 =?utf-8?B?aXY5Ym1aWXV5MkFhVnhTak9aOTViSkl4ZDlTZldtTWRRWXpCSGx6M2NzS2tz?=
 =?utf-8?B?T0g0UnJ5dFpKVnlUUDRkQlQrUCtBblFqUFpDQXl3WTZWOWVvSEdMRnNBa05I?=
 =?utf-8?B?b2tzSWFuMkFPVUdJaTloUkRRbFJCaXFVbU55c2YvazFzYXhOejlKSlFBbU5V?=
 =?utf-8?B?aHBGRVY0MU9ld1pBMDc5RllxZE53b3cwYkN5dFZ4dDlQWHZpTUZ2YXlFWkNU?=
 =?utf-8?B?eG5ucTdXSGxpQ3J2ZXJQd1d3U09LQkZuaEJkT2NoK1dtaFVLenZYZnVBTnVx?=
 =?utf-8?B?Y2lOUmJJZFdELzhIblFEczF1UlNxTVZObXBDTlNzajNwNzBydUIrZzBFcnNL?=
 =?utf-8?B?dDV2bGh2V3R2T2FHWUdEaGdKWkExQ0lNRDZhUGE3eEhBc05NNGhSTGFLaWNi?=
 =?utf-8?B?Q0xYSnRWOHowREtqSytpd1puZGZ4MCs4THN5ZUdSSEtoZkZWUzRRRzNiTjdZ?=
 =?utf-8?B?b0ZsRnBjK08xcm45ZmFJUVkxbi92WE16UEdiLzVvMTBXVEJtRXFLdGViVFhr?=
 =?utf-8?B?ZlM5MWJzQ1FRRVJMV2VmOVByRHlKMDMyVVo2WTNDYUw0Nnc2TTg4bkdRYlBq?=
 =?utf-8?B?enRyeXBlTXVVckhJUVhoY0M0SjlUN1l3aHZUUVhtVjRCcXdjZS9CTE5OYTRu?=
 =?utf-8?B?Q0Z5dHFvYlJGb1F2L3JIMEx0V3ZIVnI5azRBa21kejFraEpHVmltRkVoZGwy?=
 =?utf-8?B?cVRHbE80NU9BN1hGaGp3QjdxcklBNWVuTW51c09FcHpnTWNzbGJHTnVrZy9Q?=
 =?utf-8?B?czQ3ZkJhOEE4TDBmOEw5R2tQc1U1d2RhUVIyM2w0ZDVIdW4yMmJtcWlEKzBZ?=
 =?utf-8?B?MmlTclMyTWx6TkEwYnRleUxpQ3Z4QlhURnE5eEFEMnBTNWRlMWJVMWRJSnp4?=
 =?utf-8?B?NFBiNFpURS9ha0trQWdSaWVUSDgzU01PelJOenlRNDBjbGhsUEhVcHVvbE8r?=
 =?utf-8?B?akY1UWp0WVlLcXQ2T1RrOUJ2b0daa1k3TkgwbjlRbXBGRVdnOEhudU8veWZR?=
 =?utf-8?B?SDR5M002T0R2RnBpamRXR1NJcWhib3B1a2QvWWRPeFRMeTMxNy9SZUhZd0ZV?=
 =?utf-8?B?eEFlMUpMbkFOUTF0a0JGTGZSUFo5aWo1NTNzRi9CZXVrVkRpZ2xTTlpUUlp2?=
 =?utf-8?B?MzUwdzJ0a2ptSDNqZmw0Z1BUUlhHNFVERlhzRmIraHc1OW0zYmQ0TmZzSzd0?=
 =?utf-8?B?bS9lRDNLazg0RFpreW1kakFxd1pOelhFdzBOdXF5NWJybzI3b2xGamZZUkt5?=
 =?utf-8?B?RDFMeDJRdEhiNE1LZmYzaW5Bb09QK2ZqclBaVEkrM0NpampmdDR6VGtqYmlO?=
 =?utf-8?B?QWloNGRlcmduQ2RlUnVVcVVkVExWajdOS09BbVlHNGd2QW00SGZreU9mYmdB?=
 =?utf-8?B?RUk5RGdrSGpxOTZxUTlzdW16NGVHRFc0RFlNVDVjd1ZQcUlpMzVLQzhHSUJS?=
 =?utf-8?B?MVVaUUw1QTZqd3gyRm90U1AvRmg1WEZNSjBIaVNlK3o2NlNkZ0FJWnlYRVNW?=
 =?utf-8?B?SHhVeHRQN1NEaFp4SFhUZFRnRnpUcTR4aTR1R3d0RDl5eFB4ekd4RTJraTlp?=
 =?utf-8?B?ankzZEpnRlpVQndNeUt3M05TSXo1RWNKRWdYa3BNSHRaT0NlT0Q5bWlUQyth?=
 =?utf-8?B?RURPZGJKakhTNk9lRWQxUUN1cFFPQlY3czFxSlFpVEFCR3Y0YlJ2cmRqekhp?=
 =?utf-8?B?SzNsREtFY0VVM0kzRzF6UXllVHBVVnhPNGcwUE5BMFFkTGxrcDVWUEMrSW1r?=
 =?utf-8?B?SS8rK2ZrY2RPVHNXZGlrN3IrVTArWFc0ZmlycncyNlJ3cEZLejcwZmhvNXl2?=
 =?utf-8?B?TEYxaG5rZmlQcE9rZkxBeU93blk0UWd3eVJrazN4RlRUeUpqN1NKaWVMVkR3?=
 =?utf-8?B?SjJlR3l6cHhWczlTaSszQlphMmpla2w5THFUcnE0cURsTjdOcUdWMlQ4MHQ0?=
 =?utf-8?B?U1F1eFFwTjZKbnVGNjVSa044MHZUZ2hzaldrZml0NDZiRVplZDBPelZCM0Mv?=
 =?utf-8?B?Q2pockNjclBBMDZqOWNablRMSkM5eDBJOEdxcFREOWsvbmh2US9ZazZEMkVV?=
 =?utf-8?Q?YEwIenwdghk9TOUPqhs49+Eev?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd350c20-0927-4b2a-cf68-08dab0751a35
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 19:23:42.5148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WaK0rH5ckf7SEH13Hb1aBBbOtOksdJqRH4q4ZfpkjQVqlCmESlaBF7q9aUX+e06M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5237
X-Proofpoint-GUID: J2MEVLJ7uvwnJIe-fsOXNlX6LePX88sI
X-Proofpoint-ORIG-GUID: J2MEVLJ7uvwnJIe-fsOXNlX6LePX88sI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/17/22 11:01 AM, sdf@google.com wrote:
> On 10/13, Yonghong Song wrote:
>> Similar to sk/inode/task storage, implement similar cgroup local storage.
> 
>> There already exists a local storage implementation for cgroup-attached
>> bpf programs.  See map type BPF_MAP_TYPE_CGROUP_STORAGE and helper
>> bpf_get_local_storage(). But there are use cases such that non-cgroup
>> attached bpf progs wants to access cgroup local storage data. For 
>> example,
>> tc egress prog has access to sk and cgroup. It is possible to use
>> sk local storage to emulate cgroup local storage by storing data in 
>> socket.
>> But this is a waste as it could be lots of sockets belonging to a 
>> particular
>> cgroup. Alternatively, a separate map can be created with cgroup id as 
>> the key.
>> But this will introduce additional overhead to manipulate the new map.
>> A cgroup local storage, similar to existing sk/inode/task storage,
>> should help for this use case.
> 
>> The life-cycle of storage is managed with the life-cycle of the
>> cgroup struct.  i.e. the storage is destroyed along with the owning 
>> cgroup
>> with a callback to the bpf_cgroup_storage_free when cgroup itself
>> is deleted.
> 
>> The userspace map operations can be done by using a cgroup fd as a key
>> passed to the lookup, update and delete operations.
> 
> 
> [..]
> 
>> Since map name BPF_MAP_TYPE_CGROUP_STORAGE has been used for old 
>> cgroup local
>> storage support, the new map name BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE is 
>> used
>> for cgroup storage available to non-cgroup-attached bpf programs. The two
>> helpers are named as bpf_cgroup_local_storage_get() and
>> bpf_cgroup_local_storage_delete().
> 
> Have you considered doing something similar to 7d9c3427894f ("bpf: Make
> cgroup storages shared between programs on the same cgroup") where
> the map changes its behavior depending on the key size (see key_size checks
> in cgroup_storage_map_alloc)? Looks like sizeof(int) for fd still
> can be used so we can, in theory, reuse the name..
> 
> Pros:
> - no need for a new map name
> 
> Cons:
> - existing BPF_MAP_TYPE_CGROUP_STORAGE is already messy; might be not a
>    good idea to add more stuff to it?

Thinking differently. I think I would have reuse the same map name
(BPF_MAP_TYPE_CGROUP_STORAGE) but with a flag like 
BPF_F_LOCAL_STORAGE_GENERIC).

We could use map_extra as well, but I think an explicit flag might be 
better.

> 
> But, for the very least, should we also extend
> Documentation/bpf/map_cgroup_storage.rst to cover the new map? We've
> tried to keep some of the important details in there..
> 
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   include/linux/bpf.h             |   3 +
>>   include/linux/bpf_types.h       |   1 +
>>   include/linux/cgroup-defs.h     |   4 +
>>   include/uapi/linux/bpf.h        |  39 +++++
>>   kernel/bpf/Makefile             |   2 +-
>>   kernel/bpf/bpf_cgroup_storage.c | 280 ++++++++++++++++++++++++++++++++
>>   kernel/bpf/helpers.c            |   6 +
>>   kernel/bpf/syscall.c            |   3 +-
>>   kernel/bpf/verifier.c           |  14 +-
>>   kernel/cgroup/cgroup.c          |   4 +
>>   kernel/trace/bpf_trace.c        |   4 +
>>   scripts/bpf_doc.py              |   2 +
>>   tools/include/uapi/linux/bpf.h  |  39 +++++
>>   13 files changed, 398 insertions(+), 3 deletions(-)
>>   create mode 100644 kernel/bpf/bpf_cgroup_storage.c
> 
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 9e7d46d16032..1395a01c7f18 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -2045,6 +2045,7 @@ struct bpf_link *bpf_link_by_id(u32 id);
> 
>>   const struct bpf_func_proto *bpf_base_func_proto(enum bpf_func_id 
>> func_id);
>>   void bpf_task_storage_free(struct task_struct *task);
>> +void bpf_local_cgroup_storage_free(struct cgroup *cgroup);
>>   bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog);
>>   const struct btf_func_model *
>>   bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
>> @@ -2537,6 +2538,8 @@ extern const struct bpf_func_proto 
>> bpf_copy_from_user_task_proto;
>>   extern const struct bpf_func_proto bpf_set_retval_proto;
>>   extern const struct bpf_func_proto bpf_get_retval_proto;
>>   extern const struct bpf_func_proto bpf_user_ringbuf_drain_proto;
>> +extern const struct bpf_func_proto bpf_cgroup_storage_get_proto;
>> +extern const struct bpf_func_proto bpf_cgroup_storage_delete_proto;
> 
>>   const struct bpf_func_proto *tracing_prog_func_proto(
>>     enum bpf_func_id func_id, const struct bpf_prog *prog);
>> diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
>> index 2c6a4f2562a7..7a0362d7a0aa 100644
>> --- a/include/linux/bpf_types.h
>> +++ b/include/linux/bpf_types.h
>> @@ -90,6 +90,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_ARRAY, 
>> cgroup_array_map_ops)
>>   #ifdef CONFIG_CGROUP_BPF
>>   BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_STORAGE, cgroup_storage_map_ops)
>>   BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE, 
>> cgroup_storage_map_ops)
>> +BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE, 
>> cgroup_local_storage_map_ops)
>>   #endif
>>   BPF_MAP_TYPE(BPF_MAP_TYPE_HASH, htab_map_ops)
>>   BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_HASH, htab_percpu_map_ops)
>> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
>> index 4bcf56b3491c..c6f4590dda68 100644
>> --- a/include/linux/cgroup-defs.h
>> +++ b/include/linux/cgroup-defs.h
>> @@ -504,6 +504,10 @@ struct cgroup {
>>       /* Used to store internal freezer state */
>>       struct cgroup_freezer_state freezer;
> 
>> +#ifdef CONFIG_BPF_SYSCALL
>> +    struct bpf_local_storage __rcu  *bpf_cgroup_storage;
>> +#endif
>> +
>>       /* ids of the ancestors at each level including self */
>>       u64 ancestor_ids[];
>>   };
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 17f61338f8f8..d918b4054297 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -935,6 +935,7 @@ enum bpf_map_type {
>>       BPF_MAP_TYPE_TASK_STORAGE,
>>       BPF_MAP_TYPE_BLOOM_FILTER,
>>       BPF_MAP_TYPE_USER_RINGBUF,
>> +    BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE,
>>   };
> 
>>   /* Note that tracing related programs such as
>> @@ -5435,6 +5436,42 @@ union bpf_attr {
>>    *        **-E2BIG** if user-space has tried to publish a sample 
>> which is
>>    *        larger than the size of the ring buffer, or which cannot fit
>>    *        within a struct bpf_dynptr.
>> + *
>> + * void *bpf_cgroup_local_storage_get(struct bpf_map *map, struct 
>> cgroup *cgroup, void *value, u64 flags)
>> + *    Description
>> + *        Get a bpf_local_storage from the *cgroup*.
>> + *
>> + *        Logically, it could be thought of as getting the value from
>> + *        a *map* with *cgroup* as the **key**.  From this
>> + *        perspective,  the usage is not much different from
>> + *        **bpf_map_lookup_elem**\ (*map*, **&**\ *cgroup*) except this
>> + *        helper enforces the key must be a cgroup struct and the map 
>> must also
>> + *        be a **BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE**.
>> + *
>> + *        Underneath, the value is stored locally at *cgroup* instead of
>> + *        the *map*.  The *map* is used as the bpf-local-storage
>> + *        "type". The bpf-local-storage "type" (i.e. the *map*) is
>> + *        searched against all bpf_local_storage residing at *cgroup*.
>> + *
>> + *        An optional *flags* (**BPF_LOCAL_STORAGE_GET_F_CREATE**) 
>> can be
>> + *        used such that a new bpf_local_storage will be
>> + *        created if one does not exist.  *value* can be used
>> + *        together with **BPF_LOCAL_STORAGE_GET_F_CREATE** to specify
>> + *        the initial value of a bpf_local_storage.  If *value* is
>> + *        **NULL**, the new bpf_local_storage will be zero initialized.
>> + *    Return
>> + *        A bpf_local_storage pointer is returned on success.
>> + *
>> + *        **NULL** if not found or there was an error in adding
>> + *        a new bpf_local_storage.
>> + *
>> + * long bpf_cgroup_local_storage_delete(struct bpf_map *map, struct 
>> cgroup *cgroup)
>> + *    Description
>> + *        Delete a bpf_local_storage from a *cgroup*.
>> + *    Return
>> + *        0 on success.
>> + *
>> + *        **-ENOENT** if the bpf_local_storage cannot be found.
>>    */
>>   #define ___BPF_FUNC_MAPPER(FN, ctx...)            \
>>       FN(unspec, 0, ##ctx)                \
>> @@ -5647,6 +5684,8 @@ union bpf_attr {
>>       FN(tcp_raw_check_syncookie_ipv6, 207, ##ctx)    \
>>       FN(ktime_get_tai_ns, 208, ##ctx)        \
>>       FN(user_ringbuf_drain, 209, ##ctx)        \
>> +    FN(cgroup_local_storage_get, 210, ##ctx)    \
>> +    FN(cgroup_local_storage_delete, 211, ##ctx)    \
>>       /* */
> 
>>   /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER 
>> that don't
>> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
>> index 341c94f208f4..b02693f51978 100644
>> --- a/kernel/bpf/Makefile
>> +++ b/kernel/bpf/Makefile
>> @@ -25,7 +25,7 @@ ifeq ($(CONFIG_PERF_EVENTS),y)
>>   obj-$(CONFIG_BPF_SYSCALL) += stackmap.o
>>   endif
>>   ifeq ($(CONFIG_CGROUPS),y)
>> -obj-$(CONFIG_BPF_SYSCALL) += cgroup_iter.o
>> +obj-$(CONFIG_BPF_SYSCALL) += cgroup_iter.o bpf_cgroup_storage.o
>>   endif
>>   obj-$(CONFIG_CGROUP_BPF) += cgroup.o
>>   ifeq ($(CONFIG_INET),y)
>> diff --git a/kernel/bpf/bpf_cgroup_storage.c 
>> b/kernel/bpf/bpf_cgroup_storage.c
>> new file mode 100644
>> index 000000000000..9974784822da
>> --- /dev/null
>> +++ b/kernel/bpf/bpf_cgroup_storage.c
>> @@ -0,0 +1,280 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
>> + */
>> +
>> +#include <linux/types.h>
>> +#include <linux/bpf.h>
>> +#include <linux/bpf_local_storage.h>
>> +#include <uapi/linux/btf.h>
>> +#include <linux/btf_ids.h>
>> +
>> +DEFINE_BPF_STORAGE_CACHE(cgroup_cache);
>> +
>> +static DEFINE_PER_CPU(int, bpf_cgroup_storage_busy);
>> +
>> +static void bpf_cgroup_storage_lock(void)
>> +{
>> +    migrate_disable();
>> +    this_cpu_inc(bpf_cgroup_storage_busy);
>> +}
>> +
>> +static void bpf_cgroup_storage_unlock(void)
>> +{
>> +    this_cpu_dec(bpf_cgroup_storage_busy);
>> +    migrate_enable();
>> +}
>> +
>> +static bool bpf_cgroup_storage_trylock(void)
>> +{
>> +    migrate_disable();
>> +    if (unlikely(this_cpu_inc_return(bpf_cgroup_storage_busy) != 1)) {
>> +        this_cpu_dec(bpf_cgroup_storage_busy);
>> +        migrate_enable();
>> +        return false;
>> +    }
>> +    return true;
>> +}
> 
> Task storage has lock/unlock/trylock; inode storage doesn't; why does
> cgroup need it as well?
> 
>> +static struct bpf_local_storage __rcu **cgroup_storage_ptr(void *owner)
>> +{
>> +    struct cgroup *cg = owner;
>> +
>> +    return &cg->bpf_cgroup_storage;
>> +}
>> +
>> +void bpf_local_cgroup_storage_free(struct cgroup *cgroup)
>> +{
>> +    struct bpf_local_storage *local_storage;
>> +    struct bpf_local_storage_elem *selem;
>> +    bool free_cgroup_storage = false;
>> +    struct hlist_node *n;
>> +    unsigned long flags;
>> +
>> +    rcu_read_lock();
>> +    local_storage = rcu_dereference(cgroup->bpf_cgroup_storage);
>> +    if (!local_storage) {
>> +        rcu_read_unlock();
>> +        return;
>> +    }
>> +
>> +    /* Neither the bpf_prog nor the bpf-map's syscall
>> +     * could be modifying the local_storage->list now.
>> +     * Thus, no elem can be added-to or deleted-from the
>> +     * local_storage->list by the bpf_prog or by the bpf-map's syscall.
>> +     *
>> +     * It is racing with bpf_local_storage_map_free() alone
>> +     * when unlinking elem from the local_storage->list and
>> +     * the map's bucket->list.
>> +     */
>> +    bpf_cgroup_storage_lock();
>> +    raw_spin_lock_irqsave(&local_storage->lock, flags);
>> +    hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
>> +        bpf_selem_unlink_map(selem);
>> +        free_cgroup_storage =
>> +            bpf_selem_unlink_storage_nolock(local_storage, selem, 
>> false, false);
>> +    }
>> +    raw_spin_unlock_irqrestore(&local_storage->lock, flags);
>> +    bpf_cgroup_storage_unlock();
>> +    rcu_read_unlock();
>> +
>> +    /* free_cgroup_storage should always be true as long as
>> +     * local_storage->list was non-empty.
>> +     */
>> +    if (free_cgroup_storage)
>> +        kfree_rcu(local_storage, rcu);
>> +}
> 
>> +static struct bpf_local_storage_data *
>> +cgroup_storage_lookup(struct cgroup *cgroup, struct bpf_map *map, 
>> bool cacheit_lockit)
>> +{
>> +    struct bpf_local_storage *cgroup_storage;
>> +    struct bpf_local_storage_map *smap;
>> +
>> +    cgroup_storage = rcu_dereference_check(cgroup->bpf_cgroup_storage,
>> +                           bpf_rcu_lock_held());
>> +    if (!cgroup_storage)
>> +        return NULL;
>> +
>> +    smap = (struct bpf_local_storage_map *)map;
>> +    return bpf_local_storage_lookup(cgroup_storage, smap, 
>> cacheit_lockit);
>> +}
>> +
>> +static void *bpf_cgroup_storage_lookup_elem(struct bpf_map *map, void 
>> *key)
>> +{
>> +    struct bpf_local_storage_data *sdata;
>> +    struct cgroup *cgroup;
>> +    int fd;
>> +
>> +    fd = *(int *)key;
>> +    cgroup = cgroup_get_from_fd(fd);
>> +    if (IS_ERR(cgroup))
>> +        return ERR_CAST(cgroup);
>> +
>> +    bpf_cgroup_storage_lock();
>> +    sdata = cgroup_storage_lookup(cgroup, map, true);
>> +    bpf_cgroup_storage_unlock();
>> +    cgroup_put(cgroup);
>> +    return sdata ? sdata->data : NULL;
>> +}
> 
> A lot of the above (free/lookup) seems to be copy-pasted from the task 
> storage;
> any point in trying to generalize the common parts?
> 
>> +static int bpf_cgroup_storage_update_elem(struct bpf_map *map, void 
>> *key,
>> +                      void *value, u64 map_flags)
>> +{
>> +    struct bpf_local_storage_data *sdata;
>> +    struct cgroup *cgroup;
>> +    int err, fd;
>> +
>> +    fd = *(int *)key;
>> +    cgroup = cgroup_get_from_fd(fd);
>> +    if (IS_ERR(cgroup))
>> +        return PTR_ERR(cgroup);
>> +
>> +    bpf_cgroup_storage_lock();
>> +    sdata = bpf_local_storage_update(cgroup, (struct 
>> bpf_local_storage_map *)map,
>> +                     value, map_flags, GFP_ATOMIC);
>> +    bpf_cgroup_storage_unlock();
>> +    err = PTR_ERR_OR_ZERO(sdata);
>> +    cgroup_put(cgroup);
>> +    return err;
>> +}
>> +
>> +static int cgroup_storage_delete(struct cgroup *cgroup, struct 
>> bpf_map *map)
>> +{
>> +    struct bpf_local_storage_data *sdata;
>> +
>> +    sdata = cgroup_storage_lookup(cgroup, map, false);
>> +    if (!sdata)
>> +        return -ENOENT;
>> +
>> +    bpf_selem_unlink(SELEM(sdata), true);
>> +    return 0;
>> +}
>> +
>> +static int bpf_cgroup_storage_delete_elem(struct bpf_map *map, void 
>> *key)
>> +{
>> +    struct cgroup *cgroup;
>> +    int err, fd;
>> +
>> +    fd = *(int *)key;
>> +    cgroup = cgroup_get_from_fd(fd);
>> +    if (IS_ERR(cgroup))
>> +        return PTR_ERR(cgroup);
>> +
>> +    bpf_cgroup_storage_lock();
>> +    err = cgroup_storage_delete(cgroup, map);
>> +    bpf_cgroup_storage_unlock();
>> +    if (err)
>> +        return err;
>> +
>> +    cgroup_put(cgroup);
>> +    return 0;
>> +}
>> +
>> +static int notsupp_get_next_key(struct bpf_map *map, void *key, void 
>> *next_key)
>> +{
>> +    return -ENOTSUPP;
>> +}
>> +
>> +static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
>> +{
>> +    struct bpf_local_storage_map *smap;
>> +
>> +    smap = bpf_local_storage_map_alloc(attr);
>> +    if (IS_ERR(smap))
>> +        return ERR_CAST(smap);
>> +
>> +    smap->cache_idx = bpf_local_storage_cache_idx_get(&cgroup_cache);
>> +    return &smap->map;
>> +}
>> +
>> +static void cgroup_storage_map_free(struct bpf_map *map)
>> +{
>> +    struct bpf_local_storage_map *smap;
>> +
>> +    smap = (struct bpf_local_storage_map *)map;
>> +    bpf_local_storage_cache_idx_free(&cgroup_cache, smap->cache_idx);
>> +    bpf_local_storage_map_free(smap, NULL);
>> +}
>> +
>> +/* *gfp_flags* is a hidden argument provided by the verifier */
>> +BPF_CALL_5(bpf_cgroup_storage_get, struct bpf_map *, map, struct 
>> cgroup *, cgroup,
>> +       void *, value, u64, flags, gfp_t, gfp_flags)
>> +{
>> +    struct bpf_local_storage_data *sdata;
>> +
>> +    WARN_ON_ONCE(!bpf_rcu_lock_held());
>> +    if (flags & ~(BPF_LOCAL_STORAGE_GET_F_CREATE))
>> +        return (unsigned long)NULL;
>> +
>> +    if (!cgroup)
>> +        return (unsigned long)NULL;
>> +
>> +    if (!bpf_cgroup_storage_trylock())
>> +        return (unsigned long)NULL;
>> +
>> +    sdata = cgroup_storage_lookup(cgroup, map, true);
>> +    if (sdata)
>> +        goto unlock;
>> +
>> +    /* only allocate new storage, when the cgroup is refcounted */
>> +    if (!percpu_ref_is_dying(&cgroup->self.refcnt) &&
>> +        (flags & BPF_LOCAL_STORAGE_GET_F_CREATE))
>> +        sdata = bpf_local_storage_update(cgroup, (struct 
>> bpf_local_storage_map *)map,
>> +                         value, BPF_NOEXIST, gfp_flags);
>> +
>> +unlock:
>> +    bpf_cgroup_storage_unlock();
>> +    return IS_ERR_OR_NULL(sdata) ? (unsigned long)NULL : (unsigned 
>> long)sdata->data;
>> +}
>> +
>> +BPF_CALL_2(bpf_cgroup_storage_delete, struct bpf_map *, map, struct 
>> cgroup *, cgroup)
>> +{
>> +    int ret;
>> +
>> +    WARN_ON_ONCE(!bpf_rcu_lock_held());
>> +    if (!cgroup)
>> +        return -EINVAL;
>> +
>> +    if (!bpf_cgroup_storage_trylock())
>> +        return -EBUSY;
>> +
>> +    ret = cgroup_storage_delete(cgroup, map);
>> +    bpf_cgroup_storage_unlock();
>> +    return ret;
>> +}
>> +
>> +BTF_ID_LIST_SINGLE(cgroup_storage_map_btf_ids, struct, 
>> bpf_local_storage_map)
>> +const struct bpf_map_ops cgroup_local_storage_map_ops = {
>> +    .map_meta_equal = bpf_map_meta_equal,
>> +    .map_alloc_check = bpf_local_storage_map_alloc_check,
>> +    .map_alloc = cgroup_storage_map_alloc,
>> +    .map_free = cgroup_storage_map_free,
>> +    .map_get_next_key = notsupp_get_next_key,
>> +    .map_lookup_elem = bpf_cgroup_storage_lookup_elem,
>> +    .map_update_elem = bpf_cgroup_storage_update_elem,
>> +    .map_delete_elem = bpf_cgroup_storage_delete_elem,
>> +    .map_check_btf = bpf_local_storage_map_check_btf,
>> +    .map_btf_id = &cgroup_storage_map_btf_ids[0],
>> +    .map_owner_storage_ptr = cgroup_storage_ptr,
>> +};
>> +
>> +const struct bpf_func_proto bpf_cgroup_storage_get_proto = {
>> +    .func        = bpf_cgroup_storage_get,
>> +    .gpl_only    = false,
>> +    .ret_type    = RET_PTR_TO_MAP_VALUE_OR_NULL,
>> +    .arg1_type    = ARG_CONST_MAP_PTR,
>> +    .arg2_type    = ARG_PTR_TO_BTF_ID,
>> +    .arg2_btf_id    = &bpf_cgroup_btf_id[0],
>> +    .arg3_type    = ARG_PTR_TO_MAP_VALUE_OR_NULL,
>> +    .arg4_type    = ARG_ANYTHING,
>> +};
>> +
>> +const struct bpf_func_proto bpf_cgroup_storage_delete_proto = {
>> +    .func        = bpf_cgroup_storage_delete,
>> +    .gpl_only    = false,
>> +    .ret_type    = RET_INTEGER,
>> +    .arg1_type    = ARG_CONST_MAP_PTR,
>> +    .arg2_type    = ARG_PTR_TO_BTF_ID,
>> +    .arg2_btf_id    = &bpf_cgroup_btf_id[0],
>> +};
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index a6b04faed282..5c5bb08832ec 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -1663,6 +1663,12 @@ bpf_base_func_proto(enum bpf_func_id func_id)
>>           return &bpf_dynptr_write_proto;
>>       case BPF_FUNC_dynptr_data:
>>           return &bpf_dynptr_data_proto;
>> +#ifdef CONFIG_CGROUPS
>> +    case BPF_FUNC_cgroup_local_storage_get:
>> +        return &bpf_cgroup_storage_get_proto;
>> +    case BPF_FUNC_cgroup_local_storage_delete:
>> +        return &bpf_cgroup_storage_delete_proto;
>> +#endif
>>       default:
>>           break;
>>       }
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 7b373a5e861f..e53c7fae6e22 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -1016,7 +1016,8 @@ static int map_check_btf(struct bpf_map *map, 
>> const struct btf *btf,
>>               map->map_type != BPF_MAP_TYPE_CGROUP_STORAGE &&
>>               map->map_type != BPF_MAP_TYPE_SK_STORAGE &&
>>               map->map_type != BPF_MAP_TYPE_INODE_STORAGE &&
>> -            map->map_type != BPF_MAP_TYPE_TASK_STORAGE)
>> +            map->map_type != BPF_MAP_TYPE_TASK_STORAGE &&
>> +            map->map_type != BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE)
>>               return -ENOTSUPP;
>>           if (map->spin_lock_off + sizeof(struct bpf_spin_lock) >
>>               map->value_size) {
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 6f6d2d511c06..f36f6a3c0d50 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -6360,6 +6360,11 @@ static int check_map_func_compatibility(struct 
>> bpf_verifier_env *env,
>>               func_id != BPF_FUNC_task_storage_delete)
>>               goto error;
>>           break;
>> +    case BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE:
>> +        if (func_id != BPF_FUNC_cgroup_local_storage_get &&
>> +            func_id != BPF_FUNC_cgroup_local_storage_delete)
>> +            goto error;
>> +        break;
>>       case BPF_MAP_TYPE_BLOOM_FILTER:
>>           if (func_id != BPF_FUNC_map_peek_elem &&
>>               func_id != BPF_FUNC_map_push_elem)
>> @@ -6472,6 +6477,11 @@ static int check_map_func_compatibility(struct 
>> bpf_verifier_env *env,
>>           if (map->map_type != BPF_MAP_TYPE_TASK_STORAGE)
>>               goto error;
>>           break;
>> +    case BPF_FUNC_cgroup_local_storage_get:
>> +    case BPF_FUNC_cgroup_local_storage_delete:
>> +        if (map->map_type != BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE)
>> +            goto error;
>> +        break;
>>       default:
>>           break;
>>       }
>> @@ -12713,6 +12723,7 @@ static int check_map_prog_compatibility(struct 
>> bpf_verifier_env *env,
>>           case BPF_MAP_TYPE_INODE_STORAGE:
>>           case BPF_MAP_TYPE_SK_STORAGE:
>>           case BPF_MAP_TYPE_TASK_STORAGE:
>> +        case BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE:
>>               break;
>>           default:
>>               verbose(env,
>> @@ -14149,7 +14160,8 @@ static int do_misc_fixups(struct 
>> bpf_verifier_env *env)
> 
>>           if (insn->imm == BPF_FUNC_task_storage_get ||
>>               insn->imm == BPF_FUNC_sk_storage_get ||
>> -            insn->imm == BPF_FUNC_inode_storage_get) {
>> +            insn->imm == BPF_FUNC_inode_storage_get ||
>> +            insn->imm == BPF_FUNC_cgroup_local_storage_get) {
>>               if (env->prog->aux->sleepable)
>>                   insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, (__force 
>> __s32)GFP_KERNEL);
>>               else
>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>> index 8ad2c267ff47..2fa2c950c7fb 100644
>> --- a/kernel/cgroup/cgroup.c
>> +++ b/kernel/cgroup/cgroup.c
>> @@ -985,6 +985,10 @@ void put_css_set_locked(struct css_set *cset)
>>           put_css_set_locked(cset->dom_cset);
>>       }
> 
>> +#ifdef CONFIG_BPF_SYSCALL
>> +    bpf_local_cgroup_storage_free(cset->dfl_cgrp);
>> +#endif
>> +
>>       kfree_rcu(cset, rcu_head);
>>   }
> 
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index 688552df95ca..179adaae4a9f 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -1454,6 +1454,10 @@ bpf_tracing_func_proto(enum bpf_func_id 
>> func_id, const struct bpf_prog *prog)
>>           return &bpf_get_current_cgroup_id_proto;
>>       case BPF_FUNC_get_current_ancestor_cgroup_id:
>>           return &bpf_get_current_ancestor_cgroup_id_proto;
>> +    case BPF_FUNC_cgroup_local_storage_get:
>> +        return &bpf_cgroup_storage_get_proto;
>> +    case BPF_FUNC_cgroup_local_storage_delete:
>> +        return &bpf_cgroup_storage_delete_proto;
>>   #endif
>>       case BPF_FUNC_send_signal:
>>           return &bpf_send_signal_proto;
>> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
>> index c0e6690be82a..fdb0aff8cb5a 100755
>> --- a/scripts/bpf_doc.py
>> +++ b/scripts/bpf_doc.py
>> @@ -685,6 +685,7 @@ class PrinterHelpers(Printer):
>>               'struct udp6_sock',
>>               'struct unix_sock',
>>               'struct task_struct',
>> +            'struct cgroup',
> 
>>               'struct __sk_buff',
>>               'struct sk_msg_md',
>> @@ -742,6 +743,7 @@ class PrinterHelpers(Printer):
>>               'struct udp6_sock',
>>               'struct unix_sock',
>>               'struct task_struct',
>> +            'struct cgroup',
>>               'struct path',
>>               'struct btf_ptr',
>>               'struct inode',
>> diff --git a/tools/include/uapi/linux/bpf.h 
>> b/tools/include/uapi/linux/bpf.h
>> index 17f61338f8f8..d918b4054297 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -935,6 +935,7 @@ enum bpf_map_type {
>>       BPF_MAP_TYPE_TASK_STORAGE,
>>       BPF_MAP_TYPE_BLOOM_FILTER,
>>       BPF_MAP_TYPE_USER_RINGBUF,
>> +    BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE,
>>   };
> 
>>   /* Note that tracing related programs such as
>> @@ -5435,6 +5436,42 @@ union bpf_attr {
>>    *        **-E2BIG** if user-space has tried to publish a sample 
>> which is
>>    *        larger than the size of the ring buffer, or which cannot fit
>>    *        within a struct bpf_dynptr.
>> + *
>> + * void *bpf_cgroup_local_storage_get(struct bpf_map *map, struct 
>> cgroup *cgroup, void *value, u64 flags)
>> + *    Description
>> + *        Get a bpf_local_storage from the *cgroup*.
>> + *
>> + *        Logically, it could be thought of as getting the value from
>> + *        a *map* with *cgroup* as the **key**.  From this
>> + *        perspective,  the usage is not much different from
>> + *        **bpf_map_lookup_elem**\ (*map*, **&**\ *cgroup*) except this
>> + *        helper enforces the key must be a cgroup struct and the map 
>> must also
>> + *        be a **BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE**.
>> + *
>> + *        Underneath, the value is stored locally at *cgroup* instead of
>> + *        the *map*.  The *map* is used as the bpf-local-storage
>> + *        "type". The bpf-local-storage "type" (i.e. the *map*) is
>> + *        searched against all bpf_local_storage residing at *cgroup*.
>> + *
>> + *        An optional *flags* (**BPF_LOCAL_STORAGE_GET_F_CREATE**) 
>> can be
>> + *        used such that a new bpf_local_storage will be
>> + *        created if one does not exist.  *value* can be used
>> + *        together with **BPF_LOCAL_STORAGE_GET_F_CREATE** to specify
>> + *        the initial value of a bpf_local_storage.  If *value* is
>> + *        **NULL**, the new bpf_local_storage will be zero initialized.
>> + *    Return
>> + *        A bpf_local_storage pointer is returned on success.
>> + *
>> + *        **NULL** if not found or there was an error in adding
>> + *        a new bpf_local_storage.
>> + *
>> + * long bpf_cgroup_local_storage_delete(struct bpf_map *map, struct 
>> cgroup *cgroup)
>> + *    Description
>> + *        Delete a bpf_local_storage from a *cgroup*.
>> + *    Return
>> + *        0 on success.
>> + *
>> + *        **-ENOENT** if the bpf_local_storage cannot be found.
>>    */
>>   #define ___BPF_FUNC_MAPPER(FN, ctx...)            \
>>       FN(unspec, 0, ##ctx)                \
>> @@ -5647,6 +5684,8 @@ union bpf_attr {
>>       FN(tcp_raw_check_syncookie_ipv6, 207, ##ctx)    \
>>       FN(ktime_get_tai_ns, 208, ##ctx)        \
>>       FN(user_ringbuf_drain, 209, ##ctx)        \
>> +    FN(cgroup_local_storage_get, 210, ##ctx)    \
>> +    FN(cgroup_local_storage_delete, 211, ##ctx)    \
>>       /* */
> 
>>   /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER 
>> that don't
>> -- 
>> 2.30.2
> 
