Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7221299FE
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2019 19:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfLWS6r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Dec 2019 13:58:47 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37218 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfLWS6q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Dec 2019 13:58:46 -0500
Received: by mail-pl1-f196.google.com with SMTP id c23so7521780plz.4
        for <bpf@vger.kernel.org>; Mon, 23 Dec 2019 10:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:subject:cc:to:in-reply-to:references:message-id
         :mime-version:content-transfer-encoding;
        bh=vFoEgxaEB1zc0DAr9pJZ8IZIOptwhmCYzlzwd9xd7k0=;
        b=Y7TjIfdheQGrUncpijbP3hs1oxbU1c+HQHDUq2jIuY+c3aAGbPpUV6m+vTiPxOUj/f
         KulYmNx1lXUqyX0K/YhvZxCzhIwdmK/b/rs1BuCVh6Ghy7UammYuYGo1gSb1706i4q/s
         Yv9FxEElY0F0z/Xpjf/WF18DSYb9uZkZLZ6shBIIMmSzv1Ii2bU4r1JT0TnR2uyguxrZ
         nlAxqLOajMsINDJoRu5fMQEtCmJEK13krcAf1PPCePWkeCLtYKw1G4IA01aZPwigFyM2
         XeKcUcWZ/r/eqN6/rUHfXseLWZ3XgQ9sS3+Ove1As4+4ZA/3DF3pE8BALqz9+vT8ZXGC
         nJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:cc:to:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=vFoEgxaEB1zc0DAr9pJZ8IZIOptwhmCYzlzwd9xd7k0=;
        b=egHa9Ot1teSPVzDSI8Q1TDWd6W8V5REIdNfwkfppMEu9Ryo1zy9pkBtCeHfxK9VWNi
         2xpjkocMZB+WRY7CAWKxSDD+Qk8levnk8JWxBTuPE4UCsymq2YseaY8ifQD0nwuNfM1L
         Ofp0v1ce0yPza4ooSS9Dse0BcAoN3LoI5daMl+QFn8Dw0rSsEjyXbI3dkRqgseEeJKVD
         9MeqdcVpeOfPdsW2IGTQU0AZmZwmvO/Zn9R76ZY6t78mGVRZmZTx1CIeorHQ++FKzOe5
         2Dl3Y5kUUTspTeNKwndsYmEayC9q5TInbQ5Xgaa23kkicOWU+rvGMVUxahKh/kqGYxdo
         cgtA==
X-Gm-Message-State: APjAAAXp0VFOFOiyuLftTsvtX6PFpNFuE2XEBed1rTf0KDDdoqrQkqyC
        ysIsOWMSWP8PQRbUsy0duRjG7A==
X-Google-Smtp-Source: APXvYqy14gp9fKJfJ2IsprI6RsHoI0uFkv1aR6vtNaqrvw2G9l8sGZR5y6mDDJYHrXI+5a8XC1/DRQ==
X-Received: by 2002:a17:90a:1785:: with SMTP id q5mr590326pja.143.1577127526213;
        Mon, 23 Dec 2019 10:58:46 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
        by smtp.gmail.com with ESMTPSA id r6sm25604177pfh.91.2019.12.23.10.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 10:58:45 -0800 (PST)
Date:   Mon, 23 Dec 2019 10:58:45 -0800 (PST)
X-Google-Original-Date: Mon, 23 Dec 2019 10:58:41 PST (-0800)
From:   Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject:     Re: [PATCH bpf-next v2 9/9] riscv, perf: add arch specific perf_arch_bpf_user_pt_regs
CC:     daniel@iogearbox.net, ast@kernel.org, netdev@vger.kernel.org,
        Bjorn Topel <bjorn.topel@gmail.com>,
        linux-riscv@lists.infradead.org, bpf@vger.kernel.org
To:     Bjorn Topel <bjorn.topel@gmail.com>
In-Reply-To: <20191216091343.23260-10-bjorn.topel@gmail.com>
References: <20191216091343.23260-10-bjorn.topel@gmail.com>
  <20191216091343.23260-1-bjorn.topel@gmail.com>
Message-ID: <mhng-96d54703-6e9d-45df-b204-a16fe8dc57e0@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 16 Dec 2019 01:13:43 PST (-0800), Bjorn Topel wrote:
> RISC-V was missing a proper perf_arch_bpf_user_pt_regs macro for
> CONFIG_PERF_EVENT builds.
>
> Signed-off-by: Björn Töpel <bjorn.topel@gmail.com>
> ---
>  arch/riscv/include/asm/perf_event.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/riscv/include/asm/perf_event.h b/arch/riscv/include/asm/perf_event.h
> index aefbfaa6a781..0234048b12bc 100644
> --- a/arch/riscv/include/asm/perf_event.h
> +++ b/arch/riscv/include/asm/perf_event.h
> @@ -82,4 +82,8 @@ struct riscv_pmu {
>  	int		irq;
>  };
>
> +#ifdef CONFIG_PERF_EVENTS
> +#define perf_arch_bpf_user_pt_regs(regs) (struct user_regs_struct *)regs
> +#endif
> +
>  #endif /* _ASM_RISCV_PERF_EVENT_H */

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
