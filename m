Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DFA699BC3
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 19:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjBPSD5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Feb 2023 13:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjBPSD4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 13:03:56 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8124FAB9
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 10:03:55 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id w23-20020a63fb57000000b004fba35704a3so1154722pgj.13
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 10:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YxK744UQFgToNEy/t2y54CJ0OuxRHUOp9cRPvcpf0qw=;
        b=teuOA/6YjB3Uo8qhyzeAAbNgnvF7LadvQBC2JLvfQN9erQ0u273hZMp6bUYS0vz14+
         6QuhSXZRpS1xauiwLqr44tE4Y6fakA/jnGOGcJ7ijgQPwQbwrtpHYXKXuDpZEhi2HCBx
         1qqUw9dbnYTzKmDOaajmgIBV0ewIzr9dmNNuhK5dzyX/0N6WcC3zpeZg2halU1N1nnvQ
         8GaDK1VTTx3YGRQAMWOWTt3EaHpG3t5SQHpEcpGN0LmNua5Wo2eJuOrvv4Vl9pMQh5/k
         qnVSCS9DKv9vV4RT21dknUaVQpeAWtv2aj88s8Z4V3OYJzRwEN83s3wPdp3omiRQROY2
         +AIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YxK744UQFgToNEy/t2y54CJ0OuxRHUOp9cRPvcpf0qw=;
        b=y10sIQoz/c5ioTWuI19mKNiWzZpddLY0lmNh1g1kgKBg2Xcx911sr0CJzlU6zBV2oT
         WQcAk8eMErdAt2bD3O6H+NJhkhfMR/yyQfe5/QTVf7frmLxnPH4dBGTD6RYlnlZjn50j
         KVP+6muW86cKjic6TKG+ujSpMVjp76uZrOgrQ5FjmFt3W6hgVta0bIX3F9sGJ4EPcnpf
         UiFhO5X0RH+7cvjGY6SWusZTVbUlLtXe7skcVKvWj99JVxfo4cjNp6jbZZfm8HAp4ujM
         LV/F61hhQHTRqAOYLMXYiTjGjcq/wXbqUCwLrDk8fDvfGU5a9NR2ei9dy6La4dQ6qwrj
         AOdw==
X-Gm-Message-State: AO0yUKX2x0hB6E+5wNmhhJMx0/7R1EvraNuWr/Ti3CicA48FmsqLIzUt
        lU9GZPLtuNV/fMLDvNyyzSx91ZY=
X-Google-Smtp-Source: AK7set8mNjEFKCj1GlpL0mlUZCbIK1cvddzz9v6WD9WjCwyheaNpOIgD4Ww1veDDTKAwPNzJjvTR318=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:2911:0:b0:4fb:323f:8bca with SMTP id
 bt17-20020a632911000000b004fb323f8bcamr1029689pgb.1.1676570635049; Thu, 16
 Feb 2023 10:03:55 -0800 (PST)
Date:   Thu, 16 Feb 2023 10:03:53 -0800
In-Reply-To: <CAADnVQJH6PRgGRMMZufDu6AZkQFF_40boz4oLHdYMWFNAj+zOA@mail.gmail.com>
Mime-Version: 1.0
References: <20230215235931.380197-1-iii@linux.ibm.com> <20230215235931.380197-2-iii@linux.ibm.com>
 <CAADnVQK-_MOk=ejM5USFZL9codbzosUqfAs4ppqQuC0y4uBLqw@mail.gmail.com>
 <Y+5nCRZ3ns3u+Tun@google.com> <CAADnVQJH6PRgGRMMZufDu6AZkQFF_40boz4oLHdYMWFNAj+zOA@mail.gmail.com>
Message-ID: <Y+5wCbT30EGsswMg@google.com>
Subject: Re: [PATCH RFC bpf-next v2 1/4] bpf: Introduce BPF_HELPER_CALL
From:   Stanislav Fomichev <sdf@google.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 02/16, Alexei Starovoitov wrote:
> On Thu, Feb 16, 2023 at 9:25 AM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > On 02/16, Alexei Starovoitov wrote:
> > > On Wed, Feb 15, 2023 at 3:59 PM Ilya Leoshkevich <iii@linux.ibm.com>
> > > wrote:
> > > >
> > > > Make the code more readable by introducing a symbolic constant
> > > > instead of using 0.
> > > >
> > > > Suggested-by: Stanislav Fomichev <sdf@google.com>
> > > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > > ---
> > > >  include/uapi/linux/bpf.h       |  4 ++++
> > > >  kernel/bpf/disasm.c            |  2 +-
> > > >  kernel/bpf/verifier.c          | 12 +++++++-----
> > > >  tools/include/linux/filter.h   |  2 +-
> > > >  tools/include/uapi/linux/bpf.h |  4 ++++
> > > >  5 files changed, 17 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > > index 1503f61336b6..37f7588d5b2f 100644
> > > > --- a/include/uapi/linux/bpf.h
> > > > +++ b/include/uapi/linux/bpf.h
> > > > @@ -1211,6 +1211,10 @@ enum bpf_link_type {
> > > >   */
> > > >  #define BPF_PSEUDO_FUNC                4
> > > >
> > > > +/* when bpf_call->src_reg == BPF_HELPER_CALL, bpf_call->imm ==  
> index
> > > of a bpf
> > > > + * helper function (see ___BPF_FUNC_MAPPER below for a full list)
> > > > + */
> > > > +#define BPF_HELPER_CALL                0
> >
> > > I don't like this "cleanup".
> > > The code reads fine as-is.
> >
> > Even in the context of patch 4? There would be the following switch
> > without BPF_HELPER_CALL:
> >
> > switch (insn->src_reg) {
> > case 0:
> >         ...
> >         break;
> >
> > case BPF_PSEUDO_CALL:
> >         ...
> >         break;
> >
> > case BPF_PSEUDO_KFUNC_CALL:
> >         ...
> >         break;
> > }
> >
> > That 'case 0' feels like it deserves a name. But up to you, I'm fine
> > either way.

> It's philosophical.
> Some people insist on if (ptr == NULL). I insist on if (!ptr).
> That's why canonical bpf progs are written as:
> val = bpf_map_lookup();
> if (!val) ...
> zero is zero. It doesn't need #define.

Are you sure we still want to apply the same logic here for src_reg? I
agree that doing src_reg vs !src_reg made sense when we had a "helper"
vs "non-helper" (bpf2bpf) situation. However now this src_reg feels more
like an enum. And since we have an enum value for 1 and 2, it feels
natural to have another one for 0?

That second patch from the series ([0]) might be a good example on why
we actually need it. I'm assuming at some point we've had:
#define BPF_PSEUDO_CALL 1

So we ended up writing `src_reg != BPF_PSEUDO_CALL` instead of actually
doing `src_reg == BPF_HELPER_CALL` (aka `src_reg == 0`).
Afterwards, we've added BPF_PSEUDO_KFUNC_CALL=2 which broke our previous
src_reg vs !src_reg assumptions...

[0]:  
https://lore.kernel.org/bpf/20230215235931.380197-1-iii@linux.ibm.com/T/#mf87a26ef48a909b62ce950639acfdf5b296b487b
