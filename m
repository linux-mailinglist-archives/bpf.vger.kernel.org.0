Return-Path: <bpf+bounces-39380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C36DB9725CF
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 01:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3826D1F246AC
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 23:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E7E18E37C;
	Mon,  9 Sep 2024 23:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiatQ6aA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF8518E040;
	Mon,  9 Sep 2024 23:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725925464; cv=none; b=LtyjB6C+bHrQaZ0Fs5JISK6SizRpCPp1YQne0eEqY4Ng72HG0KdHJlwWsSwvzNM19Qp/BfH7a8H3Db9bqt583O/gfWtG3Xz3BFYTDDis1C8NlSfaMeTexMSEDoRfJixdvKfePaOk0BDeOjap8auis6ZoNapJk8OuPNG7z/u3Rfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725925464; c=relaxed/simple;
	bh=67TG3+DJiwCDkEFHQd6no3SeVRqGsft9f91ULj7ZDGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LSxjByOrf6/eBsdZ4yvwyAD+EGga1PuAhft6rynS4/TCN7Z9ubVCqOaVOsTdskR24K9BiG7acKDYuwL9qEmbdFGuC17Ix0L7UsaNJwh82frqZexlfzoluaZXIDXmKF+9DocfEaegncm/5+Eo2S8K5flGscauSCbax6b8csNUlpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IiatQ6aA; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d88c5d76eeso3147676a91.2;
        Mon, 09 Sep 2024 16:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725925462; x=1726530262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQePtXix4NPP2DnvfCAb71/91R9FwUGIGWH2bP7w8cM=;
        b=IiatQ6aAebn3QXYhY6N2IoF1ZbJif/r43lvPxClYtX1E2BRFyZoPFNo+7umzhL9vvv
         CLTdHaWO6SKGes09hMY3PDBFosbh5kJtfcPfo9gLCUSwtzBeD/WGP9sHT2oZEJs8Hq79
         yRUreGlu9ehLoLQq0ZQNEh0UMTG06ztYW6qui7+mreeVnEsg6I9K14rkKxT+/aRUEdxT
         IYRf45dP2eV/6ZmB9N33TuPRb2qGU24MPKOE6gSa8ywyBZK9G9j/ZGMJEjTrm72O27DV
         JY7HDNW5+slsYNGjhPVpbXFw8iDQuv0u7jvS8o54tZKOH0dBPN/drqJzuiTU1YeVjkOu
         CkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725925462; x=1726530262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQePtXix4NPP2DnvfCAb71/91R9FwUGIGWH2bP7w8cM=;
        b=jQKo30JzNY6oMKIXM9RDd4sPX2IHT8kJzfzUslxvDYKb4NgNwKBVG/afkkafki/qUp
         c/DbGpg2G3NxhS4tZ/5apIgBRMr7belJvhXhKGRMAxm+mhGw6gf+yivnCLdT8BovVZ43
         fsPKT6W9ADBomF9jaVJ+xg5tElrKFUH7ct6ZNT7nD2Ph1bUhpuKGr+rj8Ncbk4lBedC2
         2qpx6EmpjxN7epgAoMsMni/3+9+kByyURhgmHm3Clg2I0UCPNE21xgR14TMNtappUIxd
         qhAc7BevzGiWFuZyD3qWNUwPNTtUmxefTmEfmQtkg0bUKy50R2ydkdTwGSGkHVGtrSw6
         z7SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWaoP/wgo5xBN2AkNvTM/sFJKAvKnrnCWIDl/5xZMKxrD3Z9mPViPnTZUGkeAsxmoKEnE=@vger.kernel.org, AJvYcCWbvBsfGBV+BWCRY1qEn71LrU0wkslnEZDTIBmoC7gfIVovRXbcR/twGEfCVMPOcKYfzcfCgvgdJRGws874@vger.kernel.org, AJvYcCXKI5knfD/QdHzyfLGhSht9Qbcjo0hFwS3BK8SfkJVt8sdxKSFyQGCQdGVcv4oLacf5X15HyeZErtSnPDq1QhAjC/Dm@vger.kernel.org
X-Gm-Message-State: AOJu0YxJdHIIn0jby1Yii3HBnGrWq6YUx+5jDrVnWTgmdgFlrVO2TNSV
	QU5vg/XkW+QZvB8g7j99gyubGrNZ768yfhEkv2WS+uNUhhmtWhLyUXk+It6gkWIVr2vZQayMUFU
	gs3CbfMJbuPlW/SPB5H/3yIQvk78=
X-Google-Smtp-Source: AGHT+IEHlh/76dHGFPfmL8zUUPtfDZ4rZIgWU7jKQK3X1aN0QgBsrlpIu95Qt/j6R2wnhn4j/XXWoqKmSxCo+39OfqA=
X-Received: by 2002:a17:90b:ec6:b0:2d8:d58b:52c8 with SMTP id
 98e67ed59e1d1-2dad505d5a0mr11742274a91.19.1725925461869; Mon, 09 Sep 2024
 16:44:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909074554.2339984-1-jolsa@kernel.org> <20240909074554.2339984-2-jolsa@kernel.org>
