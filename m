Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3386851BC1
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2019 21:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbfFXTyN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jun 2019 15:54:13 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39987 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728702AbfFXTyM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Jun 2019 15:54:12 -0400
Received: by mail-io1-f68.google.com with SMTP id n5so4862783ioc.7
        for <bpf@vger.kernel.org>; Mon, 24 Jun 2019 12:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YCg/MjFmfZjibFv1+zfjJ/08w0AqICIa/H9ziec7kII=;
        b=T5bgSuFF2J0SClg2TX96KcIkt8PMoAR1G3u6wAV9ZlHT11IjSJBWqyLCR87fxH+c29
         LTufoMIaOaS5RzlQZdhwIhVGqFpXAIChtxNsI8BWjtM0tF2pFRYeHCKuLi5czhKl6iw/
         Kh4t45FA7uaBdu+cxYKWG6S4qqD66Wb7/01m2fvDCCMbfZCFA4qJWtcmCxfFo0R0UJYn
         9RwhYjanjDxnX37mmFLMatT8eDcY+4IhBRCV/7mN+h5oZP/SOk7UlIo3kxh2grH6N1Aq
         nB2By88uwy0THJJ3z/Iol2KMXK0mq8grrgUkxODb07Yba6xPmycLbGleHl0GH6KQvt/o
         4a/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YCg/MjFmfZjibFv1+zfjJ/08w0AqICIa/H9ziec7kII=;
        b=pW3/VASQRff5RGqPC2JIWP8A4aFIgWGCK/0/fE1j/WuxvUtYWdzu2K6biRdUuVaFEW
         t66Fndwdwgmoscz8f39DnvWi4UCIEhvoqWAHB1WH9fJypo5xCVt//mYst+HWxKxQFUW+
         ySwsEy8h1MFJbZL7WSi2mWW433Do7XSfQYfaZQ2ImUir+D/yaAByz5yt9SvfiilsPwzy
         2VJ/3IkGUEHppAx3+YHM4IAMmbHa+1f/yfUnBnGhP6+P9AbghSIyA+04Eo/xIL0g5jhO
         6Kr6wGLWMZcr9YHK3PN7ZY2KBmbTG9OFVrLTkMusb3QvIhAhkIk3v5BP00ZWw6W9vPG3
         Rmug==
X-Gm-Message-State: APjAAAUoQ+TxAK6//hPdrIm3dGLbvnjhmkJJuUUQ3lqR13/p6AkjhHyo
        s73ormnqZdd0Jx1ICZmqrleNgAWjwLbyJEkZ9i2bCQ==
X-Google-Smtp-Source: APXvYqyFU7p5SRJ6nKCqIZqMdeK3zYkp5IdfxuzZhylp6PCqxOOHmnAokMWRrX7K9YZRQdLi+tIxlDW1HYKDsttAmXA=
X-Received: by 2002:a05:6638:3d3:: with SMTP id r19mr30442055jaq.53.1561406051539;
 Mon, 24 Jun 2019 12:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-24-matthewgarrett@google.com> <739e21b5-9559-d588-3542-bf0bc81de1b2@iogearbox.net>
In-Reply-To: <739e21b5-9559-d588-3542-bf0bc81de1b2@iogearbox.net>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 24 Jun 2019 12:54:00 -0700
Message-ID: <CACdnJuvR2bn3y3fYzg06GWXXgAGjgED2Dfa5g0oAwJ28qCCqBg@mail.gmail.com>
Subject: Re: [PATCH V34 23/29] bpf: Restrict bpf when kernel lockdown is in
 confidentiality mode
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     James Morris <jmorris@namei.org>,
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

On Mon, Jun 24, 2019 at 8:37 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 06/22/2019 02:03 AM, Matthew Garrett wrote:
> > From: David Howells <dhowells@redhat.com>
> >
> > There are some bpf functions can be used to read kernel memory:
>
> Nit: that

Fixed.

> > bpf_probe_read, bpf_probe_write_user and bpf_trace_printk.  These allow
>
> Please explain how bpf_probe_write_user reads kernel memory ... ?!

Ha.

> > private keys in kernel memory (e.g. the hibernation image signing key) to
> > be read by an eBPF program and kernel memory to be altered without
>
> ... and while we're at it, also how they allow "kernel memory to be
> altered without restriction". I've been pointing this false statement
> out long ago.

Yup. How's the following description:

    bpf: Restrict bpf when kernel lockdown is in confidentiality mode

    There are some bpf functions that can be used to read kernel memory and
    exfiltrate it to userland: bpf_probe_read, bpf_probe_write_user and
    bpf_trace_printk.  These could be abused to (eg) allow private
keys in kernel
    memory to be leaked. Disable them if the kernel has been locked
down in confidentiality
    mode.

> This whole thing is still buggy as has been pointed out before by
> Jann. For helpers like above and few others below, error conditions
> must clear the buffer ...

Sorry, yes. My fault.
