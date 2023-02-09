Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B59568FCA9
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 02:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjBIBe3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 20:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjBIBe2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 20:34:28 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9459F21A29
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 17:34:27 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id jg8so2172757ejc.6
        for <bpf@vger.kernel.org>; Wed, 08 Feb 2023 17:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QiGErn18AVANP7c01pcCNvyVjFVPeorj/+FHc7W+uGY=;
        b=ZB5tXV2qJ2HAi/o402PmWYAT6GmEvFzUVUI9lgP1BrjWiKeFdc6k/MFQWPHLt6F4/0
         7KPXwbK79YGIkaTsniEUYF50iuqC2xNeiNBMYcnFlHJ1KH7a4SHgLEs4YJ1MXrjLmMIf
         LMjnYbWqvk3NQuB99yxfudBm6FBbD/o8UFuK4ItqchJvhC9/Eun+RIh15ldvyw30Ut95
         UfRhl2QabjlCEwl1f0oZgwaGGMSAILbJW+zLF/dLUdg1RB3D2TkVd8j8xME3FwT+GVWG
         xKLzqweUNQSPXc6v+1XF6II8+iqG/dISgWT+joqdZSbtoYFW+9PBxH+3M5wVfMJ7mtYI
         sJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QiGErn18AVANP7c01pcCNvyVjFVPeorj/+FHc7W+uGY=;
        b=XqD0KwVEDV6FCSqRqfN42RgIRxwlJMHapwjHaKMavva5m1S6l2y3ZbjylEojtVdi6d
         oc92Nljvba44Jzf5csx2kL0iHUcEtyFzhVVEgc2QgBVE84OMbtNUGcbnVoq6svg6RLcb
         fxkWOJhnsLjeyOyqubYD+vTGxE86AVt3cTM8flQ7Tq5DKxrT80gaMWqdKp5HwPYh/SE2
         PpDfvLdblhAOAY4jO4m/NYprB20ksViPJOV4uNQsG+7DiiUSRyxyDlyAncOAZzVLCwqc
         ZgNXxKbf9+tQyQspC9urdhoQnipqkZwnWS4XqjjcIGnAiO/J2i7LsWnTXqepCZF3PeWq
         YJzg==
X-Gm-Message-State: AO0yUKXX7DHrmuePNS4nF0oqlBq2jknsW6wv2OKXngBXZYRpkXcjko2o
        bVwIXviLwEmPZVYVKwWSsWTi858ay5UP0uex2ZCgHZ6Wsq8=
X-Google-Smtp-Source: AK7set9cL3XNuzhu8PMdNv3Kp0MBbAJsmajKZ/YYxMnU7aVlv+GY9ezFQqbK6VjXefsZPKuDYkZiDInJJ8iEZE+YBss=
X-Received: by 2002:a17:906:5946:b0:88a:b103:212d with SMTP id
 g6-20020a170906594600b0088ab103212dmr147199ejr.15.1675906466107; Wed, 08 Feb
 2023 17:34:26 -0800 (PST)
MIME-Version: 1.0
References: <20230208205642.270567-1-iii@linux.ibm.com> <20230208205642.270567-10-iii@linux.ibm.com>
In-Reply-To: <20230208205642.270567-10-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 8 Feb 2023 17:34:14 -0800
Message-ID: <CAEf4BzYMa5SXLu8Ajy7DjyJ3-qvK=AN5w+9YNwxrrQyjsNPk+g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 9/9] selftests/bpf: Add MSan annotations
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
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

On Wed, Feb 8, 2023 at 12:57 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> eBPF selftests produce a few false positives with MSan. These can be
> divided in two classes:
>
> - Sending uninitalized data via a socket.
> - bpf_obj_get_info_by_fd() calls.
>
> The first class is trivial; the second should ideally be handled by
> libbpf, but it doesn't look possible at the moment, since we don't
> know the type of the eBPF object referred to by fd, and therefore the
> structure of the output data.

yeah, bpf_obj_get_info_by_fd() is quite bad from usability standpoint.
I think we should add bpf_get_{map,prog,link,btf}_info_by_fd()
wrappers and try to use them. That will allow to specify correct
expected struct types, we'll be able to mark initialized memory
properly. We already have bpf_{map,prog,btf,link}_get_fd_by_id()
family, so having similar for getting info seems fitting (even if
underlying bpf() command is generic).

Thoughts?

>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/testing/selftests/bpf/cap_helpers.c             |  3 +++
>  tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c   | 10 ++++++++++
>  tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c   |  3 +++
>  tools/testing/selftests/bpf/prog_tests/btf.c          | 11 +++++++++++
>  tools/testing/selftests/bpf/prog_tests/send_signal.c  |  2 ++
>  .../selftests/bpf/prog_tests/tp_attach_query.c        |  6 ++++++
>  tools/testing/selftests/bpf/prog_tests/xdp_bonding.c  |  3 +++
>  tools/testing/selftests/bpf/xdp_synproxy.c            |  2 ++
>  8 files changed, 40 insertions(+)
>

[...]
