Return-Path: <bpf+bounces-360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 992106FF843
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 19:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5755E1C20FD3
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 17:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AEE8F52;
	Thu, 11 May 2023 17:20:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BC82069C
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 17:20:58 +0000 (UTC)
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C47C198A
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 10:20:57 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-24e00b8cc73so4934459a91.0
        for <bpf@vger.kernel.org>; Thu, 11 May 2023 10:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683825657; x=1686417657;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5g1tPUSqWf1uQYXilzqCaULBE2+0aT+IWskC56EQBH8=;
        b=5GIB56SPeRe/q9nm6+myJQJ+bHMv03bzu8jLgoIpPWxjfdQw6Ru7f0NfXOfOOo8pcu
         +IZ0JKRL9vg+B4cS+8A8EMfjjVfkX2Cn2ih71pp8PKPTWEw8RvZjAqEZZiWYOlO05D+w
         CQHZCQdM4KXT09bhnjSIs6d1drGo3bSZ5eJpTmC3EDnlPQ2XByVYyJbiq22zccf66Lzl
         /ANAYpTz+4Rup7uMrKqYUs0MZvJ7AGjuNlvnVx9BiozukQGQDkG+nwaCOzHfnl6r+bnr
         0jeW50KKLGrX1Et0C9pMXLqCbmFeeX4eo5b2xpAp/7sIEB69nagdvxGpRaW9Zd/U6fk9
         zrqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683825657; x=1686417657;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5g1tPUSqWf1uQYXilzqCaULBE2+0aT+IWskC56EQBH8=;
        b=UysAyMalPpNqdgiVcf7qvwIDXyu3pm+wQ77BSReStRNOXXBOu0LURH9k9KgqlHJUA3
         5fjjLBDTH87w3xzjp+QPbsMtRZOxAS58woq+vawCUWOi4qxw1+XZ+RVlaUuw5N3N7FJ5
         UQh+F2iJ1M+CMNC1R0hDYUpRdRQ1zROoPBNnOAwTjMp2EESUYGV//zOJEbPueTOeVs06
         jmRmB2hZBsbZAtEgcHLKB9cu6a8Odu7WLZmudGZ4fEiOY+cq2pWSxo4TAr1K33A4yLcY
         efdrivID0H4Uou5QX+wdSEHoQrf43dysTdWWCOLUSUsRBnSOjvuicnHDdWJvx6c7hdP0
         056Q==
X-Gm-Message-State: AC+VfDxdFmHPpVHD1uNxjZo7Vk5GFaRf3OlrY+B7ZoJEAaHB9slwDPxa
	s82JPAY8Goj3AeNGcmJ3fR32Nx7plZclI8I26nSoaK1TNirM6EfTcb/boJvDnUlhdJUrUdmT2jM
	CbsfNWh9J5GtJcJ/sSj0XNyosS6itP6fuRdqLhmqf+nARRc329w==
X-Google-Smtp-Source: ACHHUZ5ZzHX9mhPDLfn0J/uH4cYp6347V/7g3pWavXpAjcaBXECSYP9ghHs9FHJY3GwZH8gbPw6JfhY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:ff95:b0:24e:2288:6d with SMTP id
 hf21-20020a17090aff9500b0024e2288006dmr6510372pjb.0.1683825656804; Thu, 11
 May 2023 10:20:56 -0700 (PDT)
Date: Thu, 11 May 2023 10:20:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230511172054.1892665-1-sdf@google.com>
Subject: [PATCH bpf-next 0/4] bpf: query effective progs without cgroup_mutex
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We're observing some stalls on the heavily loaded machines
in the cgroup_bpf_prog_query path. This is likely due to
being blocked on cgroup_mutex.

IIUC, the cgroup_mutex is there mostly to protect the non-effective
fields (cgrp->bpf.progs) which might be changed by the update path.
For the BPF_F_QUERY_EFFECTIVE case, all we need is to rcu_dereference
a bunch of pointers (and keep them around for consistency), so
let's do it.

Since RFC, I've added handling for non-effective case as well. It's
a bit more complicated, but converting prog hlist to rcu seems
to be all we need (unless I'm missing something). Plus, couple
of READ_ONCE/WRITE_ONCE for the flags to read them in a lockless
(racy) manner.

Stanislav Fomichev (4):
  bpf: export bpf_prog_array_copy_core
  rculist: add hlist_for_each_rcu
  bpf: refactor __cgroup_bpf_query
  bpf: query effective progs without cgroup_mutex

 include/linux/bpf-cgroup-defs.h |   2 +-
 include/linux/bpf-cgroup.h      |   1 +
 include/linux/bpf.h             |   2 +
 include/linux/rculist.h         |   6 ++
 kernel/bpf/cgroup.c             | 168 +++++++++++++++++++-------------
 kernel/bpf/core.c               |  14 ++-
 6 files changed, 114 insertions(+), 79 deletions(-)

-- 
2.40.1.521.gf1e218fcd8-goog


