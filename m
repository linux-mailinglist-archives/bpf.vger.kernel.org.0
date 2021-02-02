Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9673330B873
	for <lists+bpf@lfdr.de>; Tue,  2 Feb 2021 08:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhBBHL0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Feb 2021 02:11:26 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46768 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231158AbhBBHLX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 2 Feb 2021 02:11:23 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 1126s7re004077;
        Mon, 1 Feb 2021 23:10:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=bfJ7BfilOTe2/lfOf0qAVWN8pTDlC60H9xv4G5KOqjE=;
 b=kjMg6HO+jjb2OBMHs0r9qDJCBVnXfMbb6FU6AdMgAZ6BsNzOo4eNZIoShHABNdILAId5
 8dDFg2ZXF21WdXqw8/Iy5bULy48B7LEE4uZq/Pmg8b03dwKS0+eksLrrt6/fqDVd4U5/
 j4qyvQObPsQXw5zFNRZ1bW/ymbOlp+x4I0s= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 36eyxfrhgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 01 Feb 2021 23:10:28 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 1 Feb 2021 23:10:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Imz5JXwoSK/y1k9I8N87oLATzKDQi/EQPmdhhKQqWQ0mKa6qUl67OZ1GjoT7JJRADzmKQ47jVh+MzhSJDeMV3rkQoksCdE0S2QR7OuHI1gwaMuCYWSxWCUtZ8r94McVvngr32rOBdHzRjv5VGAEORtlDBddGQ9lZFH5GRQ/piT/N41bkGS5/RnNjyAr1wKFq6JFouLa55yqBkIkqGzs5/yU/GthzMzrjjM9fDwTaFfdMOLneh7j3vesQz/6EJO+NxPI1J6zBhUs8yWdps7q0PHiXHIFgiVzoL4Z6+dFwdMXGo2wki9T6/ClbrzTKlmRs5BdiuiSzQQtghFUVScaV/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfJ7BfilOTe2/lfOf0qAVWN8pTDlC60H9xv4G5KOqjE=;
 b=Lbv8am1taQrQ1T4hZVO/E4q6c2PcOxIGt3Gf85YQtbM/2kChZAuFAd5eTc8XdDBYYsPfImfphRgN7lm1rw2fMbNt+MQBSuyZ4bFdado2lCZXWtO791AKj/5K8Bk65mNncnwrYTkjFbLoDzuJyHenWGnni1w6QTW5fCLOpsjmpHQMwCnijbeErgeskdrZhn55vNqZDFmHl/rNrjrzdWaiqkq6+mG7zzata8k8lGkPLV9f1EzWyn5g4Ncku99GKeSoD3CZ8OZq+aid1eC2SDq4FAX+gQXcDhPFMPDDX6d97Ub/Bwe1r7miOgKA37t41zksTkIxWDnyLfOrc5E+1VwV6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfJ7BfilOTe2/lfOf0qAVWN8pTDlC60H9xv4G5KOqjE=;
 b=WOodBLHTrzLCfNYCZPtMVosavp+MGLbK+wCxAHzaWHq6vv2Cj5rFSyiIYsyulHt7AdmpY7rET65SK3EdlFBqhbzy3wogzY94OJMIuSL92MWLUMK/bsMxom3CZ3zOpQcocHYcG7+MD9vtVysuRmA1Z0+Y6CgHA5dd3yZdBW7W/fE=
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3461.namprd15.prod.outlook.com (2603:10b6:a03:109::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.22; Tue, 2 Feb
 2021 07:10:26 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5%5]) with mapi id 15.20.3805.028; Tue, 2 Feb 2021
 07:10:26 +0000
Subject: Re: [PATCH bpf v3 1/3] bpf: update local storage test to check
 handling of null ptrs
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@kernel.org>
CC:     bpf <bpf@vger.kernel.org>, Gilad Reti <gilad.reti@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
References: <20210112075525.256820-1-kpsingh@kernel.org>
 <20210112075525.256820-2-kpsingh@kernel.org>
 <CAEf4BzbeWCTSDorWwuC+B9SVw7xGj+5jfAMyw7LzBU_XShk5ZQ@mail.gmail.com>
 <CACYkzJ7-1phMCVR4Ctf6RkTwEs_RZDvs=jUQt72x2Ud_opmT-Q@mail.gmail.com>
 <CAEf4BzYBAKNRvGCweY0NyDQ751ChB4QKt41cVbU+VRTsDAcpGg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <c66fdb89-db8e-8a7e-f1b6-0905e841d855@fb.com>
