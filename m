Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D440E5884B4
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 01:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiHBXQn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 19:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiHBXQm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 19:16:42 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204CB2124D
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 16:16:41 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 272NB2PY021364;
        Tue, 2 Aug 2022 16:16:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ut14QCTCtSof+1wfvUXDh8l1aaq3S9CLzf7vsBsH5kI=;
 b=XiApchaf16LWXW9b/mYh0T5P4Q0JnuSpf2faHUA+hU7/C61M3BoOrp3y1d8RB+nM3Pmm
 /cDPWwOwCo1gHChjHq8pcq+W29D+w2UvKoj/OUQTRnmabPzCi5gpI3TMjVwx++UtvR09
 ZV2EcDSEkM+eyObdtkjyHGJ2/cBOu87WSec= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hq477mjmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Aug 2022 16:16:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8s5vvLuw7Ag+fR+b74Jlx2OUss1z3FBj6GeNpBWaP//psLT9JBqyv72RNJ8QHaswz77bDpWsr487nehO5UGOozG9+MRYeWZh2eZAdjoohNt9+LMkwYY6CuCNfadLAc6csmmRVmwlrVnhgo/i2rIN2uxnqoC5k5fwGxaet0iz6rJrkDfkFp/5H8pOyGIHWq9bUJ5Rktu0jbbBwCDFXlytatoxYtEQm8tFJNgOYiXCsoxLcXLQV6xbcNBTvf7Cd51+ob+2iu0EjO2kkJnDmyQUr11K+lzmJHxFs3IxKZpzMWtYmkzdQYEdGXMgHBssyPuKioR6OWeT++hEWFNdzn2Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ut14QCTCtSof+1wfvUXDh8l1aaq3S9CLzf7vsBsH5kI=;
 b=Zj11+c/QHei+1N/6FbWgEkvE7x9Cla1VFTOebkiWt8k2KJ7/QM0sd2ucDsZUCSpESsNt1TgneEbhiV+ZPdK/ui8U/CggVT+HunbLsHaNytebHFKndDNfbCDek25yY5Pfe5l3SdE4Gn56p9csmfekEUYCMyLH144t9c3FlC4TfjoA2n8pEGN9msLDRialVBL8nzJIH/sRRxYJOutLo0MElD3vfL393SfPsop8yGdrClSCdLBtsjY50J4piegBsUF81G9Tj7epvxquUT6vrx+w3gbPWtXOwU0FSiw/is8ZQDmp5W4AlWk9xfDLts1OxC3Vlf7qmFQQHTHRw98QyhSnFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB4128.namprd15.prod.outlook.com (2603:10b6:805:61::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 2 Aug
 2022 23:16:07 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::de2:b318:f43e:6f55]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::de2:b318:f43e:6f55%3]) with mapi id 15.20.5482.015; Tue, 2 Aug 2022
 23:16:07 +0000
Message-ID: <b660e733-dd2c-43b0-d583-46ec720e97f3@fb.com>
Date:   Tue, 2 Aug 2022 16:16:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [RFC PATCH bpf-next] bpftool: Mark generated skeleton headers as
 system headers
Content-Language: en-US
To:     =?UTF-8?Q?J=c3=b6rn-Thorben_Hinz?= <jthinz@mailbox.tu-berlin.de>,
        bpf@vger.kernel.org
Cc:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <20220728165644.660530-1-jthinz@mailbox.tu-berlin.de>
 <7d4af6b4-f4da-f004-48a1-e408d8615ee8@fb.com>
 <019ea70d45ba155775a82e3648eab38007b8dc60.camel@mailbox.tu-berlin.de>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <019ea70d45ba155775a82e3648eab38007b8dc60.camel@mailbox.tu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR05CA0061.namprd05.prod.outlook.com
 (2603:10b6:a03:332::6) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ff17fa9-1498-42b9-6308-08da74dcfabb
