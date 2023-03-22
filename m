Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2C76C59A0
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 23:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjCVWxu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 18:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjCVWxt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 18:53:49 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D5429E21
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 15:53:46 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id cy23so79194509edb.12
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 15:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679525625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aalP+mrXC8ka8Cn/RCiZ15O9/uhHMuDDpy7O85LUhVg=;
        b=KsMoGzA+rNURG0kBE1pv6GAurxXnoFQR290uADmLkhujlr5+K6ba8fSvKZSqwmG6Ec
         V4KPRGfEFhPcyquyR3zhNcn0/v+Q/O6bTPUTCzBQHvDuSOArN6plKf03589Ox7Cut70X
         HthwZXHVaGLPogqXkv8xMJUNRQ8MtZPcRJ4/DXD75ZF+b8N5xzzZYt+4cGVoDaDzPqf+
         yUhLZ/TRTGpxhDkggJMenDxU5VGeUZXvpLumkTuqSx5YzSeBLommbkiRIbDuZW4us56f
         dgnYkjlLOUGcfjgK+tUxRCPGB6qDef9X3h9pXxlsAaKZ+vawNf46+nPXX8vtu817ND7R
         i1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679525625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aalP+mrXC8ka8Cn/RCiZ15O9/uhHMuDDpy7O85LUhVg=;
        b=VdLSY00pqFA4NYijxwphtvQsapnc15cVFG8MFdw3VhVcXn1N9YvzcGotz2e6W57CEE
         WCIopaUo6EEw93YbNQAeW3eNR7F/tOCoXsTFUBLqMOmY3LeeFG6kofb6Tg9szTXs8yZr
         CdnvcTTnj39U32Xfw5R7BcVjZMY2fueiBjgjiFWrSAAwZmIPfqFXGLA3IIuneWZeowA2
         CrRCcnEGDlt+dL09jLl9utrb5wVHMB39SQJw4Yj+jgnlHbrbx16ilhpm9+6mhX08Mh3t
         Yb0qvk2SShlAYCcmg4763LV6pFTRImO43bq7Hp6+gQ5sBTFH//Ca+2kPJnNjZaDw2l8h
         PXwA==
X-Gm-Message-State: AO0yUKXXH4EkVip0/ALVc9liySLTcuTnfW/UBK38CIxrQchZNlSGC55N
        c3eb6tyVKXZFIowxNDGw8ydLmsbb0iRwim6SMfM=
X-Google-Smtp-Source: AK7set+WNl5sCJtoZbBEZOMQeWpEMUpe1zrqxsWcqThHCkSFgu1jDNWFPxhP2nkWlwQnuQzYzgaGSpbpWYgNI2UhvZw=
X-Received: by 2002:a50:9ecb:0:b0:4ab:49b9:686d with SMTP id
 a69-20020a509ecb000000b004ab49b9686dmr4354489edf.1.1679525625192; Wed, 22 Mar
 2023 15:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <176c368f-bcce-4779-8cc9-a8a46d9e517d@kili.mountain>
