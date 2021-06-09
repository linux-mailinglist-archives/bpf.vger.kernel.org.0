Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAD73A0D08
	for <lists+bpf@lfdr.de>; Wed,  9 Jun 2021 09:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236940AbhFIHDp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Jun 2021 03:03:45 -0400
Received: from mx0b-00007101.pphosted.com ([148.163.139.28]:52662 "EHLO
        mx0b-00007101.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234004AbhFIHDo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Jun 2021 03:03:44 -0400
X-Greylist: delayed 1728 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Jun 2021 03:03:43 EDT
Received: from pps.filterd (m0166260.ppops.net [127.0.0.1])
        by mx0b-00007101.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1596SQ2c019431;
        Wed, 9 Jun 2021 06:32:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=campusrelays;
 bh=HIFhkFrQswIABVmzomXcE2JfQ/mcE4o23usFbOK/4ik=;
 b=oXo6oEFK6gGUcqkxl2J7ADEANHdpUKzOWE9pUco6o1Jqe8XtNNDG7nqXhETBR1Rc7cfu
 nNIC/bUTF7dGZDgRm5IsYPgcdQaehcN630VMRNN15ZCFB+hmsyWrSToCpvELjNOysoqz
 gWB16+DMK5suyyAH5q+veQQbkil4WXqVtP/3UuLWiYZz92RAHbiVMmalAUO/EA6E9d/g
 odeAx2nWIscB+BJQ63mDG3XPLz9dD0xqkeAnaUnq5vNPpwJ1gGEHWxurilKAcpPH6kXo
 PcrNuGVEz+q59kImV44qjXPzwa4rDNBsC1JyxeCl5Mm1sri5V0M24iGnOt6/HNFGnpB/ jA== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2047.outbound.protection.outlook.com [104.47.56.47])
        by mx0b-00007101.pphosted.com with ESMTP id 391qtw3xds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Jun 2021 06:32:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCs3hY1a65TtA/HRn3ss72QDH1XrJLXitLgmM/5+m1EkxoPUC8+Xc/I+pRpdCkk2k1vtBnJcftGhUKjP94GK0I1vqsYPkpFWutEeD6BYM8KMdtHiRtkS54C1m2BnrLtJ6YPl5Gu3+GPi7ekcH7YPoWl33BR4CMe9XLkp3380edr4LfP5mVT2L/xz9OIkzOSJbps0aQXp9yTFEL3hHO7XmlbjGXZorYAl6SL+Hu/LSmb2sF9kSv1xiww1nFXHy7evrxKMhVzmZdrHv4+JrFlF7L0sC41RPWi7Wvck+MuCNWS7kmz8g0g8eMdN3Biv6IURW2BMDBcmHY5qJ4puASKSWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIFhkFrQswIABVmzomXcE2JfQ/mcE4o23usFbOK/4ik=;
 b=L9le0b+IJ2gQMSDeHTLubxnXwayPaQAFYrP1rx0OxawgvyEfwgsWVs+euCxZiX5BoazVGllTqKXQDbucNji/S1SJTdLuKcxXHzpxlgvgRS+42m1DegPkLABNK8HYPy9sXgVyxQGH8qgpxwtdIc9E+ZijmEJN63EkjWrzHWxxqSbgnqZ1hFCWcRsmnmfgcv5WAwPQsyHkPk38q5JqwGo+0Kj2SKOkFIRy9E6mdrM8jVJXMel3TQwW4AAya0GFH/YwiBDtWJwXpHDym+iYjR+TJiA1+wkFZOW06cjYeROr65y6b+bHYOXvGmvoQHE6WJE28ZTN6gdS3kGZKSaGpvM5Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=illinois.edu; dmarc=pass action=none header.from=illinois.edu;
 dkim=pass header.d=illinois.edu; arc=none
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=illinois.edu;
Received: from CH2PR11MB4454.namprd11.prod.outlook.com (2603:10b6:610:45::22)
 by CH0PR11MB5233.namprd11.prod.outlook.com (2603:10b6:610:e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21; Wed, 9 Jun
 2021 06:32:21 +0000
Received: from CH2PR11MB4454.namprd11.prod.outlook.com
 ([fe80::7c:abd3:683:d04b]) by CH2PR11MB4454.namprd11.prod.outlook.com
 ([fe80::7c:abd3:683:d04b%6]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 06:32:21 +0000
Subject: Re: [RFC PATCH bpf-next seccomp 00/12] eBPF seccomp filters
To:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Tianyin Xu <tyxu@illinois.edu>, Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@kernel.org>,
        YiFei Zhu <zhuyifei1999@gmail.com>,
        "containers@lists.linux.dev" <containers@lists.linux.dev>,
        bpf <bpf@vger.kernel.org>, "Zhu, YiFei" <yifeifz2@illinois.edu>,
        LSM List <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kuo, Hsuan-Chi" <hckuo2@illinois.edu>,
        Claudio Canella <claudio.canella@iaik.tugraz.at>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jann Horn <jannh@google.com>,
        "Torrellas, Josep" <torrella@illinois.edu>,
        Sargun Dhillon <sargun@sargun.me>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        Will Drewry <wad@chromium.org>
References: <cover.1620499942.git.yifeifz2@illinois.edu>
 <CALCETrUQBonh5BC4eomTLpEOFHVcQSz9SPcfOqNFTf2TPht4-Q@mail.gmail.com>
 <CABqSeASYRXMwTQwLfm_Tapg45VUy9sPfV7BeeV8p7XJrDoLf+Q@mail.gmail.com>
 <fffbea8189794a8da539f6082af3de8e@DM5PR11MB1692.namprd11.prod.outlook.com>
 <CAGMVDEGzGB4+6gJPTw6Tdng5ur9Jua+mCbqwPoNZ16EFaDcmjA@mail.gmail.com>
 <108b4b9c2daa4123805d2b92cf51374b@DM5PR11MB1692.namprd11.prod.outlook.com>
 <CAGMVDEEkDeUBcJAswpBjcQNWk7QDcO8BZR=uvVfm-+qe714tYg@mail.gmail.com>
 <20210520085613.gvshk4jffmzggvsm@wittgenstein>
 <202106011244.76762C210@keescook>
From:   Jinghao Jia <jinghao7@illinois.edu>
Message-ID: <afbf8b44-6739-2c77-a29f-2a9c791d039c@illinois.edu>
Date:   Wed, 9 Jun 2021 01:32:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <202106011244.76762C210@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [98.228.56.157]
X-ClientProxiedBy: CH2PR10CA0014.namprd10.prod.outlook.com
 (2603:10b6:610:4c::24) To CH2PR11MB4454.namprd11.prod.outlook.com
 (2603:10b6:610:45::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.8] (98.228.56.157) by CH2PR10CA0014.namprd10.prod.outlook.com (2603:10b6:610:4c::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Wed, 9 Jun 2021 06:32:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c325bd9d-df08-4172-45a8-08d92b105625
X-MS-TrafficTypeDiagnostic: CH0PR11MB5233:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR11MB523388E01C7BB85CDF868958E0369@CH0PR11MB5233.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KB0J174kPrrC1TFG/fZq1qJ8lKzzRZ0+xju4XDwd9WVTgajqJqCeqkqNVAvNA8Ktzxi+fS/Rs7c0xfIG1/k4JgvejOQ8SFNyoZqz3JJcYlGW+n9PzVIUzRmiU8cS8dCpM8hLwtn8ASE71FGFDKIxSNADQoP7uyeX+htWHe5o4LRXhojHC7wrY8Hx9NP6zVlEXt4HemWoemZ32i1zZjv8nul3Bwczb3xd7OlmzdHuiud/uLJUdrcDS7G2AT2Mv0k9hBbBUDKcWUOIprjYKQR54LRK9uopFR/lP7Hbsch3KQz72SXRSJ3ue6qyJBIx4NUg6dHCbUVELFlU5uQrt0KOvUORjFWFCo9iW/aaX0m16tSiICDWHZEq6Q21VDp0w4Jp2cxwv6rKf9nkiSMA4b+jlbECekBLFJddaHLPk0lRssHDjoT1K0yGfBnzFDPC6IBLHqdu0AdOhHF4F6Q0kJVsTFKZiERfc13ceKcpomQEr2lIclbFocbNgaq80Q1I7tfeszM6suPYraFWaQIti5sMB9M8DOzLM4n63ha1z40a/BxLIvKYpYYA4cZEOUQB1cRnWZFxfKoNBC8qPVyyMTQH1br8fxgZW9EjcSOUvzCZ52bgP/HvFxS0fLsYGKKwSbrjTDZFtOnUVyOmJBrzteYwotddkj6ViQAMO0NovvYVwYVgNPleKKEHBMZST4PdhTBKpmMFzxkAw4vrlDU2HoJwoCVscF7czl/hJdRIPWwKmjzxRYNjr10A7uWBJOenqdy/nGzBR6EtexYXk0sSCQ/HE3XIwI5zJX5r6dQY3jZXrJagrFAZBst+6R9fqdAZPDEZEMUlYnZ0ePxxVYmqCKPc/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR11MB4454.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(366004)(39860400002)(136003)(83380400001)(5660300002)(66476007)(66556008)(75432002)(66946007)(110136005)(38100700002)(54906003)(38350700002)(31696002)(966005)(786003)(4326008)(6666004)(16576012)(31686004)(86362001)(316002)(8676002)(186003)(6486002)(36756003)(478600001)(8936002)(26005)(7416002)(2906002)(53546011)(16526019)(2616005)(52116002)(956004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGRRb0k3SFNkeEhuRDY1K3d0QXhWbGdScm5mbWpTeFI0KzlGSlcwbnYzZEFF?=
 =?utf-8?B?TWpLK1ZHM25CeEd5T3hYNUVFNzg1ckRMQWxXTWV4V1ptNE1KWXN5a3E0aDA3?=
 =?utf-8?B?cjl6cm42RElTQW1lSXF4R25yM2ZhVnpoUDFJY3BVLzZkMnZmYklpNm8vejl5?=
 =?utf-8?B?Y0lOUHZmbmNtd0Qvd0k4WmIveDV0NEZFVmxyaU91bXBaMEZ5ZjhHZzdTaGh1?=
 =?utf-8?B?VXdNcjZza05jdVA3SG5wWXY1ZjZYSEtESnlpdU5TKytacUt0cUd1Y081MnVq?=
 =?utf-8?B?WDJ6RS9FK0ZBZ1M5d0lLaENFU0N3Z0Y0UnFUU1hwNVFaeUdmNHJ1aCtPS1BJ?=
 =?utf-8?B?M0ZlVTl0MFhZbU9abEdRNXY0U2tZaHhrR1lOSEV3MWp6QjlSNWltakM1cHFq?=
 =?utf-8?B?VVdoaE1VMmpNMzVWeTVZbjJqbzZvcXdaNzdpd3hNV01DVlpBZEtyZ3JuNmFo?=
 =?utf-8?B?UjFhcnJ3VTR5eE5LUjNRZ3JYcDdUR084bE5JWnFZbXJOTENCREtVWnB0Y0FD?=
 =?utf-8?B?aGwvTncrVTA5QTRQYnRDNzI2NlU5elBzWlVGRmJ6NVUrL3NYSU9BU2JOdGRx?=
 =?utf-8?B?UjAxS05YcWVvK3FEdGRtOVlzeTBRWHBSTU0xeHhMVVMvRC9zcDROY3JQWGN0?=
 =?utf-8?B?OWs5eXBsQzFlUmgySVVVMm9SMjVDZFc1MzVzNkFiWEtDWkJ6Y3BuZEtPemFh?=
 =?utf-8?B?cjM5aEk0Smlic3F3Nm5ZeUVaaFRRMlJsekNjUTdwQlpqZ0Q3WHVlOG5CVzdh?=
 =?utf-8?B?UlBib3l6WlRsMTRFd2VXQlNJQnVpLzhuVUZNYlhhMjhyU3VReXZTUGpDUlIy?=
 =?utf-8?B?Y0tMYUxPMFN4YmJ5QmQ2U2tNcGtBKy9xZ0lSSVplUVFVTlQ5RWNOa1dXRlp5?=
 =?utf-8?B?WWpzV2FJNXJRVVQyTmJDTUdZb2h1Rk1iUzdjdXlVY3pFdVcxUEFZWWErTGJH?=
 =?utf-8?B?V0NnOFBzUDZJTjErY1dwRDBTcFNEUzV6L1RqdUVTMjc1V0plOXJia2lDbVRV?=
 =?utf-8?B?RUdCQ2FCa2ZsUzFkc2haSW1neTVjUVJqRG5BOS80aVE0TTNPSW9tbCtLalR2?=
 =?utf-8?B?dDEveHZjc1o0L2p3QXhRS1pWWjY0UkovOU5uSkxIQUpyMHFNK2NTWEZOUnN3?=
 =?utf-8?B?cEhlak5HekNYRGw5M0tlNCtKMWVGMGRxSnA0TG1rNGlFTTkxeXBPbis5Zm16?=
 =?utf-8?B?R2xYOThHdUowMWFPL0RzNkpkdFlsVGNWMHNkYjMzUlBReE5LOXYrUEg0K2xU?=
 =?utf-8?B?RmQzc1JiMDJ5N0YweE1pYXdZUVJ4UzhmZytTNjgvRFdsWENQc3E5L0lTMU5l?=
 =?utf-8?B?d1NwNDJCT0FRUkxKU3VhWURiZ2JXVEtZWVlVNWFTbEYwcmZSVVdlTlFud1Fs?=
 =?utf-8?B?QkVJU2FOL1htd21NNHloT1NnSGNmTW12b1Q1WHhPbjNEVlphK2NRM2sxYTJq?=
 =?utf-8?B?WEdqOVl2RVBQeTk1MURUWEFsZmNITUtaeEd2akNzOXF3WW9yZXF0NnZqSVZw?=
 =?utf-8?B?TStVNklRQXpGMlhPbFlIeXh3NUdHMkRRS2dvYnJESjFqK3FhNVNKa3JpM0R1?=
 =?utf-8?B?VlJsRVJvTWFWQW4vSUg1c0NNZ3JSc0h2TlBzVkcvRGF6MFdGTEs2N0FEMjZF?=
 =?utf-8?B?ckVTNFMzRVpaU1N4V3FhdUFRM2hCcDZ2N1pVYVFQZVZLaU8yQ1JuSEFZZWpi?=
 =?utf-8?B?N3hoaGtJYiswR21ia2ZuNm9tb3NxWkFvUWVTdGlnVUdaWFM0UzYwRHA5eVZJ?=
 =?utf-8?Q?+j7bNWK+Wd9/Kx0Y+KVDXf8CAuMBpfMfDeKsD0h?=
X-OriginatorOrg: illinois.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: c325bd9d-df08-4172-45a8-08d92b105625
X-MS-Exchange-CrossTenant-AuthSource: CH2PR11MB4454.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 06:32:21.6748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 44467e6f-462c-4ea2-823f-7800de5434e3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dfDVLYXfJof0GmF565yjh10b0lz696OEvoeDKY5/ZxQY4odD73bHAFlXX6WVOro3XkWswA+b3vmLg6sXJxI75Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5233
X-Proofpoint-ORIG-GUID: FdvgFrfwUjYbsA3PuNgYHtpXvQiu5Ul0
X-Proofpoint-GUID: FdvgFrfwUjYbsA3PuNgYHtpXvQiu5Ul0
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106090022
X-Spam-Score: 0
X-Spam-OrigSender: jinghao7@illinois.edu
X-Spam-Bar: 
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 6/1/21 2:55 PM, Kees Cook wrote:
> On Thu, May 20, 2021 at 10:56:13AM +0200, Christian Brauner wrote:
>> On Thu, May 20, 2021 at 03:16:10AM -0500, Tianyin Xu wrote:
>>> On Mon, May 17, 2021 at 10:40 AM Tycho Andersen <tycho@tycho.pizza> wrote:
>>>> On Sun, May 16, 2021 at 03:38:00AM -0500, Tianyin Xu wrote:
>>>>> On Sat, May 15, 2021 at 10:49 AM Andy Lutomirski <luto@kernel.org> wrote:
>>>>>> On 5/10/21 10:21 PM, YiFei Zhu wrote:
>>>>>>> On Mon, May 10, 2021 at 12:47 PM Andy Lutomirski <luto@kernel.org> wrote:
>>>>>>>> On Mon, May 10, 2021 at 10:22 AM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
>>>>>>>>> From: YiFei Zhu <yifeifz2@illinois.edu>
>>>>>>>>>
>>>>>>>>> Based on: https://urldefense.com/v3/__https://lists.linux-foundation.org/pipermail/containers/2018-February/038571.html__;!!DZ3fjg!thbAoRgmCeWjlv0qPDndNZW1j6Y2Kl_huVyUffr4wVbISf-aUiULaWHwkKJrNJyo$
>>>>>>>>>
>>>>>>>>> This patchset enables seccomp filters to be written in eBPF.
> Before I dive in, I do want to say that this is very interesting work.
> Thanks for working on it, even if we're all so grumpy about accepting
> it. :)
>
>>>>>>>>> Supporting eBPF filters has been proposed a few times in the past.
>>>>>>>>> The main concerns were (1) use cases and (2) security. We have
>>>>>>>>> identified many use cases that can benefit from advanced eBPF
>>>>>>>>> filters, such as:
>>>>>>>> I haven't reviewed this carefully, but I think we need to distinguish
>>>>>>>> a few things:
>>>>>>>>
>>>>>>>> 1. Using the eBPF *language*.
> Likely everyone is aware, but I'll point out for anyone new reading this
> thread: seccomp uses eBPF under the hood: all the cBPF is transformed to
> eBPF at filter attach time. But yes, I get the point: using the _entire_
> eBPF language. Though I'd remind folks that seccomp doesn't even use
> the entire cBPF language...
>
>> [...] but Andy's point stands that this brings a slew of issues on
>> the table that need clear answers. Bringing stateful ebpf features into
>> seccomp is a pretty big step and especially around the
>> privilege/security model it looks pretty handwavy right now.
> This is the blocker as far as I'm concerned: there is no story for
> unprivileged eBPF. And even IF there was a story there, I find the rate
> of security-related flaws in eBPF to be way too high for a sandboxing
> primitive to depend on. There have been around a dozen a year for the
> last 4 years:
>
> $ git log --oneline --no-merges --pretty=format:'%as %h %s' \
>     -i -E \ --all-match --grep '^Fixes:' --grep \
>     '(over|under)flow|\bleak|escalat|expos(e[ds]?|ure)\b|use[- ]?after[- ]?free' \
>     -- kernel/bpf/ | cut -d- -f1 | sort | uniq -c
>        4 2015
>        4 2016
>       13 2017
>       16 2018
>       18 2019
>       12 2020
>        6 2021
>
> I just can't bring myself to accept that level of risk for seccomp.

I just want to clarify that the patch is not supposed to add more risks 
to seccomp.


The vulnerabilities of ebpf are inherently there as long as ebpf is 
supported, no matter whether Seccomp supports ebpf filters or not. If 
ebpf is of concern, one can turn off ebpf completely and Seccomp ebpf 
won’t be available. Otherwise, the vulnerabilities are in your socket 
filters anyway.

> (And
> yes, this might be mitigated by blocking the bpf() syscall within a
> filter, but then eBPF seccomp would become kind of useless inside a
> container launcher, etc etc.)

This is an interesting point. I think the main concern is still about 
the additional risks (which I responded above).


I responded to Christian Brauner earlier about the security model. 
Basically, the implementation is as restrictive as user notifier and 
ptrace. For example, if CAP_BPF is not there, the container won’t be 
able to load ebpf filters with tracing helpers.


In fact, one can load the ebpf filter first and then block the bpf 
syscall (if it makes things more secure).


Best,

Jinghao

>
> -Kees
>
