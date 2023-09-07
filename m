Return-Path: <bpf+bounces-9380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63383796E00
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 02:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1833D281434
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 00:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE757FA;
	Thu,  7 Sep 2023 00:29:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480A37E8
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 00:29:36 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E14AE9
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 17:29:34 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9a9d82d73f9so36483166b.3
        for <bpf@vger.kernel.org>; Wed, 06 Sep 2023 17:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694046573; x=1694651373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gl+drXqZwzhyVP+iQHvcMLlSLpd+h75qSONaRKKmhxQ=;
        b=ruykAoLqISh4xXu3ywxr92C3gzOKJvWZQJFfyo8XsPpQq0VjtiZLLR0olqhHY12Mhs
         JS1oWuAIWwMDRK5x/wtzRWFmXtCPgJ824ZR9mUHoJNzUv4ZKwDlHFHEVqMg3pDCW8F8A
         FVGXLpXIJKdxUwVLfs2wpssCvS+kGg41bb/cMCj2zPA1iqGOn18kKRNbglyEfsib15RU
         XuFDZhCNfqnfYpoFRV1oMoENQ5vX1ZBTIW0EnKvh4RRF8j9yRMPvwahTXTYiX3t3JxNi
         9zq4nMxo29Ak5VIgytwbIIv1ED8Adn+GDzfRvE5BqFZ6K+Bwfx7W+4iGm0uBCWgnlN+3
         h1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694046573; x=1694651373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gl+drXqZwzhyVP+iQHvcMLlSLpd+h75qSONaRKKmhxQ=;
        b=Id6Tws9i3wD5AI98aag8U2Y/9GX52wo+0fGgeXATm+YRaZ+wRMeiBfgMnAy20MPXTa
         OBiPxV3PoH7b6Ra4WiX8a3j0Xjlbyr+17ILw8eIZkZz99uCL2eEckqZd7Yz8wmcSHQMy
         sZbqsmBt/PfaRuiXR3Sfrf9vLKf6ALTTpqlVnri8000jp9R3WUyBwOcg+0YBqN5FPamu
         ZLr32n8rvrAOWEIOTj8cKbJgUaJKyc7LEaJh1vu98/CPnCMKhXkNHOMQjqkHcMXWEp5m
         ICwWOEmRqzLjdzwUwfxiHguKaLSp1r4Rxqqr8oZ10VK1xFGSPhWMWE6uiO4wKraV1XvD
         UziQ==
X-Gm-Message-State: AOJu0YxrJqo+z4unSHz6afiABFkoN/AjOhZLunnBGE8Q2unekQlre8jS
	SMBMCM+GqTNwDn0yN0yGL7gjAPhSFsKkw3NB/pU=
X-Google-Smtp-Source: AGHT+IEvVfo0H8RHbdeTlpEPr9tZCjvdZqh3pTxPzl9u0RETAXJ61hCzoKb5xSV0pPMT3iQ5NTXqQ5AyfqEa0dl/sKQ=
X-Received: by 2002:a17:906:24d:b0:9a1:a134:8cb4 with SMTP id
 13-20020a170906024d00b009a1a1348cb4mr3386021ejl.32.1694046572777; Wed, 06 Sep
 2023 17:29:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230816173030.148536-1-martin.kelly@crowdstrike.com>
 <5806e499-069f-18f4-2af0-5d9bd8bfa05e@iogearbox.net> <2e6c5f26-7ef9-f97f-44dc-03967b3326ea@crowdstrike.com>
 <c109eeeb-9db7-3a7a-f815-412f412968a3@crowdstrike.com>
