Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D7B43A917
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 02:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbhJZAIz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 20:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbhJZAIy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Oct 2021 20:08:54 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEDAC061745
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 17:06:31 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id o26so11774409uab.5
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 17:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8rRDEWTK36PdUw/E/Fa/gp8H9JXxNSQ6vCnNr8V/ZN8=;
        b=MSL8wU70YzlZasAXsx2sBN6zQRpcCsAJTYPSmojtypFj5qssqHCutv0AjY0VNFIu0f
         5yrqreA5BaEfs4IKuth7FYJmK7q0JEjfNY0P19RUgrfP1HRROylY/kDUmqU/LqBFpC9i
         6eLsDwrlehDWyeh49Tfq4u3W960zGAbud8rv5lk4671dwr1eT4o9mRSb7TXcSIy1U3/O
         WgCOZz58l1XprxgszqzMP4hE2+Y3NjxDo1x4pNCpK4TrE5hX6B2sBmjgTspw+UEw8XRk
         knHdNNyQG0WoKszeUzKx0W66AQaeC72A9kJhcn6PXvDrttYwJxGGeGP+SCZ26VPufvG2
         cORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8rRDEWTK36PdUw/E/Fa/gp8H9JXxNSQ6vCnNr8V/ZN8=;
        b=4eQYAIY/cmFK26VZGkQOyAC0kFtFWE5XOlRVngfktsVG14fi8D0PbIe/rtQLfanF9w
         4784yEgf1WYQUfyxjE9VNkGyoF15LvIE4GvQkLWM6hnIX+z6Txx89L1juGRCJH86SpOs
         u93/IprXCpXFpMnH8eEgil7sDQwHGNx6LPZxylAIiGCOjYcKJzO8M2i7ySiJRQ9yCpnj
         lByCB7jwF1YIYSD9Xur+6Zx6SSePqYj0vxjr6pdMwr1kAoaCJBXXlmO7Yc6hs/pJ5wCA
         PNQaf+nrNuGSTOjSyE/9LstqavONqUMMt5G2muVhvgQYpMGIfaWTg8Tch+uJyKsS8kFv
         eBSw==
X-Gm-Message-State: AOAM5319i4SkMFgAw6wFomeAq7kb9j2no8/Nuo5l9i6+5khaqLPY/IOJ
        di7PC82evSOk3ey5ozXVIJ0HlBtWToy5OMCdzUYk/Q==
X-Google-Smtp-Source: ABdhPJwgdIDcWEzWNa12DKosaoUXk5daOeJjSZVM8hTXj4Pq/De2WM5BIOlWX4MaKbyU9Ban+e1rRZihMbfkGa8TvXg=
X-Received: by 2002:a67:ebcf:: with SMTP id y15mr3000441vso.43.1635206790149;
 Mon, 25 Oct 2021 17:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1633535940.git.zhuyifei@google.com> <a2e569ee61e677ee474b7538adcebb0e1462df69.1633535940.git.zhuyifei@google.com>
 <CAEf4Bzbj0Bd5bnUrJMr4ozFFAHVE=NvsO1KR1o9=iqBT85=LUw@mail.gmail.com>
In-Reply-To: <CAEf4Bzbj0Bd5bnUrJMr4ozFFAHVE=NvsO1KR1o9=iqBT85=LUw@mail.gmail.com>
From:   YiFei Zhu <zhuyifei@google.com>
Date:   Mon, 25 Oct 2021 17:06:19 -0700
Message-ID: <CAA-VZP=Hft3MkKxc+2xxM6Qc1ZO=d+2JshjV5g2TxfymjfW6rw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Add cgroup helper bpf_export_errno to
 get/set exported errno value
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     YiFei Zhu <zhuyifei1999@gmail.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 20, 2021 at 4:28 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> it's subjective, but "bpf_export_errno" name is quite confusing. What
> are we "exporting" and where?
>
> I actually like Song's proposal for two helpers,
> bpf_set_err()/bpf_get_err(). It makes the semantics less confusing. I
> honestly don't remember the requirement to have one combined helper
> from the BPF office hour discussion, but if there was a good reason
> for that, please remind us.
>
> > + *     Description
> > + *             If *errno_val* is positive, set the syscall's return error code;
>
> This inversion of error code is also confusing. If we are to return
> -EXXX, bpf_set_err(EXXX) is quite confusing.
>
> > + *             if *errno_val* is zero, retrieve the previously set code.
>
> Also, are there use cases where zero is the valid "error" (or lack of
> it, rather). I.e., wouldn't there be cases where you want to clear a
> previous error? We might have discussed this, sorry if I forgot.

Hmm, originally I thought it's best to assume the underlying
assumption is that filters may set policies and it would violate it if
policies become ignored; however one could argue that debugging would
be a use case for an error-clearing filter.

Let's say we do bpf_set_err()/bpf_get_err(), with the ability to clear
errors. I'm having trouble thinking of the best way to have it
interact with the getsockopt "retval" in its context:
* Let's say the kernel initially sets an error code in the retval. I
think it would be a surprising behavior if only "retval" but not
bpf_get_err() shows the error. Therefore we'd need to initialize "err"
with the "retval" if retval is an error.
* If we initialize "err" with the "retval", then for a prog to clear
the error they'd need to clear it twice, once with bpf_set_err(0) with
and another with ctx->retval = 0. This will immediately break backward
compatibility. Therefore, we'd need to mirror the setting of
ctx->retval = 0 to bpf_set_err(0)
* In that case, what to do if a user uses ctx->retval as a way to pass
data between filters? I mean, whether ctx->retval is set to 0 or the
original is only checked after all filters are run. It could be any
value while the filters are running.
* A second issue, if we have first a legacy filter that returns 0 to
set EPERM, and then there's another filter that does a ctx->retval =
0. The original behavior would be that the syscall fails with EPERM,
but if we mirror ctx->retval = 0 to bpf_set_err(0), then that EPERM
would be cleared.

One of the reasons I liked "export" is that it's slightly clearer that
this value is strictly from the BPF's side and has nothing to do with
what the kernel sets (as in the getsockopt case). But yeah I agree
it's not an ideal name.

> But either way, if bpf_set_err() accepted <= 0 and used that as error
> value as-is (> 0 should be rejected, probably) that would make for
> straightforward logic. Then for getting the current error we can have
> a well-paired bpf_get_err()?
>
>
> BTW, "errno" is very strongly associated with user-space errno, do we
> want to have this naming association (this is the reason I used "err"
> terminology above).

Ack.

YiFei Zhu
