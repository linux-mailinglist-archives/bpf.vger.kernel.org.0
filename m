Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F146494652
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 05:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358415AbiATEKw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 23:10:52 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37170 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229787AbiATEKv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 19 Jan 2022 23:10:51 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20K0eHbH012419;
        Wed, 19 Jan 2022 20:10:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ItvGfLa/CELgJsc/qkAlNqaROkK67so6W6B8EYVyo+o=;
 b=n0Z33/qBk3KAu9RvkmQ4k8z+YgCjPhfUPQqnqSiz7mHqaD/rSHSyYn98fm9s5QWOcMWB
 7r8m2x+SeCkGbDa5y9UOVGBeufJckC/UF0jYa6IQ6Y126HG1zphz8xMcFO+/bnLnUIgq
 Dz+qlvKKBzSRMIMXhJ91cFblprT67CIJNJ0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dpafj7vu9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 19 Jan 2022 20:10:34 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 19 Jan 2022 20:10:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTF1VToypWrY4aToQJTc6Ohv/1IIni+wxUa9qlbPgPgw6DqDWVG/3keTaX34t57S20i8/B2uD18spiFhBLaRr+XvR2fU4f5IdI+jUgIovDZcP4Mi3mbVNx/OX52gh/JLaT0LNf2QlErYQVOYP4DFShGPor51bOBuOg4M8/i7SqIScrd0Z1NJ9mmStuIgiclZxd2JmlHXPrFr8CC5SkYqh+3pfswjne6BObHZ6fjGm+Dt3+jk6ermHdwkeI0BZRixgIpTnlP8kAygar94rZonYVV9KsyxI9KJqCGKzdlrlEdpHEQ/DUz+sYKnYnvAvTS/Dg3OMabwz/AogCvoN7P3bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItvGfLa/CELgJsc/qkAlNqaROkK67so6W6B8EYVyo+o=;
 b=SEC3OgzBsGtN4TRBZhukUGSx9Sap5c0EKoOMrI5OwjgHHerVEA3Oirhg8HVaUBlEGtpht25WvBZTftx1HW+ZItXoO2sZNQ2/G8jHxsNuHjk3yZr3vDBPw4neUFowkRS1rNXaO+eYX5shJBMAxINI+977vsD81ljmWD9dvrzkPHKY2kKcf7JVJ2i5e0NMKB2pOcC3I5uj7F89RdlKw/yN1nKOLbymINQsUcGY0mbSzWPyKjWbFoXjEuL+H81BXcpkc5ALUq2BgaW2uZoRoi8qXoazR9aisRHo4GXjTKQtXN6Ao3p45/oHKZVqvPdF3TwVHxXbM9Fo+2xhexe1NFI7Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2253.namprd15.prod.outlook.com (2603:10b6:805:20::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Thu, 20 Jan
 2022 04:10:31 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ede3:677f:b85c:ac29]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ede3:677f:b85c:ac29%5]) with mapi id 15.20.4909.008; Thu, 20 Jan 2022
 04:10:31 +0000
