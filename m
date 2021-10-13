Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7FF042B451
	for <lists+bpf@lfdr.de>; Wed, 13 Oct 2021 06:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhJMEoA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Oct 2021 00:44:00 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55286 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229634AbhJMEn7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 13 Oct 2021 00:43:59 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19CMeFK9000607;
        Tue, 12 Oct 2021 21:41:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ywn/A0hgLVIieiqTHT7TLApxB+W2bWZJrhIUoL9mQ0U=;
 b=RjzSwZJHxgJMqRfHXlaT0SNrpy25lpTi1ukLUV9BtHzeDJbNkAhsnPk7cHzUthdhPSWA
 1WtsDhL1jxs5cKarXqo8sNOIfRH03ySN6hMjzPM059bkbboE8vBG0qgekQbG/s3JFZ/K
 QMQwthKNyeUvaP+r7YIQxKdZZhXEVrxB/rA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bnkbrhum9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 12 Oct 2021 21:41:54 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 12 Oct 2021 21:41:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ik8+mhIurMGtBJdE8gxKvA1f3nIBdX6XrpyHgSx/JP3z4K3EAOc32yjzldmi3S8n0uYSm2iN6TZf5aEn+ItLSJFLRv/uDDS0b98X8YPUCAf8Urb5WKQFrkZAwCPWOOG7z8jQ3eQLx4/fvwwG9ydZOoLKcwYwsFU2S4FS48LD8WaPX50Ea/JbmnZpMWIQi8MunfQcyuV59peXGoxIv38F1aiwmT8HwRd+zPywxRqChQRbSugwk6P6rmYdvLX5wF1lwX7i3rVWYFj7NP7/t+Gx5TpNTJwXYgpD8CcBNLxiCVH5pl0zkyGcaH0ahfXR2o+rJBPZ3VuadbkEPJ60Bw512A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywn/A0hgLVIieiqTHT7TLApxB+W2bWZJrhIUoL9mQ0U=;
 b=LwvmB+ZbqkwtahWk7IlxnLeqP56Eu2ZsRnObEkgcMHgzpxG+5Yx8T+KcC0fx9PCVzY+Kuyo6qTT0BX/3o2VAwjIxbtMuUWr/EtUWzZt6PdaSlfDZaZ0Vmh0Zqj2uV6AW+Rsn1QW5xV7KtKKL9cqFooMbv2bl1JYavJFN8JoOzc6jabO9QACdkVzE8kOau7eZHwyHhtUyDDtZUwYuhPh7FkKKb3gbjHgLCGO0U6afAmBimWoxUT6dlQ8DbbUAvV/+BGeK0pVBL8xvIDfEirAONUaUXQ3311S75rRF12e/zYh7sdgNYdfjC6oTGOn7oztnE2n9Sr4ill/Y6uaRcDCEfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4490.namprd15.prod.outlook.com (2603:10b6:303:103::23)
 by MWHPR15MB1709.namprd15.prod.outlook.com (2603:10b6:301:53::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Wed, 13 Oct
 2021 04:41:51 +0000
Received: from MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::7d63:ef35:f43e:d7c2]) by MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::7d63:ef35:f43e:d7c2%5]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 04:41:51 +0000
Subject: Re: [PATCH bpf-next v4 1/5] bpf: Add bitset map with bloom filter
 capabilities
To:     Martin KaFai Lau <kafai@fb.com>, Joanne Koong <joannekoong@fb.com>
CC:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>
References: <20211006222103.3631981-1-joannekoong@fb.com>
 <20211006222103.3631981-2-joannekoong@fb.com> <87k0ioncgz.fsf@toke.dk>
 <4536decc-5366-dc07-4923-32f2db948d85@fb.com> <87o87zji2a.fsf@toke.dk>
 <CAEf4BzbqQRzTgPmK3EM0wWw5XrgnenqhhBJdudFjwxLrfPJF8g@mail.gmail.com>
 <87czoejqcv.fsf@toke.dk>
 <CAEf4BzbWVCz6RNKHVgqLYx8UqGUdDqL5EPKyuQ5YTXZMxt2r_Q@mail.gmail.com>
 <877deiif3q.fsf@toke.dk> <38d80c55-97e1-4cbb-cb23-d6331d8f539b@fb.com>
 <20211013001152.6f4ssugsebosrjh7@kafai-mbp>
