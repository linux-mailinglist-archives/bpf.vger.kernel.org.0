Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A6440B844
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 21:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbhINTlC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 15:41:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:22120 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232322AbhINTlB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Sep 2021 15:41:01 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18EG2IMK003480;
        Tue, 14 Sep 2021 12:39:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=F4of4EAEY9B2cyGfn6I1d2sQLdM21xIggY5DfnWL2Uw=;
 b=hSRQMvvsxwTGaB2Qp75X6YUGZP9Oj0Iva9aZ1DnQDNuFIWUNisWZRiBgGY30AuTE5FXb
 n76NGQFeGTYvJkilsJyI3LNkhHeN9XzeSYA/iVoWaXlP7BNKZXQoy2343/5k01DxXud1
 APArm10GjbY/BDo1Gp4Uil8dxs9jTrfjjHc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b2kh05e1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 14 Sep 2021 12:39:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 14 Sep 2021 12:39:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUZTKQOWTBlKFQau15QDr93Md78AMGi85ObWtW2uDoB7UYrRvS2WAdWN//QeodYiOVElc1feLPwQo1oL0SQr/mPsdAOeUsy+NlrKsLTDlTSF7/pJdpRbqWv0NF2A4S11HYnVctx/r40sZwg1kT+LlQtTQ1+/uce5SDR4NyuAxqjkjaeY0t/lYI9uKSdLvaC3FuGe6CDuVdPjbOzbHly/W3NtusaNRndDxtvwsTNWrwDMY0SaG+F+b8FGpQ4ryoxF2J78yZ23KC9ct6sfPWQVDwyYsrDwVyN2iPI0+q1963g6Gmx/1XJ8Lv3OEWAp8zjczZla1NkXThPobl7RPWbMDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=F4of4EAEY9B2cyGfn6I1d2sQLdM21xIggY5DfnWL2Uw=;
 b=BqJHHLxOXQIARDDTm7Fk+f54qZ1dRCshDWcqktMxkfrBw4UitoSnTS2H7yhjYip+Jg0Rsf9SfSxb++G2bX5y6K9wQ3ceBGSZwxtLZEpd2o6b+WZsppraO4h3lB3MFruyyvUN/JejD5V9kyCKbLId01UaDrKdyDe/1hrTOsWaKWYelmw3z7zm3u/5ePidnVq/TzzMMf+3end2GCpREeWaNGkdn8Zd+94umpPrz/5//UOZolFvqItKy+jDocDAep8TlIyv79AoOA58Xm9MjDqg8YBbR4ET5MIHMRnDfvG2NS8TrIbOWZt9Zx+cxSE7gKq2sgpl8/2rrZlRK5MWA0pAaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4967.namprd15.prod.outlook.com (2603:10b6:806:1d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Tue, 14 Sep
 2021 19:39:20 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 19:39:20 +0000
Subject: Re: [PATCH bpf-next v2 09/11] selftests/bpf: test BTF_KIND_TAG for
 deduplication
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20210913155122.3722704-1-yhs@fb.com>
 <20210913155211.3728854-1-yhs@fb.com>
 <CAEf4BzZoWe33fXy0BBz9zzju3dKUeBL25230_yBp-W38VWAnNQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <0031e9f3-6b01-373e-3b0e-2efdb6bd4ea9@fb.com>
