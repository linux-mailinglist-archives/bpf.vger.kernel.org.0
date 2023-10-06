Return-Path: <bpf+bounces-11518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D617BB221
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 09:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829C31C20A23
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 07:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4036AA2;
	Fri,  6 Oct 2023 07:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYRR1rKo"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DF463DA
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 07:28:02 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87B6F0;
	Fri,  6 Oct 2023 00:27:58 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99c136ee106so322831966b.1;
        Fri, 06 Oct 2023 00:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696577277; x=1697182077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3d1IEyUt5G0QrNV2XhIWZuD9qpRkSka5plbUV+63i40=;
        b=AYRR1rKo2H5GUJyWiY8vFLl6YULBzD5oCHWgJzQqwJIpAcqqO8s4cWXVRBCs0zJDcm
         FHQoocI4xRkRik5mNy9SUzOenY/yuhmfNrhFDO9ug+hxNsi4/IfehB/xMaR8Rns6MoVc
         fK1zYFugIvCO/dHx3tFiPCiSru4pO1grMW6PstMGkaGH7mczRFpXIB+IgLpPBiIgRYPf
         MxHSaI+ZyTpdJaZOq5UTOGpoTSh1/KaRmWRksMtgGwVyfRrIeN6rOFG7xH4PxMWCHxIM
         GMeQTnjqcVjTuK7Jyuhvidx51d46G7X5A4Ftbbf83DjanpMg0VEe8jJRrShdkX2dkwtV
         Jf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696577277; x=1697182077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3d1IEyUt5G0QrNV2XhIWZuD9qpRkSka5plbUV+63i40=;
        b=WvAJw83DVwzdfw+45YUq7ev/i4ujuZRpf1Xhf7+/kDZh05CnjTm8ZvJORr1hrICKmb
         XJH0oOFi8ZMRKykQIG0q3tR5FA6ZQURBnZqaZUCCzaX3zpON31fSoEXrqGfL7MGdDHiB
         OECMJVbo+SgFGhbIyMRXcIjIzhY/sqgTNcj/C56m47JobTmyIkFmJ210xu89q1JFv0EZ
         /G3TwkpwhFFaWxaPHs/8+BUsAGQudwbEu8tboJzoEmyjUiZmVb/5uHNI/15geFLNiTPX
         3gYTzfuI1AtBr6VQLSSSbPUGb3/lSX0KFZzEBsy9NLo+9Jf4DyREIZj/Isov7012BhG2
         JBDQ==
X-Gm-Message-State: AOJu0YxZWxQ2Paypv8PZojmeqjV4n0H5epsnzUvtSnOleo/L1F6SfTLs
	UyuGS06j+dpeZv5kh5RSy0HTn7+0WsQ=
X-Google-Smtp-Source: AGHT+IHrYGfzZeh1vJuc/LjDGdWJ4+7IpX8/bcxLxEEbaL/2vqfKa1DuaHUU0jNxcpeamtXj+Cw60Q==
X-Received: by 2002:a17:906:cc15:b0:9ad:ef31:6ef6 with SMTP id ml21-20020a170906cc1500b009adef316ef6mr6752160ejb.20.1696577276969;
        Fri, 06 Oct 2023 00:27:56 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id gx13-20020a170906f1cd00b009ad8d444be4sm2411412ejb.43.2023.10.06.00.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 00:27:56 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 6 Oct 2023 09:27:54 +0200
To: KP Singh <kpsingh@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org, paul@paul-moore.com, keescook@chromium.org,
	casey@schaufler-ca.com, song@kernel.org, daniel@iogearbox.net,
	ast@kernel.org, renauld@google.com
Subject: Re: [PATCH v5 4/5] bpf: Only enable BPF LSM hooks when an LSM
 program is attached
Message-ID: <ZR+2+gQ3B3tgFI/8@krava>
References: <20230928202410.3765062-1-kpsingh@kernel.org>
 <20230928202410.3765062-5-kpsingh@kernel.org>
 <ZR5vSyyNGBb8TvNH@krava>
 <CACYkzJ69x9jX3scjSA7zT99CJoM+eG6FDQdBT-SCxm47a6UEoA@mail.gmail.com>
 <CACYkzJ7Q0NEc9HThS1DZr0pMC+zO0GSToWmwQkTgXTeDs5VKaw@mail.gmail.com>
 <ZR6/iMnfl1q6Hf9I@krava>
 <CACYkzJ7aeBjMFTrBPf5u-Wib0Jk=rOX31yeBT5koUt=iYUF2MA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACYkzJ7aeBjMFTrBPf5u-Wib0Jk=rOX31yeBT5koUt=iYUF2MA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 05, 2023 at 06:07:28PM +0200, KP Singh wrote:

