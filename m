Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CF167921A
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 08:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjAXHhf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 02:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjAXHhe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 02:37:34 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EE73E617
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 23:37:33 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30O48FdV018028;
        Mon, 23 Jan 2023 23:37:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=md3wzajq2yOi8/J60EjT0Bq4G3PSJgW7bxlCcUSNGEk=;
 b=W1UDHjJTRZ2d1N3SpeMB9Ztq++gtLEXIJoHtF8Akj9HWy968DUs2vf8O+q/oJh3RGrs9
 +lbHeZj4Mr7vcGIq6xQ5UOrIs+eFo1FvJY2oNWj3PALIvr18lIgtLueko6m8Vq/TaIx/
 XFzL7bE9h8My61YMqiFvGCygCyBkvCwDRxTRO6p7PnTWZYxjJaqJ2QX4Kt6RAKmUn2Py
 btuvi1AoT7R1dW0qIEzixlURzynkF7yjBO46DEvGFfsbH2nHFKydDNJgqJ3N6AUe9bEN
 dyWQMgWaqZGI4xVjzRPi5CPJ+7SUdTMAMoyO00qombPhwYIsI6fIba7tgh1FRuKOnqsH Pg== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3na81ggrba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 23:37:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8cYDfdXj/UmlhUIhX65SuymN054zQjmSXtsYWjNW2vHAoUb8aMy4ycnr+nzq/CA4KiWQ944g0pPcvZPskYr3Da60x9QeSksu67FDzAI2T3KFOKhy67hPHM5wPQHhFDUHfU6unwIHNO60K60k97HXC1STHFXUFAYERq82rW/Upo2EeRfWFKdpMGpKLZqlq48I5C6zRVAAuamZQGb6p5VsAu1xk/6scQLiZbUnxGbi2UWwmrFbVAn5ZM5f95Sn9wpUuK2dFYU01lj7FQZOXrpTaeHKcqQtOfC43Tkr0TwG+2qTU6/lx+IXo7Br5e90yQkfYAliX02Io7wtuEFsiA6XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywISEoYEvZFKJ14yc5p1CG2k/6cGEW7qn/1Vo6eU0+A=;
 b=UbudYHdbP5Sh01yDbwv2Z7EGacUXiWfjGdf5SNRtLX/M1LMqnb1doHtQ171hNIuvBrG5UptKBLOZ4VLMolm9HTz1Oxv2Z3BvA1mSNEON1I345KsAor36MPQ8K6gqoWNF1PE4dFgQGD6/FBWBHJEbkWYBXu23kuq4S7kR+PEvuUAu8Ti23Jgo5jvk0xw9k45bCLB6rPMUWkobxN2gUMcswIFkEhDPr9vboOdfnAZScdyMbChW+v+J2mzyM2i5jW7nuCSkij3PsTPyy1XQ3mX5bTdpFBVnPvUduZyZ6ffG/HWTwWu4hyqjf9iuumrqUxGo8eUtWyv9MyB44FpHVeM7HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by IA1PR15MB5776.namprd15.prod.outlook.com (2603:10b6:208:3fb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 07:37:21 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18%4]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 07:37:20 +0000
Message-ID: <caefb2e1-bfb1-58fd-b184-ba2afc940127@meta.com>
Date:   Mon, 23 Jan 2023 23:37:16 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: BTF tag support in DWARF (notes for today's BPF Office Hours)
Content-Language: en-US
To:     David Faust <david.faust@oracle.com>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc:     bpf@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Malcolm <dmalcolm@redhat.com>,
        Julia Lawall <julia.lawall@inria.fr>, elena.zannoni@oracle.com
References: <87r0w9jjoq.fsf@oracle.com> <877cy0j0kt.fsf@oracle.com>
 <f3963ae2-2a9c-b8b4-2b19-ebbcc7863b8d@meta.com> <873581i72k.fsf@oracle.com>
 <4281ccc7-99db-69df-6675-5c8b5509abc3@oracle.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <4281ccc7-99db-69df-6675-5c8b5509abc3@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BY3PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::9) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|IA1PR15MB5776:EE_
