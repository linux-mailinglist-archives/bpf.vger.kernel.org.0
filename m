Return-Path: <bpf+bounces-2033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8EF72701A
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 23:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7C1B2814E9
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 21:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3243AE68;
	Wed,  7 Jun 2023 21:04:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1058339255
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 21:04:08 +0000 (UTC)
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6B02709
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 14:04:04 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 449164247F
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 21:04:04 +0000 (UTC)
Received: from pdx1-sub0-mail-a233.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id D3398423FF
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 21:04:03 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1686171843; a=rsa-sha256;
	cv=none;
	b=NZ9cegQpWDZGwhzwAlZdgVxhMEePthYhGcs+xgbL41bOYucHb5PuMhhR3z/iz9BtPcr9e5
	Iak68Yma8m7DSwCQx5BpAYuXl7Px4kk758YmGNaQEoTTx/db0S2ziC/G3nQJVEQdTqlBS3
	3BxPVLfoxDkQx5NgT1Rc8pd8j3TBsJajEMCsfVKV9Iq4gOgvtXv5tF1bHaIoRXLOTY0Yj5
	fXWUaOBujoSpUiHxJ0LIJNCtx9LOSc2rOSskrn/J7Kndhah5IxXa8lXjR3KJvfxYdo/wos
	exqmQRouFHq8lRNrVZ6v7kuzYW1/pB5CudH3/w8MPt4PxrewHetnlKTRamrayA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1686171843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=VgEDVaD96PpiQVvSuuPolddYls8rHIqf3JryVYxh20Q=;
	b=n+Y6tEvJcehfkF8g02ESIPiF2PdFTM6xWdo17HhQ5XPhi0JIlHx2hAcPjnm/s4oG6M43a+
	U8f6F4O8Tq+NhTQEkR4WPCtgmQ+o2IIuUXt635j5it2USnfnHcR53/1acb9ybq/Wu145kY
	p9ipe+rdt4kzB/5d892SVAwXPxtsfFm8C2I7Bow7B5oMg0mEBT+FXJcfBSmO4KqjmtAW8o
	hQPDMvK1QlpafaKi0R43qdBWQSs3MYiIUycP10935BsDwStmKFxF0iRTb4OgYnskns16nX
	OpCAz6hXDCWAuLg7XmSp0SA1V1HR3aksa8l9xgDge/y5Yxu/WHmf+a3VXZAslA==
ARC-Authentication-Results: i=1;
	rspamd-fcb9f4dcf-5vdb6;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Cooing-Ski: 4aba74001978f85d_1686171844078_1763090032
X-MC-Loop-Signature: 1686171844078:3893922940
X-MC-Ingress-Time: 1686171844078
Received: from pdx1-sub0-mail-a233.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.115.252.249 (trex/6.8.1);
	Wed, 07 Jun 2023 21:04:04 +0000
