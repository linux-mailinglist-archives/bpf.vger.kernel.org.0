Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEE558486F
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 00:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiG1WyY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jul 2022 18:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiG1WyX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jul 2022 18:54:23 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26EC4F194
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 15:54:21 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SJmcQE009879;
        Thu, 28 Jul 2022 15:54:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=GBUelDvzRH2qUS8GgKlm5syRRmZzHx1l/fKdwYMh2Mg=;
 b=HEcSDnwIg4Plt1Fv0TKEXPutm82bzKrNSH4kILAAIc7+qnWGgR6GLRbCCqSYaY5trAd4
 G2Kyzyiqy6MVeDNBRgZt+xcE4yrdRPrSC1sAP+f9VjA2cxuCtUn/7xqubLN58tDDAYkN
 CW6M0c3W8CZX+Q9iy89m7LEc0QPJgVHdERc= 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hkxjjaadw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 15:54:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jV0BtkgIqU9/83hWkJXyUZL4AhLD8aPV8QcN2kuiRPK/8yM4nqKA7OqQXQZvd8q3S2WL1n84TxPDfWymlGa+mH9DVJDrHaUU6A5DFiqVbQh5htbC7evguicj5gxkn604ps4tHnrmPYkJYEEVBpBCcpPTSfl8QdRa8bKEqamfbXWh1jiacSPuz1Kh+cD4eEIJ+BSMPI17Zo0G0NIVl68dPWjsTPzIZ6sYYLNty7RqoJhQj9Q6mTY6FXENCaoi429Fh9BaSXW27ujo5F6ru38PwQIpu8V6whG9wB7oZbgoNxCGAm8jI8tY2/78184vg6OxQAEBB7ep/lthvKj5SA2F9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBUelDvzRH2qUS8GgKlm5syRRmZzHx1l/fKdwYMh2Mg=;
 b=Jp5Ck+7EC9uhvwT9l6BdNFl9zIbMGLi/6GsV/l73McRlqaqyStZ/t42pB0ZZAyg9GmIWn4VkvYsDYqh8UpABMp3ptgCKU5AwaPTBCjNFXKyW/+dVjnBMQe5yCDRXgVqNqfZUaGy/ydCwizd1z6rp4oVXbRJW2oruBcwyo/V8yi+tYYc7hJLQbGP4l88YkAn1fm8SbuTg9qonVxTXN94v+DjhOl84N0SEvo1UpdeTU6HTrUrK+NLe3kBwgALz1K8vorx9SeZg2pMHIPvn6hUM1GSAP5RIGgwCZ/3te+hS9exWfYzJaBFv9II+SksBwLMID0kyZaaSxaat7/gVBMOW5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW2PR1501MB2012.namprd15.prod.outlook.com (2603:10b6:302:f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Thu, 28 Jul
 2022 22:54:04 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5458.024; Thu, 28 Jul 2022
 22:54:04 +0000
Message-ID: <a0a56b1d-c0c9-8982-f695-db00983d90f7@fb.com>
Date:   Thu, 28 Jul 2022 15:54:01 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH bpf-next 1/3] bpf: Parameterize task iterators.
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Kui-Feng Lee <kuifeng@fb.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "olsajiri@gmail.com" <olsajiri@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>
References: <20220726051713.840431-1-kuifeng@fb.com>
 <20220726051713.840431-2-kuifeng@fb.com> <Yt/aXYiVmGKP282Q@krava>
 <9e6967ec22f410edf7da3dc6e5d7c867431e3a30.camel@fb.com>
 <CAP01T75twVT2ea5Q74viJO+Y9kALbPFw4Yr6hbBfTdok0vAXaw@mail.gmail.com>
 <30a790ad499c9bb4783db91e305ee6546f497ebd.camel@fb.com>
 <CAP01T75=vMUTqpDHjgb_FokmbbG4VpQCUORUavCs0Z3ujT8Obw@mail.gmail.com>
 <cb91084ff7b92f06759358323c45c312da9fe029.camel@fb.com>
 <CAP01T7579jeBY8R8wnqamYsYk810S+S2_WHPMx16daK9+AQTCw@mail.gmail.com>
 <3805b621c511ee9bd76c6655d6ba814d1b54ee37.camel@fb.com>
 <555a171a-9855-e827-878d-e75e533f72ad@fb.com>
 <CAP01T75pO1CgccUuSNWnWgyVnGuhCALMPPWsF=YJr9yfAz4=zA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAP01T75pO1CgccUuSNWnWgyVnGuhCALMPPWsF=YJr9yfAz4=zA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::39) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cbee66d-4286-4ab3-405e-08da70ec11f3
