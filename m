Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88366656DB5
	for <lists+bpf@lfdr.de>; Tue, 27 Dec 2022 18:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiL0Rtj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Dec 2022 12:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbiL0RtT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Dec 2022 12:49:19 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2891B1
        for <bpf@vger.kernel.org>; Tue, 27 Dec 2022 09:49:18 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id vm8so26538641ejc.2
        for <bpf@vger.kernel.org>; Tue, 27 Dec 2022 09:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EM8myhgzIl/hLVzBEkZldw4FFb+SHfO1TYtufJ5NHAk=;
        b=lgnIGYPYyELlUu5A1DuCuWqtRROVP3m12eht9yRXBucw95HHTRrY454YIfr0EiPLIp
         /Do8Em/ebjRB5r2FRjaSzapQb+uSQHyFrx3ugdCvhId8q/6H6FFx1CgT77naCLApFNpw
         8hOwz9e/UaRlTswxOUyMPsvmQx/FEmMVUjeI7qhmAm7gv7mRMstGVFEzlN6rMg5ZqtaE
         PUWvgnkVHEEB/W5UNZZazQjsF8Bh0XmMucI1nZeuSD7d9aywU6nEjbm4WZnzGW4LcEIu
         xANVGzPjWKhUoTmYbd0JpS32/rHuinbdZ1TU6s4CgGOdY5lcg1xG3wkwpEJpCkuaoKw2
         a+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EM8myhgzIl/hLVzBEkZldw4FFb+SHfO1TYtufJ5NHAk=;
        b=TZkptv2z2s9Yb0uSm1v67YopyKGuHIViKJwHVCQyYeadJpSNq25jtBs1rbEhMt1mAo
         S/31qN8fL7Vjb4i2udioI2zfXxeey85TShJ7lIW6UB7427Lu5IkR0crYNdWhDUIWjix7
         BSDEQO7as/P+kDMwx67mQpa3HcvjS8yBhWwS/G+WuD66iT/5767gbrCiXaJ3QjvKd37P
         msWECSAwg6KlZJv4id2JfHbKcIeNlLibzLNeRrGRME0EqLDXKTBe+U8Z25Bsdi/3Grn+
         Qu5jVZJz0fPE4NcQ0Ocixc1UmTTgAT8umuISyKPSeHgKFGr0VV13OAXgrRyaaK+tS3Fm
         9RUg==
X-Gm-Message-State: AFqh2kpXr3Ges2O/fAIN9CXIWuQEQhJj+0fkLJ8lbASCfYHH+r7nBPp8
        jc3znn5eAWWJLEubV/FC6tpBykRMIFyMGDsphhs=
X-Google-Smtp-Source: AMrXdXsRjoR1peXlyKN5/KXCONx5ogElWj8fOPx5atJaDb4nzV45m768fZI9LTRwdk6jtKN5Aa5/r3Dju6ll5bqqN7c=
X-Received: by 2002:a17:906:a18c:b0:7c0:f2cf:3515 with SMTP id
 s12-20020a170906a18c00b007c0f2cf3515mr1482742ejy.327.1672163357184; Tue, 27
 Dec 2022 09:49:17 -0800 (PST)
MIME-Version: 1.0
References: <CAADnVQ+pgN8m3ApZtk9Vr=iv+OcXcv5hhASCwP6ZJGt9Z2JvMw@mail.gmail.com>
 <20221227033528.1032724-1-stfomichev@yandex.ru>
In-Reply-To: <20221227033528.1032724-1-stfomichev@yandex.ru>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 27 Dec 2022 09:49:05 -0800
Message-ID: <CAADnVQJSTXOfsEunq=z+8tiQPSHpDmtXX3eP9QcM2QvBefgaag@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: restore the ebpf program ID for BPF_AUDIT_UNLOAD
 and PERF_BPF_EVENT_PROG_UNLOAD
