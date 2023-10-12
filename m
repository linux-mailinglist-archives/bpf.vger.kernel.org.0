Return-Path: <bpf+bounces-12011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7707C676B
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 10:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32B441C2101C
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 08:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0839B1B287;
	Thu, 12 Oct 2023 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EuvUKDFB"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60590168AA
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 08:14:56 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168A4B7;
	Thu, 12 Oct 2023 01:14:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNSrzlN5DiHOWqJ1CW/mFnqZRX+X6lkMWOmmN1cNZnVabbRCqlsYza39/9I8tTnijaiXkvnjdsaa1nqGfHc8Dj4ovbMEycVSx2fA/9ovAqy09l/fz2g4l2RQntN1IkSwAhRtbNbIXcdQgVR4/ia9CieD4BP4x3w/Stfq0Y2bC2691tDwAMQmWyN82mwTyQJ8G7h9vijfZ8yG7kp4NL0elrESX1MuSKCTsL/jgbkM4BCEJKgn/fsuWDyZYj2GOA8jCuNmGvUJiJVG9qt64Ol0bNNAlQetOWqCnayFwP9bGNsFZeudtnP2oD6PYIno1+QjnePlm/mC3wPsSRMlu3Eqqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rTiW7bpv58jGuiyMyldySNLZ1KiLpFlYGzXbK2fCo8=;
 b=XVI85vj7LfUyjOMkcL1mlZ5aexiXC2DAqnqOzccFiG0LVzJkT9N+MNp7RAQLtw8+o4es1mObq2Acoa4yDsMUlD4rjhkWSU/obZBe1ZTcjdeatkhq/pKOYubUN9/RurJeXZqD+O/sSCSgWWi2yE3YMOm20hgVAHPeVALTL6LeMXJ56IMmvL5Vrz+nnVZDXjkH+aRUyh7a7R9FsBkbFOQ4e8Nxn+x50h7M0AggRiEgLpLOeewSrxMhjO0La50dlPUFTkqvYPhZ4oH3rheOyqxGprvhuWxgdILuZyIlQ1iOPs27HN5lA9DGXz6GoPxHYS2zqwkwZxpg/2ALUB+M6YTNOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rTiW7bpv58jGuiyMyldySNLZ1KiLpFlYGzXbK2fCo8=;
 b=EuvUKDFBHACN82TSU84e4gpDBZ05T1ScRav2oyIgm7xBF7GNXcbeHHOMQwFxyA1H6Y9Y2y0YOE2YQUipguR6Y4YRJwMjs4ltTAJR8BaDGn/7ygHU2EwFH4y1xT0VkQXuQGuiou5X70wssuCTb8uWCLWPb08R9G0Dtx/9y8qD+IntSsLjBv9p11Q7eAAjFIPohJ2myu5lS3G8zjnqCZhGmV29sYae9LPSOsOAshQfX7w/qgH6TV2gSUAlw+dnZ2ZuQyzA8JqZoJ9MvHySU6Nr5Yeg2f7JeJY7n8z2cBnCgaVZHHfewaWyJM63tpqNmhPxYxDATcU4zwhtYq8rePnD0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by AM9PR04MB8383.eurprd04.prod.outlook.com (2603:10a6:20b:3ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.42; Thu, 12 Oct
 2023 08:14:52 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::d87f:b654:d14c:c54a]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::d87f:b654:d14c:c54a%3]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 08:14:52 +0000
Date: Thu, 12 Oct 2023 16:14:38 +0800
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
Message-ID: <ZSeq7ieG7Cq13w67@u94a>
References: <20231011-jmp-into-reserved-fields-v3-0-97d2aa979788@gmail.com>
 <20231011-jmp-into-reserved-fields-v3-1-97d2aa979788@gmail.com>
 <CAADnVQJnhfbALtNkCauS_ZwRfybcb_mryEvZW7Uu1uOSshQ9Ew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJnhfbALtNkCauS_ZwRfybcb_mryEvZW7Uu1uOSshQ9Ew@mail.gmail.com>
