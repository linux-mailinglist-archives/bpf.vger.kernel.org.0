Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B17A4FFF55
	for <lists+bpf@lfdr.de>; Wed, 13 Apr 2022 21:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236858AbiDMTd0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Apr 2022 15:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235045AbiDMTdZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Apr 2022 15:33:25 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF0E765B1
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 12:31:02 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id x4so3040264iop.7
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 12:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wHkpUjrC1vPux35w/9QrW8WkJpE4MlmRzF+o8YdIhfU=;
        b=LFxFnhZfIOeD8PK8N9h2M4irW6dMvc2Qwx3+le/GkkBM0JNBpd0DVFtMHTdUHbvZhx
         WQb6MKt4w8rJfA4ED+/CWNGnDMkWM6AZcs07K1wNMP3HAZEBzUoT9XbjMG2r/IomtKsq
         x7DC8Sss6B9f+AaHfNEcv7NQw7FL2+wv0pTGOJlyi6f4xvLaiBDE4pAGWxh8h5p9UlBo
         ohbVMFtLtW6xPcO+/6EywA7hBhYTur6wBAk9etXJ7xHkpYlqNtrDE5IbfAZLZomm9IM3
         aRJMrzq+U+mhI22cQy/gQi81W1+uDbYQOgbu1fALhghycjKzTwLExcBq/pnLSrxX41YV
         +/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wHkpUjrC1vPux35w/9QrW8WkJpE4MlmRzF+o8YdIhfU=;
        b=SDCUqxvBllzLDlJqFpEAeiAshYFPTWq+lfc4JpOUwcart2rXYW7jVgN1ofa7qnP6uv
         MBx1zcW0VgAoiPnlhJLxmp8YvZQGCPE35A0BvaTihBK3HoTFnwcFv3Dg1MRXIO2YR7gB
         S9SFFMguvjYxPTXHm6PxxQ0p8+sng3d6beQqiz54iBmwznkfn1NefTDK56jM0F6H0cR/
         KP6fdQDkZx0WWwjFUUI07bZxeBSVhfLk3GZIJkL32AKA6Hi4jboZdjpyFGLQfzBuy4T7
         r30EsTftTpnadL/D6u2nSRFXnWG7nKTt9K4qAWJs6iU+QJXGMERtItxls1d2Fel/bc/h
         //9g==
X-Gm-Message-State: AOAM530YNIFC3DHj5A6pFgXKHGo8UtC/E1NoZKFSMCh0zvSC7ARbEiFa
        n+fS7GSwdoQY/y0wmuk0gIG8hVO8hSWBvut7p+dCMu+l3mk=
X-Google-Smtp-Source: ABdhPJxNJO4lJkmxErxWtErj+24uocSdzvcshZwQeU/FyUABPgRpIb+xv1SbEAjSFmcZIsGe8/7CG3eQMafUbOsfDzA=
X-Received: by 2002:a05:6638:2642:b0:323:756f:42a7 with SMTP id
 n2-20020a056638264200b00323756f42a7mr21943935jat.145.1649878262009; Wed, 13
 Apr 2022 12:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220413140629.GA22650@L-PF27918B-1352.localdomain>
In-Reply-To: <20220413140629.GA22650@L-PF27918B-1352.localdomain>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 13 Apr 2022 12:30:51 -0700
Message-ID: <CAEf4BzYvBHwsFrp52ZqhP=H1WDdpEeovJcgctv2nioAvBg6FBw@mail.gmail.com>
Subject: Re: [Question] bpf map value increase unexpectedly with tracepoint qdisc/qdisc_dequeue
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 13, 2022 at 12:08 PM Wu Zongyong
<wuzongyong@linux.alibaba.com> wrote:
>
> Hi,
>
> I tried to count when tracepoint qdisc/qdisc_dequeue hit each time, then read
> the count value from userspace by bpf_map_lookup_elem().
> With bpftrace, I can see this tracepoint is hit about 700 times, but the count
> I get from the bpf map is below 20. It's weird. Then I tried to add a bpf_printk()
> to the program, and the count I get is normal which is about 700.
>
> The bpf program codes like that:
>
>         struct qdisc_dequeue_ctx {
>                 __u64           __pad;
>                 __u64           qdisc;
>                 __u64           txq;
>                 int             packets;
>                 __u64           skbaddr;
>                 int             ifindex;
>                 __u32           handle;
>                 __u32           parent;
>                 unsigned long   txq_state;
>         };
>
>         struct {
>                 __uint(type, BPF_MAP_TYPE_HASH);
>                 __type(key, int);
>                 __type(value, __u32);
>                 __uint(max_entries, 1);
>                 __uint(pinning, LIBBPF_PIN_BY_NAME);
>         } count_map SEC(".maps");
>
>         SEC("tracepoint/qdisc/qdisc_dequeue")
>         int trace_dequeue(struct qdisc_dequeue_ctx *ctx)
>         {
>                 int key = 0;
>                 __u32 *value;
>                 __u32 init = 0;
>
>                 value = bpf_map_lookup_elem(&count_map, &key);
>                 if (value) {
>                         *value += 1;
>                 } else {
>                         bpf_printk("value reset");
>                         bpf_map_update_elem(&count_map, &key, &init, 0);
>                 }
>                 return 0;
>         }
>
> Any suggestion is appreciated!
>

First, why do you use HASH map for single-key map? ARRAY would make
more sense for keys that are small integers. But I assume your real
world use case needs bigger and more random keys, right?

Second, you have two race conditions. One, you overwrite the value in
the map with this bpf_map_update_elem(..., 0). Use BPF_NOEXISTS for
initialization to avoid overwriting something that another CPU already
set. Another one is your *value += 1 is non-atomic, so you are loosing
updates as well. Use __sync_fetch_and_add(value, 1) for atomic
increment.

Something like this:

value = bpf_map_lookup_elem(&count_map, &key);
if (!value) {
    /* BPF_NOEXIST won't allow to override the value that's already set */
    bpf_map_update_elem(&count_map, &key, &init, BPF_NOEXISTS);
    value = bpf_map_lookup_elem(&count_map, &key);
}
if (!value)
    return 0;

__sync_fetch_and_add(value, 1);


> Thanks,
> Wu Zongyong
