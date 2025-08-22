Return-Path: <bpf+bounces-66268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE71B3108B
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 09:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 028405E6AD8
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 07:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C8C2E8B88;
	Fri, 22 Aug 2025 07:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpEjo6Gk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8702853EE;
	Fri, 22 Aug 2025 07:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755848091; cv=none; b=lk0PsuKmlPnB5EM6EXuDXn0BJLCe2dgHxRLFGaQ01X+EqNhuTM1LJ+q1j3iyVg00nO5MjziHGNXVVb85c/l9x9vPHe8QdbWPirx3NS2fkvsQScVxPXb7IRJ6H907en7IoxIcKtxgdRgyX2dbRzzfupJ/SvagxRE3JQIHO5rMtkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755848091; c=relaxed/simple;
	bh=2xBYT1+b6a+4DabM1ACK+FFlS4lfo+m61Cj2V1cXnMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YHBcl++Udrck1AeTp6D/kVOUN7pFeEFvzc2YoYoypqnFe39Ycsz4uXWa6X3R42NseugMx5ayuvtlxeMfkMo6Kj5AxZnaX4IdPIdVuBIaxgEHtBmfjhrtv/Dk9uWj3yPTkLPTWtmEAHgDgRvtSBNvms04ygDR/gkB1BToOgG1/eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpEjo6Gk; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-70d9f5bdf7aso1063106d6.0;
        Fri, 22 Aug 2025 00:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755848088; x=1756452888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9QNj52oQIc5n631u+3FP7RSxMMik50RPo8yvFfA/24=;
        b=TpEjo6GktPYA9HFogo4lrtZlnyi/wB69KifV2iejC5LjVsdQlOdgbRm5kAs7VpDnAL
         IX9TAOkZ49MydrWMIybZEa1z8LGDH8z94A8n/nA77R1UDgjVaz7IbWPLPmKpiqAjLlDg
         pqdSBFE5B/K2wKnuvmafjeu0IrAGzb/MjyReivfg4d8kw7Sqew471FXiAb/KOFXLHrxa
         w1vAJZurUH2b2R3Rpkk2mRccF+yaQtcnhgNUr11xIpkE8botfRADwI4Zk7+b12JM8jYs
         zDChtaNUAurZEBprNQ9PLDvY7LWVEm/7a7tsL/NXHri11oybgdV2j9wPwVKCIU2z5d8M
         ARYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755848088; x=1756452888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P9QNj52oQIc5n631u+3FP7RSxMMik50RPo8yvFfA/24=;
        b=WelAGjF3IH8LzGg68zdslKgoGGFpKHcsXkF1qwjQ95+1fmSyGI1e+vRWApWXSMxoou
         aBDdBdurY5UHsQulGMnJYOQkHgUFTfqN6N1M3/KnTyViMbvoKiXBfDyzFew3fLf+k5VD
         HtrTGzCc4yFjLTcCgqfmHjiGiXxLYHIooLUAD/w/1xF3o2zzhkb5jj5wS4S7ZeWMhcJP
         jQJ/AZHnQljVsw99SSmtHNLI9PpL8cXt/woZ6mhuxADpt9BOMkGWtl/zdGhC8tPbBjc4
         QNFiM9bN8vSQwL8q/J+OT1n5A7qgi9zXUvgSlrTBSPmjf6lRRKavMaMIHpWIaYlh7Jo2
         oBgg==
X-Forwarded-Encrypted: i=1; AJvYcCVUJ0alfmZNjjX/85VPUCVDaXYrzL+w53dbIQScpvkCKBQY4X2iOSl9edx89mvuq4rNsk8=@vger.kernel.org, AJvYcCXpMjArQYf4UtmTf9DEvNdw8xPAvIHPx+4i73xAfLUiSCxks5O9+P2vaqHcF0ZMqa9n/xaSv72V@vger.kernel.org
X-Gm-Message-State: AOJu0YxoWAyt9DW02s5d4cvUSLdWduEKpxQW8zDETFU7FadTlMCPDrap
	5j/7S5IybGkb3Ba793thQ6g17tEVgOaE9wbvBBTiD8032V3iMbNlSPH8zfxkgVMh7eGCURilfWE
	sgv0tfFRnBMQQWTkEjrduS9oY8cLIV8I=
