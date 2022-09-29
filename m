Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76CF5F005F
	for <lists+bpf@lfdr.de>; Fri, 30 Sep 2022 00:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiI2Wdi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Sep 2022 18:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiI2Wcj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Sep 2022 18:32:39 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56D0A2216
        for <bpf@vger.kernel.org>; Thu, 29 Sep 2022 15:30:56 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1280590722dso3516124fac.1
        for <bpf@vger.kernel.org>; Thu, 29 Sep 2022 15:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=tgQfEA4Iu0kSJxT5pMBFZLIcD7ZpTlADi2N73CRf2gw=;
        b=KUxkW5RSz1VuzlyqokJ33tD2rkbRPSbvkfPSQNCI8CObz3Z6F9bGdq1g6oNRFLA4+r
         aOKLEFcnSLXpU/ccj6w7eVfmhaKZqKGaJHzaXn8U6iRR1xYC+fwx7Z66LWz+LcBmsyjQ
         Do7iwQKwAictrk+rOR+Tyf32/7AstqoYlmF8WUhGYX1qa9wUniesmimcGemebVTIpp29
         4klA/ADhVHJWHKStfmW1JfqrFspNFlbHISKwB7kgl2djJy7FQD4iKoqBFLpyMGgBBH+w
         2DzPtajccfaAzn9xUYQ6060CdlnTHdpObC6V/A4EA9ZlLuEj0MLyoYLF84OdOTJ94NDX
         u1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=tgQfEA4Iu0kSJxT5pMBFZLIcD7ZpTlADi2N73CRf2gw=;
        b=ptMOzvUCbVId4/KjJufvLEUrlle+PRd6469F3QRseijKv7qCSVSJLohnGOuiAI6jOX
         Vk0YqotPxuelSX+0lAxVG6Qko+fU9Yho6CQ0GzY4SED085GjGO6/1MSP/mIP3Ayarr1F
         YTK7ZrsG37FqAkwIS8R1DloT2tDUaZrHZMTCk9RbNYWjRTROkvHEn9j1OUM3LZbgn2Q+
         akS6PJmd+KICggaaTYFFsQPJCvFVqKx1umUMUPiG+8jjhggKuV8eYC3YzLYyXarS8OJf
         F67C/djWiiIWgOLhAEezDY6umMwWrfJTNHmVtRSkbpg5O20hCA8tOdH8uKFv9q3yKt4f
         /pQw==
X-Gm-Message-State: ACrzQf2/E8E8GcEFOl+ZL5K12AfHzuW/aGrHAWn4BHZ4l7buiO+CDJw9
        YQhJX0fXtMdNqSYfF76rYFjkVBsB99DXLTHFDn9hh+qErw==
X-Google-Smtp-Source: AMsMyM7p2rLc6XIDbhZW2c/58B+z9Tkw7UC4dFbMt8ZxNuVuO1D6KINe+yWjD0ebpztfS9m5FLprH2OyZfJsW+9OS7U=
X-Received: by 2002:a05:6870:41cb:b0:131:9656:cc30 with SMTP id
 z11-20020a05687041cb00b001319656cc30mr7985099oac.51.1664490654817; Thu, 29
 Sep 2022 15:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
 <8e243ad132ecf2885fc65c33c7793f0703937890.camel@huaweicloud.com>
 <7f7c3337-74f1-424e-a14d-578c4c7ee2fe@www.fastmail.com> <65546f56be138ab326544b7b2e59bb3175ec884a.camel@huaweicloud.com>
 <b0c00f80-c11e-4f5d-ba63-2e9fb7cad561@www.fastmail.com> <9aba20351924aa0d82d258205030ad4f2c404de2.camel@huaweicloud.com>
 <98a26e5c-d44f-4e65-8186-c4e94918daa1@www.fastmail.com> <06a47f11778ca9d074c815e57dc1c75d073b3a85.camel@huaweicloud.com>
 <439dd1e5-71b8-49ed-8268-02b3428a55a4@www.fastmail.com> <6e142c3526df693abfab6e1293a27828267cc45e.camel@huaweicloud.com>
 <87mtajss8j.fsf@toke.dk> <fe9fe2443b8401a076330a3019bd46f6c815a023.camel@huaweicloud.com>
 <CAHC9VhRKq=BMtAat2_+0VvYk91hnryUHg+wbZRhu2BDB9ehC2A@mail.gmail.com> <3a9efcd6c8f7fa3908230ef5be0e0ad224a730ff.camel@huaweicloud.com>
In-Reply-To: <3a9efcd6c8f7fa3908230ef5be0e0ad224a730ff.camel@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 29 Sep 2022 18:30:43 -0400
Message-ID: <CAHC9VhTWsP99PxJLebbm04HdSAfF4QyhU0kwZZQnduET3jfKjw@mail.gmail.com>
Subject: Re: Closing the BPF map permission loophole
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>,
        Lorenz Bauer <oss@lmb.io>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 29, 2022 at 3:55 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Wed, 2022-09-28 at 20:24 -0400, Paul Moore wrote:
