Return-Path: <bpf+bounces-41278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D1E995660
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 20:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A66F1F2532C
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 18:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D8E21265C;
	Tue,  8 Oct 2024 18:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gE4Kw4Mx"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2AA189910
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 18:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728411819; cv=none; b=acLRjyVgWZW9sAbQhIyJQO3LdKsYMUq9zhGTpR7yCk4V8qXg1pkxU5iN3nv+pEwUbivC93jlDw7LnR51ty6EOBI0gc+keCN5h0KNfoxzobax0AKFxTLXhMzxOg9JAg7BxHS3VE8IcwP2IkWQgoccz+qvEkSrngDKv+TPSxnYJmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728411819; c=relaxed/simple;
	bh=QT1T0IupaRLSifJ+RTMvxTlMl+w41dvAcOZCuAwcrOs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jk5UUOEBjbLNKKx+4+B2HPSjRA+2ufDf6MjGzzSQEn0FIQPtAeCaHWIwK/gk4GxBywqv6il1pXPZII747NLaGNwXwp6Z5p5oo4wGJLF1dBzugSVEt96+CnZNcA7bYtc+NfpdUdxUf930KZQu3D1svn3TwQkD0IW5aKZl6A7Kpsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gE4Kw4Mx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728411816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QT1T0IupaRLSifJ+RTMvxTlMl+w41dvAcOZCuAwcrOs=;
	b=gE4Kw4MxAliHqMm7ipsgMlY6MM+ss6e+VoSCE1VmQFC4Bw9g29AO93Q+5kw0h9II2EBQ2k
	WUktSZ5KCZ2Zm8N9KXOFSfs8DlUus6Z9/ckRmmtTgBDx6agzooe8Ck1uxo3Bzyp2V2B6n2
	smCXlusSaStSnGrmJ71iHhEjwV+bU0A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-HOQFYWDgO0KcfimYLCWlAA-1; Tue, 08 Oct 2024 14:23:35 -0400
X-MC-Unique: HOQFYWDgO0KcfimYLCWlAA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb2c9027dso52195885e9.1
        for <bpf@vger.kernel.org>; Tue, 08 Oct 2024 11:23:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728411814; x=1729016614;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QT1T0IupaRLSifJ+RTMvxTlMl+w41dvAcOZCuAwcrOs=;
        b=gtMl1ISdFHhN95iRkeJuhOt1cExF2tAKU6iTjR9BLxu59EZ87T8ZjGHcwn/KEEsWfr
         jzfHHtTxq7HYi8sDnR+Uilin/3w0UYcfh2F9rs4Yw+wBhRLdmeqtw+EvlOI9Wvf9h2cE
         jtRHN2LDfaHteetJouRX2PAMFFPK1tDjPgIgIz+tot1UF+1WdIbLDBtZaeMluN/FFks7
         jWURnIV7IeiYWOVth66R3mUWleUNBoCUm8qe1MeQm7pfPGmipO9U1u56t0+cZ/focn9b
         mC0lpeytWujuFroDGOYz/4qMZFkVgAMSlGRcsJgw9s3rHyfFTmYs7XatCjeEL7ai/gG4
         nEzQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0TWsQo4focC5p1HhyTHeiRZCoI0CTR/dQwqLBvAMmdjC92R0g95/czz/+M9Jp7f72sBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0BDAojVpV2W2OHdhW8I4cpWGETvGsK1tdHwPeTWSoHr3EYCFf
	N+NfvpWLQNR1T464oiEC/UBvRbHt7uN2DG4REJcphfFx4LofR1sFLLT5+8+Uh/5cLt/EebPft5U
	9Whj7TtFrtmgfg/dxxuoWp/xlQ13hOvZLPIgqtUq7p6vvsW57+g==
X-Received: by 2002:a05:600c:3c83:b0:42c:b037:5fce with SMTP id 5b1f17b1804b1-42f85a6c5d5mr133510585e9.3.1728411814171;
        Tue, 08 Oct 2024 11:23:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmS6JLmeixjyN9tqj9ltRwcrgP3TJf4cIZp+RtyX56Pa2J25VMfpSue5hJhJ9yNS5s1/078g==
