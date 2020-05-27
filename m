Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78251E4BFF
	for <lists+bpf@lfdr.de>; Wed, 27 May 2020 19:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391272AbgE0Rfy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 May 2020 13:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387837AbgE0Rfx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 May 2020 13:35:53 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9D2C03E97D
        for <bpf@vger.kernel.org>; Wed, 27 May 2020 10:35:53 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u6so189106ybo.18
        for <bpf@vger.kernel.org>; Wed, 27 May 2020 10:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1CALB6XXCUkWXggNCnKd8yQSQ3gWzPmlgt+o3eFIIPc=;
        b=h8inMUcTI/R2exgy2GX/UE6oQCdZ/VRDXXlY0Xpy24sk4PTcTZtyzHl+oWmmnje3yO
         /fSbDVM6OnEKIMJ/OM5vwS6PdqlD3DtkpZPwr+fEEz5HA7QFxSC2INod77XZTecFFQSm
         Pq7yHaPmie2vj6PkIawQ1RXZx+DBNI2jEQfGl0o1iAF0iwK5HkyZZucdamUYi5/YHIsk
         Tylj4F0OZ0JW5/lOpzXiMwsuLcI+CTHOIzNZm9YnxpLiXIPbtRuDFWrVkCInKe0hflyu
         pCv2EE37M2Pz+/7eJzDlrIPLpWgTLSYK5GfvrQ/MblgQwsKKgxTb1FtrbhFQ7vs3p0/n
         JC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1CALB6XXCUkWXggNCnKd8yQSQ3gWzPmlgt+o3eFIIPc=;
        b=jZiDNGSCgqaHxp1I9TPirBff4nv63QQL6Ej8hkyO9seAGoGXT3g8vw+44JDTCRVmer
         w2VJ+nvp4GQ9Xi5g4kZBknruhoMLKCDDN42BXCe/35/ezspCFSGF9qqkvLDr2Faoj6dO
         o0nNRE/PifmgcrsLWtM2/nzJba4T4nVOP3hENzyBwRDLzT3L3cBVSg+QLc8wgtq6vWnG
         iiJQm9LLhFddqKsuCvONulZfs15fL0x41mV2bCE5TiBIYE8xtor8Kl1NQOCSvmy6qqrz
         khYOdc+Lilf9LHf0e27qqmVv3GURDEoRSb4jDS50WZabuuhGvuBaFL/KjwuzlM2pamPP
         HhQg==
X-Gm-Message-State: AOAM533Pq+2yoE/Q9wcAEo3A0habD8MtnuZAOSbav76bdpTC5ekXWhHJ
        /L6fvdIfJKwYTKxNe3PrI75GC8s=
X-Google-Smtp-Source: ABdhPJwSbZmelIBVyWyTkZUTlbzpRaDH1hbHCdFP393Tl4Ve5WTyq/rqLKo1M7si8CuzTmc0pptWIx4=
X-Received: by 2002:a25:8202:: with SMTP id q2mr11479013ybk.243.1590600952995;
 Wed, 27 May 2020 10:35:52 -0700 (PDT)
Date:   Wed, 27 May 2020 10:35:51 -0700
In-Reply-To: <20200527170840.1768178-3-jakub@cloudflare.com>
Message-Id: <20200527173551.GE49942@google.com>
Mime-Version: 1.0
References: <20200527170840.1768178-1-jakub@cloudflare.com> <20200527170840.1768178-3-jakub@cloudflare.com>
Subject: Re: [PATCH bpf-next 2/8] flow_dissector: Pull locking up from prog
 attach callback
From:   sdf@google.com
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 05/27, Jakub Sitnicki wrote:
> Split out the part of attach callback that happens with attach/detach lock
> acquired. This structures the prog attach callback similar to prog detach,
> and opens up doors for moving the locking out of flow_dissector and into
> generic callbacks for attaching/detaching progs to netns in subsequent
> patches.

> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
Reviewed-by: Stanislav Fomichev <sdf@google.com>
