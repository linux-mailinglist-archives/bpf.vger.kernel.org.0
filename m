Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00062460EC1
	for <lists+bpf@lfdr.de>; Mon, 29 Nov 2021 07:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbhK2Ggf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Nov 2021 01:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbhK2Gef (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Nov 2021 01:34:35 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6B0C061574
        for <bpf@vger.kernel.org>; Sun, 28 Nov 2021 22:31:18 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id x32so39167106ybi.12
        for <bpf@vger.kernel.org>; Sun, 28 Nov 2021 22:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sn5kRaU8nSrXyQWUcqfLPAbG5mE/JLd3I/G1Tk9mvkI=;
        b=WSCziYrDPEI/A1wBcfEKu1JJPGvqLhaZ+o1Gw5f2vXkaOtQmR+dt084A1wrPwZXbkM
         46V7B8Z7HQZZG5pWeamw6mEP2dtmm8xWgFclxnXdaMHuhq4B7o9GTZPLh7ljF+m7xkTC
         pz9pVW0XWaX5MDy32RUIjVTbQY7jbJ4c7LB/ygp87G8tJpotchGqwkurH72PtJChC0w+
         anntRFWuWc0JqcR8ZWHN822cgseK/zx9Jge24eFs62wHO1splGKkMuRi+SpzRAmj4iSP
         cnxrsD0SrtU//ISYHawqm2yd4f3GEAXBlZRpxiIHFiGW7uCqlG39bQfXC6ubkw8aadiC
         rgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sn5kRaU8nSrXyQWUcqfLPAbG5mE/JLd3I/G1Tk9mvkI=;
        b=bhCtIxbRP0GRBBPtoNToNLSuU4aFfXrgbJPLypaTBFJpfzx4ns7+IwGOaI/GO6U925
         /SLZvn2OFOX9SrftGomkt/6ykGKQ6vz6x5zIbaJc0k3rP9MOxC1dvP8J1o2ciiWdD3kH
         Gw5b46QNfiHSfjPE1RtZuS3DUs2wN4fa9HcT1dTUYjjgmyuU/bs2SAl7Rme1+55zO6+E
         FPhNjwM6RN6TrJaw4J4a/3tFmHYq+eYhMzgXI9POLxH5H8q5T+kMa5zOmMDoxRHGfg1x
         HT1B2E55hgYcYx2IU+I53s+R1X9sLuMn+2PBdyJu/pTfBD1CT7GF/m9/o+C8nWLYs6MD
         QUUQ==
X-Gm-Message-State: AOAM530owQ79u8+4rUbyNsrI8SSNtewj+19bTBUGGUQkOUN4OdiV9LAh
        N5BOOg7kITcRAEpoS2JdQFnqDuNNDIG6KRTG+yx7GHNZyBRz/A==
X-Google-Smtp-Source: ABdhPJxQDhWXv3oJAYy5XW93wZvcyJelsUO4hE6DTg8MNh9SKEIphDK1oP5DWSekAfNUCb3fMM64w+xSY+sTug57zq4=
X-Received: by 2002:a25:6d4:: with SMTP id 203mr32047772ybg.83.1638167477026;
 Sun, 28 Nov 2021 22:31:17 -0800 (PST)
MIME-Version: 1.0
References: <20211128141633.502339-1-hengqi.chen@gmail.com> <20211128141633.502339-2-hengqi.chen@gmail.com>
In-Reply-To: <20211128141633.502339-2-hengqi.chen@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sun, 28 Nov 2021 22:31:05 -0800
Message-ID: <CAEf4BzYPeM3wQGMMd14E8nm=a4R8iMLOEmoSx1O53c-uTnZPWA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] libbpf: Support static initialization of BPF_MAP_TYPE_PROG_ARRAY
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Nov 28, 2021 at 6:17 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> Support static initialization of BPF_MAP_TYPE_PROG_ARRAY with a
> syntax similar to map-in-map initialization ([0]):
>
>     SEC("socket")
>     int tailcall_1(void *ctx)
>     {
>         return 0;
>     }
>
>     struct {
>         __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
>         __uint(max_entries, 2);
>         __uint(key_size, sizeof(__u32));
>         __array(values, int (void *));
>     } prog_array_init SEC(".maps") = {
>         .values = {
>             [1] = (void *)&tailcall_1,
>         },
>     };
>
> Here's the relevant part of libbpf debug log showing what's
> going on with prog-array initialization:
>
> libbpf: sec '.relsocket': collecting relocation for section(3) 'socket'
> libbpf: sec '.relsocket': relo #0: insn #2 against 'prog_array_init'
> libbpf: prog 'entry': found map 0 (prog_array_init, sec 4, off 0) for insn #0
> libbpf: .maps relo #0: for 3 value 0 rel->r_offset 32 name 53 ('tailcall_1')
> libbpf: .maps relo #0: map 'prog_array_init' slot [1] points to prog 'tailcall_1'
> libbpf: map 'prog_array_init': created successfully, fd=5
> libbpf: map 'prog_array_init': slot [1] set to prog 'tailcall_1' fd=6
>
>   [0] Closes: https://github.com/libbpf/libbpf/issues/354
>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 139 ++++++++++++++++++++++++++++++++---------
>  1 file changed, 111 insertions(+), 28 deletions(-)
>

