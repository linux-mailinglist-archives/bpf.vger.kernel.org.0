Return-Path: <bpf+bounces-56021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FB7A8AD9F
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 03:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83D9317FD09
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 01:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A12227E81;
	Wed, 16 Apr 2025 01:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfNRSlbh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6DD1487F6;
	Wed, 16 Apr 2025 01:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744767870; cv=none; b=tmrF0QBQl2+dR6/rymgVplwZt9lg0vFXNlCvjhaUe3xO9mfb9rBVkXnmECNtG/KGQZumwh2bicw8lt6L9bc7+xvRRNUtJBBTZvUPZdkg7nrOvdPrmG37LAM0vaGKfzMh4FJmIbIF59213tRLlt+aSoOk66H27zMeArDQS7tzhYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744767870; c=relaxed/simple;
	bh=1VbvWTNe/fniX3+iY/F9pCcSQOUG2CFW2qCV0+CUGOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bydeUY7ORj5jy5ETy7RCEzC5FxsvU8rlOacJ/GwdyR/ftsPXNKgaaeji6QQRiMVUCZEMq26tMI0erRzLIpQYe0+MvXzfTkZkmM3lTBCOzHodRS516RXslAfo5LuGq5QmBAmfsIdU8TBB09ZDjpT/1kyb2vUWz3f+N6cHUAF6sUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfNRSlbh; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3f8d2f8d890so3338384b6e.0;
        Tue, 15 Apr 2025 18:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744767867; x=1745372667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTTd/0/2LZSe7Cp0uHQDJpqW1SQdnvZm0OG1nRFBmME=;
        b=WfNRSlbhq8NmwB3MT1SVUMf1WqPv2uJt3BEvoYSR0v/dRlxNBpSl8+csTXlf+s4A00
         PWdhUhkneDN5CXzw56mJ8tHHXQnOiYrPQgZhn9csup3ehCcKwpaf82maiM5JEeaGNnxm
         nlcyTR4f+BUg1CDEBcHHNA8SywlZS1KS2LkjDqz8U50XREmHymjmWDeupQQ574NEXGyc
         hMS3D6pe7b2hDs3l4/eAkzAJyiLfe/8PwOgwH/MQefOVjRCEDjmBrW0aeZvQOY4rx4TH
         JmrdXPcqzc75dKqqv/x0mtXz6M3wvPzhxbiqqoJtetbUpvb2LWQWzFedKmgRJVYMoAjh
         K0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744767867; x=1745372667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTTd/0/2LZSe7Cp0uHQDJpqW1SQdnvZm0OG1nRFBmME=;
        b=i9qaaTw+c8WBMCLk/pYmMF/L4WZoUCO3wpm79LlqwoMxzkM83q772mJNx6pwFqeqev
         /eq/jxHzZyS6xM2i0GrRaLwA1Lx6Nv4EcEg/tXsROUB4m2ZipYo4/2Jj9jkszAlKBSQ1
         j6UPIYu5ex9taAYTWWGGez1WBXReHYQvyoMMz8tJbzB3aj098EIhvXYLHO1YX2mxgwC2
         89HJAscipq9Hpr19n0teedi16YAGOxm6u71ZLCVQLA9mg9Q6/q6C0dI3mxStH1IUCbK9
         JhWgqEOxeXDK7OswprEZaAMIF7P1vSo35TSZY19Vw4VMSJZbs4u0pqXOtWCI3y+Afr6/
         Twew==
X-Forwarded-Encrypted: i=1; AJvYcCVG5F5ZQUz7kInbX9xF+Qhh4F5GtC7ytkaTnEp93RhE1Csd3wLJ2h1EZafZDSr2xAFDckyuG57Jdb/P6+vl@vger.kernel.org, AJvYcCXy6k/BGvi2dbwKxq8HsUPLECrmDbJYl5udlYdpH7poBZem0M60sKxo508Pur7ojj8JoLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjZ/XD6qg0caer95ced58ZYqFZn4RpUrInSlHX3bGbVZoYinzI
	zZnkbfFQ6J5bJh+etzzZ3IUPtERTfx87q4xGnluzklo2uArEKY4maJ/hJXp4s66ifQGxpc97uAo
	TFYODLE4NI+E+pvuF8zch6xYkqCU=
X-Gm-Gg: ASbGncvPtoiPl+ZQZIlkVEPVwS3AekSUxhQD7xdSzPmESppiJ+UptiDL/m2NQholSBG
	lez1LQ1sBS3q+umLZbd6R110PkEf17GdS0ervAJbrzoDKkHgxze84Wl+wPsEBjd7Ek71MkH1NOA
	ufKbwOUW3ehJvUD1+0KxS6ug==
