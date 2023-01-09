Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB39662E0E
	for <lists+bpf@lfdr.de>; Mon,  9 Jan 2023 19:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237500AbjAISFZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 13:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237511AbjAISEo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 13:04:44 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8192F43DAC
        for <bpf@vger.kernel.org>; Mon,  9 Jan 2023 10:04:05 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id y2-20020a17090a784200b00225c0839b80so3317992pjl.5
        for <bpf@vger.kernel.org>; Mon, 09 Jan 2023 10:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=trG36qMQ9Re5MPDk2HW7Rz6kxqCJt0NIEgnLH9yO4Qo=;
        b=HehybKvulMs/fj932ds2sW8yaDNuxCqU3mQZ9Xp/6FeZgQLCpuD3ZrO8yDhdhzCqGT
         mtAIs9DLKCao4jgTr6Iw0jHGhPbTn2a/EI88HINLhb0DUgxyjbTMfQztJE4xniRi+GOv
         OO3Qv4DtYFW+K1TEGk0WCN431bBV1ccEqlluaup5Pxi/ixG76aZud0oY8YFgc+Fcc77e
         Bk7hooKkvwNM2B2TxYqBdnhVq1gcTGt9QpVM242Wy6Z6YKqowRrDjYYlg6PX8HRb8Pey
         dCWY3vxAIvU2uqWH7j82OVQ4bimredsJCd4G42HHn31cO+u/iEmtxbwbkynLgsk8ebNu
         TVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=trG36qMQ9Re5MPDk2HW7Rz6kxqCJt0NIEgnLH9yO4Qo=;
        b=YA8CzldjRu5Cxc5pF8Kj+KVcT91z73wwUBNZHt/Ctz12s9d8I9ypZ1JbLs6BX4WtUD
         6fSG/X+5q9G96sW5kPL03mG/7o8b/RaWIr49POp7bkfwQtphnV95yqmToJaIeHO89eUS
         gI6LO8MpLvBtlw3ZcD/1Yn4sBQPw/JkcyKfnm4/fZ/UIvJWSxPUsS8mfEEtmqn3jeXHJ
         Z4IIE2tev4Xh8vrLj4caBXTSrOL+NuOPYJMLIydjSOGeqpo5LO9KouWaRIVMnGPtWi+C
         ClFqH9ifVUc+XeZsVShB4euLup3ov2oVUofQj7C2c77CIb/xFewM1nPa8fX1M1MQ9/tQ
         k1aQ==
X-Gm-Message-State: AFqh2krAXfJ7ON38EVc+o7XSFVKIygZYj9mjfNTvcPJt7M0UK5e6Ujte
        mHvOQ21v2RA7o5kv1ieHxXRxbVw=
X-Google-Smtp-Source: AMrXdXvQAaSeLP8emdOQH4MJhf2F47/Fz7kLXToAn5bywJRXLQq7tIYxXrN2/Tv/EdBrmXZS7cufits=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:aa7:8c18:0:b0:588:3aa8:bd95 with SMTP id
 c24-20020aa78c18000000b005883aa8bd95mr364514pfd.14.1673287445067; Mon, 09 Jan
 2023 10:04:05 -0800 (PST)
Date:   Mon, 9 Jan 2023 10:04:03 -0800
In-Reply-To: <CAHC9VhTzBP49x3EH6yeqYxnr4jgcS6RdcvtbX_BSuRJnCH6ypQ@mail.gmail.com>
Mime-Version: 1.0
References: <20230106154400.74211-1-paul@paul-moore.com> <CAKH8qBtyR20ZWAc11z1-6pGb3Hd47AQUTbE_cfoktG59TqaJ7Q@mail.gmail.com>
 <CAHC9VhTzBP49x3EH6yeqYxnr4jgcS6RdcvtbX_BSuRJnCH6ypQ@mail.gmail.com>
Message-ID: <Y7xXEx5NEV96fnPp@google.com>
Subject: Re: [PATCH v3 1/2] bpf: restore the ebpf program ID for
 BPF_AUDIT_UNLOAD and PERF_BPF_EVENT_PROG_UNLOAD
From:   sdf@google.com
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-audit@redhat.com, bpf@vger.kernel.org,
        Burn Alting <burn.alting@iinet.net.au>,
        Alexei Starovoitov <ast@kernel.org>
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

On 01/09, Paul Moore wrote:
> On Fri, Jan 6, 2023 at 2:45 PM Stanislav Fomichev <sdf@google.com> wrote:
> > On Fri, Jan 6, 2023 at 7:44 AM Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > When changing the ebpf program put() routines to support being called
> > > from within IRQ context the program ID was reset to zero prior to
> > > calling the perf event and audit UNLOAD record generators, which
> > > resulted in problems as the ebpf program ID was bogus (always zero).
> > > This patch addresses this problem by removing an unnecessary call to
> > > bpf_prog_free_id() in __bpf_prog_offload_destroy() and adjusting
> > > __bpf_prog_put() to only call bpf_prog_free_id() after audit and perf
> > > have finished their bpf program unload tasks in
> > > bpf_prog_put_deferred().  For the record, no one can determine, or
> > > remember, why it was necessary to free the program ID, and remove it
> > > from the IDR, prior to executing bpf_prog_put_deferred();
> > > regardless, both Stanislav and Alexei agree that the approach in this
> > > patch should be safe.
> > >
> > > It is worth noting that when moving the bpf_prog_free_id() call, the
> > > do_idr_lock parameter was forced to true as the ebpf devs determined
> > > this was the correct as the do_idr_lock should always be true.  The
> > > do_idr_lock parameter will be removed in a follow-up patch, but it
> > > was kept here to keep the patch small in an effort to ease any stable
> > > backports.
> > >
> > > I also modified the bpf_audit_prog() logic used to associate the
> > > AUDIT_BPF record with other associated records, e.g. @ctx != NULL.
> > > Instead of keying off the operation, it now keys off the execution
> > > context, e.g. '!in_irg && !irqs_disabled()', which is much more
> > > appropriate and should help better connect the UNLOAD operations with
> > > the associated audit state (other audit records).
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: d809e134be7a ("bpf: Prepare bpf_prog_put() to be called from  
> irq context.")
> > > Reported-by: Burn Alting <burn.alting@iinet.net.au>
> > > Reported-by: Jiri Olsa <olsajiri@gmail.com>
> > > Suggested-by: Stanislav Fomichev <sdf@google.com>
> > > Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> >
> > Acked-by: Stanislav Fomichev <sdf@google.com>
> >
> > Thank you! There might be a chance it breaks test_offload.py (I don't
> > remember whether it checks this prog-is-removed-from-id part or not),
> > but I don't think it's fair to ask to address it :-)
> > Since it doesn't trigger in CI, I'll take another look next week when
> > doing a respin of my 'xdp-hints' series.

> No problem, I'm glad we found a solution that works for everyone; and
> thank you for chasing down any test changes that may be necessary.

> I'd like to get this patch into Linus' tree sooner rather than later
> as it fixes a kinda ugly problem, would you be okay if this went in
> via the bpf tree?  With the appropriate ACKs I could send it to Linus
> via the audit tree, but I think it would be much better to send it via
> the bpf/netdev tree.

Don't see any reason that this should go via bpf-next, so assuming
going via bpf three should be fine.


> --
> paul-moore.com
