Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132C51C9E49
	for <lists+bpf@lfdr.de>; Fri,  8 May 2020 00:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgEGWNb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 18:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgEGWNb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 May 2020 18:13:31 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666CFC05BD43
        for <bpf@vger.kernel.org>; Thu,  7 May 2020 15:13:31 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id m13so5920065otf.6
        for <bpf@vger.kernel.org>; Thu, 07 May 2020 15:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=8Kj3l3bXfGu1JAbcVF6x/goon/dQa8Bq8CyQQ5FYzaY=;
        b=uCNOu50M7Ou8lpkl+yxeMqzRzLj9xNoN6G7rMZ2IU43R+UUHxPFGQebvVuyCqExerh
         Z5wAEQOHxXIaR627RmXB99GsVeBF48cO/s/5F1lsADoycZ3sXDSCZGtnuQdW9edy/Drv
         sPWW5yuMW08zW1TAaNRZwrguuJAr3RJ6INv3rhjFbUZGCKwxzprLG/IrICOoU3tB5Voo
         4PI/bMjsZ4ZFlHpNL8+E7+9YbfzyW2bUMHGtk7xag5wMAl6Vhr9YX6a4BnkPEksg4ed+
         lyj8lu8EzJpIQiGFCfdkSEgWGqIILTbLx4Y3wmFTFWu+5AH2Ts3TRzSFYR1BxYnfXHYY
         SApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8Kj3l3bXfGu1JAbcVF6x/goon/dQa8Bq8CyQQ5FYzaY=;
        b=fOMg/dRLutZdB4dBstGTZySZ2CmQAfMq0vyknv/ObzUBEGxHCp16A+whAx2vdeC833
         D8wwD+vbK/ozL+RZGnoiqJtw72xndY1kg9RARoJT3eFqD/R2viJ3zJtXYiiaSJ9evsgI
         2zoIMV0Fx4PuxJZiUV8zE48mZQH5rgdfGdxEafYNCWmogskTcNAS+mBCLeB2Bu/6nh1W
         X+g6komJPI9NMaW5VcWaCGEksP/0fk6fDpbZos5nNoNZTjNCm7LaW09Nc2BExrrWPnRh
         W0mTeunGaUzdgK7nxn5WMPjPc3evTHZj2JKFFzSaw920eEir23ZfTsDRuXJirYBmplyW
         AXfA==
X-Gm-Message-State: AGi0PuYD9/X4sxs07Zab55blKdXbGSl2awJ9Bw+2352E1NoMNpNFfwTw
        hcJ6MXv5KVR1Gp7banCTP/1dRbXBhcJmCHFZ5O1c+S/6nFw=
X-Google-Smtp-Source: APiQypKLX8ryYWF++NoOx0tVBwZUF/tly/xbvE0TlqlvBpFR/aRMMFXTz1LAcRiY7lEfinbc4qW8jw8VME53th0cViY=
X-Received: by 2002:a9d:7cd1:: with SMTP id r17mr12469296otn.355.1588889610564;
 Thu, 07 May 2020 15:13:30 -0700 (PDT)
MIME-Version: 1.0
From:   Josh Soref <jsoref@gmail.com>
Date:   Thu, 7 May 2020 18:13:18 -0400
Message-ID: <CACZqfqC038WbB-iO86xsvpSehgRLaua_uObbOSJgxfx5DnV5Ww@mail.gmail.com>
Subject: spelling fix for bpf_perf_prog_read_value optval doc
To:     Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I hope this is acceptable.

From e60808d70c4c3d6287ed0280bd17aedbcab67a4c Mon Sep 17 00:00:00 2001
From: Josh Soref <jsoref@users.noreply.github.com>
Date: Thu, 7 May 2020 18:05:15 -0400
Subject: [PATCH] spelling: optval

---
 include/uapi/linux/bpf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index f9b7fdd951e48..f705495cbe0e3 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1771,7 +1771,7 @@ union bpf_attr {
  * which the option resides and the name *optname* of the option
  * must be specified, see **getsockopt(2)** for more information.
  * The retrieved value is stored in the structure pointed by
- * *opval* and of length *optlen*.
+ * *optval* and of length *optlen*.
  *
  * This helper actually implements a subset of **getsockopt()**.
  * It supports the following *level*\ s:

-----
In case of whitespace damage, please see:
https://github.com/jsoref/linux/commit/e60808d70c4c3d6287ed0280bd17aedbcab67a4c.patch
