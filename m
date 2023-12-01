Return-Path: <bpf+bounces-16357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D31280069C
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 10:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86CA0B2118C
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 09:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6351CAB1;
	Fri,  1 Dec 2023 09:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zt5QYCLD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24AC1728
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 01:10:24 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54c4433e98bso982425a12.3
        for <bpf@vger.kernel.org>; Fri, 01 Dec 2023 01:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701421823; x=1702026623; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CVcOt623OVDpn2HnhSfZ6lST8HFzK1ptQ5GuXvnKug4=;
        b=Zt5QYCLDN8CW/v0IDs5kbujiJJPJWD5NS5vqwyxru5DVjbtiyarbctnmWDpvwKNt86
         FdyQ5xYcWCtL6lcTQvPmZfaIKSBEV3K4e6v1uwBHnWJr8pQzgb5OgsagCSk4THWf+OlF
         bofqWJlelgh/ejgh3TqebSEpubwAXWkgH+HLm1HAs2tomRf3FopI8h7CExexlPdB60tn
         qmXVkuSv01OEfFbRoglWa718DX9S1QcPYQT0GawrXM4V/WkOvk0AwoRkk5OdDdsp67f+
         VGGNnHUoqTjlYYYYivTtofnki0NrDjkboFnHxiJGLjpZ8ZV9S2v71yp1K+4BAEjtq5zJ
         7KKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701421823; x=1702026623;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CVcOt623OVDpn2HnhSfZ6lST8HFzK1ptQ5GuXvnKug4=;
        b=gcQMWRDhyDY2KhIzmNkwZ0Nx5XTVPuusWNB+/I7t4V7lPBNSg6jdJsdt+iTRbNrC6f
         dbfMR9eiR2U3W+hEyH3NETCOxwcuGqc+jSlE9Vl+i6+yaFIbBYffUVYZJZl5NbPRV4tS
         wR26TSyl6BXLCl/cqp0NBRbTfniFE3xs11xCxS22Nn7ncZwINJLaF3NPQbxw9RRLBizY
         tcb8qNdvJ4iURSJKJQx08K7/c+Wyt6Akn0X+Y1mVZ2T4TLHYqDtwd1ZI1vfoKexV7Ww6
         1fklnaM2tjmX9rtNFvwf1D8DouREqzrv3GqytmE1YOfUwxCKaX7jh49DKzpWc3XqyjZS
         Vo6g==
X-Gm-Message-State: AOJu0Ywy9vgD8Ul+UyHgbBX1EXFun64dcfcA0Q1rHx+0yyXkpbVBmFVm
	RLPLoA7pWkilL280wunZTqg=
X-Google-Smtp-Source: AGHT+IFYLRSEyZORSpzbWghEusUM49zJITV7erSMv02anexIoZLFDqsYhtwouYmhlYw7amoHLedtuA==
X-Received: by 2002:a17:907:76fc:b0:a19:a1ba:bad9 with SMTP id kg28-20020a17090776fc00b00a19a1babad9mr347770ejc.127.1701421822591;
        Fri, 01 Dec 2023 01:10:22 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id q14-20020a1709064c8e00b009fc42f37970sm1671143eju.171.2023.12.01.01.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 01:10:20 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 1 Dec 2023 10:10:18 +0100
To: Stanislav Fomichev <sdf@google.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>, Hao Luo <haoluo@google.com>,
	Xu Kuohai <xukuohai@huawei.com>, Will Deacon <will@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>, Lee Jones <lee@kernel.org>
Subject: Re: [PATCHv2 bpf 1/2] bpf: Add checkip argument to bpf_arch_text_poke
Message-ID: <ZWmi-mMYqH_0n4av@krava>
References: <20231128092850.1545199-1-jolsa@kernel.org>
 <20231128092850.1545199-2-jolsa@kernel.org>
 <ZWZafkt97qhgHynh@google.com>
 <ZWdFIUSXcZnCWax-@krava>
 <ZWdQywF4QnrnTc5P@krava>
 <CAKH8qBuz4XGfg+w7oitF9p_kW-+ycgwEoUTF8vw36u1-A_qnLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKH8qBuz4XGfg+w7oitF9p_kW-+ycgwEoUTF8vw36u1-A_qnLg@mail.gmail.com>

On Wed, Nov 29, 2023 at 10:10:22AM -0800, Stanislav Fomichev wrote:
> On Wed, Nov 29, 2023 at 6:55 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Wed, Nov 29, 2023 at 03:05:21PM +0100, Jiri Olsa wrote:
> > > On Tue, Nov 28, 2023 at 01:24:14PM -0800, Stanislav Fomichev wrote:
> > > > On 11/28, Jiri Olsa wrote:
> > > > > We need to be able to skip ip address check for caller in following
> > > > > changes. Adding checkip argument to allow that.
> > > > >
> > > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > > ---
> > > > >  arch/arm64/net/bpf_jit_comp.c   |  3 ++-
> > > > >  arch/riscv/net/bpf_jit_comp64.c |  5 +++--
> > > > >  arch/s390/net/bpf_jit_comp.c    |  3 ++-
> > > > >  arch/x86/net/bpf_jit_comp.c     | 24 +++++++++++++-----------
> > > > >  include/linux/bpf.h             |  2 +-
> > > > >  kernel/bpf/arraymap.c           |  8 ++++----
> > > > >  kernel/bpf/core.c               |  2 +-
> > > > >  kernel/bpf/trampoline.c         | 12 ++++++------
> > > > >  8 files changed, 32 insertions(+), 27 deletions(-)
> > > > >
> > > > > diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> > > > > index 7d4af64e3982..b52549d18730 100644
> > > > > --- a/arch/arm64/net/bpf_jit_comp.c
> > > > > +++ b/arch/arm64/net/bpf_jit_comp.c
> > > > > @@ -2167,7 +2167,8 @@ static int gen_branch_or_nop(enum aarch64_insn_branch_type type, void *ip,
> > > > >   * locations during the patching process, making the patching process easier.
> > > > >   */
> > > > >  int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
> > > > > -                void *old_addr, void *new_addr)
> > > > > +                void *old_addr, void *new_addr,
> > > >
> > > > [..]
> > > >
> > > > > +                bool checkip __maybe_unused)
> > > >
> > > > Any idea why only riscv and x86 do this check?
> > >
> > > so arm does the check as well, but needs the data from the lookup
> > > to patch things properly.. but IIUC it does not suffer the same
> > > issue because it does not implement direct tail calls [1] which
> > > is used only on x86
> > >
> > > >
> > > > Asking because maybe it makes sense to move this check into some
> > > > new generic bpf_text_poke and call it in the places where you currently
> > > > call checkip=true (and keep using bpf_arch_text_poke for checkip=false
> > > > case).
> > > >
> > > > (don't see any issues with the current approach btw, just interested..)
> > >
> > > I tried to add new function for that, but it did not look good for arm
> > > because it needs to do the lookup anyway
> > >
> > > hm maybe we could use new arch function that would cover the single
> > > tail call 'text poke' update in prog_array_map_poke_run and would be
> > > implemented only on x86 ... using __bpf_arch_text_poke directly
> >
> > looks like below change would be enough, I'll test and send new version
> 
> sg. I'm still not 100% sure why it's x86 only, I was (probably
> wrongly?) assuming that at least arm64 jit is mostly on par with x86
> :-)

AFAICS the direct tail calls are on x86, CI also seems to be ok with
that change.. I'll send it as formal patch

jirka

