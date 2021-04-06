Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430593558F2
	for <lists+bpf@lfdr.de>; Tue,  6 Apr 2021 18:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244267AbhDFQNx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Apr 2021 12:13:53 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:29954 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229869AbhDFQNv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 6 Apr 2021 12:13:51 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 136GDTcf016362;
        Tue, 6 Apr 2021 09:13:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=3nYvEttBdM2LmNLELqJboX5655z605vXf5kbxZ0wBb0=;
 b=e/3ixr4TazvDu6qbnsEwP1C7Je0DxGh0fFNfdoNJ27rNU+ugI4PZAZ6qQNJgo42APCPV
 ZKkNSn+1JoYafuyFtGXZjUti2pXX570TTCuiUtdxVTam6O5hkj69Czb7P9JJJw8iVwPS
 z5uqA/ZwNr/qJOQKiVLQHcDQks9LAOPaLwc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37raej4jwd-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 06 Apr 2021 09:13:30 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 6 Apr 2021 09:13:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOb7Jr9VfeV4hE5G4aUvqEWtntoQEbXq0rE7DTfWNfO4giiXP0AWFC+UYlzpLovVNdXqrIvJ0b8PfvxvNkl5DiWuTD3DwFH27QrmDOg4MVSyx2iVWzrs5IgHJyMF56luPPa9h30waDo3AyQw91GENg+a3WMEtuNm95+Rwzri7SBkQXqFk5s2GL4F2y2ZVPuFfcJm7T+fIFkLSp2DiXMqC/kvoQDCtjgEH7cUUQ+w0jpc/65+vCs/5HVLhehErJFYySzbSGxXHFwHmTKFMvdmousJbvlaX3VrjOE2nabCCV+UGJAqTAaBl9GKANwALfSFbwv04EKMZRZby+4XVYHbTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27sl0WrrUifH4Ue5xMJdoGBuv2KsWDDkUQdfLlRxKas=;
 b=WdXYwg2iMFkBYmehGIIah0Yc+aylAWkYmwtMmnXQp23mV90TTszcqVuSvT/92OLgLLZ8036RVidm2gJc05inlZPqsz8erzcH0VECAph37+AtxdJsFToDtceb01jiCQDnp+bSJX5n+ht2yh0AJjNjLAE4HujsexXTJSTp21Q29uc30/QNKP4ntr5A3oY9cyAC5uhsg/E7U0TreuIIfrJwxLoozQiHeArnsT6Ex7UXhcDAf/3mAf0gc+jo7pkXLEZyehVHfHddUjE0V2goQK6iS76YD1D4Q0XYNm5ktXWELxbjQxTp6SurU+NR5xrEYHJ3dIkK9FXyYNvNYlkDvH0bvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4433.namprd15.prod.outlook.com (2603:10b6:806:194::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Tue, 6 Apr
 2021 16:13:28 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 16:13:28 +0000
Subject: Re: [PATCH kbuild v4] kbuild: add an elfnote for whether vmlinux is
 built with lto
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
CC:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        bpf <bpf@vger.kernel.org>, <kernel-team@fb.com>,
        Bill Wendling <morbo@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
References: <20210401232723.3571287-1-yhs@fb.com>
 <CAKwvOdmX8d3XTzJFk5rN_PnOQYJ8bXMrh8DrhzqN=UBNdQiO3g@mail.gmail.com>
 <CA+icZUVKCY4UJfSG_sXjZHwfOQZfBZQu0pj1VZ9cXX4e7w0n6g@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <c6daf068-ead0-810b-2afa-c4d1c8305893@fb.com>
Date:   Tue, 6 Apr 2021 09:13:24 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
In-Reply-To: <CA+icZUVKCY4UJfSG_sXjZHwfOQZfBZQu0pj1VZ9cXX4e7w0n6g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:5b04]
X-ClientProxiedBy: MWHPR17CA0068.namprd17.prod.outlook.com
 (2603:10b6:300:93::30) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::142a] (2620:10d:c090:400::5:5b04) by MWHPR17CA0068.namprd17.prod.outlook.com (2603:10b6:300:93::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 16:13:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0b26c19-211a-468b-0837-08d8f916e9bc
X-MS-TrafficTypeDiagnostic: SA1PR15MB4433:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB44330D1277E2F3C8E2D088C8D3769@SA1PR15MB4433.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PriUwaEoscPU8/oAICgMBOtj+bKk8BO8NLph+nPdrGxLimYP4mPE6Cqr/k//QQ1hWY4HJ+Entmq6TfEvTHpZ5F8efayxqHsvHSg22DzZ28eOCsQ60rc+D2U0Iwm9oTqazoA1n/TBOw1ncx3FDP55RwHL2oWgJ06YaziK1viKXcIsdB2itldEGanVxA09Xhl3RY+u/n7wloTby2D3fmRmtvlB1DgT/11/892datCs7vxRbbchz8Z60YVF58FUQ73uSZI6ibA3Vh7QBMYFt+Btwcn8dEOTken3QnfRsr6htytImxCbDOdhkR+JQD7Aq7pGnNKpRHFgxrAoJE6ccwHKI71PlwNnawBx0ScxZ5bh/PRKZXsa2w4r6BIRlQYlAyGD9UHPmhQ+s/ZtpP04/hA6mACisrDn8WwcxI6UJ8GChYBQXIyPKx2id3AvEDZ4UIPj9Er2cAjipy3br4nt3B5Bp8Ns8OqVWxeSqEw9T2y1FtiV8ZnibyskHGgVfetVH/XgmO36YtKYUGJTgTo35q6JWKu5wHDbrIuDN0V/NL4ma0l89pJcHzJe2pw5qxx5jnd78PUx8Dakm9dJaX86+qwh9NdUiH8z/5GiAKGELGtr2m9Rf4Z/hNXau5UMz2Lwhqx3lU6WDeg9dVgSB6qbm7TelNp+onG6e0FvKai+7d9PPjDOAUsp3iNsYp5LPjVkuxm25yst+UwuvGkm6NTdnqIZfrnYmiMt5tdmZJ1JnBTdumKCyv049GW++a9S4mcUPbHvmh1G4PrWdBZ8ta3rixxmEYKs27zDUUJ9KxFjZD3/JMU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(39860400002)(136003)(396003)(7416002)(16526019)(52116002)(186003)(8676002)(54906003)(36756003)(966005)(5660300002)(31696002)(110136005)(316002)(6486002)(53546011)(2906002)(38100700001)(86362001)(8936002)(478600001)(83380400001)(2616005)(4326008)(31686004)(66556008)(66476007)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?a3BwQWs2cXdJa2FwTi9FVFI5WEd4SWhrd2Z0TGlIdUQwbnEya3ZRSEZvdHVZ?=
 =?utf-8?B?aHVwMkRrUzIzTHRWQUtPeTY2MllhV2dSOTZZMzdiUHYzSzlVbSt0ODVFb3Bl?=
 =?utf-8?B?Mm9hQXVLVzZjeU5zN3lwNU0rZ1RlR2FYQ0hRQzBIZTNPNkpRWkxqc2JQNkRB?=
 =?utf-8?B?ZUIxM1g4cXU3cHFPcHNnUDRVRzRCOWEyRnNTVkNLMmNpYzluTXVpNUg5SDE3?=
 =?utf-8?B?bWVIQkQ4OWNIUEY0cVo4MWlCaWNwbmxMdWVrNnhDVUpxK0F0L1VzbVppcXhL?=
 =?utf-8?B?NEpqaUh1eUk4ZFZyRStxUjFWeDFVR0syS1VBQlpEOEg1UWhMUWpZUGczZ1Ro?=
 =?utf-8?B?RHBveU12Qkl0Z0tEWFVad1VqbWFrcU1sSWowSHBOeHNHUGZxZ0tEMUtFWkNY?=
 =?utf-8?B?QnJWN1BmRm1keWIzaVE0Zm53V25rT05zZUludEcyZ3VaaCsrUDdtc2FSU0NZ?=
 =?utf-8?B?d0lzVDdHRWJ1WGxkV3VOclZobWFITmppYXNiLy9LaTZYMVpZK1p6Z3BZMG5t?=
 =?utf-8?B?a3RwaXBIakp3Tmsra014WWhlalY3OTJWazRVRTNNQjFiVjd6MTdTV1pmWkht?=
 =?utf-8?B?OXp1MWJmS05rRlRXbkNKaXNZNVMvK01XYi9odzdtVFZoU0IwM1JLNFl4SWln?=
 =?utf-8?B?Z2x0YkErTEViVi9kelY5eWUvcFE2SEdncUJJSlVpVmRndDBUbW1vWFl2dUN1?=
 =?utf-8?B?RUVpaEZjbTZiSmFRNFFSQXo1R1RES2dvTXAvNy9sUWdxYUdyNkpqTW1ORnE2?=
 =?utf-8?B?Yjd0MGlFbjdwQnJrd1cxRzZrc1hPZGFXMlFjUGZpVDFaN0JxdG9xZDIyY1R6?=
 =?utf-8?B?YU5tT2tGZGdrUXoxRk5MeThWc1FueWxBcjhNVTV3aGt4TW9wS0JGUjVacFN1?=
 =?utf-8?B?RUhIK2V4aDJNaFRkOUZRM3I5SmlOVzVUM1JxMENyeXlWVjRhYlY0bytsZUF1?=
 =?utf-8?B?L0xldmowUXQ1eW4vdlN0YnlLcHhtUzFRem5pV3ZEOTA1OCsyTFBEZWdnS1Iz?=
 =?utf-8?B?MjM3RytWbmVvOHg2MWIzUUw2eEwwOSttTy9UY2lFZUg2c1VYMGxURFFPWE9Y?=
 =?utf-8?B?bHJSUU1SUVhqUDYyTE9COFAvVzBXemQ3NXpOWDkxaXZZVWdEMWNEaGxvOGlY?=
 =?utf-8?B?YmxzNTI0Y2p3WWg1eFBpLzJrSzMrSDJ0bzRHNnJPcDA4RWJuSldkYSszRTVx?=
 =?utf-8?B?OUlUMW9Xbk4rcndZcDVMNzBiaWUrdlp5Z2kyWmlmSVcxNTMzSmluU1RaTjRo?=
 =?utf-8?B?K3ZWcTNaOEkvODVhQVBWQlEveDl4eVU3QUw4c3lMSDY0VmtUdFAzUnBIYmpM?=
 =?utf-8?B?V2tmN0ttbTZiMDE5Y1BCdlJNYlIzNlNnQXVBRkhyRnhrZzJKM1FBUFVEV3V3?=
 =?utf-8?B?S0tGS3BnM1hxL2lINzNEekVlU1JHZU5NdEtXSTZDbVA0T29jblErNTg4M1JY?=
 =?utf-8?B?YVZZUEQwWUs5aUVNZkdOV2MvbWJudlZvNzR0azVNU1YxeGxvcXY5dGdtQVNI?=
 =?utf-8?B?NGUwY1JCUVVoMmpKNU0yczNETjliODZCd29JcTUwVlZNNFVSZWk5ZVQveTZm?=
 =?utf-8?B?WVpuN2hwQVR5OSsxd0lFRExCdzEreGVlaGV5RXhnd3FDWW5qMVJTQ1NDUkxP?=
 =?utf-8?B?MWwrS3RNd1JZcExwKzZITTMzNXhhUjI0NWNqRDZ3aE5WemhJaWpseVBZTFpn?=
 =?utf-8?B?Y2RVWmxQSlhXL3RJSXVzbTNzbTZXWWdXejZuREVVLzBKdmJCVVJrZm1seUdl?=
 =?utf-8?B?RmxWREdIZGN1TXB1dmdLRitETE1iV2NuaWFJeFM2NENoY3hRUlFMa241bHdv?=
 =?utf-8?B?L2FnUHgra3VDTXE3UHRxQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b26c19-211a-468b-0837-08d8f916e9bc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 16:13:28.0645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ptpTg+sNabCLC66pfBjP9R9qFeQiKAV8PfamO8zLXjCQj+FwyRE8lEPNM1tbIiy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4433
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 6lHsmSV-bQFaUjFUeBMe998lBMhSt4TI
X-Proofpoint-ORIG-GUID: 6lHsmSV-bQFaUjFUeBMe998lBMhSt4TI
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-06_04:2021-04-06,2021-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104060108
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Masahiro and Michal,

Friendly ping. Any comments on this patch?

The addition LTO .notes information emitted by kernel is used by pahole
in the following patch:
    https://lore.kernel.org/bpf/20210401025825.2254746-1-yhs@fb.com/
    (dwarf_loader: check .notes section for lto build info)

Thanks,

Yonghong

On 4/6/21 12:05 AM, Sedat Dilek wrote:
> On Fri, Apr 2, 2021 at 8:07 PM 'Nick Desaulniers' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
>>
>> On Thu, Apr 1, 2021 at 4:27 PM Yonghong Song <yhs@fb.com> wrote:
>>>
>>> Currently, clang LTO built vmlinux won't work with pahole.
>>> LTO introduced cross-cu dwarf tag references and broke
>>> current pahole model which handles one cu as a time.
>>> The solution is to merge all cu's as one pahole cu as in [1].
>>> We would like to do this merging only if cross-cu dwarf
>>> references happens. The LTO build mode is a pretty good
>>> indication for that.
>>>
>>> In earlier version of this patch ([2]), clang flag
>>> -grecord-gcc-switches is proposed to add to compilation flags
>>> so pahole could detect "-flto" and then merging cu's.
>>> This will increate the binary size of 1% without LTO though.
>>>
>>> Arnaldo suggested to use a note to indicate the vmlinux
>>> is built with LTO. Such a cheap way to get whether the vmlinux
>>> is built with LTO or not helps pahole but is also useful
>>> for tracing as LTO may inline/delete/demote global functions,
>>> promote static functions, etc.
>>>
>>> So this patch added an elfnote with a new type LINUX_ELFNOTE_LTO_INFO.
>>> The owner of the note is "Linux".
>>>
>>> With gcc 8.4.1 and clang trunk, without LTO, I got
>>>    $ readelf -n vmlinux
>>>    Displaying notes found in: .notes
>>>      Owner                Data size        Description
>>>    ...
>>>      Linux                0x00000004       func
>>>       description data: 00 00 00 00
>>>    ...
>>> With "readelf -x ".notes" vmlinux", I can verify the above "func"
>>> with type code 0x101.
>>>
>>> With clang thin-LTO, I got the same as above except the following:
>>>       description data: 01 00 00 00
>>> which indicates the vmlinux is built with LTO.
>>>
>>>    [1] https://lore.kernel.org/bpf/20210325065316.3121287-1-yhs@fb.com/
>>>    [2] https://lore.kernel.org/bpf/20210331001623.2778934-1-yhs@fb.com/
>>>
>>> Suggested-by: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>
>> LGTM thanks Yonghong!
>> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>>
> 
> Thanks for the patch.
> 
> Feel free to add:
> 
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM/Clang v12.0.0-rc4 (x86-64)
> 
> As a note for the pahole side:
> Recent patches require an adaptation of the define and its comment.
> 
> 1. LINUX_ELFNOTE_BUILD_LTO -> LINUX_ELFNOTE_LTO_INFO
> 2. include/linux/elfnote.h -> include/linux/elfnote-lto.h
> 
> - Sedat -
> 
>>> ---
>>>   include/linux/elfnote-lto.h | 14 ++++++++++++++
>>>   init/version.c              |  2 ++
>>>   scripts/mod/modpost.c       |  2 ++
>>>   3 files changed, 18 insertions(+)
>>>   create mode 100644 include/linux/elfnote-lto.h
>>>
>>> Changelogs:
>>>    v3 -> v4:
>>>      . put new lto note in its own header file similar to
>>>        build-salt.h. (Nick)
>>>    v2 -> v3:
>>>      . abandoned the approach of adding -grecord-gcc-switches,
>>>        instead create a note to indicate whether it is a lto build
>>>        or not. The note definition is in compiler.h. (Arnaldo)
>>>    v1 -> v2:
>>>      . limited to add -grecord-gcc-switches for LTO_CLANG
>>>        instead of all clang build
>>>
>>> diff --git a/include/linux/elfnote-lto.h b/include/linux/elfnote-lto.h
>>> new file mode 100644
>>> index 000000000000..d4635a3ecc4f
>>> --- /dev/null
>>> +++ b/include/linux/elfnote-lto.h
>>> @@ -0,0 +1,14 @@
>>> +#ifndef __ELFNOTE_LTO_H
>>> +#define __ELFNOTE_LTO_H
>>> +
>>> +#include <linux/elfnote.h>
>>> +
>>> +#define LINUX_ELFNOTE_LTO_INFO 0x101
>>> +
>>> +#ifdef CONFIG_LTO
>>> +#define BUILD_LTO_INFO ELFNOTE32("Linux", LINUX_ELFNOTE_LTO_INFO, 1)
>>> +#else
>>> +#define BUILD_LTO_INFO ELFNOTE32("Linux", LINUX_ELFNOTE_LTO_INFO, 0)
>>> +#endif
>>> +
>>> +#endif /* __ELFNOTE_LTO_H */
>>> diff --git a/init/version.c b/init/version.c
>>> index 92afc782b043..1a356f5493e8 100644
>>> --- a/init/version.c
>>> +++ b/init/version.c
>>> @@ -9,6 +9,7 @@
>>>
>>>   #include <generated/compile.h>
>>>   #include <linux/build-salt.h>
>>> +#include <linux/elfnote-lto.h>
>>>   #include <linux/export.h>
>>>   #include <linux/uts.h>
>>>   #include <linux/utsname.h>
>>> @@ -45,3 +46,4 @@ const char linux_proc_banner[] =
>>>          " (" LINUX_COMPILER ") %s\n";
>>>
>>>   BUILD_SALT;
>>> +BUILD_LTO_INFO;
>>> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
>>> index 24725e50c7b4..98fb2bb024db 100644
>>> --- a/scripts/mod/modpost.c
>>> +++ b/scripts/mod/modpost.c
>>> @@ -2191,10 +2191,12 @@ static void add_header(struct buffer *b, struct module *mod)
>>>           */
>>>          buf_printf(b, "#define INCLUDE_VERMAGIC\n");
>>>          buf_printf(b, "#include <linux/build-salt.h>\n");
>>> +       buf_printf(b, "#include <linux/elfnote-lto.h>\n");
>>>          buf_printf(b, "#include <linux/vermagic.h>\n");
>>>          buf_printf(b, "#include <linux/compiler.h>\n");
>>>          buf_printf(b, "\n");
>>>          buf_printf(b, "BUILD_SALT;\n");
>>> +       buf_printf(b, "BUILD_LTO_INFO;\n");
>>>          buf_printf(b, "\n");
>>>          buf_printf(b, "MODULE_INFO(vermagic, VERMAGIC_STRING);\n");
>>>          buf_printf(b, "MODULE_INFO(name, KBUILD_MODNAME);\n");
>>> --
>>> 2.30.2
>>>
>>
>>
>> --
>> Thanks,
>> ~Nick Desaulniers
>>
>> --
>> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/CAKwvOdmX8d3XTzJFk5rN_PnOQYJ8bXMrh8DrhzqN=UBNdQiO3g@mail.gmail.com .
