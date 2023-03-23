Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDC66C5EA8
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 06:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjCWFSa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Mar 2023 01:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjCWFSZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Mar 2023 01:18:25 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9841815C
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 22:18:23 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id i5so34823323eda.0
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 22:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679548702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4vsRq3hegoRiF0Vo4lYUZ6oba2eOGBOBZZU1RvXopo=;
        b=J1wm6FX8W/PL3+0I/z6ObFCP+qc76Eq/wtPlidfVHx74aUQ6BFdV4zEjqDSmSO+/cz
         B66XML6d79ybKoQAjqx2keDDg0wXKylNL6DewdQjBJayiowgXxog5HjJ0QZoqaArjA2k
         ryyFiaqzH5OckPIgKRbEazjhd7YgavLluCIR2TkBec6nrba4YGMEShpKeMsvmDmQaiYD
         fzDW3T+VzoUAEgnLg5FDCbTOtC6ADPbkVMMyFANxJ4JX7AKvMdKSBsZ6aH/URlLWHoU8
         JCNc+426TGLTIhwyHYDOYP2A/YEpkeEgBNWpoYcAWXtdzRbYN9MXtkrL8PsIBAaNvnkv
         J9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679548702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4vsRq3hegoRiF0Vo4lYUZ6oba2eOGBOBZZU1RvXopo=;
        b=4qOUMzxjQzxv4xIWkMoDEyNj5fQFH22kZGEDFOEGZ7D8Hm2gsC9Soz7gh8iXai70In
         JqXI8laMH1h0YTfa87snpsEQnyFcoucK5HhdSfNXI87+mBNPqoR3SWiTJPlcUho55Lxy
         0SJyZhRuJ/abr89pCHRlSpv/cvh2Z6bjs9vBSEBedTJnXcbJ7bsvGlU50r3O5BCGqw24
         JCwYF6adW2JM6AckrsjFPNOeO+c1mb1bA6szZxAbGQtix21Y6RgLv+lXl16gdZU4rUeU
         dyUrDKNxM1xxGhG/eWj0xPgldnZQW/3H3Kk+flCGt/AWA7APJcv+bkotBjxdy3NVBoPP
         eCTw==
X-Gm-Message-State: AO0yUKW+fb2wUnWPD+F6yQhPuotqGW8IFL/Vn5WRf+k5EUlQupKVr8i+
        NgihVMUPnOPVTFRE013BhGcJO95Hh75k3O6XKKA=
X-Google-Smtp-Source: AK7set9i+Qwi8VSrTHdpbzo7oJX2wkan5nRDh/UmIddiBt20BvFJwuZ7+ANchrqH8HshcZ4l3GHv3KBqP2JMhj4WBuQ=
X-Received: by 2002:a17:907:7ba8:b0:92f:b329:cb75 with SMTP id
 ne40-20020a1709077ba800b0092fb329cb75mr2624799ejc.5.1679548701895; Wed, 22
 Mar 2023 22:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <CADvTj4o7ZWUikKwNTwFq0O_AaX+46t_+Ca9gvWMYdWdRtTGeHQ@mail.gmail.com>
In-Reply-To: <CADvTj4o7ZWUikKwNTwFq0O_AaX+46t_+Ca9gvWMYdWdRtTGeHQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 22 Mar 2023 22:18:10 -0700
Message-ID: <CAEf4BzbEaTbEn1j9vLtmS1-8uJf0Bz-8wfmZj8N4Mmedt29nag@mail.gmail.com>
Subject: Re: GCC-BPF triggers double free in libbpf Error: failed to link
 'linked_maps2.bpf.o': Cannot allocate memory (12)
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
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

On Wed, Mar 22, 2023 at 9:26=E2=80=AFPM James Hilliard
<james.hilliard1@gmail.com> wrote:
>
> I'm seeing this gen object error with gcc does not occur in llvm for a
> bpf test(which uses both linked_maps1.c and linked_maps2.c) in
> bpf-next.
>
> I presume there is a bug in GCC which is triggering a double free bug in =
libbpf.
>

