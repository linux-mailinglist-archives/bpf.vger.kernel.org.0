Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37BDF20EDD4
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 07:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgF3FtL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 01:49:11 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51224 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726499AbgF3FtL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 30 Jun 2020 01:49:11 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 05U5djOL021256;
        Mon, 29 Jun 2020 22:48:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=JXbcS8s3gY2J+x4jZcETP2JYXfVbKRHX8/27GJwP/CU=;
 b=gkmG04r4KgvSiMcnRtoKRKow7D8Gk3bDIWzWpuh5BEwhnRXjiS/O5QqdQzzmGItAngDN
 pWvJtZsqar2awah6vvxMAKz+dTbPXoo54/zkaaZfLa/M66puQHNZLqF5FdEX8EBlHaRK
 TVwrcb+fljzuXh3dUclCj7xTE55g0xFDw6U= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 31yd4p4vca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 29 Jun 2020 22:48:56 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 29 Jun 2020 22:48:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHHZz8jhwUxCjeCpMsRe7zP4mPEKTRTCtDxNKOZfZXrMaucbmQVzIAKUiufxIHHhltypFsApFPCzHduMX0cV6tKsaDw0DJXT99WdFt/XsmO01HEhdC1EjvY9owOV/RI5PfKnjewSg0oHwgRXc3l5wcjEBydbaqblIubFbNald2/iTNurmBHRzD6vUZGUpdbEA3ALwJuxCK9QO2a/v4zsNz8AG3r7VKCh+eWlpuo1EoK1aID23gB/1MozBp6538lAcP71Ucz/fKHQIbLgjjpCLCqnh4iFU1wxqikeb+AwyzBT09LiTxB3Vc2zOjyQ6QPA11R2VUFawiBU+SX4KU1pEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXbcS8s3gY2J+x4jZcETP2JYXfVbKRHX8/27GJwP/CU=;
 b=E/b4Ekb/3uN03phsSj1NjoMUC9StxEkcWS+nQlF+JGB+9ux5aO4mY8KBminhxs8ejYyaXSdHWxmBr127c2IGN9AAKh8N4/+0N5rs8Axolu9k6AwoGpUf1nSCAwUKNLjd7BRSTZWvqZykCgwtC+r3znrRsedp7mLjn1d+CiCP0YHixUiLdb9H8KADUX83Vs+tbLdTPjxK1bkwsvyCs3915sWDxL4m6BC/jmIcm3dpMhT4Mmm3N7ktt41Sn8KE3P1x4h6GlKvcfLcEC8xTYi44DURBEZykjnsNn9xu/M+c20ALSoGQwmWqWLNX0CwGPu5H18N4h4yRt9HiLOQJO+ORcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXbcS8s3gY2J+x4jZcETP2JYXfVbKRHX8/27GJwP/CU=;
 b=MLqpwhNcsfgKKF1prTPEBPTpJ5m10eEnfPSx+VcTbI+4jCzFsUzKUTooHUdB49s7TplUGGJZWEiconELbE9gn2yqFoqIc5IA5H+T8vL8IuWLre/a9v/mGpmM7cJbL2MHFsHSjBEhGGKo+1r0klsz03ekSiqpPXcMgQB7WHSU2IA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2325.namprd15.prod.outlook.com (2603:10b6:a02:85::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Tue, 30 Jun
 2020 05:48:53 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301%7]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 05:48:53 +0000
Subject: Re: [PATCH bpf v2 0/6] Fix attach / detach uapi for sockmap and
 flow_dissector
To:     Lorenz Bauer <lmb@cloudflare.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <sdf@google.com>, <jakub@cloudflare.com>,
        <john.fastabend@gmail.com>