X-Received: by 2002:a05:600c:3c83:b0:42c:b037:5fce with SMTP id 5b1f17b1804b1-42f85a6c5d5mr133510285e9.3.1728411813778;
        Tue, 08 Oct 2024 11:23:33 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86a0a8a0sm135269295e9.6.2024.10.08.11.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 11:23:33 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 9A5CC15F3BD2; Tue, 08 Oct 2024 20:23:31 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Simon
 Sundberg <simon.sundberg@kau.se>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH bpf 2/4] selftests/bpf: Consolidate kernel modules into
 common directory
In-Reply-To: <ZwV3d5-sBYtgt2vi@krava>
References: <20241008-fix-kfunc-btf-caching-for-modules-v1-0-dfefd9aa4318@redhat.com>
 <20241008-fix-kfunc-btf-caching-for-modules-v1-2-dfefd9aa4318@redhat.com>
 <ZwVv_ZOvh2mTGAlK@krava> <87ploascn2.fsf@toke.dk> <ZwV3d5-sBYtgt2vi@krava>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 08 Oct 2024 20:23:31 +0200
Message-ID: <87ed4qsbbw.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jiri Olsa <olsajiri@gmail.com> writes:

> On Tue, Oct 08, 2024 at 07:55:13PM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Jiri Olsa <olsajiri@gmail.com> writes:
>>=20
>> > On Tue, Oct 08, 2024 at 12:35:17PM +0200, Toke H=C3=B8iland-J=C3=B8rge=
nsen wrote:
>> >
>> > SNIP
>> >
>> >> diff --git a/tools/testing/selftests/bpf/bpf_testmod/.gitignore b/too=
ls/testing/selftests/bpf/test_kmods/.gitignore
>> >> similarity index 100%
>> >> rename from tools/testing/selftests/bpf/bpf_testmod/.gitignore
>> >> rename to tools/testing/selftests/bpf/test_kmods/.gitignore
>> >> diff --git a/tools/testing/selftests/bpf/test_kmods/Makefile b/tools/=
testing/selftests/bpf/test_kmods/Makefile
>> >> new file mode 100644
>> >> index 0000000000000000000000000000000000000000..393f407f35baf7e2b657b=
5d7910a6ffdecb35910
>> >> --- /dev/null
>> >> +++ b/tools/testing/selftests/bpf/test_kmods/Makefile
>> >> @@ -0,0 +1,25 @@
>> >> +TEST_KMOD_DIR :=3D $(realpath $(dir $(abspath $(lastword $(MAKEFILE_=
LIST)))))
>> >> +KDIR ?=3D $(abspath $(TEST_KMOD_DIR)/../../../../..)
>> >> +
>> >> +ifeq ($(V),1)
>> >> +Q =3D
>> >> +else
>> >> +Q =3D @
>> >> +endif
>> >> +
>> >> +MODULES =3D bpf_testmod.ko bpf_test_no_cfi.ko
>> >> +
>> >> +$(foreach m,$(MODULES),$(eval obj-m +=3D $(m:.ko=3D.o)))
>> >> +
>> >> +CFLAGS_bpf_testmod.o =3D -I$(src)
>> >> +
>> >> +all: modules.built
>> >> +
>> >> +modules.built: *.[ch]
>> >
>> > curious, the top Makefile already checks for test_kmods/*.[ch], do we
>> > need *.[ch] ?
>>=20
>> Not really for building from the top-level Makefile, that is for running
>> 'make' inside the subdir, in case anyone tries that. Don't feel strongly
>> about it, so can remove it if you prefer?
>
> no strong feelings either ;-) I was just wondering what was the
> purpose

Actually, removing it means the .ko files may not be rebuilt. But it's
not enough with just that dependency either; will give it another try
and see if I can avoid a .PHONY (or just add that if not)...

-Toke


