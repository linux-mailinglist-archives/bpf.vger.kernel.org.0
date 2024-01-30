Return-Path: <bpf+bounces-20732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A719842654
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 14:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8227B2F85C
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 13:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F996D1B3;
	Tue, 30 Jan 2024 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K1ohGfaW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A44E59165
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 13:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706622121; cv=none; b=TFcyPP/X80n50dwdoOtasEX0ItAPejUqM9UoGU4pXYuqvyfcQPXyjL0STdKuUlRSm7XV0+bbq4z926HotK5WD7KJ4hJ3/4pDjpcOgpRMKkVXYZjdKfrUAyqxCnM+hvF78g92Y/zfU8NHJUA0wajV+MlYWPhBDmLDDMM93zVKCG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706622121; c=relaxed/simple;
	bh=0BeGZI2lfjCwg/wzly1hzEkL+SQ37NX3sQSXaRiSC/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VX1ISi+t4X0EAMQ+kKVL3/WK+9m7BZr7geW38wM5sxdMTnGdI7UV1mt3o5XfE0AuJ8fh1770216wuoMKxec3XyuQXY6vCy3IjraDYjTDRztrRZ/XFxkFt7XvKBvDLM6uof1z6WxuOlBXuI/PBfQ53KEIwi/K92Fn30MToMid2qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K1ohGfaW; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-361b23b9328so132445ab.1
        for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 05:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706622118; x=1707226918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbgyJimBDL2xlM1FoVUE3T9sFVvozDsEdx2g1TNsrH8=;
        b=K1ohGfaWtW9fnSR1o1Y5YWNOvXogVL9sK7bZ2uPuNMJ2JOkOXqzMWCLe0C0hpRvm5J
         859OqDhlBmX+o8uy367x6oamtJdIo+X6bhzfT/ahZF60Xv3QoteS409g/NCMLYp+BGYR
         nlg6tEG62Pe6KJ8Cil+K6otY8x4cNFD7w5M3GC7j/eYsv3sOqYjaAxKzOUivcMJtYq9i
         YtjZAxB6QO2Tqd+X0eN+pCW36TfyM8vaHTZqYzVjnOkI7NUbFczxLQSt9qFsqHZ65tMX
         yUgxNelp6/AksrW1N4OubufGQkgAArwsg6/jUw7fWJhyg2Cm9sd1Ctk8m8oEXUtnSa44
         eZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706622118; x=1707226918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbgyJimBDL2xlM1FoVUE3T9sFVvozDsEdx2g1TNsrH8=;
        b=AVBHG/AqPQF8cDKevUS+Yy3QaWRGyIs8OdbND4IGYO05rRW1r+zPR+NVWcALxpyfA+
         4TozLLl350POgQewY7xCCwiwvPri235N/7a3HOUSFNhdTEO34CVCNIwy55chxL9nGI/o
         TAYbqOUQ3xlOfOzwcqhf24e7MEXI9U/4mR33aFsgCHswEfM57OEankFRkwvKK6IqSPxj
         CV3bbdoBF8ln6GyD9JJ9qJYmDAg4M9U+IrX7GX6GpD1dVPYjPiLmvM1wMhKDywn3DJ9A
         34ePHvC1DwWHZN2el5CKKK3wTGxmj8qrFzD5+Q8eqG5gEDGrdWbvbfVmRVCwNB6PHZ3U
         md+w==
X-Gm-Message-State: AOJu0YyIKsjkI6Vk3izx/HtM8J0YbQKFmjcmXAsU9HVC38DYRxVEuxCt
	27miH0MWGgfMfiE21WmP6u0S2WWQbL00S8fwciUQ5zksuaPhSo/vVnt1uumjEw1Aya8Og/H/uGg
	7w9HlVUyb2qc+L6QqUgVCyi1RTsZ6Ts7RrgWi
X-Google-Smtp-Source: AGHT+IFTttrH0F0yFcNDAhaFz/OUEZdWofrsyIOjQ2cUIUV60IsTbFRJFPYibEwh47w8FBbLvqod5S8rXW+N2rbJZEA=
X-Received: by 2002:a92:d483:0:b0:363:7b27:283b with SMTP id
 p3-20020a92d483000000b003637b27283bmr183068ilg.11.1706622118267; Tue, 30 Jan
 2024 05:41:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125231840.1647951-1-irogers@google.com> <CAEf4BzamUW+O35hfj-SctPo0Z-oZk5u-96fvD0cFPDZTwFyiMg@mail.gmail.com>
