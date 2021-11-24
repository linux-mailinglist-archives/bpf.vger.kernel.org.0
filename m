Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE2445CD0D
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 20:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242949AbhKXTUP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Nov 2021 14:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241789AbhKXTUP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Nov 2021 14:20:15 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24378C061574
        for <bpf@vger.kernel.org>; Wed, 24 Nov 2021 11:17:05 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id e136so10197002ybc.4
        for <bpf@vger.kernel.org>; Wed, 24 Nov 2021 11:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cqy/gIRhIUtb9FUcntIGIXwgGW7PSZzk3kSoZhcuNhg=;
        b=L/f1hFvxuoRr+kpJoiweKDRsw9TIywYEnSoQhbQdsLHwrA6ba4lK88iV9Qmh1c6X5z
         Cg3apRFmsXseOf0boRzXGCBD1gGnlxaK9W07RtKtBM/hJP4qFj3dxcV+impDdzLGzfxc
         fTyTCiLws93aUc5ivTO199TbJPjZOnKacdutvC4su4DUUjj3MqLsG+2VgKzKvnhUzVfn
         3gZk96rfDSEtA9Vqv/nhoVKpGML27yNx8+CxrY33JkP9KbYZnkLVh03yiTHSR9qY5g/y
         Jsw6wC634WiBScpBfgEZ6osmPAQGRaXdlr9LP5cNNd2B7iqP69geTeIP6WW71et2hVfR
         iwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cqy/gIRhIUtb9FUcntIGIXwgGW7PSZzk3kSoZhcuNhg=;
        b=pubId9WJwXDpJ8Z2SN6tlfSBxBZ/Wh9BqQKHlLPGHYVg2uLaQpMnDN7v0orJVpm5Fj
         NvdsigU8pzJOjIa5Qlk5ua5U9LO3RzCiGL+jZd/1ksGyCTpiJzjWt2EuAURcS27EQ6yD
         w8gV0NqDyD7qUx2ko1bC6r26oPwlL21KTROw+zATfnrJFYNKrppVBjNz4oWOJ7ZuP7Xv
         4Mzayict8Px1PZOpY9pNEJKOwboXlSu7ScZz4ekZb23f9cVTWBxd+1mujG53LkM3hiAl
         1eso6cxiVUkJnDYoXvM3tvLiwVhtsMig9ahusb+q2U52qvWpJCYt7qbxO9VJn7zw7991
         DWxQ==
X-Gm-Message-State: AOAM532D+XA4CycB34fLnpEeedITaHcYLHIEuVLlJ8IOUg97h/VDokje
        Qw9XElBhL4fftinHM8AVC6jXjOsUsASHfjnx0VQ=
X-Google-Smtp-Source: ABdhPJyePC8AvuFZPIxLB4XyVzy334Q+S8+u0pZr0EyoZBDfSruKp0iaTEL/Eox0a0wVxZ8Qao7kp7opIrFUox1Ee3A=
X-Received: by 2002:a25:42c1:: with SMTP id p184mr17334683yba.433.1637781424263;
 Wed, 24 Nov 2021 11:17:04 -0800 (PST)
MIME-Version: 1.0
References: <20211121135440.3205482-1-hengqi.chen@gmail.com>
 <20211121135440.3205482-2-hengqi.chen@gmail.com> <CAEf4BzYMdyxe6yLw6Y4XFkN-b1xsyjs9onvvOZXvpAE1KwPgoA@mail.gmail.com>
 <961ce3c0-d231-969b-2535-de57f01867ce@gmail.com>
