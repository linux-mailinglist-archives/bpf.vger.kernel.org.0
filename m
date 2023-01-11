Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7798D66560F
	for <lists+bpf@lfdr.de>; Wed, 11 Jan 2023 09:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjAKI2O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Jan 2023 03:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235452AbjAKI14 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Jan 2023 03:27:56 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C11F2017
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 00:27:55 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id bi26-20020a05600c3d9a00b003d3404a89faso2019109wmb.1
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 00:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8H7BYWNK5QGRSV0QzyCVeNegt/4SpqVzk28XaNS779Y=;
        b=JdZNOFUJNywder3CDGRlw0Bqc6gLffj8yH1iMmJmXz7LTLn0ElYkJkLcw4UxPI1i7y
         WiOElNM97+kY5xybgJEx9t0DT7LUwcqljYYq0qy/fZGeTOWu71C57HjAffpbe70k+nZW
         AlTWZsqx7xH8An0PpcWZ7WxmT9fdlxRjCPMMpvjZ0f2zMwqIyKYDXGEbNqUq2/MlxFBo
         e2rU4ompZtn2Ftbgl1DyTG4DR4Q/WZ+tXn5cd2kk1zCn95wLeLCqlLlIVRzhzq+jglgc
         QzdPcN2bCVUqpJM8+rrOVRkxFJraekjdkX1K1mhl94Jmx9fxrQSUaBCFAqs0CT5J9xf0
         UY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8H7BYWNK5QGRSV0QzyCVeNegt/4SpqVzk28XaNS779Y=;
        b=VSmB+C5EsDpl94+GTCeU8GZNHy5fO0fJCwbxK0EM6wvTD6h39/RgERDVed+PiBJN9h
         g31RuSh9bwPRc8RaKU3GoMrvPUlcT2hZPQyavFuzMHbHX0lNYISG0Q4ilCbp/1TNZGNv
         +LHh+C9+O59A0wQPDMRx0vn8EIQX5mnF5PfSyQ99MlghDPf/XIVhEpmC5odv7oq4bWKP
         ITryOz0i5BTCRug1s7DY9GY/oh38Pt8HjY3rqnQuQFXzGjeWZ2mv33bxKB9tvepst030
         yQr1vURgtwD44gxkBB9BN9vhCANIjv2pfBk5PNyAu7KQ6m5oFr3yi4l/sx2H+mG7Ke09
         amcA==
X-Gm-Message-State: AFqh2kp7iI8akKhSyDBBJMEpEwxRjSZCZdUokOwyUXD/YdgzDdujNDNz
        kiowGlO4nUNsP4+lV5+NTBs=
X-Google-Smtp-Source: AMrXdXvuF4D0+RfBEqVx5PzCGllxosvXNT9QLwYCwbScZUM3jRoZMTDkzSQA16ESSOZ4PUW4fGGrqg==
X-Received: by 2002:a1c:6a16:0:b0:3c6:f732:bf6f with SMTP id f22-20020a1c6a16000000b003c6f732bf6fmr51200025wmc.13.1673425673475;
        Wed, 11 Jan 2023 00:27:53 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id u21-20020a7bc055000000b003d9aa76dc6asm26023905wmc.0.2023.01.11.00.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 00:27:52 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 11 Jan 2023 09:27:50 +0100
To:     andrea terzolo <andreaterzolo3@gmail.com>
Cc:     bpf@vger.kernel.org, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [QUESTION] usage of BPF_MAP_TYPE_RINGBUF
Message-ID: <Y75zBpkr1tLXKMWX@krava>
References: <CAGQdkDvVW1QhPdjOS_8yDidZA3qyW8O-H3Seb7RZHU34GGrmiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGQdkDvVW1QhPdjOS_8yDidZA3qyW8O-H3Seb7RZHU34GGrmiA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 10, 2023 at 02:49:59PM +0100, andrea terzolo wrote:
> Hello!
> 
> If I can I would ask a question regarding the BPF_MAP_TYPE_RINGBUF
> map. Looking at the kernel implementation [0] it seems that data pages
> are mapped 2 times to have a more efficient and simpler
> implementation. This seems to be a ring buffer peculiarity, the perf
> buffer didn't have such an implementation. In the Falco project [1] we
> use huge per-CPU buffers to collect almost all the syscalls that the
> system throws and the default size of each buffer is 8 MB. This means
> that using the ring buffer approach on a system with 128 CPUs, we will
> have (128*8*2) MB, while with the perf buffer only (128*8) MB. The

hum IIUC it's not allocated twice but pages are just mapped twice,
to cope with wrap around samples, described in git log:

    One interesting implementation bit, that significantly simplifies (and thus
    speeds up as well) implementation of both producers and consumers is how data
    area is mapped twice contiguously back-to-back in the virtual memory. This
    allows to not take any special measures for samples that have to wrap around
    at the end of the circular buffer data area, because the next page after the
    last data page would be first data page again, and thus the sample will still
    appear completely contiguous in virtual memory. See comment and a simple ASCII
    diagram showing this visually in bpf_ringbuf_area_alloc().

> issue is that this memory requirement could be too much for some
> systems and also in Kubernetes environments where there are strict
> resource limits... Our actual workaround is to use ring buffers shared
> between more than one CPU with a BPF_MAP_TYPE_ARRAY_OF_MAPS, so for
> example we allocate a ring buffer for each CPU pair. Unfortunately,
> this solution has a price since we increase the contention on the ring
> buffers and as highlighted here [2], the presence of multiple
> competing writers on the same buffer could become a real bottleneck...
> Sorry for the long introduction, my question here is, are there any
> other approaches to manage such a scenario? Will there be a
> possibility to use the ring buffer without the kernel double mapping
> in the near future? The ring buffer has such amazing features with
> respect to the perf buffer, but in a scenario like the Falco one,
> where we have aggressive multiple producers, this double mapping could
> become a limitation.

AFAIK the bpf ring buffer can be used across cpus, so you don't need
to have extra copy for each cpu if you don't really want to

jirka

> 
> Thank you in advance for your time,
> Andrea
> 
> 0: https://github.com/torvalds/linux/blob/master/kernel/bpf/ringbuf.c#L107
> 1: https://github.com/falcosecurity/falco
> 2: https://patchwork.ozlabs.org/project/netdev/patch/20200529075424.3139988-5-andriin@fb.com/
