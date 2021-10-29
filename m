Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4C143F3C0
	for <lists+bpf@lfdr.de>; Fri, 29 Oct 2021 02:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhJ2ASM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Oct 2021 20:18:12 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34656 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231162AbhJ2ASM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Oct 2021 20:18:12 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19SITmqa022391;
        Thu, 28 Oct 2021 17:15:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=buoGDLwBdqh6umZRM9Ywmtto+S90sgzYjWJ9Q2JY+EM=;
 b=aanvDocXL2CdhqB5mBlOcX3RCVNhXnrcdXQHVWVBdn3TTFaARgKGo7tTjjWkobBuu2Hp
 FBWrp21t8Qi+YP7DtSrTsN78DDWU7rYiUq3lytb5lJZUf8MhZ7DrFX5LkFisKhBoJaGi
 /ZxFzVrI4xLG3PIURG0R0KCmsPz7bMo39Ug= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bysednsfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 28 Oct 2021 17:15:30 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 28 Oct 2021 17:15:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7N1J2RLlWQ/zWjnP0wIPsM/Hd5OkGSpKI2qAxGZITph3ZS1d4P0yNOcymUp6c74Q7iZKbxDFTt3Ymk9h4/lP8fXdj9nNUlG5rCbUrWw7JcKVCXscCm0bv0+rjpNO8MNBrnRaUddM42zkz0+xaQ/CDF+LTv6ma9sceDYfNoKSNl1gJeeYYdVfDgcA1HytdOcYdHK7BQ0CpmJU5tgJZlbqEBzxXlw9og1IJu7LIMqaIzNhPLyKjJMgexUGNA5Q7ZPP0dHVJaeyXpk4lkYDH6TWUpmQlMsPymeFITOJVIWVhae4dieoN/d3akEm/bVhsLPXZQdCoxiaS8lKwxX4gqj1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buoGDLwBdqh6umZRM9Ywmtto+S90sgzYjWJ9Q2JY+EM=;
 b=Zox9esMe6pwhk8M52k0f17RWXA9Z7c6pcGxv52hKuZGUQDAUw5+lODcVvyusIcnbWXXBEZHEBmjzEOKMj56rpRRRTI7NDhafFS6RJ8As8ge+RfqCUKNiNhqCxG1dn3Qc0K1O6KUN8mwxmCEng8zJps0ZkedwnVl8/5Usn9raTODBfkLU6QAgKbQm9kO9v+m/4psnt/szZqpG/d3muPwfkXrhlEwjhTFJWBP+s1ACr+9ATl16ipqZF3A1yicT+c2Rlu+UuQRURs4QHMFAXKgMGYQl9pm/B7T1nZzmd37x6zPWAg7doEcphcAcPdEz4XVzE6P6wnP13WMG9SOtj57AvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB4465.namprd15.prod.outlook.com (2603:10b6:806:194::23)
 by SN6PR15MB2447.namprd15.prod.outlook.com (2603:10b6:805:21::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 00:15:28 +0000
Received: from SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::49cf:2655:67d:7b2b]) by SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::49cf:2655:67d:7b2b%7]) with mapi id 15.20.4628.020; Fri, 29 Oct 2021
 00:15:28 +0000
Message-ID: <76458a10-f42b-89b3-b4e1-6c42870b6059@fb.com>
Date:   Thu, 28 Oct 2021 17:15:24 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH v6 bpf-next 1/5] bpf: Add bloom filter map implementation
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Kernel Team <Kernel-team@fb.com>
References: <20211027234504.30744-1-joannekoong@fb.com>
 <20211027234504.30744-2-joannekoong@fb.com>
 <CAEf4Bza5SJgYABaM2s-s3cdYEEvrbkgp2MOqQiDgX8dCsJ_Y+g@mail.gmail.com>
