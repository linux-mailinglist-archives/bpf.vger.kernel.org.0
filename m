Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69F8676C8E
	for <lists+bpf@lfdr.de>; Sun, 22 Jan 2023 12:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjAVLy7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 22 Jan 2023 06:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjAVLy5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 22 Jan 2023 06:54:57 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02394125BC
        for <bpf@vger.kernel.org>; Sun, 22 Jan 2023 03:54:56 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so8781970wmb.0
        for <bpf@vger.kernel.org>; Sun, 22 Jan 2023 03:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VLe1tCHvsXuqDEBtfO7OY5kLhydgi9CnGmhErJAm6aY=;
        b=s0BAxEQrg1XNDKd+RDJjQ/lqdPTA7p1sTOMmyByolojk0mvaFqzqmy7GIdrIZxmIOf
         nFUchdZptB8ZVzLanP/34atcmww1mMSAPnOW6ClddkbiU7eDltZQOUDza6VkttvsUHfc
         VQreJV0TXJjnpWyAigdZSH569OgxnVx8rooyMeC0XkS7AD9xKYSlxnN4RqPAyi5VpF7k
         CoH7kaCdBdozNk9M+weoHgP1irBiEMfOD3knAU/SvcsagkDEAe+ceFKjExWCJUNouNc/
         k5Jv6eqzFnOZo2sgqVpIZZUumFywQQqcWtw67WTGWBMxjS7Nexwmrc+zVtNxlk1/BNXb
         5cxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VLe1tCHvsXuqDEBtfO7OY5kLhydgi9CnGmhErJAm6aY=;
        b=a+aINu67w3+GBCtrvqDFtw9JVdj1f4ChSu64xrHolsOwP/33cMHmPli3hQsF2Vq+Ox
         1FF8VRQrzRIfnY6+GXYbaIXuWeiom999j+I/73cvE7h1fs/3fL5nLAJUdhs8PQFtRMNo
         QpLxKUrKyBssgTb+4qvJmTR9tw32RlTT8fXHP/w9I7WNpA8WLlt7TjmAjfqJeej+j9Gz
         RjGVapog9rnb7agWTe0syx9uHNDcpTgAOUn3VmVbo1tMdGvw8stY/0uwwSNYPJN8091X
         CZn6TDh4Wnq/o7RhtFOKsunOtEMcRCn3bDGp6t/rVKGVCSici77m43FvNCGY0qN1Z+N3
         2IKQ==
X-Gm-Message-State: AFqh2kqfGHUYB05tSyz3zf83xZ0uaRo/PccUqHjeQ4+8+cnymzoIJMfU
        p+VC0oQzHNoRtL2F/Zj+XVIvtg==
X-Google-Smtp-Source: AMrXdXvuCQdb16Nj82HEsGUUdIjG5ZPXUogSicV9IYHza0HEoyjvxXi4JXn+3h6rll38KtJXF4JaFw==
X-Received: by 2002:a05:600c:1508:b0:3d3:5166:2da4 with SMTP id b8-20020a05600c150800b003d351662da4mr20299706wmg.8.1674388494495;
        Sun, 22 Jan 2023 03:54:54 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m37-20020a05600c3b2500b003daf681d05dsm8320826wms.26.2023.01.22.03.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 03:54:54 -0800 (PST)
Message-ID: <995eb624-3efe-10fc-a6ed-883d52d591bb@linaro.org>
Date:   Sun, 22 Jan 2023 12:54:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [RFC PATCH v2 31/31] kvx: Add IPI driver
Content-Language: en-US
To:     Yann Sionneau <ysionneau@kalray.eu>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Clement Leger <clement@clement-leger.fr>,
        Vincent Chardon <vincent.chardon@elsys-design.com>,
        =?UTF-8?Q?Marc_Poulhi=c3=a8s?= <dkm@kataplop.net>,
        Julian Vetter <jvetter@kalray.eu>,
        Samuel Jones <sjones@kalray.eu>,
        Ashley Lesdalons <alesdalons@kalray.eu>,
        Thomas Costis <tcostis@kalray.eu>,
        Marius Gligor <mgligor@kalray.eu>,
        Jonathan Borne <jborne@kalray.eu>,
        Julien Villette <jvillette@kalray.eu>,
        Luc Michel <lmichel@kalray.eu>,
        Louis Morhet <lmorhet@kalray.eu>,
        Julien Hascoet <jhascoet@kalray.eu>,
        Jean-Christophe Pince <jcpince@gmail.com>,
        Guillaume Missonnier <gmissonnier@kalray.eu>,
        Alex Michon <amichon@kalray.eu>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <git@xen0n.name>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        John Garry <john.garry@huawei.com>,
        Guangbin Huang <huangguangbin2@huawei.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Bibo Mao <maobibo@loongson.cn>,
        Atish Patra <atishp@atishpatra.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Qi Liu <liuqi115@huawei.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Benjamin Mugnier <mugnier.benjamin@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-audit@redhat.com,
        linux-riscv@lists.infradead.org, bpf@vger.kernel.org
References: <20230120141002.2442-1-ysionneau@kalray.eu>
 <20230120141002.2442-32-ysionneau@kalray.eu>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230120141002.2442-32-ysionneau@kalray.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 20/01/2023 15:10, Yann Sionneau wrote:
> +
> +int __init kvx_ipi_ctrl_probe(irqreturn_t (*ipi_irq_handler)(int, void *))
> +{
> +	struct device_node *np;
> +	int ret;
> +	unsigned int ipi_irq;
> +	void __iomem *ipi_base;
> +
> +	np = of_find_compatible_node(NULL, NULL, "kalray,kvx-ipi-ctrl");

Nope, big no.

Drivers go to drivers, not to arch code. Use proper driver infrastructure.

Best regards,
Krzysztof

