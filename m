Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DEC6C6DD2
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 17:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjCWQiX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Mar 2023 12:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbjCWQiD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Mar 2023 12:38:03 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0073844D
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 09:36:21 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id cn12so43739558edb.4
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 09:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679589379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdLSl+OI5lJMttWg+dYXfKBHDziB9k287UIT/CRq3g4=;
        b=mu5DcnYOitSA57qxWAVvtjhataEig9McSOIZEwM0wk5H9wXINd9rKbqknJdVBo014i
         xUpR+Me+lrpR37CFJ3HtBQln/HHD5nIMKUVQa9zzVBuiXJUY/Bq0UVoh2xbvt8ocKmtV
         Sly9K0m2fKpwnCa7eBu/zwK/9MzCpxc8VpLtzgSZkmOi1ys4DpaHeSp/2lMTw6I9GGlt
         +ohXa8f2FUNw0ovQ9BAmwKL+eep34Iv0neyu2huvu7V50CLIkDEwQzQ+AJ6bUu03ZGYH
         mkXBklDut7QF10EzYoUsJEBTONIyWEvPEqSAjPj1SJRzfcEnFhUmAnBJupsVL5IdFZiT
         lLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679589379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdLSl+OI5lJMttWg+dYXfKBHDziB9k287UIT/CRq3g4=;
        b=aIhJpYQbvSR5+kJueqKcgPWd+/KL9jkNtnxEVhS9U9neQU9XWQu1n6hPSO2q5c13x4
         pt6hyP2RKODxvr4WNFsyG9ONXdwc+rsZrht9rVlrPasmcZSty7ppOJOYZ1wZQ0vMm32V
         2sHDG8nDgvvfPSSgjazVZJ7FqWpDK572nKEupSdma+XRhfRpNudERdSAuXpYtQgCzRfQ
         cX2Iw7WrfNjH8FqD4U6VDBqi29y5z01t8qK+M4y+ezu6SQ2aj01tN9R6sMYswZVdXuY/
         VuKgRJ+wnpZuOwTiYNmOKlVFN2uRBAKRdOog1aFu6UI6pXBZM1JRFa23myiM14/YmKwa
         KIpA==
X-Gm-Message-State: AO0yUKVONWKUuvqdAZyK+JWrNWTCLnOcuLyYXb8M8cQXwd+te3Qmy9XU
        Z3qBqlGIQSqA8EeOe+SYUfFY9GQo5+z3tBqS8mCHC/fH
X-Google-Smtp-Source: AK7set+qkkid+Yi8Jj98xkgDEgxAiKT5Nw6VmbLRIx4yOAGtYMDROQ0WLOIRuZBozl/CGTTiigjhU7RxSqJVAh/MTeM=
X-Received: by 2002:a17:906:148d:b0:92d:591f:645f with SMTP id
 x13-20020a170906148d00b0092d591f645fmr5737438ejc.5.1679589379273; Thu, 23 Mar
 2023 09:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <CADvTj4o7ZWUikKwNTwFq0O_AaX+46t_+Ca9gvWMYdWdRtTGeHQ@mail.gmail.com>
 <CAEf4BzbEaTbEn1j9vLtmS1-8uJf0Bz-8wfmZj8N4Mmedt29nag@mail.gmail.com> <c55f31dc3ae7e346e2a6d16d3e467e5460346b91.camel@gmail.com>
In-Reply-To: <c55f31dc3ae7e346e2a6d16d3e467e5460346b91.camel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 23 Mar 2023 09:36:07 -0700
Message-ID: <CAEf4BzZ-x4U5NM7wsCcuESGXkoBbf_pk3CwJzA+gsj=WLwHSkQ@mail.gmail.com>
Subject: Re: GCC-BPF triggers double free in libbpf Error: failed to link
 'linked_maps2.bpf.o': Cannot allocate memory (12)
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        bpf <bpf@vger.kernel.org>
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

On Thu, Mar 23, 2023 at 5:57=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2023-03-22 at 22:18 -0700, Andrii Nakryiko wrote:
> > On Wed, Mar 22, 2023 at 9:26=E2=80=AFPM James Hilliard
> > <james.hilliard1@gmail.com> wrote:
> > >
> > > I'm seeing this gen object error with gcc does not occur in llvm for =
a
> > > bpf test(which uses both linked_maps1.c and linked_maps2.c) in
> > > bpf-next.
> > >
> > > I presume there is a bug in GCC which is triggering a double free bug=
 in libbpf.
