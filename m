Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F266D7D9C
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 15:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238265AbjDENVt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 09:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238110AbjDENVr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 09:21:47 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258745FCA
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 06:21:31 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m8so9965913wmq.5
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 06:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680700889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hO/P1RTN+ZeQ7JsZ/y5Y2Qjz2b77je0xWLXgsB+vN94=;
        b=ACdZZ0cJdzzuhM/iOt9xbnd7e5qyiYmTFJqZm8OthUuWhp9Ow8oP7gogaxlCURRX/A
         ZL0lwGRNoCCOsBF+tWdVzc0BusEnIuf1s/WfaK3Odp/2ApuYwDL11uQaBEuu5/tErMB9
         gxh0LYUEp82LiBZE+UNMUQ8388dT+hWi6j5FDz4nO2qcAx0YTWnCwRMxSDxD/EvEIJ2A
         kTLpWM90zRvkacNi89tA5qdrKAOsFYhCg9sifnCnFixQafaTnI1HN8RX5LK0W4dmBcQH
         1k5Dx8vVJ30j3uKHkvfVd0krNOgOacT5Wuo/PVVwanGggPbiwJKbJA5teIHLGFKXlN0E
         X9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680700889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hO/P1RTN+ZeQ7JsZ/y5Y2Qjz2b77je0xWLXgsB+vN94=;
        b=2nbqXllQ7QnGxWbRqmAeGGDz5jhxEDjsYceRV530UBe7MqnzmEeTf/98dtTIXT7S3Q
         AfVTEcdxvFI4i+A2vOQ53v4ZzmwE3RWokGWjw+UAU2t/TcylMS5SBqdezT7OYOyXP4wF
         Y+ryIy5Owlqa+VxWVshiIT99lYjYa1NrAnQOsUYEbxuPSNN60VaE17FrbJUoGtfbGFlO
         quzZQAYT52HVyTgJEqqNRq8XuANVFtlNAhjSY2Kj+XnEpNAYuiDsg1dYRZiOTYbjNL9w
         12pXaeOry9UNSEtOMXGtrRzltEhq42Eu/fFJ+caKBuFE5HSWKoyQhJFG/Bv19PCFbsTh
         AKWA==
X-Gm-Message-State: AAQBX9eLEfSeXqlp5q308AJABw7pj0j6sYlrSB5egPOs6pKHqeshsIIP
        sIieRei3OH9X5mvcBhi3L8KtMg==
X-Google-Smtp-Source: AKy350bKKuiAUg3asQ955dsNmvVFXp0B3olUCpLDIGhoHtVhabu/k2mvn+9cZn9BH3MSyKmT5Kwcyg==
X-Received: by 2002:a05:600c:2312:b0:3f0:310c:e3ce with SMTP id 18-20020a05600c231200b003f0310ce3cemr4496658wmo.17.1680700889641;
        Wed, 05 Apr 2023 06:21:29 -0700 (PDT)
Received: from harfang.fritz.box ([2a02:8011:e80c:0:8147:b5f5:f4cc:b39b])
        by smtp.gmail.com with ESMTPSA id c22-20020a05600c0ad600b003ed243222adsm2147306wmr.42.2023.04.05.06.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 06:21:29 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, Eduard Zingerman <eddyz87@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v3 7/7] bpftool: Clean up _bpftool_once_attr() calls in bash completion
Date:   Wed,  5 Apr 2023 14:21:20 +0100
Message-Id: <20230405132120.59886-8-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230405132120.59886-1-quentin@isovalent.com>
References: <20230405132120.59886-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In bpftool's bash completion file, function _bpftool_once_attr() is able
to process multiple arguments. There are a few locations where this
function is called multiple times in a row, each time for a single
argument; let's pass all arguments instead to minimize the number of
function calls required for the completion.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/bash-completion/bpftool | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 69c64dc18b1d..e7234d1a5306 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -508,10 +508,7 @@ _bpftool()
                             ;;
                         *)
                             COMPREPLY=( $( compgen -W "map" -- "$cur" ) )
-                            _bpftool_once_attr 'type'
-                            _bpftool_once_attr 'dev'
-                            _bpftool_once_attr 'pinmaps'
-                            _bpftool_once_attr 'autoattach'
+                            _bpftool_once_attr 'type dev pinmaps autoattach'
                             return 0
                             ;;
                     esac
@@ -736,16 +733,10 @@ _bpftool()
                             esac
                             ;;
                         *)
-                            _bpftool_once_attr 'type'
-                            _bpftool_once_attr 'key'
-                            _bpftool_once_attr 'value'
-                            _bpftool_once_attr 'entries'
-                            _bpftool_once_attr 'name'
-                            _bpftool_once_attr 'flags'
+                            _bpftool_once_attr 'type key value entries name flags dev'
                             if _bpftool_search_list 'array_of_maps' 'hash_of_maps'; then
                                 _bpftool_once_attr 'inner_map'
                             fi
-                            _bpftool_once_attr 'dev'
                             return 0
                             ;;
                     esac
@@ -886,8 +877,7 @@ _bpftool()
                             return 0
                             ;;
                         *)
-                            _bpftool_once_attr 'cpu'
-                            _bpftool_once_attr 'index'
+                            _bpftool_once_attr 'cpu index'
                             return 0
                             ;;
                     esac
-- 
2.34.1

