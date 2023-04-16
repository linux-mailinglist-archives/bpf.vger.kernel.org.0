Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9FC6E3B23
	for <lists+bpf@lfdr.de>; Sun, 16 Apr 2023 20:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjDPSYK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 16 Apr 2023 14:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjDPSYJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 16 Apr 2023 14:24:09 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855522106
        for <bpf@vger.kernel.org>; Sun, 16 Apr 2023 11:24:08 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-94f0dd117dcso83674466b.3
        for <bpf@vger.kernel.org>; Sun, 16 Apr 2023 11:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681669447; x=1684261447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ooJXs3NI0Q3JSdyOCPzw9FUEEUJZAiCUArD8Yez6874=;
        b=DRgWGP4YggRUuDcbfyFEWEA9/czJe42s6jRFMjm56yWc74Y3iHd7ze5Dx3KCmJxgOI
         LIV+csWP8A4/H8WokbCEcvue/CAbSrah7Buf6X9/6/CiJgiyqiXrjk2/yhk5Ovj+vSJ3
         pCrlSRyLiSM4DfoC9Ar1TaAusht2kikMgYN+wNhgaEdfdjh02A2r6MPG3AdKyxHIXSnD
         lzrWSE25Zju6gZERiiE0mzP+9ztefEbDEw5QOeqpiqaBK43kpgLDhUkG3YU/qdyCozg9
         mGf9CdG8Ih8scqh3WZA0eSM1YFp5v0Uh7wfCXPEvQbsDqV+T8HWNZiHfEcglovLNX2Bk
         0U0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681669447; x=1684261447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ooJXs3NI0Q3JSdyOCPzw9FUEEUJZAiCUArD8Yez6874=;
        b=WKxcPrA7C7oqgHS/NHf3QNsqcfT4FKBvqCsBmOqpzorYvr9abyyrSZdpRqwr5lUUNY
         9mTH7x60xZr1ZeEyjnF6BBIcc5nr7JCrrLYW3gxKU3jiXHuKnyOMugc+idadUy2qt7nB
         zljWCDI8g1HuZiIxxPEFD1loNmcXef+FeGB1GCwEBpYv0YofW3GYqHJPb1/kkK+2lFi/
         CWq7F9/WVazIL9hObcAWMZcsun3T8lQARwLhdXLuErpqKQXllXckbFeVUF4IcgCtPZ1C
         KLtmTIiAor2uXaYa0YLu546Y1bFQO9kEh0gPWmE1TCb65Wig7cRuHHV5McQ+5VcUCkUE
         IX5Q==
X-Gm-Message-State: AAQBX9eqfm/zFaod71quvWfYqBD0njlzfF2kxwW7xRXKDO8Qc3aG9qTS
        US+qXrWe8WFfPm4GSqtMGTM/+TY9phqCGEJaL4k=
X-Google-Smtp-Source: AKy350aDaB3qz75k3Gu+pbVsGmBeOtF9Lb1HuAr1nd4JjeFLP2e8rdQkUrec7WbV42RiO2hWsTrLCY4TJy/2DYCuxfQ=
X-Received: by 2002:a50:9eca:0:b0:506:34d8:c710 with SMTP id
 a68-20020a509eca000000b0050634d8c710mr6023313edf.3.1681669446782; Sun, 16 Apr
 2023 11:24:06 -0700 (PDT)
