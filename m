Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8CF65949E
	for <lists+bpf@lfdr.de>; Fri, 30 Dec 2022 05:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiL3ETL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Dec 2022 23:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiL3ETI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Dec 2022 23:19:08 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96D11183F
        for <bpf@vger.kernel.org>; Thu, 29 Dec 2022 20:18:59 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id u18so27714078eda.9
        for <bpf@vger.kernel.org>; Thu, 29 Dec 2022 20:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5LDRs4PLNOZi6E/lSAZ1su22s9pgjU7A0PvegEN5lh0=;
        b=OuKcCEY6XPX/zYYZylNcbFQqz9n1ZW0CyBsrryxI8oVcYi2QU27McWJu2BXUQK3jXb
         zuDj3qFjBbbZwsSPfB3YW1t26iCIVutV9RUIQkjjKT3qYkrJhzAAZvEjJRcJDBunCUnx
         BzkT5jGO//W2h4JxKT0C4ph2FGWJtkg9ztgjLYdkz2F66vbbrKNjCSbmaBD8ySHscVYt
         rFJ6XaU1dwF5v2m3W+2nRSqjeqsAmFCngeVjiA/GcRONsPhktTV5KyIaEQtFAKttqjpg
         TKWNc1WUr/10BYM8OSNhAuNgHLoUsCV0VjNA/DiXwaJ17lBFkswUWmvDoaJaEIGABPzm
         rOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5LDRs4PLNOZi6E/lSAZ1su22s9pgjU7A0PvegEN5lh0=;
        b=4JEUW3Q704XKJxulJwO1uvBT9YwolEXT3CtxZg1KYBDg9H17SC7RAkDsGyUv7EVzDv
         tAjZ053Wp6dEKrbNR4np06boTpCL6YuuL4Cq6pvMtlvbhmfBD3QWCeZA25Wzpe1ZQ8+X
         uxyTyCT+JeDdeWWwOtD7X3pHy2TM4VL8xUQYaYQGknCOd5lqbbaFrf/CRIfLQ8Ow3vsI
         zVt/YG2aC2Cqen11S2ZkG4jigXh3vecSNO5SaxTZsUDiUl2Gk/BlGAQp7eP15m6OUYVj
         OT9EFf2YZc9UqMcTMG+ZgM2ERQzISYPpmiPIOEKTrSDVmmHjOASp/J2TwYrLIChjbepB
         soDQ==
X-Gm-Message-State: AFqh2krWWTOtI8Agw+EcGSBKbFQ+pv3ach4PhcRRrJzcMB1T5OJx2/h3
        GL2ThOl/KewhaEhdMgNga3b+GWvmlJ+GNmXSib8=
X-Google-Smtp-Source: AMrXdXtbxD3Aujg79QuPh+xUGj42jdrm4/O9QSW2CkQVl5lyICwYNx414FNSXM9JH5jWFcqWXWMspQ7PDmby+x/zwKU=
X-Received: by 2002:aa7:d7c6:0:b0:486:9f80:8fbc with SMTP id
 e6-20020aa7d7c6000000b004869f808fbcmr1497251eds.421.1672373938065; Thu, 29
 Dec 2022 20:18:58 -0800 (PST)
MIME-Version: 1.0
References: <CAADnVQ+pgN8m3ApZtk9Vr=iv+OcXcv5hhASCwP6ZJGt9Z2JvMw@mail.gmail.com>
 <20221227033528.1032724-1-stfomichev@yandex.ru> <1855474adf8.28e3.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <CAKH8qBvR3=sSGvgGB_CqCFZhKynxdgatCK7N0mBZs1gBPDvTWw@mail.gmail.com>
 <CAADnVQ+MRTYs9sbN4a1oAV7TJ2bqRS4QE9ShmofQ9M--KQducg@mail.gmail.com> <CAKH8qBsN+ypbKyE-oiTzmH06ML71TmN9zqEr4=6KvXwt8TE0QQ@mail.gmail.com>
In-Reply-To: <CAKH8qBsN+ypbKyE-oiTzmH06ML71TmN9zqEr4=6KvXwt8TE0QQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 29 Dec 2022 20:18:46 -0800
Message-ID: <CAADnVQ+JswT0KE_mwshO-igoP-LYLCOco61+FGP+opY4xES8Eg@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: restore the ebpf program ID for BPF_AUDIT_UNLOAD
 and PERF_BPF_EVENT_PROG_UNLOAD
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stanislav Fomichev <stfomichev@yandex.ru>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Burn Alting <burn.alting@iinet.net.au>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@kernel.org>, linux-audit@redhat.com,
        Martin KaFai Lau <martin.lau@linux.dev>
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

