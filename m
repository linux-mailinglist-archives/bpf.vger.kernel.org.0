Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 900D336DE3
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2019 09:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfFFH4r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jun 2019 03:56:47 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:42132 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFFH4q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jun 2019 03:56:46 -0400
Received: by mail-yb1-f194.google.com with SMTP id c7so595442ybs.9
        for <bpf@vger.kernel.org>; Thu, 06 Jun 2019 00:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TbM9vdATYDfk/+/NGyr5Ij8vLHhNayhJciB4ayq0pHE=;
        b=MM6OcPwAJE1POnI9pGXHiBCNozL4ZBtxEn7ju0XByHG94g+QwzU/iiSy44DRpp3Unm
         FYPVos2EGcDv26xHAbZRORvla6calNQz4bJPO419a6f/RVB0FqB0wnH1K0bpliXR0snw
         7ot9cbH/X6rWk2AYvw88dVCramLl96KtBpZ1KfzV2MpsNBY4AyKGEvjdqNYoBwh/sjkW
         gUEd8CXA/N5zkn4EkSVFtCQDgodRSQ8TkO+0BilrhFBNsCQ9aIwwObLfuDN5/Oj/vvQl
         TW6ZP85+pOrzanq+88wrhLAf+HYTSw9GTGEEHwRyRLCTKy19juEFCNEovH81pwPXf6dP
         ohkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TbM9vdATYDfk/+/NGyr5Ij8vLHhNayhJciB4ayq0pHE=;
        b=tHsehsJQGjjp9hw/Mq9cEAYVEPXXTxsg+yne51f5sAKDbEnCL0MsBvKCMUzuFQIxCt
         wQVGheFEHu1ICAySgIOJuSQG7XLTShGcEbGja+XHKbmxmAHx1XMhcdEnM2Gv7jcDS3Tv
         10XuQu47ZNck0Bn7BU+qISau4Bt/ekSOUTLWmzIYqfka1Li7CPKhdZe09n+HMaD8swQ0
         PnA24gOZj43zHKUuGoKZkZJCEgw4xbyDJNAi1Li7NKcUb463zhOIzZi+6hrAO09lVi9X
         SDaC4z3hwheg7ROSlI6kZc/4Agu27/V6JVEhdoiezr395qfQvJmRA971yZnQ22wdg41I
         IBaw==
X-Gm-Message-State: APjAAAU54eOjAtAjtvjmF5wDThT4VUEBN1vcKCnuIFhcoKNyk1iA0O1l
        Z0bVgQzBIgLoFkEyhMNNfRvEYw==
X-Google-Smtp-Source: APXvYqyWosIZanguJxKE04Kd7LwXDfXHs6VXKz4KUpNZjHz3aUn6GagJhTSRzUxbsFQg51yD4tu8FA==
X-Received: by 2002:a25:410f:: with SMTP id o15mr20004920yba.328.1559807806138;
        Thu, 06 Jun 2019 00:56:46 -0700 (PDT)
Received: from localhost.localdomain (li1322-146.members.linode.com. [45.79.223.146])
        by smtp.gmail.com with ESMTPSA id 14sm316343yws.16.2019.06.06.00.56.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 00:56:45 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 1/4] perf trace: Exit when build eBPF program failure
Date:   Thu,  6 Jun 2019 15:56:14 +0800
Message-Id: <20190606075617.14327-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190606075617.14327-1-leo.yan@linaro.org>
References: <20190606075617.14327-1-leo.yan@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On my Juno board with ARM64 CPUs, perf trace command reports the eBPF
program building failure but the command will not exit and continue to
run.  If we define an eBPF event in config file, the event will be
parsed with below flow:

  perf_config()
    `> trace__config()
	 `> parse_events_option()
	      `> parse_events__scanner()
	           `-> parse_events_parse()
	                 `> parse_events_load_bpf()
	                      `> llvm__compile_bpf()

Though the low level functions return back error values when detect eBPF
building failure, but parse_events_option() returns 1 for this case and
trace__config() passes 1 to perf_config(); perf_config() doesn't treat
the returned value 1 as failure and it continues to parse other
configurations.  Thus the perf command continues to run even without
enabling eBPF event successfully.

This patch changes error handling in trace__config(), when it detects
failure it will return -1 rather than directly pass error value (1);
finally, perf_config() will directly bail out and perf will exit for
this case.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-trace.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 54b2d0fd0d02..4b5d004aab74 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3664,6 +3664,14 @@ static int trace__config(const char *var, const char *value, void *arg)
 					       "event selector. use 'perf list' to list available events",
 					       parse_events_option);
 		err = parse_events_option(&o, value, 0);
+
+		/*
+		 * When parse option successfully parse_events_option() will
+		 * return 0, otherwise means the paring failure.  And it
+		 * returns 1 for eBPF program building failure; so adjust the
+		 * err value to -1 for the failure.
+		 */
+		err = err ? -1 : 0;
 	} else if (!strcmp(var, "trace.show_timestamp")) {
 		trace->show_tstamp = perf_config_bool(var, value);
 	} else if (!strcmp(var, "trace.show_duration")) {
-- 
2.17.1

