Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B04A50F322
	for <lists+bpf@lfdr.de>; Tue, 26 Apr 2022 09:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241494AbiDZHzy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Apr 2022 03:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344488AbiDZHzo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Apr 2022 03:55:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E07E06479
        for <bpf@vger.kernel.org>; Tue, 26 Apr 2022 00:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650959556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CsyLdgIfz/J4d2JXrqNRHu2e24b1rKeyXKBpw9KICek=;
        b=hpI9D3hdKUBcErjnzmy2fFbCKRpPR0Ir10rCunLhBZzLCQMEgdTX1ejfn3gYW3/7d/G1j/
        Y30WvYjmeEVp0d2D8Bg6lS7tQmBVBgZ5Pmh7p/x2AzdrMdU7dBjv3nkJeb0WHGVMg2AlvC
        oeBxwRIHEzSJEmQ5kS9PROUlAhnAbL8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-BtN1jQWpMyKqkjqbCpORgQ-1; Tue, 26 Apr 2022 03:52:34 -0400
X-MC-Unique: BtN1jQWpMyKqkjqbCpORgQ-1
Received: by mail-pl1-f198.google.com with SMTP id j10-20020a170903024a00b0015d18032e32so3346711plh.8
        for <bpf@vger.kernel.org>; Tue, 26 Apr 2022 00:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CsyLdgIfz/J4d2JXrqNRHu2e24b1rKeyXKBpw9KICek=;
        b=orTXvDCH9PpypKivCcCwMX/58s3QLEMbk0+iJf6lcHLdnXtsC5y7+fRUNXVQKSvD9I
         DnsG/DDeYEg9GYDCJ4+Qt4Tlquz9RWWCt0824W2YTOoOFepkgD1qSXPO1cDFr6FeAck2
         FdpyQXMsZijgok0mkf7fmn9aBPpcHE29eBhG7pr01Gs3gXk0xrUtr+eqawTV3HQgzhrP
         bySRtKBF/a0YxiyCQIMrwmEYd2f3Cla+5qzqowo55ewCDux2dp8t8a57Xy6yqHyPVvk0
         hyzwTUd223tfzCRJvhBKyW4q+C+yRruWcx0bhAralC6yIpCNCWu5vXJHoQ1KHA64tIjP
         xAxA==
X-Gm-Message-State: AOAM531STk7aqRQArsyEa87IbtjgLB47IO2iinbkn7DNHn2ir17vW7S6
        LvoqiktO0KUI7T3GOQUsTxiBOQ9ywg2Zu0MCnVwdqPTffXb95Z4xy0Ar7pCce9FNjCSe1lkdfnb
        HIwmhziTRBOtkJiu3d4G0PloykV2B
X-Received: by 2002:a63:5606:0:b0:3ab:84d3:cfbe with SMTP id k6-20020a635606000000b003ab84d3cfbemr2870542pgb.191.1650959553260;
        Tue, 26 Apr 2022 00:52:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrJqOAdclf97Ql1V/uWaKgsj2lBg1ANvXOzN4QoIaBsxQuxtoa4/Mg1H2hEbADxlqqfMdefO+faiELkv9d+X0=
X-Received: by 2002:a63:5606:0:b0:3ab:84d3:cfbe with SMTP id
 k6-20020a635606000000b003ab84d3cfbemr2870516pgb.191.1650959552946; Tue, 26
 Apr 2022 00:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220421140740.459558-1-benjamin.tissoires@redhat.com>
 <20220421140740.459558-4-benjamin.tissoires@redhat.com> <20220426041147.gwnxhcjftl2kaz6g@MBP-98dd607d3435.dhcp.thefacebook.com>