X-ClientProxiedBy: FR4P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::8) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|AM9PR04MB8383:EE_
X-MS-Office365-Filtering-Correlation-Id: 61886939-aae4-463b-ac07-08dbcafb4fa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DKxtnfn4Wz3v63eqUA3mYV/zmpALsLWh+/3qClHE0xpsKmGepu0s7YPgH+T5lZhxKgD/Mk17C8FXDMj6SvFUeb8I57CK2/sGNjvmKzIQQbBQXORJmrT2+4ghuytzML4ik8r86Y442mDmlFnCc6DjasJjWv1zL2TsbG68rrjrt5jJ3lnz/LWnT4BnQ+0lSF23VNLpxztPpy0G3AfzHPn7ezc9xHfE1iGzMkTMLVNWBks05vdbPGL5cjg926Aa0sbaiVB9pcDo6FSKhvPWFi6qTCshmZzinp0l29Q922x9DGxG3BbBsP8gO+ZnFFG+X/HqpS+looUVkFJUiDkr7WCl6/EP8Hye0SuVkryqN9FHKnXPXJ6FW/E35Fp4tU5kg7/pp6Z3xmMB/qqJV9AsV+Xvtx+RIl461MhVNcuciLUixCTcLNjS1SXxKN/7mh+DSZcYKyAAjFOgPIOOMEjKwI13p5kY+7iosc11eNF+JbTcr0lUIlHAWjRPsCseRglpvr2rhS3KM9oftocFg99qKr3B2bdH81cIyS/aUk3C5FAgRb4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39860400002)(366004)(136003)(396003)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(7416002)(33716001)(2906002)(86362001)(38100700002)(53546011)(26005)(8676002)(4326008)(8936002)(6506007)(966005)(54906003)(6486002)(478600001)(9686003)(6512007)(66556008)(66946007)(66476007)(6916009)(41300700001)(316002)(83380400001)(6666004)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVVXNG1hYUhqL2duQmJWVUVzbENUL1pFa0o4dlNSWDdrM081ZzlKM3RhTXdx?=
 =?utf-8?B?U1ZuS0xkYTNUVGFHUytJcmdqaFZuRWJwUk5Jc05lRjg1MmdOSTRwWWM5OUVW?=
 =?utf-8?B?aWE5OXExT3FGYzYwcCtOWmhCekhwYkU4OTMwOUtkbkt6WGZXSVJQRzlha01r?=
 =?utf-8?B?a1RDMXVNbVBoVjFkdndFbTcyajRKMDNCM3YrMVppU2NwMk1PbHNHbWl0YjZN?=
 =?utf-8?B?NzVoSzRKQ1hWZFJXblpTTzE4ZmxNcjZBTlArWkpWcGZHWDQ5UDAxV2lyYW9R?=
 =?utf-8?B?Rkw3cmJqa2JsSDFqRTBGQVdxLy9hYUhIdFNZZko3cHE0SzJLWm1pM1pIbkRF?=
 =?utf-8?B?M1dsZnFaL0kwYjRvVGlLMlV1SmU3ZFFSVEZNa0pldG1GdERBS1BCOTZxQmk4?=
 =?utf-8?B?Qmd0dVRPbkhqTHNZUTc5TExTRlQzVDd2YzBCMSthL1lWSTRDdHBvUW8vVHpv?=
 =?utf-8?B?UGZjdytDU1NlRUFDY2Q0b3h0VS9zWFVtVWdva2xpSnl4Zkp2a2JSSjN4VG5h?=
 =?utf-8?B?bWJjRWpkckxwTTBvMS9COEgwV0JqWTQ3ZnVlT1lXdEFsYnIzek1HL1MyZ2R6?=
 =?utf-8?B?anpCUnpqZnFaNzlZS3dubCt1OGNhY2ZBMFhCVmZZTGNUeGZpMkZTazJLZktJ?=
 =?utf-8?B?NTk5WS9HdUxzNGtWQ0Z3RitNWTJ0cFFCM0FjYW5xY2dEQjZYZUlDa3lxOUY5?=
 =?utf-8?B?b0N1KzZIay84VnZrK1E5VHo1a3lPNC9GSDRESXdTZGNPb2xTTVhQUVViMktU?=
 =?utf-8?B?c3d5ZHNURjZXaDk0TktNUmJYSXlsTWE1OE1GemFtdmFZWFB0STZiWURnWS82?=
 =?utf-8?B?UUlacUg4M3FEeVBnUHQ3U2drb25mNDNWYmJjblNFL3l5S1dncTNEbm9zM2ZC?=
 =?utf-8?B?MU1YcmhHTUJEbWo5bFZiODhZSDBMS1F6K3pueWNRNWlKVVdobHZMUVB5Zk90?=
 =?utf-8?B?Qk9kay91TlpiNlpTYzVGcGtxT0hhZWNwNldtNXdiMDBvRkJhTjBCYzJJTEpO?=
 =?utf-8?B?YXBaTGNwWHFSSVBpZWNCS25neU1sbXdCVFB1c3BHNjd2NW53ZzBUeURKYmkx?=
 =?utf-8?B?RW1KUXBscmNaRTJHSDA2R0QwWEtMM0JnSnpwcXJ5RFBjUHZMVXg3UWpsZE9s?=
 =?utf-8?B?RERjeWwwbUFMa1lFUUIwTC9QSHFOTmIzRVQzbHhJUk1hU1JjRStnWVFsRnU1?=
 =?utf-8?B?bHo3M096K3k0VmNUNjJvdmdKdjdFbER4eCtzdFMyYnR0QUZaWVpQTGg5RFIr?=
 =?utf-8?B?V291N2pzNU1XS1NralFlakxSUnJDSU1UUmFpODhiLzJtdGlWVHFudk1hSm95?=
 =?utf-8?B?V0ZCaWtQTFArSUR1dHc0VzB4NWhDK0V1SXZIWjNHU0xIU2tya25jamk1MUk2?=
 =?utf-8?B?S2RIemt2RjFpZXk2YU91dzZDZWtUTzM5QTl2SjVVZThGM3gzdjlxRVRrWGxa?=
 =?utf-8?B?VnNRMFZvN3Z4ZXY4MkN3WXdGMFJDelA5UzQ4TWQxNWZzSWR2a1cvajdXU1ZU?=
 =?utf-8?B?eE1wbGxTK01MWXE5bENzZE40Z3VkWS9Cd1VZRlE1MExFa25KY3cwNThsUnkv?=
 =?utf-8?B?REFPSEtsTFV4N2JWZ29DUjNoSUVXUm9nRUtDNXl4MXRKWlo4TEZiYkM2K0tT?=
 =?utf-8?B?aWJZTE1yKzN3UXB6YTR2M3B5MkdTUCtXZFVPejJpZ2IyWWtWaDhLWFd5ZE1L?=
 =?utf-8?B?RVdyTXhLVERMelFoVHZXS1MyNjBSc3N4RjVHVFpqRWl2RHhrQ08xNkVsZm1m?=
 =?utf-8?B?NmdTeG9paEFCQUtrOVl5b3BCOWRndnV4UEJzL1hnQlA1Nk93OFBvK0FJVzA0?=
 =?utf-8?B?UE9mYVg0b0hteGFxRVg3TUp0bHhlKzNZU3RtYVg4RWp6NHYvUmNqWUpMWFpa?=
 =?utf-8?B?NWxkQklhZmIydEV1b1pTUkRRblg0UnRNRzZxWmttNzBkbU43ZVR4cmpLUXd6?=
 =?utf-8?B?U3JrcjM3cWJNdmdxdkRmckxWT3pqSzk0TjhJVDk0eXdrVk9tOTN5TFppUVNS?=
 =?utf-8?B?M3QzZGlkSlpnSEZMZnVUSTROcWZZN1R0WlROVnlHWXUzOU1mOVVSZTh5Qjc2?=
 =?utf-8?B?U00za0M1WDVKWUJrZHZDSmNHc3hTcnE0NDBSMnEvYk5Qa0UvL3lCUFMxdmYy?=
 =?utf-8?Q?PuO54Xc9uUKerqTcGa0ZOK8Az?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61886939-aae4-463b-ac07-08dbcafb4fa4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 08:14:52.6268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6W3IRv5sjLipZ27lsd8xGuEEjqAiAoo2S79CSezuzWD9w8TJxfPdZMO/K/7fVIA/rFzA/Lx7eUj6WT9U1grvvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8383
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 06:38:56AM -0700, Alexei Starovoitov wrote:
> On Wed, Oct 11, 2023 at 2:01 AM Hao Sun <sunhao.th@gmail.com> wrote:
> >
> > Currently, we don't check if the branch-taken of a jump is reserved code of
> > ld_imm64. Instead, such a issue is captured in check_ld_imm(). The verifier
> > gives the following log in such case:
> >
> > func#0 @0
> > 0: R1=ctx(off=0,imm=0) R10=fp0
> > 0: (18) r4 = 0xffff888103436000       ; R4_w=map_ptr(off=0,ks=4,vs=128,imm=0)
> > 2: (18) r1 = 0x1d                     ; R1_w=29
> > 4: (55) if r4 != 0x0 goto pc+4        ; R4_w=map_ptr(off=0,ks=4,vs=128,imm=0)
> > 5: (1c) w1 -= w1                      ; R1_w=0
> > 6: (18) r5 = 0x32                     ; R5_w=50
> > 8: (56) if w5 != 0xfffffff4 goto pc-2
> > mark_precise: frame0: last_idx 8 first_idx 0 subseq_idx -1
> > mark_precise: frame0: regs=r5 stack= before 6: (18) r5 = 0x32
> > 7: R5_w=50
> > 7: BUG_ld_00
> > invalid BPF_LD_IMM insn
> >
> > Here the verifier rejects the program because it thinks insn at 7 is an
> > invalid BPF_LD_IMM, but such a error log is not accurate since the issue
> > is jumping to reserved code not because the program contains invalid insn.
> > Therefore, make the verifier check the jump target during check_cfg(). For
> > the same program, the verifier reports the following log:
> >
> > func#0 @0
> > jump to reserved code from insn 8 to 7
> >
> > Signed-off-by: Hao Sun <sunhao.th@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index eed7350e15f4..725ac0b464cf 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -14980,6 +14980,7 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env,
> >  {
> >         int *insn_stack = env->cfg.insn_stack;
> >         int *insn_state = env->cfg.insn_state;
> > +       struct bpf_insn *insns = env->prog->insnsi;
> >
> >         if (e == FALLTHROUGH && insn_state[t] >= (DISCOVERED | FALLTHROUGH))
> >                 return DONE_EXPLORING;
> > @@ -14993,6 +14994,12 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env,
> >                 return -EINVAL;
> >         }
> >
> > +       if (e == BRANCH && insns[w].code == 0) {
> > +               verbose_linfo(env, t, "%d", t);
> > +               verbose(env, "jump to reserved code from insn %d to %d\n", t, w);
> > +               return -EINVAL;
> > +       }
> 
> I don't think we should be changing the verifier to make
> fuzzer logs more readable.

Taking fuzzer out of consideration, giving users clearer explanation for
such verifier rejection could save a lot of head scratching.

Compiler shouldn't generate such program, but its plausible to forget to
account that BPF_LD_IMM64 consists of two instructions when writing
assembly (especially with filter.h-like macros) and have it jump to the 2nd
part of BPF_LD_IMM64.

> Same with patch 2. The code is fine as-is.

The only way BPF_SIZE(insn->code) != BPF_DW conditional in check_ld_imm()
can be met right now is when we have a jump to the 2nd part of LD_IMM64; but
what this conditional actually guard against is not straight-forward and
quite confusing[1].


Shung-Hsi

1: https://lore.kernel.org/bpf/0cf50c32-ab67-ef23-7b84-ef1d4e007c33@fb.com/

