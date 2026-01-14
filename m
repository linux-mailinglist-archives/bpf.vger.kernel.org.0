Return-Path: <bpf+bounces-78846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6424D1CA77
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 07:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 666543029B80
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 06:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A475F326933;
	Wed, 14 Jan 2026 06:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFNXONgZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8B633B6C7
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 06:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768371523; cv=none; b=Bcim6oWFbpBBr8FhBJThh2+K8aTsAxH5xnDOncWGCJx9/NGvUn+J/Nw4rq2DiDxUu16BsdAJmiDxDWUPWiZpEMLL0ofWfq8k/i2MDSrUJ5JGGOcKkWxvDZUZ1Wte9cOBQu8kGQPl4hzq4/ZTmAz36z0zsoZMrQP1RvXjoOs2GLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768371523; c=relaxed/simple;
	bh=clNpslq5ijBOI5A2tm/usi5tDYC+ESDLpBpGDtp4m8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PLbdLcwh3cWBelN2zbxzoNlOYfpIod/5+eTO4k8sL4oHzdxrXqfPVeVXMs5th/gLrJSYXeeM8h+oh/nAQ+DcSftyVbOkeEKUTJPnqSTZlcCcau6KZwh8NuO9EwDNMuvQ9no+n1+9fKhfgeDoaeIBcvvIUNhhWyO+0bGJrgRglTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFNXONgZ; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-12339e2e2c1so7099c88.1
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 22:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768371504; x=1768976304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjBxkaqSZJtmI8IUKVCM6gYETHbHEi7hreoNNxicvxw=;
        b=NFNXONgZ0yhzB88pTvIvsf58llypwEtxB0nhrmw80pljJXOCxBKjYymN61AWiE1u9b
         V6TfBw2An14TnlJAd1gMiDc8DGhwIJc5mOF5sd3gW2JlEZXUcjUGa0F81z8+i7uFXa1d
         cD/TVncOL0IH1RyEy0XjhHT7fTfuUW2LXoCaYh8qXysaeYdmRE0Z4+b23lztlqd336qK
         d5DngQZyA5FPus5b+dd3gyXdJT+9gKdOb/AEpqJienzxW/uTixzx1YhTuFWEUwjpw13A
         nutC/J453joz7rPoF4qQb7wsn72+zLPy5z8Nb4nLhCmqu+olZxa+h/8K3v8XLrDSuQq0
         /g6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768371504; x=1768976304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NjBxkaqSZJtmI8IUKVCM6gYETHbHEi7hreoNNxicvxw=;
        b=oL2bjWhyuEp4Gvk2QcpvkIdmpp7S9ZeljgqkJj+6POgMiMAz1xYwRbIAenbDkRdZW8
         7Tz9lrwVFfTTjGJsFPX69+Z3VbT5q1psH2pXLrveYnFkxEEOLc2RuB6vPfeflS1Ym0rI
         u9+5Z4rxFPec73agaISCkwRC0X4W99OkLlQ0G7xvlGnWrXqqResCfzvUndIJnIbyqTyb
         7zgNkaIVsZHeDlpJXcSB0LquFz/ZnpHfowXESGVCBZP99V3qjDDQF13glGs3c70iRbKg
         EAixBfBJ4JkuIJ885jdwWej65lGXvYeY7a6XkT1Lsk5jAhaPn+jU0Fkc4gxkeukE6ByX
         jWaA==
X-Gm-Message-State: AOJu0YyKJ9aD/7vRbJcpXbjXAOvgmpGiLTbAza74a3/sf/b7ajTPkKK1
	8vF7MtyAidQMLHlXV5CXGN+MiPErZhxJoKrO/0ELgZHXw8gmoMFs1S/lCy5QrYcxe7So9UVRL1q
	q8ookR99M2I4QbHePyb0bS3OjrvjL2Pw=