X-MS-TrafficTypeDiagnostic: MW2PR1501MB2012:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k0Cu2D/2nb1PCdQFPkwB/lT5DuXDTlE3qCqbrBw15qbrnGardE6VPTkVNUdnbl7hv1qSZi6/Co9rOM0O1t58b0he5w8qV6toRLSfkLeozA+hUGKCuE5AZFhyEeaEPZpAbZdonY60x0d46RRqC1SfAgrSF6MknMmY+6q5SLJtU3Q99roWw1QsWOZTYXOKKE2OHzsxk8jz4SfdaPDGdp5s+u77+uySz/uWhKPii4ExFrOxAor7cH7oRp34xj3j033kMi8niESCN8CwDIa8M8lYvbnOoOiYAgocYqt8KKRhT3qRLqtbN7ymb63nLiGaEOM+k/2eoAe2WlJwlY5hjxZ5C7at2ljGtv2A2mqkj4M95qnE4cvGBzsZPgc106IaA2abTmfSfuJ90yngVa7/k6KyskZkC+ih4LIIT0Fmd7uF0C8DcA0ToQfb9657VKsucguU760uY9/NuwAkpvPSETwfq/n2Fl24jfPjkSTAoVI+Yo5HaNmBiaANV6F2KaRRgzNOK5H9a1zmU3r37IWAkxNQTTk4b+gF/TB+/nPf4//KBRcnVKGYh1fzm1HwMpdY7cuf17UPe9DxfvNakj0hd7O7UQjEgbg48zXU7MEI0lNr3rYVl8rMMqc2eVqCYoxLBzXQUJgd/wwpB3cjZWVdBSvVonkW0QNzE2wmasVh4v9IEARU3XDV1WMnwC3egK9xW1tZ8z3Xgua+iHRnbSiQ/ST2MBrkJH5c7XmTgelLfeh2AH4Jm/lI/Si2iP84bNIOtiFkI7IlfU+mHgVy5ZKEZqFCLrxoEOSEmMk0XHA7KExVTMyxKfEDwQC08W4wWnEEArAEFbbQT+BTzNebDXC9ldxcxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(2616005)(316002)(41300700001)(83380400001)(2906002)(8936002)(38100700002)(478600001)(31686004)(36756003)(6486002)(5660300002)(53546011)(6666004)(6916009)(6512007)(54906003)(8676002)(66476007)(86362001)(31696002)(4326008)(6506007)(66556008)(186003)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzN1QzhOVGpneGNRT2UvcHBPSDZGeURBQlNXQnBJSWVDeGhnaStwNmFQVHFa?=
 =?utf-8?B?cnQzaUx1c3NGWFo5VFk5ck92cDRaZGJGZVBiczB0cVJxOXIzYTBIaTNkUUhi?=
 =?utf-8?B?OFVQYTVCcEhORTJFZjRObEhJSmRZMm9JK0c2QUNlQjk3cEV4bHRTZHBQbC9j?=
 =?utf-8?B?c0tWV0JkQmhoSDBjamRIN3NhMmw0ODEycWNBbE0wRlJKU3kzeDN1dTFrMkc4?=
 =?utf-8?B?NUhhVDhBdXJrelhDYzR4MUZoclV0NGkxMWVDQXNUYWlnNnRRSXNxYm5HUU1v?=
 =?utf-8?B?T2JNS2RsTGZobm9kQzdFTnVicEQ4SlNOUmYyVStRRFp6d0ZOWHVkRG9sR255?=
 =?utf-8?B?N3NHdkg1QjIzRlNSNnVBNnFwTVFJSnBSSzFLOTZzN3VmMlZ6UmRGYWg5QmRU?=
 =?utf-8?B?czh3Sm5xUzNqOXpPc0pqS0hoVlBmNjlWZHpZOFhGYzZLVGYweTdEZjlUc2c2?=
 =?utf-8?B?bVBobktPRWdncDU0em0xamhORXhjZmk2ajU0ZXpTQU5uY1BHazBvMllTbS80?=
 =?utf-8?B?TUg1SVZuSU9ra1VEdmc2Wmw4dzJSRHovSmZZTW1aR1ljZnVhejJ5dFlpd1FQ?=
 =?utf-8?B?ZTBRU0srejlwNEo1bGFldUdrczZRNTNseXhEdVpaWUk2Rk81UUVaUHZjS3dG?=
 =?utf-8?B?Q0t3blJVZjIrSEZpTlE0TlowVlp6ZkwzdHJFZG0vcVFhV2s2VXhUSzl6Ty9Z?=
 =?utf-8?B?REdJMkp3MDFQcStCejVQM3kzeW9qaGExTTNFb0VEVlMwYmFZSHV1b25QUTNY?=
 =?utf-8?B?SWlDVlRDRUo4VS82VDBqVFVMdW9QQlNOSGloa0FlU3pvVlF0alRIQjhhSit4?=
 =?utf-8?B?ZlRKSjMxenFiOGw2VUxqSmRWdGxmWGluQk03YnRrazNmNnQ0SXd1N3BYVm5k?=
 =?utf-8?B?RVVUeHdYQzY4V1BRcU02RHZMVXlMaWJQWERoUmNsQndvc3o3VCsvaC9ERDg5?=
 =?utf-8?B?eEo3YXhYODJJVHB5amFvSitDM0ticm9Oc1JDVW9xZUZLR3JUWHFnMGRsQUtz?=
 =?utf-8?B?YmZTd09xdHk2ejROV3dKZ0hmWUY3UkwxYWlYQzYrN1ladEt2T0ZvVVZ3MFlD?=
 =?utf-8?B?VkdnK0k3b2lzSjBlTUtYalpLREowUHkvaDdKZjdKQkZ3Z0VGZU1SUkZ3M2hW?=
 =?utf-8?B?NTYrWlJyQW1DcEJzbnFYK1NvdU5lK2tDaW9ENlY3eEgzNUlMUmxaazhkYW5P?=
 =?utf-8?B?YnAwVHpvMjU3Tm0vVDI1aFE4VjZWbkRITENSeG1GeXRodi9pWnBIbHpQdHla?=
 =?utf-8?B?b2hoanZOOHBaQXFpVkJCZ3llcTMyM0dwM1F1NWJNcUJmbU9nKzhNbS9XNXkx?=
 =?utf-8?B?WEoyejhDSk81Z3pEZ1JlTWxWd3lhS2MxUlphWDI2eEtYK0tTZDhWWDlFbm1q?=
 =?utf-8?B?MUQ2alFpaGsvV3ZLR29ZYVdYTUwyM1VoanJ4ZDBMejlQS0Jody9NVGZGdFdl?=
 =?utf-8?B?cVB3bG1OcGxETCt1bFZ5Tks4enRCTVdqcTBHR05VYUY5SFQ1YW9hYXhhUWt4?=
 =?utf-8?B?Z1N0ejBqNUllRWcvb1FxUmU0NHh5b0NUT0Q1R2E0QWhJUk5NakFEcUpSMmtr?=
 =?utf-8?B?ZWtVRWt5SFpOOVZ1ZmM2blFlTTRZZDEyMWtMc1gweSt3WTh0cmlqeVBYdEZN?=
 =?utf-8?B?NUNnRytkVlJGWFk5TEhPMnpoTzhYYlROM2YvZmN1QVNLbVdjNVJqdmFqVkRk?=
 =?utf-8?B?eU9hUUY1ZjJqY1NFZ3VtcXFaQm9oZ0NXNHhleC9Vam8xbis2SUxxUDVicENK?=
 =?utf-8?B?QlptOGhtMWpwTjhVc2lZWGpJL3NiWGswRDBud0dTQkxjc1FxdWF1d1c3bHVO?=
 =?utf-8?B?YzlRL05sOVdrM1hqaTZBRkJKbmFhZlNJajg2RDkwcGdnbm5KVHo1WFB3ZFBU?=
 =?utf-8?B?WmFUTGk2OWl2M3FJWUR2WHdiK24zeHZjWmlsSkwwaUdoZTFqUitubjFnRVJH?=
 =?utf-8?B?M3IvU2NtU2gwb1RMcEQxOGxKVUR6M0RzQWJIZEtSM1FVQlhZZ0xNdWRSMWdB?=
 =?utf-8?B?bFRrdHVRc0NUY21Bb2lrZ3kydnM3UFR1NXFFK2lIR29ZRHhQTVQzMHNvWVlE?=
 =?utf-8?B?bWp2UHBhTmVpZXFXVVZTRnAxYysvajdMaFdTQXVmdGI5cVVOQVgwbFdHa21L?=
 =?utf-8?B?dGcwbnNGd2RFa0JuV1RDQ21uTTJCVWVFV2F3L3FRcWRCaXJtWTgwV2Jzb2o4?=
 =?utf-8?B?anc9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cbee66d-4286-4ab3-405e-08da70ec11f3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 22:54:04.3656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y4LaxCkeMYJw/hsQJ5ZhoYK0K5oysf0CAy9TOwFMuvFubbrXNzv5uhQbnXKGIoSl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR1501MB2012
