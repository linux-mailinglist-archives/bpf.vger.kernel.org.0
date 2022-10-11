Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E6C5FB9BF
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 19:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiJKRgz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Oct 2022 13:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiJKRgg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Oct 2022 13:36:36 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97681DAD
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 10:34:36 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id w18so22720904wro.7
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 10:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WuO9Fb816Vy8uVLyDzep/0aqImYubOKw3e2ZsyFbmAE=;
        b=Wdmc4NJdmMQkOGy71g1/3+3oCDzlfEpuHu2CgXF51DmeK2s1WSEd6j4mmAeWt7WWdz
         OcNQbWswzkgEu4Af9cQhvwuufSZQZqViR19qKpShT6u5j/o/6RSM0ztct9alxa5EQ9TA
         EzH0iT0RkS/BfeNGHdaFFbhCdKf7pC6fl1ydLpL982lGvrYwhZctvI66H0ik66t8I9W4
         8axma+z4EGXEc37kPg+mppIstf+cWfpda388gP5Mi7AsEtU71bVlK0Bq6dDeXsvuh8hn
         uAhd8hXPAi6m5kYec1HLhsEFBwAHJSNpH630/msxxFYnz9Dk6abe0nGw6zC/OawS2GQ1
         9bTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WuO9Fb816Vy8uVLyDzep/0aqImYubOKw3e2ZsyFbmAE=;
        b=5tIuEmA3qWA5/rsntjyzuS3YxqMFgy+46w79cBNCQN3kcSlXbbVzO1q2XSU4nTmvVb
         qDRhKk5jRiX9mtnvgjMOzbl2AQkWwNOdobqiIkp2cV5MPBSrTRjwu7ls/EjOEMEzW2m/
         uu9WMZ4FPSS0F84VAlMHD0XmMhu/0SwSGVAHnoD4NbiLWBLRNIXEDp6R0xRbv5RjBHBH
         ok+jfvC3vhyRRC3hjxrUk7SKGfCTBDLApDeI2KVM1VGfI3BeRjjG7XKmX++I1WJl9f9i
         Ci0gXLFan8Ky/c/KMKrCkr8hhqJ02gmSCYRTIpdYBiqc45m9IbtuBHMOJbhDc9CokrcP
         CxcQ==
X-Gm-Message-State: ACrzQf3kain/ix779mz4AN/ghFMnKsPnLkv9npi9Qv8PfjFjF5ajfP8S
        EGKmAV1YRcxq+LPlr4agywG/X9G2636coLXPiuBDMr+xAb4=
X-Google-Smtp-Source: AMsMyM75W4Wx1zA2bO2IGKlwaRypsso3UgjbCNV6fbBqtmkN76CPDIZaro0ja1BNk45PoojYa6G+Va+FdNLLS5LZrs8=
X-Received: by 2002:a5d:6741:0:b0:22e:2c5c:d611 with SMTP id
 l1-20020a5d6741000000b0022e2c5cd611mr16036204wrw.210.1665509675038; Tue, 11
 Oct 2022 10:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkZkY9nfaVDmjzhDG4zzezNn7bXnGrK+kpn0zQFwPhdorw@mail.gmail.com>
In-Reply-To: <CAJD7tkZkY9nfaVDmjzhDG4zzezNn7bXnGrK+kpn0zQFwPhdorw@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 11 Oct 2022 10:33:58 -0700
Message-ID: <CAJD7tkYOs4LKa=j+xNRMRiK=ors7_uCBtAjp6axRNQo0NHQqWA@mail.gmail.com>
Subject: Re: Question about ktime_get_mono_fast_ns() non-monotonic behavior
To:     John Stultz <jstultz@google.com>, tglx@linutronix.de,
        sboyd@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Hao Luo <haoluo@google.com>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 26, 2022 at 2:18 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> Hey everyone,
>
> I have a question about ktime_get_mono_fast_ns(), which is used by the
> BPF helper bpf_ktime_get_ns() among other use cases. The comment above
> this function specifies that there are cases where the observed clock
> would not be monotonic.
>
> I had 2 beginner questions:
>
> 1) Is there a (rough) bound as to how much the clock can go backwards?
> My understanding is that it is bounded by (slope update * delta), but
> I don't know what's the bound of either of those (if any).
>
> 2) The comment specifies that for a single cpu, the only way for this
> behavior to happen is when observing the time in the context of an NMI
> that happens during an update.
> For observations across different cpus, are the scenarios where the
> non-monotonic behavior happens also tied to observing time within NMI
> contexts? or is it something that can happen outside of NMI contexts
> as well?
>
> Thanks in advance! (and please excuse any dumb/obvious questions :) )

Anyone can help me with this? :)
