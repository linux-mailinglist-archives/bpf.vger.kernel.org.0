Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F086E33DE2F
	for <lists+bpf@lfdr.de>; Tue, 16 Mar 2021 20:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240716AbhCPTvv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Mar 2021 15:51:51 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58426 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240738AbhCPTvS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 16 Mar 2021 15:51:18 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 12GJksZg007830;
        Tue, 16 Mar 2021 12:50:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=985yfkIz7xmesx037iuVdW+rLe1iPAUrqLwgfHTvDB8=;
 b=cVOVXHwRDUQj2ovfA7claPb9s7F5ibfNY5Xh5ZnEqacU7dreXbbciIBhgteSVot5SV1s
 PFOHsB6HskGi8+TWVuAyi63ak3LsBQIDBQEOq/+Dl/DYEtD5gzNCUJ7sqG9SFHPFJnIV
 kPddbleRVrhNkKwAGxgfYtQY6M0xVviTevE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 37armw3ndv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 16 Mar 2021 12:50:31 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 16 Mar 2021 12:50:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aiUVOPs4aJM88wv6A1Zi9tyPPkNSBK18NxhMGgtQIXXvUvYSW25mcEy81y2KHzQR2xKyIxx6Yg2f3dVl+veOJnLu152B1ADhWKBreRnmyCHX8qEZ/igxLWI6RbTmw1hc16AKcma/MSduzFmCYB4LnfxbUx1AWqMJKJ206egcnZmVddCPH4hCxvYg3SkbOv+jdBxu5DKLKHwpeLgFelSDkD+FPgCdwRV7lcHi5/7d1yh2R5Nw5lHVVpBjY2KCp6C7vlrn7ULWqhE33w8bjsci26i+0IzcBpUulzbCQBLqWaKPx3vK88+29GXiZBm1oilxwE0F2aQkz9RlJ4Bq4Usatg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=985yfkIz7xmesx037iuVdW+rLe1iPAUrqLwgfHTvDB8=;
 b=hzHgqDJccLX8ZVdWsit8E6dJEj3Av9s+cZyO6s8ZJ64MvBiXji3FoSL9rn7O6CjXHgiAm8NB7WBYFMf8PPYBrfJat9/nBIGDA46mHZAEPww/iIx1XXD1ym0jmVkodPL7eY3h6VyIOFtjLorGTMyQBygCIWe0txkR6OPNfwuGo4yKUVyRPsPsWrFIn/Kqm923Ss/yO6hbGpIlLTsJEsi0X5tksb6GQz9GgPs2bBqr461g8DK4/cp6ngOWI/Vgx83PvcuuprexhY0e4Vm1LD8V4R1Yu5ZBsJliEXOo8gJYkTzbLAI8CciyLvAOlQ6wHR50NMHbDzXLVG4zUUuPHZrhng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BN8PR15MB3282.namprd15.prod.outlook.com (2603:10b6:408:a8::32)
 by BN6PR15MB1636.namprd15.prod.outlook.com (2603:10b6:404:114::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 19:50:28 +0000
Received: from BN8PR15MB3282.namprd15.prod.outlook.com
 ([fe80::315e:e061:c785:e40]) by BN8PR15MB3282.namprd15.prod.outlook.com
 ([fe80::315e:e061:c785:e40%3]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 19:50:28 +0000
Subject: Re: [PATCH v2 bpf] ftrace: Fix modify_ftrace_direct.
To:     Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     <davem@davemloft.net>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <paulmck@kernel.org>, <bpf@vger.kernel.org>, <kernel-team@fb.com>
References: <20210316191046.28002-1-alexei.starovoitov@gmail.com>
 <20210316154557.0c513225@gandalf.local.home>
From:   Alexei Starovoitov <ast@fb.com>
Message-ID: <12902675-a8e5-f41b-0dea-bc340b2614c7@fb.com>
Date:   Tue, 16 Mar 2021 12:50:23 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <20210316154557.0c513225@gandalf.local.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:b9b5]
X-ClientProxiedBy: MW2PR2101CA0029.namprd21.prod.outlook.com
 (2603:10b6:302:1::42) To BN8PR15MB3282.namprd15.prod.outlook.com
 (2603:10b6:408:a8::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:2103::3b8] (2620:10d:c090:400::5:b9b5) by MW2PR2101CA0029.namprd21.prod.outlook.com (2603:10b6:302:1::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.2 via Frontend Transport; Tue, 16 Mar 2021 19:50:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7251b1d9-0732-44d1-ee2d-08d8e8b4bfe3
X-MS-TrafficTypeDiagnostic: BN6PR15MB1636:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR15MB1636BB22F6C8C1808FA6BD85D76B9@BN6PR15MB1636.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nW+vngdGnWLOie6K13ROoSdoUm+s2HQYVm2ateX9keinZe8Ch9dXJ+2eD0JP7UOcvioiMDoUZg5CHhlBR7yRU2cVxkVQ2uyJFpY7WMLNOT//SRBbBraZIx0lyJRORr3yl4ZsJGjE3Iu9IlLBG4gFVdIv5z4beIapNr2kRlQL2MROJ9JWbMw5OJcQxZhZsHy3jcFscV7zPVdOlf2OMgqnEqfhC7D1gByBSAA6Z57muoEM4CYHv7bt5Px6i/L1wvkwI4HV3kaoptLN1VxLfdEXoa38vauY2SHvN7QF1kSTYWgHBL1fxCoNRfL7JJbmOpE2WTHH60+O9R5Dz+ooGfAj+HOS1fl8V0s2lyuAFZCbngKsrVISAUjF01M/3U4GDUDDJJjAKhvpEJ/WXNmS+Q2gzrdso4Jh/vrbaD/+t5+MpmNO+pUwjNfaYcEGNzivRvK9hB26IaAEjK3jQJCMvqPX3hQ3+zas1Omc0dgEKgEclvWHIMQKseGvcoYAClRZYejQgFoeyhIKsHnLAtJ9b5VqHHYSQdsiADPnLZSrd9NkQZR7kDXbxHJaU4kkfnCMye+h6OeZq7lp7ko60BA2jszxOKMZX2b0Q4KIzI0jrTBGaPZvEyHf2UD7BWiZqFW2BWvlEC2qvzmt7/nvtflDE9jAjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB3282.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39860400002)(376002)(366004)(136003)(52116002)(4326008)(31686004)(316002)(83380400001)(66556008)(478600001)(5660300002)(31696002)(8936002)(110136005)(2616005)(6486002)(66476007)(53546011)(66946007)(6666004)(16526019)(36756003)(86362001)(186003)(2906002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?K3p6VHErbmlMcWtPMjVvWU1zQnh6TlRyclVJeVZsZlZKYnozR3ZwaG40S0RC?=
 =?utf-8?B?ZUxUNUhnZloyQTFLOTJFMlVuZDgzckxjVkRrd29pNGFRL2tvNWZZeWwrTlB3?=
 =?utf-8?B?TDR6Q1RPZDdLZW9hUG12NU1EY0JXdXBpSmZ0ZVQxcUR3bEkrQzZ4MW9ia005?=
 =?utf-8?B?TGNuV0FwMU1JdTM4WHI2eGZwb2FFM1VJVHp4cXZ2YnZtVFV1SHFwSFpjSU90?=
 =?utf-8?B?RmdnKzFKeVJ6MHRSdnVGWkdEQTdHbzBnSVFOMUFsRkUycFY5VlpNL2ljQTZG?=
 =?utf-8?B?dHVQODhLOFU3eU5ZU2RZY0F4R0N1ZytwZ0tDa0JKVWpnV3BoTlV4YU9FRmdQ?=
 =?utf-8?B?SGFZRHpUUHI0SjRYdFZLSUM5RlZaYmVEd0pNOExPSGdOdjNqMVRUbmhIRHZu?=
 =?utf-8?B?U3hRbVhHTXFHOEJyNGd2cGNaeVl2QU5tS1JUb2pueGhaSmRqQUszMlZtcEtT?=
 =?utf-8?B?UUZtQXZBQmk5Sit2dWpBTm03ZHVLcmx0NUs2S3NxekFSTTYxNFp6SHRaS3dt?=
 =?utf-8?B?b0hKTHFCWkN2RkdnZ29uRk9UeXlSSkYxVy93MzdWK1BKcEMralViMU85cGFm?=
 =?utf-8?B?dmRDdHNYdFAzaUJaVUx6MjVwWS9iUDFIeDJuMjNrV0pydHZjakZGTUJsRk1a?=
 =?utf-8?B?TmVRUE9zbHZ3S3RlSEFvQnFRQnlOcUZ0eXJwZlo5RVUxd0ZHOE5xSGJ3Sml1?=
 =?utf-8?B?OHRmRjNSNzZEcW1RbTAvVVozeDVHcnpzMjNvc0I5VUhLd2lCZ29ZaGxoYktV?=
 =?utf-8?B?NEF3OC9MK2diQmNxNStaMVFxRjhMbTF6bzMxNjJObFpNbFlWaEM5M3daaG53?=
 =?utf-8?B?VmdSZGNQa29rajd4K2xhdFZrWmJvdzVMaXdjUTdMZ1Fkb1BiYXdHbUJNN0NB?=
 =?utf-8?B?L0RSYWZ0TGV6cVlIb1J0WjRhR2Z4L0M0Uk02dHhucW44YUZHSHBER1YxWm9L?=
 =?utf-8?B?S1I0VEFHc3BTTEVqbE5pVzlrS2E1dVB5UVNhQXZHMlVwK2IyaldHMmk4OHI1?=
 =?utf-8?B?eDBZRFcxZ1c1ZzYzblZRbTZ0Skh6UjdrT0diQ0c2cjR5dnhNcUtFMnhPK3c1?=
 =?utf-8?B?VVlNNzdMdytET3lDN0ZnUVVJQ2hCRG1oWU9veTNnV3RIZ3JNWjFvK0YyWGZj?=
 =?utf-8?B?WU1ibUEzME1WNXhMZS9vZTJQTjZFVGpaSk5WcGF4QkI0eXk3aG9RY2YxNk11?=
 =?utf-8?B?NFZ6c25rMmErUEg5NjEyMFZKYTNWaFY1RUNpTy9JUmVzQlZHWUhiMkwzUW92?=
 =?utf-8?B?bFJWL1BMZjFxWUtsOFBEd2hYTXFtRjNEVm9JYWQ0ZDF6WFJiOXc0UVNoQlha?=
 =?utf-8?B?aEVoaEhiOHdHbGpYRUlWa0ZISytYL2dwVHl0TXhtd0YxSXZ5UE83V3Z5NktR?=
 =?utf-8?B?U1VqODArQjBRaUI1U3U0WkZCYWxqMFFxSzhHVk16eW5NUC9EbDZ5bUlndGU5?=
 =?utf-8?B?R1VvVkJJaTErUGxGc3pVY0ZXMHNDUWFycmw1bjRmcVIyNlpYZDNqcWJYcEpX?=
 =?utf-8?B?SEJDS3RYZkJMQ0lXandPSTJQSnVoUlZyRm1MOTA2eEtoQ25jbnZzdy9VbUNH?=
 =?utf-8?B?Rk5IZis1VXZScmZzNXh4VXBDaDUyN3B0UnkzWTJtOU9IZDBjSm81QkljYUt0?=
 =?utf-8?B?WWJad1NyWEMvbmJpSnZ2ZVFUbkJoOTY0QllZdzR5bnpLV0o1K1l3Wnlqek9u?=
 =?utf-8?B?TlhkVmFUczZtTTUvcUhBTXZLQXZHdk1KWEhjOUJxUGNDRUN5V2JvRGNNNW8v?=
 =?utf-8?B?eVNYR0FxbU13azhnVE1kTnlMcTk3eHFlVlFFTE9UZlpUN2UxQ1ZWdHFnOW5a?=
 =?utf-8?B?RkQ0NEQrbE95QVFoSE9wUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7251b1d9-0732-44d1-ee2d-08d8e8b4bfe3
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB3282.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 19:50:28.5317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4OX4B70XBXTsW96gtYmnJOJ6s8zahdDtIycQwCtCYPfvRPh/5b5MW+N4X52etV2A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1636
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-16_07:2021-03-16,2021-03-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 spamscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 clxscore=1011 mlxlogscore=880
 phishscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103160124
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/16/21 12:45 PM, Steven Rostedt wrote:
> On Tue, 16 Mar 2021 12:10:46 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
>> From: Alexei Starovoitov <ast@kernel.org>
>>
>> The following sequence of commands:
>>    register_ftrace_direct(ip, addr1);
>>    modify_ftrace_direct(ip, addr1, addr2);
>>    unregister_ftrace_direct(ip, addr2);
>> will cause the kernel to warn:
>> [   30.179191] WARNING: CPU: 2 PID: 1961 at kernel/trace/ftrace.c:5223 unregister_ftrace_direct+0x130/0x150
>> [   30.180556] CPU: 2 PID: 1961 Comm: test_progs    W  O      5.12.0-rc2-00378-g86bc10a0a711-dirty #3246
>> [   30.182453] RIP: 0010:unregister_ftrace_direct+0x130/0x150
>>
>> When modify_ftrace_direct() changes the addr from old to new it should update
>> the addr stored in ftrace_direct_funcs. Otherwise the final
>> unregister_ftrace_direct() won't find the address and will cause the splat.
>>
>> Fixes: 0567d6809182 ("ftrace: Add modify_ftrace_direct()")
>> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>> ---
>> Steven,
>> I think I've changed it the way you requested. Please ack if so.
> 
> The changes look fine, but I just found another issue that needs to be
> handled as well.
> 
> 
>> @@ -5329,6 +5339,7 @@ int __weak ftrace_modify_direct_caller(struct ftrace_func_entry *entry,
>>   int modify_ftrace_direct(unsigned long ip,
>>   			 unsigned long old_addr, unsigned long new_addr)
>>   {
>> +	struct ftrace_direct_func *direct, *new_direct;
>>   	struct ftrace_func_entry *entry;
>>   	struct dyn_ftrace *rec;
>>   	int ret = -ENODEV;
>> @@ -5344,6 +5355,20 @@ int modify_ftrace_direct(unsigned long ip,
>>   	if (entry->direct != old_addr)
>>   		goto out_unlock;
>>   
>> +	direct = ftrace_find_direct_func(old_addr);
>> +	if (WARN_ON(!direct))
>> +		goto out_unlock;
>> +	if (direct->count > 1) {
>> +		ret = -ENOMEM;
>> +		new_direct = ftrace_alloc_direct_func(new_addr);
>> +		if (!new_direct)
>> +			goto out_unlock;
>> +		direct->count--;
>> +		new_direct->count++;
>> +	} else {
>> +		direct->addr = new_addr;
>> +	}
>> +
>>   	/*
>>   	 * If there's no other ftrace callback on the rec->ip location,
>>   	 * then it can be changed directly by the architecture.
> 
> Everything looks good above, but then looking below this code we have:
> 
> 	if (ftrace_rec_count(rec) == 1) {
> 		ret = ftrace_modify_direct_caller(entry, rec, old_addr, new_addr);
> 	} else {
> 		entry->direct = new_addr;
> 		ret = 0;
> 	}
> 
> Where if ftrace_modify_direct_caller() fails, you need to put back the
> direct descriptors to where they were.
> 
> 	struct ftrace_direct_func *new_direct = NULL;
> 
> 	[..]
> 
> 	if (unlikely(ret && new_direct)) {
> 		direct->count++;
> 		list_del_rcu(&new_direct->next);
> 		synchronize_rcu_tasks();
> 		kfree(new_direct);
> 	}
> 			
> The above is highly unlikely to happen, but it could.

Sure. Will respin.
