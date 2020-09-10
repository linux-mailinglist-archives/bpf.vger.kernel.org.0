Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421AF264A6E
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 18:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgIJQ5J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 12:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbgIJQzd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Sep 2020 12:55:33 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DA8C061573
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 09:55:28 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id r7so4519282ybl.6
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 09:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=teNuOoheRuS/iRcn1NaxkoJeRdD9yOGJyatpx2davuM=;
        b=kBNfcic+s5wG0n7YO8bhsSgJeleZFRNZ4FBUjL4EUhoFN4XeeY5kbQ1SO/QFub6Z7c
         5cy+Pt1XYWfQbGnfyyF0Zc4SlHxbnV99uLWN8jXpH6HjA+EQzj6wgWOFO5vNVBN3M1hT
         teVdlRC1oMXX1JF7Ujl97uJhOelL6c8KyRomDS+ajSqqHT3MdQdAreTp0AbFiFk39UwJ
         BJVcA3YqEM8awPe6S7iUHUnOU5NdbI8YVPSO6uarhhYj0aFmELxXX8Qhm4LZ+hyRJhWv
         HRI+VgtaWmvoeA+Ea9/6D4MGqTQCUt/FBNc9cZ9ONmfqoJe+76dCRHFlymjA/25vVgky
         UK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=teNuOoheRuS/iRcn1NaxkoJeRdD9yOGJyatpx2davuM=;
        b=Z8vyDokFHgKf31MSK8wW4+Eze2a9XKXKnCDf2UfJ4f0ACB6L60nYhXWbpGAYxloo0C
         yBjmP+OG7JKJua5JndcPJydvbfEbU7wmp1Y2xaDg0nUi3XH477N0vcHmklqpDuRhSpMW
         nK/3/zHb3x9KD5fFxEFsaLBiohBiSxN5/pgL0iYW1Y7xgk9xtM/OoNFmvDlTS3IggovD
         VSOhA6FLB2DUliDhKF+rP9lZCij0I3zf4S1n5Lya354A8hl2YpH6co4MgcJuKmhhrNTb
         zMSHgW778vmjYHSra9vE+xXCPg6TU2QSKxAXSCYII+jJK3/ceUmhHS+kEu7VPz8bVonh
         ZZ6A==
X-Gm-Message-State: AOAM533o9tOAOLv9ce8ZMcUvJy/LGMB0pwlYyURcNBAi0cU82drIAxYq
        +nRAT9+Onm9s2rdMt2Fxc5gMMYj4B96GnSlL7AQ=
X-Google-Smtp-Source: ABdhPJykHxuU/mZfW/1puZC6vaTL4O9YkI7i+hTmM5tidzmDHyyZUYzTfO2Z4k7ZN2eqG0182aYbCQy4q16z+4eL4nk=
X-Received: by 2002:a25:ef43:: with SMTP id w3mr12692277ybm.230.1599756927875;
 Thu, 10 Sep 2020 09:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200909232443.3099637-1-iii@linux.ibm.com> <20200909232443.3099637-3-iii@linux.ibm.com>
In-Reply-To: <20200909232443.3099637-3-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 10 Sep 2020 09:55:16 -0700
Message-ID: <CAEf4BzYGbzwwDLAUdBB+fj1XYRFddOgUUYFAmUmq=jYpPAsaog@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: Fix endianness issues in sk_lookup/ctx_narrow_access
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Jakub Sitnicki <jakub@cloudflare.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 9, 2020 at 6:59 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> This test makes a lot of narrow load checks while assuming little
> endian architecture, and therefore fails on s390.
>
> Fix by introducing LSB and LSW macros and using them to perform narrow
> loads.
>
> Fixes: 0ab5539f8584 ("selftests/bpf: Tests for BPF_SK_LOOKUP attach point")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---

Jakub,

Can you please help review this to make sure no error accidentally slipped in?

