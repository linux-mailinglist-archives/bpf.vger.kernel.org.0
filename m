Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2FBE34B2C7
	for <lists+bpf@lfdr.de>; Sat, 27 Mar 2021 00:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhCZXTg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 19:19:36 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:19144 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231599AbhCZXRx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Mar 2021 19:17:53 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12QNAFGQ023985;
        Fri, 26 Mar 2021 16:17:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=2uhgqA7+Nk30fqbKeeN3NVmkS5EwqQV2+ZlH8ItASRg=;
 b=OsUSpx2ZYsbaSueMHWIROfoZimyoq5xvP0++YiWp32uQ28KtbEzM0Y55jno85Wh7yL8G
 JYgg4JXc9wKif89+6kQs6V6ebY3+lJcyF5e+z34VrbXe/eJkNSTKwAnJO6loNjF83DKb
 6YjBy6jlLXY3jBNqeLdZmJfsubjrowRMN8o= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37h11v7buc-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 26 Mar 2021 16:17:48 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 26 Mar 2021 16:17:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGk+mnVOl51hr1pAjKL84eROO24rQaf8FGTOd5YKUgaN08lODFpsokPHGtz1sIesRrh4/TTikehRTTxXQTcKwmTrwkTo4BlQ7JCRbMA7+e+nkY+6D6V5DhJXISYacY/MTRf+PyLrV6QGY90jEiMcJ86hDdbMEm+q/FOGC2HgQqMmLlPQkrPXlNCw1gqBn563Wl+QngGEeNRwW3S5Xg9kkh63Yrfat5ufYBqW8hqFuaeZl0qqPdWNqaHY5TDGNMjsDOpDohtUTsbrrTr8GILf7atsHW3IE4bDVy9TSar/ivWqgPZCyTtaIMaCUBJU/6zvyqJRQbdRMbud5vO18tnsGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uhgqA7+Nk30fqbKeeN3NVmkS5EwqQV2+ZlH8ItASRg=;
 b=N9LjyHs2iEI2z1WdyGaCPbg6LBfv/XPXAN0efpeFGrcwNW4nXoq7v6o1w+c37XqfbfYo7kwdqXUQm4DuJAYCsXXOSe8881Pak8sWW08rtU3HBzsAKXXQCUmNbo0Hen6y9T6URN4aCChvQGzrO590N5lxI3oqIiKb9KOveil6FsixOX2TgcgB/eO6Bvxg0z0AVjEMJpqhVlNO8X9bznZ6jpH3gL3ggQVmYV+y3FkMMXy9NN/I5S5B0SHl8Vk75H0dpbSWk6J4KK+UiSzMoPIvVZKTNULvMOjcjICmbMXK2m8rz29R57aB/KQVfb0A6yoZu8lCG/BthqahxF+4Zs6HsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4433.namprd15.prod.outlook.com (2603:10b6:806:194::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Fri, 26 Mar
 2021 23:17:44 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3977.025; Fri, 26 Mar 2021
 23:17:44 +0000
Subject: Re: [PATCH dwarves 3/3] dwarf_loader: add option to merge more dwarf
 cu's into one pahole cu
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
References: <20210325065316.3121287-1-yhs@fb.com>
 <20210325065332.3122473-1-yhs@fb.com> <YF3ynAKXDCE0kDpp@kernel.org>
 <d618edb6-e4c0-a260-905f-e07720746594@fb.com> <YF4ltLywXsM3YkSs@kernel.org>
 <74e25d53-1e36-03a0-2de5-bd2d349a4a7f@fb.com>
 <CAADnVQ+MT_u7q7veB_ws8PZ0XC0v2f2=P-TnzOBbaahbvYRDwQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <2db67186-b99c-b89a-bc56-620133d4a35c@fb.com>
Date:   Fri, 26 Mar 2021 16:17:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
In-Reply-To: <CAADnVQ+MT_u7q7veB_ws8PZ0XC0v2f2=P-TnzOBbaahbvYRDwQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:2920]
X-ClientProxiedBy: MWHPR08CA0060.namprd08.prod.outlook.com
 (2603:10b6:300:c0::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::1777] (2620:10d:c090:400::5:2920) by MWHPR08CA0060.namprd08.prod.outlook.com (2603:10b6:300:c0::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Fri, 26 Mar 2021 23:17:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8d28746-1963-46f3-bfc1-08d8f0ad5c18
X-MS-TrafficTypeDiagnostic: SA1PR15MB4433:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB4433DEA7E312BA4F59A5264BD3619@SA1PR15MB4433.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jHf1Hy+U5y63ALR2HxeSihkezGoABGNrI43Gike/wjqBKoZJ91+FNprMtxzmNDoQm0vOgZ+Evn7X4CPzDP17ZHBqzUEinG9/Ny913iZ/CuK8JfqIrRVlR57KoCFuh7kknr/EH3Vuph50g7SEG8dIo+JVDDEUbIgYDS2RUNWajBtDpSfvEW3PIlfZGK6+GYAW7rEhAOw++eLMMrNaTVRGXS1C7Pcxq3d4t779mq+yHbTOTHcVqVpG/9VH0JL1unYQlvcW/7iZM89ea+0+0+nu/71hm52OU4t7e2iXAjCESknlTNPmV/twZylnx6UHaJWD0gM/WS4pS6v/IKSSqrHSSyJP7PiDuLLuXoIvqDFv6HL4YogGcFjohsuHKiUByIn8VBKSmvV9/EWAlJpnUQZS+epxK2qVpot7IXQQ+02AYV5SWcW0nn+p5c63UN+c6mPNi+/zdkFcwBQ+cXkq0VRJ4VHItS2yUim5RtZUJWm62p+T5Bc3F/2HZHlObsKLVVcjP/vZyF9m+xJoZzKgUwM7166O9A6VTsbi6PkZ3Vu23PpyGMCTYWviglmX0AC7efBwodaaLotO8yXxe0DCqKQWfUuDqVZUpSRxS2G4/KqZc8N8lFfyTrz6M3crG+NNrWK0O/egnwnGikzTXr2ItLeJtbDdr9uUdh/ofzfJYAJ/E+1GPLFELP0ALJx6qdW0FNnGKJS9UDdnT6Ah0z9Y/Ev+9G34wZEDBGnIENgsXx4ts7M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(376002)(136003)(346002)(366004)(38100700001)(66946007)(6486002)(66476007)(66556008)(6916009)(54906003)(4744005)(5660300002)(83380400001)(31686004)(186003)(316002)(4326008)(53546011)(16526019)(52116002)(31696002)(2616005)(36756003)(8936002)(2906002)(86362001)(478600001)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NVBGZEJNU3JGOGRyMCt5NkZhSUptSHowNWR3MUNKMjgwQTl5NXY2dlNpR204?=
 =?utf-8?B?ejlaWEVLRU9KVUptVzZKSXZQV1I2MVZzSUZEUWFBUTRpdTYwTS9kTUp4bk9T?=
 =?utf-8?B?L1RCaytOYlFDQ2VpQkwxc3l5WGVoMk9SZERDenFmYlJzOWF4TjBrRTYvNUJo?=
 =?utf-8?B?Q29kbzBmNFRML3IwZCtUZ1JtNTBGR2RtNm9sVHhXYjVrdnhwQ0huYWRDQUEx?=
 =?utf-8?B?aVBSWHc2cGtIbHRrYlZUd1hiVEJGSzUyTlMvdk10ZCtnaFhKdHlKVE03TXd1?=
 =?utf-8?B?VVdoa2Fja0paWXpFdElSTFR5UGNRZElQbzkrdytwcGxsanZ0azNLMzZRWVls?=
 =?utf-8?B?azVCK3FnYkZ0MSt2dFgzdzJMV3c2Sk0yNEYzcUtLblRIeW41ZFVnMjQwM2dO?=
 =?utf-8?B?MDJnVndmeURkM1B6NTdTY1JvQjc4dGQxOXdQZW9zaDFNY0NZMDJQejZRS2tL?=
 =?utf-8?B?OGY4UUdXTGdFMXZjdFFhRmlGTTYvRU9YTDlVSUoxNUgyVkpQTWhLKzhsNitN?=
 =?utf-8?B?eFI5ZzRHTnJTM1FVbG1BNm0zUWJoWHBUdXhKVkczeTMyTm52S3JFRG5IRXpG?=
 =?utf-8?B?YmNBSWtVZTRFcEpScm85SlNrOS9kZmI2aE9OZUxZbGVmYVJpNFM5UnVTUkkz?=
 =?utf-8?B?Z3FEREVXSG9nOXZzQWdwVUpBY2s3dzhpNW8va1NvQTQ0SCtzYTBabnBmZ05U?=
 =?utf-8?B?bWxVRkF6RDN2RjYxdXJZOFd4Q0xreEdSUHlBZE4yaHUrazBSNmIyT1R1Yzlt?=
 =?utf-8?B?MG4xK3RMWXFpTDNEZk9FZUx1VnNEU0ZORHRNUlVrYXgySWtISjRxTEd6NXBB?=
 =?utf-8?B?dklwdlZXV0J5ZWRlN1ZvTDZtV0VwQkhoYnNNcThoMng0bHkrN3J3R3F1dlcv?=
 =?utf-8?B?ZnhZUGlNUWZuWnpkL3N2SVBSNDFNNHVCTUcyNWUzSGFnZVFFd01PQnpzNkd0?=
 =?utf-8?B?R1ZYa25SRzRyeXh0eWJIeVBQbTVtMzRvUmVLSm80VXo0MzJtVEIrb1c4SDFD?=
 =?utf-8?B?UWhlUkRVRk4xWmVpUEQ1cWo4ckNNc3BkZS8xYnZ0R0I4R0lvQlJGSlFpdzZQ?=
 =?utf-8?B?am1aSFA5amZJdklTTmVhL2srQjdLQjdmaWs2c3IzQ0dZNW9hNWhjV0xVZURi?=
 =?utf-8?B?UDdJUTNzeWJLbnNoWTRTaHZHaUoxUDk5N3owdEdWOXgzd1R1V3kxTGJPTU1F?=
 =?utf-8?B?SEdTWVg3WEw2clRnQ2xjOTRndmxTYzF2ZUYwbWNDNS9CU0N2WTFqV2FZUEE2?=
 =?utf-8?B?bmErczJ0ck1EYXoxY28vTWRXMUFOS240ZFdaaFh4cEFQU2pUK0R2d2dzclVh?=
 =?utf-8?B?dmNRcVN3UkJhYlIxM1JFUzNENzMzWkFoTDdkYXlRUGxDQXBaSEN3RXVaSWNk?=
 =?utf-8?B?MGF2RzE2NXU2d0x6N1dhZ0JFdnRMUXVFbVVIdGp3NEEvTUFPQlNNcmVIaWZx?=
 =?utf-8?B?d3pqaEdLM2EzVlNoUVNjTE0yYTlzTGwzZXlQZ1NDelh2Qng2SzBrSWRmV1lq?=
 =?utf-8?B?ZDg0em1XVmdvRlh2SDhIZFpFYkI5ZVJRRUhpZUNBZ0UyNFMySHFkWi9wL1c2?=
 =?utf-8?B?dXgvUkkzL0hQdmpMdXBHdzQ5d3hrZjBIb1lua1JUbldvMkF6TkluVERjQXJs?=
 =?utf-8?B?NGh2RmhnbDBJSnZBR1grQW5yaUtLdnR4SkVpOXBINFlCcFQ5WFRkdWlSYlFn?=
 =?utf-8?B?VXZvNnljSG9adGpoeVJSaU8zcE05VTI0TW00R2tpeGd6d1JMVTdHZHA1V3d2?=
 =?utf-8?B?YWdMRVZSK2EwVnFyRGs3SHc2b0YzRnE1Q0V0NHNDeFZqcHlEV2lNR2M1K3hP?=
 =?utf-8?Q?bvUcRqIykIZNtgqOcBTIKD87U92lLckyZSFj4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d28746-1963-46f3-bfc1-08d8f0ad5c18
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 23:17:43.9118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VSWaZZMiH6TKOwe+I41KA7wkqJ2ownJfoLROSkHyA9kDMm3td9nzFk58/zq+L4Pt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4433
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: cY-mgVssHVadEQLFndwhJYvFz4oZVwLD
X-Proofpoint-ORIG-GUID: cY-mgVssHVadEQLFndwhJYvFz4oZVwLD
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-26_16:2021-03-26,2021-03-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 mlxlogscore=745 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2103250000 definitions=main-2103260173
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/26/21 4:12 PM, Alexei Starovoitov wrote:
> On Fri, Mar 26, 2021 at 4:05 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> Now since you found gcc actually has flags in dwarf tag producer which
>> will provides whether lto is used, I went on clang side found that
>> the following flag is needed in clang in order to embed flags in
>> the producer tag:
>>      -grecord-gcc-switches
> ...
>>     In Linux:
>>        - add flag -grecord-gcc-switches if clang lto is enabled.
> 
> I think that will help to make dwarf output a bit more uniform between
> gcc and clang. So it's a good thing on its own.
> Recording compilation flags in the debug info could be useful in
> other cases too. I would pass it for both lto and non-lto builds.

Good point. Will do this.