In-Reply-To: <CAEf4BzamUW+O35hfj-SctPo0Z-oZk5u-96fvD0cFPDZTwFyiMg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 30 Jan 2024 05:41:47 -0800
Message-ID: <CAP-5=fWd3U4VTU7Quj+EjdU8F_o3VwprUz18PeAGfphgUS7vPg@mail.gmail.com>
Subject: Re: [PATCH v3] libbpf: Add some details for BTF parsing failures
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 4:43=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Jan 25, 2024 at 3:18=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > As CONFIG_DEBUG_INFO_BTF is default off the existing "failed to find
> > valid kernel BTF" message makes diagnosing the kernel build issue some
> > what cryptic. Add a little more detail with the hope of helping users.
> >
> > Before:
> > ```
> > libbpf: failed to find valid kernel BTF
> > libbpf: Error loading vmlinux BTF: -3
> > ```
> >
> > After not accessible:
> > ```
> > libbpf: access to canonical vmlinux (/sys/kernel/btf/vmlinux) to load B=
TF failed: No such file or directory
> > libbpf: was CONFIG_DEBUG_INFO_BTF enabled?
> > libbpf: failed to find valid kernel BTF
> > libbpf: Error loading vmlinux BTF: -3
> > ```
> >
> > After not readable:
> > ```
> > libbpf: unable to read canonical vmlinux (/sys/kernel/btf/vmlinux): Per=
mission denied
> > libbpf: failed to find valid kernel BTF
> > libbpf: Error loading vmlinux BTF: -3
> > ```
> >
> > Closes: https://lore.kernel.org/bpf/CAP-5=3DfU+DN_+Y=3DY4gtELUsJxKNDDCO=
vJzPHvjUVaUoeFAzNnig@mail.gmail.com/
> > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > ---
> > v3. Try to address review comments from Andrii Nakryiko.
>
> I did some further simplifications and clean ups while applying.
>
> I dropped an extra faccessat(R_OK) check for /sys/kernel/btf/vmlinux
> and instead if F_OK passes, just go ahead and try to parse
> /sys/kernel/btf/vmlinux. If we have no access, we should get -EPERM or
> -EACCESS (I didn't check which), otherwise we'll either parse or won't
> find any BTF, both are errors. If /sys/kernel/btf/vmlinux exists,
> there seems to be little point nowadays to try fallback locations,
> kernel clearly is modern enough to generate /sys/kernel/btf/vmlinux,
> so we just bail out with error.
>
> Please check the landed commit in bpf-next and let me know if it
> doesn't cover your use case properly.

It does, thanks Andrii!

Ian

> > ---
> >  tools/lib/bpf/btf.c | 35 +++++++++++++++++++++++++++--------
> >  1 file changed, 27 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index ec92b87cae01..45983f42aba9 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -4932,10 +4932,9 @@ static int btf_dedup_remap_types(struct btf_dedu=
p *d)
> >   */
> >  struct btf *btf__load_vmlinux_btf(void)
> >  {
> > +       const char *canonical_vmlinux =3D "/sys/kernel/btf/vmlinux";
> > +       /* fall back locations, trying to find vmlinux on disk */
> >         const char *locations[] =3D {
> > -               /* try canonical vmlinux BTF through sysfs first */
> > -               "/sys/kernel/btf/vmlinux",
> > -               /* fall back to trying to find vmlinux on disk otherwis=
e */
> >                 "/boot/vmlinux-%1$s",
> >                 "/lib/modules/%1$s/vmlinux-%1$s",
> >                 "/lib/modules/%1$s/build/vmlinux",
> > @@ -4946,14 +4945,34 @@ struct btf *btf__load_vmlinux_btf(void)
> >         };
> >         char path[PATH_MAX + 1];
> >         struct utsname buf;
> > -       struct btf *btf;
> > +       struct btf *btf =3D NULL;
> >         int i, err;
> >
> > -       uname(&buf);
> > +       /* is canonical sysfs location accessible? */
> > +       err =3D faccessat(AT_FDCWD, canonical_vmlinux, F_OK, AT_EACCESS=
);
> > +       if (err) {
> > +               pr_warn("access to canonical vmlinux (%s) to load BTF f=
ailed: %s\n",
> > +                       canonical_vmlinux, strerror(errno));
> > +               pr_warn("was CONFIG_DEBUG_INFO_BTF enabled?\n");
> > +       } else {
> > +               err =3D faccessat(AT_FDCWD, canonical_vmlinux, R_OK, AT=
_EACCESS);
> > +               if (err) {
> > +                       pr_warn("unable to read canonical vmlinux (%s):=
 %s\n",
> > +                               canonical_vmlinux, strerror(errno));
> > +               }
> > +       }
> > +       if (!err) {
> > +               /* load canonical and return any parsing failures */
> > +               btf =3D btf__parse(canonical_vmlinux, NULL);
> > +               err =3D libbpf_get_error(btf);
> > +               pr_debug("loading kernel BTF '%s': %d\n", canonical_vml=
inux, err);
> > +               return btf;
> > +       }
> >
> > +       /* try fallback locations */
> > +       uname(&buf);
> >         for (i =3D 0; i < ARRAY_SIZE(locations); i++) {
> >                 snprintf(path, PATH_MAX, locations[i], buf.release);
> > -
> >                 if (faccessat(AT_FDCWD, path, R_OK, AT_EACCESS))
> >                         continue;
> >
> > @@ -4965,9 +4984,9 @@ struct btf *btf__load_vmlinux_btf(void)
> >
> >                 return btf;
> >         }
> > -
> >         pr_warn("failed to find valid kernel BTF\n");
> > -       return libbpf_err_ptr(-ESRCH);
> > +       /* return the last error or ESRCH if no fallback locations were=
 found */
> > +       return btf ?: libbpf_err_ptr(-ESRCH);
> >  }
> >
> >  struct btf *libbpf_find_kernel_btf(void) __attribute__((alias("btf__lo=
ad_vmlinux_btf")));
> > --
> > 2.43.0.429.g432eaa2c6b-goog
> >

