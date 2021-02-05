Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77050311114
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 20:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbhBERmf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Feb 2021 12:42:35 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41182 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233403AbhBERjb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 5 Feb 2021 12:39:31 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 115JE6h2001696;
        Fri, 5 Feb 2021 11:20:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=R0hFCTR8cMVQ/H+DHrsnbj6m9o2lxNuSDhIpRKPWM3A=;
 b=EiXOxXRFG6BOVKutA5nYn25phbqIItUZp8xlgs87s6tvvuiZ/HQXnf2WkToi5VI+HItk
 MOHgpFhZ6HWjLngopR9+HF8CfF8SpU3fmgH1QonZ620NluL5suutbNA3z+qIycqqZ/TR
 Y5BV1zdjTckNgLOr1MrHh6QvlRu/O6S6aSA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36h2wb2rxq-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 05 Feb 2021 11:20:59 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 5 Feb 2021 11:20:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLC9Rf3HwnjHhno07AVwIBHARzb1mLdo/2YRcVtqm/Tj7d7bbpev9WwtN7YQtlCQ+j0RQwEVHjHq3uLDtek5scp1W6Z5f72/1BlPquzUMk+g3OJvDzQJ944/C5P/XtVFkCR1eEATZQ8eCr3HeKTHOWRYPSwrDgJ3o3xFNLzYWLPdaWNNFe4UPtH8pUeU/a6r9JubY1imR+FPrvvRlto/jNKRTXqNmqrjAcFlXgLEPFv3vZa8JQsujT0A/mvmS23dPv3q09pveallqMKeowReYDH5bvBRkSDYQ8tkyZSjZN/xcD5MKoyiARKH3NBMqvMzET84g8pCxzOj6xOfmVH3jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0hFCTR8cMVQ/H+DHrsnbj6m9o2lxNuSDhIpRKPWM3A=;
 b=beaycUSKkD1/4XaPXLgHg8ySPgDwMMHCMHu2ufZVFvbNtpsKlURChvRaVk43BQtTT6Ig5JS5ld5d3EWqOwaDPBlkTnhB7RlKxMD/Tbz73J7UMnfGCLcJSgE56Zpv8WtyCfo0eOz+pa8Zbhnne7W18WRN0aoe+B4c3xMeoTUqe9Nfwe2pBTrP8L1yA1R6uMxiTk2DHYeHnUhi29CstdjPN4xtCyQKSHmPhEwsnGXVd01QpIemb0vo8BhdwilebAlceHiFBx5EoKTyAA1JucakXyjTGWCxHnvBVZHBJdehydoj6mXtEsNaGIDbZALb5vp1CEEsCTcgyl1yGHmhbhT2UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0hFCTR8cMVQ/H+DHrsnbj6m9o2lxNuSDhIpRKPWM3A=;
 b=ejZWWUKzc85iVkHPVvmQ/lcswgHXvifYHbIiTAFY0RShx1riVT+d1TFTjYyUUBptKI9WN/EnRfGRRgZaOQZywzDu/DWNBwACPhkoZ5aWMBmuTvS/N3rnEpGK0akGkVyTOHUDmtNE9rO2P4+QYxQbvPO+WDH0P/xVrdGlR1l8bMs=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2696.namprd15.prod.outlook.com (2603:10b6:a03:156::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.26; Fri, 5 Feb
 2021 19:20:54 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5%5]) with mapi id 15.20.3805.028; Fri, 5 Feb 2021
 19:20:53 +0000
Subject: Re: ERROR: INT DW_ATE_unsigned_1 Error emitting BTF type
To:     <sedat.dilek@gmail.com>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Domenico Andreoli <cavok@debian.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Mark Wieelard <mjw@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
        Tom Stellard <tstellar@redhat.com>,
        Fangrui Song <maskray@google.com>