> > I only became aware of this when the LSM list was CC'd so I'm a
> > little
> > behind on what is going on here ... looking quickly through the
> > mailing list archive it looks like there is an issue with BPF map
> > permissions not matching well with their associated fd permissions,
> > yes?  From a LSM perspective, there are a couple of hooks that
> > currently use the fd's permissions (read/write) to determine the
> > appropriate access control check.
>
> From what I understood, access control on maps is done in two steps.
> First, whenever someone attempts to get a fd to a map
> security_bpf_map() is called. LSM implementations could check access if
> the current process has the right to access the map (whose label can be
> assigned at map creation time with security_bpf_map_alloc()).

[NOTE: SELinux is currently the only LSM which provides BPF access
controls, so they are going to be my example here and in the rest of
this email.]

In the case of SELinux, security_bpf_map() does check the access
between the current task and the BPF map itself (which inherits its
security label from its creator), with the actual permission requested
being determined by the fmode_t parameter passed to the LSM hook.
Looking at the current BPF code, the callers seem to take that from
various different places (bpf_attr:{file_flags,map_flags,open_flags}).
This could be due solely to the different operations being done by the
callers, which would make me believe everything is correct, but given
this thread it seems reasonable for someone with a better
understanding of BPF than me to double check this.  Can you help
verify that everything is okay here?

> Second, whenever the holder of the obtained fd wants to do an operation
> on the map (lookup, update, delete, ...), eBPF checks if the fd modes
> are compatible with the operation to perform (e.g. lookup requires
> FMODE_CAN_READ).

To be clear, from what I can see, it looks like the LSM is not
checking the fd modes, but rather the modes stored in the bpf_attr,
which I get the impression do not always match the fd modes.  Yes?
No?

There is also LSM/SELinux code which checks the permissions when a BPF
map is passed between tasks via a fd.  Currently the SELinux check
only looks at the file:f_mode to get the permissions to check, but if
the f_mode bits are not the authoritative record of what is allowed in
the BPF map, perhaps we need to change that to use one of the bpf_attr
mode bits (my gut feeling is bpf_attr:open_flags)?

> One problem is that the second part is missing for some operations
> dealing with the map fd:
>
> Map iterators:
> https://lore.kernel.org/bpf/20220906170301.256206-1-roberto.sassu@huaweicloud.com/

You'll need to treat me like an idiot when it comes to BPF maps ;)

I did a very quick read on them right now and it looks like a BPF map
iterator would just be a combination of BPF read and execute ("bpf {
map_read prog_run }" in SELinux policy terms).  Would it make more
sense to just use the existing security_bpf_map() and
security_bpf_prog() hooks here?

> Map fd directly used by eBPF programs without system call:
> https://lore.kernel.org/bpf/20220926154430.1552800-1-roberto.sassu@huaweicloud.com/

Another instance of "can you please explain this use case?" ;)

I'm not going to hazard too much of a guess here, but if the map is
being passed between tasks and a fd is generated from that map, we may
be able to cover this with logic similar
security/selinux/hooks.c:bpf_fd_pass() ... but I'm really stretching
my weak understanding of BPF here.

> Another problem is that there is no DAC, only MAC (work in progress). I
> don't know exactly the status of enabling unprivileged eBPF.

It is my opinion that we need to ensure both DAC and MAC are present
in the code.  This thread makes me worry that some eBPF DAC controls
are being ignored because one can currently say "we're okay because
you need privilege!".  That may be true today, but I can imagine a
time in the not too distant future where unpriv eBPF is allowed and we
suddenly have to bolt on a lot of capable() checks ... which is a
great recipe for privilege escalation bugs.

> Apart from this, now the discussion is focusing on the following
> problem. A map (kernel object) can be referenced in two ways: by ID or
> by path. By ID requires CAP_ADMIN, so we can consider by path for now.
>
> Given a map fd, the holder of that fd can create a new reference
> (pinning) to the map in the bpf filesystem (a new file whose private
> data contains the address of the kernel object).
>
> Pinning a map does not have a corresponding permission. Any fd mode is
> sufficient to do the operation. Furthermore, subsequent requests to
> obtain a map fd by path could result in receiving a read-write fd,
> while at the time of pinning the fd was read-only.

Since the maps carry their own label I think we are mostly okay, even
if the map is passed between tasks by some non-fd related mechanism.
However, I am now slightly worried that if a fd is obtained with perms
that don't match the underlying map and that fd is then passed to
another task the access control check on the fd passing would not be
correct.  Operations on the map from a SELinux perspective should
still be okay (the map has its own label), but still.

I'm wondering if we do want to move the SELinux BPF fd passing code to
check the bpf_attr:open_flags perms.  Thoughts?

> While this does not seem to me a concern from MAC perspective, as
> attempts to get a map fd still have to pass through security_bpf_map(),
> in general this should be fixed without relying on LSMs.

Agreed.  The access controls need to work both for DAC and DAC+LSM.

> > Is the plan to ensure that the map and fd permissions are correct at
> > the core BPF level, or do we need to do some additional checks in the
> > LSMs (currently only SELinux)?
>
> Should we add a new map_pin permission in SELinux?

Maybe?  Maybe not?  I don't know, can you help me understand map
pinning a bit more first?

> Should we have DAC to restrict pinnning without LSMs?

Similar to above.

-- 
paul-moore.com
