Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38A2352B80
	for <lists+bpf@lfdr.de>; Fri,  2 Apr 2021 16:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235608AbhDBOfZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Apr 2021 10:35:25 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:30988 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229932AbhDBOfZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 2 Apr 2021 10:35:25 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 132ETVg9027807;
        Fri, 2 Apr 2021 07:35:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=0JkAkGBpUyme9V66zK9Z6sqsxoTfdr3Vfqe/+TzmN0k=;
 b=eesGkIZNwyotfA43vvhGHhcTk01umAvddQEPexnLqLdgxsQOg8lQQ/T5aeFiCxNq83Um
 z+NSW+IBkobaCUXT1RysUJsOul439jJQ+e6EGWVH75qlLnNqWmXc2VCbdtmhT0fenptv
 HI5MhM2Iq1Cf2NSdKO/mIRfuj2NZyZ0DxCE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37nn8cm6g5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 02 Apr 2021 07:35:19 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 2 Apr 2021 07:34:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMgNTbO147zgBXU4joTis4j+IMFkdfPt+3hF3wPt8Mhh2zycavs6sRfCNMWi3iu812P/5hQMISJ3kaoacz6ueLkBHDKjrkBOSob//Umk/EDXycOgIY2vLR8HkwZakK3wcFPww6j1yf7fah/pow9f9em7JaOJH/cy3spYdBW6ASWo1WVzNjh/+G1lQhrH8mllIGtmPwDpfzTMwHbVrC8hmgumWPLmUUYykwSO11kqv3R7zpEhjF1xn2yDPVPNDM6DP/GYXCou6VCJmArkur7yT3E6UmrLqA1OfgzVIWJ+zg5H4Dxwn8lomS5oT1vuzVL+c6Cr2m1etEfZJJo9jPRIgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JkAkGBpUyme9V66zK9Z6sqsxoTfdr3Vfqe/+TzmN0k=;
 b=TxLNZh82JfJjH+CQ1UbCNENpY8AWE/dl2TMQTldCnkNVyOpYHQ8Au45v6zguTbWtR2vZwKkS/MY/hnl5hr/bJyvau4n8IljUfsWAhenrhRED1ILpfJJgofSXmIvwflbrlW24KRvipGCfm6l7webkm/Rq8EZCUkQnVxNvOTjbpfTQC9V8EJ/GMajgAfIe5vPayTgRRck0vTUtEHJrtT6KukseTySmmJOdoWgxiFNgZK/Fyke38vHkFO90KzERz+O14PYqKzHTmp514IOU1/kJ0kFXVvVds6Q6h0KG1CW6sozZmWf/8JzrFcQIDoq67p7H0b3CBl3h6kBzEsN4HGxvjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2479.namprd15.prod.outlook.com (2603:10b6:805:17::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Fri, 2 Apr
 2021 14:34:45 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.027; Fri, 2 Apr 2021
 14:34:45 +0000
Subject: Re: [PATCH dwarves 0/2] dwarf_loader: improve cus__merging_cu()
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Bill Wendling <morbo@google.com>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Blaikie <dblaikie@gmail.com>,
        =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        <kernel-team@fb.com>, Nick Desaulniers <ndesaulniers@google.com>
References: <20210401025815.2254256-1-yhs@fb.com>
 <CAGG=3QWpcCG7b70oQsRTATgt10acEFS=-Tg9U=DHZ6xoS3GeMA@mail.gmail.com>
 <YGcbp5Y+RRWzGSia@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <3f29403d-4942-e362-c98a-4e2d20a3db88@fb.com>
Date:   Fri, 2 Apr 2021 07:34:41 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
In-Reply-To: <YGcbp5Y+RRWzGSia@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c090:400::5:44c3]
X-ClientProxiedBy: MW4PR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:303:8d::21) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::17eb] (2620:10d:c090:400::5:44c3) by MW4PR03CA0166.namprd03.prod.outlook.com (2603:10b6:303:8d::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29 via Frontend Transport; Fri, 2 Apr 2021 14:34:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3531412-79f0-4915-9402-08d8f5e47579
X-MS-TrafficTypeDiagnostic: SN6PR15MB2479:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB24793F719318D2ABE7F5DC2ED37A9@SN6PR15MB2479.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: djET3mp6fipXsT53585b+PsYSYik1vfoOqWpoDQgext1nQFpm29Wc1q+bpes3ofQsrXNmBEsDeU7oTAaSK45nzK2eGIsgzzlm3E5uVjI4IOZolqvfft23hInPou9lpOK1Yvq9EO0h9bHW8O2aDiFq9T5O7wpIj7DWLXcKlYfaAedLRM6QYXoKomzLAqM69Sf33MohlhBHpCWj5FvdDsISPhU9uLkfsMRckgCTo/ft1M6jRvK6u0QelA5IAfxZjnPa8MV4Tqhk94lCprhZomjxi7Y5L2PAPW3um6h3zV5DH+Gs4OtvcB3KBdGwiMCtImYhQ7MAw2bCkzrzQS5iSg/nwgSvtT8+M2nRU1SgIllHSMgXy1Msp4PTLEFTV7JU4IzLAXRdy7hRv3JRIl4BEPBd4qt3l4R04yUq2zzURXegaV8WO6pcTSt3nszHWL1dmHsBwJHq96vctjcDtg9Fc9IsHzwwFN3L74iC3C8JZbhrJ4T/n1H+UrEBW9V/B0DsXA+q3b17xxOpI/H3qMInHldVSP1W98gBnvz8rROnhMr/+PRVduSc/Cp8luC09kqi47K+VIfK50ALHsn2pEjqEuAw/zH1jFkVqiZcm5kmxZ+2HBQJW66oqqfkrqCJjxFNyZJ3sXDaK6AObtt7QbrlTxRfaEp1GwBEQC6m7s8aLKgbqICt+WWSsqe2WHvCD62jIWvJW4YgXvGexPwB/8wQ78ZIM4nr91b7mnCf14WqX0MV0BBs7rafJ4T9ddR7yckMWmv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(396003)(366004)(136003)(31686004)(110136005)(53546011)(36756003)(66476007)(8676002)(66556008)(2616005)(66946007)(38100700001)(4326008)(52116002)(54906003)(5660300002)(86362001)(2906002)(83380400001)(478600001)(6486002)(186003)(316002)(7416002)(31696002)(8936002)(16526019)(101420200003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NFo4a2hMd0tqZEFaQnlqVEdjbE5jM3QrcGpCQnptVUo3R0ppNGZYclJZZlF1?=
 =?utf-8?B?TjY1anRSVENFdmFTVFJqaWY3bWQ2QXVyV3lENXk0VUo3V1FBWERZVkVMVTlC?=
 =?utf-8?B?T21zV3BrT2lPQzR1dVFRNDhCZTBhU2lhbkk3ME9GaDNXTEpmNE1Jd0xiRk5Q?=
 =?utf-8?B?YzZUTWNXNkNWd3pFZm1wSi9MZll0OFcrNjZ6M1IvNEdXR2JwNWlQbC9QMHc2?=
 =?utf-8?B?U0E2MHhXNllabGdHY01ST2FPSW83UnhJRjBERVcvTDF4MmN3a1VPVlVRY0Z1?=
 =?utf-8?B?OWF6TlNVNGJjR3NNbkZ2VnB3dTRTbVV3VVVieFRPL3FRb0RvdDdLUzBPeWJN?=
 =?utf-8?B?UEpIcWdCOHRkRG50UDRXSExMWThHaE9zdGtKMC82YUlsUVJMZ1BSRi83OG5a?=
 =?utf-8?B?b08yQjhKZzVtSWlzOGM5U0NtazZLcGxTSTQzY2tuQmJHMHk0Q2tSdDdzdmV5?=
 =?utf-8?B?NlU3SzJZeVF3S2lLQjBGMkNLaUZlQU1OQlZPRFRhMnNJSjJSWGlIa1J0MlJ4?=
 =?utf-8?B?RVFRZEIwbmFaOVRyVG1WbE1JZ0I1Y2RHTHBYeEJHdzZMQ0ZHelQ1WmZhM0Q1?=
 =?utf-8?B?Mnl0SjJTa0hibms3cERVN2tuYkJaN1RibEtuWU00SnlYWG1nZzRnUkc2V1Jy?=
 =?utf-8?B?YXY5eU42UEVSMGg0R2c5amNhOHcxcnBYMndOblZ1bWlibDZhQ1N1NTA1emRC?=
 =?utf-8?B?bzJOYllOVUUrbEVGVXkvZ0hPYnFqb3doa0ZlNXN4OGdzYjFtZmdnaFA0NUlG?=
 =?utf-8?B?dW1Oejl6YUNDK0J0WE15L3EwV0xOejZzeUl6UEh6YXpRMWNjSGxaY1BVS2I3?=
 =?utf-8?B?RDRpVngvb1R2L2FwS2dQK3I0VW03bEdPakJ6ek5EU3V1V3U1YnR3NnZBWThH?=
 =?utf-8?B?VjJXc2hJQ3piVm5mT2d6THhkbldlSUM3RWlyTWMzZ2IzOHJIWFNLVUNkdlow?=
 =?utf-8?B?dHpiM3FHQ1Qzd0pQVDFNOHFkYnVBQk1QVGYxL01kV2Zab3V0Q1FXZWNFbFNE?=
 =?utf-8?B?TEVRV05uWlp6bVNJU3lCcHRGNGZSZktFTVBWc2pHcVowU0xPcmtxY0FVc0JO?=
 =?utf-8?B?NVVWMTlrK1pHZlFwRlI3L0RqdkRmcGdIeFcyYTZtQ0lpSW5KK1grdjFqaDNM?=
 =?utf-8?B?TFg4YlVyODJYdFlUbWpHT2NKYXBXQzA1YmdUSU9rVHVLSFY1VzVvN2ErbFpq?=
 =?utf-8?B?cTFtZmxKME1UbDBDa1NleVo3WUVEZ2dERW9EZ3lJOGlzNnUzeWtXV2gvQWtZ?=
 =?utf-8?B?QVdQNVo1MkxwcmR4anVWaEpJQ3JRUjVrUmx4YUtlUm82Z0VZN04yTHpMRzE5?=
 =?utf-8?B?cG96dkxJY1JHNyt6NmRJRS9TR2V4ajVpUEFQd3F0YUtxNmRFY2FrLzkxQ0FM?=
 =?utf-8?B?MjRySU42RklNNTkyNS81ZnZCSHl3MWdhQU8vSW83dXhJRWh5a3dlbnpIVlBV?=
 =?utf-8?B?YmVLQm9XKzJXbCtocHBmV0YwaVFnWnBvOUFyOXZnRWUwTGtnTlhwSEl4TmdY?=
 =?utf-8?B?UXl4QUYyOEpWTUVVanRJNlJTeEI1UzZIa20xR3I1WGg3Z0NXMjE0Y0ZwSnlh?=
 =?utf-8?B?MW1vM2ZKVVY0YjRhTncyc0FLVXM4cWhFMHVHTVBoSjI1R1ZzTVJoZXhXMDNF?=
 =?utf-8?B?ZTdBMVJKd2Zib2FCWW1pdVdzam8wMjkvbEVnaThFbTFsVzltbE05TWg2YlhM?=
 =?utf-8?B?QnlRbmM2S05oQWtnV3hpUW5KTk1lWVNoSVVPcHBzUFhZZXFKbk5ZWXJBWlFU?=
 =?utf-8?B?cGlmRzdyRGdheDJvNms3NXUyQ2xPdElTNXZ5SytRSWxTZGVFUUVJRkhNWVRM?=
 =?utf-8?B?TTNqWkZYSXV2NUREeFVYdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3531412-79f0-4915-9402-08d8f5e47579
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 14:34:44.7344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3Gl3e48IkeVZSAwsSYhmtVWj1q+9rJshBC0JTpSaoOO5JtZKXKo1I3+HYoB7h0o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2479
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 3llmrTrgSD5tFICziD5FB0xeZ4tdMjQS
X-Proofpoint-ORIG-GUID: 3llmrTrgSD5tFICziD5FB0xeZ4tdMjQS
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-02_08:2021-04-01,2021-04-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104020109
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/2/21 6:27 AM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Apr 01, 2021 at 12:35:45PM -0700, Bill Wendling escreveu:
>> On Wed, Mar 31, 2021 at 7:58 PM Yonghong Song <yhs@fb.com> wrote:
> 
>>> Function cus__merging_cu() is introduced in Commit 39227909db3c
>>> ("dwarf_loader: Permit merging all DWARF CU's for clang LTO built
>>> binary") to test whether cross-cu references may happen.
>>> The original implementation anticipates compilation flags
>>> in dwarf, but later some concerns about binary size surfaced
>>> and the decision is to scan .debug_abbrev as a faster way
>>> to check cross-cu references. Also putting a note in vmlinux
>>> to indicate whether lto is enabled for built or not can
>>> provide a much faster way.
> 
>>> This patch set implemented this two approaches, first
>>> checking the note (in Patch #2), if not found, then
>>> check .debug_abbrev (in Patch #1).
> 
>>> Yonghong Song (2):
>>>    dwarf_loader: check .debug_abbrev for cross-cu references
>>>    dwarf_loader: check .notes section for lto build info
> 
>>>   dwarf_loader.c | 76 ++++++++++++++++++++++++++++++++++++--------------
>>>   1 file changed, 55 insertions(+), 21 deletions(-)
> 
>> With this series of patches, the compilation passes for me with
>> ThinLTO. You may add this if you like:
> 
>> Tested-by: Bill Wendling <morbo@google.com>
> 
> Thanks, added, and also this "Committer testing" section:
> 
> Committer testing:
> 
> Using a thin-LTO built vmlinux that doesn't have the
> LINUX_ELFNOTE_BUILD_LTO note:
> 
>    $ readelf --notes vmlinux.clang.thin.LTO
> 
>    Displaying notes found in: .notes
>      Owner                Data size 	Description
>      Xen                  0x00000006	Unknown note type: (0x00000006)
>       description data: 6c 69 6e 75 78 00
>      Xen                  0x00000004	Unknown note type: (0x00000007)
>       description data: 32 2e 36 00
>      Xen                  0x00000008	Unknown note type: (0x00000005)
>       description data: 78 65 6e 2d 33 2e 30 00
>      Xen                  0x00000008	Unknown note type: (0x00000003)
>       description data: 00 00 00 80 ff ff ff ff
>      Xen                  0x00000008	Unknown note type: (0x0000000f)
>       description data: 00 00 00 00 80 00 00 00
>      Xen                  0x00000008	NT_VERSION (version)
>       description data: c0 e1 33 83 ff ff ff ff
>      Xen                  0x00000008	NT_ARCH (architecture)
>       description data: 00 20 00 81 ff ff ff ff
>      Xen                  0x00000029	Unknown note type: (0x0000000a)
>       description data: 21 77 72 69 74 61 62 6c 65 5f 70 61 67 65 5f 74 61 62 6c 65 73 7c 70 61 65 5f 70 67 64 69 72 5f 61 62 6f 76 65 5f 34 67 62
>      Xen                  0x00000004	Unknown note type: (0x00000011)
>       description data: 01 88 00 00
>      Xen                  0x00000004	Unknown note type: (0x00000009)
>       description data: 79 65 73 00
>      Xen                  0x00000008	Unknown note type: (0x00000008)
>       description data: 67 65 6e 65 72 69 63 00
>      Xen                  0x00000010	Unknown note type: (0x0000000d)
>       description data: 01 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00
>      Xen                  0x00000004	Unknown note type: (0x0000000e)
>       description data: 01 00 00 00
>      Xen                  0x00000004	Unknown note type: (0x00000010)
>       description data: 01 00 00 00
>      Xen                  0x00000008	Unknown note type: (0x0000000c)
>       description data: 00 00 00 00 00 80 ff ff
>      Xen                  0x00000008	Unknown note type: (0x00000004)
>       description data: 00 00 00 00 00 00 00 00
>      Xen                  0x00000008	Unknown note type: (0x00000012)
>       description data: e0 02 00 01 00 00 00 00
>      Linux                0x00000017	OPEN
>       description data: 34 2e 31 39 2e 34 2d 33 30 30 2e 66 63 32 39 2e 78 38 36 5f 36 34 00
>      GNU                  0x00000014	NT_GNU_BUILD_ID (unique build ID bitstring)
>        Build ID: 354f81317b1b3c35f3f81f8d9f04d0c8caccb09a
>    $
> 
> Then with one with the new ELF note stating that this binary was built
> with LTO:
> 
>    [acme@five pahole]$ readelf --notes vmlinux.clang.thin.LTO+ELF_note
>    
>    Displaying notes found in: .notes
>      Owner                Data size 	Description
>      Xen                  0x00000006	Unknown note type: (0x00000006)
>       description data: 6c 69 6e 75 78 00
>      Xen                  0x00000004	Unknown note type: (0x00000007)
>       description data: 32 2e 36 00
>      Xen                  0x00000008	Unknown note type: (0x00000005)
>       description data: 78 65 6e 2d 33 2e 30 00
>      Xen                  0x00000008	Unknown note type: (0x00000003)
>       description data: 00 00 00 80 ff ff ff ff
>      Xen                  0x00000008	Unknown note type: (0x0000000f)
>       description data: 00 00 00 00 80 00 00 00
>      Xen                  0x00000008	NT_VERSION (version)
>       description data: c0 e1 33 83 ff ff ff ff
>      Xen                  0x00000008	NT_ARCH (architecture)
>       description data: 00 20 00 81 ff ff ff ff
>      Xen                  0x00000029	Unknown note type: (0x0000000a)
>       description data: 21 77 72 69 74 61 62 6c 65 5f 70 61 67 65 5f 74 61 62 6c 65 73 7c 70 61 65 5f 70 67 64 69 72 5f 61 62 6f 76 65 5f 34 67 62
>      Xen                  0x00000004	Unknown note type: (0x00000011)
>       description data: 01 88 00 00
>      Xen                  0x00000004	Unknown note type: (0x00000009)
>       description data: 79 65 73 00
>      Xen                  0x00000008	Unknown note type: (0x00000008)
>       description data: 67 65 6e 65 72 69 63 00
>      Xen                  0x00000010	Unknown note type: (0x0000000d)
>       description data: 01 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00
>      Xen                  0x00000004	Unknown note type: (0x0000000e)
>       description data: 01 00 00 00
>      Xen                  0x00000004	Unknown note type: (0x00000010)
>       description data: 01 00 00 00
>      Xen                  0x00000008	Unknown note type: (0x0000000c)
>       description data: 00 00 00 00 00 80 ff ff
>      Xen                  0x00000008	Unknown note type: (0x00000004)
>       description data: 00 00 00 00 00 00 00 00
>      Xen                  0x00000008	Unknown note type: (0x00000012)
>       description data: e0 02 00 01 00 00 00 00
>      Linux                0x00000017	OPEN
>       description data: 34 2e 31 39 2e 34 2d 33 30 30 2e 66 63 32 39 2e 78 38 36 5f 36 34 00
>      Linux                0x00000004	func
>       description data: 01 00 00 00
>      GNU                  0x00000014	NT_GNU_BUILD_ID (unique build ID bitstring)
>        Build ID: aeba9ffc929acd3cd573b4d1afc8df9af4f3694d
>    $
> 
> Now to see the diff:
> 
>    $ readelf --notes vmlinux.clang.thin.LTO+ELF_note > with-note
>    $ readelf --notes vmlinux.clang.thin.LTO > without-note
>    $ diff -u without-note with-note
>    --- without-note	2021-04-02 10:23:57.545349084 -0300
>    +++ with-note	2021-04-02 10:23:50.690196102 -0300
>    @@ -37,5 +37,7 @@
>        description data: e0 02 00 01 00 00 00 00
>       Linux                0x00000017	OPEN
>        description data: 34 2e 31 39 2e 34 2d 33 30 30 2e 66 63 32 39 2e 78 38 36 5f 36 34 00
>    +  Linux                0x00000004	func
>    +   description data: 01 00 00 00
>       GNU                  0x00000014	NT_GNU_BUILD_ID (unique build ID bitstring)
>    -    Build ID: 354f81317b1b3c35f3f81f8d9f04d0c8caccb09a
>    +    Build ID: aeba9ffc929acd3cd573b4d1afc8df9af4f3694d
>    $
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Tested-by: Bill Wendling <morbo@google.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: David Blaikie <dblaikie@gmail.com>
> Cc: Fāng-ruì Sòng <maskray@google.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: bpf@vger.kernel.org
> Cc: dwarves@vger.kernel.org
> Cc: kernel-team@fb.com
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Looks great! Thanks a lot for detailed testing log and 
Suggested-by/Tested-by/Cc list!
