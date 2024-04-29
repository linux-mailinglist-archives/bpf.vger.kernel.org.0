Return-Path: <bpf+bounces-28134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD3C8B6066
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 19:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0318D1F21C2C
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 17:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC641272D3;
	Mon, 29 Apr 2024 17:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1RNBdGO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD69080630
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412858; cv=none; b=uWEVx+WUEJWQ5BGHzyuudJ5F9utgYEU/U4qx4PltbY5fnyKNxnG0kjj0gvKAhtzP2+zf+lcpogJxYvGHesb94zGoDtPtAJ5zu2NrFaE/lXy9RkpAgojdLUdfvGKoPLlhYIzfGu3OR+3k9QacXUwY7lqq+MhZLq7m3vGmCHd8y2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412858; c=relaxed/simple;
	bh=tl20B2NOMxl+1JvcoAV/vDVMSuDkR7vlzv/o5pCrurQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A+NDE9YwuGWaZWNV8LMgAu2LSkiFhteQWKv74cTKQ93JwcEk8sXCGIeS0tX/qwRGci+rSaGZaO428uYKbApX+qT5jZKcvw9L596UCSw2RDbowggS2yJi6AgXyFE2tTMan+nTTYcwhNm8Cz18S+/085qOP7A0jcSRwAyctl/18bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1RNBdGO; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-a5557e3ebcaso786911366b.1
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 10:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714412855; x=1715017655; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JvUdI/dQlgqIPT71ZqNCCHfLQBi8fh1iDexJvlf1vAU=;
        b=J1RNBdGONe5DS9apt+p1ynCHwBTrkkmIv+5yY2yvghmydM8LkPZFkLPDV7z/mlvGBV
         lXDlsiUxCHrgGYOHm++aw233aZ8yAsA6qD4cHeJEixxFLDxYXPlX7DdgVyhr2bDhZfVP
         M3PtlHy9BXM1rGORWBGk/tMITfqwfHkGbDoVdUY1bKQPXl4urxmvVPUBCu952y/867F0
         W5hxNIj4VnymgUVCPhzhtiTdZ5LicYEpJrBSb96AEDPHB0krQQ3TYjK8hMJdPFCxCGzR
         zkSDPwzf8y3xczCNULBobyyNWwJEZ7rnoltTzEPP5QzZ5FKHx+WdO+ZawgVEq7eOt9gF
         Oq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714412855; x=1715017655;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JvUdI/dQlgqIPT71ZqNCCHfLQBi8fh1iDexJvlf1vAU=;
        b=siRcWm00VW4oHoTwVAbMMEtpLHmFK0/tEddSGZjMIfnAalQVFxrt5neorQCwyexKBv
         oFGf6+6MGILZ/KKITRTgib4ui2aPGtv9nYORhhUyM3oVzZUt5t5LjAgd/gEkVeDePund
         Mck3Rrs/bX+ewNPaM+F1vKeoGxSAeCYy5RZXOiuL3sz+qzQd//62Chh63jYraI7w3+RQ
         SroFSRtrSWvdo3zdgN0RW/V2w9r9AbCODv6qWl2M2Tem0t9aUZDIg1+K2g3U316xq3g8
         oWIuP/bjH2wENEY58gGYpL1b9QcRrMWIRGZEM1tFR3EUXQS7aVfgZVBHHMezCQWejM0N
         xGJA==
X-Gm-Message-State: AOJu0Yz1FAvXfkXkSmuMvFhIAyEOmtv4LcsI6ZRui0XwW01D8K97P5yW
	xzt6edNWHJTsCuWABhTq+5J1vxnzRbW/R4q+T0ZUOOiqL/UtY6qSB1c9eFJ3aYEHyCUdIgR5s13
	6fkh96nQTwlo5zu0BXBgGKR3TevE=
