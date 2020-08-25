Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22D5250CBA
	for <lists+bpf@lfdr.de>; Tue, 25 Aug 2020 02:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgHYAFj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Aug 2020 20:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgHYAFg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Aug 2020 20:05:36 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021B2C0613ED
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2020 17:05:35 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id dp2so8874061ejc.4
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2020 17:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qSJ3hn6SwlvnIDydC8UlMXM4TqY2oPyCDRxRi3ibWKE=;
        b=QApUvtXGB19mVLe2YJN+0fc/ADwHcSDUAddvOk2oAlHGx94SRMwAiMJTJvczmY5/LJ
         5H8+z7s7ZKd4wBvGD40WowzmVgvVsHC7ykBwWbntxs+LCdWQ0VlGq5aJy0tz0qdKFdin
         uqbcvQg3gw5dEsFtO/tv+zUPbf76fN0Xd+WIdO2tZWQV+cPBuKHwpaS0iqoIazyjb0WC
         0VZo8VziYEC6cUStvp9KOD1OLo0QqjVFLoqT/QcWYj/HyXpaO7wUMO/DhvkzYkOkf+Q8
         50J2vA7dD1LC81Uhbyha05eeIKaAFh7rlFdSCBn2tV5rFA3cEm13F4JrxvRfM0oeesYi
         BmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qSJ3hn6SwlvnIDydC8UlMXM4TqY2oPyCDRxRi3ibWKE=;
        b=H4k4frlKzvwx/BME5Rn9R/gHMzvGRz2zttCUhHoGZZ4AzeG+yIEEqzDxNZ2vm/I2G8
         V7e/v8ZARLXilGaNlMqSiNHW2iGgjNOuV7PR5/s5XUV5/LyvUo6AAPuK257zzP4XZs6n
         +6vlk0YRt3WAINN2wykp1FMECbnC912pqKxj48PaXdE+5ymNhOTle8FfJjTL1Vs17jI/
         6PbzwrgZTlDkaOBY4ArHNuIVn4AAB0wOz7CWTC3CAx9h3Qbvr+KlYE5lJkatRxXckdc7
         crFk2kSQVKfswDnWhM19pVnLUHQU2A7IlLN4+Rpug7pEf7pKcxyH3ANozWtHVcdqq3b2
         ivBQ==
X-Gm-Message-State: AOAM5308lrc7LxZRAvi1qCjAEhZW2LksC0Vx9NOoTzqwI4EHxCOHRxVl
        Ytmg/1BjY0pLcCwOcUyzm+TKVb3E5jYDAugLB8syOw==
X-Google-Smtp-Source: ABdhPJwq7yY0fgxViANrAk7HQzEo+kQDYpeeuJOcuEDl5RbeTE9wZIRWTSGvgD/2fC4+y7BPhunkS6W3JpETlvNIrSg=
X-Received: by 2002:a17:906:a085:: with SMTP id q5mr7825181ejy.136.1598313933985;
 Mon, 24 Aug 2020 17:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200819224030.1615203-1-haoluo@google.com> <20200819224030.1615203-2-haoluo@google.com>
 <35519fec-754c-0a17-4f01-9d6e39a8a7e8@fb.com>
In-Reply-To: <35519fec-754c-0a17-4f01-9d6e39a8a7e8@fb.com>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 24 Aug 2020 17:05:22 -0700
Message-ID: <CA+khW7iGs=tN2FT=rEiPZMQ_Z9=sqhRe4dY7dKbVoViwX666BQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/8] bpf: Introduce pseudo_btf_id
To:     Yonghong Song <yhs@fb.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Andrey Ignatov <rdna@fb.com>,
        Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong,

An update on this thread. I successfully reproduced this issue on a
8.2.0 gcc compiler, It looks like gcc 4.9 did not have this issue. I
was also using clang which did not show this bug.

It seems having a DW_AT_specification that refers to another
DW_TAG_variable isn't handled in pahole. I have a (maybe hacky) pahole
patch as fix and let me clean it up and post for review soon.

Hao