CC:     <kernel-team@cloudflare.com>, <bpf@vger.kernel.org>
References: <20200629095630.7933-1-lmb@cloudflare.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <07d10dab-64f7-d7af-25b9-a61b39c8daf2@fb.com>
Date:   Mon, 29 Jun 2020 22:48:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200629095630.7933-1-lmb@cloudflare.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::37) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e8::15c2] (2620:10d:c090:400::5:3f83) by BYAPR05CA0024.namprd05.prod.outlook.com (2603:10b6:a03:c0::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.10 via Frontend Transport; Tue, 30 Jun 2020 05:48:52 +0000
X-Originating-IP: [2620:10d:c090:400::5:3f83]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87424961-2c2f-4b3f-1088-08d81cb94565
X-MS-TrafficTypeDiagnostic: BYAPR15MB2325:
X-Microsoft-Antispam-PRVS: <BYAPR15MB23258495BC857CD094FAE7C0D36F0@BYAPR15MB2325.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0450A714CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WVFK06G/AByZQAooD5Ch2ngNHPn/lWGEPzKHvRpa1Sl4S3DMnlAmA4aTd+VOR2W8n/ISLjgq6unNk/qMqq8wAKD9vnVV+ibH6zZb1PMc0DNuoyCwxrr/+Jk4f4M+faUWaHRRYT/dFQLI6mnIiuMzbQHJlQbDIdtEtK3twt/rn7PpZtG7Gn8edXyhgm4sl6kg5ssrUpP07u80LjcoDn4N3MeelK+bCSzEAlefzBB13TKVnCAxp+AA1V/uqa80dOPaZ82Xd6KKe+gQPCyqaZDIq1KWZjDXvWf5i0byu4IX/i2wmKFhRpAL/sDnc6nMvdltzp0nX78cRY7fcinocGQB/D6ggC1Bf8eAB5qH2YYoZ8ycMOMBQPbdPz5ECqBhemAXf4WQTSGVVqH85wy6lMZO7oQ9vvCk9SV1q/GPBLkEB1zzKrGTAeWozPAEvGk3T8wyNbivedaNgGtjsbkXBnXTzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(39860400002)(366004)(396003)(136003)(346002)(66476007)(8936002)(36756003)(66946007)(2906002)(5660300002)(31686004)(6486002)(316002)(186003)(16526019)(2616005)(4326008)(52116002)(86362001)(53546011)(8676002)(66556008)(31696002)(966005)(478600001)(83380400001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: cwbxYDlA046H1Z3bQImMZBc0xTCIqcbFkTCY5Vdqpb5xNskJv1Ai3mkswDe3hH9mNoCnDBYtP3nbk8dJuIP7Dbzmc25M+SINYtvPyL9oMiDDV00g1q2Dk1qbS4/rJ9/V4/Y7zL94ce20JNKFvFhhNvnOUkkZwqtglgdSp8/7bUPKKvDCxVUe7NleEzmwAWyihpEqCV7d5lOT25ERy/H71iXZh3iAt3LMAD0XwrQegY5o0rjcc9fR9wzVWJA63YrSVVntgtV9jE4qrvMBwiTAo218BVzjfOwHSaT4NXF2De4RqsqS/bXWKIZROaxILitWs/kbi3dCAQV8D0ipfIEGlmVLaLlF1UgouHPWJXoTfqAOdu70COQ4dcad+z7L3BQBPE0oMug9XupfYEqsEXvtPO5eusIz7ejFtjnV/clmmXfgPmsZ7UAKsTSuREqGUsHzT0SoPwiU+6awygVxGXGWgRpMsse/J3mCvrbGndB+dzYcC4pOAvUwUljfaaBwhn+N4m8VnvJhO0s5e5Q8+Ez23w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 87424961-2c2f-4b3f-1088-08d81cb94565
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2020 05:48:53.5571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ji+cstIWpkYS1wrgBmEMQkFvvPJoegjfQuT4UCzvaCP2HYfWWwD8VDTV3aVLHlJ3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2325
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-29_21:2020-06-29,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 adultscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 cotscore=-2147483648 clxscore=1011 mlxlogscore=999
 priorityscore=1501 phishscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300043
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/29/20 2:56 AM, Lorenz Bauer wrote:
> Both sockmap and flow_dissector ingnore various arguments passed to
> BPF_PROG_ATTACH and BPF_PROG_DETACH. We can fix the attach case by
> checking that the unused arguments are zero. I considered requiring
> target_fd to be -1 instead of 0, but this leads to a lot of churn
> in selftests. There is also precedent in that bpf_iter already
> expects 0 for a similar field. I think that we can come up with a

Since bpf_iter is mentioned here, I would like to provide a little
context on how target_fd in link_create is treated there.

Currently, target_fd is always 0 as it is not used. This is
just easier if we want to use it in the future.

In the future, bpf_iter can maintain that target_fd must be 0
or it may not so. For example, it can add a flag value in
link_create such that when flag is set it will take whatever
value in target_fd and use it. Or it may just take a non-0
target_fd as an indication of the flag is set. I have not
finalized patches yet. I intend to do the latter, i.e.,
taking a non-0 target_fd. But we will see once my bpf_iter
patches for map elements are out.

There is another example where 0 and non-0 prog_fd make a difference.
The attach_prog_fd field when doing prog_load.
When attach_prog_fd is 0, it means attaching to vmlinux through
attach_btf_id. If attach_prog_fd is not 0, it means attaching to
another bpf program (replace). So user space (libbpf) may
already need to pay attention to this.

> work around for fd 0 should we need to in the future.
> 
> The detach case is more problematic: both cgroups and lirc2 verify
> that attach_bpf_fd matches the currently attached program. This
> way you need access to the program fd to be able to remove it.
> Neither sockmap nor flow_dissector do this. flow_dissector even
> has a check for CAP_NET_ADMIN because of this. The patch set
> addresses this by implementing the desired behaviour.
> 
> There is a possibility for user space breakage: any callers that
> don't provide the correct fd will fail with ENOENT. For sockmap
> the risk is low: even the selftests assume that sockmap works
> the way I described. For flow_dissector the story is less
> straightforward, and the selftests use a variety of arguments.
> 
> I've includes fixes tags for the oldest commits that allow an easy
> backport, however the behaviour dates back to when sockmap and
> flow_dissector were introduced. What is the best way to handle these?
> 
> This set is based on top of Jakub's work "bpf, netns: Prepare
> for multi-prog attachment" available at
> https://lore.kernel.org/bpf/87k0zwmhtb.fsf@cloudflare.com/T/
> 
> Since v1:
> - Adjust selftests
> - Implement detach behaviour
> 
> Lorenz Bauer (6):
>    bpf: flow_dissector: check value of unused flags to BPF_PROG_ATTACH
>    bpf: flow_dissector: check value of unused flags to BPF_PROG_DETACH
>    bpf: sockmap: check value of unused args to BPF_PROG_ATTACH
>    bpf: sockmap: require attach_bpf_fd when detaching a program
>    selftests: bpf: pass program and target_fd in flow_dissector_reattach
>    selftests: bpf: pass program to bpf_prog_detach in flow_dissector
> 
>   include/linux/bpf-netns.h                     |  5 +-
>   include/linux/bpf.h                           | 13 ++++-
>   include/linux/skmsg.h                         | 13 +++++
>   kernel/bpf/net_namespace.c                    | 22 ++++++--
>   kernel/bpf/syscall.c                          |  6 +--
>   net/core/sock_map.c                           | 53 +++++++++++++++++--
>   .../selftests/bpf/prog_tests/flow_dissector.c |  4 +-
>   .../bpf/prog_tests/flow_dissector_reattach.c  | 12 ++---
>   8 files changed, 103 insertions(+), 25 deletions(-)
> 
