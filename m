Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7837264F85A
	for <lists+bpf@lfdr.de>; Sat, 17 Dec 2022 09:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiLQI7w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Dec 2022 03:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLQI7v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Dec 2022 03:59:51 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52407DFBC
        for <bpf@vger.kernel.org>; Sat, 17 Dec 2022 00:59:50 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2BH8JgvV030066;
        Sat, 17 Dec 2022 00:59:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=e+bn6fUqyLTNPHdZLvurkkcL1fMYRJ0Lmx94RzX5a8c=;
 b=JlDSqEdlwhki7vota2CHAYv8igMUd08u8YGkv26Whe1pjbuo+FkqYqfSErL7x+m8l0iQ
 XfBDTJHGOjZiJPjAFc9cxA4Y4dHCn6jcJJ5RcIKI1vVM+CsIdE/YIxQ+0vxe2J6T9xS1
 23PCsk4Bj6TlfqAyrgyvKtFvBcXLT1qVCc5TaCsL0W1iB2daQsvYhFZ2g9btWhaaXPRt
 nT9RYOrxTMhyWiYuJc0Y45KZGInuSQxvXtn10DVI3xlX++uHNq5Yz4u0B5TUrXkq2NNz
 uCPOeKCH0+6iUkE5Rh0CWL70+utqACDBZDNWMi6Z0BNawSDDltXuDSxk9O0VhFTouEiO mQ== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
        by m0089730.ppops.net (PPS) with ESMTPS id 3mha5br52v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 17 Dec 2022 00:59:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+wctzh3GiLZUEcn7cyYZJtrHOa/BxmIN/jgCLr1ywmX8XR8IJVwqmwYgpeO4lz41aT4ZK7ow0jmRdy3KgvXi9dY1S3WggtezjDF9dVBvmTTgNQcj7/J7mfIJfeFO5DWOp/lGWHNL/SHmZ1fRM8FQK55HJv9E9XuomN7yUqAT8YT5M0QFpRtAtpWMQSfBTKuBepnx7O//dWz/UyrAk4KvDzBoi67MQswUB7jjO0nO7ja4UZm5aUi14u+cDMNcVOOP8+0fa/SGamRQgBcgY1bqO0o3+RJfVy/yJpqK1tjJ4n9wOWcuYRJZPAzobkWbei8ahYnIPKZWLPEJ//c5II+Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+bn6fUqyLTNPHdZLvurkkcL1fMYRJ0Lmx94RzX5a8c=;
 b=Cvlz5OLhMOiHocmLpxD++OUWOenYHvAw3K4NN8942su99BhUxLPiHr45AYG7zBsCksW5Jxc16Y9uSORuvrz/Wwxyrsot+WOf59XI8Tma0vQJX0XunpTKWPILtwVcpKeebQQtduXUQWf7DygRCy5kuhEWUD8VzTl7rz0OCQbg6Jw7iFOVNZxEl5IhAM9p7NFHGXtiqX4kvCJh695uO0at6hCm5/qZVq7t1qUF/kiMtgjAjh6IvhpfHJ02fHw2zkuo0W5A0PZHo95CZ8M4ckDzuhgd1o64HGJXm2SZqi03daD1/B5T6l5o0sS1/P1gdW5XPNyxHijyDxYyeY93pYXQRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB4433.namprd15.prod.outlook.com (2603:10b6:806:194::20)
 by CH2PR15MB3605.namprd15.prod.outlook.com (2603:10b6:610:7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Sat, 17 Dec
 2022 08:59:33 +0000
Received: from SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::7124:3442:50ed:e480]) by SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::7124:3442:50ed:e480%9]) with mapi id 15.20.5924.016; Sat, 17 Dec 2022
 08:59:32 +0000
