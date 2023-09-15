Return-Path: <bpf+bounces-10163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BBD7A24A0
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 19:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9361C20AAE
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 17:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E870815EA2;
	Fri, 15 Sep 2023 17:27:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453BE125A1
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 17:27:15 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA68CF1;
	Fri, 15 Sep 2023 10:27:14 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5009d4a4897so4061217e87.0;
        Fri, 15 Sep 2023 10:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694798833; x=1695403633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o1ARKux85tGtkjmvv+aJvZ+7Wjuleao2EehnwO/y7bE=;
        b=VnSqs/haG/Rf+17GxL+OYPmpZztP7qFkt1zmqeOVwVlK9IzTQdYvxieMJnxJCPFhEc
         uqcyI0ZYB9k8hBZG/+cO4PPdDEnCnhl3R1OKTkWPmcU9FUVazs06v+z/KqsPWEFB1e9r
         h4ydsiLE6b/OMk43lHJFDgXz6SVztYCcrb2UlCczgfk8p7fDitoZMns6zxjKMXd70++w
         +8gILR5fw7mCGQLRL5HrIjvnMyJhGb1Fvv9C2BV3EMxsnv16A9iAunMJ/V9iRw8xYmC5
         4wITuMVjtyKvNKETypYK31APEJBlF2qJRgoZcsETh/+6kG7m9YiCa+Qx01bWgbCQBKRF
         eTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694798833; x=1695403633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o1ARKux85tGtkjmvv+aJvZ+7Wjuleao2EehnwO/y7bE=;
        b=WRp/W8o3nfjyPNqkRYexM9eQLn8PpK8Lw+tkj5MXrzShEEh2Q5+RFroZ50Gj++6+Kw
         R3XILWtiwwqKH7TIwNvwlMu1w3LjQ+HygEpi+/9qwWbv8+2xL7PlMP2P386QGnL2N6ZR
         cPLOj/dpTg28M4Z8s1PwGJFQ1EE6g254YaVWnuLEvGNCReJeQstPphTG+Hon/N6uoTcN
         GpbARNMPIU2FAPc4iyWxR3g0DQ2JDaCv+FDmzHOimz1ndT8ttAzRCRWWN+V7huVmKTqh
         2ZU5z89Engo0ReM3mrPpf8Pi8gF9VZTCh5Pay2m7lZHfmfq2yTuPMLXWrYeliRwy4XhZ
         rAaA==
X-Gm-Message-State: AOJu0YwrtMa4O9ye+sC1QRV56k7LSjV5AQxvC+k3USpa+M6LyE/xKxX+
	Q4jYtH5Xzl5luhJngczrE8JCJ7fsvHFbRIlsOYM=
X-Google-Smtp-Source: AGHT+IGkWGiKba7Un3yLBE1ZEyNTyy9ydkQsHIIUbv+/9hTwGg3voo1ErE3LFd6yU7IXkioFQh3BA2KFeW+90SsaQA8=
X-Received: by 2002:a19:5042:0:b0:500:bffa:5b86 with SMTP id
 z2-20020a195042000000b00500bffa5b86mr1873892lfj.6.1694798832457; Fri, 15 Sep
 2023 10:27:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230915-bpf_collision-v2-1-027670d38bdf@google.com>
 <20230915171814.GA1721473@dev-arch.thelio-3990X> <CAADnVQJVL7yo5ZrBZ99xO-MWHHg8L-SuSJrCTf-eUd-k5UO75g@mail.gmail.com>
 <CAKwvOdkbqHFTvRNWG==0FjOPHgnA-zqE2Gn_nB4ys6qvKR2+HA@mail.gmail.com>
In-Reply-To: <CAKwvOdkbqHFTvRNWG==0FjOPHgnA-zqE2Gn_nB4ys6qvKR2+HA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 15 Sep 2023 10:27:01 -0700
Message-ID: <CAADnVQLfdMuxWVGKSF+COp8Q7DnKxYL0w5crN19vPkSd0Gh7mg@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: Fix BTF_ID symbol generation collision
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, stable <stable@vger.kernel.org>, 
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, Marcus Seyfarth <m.seyfarth@gmail.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 15, 2023 at 10:24=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Sep 15, 2023 at 10:22=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Sep 15, 2023 at 10:18=E2=80=AFAM Nathan Chancellor <nathan@kern=
el.org> wrote:
> > >
> > > On Fri, Sep 15, 2023 at 09:42:20AM -0700, Nick Desaulniers wrote:
> > > > Marcus and Satya reported an issue where BTF_ID macro generates sam=
e
> > > > symbol in separate objects and that breaks final vmlinux link.
> > > >
> > > >   ld.lld: error: ld-temp.o <inline asm>:14577:1: symbol
> > > >   '__BTF_ID__struct__cgroup__624' is already defined
> > > >
> > > > This can be triggered under specific configs when __COUNTER__ happe=
ns to
> > > > be the same for the same symbol in two different translation units,
> > > > which is already quite unlikely to happen.
> > > >
> > > > Add __LINE__ number suffix to make BTF_ID symbol more unique, which=
 is
> > > > not a complete fix, but it would help for now and meanwhile we can =
work
> > > > on better solution as suggested by Andrii.
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Reported-by: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.co=
m>
> > > > Reported-by: Marcus Seyfarth <m.seyfarth@gmail.com>
> > > > Closes: https://github.com/ClangBuiltLinux/linux/issues/1913
> > > > Tested-by: Marcus Seyfarth <m.seyfarth@gmail.com>
> > > > Debugged-by: Nathan Chancellor <nathan@kernel.org>
> > > > Co-developed-by: Jiri Olsa <jolsa@kernel.org>
> > > > Link: https://lore.kernel.org/bpf/CAEf4Bzb5KQ2_LmhN769ifMeSJaWfebcc=
UasQOfQKaOd0nQ51tw@mail.gmail.com/
> > > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > > > ---
> > > >  tools/include/linux/btf_ids.h | 2 +-
> > >
> > > Shouldn't this diff be in include/linux/btf_ids.h as well? Otherwise,=
 I
> > > don't think it will be used by the kernel build.
>
> D'oh!
>
> >
> > argh.
> > Let's do this patch as-is and another patch to update everything
> > in tools/../btf_ids.h, since it got out of sync quite a bit.
>
> I think I can do both in a v3? I don't see the issue (in mainline, are
> they out of sync in -next?)

Yes. Pls send v3 with two patches.
We'll apply and flush bpf trees, so both will have all fixes in a day or so=
.

