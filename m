Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226236C68FB
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 13:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjCWM5c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Mar 2023 08:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjCWM5a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Mar 2023 08:57:30 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A062DE43
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 05:57:26 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id h8so86113927ede.8
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 05:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679576244;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HozdraL9QCjIPsENSEJMOQ8DFj52X4v9TiyUZ7myRA0=;
        b=pTgQHvtgxQZxF9ZTD+mO4HEoTOGXCKlwoOL6MTKkkDyHSdWsRJI7UrZFakyO1NymsT
         aObfqbdQeeExMUtsDPCZ1PsbIEOOPf6cp1N1P1hqLNFHxDSbEyGYnNzaD5HMXzoqKSqX
         w0ZTo6KAq7itwpo2XtkjuxoFmKEDk04UbY4b09vlCYKqqhsdWnI+ktRXvVw3gyrtW+bm
         4ewwleUytzAwRAY8yzaVVmiNP8fkr32pt9KlsGEHQHRgeDAydFG4AoWraneGGYqQUZrQ
         yY0C+doNaWJwpLt445/NszY/cEoMEinFVus2cw/JG4Dj98Ye6uG2ucy0zT6+PU6QSBqU
         OCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679576244;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HozdraL9QCjIPsENSEJMOQ8DFj52X4v9TiyUZ7myRA0=;
        b=vbVFeZhUHZnNuzJrJoRfxdPX2o7ZaacRn9Rw99DprDLypb1X3oOtQdUUkjuZQIiQGc
         o3YHb5Fea0mdf3gVSxCzmkYD4CrOYBecVErqwb4HSJx1LS9KDYNVw9sTPtukNO3yjhjp
         YFnWWgwLUqym8VVubIFzoSZugQ5bzDmPK64MTIex3lTdDz/BEnmym82EKgA8RqoeIZQQ
         8RHFBH1qHySY3+b9oZq4e3yNmgOme4hnmXdxOoRBVDTbwHSw+hlyB9r+Aa324K2DFfyQ
         W8TvNB6zf/T30EEZ97+iA+4IgcUN3Hrc8FuHYrg2XG8sY0v5pHpMFSaeZCGW4slL/ycu
         olXg==
X-Gm-Message-State: AO0yUKVn/hDn3HEnGNr4fNsiLRINYJxtKSir4Ly2rNnD+IyyAiBIMvyW
        Z/4txV7MyvqfWCzlOqP7GLQI/dR+X2I=
X-Google-Smtp-Source: AK7set9s1Nz2jJxlW4lcFa9fC0UqA2NcmF9sQA6+cL5KQb0L1df+cGufGhv7iaLpMXelCB7W2XKK+g==
X-Received: by 2002:a17:906:5815:b0:932:9303:76b9 with SMTP id m21-20020a170906581500b00932930376b9mr9482413ejq.26.1679576244536;
        Thu, 23 Mar 2023 05:57:24 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id so8-20020a170907390800b0093d0867a65csm717633ejc.175.2023.03.23.05.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 05:57:24 -0700 (PDT)
Message-ID: <c55f31dc3ae7e346e2a6d16d3e467e5460346b91.camel@gmail.com>
Subject: Re: GCC-BPF triggers double free in libbpf Error: failed to link
 'linked_maps2.bpf.o': Cannot allocate memory (12)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        James Hilliard <james.hilliard1@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Date:   Thu, 23 Mar 2023 14:57:23 +0200
In-Reply-To: <CAEf4BzbEaTbEn1j9vLtmS1-8uJf0Bz-8wfmZj8N4Mmedt29nag@mail.gmail.com>
References: <CADvTj4o7ZWUikKwNTwFq0O_AaX+46t_+Ca9gvWMYdWdRtTGeHQ@mail.gmail.com>
         <CAEf4BzbEaTbEn1j9vLtmS1-8uJf0Bz-8wfmZj8N4Mmedt29nag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2023-03-22 at 22:18 -0700, Andrii Nakryiko wrote:
> On Wed, Mar 22, 2023 at 9:26=E2=80=AFPM James Hilliard
> <james.hilliard1@gmail.com> wrote:
> >=20
> > I'm seeing this gen object error with gcc does not occur in llvm for a
> > bpf test(which uses both linked_maps1.c and linked_maps2.c) in
> > bpf-next.
> >=20
> > I presume there is a bug in GCC which is triggering a double free bug i=
n libbpf.
> >=20
>=20
> Could you somehow share .o files for linked_maps1.c and
> linked_maps2.c, so I can try to repro locally?

Looking at the stack trace, second free is reported here:

  void bpf_linker__free(struct bpf_linker *linker)
  {
        ...
        for (i =3D 1; i < linker->sec_cnt; i++) {
                ...
                free(sec->sec_name);
here -->        free(sec->raw_data);
                free(sec->sec_vars);
                ...
        }
        ...
  }

And first free is reported here:

  static int extend_sec(struct bpf_linker *linker, struct dst_sec *dst, str=
uct src_sec *src)
  {
        ...
        dst_align =3D dst->shdr->sh_addralign;
        src_align =3D src->shdr->sh_addralign;
        ...
 =20
        dst_align_sz =3D (dst->sec_sz + dst_align - 1) / dst_align * dst_al=
ign;
 =20
        /* no need to re-align final size */
        dst_final_sz =3D dst_align_sz + src->shdr->sh_size;
 =20
        if (src->shdr->sh_type !=3D SHT_NOBITS) {
here -->        tmp =3D realloc(dst->raw_data, dst_final_sz);
                if (!tmp)
                        return -ENOMEM;
                dst->raw_data =3D tmp;
                ...
        }
        ...
  }

