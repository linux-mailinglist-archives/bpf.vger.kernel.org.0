Return-Path: <bpf+bounces-5090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E19DC756223
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 13:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78FDC2811A0
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 11:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AA4AD36;
	Mon, 17 Jul 2023 11:58:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F676A92C
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 11:58:35 +0000 (UTC)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EF2A6
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 04:58:33 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-635dccdf17dso27765366d6.3
        for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 04:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689595113; x=1692187113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FElTA90aZB+GGK1mLeVATffT7OfMQNTXF7LmwH/0Mlc=;
        b=mPY6XrnQsHQPxhtutUgpGWMJF1nGZN0c9syPjzdUZGv/1n4FRsui+AjWL/4Nd4q+jc
         hP2F9IGWYuC8q6Dy5Cp2As8nRUinSbskP75pgEF8iljlmL0iqX78zMHByV9A/a1awS4f
         +AyC4z+3YjhrmRB89lb04F8GRKqcI4LyJ0wADfjGVcD7HpbCNHyQpvkvX/ELxP1Suv7M
         YMTqm+h0mHAqCejtR+pLRntm6S6E5nNVp6m2ikzMNRgLHYHP/kUeOXUHNboHIqKTO1+K
         2rZuDi3aSkRVklZjy2BETiP6juOK9ZDl2QQW7vhblvQmYRr5945/3PIUmpwHyRk0Hdyn
         UU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689595113; x=1692187113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FElTA90aZB+GGK1mLeVATffT7OfMQNTXF7LmwH/0Mlc=;
        b=DmH62apPDmX4LAZtEuG4KGrxrfx3MZtZHYM/lsgKKA7m4nYwy8f0lZBIydD+Y8BNTf
         ATN6bvxH0yfQPHwMp+LaqOryrG5X8N6BHlVyq0QN95+SbuCwjBRIvriBr31NBDd7TT1V
         C53Vig2b6sMZxf/W+v7fYkcmxjcMzX9VKOnWJ+ByfoZceVFzMtxjYzvmlVq/yXuuI5d6
         k95dNL6jLC4XQV4K4tU9Z1iZVwapJ4bKFJFqal4E/MqLBIfWN7Lm+UaXWlIFQmy53ZCV
         axPVpU1b4h4/CZNvOslY2AQm9USSO9pY81ov2J6H3/WZ0cNDqaKFacadObzAsNBkpdTe
         PpJQ==
X-Gm-Message-State: ABy/qLb7GRJkIq4KyzashuYFkH+YGx0v6vZpPK/rmyWOA9oUmVaS/RSy
	drFDqEdJpY/eM0hsEpyeiAJiqJhm9JnHeRssCw/FtDfcmvcvDQ==
X-Google-Smtp-Source: APBJJlFuLMgQPxR/kxrZXJTQQCMnNfIEctuoSSIOK8y3E5O1w/z9S25Ry/QHV9VPy1AqYuEE6w2wgoAS1xsz76ND2cs=
X-Received: by 2002:a0c:e191:0:b0:635:f2a4:9543 with SMTP id
 p17-20020a0ce191000000b00635f2a49543mr10964350qvl.25.1689595113041; Mon, 17
 Jul 2023 04:58:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <85697a7e-f897-4f74-8b43-82721bebc462@kili.mountain>
In-Reply-To: <85697a7e-f897-4f74-8b43-82721bebc462@kili.mountain>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 17 Jul 2023 19:57:57 +0800
Message-ID: <CALOAHbAXSj4mb5AWTbQBz217Kz8TJeJOXU9TuoLg90iUvBP3Nw@mail.gmail.com>
Subject: Re: [bug report] bpf: Support ->fill_link_info for perf_event
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 17, 2023 at 5:14=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> Hello Yafang Shao,
>
> The patch 1b715e1b0ec5: "bpf: Support ->fill_link_info for
> perf_event" from Jul 9, 2023, leads to the following Smatch static
> checker warning:
>
>         kernel/bpf/syscall.c:3416 bpf_perf_link_fill_kprobe()
>         error: uninitialized symbol 'type'.

Thanks for your report !

>
> kernel/bpf/syscall.c
>     3402 static int bpf_perf_link_fill_kprobe(const struct perf_event *ev=
ent,
>     3403                                      struct bpf_link_info *info)
>     3404 {
>     3405         char __user *uname;
>     3406         u64 addr, offset;
>     3407         u32 ulen, type;
>     3408         int err;
>     3409
>     3410         uname =3D u64_to_user_ptr(info->perf_event.kprobe.func_n=
ame);
>     3411         ulen =3D info->perf_event.kprobe.name_len;
>     3412         err =3D bpf_perf_link_fill_common(event, uname, ulen, &o=
ffset, &addr,
>     3413                                         &type);
>     3414         if (err)
>     3415                 return err;
> --> 3416         if (type =3D=3D BPF_FD_TYPE_KRETPROBE)
>
> It looks like you could call bpf_get_perf_event_info() without it
> initializing *fd_type to anything.

It can only happen when uname=3D=3DNULL.  So I think the change below can f=
ix it.

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ee8cb1a..3c29211 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3374,16 +3374,16 @@ static int bpf_perf_link_fill_common(const
struct perf_event *event,
        size_t len;
        int err;

-       if (!ulen ^ !uname)
-               return -EINVAL;
-       if (!uname)
-               return 0;
-
        err =3D bpf_get_perf_event_info(event, &prog_id, fd_type, &buf,
                                      probe_offset, probe_addr);
        if (err)
                return err;

+       if (!ulen ^ !uname)
+               return -EINVAL;
+       if (!uname)
+               return 0;
+
        if (buf) {
                len =3D strlen(buf);
                err =3D bpf_copy_to_user(uname, buf, ulen, len);


>  Meanwhile if you initialize it to
> zero here, that won't even affect the compiled code at all because
> everyone zeroes stack data these days.
>
>     3417                 info->perf_event.type =3D BPF_PERF_EVENT_KRETPRO=
BE;
>     3418         else
>     3419                 info->perf_event.type =3D BPF_PERF_EVENT_KPROBE;
>     3420
>     3421         info->perf_event.kprobe.offset =3D offset;
>     3422         if (!kallsyms_show_value(current_cred()))
>     3423                 addr =3D 0;
>     3424         info->perf_event.kprobe.addr =3D addr;
>     3425         return 0;
>     3426 }
>
> regards,
> dan carpenter



--=20
Regards
Yafang

