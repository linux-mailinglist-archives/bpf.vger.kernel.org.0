Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8D41E3F51
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2019 00:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbfJXWXu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Oct 2019 18:23:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34847 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729789AbfJXWXu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Oct 2019 18:23:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id l10so172025wrb.2
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2019 15:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gtv/AetZaEOiawKFy28xNaVVHmDK6h02djfjqXb1qLs=;
        b=rrCvlwyTk7Y1kcDek9hF7FDbJnVPSoc7d6iffpQzkvL5ItNiIN4QUlhz+csQ9Ha2c3
         7m5AFyAzXxqJ+eJqkUr2K+fKTnyqhif/mFIVY8Of87XGwOuH2OAYcT/tZrhegXgukqgw
         tryDWX3BvimOf3vjXk9kc8fVFZsUkHz7zNWqd1+g6xr0vYXBsSebXHeUalhvAD8LEPQ1
         6JUs8z+OrR90B1i9wT0v5CfEeuWO7KP9exHwFlHuqUOJwJteMIj1abSu71LsHff2wvsJ
         mQalbxN2u8SPUhQLsZPMoSk91Mec+mevtsaw3Puxj4PqvKY0cwh1nD3KUtqGh47QEKT0
         Cbiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gtv/AetZaEOiawKFy28xNaVVHmDK6h02djfjqXb1qLs=;
        b=U7Lp9gFSsWOvHsOh2EKrNO7+Q9Y0ycwyV9/4wpSqFUnOJsPT5dG/SNhz0Qdy5Qwk5W
         ywKQsrWq6oComsMmQqNuaufirnTwrjeWiyueKChux/ZcTEf4iCYxBzYYm8GnKGrJ2l+l
         I9sshw1DCcrJZvIQ+88VbEFkLUzM2ObRXyvsp3PQqYc7mZZnVlgFXKsIWja6+rWKiW92
         R/WgqWTFh7f9xUk94TttcI/Db8bRxJtdo+tFQZVnZAhTn6akrxdTiU5UMKUERq/GQeEw
         i/O2G16kCrRO4av0SDTSBAqzRbPJS9JuGrXh0lkWG1qy8UsyPuY8+HNMXamCQCoM1VUo
         fFSg==
X-Gm-Message-State: APjAAAWhlRx+dZYVYm+yuSwjQUCZ4cVYXgRkVg50qwcUePe3ple+5wvL
        VALZpvfH6uPmudE89kVQfftcxludt8TbhrG1pdqQsAq1
X-Google-Smtp-Source: APXvYqzQacM77eeXfVeljnlIazZDyc4wR98JJMV5RFFNBVyVUJQZKJs0OVHR87sYlKBSuJHwXwaB5BkMIxrmFT2xYXM=
X-Received: by 2002:a5d:5609:: with SMTP id l9mr5758717wrv.113.1571955825937;
 Thu, 24 Oct 2019 15:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <20191022043119.2625263-1-yhs@fb.com> <20191022192953.GB31343@pc-66.home>
 <f666fdcd-9b02-ca47-509b-aaffb3cf7c09@fb.com>
In-Reply-To: <f666fdcd-9b02-ca47-509b-aaffb3cf7c09@fb.com>
From:   Jiong Wang <jiong.wang@netronome.com>
Date:   Thu, 24 Oct 2019 23:23:42 +0100
Message-ID: <CAMsOgNDHEF5qYNFLvXfbXr9CBeYD_2W3465=t7mbmQnPbSv88A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] tools/bpf: turn on llvm alu32 attribute by default
To:     Yonghong Song <yhs@fb.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 23, 2019 at 3:27 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 10/22/19 12:29 PM, Daniel Borkmann wrote:
> > On Mon, Oct 21, 2019 at 09:31:19PM -0700, Yonghong Song wrote:
> >> llvm alu32 was introduced in llvm7:
> >>    https://urldefense.proofpoint.com/v2/url?u=https-3A__reviews.llvm.org_rL325987&d=DwIBAg&c=5VD0RTtNlTh3ycd41b3MUw&r=DA8e1B5r073vIqRrFz7MRA&m=0VCVs-aItkaVLRJ9Jp7YeX0We2JPKzcY7p_83Hlkso4&s=M0ANvh80tDNZb5JzE5vj9IETkKD87L1jFkcRHShC6Rk&e=
> >>    https://urldefense.proofpoint.com/v2/url?u=https-3A__reviews.llvm.org_rL325989&d=DwIBAg&c=5VD0RTtNlTh3ycd41b3MUw&r=DA8e1B5r073vIqRrFz7MRA&m=0VCVs-aItkaVLRJ9Jp7YeX0We2JPKzcY7p_83Hlkso4&s=LABlrq9E6tmCwrbU2bCQa_LwchCaL8Tk5GczMCO5Cvs&e=
> >> Experiments showed that in general performance
> >> is better with alu32 enabled:
> >>    https://urldefense.proofpoint.com/v2/url?u=https-3A__lwn.net_Articles_775316_&d=DwIBAg&c=5VD0RTtNlTh3ycd41b3MUw&r=DA8e1B5r073vIqRrFz7MRA&m=0VCVs-aItkaVLRJ9Jp7YeX0We2JPKzcY7p_83Hlkso4&s=qSDIIkauxw9Y_8rYH0AlvB4nvu06reDuhsb0GxSpoBo&e=
> >>
> >> This patch turned on alu32 with no-flavor test_progs
> >> which is tested most often. The flavor test at
> >> no_alu32/test_progs can be used to test without
> >> alu32 enabled. The Makefile check for whether
> >> llvm supports '-mattr=+alu32 -mcpu=v3' is
> >> removed as llvm7 should be available for recent
> >> distributions and also latest llvm is preferred
> >> to run bpf selftests.
> >>
> >> Note that jmp32 is checked by -mcpu=probe and
> >> will be enabled if the host kernel supports it.
> >>
> >> Cc: Jiong Wang <jiong.wang@netronome.com>
> >> Acked-by: Andrii Nakryiko <andriin@fb.com>
> >> Signed-off-by: Yonghong Song <yhs@fb.com>
> >
> > Applied, thanks!
> >
> > Would it make sense to include -mattr=+alu32 also into -mcpu=probe
> > on LLVM side or is the rationale to not do it that this causes a
> > penalty for various other, non-x86 archs when done by default
> > (although they could opt-out at the same time via -mattr=-alu32)?
>
> The current -mcpu=probe is mostly to provide whether particular
> instruction(s) are supported by the kernel or not. This follows
> traditional cpu concept. For -mattr=+alu32 case, instruction set
> remains the same, but we need to probe verifier capability.
>
> But I agree that for bpf probing verifier for alu32 support
> is totally reasonable.
>
> Jiong, could you help do an implementation in llvm side since
> you are more familiar with what alu32 capability needs to be
> checked for verifier? Thanks!

I think alu32 code-gen becomes good and stable after jmp32
instructions (cpu=v3) supported,  so if we want to enable alu32 at
default, perhaps could just link it with v3 probe, and also Daniel's
opt-out suggestion makes sense.

Will try to do one impl but not sure could catch the timeline
tomorrow. For what it's worth, tomorrow will be my last day using
Netronome email, I will use wong.kwongyuan.tools@gmail.com for
bpf/kernel contributing temporarily.

-- 
Regards,
Jiong