X-MS-Office365-Filtering-Correlation-Id: a0e4f11e-80a2-4cdf-76c5-08dafdddd355
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ad3d1Rf61hCILHb7SnZ5P2rLK117TQYxSdaRUjELq04WX8ciPjpzMxNgtQCXk0cFpYno9VWAieTS23lCSTXCiJMl7+dv1NfTvT1XpTWoBurZZ/j5IxfaoUw/SFu6NZrs0Ky5C8Lz1hQ6sF1FtIo2Doo95pE5Is/6Xy1/SrOFoV9wNcNAP+7ckC9WPntsvwEIfvMiKWbNjqnqgLYZy0GU6VDG/ajb1ONpLyWQmTvGS0ePA5Z2CeL8UpHP9dxB2BjKz+tQcTHMpXb2B5yZQp1VYeQrid4SlRLfp3iF7ldMPGEeZLlzSTfvJdOb2S6ouymLlbss00jmStngiUYyZolWQDBu0x0WO30UQTZ3AvqV8uyoJ3Q3/yEBKJk5vSE7y+jTnzQjCnDMsugSZHRipjJ6FevBiQYcQcMI+6BrStULjlCmTvzgzejR+Kn2NJZXQYNsrDbuMXyYTZPZkWCto7mWAw+GQsyfFIbPXf3y4O+Y+dFGu5YHXEkuEdJQ6hgMxowf3wXsfc8cEgXAJGhLiZQLwa4D9vTWsbJrEfYGWNxFb2WUfRxYpEMl1Ec3cumX4dfWubB+0f7WVkYFygMVnpch38tvMjHpDxITaWa6+xdddIhUqoMwOLrTJqyuZ6GV0OXWP/9fSrSB4I3DF/cVYzK+hhudvgHJ/pqYhmsTZr2zjf/+kn+H6G9bzOmvkpJMnjCmrhOYhRmig9v5HqYkFlxmgZTBW/oOJP4EQstT9y7wm48MhDEYv8hPpKfJ8AL/UPxb8jJlY21nRytBC3xlJ2l+0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199015)(110136005)(83380400001)(66476007)(66946007)(86362001)(66556008)(8676002)(4326008)(54906003)(53546011)(36756003)(316002)(6506007)(6666004)(186003)(6512007)(966005)(6486002)(478600001)(2616005)(31686004)(8936002)(5660300002)(31696002)(41300700001)(2906002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWkxeDVNZnByU3NPbmlHeG1wZFpqT2tWcjlNT3puMjg1TVRKWXpnMzdURkY5?=
 =?utf-8?B?di92aEQxMVhHUFh2dDZKcnBWTGMrT3c2U0ZyMVc5OFdjYWV2elB2Vy91eTRU?=
 =?utf-8?B?ZCs4cWFrc0RDcnY0aUxsNzZOdnRxeHF0K3JUNUd5T0ZnbXdWcUVpWk1aOG9F?=
 =?utf-8?B?QnhBR0xER1dFOHUwOXJQMDZoR2Vzb1hOL2FnUDVmTU9SRHBpVWJYOGJzK2pp?=
 =?utf-8?B?d0tENlhFTUxnTWJlSTNXVktuYnlVUnptcURmQ3pyVG1hdis2QTVXZEhMZVB4?=
 =?utf-8?B?Y29IdW5GSXVtU3NVN1BSbFJLcWRMOFdxMEhGRzk3Qnk1eVovTWxhK0NNL1BX?=
 =?utf-8?B?RWpGK1J6SzlNbEp2dGVWZGl5YzhvYnFLTEE5V2ZJOXdLazdIYXEzcG5NbElD?=
 =?utf-8?B?ZTcxSDgySTZkTTJ5WERxMmpPa0t1ZWd4LzBYVG53amZxMytMZFBLa1FES2ZW?=
 =?utf-8?B?aG9FN0Y4aEFVdVlEL3JrMm5ISGEzejFBS0taSUdwUzhuWU9RMEpESXFlZjRY?=
 =?utf-8?B?dWo3NlpLV1Y0a1VFR3VnTUFIUFFTOE1qUG15eDRaK1g0OHRGVlRvUy9VY2VG?=
 =?utf-8?B?QTZkNk9GbzlLNC9Sb2F6U1F1aXpxSmV5cWpGamtGYnBvbStibkdsZldxcGZH?=
 =?utf-8?B?RXBpSEpGdWJzV2tkYXRuOThYMno1TzJhc1RSa0NsazBYOXdDUmNKUXJsbmlM?=
 =?utf-8?B?QmtpWUhxWWJYY3hwYjFRbmV5NHhiK090YjVZeW82aTI1YUQ2UTltemZtREVx?=
 =?utf-8?B?NENtRE5YUGxLTS9WZzIvNUxSN29hZ012SGZHVGNuK2JsbnQ5TG93Sy9MVVpP?=
 =?utf-8?B?eXRRTzZEejcwRFl1bjY0R3VYbTFFbnhpbUJyVXZDQUQ3d0ppKzVTTHpBQlVG?=
 =?utf-8?B?Y00wbFVzQnc3MWp6TFFOMHVta0F3cEFRN01HclpZeWFJSk1DRXVGQ20zMWpm?=
 =?utf-8?B?N2lhK0YzclhoZEJqSVRCanEyeDdCMTJwV3ZGS1ZCaXdEUDdSRE5helA0bmJ4?=
 =?utf-8?B?bjdqSEJqa0RlSkhwK3c3aUNML2g1ZkpSbFVZWlI0V1hlenM5T1FIdXRXbG9o?=
 =?utf-8?B?bmFNclVXVlNYMWJJeUttTld6RFJlbEFFemFrU1d6Zkd0eGhHSzl6bUNIdUFV?=
 =?utf-8?B?MXh0c2I2TEhIN3dyek85VDBLR2hwbklnVjZkZGJsc0tnOUFhVTlleWFoY05l?=
 =?utf-8?B?ZHo5NDI2UEI4Si80Sm5HT2hYZjU4TEs0OVRJNGpZeWh1eW1SbTJOYUdHS3l4?=
 =?utf-8?B?emJjMElBM0R1blZTR3RORUpXeUtzRFpJZU1GOTNsdm1JTDdMd1dHdXY1dytJ?=
 =?utf-8?B?SEdNVXBwQmkxZVRSNk5rRGd3MldJQUZMMUR0MVY5NmxqT1RHN0F3VTM4MFp3?=
 =?utf-8?B?YkZGWjRGWVpIRFJ2S1JlMmcvN3loeFpmWUgwMVVQRmE0SGxPR1lPdGtKeDMy?=
 =?utf-8?B?bEN3UHY0dENpWTZUOXZZZ2Z1U0Q1MjJHUWE1RUNRcEYrZlFYQmtudlJtNlBk?=
 =?utf-8?B?QkdGU2wvTmQrNVhoMS9RL1JSSDNOVGJncHFXK2gva1hOUlNFWFQ2TWxDeFpi?=
 =?utf-8?B?VW82VmNZZ21sRFNUME5vSEhpY0h4NXZKNlNIOC9tcXdUdVRWMWpWcjdGaEp0?=
 =?utf-8?B?SW85QjQ4YzNnaGFJL2Mvb0MvZi9LY0lBQUlhd2tLUXdaUmh6KzczV0hYK1pa?=
 =?utf-8?B?TEJVajR4VFpDQUo1YWN1QXNvcVBYZGI5RjBWOXFxVGNVSnZBN1VaVFhxVDBy?=
 =?utf-8?B?UERpdWFxV1F2S3lnRHNnTHp0WnpyWUhNeENwY1lHYlkvU1J4cUZIWkRMbWlW?=
 =?utf-8?B?YTR1Q1ViRDNqR0xNQXcrbzRhOEwxay9KV3N3UncxYTAydjc5MmQzZWtQRzNk?=
 =?utf-8?B?b2pvNDliWDRQWENBbFZqazRVQWJJMExVa3F3VnlxaXFjYmUyaGZHRTh6Z3lX?=
 =?utf-8?B?TUI1dmRsWWd4TlowNlZHMEJkTHdkeTNaV0ZybmpIMk5Ka0wwQlBEWlRBVnFW?=
 =?utf-8?B?L1JRdnJkN1FhSkZ2c0sxRWJTUENBMkRVUnY5QU9JbFNGamExU0sveVgxaG5O?=
 =?utf-8?B?a1dwZEltbGx4aVJyN0NLWlIxTzVPY3lMVnZDbHpoTGt1bk1MaGNPdGRHTWRn?=
 =?utf-8?B?dGRRdldRcHAraHZ6Q1g0c2lFcWdFM2RKRFFQK2NOMWprcWxHWFFHaXVEWnBN?=
 =?utf-8?B?NFE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e4f11e-80a2-4cdf-76c5-08dafdddd355
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 07:37:20.2789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8rBh1QsytlSj14pStZ0YBI/I0mzzjdbIYL6ZQaFP2DNyhwBy9I80Srb13+7X9+yL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB5776
X-Proofpoint-ORIG-GUID: T5J5S3hYw6yiEbA_LMisYSJqhulWpQ1H
X-Proofpoint-GUID: T5J5S3hYw6yiEbA_LMisYSJqhulWpQ1H
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 2 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-23_01,2022-06-22_01
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/23/23 10:43 AM, David Faust wrote:
> 
> On 1/23/23 07:50, Jose E. Marchesi wrote:
>>
>>> On 1/5/23 10:30 AM, Jose E. Marchesi wrote:
>>>> We agreed in the meeting to implement Solution 2 below in both GCC
>>>> and
>>>> clang.
>>>> The DW_TAG_LLVM_annotation DIE number will be changed in order to
>>>> make
>>>> it possible for pahole to handle the current tags.  The number of the
>>>> new tag will be shared by both GCC and clang.
>>>
>>> w.r.t c2x attribute syntax discussion in 01/19 office hour discussion.
>>>
>>> I have checked clang c2x syntax w.r.t.
>>> btf_type_tag and btf_decl_tag. They are both supported
>>> with clang 15 and 16.
>>>
>>> See:
>>> https://clang.llvm.org/docs/AttributeReference.html
>>>
>>> The c2x btf_decl_tag attr syntax is [[clang::btf_decl_tag("")]].
>>> The c2x btf_type_tag attr syntax is [[clang::btf_type_tag("")]].
>>>
>>> $ cat t.c
>>> int [[clang::btf_type_tag("aa")]] * [[clang::btf_type_tag("bb")]] *f;
>>> [[clang::btf_decl_tag("cc")]] int foo() { return 5; }
>>> int bar() { return foo(); }
>>> $ clang -std=c2x -g -O2 -c t.c
>>> $ llvm-dwarfdump t.o | grep btf | grep tag
>>>                    DW_AT_name    ("btf_type_tag")
>>>                    DW_AT_name    ("btf_type_tag")
>>>                    DW_AT_name    ("btf_decl_tag")
>>>
>>> I double checked and the c2x syntax above generates the *same*
>>> type IR and dwarf compared to __attribute__ style attributes.
>>>
>>> [...]
>>
>> Thanks for checking.
>>
>> That matches our impression that C2X type attributes actually order the same
>> way than sparse type annotations, at least in the cases we are
>> interested on.
> 
> I have been experimenting with the C2x syntax in GCC and the results are
> similarly promising. It looks like with the C2x syntax, the 'type_tag's
> always associate in the same way as sparse.

Thanks for confirmation.

> 
> For GCC the syntax is (or will be)
>    [[gnu::btf_decl_tag("foo")]] and
>    [[gnu::btf_type_tag("bar")]]
> respectively.

Clang could add support for [[gnu::btf_decl_tag("foo")]] as well
once the syntax is agreed by the community and upstreamed.

> 
> I am not sure it is necessary to use the C2x syntax for decl_tag, iirc
> there are no issues with the __attribute__ syntax for decl_tag. Either
> one should be ok.

The same for me. Either is okay.

> 
> With C2x syntax, in the internal representation and in the generated
> DWARF, the type_tag attributes are attached to the same elements of
> the declaration as sparse attaches them to.
> 
> I checked all the examples we looked at and it seems they are
> all "fixed" with the C2x syntax, in that GCC agrees with sparse.
> For example,
> 
> $ cat ex2.c
> int __attribute__((btf_type_tag("tag1"))) * __attribute__((btf_type_tag("tag2"))) * g;
> 
> We saw that this example was problematic with the __attribute__ syntax
> in that GCC associates "tag1" with (int **) while sparse associates
> "tag1" with (int).
> 
> Using the c2x syntax, "tag1" is associated with (int) and "tag2" with
> (int *) the same as in sparse:
> $ cat ex2-c2x.c
> int [[gnu::btf_type_tag("tag1")]] * [[gnu::btf_type_tag("tag2")]] * g;
> $ bpf-unknown-none-gcc --std=c2x -c -gbtf -gdwarf ex2-c2x.c -o ex2-c2x.o
> $ bpftool btf dump file ex2-c2x.o
> [1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> [2] TYPE_TAG 'tag1' type_id=1
> [3] PTR '(anon)' type_id=2
> [4] TYPE_TAG 'tag2' type_id=3
> [5] PTR '(anon)' type_id=4
> [6] VAR 'g' type_id=5, linkage=global
> 
> 
> I also spent some studying the C2x draft standard [1] to check whether
> this ordering is documented by the standard or up to the implementation.
>    [1] https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3054.pdf
>    (I think this is the most recent draft, dated 3 Sep 2022)
> 
> I believe the "sparse-like" ordering is in fact required by the
> standard, which is great for us.
> 
> The relevant section is 6.7: Declarations. Section 6.7.12 covers only
> syntax of attributes themselves. The ordering/association rules are
> documented by the sections for each component of a declaration. Section
> 6.7.6 is particularly relevant, 6.7.6.1 discusses pointer declarators
> specifically.
> 
>  From my understanding, the general rule is that an attribute modifies
> the element of a declaration immediately to the left of it, which is
> the same as the intuitive sparse ordering.
> 
> So it seems like using the C2x standard attribute syntax may be a
> very nice solution to our problem. But we should keep in mind that C2x
> is still a draft so this attribute syntax could potentially change.
