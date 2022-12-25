Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D80655E72
	for <lists+bpf@lfdr.de>; Sun, 25 Dec 2022 23:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbiLYWRF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 25 Dec 2022 17:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiLYWRE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 25 Dec 2022 17:17:04 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521DA1002
        for <bpf@vger.kernel.org>; Sun, 25 Dec 2022 14:17:03 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id u9so23287387ejo.0
        for <bpf@vger.kernel.org>; Sun, 25 Dec 2022 14:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k9VYayWhEojXdedhpz0T3pFz3Qk5NlIUSQcAxKCeies=;
        b=my66nJcwzmG+P+xBFoH294AVlsUhkpk1U1yPW8gD22A9tApa3nf/Y798u5QqJ2KFdD
         C2ECvBpIRIUVyJ4ZEZVukE8Bb43+wh7eP9pEJbPlN/2hCNA+ltxznwjgs4B7eHL4riiB
         5XigeR7py9R2YXqottUeXzbt4q+kkL6UCpZg+pZc53ktEcI3ZnD5zbEl1fBjT3tl4mjo
         MeThLKkFBx4nM2rOc4Wad7S/EdzKAqOeeuS25uiOCOlq7DZD5uQV8OliI8GyVNbOlFZb
         DVeYlsygJymK4VnaZZptxYk+zf1gJFzZmtPIt+opzkAwX9iaCf2vEjaa/pVPIMsYwDaW
         3OWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k9VYayWhEojXdedhpz0T3pFz3Qk5NlIUSQcAxKCeies=;
        b=uGnJTBVacdk4Klxegha59v/6yuw6xYDbEQUwsp1ioFNv6atswAE/wVpxz5ruWy7rwg
         HQeYjvqb0DbJCZYzTw3d4/zyj5kFUUBtaiWet1QNGicci+RczkWelxMuFMnCOkqcbA/V
         OE574fM1+cMd+cd0Vs8nDxQs/usFuYtMLyTxTUhXyCgVqB0aej/djzzcgn/71iJ6wYck
         4Da5O0qBJ+CyInJXqmyUbAHKIye8sdhDOhs+1plftLoAM/B390YWsRayya3cPWfJxpTT
         L40TvHnZHFqoLNFZ7VrnYk9bs/Mmnz2PWjmdWT3cj1FijSa0fQ2cGmJWZ7EfPAmWvPvG
         mrGQ==
X-Gm-Message-State: AFqh2kp6AGSekoLVCI5z2xmtD41ol2MP8+vQxjAn1MrmIoPkXvvt3MHB
        OnCaGVLyfBE2lNxz2f0V6boStRHtOxZWmPHX4aTQigz2mCw=
X-Google-Smtp-Source: AMrXdXvj4TjWhrl6oaLRvnCr8CX/yG0bSRHD9hJLWz1fj14bqPQXTUxwsRS32yD+C1byaROl9bcMArcBcwc32oDuHz8=
X-Received: by 2002:a17:906:a18c:b0:7c0:f2cf:3515 with SMTP id
 s12-20020a170906a18c00b007c0f2cf3515mr1075480ejy.327.1672006621737; Sun, 25
 Dec 2022 14:17:01 -0800 (PST)
MIME-Version: 1.0
References: <20221223185531.222689-1-paul@paul-moore.com> <CAKH8qBu30bdiMWmUzZsYaVRTpSXfKjeBHD9deSPQmk_v_seDuA@mail.gmail.com>
In-Reply-To: <CAKH8qBu30bdiMWmUzZsYaVRTpSXfKjeBHD9deSPQmk_v_seDuA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 25 Dec 2022 14:16:50 -0800
Message-ID: <CAADnVQ+pgN8m3ApZtk9Vr=iv+OcXcv5hhASCwP6ZJGt9Z2JvMw@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: restore the ebpf program ID for BPF_AUDIT_UNLOAD
 and PERF_BPF_EVENT_PROG_UNLOAD
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Paul Moore <paul@paul-moore.com>, linux-audit@redhat.com,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Burn Alting <burn.alting@iinet.net.au>,
        Jiri Olsa <jolsa@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
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

On Fri, Dec 23, 2022 at 5:49 PM Stanislav Fomichev <sdf@google.com> wrote:
get_func_ip() */
> > -                               tstamp_type_access:1; /* Accessed __sk_buff->tstamp_type */
> > +                               tstamp_type_access:1, /* Accessed __sk_buff->tstamp_type */
> > +                               valid_id:1; /* Is bpf_prog::aux::__id valid? */
> >         enum bpf_prog_type      type;           /* Type of BPF program */
> >         enum bpf_attach_type    expected_attach_type; /* For some prog types */
> >         u32                     len;            /* Number of filter blocks */
> > @@ -1688,6 +1689,12 @@ void bpf_prog_inc(struct bpf_prog *prog);
> >  struct bpf_prog * __must_check bpf_prog_inc_not_zero(struct bpf_prog *prog);
> >  void bpf_prog_put(struct bpf_prog *prog);
> >
> > +static inline u32 bpf_prog_get_id(const struct bpf_prog *prog)
> > +{
> > +       if (WARN(!prog->valid_id, "Attempting to use an invalid eBPF program"))
> > +               return 0;
> > +       return prog->aux->__id;
> > +}
>
> I'm still missing why we need to have this WARN and have a check at all.
> IIUC, we're actually too eager in resetting the id to 0, and need to
> keep that stale id around at least for perf/audit.
> Why not have a flag only to protect against double-idr_remove
> bpf_prog_free_id and keep the rest as is?
> Which places are we concerned about that used to report id=0 but now
> would report stale id?

What double-idr_remove are you concerned about?
bpf_prog_by_id() is doing bpf_prog_inc_not_zero
while __bpf_prog_put just dropped it to zero.

Maybe just move bpf_prog_free_id() into bpf_prog_put_deferred()
after perf_event_bpf_event and bpf_audit_prog ?
Probably can remove the obsolete do_idr_lock bool flag as
separate patch?

Much simpler fix and no code churn.
Both valid_id and saved_id approaches have flaws.