X-Gm-Gg: AY/fxX7QpKLergaylpSSDkGskLr7paSPP5A/EQoY9nyK8WUcxo9b2y4G/tJazGlhbfO
	LY9do5YELRF5POqIED54zzAJNnQXZr7U4fghhXYWERdPlwFrL2TNNtMlFVn+jo0Liqymc6PwbUX
	G98UHpxyP7ItcodlzdQLL/tkHQdT7cfvA61PcMkVwr8v3GnChND8LZr8RBdYsxkboDcpYzsp4ac
	x2XLNwHBn87bMsXeUlY+9OuQ1e32O6LZizj5cehK0+t7hnXmlHCXBWiLzNKw5MoM2+gL8mueFOr
	apzloIc=
X-Received: by 2002:a05:701b:231a:b0:11b:9386:a383 with SMTP id
 a92af1059eb24-12336aafea9mr1292835c88.22.1768371504531; Tue, 13 Jan 2026
 22:18:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114045509.1281217-1-saiaunghlyanhtet2003@gmail.com> <17dcbb5af344c64488806ab2e291d4d7a0de3c51b8d9b0478bb1f0106a584530@mail.kernel.org>
In-Reply-To: <17dcbb5af344c64488806ab2e291d4d7a0de3c51b8d9b0478bb1f0106a584530@mail.kernel.org>
From: Sai Aung Hlyan Htet <saiaunghlyanhtet2003@gmail.com>
Date: Wed, 14 Jan 2026 15:18:13 +0900
X-Gm-Features: AZwV_Qi8wCT_ok_yzffNsUzGGwwG4eOcdtdj552inJPzrpEf3gLKyb96CVsFhLo
Message-ID: <CAGF5Uf5tRdt0Bpky+53AursJNAj1Q6-+0jkm2SQxxK-eAv=Nzw@mail.gmail.com>
Subject: Re: [bpf-next,v2] bpf: cpumap: report queue_index to xdp_rxq_info
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, netdev@vger.kernel.org, andrii@kernel.org, 
	martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev, 
	clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

That makes sense. Reverted the changes in veth.c in v3.

On Wed, Jan 14, 2026 at 2:18=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> > index 14e6f2a2fb77..4a409802cdac 100644
> > --- a/drivers/net/veth.c
> > +++ b/drivers/net/veth.c
> > @@ -648,6 +648,8 @@ static struct xdp_frame *veth_xdp_rcv_one(struct ve=
th_rq *rq,
> >
> >               xdp_convert_frame_to_buff(frame, xdp);
> >               xdp->rxq =3D &rq->xdp_rxq;
> > +             /* Preserve original queue_index from frame */
> > +             rq->xdp_rxq.queue_index =3D frame->queue_index;
>                 ^^^^^^^^^^^^^^^^^^^^^^^^
>
> Unlike cpumap.c and devmap.c which use a stack-local rxq variable,
> this writes to the persistent rq->xdp_rxq structure.
>
> In veth_poll(), the code reads queue_index before calling veth_xdp_rcv():
>
>     int queue_idx =3D rq->xdp_rxq.queue_index;
>     ...
>     peer_txq =3D peer_dev ? netdev_get_tx_queue(peer_dev, queue_idx) : NU=
LL;
>     ...
>     done =3D veth_xdp_rcv(rq, budget, &bq, &stats);
>
> After processing a frame from a device with many queues (e.g. queue 32),
> the next poll will read the corrupted queue_index and pass it to
> netdev_get_tx_queue(). If the peer device has fewer TX queues, this
> causes an out-of-bounds access to dev->_tx[].
>
> For comparison, cpumap.c uses a local variable:
>
>     struct xdp_rxq_info rxq =3D {};
>     ...
>     rxq.queue_index =3D xdpf->queue_index;
>
> Should veth also use a local rxq variable like cpumap and devmap do,
> rather than modifying the persistent rq->xdp_rxq?
>
> > [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/209830=
17884