References: <20210204220741.GA920417@kernel.org>
 <CA+icZUVQSojGgnis8Ds5GW-7-PVMZ2w4X5nQKSSkBPf-29NS6Q@mail.gmail.com>
 <CA+icZUU2xmZ=mhVYLRk7nZBRW0+v+YqBzq18ysnd7xN+S7JHyg@mail.gmail.com>
 <CA+icZUVyB3qaqq3pwOyJY_F4V6KU9hdF=AJM_D7iEW4QK4Eo6w@mail.gmail.com>
 <20210205152823.GD920417@kernel.org>
 <CA+icZUWzMdhuHDkcKMHAd39iMEijk65v2ADcz0=FdODr38sJ4w@mail.gmail.com>
 <CA+icZUXb1j-DrjvFEeeOGuR_pKmD_7_RusxpGQy+Pyhaoa==gA@mail.gmail.com>
 <CA+icZUVZA97V5C3kORqeSiaxRbfGbmzEaxgYf9RUMko4F76=7w@mail.gmail.com>
 <baa7c017-b2cf-b2cd-fbe8-2e021642f2e3@fb.com>
 <CA+icZUWESAQxWb6fvhOY0CxngLY3z4kOiZS2vPtSD5tDaSve-g@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <f985c88f-6084-c3ad-922c-ef1f69b12dd6@fb.com>
