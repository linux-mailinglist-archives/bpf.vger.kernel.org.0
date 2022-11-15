Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047DA62A356
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 21:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238491AbiKOUtN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 15:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237900AbiKOUtA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 15:49:00 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA40A47B
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 12:48:56 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2AFJoosb022765;
        Tue, 15 Nov 2022 12:48:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=fNmWUpqvDreGuda2EX44xTB3VxWiMqDaWUtf0lqMtFQ=;
 b=LSUv+89a+OSQzVq97BT78CEVcJCqAVQXxg3Q7/VN0JFZCyZ0g7+y/KJK3xliFRfyAQvU
 Vx9Dsm6ZXyNwoqME6uaT0Rb2LPu+5mDEKqLy8NSeWKIYB0rNKBNo1mSnyP5i61bJq554
 Ia8o5bUSzWUKxXgTjhF+9zwFpb6z57zH0SwVeOpkF1jpb5Kv/4t3dQJJL2GNVxQI+qyG
 I1pV5gPYIJamkE8hTERwdlu1RjvFyBkmgQfLh6JX1IXpfxMhcMpLOu8LeMgscOoyUZJT
 7NUUdqXKGdBPLBC/k/lAR4amLJRsDOqy9KfhZT0lWitBlAX0B7d9SbMQZfu1sw/Pylrf xQ== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by m0089730.ppops.net (PPS) with ESMTPS id 3kvex99sb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 12:48:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlTNLKZRTTAvMIh+IyjwihN6+bx5NkE2VToodF90r6QPS6jdPgr+I3pDLV0HGZDAfNOcqlRuAnbJgnDL20fJya+yS0DOGrM7uVx8wnZWmJ2TidFZ4LRD2FOtZjvmTKHbU+G3beuiwxmsc2kQxjGTxIS/0GCY3kB+k9EG2nJ1jT6GFDGynaD+XZgK+hBKgGi3HyOeSaf7990q/z0rIo3MtLxxs0flQxyAD+NGnYIQ1YxBnbvUz7kA4PJgz/d3xHuGMwWLD6F0d0QTNzskWWn4kkiBDooiRBPINxiLS+i/Zb/A/lbilSuMN5pmmYMoGM2A3VUd2978SS6FqbJ4sJSGYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNmWUpqvDreGuda2EX44xTB3VxWiMqDaWUtf0lqMtFQ=;
 b=VKJYgo/pYocg7vBIj+Tg/SysGcQ3vZ6wgE/YWgq0TVSt8+1n1Kk1lOeKZM2PmzIZfA3TqcSlFWptxSfzjL5AzZ7R1NdMXH5aXazlVMAG26SPtZoroREQIRLLAHtdgdsWW0BCqFbgwuPUozUUR+jy66WPJWvKj7FfY5C9MmfPV+ZcfTJwmhKZyF/WRZEzAF3NyFsGYOxrXXlhtkPMcTY4OIj5tKCqW6IOacfDQ7/H8XSyDdSoO0pshfefUhYFCTL67SvM81497q8wwOIG081+NRjzmwDngnefV6qYKo+fi2YMJBBsAmZtEredu3FrriJDNGvKt2nJK5gvFrw88q4pvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN2PR15MB3085.namprd15.prod.outlook.com (2603:10b6:208:f3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Tue, 15 Nov
 2022 20:48:38 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519%7]) with mapi id 15.20.5813.013; Tue, 15 Nov 2022
 20:48:38 +0000
Message-ID: <60f459a0-1c97-d812-c15b-304e38b75ae6@meta.com>
Date:   Tue, 15 Nov 2022 12:48:34 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH bpf-next v3 1/3] libbpf:
 __attribute__((btf_decl_tag("..."))) for btf dump in C format
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
To:     Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
References: <20221110144320.1075367-1-eddyz87@gmail.com>
 <20221110144320.1075367-2-eddyz87@gmail.com>
 <CAEf4Bzbnd2UOT9Mko+0Yf9Kgsn-sGsV43MKExYjEaYbWg0WgZg@mail.gmail.com>
 <3d638bd465fb604ef01c1dc5a5a92617b90482d8.camel@gmail.com>
 <f9ce1bd5-355c-0026-766f-59c3711a58c7@meta.com>