X-Proofpoint-GUID: KF7J3zYP4xuxFz4Bp9mZ6XZHItiHnjlt
X-Proofpoint-ORIG-GUID: KF7J3zYP4xuxFz4Bp9mZ6XZHItiHnjlt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/28/22 10:52 AM, Kumar Kartikeya Dwivedi wrote:
> On Thu, 28 Jul 2022 at 19:08, Yonghong Song <yhs@fb.com> wrote:
>>> [...]
>>
>> There is one problem here. The current pidfd_open syscall
>> only supports thread-group leader, i.e., main thread, i.e.,
>> it won't support any non-main-thread tid's. Yes, thread-group
>> leader and other threads should share the same vma and files
>> in most of times, but it still possible different threads
>> in the same process may have different files which is why
>> in current task_iter.c we have:
>>                   *tid = pid_nr_ns(pid, ns);
>>                   task = get_pid_task(pid, PIDTYPE_PID);
>>                   if (!task) {
>>                           ++*tid;
>>                           goto retry;
>>                   } else if (skip_if_dup_files &&
>> !thread_group_leader(task) &&
>>                              task->files == task->group_leader->files) {
>>                           put_task_struct(task);
>>                           task = NULL;
>>                           ++*tid;
>>                           goto retry;
>>                   }
>>
>>
>> Each thread (tid) will have some fields different from
>> thread-group leader (tgid), e.g., comm and most (if not all)
>> scheduling related fields.
>>
>> So it would be good to support for each tid from the start
>> as it is not clear when pidfd_open will support non
>> thread-group leader.
> 
> I think this is just a missing feature, not a design limitation. If we
> just disable thread pifdfd from waitid and pidfd_send_signal, I think
> it is ok to use it elsewhere.

