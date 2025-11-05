Return-Path: <bpf+bounces-73578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2D2C34341
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 08:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 211F134C1A2
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 07:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F272D0C61;
	Wed,  5 Nov 2025 07:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaJ6aJ+o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAC12C0F97
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 07:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762327196; cv=none; b=ivmTcYgAf/GNBvYWZWpc7nYrfaEqUjtJ257nzH0R/Gm7EYAzl+6udEfLGoo9M0Rm4AHXY9vNdE2+AAA0PmtCrlEEl3qFgb8wu63/R4sFK9DkQfaMLzgKCtFS1tHTnlGKGS+ApNMT80gmXof88Me/bg0Oq7hAFqVvc3yWyV37sUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762327196; c=relaxed/simple;
	bh=1pQIxX3yK+8rfBnykhFdVclFo+P44lpGQaEv3MoyRtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbyFMmUpcU27Fuv7Z7QxJqtX1iKEVkuQhB8OYAMaPETgmIIOcHuXzCPbnstH3OeObgswuSl7Ft/IDdemZ69ukpnhU/PwWPEg29RWwyaR+k9nhUVhrSVlomEG8PJOPEzcq1wCGyUl+qWb17pQr46vNutG6/k/9rzQjZmx9qWSzTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HaJ6aJ+o; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6409e985505so6095716a12.2
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 23:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762327192; x=1762931992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NpQ4sUrhtspxSzRGtm+kS+yAZk1tIHaT04QvKbBxTMo=;
        b=HaJ6aJ+oid9FyntHDIwqCkwOuQirpShAvAV6hgfRJXoxFSzunRrcmf/rPtUYFKrhUF
         S4T6RkNb70uZbOMeZIr+/0glKCM9SYmloqIoUQQeyphX52fAsXnNSO8QzuCOVV08hfxh
         g8gNRehuf+BmO5Uy+DiWY8ASOpeRjZgFM7HsSayDo1+IshWckRP3FUvAZbB4wmXe6p4j
         q5hzoPL7xJHEGTk16Sx/3u84M+cAnUhXrNBj1THhs/5+c5m6z8rcH1/7gauDtxpzXVdh
         SNkxM/3PCdIGelk+mGSDiBQhvKEOP36eq+SrdpInXhZcwzC6vTxebJO+9pFetWPPab/N
         CKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762327192; x=1762931992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NpQ4sUrhtspxSzRGtm+kS+yAZk1tIHaT04QvKbBxTMo=;
        b=LhvJ5PXopZ+N9trP1LEZ0bNYNSU3xuOMeO/aNenpCeCUb5Qqr1F5KSsMZpjqNQ0PUx
         ET4zq5i4gkNTgVyErygt8GhuyQCnun1RtVuTVGC8fqYHVhOXruxBIqC2bWkjaLLXeU1o
         7bNaYPApAqlHDx/lrwXgeGYnRpr36SIUsEE6KPY8cgc56YmcSX9CB386QChpC+GzvMo+
         gkYfBupfKK5wJQJV/wen3+onvx3Ug3ifwRgXDNMRmPu5DJW4YjG+MzT4Ci3hIG+Q3Zgx
         ldjaHGwjERKSTlWsKeaAxvwqgUC46ZKQU6JzTm79deF9S7q0l0ZmjzFsILgXJiXpbwSC
         xj5w==
X-Gm-Message-State: AOJu0YxPo/tr0C9B/Yc3IpOQ0ZXvmaWzrzoTWuizR77foZtQnzvIB3h3
	d2S/+6ZfZsLHM5Aan3tFKtUmYGGz84U5ppozptBD6F0J0y8qYLnN7I3cJsgRVA==
X-Gm-Gg: ASbGncuVKPuKPwPATbzXrhlaELwOgruFyRjzuLwKi2Fr/wWK2po20yYRlrDoFgGou5T
	KbmyShzk+b/3x810Q64vmYrzIcfe3czAKSiHWPaNG+2MglhWxYQtf3/9uZTEk9b4mrlKnPvPPsi
	gFRW6GqfUdTn24nyCZO3SajZiLkrCaVpaxf6EAMJSJC5PN5K7Q8IDueP7yKHxf6GZ+I/ab4O48V
	pv+qO+TdFbJ8yEjakI3cRmMNO327f8RQqyAVYvJcQfOov75SaM017ojNc8PbwVH0HnuetlUg2Br
	7HQOq6Dajj2dI8GDHe2LVI32tKxdFMnM78GbvRmr9W2Y6+HpRIPzAmAGmSgTDuudH6mAHlApXhG
	+RsBj7OnWS9zvJTRMAiZVQsBBeohI6n3AJzvkjFKW6CerfY26qJFpLUuRubtFPIMB4zfgQllLHa
	mJbid1bQKsdf7nX6GtZlHh
