Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870886EE665
	for <lists+bpf@lfdr.de>; Tue, 25 Apr 2023 19:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbjDYRMk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Apr 2023 13:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjDYRMj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 13:12:39 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEF4E71
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 10:12:37 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63b73203e0aso36998383b3a.1
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 10:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682442757; x=1685034757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkGbCo2c46LmsAkGrT6H0RZ5+yrOxfWeFrMc4qNAiC8=;
        b=M5bsNmSOotsPo9F2oTzOUDu+n9BgvKgTxmEoMwz/WWZV/oqGCuza08Ko8cAO0wxXUR
         0YUTvoVsbnqOMAuRc1yU6AcIMCQFjcYTTikwADpC3R4JnwfuYltI2qtTrREbYx9mrI4O
         q+FV3nAV55Ye50S80WuUh6gVBhFhac1yjGAF7eB2P9RYK0CQPI6YQV20l/Muguu3v8WE
         TOsJal0buPsnJ6JU+ZEzObjcjMKucqY2Q+m8W2BLUmffeIYsqcu2t2k2jsFWEn1rfWD9
         dl01HhZ90zvAgcUYlkrrZ4/cglqxNVcdn4eNmqTAkfV5Blsf6g/S2Y0d2SsNIVRipdgn
         UeeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682442757; x=1685034757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HkGbCo2c46LmsAkGrT6H0RZ5+yrOxfWeFrMc4qNAiC8=;
        b=GMZ/FuT3NmWmoPkcIPg7JUAfa2k6PL8f/1RcZZi1RZ+Iq/7e9hs1S+zpB/jKjtYzQB
         giLG+dTxJFDr7Vok+0VRlijyNA7W2q5lT+nFiE6TgTewq+a3oqJaL2xjNmmOG5ohAsoQ
         Bqsfdv3A/UodGsruscFWafqfooTONcqC4HIyHIF5N+2w0vZ4YqoJXPRVUInVOaGqPjIx
         MvzxdvctuB/bW+MrSxwNIOPFZvohK/JEV2YDIGGg91XMmv189L0LqJ3o7dFRPlNh+0yS
         qUzeyuabfJUDsuAhqvHu2AFH6QcQ0V/BQw9r8i45PY3WeM1Vx2xtEpUM0tqT/0OV/7XQ
         jJGw==
X-Gm-Message-State: AAQBX9cxDKYma0gvYPwdRx2qV7O8U6kBiAaPOG7VK/dZfWb+Wf0twjkC
        2OPEufZz+ld1k+60yhxlkSuGoqL38P89jofQxdAAsg==
X-Google-Smtp-Source: AKy350ayyf7RWTlxys1UzmWAmYZ7xYhWeHAGf5fOalmEPpn3WqekHWTMOaCtBxxpf60qcxB7gNc3hebaAmYxtPGZhl0=
X-Received: by 2002:a17:90b:3a8e:b0:247:85d2:808f with SMTP id
 om14-20020a17090b3a8e00b0024785d2808fmr24484993pjb.12.1682442757126; Tue, 25
 Apr 2023 10:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230418225343.553806-1-sdf@google.com> <20230418225343.553806-4-sdf@google.com>
 <4a2e1b70-9055-f5d9-c286-3e5760f06811@iogearbox.net> <CAKH8qBshg+bF59LUXypxvPX1Gek2AASL+DQydVLMgqGT4ONfGQ@mail.gmail.com>
 <f68fc5d8-9bd7-19b2-0e57-8ba746295d37@linux.dev>
In-Reply-To: <f68fc5d8-9bd7-19b2-0e57-8ba746295d37@linux.dev>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 25 Apr 2023 10:12:26 -0700
Message-ID: <CAKH8qBsVw=my-pB5Mnmyq-Cp0a1by-nS_=Fyu7cZTmiKk8niXw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/6] bpf: Don't EFAULT for {g,s}setsockopt with
 wrong optlen
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Apr 24, 2023 at 5:56=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 4/21/23 9:09 AM, Stanislav Fomichev wrote:
> > On Fri, Apr 21, 2023 at 8:24=E2=80=AFAM Daniel Borkmann <daniel@iogearb=
ox.net> wrote:
> >>
> >> On 4/19/23 12:53 AM, Stanislav Fomichev wrote:
> >>> Over time, we've found out several special socket option cases which =
need
> >>> special treatment. And if BPF program doesn't handle them correctly, =
this
> >>> might EFAULT perfectly valid {g,s}setsockopt calls.
> >>>
> >>> The intention of the EFAULT was to make it apparent to the
> >>> developers that the program is doing something wrong.
> >>> However, this inadvertently might affect production workloads
> >>> with the BPF programs that are not too careful.
> >>
> >> Took in the first two for now. It would be good if the commit descript=
ion
> >> in here could have more details for posterity given this is too vague.
> >
> > Thanks! Will try to repost next week with more details.
> >
> >>> Let's try to minimize the chance of BPF program screwing up userspace
> >>> by ignoring the output of those BPF programs (instead of returning
> >>> EFAULT to the userspace). pr_info_ratelimited those cases to
> >>> the dmesg to help with figuring out what's going wrong.
> >>>
> >>> Fixes: 0d01da6afc54 ("bpf: implement getsockopt and setsockopt hooks"=
)
> >>> Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> >>> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> >>> ---
> >>>    kernel/bpf/cgroup.c | 8 ++++++--
> >>>    1 file changed, 6 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> >>> index a06e118a9be5..af4d20864fb4 100644
> >>> --- a/kernel/bpf/cgroup.c
> >>> +++ b/kernel/bpf/cgroup.c
> >>> @@ -1826,7 +1826,9 @@ int __cgroup_bpf_run_filter_setsockopt(struct s=
ock *sk, int *level,
> >>>                ret =3D 1;
> >>>        } else if (ctx.optlen > max_optlen || ctx.optlen < -1) {
> >>>                /* optlen is out of bounds */
> >>> -             ret =3D -EFAULT;
> >>> +             pr_info_ratelimited(
> >>> +                     "bpf setsockopt returned unexpected optlen=3D%d=
 (max_optlen=3D%d)\n",
> >>> +                     ctx.optlen, max_optlen);
> >>
> >> Does it help any regular user if this log message is seen? I kind of d=
oubt it a bit,
> >> it might create more confusion if log gets spammed with it, imo.
> >
> > Agreed, but we need some way to let the users know that their bpf
> > program is doing the wrong thing (if they set the optlen too high for
> > example).
>
> imo, I also think a printk here will be a noise in dmesg most of the time=
 (but
> much better than an unexpected -EFAULT).

I was thinking for a v2, maybe print it at least once? Similar to
current bpf_warn_invalid_xdp_action?


> > Any other better alternatives to expose those events?
>
> Is it possible to only -EFAULT when the bpf prog setting a ctx.optlen lar=
ger
> than the "original" user provided optlen?
> Ignore for all other cases that is due to the current PAGE_SIZE limitatio=
n?

Should be possible. That "ctx.optlen > PAGE_SIZE && ctx.optlen <
original_optlen" is the condition where we'd silently ignore BPF
output.
As per above, I'll stick a line to the dmest (similar
bpf_warn_invalid_xdp_action), at least to record that this has
happened once.
LMK if you or Danial still don't see a value in printing this..
