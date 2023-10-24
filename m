Return-Path: <bpf+bounces-13128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 021C77D4F4B
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 13:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A89EE2819C8
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 11:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5917A266D0;
	Tue, 24 Oct 2023 11:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PRxuIC2v"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90942266B0
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 11:57:41 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2088.outbound.protection.outlook.com [40.107.7.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CD610C0;
	Tue, 24 Oct 2023 04:57:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZ74aMWu4kL+Z71kGDlCEhCqI0moJOUSB2hbsRpOlqSthTprwzk3iKAHfM+ISkMx11w1xKr1DF29lhYK3FW4NW2Dd0N/6t8r3hciHVMlwpsOXNgHLmeB2Z3VEckbotxqsjdcA9iirSr7fo/4LYaGNR7JUUoZo5jVH6kOi5YwMKMOuxbY7o1qhSKl2k3nWk3G5MWso9G0YE2YfUa+Ji2X1rqhe5ikt0a19oKcmFBqBTF3wBFNsGI0LZu4PEclAj+hRJiRsam3LMFLHBklJ/O2ok61UQ0q2ppMYqcHyCSQ/hrqFlrST0CK+dhh52RmrQY1oH09kA2CyxHtwFg/rxVlIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xOxYzcTO7ewWbvNKH7KA/zJG/77X7vbTs4fJKUC4YZw=;
 b=MWw2aDGNj7//Csl8LA04/z0ModY42NClsSg9abHgw1fhuydFa9iQmPU4KusmFwNpmqAqS02vAB8MaMFi9PfrO5+aiCztrO2xlMz/ZrofB6cOvAFPDeZQzXrriNP8gdR6ImZfOc0ozyrE0ifqJxTRCoCcWplY0IGJ+tq6jtw+KSJMVQbCbtBH84x36LV8PhL7t0aO4vV8/tpX8/z5Ug+YDXHfqJumDwjIX9SlXa0zYRBBoYbZpci/YyDVG4PRkTCi0gxZGqU4Y/UzT+FsmEVXFdM6PY2DtGTA7TnGfTmP+VVhL0s9kWYwQMoNlET2FhZg6U80EAhhiAOfxBttOUOJzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOxYzcTO7ewWbvNKH7KA/zJG/77X7vbTs4fJKUC4YZw=;
 b=PRxuIC2vJ0cZEe8eq+83+Ze18f45UUDFdRFmIYZa2Scgua2Up9RrF9DN6RM0rofVEnnz/8S8A2oQzgciUdX8X5jPU4a77aBKJHr/f8OWOfOP0zpZmlJATUTSw7DhxpOC1AcEZaCtyrv1AQt2sSVzXU6SiC/6Jj80aKDMQzQfYlYESV/nOxSmyOTmjkzU5rhquzglLz/1g1fFETPqmhJaBdPVUXZlTySzGtA6zLuAKqcicKBeCNuHxw2sykkwFYOV2Tm7ULxDP7nr5ssVGPsyojSKiIyr8XepMJFNsrcbvw8lygSXHTE4fwc7W7KapIgvSyxDea6RbwBXSWPG52l7Eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by PAXPR04MB8575.eurprd04.prod.outlook.com (2603:10a6:102:216::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Tue, 24 Oct
 2023 11:57:36 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c%6]) with mapi id 15.20.6933.011; Tue, 24 Oct 2023
 11:57:36 +0000
Date: Tue, 24 Oct 2023 19:57:28 +0800
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
Message-ID: <ZTexKOcNxpRd4oc5@u94a>
References: <20231011-jmp-into-reserved-fields-v3-0-97d2aa979788@gmail.com>
 <20231011-jmp-into-reserved-fields-v3-1-97d2aa979788@gmail.com>
 <CAADnVQJnhfbALtNkCauS_ZwRfybcb_mryEvZW7Uu1uOSshQ9Ew@mail.gmail.com>
 <ZSeq7ieG7Cq13w67@u94a>
 <CAADnVQJHAPid9HouwMEnfwDDKuy8BnGia269KSbby2gA030OBg@mail.gmail.com>
 <ZSi5PHDfoAYcvbCq@u94a>
 <CAADnVQLiWk5_Wf3q6iDAyLb-n0W5je3Z8XT2J-mtZ5s9RA-JjQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLiWk5_Wf3q6iDAyLb-n0W5je3Z8XT2J-mtZ5s9RA-JjQ@mail.gmail.com>
