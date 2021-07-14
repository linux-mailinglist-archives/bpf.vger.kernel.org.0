Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFE13C8822
	for <lists+bpf@lfdr.de>; Wed, 14 Jul 2021 17:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239884AbhGNP7Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Jul 2021 11:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239877AbhGNP7Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Jul 2021 11:59:25 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9549CC061764
        for <bpf@vger.kernel.org>; Wed, 14 Jul 2021 08:56:33 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id u25so4097355ljj.11
        for <bpf@vger.kernel.org>; Wed, 14 Jul 2021 08:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=WzBK9ERHaZxFdBxPHSrbA4IYumXCPn8UfReAHKrj0v0=;
        b=w5jc7OAKHRzl4YTn6zAvJ++zfto0ZvfyzqmrXKgj7WmDcPy30D6INjI2tBQTJIWzab
         37qtPfPCPHNuNH7269XPrQvqhXATnXxYMs37hHzeuBM7n4FJJ2H/AYq/eyPhiZew4gdD
         MtYYjmrcRruL3LO+c6gMkb+SJ8e00riguWgR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=WzBK9ERHaZxFdBxPHSrbA4IYumXCPn8UfReAHKrj0v0=;
        b=MYRLDInCQtDgCcaWIIGFxgdl0i0FXwOjGkSLrJlxbEATErgGQ4pya9jnnWdZ6D861k
         CxKTyFf6/lLqcEGUoe4zO7K3rlD/bYtLiGdCdwnfw9givOxM6L1uWXAUdm1jk+F9jOc/
         iShDToxv+Hx6pytYw/rIwkw57726ogfDq0Jm12N7xE9p2LfqGe0xgjwsLO4JebTJN35O
         k7M5cpuWbM/GtDE7fuwPDBgkVUG7nYz5kQUkSO69qGrTE1qZSAFsQMErs2JvYGAS8qmx
         BET7wwm3R5rVz3B3yZY6li5HJJ+09EjfpDKpSDF3UjUXLvwoecX/LELZ9BfUeu6ZOcjR
         ZbSQ==
X-Gm-Message-State: AOAM531T7KeV/6K74cawgOlniKr0Iy8kiZX6vzrmx7HDMn7nXK4M6UVq
        v3yD41txYS9piBXJAD/O1NS8Ew==
X-Google-Smtp-Source: ABdhPJyV0huv3JF5YuH6LhKvklYRlJLVKfmbyztk2SWOSdYbNSzfUzpDoVpN+RqID0QtAhEYsaDYhA==
X-Received: by 2002:a05:651c:1aa:: with SMTP id c10mr10124921ljn.56.1626278191979;
        Wed, 14 Jul 2021 08:56:31 -0700 (PDT)
Received: from cloudflare.com (79.191.183.149.ipv4.supernova.orange.pl. [79.191.183.149])
        by smtp.gmail.com with ESMTPSA id a3sm191060lfl.134.2021.07.14.08.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 08:56:31 -0700 (PDT)
References: <20210713074401.475209-1-jakub@cloudflare.com>
 <CAM_iQpVV1XRTsbyEbG_GTb4GHHx47m+TOYYw_z3euX3UYvDt9Q@mail.gmail.com>
User-agent: mu4e 1.1.0; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf, sockmap, udp: sk_prot needs inuse_idx set for
 proc stats
In-reply-to: <CAM_iQpVV1XRTsbyEbG_GTb4GHHx47m+TOYYw_z3euX3UYvDt9Q@mail.gmail.com>
Date:   Wed, 14 Jul 2021 17:56:30 +0200
Message-ID: <87wnpsris1.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 14, 2021 at 02:51 AM CEST, Cong Wang wrote:
> On Tue, Jul 13, 2021 at 12:44 AM Jakub Sitnicki <jakub@cloudflare.com> wrote:
>>
>> Proc socket stats use sk_prot->inuse_idx value to record inuse sock stats.
>> We currently do not set this correctly from sockmap side. The result is
>> reading sock stats '/proc/net/sockstat' gives incorrect values. The
>> socket counter is incremented correctly, but because we don't set the
>> counter correctly when we replace sk_prot we may omit the decrement.
>>
>> To get the correct inuse_idx value move the core_initcall that initializes
>> the udp proto handlers to late_initcall. This way it is initialized after
>> UDP has the chance to assign the inuse_idx value from the register protocol
>> handler.
>
> Interesting. What about IPv6 module? Based on my understanding, it should
> always be loaded before we can trigger udp_bpf_check_v6_needs_rebuild().
> If so, your patch is complete.

That's my understanding as well. The lazy update_proto call chain is:

sock_map_update_common
  sock_map_link
    sock_map_init_proto
      psock->psock_update_sk_prot
        udp_bpf_update_proto
          udp_bpf_check_v6_needs_rebuild

If that happens we are being passed an AF_INET6 socket. Socket has been
created so IPv6 module must have been loaded.

>>
>> Fixes: 5e21bb4e8125 ("bpf, test: fix NULL pointer dereference on invalid expected_attach_type")
>
> Should be commit edc6741cc66059532ba621928e3f1b02a53a2f39
> (bpf: Add sockmap hooks for UDP sockets), right?

Thanks. Fixed in v2.
