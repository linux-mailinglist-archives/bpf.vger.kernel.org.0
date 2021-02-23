Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5AB323188
	for <lists+bpf@lfdr.de>; Tue, 23 Feb 2021 20:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbhBWTio (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Feb 2021 14:38:44 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44586 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231335AbhBWTil (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Feb 2021 14:38:41 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11NJXXJ0026744;
        Tue, 23 Feb 2021 11:37:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=JqIahzmBZnDDH+7SMxCN4M5cPmyz3wr3Wwc27vgVTPs=;
 b=WDwKgTZytMNPMc/pgIcq1uLQ7sDZYRhsP+c82THkg1GTMm3RxmAGdgXpAFoNPSu3u+mV
 rnjrPxoSUw6k7TJeBQ9n8qLFCUXpOL5AClHIABhi0zairtw6Xxl5Vw0z8eMqX8o/Xb/J
 MMICOw7o5HJq9OrEQ7Dp8w/9+5vj8b5YUx0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36u14q83cm-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Feb 2021 11:37:47 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Feb 2021 11:37:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNeY+hw3sSMNsltxBqlYBoWevI1QAYre4YMMjhhAXT1qN1xS/MawXwj2FLt74YmBnbAx/4Jn2svVAj4NRb4lfqRrXlvZjrwG6TQpIcVf8qXLvfvt6xx7d5/J/Edx8qlfgN6F/agYSeKkos6MFnHnjgzcVYVPvBzDEoWD1GoxzQxpCIXamr80SdT9TayyX7ebTXj3vypCSrw4idTAOn8N3Kq6itb3AES8cnmiPZNEqZjMENpGDpZbmo3heC5uyjiPx6zofIS5GlknQbsd5l7GAQzUUUmzV9AR0zdFcA07QXXhlRNvJV0tTdxV5cQZ13SKUGhPZ9LVvfgCd56sybw5hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqIahzmBZnDDH+7SMxCN4M5cPmyz3wr3Wwc27vgVTPs=;
 b=H1CI7Dg5h/xlF2C8/EmCXerYLxwDyZxOlWyx+58bYIBOSBaljYLgumACB86N6VXli6wGtjnK0RRJpcmjNX/a+uCKXv+P4UNMZB6o8jOGK6+xxCf0xpuPJSfJfmwip77t1ocltbzrYbLUQekXhjCdDA8N4ozw1XFjgIdDdEb1N25pQG6K+x5PlhpWTywfYErWqX805m4ui/Ji5MdnHNTecTQvXMQnKrGlxmnFKETNzUhgPOSpfUJpaO4Gh5gsQNayftZhGN64kGMOHuqOeAbXG1ut5V0yVMZ7GHh7+wD3uq8Z2SbVsGH6O/ZOEWyGVCtUf+XCKUhMnS7WRJer9JpWKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2287.namprd15.prod.outlook.com (2603:10b6:805:23::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Tue, 23 Feb
 2021 19:37:43 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93%6]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 19:37:43 +0000
Subject: Re: [PATCH bpf-next v2 04/11] bpf: add bpf_for_each_map_elem() helper
To:     Alexei Starovoitov <ast@fb.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
References: <20210217181803.3189437-1-yhs@fb.com>
 <20210217181807.3190187-1-yhs@fb.com>
 <20210222205912.hucaxodzk7csrdyj@ast-mbp.dhcp.thefacebook.com>
 <083e0c5c-71c5-a735-63e7-4c5b8b1e9149@fb.com>
 <c837ae55-2487-2f39-47f6-a18781dc6fcc@fb.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <b45301e2-3c22-f12a-9e91-538363528389@fb.com>
Date:   Tue, 23 Feb 2021 11:37:40 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <c837ae55-2487-2f39-47f6-a18781dc6fcc@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c090:400::5:668b]
X-ClientProxiedBy: MWHPR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:300:116::29) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::10c3] (2620:10d:c090:400::5:668b) by MWHPR07CA0019.namprd07.prod.outlook.com (2603:10b6:300:116::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Tue, 23 Feb 2021 19:37:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa0fddb7-88a9-421e-7ec7-08d8d8327d38
X-MS-TrafficTypeDiagnostic: SN6PR15MB2287:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB2287D08F7A4961E4904BF342D3809@SN6PR15MB2287.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iCKaTxqLwlUBKqkO9jf6KdX7vvfb5U0eaPkDwflTo+4B/uA0pgwlVFsYcDoe4kAfdaNbThIMtskXA7Eq+uTBxDv+ZPJT7TmcmCUtFxB3m3bBbRr7hPcA9H+03h/yECeBBfWaWHgcFI3EieOBln87V6dr/OTLnlmCbLVxeoHMAvoeFWAWiE4kJN2lP+a3DpgwCcxbDaO8kbMLTU0w9I0MqBPeBYtyGlds1jSHTs3uURGowvB8qiqBKaLCefdpA5j3nosCRkW5M1k/xMZWMySK57JFieDnQhi6gHNecIIemIpjRykyupHV5KK5TAlVV2vnY/YaNn7K2hynkkaRw1ho51RY3rSivq079DCbly36LR9jkeyfn1wqF1NJRjVOZtekscJL9gWYhIB4YrrMOQMun68dwyQzjHZQnoe5RWLCbLJURCT7z+DUfLmDiyJIfZu9PIFLDOIyn9712gYRMpvOU/Zwv9flTqZKGkXxd3so/l4fF0Bkk/VnDPKJlcujpNhRwDBKyf7639tSmnTxGczaELHKB9dlUZSDY0hgL9cl+0jZar5wQ+Gg19DpQLXmepspPyGhlUfEYp/jIKHiLdj0EcJ0WfE+gAMVlcdMVGLEP0M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(136003)(39860400002)(366004)(346002)(53546011)(4326008)(54906003)(2616005)(186003)(8676002)(83380400001)(36756003)(66476007)(52116002)(66946007)(8936002)(16526019)(66556008)(31686004)(2906002)(31696002)(86362001)(5660300002)(478600001)(6486002)(110136005)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SERCVjZFSVovOW5GVXpZOWRzQk11Wk5TRkJ5dGJvWGVLM3dnL3E0RThjQTQv?=
 =?utf-8?B?dzNvOWh5K0pqckllRGtMQTIraE1nbmNoT2k4bUg0bVBOdWs4KzF1VVRFTDd4?=
 =?utf-8?B?U1V6UFl2RlY1V2Y0WHBXWkFYTk1hMWF2U042N2E3OUtWbDZ5SUNIV3RoTVcv?=
 =?utf-8?B?Wk42N1pVbHl1NUJkWXNjTlhUYzdKOWVUWS9VKy9pdE1NYjR0eFpoUmt0NDFW?=
 =?utf-8?B?UDlDZ2diblBRZDVMdU9hS1hNNXVlWlZFVS9WR3V2dngzMmVQUnI1TjFCYmxt?=
 =?utf-8?B?M2NSWEh3K25UN2YzaHhGMVFUaDBuNENkRHNxOUx4SnM2RUk1K2ZiUUZJYnhk?=
 =?utf-8?B?S2I0dTJtdnNtOWhYcmZldm01Vm1vM3ZYa0VpL0VtTHVzaDVkOTJWRE8zYlB0?=
 =?utf-8?B?ZTRydjJua2wvMDBIcU9pSllVMnVEUG5TOGxFcU9hdDJ2VXdPWUEzSW5rYkVP?=
 =?utf-8?B?R2hpZktpalNkemxGQlNkOTFnd0w0Rk5EMzhSZk1wbWdVSG9NOWlOMW1LWUVW?=
 =?utf-8?B?YktNb3I3b2VaU0FveFFBNjBBTW1CbmQ4emNMemdwWXVxY08reHhFbzFKUStE?=
 =?utf-8?B?VFNqUjFET1JQSy9HOHpQL0FlblVpcFlldEw1VjNEMWRQZnNPMnlIblBaKytx?=
 =?utf-8?B?MktFV1dOamZlUEoxYTlRc2x1U0cwMnBzRmJwQmltNnNPT0dyRXFDU2IwNVBw?=
 =?utf-8?B?ais3RnJHY0FHa3duaERMSW5keUJ5akJqUXJ5NXh2ZDJtcDJna0gyekxoMmha?=
 =?utf-8?B?S0ZZamY4cVJ5VWgyTzB0VUk0WnRVcHc0dzlYZllvbmhMRW03OWpXaUszRHZm?=
 =?utf-8?B?eFB2SFYxS2RqYk55QUp2MWtGZDduTUtwT1dhZzY1WnAzbXRnWnRFK1A3eHg1?=
 =?utf-8?B?bms2R0pqOXdoZVZxUGFBekhOS29ZTDZCamdQTm1pOTdKSEJuQVdEbE5TZUhI?=
 =?utf-8?B?TVU0VWRjWmlsaWt3b3hrajZMd3lxS3ZaekJzUkFkSERISlMvQ0wrUTBIekV4?=
 =?utf-8?B?VDJ1bEJ3Si9jT012UUxkYlkwbVZCMlhWbE1HTkNXTllnT05scU04N1IxdUpC?=
 =?utf-8?B?eUJ4TmlHSnJzejF4dTdTQnZjYlBId0hIYzdrZ21UTE0vS2REK25pZUpibCs5?=
 =?utf-8?B?aVFpTXlNZTBUYStPcXFDdzJ0dUsxblFKNTdHVVhvNk9aUFcvUytRYzI3c3hC?=
 =?utf-8?B?OUwvM29IaVVnWHhUZlV2MnBGL3g3bmtQMHNTd2FIKzR3ODV2bStWS05HeFdG?=
 =?utf-8?B?cm05NmY3ZXdrUi8zaW1vR3lTY2VlTnU1TEFQWEJYM0R0WDFLWE1DaWhoaVpV?=
 =?utf-8?B?UnRtTVRSRzljSXpuOEdCd0NGU2lubEdoZnpadHczejlWaGIvK0JTVUZsbGEr?=
 =?utf-8?B?NWwvb0crWlE4MHB4a054Q2tSU0w3L1YrTzN4RWxvV0lxcVV3YW1mdkZlQi81?=
 =?utf-8?B?ZXFlSml5ZHdHU1gzR081elYxQmt0cTdLMFg1VnJWVEJKdVlDaFNGSlBTd1NK?=
 =?utf-8?B?eXBVLzZSaFJZcWhRMTFwdURqVDFScmtHOThUV0NZMFQ3VGV0eEtkbGRwak9O?=
 =?utf-8?B?cEwzSmZBazg2a0s1aC90NnM2eVJJemhpR0F4RWJUOGNvMTNPZXhrTWpHWUFV?=
 =?utf-8?B?NzVJYWtabnNIQnJMOTRkV01Cd0FibThpT0hBOTZuK3JtS3RhYWZmV0lpdi9l?=
 =?utf-8?B?Q205UERVQzhNc0xueW4wK0RPTjNzNlpsRjFhc1JFdjMxZUNvdzQwdjZQMDJS?=
 =?utf-8?B?eGRVOXF4M0pRZG15VUFXeHJtYnhTQXBrNlo4bG5VWmJjT2VHMFduNURobFFO?=
 =?utf-8?Q?bxo+ld5qBhYNUwEh2FeMRDDCe8LNtA1JuWLW0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0fddb7-88a9-421e-7ec7-08d8d8327d38
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 19:37:43.4783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0us8loTvn3Xh3G8RDGKLk6UdbJOH86JqTUeaN7lTB80lP/EB6BRh6bHfkZSNkRap
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2287
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-23_08:2021-02-23,2021-02-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230164
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/23/21 10:46 AM, Alexei Starovoitov wrote:
> On 2/23/21 10:39 AM, Yonghong Song wrote:
>>
>>
>> On 2/22/21 12:59 PM, Alexei Starovoitov wrote:
>>> On Wed, Feb 17, 2021 at 10:18:07AM -0800, Yonghong Song wrote:
>>>> @@ -5893,6 +6004,14 @@ static int retrieve_ptr_limit(const struct 
>>>> bpf_reg_state *ptr_reg,
>>>>           else
>>>>               *ptr_limit = -off;
>>>>           return 0;
>>>> +    case PTR_TO_MAP_KEY:
>>>> +        if (mask_to_left) {
>>>> +            *ptr_limit = ptr_reg->umax_value + ptr_reg->off;
>>>> +        } else {
>>>> +            off = ptr_reg->smin_value + ptr_reg->off;
>>>> +            *ptr_limit = ptr_reg->map_ptr->key_size - off;
>>>> +        }
>>>> +        return 0;
>>>
>>> This part cannot be exercised because for_each will require cap_bpf.
>>> Eventually we might relax this requirement and above code will be 
>>> necessary.
>>> Could you manually test it that it's working as expected by forcing
>>> sanitize_ptr_alu() to act on it?
>>
>> I did some manual test and hacking the verifier to make this code 
>> executed and it looks fine and verifier succeeded.
>>
>> But since this code won't execute with current implementation
>> with bpf_capable(). It probably makes sense to remove this code
>> for now and will add it back later once bpf_pseudo_func is permitted for
>> unprivileged user.
> 
> I think we might forget it later.
> I would leave the code here and maybe add the comment that it's tested
> for future use, but not needed yet.

okay. will keep it.

