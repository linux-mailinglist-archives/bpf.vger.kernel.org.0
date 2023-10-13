Return-Path: <bpf+bounces-12116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A44497C7C12
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 05:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4272282D28
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 03:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6701108;
	Fri, 13 Oct 2023 03:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="jyYEK0Zk"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA33FED6
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 03:28:10 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2040.outbound.protection.outlook.com [40.107.249.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30083C9;
	Thu, 12 Oct 2023 20:28:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyAMLT78yYoj3QPrlkqWEEOx3oOMUyHpi+zp0JUZCln5f+9oN2igNjEf0hc5tomdatAHi9X39CQYhYtpf1D9mi55DD0FioqHEMPExhLIwezn5HygBEoxE73AX82kWWgow7ZthiJa76NSnL6xmi7/v39DF2XFr1A7H918MsHRId5K+WzqIY5u97ZR5jFAN1ThGv7RBJPrx8YydRe8pezoNQPmlw6Ne7NKCzQDzKc8RiRKaCGD/I6Ep9V2U4dHwAoYcLG/STq9m6JcDLmlvbL8s9So0R6fqtWgT34P1gvRY24B5ed8lxK830Eu0hNSeEHsMr/niLXrkOkpJacteSl16g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ut5kKLzlO6G/ud0tih+z44d23Vje6bC6+AAlpGsk7nQ=;
 b=A2P3YPhcA+rgYXzO1R1BpQtmjSApnWcH2XQ0ulp2re+gR7JOhyoNy+djQLEYltM4aEk81KQESP6IIDFYizbItR7P+hY0zaNXUpzxALsxuVfu4BlPA2DUFyPK3yDXZSaBJEdKN/y6hIG3KKX/7D8VjNcsJ/HAW9J3Tm9b+JctpcdXIIj2NFNz/pa6OehEv9YFSG7Axy1X8NAV26bXo1c7K0sWbgaGa9q/xhm0tNnaxsZg5mpOmb1HLBYQ+5pWX/2qshO5cqIknAKJGOehoD4cVlItUdIPoYW0Ewf3tMdx0Uy/25ukldmc6CYEIzAf+oflUc9zNKXCW1JsKIt3JeegvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ut5kKLzlO6G/ud0tih+z44d23Vje6bC6+AAlpGsk7nQ=;
 b=jyYEK0ZkoRf6AeO80dsy+9Yx+PFhifZVzPjMfz0EtMU/F4Fq9vLWglyM01w2Mkjgml/6XPc/bzzko/WWVoA/WExiCLwswFl6QqoCdn9fRWOmi3Wxrbl/+Mv0VNMbtC1vxW032SqUe+f95tcc+hnOkCfymHGCXfgsGbIFulj8dLEtQl1KO04xkUxy7h4kP8WBrRoqDgtc7Zf/aRxNY2013WukcAIBc01DAiwixYp96DC7VPz+34es+NW9FYvoijKHZfT/sixByLONV4jaiMDiTQ+0wLoF/Aw9xSII4L6grPomRY7BrB3IfRgV1eE4LDBZCk3uEpkTR/qg92TEr8wO/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by AM9PR04MB8227.eurprd04.prod.outlook.com (2603:10a6:20b:3b4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 03:28:05 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::d87f:b654:d14c:c54a]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::d87f:b654:d14c:c54a%3]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 03:28:05 +0000
Date: Fri, 13 Oct 2023 11:27:56 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Hao Sun <sunhao.th@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 1/3] bpf: Detect jumping to reserved code
 during check_cfg()
Message-ID: <ZSi5PHDfoAYcvbCq@u94a>
References: <20231011-jmp-into-reserved-fields-v3-0-97d2aa979788@gmail.com>
 <20231011-jmp-into-reserved-fields-v3-1-97d2aa979788@gmail.com>
 <CAADnVQJnhfbALtNkCauS_ZwRfybcb_mryEvZW7Uu1uOSshQ9Ew@mail.gmail.com>
 <ZSeq7ieG7Cq13w67@u94a>
 <CAADnVQJHAPid9HouwMEnfwDDKuy8BnGia269KSbby2gA030OBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJHAPid9HouwMEnfwDDKuy8BnGia269KSbby2gA030OBg@mail.gmail.com>
