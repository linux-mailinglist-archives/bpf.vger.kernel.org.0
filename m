Return-Path: <bpf+bounces-18362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DA3819730
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 04:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62AC61F264BD
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 03:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779858BFC;
	Wed, 20 Dec 2023 03:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1du8kPx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC18168A4
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 03:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3364c9ff8e1so150304f8f.0
        for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 19:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703043209; x=1703648009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zn8hLRuWBdnM5as7BB6+1PLdnaYpWJVvmgGmberHDuA=;
        b=I1du8kPxrmv/LK47oYEBGXkqAqt4RQJZsWa5sNRnrkBl4zrn7Fu03TYhARIFbs3WLL
         rNRHB0TjUzZ8XFUOoO4l6/RNVN1u6yESNdp0OAJyJqAzn8FKQtGlwtnM1wNhzbH62gA2
         fiYVrT+U1gjMOyxDELdec7ufOjz4IgWgHQYQdUmzTayG6JVVwVPkHbrw580viKlDjJU3
         NZxbj+YvMVMCUBL7pjejeepN2E48wRl9igXsm2RQEHwxQD3siANfmYVZmNNPV9lFz70D
         r0hNNPFJNTqkiuFXEok+d3mtyZB+iDVioBsGl6Yo+pQxAIUd/15KCCrQLsypMhCq3U0h
         1uvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703043209; x=1703648009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zn8hLRuWBdnM5as7BB6+1PLdnaYpWJVvmgGmberHDuA=;
        b=wATt/szquMj6MsQoFShLhwgq5QfhbWLgg3yz6u7va0kXvSg+Ml4GUjbiAYvTV/0kgk
         PCeBK8iyhbK9FZOTy1NYydgc7ObPJd4Mv6WafRYFzBgH7SOXx+n3JEW/qht6YgS8ZXBE
         L4cEsVLTktClU0v9EKVjvrCq79ayAiaxrT26dlxWvKXJIU7lApMXHYlGGk4JTHt/qQuV
         iUVdUPH1ZXtFj9XvE9e4aKWj9/jlpX2/6ngfetAkBg9q2iah5gyo4OKRAvQM5lMg8fF+
         96pmJtm/18G8WNldoODA5hkc3j2Ry0cVl0fpM5xU/wQhUh4GDM+xgC4ircG/XrsMJUJb
         H4BQ==
X-Gm-Message-State: AOJu0YxSPqP98kPWmu6evKkpYcaTVmi80toHk3+qd9Xu69BivCVpp7oP
	qRvrj2hoL6hwAqQm+hYzYgJxPIHnnGqcTJ0xwqMb3V8T
X-Google-Smtp-Source: AGHT+IFEEICTAS4Q/TzITHS8brTJsyi7krw+it7cfgOyxsvHOi0jbi5prQujT5dBAew/GtP3B0b/K4i8GNCWpWwhfe0=
X-Received: by 2002:a05:600c:4fd4:b0:40c:1e8a:4ced with SMTP id
 o20-20020a05600c4fd400b0040c1e8a4cedmr1136539wmq.13.1703043208351; Tue, 19
 Dec 2023 19:33:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231217010649.577814-1-andreimatei1@gmail.com>
 <20231217010649.577814-2-andreimatei1@gmail.com> <658b22003f90e066ba7d6585aa444c3e401ff0ac.camel@gmail.com>
 <CABWLseu+uALXXwaSGJ=zJhoZuWH3Lajby-ip8oKAmTOLxci7Vw@mail.gmail.com>
 <0994aae8e3086cb93f25a47ee9e81a6894dbff26.camel@gmail.com> <CAEf4BzZPC0zV_ETO_BPe58aZnDx_GrhpVejr3=-Hzx176P1Kvw@mail.gmail.com>
In-Reply-To: <CAEf4BzZPC0zV_ETO_BPe58aZnDx_GrhpVejr3=-Hzx176P1Kvw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 19 Dec 2023 19:33:17 -0800
Message-ID: <CAADnVQLdS-E2jvGk5k9-zb9k4ATc=Z4eJjG6p-=basSaKfKDKg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/1] bpf: Simplify checking size of helper accesses
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Andrei Matei <andreimatei1@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 11:08=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
>
> I don't know if variable-sized BTF access is important (Alexei?,
> Martin?), but maybe BTF access has to be checked separately and then
> we can keep the check that does pure dump memory access checks simply
> and correctly?

Walking structs with BTF is certainly special and variable size
BTF is necessary to access flex arrays at the end of structs.
iirc we have a test case for it.
On todo list we had a task to implement variable access to
different array elements (while preserving BTF types).

