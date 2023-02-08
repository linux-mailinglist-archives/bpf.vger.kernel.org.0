Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DA368E84C
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 07:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjBHGby (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 01:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjBHGbw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 01:31:52 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703B91BAC0
        for <bpf@vger.kernel.org>; Tue,  7 Feb 2023 22:31:39 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id j25so12159434wrc.4
        for <bpf@vger.kernel.org>; Tue, 07 Feb 2023 22:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WoksOOVUu45igo/fuPyM6pmsPOmU6qQeiRFAYC/qb+c=;
        b=DoEOxD1xriRoioJ4+GipL08ASzZaW1/OhnQFeuE5w2dzfwbzMXsNyGGKhUM432xZ8I
         Rh1SK2uNWRC6++DcSBRv1CsulGtF9nd1/IwgUw/vWTTAI9JPbJbAzUgRS2B0FZITwhKu
         vlDblk3DOO+JdKqVk3NUJ2ODRTsOerf9+2X0UFDEQNcFR2qprPr3/VE357oQUKum4ORi
         qSqGCuUNgQtbNboV9Mcw8sPisuoQQuM94GwfkKfnoUnvS1di1ATGEzMgG9PjhrmSZztq
         Vg0tiMF2wxa3Yo3Xz5H7yeauuA0b6VcBbV3FHS+6lDSh6jsGYJP8GnHbI/uDXb5sIlGb
         E9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WoksOOVUu45igo/fuPyM6pmsPOmU6qQeiRFAYC/qb+c=;
        b=1ptoRxK7FnsV9izzVxeoPTcCiP1sYgdiEkkMBxToGdAcCUUzWK8Ct8BVtMNM0LXq84
         1HU5S0adNQkO90hkMss6XZDscxhqR9btTmpg7qMK0WPDeULja2vVPwrDJonc3lpvmmvd
         p0EwefdwOKqWujT9VDKn6iMj2ZhE64QkxG1sk/c/3ujiRfhUDsmSSEfgB4xXXmGvSQAT
         3zrVJ3U9zNOoaShbqt48bC/RZuLWd3WHav1w3waivDaPpIiMOnXoDATdw2r5zOXsocGY
         zH1w0ZZV/cWmKnxhj4RdpDABRx2+ulkvLTW2+NZRsmOXDLn1XOHt2dFIUV7OQJnGmakX
         PTxw==
X-Gm-Message-State: AO0yUKX7re+piBzbB6DWddMn9SP+cN9wBeJGPpBvqKdj1fdHQSB1q884
        5Q9PbsthPONKUA/+oiDG43tqC4riWNS7QX5IUhlqfa85vnQ=
X-Google-Smtp-Source: AK7set9kOAmcpjh5WyI6pDQ6ZUJpZ1Md8MTdIjxK/nbmlnnDNjMGx3PyjrgNI5/J1jjcpNf5eP5Xo99fA8T3VdyA2Ss=
X-Received: by 2002:adf:e3cc:0:b0:2c3:ebe6:36b5 with SMTP id
 k12-20020adfe3cc000000b002c3ebe636b5mr153153wrm.58.1675837897946; Tue, 07 Feb
 2023 22:31:37 -0800 (PST)
MIME-Version: 1.0
References: <CAHF350LaCGPZL_e__5s04PO466eGnA9uM61rc1eQAu-0N8jhJA@mail.gmail.com>
 <CAADnVQ+XNEEj78m-xDgmcsk5hy30nz+gDECht7Ft07DEy_j-gQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+XNEEj78m-xDgmcsk5hy30nz+gDECht7Ft07DEy_j-gQ@mail.gmail.com>
From:   Dushyant Behl <myselfdushyantbehl@gmail.com>
Date:   Wed, 8 Feb 2023 12:01:26 +0530
Message-ID: <CAHF350LmbOEDKp+WyUXDYXR18eAsARC1d-2JdvO4G-tiB8FKUg@mail.gmail.com>
Subject: Re: Adding map read write API to bpftool gen skeleton sub command.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Quentin Monnet <quentin@isovalent.com>,
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

On Fri, Feb 3, 2023 at 10:12 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Jan 31, 2023 at 10:41 PM Dushyant Behl
> <myselfdushyantbehl@gmail.com> wrote:
> >
> > Hi folks,
> >
> > I have been testing the use of BTF to generate read/write API on maps
> > with specific key value types which can be extracted from the BTF
> > info.
> > I have already developed a small tool to test this which uses the BTF
> > information in the ebpf binary to automatically generate map
> > type-specific CRUD APIs. This can be built on top of the libbpf api in
> > the sense that it can provide key and value type info and type
> > checking on top of the existing api.
>
> What is 'CRUD APIs' ?
> Could you give an example of what kind of code will be generated?

Hi Alexei,

By CRUD, I wanted to mean the API for Create, Read, Update and Delete
functionality on the maps.
In equivalent terms to libbpf it would be
bpf_map_<update/lookup/delete>_elem API.

Currently with the generated skeleton users are able to create and load BPF
objects and my idea was to extract actual map key and value types from
the BTF info
and provide an API along with the current skeleton to read, update,
and delete map fields for users.

As an example, I have taken a slightly modified version of a sample
from the bpftool-gen manpage

$ cat example2_modified.c
    #include <linux/ptrace.h>
    #include <linux/bpf.h>
    #include <bpf/bpf_helpers.h>

    struct my_key_t { int k; };
    struct my_value_t { long v; };

    struct {
         __uint(type, BPF_MAP_TYPE_HASH);
         __uint(max_entries, 128);
         __type(key, struct my_key_t);
         __type(value, struct my_value_t);
     } my_map SEC(".maps");

     SEC("raw_tp/sys_exit")
     int handle_sys_exit(struct pt_regs *ctx)
     {
         struct my_key_t zero;
         zero.k =3D 0;
         bpf_map_lookup_elem(&my_map, &zero);
         return 0;
      }

Currently the gen-skeleton structure for this program looks like below,

struct example2 {
    struct bpf_object_skeleton *skeleton;
    struct bpf_object *obj;
    struct {
        struct bpf_map *my_map;
    } maps;
    struct {
        struct bpf_program *handle_sys_exit;
    } progs;
    struct {
        struct bpf_link *handle_sys_exit;
    } links;

    #ifdef __cplusplus
    static inline struct example2 *open(const struct
bpf_object_open_opts *opts =3D nullptr);
    static inline struct example2 *open_and_load();
    static inline int load(struct example2 *skel);
    static inline int attach(struct example2 *skel);
    static inline void detach(struct example2 *skel);
    static inline void destroy(struct example2 *skel);
    static inline const void *elf_bytes(size_t *sz);
    #endif /* __cplusplus */
};

The extra code and API I wanted to expose would look something like below,

/* types reconstructed from BTF */
struct my_key_t { int k; };
struct my_value_t { long v; };

/* Generic read write API */
static inline void *read_map(bpf_map *m, void *k) {
 /* read the map and return value */
}

static inline void write_map(bpf_map *m, void* k, void *v) {
  /* write the map and return value */
}

static inline void delete_map(bpf_map *m, void *k) {
 /* delete the key */
}

/* Macros for direct access to map type */
#define READ_MY_MAP(k) read_map(example2->maps.my_map, k)
#define WRITE_MY_MAP(k,v) write_map(example2->maps.my_map, k, v)
#define DELETE_MY_MAP(k) read_map(example2->maps.my_map, k)

Currently I have a python utility which I have tested to detect the type of=
 a
BTF object and this is what I generated when I run it on the above example,
it currently outputs json so I am just showing that here

"maps": [{
  "name": "my_map",
  "key": {
    "variable_name": "my_key_t",
    "kind": "STRUCT",
     "member": [ {
        "variable_name": "k",
        "type_name": "int",
        "size": 4,
        "kind": "INT",
        "input": null
    }]
  },
  "value": {
    "variable_name": "my_value_t",
    "kind": "STRUCT",
     "member": [{
       "variable_name": "v",
       "type_name": "long int",
       "size": 8,
       "kind": "INT",
       "input": null
     }]
  }
}]

This is a work in progress and I am unclear if certain type information
might not be correctly extractable.

Please let me know if this a) clarifies the intent, b) whether this
feature will be inline
with bpftool's philosophy and c) whether such additional features will
be useful.

Thanks,
Dushyant

> > Our goal is to ease the development of ebpf user space applications
> > and was wondering if this feature could be integrated to "bpftool gen
> > skeleton" sub command.=E2=80=A8I was wondering if you think that such a
> > feature will be inline with the intent of bpftool and will be of value
> > to its users.
> > I am happy to have more discussion or a meeting on how this could be
> > approached and implemented and if it would be a good addition to
> > bpftool.
> >
> > Please let me know.
> >
> > Thanks,
> > Dushyant
