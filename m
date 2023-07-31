Return-Path: <bpf+bounces-6392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C65EF768A26
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 04:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 592802814FD
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 02:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550E863B;
	Mon, 31 Jul 2023 02:50:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2102562D
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 02:50:35 +0000 (UTC)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44DCE46
	for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 19:50:33 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-76c845dc5beso122297385a.1
        for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 19:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690771833; x=1691376633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tu7nICAcXLKsjvFXjzCa8zu8KakSfVUww6okC4enQ9o=;
        b=EGVbz8mXfKIgIp/5StHHJIDegpkNw9OHblzH0mZJN5/7DBbzehwZEPeTTtpgJzqJpT
         Kbm6zNRsMhcQ7M7MBFMvQ1nsRSI8a9/hLorT8P0ka2qK1KdjE/cuwXdPK5viZp3uXIJH
         pf2+ces/cFz2Edf51P8nsCIFaeJLfQ0m53V/vnUPAR6bU5mI8g/0Cjlr3pXWLqb+ZglJ
         TJSHyoXOORTUntNsC97888BgwkAaHbOJqpXnM43vdw+eGq7MDSxPmiLJAA4CooGSOHwl
         0Ja4+7q5pSyi+IMPAIvgB+fFfQyohhtsDIVSJkaVivaL5st2HtsJJm3cEvLbnCcAB2Fi
         BMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690771833; x=1691376633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tu7nICAcXLKsjvFXjzCa8zu8KakSfVUww6okC4enQ9o=;
        b=PIlaukcQJ76zB5GXiX62jRZ0A616vDY1gXYA0CqAa9sctSC8XGNupp7xt+OgRvoe0A
         oKlCB2DMudwtDUH0tlb+0OSAwB1+8/Nm3QyZN3CdcWl76lddSj+tLcJmy0kHEieamq76
         1Q9ckekbr6RGN3XpQ7cjCZNSdmlh0NTDhAV+4H2UD+jm2GTB1/HNtRYA53GfR4U28Ei+
         L9oiqeMgnFMr3YBP8DuVWdX2WNXxUWBrtpW9QPSCUPB4TEQt4RlrxqNg5mqIxl7oDNn8
         cWbHuxVTkTciwAxwkwVZGfogsSovpNWADMff0tAM7L5x+HNJbmZ8GQy9YBXyHFvWPV1y
         iETw==
X-Gm-Message-State: ABy/qLb/Yc8YXlc+o8ZQ+rksQRGYf4hXTuvsZLPAmpxPcLNO88aSULsi
	v0Zxnw/v9CnFHsYWARJw2THpflvM4mp3jeocrkE=
X-Google-Smtp-Source: APBJJlFWJh8RCLhRESkRWYNEwbEvM2+NxJqOEWcjgh8/IHUPUBNc8Nf9hyflTkv/E7ID1cEXMKCrARwsJE3OqvEu56Q=
X-Received: by 2002:a05:6214:12e:b0:63c:f932:1bf7 with SMTP id
 w14-20020a056214012e00b0063cf9321bf7mr5901175qvs.59.1690771832971; Sun, 30
 Jul 2023 19:50:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230730134223.94496-1-jolsa@kernel.org> <20230730134223.94496-2-jolsa@kernel.org>
In-Reply-To: <20230730134223.94496-2-jolsa@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 31 Jul 2023 10:49:56 +0800
Message-ID: <CALOAHbC617xPdffC6pGrKDbDvub+p=4kxkdGzdspC9XhKtUPAw@mail.gmail.com>
Subject: Re: [PATCHv5 bpf-next 01/28] bpf: Switch BPF_F_KPROBE_MULTI_RETURN
 macro to enum
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jul 30, 2023 at 9:42=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Switching BPF_F_KPROBE_MULTI_RETURN macro to anonymous enum,
> so it'd show up in vmlinux.h. There's not functional change
> compared to having this as macro.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Yafang Shao <laoar.shao@gmail.com>

> ---
>  include/uapi/linux/bpf.h       | 4 +++-
>  tools/include/uapi/linux/bpf.h | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 70da85200695..7abb382dc6c1 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1186,7 +1186,9 @@ enum bpf_perf_event_type {
>  /* link_create.kprobe_multi.flags used in LINK_CREATE command for
>   * BPF_TRACE_KPROBE_MULTI attach type to create return probe.
>   */
> -#define BPF_F_KPROBE_MULTI_RETURN      (1U << 0)
> +enum {
> +       BPF_F_KPROBE_MULTI_RETURN =3D (1U << 0)
> +};
>
>  /* link_create.netfilter.flags used in LINK_CREATE command for
>   * BPF_PROG_TYPE_NETFILTER to enable IP packet defragmentation.
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 70da85200695..7abb382dc6c1 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1186,7 +1186,9 @@ enum bpf_perf_event_type {
>  /* link_create.kprobe_multi.flags used in LINK_CREATE command for
>   * BPF_TRACE_KPROBE_MULTI attach type to create return probe.
>   */
> -#define BPF_F_KPROBE_MULTI_RETURN      (1U << 0)
> +enum {
> +       BPF_F_KPROBE_MULTI_RETURN =3D (1U << 0)
> +};
>
>  /* link_create.netfilter.flags used in LINK_CREATE command for
>   * BPF_PROG_TYPE_NETFILTER to enable IP packet defragmentation.
> --
> 2.41.0
>


--=20
Regards
Yafang

