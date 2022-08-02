Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707B4587EFB
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 17:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiHBPbo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 11:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiHBPbL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 11:31:11 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C314C245
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 08:31:10 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 272EW9wF013029;
        Tue, 2 Aug 2022 08:30:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=z5NR3H/rn8YKHxHcvP8BVuBEzZE2EEwJHtHrHUz5Ud4=;
 b=fjUblJ5a+AIsRFFYGrySCtN3ihK6cE6ZF65Rs9F4odEvwwGwBusiEOYbuyUgf/hBLGbt
 aC8EJ8w27QyKp2+RskCKmlAupL6IM3hWsCyijlTUZPs9Zwh2PiWXORCIolf30TImim3A
 Wd+tc3vUyjbmk5FGCkXL2Isjf8OIYtrBUgU= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hn0pk4000-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Aug 2022 08:30:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABuXUdC/6OrKAe8k6t71KzeLtyfK0afJXsPdL8K+Gz4BfE9H0BzdhcjEi9iqfHzOBmL/YVkXYsK29e5Qj7GpmpOZYDfv3eqKypdF3Uv8Ucyyr2bBQNJVZStHY4/rEDFdRjbVeDV3ysRAWz07TwHoxLdkqelbrInoA/+WkClenH4/6mZdkYIvg0AeDSvjjHE7t+WmLSiMkrjsqGrWkr4Rr0zgj0Yu3kV+TSn2DvqN8TLKLzu3qChTCThQlveYUsPxpywFjquX4PIWbWILgV4dwSl1tiB/v8YnG0hBLlN0WxbcP6ow1bxaeo862VYmryJhA8dNafpV4YXSkTo8tubqHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5NR3H/rn8YKHxHcvP8BVuBEzZE2EEwJHtHrHUz5Ud4=;
 b=YeaRe3PeZuJpXzrRXib4iPLjK0zaTMKh7bE6ZMJGh7Vnp1+rAZ9c9J8uKuszkpWgkXulJtlyzKuoEEB3BJOB7RsTDgCY9epUTlUflgUVqB1qiQlTVjy8bnjRbvnZ1UXLKxzxJ5sta90YlwKaJP+iNTUDLQIxJ0jxpyGLngfdELGjSb5VtYAtMk81OwYm0WuVmJD/XBOhiypEExBXmEgWYeNCV6yoTc2zqjRmpyTLJhS5C/OjthRYE7ftKiYVEdcb8X/069f+5xDAEMxrP6bV6HI/pAJKfC9TRwYWG0p1HW4y+6QidfrdB4GLpc+6ILtx17QfSlO7C9sWAh8Gl5xYOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4490.namprd15.prod.outlook.com (2603:10b6:303:103::23)
 by BN6PR15MB1828.namprd15.prod.outlook.com (2603:10b6:405:54::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 2 Aug
 2022 15:30:48 +0000
Received: from MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::5457:7e7d:bdd2:6eab]) by MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::5457:7e7d:bdd2:6eab%3]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 15:30:48 +0000
Message-ID: <f49fdce5-5098-878d-092f-cc55ce28b644@fb.com>
Date:   Tue, 2 Aug 2022 08:30:46 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [RFC PATCH bpf-next 05/11] bpf: Add bpf_spin_lock member to
 rbtree
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>,
        "toke@redhat.com" <toke@redhat.com>
References: <20220722183438.3319790-1-davemarchevsky@fb.com>
 <20220722183438.3319790-6-davemarchevsky@fb.com>
 <61209d3a-bc15-e4f2-9079-7bdcfdd13cd0@fb.com>
 <CAP01T74O+CS0VCXq9U7wyPvxTDdBr7ev0Oo-79ZcnkH6hagMcA@mail.gmail.com>
