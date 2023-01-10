Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7536F664247
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 14:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbjAJNuQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Jan 2023 08:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237872AbjAJNuO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Jan 2023 08:50:14 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A8C7CDD2
        for <bpf@vger.kernel.org>; Tue, 10 Jan 2023 05:50:12 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id ud5so28786142ejc.4
        for <bpf@vger.kernel.org>; Tue, 10 Jan 2023 05:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OZD8UAkVKab4A2fsnZbsrWl0c6JkB55VJbmiK1XqNn8=;
        b=pU8ifWr6fdTRwRUbSksP3T2Rsgr/FmCMSy7cvMNUkY/vJKgQBprYC4tbeatPXpvnO+
         3ED1ROLv1Ik+P2SGAg/hFhd7he4cKTjAdKcWF94PHGs15eHGfqTGgYP52m2tVsa8U7wV
         iUEsVtPV5xZECVG2t+QSl/Phf3Ti2kPb7HAbLuQVllLyerbxwUlpGNCkOamAVcmCyJGW
         +TzfmWa56BUwl01BNEFIIoZLlsEModE2oRog1jr0XnBTtG8iEURWufByXM8cHOuM9OKa
         7ni2tFHgWeaiR+mjiLRmJ2yvnZ4v0xcxwKASrjD3NRBrxGcRuf/8DiDK5epaMctu/kSb
         YAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OZD8UAkVKab4A2fsnZbsrWl0c6JkB55VJbmiK1XqNn8=;
        b=jM0YSm883fo4XDtehlpidB8gv1tfapQqU13exHxyPYfR7s/YGeozxPSdn7rL4cUumG
         6o7wD79txtbw4VOOPI64LgDUQ9jhistn04SyZOW+Ep6QyMU/sazNBeg7q3ohKuZcTeFx
         7F3yMUj3QtVzM/8xMthEo2SqBGKDGNLy2GGJPlQsCSukENcp0YiKYwLQmVWSM1cHpvsX
         yDM+M/R9F/+jxoVPg8FauqAJtxmdr93Y+dNF/e1Qms966vbCQnmZa8UD5wF32vdhFjuR
         sdp8qR7RjD650E2NksyTv5S/IdldkhKL35ffLk3PiSRjbw+31onfBPvUmEl0ZPv5BOGC
         bpKA==
X-Gm-Message-State: AFqh2kpbNxbylKTUXef+UDE3KnnN/StBA9i0/gypYTLtUGTuR1429ADp
        /7Y9CW8yfnd75aRm4G0UO1pK6EWcgOZNaYPrl/MMp6OOoVktwQ==
X-Google-Smtp-Source: AMrXdXuHJVHp//OgzvW4G4yNcVYRpJnMCQorg1LBmn7mR3JsN9zwD+a9ihPSuGn1mEbET8C+OCzsketVYZrrcJo8dh8=
X-Received: by 2002:a17:906:39cd:b0:7c0:deb6:e13c with SMTP id
 i13-20020a17090639cd00b007c0deb6e13cmr5005936eje.457.1673358610793; Tue, 10
 Jan 2023 05:50:10 -0800 (PST)
MIME-Version: 1.0
From:   andrea terzolo <andreaterzolo3@gmail.com>
Date:   Tue, 10 Jan 2023 14:49:59 +0100
Message-ID: <CAGQdkDvVW1QhPdjOS_8yDidZA3qyW8O-H3Seb7RZHU34GGrmiA@mail.gmail.com>
Subject: [QUESTION] usage of BPF_MAP_TYPE_RINGBUF
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello!

If I can I would ask a question regarding the BPF_MAP_TYPE_RINGBUF
map. Looking at the kernel implementation [0] it seems that data pages
are mapped 2 times to have a more efficient and simpler
implementation. This seems to be a ring buffer peculiarity, the perf
buffer didn't have such an implementation. In the Falco project [1] we
use huge per-CPU buffers to collect almost all the syscalls that the
system throws and the default size of each buffer is 8 MB. This means
that using the ring buffer approach on a system with 128 CPUs, we will
have (128*8*2) MB, while with the perf buffer only (128*8) MB. The
issue is that this memory requirement could be too much for some
systems and also in Kubernetes environments where there are strict
resource limits... Our actual workaround is to use ring buffers shared
between more than one CPU with a BPF_MAP_TYPE_ARRAY_OF_MAPS, so for
example we allocate a ring buffer for each CPU pair. Unfortunately,
this solution has a price since we increase the contention on the ring
buffers and as highlighted here [2], the presence of multiple
competing writers on the same buffer could become a real bottleneck...
Sorry for the long introduction, my question here is, are there any
other approaches to manage such a scenario? Will there be a
possibility to use the ring buffer without the kernel double mapping
in the near future? The ring buffer has such amazing features with
respect to the perf buffer, but in a scenario like the Falco one,
where we have aggressive multiple producers, this double mapping could
become a limitation.

Thank you in advance for your time,
Andrea

0: https://github.com/torvalds/linux/blob/master/kernel/bpf/ringbuf.c#L107
1: https://github.com/falcosecurity/falco
2: https://patchwork.ozlabs.org/project/netdev/patch/20200529075424.3139988-5-andriin@fb.com/
