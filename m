Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74FE659423
	for <lists+bpf@lfdr.de>; Fri, 30 Dec 2022 03:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiL3CN1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Dec 2022 21:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiL3CN1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Dec 2022 21:13:27 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49201707B
        for <bpf@vger.kernel.org>; Thu, 29 Dec 2022 18:13:25 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so24605231pjj.2
        for <bpf@vger.kernel.org>; Thu, 29 Dec 2022 18:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7xY4VLmipIcyrPbQHM+K5bvSivcl9z5G6MG2IKjbN8M=;
        b=Q52cVbX0LpQPUvluUPtsvuRY3li/Ra7733Kpj0/wwjlv7tHeF5Hsc8fD+xSBQZpRvd
         rIy1EpFLVTZ6qVFrhnIygCfg3WezdzIoVcCTJI7e+ZSfhkH9tM5/n21On6vXfrrkzKbX
         sz75B3ge/Mt76HuHpo3RA8Rd4E/+m7SdFIpsk/qRh/Bl5QPT4f44KYt8I82VcbqAFOkv
         a2PD0wmnzmatuiQmCTgOvOBAtN6TKlen0+R0wlPj1XLKQA2XdBQjk/1cSBYoRgSJWuAv
         9jaGT/UdXlyOccMA3K2J/JyANU4UY1y+Ia52RnRjaagr7q2LnuGwkyvjUqZVFEigfWvZ
         FkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7xY4VLmipIcyrPbQHM+K5bvSivcl9z5G6MG2IKjbN8M=;
        b=gpdOQR37WOxyJl7elbNut0VnfKJEn+LGgnQXgxbuw4MxbRmz+53Yit16rKJQTAOLnk
         84AC1G7Yknnx4XmUuqR6EAj+x+g1k9GBbUJP3ruBm+KxOPqKbBZP3tdxvtfVvpp2ALeg
         9B2hSMgKk/zZQEltTDoPlgzcyiMWxRKrlD0fOUemWCo4S6GCiGyepjZV215vZdhVYdHh
         fRTzS2UNoswiPIb1r5FfSL0D6aeFcfYPkE6CFAFDwiuKqHhl97pLotoeDKOdoasptYwi
         6xEKbOC6aIyCbuqmOjScLYIU13ROkHzTfLEnJUtOiGFHB1KdZ9xtxSGrIwcO+kfht/YU
         7aKA==
X-Gm-Message-State: AFqh2krFIisykEEQoqpmKHTKYdj6+5VG/VYOWsqXqfk/eLNLlCqj7K6Q
        ZJqYhZJLkL3PctYr3O1jbKVTnkwmn+ihVrx8Bm34tA==
X-Google-Smtp-Source: AMrXdXtUgH27o5mLWa/y9Pzg1vrr+LBDxCdlXIOq4bJHnGqVqGaTs1tyVZTTTPZLey2JdEsNDQBQWMWEI8hjslwMzE4=
X-Received: by 2002:a17:90a:5296:b0:219:fbc:a088 with SMTP id
 w22-20020a17090a529600b002190fbca088mr3044200pjh.162.1672366405062; Thu, 29
 Dec 2022 18:13:25 -0800 (PST)
MIME-Version: 1.0
References: <CAADnVQ+pgN8m3ApZtk9Vr=iv+OcXcv5hhASCwP6ZJGt9Z2JvMw@mail.gmail.com>
 <20221227033528.1032724-1-stfomichev@yandex.ru> <1855474adf8.28e3.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <1855474adf8.28e3.85c95baa4474aabc7814e68940a78392@paul-moore.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 29 Dec 2022 18:13:13 -0800
Message-ID: <CAKH8qBvR3=sSGvgGB_CqCFZhKynxdgatCK7N0mBZs1gBPDvTWw@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: restore the ebpf program ID for BPF_AUDIT_UNLOAD
 and PERF_BPF_EVENT_PROG_UNLOAD
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stanislav Fomichev <stfomichev@yandex.ru>,
        alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, burn.alting@iinet.net.au,
        daniel@iogearbox.net, jolsa@kernel.org, linux-audit@redhat.com,
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

