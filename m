Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BFD6B2A98
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 17:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjCIQQM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 11:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjCIQOt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 11:14:49 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872591070E8
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 08:07:27 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id p20so2461755plw.13
        for <bpf@vger.kernel.org>; Thu, 09 Mar 2023 08:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678377988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+eaOZDAMP7IVRiUMgwsXxeXZaTP/ZiwfvsJ/oitRkE=;
        b=jwNhYQaO8zL7jXHQfM8eVRL4d7S2KD/ubGv6/Ueqdh4F+XVKxMW39svN3nZ1h/+Mey
         3OWmoIr4tqI9Zj+aRRJEnHDnsxezwvBTjDwMN1tPfA13Xl8U7I00Amu5WUecXnS0cdhT
         vTrXQheiD9bn8WD06tUW+0k4wzl+UP0EWRC6SHqjJhyB/sM0R5TT4NfD0jQDoGXtup9P
         jIsGuQH4QtCoziNj0KI2XAi5ZTZJNMZ6amme9vv6eES8aUZrgCHlfPb4JsUSnaUxQEkQ
         MG3849M4kjEjHgz1H+6Pwo5R/nDjD746gljFF4IM7yrSlIpz4Ayx9oWcwAwiPqh+vE5k
         V7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678377988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+eaOZDAMP7IVRiUMgwsXxeXZaTP/ZiwfvsJ/oitRkE=;
        b=ELeK0toV74OSd0zSl2qfzrlx4kPnrQFoC+kxb/1O0QmhT3/n5ouRG5EleL0LB8ir6m
         aHxx61IdTr2NUJ5SurrTBKg0YYNTbtdGm1roLVyFzcaJ/tfwE95F1kqfOetNPCUjGBRv
         I3Yxkpfsqe5b5P1KsL3kxRdLo1tHSTnmtOhnKlEJ6dP508rm61CpC9hNTeSsW4iuQTO8
         5O5OQ+RZnjN4DRTOaPHQpJvjXPA0pOmpYZBVHDKSPc9kBSPwp5VUnSRlvuUhxVphQtN0
         9kmaYs33CYFkFAU2jot5kY/E0KuU1aD7sHl9lzQYfsg3VopKYTgKVPo1tIyzsi+rSqip
         P9bQ==
X-Gm-Message-State: AO0yUKXfWsrSi6PdKYSkdFE/PdQodsMsYxPWnumgu5nPobJ43m5ltlXY
        R5znEtmNKfVs2FUOjY8T7P+PgFF6bIr/AAN11M2exg==
X-Google-Smtp-Source: AK7set8etm+E2EsgEPngtG0ZgDECjzjDsAcSW+OuwThkkMo2kj6ubmzJbJoEjzJQyp3DYFxy8Ou8Dq2kT3+UNNfN4jQ=
X-Received: by 2002:a17:90a:c257:b0:233:bada:17b5 with SMTP id
 d23-20020a17090ac25700b00233bada17b5mr8283000pjx.4.1678377988477; Thu, 09 Mar
 2023 08:06:28 -0800 (PST)
MIME-Version: 1.0
References: <20230309004836.2808610-1-jesussanp@google.com> <167832601863.28104.18004021177531379064.git-patchwork-notify@kernel.org>
In-Reply-To: <167832601863.28104.18004021177531379064.git-patchwork-notify@kernel.org>
From:   Jesus Sanchez-Palencia <jesussanp@google.com>
Date:   Thu, 9 Mar 2023 08:06:17 -0800
Message-ID: <CAK4Nh0gOSHfwb8Yuv_YAhKHH+gTr=rqt+ZnQi1yXQ7qLiqu21w@mail.gmail.com>
Subject: Re: [PATCH] Revert "libbpf: Poison strlcpy()"
To:     andrii@kernel.org
Cc:     bpf@vger.kernel.org, sdf@google.com, rongtao@cestc.cn,
        daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 8, 2023 at 5:40=E2=80=AFPM <patchwork-bot+netdevbpf@kernel.org>=
 wrote:
>
> Hello:
>
> This patch was applied to bpf/bpf-next.git (master)
> by Andrii Nakryiko <andrii@kernel.org>:

Andrii, are you planning to send this patch to 6.3-rc* since the build
is broken there?
Just double-checking since it was applied to bpf-next.

Thanks,
Jesus
