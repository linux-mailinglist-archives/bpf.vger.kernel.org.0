Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092B9618D66
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 02:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiKDBEr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 21:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKDBEq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 21:04:46 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAF0E91
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 18:04:45 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3NTgHW014052;
        Thu, 3 Nov 2022 18:04:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=MS0jck8h5JcoRQQXr1qK3Y0kYqskMKfCbjcuPIaa+l0=;
 b=ftfdq3RwceEjXELKJk7j/UHazDFALtHynqaADaspDDPg9ENxdv6kTtLLin8y1VRtcKSJ
 AwxKkC3eKBATwJzwU64f2sl4dGUQCadWYXfzvPPDIZyoEuOOkPQ4p5w5AnlDdv2JoQEp
 ztIUJuoXjYnGH0hW8I2bWBLCvxplnQTL51LrRVsmNrbIlwKLgzpQCuaM/DJr11uncJXr
 4ETv1wEzoLWC9lvb1PRnxWgi2mZ4KLIPwSqVDFocLbVyfcVJF8g9vRjMT3FWyjl5cn3H
 KO8XGcX0YBfCmOLwy92Mzf3RcrbhxjC12BuLc67SP21SaoVbzde0iVP7+3iefnUWDdXb pg== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kmqbn8kck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 18:04:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cq8W1bAekR+GrhZNrGJ0k3ZaL5gLNU2aGKL5ThRha+5Z3uXpZAgkCVgVPL1QFqufyyJ4TDF25niSnkQQJqmqQ9LEjwRwV6aTnM9KtGxNn7GIt3ZZz7YZZcdYl6yE2u84vYau9fccxmug9q7mk/1csXM+scymF5UyDzyPDqYDDkWiVc61XlaTCrqususVG8o3C6qasHC1aNVe0hrINDmp0hGthBiDCBlLF0bG6VAJyFzKAztB/xLDpcbJgrvIwU5e1fRidoRHrfHyNO+HPcjOv+9gIZ8YITGtmIDDiwJfTfZeisZlaklsqH557/y0OK+0kZxlAye0WoAS/oX4K/pklw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MS0jck8h5JcoRQQXr1qK3Y0kYqskMKfCbjcuPIaa+l0=;
 b=kNIYXBsclT1AeiRSPYL3bxKzJJR2OEMPjKlwLdQR7yCDrdljX2QMrwt+IBlOwvIYkAKvyIVC3z4hIUfzUJUGrVzqyxfD/5gVqUZecGfV52fzubgpUUXZ/O3iHcb2jegu42vbD4zMccQ97w82ouE2B9KqqxqrI99mpDFb5EmPkPVskI9+XCYUJ5XDeYgbA3+7uWG2d+jU3pMRBlHSLDIEmaENV4q6Q+c8tnBhTkfNPEx/Ee4+GU+4GM0VO318ZQvaOlHtUfvdjHTUyNxHJSzB7hGDcx1I0pwrgcUSeETdFKCOTexj0tXep/DDWkuRgEVKeg6stUZCC447uVzhlOxT1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MW4PR15MB4490.namprd15.prod.outlook.com (2603:10b6:303:103::23)
 by MW4PR15MB4681.namprd15.prod.outlook.com (2603:10b6:303:10a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 01:04:28 +0000
Received: from MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::c42b:4da0:5bf4:177]) by MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::c42b:4da0:5bf4:177%5]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 01:04:28 +0000
Message-ID: <2eb74220-7e73-7316-8739-44e5117a8b59@meta.com>
Date:   Thu, 3 Nov 2022 18:04:25 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf-next 2/5] bpf: Add bpf_rcu_read_lock/unlock helper
Content-Language: en-US
To:     Yonghong Song <yhs@meta.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20221103072102.2320490-1-yhs@fb.com>
 <20221103072113.2322563-1-yhs@fb.com>
 <20221103221800.iqolv5ed2muilrgq@apollo>
 <d9e7c760-a581-8633-f41a-3e5d122ffc9c@meta.com>
