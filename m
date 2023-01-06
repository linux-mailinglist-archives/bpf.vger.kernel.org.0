Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AB665F9B3
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 03:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjAFCy1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Jan 2023 21:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjAFCy0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Jan 2023 21:54:26 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F951B1CE
        for <bpf@vger.kernel.org>; Thu,  5 Jan 2023 18:54:25 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id c6so362285pls.4
        for <bpf@vger.kernel.org>; Thu, 05 Jan 2023 18:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z9HWc/Jyi5I5xdssZ+I8lqCfwTBCSjVg/OEt7+3HtpA=;
        b=XF/abNWBDNSRrihrcr1eFd6daB0GZIFQI604ANftwYN5X5lVrDtLvNIWhLKrvClaAL
         xTgA3iQJodoh7XqdfBIzZANW22vg+m+bt5Y34U1O7cOcZVqnpU9+kun1htIdsuh1jlc1
         6LSz+KaAkpc2JvTAtvz9HOtqB9IF8mTdC+pv7pcOrbZ8yVLk5NLg7Dxpe22xEVKMiqfB
         Pt3gcYGRBxXYWv/IZf3vCSBLwoRaELslcXnldu6p9Rg7H7tACzhweSeYjZM7jqzEcPhh
         ZUEnCR/TskMaHjC+RZff0xXBkAWN4w9Rs/TFeaVeZDku1CVNyIrb1aC4yvxw5apGrV+X
         3ebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9HWc/Jyi5I5xdssZ+I8lqCfwTBCSjVg/OEt7+3HtpA=;
        b=s0b1req7yNOiF42my/vXomFWsWEzajiplEfaaGyNFGDMxbc6R0Gv2P4jiKsIFeTfG9
         pjFxYjrAzEir+sTlgqkOcR3A0GeQ7xGzdOxg1XZU80KXCYgR1yzQC0C+/yL6wRuSfEJ+
         cq7xrVqcrMLVcjwUiRY7hj7lM2kFmryymo4+zb7wjTcVsvxQ4Vsl6EQ5lMGR/RH7iDzK
         8IwhtkWF3RWeOYM6z35Y/5KUdouxvy0fT3vKe6kU+KZ2/UwD07x16P42eOs8swrpT9Qo
         1edjo6Zvk0DV0htN47LOGMRq/w0L3lu9deBSCrFT505o9swJ5KlKeGFL+d4tqYsu9zRb
         tKAA==
X-Gm-Message-State: AFqh2kr7LqM8icnFwccjqd2vm4cUOOeH7qMDYDrZqzNAQq6E3RcMPomM
        zRVFhQTMF3HjFG8536YTSdo=
X-Google-Smtp-Source: AMrXdXt48O4es0yaniBLWCw9OWMPNzzLjDCQm4ekjHlHVqIpv4onWAumwi/YIM8fFsga9r/qVO4gsg==
X-Received: by 2002:a17:902:7c07:b0:193:bec:2122 with SMTP id x7-20020a1709027c0700b001930bec2122mr1059719pll.32.1672973664580;
        Thu, 05 Jan 2023 18:54:24 -0800 (PST)
Received: from MacBook-Pro-6.local ([2620:10d:c090:400::5:1385])
        by smtp.gmail.com with ESMTPSA id o13-20020a170902d4cd00b00189812a5397sm26753262plg.180.2023.01.05.18.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 18:54:23 -0800 (PST)
Date:   Thu, 5 Jan 2023 18:54:20 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     David Vernet <void@manifault.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        kernel-team@meta.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>
Subject: Re: bpf helpers freeze. Was: [PATCH v2 bpf-next 0/6] Dynptr
 convenience helpers
Message-ID: <20230106025420.6xdhhjsknhdhbu3d@MacBook-Pro-6.local>
References: <20221216173526.y3e5go6mgmjrv46l@MacBook-Pro-6.local>
 <CAEf4BzbVoiVSa1_49CMNu-q5NnOvmaaHsOWxed-nZo9rioooWg@mail.gmail.com>
 <20221225215210.ekmfhyczgubx4rih@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYhn0vASt1wfKTZg8Foj8gG2oem2TmUnvSXQVKLnyEN-w@mail.gmail.com>
 <20221230024641.4m2qwkabkdvnirrr@MacBook-Pro-6.local>
 <CAEf4Bzbvg2bXOj8LPwkRQ0jfTR4y5XQn=ajK_ApVf5W-F=wG2Q@mail.gmail.com>
 <20230104194438.4lfigy2c5m4xx6hh@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4Bzag8K=7+TY-LPEiBJ7ocRi-U+SiDioAQvPDto+j0U5YaQ@mail.gmail.com>
 <Y7YQHC4FgYuLWmab@maniforge.lan>
 <CAEf4BzaJ4h4o+nrApBPABZ8zu-f+TpuV4FUvEfHsrLRsu1bObw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzaJ4h4o+nrApBPABZ8zu-f+TpuV4FUvEfHsrLRsu1bObw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 05, 2023 at 01:01:56PM -0800, Andrii Nakryiko wrote:
