Return-Path: <bpf+bounces-3291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E3873BCCB
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 18:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E54F41C212F1
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 16:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1AEAD2A;
	Fri, 23 Jun 2023 16:39:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FDC8C16
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 16:39:50 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D21295B
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 09:39:32 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51bec9aaf7bso919998a12.1
        for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 09:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687538368; x=1690130368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkHoIwi12sYBlwAx8Ze//qn83kNQMmXpJBnsidspcj4=;
        b=mcdlI1oG9tBmOBYBcVq3TlclHmkGoz9ogfRWcDyLRZ6j1E7caJ0Eb/H0Zd3wsF69mG
         vddb+wkIWSMsBHYuD+lfhebM5VVgdas79HCYEZCi17vPrDovFPWwTnBdZ6USb6Ozy86X
         L8xDu3S5Wl3abgBkQFQ/kT8aD2ncPbWq6Xs6Fw/8ndTYYvC5jKrm2M4Qxg3vFvxsfn5L
         a7WJqsDYiXLyuPlKc+YcwOq89DtoirXMo2Zrs4+dyJOdVpSvG1w+tyDVqsPdlGIX/ju4
         x3bCYFRdUaSHlD4vtfWZFbKXABNWovBSHR7X1pcKNLfxgsFGrmhMCVTEnAtkb2KJSe4D
         Ps4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687538368; x=1690130368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkHoIwi12sYBlwAx8Ze//qn83kNQMmXpJBnsidspcj4=;
        b=flCs98Lhb0bysu+Xj7ayFOXiDPfPK0Ku1o3HTgoC03VWyHjkh1LpEWMiddpRE95zuu
         X+zYMM0duOiBOQ2yLN5wab+3lOXVOcD+LJBLb74Nr6dunXnrScUdDfR7l+V87WQlkRoy
         D4LuXpM45hEQyO79IE0ksYb6UdDWH+mRp2bpkeiFqgbrrwPD+cqsgq8EzH/RfWooH+JM
         u0PUcEcNM2qqJJlrrFc3gi5YWgsCerlqlGbZ0sHSOFQX35yeO6upolhgsWrLqAkplBG+
         Dzu5r2Zzqhh6r/lapMIpMHhU/BIZRBIyQpzuQII3l3L0TA0sr4dVRmnbrRikgSuDdBXe
         sX+A==
X-Gm-Message-State: AC+VfDx5AbSCg+akECkjvB/bfRMBku2vaH16nJ1xTynwtAz6Iew4qDOz
	smm0O8gHHup47M7xq5V4r47AUJeSPeSin/zjVN4=
X-Google-Smtp-Source: ACHHUZ7CMCL1K1We+QmYb6J0gnRO0LCszzIF1pIPg4Tl9D4GKi1iaS4FF6vz5TLqGyXpWEddeDZCZZnZ1aM98iN47E8=
X-Received: by 2002:aa7:cb50:0:b0:51b:e89e:a847 with SMTP id
 w16-20020aa7cb50000000b0051be89ea847mr3820327edt.21.1687538367991; Fri, 23
 Jun 2023 09:39:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230620083550.690426-1-jolsa@kernel.org> <20230620083550.690426-2-jolsa@kernel.org>
 <CAEf4BzZnn-m-5sTQEmCSyaQPNNyreE37Vu2GWtdLT=k+zR+kDA@mail.gmail.com>
 <ZJVViQEvUnMQN43b@krava> <CAEf4BzaQGqhO3hoGW-zvhioE=VKVpuMw5NTTvUw=sXTEoFptxA@mail.gmail.com>
In-Reply-To: <CAEf4BzaQGqhO3hoGW-zvhioE=VKVpuMw5NTTvUw=sXTEoFptxA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 23 Jun 2023 09:39:16 -0700
Message-ID: <CAADnVQKT2=MHXj4RD9TXwqnPqau94UMHgjspYGgyGpz_aUQjCg@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 01/24] bpf: Add multi uprobe link
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
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

On Fri, Jun 23, 2023 at 9:24=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> > > > +
> > > > +static int uprobe_prog_run(struct bpf_uprobe *uprobe,
> > > > +                          unsigned long entry_ip,
> > > > +                          struct pt_regs *regs)
> > > > +{
> > > > +       struct bpf_uprobe_multi_link *link =3D uprobe->link;
> > > > +       struct bpf_uprobe_multi_run_ctx run_ctx =3D {
> > > > +               .entry_ip =3D entry_ip,
> > > > +       };
> > > > +       struct bpf_prog *prog =3D link->link.prog;
> > > > +       struct bpf_run_ctx *old_run_ctx;
> > > > +       int err =3D 0;
> > > > +
> > > > +       might_fault();
> > > > +
> > > > +       rcu_read_lock_trace();
> > >
> > > we don't need this if uprobe is not sleepable, right? why uncondition=
al then?
> >
> > I won't pretend I understand what rcu_read_lock_trace does ;-)
> >
> > I tried to follow bpf_prog_run_array_sleepable where it's called
> > unconditionally for both sleepable and non-sleepable progs
> >
> > there are conditional rcu_read_un/lock calls later on
> >
> > I will check
>
> hm... Alexei can chime in here, but given here we actually are trying
> to run one BPF program (not entire array of them), we do know whether
> it's going to be sleepable or not. So we can avoid unnecessary
> rcu_read_{lock,unlock}_trace() calls. rcu_read_lock_trace() is used
> when there is going to be sleepable BPF program executed to protect
> BPF maps and other resources from being freed too soon. But if we know
> that we don't need sleepable, we can avoid that.

We can add more checks and bool flags to avoid rcu_read_{lock,unlock}_trace=
(),
but it will likely be slower. These calls are very fast.
Simpler and faster to do it unconditionally even when the array doesn't
have sleepable progs.
rcu_read_lock() we have to do conditionally, because it won't be ok
if sleepable progs are in the array.

