Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D421D5A1A54
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 22:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbiHYUaL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 16:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbiHYUaK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 16:30:10 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6879B73311;
        Thu, 25 Aug 2022 13:30:09 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id t5so27544708edc.11;
        Thu, 25 Aug 2022 13:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=CHZLqdp0NftYyqLJlxqmAdIZcnUJyeWujCb5jf0gPQQ=;
        b=lE9RrcPNmb5lFwWqZk8ZHLuYK9757fMPMpb77PEoX23mOsFeLgSNAsWWDSvDvD2IHH
         3jvoF9OSdQaKqYQ6NzHq4n1BW1+IXcJ0n9G7g2r7KKKlUMgEC8TdjaBlP6/L3Wo3cFrm
         wLOOCp7sGfz8awN20Wod2C+9EhPbLD0kt1ysATNYKc4JdqJ5lKQg9cod+cqiSFaJd+Zk
         qqWmVlh2JIqMoIFhigdBOtD886r8t3K24EcNmhYj35CxqM7k+Yg0qyVOwifcmE+Sgmbg
         TKzkkQa73LBfi1+Gb/zfVEqOmXK7UOGxx4+lZOf+6+u29nkr4zYlvI9NlBlY3jjtqGJC
         hprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=CHZLqdp0NftYyqLJlxqmAdIZcnUJyeWujCb5jf0gPQQ=;
        b=6Xe/7epAS8H4Un1LD9ugK2KU0vC91X+pUuo4r1BHR1s2pAeZyOmqk+KQ1M0v8V7chg
         C+qONkxYrS2jyItT/n7oe1ecvF1G5WkwlewRhCHBFblSb4EqxBPew05PTvmdf+NsS3AW
         1rusl/0OgvHP8an6HHW3zDXtVverH5Hjty7pG1cS8TlPDlDwpiCXtunkeSOuX5GZqFVU
         TDBWxN3NXd3/Cf8DE+jQBrVwtuERd6fw9g+IohhQ0keY5vjXuQEGhTfXWI1Q7K5bRXDf
         qIsWchxpH6A5/7n6F628EAoqqTOOzgXEuMJBJvaVGqT2UOFtM2Vak1S6H1RGBuV21Ah+
         Lotw==
X-Gm-Message-State: ACgBeo1cG7AS7z7XSHmkJaNL8ckFBg4EM8RYpueAxhDJcReZvdwrAtpI
        xf9x4N4jrMr3Ej4GzjGy9HqdyjLXcyeYjPedTBAMo7IS
X-Google-Smtp-Source: AA6agR7ve7bQRJ7/dXQV0ykp7VEff+fYBWLkBu88aWP+4S0/LzHez+0n0y1l3n4FNLAOTY5BfSiLNRVJeyW0jPMEp+E=
X-Received: by 2002:a05:6402:24a4:b0:440:8c0c:8d2b with SMTP id
 q36-20020a05640224a400b004408c0c8d2bmr4346193eda.311.1661459407936; Thu, 25
 Aug 2022 13:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220823132236.65122-1-donald.hunter@gmail.com>
 <CAEf4BzaujwgDXm+05MuGr_ouAseGGFg50Cxb83hHeWHX7bCk6A@mail.gmail.com> <m2fshmym52.fsf@gmail.com>
In-Reply-To: <m2fshmym52.fsf@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 25 Aug 2022 13:29:56 -0700
Message-ID: <CAEf4BzZZOh+QoEJGfRU-JrQbyyTLc4PHi0abr5DxegAJJfpntA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] Add table of BPF program types to docs
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        grantseltzer <grantseltzer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 24, 2022 at 3:25 AM Donald Hunter <donald.hunter@gmail.com> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> > On Tue, Aug 23, 2022 at 9:56 AM Donald Hunter <donald.hunter@gmail.com> wrote:
> >>
> >> Extend the BPF program types documentation with a table of
> >> program types, attach points and ELF section names.
> >>
> >> The program_types.csv file is generated from tools/lib/bpf/libbpf.c
> >> and a script is included for regenerating the .csv file.
> >>
> >> I have not integrated the script into the doc build but if that
> >> is desirable then please suggest the preferred way to do so.
> >>
> >> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> >> ---
> >
> > It does seem cleaner to generate this .csv during docs build, instead
> > of having to manually regenerate it all the time? Should we also put
> > it under Documentation/bpf/libbpf/ as it's libbpf-specific? Having it
> > under libbpf subdir would also make it simpler to expose it in libbpf
> > docs at libbpf.readthedocs.io/
>
> Agreed about generating the .csv as part of the doc build. I will look
> at adding it to the docs Makefile.
>
> I'm happy to put it in Documentation/bpf/libbpf and link to it from
> Documentation/bpf/programs.rst.
>
> > We can probably also establish some special comment format next to
> > SEC_DEF() to specify the format of those "extras", I think it would be
> > useful for users. WDYT?
>
> Yes this would be a useful addition. Are the extras always for
> auto-attach? If so, then I can add that to the rules.

I think so. I can't recall any program type that can be auto-attached
with just its type.

>
> I'd prefer to modify the existing ELF section name column to replace '+'
> with extras since the table is already wide.
>
> > CC'ing Grant as well, who worked on building libbpf docs.
