Return-Path: <bpf+bounces-57643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 068A8AADA94
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 10:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCBC5188E87E
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 08:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D184E204097;
	Wed,  7 May 2025 08:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJMZeHPK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B642B193062;
	Wed,  7 May 2025 08:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608201; cv=none; b=h9150QpqXgG0xaJ00wkC+fRDaULqg+ScmN+4SjzPP08LJjQYzIAerE1tlWn8SbQi/XB31bdsFsD4oNPCOs7QETC0Xq45n+0dPk2MMDN0+uMxbIiHHUIxiaR2FmHLw52XBuo6AfQq6+ic1t0Zn+0VD881UadiyThjsR0qF135Mrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608201; c=relaxed/simple;
	bh=YF0XBybdGev5P5laamOGvx0yuMkyeOtbHYbsvXl924w=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkW1WUOzKaUmnVOJH1Gksxh5Q/m1hP4XnwwNdcw5jrNWUURPlHQKZmby33TRaPDcI66xL2i1n6ej4cfip16cSHbUyfuZnMV+HjgOOldqPCWagA9s1brqWSvfmwBEHibxusc4i9fhBG84F/suyJOz19klF0py2sac3HAbrSBrUbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJMZeHPK; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5fbee929e83so678244a12.3;
        Wed, 07 May 2025 01:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746608198; x=1747212998; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RtJrNEhTxPpRyYlS5ximO0nluwO8bWEvvP6btnNB21E=;
        b=JJMZeHPKcibRmqMPIVAh+As1HV8FA7KXR1UslVcLladEtlFxZNjyiYScb8EwdaarzC
         S5GJo7KwXiRUUnaY0HbsI+yfOsxGbQqTYWa0f+dkp85GucaSj+pd7E+s75SJ27zo7zff
         Q/PJgHcseohQ0v8pVf29+aHlnXp6nYAKPTaKSuNqn+v9MK946KwKW/qPEorz620+ALLJ
         8SEHqP05B8KSSpAMl0/Jf/FqA/VyriMUfOO2Wu3e0EgtqneSr+ch6QG7/x2eq2oujAtz
         ZEmORYQ4UyH4/KlNscIoVD9M6BSYKEh709sX9HZV3fwKt5mfzhF6hKV0Q+YwwDDQaxxu
         r/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746608198; x=1747212998;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RtJrNEhTxPpRyYlS5ximO0nluwO8bWEvvP6btnNB21E=;
        b=UYzEU3yE7eQJfcM4eDNaD/8csl+fHqVUDwt9+738pu0TYj24/pyc6mfuogzjDfF/Sa
         n+ib6ZknD3P/yzYje78edhO7p0qL+cnHL3t9LHip9FB52OZB7P6wlcYWr8NuUeje+pNK
         Ko27CtCJM+Slvv626cNctci1x3roWVccFhdgd0u4FKv9WZfrBbQyenl6ckVN+6wCYQxI
         cX60dUO1iWhoOXB0vRTIavMaRSeZS02hQ7UjxCA303tl98RRIjs0LXbbRZ50ms1ghvPM
         l0laf8ZWoIWlJ4sWeor4+O3exCp27RZztkJlLrcw5B64WEHqvSSNohLkzV2aqb6XwAr1
         rgBg==
X-Forwarded-Encrypted: i=1; AJvYcCWH5MJXSkopgdgv8a9OzeCLfApdVoaBqyCmbdwk//UOOsDX2rl/GIDXU6Fyw4JzeH6L1z/dv5dDHGm3wdzy+Mz/Jg==@vger.kernel.org, AJvYcCXGyswD4+eDlZmsKrYPymhTB3epaX3dXFebgSatwbiFNFx9A3HdMtzierWaKUz19VUpO60=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ9CkWLACawDtYkzYoTmPYb89Qaer2QroBmnKbzSPwes2y8tTO
	ybvnQH0HDJGmhSRi8QjljRH3wq8DvHZgK294RtaslfBavd2DN48S
