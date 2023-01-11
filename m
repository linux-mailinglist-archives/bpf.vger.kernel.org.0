Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36202665F9E
	for <lists+bpf@lfdr.de>; Wed, 11 Jan 2023 16:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239381AbjAKPtV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Jan 2023 10:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239709AbjAKPst (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Jan 2023 10:48:49 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C6F3591F
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 07:48:22 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id v19so9550325ybv.1
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 07:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oWXiKk5N76ghcPrYpnrhpW08LqZySwOUdbWXIWHxWBc=;
        b=qR342MVgAspa6C1TGx9WVz/1cYTR+YeR9HoTjGffZVND8qcg0OHq1J72TpetAu/HNB
         2+THEqpRejnwna90MXpyOp+3/Fq5W3DoyrAJXBN8J5ZKYln64yVWUF+e+sCKAAQOA9FS
         Y8oRW47E3kdekVshbys8cs51Aqrvo0DHbYOJIUC77x9un0wFiOlZNPemabshL4Uw/Efa
         DnD3DpuEsWOuFNLaJHV6GMdqfeTOBbbhOT3+yMY8eMnNKIMN5odanWwDQ4VVdUg6g+rM
         9N45sETfK9LWUw9RKUly2uvsCuKP+eTCDjm8juuwwOpDcWz9unkBXfM1cRdQ1qzufKTs
         Dn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oWXiKk5N76ghcPrYpnrhpW08LqZySwOUdbWXIWHxWBc=;
        b=crlEEqhN73tLrsIcPUq6fcWRYjMDUkA6vJj6jjNUHohhV00oZ3Q51MYU4dY5Plv2vF
         W38kTItWtoHoA4ZHKCrSHFv2hevI4+jUxnEuB3OmBH+eOtc0M9FoR2Wccs752QUTTQnC
         D7jI899s5zdDRk8QeqR1soSv6SF8qTgmJ5GZp041lhqDIqdK3bSUGvvUpcFRzYUwz3Xm
         pwFZhMB57R7CY1oBFEESfYJ1TJdxkdtFOF3+KZ2B+eqAEmBiwE7dYJGAWL5r5uGHZrNw
         th0vdkhZ2uOmvNQJO6qxEsinXTzruhv6/OB14tJJvfeZgLDdmcwzE+YjdzXQCVJg1gZV
         gzBA==
X-Gm-Message-State: AFqh2kot/8YiBC01SoFwMRAJ8fc0TLSpRM6y+5HWm5y6zYWTUjfoH5RU
        75Xvbx4wb1ATOjG+Eoey4Z0tx90Hx2yg9AmO1Rf4Pw==
X-Google-Smtp-Source: AMrXdXuLnT+5i/eyQN5Bm5ScZRY47Yc3QKQd7ZWRW6c++xS955xVHS85ngwXh95gH7UiKLtX+r+Hq3+gByBM2HOGy9w=
X-Received: by 2002:a25:7288:0:b0:78e:9ffb:6421 with SMTP id
 n130-20020a257288000000b0078e9ffb6421mr5641227ybc.95.1673452101328; Wed, 11
 Jan 2023 07:48:21 -0800 (PST)
MIME-Version: 1.0
References: <cover.1673423199.git.william.xuanziyang@huawei.com> <ec692898c848256540d146b76a3e239914453293.1673423199.git.william.xuanziyang@huawei.com>
In-Reply-To: <ec692898c848256540d146b76a3e239914453293.1673423199.git.william.xuanziyang@huawei.com>
From:   Willem de Bruijn <willemb@google.com>
Date:   Wed, 11 Jan 2023 10:47:44 -0500
Message-ID: <CA+FuTSe+YJcyDV8S-PAzceLe4kNe-ZTZ+JpqpFkSmYfASv27Ug@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: add ipip6 and ip6ip decap
 to test_tc_tunnel
To:     Ziyang Xuan <william.xuanziyang@huawei.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Jan 11, 2023 at 3:02 AM Ziyang Xuan
<william.xuanziyang@huawei.com> wrote:
>
> Add ipip6 and ip6ip decap testcases. Verify that bpf_skb_adjust_room()
> correctly decapsulate ipip6 and ip6ip tunnel packets.
>
> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
> ---
>  .../selftests/bpf/progs/test_tc_tunnel.c      | 91 ++++++++++++++++++-
>  tools/testing/selftests/bpf/test_tc_tunnel.sh | 15 +--
>  2 files changed, 98 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
> index a0e7762b1e5a..e6e678aa9874 100644
> --- a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
> +++ b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
> @@ -38,6 +38,10 @@ static const int cfg_udp_src = 20000;
>  #define        VXLAN_FLAGS     0x8
>  #define        VXLAN_VNI       1
>
> +#ifndef NEXTHDR_DEST
> +#define NEXTHDR_DEST   60
> +#endif

Should not be needed if including the right header? include/net/ipv6.h

Otherwise very nice extension. Thanks for expanding the test.
