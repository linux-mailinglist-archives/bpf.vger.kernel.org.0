Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE3608EE42
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2019 16:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732934AbfHOOcd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Aug 2019 10:32:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37906 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730466AbfHOOcd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Aug 2019 10:32:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id g17so2414123wrr.5
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2019 07:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CMA3sRg7D/yxSYutIiGR9Ywo5TwiBUayBKOGHCZMAQQ=;
        b=onUTk2A4W/SWt+WguIOVirYQ2odQDVjaZNL81KkBk8ukGK6ts8RDFnyOpEGCxZJLji
         HCgBUJp3FQL2nSOMQTNkfs+rPZP7fHGdsy/MCpH8or4ZaqLgaKKTybCQn4jgF+blB1Gg
         EmWCXyxx2rIbdqfVvmFfJyuxfN8dpzrl0q0NNcFYmrm7DmnO7d/kGg/CpxDb1HZZ2sPW
         +ZCAboa9xzR6NqjszMd2GhD8k/qQ+M6PAotAwxGjEkoImkfThfE23XJj8m/cVJjWZ/Nm
         z7og7WNyqdsLTMjSm2qOPx4fvOa9edM7GAw41fajeRaeoCvW2Wtgg01fbfsCywJmSx10
         Y05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CMA3sRg7D/yxSYutIiGR9Ywo5TwiBUayBKOGHCZMAQQ=;
        b=Nl1lQcXMtc0Knio9dvD1P3tYl2AC+KXLsHtoUUVEe+Bghgn0icyhBjo0xolkBBmWVy
         E1kXEVFL/ZXsS07I+IqRHQ650NtakO0WF7D0ltjUgYu0fdJywARGRfvlqlxS8tww1Glf
         P7SB9L8J/ByxyG2YxEMQuzT4RVn2xpp5+nOnXocv6KRiKGIJXAb+DjQA+F8rYT5yraWo
         puMr2eGmrYwIU1ASj5KjNGPlyr8A8lPX9+K/Fm6VX48h5V2UjNYHpn1aGLHu78Hte7MF
         2c1Ta/Bvct3I1uatGzeu32TvSsVS80A0nmbpAh+caRUSfJ8iKOrzOk4aMlgLBmSXe+BO
         CzBw==
X-Gm-Message-State: APjAAAX443dPvL+eoXMVnUd4DGhiQeL2IF0BHuaMJGahUa7q+u9dKmO6
        TvoX4dz8shMfhO+afF6iHSx6hg==
X-Google-Smtp-Source: APXvYqyxyRU7c5HWyYflegsbfoQS2Arr22U5UvgLTffx1xxpBYUJRRJxMR94yMAz9wKFAG5nDp7bcA==
X-Received: by 2002:a05:6000:128d:: with SMTP id f13mr5935903wrx.241.1565879551546;
        Thu, 15 Aug 2019 07:32:31 -0700 (PDT)
Received: from cbtest32.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id a19sm8857463wra.2.2019.08.15.07.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 07:32:30 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH bpf 1/6] tools: bpftool: fix arguments for p_err() in do_event_pipe()
Date:   Thu, 15 Aug 2019 15:32:15 +0100
Message-Id: <20190815143220.4199-2-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190815143220.4199-1-quentin.monnet@netronome.com>
References: <20190815143220.4199-1-quentin.monnet@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The last argument passed to some calls to the p_err() functions is not
correct, it should be "*argv" instead of "**argv". This may lead to a
segmentation fault error if CPU IDs or indices from the command line
cannot be parsed correctly. Let's fix this.

Fixes: f412eed9dfde ("tools: bpftool: add simple perf event output reader")
Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 tools/bpf/bpftool/map_perf_ring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/map_perf_ring.c b/tools/bpf/bpftool/map_perf_ring.c
index 3f108ab17797..4c5531d1a450 100644
--- a/tools/bpf/bpftool/map_perf_ring.c
+++ b/tools/bpf/bpftool/map_perf_ring.c
@@ -157,7 +157,7 @@ int do_event_pipe(int argc, char **argv)
 			NEXT_ARG();
 			ctx.cpu = strtoul(*argv, &endptr, 0);
 			if (*endptr) {
-				p_err("can't parse %s as CPU ID", **argv);
+				p_err("can't parse %s as CPU ID", *argv);
 				goto err_close_map;
 			}
 
@@ -168,7 +168,7 @@ int do_event_pipe(int argc, char **argv)
 			NEXT_ARG();
 			ctx.idx = strtoul(*argv, &endptr, 0);
 			if (*endptr) {
-				p_err("can't parse %s as index", **argv);
+				p_err("can't parse %s as index", *argv);
 				goto err_close_map;
 			}
 
-- 
2.17.1

