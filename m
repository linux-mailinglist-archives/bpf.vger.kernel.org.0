Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E151224A035
	for <lists+bpf@lfdr.de>; Wed, 19 Aug 2020 15:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgHSNhf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Aug 2020 09:37:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39484 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726752AbgHSNhN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 19 Aug 2020 09:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597844232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3swU3G3REsk/4j7W3UAOwoicLgUT67RtsE9XtgsJKQo=;
        b=E9FqaqJuGjJHs980fdT7PqJeF3GJ9krPVQnE8Dy/rqioEMIw5eQStOXF76wRgWAzrBsU0N
        gbIids0bXyQXpN9vZQmr+1Qa2E+uj3jeIjyvcrPBm3RCCKE06fLXMz6GTEVP9uhYdbqshF
        y2qNWDK+rokawQ4vZI66tiU/7m61vMA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-SThYVKtjNnKv5tpEDzvNpA-1; Wed, 19 Aug 2020 09:37:08 -0400
X-MC-Unique: SThYVKtjNnKv5tpEDzvNpA-1
Received: by mail-wr1-f69.google.com with SMTP id j2so9407835wrr.14
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2020 06:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3swU3G3REsk/4j7W3UAOwoicLgUT67RtsE9XtgsJKQo=;
        b=PMR76zf/+kYW6tNW2ek8601wlf8OO9eUEgcfB1SrMVGDHvpsV63d+3g7KTN7oo0+ar
         yNI1zuYV5Bqmqn/FLfWBIq6fq8GpZbOGNDgjbO8jGeCLx8xST9iCoSBup8nN9Js6qKlb
         861kdv+wQ0WPTOb5b97tS64fD1k6LLbreedBcRmytMqKztkk5ZwCIoOS+jXzbcICCxqc
         R9zepNKZm57ZOZoEkw2t2CB9CdsSJeSp9hBj37sRoZlyOymOds7gHHhuynw/WHtlDCha
         M/7c8XwUFcYA2BFvimmzq3bfMjxFhWUhH1BgdmA0hRkeglkW/+S37GRuBkVcfNEmi1Wd
         UNqQ==
X-Gm-Message-State: AOAM532jr7FYTiblAiz3fhSCVXlZ2d8tLQ6kNkco3TRpHLhdoM7hOMP5
        o/YcdlVBSuJzb19mAq0BEjuw4ryNWfATBSr0R69/JJnvR3MVphEq5sArCC5ogaFKVrzKeitGpwl
        bU54sqvfnZ5wmZqa9WUXhOIcc23Gb
X-Received: by 2002:adf:a35e:: with SMTP id d30mr26679446wrb.53.1597844227144;
        Wed, 19 Aug 2020 06:37:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwt8d00V9H+4LaXvcbBLODGfCF5gtkJI7mPTV8DbSV9pJS9zkxsQy4WoHWbyfHkDdNPiEotTBcyGfSOcb7PSCQ=
X-Received: by 2002:adf:a35e:: with SMTP id d30mr26679422wrb.53.1597844226927;
 Wed, 19 Aug 2020 06:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200819023427.267182-1-yauheni.kaliuta@redhat.com>
 <66d63f42-ce71-446a-7ee2-586ffcea160d@fb.com> <CANoWswmccdLu4mCj48iVH1_Od4zZ=BdgCHZ0CMyieYQ9WxoHPA@mail.gmail.com>
In-Reply-To: <CANoWswmccdLu4mCj48iVH1_Od4zZ=BdgCHZ0CMyieYQ9WxoHPA@mail.gmail.com>
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Date:   Wed, 19 Aug 2020 16:36:50 +0300
Message-ID: <CANoWswnePFEeyYgJ95x8MgAnffyjfESwtf6f7G8pFvBGmh8Qeg@mail.gmail.com>
Subject: Re: [PATCH] bpf: selftests: global_funcs: check err_str before strstr
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 19, 2020 at 10:05 AM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> On Wed, Aug 19, 2020 at 8:19 AM Yonghong Song <yhs@fb.com> wrote:
> >
> >
> >
> > On 8/18/20 7:34 PM, Yauheni Kaliuta wrote:
> > > The error path in libbpf.c:load_program() has calls to pr_warn()
> > > which ends up for global_funcs tests to
> > > test_global_funcs.c:libbpf_debug_print().
> > >
> > > For the tests with no struct test_def::err_str initialized with a
> > > string, it causes call of strstr() with NULL as the second argument
> > > and it segfaults.
> > >
> > > Fix it by calling strstr() only for non-NULL err_str.
> > >
> > > The patch does not fix the test itself.
> >
> > So this happens in older kernel, right? Could you clarify more
> > in which kernel and what environment? It probably no need to
> > fix the issue for really old kernel but some clarification
> > will be good.
>
> I'll test it with the very recent kernel on that architecture soon,
> for sure. But it's not related to the patch.

./test_progs -t global_func still fails for me on s390 with
18445bf405cb331117bc98427b1ba6f12418ad17

