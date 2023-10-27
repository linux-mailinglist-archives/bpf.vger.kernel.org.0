Return-Path: <bpf+bounces-13482-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C586B7DA1BB
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 22:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6E34B21513
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 20:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF063E47D;
	Fri, 27 Oct 2023 20:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+r13W6G"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140263DFE0
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 20:24:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46841AA
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 13:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698438282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FxDkKqQ77Q8shRVMBq3wMjxaan0Y08EEDBxjDHU/0IM=;
	b=C+r13W6Ge5eBZDFfuvlaWRHUzC8sdtu9Jf+dK1g08NJk0QQ/tsZcYjXIc2bGjkaCwzAvTj
	X5sArAXfHprvIQSxzIdnJG+cx7J6vSYlKmHPbazoGS/cIYhRv6jkYJTUKZO+X6Z4xR89GT
	6tV8zKu9HNRna/jPA1uJO9XEhJLYvXg=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-XQgfshF5PiyQxHB4_jmXAw-1; Fri, 27 Oct 2023 16:24:36 -0400
X-MC-Unique: XQgfshF5PiyQxHB4_jmXAw-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6cd019c925cso3226691a34.1
        for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 13:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698438275; x=1699043075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FxDkKqQ77Q8shRVMBq3wMjxaan0Y08EEDBxjDHU/0IM=;
        b=J/pH6Rwm6Tlo6UsstTUuBKyGFeltKbEe4UbccUPCxGxkT4hJYgGsDtYPmFgnWOkGkr
         obM7guI2cgZdIcXGdD24mGs2S3nQHF2eID7ytx6cqXi8j5zlA15MicvbGrH8Zl7EI/0n
         BobUXuozeA/2VAzx1ErjiM86t34ubgB+p+CtpY6rdIw0yajBDnlEEwXIlRD3eb5IMHy5
         xmhACv0O3hIQWiiY/u7Z/opex5iE0LZ0SmtAQW2VxsQtUSJkwkG/6PVHTLW6oiPVTimE
         z4CkxK+Q2Hmuc70JPxhc+fFt8SAbeRk/hYJ4PWrLE4ywAjOsJszDbpzzOieppYHHQrQQ
         N+kQ==
X-Gm-Message-State: AOJu0Yzzj/ykYzYaDqa/rSG99PLU3EMivCF+sQpmBqKEHwmlvK4TWY63
	a5Oqu8OXDXjQdPfkrIidrwSwvH/vnEiEtBFfYVySu5DqF3bHMD1SzUed1F14SBFKrZrUfXEBdd6
	goBtyEyZvO78yRzAeO+uk8OPKiQnJBLG/PStV
X-Received: by 2002:a05:6830:2643:b0:6ce:30ce:3c94 with SMTP id f3-20020a056830264300b006ce30ce3c94mr3956253otu.4.1698438275367;
        Fri, 27 Oct 2023 13:24:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4/h4f4EpA+zmP+MyC2mslPNNQSyCeBI346RzvENotIBvvMYxIYBngOeN5VIl4XKG2rTwgnlladaLy9IrTAAo=
X-Received: by 2002:a05:6830:2643:b0:6ce:30ce:3c94 with SMTP id
 f3-20020a056830264300b006ce30ce3c94mr3956239otu.4.1698438275139; Fri, 27 Oct
 2023 13:24:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP6g7J+s_LFaA2sauAG2NJsW0-ob7bxmcCYZFDu1GWp_dtEbww@mail.gmail.com>
 <CAP6g7JJqSZLFKc6uuJ=EXky9TZqxYJWLWdK4N3kuOTGWob8BgQ@mail.gmail.com>
In-Reply-To: <CAP6g7JJqSZLFKc6uuJ=EXky9TZqxYJWLWdK4N3kuOTGWob8BgQ@mail.gmail.com>
From: Mohamed Mahmoud <mmahmoud@redhat.com>
Date: Fri, 27 Oct 2023 16:24:24 -0400
Message-ID: <CAP6g7JLBPMZrdUTNqegiDeQ_WPSb=ffEaLYCm+=Qnh=oiihAyA@mail.gmail.com>
Subject: Re: experiencing very odd behavior with TCP traffic with TC hook
To: bpf@vger.kernel.org
Cc: Toke Hoiland Jorgensen <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

pls. ignore this thread this how TCP behaves and matches what I see
with wireshark too

Thanks!

On Fri, Oct 27, 2023 at 8:47=E2=80=AFAM Mohamed Mahmoud <mmahmoud@redhat.co=
m> wrote:
>
> Hi All:
>
> I have been looking at an issue while attempting to track DNS over TCP pa=
ckets
> I am using "do dig www.google.com +tcp; sleep 10; done" to test the code
> I noticed the TC hook seeing inconsistent pkt length which causing my cal=
l to
> bpf_skb_load_bytes() sometimes return EFAULT
> I collected some info for working and non working cases
>
> working
> =3D=3D=3D=3D=3D=3D
> "dns_record": {
>                         "id": 40514,
>                         "flags": 34176,
>                         "latency": 185794,
>                         "errno": 0,
>                         "offset": 68,
>                         "tcp_len": 34,
>                         "skb_len": 291
>                     },
> none working
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> "dns_record": {
>                         "id": 0,
>                         "flags": 0,
>                         "latency": 0,
>                         "errno": 7,
>                         "offset": 68,
>                         "tcp_len": 34,
>                         "skb_len": 66
>                     },
>
> as u see in the failing cases sbk_len is only 66 bytes that explains
> why call to load bytes fails, IMHO this very odd behavior and inconsisten=
t
> it's not clear what I can do in my application to get consistent behavior
> I am seeing this with RHEL9.2 kernel
> uname -r
> 5.14.0-284.36.1.el9_2.x86_64
> is this a known issue that was fixed in latest or this is expected behavi=
or
>
> Thanks!
> Mohamed


