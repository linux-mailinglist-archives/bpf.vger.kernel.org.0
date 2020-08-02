Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCC92354F2
	for <lists+bpf@lfdr.de>; Sun,  2 Aug 2020 05:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgHBDLC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 1 Aug 2020 23:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgHBDLC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 1 Aug 2020 23:11:02 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C68C06174A
        for <bpf@vger.kernel.org>; Sat,  1 Aug 2020 20:11:01 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id z5so18073217pgb.6
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2020 20:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sa15gsBVaF+r5PMNXLTeqvajBbnJe5BOkFf7cOuDvTI=;
        b=jLvR0emTtmB8API4vK4mq7NttL2bs+NwKij/D4tfQCBl4UB3AmYJ2hhmyJxMAvb6Id
         FJQ4Gmo0P+sXEuiOy7kINA7fNyuFCg02Ws9DrKyODIHQ8TGkhlH4SMXuG+aYHsrVP3R0
         PThsxJqILLJnv80FrdLJLZGtN8YYlPpNHS96gA0Afw4AB5zyHu4eomYi0wXRg9t63YZg
         d9KFETdxY1qMUHoGkzhF7zkTZS9r+v0gVA9shoWmLHrqYxPGjUCxChbRszWe/8wBGbN0
         AvpytG/q9CskHW66sRR49one2hmZtdRyIdeDMhzQEbRHlXm5HnjOobuM8Dt0QddDLNrQ
         /LCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sa15gsBVaF+r5PMNXLTeqvajBbnJe5BOkFf7cOuDvTI=;
        b=WdDkG72pOlksbEVcfNJVXIHfAlyQMOLRFoc7Cp8TWGqSEsBbBB9/79+DbGkQkYnTP6
         EozSMWG/5WrtGegNEs+HAt320oS3SFOIal5cS5IhqslmApSNgrpdZJVOrXMZ0L7krQq0
         c/6+rVk1D6YC99QkW4BVXXWC3EjhF72IIMyr0HWjJa/W04nL0KlYJpiM1pcYQQQI6AJi
         MctU4uqUFfzzVfOpiDKPu3yMYpu8T/CYcKE/7BypUlxh3HJxrb5sBqz7aWuYMwvf8nLL
         mSIxCfFFAt1HJ/w74eb+ZCt+0HHrRqFA5biT4F9PDFCjVHMWUABl8suMKdcMurslU3IK
         roeg==
X-Gm-Message-State: AOAM532Ruc0lwDqLuzNzgB+RkqpM4cc7AVbh9KmToQplF7htu4ayeKGs
        tcwQOvLUtyXgXVOULJv3mxw=
X-Google-Smtp-Source: ABdhPJwW+aT1pAKBUs/tyAXwIeS4coOiccHDPmnEHlRWRaaALTeIQjHPoVeyJNtVgZXNRiPiMUp+8Q==
X-Received: by 2002:a62:ac05:: with SMTP id v5mr10487843pfe.8.1596337861022;
        Sat, 01 Aug 2020 20:11:01 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:65b5])
        by smtp.gmail.com with ESMTPSA id l16sm14574102pff.167.2020.08.01.20.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 20:11:00 -0700 (PDT)
Date:   Sat, 1 Aug 2020 20:10:58 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [bpf-next PATCH] bpf: Add comment in bpf verifier to note
 PTR_TO_BTF_ID can be null
Message-ID: <20200802031058.rk4rlygvbbmny3bl@ast-mbp.dhcp.thefacebook.com>
References: <159623491781.20514.14371382768486033310.stgit@john-XPS-13-9370>
 <CAEf4BzZ9=av=EvbyzhoyCg0ZvTOA2GBPgq5vyb1SaoNmqwL6XQ@mail.gmail.com>
 <5f262751ab97c_11b82ae318aac5b44d@john-XPS-13-9370.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f262751ab97c_11b82ae318aac5b44d@john-XPS-13-9370.notmuch>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Aug 01, 2020 at 07:39:13PM -0700, John Fastabend wrote:
