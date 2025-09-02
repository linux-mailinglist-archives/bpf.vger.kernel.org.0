Return-Path: <bpf+bounces-67199-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D48B40A36
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 18:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 775E91BA227E
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 16:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D08733A00B;
	Tue,  2 Sep 2025 16:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXdmJjJl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A8A3375DA;
	Tue,  2 Sep 2025 16:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756829497; cv=none; b=meUemaHurGI576rx8u3Fg4Ub9aQ4SxQKjFJt9IKq8qqXgNzbtfJzantXSbM/hOacP4sU5xHHGhYFkmRVn6R7lX6+Wjckv02ZlqeK2NDPT5X1WliTuPw9sNjzlLwNl2Krh0QHRNVMM0vGcrpskV5+mMUdtXeE0WAN97FShiSszS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756829497; c=relaxed/simple;
	bh=jTW8kVFk5PN3HuFXHJyL7zyMWDABWszA9BxNrkt5TOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZrOSB5LAD/sNStLirtNoS0qprC6VW9M+7yLqm6ZjH7gg5dGTlBUqPxQKqFdiUOPv/9ce/s5mv+IQ5Y4hOIDPmKYmOKaCb6U6vCyfG0ou2OzUUxZ3UZNn4HReXklDxdVIdXcQu8Gurqwc8LTppUPlQ1cXPFdWwXyi6nKAcRrFljg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXdmJjJl; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b04271cfc3eso296969066b.3;
        Tue, 02 Sep 2025 09:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756829494; x=1757434294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dcZpUvLVz3N0at5fXDhoAD++E+8uoI2vo+O9PjHjxU=;
        b=DXdmJjJlMiQuesX1dfc8SFL+xs9UQOod39hIT5WybyNLOIxcIiEmyS2Z99On7i/pWv
         pbtCKWmDENyaMltBn5PL3VFw3ItxRG67TQ6Qw5AKGQPNQn+CZgYi+JJsyoYNQN0iae7s
         BylNdqpzjt9lSZJSrA/sLXks9waYkZXSfFuKRWYmakqNTOGRc6+6YeEqITA2i8P09Bs0
         f1Cmuw5SJV7rNvOZTBs2NbEwxrxsHi7SgktCTNXYNo8Z/yYKCdpXGfWBP7kceJwUujnF
         xtDNsTe+KJFD7WJzryYPu8/V3azy1P+he6NMrNL/WZIN2QGqmFxTvi5N6kR9F+dwtFyS
         Q4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756829494; x=1757434294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2dcZpUvLVz3N0at5fXDhoAD++E+8uoI2vo+O9PjHjxU=;
        b=qqTS9XY/j+MxXyYaEpetsTz5Xvgg4aHyyf/zYLR0m6IMp0jy4juMiAiNOK6GFJVuVE
         IpkeMekbtfIzKjaVcSQOFXTxmfF5Gqk6WdY3+AnHz8qtu2CiNoOkvBejOCnkPKYHMsLw
         nlLlfi5P7V8wVoF+jag1oH3feye6cEX6LF6FOReLdpBtLd4OlJFQMzZ0CNKYB8/5j1+T
         SsS+XhElkdVqyBwKToAMovNEEU3mSeAQEKp95b4hK3IyfdsNWALzIJ9AF5XVnyorRDz/
         oH8+Qb2v7yvMc7eB4sZJRBYwoLT89J2C8cvp0n1w1YPcIOzfAoW366F9DePzSkSzT5T8
         nt+g==
X-Forwarded-Encrypted: i=1; AJvYcCU5FOS+pKgEkIepFQHQxJ2FlualIXrD2+Myv5ygefUze4J+DC7AmEw7GYZ88U5RZugVbJo/e0xWMKxAH+RYaaRMHbQC@vger.kernel.org, AJvYcCV8RbKXQv9rW6kKR6JFZ0xEUI4vzqC/AJk7GGkQaRUi9Yy02LY3r3TI9WNpz4q6ZhfYnL+/gWY/8VLySqtw@vger.kernel.org, AJvYcCWp+uarZnd7YXCvJg6ocDIpco/HfJXfSjdXmWzsJTFJBCcFo+fIl4jy047YKdlWV5E/POg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhCDk4KgxB+PdvSvD95AtiO9dAwE6e470hHM5emcW1yyU8Cwro
	Gs8kbJLPL/uTfEBkETKxlthEfWkmqnuS71q7KBS5+rot2FEe/zv1FpM+lVriw1apsOSLwFjo8gr
	jR/hQQ6UAcyuMGJXtHWANxEPWr1j+aGo=
X-Gm-Gg: ASbGncujZaweWH9Ss4zSe3xGHETqfF3SArM1Y/tmPUpzv+THYguwstggnmPX8OQ96Rn
	wj0b2/Boo6SUYL1q6nM1gFlrVwczwCz/lUybRHSsm/xz/HyHAaaihkLycuXuGHwvmiPqVYUsJzd
	15uYVZ3+HlaLPIqiggvLI1dj5hzrd8Eruj6Uv1JNDGdRpw1dqOf1gt19CTcwjrtl/LmUFkrd/JM
	WrwQu8gggCkMbmL1+PdZM4ph1oHzWj9LQ==
X-Google-Smtp-Source: AGHT+IERdIljI9N7Xe/T21h5febi7Y0OYO4gOFIJTKeQ7Xhez0g3OMTeZX2wNcts37cq/XlPW8fxUGYhvx5teij95Y0=
X-Received: by 2002:a17:907:7291:b0:b04:3e43:eccc with SMTP id
 a640c23a62f3a-b043e43f17amr552559166b.40.1756829493901; Tue, 02 Sep 2025
 09:11:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902143504.1224726-1-jolsa@kernel.org> <20250902143504.1224726-5-jolsa@kernel.org>
In-Reply-To: <20250902143504.1224726-5-jolsa@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 2 Sep 2025 09:11:22 -0700
X-Gm-Features: Ac12FXzfov0r30nmd6VkzyQEbnijwjfleIGZKFPAEflFWqIgyGmqUWuPgQC4Xmk
Message-ID: <CAADnVQ+MntzHdwSe_Oqe7CU=E3yjko=7+9GTnapsPWwe4oqpsw@mail.gmail.com>
Subject: Re: [PATCH perf/core 04/11] bpf: Add support to attach uprobe_multi
 unique uprobe
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 7:38=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support to attach unique uprobe through uprobe multi link
> interface.
>
> Adding new BPF_F_UPROBE_MULTI_UNIQUE flag that denotes the unique
> uprobe creation.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/uapi/linux/bpf.h       | 3 ++-
>  kernel/trace/bpf_trace.c       | 4 +++-
>  tools/include/uapi/linux/bpf.h | 3 ++-
>  3 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 233de8677382..3de9eb469fe2 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1300,7 +1300,8 @@ enum {
>   * BPF_TRACE_UPROBE_MULTI attach type to create return probe.
>   */
>  enum {
> -       BPF_F_UPROBE_MULTI_RETURN =3D (1U << 0)
> +       BPF_F_UPROBE_MULTI_RETURN =3D (1U << 0),
> +       BPF_F_UPROBE_MULTI_UNIQUE =3D (1U << 1),

I second Masami's point. "exclusive" name fits better.
And once you use that name the "multi_exclusive"
part will not make sense.
How can an exclusive user of the uprobe be "multi" at the same time?
Like attaching to multiple uprobes and modifying regsiters
in all of them? Is it practical ?
It feels to me BPF_F_UPROBE_EXCLUSIVE should be targeting
one specific uprobe.

