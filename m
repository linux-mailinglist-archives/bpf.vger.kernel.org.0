Return-Path: <bpf+bounces-9848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B80F79DCFD
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 02:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 189A21C20AC1
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 00:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7CD382;
	Wed, 13 Sep 2023 00:10:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F8A7F;
	Wed, 13 Sep 2023 00:10:56 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DBD10F2;
	Tue, 12 Sep 2023 17:10:55 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-5009d4a4897so10577925e87.0;
        Tue, 12 Sep 2023 17:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694563854; x=1695168654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDU5pSKkCf+ROG6Vvo9qMmmrl9dENDhQwvux9jW53fk=;
        b=CVyz6mj2IOl6ZWa3h6yHaDn88UJAmI459eSDxjXlKtaJpQjW8BHLm24w1AgA3xQoMD
         pHQ1FD5hSRFV4Xh1BKAQwXaXK2jpUHQc6eYZG7jrCtRupzu/fzVFENNDLJxbyGyJ9PPc
         fH/itVFaXbbnVIg2ipf6s3T4Z3FWpYM5E92nRP5HN4nl4xePNf7aehiFIfDvKHxQe60G
         KIko1QarmwKnGHdil8Tke9T1AhD8vEqc4nrECcj9FMBCrwUj5MW79lKUvWCEyifkNRLO
         MZJaljWTb4MWNi7if4UbMmGkK5djCeup7IR0PIM7gvUSojs4fWXXLEJLkHoil9VsfbN2
         Rw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694563854; x=1695168654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lDU5pSKkCf+ROG6Vvo9qMmmrl9dENDhQwvux9jW53fk=;
        b=l0M+Z+wKqg7JyIRRqf2kZDB9klGYcgIEWQFTkcpD7DCvsGRR+8CeSwSOf9a1WH/cH9
         LlTGbASgkT1vnXCFzMvA1K9r5ooeFbNCpfeAtJcT8xGhGjnL9+tC44rXafxRVjf/Teoz
         2Xpf1k69c5FzZ6ji/SYsKjOxL+v57doli++52S9qpIwbL7yT/ECNsMe8g1usQM9TsJmP
         RZd0pQZSiZsRHCyuuk0BB3DoS0JoFWmh7zbJI9w8tN7bgyNNGxo6lyWX2BXg9H/SBO6I
         J9quGX1vVKZsYbJ12wOBSgtjCIhJatqOPN7MnEGX6YXHawGl6sVf9Jgno1Z5RUNp1Z+3
         wLWQ==
X-Gm-Message-State: AOJu0YxJjhiJybii4mTJt1SajdD7QgAw7Ea6GdpAgu9uOEYk/liR8DW0
	+r0Fq5Xn+poy7KEypk1YjRPR+eJOYsla0MbC+aA=
X-Google-Smtp-Source: AGHT+IE0DJ1yIeH5yZxGYgPrqT6xeFSkjh5Zl6R/0fUeOPfMg57L6CIwSvBEee3CSY3IGdEklD5DOU0AfhXdAtHa5js=
X-Received: by 2002:a19:e012:0:b0:502:9dc3:9c68 with SMTP id
 x18-20020a19e012000000b005029dc39c68mr597128lfg.63.1694563853416; Tue, 12 Sep
 2023 17:10:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912224654.6556-1-puranjay12@gmail.com> <20230912224654.6556-6-puranjay12@gmail.com>
 <ZQDuVTSycDcjDkvi@shell.armlinux.org.uk> <CANk7y0iFdgHgu+RXYJvP3swaRS+-Lr0CgOAdcQWtjs4VkrOzdQ@mail.gmail.com>
In-Reply-To: <CANk7y0iFdgHgu+RXYJvP3swaRS+-Lr0CgOAdcQWtjs4VkrOzdQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 12 Sep 2023 17:10:42 -0700
Message-ID: <CAADnVQLzbyG3xWVDFyTsDPRSC=fnAskaeyc1erQVLYo_b6Lg_w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/6] bpf, arm32: Always zero extend for LDX with B/H/W
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shubham Bansal <illusionist.neo@gmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Wang YanQing <udknight@gmail.com>, bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-parisc@vger.kernel.org, ppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 4:17=E2=80=AFPM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> On Wed, Sep 13, 2023 at 1:04=E2=80=AFAM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Tue, Sep 12, 2023 at 10:46:53PM +0000, Puranjay Mohan wrote:
> > > The JITs should not depend on the verifier for zero extending the upp=
er
> > > 32 bits of the destination register when loading a byte, half-word, o=
r
> > > word.
> > >
> > > A following patch will make the verifier stop patching zext instructi=
ons
> > > after LDX.
> >
> > This was introduced by:
> >
> > 163541e6ba34 ("arm: bpf: eliminate zero extension code-gen")
> >
> > along with an additional function. So three points:
> >
> > 1) the commit should probably explain why it has now become undesirable
> > to access this verifier state, whereas it appears it was explicitly
> > added to permit this optimisation.
>
> I added some details in the cover letter.
>
> For the complete discussion see: [1]
>
> > 2) you state that jits should not depend on this state, but the above
> > commit adds more references than you're removing, so aren't there still
> > references to the verifier remaining after this patch? I count a total
> > of 10, and the patch below removes three.
>
> The JITs should not depend on this state for LDX (loading
> a B/H/W.
> This patch removes the usage only for LDX.
>
> > 3) what about the bpf_jit_needs_zext() function that was added to
> > support the export of this zext state?
>
> That is still applicable, The verifier will still emit zext
> instructions for other
> instructions like BPF_ALU / BPF_ALU64
>
> >
> > Essentially, the logic stated in the commit message doesn't seem to be
> > reflected by the proposed code change.
>
> I will try to provide more information.
> Currently I have asked Alexei if we really need this in [2].
> I still think this optimization is useful and we should keep it.

Right. subreg tracking is indeed functional for narrow loads.
Let's drop this patch set.

