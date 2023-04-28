Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D966F1FFF
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 23:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjD1VPW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Apr 2023 17:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjD1VPW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Apr 2023 17:15:22 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2141BCF;
        Fri, 28 Apr 2023 14:15:20 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-94eee951c70so40025766b.3;
        Fri, 28 Apr 2023 14:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682716518; x=1685308518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnOuX41j7F8VPQ++N8fwERH3Nnxkown4YdoEOz69K7k=;
        b=q8lV/QWREQGaYpuwQbGQsIaDg7x2f2gbopVAZVomDzbAmY1kVGwmfg9XsjlW7N1lvZ
         QfhGuJeMLFI06faVBalTAgi185wP0B5+kaghyJ4diDg666G1jes013MsG7OdA+uHTuNd
         MAYB+e40GWDAuBPu/+eYflt6tbKGXaBRUyvlpXV5OK8N8ZLbsEHg9cybIM+ix3Bq8hnP
         YYNKAh9MShDOA2VVv8ELVccssKkmRanUGarrUwWBqhfZkQ5j1Hr4iin95pmnyEomPypp
         7ES0tnqho7+SU4Jx7XzgDV0A7KfBdr0EQwsFzLPyBgXqUgTgAxLZFG+Yo+EBakZw8Arm
         JySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682716518; x=1685308518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vnOuX41j7F8VPQ++N8fwERH3Nnxkown4YdoEOz69K7k=;
        b=BexE+pBlHPjlIyddwrh1ACm5QONYKaUA/UxXFSiSJW1LkxEe8gJvZNXEsS4VNIyCqn
         icJkUYuNrhz8sjEFXNMbmXQ0VQ4qhwbD5BbjNCkXRyaoeAZTWcaNLWBJs5tkp83fLEdA
         1Cn7iNAjZFe3tlsEJQBs72LdVMHIf75GDELv49cDFVLSGbaWskYRSG85Flf+zJz+uqou
         MSQPJN2l0EVG98QxXP9MW1eZqmdKJ0uQLm5u9D+YSn5iZRYNbKCt15FKDZxMEvDZVERa
         I2YtpDpx5Ptkx9zcRxYIFWol0xO03BMy8v4sJXPBGOPDdakY9KuL4nts3Ccve7v7Oy8g
         mQGA==
X-Gm-Message-State: AC+VfDyUT8vizIjH27tKvnQjAqgtYIh4miqKAfkeiv9PTUEpE6jlRmNx
        VBq7OljUw63+lrBeIzkLBnzsvODoJ9Rka3FGeJA=
X-Google-Smtp-Source: ACHHUZ7SBXVnVKJcbWYCfEy6/Fo6/HCKByGNeZ9FCWhpJ8mqyG7C2ewgxistHOK/nB6Ua+NXzueXd4uDF0fYfBRgCzA=
X-Received: by 2002:a17:907:d8c:b0:947:ebd5:c798 with SMTP id
 go12-20020a1709070d8c00b00947ebd5c798mr8152904ejc.54.1682716518476; Fri, 28
 Apr 2023 14:15:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4Bzaw6DBHn=S9zKCXTSh7jW8xL9K6bzi1Q-e8j93thi2hmg@mail.gmail.com>
 <20230418112454.GA15906@kitsune.suse.cz> <CAEf4BzZf50fX7T9k47u+9YQrMbSLxLeA1qWwrdWToCZkMhynjg@mail.gmail.com>
 <20230418174132.GE15906@kitsune.suse.cz> <ZD/3Ll7UPucyOYkk@syu-laptop.lan>
 <CAEf4BzZfGewUgYsNNqCgES5Y5-pqbSRDbhtKiuSC7=G_83tyig@mail.gmail.com>
 <87zg73tvm1.fsf@toke.dk> <CAEf4BzY9Hr2M7dZXaTZCP4SRat+KpN42c89LG1Msn4PB+1O1YA@mail.gmail.com>
 <878remtxvs.fsf@toke.dk> <CAEf4BzafdhjjxxW-7ovbO9vpGa3KVTV4iESe+gjRk7UyJtg6aA@mail.gmail.com>
 <ZEuOK8Rvlm52d2DK@syu-laptop>
