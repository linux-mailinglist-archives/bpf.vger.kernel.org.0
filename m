Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAEBA4419CA
	for <lists+bpf@lfdr.de>; Mon,  1 Nov 2021 11:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbhKAK0b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Nov 2021 06:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhKAK0b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Nov 2021 06:26:31 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FA4C061714
        for <bpf@vger.kernel.org>; Mon,  1 Nov 2021 03:23:58 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id o26so30906522uab.5
        for <bpf@vger.kernel.org>; Mon, 01 Nov 2021 03:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BIKQc4IpbYHEzoBvLDQjwTuL7iXg615W5E03UeEvh/U=;
        b=OYc/SHjM5GBytls+t2pmBOx7Yl6npJHqv2xh/bSKPOW3d1I1VUPj+uAWcKfBAo10kR
         imREF8LoruqhCVuDQMfEIJ4hRlImllIPMHQAx2ubrMAx+zOrn7nPiSX13dY/l0VDix1B
         oLT2RHLk2bIy8AekgNcjnco8K2snr3htj29Ru3Zghyd42H/91NJ/sOzw1LxaMvq/k2+t
         9d+4+CDRGQv+YFcxVZnToOpuSFsLhM3eHpWGrtr81wle6jex00nBWROhUSwt+po4WxUP
         Xo0FBkU/Us/8EX3IgCsIG5O/8ecrI0vnJPakrHlo+yUtOsTGgY12+w0ogYhh+L2KIKhb
         Wogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BIKQc4IpbYHEzoBvLDQjwTuL7iXg615W5E03UeEvh/U=;
        b=mph9Lobm33zO03RqdUGx0nS0B1GF/JLq2RN03Rn8hlvGHrZ7PE6/wY+B2R1PysKxHT
         WDdNO1K/+mTC/rbwi+oRXCdRGrWVQbB8pD0RAYf3til+cuDcsl6rm4fDWQCW6VTEeLI1
         +sVNYHfCr+EB+WqNuIeGbO/tC3Wmf5eX+zuxmcT2mkKU9a9p7iJZUpRFlnMs1fXFiDXc
         mAouYEwwpPAX7y5FlTpUYBbyP/zaSWL75WX/wuZ+H3EfT5N5jFSd8jo/U9CT4j4ZwnR+
         aQKUBB3rl+CM3hn8ZlJMbnePgLAKvYCYa5v2ZOIafA0aBFvG+Tjf7NVVv/XTirgjHq1q
         n1sQ==
X-Gm-Message-State: AOAM533sy/4wVROPrl5qzq3zoITsT2acj6HBng51cNlMCWj8Rjr7F3GW
        DrAiD8Bly5r5wsl7fhg0O/jyZIt4VaRnfJa2+HW3f84pGl1dug==
X-Google-Smtp-Source: ABdhPJzREJdwUvMI2flY5p1LEZfDLH/rA4XMihALOnYf36XgrsCRBZhHvQplHU1XeY9AvUvfSqPEa20Jl8cwJHxI4h0=
X-Received: by 2002:a67:d990:: with SMTP id u16mr4448567vsj.44.1635762237131;
 Mon, 01 Nov 2021 03:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1633535940.git.zhuyifei@google.com> <a2e569ee61e677ee474b7538adcebb0e1462df69.1633535940.git.zhuyifei@google.com>
 <CAEf4Bzbj0Bd5bnUrJMr4ozFFAHVE=NvsO1KR1o9=iqBT85=LUw@mail.gmail.com>
 <CAA-VZP=Hft3MkKxc+2xxM6Qc1ZO=d+2JshjV5g2TxfymjfW6rw@mail.gmail.com>
 <CAKH8qBs2xgqJnECSNpguqkwNMOd4m2gaz1CGueReP32cUdPgGw@mail.gmail.com>
 <CAA-VZP=rXb_oyoORsK5apL39xpY7XeVAdEQvVFhBqUBQOTxthA@mail.gmail.com> <CAKH8qBunq4LQGGuX9_L_3BMgPNOjqjZJrxK0ih6QnD_UYsAq6w@mail.gmail.com>