From:   Alexei Starovoitov <ast@fb.com>
Message-ID: <68fdb5ac-934f-ee20-3469-e0f22d66b2a9@fb.com>
Date:   Wed, 13 Oct 2021 06:41:45 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20211013001152.6f4ssugsebosrjh7@kafai-mbp>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR2201CA0041.namprd22.prod.outlook.com
 (2603:10b6:301:16::15) To MW4PR15MB4490.namprd15.prod.outlook.com
 (2603:10b6:303:103::23)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:21c8::113c] (2620:10d:c090:400::5:4b7) by MWHPR2201CA0041.namprd22.prod.outlook.com (2603:10b6:301:16::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 04:41:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8927024-8c24-4446-51f0-08d98e03c641
X-MS-TrafficTypeDiagnostic: MWHPR15MB1709:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR15MB1709E9F8B52DBB98AAF3316DD7B79@MWHPR15MB1709.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cqtcbPO5/9tRNro8Je4HK09mKkiDhb7WrFwwtTZeZOcTpeIDyOGVDjmngPU5V2VXfX33GtdbKAz7C+Zy9mX2/uKT4XXkCmkET8v2uLeF1Ya7ba7rtbEp9hz+4piJznX7j8vvbpgNEkW8Lhstn46lqAgKOHobMa/AVFnanS9v6Hr6egYQSmX5P9iIc9XUBam4asJTmw2r0hQOgQzyKwVCrZCF8ga4UQXLYzBgjNyMVRP2MNyslORzwgTQLbgYaLsSCud8+RrtAm9kr5I5IsPs315GjSKDjirLfkaZbq/KmYe0X/c65ceygPEWJOQlzugZJD2QGt59uRb/vRVXHnnjtUm4i+ex3TEPouiU9gEVyELLgqIKnDNmd7PUbX5cORDYfAOIfYnlYhLA8ApUgHBV3YAXMpD4iUFqUHZyKw8k5fg2YXv/h5jSfXdht+9Gb2VFYj05IiizNePu7t2upJ931VyiN+MM87tSHcJooVc+njMhcYfGjBss87nHrfhGvVL1igKg58agRMgwczFwqWg9yfgFAZVqEvGvFvpPuvo1ACxu9eTgO9dtzP2/J+wnysnfgWhbycvdttQD1uswv4XlurRxzOVPYb9DjA/FJUJuRW8KAK69/WljKOVOQSTFR1LpXxAZdi6wQVHcVnBOV2d5JiZqJ7bwU6ELBNlThGTncHwupvpZMD7GpL3Usoodl1qEpl0DMMluLxVgL5ilE3i+3aS51W35GRa/qatB6KyRXc8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4490.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(8676002)(2906002)(186003)(4326008)(6636002)(53546011)(6666004)(38100700002)(110136005)(52116002)(54906003)(5660300002)(8936002)(508600001)(4744005)(66946007)(316002)(83380400001)(66556008)(86362001)(66476007)(31686004)(36756003)(31696002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aStTNm1WVlhuTWQzOThaM1dtSjRVdjdudytDZFRZcXNzcXpYeDgwaGlpSUhz?=
 =?utf-8?B?Q0JMMFhCNWdBOEFObzV6MUJqMGdmZWRsQm9XWGg0L0FwQmZpRmdva1Z6U08y?=
 =?utf-8?B?S0JlUjVqTTJWRm5ldkVYalhBY2lZamVySjlNRDVlc3ZrN21zVGt6dG5laTdX?=
 =?utf-8?B?eEhVS29ickpVc3VBSUh3S1RzaWplMVUwdTBUc2JZdy9MN1dPa2FlWnpFU2Ny?=
 =?utf-8?B?WlBtK2dDaVdKZ1RIZ3JaL0R2N25STmJncEFkVXM3amgxdEhRaDZsZE9HbmdH?=
 =?utf-8?B?WDZWMEJVQjN3MGJnRyt1dnd5bTd2MUtrUVo4MFJxeXgyTWQzV1h5d2NmU2Rt?=
 =?utf-8?B?d3ZOVkpFN05aZkRmSDNUTUVqWGVHNFdoejlNQlV6Q3QrRWRtVXVxZkhxQmww?=
 =?utf-8?B?SzErWDhRa1orREZaZjE3SjIrODYrV005K3Zkdk9NM3hBT0RKdlRQVVkrdGJX?=
 =?utf-8?B?K1hhQzFuUVBRRVd1UE5xbFB5cUhRZkR3WnlDWEhhcGhuMWdSMEx2V1BMUHNv?=
 =?utf-8?B?ektwU1ZyUWJ0RzBhQ1drcGNTMGhMR3JINHJ5RHZKdi9rRFhGUWZCK1kzLzVP?=
 =?utf-8?B?aUFpOHVvZlRFRnJmQUZXOUNXUWhWNThxRk1QUkNVY2xiSkRsdnNzRVluejJm?=
 =?utf-8?B?UDlUOXBvbVVOaGNzamRjS3ZpV1lqckQ5T1FLUVBXdDRSTk5pZ0RpYXY0MGRW?=
 =?utf-8?B?dGVIM05OL2pwVTd6cytlM1NCSFhiczB4OEZuaFBqeWd1OTFReUpVblpZU25o?=
 =?utf-8?B?VmQrb1M1UjZzU2xMNUxZTTBsL2hxSDFCd3ZOZWZiWHRWaXhNQWtIc3hVRzRv?=
 =?utf-8?B?U0dTRjdNSG9GQzA0NFQ5M0JQRVF6VmVIYWR2Uzd1VWRKYWhDMHNVRnNQdDkz?=
 =?utf-8?B?MTRjRnp2S3ZxcFZ1djZ0K1MvMzROcUtsVXk5cGQ1QUVZbVNvUFFpbXBqaGxp?=
 =?utf-8?B?R01CRTI2dE1KTk03WEtVZGxKNWhtZ1k5VGVBMXdKRnpESWtFRGk1c2orRjFQ?=
 =?utf-8?B?UmxxcU8yYjBVdk4raU4zTGtHR09lVkY2R1lDeExORUp2eFE4VHZlMTgyS29O?=
 =?utf-8?B?NjRJemJWM2hNNCszamFWKzlHanB2L3REeWlmQVF2U1Z2OTdqbjdnVndEVHpu?=
 =?utf-8?B?TjdPd24reWlPc2s3Z3pOcEVNWE0rcDNmOUdzT0x1b1pCclF4d0tQb2hoZnZs?=
 =?utf-8?B?VmFSdGhoVVMraE5aOU1zT3g4UXBZWm5uMEg2eThzeFBDSk1tQWIwVFA5TDFp?=
 =?utf-8?B?ZVlZck9iRUtpclJEYjdpT0hIMk1ac1YrMURreVdOS0Raakh4M3dyY3FEaTRQ?=
 =?utf-8?B?R2ZLbDFhRUQwc2VGaStJZXJHY0NCdkZZY3dMQVNBYjl0d1VEL0dhTVZiSXhv?=
 =?utf-8?B?Y2loYWJIS0taeFZaSTJUdTZMcHRXTEpZWGNCRERKQ0I1c1pUVUdNOXlhUWFz?=
 =?utf-8?B?YWxma0J4d1F5N1dIWEhuUnF6NTk2RTBYM2M3Mk52aXVQaDlETjVsREhINElK?=
 =?utf-8?B?UVI3aDZhbENYQW5sZWZ6VlF0NzFpTlV4dVZkQm9RWndsZW1DWGNEMm9mREpK?=
 =?utf-8?B?TFkzMFZwdDdBNEdzQWQ3ODFubHpHcXBHWXM0OW9XeC9VZnplbzNkTzVSUlcz?=
 =?utf-8?B?Wm9mdmVBY0pKd0xCTmhrMWwrS3lIRFc0STdlWGxXYi80SjcvdnV6M0FnK0R5?=
 =?utf-8?B?NkNHZ0c5Nzh5NHpaaHA0djZma3Z6aXV4aWc5ZUEzSXJwR2hRM3ZGQmpiNTh4?=
 =?utf-8?B?YWFHK3Z5SDArSXZzUGJIS0pJYzlmQWZxUEJ2NkRObkhYOHRKQzZVRE0ranFy?=
 =?utf-8?B?Q2FsVzJicEVBVisyRFp4dz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8927024-8c24-4446-51f0-08d98e03c641
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4490.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 04:41:51.3135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Qhd7JwunbQnr4pnDJFb7MCgE17ef2yvUPpIJC2RUkNf7hlE5TxTozCG7I+vxzQ3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1709
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: _gnOGpoAgrQvPynYa0G19YItKxhWNHty
X-Proofpoint-ORIG-GUID: _gnOGpoAgrQvPynYa0G19YItKxhWNHty
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_01,2021-10-12_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=897
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110130030
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/12/21 5:11 PM, Martin KaFai Lau wrote:
> On Tue, Oct 12, 2021 at 03:46:47PM -0700, Joanne Koong wrote:
>> I'm also open to adding the bloom filter map and then in the
>> future, if/when there is a need for the bitset map, adding that as a
>> separate map. In that case, we could have the bitset map take in
>> both key and value where key = the bitset index and value = 0 or 1.
> v4 uses nr_hash_funcs is 0 (i.e. map_extra is 0) to mean bitset
> and non-zero to mean bloom filter.
> 
> Since the existing no-key API can be reused and work fine with bloom
> filter, my current thinking is it can start with bloom filter first
> and limit the nr_hash_funcs to be non-zero.
> 
> If in the future a bitset map is needed and the bloom filter API can
> be reused, the non-zero check can be relaxed.  If not, a separate
> API/map needs to be created for bitset anyway.
> 

sounds good to me.
let's drop bitset for now since there doesn't seem to be a consensus.
