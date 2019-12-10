Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D28D118F9C
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2019 19:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfLJSRU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Dec 2019 13:17:20 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34330 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbfLJSRU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Dec 2019 13:17:20 -0500
Received: by mail-pl1-f193.google.com with SMTP id x17so193964pln.1
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2019 10:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=NSUe4Dlnq/eVmmI9RrnQy5bu5fPS8XtosW1PP57fyEk=;
        b=cGAcejXCQHtpnBjye+7ngsK2pmYFOM9r0VCD7Y+1KASSHUeQDFocwSBRWtmGkbr1nm
         iRM5NK+/ctyKMnrmcqENEgSad0Tjs+0wJkwKK70ejjHEk7+bLAktEAtqsoql7qZcZpw3
         r4lnbhKXP3CC78W0sGeqN0EeixT7AFHGU2A4Teq7ByEApz3cjjfpT0G9Z52FDjHcr3jX
         2Sckts7bZrOv+GbcIkQW1qpAf6vwiheelER3yHLTI3N+6S4YSTOdUD7jsj5HMvnPN7Vx
         NK4XAfu+068U+dIVYep28iFy2U0kV936w8H3jVTXxkEax1LPfBfhb3GHr40Ahb1VTat/
         4wwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=NSUe4Dlnq/eVmmI9RrnQy5bu5fPS8XtosW1PP57fyEk=;
        b=oiCQfKvzQEn/l8BYcrOfcatwfc73bIJ17l05pAKBx12jhjC3uZ7kX5H5gaSvIvQZj3
         M0NiQcsXQL6kxAfWmDlM62sEewITK2t7tlwvUJI9iyXrMAshZiuvZFov1cOl1PtyNJlX
         kDxQ247pFPdK1+67Y/7cTce4707+/KHYLBC95bv+wdRHw+tekdAuxm/DqWMNloEDTyYk
         aoO/s466AfJYGvz3cfQw6Op7l7Idq6OkN4pn7v2gk/080PcyFt8hRSy3xqi972YjkGs8
         dyv4qs93SnpeS9FWom5fJvcz+OTEFX944+7AUN2B7MqAjw2YDICPgeWaf9De2r3wQYZr
         EAOg==
X-Gm-Message-State: APjAAAURq0kgUEqWl0wPc9s4MDxSJicG44/cKT1xssPHAlG+MvGvt667
        y8sQAU17seY8SX0JKcfDq0nrMw==
X-Google-Smtp-Source: APXvYqzgXxVQjEBKZ3Mi0lFQtZoHY01Pl/ne8zTb8kAqBDyYR+JfIlz4enqyg8dwMLtf6FX2NkCDdg==
X-Received: by 2002:a17:902:ab86:: with SMTP id f6mr33843103plr.78.1576001839701;
        Tue, 10 Dec 2019 10:17:19 -0800 (PST)
Received: from cakuba.netronome.com ([2601:646:8e00:e18::3])
        by smtp.gmail.com with ESMTPSA id u18sm4082557pgi.44.2019.12.10.10.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 10:17:19 -0800 (PST)
Date:   Tue, 10 Dec 2019 10:17:16 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 03/15] libbpf: move non-public APIs from
 libbpf.h to libbpf_internal.h
Message-ID: <20191210101716.56c34afc@cakuba.netronome.com>
In-Reply-To: <CAEf4BzbYvNJ0VV2jHLVK3jwk+_GvVhSWk_-YM2Twu5XkZduZVQ@mail.gmail.com>
References: <20191210011438.4182911-1-andriin@fb.com>
        <20191210011438.4182911-4-andriin@fb.com>
        <20191209173353.64aeef0a@cakuba.netronome.com>
        <CAEf4BzbYvNJ0VV2jHLVK3jwk+_GvVhSWk_-YM2Twu5XkZduZVQ@mail.gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 10 Dec 2019 09:04:58 -0800, Andrii Nakryiko wrote:
> > I thought this idea was unpopular when proposed?  
> 
> There was a recent discussion about the need for unstable APIs to be
> exposed to bpftool and we concluded that libbpf_internal.h is the most
> appropriate place to do this.

Mm. Do you happen to have lore link? Can't find now.

My recollection is that only you and Alexei thought it was
a good/workable idea.
