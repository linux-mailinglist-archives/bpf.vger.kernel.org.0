Return-Path: <bpf+bounces-66019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E75DB2C83B
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 17:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE8433BD082
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 15:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016BE2820A9;
	Tue, 19 Aug 2025 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+6F4blG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2227327A108
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 15:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755616430; cv=none; b=TE5hmdpcwfC7I7LKvFab3juyy+bPpAz3Er9iBHIexX7TfiUQsM0N3BgnjrL2bGESBNwvcqRdA4Rql2j4BDnvV2GL1Z665qymLDCvB+ke9Q6TFtzLVi0Y3HC+pLs0+tUD75OQyf7xLFEZ2EkW15rm0NJbJWri5uE9820w/QkeNkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755616430; c=relaxed/simple;
	bh=AzZCvZdwujpUMdN+tWDgdMxLcLvOMsoeFATO4DHbqMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VFTAwb6faYN4gdLbsq9NvGTbgN/MwdEWbxkqKkA39DR3Oooce3ZynN0oofnoKk6dsLP5OPBb4Ht3xlu+vJjzHNIlMlg7HLeEVKaXbuD5s7zmPEgVW4TPbWyHfFFR7UCMcFg1dUCHDSdNBjFRZbpjcwsuJm9u5S1Pi4bqU7Q75Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+6F4blG; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7e8704c52b3so642318485a.1
        for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 08:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755616428; x=1756221228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzZCvZdwujpUMdN+tWDgdMxLcLvOMsoeFATO4DHbqMw=;
        b=j+6F4blGEX5xH33Bnb9Tn/G5auEIY/tAVoXASZHQovaF4IvgMFz3rDPjfugitnmfUD
         6ydgzk+n/RTEcT5vFrw1lsObn5N8vJENFyRUtLyeGX2vlHzFVVxpb0/mi/TGkN+ei26K
         RfdN+i7ELQfMCVRqSfY3BjR5zYLW7E2kJT6qSZQYXOGpXcZg43jqOYJOz7WXs2AL3FKH
         /8YuQKn8KF9hKdvuN1sWRHmca0EdlEiU9KPWWKQIni9v2AxHrFnDIEDFWRbTuxsrMCqb
         CI6B+te+gYiyjhcR7FnYAN84ja10Qu8jgkkZAkXxFwyFVYSfUHLvGIeLbkZeQSoGOmjq
         6dcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755616428; x=1756221228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AzZCvZdwujpUMdN+tWDgdMxLcLvOMsoeFATO4DHbqMw=;
        b=hrQlK6Q7KRBOxpqxfP6I55XWE+ygmlGjM0kreG4dAJTxa6qm04U/BQZI6O4ZxwsdKS
         9NRRmhi5uJwtNoDijEH5wi99EKa/yAN/m9GJbsXKD4D/hZGiRz+g7DkXup7Zs+VbNp0p
         O1OvjFJAzBzeXY6dendOYyagTCCasufbAkmjhIXlHl18irRGy6KreqQn4y6bJ9RkxEYu
         Fa6vY9KHj9r9yj7/DwIVkIDibZQzt8PzOuWCMFxiHXbc9RGX6aHwnJUUr2NWVy+eCfsJ
         KO11ncdJ4vBfGMghokKp+NenT7lppZjOl336d46Ja5E3xr+H/GUtYE3sA1qWHbHjrbyE
         166A==
X-Gm-Message-State: AOJu0YwI66tw4W+qvAiloTqFfzCmWwWgJt6LhYbgiGKQU+JAJJmXwIbc
	z+TkwTfuCPBP/mX2pEB+1VFxLpXD/MCI6cOi9IBeddGF9rQ6Byyl/xX4zK49ygulF6YY827FdE8
	rsm95gDbZumY7idKlCxWrBF12F22OQys=
X-Gm-Gg: ASbGncv59TNYq2unbj+ep1eY4kEVHzBdeNsVi24UbcdxH9NOCtmcGcMtvlerZPF/J4N
	AzngGWDrgTfnh3oJYbVJCsAttN6KBsNoHF1t7pmivIBJwfivoMiJrO+B1TUurzOaw8x/J9wtNtq
	k2gElcrM7b39M1u5Bmelm1Xx8loZ7wX2wtIGGhOg3raT/Cf/JKwLVB9+UcIySQPGI7lRKT8lWwI
	cfMNZT7CfHXMWQFlw==
X-Google-Smtp-Source: AGHT+IEBrw3iBEEt94H31UvaehIU64YLaOwfZAiGJWwM+NQKoZsl/96CznzjhTfdq89ERZShslR8EOEDd/s7T/3mvPk=
X-Received: by 2002:a05:620a:1786:b0:7e8:7094:52dc with SMTP id
 af79cd13be357-7e9f333b5famr338639485a.7.1755616427943; Tue, 19 Aug 2025
 08:13:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818165113.15982-1-vincent.mc.li@gmail.com> <65c52407-1993-4906-8e13-2d74932ee82e@iogearbox.net>
In-Reply-To: <65c52407-1993-4906-8e13-2d74932ee82e@iogearbox.net>
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Tue, 19 Aug 2025 08:13:35 -0700
X-Gm-Features: Ac12FXygNzjwxByNrM5R58W3kfCFiBPhCCFshqxdBfKa-OGVf4pEXuiS6KOP7Y4
Message-ID: <CAK3+h2xOEpjUYnpMYsYJJupAjQqn==z-cqEoro4AdkQP6Y+aYA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpftool: add kernel.kptr_restrict hint for no instructions
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, Quentin Monnet <qmo@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 1:12=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 8/18/25 6:51 PM, Vincent Li wrote:
> > from bpftool github repo issue [0], when Linux distribution
> > kernel.kptr_restrict is set to 2, bpftool prog dump jited returns "no
> > instructions returned", this message can be puzzling to bpftool users
> > who is not familiar with kernel BPF internal, so add small hint for
> > bpftool users to check kernel.kptr_restrict setting. Set
> > kernel.kptr_restrict to expose kernel address to allow bpftool prog
> > dump jited to dump the jited bpf program instructions.
> >
> > [0]: https://github.com/libbpf/bpftool/issues/184
> >
> > Signed-off-by: Vincent Li <vincent.mc.li@gmail.com.
>
> I fixed up the email typo and rewrote the commit message a bit when apply=
ing
> to bpf-next.
>
Sorry about the typo, maybe I should have asked AI first to write a
commit message for me :).

> Thanks,
> Daniel

