Return-Path: <bpf+bounces-23033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2854786C6A8
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 11:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D6BA1F21486
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 10:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BBA6214D;
	Thu, 29 Feb 2024 10:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbtVp8C5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757AF64CC0
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 10:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709201817; cv=none; b=sJGTn4pHXJxQGBzeGhgxPjFNunQtSkyDB7IOAjAoMz3LdeNzAMThDnpt9M4t6QHOk/JDQ9/kbETViQYPnTrEB5EvWW4dticoo7SSTE0WwB42A6lsMD4t/BBmMLg7LI1/mLiZrcfmP2zMYWDypojFR0x/W9PcBx+RN+mpWxVGwqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709201817; c=relaxed/simple;
	bh=8pp7/1kEedQf+zGsdpnksWd3El4sHvQFV3zwW82ZB+Q=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XE0F/uPtoUpzhh8CurlV8yW2XfeXVv9p/MXqHHwbS6iVYdVZmq5f/8X1eiFQPA3LXwxQscAlkszriNNdUpsAyw0w6u9/QvTAOTth00/FPgdMEYGPhykdHKCtmrfKZA5opK3xGBUAHZ0iBwx9HRiUPSeyszrsoxetIdUUhNPfDT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbtVp8C5; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-565d1656c12so1273167a12.1
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 02:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709201814; x=1709806614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AM3FYonI9DWBM6xfkrt5C2DDDigbk3WvqdygTy8criY=;
        b=jbtVp8C57pSCk1sFMC9yUaLzNlQcP/KY9UjnYPkstEXz8rfFIfKp1tAUch3fINaSW2
         qhS1Jzuk0Epu+jvQXanOK5MZYDzvw2UbZAZ+f236hIFZU0yqZe3KalpJmzzwE8HT9Buz
         PMZL9lzBP7Aeg+7kxqQVpuIJF1WkhD342jNQNhjRx/LjlzYoDhHYDZPIJJHIVMWL4iGE
         oECxBp5YA3RlA3mWkJaNOXCNlJsBLgzYzWltggn+JJ5YT9VCwN4BMh8Tb6qENmliortR
         60qYfggCbVYJDtjJ12C0P0T7v6Z8eDTyrpkwOM8WVzxVUnoYqUUKXs135A4pB5lHAbd9
         2I3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709201814; x=1709806614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AM3FYonI9DWBM6xfkrt5C2DDDigbk3WvqdygTy8criY=;
        b=qFohbsi2ge9y/udiPhgFP10JYKk6Pi41In5ugAhdsEz1H1hpXMum8V9H9iMda++ORf
         y82zcMYxRmnWF4Likhmee2p1/R/I4iDTPQNY3KO+hsvhK0zGl99S+sCSofc/SKneyHJj
         glekgm7uagtXJ3uG9Fj5MfBTKfrF75ouskEE5YzyBqppdndrBfGPARhj1Mhtx3svMGST
         YijzD8MzYq9NC8zpwiO8urPsZ151wRn75+M70RpVNd2RkXnRaSmB1vYIvrLlWRAMew2W
         9ZUKn7ZMosQUfrKOCbBCxp3QLzRtuS7woPjtVRxvpFzBjzaXx9w1Z9CTecaikjyJRwB7
         g4dA==
X-Forwarded-Encrypted: i=1; AJvYcCWOvQqTp/8U6iVwYwWHgRk2UWMzG5+iJV3wl+lS8lYJn/LpzfvlIHNzGFJ5T33bqaIvIUZ8Xu5x5JnrnHiqXlxCyLJ6
X-Gm-Message-State: AOJu0YzsiZo5bLu1R3TjmDDBa2ANIOf3GW4vMlcC15pK0uJaiZAyUdh5
	WdqyzgPwY41828Ck0K6aLjH00+7CFKzJu2UDzMw4cIJiBPlP6uQL
X-Google-Smtp-Source: AGHT+IHKGSb+W3Ij1gEQ2EabGpM3RzLJOAuRe5+N3f4lEK6JlI1cB5dGZBbd5uheXIbsVki5LEDMuA==
X-Received: by 2002:a05:6402:354b:b0:565:78ff:f066 with SMTP id f11-20020a056402354b00b0056578fff066mr1242029edd.5.1709201813498;
        Thu, 29 Feb 2024 02:16:53 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id m5-20020a509305000000b0056676b80a38sm493308eda.3.2024.02.29.02.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 02:16:53 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 29 Feb 2024 11:16:50 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH RFCv2 bpf-next 2/4] bpf: Add bpf_kprobe_multi_is_return
 kfunc
