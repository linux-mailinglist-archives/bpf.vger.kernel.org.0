Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9D1403F84
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 21:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344396AbhIHTNa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Sep 2021 15:13:30 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:6140 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230161AbhIHTN3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 8 Sep 2021 15:13:29 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 188J9e4Y020184;
        Wed, 8 Sep 2021 12:12:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Ou9w9K1FbPjfo8VnSgmbutnZ0FsGqR7pj8eAhgC1hwI=;
 b=hQH0HDyHKdeSj4vbYNXKue+ZCKdVcBwC/3el6TRtTJgD36WFJETasD+UwtGSI9HJWKuC
 BvWEhRl1jNXUxyr5uz2V7eFf4SiUIwG8XNl3NJtz6LI1gWLERUHNjAhgqZKpcH/9Hz3k
 2OC6eWI9Zm3Pv0e7j3rDjdd9KMu8DTMpDjc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3axcpj7yr7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 08 Sep 2021 12:12:00 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 8 Sep 2021 12:11:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJzeu+95ZDYF9Do8p70k7nvZPORSXj7J3xtVOJk0Ej+WihgUsnUi+6umHumm3WosLd7YxTp7ZyPhxahqdZB5oZ5XUN+MqewLPYo2xBr2j23xMNUIcCJblz4h41gWbxiQq8SN9gTrHJAXhSs1kEQ3Z9cEtoKIfms8tgs4gRGjn+N8ASh1aZTgtjA5R445POZFOuhVD9gn5pRGNFWbV8LBtFPir7qRVjI5fJKE/lLYA9E9L5wn79oIWwLu3DGvVmWuYz1p72XDsDkf5UIZP3Rffn3bLIIq0u2dL7eF2AOBjy0SYDHQnIPzd23VA0rnSQ59MGI0J7/tHJ4yjij4jqKz9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Ou9w9K1FbPjfo8VnSgmbutnZ0FsGqR7pj8eAhgC1hwI=;
 b=E+FrqYGMS9INOD6oSGMmqY44f0Qbu0uhBM69aEjDZeE2gGnHXOzDTjM7zXCiVySy6FbEuHB5SFujXPaVDvaRUTOuqyiSUy/BwX0mKnO1k/SOvOWZiCWG7LraNG1T8F1ds44SYwmTnDdXIGo+7vR0F3K2EgxsGnif5ZKGMkfltNUQPt7y5sQApoZSsdOTifiaagSidNz4JrDWtW11ZaBPLNLJ6fcSYWJcjwIn8jNu4l/cPsg7O4qj4OWrxlsLVQcpnmN46b+glazXFW0y9yP2C6b7bhXgfrQjAZpxZ/yD2lnbArs2T8O3fmr2wCoioR1RTyb/tFWYF4xWQ0cZs40/5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by DM6PR15MB3099.namprd15.prod.outlook.com (2603:10b6:5:145::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Wed, 8 Sep
 2021 19:11:58 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::80a7:bdbd:d33b:e03c]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::80a7:bdbd:d33b:e03c%5]) with mapi id 15.20.4500.014; Wed, 8 Sep 2021
 19:11:58 +0000
Subject: Re: [PATCH mm/bpf v2] mm: bpf: add find_vma_no_check() without
 lockdep_assert on mm->mmap_lock
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Liam Howlett <liam.howlett@oracle.com>
CC:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luigi Rizzo <lrizzo@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "walken@fb.com" <walken@fb.com>
References: <CAMOZA0+FofdYMivrBR14snb6Xo_i6BV7gVX1dGCtJa=ue3VqEQ@mail.gmail.com>
 <20210908151230.m2zyslt4qrufm4bv@revolver>
 <f5328a05-ed3c-a868-9240-1b0852e01406@fb.com>
 <CAMOZA0+2KLgYTXDZHGUYFnYezee=_hH6kFVM+-n2ZQuFTfh6yg@mail.gmail.com>
 <20210908172118.n2f4w7epm6hh62zf@ast-mbp.dhcp.thefacebook.com>
 <20210908105259.c47dcc4e4371ebb5e147ee6e@linux-foundation.org>
 <20210908180258.yjh62e5oouckar5b@ast-mbp.dhcp.thefacebook.com>
 <20210908111527.9a611426e257d55ccbbf46eb@linux-foundation.org>
 <CAADnVQ+5m0+X1Xvgu-wYii2nWvAtEfk2ffM6mQTaiq2SPM1Z=A@mail.gmail.com>
 <20210908183032.zoh6dj5xh455z47f@revolver>
 <20210908184912.GA1200268@ziepe.ca>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <7aece51f-141c-db55-5d4c-8c6658b6a1fc@fb.com>
