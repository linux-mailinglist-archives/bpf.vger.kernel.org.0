Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D86B19C6E2
	for <lists+bpf@lfdr.de>; Thu,  2 Apr 2020 18:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389816AbgDBQRH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Apr 2020 12:17:07 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42610 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389697AbgDBQRG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Apr 2020 12:17:06 -0400
Received: by mail-ed1-f65.google.com with SMTP id cw6so4902679edb.9
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2020 09:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YgBslAldvscDXaORuuun4CbeNjFjkHCMAuaEorWuYL4=;
        b=q5YI5motFsJgWwPIHAvUMAcBB50kvt9eHqMYuU9M12bKxZ6NhkesQzg7NUw9FhcnTn
         uYUePR+4Smc+dyPsMoVNenjQ40AHp5emwcMALe+C8Uhldi197aWsax4Qcg38cWA0FEcl
         MDuI/dJlOZhO0GAy2op7BTai5k4x9XH48L4OFlRQZygTS3KVlrLVF0iKJrxKudu6TQe3
         RsXOQ4Z19TMFGeblGsZ1X+mdvljTTuyg7g3Qwwt7hxlIphKuavr2atH1uWX0Wl9SCK8n
         AVudsJZU0Nc9kpDWljGX01mk+6yPG4BeRyyeVw5ziXU5C8fNq9p5TtTMfvh0e7QQ+LkK
         9vvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YgBslAldvscDXaORuuun4CbeNjFjkHCMAuaEorWuYL4=;
        b=RXIRuUd6NpY2DdVvkVAlwbJ+IkMmy5LFdb4hOtzkV2uQFUk5metmfK9ZJwDLdSpTjp
         bFOOTVL5XZGeDhqt0qKXvPlylwDYRjzwBBCkZUbor5mxLi26gapaZ4zh8sqSwabOmJm8
         BfUQkoolRgxXQDkYh/v+gL2VmeZCGHNF6mFL6pqiJ7KssURi+br7l4Vc5R/VRjfUmWwp
         BlDRbui1H0sbDkfuHaj9/uX0PempQ9ICuyXiAryGZCXdGdk+ZKjY9+JmLyAKUlFMi5GR
         0mAfvp3szo8JfHeJ+jypKr/GK+/TgIpDvyJ0mH50dN4fOejqDfPgOI/5T+5v3u7zbxnk
         MjAQ==
X-Gm-Message-State: AGi0PubEztzQQoYdlecjwvxJ9yidbi/z0wwwTgMQR7WBXvImkw4KxuEZ
        RNZROGjEkF9Kn04ipy5i/n+wZuT37/84QASpyCzTBIEE
X-Google-Smtp-Source: APiQypJiaP/pX2+SlUMqPqmJx+tXQsikwHLoKClGDFBIqDOPtvs3Pf8A8slVRHA9RT39Zf3N692Kb+hT8kXbXuBdiwo=
X-Received: by 2002:a50:cd5a:: with SMTP id d26mr3823478edj.65.1585844223314;
 Thu, 02 Apr 2020 09:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <CANaYP3GNm-siPt49Z5SSvgcF9YT4oN_enznMkaEFgbBBC9qrDQ@mail.gmail.com>
 <20200401232849.wms6vfuozvis5t2s@ast-mbp> <CANaYP3GgpWKpiW-ATQ6UYLwNWJ3EqBKf-6d8Ki4xWXHVBOGvQw@mail.gmail.com>
 <CAADnVQLfZv=1H_CuJwOyJK+=9iv=bdA7yCbMta0G2bqh6EmXRw@mail.gmail.com>
In-Reply-To: <CAADnVQLfZv=1H_CuJwOyJK+=9iv=bdA7yCbMta0G2bqh6EmXRw@mail.gmail.com>
From:   Gilad Reti <gilad.reti@gmail.com>
Date:   Thu, 2 Apr 2020 19:16:26 +0300
Message-ID: <CANaYP3EMYbeg67O5O1sjcHBF3MFhB+dyKYywr8i-VQwoFHWcaA@mail.gmail.com>
Subject: Re: probe_write_common_error
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 2, 2020 at 6:38 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> re-added mailing list back. pls don't remove it from cc.
Sorry, this wasn't on purpose.
>
> On Thu, Apr 2, 2020 at 1:05 AM Gilad Reti <gilad.reti@gmail.com> wrote:
> >
> > On Thu, Apr 2, 2020 at 2:28 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Mar 31, 2020 at 07:16:28PM +0300, Gilad Reti wrote:
> > > > When I try to probe_write_common into a writable location (e.g a
> > > > memory address on a usermode stack) which is not yet mapped or mapped
> > > > as read only to the memory, the function sometimes return a EFAULT
> > > > (bad address) error. This is happening since the pagefault handler was
> > > > disabled and thus this memory location won't be mapped when the
> > > > function tries to write into it, an error will be returned and no data
> > > > will be written.
> > > > Is that behavior intended? Did you want those functions to have as
> > > > less side-effects are possible?
> > >
> > > You mean bpf_probe_write_user() helper?
> > Well yes, but it calls probe_write_common which disables the pagefault
> > handler so I asked about it.
> > > Yes it's a non-faulting helper that will fail if prog is trying to
> > > write into a valid memory that could have been served with minor fault.
> > > The main reason for this is that bpf progs are not allowed to sleep.
> > > We're working on sleepable bpf progs that will be able to do copy_from/to_user
> > > from the context where it is safe to sleep. Like syscall entry.
> > Thanks!
> > > Could you please share more about your use case, so we can make sure
> > > that it will be covered by upcoming work?
> > Sure. I was playing with modifying kprobed syscall parameters (for
> > example, changing the path of an openat syscall etc).
>
> yes, but what is the use case?
> Why do you want to modify path of openat syscall?
I had no specific use case. I have seen that eBPF can modify usermode
memory and wanted to experiment with that...