X-Google-Smtp-Source: AGHT+IHYEZ/9b4fgq5B0GGLttxzTCQeDdn6dlVD5fCs/65tCj6n1S6DiRc4KA3juTT46TrTYEMm8qgfwMyljvRsNUHM=
X-Received: by 2002:a17:906:4151:b0:a58:c54c:9bb8 with SMTP id
 l17-20020a170906415100b00a58c54c9bb8mr327077ejk.6.1714412854767; Mon, 29 Apr
 2024 10:47:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429165658.1305969-1-sidchintamaneni@gmail.com>
In-Reply-To: <20240429165658.1305969-1-sidchintamaneni@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 29 Apr 2024 19:46:58 +0200
Message-ID: <CAP01T74N=Lk5Yc0LT1xF9_mZfeizmfGv1Bg5R9EVfwcMiddQOA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] Patch to Fix deadlocks in queue and stack maps
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, daniel@iogearbox.net, 
	olsajiri@gmail.com, andrii@kernel.org, yonghong.song@linux.dev, rjsu26@vt.edu, 
	sairoop@vt.edu, Siddharth Chintamaneni <sidchintamaneni@vt.edu>, 
	syzbot+8bdfc2c53fb2b63e1871@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Apr 2024 at 18:57, Siddharth Chintamaneni
<sidchintamaneni@gmail.com> wrote:
>
> From: Siddharth Chintamaneni <sidchintamaneni@vt.edu>
>
> This patch address a possible deadlock issue in queue and
> stack map types.
>
> Deadlock could happen when a nested BPF program
> acquires the same lock as the parent BPF program
> to perform a write operation on the same map as
> the first one. This bug is also reported by
> syzbot.
>
> Link: https://lore.kernel.org/lkml/0000000000004c3fc90615f37756@google.com/
> Reported-by: syzbot+8bdfc2c53fb2b63e1871@syzkaller.appspotmail.com
> Fixes: f1a2e44a3aec ("bpf: add queue and stack maps")
> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@vt.edu>
> ---
>  kernel/bpf/queue_stack_maps.c | 42 +++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.c
> index d869f51ea93a..4b7df1a53cf2 100644
> --- a/kernel/bpf/queue_stack_maps.c
> +++ b/kernel/bpf/queue_stack_maps.c
> @@ -18,6 +18,7 @@ struct bpf_queue_stack {
>         raw_spinlock_t lock;
>         u32 head, tail;
>         u32 size; /* max_entries + 1 */
> +       int __percpu *map_locked;
>
>         char elements[] __aligned(8);
>  };
> @@ -78,6 +79,16 @@ static struct bpf_map *queue_stack_map_alloc(union bpf_attr *attr)
>
>         qs->size = size;
>
> +       qs->map_locked = bpf_map_alloc_percpu(&qs->map,
> +                                               sizeof(int),
> +                                               sizeof(int),
> +                                               GFP_USER);

GFP_USER | __GFP_NOWARN, like we do everywhere else.

> +       if (!qs->map_locked) {
> +               bpf_map_area_free(qs);
> +               return ERR_PTR(-ENOMEM);
> +       }
> +
> +
>         raw_spin_lock_init(&qs->lock);
>
>         return &qs->map;
> @@ -98,6 +109,16 @@ static long __queue_map_get(struct bpf_map *map, void *value, bool delete)
>         int err = 0;
>         void *ptr;
>
> +       preempt_disable();
> +       local_irq_save(flags);
> +       if (unlikely(__this_cpu_inc_return(*(qs->map_locked)) != 1)) {
> +               __this_cpu_dec(*(qs->map_locked));
> +               local_irq_restore(flags);
> +               preempt_enable();
> +               return -EBUSY;
> +       }
> +       preempt_enable();
> +

You increment, but don't decrement the map_locked counter after unlock.
Likewise in all other cases. Then this operation cannot be called
anymore after the first time on a given cpu for a given map.
Probably why CI is also failing.
https://github.com/kernel-patches/bpf/actions/runs/8882578097/job/24387802831?pr=6915
returns -16 (EBUSY).
E.g. check hashtab.c, it does __this_cpu_dec after unlock in htab_unlock_bucket.

>  [...]
>
>

