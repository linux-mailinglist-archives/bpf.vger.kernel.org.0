Return-Path: <bpf+bounces-48309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F219EA06873
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 23:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4C71164059
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 22:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D140204681;
	Wed,  8 Jan 2025 22:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TN2UdWA3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F73C1A0706
	for <bpf@vger.kernel.org>; Wed,  8 Jan 2025 22:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736375925; cv=none; b=bqSGbO+YMGpw0K5NvFpdnqtHO+o9KdzArcklXNljx9TR7pnwrcsxi6oyQgUwyHTOj1IfJ9+WiMhX9YsK2PisQifYsnx7rNuDehWrJaMmaBSj9VooYYjjDWrxLZIr94FJU8U+VEP7sRfveQ2QCEXgifDZXMTNvoYMddDSgrMDNqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736375925; c=relaxed/simple;
	bh=gS7Uivd96uflEnERoT9kG2hYXaPQmpDNaBiG2E1nbRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tkxqRpPWhF8ktWHpdRH/ye/52EgMC+YBUcGpRDsWST5m+zPwY6zTVnvz8d08WUNBvYY0L1dEWB0XyJWNc9O42KB8pj0lQVnCR/GhxgxvOLqKGeC47/x4D7Arh0F/RorilnGc8IBFIJc72UKrsG100ucFALVUO1s9Dm5MAUYUeoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TN2UdWA3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2161eb95317so3519045ad.1
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2025 14:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736375924; x=1736980724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8/8zD7wOJR6mRCvKckDccAwos908RzWAF5dppJxN/Q=;
        b=TN2UdWA3Gp54lSrCbjGGjUgSUgYbH2N2nu3ARO5v2dWEjIAfJNyrM7cfbwVctdnyDJ
         FbPTq1Jn4n/i8yDd3m5JXrRecYW+Fhrag4Vi75xXTrs8ueyupSo/xU+L79FU0MOTCAi+
         Z8w14M1g0pVtLPeThLggGVZWdVlCm178pv9oDrjF6cNMPNeq81MJq8WVt1rHSNnwXyON
         AjpnAbrAwlnsUga1D6Lr/PlSQ6do7KnS8DVmd7VeDMA6wRHi0dYdGvPRyMIMiXeG8InM
         0LTXssa7th6d2kyNPeP4jP5NdgXY24DucZ4BRnHQO7qmy6EoLOjmk8V9MuJtg4T+hDdB
         8LcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736375924; x=1736980724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H8/8zD7wOJR6mRCvKckDccAwos908RzWAF5dppJxN/Q=;
        b=QobyP5lzmbN/5cOmfMhP4GaUL5aMa5ctNXR71KFQGPR5RGXnnYI6XUWJUVVs9TSjUG
         nCpd3NJdvYJDsocM+WZVl8REx2hZhENhSRE8PTx1rbyv8qRPQ+ZzYPDYGtODuFKWHe/4
         di33BYLfn3xRfXBkhixk86n+KWBJvBy95tXmOJug5GGAtTfsm5VdoWOfqlEcp02yXZVA
         5/heQNd1bzj5lZsUhXQhQMkt8p6+XPJtNzWXL1KBqSht6DTP/nxQayFUYTLh5RxprNnT
         L9wO3q0tPCynnnWK9MyXAZIodZjK9QIreqGW3xqZ9fP48mWDmwjQsMgTLD4Mqvkhfn4N
         cmog==
X-Gm-Message-State: AOJu0YyrTfN1EnLvBEGo/G4opvxCpKOzF0MSaK8LmTIsVD93zNEGlijP
	M+p7la6pBPNVL1aGKGAd98hxHBdeLGDf/RdTlcISJCQH806zh/y2RpFwKQgHWpxzqRBLzmJwEV8
	qUNKdU1twPBoNYLhmgk7qnJwxgFY=
X-Gm-Gg: ASbGncv/adFyVbG/pEE/ZyxpiaN7ufjDuhOhRw1RlHIDadOdiVKvW82NsN7YtePUYCx
	xwXV+ptT4JIv2cJYOO+Kdlk6O9LSAndE1FiMkzyFofsSZOGXAYhhJmg==
X-Google-Smtp-Source: AGHT+IEtdl8ELQ9iPdEXVRtl0gdeL5nBxLjSCcknjuM5bQCUlmy7Oo7IURvsUrpO++cnDewTBj2/sScfebA4mAgdniA=
X-Received: by 2002:a05:6a20:7284:b0:1e0:eb49:b81b with SMTP id
 adf61e73a8af0-1e88d09c97emr7757563637.31.1736375923583; Wed, 08 Jan 2025
 14:38:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218225246.3170300-1-yonghong.song@linux.dev>
 <CAEf4BzaJ3cF+StkPoANKDY3q-5Y-vuvEpcWVTq0zvom1mmFbaw@mail.gmail.com> <fcb4cbb5-d9b7-47fb-b300-e2227223e882@linux.dev>