From:   Joanne Koong <joannekoong@fb.com>
In-Reply-To: <CAEf4Bza5SJgYABaM2s-s3cdYEEvrbkgp2MOqQiDgX8dCsJ_Y+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0322.namprd03.prod.outlook.com
 (2603:10b6:303:dd::27) To SA1PR15MB4465.namprd15.prod.outlook.com
 (2603:10b6:806:194::23)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21c8::1716] (2620:10d:c090:400::5:5753) by MW4PR03CA0322.namprd03.prod.outlook.com (2603:10b6:303:dd::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 00:15:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd2bdee5-9069-46cf-689e-08d99a71365f
X-MS-TrafficTypeDiagnostic: SN6PR15MB2447:
X-Microsoft-Antispam-PRVS: <SN6PR15MB244737D8285ABFA9C10C6836D2879@SN6PR15MB2447.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZKU+GbMs7ux1hjT7LvjEiCpjc7j4TU5gngXx+dU7AgY9Y0oeiA7fp2bP/H/+MfBpcXHS5Ft52bqVaRxzzqdiWJdfJjbbFG4yMfIaa59SDQbSBxdXSlCEIpz74cWv2WjMiBc38U0VFNXVTcArA7gpnF3y/iSgi1hLTOAIQCfgB53p3WZ+GFxMcUVorZuHz6UKEWJesNnyOnmrgjAIvLoGi8DyLhvSoJMU+q6qQ9ve9etd1+MX+nw4nVgKAiEIXOJP/yNzYJcpnl31eH8xexYZtdBU1mtd25kHso9uUukQpjlOiMeKS7J07ol+yOWb3EprYZXbSlHI38ayL6DRj0Bbg1tWO3VJsqSolOdr7zI/0SE2uCf0jN5n13yI4yYrYR22TvIPNticFzQederEb9mA4JqfvdIj2hnWafAtrUCVgvdG3BgZXI5isJS0i9sWo3DRr5DBIwCW3hOWBQsD4YDFLmjyQx29Ln+iD4VerpKdNrerAALsdEcdd6S7jp+fPOc8eRu6malVl3SdB8H0dbYOWZNLUem8NNUkLUFgXO8XMTKuyVmqIkrsh9nEv0ZPwPMowSnYEO5yHXpvX2OAyhqx+zqooItUOoxqiVdacxln4xPug+caAkw7Zx7VQSYebWQfUx1LqM/ly/xlTwKycEMK30mU5RoDTnuRC5q9o4SX8H6x5FOxS/DYq45J3XtGEwpmkBPK5SXDCx6kifETs4DpoFtuxNR7sHBjfR+wDm7HdTM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4465.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(8676002)(38100700002)(6916009)(31696002)(5660300002)(83380400001)(186003)(6486002)(86362001)(54906003)(31686004)(66476007)(66556008)(2906002)(36756003)(6666004)(4326008)(66946007)(2616005)(53546011)(316002)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZE5Tck51TkJJeE9LQWRqR0wrMG02aVJZTUhTcjZTemxxRWxQdSs4d2NZSEpS?=
 =?utf-8?B?aWI2ZE5qTmJGZDdLajdxRGc1YTBxTTlzRnVmV1hHRUJuMjk5T0I1dGhsRWwz?=
 =?utf-8?B?TEJDMEtSUVMveDlGTTl3Qk5HQkhnRER2VUcyaUQ1ZzdlSTBNSkZ0Si9TV2Nz?=
 =?utf-8?B?T1kvbTZzZFBQSzMvVDZRaEdaaEthUGM0Nmxidyt6WFpJYWRyUks4MHJBNURk?=
 =?utf-8?B?dXQxdndhSjl6SFFGd3oxM1hEK3hJUFlHN2RrNHUwS3RGUEI5TlVvS2xkK0Mz?=
 =?utf-8?B?UEZBUGR5aTRGWldwK1JKcWd6S0VvblE3ZlZreEFoS21RTzhvR0VST1NkWkYx?=
 =?utf-8?B?TkJYMFpnU1V5T0VjNHhsT2xLQm05aGlWb3huTVBXeDM1d0k5TEdKS1FEM3A5?=
 =?utf-8?B?RzJHZVM1bnVWVkRjRExmeDFGQjczMElDYzJIdS8vdkRBTjE4NnRBKzJ5S0c4?=
 =?utf-8?B?RUFpakJ2Z2VxVDMzeTEwUWx4bldQTExVR0hYSUlqNk53eTQ3WmtjMThwa1pC?=
 =?utf-8?B?WE9WSE1ObXkxMUZ5WjM2Z0swOWxPMWtFM0lwdE9WcDlPMkJnS2l1cGF2N2Y1?=
 =?utf-8?B?V1pacGZBK2h4Q01CcDJHNkxjL3JJQ01od0Q4RWYvU3hGV1JTR2Zjc213SHNU?=
 =?utf-8?B?ampFSU0zOFBjSnNiaHlNVU9WSUxjdVZkWmphdTNEdnp4ckZDSlh0RjFWTkxH?=
 =?utf-8?B?UWJ5UHZZcjB0VmRhZE5ONHliejREd014a25aMjk3bjMxVVRhZXNuTkZNelZS?=
 =?utf-8?B?SmdJaGZxRmNuc3kwNmNKNGVwVDZvZmVpMDNveUpCYjN3dmFnMUdTZzJOKzk0?=
 =?utf-8?B?bU53VXhPU3hqbExPK2Q1ckJJc1lpcXVSekoxUUQvSFVweEFoVHhWRU44TElW?=
 =?utf-8?B?dzIxZ0FYdUFaNDFRWXhvOURzNjkzT2RRQUwvZm1YUTVCc0VtYllZNm9HSXBZ?=
 =?utf-8?B?bnpVV1htblB5QWMzemxuazdTc0VuRkFMQW8yYitXekRJV09CcFZkRU1XOHY1?=
 =?utf-8?B?emJIY3MxdXd3anZMK1FrS2xFMFlZdGg0dDcyS0FyRVRjdXlFQ1dYZlhaWGhM?=
 =?utf-8?B?dmpCbTQ3am1Wd1BOUFVYVWZtTWcwM0dSaTVjWE5ULysrelZTcjBHMnM4a1Fa?=
 =?utf-8?B?YnJqSW9Nbk9BbFo0a2ZURzlLQXRId0NJZlpiaExUWmpncXd3bjZqbVJQeU9n?=
 =?utf-8?B?Y0FDSFBUaEw5OUs3M0pkWUZheXBILzZBaHdPd2NNbzJxNkpOL1VqT0oyRXcz?=
 =?utf-8?B?cHRWR3hNck1leWt5amxlL2g5bWgxTnFRR3hldy9ON2Qxd2cvRjZ5bXBVVFFT?=
 =?utf-8?B?MGVMUHRzODQwNElqOEl0NmdYRXprdWo1QXY4UmtKMkVMdTNhRVBIdmlhRzNk?=
 =?utf-8?B?MWVIZ0d4cmQvUDdFOVczdUw5RnN3UVR6YVBMdGEwbWl2ekNPVGJpdzhxVjVB?=
 =?utf-8?B?ajM3QTVhQjFCamJuZnBmVG1Ndk1mMHk2bWpuOTd1TXBKYWZoSmFWMjY5UXE5?=
 =?utf-8?B?S1BNOElGclVOb0F0UVE5NllMNHpZR2hUZWRuT0RtL2RMRCttTnJYUlBDS0Nk?=
 =?utf-8?B?aGp6TWgxMXYzNkt3eDkrTlY1QytSWUwxekVPSzJoU3hEV0VWbXhBTkVwOG5B?=
 =?utf-8?B?bTBIT2NteE1yTCtyZ3VqZzVoazN0eHF6cDgydHk2alVXWmNWZ3pMb0MyeUtG?=
 =?utf-8?B?OFNPUmwxWCtBbUVGeFk3VU00MWIzM2RpLzBkZXY2Y2xkZlh3TytiblNjZFhk?=
 =?utf-8?B?S3RORmtpMGYvK2M1VTVSZ2pZS3FkS2pjSU1oczIybk1SeDdkSFU0NUVmK003?=
 =?utf-8?B?LzBBaXZZY3YycE1iWjJ3ekJJSHBTMG4rblZWL05HY1h4cXprOGhZbWxXVVUz?=
 =?utf-8?B?SUlQV1hhWXgwMlJhcW9mbU1OVjA4T2E4Sk1FMG10T0lkUFZocVNoaExrNkpU?=
 =?utf-8?B?NU1OaGlnK0VGK0xXQzMwQWtVMFFUTThMTEpkaVhLUy8zWlZ2SFkzV1B1NlFD?=
 =?utf-8?B?VGRuSjdvYWRLaHlXcjlnaDAzNHR0bm9UWWg2dmZDdkRpY2RKRkMrRmIyWVI5?=
 =?utf-8?B?TlFkYVl4cFE1NUhRWVE0M25pZjc5TkdJZDdMbnBtM24xMDl4MGxaSjZUbkpS?=
 =?utf-8?B?Y2VpTFhBaFlUU21obFpzNytPQzlPVWoxcFVUODJ5SW0rRnpWMG8wcWxINjZI?=
 =?utf-8?Q?if5eE5Jo7gKx9sTxzOqs3rvic7HvRrP1Zq9sBEtxbaGK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd2bdee5-9069-46cf-689e-08d99a71365f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4465.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 00:15:28.5393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wqe3eqXhfUqUHanmGX3/WC+A3ptaeXhMzbvCNKhwInfSI5EeWR3lg0AMIWpPFL9IrU7nqWSJxaL2YfFUY971uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2447
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: k2J3YvphHJ0EyxBV4OuVkxLskR43eIVt
X-Proofpoint-ORIG-GUID: k2J3YvphHJ0EyxBV4OuVkxLskR43eIVt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-28_06,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110290000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/28/21 11:15 AM, Andrii Nakryiko wrote:

> On Wed, Oct 27, 2021 at 4:45 PM Joanne Koong <joannekoong@fb.com> wrote:
>> This patch adds the kernel-side changes for the implementation of
>> a bpf bloom filter map.
>>
>> The bloom filter map supports peek (determining whether an element
>> is present in the map) and push (adding an element to the map)
>> operations.These operations are exposed to userspace applications
>> through the already existing syscalls in the following way:
>>
>> BPF_MAP_LOOKUP_ELEM -> peek
>> BPF_MAP_UPDATE_ELEM -> push
>>
>> The bloom filter map does not have keys, only values. In light of
>> this, the bloom filter map's API matches that of queue stack maps:
>> user applications use BPF_MAP_LOOKUP_ELEM/BPF_MAP_UPDATE_ELEM
>> which correspond internally to bpf_map_peek_elem/bpf_map_push_elem,
>> and bpf programs must use the bpf_map_peek_elem and bpf_map_push_elem
>> APIs to query or add an element to the bloom filter map. When the
>> bloom filter map is created, it must be created with a key_size of 0.
>>
>> For updates, the user will pass in the element to add to the map
>> as the value, with a NULL key. For lookups, the user will pass in the
>> element to query in the map as the value, with a NULL key. In the
>> verifier layer, this requires us to modify the argument type of
>> a bloom filter's BPF_FUNC_map_peek_elem call to ARG_PTR_TO_MAP_VALUE;
>> as well, in the syscall layer, we need to copy over the user value
>> so that in bpf_map_peek_elem, we know which specific value to query.
>>
>> A few things to please take note of:
>>   * If there are any concurrent lookups + updates, the user is
>> responsible for synchronizing this to ensure no false negative lookups
>> occur.
>>   * The number of hashes to use for the bloom filter is configurable from
>> userspace. If no number is specified, the default used will be 5 hash
>> functions. The benchmarks later in this patchset can help compare the
>> performance of using different number of hashes on different entry
>> sizes. In general, using more hashes decreases both the false positive
>> rate and the speed of a lookup.
>>   * Deleting an element in the bloom filter map is not supported.
>>   * The bloom filter map may be used as an inner map.
>>   * The "max_entries" size that is specified at map creation time is used
>> to approximate a reasonable bitmap size for the bloom filter, and is not
>> otherwise strictly enforced. If the user wishes to insert more entries
>> into the bloom filter than "max_entries", they may do so but they should
>> be aware that this may lead to a higher false positive rate.
>>
>> Signed-off-by: Joanne Koong <joannekoong@fb.com>
>> ---
> Don't forget to keep received Acks between revisions.
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
Can you elaborate a little on how to keep received Acks between revisions?

Should I copy and paste the "Acked-by: Andrii Nakryiko <andrii@kernel.org>"
line into the commit message for the patch? Or should this information be
in the subject line of the email for the patch? Or in the patchset series'
cover letter? Thanks!

>
>>   include/linux/bpf.h            |   1 +
>>   include/linux/bpf_types.h      |   1 +
>>   include/uapi/linux/bpf.h       |   9 ++
>>   kernel/bpf/Makefile            |   2 +-
>>   kernel/bpf/bloom_filter.c      | 195 +++++++++++++++++++++++++++++++++
>>   kernel/bpf/syscall.c           |  24 +++-
>>   kernel/bpf/verifier.c          |  19 +++-
>>   tools/include/uapi/linux/bpf.h |   9 ++
>>   8 files changed, 253 insertions(+), 7 deletions(-)
>>   create mode 100644 kernel/bpf/bloom_filter.c
> [...]
