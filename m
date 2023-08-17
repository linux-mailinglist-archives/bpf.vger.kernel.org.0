Return-Path: <bpf+bounces-8017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C69777FEA8
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 21:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A15E1C214BE
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 19:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D800E1AA80;
	Thu, 17 Aug 2023 19:43:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934D720F8
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 19:43:40 +0000 (UTC)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191902D61
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 12:43:39 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso2493651fa.1
        for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 12:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692301417; x=1692906217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LWdknMsspoz/+6fO32rwPbGQoieEdl+MC7RVNOtOZM=;
        b=pelYKuHTvYovi21rCm9qrzuQ/tEfbEStKbkKRQ3VGGBt4v96rgJa4j2ooARfgjmECy
         pIZuguZWK35sllm1gB07k5hXEV9sCulVfl7x8TUpI1il4jZTKr6vi70BZcKzWK6L/Scb
         vdnig+y1h7FlZSTKyrJqP4DIY5XuRC7Qtcxe6UA8Bf3mHsJ5Vj6qQM36/4OxI8rNIzyi
         e8dIgJQ/nSZxC4BUJJW3FYjvjTNywp6nf4yH9/myXH7dYJNU9g7djXUPzehp6/WRoZCk
         s1jmUGhd9HXUBqKnZiYcsY7LQw76eYoLRvAFdF9hj/1LYGZMdX7OEqVsD2oPkEftuie+
         XU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692301417; x=1692906217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0LWdknMsspoz/+6fO32rwPbGQoieEdl+MC7RVNOtOZM=;
        b=M5cN/sg6b9WrooJZiShIUeKfjCWQQrAAZWjG7anE92fK/hZpOnrmNTMvFFRZYFlTgZ
         ALMU73POf5lR6XPFp8hCs19nzU9QimeynBdOa226VQwImm41PR2rFAVoCNlzYU3pgrZa
         JMNYdOfD5cqCrF2ID/B0jxCNwB4UCzMHhrxmUxO/n68b8xZ/CCPfbONOoLr9RzrT1Yq6
         qRuIClfDNW0/XXlSsl9D1qrIH5HNUssoQHcoicYlgYxtbysoeq0RdQcawlSoVCB8WZls
         2SwTS1ppVSwURjenM4ouPcpYI5rh33ZTAH9As1kO9kQnbuSgfHmFFEW3w0kqUtzE7Yy6
         3jGg==
X-Gm-Message-State: AOJu0YyY+oI+REKsmU29GeILOVyMZ3Nbs7jsh/35Iwf1UAhbHLS4R6af
	BaVGLlbi28lUnVOlPUDhigFLfVv/BK8XpPeE+fc=
X-Google-Smtp-Source: AGHT+IE8LYSln0qt6WSTyCRSg2FHsqEreQgPvpVaTp2mwbS1ysJQbgm95KehkUFiNS81Wp+ZDbpFDUg8uZi+UYXA3WQ=
X-Received: by 2002:a2e:9c46:0:b0:2a7:adf7:1781 with SMTP id
 t6-20020a2e9c46000000b002a7adf71781mr276684ljj.2.1692301416889; Thu, 17 Aug
 2023 12:43:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230815174712.660956-1-thinker.li@gmail.com> <20230815174712.660956-5-thinker.li@gmail.com>
 <20230817012518.erfkm4tgdm3isnks@MacBook-Pro-8.local> <5dd24d8c-17b8-53d3-3701-93693a11279b@gmail.com>
In-Reply-To: <5dd24d8c-17b8-53d3-3701-93693a11279b@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 17 Aug 2023 12:43:25 -0700
Message-ID: <CAADnVQLsqueyOQ4p0nJbGjhW7ULx+aB87Rr9ox3VJK55Xj=2Lg@mail.gmail.com>
Subject: Re: [RFC bpf-next v3 4/5] bpf: Add a new dynptr type for CGRUP_SOCKOPT.
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Kui-Feng Lee <kuifeng@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 17, 2023 at 12:00=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.com>=
 wrote:
>
>
>
> On 8/16/23 18:25, Alexei Starovoitov wrote:
> > On Tue, Aug 15, 2023 at 10:47:11AM -0700, thinker.li@gmail.com wrote:
> >>
> >> +BTF_SET8_START(cgroup_common_btf_ids)
> >> +BTF_ID_FLAGS(func, bpf_sockopt_dynptr_copy_to, KF_SLEEPABLE)
> >> +BTF_ID_FLAGS(func, bpf_sockopt_dynptr_alloc, KF_SLEEPABLE)
> >> +BTF_ID_FLAGS(func, bpf_sockopt_dynptr_install, KF_SLEEPABLE)
> >> +BTF_ID_FLAGS(func, bpf_sockopt_dynptr_release, KF_SLEEPABLE)
> >> +BTF_ID_FLAGS(func, bpf_sockopt_dynptr_from, KF_SLEEPABLE)
> >> +BTF_SET8_END(cgroup_common_btf_ids)
> >
> > These shouldn't be sockopt specific.
> > If we want dynptr to represent a pointer to a user contiguous user memo=
ry
> > we should use generic kfunc that do so.
> >
> > I suspect a single new kfunc: bpf_dynptr_from_user_mem() would do.
> > New dynptr type can be hidden in the kernel and all existing
> > kfuncs dynptr_slice, dynptr_data, dynptr_write could be made to work
> > with user memory.
> >
> > But I think we have to step back. Why do we need this whole thing in th=
e first place?
> > _why_ sockopt bpf progs needs to read and write user memory?
> >
> > Yes there is one page limit, but what is the use case to actually read =
and write
> > beyond that? iptables sockopt was mentioned, but I don't think bpf prog=
 can do
> > anything useful with iptables binary blobs. They are hard enough for ke=
rnel to parse.
>
> The ideal behind the design is let the developers of filters to decide
> when to replace the existing buffer.  And, access the content of
> buffers just like accessing raw pointers. However, seems almost everyone
> love to use *_read() & *_write(). I will move to that direction.

That doesn't answer my question about the use case.
What kind of filters want to parse more than 4k of sockopt data?

