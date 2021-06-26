Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1F13B4E1D
	for <lists+bpf@lfdr.de>; Sat, 26 Jun 2021 12:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhFZKl0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 26 Jun 2021 06:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhFZKlZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 26 Jun 2021 06:41:25 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8521AC061766
        for <bpf@vger.kernel.org>; Sat, 26 Jun 2021 03:39:03 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4GBr2Y36lLz9sjD; Sat, 26 Jun 2021 20:39:01 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev@lists.ozlabs.org, bpf@vger.kernel.org,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Anton Blanchard <anton@ozlabs.org>
In-Reply-To: <20210609090024.1446800-1-naveen.n.rao@linux.vnet.ibm.com>
References: <20210609090024.1446800-1-naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/bpf: Use bctrl for making function calls
Message-Id: <162470384413.3589875.7316169059141962276.b4-ty@ellerman.id.au>
Date:   Sat, 26 Jun 2021 20:37:24 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 9 Jun 2021 14:30:24 +0530, Naveen N. Rao wrote:
> blrl corrupts the link stack. Instead use bctrl when making function
> calls from BPF programs.

Applied to powerpc/next.

[1/1] powerpc/bpf: Use bctrl for making function calls
      https://git.kernel.org/powerpc/c/20ccb004bad659c186f9091015a956da220d615d

cheers
