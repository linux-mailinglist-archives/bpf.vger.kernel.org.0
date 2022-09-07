Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EB15B0DDE
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 22:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiIGUNE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 16:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiIGUND (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 16:13:03 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D182CC0E72
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 13:13:01 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id dv25so3654030ejb.12
        for <bpf@vger.kernel.org>; Wed, 07 Sep 2022 13:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=/cqJlV0sE8kwmWT8dlmpA2i/xUkjsGME1Uaxd/mqJQ8=;
        b=M3TcQSllXaiQXG3sJT+anH6I3IEKrSAB0rv5x4BdBhwG4ITipJbDMHCRKNhXJU4NeM
         Z8zeFv2Ddqd1+h43eF36xv5DOlIhB7YgUV3ADhRuBiXPwsEJDxsoa/LVgeL8BGpWRi4Z
         8Vzjv1CPqBCysPbtq9VMdniVdhPnQ68+TphNp+6XqdBaxq6ZITnW9uNehJd1GfwDa2Q0
         /Nb3OPv/4fDj+1i2hwnjy+pyxnzTtMmaScBPbceirukRZzZUEyqSSalUENz/BcXgfHNq
         aGQBNG8fpcepgH1WlaVX5ousQLyrh2Cz1mNPVM1uBjljlgG17a+nsmT3iIQJmUltJgeL
         IF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=/cqJlV0sE8kwmWT8dlmpA2i/xUkjsGME1Uaxd/mqJQ8=;
        b=xCON7ZiRg+9cJWby4JlrzculNfR/qC2Hub10K4/B81aJNRBg40c7ybAT9QGOULKaJl
         8NjwN3BLwlixdXTdygdZ0uOxlIH8UOvMA7WSdz63ouGDnBI9bmCaMOqdKsVNgYjKu8kQ
         g0vNF15xFM616WSIBuO+8EXAYXRKieHNVKUP5Dgt/HK8HW75VLcZNd0DVYwpc6Qu9hru
         t1kwafvv8izC5Fyk5dD+dN+Q5QgaYUHef2Q22MHrOlJ/XHQ7gIB1g3YqMbJO3PYLhQ+/
         fDiLbpX43RetE0IGL2vBh9e1HEC3M8NlUp1ci1HhTGe1hT32IveplYb3lr8HLXa1WB/P
         /57Q==
X-Gm-Message-State: ACgBeo3MK5FE2x0EtPHLUTLgulNWmtpEmM0YEhV4/IumVJSP8Sb8Brfj
        XRsrPEpgEYR++t9mCa4nRHt+xdyJfr/6S4/I4cU=
X-Google-Smtp-Source: AA6agR7xBlNmu73YTfIlAvLXuaOqMSw874LPD8w7dIe5m0DQ/JJYrP33JTeZ6qgMOzRp2qFc1+uoCH61oXMGdZakSYE=
X-Received: by 2002:a17:907:3f15:b0:741:7ab9:1c5a with SMTP id
 hq21-20020a1709073f1500b007417ab91c5amr3354978ejc.369.1662581580202; Wed, 07
 Sep 2022 13:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220831233615.2288256-1-harshmodi@google.com>
In-Reply-To: <20220831233615.2288256-1-harshmodi@google.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Wed, 7 Sep 2022 13:12:49 -0700
Message-ID: <CAJnrk1ZVbczXnJrd7NH-q6CV10eu5FytTgrGX_3SC_+G59P73Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add bpf_[skb|xdp]_packet_hash.
To:     Harsh Modi <harshmodi@google.com>
Cc:     bpf@vger.kernel.org, sdf@google.com, ast@kernel.org,
        haoluo@google.com, quentin@isovalent.com, joe@cilium.io
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

On Wed, Aug 31, 2022 at 4:36 PM Harsh Modi <harshmodi@google.com> wrote:
>
> eBPF currently does not have a good way to support more advanced
> checksums like crc32c checksums. A bpf helper that allows users
> to hash packet data from eBPF will use this.
>
> Currently, it only supports crc32c, however, additional support for
> new hashes can be supported by adding an additional enum and
> implementing the corresponding code in net/core/filter.c.
>
> Signed-off-by: Harsh Modi <harshmodi@google.com>
> ---
>  include/net/xdp.h                             |   3 +
>  include/uapi/linux/bpf.h                      |  33 ++++
>  net/core/filter.c                             | 100 +++++++++++
>  net/core/xdp.c                                |  51 ++++++
>  scripts/bpf_doc.py                            |   2 +
>  tools/include/uapi/linux/bpf.h                |  33 ++++
>  .../selftests/bpf/prog_tests/packet_hash.c    | 159 ++++++++++++++++++
>  .../testing/selftests/bpf/progs/packet_hash.c | 125 ++++++++++++++
>  8 files changed, 506 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/packet_hash.c
>  create mode 100644 tools/testing/selftests/bpf/progs/packet_hash.c
>
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 04c852c7a77f..cbfec47e391d 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -407,6 +407,9 @@ struct netdev_bpf;
>  void xdp_attachment_setup(struct xdp_attachment_info *info,
>                           struct netdev_bpf *bpf);
>
> +__wsum __xdp_checksum(struct xdp_buff *xdp, int offset, int len,
> +                     __wsum csum, const struct skb_checksum_ops *ops);
> +
>  #define DEV_MAP_BULK_SIZE XDP_BULK_QUEUE_SIZE
>
>  #endif /* __LINUX_NET_XDP_H__ */
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 962960a98835..c8313a13a948 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5386,6 +5386,25 @@ union bpf_attr {
>   *     Return
>   *             Current *ktime*.
>   *
> + * int bpf_skb_packet_hash(struct sk_buff *skb, struct bpf_packet_hash_params *params, void *hash, u32 len)
> + *     Description
> + *             Hash the packet data based on the parameters set in *params*.
> + *             The hash will be set in *hash*. The value of *len* will be
> + *             dependent on the hash algorithm.
> + *             Currently only crc32c is supported.
> + *
> + *     Return
> + *             0 on success, or negative errno if there is an error.
> + *
> + * int bpf_xdp_packet_hash(struct xdp_buff *xdp, struct bpf_packet_hash_params *params, void *hash, u32 len)
> + *     Description
> + *             Hash the packet data based on the parameters set in *params*.
> + *             The hash will be set in *hash*. The value of *len* will be
> + *             dependent on the hash algorithm.
> + *             Currently only crc32c is supported.
> + *
> + *     Return
> + *             0 on success, or negative errno if there is an error.
>   */

What are your thoughts on having a more generic hashing helper? I'm
thinking about something like

bpf_dynptr_hash(enum bpf_hash hash_type, struct bpf_dynptr src, struct
bpf_dynptr dst, u64 flags);

where this helper would extend easily to other cases as well (for
example, to malloc-type dynpts) instead of needing multiple helpers.


>  #define __BPF_FUNC_MAPPER(FN)          \
>         FN(unspec),                     \
> @@ -5597,6 +5616,8 @@ union bpf_attr {
>         FN(tcp_raw_check_syncookie_ipv4),       \
>         FN(tcp_raw_check_syncookie_ipv6),       \
>         FN(ktime_get_tai_ns),           \
> +       FN(skb_packet_hash),            \
> +       FN(xdp_packet_hash),            \
>         /* */
[...]
> --
> 2.37.2.672.g94769d06f0-goog
>