In-Reply-To: <ZEuOK8Rvlm52d2DK@syu-laptop>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 28 Apr 2023 14:15:06 -0700
Message-ID: <CAEf4Bzb9UZykRSczsP5quSEL5DvneuYfB2eLmnLKee_YrCROpw@mail.gmail.com>
Subject: Re: Packaging bpftool and libbpf: GitHub or kernel?
To:     Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc:     linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Tony Jones <tonyj@suse.de>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        David Miller <davem@davemloft.net>,
        Mahe Tardy <mahe.tardy@gmail.com>,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
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

On Fri, Apr 28, 2023 at 2:13=E2=80=AFAM Shung-Hsi Yu <shung-hsi.yu@suse.com=
> wrote:
>
> On Thu, Apr 20, 2023 at 02:39:17PM -0700, Andrii Nakryiko wrote:
> > On Thu, Apr 20, 2023 at 7:46=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgense=
n <toke@redhat.com> wrote:
> > > [snip]
> > > Right, well, you don't *have* to be cooperative with the wider
> > > ecosystem, of course. Just as packagers don't have to follow your
> > > recommendations if they have good reasons not to. I believe we've had
> > > this discussion before, and I don't think we're going to agree this t=
ime
> > > around either, so let's not waste any more virtual ink on rehashing i=
t :)
> >
> > Exactly, so I'm not sure why we are even having this conversation all
> > over again. I agree on not wasting virtual ink anymore. I'm not
> > forcing anyone to follow my advice, I expect others to not force me to
> > follow theirs.
>
> Thanks for still going through the reasoning.
>
> I don't have anything to add to the discussion, so instead here's an atte=
mpt
> to summarize the thread thus far, reading between the lines here and ther=
e
> to keep it terse but complete; feel free to point out where I misundersto=
od.
>
>
> # Packaging bpftool and libbpf
>
> - bpftool and libbpf version should be kept in sync
>   - interdependency is by design
>   - bpftool uses private functionality of libbpf
>   - bpftool generated file is tie to specific libbpf (?)

this bullet point is not true, generated BPF skeleton or statically
linked BPF object file should work across wide range of libbpf
versions

>
> - the GitHub mirror is the recommended source
>
> - benefits of using the GitHub mirror includes
>   - ease of upgrade
>   - maintainer crafted changelog

I'd also say consistency between all distros (assuming everyone use
Github mirror). Because release X means exactly the same set of
commits.

>
> - downsides of using the GitHub mirror has to do with kernel backporting
>
> - git submodule requires extra work for distros to package
>   - offsetted if the source of submodules are released along
>
> - bpftool releases will (have a file that) includes submodules' source al=
ong
>   going forward
>
> - bpftool and libbpf both should work on earlier kernel (if not it's a bu=
g)
>
>
> # Other
>
> - motivations for GitHub mirror
>   - ease of distribution, packaging, build
>   - CI, to be used as submodule, Window support, etc.
>
> - libbpf interface stability
>   - stable API and ABI (within major version)
>   - BPF object format is not considered stable

BPF object file format is stable, but not frozen, it can keep evolving

>
> - libbpf is not opinionated in how it's used as a library, either
>   - statically or dynamically linked
>   - a tagged release or a random commit
>
> - on statically linking libbpf
>   - reasoning
>     - full control of implementation detail, decouples from distro packag=
e
>   - against
>     - difficulty in applying fixes
>

Looks good to me apart from things I pointed out above. Thanks for summariz=
ing!


>
> Shung-Hsi
>
> > >
> > > -Toke
> > >
