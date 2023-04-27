Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355DC6F068E
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 15:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243409AbjD0NYR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 09:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243518AbjD0NYM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 09:24:12 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B90146B8
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 06:24:02 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5066ce4f725so12339078a12.1
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 06:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682601841; x=1685193841;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d8+bI9b9+YHm08JqK37zNlzTM/fSajobBi1+8wnrQi8=;
        b=anRXrEQXM95a8TUhRegOIDe39UqU96231iT8HrrUSYG5/7veAs5yrsKu66rzltjomu
         kiFIeX4pH2re1n1oqhMAJf7uqCrrMTlsa0+pquhG4e309wnV0+N6wE8Zo0YMCuBHQHIj
         zPw8aQAvE7VCM+pqCTdBWezM1LT3eEORqDNfJ+TJSesQDaA99eBgEpXGkX4zmot06HaH
         gypqHKREB50a9OMtuvpQPzOdJQf4mSrZDvJ6SMUWGwVn+Dgb6wJInSUPhJL567M4wm89
         GKjYWOwy9mBT42nlAw/PSj6xpWv7JtZYaQTd3T9m5C/sQrE6mhZZi4doMnOmDWm3/bJ+
         iKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682601841; x=1685193841;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d8+bI9b9+YHm08JqK37zNlzTM/fSajobBi1+8wnrQi8=;
        b=DjaID1/LD3D2QHYUqZn3uHZ8xarJl6hpNf3hayLNbbQMnwdpQZsaft9WLcJDtYq2KO
         4fM/ZLTZMhHoMYNNnw569QJtQOUEsOe+Trn0mZzeSDPUyOGGTr6JvZ/qjTbo7FVlwN7D
         d+y6Rr3C8tSzdQAuEay4chFvBxYIeUwCuZvVVF9KoWqCmt43oxXFa0sC/juHUrGswF/u
         xF96j4EtdNq9i/uQNqfAckF9Ld05dDGLFj+PdZq2bwxJYAclUokEeA/LaOf+21oeBs/W
         eJVs6qCOV9H1wZCBoQFig5ocx1dMNvqE2npd/gl5Onpjgpns0MKgrX9kVFhZdUexu+s/
         8Y0A==
X-Gm-Message-State: AC+VfDxKU5XLcRXZ3kCCSy2rrq3emP7o4opMudXi9ycPdCEFF8VROKbu
        BVzMKq1aXzcP2TfZ4j6iUbg=
X-Google-Smtp-Source: ACHHUZ4MOUkdoNtWMLOzv4QpPTV33ctAcnlEo3VjwjwgU4o5pj7J0rmJeljeQCw3ocbXOx7ZXbTnag==
X-Received: by 2002:aa7:dc0e:0:b0:506:a192:d739 with SMTP id b14-20020aa7dc0e000000b00506a192d739mr1616207edu.41.1682601840602;
        Thu, 27 Apr 2023 06:24:00 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-8b88-53b7-c55c-8535.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:8b88:53b7:c55c:8535])
        by smtp.gmail.com with ESMTPSA id n20-20020aa7d054000000b004fc01b0aa55sm8019303edo.4.2023.04.27.06.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 06:24:00 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 27 Apr 2023 15:23:57 +0200
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [RFC/PATCH bpf-next 06/20] libbpf: Factor elf_for_each_symbol
 function
Message-ID: <ZEp3bfmJG2HBe2rK@krava>
References: <20230424160447.2005755-1-jolsa@kernel.org>
 <20230424160447.2005755-7-jolsa@kernel.org>
 <CAEf4Bza8L7YKbVvNAsRn_RDKx8PuHYZpO7HSWuZuubioEsEmbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bza8L7YKbVvNAsRn_RDKx8PuHYZpO7HSWuZuubioEsEmbQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 26, 2023 at 12:27:31PM -0700, Andrii Nakryiko wrote:
> On Mon, Apr 24, 2023 at 9:05 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Currently we have elf_find_func_offset function that looks up
> > symbol in the binary and returns its offset to be used for uprobe
> > attachment.
> >
> > For attaching multiple uprobes we will need interface that allows
> > us to get offsets for multiple symbols specified either by name or
> > regular expression.
> >
> > Factoring out elf_for_each_symbol helper function that iterates
> > all symbols in binary and calls following callbacks:
> >
> >   fn_match - on each symbol
> >              if it returns error < 0, we bail out with that error
> >   fn_done  - when we finish iterating symbol section,
> >              if it returns true, we don't iterate next section
> >
> > It will be used in following changes to lookup multiple symbols
> > and their offsets.
> >
> > Changing elf_find_func_offset to use elf_for_each_symbol with
> > single_match callback that's looking to match single function.
> >
> 
> Given we have multiple uses for this for_each_elf_symbol, would it
> make sense to implement it as an iterator (following essentially the
> same pattern that BPF open-coded iterator is doing, where state is in
> a small struct, and then we call next() until we get back NULL?)
> 
> This will lead to cleaner code overall, I think. And it does seem func
> to implement it this (composable) way.

ok, I'll check the open-coded iterator for this

> 
> Also, I think we are at the point where libbpf.c is becoming pretty
> bloated, so we should try to split out coherent subsets of
> functionality into separate files. ELF helpers seem like a good group
> of functionality  to move to a separate file? Maybe as a separate
> patch set and/or follow up, but think about whether you can do part of
> that during refactoring?

right, sounds good, will check

thanks,
jirka

> 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/bpf/libbpf.c | 185 +++++++++++++++++++++++++----------------
> >  1 file changed, 114 insertions(+), 71 deletions(-)
> >
> 
> [...]
