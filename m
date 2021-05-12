Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714E837EE17
	for <lists+bpf@lfdr.de>; Thu, 13 May 2021 00:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236425AbhELVJQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 May 2021 17:09:16 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:31278 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243882AbhELSpa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 12 May 2021 14:45:30 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14CIhktx032740;
        Wed, 12 May 2021 11:44:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=kWucB2jK9LpvZ1Q67+NuHqsBmPRU5ZP6Tq9pUz4VtOU=;
 b=OsBk8vOk3JKOJ6dIZaXqkQ31raXIcgWjmwwa5vPJwqhS2i6k/eZdiSzV4SNHIzUJg4kA
 cKzejxS7bk31y01YXhL4DSUTMTZEiwt30DI/jWCt7dudB/RJLjC+pM+LFEOkYEEh4uUZ
 sDOJXMdp8271oJSIcUGyuT28xB5bLxhR6ZE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 38fahjwkch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 12 May 2021 11:44:00 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 12 May 2021 11:43:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLUVv8TPz97SAC5nvsDe9rRMoSywBUjJCS+yoITlQheSf0aacyEMQ/pohlE8SU/YAVzcUPnoG2UHfOjEOI93nlb+lBAllGMAggjRZh+/rGGMwprRfhtrMX4nOim0ibcFPYLZ/flsRlcC0a1Ot+tpQL0UjwRh/M+/hywbuM/Y9S9zhuTA2dvGPM5eAT2aKfFudWY6uFaf8pijYyxasg0tUJk4Ywri1aU1HO90waK2kv6qWq7tcrN06gKgnxmU/mBhHwsbE5un/EfQ0Xd4LDzZBRomguvo0P+95XQWGvaJzwcbOebcBUAwfiGky4hRj6Lt1uhqwVKeKpwXONKCih8tjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWucB2jK9LpvZ1Q67+NuHqsBmPRU5ZP6Tq9pUz4VtOU=;
 b=YTAJ8PLg4sBIVnl6Lm2TbDU7eiou2/DfWEfL7A0gPQbM08B6N0MgjgR3JiNVm4y12DruO72ZvgKNf7X5FlHs7l7RwA2qnqaTk6+XQjL19w6t8SM2AIQj4Rl2OkKTI/aNL2QX8rYHtuPPaI7IwGg7gwND2+yxTbuSQHcrrOyqTIdi5M9/X1LMRWcl65bnW9f2fEU9PIA61iOVWfu4p5r02nuH5od1+HhGNFz6/XA0YAyStAswLmc1G3zL2Hw2FXtyL6ItNOMtk6ZI3mLnYF98WqJ8fVJd0261cnMwXH0xkVCeazi36AaesJTMpOHaHUUuJqyXT515Vfc6D1mid/QT+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BN8PR15MB3282.namprd15.prod.outlook.com (2603:10b6:408:a8::32)
 by BN8PR15MB3489.namprd15.prod.outlook.com (2603:10b6:408:a0::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.40; Wed, 12 May
 2021 18:43:54 +0000
Received: from BN8PR15MB3282.namprd15.prod.outlook.com
 ([fe80::d427:8d86:1023:b6b5]) by BN8PR15MB3282.namprd15.prod.outlook.com
 ([fe80::d427:8d86:1023:b6b5%6]) with mapi id 15.20.4108.032; Wed, 12 May 2021
 18:43:53 +0000
Subject: Re: [PATCH v4 bpf-next 18/22] bpftool: Use syscall/loader program in
 "prog load" and "gen skeleton" command.
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20210508034837.64585-1-alexei.starovoitov@gmail.com>
 <20210508034837.64585-19-alexei.starovoitov@gmail.com>
 <CAEf4BzZYZ9i+pJ_aBzkhCLX9fVjUbOF_1=xvykk93TL5yQZieA@mail.gmail.com>
From:   Alexei Starovoitov <ast@fb.com>
Message-ID: <fc8d6e6b-cd31-5fcb-ff22-e3030b3f68a8@fb.com>
Date:   Wed, 12 May 2021 11:43:47 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
In-Reply-To: <CAEf4BzZYZ9i+pJ_aBzkhCLX9fVjUbOF_1=xvykk93TL5yQZieA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:18fd]
X-ClientProxiedBy: MW3PR06CA0023.namprd06.prod.outlook.com
 (2603:10b6:303:2a::28) To BN8PR15MB3282.namprd15.prod.outlook.com
 (2603:10b6:408:a8::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::1acd] (2620:10d:c090:400::5:18fd) by MW3PR06CA0023.namprd06.prod.outlook.com (2603:10b6:303:2a::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26 via Frontend Transport; Wed, 12 May 2021 18:43:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf94ef53-3d70-4e32-29b0-08d91575e437
X-MS-TrafficTypeDiagnostic: BN8PR15MB3489:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR15MB348927F0D708C6C4199D8708D7529@BN8PR15MB3489.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hTpXU5smlKyaswLV4leGOON1t5fUMnjaOh5xdAGoOFjjYJ6AljCTWoxldpR7rfR/AqqKBY7GWohbe/44YxLO+H+9SNZm/OkrpwQiBtyY1JJ25GbeNjDU5CALHacopx1GrW9zWkzElMIcsIdMUn4G4sBd35K7o+lOjqPQYz+o7dYtORtik9EJf+N4Sxc+sBkF6wCKpOve9C1ALZenYIF8JAoddhsNckJJWs+MdH33tI9DazcxodN9ui/IfG4cpkL+Znejz7KDk6XuDBImYMUwM6WA47F2SNp7XKn78dQLonbgG+zSzuGJkXBcdEzNCc9LrLV0jW7uDh3Iv4y8sB8vq4L5I5sLcAbjmwYMm5Fcd72EXxwd9FGBsoiaT4rC2qXWqR8XjL4b+Fr6W1lEJagkGR4kTS6qaFgfZ7CsMEPfqXtjR3+VyWvzyuixGcZHKe3ktkac1MjS46r487utThnotzN7U0A9vCXLUYZDO5/vLG7fdFKQ75EeStE1ub36adJ1bkcoZ9mA1TowZcMvr44QsqTIHiSYrJkOjEYmdXkfsGEhvob/tutNFwOAnFVXqwJzycdEYMfQn4kuDoz5mNvAwFDOj3Zf56p5RLQsYaD00eo2uP+chzg6uB24C0q6ubJnPlSsZVVLMoegksxUnZxaZY7BdpObv6M8g76eN1J92k+f9aYp69uxMyus+RjRxKJe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB3282.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(8936002)(2616005)(4326008)(6666004)(2906002)(52116002)(110136005)(53546011)(54906003)(316002)(6486002)(36756003)(83380400001)(8676002)(16526019)(66946007)(86362001)(31686004)(478600001)(5660300002)(186003)(38100700002)(66476007)(66556008)(4744005)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dDZsemRQdDRmYTd6UlFwUmVjVVgvMEx5UGsxejBTYmJVNVdzYUJXUXNLSXVm?=
 =?utf-8?B?NXBEYU5vZ080VWlzRCtMT2dXRHdPOXdWek1tVDNRcmQ3YnAra0ZObDhSVmhQ?=
 =?utf-8?B?azgwdGFkdFJjcjhvdUlCZHdXNFVWTzh5VnNXR3M4SEtOclBMUmtZN2w3dFI5?=
 =?utf-8?B?VjNGQWd1d2FocFBQMEI3KzlGSXloZzdOK2tqaUUxN3p6QTBhdnJCaHc2dTFi?=
 =?utf-8?B?Y3NYKzhBVnZkblF3ZjA0THFRZmNtUzNkRU9ta0lEUVNTQ0F4dWRYV3JENWs0?=
 =?utf-8?B?MUFpbHlRQ01ENDZCcHkzMWFobWgrNFRsemZ2S0prMDErUktUdTNQRTE3cjRZ?=
 =?utf-8?B?TVlHcWF0aG0zUDFMQnFJYXZkQUF4T2pHUnNveEVMWUFZdnM3b0JrVGw1dFRY?=
 =?utf-8?B?a0t5ZElsMDlEUmdJd285ZkJIUnFzWjZVdEdWcU05Wmpwdk04NitvajdIam1v?=
 =?utf-8?B?UndaRGFnY0hkNndZMy9uMzF2VUp1T3RhNEZqRGNCOFFtN0tvb0VjbGxMRHV4?=
 =?utf-8?B?OVNCR2ZLaEJRTGw1UDYvUzZWVUo5ZFFOVVNrcVRWTmFVS09ZVEtVOFRxVFFQ?=
 =?utf-8?B?SHJlQ0JIbnRORm1KNUwrZHE4dSs0QUVzWkpLSlB6N0FwU0hqWUFKK29kczVV?=
 =?utf-8?B?RTBqaTUranNaUFVjOFFPSDAzSVZRYzJiZGM1Z0dlVFVVdjMxMFltRG0wWTZz?=
 =?utf-8?B?ZjZZWldpc2VVT2VGUE9pSExWQ0dIUnhGVEVZMHVWay9wMGtiVzNpK1hhMEw5?=
 =?utf-8?B?ZUpaYXV2RDVYYW5xVnBXanBZaTBrMFc5ZkxlVXFUZWFlLy8yN080WTV5bzF0?=
 =?utf-8?B?MDAwOEdma0duM0ZMUGhuQ2w2SXJxMjlnZlhvZGtPWmxMb3JIdkd1aTBuVjBS?=
 =?utf-8?B?akpmMFJQRVR0U0pDbWVHYWUrM1hCYTN4RTJsSVUvWFc3bEE5QVdENzdxeGlt?=
 =?utf-8?B?SDVRQ1FJbGdMMmRkSDFSTkllUEdXSFJiWHEwdXB0RWE0cFZvVDJrQ05LY245?=
 =?utf-8?B?MUEwR2ZOeWVGYjRyWndNa29HODlYYUZTcEIvY0g1b0hhYlVuaHFSa2gvUXdW?=
 =?utf-8?B?UTVGbDJZRmdXcS8vVG9KUkFYeUE4ZlMxUzlna3hMQUVPM2RtVVY0TlpFTUZD?=
 =?utf-8?B?T28yVEdYazYxeHVkMlVhMytqekRvRUxhaVJ4bFNxaWFINHVQaU9GSGhoUW1u?=
 =?utf-8?B?bVY5R05YM3ZOV1FZNnlLMmtJN1pPckJvTUYyMFZFUUh4WTlaR1dUOW1uV09x?=
 =?utf-8?B?R2oyaW9EWFBqNlVDLzQzUEQ0TzFYSEluZS9FL3R5Z3FOYWR3Z24wUHRhSU5N?=
 =?utf-8?B?OUh3QVNCZGt5U2VPUnZ3eVh3ZVNlaXZZR0xJVVZLT21FVUdFRDc0cG10Ny9k?=
 =?utf-8?B?a2JLSC9mcXdWVjdCUXlVWU9FdVhNcDk4ZmhCM0QyTkFUY003WW5ZbXVIZ2Uw?=
 =?utf-8?B?RHFsM0ZsZXJjVk82b0plNUxDTHpwOGJDcWp4UVh1a3lTaXp4MjlmRjFmZDJ3?=
 =?utf-8?B?Q1N5bHFNNFpxQ3hVMkN0cGpSVHlBZmFmT25oY084clBFbVVzVDV2dDRLOHNt?=
 =?utf-8?B?SU1qaFB3TzU3MVhUU281ZDZsdkNueWVTYVFQemRCVm9HdXU1NGlTbmJNSmFl?=
 =?utf-8?B?UEkvT3doUlNTMTQxWkJpbm5WbHU2U2JuOTdoNnIxU00wRmlBY2RsMEI1NWFK?=
 =?utf-8?B?UmdtalB5TlJOTkNVeXF1WlJvMmRDUWVQNHUvbEFnYjVlUkNFZEVlMVl1TUNY?=
 =?utf-8?B?UzQrUFV6TUc1Z2ZCaDJoZ0d5a1BOVldqNTNvT3hNeU1sQ0FTRTUzOStpSXFM?=
 =?utf-8?B?ejhFWW5Kc3dtall0N0xFQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf94ef53-3d70-4e32-29b0-08d91575e437
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB3282.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 18:43:53.6781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0B5hRJp0QwdNYmNrvbN4z9X4iHvvXujcYm99g8KcjTguAsWJZVWnDDN39285QEB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3489
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: n5Z0PIrsGXYtLEU-8P_e4n97SEsZLCGJ
X-Proofpoint-ORIG-GUID: n5Z0PIrsGXYtLEU-8P_e4n97SEsZLCGJ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-12_09:2021-05-12,2021-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2105120121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/11/21 9:17 PM, Andrii Nakryiko wrote:
>> +       bpf_object__for_each_program(prog, obj) {
>> +               printf("\tif (skel->links.%1$s_fd > 0) close(skel->links.%1$s_fd);\n",
>> +                      bpf_program__name(prog));
> 
> you use bpf_program__name(prog) in so many place that it will be much
> simpler if you have a dedicated variable for it

Every time it's in the different loop over all progs.

>> +       obj = bpf_object__open_file(file, &open_opts);
>> +       if (IS_ERR_OR_NULL(obj)) {
> 
> please use libbpf_get_error() instead of IS_ERR_OR_NULL()

That was copy-pasted from another place in the same file.
Fixed both and the rest of comments.
