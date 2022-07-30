Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC0B58578B
	for <lists+bpf@lfdr.de>; Sat, 30 Jul 2022 02:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbiG3AYa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 20:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiG3AY3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 20:24:29 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9802F275C2
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 17:24:28 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id e12so2204564qkl.2
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 17:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5wYeNl+twD0S1pvdfZUyIE4BaukcUkJ+DkYiJJ23zw0=;
        b=Vau/a8uF9TmGWPjkL1/jomPE8vEIq9NcChnp4JhzMLY1YFhwBuavzsSkDVW8iVdtt1
         NtrmTg4M2TfCXtmK8AHPmW3pAwjpcS0GijZqs9TBt3elo4iHcO0GltCQQgS/GgEAxYdR
         Aa+UQsOmkDvT8n02JGhaxpFvVy+ivp6WHUPtk3I7fMyjd/elwCseebPOEHFhZ2b9Yg0p
         2vvS9jFK8YeMSHHXCgdrFUExF+3dii4PWuwLXDUGuVJpIEAN7KCJFtoGB5j4O38Vqh62
         TpCJqxnsSN4wq/6TIuRb76PAtw3HVus8ff9ntIQ4Kp14JKbp0ex06SGPBbNC6/pv/OWC
         ry4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5wYeNl+twD0S1pvdfZUyIE4BaukcUkJ+DkYiJJ23zw0=;
        b=P9y01M2Sz1LvlgqYtMdZUCpBcHJQSEe0xWUEMOlbfTQVBmnEVhHDmh7U9Q7fugkpjV
         YGuSjZVksu+ys4zdcdgeb05Ec0u+nAhSovivfkZM9rfOcr3OcZTpPCUMxQYjioyKuGSY
         SwKsBAR/G9wb2J3bcSm9gxNLs2X52IcoxD08YQzA8ghmt6Zw7G6GMMRzu/xg6iRZwUK9
         HnDeZU57PHPSKmeRrZJ/FYHb0WfWrmPte43T3kdVh/CN5Mb0H86TrCcdFKRkON01d7XE
         VWxRX1LdkoNBygjbCDcIxEvaDXcI+v3rjPCL1iNW3ZWJ+sNmV0B0dA8sXT8iw6zmYdhD
         WbKw==
X-Gm-Message-State: AJIora9lc12HBCMd4xkQcsTaWQe85EdpMzOeAf56ItuFHaBTsBW7CK0K
        s6srBjP0hmTkbk2SR3L4D5f9F5kQEvbta9FRJqUwmg==
X-Google-Smtp-Source: AGRyM1tGCAmRt37YUth3Qv1BgQnIAAw7D7/wMhYe1ipuSuKIi1u/SjBRFG0VrC+se9ciEBkHlef98P7t9uM05omtAgk=
X-Received: by 2002:a37:953:0:b0:6b6:4a0d:9ea2 with SMTP id
 80-20020a370953000000b006b64a0d9ea2mr4638968qkj.221.1659140667661; Fri, 29
 Jul 2022 17:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220730000809.312891-1-sdf@google.com>
In-Reply-To: <20220730000809.312891-1-sdf@google.com>
From:   Hao Luo <haoluo@google.com>
Date:   Fri, 29 Jul 2022 17:24:16 -0700
Message-ID: <CA+khW7iRn0sLeR25gu5Gz1aT6MAk3ZTWD7C0iWPfVP3tC=TDLw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: use proper target btf when exporting attach_btf_obj_id
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Jul 29, 2022 at 5:08 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> When attaching to program, the program itself might not be attached
> to anything (and, hence, might not have attach_btf), so we can't
> unconditionally use 'prog->aux->dst_prog->aux->attach_btf'.
> Instead, use bpf_prog_get_target_btf to pick proper target btf:
>
> * when attached to dst_prog, use dst_prog->aux->btf
> * when attached to kernel btf, use prog->aux->attach_btf
>
> Fixes: b79c9fc9551b ("bpf: implement BPF_PROG_QUERY for BPF_LSM_CGROUP")
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Looks good to me.

Acked-by: Hao Luo <haoluo@google.com>

Hao
