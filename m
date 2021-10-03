Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E01F420092
	for <lists+bpf@lfdr.de>; Sun,  3 Oct 2021 09:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhJCH5n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Oct 2021 03:57:43 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:57725 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229822AbhJCH5m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Oct 2021 03:57:42 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HMbkf5LsFz9sVT;
        Sun,  3 Oct 2021 09:55:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ca_nrpwXBqPp; Sun,  3 Oct 2021 09:55:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HMbkf4XLQz9sVS;
        Sun,  3 Oct 2021 09:55:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 867298B76D;
        Sun,  3 Oct 2021 09:55:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id dOxT7VpGihEH; Sun,  3 Oct 2021 09:55:54 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (po18950.idsi0.si.c-s.fr [192.168.203.204])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D700E8B765;
        Sun,  3 Oct 2021 09:55:53 +0200 (CEST)
Subject: Re: [PATCH 3/9] powerpc/bpf: Remove unused SEEN_STACK
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Cc:     bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
 <92fcd53a43dede52fbba52dc50c76042a6ce284c.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <bdadfd21-7e39-5984-43b9-818f1660ccaf@csgroup.eu>
Date:   Sun, 3 Oct 2021 09:55:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <92fcd53a43dede52fbba52dc50c76042a6ce284c.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



Le 01/10/2021 à 23:14, Naveen N. Rao a écrit :
> From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> 
> SEEN_STACK is unused on PowerPC. Remove it. Also, have
> SEEN_TAILCALL use 0x40000000.

Why change SEEN_TAILCALL ? Would it be a problem to leave it as is ?

> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>   arch/powerpc/net/bpf_jit.h | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
> index 7e9b978b768ed9..89bd744c2bffd4 100644
> --- a/arch/powerpc/net/bpf_jit.h
> +++ b/arch/powerpc/net/bpf_jit.h
> @@ -125,8 +125,7 @@
>   #define COND_LE		(CR0_GT | COND_CMP_FALSE)
>   
>   #define SEEN_FUNC	0x20000000 /* might call external helpers */
> -#define SEEN_STACK	0x40000000 /* uses BPF stack */
> -#define SEEN_TAILCALL	0x80000000 /* uses tail calls */
> +#define SEEN_TAILCALL	0x40000000 /* uses tail calls */
>   
>   #define SEEN_VREG_MASK	0x1ff80000 /* Volatile registers r3-r12 */
>   #define SEEN_NVREG_MASK	0x0003ffff /* Non volatile registers r14-r31 */
> 
