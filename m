Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAE32B4B92
	for <lists+bpf@lfdr.de>; Mon, 16 Nov 2020 17:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732261AbgKPQpc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Nov 2020 11:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731586AbgKPQpc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Nov 2020 11:45:32 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8F8C0613D1
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2020 08:45:32 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id e21so13697435pgr.11
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2020 08:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o7khu+y1k6F3Cwh3naL/BSozOiSx1uzR1Zxg1hKkEHw=;
        b=yVxS7tFMUDDF2hAntmnfBCptEWqhaOicCid80+SdhHYkm679t9Ix0cTQmD9INU6DI6
         ED0v/XT8QNxkOW4cwxQfJ+Yzb9lGAQHRRnw0zkI2fxA751cyNJ88mw8xWJltU07NFlEQ
         8UIsh+jQu/s4zFmuUd30XLvqTrqonBBvsYx9Fyzmq1qgm2cmWbbXvqob/6b4B5E/Rkio
         fJcCCOBNKPkBv62AgktBUMNByOgUiJhf4Hj20qfMdxtWHhaySGhm4nZfwPHggJoYPE6J
         K69wEhlSxEuvWV4QkbqVyxGmAehmkB5Rc6Jjo6ct3nOpKLwEFT4BGWcjQ+qq1i45j/vj
         crRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o7khu+y1k6F3Cwh3naL/BSozOiSx1uzR1Zxg1hKkEHw=;
        b=EsuISgc69YOZFvpVZa9ZjKcOF9Bvv5C0+429BbDmMVkUILFyfn9xSttEby/yZ6aQ5f
         04krqtNEfTg3OFOO+Bb4tuF1i4emllFa8yirMIVJighskWb4BNs6/Hm/z2eimIQFvWfZ
         Pnn/rr0DZtH1inE3jDN7DFQEg+lRVacXemO0gzT3XnSyRpzantaNY7paUl8wFAAd8Cju
         VhOfc/M6AqaMDq+hpVeyFaZVSNWnBNNiIgzYEb1rZcLvGx9QhpU2PN1y30nInrx8z2ph
         R+v/JX6H9iJ5RZkIvKUu2GCGfjOA+DxBEXfNeVU6UYqSsGVSQO5cjQ7LeIsuCdjLAldg
         k+GQ==
X-Gm-Message-State: AOAM532gnO66uzXF884BBKgfJCuohxn728B3kFQ0OEJlfRLSjAD5GMj1
        NqYhK53zvLVDVtjPgMEiyd+ctA==
X-Google-Smtp-Source: ABdhPJwRszpyHCKExvAKPr/qsD/ZMfQPI7cBSkbDUH/bASi7IjeTgiJDQu2rroAgdCM8ws+0u61tPw==
X-Received: by 2002:a63:6ecb:: with SMTP id j194mr101099pgc.420.1605545131625;
        Mon, 16 Nov 2020 08:45:31 -0800 (PST)
Received: from hermes.local (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id z21sm18402236pfa.158.2020.11.16.08.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 08:45:31 -0800 (PST)
Date:   Mon, 16 Nov 2020 08:45:22 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Hangbin Liu <haliu@redhat.com>, David Ahern <dsahern@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        David Miller <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Jiri Benc <jbenc@redhat.com>,
        Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Subject: Re: [PATCHv5 iproute2-next 0/5] iproute2: add libbpf support
Message-ID: <20201116084522.5b315106@hermes.local>
In-Reply-To: <CAADnVQ+LNBYq5fdTSRUPy2ZexTdCcB6ErNH_T=r9bJ807UT=pQ@mail.gmail.com>
References: <20201109070802.3638167-1-haliu@redhat.com>
        <20201116065305.1010651-1-haliu@redhat.com>
        <CAADnVQ+LNBYq5fdTSRUPy2ZexTdCcB6ErNH_T=r9bJ807UT=pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 15 Nov 2020 23:19:26 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Sun, Nov 15, 2020 at 10:56 PM Hangbin Liu <haliu@redhat.com> wrote:
> >
> > This series converts iproute2 to use libbpf for loading and attaching
> > BPF programs when it is available. This means that iproute2 will
> > correctly process BTF information and support the new-style BTF-defined
> > maps, while keeping compatibility with the old internal map definition
> > syntax.
> >
> > This is achieved by checking for libbpf at './configure' time, and using
> > it if available. By default the system libbpf will be used, but static
> > linking against a custom libbpf version can be achieved by passing
> > LIBBPF_DIR to configure. LIBBPF_FORCE can be set to on to force configure
> > abort if no suitable libbpf is found (useful for automatic packaging
> > that wants to enforce the dependency), or set off to disable libbpf check
> > and build iproute2 with legacy bpf.
> >
> > The old iproute2 bpf code is kept and will be used if no suitable libbpf
> > is available. When using libbpf, wrapper code ensures that iproute2 will
> > still understand the old map definition format, including populating
> > map-in-map and tail call maps before load.
> >
> > The examples in bpf/examples are kept, and a separate set of examples
> > are added with BTF-based map definitions for those examples where this
> > is possible (libbpf doesn't currently support declaratively populating
> > tail call maps).
> >
> > At last, Thanks a lot for Toke's help on this patch set.
> >
> > v5:
> > a) Fix LIBBPF_DIR typo and description, use libbpf DESTDIR as LIBBPF_DIR
> >    dest.
> > b) Fix bpf_prog_load_dev typo.
> > c) rebase to latest iproute2-next.  
> 
> For the reasons explained multiple times earlier:
> Nacked-by: Alexei Starovoitov <ast@kernel.org>

Could you propose a trial balloon patch to show what you would like to see in iproute2?