Message-ID: <1b0aa125-15c1-247c-e3c3-cf29941b54e5@meta.com>
Date:   Sat, 17 Dec 2022 03:59:30 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH bpf-next 02/13] bpf: map_check_btf should fail if
 btf_parse_fields fails
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
 <20221206231000.3180914-3-davemarchevsky@fb.com>
 <20221207164900.mqxvvw4thxldg4vo@apollo>
 <20221207190533.vlfg33metstbcpik@macbook-pro-6.dhcp.thefacebook.com>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <20221207190533.vlfg33metstbcpik@macbook-pro-6.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:208:36e::18) To SA1PR15MB4433.namprd15.prod.outlook.com
 (2603:10b6:806:194::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR15MB4433:EE_|CH2PR15MB3605:EE_
X-MS-Office365-Filtering-Correlation-Id: a9f23f37-140d-4869-7cbb-08dae00d03aa
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qZ6fOLIdMeRNHLfMwA1zniqrW8ffja0cWhBvdE8a6P15Y73aeZuevh4TR1yuW3NVRiZFXAHva+4jDsV5Ef+EOzfE+YQajlfBHfcHhAdKPDhozQEO8rrdYkqyAbCqcr7+p8qlP63A1OToJyQT0hwDBALzWCiZ1VVMCpPIinme8F7ZfrMDTjRP4yq68pVeDoGEf4+BTgZzbUoQ0WjpUscL2ThvKOuzxc7SsqIU7DHPBeV0SsfiYXmX6WiDY6kWbjJLAbgCkQncHCdEyP5Q1Mp7xxLghVgBfoyYEHYATq/qk3RN6RXqg37eMprpQk+GrxCu2V4Enw/jOZACxNwyspkFvDbfQgPTt/4Grm8L9seuUm4M2Sq83xgC2uKHfaEK8nhHX9EyCCPGRQveYEZlx3FT3FFsju2Aju4EkQTEFHGbqwwKf5iRCqMc8UxPlQ8xUb73a9T/gRbubwIYMqEj8Q41SwgyTs9bKN1yK5PFRt8srZ7guGYDARuvQBCJ2W1JCb9XEdn8o/5m/juCHGgu09gH7G6E36YrzrTfvAE+egXEo0SmZM2E92hmN6zEWiwbtq/i0RnV9LG5m2KayDs2pRHzDn6DxLlihqsrqORuzrm2IbfmDXl7WZJYo1ZbcsiJ9nBMOIPVwNJs87XyiukVapT4uXxYiCA9gja4Uc5SUILZCC375PydTGa58GMSzXknvKWjmkLbGQ4iS07At/nPsvCx9IHQTHnjR1YJE4Gh8b1nvLo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4433.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199015)(54906003)(6506007)(53546011)(316002)(478600001)(6486002)(38100700002)(110136005)(4326008)(8676002)(31696002)(86362001)(36756003)(66476007)(66946007)(2616005)(66556008)(31686004)(5660300002)(83380400001)(8936002)(2906002)(186003)(41300700001)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXMwaytPYVdyRXRZZEVyc0ttVTZwVk51M3g4Mk51WVZVNnQ1UVVMTFhia1VP?=
 =?utf-8?B?ZmlwUVYxMVpkZWVZOG1LSmFIMFlycExtYm1FZXNYRm9MY05nMENFbUdwbWd2?=
 =?utf-8?B?VDlOQWZnY0N2OHJwaXh2STdNWCtmcEYvV2NLL2xmQWMzcW44ZjVMdGphQUdv?=
 =?utf-8?B?a1ZkRFVQS1ZKQ3E0aC9oV0dhWUtqNkIwYmhuNFFQWmU1VWpyYUtFVHA5blJY?=
 =?utf-8?B?NGorQzMxVUFxS2pBVmNnbEdvRjNONmh2c3JiN2dJWS96eWpVc2JpQ0ltMHV4?=
 =?utf-8?B?TWZlWldlWkJUOEUzeUVvY0ZPS2U2Yy9WcEY4cHg4WDluak5UZTRVQjNXUVVj?=
 =?utf-8?B?NkRWRWhoV0dESXFyNXd5NkFEWmN5MkI1eElYSkFFUUN5eTVnTFRCbTY2Q3hM?=
 =?utf-8?B?MklIMWxJbXA5QzBLTnRQRXkrNVF1KzF4UlF1bHNxT2R6L21rYW1JVnNJWWhU?=
 =?utf-8?B?Zk5CaFNoUE9ZSTg2eFlXK2Z2ZHRjSDZCY0R2S1lBUlkrUStHbFgwSDJ0ZU95?=
 =?utf-8?B?QXhkZGJQeG43Rzg2dk1xK2pNRVRZOUMrNThzM3FWUDhwa0daRmxCYXphVW9L?=
 =?utf-8?B?N0ZrbUdDUDdZZGN4bnJ3MENkQ0doQWgxUE1CeG05RnhEL2EwQ1JTbHZPd3JO?=
 =?utf-8?B?T3B3WFJ6eENxK3pSd3YyUUQ3djNhMGJZSWVkVnBzQTEzeVAycTdVQjJ1dW5G?=
 =?utf-8?B?aHJvOHlCaS9lMDJNNjJvc3VCdERsREQvNWFjU1VUYmx3UWVyeXdXYUk5VVh6?=
 =?utf-8?B?WHllaVg1OHBQYWEwQVBwTUxBaWJBT1ZrSXR0SUNNS2RvdEdBZ0htd3lPczI4?=
 =?utf-8?B?VUE0K3VhbCsxZk91T3pQeDFNcHlicWMycThRSkw0MXlTQmpGeUptbkpZa0JB?=
 =?utf-8?B?anpOeng1N3doOXUwMmZML0lxQ3IvQzhtVHA2OXpTZGFTMFJqSVdJZDJtUGVK?=
 =?utf-8?B?OGgzS0o1dkIwN1BHWHVDSlBpL2xLSFFRS0d0bG0wRnZjTU9SalhVWEpDOU0x?=
 =?utf-8?B?a1VQUnpSTVIyKy9obUxVa3RtalRHdnczZSt6ZytXTnJMZ2s2V2YrT1V2Ump3?=
 =?utf-8?B?U1h2OWhzSG1QN0pHT3dhUGNKZXcwSWNsWVRLMWVzWFhSUmI5Q2tjMXBLYUJD?=
 =?utf-8?B?RDNoR3N3Rm1maU9BNUhURUtDd2FkWExBSzd5aC9rbEh3M1F5K1BONjZpc3c2?=
 =?utf-8?B?Y2RYNHM4TTBjd0xDS2lTZmZJNGRFYlhRS3lpSmNEaGMrSkJweUpGSVJVSjVh?=
 =?utf-8?B?Y015WjhCWjMwNVFBdHhnY1VCbGpaZkRTRGVsSzd3T0s0VFg1TmthaU9HOEdS?=
 =?utf-8?B?QVI0WGF3QmlqT3QxRVpIV1VHODIrZUJUZ0ZQb2Q4a05IVUhmS01kMDVvK2xO?=
 =?utf-8?B?SDFBYUZJc0FNNDhjTTQ1d3JvM09aMlQ4NnZTbTlBZWxXWGZLNFl0dTJpS1g3?=
 =?utf-8?B?VWsrRERLdStyNDhsY21DQU5JSWZwdnN1YmUyVlBqd2JqcTBkOHNqaGtxb1dK?=
 =?utf-8?B?MEprRDM3enErb0NBc2hBd3NoQ3JDZnVKL25TM2h5dkxaZm1uanlVT0NxMzVn?=
 =?utf-8?B?UUZnbG1kcHFYMjdNRkFrNzI4eWZxMHJrT1ZxcUUrOVcxalZacExLdFdHOWtK?=
 =?utf-8?B?TmYrZUVXUWI4OEkrVCtoR3ArbnVJbEE1aStGeWRHY2ppOVRIYUNiTHBjbWRJ?=
 =?utf-8?B?clVmMWNPVWN3MmNvVEpxWnYvUVp1T3NLanpFK3J3OWxHZ3BHazRBUmljL3lp?=
 =?utf-8?B?VW83bzhHZFY4Q1pPbC9xNWo4WXhReTk0RkxFZjRiNXg3dE83SWtvdkY0SzJT?=
 =?utf-8?B?dkNLTjlEK0lkdkE2Z1FYaFQ2TnBMWWhKNjNIcmd5U1d0UDlLbHZSRm1iVkdV?=
 =?utf-8?B?cWozZjV4VEJDQzQybGhKUlcrMGFvM3owMEsvRjZsN2FzR1pBQWlwSzFVRmpE?=
 =?utf-8?B?NGx5Rk42WXNJSTVKVDg4Q3V3STJxR3VDSGYvQlVzTnpFMEI0VUtDVmgyS2RP?=
 =?utf-8?B?eWhnbEFadmdFYTI0VXhtbzNtNmQyZytabVRnOXRwc0dsVjhvQkgvbGhWT0tI?=
 =?utf-8?B?QUtONnorMW1Vai9scHE1WkMraUlkZStxeWZKSWpuT2ViVDBhT0dhNzJoR2hL?=
 =?utf-8?B?TEdmYlBsSTA5QzdlcjZxU3hCSDFSQk0wck9vS2J2TzBzS2hTeFkxTWx0OUNp?=
 =?utf-8?Q?JMdo1JqSRVuM/jgfupAbGrY=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f23f37-140d-4869-7cbb-08dae00d03aa
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4433.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2022 08:59:32.8297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 761LEVGNvpFLu46ZnmMZaz0of+n9dsJ5zhqoH5zfVN23ff2ZSLY8cYejpOMWjtd9PBnlFNmxEAUdF+jIK5Gfhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR15MB3605
X-Proofpoint-GUID: NgvmaUtTm0NUymBbusvZ6OMCtl7be7oE
X-Proofpoint-ORIG-GUID: NgvmaUtTm0NUymBbusvZ6OMCtl7be7oE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-17_03,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/7/22 2:05 PM, Alexei Starovoitov wrote:
> On Wed, Dec 07, 2022 at 10:19:00PM +0530, Kumar Kartikeya Dwivedi wrote:
>> On Wed, Dec 07, 2022 at 04:39:49AM IST, Dave Marchevsky wrote:
>>> map_check_btf calls btf_parse_fields to create a btf_record for its
>>> value_type. If there are no special fields in the value_type
>>> btf_parse_fields returns NULL, whereas if there special value_type
>>> fields but they are invalid in some way an error is returned.
>>>
>>> An example invalid state would be:
>>>
>>>   struct node_data {
>>>     struct bpf_rb_node node;
>>>     int data;
>>>   };
>>>
>>>   private(A) struct bpf_spin_lock glock;
>>>   private(A) struct bpf_list_head ghead __contains(node_data, node);
>>>
>>> groot should be invalid as its __contains tag points to a field with
>>> type != "bpf_list_node".
>>>
>>> Before this patch, such a scenario would result in btf_parse_fields
>>> returning an error ptr, subsequent !IS_ERR_OR_NULL check failing,
>>> and btf_check_and_fixup_fields returning 0, which would then be
>>> returned by map_check_btf.
>>>
>>> After this patch's changes, -EINVAL would be returned by map_check_btf
>>> and the map would correctly fail to load.
>>>
>>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>>> cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>>> Fixes: aa3496accc41 ("bpf: Refactor kptr_off_tab into btf_record")
>>> ---
>>>  kernel/bpf/syscall.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>> index 35972afb6850..c3599a7902f0 100644
>>> --- a/kernel/bpf/syscall.c
>>> +++ b/kernel/bpf/syscall.c
>>> @@ -1007,7 +1007,10 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
>>>  	map->record = btf_parse_fields(btf, value_type,
>>>  				       BPF_SPIN_LOCK | BPF_TIMER | BPF_KPTR | BPF_LIST_HEAD,
>>>  				       map->value_size);
>>> -	if (!IS_ERR_OR_NULL(map->record)) {
>>> +	if (IS_ERR(map->record))
>>> +		return -EINVAL;
>>> +
>>
>> I didn't do this on purpose, because of backward compatibility concerns. An
>> error has not been returned in earlier kernel versions during map creation time
>> and those fields acted like normal non-special regions, with errors on use of
>> helpers that act on those fields.
>>
>> Especially that bpf_spin_lock and bpf_timer are part of the unified btf_record.
>>
>> If we are doing such a change, then you should also drop the checks for IS_ERR
>> in verifier.c, since that shouldn't be possible anymore. But I think we need to
>> think carefully before changing this.
>>
>> One possible example is: If we introduce bpf_foo in the future and program
>> already has that defined in map value, using it for some other purpose, with
>> different alignment and size, their map creation will start failing.
> 
> That's a good point.
> If we can error on such misconstructed map at the program verification time that's better
> anyway, since there will be a proper verifier log instead of EINVAL from map_create.

In v2 I addressed these comments by just dropping this patch. No additional
logic is needed for "error at verification time", since btf_parse_fields doesn't
create a btf_record, and thus the first insn that expects the map_val to have
one will cause verification to fail.

For my "list_head __contains rb_node" case, the first insn is usually
bpf_spin_lock call, which also needs a populated btf_record for spin_lock.
Unfortunately this doesn't really achieve "proper verifier log", since
spin_lock definition isn't the root cause here, but verifier error msg can
only complain about spin_lock.

Not that the error message coming from BTF parse or check failing is any
better.

Anyways, I think there's some path forward here that results in a good error
message. But semantics work how we want them to without this commit, so it can
be delayed for followups.
