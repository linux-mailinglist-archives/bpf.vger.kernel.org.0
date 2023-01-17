Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F5C66DC70
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 12:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbjAQLbz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 06:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236909AbjAQLb1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 06:31:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C8132512
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 03:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673955030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZVNHKgbtLKpXIG8gHCv6aTj4n7VIPLZrQvHeAO9MVdw=;
        b=Y4ps5ZZfpJmMEhyB2B8xQFLYAjmWxnpQsSYD756hwkiYh2VBwwUqS5KX8LWfVx1PugYlKb
        HiBqA6BdmJoBcSNTkORaUiepL7AfdofMcXeLCJ7h8ASEfC4j2GCwe8BduTtigXX4k5qv71
        F/gj4swQ4Rz9MRMFmdpnzRXdKSDLbso=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-310-OkPyihSzOCOpazCnet5wAw-1; Tue, 17 Jan 2023 06:30:29 -0500
X-MC-Unique: OkPyihSzOCOpazCnet5wAw-1
Received: by mail-ed1-f72.google.com with SMTP id m9-20020a056402430900b0049ca14dc2aaso7469265edc.16
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 03:30:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVNHKgbtLKpXIG8gHCv6aTj4n7VIPLZrQvHeAO9MVdw=;
        b=5pun5OVxoo9YGJ8eP+0kRQlYrUiqeljqsxwWX76ON+f3DN5fPGCW7r9NceBTXLXuZg
         /gWfqW35bUvIYvxWZUGR2g6ST7ugFAWMN8/5Qf6LKIJpjlzq+BqFOdKpv1d55dbPjBsV
         n7SyOaEnQgHoWWPCPUAOKmWB+lDNeaaAIq0REkVQt6iuxxuMRnCmpHLrhxnY3AIjgpYQ
         em6kV1HlXPX6sIvGIRH89hAaXrTruN8gdWziqq4ieVzqZXTQV7L2E4GXGJYLxLuNiLqV
         G2uyzxSgfbqw2X8bwlQn3RZR7K7wLn3ypb6FDIjk984fzUiIcd3VfaWGgYapUhunPi3O
         YoOw==
X-Gm-Message-State: AFqh2kpMhLV7PsFbcOUURrPKZFMzFdE3pb0Rxcgzp542j4T8T4f65NCi
        0Q5GtKzYRs+UZpvCLzN2IVON7H1gCGBMH1ugyZqAjvMNaXHcsufwfDotAXVjx+ZIc8llg2xJL4W
        HpnPhe3W1/oXK
X-Received: by 2002:a17:906:75b:b0:7e0:eed0:8beb with SMTP id z27-20020a170906075b00b007e0eed08bebmr15528995ejb.41.1673955028335;
        Tue, 17 Jan 2023 03:30:28 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuFUcJdVGp4iM9H3zNn9kq0BJ+kXwW7a/tP1pf5uKejSDenxomkVzXKpng0AjtWP7dyrmajtw==
X-Received: by 2002:a17:906:75b:b0:7e0:eed0:8beb with SMTP id z27-20020a170906075b00b007e0eed08bebmr15528960ejb.41.1673955027933;
        Tue, 17 Jan 2023 03:30:27 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id o3-20020a170906288300b007ae693cd265sm12940928ejd.150.2023.01.17.03.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 03:30:27 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 87AFB9010ED; Tue, 17 Jan 2023 12:30:26 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc:     David Vernet <void@manifault.com>, bpf@vger.kernel.org,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [RFC PATCH bpf-next] Documentation/bpf: Add a description of
 "stable kfuncs"
In-Reply-To: <6deb800f-57d8-9ee5-d588-ee6354e74aa9@iogearbox.net>
References: <20230116225724.377099-1-toke@redhat.com>
 <6deb800f-57d8-9ee5-d588-ee6354e74aa9@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 17 Jan 2023 12:30:26 +0100
Message-ID: <87fsc9csa5.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 1/16/23 11:57 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Following up on the discussion at the BPF office hours, this patch adds a
>> description of the (new) concept of "stable kfuncs", which are kfuncs th=
at
>> offer a "more stable" interface than what we have now, but is still not
>> part of UAPI.
>>=20
>> This is mostly meant as a straw man proposal to focus discussions around
>> stability guarantees. From the discussion, it seemed clear that there we=
re
>> at least some people (myself included) who felt that there needs to be s=
ome
>> way to export functionality that we consider "stable" (in the sense of
>> "applications can rely on its continuing existence").
>>=20
>> One option is to keep BPF helpers as the stable interface and implement
>> some technical solution for moving functionality from kfuncs to helpers
>> once it has stood the test of time and we're comfortable committing to it
>> as a stable API. Another is to freeze the helper definitions, and instead
>> use kfuncs for this purpose as well, by marking a subset of them as
>> "stable" in some way. Or we can do both and have multiple levels of "sta=
ble",
>> I suppose.
>>=20
>> This patch is an attempt to describe what the "stable kfuncs" idea might=
 look