MIME-Version: 1.0
References: <303b5895-319d-2bb7-9909-10fec3323df2@antgroup.com>
In-Reply-To: <303b5895-319d-2bb7-9909-10fec3323df2@antgroup.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 16 Apr 2023 11:23:55 -0700
Message-ID: <CAADnVQ+3y0mbORnvCYNLdSGZ7hV5Qxskc3L-mTg0SmVpfwHFYQ@mail.gmail.com>
Subject: Re: [RFC] A new bpf map type for fuzzy matching key
To:     =?UTF-8?B?5rKI5a6J55CqKOWHm+eOpSk=?= <amy.saq@antgroup.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        =?UTF-8?B?6LCI6Ym06ZSL?= <henry.tjf@antgroup.com>,
        =?UTF-8?B?5ZGo5by6KOS4reiIqik=?= <shuze.zq@antgroup.com>,
        =?UTF-8?B?5pyx6L6JKOiMtuawtCk=?= <teawater@antgroup.com>,
        =?UTF-8?B?5byg57uq5bOwKOS6keS8ryk=?= <yunbo.zxf@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 15, 2023 at 9:32=E2=80=AFPM =E6=B2=88=E5=AE=89=E7=90=AA(=E5=87=
=9B=E7=8E=A5) <amy.saq@antgroup.com> wrote:
>
>
> Hi everyone,
>
> For supporting fuzzy matching in bpf map as described in the original
> question [0], we come up with a proposal that would like to have some
> advice or comments from bpf thread. Thanks a lot for all the feedback :)
>
> We plan to implement a new bpf map type, naming BPF_FM_MAP, standing for
> fuzzy matching map.
> The basic idea is implementing a trie-tree using map of map runtime
> structure.
>
> The number of tree levels equals to the number of fields in the key
> struct. Assuming that the key struct has M fields, the first (M-1) level
> of tree nodes will be hash maps with key as the value of (M-1)-th field
> and entry as the fd of next level map. The last level, regarded as leaf
> nodes, will be hash maps with key as the value of M-th field and entry
> as user-defined entry for this BPF_FM_MAP.
>
> To support fuzzy matching, we add a special value -1 as (M-1)-th field
> key if (M-1)-th field is set as general match.
>
> When looking up a target key in BPF_FM_MAP, it will lookup the first
> level hashmap, matching the entry with the same value on this field and
> with -1 if exists. Then it will lookup the next-level hashmap, whose fd
> is the value it get from the previous level hashmap. It will go through
> all the levels of tree and get a set of leaf nodes it matches. Finally,
> it will sort the set of matched leaf nodes based on their priority,
> which is defined in BPF_FM_MAP entry struct, and return the
> corresponding return value also defined in BPF_FM_MAP entry struct.
>
>
> Given a user-defined key struct and entry struct as following:
>
> struct fm_key {
>      int a;
>      int b;
>      int c;
> }
>
> struct fm_entry {
>      int priority;
>      int value;
> }
>
> and declare a BPF_FM_MAP DEMO_MAP to store incoming key-value pair:
>
> struct {
>      __uint(type, BPF_FM_MAP);
>      __type(key, struct fm_key);
>      __type(value, struct fm_entry);
>      __uint(pinning, LIBBPF_PIN_BY_NAME);
>      __uint(max_entries, 1024);
>      __uint(map_flags, BPF_F_NO_PREALLOC);
> } DEMO_MAP SEC(".maps");
>
> Now, we add the following three key-value pairs into DEMO_MAP:
>
> |a    |b    |c    |priority    |value    |
> |-    |-    |1    |1           |1        |
> |-    |2    |1    |2           |2        |
> |3    |2    |1    |3           |3        |
>
> The tree will be constructed as following:
>
> field a             field b               field c
>
>                                            fd =3D 3
>                                       ---->| key | (prioriy, value) |
>                                      |     |  1  |       (1, 1) |
>                                      |
>                      fd =3D 1          |
>                   -->| key | val |   |
>                  |   | -1  |  3  |----     fd =3D 4
>                  |   |  2  |  4  |-------->| key | (prioriy, value) |
>   fd =3D 0         |                         |  1  |       (2, 2) |
> | key | val |   |
> | -1  |  1  |----
> |  3  |  2  |----
>                  |   fd =3D 2
>                   -->| key | val |         fd =3D 5
>                      |  2  |  5  |-------->| key | (prioriy, value) |
>                                            |  1  |       (3, 3) |
>
>
> After updating the tree, we have three target tuples to lookup in DEMO_MA=
P.
>
> struct fm_key t1 =3D {
>      .a =3D 6,
>      .b =3D 4,
>      .c =3D 1
> };
>
> struct fm_key t2 =3D {
>      .a =3D 5,
>      .b =3D 2,
>      .c =3D 1
> };
>
> struct fm_key t3 =3D {
>      .a =3D 3,
>      .b =3D 2,
>      .c =3D 1
> };
>
> // map lookup order: 0 -> 1 -> 3
> // matched leaf nodes: (1, 1)
> // picked return value: 1
> map_lookup_elem(&DEMO_MAP, &t1) =3D=3D 1
>
> // map loopup order: 0 -> 1 -> (3, 4)
> // matched leaf nodes: (1, 1), (2, 2)
> // picked return value: 2
> map_lookup_elem(&DEMO_MAP, &t2) =3D=3D 2
>
> // map lookup order: 0 -> (1, 2) -> (3, 4, 5)
> // matched leaf nodes: (1, 1), (2, 2), (3, 3)
> // picked return value: 3
> map_loopup_elem(&DEMO_MAP, &t3) =3D=3D 3
>
>
> Thanks a lot for reviewing this proposal and we really appreciate any
> feedback here.

This sounds like several hash maps chained together with a custom logic.
If so it's not clear why a new map type is necessary.
Just let bpf prog lookup multiple hash maps.