Received: from kmjvbox (c-73-93-64-36.hsd1.ca.comcast.net [73.93.64.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a233.dreamhost.com (Postfix) with ESMTPSA id 4Qc0FZ4F8Yz10h
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 14:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1686171842;
	bh=VgEDVaD96PpiQVvSuuPolddYls8rHIqf3JryVYxh20Q=;
	h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
	b=hu3WDKEe0rcjosyx/zlIvFagh5mtaQx+6schtl4mekrXSgPd7bOSiVY8mAh8QOBBf
	 Nm0foHzaCpmM55Q/5IlJM8lEc8qkSkfHHxXjZTGvtIgVd5W3ui+YnPY2vYxXKyE+is
	 I0qPQf7eBPKlSSw/xU32dSqIGhvdqG0CptDTp8TA=
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e005f
	by kmjvbox (DragonFly Mail Agent v0.12);
	Wed, 07 Jun 2023 14:04:01 -0700
Date: Wed, 7 Jun 2023 14:04:01 -0700
From: Krister Johansen <kjlx@templeofstupid.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	clang-built-linux <llvm@lists.linux.dev>,
	stable <stable@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: search_bpf_extables should search subprogram
 extables
Message-ID: <20230607210401.GB2023@templeofstupid.com>
References: <20230605164955.GA1977@templeofstupid.com>
 <CAADnVQK7PQxj5jjfUu9sO524yLMPqE6vmzcipno1WYoeu0q-Gw@mail.gmail.com>
 <20230606004139.GE1977@templeofstupid.com>
 <CAADnVQLhqCVRcPuJ8JEZfd5ii+-TsSs4+AsJC0sbjwPMv7LX_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLhqCVRcPuJ8JEZfd5ii+-TsSs4+AsJC0sbjwPMv7LX_Q@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 05, 2023 at 06:31:57PM -0700, Alexei Starovoitov wrote:
> On Mon, Jun 5, 2023 at 5:46 PM Krister Johansen <kjlx@templeofstupid.com> wrote:
> > With your comments in mind, I took
> > another look at the ksym fields in the aux structs.  I have this in the
> > main program:
> >
> >   ksym = {
> >     start = 18446744072638420852,
> >     end = 18446744072638423040,
> >     name = <...>
> >     lnode = {
> >       next = 0xffff88d9c1065168,
> >       prev = 0xffff88da91609168
> >     },
> >     tnode = {
> >       node = {{
> >           __rb_parent_color = 18446613068361611640,
> >           rb_right = 0xffff88da91609178,
> >           rb_left = 0xffff88d9f0c5a578
> >         }, {
> >           __rb_parent_color = 18446613068361611664,
> >           rb_right = 0xffff88da91609190,
> >           rb_left = 0xffff88d9f0c5a590
> >         }}
> >     },
> >     prog = true
> >   },
> >
> > and this in the func[0] subprogram:
> >
> >   ksym = {
> >     start = 18446744072638420852,
> >     end = 18446744072638423040,
> >     name = <...>
> >     lnode = {
> >       next = 0xffff88da91609168,
> >       prev = 0xffffffff981f8990 <bpf_kallsyms>
> >     },
> >     tnode = {
> >       node = {{
> >           __rb_parent_color = 18446613068361606520,
> >           rb_right = 0x0,
> >           rb_left = 0x0
> >         }, {
> >           __rb_parent_color = 18446613068361606544,
> >           rb_right = 0x0,
> >           rb_left = 0x0
> >         }}
> >     },
> >     prog = true
> >   },
> >
> > That sure looks like func[0] is a leaf in the rbtree and the main
> > program is an intermediate node with leaves.  If that's the case, then
> > bpf_prog_ksym_find may have found the main program instead of the
> > subprogram.  In that case, do you think it's better to skip the main
> > program's call to bpf_prog_ksym_set_addr() if it has subprograms instead
> > of searching for subprograms if the main program is found?
> 
> I see.
> Looks like we're doing double bpf_prog_kallsyms_add().
> First in in jit_subprogs():
>         for (i = 0; i < env->subprog_cnt; i++) {
>                 bpf_prog_lock_ro(func[i]);
>                 bpf_prog_kallsyms_add(func[i]);
>         }
> and then again:
> bpf_prog_kallsyms_add(prog);
> in bpf_prog_load().
> 
> because func[0] is the main prog.
> 
> We are also doing double bpf_prog_lock_ro() for main prog,
> but that's not causing harm.
> 
> The fix is probably just this:
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1e38584d497c..89266dac9c12 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17633,7 +17633,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>         /* finally lock prog and jit images for all functions and
>          * populate kallsysm
>          */
> -       for (i = 0; i < env->subprog_cnt; i++) {
> +       for (i = 1; i < env->subprog_cnt; i++) {
>                 bpf_prog_lock_ro(func[i]);
>                 bpf_prog_kallsyms_add(func[i]);
>         }

This will cause the oops to always occur, because func[0] has a extable
entry when jit_subporgs() completes, but prog->aux doesn't.
jit_subprogs also sets prog->bpf_func which prevents the other copy of
the main program from getting jit'd, and consequently getting an extable
assigned.

There are probably a few options to fix:

1. skip the bpf_prog_kallsyms_add in bpf_prog_load if the program being
loaded has subprograms

2. check extables when searching to see if they're NULL and if the
subprogram has one instead

3. copy the main program's extable back to prog->aux

I'll send out a v2 here shortly that includes the selftest you
requested.  It takes approach #3, which is also a 1-line change.

-K


