Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C406D236C
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 17:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjCaPDP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Mar 2023 11:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbjCaPDO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 11:03:14 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E577BCA38
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 08:03:13 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id t14so23357105ljd.5
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 08:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680274992; x=1682866992;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1ei0Vy5AzwtUR/Iz03nIvnJMR+AQ26BG84xZdFlWve8=;
        b=dKfTCSAbDzaxRMKGVwII+5e+bMdSxFNq5AK8NKa5n5XLJW8wbfyOhVJL5yFOGVSXi0
         gCtT1dr8CQs7alVCprBL2CxtPgbKfToou8jPoYG1don7l9VvZ9JTv5ADGN4OdNW0R6hU
         gZFl2OjiUN3qJZ/pjHhtaDGZgdLrdTq6ujO3dQLyxTydn+ZnaLsGYFfgY58LwU+wx5xz
         vEVZZfbnhAP5z3p9iT44EmY/lOTWy2FVYjfAhFYq8GFgd5byYVkndZRGdFnyOMnagRXm
         +nbddHx4Aj3dyKBqzzXuu0EoOBj3/TgL/F1wFpUKw4ptZBohPsAqpcg8mu/Ecvq0pE60
         BZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680274992; x=1682866992;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ei0Vy5AzwtUR/Iz03nIvnJMR+AQ26BG84xZdFlWve8=;
        b=xVTT/sJAkUzmWd2HeYTYaxdAEs658yE5gqUgu8A0uopUkfY14fGj1N60jpJgk8qjsA
         CvTquDuzgOZOtzDAP0c/MPeANdsbo0pX6BeVRAHA+3tJz/8mZ4AJ28PaYApxeC1aFAvW
         tnoKAlEDFUrp5AMUWGf1jE/AJVwdVvDZ0T7YtEYvsqH9uU4ZX03AdH9+VYygzw40pPSi
         7gDoC/BOfDcJ3BRlKa+ZVuxDCeZUEldFYeEECTW7hVRZE2qxM86DA5CuQbWi90SiyPOb
         Tjjm/9Y42hz/up7Xk8+n/KIyNVtH9W5ArYc3UUbkGuHZ+Fk4cq2vRl8kmN0wX4vBG3P2
         a9zA==
X-Gm-Message-State: AAQBX9c6hAWO4IFf+/cM1LwZOP01MGkSSe2kJUN5kT8SY41qaNYYHRGk
        /NASQ/qmM1oiIdShia/hHEc=
X-Google-Smtp-Source: AKy350bDpG9WABbvwFPmRvBiKH/qVcfwIggRoZyJ5+MdlGXgOR6/DhqkPVxeiENmSGy7amgZeT9wkQ==
X-Received: by 2002:a05:651c:204:b0:298:a7f5:755 with SMTP id y4-20020a05651c020400b00298a7f50755mr7967064ljn.14.1680274992207;
        Fri, 31 Mar 2023 08:03:12 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id h3-20020a2e9ec3000000b00293d7c95df1sm393794ljk.78.2023.03.31.08.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 08:03:11 -0700 (PDT)
Message-ID: <1feb20b6f2659b4a1e19a7522ec7e5e9993765cd.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 5/5] bpftool: Support printing opcodes and
 source file references in CFG
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org
Date:   Fri, 31 Mar 2023 18:03:09 +0300
In-Reply-To: <899fb41c-2bc4-c60f-c83b-4eb5c348e711@isovalent.com>
References: <20230327110655.58363-1-quentin@isovalent.com>
         <20230327110655.58363-6-quentin@isovalent.com>
         <fa28d05a6a123aea329a02ac666dbb18e7c5f519.camel@gmail.com>
         <899fb41c-2bc4-c60f-c83b-4eb5c348e711@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2023-03-31 at 15:52 +0100, Quentin Monnet wrote:
[...]
> > > @@ -413,6 +414,16 @@ void dump_xlated_for_graph(struct dump_data *dd,=
 void *buf_start, void *buf_end,
> > >  		printf("%d: ", insn_off);
> > >  		print_bpf_insn(&cbs, cur, true);
> > > =20
> > > +		if (opcodes) {
> > > +			printf("       ");
> >=20
> > These spaces are treated as a single space by the dot renderer, as [1]
> > says: "Spaces are interpreted as separators between tokens, so they
> > must be escaped if you want spaces in the text."
> >=20
> > [1] https://graphviz.org/doc/info/shapes.html#record
>=20
> I noticed, I kept the multiple spaces to make the DOT output slightly
> more readable. But it would maybe make sense to indent more in the graph
> as well, if it doesn't make opcode sequences wider than instructions.
> I'll have a look at this.

Oh, sorry, that did not occur to me, making DOT itself more readable
makes total sense.
