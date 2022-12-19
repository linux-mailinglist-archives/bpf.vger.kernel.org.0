Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90036514D8
	for <lists+bpf@lfdr.de>; Mon, 19 Dec 2022 22:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbiLSV0Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Dec 2022 16:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbiLSV0X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Dec 2022 16:26:23 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393AF643F
        for <bpf@vger.kernel.org>; Mon, 19 Dec 2022 13:26:22 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id r26so14778326edc.10
        for <bpf@vger.kernel.org>; Mon, 19 Dec 2022 13:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=GCXGJJNKGTWuXb6V003J6pOwCnEMsetkiLzAhdYVzW0=;
        b=LtAF2xSDlToVTnXEy9LEzSpz+GkrYgPLsAQGgze39udobM+kGKBCX3CEY+1EgLEUTC
         Uc/EiqqgUe5lUCzrKnoJ5S0ecwbhlLTI5MCUwc07oww71PWzfmlqFSiVc99ZwROvEqcb
         qrngqVlRC93l9usMvokx/fLao5HYoVBNnE9Jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCXGJJNKGTWuXb6V003J6pOwCnEMsetkiLzAhdYVzW0=;
        b=O03EW9bYdJMhEJk2LAaGYZhyIpdjqOWezSBXZtBeE1+pntuIhO4WQ4JC7EFjmDbx+F
         +e84cAL3gtI4Pg/W4gz26Dvckf/qmKVrcKU7ZltTnp0LA9kY90KW/hiSPwea7WAYd4mV
         04dmGSZ2mJOVqquKdIQd/0mDLNz/lehlLrOx6xcLtm/bSyX55GJVR7dytxNOKN20y21R
         jUghmdIBvyD/sK3T5BvnhBTHOdpfg+6VADgQYUsJQqawjyA710nJcG/3NrMIN0YT/rTX
         D3Il3Kb5jJrKNkHJxJ/O95Rr2EQUQaz9bO4zDUCCJs00Q61S49ChmzxkZ9LJKcV93MHh
         LNPg==
X-Gm-Message-State: AFqh2kofkjvK28o5kL+UQNg/gVdYVC0EyUvVLehs4conjKL1D3+qI+0Y
        QoOf1yln3fn6I3K4Gn7azvMefA==
X-Google-Smtp-Source: AMrXdXsVsa+mINTX9SXwUHvirH1jBMYbU+7Ik/+LmiyZ7seBhwCX7NH3K7CK/dkVCf6frMzTTiFYOQ==
X-Received: by 2002:a05:6402:25c7:b0:461:c5b4:a7d0 with SMTP id x7-20020a05640225c700b00461c5b4a7d0mr5967924edb.24.1671485180824;
        Mon, 19 Dec 2022 13:26:20 -0800 (PST)
Received: from cloudflare.com (79.184.201.14.ipv4.supernova.orange.pl. [79.184.201.14])
        by smtp.gmail.com with ESMTPSA id v8-20020a056402184800b0047021294426sm4801729edy.90.2022.12.19.13.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 13:26:20 -0800 (PST)
References: <20221218051734.31411-1-cehrig@cloudflare.com>
 <20221218051734.31411-2-cehrig@cloudflare.com>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Christian Ehrig <cehrig@cloudflare.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        Kui-Feng Lee <kuifeng@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Maxim Mikityanskiy <maximmi@nvidia.com>,
        Kaixi Fan <fankaixi.li@bytedance.com>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik@metanetworks.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add BPF_F_NO_TUNNEL_KEY test
Date:   Mon, 19 Dec 2022 22:26:02 +0100
In-reply-to: <20221218051734.31411-2-cehrig@cloudflare.com>
Message-ID: <87a63jjdac.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Dec 18, 2022 at 06:17 AM +01, Christian Ehrig wrote:
> This patch adds a selftest simulating a GRE sender and receiver using
> tunnel headers without tunnel keys. It validates if packets encapsulated
> using BPF_F_NO_TUNNEL_KEY are decapsulated by a GRE receiver not
> configured with tunnel keys.
>
> Signed-off-by: Christian Ehrig <cehrig@cloudflare.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
