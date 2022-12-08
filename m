Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2DF6475EE
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 20:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiLHTFU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 14:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiLHTE5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 14:04:57 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C798092FE0
        for <bpf@vger.kernel.org>; Thu,  8 Dec 2022 11:04:55 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id kw15so6228237ejc.10
        for <bpf@vger.kernel.org>; Thu, 08 Dec 2022 11:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/9jHEdB1ZlGe81I9nd1YveIW0tOWvpGpiZ6p1dHpGk=;
        b=ED0QOR0NmOJbLGbA3MpUkTzZHM0QO6sS8NGjCGxhS65zoeL5C1V6DJzMdtsQxFJt9h
         10Qe3ZtyMkAmxY9UZZj2Bi13HkpJV73yhhZ+tCYmD09knxH5xN7g4GTJDYTiZJUApVF/
         kU5PDv61kfAsRr/Yp8UXo24EUabYJtkb9/fmq5es6+J8WtStvlgnH9yT/7YyJqJhvfsv
         OHLTKq6bKDBleBgB85eF+HuSvwqls0aFjE3icjall7AuANMYdFzzwzouEyjQnBVStzx0
         LW9EH6/z4KlLSAUvx53nyz3+n6l7ffzcOqEQzrNruNdKJqhuptnwKtAPHMFDhWIjqFQZ
         vjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/9jHEdB1ZlGe81I9nd1YveIW0tOWvpGpiZ6p1dHpGk=;
        b=U9P8hLpqOP6/fZujInrWZaKGFgxKbvkPqyeu0ck9A763fQKrPU0w2cn7gaw1kdqSYo
         QfIo+CIchrFYlEH7qaNFH+eGbCOzNYepMKz6cHW50rsATY2ynOOgcjPSoOwLw1p4cKXL
         VRpmrm2dj9+PS2WxVj5730f6Ou0p4ibMCRDK8SW3/9jOdC/OHKG25UWxCz6iI87Bj3uL
         e9avSK2PIi+dZLHvTwjU/h7pOr1cQOvLSozsAv4nHydjlBaFXY+kKKPRG742l3lnAYKs
         UjuByrE/41FviRbEhmq3nBctAKz22WU0lKOaoINBJN/c81+5HBg6ZoCRHB1Zi/j5PTE2
         JpSw==
X-Gm-Message-State: ANoB5plnBt23AZSiXjK+RvPuhtpbno6Q5FXO+jCcXkr+CVnK3izAXw07
        AYRwtR9CD+xRU5e/pEOKte7RyDNY3WPilC8MX7A=
X-Google-Smtp-Source: AA0mqf5iPT3NjoJhM9I1URT0fCscqfnw0UvZzEPlhwmAYLZbwXhsq0pMzQATu8kniYhxbgiTuRQGlBmtvOjZ+jzvzHI=
X-Received: by 2002:a17:906:6403:b0:7b2:9667:241e with SMTP id
 d3-20020a170906640300b007b29667241emr80375187ejm.115.1670526294017; Thu, 08
 Dec 2022 11:04:54 -0800 (PST)
MIME-Version: 1.0
References: <9cfc736f2b45422a50a21b90b94de04b19836682.camel@ericsson.com>
 <Y3d9mYrkWjrkJ9q2@krava> <HE1PR07MB3321F2F4C156BCA6EFD3A3DBBD099@HE1PR07MB3321.eurprd07.prod.outlook.com>
 <b529c3fa5946537f96430d679b9e8a4280f03e4b.camel@ericsson.com>
 <CAEf4Bza8c59wH05pRaBL2hHznFVs0_yWpVy1GHexURu3Ln-a=g@mail.gmail.com>
 <c4a265caf1653412ac88b8e6c56a694a0d50879c.camel@gmail.com>
 <CAEf4BzZt0VCEf-PVK0=aKBzqHHS4EBDiRc0tA23rrC7_amnxDQ@mail.gmail.com>
 <a95d7cae1ba418bac8d024c2590c34849a73472a.camel@gmail.com>
 <CAEf4BzbsxV63=-wET7eXS-He3eKkWnHtokzCak59ctztGn4kqQ@mail.gmail.com>
 <02cbc397cf2ed051bf3f79bbe8e1be07fadb3f10.camel@gmail.com>
 <CAEf4BzbQuxm2PEuLLZ0ydaheK8B1xt5WVXGZBuMfsphU7z=u0Q@mail.gmail.com> <85f83c333f5355c8ac026f835b18d15060725fcb.camel@ericsson.com>