In-Reply-To: <961ce3c0-d231-969b-2535-de57f01867ce@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 24 Nov 2021 11:16:53 -0800
Message-ID: <CAEf4Bza3iQL7Z2A2vOQxrAfqf1q_yeBWRr9Uad0BY+4kbip0jw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: Support static initialization of BPF_MAP_TYPE_PROG_ARRAY
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 24, 2021 at 8:13 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> Hi, Andrii
>
> On 11/23/21 11:28 AM, Andrii Nakryiko wrote:
> > On Sun, Nov 21, 2021 at 5:55 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
> >>
> >> Support static initialization of BPF_MAP_TYPE_PROG_ARRAY with a
> >> syntax similar to map-in-map initialization ([0]):
> >>
> >>     SEC("socket")
> >>     int tailcall_1(void *ctx)
> >>     {
> >>         return 0;
> >>     }
> >>
> >>     struct {
> >>         __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
> >>         __uint(max_entries, 2);
> >>         __uint(key_size, sizeof(__u32));
> >>         __array(values, int (void *));
> >>     } prog_array_init SEC(".maps") = {
> >>         .values = {
> >>             [1] = (void *)&tailcall_1,
> >>         },
> >>     };
> >>
> >> Here's the relevant part of libbpf debug log showing what's
> >> going on with prog-array initialization:
> >>
> >> libbpf: sec '.relsocket': collecting relocation for section(3) 'socket'
> >> libbpf: sec '.relsocket': relo #0: insn #2 against 'prog_array_init'
> >> libbpf: prog 'entry': found map 0 (prog_array_init, sec 4, off 0) for insn #0
> >> libbpf: .maps relo #0: for 3 value 0 rel->r_offset 32 name 53 ('tailcall_1')
> >> libbpf: .maps relo #0: map 'prog_array_init' slot [1] points to prog 'tailcall_1'
> >> libbpf: map 'prog_array_init': created successfully, fd=5
> >> libbpf: map 'prog_array_init': slot [1] set to prog 'tailcall_1' fd=6
> >>
> >>   [0] Closes: https://github.com/libbpf/libbpf/issues/354
> >>
> >> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> >> ---
> >>  tools/lib/bpf/libbpf.c | 146 ++++++++++++++++++++++++++++++++++-------
> >>  1 file changed, 122 insertions(+), 24 deletions(-)
> >>
> >
> > Just a few nits and suggestions below, but it looks great overall, thanks!
> >
> > [...]
> >
> >>                         t = skip_mods_and_typedefs(btf, btf_array(t)->type, NULL);
> >>                         if (!btf_is_ptr(t)) {
> >> -                               pr_warn("map '%s': map-in-map inner def is of unexpected kind %s.\n",
> >> -                                       map_name, btf_kind_str(t));
> >> +                               if (is_map_in_map)
> >> +                                       pr_warn("map '%s': map-in-map inner def is of unexpected kind %s.\n",
> >> +                                               map_name, btf_kind_str(t));
> >> +                               else
> >> +                                       pr_warn("map '%s': prog-array value def is of unexpected kind %s.\n",
> >
> > maybe let's do
> >
> > const char *desc = is_map_in_map ? "map-in-map inner" : "prog-array value";
> >
> > and use desc in those three pr_warn() messages?
> >
>
> Ack.
>
> >> +                                               map_name, btf_kind_str(t));
> >>                                 return -EINVAL;
> >>                         }
> >>                         t = skip_mods_and_typedefs(btf, t->type, NULL);
> >> -                       if (!btf_is_struct(t)) {
> >> +                       if (is_prog_array) {
> >> +                               if (btf_is_func_proto(t))
> >> +                                       return 0;
> >
> > you can't return on success here, there could technically be other
> > fields after "values". Can you please also invert the condition so
> > that error handling happens first and then we continue:
> >
> According to the original code ([0]), the "values" field is intended to be
>
> the last field ?

yeah, but we don't need to make this assumption here and exit early,
given the other code doesn't do that. Let's not try to shoot ourselves
in the foot unnecessarily.

>
> > if (!btf_is_func_proto(t)) {
> >     pr_warn(..);
> >     return -EINVAl;
> > }
> > continue;
> >
> > It's more consistent with the other logic in this function
> >
> >

[...]

> >> @@ -6229,8 +6304,20 @@ static int bpf_object__collect_map_relos(struct bpf_object *obj,
> >>                         return -EINVAL;
> >>                 }
> >>
> >> -               if (!bpf_map_type__is_map_in_map(map->def.type))
> >> +               is_map_in_map = bpf_map_type__is_map_in_map(map->def.type);
> >> +               is_prog_array = map->def.type == BPF_MAP_TYPE_PROG_ARRAY;
> >> +               if (!is_map_in_map && !is_prog_array)
> >>                         return -EINVAL;
> >> +               if (is_map_in_map && sym->st_shndx != obj->efile.btf_maps_shndx) {
> >> +                       pr_warn(".maps relo #%d: '%s' isn't a BTF-defined map\n",
> >> +                               i, name);
> >> +                       return -LIBBPF_ERRNO__RELOC;
> >> +               }
> >> +               if (is_prog_array && !bpf_object__find_program_by_name(obj, name)) {
> >
> > let's do an additional check on the program you found with find_program_by_name:
> >
> >   1. prog->sec_idx == sym->st_shndx
> >   2. prog->sec_insn_off * 8 == sym->st_value
> >   3. !prog_is_subprog(obj, prog)
> >
> > This will make sure you have the correct entry-point BPF program (not
> > a subprog) and we point to its beginning (no offset into the program).
> >
> >
>
> OK, will do, maybe we should also add some tests for these cases ?

yeah, negative test validating that you can't put a global variable
and/or a map into the PROG_ARRAY slot would be great, thanks!

>
> >> +                       pr_warn(".maps relo #%d: '%s' isn't a BPF program\n",
> >
> > "entry-point" is an important distinction, please mention that. You
> > can't put sub-programs into PROG_ARRAY.
> >
> >> +                               i, name);
> >> +                       return -LIBBPF_ERRNO__RELOC;
> >> +               }
> >>                 if (map->def.type == BPF_MAP_TYPE_HASH_OF_MAPS &&
> >>                     map->def.key_size != sizeof(int)) {
> >>                         pr_warn(".maps relo #%d: hash-of-maps '%s' should have key size %zu.\n",

[...]
