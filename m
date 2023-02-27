Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806FA6A4CE3
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 22:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjB0VNT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 16:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjB0VNR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 16:13:17 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E0EA5FD
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 13:13:15 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id i34so31352423eda.7
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 13:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dsxw+PmfHJ7zwtKCpoX340gGigAxUZQeLRgQ5Ms5qQI=;
        b=LzxnlvV4dfLkPfqLQHpXNrEDVivqzZRMIvzSvKEMP+qX8ol8OWiEUnsUzpnWJGzuuX
         8p4kD4NsLOjpU0C+Cjdu5J90KLySiwTy87o0T+pyfy6yNBoyYfT5Xkqq71o7cmNeB+Ev
         OfSh4N4sybEMNlUkdx+4gnYQ1vagKyhEQBelzqujXudDAC4RgJTfKkS00lecJhn1vfgI
         r16nvvROXEgkgtj8Ui23D1hB+F64heOPFeD4CqtmtSfx7kUsN2jLfUNCQK5tVha4p4De
         hbEPDMI9ymGiCddk6G7imfJZV6NjrXbXpmk1bntLu9dm9rkPD1pToiSXqNy4IOiFVl7j
         AXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dsxw+PmfHJ7zwtKCpoX340gGigAxUZQeLRgQ5Ms5qQI=;
        b=PrNAxq7qvLRjvSXjdzdXPD/vX0qsUYvFyHYFPphHGVbmNsQJcFJeGPDZygeiyHY9+G
         fjcCZ2WuPjuNUgTJQ4YfmMPOaK1khWq8o/M83h88GqszlEqQLIScl66JhMzn3Mugackb
         taLcEotNqwA1dfmKXlbPiJnyzohjv+iwnICOlmiGO6fQhELzqdkiywNSRzlo+LFXLu6B
         hgdSXkhdVvF8agv/wCiwA8GmOD8pRT8HNuvoMHXawQiOqr9ObT9g0fqjMwZglj6Pkt8m
         Qd+ltRXTl00d/0gjeIDKUBgaHi7CGw6t4ifLpHt3dbtTK/Go9eBfof0fgqSPorlElnz1
         vvcg==
X-Gm-Message-State: AO0yUKXLk9knEA3Hu5JIlKe3iig0aMFz0oEfwAPjGWxgjyfwBK7U0i1f
        c05eSlB7HBCbvPTGw0snw+3lQZLZzCZzOptLRV5mpUll
X-Google-Smtp-Source: AK7set9k862BE4Xw91xSqybI8806jnx9fdUXwUT8AVS10pjJsX2FiFAgCCo76qu2VL/W4HrM7LBn41xwGYVb1xserPc=
X-Received: by 2002:a17:906:5f97:b0:8b0:7e1d:f6fa with SMTP id
 a23-20020a1709065f9700b008b07e1df6famr26317eju.15.1677532393862; Mon, 27 Feb
 2023 13:13:13 -0800 (PST)
MIME-Version: 1.0
References: <87r0w9jjoq.fsf@oracle.com> <877cy0j0kt.fsf@oracle.com>
 <e783fb7cdfb7bfd40e723c67daab7c5f81d12fbf.camel@gmail.com>
 <1fe666d0-aab1-5b6f-8264-57ff282b5e52@oracle.com> <1b84d1477c3648e6d20bacaf1447724fb78e282f.camel@gmail.com>
 <a71cd1ae-d4a0-7463-0afd-32d2e15a8882@oracle.com> <CAADnVQ+QNAEaqgOM9PwDs+0dkiL3wmPafJN=XY5ckcgTzmsiEg@mail.gmail.com>
 <d6f9fe3faa4aef62227420fc41f2e896f4d7eb2a.camel@gmail.com>
In-Reply-To: <d6f9fe3faa4aef62227420fc41f2e896f4d7eb2a.camel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Feb 2023 13:13:01 -0800
Message-ID: <CAEf4BzZUySu10OnsdoyTVXYS_2Ggn2i5KA177RA=v75oquq9TQ@mail.gmail.com>
Subject: Re: BTF tag support in DWARF (notes for today's BPF Office Hours)
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Faust <david.faust@oracle.com>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        bpf <bpf@vger.kernel.org>,
        James Hilliard <james.hilliard1@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Malcolm <dmalcolm@redhat.com>,
        Julia Lawall <julia.lawall@inria.fr>, elena.zannoni@oracle.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Yonghong Song <yhs@fb.com>, Mykola Lysenko <mykolal@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 22, 2023 at 11:51 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Wed, 2023-02-22 at 10:11 -0800, Alexei Starovoitov wrote:
> [...]
> > > > > What do you think about something like "debug_type_tag" or
> > > > > "debug_type_annotation" (and a similar update for the decl tags)?
> > > > > The translation into BTF records would be the same, but the DWARF info
> > > > > would stand on its own without being tied to BTF.
> > > > >
> > > > > (Naming is a bit tricky since terms like 'tag' are already in use by
> > > > > DWARF, e.g. "type tag" in the context of DWARF DIEs makes me think of
> > > > > DW_TAG_xxxx_type...)
> > > > >
> > > > > As far as I understand, early proposals for the tags were more generic
> > > > > but the LLVM reviewers wished for something more specific due to the
> > > > > relatively limited use of the tags at the time. Now that the tags and
> > > > > their DWARF format have matured I think a good case can be made to
> > > > > make these generic. We'd be happy to help push for such change.
> > > >
> > > > On the other hand, BTF is a thing we are using this annotation for.
> > > > Any other tool can reuse DW_TAG_LLVM_annotation, but it will need a
> > > > way to distinguish it's annotations from BTF annotations. And this can
> > > > be done by using a different DW_AT_name. So, it seems logical to
> > > > retain "btf" in the DW_AT_name. What do you think?
> > >
> > > OK I can understand keeping it BTF specific.
> > >
> > > Other than that, I don't come up with any significantly different idea
> > > than to use the ":v2" suffix, so let's go with "btf_type_tag:v2"?
> >
> > I don't like v2 suffix either.
> > Please come up with something else.
>
> Nothing particularly good comes to mind:
> - btf_type_tag:wrapper
> - btf_type_tag:outer
> - btf_type_tag:own
> - exterior_btf_type_tag
> - outer_btf_tag
> - btf_type_prefix
> - btf_type_qualifier (as in const/volatile)
>
> Or might as well use btf_type_tag:gcc, as you suggested earlier,
> but it is as confusing as the others.

btf.type_tag or btf:type_tag or btf/type_tag (you get the idea, it's
"BTF scoped")?
