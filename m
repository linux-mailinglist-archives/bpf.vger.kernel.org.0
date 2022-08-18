Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2343C598866
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 18:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343624AbiHRQM4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Aug 2022 12:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245254AbiHRQMz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Aug 2022 12:12:55 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A723BCCC3
        for <bpf@vger.kernel.org>; Thu, 18 Aug 2022 09:12:55 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 202so1638283pgc.8
        for <bpf@vger.kernel.org>; Thu, 18 Aug 2022 09:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=np3X6YADmGhWsKEmorFSnN3Tli7/JF2t3bjJf59x8Yk=;
        b=iRpmSdMztktVZTUVM9JO1LeQ7OTKN+Ntu+FfSKUiQY0GsFRt4SwAy/K7BFag5P0gJa
         y83E6sdvj3+FbjWtdguzHab/gxdqmU6xp9AULCGswgKz4k3HVtLXB2nQTRjIT2CyDOb0
         fJ1bFr3JYaHThYKhkQY5O7zBbG0Vk+fhEElLITwHajtF6AzNz8GCfZHdzg/IdpwP/gfC
         PRIHrBTWU3mpYtXZZWBMQjfOeOjGXbYtIKtgxODWPrH8h5j5g7xo+D8zaTq1CyYSq7Lk
         VdoV+xT6FeG8jWolQzuiYu0px8l1iSS8oQ67NmLu07dlcxmxrJMu1ObPFjO3Yi4x4yBP
         EYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=np3X6YADmGhWsKEmorFSnN3Tli7/JF2t3bjJf59x8Yk=;
        b=r+0uWAck2+9CbtygIYLoWuYwE1g9B3xGUv4X00Z+EigUHkHtmmrjal2IXyvCIFRY4H
         XlMsZQdAgUNz1wbFYuTUjwsYtvyZK3Q39tKaoRX3R0fcdUc1NujhyNYCqg7JtV0vWDL0
         +mFLun9hHKjtPyKHwGdJZnwLYfGz+Nl1j+TnlP6w8o+VUg9XYKw7NASXD/X1gYf+Y9sm
         bAslXDQ3H1ptMjSPCsziYNh6hgDl2Cb0N/Y9G2f0hSfzfqIOTO50lrMb7YhmZBfKTkO2
         aTkDqlBADmOX4Yry4W3j/eKgRo07zvyYTkkJhVjBwDCZPiuag0lJ9lXEk7o6m2piPb/m
         nTdg==
X-Gm-Message-State: ACgBeo21uyEgtvxpqZm4c/l9vUvhsaw5bbRRQ92cuEDA96vaqXoay534
        ZrnE1SzsqcH+B0kxeO9tR5hzyidzIcmxPP0xRFO3WQ==
X-Google-Smtp-Source: AA6agR4VcXcHyAjycETpZB+i3YYfGKjZ3CMVod6NpaxneXrE+7QQHCDngqScdaGBOAYN9YcmQLHTCNlh6P2IYa3O9Fw=
X-Received: by 2002:a63:1043:0:b0:429:fd41:b7cb with SMTP id
 3-20020a631043000000b00429fd41b7cbmr2768310pgq.442.1660839174289; Thu, 18 Aug
 2022 09:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220818062405.947643-1-shmulik.ladkani@gmail.com> <20220818062405.947643-3-shmulik.ladkani@gmail.com>
In-Reply-To: <20220818062405.947643-3-shmulik.ladkani@gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 18 Aug 2022 09:12:43 -0700
Message-ID: <CAKH8qBsrUL2eV4YcxVYqp+3Fqx+Gx667othK8O-5Lp8r9yM_8w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf/flow_dissector: Introduce
 BPF_FLOW_DISSECTOR_CONTINUE retcode for flow-dissector bpf progs
To:     Shmulik Ladkani <shmulik@metanetworks.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 17, 2022 at 11:24 PM Shmulik Ladkani
<shmulik@metanetworks.com> wrote:
>
> Currently, attaching BPF_PROG_TYPE_FLOW_DISSECTOR programs completely
> replaces the flow-dissector logic with custom dissection logic.
> This forces implementors to write programs that handle dissection for
> any flows expected in the namespace.
>
> It makes sense for flow-dissector bpf programs to just augment the
> dissector with custom logic (e.g. dissecting certain flows or custom
> protocols), while enjoying the broad capabilities of the standard
> dissector for any other traffic.
>
> Introduce BPF_FLOW_DISSECTOR_CONTINUE retcode. Flow-dissector bpf
> programs may return this to indicate no dissection was made, and
> fallback to the standard dissector is requested.

Some historic perspective: the original goal was to explicitly not
fallback to the c code.
It seems like it should be fine with this extra return code.
But let's also extend tools/testing/selftests/bpf/progs/bpf_flow.c
with a case that exercises this new return code?

> Signed-off-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
> ---
>  include/uapi/linux/bpf.h  | 5 +++++
>  net/core/flow_dissector.c | 3 +++
>  2 files changed, 8 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 7bf9ba1329be..6d6654da7cef 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5836,6 +5836,11 @@ enum bpf_ret_code {
>          *    represented by BPF_REDIRECT above).
>          */
>         BPF_LWT_REROUTE = 128,
> +       /* BPF_FLOW_DISSECTOR_CONTINUE: used by BPF_PROG_TYPE_FLOW_DISSECTOR
> +        *   to indicate that no custom dissection was performed, and
> +        *   fallback to standard dissector is requested.
> +        */
> +       BPF_FLOW_DISSECTOR_CONTINUE = 129,
>  };

Is it too late to also amend verifier's check_return_code to allow
only a small subset of return types for flow-disccestor program type?

>  struct bpf_sock {
> diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> index a01817fb4ef4..990429c69ccd 100644
> --- a/net/core/flow_dissector.c
> +++ b/net/core/flow_dissector.c
> @@ -1022,11 +1022,14 @@ bool __skb_flow_dissect(const struct net *net,
>                         prog = READ_ONCE(run_array->items[0].prog);
>                         result = bpf_flow_dissect(prog, &ctx, n_proto, nhoff,
>                                                   hlen, flags);
> +                       if (result == BPF_FLOW_DISSECTOR_CONTINUE)
> +                               goto dissect_continue;
>                         __skb_flow_bpf_to_target(&flow_keys, flow_dissector,
>                                                  target_container);
>                         rcu_read_unlock();
>                         return result == BPF_OK;
>                 }
> +dissect_continue:
>                 rcu_read_unlock();
>         }
>
> --
> 2.37.1
>
