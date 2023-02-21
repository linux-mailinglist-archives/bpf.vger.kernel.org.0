Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F08C69EA84
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 23:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjBUW5i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 17:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjBUW5h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 17:57:37 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9A830B14
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 14:57:35 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id x10so22563527edd.13
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 14:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pJNodFSZd5cAl2tTcW3EwZkJrUwXKju3lV2mF0ekIHs=;
        b=Rv9s6AwGlhSlVw49mbkh3FTV468NLGx2p4RjJRWmee0VfJP2SAyFAnkBb3TSZZ95vZ
         QWv2ksxrXMKv2mgkK5M6zJgtObORd+pb7m2igX1+Ho5u4NUm1cGSiRZwFAYo3ae1s1Lz
         qbIsrgJyeOloiu9+CrL71bHsGUrOW0rmZ6TsZF5oLA+WyNVLL1mRjFnRNd8zq805nOLo
         Hm1sjZIwufaohs4xnCotNxuHgL9A+VKIWPHaLf0K8ArRosEEbHvuMrMcxey9ClUMHAsD
         SAoorBS9WM6eVkvxdDqAgsjE/nrG17ajK98OI7ePhFPV62PJQP+nv7yx2NFPb3qkZi8K
         KxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pJNodFSZd5cAl2tTcW3EwZkJrUwXKju3lV2mF0ekIHs=;
        b=5WAP+Fms5CEnk1zjDgm1oEtGwDrgR04L5v5b5WPdlR48DP8QE7J44jJD5sXxiOLa6C
         H5e6NAUTW1UHkyxGIzJvrj3FxYYqC2vRMeZ4DRe+QtqdGb8iBxcQNOxrxUJN7nzI09e7
         w/D0nP1O1xTZftoUOT9+5yuKc/rn1+u8thf5SrKbyNb44rIeazqU/IFrkW1UldQ+yDRv
         ZG1C7N5L6lnQgaxbVXFh9DhGB5GdOAWKaHgvX0DEew283JT5EVj9ytDvx+wJcSWVPVvk
         ow7ovTkDH48PIxKb3uAW4MTI8lqyOJ905lAw3BPBhBfn/CxlmiJH8JHRo/66OPK6tFsG
         FVmQ==
X-Gm-Message-State: AO0yUKWYkTQ64hhedgrKigfo1DM+SY/LYDd69DzZk3WY808jlczfMY91
        HJryUr9hPlptOl6Q1Kr5Yi0=
X-Google-Smtp-Source: AK7set8mUT6cuSjTAbE3LPidW/CY1m8cMWVjHFgFzK/YLiXhxnkoRZRoWgFv+SZ3InthiPu2Q4StpQ==
X-Received: by 2002:a05:6402:6d1:b0:4af:593c:c06f with SMTP id n17-20020a05640206d100b004af593cc06fmr3165852edy.11.1677020254336;
        Tue, 21 Feb 2023 14:57:34 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id rh16-20020a17090720f000b008b6aea4738esm5760377ejb.42.2023.02.21.14.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 14:57:33 -0800 (PST)
Message-ID: <1b84d1477c3648e6d20bacaf1447724fb78e282f.camel@gmail.com>
Subject: Re: BTF tag support in DWARF (notes for today's BPF Office Hours)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     David Faust <david.faust@oracle.com>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Malcolm <dmalcolm@redhat.com>,
        Julia Lawall <julia.lawall@inria.fr>, elena.zannoni@oracle.com,
        acme@redhat.com, Yonghong Song <yhs@fb.com>,
        Mykola Lysenko <mykolal@fb.com>
Date:   Wed, 22 Feb 2023 00:57:32 +0200
In-Reply-To: <1fe666d0-aab1-5b6f-8264-57ff282b5e52@oracle.com>
References: <87r0w9jjoq.fsf@oracle.com> <877cy0j0kt.fsf@oracle.com>
         <e783fb7cdfb7bfd40e723c67daab7c5f81d12fbf.camel@gmail.com>
         <1fe666d0-aab1-5b6f-8264-57ff282b5e52@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2023-02-21 at 11:38 -0800, David Faust wrote:
[...]
> Very nice.
> Keeping the 0x6000 tag and instead changing the name sounds good to us.
>=20
> From the GCC side, support for BTF tags will be new either way but
> conserving DWARF tag numbers is a good idea.

Great, thank you!

> > Both [1] and [2] are in a workable state, but [2] lacks support for
> > subroutine types and "void *" for now. If you are onboard with this cha=
nge
> > I'll proceed with finalizing [1] and [2]. (Also, ":v2" suffix might be =
not
> > the best, I'm open to naming suggestions).
>=20
> As for the name, I am not sure the ":v2" suffix is a good idea.
>=20
> If we need a new name anyway, this could be a good opportunity to use
> something more generic. The annotation DIEs, especially with the new
> format, could be more widely useful than exclusively for producing BTF.
>=20
> For example, some other tool may want to process these same user
> annotations which are now recorded in DWARF, but may not involve BPF/BTF
> at all. Tying "btf" into the name seems to unnecessarily discourage
> those use cases.
>=20
> What do you think about something like "debug_type_tag" or=20
> "debug_type_annotation" (and a similar update for the decl tags)?
> The translation into BTF records would be the same, but the DWARF info
> would stand on its own without being tied to BTF.
>=20
> (Naming is a bit tricky since terms like 'tag' are already in use by
> DWARF, e.g. "type tag" in the context of DWARF DIEs makes me think of
> DW_TAG_xxxx_type...)
>=20
> As far as I understand, early proposals for the tags were more generic
> but the LLVM reviewers wished for something more specific due to the
> relatively limited use of the tags at the time. Now that the tags and
> their DWARF format have matured I think a good case can be made to
> make these generic. We'd be happy to help push for such change.

On the other hand, BTF is a thing we are using this annotation for.
Any other tool can reuse DW_TAG_LLVM_annotation, but it will need a
way to distinguish it's annotations from BTF annotations. And this can
be done by using a different DW_AT_name. So, it seems logical to
retain "btf" in the DW_AT_name. What do you think?

> > As a somewhat orthogonal question, would it be possible for you to use =
the
> > same 0x6000 tag on GCC side? I looked at master branch of [3] but can't
> > find any mentions of btf_type_tag.
>=20
> Yes, we plan to use the same 0x6000 in GCC. Support for btf_type_tag isn'=
t
> committed in master yet; I originally worked on patches [1] last spring b=
ut
> they were not committed due to some of the issues we've now worked out
> (notably the attribute ordering/association problem). But 0x6000 is not
> currently in use in GCC and didn't come up as a problem for those patches=
,
> so I don't think it should be an issue.

Understood, thank you for the clarification.

Thanks,
Eduard
