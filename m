Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01ED62193E
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 17:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbiKHQU5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 11:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbiKHQUz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 11:20:55 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6575E1DDCF
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 08:20:54 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 2A8BCPWB004977;
        Tue, 8 Nov 2022 08:20:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=LCAH579KxEr3SzqdSBLn5xDt/gALDOHUGW//wJeUhr8=;
 b=k5LcuNIcvMHAsYafWqrDGqRHuMVccoh09QpfdAvVO1SDW4zWNQfJGkkYy8LvvyMRrYkR
 xeZXleR1ji+/DOQB4E6D1omKc5FxJdJ/QcmaAzgZ8RkjVW9R1iZWuaeFmmPhWdyOkJVq
 ieQU1LJP5QVrkWj22UELEQHju+daX06m1vmaeDtaH57k7JcY0JvdY6uYhTf9g4KXTrVk
 KrWAYPIT44l107ThAQ/WKc4D+bhg7EwpDrLb/guiPRzTmpsz0vflCHN8ZWtufTD/5C1V
 GmmuiBaP18g9V2P3iyQ3W7ryFgd5YGWyLJM1ljg2U43xFRplZronsRpNshlXzKgvTyGv 9g== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by m0089730.ppops.net (PPS) with ESMTPS id 3kqp1mjbrq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 08:20:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpKBzbH6ucwuFTrgjItCc2VCIzHKGQfSAKY34nZaL2iP0jDEObV3QkafA+0ENOEwoaZLudia7ziF7CY3CsTgq812EmYy71Y85dDqzq1GxLRwOnLB8h8IOiAMofaFZIA9o5sWOg8dsOsPuvtJ8SOeE5Io/RlvzaPRUkk/v/huVEe1l7MVPQVv6CBcCst7kf7LQm6TdUjooTVjhrd9xH0fwVVO9uxYV2Eb5/FvYxE3KwIErb50n3Vldb25BhgnORsDqZOXBrKylUEW2LOW/l+yGx4pz/8DG+GLKdb6uBWi/2VkWrrOBUwDlunvZWmo/M0qhO8lyKYZLozZpLF8iI8x1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCAH579KxEr3SzqdSBLn5xDt/gALDOHUGW//wJeUhr8=;
 b=KZKTRCCHNEoiPgCt4XQ4QKWoSlU17TVci2ehlCWwCqhArgDurWYWnB9LVT9Pvzc4nSjbrvMgQJ8oeeYZ8BoK8slwoPB+DCv36OoCNXYCNpKT83NZBNa75Ajx7lxMTPmsZKqOfJabl2KHDMgN/0YQwAmmqNdFMf6esTx1qdCj4X0pbGBKXzfvzvht1iZyFhBPPAKCBA6/cd7an1DCeAzX+tW6Klua2+YWUdyoKAyg0pANuv2gOldmDy1Fdjbn0g1Pl5cMnwoOL0i52v5RDCymjWzg1ZSluPtUytrP1VA0EK42gHQrcRzDMNm9oeSsOQxIyatC1Bsf5ZcEb/me1/8FRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4609.namprd15.prod.outlook.com (2603:10b6:806:19c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Tue, 8 Nov
 2022 16:20:01 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 16:20:01 +0000
Message-ID: <497caf8c-a3a5-dd3b-2b89-25cc12e3b34c@meta.com>
Date:   Tue, 8 Nov 2022 08:19:58 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf 1/3] bpf: Pin the start cgroup in
 cgroup_iter_seq_init()
Content-Language: en-US
To:     Hou Tao <houtao@huaweicloud.com>, Hao Luo <haoluo@google.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Tejun Heo <tj@kernel.org>, houtao1@huawei.com
References: <20221107074222.1323017-1-houtao@huaweicloud.com>
 <20221107074222.1323017-2-houtao@huaweicloud.com>
 <a4721692-82bf-05eb-a1fa-72ddb5d1461b@meta.com>
 <CA+khW7jmm4UWXve_kzXdh4sv8cFbFKNYQ-G-XCJ6qGRW1_verg@mail.gmail.com>
 <8bae6a03-9d31-2da5-1b7d-cf5c74e76cfd@huaweicloud.com>
 <a85181da-99dc-d3a3-53c7-96584dbad8bf@meta.com>
 <0ad23bcc-b4dd-307f-f188-1181efaa3e53@huaweicloud.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <0ad23bcc-b4dd-307f-f188-1181efaa3e53@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BYAPR07CA0098.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::39) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA1PR15MB4609:EE_
