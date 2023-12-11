Return-Path: <bpf+bounces-17438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D42B380DB3C
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 21:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FB8E1C215CF
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 20:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4588253802;
	Mon, 11 Dec 2023 20:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEuqlm0M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB6FC4
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 12:06:19 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6ce934e9d51so3097699b3a.1
        for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 12:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702325179; x=1702929979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8eZKx5GkiUH6GA3XPVibDjEMzwes+FD0A0dagasN0I=;
        b=AEuqlm0Ml27mcVDPuyk7LWB1c8wXqEkpgVlIoPbRoJAMNkVdFrROvvxV0thewSvZVs
         UiUq4HroWZytjx8oRLjn55m0JrgAzT3x6dtz9Rr1wRtIpRBDB3C5+q5HTWrWAHCyF3m4
         +MKYpptw8UNgJ1QOGrsAaQMJVXTIKpEUs0OHzftACa8dSjPfz2iPwUgDUln7HBHJXvs1
         jwzKVxzOgZkuPXAdKjaLMzwmjlhaxpowmgJC1Ck47ZGI6zGwm8VKB3lfm8TMDM4F5XGu
         Pr0iEdHVvxYMsBXdXGg6A+49ptwB1qCR0RWRdzzFmFZxr2w9P1EQ4js0PopdO3oIY255
         h28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702325179; x=1702929979;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l8eZKx5GkiUH6GA3XPVibDjEMzwes+FD0A0dagasN0I=;
        b=Fjt8fTVWJDUYJmQS3wgHTBBo/XZ38t7+OD2yjC6Owdgu/Ncu39YTxpizn4mIQJsvDv
         zrdZKKei1T5ZdfJ9dyGr72huMLzKyEP16K8yQplOyCmVjJJIWVoFfpHgaPWZ2FC9fGVI
         B3nwr3jPYKrLYy2JQQYuo15Zd0OcjOECBhKkzExqU11x8rG3hOMi7ObVYmvMYoMiH/RX
         kf5hZedntu15znTbdZh1NBE+iNcS11x23txcOS8JFgk4bhm2CoKTZzdYJF7N8mEcyy6W
         wrxcnij4oIA3Q1pj5i4JbfcYkxYjMKiaVLSMoUSNk6IBviUzbhb2yiKOa1WGson+0pXJ
         LBGQ==
X-Gm-Message-State: AOJu0YzdwF180EigdsX2ZVMMsx9Fe13KJqgmbuaIPD8yDmICYpk8lI1g
	9nMRsMxF56+lpm2KmCoDcXE=
X-Google-Smtp-Source: AGHT+IFoT8RZe/jX4pLnT5tADtKdrAtCywPHPLp2fo1vXjSmi0+T1rQ+nJihZBw74bC67u72nMW6wA==
X-Received: by 2002:a05:6a20:748f:b0:18f:97c:9270 with SMTP id p15-20020a056a20748f00b0018f097c9270mr2785208pzd.85.1702325179029;
        Mon, 11 Dec 2023 12:06:19 -0800 (PST)
Received: from localhost ([98.97.32.4])
        by smtp.gmail.com with ESMTPSA id m9-20020a62f209000000b006cb903ab057sm6605264pfh.83.2023.12.11.12.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 12:06:18 -0800 (PST)
Date: Mon, 11 Dec 2023 12:06:16 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, 
 Hou Tao <houtao@huaweicloud.com>, 
 bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>, 
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Song Liu <song@kernel.org>, 
 Hao Luo <haoluo@google.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 houtao1@huawei.com
Message-ID: <65776bb8d03f5_e82d208fb@john.notmuch>
In-Reply-To: <0415f445-4dff-4b64-bd87-f4de08b94bb7@linux.dev>
References: <20231211083447.1921178-1-houtao@huaweicloud.com>
 <0415f445-4dff-4b64-bd87-f4de08b94bb7@linux.dev>
Subject: Re: [PATCH bpf-next v2] bpf: Update the comments in
 maybe_wait_bpf_programs()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Yonghong Song wrote:
> 
> On 12/11/23 12:34 AM, Hou Tao wrote:
> > From: Hou Tao <houtao1@huawei.com>
> >
> > Since commit 638e4b825d52 ("bpf: Allows per-cpu maps and map-in-map in
> > sleepable programs"), sleepable BPF program can also use map-in-map, but
> > maybe_wait_bpf_programs() doesn't handle it accordingly. The main reason
> > is that using synchronize_rcu_tasks_trace() to wait for the completions
> > of these sleepable BPF programs may incur a very long delay and
> > userspace may think it is hung, so the wait for sleepable BPF programs
> > is skipped. Update the comments in maybe_wait_bpf_programs() to reflect
> > the reason.
> >
> > Signed-off-by: Hou Tao <houtao1@huawei.com>
> 
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> 
> 

Useful info if you are needing this property.

Acked-by: John Fastabend <john.fastabend@gmail.com>

