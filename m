Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21BE02857C3
	for <lists+bpf@lfdr.de>; Wed,  7 Oct 2020 06:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgJGEbr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Oct 2020 00:31:47 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36594 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726388AbgJGEbr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 7 Oct 2020 00:31:47 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0974UbuJ017791;
        Tue, 6 Oct 2020 21:31:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=fAx97bmWWv7pXu6hBwt+5yB/lmaVGVEfj/nDL//ggj4=;
 b=LXS1osk0Hh85xeeTX+fjkUCJk/bondiyLb6anzrKltB6b0Xqehzp0KxEhOYFt2Wmva24
 Tfwa6+2qPCqg59IHN3hdi+9m7TKY173BryfWT5sxI96s7VEksVopWqcRrdqng+Sn0U/j
 TypD0HF0GLuxRMt0uBLLFYbflN2WOwcMaLI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33y8stxjnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 06 Oct 2020 21:31:32 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 6 Oct 2020 21:31:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clkD6KB3itZm0CGIOvwrVyR4q/JLFLCV8GfkaiaRZDybFh5Y7jslHIrqdBsIW/yxAmv2qLU7S3AxQMN6ot74vrcjYSoZAaH/nj/tLtjjXGRF7sAFbvKUqZro1FDLcwula/oYicDDhpKMpzz+Ap4QERBCb/4KCkvV9bAb74b/2yqg9yJkHEYlDHipnBfevYRHAgdrugQUwVrPVtRK+B3VTXZoJfq2uPg3PlJM86iS5ILXGOirmANBQfgZKx20nX14ypALBYi80jEe8wMHS5FTvBfISJvF7cw7Wp5n9s6xmzz0ossj+9OF0IDXbz/gWFALHf+lj9HgKkkcTVgEmOuCEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAx97bmWWv7pXu6hBwt+5yB/lmaVGVEfj/nDL//ggj4=;
 b=Tz8V1zyjHz7PIYVEFbzRZ52IWI6XGkatnL/B1SNevMnw+Lb0fOkmUIIVB6Zv4wHAcMj8blXKlm23mf+/sEmzNsUI7mnGsz0SE+jZee59oFSNUYM+Z2T9YVEYVawAzSZf3UiBFPbKGZkamyF40w25EfM27lO46f10QnNuppr3S4Nv9JYZ71MvO5lTAIL3jMZydBkVKeB32H4bTDd/t8ufgj2hPFl7fe0SSyLNEyxsm+ArD1+WIc8Ms2OqKxq0+6SWZhlF/PPMttnV/hv7FOXaigt09L6wwQUdLdBZ41ilql8m0RJBtI1hA+O+el5yHzu7NaPxr/KEwYFYJGFwLdCZow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAx97bmWWv7pXu6hBwt+5yB/lmaVGVEfj/nDL//ggj4=;
 b=H3xs8wFryiKmWSPpGE9X1G5++OVJIgJL3JwzUKTSQyPXVRADPn28Ab4E6SUf1cXVOn1ZDTQ35BzkkNK2RwwPwMibe4l6CYEjPKL/TGXIX7ANz9rDZYsvUXuyV2FDrhI/RecOfjf3fkjg05JQ6t27jJgPExKGaWa28BvX5u2TzCU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2566.namprd15.prod.outlook.com (2603:10b6:a03:150::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Wed, 7 Oct
 2020 04:31:17 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8887:dd68:f497:ea42]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8887:dd68:f497:ea42%3]) with mapi id 15.20.3455.023; Wed, 7 Oct 2020
 04:31:17 +0000
Subject: Re: Failure in test_local_storage at bpf-next
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>
CC:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
References: <CACYkzJ7AfZ4HMEzt7OV_T4N8RO4SJcFbyEVxCgVrkKS4uiOD=g@mail.gmail.com>
 <CAEf4BzbrF9C27gX5JaAq--Ex7+cJe0yz0QKVo9fov2voiiWwtA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <71e1203f-5864-f86d-e587-67d92183b89b@fb.com>
