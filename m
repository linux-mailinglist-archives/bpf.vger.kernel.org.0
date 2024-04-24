Return-Path: <bpf+bounces-27676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7148B0896
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 13:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B5561F24610
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 11:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DFA15A4BA;
	Wed, 24 Apr 2024 11:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxhTzRSh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BEA15A4BC
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 11:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713959181; cv=none; b=QBZh9GK/p9uv1FiuwdCXC39dYD687BkAt055qZHh/iISKQZJHab5+vM4qhQGHOPSBV1WfbHAgN5iDS0r8hoXJ3bsXDQiNx404H1pyNE+9TgE255bBeLfVIPA45nib3OoB0Gxq2xMmrO8kM1l7sxju2WFLKrsudWDqPecNWi2MLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713959181; c=relaxed/simple;
	bh=y6Srj4lFKW4Q/6g1k2X34ohhTY6m3/28eV0FUHQ36Jc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmvBB5+rT+wA8rYSxrIfDV+fSbtVwIWc8H9qlWCeB4l36lCAwZMaWYxJElxyvOnp+WnI1aV6kMuH0p1aYJTQeo9hvLLgy2HzfaNpbYQPrMgEAy5fAVO5b94E8Gkg0sUlv84orTnesTEQCsZMLuNBjqQhyntQNPg1wv2QvKgmMTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxhTzRSh; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a5894c1d954so22717666b.1
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 04:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713959178; x=1714563978; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cJ9SaWsoXrrIRixhToCG5jyAb+dgmPgkHGEHBCizlF8=;
        b=bxhTzRShm8NGmC/jwIUUdYxRl5KVZDP++DPFCcovVZ4IlmKzn6shLsz0JcRkj+uYVH
         9T3Yg1SZkHra/tL6dFH1iGCLqxJVzox2IXVp4Dbbetw26kAtitQwF6ENVpP3q0XgalrQ
         KFdvNarswNzVoVvGyaNINlhdmppk/0PNdJZJ4EmGbmDBEyLhK5h3u7FGXadNo/fxir2G
         uOmppgPe7zvzW899A969pkAMBA/waxQAfhhKLnwYwH4B/XRf1oJ1Mlfc5Blb++DixVBU
         B9tHek/G9NdMmI6hjUQfGVRrAjks0eRg0NllWw1/X4TcSWL/YRJYc7MYlKbLNcLM4Uj9
         H/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713959178; x=1714563978;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cJ9SaWsoXrrIRixhToCG5jyAb+dgmPgkHGEHBCizlF8=;
        b=FAKxRATSakTbpu0s/bmvBAq9U/F8mLUA8L1EsiRoWNMQoatwQSvpZX/EctUVEnbxfQ
         FsaJR4NCVu9Ehqg8ed8OApj1o9u7BuR1cBWSiGzt0IIGlh9r254O7sM15pMVABbYqTCt
         9X7PpMyGncXXpF4MjoA3Vi4bfEU1sjUxEzhcPBi360AByCSCnitcixbqp/0Plgc7jbOc
         cEKeKFtdRv0mHZiaWvxEtGFBDrlPkSw9QML1SLA3hG+3OpPGAqKhFfHaYbrmd1lKSvF2
         /TbkROp9raKWKf30EHOOUHgc6YmnJj37w30CRZXvz1VACJIhWuXRsn/OdxIbXoSbRMNN
         Uphg==
X-Forwarded-Encrypted: i=1; AJvYcCUR7FcNj6us5dKO4/r73on09V/P5laxZY7Dn6vpcFaLutRbg7l+CnpnYeIF3tCd9bfJ49OstyNUAAgk7tOF9WXmzIKN
X-Gm-Message-State: AOJu0YxS3PzqIzVUPmswOkGWVME+QOkqB/8HfMQFf0ffUb8tjj8EOIQ5
	ZdQelOP9FBS+gtmva5iqXb892q70ld257nt8l5NfyjK2Xt/ASNjn
X-Google-Smtp-Source: AGHT+IE/URGzKv5WzNwWQCbYBgS6eRoemBeIXHPRwJyLBmNno98hCgntL6/iarFzaDg0+VV5HThb3A==
X-Received: by 2002:a50:d718:0:b0:56e:10d3:85e3 with SMTP id t24-20020a50d718000000b0056e10d385e3mr1767967edi.13.1713959177903;
        Wed, 24 Apr 2024 04:46:17 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id z8-20020a50cd08000000b0056ff82e54a0sm8137671edi.31.2024.04.24.04.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 04:46:17 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 24 Apr 2024 13:46:15 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Viktor Malik <vmalik@redhat.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: [PATCH bpf-next 1/7] bpf: Add support for kprobe multi session
 attach
Message-ID: <ZijxB_pe6DiNuy-f@krava>
References: <20240422121241.1307168-1-jolsa@kernel.org>
 <20240422121241.1307168-2-jolsa@kernel.org>
 <CAEf4BzayRpyFu_UAR4aNvvpq8hzOWFgbcRSWTUgAM81OGcQGoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzayRpyFu_UAR4aNvvpq8hzOWFgbcRSWTUgAM81OGcQGoQ@mail.gmail.com>

On Tue, Apr 23, 2024 at 05:26:39PM -0700, Andrii Nakryiko wrote:
> On Mon, Apr 22, 2024 at 5:12 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding support to attach bpf program for entry and return probe
> > of the same function. This is common use case which at the moment
> > requires to create two kprobe multi links.
> >
> > Adding new BPF_TRACE_KPROBE_MULTI_SESSION attach type that instructs
> > kernel to attach single link program to both entry and exit probe.
> >
> > It's possible to control execution of the bpf program on return
> > probe simply by returning zero or non zero from the entry bpf
> > program execution to execute or not the bpf program on return
> > probe respectively.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/uapi/linux/bpf.h       |  1 +
> >  kernel/bpf/syscall.c           |  7 ++++++-
> >  kernel/trace/bpf_trace.c       | 28 ++++++++++++++++++++--------
> >  tools/include/uapi/linux/bpf.h |  1 +
> >  4 files changed, 28 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index cee0a7915c08..fb8ecb199273 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1115,6 +1115,7 @@ enum bpf_attach_type {
> >         BPF_CGROUP_UNIX_GETSOCKNAME,
> >         BPF_NETKIT_PRIMARY,
> >         BPF_NETKIT_PEER,
> > +       BPF_TRACE_KPROBE_MULTI_SESSION,
> 
> let's use a shorter BPF_TRACE_KPROBE_SESSION? we'll just know that
> it's multi-variant (there is no point in adding non-multi kprobes
> going forward anyways, it's a new default)
> 
> >         __MAX_BPF_ATTACH_TYPE
> >  };
> >
> 
> [...]
> 
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index afb232b1d7c2..3b15a40f425f 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -1631,6 +1631,17 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> >         }
> >  }
> >
> > +static bool is_kprobe_multi(const struct bpf_prog *prog)
> > +{
> > +       return prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI ||
> > +              prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI_SESSION;
> > +}
> > +
> > +static inline bool is_kprobe_multi_session(const struct bpf_prog *prog)
> 
> ditto, this multi is just a distraction at this point, IMO

ok, sounds good, will drop multi for session stuff

jirka

> 
> > +{
> > +       return prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI_SESSION;
> > +}
> > +
> >  static const struct bpf_func_proto *
> >  kprobe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> >  {
> 
> [...]

