Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC076CB7E6
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 09:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjC1HWs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 03:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjC1HWr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 03:22:47 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EB12D71;
        Tue, 28 Mar 2023 00:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=ESpFu/zHckpILn58+li2ydE8LBfBNpBi5fiR8Kg6sWY=; b=IxAXQFy0FQQAdQdTKk0mKYpnX9
        lEAapQeoTCVHKu4trvRm9noBGFumbVqWSVsdq2aPD34GcQCTizaZE8i0g16VgZleOjcDXXksjHzZo
        ylFc29DahNprPh65xXF0cejoqUrtoipyVK2UsrURMWXrQzP/TRJ+yF0/ui0jXqQ6AXW3vTso1SNMc
        AArdXJaCVanUlojfI6a4CIVWGE4eb1k53i88UighbkijvX8GBaw6SGzHYmpavT+zls2awasMGhtCk
        FHu4nuvi7+wmIriAu+g7Vd09x5ajHio3hleiji1e5O1JlF/Ge2nfvCedWm+AJFrjxLtusVU4Y6eF4
        wwSqOKAQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1ph3f8-0006AP-Ej; Tue, 28 Mar 2023 09:22:34 +0200
Received: from [219.59.88.22] (helo=localhost.localdomain)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1ph3f7-000RIq-JV; Tue, 28 Mar 2023 09:22:34 +0200
Subject: Re: [PATCH v2] loongarch/bpf: Skip speculation barrier opcode, which
 caused ltp testcase bpf_prog02 to fail
To:     George Guo <guodongtai@kylinos.cn>
Cc:     ast@kernel.org, bpf@vger.kernel.org, chenhuacai@kernel.org,
        kernel@xen0n.name, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        masahiroy@kernel.org, michal.lkml@markovi.net,
        ndesaulniers@google.com, hengqi.chen@gmail.com,
        yangtiezhu@loongson.cn, tangyouling@loongson.cn
References: <c1932d0d-cf3f-5005-958d-7e08dddf42c9@iogearbox.net>
 <20230328071335.2664966-1-guodongtai@kylinos.cn>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ddb2f552-252f-4533-469b-31044b4fc2d6@iogearbox.net>
Date:   Tue, 28 Mar 2023 09:22:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230328071335.2664966-1-guodongtai@kylinos.cn>
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

On 3/28/23 9:13 AM, George Guo wrote:
> Here just skip the opcode(BPF_ST | BPF_NOSPEC) that has no couterpart to the loongarch.
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
> 
> ---
> Changelog:
> v2:
> 	- place it to build_insn
> 	- add printing for skipping bpf_jit the opcode
> ---
>   arch/loongarch/net/bpf_jit.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 288003a9f0ca..d3c6b1c4ccbb 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -1022,6 +1022,11 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
>   		emit_atomic(insn, ctx);
>   		break;
>   
> +	/* Speculation barrier */
> +	case BPF_ST | BPF_NOSPEC:
> +		pr_info_once("bpf_jit: skip speculation barrier opcode %0x2x\n", code);
> +		break;

Thanks that looks better. Question to LoongArch folks (Cc): There is no equivalent
to a speculation barrier here, correct? Either way, I think the pr_info_once() can
just be removed given there is little value for a users to have this in the kernel
log. I can take care of this while applying, that's fine.

>   	default:
>   		pr_err("bpf_jit: unknown opcode %02x\n", code);
>   		return -EINVAL;
> 

