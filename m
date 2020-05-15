Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E181D52B0
	for <lists+bpf@lfdr.de>; Fri, 15 May 2020 16:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgEOO5j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 May 2020 10:57:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39717 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726163AbgEOO5i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 May 2020 10:57:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589554657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4x7bjXMvXuQSrvIM9mYugS4RQXFv/5eVjRIgPuMmbAE=;
        b=WUsS8bRvc1xarSy2JKB8A8IKDM8SmvGQKuAPgJMP90C/AjKYOxYglYwDNKfMV2WlxQvvq4
        ZPY9p8Qr91PhkTkxW5T5DUPkOi3l5/tMrGND8T2zINzOBBCWBnEzb1HNg45j2FjGFaC0fl
        2sX8rdHh/z1+Zm1f0YwUYacePlpk00k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-lG3B8tabNymEEY711rgZRQ-1; Fri, 15 May 2020 10:57:33 -0400
X-MC-Unique: lG3B8tabNymEEY711rgZRQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 327BB8018AC;
        Fri, 15 May 2020 14:57:31 +0000 (UTC)
Received: from krava (unknown [10.40.194.127])
        by smtp.corp.redhat.com (Postfix) with SMTP id BCA7246;
        Fri, 15 May 2020 14:57:27 +0000 (UTC)
Date:   Fri, 15 May 2020 16:57:25 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Wenbo Zhang <ethercflow@gmail.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>, Martin KaFai Lau <kafai@fb.com>,
        David Miller <davem@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        KP Singh <kpsingh@chromium.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Florent Revest <revest@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 8/9] selftests/bpf: Add test for d_path helper
Message-ID: <20200515145725.GA3565839@krava>
References: <20200506132946.2164578-1-jolsa@kernel.org>
 <20200506132946.2164578-9-jolsa@kernel.org>
 <CAEf4Bzbn_m8HUmvkBwK9t3-CkO+gz4SvAvMsO7aUQ49v3skh=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzbn_m8HUmvkBwK9t3-CkO+gz4SvAvMsO7aUQ49v3skh=w@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 14, 2020 at 03:48:20PM -0700, Andrii Nakryiko wrote:
> On Wed, May 6, 2020 at 6:32 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding test for d_path helper which is pretty much
> > copied from Wenbo Zhang's test for bpf_get_fd_path,
> > which never made it in.
> >
> > I've failed so far to compile the test with <linux/fs.h>
> > kernel header, so for now adding 'struct file' with f_path
> > member that has same offset as kernel's file object.
> >
> 
> Switch to using vmlinux.h? It would also be nice to use skeletons
> instead of bpf_object__xxx API.

I just spot it this week when checking for something else.. yep, nice ;-)

thanks,
jirka

> 
> > Original-patch-by: Wenbo Zhang <ethercflow@gmail.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  .../testing/selftests/bpf/prog_tests/d_path.c | 196 ++++++++++++++++++
> >  .../testing/selftests/bpf/progs/test_d_path.c |  71 +++++++
> >  2 files changed, 267 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/d_path.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_d_path.c
> >
> 
> [...]
> 

