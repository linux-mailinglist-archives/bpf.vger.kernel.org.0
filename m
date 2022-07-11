Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3810E56D23C
	for <lists+bpf@lfdr.de>; Mon, 11 Jul 2022 02:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiGKAjU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 10 Jul 2022 20:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiGKAjT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 10 Jul 2022 20:39:19 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C365A189;
        Sun, 10 Jul 2022 17:39:19 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26ALp9N3030672;
        Sun, 10 Jul 2022 17:38:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=5oIEK7Kmr9SiuSsATpxQkYAcfkjey/DWiIgYNeOBOo0=;
 b=XDflCWMGoeeal0MaPzAF6kuMxcwbdGHGrvWRZV5DbYVlv1+lbINWCPH+j+gLzw1ZjOSu
 qFRoUR0WzzWr1+CQ+C6pNkbye8SQZgZIQpwMBl6O+QU4rzP2gYsPoemD2FezW5w7Dk2P
 uBk3ijV21qpCawPPLl31FtBhdgBVZLLg0ww= 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h76sre9bk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 Jul 2022 17:38:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QioPpy97aSsKOSQmDniPtJxWfQXYrlrmLL616qE9SXLIKXDfCctbpg5kHJDO6/qjTzVoixcddIQ+ow4n8747MnNS0nZRxsKQpTzA5VEIXiVPly2HnDKLe6sbjFNHnB9QBvCl9/ia3MZgkKCnfUs5YT+THCSWy/zJV7cmiZZaZ5GG2wYJkTcJPQEf4QR8sO97fcjOKW7OfARrPRoDR8TQ4uDdDt4qqc8XRT9ydoFK6uMcVmPkPyO3ZoYT3pVc5leh2BFnkperPN3nk3btcINXaX7IBUYYfAUqCiaMUZ/krhorGkIpkkKW8o0IsjsNTMZAbKyhPCZbvjvpuXbAlgtRYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oIEK7Kmr9SiuSsATpxQkYAcfkjey/DWiIgYNeOBOo0=;
 b=DsOCxWW3yQO9NnWJR1xM+fIiqqxbuQuN/IlWTXAgEVzmFgUcuLnJBSeMa+hj1fMIidLkaRH8vn9Nzf1XW2OC81KtXA5Rh4d1C2c5E8Ip+ECAH6t4XizX2D8mfH0fItHMlcMUuZKXfYwy6gZOnjN5h4N68IplnFcitSMUUwpDySTaz83g2LmGFnOiQ7tWMaDIV6DBD4zp1mpmdOPW5yFFMyyHkqA9C5MQQ/dDnpMzT7ErNra+LdbCnpls5HZlevO3BPRkLm3rFeovtf4TOnB4L+kBr1NNRU3xTvnGF0dVnZHqRM6Jb2QwnL9w+HsQoxH6cqsSDVquckGTKK5LuQPQ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN6PR15MB1395.namprd15.prod.outlook.com (2603:10b6:404:c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Mon, 11 Jul
 2022 00:38:53 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 00:38:53 +0000
Message-ID: <eafd8d7b-4aea-9ec0-6e3f-8e0afb290235@fb.com>
Date:   Sun, 10 Jul 2022 17:38:50 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH bpf-next] bpf: fix 'dubious one-bit signed bitfield'
 warnings
Content-Language: en-US
To:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>
Cc:     mptcp@lists.linux.dev, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220710083523.1620722-1-matthieu.baerts@tessares.net>
 <fd51d0bb-8908-ede1-6d7a-37ed82badebf@fb.com>
 <428689f2-ad91-e1b4-64c5-c1c4802e2cbe@tessares.net>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <428689f2-ad91-e1b4-64c5-c1c4802e2cbe@tessares.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::12) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0944b4e2-51f7-42c7-5f87-08da62d5bad4