X-Google-Smtp-Source: AGHT+IFQ1BYgGMjS8evMCZPXovj65fndhT0CwIflnBZBG6vOgAAunL053HSfsCNCAm/15Km8rCBQ70kJCOe0CTYQQT4=
X-Received: by 2002:a05:6808:2126:b0:3f8:6caf:8339 with SMTP id
 5614622812f47-400b044caa7mr21690b6e.37.1744767867290; Tue, 15 Apr 2025
 18:44:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415093907.280501-1-yangfeng59949@163.com>
 <20250415093907.280501-2-yangfeng59949@163.com> <CAEf4BzYZpLOOV5MVxaB4+WPZiO3SjSkNCPrNkd67jZ49kUYDZA@mail.gmail.com>
In-Reply-To: <CAEf4BzYZpLOOV5MVxaB4+WPZiO3SjSkNCPrNkd67jZ49kUYDZA@mail.gmail.com>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Wed, 16 Apr 2025 09:44:16 +0800
X-Gm-Features: ATxdqUGgd60uTO0YuHuEJBemweoR8ND1ZZ9ZAxRp_g4hhHmJRcETHD1Oj-sHxCs
Message-ID: <CAEyhmHQG5+F7b2OBUXYHRKqYuQyG3e_MAj9q=fwebHD_uAU9-w@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/3] libbpf: Fix event name too long error
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Feng Yang <yangfeng59949@163.com>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, olsajiri@gmail.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrii,

On Wed, Apr 16, 2025 at 7:05=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Apr 15, 2025 at 2:40=E2=80=AFAM Feng Yang <yangfeng59949@163.com>=
 wrote:
> >
> > From: Feng Yang <yangfeng@kylinos.cn>
> >
> > When the binary path is excessively long, the generated probe_name in l=
ibbpf
> > exceeds the kernel's MAX_EVENT_NAME_LEN limit (64 bytes).
> > This causes legacy uprobe event attachment to fail with error code -22.
> >
> > The fix reorders the fields to place the unique ID before the name.
> > This ensures that even if truncation occurs via snprintf, the unique ID
> > remains intact, preserving event name uniqueness. Additionally, explici=
t
> > checks with MAX_EVENT_NAME_LEN are added to enforce length constraints.
> >
> > Before Fix:
> >         ./test_progs -t attach_probe/kprobe-long_name
> >         ......
> >         libbpf: failed to add legacy kprobe event for 'bpf_testmod_looo=
oooooooooooooooooooooooooooong_name+0x0': -EINVAL
> >         libbpf: prog 'handle_kprobe': failed to create kprobe 'bpf_test=
mod_looooooooooooooooooooooooooooooong_name+0x0' perf event: -EINVAL
> >         test_attach_kprobe_long_event_name:FAIL:attach_kprobe_long_even=
t_name unexpected error: -22
> >         test_attach_probe:PASS:uprobe_ref_ctr_cleanup 0 nsec
> >         #13/11   attach_probe/kprobe-long_name:FAIL
> >         #13      attach_probe:FAIL
> >
> >         ./test_progs -t attach_probe/uprobe-long_name
> >         ......
> >         libbpf: failed to add legacy uprobe event for /root/linux-bpf/b=
pf-next/tools/testing/selftests/bpf/test_progs:0x13efd9: -EINVAL
> >         libbpf: prog 'handle_uprobe': failed to create uprobe '/root/li=
nux-bpf/bpf-next/tools/testing/selftests/bpf/test_progs:0x13efd9' perf even=
t: -EINVAL
> >         test_attach_uprobe_long_event_name:FAIL:attach_uprobe_long_even=
t_name unexpected error: -22
> >         #13/10   attach_probe/uprobe-long_name:FAIL
> >         #13      attach_probe:FAIL
> > After Fix:
> >         ./test_progs -t attach_probe/uprobe-long_name
> >         #13/10   attach_probe/uprobe-long_name:OK
> >         #13      attach_probe:OK
> >         Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> >
> >         ./test_progs -t attach_probe/kprobe-long_name
> >         #13/11   attach_probe/kprobe-long_name:OK
> >         #13      attach_probe:OK
> >         Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> >
> > Fixes: 46ed5fc33db9 ("libbpf: Refactor and simplify legacy kprobe code"=
)
> > Fixes: cc10623c6810 ("libbpf: Add legacy uprobe attaching support")
> > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> > ---
> >  tools/lib/bpf/libbpf.c | 41 +++++++++++++++--------------------------
> >  1 file changed, 15 insertions(+), 26 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index b2591f5cab65..b7fc57ac16a6 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -60,6 +60,8 @@
> >  #define BPF_FS_MAGIC           0xcafe4a11
> >  #endif
> >
> > +#define MAX_EVENT_NAME_LEN     64
> > +
> >  #define BPF_FS_DEFAULT_PATH "/sys/fs/bpf"
> >
> >  #define BPF_INSN_SZ (sizeof(struct bpf_insn))
> > @@ -11136,16 +11138,16 @@ static const char *tracefs_available_filter_f=
unctions_addrs(void)
> >                              : TRACEFS"/available_filter_functions_addr=
s";
> >  }
> >
> > -static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
> > -                                        const char *kfunc_name, size_t=
 offset)