> Didn't find the best place to put this, so it will be here. I think it
> would be beneficial to discuss BPF helpers freeze in BPF office hours.
> So I took the liberty to put it up for next BPF office hours, 9am, Jan
> 12th 2022. I hope that some more people that have exposure to
> real-world BPF application and pains associated with all that could
> join the discussion, but obviously anyone is welcome as well, no
> matter which way they are leaning.
> 
> Please consider joining, see details on Zoom meeting at [0]
> 
> For the rest, please see below. I'll be out for a few days and won't
> be able to reply, my apologies.
> 
>   [0] https://docs.google.com/spreadsheets/d/1LfrDXZ9-fdhvPEp_LHkxAMYyxxpwBXjywWa0AejEveU/edit#gid=0

Thanks for adding it to the agenda.
Hopefully we'll be able to converge faster on a call.

There are several things to discuss:
1. whether or not to freeze helpers.
2. whether dynptr accessors should be helpers or kfuncs.
3. whether your future inline iterators should be helpers or kfuncs.
4. whether cilium's bpf_sock_destroy should be helper or kfunc.

If we hard freeze helpers in 1 it automatically decides the fate for 2, 3, 4.
We can soft freeze the helpers then 2,3,4 are up for discussion.
Looks like the thread so far was primarily about 1.
4 was touched separately. Daniel hasn't replied yet to my suggestion for it to be kfunc.
You insist that 2 and 3 must be helpers.
No one seen the patches for 3. I've seen you whiteboard them. It's impossible
for others to participate without patches, so let's postpone that.

Let's try to focus this thread on 2 assuming both helpers and kfuncs
are on the table for dynptrs...

