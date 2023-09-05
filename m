Return-Path: <bpf+bounces-9239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BFF792148
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 11:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1818280D7C
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 09:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F5963B4;
	Tue,  5 Sep 2023 09:06:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1E31C2F
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 09:06:12 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632B5CE;
	Tue,  5 Sep 2023 02:06:10 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-500b6456c7eso3978561e87.2;
        Tue, 05 Sep 2023 02:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693904768; x=1694509568; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=letwRErFMBgbPngILbkdV7sGxY9b/Xz8daRTCtIa2w8=;
        b=DXeAb6P65VKaB0RaSL+6ecESxBs71K0CTjrivB7HS4l2lQCVt53ISaT+oEfnceDEiy
         Hfwpf7U/PYJnDs7K4m0hSO6ymeROOQ3FHvkbXQeCkJZFajSFw3PbLvv0Kv6OMShUJDYf
         LbO2BF4Ztd/ccHJIsqbgzOc5LJF+vU1tnDaQ1O5sZK+2QJZG0KM0q1PvBaW6ietgLSjB
         BMHX9pudexW0JFOs/TKIcygHYYCROKEYjIkTmx2f32pulq8hPCj4BtodoYohx3y8gIqg
         L3aaRViW9lkDA9UobYZZF5nqAewEAzcVcgLJkYiruoyoKmOgkTwwY5iTxrxJsoDvLxrO
         gU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693904768; x=1694509568;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=letwRErFMBgbPngILbkdV7sGxY9b/Xz8daRTCtIa2w8=;
        b=XHf3XXRV7DPD84iO+YUtplk4M04lRNRTBXlO6kVy1zAJ1vT5M0GZSiY4rS1Rrjx3qq
         rdF34iTy2zZsDZEdifh0hhWiwWnT1SnSWSzf6h6w5FVPo47/VtLFyAUu8K2ceoKpl2pG
         t2cJkLQ/VAWLzLaHNJtLCG+RmGA1DE9kbwaC33bnJum7fQtBsj+LFY2NukoKLWh1BaAj
         zsIWSf+5IcKNuV3afLtxRGvGHOjtWIIE1Vxb7AlsVlE8eoAVKd8vAGc6WhJrnXu9tvg4
         oj4Bd22lGFMR6FFGPXpJa4JvfcuVqn3+VpjnZLF0npKB9tTTpwTjM0lXQZB/cBrkUBim
         sASQ==
X-Gm-Message-State: AOJu0YzP+Efs0MGAx+PlNkyUvDQ7igEGMFlYva1ATAG3U3Qz9r0C3spk
	LQWdX45ctqJ+oKcwwmmFEToFvVsKhJw0Sw==
X-Google-Smtp-Source: AGHT+IErdz2nPOeeXQxbGqcrhny5C2Hrn3K8C7hP0c/COE1md7cNuUKpAMBmFeiG8NrKl+5520A6Aw==
X-Received: by 2002:a2e:9d8d:0:b0:2bb:b01a:9226 with SMTP id c13-20020a2e9d8d000000b002bbb01a9226mr8748809ljj.7.1693904767873;
        Tue, 05 Sep 2023 02:06:07 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:4a6:d58b:abde:2218])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c379200b003fee65091fdsm19595905wmr.40.2023.09.05.02.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 02:06:06 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: David Wang <00107082@163.com>
Cc: fw@strlen.de,  Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,  Yonghong
 Song <yonghong.song@linux.dev>,  John Fastabend
 <john.fastabend@gmail.com>,  KP Singh <kpsingh@kernel.org>,  Stanislav
 Fomichev <sdf@google.com>,  Hao Luo <haoluo@google.com>,  Jiri Olsa
 <jolsa@kernel.org>,  linux-kernel@vger.kernel.org,  bpf@vger.kernel.org
Subject: Re: [PATCH] samples/bpf: Add sample usage for BPF_PROG_TYPE_NETFILTER
In-Reply-To: <20230904102128.11476-1-00107082@163.com> (David Wang's message
	of "Mon, 4 Sep 2023 18:21:28 +0800")
Date: Tue, 05 Sep 2023 10:05:26 +0100
Message-ID: <m28r9ldm7d.fsf@gmail.com>
References: <20230904102128.11476-1-00107082@163.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

David Wang <00107082@163.com> writes:

> This sample code implements a simple ipv4
> blacklist via the new bpf type BPF_PROG_TYPE_NETFILTER,
> which was introduced in 6.4.
>
> The bpf program drops package if destination ip address
> hits a match in the map of type BPF_MAP_TYPE_LPM_TRIE,
>
> The userspace code would load the bpf program,
> attach it to netfilter's FORWARD/OUTPUT hook,
> and then write ip patterns into the bpf map.
>
> Signed-off-by: David Wang <00107082@163.com>
> ---
>  samples/bpf/Makefile                      |  3 +
>  samples/bpf/netfilter_ip4_blacklist.bpf.c | 62 +++++++++++++++
>  samples/bpf/netfilter_ip4_blacklist.c     | 96 +++++++++++++++++++++++
>  3 files changed, 161 insertions(+)
>  create mode 100644 samples/bpf/netfilter_ip4_blacklist.bpf.c
>  create mode 100644 samples/bpf/netfilter_ip4_blacklist.c

According to https://docs.kernel.org/process/coding-style.html#naming
you should avoid new use of blacklist. You should use somethink like
denylist or blocklist instead.

