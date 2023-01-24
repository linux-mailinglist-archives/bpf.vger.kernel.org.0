Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518DD67A4A1
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 22:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbjAXVLw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 16:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbjAXVLv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 16:11:51 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884B34A1D6;
        Tue, 24 Jan 2023 13:11:41 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id kt14so42570620ejc.3;
        Tue, 24 Jan 2023 13:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6VLfWvMIE+0MYnxjr0DPm0a1hmaojHme2AR9a6gv5+A=;
        b=TxOBUUSdgIBLJ02hrTJoaxJq2/1uCBG0yLSvLao+h7ARu3iM7HKAt8bYX57MtVtlVm
         Rxab8x5xMRxOIEcaphlyXgZfJsHtZJXLWxem2UNO4Waqg28SsVAsRx6Z6+1y+K8mhKdo
         ubrYaM7PQM5pzCdWqQrmOC1NxmwogNM4FIfe8fHcQNbM7nTBQVS+ExBkf3R3uB+2bynX
         TF8UGlf4ykumgDFGytruc0ywGYA6DwfwuCDZPhUk+tq9Q0GKU9W9xmjK6ue0/iL0Hyc4
         hEF9dC/FF7QTjzIw+Ac1tb6AiQQFZ7rlQPgI6O7FbOluQ08sgTS7lunVW64dyRLZwCAb
         BX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6VLfWvMIE+0MYnxjr0DPm0a1hmaojHme2AR9a6gv5+A=;
        b=T+gqNjDn2zKZp6RuCYkFb7/hsoAjhRuEGsPaDqB012IqV2pIVZRHYHiLQJ9SP+iwEB
         qz7KpXHoWMvmh1rodG67rR3HXcB05rYR2nPBweTpT8r5XDPnaB3/JDVxqV/fZa7ydE8k
         eYgpoDZFxcNhCjWHsAR+B2kyrJLbQ79ncPWRm3yTdXx6FccHt/u5lE0jx88CG1K1cd4I
         vPWnzlzab0gK1U55edRR6PVJp/8M/x9T7ti0bOlHeeMv9qgHAwJSsF9bt5kiUQJTr47+
         U62Cc9P0x1PEgjbTJqbJ6qsoJqyGh531CXLL5QR44VIUjbaEyunYksg4nLNApL9dVJUD
         5Hlg==
X-Gm-Message-State: AFqh2kpUW3FRxkcqfPiRzMHsqqy8+hTM1hlpjZ6GK6OaFO5hW3t0c+Y/
        eRq3U7RdrrA8Gq448Uaq63sl4LxSmbgpkAkLfW0=
X-Google-Smtp-Source: AMrXdXvKgaepUMdT61pPhe51PlugSdTDtzOGQT/sKSMMKBNvfvNuiMFxSRoAI0f8ihee41LKPEnzzmXexTDZjo/9NOg=
X-Received: by 2002:a17:906:5a94:b0:84d:3b9a:e2b3 with SMTP id
 l20-20020a1709065a9400b0084d3b9ae2b3mr2622670ejq.318.1674594700019; Tue, 24
 Jan 2023 13:11:40 -0800 (PST)
MIME-Version: 1.0
References: <20230124202238.563854686@goodmis.org> <20230124202515.873075730@goodmis.org>
In-Reply-To: <20230124202515.873075730@goodmis.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 24 Jan 2023 13:11:28 -0800
Message-ID: <CAADnVQ+fJEtHVA6FhqtP1iMNfO7wQserFG_bRvuZcvQSY=kV2Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] bpf/tracing: Use stage6 of tracing to not duplicate macros
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linyu Yuan <quic_linyyuan@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
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

On Tue, Jan 24, 2023 at 12:25 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>
> The bpf events are created by the same macro magic as tracefs trace
> events are. But to hook into bpf, it has its own code. It duplicates many
> of the same macros as the tracefs macros and this is an issue because it
> misses bug fixes as well as any new enhancements that come with the other
> trace macros.
>
> As the trace macros have been put into their own staging files, have bpf
> take advantage of this and use the tracefs stage 6 macros that the "fast
> ssign" portion of the trace event macro uses.
>
> Link: https://lore.kernel.org/lkml/1671181385-5719-1-git-send-email-quic_linyyuan@quicinc.com/
>
> Cc: bpf@vger.kernel.org
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Reported-by: Linyu Yuan <quic_linyyuan@quicinc.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Nice cleanup.
Acked-by: Alexei Starovoitov <ast@kernel.org>