In-Reply-To: <85f83c333f5355c8ac026f835b18d15060725fcb.camel@ericsson.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 8 Dec 2022 11:04:41 -0800
Message-ID: <CAEf4BzbvX54m9VGo0z6i6=AsKHBSjMu7q_M0rYieVdDMRvu4iQ@mail.gmail.com>
Subject: Re: Sv: Bad padding with bpftool btf dump .. format c
To:     =?UTF-8?Q?Per_Sundstr=C3=B6m_XP?= <per.xp.sundstrom@ericsson.com>
Cc:     "eddyz87@gmail.com" <eddyz87@gmail.com>,
        "olsajiri@gmail.com" <olsajiri@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 5, 2022 at 5:54 AM Per Sundstr=C3=B6m XP
<per.xp.sundstrom@ericsson.com> wrote:
>
> On Wed, 2022-11-30 at 15:11 -0800, Andrii Nakryiko wrote:
> > On Wed, Nov 30, 2022 at 3:06 PM Eduard Zingerman <eddyz87@gmail.com> wr=
ote:
> > > On Wed, 2022-11-30 at 14:49 -0800, Andrii Nakryiko wrote:
> > > > On Tue, Nov 29, 2022 at 6:29 PM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
> > > > > On Tue, 2022-11-29 at 16:27 -0800, Andrii Nakryiko wrote:
> > > > > > On Tue, Nov 29, 2022 at 9:38 AM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > > > > > > On Wed, 2022-11-23 at 18:37 -0800, Andrii Nakryiko wrote:
> > > > > > > > On Fri, Nov 18, 2022 at 9:26 AM Per Sundstr=C3=B6m XP
> > > > > > > > <per.xp.sundstrom@ericsson.com> wrote:
> > > > > > > > >
> > > > > > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vanilla =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > > > > struct foo {
> > > > > > > > > > >     struct {
> > > > > > > > > > >         int  aa;
> > > > > > > > > > >         char ab;
> > > > > > > > > > >     } a;
> > > > > > > > > > >     long   :64;
> > > > > > > > > > >     int    :4;
> > > > > > > > > > >     char   b;
> > > > > > > > > > >     short  c;
> > > > > > > > > > > };
> > > > > > > > > > > offsetof(struct foo, c)=3D18
> > > > > > > > > > >
> > > > > > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Custom =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > > > > struct foo {
> > > > > > > > > > >         long: 8;
> > > > > > > > > > >         long: 64;
> > > > > > > > > > >         long: 64;
> > > > > > > > > > >         char b;
> > > > > > > > > > >         short c;
> > > > > > > > > > > };
> > > > > > > > > >
> > > > > > > > > > so I guess the issue is that the first 'long: 8' is pad=
ded to full
> > > > > > > > > > long: 64 ?
> > > > > > > > > >
> > > > > > > > > > looks like btf_dump_emit_bit_padding did not take into =
accout the gap
> > > > > > > > > > on the
> > > > > > > > > > begining of the struct
> > > > > > > > > >
> > > > > > > > > > on the other hand you generated that header file from '=
min_core_btf'
> > > > > > > > > > btf data,
> > > > > > > > > > which takes away all the unused fields.. it might not b=
eeen
> > > > > > > > > > considered as a
> > > > > > > > > > use case before
> > > > > > > > > >
> > > > > > > > > > jirka
> > > > > > > > > >
> > > > > > > > > > That could be the case, but I think the 'emit_bit_paddi=
ng()' will not
> > > > > > > > > > really have a
> > > > > > > > > > lot to do for the non sparse headers ..
> > > > > > > > > >   /Per
> > > > > > > > >
> > > > > > > > > Looks like something like this makes tings a lot better:
> > > > > > > >
> > > > > > > > yep, this helps, though changes output with padding to more=
 verbose
