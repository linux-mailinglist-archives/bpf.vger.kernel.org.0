Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD18C485ECE
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 03:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344748AbiAFCba (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Jan 2022 21:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344731AbiAFCb2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Jan 2022 21:31:28 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3152EC061245
        for <bpf@vger.kernel.org>; Wed,  5 Jan 2022 18:31:28 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id y11so1434497iod.6
        for <bpf@vger.kernel.org>; Wed, 05 Jan 2022 18:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ypEjZS1xqSg6XwrznZf02X8HJG4g3PvWsbV5zTT1rgQ=;
        b=RFqdr12/F36nS3YTeCLiJvTmWyz8F1K8+jgXUoj6b2L1HnxbLNyDPZpc7xRNFV6Zlv
         rMEnB/gnJ5OdP8eiU+8+wpMiWIVh/6gtekebIu71JQBUJl5bhWYMbpI5VGhUqDvLZ+7C
         UtLp+Gfy9olOsyddE2+A64i0rjV6mPLU+RIGbQD99YPI1Z23wXOJX2WpCBQ/l4HKKtih
         LCs8lVblJ+UsdlAN54JG587d+TW08v9OCP3q1CptDGEDrH9GrxapQttwhb8B56AtMU4s
         3hdkqydGLJE2JXEwzSdolPe5lzjJ3/DMr/5ezykIUhzo/OoTcB9zMCkpzPTttWsmbFa5
         q/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ypEjZS1xqSg6XwrznZf02X8HJG4g3PvWsbV5zTT1rgQ=;
        b=7tC8/YVz8ofkYdnWzi5ZoOD/VDjQACLoFDARfvU8V0v0sbLkU/CJ6Psxnlpc9NWEMe
         d//17pEz6vmPvcSPrpdyABfBkKk6qfrnwB+KyGJmUmIFjSjYNbAIoc+NN6sZpo5GLl0A
         zXBZ76qGrnkTk6P6ElPr4WFtQhJP8ncMFE1Li2vHMBHv2wi53P8UYDzXqV2rsyLyGBo1
         ToHmJwfAMEuhhjh9ZrWpEnY9ARDAee8/cORxrNjRP1grez5QEWxdTR/VWhMANCYidPW6
         EPQZxoxs9oyhVCJAAZ94zAx6ATMfN2tu4ZAfLAC5cpJO7cdNLqZbdPYu0L9Yx2l8O8+1
         KzxQ==
X-Gm-Message-State: AOAM531DDomVujtfPXpcblXAYKWApy2H3L05BFMjykKaPjRYuvVQuW8E
        LttBnW8qKz30wg6Iz46iYhXWiWVNBGXQCPYKL8IlS4jT
X-Google-Smtp-Source: ABdhPJzdsRpb0p7N1cqJEXXLF8ztXpdhfZqngE4dI7bLzO07UOsi3eymhVYc8YDkCY9p7vr/hFQ/qqltRGsau3C7kbQ=
X-Received: by 2002:a6b:3b51:: with SMTP id i78mr26644809ioa.63.1641436287527;
 Wed, 05 Jan 2022 18:31:27 -0800 (PST)
MIME-Version: 1.0
References: <20211225203717.35718-1-grantseltzer@gmail.com>
 <b572def1-cfdc-6ae3-3772-d92660170fda@gmail.com> <CAO658oVFNA7JMPozQTF4vw5TDdwSu6dR_KdxgKvER8BNhiL9aA@mail.gmail.com>
In-Reply-To: <CAO658oVFNA7JMPozQTF4vw5TDdwSu6dR_KdxgKvER8BNhiL9aA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 5 Jan 2022 18:31:16 -0800
Message-ID: <CAEf4BzZY4W_TifFqt7aV-f=uS-kZKRgGmxD7Xs3=Dn0Gw+qBhA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] libbpf: Add documentation for bpf_map batch operations
To:     Grant Seltzer Richman <grantseltzer@gmail.com>
Cc:     Hengqi Chen <hengqi.chen@gmail.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 3, 2022 at 10:09 AM Grant Seltzer Richman
<grantseltzer@gmail.com> wrote:
>
> On Mon, Dec 27, 2021 at 7:25 AM Hengqi Chen <hengqi.chen@gmail.com> wrote=
:
> >
> >
> >
> > On 2021/12/26 4:37 AM, grantseltzer wrote:
> > > From: Grant Seltzer <grantseltzer@gmail.com>
> > >
> > > This adds documentation for:
> > >
> > > - bpf_map_delete_batch()
> > > - bpf_map_lookup_batch()
> > > - bpf_map_lookup_and_delete_batch()
> > > - bpf_map_update_batch()
> > >
> > > Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
> > > ---
> > >  tools/lib/bpf/bpf.c |   4 +-
> > >  tools/lib/bpf/bpf.h | 112 ++++++++++++++++++++++++++++++++++++++++++=
+-
> > >  2 files changed, 112 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> > > index 9b64eed2b003..25f3d6f85fe5 100644
> > > --- a/tools/lib/bpf/bpf.c
> > > +++ b/tools/lib/bpf/bpf.c
> > > @@ -691,7 +691,7 @@ static int bpf_map_batch_common(int cmd, int fd, =
void  *in_batch,
> > >       return libbpf_err_errno(ret);
> > >  }
> > >
> > > -int bpf_map_delete_batch(int fd, void *keys, __u32 *count,
> > > +int bpf_map_delete_batch(int fd, const void *keys, __u32 *count,
> >
> > Maybe you should drop these const qualifier changes.
>
> Can you help me understand the benefit of using the const qualifier in
> this context? I added it at Andrii's suggestion without proper
> understanding. I understand that it will properly convey that the keys
> or values aren't output parameters like in other batch operation
> functions, I don't think it would change where the underlying data is
> stored, just the pointer variable.
>
> Is it worth it to have seperate 'common' functions for the sake of
> having a const qualifier?
> >
> > All batch operations use `bpf_map_batch_common`, which has the followin=
g signature:
> >
> > static int bpf_map_batch_common(int cmd, int fd, void  *in_batch,
> >                                 void *out_batch, void *keys, void *valu=
es,
> >                                 __u32 *count,
> >                                 const struct bpf_map_batch_opts *opts)
> >
> > Adding these const qualifiers causes the following error:
> >
> > bpf.c:698:15: error: passing argument 5 of =E2=80=98bpf_map_batch_commo=
n=E2=80=99 discards
> > =E2=80=98const=E2=80=99 qualifier from pointer target type [-Werror=3Dd=
iscarded-qualifiers]

we can either forcefully cast to (void *) internally when calling
bpf_map_batch_common(), or just make bpf_map_batch_common() take const
void *. It's a bit misleading, but either way it just gets converted
to u64.

I think it's more important to have public API reflect the guarantees
correctly, so if public API specifies that something is `const void *`
that means that no one is overwriting the contents of that memory.

> >
> > >                        const struct bpf_map_batch_opts *opts)
> > >  {
> > >       return bpf_map_batch_common(BPF_MAP_DELETE_BATCH, fd, NULL,
> > > @@ -715,7 +715,7 @@ int bpf_map_lookup_and_delete_batch(int fd, void =
*in_batch, void *out_batch,
> > >                                   count, opts);
> > >  }
> > >

[...]
