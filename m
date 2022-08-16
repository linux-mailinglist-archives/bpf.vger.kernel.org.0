Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C611E5960EA
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 19:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiHPRTh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 13:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbiHPRTg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 13:19:36 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0810B52474
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 10:19:36 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id ha11so10305893pjb.2
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 10:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=QYvC55CINRyKt8ZXJPD8Vmw/q2RZTvM3BD649mxzcW8=;
        b=hltwmy85v3mdHKGqJvszTv2yyRaEilq0Z5l8ckMPgxM4yqFsTGBQJNDusBUtgUggLk
         AK5V6m0hX7Ela358hGbnoAibVvciRiugD+K7Q+T7ybaqNI7J+W4zMbWYpjtqHVy13aN6
         BVn7oCHnkfetvgFurSVD/YYOYtGdnHh1O6AL7/FJG+2yuYS57lMjjOIgPLpnf9CaMA8y
         8x3kXKYr0vwEzYVjg1DvdyVVKNgonIDTh84b7RExwydGZ7cZ5TSuKVHQrpzwjsJaxHcY
         7Cymll/XKWUJjKk/acwSORaFYLDe7Nt64yIZhXgQez6/gRpYEnuEoZgGeth8RBNtYvDW
         Soig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=QYvC55CINRyKt8ZXJPD8Vmw/q2RZTvM3BD649mxzcW8=;
        b=Uuz70PwwmXYEK7gKj82qcd/8z2DSCOoXatVPgh9GL8EFbR9EgA7KM84RSg0PPO/23u
         /nn55aY7NOnGz5itP5mz5aqgHuSPAuKZ7ccf+fTc7Zc7O3gyNEg1keOZy0fVTz0fPSVL
         qXFmPXMfUKdmA0Hd+yNVunHPwZDW4nCZt6jQ9yIrzhD6bCazG7IlDrCZ3EcLddcyBLMm
         Yk0q9CRMGsJnRTLRc76VHukykILofor6HMgf7ag6MMpp25RLY5C8yuvQ/Lcy3/D4zq56
         Jnq49+x0zgqNcUcL58beLFfk0x7PO5KQa2v/nlHAd42jwelep6XRnDmLak1nVb3s31JN
         Xl6A==
X-Gm-Message-State: ACgBeo1Q7zP2Qk251C6cCMbCkWeYCtllKVfvrets2wpa71tj8GVlNsQd
        ehK9Zesl/uVF8GI0Vq3J+2h/MjFIxbEPwgeoZAA4YQ==
X-Google-Smtp-Source: AA6agR5uqBmo0BYpPldTjV2bWFUwSKP7kDvgllIkUw7Eyt4/9xuFvNGkMuqpZ7x9WDw2Tm7RT5JcDbydtPNr7HI7FsE=
X-Received: by 2002:a17:90b:4b04:b0:1f5:2da0:b2f6 with SMTP id
 lx4-20020a17090b4b0400b001f52da0b2f6mr23949474pjb.195.1660670375364; Tue, 16
 Aug 2022 10:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220812190241.3544528-1-sdf@google.com> <20220812190241.3544528-3-sdf@google.com>
 <20220815215755.mzf456mgv3tx4vfe@kafai-mbp>
In-Reply-To: <20220815215755.mzf456mgv3tx4vfe@kafai-mbp>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 16 Aug 2022 10:19:24 -0700
Message-ID: <CAKH8qBu_CMn2sObNuQ7m0hUv=vcBYEe=wOVp8vA3T6KBVLPvCA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: use cgroup_{common,current}_func_proto
 in more hooks
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 15, 2022 at 2:58 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Fri, Aug 12, 2022 at 12:02:40PM -0700, Stanislav Fomichev wrote:
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index de7d2fabb06d..87ce47b13b22 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -1764,9 +1764,31 @@ cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> >       case BPF_FUNC_get_local_storage:
> >               return &bpf_get_local_storage_proto;
> >       case BPF_FUNC_get_retval:
> > -             return &bpf_get_retval_proto;
> > +             switch (prog->expected_attach_type) {
> > +             case BPF_CGROUP_SOCK_OPS:
> > +             case BPF_CGROUP_UDP4_RECVMSG:
> > +             case BPF_CGROUP_UDP6_RECVMSG:
> > +             case BPF_CGROUP_INET4_GETPEERNAME:
> > +             case BPF_CGROUP_INET6_GETPEERNAME:
> > +             case BPF_CGROUP_INET4_GETSOCKNAME:
> > +             case BPF_CGROUP_INET6_GETSOCKNAME:
> > +                     return NULL;
> > +             default:
> > +                     return &bpf_get_retval_proto;
> > +             }
> >       case BPF_FUNC_set_retval:
> > -             return &bpf_set_retval_proto;
> > +             switch (prog->expected_attach_type) {
> > +             case BPF_CGROUP_SOCK_OPS:
> > +             case BPF_CGROUP_UDP4_RECVMSG:
> > +             case BPF_CGROUP_UDP6_RECVMSG:
> > +             case BPF_CGROUP_INET4_GETPEERNAME:
> > +             case BPF_CGROUP_INET6_GETPEERNAME:
> > +             case BPF_CGROUP_INET4_GETSOCKNAME:
> > +             case BPF_CGROUP_INET6_GETSOCKNAME:
> > +                     return NULL;
> > +             default:
> > +                     return &bpf_set_retval_proto;
> > +             }
> Does it make sense to have bpf_lsm_func_proto() calling
> cgroup_common_func_proto() also?

Oh, sure, will do, thanks!
