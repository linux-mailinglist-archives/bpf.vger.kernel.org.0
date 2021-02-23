Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8743230EF
	for <lists+bpf@lfdr.de>; Tue, 23 Feb 2021 19:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhBWSsA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Feb 2021 13:48:00 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:6360 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230114AbhBWSr6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Feb 2021 13:47:58 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11NIhmP3008396;
        Tue, 23 Feb 2021 10:47:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=hZi8GR+wi6zVXrDYAmq467w0DEKa1hiQul3Ra6LxQw8=;
 b=guGV9RmBH3ahOy1mGFeyYamq7yCG+vXSXOGzxHZBvw2aBsLrgJlJeIwrWEoVV3HDba7e
 ysCGSMueqddesfMq4zqdRd36SrNQ5Qj16YvG23R20wVhNLyookS1f9Q+SCiWKCAXZTiO
 aLN9E8wvmjv9NKB5UMlqAgWtFTZpTLioXhs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36vx7rtx66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Feb 2021 10:47:04 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Feb 2021 10:47:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBqgo5Rgsu5Vbu5Z3LrR5fUZxWWe41M2b+sWlx9sEb/e0rPtJSGahwdIdvWDDoU0zXXCVa+AJu/GE6UAlJIqJMfhRubSXydnWyhIviaCCM7/UQJwfHptIWsF9sSGDmLSTmj02ut3b3ZNAuQIlPi7z1f5Br3/noJO/OETnEEauC7TRaQtKP1Zn4iELv8CLRltfqolEwNQElWSl+axcyELuZYtH2uIwgSYe/gHsgP09LTGDAuwp5t+Lv1j+fEl+97yRyXo3k4uYRUAwzwGZZzJUBhPs8Eoff3v/eRgfS+/y54Al6x3cMRjW1thd+JNxReHxix8zzag3b7P/MxWFKdWtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZi8GR+wi6zVXrDYAmq467w0DEKa1hiQul3Ra6LxQw8=;
 b=Zb96tkP7wU5LjWgzOZg4rIsqRTknaglJvihGw6U2l3fSWyfC26aWgrv791NUgzJAxPde8g5BMyfRZvQ3tKpGU+6FcYkB4S5JgIxF9kMwh+5PtjGPxbzv6dWD8VqN1F5YbiRKtxC5XnOff/bPuSWt+v3E3S491MDcadrRzyYNBYT5D7p8IvqebIrjh36zyBJdwAcHRE4E5wfIe3G1DxufxzXHZM7Bni71Rjv44eEqFP+m0SQLlw0M5sPhT1BluWN/Pc3oq0TnurntD8jGbQdOkOcvuf4ZUc3lmugh/dI/TKSiRJ1xlzenWUiN2sl+IJRmFhUbA8wkdAFJWLL43l8LFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BN8PR15MB3282.namprd15.prod.outlook.com (2603:10b6:408:a8::32)
 by BN6PR15MB1857.namprd15.prod.outlook.com (2603:10b6:405:53::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Tue, 23 Feb
 2021 18:47:02 +0000
Received: from BN8PR15MB3282.namprd15.prod.outlook.com
 ([fe80::81bf:9924:c4f1:75cd]) by BN8PR15MB3282.namprd15.prod.outlook.com
 ([fe80::81bf:9924:c4f1:75cd%6]) with mapi id 15.20.3763.019; Tue, 23 Feb 2021
 18:47:02 +0000
Subject: Re: [PATCH bpf-next v2 04/11] bpf: add bpf_for_each_map_elem() helper
To:     Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
References: <20210217181803.3189437-1-yhs@fb.com>
 <20210217181807.3190187-1-yhs@fb.com>
 <20210222205912.hucaxodzk7csrdyj@ast-mbp.dhcp.thefacebook.com>
 <083e0c5c-71c5-a735-63e7-4c5b8b1e9149@fb.com>
From:   Alexei Starovoitov <ast@fb.com>
Message-ID: <c837ae55-2487-2f39-47f6-a18781dc6fcc@fb.com>
Date:   Tue, 23 Feb 2021 10:46:57 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
In-Reply-To: <083e0c5c-71c5-a735-63e7-4c5b8b1e9149@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c090:400::5:5e03]
X-ClientProxiedBy: CO1PR15CA0065.namprd15.prod.outlook.com
 (2603:10b6:101:1f::33) To BN8PR15MB3282.namprd15.prod.outlook.com
 (2603:10b6:408:a8::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:2103:c99:e09d:8a8f:94f0] (2620:10d:c090:400::5:5e03) by CO1PR15CA0065.namprd15.prod.outlook.com (2603:10b6:101:1f::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.28 via Frontend Transport; Tue, 23 Feb 2021 18:47:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 180ecc6e-cb96-4621-eb8b-08d8d82b6871
X-MS-TrafficTypeDiagnostic: BN6PR15MB1857:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR15MB18576A1BB507F5EA2242254DD7809@BN6PR15MB1857.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YjOC/eCeiSUokU0DcEFw5a95+0nmUiKOxvI9LeZJ89fXfvLk71n4CtjX6HRWX4YOiCcCiKYiY7ywWBBTQ1hAa+TO8cYH8He3npxHatpnznrKhVxpF0+s9Jq8RkcEY8sZEC2nmbLPulsZUb8mTtTpE3wg6gU2lGtxYQ7ncealeGYMuAz5YdaR0tK1Eo/J/CP+93OX3FwnuXuWTylOrEDNW9URLm2Hw4BbW5UuZB432p4j5j4VF0T1mH4TnvwjuIwMX4SVSZrNm2H06o075zhSbLXNlDWION6PjtXEsgo36zz+Zgi+U9rjFo1whYdq9Dn6jucVULcC5ggDfhmKdxfSwB8SpiMQYDbFlVBWhtpTkSh0dqo2VmuhJzXSZVBqLJjtyZ5/9lqGorJp4fziEoyPDN6EIqWci16ssI/mRR1/0gGzG6oJpmqOXjAEwc73l5Oz//HoF2ip6OnmI+8y/rSGmHFspyxL1NhRu1DedX4W+Tju9SYljSuHTHAeslLl+4EcjglC43p7sLBc0lCKN6z0dGr1Y8RBEQPfuhO0PahogYqYHQ6qX1E+1a7CdIRJ17QXDAFMFWL4PUsBREv5AxZp5SHvqElLz3jwdl4jzddqx8A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB3282.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(346002)(376002)(366004)(52116002)(83380400001)(66556008)(66946007)(5660300002)(54906003)(6666004)(478600001)(186003)(16526019)(66476007)(53546011)(31696002)(2616005)(2906002)(31686004)(4326008)(110136005)(86362001)(8676002)(36756003)(6486002)(316002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NnhVNlZMWmNyd1dxQ3lCbmpRZXg3cWVQY1BjWllySVk0bEIrMjVvZzdlYWhC?=
 =?utf-8?B?Zmt3TDZDem40M0FxNEJVeVRUUU8wSENyNkFsUU1oamprQmNUakQ3bmV4bE9F?=
 =?utf-8?B?RUNFLzhUdGRqMEM1blBBMFZtVVlNdFlEdElDWTBpM0lPa0pPRXRja1g2SEdV?=
 =?utf-8?B?ZUY0Sk90Wm5nV01WVWRnVlAzNlFzb1NjV3lGdXVrU0RGTG5SWUF6bldDRFFD?=
 =?utf-8?B?dVpsdEc0dWlrYU10RkZpV2szK2NaYm1CbEs0N2s0QjNZOXRKN1FCUmZ0emJ1?=
 =?utf-8?B?UlRuT2szZWNFZnpRa2U0QzVhT0FTTnBLVDBsQzY0YnBJbExkWmtPTno2VFRM?=
 =?utf-8?B?VmlscldYbHBKUy9UaTQvOFRLVmZ4bXNtMTQvYVZMTWVtRWNaTGNwRmpwWUtK?=
 =?utf-8?B?KzJ6NmpYQ2NZR0U1cFVBdGxnZStjcmwzbGtoV3JsSEI5VlRXZ21Lc0w2NDBI?=
 =?utf-8?B?QXVPTWdiOEZkQjBscDRHQWFOUjMwRmN6cXpYeVp5V2dtOVBPNDZ4aG9PMSsy?=
 =?utf-8?B?c0QrWTdUNlRXWC84SFMwUzhnZlgrckFpV2RSSGtldmVLcHdQUmJEYVd6ZDdI?=
 =?utf-8?B?OS9BUStDYnBmOEp6Titua3dDaU9YL1RXdENxV0t3VjhvdkhpK0tVNEZOZlBs?=
 =?utf-8?B?WFBsRVRrS2xTL1NaeWJrVEhQWHdSbVNJSFZCZFlwbFlDMFNqMUZlSEhrdHJP?=
 =?utf-8?B?NGhRSXg3TldpWFVEbzVwZUd5bllENWdvWlZBdmNaTTRDUzRycDVGcDhCOTZB?=
 =?utf-8?B?MzBnT1N5dEpndE5Ba0dUZ0pOd2cyeTF5MU81Y256UVd4ZEFBcEhpV1AzUEU0?=
 =?utf-8?B?VXBvbTFZRFkyakx5UVpNK2pZYjYrUVdlczV2dWQ1eEtWeWw2bmE2V3R0dkdn?=
 =?utf-8?B?QWg2QjZmcitnSU12NCtUQmhtNWVXeUxsbnhhbHJkcXpQaXRwbW82STE1dTM2?=
 =?utf-8?B?UmViMzUwSEdjeWJDMjZVTVVYWXBmcnRDeW1XbUcrL2NwWUdvczFuRDBzVWpB?=
 =?utf-8?B?R0dFQ2o4S1Y5dWxzTzBhc1FLMS9NYjIzUjZLc3FaU0lWaW5oSVVsYkE4MS9E?=
 =?utf-8?B?UzlrSkE4RjRrREcveUN1a2YyR2dmWjhDQ20rWklINW1PM2trRlJRTEZ4eTZP?=
 =?utf-8?B?TXQ3MjYyNWEvZW54dGxGRy9VeXlhK0wwY2p6eEZRMzFZdm5pUXRmOU5HRUJn?=
 =?utf-8?B?WW9xcVcvY3ZYVDlUTEZnZXFScnQyeVIweDl5c0tpdUxyd2NjdnpoNHMxV0Ro?=
 =?utf-8?B?Unl1M2piaXRSRjB3WFBQTmdxd2xkbjhqRmlLWlN5VGxXT3dKQVBySFNnMGcz?=
 =?utf-8?B?RExILy9hbkJKMEpqRnc2ejVFbVI4ZDRVd1BoOWNKM0d6cW56Z3F0ZVM0RGZq?=
 =?utf-8?B?dHltS00vZDVRbFNQQWhhRUJucHE2eHc4eC9jaVFqaWVpWGFyTGQrUXlHVHlZ?=
 =?utf-8?B?SGlPU3JLOW5iU3dXUjNDVjYrdW90dmczdGwzMHJRekoyYWRwWkFwcEVDOCtJ?=
 =?utf-8?B?WFljc3RrdHlMckRwZ0JONGo3NU5ia3EzcmYweFp3OUNUaUJvd21qUXNqYm5U?=
 =?utf-8?B?THROWG5pb21YRm1LNE1yUE9zY09VY1h2T3NFOWFuUlpRc2QraWVKbExUNHlp?=
 =?utf-8?B?b0swVjNwVlJITVVkMlk4bW4zT3N4YnhydVgyeEEyWGdhQnprTVVyOGdET0V5?=
 =?utf-8?B?VGlMbXVNT2NsdUFyUGpvYzRNOTZMTitGT2ZGZXRBN2lvNXVnVW1lditsREhC?=
 =?utf-8?B?UlZUbFVWenZHUldaWjduT1Z1WkJlNjA0eWx6bVllUnVBZVhtT1ozci8rRWxk?=
 =?utf-8?B?YW5YZFhxVGU4WkJ6NEhsQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 180ecc6e-cb96-4621-eb8b-08d8d82b6871
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB3282.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 18:47:02.2483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vGrYOxkaW3i9oy69LKniXY3w37Wixh+Nsr39TUKZxgTrJhfq4M6odt8HiH5BpqeP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1857
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-23_08:2021-02-23,2021-02-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 spamscore=0 clxscore=1011 mlxscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230155
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/23/21 10:39 AM, Yonghong Song wrote:
> 
> 
> On 2/22/21 12:59 PM, Alexei Starovoitov wrote:
>> On Wed, Feb 17, 2021 at 10:18:07AM -0800, Yonghong Song wrote:
>>> @@ -5893,6 +6004,14 @@ static int retrieve_ptr_limit(const struct 
>>> bpf_reg_state *ptr_reg,
>>>           else
>>>               *ptr_limit = -off;
>>>           return 0;
>>> +    case PTR_TO_MAP_KEY:
>>> +        if (mask_to_left) {
>>> +            *ptr_limit = ptr_reg->umax_value + ptr_reg->off;
>>> +        } else {
>>> +            off = ptr_reg->smin_value + ptr_reg->off;
>>> +            *ptr_limit = ptr_reg->map_ptr->key_size - off;
>>> +        }
>>> +        return 0;
>>
>> This part cannot be exercised because for_each will require cap_bpf.
>> Eventually we might relax this requirement and above code will be 
>> necessary.
>> Could you manually test it that it's working as expected by forcing
>> sanitize_ptr_alu() to act on it?
> 
> I did some manual test and hacking the verifier to make this code 
> executed and it looks fine and verifier succeeded.
> 
> But since this code won't execute with current implementation
> with bpf_capable(). It probably makes sense to remove this code
> for now and will add it back later once bpf_pseudo_func is permitted for
> unprivileged user.

I think we might forget it later.
I would leave the code here and maybe add the comment that it's tested
for future use, but not needed yet.
