Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3912D49F0B6
	for <lists+bpf@lfdr.de>; Fri, 28 Jan 2022 02:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241681AbiA1But (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jan 2022 20:50:49 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:29202 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235404AbiA1Bus (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 27 Jan 2022 20:50:48 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20RNamoH007043;
        Thu, 27 Jan 2022 17:50:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=N3J+iAgNRruUTGYwesTso7hhKfmBWQ3+wQp3TwrpVnI=;
 b=ZyTEg2LALw5BZ8m5WwrwBYgdbsHukGB5vsPJRWgynYW83DEfjQZ4kKaFXjeLLo12Lsau
 pJmth229PC6J8WXxeZxMBzGh/bsEzGpmzoB9yONzlO0TI138FgvRipuHr8LJjvX/f7hP
 X/IuOxpj1sonvouVRhIZHWgTBJgLNagYge0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dujva720y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 27 Jan 2022 17:50:47 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 27 Jan 2022 17:50:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCIH6kFfPe/AW11/A4nXkYeoNUfRvjMawTiuIEdZCemxom9Tx1zd4JOzde6vH6vSHPbz4Rr+AI2qOvsoxFfpO0Cb15r0k3YBP/soayefFU3IXiWptRmx0VTdLefL182HJckBjJuiIVrnLbkb0+zZemsJc2R7Hm2wW4D7byQAycyiuF/mGRaxII+H/upm28ttTEuZ6VPQ+hgTqGo5BhcS+B6AW9E+30T2Cea0P6AB0qpb0pwqBqeDrAzMn1gvAh4Xe/ipQsp9ODS5Bak43HcIW10LOpOkJAYk8GkpWAgZryTnTKOG1aR79nDoEWbQyK4FMpU96exF3oXoOa14DFD3xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3J+iAgNRruUTGYwesTso7hhKfmBWQ3+wQp3TwrpVnI=;
 b=muZWiRIz7qpueD4ASTnMEdvsvagmBaNDi8gtCutbigc+VadmEnNfnfbLnOqvcZFYfKspIk+mdQFEym/fGIAHBkL6mHz/N9gyq2wiww09r/SMcuNrosNV0wG0Pz5/WopFoovFH3UVHam+XrMUqjrR7/PptnTvOeR0JPVP3JI/lJc9Vg2uly+3Gq0srYRXnyfgVr6fsDd7IRG+wcinv0SPfyushRP7j7UuXhqgHC3M5PRzCdUSWJeM36iDd7xvqED6zfulb50sSOkG5k38u+2ZNAGYRIsr3dBbV5J6s0KfAuVkUWH8UtEhlpVxz+2xTMKwBQegTiwxMVE1hTIK668ckw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB5038.namprd15.prod.outlook.com (2603:10b6:510:cd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 01:50:45 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::11fa:b11a:12b5:a7f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::11fa:b11a:12b5:a7f0%6]) with mapi id 15.20.4930.017; Fri, 28 Jan 2022
 01:50:45 +0000
Message-ID: <41e809b6-62ac-355a-082f-559fa4b1ffea@fb.com>
Date:   Thu, 27 Jan 2022 17:50:37 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: can't get BTF: type .rodata.cst32: not found
Content-Language: en-US
To:     Vincent Li <vincent.mc.li@gmail.com>, bpf <bpf@vger.kernel.org>
References: <CAK3+h2wcDceeGyFVDU3n7kPm=zgp7r1q4WK0=abxBsj9pyFN-g@mail.gmail.com>
 <CAK3+h2ybqBVKoaL-2p8eu==4LxPY2kfLyMsyOuWEVbRf+S-GbA@mail.gmail.com>
 <CAK3+h2zLv6BcfOO7HZmRdXZcHf_zvY91iUH08OgpcetOJkM=EQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAK3+h2zLv6BcfOO7HZmRdXZcHf_zvY91iUH08OgpcetOJkM=EQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: MWHPR07CA0003.namprd07.prod.outlook.com
 (2603:10b6:300:116::13) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b1ecd84-258a-4a0e-c590-08d9e200999b
X-MS-TrafficTypeDiagnostic: PH0PR15MB5038:EE_
X-Microsoft-Antispam-PRVS: <PH0PR15MB5038B8248A4AA770E24EA967D3229@PH0PR15MB5038.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L7oJ79VN2mSCmb9L2Mp6hmBbh/5JnMAauOkJAtKt0tJhsd6ayhyZ0YYI96UrWiNrcTb7kh4ZsIx4NGC3d5oCn/is/Z1C6TU5GE29SRuwrL81cWrs8oYlt1T8JrZamVimroQr5BAb6t1Jzxau+aKHn32YB5Q/cuU0oEIWCrTSrwV8qAnYZWBnAxdNHyAR4yEk7Z4WahHZVKyB3gRy0XBjFPWPpM5s0Y5fe8Pv+vDUKQEAr+ni2hWF8cGPuORT+iRE+AG2Kv02IgO9CGLpgNGQSiClE4PWQKaAdkcZDlWK2BntVV5wbmcj2GRKyc5bhGVnnCMTZbWMgdvMNMbjZvYzvgDZNZqjRO0LF32iasrpWBuYm68lI/wgwT71RsCr+p5jSqvy3iGK82ITvfug8c2r2gUl6MhpkCSJfqwupacZRINC30J9g6T4tFe7fPimGwkS/aeADRVKUYgVxea3kkGdtPvape2mIwoTPm7f84kDZPGUMAsLmwruO1VWTNQj5Iae7f1+kZn8CuHrLVxZX/14LSc7HyChn0jpkaDo8+kOtyl1y0GxmhEjr+207j2Dzr325oi/4MZN8nwNcbz1Entmb81gPwkrVwHQ0C8EILqZnlrgZJ8eTP5Kw72JUnF4ybqJqAO8/T7thnb2/K++NMPI37DHlFS6CgDlsYi3zNwNzefcj3z9CEtBUbty2IjQCss8eKbxBVQc9ODW0ExhbKWViogawo0+0ff+JDZ4/fsYxt4kBpjuCdprwaNrCoSs5DKEIeLKk9K7+ujhAg9cj59BZzApfC4VyUYGb5bHzfHEAIKWnMSbGJU5Q62mHB76R+Imi3izWQ2s2g9yzecW/eA2NjMIz7PEslOb889YleeT/dO1+enZ7R8o15foPjMcognj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(2906002)(31696002)(31686004)(6512007)(316002)(8936002)(8676002)(6486002)(2616005)(110136005)(6506007)(6666004)(186003)(966005)(5660300002)(508600001)(52116002)(36756003)(53546011)(83380400001)(66556008)(38100700002)(66476007)(66946007)(142923001)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmVkNFAxWGJZWHRsT1hiTDVsNWUveVgrZ0VObTNvcDltajYxdDBUVzQvOUx4?=
 =?utf-8?B?TWVkOE9BZEFFWmtCMUIyRHZuS0NEMGU2azFtWkt0OWpJZjZybXl2dHkzVVhO?=
 =?utf-8?B?SnJMbThybTFjTjl3UnhCK2RHeXBNVVJuajBVUDVhRjZmb2ZZQ3BYK3paUWZC?=
 =?utf-8?B?c2dOMTZFbnRJNjQvdkNvQ3hsU0poQjhrUFlMZ25aOHBIL2NjS2FSbWFIZ0Fi?=
 =?utf-8?B?QnB1VzVyZ3NhbXZjd3paVnRDVWFWQ0xVb2JQUUZqRFVOeE13Ujd1R1IrOVdS?=
 =?utf-8?B?SHQ4dFlvTUNRSmpoa2hwTGQxbitZaCtFdmZhYmFLbU5VQy9MeUwrTU5OODVG?=
 =?utf-8?B?U1N3TXJnQWY4NlNScUNJQTZja0k4YnRTUEk0UWdhbnB1T1lpYW4va0dOYW5Y?=
 =?utf-8?B?K293azRuZEpWQkg5T1o5aDdYOHZ5bVlwS0ZuWnlUaG1jR0lTT0NtUHJ2VGdH?=
 =?utf-8?B?L0dzbUtIVG4wbmhrcitPNXpPUWZ4VWJSNm43aHAvZW82VGhOVVg3amJsUnBV?=
 =?utf-8?B?NDBsVzRDaGpUQ1ZGVDJzZ3RvS1ZMaHYzYzdwQm1pdFY4aCtWZ0tYTVdpTFFE?=
 =?utf-8?B?MzNVcTVzTkVyNmxtRWhhYlRBOG9LcHBMMmVEL05QWlMwT2dzVVFOSk52UC9N?=
 =?utf-8?B?TC9GWVBMNDREL3BYM29wc2Jnc0JoV3cvUUtJMURWc0xWZkhneWxFajBoU3JN?=
 =?utf-8?B?UE1HVWR4dUJJZlM0MkFyL1Exd3BPNWtpaFdQeGVibVczRlBqWld0dXZIa01t?=
 =?utf-8?B?WEdTZlpmcFJ5MU1LQkNhTzlEVWJrQ1U3a21kQnZtaGtKZmM5ZnpMNG4xL0tw?=
 =?utf-8?B?ZFZsOW8yN0lsZjZ0NFYwUExZcUk0cHh2S1pySCt1dFovK3JvNWdKTmxvMjkv?=
 =?utf-8?B?bEVOc3lPWmQxWlpwSW5OR0NhUldPeDNVc3dqWFBjVXhOTVAzNndhNE5xTFMx?=
 =?utf-8?B?djJkZHFpbG1XSnNxTUNYR1VobkU4WW5tbkhSWWZseC96OThoQy9EQnh0dld1?=
 =?utf-8?B?YjVpc1Q3VDhlNkVQVURhZ0Eyd3NBK1JWSVBvcS9qYXNXYWVEa0YrTGU2MDRm?=
 =?utf-8?B?T3YvQnJJY0IwQ3NkTmhjc1M1ZlhiT1V4d0p6cXJaS2VCVGZuMXY0UXFjd3pl?=
 =?utf-8?B?bkdEQ3hsMlQ4endIRnhPOXcrL1gzQy9sL3dITTBrSUhCd3NMOFVDMkVGbm9p?=
 =?utf-8?B?bUJVQnFGaUZsV2JHN0FZeHdLMll0SFllU3lQdnZrOTNyM1ptMG4vbXZlR01L?=
 =?utf-8?B?czBONnRqc2hiQVJnS29xNDVwZW8wdG9HeFRBTktwd3IvOEEwRGQycy9oYi9x?=
 =?utf-8?B?eDNjcGRWL0xyTWZncDBVZU13TG5vQTVuMk9maWlGL1VWRm95cjBwZk1JR1Mw?=
 =?utf-8?B?aUxZcGMvNnBSSGM3Sk9nRDBwbDJiaEpIRUsySmZ3bVBYaW40Mk5saWNHOE5E?=
 =?utf-8?B?bVZEVU9HRFNXUDg0T3ZvRlVBN2VZbUVmOFNYN3d1SUdkaEgwM253Y2tETU53?=
 =?utf-8?B?OWRveHZ6dEZpU2pqRmxQdUM3QzNsUnhSOXBJZmVxZzRML01vRkxvaVIvY095?=
 =?utf-8?B?YU9MclkwdTVINjNWMjJhK3dtK3laWkp5QTRlWFBZaUhVbUp4UUFtaSttR0da?=
 =?utf-8?B?aVFUZUZISE1JRzVsVW5PTTZqTmxWMXdDSE1ZRnl2RE84WGZUK1pZRXBoYkdo?=
 =?utf-8?B?RVREWjZnNzdZZVJEQzBzQTU1aS81bEIySlJQbCs2NkFxMXB1MEJ3aTVibmc0?=
 =?utf-8?B?NmZKMldwSERzNi95NkhicXdrU1J1UVZxQ1VqSVpURGtzVXJiUVptbVh2eDFU?=
 =?utf-8?B?ZkNUekttbWZhTnV1cURGc1RwMGYyNXhhdUZFQ29yRUg5cWxqRjN5eEJyWWtm?=
 =?utf-8?B?RjhHd1JLa2xOSjhkUDJCU2VGZVFJY1JPT2Nsb2hIdmlFRjg1Z3Z4Y0hycnFh?=
 =?utf-8?B?bmVFMTQ1VGMyQlJxd1loUGsxZXUvUmlyTWlkeDhYK0tnSjFWK1haOXdJRnB4?=
 =?utf-8?B?MVRSSXVMOHRjRUZZZTdScHBVODVDbWJqYy9FWmtLR09NOGpHOU1HRGRRa0Jr?=
 =?utf-8?B?Z0dobDBkU3FLVkYvT0U0Z1E1dUViNEU0bHpCcEtSSjdwSVB0Nk1rOURYOUxH?=
 =?utf-8?Q?B3O2IVexZtGv9W6UI/+2WgLA6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1ecd84-258a-4a0e-c590-08d9e200999b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 01:50:45.6198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W/c3OfBj1dD+giZTSBB7XxKHyEnuujFKh8SRsAyMYgRuhZd4u213Qe35s6urvq17
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5038
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: bVsdk1giwvZmg6aFQTyaiwDmmGzx0s-A
X-Proofpoint-ORIG-GUID: bVsdk1giwvZmg6aFQTyaiwDmmGzx0s-A
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_06,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 spamscore=0
 mlxlogscore=999 adultscore=0 clxscore=1011 mlxscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201280006
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/25/22 12:32 PM, Vincent Li wrote:
> On Tue, Jan 25, 2022 at 9:52 AM Vincent Li <vincent.mc.li@gmail.com> wrote:
>>
>> this is macro I suspected in my implementation that could cause issue with BTF
>>
>> #define ENABLE_VTEP 1
>> #define VTEP_ENDPOINT (__u32[]){0xec48a90a, 0xee48a90a, 0x1f48a90a,
>> 0x2048a90a, }
>> #define VTEP_MAC (__u64[]){0x562e984c3682, 0x582e984c3682,
>> 0x5eaaed93fdf2, 0x5faaed93fdf2, }
>> #define VTEP_NUMS 4
>>
>> On Tue, Jan 25, 2022 at 9:38 AM Vincent Li <vincent.mc.li@gmail.com> wrote:
>>>
>>> Hi
>>>
>>> While developing Cilium VTEP integration feature
>>> https://github.com/cilium/cilium/pull/17370, I found a strange issue
>>> that seems related to BTF and probably caused by my specific
>>> implementation, the issue is described in
>>> https://github.com/cilium/cilium/issues/18616, I don't know much about
>>> BTF and not sure if my implementation is seriously flawed or just some
>>> implementation bug or maybe not compatible with BTF. Strangely, the
>>> issue appears related to number of VTEPs I use, no problem with 1 or 2
>>> VTEP, 3, 4 VTEPs will have problem with BTF, any guidance from BTF
>>> experts  are appreciated :-).
>>>
>>> Thanks
>>>
>>> Vincent
> 
> Sorry for previous top post
> 
> it looks the compiler compiles the cilium bpf_lxc.c to bpf_lxc.o
> differently and added " [21] .rodata.cst32     PROGBITS
> 0000000000000000  00011e68" when  following macro exceeded 2 members
> 
> #define VTEP_ENDPOINT (__u32[]){0xec48a90a, 0xee48a90a, 0x1f48a90a,
> 0x2048a90a, }
> 
> no ".rodata.cst32" compiled in bpf_lxc.o  when above VTEP_ENDPOINT
> member <=2. any reason why compiler would do that?

Regarding to why compiler generates .rodata.cst32, the reason is
you have some 32-byte constants which needs to be saved somewhere.
For example,

$ cat t.c
struct t {
   long c[2];
   int d[4];
};
struct t g;
int test()
{
    struct t tmp  = {.c = {1, 2}, .d = {3, 4}};
    g = tmp;
    return 0;
}

$ clang -target bpf -O2 -c t.c
$ llvm-readelf -S t.o
...
   [ 4] .rodata.cst32     PROGBITS        0000000000000000 0000a8 000020 
20  AM  0   0  8
...

In the above code, if you change the struct size, say from 32 bytes to 
40 bytes, the rodata.cst32 will go away.
