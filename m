Return-Path: <bpf+bounces-20055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4FA837B22
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 01:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9979B2D74A
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 00:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D1C131750;
	Tue, 23 Jan 2024 00:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdc/tAPA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1587C130E42;
	Tue, 23 Jan 2024 00:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969087; cv=none; b=uGwd9SMZafa0uffcBylvuUzMXa93xmHFVERgrryScHg4Wjv5Y6FoLFf0DZqkiR7mExhAhvfmJHrFCr0Mv4D8dsa5K/g8FGVtVWdMWDVMcim32Bii1FdjyehyGwM5VmxxIG+PkYJ+oF4uuSfwt7CxxtWBimICiQaUKYGTZN6P4q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969087; c=relaxed/simple;
	bh=XsRAAQsPjyC7mAb+Rj2z59L5HzWedPqLWk2ITIOdKXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rx7GFiymXbD5z9DPdtFQ3F1eeI0p74tztbrMlkD6zaHAsL1/8ccn27EiI/456G0R6HCVV3WZ6yzLL/G5AB9sxnxEKBjJAPpFO+jFWwbeyeRYph1RSkTrhpVcLZVx/gVQ1pL5/d6Ku8V3suvFz7+aGVy+2TZQ/pEy3+byJr64ZBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdc/tAPA; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6ddef319fabso2468351a34.1;
        Mon, 22 Jan 2024 16:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705969085; x=1706573885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5tcut5oygY7UPZdDIt+xFB2Y78NvHfsic1L6PsWyUg=;
        b=cdc/tAPACzupPpbH5VORZ7hc7AnoJioLxaVG812Lz1fm8YGP03HTunaK/cwGoaFX32
         tjaBVnR06u/aJsNEIL/lyJUYj2Mqo56H328NCt1cr/XDM3QMro+BSlUJQ6Ao5UMqiL2w
         sDLe+yhxt4I2Fxdi2GQUH6zmieuASB0h4Jh1aDjc69kAvAM9GXdnWl+AjO+3hF0j4m9q
         Bdz3OGo9xzr87g4kLmNRAvQ0SlZZUGX3UcqLv7839bPi4L93ifoNhsyp1btEfrme9E++
         g8E4QoLxoxyBBGpkwQvRuZLk+HH10bHMj9cZnKrVN70U9SjQiTeJUOtdXxt5r1mUCogP
         Qwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969085; x=1706573885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5tcut5oygY7UPZdDIt+xFB2Y78NvHfsic1L6PsWyUg=;
        b=nbbR3/QT+Y+LGV1iNdUTdRlClvipzY2DHPliOoiNQlaaG7SB0+AJWJi9wVSJBOFMux
         usjEK0L0jlyHk0tvpq/OvnfLj/t5y4J9Ref9uKq+W/ui0HX2t4zvRS13EHN1aOaksl1U
         /v+h17YPyfF4widD37n6KWJaFwaGGP303vLGXcc8mVeI1HAtjX3/Fsrl5Sn+wCSgigNX
         imR+VHLAMoZMqeKol+4bz8BYzblmri8o0G+6Wl0Fwu8AKZl3BPDtHKHCLE/HsuR8mj9W
         qJu6kCgw1W3BL7ZgudxjEEC1IjqyTkXnUTPShp1nvvypgQijnSYreM6n8lwOmK6qx1Hw
         CTCQ==
X-Gm-Message-State: AOJu0YxdmiG019pAwlowvytaV8v9EFVzIM1smWMXAzK5LlWLScs0Ohb7
	0DKhttlZy6XKjrJhq2+Z2xjGdIx2b49yfiblnsEFou+xwXiPzlGBrxU5WC8Dl9lD1sn0H/DBanC
	ZvUz3uNp5sJFg1TxPeOI6KRSMy5Q=
X-Google-Smtp-Source: AGHT+IEt+nzuO0vPiyMVhwP8H+8gsOeo6E7KF9TNsThfFsGLL/wWzyOJFHqOCS8PKUYUzNOhmBo5Bba7NCqvFq8+wro=
X-Received: by 2002:a05:6358:6f0e:b0:176:25b:7af8 with SMTP id
 r14-20020a0563586f0e00b00176025b7af8mr1951748rwn.52.1705969084916; Mon, 22
 Jan 2024 16:18:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705432850.git.amery.hung@bytedance.com> <813b2de18b94389f4df53f21b8a328e1c2fdda13.1705432850.git.amery.hung@bytedance.com>
In-Reply-To: <813b2de18b94389f4df53f21b8a328e1c2fdda13.1705432850.git.amery.hung@bytedance.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 22 Jan 2024 16:17:52 -0800
Message-ID: <CAEf4BzaDCsVOBgCkZKPpM2RbsiKQMLToRaiYpBYejX=F5DncuA@mail.gmail.com>
Subject: Re: [RFC PATCH v7 6/8] tools/libbpf: Add support for BPF_PROG_TYPE_QDISC
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn, 
	toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, sdf@google.com, 
	xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 1:57=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> While eBPF qdisc uses NETLINK for attachment, expected_attach_type is
> required at load time to verify context access from different programs.
> This patch adds the section definition for this.
>
> Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> ---
>  tools/lib/bpf/libbpf.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index e067be95da3c..0541f85b4ce6 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8991,6 +8991,10 @@ static const struct bpf_sec_def section_defs[] =3D=
 {
>         SEC_DEF("struct_ops.s+",        STRUCT_OPS, 0, SEC_SLEEPABLE),
>         SEC_DEF("sk_lookup",            SK_LOOKUP, BPF_SK_LOOKUP, SEC_ATT=
ACHABLE),
>         SEC_DEF("netfilter",            NETFILTER, BPF_NETFILTER, SEC_NON=
E),
> +       SEC_DEF("qdisc/enqueue",        QDISC, BPF_QDISC_ENQUEUE, SEC_ATT=
ACHABLE_OPT),
> +       SEC_DEF("qdisc/dequeue",        QDISC, BPF_QDISC_DEQUEUE, SEC_ATT=
ACHABLE_OPT),
> +       SEC_DEF("qdisc/reset",          QDISC, BPF_QDISC_RESET, SEC_ATTAC=
HABLE_OPT),
> +       SEC_DEF("qdisc/init",           QDISC, BPF_QDISC_INIT, SEC_ATTACH=
ABLE_OPT),

seems like SEC_ATTACHABLE (or just 0) is what you want.
expected_attach_type shouldn't be optional for any new program type

>  };
>
>  int libbpf_register_prog_handler(const char *sec,
> --
> 2.20.1
>
>

