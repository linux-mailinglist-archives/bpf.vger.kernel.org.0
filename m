Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F6B4CB7F5
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 08:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiCCHfL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Mar 2022 02:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiCCHfK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Mar 2022 02:35:10 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DF615D3AB;
        Wed,  2 Mar 2022 23:34:24 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2235DUFv005212;
        Wed, 2 Mar 2022 23:34:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=xiCtSZjgaDs6WXA5y+/X/su88NGOmmDOZhczdSENgSA=;
 b=bvvXRYzG94tiCp3gn6KDU7D1WlNZfA4Sd8iI5sULBWyUR0f288fgJDexvGfcZldzkVJr
 BTfrVk6/Bw5A8xexDQxKKGoxW4IWEZLywKVyjfJxT4RREJH61/35shpAlkwpvqbd+cOf
 411HDBSYwx6Qagi35pTszO7Ob594DHRcIF4= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ej7km04ms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 23:34:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNKU8RIvknarPzuZ0lAUrRVGOSL1V44BXcbFEjdOS8OBKfT9NuFUU+ALKTWoCJCbmmG4cUUyN3Ur7FPkpK3yA6XejyMqgh30XEPxRV/1alJ9TnjyCArlxPeko1G9e+i+qvu35YbRqZLoe8NfvEQYRwzAVDVZnt3iI+0YMwy9W8xlwk3OQp+Wgfnwsh/651WcaHpZSbTmqb3du66wXDC9TO+pulhGmLFx1aUURedqaHR3MhitTYH8+n6aeS5SYk23guWVFtPyUxJpVhTA+xi1/+RPJZwd4AGz1h0yqT/7oEhKkEeAgT9HtgmjNq+QCPubgG4aqW1CrjQbOur/4nnnjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiCtSZjgaDs6WXA5y+/X/su88NGOmmDOZhczdSENgSA=;
 b=Py0JymTUbSvs/t+4UUW07ID5OUSCQ6pzbmCNzA21KhPkbJFBoUpNp0LMXScQ5Eu9F9wxOfsz4M1tPgwA9Z3U1BoUf6t5HGzatfhJ7y/8iZhhrrhv3YiddMvgAueYXhrZddzWr0LLbyUSgV/kBNUMZb2AInXt0ZSNIOYj4V007yrLPWsnQjNUrUWETuQhVaMvZQX7ptYnmewRwySU9WbjqIolrsNDdB7cai2gJzlb+r1v+La7h+hAWUa5o7o2hHF9BFEC1ymJZ2306RZzrQBR2fIRbmYr8kBUuQU8lbGSkw/sX39O1uvdiwctiDXojWEt559LH9QUNvu7OuY5VZweMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SJ0PR15MB5245.namprd15.prod.outlook.com (2603:10b6:a03:429::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 3 Mar
 2022 07:34:01 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1%3]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 07:34:00 +0000
