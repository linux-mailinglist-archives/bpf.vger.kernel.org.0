Return-Path: <bpf+bounces-13674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF2A7DC5D8
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 06:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24A272814D7
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 05:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16212D275;
	Tue, 31 Oct 2023 05:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="mhV3xAcO"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB436CA7C
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 05:22:34 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2064.outbound.protection.outlook.com [40.107.6.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A26EB7
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 22:22:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZYmZgvfwA9T9hSA4hIWXLEmr3fZQZs65VCYPyO91vKQLi+HBO6buvn0BgsTJjclzZk9wv1b61BXkoMw8FhRnZYRRbH+WVOUffyF0v5G1IA3ATMFw1HzwXBFuuNu/P3oEEw4QSN9hqyIyn5r39un6QD7PVEVzQAGjDqF3vulR6d5VMa009Fr80vhNnwdmiLc+UjJhQjJkuZqlybWpPt+252pMIiD4R5c8vf391G4YcjEukai648dzVnk1O25iCNoXIZ4Q1PPvSnwZgaW2Ie1Lb75PSpChMQP6OSj4i4ZSAZjR+EIrAuAskRAtcw7nuuDXlDBRnH5YfvNB3gsBMhbQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1eOtQc6oD2x5RVfsCSsvhl1aRpHVriA6ICXW8ZfS4OQ=;
 b=EdK/uavzCrtlFhR67P8q42pPTSRRx46RxtFCmtq/IoTsyB0qnhK87vnpBc1PrZxGKpYNlkE7wJS10d/klB1w+oQu539PqSIejz2tcSzxyEm1XPOwThzBq2xXyB0Q0zngum5wD9hIbFzy9qPMYUXuzmKzvPfNv5rjuBOZMAELaqLwBuWD96zqBiz1IdlYAfffOtPwww68OrcGIORtwaqq8vb+9dT0HkKiLT4sPfnpBtFSaJcwLiO/lqQgAIMGqd8JzwkyQudUfn09GcTSFzgVCcRMmGaH3zZPKnSEPIrixwK919igJ4wsGlP+9IKUzc+UPKhab7Gj/ujIEYDQmxzdLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1eOtQc6oD2x5RVfsCSsvhl1aRpHVriA6ICXW8ZfS4OQ=;
 b=mhV3xAcO29/8CkLHPzxK65zZTyiJW751a3KCMtSEeHtr9OjSEXgdZaI+E7pT2oTBPp8ZIxGhnUpF9Y+R2ayUVMT3IeTHUyfdWS6nLk5+t8TfXednpcjM6YhZdXLIocWjq57uKnkdGzfcjwCI5LltE/wpHrL7omvyASdoNTjMczRyLVvytmHhH2f7+ymiicWPmn6mEB2jc7X+uDmJmQ4LJDU+TG42ypZ8op+NOVZbaYm1BE4SEixRPusdnqN9LsScGOFBjuiRFv0SIe3PPpmyGcVgl395vHaEKg7MAV1i0N4U4Whml/WDk32r902IbEQxMUU1GrhBIEUZGoOmQCEfTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by PAXPR04MB9217.eurprd04.prod.outlook.com (2603:10a6:102:232::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.18; Tue, 31 Oct
 2023 05:22:30 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c%6]) with mapi id 15.20.6954.016; Tue, 31 Oct 2023
 05:22:30 +0000
Date: Tue, 31 Oct 2023 13:22:19 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andriin@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [RFC bpf 2/2] selftests/bpf: precision tracking test for BPF_ALU
 | BPF_TO_BE | BPF_END
Message-ID: <ZUCPC21XwyjDXxP1@u94a>
References: <20231030132145.20867-1-shung-hsi.yu@suse.com>
 <20231030132145.20867-3-shung-hsi.yu@suse.com>
 <905f4ae9a5d9fe1a030d7e7442e980e9d49e00b9.camel@gmail.com>
 <CAADnVQKF6G2au4QPNwxyxNBLTvzhJpADYxKeYMjPg3wA1jJNAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKF6G2au4QPNwxyxNBLTvzhJpADYxKeYMjPg3wA1jJNAA@mail.gmail.com>
