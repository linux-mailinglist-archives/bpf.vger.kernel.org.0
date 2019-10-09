Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D62DD19D5
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2019 22:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbfJIUlo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Oct 2019 16:41:44 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:38141 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731878AbfJIUlo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Oct 2019 16:41:44 -0400
Received: by mail-lj1-f171.google.com with SMTP id b20so3880121ljj.5
        for <bpf@vger.kernel.org>; Wed, 09 Oct 2019 13:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y12OqUDXt0uUd8S/w/N9B4j5fJB9b6dEGe48WxLpJQ0=;
        b=b82CPx+fPly56w9MPycjqjk9NJFrcqTUC+lMTY5z15BMRw4pELbH/XPZ+RJefWuxPY
         Ve+lIxc6pQd+2yDHo9zcMjT2RLJUqoXNChE9oUJ1xBcEkkjBJsESNa9GWmIK6Li9Rbkw
         2gsZITjElYlpNfxDj0t7SIHmbzIKhfrXgQQ0eutD4pIHkl55qf+nSBf/bZYmQNvZSkgO
         bLliGWmkU+bpjvxPedusjcxCZqk6Z8tNN3fiXpA9lu1SC9hixLlHu7am+/BzaOY0OlQc
         nx3uyOZj9pepIabNtCEHnzksYGri285CEa6jAL/ZaogaUkfB9TcjD1KrdFRk5hVdInNL
         Q7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y12OqUDXt0uUd8S/w/N9B4j5fJB9b6dEGe48WxLpJQ0=;
        b=qjSJcJbHlLAiGLAgifAn1ua3IFjrgIwXwbf41aZN0Mt+gYkf+/c3HFjqDEy3hl9ron
         X90isZAytGhZSy1coqgQNSrPK/4JFsSAu5EG75cMp22JkC3hYBGyyHo2dXiF+EYK42Zk
         1zYqNjLkGTlwR6wsKNtN8xKLocWu/gLY5jdP8EUICIulmAJSQCTU8PtXyq4VoV4JTD/d
         K6/cAQFvYc1jNaGqLckrHc5/nHVrIdP0FTwGZP62oT9hobhkcnM+lfoc8bB6oJ/72bsR
         PdK3jbl2aIHor5x/cDzRf/AzAT1JDtdohKgtPPzH+Kzh175/IGBihQJmHJRlD4K8c/Fw
         FLhA==
X-Gm-Message-State: APjAAAUozHsR7fUylvmazlBN729X6+FQIUxh4slb9QBl5HuuomGG5Nyc
        lQ/3yawu/rljNi74LjQPpzuFSg==
X-Google-Smtp-Source: APXvYqz9ZmT3mmRmWoZneEqLxJDx7rmmR3dC+5Tb7MVDbitwoik3uWhRkcyt0PDRQ6WmBWMTwbR9xA==
X-Received: by 2002:a2e:7e05:: with SMTP id z5mr3623227ljc.120.1570653702474;
        Wed, 09 Oct 2019 13:41:42 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id h3sm730871ljf.12.2019.10.09.13.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 13:41:41 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        ilias.apalodimas@linaro.org, sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v4 bpf-next 02/15] samples/bpf: fix cookie_uid_helper_example obj build
Date:   Wed,  9 Oct 2019 23:41:21 +0300
Message-Id: <20191009204134.26960-3-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191009204134.26960-1-ivan.khoronzhuk@linaro.org>
References: <20191009204134.26960-1-ivan.khoronzhuk@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Don't list userspace "cookie_uid_helper_example" object in list for
bpf objects.

'always' target is used for listing bpf programs, but
'cookie_uid_helper_example.o' is a user space ELF file, and covered
by rule `per_socket_stats_example`, so shouldn't be in 'always'.
Let us remove `always += cookie_uid_helper_example.o`, which avoids
breaking cross compilation due to mismatched includes.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 4f61725b1d86..045fa43842e6 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -145,7 +145,6 @@ always += sampleip_kern.o
 always += lwt_len_hist_kern.o
 always += xdp_tx_iptunnel_kern.o
 always += test_map_in_map_kern.o
-always += cookie_uid_helper_example.o
 always += tcp_synrto_kern.o
 always += tcp_rwnd_kern.o
 always += tcp_bufs_kern.o
-- 
2.17.1

