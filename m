Return-Path: <bpf+bounces-11531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE7C7BB3C8
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 11:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56C031C20A54
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 09:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AFB1171A;
	Fri,  6 Oct 2023 09:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZa02X+k"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5830010969
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 09:05:25 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F111F93;
	Fri,  6 Oct 2023 02:05:23 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3231d6504e1so1719922f8f.2;
        Fri, 06 Oct 2023 02:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696583122; x=1697187922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tV8vdtRv0dLgQHb0i++2h3/DMYxrtErGTtvFqRlaYuM=;
        b=dZa02X+kRu9jyFk9y1mToMqN33813nIXY7XQmwBsE+PgI7CrbMS1sTE/Wgl06sM04R
         NySjt3Hn44CQrU0Z9OQY0qsThUsWktrF6eu8Ax4bdcqmS9sGFWXg8oZa5OTP7h+6b7W3
         h6HbSW2iizKvk0r1HV00dqj4/wFrXzkSv8qqhcpd9H8ItTg+FV42T8KV7MFgbRvbMJ3+
         Sm/rdBLzzqoLbKAdRLtNV9olcAsa9BlOQYGbbbwGv3T1TWyxpWtP4gV1uglDmbBHOan7
         QBtw1tc4MuDkgZt4TEiKocPKByUQ5KMWVuj4QD0wZhaiLQgQRgP0vGXRpdF2/GOEdoIp
         6U+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696583122; x=1697187922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tV8vdtRv0dLgQHb0i++2h3/DMYxrtErGTtvFqRlaYuM=;
        b=mTZkyA/+gUWs+4hKxw4SKFPhquL2gIo3+/bQQYul4m9LUfZGW1iLt/QLCkKZ55qS5j
         DWuWT2AeuJ8Et8MRqx8QAx96qB3/gb2YHwO7wED5ZkB5qE+g6KrHdoKBFddBNtjJFT+K
         Z1vVQc4rT+T4bqM57QbeyYzXkRBB9CoX+FmYjkz2kM30G5StbS8nEhjB5E1X91MeX+Hf
         gctu73srKOtZ6aWvgbr+H8VHZP37b+fwSIaPFoxO45zpi8PxrsXgU4CPnLeNv8xHH6rN
         jFkFG9VOU7Ab3jXApjZOCO2U0Q6VGNHtBSybGwYRloDD3nsLBJyvM+PSBbSBm9RrHx8S
         wWcQ==
X-Gm-Message-State: AOJu0YwtOfKtDZaQSEFkJdX2WwXCJVd/1Umy4OUmaEvl24gJxcB9qk5V
	x/n2QfkKhANOAs3xjePcxLs=
X-Google-Smtp-Source: AGHT+IHw6Yxkg8as3r/flQofvYoN/GP3MsFDBicu3V1whChqfhmdL98ABCljUUSixXXHiG2DHxuQSA==
X-Received: by 2002:a05:6000:18b:b0:323:1689:6607 with SMTP id p11-20020a056000018b00b0032316896607mr6995613wrx.5.1696583121924;
        Fri, 06 Oct 2023 02:05:21 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id n9-20020adff089000000b0031ad2f9269dsm1167270wro.40.2023.10.06.02.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 02:05:21 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 6 Oct 2023 11:05:19 +0200
To: KP Singh <kpsingh@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org, paul@paul-moore.com, keescook@chromium.org,
	casey@schaufler-ca.com, song@kernel.org, daniel@iogearbox.net,
	ast@kernel.org, renauld@google.com
Subject: Re: [PATCH v5 4/5] bpf: Only enable BPF LSM hooks when an LSM
 program is attached
