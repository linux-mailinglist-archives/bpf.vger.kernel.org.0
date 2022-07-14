Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9360574535
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 08:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbiGNGmv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 02:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbiGNGmu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 02:42:50 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7461FCEE
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 23:42:48 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DICgem017546;
        Wed, 13 Jul 2022 23:42:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Uv/dyZPuYPIHU1a41TfB/ez5Oy+KqzZ2Jrf+te27v9Y=;
 b=rNObMl5xKuTFzWFZY7MI42sOqK85ZX5w13eZ5ma0nM+przR/1KK+LKWPSac4GeEI5C7P
 ITkSGGz7Uf5ZfqfVt9sn4f8fjan4hFUOQRKL63fdjb6TwqQ6WwA3rCfRN1X/NmWbXQjm
 bEYJDFo3GKMCGoB1L9kWsOxLdEKZntfoDyI= 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h9h5hs8h6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 23:42:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOOlwW8TE9OHEpka1FrMjEeq9H0eunm/d2SkRCUtYDIHKcxP63byHQBobvU5wbUyHTJSngkvdgTrJ0jn0vL9Hm8BuydwGm4UF7l4tqWmjQJ5qxwi7MDmy1DCSC9IoelfcSzYfCx4kDZq9DSH53P7g6y98YjC1J+iLF15KyEp/roMX0a2eO+AO6iZ48bJsYduacwB3m2aMIsnp6W3jileMioi+uwI2c/0t9ObZKFAGaT27WYwMUcVxe6wcycaJGUKpXwrAfnm5sqSJ1K04pPTFl6E+IRpYLRoLBwdGjOddDAOwcu4pPkH3yfpB2zFJEGVKf33cW8JgTyiDbQ9Krikug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uv/dyZPuYPIHU1a41TfB/ez5Oy+KqzZ2Jrf+te27v9Y=;
 b=egj1nmfK6PprtUI/dsKAibKmwav9TZI8+jpXWo4ZgPDRQN5NNhy8uCl4ri55xCsy9hRg1LB9plT50QU/AEq/3tqH4r2iXNiTzymoUBZg4gz1bTmH6c4TRJzmCYFAvEt/qSDvu7L9zY0oa4JfhJKSnIyPaVTZgzqCoTEikGCM/KxXl3qoA0jUaCx1nqJoupgOB0kHw8ARO7huuO+Fuwpd04uXIe6ldO7pLPD8cIbD/ucFRr1f3iC/o6a/QOu4Qkortkcnx9EmSrZ1YIpVdwn8hRCyn2ve61ax1oDtQZWkL4K7oaIFTufBMDCHQhm/4v75BrvwtZ4dYuzdpqNu0Nq0wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by MWHPR15MB1328.namprd15.prod.outlook.com (2603:10b6:320:25::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Thu, 14 Jul
 2022 06:42:44 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::acda:cdec:5c2f:af77]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::acda:cdec:5c2f:af77%7]) with mapi id 15.20.5417.026; Thu, 14 Jul 2022
 06:42:43 +0000
Message-ID: <70edc9d0-9dab-c5d7-7f3e-9ce6c3b700de@fb.com>
Date:   Wed, 13 Jul 2022 23:42:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH bpf-next] docs/bpf: Update documentation for BTF_KIND_FUNC
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Indu Bhagat <indu.bhagat@oracle.com>
Cc:     bpf <bpf@vger.kernel.org>
References: <20220713222544.2355143-1-indu.bhagat@oracle.com>
 <CAEf4BzYqL_p61f_2HXSNuCSXPGxWbq7+kvZvmVGGgdLY1Z1ZWA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzYqL_p61f_2HXSNuCSXPGxWbq7+kvZvmVGGgdLY1Z1ZWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0358.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::33) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0077ff9c-68c4-4e2e-69a5-08da65640e42
