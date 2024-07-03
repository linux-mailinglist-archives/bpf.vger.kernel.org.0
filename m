Return-Path: <bpf+bounces-33789-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8076C926704
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 19:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3C131C22318
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 17:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288FF185084;
	Wed,  3 Jul 2024 17:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIyLaSsc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FFF1849C3;
	Wed,  3 Jul 2024 17:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720027434; cv=none; b=H0YKhEd/KW4IdQLs0YAxsRwcmoU2zUF7gFe2X0w8+DIjQ4PzTAtbug74RjiyQ0FKrL/h+evk5yCVtS3CQIGmJaaxg9AqUAekONNaoyVWkzem0QMm1r53/MziT4Ks7RUad6BMn8AbVx6grdSJu9EySz3XTOOtUlUxfS4PSB5XiHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720027434; c=relaxed/simple;
	bh=z67pOF54298L0LiTmDmYaTs/VX1vfsc0xJhQPZ9JdJg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kbodpq7azPviL6u972bYgaVHSBgio4gUI53ytdI8P1ouZpdRZ1jfs2ukz/Cd9h5vxz0SesYHgZGp7H9Rp9xeLOeVgwee50N8l2481bEnxe1HWrHW6BblwtwpnAkPitIDGs+EDAsJIO+CzqhGIY1cMa2kCmEVufEjR7thJlot1Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIyLaSsc; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a724598cfe3so698018266b.1;
        Wed, 03 Jul 2024 10:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720027431; x=1720632231; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0yydqW0pEiTRrPXeTkUJn0GQeIWHeWEWO75cCPWOmNY=;
        b=HIyLaSsc/8S0A4uQ9TcnmSxsCpPlm7UsnEayt3Vr67+SpDf0FqLlMgeOJOe/WWTC/2
         aJSvt3l+cMKUmo0JKovT6brEbI7+oPc3JrXsoQCU7tBNWjbHCMd51TGQCsNzntpvPaoC
         7HuA1uj8Txm2pva5pH9W6c8k5ixnkcXVrDL4rDk4TkYIpdeUWYdA9QZmkb/kQmJY9SED
         SxiJjtGvo3iOYMJXy3sCgSAXr1d0TXqKlX7wqH3mRJWWx6Ymxce/djqqM4P84CV2r3us
         mSdP/8LUl3b7JSWSL416NWTVNA45tLfmqgfRYiecNymjVgOxGwMsSP0tGeSDado7JfkT
         CMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720027431; x=1720632231;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0yydqW0pEiTRrPXeTkUJn0GQeIWHeWEWO75cCPWOmNY=;
        b=s3/Ff37m+qwF0s4iqIN8NjuzfkGZIp8On+AL3t50BgcSUMiTH4tqMqwVRUGhonBRqM
         nU7LWxrBFMPXIMyEff0iXq3uCFhmFjF3VGcxIlBGLIxvGAPaj+FZFUeuTiZPk0A3JmI1
         6dCrQQKMWemmcf2ihW7DC7V+Ka7hbFkRkIDfMVB2OLAyWN6+6qkOH2ItMtJOC3EkUF4w
         biO9o4wOcCOdASLgdL38UQAKLeDQmW67V0F+N0A6N0akgFVkmUdtmrP6hUIzUmIC6bMF
         +j1q37XHRVMENjxzVE+YKeDrecgYSWGx5i4j2wXCmwviIUriytWOXqqRWGPy2K7YsAcl
         1K0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7FR4zK3C6dDmc4yO6+DCUi2i4/EOdW/RDsNPH+sns3pk2gECYnZCRUKUTX5zHupYES74w8P1ZkIyoC4Zny0iXPIMdwyf6GaavMReyg+6OLvADilSymDGJD2tDNXMP4uucyavXU1AlyVH/5Opmvhr9ng7u3R8G3OYyPZL+RihRirQDW3pG
X-Gm-Message-State: AOJu0YymUPot0MjUWYFKg5xvFfQOXgs2Hge1EWx/hFEQ8cM8Y0kLnC3h
	upIwl28x3gCqJs642upkF2oNXSZLRvyy3Vwl5Kzld1A0NBukoi4u
X-Google-Smtp-Source: AGHT+IGUvGNq+Sz+kFZMMyBKyjPhcOdVU6Um6y2Uyc9CbZDox0PUbeXGHKqoO4cqonps8AAl8uEA/g==
X-Received: by 2002:a17:906:360c:b0:a72:a206:ddc2 with SMTP id a640c23a62f3a-a751449ef55mr722801666b.36.1720027431258;
        Wed, 03 Jul 2024 10:23:51 -0700 (PDT)
