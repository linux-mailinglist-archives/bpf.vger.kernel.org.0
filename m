Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA9B659468
	for <lists+bpf@lfdr.de>; Fri, 30 Dec 2022 04:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiL3Dif (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Dec 2022 22:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiL3Did (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Dec 2022 22:38:33 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F83518389
        for <bpf@vger.kernel.org>; Thu, 29 Dec 2022 19:38:32 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id jl4so14447960plb.8
        for <bpf@vger.kernel.org>; Thu, 29 Dec 2022 19:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5fydax2I5e8hodR7TsTth7TEIP2I2sf/t20unGpGvPU=;
        b=U6Pp9ruQQHbezeJRx0weI9Y7dOKH1Ye00AMfT/WK3gTlAExt8VIClGJ04o2sIwhJ4g
         G99cVPmwQrYphw6Uatp1VEC2uY2TX0Ih9No+Eqn8FIbA/BIJBy6R57zjhoPo4UY2UetC
         UnpAAgSTzatT6FfsTfpcMCphTP0oe+tGBJZC71Kr0JdCyUAANs0b0j6QMb9CCVrkqCmX
         1+v//guhZlyBA1UaT/W+v3PPF6lKSjZNhyW2aD/Tk6NbnVft8O1bGlVK5OZZjFQu12Oi
         34UGHzGvuU2zSoSZhORjWV078craW6eNdX1CiddsVpQudfCxny9d3W1KQhNXlpQ1SGiL
         txIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5fydax2I5e8hodR7TsTth7TEIP2I2sf/t20unGpGvPU=;
        b=7nB6MUzKnWs3q3y6m5D85YJUNR0/WLgznWyVlr+BbWCwkBO2+U0vlDhwwqvEkIx1OQ
         GEHuuqyGygrWO1p/WEybKAXXXPz8VgittzmfHflHAn4vXb14qxHaPS39kUFQcOPyYEKf
         LBJVHNmXnhkYkia72CamtJ3DvpwOppcW0sGz/BKJoiJL7PssLH6RnjzAr9bK1XCphfbS
         pZ6yuQBNLTzUa9bNnLNN81w/C4u/Gkw99EvEC5+vXRAHfhpJyImVYtlNMG8dyACx7dhP
         +2s6HYjQWFc7+2EuVBYGsXSRQxya6YsU4uaysCGUUgVK1Mup5UzoSOD/vzJn0zWtjlgB
         otOg==
X-Gm-Message-State: AFqh2kpvNrwEVSoJ9E7VQLCuu01VTkX/uYREbTyrCUiHJwhqtJCxql9d
        zkvZ+HGGeQ8+Mp5DpUVrW4XmlxXcaQ10xmmL85dAwA==
X-Google-Smtp-Source: AMrXdXv4sT7d1E5xTQ1OLVal0h9ETKqceM6oFv050lNNRkQVd8/d3SOuoUbV3z1O+qFefPhXQrIQU9To83Ly6L2v+do=
X-Received: by 2002:a17:902:b20d:b0:191:283d:612e with SMTP id
 t13-20020a170902b20d00b00191283d612emr1471231plr.88.1672371511611; Thu, 29
 Dec 2022 19:38:31 -0800 (PST)
MIME-Version: 1.0
References: <CAADnVQ+pgN8m3ApZtk9Vr=iv+OcXcv5hhASCwP6ZJGt9Z2JvMw@mail.gmail.com>
 <20221227033528.1032724-1-stfomichev@yandex.ru> <1855474adf8.28e3.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <CAKH8qBvR3=sSGvgGB_CqCFZhKynxdgatCK7N0mBZs1gBPDvTWw@mail.gmail.com> <CAADnVQ+MRTYs9sbN4a1oAV7TJ2bqRS4QE9ShmofQ9M--KQducg@mail.gmail.com>
In-Reply-To: <CAADnVQ+MRTYs9sbN4a1oAV7TJ2bqRS4QE9ShmofQ9M--KQducg@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 29 Dec 2022 19:38:19 -0800
Message-ID: <CAKH8qBsN+ypbKyE-oiTzmH06ML71TmN9zqEr4=6KvXwt8TE0QQ@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: restore the ebpf program ID for BPF_AUDIT_UNLOAD
 and PERF_BPF_EVENT_PROG_UNLOAD
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stanislav Fomichev <stfomichev@yandex.ru>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Burn Alting <burn.alting@iinet.net.au>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@kernel.org>, linux-audit@redhat.com,
        Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 29, 2022 at 7:10 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Dec 29, 2022 at 6:13 PM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > On Tue, Dec 27, 2022 at 8:40 AM Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > On December 26, 2022 10:35:49 PM Stanislav Fomichev <stfomichev@yandex.ru>
> > > wrote:
> > > >> On Fri, Dec 23, 2022 at 5:49 PM Stanislav Fomichev <sdf@google.com> wrote:
> > > >> get_func_ip() */
> > > >>>> -                               tstamp_type_access:1; /* Accessed
> > > >>>> __sk_buff->tstamp_type */
> > > >>>> +                               tstamp_type_access:1, /* Accessed
> > > >>>> __sk_buff->tstamp_type */
> > > >>>> +                               valid_id:1; /* Is bpf_prog::aux::__id valid? */
> > > >>>>    enum bpf_prog_type      type;           /* Type of BPF program */
> > > >>>>    enum bpf_attach_type    expected_attach_type; /* For some prog types */
> > > >>>>    u32                     len;            /* Number of filter blocks */
> > > >>>> @@ -1688,6 +1689,12 @@ void bpf_prog_inc(struct bpf_prog *prog);
> > > >>>> struct bpf_prog * __must_check bpf_prog_inc_not_zero(struct bpf_prog *prog);
> > > >>>> void bpf_prog_put(struct bpf_prog *prog);
> > > >>>>
> > > >>>> +static inline u32 bpf_prog_get_id(const struct bpf_prog *prog)
> > > >>>> +{
> > > >>>> +       if (WARN(!prog->valid_id, "Attempting to use an invalid eBPF program"))
> > > >>>> +               return 0;
> > > >>>> +       return prog->aux->__id;
> > > >>>> +}
> > > >>>
> > > >>> I'm still missing why we need to have this WARN and have a check at all.
> > > >>> IIUC, we're actually too eager in resetting the id to 0, and need to
> > > >>> keep that stale id around at least for perf/audit.
> > > >>> Why not have a flag only to protect against double-idr_remove
> > > >>> bpf_prog_free_id and keep the rest as is?
> > > >>> Which places are we concerned about that used to report id=0 but now
> > > >>> would report stale id?
> > > >>
> > > >> What double-idr_remove are you concerned about?
> > > >> bpf_prog_by_id() is doing bpf_prog_inc_not_zero
> > > >> while __bpf_prog_put just dropped it to zero.
> > > >
> > > > (traveling, sending from an untested setup, hope it reaches everyone)
> > > >
> > > > There is a call to bpf_prog_free_id from __bpf_prog_offload_destroy which
> > > > tries to make offloaded program disappear from the idr when the netdev
> > > > goes offline. So I'm assuming that '!prog->aux->id' check in bpf_prog_free_id
> > > > is to handle that case where we do bpf_prog_free_id much earlier than the
> > > > rest of the __bpf_prog_put stuff.
> > > >
> > > >> Maybe just move bpf_prog_free_id() into bpf_prog_put_deferred()
> > > >> after perf_event_bpf_event and bpf_audit_prog ?
> > > >> Probably can remove the obsolete do_idr_lock bool flag as
> > > >> separate patch?
> > > >
> > > > +1 on removing do_idr_lock separately.
> > > >
> > > >> Much simpler fix and no code churn.
> > > >> Both valid_id and saved_id approaches have flaws.
> > > >
> > > > Given the __bpf_prog_offload_destroy path above, we still probably need
> > > > some flag to indicate that the id has been already removed from the idr?
> > >
> > > So what do you guys want in a patch?  Is there a consensus on what you
> > > would merge to fix this bug/regression?
> >
> > Can we try the following?
> >
> > 1. Remove calls to bpf_prog_free_id (and bpf_map_free_id?) from
> > kernel/bpf/offload.c; that should make it easier to reason about those
> > '!id' checks
>
> calls? you mean a single call, right?

Right, there is a single call to bpf_prog_free_id. But there is also
another single call to bpf_map_free_id with the same "remove it from
idr so it can't be found if GET_NEXT_ID" reasoning.
It's probably worth it to look into whether we can remove it as well
to have consistent id management for progs and maps?

> > 2. Move bpf_prog_free_id (and bpf_map_free_id?) to happen after
> > audit/perf in kernel/bpf/syscall.c (there are comments that say "must
> > be called first", but I don't see why; seems like GET_FD_BY_ID would
> > correctly return -ENOENT; maybe Martin can chime in, CC'ed him
> > explicitly)
>
> The comment says that it should be removed from idr
> before __bpf_prog_put_noref will proceed to clean up.

Which one? I was trying to see if there is any reasoning in the
original commit 34ad5580f8f9 ("bpf: Add BPF_(PROG|MAP)_GET_NEXT_ID
command"), but couldn't find anything useful :-(

> > 3. (optionally) Remove do_idr_lock arguments (all callers are passing 'true')
>
> yes. please.
