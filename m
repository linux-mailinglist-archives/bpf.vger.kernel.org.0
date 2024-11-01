Return-Path: <bpf+bounces-43761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1DD9B97F6
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 19:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C7528200C
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 18:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16761CEE94;
	Fri,  1 Nov 2024 18:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHvGQtFu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7DA1CEAA2;
	Fri,  1 Nov 2024 18:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730487279; cv=none; b=SnWsJ5nPIPdvUpmctF9SEPoQVkVWLLnox2uYn/08uzNBL63f+wg8twtjSJlGYyRWoK5nnMtZ23iEFlFMQQd0eYK0GM7YHoFXUV0pqGtaXxep5vZ+SV4vzAMYfjeQ6O4coeS/DnW27E6ILw44IC/PeHASSMT+NuE950fne0FndnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730487279; c=relaxed/simple;
	bh=1bMRixRQWrCR5WDHY1GSQDFQzqbkaLd6KXwZ/ssd4f0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NnTQVFCQ2aVeFuUMBa2tSnQ5joFqbUgYAJPTAJFJenosGyedNZszvFHLeDi/5C4l7cS1NR5SZd/E5qaNE5uacjQo72Yg5K4skov/mHGv99o8drr+vw1BNeEXqBeWGdQP3NOBHQkU7HkQhwQOGfAhX46L9QgE3oH1IjI3wz8ZmVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHvGQtFu; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e56750bb0dso1654019a91.0;
        Fri, 01 Nov 2024 11:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730487277; x=1731092077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bMRixRQWrCR5WDHY1GSQDFQzqbkaLd6KXwZ/ssd4f0=;
        b=eHvGQtFu/ZyG/S98USHWti5X6CXjkicOzRjjcszBCkstjTAPaa9uHj8WB+Uf+aJP7I
         qA1r1j47ewUtTOtGRQP2axWxOgNnHDZ49oFhWsj6ODkK2IXQBByxu0lqGjlqD0r1XIVL
         eMm/2TB6mHXkI5PyurzfkovcAJMykhIRtfy3cCsxbMjRTlJ++PD/XWmCP+eWXcZ6Prpk
         FEM7xYb/+g6nqfGdHu460L5Wb7xQA0nrcJTBOdtwo113Kcaya72UtcR7qtEmgy1Uu8hU
         Ztf7rsTnPqGXXbU6GwP8psh5BJ0Ng1o5enWApMgRCTz5AOSkmkoaSnhD2lk4J9mnVGCn
         q/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730487277; x=1731092077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1bMRixRQWrCR5WDHY1GSQDFQzqbkaLd6KXwZ/ssd4f0=;
        b=RPiB3uuJVV2eGkkYAWEoKrVhXI5E3KRhTGswx+q4rubuK4lXVBEPCPzJMJ0MrMfiKl
         mvfn03SXocw6DbTb21eORMw9Xu8yFXFDjJuKuoaU7n2H3YJSbUCZ+06EAo4ZvK1uZ0Ew
         DdtUu1hsmovk5+Oh1uY7i/7B3t/+lXd2T0J+gY+I1wLxIH35qOzdckEyyZN4saahCYv5
         ZccZZhBxWXMKloa+2vsSg2MZSiyeCqkY4GVIxbygIKsDTi+quWLmxqBgG4U/fv0OTuAd
         a0SlH4blQVspMTIGiDMzYoO60OZBuluX9dtc2wxOqu2ZaHAq91z3PX01ZF8cNguc8VyR
         UEHw==
X-Forwarded-Encrypted: i=1; AJvYcCUoS3avk54n89C3FQs933YqffmWjfACB6QqnZuFkPT/wY4PndhjZ/iqXCu81RA4TAmoXavDhXcWWPqHT6cFIiUIUw==@vger.kernel.org, AJvYcCVp3gnA+yOVJSL4ouPVyacMcy2k3XlMhjgAwgg/77HoUqcdO1rJJ+qqpgQC+K3l7Hph39E=@vger.kernel.org, AJvYcCVr0k42kqMHZ746ZCeCxVbomZQgjuPobkXlrqDDLJ7NAFzhGZbsOXgZGRRGcYwPqHGAV9ZaGoCmG/QJIRRi@vger.kernel.org, AJvYcCWxbwSQjYVm5TwNjm6Rbcatuz0emTFyUsnnft94ynnABzVPW10f5mfiAxERUL71uD29iyIfefAi2BzMbf7fSc8tqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzU7aYNRUjy91zsHKAoXMPwzd7UUPph/sxd/WjxzrgdOL2wtJRJ
	jmzCeaUaHOZh8svsyZH8ayWnrP/x3KuAoa9jXkC0RGjo3YW/m446NW4A6dJnb2R9kXVv1r9LPw2
	8tmMCobxLxUDhox7mnb8aoJE0958=
X-Google-Smtp-Source: AGHT+IG/sYlxmlCyl7sDQo4FWNE1QHHdRYACXFSNwcX7Otja+6b/3OXBl3uyzAsS28BVR9/iBGlyJATm+i8qVTfJC/o=
X-Received: by 2002:a17:90b:1c85:b0:2e2:e597:6cd3 with SMTP id
 98e67ed59e1d1-2e94c2d6a20mr5804587a91.17.1730487277089; Fri, 01 Nov 2024
 11:54:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730150953.git.jpoimboe@kernel.org> <42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org>
 <CAEf4BzY_rGszo9O9i3xhB2VFC-BOcqoZ3KGpKT+Hf4o-0W2BAQ@mail.gmail.com>
 <20241030055314.2vg55ychg5osleja@treble.attlocal.net> <CAEf4BzYzDRHBpTX=ED3peeXyRB4QgOUDvYSA4p__gti6mVQVcw@mail.gmail.com>
 <0f40b9b8-53a9-4b45-883b-d4d5ecf9fff6@oracle.com> <CAEf4BzbLt3b8xH3eSvRJdnorZvQfWzOFeV-gYRxDmaS6YVba2A@mail.gmail.com>
 <20241101144720.78e2dbd9@gandalf.local.home>
In-Reply-To: <20241101144720.78e2dbd9@gandalf.local.home>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 1 Nov 2024 11:54:24 -0700
Message-ID: <CAEf4Bzbygo28Mi+FMeZLj=ZMyp94-6W6+tUqeJAscW82J3RT1w@mail.gmail.com>
Subject: Re: [PATCH v3 09/19] unwind: Introduce sframe user space unwinding
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Indu Bhagat <indu.bhagat@oracle.com>, Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org, 
	Jordan Rome <jordalgo@meta.com>, Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org, 
	Jens Remus <jremus@linux.ibm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Florian Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 11:46=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Fri, 1 Nov 2024 11:38:47 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > BTW, I wanted to ask. Are there any plans to add SFrame support to
> > Clang as well? It feels like without that there is no future for
> > SFrame as a general-purpose solution for stack traces.
>
> We want to use SFrames inside Google, and having Clang support it is a
> requirement for that. I'm working on getting people to support it in Clan=
g.
>

Nice, good to hear!

> -- Steve

