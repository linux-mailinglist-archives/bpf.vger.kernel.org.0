Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE87B67C115
	for <lists+bpf@lfdr.de>; Thu, 26 Jan 2023 00:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjAYXnV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 18:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjAYXnU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 18:43:20 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054794683
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 15:42:46 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h12so155740wrv.10
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 15:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8xwu0i7Pazb4x37f9xfx5kewaY3HywfhzIcK5366RL0=;
        b=m0rc2+jfdsLPVCiN6UVEaZ+1Yu7bFLIS8XmrDDyHKyvbrwhSR6mYq5Ri2SgMpvd1wc
         5Rs9//iKowPQWPnpzRCueFW7FgrIXm905jRwv/G7myCTgOvpWH156xebNMHkGaLPqnZS
         s2bDqkYaLq73xtoAJrhY7TpXYCSVaIgzWVIBwAyUpXkRlv4WpgOz2hsYgyKQ5OmSswhh
         MZFI0P3WuhcTKoqlG3kfuPnylZAuzflH0rNvmmhh6pCk5nFj+S6qJCnELD4+hkOkFqRK
         MhBw1eRPGwZPfVADwSjUCDJOzILiywUqsgiLDGASIkFfIUSuVoC+GzuK//sEgJ1evxk5
         1b0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8xwu0i7Pazb4x37f9xfx5kewaY3HywfhzIcK5366RL0=;
        b=u1F4zewFKjkbNdTUZsacXu+AjthEEhuvfiFE4T7gLt67+R6AXjYjwxwf+Xq/HmPomq
         aCk2fow+MemLzSDF8GdKnbFcbKdVkkp750Zd9z+cWzAKEdOCVWxnJsZC6AXXwjEEQ33/
         JmnTDzpUQSu2QL+nlUjVH/vMQsJfQ4yYGHqnkcNgVTl3DOFxnf7MbVnuRmgQwI0YPaEy
         AWzxa0rc9gLniripQKg55FLxZjKwm6olzTepNGRrh+xyU/ok31RV3i8NiQu8bgMoSzEW
         465CJTqEVBd1wDPyOUaffsSM+FPNHbEJMM427NcRRurwUysvag4V6HyAeLt80ZzCgsIW
         2Miw==
X-Gm-Message-State: AO0yUKXQl1bAUUcVex2rpAixU1BypoKIKMZyOOHnKLOozTYGsYAuDbGc
        0atcEo9RBcxx5h1vz3JFNrQ=
X-Google-Smtp-Source: AK7set+9/ofy/1lJVMW5ndEjT0pamMKPS1nyPTIHYIby1fSn6u+uWb4guYOLNn11ldiEF5LV+V6P2w==
X-Received: by 2002:adf:ec0f:0:b0:2bf:b661:87d9 with SMTP id x15-20020adfec0f000000b002bfb66187d9mr5021452wrn.50.1674690162835;
        Wed, 25 Jan 2023 15:42:42 -0800 (PST)
Received: from [192.168.1.113] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id v6-20020a5d4b06000000b002bfc2d0eff0sm561198wrq.47.2023.01.25.15.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 15:42:42 -0800 (PST)
Message-ID: <bc50242da1ea8b3b3eafb62e880ed4a278492d2c.camel@gmail.com>
Subject: Re: [PATCH dwarves 1/5] dwarves: help dwarf loader spot functions
 with optimized-out parameters
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Alan Maguire <alan.maguire@oracle.com>, acme@kernel.org,
        yhs@fb.com, ast@kernel.org, olsajiri@gmail.com, timo@incline.eu
Cc:     daniel@iogearbox.net, andrii@kernel.org, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
        haoluo@google.com, martin.lau@kernel.org, bpf@vger.kernel.org
Date:   Thu, 26 Jan 2023 01:42:41 +0200
In-Reply-To: <530ea13a-5229-82a8-d976-b0bc141c3448@oracle.com>
References: <1674567931-26458-1-git-send-email-alan.maguire@oracle.com>
         <1674567931-26458-2-git-send-email-alan.maguire@oracle.com>
         <eb706138246821aafe0f3e88a98933348ba343ac.camel@gmail.com>
         <3ca14d5e-5466-fb4e-b024-01ba33370372@oracle.com>
         <f23eb6cfe20966d7b417f29ec782f78fa0ab93d5.camel@gmail.com>
         <530ea13a-5229-82a8-d976-b0bc141c3448@oracle.com>
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

