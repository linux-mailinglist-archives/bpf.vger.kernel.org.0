Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4D73546D2
	for <lists+bpf@lfdr.de>; Mon,  5 Apr 2021 20:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbhDES5A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Apr 2021 14:57:00 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:26796 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234913AbhDES47 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 5 Apr 2021 14:56:59 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 135Iu837020122;
        Mon, 5 Apr 2021 11:56:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=5VSCKR4y/i0xLrBlglQxPIMamJIcRHF9mO9N620ujIc=;
 b=jSSKL8yVcjXunQhxcFKHIpqdL0p1TCeLBFeNBhJWvNsX3Mwm+Y5rpxQQtpzPGp0Igg2Y
 Gc6BaOFd2fouWwNLBE3dN5mtKRzQxeclqd/mGq0eppBd/WXkw/j+TVjMh2MrZnWjmWBO
 ztc4nUogQd6ZP3lMUj5KE1flkWmd0H2hbbs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37qvma357c-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 05 Apr 2021 11:56:49 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 5 Apr 2021 11:56:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7ElBEM9mLzMgP2xbd4k2sfnxCs6/fB0rWfXffvB1H5h/dXtSO3bJBIWkKb9f1Pd8CimYvZaaMbXTVjJmKU0SVkftBkHiIeQo7YOY8mz8v3yYbCM4/iP4dNNgNd0BqvFinGKFxS5K23e/utWwSsmthjr3xuILcFC9GJEQpdBo7ciuiEPL682/unrCjpa2nM9GeSlE+cqsdSa40RsdsBTVw296YPceMGBbZ6IU5MtpyUVyqInIuyzupDgaqLxj9hw4XUtLueKryMI9/xgb7JOeIiOlYt+vLJ3OiNp2DtlHu7Et6iXlLRUvNwqod+VShhyiIhWOmzFOcBhDuTDpnFoyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VSCKR4y/i0xLrBlglQxPIMamJIcRHF9mO9N620ujIc=;
 b=YLkszSx93/Skb4G+WeT44goQKp1vgTD2LU0wXEsnBDZqmxM/cu3zhlBArrhEEjNOFVbZKkwjbEzt/6vvt7LSTEmDh7/uzcdA+7zFGx86gKLOaGNNpyouBQksT4kVYFFCamEhD4hPs1bKO/1DbrulPl4OiX7DV3dEGWMQs8GhA5CRxYWgtwnj4nek/IxYvest0vj/srwgwtswl8s8FEYpkWSw1RxD+iTAkNu1z9Tau+9W+qKjn87f6CHlJbE4WlzuZ5tvnQoEtCxLDDNaGH9bABxogsLbDJQD+TahihfDOeBKNh9SIlQAqJF5T21maIBDhBZE/vzyrjRC9qNpXg9nMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2256.namprd15.prod.outlook.com (2603:10b6:805:1b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Mon, 5 Apr
 2021 18:56:44 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 18:56:44 +0000
Subject: Re: [PATCH dwarves] dwarf_loader: handle DWARF5 DW_OP_addrx properly
To:     <sedat.dilek@gmail.com>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Bill Wendling <morbo@google.com>, <bpf@vger.kernel.org>,
        David Blaikie <dblaikie@gmail.com>, <kernel-team@fb.com>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20210403184158.2834387-1-yhs@fb.com>
 <CA+icZUWLf4W_1u_p4-Rx1OD7h_ydP4Xzv12tMA2HZqj9CCOH0Q@mail.gmail.com>
 <6c67f02a-3bc2-625a-3b05-7eb3533044bb@fb.com>
 <CA+icZUV4fw5GNXFnyOjvajkVFdPhkOrhr3rn5OrAKGujpSrmgQ@mail.gmail.com>
 <CA+icZUWh6YOkCKG72SndqUbQNwG+iottO4=cPyRRVjaHD2=0qw@mail.gmail.com>
 <f706e8b9-77ca-6341-db13-e2a74549576b@fb.com>
 <CA+icZUVb_J95Gk2Kf0i8waL6TDfJ2n9JrGbNK_dsN1n8HdcoXQ@mail.gmail.com>
 <458faf4c-7681-13eb-023d-c51f582bfec6@fb.com>
 <CA+icZUVcQ+vQjc0VavetA3s6jzNhC20dU4Sa9ApBLNXbY=w5wA@mail.gmail.com>
 <b4963c83-df8a-630a-cc78-c72f6a388823@fb.com>
 <CA+icZUVd64WJkX+adNKpGbL+=g-Yn-D-_XwqW_GOt9vp0Fpamw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <cd3f781e-ad2f-644d-d2af-8ea15902dbf8@fb.com>
Date:   Mon, 5 Apr 2021 11:56:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
In-Reply-To: <CA+icZUVd64WJkX+adNKpGbL+=g-Yn-D-_XwqW_GOt9vp0Fpamw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:7583]
X-ClientProxiedBy: MW4PR04CA0130.namprd04.prod.outlook.com
 (2603:10b6:303:84::15) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::1149] (2620:10d:c090:400::5:7583) by MW4PR04CA0130.namprd04.prod.outlook.com (2603:10b6:303:84::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Mon, 5 Apr 2021 18:56:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf49d5a0-930e-4d1c-7336-08d8f8648e59
X-MS-TrafficTypeDiagnostic: SN6PR15MB2256:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB22561F0012D3C881A7ADD045D3779@SN6PR15MB2256.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +A8CwUsrum3kKBoGO1HfjpOg58gPOILkz1/fvc5puyqzRhL7VHLgeC3/rClGRucRWh36CtldRoTYDHq8cnx8HyTsT0NTy3KANvGKlB6I4dFoc6xhjdkcFxKpC1kWH7CfwlErQXOV/B8tptEAobwNQeFTHMa+iRcSdilE7nC2LCXCKersos4XVUTqsAO6NqOlWC+kTFV7rlJWqKuxWrFUxonJv+bJrl+DT6HWPAqckccmnR0oPHTU+VdWoWo+myHNDkDSBlNdJjsmiNKrDVChamSq4mH10+3g90khdXNeT5U6ngH7XTCQbXJoBISp8Dhv7eNorDAxjX/bN7Xx9lUtKyBBh4Y1jY3oD3LTW8UVmtf3YJHzSmQOG94jDfHpQ0rMIBFllDcBo06grLCywFpmyBp7xoOsxveShHOoITvbYOYS6F0JklrM20nKgToz5epf12cbGXl2R3xQFlgy9UOJX8lMP/9angJAqe78tWtNmSgc0Op/1Aesq740n3r1AFzjkpiTUF6ll6j8HN8uj5KvE3gDzv3m+R8B6KYFhzDBO7raqKV8iODQwvncguzi8AvDhgCKNRxeUkNa3XyziHoQtYhJe23NzZN3/gX5J+ikNfyXZHyOsT9OUp5EsEX86yi6sJ90aHNc7PuJjMS3k8Nxuj2U68dLwcT8r7qXyywfYsrU6q8U+qeP5hYFk2IDF/gLqnpd4/BlQi471dBIBEIFJrpeiiAHiw9x01qU88y4If8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39860400002)(376002)(346002)(136003)(53546011)(52116002)(2906002)(16526019)(6486002)(8676002)(6916009)(86362001)(8936002)(316002)(83380400001)(31696002)(31686004)(66946007)(66476007)(66556008)(2616005)(54906003)(36756003)(478600001)(38100700001)(4326008)(5660300002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MjZ3dk05ZmVFdFRoNG1VbmlYL0NOMnBGaHFFR1UzMGY0bW05Rlk2S0VZRC96?=
 =?utf-8?B?VEs3dzM5Z05Yd3B3T2ZQS08yR0txQ2dHWWRwSmloRFNmNzZETzAraUI0RkZQ?=
 =?utf-8?B?a2E1Ym16S0ZvTHBpTWRQN2x1Tkc4ZFcwZU9qTEkrN2ZPTUVZZGdGRDNUNmZE?=
 =?utf-8?B?UTBaczJHQnRucUhMeFIvRzlMYllueU44M1lDTzE1SnJBbUliaExBVEtiR1hy?=
 =?utf-8?B?LzZJVWNIeU4yREpFWmZuaTkyK1RkTVFjRkNIdzFVaUdkemQ3ckVsSUVJTFpT?=
 =?utf-8?B?QUcvRHdubC9xRnRVbGlkNjlyTCtsS3JKaGJvb2pLNjV1TmR2bHVKZng1Z3Za?=
 =?utf-8?B?bDlZajRBMmI3b2RKcTU4YXZ1QXp6ZUZKT0RQcDJtQzBCaURReFBuT3ZSNmND?=
 =?utf-8?B?OU9XaWhWQkd1SmFVY2pyYXpFOUxLNlN6Tll2YzZaZklVcFlENGdNWkFyQm9P?=
 =?utf-8?B?SzJ5WitsMC9HNlZOWnRjdVhUS3lUMmNnOXZTVWV4RVREM3dFb20xV3FwY3By?=
 =?utf-8?B?L0Z0ajl0MDlKVDFTWjExcENrbE1pcWhMNzU1YW9iZ2hjQ21odTUrT2g0OTdV?=
 =?utf-8?B?ckczNHFZK25IaXRRUCtqY0wvOGIwUGVTMy9WUzNHWEtCVjU1dDRVRXVTaUZD?=
 =?utf-8?B?YmE5QkpDODZBaWdZMStQcjQxVDRndVR0Ny9vUEZ6SHZDQmh1ZkV5d0VWamdz?=
 =?utf-8?B?YlVXQVVqMzNVc0VzbkI3WjdFYXFWQlJGWUt6UHc5aWpPQXRqSlFkQy93MHNJ?=
 =?utf-8?B?b1QzZ3VPYVAwU1ZKbVJhSVYvTmN0NGhsWkc3QWJsOU5xeG5EbjZMVS9YVENq?=
 =?utf-8?B?QUZRNEl3QmhjODc2VlpPdjM4djVjd1VNUlV6Z2hMdUNla0RJdUE1aGo4OFBS?=
 =?utf-8?B?Yk56SHIxKytobEdoNVdJTGxpM2JLNFloblVKRVYvSzhxMTY1STk3RWxWVGRi?=
 =?utf-8?B?R0pHRWFNWUkxWlBmQnpWRVhPeTVLekRKV2hya0JWSjVmYldVQjNCaVdnQ2VD?=
 =?utf-8?B?ZkU0UjdTZ0FSbTh2YnFrYVErQjRzbzUxL1BPblgydHpUMFhHcjdEZ0ZLM2Ft?=
 =?utf-8?B?dlp6S2UwcmxLMnNmVm1zU09PYm83NFVwQUlDM1QvTkxSL3V0WnpIT3BBZjhE?=
 =?utf-8?B?alFyMnhPY2NvdUk1V1Z0Y3FsODhFeHgvSkk5d01saXRkMDVIM3h6YVgydDdq?=
 =?utf-8?B?dWRPZ3B1ME9ZakVUM05MR21ZaS9QZDE4WVIxUW5hallLMTd1UEZYcCtaa0tt?=
 =?utf-8?B?bjBRRERPTDNGK3hISzJ4NVVRSVN5WSt1R2RuNGxpVTg1ZXA4U0FuS29BU3Vj?=
 =?utf-8?B?UzYxNnJVS3dMcm5QdDBWZzhXOUZQQWc3SWh6NEtYMXFVc1p2R1VQMFJDc2o3?=
 =?utf-8?B?aFBFTktSdlhHOEhjdHFQNjEzNExFTm9HektRcTBjSER1aVJ1SW50TkdBSCt6?=
 =?utf-8?B?WVpqQ0x5am16blcvTXg4dFFDVEdOdVh3Q0IwWm83bU5wc3AzaU1wVWJwV25w?=
 =?utf-8?B?U0liZVpPc3p5WmQ0QVZKcVY1WkVjZ2hVL1VjNXZpaDViQ2dDSGdMNU85cUll?=
 =?utf-8?B?a2Q2OEo3VzZtZnRQNUpEZ0xTZ2NZa1ZzbmhzWlpvYmk4VERVRGlZL1htYUly?=
 =?utf-8?B?NDJ0V1pCNWJqYWdqOHlPRjFvNHAvaVVvOVIxR21DSU9FL2FvRzFGZEMwWXc2?=
 =?utf-8?B?SUxpN0FnK2JYVUVSUFU0WGN2S0kzT1JJUDdQbHlLMmE1Q1hURWR2Q1hPN3Ji?=
 =?utf-8?B?ZElQU1AzbEw0NFQyUDJyeGIyZE5Beld5b2JrUmczTVNuZGdDOGhmUzJvVGU3?=
 =?utf-8?Q?LUI/3Ufe1/HXtj9lhOkeCEu0V+sFwCtgcMW14=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf49d5a0-930e-4d1c-7336-08d8f8648e59
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2021 18:56:44.3339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZKsD9xpvQesTWNCbIRfIO7PgJayUoQG/VsP9LSGUrucD3kCM5/24GwCNHJiJLMT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2256
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: NGGqi71LGqGXuUTOt-cjQKAvKrYlXK6x
X-Proofpoint-ORIG-GUID: NGGqi71LGqGXuUTOt-cjQKAvKrYlXK6x
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-05_14:2021-04-01,2021-04-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104050120
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/5/21 11:32 AM, Sedat Dilek wrote:
> On Mon, Apr 5, 2021 at 6:17 PM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 4/4/21 11:55 PM, Sedat Dilek wrote:
>>> On Mon, Apr 5, 2021 at 4:24 AM Yonghong Song <yhs@fb.com> wrote:
>>>>
>>>>
>>>>
>>>> On 4/4/21 10:25 AM, Sedat Dilek wrote:
>>>>> On Sun, Apr 4, 2021 at 6:40 PM Yonghong Song <yhs@fb.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 4/4/21 5:46 AM, Sedat Dilek wrote:
>>>> [...]
>>>>>>> Next build-error:
>>>>>>>
>>>>>>> g++ -g -rdynamic -Wall -O2 -DHAVE_GENHDR
>>>>>>> -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
>>>>>>> -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/b
>>>>>>> pf/tools/include -I/home/dileks/src/linux-kernel/git/include/generated
>>>>>>> -I/home/dileks/src/linux-kernel/git/tools/lib
>>>>>>> -I/home/dileks/src/linux-kernel/git/tools/include
>>>>>>> -I/home/dileks/src/linux-kernel/git/tools/include/uapi
>>>>>>> -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
>>>>>>> -Dbpf_prog_load=bpf_prog_test_load
>>>>>>> -Dbpf_load_program=bpf_test_load_program test_cpp.cpp
>>>>>>> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_core_extern.skel.h
>>>>>>> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a
>>>>>>> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_stub.o
>>>>>>> -lcap -lelf -lz -lrt -lpthread -o
>>>>>>> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_cpp
>>>>>>> /usr/bin/ld: /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a(libbpf-in.o):
>>>>>>> relocation R_X86_64_32 against `.rodata.str1.1' ca
>>>>>>> n not be used when making a PIE object; recompile with -fPIE
>>>>>>> collect2: error: ld returned 1 exit status
>>>>>>> make: *** [Makefile:455:
>>>>>>> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_cpp]
>>>>>>> Error 1
>>>>>>> make: Leaving directory
>>>>>>> '/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf'
>>>>>>>
>>>>>>> LOL, I was not aware that there is usage of *** CXX*** in tools
>>>>>>> directory (see g++ line and /usr/bin/ld ?).
>>>>>>>
>>>>>>> So, I changed my $MAKE_OPTS to use "CXX=clang++".
>>>>>>
>>>>>> In kernel, if LLVM=1 is set, we have:
>>>>>>
>>>>>> ifneq ($(LLVM),)
>>>>>> HOSTCC  = clang
>>>>>> HOSTCXX = clang++
>>>>>> else
>>>>>> HOSTCC  = gcc
>>>>>> HOSTCXX = g++
>>>>>> endif
>>>>>>
>>>>>> ifneq ($(LLVM),)
>>>>>> CC              = clang
>>>>>> LD              = ld.lld
>>>>>> AR              = llvm-ar
>>>>>> NM              = llvm-nm
>>>>>> OBJCOPY         = llvm-objcopy
>>>>>> OBJDUMP         = llvm-objdump
>>>>>> READELF         = llvm-readelf
>>>>>> STRIP           = llvm-strip
>>>>>> else
>>>>>> CC              = $(CROSS_COMPILE)gcc
>>>>>> LD              = $(CROSS_COMPILE)ld
>>>>>> AR              = $(CROSS_COMPILE)ar
>>>>>> NM              = $(CROSS_COMPILE)nm
>>>>>> OBJCOPY         = $(CROSS_COMPILE)objcopy
>>>>>> OBJDUMP         = $(CROSS_COMPILE)objdump
>>>>>> READELF         = $(CROSS_COMPILE)readelf
>>>>>> STRIP           = $(CROSS_COMPILE)strip
>>>>>> endif
>>>>>>
>>>>>> So if you have right path, you don't need to set HOSTCC and HOSTCXX
>>>>>> explicitly.
>>>>>>
>>>>>
>>>>> That is all correct with HOSTCXX but there is no CXX=... assignment
>>>>> otherwise test_cpp will use g++ as demonstrated.
>>>>
>>>> This is not a kernel Makefile issue.
>>>>
>>>> We have:
>>>> testing/selftests/bpf/Makefile:CXX ?= $(CROSS_COMPILE)g++
>>>>
>>>> So you need to explicit add CXX=clang++ when compiling
>>>> bpf selftests with LLVM=1 LLVM_IAS=1.
>>>>
>>>
>>> NOPE.
>>>
>>> $ echo $MAKE $MAKE_OPTS
>>> make V=1 LLVM=1 LLVM_IAS=1 CXX=clang++ PAHOLE=/opt/pahole/bin/pahole
>>>
>>> $ LC_ALL=C $MAKE $MAKE_OPTS -C tools/testing/selftests/bpf/ 2>&1 | tee
>>> ../make-log_tools-testing-selftests-bpf_llvm-1-llvm_ias-1_cxx-clang.txt
>>>
>>> This breaks again like reported before:
>>>
>>> clang++ -g -rdynamic -Wall -O2 -DHAVE_GENHDR
>>> -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
>>> -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/include
>>> -I/home/dileks/src/linux-kernel/git/include/generated
>>> -I/home/dileks/src/linux-kernel/git/tools/lib
>>> -I/home/dileks/src/linux-kernel/git/tools/include
>>> -I/home/dileks/src/linux-kernel/git/tools/include/uapi
>>> -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
>>> -Dbpf_prog_load=bpf_prog_test_load
>>> -Dbpf_load_program=bpf_test_load_program test_cpp.cpp
>>> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_core_extern.skel.h
>>> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a
>>> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_stub.o
>>> -lcap -lelf -lz -lrt -lpthread -o
>>> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_cpp
>>>
>>> clang-12: warning: treating 'c-header' input as 'c++-header' when in
>>> C++ mode, this behavior is deprecated [-Wdeprecated]
>>> clang-12: error: cannot specify -o when generating multiple output files
>>> make: *** [Makefile:455:
>>> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_cpp]
>>> Error 1
>>> make: Leaving directory
>>> '/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf'
>>>
>>> Do you know some magic CXX flags to be passed?
>>
>> I tested in my environment. The reason is LC_ALL=C.
>> Without LC_ALL=C, make succeeded and with it, test_cpp
>> compilation failed. Is it possible for you to drop
>> LC_ALL=C for bpf selftests?
>>
>> The following command succeeded for me:
>>      make -C tools/testing/selftests/bpf -j60 LLVM=1 V=1 CXX=clang++ CC=clang
>>
> 
> First, I tried the exact make invocation ^^^ in my build-environment
> but that breaks with the same ERROR.
> 
> I did in a second run:
> 
> LLVM_TOOLCHAIN_PATH="/opt/llvm-toolchain/bin"
> if [ -d ${LLVM_TOOLCHAIN_PATH} ]; then
>    export PATH="${LLVM_TOOLCHAIN_PATH}:${PATH}"
> fi
> 
> echo $PATH
> /opt/llvm-toolchain/bin:/opt/proxychains-ng/bin:/home/dileks/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games
> 
> MAKE="make"
> MAKE_OPTS="V=1 -j4 LLVM=1 CC=clang CXX=clang++"
> MAKE_OPTS="$MAKE_OPTS PAHOLE=/opt/pahole/bin/pahole"
> 
> echo $MAKE $MAKE_OPTS
> make V=1 -j4 LLVM=1 CC=clang CXX=clang++ PAHOLE=/opt/pahole/bin/pahole
> 
> $MAKE $MAKE_OPTS -C tools/testing/selftests/bpf/ 2>&1 | tee
> ../make-log_tools-testing-selftests-bpf.txt
> 
> That would have been funny... Drop LC_ALL=C from make line as a fix.
> 
> Just curious: Do you see these warnings?
> 
> clang-12: warning: argument unused during compilation: '-rdynamic'
> [-Wunused-command-line-argument]
> clang-12: warning: -lcap: 'linker' input unused [-Wunused-command-line-argument]
> clang-12: warning: -lelf: 'linker' input unused [-Wunused-command-line-argument]
> clang-12: warning: -lz: 'linker' input unused [-Wunused-command-line-argument]
> clang-12: warning: -lrt: 'linker' input unused [-Wunused-command-line-argument]
> clang-12: warning: -lpthread: 'linker' input unused
> [-Wunused-command-line-argument]
> clang-12: warning: -lm: 'linker' input unused [-Wunused-command-line-argument]
> 
> Equivalent CFLAGS for '-rdynamic' when CC=clang is used?
> Missing LDFLAGS when LD=ld.lld (make LLVM=1) is used?

I see this warning as well, but seems it does not hurt...
Maybe some flags need change if the CC is clang...

> 
> Last question:
> Can you pass LLVM_IAS=1 (means use LLVM/Clang Integrated ASsembler) to
> your make line?
> 
> Old: make -C tools/testing/selftests/bpf -j60 LLVM=1 V=1 CXX=clang++ CC=clang
> New: make -C tools/testing/selftests/bpf -j60 LLVM=1 LLVM_IAS=1 V=1
> CXX=clang++ CC=clang
> 
> Does it build successfully?

I think it is better to add LLVM_IAS=1. In my build, for non-lto, I 
didn't pass LLVM_IAS=1 to kernel build, so selftest does not need it either.

But for LTO build, LLVM_IAS=1 is required so selftest also needs
LLVM_IAS=1.

Yes, we can always have LLVM_IAS=1 if it is included in kernel build.

> 
> - Sedat -
> 
>>>
>>> The only solution is to suppress the build of test_cpp (see
>>> TEST_GEN_PROGS_EXTENDED):
>>>
>>> $ git diff tools/testing/selftests/bpf/Makefile
>>> diff --git a/tools/testing/selftests/bpf/Makefile
>>> b/tools/testing/selftests/bpf/Makefile
>>> index 044bfdcf5b74..cf7c7c8f72cf 100644
>>> --- a/tools/testing/selftests/bpf/Makefile
>>> +++ b/tools/testing/selftests/bpf/Makefile
>>> @@ -77,8 +77,8 @@ TEST_PROGS_EXTENDED := with_addr.sh \
>>> # Compile but not part of 'make run_tests'
>>> TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
>>>          flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
>>> -       test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod.ko \
>>> -       xdpxceiver
>>> +       test_lirc_mode2_user xdping runqslower bench bpf_testmod.ko xdpxceiver
>>> +       # test_cpp # Suppress the build when CXX=clang++ is used
>>>
>>> TEST_CUSTOM_PROGS = $(OUTPUT)/urandom_read
>>>
>>> I have attached both make-logs with and without suppressing the build
>>> of test_cpp and the diff.
>>>
>>> - Sedat -
>>>
>>>>
>>>>>
>> [...]