>> like, as well as to formulate some criteria for what we mean by "stable"=
, and
>> describe an explicit deprecation procedure. Feel free to critique any pa=
rt
>> of this (including rejecting the notion entirely).
>>=20
>> Some people mentioned (in the office hours) that should we decide to go =
in
>> this direction, there's some work that needs to be done in libbpf (and
>> probably the kernel too?) to bring the kfunc developer experience up to =
par
>> with helpers. Things like exporting kfunc definitions to vmlinux.h (to m=
ake
>> them discoverable), and having CO-RE support for using them, etc. I kinda
>> consider that orthogonal to what's described here, but I added a
>> placeholder reference indicating that this (TBD) functionality exists.
>
> Thanks for the writeup.. I did some edits to your sections to make some p=
arts
> more clear and to leave out other parts (e.g. libbpf-related bits which a=
re not
> relevant in here and it's one of many libs). I also edited some parts to =
leave
> us more flexibility. Here would be my take mixed in:

Edits LGTM, with just one nit, below:

> 3. API (in)stability of kfuncs
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
> By default, kfuncs exported to BPF programs are considered a kernel-inter=
nal
> interface that can change between kernel versions. In the extreme case th=
at
> could also include removal of a kfunc. This means that BPF programs using
> kfuncs might need to adapt to changes between kernel versions. In other w=
ords,
> kfuncs are _not_ part of the kernel UAPI! Rather, these kfuncs can be tho=
ught
> of as being similar to internal kernel API functions exported using the
> ``EXPORT_SYMBOL_GPL`` macro. All new BPF kernel helper-like functionality=
 must
> initially start out as kfuncs.
>
> 3.1 Promotion to "stable"
> -------------------------
>
> While kfuncs are by default considered unstable as described above, some =
kfuncs
> may warrant a stronger stability guarantee and could be marked as *stable=
*. The
> decision to move a kfunc to *stable* is taken on a case-by-case basis and=
 has
> a high barrier, taking into account its usefulness under longer-term prod=
uction
> deployment without any unforeseen API issues or limitations. In general, =
it is
> not expected that every kfunc will turn into a stable one - think of it a=
s an
> exception rather than the norm. kfuncs which have been promoted to stable=
 are
> then marked using the ``KF_STABLE`` tag. The possibility from a stable kf=
unc to
> a BPF helper addition is up to the maintainers to decide.
>
> 1. Stable kfuncs will not change their function signature or functionalit=
y in
>     a way that may cause incompatibilities for BPF programs calling the f=
unction.
>
> 2. The BPF community will make every reasonable effort to keep stable kfu=
ncs
>     around as long as they continue to be useful to real-world BPF applic=
ations.
>
> 3. Should a stable kfunc turn out to be no longer useful, a deprecation p=
rocedure
>     might be implemented for them as outlined below.

"deprecation procedure might be implemented" could be interpreted as "we
may implement a deprecation procedure, or we may just remove it without
one". Which is presumably not what you meant? So maybe:

 3. Should a stable kfunc turn out to be no longer useful, the BPF
    community may decide to eventually remove it. In this case, before
    being removed that kfunc will go through a deprecation procedure as
    outlined below.

> 3.2 Deprecation of kfuncs
> -------------------------
>
> As described above, the community will make every reasonable effort to ke=
ep
> kfuncs available through future kernel versions once they are marked as s=
table.
> However, there may be the unforeseen case that BPF development moves in a
> direction where even a stable kfunc is no longer useful for program devel=
opment.
> In this case, stable kfuncs can be marked as *deprecated* using the
> ``KF_DEPRECATED`` tag. Such deprecation request cannot be arbitrary and m=
ust
> explain why a given stable kfunc should be deprecated.
>
> 1. A deprecated stable kfunc will be kept in the kernel for a conservativ=
ely
>     chosen period of time after it got first marked as deprecated (usually
>     corresponding to a span of multiple years).
> 2. Deprecated functions will be documented in the kernel docs along with =
their
>     remaining lifespan and including a recommendation for new functionali=
ty that
>     can replace the usage of the deprecated function (or an explanation f=
or why
>     no such replacement exists).
>
> 3. After the deprecation period, the kfunc will be removed and the functi=
on name
>     will be marked as invalid inside the kernel (to ensure that no new kf=
unc is
>     accidentally introduced with the same name in the future). After this
>     happens, BPF programs calling the kfunc will be refused by the verifi=
er.