X-ClientProxiedBy: FR0P281CA0102.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::18) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|AM9PR04MB8227:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bdce4ab-cc3e-4aa4-2770-08dbcb9c6964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dKzSNFJwZgJgdrk3fuJl5GHofRzIBI42ehkTRH4d9266+q5m9rpoGnp0HPseJFNSPAGp3iqVTX5ogFX/iURXBBMZSfDeyuTrrau8/nZ4JDY6PCtAjHPqATAFlxo4+UzjIDoxTUNCc7477CpW6W6+7pnFGDikcl331zl01dbQr4K8p0spOTXoaxuuckuB1XZvCkAcetQF4TItDldWtT8OYBq+Qexof/7k2fgSPmDWeJj/oqRsOSjvdYjYDgHBGjnPo8G1+uxntJ/MZolXjuSsCHKT+n+6ggvTyG6okJjUHHcBD6D8Ryp1gsvva6V6K291gz0q9eOSD2pFO0aohjZhIWDjcZCo9AsTLhsW0rexKnfDtFu/Q1IAwfIxfSLMsDRXvs5Jk79505WQrjQO4FV8YFtxnWkGFT1FeKg1SUkpQnI3zNJqY58PKV95aLP5eb+6WXLYDZRbf3BLHCIW51QGKC7kwxVF411u/sL6Rj7PTokPlE9j7Xp09u6nNuLHl7DYjPqcD8x0tBohF4uKAsCFsBMKYrf5sQo9v6kIUNdXQkU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(376002)(396003)(136003)(366004)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(966005)(7416002)(2906002)(6666004)(478600001)(33716001)(6486002)(41300700001)(4326008)(8676002)(8936002)(5660300002)(66946007)(66476007)(54906003)(66556008)(316002)(83380400001)(6916009)(26005)(6506007)(9686003)(6512007)(53546011)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFRtK25seERlMW5ySmZnNlFUQTNOdEFVMmdjVkFaQ3IwdFQ4a0owZGcrK3dW?=
 =?utf-8?B?ZmJUYkF0bTJOM0pvVGZzM25WeGpEdVk4eVJ1N3pGWVl0UDU2VzZYY3BNNUxt?=
 =?utf-8?B?anFrYkVWR3BvNUR6ZFBFWUk0dzNLMXdEMTI3YWdETndxbjAwTTlmaGdPSnc2?=
 =?utf-8?B?WkhQK1Z4QkxCSHJsajZ0aWVtak5ZdC8vSCtYSnhhZEpQSXFPeUJhQnFHNEo1?=
 =?utf-8?B?YTB2N0VMV3R2YnNWL1hHNVZpcjRRZWppa2twcFhDV1dINkdNN3JMWFFEeE5j?=
 =?utf-8?B?MUZ6VFdwZWJqcGF6YW1BZUxLTHUzdU1vd3VGeXhrNHQ5SFA0MW1EcDlWMnlv?=
 =?utf-8?B?T3BqYys5SXBmZCtqS3ZvQUhOSnRzN0ZJNldGZERBbldINkVjQklIT2hBcGZj?=
 =?utf-8?B?MGl2ckRKckZQcWlvMVhyK3hYOEtML0x5N1ZRNGVyL202SGdwQzd1YVlQeFZa?=
 =?utf-8?B?TjEwVE5uQ2prNHI4N3k0ZndDY1h4eUwxY0FiQ3lUYXlWZTJONTl4dVZ5UFhZ?=
 =?utf-8?B?cEQzMm96VDEzNmdmUjlQVDB4Y3oxaXNlMTFKc2c0S3h4VzRDRS9nQTdxcmJo?=
 =?utf-8?B?aUxqb2VGWUF1TktTQWxGMndyTGowWWJ1UkhSOFNoN2xzTktwNC9VM0V1WmRR?=
 =?utf-8?B?RUFuZ2krM0N6dHFGazVTNjNrejg1UmhmeTNWMitLRlhrTG1kd3VpSEMyU21Y?=
 =?utf-8?B?TWNQYnNReStCQXhtUHBkcUoxWUx1MHhRRDNkeG5TNndBNG8ydmJETDBTOGpI?=
 =?utf-8?B?dm9HQVdaT2w0VXM1SjdkMWdvajRhNFowSTRzbDRyMnlYd3VtZnZDVGVzTWY5?=
 =?utf-8?B?a1FKMkpJUTZGWlc3R1JnTG4wSW5CV29KWmRvZzlUZzBHMGV3YjRJejJOdWxi?=
 =?utf-8?B?aFAzeStvUFppYjVkSjVhdmpKMDhaQnJ1T0FEVXpuc01iSHFBeXU2aDkzV3V6?=
 =?utf-8?B?VTJ5ZUlzTVhucmxQbUs3SG80WDBVdDIvczdTMXNMQUltaVAyUW9KS3M0N3Fz?=
 =?utf-8?B?MG5lZk5DRXdSeFM0N3J3NVo5RXE1VEk0bUhYSFA4YnVBVkpVRlNoZWRsWVZk?=
 =?utf-8?B?MEhKTzJENGhnL2FIUm43UzM3UC9VQzZiUTJRZU5aU3V4b2V4UWkzMGI0Q0sy?=
 =?utf-8?B?d2JyM0gzUCtZWU9vOEtjMnppM2dERnZkcEdRK3F3Q1BibTdCYktpRk9UK29m?=
 =?utf-8?B?Y2NNYS9DYU5DeFB0R09QMlZsM1RDK2lXN3dHQjJjTUZJNTJMdTZIdVFDMmN1?=
 =?utf-8?B?WS9BQWFYVDBGS0N6Zi9uWW5RZ1VVYWFnbGJ5OG9wb0IxRXlPTStrYTMzdE4r?=
 =?utf-8?B?bjU4MzFvdWkxYTFlcjdMRi9JN1hSTE9xYzYrcGt1NmU0TUtUNGtVZ2h0Nnl2?=
 =?utf-8?B?VlZxNXFxSWVjMDBTRTBvU093YWs4dFhSaTRFQmcrbmRQUlBCaW52VEh5c0dF?=
 =?utf-8?B?OE5iR2wxc3RQZWt3RnVuL2RUcGFlTDlIZkJuM3A0a1d4NGhxZUVZNFVFUWRU?=
 =?utf-8?B?K0puaVRSYXFpSGtWMjhZOHZrSmF1SFo0RE5BWUtBa1R6b0pGTEkyVkJXR0Rq?=
 =?utf-8?B?aCs1WFNvY0FudzB4TDNwdUFTQjF2UW1PeDNjUVhmM01uMFYxTUdOR2U0RDEy?=
 =?utf-8?B?UzM2MENGdGIzZUo0TElUS3lFVWU5ejZkcXZjQWtMaHlZancxM0pORjRvRU5I?=
 =?utf-8?B?cERsUWVTVzRQTG1rN1ZtRlFMWG5jQWpvQXdlWmVqSUpzYVRneE9iV3pxU1FT?=
 =?utf-8?B?RFhBSEk3dmRUdkR1Rkpsa0RYMDRibUtGeFVQbnd4QjdWZHNUZjRsblpuOTVD?=
 =?utf-8?B?RWRBTys5V0dXOCt3ektPUjllTCtEV2pGeGFhNVhMSHNTM0o4OXI5REsrUGZ4?=
 =?utf-8?B?YUF3d09jdHFqMVlCZlJnZUQ1NWFtQlRWb0ZYMWtPdy9hUnExVGVxTmVmOGpn?=
 =?utf-8?B?ZUduTHdqTkk3V25nK3prNFpuanR1NU5TV3E2Zy9yMnJXQjNWQ2ZuRUVDRkgv?=
 =?utf-8?B?cUlsZlAyV1ZLdWFwYy9vSFRBcVR5Y0Rwek5lZS96RndEdjZzelptL2ExMlRW?=
 =?utf-8?B?NHU1NFpxMW1qZC83Nm5GTnFKL25ZVnZPUXpzOGhST3NublJ0clZLSzduWW9L?=
 =?utf-8?Q?wciKUfHq1RxEBvsujU65aRvBp?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bdce4ab-cc3e-4aa4-2770-08dbcb9c6964
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 03:28:05.1051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: svg0UbEhClESfwdxkDLg51Cm1+ei7YkdQ8/5kVt9Z/veblJt1WkZUg5jzJbACm9NbKYQQy7TB/xo0+lTYGw6IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8227
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 08:02:00AM -0700, Alexei Starovoitov wrote:
> On Thu, Oct 12, 2023 at 1:14 AM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> > On Wed, Oct 11, 2023 at 06:38:56AM -0700, Alexei Starovoitov wrote:
> > > On Wed, Oct 11, 2023 at 2:01 AM Hao Sun <sunhao.th@gmail.com> wrote:
> > > >
> > > > Currently, we don't check if the branch-taken of a jump is reserved code of
> > > > ld_imm64. Instead, such a issue is captured in check_ld_imm(). The verifier
> > > > gives the following log in such case:
> > > >
> > > > func#0 @0
> > > > 0: R1=ctx(off=0,imm=0) R10=fp0
> > > > 0: (18) r4 = 0xffff888103436000       ; R4_w=map_ptr(off=0,ks=4,vs=128,imm=0)
> > > > 2: (18) r1 = 0x1d                     ; R1_w=29
> > > > 4: (55) if r4 != 0x0 goto pc+4        ; R4_w=map_ptr(off=0,ks=4,vs=128,imm=0)
> > > > 5: (1c) w1 -= w1                      ; R1_w=0
> > > > 6: (18) r5 = 0x32                     ; R5_w=50
> > > > 8: (56) if w5 != 0xfffffff4 goto pc-2
> > > > mark_precise: frame0: last_idx 8 first_idx 0 subseq_idx -1
> > > > mark_precise: frame0: regs=r5 stack= before 6: (18) r5 = 0x32
> > > > 7: R5_w=50
> > > > 7: BUG_ld_00
> > > > invalid BPF_LD_IMM insn
> > > >
> > > > Here the verifier rejects the program because it thinks insn at 7 is an
> > > > invalid BPF_LD_IMM, but such a error log is not accurate since the issue
> > > > is jumping to reserved code not because the program contains invalid insn.
> > > > Therefore, make the verifier check the jump target during check_cfg(). For
> > > > the same program, the verifier reports the following log:
> > > >
> > > > func#0 @0
> > > > jump to reserved code from insn 8 to 7
> > > >
> > > > Signed-off-by: Hao Sun <sunhao.th@gmail.com>
> > > > ---
> > > >  kernel/bpf/verifier.c | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > >
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index eed7350e15f4..725ac0b464cf 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -14980,6 +14980,7 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env,
> > > >  {
> > > >         int *insn_stack = env->cfg.insn_stack;
> > > >         int *insn_state = env->cfg.insn_state;
> > > > +       struct bpf_insn *insns = env->prog->insnsi;
> > > >
> > > >         if (e == FALLTHROUGH && insn_state[t] >= (DISCOVERED | FALLTHROUGH))
> > > >                 return DONE_EXPLORING;
> > > > @@ -14993,6 +14994,12 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env,
> > > >                 return -EINVAL;
> > > >         }
> > > >
> > > > +       if (e == BRANCH && insns[w].code == 0) {
> > > > +               verbose_linfo(env, t, "%d", t);
> > > > +               verbose(env, "jump to reserved code from insn %d to %d\n", t, w);
> > > > +               return -EINVAL;
> > > > +       }
> > >
> > > I don't think we should be changing the verifier to make
> > > fuzzer logs more readable.
> >
> > Taking fuzzer out of consideration, giving users clearer explanation for
> > such verifier rejection could save a lot of head scratching.
> 
> Users won't see such errors unless they are actively doing what
> is not recommended.
> 
> > Compiler shouldn't generate such program, but its plausible to forget to
> > account that BPF_LD_IMM64 consists of two instructions when writing
> > assembly (especially with filter.h-like macros) and have it jump to the 2nd
> > part of BPF_LD_IMM64.
> 
> Using macros to write bpf asm code is highly discouraged.
> All kinds of errors are possible.
> Bogus jump is just one of such mistakes.
> Use naked functions and inline asm in C code that
> both GCC and clang understand then you won't see bad jumps.
> See selftets/bpf/verifier_*.c as an example.