X-Gm-Gg: ASbGnctb2xLTtS8PH0qUfDv6JpwUJusNfDtvv1om7d+lNYzIrc93ZWd4Vg8ugyp8vsj
	pCzafzROpUWJUVLXh01bozT5cuD7p6EX6RTKN8Srefe31t549NNeCN7UnYBk9vTddtz35ukS23g
	eaQioXeUJu9zGxwmGJN+CIshJa1aA8UVLG2a/EAnJYQdwkca/OgJ0L4+tmw9vaQallsxOIBFfZE
	XB1aiHm2JFQbko7zaf+N7l7m38nHxDPiReZ4IYi2gqrAmu9p+8lUlXtMLJMzmEXeOFZWn90IjZ/
	JhLJfKHNs0jxwBdCs/ZRCLiKZNE=
X-Google-Smtp-Source: AGHT+IGkqNN7KP/S/TA1argQXXGqtucTueWdiZvttJsrEcaRwxPxXI3wgtYKoiS0qQb8Z5uO5jIjYA==
X-Received: by 2002:a17:907:2ce6:b0:ac7:b8d0:86c0 with SMTP id a640c23a62f3a-ad1e8b936c7mr252997266b.9.1746608197607;
        Wed, 07 May 2025 01:56:37 -0700 (PDT)
Received: from krava ([173.38.220.40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad189146f61sm866955566b.9.2025.05.07.01.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 01:56:37 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 7 May 2025 10:56:35 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Yafang Shao <laoar.shao@gmail.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH bpf-next 3/3] bpftool: Display ref_ctr_offset for uprobe
 link info
Message-ID: <aBsgQw1kzJsRzM5p@krava>
References: <20250506135727.3977467-1-jolsa@kernel.org>
 <20250506135727.3977467-4-jolsa@kernel.org>
 <CAEf4Bzbpn8kQV8ORoBv7iDR1VxT0uUf=qqjanFQFtFx1fSjrQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzbpn8kQV8ORoBv7iDR1VxT0uUf=qqjanFQFtFx1fSjrQQ@mail.gmail.com>

On Tue, May 06, 2025 at 03:33:33PM -0700, Andrii Nakryiko wrote:
> On Tue, May 6, 2025 at 6:58 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding support to display ref_ctr_offset in link output, like:
> >
> >   # bpftool link
> >   ...
> >   42: perf_event  prog 174
> >           uprobe /proc/self/exe+0x102f13  cookie 3735928559  ref_ctr_offset 50500538
> 
> let's use hex for ref_ctr_offset?

I had that, then I saw cookie was dec ;-) either way is fine for me

> 
> and also, why do we have bpf_cookie and cookie emitted? Are they different?

hum, right.. so there's bpf_cookie retrieval from perf_link through the
task_file iterator:

  cbdaf71f7e65 bpftool: Add bpf_cookie to link output

I guess it was added before we decided to have bpf_link_info.perf_event
interface, which seems easier to me

jirka

> 
> >           bpf_cookie 3735928559
> >           pids test_progs(1820)
> >
> >   # bpftool link -j | jq
> >   [
> >     ...
> >     {
> >       "id": 42,
> >        ...
> >       "ref_ctr_offset": 50500538,
> >     }
> >   ]
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/bpf/bpftool/link.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> > index 52fd2c9fac56..b09aae3a191e 100644
> > --- a/tools/bpf/bpftool/link.c
> > +++ b/tools/bpf/bpftool/link.c
> > @@ -380,6 +380,7 @@ show_perf_event_uprobe_json(struct bpf_link_info *info, json_writer_t *wtr)
> >                            u64_to_ptr(info->perf_event.uprobe.file_name));
> >         jsonw_uint_field(wtr, "offset", info->perf_event.uprobe.offset);
> >         jsonw_uint_field(wtr, "cookie", info->perf_event.uprobe.cookie);
> > +       jsonw_uint_field(wtr, "ref_ctr_offset", info->perf_event.uprobe.ref_ctr_offset);
> >  }
> >
> >  static void
> > @@ -823,6 +824,8 @@ static void show_perf_event_uprobe_plain(struct bpf_link_info *info)
> >         printf("%s+%#x  ", buf, info->perf_event.uprobe.offset);
> >         if (info->perf_event.uprobe.cookie)
> >                 printf("cookie %llu  ", info->perf_event.uprobe.cookie);
> > +       if (info->perf_event.uprobe.ref_ctr_offset)
> > +               printf("ref_ctr_offset %llu  ", info->perf_event.uprobe.ref_ctr_offset);
> >  }
> >
> >  static void show_perf_event_tracepoint_plain(struct bpf_link_info *info)
> > --
> > 2.49.0
> >

