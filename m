Return-Path: <bpf+bounces-37766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0227B95A643
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 23:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DAD01F229E6
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 21:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F22170A37;
	Wed, 21 Aug 2024 21:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdgAE6dy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898D37405A;
	Wed, 21 Aug 2024 21:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724274083; cv=none; b=OD15aRIKXskw/lf262Aetf3Mz2IslqY5wOUTLi8Pzdj9iL3aFpH9+9XmRaXDgzTpBKLGpQQ2oLc+Rcdxh4sel4fgTqFznFAPMo19UNZKscKVQMLWolf3sVT9XRgtFgVn1cB8MABS2nM0Ajn5NsRzmpWLCk3EPx0GbWi9vFYnMQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724274083; c=relaxed/simple;
	bh=BcMGqKRQYmvlkD3ncucm/R/QqOz8Hm1b2ox1ktnrYkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OAfv0mneRk5HdphCoHXcXAlmw5p6wxRY5++FJMJguVPK5PwLbfb8azAmqwvJp8S3RwlrhVZwZNeKNMAVcP+9B1zDEBdXPhT1C1QeHrgEBg/aGrxTgW+RU+SeccbuU9DeS21yh4mcsQhwd908cKZ5JwtnqvPbqn3BehPg73eu2KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdgAE6dy; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37196681d3bso29616f8f.3;
        Wed, 21 Aug 2024 14:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724274080; x=1724878880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPNQ3r1NoMlaj0xx7dLL0YCAm3rSnwF6hmKGBdiyvbM=;
        b=FdgAE6dyB59cjsTGM5TSTK2ADRevEAjn2c2r8SL1d8ypmLxSdwIhnxEUtP4nHwo76G
         yDJl2z+u70r3NGzAxpCOnOAa+hrX/9MLLEL3v4RkUR4qh94I68k30x73VDhkzaRTZ4Pj
         StKCd+PAwdPoeupGySpPRISjrndXP2ecipjyq4nvf+UvxkjKawKcgyRtdLNPgFzv9MGs
         Bkwjmg/jZOgcFrxT7MfSp5zwnRTfLdPHKcyj9olKpecUaknNsDQW1SE2/Q0nZbEzkdy5
         YUFyc4vbBJWBNF9fk5NYEkD24Y3nZf7btxxbH2cXuW8N0o3CifFsqT8Ioh3ACYaf8mP8
         nTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724274080; x=1724878880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPNQ3r1NoMlaj0xx7dLL0YCAm3rSnwF6hmKGBdiyvbM=;
        b=LIku9M/5Xvvaf0HsozkiXvv3YX0VCWQpk/xhcUyHFrMHlse2jkFJPcr4K+iXGaG/8R
         toNXYar/voU/dyXuDYoPlink8+szzQ//7HcnjxILbhWWYLrOz8StNNkfFt6jH3uZxxXy
         UO/37INcAilvrWq+Ph68VVBaOojHXes0xxQDx/YM1e6yf7NtvBW7ipr8LUmA8BHtmoNY
         c4tGxhfy3UI4gnYhy2FqSEjS5LxfiUIORprljtOvBuIObfs3/AjKKu2P+blQpyRDvPt7
         arCd3SfiCv7pSllpKlPp+IsVxfRzD2bS2O2TQknL23HoM3xMl2yhmHFowhHMG9DgaeFV
         wZtA==
X-Forwarded-Encrypted: i=1; AJvYcCXSQwjOCRGgdtj5m7bfM6Sdbb4W4xnuUOttAzxEmtYmQhoM8mQytWw701KgwxYDUua1hyM=@vger.kernel.org, AJvYcCXn0c7beT6JxpRZn2AMLnXe7tdgRzMNF3qKeNa28B3DlNhy7+Pd6CSbav975rDKhDOSbPKa8OeVEjdv20ws@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmp4CKx8kVfZMWvGaRWLGObaRRBj5fEkOQfzGIGYHpaaX4Yg8q
	HtAxgOx6dHopL2yusr5MZB4b+4hZvpeDrBFjZnzmBVabOdBXWtmHGi0B8VoRbK12UMTGkd1veNV
	S5niZpO2o9eoplUA1/yIHM+qUfh0=
X-Google-Smtp-Source: AGHT+IGK5T0nDufa6N8i4fHSCAxyTR0jwbSr6kE4UzzT3vskIhvbCHGDn2AlzCa36TYh+syU4K8aw4v6vDWjtuG2a2s=
X-Received: by 2002:a5d:44c7:0:b0:371:8f15:21df with SMTP id
 ffacd0b85a97d-372fd70fd5bmr2438422f8f.49.1724274079514; Wed, 21 Aug 2024
 14:01:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821093016.2533-1-Tze-nan.Wu@mediatek.com>
