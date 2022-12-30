Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F93659457
	for <lists+bpf@lfdr.de>; Fri, 30 Dec 2022 04:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbiL3DKt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Dec 2022 22:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiL3DKs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Dec 2022 22:10:48 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7461145
        for <bpf@vger.kernel.org>; Thu, 29 Dec 2022 19:10:47 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id z11so13124189ede.1
        for <bpf@vger.kernel.org>; Thu, 29 Dec 2022 19:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RYVyCUcNeUublLPHcN05eG9pncvtlfHo7DgzMDH0eOE=;
        b=gx3TtjW2x5FMkD/N9DP/wi/9dxqt86Nqs65jaUsC/Ah63zhc85QORFk/nzjcTBRHsg
         KfWi/buJPLaliYPTCNRXuLlBl1IdHkd4Ehjk9R/kKFZ6iLM8iif0SkffNOM8QYcER9BB
         A9Y3pM8q3NyXBV9N7KbnabNnTqT6IrqqE0TZpUkJLyuRzJNT9N160RSb7LmFtP20lR+h
         /MT+AKOAXvzGFLy8D4WoN6Wa1/7S1blhFMP+rqre7QgXp08oZ2qJ6XybqpRFi5v5sAlz
         bCGX82XZJxUeJyDPO2jL8zkYNct6SZiVAcC/rC2Rop7bqONOBGbC0GoYsSmrtMEh1+WM
         8Idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RYVyCUcNeUublLPHcN05eG9pncvtlfHo7DgzMDH0eOE=;
        b=uAQBLT7jNQ4L5igY8LCjmc4yATyLEPSItACNjH/8op8zCc8Xu1KOXQNHReP4e+TQck
         ddJo6zG5XS+IhxorW1LG2WlrsldqECBbOXp6/2GBGb3uiJ3TSbWjVxCSab1n/I6w069e
         E2UOHh5rrYE2FvEOT/vHCyiZv/vJFd+BdOnlHWiEuoG9nA4wE41zCAg1fCN4B7yAl79W
         dio2B5ECTJY9u7/Gf5o926kcE5LD7fTH1EcdeDYvG9uJcl3cDfj3VJdKrE38qkDXaHvp
         YwWuJo4oJ882b+4UB5zdv02As35a9xNrdzOn14qjFPSFoeISjddmqJDXBPmHyrD7ihMq
         cMZg==
X-Gm-Message-State: AFqh2kqQmFSGBnI7LhuwaNcoeOtguI4NBYxTmp/+x5eQxq9ikPU5CW6F
        hDSBY3k6jEn0jM27RXaszUGWkSuXr2aZ2OiP96Y=
X-Google-Smtp-Source: AMrXdXv8lhfFwhvMHXOYCAWn8XSH0zwxTxnM1xtWQg9Niy9ULRwY/QpRJo/sRzYL3JsRT6SYtwiuyQEankecE6v1n+E=
X-Received: by 2002:aa7:d417:0:b0:482:6f7c:398 with SMTP id
 z23-20020aa7d417000000b004826f7c0398mr1821320edq.6.1672369846391; Thu, 29 Dec
 2022 19:10:46 -0800 (PST)
MIME-Version: 1.0
References: <CAADnVQ+pgN8m3ApZtk9Vr=iv+OcXcv5hhASCwP6ZJGt9Z2JvMw@mail.gmail.com>
 <20221227033528.1032724-1-stfomichev@yandex.ru> <1855474adf8.28e3.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <CAKH8qBvR3=sSGvgGB_CqCFZhKynxdgatCK7N0mBZs1gBPDvTWw@mail.gmail.com>
In-Reply-To: <CAKH8qBvR3=sSGvgGB_CqCFZhKynxdgatCK7N0mBZs1gBPDvTWw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 29 Dec 2022 19:10:34 -0800
Message-ID: <CAADnVQ+MRTYs9sbN4a1oAV7TJ2bqRS4QE9ShmofQ9M--KQducg@mail.gmail.com>
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

