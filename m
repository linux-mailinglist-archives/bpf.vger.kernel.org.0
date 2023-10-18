Return-Path: <bpf+bounces-12583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497E47CE2C3
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 18:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03CE5281DB6
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 16:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE4A3CCE2;
	Wed, 18 Oct 2023 16:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EwJsb7Mj"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F281E358A1
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 16:29:03 +0000 (UTC)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F8ABD
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 09:29:02 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-41cb7720579so295331cf.1
        for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 09:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697646541; x=1698251341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NP8epScHrNgHZ84MxLEjBdBvtFkaSpGQFw1IMN4MPNo=;
        b=EwJsb7Mj9rMz7vi3ocLoJpYksd2wJNBPiYfTs5tTcoBvo6bRv9mg3Sdj1cDlXsPjTE
         Ic5LsgN19EvEThygVh2DRBgKgY4TTcJsFxeyAB0C5XP2JSsO5EH3R327EWLddCaJGVwu
         /v0yaw3ub/VJ9N5qf6ed1ZlAiPvgG9+7Rb/H4enMvJhkAR059tDdPoZenOJcpC2avBlP
         1/NK80j3ySdsGtUneqBRM9gr6cERg3q0P2Zq4YRXhFgpKBUdFBJPZdxdnli0/C6WvqHs
         WPtXa4GEP2IdiWLRPuYHMaLFLyrJf3fauw95Jofzt/CNG7MFbXmxa0cO4lImO6KITLUb
         XmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697646541; x=1698251341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NP8epScHrNgHZ84MxLEjBdBvtFkaSpGQFw1IMN4MPNo=;
        b=RkkJQ2tFPMFBMhbYUSE5gSh7Ko4F05VPbABwRG0G2/DqPKcB3YbxhiXIz/2qlXYYJ4
         ZuyI9QQwa0nOkL7rQLkmSVPbVFqoD+4iPVFX5zaBwOyuQ/PpnFHekGkW8Pj+45cnhOtA
         lSNpuLzGtM8LHv/zpnBqmVU12rwrJ7LKNV54zFylhWjdpFOC3RSmJl5hoC6J4oU3FobV
         zBh/3e2LAz6fFTkkJ6mfgdvnlU5QADMqQt3CCJBGY5kvEjkt8MR+oKgjQZqs6SMU4aKJ
         nqfkwr9e1L5OEPvxaFavcJBbDwyPO3B6PtI3J/j0j9IKhm7g09PeeiI4fyptJCa8hIfG
         GAcQ==
X-Gm-Message-State: AOJu0YzTtGmCELR+KL9VeqRRL6Q1LtbHbJYCd1lPl75zVAggCUHubak6
	ZZ5lduJw5nzq5snV0JS8hcFTwnvSbBt+D5PQocVgUQ==
X-Google-Smtp-Source: AGHT+IEjZdE64AlO/kPu6yekVca1LeSJ4143bYX+rUPzxbvwQZgKxFi7LC3iGp1nmFLzzNVPtiFHfVLV7D6UhUO4iQY=
X-Received: by 2002:a05:622a:4713:b0:404:8218:83da with SMTP id
 dn19-20020a05622a471300b00404821883damr251529qtb.1.1697646541251; Wed, 18 Oct
 2023 09:29:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018082104.3918770-1-link@vivo.com> <20231018082104.3918770-2-link@vivo.com>
In-Reply-To: <20231018082104.3918770-2-link@vivo.com>
From: Yu Zhao <yuzhao@google.com>
Date: Wed, 18 Oct 2023 10:28:25 -0600
Message-ID: <CAOUHufbc9j-6yfcm_4h_qD5L1oq6KRVXxA1u+mx0dXBqtghjYQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] tracing: mm: multigen-lru: fix mglru trace
To: Huan Yang <link@vivo.com>, Jaewon Kim <jaewon31.kim@samsung.com>, 
	Kalesh Singh <kaleshsingh@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, 
	opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 18, 2023 at 2:22=E2=80=AFAM Huan Yang <link@vivo.com> wrote:
>
> This patch add two reclaim stat:
> nr_promote: nr_pages shrink before promote by folio_update_gen.
> nr_demote: nr_pages NUMA demotion passed.

The above isn't specific to MLGRU, so they should be in a separate patchset=
.

> And then, use correct nr_scanned which evict_folios passed into
> trace_mm_vmscan_lru_shrink_inactive.
>
> Mistake info like this:
> ```
> kswapd0-89    [000]    64.887613: mm_vmscan_lru_shrink_inactive:
> nid=3D0 nr_scanned=3D64 nr_reclaimed=3D0 nr_dirty=3D0 nr_writeback=3D0
> nr_congested=3D0 nr_immediate=3D0 nr_activate_anon=3D0 nr_activate_file=
=3D0
> nr_ref_keep=3D0 nr_unmap_fail=3D0 priority=3D4
> flags=3DRECLAIM_WB_FILE|RECLAIM_WB_ASYNC
> ```
> Correct info like this:
> ```
>  <...>-9041  [006]    43.738481: mm_vmscan_lru_shrink_inactive:
>  nid=3D0 nr_scanned=3D13 nr_reclaimed=3D0 nr_dirty=3D0 nr_writeback=3D0
>  nr_congested=3D0 nr_immediate=3D0 nr_activate_anon=3D9 nr_activate_file=
=3D0
>  nr_ref_keep=3D0 nr_unmap_fail=3D0 nr_promote=3D4 nr_demote=3D0 priority=
=3D12
>  flags=3DRECLAIM_WB_ANON|RECLAIM_WB_ASYNC
> ```

Adding Jaewon & Kalesh to take a look.