Could you somehow share .o files for linked_maps1.c and
linked_maps2.c, so I can try to repro locally?

> GCC gen object failure:
>
> =3D=3D2125110=3D=3D Command:
> /home/buildroot/bpf-next/tools/testing/selftests/bpf/tools/sbin/bpftool
> --debug gen object
> /home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/linked_maps.=
linked1.o
> /home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/linked_maps1=
.bpf.o
> /home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/linked_maps2=
.bpf.o
> =3D=3D2125110=3D=3D
> libbpf: linker: adding object file
> '/home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/linked_maps=
1.bpf.o'...
> libbpf: linker: adding object file
> '/home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/linked_maps=
2.bpf.o'...
> Error: failed to link
> '/home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/linked_maps=
2.bpf.o':
> Cannot allocate memory (12)
> =3D=3D2125110=3D=3D Invalid free() / delete / delete[] / realloc()
> =3D=3D2125110=3D=3D    at 0x484B0C4: free (vg_replace_malloc.c:884)
> =3D=3D2125110=3D=3D    by 0x17F8AB: bpf_linker__free (linker.c:204)
> =3D=3D2125110=3D=3D    by 0x12833C: do_object (gen.c:1608)
> =3D=3D2125110=3D=3D    by 0x12CDAB: cmd_select (main.c:206)
> =3D=3D2125110=3D=3D    by 0x129B53: do_gen (gen.c:2332)
> =3D=3D2125110=3D=3D    by 0x12CDAB: cmd_select (main.c:206)
> =3D=3D2125110=3D=3D    by 0x12DB9E: main (main.c:539)
> =3D=3D2125110=3D=3D  Address 0xda4b420 is 0 bytes after a block of size 0=
 free'd
> =3D=3D2125110=3D=3D    at 0x484B027: free (vg_replace_malloc.c:883)
> =3D=3D2125110=3D=3D    by 0x484D6F8: realloc (vg_replace_malloc.c:1451)
> =3D=3D2125110=3D=3D    by 0x181FA3: extend_sec (linker.c:1117)
> =3D=3D2125110=3D=3D    by 0x182326: linker_append_sec_data (linker.c:1201=
)
> =3D=3D2125110=3D=3D    by 0x1803DC: bpf_linker__add_file (linker.c:453)
> =3D=3D2125110=3D=3D    by 0x12829E: do_object (gen.c:1593)
> =3D=3D2125110=3D=3D    by 0x12CDAB: cmd_select (main.c:206)
> =3D=3D2125110=3D=3D    by 0x129B53: do_gen (gen.c:2332)
> =3D=3D2125110=3D=3D    by 0x12CDAB: cmd_select (main.c:206)
> =3D=3D2125110=3D=3D    by 0x12DB9E: main (main.c:539)
> =3D=3D2125110=3D=3D  Block was alloc'd at
> =3D=3D2125110=3D=3D    at 0x484876A: malloc (vg_replace_malloc.c:392)
> =3D=3D2125110=3D=3D    by 0x484D6EB: realloc (vg_replace_malloc.c:1451)
> =3D=3D2125110=3D=3D    by 0x181FA3: extend_sec (linker.c:1117)
> =3D=3D2125110=3D=3D    by 0x182326: linker_append_sec_data (linker.c:1201=
)
> =3D=3D2125110=3D=3D    by 0x1803DC: bpf_linker__add_file (linker.c:453)
> =3D=3D2125110=3D=3D    by 0x12829E: do_object (gen.c:1593)
> =3D=3D2125110=3D=3D    by 0x12CDAB: cmd_select (main.c:206)
> =3D=3D2125110=3D=3D    by 0x129B53: do_gen (gen.c:2332)
> =3D=3D2125110=3D=3D    by 0x12CDAB: cmd_select (main.c:206)
> =3D=3D2125110=3D=3D    by 0x12DB9E: main (main.c:539)
