Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4880A6C9F62
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 11:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbjC0Jac (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 05:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjC0Jab (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 05:30:31 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47EF3A92;
        Mon, 27 Mar 2023 02:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=NQ76cs9m2PfyRb1nvWbSz8Et10awSsHsXz4HNPXF8yg=; b=QZ9Vn6XQoPo/vkVnwWKgjNwNQF
        i+T6Yl3JETlALqU5VTD5LuRKWBkxlUZfMnccx1V/R8P1y1jb2Nn5vNn7qwhEJjK8c6CJnqa+IvXYv
        fSsK289ahjDc6UcYJ6PNuPJdYbA6zEy2NiIQ1OKZDK5Ou9RVm5ztS1GIL6bIVPQLOz4PR1pye5B0O
        3vVEIr7XrOnjpURdrjUhayo44zsagA6WzNAlLWxZihURKdHXLk/exMEpuHu1wCA+H5uKVfWFO4jHw
        sx55zP9IskZDpk3E1MCtVVDVaPNI846+iakQvvoZc3HFZinQFEwTulPbXBfyfpt6jwzMW6C0Vf0N7
        kIjdICDw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pgjAz-0007hb-0h; Mon, 27 Mar 2023 11:30:05 +0200
Received: from [219.59.88.22] (helo=localhost.localdomain)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pgjAw-000UQh-Hd; Mon, 27 Mar 2023 11:30:03 +0200
Subject: Re: [PATCH] loongarch/bpf: Fix bpf load failed with
 CONFIG_BPF_JIT_ALWAYS_ON, caused by jit (BPF_ST | BPF_NOSPEC) code
To:     George Guo <guodongtai@kylinos.cn>, chenhuacai@kernel.org,
        masahiroy@kernel.org, michal.lkml@markovi.net
Cc:     kernel@xen0n.name, ndesaulniers@google.com, ast@kernel.org,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, bpf@vger.kernel.org
References: <20230326044019.2139628-1-guodongtai@kylinos.cn>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c1932d0d-cf3f-5005-958d-7e08dddf42c9@iogearbox.net>
Date:   Mon, 27 Mar 2023 11:29:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230326044019.2139628-1-guodongtai@kylinos.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26856/Mon Mar 27 09:24:05 2023)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/26/23 6:40 AM, George Guo wrote:
> Here just skip the code(BPF_ST | BPF_NOSPEC) that has no couterpart to the loongarch.
> 
> To verify, use ltp testcase:
> 
> Without this patch:
> $ ./bpf_prog02
> ... ...
> bpf_common.c:123: TBROK: Failed verification: ??? (524)
> 
> Summary:
> passed   0
> failed   0
> broken   1
> skipped  0
> warnings 0
> 
> With this patch:
> $ ./bpf_prog02
> ... ...
> Summary:
> passed   0
> failed   0
> broken   0
> skipped  0
> warnings 0
> 
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
>   arch/loongarch/net/bpf_jit.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 288003a9f0ca..745d344385ed 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -1046,6 +1046,11 @@ static int build_body(struct jit_ctx *ctx, bool extra_pass)
>   		if (ctx->image == NULL)
>   			ctx->offset[i] = ctx->idx;
>   
> +		/* skip the code that has no couterpart to the host arch */
> +		if(insn->code == (BPF_ST | BPF_NOSPEC)) {
> +			continue;
> +		}

Small nit, but could we align with other JIT implementations and place it into similar
location for consistency? Above looks a bit out of place and it should really be part
of build_insn.

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 288003a9f0ca..d586df48ecc6 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1022,6 +1022,10 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
                 emit_atomic(insn, ctx);
                 break;

+       /* Speculation barrier */
+       case BPF_ST | BPF_NOSPEC:
+               break;
+
         default:
                 pr_err("bpf_jit: unknown opcode %02x\n", code);
                 return -EINVAL;

