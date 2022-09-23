Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC8B5E8637
	for <lists+bpf@lfdr.de>; Sat, 24 Sep 2022 01:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbiIWXMO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Sep 2022 19:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbiIWXMN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 19:12:13 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C6412CCAA
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 16:12:12 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id 13so3586422ejn.3
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 16:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=hsgpX7kWmfrOIyvO5+hzt6Anorh6wyVvqt2nvD3iyGs=;
        b=Wzqjav6rx03LhCoEVMf4FzGQ/th2NrtIII4IqV2/krta3ubirUMdZ/F+fidzYhfb7w
         UF+PUedNau7vBPx1+MpXEDn6EiCsRF1dgGPSJDIy/vLZsC6EkXwPynQMveeKgMigT2kc
         jPogJpzxEdJ3wq7wKb0VCEol/tjZRrZhQrxJ2+wb1kbAU9UKjNMtgR9xW57SgP21nmfk
         dsEEetyoe57+jDWaaXb8zzMFeQ0+yGXSgEEJfzB7xGeefF9MFcO2esyzDQ9SWqqho3Q3
         MZzj7wTc23Zgn7ZxS1l4hqk4IWCm5GZGP+xX3y6TKxxYWyLurTf1eqYijCcyhUHtnJzt
         8yDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hsgpX7kWmfrOIyvO5+hzt6Anorh6wyVvqt2nvD3iyGs=;
        b=dlgRPSWpWkpvUqQaQxMDiqphARkZTOPooYtBVmvMI5Li3ftSZ5DAlG0Z0XHL1Ucw6l
         +VOX3kndoL+2EXgCXR3T7xQKk4MmwDTyUABTllzh5m4JUlupVEEo99+egGskr1RmeSUg
         y7JG84H1jCyIuSPJ+QxpbvlfZS6u51b8mk4Rzojv4kz2WUQ5gRl6/kLwptAo7wUFnLMJ
         vIQloZ6kH8ej3qMqhB9kDGZ/g4Yq5GEiC2zcoB2DhCsNARiCjc9UBmfHl8fEfR1KMGkX
         wYYwe0bVZE7t1TuWS3DaIg4YYY0Sl81g6tTST6ACU3+srT6QC5Lsdnd2CrnWnhNi5tKt
         GbSQ==
X-Gm-Message-State: ACrzQf0ZynahD1QKO3ucPI68Bw8uuUjnU5kDd0S2ytR/qhjn9DrZxd5M
        7WUg3VwzbLzIgOX+xl5CCv3M3Zk1WU3jRKPnKEE=
X-Google-Smtp-Source: AMsMyM480lJB8wImq7xmLcM65O1RrtC+6ufwSnbf2slQSJaTnik3na339IJ2A+ez4Kz/dZQdxE08JhfYY5DYTXXK74k=
X-Received: by 2002:a17:906:99c5:b0:73d:70c5:1a4f with SMTP id
 s5-20020a17090699c500b0073d70c51a4fmr8744134ejn.302.1663974730494; Fri, 23
 Sep 2022 16:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAO658oWgicsACo3DUripSBkU6_bjJCScMUHKqLww7O+xY8CiUw@mail.gmail.com>
 <CAEf4BzaMNWySHvbPWa-yU5DPL0zu+kMr29iRUTkmPLciKyGGew@mail.gmail.com>
In-Reply-To: <CAEf4BzaMNWySHvbPWa-yU5DPL0zu+kMr29iRUTkmPLciKyGGew@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 23 Sep 2022 16:11:59 -0700
Message-ID: <CAEf4Bza6V+W8=eTcVZYj5+KtN9Suvqxt6j8Nr4sEAYnLE7HB6g@mail.gmail.com>
Subject: Re: Interesting data corruption in bpf_object_open_opts
To:     Grant Seltzer Richman <grantseltzer@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 23, 2022 at 3:24 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Sep 13, 2022 at 6:23 PM Grant Seltzer Richman
> <grantseltzer@gmail.com> wrote:
> >
> > Hi all, I'm experiencing an issue that I want to discuss, though I'm
> > not sure libbpf code is at fault. Any guidance is much appreciated.
> >
> > The behavior I'm seeing is that I have a `struct bpf_object_open_opts`
> > where I properly set each of the `btf_custom_path` and `kconfig`
> > fields. I then call `bpf_object__open_mem` with this opts struct and
> > get this error:
> >
> > libbpf: failed to get EHDR from /proc/config.gz
> >
> > The very important thing to note here is that I'm setting the fields
> > and calling bpf_object__open_mem from Go code using CGO (this is in
> > libbpfgo). I do believe it's likely to be a CGO issue and not libbpf
> > itself, but here's why:
> >
> > I've `git bisect`'ed the issue to be caused by commit `d8454ba8`,
> > which leads me to believe that CGO is failing to adjust offsets for
> > whatever having `long :0` in bpf_object_open_opts does. I can't figure
> > out why this was added, what exactly does that do? Is it some type of
> > added padding? Is it possible this isn't CGO?
>
> Yes, the intent was to have a hole between pin_root_path and kconfig.
> But this is a bug, my commit actually changed the layout of
> bpf_object_open_opts, unintentionally, because if long: 0 is already
> at long-aligned offset (which it is in this case) it does nothing,
> instead of shifting next field to next long-aligned offset. So
> bpf_object_open_opts is basically broken in libbpf 1.0. Thanks for the
> report! I'll send a fix shortly and we'll need to release 1.0.1 bug
> fix release.
>

Ok, so this should be fixed in [0]. But also note that technically you
are required to recompile with libbpf 1.0 header if you are linking
against libbpf.so.1. In your case it appears as your headers and
actual .so library was from 0.x and 1.x. So check that as well.

  [0] https://patchwork.kernel.org/project/netdevbpf/patch/20220923230559.666608-1-andrii@kernel.org/

> >
> > Thanks for any help,
> > Grant
