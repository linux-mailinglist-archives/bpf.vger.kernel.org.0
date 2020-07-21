Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D311C227CD1
	for <lists+bpf@lfdr.de>; Tue, 21 Jul 2020 12:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgGUKVh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jul 2020 06:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbgGUKVg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jul 2020 06:21:36 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4D2C0619D8
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2020 03:21:36 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z2so20689239wrp.2
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2020 03:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=oJ7MRpiw+iTSL8WvnHtt7TFDU0lu71kFFSR8GrqMDDg=;
        b=uCFqHNtN85MUxvO4A1kcjM1McIXmvOrnRTH/YFkEekQmOIvOED9d/sDWx8UjlybZqY
         pb/srWm2LbgoRNYwHyejMYgPgt+2Z8DT3az9Z5JdgnKkGpXkOJzSc6m9ZwG57vsosfW5
         PN/+I1JVtbFm2kPXlj/tNpQw5epLiOLrMBV4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=oJ7MRpiw+iTSL8WvnHtt7TFDU0lu71kFFSR8GrqMDDg=;
        b=bGLRLD8w/0qqOGl/JA+mXFGjGsZ5nsD5aDPXsLUD9s01C89cOVWukYuy99bL1R3r/z
         e7hrT5bmwYpHwEO2P9Sl+APcJCpkGKYQMID6rZZfk0htxLhdPR/akoKufmoU5n3JDCbu
         By1tU+knmKSE7+G2o/q1UtFzZ3+qqTUPVy1ivW8Bb0R0a0JIyp4SEsHdUJnKo7H3QtZY
         SPvfmpvnJxQJW8iZzHsVf9i9SEZa8nKKUcFSiEFktxcViTW2Nl44vzizqy0byDm6gpLQ
         TyMAAKM4qBAK1bB3lrKLQjgJsvqliBW5EvVs2N/L9vXIiWCLTIIiBlFD64WoHCrP4lMH
         c79g==
X-Gm-Message-State: AOAM531a25admZJGriYyT+HUKF57dEWIQCdvJVBaxcNQvmuYvpPiRYss
        tws1/RH5kQMQxSdrnlzEvndIpQ==
X-Google-Smtp-Source: ABdhPJw3FKL17gc4iiyZ5KSdU0Ut/TTW6seduJPa0Kl86zVqYX2pOvCQpeORoz9Q5TU2gwEu1T1BWw==
X-Received: by 2002:adf:e6c1:: with SMTP id y1mr27943211wrm.116.1595326894988;
        Tue, 21 Jul 2020 03:21:34 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id w14sm36317465wrt.55.2020.07.21.03.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 03:21:34 -0700 (PDT)
References: <e54f2aabf959f298939e5507b09c48f8c2e380be.1595170625.git.lorenzo@kernel.org> <874kq2y2cy.fsf@cloudflare.com> <a77cf1a2-6dc8-0a3c-3bb8-d2d9681ccb8f@gmail.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     David Ahern <dsahern@gmail.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, davem@davemloft.net, ast@kernel.org,
        brouer@redhat.com, daniel@iogearbox.net,
        lorenzo.bianconi@redhat.com, kuba@kernel.org
Subject: Re: [PATCH bpf-next] bpf: cpumap: fix possible rcpu kthread hung
In-reply-to: <a77cf1a2-6dc8-0a3c-3bb8-d2d9681ccb8f@gmail.com>
Date:   Tue, 21 Jul 2020 12:21:33 +0200
Message-ID: <871rl5xj6a.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 20, 2020 at 05:45 PM CEST, David Ahern wrote:
> On 7/20/20 3:14 AM, Jakub Sitnicki wrote:
>> I realize it's a code move, but fd == 0 is a valid descriptor number.
>
> this follows the decision made for devmap entries in that fd == 0 is NOT
> a valid program fd.

Surprising. Thanks for clarifying.
