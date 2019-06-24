Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E00951C02
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2019 22:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfFXUI6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jun 2019 16:08:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:44258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731487AbfFXUI6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Jun 2019 16:08:58 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8822B208E4
        for <bpf@vger.kernel.org>; Mon, 24 Jun 2019 20:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561406937;
        bh=yZharV4FdSmnh4ESX5hlMEMyGkbzv5g/opBE0Yc/f0I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y1IekffKS026ESmMRLJsvztz8MSob/Ro0R6FERAq9Bq0/tiEEnb1wPvsYvLv+gzeS
         jf0ST/tsLNz4FT7mGomzddkDvyOyMhn2cbgylD5MqpFhElQOlY99iS+3k+lQfAomRo
         uJkLnM6Rt8Zt/0bzPwQM9DU0YlHQnU8lKav0D2pc=
Received: by mail-wm1-f53.google.com with SMTP id s3so557151wms.2
        for <bpf@vger.kernel.org>; Mon, 24 Jun 2019 13:08:57 -0700 (PDT)
X-Gm-Message-State: APjAAAU9Wmm7TMuNM3j4cxZ2h7MsmSF/XN+gsJacz1U+GDuRMU+oVILS
        VzXBcUxdMyKllA6gQKPGcmVcjdy0Wa9BGJgFfQ7OVw==
X-Google-Smtp-Source: APXvYqyZ4fIE5cdsQv7I/gZrnrFakyNqFBpURFkRXdCRFCL/Nn5A6g099FGLoCCojiN2iaBzq20qxfRFBCC5+SY8tyQ=
X-Received: by 2002:a7b:cd84:: with SMTP id y4mr17194362wmj.79.1561406935987;
 Mon, 24 Jun 2019 13:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-24-matthewgarrett@google.com> <739e21b5-9559-d588-3542-bf0bc81de1b2@iogearbox.net>
 <CACdnJuvR2bn3y3fYzg06GWXXgAGjgED2Dfa5g0oAwJ28qCCqBg@mail.gmail.com>
In-Reply-To: <CACdnJuvR2bn3y3fYzg06GWXXgAGjgED2Dfa5g0oAwJ28qCCqBg@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 24 Jun 2019 13:08:44 -0700
X-Gmail-Original-Message-ID: <CALCETrWmZX3R1L88Gz9vLY68gcK8zSXL4cA4GqAzQoyqSR7rRQ@mail.gmail.com>
Message-ID: <CALCETrWmZX3R1L88Gz9vLY68gcK8zSXL4cA4GqAzQoyqSR7rRQ@mail.gmail.com>
Subject: Re: [PATCH V34 23/29] bpf: Restrict bpf when kernel lockdown is in
 confidentiality mode
To:     Matthew Garrett <mjg59@google.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        Chun-Yi Lee <jlee@suse.com>, Jann Horn <jannh@google.com>,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 24, 2019 at 12:54 PM Matthew Garrett <mjg59@google.com> wrote:
>
> On Mon, Jun 24, 2019 at 8:37 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> >
> > On 06/22/2019 02:03 AM, Matthew Garrett wrote:
> > > From: David Howells <dhowells@redhat.com>
> > >
> > > There are some bpf functions can be used to read kernel memory:
> >
> > Nit: that
>
> Fixed.
>
> > > bpf_probe_read, bpf_probe_write_user and bpf_trace_printk.  These allow
> >
> > Please explain how bpf_probe_write_user reads kernel memory ... ?!
>
> Ha.
>
> > > private keys in kernel memory (e.g. the hibernation image signing key) to
> > > be read by an eBPF program and kernel memory to be altered without
> >
> > ... and while we're at it, also how they allow "kernel memory to be
> > altered without restriction". I've been pointing this false statement
> > out long ago.
>
> Yup. How's the following description:
>
>     bpf: Restrict bpf when kernel lockdown is in confidentiality mode
>
>     There are some bpf functions that can be used to read kernel memory and
>     exfiltrate it to userland: bpf_probe_read, bpf_probe_write_user and
>     bpf_trace_printk.  These could be abused to (eg) allow private
> keys in kernel
>     memory to be leaked. Disable them if the kernel has been locked
> down in confidentiality
>     mode.

I'm confused.  I understand why we're restricting bpf_probe_read().
Why are we restricting bpf_probe_write_user() and bpf_trace_printk(),
though?

--Andy