X-Gm-Gg: ASbGncu5ycJbUFuUr5lxjjI/vGX3XL0+GtUV0liN0+f7S28UvPE/w3uCFir6FC/msCr
	jpYzzIAygPyu14lOgrlefc5OKYpCIOj/FuFXVYlR4Fo3qRVBfVK9bS7pTUE5SwbsdVHsMfx6Lw5
	9T+oJPMMBWE3QVnZSK76x0L/QYOJba1M44LkQ1ieU8mxeLUNrpO5yw3ta9Vn2DyYb+DlZ9bUpU9
	o6eAkqwuM8EVLcxIvg5H+h989p0OJXo+1HFh5Xj
X-Google-Smtp-Source: AGHT+IHRVHZoZ+oMihsJNK23qe6RMS4OZ8SkR5nu3STB9p8OwRWAeMbGVk5j//8BP8G0AUNBVIXcDVj+PBF43EAtuPE=
X-Received: by 2002:ad4:5ccf:0:b0:709:dd30:fc7b with SMTP id
 6a1803df08f44-70d971c47b6mr22120876d6.38.1755848088307; Fri, 22 Aug 2025
 00:34:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822064200.38149-1-laoar.shao@gmail.com> <87303e90-3c74-4e4f-8fac-2001d82b90d8@blackwall.org>
In-Reply-To: <87303e90-3c74-4e4f-8fac-2001d82b90d8@blackwall.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 22 Aug 2025 15:34:10 +0800
X-Gm-Features: Ac12FXwpMDW-Xvt5O9Y7sexMCqpcKd6vdnzoDdolwazgXwEU9eUOCbicJLJp4f4
Message-ID: <CALOAHbDoT8kmfbM9EnRcLP2o+2YpgN6ktn+p3UJMCeA=bOFopA@mail.gmail.com>
Subject: Re: [PATCH v2] net/cls_cgroup: Fix task_get_classid() during qdisc run
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, daniel@iogearbox.net, 
	bigeasy@linutronix.de, tgraf@suug.ch, paulmck@kernel.org, 
	netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 3:26=E2=80=AFPM Nikolay Aleksandrov <razor@blackwal=
l.org> wrote:
>
> On 8/22/25 09:42, Yafang Shao wrote:
> > During recent testing with the netem qdisc to inject delays into TCP
> > traffic, we observed that our CLS BPF program failed to function correc=
tly
> > due to incorrect classid retrieval from task_get_classid(). The issue
> > manifests in the following call stack:
> >
> >         bpf_get_cgroup_classid+5
> >         cls_bpf_classify+507
> >         __tcf_classify+90
> >         tcf_classify+217
> >         __dev_queue_xmit+798
> >         bond_dev_queue_xmit+43
> >         __bond_start_xmit+211
> >         bond_start_xmit+70
> >         dev_hard_start_xmit+142
> >         sch_direct_xmit+161
> >         __qdisc_run+102             <<<<< Issue location
> >         __dev_xmit_skb+1015
> >         __dev_queue_xmit+637
> >         neigh_hh_output+159
> >         ip_finish_output2+461
> >         __ip_finish_output+183
> >         ip_finish_output+41
> >         ip_output+120
> >         ip_local_out+94
> >         __ip_queue_xmit+394
> >         ip_queue_xmit+21
> >         __tcp_transmit_skb+2169
> >         tcp_write_xmit+959
> >         __tcp_push_pending_frames+55
> >         tcp_push+264
> >         tcp_sendmsg_locked+661
> >         tcp_sendmsg+45
> >         inet_sendmsg+67
> >         sock_sendmsg+98
> >         sock_write_iter+147
> >         vfs_write+786
> >         ksys_write+181
> >         __x64_sys_write+25
> >         do_syscall_64+56
> >         entry_SYSCALL_64_after_hwframe+100
> >
> > The problem occurs when multiple tasks share a single qdisc. In such ca=
ses,
> > __qdisc_run() may transmit skbs created by different tasks. Consequentl=
y,
> > task_get_classid() retrieves an incorrect classid since it references t=
he
> > current task's context rather than the skb's originating task.
> >
> > Given that dev_queue_xmit() always executes with bh disabled, we can sa=
fely
> > use in_softirq() instead of in_serving_softirq() to properly identify t=
he
> > softirq context and obtain the correct classid.
> >
>
> nit: you are no longer using in_softirq() in v2, you should update the
> commit message as well.

Oh, my bad.
I will update it.

--=20
Regards
Yafang

