Return-Path: <bpf+bounces-44219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505D89C0156
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 10:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 675FAB22276
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 09:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578591E1C37;
	Thu,  7 Nov 2024 09:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNBcltbY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF23126C01;
	Thu,  7 Nov 2024 09:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730972527; cv=none; b=lllUrq0iNhqMp8VCRAMYa0qOQKkgBrf3Ru6EG/cE/wuZV4sP/UGRVBESltSZtu9ldbAB6tNSDl2qdDQ6DveeuTw+rjoQy69MiA5K3xtVTLJlKWtWnw1Hx5ttPUH6KlJAizEhDiEuIhjMNOx1Vh4pKsNm7VyKrR3Lyx/X7nKqWbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730972527; c=relaxed/simple;
	bh=6rCfQjYqKedxRoDt5Nu+GGmE+Ps1PathpCfylFya1ns=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwsjFLWXPihTJopc+L0kD3iYrFwhWRPMJ3XXAqI3/arNn3jU0pK0QEWgVJBd3foeNjxRo5e5wdnQg2qOYKktj+81Gp7NBvDV79uJ8fxE4/rkXaIC5btUfXLFdvCZVECAD5KOrOQ5v2x26cAEQsGRlL+ZatEq1Q0hv08VCNpRejg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNBcltbY; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53b13ea6b78so961321e87.2;
        Thu, 07 Nov 2024 01:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730972524; x=1731577324; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cb032bMxCB2+U/0i/l2uSww85w5ZIQiK34d0j8RbCUM=;
        b=fNBcltbY4kDNmswkpGmqPT91RadjLlwcKkqpJIQ3vZQbqsHjo68Bl9pTScJc6gJ8/N
         VurEEVC69PIQWg8Vq9NzS4vZdkbE1ccr+Apq1OclSp8RoX16KXcepamCqVPfb05FfYX1
         YThSQmvEGkxnApBZ1MqWNDc0Pt0C4+1fQ+uPXPVCAUZKdMf7BSqcD9NAUCaeX5S9ZID3
         0C9tCkrpYeL3f9rFMoPyF/Q6kmbHyooaXxIz8CgqJJY3rTllKNaGjw6611KfaMJNXCee
         PiQ7eUrdHJ0ONJ+BMQT93KeFujVWicavinJ7pDkHVXHxb0ihGgMK+mGSPUz3bByHIjbM
         ui+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730972524; x=1731577324;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cb032bMxCB2+U/0i/l2uSww85w5ZIQiK34d0j8RbCUM=;
        b=FFyrfrIvqhLdbWxda/ZVJH1baKjELxgWmbvBTOY+bhNyR6g7WjOi/6xc4QGIBSsHZ1
         mDJphAvDdfy6U+JIpLsFJCa9V35x9+wnJj5ZEEM1StV/2uITbtuFeKFigIe1ctjVExEo
         aQcazCZFdGGo+SBUp1nw+pZ6AyoCf9XOKm/VggASVkQA8wJu+IbsarrxjHymd5hQ2dE0
         RQaSpS6kXmpNDVgLMZnR4tiPrxzzJ/KFRQfwKlUmMtkEWdbug2ofqWK4344bZUQl/d73
         VvIZ0O5zWopCZxhX9ek3bXtPpUfR8owx7DuVYLJgFHbI6EgwmshyIYulF+2r2aJCFxnM
         6iFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR8Iu303S2TVTFuITCUyzS3tBGxnuKyqa4yQLdw/EG5BXsIdgVnj7Kn+xnkklAIdPr9Vkox3ywh9SenCIp56jdYg==@vger.kernel.org, AJvYcCWCVJvdleKb5fVmF9aXQpAw0G1yLVZTEQYSvcVMmv2XHSD2t8ulBK9VQYPXSTBFutdMlYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiKfpTR6R1MrxoT548QV++Imhee+qgYfU23mdyf254JSNOD3kn
	cuh78ixLtX30hlTaWqXxKV/Gwo2V0MPnGcNLyyxJ3ImNyzcBzH+pxcVhIw==
