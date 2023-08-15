Return-Path: <bpf+bounces-7783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C48E177C610
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 04:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 862C81C20BD3
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 02:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F3F1C13;
	Tue, 15 Aug 2023 02:46:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E062F1FB6
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 02:46:18 +0000 (UTC)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27071715
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 19:46:17 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-6418d37f006so25633746d6.2
        for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 19:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692067577; x=1692672377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOisQtV6rmKAqeGYvqjvfN7hklNuRtsKGxaBOCuoNRY=;
        b=FCT0EISC5JeYGg8rX0asrbplZ3LSwv8IvfjShd2LqSJiiLnhcwaKcP++7DiIr+z/yF
         pilEKj/S6tSohrY0dZKdcOf38AGfcD+ldpLRLhdryzqtrNO8uF5VYoAGPWgR1jdPf/54
         WV3D12oZmOwwt1QMKhejPf75khyd3xYq1U95e5DCsqKZDBLRfa8v1ob/TjHlSA7bRHQy
         DV5Rutd50xp8N+6ArFAFXKJhJPJzmcK1fmqZCdFLrawTlIi0xCoBW9YY3QYb/lh2WirE
         bKwGjMy+4Ch+vN3Ya2rc/sMxjCeIEo/V5Om3tSRNrVaWAT6RSSqksHSUAqLx+gG0u2kq
         RLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692067577; x=1692672377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOisQtV6rmKAqeGYvqjvfN7hklNuRtsKGxaBOCuoNRY=;
        b=HWBSoY8Pa7JcHzqtxFOwDRtYkod9ZeAo+o4K+cWOxkSc6+IxcbZv1OTKo5fSN96Cvc
         SGPEzYfSQnQ1RkvS4PQ+TojFBKS9Hqp11zF2dsQtyneStgVdxns2lx3TVV/3CGHQAP7s
         wfnr+Hej/znS+89mwRaUcImeT7FhnvTbcFRu0wjScxcdG+VsgXKbf+D08h3Eq9Q7bKHr
         AizcwhlLZqV/IOH2KGh88WgmXHyHseZFIlyQYSTLY6eehNMxEMHvJkzNiwpSPASSZ+dX
         09rRrQfadZPU5hJsHONsyOWRSBjz/lvmaFjmb+8e4Uj4r1kJptfM08dP2AANf/HQTekX
         l5hQ==
X-Gm-Message-State: AOJu0YwEV1mkCZ1M0mE+bmApc+4vT5r6a736G1maR+OmXBcS5xiUe6VQ
	Uk1tWajsSNFwPOxSXrMmz2P8q5HBoXFNU6xx/NU=
X-Google-Smtp-Source: AGHT+IFsupL9yyj97gcMzist6DNzp7CYnbTAAAxXd2CKfQF9X/OR6qlVH6F5gspk0htjMqBx+Zs3ueslK4JyCp8K7mY=
X-Received: by 2002:a05:6214:712:b0:63f:8677:34a with SMTP id
 c18-20020a056214071200b0063f8677034amr11452341qvz.50.1692067576769; Mon, 14
 Aug 2023 19:46:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230814143341.3767-1-laoar.shao@gmail.com> <20230814143341.3767-2-laoar.shao@gmail.com>
 <56dc2449-f01c-f0a7-e31b-cfe6cd157aaa@linux.dev>
In-Reply-To: <56dc2449-f01c-f0a7-e31b-cfe6cd157aaa@linux.dev>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 15 Aug 2023 10:45:40 +0800
Message-ID: <CALOAHbC9cka4Ma7KWOjGtFkjshU214z9NMaYXHiOTfc7dc7=tQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/2] bpf: Add bpf_current_capable kfunc
To: yonghong.song@linux.dev
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 15, 2023 at 8:28=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
> On 8/14/23 7:33 AM, Yafang Shao wrote:
> > Add a new bpf_current_capable kfunc to check whether the current task
> > has a specific capability. In our use case, we will use it in a lsm bpf
> > program to help identify if the user operation is permitted.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >   kernel/bpf/helpers.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index eb91cae..bbee7ea 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -2429,6 +2429,11 @@ __bpf_kfunc void bpf_rcu_read_unlock(void)
> >       rcu_read_unlock();
> >   }
> >
> > +__bpf_kfunc bool bpf_current_capable(int cap)
> > +{
> > +     return has_capability(current, cap);
> > +}
>
> Since you are testing against 'current' capabilities, I assume
> that the context should be process. Otherwise, you are testing
> against random task which does not make much sense.

It is in the process context.

>
> Since you are testing against 'current' cap, and if the capability
> for that task is stable, you do not need this kfunc.
> You can test cap in user space and pass it into the bpf program.
>
> But if the cap for your process may change in the middle of
> run, then you indeed need bpf prog to test capability in real time.
> Is this your use case and could you describe in in more detail?

After we convert the capability of our networking bpf program from
CAP_SYS_ADMIN to CAP_BPF+CAP_NET_ADMIN to enhance the security, we
encountered the "pointer comparison prohibited" error, because
allow_ptr_leaks is enabled only when CAP_PERFMON is set. However, if
we enable the CAP_PERFMON for the networking bpf program, it can run
tracing bpf prog, perf_event bpf prog and etc, that is not expected by
us.

Hence we are planning to use a lsm bpf program to disallow it from
running other bpf programs. In our lsm bpf program we will check the
capability of processes, if the process has cap_net_admin, cap_bpf and
cap_perfmon but don't have cap_sys_admin we will refuse it to run
tracing and perf_event bpf program. While if a process has  cap_bpf
and cap_perfmon but doesn't have cap_net_admin, that said it is a bpf
program which wants to run trace bpf, we will allow it.

We can't use lsm_cgroup because it is supported on cgroup2 only, while
we're still using cgroup1.

Another possible solution is enable allow_ptr_leaks for cap_net_admin
as well, but after I checked the commit which introduces the cap_bpf
and cap_perfmon [1], I think we wouldn't like to do it.

[1]. https://lore.kernel.org/bpf/20200513230355.7858-3-alexei.starovoitov@g=
mail.com/
--=20
Regards
Yafang

