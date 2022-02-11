Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4384B306C
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 23:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbiBKW2T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Feb 2022 17:28:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239789AbiBKW2T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 17:28:19 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F7CD4E
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 14:28:16 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21BLJ7O8003366;
        Fri, 11 Feb 2022 14:28:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=M+X/27ir7joiXO+eWXxCe1Yf5Fw89RUjH2DT11o1oJY=;
 b=kN6Ein5mSZnmWppMsjAlCiJgsB1ptqIn0dp6NnYTdc6Xg4EbqbEmifrgdPEwHBHt6rfb
 1RQEnG1HdpJc30CMu6KD08GSZxdpECI+rPnfHJMRqy5/rG+7MWwlWCm1eGY2yy/bJEw/
 M5RmyaZT15Pm5clH5KL/Ztprb+Aunmt+KtE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e58ya1av4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 11 Feb 2022 14:28:00 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Feb 2022 14:27:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lO0zGwdCFXEZQFIIzYp2TLA8FK3PI2fs8TtUfvM20ZlnX7uKqrVoPIR4LfjKElYQaHKGAmdMRq6WSmfqlFEnZba6Z9fMBZSDevH2p9g/UleS5qqGc3yVFBf7piF726l23LJ7LAz+ErPu9kh2BbrmdbtDKqvY7Y5iUMPPxozBPkyCnmCK6ZRZKG8sRGgif9Y4eNMNxmkM4+7kIu0h52PMMA+H5+zBPkvAvrTsxYDBybkPp/TBLEUVAqyri8PsV5iAXc8kOZ30UxU6lZVO8wllTArFiFmapIq39UK3ZLShFsyMtRwP9Z9x6El5e8Q1zLeiezvbR30VjJH/ZtcGpYfoAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+X/27ir7joiXO+eWXxCe1Yf5Fw89RUjH2DT11o1oJY=;
 b=j1CFAZBrZmzvXk+HhQOW/uIaXL9OrGqEKRZfNg7xT3o5NPYoQjwyvS76DxS4G6OaiGVsXSXWxdQUZlzn2L0gwj7HfQlU3z5BnktLUE3gu3wKDmEgXG/3EKe5pIJZ9iq11TraBGr23sL8V57THlJbCtA28AoIr1BSrH12PXNMLxDjSSPrpiUeKrEwEWXI8onnq6zPu9YFVLVEwCzNkyPGGldlrKowWQzTRprj6aujTZ36BfO6PH3Do1+U08Ij6vMGi+N0b6kKGAgSGcAW+1tfYC8rFP4uR2iUIDRlxHan8W174H5503bYW/v6+4VI8yW4NFFiWWnkmYgl49i55GjrbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by BN6PR15MB1764.namprd15.prod.outlook.com (2603:10b6:405:4d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Fri, 11 Feb
 2022 22:27:58 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::c5d8:3f44:f36d:1d4b]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::c5d8:3f44:f36d:1d4b%6]) with mapi id 15.20.4975.011; Fri, 11 Feb 2022
 22:27:58 +0000
Message-ID: <a28dbabc-988f-af20-5612-acc09ff82656@fb.com>
Date:   Fri, 11 Feb 2022 14:27:54 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH bpf-next v2] bpf: Do not try bpf_msg_push_data with len 0
Content-Language: en-US
To:     Felix Maurer <fmaurer@redhat.com>, <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kafai@fb.com>, <songliubraving@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>
References: <df69012695c7094ccb1943ca02b4920db3537466.1644421921.git.fmaurer@redhat.com>
 <cd545202-d948-2ce5-dfae-362822766f90@fb.com>
 <f18b9e66-8494-f335-13cc-a9b30a90e32e@redhat.com>
 <22d98cc5-26fa-8023-3a85-a082a9e08147@fb.com>
 <a2665ecd-12b0-e520-2061-ec8caf1d076a@redhat.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <a2665ecd-12b0-e520-2061-ec8caf1d076a@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: MWHPR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:300:4b::33) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81731f18-1782-4a2a-7dc2-08d9edadc173
