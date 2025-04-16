Return-Path: <bpf+bounces-56049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF13BA90926
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 18:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24EEE5A057F
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 16:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C80B212F83;
	Wed, 16 Apr 2025 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTmsOoLG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7BD1DF744;
	Wed, 16 Apr 2025 16:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744821760; cv=none; b=SEGLWl/HW7NWmP5Ha1XH7vcVk6WHzl4v36m/PaFBImTlwd+oyg9at0ksW8jnytWofBUgZ6pla47SK6b7tZFfw7QT0ZkkhFKU21A4irWuZZj3XcoTx3H7SWYjn9k+3H35SlOczaocb7AAG0JGcrtPD/7f8bC+vh5Ux4lXh50/UG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744821760; c=relaxed/simple;
	bh=Kp96AHMtPFqugTdZl5vsCg/C4gJtHkxGRskQOVqc1lA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VX7dNNnIzeQhbkkb/SfyflaUIUCJt8ma3G/41NmPlE5uC82JmqrZcfFeYamZl0KWOQzxkcVF7J09ZBsy7P694DbQDl90aHGlA9MStwT/+j5hdhgV9hkMuSCgafhJOZOaGnvOrdIzrN0AS5KP3gklk1FNd2rdwk6j6RxmMuuUIIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTmsOoLG; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-736ab1c43c4so6641129b3a.1;
        Wed, 16 Apr 2025 09:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744821758; x=1745426558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vi3/LsCAglVXlc1y/XElmJxhOC8xVFBVCFELuJBW74U=;
        b=cTmsOoLGiyNbUNUD55nD092/BTmAej/hcYTmfw11WGDcHBH4s/Zb9PXFkYIYRpvr8s
         mvGB4z4yvynyVkjBbdcRdcGnegvR0bkFK4HQV1laSow8tmZSy4aH+HlXjWVLdn9hNPya
         Cr5oxJifi/yPMZE3HBEEQAff5Ik5YrDGUtYN/E5qiXOHVx7IhvBCILBH8L6wjH3R0iJn
         shPgShiHyef2vPtYtqre87ns55RbE5ac0PDlwUvQ3Eu/126BI07JQlO3qHCsdZxWtdLp
         0lakIlbcvxP26xXfccXX735e+xbf6K8uCfeYlGlX3CL4qOc14JSk7gY9VbsXLx+NXIlS
         QAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744821758; x=1745426558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vi3/LsCAglVXlc1y/XElmJxhOC8xVFBVCFELuJBW74U=;
        b=BxASdVaTBnu+fUr7EhGxdTdOE7oxu+3JusDBTK3Xy425OmaKvK6dJi4eWA0bFSsW58
         9D8up/YkVngIgE6MkvoIYD+9FtB7n4KXO6NR1AeWmQWVAafVYTxmug6GP11COIfb1myN
         Al1qWnHMeOX8/DB4h6aINYtNd5iNor/d97hhA6hJUrO9rW9TUAnQX1K5hwiIkMwBF3K/
         gSstafqe56e/65ND0HyLj0ltXZdBpGPsJoQpfgJYQF/GfuPzH1SPtH1zUEwP7shC9x5Y
         vntMHqAuGy2rpa0csxldDJE7nLAQ1BE1f2iBH/M8FZk2hoQ6pCzbpnzgTQrOirvZ5oBF
         akyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIb20zlJXd7yvFSF+l85IgeCU7ZX8rZbhSmgC2dRD8ud8VTKoIfTDDYknJeIhpHudj+ek=@vger.kernel.org, AJvYcCWgwqzftoeN9Wm2WhSlwOPK71V21Pu5nh070F2SUzxm7eGzhVzOthIVvfqY9JLLV0JCGxYxtHLfY0fB1FxS@vger.kernel.org
