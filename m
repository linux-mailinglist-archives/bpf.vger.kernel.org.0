Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE7E676C92
	for <lists+bpf@lfdr.de>; Sun, 22 Jan 2023 12:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjAVL5N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 22 Jan 2023 06:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjAVL5L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 22 Jan 2023 06:57:11 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81377125B7
        for <bpf@vger.kernel.org>; Sun, 22 Jan 2023 03:57:10 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id r9so8473955wrw.4
        for <bpf@vger.kernel.org>; Sun, 22 Jan 2023 03:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ckWviSxANZfcro+bBRfyc+cenkmtjOkiW7r6SzucWlg=;
        b=rVyqAJqcbEVO2mLYQVAhfnqaxyKeML/dcpxmRaA391AWy18uZOcTusGjMi44ncpTql
         vRUlbx31k3vofUNP4vsPJVAi8lmlvkVa9EF7D+g1STXssK/sO9udFfYn+8KZstXrK7qh
         xd8yLliT4+F15t5bWD1hE7T1GDf9FwKdq6LRDIE6AKZfPND9W8ihbB18IBlG77AI1lAD
         h2yHlmJaQeszTJT/hh3lV1J+dPT8wAe85E0VKkfG7d3OdVi0bTLkjAqcxHch+rOespJa
         a741p3AQgK6ZAVKTC3L2Wy3ECwJcIx3YubDD3GwhhX5WXjHjZWZq6eG8muWvlHTdzBqb
         Y8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ckWviSxANZfcro+bBRfyc+cenkmtjOkiW7r6SzucWlg=;
        b=l7gQhJYwTYkV4HF8S1st1Mvd+mfRSPxPHYT/XL9XsDjaE3XeIq+9ZRgQWgq0NT/xQS
         GaoEIgehIChaD7P8TCOV/wL54kOY4lsSfqLVlMMUiQCg0R1yWnqi/5MoHaGlwu9rZh2r
         uVv/f9uX5wM1d494XScBwu31DKyz5OYqgZeZt3EbnkCqz3YDNLpxCYKdMA15D7Lk/3H5
         7QVRblmxRCEpkqyNATXj4iehkOEGLzv1XjZQvqokOVF9SNH1ArwJjZsr9iPNU7TiOqnI
         F2DA8dfEBKCK2nmFVhYVMztp0j3aSvd2jg3yxw8yvCPxK0YC2vlrfvR+FjMS0Bppl1ZE
         G/WQ==
X-Gm-Message-State: AFqh2kqu4ZkXokGI8PJ7ootB1Pl9cn9dBOxYHet4AS+KuhZe/uKMYE92
        G9opbtVZO0aUWVezpisWXr7Qew==
X-Google-Smtp-Source: AMrXdXvUmSo3jcsu3xojfTukvrhpzxz6e7Xp9tLFomGzgShSJjiyaBJUGl7NNs6LSU7eztbkOMG0ag==
X-Received: by 2002:a5d:5224:0:b0:2bd:bbf7:1f87 with SMTP id i4-20020a5d5224000000b002bdbbf71f87mr20620225wra.60.1674388629088;
        Sun, 22 Jan 2023 03:57:09 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id d16-20020adfef90000000b002b9b9445149sm3306165wro.54.2023.01.22.03.57.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 03:57:08 -0800 (PST)
Message-ID: <3043df6d-8cc1-6969-09d4-50ad6195c924@linaro.org>
Date:   Sun, 22 Jan 2023 12:57:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [RFC PATCH v2 29/31] kvx: Add support for cpuinfo
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
 <20230120141002.2442-30-ysionneau@kalray.eu>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230120141002.2442-30-ysionneau@kalray.eu>
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
> +static int __init setup_cpuinfo(void)
> +{
> +	int cpu;
> +	struct clk *clk;
> +	unsigned long cpu_freq = 1000000000;
> +	struct device_node *node = of_get_cpu_node(0, NULL);
> +
> +	clk = of_clk_get(node, 0);
> +	if (IS_ERR(clk)) {
> +		printk(KERN_WARNING
> +		       "Device tree missing CPU 'clock' parameter. Assuming frequency is 1GHZ");
> +		goto setup_cpu_freq;
> +	}
> +
> +	cpu_freq = clk_get_rate(clk);

What about cpufreq? I don't think this is useful.

Best regards,
Krzysztof