In-Reply-To: <176c368f-bcce-4779-8cc9-a8a46d9e517d@kili.mountain>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 22 Mar 2023 15:53:33 -0700
Message-ID: <CAEf4BzbF5To2OFt7W2N4tWbTdcyNn40gGW=JY4Mu+m8nR6QpCw@mail.gmail.com>
Subject: Re: [bug report] bpf: add support for open-coded iterator loops
To:     Dan Carpenter <error27@gmail.com>
Cc:     andrii@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 21, 2023 at 1:47=E2=80=AFAM Dan Carpenter <error27@gmail.com> w=
rote:
>
> Hello Andrii Nakryiko,
>
> The patch 06accc8779c1: "bpf: add support for open-coded iterator
> loops" from Mar 8, 2023, leads to the following Smatch static checker
> warning:
>
>         kernel/bpf/verifier.c:6781 process_iter_arg()
>         warn: assigning signed to unsigned: 'meta->iter.spi =3D spi' '(-3=
4),0-268435454'
>
> kernel/bpf/verifier.c
>     6762 static int process_iter_arg(struct bpf_verifier_env *env, int re=
gno, int insn_idx,
>     6763                             struct bpf_kfunc_call_arg_meta *meta=
)
>     6764 {
>     6765         struct bpf_reg_state *regs =3D cur_regs(env), *reg =3D &=
regs[regno];
>     6766         const struct btf_type *t;
>     6767         const struct btf_param *arg;
>     6768         int spi, err, i, nr_slots;
>     6769         u32 btf_id;
>     6770
>     6771         /* btf_check_iter_kfuncs() ensures we don't need to vali=
date anything here */
>     6772         arg =3D &btf_params(meta->func_proto)[0];
>     6773         t =3D btf_type_skip_modifiers(meta->btf, arg->type, NULL=
);        /* PTR */
>     6774         t =3D btf_type_skip_modifiers(meta->btf, t->type, &btf_i=
d);        /* STRUCT */
>     6775         nr_slots =3D t->size / BPF_REG_SIZE;
>     6776
>     6777         spi =3D iter_get_spi(env, reg, nr_slots);
>     6778         if (spi < 0 && spi !=3D -ERANGE)
>                                 ^^^^^^^^^^^^^^
> Assume iter_get_spi() returns -ERANGE
>
>     6779                 return spi;
>     6780
> --> 6781         meta->iter.spi =3D spi;
>
> meta->iter.spi is a u8.  How is this going to work?  At the very least
> it needs a comment.

The reason why all this works is because this meta->iter.spi field is
used only for iter_next() functions, at which point it is validated by
is_iter_reg_valid_init() to not be an -ERANGE.

But I think I'll just move this part to after the below if, and
-ERANGE is not going to be an allowable case there.

Thanks for pointing this out!

>
>     6782         meta->iter.frameno =3D reg->frameno;
>     6783
>     6784         if (is_iter_new_kfunc(meta)) {
>     6785                 /* bpf_iter_<type>_new() expects pointer to unin=
it iter state */
>     6786                 if (!is_iter_reg_valid_uninit(env, reg, nr_slots=
)) {
>     6787                         verbose(env, "expected uninitialized ite=
r_%s as arg #%d\n",
>     6788                                 iter_type_str(meta->btf, btf_id)=
, regno);
>     6789                         return -EINVAL;
>     6790                 }
>     6791
>     6792                 for (i =3D 0; i < nr_slots * 8; i +=3D BPF_REG_S=
IZE) {
>     6793                         err =3D check_mem_access(env, insn_idx, =
regno,
>     6794                                                i, BPF_DW, BPF_WR=
ITE, -1, false);
>     6795                         if (err)
>     6796                                 return err;
>     6797                 }
>     6798
>     6799                 err =3D mark_stack_slots_iter(env, reg, insn_idx=
, meta->btf, btf_id, nr_slots);
>     6800                 if (err)
>     6801                         return err;
>     6802         } else {
>     6803                 /* iter_next() or iter_destroy() expect initiali=
zed iter state*/
>     6804                 if (!is_iter_reg_valid_init(env, reg, meta->btf,=
 btf_id, nr_slots)) {
>     6805                         verbose(env, "expected an initialized it=
er_%s as arg #%d\n",
>     6806                                 iter_type_str(meta->btf, btf_id)=
, regno);
>     6807                         return -EINVAL;
>     6808                 }
>     6809
>     6810                 err =3D mark_iter_read(env, reg, spi, nr_slots);
>
> If spi is -ERANGE here then it leads to an array underflow.

-ERANGE can't happen because is_iter_reg_valid_init() will reject it first.

>
>     6811                 if (err)
>     6812                         return err;
>     6813
>     6814                 meta->ref_obj_id =3D iter_ref_obj_id(env, reg, s=
pi);
>     6815
>     6816                 if (is_iter_destroy_kfunc(meta)) {
>     6817                         err =3D unmark_stack_slots_iter(env, reg=
, nr_slots);
>     6818                         if (err)
>     6819                                 return err;
>     6820                 }
>     6821         }
>     6822
>     6823         return 0;
>     6824 }
>
> regards,
> dan carpenter
