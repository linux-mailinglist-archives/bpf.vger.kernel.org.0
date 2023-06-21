Return-Path: <bpf+bounces-3072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52558739135
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 22:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7690D1C20BC0
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 20:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A5F1C76E;
	Wed, 21 Jun 2023 20:57:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9426117724
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 20:57:53 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62681BD4;
	Wed, 21 Jun 2023 13:57:33 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f8792d2e86so4076393e87.1;
        Wed, 21 Jun 2023 13:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687381052; x=1689973052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkYjPecj7jkh0eSl5nFN/psGSW4/CTbJ5xdbDB+Wop0=;
        b=j8KrwTzp6jE/6uuK++JqQ9NzN6+z0609C5pLtnysgbCrHSZPdaBhTKnonmJ9utZCvX
         D06WB8IdHrMy2mmBmIm4MQkOq9UU/qcEGRj2dKDiMwGKHb5nDyc2z+kPZd6uqWagqBdu
         Lfwy7l7iX3xLeO5uSOLaSnDqqxWOKx2xY/kHXRJpfzTKUfXqpw41lwBcrvIdLI6cz24V
         rbkkB+lqSBRHJpNpauQwuRBo/7UqE2H3Iinx+cbnaWSM2A0f5eetSd/Pjv90kr6HVLYa
         0PVxvuBT4y9Rluh6zz6Pw9dGXgI0iTtRgQXJ9+pCLiKCkHCQj1j3NhD7DzBTP+6zXsuX
         IqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687381052; x=1689973052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NkYjPecj7jkh0eSl5nFN/psGSW4/CTbJ5xdbDB+Wop0=;
        b=WRc4DnjzIYNqcm3S4QGOIoEH7z+wsMXRUIXzJgScmuY40307hi1SZoNGVj4jLZ1MTj
         7srGzoii/wsrz4pP6h0ibxqCIzZSKTnh/7XWST81XF7PznbDOxp4T79zE43T5z32F2dw
         Y4braSvzd2u4npV+fMyTaOjcbbMbaahMBTck8UsJjZLX4HdkgXm2giJpQQghAa+u/o3p
         v09MSPhDZKxV1l+j9acnCw/JuaVKdJrhnFrJAy/YBzeK1MopEbxJgFFFG1hKEdb1j+PU
         Gb4XyXmwfGxJawSJJIXc8yB5ad5T+xCt78/n4gnBQXet1+gM9/hu2dnp/dtTQpoE45ed
         Rkow==
X-Gm-Message-State: AC+VfDyPhMkEvnrLdhXobKDd1Sl8GGciraR2hd+pUQVBcnDvCBSfUCnv
	bfNBuVQ1J/ne11m+bg/tUKTpt9VNHDi+xLQaliC3mhu+EvyJsIoR8Ws=
X-Google-Smtp-Source: ACHHUZ4OW6Y4mRQPu6nwXJqkIM9/RAD5tiOhgB/7GpKShKprEHiAJLztiSV1PANQDaop0VsiU7JYv/iC/lUmNpWR0/U=
X-Received: by 2002:a05:6512:3985:b0:4f9:615f:14dd with SMTP id
 j5-20020a056512398500b004f9615f14ddmr477123lfu.11.1687381051562; Wed, 21 Jun
 2023 13:57:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230619100121.27534-1-puranjay12@gmail.com> <20230619100121.27534-4-puranjay12@gmail.com>
 <ZJMXqTffB22LSOkd@FVFF77S0Q05N>
In-Reply-To: <ZJMXqTffB22LSOkd@FVFF77S0Q05N>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 21 Jun 2023 22:57:20 +0200
Message-ID: <CANk7y0h5ucxmMz4K8sGx7qogFyx6PRxYxmFtwTRO7=0Y=B4ugw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/3] bpf, arm64: use bpf_jit_binary_pack_alloc
To: Mark Rutland <mark.rutland@arm.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, catalin.marinas@arm.com, 
	bpf@vger.kernel.org, kpsingh@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Mark,

On Wed, Jun 21, 2023 at 5:31=E2=80=AFPM Mark Rutland <mark.rutland@arm.com>=
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

Thanks for catching this, It is a big miss from my side.