X-MS-TrafficTypeDiagnostic: BN6PR15MB1395:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xHj4jl2nJuBmZri6zl4Wqv7WXOn0gFWG3NKZlIENOKVbkH4zcK5UjQ4JPdZgEYM3x0AM+4us/Z3AHZP9IGgQnMSjl/pIu9rPYua8kHBqa8W4wMh4XJmw1jDacEvQTq+g/0eUjTcYEB7r2Zi9neG7OURtcCap6ReaimBCp4ikKmXqaQ9L4PsEKeSTqSQRQnWjd+Ucgd5iZMV3Bh8AynVKx7vo0QLFd5EZq4mHk0+JudlJY5a02FpaXFWm1vHt9MHWEbQyxUpz8MYb4ysPXGIlacNtpUG0ZeDzWETZPYmnlci6Am/7nR+QZwJa1WmF1PbUF9V9CdFz+5zs9IbUQYoRuH+WvQQtMVAI8ecGUalL/JCvLCOQdeaa7hvekjvzD7r9lrXxAW+RBxx0iAYMYkt86dibBSwW99FD81JWuvR+EvoCox622V5wKGaqeGiuwnLddhMCO61Ath780JoJeZTp+/grOeyVEDOC/+sqsWA4xvsMxU9Zezr/nZBR03gktohRttY1SSgfW42nuvZoq2OUpwime1s/R5XIOVyehIk6LgPcAv7D+qhmd+1YisLZThHgK28uzqjb+K0oNPzkjp3MRLhj9aWk/mW5oOIhRwWTyAWpGGajbuKwVCHrfxj2zBWT+Lll9swuflVYXrEwcDrkAj2DHa697kea4Qe05E6raTyZODnJf/tpkkReYSqddjnWhqI16emU1zgTk89xxVwAZ+onxFGGck8xxl6VY2xdbbrDxl9kfgxd9HU3IilW+rw3uR5yw2a0ShUrgz5SUER8e6/0qz+95XiXcXEi56umQI6pQUnEHoL7dGisxKuZb5yOKXPnSimYWBvZZT76PHUc1i3iTlW/B/MZP9l9bc9bslDH5KXjzhSiPC1EN2bqOVxg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(478600001)(36756003)(110136005)(53546011)(6506007)(186003)(2616005)(6512007)(316002)(41300700001)(6486002)(31686004)(2906002)(86362001)(38100700002)(921005)(66476007)(66556008)(8676002)(66946007)(7416002)(5660300002)(31696002)(8936002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVM5NFlSRFNydE5OcFpKUkRFcS9zTnhUSXpDVFdscWRzMmJlNGo0MXNpeGNW?=
 =?utf-8?B?SnVObkh2Y0lXNngwU3JmWkhNbTNpT1Q5MDJJTzNzRHNOSWtocHkzUU1iSUdj?=
 =?utf-8?B?SzdyTDFzc2I1ekI4YTViS1EyYWY3T2pWY1JHRjBtVjdDR3QwR2loemxzSjI4?=
 =?utf-8?B?UHhBc1BtanpDcGNzcUd0MkxJdXVsWEtMMFJQdkJOTGpRcWN5c0NraURiQTFT?=
 =?utf-8?B?TUIyZW1lM1hKMFozQTdLNUJUdFJkdlR2a2JzOEdVUmNGRDA5bFFmR0M2VE9W?=
 =?utf-8?B?S1dlc2c4MFhnaWtVRnlNc01aQ3pnSExhWHNTY1lxcE5VMjM0aE5PL01ScVpj?=
 =?utf-8?B?MXRVZ01KVFJybFRydUJ3dkR3UDhYbHZiRzY3UnZacXFHZ3BMSDQ4NnFWb0hS?=
 =?utf-8?B?eDBsUkw5YTVqbS93d2IrUVI0S3dTLzcwdmhjek5YUUtpNHl6cjlBWENZRDBZ?=
 =?utf-8?B?SXRJSEZWY01RQW9lUTdyY2p1dmlncFJoRm53WGxUbUppNW92RGxSanJWWDJh?=
 =?utf-8?B?V0Y1S09MNU94a0txdnVmOUgyUHRVMlIySmtTS0M3RXdrWVdYTHY4d1NjS05Q?=
 =?utf-8?B?WU5uNjFCS1hITGFsOE5MY2NYOFZrTXp1Zzg2bFdORXpJaHRhRnlrM1pmNEFq?=
 =?utf-8?B?Znp5RDBOM3RsemQwemRkU2ljT1VFYmRMVWtvcmlIRzN6aVFza243ZmhzbG85?=
 =?utf-8?B?U0QwN3J1ZXB2a1Q5N0FxemZOOU1yR0VwUUgzKzFoZXh2eXgwd3lkN1g1SS9r?=
 =?utf-8?B?ZHp6MmpiWjZ1TkZsNEdoKy83UHJHTFQ0WGhJVkNnaHlTYWJHVUJMR0F1TVJK?=
 =?utf-8?B?cjdEandrMTd6NGFmajVHOVVvRm9sQVB0Y1QzVjdYbFlYNmRoaTZuckplZkxh?=
 =?utf-8?B?SzU3cjMwRDhrOVNudE1qdkxsYnAyTEdkdmtnUzMxbzYrR0w1N2J0dlc0T2lU?=
 =?utf-8?B?VTZDelpVNmNsaFBTeXBtcEQrWGZ1Q2VEUWI0YkdkM3hndzU3MjM3ZkRmVDFU?=
 =?utf-8?B?cWVoeFh3cG85R0pTR0k0OVkzU0c1dzBPY3hKU29wUUtncWF5d1ZKbUIxMDJq?=
 =?utf-8?B?Q2JGN0JqdGhDSVN2eFpZTHNVbEg2L2tzeWpTTWY4djJDZnJtcEJ0akQwRmRt?=
 =?utf-8?B?UFNSc24xQ2F4b3VVTS9VZDEzQ1JTOG9ZVERyTzRYRzdQdm4yYlZtVlhhTFBk?=
 =?utf-8?B?TVFrNC93ay9aOGJPcFVNdmkvdkNjcitqMlA4OW8wanpGbVdPNG1mK2NjajlU?=
 =?utf-8?B?ckJDRndNU1F5ZnptNEFvaHV2VWV4bTAzQ0kzTFVlYTlFOC9uTHNON1hzTUhN?=
 =?utf-8?B?MHVOR3JDRlJJYUpkYjV0KzRISnIra2k0QTE1VjVZTzVhaTB1VUwwakVGVTNk?=
 =?utf-8?B?U1pjL1AxcVJ0ZFVoN3JuZHYzZWRZYWJPTXpQMmU4RGNEQkF2RzVLL1NiRDEw?=
 =?utf-8?B?TEkzVFordFU0aHlQOTZUbndmaXlDb2lYUmpZbng0RmwyN2lPMDU1RkxBRmJw?=
 =?utf-8?B?UzNzdGZ5bzRhblp5U2ZDSHhSakN1WCtRYzhsckVFMURGaGxMSHVoNFIxdjA1?=
 =?utf-8?B?Ukh6SzgrQmJNdkZyN25Ma0tiVXNIS3dpMExsWGNuMGV2Z3FybDRVdjhBM3BH?=
 =?utf-8?B?OW1XMzNzNnZ0aEI1VmhZSFJScGdDM05yK2tCOEhJRGNjTjNKcmt5Q3g4ZVNL?=
 =?utf-8?B?TG1jL2d3eTZMWkg0eXFOTi8vNmR0TGE4UUFwWndaQng0bW53RFpTakR2b08y?=
 =?utf-8?B?MVpCcnR6WUhiNEs3aXVQNHplUG12dHptUGg3S2FmK1M0bDZkVFVRcE81THdk?=
 =?utf-8?B?TUtjTEpBYVJscHZ5ckNKcVZEbXh4VVI5YXVxeW9GSkRmd25NeE1Ja3RNTWls?=
 =?utf-8?B?NmF5a1lDdkZKKzYxc0l2N3hIWXBEUWRZclJpenFHN3hHV0l0bmw4eCtGcmY5?=
 =?utf-8?B?S0VPZUMvcmVWT2MrMEkrcmFHMzhDSjQyck5lUDVTZVQ5MExMTGhWR1NmTTIr?=
 =?utf-8?B?VjRpeGN6b1BtVUk0SXlKNU9BUTYvN3ZXaHBOR0xyZTluNDF1TklmbGVIV0d6?=
 =?utf-8?B?dGdGODJ5M0U5bkpYK01vM210ZjZON0s2NHg1TkJicXZKTzVuYlppb1FYemhU?=
 =?utf-8?B?d29uVnJ0d0xBaDh5MXR5byttMUZIS1h2UStock9zRmhVbGExdlF1WVliM3Jv?=
 =?utf-8?B?UVE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0944b4e2-51f7-42c7-5f87-08da62d5bad4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 00:38:52.9632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHh+Js55Yw9Nfzk+tgenCcuramMd64/mUYn3RivuZbaCzgOOYFb0XHSKCr2plOvP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1395
X-Proofpoint-ORIG-GUID: VxQxVZDCQ5IkUljYpDjI8SIrDbIIsQzu
X-Proofpoint-GUID: VxQxVZDCQ5IkUljYpDjI8SIrDbIIsQzu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-10_18,2022-07-08_01,2022-06-22_01
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



On 7/10/22 1:19 PM, Matthieu Baerts wrote:
> Hi Yonghong,
> 
> Thank you for the review!
> 
> On 10/07/2022 18:59, Yonghong Song wrote:> On 7/10/22 1:35 AM, Matthieu
> Baerts wrote:
>>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>>> index 81b19669efba..2ac424641cc3 100644
>>> --- a/include/linux/bpf_verifier.h
>>> +++ b/include/linux/bpf_verifier.h
>>> @@ -345,10 +345,10 @@ struct bpf_verifier_state_list {
>>>    };
>>>      struct bpf_loop_inline_state {
>>> -    int initialized:1; /* set to true upon first entry */
>>> -    int fit_for_inline:1; /* true if callback function is the same
>>> -                   * at each call and flags are always zero
>>> -                   */
>>> +    bool initialized; /* set to true upon first entry */
>>> +    bool fit_for_inline; /* true if callback function is the same
>>> +                  * at each call and flags are always zero
>>> +                  */
>>
>> I think changing 'int' to 'unsigned' is a better alternative for
>> potentially adding more bitfields in the future. This is also a pattern
>> for many other kernel data structures.
> 
> There was room, I was not sure if it would be OK but I saw 'bool' were
> often used in structures from this bpf_verifier.h file.
> 
> I can of course switch to an unsigned one. I would have picked 'u8' when
> looking at the structures around but any preferences from you?
> 'unsigned', 'unsigned int', 'u8', 'u32'?

The original data structure is
   struct bpf_loop_inline_state {
         int initialized:1; /* set to true upon first entry */
         int fit_for_inline:1; /* true if callback function is the same
                                * at each call and flags are always zero
                                */
         u32 callback_subprogno; /* valid when fit_for_inline is true */
   };

So 'initialized' and 'fit_for_inline' and additional padding will take
4 bytes, so 'unsigned', 'unsigned int', 'u32' should be appropriate 
here. Later, if people want to add a u8 or u16 to utilize the padding,
the type of 'initialized' and 'fit_for_inlined' might be changed to
u8 or u16.

For which of 'unsigned', 'unsigned int', 'u32', checking with
   $ [~/work/bpf-next/include/linux] grep ":1" *.h
both 'unsigned' and 'unsigned int' are used in many places. I don't have
a preference. I saw one instance 'unsigned int' is used in this file,
so 'unsigned int' should be okay here.


> 
> Cheers,
> Matt
