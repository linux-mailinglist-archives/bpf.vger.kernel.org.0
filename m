Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B096187A7
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 19:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiKCSiR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 14:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiKCSiQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 14:38:16 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E17F61;
        Thu,  3 Nov 2022 11:38:15 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id y14so7652583ejd.9;
        Thu, 03 Nov 2022 11:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AdV60lwYNZHd1nY0aYC1vThK2Pv8MfHSq31cC6uqLnw=;
        b=K6vifuN+hyYqYGS7hup35yInLj34OLtWGhie3fL1HWrzRYZ4Pyw9WrQv+zwR9xaNvt
         EQ/QV8Tu02cnUS7kOoYiJ8+Psk5gXl8Sk64sAhIx+GY/zybTEVo/IRR/81CloH0b9wE1
         OLzqDx4+HvQZISclU1rYRlrM78nXlORNZmXv8+eEQ7kilblLpBXkwMKtlGEnYkSup7t5
         piWM6x7cY2cZxmZpLSZ+X6frGzhVWImwhujiiilkigtUmqvamsO9oBOY3IDOKOCtdtln
         mqi7dqAbTEfQrhRueb4ulqrYAcEt1QI9CeR6Lnx/cfIqbPS46tLdxRk2A/IrdfjYIwM+
         DkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AdV60lwYNZHd1nY0aYC1vThK2Pv8MfHSq31cC6uqLnw=;
        b=uo17gIli8GldREKM/FwNOMOakvPMYMZPuMjDokjeyqe+yuY3eMM27NNJ2lBajRweSi
         SQ+zxpKJV7/Mx2iYn+lCWYEO+Vbm8beM3xa8L5k3kqhtEkPSFeOdp69MrRi/94+3+2Xi
         g7WBcN5QpeeDqMX8e8FrXd1n92enk6xyxageWMF0d9+v/O0f+fTOATuWqUiTHM3ejzvh
         mCw/AWjhZYas0d7z8A2flC8Vg/a3Tm+ec7DfZNPZ/aHVTZV2Afz1hisHq5iU4r7at49R
         PEgqDW/F99BbICQsLpHTWhhwJV1RbSd0Mk/kat4DKSq4lggZuSf8xG25H4TXXOZ/bdfW
         e6LA==
X-Gm-Message-State: ACrzQf2W2LSMexcokwdJBTyl7FdzE0WjiLeFDJxpu2PElrtMTQyhFqjX
        eO+ET9bbJiDl+OQUXCwmpSG+kBS+vbCFlGqx2mM=
X-Google-Smtp-Source: AMsMyM6XqiSWJ8DfS6sbyPWxEdSJArp5SzDs76W8V+EpEBHcscgbmz7pW++nxedhmpvnNK8Kf4GsEvKzAh5nbg775xc=
X-Received: by 2002:a17:907:7214:b0:7ad:94cf:4a36 with SMTP id
 dr20-20020a170907721400b007ad94cf4a36mr30312331ejc.226.1667500694357; Thu, 03
 Nov 2022 11:38:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4Bza_6qND8iOuiur+xX0cBVkKJfKoJAOjihnVYRjoB3tWqw@mail.gmail.com>
 <tencent_7DD02046A8398BE3324F85E0F56ED41EB105@qq.com>
In-Reply-To: <tencent_7DD02046A8398BE3324F85E0F56ED41EB105@qq.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 3 Nov 2022 11:38:02 -0700
Message-ID: <CAEf4BzbvCABmSB3UqKyka=txTiCUdBpTtQg4X6XOa_qVVXW+hw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] samples/bpf: Fix sockex3: missing BPF prog type
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

On Sat, Oct 29, 2022 at 12:53 AM Rong Tao <rtoax@foxmail.com> wrote:
>
> From: Rong Tao <rongtao@cestc.cn>
>
> since commit 450b167fb9be("libbpf: clean up SEC() handling"),
> sec_def_matches() does not recognize "socket/xxx" as "socket", therefore,
> the BPF program type is not recognized, set "socket/xxx" to SOCKET_FILTER
> solves this error.
>
>  $ cd samples/bpf
>  $ sudo ./sockex3
>  libbpf: prog 'bpf_func_PARSE_IP': missing BPF prog type, check ELF section name 'socket/3'
>  libbpf: prog 'bpf_func_PARSE_IP': failed to load: -22
>  libbpf: failed to load object './sockex3_kern.o'
>  ERROR: loading BPF object file failed
>
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---

You need to do changes like this:

diff --git a/samples/bpf/sockex3_kern.c b/samples/bpf/sockex3_kern.c
index b363503357e5..db6a93e7ec53 100644
--- a/samples/bpf/sockex3_kern.c
+++ b/samples/bpf/sockex3_kern.c
@@ -17,7 +17,7 @@
 #define IP_MF          0x2000
 #define IP_OFFSET      0x1FFF

-#define PROG(F) SEC("socket/"__stringify(F)) int bpf_func_##F
+#define PROG(F) SEC("socket_filter") int bpf_func_##F

 struct {
        __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
@@ -279,7 +279,7 @@ PROG(PARSE_MPLS)(struct __sk_buff *skb)
        return 0;
 }

-SEC("socket/0")
+SEC("socket_filter")
 int main_prog(struct __sk_buff *skb)
 {
        __u32 nhoff = ETH_HLEN;


Why fixing up after the fact at runtime, if you can just make those
BPF programs conform to libbpf rules?



>  samples/bpf/sockex3_user.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/samples/bpf/sockex3_user.c b/samples/bpf/sockex3_user.c
> index cd6fa79df900..dc79c17ad195 100644
> --- a/samples/bpf/sockex3_user.c
> +++ b/samples/bpf/sockex3_user.c
> @@ -39,6 +39,9 @@ int main(int argc, char **argv)
>                 return 0;
>         }
>
> +       bpf_object__for_each_program(prog, obj)
> +               bpf_program__set_type(prog, BPF_PROG_TYPE_SOCKET_FILTER);
> +
>         /* load BPF program */
>         if (bpf_object__load(obj)) {
>                 fprintf(stderr, "ERROR: loading BPF object file failed\n");
> --
> 2.31.1
>
