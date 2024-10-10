Return-Path: <bpf+bounces-41655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 086C39994FA
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 00:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FC141C22D4F
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 22:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F961E491B;
	Thu, 10 Oct 2024 22:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5qJoJnR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453941E2317
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 22:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728598359; cv=none; b=TtlGEDUwHkmArJxjlzPSyBJC1m7pkSxccWjMLkE0LDFogT0g2IXBQZw0mGIbL2sn0YofcfpM8YBEupxEj8LdOaPHouwLAKch4X1Yv5CweBZ0EyC13o55VoeTAz35g0HQc8MpR7ff1Xn6WMX4tNzAElrb5zLbBtH98FFmquBd0oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728598359; c=relaxed/simple;
	bh=VW9j7IsYjW1DmNRNe/0L7VBroJU4NKM8TbZu3fSAhHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eKQJnAk+wSoFjXWrk8xquzu9/vqEiKk7e469W0VU+Ai7TFl7jDSgUCt7qs7tyhLHn0QYBhgNGPXHSDyT9cLEQK8oUcjNyaGhz+dwXG1axsVgWYae8455w+HBEOXCSXRutgvlxkCjAq1KEPkPm3AbQbkEkyqAMeY7J5CAuO0tHLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5qJoJnR; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4311c285bc9so4083055e9.3
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 15:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728598356; x=1729203156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6575e7lgxVtljqmNv9HPyWw86tGOkdC1md1bRgv4rs=;
        b=N5qJoJnRdzJ5xzq5yWkpDZc+h38GWb+WQPw4CxAzu38P1taiOtsKCN5BSR/Pkz0L1S
         6Xd2E8ok+CKbTRouM184gIDuTTOerQIcyF7QNhPU/+zBcJzK+BJV/6yIihfTBiofGPgj
         FSor++e0MbRrdB59ibeDLrcmfengpnUyihMPA/2UNIqMmEq0rd/BX1Mxw79YURI0/F/v
         2txsSEs16E131MxVX4LrtEQAT5ieDOgfzB3BGLCZJ11AS7HificlZCFIJShVovzqdqAR
         NapLdLgSY5LlpMuBqJ7AiZV6LSKqkGpW8VXKkY+4DRBtIy/f5yzmQjH8ZF2K12WimPhS
         Dmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728598356; x=1729203156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6575e7lgxVtljqmNv9HPyWw86tGOkdC1md1bRgv4rs=;
        b=JL+ZK0rikykwTvX8LZBzgvWHqzKlP8NbGxfdl20Uw12TvBcy2H+LXpVWCaavuvwfLF
         pBdV9NOTfEuJ0K5umrvYLL52PT2U7bse9xl/R1xBYHydObTnCrsEAaym4pbl1rIPBZBe
         xJwvJb6AZnPR48LfXuIRIsuAMUBo+0w0BgCuVd4+G7bVhhgl3oMb+zs2ZDijjHMnxZoV
         EQJgwc8smatrl71skR2CuboTgCl0XwLJu4AQuQfsGxKLuonTu4CQqvcGzENuAaC9Fw/l
         Ru6HjtldRPzkNLe8ga/Huw54jH51+cOAMWWI5+pDyJzt69TSeX/BJfz5GpcrZmC3hn1v
         TQwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW3GbTbjSbDplZKBsuDa10df+EdE2W0Jpi+vad2/+lb7tovX3FDftHncpJ3laNvF4nAz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK75r0hQzsGW4JjPe91cR0yDG9ZjvyYLZWSO9L5o1CGzjRWRsb
	OmAFODglLdDlRYjIW4gpCjYyce0LClCTUabDul+ShrX4S4vufOWSk5stIN+dKCShBuXj1F/fOzn
	LTcfoWPGuSwFeRBlnhXoBX+yrNtv3EA==
X-Google-Smtp-Source: AGHT+IG3kT1RGk1fsLecbM008LyklO58oiVJRvjhAGj17KN3R9PCOoDq9DHaNtkxe0NM2Ay6FDhtlOIyh9SCI5EP0WI=
X-Received: by 2002:adf:f98a:0:b0:37d:39aa:b9f4 with SMTP id
 ffacd0b85a97d-37d551d416emr381387f8f.26.1728598356281; Thu, 10 Oct 2024
 15:12:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008091501.8302-1-houtao@huaweicloud.com> <20241008091501.8302-7-houtao@huaweicloud.com>
 <CAEf4BzaVNBaNULS3=9o6hwnruKBTcz-Z3c0DMf+q17G=RfPkEg@mail.gmail.com>
In-Reply-To: <CAEf4BzaVNBaNULS3=9o6hwnruKBTcz-Z3c0DMf+q17G=RfPkEg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 10 Oct 2024 15:12:25 -0700
Message-ID: <CAADnVQ+hC5pL+kP12JUUA7SMQjk7ErQbnyQ61KZV3vfZoAJPnQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 06/16] bpf: Introduce bpf_dynptr_user
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>, 
	Xu Kuohai <xukuohai@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 2:50=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Oct 8, 2024 at 2:02=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> w=
rote:
> >
> > From: Hou Tao <houtao1@huawei.com>
> >
> > For bpf map with dynptr key support, the userspace application will use
> > bpf_dynptr_user to represent the bpf_dynptr in the map key and pass it
> > to bpf syscall. The bpf syscall will copy from bpf_dynptr_user to
> > construct a corresponding bpf_dynptr_kern object when the map key is an
> > input argument, and copy to bpf_dynptr_user from a bpf_dynptr_kern
> > object when the map key is an output argument.
> >
> > For now the size of bpf_dynptr_user must be the same as bpf_dynptr, but
> > the last u32 field is not used, so make it a reserved field.
> >
> > Signed-off-by: Hou Tao <houtao1@huawei.com>
> > ---
> >  include/uapi/linux/bpf.h       | 6 ++++++
> >  tools/include/uapi/linux/bpf.h | 6 ++++++
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 07f7df308a01..72fe6a96b54c 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -7329,6 +7329,12 @@ struct bpf_dynptr {
> >         __u64 __opaque[2];
> >  } __attribute__((aligned(8)));
> >
> > +struct bpf_dynptr_user {
>
> bikeshedding: maybe just bpf_udynptr?

I don't like it. Looks too similar and easy to misread.
I think bpf_dynptr_user is better.

