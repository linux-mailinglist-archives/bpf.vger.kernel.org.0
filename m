Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C75608DE5B
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2019 22:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbfHNUEs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Aug 2019 16:04:48 -0400
Received: from mail1.oneunified.net ([63.85.42.215]:35834 "EHLO
        mail1.oneunified.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729479AbfHNUEp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Aug 2019 16:04:45 -0400
X-Greylist: delayed 1096 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Aug 2019 16:04:44 EDT
X-Spam-Status: No
X-One-Unified-MailScanner-Watermark: 1566416786.88654@llTxkVrR0i2rcv/yasm9fQ
X-One-Unified-MailScanner-From: ray@oneunified.net
X-One-Unified-MailScanner: Not scanned: postmaster@oneunified.net
X-One-Unified-MailScanner-ID: x7EJkJbN031716
X-OneUnified-MailScanner-Information: Please contact the ISP for more information
Received: from [10.55.90.10] (h96-45-2-121-eidnet.org.2.45.96.in-addr.arpa [96.45.2.121] (may be forged))
        (authenticated bits=0)
        by mail1.oneunified.net (8.14.4/8.14.4/Debian-4) with ESMTP id x7EJkJbN031716
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 14 Aug 2019 19:46:25 GMT
To:     bpf@vger.kernel.org
From:   Raymond Burkholder <ray@oneunified.net>
Subject: bpftrace / bpf program 'Killed' on kernel v5.2.7 during load
Organization: One Unified Net Limited
Message-ID: <9b763db5-2d31-9e72-7236-4e4c9f91180f@oneunified.net>
Date:   Wed, 14 Aug 2019 13:46:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The simplest test I have is the following for a difference between kernels:

# uname -a
Linux nuc8i7hvk01 4.19.0-5-amd64 #1 SMP Debian 4.19.37-6 (2019-07-18) 
x86_64 GNU/Linux
# cat /sys/kernel/debug/tracing/events/syscalls/sys_enter_execve/id
677

# uname -a
Linux nuc8i7hvk01 5.2.0-2-amd64 #1 SMP Debian 5.2.7-1 (2019-08-07) 
x86_64 GNU/Linux
# cat /sys/kernel/debug/tracing/events/syscalls/sys_enter_execve/id
Killed


This prevents bpftrace and other bpf helper based applications from loading.

apparmour, selinux, and audit are all turned off.

Is there a new 'enable' flag some where?  Or are things done differently 
now? Or is this a Debian 'thing'?

Raymond.
https://blog.raymond.burkholder.net/