X-Google-Smtp-Source: AGHT+IH7KMFfhDT1gGzkp8h5jxdzHpfZBkC4AsLqf6ObWYqu7cs12RlZJoO91nP5uiHJbnSUaS21sw==
X-Received: by 2002:a17:907:1c8e:b0:b49:2021:793f with SMTP id a640c23a62f3a-b726553bb4amr214575966b.53.1762327192380;
        Tue, 04 Nov 2025 23:19:52 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723f6e2231sm413173166b.34.2025.11.04.23.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 23:19:51 -0800 (PST)
Date: Wed, 5 Nov 2025 07:26:06 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v10 bpf-next 11/11] selftests/bpf: add C-level selftests
 for indirect jumps
Message-ID: <aQr8Dr+yJRlpm3f3@mail.gmail.com>
References: <20251102205722.3266908-1-a.s.protopopov@gmail.com>
 <20251102205722.3266908-12-a.s.protopopov@gmail.com>
 <e72db29a74ce5e7ac43068e6bf8005c7a3c7cfa2.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e72db29a74ce5e7ac43068e6bf8005c7a3c7cfa2.camel@gmail.com>

On 25/11/03 12:45PM, Eduard Zingerman wrote:
> On Sun, 2025-11-02 at 20:57 +0000, Anton Protopopov wrote:
> 
> [...]
> 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
> > new file mode 100644
> > index 000000000000..2a55fa91e1fa
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
> > @@ -0,0 +1,272 @@
> 
> [...]
> 
> > +static void check_simple_fentry(struct bpf_gotox *skel,
> > +				struct bpf_program *prog,
> > +				__u64 ctx_in,
> > +				__u64 expected)
> > +{
> > +	skel->bss->in_user = ctx_in;
> > +	skel->bss->ret_user = 0;
> > +
> > +	/* trigger */
> > +	usleep(1);
> > +
> > +	if (!ASSERT_EQ(skel->bss->ret_user, expected, "skel->bss->ret_user"))
> > +		return;
> > +}
> 
> [...]
> 
> > +static void check_other_sec(struct bpf_gotox *skel)
> > +{
> > +	__u64 in[]   = {0, 1, 2, 3, 4,  5, 77};
> > +	__u64 out[]  = {2, 3, 4, 5, 7, 19, 19};
> > +	int i;
> > +
> > +	bpf_program__attach(skel->progs.simple_test_other_sec);
> > +	for (i = 0; i < ARRAY_SIZE(in); i++)
> > +		check_simple_fentry(skel, skel->progs.simple_test_other_sec, in[i], out[i]);
> > +}
> 
> The above means that fentry programs are accumulated for 'sys_nanosleep', right? 
> In all 3 test cases that use check_simple_fentry() the identical 'out'
> values are used.  Should the programs be detached here to avoid
> possible masking of a misbehaving program?

yes, thanks, will detach it

> 
> [...]
> 
> > diff --git a/tools/testing/selftests/bpf/progs/bpf_gotox.c b/tools/testing/selftests/bpf/progs/bpf_gotox.c
> > new file mode 100644
> > index 000000000000..8a84f4b225b2
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/bpf_gotox.c
> 
> +SEC("fentry/" SYS_PREFIX "sys_nanosleep")
> +int use_nonstatic_global_other_sec(void *ctx)
> +{
> +	return __nonstatic_global(in_user);
> +}
> 
> Should this check for target process pid?

And here will add a fix as well. Thanks

> [...]
> 
> > +#define SKIP_TEST(TEST_NAME)				\
> > +	SEC("syscall") int TEST_NAME(void *ctx)		\
> > +	{						\
> > +		return 0;				\
> > +	}
> > +
> > +SKIP_TEST(one_switch);
> > +SKIP_TEST(one_switch_non_zero_sec_off);
> > +SKIP_TEST(simple_test_other_sec);
> > +SKIP_TEST(two_switches);
> > +SKIP_TEST(big_jump_table);
> > +SKIP_TEST(one_jump_two_maps);
> > +SKIP_TEST(one_map_two_jumps);
> > +SKIP_TEST(use_static_global1);
> > +SKIP_TEST(use_static_global2);
> > +SKIP_TEST(use_static_global_other_sec);
> > +SKIP_TEST(use_nonstatic_global1);
> > +SKIP_TEST(use_nonstatic_global2);
> > +SKIP_TEST(use_nonstatic_global_other_sec);
> 
> Nice.
> I double checked and tests are skipped when old clang is used and pass
> when new clang is used.
> 
> > +#endif /* __BPF_FEATURE_GOTOX */
> > +
> > +char _license[] SEC("license") = "GPL";

