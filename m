Return-Path: <bpf+bounces-687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4B2705CB2
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 03:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18F3E1C20CF0
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 01:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F6617F3;
	Wed, 17 May 2023 01:55:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C681417D0
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 01:55:07 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F4D3C33;
	Tue, 16 May 2023 18:55:06 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51090206721so370982a12.0;
        Tue, 16 May 2023 18:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684288504; x=1686880504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PzZh0bIZSJ+JPhYvLDEGW/XgH4+hk0vQUZAdjfNNsdg=;
        b=ZbE0g5qJQ2o9t0i1MOgKVdjGyHIxLEcWxeQfDxs9Z/f5sK1/cZh05zbTDuiM0wv3eT
         ifv1XJk4gYn/uZi7kgIM/IAxyph61Tn2TfJC2F78HRn5M/CORQJx+zPrpnDyhFaEyTDR
         LzSPODZYS8B+7Piwap7DrMRvMQAhcQq13pxT3TzPd2kQ8VxzzWAOi1GZSKN6HsO2GlT+
         SURfW30bGy/IxQevnxxYtzfGiQXGQlofTtqcXMTIVTA9YKL4/PiNVhgqTtVcG1dh/Hpx
         Tp8rlIoSdBsO1ummd85QXj8qkuq0A/hhhdM9X31zqAz0nVvl7IUBn545twb9SIKOLo3D
         Uj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684288504; x=1686880504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PzZh0bIZSJ+JPhYvLDEGW/XgH4+hk0vQUZAdjfNNsdg=;
        b=ZGox+Cv2C6lTEZJHVDbC1L/w4BDecPcPN4a01RSj8aKwSvCeNpH+wdoZmC/KoNyKN8
         UP09cBzQWYd/IFlzF14TpH4nQTn4TN037Pl/PJav8mvLEiS0tf3fYTjMPHyYxEVkd3D9
         ePq0ObgrBBJ7KOUZaP7Qj80o4MQZJ4qgmR+/XjnbKG1sy0UJThHX5iOksu29g755az+I
         0cSghaW4z2v3RDydx8M947Uw2w/dT2PAkKszo3pPF4GQnp0gwYmPC26WcjOqnFRw7wBM
         /90clwuWUh+nSgPNMh8hj8haz/m1QnRsqT1i4RBzdbKmXd5NXSejY+js2TfEzbfftkkh
         QhfQ==
X-Gm-Message-State: AC+VfDxBhUsAURDFeE7brMwnq1GIieJ2rI1b6I6qpAifO1aYrNrYoC7g
	xTH/Pvyhw21BiNf1Q1UU49lyWgv/+XAsM0MbTwA=
X-Google-Smtp-Source: ACHHUZ7NsRASUg7F+CJyPuN2am+wh93OmEnhfAmtdtKJmfYbwMRaHk8oJ5Ft6fHAO6vVt499Vf2lbNpMiyi2+jQzsxE=
X-Received: by 2002:a50:fb9a:0:b0:506:9805:7b56 with SMTP id
 e26-20020a50fb9a000000b0050698057b56mr856882edq.32.1684288504486; Tue, 16 May
 2023 18:55:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230516071830.8190-1-zegao@tencent.com> <20230516071830.8190-3-zegao@tencent.com>
 <20230516091820.GB2587705@hirez.programming.kicks-ass.net>
 <CAD8CoPDFp2_+D6nykj6mu_Pr57iN+8jO-kgA_FRrcxD8C7YU+Q@mail.gmail.com> <20230517010311.f46db3f78b11cf9d92193527@kernel.org>
In-Reply-To: <20230517010311.f46db3f78b11cf9d92193527@kernel.org>
From: Ze Gao <zegao2021@gmail.com>
Date: Wed, 17 May 2023 09:54:53 +0800
Message-ID: <CAD8CoPAw_nKsm4vUJ_=aSwzLc5zo8D5pY6A7-grXENxpMYz9og@mail.gmail.com>
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

Oops, I misunderstood your comments before.

Yes, it's not necessary to do this reordering as regards to kprobe.

Thanks for your review.

I'll rebase onto the latest tree and send v3 ASAP.

Regards,
Ze

On Wed, May 17, 2023 at 12:03=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.=
org> wrote:
>
> On Tue, 16 May 2023 17:47:52 +0800
> Ze Gao <zegao2021@gmail.com> wrote:
>
> > Precisely, these that are called within kprobe_busy_{begin, end},
> > which the previous patch does not resolve.
>
> Note that kprobe_busy_{begin,end} don't need to use notrace version
> because kprobe itself prohibits probing on preempt_count_{add,sub}.
>
> Thank you,
>
> > I will refine the commit message to make it clear.
> >
> > FYI, details can checked out here:
> >     Link: https://lore.kernel.org/linux-trace-kernel/20230516132516.c90=
2edcf21028874a74fb868@kernel.org/
> >
> > Regards,
> > Ze
> >
> > On Tue, May 16, 2023 at 5:18=E2=80=AFPM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > >
> > > On Tue, May 16, 2023 at 03:18:28PM +0800, Ze Gao wrote:
> > > > Current implementation calls kprobe related functions before doing
> > > > ftrace recursion check in fprobe_kprobe_handler, which opens door
> > > > to kernel crash due to stack recursion if preempt_count_{add, sub}
> > > > is traceable.
> > >
> > > Which preempt_count*() are you referring to? The ones you just made
> > > _notrace in the previous patch?
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

