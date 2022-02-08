Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5331C4ADEDA
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 18:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbiBHRDs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 12:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiBHRDr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 12:03:47 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E859BC061576
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 09:03:43 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 218E7HhV008734;
        Tue, 8 Feb 2022 09:03:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=oL5iI9YNI4oaRLVyItfkKS6aWSbs1k5EX+QlDc0aXRI=;
 b=RbFEab+npKF48TUxuiMkVP5WJOmjWONZB0o09RFBBls+Ol3HnewoPyukW1AHJvLsWDfX
 qmeQyqptvfvZTk2lPoKZsb6VTRvjhbInuR1Bpp4oC5ZtbsCW+XElifVU0EEg0eTcTNdz
 PJSA+qCUHn4xbbWOumoo1J/IddusYQE7TUg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3e36q88d0e-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 08 Feb 2022 09:03:05 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 09:03:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZE0IU7BLS7qhZoe9wp0rOZozgywcYCxvRZNiGCi+E+XmYXdDbkvHM2FvfShiceKq44VWS6bstddllVhEeuMYZYUcH+xioKsNIDWnHCoDnw2w6svV9teyFeJCsUXDROa2kf5unMi4yL/Y1uux94DxvMyzEDYZyz8E5AbxDje98De3dcv10h4KLA9IFCD/daadxnIEI0HSGZzCHC3bdby4P7pfU2EqtGwkxVzI+WjzgcOIaS+gNaUM9s5GYoLW4UZU3a2buxakXvnHH2/uesbhuJM6GWE9yWMduFOQyM87iqDNRpKHL4wdkVroQ6K+4O+dj+BcPopi0zQ+MGz4lzxLng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oL5iI9YNI4oaRLVyItfkKS6aWSbs1k5EX+QlDc0aXRI=;
 b=QNvYt+znf399SGf2NuuggnrKBDesvEgnEzM3AeFuE3ZmaQAvHYZS2kHtN+Hk+YqgJVLRIrh6q95EpBa80fPIiYq07am3hWsgVzRNVsgMe0+M6ELSy3JRjYfx2qrPVUqUzHslWbh8PCSyTSjOf8HIstwRTCvhhalODy1T4lPiSEpsNkaqrZQrG7xPNTh1HWPrHCD7jSLjo5sSN7kUy8KmomOHoSgA9+iKlx+MCMjWzhN81lw4+5ToCD00Fc8/hbjfl0ih7We3ga2ink7+5aHnSLn9+YHtqCOx0yRQvaHORgDHSU1sw1GC9ILYtapH1lfxHdwFqn8JonYicYpaZ/j5nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by BN7PR15MB2372.namprd15.prod.outlook.com (2603:10b6:406:81::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 8 Feb
 2022 17:03:00 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::c5d8:3f44:f36d:1d4b]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::c5d8:3f44:f36d:1d4b%6]) with mapi id 15.20.4951.018; Tue, 8 Feb 2022
 17:03:00 +0000
Message-ID: <c7dc9d3f-cc61-8b8d-00ca-f4c133709769@fb.com>
Date:   Tue, 8 Feb 2022 09:02:58 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH bpf-next] bpf: Do not try bpf_msg_push_data with len 0
Content-Language: en-US
To:     Felix Maurer <fmaurer@redhat.com>, <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kafai@fb.com>, <songliubraving@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>
References: <05989b20a8793d1ee1fa70a8a7a4328a768263d0.1644314545.git.fmaurer@redhat.com>
 <3273861b-5475-eac5-c827-c128a72c8b04@fb.com>
 <38889612-9aca-de7e-d7d8-039131a82700@redhat.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <38889612-9aca-de7e-d7d8-039131a82700@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:303:16d::21) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0a8ab96-87c5-4e4d-cfdf-08d9eb24dcd4
