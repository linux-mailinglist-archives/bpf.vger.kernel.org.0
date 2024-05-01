Return-Path: <bpf+bounces-28325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A618B8732
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 11:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A7E41F24236
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 09:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B73851C30;
	Wed,  1 May 2024 09:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjUdLsOI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DCF4F881
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 09:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714554326; cv=none; b=F5+ptao8hk8D+07jwV/oACUCy3EfG3CN5bh3q9d7SjgOfGd9xPFZyLTGp/n2AZceFvpg06z8Q3fETmTGlhv3te9da0cLdTQrpgf0EMFccQJydZkeGrVfDdZYI+IrAL8bRlT7HHBn0+s2Yfozb69eOhkxkcEUM1x4IYGFj/v8Y0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714554326; c=relaxed/simple;
	bh=ysCso4Le5ojZO0tenMrHBgCHHTOjjvz4U93v2rhMHlI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tltHInYyvfC+WF/2Q1HwfsU11DhwtRZ3tUrJkeNr5K1V9VEeOrLLujS9Ci6uQzVl5nhwwsRs5YlKZFizwecZBjl40w/BoeDyohOMjuTuK6EIsqqwfLvSki7fQevixQXYSpvAEUGLuXBbuBOmSU3jphd9mA1+GBRuQgYInxTk4kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjUdLsOI; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4196c62bb4eso48928045e9.2
        for <bpf@vger.kernel.org>; Wed, 01 May 2024 02:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714554322; x=1715159122; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9SdXqfogTIv1Tm7xTOfXrF1c5gQ9jafBYwCSLzvbrTc=;
        b=gjUdLsOI4KEwfpndPd5gjuwk1spC6NjPhtC/zs8aWLWjFDukvIF9pPPLaXdcCj2BwS
         zum5l5HKg7KQfcV5faNL4DoDi8I7tKxc9mk9WwAQwo4VMt3h0f3f03TwZRr0DRIWPk6o
         yTUDEPHeJhTKJN9Om8csoSr78IafxCMKOXuCYh37p0T+zpYg44wTGgwu/XE72K7gxFeW
         cmRdhaqffNTahLyYsBIDLi256ABvQHX2nblWyVXQBS1Avoc986WFhnE41R71T/eRHU6f
         F5RkW9/yeWsQvicExrRGtZYvH9P+vK6ePPPyNF/1AbdjvlN3wyNerPfwA2g7M6doI07M
         3Iug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714554322; x=1715159122;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9SdXqfogTIv1Tm7xTOfXrF1c5gQ9jafBYwCSLzvbrTc=;
        b=Mh570x8riNIXAFCpAALJWjFtVWPkpS9+sQ0N17oIDoY/mNGxLfxh/3tfgKhznMaeY/
         zT0guVT+glvkTSbui76to31J5V/rAW0InhwlRtKqi5fpaUQBbxhXTep+vLDASmkmFM7Q
         OdcpoQeF47Xjvpj7m/JdWZLjn3fgVyXhrIwNQxDunCYOvDH31o7hg2I/g+22zMOT64tW
         EzEHuCTSXW9H6TRlD7bzYe+azDDr+y1WIuLvrEIHz8eyb/BEkfEMKPRs06m/VzoGZyaH
         7anafUEU/Iw2TLT+VtxY60jWxqjJ3oxr+d/cREEnXS4qGY7iUbyaSLxJOHTTt2qiLHs8
         Cz3w==
X-Forwarded-Encrypted: i=1; AJvYcCVBCb9qDB0rZf262e3LqNvnG6/rSo/LTygyZBIR7tdyEWn3LKNylwmIr4DLsrPJYoSfLf6E9Sif65hvDrnI68i/AF+o
X-Gm-Message-State: AOJu0YwnqJQbUdzadWKq6EqWR/7KSAcB2dRSFUNKz34v5X+8T876hR7P
	kcTXb4Ywgkr9nyPv1d7aRCNuU7OcpuTmzjJUXVx3GiThzFDFrRR6
