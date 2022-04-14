Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2EE501E92
	for <lists+bpf@lfdr.de>; Fri, 15 Apr 2022 00:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347188AbiDNWrw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Apr 2022 18:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347193AbiDNWrv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Apr 2022 18:47:51 -0400
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76435C6B77
        for <bpf@vger.kernel.org>; Thu, 14 Apr 2022 15:45:25 -0700 (PDT)
Date:   Thu, 14 Apr 2022 22:45:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
        s=protonmail2; t=1649976323;
        bh=Jjx4TEjThTwWL8bj+lhR5ya+aOGQp9+e5cNVbMKzJbU=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=n1JYQEqnS0UycH2UG6rdRF0NDW9N472WSec3ZYaZEP3WdQJe6sEY8fOYa6pQDOBdN
         n8KwoW1Q61coy1P8wCY8gGLszNUHTwKDvm15696xiuA8j78ApsqvDyfkMtgZ16Emsr
         qFgZpsBF6piz0VCrrmuPaYznPT8dig9fPkTg9vphSHENpc3o3X51MeHt3Z8UuaPibu
         dBKc0hQoG/Q2AVm6EWq3QzG2b5A3fa3WbRKOTPt1VVTl/7k+9vfWIBxus5+8owcR+B
         xU2HYkr/S5czp89OwOV035PGE7HAeeZcuNkP9UoLJWEaE3NimsNNbjEJlF0n7asDZa
         5+VuryUcvrAiQ==
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        =?utf-8?Q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Chenbo Feng <fengc@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Daniel Wagner <daniel.wagner@bmw-carit.de>,
        Thomas Graf <tgraf@suug.ch>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: [PATCH bpf-next 03/11] tools, bpf: fix bpftool build with !CONFIG_BPF_EVENTS
Message-ID: <20220414223704.341028-4-alobakin@pm.me>
In-Reply-To: <20220414223704.341028-1-alobakin@pm.me>
References: <20220414223704.341028-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix the following error when building bpftool:

  CLANG   profiler.bpf.o
  CLANG   pid_iter.bpf.o
skeleton/profiler.bpf.c:18:21: error: invalid application of 'sizeof' to an=
 incomplete type 'struct bpf_perf_event_value'
        __uint(value_size, sizeof(struct bpf_perf_event_value));
                           ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/bpf/bpftool/bootstrap/libbpf/include/bpf/bpf_helpers.h:13:39: note: e=
xpanded from macro '__uint'
                                      ^~~
tools/bpf/bpftool/bootstrap/libbpf/include/bpf/bpf_helper_defs.h:7:8: note:=
 forward declaration of 'struct bpf_perf_event_value'
struct bpf_perf_event_value;
       ^

struct bpf_perf_event_value is being used in the kernel only when
CONFIG_BPF_EVENTS is enabled, so it misses a BTF entry then.
Emit the type unconditionally to fix the problem.

Fixes: 47c09d6a9f67 ("bpftool: Introduce "prog profile" command")
Signed-off-by: Alexander Lobakin <alobakin@pm.me>
---
 kernel/bpf/syscall.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 34fdf27d14cf..dd8284a60a8e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4286,6 +4286,7 @@ static int link_create(union bpf_attr *attr, bpfptr_t=
 uattr)
 =09=09goto out;
 =09case BPF_PROG_TYPE_PERF_EVENT:
 =09case BPF_PROG_TYPE_TRACEPOINT:
+=09=09BTF_TYPE_EMIT(struct bpf_perf_event_value);
 =09=09if (attr->link_create.attach_type !=3D BPF_PERF_EVENT) {
 =09=09=09ret =3D -EINVAL;
 =09=09=09goto out;
--
2.35.2


