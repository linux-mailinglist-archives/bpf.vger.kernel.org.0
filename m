Return-Path: <bpf+bounces-14060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02837DFEE9
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 06:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03CF51C21019
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 05:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D8917E1;
	Fri,  3 Nov 2023 05:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njG9hzl8"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B40D17C5
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 05:46:42 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAAD1B9
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 22:46:41 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1ea05b3f228so962972fac.1
        for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 22:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698990400; x=1699595200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzyljLmrvcOIw2k/zlG2oViJ4AiPlhbxS729I/ZXD1U=;
        b=njG9hzl8fowo/fnhjnbT9eYC6R3ygVZGpro9reJvrTxhqMH8au60HrYfde0aPhbfeo
         1GITqELXIJgBR9nw4LLeNpUyfEEHM1fu5BhVbYtlHeAP4MGwrvtKEV8bFSw20fo0Os3n
         CDgPZfjWUOvmVUn0BisG7xL1qyMSjGJwtfNrldhC3MN0/Glm+ELoTWcZrfmgFgt0zky5
         VSCYt4EzsvqKq6PSykZAgFu5KyYyB0seltj1UTFpLz+pNJznmcYdDo0FNs0Jir46mubE
         D/Y896UsesEnpalmvd8MWQSlexUjc0N736TJbDlO0RN7HK9f8+orP0qhwZ7NpAw8iQGo
         jrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698990400; x=1699595200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzyljLmrvcOIw2k/zlG2oViJ4AiPlhbxS729I/ZXD1U=;
        b=FG5D9+B4g0v73z1MXbA+y/MWmXP6i9NbSDXHaXfMV3P+WVLLwA+/1t+hKQ6NwOkWsb
         HhjH7EogxHLP1G4nu94IXPvYul8d+boNH06O/eSQrs54TN/YmmU6YAsqUjqxl3DblpyX
         1d9uPdjvn3TMmX/nVl3IueJpxUMc3+hjABDI1dqY673WYOj43lxhYS0ZCT4EhjsHqtbv
         InZw4SEunep7CufbjYA3ccUHQW1w8PoV/kjomgPp6OOduSMulBqni+p32Fdpi/K8+213
         r4mincR/Svv2JpxLRBMDCGwbSeBKMxZ6xpO1KaCHlvlgedQv6YLlk4Tyg6sPivZPPVmJ
         zmVQ==
X-Gm-Message-State: AOJu0YyTZA5YqaR6YNjXzPEJUYgAUwYLuVlEBf9ezNInmTypkdRo+/27
	fMW19u6hpEDoLwlj5HUvL1ljsBNB1toGowXB6y0=
X-Google-Smtp-Source: AGHT+IEKDMSVTIiWS9S5MW+24DtrTPAm9RzViIvQl/l+k5sF13wUBUzU82KO/wSWIHBl0vRPf9D1GR3M6cgp70dMGfc=
X-Received: by 2002:a05:6871:650c:b0:1e9:f73e:636c with SMTP id
 rl12-20020a056871650c00b001e9f73e636cmr24304590oab.43.1698990400021; Thu, 02
 Nov 2023 22:46:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031012407.51371-1-hengqi.chen@gmail.com> <20231031012407.51371-2-hengqi.chen@gmail.com>
 <6F41D669-AE0C-4CAE-9328-B03BFF7F5643@kernel.org>
In-Reply-To: <6F41D669-AE0C-4CAE-9328-B03BFF7F5643@kernel.org>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Fri, 3 Nov 2023 13:46:29 +0800
Message-ID: <CAEyhmHSROn4=U2e6w8uxer=_R4+d2vZbwrSbq=dHgD9H0ent8A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/6] bpf: Introduce BPF_PROG_TYPE_SECCOMP
To: Kees Cook <kees@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, keescook@chromium.org, luto@amacapital.net, 
	wad@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Kees:

On Fri, Nov 3, 2023 at 3:49=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
>
>
> On October 30, 2023 6:24:02 PM PDT, Hengqi Chen <hengqi.chen@gmail.com> w=
rote:
> >This adds minimal support for seccomp eBPF programs
> >which can be hooked into the existing seccomp framework.
> >This allows users to write seccomp filter in eBPF language
> >and enables seccomp filter reuse through bpf prog fd and
> >bpffs. Currently, no helper calls are allowed just like
> >its cBPF version.
>
> I think this is bypassing the seccomp bitmap generation pass, so this wil=
l break (at least) performance.
>

What if we did the same for eBPF, a bit harder though, does that
address your concerns ?

> I continue to prefer sticking to only cBPF for seccomp, so let's just use=
 the seccomp syscall to generate the fds.
>

That's an alternative. But as Alexei said, there would be no more bpffs thi=
ngs.
AFAIK, we could only share the filter via UDS.

> -Kees
>
> --
> Kees Cook

