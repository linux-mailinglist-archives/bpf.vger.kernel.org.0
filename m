Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDDB3A212F
	for <lists+bpf@lfdr.de>; Thu, 10 Jun 2021 02:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhFJANw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Jun 2021 20:13:52 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:24920 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229507AbhFJANw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Jun 2021 20:13:52 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15A05uYi002376;
        Wed, 9 Jun 2021 17:11:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ct9VMoCtEhe3cHuk4MUJRLkyBCq0YAPNPVquQWHD8KE=;
 b=YVeM7g+kCpbtmUq1GGrj9YGb+Gn5N5Wy9FsBYd5RXC5FZ91lfweYAIWMzuOtF4f7SZ86
 Rny3j4zYGf7SSdHDmP8WK+E1B77UYt0MuB45y71lPDKkIlgh7a2q4a413+YjljphevYX
 mD4yFna8A+VEZ6BFifQPHfDXTSn0b0KqRCM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3925y2vfkc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 09 Jun 2021 17:11:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 17:11:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEz5HAjmknkgTZ/yZsczf2+lqQmPGBYspAonAMDq1w5Nxg2QeT2AB/bUkdsndQPwBjBONfqUbKw8cvTJFCjhpeAX0gnPwo4NXUsMKJycdpm7hDcIg6Lnk84eTs77kNRXK8ric9TXKts/OlrtW2o2PkG7QCqUbFsiBXyDj/V+scOzjhbJoMeMRL9W/J1Bx/+pUIAf7fpAWw43EU8j11yc5k3RAJjzOw1rAv/LlurhtrBxbJrTOsObLpXhsPzdwPJ4GdU5uE7tJTDh5qo1ed1kSGYBbv2GAEO4URezrDj6mLUHTVa6R7WnBL2+mTiJcyXut2cbr5HQ9pmEfOtLe9kTnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ct9VMoCtEhe3cHuk4MUJRLkyBCq0YAPNPVquQWHD8KE=;
 b=gk6fvwvLulEP0e/WaZeTQSVxzjDeMsOWC3fvnjgYFU0GG8p0shLRpnI/FnQ/Ms/nbRrqPCB8g+VO3ZBwV7Ls9C40be96LVbW1WyDJcRzwhlnJ1NSjv8+Equ30KFqjzXMgkneaLf4PdZbBF8d5H0MyYwvVje24C4b254BPntXIfsDRZCxr4wG1gyhIZnRcLOWsyZUsdEcFloP7Kh1q1RBzt5BCImboNhBnbv/QBoXb0MXaHvT/DbqwVW53sAay9aqE+cr6FKET8oSWVeRGyrZHTeGSqmOELEJyq6T/11AROCsO1ADb1urKou60PcgVyXd8qmR09bNSKsUqVFMEyjz8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: riotgames.com; dkim=none (message not signed)
 header.d=none;riotgames.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4919.namprd15.prod.outlook.com (2603:10b6:806:1d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Thu, 10 Jun
 2021 00:11:39 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4219.022; Thu, 10 Jun 2021
 00:11:39 +0000
Subject: Re: [PATCH bpf-next v4 3/3] selftests/bpf: Add test for xdp_md
 context in BPF_PROG_TEST_RUN
To:     Zvi Effron <zeffron@riotgames.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Cody Haas <chaas@riotgames.com>,
        Lisa Watanabe <lwatanabe@riotgames.com>
References: <20210604220235.6758-1-zeffron@riotgames.com>
 <20210604220235.6758-4-zeffron@riotgames.com>
 <960ba904-9e5a-9345-4ff3-73c3eb8a82bd@fb.com>
 <CAC1LvL08QdD-4D_q2TEt3wv+8N=xbfmMdPwZPyA+MoZV=0KKMA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <0915c55e-ea90-1d43-4431-a4959ce3d7ec@fb.com>
Date:   Wed, 9 Jun 2021 17:11:36 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <CAC1LvL08QdD-4D_q2TEt3wv+8N=xbfmMdPwZPyA+MoZV=0KKMA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:92ff]
X-ClientProxiedBy: BYAPR02CA0043.namprd02.prod.outlook.com
 (2603:10b6:a03:54::20) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::11dd] (2620:10d:c090:400::5:92ff) by BYAPR02CA0043.namprd02.prod.outlook.com (2603:10b6:a03:54::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Thu, 10 Jun 2021 00:11:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ada62262-ffe3-4a04-73db-08d92ba45183
X-MS-TrafficTypeDiagnostic: SA1PR15MB4919:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB49195F7F22C4AF0F7F8B497DD3359@SA1PR15MB4919.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +8eIgEqPxK28zI88ZnqTE3xKhpq9LPSmnrK/sw0UK2l1W7AvhSxFquWliSBWcR/yV0cTYNJ982eha0PXbQjc3IyrEqfnttxuQJy7YauaO84ol/ZLwaJNerqlTpzrUZFNVREUwW4kGnJaJFGtDa6acJO113ghkQIhMg3/JGwEhvDsaykw+lEw3fYLW7TWFSx/WeGi+qGr5p2GOAYoPuZuLSmDElc8MI+UaaxdkAlZ2N1nlVnHvQEccVMWI1D+bNCXPmqAvThBQHa5D7240pZOwu/KSWGxdy+KrjGQ3sXSFdL5vEVJoCXIBshPKcdr8TBXJl4U++7sbku9MIUSXgznF7qtPSzf9jEGogCOML0oX8wpzvSoe3xfpV9toLTZJhy75/PeZMFZ/ELk4nVlMdiW/JXVBe8EwzOzpjZbJay7CZL2tyVSR+bdJAhtBEJIkNkE5sOv2AVETbUQZWXb5xEVwTY5lMGpBt3PM89Qo4HwpSDjA5y9uw+dyoQWfLxq5lc7G8KJvUDqCNkOsczfn1a8bgTztlGt2McX9odYbWg8J2yHTn3j/RDM+gXlOtdAaqYm/pJaPYBuZPrwMLAtnrnP3qRuwoElkpOOGHZkcB3tijbMrkhzx1ArWXoSUFPV5eIaWgee4FmppbTiUYVuJAnwIyk8S11u2GEWWRcphNPyBr3kEcDWoIG65Iq5151Uh89G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(7416002)(2616005)(4326008)(316002)(6916009)(8676002)(6486002)(83380400001)(186003)(52116002)(53546011)(38100700002)(478600001)(8936002)(16526019)(86362001)(66946007)(66476007)(66556008)(36756003)(31696002)(5660300002)(2906002)(54906003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDZ3UnR2YUt3cDNTcUU3R1o3WE9wSlRrc2JwM2dxdVlRaG13Q3dwNUV1YWhh?=
 =?utf-8?B?T3VXU2cycXVmbDI4dVRtdnJOeTI4UnFLaVN0VXAvZy9oYXlSSWZBVHZQZFZW?=
 =?utf-8?B?TWxxTGZldUZmMlBTTmI0SFVJZC9jdHNWd1ZpQkRGa3h3TE9nMFNuVVdHdHZu?=
 =?utf-8?B?Mis2YmdVNFFXdWQ5L3RzUWd6K1JaV0lhYXdqMWQvcXVpM1pDWTU1TUFDemRB?=
 =?utf-8?B?eUd5T1E2alBCVk4xUFg1eHJUUlRBd3VUOUtjdytZTjZyR1FJcDdLUFBqbmJ6?=
 =?utf-8?B?TkhxQXBBREsxS1RaVk5QVUFkcnlMeVJ1RmZyVlJjSm5PWmRlZEpEN2NLa0xk?=
 =?utf-8?B?dW9HdFYwNDZqa0MxekdMUXNSMklzUURuZExhME9HZmplcXVZa3ZZbzhwMW54?=
 =?utf-8?B?cm5vZHRWSVBFTjdjSUo5OVhkN1JxbzBEbFdNL0JlUGJVazA1cnIzRUNESFBm?=
 =?utf-8?B?VUlMUFhiZXFGWHNBMmZPdVFPOWlQcXBOOU90YmlhZk5QU0hiaUlUZEZUTkdY?=
 =?utf-8?B?K29NYk1abEFYdWMya2ZFajhybjJzWlZBSVdCYStpaCtoU3lIalVBRnZ4QlBU?=
 =?utf-8?B?dXdERlVwVG1nUE1HRVhCcFh4aXFJQmhZbDlCMjI2K2RqTzRKWCthY1pOUkVO?=
 =?utf-8?B?MUJlckloWGh4MnNxRGwzazdGRWx1M1Z6MjZvRFU4SmZKcHplRmwxd256b1dj?=
 =?utf-8?B?TDFGRjdCbU9TRHJJV041eHUzTjF2aGZlMGRPV21vS21rMmM3dkVFY2VBUG5v?=
 =?utf-8?B?M3FMYjJwb1Ewczdvc2g0M2VpMDQ4UXNRcEI3QUhBT09PNCtZeStFdWVZdGFM?=
 =?utf-8?B?YjJPUGRPRHF4UERvS3pjYWRndXdpZU9XK2E3c3BSYS9oMUdIOW51c2VaejB4?=
 =?utf-8?B?alc4ZWtsbkZoeEJWRGVlVlVod2FRSDR6L3plSGZGWFdmMTNrZnZCOWJXN2wy?=
 =?utf-8?B?dGd6WU9ad08yaXF3QjB3M21RVTJGb2R3bVNva2dpY2k3SkNHUkd1YlpvalFQ?=
 =?utf-8?B?REJ1cURFelFCb1o0Q3ZEdUVMNXloMUxCL2VhamJKS1dCUm1lblZsUlNKd2dL?=
 =?utf-8?B?Wk5mbzFNekxGTUZBUTlnQWwwUE5JVVdnK0ltb2htR2thREt6d2NySUFmUG5a?=
 =?utf-8?B?ZHIwa1cvMnZ2b1BGbFl1SDdqQUpzOEJpaUZZcjc3M2RpMkY4dDdKNGtEVStj?=
 =?utf-8?B?TFVtVFJEcm1KV0xqRFVlZzNkU0pqcThSNkVlY3NUOENrVk9tWnBiMWVadzJW?=
 =?utf-8?B?VnBiRXpzZndjUzdpSXlJL1Jnd2NnV3lmUndyU0kwTHExV0VXc0xJSzJ4TDlz?=
 =?utf-8?B?eHhWdGh5aXVlZUlhWjZvQ25LRGUyK010c2lXMzhneDYzbEFCS3AzSjRYTVZV?=
 =?utf-8?B?U3hLRUY4U3c1a0dJSFJJYlN0LzM3RHlpMjh4WndXNzZRKzIxTk02VmVVMmxZ?=
 =?utf-8?B?MU1LQ2lTRGQ2Y1NHczl2cy91L0NkQWdXZFJEUUFJblNuQkJkajdiZ2tRUVp3?=
 =?utf-8?B?UnBOaWp6WGgxU1ZIdEFxT1JqOFIxeUhia1ZMK3V2eUc0MmFxT0ZNL0xreE9p?=
 =?utf-8?B?M3B6c1M4c3lQMlJ0NmJyRlZoTlh6WXUzQTJzeGZxZ1M1TG4yZGNZMkdYdHJi?=
 =?utf-8?B?SDRHaG9mdjAwb0s5bWUrcy9YR3M4cnE4R0Z0NGVHN01xeWxxRUlvanJkWDNw?=
 =?utf-8?B?L01PcnJQWnZQSlBLbkhZQUM2bXVybHpUZVJ4WWhERHp4cnBadmw4ZGtWSDNR?=
 =?utf-8?B?MUVScWtpcmNYSmRxbHdZTnhxdndIb25Fd1h5YUN3Qk1rbGZzaWNnSVRmb3pM?=
 =?utf-8?Q?jLXtJydWUiGhofuNBKHosEm+5q0JntihxL95E=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ada62262-ffe3-4a04-73db-08d92ba45183
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 00:11:39.2915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: icbQbHZyq8yotcDQGJHMKkPW4JnfnixSJ0IJG7rG74BCFv9aaljZawBwQ/ScMlJ3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4919
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 5_a7Y2pVECFH3P0iJSoHHGABLuldee1a
X-Proofpoint-ORIG-GUID: 5_a7Y2pVECFH3P0iJSoHHGABLuldee1a
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-09_07:2021-06-04,2021-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 mlxscore=0
 impostorscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106090131
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/9/21 10:07 AM, Zvi Effron wrote:
> On Sat, Jun 5, 2021 at 11:19 PM Yonghong Song <yhs@fb.com> wrote:
>> On 6/4/21 3:02 PM, Zvi Effron wrote:
>>> +     opts.ctx_in = &ctx_in;
>>> +     opts.ctx_size_in = sizeof(ctx_in);
>>> +
>>> +     opts.ctx_in = &ctx_in;
>>> +     opts.ctx_size_in = sizeof(ctx_in);
>>
>> The above two assignments are redundant.
>>
> 
> Good catch.
> 
>>> +     ctx_in.data_meta = 0;
>>> +     ctx_in.data = sizeof(__u32);
>>> +     ctx_in.data_end = ctx_in.data + sizeof(pkt_v4);
>>> +     err = bpf_prog_test_run_opts(prog_fd, &opts);
>>> +     ASSERT_OK(err, "bpf_prog_test_run(test1)");
>>> +     ASSERT_EQ(opts.retval, XDP_PASS, "test1-retval");
>>> +     ASSERT_EQ(opts.data_size_out, sizeof(pkt_v4), "test1-datasize");
>>> +     ASSERT_EQ(opts.ctx_size_out, opts.ctx_size_in, "test1-ctxsize");
>>> +     ASSERT_EQ(ctx_out.data_meta, 0, "test1-datameta");
>>> +     ASSERT_EQ(ctx_out.data, ctx_out.data_meta, "test1-data");
>>
>> I suggest just to test ctx_out.data == 0. It just happens
>> the input data - meta = 4 and bpf program adjuested by 4.
>> If they are not the same, the result won't be equal to data_meta.
>>
> 
> Sure.
> 
>>> +     ASSERT_EQ(ctx_out.data_end, sizeof(pkt_v4), "test1-dataend");
>>> +
>>> +     /* Data past the end of the kernel's struct xdp_md must be 0 */
>>> +     bad_ctx[sizeof(bad_ctx) - 1] = 1;
>>> +     opts.ctx_in = bad_ctx;
>>> +     opts.ctx_size_in = sizeof(bad_ctx);
>>> +     err = bpf_prog_test_run_opts(prog_fd, &opts);
>>> +     ASSERT_EQ(errno, 22, "test2-errno");
>>> +     ASSERT_ERR(err, "bpf_prog_test_run(test2)");
>>
>> I suggest to drop this test. Basically you did here
>> is to have non-zero egress_ifindex which is not allowed.
>> You have a test below.
>>
> 
> We think the actual correction here is that bad_ctx is supposed to be one byte
> larger than than struct xdp_md. It is misdeclared. We'll correct that.
> 
>>> +
>>> +     /* The egress cannot be specified */
>>> +     ctx_in.egress_ifindex = 1;
>>> +     err = bpf_prog_test_run_opts(prog_fd, &opts);
>>> +     ASSERT_EQ(errno, 22, "test3-errno");
>>
>> Use EINVAL explicitly? The same for below a few other cases.
>>
> 
> Good suggestion.
> 
>>> +     ASSERT_ERR(err, "bpf_prog_test_run(test3)");
>>> +
>>> +     /* data_meta must reference the start of data */
>>> +     ctx_in.data_meta = sizeof(__u32);
>>> +     ctx_in.data = ctx_in.data_meta;
>>> +     ctx_in.data_end = ctx_in.data + sizeof(pkt_v4);
>>> +     ctx_in.egress_ifindex = 0;
>>> +     err = bpf_prog_test_run_opts(prog_fd, &opts);
>>> +     ASSERT_EQ(errno, 22, "test4-errno");
>>> +     ASSERT_ERR(err, "bpf_prog_test_run(test4)");
>>> +
>>> +     /* Metadata must be 32 bytes or smaller */
>>> +     ctx_in.data_meta = 0;
>>> +     ctx_in.data = sizeof(__u32)*9;
>>> +     ctx_in.data_end = ctx_in.data + sizeof(pkt_v4);
>>> +     err = bpf_prog_test_run_opts(prog_fd, &opts);
>>> +     ASSERT_EQ(errno, 22, "test5-errno");
>>> +     ASSERT_ERR(err, "bpf_prog_test_run(test5)");
>>
>> This test is not necessary if ctx size should be
>> <= sizeof(struct xdp_md). So far, I think we can
>> require it must be sizeof(struct xdp_md). If
>> in the future, kernel struct xdp_md is extended,
>> it may be changed to accept both old and new
>> xdp_md's similar to other uapi data strcture
>> like struct bpf_prog_info if there is a desire.
>> In my opinion, the kernel should just stick
>> to sizeof(struct xdp_md) size since the functionality
>> is implemented as a *testing* mechanism.
>>
> 
> You might be confusing the context (struct xdp_md) with the XDP metadata (data
> just before the frame data). XDP allows at most 32 bytes of metadata. This test
> is verifying that a metadata size >32 bytes is rejected.

Right, you can keep this test. Previously I suggested to enforce
sizeof(struct xdp_md) as the ctx size, but that may be too restrictive.

> 
>>> +     ctx_in.ingress_ifindex = 1;
>>> +     ctx_in.rx_queue_index = 1;
>>> +     err = bpf_prog_test_run_opts(prog_fd, &opts);
>>> +     ASSERT_EQ(errno, 22, "test10-errno");
>>> +     ASSERT_ERR(err, "bpf_prog_test_run(test10)");
>>
>> Why this failure? I guess it is due to device search failure, right?
>> So this test MAY succeed if the underlying host happens with
>> a proper configuration with ingress_ifindex = 1 and rx_queue_index = 1,
>> right?
>>
> 
> I may be making incorrect assumptions, but my understanding is that interface
> index 1 is always the loopback interface, and the loopback interface only ever
> (in current kernels) has one rx queue. If that's not the case, we'll need to
> adjust (or remove) the test.

You could be correct. Please add some comments though.

> 
>>> +
>>> +     test_xdp_context_test_run__destroy(skel);
>>> +}
[...]