From:   Alexei Starovoitov <ast@meta.com>
In-Reply-To: <d9e7c760-a581-8633-f41a-3e5d122ffc9c@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::17) To MW4PR15MB4490.namprd15.prod.outlook.com
 (2603:10b6:303:103::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR15MB4490:EE_|MW4PR15MB4681:EE_
X-MS-Office365-Filtering-Correlation-Id: 630e6d27-8732-4182-d58a-08dabe008605
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iZjMJbq2iRNUsJjPq7cdue5bQbFCa3kpzDxySztz71lD6AUVNJ+4DjIb96W4U/Mppcf2ysi1gg/1emfwkI5Wa4kfSdEKjfOMXNZZR/cmm8JWNdVduCT1SYS8D+bh0jxbIXvfWRX8qxzZ9HdfeymzY58IGuKBXCxPcK+uSrht/W0LD3fr7HFAEegXWrJ2OoaTk8GgbfsLH2i/cnnqL7ihS7Gnmg0o20uqWd7ocNOJLG1IcPi0tFlE7inL0BG+GwnTr+YPuqrTZU7MO/1mf/bXYzqgC7ASEoN2wlLRlWjHKBTFR8h6+RAJzF8xwT42f8smQosNHFCby5uGD+mJ94Tuo4N1vT11ZysmIQIPkslYYyskZquqZvjrwLrcl+B14d9xMHV5E9MK6eyrgb94n3oXQTiXaadL/jxKpSkR0t1WS6yryJU6vsHJ/PBKgkccj9fzzQpvPudp/6bfC0MUp4irYimTyzd8If/8NF1bnconW/ePhZTjwy/fgjiWPcQSuUsIon3iDe+cOf5Us8bURReiqh/WnNUy5Kg548M3WBYLQCXoMKZqdwyWfWRDu2rvwBLpRKNP975wT+Ta31a4ynVoYTM5zTDpTtXJz9SMtG68YOa/6T4g5dCLvqdEx/tqj8KoW9TgqgH2ui/P9zQC+3UaPbjENkM5AtyuB+lZt4SHev+8F2okr+r3xzZZe9HzVNyD7d539srpUxDhRsTGAZ3RlVQ8SP/PV/y+m2y3PEueP/aTquSIRJ88nUd4M6bqw4zPh2FM8DNEb52g97Lmjghz5XoP3d29q4oSpA98q5nPMwI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4490.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199015)(6506007)(53546011)(31686004)(31696002)(6512007)(8936002)(86362001)(2616005)(8676002)(186003)(5660300002)(6486002)(6666004)(4326008)(66476007)(66946007)(66556008)(478600001)(110136005)(83380400001)(54906003)(36756003)(316002)(41300700001)(2906002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmtidHd0M1NaK2lnZDFQV1Fab0UzL3JuNFhOWXZXYXJRY2labDVZdlhFRTg0?=
 =?utf-8?B?RG1xYllQbUZUTTdmT3c3eHRpdHF1QW9sb3ZGQkpsNzhRZHB6ZjN6dGRyQnZV?=
 =?utf-8?B?RXlEN2g3ZXBJUzhyVm9zVERkV3ZRWWNGSzhuSStrc3Mwa2k2bjJvbzhLMGVB?=
 =?utf-8?B?YzVIRWJhcC9TcGQ1TGJwaXc2dldNUUVpTHQ1bExlZEJ6WWtDekxXMnFZM3JC?=
 =?utf-8?B?UEFiS0tkZkdteUQzWDNYQ2tTMDJYVDNzTloyUkJ3ODV2ejVqZys0RU8xT3pW?=
 =?utf-8?B?NG5MUCtvTDJ3d21PWFVGZjZ1L0ZFYjMvZlJjcGMzVUd5Zy96Nmp1OCtQRTRW?=
 =?utf-8?B?ekNTM1JJcnczQWdLL0hiYlRuVXZsdnN2elp3eUs0Ylh3Sm53ckRqdlJWRGlm?=
 =?utf-8?B?MXFLL1g4TjhPUGVnTExkT0FYSjFWaVdwM2IzU21ib0h6MW4yRWdtbTB4a0Ux?=
 =?utf-8?B?SlZOcU14T202dmNiMkFIVmpYRENUVzVWT21iWFk0QjBsM3RpcW9Ga0txNkRs?=
 =?utf-8?B?RVZTR1lBSmVNZGt0WlhDQXN3Zi95TnhtVXpXc0FUUENyVDhSa2xoV3VOSzkx?=
 =?utf-8?B?SklJNk9aRHdHV3NjWXNPWDhJbHU0ZGNxN2x5VEh0VTE2TjhSRndlZ0dCc1Bo?=
 =?utf-8?B?dy9CaVZFM3pHdGdPWlNXNytidGtNRThKdHp6aFBLQmNVTjY3SExyV00yamE0?=
 =?utf-8?B?VUhTblpSUU84aGhxdlNhdzIvMlExMEp3dXBaQ0krWUFHQ1JaL09aUlRxREFO?=
 =?utf-8?B?Q3hXWnR3SEsxQVl0TzUxTkxnZHFHQTdnMUt5QXAxQWphNU9sVUI5VjI1ZnU0?=
 =?utf-8?B?SWhGRkhmblFMMDNxUUNWdkM1dmtCdlBvRFJMWjJNaVllS2MvMDRMOHRQUTVI?=
 =?utf-8?B?U202TkhXczhSVkJrcE5uYWV2MFdvR1VlbUdvUGIyQlA1YVR1TnpialNqdG8r?=
 =?utf-8?B?cnVpSUJ6WHE5b3VtdVRYRTJ2d2s3U3hlaUZ1TXp2WHJxd2JXSjl2bWJWa2p5?=
 =?utf-8?B?SXBsVzRucUJpNmlxWEF2SGhBREErWGdITzhLenMza2IrQTRFVENhN3hmRDJv?=
 =?utf-8?B?SnZSZkVHWklSYlRMaVhibEd6L2NmUExkL2NXUkNtNFJNZ0RlYmVaOUtBZzNt?=
 =?utf-8?B?c2pLTkpubmFqUXJkelQ3YVpLZTMrSEVyTTRIbU0rVzNWa3dsVmhuWEVzTytU?=
 =?utf-8?B?Wjl1N2V6S3VCQk1EalMyTWpWRkFtTXA1dUhwMjFGS1hPb2Z6cnNSZ3BFaFJW?=
 =?utf-8?B?VTJXVzJKUVp3SWJHWHZoOGZPL3NBOG9oWW5jSytOVEtjYXdSTmYvSHBtczJQ?=
 =?utf-8?B?NWd4Q1dKdWtadWNNSHlIVjkyWkNDVnV4aU9IcEk3Vk5pbVdZN2hYL09CMnA3?=
 =?utf-8?B?TXFXc3RuSXBEN0wycG1lTWNkTUFFRXpYWTNET2s1M2hmK2UyY2JRaDhtcWZh?=
 =?utf-8?B?VElQRTR3SU9mVnJYNytjYWxES0hvcE9DTVNWUXhKdmRvMDdYSzJ2SExzL1Fp?=
 =?utf-8?B?Z29GWUU0STVVWW8rZTVFQ3dRMFBadEpHY3VweGszdExTb3RYUEEvVFlHQXB2?=
 =?utf-8?B?VHVsSUtqRnZTbThhZDAvc2dtUTJPV2hRZVUrdmJHb2w4NW04QTNxQWJ2WXpE?=
 =?utf-8?B?MDBScmRhOHZmN0xQcHpzL3g5OGZUeEdmUGRIMmFuSURZVWc0c3cwd3FNcTZH?=
 =?utf-8?B?R3pLOGUxeEFLSnJmMzZLUjJ0TWY3ZDFRYS9WMzREY3BmR3dwajVpV0RNaGo1?=
 =?utf-8?B?ek5ML0lwUTRBdll0NHZkVFNDVHFlRjZVRlE3Z2w1ZzBGTEdQeDFYMmx2eEFT?=
 =?utf-8?B?b0xpK0IxUkZOaEh0TmFwVW01NVFWSlFrSDJjc1F4SGJRM29zMDFGWFdNK0lm?=
 =?utf-8?B?UkM1RXF2bUpla1VSNGZZcTkxSjBaM3U3ZUoydHhKYjJ6azZYYXhUamlJa2RD?=
 =?utf-8?B?OHVBUjZscHM2c3JCVENIMGZqMm1NbzBNdnQrdjU0dnB5NHd4MTEvQmZPVU94?=
 =?utf-8?B?NWlqNWxBYWIvTGxvNWpkYVdPdnlxME5uZzAyTXdnNjl1NVppU0UxYm4vY3Rm?=
 =?utf-8?B?R3NhR1FCbmxDMUo0clFCM2tpZXZ0N0laT1BsVHhEWk9PWnByNlFEWGR0T1Zi?=
 =?utf-8?B?T3ZhMWtxanBlaHFJMGt0RHdBOFNRbXh3dlYwd1dDMWk2enViRFd6L2NmazBN?=
 =?utf-8?B?K3c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 630e6d27-8732-4182-d58a-08dabe008605
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4490.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 01:04:28.6339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q2B+QI1b1nYUxmLQ8S29J2l60Hm/V4vkkTQTqZ8onAlqGWFP73fZ/B3WDLlMnI0Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4681
X-Proofpoint-ORIG-GUID: v_EUSAqV6pmBA-FP3tQNXlJiX-TlBj7y
X-Proofpoint-GUID: v_EUSAqV6pmBA-FP3tQNXlJiX-TlBj7y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/3/22 5:30 PM, Yonghong Song wrote:
>>> index 94659f6b3395..e86389cd6133 100644
>>> --- a/include/uapi/linux/bpf.h
>>> +++ b/include/uapi/linux/bpf.h
>>> @@ -5481,6 +5481,18 @@ union bpf_attr {
>>>    *        0 on success.
>>>    *
>>>    *        **-ENOENT** if the bpf_local_storage cannot be found.
>>> + *
>>> + * void bpf_rcu_read_lock(void)
>>> + *    Description
>>> + *        Call kernel rcu_read_lock().
>>> + *    Return
>>> + *        None.
>>> + *
>>> + * void bpf_rcu_read_unlock(void)
>>> + *    Description
>>> + *        Call kernel rcu_read_unlock().
>>> + *    Return
>>> + *        None.
>>>    */
>>
>> It would be better to not bake these into UAPI and keep them unstable 
>> only IMO.
> 
> rcu_read_lock/unlock() are well known in kernel programming. I think
> put them as stable UAPI should be fine. But I will reword the
> description to remove any direct reference to kernel functions.

tbh I also feel that kfunc is better here.
Sooner or later we will need srcu_read_lock,
then rcu_read_lock_task_trace, etc.
bpf shouldn't be a burden to RCU.
