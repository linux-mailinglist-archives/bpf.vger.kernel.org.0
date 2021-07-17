Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88293CC484
	for <lists+bpf@lfdr.de>; Sat, 17 Jul 2021 18:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhGQQqQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Jul 2021 12:46:16 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:12384 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231346AbhGQQqQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 17 Jul 2021 12:46:16 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16HGcpt4008955;
        Sat, 17 Jul 2021 09:43:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=WZFM9c7yej4tZXDNsk3S9GA7pFaq399WHOv3HnfneRY=;
 b=qGk0PFVpTsGX+UZ+SWB27FtbS9ZnJsZDOmVH/zDxVxotBn17d8YjVgDeRLHiv86+FfqK
 o+bZfB2v9GF/M3qcKGh3pFQe0YdU2ZinKtZbvG8RcVKoRtY8DZECVusZdUfv0Izwx1qa
 /kYfVu4UiYsIElkrHIesp8LCrWCdel371Ho= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 39uxh8911m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 17 Jul 2021 09:43:18 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 17 Jul 2021 09:43:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4koDxHusfDKjKMzRYgOUU1JR6MCspSq4U/Vg7dF6koeOxDUv13LJfsT/HKdvK6o+mSBnJP+2X0SRpfEJiI4oFbp0FkUCO+KT1WRYGgqUPBM5brq1ZK386KbP5ofrWCoXcCgBZB6r+DJURPE0bgdQ+soCj+hRoSognrr9/0tEce87YpuBXnIZ0/q77VlU8IA9KG8N8jUrMGBjJCACZfP2K4p16rRT3lTcu1+69gDgKpw/ycCT/rXXUrAfR0BJw5SVDyJDsobCWA/WRLVx7jZiDKtQtnO4QBZYDPOgr8hLW4q48+SCf79RqpFk8+3lLKK9BzRzpXCqO24iNeoEr//Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZFM9c7yej4tZXDNsk3S9GA7pFaq399WHOv3HnfneRY=;
 b=W7GrUkQIiGcjlZup/oTUOW94hxTdCzN007djaWTcNK3OUKb7hu6cGHmtTStvfC5EXHKgT14GArBetbPSvwbYrt/t2xnh3Tx4InsfBI1Y+Al2q4HyFRog43qPBfy0dB4ga+ZysGlVenfLzOvXczrK5hNZi9U/muveDhPViqPBe/oCnMueDnhIN69CGdtMlJRsa2/1G17RPMCqimRrwK+ejbx4BVd1SwTu6m3WslAPYasloSMtyBqcDvFo4DlbkEnYSKitiErR8PQQnRlP2/IjkdmNoqy0e74YvLtzwO54AQFfNov/p3EH/cdEaJidThMQILTrbjERQaZbmZr2uj5oDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3966.namprd15.prod.outlook.com (2603:10b6:806:8e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Sat, 17 Jul
 2021 16:43:14 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4331.026; Sat, 17 Jul 2021
 16:43:14 +0000
Subject: Re: [PATCH bpf-next] bpf: Expose bpf_d_path helper to
 vfs_read/vfs_write
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     John Fastabend <john.fastabend@gmail.com>,
        Hengqi Chen <hengqi.chen@gmail.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Jiri Olsa <jolsa@kernel.org>
References: <20210712162424.2034006-1-hengqi.chen@gmail.com>
 <60ec94013acd1_50e1d2081@john-XPS-13-9370.notmuch>
 <6f42985e-063e-205b-820e-6bad600caf54@fb.com>
 <CAADnVQL9X7xrLKa5_tfgzAnEjPckz0jaWozAH+oNKz3=tZ6r=Q@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <a4faf9ec-ba94-13d1-d2e1-7710902450d7@fb.com>
Date:   Sat, 17 Jul 2021 09:43:11 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <CAADnVQL9X7xrLKa5_tfgzAnEjPckz0jaWozAH+oNKz3=tZ6r=Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-ClientProxiedBy: BY5PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::20) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e8::1032] (2620:10d:c090:400::5:3550) by BY5PR04CA0010.namprd04.prod.outlook.com (2603:10b6:a03:1d0::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Sat, 17 Jul 2021 16:43:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56de5284-3d41-47bd-364d-08d94941f8bb
X-MS-TrafficTypeDiagnostic: SA0PR15MB3966:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB3966B679DBA3EEFEA899B6DAD3109@SA0PR15MB3966.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5VgTRaJG/JwGyP4MmOqdSgZMJ31LXyBhhTaB0a1bujhXaHhVSf07fnNamDPBcEXeePTQ3C+c3yvpyDXdfNOkFv0KkkN6pSufySjfzVIWHIDApLUEaWjKiWl2wXiLYFaOI30JAGvPIDAkjJjgrTQfFQ1kC6tbGNE7wbHZ4lDpGbkW5Stx5Lpep3W2r/SrFp1YGz14Xj8fz3OeNifoOEH0C8gc/GT7kQEe9mb3VYiC3Ig7aNG1i0UePnNwpu2p+cIZZG8QtbynbrrKEBdD1cTWCilyEJsE/wrESlLmhr6rAhNZB4NZIEckEX0FPS13h77NqQ0oW8uWgTLz47CajhNTyJkDQWYVRvgL3ZDIjHCmbGppIaFb6s0SmgzPKOiODeOFxfP2DV0i7LWud7/hZrGDODTA8FMZZRlrXlMV0YDGFNsCs2w/7pPjooBprDoPtZbRjKkKqR/4hIFOnx+g5Pnhrk0KkKTJvNR5QoEmIm3i2CyF1nBJpIZKUrcdHGtbIJPWauBnpKQDN1GGG67g9NOAVXs1f5RMiLCcCr2ER35oHc4v7ZEk2WWyLSFg1o2hJbVqr8OMVRQ9hZK2DtQdWbmJ65Ov4x14tFR9XfQ1pvMbwqDjLT8eO7f/FGvptmL0B7ZdVcntQHMzb5RThx+x1nprk4k0dA48SK30sNT9TcMS07BfEvIGMWW0Z1qvmjTGg0N5eFsr9mL0E2Vbb+Kbw7quOyHkrK/bYErnjy3N5ULvc3WTCgzwm25bDEicrzO1hfh+HMYL/AaA3T3Onc+MmvCczMIqA6mauTlZkMlLCoVblKreVsQP4GRoAqmAFklNuYnY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(966005)(6486002)(5660300002)(52116002)(53546011)(8936002)(478600001)(83380400001)(4326008)(38100700002)(66946007)(66556008)(66476007)(31686004)(2616005)(36756003)(2906002)(31696002)(6666004)(8676002)(6916009)(54906003)(186003)(316002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3NCRU5tVnZkUDEwb0YxVEs1MWhqWlJvbnYyK1lwZjZ4RW4zRFY3YmZ3RElE?=
 =?utf-8?B?YnowblExR01teEIxWFdVMC9xNVQ4RVZ4OEw4NjhSM3VqUmNNVVNFdld2bGhI?=
 =?utf-8?B?UEdDRjIzRTVNRk5mRm5xaDRjckZlVVJnZkdWeEt0SHM2UmJYWFBwRmZyNzRi?=
 =?utf-8?B?WklXaWtGSHhXeUZQcVRiUnhhVUIyVnZwYnBTOXhyVFFkcVdpRWE2dHZvNVVH?=
 =?utf-8?B?WXQwalhHb2hnQkdwRGJCbEIrblFFeXBQQnlNV2lGM3VWSFBCeEJPOHhDbC9L?=
 =?utf-8?B?eFBLTnI2aXcvTmZiZGZoVk44SFFSOVNpUTU2MUh5UmU4MEtVSk1IVXMrSi9t?=
 =?utf-8?B?aXNOQnJKVnQxU0cvc1JaWjgwVmtHOXI3VnkwR2E5d3lWczVDL3IvZ2p3YkVa?=
 =?utf-8?B?WmtLUnlsRjNuOUR6RlRtWkpQSFdRTUpLZW05REw2TWVRSjBreFlYdEpaYnZa?=
 =?utf-8?B?OUcwKzlwUGdVSHNFLytiWFRuV2FBUW5OTXJPVnZ5SEdwVllGY2tsNkEvNlVx?=
 =?utf-8?B?TVpheW54dGtTU3ZGZTJKUUlqbnBYVFFWYWY3MmplNU05clgwV3pwTDdRQ2h4?=
 =?utf-8?B?ejFjcXJxcnA5eXlhVkVCaW93S3Y0N1Rkc1RZL0MycTM3a29kUnBEdWQ2NGtp?=
 =?utf-8?B?RHE2YkJ4NFhtVlNndm9RVCswNzVIWS9GSTQvcEM2YjRnMGowMjhmR1BkU2Nx?=
 =?utf-8?B?d3R3aXJhYkh2N2JCTzNtajYzbnlrbld3eXFycDhuOWxHenRUNndjTERIYUIv?=
 =?utf-8?B?RDJLQWExZ28ySnNTT3RnOXYzTFdGYzFUUjBWc1VZQWFlSUJ6SzlCYVFsWENM?=
 =?utf-8?B?RVFoUzZwVHYrK3BWc1RjSDJKVTJkUlA1YURmWElLRG9GWTNwc1JXcVVkYWFP?=
 =?utf-8?B?cWpzOGtkRmJwOXowVTY1NVY3TzlrcWRla0VmcENNUy9uWnRHdWNuODlxakRm?=
 =?utf-8?B?NkJoR2VVR09DOHRzM2FvdGpIUDBTV0NGV2JPVWFMTklvU0o1T0d0eFJJNlNO?=
 =?utf-8?B?aTVQYkp2OVFIbGhsNjJ3Y1V0WU1vNldVZkMybzNNdDlWYVo0N0lhQ05paXF2?=
 =?utf-8?B?K25PQ2dMQVdvdzUrM1FlQkZuU0JnTXUzeVhyTkhEQ1VuQmFBU1Q0Tm95TklC?=
 =?utf-8?B?VFhyRjRzRm9LeXRKN3pPeUR1MVFRZ1VwY0ZRRUZmdzdVQ2MzYUhCMTUzeG1D?=
 =?utf-8?B?Y1BoY1owSklsaXNtd2RNSU94MnpicVR2Q1VXc0NtMDRHVjJkUUhlRnN4SzNl?=
 =?utf-8?B?ZlZILzQ3Snh5YWcvY2Z4RitPb2ZLc1BGeGkwZTZYZGRHazl0c3k2WXF5dWhO?=
 =?utf-8?B?UjFhNHd5OVFFZjJ6RVU3U1FjLzhWcUlhMHFMNmZZNTl1aWhxbVBXeTBtOXJq?=
 =?utf-8?B?cDVFYUJUTXdhZmFIeUhQamI1eFh0UUtKR1Vab2VCN0Y1VTAxbkxrbDltaGtQ?=
 =?utf-8?B?WEdLdVU0MVN3ZWcwbkFzb2tmRkJnUnVVdTlKTEYvNGlsSGVNT01QUDM2YjJV?=
 =?utf-8?B?R2x0SnNMc3dGZkNXdWNEckpST3lObU5zQVd6ZE00OHNNeGhjSEdBYjJFM2tU?=
 =?utf-8?B?ZUhETVVEeGhOYWdhOVdsY3VZMGtTalVCZEE5Rytob2xPWE9sc3Y5RUEwMlpL?=
 =?utf-8?B?d2JlRTRPZUVtcXRZUlRXKzBFblBPRVdQSlF6RnhTcS9lNlVMMnBaeWpJT1ZS?=
 =?utf-8?B?dU1EOXFNTGdLRVFzaERCMTZXKy9rYVdQTUJOb0tndU43MzI3NVZUYmFlQTNa?=
 =?utf-8?B?NEpuNUVreE52alVGemk0K1kwTzBxZzJPRFNtVWtDYTc2cUJsS0V2VWRBTVV1?=
 =?utf-8?B?eVZKSjZMS21mSlA3TmJXUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56de5284-3d41-47bd-364d-08d94941f8bb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2021 16:43:14.5545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IJmaqRgFHKrDZPq8xeYuWG4gVvicc6hfNu5YNxYPzPu+JSZSEMKul6HKgODpsAO8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3966
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: mdJ9Up_aq0cO37OEYFRyFGVp1oUck0kV
X-Proofpoint-GUID: mdJ9Up_aq0cO37OEYFRyFGVp1oUck0kV
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-17_07:2021-07-16,2021-07-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107170100
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/15/21 6:44 PM, Alexei Starovoitov wrote:
> On Wed, Jul 14, 2021 at 5:55 PM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 7/12/21 12:12 PM, John Fastabend wrote:
>>> Hengqi Chen wrote:
>>>> Add vfs_read and vfs_write to bpf_d_path allowlist.
>>>> This will help tools like IOVisor's filetop to get
>>>> full file path.
>>>>
>>>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
>>>> ---
>>>
>>> As I understand it dpath helper is allowed as long as we
>>> are not in NMI/interrupt context, so these should be fine
>>> to add.
>>>
>>> Acked-by: John Fastabend <john.fastabend@gmail.com>
>>
>> The corresponding bcc discussion thread is here:
>>     https://github.com/iovisor/bcc/issues/3527
>>
>> Acked-by: Yonghong Song <yhs@fb.com>
>>
>>>
>>>>    kernel/trace/bpf_trace.c | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>>>> index 64bd2d84367f..6d3f951f38c5 100644
>>>> --- a/kernel/trace/bpf_trace.c
>>>> +++ b/kernel/trace/bpf_trace.c
>>>> @@ -861,6 +861,8 @@ BTF_ID(func, vfs_fallocate)
>>>>    BTF_ID(func, dentry_open)
>>>>    BTF_ID(func, vfs_getattr)
>>>>    BTF_ID(func, filp_close)
>>>> +BTF_ID(func, vfs_read)
>>>> +BTF_ID(func, vfs_write)
>>>>    BTF_SET_END(btf_allowlist_d_path)
> 
> That feels incomplete.
> I know we can add more later, but why these two and not vfs_readv ?
> security_file_permission should probably be added as well ?
> Along with all sys_* entry points ?

The first argument of bpf_d_path is "struct path *, path"
which needs to be a BTF_ID w.r.t. verifier.

I think maybe we should target the common kernel functions which
has "struct path *" or "struct file *" arguments?

vfs_readv and security_file_permission or other possible candidates
are not added since there are no use case for those yet. But agree
that adding some vfs_* calls and security_file* options are a good
call since they could be used in a different situation and adding
them may save another kernel patch.

The syscall entry points typically only contains fd. Although
bpf program might hack to do something to convert fd to a file,
I still think this is a unlikely use case.