X-MS-TrafficTypeDiagnostic: SN6PR1501MB4128:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZLABM8+kIUVCnpveQm5lZSrPT4SwOLC2brVlB98KlVC7ocJNUcDuDgfTQaM/a45CDAT1O34FNRhnT6j8WCIpp+NgeOrLrlEILkqOm+W/KKYXV34Sta7IBfTQtnDlOSE+IEBDA2wIpuyaGtpsWjvS6aX6dLxHYPg+BYJdcDHc8prXGWy28pXg/XKXY8URx8Unwo2bm6Jna6pH9kGqzWhqM7w9/AcvCKZb6rOGDRNwVxD3y8HBqSc8ymtm+2LuhVYjcZFyUGztY7efoOWFVN+sQNvosST3xNtTebgDcVYGfNDEb5shz3/aBXK1Ie6I1MFOg6ZK3u98Jn6GglCVlmtbKs+zqcd3jSHgM7F8dcJuyDIH/ZHCy4OOK9m0+abkQ4hDAUraqZs3ezx2DMQTVX5Z4hUximV8VK09mst9MGb8DPdCk87RyLjNrhpNYkqlQcw3iI2wta9LjWoP7jh9TV+fvLxU5mFjgFkZ7q6sTNn9029qSxvlTVSJcHIYGgiUoFPBuhw9Knt3Vh/BIKABZ27LMpWhCOeHRwnrVUytPawdX5q0kmlufA68RuQ9NEGp2hmuWbkpMMe34jIpsAtVL7fLNyCl0orIxAIDIfiBNjKJwc51VAmiGSjVBTShgqAJpM1uTbLnjbRuDhMz61ZYl/L/kdIPU2erWF+IMqWRjlKN3+bOE7M2c9RDAAnd7qLSgY6XPwC39sBDngONbWwavXyAQJrP27YQbqOs92Ez1nFiugjPSu49s/PO/Kib41+TITc/OANsojW3HygrOOYl2yLW5Phi9rJy+G8rGnxSVPb1kMtV8X2Nb7KStTyRn9wxUW5nc3jdf1aQjoKJ+QZqrOrrJF/ZlZJqWtnQ/MEQ/AP6Gso=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(186003)(66574015)(83380400001)(8676002)(38100700002)(66476007)(966005)(6486002)(6506007)(66556008)(53546011)(478600001)(41300700001)(6666004)(66946007)(316002)(54906003)(4326008)(7416002)(2616005)(2906002)(8936002)(5660300002)(31696002)(31686004)(36756003)(86362001)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M25RR2szckRHMHFHeFZSbGdFdHFURjhlWUU2a3h1N1RlMmdTd28zRkJYclRO?=
 =?utf-8?B?MmJVMXlCY3pIMGEzVUpmb0VxVmk3TWR4dGFEUTFudkRyakg2bWhZVDdBREFX?=
 =?utf-8?B?TndpSU1PUmlUVzlOMDNPTWhkN2dGMTZiVDZFUi9UWEhRQnhEWTA1YWZUemwz?=
 =?utf-8?B?ZndoRnF6aFcxUmJhdE1SOVY0eCtFakpGNHB0Q2owL2UybkhtTDg4aUlFR2Yy?=
 =?utf-8?B?Qm1PdklvV0lvWENmS0FlWngzRlYvYXdabytBMjBydDNWRmt1bHJ4RHBiZ1lF?=
 =?utf-8?B?bUFWaVJpT1hRam14MzdVQ2ZHN0E0bE5MOTZraFROWWZ3ZVU5QzgzcnNqaDdv?=
 =?utf-8?B?L3dIM2FrUFNBL1l6MC82QUsrbnkrekcxV2JESG5XQlFEZnpVZkxJWkFIcFBT?=
 =?utf-8?B?RW5NK0lSUjVNbVpaSXViY0xJODFhSjZHbmgwZ29QUzBzZkNIaEtDcnlqSDdn?=
 =?utf-8?B?RFYvQ3A3MW1ad3YvRmNMTGRtNWx2eHpkdm1DTmd3MUF1bVJRREc2WWY0YWo4?=
 =?utf-8?B?K2ZMVjc2VlErVDJmZnBCOGE2SVBFbVQrYTlUa28vNS83NlFEamIyT2d3N29p?=
 =?utf-8?B?bVZDUEVXNWR5MjN5ZXRSaEpqZWprYW5XQzkzYXNaVUprQVoxdUxoYjNHZXR6?=
 =?utf-8?B?NnMvSG9SUkYvZG14WjFHRTNJQ2pWaENRYmgzbUcrZDQzQTlFWDFXSWpEcHhj?=
 =?utf-8?B?QVFZTkgzYWRkbDY5V1FIb0swYUxtWEIwZHRLODFielUzRDFjY3NOTDIyb1Ix?=
 =?utf-8?B?cWNkbTJNaXcvT2lidWlDLzhzbUxueUc4UlhUVkl1RUhtTjFFRjB2dE9tZDdK?=
 =?utf-8?B?Sm12R0lJTERURk9HOXNiemVmeG5STFV4cFFXT0tJZWFmMmlzY25oOU5FZE5E?=
 =?utf-8?B?dCtSRm5Ydjlja3NkMkFVM1p3K3U4K0lKYWZkMU9qYzMzZTBieWxIdnRNd0ZE?=
 =?utf-8?B?VFBPblQxaGJmZm05NGRpaUxVTDUrT3FpdjBsWEdhejlMcytudmgwZXo2SXc0?=
 =?utf-8?B?ZHJqeHBMYjlFLzlRYmhXM3FiT1ZPcjdyemRrejJsNml1RThrSC8xNlovWm0z?=
 =?utf-8?B?cmN4WHRnYUpPZ3RKS2tXaVNIc0xMR0p5Z3FkZGpDK2xsUWNSNXFCUmxVVlFY?=
 =?utf-8?B?M2FReUJsQXdrajJjZVhFQ05JRkRxcThKTlVHdGxNVUQ0QnQvN3Yzc3NDd01i?=
 =?utf-8?B?WGNLRUVyQ1lJWXNwYndQRWZvZjcxbVJiWDZJa0gzdDRlamRtcGZZdGkwSFl1?=
 =?utf-8?B?aFZIa2JOeVFjR280blVuVjB6eU04THF1d1h0QUJIWHllakVjckd5dC9BOFQz?=
 =?utf-8?B?Q3BNRHBLZkdaM1hxYy9EN0o4UzdEQU0xMk56eHZiSS9aNDJSTExrcFhVRHhp?=
 =?utf-8?B?WFRjZWJlNEtqbGEwa1NNWXRsb0tqeVpsTS93cTBuekQ2TkF0Q3l0MzV5UVRG?=
 =?utf-8?B?WjJBY0xQUVFvL3gvTDI5ejN4bENhL2xXUFZXbXdkVVhMa0w3YVhydGIvbVRz?=
 =?utf-8?B?c1NLeXlaRUVxWlJwdHFsM0tiaWRFaUQzSk1HRitKUmhtYVpIcG51RGJvTm5Y?=
 =?utf-8?B?WkhDMTgwb0VSSUFKMFh3dlExTFdqU3FoNUFXaW5JLzR3d29DMlVLdjQybGpP?=
 =?utf-8?B?bUhMTWVHaXNNME9qWFRKT3BndHFLNGJZNGZ6SG1GUEltWXRTZ2lmbkZGQk14?=
 =?utf-8?B?eHA5S2lIUDNnZlNLL2kySkRoSVZDWHY1ZkdmMkd2aExzS3hCeit6Kzk3RFk5?=
 =?utf-8?B?YXhvVTNMN2ZodVlQY1ZPZmRaYUxFcVVnK0NUWTI4Nkx3KzNVRzVCd3VlVkh5?=
 =?utf-8?B?RlIvd0t0L1crQXBRZFNVcURJaCtUMHpMZE1JQnVNOENHalk1WjAwY1RhT0tw?=
 =?utf-8?B?R1B4OWw2bzlBTFQvSmVTK0Q1KzJRazkxaUdYcXoxblJjc3ErWVpaWGNpS0lo?=
 =?utf-8?B?TTVDYjd5ZVVTeFNBUjY0V2ZwdTFMa2xmVnZwbmN3Qm1yaWRFT2w0US83MnJ1?=
 =?utf-8?B?OWNNR3ZreHE0U3RvMzFxbUZhU1AvbGg0SUpYdjdaSTNoSWEzZ1l0dTZJb0Jp?=
 =?utf-8?B?WHlEMk9JQzZoQTd2WEI3NVA1akJvK05VVHEzY1NuWUFsMnI3Q2FHSEFWUCt5?=
 =?utf-8?Q?tFVuP4WcTPBwq4Gf+SN6ZPbz1?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff17fa9-1498-42b9-6308-08da74dcfabb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 23:16:07.5808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pmkagY2SCMj8fDP6H+oKXOE9qjT2dFGfiey9IiTTDJMOGVIAWbkY9CuXIOA7Tlt5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB4128
