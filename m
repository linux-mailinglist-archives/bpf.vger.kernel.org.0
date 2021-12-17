Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3BF478D14
	for <lists+bpf@lfdr.de>; Fri, 17 Dec 2021 15:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236957AbhLQOLo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Dec 2021 09:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhLQOLo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Dec 2021 09:11:44 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B89C061574
        for <bpf@vger.kernel.org>; Fri, 17 Dec 2021 06:11:43 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id q16so4306703wrg.7
        for <bpf@vger.kernel.org>; Fri, 17 Dec 2021 06:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=XBOar8hVs+92I590k7WtI+tLlc95XVYl8RWh/LdOtGs=;
        b=joCjd4e0mjY7eqNW8jbcDdKUHsCms2Q/5TnhJkFlbLJ82EtPm7fKy+8VhXKzjYBG6z
         plOErZ/hr6k16L3pmwI4YJKHSWpIAJprvH6yTw4AtjY5sTBz3Sz0PVpirjGceZlTiUyE
         ApJpzb8nvGjZLGTRj1yfrpEyws6c6SSt6We80pPSUUiO4oGXw6g5RyXJSwOtLlL4Y8mC
         ZWEvw+Wh+zedgg0Co04Vx0PpRCMpet+o7qcfPafcCqvxZWdvcbo7cVGGReVfiqLT7kwT
         M5x/EUNR26rI5bIFIki77DRJFR8KTge82giMhemy2WCrU4jmSKU4u0esrv84TP8C+3h+
         5RAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=XBOar8hVs+92I590k7WtI+tLlc95XVYl8RWh/LdOtGs=;
        b=x55J2ehC9cSjOzWnLbji4WdUgp+fEnBKrn0llsTqLec9bJTAwCw/ci1n8gN3w+/34F
         sx62U4wq6X8MdXTPYgoJVXETBR7U6jpO9m1UKw8GQG55DSaYwaLczPKvatywJDcsWBiC
         o3Do76dDp9mwfa3kmdesDULWWR5hpNs0VmwLSemEytO0S0JIlmNbQprL1H9ztw/kaOcW
         7x53r9oUewtHfGeOH0M+zaXHHk8vFSRHBsRi4RkhWjItiEQMom0dP9Fl5n7fD5XA1sVq
         /TPRXzojgwAMRCc1CEpKqnDQrY30YCXW1n+MqzR2Q1xtY5g1bveN0hLDQl9caqNBOS4q
         38KQ==
X-Gm-Message-State: AOAM531Rswl9Ev930KOzxBdgtY5bKZ1qUMTs4Mw440GrenrJPaF+iNBF
        tYl+MyhsiRabyZyc2oRNM3IQ+IR51hHL6Qs=
X-Google-Smtp-Source: ABdhPJzcF6vJGq05td87HAqtYIRGW2fvhKJ/Xp8/I6UjtYIpOT809DsW9UaXhdGBPezk/mxZZXwnRg==
X-Received: by 2002:a05:6000:1567:: with SMTP id 7mr480632wrz.513.1639750302484;
        Fri, 17 Dec 2021 06:11:42 -0800 (PST)
Received: from Mem (2a01cb088160fc0089020d359cf3dd66.ipv6.abo.wanadoo.fr. [2a01:cb08:8160:fc00:8902:d35:9cf3:dd66])
        by smtp.gmail.com with ESMTPSA id f13sm8762670wmq.29.2021.12.17.06.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 06:11:42 -0800 (PST)
Date:   Fri, 17 Dec 2021 15:11:40 +0100
From:   Paul Chaignon <paul@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf v2] bpftool: Flush tracelog output
Message-ID: <20211217141140.GA26351@Mem>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The output of bpftool prog tracelog is currently buffered, which is
inconvenient when piping the output into other commands. A simple
tracelog | grep will typically not display anything. This patch fixes it
by flushing the tracelog output after each line from the trace_pipe file.

Fixes: 30da46b5dc3a ("tools: bpftool: add a command to dump the trace pipe")
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Paul Chaignon <paul@isovalent.com>
---
Changes in v2:
  - Resending to fix a format error.

 tools/bpf/bpftool/tracelog.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/bpftool/tracelog.c b/tools/bpf/bpftool/tracelog.c
index e80a5c79b38f..b310229abb07 100644
--- a/tools/bpf/bpftool/tracelog.c
+++ b/tools/bpf/bpftool/tracelog.c
@@ -158,6 +158,7 @@ int do_tracelog(int argc, char **argv)
 			jsonw_string(json_wtr, buff);
 		else
 			printf("%s", buff);
+		fflush(stdout);
 	}
 
 	fclose(trace_pipe_fd);
-- 
2.25.1