Date:   Tue, 14 Sep 2021 12:39:16 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <CAEf4BzZoWe33fXy0BBz9zzju3dKUeBL25230_yBp-W38VWAnNQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0048.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::23) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:21cf::1169] (2620:10d:c090:400::5:6de5) by SJ0PR13CA0048.namprd13.prod.outlook.com (2603:10b6:a03:2c2::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.9 via Frontend Transport; Tue, 14 Sep 2021 19:39:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b51ea10e-00ab-459b-7ae1-08d977b758ab
X-MS-TrafficTypeDiagnostic: SA1PR15MB4967:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB49676461B1A47B11D0EC77F8D3DA9@SA1PR15MB4967.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4easUSRfXs6eRbcN2HSuteV/wKJAbztQm9b2JPkJEJpGj5iyoegnp7yPV5PhPEILRvV8ECVtuSaWyIX9xu5owCaVEajFHB7TnvdZ5gQMI+fI/SCpBZeJ8gMXm/QkHtoe1ZRBogkPe/qgu4BtNYoMbwxLQXYJAMCiZ4OhKcCqXdr+90HGvOHAjEzdtCxFmq++Ib9jixTLKb53KKSVFwrcenrL1hqWpZ8PEx/ugbxkBgsMQ2OOGqJvtZ8DW6B5bOGgOSMQlEs6/up16nRiB20A9c55cU1cyIYGswBciNWchkHj+y25pkOhM45domGZu6D85JSnpTfNFtRIVmTE1ByEOcSm2VRy3BZQk7qU81ZzZZg07LaXmmKaxkaewhdW2pubj6w/fKFo+IpKus5mqN+DLiKJ2le7s0/orFk7hqr4y15qmizJbjGR4daV88qjFaeLZZE3HOb/JMy0UnoNq9kWw4R9BTjECDwh3kW6tMkWfkaHwuMVM+epX74a4EApRqXoizq+Qmeky2ZMIibRXpZuUM6+3doKVtxR6WoGnUdUl6L0OjNB6c+wA0M07mSSRF/L3sRlhAa6MU5twoo2xswePgGewyhYMKHQVJPBVfrCpJpHUx1AJMBKuV/GI2LpUoFS0WR2SeFVj7nFOgjvFuqrMZ81D+Hj7e7v/c4jjSJPKRUUGOK6v2KXdxMzkhSCXNQFLwXL26PSGLMg/CHk9+JEpq3UJaI0eDHoKSiM/53y/os=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(31696002)(6666004)(5660300002)(478600001)(6486002)(2616005)(86362001)(66946007)(6916009)(2906002)(38100700002)(4326008)(53546011)(186003)(54906003)(66556008)(66476007)(52116002)(8936002)(83380400001)(8676002)(316002)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3VBNGNPUkdqNUVGNzZSb1p1UXBhbWxHVWlta2M4ajBJbFFpWmVldCt6Mmc5?=
 =?utf-8?B?RUJ4cXZsRXdwaDAycHRjL1NxMnE0VVlmVnFlaHlaUzV4V0VFa1NUK1RjbEhv?=
 =?utf-8?B?b3E0QTVLK213cExIM1F2K2w2cWk5anlwY3hjVmhjTTFNUk1QL000WVkyY3d2?=
 =?utf-8?B?TjZMd0w0ekFzSUxWalJQdnRVS3k4ZXpJU1RLbkw4WmN6UzRJcnlHQzcxQUla?=
 =?utf-8?B?dCtSYUNuT2c3UHNvWHZnQVBpMnlHemJvZzVSa01QYlVmVENkS1VtaENpaVh1?=
 =?utf-8?B?Z0dkdGlrZmQxSGhXejQ5RksvZGhkQ2N5cVozc3UrQk5PZVI1YnFSdVVTZWNF?=
 =?utf-8?B?STVNMWdkN3RKdmNuMTYzWVBkMzJvcjhKYk9pcmJUZWFXZDk4aXQzUzE0SEEx?=
 =?utf-8?B?cEp0NXkweU56U3VBZlQwOHpFWkVJN21ELzNoT3dqL2hidlVJM1NJbmpreks4?=
 =?utf-8?B?NFN6TzdFYWpHVzFWVkx3MmMwSzVRUXp1NDNDSTJjZ1U2ZVVDY1lmSzhPdDk2?=
 =?utf-8?B?Vjg5Q2xHNUFQdXNpTjgxa3VhTmJqT1JHNnNSdU9YeC9OdVR6NjFraVcxcCtM?=
 =?utf-8?B?Q2N0Z2h3K2dsbWpGSWc3VWhDNmJmSUpHbVI5UEFWQVdLdERVZ3ppV2xoREVK?=
 =?utf-8?B?RE1CdFJHWklqZnNRalNYRjFGSE1vZ1d0NE8wZW1vYjZzNlVSb2RMNXJPNkw2?=
 =?utf-8?B?aUFCaUpabFhGWUxlWUdscnVWQ1lTcFRPZ3Y0bldqdDZyVCt5MFZLcGxjNlB4?=
 =?utf-8?B?dk5YZEFEZUdTek5YMVo4Q2F6eVdLYzBZQldFamNqT0Y3UkhMM2lQbzJpajVm?=
 =?utf-8?B?TG5zdGV4TE40UzFNNlI3bGxVOHEwaHdxQUtoODRIUGxBS3NrWTNYL2wyYkJP?=
 =?utf-8?B?aHg5V1dNY05TanEwa2YyMWlmYWFPYkJjZGI4aXJkOGw4UDdoUVlTNjd0UVJL?=
 =?utf-8?B?TjFMaUI5bjVWMDZvUi9TTHZBTUdaNi9NbWE2eHpidFQwWHoveUpqUDA5bWZu?=
 =?utf-8?B?ZTNaSkdSZ1h1QXFwMUNMMUxPRjB1c2UrL3BudzJNejh1TXhLcHhEWStNRncr?=
 =?utf-8?B?eTJLT0o1clpwVElvdjVCMkRBb2V2WnJ1T2RJK1dtY2xmSjZiR0Mvc0ttalNx?=
 =?utf-8?B?eDFHTVBCb2M5cmVYSVUrYllUV2xReWZ3cGJ0NzF5NkRnSG9ab2QrOW1HVDB2?=
 =?utf-8?B?eXJxSmpYS01EMXJJWUZDRlVsZHd6SFlMakoyb3llYUJwMVoxbnltaTBDNzBs?=
 =?utf-8?B?cXVZZDdXd3VaUmQ3cTRmUVZTRDZObThJTmVDWFQ0bEtDWWJKM0doS0x5OUJK?=
 =?utf-8?B?dFUzWFpkQ2xLOVRDQ2ZQSzhEWjROQzVkVktLbTJOOEdJbEc5b25RR3NIK00v?=
 =?utf-8?B?SnkzUm1qUTI0RjlEdTQ2SGMxMitNYjV1czl6aFM3UGlxdFRJa1lSdkIyejg3?=
 =?utf-8?B?dWppTjJZMEJkSWl5OTAwNlNmWVFKN3h6ZWI2RW1yVWcvSm1Fd3B6cFVjRXM3?=
 =?utf-8?B?cnZJMWVIbmM0NlA3RGxEYlA1YnhpZ2ZMUmppUkhkZTlqRWdxdmNZOWRLeDJr?=
 =?utf-8?B?UmdvaHFHeG9LeFErTU82VzdBZnlDejhvbndabmhBc1FkV2VIM1o3bTZJb0R5?=
 =?utf-8?B?U1lETE1KOVNDcHk2bDRNRzFVWmRYMlZMWDFiK0liM2IzRWxMLzNUcGxhVWNJ?=
 =?utf-8?B?WUY4dnNUVFBjem45T1RKSlFadzhIOHY0a3IvT2RjTFpUUjNEZFQzUkhwL3pF?=
 =?utf-8?B?aVY4akVLcURIWDRTbklzN1ZjTHVycTQ3bjFGWmxHUzdpQm0zTXZzSHl6bC8v?=
 =?utf-8?B?cTVPamk4M1hReWY3QVRWdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b51ea10e-00ab-459b-7ae1-08d977b758ab
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 19:39:20.1518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUAxGdol7cJlYpoJ+Hu1YIsm/5S6ShemO0hNV//FGVatoOhGgryG7gnO6yo5vqTm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4967
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: uyWVAuiGHKkChqFqpXc-wZnMK1ZyjnMg
X-Proofpoint-GUID: uyWVAuiGHKkChqFqpXc-wZnMK1ZyjnMg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-14_08,2021-09-14_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109030001 definitions=main-2109140114
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/13/21 10:38 PM, Andrii Nakryiko wrote:
> On Mon, Sep 13, 2021 at 8:52 AM Yonghong Song <yhs@fb.com> wrote:
>>
>> Add unit tests for BTF_KIND_TAG deduplication for
>>    - struct and struct member
>>    - variable
>>    - func and func argument
>>
> 
> Can you please also add tests where you have duplicated struct,
> variable, and func (three different tests), and each copy has two

currently, variable won't be deduplicated so I will skip variable
and add tests for func/argument and struct/member.

> tags: one with common value (e.g., common_val) and one with unique
> value (uniq_val1 and uniq_val2, one for each copy of a
> struct/var/func). End result should be a single struct/var/func with
> three different tags pointing to it (e.g., common_val, uniq_val1,
> uniq_val2). I.e., those tags are "inherited" by the deduplicated
> entity and only a unique set of them is left.
> 
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/testing/selftests/bpf/prog_tests/btf.c | 91 ++++++++++++++++----
>>   1 file changed, 74 insertions(+), 17 deletions(-)
>>
> 
> [...]
> 
