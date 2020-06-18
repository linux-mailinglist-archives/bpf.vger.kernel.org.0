Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D011FFB71
	for <lists+bpf@lfdr.de>; Thu, 18 Jun 2020 21:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgFRTDs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Jun 2020 15:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgFRTDp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Jun 2020 15:03:45 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2283FC06174E
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2020 12:03:45 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id t6so5389684otk.9
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2020 12:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ADpL0Q3zTC6e1Jx91yWqfx4lOG/Qk7A5LHq5efYjizU=;
        b=zXdc+Iew77X/SkJmNVS3AnASuo67NlOM+BlSZdEP3IZRmaZWpFjXdBnL/TDDW47UNE
         gERfUPA/0FJZjzrg5lzgzXbQ4DtSx2AZZM2DeH0Is9zhBrrR5+PDD6Njbd9HTVGZLqzs
         6wrpXWoIDi9EeooIAIDeqhoUsW/58eG95mkKtuCv3E0kj9rTrKALRh7UwP+AOj6jWGj2
         BftyBMXCU8+IVyqpvpNU5f/mIjcWjwteXAUms6H7FGObOnqCuwJC56EkHsTb6rqvnfZ+
         4ZqE1i16RseZjV6j5TTogARhsbv8/emFu4riwdjp0yKwNwPsfFQMUR5d6IE1GUCjhbf/
         ItnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ADpL0Q3zTC6e1Jx91yWqfx4lOG/Qk7A5LHq5efYjizU=;
        b=ok2zvde+6xCFJqCEADyUgGS/3c2IPwMclqX3qEUj2zRXGlYgp5NKLXJDkJx9N/r1cA
         +xoB0ryM3Jh0v7gNffCmm7FpSgYVyEzYu5wqosSVMuFY2GCP1RrVjFiWQL+cbMR5eJrV
         H/dZt5iwldYkHGeIYq2Vv5g5Imbo1sHgWGPzyCTGgMfiFmKIhUlQ0wWNozEDIrHv9udI
         r1Xun3Eiuz0OjPDSWKr9mbZl9k4HCbpM/oIcjX9OHOtNGpfhwE4SQfNwQzaZCMErVG7u
         jRIxNZp7p48jmJNwO8o8p4fc1w291SRSl4FA/5MPJevpXxD0Ten0g0/zOKsa3xiA9vg7
         TLGg==
X-Gm-Message-State: AOAM533pWQcea24jE79RoHpOnvcMkrBw/gMoEBLM7LOplDTWXaHNCLw2
        EUAPFnyAusE+iCoqQLP/7ip3XF3FpL+pH7bsyw809w==
X-Google-Smtp-Source: ABdhPJxCkUjA0P6DBPfUyyXr1BNUHIZ+CloIY0fwFw9t8HJ59KT66Q5snQRMM3Ndd7LKzgbmQwSM2CPggwes7nv7yZk=
X-Received: by 2002:a9d:1296:: with SMTP id g22mr182244otg.102.1592507023480;
 Thu, 18 Jun 2020 12:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAHo-OoxJ6XBrBDXUxhCr0J58eOGq3FZu5+Rg6GLeeCjThrA8rg@mail.gmail.com>
 <CAADnVQKXbd986SrW2u4nxY-0nNuC7VoVM29=3LeD9potOJTdZQ@mail.gmail.com> <CAHo-Ooz4smKgTDTit4NAnaasUDLJLkX7iRcYouv4KY=AG5SUaA@mail.gmail.com>
In-Reply-To: <CAHo-Ooz4smKgTDTit4NAnaasUDLJLkX7iRcYouv4KY=AG5SUaA@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 18 Jun 2020 12:03:32 -0700
Message-ID: <CALAqxLXgnqSM16=a3O1NyqYae1n_rMyw4_hcx5APm9s-h3TBtQ@mail.gmail.com>
Subject: Re: capable_bpf_net_admin()
To:     =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        BPF Mailing List <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Amit Pundir <amit.pundir@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 18, 2020 at 3:20 AM Maciej =C5=BBenczykowski
<zenczykowski@gmail.com> wrote:
>
> John has all the details.  I'm just guessing.
>
> But having actually looked at the code, commit 2c78ee898d8f1 ie.
>
> kernel/bpf/syscall.c: bpf_prog_load()
> +       if (is_net_admin_prog_type(type) && !capable(CAP_NET_ADMIN))
> +               return -EPERM;
>
> looks fishy, since our bpfloader only has CHOWN SYS_ADMIN, and the
> maps/programs it creates/loads are used by netd which only has
> NET_ADMIN (but not SYS_ADMIN).  Furthermore I don't really want to
> grant it NET_ADMIN.
>
> I think this should again be either NET_ADMIN or SYS_ADMIN.

Just to confirm, reverting 2c78ee898d8f1 (which doesn't revert
perfectly cleanly) seems to avoid the failure I was seeing.

And specifically in the chunk Maciej pointed out above, if we just
switch the check to CAP_SYS_ADMIN it also avoids the problem.

Let me know if there is anything folks would like me to test!

thanks
-john
