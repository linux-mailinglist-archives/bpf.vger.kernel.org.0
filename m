Return-Path: <bpf+bounces-41739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F038399A2D1
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 13:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C5581C2145D
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 11:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0902821643E;
	Fri, 11 Oct 2024 11:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G66Tc2YL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFA9216432;
	Fri, 11 Oct 2024 11:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728646611; cv=none; b=R4T/jagikSDVGINZYBrRa8sZySVgL2dTdjog/UXg48s+eclNlrVEHYK605fl9/RqlA92ExnHGzTyd5hGCv7iUo+khMmHzZ48BFHZqXzv3xJopzDTGy3AzhIZwIJkEKf3No2qF38nXcNBeCY1BdDq9ZPSUue6upPq+vUj36qHMAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728646611; c=relaxed/simple;
	bh=fS12zFfDSg5QRtQKUz0FYz6oR+Aj6burkqiVH1GI3sk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mqz50jtThzYa1YQbpdfjZ4vGcU3xO7fYyqLz5KZbEAoyBkG11wh00m3DXvl7Tuh/eSOZanSkGffubRXjK590PGZIWWmHyxv7Efz+iRR1M8T7o2TPu/+G9oAEW3WmeVmOlgrLgH0adSxxjEs1GOeJS8c2w5S/QKl5K3p6L3fSIcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G66Tc2YL; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d4821e6b4so1050110f8f.3;
        Fri, 11 Oct 2024 04:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728646608; x=1729251408; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fYCLJth7NLoOYxi6Dz0gKrn8jpcKzLs3AoDhQjsXJ1I=;
        b=G66Tc2YLNMdy57Q/Sf3g9HaRzqmXMS3qpExyOJ0ZnP5+1gDkNIhLhdNP31anGoStTJ
         CVWgJY4yHiunuK2er/yVRfSRGXnh1f7iNv3ucgd+UHgt78RMZ+kgqx/WpXyplGjIt1Oq
         tLxnALaHWCV69QPIwk8VcBghsbop099oimOZ3qKkHuN14TMTyKp1XpS9562RLaxjuRKY
         Gy7avAi0BSHp3OQCDALobq6CE1jL3XwytctN0AXTvE2ZeZiGnYm+Jz0t/990FQAjF8iQ
         kJu2N7+ayzSSA8RyaUwUJeZwEprizYJjeMFbr0QaVMx1gg89v8Fsj+1EK8uqbfEWyl73
         5Evg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728646608; x=1729251408;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fYCLJth7NLoOYxi6Dz0gKrn8jpcKzLs3AoDhQjsXJ1I=;
        b=YIs1+3ZtaTNbchpAX6g+VUWZZ1t4I9prcZNjm9LwH/c33jQNhJaIbUqBvGx/Dbo6Kq
         H9Hf8Lz+4BM/YCWOgdVzqexSmNy4XsbyFOoqZrSRyTtfwwdvbYinIjgEBmzUB+svjR2/
         TiRCg3uSzFbUI3citkWdplxYFihWJ8e4Q5v1kHGbsi4jmVFBlPr1TVXypO3joNpsxLQJ
         DEmKofJ3V0o0wc1TIJPfHXS23jKncvSgQpPlfafyis9hyyQcOLeUim7ZUFpW+jlwRjag
         RsrCb5+1JdmCNm3PJ3DU22sTRVvoBSMez/rRB0peyXYTQfEmKkGiCv7R2PehPUPfgcN7
         FUog==
X-Forwarded-Encrypted: i=1; AJvYcCW+lvmrIFJ6GKbvDOFGyTxTR/vlZcFsc+s6aeMi+45otf2M76265UnGXveIBxmxayoX2JsW3/3ztxW2ZB23@vger.kernel.org, AJvYcCWCTQH30fSy1YAojaYJVrxf5gcO2CoJEWaFphpKKyaYPXhnZGfKV1PJrUx1+zvutZvTUskxc++4IevmyadAnunpvffV@vger.kernel.org, AJvYcCX+wyA41rWoQ/fZ+5FtyEdmryYEM5qsuVakK0cKzr+xiCWL1hNmnY+MTBYlWD9NtEK62so=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe2aAzAEiz6uVzQr73FW9XkmVmwn9OLs5yxjLsdm43CFD3IPQz
	k2f3yI8wHAQo/09Lg27vKc6nY/YtcjVo328FTaZ6xG1HCFHnTAPa
X-Google-Smtp-Source: AGHT+IEmFwW6QnxlYpKGtEGpfRqk3WRVeaIiOPfgUcGsKcP0IodfnMtjmOHC04e/Tf0U4P7yW90N0g==
X-Received: by 2002:adf:f58a:0:b0:37d:4ab2:9cdc with SMTP id ffacd0b85a97d-37d551b07ebmr1483999f8f.13.1728646608087;
        Fri, 11 Oct 2024 04:36:48 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6d0217sm3710381f8f.60.2024.10.11.04.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 04:36:47 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 11 Oct 2024 13:36:45 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv6 bpf-next 15/16] selftests/bpf: Add uprobe sessions to
 consumer test
Message-ID: <ZwkNzWPlpK4P2Iyh@krava>
References: <20241010200957.2750179-1-jolsa@kernel.org>
 <20241010200957.2750179-16-jolsa@kernel.org>
 <CAEf4BzY5zgoYAgJG7tfa84F2Zzjq=YFjh3=OzWqA6h39FfXB4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzY5zgoYAgJG7tfa84F2Zzjq=YFjh3=OzWqA6h39FfXB4Q@mail.gmail.com>

On Thu, Oct 10, 2024 at 07:30:19PM -0700, Andrii Nakryiko wrote:
> On Thu, Oct 10, 2024 at 1:13 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding uprobe session consumers to the consumer test,
> > so we get the session into the test mix.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  .../bpf/prog_tests/uprobe_multi_test.c        | 63 +++++++++++++++----
> >  .../bpf/progs/uprobe_multi_consumers.c        | 16 ++++-
> >  2 files changed, 66 insertions(+), 13 deletions(-)
> >
> 
> you are undoing most of the changes done in the previous patch... it
> seems like it would be better to just combine  both patches

ok, the diff looks actualy ok, I'll squash them together

thanks,
jirka

> 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > index 2effe4d693b4..df9314309bc3 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > @@ -761,6 +761,10 @@ get_program(struct uprobe_multi_consumers *skel, int prog)
> >                 return skel->progs.uprobe_0;
> >         case 1:
> >                 return skel->progs.uprobe_1;
> > +       case 2:
> > +               return skel->progs.uprobe_2;
> > +       case 3:
> > +               return skel->progs.uprobe_3;
> >         default:
> >                 ASSERT_FAIL("get_program");
> >                 return NULL;
> 
> [...]