> > >
> >
> > Could you somehow share .o files for linked_maps1.c and
> > linked_maps2.c, so I can try to repro locally?
>
> Looking at the stack trace, second free is reported here:
>
>   void bpf_linker__free(struct bpf_linker *linker)
>   {
>         ...
>         for (i =3D 1; i < linker->sec_cnt; i++) {
>                 ...
>                 free(sec->sec_name);
> here -->        free(sec->raw_data);
>                 free(sec->sec_vars);
>                 ...
>         }
>         ...
>   }
>
> And first free is reported here:
>
>   static int extend_sec(struct bpf_linker *linker, struct dst_sec *dst, s=
truct src_sec *src)
>   {
>         ...
>         dst_align =3D dst->shdr->sh_addralign;
>         src_align =3D src->shdr->sh_addralign;
>         ...
>
>         dst_align_sz =3D (dst->sec_sz + dst_align - 1) / dst_align * dst_=
align;
>
>         /* no need to re-align final size */
>         dst_final_sz =3D dst_align_sz + src->shdr->sh_size;
>
>         if (src->shdr->sh_type !=3D SHT_NOBITS) {
> here -->        tmp =3D realloc(dst->raw_data, dst_final_sz);
>                 if (!tmp)
>                         return -ENOMEM;
>                 dst->raw_data =3D tmp;
>                 ...
>         }
>         ...
>   }
>
> The documentation says that `realloc(ptr, 0)` frees `ptr`.
> So, I assume that issue is caused by handling of empty sections.

yep, thanks for repro steps! It's a quite interesting behavior. There
are two reallocs involved:

First, dst->raw_data is NULL, dst_final_sz is 0, realloc succeeds and
returns non-NULL pointer (which according to documentation can be
freed with free()). All good.

Second one, for second file, we have non-NULL dst->raw_data returned
from previous realloc(), we pass it to realloc() with dst_final_sz
still 0. But *NOW* we get NULL as a return (and original special
pointer "helpfully" freed for us). This we handle as -ENOMEM and exit.

Amazingly non-error-prone behavior, of course.

