Return-Path: <bpf+bounces-4430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA06074B27B
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 16:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65EF428177A
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 14:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96737D2F9;
	Fri,  7 Jul 2023 14:04:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E55C8E6
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 14:04:42 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E13110EA
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 07:04:40 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b69e6d324aso29516541fa.0
        for <bpf@vger.kernel.org>; Fri, 07 Jul 2023 07:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688738678; x=1691330678;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qwnWWKCVB4plzMeigCbW0omom0P1pYbSL/j64f058j8=;
        b=Ox0+aMR/aqHHOzYal/EvFcBw8Kd4mKq8Zut8jWK0i3aV32OHyP6FeKzpI4FITcVDWb
         k3zmM00cSIBKIEhGKmyMhuYsy9H3Q/l597eMgbkDpOnBEsBs0n7rXzP/TLVHhU3CdZcq
         6x0i/LM4aC0P6LCWh63590pWEDzwffudNyRwTSiiyDBs80kGEvzMpVFv4zSWgwe6jA/m
         gdsglqUcGejrUP4M125H8llqgmlx0eXd9+YXqQu2+Fcw6pcWM70EeKnHdA7stv2F+Z9Z
         NMnRw50PiwpdReZoNEVJYknBFubDeqs5h+zFSFZq9uSavcJKF7Y23lq+7kXe1DHY0dBB
         uUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688738678; x=1691330678;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qwnWWKCVB4plzMeigCbW0omom0P1pYbSL/j64f058j8=;
        b=ToaNwalE4tuSswayQ55BhwtYioor2uB1yEsxUFSShRCjLFFxf2UMykbTt1AJ4B8iSb
         2Lv8GU2m/MM7zcRscU/iRrIx2XKdN04qPSo6lCvGPlGUs3ugaW4fl8sbRZpIMmVn+hp/
         thy2PHHQVq+/cVtNSczwgx4KT5aFFo4klrGP3HH5XmPGBNSsaNM2rhtJcqtQVVHl/mzJ
         0M8EN0TUP8twH5VwVgc6817DA93Z/wTUOqJggMPtAiwm/8dj0TvDetBxoH8cLtX5lgMN
         bjyvIQgZRM9m0arUJq7YNMQUPmmXV3ifEoAaaaLxffYJ2W0ZBEzPsCpdgGzPXZYJsIL/
         lKJg==
X-Gm-Message-State: ABy/qLboIMzkqC/SjWqKSlCzv0PEqbjCQ2FUMpA/IiWLCu1GVmQy4+wp
	kAft7bb6SNwb12PRvdmiYLkNeIAdTyOYUjWweElHChG46a1GzpoE
X-Google-Smtp-Source: APBJJlEgCbDUNxFi+Xc0KTCLxJKFPuigofPFpUe8EdxUo0wv1MofnhvK01ToZhV2X8WatFpvGy4l/8+lzTr7hv1Kk+s=
X-Received: by 2002:a2e:9896:0:b0:2b6:eeb3:da94 with SMTP id
 b22-20020a2e9896000000b002b6eeb3da94mr3774945ljj.22.1688738677657; Fri, 07
 Jul 2023 07:04:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Andrew Werner <awerner32@gmail.com>
Date: Fri, 7 Jul 2023 10:04:26 -0400
Message-ID: <CA+vRuzPChFNXmouzGG+wsy=6eMcfr1mFG0F3g7rbg-sedGKW3w@mail.gmail.com>
Subject: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
To: bpf@vger.kernel.org
Cc: Andrei Matei <andreimatei1@gmail.com>, Tamir Duberstein <tamird@gmail.com>, joannelkoong@gmail.com, 
	kernel-team@dataexmachina.dev, andrii.nakryiko@gmail.com, song@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