> > > > > > > > version, quite often unnecessarily. I need to thing a bit m=
ore on
> > > > > > > > this, but the way we currently calculate alignment of a typ=
e is not
> > > > > > > > always going to be correct. E.g., just because there is an =
int field,
> > > > > > > > doesn't mean that struct actually has 4-byte alignment.
> > > > > > > >
> > > > > > > > We must take into account natural alignment, but also actua=
l
> > > > > > > > alignment, which might be different due to __attribute__((p=
acked)).
> > > > > > > >
> > > > > > > > Either way, thanks for reporting!
> > > > > > >
> > > > > > > Hi everyone,
> > > > > > >
> > > > > > > I think the fix is simpler:
> > > > > > >
> > > > > > > diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dum=
p.c
> > > > > > > index deb2bc9a0a7b..23a00818854b 100644
> > > > > > > --- a/tools/lib/bpf/btf_dump.c
> > > > > > > +++ b/tools/lib/bpf/btf_dump.c
> > > > > > > @@ -860,7 +860,7 @@ static bool btf_is_struct_packed(const st=
ruct btf *btf, __u32 id,
> > > > > > >
> > > > > > >  static int chip_away_bits(int total, int at_most)
> > > > > > >  {
> > > > > > > -       return total % at_most ? : at_most;
> > > > > > > +       return total > at_most ? at_most : total;
> > > > > > >  }
> > > > > > >
> > > > > > > It changes the order in which btf_dump_emit_bit_padding() pri=
nts field
> > > > > > > sizes. Right now it returns the division remainder on a first=
 call and
> > > > > > > full 'at_most' values at subsequent calls. For this particula=
r example
> > > > > > > the bit offset of 'b' is 136, so the output looks as follows:
> > > > > > >
> > > > > > > struct foo {
> > > > > > >         long: 8;    // first call pad_bits =3D 136 % 64 ? : 6=
4; off_diff -=3D 8;
> > > > > > >         long: 64;   // second call pad_bits =3D 128 % 64 ? : =
64; off_diff -=3D 64; ...
> > > > > > >         long: 64;
> > > > > > >         char b;
> > > > > > >         short c;
> > > > > > > };
> > > > > > >
> > > > > > > This is incorrect, because compiler would always add padding =
between
> > > > > > > the first and second members to account for the second member=
 alignment.
> > > > > > >
> > > > > > > However, my change inverts the order, which avoids the accide=
ntal
> > > > > > > padding and gets the desired output:
> > > > > > >
> > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Custom =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > > > > > struct foo {
> > > > > > >         long: 64;
> > > > > > >         long: 64;
> > > > > > >         char: 8;
> > > > > > >         char b;
> > > > > > >         short c;
> > > > > > > };
> > > > > > > offsetof(struct foo, c)=3D18
> > > > > > >
> > > > > > > =3D=3D=3D BTF offsets =3D=3D=3D
> > > > > > > full   :        'c' type_id=3D6 bits_offset=3D144
> > > > > > > custom :        'c' type_id=3D3 bits_offset=3D144
> > > > > > >
> > > > > > > wdyt?
> > > > > >
> > > > > > There were at least two issues I realized when I was thinking a=
bout
> > > > > > fixing this, and I think you are missing at least one of them.
> > > > > >
> > > > > > 1. Adding `long :xxx` as padding makes struct at least 8-byte a=
ligned.
> > > > > > If the struct originally had a smaller alignment requirement, y=
ou are
> > > > > > now potentially breaking the struct layout by changing its layo=
ut.
> > > > > >
> > > > > > 2. The way btf__align_of() is calculating alignment doesn't wor=
k
> > > > > > correctly for __attribute__((packed)) structs.
> > > > >
> > > > > Missed these point, sorry.
> > > > > On the other hand isn't this information lost in the custom.btf?
> > > > >
> > > > > $ bpftool btf dump file custom.btf
> > > > > [1] STRUCT 'foo' size=3D20 vlen=3D2
> > > > >         'b' type_id=3D2 bits_offset=3D136
> > > > >         'c' type_id=3D3 bits_offset=3D144
> > > > > [2] INT 'char' size=3D1 bits_offset=3D0 nr_bits=3D8 encoding=3DSI=
GNED
> > > > > [3] INT 'short' size=3D2 bits_offset=3D0 nr_bits=3D16 encoding=3D=
SIGNED
> > > > >
> > > > > This has no info that 'foo' had fields of size 'long'. It does no=
t
> > > > > matter for structs used inside BTF because 'bits_offset' is speci=
fied
> > > > > everywhere, but would matter if STRUCT 'foo' is used as a member =
of a
> > > > > non-BTF struct.
> > > >
> > > > Yes, the latter is important, though, right?
> > >
> > > Do you want to do anything about this at the custom BTF creation stag=
e?
> >
> > No, absolutely not. We just need to teach btf_dump.c to not introduce
> > any new alignment requirements while taking advantage of existing
> > ones. We can derive enough information from BTF to achieve this.
> >
> > > E.g. leave one real member / create a synthetic member to force a spe=
cific
> > > struct alignment in the minimized version.
> > >
> > > > So I think ideally we determine "maximum allowable alignment" and u=
se
> > > > that to determine what's the allowable set of padding types is. WDY=
T?
> > >
> > > Yes, I agree.
> > > I think that a change in the btf__align_of() should be minimal, just =
check
> > > if structure is packed and if so return 1, otherwise logic should rem=
ain
> > > unchanged, this would match what LLVM does ([1]).
> > > Also the flip of the order of chip_away_bits() should remain.
> >
> > Let's come up with a few tricky examples trying to break existing
> > logic and then fix it. I suspect just chip_away_bits() changes are not
> > sufficient.
>
> I have been using this python script to produce code that verifies
> offsets for struct members for some various kernel 'btf's.
> It compares the offsets from 'bits_offset' generated with 'bpftool
> btf dump <file>' (without 'format c') and the offsets computed by
> 'gcc' from header files generated with 'format c'.
>
> Use as: './verify_header_offsets.py <path to btf>'
>
> It will by default skip 50% of the members to make it harder for
> bpftool to produce correct offsets (can be changed with environment
> variable "RANDOM_SKIP_MEMBERS=3D<value between 0.0 and 1.0>"
>
> 'clang' does not play well with these big files, so I need to divide
> the generated files into batches. Default is 1000 structs.
> (can be controlled with environment variable 'MAX_STRUCTS')
>

Hi Per,

Your script was very useful and instrumental to get to the final state
of the fixes I just submitted ([0]). Thanks to it I also discovered
for myself mode(byte) and mode(word) attributes, which influences
sizing of enums. All the issues I found were fixed in my patch set.

That said, your script isn't always correct, it seems. I've noticed
that often when there are two structs involved, one of which is
embedded in another as a field, offset assumptions will be incorrect.
I suspect it has something to do with your script modifying nested
struct definition in a way that actually changes its size, but offset
checks don't take this into the account.

I haven't spent time trying to understand or fix it, though. The
script itself is great, and it would be nice to have it in
selftests/bpf available at least for manual testing. So if you can,
please improve it and submit it for inclusion.

Oh, another issue is that sometimes clang will crash due to some
condition violation when related to bitfields. It would be nice to
either avoid this, or at least not spam the output. Please check that
as well.

But overall, I've found multiple issues as I worked on this, so it
definitely was very useful. Thank you!

  [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=3D703071&=
state=3D*

>   /Per
>
>
> ---------- verify_header_offsets.py ------------
> #!/usr/bin/env python3
>
> import os
> import sys
> import time
> import random
> import tempfile
> import subprocess as sp
>
> structs_count =3D {}
> n_files =3D 0
> done =3D False
>
> class AppError(Exception):
>     """
>     Class used for application generated exceptions
>     """
>     pass
>
>
> def shell_cmd(command, **kwargs):
>     print(f"COMMAND: {command}")
>     res =3D sp.run(["bash", "-c", command], **kwargs)
>     if res.returncode !=3D 0:
>         raise AppError(f'shell command "{command} failed')
>     return res
>
>
> def find_struct_members(btf_file):
>     struct_list =3D []
>     members =3D []
>     found =3D False
>     name =3D ""
>
>     res =3D shell_cmd(f"bpftool btf dump file {btf_file}", universal_newl=
ines=3DTrue, stdout=3Dsp.PIPE)
>
>     for line in res.stdout.splitlines():
>         #print(line, flush=3DTrue)
>         if found and line.startswith("\t"):
>             member =3D line.split()[0].replace("'", "")
>             # Get "Error: error recording relocations for <file>.o: Inval=
id argument" in 'bpftool'
>             # for some structs. Skip for now
>             if member in ['(anon)', 'context', 'inflate_state', 'dma_fenc=
e_array', 'net_generic']:
>                 continue
>             bit_offset =3D int(line.split()[2].replace("bits_offset=3D", =
""))
>             bitfield_size =3D int(line.split()[-1].replace("bitfield_size=
=3D", "")) if line.find("bitfield_size") > 0 else 0
>             if random.random() > float(os.environ.get('RANDOM_SKIP_MEMBER=
S', '0.5')):
>                 members.append((member, bitfield_size, bit_offset))
>             else:
>                 # flag skipped members with (0,0) so we can log them late=
r
>                 members.append((member, 0, 0))
>         elif found:
>             found =3D False
>             struct_list.append((name, members))
>             name =3D ""
>             members =3D []
>         if line.find(" STRUCT ") > 0:
>             name =3D line.split()[2].replace("'", "")
>             if name in ["(anon)"]:
>                 continue
>             structs_count[name] =3D structs_count.get(name, 0) + 1
>             found =3D True
>
>     # Due to limitations in "clang" we need to split the
>     # verification into batches
>     split_n_structs =3D int(os.environ.get('MAX_STRUCTS', 1000))
>     structs =3D []
>     batches =3D []
>     for n, struct in enumerate(struct_list):
>         if n and n % split_n_structs =3D=3D 0:
>             batches.append(structs)
>             structs =3D []
>         structs.append(struct)
>
>     batches.append(structs)
>     return batches
>
> def generate_header(dir, btf_file):
>     shell_cmd(f"bpftool btf dump file {btf_file} format c > {dir}/test.h"=
)
>
> def generate_verification_code(dir, btf_file, struct_batch):
>     code =3D ""
>     main_body =3D ""
>
>     code +=3D f'#include "test_{n_files}.h"\n'
>     code +=3D 'int printf(const char *format, ...);\n'
>     code +=3D 'int sprintf(char *str, const char *format, ...);\n'
>     code +=3D '#define offsetof(TYPE, MEMBER) ((long) &((TYPE*)0)->MEMBER=
)\n'
>     for name, members in struct_batch:
>         if  structs_count[name] > 1:
>             # structs seen more than one time will be called 'struct foo_=
__<n>' in
>             # the generated header file. Only that the '<n>' seems arbitr=
ary, so skip
>             # them for now
>             continue
>         if name in ['context']:
>             # for some reason, there are missing structs in the generated=
 header file
>             # skip them
>             continue
>
>         code +=3D f"int __ref_func_struct_{name}() {{\n"
>         code +=3D f"    int ret =3D 0;\n"
>         code +=3D f"    char data[100];\n"
>         for member, bitfield_size, bit_offset in members:
>             if bitfield_size:
>                 code +=3D f'    ret +=3D ((struct {name}*)&data)->{member=
}; /* bit_offset=3D{bit_offset}, bitfield_size=3D{bitfield_size} */\n'
>             else:
>                 if bitfield_size =3D=3D 0 and bit_offset =3D=3D 0:
>                     # Skip verifying non bitfield member at offset 0, wil=
l always be correct
>                     code +=3D f'    /* ret +=3D offsetof(struct {name}, {=
member}); Skipped */\n'
>                     continue
>                 code +=3D f'    ret +=3D offsetof(struct {name}, {member}=
);\n'
>                 main_body +=3D f'    offset =3D offsetof(struct {name}, {=
member});\n'
>                 main_body +=3D f'    sprintf(line, "offsetof(struct {name=
}, {member}) =3D %d", offset);\n'
>                 main_body +=3D f'    printf("%-80.80s %s\\n", line, offse=
t =3D=3D {int(bit_offset/8)} ? "OK" : "Not OK (should be {int(bit_offset/8)=
})");\n'
>         code +=3D "    return ret;\n"
>         code +=3D "}\n"
>     code +=3D 'int main() {\n'
>     code +=3D '#ifdef VERIFY\n'
>     code +=3D '    char line[200];\n'
>     code +=3D '    int offset =3D 0;\n'
>     code +=3D '    int dummy =3D 0;\n'
>     code +=3D      main_body
>     code +=3D '#endif\n'
>     code +=3D '    return 0;\n'
>     code +=3D '}\n'
>     with open(f"{dir}/test_{n_files}.c", "w") as f:
>         f.write(code)
>
> def compile_btf_object(dir, btf_file):
>     shell_cmd(f"cp {dir}/test.h {dir}/test_{n_files}.h")
>     shell_cmd(f"clang -c -I{dir} -ggdb -gdwarf -fpie -target bpf -D__TARG=
ET_ARCH_x86 -o {dir}/test_{n_files}.o {dir}/test_{n_files}.c")
>     shell_cmd(f"bpftool gen min_core_btf {btf_file} {dir}/test.btf {dir}/=
test_{n_files}.o")
>     shell_cmd(f"bpftool btf dump file {dir}/test.btf format c > {dir}/tes=
t_{n_files}.h")
>
> def compile_and_run_verification(dir):
>     shell_cmd(f"gcc -DVERIFY -I{dir} -o {dir}/test_{n_files} {dir}/test_{=
n_files}.c")
>     shell_cmd(f"{dir}/test_{n_files}")
>
> def main():
>     global n_files
>     global done
>     if len(sys.argv) > 1 and os.path.exists(sys.argv[1]):
>         btf_file =3D sys.argv[1]
>         print(f"Verifying btf file {btf_file}", flush=3DTrue)
>         #with tempfile.TemporaryDirectory() as dir:
>         dir=3D"/tmp"
>         try:
>             generate_header(dir, btf_file)
>             for batch in find_struct_members(btf_file):
>                 generate_verification_code(dir, btf_file, batch)
>                 try:
>                    compile_btf_object(dir, btf_file)
>                 except AppError as fault:
>                     print(f"Error: {fault}", file=3Dsys.stderr)
>                     print(f".. ignore ..", file=3Dsys.stderr)
>                     continue
>                 compile_and_run_verification(dir)
>                 if done:
>                    break
>                 n_files +=3D 1
>         except AppError as fault:
>             print(f"Error: {fault}", file=3Dsys.stderr)
>             sys.exit(1)
>
> if __name__ =3D=3D "__main__":
>     main()
>
> >
> > > [1]
> > > https://protect2.fireeye.com/v1/url?k=3D31323334-501cfaf3-313273af-45=
4445554331-e6381a6a39d24e8d&q=3D1&e=3D50f6402e-fdb7-4512-8c16-8ce450e943f7&=
u=3Dhttps%3A%2F%2Fgithub.com%2Feddyz87%2Fllvm-project%2Fblob%2Fmain%2Fllvm%=
2Flib%2FIR%2FDataLayout.cpp%23L764
> > > > > > So we need to fix btf__align_of() first. What btf__align_of() i=
s
> > > > > > calculating right now is a natural alignment requirement if we =
ignore
> > > > > > actual field offsets. This might be useful (at the very least t=
o
> > > > > > determine if the struct is packed or not), so maybe we should h=
ave a
> > > > > > separate btf__natural_align_of() or something along those lines=
?
> > > > > >
> > > > > > And then we need to fix btf_dump_emit_bit_padding() to better h=
andle
> > > > > > alignment and padding rules. This is what Per Sundstr=C3=B6m is=
 trying to
> > > > > > do, I believe, but I haven't carefully thought about his latest=
 code
> > > > > > suggestion.
> > > > > >
> > > > > > In general, the most obvious solution would be to pad with `cha=
r :8;`
> > > > > > everywhere, but that's very ugly and I'd prefer us to have as
> > > > > > "natural" output as possible. That is, only emit strictly neces=
sary
> > > > > > padding fields and rely on natural alignment otherwise.
> > > > > >
> > > > > > >
> > > > > > > > > diff --git a/src/btf_dump.c b/src/btf_dump.c
> > > > > > > > > index 12f7039..a8bd52a 100644
> > > > > > > > > --- a/src/btf_dump.c
> > > > > > > > > +++ b/src/btf_dump.c
> > > > > > > > > @@ -881,13 +881,13 @@ static void btf_dump_emit_bit_paddi=
ng(const
> > > > > > > > > struct btf_dump *d,
> > > > > > > > >                 const char *pad_type;
> > > > > > > > >                 int pad_bits;
> > > > > > > > >
> > > > > > > > > -               if (ptr_bits > 32 && off_diff > 32) {
> > > > > > > > > +               if (align > 4 && ptr_bits > 32 && off_dif=
f > 32) {
> > > > > > > > >                         pad_type =3D "long";
> > > > > > > > >                         pad_bits =3D chip_away_bits(off_d=
iff, ptr_bits);
> > > > > > > > > -               } else if (off_diff > 16) {
> > > > > > > > > +               } else if (align > 2 && off_diff > 16) {
> > > > > > > > >                         pad_type =3D "int";
> > > > > > > > >                         pad_bits =3D chip_away_bits(off_d=
iff, 32);
> > > > > > > > > -               } else if (off_diff > 8) {
> > > > > > > > > +               } else if (align > 1 && off_diff > 8) {
> > > > > > > > >                         pad_type =3D "short";
> > > > > > > > >                         pad_bits =3D chip_away_bits(off_d=
iff, 16);
> > > > > > > > >                 } else {
> > > > > > > > >   /Per