In-Reply-To: <f9ce1bd5-355c-0026-766f-59c3711a58c7@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BYAPR08CA0053.namprd08.prod.outlook.com
 (2603:10b6:a03:117::30) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MN2PR15MB3085:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f8ab991-ca98-452b-5eb8-08dac74ac56f
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: StHxhaEROhWA212giDl4RIEDg5h/0XslQ7b8PbJ5AfStQ7maqwXwafzVMpqYX/3r/2435aFJ3n0LXurE4+km+EFmpQLq0ex0XfVwxqKhe9zthZyvyMlNfUIDHAfhvW0xWxIplUKv/c+xsEVxKZP0ee0jYKYyDHTi629H8OW/mG8Z23zVX1fPa+Y5Wa7CpxD01uSH/LIpM5uj14bG4r6uAx8ZZ/shN5aRFWk3y72mOVK3ri5BQn3FSttyCsT0llwRJkpG3Zbj+Vf9RvmGSXgPazvY1rDEnKK03AI/3GU6g83HgBvdSzc993b77k5IOxp0wBu3t5BKh+yVHcvcRr4PtqgA7vRZitPcXb7gH5OSEbQMtFqBkGf4Ej7Waps9sOT5S6gnwRAnntv42pbCgl5dmHh+d9+/J1UDf3NfReAcER2D5IaQflYHbDuKUaQMV5wQZa1XWpQhCvMdlY1Cjcq2J+ORKvUYMgFTRtaNJHTkIsRZUt5LeeZhPoPb81fOGyyP5XkomWYi2aJ4OK1vSTkhWusTGjCbWCY7JeUXg9wR2FwXankohueSPdRJlZtwXzVGRWHraju3aZ3IDFEwzlFRpJpowqA28IZZVoIt7GS0DohzkyaADfcGesS6KFxWtMBHIqx59Q9KdtUmYnwzqlOdBDuyZtC3Pf1z2xQw3wNW+8vh/A/9Ms/M8zxbDsinn55kqzY/M5HgZiTxDmXw5Xb7QjUf190h62IkOX2dl18v2m0uv1ACHTGqAsji/XAWRX6phGOuiCmlT3hXYr8eOCTTXyBIdyCrdtGz0I2PLcUtfKq3kdNOwlnOEJt0+f//P68hRB0hqnhELGJ1LcgN4H3pQp5l+Y1TplCRMB1wlApUJGJLXGBKVD2uHtQFiBZdfZPz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199015)(36756003)(86362001)(186003)(31696002)(53546011)(6506007)(6666004)(6512007)(2616005)(38100700002)(8936002)(66946007)(4326008)(66476007)(66556008)(8676002)(5660300002)(41300700001)(2906002)(6486002)(966005)(478600001)(316002)(110136005)(31686004)(4001150100001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnFSVXh6TitZMHlxc2RhVnQyWmFHUWlkV0Q3dmJ6SmhLb2VkeHNKR1RnOGtw?=
 =?utf-8?B?T3R5Rjh1WmF0ZVNNeVlUb0lWdjg5a3hZOWNhNUZ3YmJqMW85M0xQQmlqM3RQ?=
 =?utf-8?B?ajJCdG11c09XcGRXZ0s2K1hzTjV2NmhFZ0dQNFdqU0dFN2J4RFRUUzhPQmtl?=
 =?utf-8?B?REVLTHFXdmtpdld2RE5MK2d1TXQ1eDc0MXg5cTdKbGRzcW1CRmNIOUx0OGJL?=
 =?utf-8?B?eUpMNGsybm13U2ErOVEwblJGTldpeEJBYnl4bU4yM0ozV2gyUU94cVNKSUNH?=
 =?utf-8?B?bzBrb3lyUjROdmp2NXhITFBGRVo5QlN5UDk3a2hpa25KTmU5dm9lT2pDcCtv?=
 =?utf-8?B?M3lJNGtFLzdyWWZaR1RoSElLL1lpN1dva1VzcHBuYVFkN3NZWnJTRExDQ0Ny?=
 =?utf-8?B?TE1hWi9PYkE2U3IxNGE0bWVIcGNaR1h5U2ZMNGJSZzdHaDJwd041NlFsTmNI?=
 =?utf-8?B?RHU3ZThyMUdWeFJtSVJHY3plc0ZHdnJPUHo1VmYrZFU5c1MxbVU3UnNmS3Jt?=
 =?utf-8?B?YmxkK2YrQ3IwMmtGYk9JdGdwOXJYb3dDWHp1MmhFMlN3RDFtVVJEZFQraEwz?=
 =?utf-8?B?SEI2K05oYmxOSVFDK0xyVzh3VzhtaWlEUWhQRVhpWnpUa0pnQkdEY29QYlZl?=
 =?utf-8?B?N3dRWHNwVEVFc1ZOdHV6bVhaQ09QUVhxS0haL0hTdXhCblJjNGRNajlkWEgw?=
 =?utf-8?B?Ky9tYXJLdXRRY0tLRnVjVC8rcjIwY0w5Qk1YM1dxakwxbVp4NGt0dFdpUGZn?=
 =?utf-8?B?Y3E1Z2t4emZETVdvWEtuMGp1Tkx0VmRlbldhWWpEWFhtTkMwRjdrYkdpU0pX?=
 =?utf-8?B?Qm5jZlUvaTc2a1FHaWVFa0FPaVdPMGgwY29hYjVjV1lUMkgvUXFTdTlVZWp1?=
 =?utf-8?B?aFFQc2JweEo3cjJ3L01Wc1h3SHltSU84OTB0SGtxS242RndTYlRmb1NiYTB0?=
 =?utf-8?B?REkwYnBrdlVtZWhrYjRHQ1RuTTBzQ1pYeVIrV296blRGOGV0d28rMmpnRy8w?=
 =?utf-8?B?THpqUFR4QlROTHZsM0RuVnlleHRmZk1zUTFJOU1Ndjc2WUZtNmVyMWx3Zm5S?=
 =?utf-8?B?eG5aTnhPZVF6Nis0dms1bGljVFpDWk5qdEF2UWx6anM5U0I3R09PMjJTY2Y4?=
 =?utf-8?B?L0wxZmJkVDZBZEN1UzRKcmhINWFadmppbW82MTVXVTJqWmRUdXQ2RjA1aVA3?=
 =?utf-8?B?T3kyOEljQnBGUzF0M2lPZjVwS2pHV2w4WFR1eFU5WHV0UVYzY0hKQisvMExR?=
 =?utf-8?B?U3VlcVF3SXEyNWJJblF4ZkdDSSt5U2dYVWZnTmlCWjhIUDJZM1FwU2xJQWJr?=
 =?utf-8?B?YVRjMzJUOEVPY0VtYmhxdHAzK2pTZWhCcDFkSGJpVE56am0yaXdmTDVZNnlw?=
 =?utf-8?B?MXpyMjJtQUpIckRGTWorVWd1UHpldzVVMnI0RlhpUk5TdUErL1dKSXFBVmVY?=
 =?utf-8?B?MWQ2d3QxTzBJRjhFSEp3bUsyU21QY0ZKNndnNytpTytjQ0ZNU1Uwa1ZjMURi?=
 =?utf-8?B?NlZycGl4cHpDMmtDQ3RhY0JkNE5xYjlaOU5MbzJVdDFUMS9DbnFOcEIvMDAr?=
 =?utf-8?B?UU44OVhiYnhJM21CUnlJS1ZBaHdwYXBnTUl5UkdMUStZU2lHS2tVTW55ZmtR?=
 =?utf-8?B?SG5UZWlhRFhxR0JjS3JhTmRjZXRITWFaRVFocmk0QzhUUVRrbWdWR3hiQTVm?=
 =?utf-8?B?ZDV0K3JHbzVuOHFNaTQzT3I0MVZ6ZjBZWEtMV2ZUdVNNbitONDdlakQvK0oz?=
 =?utf-8?B?REZtWmkwNnltNW5iRGdxS3dTUkQ4Q1d2eFBXYktNYlljbXpoMkRxUG5ZSXBP?=
 =?utf-8?B?c21oSFBDSXpuTzc3OTZnTW5ncFdSNUJXYlhJOWhjVEJQWHBUUzQ2UHcvTUti?=
 =?utf-8?B?WHE3ZDBST2RiYWM5Und0OE9Wd1NkM1ByYzFtZ3AwamlDYURzSUtOTElwb01m?=
 =?utf-8?B?UzlFNnBQenFNeW1jM3cvZzM1LzJsWENCbTRMeUlzZjZQVTRmSXIvVVJLZU9R?=
 =?utf-8?B?b1NNUTFWci9qRTA3cjY4ck5rdDVkSTJYLzhhcW9nZlB6VEZiVkliZHVrQkdB?=
 =?utf-8?B?NVdPYTJia2F0SmJPQjM4bVRIVUsvSGgzbWYzSkVSdFUwVHZUOGNkTU9jWGRH?=
 =?utf-8?B?S3grc0tFdzdSWWVwUG9PeDh5eWkwY2dmdU11dlJibU9OV0JHb3Z6UHI4RDQ2?=
 =?utf-8?B?RFE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8ab991-ca98-452b-5eb8-08dac74ac56f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 20:48:38.1201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PqIRkrDtm5atonrPJEXT2Rv7z7pJaw9H58tUFijPV2BNFlrFOZuMfylNgd4VVQhb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3085
