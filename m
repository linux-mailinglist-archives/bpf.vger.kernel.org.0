Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B281A6E1654
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 23:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjDMVJo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Apr 2023 17:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDMVJn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Apr 2023 17:09:43 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3656EB2
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 14:09:40 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id p8so16407416plk.9
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 14:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681420180; x=1684012180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xox8hXPs6W85vkGeUqQTY2m8uUpiVzMpq6KP6G7f3rU=;
        b=Ym5gHr6I7xCBVbfng1pj+vlV6abC7afi7iQNsZ+u464e3/mm69kOO49Qy2H0mZpu3N
         sN33a8dFEM7OcNQxr4W+NykW6qYpkDKIx5EdXZngCbYm6IPsWXhj60lQ+WqxpAyLF5wE
         hnaS+0dwQFupL74q3o5YOQXdcGr+4HZrRBg+6Q3DvEiDWRwRkGN0scaWz9zcnxVMdKoO
         kNwC9lA1yMlQ63mFemgySh8un6YzGZRlHLRn0HxV5MY+WACKqRkvYoYG2L94TnqSK450
         DCoqJu+re1TwgwUTwsBEs1jPRxjjn4T7EAdXWgNYsilp2ccIUpT3+uF1gLNVy2QnvVGE
         lr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681420180; x=1684012180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xox8hXPs6W85vkGeUqQTY2m8uUpiVzMpq6KP6G7f3rU=;
        b=Y5u6dGwKRIJ1OZF+d36gKtE0X1x7kJ2L/Z5VFGCX3eONYSRSm9Ip4lRVhTLCZt1SXJ
         AxjZZT0tjnRiVRnphkKX8/wGWgUi7TJNBAWbfSu347M+YHuP+j6/tel3132Eh5D0yRoY
         yS45yb6dbyhsnQmxEVFgo5ORaamAuezj9DXzIH299IwBpbvnOJ6fYoy++F1XhHGtSLI3
         TviFWiIoA43zJq5FcXkNmq2dXzisRhg5qEDTqrsxsxZJQdSIs+EIYDOPeBddZy1N40jQ
         weS3MzJ+y1ezy+toem9r5KIfQk9nMfJfsx7cbeHh7QU2Rz3t1xytD2YuUosci5NbwqmO
         SUDg==
X-Gm-Message-State: AAQBX9dAaVmy3HQUdJXZ1cpBVIObAPEUPJunDswip/YOJwLN54t3ndF0
        adIEnmldH6bH+AO2IeBKxcjMS6tCAkI7JtfA/PB+7Q==
X-Google-Smtp-Source: AKy350bvomgEW8Lh7LFBOXJ20N2wm5bs+7yCvbqTbYj1i2kFZJnMfuLFNzl+Tun402Fgyfd1I31QXCjEsJpAaEflFIc=
X-Received: by 2002:a17:903:100a:b0:1a6:97af:870b with SMTP id
 a10-20020a170903100a00b001a697af870bmr140092plb.2.1681420179676; Thu, 13 Apr
 2023 14:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230413025248.79764-1-laoar.shao@gmail.com>
In-Reply-To: <20230413025248.79764-1-laoar.shao@gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 13 Apr 2023 14:09:27 -0700
Message-ID: <CA+khW7iS4xHZ1tnY14yyHbGpmxvToY-7_Gei8YxW9yar0hJhNw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add preempt_count_{sub,add} into btf id
 deny list
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        jolsa@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
        bpf@vger.kernel.org, Jiri Olsa <olsajiri@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Apr 12, 2023 at 7:52=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> From: Yafang <laoar.shao@gmail.com>
>
> The recursion check in __bpf_prog_enter* and __bpf_prog_exit*
> leave preempt_count_{sub,add} unprotected. When attaching trampoline to
> them we get panic as follows,
>
> [  867.843050] BUG: TASK stack guard page was hit at 0000000009d325cf (st=
ack is 0000000046a46a15..00000000537e7b28)
> [  867.843064] stack guard page: 0000 [#1] PREEMPT SMP NOPTI
> [  867.843067] CPU: 8 PID: 11009 Comm: trace Kdump: loaded Not tainted 6.=
2.0+ #4
> [  867.843100] Call Trace:
> [  867.843101]  <TASK>
> [  867.843104]  asm_exc_int3+0x3a/0x40
> [  867.843108] RIP: 0010:preempt_count_sub+0x1/0xa0
> [  867.843135]  __bpf_prog_enter_recur+0x17/0x90
> [  867.843148]  bpf_trampoline_6442468108_0+0x2e/0x1000
> [  867.843154]  ? preempt_count_sub+0x1/0xa0
> [  867.843157]  preempt_count_sub+0x5/0xa0
> [  867.843159]  ? migrate_enable+0xac/0xf0
> [  867.843164]  __bpf_prog_exit_recur+0x2d/0x40
> [  867.843168]  bpf_trampoline_6442468108_0+0x55/0x1000
> ...
> [  867.843788]  preempt_count_sub+0x5/0xa0
> [  867.843793]  ? migrate_enable+0xac/0xf0
> [  867.843829]  __bpf_prog_exit_recur+0x2d/0x40
> [  867.843837] BUG: IRQ stack guard page was hit at 0000000099bd8228 (sta=
ck is 00000000b23e2bc4..000000006d95af35)
> [  867.843841] BUG: IRQ stack guard page was hit at 000000005ae07924 (sta=
ck is 00000000ffd69623..0000000014eb594c)
> [  867.843843] BUG: IRQ stack guard page was hit at 00000000028320f0 (sta=
ck is 00000000034b6438..0000000078d1bcec)
> [  867.843842]  bpf_trampoline_6442468108_0+0x55/0x1000
> ...
>
> That is because in __bpf_prog_exit_recur, the preempt_count_{sub,add} are
> called after prog->active is decreased.
>
> Fixing this by adding these two functions into btf ids deny list.
>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Yafang <laoar.shao@gmail.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Jiri Olsa <olsajiri@gmail.com>
> ---

Thanks Yafang,

Acked-by: Hao Luo <haoluo@google.com>

I happened to be looking at a similar problem the other day. I was
wondering if we can trace preempt_{enable, disable}. It turns out
those functions are not covered by the recursion protection. It makes
sense to add them to the denylist.

Hao
