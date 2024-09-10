Return-Path: <bpf+bounces-39409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 767C7972A6C
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 09:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE5EC1F25946
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 07:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DB117D35C;
	Tue, 10 Sep 2024 07:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4HDF8J3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFEA17C220;
	Tue, 10 Sep 2024 07:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725952655; cv=none; b=Ntj6vGq/16d6VtduOjrIgXQGlpHN2U9e1wbEFJkwbAGJCc6jHN7nvalD8nNzsIkk1AW1lGtZ6A54iNiAoyxbMIthdLMZsekjOBvwwpf6rj/Cppqh8ebCKuwsPzofQtaIqeotZbPP9+S4SSHb9cjxRY33zEoZWRP/F7QbDfN+jqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725952655; c=relaxed/simple;
	bh=3Mz+7gV3ML0Zf+yZsHTAyXdLUlYZ2LEMKrmSiBZeqwc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJ96DcoiFjzQjXXAwH2Cwjva7Qw29xRODA1c++u2cOMALOyA4YL5vFMUUvKoD/GE20mcMevGSbQluSUBk9pOcJN7YFlEdHF832Zihd7P7eXa0KI4gvupVyXwKatNKlYLB53obREHOAkNV+jcEfUvHFB9rx/T3zpPYgCOj3Zu+XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4HDF8J3; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cb1e623d1so4144255e9.0;
        Tue, 10 Sep 2024 00:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725952652; x=1726557452; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1G/6TSU4XvyEREQovtBQTLvcvDdo46Yqz8ae2ySDRy0=;
        b=W4HDF8J3PdY2+B+97uhDRrZz4wjXAfsdiIHQXNFFUIoDqDnS4XT0KMkFfWaUkT/Jui
         S2c/g2UsakITwvQTHR1fk1Sa4U+2gp6o0JJDEJPWoDBXwfsUp2ch29WMEDv1NGtzwyKO
         sreuVtoJl17OcWE67OD9Afntpqshhzha15HUSBjT9DoaiucC7lRv3DMKDqVXA32dQm91
         YJRaJJkiAwgKwfHJQpUA3/rZ9/pA4Bna7zHpuaVr0hf0rXcZVeqXNJmz9BKa0DvHVFXZ
         Fl+lYkPOpAGUguWOhUG2gZ7lvHcVE5Tn+EFRyVmdwTFTTatDDKLJLnuVKljudKAEsRhA
         iTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725952652; x=1726557452;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1G/6TSU4XvyEREQovtBQTLvcvDdo46Yqz8ae2ySDRy0=;
        b=M78Ynnfm7NkSMLv994MCFqUqI5ntLMycoprthzdLlJU1y0uXCJlC5ixM7xVYfmwV/u
         A6H/28lgBPfxx3Dt5cJZBbS/Q5WFN69fKL3D9vKB5CkthOlreCWmxPNSmagviQXfFnYH
         v/8aotJWP99XjRC5cTMXMSskw6yTi3nigv+Br74vd7TQaY8qbhF7YO66wCYPROvUnmXQ
         MfuKS1SB1giSa+Nwtt/nGuKvK9f0O+Thvc8/f8XnhihfspimW/OVA8isbq63nCrkffJm
         Mnm7imyRezg1T6bIf1LyRrGXCfj5Jem/RRMJUyaYb7hSu7qAYl7suMGiJkPloctqCsBu
         ejrg==
X-Forwarded-Encrypted: i=1; AJvYcCUM1diLI1HBQXXYXhBt25BaZBRNE9LyiMDxeEWjwMPFz0aQ8JFrbvEqGHhd4U0nzl5C51g=@vger.kernel.org, AJvYcCW/j0EPoa8eTu0cAJq8p8/jFXMGbbqcG7JaCjenQBtViQAFJbn/+Rn8mK+urIANgpeogVSS+rFxM+VEqCOW@vger.kernel.org, AJvYcCWqQpOaZY8+uIdvcPQszX9x1LIDPiZAmKwPJ4/LNExQAvGWpfGVP87PwOtdjqPIMGftFNOoikauZzFjQtYjPRWyZy1z@vger.kernel.org
X-Gm-Message-State: AOJu0YxDGcOTs6Gjq2XeVw92s1WX4bRZW0/iruPY/TB/6SLE4KsHPek5
	b2d59o/HGLO7Fl+OnYOZP1zOdUOle8+rInHKPzo0WQOUpJ+Fj9x7
X-Google-Smtp-Source: AGHT+IGt0x0ctkcebXtzMZbMb4xvYbA9vXD1RvUPnjXmJSDIdmTl977N6sUL/QUNbJB/wcqEwE96aA==
X-Received: by 2002:a05:600c:3b1e:b0:42c:be90:fa23 with SMTP id 5b1f17b1804b1-42cbe90fde6mr13834385e9.2.1725952652462;
        Tue, 10 Sep 2024 00:17:32 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d3654sm8053364f8f.78.2024.09.10.00.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 00:17:32 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 10 Sep 2024 09:17:30 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv3 4/7] libbpf: Add support for uprobe multi session attach
