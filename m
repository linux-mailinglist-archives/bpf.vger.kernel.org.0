Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82DE239BCA8
	for <lists+bpf@lfdr.de>; Fri,  4 Jun 2021 18:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhFDQMv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Jun 2021 12:12:51 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:16678 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230037AbhFDQMt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Jun 2021 12:12:49 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 154G7qxn011219;
        Fri, 4 Jun 2021 09:11:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=uDFtN5R7hW6D4zkRBan47MFkKjHKjicFQ9r0ia5Uy10=;
 b=EsdRMiE6VmicgwKWr0s4RUy7YTrfcgY+b/Xeo/sQ5ZZ1cy6O1CGkUlc7/q5Cgt/loPfb
 iotIbc5Ii8RaS+ogA4PWoVA8Ro1qa53W9O+fcZNDOz+GNx6bR5setT/i2Kp9EiRBGEwv
 SAa0OtAYAzwQLbdXqVNgQyFACSQ+OVIpBx0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 38ygh72bxu-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 04 Jun 2021 09:11:02 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 09:11:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idZJOQJwcm0rJMFQ1ecGHYYdMSN0CQ1JfMGJjZPI/tHaQKCw6Gk1r7pyaCyiE6LoW/P+s1403TYUI2zsCPsSwu6rl/xjhElO3z68pZrHvgOFA1gdTPhDQF0MbcUIzcK2UWPkuk1LpgDx2FSUF7SuLKY+Cx05UuXZ8BnFtLURBl2WVDn4G8VIpg4S7mUm4r7rnHenynEyhBakreMlwC9lRWtIK/7xN9GFhfDb6knX5FzcdRdLj1MIwd3OI6JXkN+bM7pAtH/WbasAjJZW+bO5FacvvS+CCCcpEDW86JcJ+BIhBbdpeFjfXdji5qfLQwu9lk9kUz6l8aD33IE19B02Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDFtN5R7hW6D4zkRBan47MFkKjHKjicFQ9r0ia5Uy10=;
 b=YSMUfPW2UpJ+eyh+Y0xC5nbBAEXBgwpnTShZo9Zl+eVld5eH82LFvVne8s2ycIy8M342jEbHpVtW2XbIKl9QSdI88XSi2ytw6sTe9Uzgn0iJxi+U8czLc4FCTGeGrgEidbLe7qsUl8cmJzeJIZJ6k+KWRdVn4+fTLNw9WEkZjxESKT3MfCrTqLi8/GuYmGYJyXcTk/W98Fgfeeo4B2TxyrNn0cjcw2glYxRA7AblOAIc0HiH0w8Jm0VL8tZJ/+1vGsUBFL7XXMXGs1OmZSJ6xtNE5bdhQ4hv1qkzS2OwzZDblCFU0RYsD8Q73BmzpnDDNhlX0A0t4zUz6PK0FMMaJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3967.namprd15.prod.outlook.com (2603:10b6:806:8c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Fri, 4 Jun
 2021 16:11:00 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4173.030; Fri, 4 Jun 2021
 16:11:00 +0000
Subject: Re: Headers for whitelisted kernel functions available to BPF
 programs
To:     Martin KaFai Lau <kafai@fb.com>, Kenny Ho <y2kenny@gmail.com>
CC:     bpf <bpf@vger.kernel.org>
References: <CAOWid-drUQKifjPgzQ3MQiKUUrHp5eKOydgSToadW1fNkUME7g@mail.gmail.com>
 <20210604061303.v22is6a7qmlbvkmq@kafai-mbp>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <f08f6a20-2cd6-7bf0-c680-52869917d0c7@fb.com>
Date:   Fri, 4 Jun 2021 09:10:58 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <20210604061303.v22is6a7qmlbvkmq@kafai-mbp>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:a57b]
X-ClientProxiedBy: SJ0PR05CA0130.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::15) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::1a75] (2620:10d:c090:400::5:a57b) by SJ0PR05CA0130.namprd05.prod.outlook.com (2603:10b6:a03:33d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.10 via Frontend Transport; Fri, 4 Jun 2021 16:11:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb1bdcef-a059-4b4c-d2af-08d927735853
X-MS-TrafficTypeDiagnostic: SA0PR15MB3967:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB396762338A2B8FC9F7CA1BBAD33B9@SA0PR15MB3967.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CPhx6Yk7TquwBZeRfqf7nRUnRgnjDJ+qOZNPWHvEnOWDP6uvy8atIMekZvxUuWzVHQdKuQPR2Xg+Wt4KXhQyYnCrQnNDHXann6fqq3HFHfBd6fqpEsXM4YU1UUPXYOkXIVIKg4vKkF/a9z9CJBaBOqJrqh5E0G0AkfWihpFxbF+i01A2/Rw9YxETdAAscJUupt4pJkBWnbjhM8zGs1rv2LQCIHKImsLsEnTkj8888Oc2RXgE18JOqWKVdAE6Wc+sYV0rWWNconAuX9IW0710U+vdGvAcWx8daVCaLepcGoHl0SksUaEI7x4e2lqmHR2S6DN+nkjQCYStz6K6TTQuU3CGWTZGvsXOm4wjkZ0iuTw8F6+6Zj23bRXWuXfG1dOF1jZp+SEWAlem+ADRAqHIwnQjEcwBA+0LsL4GErXKYq2dYujHOckYl/0inRa9Hhk22cVbmLn5LiFt3Bpr4e/jdLreDZi/tDEg3j56wsd/zwN4KMDVZ5QBE+ng0jL2/4MkCqYX93JfBdg5qJrLJpGO/A1H5KuerI2Ed3psYS7HU234k9xoAbEsb1BPtpC5bpJfL2sgM2LAjTZVpf2Y4AQd17U4BvduWGLfjpczjSLhCMz0qHWHEy8AVQP67DeuOa/CT9XDw/g3kl6sg81ljNpaHOSYABYha56knBYe+u4ttTEznETeBEjyfF8BqItM47Sillw82b+9eF56vUT+i1K6yLhntyDwdz8JvsPNCUgWQ3bxmQNESQJIJKISlut9hk+FALO9N2KeE6r2xsUMql44BuaeWc0BM4ARcftBcSAJxvM8BUNrWSdzLGF0FxlG2WK0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(53546011)(8676002)(2906002)(6486002)(8936002)(478600001)(186003)(16526019)(66946007)(66476007)(5660300002)(966005)(4326008)(66556008)(52116002)(86362001)(38100700002)(2616005)(110136005)(316002)(31686004)(36756003)(83380400001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?L0l3YkhHb1RnRXM2d1RZcUFnUjk1d0VnZ05oa2QvWlM5UHBHZzZGTnFPd3FQ?=
 =?utf-8?B?TGdTNlY2Q0FMMklTdDZuOUVMczBha3VnK2kyeG9vS2Jkb1VHWS94aExZeFFQ?=
 =?utf-8?B?OExnUnYrZjFyS3hzYmthSC9SVTVNZW12WktyQkZXWCtEQkl2eXExT3RLNnJh?=
 =?utf-8?B?NGgxZG5PSFZ5WXVkejVXUnFncWY0TUw3ajhpcyt4cjQxK2VJajN3c3RZc2Ru?=
 =?utf-8?B?WDVOMGFUY25KenVFVm9vbm42TWhucEtSSmpwU3A0eTF6bFE2a0I4WVdJRm9B?=
 =?utf-8?B?TUJhcUJvbmdBdVJJU1VNbndKZXl1bkJJSm12a2NCRnVGTmhoQ1lJeWRBdkdh?=
 =?utf-8?B?TGtQS0dnczBXWmNDNGxjZW9kdEpidFo5cElXV01DNlFVK3NxVHAraDZScFVX?=
 =?utf-8?B?dGxMaVhXUWdXVFV0cU4rd0VYTllWSE11RmFXYmtLRDFZNExHYktnVlpBN3JF?=
 =?utf-8?B?R01lc3ZDVm9sYVBDT1VjcHZEY3pDNzErdnZnb0ttUHdhREpCZEVOMkJBY0xX?=
 =?utf-8?B?MG94SlE4VHNjcVJkUjZtYWt1b0hnNGFmMFBpUThyRnhOUnB5UldWZXcwZjZp?=
 =?utf-8?B?VVlwQjhUa3hiVTJDVmFHSXBRTXZTdnRBMXBLN0piVThtb0hHZGFISnRqKzV1?=
 =?utf-8?B?WVBnelVNWC95VlA5VmFxOXBFRlpjd3hmQ0htKzh2c0pIeXBJbnltQmxBOTJl?=
 =?utf-8?B?QzkveGZmYUttRzlCOXZMeGRXMmtyaXU2UHllWllQZW9zN3NjV0VmVFNQdnJO?=
 =?utf-8?B?OExkai9Ra2lVajdoaVpwVU53L3YxZlMvbHdSbDlNTG5FSlJaVjBnb0ZsV3Nt?=
 =?utf-8?B?VUFsMUJOc2FERGpDL3VaQ00rVDRMUEpOaUUyWHhhTDZXcFE5VzBmSzlOYWw2?=
 =?utf-8?B?T0hWSG1JbUYyU1RFd1lLeVBlWXpyZVBFOG96QzZOVE52akR1TDdmVUk1NzRF?=
 =?utf-8?B?bjFhZ1hvM0NHZ0F1VGRjMXFucmYyYjF2WjdTdmNPN1Q1d2RYYmlZMWhaZCta?=
 =?utf-8?B?WE1GQXpPelB0MmVJbTFKWEY4L2I1bzRUaEhhRDlDQWxUdWJLNGtKL2JRZTRR?=
 =?utf-8?B?SEZKNS9zSmZ1d3M4U0JXNjZsR21oNGlsVWgzd0NBN0FYcXZRVnZOZ2RXV3Vo?=
 =?utf-8?B?alJQL0NSUXpyTGNYam9JbGRWOTJTV3g1MkdBT0N5MERFTE9tcmNGQUZHNjlQ?=
 =?utf-8?B?ZDYrdHFkbEl1NVFVRHI2MTZTdzR4bTdJaUZCa2RUaHp6WEJsZGxqcis5aEpV?=
 =?utf-8?B?cEtROFFzbUh4d0kwRHd6dXlueTg3MTVnenkxM2VzMS8yS2tEMWJVOWQ4T2FN?=
 =?utf-8?B?Nk9KZ2JWelBRY0tpUStoRFRLSXkxTk5nMEdwWmJzWllIYWo3UmpYa3RQOGFR?=
 =?utf-8?B?UjI5eVNYeE9lZjVVeldxZzVLQlo4a0FCWlNZVDdKM1laQXRTbWJFd2IxeXZS?=
 =?utf-8?B?OTJBV3p3OWIzQUN2bTIxS05Uc05Da1JtV3ovcTF5WHFxV0tOYlJQekxvbTdM?=
 =?utf-8?B?WDVPQ2xYNm9oejgvNkZpTmlQNFlWeTZMcGkyN1JzSDJWYWgzOUFHVDRjUEds?=
 =?utf-8?B?YlJra3FVaGtWTHN4UG01dVJhVnlmb21ISkVDbWFvZGl2WjZTR0l1cUlMOGl5?=
 =?utf-8?B?SDR5cm80V1Uyd1UvNmt1MkJmVXg4QnJNKzJkS1NLRHgzZ3JQZm1kdzh0UjdP?=
 =?utf-8?B?UXhLeGZOQ0k0ckVYTm9iTFBmYmhGcVByMmNLdWlqOWIxUmxlU29FV0Q4TjJ3?=
 =?utf-8?B?RmJSNmo2U1hIZVYxd0wwSnVRT2xNdWFjaTB3Y2YvdkhTakJXR3V3T0ZaR3R5?=
 =?utf-8?B?RGxMTEZoTnhtUkkvczhwZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1bdcef-a059-4b4c-d2af-08d927735853
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 16:11:00.7535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2aVUsXToLpnzG7fv7dS3aNEJ/goqG2/RS9LtvjCpR4s1vijGlCrOaNtRmd7bIeM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3967
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: TlGyQ8AVcBIr0gHbx21LOpwirFWJNReS
X-Proofpoint-GUID: TlGyQ8AVcBIr0gHbx21LOpwirFWJNReS
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-04_11:2021-06-04,2021-06-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 clxscore=1011 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 mlxscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106040117
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/3/21 11:13 PM, Martin KaFai Lau wrote:
> On Thu, Jun 03, 2021 at 02:01:13PM -0400, Kenny Ho wrote:
>> Hi,
>>
>> I understand that helper functions available to bpf programs are
>> listed in include/uapi/linux/bpf.h and kernel headers can be made
>> available at /sys/kernel/kheaders.tar.xz with CONFIG_IKHEADERS.  But
>> with the support of calling kernel functions from bpf programs, how
>> would one know which functions are whitelisted?  Are the headers for
>> these whitelisted functions available via something like "bpftool btf
>> dump file /sys/kernel/btf/vmlinux format c"?
> Like other whitelisted functions in BPF, the list is not in the vmlinux btf
> now but could be a BTF extension in the future (Cc: Yonghong).

Currently I am working to add a custom dwarf attribute in llvm so we can
annotate global/static variables, global/static functions, function
arguments, struct/unions, struct/union fields, with arbitrary strings
and these strings will be preserved in dwarf so we can eventually
encode in BTF. The WIP patch is here https://reviews.llvm.org/D103667.

> 
> Making the kfunc call whitelist more accessible is useful in general.
> The bpf tcp-cc struct_ops is the only prog type supporting kfunc call.
> What is your use case to introspect this whitelist?

Agree. It would be good if you can share your use case.