X-Gm-Message-State: AOJu0YzAvHVoFdaxSGTYf+o9s/c5ew4vifmITIDOefj5d+PGTDqKrSgf
	DE0iAEf2//6g2hP73JGFtukT0dAyMfkqK9JcqWniR9FosZcqMMnHE4vGKjoyfZp8zCUyPMIP8z2
	O74X0l7hrSzSi47EeT4Df4FrZFLg=
X-Gm-Gg: ASbGncurGMBbo371EizeiM8qOKEx0YwYRHLBpXNtgfq8bMgczGKeuEfLkxp21pWfjO1
	ga3k7+UarcMwsp/jR74MwZagzYhmHF109Q6yUgMdn4S0yBNzAvTjW1IFutEEIJ9WSi7PVpOH6cr
	iVrKTeesYsqkQHF21IBosNJHh/l0mtSRSYejdGdH1NXTIl3oJR
X-Google-Smtp-Source: AGHT+IGdK6crrHS1+yd3fSVPdpk0V3ZAFbNc+T9D/khg7MZyDS4cCPh5Ipu63sOQeNDp/BRfF5MFoFl9PKkFftITMQ4=
X-Received: by 2002:a05:6a00:1145:b0:736:546c:eb69 with SMTP id
 d2e1a72fcca58-73c267003b0mr3397118b3a.9.1744821758061; Wed, 16 Apr 2025
 09:42:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415093907.280501-1-yangfeng59949@163.com>
 <20250415093907.280501-2-yangfeng59949@163.com> <CAEf4BzYZpLOOV5MVxaB4+WPZiO3SjSkNCPrNkd67jZ49kUYDZA@mail.gmail.com>
 <CAEyhmHQG5+F7b2OBUXYHRKqYuQyG3e_MAj9q=fwebHD_uAU9-w@mail.gmail.com>
In-Reply-To: <CAEyhmHQG5+F7b2OBUXYHRKqYuQyG3e_MAj9q=fwebHD_uAU9-w@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 16 Apr 2025 09:42:24 -0700
X-Gm-Features: ATxdqUF_SkHobflZ4JWeCBVB3YaeRB6wH7TVTDkNc1olfadoGJkXvUGukESEMSA
Message-ID: <CAEf4BzYGf6zp4TXPqrX8P2mUNHo2nQLk0m7x1peRMmWaFphTaw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/3] libbpf: Fix event name too long error
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: Feng Yang <yangfeng59949@163.com>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, olsajiri@gmail.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 6:44=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.com>=
 wrote:
>
> Hi Andrii,
>
> On Wed, Apr 16, 2025 at 7:05=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Apr 15, 2025 at 2:40=E2=80=AFAM Feng Yang <yangfeng59949@163.co=
m> wrote:
> > >
> > > From: Feng Yang <yangfeng@kylinos.cn>
> > >
> > > When the binary path is excessively long, the generated probe_name in=
 libbpf
