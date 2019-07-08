Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C41361F42
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2019 15:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbfGHNF5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Jul 2019 09:05:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55831 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731234AbfGHNF5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jul 2019 09:05:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id a15so15723120wmj.5
        for <bpf@vger.kernel.org>; Mon, 08 Jul 2019 06:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=kBezTPnTqCdw/0P9uielP/zWUgvOGL03R8LDl/7B9T8=;
        b=NSP2kfayAA1WDdyujC07ifgcQM5x8ZXh/o54O8PTO9r5iuP7Ho/45raHRYY2iWccaa
         3R82z13r+qtV1wSU6hzPhaHO2EgiB51XB6rLIZ3g2GfLu5f/dOEeC/lLTUerFzFSuzvw
         q0PHmefmB2A7FwLqDHUg6x8TwWUHkNfNRQGYL6RtktvoKYE58iuj/cF6LhjFe4MgQDI5
         MFDCmCy+QbBUpvL1ywd5bIutSMcm57oid1Uw9M1shjnHy/+nt3ln54rfVtxcJrvWtnm9
         LOfCrYkWbsbX8mXp2ZC6uy6Au17R52zHE/Gx1etJGoUPRhJu1jv1RrG5tW8M4MqtbgPl
         J4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kBezTPnTqCdw/0P9uielP/zWUgvOGL03R8LDl/7B9T8=;
        b=p77u0gXyAHZ6zJ1ZRIUexrFOsvqB0tH2YyLcvEtClu71wngZmfLmAteLXETEbrh44v
         4J7lEdnxGZ6xOIV3tyF1WgLL82ccq3nucrDUAPGdwy+SpUqwlXkcwSBuLQl1vhCwyMvD
         KxEY5PAsxRUaUKwPe5zKbP6sNBvylwP22DfFbYuHGWfySdXaTmqkoJwRhPKmsMKuUpo+
         vsq2mqm4uk4P9G4Gk7bkJnh60P4z65c93vmJNfRjaKo4TljZWZ6otYtOGoCzm9XG3i7b
         5PgnPxQ2VkEfESe/aIJqTnvMObyl59qEVymPtcAEAZm3XyK3u3YJjqY++q8OxUWVLGUx
         RqYw==
X-Gm-Message-State: APjAAAV5OlMdrN9TWRvDEOgB56C6g88UdhcSTz8peE5cSdN7YpkpRKZ3
        tpi6udr4G5kJiEDpwJgrmYs1MQ==
X-Google-Smtp-Source: APXvYqxhyXd5o6GGE395XRWyVBg429XqKT+TCdbjcC21qLXaWyUeiWfiFWIA0RhNJlXSJXlFWHGWpQ==
X-Received: by 2002:a1c:1a4c:: with SMTP id a73mr12568041wma.109.1562591155504;
        Mon, 08 Jul 2019 06:05:55 -0700 (PDT)
Received: from cbtest32.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id e7sm16059575wmd.0.2019.07.08.06.05.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 06:05:54 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH bpf-next] tools: bpftool: add completion for bpftool prog "loadall"
Date:   Mon,  8 Jul 2019 14:05:46 +0100
Message-Id: <20190708130546.7518-1-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.17.1
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bash completion for proposing the "loadall" subcommand is missing. Let's
add it to the completion script.

Add a specific case to propose "load" and "loadall" for completing:

    $ bpftool prog load
                       ^ cursor is here

Otherwise, completion considers that $command is in load|loadall and
starts making related completions (file or directory names, as the
number of words on the command line is below 6), when the only suggested
keywords should be "load" and "loadall" until one has been picked and a
space entered after that to move to the next word.

Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 tools/bpf/bpftool/bash-completion/bpftool | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 965a8658cca3..c8f42e1fcbc9 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -342,6 +342,13 @@ _bpftool()
                 load|loadall)
                     local obj
 
+                    # Propose "load/loadall" to complete "bpftool prog load",
+                    # or bash tries to complete "load" as a filename below.
+                    if [[ ${#words[@]} -eq 3 ]]; then
+                        COMPREPLY=( $( compgen -W "load loadall" -- "$cur" ) )
+                        return 0
+                    fi
+
                     if [[ ${#words[@]} -lt 6 ]]; then
                         _filedir
                         return 0
@@ -435,7 +442,7 @@ _bpftool()
                 *)
                     [[ $prev == $object ]] && \
                         COMPREPLY=( $( compgen -W 'dump help pin attach detach \
-                            load show list tracelog run' -- "$cur" ) )
+                            load loadall show list tracelog run' -- "$cur" ) )
                     ;;
             esac
             ;;
-- 
2.17.1