Date:   Wed, 8 Sep 2021 12:11:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <20210908184912.GA1200268@ziepe.ca>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0042.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::17) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:21e8::15db] (2620:10d:c090:400::5:ffd6) by SJ0PR13CA0042.namprd13.prod.outlook.com (2603:10b6:a03:2c2::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.8 via Frontend Transport; Wed, 8 Sep 2021 19:11:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67d2c49c-e220-4f4e-98ad-08d972fc875b
X-MS-TrafficTypeDiagnostic: DM6PR15MB3099:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR15MB3099DA0459014F95086BC0D6D3D49@DM6PR15MB3099.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +cbn1t6jHijKEAepupJbZeT+ukS8eZ187yc+8B79b1LJbG5GiqoAMzN715DObEhzZF9AKen25oMpnE2kB0NLcY6S4KQ3R/OGpU5kzwZT5x4feT0VFM/pgLexrlzJ7CSs7eoat9QV0wzI/Jti4uradJ8oxHJmjIThFSqx2sOeDQNRWAxx36dNs/QYChS3EORBVUlCNvA4UyOPjEDSa7tJ+RHKt5ju2FwfH4wYfGm85Yp5W+Bou9aHn5Nkd3nz3Wm+9SrwXrmH293VNzhFUGGALWjmhSxVbHfC6zfmIVBuC0u1u+IV1W9I1RFemOQF5VT9Bw6jvzoSyL4X02m3jjKgR/JD+VPHX5V6f62uM5JcCvE01hR3N6L16cnyAXV2KGQEPGuDdB4qrGLRsuTOiYU5ZySBiX5NQiSjBo2w9eiIKPu2i1p6RAPByM/X6CJ+KO9EsAXm9C8NCSJD9vYc8mEHN8iquxJ5Ac5JKOX3nqgSg5R7F2t913373mIrEQVGTB9Gxm0onJtgmHr9mJu3/C1gnOnozyCbYJap9QQAi1yrn9kX7gJL+DXWgybPnKopLPwdywgIIDXbS9LpyOdfiaxCLH7REwjYWTsUzDqrNzJ2Q1ZwNl1w/TIOrGidgZwU5/zFoJfl5CUmmMWxBIwzvXoG5vJdVrem7gKySpniIEI1nAUdXfADBkmHtX2k5XJHhCXCBkkr8d1dosXsmus6XvBurQ/kHgHJnO48KJp22fwyGD8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(83380400001)(36756003)(7416002)(8676002)(6486002)(31686004)(8936002)(52116002)(54906003)(86362001)(110136005)(508600001)(316002)(2616005)(4326008)(66556008)(186003)(2906002)(38100700002)(66946007)(53546011)(31696002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVE4M1BVQUFjTlpDcVhjbVMrQlp1d0FvNWN6L3RNRm1Rd3R4dUdBYURUZCsy?=
 =?utf-8?B?UlNLamFZVjhJclM4YVV2bDZJbjhRRmNrRzNVZ0N5Ung0YjFvV3ZZWnQvYmQ3?=
 =?utf-8?B?UUVzaFNLYzRmRUMwZkY5Z0tEdkM1Q0ljOXRGZUsySmRRbzJ2UWtBbEY4N25a?=
 =?utf-8?B?aFF3c2hGR3piaHkxOTVVREpkcEFSQzZhN0t0OG03RzFTbHd2QjNGbXl2YzhD?=
 =?utf-8?B?UVorNWFwUnExV1dUazRZWE9GN3lhSU5IZ2U1Wjl3anNBc0NIS2hkT1dTZVpF?=
 =?utf-8?B?Ulk1TXhieVQvV1VyNzQxMUkwSmVJeGVUODgxNkp3UmwrUDI2dm1DUDFZajlX?=
 =?utf-8?B?aERTdm1HLzNqUS9GKzAxOFlDdWswNDcyRU8zK1B0UkN1NGJ5d1BZY0Eyay9G?=
 =?utf-8?B?YVYwZVpxQTZYcHRQRm0xNmdCVnczNEhnTGVveFBYVFVHSHRiQU1mMys1ZU1J?=
 =?utf-8?B?RmJaeFdkbUxHY0NsdVNyMnR1ZTYrUnpVMC9HVk5zUDlqVndmSGY4REs4Q1k1?=
 =?utf-8?B?UDhGYVpKWHRkTFFWcE53dkRRMWpvMTRGZldZeTdGczRNWmgxNU5ZbG1iRklM?=
 =?utf-8?B?TWJFVDF4MkQ0SU5sWjBrbEJRUGI0MmhGQkJHVVFud3VuTGh5UnlHbHNsU2xt?=
 =?utf-8?B?VitXbnB4RUhCdVZ5QmpjZ2JjeEE0M29lZGNuaUhvN1V1UXR6L3dJdS9KUytt?=
 =?utf-8?B?ajA4YkdlLzNJYWZnYSthdXlITy9hREZwemNPMmFGMy8zZ2k0dmtKYm91ZXRS?=
 =?utf-8?B?bEtOaXgyVVU1c2hDWTRwTGE0K0QyTFBTbmFrUGJpSmJFN1NSdFR0YVl0QXhL?=
 =?utf-8?B?YU01MnRBRmY5WW9KWTVtL1B2bHpvMEtDUVlNSWMyWXRzWTIvMlFaNlc0WUNp?=
 =?utf-8?B?ZHdjV3E4R0diWm1pMldocFBRSkdyd2JoVmNVY1BBeCt3cmVvT0FDclpzOVgw?=
 =?utf-8?B?c29rVnJXTlhIcTFsdTdNcFM1TlNJZUwrS2hpTjlaajZFSGs2dzk4QUFIQkJj?=
 =?utf-8?B?ZmZ4d25yRTJRMFBWNkNUdXdYL0xJZHJHL0VKcWRYTG1SeCt4SXAwSWhueWJK?=
 =?utf-8?B?N21qR0I1UUtCeWxkWHZBMWZEV1gvaG9iZWxqTFZLTyszRDNhV2wxWjA4OHZ2?=
 =?utf-8?B?a002WE96U0pEbkdLVXliK1hySmJndkhVYk9XUlhseVJYNUR2TVFWNCtJWU9G?=
 =?utf-8?B?bWFyUGhPQzgyRjIwa1lJNElFbk1qYS9NYTFtWmtEaFdaUHRydWY1S2ZNUHNw?=
 =?utf-8?B?U1YzWVNFT0FSRTcyYzBpdUFMRDNMQ29kR09kUkw1YU5LR1VwdXVTOXZTS2Vj?=
 =?utf-8?B?Q2lFRW5URzFQdGN0dkltUDErc1krUEZUZVFaZFNrU2RPc054eWRFcC9KbFJD?=
 =?utf-8?B?ZndoVlBUeW5PeVNMUUR6WXZQa2puMGdRYys4LzhBSWVWb21MNWRIREN4RmtW?=
 =?utf-8?B?U0lVSmEzVkkzRlNjLzhvcW1uU1I5a2FNUEdOdXFkTTQ1NkZxRFNkdk9BTVEy?=
 =?utf-8?B?b1ZlbFRaV1dKSjZnZVh5R29GV3FwS2dDYm9nTks0Q3lSYm8wSjBvM3NSbDQ3?=
 =?utf-8?B?WkdXR3FtSzUwSTlhUGN0aTFtWTFSajZ3T1ZaVFlPYnEwM0M3OWNOSWxKTk1G?=
 =?utf-8?B?TnE4ZCt6U0NwVjA1aFhDU24xdUFkbkpJUU5rZndBNWhCSG81TkNyWDZobnMz?=
 =?utf-8?B?NzR1UVJIUmVoc3NKK1dyRFhzejFUMm1PNy9ZWFFYM0hVYWlSc0hUQnR4N1VK?=
 =?utf-8?B?eVF6aTQ5dXZzZTY4VFJqVGgxY1JiN2JPWHJSY0I5VzVuNDlDbVZORVQ3elZ4?=
 =?utf-8?Q?4z0v6wk/M03Y9vXfx9bCKOuAHSKc9M+ahO7Ns=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d2c49c-e220-4f4e-98ad-08d972fc875b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 19:11:57.9107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +RrD3tCEcKPV5H91Snh101dE+yjDLKejXqLE/ObTFoWQh5Dvsoupg1aiforWTtr3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3099
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: hP8L5PXnp4e6rxOwJJU6f-qzkNbW2OfJ
X-Proofpoint-ORIG-GUID: hP8L5PXnp4e6rxOwJJU6f-qzkNbW2OfJ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-08_06:2021-09-07,2021-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 spamscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/8/21 11:49 AM, Jason Gunthorpe wrote:
> On Wed, Sep 08, 2021 at 06:30:52PM +0000, Liam Howlett wrote:
> 
>>   /* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
>> -struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
>> +struct vm_area_struct *find_vma_non_owner(struct mm_struct *mm,
>> +					 unsigned long addr)
>>   {
>>   	struct rb_node *rb_node;
>>   	struct vm_area_struct *vma;
>>   
>> -	mmap_assert_locked(mm);
>> +	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
>>   	/* Check the cache first. */
>>   	vma = vmacache_find(mm, addr);
>>   	if (likely(vma))
>> @@ -2325,6 +2326,11 @@ struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
>>   	return vma;
>>   }
>>   
>> +struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
>> +{
>> +	lockdep_assert_held(&mm->mmap_lock);
>> +	return find_vma_non_owner(mm, addr);
>> +}
>>   EXPORT_SYMBOL(find_vma);
>>   
>>   /*
>>
>>
>> Although this leaks more into the mm API and was referred to as ugly
>> previously, it does provide a working solution and still maintains the
>> same level of checking.
> 
> I think it is no better than before.
> 
> The solution must be to not break lockdep in the BPF side. If Peter's
> reworked algorithm is not OK then BPF should drop/acquire the lockdep
> when it punts the unlock to the WQ.

The current warning is triggered by bpf calling find_vma().
Is it too late even if bpf does drop/acquire the lockdep when it punts
the unlock to the WQ with irq_work_queue()? Maybe I missed something,
could you be more specific about your proposed solution?

> 
> 'non-owner' is just a nice way of saying 'the caller is messing with
> lockdep', it is not a sane way to design APIs
> 
> Jason
> 