I was able to reproduce the boot issue in the other thread on my
raspberry pi. I think it is connected to the
wrong I-cache handling done by me.

As you rightly pointed out: We need to do bpf_flush_icache() after
copying the instructions to the ro_header or the CPU can run
incorrect instructions.

When I move the call to bpf_flush_icache() after
bpf_jit_binary_pack_finalize() (this does the copy to ro_header), the
boot issue
is fixed. Would this change be enough to make this work or I would
need to do more with the data cache as well to catch other
edge cases?

Thanks,
Puranjay

>
> Thanks,
> Mark.
>
> >
> >       if (!prog->is_func || extra_pass) {
> >               if (extra_pass && ctx.idx !=3D jit_data->ctx.idx) {
> >                       pr_err_once("multi-func JIT bug %d !=3D %d\n",
> >                                   ctx.idx, jit_data->ctx.idx);
> > -                     bpf_jit_binary_free(header);
> >                       prog->bpf_func =3D NULL;
> >                       prog->jited =3D 0;
> >                       prog->jited_len =3D 0;
> > +                     goto out_free_hdr;
> > +             }
> > +             if (WARN_ON(bpf_jit_binary_pack_finalize(prog, ro_header,
> > +                                                      header))) {
> > +                     /* ro_header has been freed */
> > +                     ro_header =3D NULL;
> > +                     prog =3D orig_prog;
> >                       goto out_off;
> >               }
> > -             bpf_jit_binary_lock_ro(header);
> >       } else {
> >               jit_data->ctx =3D ctx;
> > -             jit_data->image =3D image_ptr;
> > +             jit_data->ro_image =3D ro_image_ptr;
> >               jit_data->header =3D header;
> > +             jit_data->ro_header =3D ro_header;
> >       }
> > -     prog->bpf_func =3D (void *)ctx.image;
> > +     prog->bpf_func =3D (void *)ctx.ro_image;
> >       prog->jited =3D 1;
> >       prog->jited_len =3D prog_size;
> >
> > @@ -1610,6 +1663,14 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_=
prog *prog)
> >               bpf_jit_prog_release_other(prog, prog =3D=3D orig_prog ?
> >                                          tmp : orig_prog);
> >       return prog;
> > +
> > +out_free_hdr:
> > +     if (header) {
> > +             bpf_arch_text_copy(&ro_header->size, &header->size,
> > +                                sizeof(header->size));
> > +             bpf_jit_binary_pack_free(ro_header, header);
> > +     }
> > +     goto out_off;
> >  }
> >
> >  bool bpf_jit_supports_kfunc_call(void)
> > @@ -1617,6 +1678,13 @@ bool bpf_jit_supports_kfunc_call(void)
> >       return true;
> >  }
> >
> > +void *bpf_arch_text_copy(void *dst, void *src, size_t len)
> > +{
> > +     if (!aarch64_insn_copy(dst, src, len))
> > +             return ERR_PTR(-EINVAL);
> > +     return dst;
> > +}
> > +
> >  u64 bpf_jit_alloc_exec_limit(void)
> >  {
> >       return VMALLOC_END - VMALLOC_START;
> > @@ -2221,3 +2289,27 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_p=
oke_type poke_type,
> >
> >       return ret;
> >  }
> > +
> > +void bpf_jit_free(struct bpf_prog *prog)
> > +{
> > +     if (prog->jited) {
> > +             struct arm64_jit_data *jit_data =3D prog->aux->jit_data;
> > +             struct bpf_binary_header *hdr;
> > +
> > +             /*
> > +              * If we fail the final pass of JIT (from jit_subprogs),
> > +              * the program may not be finalized yet. Call finalize he=
re
> > +              * before freeing it.
> > +              */
> > +             if (jit_data) {
> > +                     bpf_jit_binary_pack_finalize(prog, jit_data->ro_h=
eader,
> > +                                                  jit_data->header);
> > +                     kfree(jit_data);
> > +             }
> > +             hdr =3D bpf_jit_binary_pack_hdr(prog);
> > +             bpf_jit_binary_pack_free(hdr, NULL);
> > +             WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(prog));
> > +     }
> > +
> > +     bpf_prog_unlock_free(prog);
> > +}
> > --
> > 2.40.1
> >

