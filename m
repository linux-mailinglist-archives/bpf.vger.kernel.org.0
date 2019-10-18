Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8C30DD575
	for <lists+bpf@lfdr.de>; Sat, 19 Oct 2019 01:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389321AbfJRXcG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Oct 2019 19:32:06 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44839 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387700AbfJRXcG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Oct 2019 19:32:06 -0400
Received: by mail-lj1-f194.google.com with SMTP id m13so7770888ljj.11
        for <bpf@vger.kernel.org>; Fri, 18 Oct 2019 16:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=bOk+Nwv7AY/3M5im96P0v1cp6jRzN0hadKAQNd2Rgac=;
        b=DuMKndizmbev/G6iDMVUCwQFsTlU0AnXf4p+XzqQFa/F2XVbUSJ7j5IFLNUOcXQcA3
         +m+rDJJNTwEulwflFqElNEkKgup5zjDaH8tad2QDW0WKh+vObQxNL1kqsVOpE4ZewnRE
         GIT3y+8us25G5vN9rNPBrMuJEUK0xNs+CMBjqkY6+tMgVl8QDNG06w7Qe13s0uP/+D+n
         hvJ43fLZJWTok/Vydv9xVzFdWGxELd9a3ihB5W1KDPE58Kq68WevJ3Jb1xl1Qb520HN3
         infeSBFOH5yqVudVa/FiOVR8wToOn5Zk/Vx3ENQoRvgXIQttItvQ7DPpjf9Ipta9q9TQ
         jDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=bOk+Nwv7AY/3M5im96P0v1cp6jRzN0hadKAQNd2Rgac=;
        b=HmfVqPbEhVzGoIWgCgNF/zeMx0jfD+GZH9ISiPl6vTcVEI6AMw48Q02DV7rKcvmYcD
         j5TLkDtKri1uCz0tpE5qecM19TipFBYSeNCaMKauAKDXXi+GSbWlGti9Q/4FQePRh33Y
         RECyuyRLYz4n7mwr4KEYlp47R2xSqcPaRL3kkf339GdDBEc0+8s931fTFCOmYPzZFjxv
         XHeFQrKCo4LCRgB6CB2Y/GBPqjfqq3TV7dZBSRHB0BwONol33l5MAzxo07QoJrfUhav8
         r8SAP4K46LIxhq7thhWt7eiRPaKLk5VyYPia91mUWvFa/Ct7CvmrZrxxhMamspZwUXAK
         K3LA==
X-Gm-Message-State: APjAAAVFOZgytBe0nyD3TdEjSpWFU5MTakYKw2IeNeU9cm7dEjBWZtyZ
        rsx6JTky3h9+JADebOkETBJDUw==
X-Google-Smtp-Source: APXvYqyek6tELW4NRmY6/lqbijXLozP174xBdciVs1dhVU0bJ6aICt+EelRsvEYL304DTilUtuMSZg==
X-Received: by 2002:a2e:5354:: with SMTP id t20mr6980039ljd.44.1571441524103;
        Fri, 18 Oct 2019 16:32:04 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id v6sm2885022ljh.66.2019.10.18.16.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 16:32:03 -0700 (PDT)
Date:   Fri, 18 Oct 2019 16:31:56 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@fb.com>, bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf] xdp: Prevent overflow in devmap_hash cost
 calculation for 32-bit builds
Message-ID: <20191018163156.278f4ca5@cakuba.netronome.com>
In-Reply-To: <CAADnVQKDaMAVT6UxGy8w+CPUmzvgVWAjXmHexiz09yZJ8CbAeQ@mail.gmail.com>
References: <20191017105702.2807093-1-toke@redhat.com>
        <CAADnVQKDaMAVT6UxGy8w+CPUmzvgVWAjXmHexiz09yZJ8CbAeQ@mail.gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 18 Oct 2019 16:25:24 -0700, Alexei Starovoitov wrote:
> I'm not sure that cleanup Jakub is proposing is possible or better.
> Not everything is array_size here and in other places
> where cost is computed. u64 is imo much cleaner.

Right, adding multiple components with size_t is going to be
unnecessarily tricky.