In-Reply-To: <20240909074554.2339984-2-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 9 Sep 2024 16:44:09 -0700
Message-ID: <CAEf4Bza-aJQ_qzJxnzkE07xn66TppVLO6t5ps_AOjO3eFaiQqA@mail.gmail.com>
Subject: Re: [PATCHv3 1/7] uprobe: Add support for session consumer
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 12:46=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support for uprobe consumer to be defined as session and have
> new behaviour for consumer's 'handler' and 'ret_handler' callbacks.
>
> The session means that 'handler' and 'ret_handler' callbacks are
> connected in a way that allows to:
>
>   - control execution of 'ret_handler' from 'handler' callback
>   - share data between 'handler' and 'ret_handler' callbacks
>
> The session is enabled by setting new 'session' bool field to true
> in uprobe_consumer object.
>
> We use return_consumer object to keep track of consumers with
> 'ret_handler'. This object also carries the shared data between
> 'handler' and and 'ret_handler' callbacks.

and and

>
> The control of 'ret_handler' callback execution is done via return
> value of the 'handler' callback. This patch adds new 'ret_handler'
> return value (2) which means to ignore ret_handler callback.
>
> Actions on 'handler' callback return values are now:
>
>   0 - execute ret_handler (if it's defined)
>   1 - remove uprobe
>   2 - do nothing (ignore ret_handler)
>
> The session concept fits to our common use case where we do filtering
> on entry uprobe and based on the result we decide to run the return
> uprobe (or not).
>
> It's also convenient to share the data between session callbacks.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

Just minor things:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  include/linux/uprobes.h                       |  17 ++-
>  kernel/events/uprobes.c                       | 132 ++++++++++++++----
>  kernel/trace/bpf_trace.c                      |   6 +-
>  kernel/trace/trace_uprobe.c                   |  12 +-
>  .../selftests/bpf/bpf_testmod/bpf_testmod.c   |   2 +-
>  5 files changed, 133 insertions(+), 36 deletions(-)
>

[...]

>  enum rp_check {
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 4b7e590dc428..9e971f86afdf 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -67,6 +67,8 @@ struct uprobe {
>         loff_t                  ref_ctr_offset;
>         unsigned long           flags;

we should shorten flags to unsigned int, we use one bit out of it

>
> +       unsigned int            consumers_cnt;
> +

and then this won't increase the size of the struct unnecessarily

>         /*
>          * The generic code assumes that it has two members of unknown ty=
pe
>          * owned by the arch-specific code:
> @@ -826,8 +828,12 @@ static struct uprobe *alloc_uprobe(struct inode *ino=
de, loff_t offset,
>

[...]

>         current->utask->auprobe =3D NULL;
>
> -       if (need_prep && !remove)
> -               prepare_uretprobe(uprobe, regs); /* put bp at return */
> +       if (ri && !remove)
> +               prepare_uretprobe(uprobe, regs, ri); /* put bp at return =
*/
> +       else
> +               kfree(ri);

maybe `else if (ri) kfree(ri)` to avoid unnecessary calls to kfree
when we only have uprobes?

>
>         if (remove && has_consumers) {
>                 down_read(&uprobe->register_rwsem);
> @@ -2160,15 +2230,25 @@ static void handler_chain(struct uprobe *uprobe, =
struct pt_regs *regs)
>  static void
>  handle_uretprobe_chain(struct return_instance *ri, struct pt_regs *regs)
>  {
> +       struct return_consumer *ric =3D NULL;
>         struct uprobe *uprobe =3D ri->uprobe;
>         struct uprobe_consumer *uc;
> -       int srcu_idx;
> +       int srcu_idx, iter =3D 0;

iter -> next_ric_idx  or just ric_idx?

>
>         srcu_idx =3D srcu_read_lock(&uprobes_srcu);
>         list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
>                                  srcu_read_lock_held(&uprobes_srcu)) {
> +               /*
> +                * If we don't find return consumer, it means uprobe cons=
umer
> +                * was added after we hit uprobe and return consumer did =
not
> +                * get registered in which case we call the ret_handler o=
nly
> +                * if it's not session consumer.
> +                */
> +               ric =3D return_consumer_find(ri, &iter, uc->id);
> +               if (!ric && uc->session)
> +                       continue;
>                 if (uc->ret_handler)
> -                       uc->ret_handler(uc, ri->func, regs);
> +                       uc->ret_handler(uc, ri->func, regs, ric ? &ric->c=
ookie : NULL);
>         }
>         srcu_read_unlock(&uprobes_srcu, srcu_idx);
>  }

[...]