In-Reply-To: <c109eeeb-9db7-3a7a-f815-412f412968a3@crowdstrike.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 6 Sep 2023 17:29:21 -0700
Message-ID: <CAEf4BzY1ZPmyyG3T+hSms7Avbb+4CmMJo13v5yZMz824wLt2iw@mail.gmail.com>
Subject: Re: [PATCH bpf] libbpf: soften BTF map error
To: Martin Kelly <martin.kelly@crowdstrike.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 28, 2023 at 1:22=E2=80=AFPM Martin Kelly
<martin.kelly@crowdstrike.com> wrote:
>
> On 8/17/23 10:07, Martin Kelly wrote:
> > On 8/17/23 07:17, Daniel Borkmann wrote:
> >> On 8/16/23 7:30 PM, Martin Kelly wrote:
> >>> For map-in-map types, the first time the map is loaded, we get a scar=
y
> >>> error looking like this:
> >>>
> >>> libbpf: bpf_create_map_xattr(map_name):ERROR:
> >>> strerror_r(-524)=3D22(-524). Retrying without BTF.
> >>>
> >>> On the second try without BTF, everything works fine. However, as thi=
s
> >>> is logged at error level, it looks needlessly scary to users. Soften
> >>> this to be at debug level; if the second attempt still fails, we'll
> >>> still get an error as expected.
> >>>
> >>> Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
> >>
> >> nit: $subj should be for bpf-next instead of bpf
> >
> > I had purposefully sent to "bpf" instead of "bpf-next" as it felt like
> > a fix, but I'm fine with "bpf-next" instead if that's better.
> >
> >>
> >>> ---
> >>>   tools/lib/bpf/libbpf.c | 2 +-
> >>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >>> index b14a4376a86e..0ca0c8d01707 100644
> >>> --- a/tools/lib/bpf/libbpf.c
> >>> +++ b/tools/lib/bpf/libbpf.c
> >>> @@ -5123,7 +5123,7 @@ static int bpf_object__create_map(struct
> >>> bpf_object *obj, struct bpf_map *map, b
> >>>             err =3D -errno;
> >>>           cp =3D libbpf_strerror_r(err, errmsg, sizeof(errmsg));
> >>> -        pr_warn("Error in bpf_create_map_xattr(%s):%s(%d). Retrying
> >>> without BTF.\n",
> >>> +        pr_debug("bpf_create_map_xattr(%s):%s(%d). Retrying without
> >>> BTF.\n",
> >>>               map->name, cp, err);
> >>
> >> There are also several other places with pr_warns about BTF when
> >> loading an obj. Did
> >> you audit them as well under !BTF kernel? nit: Why changing the fmt
> >> string itself,
> >> looked ok as-is, no?
> >
> > This message is actually printed even for a BTF-supported kernel.
> > Basically, the first call to bpf_create_map_xattr using BTF *always*
> > fails for map-in-map types, printing this message, and then the second
> > always succeeds. So this isn't really about BTF support but simply
> > about an over-zealous message.
> >
> > I changed the format string because calling this an "Error" feels (to
> > me) unnecessarily alarming, given that this is totally normal
> > behavior. I'm OK keeping the "Error in" part if you think that's
> > better. The most important thing to me was that, when the program
> > loads successfully, we shouldn't be logging to stderr and scaring the
> > user.
> >
> > Let me know if you'd like me to keep the "Error in" part for a v2 patch=
.
> >
> >>
> >> There is also libbpf_needs_btf(obj), perhaps this could be left as
> >> pr_warn similar
> >> as in bpf_object__init_btf() - or would this still trigger in your cas=
e?
> >
> > I think this one should stay as a warning, as it looks like the code
> > path is a fatal error, and if you try to load a BTF-requiring program
> > but don't have BTF, that seems like an error to me. This patch was
> > more about an error being logged 100% of the time in a totally normal,
> > non-fatal, BTF-supported case due to the quirks of map-in-map types
> > and BTF.
> >
> >>
> >>>           create_attr.btf_fd =3D 0;
> >>>           create_attr.btf_key_type_id =3D 0;
> >>>
> >>
> >> Thanks,
> >> Daniel
>
> (ping) any thoughts on the above? I'm happy to send a v2 patch but want
> to make sure we're on the same page with what should be in it.
>

map creation failing due to having a BTF information should be a
rather exception than the norm, for two reasons: 1) libbpf sanitizes
BTF, so even older kernels can still retain some (modified) BTF
information, and 2) libbpf drops BTF for maps that don't support BTF
type info for keys/values. So if you see this, then it would be useful
to actually look into why this is happening.

So I'd prefer this to keep pretty visible. Can you try to debug what
makes the kernel reject your BTF information?

