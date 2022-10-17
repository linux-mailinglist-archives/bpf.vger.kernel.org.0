Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE54A601935
	for <lists+bpf@lfdr.de>; Mon, 17 Oct 2022 22:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbiJQUR3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 16:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbiJQURH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 16:17:07 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFC127906
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 13:16:33 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HJPWN0028173;
        Mon, 17 Oct 2022 13:15:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=7OkOxMnG7Vp5YDaWtlViY+45fu0Mq6qAnf2dA0XIwV4=;
 b=FIBn5tT8QP/GrKjJPFLyiyJNGHxVqct14aTUoAJEetfFrwJ2nkIXvP9H7uGivPzQNsLK
 LNJpjxGfFBE19YwUVEt8oLhNHshiR+hy3x13Tg0UwpTK0rMrVAgZbIkT3UvqVJgwCBze
 r9wBP/hvcnMyVPxzuqDj5IaKJPA6Bs9MwGi3JCz1H6xzEDu82ImuQbbfopxv4nFV95kI
 mbtVghX1E6KKPlWr8E1SBb41msDdOVja7SEB+PADbdm5YiYWFvDK0E1yNiKCkdolRlNp
 8H7xhA0A3H/hS5s/fG+SPbGmomZi7IevEPCTftCzg7BhqJTKkjZfgg32Xz/t5dYLnkqf kg== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k7r6mv33u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Oct 2022 13:15:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFZkvvwyWJky6Y5cSp+2Kbs297z/WeGYfdJ5RhTGcxKGFiAyCZvXi9BPJyXX2DFpLzQIfMe23fd+OaPjeExd0xkCttuZBE4FArmla1kPMhSMwmh8d84RDmcstL3uUd36JymX6w6WXzKbQNe3sAH+LJFhkzXTsb2+nrrXdThGDpWM1dhI/XkxV/rtWelrIRiO5FrpE7ku3gtLE3Qo0byh/EMPrXotHvUmnFyDZV4IR3uLI9sywyvVluFFvNSqwDCKaoL7XXq/bKx5mw49n7tiax9wQmp6RKwpUVRvU75FB7t10xeINuTyhVo3p71jHTOAOZxZpIRWD0yuFvv18JeYYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OkOxMnG7Vp5YDaWtlViY+45fu0Mq6qAnf2dA0XIwV4=;
 b=Lh4ykoZWbHrcHVUy92heYqQHn+3OPrLhk7g5xPM+s5hzS/JN/Z0D6HN/H2pYOzV5bCajkdj/DCiKhdpSL2e7/bgiCc4RxsDf7lECRtsheLPwrfgvufzHXv0mOJmHS3rcnlifQdeCTiRVt9MEFmRBZOCcWPPsVViR46o5MjnX396kO/Jc87Ev3wxCY5aK0Ojdjnw/8lRREbtHN5zuUlSU4b6AUhW0w2FW5YdM4eQF1z/jLrxxlmOtva8Y0SJNKrI27hqre751OyMx5R/qWDW4/ZD4qUv+TxRztzOb17tJJkDVx9hTwXNMDFrHWEX9alllFmsPDz4SB63Kx0iIWYH9YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW4PR15MB4603.namprd15.prod.outlook.com (2603:10b6:303:10c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 17 Oct
 2022 20:15:53 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::6e08:a405:4130:f36e]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::6e08:a405:4130:f36e%6]) with mapi id 15.20.5723.032; Mon, 17 Oct 2022
 20:15:53 +0000
Message-ID: <8f345eb7-f385-1ccd-1ea4-34bfbd2498f5@meta.com>
Date:   Mon, 17 Oct 2022 13:15:49 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [PATCH bpf-next 2/5] bpf: Implement cgroup storage available to
 non-cgroup-attached bpf progs
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>,
        Stanislav Fomichev <sdf@google.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
