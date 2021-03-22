Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB74343668
	for <lists+bpf@lfdr.de>; Mon, 22 Mar 2021 02:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhCVBtV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Mar 2021 21:49:21 -0400
Received: from mail-mw2nam12on2087.outbound.protection.outlook.com ([40.107.244.87]:22369
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229579AbhCVBtG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 21 Mar 2021 21:49:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=id5CubFqQMyVNLg3Tu0mjL+W2b0VGPWw4jjLoN06mOVbfO45GYgJMJnG4ezL+Fsz2PfzLqZog0JR/MumQk0jlLm9ou1SVqQqPi1P4E+HtSFGUiPONZe50GdIVLEhfNc/zAtBPKBITaMqm0iEIeqsVdB7LLHmHL/FLbQSctrfucI9HW/aE9PhgwFw/6815awmtKosXvP5a48zVJFAuiiX2vvTCGfLSa6c6z9M3Dc5I4IkiptAHuspko9aqa459evTFfDt89bevr3Zl+4Vf1f02IVQLZ5Unub0aGie96nQ/at8icfrMk4J3cLEIFOCcsfmxxYvdsfKpDDOWpAj8ZIhMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NBl2bxI2QZhHC/0b/fK+4nCbGSZ8/O+xh6SuznoLKg=;
 b=Udp9i/+vZGzNafwn0rs0vCupp2VlVl55jL5DYnI8ebOJyzo2vphn9PWUhk0Ayx0htgfhqw5PGmt07ICracbd6r/n8+2dNJT8qvLMQ93zANIVFijvZ9bLhKh+w/oDZ8yXvql7+a6nt6vbYlJLG9MTcMTCCUrbPTqSmiQ7avxvJCLyzQhRcVJfmhAWWjdts9JqAcZRsQ8GHVW+Y9fs/CNpz8/gEaXVnbGvP3cgRNC6cKDDkLbjSEncz2QaWouiAxP4GWyPJLoygvhKVxxKs/CrL1xB60lgNuadjFz8kNYk6oUF//AcDg57SGhkiwazasMflVnJSEU+KNO3VnLvCCv2HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NBl2bxI2QZhHC/0b/fK+4nCbGSZ8/O+xh6SuznoLKg=;
 b=ld3KTifmf2Krw5GfdNnszDTpoPIepNTYCzuvpL35CtA2B0A+/i7iGZwLfLMXip99LPf7jv4+CEn+Oo24CM9sQ9NdS4AJ8l0bFWi1AQmhmkoHCjBN0JhRSWlDvLyLhY3gAS4xLNBQns/x0xXTsEmr0ZlX37gK8SvmDaB6WjX2l5Y=
Authentication-Results: fb.com; dkim=none (message not signed)
 header.d=none;fb.com; dmarc=none action=none header.from=synaptics.com;
Received: from BY5PR03MB5345.namprd03.prod.outlook.com (2603:10b6:a03:219::16)
 by SJ0PR03MB6270.namprd03.prod.outlook.com (2603:10b6:a03:3ba::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24; Mon, 22 Mar
 2021 01:49:05 +0000
Received: from BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72]) by BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72%7]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 01:49:04 +0000
Date:   Mon, 22 Mar 2021 09:48:43 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: CLANG LTO compatibility issue with DEBUG_INFO_BTF
Message-ID: <20210322094843.752254b3@xhacker.debian>
In-Reply-To: <4e1d1504-55e5-db8b-112b-921d86ef7d5b@fb.com>
References: <20210319113730.7ad6a609@xhacker.debian>
        <4e1d1504-55e5-db8b-112b-921d86ef7d5b@fb.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: SJ0PR03CA0371.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::16) To BY5PR03MB5345.namprd03.prod.outlook.com
 (2603:10b6:a03:219::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by SJ0PR03CA0371.namprd03.prod.outlook.com (2603:10b6:a03:3a1::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 01:49:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a0a4010-4af9-4ca5-c25b-08d8ecd4ac87
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6270:
X-Microsoft-Antispam-PRVS: <SJ0PR03MB62701705DB92D7B0F4591547ED659@SJ0PR03MB6270.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xzrXuZj8PSepXfyRPHfE0kq0qOxlDAoGIH9yR0abOppI7NjVs40pBz+gR2C/pybMVE+vPZXTPYyDjKI1PtevFLU5wx8PDkrqgXxUg39xTr4JGMvE+sM3hgZdSyxln6D+NPol3HBNGp6feHSqjuEg6DFqT/NHGWgzOR+ehL/i1Fh5Fw92wOunaMQItipE6AkOfyLxjZIgIRCMYJLLNafQRIsDQyUQsIBNc1LiooMoplWvYqbtQY3fR36SZ2a719U2jOlP1L2rGg8HwE1fTWr6I6nWZiHEW+iKTqLBPLrZb7Bd+YjvmV1OfI8u73cCyuwKuagWD0SD6wLYtZ+3TANpCu9qBCLZNwIirSMewhqhEHlM2XzBEjfgEUQRcsnUcmfhx48M39XdbtwE1yo0/UwDfslNoI2AOiZqtMqGmsqJjj1r/faigE7gHXRjxPkQNEhlAaQu8HMhQlgxf++7zW/wfo9uM/hdQNCXMnzubpuprQ75ZQFZvLhRUt7Ugd294jJPpXHorI/6j03+cEhwxy1IpRg4VE76Czjfl8jnI4Tom4Q6HHsIw/iHsXzcHkpybb1lB/fBftTnWQctxEpWvXBpj9Snq8atIq2FUJe6ZHCnkTGM7ZNmXIXF1GY8ezaf7iKtrL0Csz90nKw3X6Zv9Lh9Fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR03MB5345.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39850400004)(376002)(396003)(366004)(4326008)(52116002)(7696005)(55016002)(8676002)(478600001)(316002)(8936002)(54906003)(66476007)(6916009)(66556008)(66946007)(9686003)(2906002)(53546011)(956004)(6666004)(5660300002)(38100700001)(83380400001)(186003)(26005)(1076003)(86362001)(16526019)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?h23KmLov83TRtgkm3Rv1+eEy26TZXFb3T7dK2FQJYzMY2Xjxoi6YzGQyqSoT?=
 =?us-ascii?Q?ZcYDpoL+PaHGhv9fbFg/8lq25HXFFIU8VGpWP49Uj7vsa7lzmT7MZis7oPPN?=
 =?us-ascii?Q?1Bl1DOcH38+NigPsSVSjO5FIBivrlMTBb9/sm8jzccS85UDl/yL77ilixh2g?=
 =?us-ascii?Q?c6K7iRYg30IBcDNbsvZ5lCDa5jFmlE+ZUVNlZu+4yC3p5CpaRfiNpXf+jJb0?=
 =?us-ascii?Q?BGMDgB1WWpJ7lUkcylETkYHB4lg6aVnXT6cxptR76L6twIP7qcq4o/UleG6H?=
 =?us-ascii?Q?8o7isjSqgiJcHPnAJtKTT22h1l+F/J6lWHFaXr7SpJFgrNwr1bfbjhPRn8He?=
 =?us-ascii?Q?DgvhCo8amP6/z8+y7Ud6c0KIVe+wTtRDCrZwgiJRUgtAqlcXqN6vGDI5PSDw?=
 =?us-ascii?Q?ZYRP13bxBTwd0CQ3YdO+VhRz33uieJR75pZeO/wR1CXDHKI/jZHfsB4WGMPN?=
 =?us-ascii?Q?CmuL3xtMqbCisT3k2A+17qU8ZEcW4uwWJEkky6dfA1X7QZLk24XC+TIUUGEx?=
 =?us-ascii?Q?JhxzXPCSYYoKFxw0rNQbjF4o7scrtlobv3+l4dZ85t1GruXvUpWEjYEekwKl?=
 =?us-ascii?Q?Lx8RObgTgbE4iuCNe/6ZV0R9Xu/Q7C8xRbHG3BC/j8gpLbNmNLH0sTNmvjQl?=
 =?us-ascii?Q?TQk6uFd1sAQiRft7+zTZoChE/eJzcejNZcBY5QCIpTPxQOgIVgtd5wCw0lFg?=
 =?us-ascii?Q?QhkeFHM1DiuLkjsLTFlLt9yep+K/+rRnQr4WLrPYxxO+oYAVyd1xePIT2mBF?=
 =?us-ascii?Q?Qu+zXZDJSaKDQrY1tgr7ZUmV+bXu9/Zrd9iZ1zzw8XLg1AW11riAJk8GYxA9?=
 =?us-ascii?Q?E27eCleQMYihOA8lRJG9zwYLlAO3uM0eQ/+Xqd+Ou2i3nphOBCjPdMzxTuU2?=
 =?us-ascii?Q?jLhKQXLMClIoLHYAXt5347xbAICpizjYcLPQUMH831h56WVbPYlisjffhaET?=
 =?us-ascii?Q?CAcbauKtdD+fAMUnjPLB81Zfn7FnpjJUqBwr6lEYlK6bvWa39K2X6MvZXl9Z?=
 =?us-ascii?Q?zYoF8yQEWrPgTXkQSUnHSqOCd8q1W94TQGsawnPcOldj88F0ySLzcoG4cg8R?=
 =?us-ascii?Q?1WeQj28dfToZ5xj23s6FyyljMUYKlNrWpLajAkAhrSbu4iGJLmFhJhRkIyCr?=
 =?us-ascii?Q?Bw7tNvlFg9Z8zhAhp26qrf2KjpnJ+G1LL86puzZGpl1YwkJu5C21FZgT4xqm?=
 =?us-ascii?Q?+ZjsB31BHZFh1nvHYpphKtpk0Fs3rR6JASSg7U/C67hZ0ueW9pWxBBkyDANr?=
 =?us-ascii?Q?CPtPiUJcLWWlRQtsKjHI8UxViJKcWbgiZOtU0LDgYo6msN1b1DByIKtKlq+t?=
 =?us-ascii?Q?BwVg1yVDYXWzIGt9BUMqOUIl?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0a4010-4af9-4ca5-c25b-08d8ecd4ac87
X-MS-Exchange-CrossTenant-AuthSource: BY5PR03MB5345.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 01:49:04.6716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5/lG5Ldu8NCHKtw8GTW/IzBo/JTokuSkLdUZs25tDZK1Or2paYeHN3sEb6hLyE45enmw6pAE4VNxKOWDDQSU4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6270
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 18 Mar 2021 20:56:46 -0700 Yonghong Song wrote:


> 
> On 3/18/21 8:45 PM, Jisheng Zhang wrote:
> > Hi,
> >
> > When trying the latest 5.12-rc3 with both LTO_CLANG_THIN and DEBUG_INFO_BTF
> > enabled, I met lots of warnings such as:
> >
> > ...
> > tag__recode_dwarf_type: couldn't find 0x4a7ade5 type for 0x4ab9f88 (subroutine_type)!
> > ftype__recode_dwarf_types: couldn't find 0x4a7ade5 type for 0x4ab9fa4 (formal_parameter)!
> > ...
> > namespace__recode_dwarf_types: couldn't find 0x4a8ff4a type for 0x4aba05c (member)!
> > namespace__recode_dwarf_types: couldn't find 0x4a7ae9b type for 0x4aba084 (member)!
> > ...
> > WARN: multiple IDs found for 'path': 281, 729994 - using 281
> > WARN: multiple IDs found for 'task_struct': 421, 730101 - using 421
> > ...
> >
> >
> > then finally get build error:
> > FAILED unresolved symbol vfs_truncate
> >
> >
> > Is this a known issue? Do we need to make DEBUG_INFO_BTF depend on !LTO?  
> 
> This is a known issue for pahole. pahole does not handle dwarf well
> generated with LTO. Bill Wendling from google is looking at the issue
> and I will help look at the issue as well. Since bpf heavily depends
> on BTF, at this point, I suggest if you are using bpf, please do not
> turn on LTO. Or if you build with LTO, just turn off DEBUG_INFO_BTF
> in your config. Thanks!
> 

Got it. Thanks for the information
