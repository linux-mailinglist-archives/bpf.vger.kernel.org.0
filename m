Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F1B3C94A1
	for <lists+bpf@lfdr.de>; Thu, 15 Jul 2021 01:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhGNXsq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Jul 2021 19:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhGNXsq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Jul 2021 19:48:46 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65126C06175F
        for <bpf@vger.kernel.org>; Wed, 14 Jul 2021 16:45:53 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id a7so3314122iln.6
        for <bpf@vger.kernel.org>; Wed, 14 Jul 2021 16:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=n7/CnwquV7qf+at4gFjVvZiPNrWAycR3M6cVLWMhogA=;
        b=jixIUCbW0f/iUgvk+qRZFDAixn+L0oSBpF0f5TiVcIGA9VAfMfwHd0uvjO43l8t4Zc
         ApZZoPrBQWqBxb2rVDQtTQE2YELVo6JIiexJeqTBEI/UMb/o9dAXu1QlXgmuEAYbDAbV
         FX28+DqPjndX1SArl3dSNASnn5PypBqJqqOdCoMNpgOGnQrhCAvowNYbsskQ3luNBjMn
         SPpSbG1PhNxUhi+JK7huAM2t9CjTHjEPDyb6vtaFHRNqHDExVH/w5MUbp4PBY6ny4kli
         gePCRUfQsEd3BJ7EfUhGxZ8kpnMUGWwHsxHw0J05YRoISA/ryfoDk8/s4XAdqXJy8+zb
         peIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=n7/CnwquV7qf+at4gFjVvZiPNrWAycR3M6cVLWMhogA=;
        b=TEBj6Xs7WWpDx/LImyHV20re0d5C32C7GdomGnagW1bnpCZF+LP+eM+8oVv8Pm/Ji2
         28W4ubBoKsbys3clhEyYwJ+jdFSMBLg8rpBvYNC7nb919dLG0Eks1nTZJItltZpiGZ8q
         kEqJZpS/x3f/jjQmTeEde8Uliqod0kakukpHwyOF7sCRWXHJliCFEi/7uLY8Vcn65Cmn
         kKw9x0XzdxKH/gIHBGssDzg9LoMddQVEnRMPjSLl/OQZUt6vfn2oXWdS9togcCVLxFKW
         fhkgRkr+Wmn7IsKQTeIYX/hdDrCSYvmuOl00HRUxzi9Cb5mStnIFDbUgjKCG8gC8Y7QO
         iPJw==
X-Gm-Message-State: AOAM532uvmD0DL+fs1IiRyLWWuXIpwVltNEAh3lje6nlsLQ9mrQOzSr5
        gOVtLDTJEvsqvemb6ZREtRY=
X-Google-Smtp-Source: ABdhPJwHyeVkGvZB1QdoYeSRz5gDnO+ie837nLUOzDTqIxdzHRiPn2C1+HZ05EqmuAI7uMjciYFoHQ==
X-Received: by 2002:a92:dcc5:: with SMTP id b5mr277673ilr.234.1626306352775;
        Wed, 14 Jul 2021 16:45:52 -0700 (PDT)
Received: from localhost ([172.243.157.240])
        by smtp.gmail.com with ESMTPSA id d5sm2139162ilf.55.2021.07.14.16.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 16:45:52 -0700 (PDT)
Date:   Wed, 14 Jul 2021 16:45:46 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Martin KaFai Lau <kafai@fb.com>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org
Message-ID: <60ef772a443e3_5a0c120884@john-XPS-13-9370.notmuch>
In-Reply-To: <20210714174013.oksmjoc5l5bq4b5o@kafai-mbp.dhcp.thefacebook.com>
References: <20210714124317.67526-1-kuniyu@amazon.co.jp>
 <20210714174013.oksmjoc5l5bq4b5o@kafai-mbp.dhcp.thefacebook.com>
Subject: Re: [PATCH] bpf: Fix a typo of reuseport map in bpf.h.
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martin KaFai Lau wrote:
> On Wed, Jul 14, 2021 at 09:43:17PM +0900, Kuniyuki Iwashima wrote:
> > Fix s/BPF_MAP_TYPE_REUSEPORT_ARRAY/BPF_MAP_TYPE_REUSEPORT_SOCKARRAY/ typo
> > in bpf.h.
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
> It could be bpf-next.
> 
> Fixes: 2dbb9b9e6df6 ("bpf: Introduce BPF_PROG_TYPE_SK_REUSEPORT")
> Acked-by: Martin KaFai Lau <kafai@fb.com>

LGTM with fixes and bpf-next.

Acked-by: John Fastabend <john.fastabend@gmail.com>
