Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879393AC50B
	for <lists+bpf@lfdr.de>; Fri, 18 Jun 2021 09:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbhFRHe2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Jun 2021 03:34:28 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:35239 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhFRHe2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Jun 2021 03:34:28 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 79DE96000D;
        Fri, 18 Jun 2021 07:32:18 +0000 (UTC)
To:     bpf@vger.kernel.org
Cc:     Jisheng Zhang <jszhang@kernel.org>
From:   Alex Ghiti <alex@ghiti.fr>
Subject: BPF calls to modules?
Message-ID: <aaedcede-5db5-1015-7dbf-7c45421c1e98@ghiti.fr>
Date:   Fri, 18 Jun 2021 09:32:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi guys,

First, pardon my ignorance regarding BPF, the following might be silly.

We were wondering here 
https://patchwork.kernel.org/project/linux-riscv/patch/20210615004928.2d27d2ac@xhacker/ 
if BPF programs that now have the capability to call kernel functions 
(https://lwn.net/Articles/856005/) can also call modules function or 
vice-versa?

The underlying important fact is that in riscv, we are limited to 2GB 
offset to call functions and that restricts where we can place modules 
and BPF regions wrt kernel (see Documentation/riscv/vm-layout.rst for 
the current possibly wrong layout).

So should we make sure that modules and BPF lie in the same 2GB region?

Thanks,

Alex
