Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA08C20F8D5
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 17:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389710AbgF3PuZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 11:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389703AbgF3PuZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Jun 2020 11:50:25 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91616C061755
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 08:50:24 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id x83so10309255oif.10
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 08:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nAAFkdYYJ+2GoH48WcuwVslj7lbZ3ph/wxzxJ7avE4w=;
        b=hTEGfnUVm5s02Dis6nkE+CoF9nuzjEiRqJW/UMd+iJSHOCB18QtixER0mdw3bg7HkX
         CyiWIIPz66H1AUd6DvUxxS8og7DOimpy6zeJa2G/1Wg1Ti2W1V8L8u5d1aSl1sOCb63p
         xcsZUDWwQ0BQFIPd1Q2FX9XDuR6VcQxhyk0Y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nAAFkdYYJ+2GoH48WcuwVslj7lbZ3ph/wxzxJ7avE4w=;
        b=Ir2niwLELXhXgTmkZsamj2JImHSBvkpP1RwK8EYV3cDBqGqScswhtDnQfIxzMBwLRc
         xg4A9DgLantJskAcLf5riYWKtcVxjpdGn7JRwavnbbpYb5ZIBAl0isOTCytA/rsbCm9t
         s476n2QTTPk8tlKPWWdbiY0phHo3KJQ3l6krWxuXQ+aCMFlk/Hgdzw1Ub9Vdd1O5HM5j
         FLC+NEUgVjylbsp3MZYvQ16MG4eBQSfBPzyxwn7WwA0/WJimGKqyyKkXaar7NGNJ2SZQ
         YmbH8jBNfC3Bj5o4zT5GjfylNFIUYvrvQlyO9eM4RFPyq1GrZzW03SaVkBhCYuCDrqxa
         mSoQ==
X-Gm-Message-State: AOAM533S27CMn8eIDmJ3kq0+xAXInF8lVN+MZTtdqRi2nN+CmJHT47oQ
        VTxbAiyWEbeT11Gpj3mb6ZS5AML0cpas98QwCx+0Vg==
X-Google-Smtp-Source: ABdhPJwV+EoohmZyneNGcDwaFfL/MA7dO48kUMK9qyg4y2qAqizP35EzjuloyUOID/8GUEHYr3iukpLZtCoC8uFhWoI=
X-Received: by 2002:aca:c6cd:: with SMTP id w196mr16955233oif.13.1593532223897;
 Tue, 30 Jun 2020 08:50:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200629095630.7933-1-lmb@cloudflare.com> <07d10dab-64f7-d7af-25b9-a61b39c8daf2@fb.com>
 <CACAyw9_5Dg=dTMk3TQiYFE3vzUuq68V2-NcpZCuiQqJFPn-0Dw@mail.gmail.com> <8fcf1a4c-5a5a-280a-65eb-fa8bc8a298c1@fb.com>
In-Reply-To: <8fcf1a4c-5a5a-280a-65eb-fa8bc8a298c1@fb.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 30 Jun 2020 16:50:12 +0100
Message-ID: <CACAyw9_wAmj=DnUp85-rcOp57sWW6F2UqmdO_ifFEtJ=ySMyHw@mail.gmail.com>
Subject: Re: [PATCH bpf v2 0/6] Fix attach / detach uapi for sockmap and flow_dissector
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>,
        kernel-team <kernel-team@cloudflare.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 30 Jun 2020 at 16:08, Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 6/30/20 1:39 AM, Lorenz Bauer wrote:
> > On Tue, 30 Jun 2020 at 06:48, Yonghong Song <yhs@fb.com> wrote:
> >>
> >> Since bpf_iter is mentioned here, I would like to provide a little
> >> context on how target_fd in link_create is treated there.
> >
> > Thanks!
> >
> >> Currently, target_fd is always 0 as it is not used. This is
> >> just easier if we want to use it in the future.
> >>
> >> In the future, bpf_iter can maintain that target_fd must be 0
> >> or it may not so. For example, it can add a flag value in
> >> link_create such that when flag is set it will take whatever
> >> value in target_fd and use it. Or it may just take a non-0
> >> target_fd as an indication of the flag is set. I have not
> >> finalized patches yet. I intend to do the latter, i.e.,
> >> taking a non-0 target_fd. But we will see once my bpf_iter
> >> patches for map elements are out.
> >
> > I had a piece of code for sockmap which did something like this:
> >
> >      prog = bpf_prog_get(attr->attach_bpf_fd)
> >      if (IS_ERR(prog))
> >          if (!attr->attach_bpf_fd)
> >              // fall back to old behaviour
> >          else
> >              return PTR_ERR(prog)
> >      else if (prog->type != TYPE)
> >          return -EINVAL
> >
> > The benefit is that it continues to work if a binary is invoked with
> > stdin closed, which could lead to a BPF program with fd 0.
>
> For bpf_iter, there is no legacy. So I will have something like
>      // somecondition could be new attr->flags, or some kernel internal
> checking
>      if (somecondition) {
>        /* not accepting fd 0 */
>        if (attr->attach_bpf_fd == 0)
>          return -EINVAL;
>        prog = bpf_prog_get(attr->attach_bpf_fd)
>        if (IS_ERR(prog))
>          return PTR_ERR(prog)
>      } else if (attr->attach_bpf_fd != 0)
>        return -EINVAL;
> or I could have
>      if (somecondition) {
>        /* accepting any fd */
>        prog = bpf_prog_get(attr->attach_bpf_fd)
>        if (IS_ERR(prog))
>          return PTR_ERR(prog)
>      } else if (attr->attach_bpf_fd != 0)
>        return -EINVAL;
>
> This "somecondition" is false for the current bpf_iter, so existing
> behavior attr->attach_bpf_fd == 0 is still enforced.
>
> >
> > Could this work for bpf_iter as well?
> >
> >>
> >> There is another example where 0 and non-0 prog_fd make a difference.
> >> The attach_prog_fd field when doing prog_load.
> >> When attach_prog_fd is 0, it means attaching to vmlinux through
> >> attach_btf_id. If attach_prog_fd is not 0, it means attaching to
> >> another bpf program (replace). So user space (libbpf) may
> >> already need to pay attention to this.
> >
> > That is unfortunate. What was the reason to use 0 instead of -1 to
> > attach to vmlinux?
>
> attaching to vmlinux happens first and at that time attach_prog_fd
> does not exist. Later when replace prog feature is introduced,
> attach_prog_fd is added. This field is used to differentiate
> between vmlinux func attachment vs. bpf_prog attachment. A little
> bit unfortunate, but using 0 is easier as we have check_attr
> in the kernel to ensure all kernel-unsupported fields must be 0.
> using -1 will break that.

Ah, that makes sense, thank you!

Best
Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
