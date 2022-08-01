Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1316D586C72
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 15:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbiHAN7I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 09:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiHAN7G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 09:59:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8516E25EB7
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 06:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659362343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eXxFDNHmW1eO0dHBvosAP+F5NsGPg4Gs2jo3HyEeOm4=;
        b=elBnH3m4Mc/5raaQ++OPBqwdsc40LXyyekriiAY3EdthBd7jxOhQrdUkFaNnS8A5EEP9DI
        iWvW+4YxuXSmhy0zV9+xz/IJ4NZK2r8uE5gxLVQB5yOQnRGgugtY7kLXaTfUSfU88RYTz+
        O26RUDniix2HHgO74CWDY+MR8tFxSSc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-1dgpwpuyOc2I88Ul1h64vA-1; Mon, 01 Aug 2022 09:59:02 -0400
X-MC-Unique: 1dgpwpuyOc2I88Ul1h64vA-1
Received: by mail-ej1-f70.google.com with SMTP id hp13-20020a1709073e0d00b0072b812bc5e9so3021607ejc.9
        for <bpf@vger.kernel.org>; Mon, 01 Aug 2022 06:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=eXxFDNHmW1eO0dHBvosAP+F5NsGPg4Gs2jo3HyEeOm4=;
        b=UdDDwbuIHv5aBMsvnHhXEBBxE7THYT/fz+suMVZ4XRZzYyF3YGA4aLP+i21O1SUsCO
         Z2hCAmpA/4V2l5pDH31ffZWI5uqWM8UymX/schLBg6VWen3M2VMOOyH+ByanAhtcpXoW
         /MDw5yzptA8pef8Q5K6lG+AVymejrraOFk5k1wojWVaSTeOlZLna+sv9V0ZOAqRNf8W6
         u3PQqU3IDWAPqrtrV4Tm87cp+0hS19DKqHVIvf2mYuc9RVNpKlkPxqLjMexj6NnHP5MJ
         Loua1s2C23990W5bQhp5TGIOrBJagKLEHO28T37QLv+BsS0T7dg1JwM6KhcFDrapZ2FJ
         LipA==
X-Gm-Message-State: AJIora8HKNN8R/yKEC3YTfK8XIZNjIScqwfcZ8dAPny8fTpdVaKNbpqp
        nTMbwZ2WpcE43JQd9Ys333L5QM3adSQcsxFcA5ko96SNSxahQrSfjFS0EGMGYpGunLufAo8+LjW
        7t+pwmY2ZAyBj3gJ40vrXwXXRbPtW
X-Received: by 2002:a05:6402:428a:b0:42e:8f7e:1638 with SMTP id g10-20020a056402428a00b0042e8f7e1638mr15797061edc.228.1659362341203;
        Mon, 01 Aug 2022 06:59:01 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sOKK1XArDJ/+T2IJ3/pCZ85i2lWKtqCnCIBQNq5wFJM3QRwfxBQ0mImsdCShuk7kTJM73OnyoYE+c/C8XVIdY=
X-Received: by 2002:a05:6402:428a:b0:42e:8f7e:1638 with SMTP id
 g10-20020a056402428a00b0042e8f7e1638mr15797050edc.228.1659362341081; Mon, 01
 Aug 2022 06:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220711083220.2175036-1-asavkov@redhat.com> <YswAqrJrMKIZPpcz@krava>
In-Reply-To: <YswAqrJrMKIZPpcz@krava>
From:   Daniel Vacek <neelx@redhat.com>
Date:   Mon, 1 Aug 2022 15:58:24 +0200
Message-ID: <CACjP9X-HWHhFD6D1TsuhWOgj2v=dMkwVCjQCQzQqa054yKiqeg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/4] bpf_panic() helper
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Artem Savkov <asavkov@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 11, 2022 at 12:51 PM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Mon, Jul 11, 2022 at 10:32:16AM +0200, Artem Savkov wrote:
> > eBPF is often used for kernel debugging, and one of the widely used and
> > powerful debugging techniques is post-mortem debugging with a full memory dump.
> > Triggering a panic at exactly the right moment allows the user to get such a
> > dump and thus a better view at the system's state. This patchset adds
> > bpf_panic() helper to do exactly that.
>
> FWIW I was asked for such helper some time ago from Daniel Vacek, cc-ed

Nice :-)
This is totally welcome. Though, IIRC, I was asking if I could do a
NULL pointer dereference within perf probe (or ftrace) back then.
Still, the outcome is similar. So kudos to Artem.

--nX

> jirka
>
> >
> > I realize that even though there are multiple guards present, a helper like
> > this is contrary to BPF being "safe", so this is sent as RFC to have a
> > discussion on whether adding destructive capabilities is deemed acceptable.
> >
> > Artem Savkov (4):
> >   bpf: add a sysctl to enable destructive bpf helpers
> >   bpf: add BPF_F_DESTRUCTIVE flag for BPF_PROG_LOAD
> >   bpf: add bpf_panic() helper
> >   selftests/bpf: bpf_panic selftest
> >
> >  include/linux/bpf.h                           |   8 +
> >  include/uapi/linux/bpf.h                      |  13 ++
> >  kernel/bpf/core.c                             |   1 +
> >  kernel/bpf/helpers.c                          |  13 ++
> >  kernel/bpf/syscall.c                          |  33 +++-
> >  kernel/bpf/verifier.c                         |   7 +
> >  kernel/trace/bpf_trace.c                      |   2 +
> >  tools/include/uapi/linux/bpf.h                |  13 ++
> >  .../selftests/bpf/prog_tests/bpf_panic.c      | 144 ++++++++++++++++++
> >  9 files changed, 233 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_panic.c
> >
> > --
> > 2.35.3
> >
>

