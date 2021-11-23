Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7B7459924
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 01:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbhKWA2B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 19:28:01 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45476 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229562AbhKWA2B (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Nov 2021 19:28:01 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AMME8Gx028427;
        Mon, 22 Nov 2021 16:24:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=8kmpgpttMK+B2GLoqXO7LLnfpxYUVeNcU7My42vRmwM=;
 b=TbeRDt4pXSTKHsCTsG1Yi5zurvil0vygYn+6zlh740yNYSZpQGYq3CP9kt9wbEY+3fXe
 04SCiwLJ+CyN7ICjoaqwcB18YUxzfAxAww8uc0JbKODtjFkUVrN/3i9AGJjVDX58vfsZ
 b6jCG3v72b7a/c544aJ3Wlc210wVvdWR9CU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cgaffw2bf-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 22 Nov 2021 16:24:51 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 22 Nov 2021 16:24:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8d9rrmYgrmPycnMbHCAbUZCTsCzvxtMt+KFKoD6lIbTBZXBhPvhsDr3Gsws2nQcIKE2rqXeV1wKEzBcUesRX7fGewhO/GwChRqQSGOGECzMBR3+9nL0re8OpYfpd0BzZIDxO6HHhyvfEc3UFhtbrprjrktmOE8WQtONrGOVrPdMJTR5PMs8sns2vKANUF0eCXPlPU2w29fLt6ZFbqCcebpdnT/ZGSMPROJaDHYVFGLdBSU128EJTjqRPZS42k3hZLBRfRVCnDj+zYo0G0em4xcscIS9F04wUrsu11Y/SozwtsW51RJJp749M8ZwaKdXDGFb7No69jvFSjJZkyPNKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qonKbDp7g2p/JuWoRySzZ+D2l5d6B12SvWa734BI1ZA=;
 b=BQIXOaKJGUTBOJBwiX40Tbbm/QrwUcob8jlyrudjrewmAwa/+D67XM8YkgUPvrzbjbLOXw/xm/F1TdFHuZP53bVtI9y2t7cNd5b4Nhitwr3qO1STakKe9MpmBj14ICgKqpYoX1t3hSP35a/1W3aPtSMi7sh9rxGo2iqTrOymmtNqH6hHezyIu+v+FrsTMVg9ggiT7kc4Rzgm7AL0zZ5HJZ7K6LxdmJZKktR6+BBJcQCnecQ9ooF9xZ3RTYtw116Yra14oj8VJOmLJQisR55Ax2UHOClXKnOEkkmerNdF/JANN6Q+wFkLXtT3Xp8isodVjkB1lHDGT3HyNjL03Frt1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4982.namprd15.prod.outlook.com (2603:10b6:806:1d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 23 Nov
 2021 00:24:26 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a91b:fba1:b79c:812c]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a91b:fba1:b79c:812c%5]) with mapi id 15.20.4713.025; Tue, 23 Nov 2021
 00:24:26 +0000
Message-ID: <c3c0922e-28b3-ff6d-3877-4fe869776004@fb.com>
Date:   Mon, 22 Nov 2021 16:24:23 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: BPF CO-RE and array fields in context struct
Content-Language: en-US
To:     YiFei Zhu <zhuyifei@google.com>, bpf <bpf@vger.kernel.org>
CC:     Stanislav Fomichev <sdf@google.com>,
        Fangrui Song <maskray@google.com>