X-MS-TrafficTypeDiagnostic: BN6PR15MB1764:EE_
X-Microsoft-Antispam-PRVS: <BN6PR15MB17643DF5815CDA1620391C2CD3309@BN6PR15MB1764.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bTHlFc8KgBkx5qwN6+4VfnIxW3x0RhtTl7oaYRX0DE2p2EFFCwsYpxMhKiz2b8p7oRl6l0Pr2lytYe644CzVW05YxgZj1PWsydwf9CJayfZlF7xhfmWQD4r4Tuof2cKbr28VJQrF6OqKBoFQHRyohUOF1Qoxoo+J1pNwnd9cX7C0TQqVbzZhxAEZZHrL+LBH8MMmAN6pkR7IN+5gQQ/NPTCcKQBhHaYfB8HB/yZ/Gr6g+sIbCexiTTjBOi76CpdyOSes4Ifc1TRK8grDPlPpWyurG3Rssrzku056y0rFOXwLbOX1ZR37ag343ycUgkYiCRLAtKjKxWuNUMqnh7JxAyTJvmrBvOLKTHH1bj59/akl4dVaVfTrlDXwAVPh/AIo2q92KK9VUxKFAM9qGYI5vt7rGGR7lXnXCUepwPxFBm7v95yLSgrCQE5+sqB2qkCzhcXPrTjJLPUDqFf97KCaklnBeo0bpR19YWwC2U964iTfPaGqrCUgnESjI+zdp3o/uiixpDMmEaSlOJM833oKSf9QYTm3mLoUq4sBzPy6e5L4tnJAs9F30G8Se8Pb5pSsqP7J+/KNSGR1Pw3/4wxsYbiiFkD1dUTtPLSOYAptEePz7acLwwtZ729oJUGmbEO+1oEOh4aAgdaB+89cBZRVOx3EzNpwHrLtrcFCrBny6HYaVQgbBS9ImpRE7fT5YbyZRcsJ5ZXZLrA0jJfjHvbIKfWv4iUfJfD93K/YOrg1uflSpe0d3OwMlBqt31OWum6UP+L0n7ZcYT8j/gCvqJY80hMX16j/sfiHmMNI6lsA7XrUnOKj8EiUNzcwOg40/nLs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(66556008)(4326008)(8676002)(53546011)(52116002)(66946007)(6666004)(6486002)(316002)(8936002)(508600001)(66476007)(86362001)(6506007)(31696002)(83380400001)(36756003)(2616005)(6512007)(31686004)(5660300002)(186003)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3dTZlJ0WUNlakNvOHZQTWw3aFJqQ3pnY0ozRTREcVZpWHQvMVpEcjQrb09D?=
 =?utf-8?B?RHUyM3FaM25RRGQ1RFJvOVY4Q2ZqSlh1cEVUYk5oQiswSC9yUmFJTkZrdGhL?=
 =?utf-8?B?TU0wNWJKY3FkRFRVOTNZUWFRelM0Mkd4ZUNvaXBzcGpMalhXOGRCTGtScFdm?=
 =?utf-8?B?V21PQTZxV3hqbnV2aUkyZ1VaSFdIaERKTFRzYjlmZGZjVE5PcjZKOWxNWFdQ?=
 =?utf-8?B?YlVkSDZlNkJMMFYyb0Q1WTFyS29ZU1hYeHREby9SM21nc3hqVU51NGlFV2pu?=
 =?utf-8?B?eXZwNFVqQi9CRjVwWU05c251S3hadyt5NFppSit3N2I0THpMenBHZC9rRmVP?=
 =?utf-8?B?ckYrSmthaFFyd2dlamJMUXFxSFNyV1hSQXlXT0t3dkJUbWVsczdmUW5WSlRZ?=
 =?utf-8?B?L1V2MXJOZ3hwRFpkRzZsL25DR3RKZHBmdk1iZ0Q0N2J3UWpzVHJ2SGxVZjU5?=
 =?utf-8?B?Q0ZUMk4wcHFNS1JxZTFlWmpqNUk4Um5WOVV5N3VSYzNiVlhFdjVFek1hR2RT?=
 =?utf-8?B?TDdZK09wc25BUXRzYWNvTkVrdkx1MndRZ1R4WGlkQThmMDEzb2l2bTVJdENV?=
 =?utf-8?B?cERXK3gvRS84VlJlRUI4ZnpHMkpRNFg4YzRrRHpjdnYxYXB0N1hGbmhuQk1J?=
 =?utf-8?B?d0s0cTk0Y2FraytrdGhyMTVwOUFYM2xpOFJyaU51ZXJWSVBIeExJTU5rTFBz?=
 =?utf-8?B?SmY3QjllYXVmL0pCcXFtODAvNVVVTzdiY094M3d6N0ZhM0hWQjhSMURyZE9C?=
 =?utf-8?B?VXp5NklxVDY0QXZLaU5BVUg4THFuYjRrVldpZG1TdDlNWEpzelZocnY3aXNx?=
 =?utf-8?B?UTNBdm1vczNCVG94N3VlQmtmMFIvZVlBekVGbkFuZXQyWkhiUTZSam05U2Nx?=
 =?utf-8?B?dS9Hcll4eGZMTXFBdEZCdVlvYmlaRml1T3JwaVNQdGhYUDdtWGlBSGZWMWpZ?=
 =?utf-8?B?dFd6REUxL1o3cHB5NjFqMXplY3NTcVlSTTNEYlI3eW0vbWlpSHI4Y0RYY2dX?=
 =?utf-8?B?bHhYTytYUksyaGlUa3lROW5xamI5dEdGWGtkUWViL0w4bHdqbmxHMkFKNDdY?=
 =?utf-8?B?WXU1ay9ad25QTC9sYnkzVWk0SFRFbElOVmZmeWNDZXRrQWhuT1B4a1JrRTdn?=
 =?utf-8?B?RU5mbWcxODd2ajI1cW92YmZhQzE1VEpRYWI2QloyUldNS0VqWXZjeTk3QWxL?=
 =?utf-8?B?Y0pTNzNkMnZEMXZ1ZlVjYithUHoxU3pONnVrTVNBai9XcFBYR1R2b0hKSlFv?=
 =?utf-8?B?VHVoT0lOU1EwbmZyeUd5QzdYZ2hlUVBxUUNra1FRSWpHNWFYaGQ0RTFBNUxn?=
 =?utf-8?B?MkVBZDRkaXJkOS9iVVl4bndKVXNhWm1hYVNzd2hzMHZRVWl3a0dHOUE1S3dv?=
 =?utf-8?B?S2NKWmdvdktld0hFZVJpMENXTzJ0VDZiVG5wRHc4WlcyRFllTFppbVh0Q2pW?=
 =?utf-8?B?N294NnMwSmx4Unp1VkNZMFVLb2RlY0I1VENCNUJVT0xtZjlma3lzOVUybExv?=
 =?utf-8?B?RmJ6SVAwYXFrQ2YvaENUTGk3MTBwSDN3cjVBOW96NjNlVXVQVFRDQW9WTGNi?=
 =?utf-8?B?OHBFMVhKSDlrYTlwb1ViMEw0eklmcUdjZlpVZ0EwdE5FYjZFUi9HRHFQZzd6?=
 =?utf-8?B?SytUa1oyeWwzOCtXb3JyWjd5aDl5dW1GaEYxaEJxUWx0NmxzRGdOYmxCY0pp?=
 =?utf-8?B?WHlkM2ljbUFVU1FpUjloOUV0STAwQW9jaGtGcFh6Vk9PcVp6QlpEeTJvWVpo?=
 =?utf-8?B?SDIwNXBIclVkaW5GT0U0TW9FRlQ3ZERyTjd0eGpJVkp2NEdhWFY5MXM2Mkhq?=
 =?utf-8?B?L25oelJFbG1OZ3FUY3NHN0Yrdlc2akp5Q1hsQ3VIZzhHVnlabDdHM1E4K1Ru?=
 =?utf-8?B?aHNybVc0RCtLM2hySjllOHZ5M1lXSEtMa0Myb0RpdVFLSlNKamhWZXlIZVpB?=
 =?utf-8?B?OWUybUlNNnRZdWpYOE13c2l2UzFURmtoUHNUaWY3RVZGeUIzSjJFcUZNelZq?=
 =?utf-8?B?RUVCcW5GRkhIWVE5bi8wekE0VG9BV0srcVNUSnB3MWdVd21oYWVtbVNoL2hH?=
 =?utf-8?B?RGZkQTlRNEtwMXg3akpvM2ZyMDRpaVdjOXpjUGI1blhPWmpoOWoxdWVoSFMr?=
 =?utf-8?Q?KxpJoSOzqPPDGv6fHjUE9tRfi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 81731f18-1782-4a2a-7dc2-08d9edadc173
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 22:27:58.2207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6RJM1kLhF+VIjGWb+sHip+fQyk4NiSEBTLpAw1D//62IcMGqTk238k9KzLP/ArkN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1764
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: cgVBAFHBfXt6Sx6Pu5MTiGVLgJ0iDX81
X-Proofpoint-ORIG-GUID: cgVBAFHBfXt6Sx6Pu5MTiGVLgJ0iDX81
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-11_05,2022-02-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202110112
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/11/22 9:52 AM, Felix Maurer wrote:
> On 10.02.22 19:04, Yonghong Song wrote:
>> On 2/10/22 7:45 AM, Felix Maurer wrote:
>>> On 09.02.22 18:06, Yonghong Song wrote:
>>>> On 2/9/22 7:55 AM, Felix Maurer wrote:
>>>>> If bpf_msg_push_data is called with len 0 (as it happens during
>>>>> selftests/bpf/test_sockmap), we do not need to do anything and can
>>>>> return early.
>>>>>
>>>>> Calling bpf_msg_push_data with len 0 previously lead to a wrong ENOMEM
>>>>> error: we later called get_order(copy + len); if len was 0, copy + len
>>>>> was also often 0 and get_order returned some undefined value (at the
>>>>> moment 52). alloc_pages caught that and failed, but then
>>>>> bpf_msg_push_data returned ENOMEM. This was wrong because we are most
>>>>> probably not out of memory and actually do not need any additional
>>>>> memory.
>>>>>
>>>>> v2: Add bug description and Fixes tag
>>>>>
>>>>> Fixes: 6fff607e2f14b ("bpf: sk_msg program helper bpf_msg_push_data")
>>>>> Signed-off-by: Felix Maurer <fmaurer@redhat.com>
>>>>
>>>> LGTM. I am wondering why bpf CI didn't catch this problem. Did you
>>>> modified the test with length 0 in order to trigger that? If this
>>>> is the case, it would be great you can add such a test to the
>>>> test_sockmap.
>>>
>>> I did not modify the tests to trigger that. The state of the selftests
>>> around that is unfortunately not very good. There is no explicit test
>>> with length 0 but bpf_msg_push_data is still called with length 0,
>>> because of what I consider to be bugs in the test. On the other hand,
>>> explicit tests with other lengths are sometimes not called as well. I'll
>>> elaborate on that in a bit.
>>>
>>> Something easy to fix is that the tests do not check the return value of
>>> bpf_msg_push_data which they probably should. That may have helped find
>>> the problem earlier.
>>>
>>> Now to the issue mentioned in the beginning: Only some of the BPF
>>> programs used in test_sockmap actually call bpf_msg_push_data. However,
>>> they are not always attached, just for particular scenarios:
>>> txmsg_pass==1, txmsg_redir==1, or txmsg_drop==1. If none of those apply,
>>> bpf_msg_push_data is never called. This happens for example in
>>> test_txmsg_push. Out of the four defined tests only one actually calls
>>> the helper.
>>>
>>> But after a test, the parameters in the map are reset to 0 (instead of
>>> being removed). Therefore, when the maps are reused in a subsequent test
>>> which is one of the scenarios above, the values are present and
>>> bpf_msg_push_data is called, albeit with the parameters set to 0. This
>>> is also what triggered the wrong behavior fixed in the patch.
>>>
>>> Unfortunately, I do not have the time to fix these issues in the test at
>>> the moment.
>>
>> Thanks for detailed explanation. Maybe for the immediate case, can you
>> just fix this in the selftest,
>>
>>    > Something easy to fix is that the tests do not check the return
>> value of
>>    > bpf_msg_push_data which they probably should. That may have helped find
>>    > the problem earlier.
>>
>> This will be enough to verify your kernel change as without it the
>> test will fail.
> 
> I just send a patch checking the return values of the bpf_msg_push_data
> usages in the test [1]. Passing the errors to userspace by dropping
> packets is not very nice, but a straightforward way in the current test
> program.
> 
> I did try the same checks of the return values of bpf_msg_pull_data, but
> then the tests fail. So there might be something hidden here as well.

Thanks for the patch! Maybe this can be the first step to fix
test_sockmap.

John, could you help take a look at the patch?

> 
> [1]:https://lore.kernel.org/bpf/89f767bb44005d6b4dd1f42038c438f76b3ebfad.1644601294.git.fmaurer@redhat.com/
> 
>> The rest of test improvements can come later.
>>
>>>
>>>> Acked-by: Yonghong Song <yhs@fb.com>
>>>
>>> Thanks!
>>>
>>
> 
