Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B50445FE3
	for <lists+bpf@lfdr.de>; Fri,  5 Nov 2021 07:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhKEG54 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Nov 2021 02:57:56 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44052 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232424AbhKEG5z (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 5 Nov 2021 02:57:55 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A50Ug3D021710;
        Thu, 4 Nov 2021 23:55:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=qhKbmhznf4EduiqzO/ffawLszRW9/zVmKQLYrpWUMls=;
 b=O8Q9kLdIvHxWQAxrY4qJvuUbM1eqb84cegj7+F4A8FhUEBTh+egifSMeKmIkP17+RbA9
 GKbOKONCPlMz3BmuJhh9Es+fjpviYjKQB9Cb2mAlUA4SfvnHk4I0MSadphTxx0HMS2Kg
 8d1Ag7BVzyvu/3+eDAh0C1GxE0YJoLWv+WY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c4t4n1smv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 04 Nov 2021 23:55:03 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 4 Nov 2021 23:55:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbGU4q+ZuIUPpJJkQN8m8hYxHBu6caOGt2xDHtdnjywu84+O8VL0FJzEd9kdcI0naD5PQJwv/9DORwTSEVmGVk6DVN0LqjH7cZ2m5YtsOyWbgpDGQJ9JezVeOXmaIMtiDtwbmYk7HVt6v8IPuBQYUTlNNybSBoCO/Ziysofen2AM+cEApBJyeS4xq/8USmMmlQoJkJ4/ojTEMqgvUWUDQ3Nd5h2vp0bGlfQ8v4qXc3LEfuXavPnXAu0zeQJ3mg1XZEAFhPlqpnpAUwEQL6F/CaXa0FpQI5aNO87xKP+7QhOrjcQ0m4nLmVVnq9wT3KUKDSXQIRk7CekSWpQYcW8zjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhKbmhznf4EduiqzO/ffawLszRW9/zVmKQLYrpWUMls=;
 b=avj1TQZTkzaHRmhrcwyRw1/+kYxiPhoQ3rRoDZR566QOL0btwGiWdhZvxsqj01DCE4lcwB+dhrn5Oq+jCQGT17bkqJTcXyOVUbbH1zY2hJrm5NwY+XtO39QJAbZ2eeK5uUCFpG7lz3jR21wJiKYrhHccqMFKCBznwjHJ0ibjHg8dh4Li0co0AUGmhkiHSzBrHvg934X7PTqnzt3kNJXg+IgHLZSs+vmXxJRZgEMPXW5ZDDeZcTSKJNMgm9dsB2Blfvs2oe/TpctFU9/IHmNYM2KOkO/1w4QX6r54Pe+LJ/N/hNv3d/LnLwOwL1P9u6ukzQv1Dlhe+BNZeQCwNRpADw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by DM5PR15MB1515.namprd15.prod.outlook.com (2603:10b6:3:cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Fri, 5 Nov
 2021 06:55:00 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::755e:51ae:f6c:3953]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::755e:51ae:f6c:3953%5]) with mapi id 15.20.4669.013; Fri, 5 Nov 2021
 06:55:00 +0000
