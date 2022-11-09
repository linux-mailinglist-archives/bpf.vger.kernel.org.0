Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A81623791
	for <lists+bpf@lfdr.de>; Thu, 10 Nov 2022 00:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbiKIXgC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 18:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbiKIXfr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 18:35:47 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206A12E9DC
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 15:35:47 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id v17so541954edc.8
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 15:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cX60kSRACSEe4BPNdgnQj1ayNctCEfbcxUvnaT3k0ls=;
        b=WYZTJ5aN/S1WwPCWOJzOjf6o0leE4wiyX2SzS19piWnredD7fvZXsKl4/W5+a0gvgx
         yGvOJBP5QhfKZs4TxcTU9s8+Gvo4JRqjSxUasSWzquHAaAgZ5Dv4ZEkFAdEOHPyoDOSi
         8I9cihCxjeR5YS2oHsPEaVB0fIedu0SBNRI5xJGuEom0q2UIhWDutzovuSA3yudZLUpJ
         84g2Qqe5dMmPK76rtmodzZw/N8OQVRzRsv7eIF3SnNQ52PihB+b7zqVC6BXU/5azuXS4
         dFDWoMMWB17AuE0QQV9Czg1h3RtlF7eVo01H3XbD8Q8D80g69Vgx7CX/JGLn3jTZkAVU
         sW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cX60kSRACSEe4BPNdgnQj1ayNctCEfbcxUvnaT3k0ls=;
        b=CiFhHU8ns+RZN1SMIb+f2LGyERYwkdPNkTG76dE/DycxkVEkzmNFHcKbkamcYfXq+X
         Y7z5VxgrTAVrjBTRZaFm34hedwX36I03QXlhI3iIBdwdzoRGOR5qvb5Wfphdo/GeLSuB
         0NBzUW+DENUdh6XL6ZItn2/2h/yzVr9PKZvjI3vNhlovhytA9jvSk1Hi0qjI8u9C+rMG
         h7h7yVH81zW5YISPqJlAXqiQB+vKIyKpd+hkD6rZowwYCHYue/9OHwDQjoEbggoah8ra
         kJOyaxi1tjoXSrTfDz4/dcYzB/2CdCxf2opH8aF+EJC4jiDmsDj4/osafBCsj9X6Aha6
         UREA==
X-Gm-Message-State: ACrzQf278TP00yxo7r1mLfhtiO1YdqgeVXr7XBtYCt22TaiM9Q+5GbB2
        pjCQJy/sBGL0aphs1xrd2EaInyQ+51Sa4YMlGAE=
X-Google-Smtp-Source: AMsMyM5HIj95WyeRMvePUB/p7bXucpcslRRe+Btfzc+SfY1lX8VpvzlW3keOXmws34g4CrA0w3qMM2rJwhI0xbvgJSU=
X-Received: by 2002:a05:6402:428d:b0:460:b26c:82a5 with SMTP id
 g13-20020a056402428d00b00460b26c82a5mr63154328edc.66.1668036945370; Wed, 09
 Nov 2022 15:35:45 -0800 (PST)
MIME-Version: 1.0
References: <20221107230950.7117-1-memxor@gmail.com> <20221107230950.7117-4-memxor@gmail.com>
 <CAEf4Bza6R67US05R6Oh-FY9Kit8abH6eiJ33Z6TnSSpC_n5FBA@mail.gmail.com>
 <20221108233944.o6ktnoinaggzir7t@apollo> <CAEf4BzbBNSsqvJnD8Sy4EzzOQOSuVb-g8HecCcBdJy1J2c09-A@mail.gmail.com>
 <CAADnVQLaiNYALgngkU+iKe-f7qJp9FOCqNKpcCfSVn5U4od32A@mail.gmail.com> <CAEf4BzbR-GjtjXi4mZTdya9gidPBsSi8hn3MJ7+G5J_r4iw5xQ@mail.gmail.com>
In-Reply-To: <CAEf4BzbR-GjtjXi4mZTdya9gidPBsSi8hn3MJ7+G5J_r4iw5xQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 9 Nov 2022 15:35:33 -0800
Message-ID: <CAADnVQK19sEn7reWbXFbAwSpefiN+Q_xx+UvGLqYNRx-fxBtYw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 03/25] bpf: Support bpf_list_head in map values
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
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

On Wed, Nov 9, 2022 at 3:11 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> >
> > > > >
> > > > > So what if we have
> > > > >
> > > > > struct bpf_list_node {
> > > > >     __u64 __opaque[2];
> > > > > } __attribute__((aligned(8)));
> > > > >
> > > > > ?
> > > > >
> > > >
> > > > Yep, can do that. Note that it's also potentially an issue for existing cases,
> > > > like bpf_spin_lock, bpf_timer, bpf_dynptr, etc. Not completely sure if changing
> > > > things now is possible, but if it is, we should probably make it for all of
> > > > them?
> > >
> > > Why not? We are not removing anything or changing sizes, so it's
> > > backwards compatible.
> > > But I have a suspicion Alexei might not like
> > > this __opaque field, so let's see what he says.
> >
> > I prefer to fix them all at once without adding a name.
> >
>
> This is not an issue with BTF per se.
>
> struct blah {
>   u64: 64
> };
>
> is just an empty struct blah with 8-byte size. Both BTF and DWARF will
> record it as just
>
> struct blah {
> }
>
> and record it's size as 8 bytes.
>
> With that, there is nothing to suggest that this struct has to have
> 8-byte alignment.
>
> If we mark explicitly __attribute__((aligned(8))) then DWARF will
> additionally record alignment=8 for such struct. BTF doesn't record
> alignment, though.
>
> adding u64 fields internally will make libbpf recognize that struct
> needs at least 8-byte alignment, which is what I propose as a simple
> solution.
>
> Alternatives are:
>  - extend BTF to record struct/union alignments in BTF_KIND_{STRUCT,UNION}
>  - record __attribute__((aligned(8))) as a new KIND (BTF_KIND_ATTRIBUTE)

imo above two options are way better than adding __opaque which
is nothing but a workaround for a missing feature in BTF.

> Both seem like a bit of an overkill, given the work around is to have
> u64 __opaque[] fields, which we won't have to remove or rename ever
> (because those fields are not used).

There is no rush to do this workaround.
As Kumar says we can land the existing patch as-is
and add BTF_KIND_ATTR (or anything else) in the followup.

Adding __opaque now won't work, since we won't be able
to remove it later due to backward compat.
