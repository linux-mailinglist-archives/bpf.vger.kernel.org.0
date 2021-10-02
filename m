Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DFB41FD73
	for <lists+bpf@lfdr.de>; Sat,  2 Oct 2021 19:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbhJBRc0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 2 Oct 2021 13:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbhJBRcZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 2 Oct 2021 13:32:25 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB2AC0613EC
        for <bpf@vger.kernel.org>; Sat,  2 Oct 2021 10:30:39 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id s64so24653427yba.11
        for <bpf@vger.kernel.org>; Sat, 02 Oct 2021 10:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wXMJtKlLUkpkTeC/ZpG6R1dp/ShOwvvXqINiBv7rTpQ=;
        b=YSYMM4FkUE8eZebYGJWRLl0+IuMVzn3R2Haf+PpJJFPbAPYWcXc2cXByOZcaQPcCg/
         lG6FnIIwo67fIC58k0cQUJEJWEisW1zgl3904xD7+XA5mQZQCRkOHPdbYRpimIthdvop
         7YENn/BkXqvM4zBQidXgTnRTmNsEHXL1UWgZVu+8q9s/XryNUfqjQ4AC3R/I+vPYtUPd
         trumoXBvLA57f4c7OSuo+ynZhKGt2+5askS8wLVKDrmMn8Td0zwAmo0VkZMcnAIqwCZ5
         FtX+lCu+q4B3tNIMfgS68IIPz1tBX5UVnOryRZRUr1TpMuo/A78E8WfrqK98KgTYa1+M
         K14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wXMJtKlLUkpkTeC/ZpG6R1dp/ShOwvvXqINiBv7rTpQ=;
        b=PS++UiRpT6tHhR7g1lafEW9uCsEJj7iPM0vB+kyVQyAOHOBm7qLrZty4eFfIcheimA
         lpXmT8+QiKXKD3tJT/v3dCBJRMfSC1qgUqlDk1lSxnc21Z08itSW2Ocq/N8PFmXyKHLg
         R0W/yc5h3oAFubi2SCM1ntRt0dkCF4+XwFwGg8hVz5gUvMQDlv2hN/3jvNIWQHUej5+X
         M7zs6EW9A0jFo83jtp2xsuSwT4Xbg3dlrblnq4qOZWC4e0DPCivjzbHhpIN5YAOSasY8
         NDmEvygHjVF/lAQHsyPd2ak9+yVlsQauGr/I+1lt7xxs+kmWXmlfQvL7bI5b2pFbnOW7
         xkSw==
X-Gm-Message-State: AOAM533r+v3YjQZlmq4zBbSX4FDrNS97z+s845qbWXAdmeI5Bin4CDYp
        3ugsS4DW4pqmaZwgO+vJCW0aXsZc2Jyv0vsh+zussA==
X-Google-Smtp-Source: ABdhPJx+jygCqca4NLWugI+qdhvBayAOnFyq54a2FPzwA2PSth4+amv+zq5sCxgcWPbUB7b0Z/Z+ZlfkSCgfhNhn53Y=
X-Received: by 2002:a25:c986:: with SMTP id z128mr4811601ybf.112.1633195839032;
 Sat, 02 Oct 2021 10:30:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1633104510.git.naveen.n.rao@linux.vnet.ibm.com> <92fcd53a43dede52fbba52dc50c76042a6ce284c.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <92fcd53a43dede52fbba52dc50c76042a6ce284c.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date:   Sat, 2 Oct 2021 19:30:28 +0200
Message-ID: <CAM1=_QS6GCA0zAUgWSiW8eR6GiVjnMzCWvGrdkmY9nnseeCFeg@mail.gmail.com>
Subject: Re: [PATCH 3/9] powerpc/bpf: Remove unused SEEN_STACK
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        bpf <bpf@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 1, 2021 at 11:15 PM Naveen N. Rao
<naveen.n.rao@linux.vnet.ibm.com> wrote:
>
> From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>
> SEEN_STACK is unused on PowerPC. Remove it. Also, have
> SEEN_TAILCALL use 0x40000000.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Acked-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Tested-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>

> ---
>  arch/powerpc/net/bpf_jit.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
> index 7e9b978b768ed9..89bd744c2bffd4 100644
> --- a/arch/powerpc/net/bpf_jit.h
> +++ b/arch/powerpc/net/bpf_jit.h
> @@ -125,8 +125,7 @@
>  #define COND_LE                (CR0_GT | COND_CMP_FALSE)
>
>  #define SEEN_FUNC      0x20000000 /* might call external helpers */
> -#define SEEN_STACK     0x40000000 /* uses BPF stack */
> -#define SEEN_TAILCALL  0x80000000 /* uses tail calls */
> +#define SEEN_TAILCALL  0x40000000 /* uses tail calls */
>
>  #define SEEN_VREG_MASK 0x1ff80000 /* Volatile registers r3-r12 */
>  #define SEEN_NVREG_MASK        0x0003ffff /* Non volatile registers r14-r31 */
> --
> 2.33.0
>