Date:   Tue, 6 Oct 2020 21:31:14 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.1
In-Reply-To: <CAEf4BzbrF9C27gX5JaAq--Ex7+cJe0yz0QKVo9fov2voiiWwtA@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:757]
X-ClientProxiedBy: CO1PR15CA0044.namprd15.prod.outlook.com
 (2603:10b6:101:1f::12) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::121a] (2620:10d:c090:400::5:757) by CO1PR15CA0044.namprd15.prod.outlook.com (2603:10b6:101:1f::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend Transport; Wed, 7 Oct 2020 04:31:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5821226-1e64-49be-bac7-08d86a79d4e5
X-MS-TrafficTypeDiagnostic: BYAPR15MB2566:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2566BFFD89AF1A04F687EB5DD30A0@BYAPR15MB2566.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kpq5yMleo7icrrd7jmsJleSFb3o1H0yCrSBaFbzUIvzjkd+dEjCq5Xx88dJzrmCLxWGNSM0BHe0pWTzUIRBg8OE3eTOi+hkhni9zcUfagwU4rFqe8zT0kbDBv52KLDYZFv6ZrM1mAho1tAAsz4WCwW3ZEY/z5VR5KwqJ+4oymNqsUkgLqKOrX/kWEJlvQPTaEt4aqmFtbgiO+K8iH5dPtdQo/GePcJcQ8E1aI1CSvvHliUOoeBnSk6q18QiLpBZ4TmuGG9vOJiMOo+PVl9R2cYKdfUtTPtVZEkNQRrhrESASXcdIawHgWb9lmqpHchM1+LdLwc396A45VXqWj61i3RZnmU3cCwNNGWhwe/hjEpV8ARfXIsPL0em8Nzb6V3UlM53fydwTeFKo+zCp84alPs89qg8fC8FJmJQvk/C2sx8B3HXcCrkukGsCNJPQnETPfD4nZn/f8BMywv02L1w5Kg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(39860400002)(376002)(396003)(5660300002)(52116002)(8676002)(86362001)(4326008)(316002)(66476007)(66556008)(8936002)(66946007)(83080400001)(83380400001)(31686004)(966005)(36756003)(53546011)(2616005)(186003)(2906002)(478600001)(16526019)(110136005)(54906003)(31696002)(6486002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: +Xm4J5WKzXv36zKvZr+x5wlWmlBVLUSe/ROvmXOqrKvKxRmrNmWmMDJGlIlmvBs6AZdEe41Kf1YdVu8tqzswRaPDw6DYSBwlEFwSdbYm8WL0h1T3LdwsGG2XjDTdFbt+q1uLoMBLH3IY4dxaMfXzXPkbFrFHa4YgSLjKgL9kF4v9FdiqhoWdcHPQ/rvl/Vs6riz+ZUd9rnzjFeSGSUR0NPxcIBpFjSRLmATPvicHTD0JVyWZIfKnhWP6+MpPK9tiuYI4U28YKPwf+o6+0Xs0iYvwmwqutWXUzoWz8aD0UylYqyBEgSjCsUuH0hE0NYRMuJXtmc+54TF5VsMW7XewPxJZuzfFZ/7TWhx3VYc3qx/rRVxA0rstuJ6XVs58tbc6U/W8cjcrknm745NyVIFx0MTj8THrFkRd8ygvq+nB7e6Foa8l5aBPrz8+Vj3ttdXlsyAfewT7DYD0PoodhmqFIan6ZsTFYGv1W5P/yezPuZprKzyb+iVXwUXeciBpC0E56K4h7khDChl2sCpj68bNZRmD9djlckL8BOnX0FRR0LaZYmYZDXZYTTTcldepMeyeFuL8MePuU0mIedOAQ8RX6L6/9xDY2dKDwzETe6UpHYUFcZ9KCuwhMEUZaMsdqhDs/vOY4ZIF3XNT2j3E3xQN+IXPTOJeK0L4zBosejcwSqs=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5821226-1e64-49be-bac7-08d86a79d4e5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 04:31:17.1895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6mdhPTM5GNraEjtvwY0WpvQl1MQb4I7cxJOVjhPK9FDk9Gx6OgEZ4YnB3LyVvkdt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2566
X-OriginatorOrg: fb.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-07_03:2020-10-06,2020-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 spamscore=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2010070028
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/6/20 6:23 PM, Andrii Nakryiko wrote:
> On Tue, Oct 6, 2020 at 5:31 PM KP Singh <kpsingh@chromium.org> wrote:
>>
>> I noticed that test_local_storage is broken due to a BTF error at
>> bpf-next [67ed375530e2 ("samples: bpf: Driver interrupt statistics in
>> xdpsock")]
>>
>> ./test_progs -t test_local_storage
>> libbpf: prog 'socket_post_create': relo #0: parsing [28] struct socket + 0:0.1 2
> 
> This line is truncated, btw, please make sure you post the entire
> output next time.
> 
> But, this seems like a bug in Clang, it produced invalid access index
> string "0:0.1", there shouldn't be any other separator except ':' in
> those strings.
> 
> Yonghong, can you please take a look? This seems to be a very recent
> regression, I had to update to
> 6c7d713cf5d9bb188f1e73452a256386f0288bf7 sha from not-too-outdated
> version to repro this.

Sorry. This indeed is a llvm regression. The guilty patch is
https://reviews.llvm.org/D88855 which adds NPM (new pass manager) 
support for BPF. The patch just merged this morning, thanks for catching 
the bug so fast. Since NPM is not used by default and the code 
refactoring looks okay, so I did not run selftests. But, yah, it does 
change some semantics of the code...

I just put a fix at https://reviews.llvm.org/D88942.
Hopefully to merge soon.

> 
>> libbpf: prog 'socket_post_create': relo #0: failed to relocate: -22
>> libbpf: failed to perform CO-RE relocations: -22
>> libbpf: failed to load object 'local_storage'
>> libbpf: failed to load BPF skeleton 'local_storage': -22
>> test_test_local_storage:FAIL:skel_load lsm skeleton failed
>>
>> by changing it to use vmlinux.h with:
>>
> 
> [...]
> 
>>
>> clang --version
>> clang version 12.0.0 (https://github.com/llvm/llvm-project.git
>> 6c7d713cf5d9bb188f1e73452a256386f0288bf7)
>> Target: x86_64-unknown-linux-gnu
>> Thread model: posix
>>
>> pahole --version
>> v1.18
>>
>> This error goes away if I comment out the lsm/socket_post_create or
>> the lsm/socket_bind which makes me think that something in
>> bpf_core_apply_relo does not like two programs in the same object
>> having the same BTF type in its signature (but this just a guess, I
>> did not investigate more).  I was wondering if anyone has any ideas
>> what could be going on here.
>>
>> PS: While working on task local storage, I noted that some of the
>> checks in this test were buggy and will send a patch to fix them as
>> well.
>>
>> - KP
