Return-Path: <bpf+bounces-1750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DA2720BD3
	for <lists+bpf@lfdr.de>; Sat,  3 Jun 2023 00:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 201DC281A2D
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 22:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B392CC15C;
	Fri,  2 Jun 2023 22:20:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A058493
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 22:20:06 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C181BB
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 15:20:04 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9707313e32eso394463366b.2
        for <bpf@vger.kernel.org>; Fri, 02 Jun 2023 15:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685744403; x=1688336403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4LL6f7g4xFPIatUIXJJU6V8X0yYfWD9dexU7OlCbpM=;
        b=XkXJjxKgAjllMrXHs4WmdSMlwrLq7hqDYdMt3Xm+zqXN8sjUku1J2qMKDWekcy/9VP
         +qS8b09zyZWlmMjfRzjDr6eC27uhLa/mK9d84xVu0rYxqSdqlKFCMsGxlJZvA+bMBf18
         z1wc3U69uOiIWkvUcYjes8Em28r9eBp6U+CeCMYQ2Qua+pzpbQOGyfqgiWYkXweVtWrt
         /lH3xgs7X1gxKhkEX9QgpB4UIcudh9LfVbEKajPzllgUemaVzPwDajkd/BnID6xyqH4+
         MCJN4jGScUceFOgL466XayRE15SR7hS9LTnSdYkxDg1DEL4EWejFz6sRpZmt9/KXVf6M
         aMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685744403; x=1688336403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4LL6f7g4xFPIatUIXJJU6V8X0yYfWD9dexU7OlCbpM=;
        b=UbtrbnXJfTXL409cUKhC7rHQ1MvCzkuQkQPLkEhNqpGDBmUlP7RYFmDFuCG2QKuf9X
         JjVe41/onpMx4taNmmFjSeGElHSQmJeQMViBFbmleaFOKDxcsmVAmT2lHlxUPmhSsKrN
         CIBZn6Mxx9ysoctHBaLc5VfncjXZqE+tk58taNii6CaHwE/e77xtpjPkOC+6Hp5tuMVt
         uW23VRWcwOMZLI7rL3WMHkB0okRnKb3yAaK4vuEw/rm1EI5/MXJtOG4tLzop7Tml5PbF
         byGZ/DeAp/bPvpGL94jxd1fPmQ1N3Vyk07El5IHHZ+h7678y+Tn+GSvbsUfIvDJ6iI5H
         kCBw==
X-Gm-Message-State: AC+VfDwwPrYLukeGm3J4omBFx9vGVTijSe0X1wZLyFNbuhY2uxYm1Wdn
	upfY5aNoSpvAny8RyvVmjWQNkTsZ1wa2TvULSGc=
X-Google-Smtp-Source: ACHHUZ7uLGG52RJQ+d+3ztBhERDqN94KIdHLlnJNB9Uf3W6pd5hVI/x5J+sSkbh+iFxN58mO88XzdD3Ue67EASBPhs4=
X-Received: by 2002:a17:907:2dab:b0:96f:7af5:9e9e with SMTP id
 gt43-20020a1709072dab00b0096f7af59e9emr11481997ejc.53.1685744402709; Fri, 02
 Jun 2023 15:20:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230602085239.91138-1-laoar.shao@gmail.com> <20230602085239.91138-6-laoar.shao@gmail.com>
In-Reply-To: <20230602085239.91138-6-laoar.shao@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 2 Jun 2023 15:19:51 -0700
Message-ID: <CAEf4Bzb1A-SSkr5UrXrccMsT99AbmtwOS0WRXzUvYUGCYLX68g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/6] bpf: Support ->fill_link_info for perf_event
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	quentin@isovalent.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 2, 2023 at 1:52=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> By adding support for ->fill_link_info to the perf_event link, users will
> be able to inspect it using `bpftool link show`. While users can currentl=
y
> access this information via `bpftool perf show`, consolidating the link
> information for all link types in one place would be more convenient.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  include/uapi/linux/bpf.h       |  6 ++++++
>  kernel/bpf/syscall.c           | 45 ++++++++++++++++++++++++++++++++++++=
++++++
>  tools/include/uapi/linux/bpf.h |  6 ++++++
>  3 files changed, 57 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 22c8168..87ecf8b 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6442,6 +6442,12 @@ struct bpf_link_info {
>                         __u64 addrs;
>                         __u32 count;
>                 } kprobe_multi;
> +               struct {
> +                       __aligned_u64 name; /* in/out: symbol name buffer=
 ptr */
> +                       __u64 addr;
> +                       __u32 name_len;
> +                       __u32 offset;
> +               } perf_event;

perf_event link could be:

a) uprobe
b) kprobe
c) tracepoint
d) generic perf_event (e.g., cpu_cycles)

This interface doesn't make it very clear which one it is. And what's
"name" for cpu_cycles event? What is the name for uprobe? Let's
actually document this, otherwise it's hard to understand how this
information can be interpreted...

>         };
>  } __attribute__((aligned(8)));
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 80c9ec0..da2de8e 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3303,9 +3303,54 @@ static void bpf_perf_link_dealloc(struct bpf_link =
*link)
>         kfree(perf_link);
>  }
>

[...]

