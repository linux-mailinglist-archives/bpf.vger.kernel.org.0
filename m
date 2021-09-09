Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC264059C4
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 16:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236469AbhIIO4p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 10:56:45 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:20110 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232359AbhIIO4n (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 9 Sep 2021 10:56:43 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 189EjdFi023194;
        Thu, 9 Sep 2021 07:55:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=wDO3KYmgrDNR0/WgzcOfA9j3g/DMH8UcHx7vztzuQ/Y=;
 b=cwDyT+C7oGqvd+iWQYXEumvepazjfdGe9Vt+Xh3IcNeXgBet+YDFABKEKzK8RSqcoq/Q
 4scicm9Fv9a2WEppVrFE/dL2kbCvaCfFL4LtRx6kObZoqQFaQfFq+Qf5bMMGyCIHHSrV
 jVA+G672KIGBQ7CJnRVfjOqG0OX9g5V1zAQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3ay56757kv-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 09 Sep 2021 07:55:17 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 9 Sep 2021 07:55:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWqidjgpVNnBNPfARWo/ehQvPZDobH2xUAbPREUF5oQf2fSk5weCts2YNCYeMFLLfluckS/ELChfs/Ie7YHaHmILsl2Nju+veaew4yNLT1M9EbVEVC/nzmEgxmsKCgA4J1GlhRYa8UBj4wXjJGuc3DRhUqVIby4bsbtH5hOzwK42aAZRpg6fbFPjuKaQB6Jo8nPPKmvbifiv063V236EWlSs99ac/Anat7yYlxHRTBYdJUACWvTETT2/G961+6/vBndYA23cD1ABoBk1OlP8Htof6QSRB6xErSWORwWZzWFTURYAaKGk6x9TtZsmRecueUAqWAxiQk5lO7W53BbzwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=wDO3KYmgrDNR0/WgzcOfA9j3g/DMH8UcHx7vztzuQ/Y=;
 b=IlKD1SzqEtyLxVcgzqnyeBmqQJ7UUfCzzlcTkD2hki22hfdAI37C1zhBOzaMgLrniopqdxXRltkXv4FE2sVFOuHjY/W7fuHab1MQsH5+oa1ZM7yVOQ97h1mIGQDcQhGegVn3plslGNuLEnvS3LFyIGOid4xKQYuL9f+PBoKl7T0XXZnFMBuipG2jABJRHf3U96Jt4IJ0YR5sedspEjJ81dJoataWQykOZ1xhl/+NdJ9xzxwGJTHwscfSc5dZMQUg20S1RWk2vQNGrL8K1EXwfLgYN5ISgfhIpHwqmZRCF0m4zuLcV7g6RsnCZzFktlBVqd+YE0GLLZ4oDNvclHFVQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: ziepe.ca; dkim=none (message not signed)
 header.d=none;ziepe.ca; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4419.namprd15.prod.outlook.com (2603:10b6:806:196::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Thu, 9 Sep
 2021 14:55:12 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4500.016; Thu, 9 Sep 2021
 14:55:12 +0000
Subject: Re: [PATCH bpf-next v4] bpf: fix lockdep warning triggered by
 stack_map_get_build_id_offset()
To:     Matthew Wilcox <willy@infradead.org>
CC:     <bpf@vger.kernel.org>, <linux-mm@kvack.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Luigi Rizzo <lrizzo@google.com>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20210909060245.2966358-1-yhs@fb.com>
 <YToNG9HaJYfGHusw@casper.infradead.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <196576d8-414e-8962-34e9-d1d7eb569133@fb.com>
Date:   Thu, 9 Sep 2021 07:55:10 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <YToNG9HaJYfGHusw@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0186.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::11) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:21d6::108f] (2620:10d:c090:400::5:59e2) by SJ0PR03CA0186.namprd03.prod.outlook.com (2603:10b6:a03:2ef::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 14:55:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c26d78ad-0d30-434a-3e26-08d973a1d394
X-MS-TrafficTypeDiagnostic: SA1PR15MB4419:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB4419D8DC6AA95CE9029144F8D3D59@SA1PR15MB4419.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s9uJQ5ZuSurIOSPUAtcJqMc8SoPPKSEX2tt5YMB0iU0uaA6cev/wfRiZZAjzItyoRxUKKZIRcELJPl6yS2rfnEnPPwGzL2saqvnEj73pUpgR07k9rwKjKLmTCIBKjWNivOSUn3L82nFgBunBClEHY88DvcQe9ONzjQKSUD+p1KyI6c6vN5oQ7OD1sxnak14tGtjPGtw2jHiSO8d4gxOqICJvc/gEv1gdX2LIRhc1sKnSst63SKcVYIKsou5qegrZYlI3qFUa9jIYVpm9Nr645Ex/q5ct9KqWvw6pvPSt9cmmAUHH6MX0xPMyWPXhKpRb0AxAu0hFM0tjIpqgs8mJNltrMbH+8CGEYGR8ZZ4dKUOrqGDuzgIoiP+k7ayN9j+bo2SR+TgRuM1HDIiTXC+szJ+vBqi00bcu5hsjErZCWHAvJj26n6cU9VZziRAwIWG78wTe77EsmIFJQn6B/mc3R2rlJ91RdZQJvAyQRvqOswDvom+CelDiHTrQSJ3FmYO3/iNYuTExnZ5Btd1vTiYFHNX/kJvhFZMFP0hX9dTNYoIXA5bOpPADj9mYpz9Q2BbBXFx7hUd49qCFe6JqJD0D3cNizNX6VaG1XDgtP710Lyt7A44HxmNI4lDVxgnjZ+dFLxPtws8phxyqUAqxMslh+uk0OQaKqfJue9O4MP8Qhzbr9QvcUb4yKg++iqKTxnoc9LHyQRSSGZfzjYFHiWfeUEbcQAINgHshf6faVPvz3jM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(316002)(52116002)(4326008)(31696002)(5660300002)(6486002)(66946007)(2906002)(83380400001)(2616005)(4744005)(53546011)(86362001)(38100700002)(8676002)(508600001)(36756003)(186003)(6916009)(66556008)(31686004)(54906003)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTlDVXdOVDhxckhPeWJzNzdTZG03NStuNHBsQ01vbjlWMGN1cUxsWG1mNzEr?=
 =?utf-8?B?cFp2N1VYUUUxSDFPTDRhcXJCZG15OWpoaTV1a2R4bGJ6V0p0RFBPdzlzdG11?=
 =?utf-8?B?YzVoYXQ4UlRtRnVzTmpRelQ3UCtlVzNZa0VrTjdqQ3pkcS9JbGh4WEZFVW0w?=
 =?utf-8?B?WUtyUklxZjR6amFNemZJR2ZnRitpRkU4WFVPUldldWpHWHdWOXB1c3FXVzlo?=
 =?utf-8?B?ZVVaMEhMM2lhMkhDUlcyZmltajdNeEs5VTVTZUh1TmxCUkVobm9nUWFqYXM2?=
 =?utf-8?B?VGZ0N2VNU2NtTVZFdUtMMlNJdTVvU1FNRzkxYnRoc3Z3QUtqaDREVGRXeWZW?=
 =?utf-8?B?a0FWQVFkeUJUVDVWNko1RXJUSDZRZ0pPdkxTR25uT3ZRK0J5Z2JJUlFoMCsy?=
 =?utf-8?B?b2FhTDA2UTEwRnVxajZRanVCanplU2VIdVhncmFWYS9ZQ2syQjRaekJBck9E?=
 =?utf-8?B?cHU3eURIQkZPRnlaeDZmRW1KNUcySEhuZW9hc1lGZzVqZU9XSmFlOE9rWlFI?=
 =?utf-8?B?d0cxMEF1TkxPMjd3WHM1TzhNQm14amJqZWI1REo1cC9PcjRZcmg4VzlPeHNE?=
 =?utf-8?B?cytsak9DTXRlOHJtaVFPejIxTCtGeGh2QzNGWE15Y3pKMitCYWZtdHJBWUlx?=
 =?utf-8?B?a0I0ZkNNSlpsa25raUxqUHBhZE1Cc3Z0bWROcFAwaTRWUE12ZGcvci9pWHRr?=
 =?utf-8?B?TTdPNlhvK2UxVUdYenJEanh3eFVTVUhIZjA2cEJtdFprUUpPUFZEZEsxSlpi?=
 =?utf-8?B?R1UwcDlkVktjQ1JsbnhGMDZrVlRaRVVvNzNDWUdES1d5bFRsRDkxTGZocDcz?=
 =?utf-8?B?Q2FSeVVtVHNZZXVZaUNnSFhNU1RCT2pEbk9BM2RuODVhNFI5UmdFKy9YVXF0?=
 =?utf-8?B?NEQzRFBlTWg0ZG1iK0tSeHNnL091RHd5V01HaitvRXFEbXpsSEpwbVloUmxY?=
 =?utf-8?B?YU9FZjlZTW1pMVdyd1RIa0Z2Vi8wTE9uUlNkRDY1Y3k1cGdpc3ZRNzQwaHR3?=
 =?utf-8?B?NmJZczUvcXY3Y2FaS1R5ekUzRVVkUWxTNUdLWFhUdlJ6V1ZkVy9Ud2hNVzFv?=
 =?utf-8?B?N01sVmk3NFJaZkVBU3ViWmdpOEVTcHRDY0Q4R3ZIdEhKUHpSb1QrbmtnY1VM?=
 =?utf-8?B?UG43dnQ0NjBjYVlUWkNNenhaSmUwdEJRb3VJQ0NxYU9IVUVRbTFjK1M3RXht?=
 =?utf-8?B?WnkwSEJ6aW9YQ1RNNjVSNlk2OWl6bDI3cHVTVDltTE0yUXdJd1Rua2hJakVX?=
 =?utf-8?B?dmwrcURvRHhMNE9STlFlczNQcVlsa3I5UEVST25IdnBoMmRhNkswSW1vVmhl?=
 =?utf-8?B?bmVOQzRtbmYvNmMzR3grSHhWVi90MUJMMUJtVTNFbWlacmZiSi8xYjEwejZG?=
 =?utf-8?B?SmxVNjZ2NDNpWCsySktITTczZk5Tc3lscXBLbzNtUzhMK2JMRzZSOExlemFo?=
 =?utf-8?B?SGk5SDQ0OWlqMHpRTys5cnNoWkNnK05pcHJDNlJaVXJYc2JsOW5KYWZQVSs1?=
 =?utf-8?B?MCtRdDJGZ0NGVFlDeG00cG5DbGxVYWJPREtYbnhWN1VOYmdCV28veTYwZWhI?=
 =?utf-8?B?TW9JUFlJVldWemZvYk5sYWFQSmVQRitSM053cDFBcHBjYXpBWkhJZVYvZFd3?=
 =?utf-8?B?N0cvOWplSG5JYlA0UDhMQmFtT1VlWnhOaVZKMGs5QmRqd0Q1R01kUXNzeE1o?=
 =?utf-8?B?MlBsbnBHa2FqZmN6dzduZmszTFlLVFNKWUNLZkhSd2k0bTVFYnMrYy9EQUFa?=
 =?utf-8?B?UHBhVnVKZkN4N3ZnSlVVVStTcThJRWs4WkRaM2RQdjZiMy81OGVJQVNDTkxu?=
 =?utf-8?Q?VrgU8WIroE/vIfkGUPQfMP6gittviC19ztNp8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c26d78ad-0d30-434a-3e26-08d973a1d394
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 14:55:12.7321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: by/K1/aK4J+HkFb5X9b39/h1hSX8LactqZ3J9g4d0PD1bixJk3a7uuLLIHJi0vmG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4419
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: r3AlWCditmwc0vPQ-4yBQmS8iuH1akPg
X-Proofpoint-GUID: r3AlWCditmwc0vPQ-4yBQmS8iuH1akPg
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-09_05:2021-09-09,2021-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109090091
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/9/21 6:33 AM, Matthew Wilcox wrote:
> On Wed, Sep 08, 2021 at 11:02:45PM -0700, Yonghong Song wrote:
>> @@ -204,9 +204,10 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>>   	}
>>   
>>   	if (!work) {
>> -		mmap_read_unlock_non_owner(current->mm);
>> +		mmap_read_unlock(current->mm);
>>   	} else {
>>   		work->mm = current->mm;
>> +		rwsem_release(&current->mm->mmap_lock.dep_map, _RET_IP_);
>>   		irq_work_queue(&work->irq_work);
> 
> This needs a comment before the rwsem_release().  Something like:
> 
> 		/*
> 		 * The lock will be released once we're out of interrupt
> 		 * context.  Tell lockdep that we've released it now so
> 		 * it doesn't complain that we forgot to release it.
> 		 */

Thanks! Will add it in the next revision.
