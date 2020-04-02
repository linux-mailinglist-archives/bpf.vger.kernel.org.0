Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 502CC19C60A
	for <lists+bpf@lfdr.de>; Thu,  2 Apr 2020 17:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388591AbgDBPiF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Apr 2020 11:38:05 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36694 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732754AbgDBPiF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Apr 2020 11:38:05 -0400
Received: by mail-lf1-f65.google.com with SMTP id w145so3121274lff.3
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2020 08:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=l2pv+sF0nJgIImzMOs7CmUtVOhgww9QzBLDYllI+T7o=;
        b=ppbFz34plF5pJ+MDr0VAPdKCRy3PCY+P7aFCaVm3rBBtjftAbG/riUJVI2nTuyZYy+
         Nf8oIM9K40XMqfyloiiTZGBLlSXq8kK5JMOJ2BIWk8Y+PpDkQwDVfy2N5ms4aCLLXFRH
         2BpPCTmo8V7x914hJsyLpiYCZ4xDqdKqphQv/Ax1TqwAd1+UJzK/a+UkohC8DdXkybIo
         HUAhh9QY7ycFCGF8EDd85ApgIsO5kTT7GXhLTAcKw4bnHrEvDU08IKDMVd/Quq+1avCa
         tbgTNgDfo/sx3x1syhS083x0RVlyZB7/xPa68ZxVP26dRLImJCZmZIxG7xidJRBBA+/W
         QiCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=l2pv+sF0nJgIImzMOs7CmUtVOhgww9QzBLDYllI+T7o=;
        b=idlv/5MRaYEHzNWnWLyP7nqu5JaxRsPrIROsJUIf85D+RK/wavY8uFU116tFoIGcZk
         1i1yHALgVwK642haCA9W7El4JE94FPE4BLe17TPHo4MIMpgfIJw6odbR8SG0jWw3bifK
         4Q2cJshU/9nCfBAFyTfOcMvlQ3A4cUEpyC/7wLPpbl+pjJNFoyvIJvMT3u566ZFV+n1+
         mJw/2LXqdJC3PCOgJwNcMhxNGV2P3iS3PKVI1LRf6XswteySRDxsOpCK7mJfTUwk3Pwh
         x03cmnxU4/sobfrtsAmkdfzOAjoOD8ccSV7RL2H3CQjO4m+OTLkRjAh6m0zD68Lv+iVK
         K6Rg==
X-Gm-Message-State: AGi0PuYZPi+TiIKLmzc1vo6NUr9wN3t9VvFoPfLkeOUhhuhOK07A3MPc
        wfSIvNMJW1PI/ojXwuQBQQFkQ+rWtQ11/mDBDkmWqw==
X-Google-Smtp-Source: APiQypJ2PulSr+ZRfDExGm/q4tzRnpH41qOIW/PLzH+689TXDZ3n2RcpHzkp1fmg59o1q2MUHzIT3wG9QPc9lOqsA1U=
X-Received: by 2002:a05:6512:304e:: with SMTP id b14mr2380439lfb.119.1585841882797;
 Thu, 02 Apr 2020 08:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <CANaYP3GNm-siPt49Z5SSvgcF9YT4oN_enznMkaEFgbBBC9qrDQ@mail.gmail.com>
 <20200401232849.wms6vfuozvis5t2s@ast-mbp> <CANaYP3GgpWKpiW-ATQ6UYLwNWJ3EqBKf-6d8Ki4xWXHVBOGvQw@mail.gmail.com>
In-Reply-To: <CANaYP3GgpWKpiW-ATQ6UYLwNWJ3EqBKf-6d8Ki4xWXHVBOGvQw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 2 Apr 2020 08:37:51 -0700
Message-ID: <CAADnVQLfZv=1H_CuJwOyJK+=9iv=bdA7yCbMta0G2bqh6EmXRw@mail.gmail.com>
Subject: Re: probe_write_common_error
To:     Gilad Reti <gilad.reti@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

re-added mailing list back. pls don't remove it from cc.

On Thu, Apr 2, 2020 at 1:05 AM Gilad Reti <gilad.reti@gmail.com> wrote:
>
> On Thu, Apr 2, 2020 at 2:28 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Mar 31, 2020 at 07:16:28PM +0300, Gilad Reti wrote:
> > > When I try to probe_write_common into a writable location (e.g a
> > > memory address on a usermode stack) which is not yet mapped or mapped
> > > as read only to the memory, the function sometimes return a EFAULT
> > > (bad address) error. This is happening since the pagefault handler was
> > > disabled and thus this memory location won't be mapped when the
> > > function tries to write into it, an error will be returned and no data
> > > will be written.
> > > Is that behavior intended? Did you want those functions to have as
> > > less side-effects are possible?
> >
> > You mean bpf_probe_write_user() helper?
> Well yes, but it calls probe_write_common which disables the pagefault
> handler so I asked about it.
> > Yes it's a non-faulting helper that will fail if prog is trying to
> > write into a valid memory that could have been served with minor fault.
> > The main reason for this is that bpf progs are not allowed to sleep.
> > We're working on sleepable bpf progs that will be able to do copy_from/to_user
> > from the context where it is safe to sleep. Like syscall entry.
> Thanks!
> > Could you please share more about your use case, so we can make sure
> > that it will be covered by upcoming work?
> Sure. I was playing with modifying kprobed syscall parameters (for
> example, changing the path of an openat syscall etc).

yes, but what is the use case?
Why do you want to modify path of openat syscall?
