Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CC7652835
	for <lists+bpf@lfdr.de>; Tue, 20 Dec 2022 22:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiLTVGu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 16:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiLTVGs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 16:06:48 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386241E3F3
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 13:06:47 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id t17so32291127eju.1
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 13:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fgd+XVLOiWp/PrwbFuLnLeERrwCx96by+t/nRr7B7Pg=;
        b=CCxdSELaTwcK1hDHyEjlFROnff89pthwX+yLXXYAmz1OWhaie1zksnlL6ysCG92f6U
         jduRORyaXNSSOFZ8Tv2luXRj4yMQmG6wRz5nvStA5BWQAYwqjq7cgWJ6OXoBTyulHssP
         UUnaEidK1gRha6Kkk8PyVYYlAESeTUDhFv/vEEm68dpEGegGK6/jvWcsITzGF3z5OXqs
         jn/odD+OrAq1Az+4WASwHcLzts1L5LhvotnBlbIqB6Atcp0qHWy2OQvzYiyX2idwzg0P
         elvKlyF+zFKcXqYHh0GHA0fjEayuxK6V/9ReeruqNOtUax1spBXVxe2t8rOcdREHJzMz
         Ft3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fgd+XVLOiWp/PrwbFuLnLeERrwCx96by+t/nRr7B7Pg=;
        b=wUf4gHO6aZJ5bZ3q18UqdgvOj/q7SXSxfYEm1PBfCJmwVz6MismQ2JTV8VnsQw7fDi
         i4l5UinEnJsl3Wfj4Zw+KAP0dKjuixhVUYafTmibkQtg1Ngz1rgV5e418wk/96Ja7exd
         dRxxOqVdeevSgUPLXU9fYjkb5k134JP9PzEPqeXt76C+vO9VDS2M8lt9dAGv8D96OFci
         Kff36MlLjLD6sX2JA5K77FRkj8ZYLjtAqZd4f5l+8P0vGJD5kFY75fDgo/ciDm+N8sm0
         H++HMaxplIzW3Rk2cnx6YOXbCBA0dQzw5WIBB3HVhGGo9xgWKJpLWEhycKkL7AxDGLxo
         tcsg==
X-Gm-Message-State: AFqh2koEpWHk6F0Bq3Joe+xPW3ZSQjEANB8Tsr/Q+BXClBMZ5qp2WsDm
        EkmLt7YbyJBI64K2WtaXjHJ6W8neK4afTGt7kYQ=
X-Google-Smtp-Source: AMrXdXszkBbqCV3GLtKcS0ov9k7+LjiIs2Djf2sR/OHvgk5lzZcrY+5YEe2mWFxLW5Kncm5RYVmARa51aE9GfSvozLo=
X-Received: by 2002:a17:906:360d:b0:7fd:f0b1:c8ec with SMTP id
 q13-20020a170906360d00b007fdf0b1c8ecmr886904ejb.114.1671570405746; Tue, 20
 Dec 2022 13:06:45 -0800 (PST)
MIME-Version: 1.0
References: <20221217021711.172247-1-eddyz87@gmail.com> <20221217021711.172247-4-eddyz87@gmail.com>
In-Reply-To: <20221217021711.172247-4-eddyz87@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 20 Dec 2022 13:06:33 -0800
Message-ID: <CAEf4BzYF7yheGNagx7Tx8r=Ma4mvx34VtQ8asEzEaxjAkh7urg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: reduce BPF_ID_MAP_SIZE to fit only
 valid programs
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 16, 2022 at 6:17 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> BPF limits stack usage by MAX_BPF_STACK bytes across all call frames,
> however this is enforced by function check_max_stack_depth() which is
> executed after do_check_{subprogs,main}().
>
> This means that when check_ids() is executed the maximal stack depth is not
> yet verified, thus in theory the number of stack spills might be
> MAX_CALL_FRAMES * MAX_BPF_STACK / BPF_REG_SIZE.
>
> However, any program with stack usage deeper than
> MAX_BPF_STACK / BPF_REG_SIZE would be rejected by verifier.
>
> Hence save some memory by reducing the BPF_ID_MAP_SIZE.
>
> This is a follow up for
> https://lore.kernel.org/bpf/CAEf4BzYN1JmY9t03pnCHc4actob80wkBz2vk90ihJCBzi8CT9w@mail.gmail.com/
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> ---

LGTM, thanks.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  include/linux/bpf_verifier.h | 4 ++--
>  kernel/bpf/verifier.c        | 6 ++++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 53d175cbaa02..da72e16f1dee 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -274,8 +274,8 @@ struct bpf_id_pair {
>  };
>
>  #define MAX_CALL_FRAMES 8
> -/* Maximum number of register states that can exist at once */
> -#define BPF_ID_MAP_SIZE ((MAX_BPF_REG + MAX_BPF_STACK / BPF_REG_SIZE) * MAX_CALL_FRAMES)
> +/* Maximum number of register states that can exist at once in a valid program */
> +#define BPF_ID_MAP_SIZE (MAX_BPF_REG * MAX_CALL_FRAMES + MAX_BPF_STACK / BPF_REG_SIZE)
>  struct bpf_verifier_state {
>         /* call stack tracking */
>         struct bpf_func_state *frame[MAX_CALL_FRAMES];
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a5255a0dcbb6..fb040516a946 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12951,8 +12951,10 @@ static bool check_ids(u32 old_id, u32 cur_id, struct bpf_id_pair *idmap)
>                 if (idmap[i].old == old_id)
>                         return idmap[i].cur == cur_id;
>         }
> -       /* We ran out of idmap slots, which should be impossible */
> -       WARN_ON_ONCE(1);
> +       /* Run out of slots in idmap, conservatively return false, cached
> +        * state will not be reused. The BPF_ID_MAP_SIZE is sufficiently
> +        * large to fit all valid programs.
> +        */
>         return false;
>  }
>
> --
> 2.38.2
>
