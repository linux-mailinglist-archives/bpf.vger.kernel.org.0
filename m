Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE7015553B
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2019 18:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbfFYQ4J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jun 2019 12:56:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57394 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727763AbfFYQ4J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Jun 2019 12:56:09 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4850430024AD;
        Tue, 25 Jun 2019 16:56:09 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-116-223.ams2.redhat.com [10.36.116.223])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D30619C6F;
        Tue, 25 Jun 2019 16:56:08 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc:     bpf@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>
Subject: bpf: jit: s390 64/32 bits for index in tail call
Date:   Tue, 25 Jun 2019 19:56:07 +0300
Message-ID: <xuny36jxppso.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 25 Jun 2019 16:56:09 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi!

I have a question about 6651ee070b3124fe9b9db383e3a895a0e4aded65

```
    With this patch a tail call generates the following code on s390x:
    
     if (index >= array->map.max_entries)
             goto out
     000003ff8001c7e4: e31030100016   llgf    %r1,16(%r3)
     000003ff8001c7ea: ec41001fa065   clgrj   %r4,%r1,10,3ff8001c828
```

Do I understand corretly, that it uses 64 bit index value?

"runtime/jit: pass > 32bit index to tail_call"
test_verifier's test fails for me and I see, for example,
/* mov edx, edx */  in the x86 implementation


-- 
WBR,
Yauheni Kaliuta