Message-ID: <ee991731-0e85-23be-2720-2d641704dcf9@fb.com>
Date:   Wed, 2 Mar 2022 23:33:57 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH bpf-next v1 8/9] bpf: Introduce cgroup iter
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Hao Luo <haoluo@google.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, joshdon@google.com, sdf@google.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220225234339.2386398-1-haoluo@google.com>
 <20220225234339.2386398-9-haoluo@google.com>
 <20220302224506.jc7jwkdaatukicik@apollo.legion>
 <f780fc3a-dbc2-986c-d5a0-6b0ef1c4311f@fb.com>
 <20220303030349.drd7mmwtufl45p3u@apollo.legion>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220303030349.drd7mmwtufl45p3u@apollo.legion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR18CA0048.namprd18.prod.outlook.com
 (2603:10b6:320:31::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 849d93c9-d2f6-41e3-cbcb-08d9fce82f5a
X-MS-TrafficTypeDiagnostic: SJ0PR15MB5245:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR15MB524528A32E7D43226BE3DE5BD3049@SJ0PR15MB5245.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1fF5bGK1H+anJh8yvaVqeTim7u51T64mKq1lKDmNIhoMqr7q4IPN51PTHQVn0jHW8o1oCPJLhaTRakfbvhBHUvQQnZJTz7I7f1JbQ/nlskOMFAshRAjD9I/COfI7MXlEM/jwwCejbNcurIJw7MVd87+JQgpOgHwAqU743bq7MC2ja5nNwNR7Waz1R9wQl+Rc8aM+sczc+r8dR7MQd0tlGCUXEFGjZ1P3hDKwtBiNiaZRfGwkSVVZZNk4ohSTvmWC+8j2qY7e+TdZ5gmlk545uonobVZDD3LQRP58Xxw/+I6lYjcMOq/H+C4AmHifQNqp0SSm6eAACS4tV3OWKFsmxiSnNeL6RPfga/YbLrrz5WjT3bxJz6U4nyX5KDcGo4Eha4FAMnJ+AcYHwVZqJdFeETXQuEjt2buj6AjDopTe/6yRBBdB3L1h9msgUwAl/6lIx5SW34s61JSQ70ec7JO1HGDQ3JQcgBUVRaO/nASWIT8l+GK41Vp9VaVMLxH5yGCEU6nMuswfMBSBJlQgKK8Ax1rGZ8Jd5MKxKu9xJB7U+/ujSmotdzsvc+KZPk+BW/7RaPr6tQQW899c/q5XBjRxKADRCEjTSfk6Rrt3T36ENa9GIfVYqnqLtiuZr6rHXVbFk89NaBW8NTpHKa6kFFF/DunX+pbNJfZFdO9TCcuRKWWxUNG5uRB8isNyREMU7DKCSIM52kAV6VW83zN7bG8HGqpxK+18qqnOcAXFgdbxfmqlkEp9HJxE3k7NWDYSXZmg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(31696002)(316002)(7416002)(6916009)(36756003)(53546011)(86362001)(54906003)(66476007)(66556008)(66946007)(4326008)(38100700002)(8676002)(8936002)(5660300002)(2906002)(52116002)(6666004)(6512007)(6506007)(186003)(2616005)(83380400001)(508600001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aU9rbVJjak5ENDFya0pSWVVqS0ZtSlFVUTFzSFdsSlBOOXJlZmo0Ny9aUm90?=
 =?utf-8?B?TDBrRTM5RUJodjZPRGFWeWpaN1FsNmpmVUhkZHpZMTRkNVhFN1JYblN3OWQz?=
 =?utf-8?B?YjZNeWFpUFM5YTFhRHV3YlRrQTZHSTJnaDBWcUlSUlp0K0ROMFZVTFp0OXUz?=
 =?utf-8?B?U1AvR2l0NlRVZFZPNVZlV3ZKSGNzZSs1TWhacGlLYUx3dExqdTBHS2V4Tldp?=
 =?utf-8?B?TUxuZVVMWGxHVkhybnh1UG5JdzcrVkp3ZXArVERqa2JRdUpZR0p0ekxRZFM0?=
 =?utf-8?B?RUdUZFQ5a0NESVpHazhkN1ZVQ21GQnpTUEJyU0ZxV3hFNDlLRzRsK0VuYk1r?=
 =?utf-8?B?WVY0WkxaSXBXU0oyQ3EyWlVxZ0ZCMSttU3lrdmFNeElPTk5rOXh1RnZyYWtD?=
 =?utf-8?B?czRiTW45RzRCTHhIb0pwWmViQW13a0pTOVArSkFJYTV4eUdGSXR2dVlHYi9i?=
 =?utf-8?B?cjdzV05MMjc4NUlTZ2pZRTJUWTNBcG12MFRhekhTaUd4VTJRWS9ma1JpVDQ1?=
 =?utf-8?B?Sytra2tpeXZSMmhDakJCR1NVZ0thbEdoR2pUU0NFVVNRZTVWR09GWERxeEJQ?=
 =?utf-8?B?eFE1MWxEdG1FV0RQUU5hdGd6NDZrQldEVU9iRVV6UkZUVk55LzNuMTA3MnRD?=
 =?utf-8?B?MkVxeWJHMkYwa0FRZXVuNU9WbzZwWThXMGxHcHVIVmo2bG1oRzVVRVQyYXpI?=
 =?utf-8?B?cHpUM2tkR29HVmpBd1JKc05wdVVZMVhjQldkLzQ2dkNwd1VwU1JBWWJRWW41?=
 =?utf-8?B?NWh1UytBZ3QzaTlhNlBWWUVvc0R2RHpNWkd3VXM5dEFIWlhNVDNaa1NKeWpM?=
 =?utf-8?B?b0p5aWFlZ2V6V1NDRGhUUkQyNG80djV0WXRWbnUybEUrekFSSjlzVXR0ekgz?=
 =?utf-8?B?azUyczlkSmJKNkhIekk1UkV5YW1uUEdVbm9nOHFjcUYrL1dHejI3UFl2b0VZ?=
 =?utf-8?B?cEsvOXZhNVhPMGYwdy8xcjM3dzNOMlBrMDQ3Q1Z5dmMzbXJsUlNHOXJmbHkz?=
 =?utf-8?B?L29jaHJIaG8yem9ZUi9NREU0cTdqZ3g0ZCtzUytNSjZYVVQ2Y21KUVk3MVJj?=
 =?utf-8?B?eW80d2kyZDFyQnlYWE1zRFpZOHhqYThCdW80dmU5c1ZuOExveXdyaDRvK1Ar?=
 =?utf-8?B?SXdkbGNFWUsyd0I3a0NCTjIxMXRBcXgrbVdOKzhHa3psbmFSUzZKTXQrM2hC?=
 =?utf-8?B?cENzVjFiQnJjMllJQUxHM0J5eDRCSWNoZHNCbXBTU0lsdWtnWVVOeXAzaHdQ?=
 =?utf-8?B?blRaWTRObzlIbURwQVI1S1d2Y0x2WFJuV3BEbThackIxc0ZxdTlWdVVrbW83?=
 =?utf-8?B?VStmbHpIUFdIdVQwa1l3SGNtRHk2dW1uQ05US2gxL0FLWU40WDY0QW1ENGYr?=
 =?utf-8?B?QXc0Mnc5TWhVUVdOaHBRam5EUUJRS1ZjNVlsaHN2bk9VYUVyVk5IMDVhaUVm?=
 =?utf-8?B?UE4vanU5Ui8rUVgrYkhHMXAyVWp2Ylcwckdlenc2SUcvek9WSVRpQ0ZMdjNq?=
 =?utf-8?B?ZnRFOHJRd3FXVkduVzJWakx4dkxOM0k2Mmc2VXVIdndXMjdsQndjYSt3RFZI?=
 =?utf-8?B?YjZrb3BDbnlHM2FCRjVMM1NnVlFtc25oUndoYmZtcGNhMWlTVlhPdVY5b2xQ?=
 =?utf-8?B?VnREUlJmOU1GMUpqQkFFQUZJSWVTbkk1dnFCK0ZINnBJUlRwVTQ5VnlEa1I0?=
 =?utf-8?B?TXF4ZkR4amM0ODVxSzI0MzRid2J6KzVldWxvKzFkYndLQWErZm5lL1dvNXVE?=
 =?utf-8?B?eG5YVE5kY1NqU3BuRVRiaGlRTHJnU3FOZ0ZweG94c0xGMTVWc1g2R0I0TnRR?=
 =?utf-8?B?YXY4SGhVeUJ2WXlQRjk4QmVsVzFQR0FwdEN0SmZML2pJci9XcmljRlpYeXlF?=
 =?utf-8?B?bFRVSzlvQmVBTEdmRmp6U2VTMEd4RnE4c3BQTEp2WGxXaXA0OW9RNVZKa3VV?=
 =?utf-8?B?eXVmNWUvQThpZzRaNTVHSDlwc3ZHVXN3MU5MTEhQQVJiTDJka0dEa3FOSjEy?=
 =?utf-8?B?RVJmV2lrVlhHQmx3UElYTys2d2FuM1lzQyszOVVHTzVZUFJhSnFwamdWeDZZ?=
 =?utf-8?B?b3liOHAwaFF1RXNYaEpjVmU5RzA4cnpZZThwSTZVdENsODIzb0dKUjNjOGUw?=
 =?utf-8?B?b0gzVW5IbkVFYUd3YjRTT01kUFNXc09sQXFsc3dPaGRUY3ZtZzg4ZTMySU91?=
 =?utf-8?B?L2c9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 849d93c9-d2f6-41e3-cbcb-08d9fce82f5a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 07:34:00.8133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +NbjGOXyoD0fIM5vdIIYIezvga5rw+HvByrq/HT1kfIqtJkK+VSDZsp28cQO2VLM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB5245
X-Proofpoint-GUID: KaVmd7GDoVuLv3gZK7ec6TITXlJbIEdj
X-Proofpoint-ORIG-GUID: KaVmd7GDoVuLv3gZK7ec6TITXlJbIEdj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-03_02,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 spamscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203030036
X-FB-Internal: deliver
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/2/22 7:03 PM, Kumar Kartikeya Dwivedi wrote:
> On Thu, Mar 03, 2022 at 07:33:16AM IST, Yonghong Song wrote:
>>
>>
>> On 3/2/22 2:45 PM, Kumar Kartikeya Dwivedi wrote:
>>> On Sat, Feb 26, 2022 at 05:13:38AM IST, Hao Luo wrote:
>>>> Introduce a new type of iter prog: cgroup. Unlike other bpf_iter, this
>>>> iter doesn't iterate a set of kernel objects. Instead, it is supposed to
>>>> be parameterized by a cgroup id and prints only that cgroup. So one
>>>> needs to specify a target cgroup id when attaching this iter.
>>>>
>>>> The target cgroup's state can be read out via a link of this iter.
>>>> Typically, we can monitor cgroup creation and deletion using sleepable
>>>> tracing and use it to create corresponding directories in bpffs and pin
>>>> a cgroup id parameterized link in the directory. Then we can read the
>>>> auto-pinned iter link to get cgroup's state. The output of the iter link
>>>> is determined by the program. See the selftest test_cgroup_stats.c for
>>>> an example.
>>>>
>>>> Signed-off-by: Hao Luo <haoluo@google.com>
>>>> ---
>>>>    include/linux/bpf.h            |   1 +
>>>>    include/uapi/linux/bpf.h       |   6 ++
>>>>    kernel/bpf/Makefile            |   2 +-
>>>>    kernel/bpf/cgroup_iter.c       | 141 +++++++++++++++++++++++++++++++++
>>>>    tools/include/uapi/linux/bpf.h |   6 ++
>>>>    5 files changed, 155 insertions(+), 1 deletion(-)
>>>>    create mode 100644 kernel/bpf/cgroup_iter.c
>>>>
>>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>>> index 759ade7b24b3..3ce9b0b7ed89 100644
>>>> --- a/include/linux/bpf.h
>>>> +++ b/include/linux/bpf.h
>>>> @@ -1595,6 +1595,7 @@ int bpf_obj_get_path(bpfptr_t pathname, int flags);
>>>>
>>>>    struct bpf_iter_aux_info {
>>>>    	struct bpf_map *map;
>>>> +	u64 cgroup_id;
>>>>    };
>>>>
>>>>    typedef int (*bpf_iter_attach_target_t)(struct bpf_prog *prog,
>>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>>> index a5dbc794403d..855ad80d9983 100644
>>>> --- a/include/uapi/linux/bpf.h
>>>> +++ b/include/uapi/linux/bpf.h
>>>> @@ -91,6 +91,9 @@ union bpf_iter_link_info {
>>>>    	struct {
>>>>    		__u32	map_fd;
>>>>    	} map;
>>>> +	struct {
>>>> +		__u64	cgroup_id;
>>>> +	} cgroup;
>>>>    };
>>>>
>>>>    /* BPF syscall commands, see bpf(2) man-page for more details. */
>>>> @@ -5887,6 +5890,9 @@ struct bpf_link_info {
>>>>    				struct {
>>>>    					__u32 map_id;
>>>>    				} map;
>>>> +				struct {
>>>> +					__u64 cgroup_id;
>>>> +				} cgroup;
>>>>    			};
>>>>    		} iter;
>>>>    		struct  {
>>>> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
>>>> index c1a9be6a4b9f..52a0e4c6e96e 100644
>>>> --- a/kernel/bpf/Makefile
>>>> +++ b/kernel/bpf/Makefile
>>>> @@ -8,7 +8,7 @@ CFLAGS_core.o += $(call cc-disable-warning, override-init) $(cflags-nogcse-yy)
>>>>
>>>>    obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o bpf_iter.o map_iter.o task_iter.o prog_iter.o
>>>>    obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
>>>> -obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
>>>> +obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o cgroup_iter.o
>>>>    obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
>>>>    obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
>>>>    obj-$(CONFIG_BPF_SYSCALL) += disasm.o
>>>> diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
>>>> new file mode 100644
>>>> index 000000000000..011d9dcd1d51
>>>> --- /dev/null
>>>> +++ b/kernel/bpf/cgroup_iter.c
>>>> @@ -0,0 +1,141 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>> +/* Copyright (c) 2022 Google */
>>>> +#include <linux/bpf.h>
>>>> +#include <linux/btf_ids.h>
>>>> +#include <linux/cgroup.h>
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/seq_file.h>
>>>> +
>>>> +struct bpf_iter__cgroup {
>>>> +	__bpf_md_ptr(struct bpf_iter_meta *, meta);
>>>> +	__bpf_md_ptr(struct cgroup *, cgroup);
>>>> +};
>>>> +
>>>> +static void *cgroup_iter_seq_start(struct seq_file *seq, loff_t *pos)
>>>> +{
>>>> +	struct cgroup *cgroup;
>>>> +	u64 cgroup_id;
>>>> +
>>>> +	/* Only one session is supported. */
>>>> +	if (*pos > 0)
>>>> +		return NULL;
>>>> +
>>>> +	cgroup_id = *(u64 *)seq->private;
>>>> +	cgroup = cgroup_get_from_id(cgroup_id);
>>>> +	if (!cgroup)
>>>> +		return NULL;
>>>> +
>>>> +	if (*pos == 0)
>>>> +		++*pos;
>>>> +
>>>> +	return cgroup;
>>>> +}
>>>> +
>>>> +static void *cgroup_iter_seq_next(struct seq_file *seq, void *v, loff_t *pos)
>>>> +{
>>>> +	++*pos;
>>>> +	return NULL;
>>>> +}
>>>> +
>>>> +static int cgroup_iter_seq_show(struct seq_file *seq, void *v)
>>>> +{
>>>> +	struct bpf_iter__cgroup ctx;
>>>> +	struct bpf_iter_meta meta;
>>>> +	struct bpf_prog *prog;
>>>> +	int ret = 0;
>>>> +
>>>> +	ctx.meta = &meta;
>>>> +	ctx.cgroup = v;
>>>> +	meta.seq = seq;
>>>> +	prog = bpf_iter_get_info(&meta, false);
>>>> +	if (prog)
>>>> +		ret = bpf_iter_run_prog(prog, &ctx);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static void cgroup_iter_seq_stop(struct seq_file *seq, void *v)
>>>> +{
>>>> +	if (v)
>>>> +		cgroup_put(v);
>>>> +}
>>>
>>> I think in existing iterators, we make a final call to seq_show, with v as NULL,
>>> is there a specific reason to do it differently for this? There is logic in
>>> bpf_iter.c to trigger ->stop() callback again when ->start() or ->next() returns
>>> NULL, to execute BPF program with NULL p, see the comment above stop label.
>>>
>>> If you do add the seq_show call with NULL, you'd also need to change the
>>> ctx_arg_info PTR_TO_BTF_ID to PTR_TO_BTF_ID_OR_NULL.
>>
>> Kumar, PTR_TO_BTF_ID should be okay since the show() never takes a non-NULL
>> cgroup. But we do have issues for cgroup_iter_seq_stop() which I missed
>> earlier.
>>
> 
> Right, I was thinking whether it should call seq_show for v == NULL case. All
> other iterators seem to do so, it's a bit different here since it is only
> iterating over a single cgroup, I guess, but it would be nice to have some
> consistency.

You are correct that I think it is okay since it only iterates with one
cgroup. This is different from other cases so far where more than one 
objects may be traversed. We may have future other use cases, e.g.,
one task. I think we can abstract out start()/next()/stop() callbacks
for such use cases. So it is okay it is different from other existing
iterators since they are indeed different.

> 
>> For cgroup_iter, the following is the current workflow:
>>     start -> not NULL -> show -> next -> NULL -> stop
>> or
>>     start -> NULL -> stop
>>
>> So for cgroup_iter_seq_stop, the input parameter 'v' will be NULL, so
>> the cgroup_put() is not actually called, i.e., corresponding cgroup is
>> not freed.
>>
>> There are two ways to fix the issue:
>>    . call cgroup_put() in next() before return NULL. This way,
>>      stop() will be a noop.
>>    . put cgroup_get_from_id() and cgroup_put() in
>>      bpf_iter_attach_cgroup() and bpf_iter_detach_cgroup().
>>
>> I prefer the second approach as it is cleaner.
>>
> 
> I think current approach is also not safe if cgroup_id gets reused, right? I.e.
> it only does cgroup_get_from_id in seq_start, not at attach time, so it may not
> be the same cgroup when calling read(2). kernfs is using idr_alloc_cyclic, so it
> is less likely to occur, but since it wraps around to find a free ID it might
> not be theoretical.

As Alexei mentioned, cgroup id is 64-bit, the collision should
be nearly impossible. Another option is to get a fd from
the cgroup path, and send the fd to the kernel. This probably
works.

> 
>>>
>>>> +
>>>> +static const struct seq_operations cgroup_iter_seq_ops = {
>>>> +	.start  = cgroup_iter_seq_start,
>>>> +	.next   = cgroup_iter_seq_next,
>>>> +	.stop   = cgroup_iter_seq_stop,
>>>> +	.show   = cgroup_iter_seq_show,
>>>> +};
>>>> +
>>>> +BTF_ID_LIST_SINGLE(bpf_cgroup_btf_id, struct, cgroup)
>>>> +
>>>> +static int cgroup_iter_seq_init(void *priv_data, struct bpf_iter_aux_info *aux)
>>>> +{
>>>> +	*(u64 *)priv_data = aux->cgroup_id;
>>>> +	return 0;
>>>> +}
>>>> +
[...]
