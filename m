Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D772B656723
	for <lists+bpf@lfdr.de>; Tue, 27 Dec 2022 04:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiL0Dlv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Dec 2022 22:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiL0Dlu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Dec 2022 22:41:50 -0500
X-Greylist: delayed 355 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 26 Dec 2022 19:41:48 PST
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [178.154.239.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699D56169
        for <bpf@vger.kernel.org>; Mon, 26 Dec 2022 19:41:48 -0800 (PST)
Received: from myt6-fe378243d6ea.qloud-c.yandex.net (myt6-fe378243d6ea.qloud-c.yandex.net [IPv6:2a02:6b8:c12:488f:0:640:fe37:8243])
        by forward502b.mail.yandex.net (Yandex) with ESMTP id 4E2925ED86;
        Tue, 27 Dec 2022 06:35:42 +0300 (MSK)
Received: by myt6-fe378243d6ea.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id cZFOuGaZRGk1-4hXo2Qzg;
        Tue, 27 Dec 2022 06:35:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1672112141;
        bh=wvJ3Kka3VdTmL4BnJoj3vjA85GvqYQf9WTdWToEMxvg=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=A6OMPNP1X/OUSHkeNfqmkueMHNGCL8qUd2uYWt2RVHRvDTnxBTxTJh/TioKPORSLt
         nMd12uicHLyp4BtWYs4GNffxQzavkGK6gyrRlxaN4SJ3cvc2vUr2WjwGfpvVYMG+X2
         +w1sLOmluPn3qtXBoWxng2aYVdx6KqWDcE6r3lSg=
Authentication-Results: myt6-fe378243d6ea.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Stanislav Fomichev <stfomichev@yandex.ru>
To:     alexei.starovoitov@gmail.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        burn.alting@iinet.net.au, daniel@iogearbox.net, jolsa@kernel.org,
        linux-audit@redhat.com, paul@paul-moore.com, sdf@google.com
Subject: Re: [PATCH v2] bpf: restore the ebpf program ID for BPF_AUDIT_UNLOAD and PERF_BPF_EVENT_PROG_UNLOAD
Date:   Mon, 26 Dec 2022 19:35:28 -0800
Message-Id: <20221227033528.1032724-1-stfomichev@yandex.ru>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <CAADnVQ+pgN8m3ApZtk9Vr=iv+OcXcv5hhASCwP6ZJGt9Z2JvMw@mail.gmail.com>
References: <CAADnVQ+pgN8m3ApZtk9Vr=iv+OcXcv5hhASCwP6ZJGt9Z2JvMw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> On Fri, Dec 23, 2022 at 5:49 PM Stanislav Fomichev <sdf@google.com> wrote:
> get_func_ip() */
> > > -                               tstamp_type_access:1; /* Accessed __sk_buff->tstamp_type */
> > > +                               tstamp_type_access:1, /* Accessed __sk_buff->tstamp_type */
> > > +                               valid_id:1; /* Is bpf_prog::aux::__id valid? */
> > >         enum bpf_prog_type      type;           /* Type of BPF program */
> > >         enum bpf_attach_type    expected_attach_type; /* For some prog types */
> > >         u32                     len;            /* Number of filter blocks */
> > > @@ -1688,6 +1689,12 @@ void bpf_prog_inc(struct bpf_prog *prog);
> > >  struct bpf_prog * __must_check bpf_prog_inc_not_zero(struct bpf_prog *prog);
> > >  void bpf_prog_put(struct bpf_prog *prog);
> > >
> > > +static inline u32 bpf_prog_get_id(const struct bpf_prog *prog)
> > > +{
> > > +       if (WARN(!prog->valid_id, "Attempting to use an invalid eBPF program"))
> > > +               return 0;
> > > +       return prog->aux->__id;
> > > +}
> >
> > I'm still missing why we need to have this WARN and have a check at all.
> > IIUC, we're actually too eager in resetting the id to 0, and need to
> > keep that stale id around at least for perf/audit.
> > Why not have a flag only to protect against double-idr_remove
> > bpf_prog_free_id and keep the rest as is?
> > Which places are we concerned about that used to report id=0 but now
> > would report stale id?
> 
> What double-idr_remove are you concerned about?
> bpf_prog_by_id() is doing bpf_prog_inc_not_zero
> while __bpf_prog_put just dropped it to zero.

(traveling, sending from an untested setup, hope it reaches everyone)

There is a call to bpf_prog_free_id from __bpf_prog_offload_destroy which
tries to make offloaded program disappear from the idr when the netdev
goes offline. So I'm assuming that '!prog->aux->id' check in bpf_prog_free_id
is to handle that case where we do bpf_prog_free_id much earlier than the
rest of the __bpf_prog_put stuff.

> Maybe just move bpf_prog_free_id() into bpf_prog_put_deferred()
> after perf_event_bpf_event and bpf_audit_prog ?
> Probably can remove the obsolete do_idr_lock bool flag as
> separate patch?

+1 on removing do_idr_lock separately.

> Much simpler fix and no code churn.
> Both valid_id and saved_id approaches have flaws.

Given the __bpf_prog_offload_destroy path above, we still probably need
some flag to indicate that the id has been already removed from the idr?
