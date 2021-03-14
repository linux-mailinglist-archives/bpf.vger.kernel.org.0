Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B32133A362
	for <lists+bpf@lfdr.de>; Sun, 14 Mar 2021 08:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhCNHGD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 14 Mar 2021 03:06:03 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34102 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229539AbhCNHFX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 14 Mar 2021 03:05:23 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 12E72umc013680;
        Sat, 13 Mar 2021 23:05:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=F5rRp6KMAtaPQysrEf2HUQMi0VukzMeETFThH8fEqQY=;
 b=a1eMleaybQBkIO8BcBaC7Af77cDCYr41aorMmiwcnuNCB8lRspsMjhbqJBV3osBsMY/M
 9WsHaPrypZiEb0gqcAS64UARJTKiNx0BGG5b6ITRowngfHQzmqfsGnn+OkW3JlwHnZ4c
 2+kV0CLTXBpb6YwmwdltNQI8ecAfDr2k15E= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 378sxtkax0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 13 Mar 2021 23:05:21 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 13 Mar 2021 23:05:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXGb8jn6mMC14pQXlhOFaVf5YsnAG++37awxaSCJs6y0AgTqg9u3JKm6spX02eOuvBh07plBS0bdOtVW9P02pU9jq3E03ZnUZWBeIqaufWS/YrzYkHEt2ZFSyBL8ZsUn3sIUk0gzrWj9UJzhipnzy5SpBTBuGpWIoeXHiN20LGGFAo2VMJL8KUKbiol9Px9Zh5+3lfKpac4qB1IF8cscb0d6u7qSp9SWIMO5SHm46y55LQuRBTB0YejPhWbgDJDWGZAAPYK4YpP2s98hFlFXPdhlWMkwNfholAm+uCIOAUaG2AiPrMBzaSn2RSFGlCavwPIik2gUOBeD11ri5QhUeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5rRp6KMAtaPQysrEf2HUQMi0VukzMeETFThH8fEqQY=;
 b=JsNByyxeLcgLe0wrt3FpQhRplFnKlUZQFEAx45I8vEZ319tuTrINtFEqZ6x5P2iMbXbJykX/JKDq++3S1Cui9x+7+TQzI5Sjf0YV0Bo89GZlQBFDjVb7ALpXORW3/rsFJ2BCBA+6FJrm0yJkuorthuubQmx8p6SfhCQ0ZQQVrpAY7fauZmiEIPeXPhy56tsV9+xp/LNx/DUSsKpDHpEqgYniJo/HRfvJv+oYR3b/k9+/IqH4cBrDI6iX+vneiiENZ6h9gD2nSggN9EAkg0jGLtOfqnn36lM9dn8TDwccoDFxsXtsCbojbuQFUtIatU+4RLND9Syfi3NP/SY9ZUvkyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2031.namprd15.prod.outlook.com (2603:10b6:805:8::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Sun, 14 Mar
 2021 07:05:18 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3933.032; Sun, 14 Mar 2021
 07:05:18 +0000
Subject: Re: [RFC 0/1] Combining CUs into a single hash table
To:     Bill Wendling <morbo@google.com>, <dwarves@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
References: <20210212211607.2890660-1-morbo@google.com>
 <CAGG=3QWuxzwKGuYhVu+EfXPFZMNsO7-=NtHbdXAyvcVjvKF3hA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <86bcb5c4-b3c8-e41f-96ec-800caf57f585@fb.com>
Date:   Sat, 13 Mar 2021 23:05:14 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
In-Reply-To: <CAGG=3QWuxzwKGuYhVu+EfXPFZMNsO7-=NtHbdXAyvcVjvKF3hA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:5c8]
X-ClientProxiedBy: MWHPR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:300:4b::28) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e8::104e] (2620:10d:c090:400::5:5c8) by MWHPR02CA0018.namprd02.prod.outlook.com (2603:10b6:300:4b::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend Transport; Sun, 14 Mar 2021 07:05:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edb60b29-2736-42a4-d968-08d8e6b78657
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2031:
X-Microsoft-Antispam-PRVS: <SN6PR1501MB20319BE86391171F1325A130D36D9@SN6PR1501MB2031.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SssOFCZsRJ02Wv0u+mTVbSccsoKgL/xQF0UYTatuBnvu9ZUPSWS2JrKdked1bdQpQL3EhFRLhpEsTkqpEzWdpQDyA6HpA54rD+rPIDkvUDXTb6wnbNBQUbFscimQww9JF1EWAsaV3cGmglV+ojymMwBFX69A7XVYmhArxm26zhQ/Zt1N54QnATd6ObM6IzD+IRHxcuEHp2k7aiJluCF82Szk5hGlB9756riTlWqVN884wPcKgMhQYobxeA1zYnv4Cbts/J8E38e/YcoxqlH5IhpRb3QyhQtRnFcD6ye2/QpEK40kZNbFdNXiWT0O0q2hoLVJ7pJ6b8MSUUhHcRF/V65ZjNM5OqTnUnma2mdRHkiiAw4iVWJq/HXf94XGZWL/X3hCfOkR46Tq1Z3DMVhl3CFsvECaPelANz9xdNRIdm/kPbHBS90IwLbpHxc9VDA6c0Bq1B1kQ9XvJe7N2f5y83/ND2riZIae7CHfQTlXQ2dRzrDPUIvIX2xa5kA7MM008uDsFpKqK3N2o9bH6ObF1xSaONSEBqMEzQYt3HC/Ww1XriD03PQ3CY88a9UclqVBcxlECBuSsGjDcQZaTXD29nnl2HiLr8SWornW/KExlyo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(346002)(396003)(39860400002)(6486002)(66556008)(5660300002)(16526019)(66946007)(186003)(83380400001)(478600001)(8676002)(66476007)(86362001)(2616005)(2906002)(31686004)(36756003)(110136005)(52116002)(53546011)(316002)(4326008)(8936002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?a0tVVUdHQ2c5cjhrYXpnKzNwdHFmZ1F1ZnlHOHNtWGNVVFdDMk4vM3lMSDNl?=
 =?utf-8?B?NTNVQjk5QlFlbGNUYzlKRS80RHovdUx0T3FmV1QxSnhHYXRiWFZsUG1OdG1Z?=
 =?utf-8?B?NHZpR3l2aXRLZUo4clorR04xODI2YkFNaW9SS3VnK1ZlajVmUW9UclZMaFRQ?=
 =?utf-8?B?WWdvZCt0K0luUUZabWtrbzhnVHh6U0R0cjRkVTIvUERnbFFIMExlSXAxWndF?=
 =?utf-8?B?dzA2czhpTSs0WkdaaWpNMGJyeFpacVh5cXRIdm50clFDdENscDRVTXRiRkVX?=
 =?utf-8?B?Rk4yVHFUZG55M0tvUkR1TWFkaHQyUXNPbytTRGw0M0ZrWWdBMy9iWkZmOGo0?=
 =?utf-8?B?RVJVMTB0eTFMc0plWmZoYUZveFgyVlF6NTRpNXY3TEIreUFqQlM1bWtQMEoz?=
 =?utf-8?B?WVJyT2xDdjd2Qnp2UzdwMEF4eFBML3daMzZWQ3Z1azVqQjdvbjJwQlRlclIx?=
 =?utf-8?B?WFFqOEVHSG51eUlTRHV4bFF1NGxIdXZvYmRBMXlEVk41cFQ0bldZbWFkeFU0?=
 =?utf-8?B?THI1Y1RCd0prRkZtMUFSMk9qOXBRSzZrVFlxNVR3UWxGZzVhekRYcXN4MFp0?=
 =?utf-8?B?NlU2YzVGVEYzKzBOVkRGS2YxeEJMa2dhWGxTeFh0d0dKRlBnMCs0UW14Y0Z3?=
 =?utf-8?B?VHIyTGhhaXNVbHF5NENVNTJtVE44ZXZ6V1hpUzVjMnhzc09HMjVhYjVkaC9y?=
 =?utf-8?B?NWRjelBLM3U3M0hnQVJZNk9xenFQU1JScE83cXlMdFdDT29iaHZ4VXpzdVht?=
 =?utf-8?B?dUpnR0ZGUXZqWTlJVXNVeEZpS0p5NG9BWVpqNVpPZkNxQWFaMERZSWhBVjRQ?=
 =?utf-8?B?WHErUVp6QjAyU2VvVVJUcm5zNUJpanhqRmEwSjd5VDhrYU1xTWpISDJIV0Jm?=
 =?utf-8?B?dkdSZzVzSE5hYXY3bFJpdS9jNTVvRWIzQjVZNnFKL2FGK3I0dlRGSU93V1B3?=
 =?utf-8?B?cTdGYm1FRThkK0IvVzErK2svb3lzcFFvaE1ENWpGLzdmK3RYTGMrTXBScUlO?=
 =?utf-8?B?MXBPYk5xbWFPa1B2bmpLR3d2QlJpbUo2VW1vdUpDYXgyNHh6azVPZCsrVnRi?=
 =?utf-8?B?VWtxYU0wREJ2aEhrcFhNNVYwTVd6S09jeDhzYTZSRU9pS2dDSWFkVWlBTkhi?=
 =?utf-8?B?MXpreGhSeWdtaWFVZjFPa2NKenJsWVlqYU4ra2MzNEdSeERVUE9EQlhoaHRh?=
 =?utf-8?B?OXVPK1pPbDdPNnRSNUNCaW8vVk1rb1JpdWM1VE5kQ1h6dkE1cUZsSGNzRnNI?=
 =?utf-8?B?OXRWY0Q5czBDSWhrOURlN3lITkZOTCthWUdVb3Q2ZlgvWVRYb2VaR2ZsMXRS?=
 =?utf-8?B?NWZEV3Q0MHBlYVhSc25GR1hRRWVmcFg0QzlPL2tCZ3ZNWkNkSkMrODNvMTVi?=
 =?utf-8?B?SGRGV1pnbVpMNGlaSTBXekEybElreVlYT1RCdTk0Z0N6VUU1UW1EdTVZMjdE?=
 =?utf-8?B?a1BZUlpNZktsL3dudk1VMHlOTGJCdU40WlpnUUZ2dW5IMXlVUE5MRUZDZEZG?=
 =?utf-8?B?SGQ0alFVM2lRWlRjeHhWRkw2d3ArRy8zVmRSUnhrWmdEdVN3Y2NqbmlWaUI5?=
 =?utf-8?B?ckk3dkM2TVg1QXhCbGpkSmN6c1VmNGNTN3pnVkNhZzBrUHE4Q1FqYy9nejEw?=
 =?utf-8?B?WGkva1NRWVYyUHdLWTNzbXUxMmR0ZzZUc2xGQ0Z2WWYxUnFoODV0eGZtb1l2?=
 =?utf-8?B?S0c5b2w3VUUrdXF1NFp0QkQ0SnhzZzR6Q29MZUN0N2FoOW9wRDdUUWlsRzR4?=
 =?utf-8?B?cEpBMUdkcUxmSnRMeER5emRzVGdVK3E1S00wRks2dnRhSWlySFVxc0k5aXM5?=
 =?utf-8?B?OUZIZlVNY2tWczhyZzgwdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: edb60b29-2736-42a4-d968-08d8e6b78657
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2021 07:05:18.3741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AHiLfwFI8mwMi60uhA6/OYJ7cHdDNnjVkjrHYk5s+nZU2GxLLSSGoI1lhrL9hi+O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2031
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-14_02:2021-03-12,2021-03-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 phishscore=0 malwarescore=0 adultscore=0 mlxlogscore=971 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103140052
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/23/21 12:44 PM, Bill Wendling wrote:
> Bump for exposure.
> 
> On Fri, Feb 12, 2021 at 1:16 PM Bill Wendling <morbo@google.com> wrote:
>>
>> Hey gang,
>>
>> I would like your feedback on this patch.
>>
>> This patch creates one hash table that all CUs share. The impetus for this
>> patch is to support clang's LTO (Link-Time Optimizations). Currently, pahole
>> can't handle the DWARF data that clang produces, because the CUs may refer to
>> tags in other CUs (all of the code having been squozen together).

Hi, Bill,

LTO build support is now in linus tree 5.12 rc2 and also merged in 
latest bpf-next. I tried thin-LTO build and it is fine with latest
trunk llvm (llvm13) until it hits pahole and it stuck there (pahole 
1.20) probably some kind of infinite loop in pahole as pahole is
not ready to handle lto dwarf yet.

I then applied this patch on top of master pahole (1.20) and pahole
seg faulted. I did not debug. Have you hit the same issue?
How did you make pahole work with LTO built kernel?

Thanks!

Yonghong

>>
>> One solution I found is to process the CUs in two steps:
>>
>>    1. add the CUs into a single hash table, and
>>    2. perform the recoding and finalization steps in a a separate step.
>>
>> The issue I'm facing with this patch is that it balloons the runtime from
>> ~11.11s to ~14.27s. It looks like the underlying cause is that some (but not
>> all) hash buckets have thousands of entries each. I've bumped up the
>> HASHTAGS__BITS from 15 to 16, which helped a little. Bumping it up to 17 or
>> above causes a failure.
>>
>> A couple of things I thought of may help. We could increase the number of
>> buckets, which would help with distribution. As I mentioned though, that seemed
>> to cause a failure. Another option is to store the bucket entries in a
>> non-list, e.g. binary search tree.
>>
>> I wanted to get your opinions before I trod down one of these roads.
>>
>> Share and enjoy!
>> -bw
>>
>> Bill Wendling (1):
>>    dwarf_loader: have all CUs use a single hash table
>>
>>   dwarf_loader.c | 45 +++++++++++++++++++++++++++++++++------------
>>   1 file changed, 33 insertions(+), 12 deletions(-)
>>
>> --
>> 2.30.0.478.g8a0d178c01-goog
>>
