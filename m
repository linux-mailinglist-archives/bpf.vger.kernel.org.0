Return-Path: <bpf+bounces-6025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E321A7642AE
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 01:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ED001C2146D
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 23:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B166BDDCA;
	Wed, 26 Jul 2023 23:39:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD83BE5C
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 23:39:42 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694642129
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 16:39:40 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99bc0da5684so35105166b.0
        for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 16:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690414779; x=1691019579;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XGx68qTI1bkx/pMJa88wVcICln3UVb6e60kC/3stXE0=;
        b=W7PV0PaJZV2/7ZcjJp9/XWvmcHYNTtSGWUeAv+/zOsEnqG79qO38s+Rcw8tZOJb2Yh
         c8kAJE7L2IF/CiiaMUgN9WVw5AFC734R5W/E96QTZiL/RvZ8E/YaIK3a+r8hQHiZ/iqs
         uMngbJg8lNgy5Sw3EE8Nw0srz1JAqRP3qjSUKgVcsiVTiTWnRXbwhBDOMC5uaZOuQVP9
         0MXAGbBBZGlrjkccRi/Lf9s6ayWGSZMVhXze5stQoYWvp6RBSq77xU4uNm+/Ev2S5me9
         XCq7E1dS7H0qRoVAydzNaVzwNAnwuqwQHPhlvZnyKGlnbPCFUmoCZMQS6ddN8bZ3MGpb
         luig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690414779; x=1691019579;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XGx68qTI1bkx/pMJa88wVcICln3UVb6e60kC/3stXE0=;
        b=BNBqxMtUJrx5yXhW+q912qy+B4Z6/6ozJe6dQHEp52wYjRkbNZpbraEqu6HP1QTeE2
         cv0dPmaNYa7v0BX8+rx6Po+kL3an+09a6w54x/Jxsjt+waW77pVyLZNmOnTZeCAFXAYY
         ieZYTneyOYIaigqa80dq1BrSFn+nv0+Se0TDMEbgW78dhwQuE2h2x8Vh+3hjVviCSJWU
         mzOhYZe30TcgJ7knIeS1r+gtkLbD/NNFekvQU84l98UdTFTK2nVFwJVhIZ5243IcbWjb
         TKOR9gXt7gnktNsrQ3Jka7pPnXOEStano7teZp+X27zpogiOGkwgdEZ0mI2BmdAYvrk4
         tyYQ==
X-Gm-Message-State: ABy/qLYvfv5BtiA9gIyINAYB71Sc86nXBRUEJ88ltUq5Tfravsgi0btK
	RIPza0mcpcOwYYeX/wb9YsU=
X-Google-Smtp-Source: APBJJlEJ/zY0YXiFHSa2gPlrr7saHPAOhC5jJ4vIyljXxaksZ0bJABZJ4Pd/x3K4l14OMnMymrAmmA==
X-Received: by 2002:a17:906:84:b0:993:8d16:4c22 with SMTP id 4-20020a170906008400b009938d164c22mr471162ejc.75.1690414778644;
        Wed, 26 Jul 2023 16:39:38 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id gr16-20020a170906e2d000b00977cad140a8sm18073ejb.218.2023.07.26.16.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 16:39:38 -0700 (PDT)
Message-ID: <4067a5cebe3df5b5cf436b27479a7c9a065d69a0.camel@gmail.com>
Subject: Re: Question: CO-RE-enabled PT_REGS macros give strange results
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, Timofei Pushkin
	 <pushkin.td@gmail.com>, Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org
Date: Thu, 27 Jul 2023 02:39:37 +0300
In-Reply-To: <8dd70c47d4f395ad5dd3b1da9e77221125eb9146.camel@gmail.com>
References: 
	<CAChPKzs_QBghSBfxMtTZoAsaRgwBK9dRXuXZg+tg2=wz=AuGgg@mail.gmail.com>
	 <3d26842f-86a4-e897-44c2-00c55fadb64a@oracle.com>
	 <CAChPKztZ9kaNw-PkhEq4UKidjVgKNnwLPKzYvLc6BcOOUtvEkQ@mail.gmail.com>
	 <883961c3-3ea2-2253-4976-aa5e20870820@oracle.com>
	 <51d510b9-fbbd-d30a-9a01-e77c84db52a5@oracle.com>
	 <49c9170f7dd0d3e78a12570ae422bce553a1e236.camel@gmail.com>
	 <308bfec7-38d7-9dcd-3130-5602658db47f@oracle.com>
	 <8dd70c47d4f395ad5dd3b1da9e77221125eb9146.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-07-26 at 23:03 +0300, Eduard Zingerman wrote:
[...]
> > > It looks like `PT_REGS_IP_CORE` macro should not be defined through
> > > bpf_probe_read_kernel(). I'll dig through commit history tomorrow to
> > > understand why is it defined like that now.
> > >  help
> >=20
> > If I recall the rationale was to allow the macros to work for both
> > BPF programs that can do direct dereference (fentry, fexit, tp_btf etc)
> > and for kprobe-style that need to use bpf_probe_read_kernel().
> > Not sure if it would be worth having variants that are purely
> > dereference-based, since we can just use PT_REGS_IP() due to
> > the __builtin_preserve_access_index attributes applied in vmlinux.h.
>=20
> Sorry, need a bit more time, thanks for the context.

The PT_REGS_*_CORE macros were added by Andrii Nakryiko in [1].
Stated intent there is to use those macros for raw tracepoint
programs. Such programs have `struct pt_regs` as a parameter.
Contexts of type `struct pt_regs` are *not* subject to rewrite by
convert_ctx_access(), so it is valid to use PT_REGS_*_CORE for such
programs.

However, `struct pt_regs` is also a part of `struct
bpf_perf_event_data`. Latter is used as a context parameter for
"perf_event" programs and is a subject to rewrite by
convert_ctx_access(). Thus, PT_REGS_*_CORE macros can't be used for
such programs (because these macro are implemented through
bpf_probe_read_kernel() of which convert_ctx_access() is not aware).

If `struct pt_regs` is defined with `preserve_access_index` attribute
CO-RE relocations are generated for both PT_REGS_IP_CORE and
PT_REGS_IP invocations. So, there is no real need to use *_CORE
variants in combination with `struct bpf_perf_event_data` to have all
CO-RE benefits, e.g.:

  $ cat bpf.c
  #include "vmlinux.h"
  // ...
  SEC("perf_event")
  int do_test(struct bpf_perf_event_data *ctx) {
    return PT_REGS_IP(&ctx->regs);
  }
  // ...
  $ llvm-objdump --no-show-raw-insn -rd bpf.o=20
  ...
  0000000000000000 <do_test>:
         0: r0 =3D *(u64 *)(r1 + 0x80)
            0000000000000000:  CO-RE <byte_off> [11] struct bpf_perf_event_=
data::regs.ip (0:0:16)
         1: exit

[1] b8ebce86ffe6 ("libbpf: Provide CO-RE variants of PT_REGS macros")

---

I think the following should be done:
- Timofei's code should use PT_REGS_IP and make sure that `struct
  pt_regs` has preserve_access_index annotation (e.g. use vmlinux.h);
- verifier should be adjusted to report error when
  bpf_probe_read_kernel() (and similar) are used to read from "fake"
  contexts.
- (maybe?) update PT_REGS_*_CORE to use `__builtin_preserve_access_index`
  (to allow usage with `bpf_perf_event_data` context).

[...]