>  .../selftests/bpf/progs/test_sk_lookup.c      | 264 ++++++++++--------
>  1 file changed, 149 insertions(+), 115 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/test_sk_lookup.c b/tools/testing/selftests/bpf/progs/test_sk_lookup.c
> index bbf8296f4d66..94e6d370967b 100644
> --- a/tools/testing/selftests/bpf/progs/test_sk_lookup.c
> +++ b/tools/testing/selftests/bpf/progs/test_sk_lookup.c
> @@ -19,6 +19,17 @@
>  #define IP6(aaaa, bbbb, cccc, dddd)                    \
>         { bpf_htonl(aaaa), bpf_htonl(bbbb), bpf_htonl(cccc), bpf_htonl(dddd) }
>
> +/* Macros for least-significant byte and word accesses. */
> +#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
> +#define LSE_INDEX(index, size) (index)
> +#else
> +#define LSE_INDEX(index, size) ((size) - (index) - 1)
> +#endif
> +#define LSB(value, index)                              \
> +       (((__u8 *)&(value))[LSE_INDEX((index), sizeof(value))])
> +#define LSW(value, index)                              \
> +       (((__u16 *)&(value))[LSE_INDEX((index), sizeof(value) / 2)])
> +
>  #define MAX_SOCKS 32
>
>  struct {
> @@ -369,171 +380,194 @@ int ctx_narrow_access(struct bpf_sk_lookup *ctx)
>  {
>         struct bpf_sock *sk;
>         int err, family;
> -       __u16 *half;
> -       __u8 *byte;
>         bool v4;
>
>         v4 = (ctx->family == AF_INET);
>
>         /* Narrow loads from family field */
> -       byte = (__u8 *)&ctx->family;
> -       half = (__u16 *)&ctx->family;
> -       if (byte[0] != (v4 ? AF_INET : AF_INET6) ||
> -           byte[1] != 0 || byte[2] != 0 || byte[3] != 0)
> +       if (LSB(ctx->family, 0) != (v4 ? AF_INET : AF_INET6) ||
> +           LSB(ctx->family, 1) != 0 || LSB(ctx->family, 2) != 0 ||
> +           LSB(ctx->family, 3) != 0)
>                 return SK_DROP;
> -       if (half[0] != (v4 ? AF_INET : AF_INET6))
> +       if (LSW(ctx->family, 0) != (v4 ? AF_INET : AF_INET6))
>                 return SK_DROP;
>
> -       byte = (__u8 *)&ctx->protocol;
> -       if (byte[0] != IPPROTO_TCP ||
> -           byte[1] != 0 || byte[2] != 0 || byte[3] != 0)
> +       /* Narrow loads from protocol field */
> +       if (LSB(ctx->protocol, 0) != IPPROTO_TCP ||
> +           LSB(ctx->protocol, 1) != 0 || LSB(ctx->protocol, 2) != 0 ||
> +           LSB(ctx->protocol, 3) != 0)
>                 return SK_DROP;
> -       half = (__u16 *)&ctx->protocol;
> -       if (half[0] != IPPROTO_TCP)
> +       if (LSW(ctx->protocol, 0) != IPPROTO_TCP)
>                 return SK_DROP;
>
>         /* Narrow loads from remote_port field. Expect non-0 value. */
> -       byte = (__u8 *)&ctx->remote_port;
> -       if (byte[0] == 0 && byte[1] == 0 && byte[2] == 0 && byte[3] == 0)
> +       if (LSB(ctx->remote_port, 0) == 0 && LSB(ctx->remote_port, 1) == 0 &&
> +           LSB(ctx->remote_port, 2) == 0 && LSB(ctx->remote_port, 3) == 0)
>                 return SK_DROP;
> -       half = (__u16 *)&ctx->remote_port;
> -       if (half[0] == 0)
> +       if (LSW(ctx->remote_port, 0) == 0)
>                 return SK_DROP;
>
>         /* Narrow loads from local_port field. Expect DST_PORT. */
> -       byte = (__u8 *)&ctx->local_port;
> -       if (byte[0] != ((DST_PORT >> 0) & 0xff) ||
> -           byte[1] != ((DST_PORT >> 8) & 0xff) ||
> -           byte[2] != 0 || byte[3] != 0)
> +       if (LSB(ctx->local_port, 0) != ((DST_PORT >> 0) & 0xff) ||
> +           LSB(ctx->local_port, 1) != ((DST_PORT >> 8) & 0xff) ||
> +           LSB(ctx->local_port, 2) != 0 || LSB(ctx->local_port, 3) != 0)
>                 return SK_DROP;
> -       half = (__u16 *)&ctx->local_port;
> -       if (half[0] != DST_PORT)
> +       if (LSW(ctx->local_port, 0) != DST_PORT)
>                 return SK_DROP;
>
>         /* Narrow loads from IPv4 fields */
>         if (v4) {
>                 /* Expect non-0.0.0.0 in remote_ip4 */
> -               byte = (__u8 *)&ctx->remote_ip4;
> -               if (byte[0] == 0 && byte[1] == 0 &&
> -                   byte[2] == 0 && byte[3] == 0)
> +               if (LSB(ctx->remote_ip4, 0) == 0 &&
> +                   LSB(ctx->remote_ip4, 1) == 0 &&
> +                   LSB(ctx->remote_ip4, 2) == 0 &&
> +                   LSB(ctx->remote_ip4, 3) == 0)
>                         return SK_DROP;
> -               half = (__u16 *)&ctx->remote_ip4;
> -               if (half[0] == 0 && half[1] == 0)
> +               if (LSW(ctx->remote_ip4, 0) == 0 &&
> +                   LSW(ctx->remote_ip4, 1) == 0)
>                         return SK_DROP;
>
>                 /* Expect DST_IP4 in local_ip4 */
> -               byte = (__u8 *)&ctx->local_ip4;
> -               if (byte[0] != ((DST_IP4 >>  0) & 0xff) ||
> -                   byte[1] != ((DST_IP4 >>  8) & 0xff) ||
> -                   byte[2] != ((DST_IP4 >> 16) & 0xff) ||
> -                   byte[3] != ((DST_IP4 >> 24) & 0xff))
> +               if (LSB(ctx->local_ip4, 0) != ((DST_IP4 >> 0) & 0xff) ||
> +                   LSB(ctx->local_ip4, 1) != ((DST_IP4 >> 8) & 0xff) ||
> +                   LSB(ctx->local_ip4, 2) != ((DST_IP4 >> 16) & 0xff) ||
> +                   LSB(ctx->local_ip4, 3) != ((DST_IP4 >> 24) & 0xff))
>                         return SK_DROP;
> -               half = (__u16 *)&ctx->local_ip4;
> -               if (half[0] != ((DST_IP4 >>  0) & 0xffff) ||
> -                   half[1] != ((DST_IP4 >> 16) & 0xffff))
> +               if (LSW(ctx->local_ip4, 0) != ((DST_IP4 >> 0) & 0xffff) ||
> +                   LSW(ctx->local_ip4, 1) != ((DST_IP4 >> 16) & 0xffff))
>                         return SK_DROP;
>         } else {
>                 /* Expect 0.0.0.0 IPs when family != AF_INET */
> -               byte = (__u8 *)&ctx->remote_ip4;
> -               if (byte[0] != 0 || byte[1] != 0 &&
> -                   byte[2] != 0 || byte[3] != 0)
> +               if (LSB(ctx->remote_ip4, 0) != 0 ||
> +                   LSB(ctx->remote_ip4, 1) != 0 ||
> +                   LSB(ctx->remote_ip4, 2) != 0 ||
> +                   LSB(ctx->remote_ip4, 3) != 0)
>                         return SK_DROP;
> -               half = (__u16 *)&ctx->remote_ip4;
> -               if (half[0] != 0 || half[1] != 0)
> +               if (LSW(ctx->remote_ip4, 0) != 0 ||
> +                   LSW(ctx->remote_ip4, 1) != 0)
>                         return SK_DROP;
>
> -               byte = (__u8 *)&ctx->local_ip4;
> -               if (byte[0] != 0 || byte[1] != 0 &&
> -                   byte[2] != 0 || byte[3] != 0)
> +               if (LSB(ctx->local_ip4, 0) != 0 ||
> +                   LSB(ctx->local_ip4, 1) != 0 ||
> +                   LSB(ctx->local_ip4, 2) != 0 || LSB(ctx->local_ip4, 3) != 0)
>                         return SK_DROP;
> -               half = (__u16 *)&ctx->local_ip4;
> -               if (half[0] != 0 || half[1] != 0)
> +               if (LSW(ctx->local_ip4, 0) != 0 || LSW(ctx->local_ip4, 1) != 0)
>                         return SK_DROP;
>         }
>
>         /* Narrow loads from IPv6 fields */
>         if (!v4) {
> -               /* Expenct non-:: IP in remote_ip6 */
> -               byte = (__u8 *)&ctx->remote_ip6;
> -               if (byte[0] == 0 && byte[1] == 0 &&
> -                   byte[2] == 0 && byte[3] == 0 &&
> -                   byte[4] == 0 && byte[5] == 0 &&
> -                   byte[6] == 0 && byte[7] == 0 &&
> -                   byte[8] == 0 && byte[9] == 0 &&
> -                   byte[10] == 0 && byte[11] == 0 &&
> -                   byte[12] == 0 && byte[13] == 0 &&
> -                   byte[14] == 0 && byte[15] == 0)
> +               /* Expect non-:: IP in remote_ip6 */
> +               if (LSB(ctx->remote_ip6[0], 0) == 0 &&
> +                   LSB(ctx->remote_ip6[0], 1) == 0 &&
> +                   LSB(ctx->remote_ip6[0], 2) == 0 &&
> +                   LSB(ctx->remote_ip6[0], 3) == 0 &&
> +                   LSB(ctx->remote_ip6[1], 0) == 0 &&
> +                   LSB(ctx->remote_ip6[1], 1) == 0 &&
> +                   LSB(ctx->remote_ip6[1], 2) == 0 &&
> +                   LSB(ctx->remote_ip6[1], 3) == 0 &&
> +                   LSB(ctx->remote_ip6[2], 0) == 0 &&
> +                   LSB(ctx->remote_ip6[2], 1) == 0 &&
> +                   LSB(ctx->remote_ip6[2], 2) == 0 &&
> +                   LSB(ctx->remote_ip6[2], 3) == 0 &&
> +                   LSB(ctx->remote_ip6[3], 0) == 0 &&
> +                   LSB(ctx->remote_ip6[3], 1) == 0 &&
> +                   LSB(ctx->remote_ip6[3], 2) == 0 &&
> +                   LSB(ctx->remote_ip6[3], 3) == 0)
>                         return SK_DROP;
> -               half = (__u16 *)&ctx->remote_ip6;
> -               if (half[0] == 0 && half[1] == 0 &&
> -                   half[2] == 0 && half[3] == 0 &&
> -                   half[4] == 0 && half[5] == 0 &&
> -                   half[6] == 0 && half[7] == 0)
> +               if (LSW(ctx->remote_ip6[0], 0) == 0 &&
> +                   LSW(ctx->remote_ip6[0], 1) == 0 &&
> +                   LSW(ctx->remote_ip6[1], 0) == 0 &&
> +                   LSW(ctx->remote_ip6[1], 1) == 0 &&
> +                   LSW(ctx->remote_ip6[2], 0) == 0 &&
> +                   LSW(ctx->remote_ip6[2], 1) == 0 &&
> +                   LSW(ctx->remote_ip6[3], 0) == 0 &&
> +                   LSW(ctx->remote_ip6[3], 1) == 0)
>                         return SK_DROP;
> -
>                 /* Expect DST_IP6 in local_ip6 */
> -               byte = (__u8 *)&ctx->local_ip6;
> -               if (byte[0] != ((DST_IP6[0] >>  0) & 0xff) ||
> -                   byte[1] != ((DST_IP6[0] >>  8) & 0xff) ||
> -                   byte[2] != ((DST_IP6[0] >> 16) & 0xff) ||
> -                   byte[3] != ((DST_IP6[0] >> 24) & 0xff) ||
> -                   byte[4] != ((DST_IP6[1] >>  0) & 0xff) ||
> -                   byte[5] != ((DST_IP6[1] >>  8) & 0xff) ||
> -                   byte[6] != ((DST_IP6[1] >> 16) & 0xff) ||
> -                   byte[7] != ((DST_IP6[1] >> 24) & 0xff) ||
> -                   byte[8] != ((DST_IP6[2] >>  0) & 0xff) ||
> -                   byte[9] != ((DST_IP6[2] >>  8) & 0xff) ||
> -                   byte[10] != ((DST_IP6[2] >> 16) & 0xff) ||
> -                   byte[11] != ((DST_IP6[2] >> 24) & 0xff) ||
> -                   byte[12] != ((DST_IP6[3] >>  0) & 0xff) ||
> -                   byte[13] != ((DST_IP6[3] >>  8) & 0xff) ||
> -                   byte[14] != ((DST_IP6[3] >> 16) & 0xff) ||
> -                   byte[15] != ((DST_IP6[3] >> 24) & 0xff))
> +               if (LSB(ctx->local_ip6[0], 0) != ((DST_IP6[0] >> 0) & 0xff) ||
> +                   LSB(ctx->local_ip6[0], 1) != ((DST_IP6[0] >> 8) & 0xff) ||
> +                   LSB(ctx->local_ip6[0], 2) != ((DST_IP6[0] >> 16) & 0xff) ||
> +                   LSB(ctx->local_ip6[0], 3) != ((DST_IP6[0] >> 24) & 0xff) ||
> +                   LSB(ctx->local_ip6[1], 0) != ((DST_IP6[1] >> 0) & 0xff) ||
> +                   LSB(ctx->local_ip6[1], 1) != ((DST_IP6[1] >> 8) & 0xff) ||
> +                   LSB(ctx->local_ip6[1], 2) != ((DST_IP6[1] >> 16) & 0xff) ||
> +                   LSB(ctx->local_ip6[1], 3) != ((DST_IP6[1] >> 24) & 0xff) ||
> +                   LSB(ctx->local_ip6[2], 0) != ((DST_IP6[2] >> 0) & 0xff) ||
> +                   LSB(ctx->local_ip6[2], 1) != ((DST_IP6[2] >> 8) & 0xff) ||
> +                   LSB(ctx->local_ip6[2], 2) != ((DST_IP6[2] >> 16) & 0xff) ||
> +                   LSB(ctx->local_ip6[2], 3) != ((DST_IP6[2] >> 24) & 0xff) ||
> +                   LSB(ctx->local_ip6[3], 0) != ((DST_IP6[3] >> 0) & 0xff) ||
> +                   LSB(ctx->local_ip6[3], 1) != ((DST_IP6[3] >> 8) & 0xff) ||
> +                   LSB(ctx->local_ip6[3], 2) != ((DST_IP6[3] >> 16) & 0xff) ||
> +                   LSB(ctx->local_ip6[3], 3) != ((DST_IP6[3] >> 24) & 0xff))
>                         return SK_DROP;
> -               half = (__u16 *)&ctx->local_ip6;
> -               if (half[0] != ((DST_IP6[0] >>  0) & 0xffff) ||
> -                   half[1] != ((DST_IP6[0] >> 16) & 0xffff) ||
> -                   half[2] != ((DST_IP6[1] >>  0) & 0xffff) ||
> -                   half[3] != ((DST_IP6[1] >> 16) & 0xffff) ||
> -                   half[4] != ((DST_IP6[2] >>  0) & 0xffff) ||
> -                   half[5] != ((DST_IP6[2] >> 16) & 0xffff) ||
> -                   half[6] != ((DST_IP6[3] >>  0) & 0xffff) ||
> -                   half[7] != ((DST_IP6[3] >> 16) & 0xffff))
> +               if (LSW(ctx->local_ip6[0], 0) != ((DST_IP6[0] >> 0) & 0xffff) ||
> +                   LSW(ctx->local_ip6[0], 1) !=
> +                           ((DST_IP6[0] >> 16) & 0xffff) ||
> +                   LSW(ctx->local_ip6[1], 0) != ((DST_IP6[1] >> 0) & 0xffff) ||
> +                   LSW(ctx->local_ip6[1], 1) !=
> +                           ((DST_IP6[1] >> 16) & 0xffff) ||
> +                   LSW(ctx->local_ip6[2], 0) != ((DST_IP6[2] >> 0) & 0xffff) ||
> +                   LSW(ctx->local_ip6[2], 1) !=
> +                           ((DST_IP6[2] >> 16) & 0xffff) ||
> +                   LSW(ctx->local_ip6[3], 0) != ((DST_IP6[3] >> 0) & 0xffff) ||
> +                   LSW(ctx->local_ip6[3], 1) != ((DST_IP6[3] >> 16) & 0xffff))
>                         return SK_DROP;
>         } else {
>                 /* Expect :: IPs when family != AF_INET6 */
> -               byte = (__u8 *)&ctx->remote_ip6;
> -               if (byte[0] != 0 || byte[1] != 0 ||
> -                   byte[2] != 0 || byte[3] != 0 ||
> -                   byte[4] != 0 || byte[5] != 0 ||
> -                   byte[6] != 0 || byte[7] != 0 ||
> -                   byte[8] != 0 || byte[9] != 0 ||
> -                   byte[10] != 0 || byte[11] != 0 ||
> -                   byte[12] != 0 || byte[13] != 0 ||
> -                   byte[14] != 0 || byte[15] != 0)
> +               if (LSB(ctx->remote_ip6[0], 0) != 0 ||
> +                   LSB(ctx->remote_ip6[0], 1) != 0 ||
> +                   LSB(ctx->remote_ip6[0], 2) != 0 ||
> +                   LSB(ctx->remote_ip6[0], 3) != 0 ||
> +                   LSB(ctx->remote_ip6[1], 0) != 0 ||
> +                   LSB(ctx->remote_ip6[1], 1) != 0 ||
> +                   LSB(ctx->remote_ip6[1], 2) != 0 ||
> +                   LSB(ctx->remote_ip6[1], 3) != 0 ||
> +                   LSB(ctx->remote_ip6[2], 0) != 0 ||
> +                   LSB(ctx->remote_ip6[2], 1) != 0 ||
> +                   LSB(ctx->remote_ip6[2], 2) != 0 ||
> +                   LSB(ctx->remote_ip6[2], 3) != 0 ||
> +                   LSB(ctx->remote_ip6[3], 0) != 0 ||
> +                   LSB(ctx->remote_ip6[3], 1) != 0 ||
> +                   LSB(ctx->remote_ip6[3], 2) != 0 ||
> +                   LSB(ctx->remote_ip6[3], 3) != 0)
>                         return SK_DROP;
> -               half = (__u16 *)&ctx->remote_ip6;
> -               if (half[0] != 0 || half[1] != 0 ||
> -                   half[2] != 0 || half[3] != 0 ||
> -                   half[4] != 0 || half[5] != 0 ||
> -                   half[6] != 0 || half[7] != 0)
> +               if (LSW(ctx->remote_ip6[0], 0) != 0 ||
> +                   LSW(ctx->remote_ip6[0], 1) != 0 ||
> +                   LSW(ctx->remote_ip6[1], 0) != 0 ||
> +                   LSW(ctx->remote_ip6[1], 1) != 0 ||
> +                   LSW(ctx->remote_ip6[2], 0) != 0 ||
> +                   LSW(ctx->remote_ip6[2], 1) != 0 ||
> +                   LSW(ctx->remote_ip6[3], 0) != 0 ||
> +                   LSW(ctx->remote_ip6[3], 1) != 0)
>                         return SK_DROP;
>
> -               byte = (__u8 *)&ctx->local_ip6;
> -               if (byte[0] != 0 || byte[1] != 0 ||
> -                   byte[2] != 0 || byte[3] != 0 ||
> -                   byte[4] != 0 || byte[5] != 0 ||
> -                   byte[6] != 0 || byte[7] != 0 ||
> -                   byte[8] != 0 || byte[9] != 0 ||
> -                   byte[10] != 0 || byte[11] != 0 ||
> -                   byte[12] != 0 || byte[13] != 0 ||
> -                   byte[14] != 0 || byte[15] != 0)
> +               if (LSB(ctx->local_ip6[0], 0) != 0 ||
> +                   LSB(ctx->local_ip6[0], 1) != 0 ||
> +                   LSB(ctx->local_ip6[0], 2) != 0 ||
> +                   LSB(ctx->local_ip6[0], 3) != 0 ||
> +                   LSB(ctx->local_ip6[1], 0) != 0 ||
> +                   LSB(ctx->local_ip6[1], 1) != 0 ||
> +                   LSB(ctx->local_ip6[1], 2) != 0 ||
> +                   LSB(ctx->local_ip6[1], 3) != 0 ||
> +                   LSB(ctx->local_ip6[2], 0) != 0 ||
> +                   LSB(ctx->local_ip6[2], 1) != 0 ||
> +                   LSB(ctx->local_ip6[2], 2) != 0 ||
> +                   LSB(ctx->local_ip6[2], 3) != 0 ||
> +                   LSB(ctx->local_ip6[3], 0) != 0 ||
> +                   LSB(ctx->local_ip6[3], 1) != 0 ||
> +                   LSB(ctx->local_ip6[3], 2) != 0 ||
> +                   LSB(ctx->local_ip6[3], 3) != 0)
>                         return SK_DROP;
> -               half = (__u16 *)&ctx->local_ip6;
> -               if (half[0] != 0 || half[1] != 0 ||
> -                   half[2] != 0 || half[3] != 0 ||
> -                   half[4] != 0 || half[5] != 0 ||
> -                   half[6] != 0 || half[7] != 0)
> +               if (LSW(ctx->remote_ip6[0], 0) != 0 ||
> +                   LSW(ctx->remote_ip6[0], 1) != 0 ||
> +                   LSW(ctx->remote_ip6[1], 0) != 0 ||
> +                   LSW(ctx->remote_ip6[1], 1) != 0 ||
> +                   LSW(ctx->remote_ip6[2], 0) != 0 ||
> +                   LSW(ctx->remote_ip6[2], 1) != 0 ||
> +                   LSW(ctx->remote_ip6[3], 0) != 0 ||
> +                   LSW(ctx->remote_ip6[3], 1) != 0)
>                         return SK_DROP;
>         }
>
> --
> 2.25.4
>
