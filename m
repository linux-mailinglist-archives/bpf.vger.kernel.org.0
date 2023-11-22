Return-Path: <bpf+bounces-15646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6F67F4820
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 14:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E2731C20AFB
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 13:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE05325560;
	Wed, 22 Nov 2023 13:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7Jtoo2h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72ABAD50
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 05:48:58 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a00f67f120aso323247766b.2
        for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 05:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700660937; x=1701265737; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+wTOUdmVRfoZRe3TwNvBuMk3+gy4xmj3oNwPwLVNCfY=;
        b=k7Jtoo2hf1wX7m/SSx9C0BX6BIrhcPR18g8t1E2/fY8sTOoHDQDs7yctXBA2p39Y6I
         lRmvypn8RhwSuqd1cNBRT9Z/jsLiZJe8GabVgwzO1Vp0vpHhR57inJFngX6nFsArzLNX
         LKyPOXhFKIkQ+bYATjzrvLOv+3uYTuQcpD+flz5uSLtyzimTqAfWKGiin7ghkzmepr5S
         DhRDWIbpfB20CFo1i5BRDUL+KqYtFqu8Fw2aZudBevJk0x5+xWyb21FH/BUg2VQIsXfy
         gy+XG60WamyXUXsRULmI6Rdx2JBVlKOQ1+z9MGtlFqnsNXxioBMS/RRLGxi6PsvY2DOp
         pZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700660937; x=1701265737;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+wTOUdmVRfoZRe3TwNvBuMk3+gy4xmj3oNwPwLVNCfY=;
        b=ipNYEm8Y+PgTXnyO/4Dyo6y3wRE5EK2YOquZNYSn8fgWh98zOuNatFGmWBPykyYTMM
         IdNvyHVHl1jpUquGoThoQrnIcYnIAI9VteoaTdmY/nabQ4ZB9gJxsiyUifbdEWd4FMVd
         KyjZlj8jPiuOz96LL0XIxzqG2VWYy5259Ei2++sAMBmEtG7nZQZmtiDSswXm7okBiTYB
         v4NNmwetS+2goJPVAzrJoIRGTiHraInpxxAuvKgCzPnz4Wf66ro4rb8TRTCNduOFR/Kk
         lVNLQGVeowrwSbDZVUkHRQfjpT5XtzcZyAftWYhXaP4gruFxaP+wYpU3CtNyVMQE+78h
         FIfA==
X-Gm-Message-State: AOJu0YzDek/thWpItSUwet1m2OWlkLd3hgoAZw6VLVJDFY/3U/LQjk0n
	Ab/pT54NJR6uIdDs13G8TBE=
X-Google-Smtp-Source: AGHT+IHXdwxtEsMt/ucbsT2Q8vcwg4DU2jaEtPwQjhAei/oheE9B/xjW14Xlrj5Zqgl6DUY5gbQsVA==
X-Received: by 2002:a17:907:c204:b0:9fc:b083:e549 with SMTP id ti4-20020a170907c20400b009fcb083e549mr2483435ejc.54.1700660936442;
        Wed, 22 Nov 2023 05:48:56 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id h19-20020a170906591300b00a047f065fa6sm772001ejq.206.2023.11.22.05.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 05:48:56 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 22 Nov 2023 14:48:54 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCHv3 bpf-next 3/6] bpf: Add link_info support for uprobe
 multi link
Message-ID: <ZV4GxrqnrvxBppC/@krava>
References: <20231120145639.3179656-1-jolsa@kernel.org>
 <20231120145639.3179656-4-jolsa@kernel.org>
 <CAEf4BzY0EpOorNs2Vm0ijeYsL7doAf4-mQBoz6y1xpWb2bWY6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzY0EpOorNs2Vm0ijeYsL7doAf4-mQBoz6y1xpWb2bWY6Q@mail.gmail.com>

