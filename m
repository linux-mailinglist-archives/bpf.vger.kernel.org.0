Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B94B1E3B38
	for <lists+bpf@lfdr.de>; Wed, 27 May 2020 10:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbgE0IFm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 May 2020 04:05:42 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56763 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729367AbgE0IFl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 27 May 2020 04:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590566740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Iv61hiKMRdE+binuenpMGOmIDwOOgnaGDNF59OZgFNw=;
        b=NHrh6dpz40bAkUrQG1thQhWXSWeGyGyk7SLEORNTL+VnEOBGxWSNa/CpMnRgg0+Gvquci9
        fo76oBU3ZJnQ3rcUVapYOwIdlUCujel+lWSQ33hJ6Ak4xCP7a0iLRPZd48HWA7+Tu8xQPG
        vCawv3CZm/lQvWHAaJltIKfxKuUZRQg=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-APUhzAX-OP-yDYWvjuY_cQ-1; Wed, 27 May 2020 04:05:37 -0400
X-MC-Unique: APUhzAX-OP-yDYWvjuY_cQ-1
Received: by mail-ot1-f72.google.com with SMTP id l26so3208534otr.14
        for <bpf@vger.kernel.org>; Wed, 27 May 2020 01:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iv61hiKMRdE+binuenpMGOmIDwOOgnaGDNF59OZgFNw=;
        b=e6HDLkmfrTC0ff48aakNYGA9VMmeb7MLYu4rDEVPcjIuCTsy0fjunme8OmIdSo4Y0L
         bGaM6PpBHSq0lbz8MRZmBe1r/KhQaIsgpWGHZo7dNEQAcAQVpHmbQlfWZ4EgovIP25Oe
         qRr/X9hMoSE6cbGlqGFOxZ+NinhUYg7skp+5wBFV09JZ/Ni4oUZYLKqdnVME9ognRunJ
         y9UWiq0hn2hn6guxRyKC4qOVYaBVo9CUgvYWqQd8OYmFG8K65CV5WKSzzljCfo+ou6bw
         T1qVk0ovlW0UNg7doOaKsMcdjU1t2ufPtE0ea9lmRJKRf//O45/wh4LI4fV2HsvOOqjh
         RaCg==
X-Gm-Message-State: AOAM533HeOzy0TwhFv4nN3jB8RMs2JSEmfzDliu+Hk0/dDeETokpjqoe
        gM6seL8vgdCt7RCgwW/+1pzI+qfbtb0zVKBwshyYRj1sAhg13l4ZmJ0dlZkJoBZCwEVhsi+/bin
        L5oGlOdVMrBZiczIYleNglqSfEwdb
X-Received: by 2002:a4a:3790:: with SMTP id r138mr2175322oor.81.1590566736950;
        Wed, 27 May 2020 01:05:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9cK1fII07jm9d1oAGLySP1vgu/XtruBGCfr+FfHNisYPVjdJRz45yDq/CDrOf06VCe/xxR8yWdn75OjyUWoM=
X-Received: by 2002:a4a:3790:: with SMTP id r138mr2175298oor.81.1590566736701;
 Wed, 27 May 2020 01:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200522041310.233185-1-yauheni.kaliuta@redhat.com>
 <xuny367so4k3.fsf@redhat.com> <CAEf4BzZd507Hyfu8GYxZfJ-Rc0GAs1UNCN0uBqX3kYS9sz-yDA@mail.gmail.com>
 <xunyv9kiou7w.fsf@redhat.com> <CAEf4Bzau5MWYqP1XfZzYVj6tf7Y9fmJRgjbO00DzOmJ_iGschg@mail.gmail.com>
 <xunyy2pdon4g.fsf@redhat.com>
In-Reply-To: <xunyy2pdon4g.fsf@redhat.com>
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Date:   Wed, 27 May 2020 11:05:20 +0300
Message-ID: <CANoWsw=5gypPiHYHLr+iKCY3CUwAHoEN1MsFuZEMbgOB8uRSyQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] selftests/bpf: installation and out of tree build fixes
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Jiri Benc <jbenc@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 27, 2020 at 10:25 AM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:

[...]

>  > My point is that by building in tree and then just copying
>  > everything under selftests/bpf directory to wherever you want
>  > to "install" it would just work. And won't require
>  > complicating already complicated Makefile. Any problem with
>  > such approach?
>
> I understand. I see only wasting of space as a problem, but
> should check.
>

Well, it messes up with the lib.mk functionality. There must be
explicit was for customization, like it's done with OVERRIDE_TARGETS.