In-Reply-To: <CAKH8qBunq4LQGGuX9_L_3BMgPNOjqjZJrxK0ih6QnD_UYsAq6w@mail.gmail.com>
From:   YiFei Zhu <zhuyifei@google.com>
Date:   Mon, 1 Nov 2021 03:23:46 -0700
Message-ID: <CAA-VZPmGtJHBE_PpTyx2ccfw45cTCLD4t80yXQgaQEJfbLXE-Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Add cgroup helper bpf_export_errno to
 get/set exported errno value
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 26, 2021 at 2:26 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> On Tue, Oct 26, 2021 at 1:50 PM YiFei Zhu <zhuyifei@google.com> wrote:
> >
> > On Tue, Oct 26, 2021 at 8:44 AM Stanislav Fomichev <sdf@google.com> wrote:
> > >
> > > On Mon, Oct 25, 2021 at 5:06 PM YiFei Zhu <zhuyifei@google.com> wrote:
> > > >
> > > > On Wed, Oct 20, 2021 at 4:28 PM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > it's subjective, but "bpf_export_errno" name is quite confusing. What
> > > > > are we "exporting" and where?
> > > > >
> > > > > I actually like Song's proposal for two helpers,
> > > > > bpf_set_err()/bpf_get_err(). It makes the semantics less confusing. I
> > > > > honestly don't remember the requirement to have one combined helper
> > > > > from the BPF office hour discussion, but if there was a good reason
> > > > > for that, please remind us.
> > > > >
> > > > > > + *     Description
> > > > > > + *             If *errno_val* is positive, set the syscall's return error code;
> > > > >
> > > > > This inversion of error code is also confusing. If we are to return
> > > > > -EXXX, bpf_set_err(EXXX) is quite confusing.
> > > > >
> > > > > > + *             if *errno_val* is zero, retrieve the previously set code.
> > > > >
> > > > > Also, are there use cases where zero is the valid "error" (or lack of
> > > > > it, rather). I.e., wouldn't there be cases where you want to clear a
> > > > > previous error? We might have discussed this, sorry if I forgot.
> > > >
> > > > Hmm, originally I thought it's best to assume the underlying
> > > > assumption is that filters may set policies and it would violate it if
> > > > policies become ignored; however one could argue that debugging would
> > > > be a use case for an error-clearing filter.
> > > >
> > > > Let's say we do bpf_set_err()/bpf_get_err(), with the ability to clear
> > > > errors. I'm having trouble thinking of the best way to have it
> > > > interact with the getsockopt "retval" in its context:
> > > > * Let's say the kernel initially sets an error code in the retval. I
> > > > think it would be a surprising behavior if only "retval" but not
> > > > bpf_get_err() shows the error. Therefore we'd need to initialize "err"
> > > > with the "retval" if retval is an error.
> > > > * If we initialize "err" with the "retval", then for a prog to clear
> > > > the error they'd need to clear it twice, once with bpf_set_err(0) with
> > > > and another with ctx->retval = 0. This will immediately break backward
> > > > compatibility. Therefore, we'd need to mirror the setting of
> > > > ctx->retval = 0 to bpf_set_err(0)
> > > > * In that case, what to do if a user uses ctx->retval as a way to pass
> > > > data between filters? I mean, whether ctx->retval is set to 0 or the
> > > > original is only checked after all filters are run. It could be any
> > > > value while the filters are running.
> > > > * A second issue, if we have first a legacy filter that returns 0 to
> > > > set EPERM, and then there's another filter that does a ctx->retval =
> > > > 0. The original behavior would be that the syscall fails with EPERM,
> > > > but if we mirror ctx->retval = 0 to bpf_set_err(0), then that EPERM
> > > > would be cleared.
> > > >
> > > > One of the reasons I liked "export" is that it's slightly clearer that
> > > > this value is strictly from the BPF's side and has nothing to do with
> > > > what the kernel sets (as in the getsockopt case). But yeah I agree
> > > > it's not an ideal name.
> > >
> > > For getsockopt, maybe the best way to go is to point ctx->retval to
> > > run_ctx.errno_val? (i.e., bpf_set_err would be equivalent to doing
> > > ctx->retval = x;). We can leave ctx->retval as a backwards-compatible
> > > legacy way of doing things. For new programs, bpf_set_err would work
> > > universally, regardless of attach type. Any cons here?
> >
> > Is it a concern that AFAICT getsockopt retval may be a positive number
> > whereas the err here must be non-negative?
>
> getsockopt retval is either -errno or 0. It's not really enforced at
> load/attach time, but there is a runtime check which returns -EFAULT
> if the prog sets it to something else.
>
> > Also the fourth point still stands. If any getsockopt returns 0,
> > original behavior is return -EPERM whereas new behavior, clearing
> > retval will clear -EPERM.
>
> True, but do you think these cases exist out there? I guess somebody
> can do it inadvertently, but the example you've mentioned doesn't
> really make sense, right?
> This is why we are adding a way to propagate the status, so the
> programs in the chain can understand whether they should do anything
> at all (previous prog returned EPERM). Returning EPERM from the child
> and then doing ctx->retval=0 in the parent should already not work as
> expected.

How about this? Have a bpf_{get,set}_retval that mirrors (in both
directions) the ctx->retval without any processing. Considering
in-kernel implementations of getsockopt sometimes return positive
values (usually optlen), we could allow eBPF-implemented getsockopt to
do so too, by relaxing the current 'only change to zero or keep the
same restriction, and allow it the filter to set arbitrary return
values to user space. For a filter that runs before the in-kernel
implementation, such as setsockopt or cgroup_skb, we verify after
running all the hooks, that it must be 0 or a negative number in
-errno; -EFAULT otherwise.

For legacy -EPERM programs that do it by returning 0, a filter that
bpf_set_retval(0) or ctx->retval = 0 will clear the -EPERM, this will
be different from the current behavior of getsockopt programs. I'm not
really sure of any use cases where users would rely on the current
behavior -- one would do ctx->retval = 0 to tell userspace that
something is done, yet another filter denies that 'something'? Doesn't
make sense to me, but correct me if I'm wrong or if we think this UAPI
must be kept exactly the same.

Another potential UAPI breakage is that originally getsockopt hooks
can inject an -EFAULT instead of -EPERM by setting bogus values to
ctx->retval. Now they have to do it by setting ctx->retval = -EFAULT;
any other value, even bogus values will be passed to userspace. That
said, I'm not sure why anyone would want to return an -EFAULT instead
of -EPERM; some unusual fault injection maybe? And in that case if
they literally want -EFAULT, the statement that makes sense would
already be ctx->retval = -EFAULT, which is usually a bogus value.

Considering that here we would have bpf_{get,set}_retval with no
in-kernel processing at all to mirror a value in ctx... I think it
would make a lot of sense to just use a context variable instead of
helpers (i.e. provide ctx->retval to all cgroup program types)?

YiFei Zhu