On Tue, Nov 21, 2023 at 10:41:24AM -0800, Andrii Nakryiko wrote:
> On Mon, Nov 20, 2023 at 6:57 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding support to get uprobe_link details through bpf_link_info
> > interface.
> >
> > Adding new struct uprobe_multi to struct bpf_link_info to carry
> > the uprobe_multi link details.
> >
> > The uprobe_multi.count is passed from user space to denote size
> > of array fields (offsets/ref_ctr_offsets/cookies). The actual
> > array size is stored back to uprobe_multi.count (allowing user
> > to find out the actual array size) and array fields are populated
> > up to the user passed size.
> >
> > All the non-array fields (path/count/flags/pid) are always set.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/uapi/linux/bpf.h       | 10 +++++
> >  kernel/trace/bpf_trace.c       | 72 ++++++++++++++++++++++++++++++++++
> >  tools/include/uapi/linux/bpf.h | 10 +++++
> >  3 files changed, 92 insertions(+)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 7a5498242eaa..a63b5eb7f9ec 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -6562,6 +6562,16 @@ struct bpf_link_info {
> >                         __u32 flags;
> >                         __u64 missed;
> >                 } kprobe_multi;
> > +               struct {
> > +                       __aligned_u64 path;
> > +                       __aligned_u64 offsets;
> > +                       __aligned_u64 ref_ctr_offsets;
> > +                       __aligned_u64 cookies;
> > +                       __u32 path_size; /* in/out: real path size on success */
> > +                       __u32 count; /* in/out: uprobe_multi offsets/ref_ctr_offsets/cookies count */
> > +                       __u32 flags;
> > +                       __u32 pid;
> > +               } uprobe_multi;
> >                 struct {
> >                         __u32 type; /* enum bpf_perf_event_type */
> >                         __u32 :32;
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index ad0323f27288..ca453b642819 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -3044,6 +3044,7 @@ struct bpf_uprobe_multi_link {
> >         u32 cnt;
> >         struct bpf_uprobe *uprobes;
> >         struct task_struct *task;
> > +       u32 flags;
> 
> this fits better after cnt to avoid increasing the size of
> bpf_uprobe_multi_link, please it move up

ok

> 
> >  };
> >
> >  struct bpf_uprobe_multi_run_ctx {
> > @@ -3083,9 +3084,79 @@ static void bpf_uprobe_multi_link_dealloc(struct bpf_link *link)
> >         kfree(umulti_link);
> >  }
> >
> > +static int bpf_uprobe_multi_link_fill_link_info(const struct bpf_link *link,
> > +                                               struct bpf_link_info *info)
> > +{
> > +       u64 __user *uref_ctr_offsets = u64_to_user_ptr(info->uprobe_multi.ref_ctr_offsets);
> > +       u64 __user *ucookies = u64_to_user_ptr(info->uprobe_multi.cookies);
> > +       u64 __user *uoffsets = u64_to_user_ptr(info->uprobe_multi.offsets);
> > +       u64 __user *upath = u64_to_user_ptr(info->uprobe_multi.path);
> > +       u32 upath_size = info->uprobe_multi.path_size;
> > +       struct bpf_uprobe_multi_link *umulti_link;
> > +       u32 ucount = info->uprobe_multi.count;
> > +       int err = 0, i;
> > +       long left;
> > +
> > +       if (!upath ^ !upath_size)
> > +               return -EINVAL;
> > +
> > +       if ((uoffsets || uref_ctr_offsets || ucookies) && !ucount)
> > +               return -EINVAL;
> > +
> > +       umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
> > +       info->uprobe_multi.count = umulti_link->cnt;
> > +       info->uprobe_multi.flags = umulti_link->flags;
> > +       info->uprobe_multi.pid = umulti_link->task ?
> > +                                task_pid_nr_ns(umulti_link->task, task_active_pid_ns(current)) : 0;
> > +
> > +       if (upath) {
> > +               char *p, *buf;
> > +
> > +               upath_size = min_t(u32, upath_size, PATH_MAX);
> > +
> > +               buf = kmalloc(upath_size, GFP_KERNEL);
> > +               if (!buf)
> > +                       return -ENOMEM;
> > +               p = d_path(&umulti_link->path, buf, upath_size);
> > +               if (IS_ERR(p)) {
> > +                       kfree(buf);
> > +                       return -ENOSPC;
> > +               }
> > +               upath_size = buf + upath_size - p;
> > +               left = copy_to_user(upath, p, upath_size);
> > +               kfree(buf);
> > +               if (left)
> > +                       return -EFAULT;
> > +               info->uprobe_multi.path_size = upath_size - 1 /* NULL */;
> 
> why subtract zero terminating byte? I think we should drop this -1 and
> return filled out buffer content size, including zero terminator.

I wanted to return the same as strlen would:

       The strlen() function calculates the length of the string pointed to by s, excluding the terminating null byte ('\0').

either way works for me, but perhaps we should document it in the uapi header

jirka

