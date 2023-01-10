Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831A8663D87
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 11:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjAJKJ1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Jan 2023 05:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjAJKJZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Jan 2023 05:09:25 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828724D731
        for <bpf@vger.kernel.org>; Tue, 10 Jan 2023 02:09:24 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v2so155494wrw.10
        for <bpf@vger.kernel.org>; Tue, 10 Jan 2023 02:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4xYMRRUsS1/+nnFrFeQgPKlK9gLI7LgQiZoVUnSBgI4=;
        b=qv97nGmxcMwyDTmIwBmhhqeVq7UvyuI6iU7kvOwVo8BBBun+sOpEaBXhRZuXzF2lwK
         MCMbDYxMR0eOlY04P3bmwdWu7EN8bpri+p40F5B/q5+dLnMOsfb2Xsfa+Y7KdqoktCbX
         iXg80PPWBS1Y1e+d3/jV+b17UIoDmmWLMK7VJwaAdH5/r9nlajOsaZzzwf6dGExTjAPQ
         Qc6ST8MYR/Up7JBw21L2A83NoNKolRor6JH8DuFInuWFmPMe2tdlM7xbH9GhpUKELP9y
         k3QkZJWdaA9SjGyBcr/MR/eo2hzOMNCo3VnhsTUM12Zzpwx7NdV0JXlLTGrk4PVXKQW4
         wJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4xYMRRUsS1/+nnFrFeQgPKlK9gLI7LgQiZoVUnSBgI4=;
        b=AmmqUSQ/xDdYNY3lfwcpV1lqbSb+FGf7ICCUa0Kh5bEPjztXVur53M5QjZQkcgqhM9
         h6SsnwJlpg+at7cQZFxmt+AEK9BX8XsFUIHGEFOM9yio2bVnmR1+Ez+zE6vbnJAIsYf+
         Vor8llqXqQ4O/+66c+Fh002KRPeYr6bZHjfQfJEQOPIPzAKj8gjdTrnWbjTMVej66J8f
         Ok+Nm7C+vb57BPA4VYQtwxVARNv5b/9gJ/3PuPpQuyN06SFe1xPJ1Xe4J1TqoBwm8htY
         qJ/+arp3FGqG3xCw62ivKOfvDaDIZM4wr89EyegQoLAFZP2lIKzx/4L10wHLri4QsdRa
         w9qQ==
X-Gm-Message-State: AFqh2kr0eA5jNLLl4C8WDHoFqtoB6WS9rCPw+/EYqFK7JrFSFIS5AbY1
        waSY1kPkm2TiP7SdO87h/EaAs7rrD45bamJ6uUQ=
X-Google-Smtp-Source: AMrXdXvgLV7H2Uc2y/x8gtRgon6k5ihb8NLU90cU65YiJ7wiU3KJIYxoeQYWyHlRrsCA7g0NdwEfAA==
X-Received: by 2002:adf:ec85:0:b0:291:4088:a634 with SMTP id z5-20020adfec85000000b002914088a634mr25413839wrn.40.1673345363032;
        Tue, 10 Jan 2023 02:09:23 -0800 (PST)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id u5-20020adfdb85000000b002ba2646fd30sm12631012wri.36.2023.01.10.02.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 02:09:22 -0800 (PST)
Message-ID: <cf942878-c1f7-c1ce-858b-d8eec716973b@isovalent.com>
Date:   Tue, 10 Jan 2023 10:09:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH bpf-next] bpftool: Add missing quotes to libbpf bootstrap
 submake vars
Content-Language: en-GB
To:     James Hilliard <james.hilliard1@gmail.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20230110014504.3120711-1-james.hilliard1@gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230110014504.3120711-1-james.hilliard1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2023-01-09 18:45 UTC-0700 ~ James Hilliard <james.hilliard1@gmail.com>
> When passing compiler variables like CC=$(HOSTCC) to a submake
> we must ensure the variable is quoted in order to handle cases
> where $(HOSTCC) may be multiple binaries.
> 
> For example when using ccache $HOSTCC may be:
> "/usr/bin/ccache /usr/bin/gcc"
> 
> If we pass CC without quotes like CC=$(HOSTCC) only the first
> "/usr/bin/ccache" part will be assigned to the CC variable which
> will cause an error due to dropping the "/usr/bin/gcc" part of
> the variable in the submake invocation.
> 
> This fixes errors such as:
> /usr/bin/ccache: invalid option -- 'd'
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>


Acked-by: Quentin Monnet <quentin@isovalent.com>

Thanks
