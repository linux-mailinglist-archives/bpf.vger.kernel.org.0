Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44715E85DB
	for <lists+bpf@lfdr.de>; Sat, 24 Sep 2022 00:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbiIWWZB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Sep 2022 18:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbiIWWZA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 18:25:00 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28512B195
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 15:24:57 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id z13so3400155ejp.6
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 15:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=qmVDg6A0N81/7iCKY+RRgmqln1tMG5pJfnGY7finnE8=;
        b=gmthGHoj8qsVdo8OhAxmkyJEVNJ/oWIOE6y+vbfIdKaLhqaO+PgdT/uqL8DbfZy6qN
         sPvAttLNY6AtjR8dGy1kHP9184rxOTlMJ/oL1VUCbOB+uoWvTOGgsml+HOU/89nXbrzc
         fr7N5ZNg3VEfqDSGekV5zrvv2W7naL621rw/By0fr3l/NSKnM21mn3agGEw4ME9LAoYA
         Uhqrv55zWVOtxrXel1F0vPwtAk1+biD19BBqktVp20Ir5EcOZBemd0cV70TjNWPDUenH
         W21BUA4b22z25BW8vUw6EuHrU9ZaQIF3Fuoh53/zD3+9+Xq+H3/jb1B6EoVHH18GSQOP
         5RgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=qmVDg6A0N81/7iCKY+RRgmqln1tMG5pJfnGY7finnE8=;
        b=Gxoni7VbCTjuKuYgqrY+8LI4+nBjVYbFq0LWZ+yUQN6hkepx1i4yz5eLaNBm8D26jG
         jAbXpjelg1wwn8sY/GdXU7JBsbjUnXkakZYVQJHvI9t3jpb36LOwy2+00vI0eg9tXhvQ
         cicQomUP3GjMFQtey8UA5hRwdHhK1/Xfdo49DhGUvFo/6gIPDoVip93yUTI9ui1OvSBV
         S5aqLZ5Pt6P+MDKfwJHItiDdFc1dTP94ZJFlmsN4LNvvi0cI8C/RKEawR8ycQ84hXhQy
         XzBBmg/cyKn985Ykoyr4lgVNZsu638aLAI/RDCzAZBOFQ+9iUqNZsqnnGCkqOWSOT+YO
         L1Dw==
X-Gm-Message-State: ACrzQf3gMkmFn/7CEXbzIkBmC1NGPyEVpkqS5dZ4D+i8nSEYGkReNNgj
        yUKVn7ZaRJw7R8LuDDelMIKMVxPRqA423aqTAyw=
X-Google-Smtp-Source: AMsMyM4BSbFrQsfXbG3m15vt3IAxDSgjg7/J/uM3YtfghzFXxI3BS/bgBDBwAN4yU0Aw4uzRZkGi8aRzmqNE5QmdSu0=
X-Received: by 2002:a17:906:99c5:b0:73d:70c5:1a4f with SMTP id
 s5-20020a17090699c500b0073d70c51a4fmr8620594ejn.302.1663971896254; Fri, 23
 Sep 2022 15:24:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAO658oWgicsACo3DUripSBkU6_bjJCScMUHKqLww7O+xY8CiUw@mail.gmail.com>
In-Reply-To: <CAO658oWgicsACo3DUripSBkU6_bjJCScMUHKqLww7O+xY8CiUw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 23 Sep 2022 15:24:44 -0700
Message-ID: <CAEf4BzaMNWySHvbPWa-yU5DPL0zu+kMr29iRUTkmPLciKyGGew@mail.gmail.com>
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

On Tue, Sep 13, 2022 at 6:23 PM Grant Seltzer Richman
<grantseltzer@gmail.com> wrote:
>
> Hi all, I'm experiencing an issue that I want to discuss, though I'm
> not sure libbpf code is at fault. Any guidance is much appreciated.
>
> The behavior I'm seeing is that I have a `struct bpf_object_open_opts`
> where I properly set each of the `btf_custom_path` and `kconfig`
> fields. I then call `bpf_object__open_mem` with this opts struct and
> get this error:
>
> libbpf: failed to get EHDR from /proc/config.gz
>
> The very important thing to note here is that I'm setting the fields
> and calling bpf_object__open_mem from Go code using CGO (this is in
> libbpfgo). I do believe it's likely to be a CGO issue and not libbpf
> itself, but here's why:
>
> I've `git bisect`'ed the issue to be caused by commit `d8454ba8`,
> which leads me to believe that CGO is failing to adjust offsets for
> whatever having `long :0` in bpf_object_open_opts does. I can't figure
> out why this was added, what exactly does that do? Is it some type of
> added padding? Is it possible this isn't CGO?

Yes, the intent was to have a hole between pin_root_path and kconfig.
But this is a bug, my commit actually changed the layout of
bpf_object_open_opts, unintentionally, because if long: 0 is already
at long-aligned offset (which it is in this case) it does nothing,
instead of shifting next field to next long-aligned offset. So
bpf_object_open_opts is basically broken in libbpf 1.0. Thanks for the
report! I'll send a fix shortly and we'll need to release 1.0.1 bug
fix release.

>
> Thanks for any help,
> Grant
