Return-Path: <bpf+bounces-9271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 193D8792D7B
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 20:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D230D281211
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 18:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A4BDDCA;
	Tue,  5 Sep 2023 18:40:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2813BD53B
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 18:40:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9D9C43215
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 18:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693939255;
	bh=G09su3IehpXxn3VDyOVRh9WdziKZ6oh64n9mbK3zmYM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Jbwcqz8Coq/cLy8nNRVRRyp8QdLRZJV5CXXEOFfgYYl4XI51FU5SpTmFArTzDzBlW
	 zBvaxkbG4I3gg42gByQGukOFrswJUff6LgKI7Pc4W08psxumnWn2ZxK2xiuH49dcUv
	 T0q//dVtghN27+iQ5tWaBkZ8VZrhoKwC33fPa7cIKsXutrdJgOefMeE8LebaJ6ZtEh
	 rooN7D25CTwTzPUeb3jvQKDjhM1xPnhUmOzo0HBKCOHCYFK5DA/pL+O9Jm0INKGTb+
	 E9vNN6j4rrmwgE6rYUqLBmBTaKfQij9JCK5a3zwiV4efCZEh2S1Ig2i+66RnVO065L
	 SuhmtwTLzeDWA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-500c6ff99acso161920e87.1
        for <bpf@vger.kernel.org>; Tue, 05 Sep 2023 11:40:55 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyn6mHTg/1UPqXlMorI64rBkI97cka2ljKIKfwlji6h6oukcAoS
	5Qy6J/5MrLeCyffohZUsJnw2S0XjPWjX71UySFQ=
X-Google-Smtp-Source: AGHT+IG2Z99SQbdQ2cKjJufRTyvvUFwYgfcoG61o09mRsp2ffmYIshp7nSlKT0vXtlRF4pihwyFDZXPQFrKOrnkofU0=
X-Received: by 2002:a2e:9990:0:b0:2bc:dd8f:ccd7 with SMTP id
 w16-20020a2e9990000000b002bcdd8fccd7mr251695lji.16.1693939253413; Tue, 05 Sep
 2023 11:40:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230831141103.359810-1-jolsa@kernel.org> <1fc894ed-0f54-ea4f-8b2f-d7120b6d9c0f@iogearbox.net>
 <CAPhsuW64KL9T2B9ePzLSvfW2UonCircVj48+GozagJi8xLNo7w@mail.gmail.com> <ZPWCyELkdspCPXP3@krava>
In-Reply-To: <ZPWCyELkdspCPXP3@krava>
From: Song Liu <song@kernel.org>
Date: Tue, 5 Sep 2023 11:40:39 -0700
X-Gmail-Original-Message-ID: <CAPhsuW71bNbpfqNQ6xfSKbv3pB5YQWPWp3bb5mgT1V3cJ2zHvg@mail.gmail.com>
Message-ID: <CAPhsuW71bNbpfqNQ6xfSKbv3pB5YQWPWp3bb5mgT1V3cJ2zHvg@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next] selftests/bpf: Fix d_path test
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 4, 2023 at 12:10=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Fri, Sep 01, 2023 at 04:09:31PM -0700, Song Liu wrote:
> > On Thu, Aug 31, 2023 at 8:21=E2=80=AFAM Daniel Borkmann <daniel@iogearb=
ox.net> wrote:
> > >
> > > On 8/31/23 4:11 PM, Jiri Olsa wrote:
> > > > Recent commit [1] broken d_path test, because now filp_close is not=
 called
> > > > directly from sys_close, but eventually later when the file is fina=
lly
> > > > released.
> > > >
> > > > As suggested by Hou Tao we don't need to re-hook the bpf program, b=
ut just
> > > > instead we can use sys_close_range to trigger filp_close synchronou=
sly.
> > > >
> > > > [1] 021a160abf62 ("fs: use __fput_sync in close(2)")
> > > > Suggested-by: Hou Tao <houtao@huaweicloud.com>
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > >
> > > That did the trick, thanks everyone, applied!
> >
> > I guess I am a bit late. But how about we use something like the follow=
ing?
> > I like this one better because it tests bpf_d_path() from retval at fex=
it.
>
> right, that would have been an option as well
>
> >
> > Thanks,
> > Song
> >
> >
> >
> >
> > diff --git i/kernel/trace/bpf_trace.c w/kernel/trace/bpf_trace.c
> > index a7264b2c17ad..fe91836cedcd 100644
> > --- i/kernel/trace/bpf_trace.c
> > +++ w/kernel/trace/bpf_trace.c
> > @@ -941,6 +941,7 @@ BTF_ID(func, vfs_fallocate)
> >  BTF_ID(func, dentry_open)
> >  BTF_ID(func, vfs_getattr)
> >  BTF_ID(func, filp_close)
> > +BTF_ID(func, close_fd_get_file)
>
> I liked using the close_range syscall because we did not need to
> add new allowed function.. however close_fd_get_file looks safe
> enough so I wouldn't mind changing that if you insist ;-)

Let's use close_range() then. I will send another patch to test
something with "struct file *" as retval on fexit.

Thanks,
Song

