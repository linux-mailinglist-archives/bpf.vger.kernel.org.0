Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D483BC14C
	for <lists+bpf@lfdr.de>; Mon,  5 Jul 2021 17:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhGEQCJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Jul 2021 12:02:09 -0400
Received: from ivanoab7.miniserver.com ([37.128.132.42]:51096 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbhGEQCJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Jul 2021 12:02:09 -0400
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@kot-begemot.co.uk>)
        id 1m0R0N-0003Wl-Jm
        for bpf@vger.kernel.org; Mon, 05 Jul 2021 15:59:31 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.92)
        (envelope-from <anton.ivanov@kot-begemot.co.uk>)
        id 1m0R0L-0003g3-Du
        for bpf@vger.kernel.org; Mon, 05 Jul 2021 16:59:31 +0100
To:     bpf@vger.kernel.org
From:   Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Subject: Access to a BPF map from a module
Message-ID: <dc71d2f8-acd8-c88a-1ec6-1b733fa03440@kot-begemot.co.uk>
Date:   Mon, 5 Jul 2021 16:59:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi List,

I have the following problem.

I want to perform some operations on a bpf map from a loadable module. The map is instantiated elsewhere and pinned.

How do I go about to obtain the map inside the module?

bpf_map_get* functions are not exported at present so they are not available. Is there another way besides them to fetch a bpf map "by fs name" in a kernel module?

If the access limitation is intentional, may I ask what is the actual rationale behind this decision?

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/
