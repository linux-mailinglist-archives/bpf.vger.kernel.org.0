Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A4143F54C
	for <lists+bpf@lfdr.de>; Fri, 29 Oct 2021 05:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbhJ2DUO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Oct 2021 23:20:14 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:22802 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231600AbhJ2DUO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Oct 2021 23:20:14 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19SIiqGb022370;
        Thu, 28 Oct 2021 20:17:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=K/r5IPZ9cR0vLAE5BiJdF3G13w9VvLDI2lBmk8Y9jWA=;
 b=Go9V5i6ZoUM+Nx6GiXnJkSBoMzSBSZ0Khm1m3p2s9lWBLqYcM9ugMUZ1ghAhUXJme5cB
 ph5ng9e0Joq/0WHWjoGB0n6tmJrf++eh6Wj0K1bSEh5xm+AnKzhahOd1zw0QHFWMJ4+x
 l0kWDwMiD+j3M1LRHXpMvfojOYeyim/LfQs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bysedpkny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 28 Oct 2021 20:17:33 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 28 Oct 2021 20:17:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S21N5zX5ICqTm8ov0vxyjo946zxHUyUdXFYkIRD+DzqdRa0AXw+13HrR4ViNipMT6nWSpMNLC3+kqZWv5mC3EYt8+4CZ1jEWLvDEataV12eA/RmI1yYn59or5Cvz3w5HKZlG4Gh7stYARs3fttUK7Zb1qY8wwDiM0T2WcY7uz8Nl/HsfQrDdDp+Q65Fqne0+ulkf2cjBugaFYW3ussQrRh54hafBVl2xxVbp5wFreeckc3jK/usg+a44f0dcUZwyTr0H5B2CH3VVhmpk2/XnJ3euZmsRgojpL8aBuN0HX7QrA6qSFqEj2w7QUfQS/swM/ANoqWTxaIjxoX14HfV8Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/r5IPZ9cR0vLAE5BiJdF3G13w9VvLDI2lBmk8Y9jWA=;
 b=VHY9m3Df4fxlu328KzGOs/3bgDiTtaQLxYZqwiA7A+Uosei3lkjcIGFqPTeJAVYHQ0wIYm3iYIRmNNE3hBR3tNK15UcGfgevbi0i0ROO5YRucXFHY/P1yPX+4HDRM7AoDFmyM0498dVjSq/CqTuss5eCpYUtCk1ZcLcsD8YZCwj5fwmeZqpjFyfzt/nvsWNf+1Af0fUx0vmk7Zof9plGTrmCC6rFLSzUQ2VeuRIfzYQhHGxQJms/MfUkyOnqA9M/Z8ZOQ1T+xA9GkwGFNGpQyZgPzxX6PV3noxIQBRn6au5AWtSimMg4bXiVoDYpdlGl6eFGuq/5WRZMS3+mmzLjdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB4465.namprd15.prod.outlook.com (2603:10b6:806:194::23)
 by SA0PR15MB3934.namprd15.prod.outlook.com (2603:10b6:806:87::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 29 Oct
 2021 03:17:26 +0000
Received: from SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::49cf:2655:67d:7b2b]) by SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::49cf:2655:67d:7b2b%7]) with mapi id 15.20.4628.020; Fri, 29 Oct 2021
 03:17:26 +0000
Message-ID: <8ff8008f-baee-123c-d61f-0fd0140ff50d@fb.com>
Date:   Thu, 28 Oct 2021 20:17:23 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH v6 bpf-next 1/5] bpf: Add bloom filter map implementation
Content-Language: en-US
To:     Martin KaFai Lau <kafai@fb.com>
CC:     <bpf@vger.kernel.org>, <andrii@kernel.org>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <Kernel-team@fb.com>
References: <20211027234504.30744-1-joannekoong@fb.com>
 <20211027234504.30744-2-joannekoong@fb.com>
 <20211028211424.m5y4kafaulvgke54@kafai-mbp.dhcp.thefacebook.com>