X-Proofpoint-GUID: Xs0QIXQmk6mL-RqTCMJ1yKmqUkXTTdua
X-Proofpoint-ORIG-GUID: Xs0QIXQmk6mL-RqTCMJ1yKmqUkXTTdua
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-02_15,2022-08-02_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/29/22 10:29 AM, Jörn-Thorben Hinz wrote:
> On Thu, 2022-07-28 at 11:25 -0700, Yonghong Song wrote:
>>
>>
>> On 7/28/22 9:56 AM, Jörn-Thorben Hinz wrote:
>>> Hi,
>>>
>>> after compiling a skeleton-using program with -pedantic once and
>>> stumbling across a tiniest incorrectness in skeletons with it[1], I
>>> was
>>> debating whether it makes sense to suppress warnings from skeleton
>>> headers.
>>>
>>> Happy about comments about this. This change might be too
>>> suppressive
>>> towards warnings and maybe ignoring only -Woverlength-strings
>>> directly
>>> in OBJ_NAME__elf_bytes() be a better idea. Or keep all warnings
>>> from
>>> skeletons available as-is to have them more visible in and around
>>> bpftool’s development.
>>
>> This is my 2cents.
> Thanks for the comment, Yonghong.
> 
>> As you mentioned, skeleton file are per program
>> and not in system header file directory. I would like not to mark
>> these header files as system files. Since different program will
>> generate different skeleton headers, suppressing warnings
>> will prevent from catching potential issues in certain cases.
> I admittedly didn’t take a full detailed look at it. But isn’t the
> general skeleton structure rather static, with only small differences
> depending on e.g. the sections, maps present in a BPF object?

