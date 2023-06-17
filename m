Return-Path: <bpf+bounces-2778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 736EB733DB5
	for <lists+bpf@lfdr.de>; Sat, 17 Jun 2023 05:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 302C028191D
	for <lists+bpf@lfdr.de>; Sat, 17 Jun 2023 03:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FBDA48;
	Sat, 17 Jun 2023 03:09:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE96CA28
	for <bpf@vger.kernel.org>; Sat, 17 Jun 2023 03:09:28 +0000 (UTC)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5293A82;
	Fri, 16 Jun 2023 20:09:27 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-62fe192f7d3so12536566d6.3;
        Fri, 16 Jun 2023 20:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686971366; x=1689563366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1sjNGPmC7TxHhfMe6BQUANKBjOLnZQghcSlulcKAYCQ=;
        b=AFBb+p8z8MqerObmKvkyP8DzetJP+hzrqKBZHx/VIdcoIn2Kj2lGZCQiGWno77vX0K
         it6Z3fJ80Ac6F3FJr6GNnukfdvCQuvH0rZijBojw7b/HBv6pzxbBhWh5KhSCaHudGlEn
         YXJMtb+9+QRhJ7re66ORMCzgZBVg0pd91dR7X+iVKljWYJ/0JhLH06YWY2IqXXrutbC4
         mdkqjpPFg2/JjqD3LLEUxEnXFtq6e9ShqlbaF9QabmBd1RPuPFOQIQJ4SbM6zx3sBcAD
         f94AdjbacJOTboW5QtOP0AYNTzGrDJgSio3Sv+O+5vE4L70+v07C8vCWRgKrfdJOwqYM
         +g0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686971366; x=1689563366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1sjNGPmC7TxHhfMe6BQUANKBjOLnZQghcSlulcKAYCQ=;
        b=Ug/PBWABw7U6Y+Uw1f1p7GIUM9JXXpfpRU7m/uqazU9vyhc3vlZ4XHnka9m6C6lq2J
         9ab1trIJn1ClqpgRz7P5ut0POTP7q6kby53nEep0TDefawvNDsvUcvO28XEaKCZWnd3W
         Hgpqxlt2Sn2TtOcwX2eCI/6IurZUVmqMHO8l8yNkj1dQayD2TFZ4OnIAGp5KpOsp4iAI
         VN673RO4plIXBOJN2F+6Q/YLswPMuFw00uCS7N/zHHy29xV/ZjBBGPCSv7BFZLKQpF2y
         ARc4wxcsLpg0G16ogugdF7eDc6r88x5U1/CTn1/JmkEkv/idRU7WnVSJ6W+SGoy4xlrm
         c1Yw==
X-Gm-Message-State: AC+VfDzBlA41ZsavAN93iCRXw9ZFXqBC+3dLpSJ9dL9KdNN54Nl3jKA6
	QMpQm3UGWAmVsgs2Qzn52lhUUJN7nfGuKKZIM98=
X-Google-Smtp-Source: ACHHUZ76dl1QNxERJsPH8jtTJeKoPK6b5LC1uDp3k9pSCHtRi2fPAvOW9uZRt1zrMpLKE7Y2PMu7RutRF1e1kfk/iLU=
X-Received: by 2002:a05:6214:1306:b0:628:2e08:78b7 with SMTP id
 pn6-20020a056214130600b006282e0878b7mr5714541qvb.31.1686971366439; Fri, 16
 Jun 2023 20:09:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230612151608.99661-1-laoar.shao@gmail.com> <20230612151608.99661-4-laoar.shao@gmail.com>
 <CAEf4BzaZEb_Uz21WDmQr7UC8Q50EfHDr2=dK477Z8fGEinCZ7w@mail.gmail.com>
In-Reply-To: <CAEf4BzaZEb_Uz21WDmQr7UC8Q50EfHDr2=dK477Z8fGEinCZ7w@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sat, 17 Jun 2023 11:08:50 +0800
Message-ID: <CALOAHbC=fJfsE=r=o87sT36gq_OP-rLGv4yb-BuTxadu1KQ-pw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 03/10] bpftool: Show probed function in
 kprobe_multi link info
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	quentin@isovalent.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jun 17, 2023 at 1:30=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Jun 12, 2023 at 8:16=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > Show the already expose kprobe_multi link info in bpftool. The result a=
s
> > follows,
> >
> > 52: kprobe_multi  prog 381
> >         retprobe 0  func_cnt 7
> >         addrs ffffffff9ec44f20  funcs schedule_timeout_interruptible
> >               ffffffff9ec44f60        schedule_timeout_killable
> >               ffffffff9ec44fa0        schedule_timeout_uninterruptible
> >               ffffffff9ec44fe0        schedule_timeout_idle
> >               ffffffffc09468d0        xfs_trans_get_efd [xfs]
> >               ffffffffc0953a10        xfs_trans_get_buf_map [xfs]
> >               ffffffffc0957320        xfs_trans_get_dqtrx [xfs]
> >         pids kprobe_multi(559862)
> > 53: kprobe_multi  prog 381
> >         retprobe 1  func_cnt 7
> >         addrs ffffffff9ec44f20  funcs schedule_timeout_interruptible
> >               ffffffff9ec44f60        schedule_timeout_killable
> >               ffffffff9ec44fa0        schedule_timeout_uninterruptible
> >               ffffffff9ec44fe0        schedule_timeout_idle
> >               ffffffffc09468d0        xfs_trans_get_efd [xfs]
> >               ffffffffc0953a10        xfs_trans_get_buf_map [xfs]
> >               ffffffffc0957320        xfs_trans_get_dqtrx [xfs]
>
> it all subjective, but this format is a bit weird where "addrs" and
> "funcs" is in first row to the left. Just makes everything wider. Why
> not something like
>
> addr              func
> ffffffff9ec44f20  schedule_timeout_interruptible
> ffffffff9ec44f60  schedule_timeout_killable
> ffffffffc0953a10  xfs_trans_get_buf_map [xfs]
> ffffffffc0957320  xfs_trans_get_dqtrx [xfs]

It may be a little strange if there's only one function, but I don't
mind doing it as you suggested.

>
> Not it's singular (addr and func) because it's column names,
> basically. Can also do "addr func [module]".

The length of the function name is variable, so it is not easy to
determine where to put the "[module]". So I prefer to not show  the
"[module]".

--=20
Regards
Yafang