X-MS-TrafficTypeDiagnostic: MWHPR15MB1328:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EVOa4trOqJW8hywzas30oAKdvfj+LvmUM7QNu3aQWZRsBnYRrBv99Ch8OFz6CacFdfVRju1F+fQsr+FWLM0fsuegG7gdxwUi6BvX24+BSOXyKnzRZAUBGeKrMBSTg9BHM4itz2Zwl6tgLGp1msO+O5jECkMciqqlxCw3x8awyM1Tlak0C30Pol8cB9lFrwqAs5FYoTD9hgfr09FAUG1cyD+CbA5KdKN0q3vFiZFpaP+aN23nKZBcDkWt4iBdrBL9EPVSbfzvWzJcB+aKOX3E63YGFDPC6o5sfKpiUV2t8mRjqdOq9bl2feda5KG19x03VOCGROM6VSXrOpEAk699OwNaJiuE+Yq/3guTt39pqHXAXi7OwKk9HXeJ3RR3Qwwtzx3ujo0+0vWfGy0HhflZ/vqA5jNxo27AvtU00n5mOczLzQORjCyK11yLUUQ2Ql69CWe8KKRjhBp6i7pBIYli/CNtJaV/OKwQDl2mBEFldOtnhsB2S7WIKXHsEeopYOhfhduznqjZ2QtUGsFBgeZ2SSbuRDHDBkZ1KQtc6cCmhmD+JDuDWT28JVUS9f37y0PY0RzQtPPdUYTxQdVsmcy7+fyKAiPmERhMqUmcY0Gb0Ia0ciYEYUtKR3r8SDtcsGfOWx0fJzc6K2C6zpJtTeCS9Y/HDhX37qzIjydC6NLc4+NCQD8cB1aQHKolUF60e6bZfaMaajjzCq54bys5+S0ygFFQPEKf3q5LA0BKe68OSqV48iwfniw1lh30winKeDtnSXwOTfzMsOBz9b2Vsqwz4p/Nv4QOsFi/tqvXTxHlh5eApNejZjZE+cHI60rg98eawu3sBInpwFh/on9nrSsyD0UaQPIvSsu4U5jffM7AVNk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(478600001)(66476007)(53546011)(6506007)(6486002)(41300700001)(6512007)(66946007)(8676002)(66556008)(31696002)(316002)(86362001)(83380400001)(4326008)(38100700002)(186003)(2616005)(5660300002)(36756003)(110136005)(8936002)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blZ1U0lDNExzOXNOTmp2VlptYlk2WDhjWTllQjBIY3l6R3BvMG9kdEoxczJ4?=
 =?utf-8?B?MDJtNmpnZ20yQ1V1ejNzRm5tOWpLRFlMSmNaSDNmUUFYWEZTR1U3REVCbzlY?=
 =?utf-8?B?WDcyMWk1UWt2QitqclYzT3JJUTBqbndxZ0hVOTk5MHZQRGZMektVNjlYK3g0?=
 =?utf-8?B?M0RjcUhqSzlPaVlOYSs0eUpvbEdNeG1XVFpsNncwcXpuQ3JHdnllUkk1VUdB?=
 =?utf-8?B?c1U1NHlJZDc5SnlVZXIzcVVtWkhoV0Zld2xtd1FUSFovRS9pVWgyZ1VvMlVi?=
 =?utf-8?B?bXJDSGVBZXA3SldFMDdtWm85WFNKZDRxNnJ6aTlpdkFNcUdoOFRRQmVhUVYw?=
 =?utf-8?B?SDl5bnBpVmxnSHdNOUpCOENhelM0NXg1eUtxZmFvYnNVcTltMXpwRll6d0tG?=
 =?utf-8?B?RU5HbHdKWGZYOTBNcTF1SitwSzR4TVFtdlV0VkFlMS81RmxVd0tYL2lJMEsz?=
 =?utf-8?B?WUwyc201a3Fza0ZmcHVkZDRrQUtjZmVrRGh6QXkrV1pNelpWMVVKY3Foempa?=
 =?utf-8?B?YTJwMjV3bkZtUTF0dTFnWjJNazZnL2EycDd2M25WVVhJa0tJR1Y4a241TGRW?=
 =?utf-8?B?a2VrOXFZbUhoTEEvU29oWlR1bTZrNmZHUUdablcxMUROYWh0QkEzUyt4ZTZC?=
 =?utf-8?B?QUtJcFZtN2VEV25jMmszMmVSQitGUjJ6N3VmNEFDcWhwZSt2T2NKdkZqOGZX?=
 =?utf-8?B?Q25Ca2ZVUFNYNUllV3k5RlJJUi9YUUFvNDkyZFN3M2hEU2tZTFF1N3ZQUlRK?=
 =?utf-8?B?YWY2b0Z2NHhyOHhNdVRKemZtMmF0QUFORFNYazIzalI0S1BUNU1jY1dPb1pN?=
 =?utf-8?B?eFhCOVRPZ2lBS0UwbEVqT0ZGcTlWU2o2RDNYdUFYamlaMGxwSHk1dlVsTUQy?=
 =?utf-8?B?K1JxSTZOckc4TUVGakYrVk9Ka3RCT2Nyd2l0MDM5OWRMNzk1dHU4ZlZsVUc3?=
 =?utf-8?B?RVJ5Z0J1L3pBMW5heFByaE9FWUlVYTB5N0gzT0hnclNFYWdzK0pqMkZBWno4?=
 =?utf-8?B?UWNzOFJ5a2RBN253RU5xVmN0QURwZXArVFlmVDRrUnVCcmdjSjYxVVhjS1JV?=
 =?utf-8?B?cm84cnlTY0lZNklocUhGaVF4WWMyb3czSnlCbE1LOFFoVUdub3ZScU92M2lS?=
 =?utf-8?B?YTBjUWFBU0FaNEt2Qkt1RzNEbEhMdXp5cmQxZUNERUgvWkMrVWxLVVhaRGlI?=
 =?utf-8?B?bllVdk9tLzF0akszVldsNVVBazVacFdqOVlKVmw2d1ovTFFwVy9jVE1EMHd3?=
 =?utf-8?B?RG5mUFl1Z1BVcExSZUlid2tmYVpaTUJjYjVWYlFjTDVITkFqTkRLUUxuczMv?=
 =?utf-8?B?bFEwd0JXZ1o4SmRlVGRaV0hUZklqVVpNVC9OaGdac0Q5dUFhYkVqK1o5bWV3?=
 =?utf-8?B?WFBDMktJWG5ZZnVGUXQ5MXU2d1ZtUmZXUUwxWFcrUFBIMFAzMGRXVmY0TVJi?=
 =?utf-8?B?OFVaZFhsM28xZTNmWmVpcjg1VlU1bEVpN3RnTFF2UEx0b1pTeDA3bHY3S2xz?=
 =?utf-8?B?bURFMnUwQm9SVWx4OElTcGQ1Um12NEZhbFBpbU5ybXVSS3NyTldRMXZWQ01E?=
 =?utf-8?B?c0FPR0Ewd1MwOWNjTmZ4eWdUVWF4SWVaQi9LVG52Q3g3b3lkUFlDRGpKL0Za?=
 =?utf-8?B?Snl4ZGc4QTAyeVQ2aDROckZ4TXBmNm0zVkJWdy9QNG9UbGU1SEErTlZaNUZV?=
 =?utf-8?B?OWUyWmpxWm9kVHBUWmFpYi82TVVUKzhWdW40Sk1pQ0dpS1FtdDhIenJoTFZr?=
 =?utf-8?B?UFB3YytWYWVaQUs1V2pMeUNHZC83amxDK1Z6OThUcWxLQm9tdWJpaHRyVGRa?=
 =?utf-8?B?MjNQbGpDWGpJSFpzcXhQQ3ZWcml1ZzMvb245Zmp4RWZQY0JrUGxHdlg2WjYv?=
 =?utf-8?B?VGY5NkgxRjFUU0xFL09WdHVIV0RITnFpQ2s2bW1PMmt2bVVTYy9ZdjQ2emdC?=
 =?utf-8?B?c3R4NmVtUmluUEZ5bEtYdUg1b0dSNVp4bU9sUHQ0UG56N2Jrb1ZuMTVrMFEz?=
 =?utf-8?B?MkIvekpNQVErNjl1NEdBVlNxQ1lYSXc2aTZxbEI0WGVVY3YvbE1nVDM0dEVa?=
 =?utf-8?B?SFV1YUFUbWdndVRkUVNGMzdjWklGYkFUUExRVGZBbDhwYUxQRjVaK09hQ2x4?=
 =?utf-8?Q?gN9HdVbgX+y0aetAE9SGHGuIg?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0077ff9c-68c4-4e2e-69a5-08da65640e42
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 06:42:43.8746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ECnMLhUUCBUd/cQruICWQj8CRfQEKGviMlQ7RiJQh7BKcg1DTkOu/bsNzh64YvUu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1328
X-Proofpoint-ORIG-GUID: LgkdR2nZyH0pSdPACA6ARAU6Vxt3JScr
X-Proofpoint-GUID: LgkdR2nZyH0pSdPACA6ARAU6Vxt3JScr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-14_04,2022-07-13_03,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/13/22 11:00 PM, Andrii Nakryiko wrote:
> On Wed, Jul 13, 2022 at 3:37 PM Indu Bhagat <indu.bhagat@oracle.com> wrote:
>>
>> The vlen bits in the BTF type of kind BTF_KIND_FUNC are used to convey the
>> linkage information for functions.
>>
>> Signed-off-by: Indu Bhagat <indu.bhagat@oracle.com>
>> ---
>>   Documentation/bpf/btf.rst | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
>> index f49aeef62d0c..b3a9d5ac882c 100644
>> --- a/Documentation/bpf/btf.rst
>> +++ b/Documentation/bpf/btf.rst
>> @@ -369,7 +369,7 @@ No additional type data follow ``btf_type``.
>>     * ``name_off``: offset to a valid C identifier
>>     * ``info.kind_flag``: 0
>>     * ``info.kind``: BTF_KIND_FUNC
>> -  * ``info.vlen``: 0
>> +  * ``info.vlen``: linkage information (static=0, global=1)
> 
> there is also extern=2, but I think we should just refer to enum
> btf_func_linkage, defined in UAPI (include/uapi/linux/btf.h) ?

Currently kernel rejects extern=2. In kernel btf.c, we have

         if (btf_type_vlen(t) > BTF_FUNC_GLOBAL) {
                 btf_verifier_log_type(env, t, "Invalid func linkage");
                 return -EINVAL;
         }

and extern=2 will cause btf loading failure.

The BTF_FUNC_EXTERN is generated when you call an extern *global*
function. I suspect that during static linking, all these
extern globals should become true global/static functions and
not extern func's any more so kernel is okay.

So looks like it is worthwhile to mention that BTF_KIND_FUNC
supports all three modes as specified in enum btf_func_linkage.
But only static/global is supported in the kernel.

> 
>>     * ``type``: a BTF_KIND_FUNC_PROTO type
>>
>>   No additional type data follow ``btf_type``.
>> --
>> 2.31.1
>>