X-ClientProxiedBy: FR4P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::6) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|PAXPR04MB9217:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb9ab18-acb3-4938-9029-08dbd9d160e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	u3qgc8NEUi+zk7Y+414G33QYcZ4rAz5KgeJ0rOC0ZIJEqXdgiaB1j1yXqCXSh9cwvwwMhmUf5UVUxqX9aHzVEg6VR37a+kiCisjYTHTemt2UvUxFkM6JFW3sX3FtuDPc89iTLZwzhL9DBAhgaaD6Qcb88CnUObA76ts46xl/xDXwddObSuGIMMTYOV898LCya+jfnq5Chh9UWsxG7NUQYgaP36nolpADjq68p+Drq+tMoGhfn3qpXP9HCKN59a238IqEAniKdjV2xMzagR4wRZm09A34Cu6tNaH0W8byEPBzkg8EnVh9oyUzu5uf3xg2ZOKQVgmULRMEVONz0brWOlQ7cCx7z7GN+LF/msyMok2mVC4HkFOw6XNhQm6zoIlDthQYjR64L5N7yyQfkROHVOZjzRqDJHQwXVrCX/FnjV7SYkvMZETAsvgM2u+8R0T/XRvY0qwBXIvRvETb2zgYepxA5VnAHrKS1fnBQds7W3VBU5bMHSlUNb0i/BkP9V4oxjFdupWOD2KuJCNiUvztHAIXpLJaC41S5fmSVEaMzq6pns/xtYJNH8d5VuYxlTQb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(39860400002)(396003)(136003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(7416002)(66899024)(9686003)(6512007)(26005)(38100700002)(86362001)(4001150100001)(2906002)(478600001)(6506007)(53546011)(6666004)(8936002)(8676002)(6486002)(66476007)(316002)(4326008)(54906003)(66556008)(33716001)(41300700001)(110136005)(66946007)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2h1ZWNyOXB4QkRQNmJNcmJYL3ErNGVxWlREWktCd1BqQ0RjdXdDN1EyZlh5?=
 =?utf-8?B?Nzhac3VSMnU0QnJzQnJzMEdZdjNvN2pRVEtCL1hHeFBJY0lNUEJST1MzK05M?=
 =?utf-8?B?MGJVS0dSQnJWSGdKWWNlUFhXRXpKL3U1WldHVVJsaTdmN3o5R3JORWdra251?=
 =?utf-8?B?RFFlR3dya0YyRzM4TXNyZE9JTXp3aTNTcGNuWSt2QmQycmZxTEtZZlRoVjBF?=
 =?utf-8?B?SjRaeGJ5ZDRiMG5wVUFUdFJ3OFpJRVNZY3QxOVhCZ1kwanFCTTlYU04wekp4?=
 =?utf-8?B?ZEl1dVl2QVFWWHJRaGZ1ODJGQ1FLQm5LSGZsN1NuckJrb3dMSEVCcmU1Rjc2?=
 =?utf-8?B?SEhrbXNQSDBuakh1RFZBWXNZaGJMOUlGTnVheGM5K1hKVTJ5cGFVNHk4N2hQ?=
 =?utf-8?B?YkpGdVFJNUMyWXlOUUYySmVVMmwvYUhPdDhSMllVcUNjUGw2a2liNFdja0hL?=
 =?utf-8?B?bmlTZ1ViVjJKTm1BMCtKaWF6OWt4MlNscWJySzQxT25Ya0lOdU5hbTMrT0FF?=
 =?utf-8?B?VGVsOFpIVUE4Rm85b2hBMlhoUldiNFFTS1FLc0UvR1VpRHFKRmF6Zkt4NS9B?=
 =?utf-8?B?RmZ1SHE2SFZJOWpVaERCQTh6VVpaOUZrdUNFbkxLSWVFdFI5Zjc3WTJRa0tn?=
 =?utf-8?B?ZVFZSjA2UXo2d1l5ZWlxbFZGZzVZR1NBYmg2bys2eDdQRnd2aGhmdnFENnNs?=
 =?utf-8?B?eStvWGd5TzVRS2o1c0wxYXJ3RDBYcEtGaUxLeU5PdGZPTVVFZ2loQWtyN1BO?=
 =?utf-8?B?S1ZmdW10ZFVMVXpGbkttSVpxbkRxS0tXWTlQc0hDMFA2dW5yZXhDVEk2eFNM?=
 =?utf-8?B?cEVsbXRLZU9ZYXFWM3BlbDdoZURMR1lKWnFpenBoc3Y3eFZTTzBBZTJDNzUr?=
 =?utf-8?B?WnRXbkpRRUR5NEtEUDRzaFhIb2d3N3NiNVR0Yyt4MWRqVlBkc1gvVVBEWGNv?=
 =?utf-8?B?TmZ4bS8vT2gzbEJFaVdYRnlKeDBtekhkQld3dDhXT05WNGR4ODdRMjdwdnZi?=
 =?utf-8?B?cmphMTVMNmxIK0JicmphQTJoSlRGUXVvOHV5UFZ4eTdOeHduUlJvSFpGTnZE?=
 =?utf-8?B?VGIwUzdHclAzdWtSZ0tVcVhGM094MzluZGp0R002blRaWHlDWDM5Vm16OGJl?=
 =?utf-8?B?Z3FJSkhKeFVkdjd3VEtjZ25EdHBQYzhqb0c4QjRlMmxnR2gxTE9PdmtidlFz?=
 =?utf-8?B?V1Blbzd4QU1CTEhDSHpXc05FcEE2NVhFZ2RMZXMrT3hlMUFEaE4rSDdFZzFY?=
 =?utf-8?B?SUxIMXViUzQwamZJQWt5eXVZcVR2dnZUYmpmVE9OZ0lPd0VPQUdiS2pjUHBB?=
 =?utf-8?B?MFBlOFV1MnhzQWRVekU3ZkM0UjJnZGltMzJmWjdjSWNCTTNkangvVFIzRkxQ?=
 =?utf-8?B?NUpyZ0tWUExvMm1YdVpiSEpIOHBQR3FrK3MrQlgrOHVIOUh3dzJ5dEhHcXZU?=
 =?utf-8?B?b09DYWp0MG9pb2xmY3IvU3VvOG41NlVsU3dEaElqUWdtcE83Tk5ueEZvcmNQ?=
 =?utf-8?B?S25xQkRFQ3VnbUU4YWxLUk1IaGx0KzN2Z0JyMnNhUXVZMWlERWt2V1hodGo2?=
 =?utf-8?B?bThWd1ZWZTBnSEM2U3hPNzJ3N0hYeUV0UVJaWEdrd2lhQ2VXZTFncUJob0U4?=
 =?utf-8?B?WFBjc0ZZeHpId0pIbWpBbFM3S3ZVdmEzN1JyUjlSdjVLV3RMQU0xWm5NSWs0?=
 =?utf-8?B?dmRpNjloQ3Y2RkZWWXZUM2pIOVhJS0hudnN2NW9NSk90OG5NSnRKR0dxL1V1?=
 =?utf-8?B?QlFLTy9tNTN6WHIya2JWZmJmZjExR1dJbEwzQ2ZMMThEVlZZVUFaOVFKY3c2?=
 =?utf-8?B?bVIwaXR0Zi9EZW44eWJFdkFRZXVHV1BBc084MzM0U2lQa3B5Z2VibjV2eTBG?=
 =?utf-8?B?NmRsTldtc2RMV3FaM3NweitZa3EvTHdLVFJNWnlTWDllOGNvR1c4ZHBOY0ND?=
 =?utf-8?B?N3ZPVDdFRFV5emJ6REJVbVhVajJRYXAzcUp6SDk4em9MUEJNVDVjOUhibzFR?=
 =?utf-8?B?TWJBM3FhSVhxcHIzakJieUVEWldBZzRKellydWorTzBwS1h4ZE9jNHVwRE85?=
 =?utf-8?B?MHJYY0lNYkxWczlpb2pvNjBWeTB2V2RkRUNtUS8vKzhvNkYwMjYrbTlNam5l?=
 =?utf-8?Q?w9XaEclt1DHq/DpeIKxP0PTwh?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb9ab18-acb3-4938-9029-08dbd9d160e4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 05:22:30.2857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pb9QWV5aGDcMijpcTKNZnnFO77Ml8CDOS5sFIGM5foiyu4vcQC15iWRlREcwR1Murk3tQqp0guNN8PVHlFmKhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9217

On Mon, Oct 30, 2023 at 10:17:10AM -0700, Alexei Starovoitov wrote:
> On Mon, Oct 30, 2023 at 7:36 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
> > On Mon, 2023-10-30 at 21:21 +0800, Shung-Hsi Yu wrote:
> > > Add a test written with inline assembly to check that the verifier does
> > > not incorrecly use the src_reg field of a BPF_ALU | BPF_TO_BE | BPF_END
> > > instruction.
> > >
> > > Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> > > ---
> > >
> > > This is the first time I'm writing a selftest so there's a lot of
> > > question I can't answer myself. Looking for suggestions regarding:
> > >
> > > 1. Whether BPF_NEG and other BPF_END cases should be tested as well
> >
> > It is probably good to test BPF_NEG, unfortunately verifier does not
> > track range information for BPF_NEG, so I ended up with the following
> > contraption:
> 
> Makes sense to me.
> 
> > SEC("?raw_tp")
> > __success __log_level(2)
> > __msg("mark_precise: frame0: regs=r2 stack= before 3: (bf) r1 = r10")
> > __msg("mark_precise: frame0: regs=r2 stack= before 2: (55) if r2 != 0xfffffff8 goto pc+2")
> > __msg("mark_precise: frame0: regs=r2 stack= before 1: (87) r2 = -r2")
> > __msg("mark_precise: frame0: regs=r2 stack= before 0: (b7) r2 = 8")
> > __naked int bpf_neg(void)
> > {
> >         asm volatile (
> >                 "r2 = 8;"
> >                 "r2 = -r2;"
> >                 "if r2 != -8 goto 1f;"
> >                 "r1 = r10;"
> >                 "r1 += r2;"
> >         "1:"
> >                 "r0 = 0;"
> >                 "exit;"
> >                 ::: __clobber_all);
> > }
> >
> > Also, maybe it's good to test bswap version of BPF_END (CPU v4
> > instruction) for completeness, e.g. as follows:
> >
> > #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
> >         (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) || \
> >         defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390)) && \
> >         __clang_major__ >= 18
> >
> > ...
> >                 "r2 = bswap16 r2;"
> 
> +1. Let's have a test for this one as well.
> 
> > ...
> >
> > #endif
> >
> > > 2. While the suggested way of writing BPF assembly is with inline
> > >    assembly[0], as done here, maybe it is better to have this test case
> > >    added in verifier/precise.c and written using macro instead?
> > >    The rational is that ideally we want the selftest to be backport to
> > >    the v5.3+ stable kernels alongside the fix, but __msg macro used here
> > >    is only available since v6.2.
> >
> > As far as I understand we want to have new tests written in assembly,
> > but let's wait for Alexei or Andrii to comment.
> 
> Backports is not a reason to use macros.
> Please continue with inline asm.

Got it, will add tests for negation and bswap with inline assembly.

Thanks you both for feedbacks and suggestions!

