Return-Path: <bpf+bounces-3296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CD573BD85
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 19:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44B2281C87
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 17:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51277100C2;
	Fri, 23 Jun 2023 17:12:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12679944B
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 17:12:00 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FE4C7
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 10:11:59 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3112c11fdc9so877769f8f.3
        for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 10:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687540318; x=1690132318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80t4GLwyXkPzj10cZ6ETqaxFLYs6Ye0bHiMhVUCn6b0=;
        b=hcriN1YydIkQcVev9JQOzEMprsg1quefwgvt4/SG9ZzL188e/XGNNVLfVgvgYsYneH
         EyDQKARlwEO2977IwFk/obwsDACYjncXxAezgCpDxDcHxSJ2+rd+vjStzrEoN/R8OKqU
         qmD+zRYf+OoF400+E5TtKZhZHihFFe0oX70QYB5lP6QCsTd8oNIODlUochBsPp0RKDpQ
         34rgPVEwl78fYKcmHkBuf3AzBWGRXSZsCJcUOikE9kUepeosjmq61AUZ9SuaEgN+cK9f
         lYgIoauzBVcFC97n4s7exGd85x1+vU9CyW6X3rdkF5jinDizdxcLJjuc8O2nsPetkI4Y
         tu9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687540318; x=1690132318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80t4GLwyXkPzj10cZ6ETqaxFLYs6Ye0bHiMhVUCn6b0=;
        b=UeFd7NzEinhXetiUo/g9GSECKHJxLaigaSM99anqMiFyO4exM4CoVizz2vskWBSyoG
         hweMlnNcv7C82lg63fwkL6Aal1VoUYYFZK8VZiEhOwEbu6hlbRVZFRYbDAGeoD3ZZSE/
         6UVHZCPyWXywM7ttF/CPfVXcHWAu3t/Nb/syK+hiNWbUdG58MlSw/aGphGJK/KN2UOa0
         qFsiXzMwhZqMGAbnrP1FAG4hIjvfVdYUSTVI6ywExezaITuYoUunoq1V2C3BW/1+MymX
         ag053jRfnoxNIKi4XwBHxyaFsUbAK2Wyn8PX00ROrixcmj2PkQaiiDdqesDKPhUWd6Re
         LE1g==
X-Gm-Message-State: AC+VfDxwAmZLmuGf2PTb5CFIZZ8lYKn4fId4OHhPQFiIPotLJh95P6w8
	zjdHKHIYJIEtXvqZVvfkKcRZM9/UloFaA57em0Q=
X-Google-Smtp-Source: ACHHUZ6RdiqV7B9BeKLbAivRktyMjL1NKJebvKWQYWFrYDpt2eHluGERgeqKbkfhn2bCi9hoflagaBnuBYBCcK6xsxA=
X-Received: by 2002:a5d:4538:0:b0:311:1120:f2a8 with SMTP id
 j24-20020a5d4538000000b003111120f2a8mr16208954wra.50.1687540317686; Fri, 23
 Jun 2023 10:11:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230620083550.690426-1-jolsa@kernel.org> <20230620083550.690426-2-jolsa@kernel.org>
 <CAEf4BzZnn-m-5sTQEmCSyaQPNNyreE37Vu2GWtdLT=k+zR+kDA@mail.gmail.com>
 <ZJVViQEvUnMQN43b@krava> <CAEf4BzaQGqhO3hoGW-zvhioE=VKVpuMw5NTTvUw=sXTEoFptxA@mail.gmail.com>
 <CAADnVQKT2=MHXj4RD9TXwqnPqau94UMHgjspYGgyGpz_aUQjCg@mail.gmail.com>
In-Reply-To: <CAADnVQKT2=MHXj4RD9TXwqnPqau94UMHgjspYGgyGpz_aUQjCg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 23 Jun 2023 10:11:45 -0700
Message-ID: <CAEf4BzZRwsPK1mHDob4ROWjFyxaGM7vcQ7xZ8xQgEuY-7hFu_w@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 01/24] bpf: Add multi uprobe link
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 9:39=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jun 23, 2023 at 9:24=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > > > > +
> > > > > +static int uprobe_prog_run(struct bpf_uprobe *uprobe,
> > > > > +                          unsigned long entry_ip,
> > > > > +                          struct pt_regs *regs)
> > > > > +{
> > > > > +       struct bpf_uprobe_multi_link *link =3D uprobe->link;
> > > > > +       struct bpf_uprobe_multi_run_ctx run_ctx =3D {
> > > > > +               .entry_ip =3D entry_ip,
> > > > > +       };
> > > > > +       struct bpf_prog *prog =3D link->link.prog;
> > > > > +       struct bpf_run_ctx *old_run_ctx;
> > > > > +       int err =3D 0;
> > > > > +
> > > > > +       might_fault();
> > > > > +
> > > > > +       rcu_read_lock_trace();
> > > >
> > > > we don't need this if uprobe is not sleepable, right? why unconditi=
onal then?
> > >
> > > I won't pretend I understand what rcu_read_lock_trace does ;-)
> > >
> > > I tried to follow bpf_prog_run_array_sleepable where it's called
> > > unconditionally for both sleepable and non-sleepable progs
> > >
> > > there are conditional rcu_read_un/lock calls later on
> > >
> > > I will check
> >
> > hm... Alexei can chime in here, but given here we actually are trying
> > to run one BPF program (not entire array of them), we do know whether
> > it's going to be sleepable or not. So we can avoid unnecessary
> > rcu_read_{lock,unlock}_trace() calls. rcu_read_lock_trace() is used
> > when there is going to be sleepable BPF program executed to protect
> > BPF maps and other resources from being freed too soon. But if we know
> > that we don't need sleepable, we can avoid that.
>
> We can add more checks and bool flags to avoid rcu_read_{lock,unlock}_tra=
ce(),
> but it will likely be slower. These calls are very fast.

that's ok then. But seeing how we do

rcu_read_lock_trace();
if (!sleepable)
    rcu_read_lock();

it felt like we might as well just do

if (sleepable)
    rcu_read_lock_trace();
else
    rcu_read_lock();


As I mentioned, in this case we have a single bpf_prog, not a
bpf_prog_array, so that changes things a bit.

But ultimately, the context switch required for uprobe dwarfs overhead
of any of this, presumably, so it's a minor concern.

> Simpler and faster to do it unconditionally even when the array doesn't
> have sleepable progs.
> rcu_read_lock() we have to do conditionally, because it won't be ok
> if sleepable progs are in the array.

