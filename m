Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C1A6774CB
	for <lists+bpf@lfdr.de>; Mon, 23 Jan 2023 06:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjAWFXS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 00:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjAWFXO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 00:23:14 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43104C22;
        Sun, 22 Jan 2023 21:22:57 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 30N3pOvM015364;
        Sun, 22 Jan 2023 21:22:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=E0baI9dnhxcRGdZ8o/YBsvgq57eRbS7+B6WUIIoTXsg=;
 b=KAjP3EP77p5IbecLwxHSf7hCz0sKmZvzUJc+vHiUanBlp0JA9+krkowo0rPVK3LRGNJ7
 iD1GB0KQQ7eQR6J1s1kthd5otgo+ORuy/qTISg+/V32/4Yq36B2yDGha/of7BENNycN9
 W6quoii+gkVT2SuaJw6pbkDar98OnNlptf/+ZttWUFTbDlVEQYTviA9nayVhxtgMH8qV
 vrEGLYXgKDOrq1ZL2vAgxFIWkzIHa70KOfkKOORc/wDwW7SIIUAZeNDAvgmRwEzJVbkG
 3XiUiWdaicF54OOHUmXUCgZI6ZfOxiEwLr8SS/GZnXE6BAZt8seQSThi2rh5iIXXWW1T EA== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by m0089730.ppops.net (PPS) with ESMTPS id 3n8ceeqyex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 Jan 2023 21:22:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/ZSaJyufaOxlbW/GSyBmQNHlylYiG1FDhzKBRk7nn7hf6lGmX8Ddy7OgVh3e3S5h0l7kTFtP2JTKgGOOK12kA9hmI243vKdW+FNq8IDgfq3tNzQqUp6aukuSiaSujrscOBVSmeyk86ixmZ7IE90I3QsYB+xosxhNVP9tGa9BP/j7F3Vb4VedWdFaOf2d0TY5Oue57k1JvuYkKrpMeLBT5jkmQ+aopMk0Acw9Zun2INJu3MgksHxtfhCWR8/IoDzVsSln0YkaLV1cb2uwtjX4Ow95AZT7AFjmY5c6iwAp3Z5gWed7RMf4BeAAbIF+eTd44/mJyfgED5nC3hpqqX1BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eauWNfkudqoJ3zZgt+sshjBnZbTQYYyMX3t4LkO3LyU=;
 b=oELKOcTF0Ws2jpdA3mjMpyJ/Ne70/ujUteq3dLlboAKYyg5VUpq9TKof+g3jCr6nUNdj3rpWYBH/q4pk1PMu9XLQpG523L2lFHljZ1M9hwBplNij9NoJcm0k32qOgT4autTfpEtIJeaWg01VAELjBscvkCxDiVA1OPrza/OQgjW91k0KuD4/S9tduGgWUekyVYU3EaXOkgTYMkgXmWxjUAKqx8sdHaUmJipajGY4Mwsyvrp475LUy9vg53jM0V2F93j7fIqOVwqKxIRZGXwd9amLjA7YupcIf8mFQEvcW7uL48XGzlHlpQvxsc7aI+T69Uq7Y8fCOZF6tyFGml/6PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4449.namprd15.prod.outlook.com (2603:10b6:806:194::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.28; Mon, 23 Jan
 2023 05:22:31 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18%4]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 05:22:31 +0000
Message-ID: <302afd51-07c2-04b3-98a0-ee9d8fc5397c@meta.com>
Date:   Sun, 22 Jan 2023 21:22:28 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] tools: bpf: Disable stack protector
Content-Language: en-US
To:     Peter Foley <pefoley2@pefoley.com>
Cc:     Eduard Zingerman <eddyz87@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20230114-bpf-v1-1-f836695a8b62@pefoley.com>
 <701abf4bbf5b7957a24d2f164c643e1d9f586fad.camel@gmail.com>
 <4dc6a571-8564-b38c-31df-0d9741dfc592@meta.com>
 <CAOFdcFOh_rNt3pfkNHPPeK=Kojro==Kpgmmu-VnLuaMYfFoiwg@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAOFdcFOh_rNt3pfkNHPPeK=Kojro==Kpgmmu-VnLuaMYfFoiwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR05CA0187.namprd05.prod.outlook.com
 (2603:10b6:a03:330::12) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA1PR15MB4449:EE_