> conclusions. I think it's even possible to deprecate BPF helpers, if
> we really want to. In the end, technically, the only UAPI part about
> BPF helper is it's ID. That should stay fixed. We do change over time
> which helpers are available in which program types. Yes, it would be
> really bad to change helper signature and I'd be very much against
> this, but from my perspective (and I'm sure others will disagree),
> it's in the realm of possibility to do gradual deprecation of some
> helpers. We'll leave BPF_FUNC_xxx enumerator intact, of course, but
> add a simple wrapper that will just -ENOTSUP.

Unfortunately you're completely wrong in the above paragraph.
I suggest to read this Linus's rant first:
https://lkml.org/lkml/2012/12/23/75

Everything that user space sees we cannot change.
We can try to, but it will be reverted if users complain.
That's why we never try unless there is a very strong reason like security issue.

For example your last commit to uapi/bpf.h
commit 8a76145a2ec2 ("bpf: explicitly define BPF_FUNC_xxx integer values")
is a leap of faith.
Though we tried to make it as transparent as possible and
I googled BPF_FUNC_MAPPER before applying the patch to see in what weird ways
people can use the macro, there is still a non zero chance that
we would have to revert it if users complain loud enough.

For example cilium has this bit of code:
https://github.com/cilium/ebpf/blob/master/asm/func.go
I suspect it's broken now, because you've changed 'FN' macro in that commit.
Cilium folks are unlikely to complain and demand a revert, so we should be safe
in this regard, but we cannot assume that for other users.

It should be obvious that we cannot deprecate helpers with ENOTSUP
or deprecate them in any other way.

> E.g., Linus requested bpf_probe_read() to not exist and not be used,
> everyone agreed. Good opportunity?

It's an exception that proves the rule.
1. it's a security issue that's why uapi breakage was on the table.
2. it wasn't completely removed. See:

#ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
        case BPF_FUNC_probe_read:
                return security_locked_down(LOCKDOWN_BPF_READ_KERNEL) < 0 ?
                       NULL : &bpf_probe_read_compat_proto;

> The point is that UAPI stability is not the end of the world and
> paranoia is bad. We shouldn't get paralyzed because we add APIs. We do
> that to libbpf and APIs will stay stable within entire 1.x version.
> Yes, we don't have such a nice "luxury" with kernel, but see above.

Exactly. See above. There is no way at all to deprecate helpers.

> >
> > - On the one hand you're arguing that in some cases, _no_ API
> >   instability is acceptable. That in general, the main kernel <-> kernel
> >   BPF program API boundary is equivalent to UAPI, and that it's _never_
> >   acceptable for us to ever, _ever_ deprecate certain APIs because
> 
> you are being hyperbolic and overdramatic again for no good reason,
> "ever, _ever_" -- really? There is no such thing.

Andrii, it's really _ever_. You need to internalize that first
before we discuss this topic again during office hours.

> I'd probably still go for it. But building some tool like perf or
> retsnoop -- I'd think twice if I want to take dependency on BPF map
> (or dynptr for that matter), if it potentially limits the
> applicability of my application.

A quote from retsnoop readme:
"
NOTE: Retsnoop relies on BPF CO-RE technology, so please make sure your Linux
kernel is built with CONFIG_DEBUG_INFO_BTF=y kernel config. Without this
retsnoop will refuse to start.
"
and in calib_feat.bpf.c
/* Detect if bpf_get_func_ip() helper is supported by the kernel.
/* Detect if fentry/fexit re-entry protection is implemented.
/* Detect if fexit is safe to use for long-running and sleepable
/* Detect if bpf_get_branch_snapshot() helper is supported.
/* Detect if BPF_MAP_TYPE_RINGBUF map is supported.
/* Detect if BPF cookie is supported for kprobes.
/* Detect if multi-attach kprobes are supported.

If the feature is useful you will use it. In retsnoop and everywhere else.
Regardless whether it's arch dependent, kernel dependent or unstable.

> I disagree about ripping the bandaid and precluding dynptr framework
> to be whole before we solve various problems I pointed out in [1]
> (which unfortunately was mostly ignored, it seems).

Let's look at your
https://lore.kernel.org/all/CAEf4BzZM0+j6DXMgu2o2UvjtzoOxcjsJtT8j-jqVZYvAqxc52g@mail.gmail.com/
"
1. Generic accessors to check validity of *any* dynptr, and it's
inherent properties like offset, available size, read-only property
(just as useful somethings as bpf_ringbuf_query() is for ringbufs,
both for debugging and for various heuristics in production).

bpf_dynptr_is_null(struct bpf_dynptr *ptr)
long bpf_dynptr_get_size(struct bpf_dynptr *ptr)
long bpf_dynptr_get_offset(struct bpf_dynptr *ptr)
bpf_dynptr_is_rdonly(struct bpf_dynptr *ptr)

There is nothing to add or remove here. No flags, no change in semantics.
"

You're arguing that it's obviously stable material.
Like:
+BPF_CALL_1(bpf_dynptr_get_offset, struct bpf_dynptr_kern *, ptr)
+{
+    if (!ptr->data)
+         return -EINVAL;
+
+    return ptr->offset;
+}

but we can do it now in native bpf code:

static inline int bpf_dynptr_get_offset(const struct bpf_dynptr *uptr)
{
     struct bpf_dynptr_kern *ptr = bpf_rdonly_cast(uptr, bpf_core_type_id_kernel(struct bpf_dynptr_kern));

     if (!ptr->data)
          return -EINVAL;

     return ptr->offset;
}

No kernel changes necessary. No UAPI helpers. No kfuncs.
CO-RE will take care of kernel version differences.

Do you still insist that it should be a stable uapi helper ?

> And for the "for loop iterator", I absolutely do not want to have a
> useful generic abstraction for repeatable loop, that will have few
> asterisks associated with them, dictating which arches and what kernel
> config values (beyond basic BPF ones) should be ensured to make
> iteration work. Kills any motivation to finish it. 

I'm really sad that you went down this ultimatum path.
Essentially you're saying: "loop iterator has to be stable helper or
I quit working on it."
Say we cave in and accepted your demand. Later you do another ultimatum
and we cannot cave in for whatever reason. You stay true to your words
and quit BPF development. Now we're stuck with your uapi that we cannot
change, cannot improve, but still have to maintain it _forever_
without you because you quit. That would suck.
Let's get back to discussing technical merits without ultimatums. Ok?
