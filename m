Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7DD334B351
	for <lists+bpf@lfdr.de>; Sat, 27 Mar 2021 01:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhC0AUC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 20:20:02 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51060 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230299AbhC0ATw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Mar 2021 20:19:52 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12R0A1K4028233;
        Fri, 26 Mar 2021 17:19:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=op+YHn4nkhSJ2cUuNHKXYRH1rANp/bW97SLUTB+yD+A=;
 b=FLLMf6031ZUc4o64Kuk3A7Ooirc//9G4anEAEgGd4auuctkbpX/yzlrZk7cRE+Grz/hQ
 95jIjnlvK8umpS7L+3vto9Pyp1NhoUOQ+EQDWFJXk3TCmuyDYhMP3IgfwsfGK2yN5GZ8
 VGpb3sHcApE7q5RYtzU+30E8Q9qVDbq+MGI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37hmbphv3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 26 Mar 2021 17:19:48 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 26 Mar 2021 17:19:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4zqrWlsfzq3Zn2lXbR737buQbTDJE8qzRS1LnyBVjFYQihcbAIGCMcbKrBcoKW5yuivJc78zOI9ENv9PQij1pzeW70vUApQARbX+kzwb/msJDUxvPsDl9eXr4VYNE2KlaqZwLMpE9Qc2VpDABqNS3IYkS8guM5T57PtQ2nf0vedLyWW33MzDBTilVH/IappqcZYtaRIkdPI40Kb4R7918doVHoC/1opHn7TB4iNJLynjUYcTB20rG64Gg7UqGrjDiVHDrfwfic2Jo51aGaoXPXFgCh74Jfp3wSE6UA75fX7P3hDirtU/glhoI3e9l0piz1m9G2tTC4SjpT6rbRm/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=op+YHn4nkhSJ2cUuNHKXYRH1rANp/bW97SLUTB+yD+A=;
 b=JeOufQC7x2ozmtqVZgiymCouT39OSCqzvx4JdKxftupdtJqyBQrbKG5Av6GSuqpxu5K1OAbL+Z/83nkqG9QhNNbFHImo4AeXG51YtNNDWn/GSgzEeGLLZAsZu/ai5G0t/piN7I0/Toijc+Gqk0fg0TQtEAY7eLH3ArrSeX4e1I44ktE3f0/yCmDhtLzK8/nFTtzBMociBl6DxUmU1iXSJ7B/nTrY/vCTKeWHTCoKS/Ug7fIv1EqB3+mc8vcMcJB3Y7RvNjvPwkfTDlPDKdCBoG50NyoYW+00zbH2taNMyjLkSsluBEpF8tENH1YsT4sJL6WYefMIy1EQV0Zh0iItDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4644.namprd15.prod.outlook.com (2603:10b6:806:19f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Sat, 27 Mar
 2021 00:19:46 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3977.025; Sat, 27 Mar 2021
 00:19:46 +0000
Subject: Re: [PATCH dwarves 3/3] dwarf_loader: add option to merge more dwarf
 cu's into one pahole cu
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
References: <20210325065316.3121287-1-yhs@fb.com>
 <20210325065332.3122473-1-yhs@fb.com>
 <CAEf4BzZ=jWb7KuR6yX+3A4zZUbrgHm=AdxcYVoQ358N5zLGFqw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <508dd920-3604-5b42-83cb-ea99aac42f7a@fb.com>
Date:   Fri, 26 Mar 2021 17:19:42 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
In-Reply-To: <CAEf4BzZ=jWb7KuR6yX+3A4zZUbrgHm=AdxcYVoQ358N5zLGFqw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:2920]
X-ClientProxiedBy: MW4PR03CA0057.namprd03.prod.outlook.com
 (2603:10b6:303:8e::32) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::1777] (2620:10d:c090:400::5:2920) by MW4PR03CA0057.namprd03.prod.outlook.com (2603:10b6:303:8e::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.28 via Frontend Transport; Sat, 27 Mar 2021 00:19:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50e846e7-00b9-467a-6264-08d8f0b60653
X-MS-TrafficTypeDiagnostic: SA1PR15MB4644:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB4644ADF9988A042CE74B24FBD3609@SA1PR15MB4644.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qy95Lm338slsl/srurn/Z3RDqoaoWNbfKypXpxpv9Mcp205VLxwKk/9oB7Sc6cdDA7aGzGOqwUZ3SlDHnuaImWUWr1EHtaqJMbKSvdOEHEpAAl01Q32o72e0fVsqZPL+H7NTjSORQ/3SqIiPQXGOZiEbKygF0OXSvw/1zxact6UzZVWRjySRk/L6PnaAlmxwc9qFUyLD6iu0fSQsue3x26c/EYiEmbyINUcxpKCUck4qQvqRHZOOWo3AzwybEUCFmIXBQUH/3byrXZZ71mi30k9+18NmwTw79UbIuri6De9n25ld1XcT3LfiQII6gEYQYTFfXaid2S5fof9qod5YidsNe0Et6tnolsd4maUd0Ja26NrF4p0PEYX5gXl1501NnfpUCPmCAO2l6H4GzJs9QM5CuySpM+kcjp8pCUEKAIzzmchkem+ZEJimCM71XBs+AG7ApIUk0HjmAZITnDhTc54QOveuLjTLA5R8+5Ay14i/j7EbrfyKsz8wfF8NKrKyYsDWbTVruSCFoNgv48ZXNWu4cvHPeaFMdaeVhUaUkX9qmxZk02IRXlglGx3lFlM8mGjNgYJqn19IEKY1WYE+B51GdJKsm5S6wUlo+nuAsLvzdz1XBlYC7GCG607MC9w6IDRHNeUY1845ZqgIX/mIHDOytN86mg3YAGnPe3y5DU6Fdi7Zz+5LZSuq1qwIijULOg64q4wT60HPf7eZFhWCBeyD4TxwKasCeMIFrp8wAvY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(396003)(376002)(346002)(366004)(54906003)(478600001)(8936002)(5660300002)(4326008)(186003)(316002)(2616005)(2906002)(6916009)(38100700001)(31686004)(8676002)(6486002)(52116002)(66476007)(66556008)(31696002)(86362001)(83380400001)(66946007)(36756003)(53546011)(16526019)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?R2l0ZHBXaE5EZDIzNWZRclJHcUpyZmw0cTk3YzU1TjlRbmhDZGFneVN6K0I5?=
 =?utf-8?B?YzRMbWtqOFRjNVAzbThuRTJ5NEIxdWZKVTAvakNIUDNra0xiNnZDOUtZUWYy?=
 =?utf-8?B?L0NVQW1xdVNIUUl3a0dkeUtQWWdNaWtEUnR6NGxhTm9NOEhhMkJkemVuQXFJ?=
 =?utf-8?B?SElPK1ZzbG9idHNJayt6cWdNWnVZOFpLQ1Ayd2YxYUV2T1VHbDYwOGFsV3I0?=
 =?utf-8?B?UnN2WWZOZ2VOUzltM3k5TUlrWWNxS1hueWZDZnAzeGpVQ2p4bHJZYkxHVEhQ?=
 =?utf-8?B?MFQ4R25sTUFwcnFaNkhvWGF5ekdjYmpxT3dkbEdkeWxpdHFULzlnWnVVZnp0?=
 =?utf-8?B?dEM2REFFWmhBcmFxQ2pXaEk4N1FtYnJUK1F1ZUlEaG9QVEdyNXJnY3ljUmZS?=
 =?utf-8?B?RHhRM3VvSkx1VUZHYkRCUkFUbXMydFFzZGl2cTcrbHBmZlM4eUZCVDMrNkMy?=
 =?utf-8?B?OTdpWlN1a0pWb1VsM2NGakdXZTBTcXVlVU5BSFFXWDZzOVlNMHo5THVOMXkx?=
 =?utf-8?B?bGx6WGJjaEtZWlV4RDlMQlBiNFZzUm9uSlpoRlZ5L1RXWUtYaS9BampOb2M1?=
 =?utf-8?B?WEozdXhZcmUvK055NVd5c09hVUp6bWJJbFFHTHNqZDhxb3I1dm4zUFRqRUZN?=
 =?utf-8?B?Tzh6TmhScG9TZE9KOE5KdzgxUm5iL1FNTWJUamY4cm95WHdWZVBJUmVhc0xt?=
 =?utf-8?B?NUQ2c1ZtS1BnZWtmd3YyTFpJN3IxdXBDU2lXNnc4N0d5c21GRkNJMUxZMVZi?=
 =?utf-8?B?aGw5VDBtVk9sWWtGRjVSQlQ0T0lodkdiaHBSRnRpL2g0K0Z0Z0d2RVJIUVNl?=
 =?utf-8?B?U3g2akxsZngvSEs1eGNGd2FlK0FMNGFUQjI3TDlYYlRMYzJjdm9La3poUTJv?=
 =?utf-8?B?cjhUakpCR2s0NzQ1NG1QSjdHUlhSZWlvQ2VHbERXVlZhSFA2NGJyOTZ4Ky9h?=
 =?utf-8?B?YzJJbFlrSEJTR2tra2dYb2oyN1doaUVudGtqV2xNQ0Q3MmxPNGNMK09FRnpO?=
 =?utf-8?B?NjRDZlhaeTAzZGhmRTc2YUZUMVVWQTJ3bE1NakMzSktEcGJPTHprbW1md3dp?=
 =?utf-8?B?dmJmeFh1SGtreXljVUpUWnpoSUszZkZVRW1ISHcrSGlWeGR4YlVWN3o1a3J5?=
 =?utf-8?B?YW9LUDlGU1FXbVE5UktTL0NuTmhLdytveVFKemx1aDBtUTJCT084ZFV1V3Vx?=
 =?utf-8?B?SUFwYlZaTW05VzVUakFyZFJvZmsvVTZYZFE5SkYxMkx0c3JmNm9sSXNJUWZn?=
 =?utf-8?B?SHc0UG1nSWJ1aGVlc0V0NnlxV25JZTRXSy9LMXQ0TU9aR1o0akdYSGxsb254?=
 =?utf-8?B?SFZ0MzB3V0lmSHBuVDhMZ1cyZjNKbVFQQzZkOGlrb2Fvc2ZUZU9wYzJlVElm?=
 =?utf-8?B?dHRXRnp3NDNmQzRlUGFyRVorNU1yNXJ6UDNLdUJoWWpHSWFNcmZCd2pRUG9K?=
 =?utf-8?B?bEpGZVRMQTc0NmlBbDVLNlR0cEx4djlsanI4MFZXVWdlUUppaE1tbkJUdk40?=
 =?utf-8?B?VFVVZVdqZFc1V0l2OWp4cy96VnhHRDl4V1pIR25jazVVQjc3cnJsUXNkK2dC?=
 =?utf-8?B?NXpuZW5wQk5QVjY1R2s4Tm5HTXJabUg3SjBEYkZPNmFsdExhY0U5TGdqVUN1?=
 =?utf-8?B?Rk1VTFRjN2JDMFFoN1IzbnZRRlROYUNKaGtHWU82eFRZK0hodEFZTVRRWlFN?=
 =?utf-8?B?VER1SEp2cU1OSW54Z05yS3ppYkxCVUNiWlBBS2hZMFFyMUt3YzN4NU8wa1dk?=
 =?utf-8?B?ZFdYMmM2YjNJOUZjVTltQ1grTDNhRXN6YXVjaVFRMUVLU3N5UlRBMTUvUkpq?=
 =?utf-8?Q?CRPL+8bhRnLX2XfUebzUNDy9ytMbTyl0Y2bVQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e846e7-00b9-467a-6264-08d8f0b60653
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2021 00:19:46.0463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X+wEMEWeYJng3N57sHNSIqodJOa8/G3C6UafUbyMuprf3slVw8oIsgr+QuaATRZ+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4644
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: J17_8X1cH4-d3PNIw58FwrnBd-D27gHU
X-Proofpoint-ORIG-GUID: J17_8X1cH4-d3PNIw58FwrnBd-D27gHU
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-26_16:2021-03-26,2021-03-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 mlxlogscore=848 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103270000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/26/21 4:21 PM, Andrii Nakryiko wrote:
> On Wed, Mar 24, 2021 at 11:53 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> This patch added an option "merge_cus", which will permit
>> to merge all debug info cu's into one pahole cu.
>> For vmlinux built with clang thin-lto or lto, there exist
>> cross cu type references. For example, you could have
>>    compile unit 1:
>>       tag 10:  type A
>>    compile unit 2:
>>       ...
>>         refer to type A (tag 10 in compile unit 1)
>> I only checked a few but have seen type A may be a simple type
>> like "unsigned char" or a complex type like an array of base types.
>>
>> There are two different ways to resolve this issue:
>> (1). merge all compile units as one pahole cu so tags/types
>>       can be resolved easily, or
>> (2). try to do on-demand type traversal in other debuginfo cu's
>>       when we do die_process().
>> The method (2) is much more complicated so I picked method (1).
>> An option "merge_cus" is added to permit such an operation.
>>
>> Merging cu's will create a single cu with lots of types, tags
>> and functions. For example with clang thin-lto built vmlinux,
>> I saw 9M entries in types table, 5.2M in tags table. The
>> below are pahole wallclock time for different hashbits:
>> command line: time pahole -J --merge_cus vmlinux
>>        # of hashbits            wallclock time in seconds
>>            15                       460
>>            16                       255
>>            17                       131
>>            18                       97
>>            19                       75
>>            20                       69
>>            21                       64
>>            22                       62
>>            23                       58
>>            24                       64
> 
> What were the numbers for different hashbits without --merge_cus?

Without --merge_cus means non-lto vmlinux.
Just did quick measurement, for hashbits 10 - 18,
all ranges from 37s - 39s for "pahole -J vmlinux" run
with 10 - 15 between 37 - 38 and the rest 38 - 39.

The number of cus for my particular vmlinux is 2915.
The total number of types among all cus is roughly 8M based
on a rough regex matching, so each cu roughly 2K.

So the current default setting is okay for
non-lto vmlinux.

> 
>>
>> Note that the number of hashbits 24 makes performance worse
>> than 23. The reason could be that 23 hashbits can cover 8M
>> buckets (close to 9M for the number of entries in types table).
>> Higher number of hash bits allocates more memory and becomes
>> less cache efficient compared to 23 hashbits.
>>
>> This patch picks # of hashbits 21 as the starting value
>> and will try to allocate memory based on that, if memory
>> allocation fails, we will go with less hashbits until
>> we reach hashbits 15 which is the default for
>> non merge-cu case.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   dwarf_loader.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>   dwarves.h      |  2 ++
>>   pahole.c       |  8 +++++
>>   3 files changed, 100 insertions(+)
>>
> 
> [...]
> 