To:     Stanislav Fomichev <stfomichev@yandex.ru>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Burn Alting <burn.alting@iinet.net.au>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@kernel.org>, linux-audit@redhat.com,
        Paul Moore <paul@paul-moore.com>,
        Stanislav Fomichev <sdf@google.com>
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

On Mon, Dec 26, 2022 at 7:35 PM Stanislav Fomichev <stfomichev@yandex.ru> wrote:
>
> > On Fri, Dec 23, 2022 at 5:49 PM Stanislav Fomichev <sdf@google.com> wrote:
> > get_func_ip() */
> > > > -                               tstamp_type_access:1; /* Accessed __sk_buff->tstamp_type */
> > > > +                               tstamp_type_access:1, /* Accessed __sk_buff->tstamp_type */
> > > > +                               valid_id:1; /* Is bpf_prog::aux::__id valid? */
> > > >         enum bpf_prog_type      type;           /* Type of BPF program */
> > > >         enum bpf_attach_type    expected_attach_type; /* For some prog types */
> > > >         u32                     len;            /* Number of filter blocks */
> > > > @@ -1688,6 +1689,12 @@ void bpf_prog_inc(struct bpf_prog *prog);
> > > >  struct bpf_prog * __must_check bpf_prog_inc_not_zero(struct bpf_prog *prog);
> > > >  void bpf_prog_put(struct bpf_prog *prog);
> > > >
> > > > +static inline u32 bpf_prog_get_id(const struct bpf_prog *prog)
> > > > +{
> > > > +       if (WARN(!prog->valid_id, "Attempting to use an invalid eBPF program"))
> > > > +               return 0;
> > > > +       return prog->aux->__id;
> > > > +}
> > >
> > > I'm still missing why we need to have this WARN and have a check at all.
> > > IIUC, we're actually too eager in resetting the id to 0, and need to
> > > keep that stale id around at least for perf/audit.
> > > Why not have a flag only to protect against double-idr_remove
> > > bpf_prog_free_id and keep the rest as is?
> > > Which places are we concerned about that used to report id=0 but now
> > > would report stale id?
> >
> > What double-idr_remove are you concerned about?
> > bpf_prog_by_id() is doing bpf_prog_inc_not_zero
> > while __bpf_prog_put just dropped it to zero.
>
> (traveling, sending from an untested setup, hope it reaches everyone)
>
> There is a call to bpf_prog_free_id from __bpf_prog_offload_destroy which
> tries to make offloaded program disappear from the idr when the netdev
> goes offline. So I'm assuming that '!prog->aux->id' check in bpf_prog_free_id
> is to handle that case where we do bpf_prog_free_id much earlier than the
> rest of the __bpf_prog_put stuff.

That remove was done in
commit ad8ad79f4f60 ("bpf: offload: free program id when device disappears")
Back in 2017 there was no bpf audit and no
PERF_BPF_EVENT_PROG_LOAD/UNLOAD events.

The removal of id made sense back then to avoid showing this
'useless' orphaned offloaded prog in 'bpftool prog show',
but with addition of perf load/unload and audit it was no longer
correct to zero out ID in a prog which refcnt is still not zero.

So we should simply remove bpf_prog_free_id from __bpf_prog_offload_destroy.
There won't be any adverse effect other than bpftool prog show
will show orphaned progs.

>
> > Maybe just move bpf_prog_free_id() into bpf_prog_put_deferred()
> > after perf_event_bpf_event and bpf_audit_prog ?
> > Probably can remove the obsolete do_idr_lock bool flag as
> > separate patch?
>
> +1 on removing do_idr_lock separately.
>
> > Much simpler fix and no code churn.
> > Both valid_id and saved_id approaches have flaws.
>
> Given the __bpf_prog_offload_destroy path above, we still probably need
> some flag to indicate that the id has been already removed from the idr?

No. ID should be valid until prog went through perf and audit unload
events. Don't know about audit, but for perf it's essential to have
valid ID otherwise perf record will not be able to properly associate events.
