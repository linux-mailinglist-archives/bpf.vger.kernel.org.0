Return-Path: <bpf+bounces-617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5A77049A6
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 11:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3481028161B
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 09:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C82171D6;
	Tue, 16 May 2023 09:48:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2132C726
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 09:48:09 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1752D62;
	Tue, 16 May 2023 02:48:05 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50bc570b4a3so24971550a12.1;
        Tue, 16 May 2023 02:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684230484; x=1686822484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvja6u6ZFGfnkLgz3Y8JuncRIU7gT8PI/VykX029Ek8=;
        b=TC7kZ/eTedXqDpQDxFKtRdYmJcctfLX6NTMRBtAufhESfjfZFEbqTOwHLyakOCtvW0
         AMBh812gNA/G0aj8rpTd6aE2NMZwOWYIQ+dEhHCfRIT7f+UR/e+BwhnodvdfqbO+wb6U
         eRsVzFQ9r9dSTvVsd8slJf/AXpUgm3neL8HFRbZ6TvzwrSj9eaa80Kd5Ae0mH3g38KWb
         0rxQElUd98LPtTocedpBmQtSgxVDb+DXoUfIwerj3++n+SHfyWBHYYoVGZYZH8cc1Rp/
         iCPK5pJKUn4uSOhWWDOrnur3lpeS2sVYd3XMEmKfCashfPiPR9u8n5okyWqkkRdaFWdM
         /zpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684230484; x=1686822484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvja6u6ZFGfnkLgz3Y8JuncRIU7gT8PI/VykX029Ek8=;
        b=hc1+fk5sUeJputphOQr8sq4JyNowBSk4JxBVKqUYZHtuaRmD2ZdFRm1hf7rsB9wAY5
         N06vP12tIKBvUkRXoE4Pm/8vUIA70wm/Vwzz1+Qm7O1i4oj2QSU1ksUpZDDyAcWaI9A1
         58wKKrxS9N5aNjPM16lPgWt0ykng/42sF2HTaD5GfSdIc3qUX5/Cmxv4vMF9O+pbNTq+
         QcZWUAH8Jn7k46s8At7wqpT3MFFRb+PtF9T5wFQTHe23VFn7bxDdGXTvdCP0jqTrNIOE
         Lpypp0d3uXiG3oI8ukYCt+KLmhaiSPb+M0wroyK1B/Br+k4XYlmQ1oJNTYCew2vWmOFl
         1t7A==
X-Gm-Message-State: AC+VfDyAaEnDkaYc3cCo2w+cLpHyOzPH11723jnGw22viL3gc9c7NS+c
	gCVHw9IAcbk+KSf6DXcqM7V7V8/UVNIsCqtzD/I=
X-Google-Smtp-Source: ACHHUZ58Xk+LnHJqjDTQuzlbH9AZ2ZBiLiSzhynrpP51aJp6KZ9Hq9kWwdgsjYeQWqA2BDUz86yph1wPMeprS3aKpgQ=
X-Received: by 2002:aa7:d943:0:b0:510:47a3:e775 with SMTP id
 l3-20020aa7d943000000b0051047a3e775mr6274132eds.41.1684230483965; Tue, 16 May
 2023 02:48:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230516071830.8190-1-zegao@tencent.com> <20230516071830.8190-3-zegao@tencent.com>
 <20230516091820.GB2587705@hirez.programming.kicks-ass.net>
In-Reply-To: <20230516091820.GB2587705@hirez.programming.kicks-ass.net>
From: Ze Gao <zegao2021@gmail.com>
Date: Tue, 16 May 2023 17:47:52 +0800
Message-ID: <CAD8CoPDFp2_+D6nykj6mu_Pr57iN+8jO-kgA_FRrcxD8C7YU+Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] fprobe: make fprobe_kprobe_handler recursion free
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
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

Precisely, these that are called within kprobe_busy_{begin, end},
which the previous patch does not resolve.
I will refine the commit message to make it clear.

FYI, details can checked out here:
    Link: https://lore.kernel.org/linux-trace-kernel/20230516132516.c902edc=
f21028874a74fb868@kernel.org/

Regards,
Ze

On Tue, May 16, 2023 at 5:18=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Tue, May 16, 2023 at 03:18:28PM +0800, Ze Gao wrote:
> > Current implementation calls kprobe related functions before doing
> > ftrace recursion check in fprobe_kprobe_handler, which opens door
> > to kernel crash due to stack recursion if preempt_count_{add, sub}
> > is traceable.
>
> Which preempt_count*() are you referring to? The ones you just made
> _notrace in the previous patch?