On Thu, Dec 29, 2022 at 6:13 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> On Tue, Dec 27, 2022 at 8:40 AM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On December 26, 2022 10:35:49 PM Stanislav Fomichev <stfomichev@yandex.ru>
> > wrote:
> > >> On Fri, Dec 23, 2022 at 5:49 PM Stanislav Fomichev <sdf@google.com> wrote:
> > >> get_func_ip() */
> > >>>> -                               tstamp_type_access:1; /* Accessed
> > >>>> __sk_buff->tstamp_type */
> > >>>> +                               tstamp_type_access:1, /* Accessed
> > >>>> __sk_buff->tstamp_type */
> > >>>> +                               valid_id:1; /* Is bpf_prog::aux::__id valid? */
> > >>>>    enum bpf_prog_type      type;           /* Type of BPF program */
> > >>>>    enum bpf_attach_type    expected_attach_type; /* For some prog types */
> > >>>>    u32                     len;            /* Number of filter blocks */
> > >>>> @@ -1688,6 +1689,12 @@ void bpf_prog_inc(struct bpf_prog *prog);
> > >>>> struct bpf_prog * __must_check bpf_prog_inc_not_zero(struct bpf_prog *prog);
> > >>>> void bpf_prog_put(struct bpf_prog *prog);
> > >>>>
> > >>>> +static inline u32 bpf_prog_get_id(const struct bpf_prog *prog)
> > >>>> +{
> > >>>> +       if (WARN(!prog->valid_id, "Attempting to use an invalid eBPF program"))
> > >>>> +               return 0;
> > >>>> +       return prog->aux->__id;
> > >>>> +}
> > >>>
> > >>> I'm still missing why we need to have this WARN and have a check at all.
> > >>> IIUC, we're actually too eager in resetting the id to 0, and need to
> > >>> keep that stale id around at least for perf/audit.
> > >>> Why not have a flag only to protect against double-idr_remove
> > >>> bpf_prog_free_id and keep the rest as is?
> > >>> Which places are we concerned about that used to report id=0 but now
> > >>> would report stale id?
> > >>
> > >> What double-idr_remove are you concerned about?
> > >> bpf_prog_by_id() is doing bpf_prog_inc_not_zero
> > >> while __bpf_prog_put just dropped it to zero.
> > >
> > > (traveling, sending from an untested setup, hope it reaches everyone)
> > >
> > > There is a call to bpf_prog_free_id from __bpf_prog_offload_destroy which
> > > tries to make offloaded program disappear from the idr when the netdev
> > > goes offline. So I'm assuming that '!prog->aux->id' check in bpf_prog_free_id
> > > is to handle that case where we do bpf_prog_free_id much earlier than the
> > > rest of the __bpf_prog_put stuff.
> > >
> > >> Maybe just move bpf_prog_free_id() into bpf_prog_put_deferred()
> > >> after perf_event_bpf_event and bpf_audit_prog ?
> > >> Probably can remove the obsolete do_idr_lock bool flag as
> > >> separate patch?
> > >
> > > +1 on removing do_idr_lock separately.
> > >
> > >> Much simpler fix and no code churn.
> > >> Both valid_id and saved_id approaches have flaws.
> > >
> > > Given the __bpf_prog_offload_destroy path above, we still probably need
> > > some flag to indicate that the id has been already removed from the idr?
> >
> > So what do you guys want in a patch?  Is there a consensus on what you
> > would merge to fix this bug/regression?
>
> Can we try the following?
>
> 1. Remove calls to bpf_prog_free_id (and bpf_map_free_id?) from
> kernel/bpf/offload.c; that should make it easier to reason about those
> '!id' checks

calls? you mean a single call, right?

> 2. Move bpf_prog_free_id (and bpf_map_free_id?) to happen after
> audit/perf in kernel/bpf/syscall.c (there are comments that say "must
> be called first", but I don't see why; seems like GET_FD_BY_ID would
> correctly return -ENOENT; maybe Martin can chime in, CC'ed him
> explicitly)

The comment says that it should be removed from idr
before __bpf_prog_put_noref will proceed to clean up.

> 3. (optionally) Remove do_idr_lock arguments (all callers are passing 'true')

yes. please.