Message-ID: <4fe03fc1-fc1a-9853-bc10-dacb8cc60fe1@fb.com>
Date:   Wed, 19 Jan 2022 20:10:27 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH bpf-next v2 2/5] bpf: reject program if a __user tagged
 memory accessed in kernel way
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Kernel Team <kernel-team@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <20220112201449.1620763-1-yhs@fb.com>
 <20220112201500.1623985-1-yhs@fb.com>
 <CAADnVQKY-uvYic=4iXmHMdyiYOSzT1Nx=Zv_70pL+8ypNWQjYQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAADnVQKY-uvYic=4iXmHMdyiYOSzT1Nx=Zv_70pL+8ypNWQjYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO1PR15CA0090.namprd15.prod.outlook.com
 (2603:10b6:101:20::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa0d0ff9-bdae-4fa5-cfa3-08d9dbcacc7c
X-MS-TrafficTypeDiagnostic: SN6PR15MB2253:EE_
X-Microsoft-Antispam-PRVS: <SN6PR15MB2253A7D93108D7CBE2AEEB39D35A9@SN6PR15MB2253.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VzSeKLich1djVaE1wuYHfSMcGROM0HcgHDYcELG8qR/DeLRblsZXxtoNVNJmSGsKF6/byd1vc6PZ7bg0Dri7raA4JGxZ5vKyBRf4B48IjcqDpmW8Dn00xH9ULnbA2V+oumH5URd9i4yzIYQ8TR3td+nbPcDJ1vTVn3RZSm4AlQFqCZzanBUScMnbfRdJPKHsRKVxtHsAv2oimcUxgmMQLxf/vpu32ibCRaxGFeVRD8+oA2ccuZhXMTZryTqL4AtuZUC8451aUuM4K6QFYevsJDjN0xh1xCY3Lt/AGYnsA6uHsm8pF7+EkcGbLdt9DExhCTUa0LiMogUsP2oCQzwIz3RTGlc/hImv2hwXMTpdNjDT21lf3PgequijBQh+owxsI7ezORseBx2GR02MsHO5miH+TbeRfi2bDVQhoMI6y5+MaOa1LYNPtOgTcUAKqYcilpSVIZUhEktu71q4J1ClCPb/Jsr9RqIkdqRY/QFQPv5sd3h6YyfEEqcc8UkrsX5jnZv6sJ7Oc7lmFxWvIFlv52/q9IOIsTc8jErAmALQjMBpQoAXmVh6NQZ0EBn0R4J18rdGphqQhI/nfhDNOJynwGrf5CxlUyo55KtxgzKyfOxMyOIF4P4BKPEJBpgry4uCv+TPYKzBmQOnVkZliXB2V/DHpU2AnGyHe3eUiuyTouUTiiG4xd3f7YSmNXSvhaL4oDqhdUqlDjaS3MjXw3vcBN8ax6+kBZjAYk5nxUbZeKoOmMrT3cBKXDJ8FO07FrH+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(66946007)(4326008)(36756003)(52116002)(31686004)(66556008)(66476007)(83380400001)(6506007)(6486002)(53546011)(508600001)(6512007)(86362001)(186003)(54906003)(316002)(5660300002)(6916009)(6666004)(2906002)(8936002)(2616005)(8676002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUxEMElLd2Q0SEMzTkdhcDBYWVdBMDdaZEdwVXVvTGc1U2ZmblZ3WjNmNzV0?=
 =?utf-8?B?TjdTV1FoWW4xdG5HZlRlT05qYVQwdG9ORklBT0J4SzRvQWt0Mk1tMnpOczJr?=
 =?utf-8?B?VWltajYvYnZuYTFndU1sbXhzQkFZazBLbXhuSXZ6dmJEVnRKY0NFRXhqeCs2?=
 =?utf-8?B?bEhiMHRURkwwOVlPWTRhZ3FUTUtWcmJ1SWhFclpFVXBSWU1JL2RIcy9PTCs2?=
 =?utf-8?B?aTZidXJHNDZuNkJwcGJadDRhWDZKTDFRZDMxTEVNencyRjgwcGlQbnN0eXVZ?=
 =?utf-8?B?NVlFZ2NkcXEvK1QzUUhBQk9QOERscFg0dTdBYlB6S2Yvb0R3cTBVK0EvZkM0?=
 =?utf-8?B?dEpQVUVPVms4ZmsrTUJMTEcvTDZJK0NxUTl1UWNabHhyeGlhd002by9MYWY1?=
 =?utf-8?B?QmtqZjRSUXpZRkRsSEx5NVloS01yRVErM0laa1I2eHR0dFBzb0FBRmxTWmFH?=
 =?utf-8?B?eVp4bXQxOXZpQVJqL05BSThOSDhySFA2UG5lNnE0ZHNJZUtSYm1DOGVrR1Br?=
 =?utf-8?B?V0ozd0Fxd1UwbTB1SE5uaG5YQk05dllZREdpUDYzVWp3bFJ1ZDJhMFpMaUp3?=
 =?utf-8?B?ZTFtZktyZ2lXb0NDNExvZFhOZGl1VnJNWWl6Z0h0YkNYa09FRCt4U0dLc0JK?=
 =?utf-8?B?ZGx4RWhyckVERlFIQUw2eFNYTDNwVUdGN1ZFeGVzdjNOc04rb0g4eFpjNys1?=
 =?utf-8?B?VlpMVTZXaXRyRDZRQWw4SVM1ZDFkZWhqSHU1UUhJbnQyT2g1cm9PYU1IMXVU?=
 =?utf-8?B?V0N4eWxHN21ZU2ZOL1JmOHRIRGtqdHFXVXl3UThORkxTMjNpRnpTMUZpanZu?=
 =?utf-8?B?M2VSVi9JK2ROY0NEUmo1NEpxRnJvVlZaOE1vczB4eU9XNWhtUXg0MmMzOERi?=
 =?utf-8?B?VEtoUERialZ2L2FLQnA2bjJKb0d6eFFlT2JFRk9sNVVMUnpmOTl0UjdWcUdt?=
 =?utf-8?B?NjVMNFZLaDd6TS9tTkNxMkdaNC9FTmZWWktqcklRS2ZzalJDWlNGNzFZdTNo?=
 =?utf-8?B?eGh3UE1HeC9Hemk0VnI1MjRDUUNBT09WNUtabEdIU2VFWDNMaFpIVzhWd0d1?=
 =?utf-8?B?c1pQRllWbFhMRVZMTGRKd1NxQy9qTEZiQUYwaThQRmxMNXJVZlM1RVJjd2VP?=
 =?utf-8?B?dHRCZi9sM0Vud0VkMkwzYjdiREIvR0FaeWxCUGVESy9EcmI0MlUxQnNCL0Zu?=
 =?utf-8?B?VGpQWG4wNHRRcmdWRWpLajhheERSZlB0V2VuWmRTak52TDVCRHkzZDBXOXBV?=
 =?utf-8?B?d1A3RlU0MXBleUV2R1hhUnNvUDJpTU5KTGdLVXZhVlJsOWVzWEpwMTNBcFRI?=
 =?utf-8?B?Zzhyb1Evc0hkdE1nREJiRzZMeDlOYXc5eXl6RCtGS2pDQUw5eEExZ3E3NDMw?=
 =?utf-8?B?OUpwZGdYNkQ0bVZrZkNuQUhnd0dCcjdySnA1b3VrVng2TGRDWXlhVUxCZlJ4?=
 =?utf-8?B?REsyZVZVOU1TZHp2MmdFWnFtbFNaQ1Q2elc1akhXZTJEblN1Y0pxa3Fnb09S?=
 =?utf-8?B?aE9nNTdNSnNrNzVFbGo5dWZiVCszUGdtZ1NEQ1FmaEhRT0FXZjQyMnJpdSt6?=
 =?utf-8?B?VktqbjNwalBFR3dCNFRLRDBGZ3JibmlZaS9YTXk1S21WZ3p1T21xczN6Y3Bm?=
 =?utf-8?B?WlgzM2ZtejdMbmxZSFFHNWpqSWhkZHhFa3RBUDVCWjI5UjBYNXNrWTdCdVNq?=
 =?utf-8?B?WE4zd0FneGFBbWNTbStLbWZlM3RMcnFGU3RxMG5tK05xZllrM1FQZFp3ZGNv?=
 =?utf-8?B?ejdUalpOYnRPOHJMRllTMXMyK0Z5MnZwN0t3MkJydjBLdVhjOVJUazNjSnd5?=
 =?utf-8?B?MEdEbVl4dEE0YkduelByUEljR2lwSkNKeWZiV2tGRUIzcWd3TDdlNkN6d3c1?=
 =?utf-8?B?eTJYUzlWYU5qLy9rVEQzaUV5VkVoZlF3ZGlBdHkrL0FJZktBSDBqckFqdFF1?=
 =?utf-8?B?aVdsNXlCZ2ZPRldpTDJwMEQ0R0x0TDVVOU42V1lsKzdhdnIyTktQanlGN0J3?=
 =?utf-8?B?SEJGWHovdTFMY3hTV3hLUmVrelhzZ3FUWGRPTDB3OFRZOWxwTytsRlNTYzk5?=
 =?utf-8?B?RlJUeVRST0NRNDFEVlNhaXpHUDF6N1BPQ2krODVrblpmRlR5UHJDMFNZS21F?=
 =?utf-8?B?V1VOeENMV3NNdVdOeURaZEx6TWN2c1RyQUZVZzNLMlJwYXJaRlE2UTgvV3pJ?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0d0ff9-bdae-4fa5-cfa3-08d9dbcacc7c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 04:10:31.1650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2C2H8Q4qwKvF7YgK0Z2ZEZmtLjcO5X5c4UJ/q5HrRGdHCM2Nr6TtuE0hLVcPuDUo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2253
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: joqEX2fAp3krcgpX51-J4LalIB4uBmvn
X-Proofpoint-GUID: joqEX2fAp3krcgpX51-J4LalIB4uBmvn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_01,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 suspectscore=0 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=810 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201200022
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/19/22 9:47 AM, Alexei Starovoitov wrote:
> On Wed, Jan 12, 2022 at 12:16 PM Yonghong Song <yhs@fb.com> wrote:
>> +
>> +                       /* check __user tag */
>> +                       t = btf_type_by_id(btf, mtype->type);
>> +                       if (btf_type_is_type_tag(t)) {
>> +                               tag_value = __btf_name_by_offset(btf, t->name_off);
>> +                               if (strcmp(tag_value, "user") == 0)
>> +                                       tmp_flag = MEM_USER;
>> +                       }
>> +
>>                          stype = btf_type_skip_modifiers(btf, mtype->type, &id);
> 
> Does LLVM guarantee that btf_tag will be the first in the modifiers?
> Looking at the selftest:
> +struct bpf_testmod_btf_type_tag_2 {
> +       struct bpf_testmod_btf_type_tag_1 __user *p;
> +};
> 
> What if there are 'const' or 'volatile' modifiers on that pointer too?
> And in different order with btf_tag?
> BTF gets normalized or not?
> I wonder whether we should introduce something like
> btf_type_collect_modifiers() instead of btf_type_skip_modifiers() ?

Yes, LLVM guarantees that btf_tag will be the first in the modifiers.
The type chain format looks like below:
   ptr -> [btf_type_tag ->]* (zero or more btf_type_tag's)
       -> [other modifiers: const and/or volatile and/or restrict]
       -> base_type

I only handled zero/one btf_type_tag case as we don't have use case
in kernel with two btf_type_tags for one pointer yet.

