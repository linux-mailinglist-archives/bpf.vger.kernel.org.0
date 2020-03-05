Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1529017ADC6
	for <lists+bpf@lfdr.de>; Thu,  5 Mar 2020 19:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgCESCV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Mar 2020 13:02:21 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35724 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgCESCV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Mar 2020 13:02:21 -0500
Received: by mail-ot1-f68.google.com with SMTP id v10so6631460otp.2;
        Thu, 05 Mar 2020 10:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bImCa8e75imP5OBiFn4OIcu9vGwfjFkhcN3Jk6EQf9c=;
        b=UBjwhXXB7Z3eO7J/9T0RT1RI8fpcwomIFdsfs667Q3w3V4MrEqj1JxGClS1nCzLXtu
         OB4WkpY+EooNfPTvjY0qr7DuPSuAt7D3SqzFKq/ellIgtaM3DY5QKKfXbjyCEvvEnz4t
         hQgjGwsVgvNtcF/t15XaM8sJ0DczcuyEFDLQngNw/LaGa25bryQxdbXRJXbFyqwVr35S
         4mc7xyA/NQFFk/74kv7IXPPe0E+jcGUm/mVR+WQR/dRZWyEB6xBf164GWiu62359avCj
         pNLVz2qmkVV68i19jQxzYExh6ecLV9Wd0N80e0/2f1v7GC1yxe8B96jBPoj4u9BcY+5t
         eiqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bImCa8e75imP5OBiFn4OIcu9vGwfjFkhcN3Jk6EQf9c=;
        b=nq0pSMsCcs7ZolZI5OpvXhCVJW6FXOtzhdFe6GrDCYNaCRPQGXgER8mmS1TbzKvpaS
         ycUV0tQWSsNS8cYIo7B2IFDoe2iCoMhRvGobiYE3xHxHAdulWCVCOFDwmCTpfI3AIB1e
         rHIWl9v8zjpIZGcvusBqR6l5XyHDmpm5qWvo6pyKs5ZEjRYtJK3iSslBldsZjdjrkmkr
         rx/PliuQ7U13hW0uRuIVEczDUYYN7w4J2SflhmUqNWWLF0OtO+nouM7PkiJPUIqlUDFM
         jFVZ0CwL04xqb85hB7R3V+rgoayogYqg5J7a+pGUGfNznBia/Ieh6vjwUqP0Q4WA31vN
         dpQQ==
X-Gm-Message-State: ANhLgQ2P87WWWV8yZfXHMFQxw4OqxHF+VWFGmozxS9TP1IRHIT66U7nq
        QBFGEqI3lWIfvfomGVQXOIuxTm8SAbNoe+nXjJs=
X-Google-Smtp-Source: ADFU+vsvbQuqzn8gGOtAxjPNVm9WpKEFdkyFDU2gticZVw82S72hfRFT62HlHzFLjnhAG5wKOwfQ5MHvENi4XGLAZXw=
X-Received: by 2002:a05:6830:22f2:: with SMTP id t18mr7959676otc.165.1583431340611;
 Thu, 05 Mar 2020 10:02:20 -0800 (PST)
MIME-Version: 1.0
References: <20200304191853.1529-1-kpsingh@chromium.org> <20200304191853.1529-4-kpsingh@chromium.org>
 <CAEjxPJ4+aW5JVC9QjJywjNUS=+cVJeaWwRHLwOssLsZyhX3siw@mail.gmail.com>
 <20200305155421.GA209155@google.com> <d7615424-48cb-1131-3c5d-f2a0b4adfaf7@schaufler-ca.com>
In-Reply-To: <d7615424-48cb-1131-3c5d-f2a0b4adfaf7@schaufler-ca.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 5 Mar 2020 13:03:26 -0500
Message-ID: <CAEjxPJ7EQjq2J8AGn+b90=yMG9H5CaNErk1PqtTz8T3CwdAvJw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/7] bpf: Introduce BPF_MODIFY_RETURN
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     KP Singh <kpsingh@chromium.org>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>, jmorris@namei.org,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 5, 2020 at 12:35 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> I believe that I have stated that order isn't my issue.
> Go first, last or as specified in the lsm list, I really
> don't care. We'll talk about what does matter in the KRSI
> thread.

Order matters when the security module logic (in this case, the BPF
program) is loaded from userspace and
the userspace process isn't already required to be fully privileged
with respect to the in-kernel security modules.
CAP_MAC_ADMIN was their (not unreasonable) attempt to check that
requirement; it just doesn't happen to convey
the same meaning for SELinux since SELinux predates the introduction
of CAP_MAC_ADMIN (in Linux at least) and
since SELinux was designed to confine even processes with capabilities.

> Then I'm fine with using the LSM ordering mechanisms that Kees
> thought through to run the BPF last. Although I think it's somewhat
> concerning that SELinux cares what other security models might be
> in place. If BPF programs can violate SELinux (or traditional DAC)
> policies there are bigger issues than ordering.

It is only safe for Smack because CAP_MAC_ADMIN already conveys all
privileges with respect to Smack.
Otherwise, the BPF program can access information about the object
attributes, e.g. inode attributes,
and leak that information to userspace even if SELinux would have
denied the process that loaded the BPF
program permissions to directly obtain that information.  This is also
why Landlock has to be last in the LSM list.