X-ClientProxiedBy: FR4P281CA0384.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::18) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|PAXPR04MB8575:EE_
X-MS-Office365-Filtering-Correlation-Id: b1c449eb-e79b-403f-7770-08dbd48869c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	v+SOAnh4/yLB+e7lLdzf4mGqeSBDXq1p9IYtmhxXT78TOIwN7tM6dY5DqEm2weFWMLCgKfJyNBi4o7wTQfPd2FgIkCmmnPx/o28JWKoHuPBJZWvbOrhVzM/V5yc/G4O8qIReAQ8A3AK2GRC6AMlvElcmpUJlD8Ld0OgEaTD8B9c+G6/0u66e+THzsmB8z14slXDNsRUcHiiZ+5qcVkFsE4vXJf0s86rkokZxxf5ULBTc/eIBem6E4wO+JQmZOieNI4W3+5DaPvIi49CNgFppJTHoegUZlGjPgjMXr2yvHB/9/hsfn4qZxweC+169326eOvA7ou4yPtCiWe34kkwYJQLcP9e22VPO6DctUpHZAtkOjrjewz1De5TkecIB4yiavc81OqwMeDveRDVns6vDo3810wAxfmWgWfzs8mU56YUOcqRf4S21WHlugcWW0t9PYl1ikZ3Ia0nnxvhlMlF3NebYmzSYTy5kHuMWVMgVoNJCy9bElqeEl7ynwNKStPhW6rWMSYkw6Tb5AYqjB7f1qcAN8tlVHOKncbuHKnFac5VHf0pYzOti+GM/hR6LTVEb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(6916009)(66556008)(66476007)(66946007)(54906003)(316002)(86362001)(38100700002)(83380400001)(8676002)(53546011)(9686003)(6512007)(26005)(6506007)(6666004)(6486002)(478600001)(8936002)(2906002)(33716001)(7416002)(5660300002)(41300700001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEg2c0JVQ0FDbVZUMXVKZWdSMlhOVnZHK0duTk1HZUlIanVjaDV3SDljenRC?=
 =?utf-8?B?L3lqVUJwMHY4Uml2S24yVThRV01EekFPSThsS05WRzlWdmNCUmdEZjJGZzJ2?=
 =?utf-8?B?SkRFUkRveHlsQkh4TjcrR21HMnZaNjNhLzd2aE12b2dVMjkyMHNieXR4Mm9J?=
 =?utf-8?B?ZFp4RWEwazQvVE1WUEJYd25ZcEk0TStycC96aXM2cVYzUkx2WHN2VkR0Qzc0?=
 =?utf-8?B?Q2Fsd3NMUU5UQ1kyZGNZZk1BYy93UHF1S3JEZy8rZWxsQ1RRb254N0MydFU0?=
 =?utf-8?B?VW9YaHp6eitqbzRlcEcxSHZBY3ZVemF2dDl2U0R4UTVDdFFmNk80YThPemM0?=
 =?utf-8?B?c0VualkwWkpJM3gvekw5UDZ2aVpSUXdINnNpS0NYaThuY1dLaEJKLzdreEpF?=
 =?utf-8?B?YitDczl5bUVwbWxvMThDVGlscjcwNFZNVVAvdFNlLzU5bm9rUFBXTnVmMlV6?=
 =?utf-8?B?NDRmeTBFWUZJcDIxMXdYRFFFQW9ySm5Oc1NpeC8vYVpVckJkQkpTaGxQU1Zj?=
 =?utf-8?B?cEJxUXYyZVlwTHMzRkgvVmYvaXh4L3oxcHdrMW5XWU1DUnBYNEJMaHJGQmVp?=
 =?utf-8?B?bm0vWEFLSnRaSVoxS0pvVkZxeGQ4RXh1ajZTREh3ajNZdlhOR01RMmlvOU4r?=
 =?utf-8?B?d29DbmdnTVFxeFB6YkpvdDZJalNrTzhkcThIdStzdSttay9lNGUyQUdBQk9r?=
 =?utf-8?B?Y1JRTDFTdk83ejBMMmR0UmlOang4d2dSUitlVTJlZ0w0ZlJzbWpHNXJlOFJs?=
 =?utf-8?B?ODVGY216TWluL3B1cytaenZHbFh1c1JqQkRlak15dUdHRlVXUk5EMHhTcE5R?=
 =?utf-8?B?OVBJejk0OVVlS0Z0SjFJbVBsZHp5SjQ1Z0hvRmtKWmUyRkJuT2tpOUZBazFD?=
 =?utf-8?B?clBsM1pLSE9yZ2UxMHM2cWpaWUVJc1ZBSDhtbGlIQm1keHdrNVBMMzFNTEVu?=
 =?utf-8?B?bStGc1QyZURtMFlGK256blNpY2JhYzl1cElJWVF2aHo4cmhFb1hrM0c5SUht?=
 =?utf-8?B?YUdoaXVoVDNWdENpaUhlbjFkaTVVQVhjSVdNWDFMOWtBVVJIUU43c2tJMWpN?=
 =?utf-8?B?TGhzV0p0cHVXTWZBZjNGVUkwZjR2eGFmSmhEQ0Q4SzZHVnMyRmpXZk5TM2ZZ?=
 =?utf-8?B?WnVMYjhFSlVka2dLT1JGU215dUZOQ3ltemhjOUhOS2hEbXFNMTdQUWExaVFZ?=
 =?utf-8?B?YmdrbGlZWnZSMFRvbjkxMUU1NUxBRXBhWXYvNVBpTGlrblFpQVhHckRYTloy?=
 =?utf-8?B?ZjF1bU5sQ1NsWHo1b2ZJODFtcWRkSmFVazJNOGRIWE5VZ2lHcnJ0Mks5Z2Z6?=
 =?utf-8?B?UU8yVmpsYllrcTdGVFoxZFZGODJhRVlNRFB4d0t6ZzdSZXM0MDhlVk4yb2Vr?=
 =?utf-8?B?aU1GSVFKeldoL0k2WDdFa1RZMEs3YVpHMmVLRmgvSitsbDRNTzVTdGxnV1FG?=
 =?utf-8?B?MjlBZXdVRHRLWUpNeUhHd3dMMFdZRUpIcURxbHc1ZTUvM0krMkRiVERsSzNm?=
 =?utf-8?B?eVdndkQzRHZKbmV5YThOWEVKMGJ2Z0hadU1rN2c2L25zRDlwd0pkdG9FKzRG?=
 =?utf-8?B?WlJrdnNjN2JLZGVaMDBRTFloZGovYW9rc0VjdnZFNGtsRkxKbDRmSTZ3VjM3?=
 =?utf-8?B?VFBYaUtIWUJXcFlna3BqNm1wNjM2L0lmbUl6TUFBai9pN2cyWTUrdDVvWTF4?=
 =?utf-8?B?YnJuQ0w1cGJqbGZRSnhySUl2R0xKdnFvNUt1VTVkV3dhZWQvSU5SQml3Z2dH?=
 =?utf-8?B?MVFGTXlTdEZrekFScHJmU3NPbklDNkFBWk44RzRpZk9qN2hlb0lzaEVLMld2?=
 =?utf-8?B?ZVhVbnlrN2kwWkhyQUpKdWtqVmFOQjVyLzgvY0NBeDRPSDJmVHo0OE9EM21K?=
 =?utf-8?B?NFBXcFA2K2JtOWx6OVhzckdFTnJjbXZIMVlyTVNZa2hhOGpMZlZwTVJkMWNC?=
 =?utf-8?B?T0l0ZDVlN1F0eE8wV1VqUFhmbWFnZUNlYksrbGkrenVWZ2JHb0w1WkFCYnNt?=
 =?utf-8?B?SURoSE5QRERMQ1pESzdsK2c2aGxVMlUvYkpNWGFFbTJnQ2tuRmhENUZPRmN1?=
 =?utf-8?B?NUpWZEVjeXp0ZXhRUEJ6d3hKcDltUSt4bElwSmZtNG5hcUJoZ3pUVmI2ZW9Q?=
 =?utf-8?Q?1IiakKctr4/kK+oW0c2SdkuUj?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c449eb-e79b-403f-7770-08dbd48869c8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 11:57:36.0122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KB8hLL1vUUy9r0A/VhL1+PlKIt0yWoMAgzHiWGPCDUnK4bmQ5usli6X1es/vo8byKkLWFb1CWuqOdmZiahHBeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8575

On Thu, Oct 19, 2023 at 05:25:26PM -0700, Alexei Starovoitov wrote:
> On Thu, Oct 12, 2023 at 8:28 PM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> > On Thu, Oct 12, 2023 at 08:02:00AM -0700, Alexei Starovoitov wrote:
> > > On Thu, Oct 12, 2023 at 1:14 AM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> > > > On Wed, Oct 11, 2023 at 06:38:56AM -0700, Alexei Starovoitov wrote:
> > > > > On Wed, Oct 11, 2023 at 2:01 AM Hao Sun <sunhao.th@gmail.com> wrote:
> > > > > >
> > > > > > Currently, we don't check if the branch-taken of a jump is reserved code of
> > > > > > ld_imm64. Instead, such a issue is captured in check_ld_imm(). The verifier
> > > > > > gives the following log in such case:
> > > > > >
> > > > > > func#0 @0
> > > > > > 0: R1=ctx(off=0,imm=0) R10=fp0
> > > > > > 0: (18) r4 = 0xffff888103436000       ; R4_w=map_ptr(off=0,ks=4,vs=128,imm=0)
> > > > > > 2: (18) r1 = 0x1d                     ; R1_w=29
> > > > > > 4: (55) if r4 != 0x0 goto pc+4        ; R4_w=map_ptr(off=0,ks=4,vs=128,imm=0)
> > > > > > 5: (1c) w1 -= w1                      ; R1_w=0
> > > > > > 6: (18) r5 = 0x32                     ; R5_w=50
> > > > > > 8: (56) if w5 != 0xfffffff4 goto pc-2
> > > > > > mark_precise: frame0: last_idx 8 first_idx 0 subseq_idx -1
> > > > > > mark_precise: frame0: regs=r5 stack= before 6: (18) r5 = 0x32
> > > > > > 7: R5_w=50
> > > > > > 7: BUG_ld_00
> > > > > > invalid BPF_LD_IMM insn
> > > > > >
> > > > > > Here the verifier rejects the program because it thinks insn at 7 is an
> > > > > > invalid BPF_LD_IMM, but such a error log is not accurate since the issue
> > > > > > is jumping to reserved code not because the program contains invalid insn.
> > > > > > Therefore, make the verifier check the jump target during check_cfg(). For
> > > > > > the same program, the verifier reports the following log:
> > > > > >
> > > > > > func#0 @0
> > > > > > jump to reserved code from insn 8 to 7
> > > > > >
> > > > > > Signed-off-by: Hao Sun <sunhao.th@gmail.com>
> > > > > > ---
> > > > > >  kernel/bpf/verifier.c | 7 +++++++
> > > > > >  1 file changed, 7 insertions(+)
> > > > > >
> > > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > > > index eed7350e15f4..725ac0b464cf 100644
> > > > > > --- a/kernel/bpf/verifier.c
> > > > > > +++ b/kernel/bpf/verifier.c
> > > > > > @@ -14980,6 +14980,7 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env,
> > > > > >  {
> > > > > >         int *insn_stack = env->cfg.insn_stack;
> > > > > >         int *insn_state = env->cfg.insn_state;
> > > > > > +       struct bpf_insn *insns = env->prog->insnsi;
> > > > > >
> > > > > >         if (e == FALLTHROUGH && insn_state[t] >= (DISCOVERED | FALLTHROUGH))
> > > > > >                 return DONE_EXPLORING;
> > > > > > @@ -14993,6 +14994,12 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env,
> > > > > >                 return -EINVAL;
> > > > > >         }
> > > > > >
> > > > > > +       if (e == BRANCH && insns[w].code == 0) {
> > > > > > +               verbose_linfo(env, t, "%d", t);
> > > > > > +               verbose(env, "jump to reserved code from insn %d to %d\n", t, w);
> > > > > > +               return -EINVAL;
> > > > > > +       }
> > > > >
> > > > > I don't think we should be changing the verifier to make
> > > > > fuzzer logs more readable.
> > > >
> > > > Taking fuzzer out of consideration, giving users clearer explanation for
> > > > such verifier rejection could save a lot of head scratching.
> > >
> > > Users won't see such errors unless they are actively doing what
> > > is not recommended.
> > >
> > > > Compiler shouldn't generate such program, but its plausible to forget to
> > > > account that BPF_LD_IMM64 consists of two instructions when writing
> > > > assembly (especially with filter.h-like macros) and have it jump to the 2nd
> > > > part of BPF_LD_IMM64.
> > >
> > > Using macros to write bpf asm code is highly discouraged.
> > > All kinds of errors are possible.
> > > Bogus jump is just one of such mistakes.
> > > Use naked functions and inline asm in C code that
> > > both GCC and clang understand then you won't see bad jumps.
> > > See selftets/bpf/verifier_*.c as an example.
> >
> > Understood, thanks for the explanation!
> >
> > Found them under progs/verifier_*.c inside the bpf selftest directory.
> >
> > > > > Same with patch 2. The code is fine as-is.
> > > >
> > > > The only way BPF_SIZE(insn->code) != BPF_DW conditional in check_ld_imm()
> > > > can be met right now is when we have a jump to the 2nd part of LD_IMM64; but
> > > > what this conditional actually guard against is not straight-forward and
> > > > quite confusing[1].
> > >
> > > There are plenty of cases in the verifier where we print
> > > an error message. Some of them should be impossible due
> > > to prior checks. In such cases we don't yell "verifier bug"
> > > and are not going to do that in this case either.
> >
> > I agree, without patch 1 applied, the change to "verfier bug" in patch 2
> > doesn't make sense and is just wrong. The point I'm trying to make is that
> > the checks done by verifier are generally clear, you can make sense of why
> > certain check are in place just by looking at the code, but
> > BPF_SIZE(insn->code) != BPF_DW is _not_ one of them.
> >
> > I got confused, (reading between the lines I believe) this had Hao puzzled,
> > and even Yongsong had to look twice[1] back then; so this check is certainly
> > not on-par with others we have in the verifier in terms of clarity, which
> > leads to patches here as well as mine a while back.
> >
> > Perhaps we could reconsider making it more obvious how verifier prevents
> > jump to reserved code/2nd instruction of LD_IMM64?
> 
> I agree that the message is confusing.
> My point is that people see it only when they code in asm with macros.
> Anyone who was doing that a lot saw that message and probably debugged
> much worse issues while inserting an asm macro and forgetting to
> adjust constants in branches. The code might even load, but will
> execute something totally different.
> asm macros are a nightmare to debug. Adding more code to the verifier
> to help with one particular case is not going to help much.
> Use inline asm in C is the right answer for folks that still need asm.
> 
> UX of the verifier sucks and we need to improve. So please focus on impactful
> improvements instead of hacking on niche cases.

Ok, can't say I agree entirely, but it's a niche case alright, and I'll
leave this alone.