In-Reply-To: <fcb4cbb5-d9b7-47fb-b300-e2227223e882@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 8 Jan 2025 14:38:31 -0800
X-Gm-Features: AbW1kvbYP1ubsgUqInSUfAuzvzJQC-m0sC8070UWuuz-6TI7TJDzvZMXbWoygTE
Message-ID: <CAEf4BzagphW_zikH_W7wVoZB_omMM4L7uMaLH+hCRx1BiQCC4g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: Add unique_match option for multi kprobe
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Jordan Rome <linux@jordanrome.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 10:29=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
>
> On 1/6/25 4:24 PM, Andrii Nakryiko wrote:
> > On Wed, Dec 18, 2024 at 2:53=E2=80=AFPM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> >> Jordan reported an issue in Meta production environment where func
> >> try_to_wake_up() is renamed to try_to_wake_up.llvm.<hash>() by clang
> >> compiler at lto mode. The original 'kprobe/try_to_wake_up' does not
> >> work any more since try_to_wake_up() does not match the actual func
> >> name in /proc/kallsyms.
> >>
> >> There are a couple of ways to resolve this issue. For example, in
> >> attach_kprobe(), we could do lookup in /proc/kallsyms so try_to_wake_u=
p()
> >> can be replaced by try_to_wake_up.llvm.<hach>(). Or we can force users
> >> to use bpf_program__attach_kprobe() where they need to lookup
> >> /proc/kallsyms to find out try_to_wake_up.llvm.<hach>(). But these two
> >> approaches requires extra work by either libbpf or user.
> >>
> >> Luckily, suggested by Andrii, multi kprobe already supports wildcard (=
'*')
> >> for symbol matching. In the above example, 'try_to_wake_up*' can match
> >> to try_to_wake_up() or try_to_wake_up.llvm.<hash>() and this allows
> >> bpf prog works for different kernels as some kernels may have
> >> try_to_wake_up() and some others may have try_to_wake_up.llvm.<hash>()=
.
> >>
> >> The original intention is to kprobe try_to_wake_up() only, so an optio=
nal
> >> field unique_match is added to struct bpf_kprobe_multi_opts. If the
> >> field is set to true, the number of matched functions must be one.
> >> Otherwise, the attachment will fail. In the above case, multi kprobe
> >> with 'try_to_wake_up*' and unique_match preserves user functionality.
> >>
> >> Reported-by: Jordan Rome <linux@jordanrome.com>
> >> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> >> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> >> ---
> >>   tools/lib/bpf/libbpf.c | 10 +++++++++-
> >>   tools/lib/bpf/libbpf.h |  4 +++-
> >>   2 files changed, 12 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >> index 66173ddb5a2d..649c6e92972a 100644
> >> --- a/tools/lib/bpf/libbpf.c
> >> +++ b/tools/lib/bpf/libbpf.c
> >> @@ -11522,7 +11522,7 @@ bpf_program__attach_kprobe_multi_opts(const st=
ruct bpf_program *prog,
> >>          struct bpf_link *link =3D NULL;
> >>          const unsigned long *addrs;
> >>          int err, link_fd, prog_fd;
> >> -       bool retprobe, session;
> >> +       bool retprobe, session, unique_match;
> >>          const __u64 *cookies;
> >>          const char **syms;
> >>          size_t cnt;
> >> @@ -11558,6 +11558,14 @@ bpf_program__attach_kprobe_multi_opts(const s=
truct bpf_program *prog,
> >>                          err =3D libbpf_available_kallsyms_parse(&res)=
;
> >>                  if (err)
> >>                          goto error;
> >> +
> >> +               unique_match =3D OPTS_GET(opts, unique_match, false);
> >> +               if (unique_match && res.cnt !=3D 1) {
> >> +                       pr_warn("prog '%s': failed to find unique matc=
h: cnt %lu\n",
> >> +                               prog->name, res.cnt);
> >> +                       return libbpf_err_ptr(-EINVAL);
> > goto error, leaking resources here
>
> Ack. Will fix.
>
> >
> >
> > we should also think about interaction of unique_match interaction for
> > !pattern case, and either reject it (if it makes no sense), or enforce
> > it (if it does, I haven't really thought about which case do we have)
>
> The unique_match only makes sense for pattern case. So I suggest to
> reject the case unique_match && !pattern. WDYT?
>

Yep, let's reject (we could make it behave well, just making sure that
cnt =3D=3D 1 if unique_match =3D=3D true, but why bother, it's not intended=
 to
be used together).

> >
> > pw-bot: cr
> >
> >> +               }
> >> +
> >>                  addrs =3D res.addrs;
> >>                  cnt =3D res.cnt;
> >>          }
> >> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> >> index d45807103565..3020ee45303a 100644
> >> --- a/tools/lib/bpf/libbpf.h
> >> +++ b/tools/lib/bpf/libbpf.h
> >> @@ -552,10 +552,12 @@ struct bpf_kprobe_multi_opts {
> >>          bool retprobe;
> >>          /* create session kprobes */
> >>          bool session;
> >> +       /* enforce unique match */
> >> +       bool unique_match;
> >>          size_t :0;
> >>   };
> >>
> >> -#define bpf_kprobe_multi_opts__last_field session
> >> +#define bpf_kprobe_multi_opts__last_field unique_match
> >>
> >>   LIBBPF_API struct bpf_link *
> >>   bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog=
,
> >> --
> >> 2.43.5
> >>
>

