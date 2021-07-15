Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F653CA232
	for <lists+bpf@lfdr.de>; Thu, 15 Jul 2021 18:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhGOQYt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Jul 2021 12:24:49 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:13296 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229518AbhGOQYt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 15 Jul 2021 12:24:49 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16FG4exT029937;
        Thu, 15 Jul 2021 09:21:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ZUO+r1lGj5Mb/hSyfFRiaTD18Sc9R0+LHlv1ca0S4SY=;
 b=QXiHMEqGvL4jipRo4CpSiuXXX0XXTtDM8IZs3lOeQ+uKsBuPj4XUsAsn7bm9AxADz9mc
 mKisx8yZTZ3wwT6KvoHVBOxG9lX4T7Q/DoIytfxjlF/K//SCNJ6qchptYKj6spp1wUOA
 TjYqz0rKVev8xF+RcJ7yTSjkCY5vwdeuVNI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 39sqkkb1d7-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 15 Jul 2021 09:21:43 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Jul 2021 09:21:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ayJ7voPj/4WvqAdwfdU+JwW7dt/YG3UAf27LQdcg7TYa6ASGVyF1xIspKAbKWsKP1apQIpUBdU6SuaYlhRlE1/zposkrBCnLKJq6L1JdaXqYV2NHdOYZ/cxdFzK+CX9+JM2eZ0pOO2fHXKXb02w+b0xEwHOkWJ4rkmadRrlwmCenE3/eqrh6oNKFHgTDbMZhksNFDXxNUBj7Wke41HVKapNE2eRNbMy4N3iC9Yxqxc9yZHaco2GRe1aP7TGDUNkNk0P96krETko4eEkZTK61QlDmWI6eb2mZWRKbbwS3R/mLtFb6fNNeLc2m3VuXyLvD66QQyZ24bsR61HQNIEHAsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRcJZBq+ny1nbFBrmNsx93UpWCIlZeDqtDOlO2lpluU=;
 b=TYNn59kEh2aY4hmS27WfcncANw0qyr+jOO0tn2Em7qgkeecv5zbOf1dU8RCKKw7KUOAMSeJMzG+gvjlk1KITmbbcj+krwlHTnNlZcihC7Ec8Cz5rsIsJdjz9rrNqgMxw6elnREaMcwBban1v54tFYgZBvFicJh9Yau+zzugMG0Y5rpMectLcYSrj7ZC+0tnPk/6s1vrIaofp55WiSnwy7jQvWhDHjnDlpvep/P+q+4y7898e5wzsYL1uQSt21w/blqPeOpL2Qz4gqWgZfDSJPIoPvu5ZLeCh/1KyyWtQaZAKqSzGYt5KJI+8RKlTwptuhbRj4A6AAq6GcnQIyZLkVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3933.namprd15.prod.outlook.com (2603:10b6:806:83::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 16:21:41 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4331.023; Thu, 15 Jul 2021
 16:21:41 +0000
Subject: Re: Can't build 5.13 selftests against clang-12 nor clang-13
To:     Lorenz Bauer <lmb@cloudflare.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
CC:     bpf <bpf@vger.kernel.org>
References: <CACAyw99ZrBRr9QydPVvuWNksGfOckq-giTUR29sjzZDfdx5MFA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <36382079-96b5-bcb1-e71d-172ddd7bcd00@fb.com>
Date:   Thu, 15 Jul 2021 09:21:39 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <CACAyw99ZrBRr9QydPVvuWNksGfOckq-giTUR29sjzZDfdx5MFA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-ClientProxiedBy: BYAPR06CA0039.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::16) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::1287] (2620:10d:c090:400::5:f774) by BYAPR06CA0039.namprd06.prod.outlook.com (2603:10b6:a03:14b::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 16:21:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c172a1a-053e-4e94-bf79-08d947aca0df
X-MS-TrafficTypeDiagnostic: SA0PR15MB3933:
X-Microsoft-Antispam-PRVS: <SA0PR15MB3933D1B863295EB5992B9C91D3129@SA0PR15MB3933.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ifVMjZx3QMIJquKV81f4sWHzk63wf3ErUJ+7PwKn6eFs3WedvBe4XW2VEOINWTjYxB7KtKa4SKp9w6DmrFSmnaAgKZrZlac34YcukTKUxOG1qh0NEiGpWjZIREMH6tYgNNsumNWeQvtVBOJd3Q1YdC3U3rgdXzLmu5d8aSHKwsJw6ATZ11qV9DJq9gfw4cQ7PpqpFnQH5nW2CGmKLTPvJV4i/M/Pn9o8UEfSg4G4krB7OjCbq+VaW3Lo+P/EVyaKIvIp+Z6A7oYHiH17gRgd9+uKh2Whn/z+rwukxSrZSEmXRcw4iC1Baou/xbMj0/bh1Iaxqovf7S/fnmSVhIM/R7Hv6bbi5EX405l0K6iQaUonK6GnW0x+snt2dKV603eW2krasir/9limCzQiHknzI18Hep61ddogMaacjxO3zTHqNMIEYG/ej+KZQgv0l+WzElEopXXwd21QKHrASNSKJxxBhTSLPN3MJq3dn/Y1g+iLTsKRgzMeH4z24GXiwINxtbcBGqlR0PsxXRxQ179bfrFjoqzd1y1SZGq5RA/LvhkhawMFmYWvTktiw9F4Fa6G1YfoMUDkC+yRR2f6PmAgy0J3rqn10Hj7h0Wrdy4uqyo7wKGT3I0JFl7R4YlcUp7qVvtJ+9DOUEhqCbLFQtx8uAOoGOeNxJNVrmmcMLCGUs9pVvN5aQp7IUSw4LHPSXkLDX7KbK30lmhAb2+YYXggzqBPtLEy1pIPK44b75spMADw6jBB1/lKK5MLMOF5GQ8Pr9DX6uJMhQrBunrFiNdTAoJTRz5SSkJp1OCBM1QkA/7iBvTBKIi6rINBEVQZ/xDM9/VBrPVk0UWk7uEn6g9kxYOuVXPiSO6rrVn74le1hMs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(186003)(5660300002)(2616005)(8676002)(53546011)(36756003)(66476007)(66946007)(66556008)(966005)(478600001)(86362001)(316002)(8936002)(31696002)(52116002)(4326008)(6486002)(110136005)(31686004)(83380400001)(38100700002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZklrZW5LQTFSMjBndmJ1ZTZxSFI2RmMrRHJPMDQybVRMTzZJQWhqZWJIOEdq?=
 =?utf-8?B?dHhSVDBxcWc3T3BqTk01a1pBSDN5ZDVTNkdBaDU5NzBGSUdaTHNLY2R0cXJX?=
 =?utf-8?B?d28ydlp5Q1M3Z0cxSzVnWHMvRDlsL1JuVE93VGZxbUlheGZES1AyeUFRL3ly?=
 =?utf-8?B?aVdhQ1FvbG1EK2dJTEpCV2IwSFQyZWtGN3lpbEhrL0hnQkwzVmUxelFvei9w?=
 =?utf-8?B?cnhvUHl3eDRYdmJlbVkyc1QyWFM5ak84NDR6SElwUHVrNXcwVlFMcnVnTlha?=
 =?utf-8?B?QnFaUWlMRVlIYVNLL3I2OFVFWmRzNUlYN281c2pPVXdBRmtCdnVLQ0FkU1cr?=
 =?utf-8?B?dkM5dmtTM3g1WFA2cm9pek1qUEpON0RuR25zWUhOOTRmRFVWOUlKK2NuWlBX?=
 =?utf-8?B?Yys5RVZSeG14bzV4Q21ZdVl3OWU3eVJWcThNYWhzWkpUWGs4d2tmRzRtMUZZ?=
 =?utf-8?B?TU1Ud3JNZTNoTCt4YUhTUVpHWjJFVm5oMWcyb2lpcmJXcEZBc3hxV280WmhJ?=
 =?utf-8?B?RlVUak9uT1AzQjNXaXlKYi94R25FZ3ZoNFNwbFJmTzJ4Q2tHTC9tbWtCdU5Q?=
 =?utf-8?B?aldHWEgwS2txbC9pbXlKcVptbzR5RnZTbGNvaHMxRk1wdFI3TkcrMDE5cU9z?=
 =?utf-8?B?TnczQWtrVU9QZDVwbFJpTUI2VWJONVFjbEZiYnVOY3NhcHNqVURsWUJFR1NO?=
 =?utf-8?B?V3h6TDhDT25tTjZON3VYWWtWUnRoZDZFYjlKL0xOTVhCYTNKWW85U2FRcHl5?=
 =?utf-8?B?YS9nK0ZiZ0daalNEaTluWHAwTzRJOWJCYXpSOVdONmtWaG15UVREeGZja05w?=
 =?utf-8?B?MW9kYTcvNTVySWJwU2tCTkwxVzR6aXZCRTcwUkczdkR2dkxuUVRVellkNDdY?=
 =?utf-8?B?TmZPck95VzBWUXZLdUl3czJDeGUyWHhNTlRXS09vaXhBMEtCZjVySDhkZkNl?=
 =?utf-8?B?Q05NcEwreHdHbUUwam9EWGVSaHN1YWs4cFM3ZTVKUFV2YmlQaGg3Vi9tTDZn?=
 =?utf-8?B?aFNXQmlCTk55M1dYYmpaWGxFNE5RdDM2T1VSQktBckhCZlJ6eWhYdFFROG9k?=
 =?utf-8?B?V2p3empwVU96UExqOGN0aHZVUVhuTjlqam5uaVQ3Z2tDVXExMEZGTm5yN1NI?=
 =?utf-8?B?N2M0UlUxeDE2VWxPNlFXVkNiUHZqd2U1ekhWeTdjRmp0dlRNL21ZL0QrMjla?=
 =?utf-8?B?U0IrSFM1aEczcnRaYlZWSy9Uem5FOE4vR2FtdWk2MzIvYjMzVnBoc1VpbXVE?=
 =?utf-8?B?RGpMTFRBSmpMQWtSdEE3SHIvZFVKbFdCSnc3c2hiTHdwdzVEcjc4VnFIRE9D?=
 =?utf-8?B?VWorQ3AyRWdGWXZDTkZlbm0vRzBJMzdFOC9sSTNXU2pYcFMyTCt3UkhIMFpY?=
 =?utf-8?B?eExiQ3krQnFZVjhRamp5YXJFWm1UNXBOekZpUUJsV3g1REJrblVkMThnS2VL?=
 =?utf-8?B?T3VsUUtrOThaMWd4RDBGMkVFa0FOclg5eXpMMDBFcE0wWStpTU5IajZ1Nkla?=
 =?utf-8?B?ZFBzeVJaLzVjUlRiOFJJSTQwb2oxNXg4aGdjMEc2bFR4S0RzNDc3UDRMT2Rm?=
 =?utf-8?B?ZWo2MWg0WDA4d1NlR2xHSENtNm0yaThFVTFLQ2xJTkhyY2JMRGZuTlcra3ov?=
 =?utf-8?B?djVKUGFqVzN6T0Jnc1pDc2EyaHJNS0NTSWZaeFZEdWRTeVhYdllNekgxRG54?=
 =?utf-8?B?ZHdkTko5U0FFQ2I2NWdBanZpM3kwR3A5ODJLMXl2OXlFeTEzOWIwQ1gxVFVL?=
 =?utf-8?B?T3hJdGtDM0NvYmRacjUxMjJuTEZpTU9SQUM4eFR5cCtJRW41UVZsZU1pd2Iy?=
 =?utf-8?B?RWdMeENxdHZRd1NVZEhQUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c172a1a-053e-4e94-bf79-08d947aca0df
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 16:21:40.9740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jXjt22VgJLpjXZDMRfXx1WI2R3JD4ydU97qkmHc0kpNnsIp1zoFq94GzX07gkMBH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3933
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 77pUBTXc5CBYIUEylzHTuLh_1U-xFvB9
X-Proofpoint-ORIG-GUID: 77pUBTXc5CBYIUEylzHTuLh_1U-xFvB9
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-15_10:2021-07-14,2021-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107150112
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/15/21 2:03 AM, Lorenz Bauer wrote:
> Hi everyone,
> 
> I'm trying to build 5.13.2 selftests for github.com/cilium/ci-kernels.
> With clang-12:
> 
>      libbpf: failed to find BTF for extern 'tcp_reno_cong_avoid' [38] section: -2
>      Error: failed to open BPF object file: No such file or directory
>      libbpf: failed to find BTF for extern 'tcp_cong_avoid_ai' [27] section: -2
>      Error: failed to open BPF object file: No such file or directory
> 
> Arnaldo has hit this problem before:
> https://www.spinics.net/lists/dwarves/msg01332.html  So I tried to
> recompile with clang-13 (Ubuntu clang version
> 13.0.0-++20210629083512+c4de78e91c93-1~exp1~20210629184258.496):
> 
>      libbpf: ELF relo #0 in section #15 has unexpected type 2 in
> /home/lorenz/dev/ci-kernels/build/linux-5.13.2/tools/testing/selftests/bpf/bpf_cubic.o

In this particular case, you can check out a llvm13 git repo upto but 
not including the patch
    6a2ea84600ba BPF: Add more relocation kinds

> 
> Aka my clang-12 is too old, my clang-13 is too new. In the past we've
> stubbed out some tests based on clang version, can we do the same
> here?

LLVM has 6-month development cycle vs. kernel 8-10 weeks.
With this, sometimes we implemented some features which is suitable
for *latest* kernel version but has an adverse impact on old
kernels.

> 
> This build breakage tends to happen with every major kernel release.
> Is there a way to avoid this? FWIW some CI builds fail because of
> this, however I have no idea where these reports go / why they aren't
> taken into account: https://lkml.org/lkml/2021/6/22/987

First always check tools/testing/selftests/bpf/README.rst which should
contain most, if not all, possible breakages and how to mitigate them,
e.g., which llvm patch is responsible and if you checkout a llvm repo
upto and without that patch, you might be okay.

We can also maintain a list of llvm sha commits which have been tested
to work for a particular kernel version.

Further, if we really want, we could have a forked llvm-project repo
with tags for each kernel release. This way, people can checkout the 
repo/tag and build for particular kernel release selftests.

> 
> It would be nice if there was some combination of (easily available
> clang release) x (stable kernel versions) that allows to compile BPF
> selftests successfully.
> 
> Lorenz
> 
