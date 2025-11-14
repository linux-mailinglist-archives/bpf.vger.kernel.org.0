Return-Path: <bpf+bounces-74597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1BDC5F922
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 00:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F7113AFC41
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 23:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C927309EEB;
	Fri, 14 Nov 2025 23:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6aIzRa0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B4927281E
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 23:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763162272; cv=none; b=cAgPeeGpVZi8ktzgQnVzPAgxaBk+CDwoWWB/Wp8/bcVgFenmeWLq4G6Sx8S3LxZIchzuZ38qL/3Xzxa6B2XnZQS2TWw0UwsGr9I63gfu8JY+mWOThJkjwV8CyDcitXpX4YDGtAehad1pgtsQzdIjw7vRmOEJkqMVYwHJJYE0UJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763162272; c=relaxed/simple;
	bh=vC/SFwwHH5ERwHKHFXjn+dmNfWYgSW5aTxMRn0nqvIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rFfFc/V8wLSXrdPuDLhjCbaGLg446J9z5wlGHA1N6l6YlPFfq8LqiCWvOQch/3NQ6adSCFxOgjoijvYo6eYUqhj/HahicUvkhXvMD5EhI2sHGr5lPDJ/yfdl1F9JdhsEXs6crpmArcrEExSxqgN0hXCe36WlKJjb3yj3R3xb/q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6aIzRa0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381C3C2BCAF
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 23:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763162272;
	bh=vC/SFwwHH5ERwHKHFXjn+dmNfWYgSW5aTxMRn0nqvIY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i6aIzRa08B/+5ez4cWtc3N6o2bwCYYvJqu9bjXCpxeeK44ttUqtoaVsgZ0fiFgVKx
	 Hl2SKb6zYf4dllvv4nEzLO4MP7AQMRN7EGn6LhwTf0vSK2uN8e7VLBpKMj+BWB/i4c
	 x40UnMQB0zpnAkgCC8OlK/z8K0B7DoY1NlpaPjZePmzRFSaHjEomkLwXJIO687Z0Pz
	 cm8mlpIB+/ZBSnS5l6920AisUd7gv1dcNOXa0Lep6YT+pZm94fn4goPiUMZF0VQaxz
	 E0vFiKkRuZS2Ztzj2GC5su48Rvv4ypkU2BZ+mtpiZu9I8RCb6jw2GJIZDW3NH1tzms
	 wYstNejJjigFw==
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d71bcab69so22844547b3.0
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 15:17:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWxcEr2SJdvZAhy4MiTa2afXBOl2PxNXCljKXIxKFjUjExvTZ6T4XokMbEXWZebRVXq6vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHuX1kILsLW+wilHhe46kJOnb23YZfpLUId4kg2SSt5yi15kJ8
	z2DhxngXgOvuzbKbFjw/aucuTnClpGNO4KuMt8K+idXjEO8DmOJJMsTn5FODC1CYo6Fji4BAH2/
	/EpVhIKUuOarp7ORyPO8/PCr9Z7AAgyM=
X-Google-Smtp-Source: AGHT+IHlSnNZwkER98sQW0oFNCEVL3aA3sMAlC6Fmge+0KqbGsJsAmPRPyUpXrgvErJfDmcpa9przrKqaGGnmBd9ifQ=
X-Received: by 2002:a05:690c:8b19:b0:787:d0d5:808e with SMTP id
 00721157ae682-78929f15937mr35746277b3.50.1763162271349; Fri, 14 Nov 2025
 15:17:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114222249.30122-1-alan.maguire@oracle.com>
 <20251114222249.30122-2-alan.maguire@oracle.com> <CAHzjS_vO3GseC0MsUpGDFdTULNYsj4rmWXt6kADa26zioSswgQ@mail.gmail.com>
 <cd326ce3-bff1-4003-912c-659db8da6bf9@oracle.com>
In-Reply-To: <cd326ce3-bff1-4003-912c-659db8da6bf9@oracle.com>
From: Song Liu <song@kernel.org>
Date: Fri, 14 Nov 2025 15:17:40 -0800
X-Gmail-Original-Message-ID: <CAHzjS_vOOiHuTCygx1xSV-6mc12YHRnuhSew_f54chetc3zEpQ@mail.gmail.com>
X-Gm-Features: AWmQ_bk-xxwIcy42wc13TBonJ3WN4bDiCB6o_Ol-gd2_mHG98jg317hL7NhhKF0
Message-ID: <CAHzjS_vOOiHuTCygx1xSV-6mc12YHRnuhSew_f54chetc3zEpQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpftool: Allow bpftool to build with openssl
 < 3
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Song Liu <song@kernel.org>, qmo@kernel.org, kpsingh@kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 3:04=E2=80=AFPM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 14/11/2025 22:55, Song Liu wrote:
> > On Fri, Nov 14, 2025 at 2:23=E2=80=AFPM Alan Maguire <alan.maguire@orac=
le.com> wrote:
> >>
> >> ERR_get_error_all()[1] is a openssl v3 API, so to make code
> >> compatible with openssl v1 utilize ERR_get_err_line_data
> >> instead.  Since openssl is already a build requirement for
> >> the kernel (minimum requirement openssl 1.0.0), this will
> >> allow bpftool to compile where opensslv3 is not available.
> >> Signing-related BPF selftests pass with openssl v1.
> >>
> >> [1] https://docs.openssl.org/3.4/man3/ERR_get_error/
> >>
> >> Fixes: 40863f4d6ef2 ("bpftool: Add support for signing BPF programs")
> >> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >> ---
> >>  tools/bpf/bpftool/sign.c | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/tools/bpf/bpftool/sign.c b/tools/bpf/bpftool/sign.c
> >> index b34f74d210e9..f9b742f4bb10 100644
> >> --- a/tools/bpf/bpftool/sign.c
> >> +++ b/tools/bpf/bpftool/sign.c
> >> @@ -28,6 +28,12 @@
> >>
> >>  #define OPEN_SSL_ERR_BUF_LEN 256
> >>
> >> +/* Use deprecated in 3.0 ERR_get_error_line_data for openssl < 3 */
> >> +#if !defined(OPENSSL_VERSION_MAJOR) || (OPENSSL_VERSION_MAJOR < 3)
> >> +#define ERR_get_error_all(file, line, func, data, flags) \
> >> +       ERR_get_error_line_data(file, line, data, flags)
> >> +#endif
> >> +
> >
> > We have func=3DNULL in display_openssl_errors(). Shall we just use
> > ERR_get_error_line_data instead?
> >
>
> It's a good idea, and I tried it - unfortunately we then get a
> "deprecated in v3" warning when we build with opensslv3. So this was the
> only way I could think of to build on v1 and not get warnings with v3.

I see. Thanks for the explanation. This looks good to me.

Acked-by: Song Liu <song@kernel.org>