The documentation says that `realloc(ptr, 0)` frees `ptr`.
So, I assume that issue is caused by handling of empty sections.
This is easy to test using object files produced by LLVM:

  $ touch empty
  $ llvm-objcopy --add-section .foobar=3Dempty linked_maps1.bpf.o
  $ llvm-objcopy --add-section .foobar=3Dempty linked_maps2.bpf.o
  $ bpftool --debug gen object linked_maps.linked1.o linked_maps1.bpf.o lin=
ked_maps2.bpf.o
  libbpf: linker: adding object file 'linked_maps1.bpf.o'...
  libbpf: linker: adding object file 'linked_maps2.bpf.o'...
  Error: failed to link 'linked_maps2.bpf.o': Cannot allocate memory (12)
  free(): double free detected in tcache 2
  Aborted (core dumped)

The valgrind output also matches the one attached to the original email.
Something like below fixes it:

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index d7069780984a..ff3833e55c55 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -1113,7 +1113,7 @@ static int extend_sec(struct bpf_linker *linker, stru=
ct dst_sec *dst, struct src
        /* no need to re-align final size */
        dst_final_sz =3D dst_align_sz + src->shdr->sh_size;
=20
-       if (src->shdr->sh_type !=3D SHT_NOBITS) {
+       if (dst_final_sz !=3D 0 && src->shdr->sh_type !=3D SHT_NOBITS) {
                tmp =3D realloc(dst->raw_data, dst_final_sz);
                if (!tmp)
                        return -ENOMEM;


BPF selftests are passing for me with this change,
objcopy-based reproducer no longer reports error.
WDYT?

James, could you please test this patch with bpf-gcc?
(you will have to re-compile libbpf and bpftool,
 I had to separately do `make -C tools/bpf/bpftool`
 before re-building selftests for some reason)

Thanks,
Eduard

>=20
> > GCC gen object failure:
> >=20
> > =3D=3D2125110=3D=3D Command:
> > /home/buildroot/bpf-next/tools/testing/selftests/bpf/tools/sbin/bpftool
> > --debug gen object
> > /home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/linked_map=
s.linked1.o
> > /home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/linked_map=
s1.bpf.o
> > /home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/linked_map=
s2.bpf.o
> > =3D=3D2125110=3D=3D
> > libbpf: linker: adding object file
> > '/home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/linked_ma=
ps1.bpf.o'...
> > libbpf: linker: adding object file
> > '/home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/linked_ma=
ps2.bpf.o'...
> > Error: failed to link
> > '/home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/linked_ma=
ps2.bpf.o':
> > Cannot allocate memory (12)
> > =3D=3D2125110=3D=3D Invalid free() / delete / delete[] / realloc()
> > =3D=3D2125110=3D=3D    at 0x484B0C4: free (vg_replace_malloc.c:884)
> > =3D=3D2125110=3D=3D    by 0x17F8AB: bpf_linker__free (linker.c:204)
> > =3D=3D2125110=3D=3D    by 0x12833C: do_object (gen.c:1608)
> > =3D=3D2125110=3D=3D    by 0x12CDAB: cmd_select (main.c:206)
> > =3D=3D2125110=3D=3D    by 0x129B53: do_gen (gen.c:2332)
> > =3D=3D2125110=3D=3D    by 0x12CDAB: cmd_select (main.c:206)
> > =3D=3D2125110=3D=3D    by 0x12DB9E: main (main.c:539)
> > =3D=3D2125110=3D=3D  Address 0xda4b420 is 0 bytes after a block of size=
 0 free'd
> > =3D=3D2125110=3D=3D    at 0x484B027: free (vg_replace_malloc.c:883)
> > =3D=3D2125110=3D=3D    by 0x484D6F8: realloc (vg_replace_malloc.c:1451)
> > =3D=3D2125110=3D=3D    by 0x181FA3: extend_sec (linker.c:1117)
> > =3D=3D2125110=3D=3D    by 0x182326: linker_append_sec_data (linker.c:12=
01)
> > =3D=3D2125110=3D=3D    by 0x1803DC: bpf_linker__add_file (linker.c:453)
> > =3D=3D2125110=3D=3D    by 0x12829E: do_object (gen.c:1593)
> > =3D=3D2125110=3D=3D    by 0x12CDAB: cmd_select (main.c:206)
> > =3D=3D2125110=3D=3D    by 0x129B53: do_gen (gen.c:2332)
> > =3D=3D2125110=3D=3D    by 0x12CDAB: cmd_select (main.c:206)
> > =3D=3D2125110=3D=3D    by 0x12DB9E: main (main.c:539)
> > =3D=3D2125110=3D=3D  Block was alloc'd at
> > =3D=3D2125110=3D=3D    at 0x484876A: malloc (vg_replace_malloc.c:392)
> > =3D=3D2125110=3D=3D    by 0x484D6EB: realloc (vg_replace_malloc.c:1451)
> > =3D=3D2125110=3D=3D    by 0x181FA3: extend_sec (linker.c:1117)
> > =3D=3D2125110=3D=3D    by 0x182326: linker_append_sec_data (linker.c:12=
01)
> > =3D=3D2125110=3D=3D    by 0x1803DC: bpf_linker__add_file (linker.c:453)
> > =3D=3D2125110=3D=3D    by 0x12829E: do_object (gen.c:1593)
> > =3D=3D2125110=3D=3D    by 0x12CDAB: cmd_select (main.c:206)
> > =3D=3D2125110=3D=3D    by 0x129B53: do_gen (gen.c:2332)
> > =3D=3D2125110=3D=3D    by 0x12CDAB: cmd_select (main.c:206)
> > =3D=3D2125110=3D=3D    by 0x12DB9E: main (main.c:539)

