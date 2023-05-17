Return-Path: <bpf+bounces-695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 296FC705DC8
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 05:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07F6F1C20DD1
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 03:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F86017F3;
	Wed, 17 May 2023 03:10:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E9D20E6
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 03:10:36 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B6695;
	Tue, 16 May 2023 20:10:34 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-510b56724caso5463763a12.1;
        Tue, 16 May 2023 20:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684293033; x=1686885033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pTSSDCaJ7lg+mm+c1srKGW468miK1XyKNdzeJHhyA4=;
        b=I+9fckyUF5DFOB6kouKDdUAmllDqQc/QcYTLG04b1K0QXMyqFH5nnQjIM6IaV5FrfE
         9o1FW9Kv5QKwd/b/XosujS90FzOmEGOxbLfFzpgDNB7shG1AI9AkMYhlRzjXqarJ557x
         zXm/VNz50OcuKrIWifJNvjToTwj6BUCVsMXU174tk3lL5idWChdZQuqOZgZf/Y0gg6ZG
         JTmWJ1ruoTgN/IGHBby+zPT5PJiduLY+v84V7kWaWiBXjcFM/VB52HWOqHLi0J0yxxXK
         MaqzP6Ja9YE2dfeF6AKzQTN/Bgfa3WOPzdrHWHqY0FKWJyCvbMDUA0cDg+9Sjo/KeM/q
         wLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684293033; x=1686885033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pTSSDCaJ7lg+mm+c1srKGW468miK1XyKNdzeJHhyA4=;
        b=J34l9UaRTUAw2UjiN8Ah8NttWLUry5ptAmAv2Gg16AO3PRvcYisRwqGjr1iVYYvrnR
         EsXG9ZutzCuiMiKajEbxma1tj2FZp6g//p/8dN3N3BljjrFLeHWYwv1KV2VJ/qw79xwd
         hD0o6qMamnjUAyhSKVD2Y2uWd29fyyZq56rr0ngEWJub4/cz2c7msfPyCHT4QygJsURz
         EzDmbfB0s6Eq6/DQR+w+Ht4Jve5IRginXvsws3z++hK57Qo96NYp/pGBbQ/B8L/jmQgQ
         O+K211hAgXNcGhAC7skq9kfBzKqzyx0Pf75YZHfjn7DMclFOAjPRnRedRaFiM3rjlqH8
         U5Cg==
X-Gm-Message-State: AC+VfDwmztlWX9/sDIGR4ym9yhkekvsFfag0kA21U6ijsw6hBCf6QzRG
	ATNJk1PxebEqsjGL8o8GZgEq+wQztqaDKsEevBY=
X-Google-Smtp-Source: ACHHUZ5Y5JiuuaffuRZQsJfvcnMH3GABSYBQ500yWJBzQa8Yn/drbPzcBo6ii1dLFh7aQZEdgHIVR3eI2pIheciedjI=
X-Received: by 2002:a05:6402:2807:b0:506:b94f:3d8f with SMTP id
 h7-20020a056402280700b00506b94f3d8fmr721226ede.5.1684293033169; Tue, 16 May
 2023 20:10:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230516071830.8190-1-zegao@tencent.com> <20230516071830.8190-3-zegao@tencent.com>
 <20230516091820.GB2587705@hirez.programming.kicks-ass.net>
 <CAD8CoPDFp2_+D6nykj6mu_Pr57iN+8jO-kgA_FRrcxD8C7YU+Q@mail.gmail.com>
 <20230517010311.f46db3f78b11cf9d92193527@kernel.org> <CAD8CoPAw_nKsm4vUJ_=aSwzLc5zo8D5pY6A7-grXENxpMYz9og@mail.gmail.com>
 <20230517115432.94a65364e53cbd5b40c54e82@kernel.org>
In-Reply-To: <20230517115432.94a65364e53cbd5b40c54e82@kernel.org>
From: Ze Gao <zegao2021@gmail.com>
Date: Wed, 17 May 2023 11:10:21 +0800
Message-ID: <CAD8CoPC0BXB2ER_Oaixm5XgMk8TTqKVVF7Po0t4gBPOLhw_xwQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] fprobe: make fprobe_kprobe_handler recursion free
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Alexei Starovoitov <ast@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Heiko Carstens <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Vasily Gorbik <gor@linux.ibm.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Conor Dooley <conor@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>, 
	Ze Gao <zegao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Got it! :)

I will improve the commit message and send v3 ASAP.

BTW, which tree should I rebase those patches onto? Is that the
for-next branch of
git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git. I saw
Jiri had troubles
applying those since these works are based on v6.4.0.

THX,
Ze

On Wed, May 17, 2023 at 10:54=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.=
org> wrote:
>
> On Wed, 17 May 2023 09:54:53 +0800
> Ze Gao <zegao2021@gmail.com> wrote:
>
> > Oops, I misunderstood your comments before.
> >
> > Yes, it's not necessary to do this reordering as regards to kprobe.
>
> Let me confirm, I meant that your current patch is correct. I just mentio=
ned
> that kprobe_busy_{begin,end} will continue use standard version because
> kprobe itself handles that. Please update only the patch description and
> add my ack.
>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> If you add Steve's call graph for the explanation, it will help us to
> understand what will be fixed.
>
> Thank you,
>
> >
> > Thanks for your review.
> >
> > I'll rebase onto the latest tree and send v3 ASAP.
> >
> > Regards,
> > Ze
> >
> > On Wed, May 17, 2023 at 12:03=E2=80=AFAM Masami Hiramatsu <mhiramat@ker=
nel.org> wrote:
> > >
> > > On Tue, 16 May 2023 17:47:52 +0800
> > > Ze Gao <zegao2021@gmail.com> wrote:
> > >
> > > > Precisely, these that are called within kprobe_busy_{begin, end},
> > > > which the previous patch does not resolve.
> > >
> > > Note that kprobe_busy_{begin,end} don't need to use notrace version
> > > because kprobe itself prohibits probing on preempt_count_{add,sub}.
> > >
> > > Thank you,
> > >
> > > > I will refine the commit message to make it clear.
> > > >
> > > > FYI, details can checked out here:
> > > >     Link: https://lore.kernel.org/linux-trace-kernel/20230516132516=
.c902edcf21028874a74fb868@kernel.org/
> > > >
> > > > Regards,
> > > > Ze
> > > >
> > > > On Tue, May 16, 2023 at 5:18=E2=80=AFPM Peter Zijlstra <peterz@infr=
adead.org> wrote:
> > > > >
> > > > > On Tue, May 16, 2023 at 03:18:28PM +0800, Ze Gao wrote:
> > > > > > Current implementation calls kprobe related functions before do=
ing
> > > > > > ftrace recursion check in fprobe_kprobe_handler, which opens do=
or
> > > > > > to kernel crash due to stack recursion if preempt_count_{add, s=
ub}
> > > > > > is traceable.
> > > > >
> > > > > Which preempt_count*() are you referring to? The ones you just ma=
de
> > > > > _notrace in the previous patch?
> > >
> > >
> > > --
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