Understood, thanks for the explanation!

Found them under progs/verifier_*.c inside the bpf selftest directory.

> > > Same with patch 2. The code is fine as-is.
> >
> > The only way BPF_SIZE(insn->code) != BPF_DW conditional in check_ld_imm()
> > can be met right now is when we have a jump to the 2nd part of LD_IMM64; but
> > what this conditional actually guard against is not straight-forward and
> > quite confusing[1].
> 
> There are plenty of cases in the verifier where we print
> an error message. Some of them should be impossible due
> to prior checks. In such cases we don't yell "verifier bug"
> and are not going to do that in this case either.

I agree, without patch 1 applied, the change to "verfier bug" in patch 2
doesn't make sense and is just wrong. The point I'm trying to make is that
the checks done by verifier are generally clear, you can make sense of why
certain check are in place just by looking at the code, but
BPF_SIZE(insn->code) != BPF_DW is _not_ one of them.

I got confused, (reading between the lines I believe) this had Hao puzzled,
and even Yongsong had to look twice[1] back then; so this check is certainly
not on-par with others we have in the verifier in terms of clarity, which
leads to patches here as well as mine a while back.

Perhaps we could reconsider making it more obvious how verifier prevents
jump to reserved code/2nd instruction of LD_IMM64?


1: the same https://lore.kernel.org/bpf/0cf50c32-ab67-ef23-7b84-ef1d4e007c33@fb.com/

