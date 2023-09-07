Return-Path: <bpf+bounces-9444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8808797C1B
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 20:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E4EE281765
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 18:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7BD13AC2;
	Thu,  7 Sep 2023 18:41:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AE98BF5
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 18:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB24C43395
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 18:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694112061;
	bh=S9ZAswZQkRWoyTBkTJdEmpRgs0QwmwDTBD/yjXWEK40=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gJr78pzBwWNytA0Owuys83RqLCISmNIyEGe1PUFf8eKNKhIiMG0Aa6xOnyqcCb0Xf
	 5DDiCVJRiRhSlaTVY67LHAT282E8d9p2hGTXvLfGATNeMt/fZqlV2xHPlHAx0TPV4M
	 Pp9IK+Ku+yClsEjjLbBpnVNaLv5jBtyXogiQsE+SKtf/JG+YBW2+14nxnUafHObtSa
	 7cRa32by4UX7gPZx293CEV2mx0rVN2NBaZLsKhLVIgbUH7rAXHRnOMDfHMfAI0/21U
	 sB355Bh3Q2JA9bg7DvOMg+0udldGVJdZUAvKQDbSj2icqZUGbPX5tQTpf7qtatty6m
	 ZD9CD8anmcwlg==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5008d16cc36so2152953e87.2
        for <bpf@vger.kernel.org>; Thu, 07 Sep 2023 11:41:01 -0700 (PDT)
X-Gm-Message-State: AOJu0YzJvbw4q6Jp4256q5oD951RqK7tMz9kPmD5w9ZO9kO8/kjPoBjB
	u8CKuJRQ4vnVujvlFRbHrkDc+1cX1BMtQDSXfXs=
X-Google-Smtp-Source: AGHT+IFpXvx04V93n2xfn+Df2HH+qexZ8rmAF4qR72CPztyrvOBuBW+9LN0MsASYVIpJc3z2W3JCYd+AzZDthxJt29I=
X-Received: by 2002:a19:915a:0:b0:500:9704:3c9 with SMTP id
 y26-20020a19915a000000b00500970403c9mr176541lfj.26.1694112059575; Thu, 07 Sep
 2023 11:40:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230907071311.254313-1-jolsa@kernel.org> <20230907071311.254313-4-jolsa@kernel.org>
In-Reply-To: <20230907071311.254313-4-jolsa@kernel.org>
From: Song Liu <song@kernel.org>
Date: Thu, 7 Sep 2023 11:40:46 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4hX95fHZCDYnfzAwK43dbnGJUxHEF3bGdODWe_6MytnQ@mail.gmail.com>
Message-ID: <CAPhsuW4hX95fHZCDYnfzAwK43dbnGJUxHEF3bGdODWe_6MytnQ@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 3/9] bpf: Add missed value to kprobe perf link info
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Hou Tao <houtao1@huawei.com>, 
	Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 7, 2023 at 12:13=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Add missed value to kprobe attached through perf link info to
> hold the stats of missed kprobe handler execution.
>
> The kprobe's missed counter gets incremented when kprobe handler
> is not executed due to another kprobe running on the same cpu.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

[...]

The code looks good to me. But I have two thoughts on this (and 2/9).

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index e5216420ec73..e824b0c50425 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6546,6 +6546,7 @@ struct bpf_link_info {
>                                         __u32 name_len;
>                                         __u32 offset; /* offset from func=
_name */
>                                         __u64 addr;
> +                                       __u64 missed;
>                                 } kprobe; /* BPF_PERF_EVENT_KPROBE, BPF_P=
ERF_EVENT_KRETPROBE */
>                                 struct {
>                                         __aligned_u64 tp_name;   /* in/ou=
t */

1) Shall we add missed for all bpf_link_info? Something like:

diff --git i/include/uapi/linux/bpf.h w/include/uapi/linux/bpf.h
index 5a39c7a13499..cf0b8b2a8b39 100644
--- i/include/uapi/linux/bpf.h
+++ w/include/uapi/linux/bpf.h
@@ -6465,6 +6465,7 @@ struct bpf_link_info {
        __u32 type;
        __u32 id;
        __u32 prog_id;
+       __u64 missed;
        union {
                struct {
                        __aligned_u64 tp_name; /* in/out: tp_name buffer pt=
r */

2) "missed" doesn't seem to fit well with other information in
struct bpf_link_info. Other information there are more like stable-ish
information; while missed is a stat that changes over time. Given we
have prog_id in bpf_link_info, do we really need "missed" here?

Thanks,
Song


[...]