You are correctly. Most skeleton code are not changed between
different programs.

> 
>>
>> Also, since the warning is triggered by extra user flags like -
>> pedantic
>> when building bpftool, user can also add -Wno-overlength-strings
>> in the extra user flags.
> Maybe I should have worded it more clearly. This was not about somebody
> adding flags to the build of bpftool itself. But rather about later
> using bpftool (prebuilt by your distribution, maybe) to generate a
> skeleton for some foreign BPF object/program.
> 
> That foreign program could use various compiler flags, which are
> outside of the reach of bpftool. But that foreign program also does not
> have any influence on the content on the skeleton header. Unless
> somebody wants to patch it after generating it (very unlikely).
> 
> So I looked at it mostly as a non-kernel-developer user of bpftool.
>  From that view, I feel like a skeleton header should behave like any
> library header and not produce unnecessary warnings in a program
> including it. Like e.g header files from /usr/include, which are, well,
> usually implicitly identified as system headers :-)
> 
> In the build of bpftool, I explicitly skipped the pragmas. So any
> warning caused by the two skeletons generated and used during bpftool’s
> build process (pid_iter.skel.h and profiler.skel.h) will still be
> visible.
> 
> Would it be an idea to by default apply this patch (or a similar one),
> but build the bpftool in selftests/bpf with a flag that keeps all
> warnings available? — like the -DBPFTOOL_BOOTSTRAP below already
> achieves, that flag could be renamed. bpftool is apparently already
> built with slightly different CFLAGS for the selftests.

I still prefer not to mark skeleton header as system header.
Precisely due to skeleton code not changing between different
programs AND skeleton code could change due to new/changed 
functionalities, we can permit by default compilation warnings
to flag potential issues.

