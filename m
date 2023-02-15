Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7863E6973A3
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 02:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjBOBbH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 20:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjBOBbG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 20:31:06 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E799834023
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 17:31:04 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id n20so4950570edy.0
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 17:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6Q41dIqbrd7cMm3ExrHotRxkA3O+1ioyBYavlNwC8c=;
        b=OGYVQTGzePRxoYOd+62ViooleiXvQMoHTHKgIb7iwUvBNI0FTvJrH5ALVPijRNgogQ
         /87QbO6jecEmVwVhiSGcOJPgnelFFQvf1wNAWv3Vg0PPicCdP6cKm1dLK48tmLjaz6ZS
         qgqylN00+4OxEHeI4yWXqlqFeTZWpHORgu5U1VE9PC16vFhQHFWU1P0GrtnLPn44atOm
         4iVpZwpAkauzCSLL5ayJHkLtUHVnjnR5GCGLwcMQXl+EuKBfNasWY7obTBP48u6X2ddI
         bGNN6iMjmcdIeQjFNV5KqtzFnCQyy4APSPgAFTzD+T6QejawOZetIzgmBi5rizhipzx/
         wyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6Q41dIqbrd7cMm3ExrHotRxkA3O+1ioyBYavlNwC8c=;
        b=J3Zee82Ut5XWL5m1XvgJCNMPKCNDDGUrQZUQO9FEk4UbmP1ed4A+GO80XmIydYUaBO
         RCrDwniY8vKURZMzxJQK1OrKsZ9TXxLcQcq98GPUMcBX8YL70Lv+RwlnTRaclUsYXOFn
         3A30FjRGNg4OSfuj6jDBT0w+ra45UM6aYxuC/m1uoUT1oAsLiGU6K+2XTOGOFeIQ1Mj6
         saIig0FMMjUuznh3Q7ndl9XXx0n+fGOqlJbhvRksQ0iBaMu/h29D/h6I3pARNAR3bEwI
         748QzVjUECWIYtDmMFDS88bQvETQKDlqkvZDNn5FmKnW0phm4JWq1aB+JvF//NWTpfKf
         u9OA==
X-Gm-Message-State: AO0yUKVB9ArAQEN9hL2ZqihNtLuGixsGU+v4esfH6aYNLTIsYvK+Et2F
        Qu5imqpLY97V5luH9o3ewrOuOlAsRnJoMRcpmaSW9V9S
X-Google-Smtp-Source: AK7set/D9Iw8DkXhqZLcKNI1slSXgjHS7CuUk4zoVTqIZ6IIk30Vc0mrxhQRkGfiq7S2q6ugd573zY02hwdXkS6WT7w=
X-Received: by 2002:a50:a695:0:b0:4ac:b626:378e with SMTP id
 e21-20020a50a695000000b004acb626378emr140189edc.5.1676424663262; Tue, 14 Feb
 2023 17:31:03 -0800 (PST)
MIME-Version: 1.0
References: <CAHF350LaCGPZL_e__5s04PO466eGnA9uM61rc1eQAu-0N8jhJA@mail.gmail.com>
 <CAADnVQ+XNEEj78m-xDgmcsk5hy30nz+gDECht7Ft07DEy_j-gQ@mail.gmail.com> <CAHF350LmbOEDKp+WyUXDYXR18eAsARC1d-2JdvO4G-tiB8FKUg@mail.gmail.com>
In-Reply-To: <CAHF350LmbOEDKp+WyUXDYXR18eAsARC1d-2JdvO4G-tiB8FKUg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 14 Feb 2023 17:30:51 -0800
Message-ID: <CAEf4BzYaVBU=ypTxy+28UJO3ex1equNsjHhdMC=4d=6gy3CSJA@mail.gmail.com>
Subject: Re: Adding map read write API to bpftool gen skeleton sub command.
To:     Dushyant Behl <myselfdushyantbehl@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        palani.kodeswaran@in.ibm.com, sayandes@in.ibm.com
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