X-MS-TrafficTypeDiagnostic: BN7PR15MB2372:EE_
X-Microsoft-Antispam-PRVS: <BN7PR15MB237202344927B99AAD276F0FD32D9@BN7PR15MB2372.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wEjqn84YQLpQB543jthRgoDvS5lbsNiDWa8h8zMXtiZa2IGOJsr5OMlzwazsCzLp5xPkx9n5ztTW1S3+QTYJUiQW6At1SP9qrmeiCYlax2HzsbC/vBh5FtCXUUWvDM1Adqd4YX50PlNV3AzEF/+RaS47C3oWjOUlQdf40HK4qC/Mb/crfckmeDRwXKFSUdHkz0fMeX2/ArngvCp76DK76sZfh4t94SEPhPmYsokw6kTtj2yjnpfMskcxWtBFB+PqM9FZBiORm4IhCeFz/byo6pNYt1f3tmzHCQuDp2UcRMVHqCz7sdE9qGjyRswLHFA2OzmaEvcevdrvMweWpaTghSDQxGfsBvaBeub1/juHVscYSjDf9OSEOoLEk82F8JF9AsxSrDwJF3J6xSTX8dvpEvQZZFYDilObeFB37AMBxXG7R6LIQK1FCeNM/PFsll5rcre0C4qxnVa/eO6sTprVCtLzWooGba+HWsvZkVROTo71XM1JyyH4z2u1PyD9g7BL8UHXzqVc0TKkfpKUQmhTEZbQnPLnAifBHB6hTkRbjLnot/ijNy6V+VxXrfAVSnBzDen/qAWtfLBWLw/8A297GXQGW54wHJI40dO8A+7cZKU1NHTpr0BZBIX8buIUcWHm3tXOJb2bCL4SOgzTQvOnNi3FNn8HtNEQZfN+TIVMf9gSw8QU90lX14UGsDFEAsSxCe+vXDC3Yis91UXQrbNElGsXdbI5OZXzA+GddEvrglmwGzs1kaVRucTpH8nwkZSL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(66476007)(66556008)(8676002)(6486002)(6512007)(508600001)(66946007)(53546011)(52116002)(6506007)(316002)(36756003)(2616005)(2906002)(83380400001)(31686004)(186003)(38100700002)(86362001)(31696002)(8936002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjVqUEtKOVluRG95alZUUVk5MnUyMDRjVDlXR0gzS09IWjVhdW01QW9UcW9W?=
 =?utf-8?B?UmVxY3JNM203Q2E1SnZNYzJXR1Q0eTUwdTJTdnJueFRrR04vejRRK3B1T2V1?=
 =?utf-8?B?NHR5OEJWVno5WVNwSUV3Yzl5Zmp4d3VESUwrWWdRYnRPeUJSaVRXNHlqNVlm?=
 =?utf-8?B?dC9neTdpRW80aHlHaGhYWGNyY3diYldFdkRHMUNYN1FnM1c3dWsra1FscmdI?=
 =?utf-8?B?ejJOTHIyam5GV2dhbFBieGx3VWpUeHZCZ3FtWENKQUJGMWk1eDVyRTkvcnJa?=
 =?utf-8?B?SW1HNk9UTUhacGxVZmdoU3FDcldjRkRobGZtc0FNRzRibDZ0ckxXbk5EZHVT?=
 =?utf-8?B?U1ZRQnR0TnhCcTRqSW5zdnQ0NVlWUGlVcEJGT0Jjb3lxL1RQd2hSK0gwZ2ZG?=
 =?utf-8?B?Vk0rSTlrTWs0WC9TaUhwUlIydFA0MU5wRDBDY1Q3QXpYbHdhWGtUNGU3Sjll?=
 =?utf-8?B?Q2pZUGxzNTB2b20xNWR5SFpHUi9aZGVFRGVoaFFrOHlrOGlYSGRNOHFxaktr?=
 =?utf-8?B?WVduanRQWXkxWXVKWEJLWDB2eGNsSlF3NjhwVm9qeGQxTSt5K3ZuazhkUU9Z?=
 =?utf-8?B?WWZ2MU1JdW9uNHJCeUkvNVVibDhnQTZhWFQ1ZmdHL2JIUGR1SjdqYXJ4cXl1?=
 =?utf-8?B?SWhkQ0EySkNiN21mNXh0VFhFWXQ3a3FRMXZuMWFhM2Z2SmNXSFBEVWNPQ1pS?=
 =?utf-8?B?VE40SDBoTXNYeFVIQmNocU5LcHJTTHY4T2xNQXZHOExGYVhYNkNNeEpvUmFF?=
 =?utf-8?B?WEpveVNFQW15M1ZXRzdkYWRLWXZRME4zblRsSmN6NU0rR2pWT3B1YzB4aWhT?=
 =?utf-8?B?QUJKVFNqVGxCUms2b0xjc1dxMWRoanM4WE05TlhnazV4VGE1U2VCWUdLMTZa?=
 =?utf-8?B?V0dBZVVSR3J5dTlJV2IrVFd2NXV5T3NYMENWNmNiSStVWW9lRWZrUktZVmtN?=
 =?utf-8?B?Mmd6VzA2dlM4WWlLMlhGdnV1UjFXUjAzenNVNlpZM1NXYjhOSnJUUmluNU52?=
 =?utf-8?B?RnlESmtvM2UzclV1QUNkODVEaEpKVERFTzdoSkI4MlFWUXBCaGpQOXg3K3ZT?=
 =?utf-8?B?SzVIbXNyWUxRZlgxa2VsWG5TRzd4cVM5anZ3TnZyWXhYYUp4Yzd6NFN4YXdu?=
 =?utf-8?B?bmNoTkRRWU9rZ3c2dld0S21McFVRdVFhc3pSY2NZVUxWUkVjcm96UlJrSURM?=
 =?utf-8?B?MDJFMzVnamtKVWFYd0lMNnZMRGRRcXg3TUw5M2xGWTdSZWF2VGlDS0FRM044?=
 =?utf-8?B?QzZGakpYTHQrRDh5Qy9FZG45cW02RGI3bXZVU29XUWJFcVpRMzR0cnFjcVRN?=
 =?utf-8?B?dUU1NWlIZ1RkUGsrOGdwKzhodzg4ektOeDViMkIxUEtXUllKVEdKYUp1eC9I?=
 =?utf-8?B?ZUZvSkx0eTA3a2FmempicElyV1NlK3BTb2RSdkpLU2hmMHdic1JuZkM0L3lz?=
 =?utf-8?B?VFpvWFBZZ3pOZm9oWEVNNVc2WnYyWW1yVkxtTXdaMUxJTTZsbjk3RFdLcUJR?=
 =?utf-8?B?K1Bra0h3QkFaTXk2RUpZS3FSbmZDMDdSTGdmSU9VSm5SM2ZWYTF3VmVjSDhE?=
 =?utf-8?B?a2NGRytBcEJLYmtLM1lwNGtJYkFidGF4VGJQZnJlTmczU0hwODBYK3BTVDk4?=
 =?utf-8?B?R1c4NXJmVEF2V1lWRklGRWhSc0d3bEhRQktRb3IyMmZjVitGbG0wRmp6dzhn?=
 =?utf-8?B?OGtUa1JJaFlkZXFDV09PSFBWTUhpZlFrN0dabHZiVEpmNzBORk9mUmpBYm1M?=
 =?utf-8?B?a1ROQldzSjB0TmhINnpZeVk3V2g4MGFZVjIvZElnQ2l0aUVFNlIxMnZQaFV5?=
 =?utf-8?B?ak8vVjcxenNHdUVPTnFFd2ZKL204MGJLZHUzQ2tacVkzMS9CZEVDNldBa25R?=
 =?utf-8?B?V09xVVY4VTFiTW5hL1JuaGRVR2hITWF3OU01RXpMaTJRNUFWVVZjdGh5eXU1?=
 =?utf-8?B?TGNXL0hsLzJqdnBPdDlZd1Z5dDhHTkpucG95YUsyL2ppS2FreGMvbTFiejZN?=
 =?utf-8?B?VG5zWUZydHh5cHpzeHF6RXVRZ0RlRFJYSE1oQjF2bFJvR3JPM3FGR2dlOGhM?=
 =?utf-8?B?QkhqdjRKRzFKMXFpSHZJVGR6RFJYMlNkbVo5WTMzMXNGaFM1aFFHbDFuNlFm?=
 =?utf-8?B?V1J4WmlFK3B6R3pYWHhhZzZMUmVWWm50SDhZTEkxdnBKQWdmRm83bnFxVlc4?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a8ab96-87c5-4e4d-cfdf-08d9eb24dcd4
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 17:03:00.7170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7vG28E6y5RFwZc9snGCYF5snN6KWsX887UXakDXllQyQZ+PocHFoYE18/J89LYC1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR15MB2372
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: QZwylGI4-7PWz0nhAek2uioOKqBG4bd2
X-Proofpoint-ORIG-GUID: QZwylGI4-7PWz0nhAek2uioOKqBG4bd2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_06,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 spamscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202080102
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



On 2/8/22 8:45 AM, Felix Maurer wrote:
> On 08.02.22 17:23, Yonghong Song wrote:
>> On 2/8/22 2:45 AM, Felix Maurer wrote:
>>> If bpf_msg_push_data is called with len 0 (as it happens during
>>> selftests/bpf/test_sockmap), we do not need to do anything and can
>>> return early.
>>>
>>> Signed-off-by: Felix Maurer <fmaurer@redhat.com>
>>> ---
>>>    net/core/filter.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/net/core/filter.c b/net/core/filter.c
>>> index 4603b7cd3cd1..9eb785842258 100644
>>> --- a/net/core/filter.c
>>> +++ b/net/core/filter.c
>>> @@ -2710,6 +2710,9 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *,
>>> msg, u32, start,
>>>        if (unlikely(flags))
>>>            return -EINVAL;
>>>    +    if (unlikely(len == 0))
>>> +        return 0;
>>
>> If len == 0 is really unlikely in production environment, we
>> probably can keep it as is. There are some helpers like this
>> with a 'len' parameter, e.g.,  bpf_probe_read_kernel,
>> bpf_probe_read_user, etc. which don't have 'size == 0' check.
> 
> My point with this is that the rest of the code does not expect len to
> be 0. E.g., we later call get_order(copy + len); if len is 0, copy + len
> is also often 0 and get_order returns some undefined value (at the
> moment 52). alloc_pages catches that and fails, but then
> bpf_msg_push_data returns ENOMEM. This seems wrong because we are not
> out of memory and actually do not need any additional memory.

So this actually a bug fix. Then please add the above to
commit messages and also add a Fixes tag and resubmit. Thanks!

> 
>> John, could you also take a look?
>>
>>> +
>>>        /* First find the starting scatterlist element */
>>>        i = msg->sg.start;
>>>        do {
>>
> 
