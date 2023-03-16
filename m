Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB276BC361
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 02:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjCPBjj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Mar 2023 21:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjCPBjj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Mar 2023 21:39:39 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DC491B6C
        for <bpf@vger.kernel.org>; Wed, 15 Mar 2023 18:39:38 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id fd5so1729070edb.7
        for <bpf@vger.kernel.org>; Wed, 15 Mar 2023 18:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678930776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAl9L1VdKK9T4FPnDb4eK9GFbN1rBiUNLvSKvbeXWfc=;
        b=T37qC6AIrqE3EMHD0jntWlPnspV/4IKsLrQsWHG+x+qn6CBMdyHZQevnTG/Gm9HEdY
         qu4CnrOAeWJzkwb57a8FImJR2eCeq/Fkilo6kZvwREVXt+tei7lBw1igVi6JXrO5K6Dt
         TdGxxKqOrb8NDf/vlaIDz1euI2I8motKRuhBgZXyZ2y2uAJge2jZKVQdFuPFQJwLqcRv
         o92SCaj/YYrBQcjg8Jqsfip27JmibCobEy1HUSD53md17lzGen7wuulI5iB5H5pu6YoZ
         2x8LkmJ7CY3RkROt9yfKMkPYkLIpul16NhkgfZKjq+Q/myZXtODGB77qkgtGkAhEbOE7
         fElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678930776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PAl9L1VdKK9T4FPnDb4eK9GFbN1rBiUNLvSKvbeXWfc=;
        b=pq+x4GSd4RoblnMqsn/mNMxTKHG4aOnE3UlOT6EwlMIIEUEL795eLTOsj4TcnVtjmr
         cmhZDOk+5pBoaFGzdwbhNpC6wMFlX7CpiDwhMjkU0I5lF9d10u4FkbDdxyoF2dmnWXos
         7v0k+IdPNzCTioqzz7j1jktFJvyGR4DFBAvLrKPvj8vejbuVbk9S9XEXPjeEIfxIvdnU
         p5Cm+Tj01cEHo1pDOKaMHBujhxePzfA0NyD74WDVg6eEH18B8HFS0qa07iVJnIpmU6lE
         9fXSUg4g1RN51mbzjgeeCIk8Q0jHba+9PTWXZdI+n2r4kBBOaa7w6bENInAe5B10iawP
         RvKw==
X-Gm-Message-State: AO0yUKWeFEhKHpneROLN3luiY7Xho7EjhNZ+icStlygXLf6YjeFhBhNJ
        U9ZLoVThPwQGSeyMBufhqTrMYT5EiKyuhNNlg+k=
X-Google-Smtp-Source: AK7set/nQFF7BQiVEvXaqwJkujkApr1O8Em/CXTTZWlDH+0L3EYoqGjf3pjR+sZYtLYSf0olM88MJ6UXmQdgFmP76lk=
X-Received: by 2002:a17:906:9483:b0:8b1:2898:2138 with SMTP id
 t3-20020a170906948300b008b128982138mr4333785ejx.3.1678930776380; Wed, 15 Mar
 2023 18:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <3f6a9d8ae850532b5ef864ef16327b0f7a669063.1678432753.git.vmalik@redhat.com>
 <202303160919.SGyfD0uE-lkp@intel.com> <CAADnVQJ+-ThSUMzEgWu6OtkWB-bdqZKPiRxWUEbL5L=cPjeezg@mail.gmail.com>
In-Reply-To: <CAADnVQJ+-ThSUMzEgWu6OtkWB-bdqZKPiRxWUEbL5L=cPjeezg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 15 Mar 2023 18:39:25 -0700
Message-ID: <CAADnVQKWtWZg+zHfA2AOwwMKipWog-MpeR88AcXN=bJuuQu6_g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 1/2] bpf: Fix attaching fentry/fexit/fmod_ret/lsm
 to modules
To:     kernel test robot <lkp@intel.com>
Cc:     Viktor Malik <vmalik@redhat.com>, bpf <bpf@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
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

On Wed, Mar 15, 2023 at 6:34=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Mar 15, 2023 at 6:32=E2=80=AFPM kernel test robot <lkp@intel.com>=
 wrote:
> >
> > Hi Viktor,
> >
> > Thank you for the patch! Yet something to improve:
>
> Argh. Comma is missing.
> Viktor,
> please send a fix asap.

Actually, since it was at the top of bpf-next
I fixed it myself and force pushed bpf-next.
