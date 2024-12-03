Return-Path: <bpf+bounces-45994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DC69E1918
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 11:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A3B128526F
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 10:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6261E1A27;
	Tue,  3 Dec 2024 10:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="i/r+K3U3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D24F1E0E1B
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 10:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733221287; cv=none; b=AHJ7XvUsJn4t75DEDD4FXpGfmvYjpVTrrMuUx7Xo6I7g4u5yLwlDipEOjQ+g9F10kgi85ui64jbA/bDbP+18obSC3FKVPbYgSlnBV4DmnwL8iSCo5lHshWm4/AiI/mmWNWH13PrBKKJhMTBZ7Qoknc24whzYX3w/yrzVN/kna34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733221287; c=relaxed/simple;
	bh=BDcwyOZwHmGiB6FBBohMjtdgw34qwUmmhREmQII79MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAXklRnDtBOQg6wm9W7BEWTniIPwOK+D6v3LsbNa8ItTkgoFGvZwD0R/CNTHZDNYnrB/f+r5oheWIYg7SgAWQXo26IwxvOFIHxqx43RLOUxCqMNkk4R7AH/vFvXXmSkAChS+SI1VF1C0uEz3dC5s6wMp1jh8+te3TuLwe8TLROI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=i/r+K3U3; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385eed29d7fso1528239f8f.0
        for <bpf@vger.kernel.org>; Tue, 03 Dec 2024 02:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1733221283; x=1733826083; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9J2WnNOrJKbxEs4W31fqfjUTLlj/5t0sxNWaIEgSrIU=;
        b=i/r+K3U3ugF0phON2tKw6tfH0yzDPVIk5Cs6pR/NCBaQr8+q0gE4oHPLYTOA+QETpA
         ozzhd/E9MnTUTFqkKqpI60pu+SmUhQRrn/Av4j/DBw6noPv2miQbKCqzuhogXNzFSGrX
         UZSfDpoE+RUMgYlshmahE1VWdtR7k25uCGrJht+25o8t4XWgJWEP45c7oEG0softYmH5
         fMby2E+4CeNOFFq77T+d+b6AwhHTu6QewpMF08utDy+MVcT2RqVVIVGRsmplevMN9gdn
         nEf3FQn1cz7xSCoe0lK8OT3+nHubbBt329NJHfHF8hGJOf2WWkJ6U1uAFxZmFmBm6d/R
         byXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733221283; x=1733826083;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9J2WnNOrJKbxEs4W31fqfjUTLlj/5t0sxNWaIEgSrIU=;
        b=IB69O9HMeaobMGuI0gVcSFrrg9vbPFbQ1kkZ0QrCXIg3BdW3bS7yDtTzfJJjVE6teZ
         KFzuvNSYg2lD/Iu0HvshFP/fP2dQrOIAeT87KvoF2AEggueFjN0+8hRRaiBFXA1UDUgX
         LKXcd/O8ANnkVJNPvyV+tWhYTaHko9fC2iUX0tr1JYbNsPn9XK2G8P4cyzFuAFSdoofi
         IWlw7iVtLqMUq3d0Q631Q67+/T1D0OEL0iaa99lejWyjTPrMd3T2wH0K8O17iopo6gGV
         dFD6RNP1R/LLk3kUWrNGtvKiocti/tzuMZj5QDtZTfz3PvFJOdEeKwsuspdOHZmv8ilc
         gfpw==
X-Gm-Message-State: AOJu0Yxo1EKtGwFLT2tuQ/HD7p//MvdfLk3XL7HZK69oz+a98APpsiU+
	vNy9EwWnu8UjHahoQdqtowhqeHPQsUBhF6fi3dyL3EegDqgZjla52K/rjmXGdfkiUfsnLVPxGUT
	5
X-Gm-Gg: ASbGncv+nj+rMeV6nzKhBAOMvGk3/BghLa7DcMdq7Cj5JoupGk6TGN5GzUncpbW/KBt
	JwzuntPPQGRLE4UOTxbmaWEvGWOWDy4Y4wVzDZZmdk83CxvhYO1sL7paBTl9yZJsA7JsTeHpvyH
	jRYStTkDr5aAEzl9hVKT8O73286bCxq22mxvZhI83VEpqCA95zNQjPal7vosroDLHHR9X0SOjQy
	tMoPhTGaGFvmuCG7umappmI2KGDNTvwJPPUSmA=
X-Google-Smtp-Source: AGHT+IFd93HmK2lQ6zs0Bk+iTMw99YIUTZmqPRnrDzjuFBdDQfrMssnXdWsmcnsqIZRaNvhDxz0PGg==
X-Received: by 2002:a05:6000:4012:b0:385:ee85:f1bf with SMTP id ffacd0b85a97d-385fd9800e2mr1212549f8f.18.1733221283114;
        Tue, 03 Dec 2024 02:21:23 -0800 (PST)