Date:   Mon, 1 Feb 2021 23:10:21 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
In-Reply-To: <CAEf4BzYBAKNRvGCweY0NyDQ751ChB4QKt41cVbU+VRTsDAcpGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:c99d]
X-ClientProxiedBy: MW4PR03CA0059.namprd03.prod.outlook.com
 (2603:10b6:303:8e::34) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::11fb] (2620:10d:c090:400::5:c99d) by MW4PR03CA0059.namprd03.prod.outlook.com (2603:10b6:303:8e::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.18 via Frontend Transport; Tue, 2 Feb 2021 07:10:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a7e26ab-e286-451f-5b8f-08d8c7499d3b
X-MS-TrafficTypeDiagnostic: BYAPR15MB3461:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB34615440588AA34781E8FDDED3B59@BYAPR15MB3461.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O7mR/GIdokox7KTKN5kxE2EEdtkxEDyMdRtebm6AXMxP353O8VEvszmw0kGBooVTSvaSNaCM61StCtjAYTBlIhpAsTlNrH5oeflSbsxnQnqaQp6cLuBgnCoEUlnBA3YN/TY2WnvcGUfVsSHQH6XEhFIvbrKgebsiyhnldAtRiK1iMoJwTlB3u0wtr5LDW8vYAEMMw0K0vlskPNXaK8RFC5u6cdPld6hl+/sTxDWIbPZRn85iPdBe38RZO3Zw3YVzGzz8Icqn9TWqN0brehgbaAAR4Ygy18tQ+ZxdL4n21JsDwWN7r+5bYerj+N3kgf4sK2biwudCooNOOpqKEzEV8XLpKjcz6kDUqbCU8BiLX6SDWIXG/H6tSiVYp/jadcthVBPb8krWtzDgsXWSTok19s7DdIoYSEI5JdjKr+DOVdrbgVH+1AhvawqXaG1FcvcTIbvqwNb1NprgbT/b2+Wet2/Z/t/bjfd7rC9WaONIiCAKDPUhakGsUhBWlA5d2DY1LMKXfwnHX9AuNnAAO6gLFQ9/HNURM6OYW5QIZJvuVr+//kdujp9e85L5ZHEzvzGRDOmzzqVwG/SqyNlxYrghJ88U3YKNK5e/N2t0CQl6dyIUgNslVt+v52wEBZaihpnoI3oLqo8w94o1lILN2QYWTJHaprFSFJJQDO+/afVgy0jU7P5giZIeWbYKQtc247zN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(376002)(346002)(136003)(396003)(186003)(16526019)(15650500001)(53546011)(66946007)(66556008)(6486002)(4326008)(66476007)(6666004)(5660300002)(110136005)(31686004)(478600001)(316002)(966005)(8676002)(2906002)(83380400001)(31696002)(36756003)(2616005)(54906003)(8936002)(86362001)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OFVYVWp2THZGWFY0R05MUk1Oa3RERHN1bzBQbm9KaExvbzg3K2RZNTJ4UWJV?=
 =?utf-8?B?WFJuelBOLzM0N2JlQWkwTWVYTHArS3RuUWE1bm4wNGo3ZjZjd1A1S3FIclJm?=
 =?utf-8?B?b3kzV1M0Nk5vWjNxOEFNdlZMOWU3U1pER2dqeFNTbmp0YXE0a1JwbU8vRGVI?=
 =?utf-8?B?bk1lVWZBaTVwak5hYkJWUE1lVW9SamdHUmFpTjA4MldiOWNLdEdiYmxFL3VG?=
 =?utf-8?B?anJWNm44YUxPTE9BWjRyeTVjM3VMbzE1dGRxYmFrV2p1KytHYzgxcDZqM05Z?=
 =?utf-8?B?OVo4eGhGTTJkczI1cTRGNFN0VHh4MG8xTUk3UVYwMmZsZ3RUeXd1a3pTNWVP?=
 =?utf-8?B?V1RQVExBTTBuOXQxSjhLMXpRdnI3ZyswQ2cxbVNyR1kveU1vb1ZNUEZ5MEhN?=
 =?utf-8?B?Y1ZmNVN5ZlNoQ1BlUTRyL29wV1FVZGhBTGxXUk4wK0ovNk5MV2hWS2RsWkpi?=
 =?utf-8?B?b1lVV0o1N2FuNTArUWZuL3lvRU1TdG0xVUczVmlMeU0wYzhwbnRtSTdpa1lw?=
 =?utf-8?B?aWtsK0FnazQ2M2hvRnVZK0QzOEsxU1hDT2xQaG93TVYwYjJ1VGhtbHZDUjNq?=
 =?utf-8?B?Yi92YTdKRGE1N0c4UFV5b3l0NUN5MHZIa0IrNWtJOEtsTnB4Y0xhaHF3Tmly?=
 =?utf-8?B?bFdyMmxFNkJqQlM0SmUvN0NwRnhOT3g2TjhUUTIvMVpocGtBWlVYT285QVR3?=
 =?utf-8?B?MVRTTUFrd1U1WHMzV3BsV2oxWWJIZlFFMVh5WUNkZ09oZkhEMXRlbE5aQ0t1?=
 =?utf-8?B?YkhLR0p5blIvY3YrSk5DelNnR3NSSkQwb1Z6YmlsbkllSmYxaVNpYXhqYS9U?=
 =?utf-8?B?MzlyVmE2aVJzS1U5NEkrSjNrOVVIVnJTbDRzSHdJcG5pUy9SZHdBUGprUWVK?=
 =?utf-8?B?ODZiOVpLMGZyU3VqakJnVDZzSEowSVVyZnR5dUdhQnJNWXIyYzYrMzc3L29W?=
 =?utf-8?B?Qzd2WDcwM2FoakJCR1kxam1wdmVmejlnUlkva3lxRlpWM0ZoMFd4ekZVZ0M0?=
 =?utf-8?B?THFFTmhOdW1yYlJIL21abFo4eDF1UU9nWXFhc3MvWVhOdDhPMGhTc2xLSXov?=
 =?utf-8?B?N2NJMGhaNWFoYzloSUVpNDVLM2orTlpyUUJlWlN3VER2R1JlSTQ2djNFZmVr?=
 =?utf-8?B?cEV0alB2SS9zRnAwK1ZWY01Jbk45ZDNTdXNxNVB6cytZTmdPMXFib3R2eDFV?=
 =?utf-8?B?cThXNXNKN1QrUmcrenFuMk5lRGJaSlBkUVRDNXVCcktQWU00MUV3WkdDSGRG?=
 =?utf-8?B?UytxcFh6anA3TUE4eTQ2TjJra0NEU2JOVWFRMWhnc3NuaUU3dGF0YXZQT1FL?=
 =?utf-8?B?RlVsWVgvSmR4V3czMkZHeWhleVdTMDgrUGpvdHh3YVlIdEJLQ0Rub0FCaFFF?=
 =?utf-8?B?b3QzVVRRWGsyWFZaOE15d0E0VzI0bWxLVWo4V21NeTJDeXRpejFtOThqWHoy?=
 =?utf-8?B?blBnTm5PMnZ0K0Z3SkkwYXQ2ZnVZZTZYN3JwK1llSDVXQ2NmWGVMNEZBMTBV?=
 =?utf-8?Q?Tpyk6U=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7e26ab-e286-451f-5b8f-08d8c7499d3b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 07:10:26.2245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EFsU6pu6qKhrEXMoHcEwaQsF2/mC7rs8hkNoExUq9BbpS194ILrajcHUqngwu6ey
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3461
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-02_04:2021-01-29,2021-02-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102020047
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/1/21 10:37 PM, Andrii Nakryiko wrote:
> On Sun, Jan 31, 2021 at 5:09 PM KP Singh <kpsingh@kernel.org> wrote:
>>
>> On Thu, Jan 28, 2021 at 2:46 AM Andrii Nakryiko
>> <andrii.nakryiko@gmail.com> wrote:
>>>
>>> On Mon, Jan 11, 2021 at 11:55 PM KP Singh <kpsingh@kernel.org> wrote:
>>>>
>>>> It was found in [1] that bpf_inode_storage_get helper did not check
>>>> the nullness of the passed owner ptr which caused an oops when
>>>> dereferenced. This change incorporates the example suggested in [1] into
>>>> the local storage selftest.
>>>>
>>>> The test is updated to create a temporary directory instead of just
>>>> using a tempfile. In order to replicate the issue this copied rm binary
>>>> is renamed tiggering the inode_rename with a null pointer for the
>>>> new_inode. The logic to verify the setting and deletion of the inode
>>>> local storage of the old inode is also moved to this LSM hook.
>>>>
>>>> The change also removes the copy_rm function and simply shells out
>>>> to copy files and recursively delete directories and consolidates the
>>>> logic of setting the initial inode storage to the bprm_committed_creds
>>>> hook and removes the file_open hook.
>>>>
>>>> [1]: https://lore.kernel.org/bpf/CANaYP3HWkH91SN=wTNO9FL_2ztHfqcXKX38SSE-JJ2voh+vssw@mail.gmail.com
>>>>
>>>> Suggested-by: Gilad Reti <gilad.reti@gmail.com>
>>>> Acked-by: Yonghong Song <yhs@fb.com>
>>>> Signed-off-by: KP Singh <kpsingh@kernel.org>
>>>> ---
>>>
>>> Hi KP,
>>>
>>> I'm getting a compilation warning when building selftests. Can you
>>> please take a look and send a fix? Thanks!
>>>
>>> /data/users/andriin/linux/tools/testing/selftests/bpf/prog_tests/test_local_storage.c:
>>> In function ‘test_test_local_storage’:
>>> /data/users/andriin/linux/tools/testing/selftests/bpf/prog_tests/test_local_storage.c:143:52:
>>> warning: ‘/copy_of_rm’ directive output may be truncated writing 11
>>> bytes into a region of size between 1 and 64 [-Wformat-truncation=]
>>>    143 |  snprintf(tmp_exec_path, sizeof(tmp_exec_path), "%s/copy_of_rm",
>>>        |                                                    ^~~~~~~~~~~
>>> /data/users/andriin/linux/tools/testing/selftests/bpf/prog_tests/test_local_storage.c:143:2:
>>> note: ‘snprintf’ output between 12 and 75 bytes into a destination of
>>> size 64
>>>    143 |  snprintf(tmp_exec_path, sizeof(tmp_exec_path), "%s/copy_of_rm",
>>>        |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>    144 |    tmp_dir_path);
>>>        |    ~~~~~~~~~~~~~
>>>
>>
>> I don't seem to get this warning, so maybe we are using different compilers.
>>
>> Mine is gcc 10.2.1 20201224 (from debian)
> 
> Funny enough, but I can't repro it locally anymore. I have gcc 10.2.0.
> But your suggested fix below does look like a correct one, so feel
> free to send it over, thanks!
> 
>>
>> That said, I understand why it's complaining, it's for something that
>> cannot really happen:
>>
>> tmp_dir_path cannot be 64 because we actually know its length so the
>> tmp_exec_path cannot really overflow 64 bytes.
>>
>> Can you check if the following patch makes it go away?
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
>> b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
>> index 3bfcf00c0a67..d2c16eaae367 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
>> @@ -113,7 +113,7 @@ static bool check_syscall_operations(int map_fd, int obj_fd)
>>
>>   void test_test_local_storage(void)
>>   {
>> -       char tmp_dir_path[64] = "/tmp/local_storageXXXXXX";
>> +       char tmp_dir_path[] = "/tmp/local_storageXXXXXX";
>>          int err, serv_sk = -1, task_fd = -1, rm_fd = -1;
>>          struct local_storage *skel = NULL;
>>          char tmp_exec_path[64];
>>
>> If so, I can send you a fix.

I have gcc 8.2.1 which can reproduce the issue.
With the above fix, the warning is gone. So yes, please send
a fix. Thanks!

>>
>> - KP
>>
>>>
>>>>   .../bpf/prog_tests/test_local_storage.c       | 96 +++++--------------
>>>>   .../selftests/bpf/progs/local_storage.c       | 62 ++++++------
>>>>   2 files changed, 61 insertions(+), 97 deletions(-)
>>>>
>>>
>>> [...]