On Tue, Dec 27, 2022 at 8:40 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On December 26, 2022 10:35:49 PM Stanislav Fomichev <stfomichev@yandex.ru>
> wrote:
> >> On Fri, Dec 23, 2022 at 5:49 PM Stanislav Fomichev <sdf@google.com> wrote:
> >> get_func_ip() */
> >>>> -                               tstamp_type_access:1; /* Accessed
> >>>> __sk_buff->tstamp_type */
> >>>> +                               tstamp_type_access:1, /* Accessed
> >>>> __sk_buff->tstamp_type */
> >>>> +                               valid_id:1; /* Is bpf_prog::aux::__id valid? */
> >>>>    enum bpf_prog_type      type;           /* Type of BPF program */
> >>>>    enum bpf_attach_type    expected_attach_type; /* For some prog types */
> >>>>    u32                     len;            /* Number of filter blocks */
> >>>> @@ -1688,6 +1689,12 @@ void bpf_prog_inc(struct bpf_prog *prog);
> >>>> struct bpf_prog * __must_check bpf_prog_inc_not_zero(struct bpf_prog *prog);
> >>>> void bpf_prog_put(struct bpf_prog *prog);
> >>>>
> >>>> +static inline u32 bpf_prog_get_id(const struct bpf_prog *prog)
> >>>> +{
> >>>> +       if (WARN(!prog->valid_id, "Attempting to use an invalid eBPF program"))
> >>>> +               return 0;
> >>>> +       return prog->aux->__id;
> >>>> +}
> >>>
> >>> I'm still missing why we need to have this WARN and have a check at all.
> >>> IIUC, we're actually too eager in resetting the id to 0, and need to
> >>> keep that stale id around at least for perf/audit.
> >>> Why not have a flag only to protect against double-idr_remove
> >>> bpf_prog_free_id and keep the rest as is?
> >>> Which places are we concerned about that used to report id=0 but now
> >>> would report stale id?
> >>
> >> What double-idr_remove are you concerned about?
> >> bpf_prog_by_id() is doing bpf_prog_inc_not_zero
> >> while __bpf_prog_put just dropped it to zero.
> >
> > (traveling, sending from an untested setup, hope it reaches everyone)
> >
> > There is a call to bpf_prog_free_id from __bpf_prog_offload_destroy which
> > tries to make offloaded program disappear from the idr when the netdev
> > goes offline. So I'm assuming that '!prog->aux->id' check in bpf_prog_free_id
> > is to handle that case where we do bpf_prog_free_id much earlier than the
> > rest of the __bpf_prog_put stuff.
> >
> >> Maybe just move bpf_prog_free_id() into bpf_prog_put_deferred()
> >> after perf_event_bpf_event and bpf_audit_prog ?
> >> Probably can remove the obsolete do_idr_lock bool flag as
> >> separate patch?
> >
> > +1 on removing do_idr_lock separately.
> >
> >> Much simpler fix and no code churn.
> >> Both valid_id and saved_id approaches have flaws.
> >
> > Given the __bpf_prog_offload_destroy path above, we still probably need
> > some flag to indicate that the id has been already removed from the idr?
>
> So what do you guys want in a patch?  Is there a consensus on what you
> would merge to fix this bug/regression?

Can we try the following?

1. Remove calls to bpf_prog_free_id (and bpf_map_free_id?) from
kernel/bpf/offload.c; that should make it easier to reason about those
'!id' checks
2. Move bpf_prog_free_id (and bpf_map_free_id?) to happen after
audit/perf in kernel/bpf/syscall.c (there are comments that say "must
be called first", but I don't see why; seems like GET_FD_BY_ID would
correctly return -ENOENT; maybe Martin can chime in, CC'ed him
explicitly)
3. (optionally) Remove do_idr_lock arguments (all callers are passing 'true')
