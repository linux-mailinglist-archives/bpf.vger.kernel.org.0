Return-Path: <bpf+bounces-27670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 890AE8B0885
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 13:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159E31F24180
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 11:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5C815A4AD;
	Wed, 24 Apr 2024 11:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiPMClVm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA2A159903
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 11:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713959069; cv=none; b=q7m1/8oFEmCUDVjKwq168DSncvti7AqhHDeWqeOK6UPRdii+zr4HXqWWw3VRWpUcAwJ3Cc3mnE5/PEYabYAa53FbR0vWK/ou+mXE2gSL4fK3/U+pAzcMsr/PtD173vSZELCbVALt3ZEkD9IVxud2mx0iYLbbEQWcLGnzgQZYRy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713959069; c=relaxed/simple;
	bh=SgM98PEfH2n/dEg4XyN1qQdqklAoEpOg+cyRzny3B/w=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtG/U+lxXwzmGguTKw+rq/Ou5eux/wOiHIkE/oRbgERbJzNcd9tH8Mf5hvWV15+nCEFScM4R6Gmr/uIJhBuuwoDG1DlJx/SMol37rbojQ1l0FtYpSR2+vfI5e9JywMLa5GtlWkF68JfnIiWaNGzdmiF4bYN0r3I6YqWfn53VeSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fiPMClVm; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-571bddddbc2so6607033a12.1
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 04:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713959066; x=1714563866; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FuKcHW/JvG4WC94fjwdKGWyaPwY1I5+YbkZimiIVfPk=;
        b=fiPMClVmMYpc6IWLsfFD3ouVbOva72MJX9EoPDDQ9e8AywcC8CkXy/m9RPMSm/m5RU
         t7+rq2ot08uNrSxqIxJFBXsvOrBLBj4dKIiP4uKV2OCTggNS0LJh8hNpMTJa/WBeYm/p
         x/HnzWWbOg9I5lwXBxEoLZ6KV4TKEK3MsUY3LkP3UURyx1T1hdq7p57hVFXpNQLbyo/h
         TjnC0/cBe0LAwDl8WRv80byvfr3Waoyy7OMMWfiKFGE59c3oOxaN65gkXq9KgMiIxFWJ
         BOw3tJ2HoSPDlvjUmxaXUE7QXgbAQVyz0xU29rbO2/wkmWchuQSLFMNV80mhgLVO/uIL
         7b9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713959066; x=1714563866;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FuKcHW/JvG4WC94fjwdKGWyaPwY1I5+YbkZimiIVfPk=;
        b=T7onQZFza9i3nyXZemuBiGcKkqAqIpX3B+y3mrolBUWMBMG2smIcaYzuv8m1C+YKhD
         me/F2YfYgjo2CEQijq+I7xd7ywBPJIClp8dl6yrgffYELgIu3ua341rOQ+4iJDpASxbq
         iC2OyCOYilj0RCEULd6PtwecTa6CvFSJ1iiqA3NeFDDKyK5mN1/HqbyCanSbQlzWjXds
         Ph1vuqEKl0d/h1qWjfi6ryhyeeQo25GgIBHMioS8oq+we+GPS/7fXi6TigjFEsb0c+BY
         rrs2M52X5N+dvFUyWld1sw6P6c+zbWUvegwnd2w0BA3q31uNSIs298UExQOeZWXZBpvA
         CKdg==
X-Forwarded-Encrypted: i=1; AJvYcCUmedHocbWbuQPl0Z7SC5szsQ4uDhS/2eHDDUd7PMWAzrbc3R9R/2muA0Nii31rqnVb21LwfzN65vOrf0wH+Gysq+8Y
X-Gm-Message-State: AOJu0YzFet78JMz+SbnXOQ0PEl+2TanU6RxSiyB/qoPmplOxSwpqR6kW
	8XKi5qq/EnyFhaO8JfjIEPWHtI77b93yoHJhumJNsDDzU35elxMp
X-Google-Smtp-Source: AGHT+IHAHFblYcmbxsk0aZQa+rIzaez6E3YFXtfnUm/Z9G/bfuD/wJ5wpLGjSJujYrkVamDX+7BzOQ==
X-Received: by 2002:a50:cd91:0:b0:56e:2a64:8290 with SMTP id p17-20020a50cd91000000b0056e2a648290mr1647028edi.5.1713959065416;
        Wed, 24 Apr 2024 04:44:25 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ef9-20020a05640228c900b00571bde3b0a4sm7457121edb.34.2024.04.24.04.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 04:44:25 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 24 Apr 2024 13:44:22 +0200
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
Subject: Re: [PATCH bpf-next 7/7] selftests/bpf: Add kprobe multi wrapper
 cookie test
Message-ID: <Zijwlv6CMqnJcu5y@krava>
References: <20240422121241.1307168-1-jolsa@kernel.org>
 <20240422121241.1307168-8-jolsa@kernel.org>
 <CAEf4BzbyQpKvZS-mUECLRq3gyBJbsqQghOKyAbutoB76mJM8xw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbyQpKvZS-mUECLRq3gyBJbsqQghOKyAbutoB76mJM8xw@mail.gmail.com>

On Tue, Apr 23, 2024 at 05:27:22PM -0700, Andrii Nakryiko wrote:
> On Mon, Apr 22, 2024 at 5:14 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding kprobe multi session test that verifies the cookie
> > value get properly propagated from entry to return program.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> 
> Forgot to update subject (still using "wrapper" naming)

ugh, thnx

> 
> overall LGTM, see nits
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> >  tools/testing/selftests/bpf/bpf_kfuncs.h      |  1 +
> >  .../bpf/prog_tests/kprobe_multi_test.c        | 35 ++++++++++++
> >  .../bpf/progs/kprobe_multi_session_cookie.c   | 56 +++++++++++++++++++
> >  3 files changed, 92 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
> >
> > diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
> > index 180030b5d828..0281921cd654 100644
> > --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
> > +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
> > @@ -77,4 +77,5 @@ extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
> >                                       struct bpf_key *trusted_keyring) __ksym;
> >
> >  extern bool bpf_session_is_return(void) __ksym;
> > +extern __u64 *bpf_session_cookie(void) __ksym;
> 
> btw, should we use `long *` as return type to avoid relying on having
> __u64 alias be available? Long is always an 8-byte value in the BPF
> world, it should be fine.

ok, there are some __u64 in kfuncs already, but let's stay on safe side

SNIP

> > +/*
> > + * No tests in here, just to trigger 'bpf_fentry_test*'
> > + * through tracing test_run
> > + */
> > +SEC("fentry/bpf_modify_return_test")
> > +int BPF_PROG(trigger)
> > +{
> > +       return 0;
> > +}
> > +
> > +static int check_cookie(__u64 val, __u64 *result)
> > +{
> > +       if (bpf_get_current_pid_tgid() >> 32 != pid)
> > +               return 1;
> > +
> > +       __u64 *cookie = bpf_session_cookie();
> 
> we don't enforce this, but let's stick to C89 variable declaration
> style (or rather positioning in this case)?

ok, will change that

jirka