[...]

> -               targ_map = bpf_object__find_map_by_name(obj, name);
> -               if (!targ_map)
> -                       return -ESRCH;
> +               if (is_map_in_map) {
> +                       targ_map = bpf_object__find_map_by_name(obj, name);
> +                       if (!targ_map)
> +                               return -ESRCH;
> +               }
> +               if (is_prog_array) {
> +                       targ_prog = bpf_object__find_program_by_name(obj, name);
> +                       if (!targ_prog)
> +                               return -ESRCH;
> +                       if (targ_prog->sec_idx != sym->st_shndx ||
> +                           targ_prog->sec_insn_off * 8 != sym->st_value ||
> +                           prog_is_subprog(obj, targ_prog)) {
> +                               pr_warn(".maps relo #%d: '%s' isn't an entry-point BPF program\n",
> +                                       i, name);
> +                               return -LIBBPF_ERRNO__RELOC;
> +                       }
> +               }

I've slightly adjusted this part to have an exhaustive if
(is_map_in_map) else if (is_prog_array) else { return -EINVAL; }. I've
also added an error message when someone is trying to put non-BPF
program into BPF_MAP_TYPE_PROG_ARRAY, like this:

  libbpf: .maps relo #0: 'value' isn't a valid program reference

Awesome work, applied to bpf-next, thanks.

>
>                 var = btf__type_by_id(obj->btf, vi->type);
>                 def = skip_mods_and_typedefs(obj->btf, var->type, NULL);
> @@ -6287,10 +6369,10 @@ static int bpf_object__collect_map_relos(struct bpf_object *obj,
>                                (new_sz - map->init_slots_sz) * host_ptr_sz);
>                         map->init_slots_sz = new_sz;
>                 }
> -               map->init_slots[moff] = targ_map;
> +               map->init_slots[moff] = is_map_in_map ? (void *)targ_map : (void *)targ_prog;
>
> -               pr_debug(".maps relo #%d: map '%s' slot [%d] points to map '%s'\n",
> -                        i, map->name, moff, name);
> +               pr_debug(".maps relo #%d: map '%s' slot [%d] points to %s '%s'\n",
> +                        i, map->name, moff, type, name);
>         }
>
>         return 0;
> @@ -7304,6 +7386,7 @@ int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
>         err = err ? : bpf_object__create_maps(obj);
>         err = err ? : bpf_object__relocate(obj, obj->btf_custom_path ? : attr->target_btf_path);
>         err = err ? : bpf_object__load_progs(obj, attr->log_level);
> +       err = err ? : bpf_object_init_prog_arrays(obj);
>
>         if (obj->gen_loader) {
>                 /* reset FDs */
> --
> 2.30.2
