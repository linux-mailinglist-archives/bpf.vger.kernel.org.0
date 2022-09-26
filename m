Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9A55EB2F8
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 23:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiIZVSn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 17:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiIZVSm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 17:18:42 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA59C9258D
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 14:18:41 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id c11so12085228wrp.11
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 14:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=9WNHl/J7CDcN3AJJwxysC1X1MJGVamy/d3xDM62RZCM=;
        b=iTfWWXsyoyyFkYlrrS7DICAuYfRfeOlVw8+wXgtFjgus7YmmaIvPk5+2Om+rsthySy
         jPgIA8nlnEoA2CX+LB72k1qEtvUHFqPnajLEWpikagbcDB6RJq63MQjHJpl7/D6W7oMj
         byu+1gqXOuC84bqGg6msDILqouBcywWNVXqAilxBVv6HXpyFDliqYg4GfO7tMe7Oa+nc
         FBiCF2CzM6jHb3zzy0GskAy8L2JZpxirBUNuaettizqYM4dTr8OLj2ODl1phIEiuvivI
         REFOHHGvXjGsvaMBAsHwLNifhFpOnjOWGaFEQcvRf4V2QU/BpUC1zoByiTriys2BMyIv
         PtSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=9WNHl/J7CDcN3AJJwxysC1X1MJGVamy/d3xDM62RZCM=;
        b=KaqixUhwPx8t+GX1WyDbkz1lVedGZWBi6IaI0GkOUrDx9BU66RpfNnilHyMiCmQ9xG
         7LkI45b+TXs3M+bLucjG03JZ0DsewT8+sgF4/u8fHD5SNkNva+7Y2M82SDEjbC98dfkU
         UIeAqDlEZ6IPAoeAv8ftWWd3/cwe9R4OuCacecX0Urmj2+vexJoMXPUMUrKkNljSuSe2
         kECtNHxzr8vIejhCNc+GQT7Q6GkHlLWx1qoTjVmtkEBH28C2iMarlKLKKA9nOtWE+09b
         hO95BvkEvIneIZ2hKtziQooZ06+zzcyYit2dvREKzvmTGwlCLLQL+tpTH5sYgMgThM8s
         Ao2A==
X-Gm-Message-State: ACrzQf2m552J/C8w45/kTV28Yg5JeHuP2aoAmKjJgs5AagmtnTjqILps
        xP2oBGjNKKSg8iyAJBAjkeqiW7qh2XpAgqKjONKxwA==
X-Google-Smtp-Source: AMsMyM7ys6VghKlHdebcfATYHg8zk6mLZSBwge5OwAV4zZVj917EVOTd7EZ+yHh3MlixALlmhNs59ALc31r/PsJiqsA=
X-Received: by 2002:a5d:5611:0:b0:228:e1d2:81d with SMTP id
 l17-20020a5d5611000000b00228e1d2081dmr15061344wrv.210.1664227120149; Mon, 26
 Sep 2022 14:18:40 -0700 (PDT)
MIME-Version: 1.0
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 26 Sep 2022 14:18:04 -0700
Message-ID: <CAJD7tkZkY9nfaVDmjzhDG4zzezNn7bXnGrK+kpn0zQFwPhdorw@mail.gmail.com>
Subject: Question about ktime_get_mono_fast_ns() non-monotonic behavior
To:     John Stultz <jstultz@google.com>, tglx@linutronix.de,
        sboyd@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Hao Luo <haoluo@google.com>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hey everyone,

I have a question about ktime_get_mono_fast_ns(), which is used by the
BPF helper bpf_ktime_get_ns() among other use cases. The comment above
this function specifies that there are cases where the observed clock
would not be monotonic.

I had 2 beginner questions:

1) Is there a (rough) bound as to how much the clock can go backwards?
My understanding is that it is bounded by (slope update * delta), but
I don't know what's the bound of either of those (if any).

2) The comment specifies that for a single cpu, the only way for this
behavior to happen is when observing the time in the context of an NMI
that happens during an update.
For observations across different cpus, are the scenarios where the
non-monotonic behavior happens also tied to observing time within NMI
contexts? or is it something that can happen outside of NMI contexts
as well?

Thanks in advance! (and please excuse any dumb/obvious questions :) )