On Wed, 2023-01-25 at 22:52 +0000, Alan Maguire wrote:
[...]
>=20
> Thanks for this - I tried it, and we spot the optimization once we update
> die__create_new_parameter() as follows:
>=20
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index f96b6ff..605ad45 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -1529,6 +1530,8 @@ static struct tag *die__create_new_parameter(Dwarf_=
Die *di
> =20
>         if (ftype !=3D NULL) {
>                 ftype__add_parameter(ftype, parm);
> +               if (parm->optimized)
> +                       ftype->optimized_parms =3D 1;
>                 if (param_idx >=3D 0) {
>                         if (add_child_llvm_annotations(die, param_idx, co=
nf, &(t
>                                 return NULL;
>=20

Great, looks good.

> With that change, I see:
>=20
> $ pahole --verbose --btf_encode_detached=3Dtest.btf test.o
> btf_encoder__new: 'test.o' doesn't have '.data..percpu' section
> Found 0 per-CPU variables!
> Found 2 functions!
> File test.o:
> [1] INT int size=3D4 nr_bits=3D32 encoding=3DSIGNED
> [2] PTR (anon) type_id=3D3
> [3] PTR (anon) type_id=3D4
> [4] INT char size=3D1 nr_bits=3D8 encoding=3DSIGNED
> [5] FUNC_PROTO (anon) return=3D1 args=3D(1 argc, 2 argv)
> [6] FUNC main type_id=3D5
> added local function 'f', optimized-out params
> skipping addition of 'f' due to optimized-out parameters

Sorry, I have one more silly program.

I talked to Yonghong today and we discussed if compiler can change a
type of a function parameter as a result of some optimization.
Consider the following example:

    $ cat test.c
    struct st {
      int a;
      int b;
    };
   =20
    __attribute__((noinline))
    static int f(struct st *s) {
      return s->a + s->b;
    }
   =20
    int main(int argc, char *argv[]) {
      struct st s =3D {
        .a =3D (long)argv[0],
        .b =3D (long)argv[1]
      };
      return f(&s);
    }

When compiled by `clang` with -O3 the prototype of `f` is changed from
`int f(struct *st)` to `int f(int, int)`:

    $ clang -O3 -g -c test.c -o test.o && llvm-objdump -d test.o
    ...
    0000000000000000 <main>:
           0: 8b 3e                        	movl	(%rsi), %edi
           2: 8b 76 08                     	movl	0x8(%rsi), %esi
           5: eb 09                        	jmp	0x10 <f>
           7: 66 0f 1f 84 00 00 00 00 00   	nopw	(%rax,%rax)
   =20
    0000000000000010 <f>:
          10: 8d 04 37                     	leal	(%rdi,%rsi), %eax
          13: c3                           	retq
   =20
But generated DWARF hides this information:

    $ llvm-dwarfdump test.o
    ...
    0x0000005c:   DW_TAG_subprogram
                    DW_AT_low_pc	(0x0000000000000010)
                    DW_AT_high_pc	(0x0000000000000014)
                    DW_AT_frame_base	(DW_OP_reg7 RSP)
                    DW_AT_call_all_calls	(true)
                    DW_AT_name	("f")
                    DW_AT_decl_file	("/home/eddy/work/tmp/test.c")
                    DW_AT_decl_line	(7)
                    DW_AT_prototyped	(true)
                    DW_AT_type	(0x00000074 "int")
   =20
    0x0000006b:     DW_TAG_formal_parameter
                      DW_AT_name	("s")
                      DW_AT_decl_file	("/home/eddy/work/tmp/test.c")
                      DW_AT_decl_line	(7)
                      DW_AT_type	(0x0000009e "st *")
   =20
    0x00000073:     NULL
    ...

Is this important?
(gcc does not do this for the particular example, but I don't know if
 it could be tricked to under some conditions).

Thanks,
Eduard

[...]