Yes, I agree this is a missing feature. It is desirable
that the missing feature gets implemented in kernel or
at least promising work is recognized before we use pidfd
for this task structure.

> 
>>
>> If it worries wrap around, a reference to the task
>> can be held when tid passed to the kernel at link
>> create time. This is similar to pid is passed to
>> the kernel at pidfd_open syscall. But in practice,
>> I think taking the reference during read() should
>> also fine. The race always exist anyway.
>>
>> Kumar, could you give more details about security
>> concerns? I am not sure about the tight relationship
>> between bpf_iter and security. bpf_iter just for
>> iterating kernel data structures.
>>
> 
> There is no security 'concern' per se. But having an fd which is used
> to set up the iterator just gives a chance to a BPF LSM to easily
> isolate permissions to attach the iterator to a task represented by
> that fd. i.e. the fd is an object to which this permission can be
> bound, the fd can be passed around (to share the same permission with
> others but it is limited to the task corresponding to it), etc. The
> permission management is even easier and faster once you have a file
> local storage map (which I plan to send soon).

So you mean with fd, bpf_lsm could add a hook in bpf iterator
to enforce policies about whether a particular task can be visited
or not, right? In such cases, I think the policy should be
against a task pointer and a bpf pointer, which have enough information
for the policy to work.