X-MS-Office365-Filtering-Correlation-Id: 57eda119-9655-4ddf-ce70-08dac1a51654
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g1u5VmiGydz4SKVcBhIKwnYWKe5bpksY0KsK1qKG94cB1CLhyhrHtqwMxbD6W8YM0JdWBD5chWEKGUiSUA7iiGxgArO6gB34qrodO92dP3fRoHPfWt/tHtdFRaq9RumpEo0Gd8kj9269wD0A6x/S7MKNz1Ac0Av25kO4Gh8tm1xqG1KzmHzBkJLF8Cbbmfu0zW72UJUwT01yMxS+b1tZZDQ89+ZmO8h+VV0i4w7ru5vG/ur3I4lJDR/altexxGkZi9in10eCFbX/AiTefsDnM6N/2ujX9Xej63ZqaAdVKIPiucfL9CPvzWb8NZDoxZ3A00Tkekv5f/s7yNhvr+Ubmi5bJFouPmFA7VgQwJxdWzv0CU+I6f7L1rMyWbVGV7Nbv4AvCVgOkxKpiNDLs/+pDokMrxcSBgRv17LvfBttXpzR0j9jhODD4MlYs5aOjQROH3LYQPqjwxUFg1lRUO3JZeDdIhdGKjoo1J/3qEaqlewklZ3vxcREHzYUvGXxq21mNPcXwbCT0qxgRipZ0TC7IpxixWeaLwlj+xyzCnhf6LhMskA8/GCow9TWTrdVQdmr7UF2w0isxjUDxfBfj9zT8mJ+mfxuub/Cz/94lefxbJ3Tb0lOZfjCe0KYEaWGFdqajWSHQ0I1DyM5q4r5IYi54sIO/nnMQ3Fm0GMeWLJiSFqqtevRKVUQZno89RKdpJfN99M/s1l0yu/fgIsa0FGE25B6YBTVhyTk6S7Jt8hE+LataQpwEnfWRaDrqvhlnSPSeRSYzn1ZckG6wfTIoPQZAZ+5bi1krNaCy2esrUhsQ8Q5jsw0AehCAiDAp5vk+cqnTB6hage4UxG6E2AmCES1hQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199015)(4326008)(8676002)(8936002)(66946007)(6486002)(66556008)(66476007)(41300700001)(7416002)(86362001)(31696002)(316002)(966005)(110136005)(478600001)(54906003)(31686004)(36756003)(38100700002)(5660300002)(2906002)(6512007)(186003)(6666004)(83380400001)(53546011)(6506007)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDhXMVBZMGkrdWE3UUYvNHpIMzJjamZqekU1M1RVK3F5ZzVLWG1NZm5MYjhT?=
 =?utf-8?B?UnlWRkVPNXVvWFA1YlFoSG8vNkN4Tks3WkN6UDJMRUo0cVdFcTY4WG16bndt?=
 =?utf-8?B?SHh1SDlrZi9iR2F0M3NPVUJoOWlKWERFQWFrWGphejFLSVJMcTJpK1NMc3Bx?=
 =?utf-8?B?Z0V4TkM0WkVzMFEzS0ZMOE53NDJibGszUUF3aDhsRkR0aElmRkdRS3FYMjV6?=
 =?utf-8?B?UHVIVjN3ekx6NGp5WFcweXdPc1FHRkhOMForU3RRWmJIeDh3S0FTRWtkdUNZ?=
 =?utf-8?B?Y2JnUXY3T092WXRWckRoOXpBRmk2V1A4cDZrSm9Zb05XY1pCR0tEUmdtRmRr?=
 =?utf-8?B?WFI5ZU9OZzN1RkJOM2hoQmZ6M2wyem9jOFgyMWVnQS9yVTgrV0pvVmVNVWlk?=
 =?utf-8?B?NHhCS09FWWVoMkp2dVg5TTJvQ1l3WTE3TEVqVWRZQ2wwbDVBamxlL3loSERh?=
 =?utf-8?B?K2l3RHpaTUtoOUpSSGw2TERzSUNnL3hTY1VyUHUyNHhwK2VTUzRzVG5TWGM0?=
 =?utf-8?B?ZHNxYXFSelZFSndoZzM1YllvemY4NUlkSmFvUktCSlVGNWlJOGc3QWxBNWpa?=
 =?utf-8?B?MmM2L01vZVZycENPWlFjU0t4R3pBbm5Qc0RhcThpQm56TnpDc01MSU84Szcz?=
 =?utf-8?B?Y1ZQRTRpVjk1Y2hPZkdQbXVLRVBLYXZpQlRMT3Fpb1I1a0Ewcm11U0dQekhE?=
 =?utf-8?B?Z0dTeGFrd2JJQ1FrSnZLOW8rUlBpRDlLbEhlTTlxeE1oZVM1Vy9jYmQvcnZ2?=
 =?utf-8?B?dFpwY1Jsa2RWbU5UYjhiNFhuUWwrWHNBeVVLU0ZUNlBOcHdBUDgxWXYrVlVn?=
 =?utf-8?B?YXJnY3lkclJ2clVZblQxQ3NqSUhvQ0JQaUlSekJMZEVKb2RNQ2drQ0p6VWht?=
 =?utf-8?B?eWVOVlhGcGo0bDA3L1VlTUpQaHphSnEwS1FxaHJJNy9FS0N3UXZ1Wk5ydWlz?=
 =?utf-8?B?R08wU1V4SWxkNHZnSW43bGp0V3JSRmxwN3FJdDloZU0xcGJFTUpraDBZWHkr?=
 =?utf-8?B?T0dkdHcrK2pzYlZVTktmZlVlbVFBSHZUOW5sclRZSDl0dHNyUnlXTzMwN2xj?=
 =?utf-8?B?Y2RleElkV0U2US9yZnFWbWJMVEFpMzRDR3pWUW1LVFJ5RDg1M3RUTHJaUTIv?=
 =?utf-8?B?T1R6TkEwTzlBY21kb1hPSlIrL09iN2ZXU1hDRHFZMk96MURvU0toRzd1Mngx?=
 =?utf-8?B?V3dCVGJCWDNaSmU1elZIMExpVGZQcUp4M0JtOHYxSlVEVG1hblo5cW12SlZl?=
 =?utf-8?B?TUg1TS9UVTZwQTdEVEZ0V1I2ak9WbSttYk55TG42elhjZFBBR0krQmlSQStE?=
 =?utf-8?B?OTB3N25La0ZBdjVuaGE1VHZqanBOT2Q0WGx1VklDOWtBOHJXaGRlRkRzV3Vz?=
 =?utf-8?B?d2hwSlEzVXRxYzZ0M0xCUEdyd1VGR2ptSVE1M09lamFqVXByaW5WdEQra1l0?=
 =?utf-8?B?N3lyeXJlSGN3Z3BUNEI0Q3VMc29JV0RkYVZTTC9SR2h4bEtaK2ltYlRQaDNY?=
 =?utf-8?B?YzEzbUVEN2ZIeWN6b3dnVHBJenNKVGwweHhOSUFOT0NSeC9Tb1NBTmUrT21y?=
 =?utf-8?B?TXVEWTd0c2FBWXZYRWp2RkVxVXc4M3lWVzRtVmFjMnRUdzFVRHEzWWtaUjFl?=
 =?utf-8?B?cXFKZFBiMm9NcytoZXRybzdIRFBuU1llcjBWR2dVdjhNUHF1bFBpTndieTl6?=
 =?utf-8?B?SUlqVDJlMkhvbVN0WkRWMzFHRzUrTzQrMDlKbXd4bzFMakJoaDRRcklPZE5n?=
 =?utf-8?B?UFhEYURCeEQ4cVd2TTRxOUlpdHZYYk5SMm1Qa3VuWTBKWEs4eURKVHkzanpI?=
 =?utf-8?B?R2ZkUEdLeG53TzZ4MEtFU2g5ZUVaMENJV3J6RHRPSnhpWTg2RWRYRWtScHJU?=
 =?utf-8?B?dVJMa0FZRmNVZXcxZHhrSGxZMWpCa1Z4ZDIvNTRlVEhKdDBwL1M2cHNtSGhT?=
 =?utf-8?B?Qm9DRkQwdk5HYkR1OElHL3BIQlZwa214UFFzRno1QlZDMXdjOThzTnJyNUJY?=
 =?utf-8?B?SDZVcS9XSXpoY2s3anMxQktrb09HczZhVVNxalpKRXEwcXI4NThUS3FLMlJ6?=
 =?utf-8?B?T3VXSUFpTnNnS3g0OC9aQWg4R0FJUGdtV3Z6dE41dUt2VnpNc1hSckZOUDU3?=
 =?utf-8?B?dUQ0S0RvVU9iK0lXYUtWOWYrcVNsYWdIVGhyWC8weUJ4NDRjbjFNaEYvZ3hI?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57eda119-9655-4ddf-ce70-08dac1a51654
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 16:20:01.7111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zALbJrbMSikvRuQLlGTv1NM+NbKGBdutPLH6maGZhZzvVt97yCXD4hbVjMY1nm/G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4609
X-Proofpoint-GUID: JlIxk5zPjuLuc1MrdzI6ZFFjd3lY2dde
X-Proofpoint-ORIG-GUID: JlIxk5zPjuLuc1MrdzI6ZFFjd3lY2dde
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/8/22 5:28 AM, Hou Tao wrote:
> Hi,
> 
> On 11/8/2022 3:03 PM, Yonghong Song wrote:
>>
>>
>> On 11/7/22 8:08 PM, Hou Tao wrote:
>>> Hi,
>>>
>>> On 11/8/2022 10:11 AM, Hao Luo wrote:
>>>> On Mon, Nov 7, 2022 at 1:59 PM Yonghong Song <yhs@meta.com> wrote:
>>>>>
>>>>>
>>>>> On 11/6/22 11:42 PM, Hou Tao wrote:
>>>>>> From: Hou Tao <houtao1@huawei.com>
>>>>>>
>>>>>> bpf_iter_attach_cgroup() has already acquired an extra reference for the
>>>>>> start cgroup, but the reference will be released if the iterator link fd
>>>>>> is closed after the creation of iterator fd, and it may lead to
>>>>>> User-After-Free when reading the iterator fd.
>>>>>>
>>>>>> So fixing it by acquiring another reference for the start cgroup.
>>>>>>
>>>>>> Fixes: d4ccaf58a847 ("bpf: Introduce cgroup iter")
>>>>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>>>>> Acked-by: Yonghong Song <yhs@fb.com>
>>>> There is an alternative: does it make sense to have the iterator hold
>>>> a ref of the link? When the link is closed, my assumption is that the
>>>> program is already detached from the cgroup. After that, it makes no
>>>> sense to still allow iterating the cgroup. IIUC, holding a ref to the
>>>> link in the iterator also fixes for other types of objects.
>>> Also considered the alternative solution when fixing the similar problem in bpf
>>> map element iterator [0]. The problem is not all of bpf iterators need the
>>> pinning (e.g., bpf map iterator). Because bpf prog is also pinned by iterator fd
>>> in iter_open(), so closing the fd of iterator link doesn't release the bpf
>>> program.
>>>
>>> [0]: https://lore.kernel.org/bpf/20220810080538.1845898-2-houtao@huaweicloud.com/
>>
>> Okay, let us do the solution to hold a reference to the link for the iterator.
>> For cgroup_iter, that means, both prog and cgroup will be present so we should
>> be okay then.
> The reason I did not use the solution is that it will create unnecessary
> dependency between iterator fd and iterator link and many bpf iterators also
> don't need that. If we use the solution, should I revert the fixes to bpf map
> iterator done before or keep it as-is ?

Let us do it separately. This is a bug fix (targeting bpf tree). map 
iterator issue has been fixed and we can leave it there or change to 
hold a reference to the link. Personally I think we can leave it as is
since it is working.

>>
>>>>
>>>> Hao
>>>
> 
