Return-Path: <bpf+bounces-10284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E817A4C3E
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 17:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35E72281DBA
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 15:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6121D6AC;
	Mon, 18 Sep 2023 15:29:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1652A1D6A1
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 15:29:00 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0ECAC
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 08:27:24 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c469ab6935so167605ad.1
        for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 08:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695050669; x=1695655469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UbPBofT/4AGGz2HH7yLIR5t4+0yl7YX5yavMVqOyw4=;
        b=0ApS85oiJ7jp8TF5CkDH1mt1703uVURGGYj2aup1HQl+wPNMFWdwTsqRAPsfJBeTlD
         yXpb6AAuQXOotdW/aQFp95Mqwf5ahVKOurIcbvKD3TyYUocTam2IRPXudcI+NLIoJqJF
         UN7rY9sPLAmJa96kYTXLsgi9mk4nsR5Dd4c7B+f3BUoRhTJrQ6j4G9RR1fH9JvLfDyP0
         UR9iFGicen+uMudo86ZarfLuC70/qJfVjOQ8++Ru2U8CeZV+X6azlwC34d3FNecuImEc
         2thWS9J0j/tanFuqiObDWLSVKEVJFjv+ou5PzIQ76Nip0GWWH/l2a/BrDS4K+ZiR6EqL
         d3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695050669; x=1695655469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6UbPBofT/4AGGz2HH7yLIR5t4+0yl7YX5yavMVqOyw4=;
        b=Dlvny3w4Og8ixUdZub16w60f/cn+AbGMRZbZQB86VTvW2h/3CdpIf7QS1vPjm9JhVL
         rwYGCvH4U1jPlendM/GxN1qJfSAOb3g7foOkPaqAEx6ZagA4YaZNnkLA2Unz6c6/FFBS
         dTkeS3YCXGeQCAon9S76HJ5IrMdlYR6l2G0X7sHUXxCARIuzheRx5xgSQRLiHpvtRQc2
         B7WMi9heyGB3m3iOA5Tkl667Q9Og3x6z3NZ7YWiw7PktkZAPnKHmMDn2Fh6PnFo8YZKl
         UMKrjiZxEnPFLN+VyGElYQ1J/fwlUu1SPp8iQuIIy9Soai0TP8UVCdl9VVfPRe/5HsaW
         /rTQ==
X-Gm-Message-State: AOJu0YwIonxM3S3t6+FlAPCUsBjUNzhxvKyaQynZgNSLeP69qkc40SLW
	g09/rrmVN+QbeXsxk2bf/Xwui16Llt9gzFG2GTGonS6WEkTmvHi6mMsJUQ==
X-Google-Smtp-Source: AGHT+IEnV4KuGka1FgaLdBiGzxFWG2i+6wNH6yhdyyc6xwatPFieTmLbogv2yArVpLXrxbWb5k7kjJCAZQAGSbAc7qE=
X-Received: by 2002:ac8:580c:0:b0:410:958a:465f with SMTP id
 g12-20020ac8580c000000b00410958a465fmr380877qtg.11.1695043555021; Mon, 18 Sep
 2023 06:25:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230916165853.15153-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20230916165853.15153-1-alexei.starovoitov@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 18 Sep 2023 15:25:43 +0200
Message-ID: <CANn89iK_367bq4Gv+AuA-H5UgXNuM=N3XCp7N8nkeMik0Kwp+Q@mail.gmail.com>
Subject: Re: pull-request: bpf-next 2023-09-16
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	daniel@iogearbox.net, andrii@kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Sep 16, 2023 at 6:59=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Hi David, hi Jakub, hi Paolo, hi Eric,
>
> The following pull-request contains BPF updates for your *net-next* tree.
>
> We've added 73 non-merge commits during the last 9 day(s) which contain
> a total of 79 files changed, 5275 insertions(+), 600 deletions(-).
>
> The main changes are:
>
> 1) Basic BTF validation in libbpf, from Andrii Nakryiko.
>
> 2) bpf_assert(), bpf_throw(), exceptions in bpf progs, from Kumar Kartike=
ya Dwivedi.
>
> 3) next_thread cleanups, from Oleg Nesterov.
>
> 4) Add mcpu=3Dv4 support to arm32, from Puranjay Mohan.
>
> 5) Add support for __percpu pointers in bpf progs, from Yonghong Song.
>
> 6) Fix bpf tailcall interaction with bpf trampoline, from Leon Hwang.
>
> 7) Raise irq_work in bpf_mem_alloc while irqs are disabled to improve ref=
ill probabablity, from Hou Tao.
>
> Please consider pulling these changes from:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
>

This might have been raised already, but bpf on x86 now depends on
CONFIG_UNWINDER_ORC ?

$ grep CONFIG_UNWINDER_ORC .config
# CONFIG_UNWINDER_ORC is not set

$ make ...
arch/x86/net/bpf_jit_comp.c:3022:58: error: no member named 'sp' in
'struct unwind_state'
                if (!addr || !consume_fn(cookie, (u64)addr,
(u64)state.sp, (u64)state.bp))
                                                                 ~~~~~ ^
1 error generated.