Message-ID: <ZeBZkmZwYqT7o4So@krava>
References: <20240228090242.4040210-1-jolsa@kernel.org>
 <20240228090242.4040210-3-jolsa@kernel.org>
 <CAEf4Bzbga6PK8UNUO5ZHL0Zo3t6xQ8S0tY4Da6aB+AFvm_jjsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzbga6PK8UNUO5ZHL0Zo3t6xQ8S0tY4Da6aB+AFvm_jjsQ@mail.gmail.com>

On Wed, Feb 28, 2024 at 05:23:45PM -0800, Andrii Nakryiko wrote:

SNIP

> >  static int
> >  kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
> > -                          unsigned long entry_ip, struct pt_regs *regs)
> > +                          unsigned long entry_ip, struct pt_regs *regs,
> > +                          bool is_return)
> >  {
> >         struct bpf_kprobe_multi_run_ctx run_ctx = {
> >                 .link = link,
> >                 .entry_ip = entry_ip,
> > +               .is_return = is_return,
> >         };
> >         struct bpf_run_ctx *old_run_ctx;
> >         int err;
> > @@ -2830,7 +2833,7 @@ kprobe_multi_link_handler(struct fprobe *fp, unsigned long fentry_ip,
> >         int err;
> >
> >         link = container_of(fp, struct bpf_kprobe_multi_link, fp);
> > -       err = kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs);
> > +       err = kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs, false);
> >         return link->is_wrapper ? err : 0;
> >  }
> >
> > @@ -2842,7 +2845,7 @@ kprobe_multi_link_exit_handler(struct fprobe *fp, unsigned long fentry_ip,
> >         struct bpf_kprobe_multi_link *link;
> >
> >         link = container_of(fp, struct bpf_kprobe_multi_link, fp);
> > -       kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs);
> > +       kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs, true);
> >  }
> >
> >  static int symbols_cmp_r(const void *a, const void *b, const void *priv)
> > @@ -3111,6 +3114,46 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
> >         kvfree(cookies);
> >         return err;
> >  }
> > +
> > +__bpf_kfunc_start_defs();
> > +
> > +__bpf_kfunc bool bpf_kprobe_multi_is_return(void)
> 
> and for uprobes we'll have bpf_uprobe_multi_is_return?...

yes, but now I'm thinking maybe we could also have 'session' api and
have single 'bpf_session_is_return' because both kprobe and uprobe
are KPROBE program type.. and align it together with other session
kfuncs:

  bpf_session_is_return
  bpf_session_set_cookie
  bpf_session_get_cookie

> 
> BTW, have you tried implementing a "session cookie" idea?

yep, with a little fix [0] it's working on top of Masami's 'fprobe over fgraph'
changes, you can check last 2 patches in [1] .. I did not do this on top of the
current fprobe/rethook kernel code, because it seems it's about to go away

I still need to implement that on top of uprobes and I will send rfc, so we can
see all of it and discuss the interface

jirka


[0] https://lore.kernel.org/bpf/ZdyKaRiI-PnG80Q0@krava/
[1] https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/log/?h=bpf/session_data

> 
> 
> > +{
> > +       struct bpf_kprobe_multi_run_ctx *run_ctx;
> > +
> > +       run_ctx = container_of(current->bpf_ctx, struct bpf_kprobe_multi_run_ctx, run_ctx);
> > +       return run_ctx->is_return;
> > +}
> > +
> > +__bpf_kfunc_end_defs();
> > +
> > +BTF_KFUNCS_START(kprobe_multi_kfunc_set_ids)
> > +BTF_ID_FLAGS(func, bpf_kprobe_multi_is_return)
> > +BTF_KFUNCS_END(kprobe_multi_kfunc_set_ids)
> > +
> > +static int bpf_kprobe_multi_filter(const struct bpf_prog *prog, u32 kfunc_id)
> > +{
> > +       if (!btf_id_set8_contains(&kprobe_multi_kfunc_set_ids, kfunc_id))
> > +               return 0;
> > +
> > +       if (prog->expected_attach_type != BPF_TRACE_KPROBE_MULTI)
> > +               return -EACCES;
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct btf_kfunc_id_set bpf_kprobe_multi_kfunc_set = {
> > +       .owner = THIS_MODULE,
> > +       .set = &kprobe_multi_kfunc_set_ids,
> > +       .filter = bpf_kprobe_multi_filter,
> > +};
> > +
> > +static int __init bpf_kprobe_multi_kfuncs_init(void)
> > +{
> > +       return register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &bpf_kprobe_multi_kfunc_set);
> > +}
> > +
> > +late_initcall(bpf_kprobe_multi_kfuncs_init);
> >  #else /* !CONFIG_FPROBE */
> >  int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> >  {
> > --
> > 2.43.2
> >