On Tue, Feb 7, 2023 at 10:57 PM Dushyant Behl
<myselfdushyantbehl@gmail.com> wrote:
>
> On Fri, Feb 3, 2023 at 10:12 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Jan 31, 2023 at 10:41 PM Dushyant Behl
> > <myselfdushyantbehl@gmail.com> wrote:
> > >
> > > Hi folks,
> > >
> > > I have been testing the use of BTF to generate read/write API on maps
> > > with specific key value types which can be extracted from the BTF
> > > info.
> > > I have already developed a small tool to test this which uses the BTF
> > > information in the ebpf binary to automatically generate map
> > > type-specific CRUD APIs. This can be built on top of the libbpf api i=
n
> > > the sense that it can provide key and value type info and type
> > > checking on top of the existing api.
> >
> > What is 'CRUD APIs' ?
> > Could you give an example of what kind of code will be generated?
>
> Hi Alexei,
>
> By CRUD, I wanted to mean the API for Create, Read, Update and Delete
> functionality on the maps.
> In equivalent terms to libbpf it would be
> bpf_map_<update/lookup/delete>_elem API.
>
> Currently with the generated skeleton users are able to create and load B=
PF
> objects and my idea was to extract actual map key and value types from
> the BTF info
> and provide an API along with the current skeleton to read, update,
> and delete map fields for users.
>
> As an example, I have taken a slightly modified version of a sample
> from the bpftool-gen manpage
>
> $ cat example2_modified.c
>     #include <linux/ptrace.h>
>     #include <linux/bpf.h>
>     #include <bpf/bpf_helpers.h>
>
>     struct my_key_t { int k; };
>     struct my_value_t { long v; };
>
>     struct {
>          __uint(type, BPF_MAP_TYPE_HASH);
>          __uint(max_entries, 128);
>          __type(key, struct my_key_t);
>          __type(value, struct my_value_t);
>      } my_map SEC(".maps");
>
>      SEC("raw_tp/sys_exit")
>      int handle_sys_exit(struct pt_regs *ctx)
>      {
>          struct my_key_t zero;
>          zero.k =3D 0;
>          bpf_map_lookup_elem(&my_map, &zero);
>          return 0;
>       }
>
> Currently the gen-skeleton structure for this program looks like below,
>
> struct example2 {
>     struct bpf_object_skeleton *skeleton;
>     struct bpf_object *obj;
>     struct {
>         struct bpf_map *my_map;
>     } maps;
>     struct {
>         struct bpf_program *handle_sys_exit;
>     } progs;
>     struct {
>         struct bpf_link *handle_sys_exit;
>     } links;
>
>     #ifdef __cplusplus
>     static inline struct example2 *open(const struct
> bpf_object_open_opts *opts =3D nullptr);
>     static inline struct example2 *open_and_load();
>     static inline int load(struct example2 *skel);
>     static inline int attach(struct example2 *skel);
>     static inline void detach(struct example2 *skel);
>     static inline void destroy(struct example2 *skel);
>     static inline const void *elf_bytes(size_t *sz);
>     #endif /* __cplusplus */
> };
>
> The extra code and API I wanted to expose would look something like below=
,
>
> /* types reconstructed from BTF */
> struct my_key_t { int k; };
> struct my_value_t { long v; };
>
> /* Generic read write API */
> static inline void *read_map(bpf_map *m, void *k) {
>  /* read the map and return value */
> }
>
> static inline void write_map(bpf_map *m, void* k, void *v) {
>   /* write the map and return value */
> }
>
> static inline void delete_map(bpf_map *m, void *k) {
>  /* delete the key */
> }
>
> /* Macros for direct access to map type */
> #define READ_MY_MAP(k) read_map(example2->maps.my_map, k)
> #define WRITE_MY_MAP(k,v) write_map(example2->maps.my_map, k, v)
> #define DELETE_MY_MAP(k) read_map(example2->maps.my_map, k)
>
> Currently I have a python utility which I have tested to detect the type =
of a
> BTF object and this is what I generated when I run it on the above exampl=
e,
> it currently outputs json so I am just showing that here
>
> "maps": [{
>   "name": "my_map",
>   "key": {
>     "variable_name": "my_key_t",
>     "kind": "STRUCT",
>      "member": [ {
>         "variable_name": "k",
>         "type_name": "int",
>         "size": 4,
>         "kind": "INT",
>         "input": null
>     }]
>   },
>   "value": {
>     "variable_name": "my_value_t",
>     "kind": "STRUCT",
>      "member": [{
>        "variable_name": "v",
>        "type_name": "long int",
>        "size": 8,
>        "kind": "INT",
>        "input": null
>      }]
>   }
> }]
>
> This is a work in progress and I am unclear if certain type information
> might not be correctly extractable.
>
> Please let me know if this a) clarifies the intent, b) whether this
> feature will be inline
> with bpftool's philosophy and c) whether such additional features will
> be useful.
>

I'm not really convinced, to be honest. Those generic
{read,write,delete}_map helpers are very similar to libbpf's
bpf_map_{lookup,update,delete}_elem(), except they accept fd, which
you can get with bpf_map__fd().

{READ, WRITE, DELETE}_MY_MAP() macros definitely go quite against the
spirit of BPF skeleton.

Also keep in mind that libbpf provides
bpf_map__{lookup,update,delete}_elem() high-level APIs, that take
struct bpf_map * directly. If you want to avoid hard-coding sizes of
key/value, then you can fetch them at runtime with
bpf_map__{key,value}_size().

So in short, all you are trying to do seems pretty doable completely
outside of BPF skeleton.

> Thanks,
> Dushyant
>
> > > Our goal is to ease the development of ebpf user space applications
> > > and was wondering if this feature could be integrated to "bpftool gen
> > > skeleton" sub command.=E2=80=A8I was wondering if you think that such=
 a
> > > feature will be inline with the intent of bpftool and will be of valu=
e
> > > to its users.
> > > I am happy to have more discussion or a meeting on how this could be
> > > approached and implemented and if it would be a good addition to
> > > bpftool.
> > >
> > > Please let me know.
> > >
> > > Thanks,
> > > Dushyant