Message-ID: <ZR/Nz+aPH4sIQMwT@krava>
References: <20230928202410.3765062-1-kpsingh@kernel.org>
 <20230928202410.3765062-5-kpsingh@kernel.org>
 <ZR5vSyyNGBb8TvNH@krava>
 <CACYkzJ69x9jX3scjSA7zT99CJoM+eG6FDQdBT-SCxm47a6UEoA@mail.gmail.com>
 <CACYkzJ7Q0NEc9HThS1DZr0pMC+zO0GSToWmwQkTgXTeDs5VKaw@mail.gmail.com>
 <ZR6/iMnfl1q6Hf9I@krava>
 <CACYkzJ7aeBjMFTrBPf5u-Wib0Jk=rOX31yeBT5koUt=iYUF2MA@mail.gmail.com>
 <ZR+2+gQ3B3tgFI/8@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZR+2+gQ3B3tgFI/8@krava>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 06, 2023 at 09:27:57AM +0200, Jiri Olsa wrote:

SNIP

> >  static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
> > struct bpf_trampoline *tr)
> >  {
> >         enum bpf_tramp_prog_type kind;
> >         struct bpf_tramp_link *link_exiting;
> > -       int err = 0, num_lsm_progs = 0;
> > +       int err = 0;
> >         int cnt = 0, i;
> > 
> >         kind = bpf_attach_type_to_tramp(link->link.prog);
> > @@ -547,15 +566,14 @@ static int __bpf_trampoline_link_prog(struct
> > bpf_tramp_link *link, struct bpf_tr
> >                 /* prog already linked */
> >                 return -EBUSY;
> > 
> > -               if (link_exiting->link.prog->type == BPF_PROG_TYPE_LSM)
> > -                       num_lsm_progs++;
> >         }
> > 
> > -       if (!num_lsm_progs && link->link.prog->type == BPF_PROG_TYPE_LSM)
> > -               bpf_lsm_toggle_hook(tr->func.addr, true);
> > -
> >         hlist_add_head(&link->tramp_hlist, &tr->progs_hlist[kind]);
> >         tr->progs_cnt[kind]++;
> > +
> > +       if (link->link.prog->type == BPF_PROG_TYPE_LSM)
> > +               bpf_trampoline_toggle_lsm(tr, kind);
> 
> how about keeping BPF_PROG_TYPE_LSM progs type count of attached programs
> in bpf_trampoline and toggle lsm on first coming in and last going out?

hm we actually allow other tracing program types to attach to bpf_lsm_*
functions, so I wonder we should toggle the lsm hook for each program
type (for bpf_lsm_* trampolines) because they'd expect the hook is called

but I'm not sure it's a valid use case to have like normal fentry program
attached to bpf_lsm_XXX function

jirka

> 
> also the trampoline attach is actually made in bpf_trampoline_update,
> so I wonder it'd make more sense to put it in there, but it's already
> complicated, so it actually might be easier in here
> 
> jirka
> 
> > +
> >         err = bpf_trampoline_update(tr, true /* lock_direct_mutex */);
> >         if (err) {
> >                 hlist_del_init(&link->tramp_hlist);
> > @@ -578,7 +596,6 @@ static int __bpf_trampoline_unlink_prog(struct
> > bpf_tramp_link *link, struct bpf_
> >  {
> >         struct bpf_tramp_link *link_exiting;
> >         enum bpf_tramp_prog_type kind;
> > -       bool lsm_link_found = false;
> >         int err, num_lsm_progs = 0;
> > 
> >         kind = bpf_attach_type_to_tramp(link->link.prog);
> > @@ -595,18 +612,14 @@ static int __bpf_trampoline_unlink_prog(struct
> > bpf_tramp_link *link, struct bpf_
> >                                      tramp_hlist) {
> >                         if (link_exiting->link.prog->type == BPF_PROG_TYPE_LSM)
> >                                 num_lsm_progs++;
> > -
> > -                       if (link_exiting->link.prog == link->link.prog)
> > -                               lsm_link_found = true;
> >                 }
> >         }
> > 
> >         hlist_del_init(&link->tramp_hlist);
> >         tr->progs_cnt[kind]--;
> > 
> > -       if (lsm_link_found && num_lsm_progs == 1)
> > -               bpf_lsm_toggle_hook(tr->func.addr, false);
> > -
> > +       if (link->link.prog->type == BPF_PROG_TYPE_LSM)
> > +               bpf_trampoline_toggle_lsm(tr, kind);
> >         return bpf_trampoline_update(tr, true /* lock_direct_mutex */);
> >  }
> > 
> > 
> > - KP