Received: from eis ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385f343f293sm5052569f8f.36.2024.12.03.02.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 02:21:22 -0800 (PST)
Date: Tue, 3 Dec 2024 10:23:39 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v3 bpf-next 4/7] libbpf: prog load: allow to use
 fd_array_cnt
Message-ID: <Z07cKx0pEIrk22ye@eis>
References: <20241129132813.1452294-1-aspsk@isovalent.com>
 <20241129132813.1452294-5-aspsk@isovalent.com>
 <CAADnVQJgYEiMbtPStOwGJLV4Dt1yj98Hy73-FEnDVh6a2be++w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJgYEiMbtPStOwGJLV4Dt1yj98Hy73-FEnDVh6a2be++w@mail.gmail.com>

On 24/12/02 06:34PM, Alexei Starovoitov wrote:
> On Fri, Nov 29, 2024 at 5:29 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> >
> > Add new fd_array_cnt field to bpf_prog_load_opts
> > and pass it in bpf_attr, if set.
> >
> > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > ---
> >  tools/lib/bpf/bpf.c      | 5 +++--
> >  tools/lib/bpf/bpf.h      | 5 ++++-
> >  tools/lib/bpf/features.c | 2 +-
> >  3 files changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> > index becdfa701c75..0e7f59224936 100644
> > --- a/tools/lib/bpf/bpf.c
> > +++ b/tools/lib/bpf/bpf.c
> > @@ -105,7 +105,7 @@ int sys_bpf_prog_load(union bpf_attr *attr, unsigned int size, int attempts)
> >   */
> >  int probe_memcg_account(int token_fd)
> >  {
> > -       const size_t attr_sz = offsetofend(union bpf_attr, prog_token_fd);
> > +       const size_t attr_sz = offsetofend(union bpf_attr, fd_array_cnt);
> 
> Thankfully this function doesn't set fd_array_cnt below.
> Otherwise the detection of memcg would fail on older kernels.
> Let's avoid people mindlessly adding init of fd_array_cnt here by accident.
> Simply keep this line as-is.
> offsetofend(.., prog_token_fd) is fine.

Ok, thanks, reverted (as with the one you've mentioned below)

> >         struct bpf_insn insns[] = {
> >                 BPF_EMIT_CALL(BPF_FUNC_ktime_get_coarse_ns),
> >                 BPF_EXIT_INSN(),
> > @@ -238,7 +238,7 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
> >                   const struct bpf_insn *insns, size_t insn_cnt,
> >                   struct bpf_prog_load_opts *opts)
> >  {
> > -       const size_t attr_sz = offsetofend(union bpf_attr, prog_token_fd);
> > +       const size_t attr_sz = offsetofend(union bpf_attr, fd_array_cnt);
> >         void *finfo = NULL, *linfo = NULL;
> >         const char *func_info, *line_info;
> >         __u32 log_size, log_level, attach_prog_fd, attach_btf_obj_fd;
> > @@ -311,6 +311,7 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
> >         attr.line_info_cnt = OPTS_GET(opts, line_info_cnt, 0);
> >
> >         attr.fd_array = ptr_to_u64(OPTS_GET(opts, fd_array, NULL));
> > +       attr.fd_array_cnt = OPTS_GET(opts, fd_array_cnt, 0);
> >
> >         if (log_level) {
> >                 attr.log_buf = ptr_to_u64(log_buf);
> > diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> > index a4a7b1ad1b63..435da95d2058 100644
> > --- a/tools/lib/bpf/bpf.h
> > +++ b/tools/lib/bpf/bpf.h
> > @@ -107,9 +107,12 @@ struct bpf_prog_load_opts {
> >          */
> >         __u32 log_true_size;
> >         __u32 token_fd;
> > +
> > +       /* if set, provides the length of fd_array */
> > +       __u32 fd_array_cnt;
> >         size_t :0;
> >  };
> > -#define bpf_prog_load_opts__last_field token_fd
> > +#define bpf_prog_load_opts__last_field fd_array_cnt
> >
> >  LIBBPF_API int bpf_prog_load(enum bpf_prog_type prog_type,
> >                              const char *prog_name, const char *license,
> > diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> > index 760657f5224c..5afc9555d9ac 100644
> > --- a/tools/lib/bpf/features.c
> > +++ b/tools/lib/bpf/features.c
> > @@ -22,7 +22,7 @@ int probe_fd(int fd)
> >
> >  static int probe_kern_prog_name(int token_fd)
> >  {
> > -       const size_t attr_sz = offsetofend(union bpf_attr, prog_token_fd);
> > +       const size_t attr_sz = offsetofend(union bpf_attr, fd_array_cnt);
> 
> Same here. Don't change it.

