Return-Path: <bpf+bounces-28394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F158B9015
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 21:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C2231C21351
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 19:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5504161302;
	Wed,  1 May 2024 19:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I69lXr8D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60251B977
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 19:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714591947; cv=none; b=Mxn32Nwng8ya35TauEBI++uFoZsmdM9SdwGs4L0k/nphdKccGC6NS+8lXUQ40vL6jp5uSiBcSDBBj6xnLHyI1zUXWX13AZEh8BWUNWA7O/rTsbelL7TFRlYl2u7uSmMm0hIYSKoA5qrbyoL2SKBT5GEmJCtkD5No/XI10rUnq+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714591947; c=relaxed/simple;
	bh=/UPjrtVNVpvmmdWA8gmvDSA7aEdXPqhLr2pe0ta8xi0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tht4qUYmB6VLrnGKFAnlF3uJbz7ATkgRH9rvsZCpV4ZmWcE3dmAIEr+XFbr9EGOq/KnlEipXj1w99eRvyFehalZ2j3jKLf9mAycEMYuIlzX+7B0ZgcByCndxUAAdOG6BkDJzu/Om0f5XVwyY4CFbtEpG58T1iNcr+EzzA8T+yag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I69lXr8D; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-34d7b0dac54so672401f8f.0
        for <bpf@vger.kernel.org>; Wed, 01 May 2024 12:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714591944; x=1715196744; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hVnJAkunofxDb+YfJ4eukFi1T5pTTRzV+BSWEg0rVDk=;
        b=I69lXr8DyrHzfgDCFKGtiQymaIuCqvUEi7xS/w0XYAbOdPt/u+h/V3LdW8N3FW9AIp
         a9WX4gmf96s7hg8hxVuXzdbIMb89EKu8g/EXtxXLwb6UQ3hST9GBNduD67IC/BxUP6aB
         2Z6+XxqUTzTlt2cU/iblb3ed6UY8HCfAb+vq+vDkolV+tpO+mXvZiwETTl8f6iBEQi/B
         66X+Sum+V6wf00smQ39vuraQVYUwcyPLFQlRLgweygfJDM6/uyCM2unAT50dehkZx88i
         qmjt8Oc4whMN5rTO3tS6t75eWLlWCAuafXWlRgwmCGF0vcZ+DsLa4lfUifO3Za+3PT4G
         GCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714591944; x=1715196744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVnJAkunofxDb+YfJ4eukFi1T5pTTRzV+BSWEg0rVDk=;
        b=HbOBLqt5qvO4LuQ7ouUDXNMESCCHYDh/fAFcRmVVjc0ouJSKuO+MJQEGejf8xfNQnT
         RQaBDMM5McioMPyyn7mWh8W64dxCcTGnEZ3KnUk2yD11hlcTLPllPDtz4vAVeXCdEYZD
         cQjY1y1VdnWdE9t4UCpacuU0s19MktWMQOAL/UibaZz1Ilfb8+AVn+X0/LOItj+PB66J
         ej6M5U/2iHE8QdauUixE203M98r895K0GALHpWKoABHYFjFxwmIZcPV/FvZs+yisRwwP
         NZ439HPXv3Xe7rPMOw65xg4TQAd+Zf9FlBD1546JZJmTmH6d8F0I+hH4+M3vEj21ByhF
         5xCw==
X-Forwarded-Encrypted: i=1; AJvYcCXEidGvHLlxGN5cIk6BobC1EzmYg9ZNkuwGuSApHF4fJ4+MRigLJKC74GAMCNzIXTjUszsgaNCi8R9H7s1aaeMQON3j
X-Gm-Message-State: AOJu0Ywxn3/MBo0ATEa8ymuzqaN9vAyJoR7N831soUdJi+JBxW3oMXHF
	92NJZrBj4ThTwWDHc/crm0oelSNl57CV7jSpSsskh4AW9pMwgw10
X-Google-Smtp-Source: AGHT+IHbZgOhyPslZUe++IfAwS8kb3+4uJCsQkKjkw6rJZl+1gebMAgcErhoTB+zlXeGw43g3RBXUQ==
X-Received: by 2002:a05:6000:1742:b0:34d:a0b4:d122 with SMTP id m2-20020a056000174200b0034da0b4d122mr366440wrf.30.1714591943530;
        Wed, 01 May 2024 12:32:23 -0700 (PDT)
Received: from krava ([83.240.62.36])
        by smtp.gmail.com with ESMTPSA id c2-20020a5d4142000000b0034e0346317dsm614559wrq.13.2024.05.01.12.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 12:32:23 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 1 May 2024 21:32:19 +0200
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
Subject: Re: [PATCHv2 bpf-next 4/7] libbpf: Add support for kprobe session
 attach
Message-ID: <ZjKYw21GkJHFLva2@krava>
References: <20240430112830.1184228-1-jolsa@kernel.org>
 <20240430112830.1184228-5-jolsa@kernel.org>
 <CAEf4BzbxSWvoNYJez8qc1TtKvTZG8S=hAYLrnwPwayuRnW1N9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbxSWvoNYJez8qc1TtKvTZG8S=hAYLrnwPwayuRnW1N9g@mail.gmail.com>

On Wed, May 01, 2024 at 11:30:55AM -0700, Andrii Nakryiko wrote:

SNIP

> >
> > +static int attach_kprobe_session(const struct bpf_program *prog, long cookie,
> > +                                struct bpf_link **link)
> > +{
> > +       LIBBPF_OPTS(bpf_kprobe_multi_opts, opts, .session = true);
> > +       const char *spec;
> > +       char *pattern;
> > +       int n;
> > +
> > +       *link = NULL;
> > +
> > +       /* no auto-attach for SEC("kprobe.session") */
> > +       if (strcmp(prog->sec_name, "kprobe.session") == 0)
> > +               return 0;
> > +
> > +       spec = prog->sec_name + sizeof("kprobe.session/") - 1;
> > +       n = sscanf(spec, "%m[a-zA-Z0-9_.*?]", &pattern);
> > +       if (n < 1) {
> > +               pr_warn("kprobe session pattern is invalid: %s\n", pattern);
> 
> this should be printing spec, not pattern, please send a follow up fix, thanks

ugh yes, also attach_kprobe_multi is broken same way, will send the fix tomorrow

thanks,
jirka

> 
> > +               return -EINVAL;
> > +       }
> > +
> > +       *link = bpf_program__attach_kprobe_multi_opts(prog, pattern, &opts);
> > +       free(pattern);
> > +       return *link ? 0 : -errno;
> > +}
> > +
> >  static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link)
> >  {
> >         char *probe_type = NULL, *binary_path = NULL, *func_name = NULL;
> > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > index 1333ae20ebe6..c3f77d9260fe 100644
> > --- a/tools/lib/bpf/libbpf.h
> > +++ b/tools/lib/bpf/libbpf.h
> > @@ -539,10 +539,12 @@ struct bpf_kprobe_multi_opts {
> >         size_t cnt;
> >         /* create return kprobes */
> >         bool retprobe;
> > +       /* create session kprobes */
> > +       bool session;
> >         size_t :0;
> >  };
> >
> > -#define bpf_kprobe_multi_opts__last_field retprobe
> > +#define bpf_kprobe_multi_opts__last_field session
> >
> >  LIBBPF_API struct bpf_link *
> >  bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
> > --
> > 2.44.0
> >

