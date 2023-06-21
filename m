Return-Path: <bpf+bounces-3041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCA8738B00
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 18:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5155E1C20F03
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 16:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F5019926;
	Wed, 21 Jun 2023 16:25:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A35618C2E
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 16:25:09 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C941BC;
	Wed, 21 Jun 2023 09:25:07 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-519c0ad1223so7549737a12.0;
        Wed, 21 Jun 2023 09:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687364706; x=1689956706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QL1t4miGxRnnxQzf8bjjL0+PFINXfuxB+zoinGDtes8=;
        b=irrMpAFNJpTfbjVuH28fbCCV4lH0Ch8ytsOoxweDj1qnoZo3ylZ2LN/OTyjLU5p91D
         9gQ9eu5tXdmVWpJcJL6oYE8gKOgzBr7Oi0/Cz5BZNewF5k7wTS9wJwpj3TstACyyC5Zh
         nb1wnAQOSQMf2QDyHj3LAYOMZCJR2OA3xM8u7hSTUCJ1lnf0iQlWOC53zf7Upi5uT6FT
         RgzdWPTkbpkdxUxiGNPgDtbfFNB8YOdE5sv0pqkpvw1VAkeR5wUPIWIoU2Ufl2DwIh/9
         ZLedVmJNSAqgB9T1tATySiZW5XPEXlwrBRf6UN9dDJL3ZSVUDXB8VlYOyNNRv2L06Uy4
         qESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687364706; x=1689956706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QL1t4miGxRnnxQzf8bjjL0+PFINXfuxB+zoinGDtes8=;
        b=Cwh6FfdDLYV1FE0BMg4XNZ3UJJbl0DUiDHrIp9IqA0gxe5+moSLjyxAPbUcZqG3Gx8
         /Ts54Fn/0OC1uDV9OykpFd4bUAIC3iF/F3+6+sLHYNCfJGBii93k6MqLQOXIBXQbx9q8
         Tppd42lEgOYt7RIF48SQWo6ST7QOYX2zrx54W+VjToffeTf6AjVDuhhWwIhFAZqtZfFF
         cjtHBbOqChdKsLbMdbuT+mGnVgYgiOr67Dow3VzZJvblJef2kZ4vJdBiSk7qEy4dctp8
         Ffnv8jRsEjI4MbneT4jNy95AOfRX5jLBZNjWvlguz+2OLvY2TRLPqDMjTsPbmAGwndOA
         VduQ==
X-Gm-Message-State: AC+VfDwimRsKmCB+Gjd5+Vy0nzSYn24ZTmGuCZgzx64tPyOkBoIKSyiR
	FrNG1PahPXJspo4tBtYd42RXNfB+PfVp/LseVgM+cgnb
X-Google-Smtp-Source: ACHHUZ4lwnpU6y2DEqkwAjOhowAtut67tG33cF4WNAz5zfOTSljr0nDzT8AJQpyZqkWm82NcD83fJBnQqxZ06OqUACg=
X-Received: by 2002:aa7:c6c5:0:b0:51a:4d98:e5ce with SMTP id
 b5-20020aa7c6c5000000b0051a4d98e5cemr7411614eds.36.1687364705636; Wed, 21 Jun
 2023 09:25:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230619100121.27534-1-puranjay12@gmail.com> <20230619100121.27534-4-puranjay12@gmail.com>
 <ZJMXqTffB22LSOkd@FVFF77S0Q05N>
In-Reply-To: <ZJMXqTffB22LSOkd@FVFF77S0Q05N>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 21 Jun 2023 09:24:54 -0700
Message-ID: <CAADnVQJqDOMABEx8JuU6r_Dehyf=SkDfRNChx1oNfqPoo7pSrw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/3] bpf, arm64: use bpf_jit_binary_pack_alloc
To: Mark Rutland <mark.rutland@arm.com>
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, bpf <bpf@vger.kernel.org>, 
	KP Singh <kpsingh@kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 21, 2023 at 8:31=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> On Mon, Jun 19, 2023 at 10:01:21AM +0000, Puranjay Mohan wrote:
> > Use bpf_jit_binary_pack_alloc for memory management of JIT binaries in
> > ARM64 BPF JIT. The bpf_jit_binary_pack_alloc creates a pair of RW and R=
X
> > buffers. The JIT writes the program into the RW buffer. When the JIT is
> > done, the program is copied to the final RX buffer
> > with bpf_jit_binary_pack_finalize.
> >
> > Implement bpf_arch_text_copy() and bpf_arch_text_invalidate() for ARM64
> > JIT as these functions are required by bpf_jit_binary_pack allocator.
> >
> > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
>
> From a quick look, I don't beleive the I-cache maintenance is quite right=
 --
> explanation below.
>
> > @@ -1562,34 +1610,39 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf=
_prog *prog)
> >
> >       /* 3. Extra pass to validate JITed code. */
> >       if (validate_ctx(&ctx)) {
> > -             bpf_jit_binary_free(header);
> >               prog =3D orig_prog;
> > -             goto out_off;
> > +             goto out_free_hdr;
> >       }
> >
> >       /* And we're done. */
> >       if (bpf_jit_enable > 1)
> >               bpf_jit_dump(prog->len, prog_size, 2, ctx.image);
> >
> > -     bpf_flush_icache(header, ctx.image + ctx.idx);
> > +     bpf_flush_icache(ro_header, ctx.ro_image + ctx.idx);
>
> I think this is too early; we haven't copied the instructions into the
> ro_header yet, so that still contains stale instructions.
>
> IIUC at the whole point of this is to pack multiple programs into shared =
ROX
> pages, and so there can be an executable mapping of the RO page at this p=
oint,
> and the CPU can fetch stale instructions throught that.
>
> Note that *regardless* of whether there is an executeable mapping at this=
 point
> (and even if no executable mapping exists until after the copy), we at le=
ast
> need a data cache clean to the PoU *after* the copy (so fetches don't get=
 a
> stale value from the PoU), and the I-cache maintenance has to happeon the=
 VA
> the instrutions will be executed from (or VIPT I-caches can still contain=
 stale
> instructions).

Good catch.
Also considering the boot issue reported in the other thread
I removed this series from bpf-next.
Looks like another respin is necessary.