References: <20221014045619.3309899-1-yhs@fb.com>
 <20221014045630.3311951-1-yhs@fb.com> <Y02Yk8gUgVDuZR4Q@google.com>
 <CAJD7tkYSXNb=D1OX_iv7PD-eJaK_7-5tcNvDQrWprWbWwJ2=oQ@mail.gmail.com>
 <CAKH8qBvHJPj6U_dOxH1C4FHJvg9=FE8YZUV3_kc_HJNt1TDuJQ@mail.gmail.com>
 <CAJD7tkYHQ=7jVqU__v4eNxvP-RBAH-M6BmTO1+ogto=m-xb2gw@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAJD7tkYHQ=7jVqU__v4eNxvP-RBAH-M6BmTO1+ogto=m-xb2gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P223CA0006.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::11) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW4PR15MB4603:EE_
X-MS-Office365-Filtering-Correlation-Id: 2821f19c-a05d-4351-d735-08dab07c6483
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wT2BLFuBHK1yOITCgZL1kyZJp+LpJ13ZjGS2fVbOyd6/9OVnSwK5xwpjx6M0EAbINLCGtG0dMhiaTaYIbO8Ik9lRDb2Uine8f/NOq2HL/5uD01mbKs6plyBIbfcXIKELaWVWxfjEh0bMWwQhV7RItR7jOc9BXqN+YkuHAwcJKXcK+oPxeq0Ddzp7ADtoDxJeUaK4d4AZKXQOfaWsSOc/2uJXuLte4SkcayVE/VlG60cwsfchNwlAkMTMUEt/P4o+gS6y+ScReYh6CNgIjTuOEZHxd69mGh5OfLiar4H3aG6cPFI5blitDq880qk5xwZPIEa7CSqexxxJNfUBAVoQo61ADj4B8Rb1OEImcFCfFhWl3Cv5f5SIuvIxaL5kUl1BlKdI3CwctJgaRm7iS78gvuvE4cAPQ0LrFZWuGCJCFxO0vPPD29UiKm0ERSZ1EG8x8Kf7zZWKWwpE0zeSn0X27Puz2SaXY3T+YDrB+qqTSTZ7qTYB2SGYX6y72ZcDCYgRLjtAsBgdSySCHkGbh0dRjrmrSoUhx9HV9N8LlPO7prFPcVITP9uIXvAPYTDJ1OXhTBNYbjq+l/H56r/9CeA3+gTfoQYZpAOc3R+Eoa1/1W9HPiy9Xw1pKgZ2y7+0fOdGgkPWap3dojVoQQTPgHVC4KtJia2ojbsDYoYCmlGd5UAvEU370CmzjLuj+j11BahVioB7Cwf1h8lqjM6ICUP67WJmYuzOw67aNALmRMiRPQm82rl8SlQ5gkz/dFgewphfoxP/vIy6T0zLt0/oAkqqgC+nIChwPRUc+ZOqbl3iUss=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(451199015)(36756003)(31686004)(31696002)(38100700002)(186003)(83380400001)(2616005)(86362001)(6506007)(6512007)(53546011)(6486002)(478600001)(6666004)(2906002)(54906003)(110136005)(316002)(4326008)(66946007)(66476007)(66556008)(8676002)(5660300002)(41300700001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGc2dy9RVllNbDRUd2V2MkxOSHk5RjdOcFkxNFRFc3lOWUxPNmk4ZHBzVnlm?=
 =?utf-8?B?T1l6S09COTVXVnExYUl1N3FSMUpzUmpBaUhhMStRWlM2SmFDL0JHbzdQdzB1?=
 =?utf-8?B?a3ZTNDRDVWJwT2FxbjdsbmpxWWI4eGxCQ0pCOUZSQlhWQ1l0ekJpaDgrd3R3?=
 =?utf-8?B?Z1VndGtTTzVjRTFnaVZKMm5EeGtkY0hyWENWd2YwWGZIVUxsN1I1c3NrU2tP?=
 =?utf-8?B?YndjUi9XNmI2VzdZS3k5T1d5WlJuSEVRbnY0OTUzOHN5QWJEeHRvMDMxVlhY?=
 =?utf-8?B?STlRaGJTczd2bXkrYnpndXkxRCtlYUEzR0kwdUxtVldlMzJyenprK1Qxb1ZO?=
 =?utf-8?B?OWZuM2xaYVdUMVhOdmV3c1V1R2NOM3FJaU83RjUrZHNCVDhaWG9RUTJ3ZE9z?=
 =?utf-8?B?MG1uWmhvNnI2d3FEWUxqMnlnMGdTNFRSRzhWTUp3cXBuV0l6bk1WaTYwU3hN?=
 =?utf-8?B?VCtLa3R6TGhzdFBJWkU4MTA3cDdEZnZGNzhmSVhUblp3MktEQWM2eHBzME1U?=
 =?utf-8?B?T21kbXNPYm5ZWFV2dFdPaDViUVREcVYySWdqSlZBWjJ3eUZ0b0dLUUtPUEFQ?=
 =?utf-8?B?amU2bCtFY29KVU9RNE5ZYk9yZzZjRDFoa3JqQ2gzZTJMTmpKQUhBQTlIVjB4?=
 =?utf-8?B?eTY2Y0Y5a1k3R0ZDUGxNRFBjZGRtRVdXMytRdUhEYWlKY2RSR3g1NlIwR1Jt?=
 =?utf-8?B?Wlp6a2ZJdlZxdEJoYWJhSWFpMWxOUmtVM0txRmdsNHFWTWxzbVZFampFbFNU?=
 =?utf-8?B?Vlkxb1RmVGQwQXJlZkNlS3lYLzRTSjdWWFlXbzJhZHh3M3ZvOHF6WS9qdVYr?=
 =?utf-8?B?d2pOR2dsRE4zSFRFR0FCSTRqWnc0dkVja3NwTkk1QnNzaEpWdTJGNWR4N2NQ?=
 =?utf-8?B?bjNCWVdkaUk3UFlmbDMzTUp2ZTV3OU81QlZiVm96eFJKU1FBcDR0OUN3Vmts?=
 =?utf-8?B?dWR5NmhKdzVsRGx2OXVZTVRBYjJFTkVPWWo5cUVvSlFQSTdyTGxMMmYrUzlt?=
 =?utf-8?B?QlRMNkR2bVFhTFNuNG9aT1hJZ2NlbWJLV0ZNb282Nkw3KzJUNkRydkdHNjdM?=
 =?utf-8?B?dWJJa2VBUkxvczY5RUY2S2RjZzI4aml1RmpBVjJ5OFlNbjFtUGtibmNoYVV6?=
 =?utf-8?B?QkRndjFEMWxvYXA1R3FNNlZzMWlGZFFVZ0QyUUhFMmlaRE9GT3h2TXdGdDVy?=
 =?utf-8?B?bzJPVUxSWmJHb2w4bGZyckJ5MzBMbWx3SGYrUUVySWIrcnhsVW5xTmpxK2d6?=
 =?utf-8?B?WTZHOFlVTmlLL0dyRTFYNjdOdE9neUZ6U0JBamVVKzM2OGNuSEFPNFMwSXVj?=
 =?utf-8?B?dThwckVrL1V6b2h3R0ppb0YveE50ZWhoQmtZRDZkc3Uzdy9tOEg5dlZ4V3cw?=
 =?utf-8?B?NWdCR1d5c1ZzOFBOQmFxWE5lQTRWNTNJOFA3NFozRnY5ZlNWSGVYZ21heTJ3?=
 =?utf-8?B?QkNJK3ZjTHJwQUNLcWFYSHJNbTl2Mm9neUNXMjFUbXNlZENuOEdCOE9TUlVC?=
 =?utf-8?B?bVVpektNbDZ4NmlvSnNSQlE0RGRmejl2NkJrWi9MS211Vkg0cFF3L3lwVXF6?=
 =?utf-8?B?SXhOT1J3bVNQQ3VNQUZXOGhxb1dsVXQ2WGhWODZTVXZQN1VneWlKRHk3RTJl?=
 =?utf-8?B?U20vSk5iRStYZDdvbm1sblVIOGtGRUVTVjZOM2dxWldDeEdidWJIdmI0VEZB?=
 =?utf-8?B?S2RsZFY1VmhucHp6SmtWNXJjSmtId0lCUU43UEU5Ny80M1ZrRDV0SnpwWXZu?=
 =?utf-8?B?RTNYczNGVG9BdjQ2MWkvT0VkMUlnSzZtaDF6TFg0M3oyL0FEWmZGbjZVMjZU?=
 =?utf-8?B?eFFCYkRQVDNrZ3R1VDRsWXhscmgyM29NL28vaDJwU3IxdFl3bHNaM1pnZEpL?=
 =?utf-8?B?V3NScm5PaWYwc0lyUnUxcEFORHN4Vm9uRkVqclpTU3hVUnVHT28raXV6RGtW?=
 =?utf-8?B?S1J4RWVHMk9EcjJlNkVXOUtkc0VpZ28xbUEwMVAxZDhVbGl0cDZPbmJBQTQy?=
 =?utf-8?B?SUp5eVRKWkZHeWd4RWxPdWZjenJyK0NkZFBOdkgvTlRhZ0d0eitZQWliNGpH?=
 =?utf-8?B?eGNiMG5CUzliUVNKdHgrZDByT202a2hNVytTRjMvKzEzTUpNRnVsR05VajFL?=
 =?utf-8?B?MnIxaExXM1hGL2tkYkROZ1ZQUmdUMmgzQThzTzk2UnlaTUlHVnFnM3pIRFBx?=
 =?utf-8?B?RXc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2821f19c-a05d-4351-d735-08dab07c6483
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 20:15:53.5922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nrYrRy/cqEs8Q2R2rcrvSb/GSUlEhIoBOApS+yp1YFC05zmrkevJ3PHOlJ5vfX1M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4603
X-Proofpoint-ORIG-GUID: EdsJDWMZEp0ZWAAFoERIyMgkBw8t3xPp
X-Proofpoint-GUID: EdsJDWMZEp0ZWAAFoERIyMgkBw8t3xPp
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



On 10/17/22 11:47 AM, Yosry Ahmed wrote:
> On Mon, Oct 17, 2022 at 11:43 AM Stanislav Fomichev <sdf@google.com> wrote:
>>
>> On Mon, Oct 17, 2022 at 11:26 AM Yosry Ahmed <yosryahmed@google.com> wrote:
>>>
>>> On Mon, Oct 17, 2022 at 11:02 AM <sdf@google.com> wrote:
>>>>
>>>> On 10/13, Yonghong Song wrote:
>>>>> Similar to sk/inode/task storage, implement similar cgroup local storage.
>>>>
>>>>> There already exists a local storage implementation for cgroup-attached
>>>>> bpf programs.  See map type BPF_MAP_TYPE_CGROUP_STORAGE and helper
>>>>> bpf_get_local_storage(). But there are use cases such that non-cgroup
>>>>> attached bpf progs wants to access cgroup local storage data. For example,
>>>>> tc egress prog has access to sk and cgroup. It is possible to use
>>>>> sk local storage to emulate cgroup local storage by storing data in
>>>>> socket.
>>>>> But this is a waste as it could be lots of sockets belonging to a
>>>>> particular
>>>>> cgroup. Alternatively, a separate map can be created with cgroup id as
>>>>> the key.
>>>>> But this will introduce additional overhead to manipulate the new map.
>>>>> A cgroup local storage, similar to existing sk/inode/task storage,
>>>>> should help for this use case.
>>>>
>>>>> The life-cycle of storage is managed with the life-cycle of the
>>>>> cgroup struct.  i.e. the storage is destroyed along with the owning cgroup
>>>>> with a callback to the bpf_cgroup_storage_free when cgroup itself
>>>>> is deleted.
>>>>
>>>>> The userspace map operations can be done by using a cgroup fd as a key
>>>>> passed to the lookup, update and delete operations.
>>>>
>>>>
>>>> [..]
>>>>
>>>>> Since map name BPF_MAP_TYPE_CGROUP_STORAGE has been used for old cgroup
>>>>> local
>>>>> storage support, the new map name BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE is
>>>>> used
>>>>> for cgroup storage available to non-cgroup-attached bpf programs. The two
>>>>> helpers are named as bpf_cgroup_local_storage_get() and
>>>>> bpf_cgroup_local_storage_delete().
>>>>
>>>> Have you considered doing something similar to 7d9c3427894f ("bpf: Make
>>>> cgroup storages shared between programs on the same cgroup") where
>>>> the map changes its behavior depending on the key size (see key_size checks
>>>> in cgroup_storage_map_alloc)? Looks like sizeof(int) for fd still
>>>> can be used so we can, in theory, reuse the name..
>>>>
>>>> Pros:
>>>> - no need for a new map name
>>>>
>>>> Cons:
>>>> - existing BPF_MAP_TYPE_CGROUP_STORAGE is already messy; might be not a
>>>>     good idea to add more stuff to it?
>>>>
>>>> But, for the very least, should we also extend
>>>> Documentation/bpf/map_cgroup_storage.rst to cover the new map? We've
>>>> tried to keep some of the important details in there..
>>>
>>> This might be a long shot, but is it possible to switch completely to
>>> this new generic cgroup storage, and for programs that attach to
>>> cgroups we can still do lookups/allocations during attachment like we
>>> do today? IOW, maintain the current API for cgroup progs but switch it
>>> to use this new map type instead.
>>>
>>> It feels like this map type is more generic and can be a superset of
>>> the existing cgroup storage, but I feel like I am missing something.
>>
>> I feel like the biggest issue is that the existing
>> bpf_get_local_storage helper is guaranteed to always return non-null
>> and the verifier doesn't require the programs to do null checks on it;
>> the new helper might return NULL making all existing programs fail the
>> verifier.
> 
> What I meant is, keep the old bpf_get_local_storage helper only for
> cgroup-attached programs like we have today, and add a new generic
> bpf_cgroup_local_storage_get() helper.
> 
> For cgroup-attached programs, make sure a cgroup storage entry is
> allocated and hooked to the helper on program attach time, to keep
> today's behavior constant.
> 
> For other programs, the bpf_cgroup_local_storage_get() will do the
> normal lookup and allocate if necessary.
> 
> Does this make any sense to you?

Right. This is what I plan to do. The map will add a flag to
distinguish the old and new behavior.

> 
>>
>> There might be something else I don't remember at this point (besides
>> that weird per-prog_type that we'd have to emulate as well)..
> 
> Yeah there are things that will need to be emulated, but I feel like
> we may end up with less confusing code (and less code in general).
> 
>>
>>>>
>>>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>>>> ---
>>>>>    include/linux/bpf.h             |   3 +
>>>>>    include/linux/bpf_types.h       |   1 +
>>>>>    include/linux/cgroup-defs.h     |   4 +
>>>>>    include/uapi/linux/bpf.h        |  39 +++++
>>>>>    kernel/bpf/Makefile             |   2 +-
>>>>>    kernel/bpf/bpf_cgroup_storage.c | 280 ++++++++++++++++++++++++++++++++
>>>>>    kernel/bpf/helpers.c            |   6 +
>>>>>    kernel/bpf/syscall.c            |   3 +-
>>>>>    kernel/bpf/verifier.c           |  14 +-
>>>>>    kernel/cgroup/cgroup.c          |   4 +
>>>>>    kernel/trace/bpf_trace.c        |   4 +
>>>>>    scripts/bpf_doc.py              |   2 +
>>>>>    tools/include/uapi/linux/bpf.h  |  39 +++++
>>>>>    13 files changed, 398 insertions(+), 3 deletions(-)
>>>>>    create mode 100644 kernel/bpf/bpf_cgroup_storage.c
[...]