On Thu, Dec 29, 2022 at 7:38 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> On Thu, Dec 29, 2022 at 7:10 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Dec 29, 2022 at 6:13 PM Stanislav Fomichev <sdf@google.com> wrote:
> > >
> > > On Tue, Dec 27, 2022 at 8:40 AM Paul Moore <paul@paul-moore.com> wrote:
> > > >
> > > > On December 26, 2022 10:35:49 PM Stanislav Fomichev <stfomichev@yandex.ru>
> > > > wrote:
> > > > >> On Fri, Dec 23, 2022 at 5:49 PM Stanislav Fomichev <sdf@google.com> wrote:
> > > > >> get_func_ip() */
> > > > >>>> -                               tstamp_type_access:1; /* Accessed
> > > > >>>> __sk_buff->tstamp_type */
> > > > >>>> +                               tstamp_type_access:1, /* Accessed
> > > > >>>> __sk_buff->tstamp_type */
> > > > >>>> +                               valid_id:1; /* Is bpf_prog::aux::__id valid? */
> > > > >>>>    enum bpf_prog_type      type;           /* Type of BPF program */
> > > > >>>>    enum bpf_attach_type    expected_attach_type; /* For some prog types */
> > > > >>>>    u32                     len;            /* Number of filter blocks */
> > > > >>>> @@ -1688,6 +1689,12 @@ void bpf_prog_inc(struct bpf_prog *prog);
> > > > >>>> struct bpf_prog * __must_check bpf_prog_inc_not_zero(struct bpf_prog *prog);
> > > > >>>> void bpf_prog_put(struct bpf_prog *prog);
> > > > >>>>
> > > > >>>> +static inline u32 bpf_prog_get_id(const struct bpf_prog *prog)
> > > > >>>> +{
> > > > >>>> +       if (WARN(!prog->valid_id, "Attempting to use an invalid eBPF program"))
> > > > >>>> +               return 0;
> > > > >>>> +       return prog->aux->__id;
> > > > >>>> +}
> > > > >>>
> > > > >>> I'm still missing why we need to have this WARN and have a check at all.
> > > > >>> IIUC, we're actually too eager in resetting the id to 0, and need to
> > > > >>> keep that stale id around at least for perf/audit.
> > > > >>> Why not have a flag only to protect against double-idr_remove
> > > > >>> bpf_prog_free_id and keep the rest as is?
> > > > >>> Which places are we concerned about that used to report id=0 but now
> > > > >>> would report stale id?
> > > > >>
> > > > >> What double-idr_remove are you concerned about?
> > > > >> bpf_prog_by_id() is doing bpf_prog_inc_not_zero
> > > > >> while __bpf_prog_put just dropped it to zero.
> > > > >
> > > > > (traveling, sending from an untested setup, hope it reaches everyone)
> > > > >
> > > > > There is a call to bpf_prog_free_id from __bpf_prog_offload_destroy which
> > > > > tries to make offloaded program disappear from the idr when the netdev
> > > > > goes offline. So I'm assuming that '!prog->aux->id' check in bpf_prog_free_id
> > > > > is to handle that case where we do bpf_prog_free_id much earlier than the
> > > > > rest of the __bpf_prog_put stuff.
> > > > >
> > > > >> Maybe just move bpf_prog_free_id() into bpf_prog_put_deferred()
> > > > >> after perf_event_bpf_event and bpf_audit_prog ?
> > > > >> Probably can remove the obsolete do_idr_lock bool flag as
> > > > >> separate patch?
> > > > >
> > > > > +1 on removing do_idr_lock separately.
> > > > >
> > > > >> Much simpler fix and no code churn.
> > > > >> Both valid_id and saved_id approaches have flaws.
> > > > >
> > > > > Given the __bpf_prog_offload_destroy path above, we still probably need
> > > > > some flag to indicate that the id has been already removed from the idr?
> > > >
> > > > So what do you guys want in a patch?  Is there a consensus on what you
> > > > would merge to fix this bug/regression?
> > >
> > > Can we try the following?
> > >
> > > 1. Remove calls to bpf_prog_free_id (and bpf_map_free_id?) from
> > > kernel/bpf/offload.c; that should make it easier to reason about those
> > > '!id' checks
> >
> > calls? you mean a single call, right?
>
> Right, there is a single call to bpf_prog_free_id. But there is also
> another single call to bpf_map_free_id with the same "remove it from
> idr so it can't be found if GET_NEXT_ID" reasoning.

map offloading is different from prog offload.
Like:
        if (bpf_map_is_dev_bound(map))
                return bpf_map_offload_lookup_elem(map, key, value);

gotta be much more careful with them and offload.

> It's probably worth it to look into whether we can remove it as well
> to have consistent id management for progs and maps?

I'd rather not at this point.
Consistency sounds nice, but requires a ton more work.

> > > 2. Move bpf_prog_free_id (and bpf_map_free_id?) to happen after
> > > audit/perf in kernel/bpf/syscall.c (there are comments that say "must
> > > be called first", but I don't see why; seems like GET_FD_BY_ID would
> > > correctly return -ENOENT; maybe Martin can chime in, CC'ed him
> > > explicitly)
> >
> > The comment says that it should be removed from idr
> > before __bpf_prog_put_noref will proceed to clean up.
>
> Which one? I was trying to see if there is any reasoning in the
> original commit 34ad5580f8f9 ("bpf: Add BPF_(PROG|MAP)_GET_NEXT_ID
> command"), but couldn't find anything useful :-(

Maybe back then we didn't have atomic_inc_not_zero(prog/map->refcnt) ?
I don't really recall what race we were worried about.

> > > 3. (optionally) Remove do_idr_lock arguments (all callers are passing 'true')
> >
> > yes. please.