In typical use cases, user space gets a pid (the process own pid or
another process id). Yes, we could create a pidfd with pidfd_open().
And this is pidfd can be manipulated with permissions, and passed
to the bpf iter. The current pidfd creation looks like below:

int pidfd_create(struct pid *pid, unsigned int flags)
{
         int fd;

         if (!pid || !pid_has_task(pid, PIDTYPE_TGID))
                 return -EINVAL;

         if (flags & ~(O_NONBLOCK | O_RDWR | O_CLOEXEC))
                 return -EINVAL;

         fd = anon_inode_getfd("[pidfd]", &pidfd_fops, get_pid(pid),
                               flags | O_RDWR | O_CLOEXEC);
         if (fd < 0)
                 put_pid(pid);

         return fd;
}

I am not sure how security policy can be easily applied to such a
fd. Probably user need to further manipulate fd with fcntl() and I think
most users probably won't do that.

The following are some bpf program lsm hooks:

#ifdef CONFIG_BPF_SYSCALL
LSM_HOOK(int, 0, bpf, int cmd, union bpf_attr *attr, unsigned int size)
LSM_HOOK(int, 0, bpf_map, struct bpf_map *map, fmode_t fmode)
LSM_HOOK(int, 0, bpf_prog, struct bpf_prog *prog)
LSM_HOOK(int, 0, bpf_map_alloc_security, struct bpf_map *map)
LSM_HOOK(void, LSM_RET_VOID, bpf_map_free_security, struct bpf_map *map)
LSM_HOOK(int, 0, bpf_prog_alloc_security, struct bpf_prog_aux *aux)
LSM_HOOK(void, LSM_RET_VOID, bpf_prog_free_security, struct bpf_prog_aux 
*aux)
#endif /* CONFIG_BPF_SYSCALL */

I think task_struct ptr and prog ptr should be enough for the
potential LSM hook.

> 
> So you could have two pidfds, one which allows the process to attach
> the iter to it, and one which doesn't, without relying on the task's
> capabilities, the checks can become more fine grained, and the
> original task can even drop its capabilities (because they are bound
> to the fd instead), which allows privilege separation.
> 
> It becomes a bit difficult when kernel APIs take IDs because then you
> don't have any subject (other than the task) to draw the permissions
> from.

Maybe I missed something from security perspective. But from design
perspective, I am okay with pidfd since it pushes the responsibility
of pid -> task_struct conversion to user space. Although unlikely,
it still has chances that inside the kernel tid->task_struct may
actually use wrapped around tid...

But since pidfd_open misses tid support, I hesitate to use pidfd
for now.

Maybe Daniel or Alexei can comment as well?

> 
> But anyway, all of this was just a suggestion (which is why I
> solicited opinions in the original reply). Feel free to drop/ignore if
> it is too much of a hassle to support (i.e. it is understandable you
> wouldn't want to spend time extending pidfd_open for this).