X-Google-Smtp-Source: AGHT+IE3UvgBbetOwUqCCtrQ8FSFsJ6GnQCGXbM/x6ClL3eoM4FpQvpjGrgJAM/kpcHBe+EhaBhErg==
X-Received: by 2002:a05:6512:3b86:b0:536:55cc:963e with SMTP id 2adb3069b0e04-53d65e0b43fmr18656955e87.44.1730972523756;
        Thu, 07 Nov 2024 01:42:03 -0800 (PST)
Received: from krava (85-193-35-145.rib.o2.cz. [85.193.35.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a176e1sm69539366b.31.2024.11.07.01.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 01:42:03 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 7 Nov 2024 10:42:01 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Peter Zijlstra <peterz@infradead.org>, Sean Young <sean@mess.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix uprobe consumer test (again)
Message-ID: <ZyyLaWxHbWW87IG-@krava>
References: <20241106224025.3708580-1-jolsa@kernel.org>
 <CAEf4BzZ9wd4ZRGk=Gp3dXOVC5W2=ap90FcQaa9XmAmhY-4CCvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ9wd4ZRGk=Gp3dXOVC5W2=ap90FcQaa9XmAmhY-4CCvw@mail.gmail.com>

On Wed, Nov 06, 2024 at 04:26:11PM -0800, Andrii Nakryiko wrote:
> On Wed, Nov 6, 2024 at 2:40 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > The new uprobe changes bring bit some new behaviour that we need
> 
> needs some proofreading, not sure what you were trying to say
> 
> > to reflect in the consumer test.
> >
> > There's special case when we have one of the existing uretprobes removed
> 
> see below, I don't like how special that case seems. It's actually not
> that special, we just have a rule under which uretprobe instance
> survives before->after transition, and we can express that pretty
> clearly and explicitly.
> 
> pw-bot: cr
> 
> > and at the same time we're adding the other uretprobe. In this case we get
> > hit on the new uretprobe consumer only if there was already another uprobe
> > existing so the uprobe object stayed valid for uprobe return instance.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  .../selftests/bpf/prog_tests/uprobe_multi_test.c    | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > index 619b31cd24a1..545b91385749 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > @@ -873,10 +873,21 @@ static int consumer_test(struct uprobe_multi_consumers *skel,
> >                          * which means one of the 'return' uprobes was alive when probe was hit:
> >                          *
> >                          *   idxs: 2/3 uprobe return in 'installed' mask
> > +                        *
> > +                        * There's special case when we have one of the existing uretprobes removed
> > +                        * and at the same time we're adding the other uretprobe. In this case we get
> > +                        * hit on the new uretprobe consumer only if there was already another uprobe
> > +                        * existing so the uprobe object stayed valid for uprobe return instance.
> >                          */
> >                         unsigned long had_uretprobes  = before & 0b1100; /* is uretprobe installed */
> > +                       unsigned long b = before >> 2, a = after >> 2;
> > +                       bool hit = true;
> > +
> > +                       /* Match for following a/b cases: 01/10 10/01 */
> > +                       if ((a ^ b) == 0b11)
> > +                               hit = before & 0b11;
> >
> > -                       if (had_uretprobes && test_bit(idx, after))
> > +                       if (hit && had_uretprobes && test_bit(idx, after))
> 
> I found these changes very hard to reason about (not because of bit
> manipulations, but due to very specific 01/10 requirement, which seems
> too specific). So I came up with this:
> 
>     bool uret_stays = before & after & 0b1100;
>     bool uret_survives = (before & 0b1100) && (after & 0b1100) &&
> (before & 0b0011);
> 
>     if ((uret_stays || uret_survives) && test_bit(idx, after))
>         val++;
> 
> The idea being that uretprobe under test either stayed from before to
> after (uret_stays + test_bit) or uretprobe instance survived and we
> have uretprobe active in after (uret_survives + test_bit).
> 
> uret_survives just states that uretprobe survives if there are *any*
> uretprobes both before and after (overlapping or not, doesn't matter)
> and uprobe was attached before.
> 
> Does it make sense? Can you incorporate that into v2, if you agree?

ok, seems easier.. will send v2

thanks,
jirka