From:   Joanne Koong <joannekoong@fb.com>
In-Reply-To: <20211028211424.m5y4kafaulvgke54@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR14CA0012.namprd14.prod.outlook.com
 (2603:10b6:300:ae::22) To SA1PR15MB4465.namprd15.prod.outlook.com
 (2603:10b6:806:194::23)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21c8::1716] (2620:10d:c090:400::5:5753) by MWHPR14CA0012.namprd14.prod.outlook.com (2603:10b6:300:ae::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 03:17:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58669b82-022e-4a4d-7c58-08d99a8aa1d8
X-MS-TrafficTypeDiagnostic: SA0PR15MB3934:
X-Microsoft-Antispam-PRVS: <SA0PR15MB393411EF73A98C1B5A89AE98D2879@SA0PR15MB3934.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rFrvH9vype6i3xouW2bu7nZ8JFDeLEbp4Y2UcuAXJR5WOSupIBoagTiJPvf6IzolQk7PgMxhAJUlV7kS29rxwhrGmtLROCjKZ5JVBxvBnRh/QeHXGGmRJN3X+XGu47J/C6yzhYfa8oGBvgA8n6p+vlZ4YP6R6M5vSPTRyXDfnxLPxkQqUvhFNO0CJETFrB8G6JjMcXkMzwPU6zYF/vEdsQnIksvuSEvgTYe+uxDH+QEiRciowNSgTmbKOnb5NTivdOqY8D+nYOtETUT5jGeqV7Ylfrh3rxT/MkOKsZWhCrMLFsSZFrNo/dBbf5usS632LpFLxovPwvN/0LB0w34iN9+gEQ6/irKXfLgDSav+iyp4UI7iBx2P7dO6VzRNulp3izrD++oHRdUI1K0pdajsWgC6cOUe2N6PpvjBb8342maC/AtxFdFcCnbOCZ1jTUQjiz9Jym4T02T3PvxxIfAdYIhOM055AiegaX8DOHZSjEqxEYIS3zcvR8FsOLwsuEoIYzEwfgEqWw46w3c7Ovbo2ku+ls7dHDj++EObmtq4PD9WbgkpZPygf9UHaARUlf5nkEaH9GaPKJKeqDy/72vUgIVJsGL9LJZwnZekj4gg4CA2cQRPJt0CmHwqqb7mpv0HL935fNliF3kF9uYKrrE1HrUG9MI8xkmMnhy6dybEfwxiYpfZ7XuNF/krcOM5WfIhoNxmuPgpZRr1yoZHiLWJINrtWxJiIoow/bhT80vvmuE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4465.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6636002)(2906002)(31696002)(31686004)(66946007)(186003)(66476007)(66556008)(8936002)(2616005)(316002)(36756003)(6862004)(508600001)(8676002)(53546011)(38100700002)(4326008)(5660300002)(37006003)(6486002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K05OcEtlK29ZcTRHUjA5N25GdUV5MlpLTGcrcTRpNzV3eU5XMWtGNmFCN2RY?=
 =?utf-8?B?aElNVnRhbHQ0YnpvQXBFSDVtdjl4TDJSbThoWHBmczNBclV4SEVsYyt5c3o1?=
 =?utf-8?B?SDlTaEZqM25aczlVaEpQOERiRGhoTnFzV2pUQllzN2VaNVoyMWtrY0hlTVdx?=
 =?utf-8?B?dWk4VEovYXk3VnhtTWdoNmQ3Y1IzREpNMDNJQ0RwT2llc2hFcjJCejdsNVl0?=
 =?utf-8?B?WmNvWXp3WjZGWXR2czZFWi9IdnlMaVM3OFlkb29ZMjRuODVWTk5YOUN6bzFR?=
 =?utf-8?B?QlpWaDNKOGR1c0t5SG9tTVdYQ0MzVHZIQy9iTDZxQTZlbnJCUS8wbUNwRU1I?=
 =?utf-8?B?bnl1MHAzOEVkWUV5d0RMcWhuUU9YdlRXT2FTSG1hRnprNUptRjhjRE9jVlkr?=
 =?utf-8?B?UGFKcUU4dWcrbFdOUDFSeWdtQ1IvMTJqbEVGR20rYjFHeFAzelVzaDlPMk9Y?=
 =?utf-8?B?allyZVlRUjNWVEFTWkNWWDNmSHNONWcrVDJiTElma2UvVXEzSGVlNHJOcmlG?=
 =?utf-8?B?MlJScm1OWEhQN2Q1UGw4WHd5SzIrN1RzN1pKbEE1QkhXOVllaVR6bWh5L01s?=
 =?utf-8?B?MkphQmI1eXc4N0R5UWhtemxjdXl6RDJ0dlhQUzhjYnpQeGU1WmtVTER1S3VZ?=
 =?utf-8?B?eDN1b1d3d21waFlXZlJwb0ppM2U3ckdaS2l4K0ZhVE5FM0tFSG83QXNCd3p0?=
 =?utf-8?B?RVhDVjRrS2ZxWlRQcURTT2VwSEFlNTFQZGtYMkpMdC8wQ3pMeUhzWE1DUGpv?=
 =?utf-8?B?VHRsak1EMDRRVVpZM3lkcTBEN1hGd0hXd2lhN0hEdFc5aG1BQkVvZm81OGkx?=
 =?utf-8?B?QWQrcEpyeVpPY2NZUnRVbEpWcnhXUnlsSFcrb21HdHY0OWo2bm8xTTdBd2FU?=
 =?utf-8?B?d2IvV0JFRWlVZlkxSXlIMC8yU0h0ckVER0pkZUFPUmhjMnRBMHFuNG9ONzly?=
 =?utf-8?B?TkM4Qkpob1lQUlJoUVFtUFBQTTFtczVQY2RVejZzZjJBSmUwdWswRnpFajhi?=
 =?utf-8?B?dmZuWlI0dE9venZaclh6eGo4aWxwSXF1ZHBYSHNGSFZ0SS94eHNSZ243NFY2?=
 =?utf-8?B?ME9JdXF3WHl2MWMwNjhYL2RMTExMWWhNQ1BFQ1FrdFlXK1hXL2pneUF6TWJY?=
 =?utf-8?B?RmNSUEQ4SUhxSis0dFBUcmFHWE45REt1RCtDellDN2JIM0FORjFhUGh6OU1H?=
 =?utf-8?B?WmJ0RS9EUGRvRHBtYmZRYWdhbXIyUEZxUUFoTnR1Vjl2NlNjeEdaWENYVitE?=
 =?utf-8?B?c3BzbDBPekY0TWRBbFlhM2FwLzRMK0NCSlhMRlpnOS82TmZ3ODhUUkFvTXIv?=
 =?utf-8?B?RGFEdUZ6RXhEekQ4b21uYUtWY1I2TnRwSEJ4Mi9lYWJSYUwwdDk4R1V5V3FR?=
 =?utf-8?B?aVdjS3lXbjcyQlhhMlVEWEZpNnROclB5d3lsS1hhcklrWGRkcUdBQ3dONVZ5?=
 =?utf-8?B?OFU5RXNnREtKc3dCci9HNWpSUWM0UUIwd2U1WjZnWDZmMVI3Ly93dmVPVDZF?=
 =?utf-8?B?OGcyeFJGOXdRM2lWMWtaUm5oOEtGK0FubFVSbjFBd1pGaDFjY3lUOWVQeGlC?=
 =?utf-8?B?ZEJQdnFLbzJSaFhWRTgrRzloTHBUdHYxMkMreDVQZ3FFeGtGckZwT1h1Z01k?=
 =?utf-8?B?YmVkTHdZNlkyZUJsNUlOZ0RSeFkwamh3K3E4TDQ2bkVIcW5lbmJCaDh1TWFz?=
 =?utf-8?B?dE9lcyszamFvSmI5bTJmRCswNDc5TG9DTDYrV3YvR2ZpLzNOVWpDTXlMYlVS?=
 =?utf-8?B?OG00YU4wL0YvYm5ERGtnU0lDMjNkSjgxVXRabVI1MytlRWl2Z3hHL3dxb2N6?=
 =?utf-8?B?T3VIb1ZpNVZ5OFM1WFcrQkRsNnJSL3dvbWFYVTM0dTNwdVBmTitYS1dJb1VC?=
 =?utf-8?B?TWtVdEpQUUZFek5xdzVrZTRZWGJrcUtDUU1HMnZRdzdKY09Xa0ViektvNXpM?=
 =?utf-8?B?YkZ6MlNmeElSakxueUdOTVlreTRDMEhaY2dWMlFKVmliTmhVVWpWL1RHTHQ3?=
 =?utf-8?B?eWo5K2JobVRFdXFsQVRETFBsQWZoaDRRZVgzR2kxeGRoYm5XNkY3RnR6cTd3?=
 =?utf-8?B?dWFERENlOERpK1g0SDNVQm1vU0M2R2o2Ym5DWDdmOUlLVWZtcUs4VlBkcVJR?=
 =?utf-8?B?enlNci9qQjJjQUxadFhpZ0dTbDBpKzBmTmxPNWFORDE2QkVRM2NyUGVxbFdF?=
 =?utf-8?Q?iLeXHbRA6OunnDrntf9Izg+9pjBWLvijq1SDVOeBbM70?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58669b82-022e-4a4d-7c58-08d99a8aa1d8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4465.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 03:17:26.2453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E4qm/o16JMmWDuFQHpOFWqr75AKR228AUZjLRIZ1fx/z33i70tjFN7NbNpwuUgNvuzYRq/dS8peeeWrbJ9sVSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3934
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: AWMO05SyoARaePyY-f1sbjZXljeHxZf1
X-Proofpoint-ORIG-GUID: AWMO05SyoARaePyY-f1sbjZXljeHxZf1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-28_06,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110290017
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/28/21 2:14 PM, Martin KaFai Lau wrote:

> On Wed, Oct 27, 2021 at 04:45:00PM -0700, Joanne Koong wrote:
[...]
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index c10820037883..8bead4aa3ad0 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -906,6 +906,7 @@ enum bpf_map_type {
>>   	BPF_MAP_TYPE_RINGBUF,
>>   	BPF_MAP_TYPE_INODE_STORAGE,
>>   	BPF_MAP_TYPE_TASK_STORAGE,
>> +	BPF_MAP_TYPE_BLOOM_FILTER,
>>   };
>>   
>>   /* Note that tracing related programs such as
>> @@ -1274,6 +1275,13 @@ union bpf_attr {
>>   						   * struct stored as the
>>   						   * map value
>>   						   */
>> +		/* Any per-map-type extra fields
>> +		 *
>> +		 * BPF_MAP_TYPE_BLOOM_FILTER - the lowest 4 bits indicate the
>> +		 * number of hash functions (if 0, the bloom filter will default
>> +		 * to using 5 hash functions).
>> +		 */
>> +		__u64	map_extra;
>>   	};
>>   
When I run pahole (on an x86-64 machine), I see that there's an 8 byte hole
right before map_extra in the "union bpf_attr" struct (above this 
paragraph).
It seems like this should be padded as well with a "__u64 :64;"? I will 
add that in.
>>   	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
>> @@ -5638,6 +5646,7 @@ struct bpf_map_info {
>>   	__u32 btf_id;
>>   	__u32 btf_key_type_id;
>>   	__u32 btf_value_type_id;
> There is also a 4 byte hole here.  A "__u32 :32" is needed.
> You can find details in 36f9814a494a ("bpf: fix uapi hole for 32 bit compat applications")
>
>> +	__u64 map_extra;
>>   } __attribute__((aligned(8)));
> [ ... ]
>
>> +static int peek_elem(struct bpf_map *map, void *value)
> These generic map-ops names could be confusing in tracing and
> in perf-report.  There was a 'bloom_filter_map_' prefix in the earlier version.
> I could have missed something in the earlier discussion threads.
> What was the reason in dropping the prefix?
>
The reason I dropped the prefix was so that the function names would be
less verbose. Your point about it being confusing in tracing and in 
perf-report
makes a lot of sense - I will add it back in!

[...]
