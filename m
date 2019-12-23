Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADD7F1299EA
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2019 19:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfLWSaj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Dec 2019 13:30:39 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38401 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfLWSaj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Dec 2019 13:30:39 -0500
Received: by mail-pf1-f194.google.com with SMTP id x185so9564472pfc.5
        for <bpf@vger.kernel.org>; Mon, 23 Dec 2019 10:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:subject:cc:to:in-reply-to:references:message-id
         :mime-version:content-transfer-encoding;
        bh=4s+YAIWTnpqbkvQsrs1kgFyI5PJQFh2IvW0x8pJusAk=;
        b=PMrDwuX6oPEJOhMrPi5n1g3U7AyrFtjZL1PYFgy/GbhKxjcYPxgTuBWEThA3KTF1NK
         g+VL9Tzn8sDxGvVXEoe/4omE8SUgc4k/ySj8seyg0hkXJXsuHZ6TrIggTl4KhIvD6L7D
         hnjfgLhwvFPJmMBuusSh/sXZasEaSVi22bY6CT0VM0PkGg/dHHb2cZGy7B2qYaMlgoWY
         2PvcbWWtA6yJh453bsuMpOr8IAu7EHhh7Raeq6l2sCGhd/irHBdz5AxBBnx02lbGsLux
         fsO/uCSbk+DQOH4LcQTjOAmVEATd5fuTcg652PP37Z7vEsl+cw92BBf55B+4tgNt2LZq
         gd8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:cc:to:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=4s+YAIWTnpqbkvQsrs1kgFyI5PJQFh2IvW0x8pJusAk=;
        b=m62ylGyLOgIzltjmlmUaFiZCXbpO37jOdq4DKSONIA/HGcOosy46EdBWFPEnVXlfTM
         m4tyDoGvWYVNBXaoIsdjVwlvpqXKUomVkz7Cb9gOfDjuMrufC3p8bPhTjNhgpYwthRSK
         Sn5ARdenNiuuLyY6fPrmAdZpKcVY28ULJEcodlLahr9K24ncGfbccGmQayHpbIXpUhUt
         dOG6Wp4kUSFiSDI7vnx51x7tsLGJsd2w7nrLt0X9UlnVzwuGeC4682fj/idpi15k1exn
         q2ZvS0zycx/vh0xRcJ0Jj68d2YKAy3dWUE5m4b9gAbfZxG8Mvcjbakyl5tU/K+fqUIVZ
         3SRg==
X-Gm-Message-State: APjAAAX+RmkVUhm7jBvaZ86/U3vDd885IFZCbpATxTv2SE9GeRAUwcVz
        gUCWvl9X8OmmI5/URweEy2/O/A==
X-Google-Smtp-Source: APXvYqz9XqWvyxAlEWkNyD9bCzCDDMgxZw2M9kfQJPYDiGtuFIz2E7BxiGhn7rriK62yIKD4t4rHrA==
X-Received: by 2002:a63:1c64:: with SMTP id c36mr29162810pgm.302.1577125838483;
        Mon, 23 Dec 2019 10:30:38 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
        by smtp.gmail.com with ESMTPSA id g26sm17328760pfo.130.2019.12.23.10.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 10:30:38 -0800 (PST)
Date:   Mon, 23 Dec 2019 10:30:38 -0800 (PST)
X-Google-Original-Date: Mon, 23 Dec 2019 10:30:36 PST (-0800)
From:   Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject:     Re: [PATCH bpf-next v2 6/9] riscv, bpf: provide RISC-V specific JIT image alloc/free
CC:     daniel@iogearbox.net, ast@kernel.org, netdev@vger.kernel.org,
        Bjorn Topel <bjorn.topel@gmail.com>,
        linux-riscv@lists.infradead.org, bpf@vger.kernel.org
To:     Bjorn Topel <bjorn.topel@gmail.com>
In-Reply-To: <20191216091343.23260-7-bjorn.topel@gmail.com>
References: <20191216091343.23260-7-bjorn.topel@gmail.com>
  <20191216091343.23260-1-bjorn.topel@gmail.com>
Message-ID: <mhng-3299fb62-01d1-4e83-90fe-d706d2495bc1@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 16 Dec 2019 01:13:40 PST (-0800), Bjorn Topel wrote:
> This commit makes sure that the JIT images is kept close to the kernel
> text, so BPF calls can use relative calling with auipc/jalr or jal
> instead of loading the full 64-bit address and jalr.
>
> The BPF JIT image region is 128 MB before the kernel text.
>
> Signed-off-by: Björn Töpel <bjorn.topel@gmail.com>
> ---
>  arch/riscv/include/asm/pgtable.h |  4 ++++
>  arch/riscv/net/bpf_jit_comp.c    | 13 +++++++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 7ff0ed4f292e..cc3f49415620 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -404,6 +404,10 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
>  #define VMALLOC_END      (PAGE_OFFSET - 1)
>  #define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
>
> +#define BPF_JIT_REGION_SIZE	(SZ_128M)
> +#define BPF_JIT_REGION_START	(PAGE_OFFSET - BPF_JIT_REGION_SIZE)
> +#define BPF_JIT_REGION_END	(VMALLOC_END)
> +
>  /*
>   * Roughly size the vmemmap space to be large enough to fit enough
>   * struct pages to map half the virtual address space. Then
> diff --git a/arch/riscv/net/bpf_jit_comp.c b/arch/riscv/net/bpf_jit_comp.c
> index 8aa19c846881..46cff093f526 100644
> --- a/arch/riscv/net/bpf_jit_comp.c
> +++ b/arch/riscv/net/bpf_jit_comp.c
> @@ -1656,3 +1656,16 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  					   tmp : orig_prog);
>  	return prog;
>  }
> +
> +void *bpf_jit_alloc_exec(unsigned long size)
> +{
> +	return __vmalloc_node_range(size, PAGE_SIZE, BPF_JIT_REGION_START,
> +				    BPF_JIT_REGION_END, GFP_KERNEL,
> +				    PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
> +				    __builtin_return_address(0));
> +}
> +
> +void bpf_jit_free_exec(void *addr)
> +{
> +	return vfree(addr);
> +}

Ah, I guess I should have read the whole patch set :)

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

and feel free to put the same on whatever patch I just asked that question
on, though maybe this one should go before the others as they sort of depend on
it?