X-Google-Smtp-Source: AGHT+IEML4MBhIeUZhdPglngokGjHV8jIIA6Z1iDvT/AV+FOotJ8EMhRnrJXFy7bqAsVO8cw3JcavA==
X-Received: by 2002:a05:600c:19c9:b0:41b:f116:8c1f with SMTP id u9-20020a05600c19c900b0041bf1168c1fmr1380490wmq.29.1714554321931;
        Wed, 01 May 2024 02:05:21 -0700 (PDT)
Received: from krava ([2a00:102a:401c:c46d:8dc4:e2a9:154b:c287])
        by smtp.gmail.com with ESMTPSA id d1-20020a05600c34c100b0041c130520f3sm1573210wmq.6.2024.05.01.02.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 02:05:21 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 1 May 2024 11:05:18 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Viktor Malik <vmalik@redhat.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: [PATCHv2 bpf-next 6/7] selftests/bpf: Add kprobe session test
Message-ID: <ZjIFzmmj_e1PzS5x@krava>
References: <20240430112830.1184228-1-jolsa@kernel.org>
 <20240430112830.1184228-7-jolsa@kernel.org>
 <CAEf4BzYiBDDEPjAbW+anv8uoAdwjyUrOAeFeEXKXSBj_0wOTqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYiBDDEPjAbW+anv8uoAdwjyUrOAeFeEXKXSBj_0wOTqQ@mail.gmail.com>

On Tue, Apr 30, 2024 at 10:29:05AM -0700, Andrii Nakryiko wrote:
> On Tue, Apr 30, 2024 at 4:29 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding kprobe session test and testing that the entry program
> > return value controls execution of the return probe program.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/bpf_kfuncs.h      |  2 +
> >  .../bpf/prog_tests/kprobe_multi_test.c        | 39 ++++++++++
> >  .../bpf/progs/kprobe_multi_session.c          | 78 +++++++++++++++++++
> >  3 files changed, 119 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_session.c
> >
> 
> Given the things I mentioned below were the only "problems" I found, I
> applied the patch and fixed those issues up while applying. Thanks a
> lot for working on this! Excited about this feature, it's been asked
> by our internal customers for a while as well. Looking forward to
> uprobe session program type!

great, I'll send it soon

> 
> > diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
> > index 14ebe7d9e1a3..180030b5d828 100644
> > --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
> > +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
> > @@ -75,4 +75,6 @@ extern void bpf_key_put(struct bpf_key *key) __ksym;
> >  extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
> >                                       struct bpf_dynptr *sig_ptr,
> >                                       struct bpf_key *trusted_keyring) __ksym;
> > +
> > +extern bool bpf_session_is_return(void) __ksym;
> 
> should be __weak, always make it __weak. vmlinux.h with kfuncs is coming
> 
> same for another kfunc in next patch

ok

> 
> >  #endif
> 
> [...]
> 
> > +static const void *kfuncs[8] = {
> > +       &bpf_fentry_test1,
> > +       &bpf_fentry_test2,
> > +       &bpf_fentry_test3,
> > +       &bpf_fentry_test4,
> > +       &bpf_fentry_test5,
> > +       &bpf_fentry_test6,
> > +       &bpf_fentry_test7,
> > +       &bpf_fentry_test8,
> > +};
> > +
> 
> this is not supposed to work :) I don't think libbpf support this kind
> of relocations in data section.

aah, nice ;-) should we make it work (or make sure it works) ? seems useful

> 
> The only reason it works in practice is because compiler completely
> inlines access to this array and so code just has unrolled loop
> (thanks to "static const" and -O2).
> 
> This is a bit fragile, though. It might keep working, of course
> (though I'm not sure if -O1 would still work), but I'd feel a bit more
> comfortable if you define and initialize this array inside the
> function (then it will be guaranteed to work with libbpf logic)

thanks,
jirka

