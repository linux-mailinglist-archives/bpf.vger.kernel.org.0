Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540C72021CE
	for <lists+bpf@lfdr.de>; Sat, 20 Jun 2020 08:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725616AbgFTGIX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 20 Jun 2020 02:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgFTGIX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 20 Jun 2020 02:08:23 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46751C06174E
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2020 23:08:23 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id z2so11301313ilq.0
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2020 23:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=IDFDnuTzIDDw/HktHPu0nDrGDA+fGtkYfGdxFbkQPIE=;
        b=fDJ0ok8kaQcO4ZiAcXg2/sGxwmjAXN2Kd5lcv4+r2Evs6u7t+Sivi6ypmlJadowvbV
         53G/Ztkt+iAXZcfkSbSq3lWUzy1A9s8swyCw8o66ACFOZPwtoM2Tmhea1GCmb3/Fzds6
         t1mxXLUSHVLszgYV/UAlujB2A5JFmaiOA3jINNfYN9+mhtZoEZ7OaJU69oBM9uiDNVF4
         1199bRpx84YfUCsrJkzfT6lXl90MStDx4WkzPqPeAI3kUo/PV/wdD6hW46Jdq5IYXM1k
         OxC+vIlyaWV3QhrdmZ4zbiDab8JwR3mHzEnJHPkC1NC9ktqjjwkQw9S5aI80U7av1iCV
         7E4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=IDFDnuTzIDDw/HktHPu0nDrGDA+fGtkYfGdxFbkQPIE=;
        b=eFlEqXIMNZUwwuNCwQj6Hr+C81G25ObIdpFAlVf417/J6iPz2EKvJqOeboKxLr8pkj
         Ep5rztnakoq0N7vvATEb8pZJV1S46Ua0BBMRtZlgV/++9EHafLYXoElqntOpzW84Ly8v
         TyAFqqh6aBJL300xzb1oEgX6V3tFkRgnSnR0oeLb8VPJrwTyF+haAzYzEmpAzdIz0voX
         M2mVwJVseTzoQ9Son/PIuBAFNMZ2C7tL1jm1UU6eK8kh15ZBHtZ+24SsskgzrFup7od2
         jyRRLX5Nf+862IR9NSh/FZUPE+QL0luobbcYYbNXb5llRNF2/wnaDhhy2ulakHmz7MJE
         JPXg==
X-Gm-Message-State: AOAM532nNK0cmiH5rBnF7EKX8uRNOugOvNHcEFzL7zfEwsupWZT1ZK/+
        MYiVEg+R5TARHOfAvGCgrBA=
X-Google-Smtp-Source: ABdhPJxBdOE9e4MCLRjkrG72VFhYcisSAG/RJdqp+8gjFzKNV/ddawD4Bmo+skyjdJ/C5O/xJwgQoQ==
X-Received: by 2002:a92:914f:: with SMTP id t76mr6071184ild.99.1592633301797;
        Fri, 19 Jun 2020 23:08:21 -0700 (PDT)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id q5sm4307152ile.37.2020.06.19.23.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 23:08:21 -0700 (PDT)
Date:   Fri, 19 Jun 2020 23:08:14 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Andrey Ignatov <rdna@fb.com>, bpf@vger.kernel.org
Cc:     Andrey Ignatov <rdna@fb.com>, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, andriin@fb.com, kernel-team@fb.com
Message-ID: <5eeda7ce5dd09_38742acbd4fa45b89a@john-XPS-13-9370.notmuch>
In-Reply-To: <c006a639e03c64ca50fc87c4bb627e0bfba90f4e.1592600985.git.rdna@fb.com>
References: <cover.1592600985.git.rdna@fb.com>
 <c006a639e03c64ca50fc87c4bb627e0bfba90f4e.1592600985.git.rdna@fb.com>
Subject: RE: [PATCH v2 bpf-next 2/5] bpf: Rename bpf_htab to bpf_shtab in
 sock_map
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrey Ignatov wrote:
> There are two different `struct bpf_htab` in bpf code in the following
> files:
> - kernel/bpf/hashtab.c
> - net/core/sock_map.c
> 
> It makes it impossible to find proper btf_id by name = "bpf_htab" and
> kind = BTF_KIND_STRUCT what is needed to support access to map ptr so
> that bpf program can access `struct bpf_htab` fields.
> 
> To make it possible one of the struct-s should be renamed, sock_map.c
> looks like a better candidate for rename since it's specialized version
> of hashtab.
> 
> Rename it to bpf_shtab ("sh" stands for Sock Hash).
> 
> Signed-off-by: Andrey Ignatov <rdna@fb.com>
> ---
>  net/core/sock_map.c | 82 ++++++++++++++++++++++-----------------------
>  1 file changed, 41 insertions(+), 41 deletions(-)

Acked-by: John Fastabend <john.fastabend@gmail.com>