In-Reply-To: <20240821093016.2533-1-Tze-nan.Wu@mediatek.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 21 Aug 2024 14:01:08 -0700
Message-ID: <CAADnVQLLN9hbQ8FQnX_uWFAVBd7L9HhsQpQymLOmB-dHFR4VRw@mail.gmail.com>
Subject: Re: [PATCH net v4] bpf, net: Check cgroup_bpf_enabled() only once in do_sock_getsockopt()
To: Tze-nan Wu <Tze-nan.Wu@mediatek.com>
Cc: Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, bobule.chang@mediatek.com, wsd_upstream@mediatek.com, 
	LKML <linux-kernel@vger.kernel.org>, linux-mediatek@lists.infradead.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Yanghui Li <yanghui.li@mediatek.com>, 
	Cheng-Jui Wang <cheng-jui.wang@mediatek.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 2:30=E2=80=AFAM Tze-nan Wu <Tze-nan.Wu@mediatek.com=
> wrote:
>
> The return value from `cgroup_bpf_enabled(CGROUP_GETSOCKOPT)` can change
> between the invocations of `BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN` and
> `BPF_CGROUP_RUN_PROG_GETSOCKOPT`.
>
> If `cgroup_bpf_enabled(CGROUP_GETSOCKOPT)` changes from "false" to
> "true" between the invocations of `BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN` and
> `BPF_CGROUP_RUN_PROG_GETSOCKOPT`, `BPF_CGROUP_RUN_PROG_GETSOCKOPT` will
> receive an -EFAULT from `__cgroup_bpf_run_filter_getsockopt(max_optlen=3D=
0)`
> due to `get_user()` was not reached in `BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN`=
.
>
> Scenario shown as below:
>
>            `process A`                      `process B`
>            -----------                      ------------
>   BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN
>                                             enable CGROUP_GETSOCKOPT
>   BPF_CGROUP_RUN_PROG_GETSOCKOPT (-EFAULT)
>
> To prevent this, invoke `cgroup_bpf_enabled()` only once and cache the
> result in a newly added local variable `enabled`.
> Both `BPF_CGROUP_*` macros in `do_sock_getsockopt` will then check their
> condition using the same `enabled` variable as the condition variable,
> instead of using the return values from `cgroup_bpf_enabled` called by
> themselves as the condition variable(which could yield different results)=
.
> This ensures that either both `BPF_CGROUP_*` macros pass the condition
> or neither does.
>
> Fixes: 0d01da6afc54 ("bpf: implement getsockopt and setsockopt hooks")
> Co-developed-by: Yanghui Li <yanghui.li@mediatek.com>
> Signed-off-by: Yanghui Li <yanghui.li@mediatek.com>
> Co-developed-by: Cheng-Jui Wang <cheng-jui.wang@mediatek.com>
> Signed-off-by: Cheng-Jui Wang <cheng-jui.wang@mediatek.com>
> Signed-off-by: Tze-nan Wu <Tze-nan.Wu@mediatek.com>
> ---
>
> Chagnes from v1 to v2: https://lore.kernel.org/all/20240819082513.27176-1=
-Tze-nan.Wu@mediatek.com/
>   Instead of using cgroup_lock in the fastpath, invoke cgroup_bpf_enabled
>   only once and cache the value in the newly added variable `enabled`.
>   `BPF_CGROUP_*` macros in do_sock_getsockopt can then both check their
>   condition with the new variable `enable`, ensuring that either they bot=
h
>   passing the condition or both do not.
>
> Chagnes from v2 to v3: https://lore.kernel.org/all/20240819155627.1367-1-=
Tze-nan.Wu@mediatek.com/
>   Hide cgroup_bpf_enabled in the macro, and some modifications to adapt
>   the coding style.
>
> Chagnes from v3 to v4: https://lore.kernel.org/all/20240820092942.16654-1=
-Tze-nan.Wu@mediatek.com/
>   Add bpf tag to subject, and Fixes tag in body.
>
> ---
>  include/linux/bpf-cgroup.h | 15 ++++++++-------
>  net/socket.c               |  5 +++--
>  2 files changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index fb3c3e7181e6..5afa2ac76aae 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -390,20 +390,20 @@ static inline bool cgroup_bpf_sock_enabled(struct s=
ock *sk,
>         __ret;                                                           =
      \
>  })
>
> -#define BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen)                        =
      \
> +#define BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen, enabled)               =
      \
>  ({                                                                      =
      \
>         int __ret =3D 0;                                                 =
        \
> -       if (cgroup_bpf_enabled(CGROUP_GETSOCKOPT))                       =
      \
> +       enabled =3D cgroup_bpf_enabled(CGROUP_GETSOCKOPT);               =
        \
> +       if (enabled)


I suspect the compiler generates slow code after such a patch.
pw-bot: cr

What is the problem with double cgroup_bpf_enabled() check?
yes it might return two different values, so?

