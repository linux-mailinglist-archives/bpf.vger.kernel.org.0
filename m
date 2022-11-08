Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195646205A7
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 02:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbiKHBPB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 20:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiKHBO7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 20:14:59 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2466BE016;
        Mon,  7 Nov 2022 17:14:57 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id t25so34705464ejb.8;
        Mon, 07 Nov 2022 17:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZUC/K/qq4lsjAEpOrOv4UwDp2L93NLbYrIOQ63CsCc=;
        b=Ohddt+jcUF9W8ZRTqFt5ZEkQPWBh77ov0po6xJ0iyNXsvjJIUgmMADk4+RZR7jugUY
         A8zdNZoHZgkV0GTJmsyUlYsIHwSweWYBGZlclS1mpRGd/QNM7N36Ol+z2tElSjHYNJkU
         gG7bmgBXKyuwaEy0p5ETDAE0SrDXDUCusLqs6QFe8XvjY6tNc21Qqq1SxK6Xlxcf2kp4
         K/TKD5K2FqXTHm3Ucxj/XkZ44fQXwAu0dJ9PpK6vq9kSZIjD9CSWTyFMtICy4fWow+pQ
         ODUmZTQdYZAcPh4mLotcG/4tDvf69w4pgHj2XgTL4wGFlNOsQcrF2O+4ETKB0WBETiBp
         oAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ZUC/K/qq4lsjAEpOrOv4UwDp2L93NLbYrIOQ63CsCc=;
        b=UX65CC6gvFaTRI8XeGImcZNiOwX19UAhEHn4+nCJVuahNPA7U8NIupuYOYGMOpGJ+7
         3sqcw2ofYDWqPywftyu3Wg02JYrFnLHcksB6pz7B2RjT3KxjbHX4iRFjEysAGRA14B5O
         sQy1ebHfWKQUwPfpzYpOfHRkuuKzeIVjq7RrjTlELbTyUTrC9S4AwnVsrIPq0h89uKoK
         GF55eNqcKBDpjO62HByKJD5YiFlZZZwwJgdofTUaZpPLwpOVxi76bSRlHCReDRKYDMJ1
         NuiPHUzKKWE3EIbUOyY4Put0M8H+OQ1SEpjglDpy+Kc3Vf11nmqpwAwjBiJ6X5CoaCaZ
         5ZKQ==
X-Gm-Message-State: ACrzQf2+WCuNf7C0l+wd+qqWGmFEpuz+jxga3w+8/CbG1DeNhx/7vHWA
        1h9tT48+AnXkU8MxQg9gnKSpAR+f6ftGr5F14Ok=
X-Google-Smtp-Source: AMsMyM4fl7DfOrNo2zRACUgEhBPymhnkDqcdrvZ2enUgZB/RNLXKus33hrkO/Wx9xSlhTVEe4yYRqtCa9lmNkmTBBC4=
X-Received: by 2002:a17:906:99c5:b0:73d:70c5:1a4f with SMTP id
 s5-20020a17090699c500b0073d70c51a4fmr50120270ejn.302.1667870095649; Mon, 07
 Nov 2022 17:14:55 -0800 (PST)
MIME-Version: 1.0
References: <CAEf4BzbZDmgnohyyXBwy+p_qfZ1r_kq6d3bfqig+zSOm65vFHg@mail.gmail.com>
 <tencent_EBA3C18864069E42175946973C2ACBAF5408@qq.com>
In-Reply-To: <tencent_EBA3C18864069E42175946973C2ACBAF5408@qq.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 7 Nov 2022 17:14:43 -0800
Message-ID: <CAEf4BzaOv=yp6OyD745=j0yEcS3fW9FJUsQq-9ypNsDOiKqh7A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] samples/bpf: Fix sockex3 error: missing BPF prog type
To:     Rong Tao <rtoax@foxmail.com>
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, rongtao@cestc.cn, sdf@google.com,
        song@kernel.org, yhs@fb.com
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

On Fri, Nov 4, 2022 at 11:48 PM Rong Tao <rtoax@foxmail.com> wrote:
>
> From: Rong Tao <rongtao@cestc.cn>
>
> since commit 450b167fb9be("libbpf: clean up SEC() handling"),
> sec_def_matches() does not recognize "socket/xxx" as "socket", therefore,
> the BPF program type is not recognized.
>
> Instead of sockex3_user.c parsing section names to get the BPF program fd.
> We use the program array map to assign a static index to each BPF program
> (get inspired by selftests/bpf progs/test_prog_array_init.c).
> Therefore, use SEC("socket") as section name instead of SEC("socket/xxx"),
> so that the BPF program is parsed to SOCKET_FILTER type. The "missing BPF
> prog type" problem is solved.
>
> How to reproduce this error:
> $ cd samples/bpf
> $ sudo ./sockex3
> libbpf: prog 'bpf_func_PARSE_IP': missing BPF prog type, check ELF section name 'socket/3'
> libbpf: prog 'bpf_func_PARSE_IP': failed to load: -22
> libbpf: failed to load object './sockex3_kern.o'
> ERROR: loading BPF object file failed
>
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  samples/bpf/sockex3_kern.c | 95 ++++++++++++++++++++++----------------
>  samples/bpf/sockex3_user.c | 23 ++++-----
>  2 files changed, 64 insertions(+), 54 deletions(-)
>
> diff --git a/samples/bpf/sockex3_kern.c b/samples/bpf/sockex3_kern.c
> index b363503357e5..26d916834865 100644
> --- a/samples/bpf/sockex3_kern.c
> +++ b/samples/bpf/sockex3_kern.c
> @@ -17,47 +17,12 @@
>  #define IP_MF          0x2000
>  #define IP_OFFSET      0x1FFF
>
> -#define PROG(F) SEC("socket/"__stringify(F)) int bpf_func_##F
> -
> -struct {
> -       __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
> -       __uint(key_size, sizeof(u32));
> -       __uint(value_size, sizeof(u32));
> -       __uint(max_entries, 8);
> -} jmp_table SEC(".maps");
> -
>  #define PARSE_VLAN 1
>  #define PARSE_MPLS 2
>  #define PARSE_IP 3
>  #define PARSE_IPV6 4
>
> -/* Protocol dispatch routine. It tail-calls next BPF program depending
> - * on eth proto. Note, we could have used ...
> - *
> - *   bpf_tail_call(skb, &jmp_table, proto);
> - *
> - * ... but it would need large prog_array and cannot be optimised given
> - * the map key is not static.
> - */
> -static inline void parse_eth_proto(struct __sk_buff *skb, u32 proto)
> -{
> -       switch (proto) {
> -       case ETH_P_8021Q:
> -       case ETH_P_8021AD:
> -               bpf_tail_call(skb, &jmp_table, PARSE_VLAN);
> -               break;
> -       case ETH_P_MPLS_UC:
> -       case ETH_P_MPLS_MC:
> -               bpf_tail_call(skb, &jmp_table, PARSE_MPLS);
> -               break;
> -       case ETH_P_IP:
> -               bpf_tail_call(skb, &jmp_table, PARSE_IP);
> -               break;
> -       case ETH_P_IPV6:
> -               bpf_tail_call(skb, &jmp_table, PARSE_IPV6);
> -               break;
> -       }
> -}
> +#define PROG_SOCKET_FILTER     SEC("socket")

I dropped this and made SEC("socket") annotations explicit everywhere.
Applied to bpf-next, thank.

>
>  struct vlan_hdr {
>         __be16 h_vlan_TCI;
> @@ -74,6 +39,8 @@ struct flow_key_record {
>         __u32 ip_proto;
>  };
>

[...]