Received: from krava (37-188-178-233.red.o2.cz. [37.188.178.233])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7400456582sm427829466b.153.2024.07.03.10.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 10:23:51 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 3 Jul 2024 19:22:21 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv2 bpf-next 9/9] selftests/bpf: Add uprobe session
 consumers test
Message-ID: <ZoWIzZzZaqNR6dLm@krava>
References: <20240701164115.723677-1-jolsa@kernel.org>
 <20240701164115.723677-10-jolsa@kernel.org>
 <CAEf4BzYzpyZL+hQogXp-BaWEu6CFvWyicCOnGUxJawMpErLWRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYzpyZL+hQogXp-BaWEu6CFvWyicCOnGUxJawMpErLWRQ@mail.gmail.com>

On Tue, Jul 02, 2024 at 03:10:55PM -0700, Andrii Nakryiko wrote:
> On Mon, Jul 1, 2024 at 9:44 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding test that attached/detaches multiple consumers on
> > single uprobe and verifies all were hit as expected.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  .../bpf/prog_tests/uprobe_multi_test.c        | 203 ++++++++++++++++++
> >  .../progs/uprobe_multi_session_consumers.c    |  53 +++++
> >  2 files changed, 256 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session_consumers.c
> >
> 
> This is clever, though bit notation obscures the meaning of the code a
> bit. But thanks for the long comment explaining the overall idea.
> 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > index b521590fdbb9..83eac954cf00 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > @@ -9,6 +9,7 @@
> >  #include "uprobe_multi_session.skel.h"
> >  #include "uprobe_multi_session_cookie.skel.h"
> >  #include "uprobe_multi_session_recursive.skel.h"
> > +#include "uprobe_multi_session_consumers.skel.h"
> >  #include "bpf/libbpf_internal.h"
> >  #include "testing_helpers.h"
> >  #include "../sdt.h"
> > @@ -739,6 +740,206 @@ static void test_session_recursive_skel_api(void)
> >         uprobe_multi_session_recursive__destroy(skel);
> >  }
> >
> > +static int uprobe_attach(struct uprobe_multi_session_consumers *skel, int bit)
> > +{
> > +       struct bpf_program **prog = &skel->progs.uprobe_0 + bit;
> > +       struct bpf_link **link = &skel->links.uprobe_0 + bit;
> > +       LIBBPF_OPTS(bpf_uprobe_multi_opts, opts);
> > +
> > +       /*
> > +        * bit: 0,1 uprobe session
> > +        * bit: 2,3 uprobe entry
> > +        * bit: 4,5 uprobe return
> > +        */
> > +       opts.session = bit < 2;
> > +       opts.retprobe = bit == 4 || bit == 5;
> > +
> > +       *link = bpf_program__attach_uprobe_multi(*prog, 0, "/proc/self/exe",
> > +                                                "uprobe_session_consumer_test",
> > +                                                &opts);
> > +       if (!ASSERT_OK_PTR(*link, "bpf_program__attach_uprobe_multi"))
> > +               return -1;
> > +       return 0;
> > +}
> > +
> > +static void uprobe_detach(struct uprobe_multi_session_consumers *skel, int bit)
> > +{
> > +       struct bpf_link **link = &skel->links.uprobe_0 + bit;
> 
> ok, this is nasty, no one guarantees this should keep working,
> explicit switch would be preferable

I see, ok, will replace that with a switch

> 
> > +
> > +       bpf_link__destroy(*link);
> > +       *link = NULL;
> > +}
> > +
> > +static bool test_bit(int bit, unsigned long val)
> > +{
> > +       return val & (1 << bit);
> > +}
> > +
> > +noinline int
> > +uprobe_session_consumer_test(struct uprobe_multi_session_consumers *skel,
> > +                            unsigned long before, unsigned long after)
> > +{
> > +       int bit;
> > +
> > +       /* detach uprobe for each unset bit in 'before' state ... */
> > +       for (bit = 0; bit < 6; bit++) {
> 
> Does "bit" correspond to the uprobe_X program? Maybe call it an uprobe
> index or something, if that's the case? bits are just representations,
> but semantically meaningful is identifier of an uprobe program, right?

right.. so it corresponds to program 'uprobe_<bit>' so maybe 'idx' is better

thanks,
jirka

