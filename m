Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C0640452A
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 07:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhIIFu0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 01:50:26 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:13708 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230515AbhIIFu0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 9 Sep 2021 01:50:26 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1895SfVf021896;
        Wed, 8 Sep 2021 22:48:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Jvbq7v93py/p9QtXlxA2B2wUPZgD3xzHRURTsHKuxmg=;
 b=mmE7fD9zosUQVWiyINRRWPj64lTzbKx6qam3wiEN3uHIfcg7PL6M9wAm6/6ihKEtHAwq
 aPW9v7ae5L1ISSR3gF+OvPIFuE+tG/3JKu6GCH+s5R0frQigIXDMW70hzZNjaKtoMe2d
 4kLfwjBH4Hv/PlRsYIdY7Q6MrYoxfCNvhnM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3ay95w0yrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 08 Sep 2021 22:48:37 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 8 Sep 2021 22:48:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S2Js6+TzdXv3AF3SCK9BPJzoId0S8BuKnhhXhqA8f4rh/CK2gf6xOw8hDI4SCSlyh36N6jpn+Ro2w9T58rwpjJkKsFj3ftSHwqkZujDxTOHuyBr8V6S2l8tePYOpMLVvjUEUzJRN850DyybkXkQJyZx6qW5slp7HsVu8m+/TDTNE4DkYZTEoJafah0BSI9egE6EPL+o0MDqBjUafWHmHseJAHHcQqjnvHYMoLX7rxhVOxDrBjgd0Gu8R+FFCyUK4L95OYZEbnN67dDHYSJPxx0eWpgCNXJPjphiO81Qc9UTAQcLeSp3+Cg/eDxsXKFVS84h4SmNQ+jZSLwb+2eHBow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Jvbq7v93py/p9QtXlxA2B2wUPZgD3xzHRURTsHKuxmg=;
 b=O6Cnx4klrqFyNtos8GpxwNVNVb28Hjaa3iIxSlvCQDUUKsmc0RNzAzJTHJJNP0SbinYG39CrxGQxvVN1u2cszfqNC+mKWUT7TA+thM3UtRDzn4JgguUZQ3nLcFegJKOIt/8lkdJevwUpOFsv9UPOQjCrETY/hQPV0LUDKNq2LTUJz7Pma/N9QsUFw9HCaMn/6qwoMb5fg2DSFNG+yEEexNhkUKi/3WOFVMv6+AfgcgOh3FwqX8JyRVZUOxXt/TMe9Nm/K0x91grUjcnliFbQiJF+e5+sHl9SZnJze9ECGxDSwMXDaE/El8mNsItW7wXSwVCDwIVIEk3TLbsszEC/eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4869.namprd15.prod.outlook.com (2603:10b6:806:1d0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Thu, 9 Sep
 2021 05:48:36 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4500.016; Thu, 9 Sep 2021
 05:48:36 +0000
Subject: Re: [PATCH mm/bpf v3] mm: bpf: add find_vma_non_owner() without
 lockdep_assert on mm->mmap_lock
To:     Matthew Wilcox <willy@infradead.org>
CC:     <bpf@vger.kernel.org>, <linux-mm@kvack.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Luigi Rizzo <lrizzo@google.com>,
        Liam Howlett <liam.howlett@oracle.com>
References: <20210908224438.391816-1-yhs@fb.com>
 <YTlllQenVPeNNxIF@casper.infradead.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <32541976-4556-3927-de8d-9723080960aa@fb.com>
Date:   Wed, 8 Sep 2021 22:48:33 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <YTlllQenVPeNNxIF@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0319.namprd03.prod.outlook.com
 (2603:10b6:a03:39d::24) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:21d6::108f] (2620:10d:c090:400::5:fa3d) by SJ0PR03CA0319.namprd03.prod.outlook.com (2603:10b6:a03:39d::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 05:48:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0411267d-4827-4aea-751e-08d973557724
X-MS-TrafficTypeDiagnostic: SA1PR15MB4869:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB48693907C55F218AB34C51C0D3D59@SA1PR15MB4869.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BHTWdsnwE6d3Du9UVySIXqzbWwbwStfP5tukYq3L/EgsTo88hcDrbzN2FtubOthwRqTgDw2Grvew7MD3oFMcjQtbfZX58OYXblHN5mK61SVcnQ0cyruTKsxsWE1Z2boEpM5lbwjRC4ITpnqLH2+0vu1sBtd1hqxHPL5ZMAf8ffcKVjye1EU2ZlZJccSdtTokvLQVJIjXIIomIk3vEOL2uTMYAlJ/dibRP4D0Iw4kxrPQmP+BPWP8J8IoJoHn3qwzxELsuV3Kwvem06CxdiwWFeiHyMjINrB6L0sEctiDTeJAs9aHPn18BKPg3oHRx4Jzr4rdzickZylwQ5CsEN67zomYQujZiTpQwHz8Tmxwiuri4ss/8Iu1zzEB1eUoSl8UYOsmvb6I3v8jkNLsI9hkDCkDXlwvtjxfSfyxAOGOhmYz1kK0yMoiuq0Hlr4tuVZKtmefE9PfycVODowkjZ9+Fapb6LVdWWXzP7INRyBiiYaAMv7QyIefkyltB5J9AzGeBzuwhL3JcTwfGIU5DzA68ZVHzxC6A125Wpm5PdqgdWO/eBYKIl15TGFimPvndvTN/TAgX28ySdjT/HcMfbyCQH1xthV6y8f5v6OZFT4pIaKnI/DKMz1hPy6aRivfRdwZXsr1wn254lwyxCEMmxCrgcGmUHjbawQqx8N5tpiXrcu68WL+8zkkPTE2AcGvGWXGKRXoVSlqvyKRISPHzUsdX5buh62NqkS5XM5jvjr4X3Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(2906002)(54906003)(8936002)(83380400001)(316002)(38100700002)(86362001)(478600001)(2616005)(31696002)(5660300002)(66556008)(66476007)(52116002)(4744005)(66946007)(31686004)(4326008)(6486002)(186003)(36756003)(8676002)(6916009)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTdiWWlmL0s5NEFQcXpTOTNiV1JVclRndVpJTWxNYnl2c3NNR3VQcnR4NmN1?=
 =?utf-8?B?Nkg1bVFNTUw3UDkyeVV1M3dreDY1Qjhpa1pOU0hqUkhSeUVtR1FtUEh3Z3Vw?=
 =?utf-8?B?dVRnblNBMWJHTnNLZHhSeU9TbndVbTRhRkM5RXlqMlRTcndOMnZPT2gxeUM4?=
 =?utf-8?B?MXoyZWRWb2FmVUw0WTZBbFFvR2JaVDNCNzV3dzBueGxvS1lUVzJxNHloeXBV?=
 =?utf-8?B?MkJhWkQ4OEMxRG45TVRjdUNwOS8rcWhZeWcrUzY3akN4Q3g5Mll6eEhzNnZ3?=
 =?utf-8?B?RTZJVWh2Sm5lREJ4K0VVRjViWjVER0dVNnBlYjhySWlaTG5STnQ1OElseXR4?=
 =?utf-8?B?c0ZMd3ZNTkJ5UFd1Z1hpYXovU3k0dW5JUDBkb1Y1ZkxHTXJtcDkxZjdyM1U2?=
 =?utf-8?B?UlNmSHFuWVZoNmhpOHVUUnpDMHJMTlhmTlhqdEdVaTRDOGVaRzR1WHJtUWdQ?=
 =?utf-8?B?YUhCRi9BY2lueVgyVUJVY2cycDJGYjVmZzQ0SXlCcms5UTg3SzNjcGZBdmhU?=
 =?utf-8?B?cWhXNnpSc3BZUHhZZ1gvZmRZMmpxVjhSQzdOTmowQ1BBVElnMENBMHl3c0J0?=
 =?utf-8?B?b2xPbGhHNGY2NEU3UGp2ZjBKTU9qQjRTUjIwK2hmQkJGWGhuTGdLRnNYYU9W?=
 =?utf-8?B?RXNWWTBvdVpjb3dTT0x5VTVWZHFXOXVuTWM1N3E5YlM4MmY0VDR2TlNieS9q?=
 =?utf-8?B?K3Z6aWtLUE01em9oYlZaeDlhN1BUeEZRUktnQjkxaGt6T2VidGU4R0p6R2Qz?=
 =?utf-8?B?ei96TW9VV3prUmVUeFl4ZlQxNXdDTFVpOHZWL2srZitHTWJqRWg5aUNqeTg3?=
 =?utf-8?B?cWJqOEFHWFlQOU1yZUZjSEREdXl6dTdRNTlPNDZVU29DQXhFTDVMMGtiN0k1?=
 =?utf-8?B?OU9mTnhhUEd1MjBzMkRMN0VIdmMxWGxPemFYVDRaQ24zMDlTTTlPeFYrV2Zm?=
 =?utf-8?B?akdjRTdIcU5FNC85MFIydWE1Q0swcWl5dW9OU1hBRWNjTXN4STU1RWZYNFJv?=
 =?utf-8?B?M3M0RGtnaTQ4SjFKY3FCSHBBdWh1eEJYd2F1dTNzZ0RORGk3TEZRNEw0K3ZO?=
 =?utf-8?B?T2pRbjlKeWRkT3cwM2VER3hLUU1RTlFrc3RadUxZNEUzMlQ0WDB4eFJ2UUNU?=
 =?utf-8?B?YVgyNTgxVS82Y0p4dWloUmM4NkhtbDMvQkVCaDhxWEdISTJTeUhQY0JCUFNi?=
 =?utf-8?B?TitabUVvUllXNkxnaFVUelFDa3hTeEkvekp5aDJSczZmSGxaWHJ6TG9WcVB2?=
 =?utf-8?B?WE8vTVFyekxwZngwTmVvQ3h0dWt5RHEvT2hCMjkrZU9LeE12RW1pRjQ5Wjh2?=
 =?utf-8?B?dEgzdGFleFkwRVkvS3Y3ZktvR21NSWtGMnU4bkI4V200VWJLZGpHeVZoMWpN?=
 =?utf-8?B?L3JhR0xQWkljbGY3Um9oR1ZZblMvRy9TRS85UkpVZFk5ekVqNUk5OUR4dUlM?=
 =?utf-8?B?c3dWTWNaNkhvT0xwTlVPTGFjbFNqeTc4OXFiTytwZDE4aEtVK2J3NXJlVkpM?=
 =?utf-8?B?TUdiVlhTYVI1SEduSmUxcjVleFpMOHVXalZNRWhzL0dZNEhheExQZWIzYTNJ?=
 =?utf-8?B?YzlCT0FsbGpyT3IvZXlHWFVXT1p3WlNWY05tYVdEdHhkQTJrU0JvYUxrd05Z?=
 =?utf-8?B?Qnc1dlRGb3ZXVHdBSmMvUHpicjF2Z0t6aTJMVVBReXlEOWtiRHVGbGlQZjJX?=
 =?utf-8?B?UE5UVjE0alpTTWwwUEdmV0xRc2RPNFpNVjg2dkk5S2hGTmhnQlNOeWt2cjNC?=
 =?utf-8?B?emtZRi9WNkdXbTdyeGd2S0k4QlRrNlZXd3VKUUNvSm5ndElNWDBiUTB5SDcz?=
 =?utf-8?Q?zHfGp7FfRsFtuGotAjkHqsIFyNYy0jHtHq74Q=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0411267d-4827-4aea-751e-08d973557724
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 05:48:35.9847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V8yWkNOJKBZwNdYZnzDOF9CMoMfMo3DF6XWsrLU2p8lsljksFzvO2LKOfaAHmXNt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4869
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: q9ka4lk0dcYdoZc6IeN88G8vGZZ7rQs1
X-Proofpoint-ORIG-GUID: q9ka4lk0dcYdoZc6IeN88G8vGZZ7rQs1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-09_01:2021-09-07,2021-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1011
 mlxlogscore=735 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109090033
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/8/21 6:38 PM, Matthew Wilcox wrote:
> On Wed, Sep 08, 2021 at 03:44:38PM -0700, Yonghong Song wrote:
>> +extern struct vm_area_struct * find_vma_non_owner(struct mm_struct * mm,
>> +						  unsigned long addr);
> 
>   - extern is deprecated
>   - no space between the '*' and 'mm'.
>   - no space between the '*' and the function name.
> 
>> +struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
>> +{
>> +	lockdep_assert_held(&mm->mmap_lock);
>> +	return find_vma_non_owner(mm, addr);
>> +}
>> +
>>   EXPORT_SYMBOL(find_vma);
> 
> No blank line between the closing '}' and the EXPORT_SYMBOL.

Thanks for your comment. I just followed the original coding style for 
the above change. BTW, I will have a new version anyway so I won't
touch the above code any more.