> This is easy to test using object files produced by LLVM:
>
>   $ touch empty
>   $ llvm-objcopy --add-section .foobar=3Dempty linked_maps1.bpf.o
>   $ llvm-objcopy --add-section .foobar=3Dempty linked_maps2.bpf.o
>   $ bpftool --debug gen object linked_maps.linked1.o linked_maps1.bpf.o l=
inked_maps2.bpf.o
>   libbpf: linker: adding object file 'linked_maps1.bpf.o'...
>   libbpf: linker: adding object file 'linked_maps2.bpf.o'...
>   Error: failed to link 'linked_maps2.bpf.o': Cannot allocate memory (12)
>   free(): double free detected in tcache 2
>   Aborted (core dumped)
>
> The valgrind output also matches the one attached to the original email.
> Something like below fixes it:
>
> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index d7069780984a..ff3833e55c55 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c
> @@ -1113,7 +1113,7 @@ static int extend_sec(struct bpf_linker *linker, st=
ruct dst_sec *dst, struct src
>         /* no need to re-align final size */
>         dst_final_sz =3D dst_align_sz + src->shdr->sh_size;
>
> -       if (src->shdr->sh_type !=3D SHT_NOBITS) {
> +       if (dst_final_sz !=3D 0 && src->shdr->sh_type !=3D SHT_NOBITS) {
>                 tmp =3D realloc(dst->raw_data, dst_final_sz);
>                 if (!tmp)

let's maybe document this quirk instead of preventing realloc() call:

/* comment here explaining the quirks of realloc() API and it's
inconsistent runtime behavior */
if (!tmp && dst_final_sz > 0)
  return -ENOMEM;

Eduard, are you going to send a proper patch for this? Thanks!

>                         return -ENOMEM;
>
>
> BPF selftests are passing for me with this change,
> objcopy-based reproducer no longer reports error.
> WDYT?
>
> James, could you please test this patch with bpf-gcc?
> (you will have to re-compile libbpf and bpftool,
>  I had to separately do `make -C tools/bpf/bpftool`
>  before re-building selftests for some reason)
>
> Thanks,
> Eduard
>
> >
> > > GCC gen object failure:
> > >
> > > =3D=3D2125110=3D=3D Command:
> > > /home/buildroot/bpf-next/tools/testing/selftests/bpf/tools/sbin/bpfto=
ol
> > > --debug gen object
> > > /home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/linked_m=
aps.linked1.o
> > > /home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/linked_m=
aps1.bpf.o
> > > /home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/linked_m=
aps2.bpf.o
> > > =3D=3D2125110=3D=3D
> > > libbpf: linker: adding object file
> > > '/home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/linked_=
maps1.bpf.o'...
> > > libbpf: linker: adding object file
> > > '/home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/linked_=
maps2.bpf.o'...
> > > Error: failed to link
> > > '/home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/linked_=
maps2.bpf.o':
> > > Cannot allocate memory (12)
> > > =3D=3D2125110=3D=3D Invalid free() / delete / delete[] / realloc()
> > > =3D=3D2125110=3D=3D    at 0x484B0C4: free (vg_replace_malloc.c:884)
> > > =3D=3D2125110=3D=3D    by 0x17F8AB: bpf_linker__free (linker.c:204)
> > > =3D=3D2125110=3D=3D    by 0x12833C: do_object (gen.c:1608)
> > > =3D=3D2125110=3D=3D    by 0x12CDAB: cmd_select (main.c:206)
> > > =3D=3D2125110=3D=3D    by 0x129B53: do_gen (gen.c:2332)
> > > =3D=3D2125110=3D=3D    by 0x12CDAB: cmd_select (main.c:206)
> > > =3D=3D2125110=3D=3D    by 0x12DB9E: main (main.c:539)
> > > =3D=3D2125110=3D=3D  Address 0xda4b420 is 0 bytes after a block of si=
ze 0 free'd
> > > =3D=3D2125110=3D=3D    at 0x484B027: free (vg_replace_malloc.c:883)
> > > =3D=3D2125110=3D=3D    by 0x484D6F8: realloc (vg_replace_malloc.c:145=
1)
> > > =3D=3D2125110=3D=3D    by 0x181FA3: extend_sec (linker.c:1117)
> > > =3D=3D2125110=3D=3D    by 0x182326: linker_append_sec_data (linker.c:=
1201)
> > > =3D=3D2125110=3D=3D    by 0x1803DC: bpf_linker__add_file (linker.c:45=
3)
> > > =3D=3D2125110=3D=3D    by 0x12829E: do_object (gen.c:1593)
> > > =3D=3D2125110=3D=3D    by 0x12CDAB: cmd_select (main.c:206)
> > > =3D=3D2125110=3D=3D    by 0x129B53: do_gen (gen.c:2332)
> > > =3D=3D2125110=3D=3D    by 0x12CDAB: cmd_select (main.c:206)
> > > =3D=3D2125110=3D=3D    by 0x12DB9E: main (main.c:539)
> > > =3D=3D2125110=3D=3D  Block was alloc'd at
> > > =3D=3D2125110=3D=3D    at 0x484876A: malloc (vg_replace_malloc.c:392)
> > > =3D=3D2125110=3D=3D    by 0x484D6EB: realloc (vg_replace_malloc.c:145=
1)
> > > =3D=3D2125110=3D=3D    by 0x181FA3: extend_sec (linker.c:1117)
> > > =3D=3D2125110=3D=3D    by 0x182326: linker_append_sec_data (linker.c:=
1201)
> > > =3D=3D2125110=3D=3D    by 0x1803DC: bpf_linker__add_file (linker.c:45=
3)
> > > =3D=3D2125110=3D=3D    by 0x12829E: do_object (gen.c:1593)
> > > =3D=3D2125110=3D=3D    by 0x12CDAB: cmd_select (main.c:206)
> > > =3D=3D2125110=3D=3D    by 0x129B53: do_gen (gen.c:2332)
> > > =3D=3D2125110=3D=3D    by 0x12CDAB: cmd_select (main.c:206)
> > > =3D=3D2125110=3D=3D    by 0x12DB9E: main (main.c:539)
>
