Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FECB11DDD2
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2019 06:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732005AbfLMFjW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Dec 2019 00:39:22 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37607 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfLMFjW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Dec 2019 00:39:22 -0500
Received: by mail-pg1-f193.google.com with SMTP id q127so990759pga.4
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2019 21:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zT+v6nK+DYvIN0pINd8yuzN/yp7POvzmbm2zDJuEg68=;
        b=rECLFbmGRggJkWJDF6wfJOO4HiSoqAn3gHrcU5fB2oDSjyNb4xiK6GgnICPEvMoOjO
         CQawK2C0wXyhfBinxGksrehf6hN4vYhmGsQuxcNCOfrX5epcE53ur+3k2PykxZIJPx3P
         Zuv/GgoyUrP4400ti/aHoxUvUWV+beNo6rr9emhGqdmTNkJb2x1cBhA2/jxUEh4h4pfH
         fH63X0GPGscdHhpSyAxM0z26450wvYvjogrt79tQmWQ+NK2Am1jXJ1qthmBs36fiU3wF
         gntElU5HoTBa1jAeYA70V9AIGZnsegYyWB3suR3Xgx4K9UUY45GKWtD/kj0m8i3TflR6
         zuZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zT+v6nK+DYvIN0pINd8yuzN/yp7POvzmbm2zDJuEg68=;
        b=nkHcSw493GTTlJH5iAGnXIQDTypK3YlW6vyovI7rrM41k/drnck+xcwLvls9kKiHU3
         CNnmyRNSjFglXhUcfObC4lM2ubr2jVcgNaOeCNtvQouTj13jCrtyq5uAb0SObBfTaLjv
         Q/AgFlMb9tvpWD4nL9N2VfDRLMPdDAwpuNIaLbKfVyNuj9lXOgbBfQ4i0LeRvxSpWYQc
         +s21gt9F2iWOGmOSrIAGtiaZjtMgVaHSGOb+L0IrEd8kqDdm/MQvaIxq2rnaT2BCnzO6
         89+Kvq//gRmu0jpgqMwf3nE5IvNpzEnbdr0J56Jzt2za2XQF2sZp9YjN/xAKqrFCV0NM
         fABA==
X-Gm-Message-State: APjAAAX5LVPQsbEDnYrqjACq+Fc1DaWl0UY2Tdfoj0HvGiJ5iriFNthE
        BjvIziShfzn0W9mVJX8TWdBaqEYq
X-Google-Smtp-Source: APXvYqzM49BkR9/A1nGSd2T3oXPx3ECEa34FkPDXB0p77b/yZFZWx8T8QXgqNFclSAbZFWYIimH68w==
X-Received: by 2002:a65:6916:: with SMTP id s22mr14608209pgq.244.1576215561851;
        Thu, 12 Dec 2019 21:39:21 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:180::c195])
        by smtp.gmail.com with ESMTPSA id s27sm9622150pfd.88.2019.12.12.21.39.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 21:39:21 -0800 (PST)
Date:   Thu, 12 Dec 2019 21:39:19 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrey Ignatov <rdna@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, andriin@fb.com, kernel-team@fb.com
Subject: Re: [PATCH v2 bpf-next 0/6] bpf: Support replacing cgroup-bpf
 program in MULTI mode
Message-ID: <20191213053918.3dbidwawkzqcsjmr@ast-mbp>
References: <cover.1576193131.git.rdna@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1576193131.git.rdna@fb.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 12, 2019 at 03:30:47PM -0800, Andrey Ignatov wrote:
> v1->v2:
> - move DECLARE_LIBBPF_OPTS from libbpf.h to bpf.h (patch 4);
> - switch new libbpf API to OPTS framework;
> - switch selftest to libbpf OPTS framework.
> 
> This patch set adds support for replacing cgroup-bpf programs attached with
> BPF_F_ALLOW_MULTI flag so that any program in a list can be updated to a new
> version without service interruption and order of programs can be preserved.
> 
> Please see patch 3 for details on the use-case and API changes.
> 
> Other patches:
> Patch 1 is preliminary refactoring of __cgroup_bpf_attach to simplify it.
> Patch 2 is minor cleanup of hierarchy_allows_attach.
> Patch 4 moves DECLARE_LIBBPF_OPTS from libbpf.h to bpf.h
> Patch 5 extends libbpf API to support new set of attach attributes.
> Patch 6 adds selftest coverage for the new API.

lgtm.
Andrii, please review patches 4 and 5.

I think patch 6 is ok for now, but please consider converting it to test_progs
in the future.