SNIP

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index df9699bce372..4f31384b5637 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -511,11 +511,30 @@ static enum bpf_tramp_prog_type
> bpf_attach_type_to_tramp(struct bpf_prog *prog)
>         }
>  }
> 
> +static void bpf_trampoline_toggle_lsm(struct bpf_trampoline *tr,
> +                                     enum bpf_tramp_prog_type kind)
> +{
> +       struct bpf_tramp_link *link;
> +       volatile bool found = false;
> +
> +       /* Loop through the links and if any LSM program is attached, ensure
> +        * that the hook is enabled.
> +        */
> +       hlist_for_each_entry(link, &tr->progs_hlist[kind], tramp_hlist) {
> +               if (link->link.prog->type == BPF_PROG_TYPE_LSM) {
> +                       found  = true;
> +                       break;
> +               }
> +       }
> +
> +       bpf_lsm_toggle_hook(tr->func.addr, found);
> +}
> +
>  static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
> struct bpf_trampoline *tr)
>  {
>         enum bpf_tramp_prog_type kind;
>         struct bpf_tramp_link *link_exiting;
> -       int err = 0, num_lsm_progs = 0;
> +       int err = 0;
>         int cnt = 0, i;
> 
>         kind = bpf_attach_type_to_tramp(link->link.prog);
> @@ -547,15 +566,14 @@ static int __bpf_trampoline_link_prog(struct
> bpf_tramp_link *link, struct bpf_tr
>                 /* prog already linked */
>                 return -EBUSY;
> 
> -               if (link_exiting->link.prog->type == BPF_PROG_TYPE_LSM)
> -                       num_lsm_progs++;
>         }
> 
> -       if (!num_lsm_progs && link->link.prog->type == BPF_PROG_TYPE_LSM)
> -               bpf_lsm_toggle_hook(tr->func.addr, true);
> -
>         hlist_add_head(&link->tramp_hlist, &tr->progs_hlist[kind]);
>         tr->progs_cnt[kind]++;
> +
> +       if (link->link.prog->type == BPF_PROG_TYPE_LSM)
> +               bpf_trampoline_toggle_lsm(tr, kind);

how about keeping BPF_PROG_TYPE_LSM progs type count of attached programs
in bpf_trampoline and toggle lsm on first coming in and last going out?

also the trampoline attach is actually made in bpf_trampoline_update,
so I wonder it'd make more sense to put it in there, but it's already
complicated, so it actually might be easier in here

jirka

> +
>         err = bpf_trampoline_update(tr, true /* lock_direct_mutex */);
>         if (err) {
>                 hlist_del_init(&link->tramp_hlist);
> @@ -578,7 +596,6 @@ static int __bpf_trampoline_unlink_prog(struct
> bpf_tramp_link *link, struct bpf_
>  {
>         struct bpf_tramp_link *link_exiting;
>         enum bpf_tramp_prog_type kind;
> -       bool lsm_link_found = false;
>         int err, num_lsm_progs = 0;
> 
>         kind = bpf_attach_type_to_tramp(link->link.prog);
> @@ -595,18 +612,14 @@ static int __bpf_trampoline_unlink_prog(struct
> bpf_tramp_link *link, struct bpf_
>                                      tramp_hlist) {
>                         if (link_exiting->link.prog->type == BPF_PROG_TYPE_LSM)
>                                 num_lsm_progs++;
> -
> -                       if (link_exiting->link.prog == link->link.prog)
> -                               lsm_link_found = true;
>                 }
>         }
> 
>         hlist_del_init(&link->tramp_hlist);
>         tr->progs_cnt[kind]--;
> 
> -       if (lsm_link_found && num_lsm_progs == 1)
> -               bpf_lsm_toggle_hook(tr->func.addr, false);
> -
> +       if (link->link.prog->type == BPF_PROG_TYPE_LSM)
> +               bpf_trampoline_toggle_lsm(tr, kind);
>         return bpf_trampoline_update(tr, true /* lock_direct_mutex */);
>  }
> 
> 
> - KP