> > +static void gen_probe_legacy_event_name(char *buf, size_t buf_sz,
> > +                                       const char *name, size_t offset=
)
> >  {
> >         static int index =3D 0;
> >         int i;
> >
> > -       snprintf(buf, buf_sz, "libbpf_%u_%s_0x%zx_%d", getpid(), kfunc_=
name, offset,
> > -                __sync_fetch_and_add(&index, 1));
> > +       snprintf(buf, buf_sz, "libbpf_%u_%d_%s_0x%zx", getpid(),
> > +                __sync_fetch_and_add(&index, 1), name, offset);
> >
> > -       /* sanitize binary_path in the probe name */
> > +       /* sanitize name in the probe name */
> >         for (i =3D 0; buf[i]; i++) {
> >                 if (!isalnum(buf[i]))
> >                         buf[i] =3D '_';
> > @@ -11270,9 +11272,9 @@ int probe_kern_syscall_wrapper(int token_fd)
> >
> >                 return pfd >=3D 0 ? 1 : 0;
> >         } else { /* legacy mode */
> > -               char probe_name[128];
> > +               char probe_name[MAX_EVENT_NAME_LEN];
> >
> > -               gen_kprobe_legacy_event_name(probe_name, sizeof(probe_n=
ame), syscall_name, 0);
> > +               gen_probe_legacy_event_name(probe_name, sizeof(probe_na=
me), syscall_name, 0);
> >                 if (add_kprobe_event_legacy(probe_name, false, syscall_=
name, 0) < 0)
> >                         return 0;
> >
> > @@ -11328,9 +11330,9 @@ bpf_program__attach_kprobe_opts(const struct bp=
f_program *prog,
> >                                             func_name, offset,
> >                                             -1 /* pid */, 0 /* ref_ctr_=
off */);
> >         } else {
> > -               char probe_name[256];
> > +               char probe_name[MAX_EVENT_NAME_LEN];
> >
> > -               gen_kprobe_legacy_event_name(probe_name, sizeof(probe_n=
ame),
> > +               gen_probe_legacy_event_name(probe_name, sizeof(probe_na=
me),
> >                                              func_name, offset);
> >
> >                 legacy_probe =3D strdup(probe_name);
> > @@ -11875,20 +11877,6 @@ static int attach_uprobe_multi(const struct bp=
f_program *prog, long cookie, stru
> >         return ret;
> >  }
> >
> > -static void gen_uprobe_legacy_event_name(char *buf, size_t buf_sz,
> > -                                        const char *binary_path, uint6=
4_t offset)
> > -{
> > -       int i;
> > -
> > -       snprintf(buf, buf_sz, "libbpf_%u_%s_0x%zx", getpid(), binary_pa=
th, (size_t)offset);
> > -
> > -       /* sanitize binary_path in the probe name */
> > -       for (i =3D 0; buf[i]; i++) {
> > -               if (!isalnum(buf[i]))
> > -                       buf[i] =3D '_';
> > -       }
> > -}
> > -
> >  static inline int add_uprobe_event_legacy(const char *probe_name, bool=
 retprobe,
> >                                           const char *binary_path, size=
_t offset)
> >  {
> > @@ -12312,13 +12300,14 @@ bpf_program__attach_uprobe_opts(const struct =
bpf_program *prog, pid_t pid,
> >                 pfd =3D perf_event_open_probe(true /* uprobe */, retpro=
be, binary_path,
> >                                             func_offset, pid, ref_ctr_o=
ff);
> >         } else {
> > -               char probe_name[PATH_MAX + 64];
> > +               char probe_name[MAX_EVENT_NAME_LEN];
> >
> >                 if (ref_ctr_off)
> >                         return libbpf_err_ptr(-EINVAL);
> >
> > -               gen_uprobe_legacy_event_name(probe_name, sizeof(probe_n=
ame),
> > -                                            binary_path, func_offset);
> > +               gen_probe_legacy_event_name(probe_name, sizeof(probe_na=
me),
> > +                                           basename((void *)binary_pat=
h),
>
> This patch is a nice refactoring overall and I like it. But this (void
> *) cast on binary_path I'm not so fond of. Yes, if you read
> smallprint, you'll see that with _GNU_SOURCE basename won't *really*
> modify input argument, but meh.
>

This has been used in bpf_object__new() like:

    /* Using basename() GNU version which doesn't modify arg. */
    libbpf_strlcpy(obj->name, basename((void *)path), sizeof(obj->name));

> Let's instead do a simple `strrchr(binary_path, '/') ?: binary_path`?
>
> pw-bot: cr
>
>
> > +                                           func_offset);
> >
> >                 legacy_probe =3D strdup(probe_name);
> >                 if (!legacy_probe)
> > --
> > 2.43.0
> >