> 
> To add that: I’m aware this patch is probably nit-picky and the
> warnings, if even, a very minor issue.
> 
>>
>>>
>>> [1]
>>> https://lore.kernel.org/r/20220726133203.514087-1-jthinz@mailbox.tu-berlin.de/
>>>
>>> Commit message:
>>>
>>> A userspace program including a skeleton generated by bpftool might
>>> use
>>> an arbitrary set of compiler flags, including enabling various
>>> warnings.
>>>
>>> For example, with -Woverlength-strings the string constant in
>>> OBJ_NAME__elf_bytes() causes a warning due to its usually huge
>>> length.
>>> This string length is not an actual problem with GCC and clang,
>>> though,
>>> it’s “just” not required by the C standard to be supported.
>>>
>>> Skeleton headers are likely not placed in a system include path. To
>>> avoid the above warning and similar noise for the *user* of a
>>> skeleton,
>>> explicitly mark the header as a system header which disables almost
>>> all
>>> warnings for it when included.
>>>
>>> Skeleton headers generated during the build of bpftool are not
>>> marked to
>>> keep potential warnings available to bpftool’s developers.
>>>
>>> Signed-off-by: Jörn-Thorben Hinz <jthinz@mailbox.tu-berlin.de>
>>> ---
>>>    tools/bpf/bpftool/Makefile |  2 ++
>>>    tools/bpf/bpftool/gen.c    | 30 +++++++++++++++++++++++++++---
>>>    2 files changed, 29 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tools/bpf/bpftool/Makefile
>>> b/tools/bpf/bpftool/Makefile
>>> index 6b5b3a99f79d..5f484d7929db 100644
>>> --- a/tools/bpf/bpftool/Makefile
>>> +++ b/tools/bpf/bpftool/Makefile
>>> @@ -196,6 +196,8 @@ endif
>>>    
>>>    CFLAGS += $(if $(BUILD_BPF_SKELS),,-DBPFTOOL_WITHOUT_SKELETONS)
>>>    
>>> +$(BOOTSTRAP_OUTPUT)%.o: CFLAGS += -DBPFTOOL_BOOTSTRAP
>>> +
>>>    $(BOOTSTRAP_OUTPUT)disasm.o: $(srctree)/kernel/bpf/disasm.c
>>>          $(QUIET_CC)$(HOSTCC) $(HOST_CFLAGS) -c -MMD $< -o $@
>>>    
>>> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
>>> index 1cf53bb01936..82053aceec78 100644
>>> --- a/tools/bpf/bpftool/gen.c
>>> +++ b/tools/bpf/bpftool/gen.c
>>> @@ -1006,7 +1006,15 @@ static int do_skeleton(int argc, char
>>> **argv)
>>>                  /* THIS FILE IS AUTOGENERATED BY BPFTOOL!
>>> */                \n\
>>>                  #ifndef
>>> %2$s                                                \n\
>>>                  #define
>>> %2$s                                                \n\
>>> -
>>>                                                                      
>>>         \n\
>>> +               "
>>> +#ifndef BPFTOOL_BOOTSTRAP
>>> +               "\
>>> +               \n\
>>> +               _Pragma(\"GCC
>>> system_header\")                              \n\
>>> +               "
>>> +#endif
>>> +               "\
>>> +               \n\
>>>                  #include
>>> <bpf/skel_internal.h>                              \n\
>>>                                                                     
>>>           \n\
>>>                  struct %1$s
>>> {                                               \n\
>>> @@ -1022,7 +1030,15 @@ static int do_skeleton(int argc, char
>>> **argv)
>>>                  /* THIS FILE IS AUTOGENERATED BY BPFTOOL!
>>> */                \n\
>>>                  #ifndef
>>> %2$s                                                \n\
>>>                  #define
>>> %2$s                                                \n\
>>> -
>>>                                                                      
>>>         \n\
>>> +               "
>>> +#ifndef BPFTOOL_BOOTSTRAP
>>> +               "\
>>> +               \n\
>>> +               _Pragma(\"GCC
>>> system_header\")                              \n\
>>> +               "
>>> +#endif
>>> +               "\
>>> +               \n\
>>>                  #include
>>> <errno.h>                                          \n\
>>>                  #include
>>> <stdlib.h>                                         \n\
>>>                  #include
>>> <bpf/libbpf.h>                                     \n\
>>> @@ -1415,7 +1431,15 @@ static int do_subskeleton(int argc, char
>>> **argv)
>>>          /* THIS FILE IS AUTOGENERATED!
>>> */                                   \n\
>>>          #ifndef
>>> %2$s                                                        \n\
>>>          #define
>>> %2$s                                                        \n\
>>> -
>>>                                                                      
>>>         \n\
>>> +               "
>>> +#ifndef BPFTOOL_BOOTSTRAP
>>> +       "\
>>> +       \n\
>>> +       _Pragma(\"GCC
>>> system_header\")                                      \n\
>>> +       "
>>> +#endif
>>> +       "\
>>> +       \n\
>>>          #include
>>> <errno.h>                                                  \n\
>>>          #include
>>> <stdlib.h>                                                 \n\
>>>          #include
>>> <bpf/libbpf.h>                                             \n\
> 
> 