> Andrii Nakryiko wrote:
> > On Fri, Jul 31, 2020 at 3:36 PM John Fastabend <john.fastabend@gmail.com> wrote:
> > >
> > > The verifier contains both types PTR_TO_BTF_ID and PTR_TO_BTF_ID_OR_NULL.
> > > For all other type pairs PTR_TO_foo and PTR_TO_foo_OR_NULL we follow the
> > > convention to use PTR_TO_foo_OR_NULL for pointers that may be null and
> > > PTR_TO_foo when the ptr value has been checked to ensure it is _not_ NULL.
> > >
> > > For PTR_TO_BTF_ID this is not the case though. It may be still be NULL
> > > even though we have the PTR_TO_BTF_ID type.
> > 
> > _OR_NULL means that the verifier enforces an explicit NULL check,
> > before allowing the BPF program to dereference corresponding
> > registers. That's not the case for PTR_TO_BTF_ID, though. The BPF
> > program is allowed to assume valid pointer and proceed without checks.
> > 
> > You are right that NULLs are still possible (as well as just invalid
> > pointers), but BPF JITs handle that by installing exception handlers
> > and zeroing out destination registers if it happens to be a NULL or
> > invalid pointer. This mimics bpf_probe_read() behavior, btw.
> 
> Yes aware of all this.
> 
> > 
> > So I think the way it's described and named in the verifier makes
> > sense, at least from the verifier's implementation point of view.
> 
> The other other problem with the proposed patch is it makes BTF_ID
> and BTF_ID_OR_NULL the same from the reg_type_str side which might
> make things a bit confusing.
> 
> I'm fine to drop this, but from the branch analysis side it still
> feels odd to me. I would need to look at it more to see what the
> side effects might be, but perhaps we should consider adding it
> to the list in reg_type_may_be_null(). OTOH this is not causing
> me any real problems at the moment just idle speculation so we
> can leave it alone for now.
> 
> > 
> > >
> > > Improve the comment here to reflect the current state and change the reg
> > > type string to indicate it may be null.  We should try to avoid this in
> > > future types, but its too much code churn to unwind at this point.
> > >
> > > Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> > > ---
> > >  include/linux/bpf.h   |    2 +-
> > >  kernel/bpf/verifier.c |    2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index 40c5e206ecf2..b9c192fe0d0f 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -352,7 +352,7 @@ enum bpf_reg_type {
> > >         PTR_TO_TCP_SOCK_OR_NULL, /* reg points to struct tcp_sock or NULL */
> > >         PTR_TO_TP_BUFFER,        /* reg points to a writable raw tp's buffer */
> > >         PTR_TO_XDP_SOCK,         /* reg points to struct xdp_sock */
> > > -       PTR_TO_BTF_ID,           /* reg points to kernel struct */
> > > +       PTR_TO_BTF_ID,           /* reg points to kernel struct or NULL */

John,

could you please add the summary of this discussion here as a comment?
I think it's too important to lose and it's better to stay as comment.

> > >         PTR_TO_BTF_ID_OR_NULL,   /* reg points to kernel struct or NULL */
> > >         PTR_TO_MEM,              /* reg points to valid memory region */
> > >         PTR_TO_MEM_OR_NULL,      /* reg points to valid memory region or NULL */
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index b6ccfce3bf4c..d657efcad47b 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -501,7 +501,7 @@ static const char * const reg_type_str[] = {
> > >         [PTR_TO_TCP_SOCK_OR_NULL] = "tcp_sock_or_null",
> > >         [PTR_TO_TP_BUFFER]      = "tp_buffer",
> > >         [PTR_TO_XDP_SOCK]       = "xdp_sock",
> > > -       [PTR_TO_BTF_ID]         = "ptr_",
> > > +       [PTR_TO_BTF_ID]         = "ptr_or_null_",

but this one I would keep as-is. imo ptr_ is more correct here.

> > >         [PTR_TO_BTF_ID_OR_NULL] = "ptr_or_null_",
> > >         [PTR_TO_MEM]            = "mem",
> > >         [PTR_TO_MEM_OR_NULL]    = "mem_or_null",
> > >
> 
> 
