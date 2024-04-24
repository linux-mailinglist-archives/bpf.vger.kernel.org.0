Return-Path: <bpf+bounces-27600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EC68AFD4D
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 02:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F1E228849B
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 00:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C7D4C84;
	Wed, 24 Apr 2024 00:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixJ9blBn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF7E4C7C
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 00:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713918420; cv=none; b=XUA2Wo+6PBKzVjBel15I2XrK6WBY+MffCHTvPbeL1+YpFHdrPFqot8RcZIt2Um9xITvJ4x5YWM6ZBCBXxZSuyXtS9HCJqFwBpVw4pY2zir7pof8pLmRakhVKlwQ7dMQGC7h7JWkoDPKuXwN7QE82d5jUCJAdo0KGBT/r7EZ78p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713918420; c=relaxed/simple;
	bh=C0cSkNoOgur089irjUF/JdMzz6zflE5beV97KZ0KrRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=flC2Dbao84QnEa6uFxgLCIf1oyS4YXtB7u5rqp+AutyNpHiHQr2lsgZ4lEAAeVM+k5FsUNKF6kHyN6g4+KrB+7UW7kyZGno/a2v1H+P+TB7Md65f4aGA2PbxZAs+S5mi2RISse1ZikimL0kGMQABvjCuz9S6LC356IdfcW4Eiso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixJ9blBn; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e8bbcbc2b7so47954185ad.0
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 17:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713918418; x=1714523218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrCdTP/RX84ym6A7EZAFqXXUJpqJx0oOF/mDO7o2UpU=;
        b=ixJ9blBn6tVoo5rkclaSlVYKQsgJ1zsPqT92b7Qe5uZs1Ash4bApLQ6HGHij5wco71
         TsdAeZS0u+1JumERR24avq8PHgBWn4FQAhHG5KL4SG6HLNrvrWAf/1JXx6XtTy9negXF
         Wr0x9wBv8/MR1OEocfoMclodYcai0+nvfdidBuFpeUDZPiiXRFxfGQl6SNfB5iB3yv7g
         J+sh+Srr77699N//c6uu6DMRMyZ+YcKNf/rvjAELNdbdihA+qQJNPUgW0N0MglrJLcED
         2tO9hTVwQg/rOpXI6vpnpIspOLFtMApAPPbmidDpEwnpcgpCure0LRD61wmk440IoPeQ
         h+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713918418; x=1714523218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HrCdTP/RX84ym6A7EZAFqXXUJpqJx0oOF/mDO7o2UpU=;
        b=SScAmDFoDO7KLYEvO12uU7Ja1tBUMO28QYgk5tmLHAnIrFHZy5/ifJihCJJ1SSelL6
         NuSQ/agEeUeFhRHndsy6auEJFnVZCjSfFavfjAs9FsnnE+XSq5OVQ/d6mQZfMdYzsen2
         98U5eFwvuaJH252Se2FyyztBv3tEMNpclygEfSJMaxbGs+gWEGobLuJNakpGvyIYEWy6
         F/VXJ0NSPqUt0Qc0lsbq9r/7kqG/+/8Dg/9fZi32VpKPhVHl8mIXYnpJiEblC1+mPHTK
         E3WddcwellNq7HPJ3z4uMzR4+fwT/Uo4jOhRP/sa8zca0/2lAxVmx19ogGrdQzmck5lU
         kYFQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7+cQ7fe+IMHSLoUNZ2riPSMJULvBiU37C5+oc55FC0Cs5axnbgB5L+rC+a7p1DtWf18DqFggxj7nr5eyOXRzn2/QN
X-Gm-Message-State: AOJu0YwzwFK7Dnh5s2IbbQqFXE334N7R1mhxew1GaR0c76z+f55i5RB+
	GA8vgb2cpKqDZi+eYZUdtsQofDT20FkGMuYOJU4rSDZ+UjLucyPw2/wjwM9VfQCLEZ8aDdwTVn0
	Qx5X49r9bHBsTc7EGiDPEW4BZNr0=
X-Google-Smtp-Source: AGHT+IEm5XW+qu0pg12PTfF1GIZeeBA8ATqJluJ4wIIrJdW9fIRN3IZnZUD6FRyjqfsufZhtjaaSib9PiqExpch3oSw=
X-Received: by 2002:a17:902:dac4:b0:1e3:c327:35c0 with SMTP id
 q4-20020a170902dac400b001e3c32735c0mr1224419plx.2.1713918418533; Tue, 23 Apr
 2024 17:26:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422121241.1307168-1-jolsa@kernel.org> <20240422121241.1307168-3-jolsa@kernel.org>
In-Reply-To: <20240422121241.1307168-3-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 23 Apr 2024 17:26:45 -0700
Message-ID: <CAEf4BzZYpaZ-70WU9gCRAcAfYEH9cq5GRyyZatygULKhS7zVZw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/7] bpf: Add support for kprobe multi session context
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Viktor Malik <vmalik@redhat.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 5:13=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding struct bpf_session_run_ctx object to hold session related
> data, which is atm is_return bool and data pointer coming in
> following changes.
>
> Placing bpf_session_run_ctx layer in between bpf_run_ctx and
> bpf_kprobe_multi_run_ctx so the session data can be retrieved
> regardless of if it's kprobe_multi or uprobe_multi link, which
> support is coming in future. This way both kprobe_multi and
> uprobe_multi can use same kfuncs to access the session data.
>
> Adding bpf_session_is_return kfunc that returns true if the
> bpf program is executed from the exit probe of the kprobe multi
> link attached in wrapper mode. It returns false otherwise.
>
> Adding new kprobe hook for kprobe program type.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/bpf/btf.c         |  3 ++
>  kernel/trace/bpf_trace.c | 67 +++++++++++++++++++++++++++++++++++-----
>  2 files changed, 63 insertions(+), 7 deletions(-)
>

LGTM, but see the question below

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

> @@ -2848,7 +2859,7 @@ kprobe_multi_link_handler(struct fprobe *fp, unsign=
ed long fentry_ip,
>         int err;
>
>         link =3D container_of(fp, struct bpf_kprobe_multi_link, fp);
> -       err =3D kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip),=
 regs);
> +       err =3D kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip),=
 regs, false);
>         return is_kprobe_multi_session(link->link.prog) ? err : 0;
>  }
>
> @@ -2860,7 +2871,7 @@ kprobe_multi_link_exit_handler(struct fprobe *fp, u=
nsigned long fentry_ip,
>         struct bpf_kprobe_multi_link *link;
>
>         link =3D container_of(fp, struct bpf_kprobe_multi_link, fp);
> -       kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs);
> +       kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs, t=
rue);

Is there some way to figure out whether we are an entry or return
probe from struct fprobe itself? I was hoping to have a single
callback for both entry and exit handler in fprobe to keep callback
call chain a bit simpler


>  }
>
>  static int symbols_cmp_r(const void *a, const void *b, const void *priv)

[...]

