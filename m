Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17F01DBC30
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2019 06:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393705AbfJRE5m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Oct 2019 00:57:42 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46526 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730688AbfJRE5m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Oct 2019 00:57:42 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A42B1146CF6F3;
        Thu, 17 Oct 2019 21:57:41 -0700 (PDT)
Date:   Thu, 17 Oct 2019 21:57:39 -0700 (PDT)
Message-Id: <20191017.215739.1133924746697268824.davem@davemloft.net>
To:     williams@redhat.com
Cc:     tglx@linutronix.de, bigeasy@linutronix.de, daniel@iogearbox.net,
        bpf@vger.kernel.org, ast@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, peterz@infradead.org,
        acme@redhat.com
Subject: Re: [PATCH] BPF: Disable on PREEMPT_RT
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191017214917.18911f58@tagon>
References: <20191017.132548.2120028117307856274.davem@davemloft.net>
        <alpine.DEB.2.21.1910172342090.1869@nanos.tec.linutronix.de>
        <20191017214917.18911f58@tagon>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 17 Oct 2019 21:57:42 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Clark Williams <williams@redhat.com>
Date: Thu, 17 Oct 2019 21:49:17 -0500

> BPF programs cannot loop and are limited to 4096 instructions.

The limit was increased to 1 million not too long ago.
