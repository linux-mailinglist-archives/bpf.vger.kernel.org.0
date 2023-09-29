Return-Path: <bpf+bounces-11139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E787B3BC9
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 23:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 0BA66283669
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 21:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325F167283;
	Fri, 29 Sep 2023 21:06:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FABE6669B;
	Fri, 29 Sep 2023 21:06:25 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58461AA;
	Fri, 29 Sep 2023 14:06:23 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40651a72807so23215645e9.1;
        Fri, 29 Sep 2023 14:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696021582; x=1696626382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbVvdfxT+ctO+wp0FbZvisKSLp6xw0QJ7qLYaMtlI+k=;
        b=M3egKELQc0KLU7GDa5GLudV47P/aeFqy7PKSgJ1UXez81zHOKl0WpIKqlbJLG8ybSu
         kXBm9Wanrg0wCb4e//qBaEpNNrKutucTbueYHVf67Etf5KShlvqynun5QCe9t7PTRLf+
         7ArdWkdbRvumWdcWK6ZXPJ01nMv6ldODhwevxHOdcYp4DZMiDQB1kgpxT7f+zps8fhYf
         8Ce3/b502kQGE7/Chs1isKzNijAi/+iQlasMBJJd3fWBJJsHN9ZZ0i7MN3ouOdgJzzI8
         zMaSuGOV0ze6ZWXxN4ycNHXcYlI7imLOy5+zAtcMvLYkIR+TSXiwdCagoRd+FCJ3i8IN
         Z6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696021582; x=1696626382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GbVvdfxT+ctO+wp0FbZvisKSLp6xw0QJ7qLYaMtlI+k=;
        b=uHRmj0ubD44jqQpoWYRnxCyb2iGZaobYpTu3xtjCozs1KPUabkeqEmbwS7Nq6KXcZc
         gjdGw12sdHbRPz1f3R7Tb4ZopnYcqZK8E33NmkOTjhaEOxy9Pj5awfM0PtE7JXFtFUBk
         hFD/mTRUD/hSs4H0hCfKDmrjADFU1eq9hyzrC43QbXwkwcghM7nEx4pwghUgBp7wQqAZ
         yr1qn9YDrTyATJyD43cPIEWkVeeveKN0t7T6I2y9iEi6mS7vUdSuDae0gTUlqOiC+UXb
         bvPcWQU477XMKjjWtGYMnIlFDU9rF6a3BuUPlYJhdvcKUCQyv73G8IzqUuW0Ddk1Uhw4
         b3Ug==
X-Gm-Message-State: AOJu0YxZTpPlVkoQJzl6RiX8W/3hZxQ/BNDbqe0Rgf+XJUaNG6iy8Hpt
	M7SMmI8TUfla3NODqqK8d76/7DEy3fP3z2KczEo=
X-Google-Smtp-Source: AGHT+IGFmaNB59TjRGeXl93FIBYHgT+QH4OM9LA+HiSjaFSWkt/RqZCPKPLl8JCavCiQoSJ89nOVMTqy0tO6SBAlwJk=
X-Received: by 2002:a05:600c:21ca:b0:405:3b1f:9691 with SMTP id
 x10-20020a05600c21ca00b004053b1f9691mr5202346wmj.11.1696021582110; Fri, 29
 Sep 2023 14:06:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <157046883614.2092443.9861796174814370924.stgit@alrua-x1>
 <20191007204234.p2bh6sul2uakpmnp@ast-mbp.dhcp.thefacebook.com>
 <87sgo3lkx9.fsf@toke.dk> <20191009015117.pldowv6n3k5p3ghr@ast-mbp.dhcp.thefacebook.com>
 <87o8yqjqg0.fsf@toke.dk> <20191010044156.2hno4sszysu3c35g@ast-mbp.dhcp.thefacebook.com>
 <87v9srijxa.fsf@toke.dk> <20191016022849.weomgfdtep4aojpm@ast-mbp>
 <8736fshk7b.fsf@toke.dk> <20191019200939.kiwuaj7c4bg25vqs@ast-mbp> <ZRQtsyYM810Oh4px@google.com>
In-Reply-To: <ZRQtsyYM810Oh4px@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 29 Sep 2023 14:06:10 -0700
Message-ID: <CAADnVQJpCe9e2Qrnsaj4+ab47z00-bEYyHhN_mmpCh4+9i17vQ@mail.gmail.com>
Subject: Re: bpf indirect calls
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	Marek Majkowski <marek@cloudflare.com>, Lorenz Bauer <lmb@cloudflare.com>, 
	Alan Maguire <alan.maguire@oracle.com>, Jesper Dangaard Brouer <brouer@redhat.com>, 
	David Miller <davem@davemloft.net>, Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 6:27=E2=80=AFAM Matt Bobrowski <mattbobrowski@googl=
e.com> wrote:
>
>
> static void testing(void) {
>   bpf_printk("testing");
> }
>
> struct iter_ctx {
>   void (*f) (void);
> };
> static u64 iter_callback(struct bpf_map *map, u32 *key,
>                          u64 *value, struct iter_ctx *ctx) {
>   if (ctx->f) {
>     ctx->f();
>   }
>   return 0;
> }
>
> SEC("lsm.s/file_open")
> int BPF_PROG(file_open, struct file *file)
> {
>   struct iter_ctx iter_ctx =3D {
>     .f =3D testing,
>   };
>   bpf_for_each_map_elem(&map, iter_callback, &iter_ctx, 0);
>   return 0;
> }
> ```
...
> The fundamental difference between the two call instructions if I'm
> not mistaken is that one attempts to perform a call using an immediate
> value as its source operand, whereas the other attempts to perform a
> call using a source register as its source operand. AFAIU, the latter
> is not currently permitted by the BPF verifier. Is that right?

Correct. Indirect calls via 'callx' instruction are not supported yet.
Please use bpf_tail_call() as a workaround for now.

Over the years the verifier became progressively smarter and maybe
now is a good time to support true indirect calls.
For certain cases like your example above it's relatively easy
to add such support, but before we do that please describe
the full use case that you wanted to implement with indirect calls.

