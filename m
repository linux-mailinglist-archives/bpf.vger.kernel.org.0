Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53894356F3A
	for <lists+bpf@lfdr.de>; Wed,  7 Apr 2021 16:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242437AbhDGOuQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Apr 2021 10:50:16 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:61116 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348807AbhDGOtt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 7 Apr 2021 10:49:49 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 137ElifD019711;
        Wed, 7 Apr 2021 07:49:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=zcJAFrGAKjYUxZ/0yOhTbki4mNXby9yceFJAdb1YxfY=;
 b=bdnyLqLOQ7G97moVd2f/rKnB/T6pn/Y+0iti+bQOEHdpKpe25EYAzGGbSrugC7HFyNIp
 CMtYHJsMWrz8N8MtOYjqs67/qF8lp8BmS6YfGNxEDOg+HhSw+qBIHU2D/4d5ESSE2S+C
 9GHWKbIi+c/QBpUP9dXh0ZqqUE2E3Nze/iY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37rvanwrdw-16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 07 Apr 2021 07:49:19 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 7 Apr 2021 07:49:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2BP182RVzaox9w5zmui+Q+tt5Vs/TLWi9PhDg5+r5iE9JjDTRFVJTfVsuhO6grq14S5Kodj1/Kr6xUMcl1PHv6tjADj2Nxe/fYMzvRd/CnO+a/u66Zvj7kbeET/ctM4X6qNu32mN7ttBDx6ruhaKQuTE8AB1j8lllF8FSq0HQhgclbRZR3HrZ1jMthTbDScOFDfZQhjo9yjKlZmIez3WZPZFYyvQB3/I6ycT6tgZzfr+GuqXd4CVvaigWN3c1Tu+82u0P4M4DV6wo8MGaoPijhrBZv0PezLWJ91FnRpI2BU7uZmJqti7WQwg1mIwpGwHdabdTJs13qKj0CyahcWiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcJAFrGAKjYUxZ/0yOhTbki4mNXby9yceFJAdb1YxfY=;
 b=Clo+2dmXSemG2TT43zwxn4z8PBBEDWMe/ytOlyCdpOrNrx0Ic3X+K0SCl8kmPxTQbhrxKyY7kDshyq43fVUntboOtZSpW+mJwFH9l5hezHNl/NVmeR8/66PiHCoeRDNYpa8bRQDAgwWA0PxgddtUmEqxasrMAHbU42mhCNL84r2lnWTYPADFEPBJNWCxH7bb8UlodVtadUQ4zD21jKRD2n7ejD5taQpjUo33VTIz1uNA6vggp3Cu8fwxtIujIaIdcxUgOy+vNv9av9ISbOFMDT/wT/8qWtJx3H/kStp0eW0jTMvKR21m6PPbP4MHMKNNFfU5UCqvvmvG8RNrPK5Q1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN7PR15MB4176.namprd15.prod.outlook.com (2603:10b6:806:10c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Wed, 7 Apr
 2021 14:49:13 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.033; Wed, 7 Apr 2021
 14:49:13 +0000
Subject: Re: [PATCH kbuild v4] kbuild: add an elfnote for whether vmlinux is
 built with lto
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
CC:     <sedat.dilek@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        bpf <bpf@vger.kernel.org>, <kernel-team@fb.com>,
        Bill Wendling <morbo@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20210401232723.3571287-1-yhs@fb.com>
 <CAKwvOdmX8d3XTzJFk5rN_PnOQYJ8bXMrh8DrhzqN=UBNdQiO3g@mail.gmail.com>
 <CA+icZUVKCY4UJfSG_sXjZHwfOQZfBZQu0pj1VZ9cXX4e7w0n6g@mail.gmail.com>
 <c6daf068-ead0-810b-2afa-c4d1c8305893@fb.com>
 <CA+icZUWYQ8wjOYHYrTX52AbEa3nbXco6ZKdqeMwJaZfHuJ5BhA@mail.gmail.com>
 <128db515-14dc-4ff1-eacb-8e48fc1f6ff6@fb.com> <YG23xiRqJLYRtZgQ@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <08f2eda5-2226-d551-d660-dba981b6ced8@fb.com>
Date:   Wed, 7 Apr 2021 07:49:09 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
In-Reply-To: <YG23xiRqJLYRtZgQ@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:3758]
X-ClientProxiedBy: MWHPR08CA0054.namprd08.prod.outlook.com
 (2603:10b6:300:c0::28) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::10dc] (2620:10d:c090:400::5:3758) by MWHPR08CA0054.namprd08.prod.outlook.com (2603:10b6:300:c0::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Wed, 7 Apr 2021 14:49:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95a75dad-208c-4818-6112-08d8f9d44f5f
X-MS-TrafficTypeDiagnostic: SN7PR15MB4176:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN7PR15MB417657542E3EC905A1991C68D3759@SN7PR15MB4176.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HUoq1tg9pn/sO1iyCjW235gMTofPl5arguun7o5swIYziWpKetmxYtjG4mIME3JSYhraLZSyOqu8E4rpHmMeSnxXrVNpxzwG85X/rNlwMbJK8vqzMxAs55VGZvJRPz1xCBeSsuhlkI2Sf1/ROIgckMkAX2d19cHnUu5wfdMmu6RU22+JEZQ2XpWB/+PEt1LVu1QRUwvu1rodDA1ELBHcTDyAUIvtMaMJENo0b2E+3wniuaHWsrRY2Z3QmJXY36U9ZXyexxOPnMA8euyVBpo6r2aA/nThnpnTKBUfQkbFy8xoQbLKF4EUMp7Q/E/89H2sdHWmd4bksN0SFy7Kktb7b5I6KFyLU7d/dTZno6A6p5+HV7EkT4Wgoijb9rWvU7rt93HQlbk9XN0ROCfGMKI18rf7GNRKwpwzAPlmw7mUAwnrG5qUwInFVc5zoyvbBXkpeNd00pH1MPwdpxKdsUK0ux5a/N5ObIquQ2Caoz1A9quEKeBYXRkucDgqKhq/+4ikDMftUb3tD1q1XzjYmdFOhtwE1+LUkNlJU5p+elFdTnKpGquwvCKfuZufwHs/b4ntlpGFoD3t72npfDhXsPYTlKMZU0Ji7hoYxPEb8sTpkf+b6b5xY7Wbl+C5NeNROZJSVieDZq7QNFp7ptFYTYFKw6ZEJfSKcEJzpEScjm9del8MzsadZqCR1XebcupS+C/cGABkTPkVwtxhaZrZVJt+Gca9cSRLD+8WueXWJjNMm7Rv17mqQOUU7cO2qyoOmUc90wsDRrLVOy3PJHA8xjuFuz5lQ2hDgRrnKh1Glwuc6KQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(136003)(346002)(39860400002)(478600001)(2616005)(6666004)(5660300002)(966005)(53546011)(6486002)(31686004)(16526019)(186003)(38100700001)(4326008)(86362001)(8676002)(36756003)(66946007)(66476007)(66556008)(8936002)(316002)(110136005)(54906003)(7416002)(52116002)(31696002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WTZyTlMreDFLVld3Z0g5TnVtdG4yRms1WkQvQzQ1d3ZuYkkyZG0vbDc4MHZ2?=
 =?utf-8?B?Z1J2c0ZyR0l5dVJCMkVmdlhTa3I3b3RIZzhBcC9WV3JaYUJVYkV3NzNtMGc1?=
 =?utf-8?B?NngwMWZFQ1B0bGhZdGVnQnFJUWlWMGNLNTVPRE9TZWJwYUIvbm9CRjBTamVG?=
 =?utf-8?B?OXh5NmJnMjQyNlZMUnFpTVRqOTJQcjJreWY3d0ZmRlRSdTg0bGphYzR5bUFy?=
 =?utf-8?B?T21pM1VJQmR2NitmS1BYR29hVWpyODlBV0xRVVFobjFqWTllTlo1d3N5eVBX?=
 =?utf-8?B?bnN0Z1BpcXQ2YUxWYThwWTNueXRhcnV1cURKTW5RdVljZFBvVXU3VmgxWTJh?=
 =?utf-8?B?cXd5VzY2aFgxdEFXbHNYcHBwY1k2S2hvZVBuK2VGQmpVSkRGaGp2S1YwdXpK?=
 =?utf-8?B?SzJ5UmRmU1dZdTFOL1ZNelUyZTBBTTR4clZ2eFZHZjNPTVllM3pscmRhQVRU?=
 =?utf-8?B?VXVyUjJaSnpUcGhRazBacVJ5VHVrMnUyM1VBSWpLTDdjQ01XL05rWnZRZmVC?=
 =?utf-8?B?TzVCeFpCbXFNQk50cVRtNHBVbzdGUm1lZFBrMGdsL1ZLRVpQZE1Sd2Q4MHVo?=
 =?utf-8?B?enNwUmNoL2llT294UVRJRjlLSTNZY2hlMjNaNTJrbG9TK0dzYXMveFYxeW96?=
 =?utf-8?B?c25YZWs0NVVlRlNvWlF5eS9uWHZjWWp0MEJuUmNqZGp2cFEzQjByMjlsV2dT?=
 =?utf-8?B?QjRqalhQVDAzek51RFJmNURsbWNOV1phMTA2WFVZYm5vRmt1N2pJRlZGUmFH?=
 =?utf-8?B?S0IyNElHanhONmU4R1pXeEN2a28wTHhQYUsxWEhBSE5jMHZKK1dYcVlaVFdw?=
 =?utf-8?B?Mjg0dHBpVDIvb1lXTjBjaU9GRkp0a1ptWGZRdGtjNnQwbjZySUZMMEJxZHJp?=
 =?utf-8?B?TXFrcWdRQWs3MDBqakVVeDdBYTBqaFJZdWR2dkNUVlFHRnR1ZElXWU9MUVgy?=
 =?utf-8?B?WkNUM0h0SFlTK3B1VlZuUExGanBGWTltMU5kZWs2VThsS1dyZTZOMlM5cUxr?=
 =?utf-8?B?eFRic0xqamZjQnFSS1M3ZXEwWTlTSXMzTHVuWElQTFoxN1pNWlpiZE45cmJ2?=
 =?utf-8?B?Q3B1MzBzMDBDU1NPL3k0VXVHNDZYc1Jwb0ZFSjhmNGgwYTBNVFp6Z255UHdC?=
 =?utf-8?B?dzdWRUVSalhyZWkySkt0UE9NMkIwVkRkb0x5SkU5QVNjWE9aRENwUzdPTEtQ?=
 =?utf-8?B?SlJvRkthbi9jV3R1QnBuYkgrZitZcnM4MjUwcDFWdngzSklxeFF0QUFjQ0I0?=
 =?utf-8?B?L0RuWFBTUm02Q2ZlRWNFcTNIYitQQjFyZndSWmdhUVEzU0hlR0Y5QWJ5eThm?=
 =?utf-8?B?c3NIaTMxRENlNEZSZ1k0UW5tZVJXMkxvNnVwWk5UUU5HdXl1d0dCb2NNQkZC?=
 =?utf-8?B?dXRtU25Tc3dzbWtQeldGa2RNZmxsRjBlVmFoLzU5RE8zYVJsMlFDZEVwSzNO?=
 =?utf-8?B?aVZHMlBaYjRPSzBJS2lTTDVPVktZY2JTWU5PTkxKaDF3a09jdDFDMFBlK3NO?=
 =?utf-8?B?d2dmeFEzMVBFWWtOc1VaSjh2eWcyazNKclRtWGtPWGY5eGl0MjQ4UCtJekM3?=
 =?utf-8?B?TnA2MjBRVVBoTVFzeXdvMDg1NS9LemdoTDZaNUNiVExvWWJILzVWUng0RkJl?=
 =?utf-8?B?ak9aVXoyVmhYMWJQYVZXaFE4MWZqcDY0UCtzS0RneDI5R2tidGZmYjBwVHVz?=
 =?utf-8?B?enRyOW1CTzB0cnY2RWY0Z250Zlh0NFg2RkxMZDdqVUJldkhGbGJVd1VGWXMy?=
 =?utf-8?B?WWczZzlpeXh3L2gyTk91VTJoZ2RzN0dlY1VIMHh3aVBScGNKTlczTTdhUnZl?=
 =?utf-8?B?WmY3cnA4Tm9FekFtRTlyQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a75dad-208c-4818-6112-08d8f9d44f5f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 14:49:13.5917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bRXjEH5QLXD/WMlU9N6bLluc6SyXdJzPe07juJrSbpwCtCQ5RKZC6n7pwgBaizb/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4176
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: SxxrNBT19wEJ8TQ7M10bDzzeB3viTURk
X-Proofpoint-ORIG-GUID: SxxrNBT19wEJ8TQ7M10bDzzeB3viTURk
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-07_08:2021-04-07,2021-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxscore=0 suspectscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070106
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/7/21 6:46 AM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Apr 06, 2021 at 11:23:27PM -0700, Yonghong Song escreveu:
>> On 4/6/21 8:01 PM, Sedat Dilek wrote:
>>> On Tue, Apr 6, 2021 at 6:13 PM Yonghong Song <yhs@fb.com> wrote:
>>>> Masahiro and Michal,
> 
>>>> Friendly ping. Any comments on this patch?
> 
>>>> The addition LTO .notes information emitted by kernel is used by pahole
>>>> in the following patch:
>>>>       https://lore.kernel.org/bpf/20210401025825.2254746-1-yhs@fb.com/
>>>>       (dwarf_loader: check .notes section for lto build info)
> 
>>> the above pahole patch has this define and comment:
> 
>>> -static bool cus__merging_cu(Dwarf *dw)
>>> +/* Match the define in linux:include/linux/elfnote.h */
>>> +#define LINUX_ELFNOTE_BUILD_LTO 0x101
> 
>>> ...and does not fit with the define and comment in this kernel patch:
> 
>>> +#include <linux/elfnote.h>
>>> +
>>> +#define LINUX_ELFNOTE_LTO_INFO 0x101
> 
>> Thanks, Sedat. I am aware of this. I think we can wait in pahole
>> to make a change until the kernel patch is finalized and merged.
>> The kernel patch may still change as we haven't get
>> maintainer's comment. This will avoid unnecessary churn's
>> in pahole side.
> 
> So, I tested with clang 12 on fedora rawhide as well on fedora 33, and
> I'm satisfied with the current state to release v1.21, Masahiro, have
> you had the time to look at this?
> 
> Yonghong, as we have a fallback in case the ELF note isn't available, I
> think we're safe even if the notes patch merge gets delayed, right?

Right. That is why I separated the notes patch from other patches.
We can revisit it once the kernel patch is settled.

> 
> - Arnaldo
> 
