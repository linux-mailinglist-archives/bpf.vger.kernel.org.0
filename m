Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5AB590595
	for <lists+bpf@lfdr.de>; Thu, 11 Aug 2022 19:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbiHKRQZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Aug 2022 13:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234781AbiHKRPt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Aug 2022 13:15:49 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B50B22
        for <bpf@vger.kernel.org>; Thu, 11 Aug 2022 10:04:27 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id f13-20020a170902ce8d00b0016eebfe70fcso11596643plg.7
        for <bpf@vger.kernel.org>; Thu, 11 Aug 2022 10:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=D+ellfACBxAmbVQUNMDunXA6++33PEZVxJ5ftj+OAEc=;
        b=KRwyGcXdb2B5+MNWvIcRW1YKMnY6/vyw4So9PKlNZVgbvFnv/hPle8s4fJHpt41ZOT
         7YxS2/eh8wo6j1M3mW7R9IipjfNW1hB1SNkpaJVJzGTJxXjON82hQd1v0+KZwgVqX8Fc
         Ge23df493AdZJoin3OzGix6N3zZ6lt0gjQK8Puy95nSZSiR7CzGm660RAMjYrmXJzjEQ
         p93yH2SKxK1nAyoYfNRKOY7NoaCzY2arASDYvhBvzTeJNW7fob6qWyjG8ZDMLbWko8jy
         ASRwN3dr4R46N7oBQGDlZK1q64N9fgsTGj7EjHs8kABI0/TNw1i6scKkstaBZhdhJmVW
         sI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=D+ellfACBxAmbVQUNMDunXA6++33PEZVxJ5ftj+OAEc=;
        b=qY+zmZOjy9WwJV86nhOMLbk/X0SKwxBi3fCtVxtm2e5YyzWeKjOc48KXsZiEJ0OE8E
         JZcs3rK7EFByrX5lqbduYueO0Osiyx33ghMjIjpqaNg5IImBOe5v2Z6E7TaaS78Pz4jk
         C/g4iqO0LTmGf+42d5TZBICNknfl5D1vvoJ++ucbxnYoktisHjhp4egaWMIRR4suR/RL
         r8lHi5H6IQM6IvMbUZQ8NYtfsqqd7w9Sd8S5DIQfBGG32I4pSmqUnJauOc45sVFoCnEj
         xOaWVlonlo3DWBd4TrQbM6VCuO7cDqNKRyXeWCnjv+2kHxURPIaaqb+Jtzmslhn1lhl1
         Qt8w==
X-Gm-Message-State: ACgBeo0Z+CtOxbOdE3gWJGXUKnD/S8a+QCvc9u+bHzLAqVrMa1Rt+AHw
        BLWR9SIH1Ti4XbKeE4gr1MFhcHA=
X-Google-Smtp-Source: AA6agR5YgtCBONtNsSNwyiYb1GJCUPkTZVKNty3MYo1gnxy04/uuot/dXTJg4pGiZ37NTCJY5sDrfgw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:ce90:b0:16e:f7c3:c478 with SMTP id
 f16-20020a170902ce9000b0016ef7c3c478mr151924plg.82.1660237467007; Thu, 11 Aug
 2022 10:04:27 -0700 (PDT)
Date:   Thu, 11 Aug 2022 10:04:25 -0700
In-Reply-To: <20220810190724.2692127-1-kafai@fb.com>
Message-Id: <YvU2md/W4YSlnkBH@google.com>
Mime-Version: 1.0
References: <20220810190724.2692127-1-kafai@fb.com>
Subject: Re: [PATCH v3 bpf-next 00/15] bpf: net: Remove duplicated code from bpf_setsockopt()
From:   sdf@google.com
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, kernel-team@fb.com,
        Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 08/10, Martin KaFai Lau wrote:
> The code in bpf_setsockopt() is mostly a copy-and-paste from
> the sock_setsockopt(), do_tcp_setsockopt(), do_ipv6_setsockopt(),
> and do_ip_setsockopt().  As the allowed optnames in bpf_setsockopt()
> grows, so are the duplicated code.  The code between the copies
> also slowly drifted.

> This set is an effort to clean this up and reuse the existing
> {sock,do_tcp,do_ipv6,do_ip}_setsockopt() as much as possible.

> After the clean up, this set also adds a few allowed optnames
> that we need to the bpf_setsockopt().

> The initial attempt was to clean up both bpf_setsockopt() and
> bpf_getsockopt() together.  However, the patch set was getting
> too long.  It is beneficial to leave the bpf_getsockopt()
> out for another patch set.  Thus, this set is focusing
> on the bpf_setsockopt().

> v3:
> - s/in_bpf/has_current_bpf_ctx/ (Andrii)
> - Add comments to has_current_bpf_ctx() and sockopt_lock_sock()
>    (Stanislav)
> - Use vmlinux.h in selftest and add defines to bpf_tracing_net.h
>    (Stanislav)
> - Use bpf_getsockopt(SO_MARK) in selftest (Stanislav)
> - Use BPF_CORE_READ_BITFIELD in selftest (Yonghong)

Reviewed-by: Stanislav Fomichev <sdf@google.com>

(I didn't go super deep on the selftest)
