Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76057380002
	for <lists+bpf@lfdr.de>; Fri, 14 May 2021 00:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbhEMWYR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 May 2021 18:24:17 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:16478 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232021AbhEMWYQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 13 May 2021 18:24:16 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14DMIg1p028798;
        Thu, 13 May 2021 15:22:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=wIu7SiWhf7zt2i89fnkwLwnGbOC+KFqnOqgEp5ohrWE=;
 b=hNWjwaWWNmI6AXkXa2Y1W1Xz5GtANxSwteuft6H92jWHX1VfcJ8oLdIlZ9NplePRpSSu
 Pi3v7eW5Cj7ZE2/kyCF7DPowfr0gS7TooWHUr7XuKb/UQzIRN4yKoyLTjMDwde21wu5i
 oKfSzauD+xJDrER7SOpZrvg9V47wULOqAKc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38gpnkpygs-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 13 May 2021 15:22:50 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 13 May 2021 15:22:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eh5Y1gNWz0Mz6RA8kknFMErBvd2+Eq6VF+1fJtIRLweLXsvF+PJjMd9FujKNsZ5zXbv319ttgg5iC8W5W493IGf8pMRJT9AlN9mUHyFxoNissz+BS/kqYsdlrmqN7da2W0X8lRg10gMbrMoSGwoarKMjr/8JshXJeJyXC3TFQ5LG9AosAvCC1SGYKI2NVwgNBk3hroBuixE3VGc22urmOPTkNKp/vGeyiiGWB8OmefvGPedxeUNOSC7/G3a/7vww/Ld3HY3dDikUCc/gBXT64PiqYm6zaG/Sulwh5TMYJuFENJszOVm+LiJlOv5MskzMXEvJduuXHCYg/ryc3zBVQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIu7SiWhf7zt2i89fnkwLwnGbOC+KFqnOqgEp5ohrWE=;
 b=QsAXq1Q9/ZQIUFJf3XrErY3udF6bzF2u85pGMTR9PG8+BipCvzn+u/tawWGRQz269Xlz8ah6YDUa3BQCdvx6pPYIGaok8AewIeMit6tT8vAALldqf4w2Lp1qnEKftQWqCdclZ3c5ETeF4huHn94xLFqi1t3jg76pQZnzUvGNoVC1X5DesNkufT/WpBE22s46WHuTR443O9p67xxrxWqPZAiaj+MqFNkLTyIYSP/s8gjp2VLpTP4A1LazM3Fsp+Ms0q/WNUGPPzYCr/yIu4jx677g7AT0ZC21tg0bnYd0adBzX/4MpbQWvlDR0VZvAg7l0Fn5UWBYUJWJKigsvgoMdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BN8PR15MB3282.namprd15.prod.outlook.com (2603:10b6:408:a8::32)
 by BN6PR15MB1922.namprd15.prod.outlook.com (2603:10b6:405:4f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Thu, 13 May
 2021 22:22:46 +0000
Received: from BN8PR15MB3282.namprd15.prod.outlook.com
 ([fe80::d427:8d86:1023:b6b5]) by BN8PR15MB3282.namprd15.prod.outlook.com
 ([fe80::d427:8d86:1023:b6b5%6]) with mapi id 15.20.4108.032; Thu, 13 May 2021
 22:22:46 +0000
Subject: Re: [PATCH v5 bpf-next 16/21] libbpf: Introduce
 bpf_map__initial_value().
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20210512213256.31203-1-alexei.starovoitov@gmail.com>
 <20210512213256.31203-17-alexei.starovoitov@gmail.com>
 <CAEf4Bzb=L0LH0OfEqe+uMq0rd8=zaHzPdWV5-Qf5_CQFkKT8pw@mail.gmail.com>
From:   Alexei Starovoitov <ast@fb.com>
Message-ID: <e71cd6e3-3f2c-dc19-344a-28b8e5d68a9b@fb.com>
Date:   Thu, 13 May 2021 15:22:39 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
In-Reply-To: <CAEf4Bzb=L0LH0OfEqe+uMq0rd8=zaHzPdWV5-Qf5_CQFkKT8pw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:f822]
X-ClientProxiedBy: MWHPR2001CA0006.namprd20.prod.outlook.com
 (2603:10b6:301:15::16) To BN8PR15MB3282.namprd15.prod.outlook.com
 (2603:10b6:408:a8::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::1acd] (2620:10d:c090:400::5:f822) by MWHPR2001CA0006.namprd20.prod.outlook.com (2603:10b6:301:15::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.50 via Frontend Transport; Thu, 13 May 2021 22:22:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af7dc2fa-050a-45ef-4a3f-08d9165da227
X-MS-TrafficTypeDiagnostic: BN6PR15MB1922:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR15MB19225DCE5EA7F47EE49C9A65D7519@BN6PR15MB1922.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VIdW2W3Ue5K9q5Rh5pVIBW9Icou5BCSjw6NvAdIjRQG621rXGlLcfFc7iclNCzLZPSpFZt8E3KoL4Vy4TLD0XFTZrdPwNZ46bIMIQjIh2Gwn7aQISIv5AIbdj87qvz4mJadCG52DTmzvejfBp/IdGO6SV4H8jOxaCapSBI8pATxfyvSl3LVNjs8VgF+3i+nLxM+X8uT2RKAjSuVVqj9fF+uMqEPmsC3bnNTYe2vXz0Fj0ES/EW7yqKKVF6tMKVRfSeHtxZwKL48u6J9WprpsZgoOwbUmIuVMcXitAsmGRfEeH4dlD+HokKk8BojIxmm6YyvCr021NK7HEOjWVp3CuEXcauuj8N08+O/L1RtjAc79nmKUcdjD1zA+6icP1vNqONZ9tdIIrC+/PGG1EkhoKIjnfpGd8xfp6BidHmU77j7xhsiaAIQS34dmvHqIA4k5GmsGFNQkQUdVsJ9Lw4SxoUyom6AYiKda/e1NAKkGeDJqj2deUIO+lO4rfq9M6mmkvDrQzeH81o3GkBVHoYhUXn3JjXVSjDT9MGYMbCxmuS4vEJjJ5XSZT7PiTqHvkQjn/AYPeyfsefhFaKsv1mXBGvYB/NLIVjTOprRKbiB+xuu0PCOFFmpFvBIxEsYwYGy3hFJaIWU7cXWTD4fBVseWiMkL4ksgiHV4t5SQN9c3WeU6OKvgSMZpD1TtCXCcy73jyA/0xmDM1F3XeeNmQrRZlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB3282.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(66556008)(86362001)(36756003)(478600001)(2616005)(52116002)(66476007)(66946007)(2906002)(6666004)(53546011)(5660300002)(31686004)(4326008)(38100700002)(16526019)(186003)(54906003)(316002)(110136005)(6486002)(8676002)(31696002)(8936002)(101420200003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VUdoNGEyUGdpbklIWWhyVVdDU3pueEtLYmJ2cHoyNWNwbFJBeEpjRm9kem4y?=
 =?utf-8?B?dDZjNjFkSzNpc2hlT2dEVEZ5N2Q0VU9PV1cwMjRUcCttdE40MTVVUTlMZktP?=
 =?utf-8?B?NXNDYnZYbnRlams2c0ZKRE0wK0xzQWlKelBhR29CRGJtQlREem5aQWFZYmVB?=
 =?utf-8?B?Zm5DQUl3Y0liMjhWaU5GVGRJdnVQS01vRG14d0ZreGRqNmhJd2RCWlFXQmY2?=
 =?utf-8?B?L0JEcHgrYUdacVpBeHVuRVExbnBNU3ZLdCt3cy9SelRBRHpMYVRtVnNNY0R0?=
 =?utf-8?B?bEQrZ2ZxbHExQkpHZ1IrS2xCTTFUUzRJT2ZmcHp4TDNHK2FtQU5mdmsyRlRT?=
 =?utf-8?B?S0hsRllrNnFSZjNCY3BGVkJ4VEJPOXQvb2pXbjhXUW9mQ1FjNHMvVmlHU1Vk?=
 =?utf-8?B?dmdvUFovbjJ2UG0yaXludkR1cDUxdENSSjZsZEk3RVA4eDVIWnoyS1FNKzdB?=
 =?utf-8?B?NDBQVzVyUnZoQ0Z4QkJ5clFKcTh4aUU0M1MxU0ZjTStRT00vakRiekMzM2p2?=
 =?utf-8?B?YzI0aTVyMzZKR0gramtyc3Z1Vkh1dlRvYUd5QWxRTFJCaHFuN25QamFaMUpL?=
 =?utf-8?B?bWtDalZYVkExV2M3N0xWckpEYzVTZmVTNkNYL053enE4c2JVRjVKZkJsMk5H?=
 =?utf-8?B?L09HS1hYaGNWc04yMlM2bWhCRjZTLzYzVUFYN1pZNDgwS2F3cVFxWDBFQlFl?=
 =?utf-8?B?UHZnaUZRNHVsbGlzSkJQM05Jb0FPWkdLKzBqc3JkV3lqdXNidHh1NnZvT0xX?=
 =?utf-8?B?RDZySjZIZXVSeHMxaEp0bzR1VnRmNjQ5ZGxMakJ3cWJMVlhzYjV3VXgwVitW?=
 =?utf-8?B?bWV1M0JURnNzaDlTMDJFQ1Q0NEtHS0ZMVWpUTXZGRUFDemZyU29JZU5vYUYr?=
 =?utf-8?B?T3d3WHhoZGhUcXFqT1p5RXkwbFAzN25wQlNIbEhtcURuVlpESDZmSkhZaldS?=
 =?utf-8?B?WTFIeWR3VHM5VEt5VFdOd0kyVS84VHoyY0RrK2Vta3QrMVZRZk9COEhpUWFt?=
 =?utf-8?B?Z2haVlR5dlA2T0g3ckNRQXh1RGRFODZMVE83cS9PVE9sNy8yMHA3bHR0ZWlv?=
 =?utf-8?B?cjhKVms5c0tKalFwc201dTVpWUhJbCtuQzRYaXQrTjAyaEs3b3cwejQ5Y2FD?=
 =?utf-8?B?cDZYZ2pWaVllT3Bnak9iTDBjb2lMeUFBTmkvaW9USTZXMjd6SEFoRldKY0E5?=
 =?utf-8?B?MmdiMFE1YjJwd1dkU0xQOXRxczRwZ3cvcXVmREdPVjl1Q3hmSzRFUlJSb0hD?=
 =?utf-8?B?T2QzWHNKTFBKU3JtSXYrSEl5MTVveE5QejFVcWRwTDBCU1NMNVE0ZGpaenJ0?=
 =?utf-8?B?YklhWkNZM25zbkJCU3ZUcUt1VDNpaWVuVTZ3U204YjZmUG1vOGo1R1ZOSmRE?=
 =?utf-8?B?cnBCdlI1b0k3N2wrTURQZlVYbnFkVlZDSUIrSENyTUJNcDZpSGRER1IzVHZG?=
 =?utf-8?B?SGhwWE94aU9jSHVzWFVlMGFsQUw3SlpPUkozc0wzQThzYkxYYUxGS0xmNVZn?=
 =?utf-8?B?Z0hvQStHY21XMGdua3R2WWRxaWVRWGljLzQ4dXVUZE1jQWVLRWZ4K0hJcnMx?=
 =?utf-8?B?S1JiL0ErL01yN2phaGs3MjNmMnFXZVdSdGhjRHFiYnU4UmhyczhSRXllamhQ?=
 =?utf-8?B?V1paK1lGeWxFVGJIRmE2czJCbTZaSzQrVzZ2R3AxRkhDUFU3bXltUzdZYzNN?=
 =?utf-8?B?T2ZpcnRvT0ZqbVk3Zk5vZnhFdzI5aEZGUUhhRDg3NHgrdHQ3SGJrVDJkTTY5?=
 =?utf-8?B?cTdoMmVReHhEZjhOdkR0bWluV3BLRERWa2cxYkJOQVEwaFFMdDY3bjlUMlA1?=
 =?utf-8?B?WXVKQXNOeTRYUzkvT1lHUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: af7dc2fa-050a-45ef-4a3f-08d9165da227
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB3282.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 22:22:46.4775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cr8RAU8smO0ykCrE4U6PxGmjUEDkqgruGUOBMgZR5pXfIC3w+0PNR64OLVV/68IK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1922
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: ZJZmSqHkrS4brlwnLpAMUx1b07RWtlly
X-Proofpoint-ORIG-GUID: ZJZmSqHkrS4brlwnLpAMUx1b07RWtlly
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-13_14:2021-05-12,2021-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105130156
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/13/21 2:16 PM, Andrii Nakryiko wrote:
> On Wed, May 12, 2021 at 2:33 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> From: Alexei Starovoitov <ast@kernel.org>
>>
>> Introduce bpf_map__initial_value() to read initial contents
>> of rodata/bss maps. Note only mmaped maps qualify.
>> Just as bpf_map__set_initial_value() works only for mmaped kconfig.
> 
> This sentence is confusing. bpf_map__set_initial_value() rejects
> LIBBPF_MAP_KCONFIG, so it *doesn't* work for kconfig. But your
> implementation will return non-NULL pointer for kconfig (it will be
> all zeroes before load). So did you intend to match
> set_initial_value() semantics or not?

Good catch. I'll reword.
It was too forward looking and ended up as completely incorrect
sentence.

The idea was to make getter work for all is_internal and mmaped
maps (including kconfig), so that after __open and before __load
phase can populate them with correct values.
Initially for kconfig I was thinking to do it as part of the loader
program, but the kernel doesn't have in memory kconfig. Unzipping
and string searching didn't feel like the right task for
the loader prog/kernel, so the light skel instead will populate
it from user space during __open.
At that point we can either fail the __open if /proc/config.gz
cannot be open or it doesn't have the fields the prog is looking for
or proceed with default values in kconfig map that libbpf populated
earlier during light skel and loader prog generation.
Depending on that choice the bpf_map__initial_value() should
either return initial value for kconfig or not.
I think returning it for kconfig map doesn't hurt.