Message-ID: <c2c0c3b3-e6ab-f521-1553-51b3340d2837@fb.com>
Date:   Fri, 5 Nov 2021 02:54:58 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v2 bpf-next 08/12] selftests/bpf: fix non-strict SEC()
 program sections
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, Hengqi Chen <hengqi.chen@gmail.com>
References: <20211103220845.2676888-1-andrii@kernel.org>
 <20211103220845.2676888-9-andrii@kernel.org>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20211103220845.2676888-9-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0013.namprd20.prod.outlook.com
 (2603:10b6:208:e8::26) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c0a8:11c1::102f] (2620:10d:c091:480::1:7c65) by MN2PR20CA0013.namprd20.prod.outlook.com (2603:10b6:208:e8::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Fri, 5 Nov 2021 06:55:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9429c391-4ee4-49a3-326d-08d9a0292fc5
X-MS-TrafficTypeDiagnostic: DM5PR15MB1515:
X-Microsoft-Antispam-PRVS: <DM5PR15MB15153F8494A6C2333ECF19B5A08E9@DM5PR15MB1515.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:446;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 07JR6MVQvjcZG6IheZTLSyS//YXKgCWtLHr4ZTkeEIkaIIpZnQZE5J2WH2kH0x+BjRHuTMaUXUhxjb8MsK8ihvRNQqurOrWyDILacX0aP0iqiAlOknB3AA/W1srhRKFxNV3Xbaa4+x6ShX60A213fdiHoQeROXQRtxU4+pnRYs99cZgIJnkkigzgWAF7QyTldO3LDLUUrraWvhQ+Q37a5LxVcm2g013MBLFnmYmQyF+vKoiUZZGbaS3fv7x8ZTt54c8067xkFpvzm+x3qoEjDw0Hy1+WLX0wu3yIms68DUJOMtJL/BZVWMr8ldRkSMaiCts29oWll05vpf4ZoiDOmdXTGTIHz56STTSkiOdLo9OGy+USVuSs71QL9lEfrdxWnbjNjXXOWGxVEnwqmnIR/bn4sT2tUIjNmfrPPhiDYD2lP+DttdSfbUSfKBi8G1x1tvjMdsXPJsPjNhN133jtMtHK8ZjDIUholY5oKe4csFj/HEWuyJ/UJSVjJuLldbQ2kcLe7lBfxYTbV5YxzutTRrEr80yottO7jDrB28/n6gOO6mu4INwqd9uK9avxF7JP03RTHINLCETYZKzUGTnI664o01pdQRfxgXGrNZJJ0mVaec4DZhMxjM9FWjKX6TQZXENY1SzQl6Gw4j1KU2DrrDW1/C6MsV7eEhbMSPDWL139KHtnPJ2jMugbkDBIzdE4eTEgGjufvXhJ1OFtxMqDn5R7xqBATaQEVLQixotlSVc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(8936002)(53546011)(2906002)(31696002)(508600001)(86362001)(83380400001)(6486002)(4326008)(36756003)(8676002)(186003)(316002)(66946007)(5660300002)(31686004)(38100700002)(66476007)(66556008)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3g0VUpIQVMrcEJhUHRlTU4xcGFLd1NGdTF6VzdCN0hwTXI0cExVa3lBSXFJ?=
 =?utf-8?B?MWQwdXgzYjJSWTVXZmJqZ2Q4VHl2MThjc1B6SUZnZFVnM1FUNzNBWUw3VGVT?=
 =?utf-8?B?OVZCeEM0RDlYcFdseHAyM2hiOHQyTFZod1dPalZzcytXa2szemxBQUltRm1M?=
 =?utf-8?B?Q1dHNzJhM2Y5WURLNTFRQk9JYkdTa2pMWm82ZG05ZnFNYWRjNFZOd3BnZGhp?=
 =?utf-8?B?MXc4TkFUbDI1MW1OTWRoZXp6akNJT3A0NUJhTG1qZ2hZaEdzbjNHMzJ2S3J6?=
 =?utf-8?B?Zm5KM0FzVGVQTm1Fd3RCRkIwK1NCUkZ3cWhKbDRUbTNJY28rSTgzZ1ZwVnlt?=
 =?utf-8?B?SzBmMHN6dWdDS1RJSVBHOGo1UTVtZWw2U3JVQ2lXWGduQ2ttUEI1SmZNQUNp?=
 =?utf-8?B?am12dVFzajNYOGtBbFM5VklNNFVPbmNzdDlueE5tVlFrTTdFOVlwNEhGbk02?=
 =?utf-8?B?eGsrcy83YW45VVhRQTc2OURWMjQ3QkkxWEQ1SVVYeXI2SklVOGU0TEt1ejNE?=
 =?utf-8?B?ZWt6dEVvbE5yOEk1d0ZVUlI2TEdTQUVDS3FkSE8rSHlGc1Q1M09rZENGTFRt?=
 =?utf-8?B?R21QMmZGRXk3VUY0WnJBZUJ1MnRBdzE4cjhBM3dhRTM2ZU1kSEk2b05mbDdP?=
 =?utf-8?B?dk80MURVL0pxNzJFanNrd0tVVmhOTGpvbWN3czhhTXB6Mlowc0d1cTRVSE1y?=
 =?utf-8?B?MmVMNkNzdzkxSDJ1anEvc0U4Q1kvWEl1eVk3VlpjWlNjdU1WRDFqaFdTaFVu?=
 =?utf-8?B?N0hYcVAyZjJSTllmeXljR0k5aEJjdWNETkIzaDZyTEVvcG9ZQVBvUnFYTEg5?=
 =?utf-8?B?RmxjQTZ4V0tTVjZOZnEzYjlRS3hEUkVtdnNBQ0tMUGp0eVgvYzNCZ3hOeEF2?=
 =?utf-8?B?ei9SRXQrSUk1bStvRnVneGlYSWFRekVOb0svM1g0SzZUMkdyRzN1bFJjMERO?=
 =?utf-8?B?T3BJbERZbmdzbVd0Mkh1RVB4SVJpMjBkemhBV201QWlvQzJ4Mnd1ekpsMWxt?=
 =?utf-8?B?bWZyOER4akNSK21EV3NCR0piVVM0ZU9zME5NempTazNxb3pya01mZUR4OU1a?=
 =?utf-8?B?QmlOYlF5VWlRNExUM0dJLzNzN3o3Q3NBOFhsTVIwMlc4eUw2Q2tLUnNWWHcw?=
 =?utf-8?B?cG10akFhcGhRMVppQVBxWXRTMHYrdENSUUU0bzh3VDd3dUdVNWVRYVRoLy9z?=
 =?utf-8?B?RWJBb2lCMTRWWkptSjZyRFh6OGhwdzhFdlpmNkdNYklaYVN3V0pPb0FnekU0?=
 =?utf-8?B?VW9HZlVOZTllOC9yNjQzNU9RTVlpa01VNThQTlpNNHFYUFVqbGZUUlc5Sm1z?=
 =?utf-8?B?OHVXOUJYMkxVVFZKSHRwYlNUMkc2ZHRmY0ZCTlBQcjJCaHVUZERIOTJDeldW?=
 =?utf-8?B?ZEt5akpHQXpJWStyKzJwV1FIVlp5aVczYmE2M3I0Q1NiaHIzNStMV3V0d2VP?=
 =?utf-8?B?QWdMaEpLME1abVdKeHhuTytmYkw0UkpBUWgyZGkzS2p5bUFuNFZGZVQ4UEFa?=
 =?utf-8?B?RTRDSjhROWpvc3FtYThvbU15Mms0M1ZtNHNST3d1YlpmTjVYak5ZTVdWejA0?=
 =?utf-8?B?eHNMVURBNmdLckloZVg0anV6dUxpQU5VVmphS0ltYlpld1ZvbG9iSGkxckdj?=
 =?utf-8?B?Mzh4L2ZyVXFibVpua1VzOWV6ZzdlM0xuNlVRakNad2VqUXg3NVFBcGovYkFx?=
 =?utf-8?B?ZVZMUHdnSkp1REhxZ0djamFrSWZZNlVHdnp1eUJoTzhyOG1PZkxUR0gvOFlz?=
 =?utf-8?B?TXhXVHhmd2tjNlEzdFJwNnV1K09abW02NUZUMnlRV3REOEptekNrakwrYXRX?=
 =?utf-8?B?WldxUkNLa0lRYlNhY3lMOThSeTh2M2I2QnVHTGlTQjVrN05xakRybGJxaDNm?=
 =?utf-8?B?VytYSGx3Z1ZGNEkybUF0b1Bma1g2L3hhUVJrUGFGblE1ZTFLZXNXTlVIbS9J?=
 =?utf-8?B?dm5PQzhiNVVuUWNNWXVKek5BdEJsYTV0dDZhc2N3WVIvMHVJbUN3RzhmMm90?=
 =?utf-8?B?RFArR2hlRm5jY0JPZDF3dWdzamtXN0x4K29vS3VuSDF2VkJ0VDVEVlJrSkc1?=
 =?utf-8?B?Y1Y3akgrVCsvTjMwczQ0VFIwejhyK3RrbndMZWRJeXVXdC9URUtaWHpwdVRC?=
 =?utf-8?B?ckN1aWViU2grSnJaUGxnWjgzK2hyQ2VUYVIyOVA4M2JyNnpsRmoybUcxc1lu?=
 =?utf-8?Q?B+ZxlwhgHEaweL9iit94y+2NysE0Dg85LJ2pRZeQpyE6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9429c391-4ee4-49a3-326d-08d9a0292fc5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 06:55:00.6894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hg0thWXKCha+QL0lJBqhfYnlf4vdgzPQTFGx4qvZcnBczPHy4QiNc7Ok0aT5zr1pphEyEsZj2/o88CU7gjKaHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1515
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: hmVdUR7lvlUDkWftqH7NHzmVKxtplcr1
X-Proofpoint-ORIG-GUID: hmVdUR7lvlUDkWftqH7NHzmVKxtplcr1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-05_01,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111050037
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/3/21 6:08 PM, Andrii Nakryiko wrote:   
> Fix few more SEC() definitions that were previously missed.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>

>  tools/testing/selftests/bpf/progs/test_l4lb.c            | 2 +-
>  tools/testing/selftests/bpf/progs/test_l4lb_noinline.c   | 2 +-
>  tools/testing/selftests/bpf/progs/test_map_lock.c        | 2 +-
>  tools/testing/selftests/bpf/progs/test_queue_stack_map.h | 2 +-
>  tools/testing/selftests/bpf/progs/test_skb_ctx.c         | 2 +-
>  tools/testing/selftests/bpf/progs/test_spin_lock.c       | 2 +-
>  tools/testing/selftests/bpf/progs/test_tcp_estats.c      | 2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)

[...]