My coworkers and I have been playing with tracing use cases with bpf
and we uncovered some programs we did not expect to pass verification.
We believe that there's incorrect logic when in the verifier in the
context of the
`bpf_loop` and `bpf_for_each_map_elem` helpers (I suspect also
`bpf_user_ringbuf_drain`, but I haven't verified it). These helpers are
interesting in that they take a callback function, and a context pointer which
will be passed into the callback function; these are the helpers that do some
form of iterations. The observation is that the verifier doesn't take into
account possible changes to the context made by the callback. I'm interested in
better understanding how the verifier is supposed to work in these cases, and to
collaborate on fixing the underlying problem. Consider the following probes
(Note: this will crash the machine if triggered):

```C
#include <linux/bpf.h>
#include <linux/ptrace.h>
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_tracing.h>

char _license[] SEC("license") = "GPL";

typedef struct context {
    char* buf;
} context_t;

static long loop_callback(__u32 idx, context_t* ctx)
{
    if (idx == 0) {
        ctx->buf = (char*)(0xDEAD);
        return 0;
    }
    if (bpf_probe_read_user(ctx->buf, 8, (void*)(0xBADC0FFEE))) {
        return 1;
    }
    return 0;
}

SEC("uprobe/bpf_loop_bug")
int BPF_KPROBE(bpf_loop_bug, void* foo_ptr)
{
    __u64 buf = 0;
    context_t context = (context_t) { .buf = (char*)(&buf) };
    bpf_loop(100, loop_callback, &context, 0);
}
```

As far as I can tell, the verifier only verifies the callback relative to the
state of the context value when it's initially passed in. This can
problematically allow for pointers to erroneously be considered valid
pointers to
map data when in reality those pointers can point anywhere. The example probes
use this to write arbitrary data into arbitrary memory addresses.

From my reading of the verifier code, it seems that only exactly one
iteration of the loop is checked. The important call, as I understand it, is
`__check_func_call`[1]. It seems that that logic adjusts the verifier state
to move the arguments into the appropriate registers, and then passes
verification into the body of the function, but then, when the verifier hits
a return, it just goes back to the caller as opposed to verifying the next
iteration of the loop. Am I missing something?

When it comes to fixing the problem, I don't quite know where to start.
Perhaps these iteration callbacks ought to be treated more like global functions
-- you can't always make assumptions about the state of the data in the context
pointer. Treating the context pointer as totally opaque seems bad from
a usability
perspective. Maybe there's a way to attempt to verify the function
body of the function
by treating all or part of the context as read-only, and then if that
fails, go back and
assume nothing about that part of the context structure. What is the
right way to
think about plugging this hole?

Somewhat tangential, it seems that if I later interact with the data in the
context which may have been mutated, I get a rather opaque verifier error about
the context type itself: `reg type unsupported for arg#1 function
loop_callback#33`. I'd be interested to understand more deeply why this combined
version fails verification, and how to improve the error. See the
following probe:

```C
SEC("uprobe/both")
int BPF_KPROBE(bpf_for_each_map_elem_bug, void *foo_ptr) {
    __u64 buf = 0;
    context_t context = (context_t) {.buf = (char *)(&buf) };
    bpf_for_each_map_elem(&ARRAY, for_each_map_elem_callback, &context, 0);
    bpf_loop(100, loop_callback, &context, 0);
}
```

Just for completeness, here's one using `bpf_for_each_map_elem`:

```C
struct {
    __uint(type, BPF_MAP_TYPE_ARRAY);
    __type(key, __u32);
    __type(value, __u64);
    __uint(max_entries, 100);
} ARRAY SEC(".maps");

static long for_each_map_elem_callback(
    struct bpf_map* map,
    const __u32* key,
    __u64* value,
    context_t* ctx
) {
    if (*(__u64*)(ctx->buf) == 0) {
        ctx->buf = (char*)(0xDEAD);
        return 0;
    }
    if (bpf_probe_read_user(ctx->buf, 8, (void*)(0xBADC0FFEE))) {
        return 1;
    }
    return 0;
}

SEC("uprobe/for_each_map_elem_bug")
int BPF_KPROBE(for_each_map_elem_bug, void* foo_ptr)
{
    __u64 buf = 0;
    context_t context = (context_t) { .buf = (char*)(&buf) };
    bpf_for_each_map_elem(&ARRAY, for_each_map_elem_callback, &context, 0);
    bpf_loop(100, loop_callback, &context, 0);
}
```
[1]: https://github.com/torvalds/linux/blob/5133c9e51de41bfa902153888e11add3342ede18/kernel/bpf/verifier.c#L8668

