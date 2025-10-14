Return-Path: <bpf+bounces-70912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A3ABDA33F
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 17:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 421993562B7
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 15:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874992C029B;
	Tue, 14 Oct 2025 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVv/VASc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D130262A6
	for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 15:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454143; cv=none; b=Zoz0cKdeQcg0rBD7pKIntME/yMkdgnQGLRJqKxLZ4IVGA9etuRgMgq+qszLFCMrPnvtB9vPvVuPVx7cNEm7vRjY4H+I21Ox4Kea75zVu6BhPzLkiTip8ckMj9JAzNdrnkw/JCThsqbLWT3WgY5jEIPcNraaasBJnQjv+MMvhzI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454143; c=relaxed/simple;
	bh=wLBVcnPZguAYTgTwsKiwtS3FxogrqpWpBa8CDXH8zpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kV3i/ljq/28MRUBWDg3qCLJqHwSqxu4lFsetTVlZ64orz2zGFlmTaCnupY2MCAwT/y70bBRhStg1pw0XdoPKRnpTtgE4yMU9BI7jcPLPoKHDNcuGklUj7W95f1shwrcOpYoqctjy6lUpvHiPQBz+vc/GIzg2VnAz5UFgkaGQyMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVv/VASc; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42557c5cedcso2955158f8f.0
        for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 08:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760454139; x=1761058939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Z3LeGxNpykW8QPBBmWGZO+eW3eGppBCAhBgpeK39tg=;
        b=GVv/VAScI0yT7zJtxlMoy7phM4rxnAkX4Y9gZIG90BQ65CNFU8a/j4JEkbCeW7qkem
         U1OCaHVbD6ksOtIyMjZXR3RCBB/P36VVRjkiwO7s3SCIPXcFFQRCOFjcZ8EJkqVt2Gai
         w2GVUahsgg82q0n/d3/9czo0p5qeL6RqX8Ttfg+Ft/Is9xlOvhlU/KjjYflEk5h9dcv4
         jCWTn1Yxf/OHw/GhEK+18EUshxteGoj50rpsYwYyFrzYd18CAlibMllWw/ljXHoBrN7I
         16ZS55xcd678S92ZL87v50g7CY49pc4bf6p4/LnL5KxKqzAr5GqVXsD8eC7DX5O67lNd
         EixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760454139; x=1761058939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Z3LeGxNpykW8QPBBmWGZO+eW3eGppBCAhBgpeK39tg=;
        b=ipwboLCDTVpwI6z5MOQcfp7BLk4wehfWqzpHDt/Mmg+OnHc0XV4Q9YOBiUtjxKuuL3
         ceIA8YiKq0hYQTK9709dgSZp4E9VqvgIrxfogTA1Sr3pj+x2P8LG+uVLnTsSvMQqOXvH
         iM1Bm5sob4U5AMFCEaKR3mBvLT7F5CgFuwdZbq0FH6B70aj3pQZx+rX1vjVE9V49tNTc
         OlNZyTUcLaAwwpiAJPUkW1t2Ze79Bs+MvLMgTLVZuHvoUrFjvi8nAi9Q9gt35wLlHjIb
         UyU2j1rZ32T/LwlI3Xz4m0Kz7gyMbznP27JsIkLqxJ6q4558+7Qj4RO5/01+9Ph+zfTw
         xpBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn7xrVSGjgTfrALGkud0DBanx6rVlHLddzCiIcv8HtoCsW+Yd6u6x7UrpJInib5yFOV7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8sEUYTDXyw8XMqge1zIZ7MZHz8WGOoQ9NE+KI21ljFZ0u53PW
	xD9O0k/0pCe0T4mq3PefxSHP5uwfa0GH+RQrvHrTaKlrsoV2C2MWHx5VSxtXtjNC8EKUeF2h2CK
	9kDeq1JeUi+e5eZF1rPvnzl6bsyI/jZc=
X-Gm-Gg: ASbGncsm4ZFMdYyWgyX54zMkkhm6AVcquI43aLPCzxPsS1pMK4n7cBDA4DSMan0CrZn
	1WryYMGtvfSy8ivLCcxM3LZxyieGCz901aUgKw/pEGC6pGh2rbyXp6A7zdgqwPJp7e8cg2jRTSf
	JlbYyeX4qw/aoLvuLB7d2xsSskiR0wqIuIBhDgnyr962xuNEoMrCrfNm/s5Ct62jfHBJgGPLHVc
	i+XdvKTWXMnrWWqkzoNdkxzYH+HmnhfWvVYEHt10Q==
X-Google-Smtp-Source: AGHT+IFZ4oUDp4AWLyXSPzY6UsUd433FoGP+hnvIbGLoK7umHXXDi0LbPYh5b/NE1SjwjjD79z/uWjqAoIeYogU1rOw=
X-Received: by 2002:a05:6000:22c5:b0:3fd:bf1d:15d1 with SMTP id
 ffacd0b85a97d-4266e8dde71mr15298478f8f.49.1760454139020; Tue, 14 Oct 2025
 08:02:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014100128.2721104-1-chen.dylane@linux.dev>
 <20251014100128.2721104-3-chen.dylane@linux.dev> <aO4-jAA5RIUY2yxc@krava>
In-Reply-To: <aO4-jAA5RIUY2yxc@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 14 Oct 2025 08:02:06 -0700
X-Gm-Features: AS18NWCSgrnY4KPRrkJ5eguwWeliltY9wxstLdBBs-NEBFqW5W6tT8iypfQAxiM
Message-ID: <CAADnVQLoF49pu8CT81FV1ddvysQzvYT4UO1P21fVxnafnO5vrQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 2/2] bpf: Pass external callchain entry to get_perf_callchain
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Tao Chen <chen.dylane@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 5:14=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Tue, Oct 14, 2025 at 06:01:28PM +0800, Tao Chen wrote:
> > As Alexei noted, get_perf_callchain() return values may be reused
> > if a task is preempted after the BPF program enters migrate disable
> > mode. Drawing on the per-cpu design of bpf_perf_callchain_entries,
> > stack-allocated memory of bpf_perf_callchain_entry is used here.
> >
> > Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> > ---
> >  kernel/bpf/stackmap.c | 19 +++++++++++--------
> >  1 file changed, 11 insertions(+), 8 deletions(-)
> >
> > diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> > index 94e46b7f340..acd72c021c0 100644
> > --- a/kernel/bpf/stackmap.c
> > +++ b/kernel/bpf/stackmap.c
> > @@ -31,6 +31,11 @@ struct bpf_stack_map {
> >       struct stack_map_bucket *buckets[] __counted_by(n_buckets);
> >  };
> >
> > +struct bpf_perf_callchain_entry {
> > +     u64 nr;
> > +     u64 ip[PERF_MAX_STACK_DEPTH];
> > +};
> > +
> >  static inline bool stack_map_use_build_id(struct bpf_map *map)
> >  {
> >       return (map->map_flags & BPF_F_STACK_BUILD_ID);
> > @@ -305,6 +310,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs,=
 struct bpf_map *, map,
> >       bool user =3D flags & BPF_F_USER_STACK;
> >       struct perf_callchain_entry *trace;
> >       bool kernel =3D !user;
> > +     struct bpf_perf_callchain_entry entry =3D { 0 };
>
> so IIUC having entries on stack we do not need to do preempt_disable
> you had in the previous version, right?
>
> I saw Andrii's justification to have this on the stack, I think it's
> fine, but does it have to be initialized? it seems that only used
> entries are copied to map

No. We're not adding 1k stack consumption.

pw-bot: cr