From:   Alexei Starovoitov <ast@fb.com>
In-Reply-To: <CAP01T74O+CS0VCXq9U7wyPvxTDdBr7ev0Oo-79ZcnkH6hagMcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0159.namprd05.prod.outlook.com
 (2603:10b6:a03:339::14) To MW4PR15MB4490.namprd15.prod.outlook.com
 (2603:10b6:303:103::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5074bc3-043a-422a-f73d-08da749bf9a7
X-MS-TrafficTypeDiagnostic: BN6PR15MB1828:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IdHgpG+XxF1QCitpeoy7CukNyEm59YH1hA2WB/ltA8a+PEcjrDPjHO5FwKZEPSiNsPxFkSUfjG6F/0e4DMquyxYLSpHEZw83sNHrQPNeFengp2Xu3xyEt0uD6Rv90UQWx1rTd+8BvcUvKbTCKYv8bOynZOh4DQQ7zoN+fLA8iiGiUDy8+haBqdFPYVBEhBfErw5xwoH48BKDwJD1oyTPrXsuXTAFjuGX5kZ2lW8Fnv9nRB3M9ZHms7ShHEnQNKh3lD4CxMigrfVmbaPyPK2o7EkWVmLrOF2xRsw6sctOGJRUe+0drI3KjCKtcekUiKCK9qj0KWRvKzk2STOfFDu1jhvMraUPZIxnzTiI6NtvoZ2CDsxRaunigPDzh8s4oIBOgCLGXrY4trDeZtfNH75k2TPQfgk/AbYk9bndM5VFH0oUnVI2wTmcQhtVnt35XJDel/q/fhh+U+y/mKXuzcLkSMZbUh+smyIfNSUDLbTfgUcRAkQMRl3RtOQPszV8a0cGtxRwqbvP3//ep+bCZQ/0Urh4bQ/Rz2hT6iN+jXHuU9fZBOwlOJVMVGom8htSoLeLqzF1FKc3Ul9emUMzpPedeb9vMhPOpPnqPKwW9vlPEMhz+nnhr1v9nC+xMLdPaxhaSu/+wnDC0ojRMW+M3UO4pSAoKm2tivSB16QZBOdAzc9gYI3TF7QTq3ghXGrT+dlNUfkUUquGBdfPSYweFMmlLrgszpMY/zQlLeCi86PlV6DiOBqRjp6w8ST7SqFubj777aq8xKyPKjvEOrBx+0PfDB06hGj08JXkdAHDKiPeqhSqZX46sZcfXTdOUBeOX+ulMMxnfDyyCUn2+w8cpZ74kA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4490.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(39860400002)(136003)(366004)(346002)(86362001)(31696002)(2906002)(38100700002)(5660300002)(8936002)(6512007)(2616005)(54906003)(478600001)(6916009)(316002)(186003)(6506007)(52116002)(53546011)(41300700001)(66946007)(4326008)(8676002)(66476007)(66556008)(6486002)(83380400001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVJiam55SDh0RzhtTnhxWGtILzNjU0JYaWV5QlhHSDQ0N1RMV3dCYmg3ZWZT?=
 =?utf-8?B?OVBqSVptNjFYWDdDVUZYTzYrczRMemFjZC9iSm1hYU85cmVrYUNiZDZIWWxu?=
 =?utf-8?B?YzhGWkd2cFRYNnd3ZFY0L2RyY0R1QjVJb2IwVDRvVDRkSVM2KzRNdEpnbG9a?=
 =?utf-8?B?dVNtR0JndWRuVnkwaE1zd0Y0UVZicmxyb0t2NG8xSWtoUXk4SERSbjhraUJE?=
 =?utf-8?B?RWdqOXVQY2owdFYxbmQ0Y3p2RXBETlpjanFmZzk3QmQyYXJ2bE02L3FmdTh5?=
 =?utf-8?B?dUE1UEFuQ0dPUWpncENXMUt0RFZxVlhDa2Q1REVJRXpmTWdEQkd0aENVWWVG?=
 =?utf-8?B?WGpjQmpKaFJ3RXYrdTluVWI4YWtSVFNoTDhsMTk1V09zV0NqV1lORDVtdWZC?=
 =?utf-8?B?QS9hdG14WjFXUGFCSzhJTzQ4M20ybGhqczViWTcrM0FmbElwcmlObkYwd1JH?=
 =?utf-8?B?UFpHZ0tveWo5MEFQL1RhOHRUL1dEWUxDZ3VMV0o0akVxTmFWdjZGb1hkck53?=
 =?utf-8?B?azIyd1RDem1CRHVodjhJS2xRRjYvUGFIdXpvSThLVFhuZmVQMHB6U29lNXJr?=
 =?utf-8?B?dDZ2S3hBelhVWWJHV0ZjckF2RGtlRkV3Ni93QlVTS2syNlBGVXA1RUNlMW1u?=
 =?utf-8?B?QlE0U2xvY3h2VGF5ajFERllYdlI5b2R0RkdjVGFiY0tCR2RPUDhDTzl2Sngw?=
 =?utf-8?B?MWI4ZHY3dUkwc3dtbExwbUFLTVVWQURvZG5jK0hiZU54blo0Tk9NdXQ1c3dS?=
 =?utf-8?B?RmVvbStQY0dkVWN3ZXpPZXlQdGZUZW95SzBMU2RrNWkyTkNiamVqbjhWVk1X?=
 =?utf-8?B?Q0VvTWNNM3FzWjI4cU1CN2g1ZEYyQUh1YnV2WFhRM1Urazc3eVdXRzZFbm1Q?=
 =?utf-8?B?N2V0QWJOUVlMVzA1VEd1NVc2bWRaRGVKNEFBdU4vZEIzY2hMZXlrNmlaTjFJ?=
 =?utf-8?B?NGxpT2RkUFJSMHl2STI5aXorZnJ0azNuZUZ6ckRVVHp6ZE93MDF4NFB1NEZj?=
 =?utf-8?B?WDlqSzY2bGRYS0FSSStNRGQ1bkN1Q092M1RwUktYdjJHSlIvR2FPRytDYjJx?=
 =?utf-8?B?TWJLNHhsSUVWNjZ3RVJKL2ZOV3ZUb3c4R1JXaHpuMDhzaGVuL0ZZcEtua0cz?=
 =?utf-8?B?bHoxWk5WYWM1Zy9hcTNweVhFK0w3T2szOGJ3QnJDNzNFeHFJWUNwbjY4UDBI?=
 =?utf-8?B?WUJzM3RoK1lkaFdlRWtyNE5jS2krOXNySWxXNHBrYlc4aHpydGNlelNIMnBm?=
 =?utf-8?B?OHIyY3NqWGpKWkJURG1qWXIxNzFBL2ZTR1Zud2k3aUF4Qy9LK3FWYlhyRmxN?=
 =?utf-8?B?RWw5ZTlWREcrR3U0RlhjNGZSQ1hmbkFSQ29UVitjcjhrVlprTEMwTUtTWTJy?=
 =?utf-8?B?SzI2RzhGdThKZWd6clF4azhRSTFTYTRjeDZ4b0hKd280bWpyWlNaVUZIdmdS?=
 =?utf-8?B?cnlxUmNIQjB0bXFLRG9PWjJETkZVVllTQjJjYm94TWlqZDBLZDhRR2plMU5i?=
 =?utf-8?B?NVhqcUMrenFuelFaRmtSR3JrcEpMb1p4eDhJRXprZHVwT0NHblg5VXpEOStx?=
 =?utf-8?B?L2p0WUhaNWZrckpNOFhxbGluRWwvL3VJa25VdmI1UDkzZUhoaFN3LzZtRVNn?=
 =?utf-8?B?M1BOUUNUOE45YUZpMW5rVzNhbGlPUE9OZktZUllJV2daVTBOb3BtWlpWMTJE?=
 =?utf-8?B?WFlYTDVXR1pTV2RGNXZLTXdwbk53T09pK3JkNWRHSW9GV2ovMWpKZWc5cGpC?=
 =?utf-8?B?enpmbno2QzVtc1lkTTMzUW41c1A1bldtei9UOHRqSkxDLzF5S1BPQVpwUFFP?=
 =?utf-8?B?ZXRiSTFralk0dWUwL2phcWVlQi91L0VuWTNrRDNpOWQ3NlRPaG9Fd3ZtWm5M?=
 =?utf-8?B?UVFNVWRjbFFXblNTUnlFSjZOM1lkT0lsM1ZFaUdaSHlaZDNkVVRlSzlMbDNW?=
 =?utf-8?B?YmZtTnNUUDZqMjdpUi9sLzBYVjM2cWhVQjdRdU42cmFBcTdyTXJ1bG52eE8y?=
 =?utf-8?B?M0VJeGUvYk00L2JLSExuSVRLUlVZYmQrT3lEcDFYOWJycUxHbnREczdXNEND?=
 =?utf-8?B?ZjM3Y2tDMGIvcHNiaVI2UFExcEFNaTQxbDkwRUxEYUhWS0hFd0p4aUQ0T0xV?=
 =?utf-8?B?cmg1S3ZMaThRNjNqMExpRDhyMmZjenZQY0w1WUltM051VkZvRWcrZlUrcXRR?=
 =?utf-8?B?Z3c9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5074bc3-043a-422a-f73d-08da749bf9a7
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4490.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 15:30:48.5184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KCXlpJDiz8zFDHJSrknUwLTrviY/S9W2pqg59HOu2iys0gFhK+yUxskcON1XVBiL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1828
X-Proofpoint-ORIG-GUID: eWtEGHqCZPgyAWLnMeuzOSEKZjOsDxvS
X-Proofpoint-GUID: eWtEGHqCZPgyAWLnMeuzOSEKZjOsDxvS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-02_10,2022-08-02_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/2/22 6:59 AM, Kumar Kartikeya Dwivedi wrote:
> On Tue, 2 Aug 2022 at 00:23, Alexei Starovoitov <ast@fb.com> wrote:
>>
>> On 7/22/22 11:34 AM, Dave Marchevsky wrote:
>>> This patch adds a struct bpf_spin_lock *lock member to bpf_rbtree, as
>>> well as a bpf_rbtree_get_lock helper which allows bpf programs to access
>>> the lock.
>>>
>>> Ideally the bpf_spin_lock would be created independently oustide of the
>>> tree and associated with it before the tree is used, either as part of
>>> map definition or via some call like rbtree_init(&rbtree, &lock). Doing
>>> this in an ergonomic way is proving harder than expected, so for now use
>>> this workaround.
>>>
>>> Why is creating the bpf_spin_lock independently and associating it with
>>> the tree preferable? Because we want to be able to transfer nodes
>>> between trees atomically, and for this to work need same lock associated
>>> with 2 trees.
>>
>> Right. We need one lock to protect multiple rbtrees.
>> Since add/find/remove helpers will look into rbtree->lock
>> the two different rbtree (== map) have to point to the same lock.
>> Other than rbtree_init(&rbtree, &lock) what would be an alternative ?
>>
> 
> Instead of dynamically associating locks with the rbtree map, why not
> have lock embedded with the rbtree map, and construct a global locking
> order among rbtree maps during prog load time that the verifier
> maintains globally.
> 
> Prog A always takes rb_mapA.lock, then rb_mapB.lock,
> If we see Prog B being loaded and it takes them in opposite order, we
> reject the load because it can lead to ABBA deadlock. We also know the
> map pointer statically so we ensure rb_mapA.lock cannot be called
> recursively.
> 
> Everytime a prog is loaded, it validates against this single list of
> lock orders amongst maps. Some of them may not have interdependencies
> at all. There is a single total order, and any cycles lead to
> verification failure. This might also work out for normal
> bpf_spin_locks allowing us to take more than 1 at a time.
> 
> Then you can do moves atomically across two maps, by acquiring the
> locks for both. Maybe we limit this to two locks for now only. There
> could also be a C++ style std::lock{lock1, lock2} helper that takes
> multiple locks to acquire in order, if you want to prevent anything
> from happening between those two calls; just an idea.

Consider the case of N rbtrees. One for each cpu.
In run-time the bpf prog might grab lock of X's rbtree and
then decide to transfer the node to a higher or lower cpu.
The order cannot be determined statically by the verifier.
The simple fix for this would be to share one lock across all rbtrees.
Not necessary such 'global' lock will scale. Just an example
where sharing the lock is useful.

> Probably need to make rb_node add/find helpers notrace so that the bpf
> program does not invoke lock again recursively when invoked from the
> helper.
> 
> Then you can embed locked state statically in map pointer reg, and you
> don't need to dynamically check whether map is locked. It will be
> passed into the helpers, and from there a member offset can be fixed
> which indicates whether the map is 'locked'.

considered that. So far doesn't look like we can avoid run-time checks.
And if we do run-time check there is no need to complicate the verifier.

> If you have already explored this, then please share what the
> problems/limitations were that you ran into, or if this is impossible.
> It does sound too good to be true, so maybe I missed something
> important here.
> 
> I was prototyping something similar for the pifomap in the XDP
> queueing series, where we were exploring exposing the underlying
> locking of the map to the user (to be able to batch insertions to the
> map). The major concern was leaking too many implementation details to
> the UAPI and locking (pun intended) ourselves out of improvements to
> the map implementation later, so we held off on that for now (and also
> wanted to evaluate other alternatives before doubling down on it).

That's probably not a concern. spin_lock concept is natural.
It's implementation could be different, but we already hide it in 
bpf_spin_lock.

As far as locking...
beyond rtbtree we will likely add link lists. They would need to be
protected by locks as well.
The same bpf struct element might have two fields: bpf_rb_node and
bpf_link_list_node. It could be a part of one rbtree while at the same
time linked into some other list.
Sharing one lock for rbtree operations and link list manipulations
would be necessary.

In the past we hid locks inside maps. Exposing 'bpf_lock' as a
standalone object and associating the lock with rbtrees, lists, etc
would allow for greater flexibility and allow bpf progs create
more advanced data structures.