X-MS-Office365-Filtering-Correlation-Id: 1726a2aa-1bad-4cd4-9fc2-08dafd01d353
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nuiEz/bakibKCE/bBCjtlTo3XLEp1PKPmOK6XYOXHqopezdZvZfRyaqHYTVrgNi7h7zCVocnqBl8isZLbPVu/qxs8OBYNOaijGAiIsDV4CP1te5sSeG+YHqKvLwnsm1sHpB9DoQRE1D1jiAGcZoloDJUIHNhCsWFNDOjth6skFcwsTYw9MOzdFv2F3ZI4orBbXIu5C12LwfFxyUdQ9au/+5v81NEY6mcUztmd5lytKxhoT5G3c83lsXCqlQ7xzmWaI3zt/rQopl8oZviSfntIw2xKgfTA/t21sfPs6UdeBVKY1+yJLW13aOoCszuYN8CL2JDKO2ei2EK7/2xD9ZdELgoW1Y/XpUF3O51m3bCizDpceosmwtLoZGzdHkgVHsT2ggsZ6mV5ReUdC2mXNRv4cWf4xcH+z+mGuD8Ri7DMA6zZUk5x6uPRSg7wolVdB8GdEb2wPpEcmaRRO3Kbd+3NlRa/9lm/Vmr4nh44lAnC2EdUXEdc5xW0S9Zb1lc0nQp+JtjG9nt/17Uz7JyA7NGvJahx6wUU/XmlCllXqcaSBkL+D97tbTjHYuYGsr5inbOrVNkFH+qMW8qCxz1YOqJC7Pfu4HoLlhdUYWftedPmjEaGGfcy/zxZCU6VTYPScEedAPI3scCEVFMjHkDUUzr+/tYrT//RJBXT2zdGfOLAak8mFMg6skK0alJ2jiEL3kk6prf/rpJ/oMNii7xg2V/aNs9szYk2556kjr/QKHbrVJzcniD2KRF6cWqx6frjXp1FZh0xmLzE+ijcwZ3FkIkOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199015)(86362001)(31696002)(6916009)(4326008)(41300700001)(2906002)(66556008)(66476007)(6512007)(186003)(478600001)(8676002)(66946007)(2616005)(6486002)(966005)(53546011)(6666004)(54906003)(6506007)(5660300002)(8936002)(38100700002)(7416002)(316002)(83380400001)(66899015)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFhkMk5vYjNnZHVsM2pRUnoySkh1b1JBdytvLzQ5NStlTkFhVTAxSlJZWnh3?=
 =?utf-8?B?N0d0bDBwb3crNmhJSTRNbGlVRlFLNHVzZUd3WGp1dHZUbUU1NDRDMWVDYmtH?=
 =?utf-8?B?Vk80NjVsVm1ZN2xyc1dXem5TVTI4VDdVcDB4aU1KOWxUbGxNSmVQUGNjaDNH?=
 =?utf-8?B?dWRFWlhIelZteXNXS2orMTlDVzE0M1VGQS9PNTMrNGZoMnlraGVyWmc1cUxB?=
 =?utf-8?B?bnhYK082K2tuWG5CLzdwRngwcVBCdnlJcnhGMi9uNktoTEw5ZDdLN3FkbG1k?=
 =?utf-8?B?Yzl2S0crODl1aFpFdndGRkJBbExFdEhEdldFRVJ2QkpBTTA0T05Yc2lSSmZp?=
 =?utf-8?B?blJIblI3a1VHeEJwclYyVjFVK2x0dE8wU1R5aVI5ZDhpbElqMEhWYnZ5V0pH?=
 =?utf-8?B?Y0J3M1didWRoTmR0eWhDWWJqNWFpVTNnek1YTHhWVy95dHU1bU0xdFRCTTQ2?=
 =?utf-8?B?OFBTaVZtTUllNXZpQ29YVCtMM0lFUlJyMVo4UnpUckVzUFIyVm9jcGs0S2E4?=
 =?utf-8?B?RXVTSk00Z1YwTXhjdlhiT1ZzMmtpZU9YekNDS3dTc3NRbkZIdEZFMUY0dUtx?=
 =?utf-8?B?c1dmU3VEcE11allyVDVMNWh6T0diK3dNbkRzc3pPQVVFVnk1dUdHYlYrd2Ri?=
 =?utf-8?B?dTBzUUkySGpnS0YvTC84WjJUVFJ6L1BPL1hUT2Rsb2ppd3NuUHh1eXJYOXBi?=
 =?utf-8?B?L2lJa0NSLzVKbFBvNUU0Z09HbHFGT2xiTS9KSDhLaUMxb0RLckdkcU9nTWhZ?=
 =?utf-8?B?bUN5L3hBY1BlejlLZEZPdUNtS3VkV21wbXI0OWY0TGYvRk0xM0l2NGdSZG9Y?=
 =?utf-8?B?ZmZVOFZ6ZUhKVGREbnczZlpVZ0Y4bVRoS3dBWmVLUVc4b3d2UXJpakJaUGg3?=
 =?utf-8?B?bmozdUdTRDdiRUNOc0RRMWZvcWV3SEVlS1RzcWcyYkcxeDl6SmFIWkpJSXU1?=
 =?utf-8?B?S0FRRHRYVFd5eGJPaEMvQ0ZCdUYzZlZGY2xmZlJUcXZvQzVzMDdKK0N5dGU5?=
 =?utf-8?B?YzdwdnJQMGk0aWZUL3JjUk0wdUxBRVJXdlBieENuOUo0YTlVN3BzemxOMDhO?=
 =?utf-8?B?Z012MnhaZkFpQmFaUnFxQ1dQcEpGeVVteGVHdGlOSXl5czFtMDBLTFN3RzhN?=
 =?utf-8?B?OExRZnZySGxQQVppd2VaMHBMMmZHODczUCtTKzJaT1hoWFpHVzczNWdRWFd6?=
 =?utf-8?B?Ulp2T0t2SWJOUUE2RkUxYU5LTVJ1NWFEeHg0cnJIdTNOWFdPVERDNkx0ZlRC?=
 =?utf-8?B?TXA5SnVpb1J2YjdocFRDMEpHUElsZkFRRW9kd01RQUJhaTByVnIrMCtsMG1Y?=
 =?utf-8?B?emJYeFNvbzhqbkE2ZVNZMXYvWmpuMkViS0R3OFBpTWg3QkJwVHhoaHdmS1B0?=
 =?utf-8?B?azNUYU93ak1LNlpFYTNCdEc0T21FaHh2REJ5b2YzV1JMdlEwL25oM0c1Rk1S?=
 =?utf-8?B?bXpCaUUrQXg1SE9CRlMvNDZjYU9NRU5jUjZ4VHdqQ3AvaHFiTHZXRk1qaStz?=
 =?utf-8?B?Y1l5Sk5sbC80U25LMURxUkw5UEt2WWNhNEh3MFNsNkZGZlRieHFIOWhOeHJJ?=
 =?utf-8?B?YVB2N0tWSWgvR2c5QUpzdVZGS1VvTGJTZEd1T1YwQ3lkc2Y3SVFCY1YwL0Rx?=
 =?utf-8?B?RnYxOWp4cUxLV2ZuL2RCTWNONi9mcDJmNzluMlduZzBVSG1iVVVrNjExc29n?=
 =?utf-8?B?MVhadVlOU3J1Ry9lMlNVQll3SFdNZE0weDBDbnZZSTNKUzVhVDdVZnVKajdu?=
 =?utf-8?B?WWF3ZTdSaVhVT09FQ29sSW05aHpxU1ovdmxCZHhHMFBxK2ZkR3dpcmNnam5h?=
 =?utf-8?B?OWdDODA2ZVN0eWl4SkNXbFJuSzdxbHFqNHVVelVIbXROVDBTcUkvN1gxeGRk?=
 =?utf-8?B?bjdzVmtsc05YMFFRVVNYZzBZK2t5UEdWaDdlRzhsaWY5U01qM011SzFGME1B?=
 =?utf-8?B?Y01IbEtyN1NBeERwSlpGbnlQR29oYnV1STlqV0RlS3ROOEsrQXBud0xCSUx5?=
 =?utf-8?B?MUhtU3R6Z2N2dzh0K0pvOVh0TTVTZDVIZEVtaE9zOEQ4TFJWNWRMWmNUSCty?=
 =?utf-8?B?RGxvL3dUSThSSmwvcXFWbFpSbkpWMDhNSGl1WkZyZEJGanNUYktCdFJwN3FC?=
 =?utf-8?B?cHJtMVl5ZWJ5REdCV1NkUHJZcm5WQzNRbVArdGhtcno2OEg4dXJjRFJjNFE2?=
 =?utf-8?B?MVE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1726a2aa-1bad-4cd4-9fc2-08dafd01d353
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 05:22:31.0332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SdS2eNoMogO7NHvNUo3DfpMxzw4QXtGBLAopf4GK7syl7DwlZxC/pG9tf0gGEjjz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4449
X-Proofpoint-GUID: _y5cf-hvKDSw5Zf_KjtBmRO7uWN_SxNv
X-Proofpoint-ORIG-GUID: _y5cf-hvKDSw5Zf_KjtBmRO7uWN_SxNv
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_02,2023-01-20_01,2022-06-22_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/22/23 8:28 PM, Peter Foley wrote:
> On Wed, Jan 18, 2023 at 11:34 PM Yonghong Song <yhs@meta.com> wrote:
>> On 1/18/23 11:28 AM, Eduard Zingerman wrote:
>>>
>>> While working on clang patch to disable stack protector
>>> for BPF target I've noticed that there is an option to
>>> disable default configuration file altogether [1]:
>>>
>>>     --no-default-config
>>>
>>> Should we consider it instead of -fno-stack-protector
>>> to shield ourselves from any potential distro-specific
>>> changes?
>>
>> Peter, could you help check whether adding --no-default-config works
>> in your environment or not?
>>
>>>
>>> [1] https://clang.llvm.org/docs/ClangCommandLineReference.html#cmdoption-clang-no-default-config
> 
> I guess I could, but I'm not convinced that's the right thing to do.
> Ideally problems with distro-specific configs would cause loud
> failures (like this one) and result in fixes like the changes being
> made to upstream clang/gcc.
> Simply unconditionally disabling distro configs seems to be the wrong
> way to approach this and makes it less likely that future problems
> will be reported in the first place.

Thanks for confirming. Eduard has implemented a proper fix in clang
(https://reviews.llvm.org/D142046) which will warn if -fstack-protector
is enabled. In gentoo case, since -fno-stack-protector is appended to
compilation flags, no warning will be issued, so we are all good here.