Message-ID: <Zt_yivgO2gq6BfIH@krava>
References: <20240909074554.2339984-1-jolsa@kernel.org>
 <20240909074554.2339984-5-jolsa@kernel.org>
 <CAEf4BzYpH_2f0eHwQG205Q_4hewbtC9OrVSA-_jn6ysz53QbBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYpH_2f0eHwQG205Q_4hewbtC9OrVSA-_jn6ysz53QbBg@mail.gmail.com>

On Mon, Sep 09, 2024 at 04:44:44PM -0700, Andrii Nakryiko wrote:
> On Mon, Sep 9, 2024 at 12:46 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding support to attach program in uprobe session mode
> > with bpf_program__attach_uprobe_multi function.
> >
> > Adding session bool to bpf_uprobe_multi_opts struct that allows
> > to load and attach the bpf program via uprobe session.
> > the attachment to create uprobe multi session.
> >
> > Also adding new program loader section that allows:
> >   SEC("uprobe.session/bpf_fentry_test*")
> >
> > and loads/attaches uprobe program as uprobe session.
> >
> > Adding sleepable hook (uprobe.session.s) as well.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/bpf/bpf.c    |  1 +
> >  tools/lib/bpf/libbpf.c | 50 ++++++++++++++++++++++++++++++++++++++++--
> >  tools/lib/bpf/libbpf.h |  4 +++-
> >  3 files changed, 52 insertions(+), 3 deletions(-)
> >
> 
> [...]
> 
> > +static int attach_uprobe_session(const struct bpf_program *prog, long cookie, struct bpf_link **link)
> > +{
> > +       LIBBPF_OPTS(bpf_uprobe_multi_opts, opts, .session = true);
> > +       char *binary_path = NULL, *func_name = NULL;
> > +       int n, ret = -EINVAL;
> > +       const char *spec;
> > +
> > +       *link = NULL;
> > +
> > +       spec = prog->sec_name + sizeof("uprobe.session/") - 1;
> > +       if (cookie & SEC_SLEEPABLE)
> > +               spec += 2; /* extra '.s' */
> > +       n = sscanf(spec, "%m[^:]:%m[^\n]", &binary_path, &func_name);
> > +
> > +       switch (n) {
> > +       case 1:
> > +               /* but auto-attach is impossible. */
> > +               ret = 0;
> > +               break;
> > +       case 2:
> > +               *link = bpf_program__attach_uprobe_multi(prog, -1, binary_path, func_name, &opts);
> > +               ret = *link ? 0 : -errno;
> > +               break;
> > +       default:
> > +               pr_warn("prog '%s': invalid format of section definition '%s'\n", prog->name,
> > +                       prog->sec_name);
> > +               break;
> > +       }
> > +       free(binary_path);
> > +       free(func_name);
> > +       return ret;
> > +}
> 
> why adding this whole attach_uprobe_session if attach_uprobe_multi()
> is almost exactly what you need. We just need to teach
> attach_uprobe_multi to recognize uprobe.session prefix with strncmp(),
>  no? The rest of the logic is exactly the same.

ok, that's better

> 
> BTW, maybe you can fix attach_uprobe_multi() while at it:
> 
> opts.retprobe = strcmp(probe_type, "uretprobe.multi") == 0;
> 
> that should be strncmp() to accommodate uretprobe.multi.s, no?
> Original author (wink-wink) didn't account for that ".s", it seems...
> 
> (actually please send a small fix to bpf-next separately, so we can
> apply it sooner)

hum, right.. I wonder why the test is passing, will send a fix

thanks,
jirka

> 
> > +
> >  static void gen_uprobe_legacy_event_name(char *buf, size_t buf_sz,
> >                                          const char *binary_path, uint64_t offset)
> >  {
> > @@ -11933,10 +11969,12 @@ bpf_program__attach_uprobe_multi(const struct bpf_program *prog,
> >         const unsigned long *ref_ctr_offsets = NULL, *offsets = NULL;
> >         LIBBPF_OPTS(bpf_link_create_opts, lopts);
> >         unsigned long *resolved_offsets = NULL;
> > +       enum bpf_attach_type attach_type;
> >         int err = 0, link_fd, prog_fd;
> >         struct bpf_link *link = NULL;
> >         char errmsg[STRERR_BUFSIZE];
> >         char full_path[PATH_MAX];
> > +       bool retprobe, session;
> >         const __u64 *cookies;
> >         const char **syms;
> >         size_t cnt;
> 
> [...]

