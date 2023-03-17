Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A846BDD56
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 01:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjCQAHa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Mar 2023 20:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjCQAH2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Mar 2023 20:07:28 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11786C8AF
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 17:07:20 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id cy23so14132590edb.12
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 17:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679011639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPNx069wEkIvwYOrt8M67FLBdX09SWdWLmux9d22TlI=;
        b=IueCEF7OkwkpgIfOrSpECB0M+i7y1Zr4WDfj79OID1sJtUULN+T/5H6Zus9pJym25s
         4kOmuUGoCRedxnT5YybRHLfItTzOMdES7TSOuuc5Qt2wPqShf+ipAAkxRZ5nFVeuU5AV
         UMUh7y0TwaC+PSOaUIY5gksWN6dB8fuZaHB9LEpwiw18mn9na7p7wJbdZZWQ/zIh4u00
         NgM6NiijQESiqU7+1yyjhpGpSEXuPsl23K+lfgJ5YK/cWCC80kZBfx9PDWRahFGIdzmC
         9J4n+o1fkhrS7m1bgkvheQzMkqnBwl1Amz/xBtwJPOhBnQaSisQgoiuj1CLJ+mb0aBor
         rdKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679011639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OPNx069wEkIvwYOrt8M67FLBdX09SWdWLmux9d22TlI=;
        b=O7+48F89sQ3ix5ZQgjiRM1H0rL8NuCeI4Y/9Jd3oihvl8EmFnoCt2EPuFLAdBvAizk
         DGsv3zjkclB3t0N+4rrbEx5/c82LRvdKAF/5acAjJ8IpH/MWh5654bQ0PIzcQmCR/5Kb
         GWRjdaZbQDvvAXVYI6Oe19KqoF6KT2h1yHcNSDFhXLzhMgCKIVGZDFwdjoaBOAQBuNtx
         RV8HCcHe2Ql26qQgOP+j1oVvTb1RC9h19XGasC5NCE4+w3FPxsWbAFQ+6sfWWiK7mBYP
         ygyvK4V9VUan+uqTzay8TMIO4t4/4fSyCu6qnYLHYfg71CVwDJyMrF0vgSrzUb4xK+7P
         GSSw==
X-Gm-Message-State: AO0yUKV0BC5Uz1lUqnmv8yDj7KpI0kJZxtJh5QYVlO6Oorhen6G+/Q24
        95Myht6g+/gApLFZu+pQccFAIFG7JNpfrduQ+ks=
X-Google-Smtp-Source: AK7set+dbymRNpGmJpWd0tgGYKjAN4ZDg7SCMgPiWrxyAFLflfjag+T+zzd3k77kS8LJxRpjr2dL79K/WQcJrZe0VO8=
X-Received: by 2002:a50:cd86:0:b0:4fc:2096:b15c with SMTP id
 p6-20020a50cd86000000b004fc2096b15cmr782121edi.1.1679011639399; Thu, 16 Mar
 2023 17:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230316063901.3619730-1-chantr4@gmail.com> <665c32ae4ef880c1811b8a8e3b35a7ad0bcfb054.camel@gmail.com>
 <ZBNGBAAki3VUU0bQ@worktop> <97845fbdc4178dd3d7bea836b245af2c82347b94.camel@gmail.com>
 <CAEf4BzZj6FP+=UYVXEq8bsqk0Os2zLKB2B60vyVO9+FL5jnttw@mail.gmail.com> <88930a425a50f6c1f5a420bf2adbec3b285b96e4.camel@gmail.com>
In-Reply-To: <88930a425a50f6c1f5a420bf2adbec3b285b96e4.camel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 16 Mar 2023 17:07:07 -0700
Message-ID: <CAEf4BzZA=jW2xULXfpx+UxetXBhmStmOEh1AORnRL+BGcPa_Uw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: add --json-summary option to test_progs
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Manu Bretelle <chantr4@gmail.com>, bpf@vger.kernel.org,
        andrii@kernel.org, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, yhs@fb.com
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

On Thu, Mar 16, 2023 at 4:34=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2023-03-16 at 16:23 -0700, Andrii Nakryiko wrote:
> > > [...]
> > >
> > > > In term of logical structure and maybe extensibility, this is more =
appropriate,
> > > > in term of pragmatism maybe less.
> > > >
> > > > I don't have strong opinions and can see benefit for both.
> > >
> > > idk, I don't have a strong opinion either.
> >
> > me neither, flatter struct would be simple to work with either with jq
> > or hacky grepping, so I guess the question would be how much do we
> > lose by using flatter structure?
>
> Okay, okay, noone wants to read jq manual, I get it :)

guilty ;)

>
> I assume that current plan is to consume this output by some CI script
> (and e.g. provide a foldable list of failed tests/sub-tests in the
> final output). So, we should probably use whatever makes more sense
> for those scripts. If you and Manu think that flat structure works
> best -- so be it.

As I said, I don't care. The immediate need is to produce error
summary output from this json. If you are a power user of jq and can
help us achieve this with nested structure json, that would be great.
Code wins.