X-Proofpoint-ORIG-GUID: QaLE7U-gS9G08W1RaLqg-8kUlwGaiH_k
X-Proofpoint-GUID: QaLE7U-gS9G08W1RaLqg-8kUlwGaiH_k
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/15/22 12:45 PM, Yonghong Song wrote:
> 
> 
> On 11/11/22 1:30 PM, Eduard Zingerman wrote:
>> On Fri, 2022-11-11 at 10:58 -0800, Andrii Nakryiko wrote:
>>> On Thu, Nov 10, 2022 at 6:43 AM Eduard Zingerman <eddyz87@gmail.com> 
>>> wrote:
>>>
>>>
>>> [...]
>>>
>>>>   static int btf_dump_push_decl_stack_id(struct btf_dump *d, __u32 id)
>>>> @@ -1438,9 +1593,12 @@ static void btf_dump_emit_type_chain(struct 
>>>> btf_dump *d,
>>>>                  }
>>>>                  case BTF_KIND_FUNC_PROTO: {
>>>>                          const struct btf_param *p = btf_params(t);
>>>> +                       struct decl_tag_array *decl_tags = NULL;
>>>>                          __u16 vlen = btf_vlen(t);
>>>>                          int i;
>>>>
>>>> +                       hashmap__find(d->decl_tags, id, &decl_tags);
>>>> +
>>>>                          /*
>>>>                           * GCC emits extra volatile qualifier for
>>>>                           * __attribute__((noreturn)) function 
>>>> pointers. Clang
>>>
>>> should there be btf_dump_emit_decl_tags(d, decl_tags, -1) somewhere
>>> here to emit tags of FUNC_PROTO itself?
>>
>> Actually, I have not found a way to attach decl tag to a FUNC_PROTO 
>> itself:
>>
>>    typedef void (*fn)(void) __decl_tag("..."); // here tag is attached 
>> to typedef
>>    struct foo {
>>      void (*fn)(void) __decl_tag("..."); // here tag is attached to a 
>> foo.fn field
>>    }
>>    void foo(void (*fn)(void) __decl_tag("...")); // here tag is 
>> attached to FUNC foo
>>                                                  // parameter but 
>> should probably
>>                                                  // be attached to
>>                                                  // FUNC_PROTO 
>> parameter instead.
>>
>> Also, I think that Yonghong had reservations about decl tags attached to
>> FUNC_PROTO parameters.
>> Yonghong, could you please comment?
> 
> Currently, btf decl tag is not supported to attach FUNC_PROTO 
> parameters. We could add support in clang, do we have an actual use case
> for this? if there is a use case, we can add support for it.
> 
>>
>>>
>>>> @@ -1481,6 +1639,7 @@ static void btf_dump_emit_type_chain(struct 
>>>> btf_dump *d,
>>>>
>>>>                                  name = btf_name_of(d, p->name_off);
>>>>                                  btf_dump_emit_type_decl(d, p->type, 
>>>> name, lvl);
>>>> +                               btf_dump_emit_decl_tags(d, 
>>>> decl_tags, i);
>>>>                          }
>>>>
>>>>                          btf_dump_printf(d, ")");
>>>> @@ -1896,6 +2055,7 @@ static int btf_dump_var_data(struct btf_dump *d,
>>>>                               const void *data)
>>>>   {
>>>>          enum btf_func_linkage linkage = btf_var(v)->linkage;
>>>> +       struct decl_tag_array *decl_tags = NULL;
>>>>          const struct btf_type *t;
>>>>          const char *l;
>>>>          __u32 type_id;
>>>> @@ -1920,7 +2080,10 @@ static int btf_dump_var_data(struct btf_dump *d,
>>>>          type_id = v->type;
>>>>          t = btf__type_by_id(d->btf, type_id);
>>>>          btf_dump_emit_type_cast(d, type_id, false);
>>>> -       btf_dump_printf(d, " %s = ", btf_name_of(d, v->name_off));
>>>> +       btf_dump_printf(d, " %s", btf_name_of(d, v->name_off));
>>>> +       hashmap__find(d->decl_tags, id, &decl_tags);
>>>> +       btf_dump_emit_decl_tags(d, decl_tags, -1);
>>>> +       btf_dump_printf(d, " = ");
>>>>          return btf_dump_dump_type_data(d, NULL, t, type_id, data, 
>>>> 0, 0);
>>>>   }
>>>>
>>>> @@ -2421,6 +2584,8 @@ int btf_dump__dump_type_data(struct btf_dump 
>>>> *d, __u32 id,
>>>>          d->typed_dump->skip_names = OPTS_GET(opts, skip_names, false);
>>>>          d->typed_dump->emit_zeroes = OPTS_GET(opts, emit_zeroes, 
>>>> false);
>>>>
>>>> +       btf_dump_assign_decl_tags(d);
>>>> +
>>>
>>> I'm actually not sure we want those tags on binary data dump.
>>> Generally data dump is not type definition dump, so this seems
>>> unnecessary, it will just distract from data itself. Let's drop it for
>>> now? If there would be a need we can add it easily later.
>>
>> Well, this is the only place where VARs are processed, removing this code
>> would make the second patch in a series useless.
>> But I like my second patch in a series :) should I just drop it?
>> I can extract it as a separate series and simplify some of the existing
>> data dump tests.

BTW, current use case of decl tag in the kernel is from Kumar's link 
list patch set:

https://lore.kernel.org/bpf/20221114191547.1694267-23-memxor@gmail.com/

+#define __contains(name, node) __attribute__((btf_decl_tag("contains:" 
#name ":" #node)))

to tag the struct member bpf_list_head as below:

struct foo {
	struct bpf_list_node node;
	int data;
};

struct map_value {
	struct bpf_list_head head __contains(foo, node);
};

https://lore.kernel.org/bpf/20221114191547.1694267-5-memxor@gmail.com/

>>
>>>
>>>>          ret = btf_dump_dump_type_data(d, NULL, t, id, data, 0, 0);
>>>>
>>>>          d->typed_dump = NULL;
>>>> -- 
>>>> 2.34.1
>>>>
>>