References: <CAA-VZPniKnO4ZkYztkt0uL0s5TdKuwTRvoz5KORJg+MY-bVcHw@mail.gmail.com>
 <CAA-VZPmxh8o8EBcJ=m-DH4ytcxDFmo0JKsm1p1gf40kS0CE3NQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAA-VZPmxh8o8EBcJ=m-DH4ytcxDFmo0JKsm1p1gf40kS0CE3NQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: CO2PR04CA0174.namprd04.prod.outlook.com
 (2603:10b6:104:4::28) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Received: from [IPV6:2620:10d:c085:21e1::14f6] (2620:10d:c090:400::5:7eab) by CO2PR04CA0174.namprd04.prod.outlook.com (2603:10b6:104:4::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend Transport; Tue, 23 Nov 2021 00:24:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ce9bd2f-55fd-4381-f3ba-08d9ae179b18
X-MS-TrafficTypeDiagnostic: SA1PR15MB4982:
X-Microsoft-Antispam-PRVS: <SA1PR15MB49823F16A4D8595B888B2E16D3609@SA1PR15MB4982.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LwzyFPdASUW1X7KhhFiieQRBTj+84acGb4woWgxqYX0Ed95LSFnOd8u4rts6vsGgbyKiMdK3BEe4+c2MFBDc7VcQvQGeap2f26OunEfdowCCcFfWNRuvTnJhtp8QmALElzsjpv6kZHk3Pgw3Em+pNIl8tZ4StZT9ZyTdLBszY9RIJA/mgbPH5FqTO3izZ2wR2xYRMb7Qiwn5J8RZtFvluUTC+S5GU0GoywDMmUFvqWx2fyCWPhEcNNKsd6l/N3BRol2eN3NIk6s9G2U6GsVDYTniPB25LlEjMvjzOeQbwHP/8dbf1tDAuQ1TTrP6Gc48i/31lhSXIckk0oT4mF8wzPz7YmVXs4TWFyY7RiBtR6Rx4EWSCqdmgM9OpKoFYPQ/b/42oUnCe7kTDX0FplRla62MJbFtHOEmgWD6BOseQJxKoM4Qfqn7Ald+gvccMSYskVarxmC0LvyQoILk3OYMsaHTWrZhf6DWTiYtYiM5TAoEkBLNki4azzJt62SJAhvctmfZL++ElGFHMn1Trrk6/9ucM+HxkgftLM4A0vGKiysEQKT5LRF1e8QDwR/HItqtv579FUx3QbegFc+Gl/BRByiDofJb+PUuMqZ2NO/rD0Ijguj/tY6NB/oY86VwmvWPyA49S8UU+Hktzir8p6cSzlLNpI91xMLGhcrlegNOnBHO+PqCPJNQ89aPa7ZB0CPNFt0Jb7SAKG42tUfmVw7yel8fOAKjRvT4NSXnVbw+PXQ/tcJM988LOVmbrFaRkJjFBwSKy9hHUlTTGx4J4v9hlsiiK8HjCLWcxRi2FhMoHfg1zcug3e8yPXcF2w70yw+qaVcXNy/OnOegY6An1gKxhWTGIs7YiO4soRQmi7kFmbo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(966005)(4326008)(5660300002)(31686004)(4001150100001)(110136005)(86362001)(508600001)(31696002)(54906003)(2906002)(316002)(8936002)(36756003)(8676002)(2616005)(83380400001)(186003)(52116002)(66476007)(66556008)(66946007)(53546011)(6486002)(43740500002)(45980500001)(505234007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azlWcTQ1MFJYb29BdUJWNnFnWnI1SThPVDlhcWZCV2gzQndkZ1Mrd1FjeDhC?=
 =?utf-8?B?aHJPMXdiWGxTVHNyODRqNDJYSWdlMEpCZmZBaVlZLzM0cTd5ZjM3QjhEM2Z6?=
 =?utf-8?B?NzZQVEszNm1VUTMvVk9EZVZiOTEvRlJjSnQwMVVSaEpFVXYzKzVPenJSUTYz?=
 =?utf-8?B?RHczOWhCMEozTmQ2dUpZcVE5WCt4QmNydmxjNUcyVUpMaWNZbEE4UEZrclg4?=
 =?utf-8?B?R2pRUzhKcFBkWTd0TWZOYU96N29PQ2UrajJGYW1zOWNnNzdJdEZVMnU0R09Y?=
 =?utf-8?B?WUMxc3ZJUnYvMDVpeFp5bGxmWW5zOW0zNjhuT3dSOE1ZQWhPWGlQT1kxeElQ?=
 =?utf-8?B?MXkybU1ZdWo5MGhzcnZYa21WVlpDVjlaZERlWHJEajluWFBKakROeXdqcTkz?=
 =?utf-8?B?UERLTVFEQmY2MS9Cd1BYVlE5RUIvc3ZCLzZLeVVBcmdTQ2N1eEZkSkg0OVla?=
 =?utf-8?B?K0NZM1BGemNWU3c2QllvYm94UmM4WGduRmJOSTdtcGFudjlqaUZWZVNQa1Jm?=
 =?utf-8?B?NFNXZlN4L0s3Y0JFUjNRY1lEYmZYRW41eXFDTTN0aHdkYXR4S2ZKU1B6eW8z?=
 =?utf-8?B?N0IzcE9paGpHbzdxaGNTNGhrTllMK25SeDA0MVRvQVJhT3MzY2Rsd1lCOFBl?=
 =?utf-8?B?M2Z1OTBUSHBmcjNkMm5rZjZwVFpNeWtMSFE1RUVhVko0endkK2FCV01VMkY2?=
 =?utf-8?B?MmpqelhiZTBkMkdkV0RkaVZvc3lVY3hMVDZmeHhNbFB6aDYrbU9WRjhBSk16?=
 =?utf-8?B?RVB6NFlqSjRTVVd0QnhwMEpSVnkxYzBnYm96dmNjZ3lNU3N5cVVveHlObzlI?=
 =?utf-8?B?c3dYSTZQK0EzSG1FeWJ0L1Z0bFdwM2I2Yy9UdHhhOXQ4b2lQK0hVd3lEQk53?=
 =?utf-8?B?WGhBZWdFUGYvOStDV3BQaFRlRkVsZi9YV0cyTG0yWGZ5T1c3L2J3VHNGWWk3?=
 =?utf-8?B?eUozSk5ndXBQNlRKa09idlpteCtsenJwY0Y3cXNob3RoR3l1c2NZRjl0YW14?=
 =?utf-8?B?VVlCazNGTWtvVFhraSszRjEzblNBeXZ3UHMwQVpuUWwwbHZQdVRCSUdxeDBR?=
 =?utf-8?B?RTRabUlLYllpbUdxdHpwTkp6MXg4TEg2S1hNQzlsMHpydDI3NkxpT25CdUxn?=
 =?utf-8?B?aHBKQVdDOFhlLysxSU0yaDlKSzFOK29hRTRVdmR6dzk2Vnh0WTQvMnM2N1dE?=
 =?utf-8?B?U0htOVZrcW11QmF5UFFEbWRwK3NVWkdyRVVmWmhQcEFpWGlNMlpaY2JXY0Q5?=
 =?utf-8?B?WUlmN0RJRGlvbW9WclFKYjdlTHRtak56aENWOG9BM2E4ZGN0SElBenNXdm94?=
 =?utf-8?B?OEdUTDNkYXZQRVg2MWptMmw1aDBMamxYRzBnazgxUjdnRDRhMXQyS2l6RnVB?=
 =?utf-8?B?WU40SkZVbVg2VDZlNklpbVo2YUJ4dUovTXlZbmFhT0cxKzMvODVZNDhzMHMr?=
 =?utf-8?B?QlZsWjJHZ3J5SzFtTTB3SitmUlhlQTdDN0x4TjFaNDE2NDUzUW9aaGRKNno2?=
 =?utf-8?B?NlYyaC9ZKytyRDhEc0dyU0hzVVFscUVtRXptLzZTSm9yQUdrSzhxVm9GS1ow?=
 =?utf-8?B?T09nT2RUbDZDVWRnWVJIRk5yQVA2NEdCN3RIRDVpQXk0dURndVdCaTh3b29k?=
 =?utf-8?B?MzNyb042cUY0RFBmSDJoRSt1eklGb3ZLdisrQ1pHRWtPaWt0U2lGNUJCSjBy?=
 =?utf-8?B?MkFQcDRpaWhYenVud1JNTUxvSTg2b3RMK1VXUlJ6OTlWa3k1cUNSOGwrUHAy?=
 =?utf-8?B?RjBCM2FGazlkVXhwcG1rUDc1ZTBxTTd0QTBQTFE4cVVrRlRqZmNkTmRZTFpK?=
 =?utf-8?B?OE1YMEYwNHdYSmpoT0tzS3JyUUJ0dnBEVU03eFU2QVEwdkg2SGh1NDJTY2l1?=
 =?utf-8?B?N1l2cTdUY1VibjJMS01GMXVlRFZYbjNqcHh4K3hLQXE5OFJKR3J5enhmNjdq?=
 =?utf-8?B?SEtOVG5nVVlyZ25BU085WGNXUUVDbWhhSWh1eGJEZk1yV25xQ1NQVEtYZ2gy?=
 =?utf-8?B?bXlXek9EUXp6bDdXalM4VEhNaVRTc1dHV1hLa0x0MlJOMnNXNk1Qa2Rha3VS?=
 =?utf-8?B?cG91alY2alF4MVpFajNSckx0RDVaMk4wSCtzcjJwenN0OVhpWVBraEFDblk5?=
 =?utf-8?B?eTVxVXRiYnJ5ZTJmT00yM0V5T2NhMWpGZUtXOWhYUnpKa1J0NXN4dVpyTmM4?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce9bd2f-55fd-4381-f3ba-08d9ae179b18
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 00:24:26.0089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6pWG+v/sGiyBFHHo9n4lvepQgnk6WWcMgtY1XViFA2tGq+mwucYRawSX0SmZIpcj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4982
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: G1ugI-9Dy4DtOS3y7kc2haeLRCO3ApAY
X-Proofpoint-GUID: G1ugI-9Dy4DtOS3y7kc2haeLRCO3ApAY
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-22_08,2021-11-22_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 mlxscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111230000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/22/21 12:44 PM, YiFei Zhu wrote:
> On Mon, Nov 22, 2021 at 8:19 AM YiFei Zhu <zhuyifei@google.com> wrote:
>>
>> Hi
>>
>> I've been investigating the use of BPF CO-RE. I discovered that if I
>> include vmlinux.h and have all structures annotated with
>> __attribute__((preserve_access_index)), including the context struct,
>> then a prog that accesses an array field in the context struct, in
>> some particular way, cannot pass the verifier.
>>
>> A bunch of manual reduction plus creduce gives me this output:
>>
>>    struct bpf_sock_ops {
>>      int family;
>>      int remote_ip6[];
>>    } __attribute__((preserve_access_index));
>>    __attribute__((section("sockops"))) int b(struct bpf_sock_ops *d) {
>>      int a = d->family;
>>      int *c = d->remote_ip6;
>>      c[2] = a;
>>      return 0;
>>    }
>>
>> With Debian clang version 11.1.0-4+build1, this compiles to
>>
>>    0000000000000000 <b>:
>>           0: b7 02 00 00 04 00 00 00 r2 = 4
>>           1: bf 13 00 00 00 00 00 00 r3 = r1
>>           2: 0f 23 00 00 00 00 00 00 r3 += r2
>>           3: 61 11 00 00 00 00 00 00 r1 = *(u32 *)(r1 + 0)
>>           4: 63 13 08 00 00 00 00 00 *(u32 *)(r3 + 8) = r1
>>           5: b7 00 00 00 00 00 00 00 r0 = 0
>>           6: 95 00 00 00 00 00 00 00 exit
>>
>> And the prog will be rejected with this verifier log:
>>
>>    ; __attribute__((section("sockops"))) int b(struct bpf_sock_ops *d) {
>>    0: (b7) r2 = 32
>>    1: (bf) r3 = r1
>>    2: (0f) r3 += r2
>>    last_idx 2 first_idx 0
>>    regs=4 stack=0 before 1: (bf) r3 = r1
>>    regs=4 stack=0 before 0: (b7) r2 = 32
>>    ; int a = d->family;
>>    3: (61) r1 = *(u32 *)(r1 +20)
>>    ; c[2] = a;
>>    4: (63) *(u32 *)(r3 +8) = r1
>>    dereference of modified ctx ptr R3 off=32 disallowed
>>    processed 5 insns (limit 1000000) max_states_per_insn 0 total_states
>> 0 peak_states 0 mark_read 0
>>
>> Looking at check_ctx_reg() and its callsite at check_mem_access() in
>> verifier.c, it seems that the verifier really does not like when the
>> context pointer has an offset, in this case the field offset of
>> d->remote_ip6.
>>
>> I thought this is just an issue with array fields, that field offset
>> relocations may have trouble expressing two field accesses (one struct
>> member, one array memory). However, further testing reveals that this
>> is not the case, because if I simplify out the local variables, the
>> error is gone:
>>
>>    struct bpf_sock_ops {
>>      int family;
>>      int remote_ip6[];
>>    } __attribute__((preserve_access_index));
>>    __attribute__((section("sockops"))) int b(struct bpf_sock_ops *d) {
>>      d->remote_ip6[2] = d->family;
>>      return 0;
>>    }
>>
>> is compiled to:
>>
>>    0000000000000000 <b>:
>>           0: 61 12 00 00 00 00 00 00 r2 = *(u32 *)(r1 + 0)
>>           1: 63 21 0c 00 00 00 00 00 *(u32 *)(r1 + 12) = r2
>>           2: b7 00 00 00 00 00 00 00 r0 = 0
>>           3: 95 00 00 00 00 00 00 00 exit
>>
>> and is loaded as:
>>
>>    ; d->remote_ip6[2] = d->family;
>>    0: (61) r2 = *(u32 *)(r1 +20)
>>    ; d->remote_ip6[2] = d->family;
>>    1: (63) *(u32 *)(r1 +40) = r2
>>    invalid bpf_context access off=40 size=4
>>
>> I believe this error is because d->remote_ip6 is read-only, that this
>> modification might be more of a product of creduce, but we can see
>> that the CO-RE adjected offset of the array element from the context
>> pointer is correct: 32 to remote_ip6, 8 array index, so total offset
>> is 40.
>>
>> Also note that removal of __attribute__((preserve_access_index)) from
>> the first (miscompiled) program produces exactly the same bytecode as
>> this new program (with no locals).
>>
>> What is going on here? Why does the access of an array in context in
>> this particular way cause it to generate code that would not pass the
>> verifier? Is it a bug in Clang/LLVM, or is it the verifier being too
>> strict?
> 
> Additionally, testing the latest LLVM main branch, this test case,
> which does not touch array fields at all, fails but succeeded with
> clang version 11.1.0:
> 
>    struct bpf_sock_ops {
>      int op;
>      int bpf_sock_ops_cb_flags;
>    } __attribute__((preserve_access_index));
>    enum { a, b } static (*c)() = (void *)9;
>    enum d { e } f;
>    enum d g;
>    __attribute__((section("sockops"))) int h(struct bpf_sock_ops *i) {
>      switch (i->op) {
>      case a:
>        f = g = c(i, i->bpf_sock_ops_cb_flags);
>        break;
>      case b:
>        f = g = c(i, i->bpf_sock_ops_cb_flags);
>      }
>      return 0;
>    }

This is another issue which actually appears (even in bpf mailing list)
multiple times.

The following change should fix the issue:

  $ diff t1.c t1-good.c
--- t1.c        2021-11-22 16:00:13.915921544 -0800
+++ t1-good.c   2021-11-22 16:12:32.823710102 -0800
@@ -5,13 +5,14 @@
    enum { a, b } static (*c)() = (void *)9;
    enum d { e } f;
    enum d g;
+  #define __barrier asm volatile("" ::: "memory")
    __attribute__((section("sockops"))) int h(struct bpf_sock_ops *i) {
      switch (i->op) {
      case a:
-      f = g = c(i, i->bpf_sock_ops_cb_flags);
+      f = g = c(i, i->bpf_sock_ops_cb_flags); __barrier;
        break;
      case b:
-      f = g = c(i, i->bpf_sock_ops_cb_flags);
+      f = g = c(i, i->bpf_sock_ops_cb_flags); __barrier;
      }
      return 0;
    }

Basically add a compiler barrier at the end of case statements
to prevent common code sinking.

In the above case, for the original code, latest compiler did an 
optimization like
      case a:
          tmp = reloc_offset(i->bpf_sock_ops_cb_flags);
      case b:
          tmp = reloc_offset(i->bpf_sock_ops_cb_flags);
    common:
      val = load r1, tmp
      ...

Note that reloc_offset is not sinked to the common code
due to its special internal representation.

To avoid such a code generation, add compiler barrier to
the end of case statement to prevent load sinking in which case
we will have
     val = load r1, reloc_offset(...)
and verifier will be happy about this.

The commit you listed below had a big change which may enable
the above compiler optimization and llvm11 may just not do
the code sinking optimization in this particular instance.

I guess the compiler could still enforce this. But since it does
not know whether the memory access is for context or not, doing
so might hurt performance. But any way, this has appeared multiple
times internally and also in the mailing list. We will take a further
look.

> 
> The bad code generation of latest LLVM:
> 
>    0000000000000000 <h>:
>           0: 61 12 00 00 00 00 00 00 r2 = *(u32 *)(r1 + 0)
>           1: 15 02 01 00 01 00 00 00 if r2 == 1 goto +1 <LBB0_2>
>           2: 55 02 0b 00 00 00 00 00 if r2 != 0 goto +11 <LBB0_3>
> 
>    0000000000000018 <LBB0_2>:
>           3: b7 03 00 00 04 00 00 00 r3 = 4
>           4: bf 12 00 00 00 00 00 00 r2 = r1
>           5: 0f 32 00 00 00 00 00 00 r2 += r3
>           6: 61 22 00 00 00 00 00 00 r2 = *(u32 *)(r2 + 0)
>           7: 85 00 00 00 09 00 00 00 call 9
>           8: 18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
>          10: 63 01 00 00 00 00 00 00 *(u32 *)(r1 + 0) = r0
>          11: 18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
>          13: 63 01 00 00 00 00 00 00 *(u32 *)(r1 + 0) = r0
> 
>    0000000000000070 <LBB0_3>:
>          14: b7 00 00 00 00 00 00 00 r0 = 0
>          15: 95 00 00 00 00 00 00 00 exit
> 
> The good code generation of LLVM 11.1.0:
> 
>    0000000000000000 <h>:
>           0: 61 12 00 00 00 00 00 00 r2 = *(u32 *)(r1 + 0)
>           1: 25 02 08 00 01 00 00 00 if r2 > 1 goto +8 <LBB0_2>
>           2: 61 12 04 00 00 00 00 00 r2 = *(u32 *)(r1 + 4)
>           3: 85 00 00 00 09 00 00 00 call 9
>           4: 18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
>           6: 63 01 00 00 00 00 00 00 *(u32 *)(r1 + 0) = r0
>           7: 18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
>           9: 63 01 00 00 00 00 00 00 *(u32 *)(r1 + 0) = r0
> 
>    0000000000000050 <LBB0_2>:
>          10: b7 00 00 00 00 00 00 00 r0 = 0
>          11: 95 00 00 00 00 00 00 00 exit
> 
> A bisect points me to this commit in LLVM as the first bad commit:
> 
>    commit 54d9f743c8b0f501288119123cf1828bf7ade69c
>    Author: Yonghong Song <yhs@fb.com>
>    Date:   Wed Sep 2 22:56:41 2020 -0700
> 
>        BPF: move AbstractMemberAccess and PreserveDIType passes to
> EP_EarlyAsPossible
> 
>        Move abstractMemberAccess and PreserveDIType passes as early as
>        possible, right after clang code generation.
> 
>    [...]
> 
>        Differential Revision: https://reviews.llvm.org/D87153
> 
> YiFei Zhu
> 