> > > exceeds the kernel's MAX_EVENT_NAME_LEN limit (64 bytes).
> > > This causes legacy uprobe event attachment to fail with error code -2=
2.
> > >
> > > The fix reorders the fields to place the unique ID before the name.
> > > This ensures that even if truncation occurs via snprintf, the unique =
ID
> > > remains intact, preserving event name uniqueness. Additionally, expli=
cit
> > > checks with MAX_EVENT_NAME_LEN are added to enforce length constraint=
s.
> > >
> > > Before Fix:
> > >         ./test_progs -t attach_probe/kprobe-long_name
> > >         ......
> > >         libbpf: failed to add legacy kprobe event for 'bpf_testmod_lo=
oooooooooooooooooooooooooooooong_name+0x0': -EINVAL
> > >         libbpf: prog 'handle_kprobe': failed to create kprobe 'bpf_te=
stmod_looooooooooooooooooooooooooooooong_name+0x0' perf event: -EINVAL
> > >         test_attach_kprobe_long_event_name:FAIL:attach_kprobe_long_ev=
ent_name unexpected error: -22
> > >         test_attach_probe:PASS:uprobe_ref_ctr_cleanup 0 nsec
> > >         #13/11   attach_probe/kprobe-long_name:FAIL
> > >         #13      attach_probe:FAIL
> > >
> > >         ./test_progs -t attach_probe/uprobe-long_name
> > >         ......
> > >         libbpf: failed to add legacy uprobe event for /root/linux-bpf=
/bpf-next/tools/testing/selftests/bpf/test_progs:0x13efd9: -EINVAL
> > >         libbpf: prog 'handle_uprobe': failed to create uprobe '/root/=
linux-bpf/bpf-next/tools/testing/selftests/bpf/test_progs:0x13efd9' perf ev=
ent: -EINVAL
> > >         test_attach_uprobe_long_event_name:FAIL:attach_uprobe_long_ev=
ent_name unexpected error: -22
> > >         #13/10   attach_probe/uprobe-long_name:FAIL
> > >         #13      attach_probe:FAIL
> > > After Fix:
> > >         ./test_progs -t attach_probe/uprobe-long_name
> > >         #13/10   attach_probe/uprobe-long_name:OK
> > >         #13      attach_probe:OK
> > >         Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> > >
> > >         ./test_progs -t attach_probe/kprobe-long_name
> > >         #13/11   attach_probe/kprobe-long_name:OK
> > >         #13      attach_probe:OK
> > >         Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> > >
> > > Fixes: 46ed5fc33db9 ("libbpf: Refactor and simplify legacy kprobe cod=
e")
> > > Fixes: cc10623c6810 ("libbpf: Add legacy uprobe attaching support")
> > > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > > Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> > > ---
> > >  tools/lib/bpf/libbpf.c | 41 +++++++++++++++-------------------------=
-
> > >  1 file changed, 15 insertions(+), 26 deletions(-)
> > >
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index b2591f5cab65..b7fc57ac16a6 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -60,6 +60,8 @@
> > >  #define BPF_FS_MAGIC           0xcafe4a11
> > >  #endif
> > >
> > > +#define MAX_EVENT_NAME_LEN     64
> > > +
> > >  #define BPF_FS_DEFAULT_PATH "/sys/fs/bpf"
> > >
> > >  #define BPF_INSN_SZ (sizeof(struct bpf_insn))
> > > @@ -11136,16 +11138,16 @@ static const char *tracefs_available_filter=
_functions_addrs(void)
> > >                              : TRACEFS"/available_filter_functions_ad=
drs";
> > >  }
> > >
> > > -static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
> > > -                                        const char *kfunc_name, size=
_t offset)
> > > +static void gen_probe_legacy_event_name(char *buf, size_t buf_sz,
> > > +                                       const char *name, size_t offs=
et)
> > >  {
> > >         static int index =3D 0;
> > >         int i;
> > >
> > > -       snprintf(buf, buf_sz, "libbpf_%u_%s_0x%zx_%d", getpid(), kfun=
c_name, offset,
> > > -                __sync_fetch_and_add(&index, 1));
> > > +       snprintf(buf, buf_sz, "libbpf_%u_%d_%s_0x%zx", getpid(),
> > > +                __sync_fetch_and_add(&index, 1), name, offset);
> > >
> > > -       /* sanitize binary_path in the probe name */
> > > +       /* sanitize name in the probe name */
> > >         for (i =3D 0; buf[i]; i++) {
> > >                 if (!isalnum(buf[i]))
> > >                         buf[i] =3D '_';
> > > @@ -11270,9 +11272,9 @@ int probe_kern_syscall_wrapper(int token_fd)
> > >
> > >                 return pfd >=3D 0 ? 1 : 0;
> > >         } else { /* legacy mode */
> > > -               char probe_name[128];
> > > +               char probe_name[MAX_EVENT_NAME_LEN];
> > >
> > > -               gen_kprobe_legacy_event_name(probe_name, sizeof(probe=
_name), syscall_name, 0);
> > > +               gen_probe_legacy_event_name(probe_name, sizeof(probe_=
name), syscall_name, 0);
> > >                 if (add_kprobe_event_legacy(probe_name, false, syscal=
l_name, 0) < 0)
> > >                         return 0;
> > >
> > > @@ -11328,9 +11330,9 @@ bpf_program__attach_kprobe_opts(const struct =
bpf_program *prog,
> > >                                             func_name, offset,
> > >                                             -1 /* pid */, 0 /* ref_ct=
r_off */);
> > >         } else {
> > > -               char probe_name[256];
> > > +               char probe_name[MAX_EVENT_NAME_LEN];
> > >
> > > -               gen_kprobe_legacy_event_name(probe_name, sizeof(probe=
_name),
> > > +               gen_probe_legacy_event_name(probe_name, sizeof(probe_=
name),
> > >                                              func_name, offset);
> > >
> > >                 legacy_probe =3D strdup(probe_name);
> > > @@ -11875,20 +11877,6 @@ static int attach_uprobe_multi(const struct =
bpf_program *prog, long cookie, stru
> > >         return ret;
> > >  }
> > >
> > > -static void gen_uprobe_legacy_event_name(char *buf, size_t buf_sz,
> > > -                                        const char *binary_path, uin=
t64_t offset)
> > > -{
> > > -       int i;
> > > -
> > > -       snprintf(buf, buf_sz, "libbpf_%u_%s_0x%zx", getpid(), binary_=
path, (size_t)offset);
> > > -
> > > -       /* sanitize binary_path in the probe name */
> > > -       for (i =3D 0; buf[i]; i++) {
> > > -               if (!isalnum(buf[i]))
> > > -                       buf[i] =3D '_';
> > > -       }
> > > -}
> > > -
> > >  static inline int add_uprobe_event_legacy(const char *probe_name, bo=
ol retprobe,
> > >                                           const char *binary_path, si=
ze_t offset)
> > >  {
> > > @@ -12312,13 +12300,14 @@ bpf_program__attach_uprobe_opts(const struc=
t bpf_program *prog, pid_t pid,
> > >                 pfd =3D perf_event_open_probe(true /* uprobe */, retp=
robe, binary_path,
> > >                                             func_offset, pid, ref_ctr=
_off);
> > >         } else {
> > > -               char probe_name[PATH_MAX + 64];
> > > +               char probe_name[MAX_EVENT_NAME_LEN];
> > >
> > >                 if (ref_ctr_off)
> > >                         return libbpf_err_ptr(-EINVAL);
> > >
> > > -               gen_uprobe_legacy_event_name(probe_name, sizeof(probe=
_name),
> > > -                                            binary_path, func_offset=
);
> > > +               gen_probe_legacy_event_name(probe_name, sizeof(probe_=
name),
> > > +                                           basename((void *)binary_p=
ath),
> >
> > This patch is a nice refactoring overall and I like it. But this (void
> > *) cast on binary_path I'm not so fond of. Yes, if you read
> > smallprint, you'll see that with _GNU_SOURCE basename won't *really*
> > modify input argument, but meh.
> >
>
> This has been used in bpf_object__new() like:
>
>     /* Using basename() GNU version which doesn't modify arg. */
>     libbpf_strlcpy(obj->name, basename((void *)path), sizeof(obj->name));

yeah, I know, which is why I remembered this semantical quirk. Still,
in this case we are just adding a hint, so some simple strrchr() seems
adequate

>
> > Let's instead do a simple `strrchr(binary_path, '/') ?: binary_path`?
> >
> > pw-bot: cr
> >
> >
> > > +                                           func_offset);
> > >
> > >                 legacy_probe =3D strdup(probe_name);
> > >                 if (!legacy_probe)
> > > --
> > > 2.43.0
> > >