In-Reply-To: <20220426041147.gwnxhcjftl2kaz6g@MBP-98dd607d3435.dhcp.thefacebook.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 26 Apr 2022 09:52:21 +0200
Message-ID: <CAO-hwJLWxtZcs-ynzAaF4hGf6zPF5wAni3Etzb1_XrvQpx2Jxw@mail.gmail.com>
Subject: Re: [RFC bpf-next v4 3/7] error-inject: add new type that carries if
 the function is non sleepable
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 26, 2022 at 6:11 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Apr 21, 2022 at 04:07:36PM +0200, Benjamin Tissoires wrote:
> > When using error-injection function through bpf to change the return
> > code, we need to know if the function is sleepable or not.
> >
> > Currently the code assumes that all error-inject functions are sleepable,
> > except for a few selected of them, hardcoded in kernel/bpf/verifier.c
> >
> > Add a new flag to error-inject so we can code that information where the
> > function is declared.
> >
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >
> > ---
> >
> > new in v4:
> > - another approach would be to define a new kfunc_set, and register
> >   it with btf. But in that case, what program type would we use?
> >   BPF_PROG_TYPE_UNSPEC?
> > - also note that maybe we should consider all of the functions
> >   non-sleepable and only mark some as sleepable. IMO it makes more
> >   sense to be more restrictive by default.
>
> I think the approach in this patch is fine.
> We didn't have issues with check_non_sleepable_error_inject() so far,
> so I wouldn't start refactoring it.

OK... though I can't help but thinking that adding a new
error-inject.h enum value is going to be bad, because it's an API
change, and users might not expect NS_ERRNO.

OTOH, if we had a new kfunc_set, we keep the existing error-inject API
in place with all the variants and we just teach the verifier that the
function is non sleepable.

>
> > ---
> >  include/asm-generic/error-injection.h |  1 +
> >  kernel/bpf/verifier.c                 | 10 ++++++++--
> >  lib/error-inject.c                    |  2 ++
> >  3 files changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/asm-generic/error-injection.h b/include/asm-generic/error-injection.h
> > index fbca56bd9cbc..5974942353a6 100644
> > --- a/include/asm-generic/error-injection.h
> > +++ b/include/asm-generic/error-injection.h
> > @@ -9,6 +9,7 @@ enum {
> >       EI_ETYPE_ERRNO,         /* Return -ERRNO if failure */
> >       EI_ETYPE_ERRNO_NULL,    /* Return -ERRNO or NULL if failure */
> >       EI_ETYPE_TRUE,          /* Return true if failure */
> > +     EI_ETYPE_NS_ERRNO,      /* Return -ERRNO if failure and tag the function as non-sleepable */
>
> >  };
> >
> >  struct error_injection_entry {
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 0f339f9058f3..45c8feea6478 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -14085,6 +14085,11 @@ static int check_non_sleepable_error_inject(u32 btf_id)
> >       return btf_id_set_contains(&btf_non_sleepable_error_inject, btf_id);
> >  }
> >
> > +static int is_non_sleepable_error_inject(unsigned long addr)
> > +{
> > +     return get_injectable_error_type(addr) == EI_ETYPE_NS_ERRNO;
>
> It's a linear search. Probably ok. But would be good to double check
> that we're not calling it a lot.

IIUC, the kfunc_set approach would solve that, no?

Cheers,
Benjamin

>
> > +}
> > +
> >  int bpf_check_attach_target(struct bpf_verifier_log *log,
> >                           const struct bpf_prog *prog,
> >                           const struct bpf_prog *tgt_prog,
> > @@ -14281,8 +14286,9 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
> >                               /* fentry/fexit/fmod_ret progs can be sleepable only if they are
> >                                * attached to ALLOW_ERROR_INJECTION and are not in denylist.
> >                                */
> > -                             if (!check_non_sleepable_error_inject(btf_id) &&
> > -                                 within_error_injection_list(addr))
> > +                             if (within_error_injection_list(addr) &&
> > +                                 !check_non_sleepable_error_inject(btf_id) &&
> > +                                 !is_non_sleepable_error_inject(addr))
> >                                       ret = 0;
> >                               break;
> >                       case BPF_PROG_TYPE_LSM:
> > diff --git a/lib/error-inject.c b/lib/error-inject.c
> > index 2ff5ef689d72..560c3b18f439 100644
> > --- a/lib/error-inject.c
> > +++ b/lib/error-inject.c
> > @@ -183,6 +183,8 @@ static const char *error_type_string(int etype)
> >               return "ERRNO_NULL";
> >       case EI_ETYPE_TRUE:
> >               return "TRUE";
> > +     case EI_ETYPE_NS_ERRNO:
> > +             return "NS_ERRNO";
> >       default:
> >               return "(unknown)";
> >       }
> > --
> > 2.35.1
> >
>

