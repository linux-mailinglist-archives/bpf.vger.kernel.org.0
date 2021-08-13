Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626E73EBB56
	for <lists+bpf@lfdr.de>; Fri, 13 Aug 2021 19:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhHMRXL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Aug 2021 13:23:11 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:26354 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229533AbhHMRXL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 13 Aug 2021 13:23:11 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17DH98Ag010484;
        Fri, 13 Aug 2021 10:22:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : references
 : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=uK2S3O+JYwc93BtjVbBqCmMkuON8dKqw7w7ULk+SU8c=;
 b=HSMe7dvoY8daA+lphxWC6QfMrLPQ/kSSjyEEyzrZ6fWToEVEHdk5uKXw0R++gWmdRm8o
 g472JPTkU3j18HuhtWRS6CRSjYWv8P5YICnSXw+5jTAY7gkD8rXmR7C6A3znhws8mVyI
 ohX913Zc5ZNsUwQDCJXfsyMh1lwjlbrlE9c= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3adu0s0ury-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 13 Aug 2021 10:22:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 13 Aug 2021 10:22:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIHgmFI078wu0WGHMPrVttdwTHvup2XZI0NT0t334nAZSn6L9IKQilCNQPrUGymXu5JUOFIpSqoynTXYvHqBu4PGZN6jVNuzi60T0x79mvAW8fHDLAFzFu7kWgEeeSya1VXpT8tH8NG93a5bxVVi1jNQYohVuVAXfYUw4Lc8yULCeN6coEQqZmUR/W9sr0OdUbrfaNf1B4+GrGSsN7f5lCzQycbypgHA1ltnV77x95R6X0XafxRUG01mIRAoexxPZipSGqBnNtmQY48Nadx9ZM84EcIqIHyMe2aX3TruxQD4lEArxbtaPFMGG8wEl9dTFgHYH0z8zAcd0e/iewPamQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uK2S3O+JYwc93BtjVbBqCmMkuON8dKqw7w7ULk+SU8c=;
 b=N4GH7cObVGhs0gKvchkUjEB/MrRqXPfXTXOqVhbzBwdrVofDNJGit2F/PSDpWxPiKsy/FLKprD+ehV9yH6aCDoU8I1IO6najrWCk5trfF8NuqFYUSBF4T+qvUdotrGivduDakzcXnowcYvAOgBHbLbteiXe7BY+meaD1me1Ua3iLbWFny0kFj1aHx2jq3hB1Uf7OO32+Sjli6W5w9hmH8yLClLQze26VztydJs60F5NzxCwtR6Z9jmQ9OkFeUMyjDKmGZ4NQLbeW1zg3+ewURfRwGP6rG4/WcyOb40T84ijEF12cxeypWHHgRNNUlnJT6Lv00yDz+XECrGWghB7lLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN7PR15MB4158.namprd15.prod.outlook.com (2603:10b6:806:105::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Fri, 13 Aug
 2021 17:22:40 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4415.017; Fri, 13 Aug 2021
 17:22:40 +0000
Subject: Re: libbpf attaching a raw socket
To:     Mohan Parthasarathy <mposdev21@gmail.com>, <bpf@vger.kernel.org>
References: <CAL2pN5_4tPwhOxKu1g4YT3fEnzvhkQ0dLkP7-4RyUoEmPJiyVw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <b307c1c2-e770-8926-7b68-3a0e69c659b0@fb.com>
Date:   Fri, 13 Aug 2021 10:22:37 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <CAL2pN5_4tPwhOxKu1g4YT3fEnzvhkQ0dLkP7-4RyUoEmPJiyVw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0180.namprd03.prod.outlook.com
 (2603:10b6:a03:338::35) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e8::1013] (2620:10d:c090:400::5:8f57) by SJ0PR03CA0180.namprd03.prod.outlook.com (2603:10b6:a03:338::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13 via Frontend Transport; Fri, 13 Aug 2021 17:22:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d9df626-d3f2-45eb-9830-08d95e7ef3b5
X-MS-TrafficTypeDiagnostic: SN7PR15MB4158:
X-Microsoft-Antispam-PRVS: <SN7PR15MB41586A3A1D76154CACB31A64D3FA9@SN7PR15MB4158.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cdUf9lO1435e62rI8W4/PCZr1oqvTFznzjUBcoeOXzUL7uJ0uMbIuVKeeHV4jlPjKRWD/BMT2gcafwkMrq8iB8NqUIbjb7LKL9h3dqQecngbCglGYCfvDs+0QnrZhyS7WeUD/AGogFgYZx8y3ZFYSMSFkXGjokl8Qq3JUcjzWYQTdLFsJWlvqy+aKOk+wb/5ubZ6yICLkHeXX737ug1pt7xsEZvrxIMsA3cjyvdXG8SAq91wDjHbL06cO/pl6RfnOgdADzfCMA/4cT8dcCOsN7slIkAg/5vMYw9BTrc08uE950sHH4BJXdjXNtwUAKvSIKKBBoTjr8CQ/V87d2QOqGYLcbLwTLVxPMZ4iOzaEmT9h5+HjVsYQ0NljoeKX7G9Gww5WSFcgyWh8GiY88cSOfuZ5mkjLTUz6dQHDtEFTnWh8ZhDkR+QZ1Ox7SV0nU0TBq/ailFqB1qDr5L6V5MVF3jGfV1WJd/0aNwLD3LtLOjHYr9mdckjVaV3tpL6ZFKZEls8eEig1hGBMctnThKlgF4qv/ZwQH+HUIJOxXSVT7Giu+5e6+kS3eETsvfeHophbkUZy7vjO1S6SklDZ0ikSbvOGNXg2qYg53DkCWEJeVNe2RhAM+Am9rjYV4Xk4fR711+/qSWj6779Lqudvai9O9hMp6gVZLcSlkmHzcRCUceRHbPh8K8EJn4G1ekHEufDbOenXNkkwFfAhTpmeFRrIB9IIBKKeegXg3vIqDiLKN8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(186003)(2616005)(8936002)(478600001)(53546011)(31696002)(8676002)(6486002)(36756003)(2906002)(316002)(66476007)(52116002)(66946007)(66556008)(31686004)(5660300002)(86362001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWp4TzdUNmJuMmZRc2tjanVjS3l3UTd3UlMvNHZLbmpRRFBpdmVHRncvRC8r?=
 =?utf-8?B?RE5BRkNselJkcHVSNEhzTlZhdDFibzlSZUtwSjV3Mkd0dThIeHZ4MWlaR2pt?=
 =?utf-8?B?eSsvWC9HbmdONEQyTFNnVTdWMkRlWW5zeHFSSnRvQXprRjhqRE9YazVXOXVi?=
 =?utf-8?B?RElxWngwYW1qZk0yL1lLby9YUG9UeWRUOHJMT0lpVzVQdzB3ZjVIUXRJYzgy?=
 =?utf-8?B?SURndnU0TnZiWm9KNmE4elhSL0FhK05BUUtaS0ZBa3RXRkkxc0lDaTVoM1E4?=
 =?utf-8?B?Mko0ZE1vQWdHWFRFTWhHaTlwcEN6cW5YWitHamRLaU5HKy9aOFJId1B3bjMy?=
 =?utf-8?B?dGIvbEZYUkVhWHFJcUtmY2RuOE4rVWZmYXc0N0dFLzlvYTBDOGtvcExvejM1?=
 =?utf-8?B?ZFR4eWJsVDRJdFNFbWpub1F4SEVYaVpNNnZQL042aGZKeVVJcVBjWWdWb3Ni?=
 =?utf-8?B?SnJNazdHVjV1d1I4eGoxYm53OGZFNldLOXF4YzZwemI5R29uVDRlUlFBTS8y?=
 =?utf-8?B?YnNCSlh3NHlwT0VmVGt6NGx5V084a2tWZWtpZm84aFpUQVFSZndTYXNLUVg2?=
 =?utf-8?B?aEhXV013UDdjSlU2eVdzaGZSN1lKNi83VURibXl3QVQrdm9lWjJOVE5LSHFP?=
 =?utf-8?B?V3JOWFhJRU42MGY3RnNGMW80S3dQNm1yRnhCaHJDVy9DaDJtT0F4Q1dPMHBV?=
 =?utf-8?B?eHZLNEkvTE0zeGdEVlpWMytVamxaN3FkbCtVblZjV1VUNEdxNHpjQkVQV3Bl?=
 =?utf-8?B?N1p6NEozbGFXQmNFUHBZTkRFbW5MWHIvVHFMWE42N29tcWFJSlBWRXR4RWd3?=
 =?utf-8?B?UlVZNjNCZVRuME9uN2FzbXZYS2dNV1FiOXpUcnFPMyt4Yk9DMTdhQWZvMVhk?=
 =?utf-8?B?L2w3VTE2VXpMeWJMN3dRM0pHZmNmS2JYc2JMYkRHVlMzUVJGaDNvUEIxb0Vv?=
 =?utf-8?B?VWE5VGZpUUJmVVJTRDJRc1NwYzFHOWVVZlAzaEkrUDhvV00xMHNtdDR3N29r?=
 =?utf-8?B?R3l6eXppS3JiYW1nSUkrZ2ZOMmhSMkNFT3UweEt4L2pzaFFvWUI1NXNtRWNq?=
 =?utf-8?B?SmMxZ2RmSHZNcVprNFJGakpJNkwvem1JRFltc2t4ZE9hcnR1QUI2Ykh4T3Q3?=
 =?utf-8?B?d2FmbEtGMHVFdFp5aDIzVU5NSWMyd3JnZEt6R2tlV1pPVDIwSFV6TDVpTTVq?=
 =?utf-8?B?cDd4K3VrblF4T1ExdS95OWljdERmeU5KSXlYb3BGYXZRQVBDTHZvdEdjUE9J?=
 =?utf-8?B?UjY2YWkrYyttQWdLUkxDaVZkVDZHWStYRUg5c2R3eFVZYlRXTW9qY3BFdThp?=
 =?utf-8?B?SmYzNVpEM0ZndnNSRy9yUS9kMXpld1I0ZHFWbUErazR1SVhjVUQ2MFRhQXVV?=
 =?utf-8?B?VGE5YkZCallMdjVVckJKWHV1QjFUMi9GS3dPbDd1d3cySEdMaDE0Q0xva2E1?=
 =?utf-8?B?dWorbVJPYzAwaWFLMzI3ME9RYzVxRURNK2ZXTFBHSEljeE1mbm52SGVDZnYw?=
 =?utf-8?B?SFFIQk9uenI4eWMzZjZCMUYrNzVRWUdlR3llZEN0NmM5d2VPT1c0SXI4M2Vn?=
 =?utf-8?B?aDY5MVRYMnQzT3oyWVRQeEhjKzgwR0s3T3JQMVdIcHpGdnRnMHA1NEhQcVp3?=
 =?utf-8?B?bGZnVTN5TmJtc3lMeDhlMWhOZ1Z1NFVwcG5RTjRZa0JiQWl6SnhlQXQ0SkFV?=
 =?utf-8?B?K0V6UEJjckw4cjlGd2pvMGVJYWtLZTRieTNNWUgydSszdmVCMDV2S21rTUov?=
 =?utf-8?B?a1JhQ0hkMHUwMXlmeTJ0a0tzU0t1ODBpUC8xeGV0WjRRQkdIRG5YV3Y1RFli?=
 =?utf-8?B?V0tuQ0l5NUd1K2k5dWFrZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9df626-d3f2-45eb-9830-08d95e7ef3b5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 17:22:39.8459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eIDZN84OzUPufOhF9dT9xfrtIajHLn93GVKwjJMhEg6MzlZrF+0dXknviVIgg262
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4158
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: y2YGq4xU3mtzx_aqGhBLeaHErPTUTeH0
X-Proofpoint-GUID: y2YGq4xU3mtzx_aqGhBLeaHErPTUTeH0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-13_06:2021-08-13,2021-08-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1011 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108130104
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/11/21 6:36 PM, Mohan Parthasarathy wrote:
> Hi,
> 
> I looked in the samples and header files, but could not find an
> example for this. How does one convert this from bcc to libbpf. This
> is the userspace code.
> 
> bpf = BPF(src_file = "socket_filter.c", debug=0)
> socket_filter = bpf.load_func("socket_filter", BPF.SOCKET_FILTER)
> BPF.attach_raw_socket(socket_filter, "eth2")
> socket_fd = socket_filter.sock
> 
> I can do the following to set the type:
> 
> err = bpf_program__set_socket_filter(obj);
> 
> Is there any sample I can follow or any header files where I can look
> for attaching a socket to the bpf code.

There are a few examples in linux/samples/bpf directory:

[~/work/bpf-next/samples/bpf] grep SOCKET_F *.c
cookie_uid_helper_example.c:    prog_fd = 
bpf_load_program(BPF_PROG_TYPE_SOCKET_FILTER, prog,
fds_example.c:          return bpf_load_program(BPF_PROG_TYPE_SOCKET_FILTER,
sockex1_user.c: if (bpf_prog_load(filename, BPF_PROG_TYPE_SOCKET_FILTER,
sockex2_user.c: if (bpf_prog_load(filename, BPF_PROG_TYPE_SOCKET_FILTER,
sock_example.c: prog_fd = bpf_load_program(BPF_PROG_TYPE_SOCKET_FILTER, 
prog, insns_cnt,

They should provide an example how to attach a socket_filter program
to a socket.

> 
> Thanks
> Mohan
> 