Date:   Fri, 5 Feb 2021 11:20:50 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
In-Reply-To: <CA+icZUWESAQxWb6fvhOY0CxngLY3z4kOiZS2vPtSD5tDaSve-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:b8ac]
X-ClientProxiedBy: CO1PR15CA0064.namprd15.prod.outlook.com
 (2603:10b6:101:1f::32) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::11b4] (2620:10d:c090:400::5:b8ac) by CO1PR15CA0064.namprd15.prod.outlook.com (2603:10b6:101:1f::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend Transport; Fri, 5 Feb 2021 19:20:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31d7626d-d1ea-4a38-9bd5-08d8ca0b27fb
X-MS-TrafficTypeDiagnostic: BYAPR15MB2696:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2696C3E5F44EE5B32F455B7BD3B29@BYAPR15MB2696.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:47;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7cjbECBF3CCUADtaX8Eeusx+pX9xYm24W0jR1qUMIG377Qwl36b6TkjMPGVk9EcRwlCIZGx9nE0qjwbp+cc43v45CuB+wR0bvj8/QRDUcUcM64e/R0TvF7m9iUPRj+MDxIpT3JDRwgIhIOOaxOmQguJugqae259V2oH+fVbIqVHTuzBQ4WxaffIBKCEycD/Lk/oHhr7IVa0ZyaGGI+/HUCqN7ASEN7J0Ou2azSCfnvZqX1bUp8UEbQeAdPINuCwoGcknmNyOPEB8ermgiA8+FRWDjQSrYGrhI5dEl5mnfhjEksh2RfZYxA7HuqSNDTT5tsoG2Ek/dZgexBArMqUh4bclf/jgKME5OWf5O9a67jXyGOc0kuMP7fitNoZuJ6asZ5XBu8a8ToMu04EWLYQYmkRAuqMX0MtcujatO/ZCSxc/1V0cDZmBJaSZhRMkg1oY3uS5N08XPoZpEiHd6I/ynXitrEfeSzIjekb6wH0Xzxb+ALax6tHjx2yxJJVUeh+9Gj5wI+PuzlPQjmaHlbXo0/+V25V8NoPU3Xzjo5rmftjMa9PqnIOEXU+ghKwLmQ1e2aBlokkCoFWtnIehUGeut1HFHDPnwaDewCCkcls1yp0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(376002)(346002)(39860400002)(2906002)(8936002)(52116002)(31696002)(66946007)(36756003)(6486002)(53546011)(66476007)(6916009)(66556008)(4326008)(31686004)(54906003)(478600001)(86362001)(8676002)(7416002)(5660300002)(186003)(316002)(2616005)(16526019)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Ymx4R2ppbTh1SDZPMUxhUVBJM2NqdTdBeTFaSWxITlkwd2tyTzJ4Z0pyS3hO?=
 =?utf-8?B?bCtvRWJJUVZ6WkluTUY1RjlXK3VGS2FKUTRlSEsvNHRoMDZ5U1BRQ3puYWJa?=
 =?utf-8?B?a3ZLbUlGZURuTEsyYjc1bUNLejRNV2ZkM1E0Szc3eHlOOVBKbmlGNWVJcWpi?=
 =?utf-8?B?Z2NpcEtQRmVhN2VkTnJ1WWRodjRUenpFVC9NZDR0WThtM0JmTnl2Y1JiSmFT?=
 =?utf-8?B?R2FSbUx2M3VpZFF2SkNFUi9uVHdEUXZqcjBFQ0hVaDdYWXR6bmprWHhoaHA3?=
 =?utf-8?B?WWRycXAzNXc2elZ0T2NJQkZvNGVNN3NnU20xckdjcjZjZ1Frd0piaGFFNUhw?=
 =?utf-8?B?VVQ3OS8rQ1lxN2xWVXRoUTZ0Q3RKZGJBWWR0Z21lNDlIeVVXUXZWdFgrR2wx?=
 =?utf-8?B?SEFjT1ZNbERiSGh1MXpGZmloU1BmUUV6YnIwUEdnbG5sTEJJVzBFbzdGUjIy?=
 =?utf-8?B?VmpQZlZBdFBZckttNnJuSWx1cGtVRU42cHZ6dThZcTVUQnhrSDJBTGIydG5y?=
 =?utf-8?B?Ny81Nm8wZXU1c29FQ0t1SmgyT25HQ0JlejVpazBoNk9HUFkva2dDTVNhV2xZ?=
 =?utf-8?B?VEVUT29uNHc1UFE4UCtGNmpjK0RSZEtrUlRpejFTVHZSL2w5KzI0eFloV0xQ?=
 =?utf-8?B?V1pJS2FvL2x0NzdJdjNUYVVIWEQyU2lKbWlLc01jSnlpTG41Q05IZVZMQmp4?=
 =?utf-8?B?VG15eUJHRHgxYm04ZVRmYm0rRUZBVVdkNk1qMlRpUjlVWC9wTFJuaWdYbzl5?=
 =?utf-8?B?MlNncjluOU5xWXIyYXNSalEzV00vQ0JsM042b1Q0WUlSY29ONDM0bEhqYzhE?=
 =?utf-8?B?LzVhYlhZakNIUVNGb2VObXQ1VkN4eCtuQmlRSCtWeXhTVkc1dnNCNGczVThF?=
 =?utf-8?B?RjB3REEwckJvV3hnWnNoUU5YM2hGWlpVay95emJQYXNBNTFhT1lUR0dNZkx6?=
 =?utf-8?B?RGZHMk5BZERwdUNkTnRwOUJ6bTdONytpakNYaDJETEhJYnVFeWFqOXZBRkwy?=
 =?utf-8?B?RU40bXlrbHJXRTFrMHB6MS9sNjNRRXFnR0ZiZFRrT01ydmxxVmphbncvelBB?=
 =?utf-8?B?b2NTUzdxd1ZhUFgvQndPSi81UHpxTllzeXNxUDFpa3MxbGZScGJORjcvblMw?=
 =?utf-8?B?cmN0RVpnTkVnbUsyNW9rYzQrU24wZWQ0dU5XbnptL21NSjBwb2VpNE1oeTJI?=
 =?utf-8?B?cDlIVTk1eGVNSS9FSnk1c0xBTC92bjFPRFJqUnRjYURnQUd1Um5TYXhDK1I5?=
 =?utf-8?B?Nk9XRVFxbHp0c0VDdUFHc0haYm9ucGZTM0N4eFRFbWdRVWFzdXJZQmtVOE1u?=
 =?utf-8?B?TUtKSEtyN3d2VjlJZTBtRlFyS2RpTDRSUEhBVkRnSHlDZ2VNeElZOU90WlFG?=
 =?utf-8?B?NFg1Mmg2WVF0dS9sMmtvUVptckRKVmtZTU12aFVrN2xSV0JFMFhVRzhGNHN0?=
 =?utf-8?B?QVlNQm9XU3drNG1tQ0xCQVFmdEljVVlJVE1zZWlFMDJKdXhHMzB2VGE2ajQ3?=
 =?utf-8?B?cG1zd25sek4ra2o3SE9yTTBIS09tOFR3WUdrTkJWcFdIbDM1alFyM0JnOFpZ?=
 =?utf-8?B?WkdxcEQ4ejgxQXRTaXZ1STJSRlprUzZHbWIrKzZCYmg2dDgyTTZ6aTF3SDYy?=
 =?utf-8?B?OGdMVkxQeHduVkp3SitiRHJENFBKTnVZKzlXSk9QYlI5bnNhR0hrYTlRVktO?=
 =?utf-8?B?QXVaVUo3L0J3Q2hKMHZWSnkwbzZ1ZDhKQnlVN0dLeEw2VnlpQzBlNWl4ajZZ?=
 =?utf-8?B?M3NvVGNsY3Y0TGE0YjJHQ0dPTEZLZ0lhODJZMzk2eUJZUlVzcWRJV3k5RHRY?=
 =?utf-8?Q?r8kNcMT8JywOatomZcPBlS9GuUZLK2reaVMXg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d7626d-d1ea-4a38-9bd5-08d8ca0b27fb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 19:20:53.8656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qe+h2AWhuBQWwKPNJUQLkvsJ8JdASTOCMz7bIMpviQwf8KyuPcQzUnp2qpyf86mD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2696
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-05_10:2021-02-05,2021-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 malwarescore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102050118
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/5/21 11:15 AM, Sedat Dilek wrote:
> On Fri, Feb 5, 2021 at 8:10 PM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 2/5/21 11:06 AM, Sedat Dilek wrote:
>>> On Fri, Feb 5, 2021 at 7:53 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>>>
>>>> On Fri, Feb 5, 2021 at 6:48 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>>>>
>>>>> On Fri, Feb 5, 2021 at 4:28 PM Arnaldo Carvalho de Melo
>>>>> <arnaldo.melo@gmail.com> wrote:
>>>>>>
>>>>>> Em Fri, Feb 05, 2021 at 04:23:59PM +0100, Sedat Dilek escreveu:
>>>>>>> On Fri, Feb 5, 2021 at 3:41 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>>>>>>>
>>>>>>>> On Fri, Feb 5, 2021 at 3:37 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>>>>>>>>
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> when building with pahole v1.20 and binutils v2.35.2 plus Clang
>>>>>>>>> v12.0.0-rc1 and DWARF-v5 I see:
>>>>>>>>> ...
>>>>>>>>> + info BTF .btf.vmlinux.bin.o
>>>>>>>>> + [  != silent_ ]
>>>>>>>>> + printf   %-7s %s\n BTF .btf.vmlinux.bin.o
>>>>>>>>>    BTF     .btf.vmlinux.bin.o
>>>>>>>>> + LLVM_OBJCOPY=/opt/binutils/bin/objcopy /opt/pahole/bin/pahole -J
>>>>>>>>> .tmp_vmlinux.btf
>>>>>>>>> [115] INT DW_ATE_unsigned_1 Error emitting BTF type
>>>>>>>>> Encountered error while encoding BTF.
>>>>>>>>
>>>>>>>> Grepping the pahole sources:
>>>>>>>>
>>>>>>>> $ git grep DW_ATE
>>>>>>>> dwarf_loader.c:         bt->is_bool = encoding == DW_ATE_boolean;
>>>>>>>> dwarf_loader.c:         bt->is_signed = encoding == DW_ATE_signed;
>>>>>>>>
>>>>>>>> Missing DW_ATE_unsigned encoding?
>>>>>>>>
>>>>>>>
>>>>>>> Checked the LLVM sources:
>>>>>>>
>>>>>>> clang/lib/CodeGen/CGDebugInfo.cpp:    Encoding =
>>>>>>> llvm::dwarf::DW_ATE_unsigned_char;
>>>>>>> clang/lib/CodeGen/CGDebugInfo.cpp:    Encoding = llvm::dwarf::DW_ATE_unsigned;
>>>>>>> clang/lib/CodeGen/CGDebugInfo.cpp:    Encoding =
>>>>>>> llvm::dwarf::DW_ATE_unsigned_fixed;
>>>>>>> clang/lib/CodeGen/CGDebugInfo.cpp:
>>>>>>>     ? llvm::dwarf::DW_ATE_unsigned
>>>>>>> ...
>>>>>>> lld/test/wasm/debuginfo.test:CHECK-NEXT:                DW_AT_encoding
>>>>>>>    (DW_ATE_unsigned)
>>>>>>>
>>>>>>> So, I will switch from GNU ld.bfd v2.35.2 to LLD-12.
>>>>>>
>>>>>> Thanks for the research, probably your conclusion is correct, can you go
>>>>>> the next step and add that part and check if the end result is the
>>>>>> expected one?
>>>>>>
>>>>>
>>>>> Still building...
>>>>>
>>>>> Can you give me a hand on what has to be changed in dwarves/pahole?
>>>>>
>>>>> I guess switching from ld.bfd to ld.lld will show the same ERROR.
>>>>>
>>>>
>>>> This builds successfully - untested:
>>>>
>>>> $ git diff
>>>> diff --git a/btf_loader.c b/btf_loader.c
>>>> index ec286f413f36..a39edd3362db 100644
>>>> --- a/btf_loader.c
>>>> +++ b/btf_loader.c
>>>> @@ -107,6 +107,7 @@ static struct base_type *base_type__new(strings_t
>>>> name, uint32_t attrs,
>>>>                  bt->bit_size = size;
>>>>                  bt->is_signed = attrs & BTF_INT_SIGNED;
>>>>                  bt->is_bool = attrs & BTF_INT_BOOL;
>>>> +               bt->is_unsigned = attrs & BTF_INT_UNSIGNED;
>>>>                  bt->name_has_encoding = false;
>>>>                  bt->float_type = float_type;
>>>>          }
>>>> diff --git a/ctf.h b/ctf.h
>>>> index 25b79892bde3..9e47c3c74677 100644
>>>> --- a/ctf.h
>>>> +++ b/ctf.h
>>>> @@ -100,6 +100,7 @@ struct ctf_full_type {
>>>> #define CTF_TYPE_INT_CHAR      0x2
>>>> #define CTF_TYPE_INT_BOOL      0x4
>>>> #define CTF_TYPE_INT_VARARGS   0x8
>>>> +#define CTF_TYPE_INT_UNSIGNED  0x16
>>>>
>>>> #define CTF_TYPE_FP_ATTRS(VAL)         ((VAL) >> 24)
>>>> #define CTF_TYPE_FP_OFFSET(VAL)                (((VAL) >> 16) & 0xff)
>>>> diff --git a/dwarf_loader.c b/dwarf_loader.c
>>>> index b73d7867e1e6..79d40f183c24 100644
>>>> --- a/dwarf_loader.c
>>>> +++ b/dwarf_loader.c
>>>> @@ -473,6 +473,7 @@ static struct base_type *base_type__new(Dwarf_Die
>>>> *die, struct cu *cu)
>>>>                  bt->is_bool = encoding == DW_ATE_boolean;
>>>>                  bt->is_signed = encoding == DW_ATE_signed;
>>>>                  bt->is_varargs = false;
>>>> +               bt->is_unsigned = encoding == DW_ATE_unsigned;
>>>>                  bt->name_has_encoding = true;
>>>>          }
>>>>
>>>> diff --git a/dwarves.h b/dwarves.h
>>>> index 98caf1abc54d..edf32d2e6f80 100644
>>>> --- a/dwarves.h
>>>> +++ b/dwarves.h
>>>> @@ -1261,6 +1261,7 @@ struct base_type {
>>>>          uint8_t         is_signed:1;
>>>>          uint8_t         is_bool:1;
>>>>          uint8_t         is_varargs:1;
>>>> +       uint8_t         is_unsigned:1;
>>>>          uint8_t         float_type:4;
>>>> };
>>>>
>>>> diff --git a/lib/bpf b/lib/bpf
>>>> --- a/lib/bpf
>>>> +++ b/lib/bpf
>>>> @@ -1 +1 @@
>>>> -Subproject commit 5af3d86b5a2c5fecdc3ab83822d083edd32b4396
>>>> +Subproject commit 5af3d86b5a2c5fecdc3ab83822d083edd32b4396-dirty
>>>> diff --git a/libbtf.c b/libbtf.c
>>>> index 9f7628304495..a0661a7bbed9 100644
>>>> --- a/libbtf.c
>>>> +++ b/libbtf.c
>>>> @@ -247,6 +247,8 @@ static const char *
>>>> btf_elf__int_encoding_str(uint8_t encoding)
>>>>                  return "CHAR";
>>>>          else if (encoding == BTF_INT_BOOL)
>>>>                  return "BOOL";
>>>> +       else if (encoding == BTF_INT_UNSIGNED)
>>>> +               return "UNSIGNED";
>>>>          else
>>>>                  return "UNKN";
>>>> }
>>>> @@ -379,6 +381,8 @@ int32_t btf_elf__add_base_type(struct btf_elf
>>>> *btfe, const struct base_type *bt,
>>>>                  encoding = BTF_INT_SIGNED;
>>>>          } else if (bt->is_bool) {
>>>>                  encoding = BTF_INT_BOOL;
>>>> +       } else if (bt->is_unsigned) {
>>>> +               encoding = BTF_INT_UNSIGNED;
>>>>          } else if (bt->float_type) {
>>>>                  fprintf(stderr, "float_type is not supported\n");
>>>>                  return -1;
>>>>
>>>> Additionally - I cannot see it with `git diff`:
>>>>
>>>> [ lib/bpf/include/uapi/linux/btf.h ]
>>>>
>>>> /* Attributes stored in the BTF_INT_ENCODING */
>>>> #define BTF_INT_SIGNED (1 << 0)
>>>> #define BTF_INT_CHAR (1 << 1)
>>>> #define BTF_INT_BOOL (1 << 2)
>>>> #define BTF_INT_UNSIGNED (1 << 3)
>>>>
>>>> Comments?
>>>>
>>>
>>> Hmmm...
>>>
>>> + info BTF .btf.vmlinux.bin.o
>>> + [  != silent_ ]
>>> + printf   %-7s %s\n BTF .btf.vmlinux.bin.o
>>>    BTF     .btf.vmlinux.bin.o
>>> + LLVM_OBJCOPY=llvm-objcopy /opt/pahole/bin/pahole -J .tmp_vmlinux.btf
>>> [2] INT long unsigned int Error emitting BTF type
>>> Encountered error while encoding BTF.
>>> + llvm-objcopy --only-section=.BTF --set-section-flags
>>> .BTF=alloc,readonly --strip-all .tmp_vmlinux.btf .btf.vmlinux.bin.o
>>> ...
>>> + info BTFIDS vmlinux
>>> + [  != silent_ ]
>>> + printf   %-7s %s\n BTFIDS vmlinux
>>>    BTFIDS  vmlinux
>>> + ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
>>> FAILED: load BTF from vmlinux: Invalid argument
>>> + on_exit
>>> + [ 255 -ne 0 ]
>>> + cleanup
>>> + rm -f .btf.vmlinux.bin.o
>>> + rm -f .tmp_System.map
>>> + rm -f .tmp_vmlinux.btf .tmp_vmlinux.kallsyms1
>>> .tmp_vmlinux.kallsyms1.S .tmp_vmlinux.kallsyms1.o
>>> .tmp_vmlinux.kallsyms2 .tmp_vmlinux.kallsyms2.S .tmp_vmlinux.kallsyms
>>> 2.o
>>> + rm -f System.map
>>> + rm -f vmlinux
>>> + rm -f vmlinux.o
>>> make[3]: *** [Makefile:1166: vmlinux] Error 255
>>>
>>> Grepping through linux.git/tools I guess some BTF tools/libs need to
>>> know what BTF_INT_UNSIGNED is?
>>
>> BTF_INT_UNSIGNED needs kernel support. Maybe to teach pahole to
>> ignore this for now until kernel infrastructure is ready.
>> Not sure whether this information will be useful or not
>> for BTF. This needs to be discussed separately.
>>
> 
> [ CC Fangrui ]
> 
> How can I teach pahole to ignore BTF_INT_UNSIGNED?

i mean for the following:

@@ -379,6 +381,8 @@ int32_t btf_elf__add_base_type(struct btf_elf
*btfe, const struct base_type *bt,
                 encoding = BTF_INT_SIGNED;
         } else if (bt->is_bool) {
                 encoding = BTF_INT_BOOL;
+       } else if (bt->is_unsigned) {
+               encoding = BTF_INT_UNSIGNED;
         } else if (bt->float_type) {
                 fprintf(stderr, "float_type is not supported\n");
                 return -1;

You can do

@@ -379,6 +381,8 @@ int32_t btf_elf__add_base_type(struct btf_elf
*btfe, const struct base_type *bt,
                 encoding = BTF_INT_SIGNED;
         } else if (bt->is_bool) {
                 encoding = BTF_INT_BOOL;
+       } else if (bt->is_unsigned) {
+               ; /* ignored for now */
         } else if (bt->float_type) {
                 fprintf(stderr, "float_type is not supported\n");
                 return -1;

The default encoding is 0 which indicates an unsigned int.

> 
> Another tryout might be to use "-fbinutils-version=..." which is
> available for LLVM-12 according to Fangrui?
> Fangrui, which binutils versions can I pass and how?

> 
> Thanks.
> 
> - Sedat -
> 
