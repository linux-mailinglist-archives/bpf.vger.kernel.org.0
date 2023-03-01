Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14AE6A6C16
	for <lists+bpf@lfdr.de>; Wed,  1 Mar 2023 13:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCAMGu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Mar 2023 07:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjCAMGq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Mar 2023 07:06:46 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDAE3D0B5
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 04:06:31 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id da10so52904342edb.3
        for <bpf@vger.kernel.org>; Wed, 01 Mar 2023 04:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677672389;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UqcpZfu3vnSq8fJH66QOXn9Ku9XlGjHHYqb3TDMgAZY=;
        b=eI+DIfGkKJiUU//qsQcwboXUyS5yXwgJwPPpcXp1py8FjpejNwC3S/tvZLODgEP2J1
         fi4dve01v+PKiAG7B6IlKxRxvrzRfRsM8c+CNEAQ8Y+mlCkr9TH+YuwoNd6W8rRPg1f0
         qo6o0ajNDb03XPe+uY+f5RHnhuv2jPcJ3pTd0LljLj1CqR0lWakiXC8fbIQkxA4UL7lg
         PAMh0ZDowOVXEUfFHqwKwdpJF3qdI5NRBWgx3huYNxGl3nz/wYcMkV9k0dAH9ToezdsQ
         gL6lc9yuXgsnh7Tl1TPRbcjohejHDBjbADlltkmEFeVTnNPKDV5Mwrnx3cUpttY5UdT4
         NlXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677672389;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UqcpZfu3vnSq8fJH66QOXn9Ku9XlGjHHYqb3TDMgAZY=;
        b=Z2qUNWbcBMGdI4dIlQiP791LfM63gQ9DRHs5ioox9ZxGA0oJNv8XTY7yKS8kDnwbzt
         ceZTN7/iugKJN1nXBHBExU+QEogYJzvkn0U1Xps7bAKpCdHYt852HhrGky92Jm8Al3f2
         KUdZr+bpYUmiS2a3DREnTzVSi9DnsWx02UsDpN8/96j6HLb4yu3TGg2s/+YIOKJZnW66
         zBaCclhUvr08glJPTdKLveXe8S2bspFMNt/1SYQ4uypZ6UO9gVQMmzwDTUgFyOqZuYVZ
         KeOmOSfefzK7jW8hoazRY2VIPwQ0J7aM+L9/itlNDtaZmsE1Crb2RoJKCGZ5l/YFvgEq
         wi4g==
X-Gm-Message-State: AO0yUKVn8k/zwJgHn6gDWWsaSxVxghFB+7n7wHdpQR6rxCzDf+O8fdoU
        AkEBrg+nXO1PiGkmZ1vtruk=
X-Google-Smtp-Source: AK7set+ZjxnZ7UkHi379E93SpFVpMZvL+qvsF74ns9cM4uiDkann0GmuHRhh2h6SV0zIiYLi7KhNUQ==
X-Received: by 2002:a17:906:7111:b0:87e:9441:4c6c with SMTP id x17-20020a170906711100b0087e94414c6cmr5499630ejj.49.1677672389491;
        Wed, 01 Mar 2023 04:06:29 -0800 (PST)
Received: from [192.168.1.94] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id d3-20020a17090648c300b008dcaf24bf77sm5659965ejt.36.2023.03.01.04.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 04:06:28 -0800 (PST)
Message-ID: <c1d3f64dfeb96bfbcfdd593dedbad18b22388e4c.camel@gmail.com>
Subject: Re: bpf: RFC for platform specific BPF helper addition
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Tero Kristo <tero.kristo@linux.intel.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Date:   Wed, 01 Mar 2023 14:06:28 +0200
In-Reply-To: <73557717-e0b2-3969-4f08-c0951361af45@linux.intel.com>
References: <0838bc96-c8a8-c326-a8f0-80240cf6b31a@linux.intel.com>
         <CAADnVQJ4fHzqeuhbCF5SDR5V1Ktku=U2RRRPLc17ia0aFgNG=w@mail.gmail.com>
         <f171f10b-f7e5-e63d-b446-b37a2856909a@linux.intel.com>
         <CAADnVQKQ+eEyNt_3EsNkCbxgu93tNEOFq+EGs-6JJhMt-A50cA@mail.gmail.com>
         <73557717-e0b2-3969-4f08-c0951361af45@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2023-02-28 at 11:45 +0200, Tero Kristo wrote:
> On 25/02/2023 02:01, Alexei Starovoitov wrote:
> > On Fri, Feb 24, 2023 at 3:49 AM Tero Kristo <tero.kristo@linux.intel.co=
m> wrote:
> > >=20
> > > On 23/02/2023 19:46, Alexei Starovoitov wrote:
> > > > On Thu, Feb 23, 2023 at 5:23 AM Tero Kristo <tero.kristo@linux.inte=
l.com> wrote:
> > > > > Hi,
> > > > >=20
> > > > > Some background first; on x86 platforms there is a free running T=
SC
> > > > > counter which can be used to generate extremely accurate profilin=
g time
> > > > > stamps. Currently this can be used by BPF programs via hooking in=
to perf
> > > > > subsystem and reading the value there; however this reduces the a=
ccuracy
> > > > > due to latency + jitter involved with long execution chain, and a=
lso the
> > > > > timebase gets converted into relative from the start of the execu=
tion of
> > > > > the program, instead of getting an absolute system level value.
> > > > Are you talking about rdtsc or some other counter?
> > > > Does it need an arch specific setup?
> > > Yes, this is rdtsc. TSC is setup automatically by the arch, but
> > > exporting it to BPF takes a few lines of arch specific code (I did us=
e
> > > register_btf_kfunc_id_set() during init, under arch/x86/kernel/tsc.c.=
)
> > > > > Now, I do have a pretty trivial patch (under internal review atm.=
 at
> > > > > Intel) that adds an x86 platform specific bpf helper that can dir=
ectly
> > > > > read this timestamp counter without relying to perf subsystem hoo=
ks.
> > > > >=20
> > > > > Do people have any feedback / insights on this list about additio=
n of
> > > > > such platform specific BPF helper, basically thumbs up/down for a=
dding
> > > > > such a thing? Currently I don't think there are any platform spec=
ific
> > > > > helpers in the kernel.
> > > > Right. That's one of the reasons we don't add new helpers anymore.
> > > > Please use kfunc instead. You can add it to:
> > > > arch/x86/net/bpf_jit_comp.c
> > > > like:
> > > > __bpf_kfunc u64 bpf_read_rdtsc(void)
> > > > { asm ("...
> > > > or to arch specific kernel module.
> > > >=20
> > > > Make sure to add selftests when you submit a patch.
> Regarding this I got a follow up question, where would you recommend to=
=20
> put selftests for such functionality? Any of the BPF selftests appear to=
=20
> be generic currently.

Hi Tero,

You can take a look at these:
- tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
- tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c

Pre-processor conditionals are used in both cases:

  #ifdef __x86_64__
  ...
  #endif

Thanks,
Eduard
> > > Ok, I can take a look at the selftest side if things nudge forward,
> > > however there is some internal pressure to ditch the whole idea of
> > > bpf_rdtsc() due to potential of side channel attacks by using BPF, an=
d
> > > exploiting the accurate timer in the process. Any thoughts on that si=
de?
> > > Using BPF requires root access nowadays so it is sort of on-par to
> > > out-of-tree kernel modules.
> > Can you elaborate on that security concern?
> > User space can do rdtsc, so not clear how doing the same in bpf prog
> > loaded by root makes any difference.
> > Unpriv bpf is pretty much non-existent.
> > bpf subsystem went root only long ago.
>=20
> I am working on this internally with our security team atm., and the=20
> initial assessment is that the concern may not be valid due to the=20
> points you mention also.
>=20
> -Tero
>=20

