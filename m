Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9094416EF4B
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2020 20:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731300AbgBYTpC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Feb 2020 14:45:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:55652 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731195AbgBYTpC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Feb 2020 14:45:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F0231B012;
        Tue, 25 Feb 2020 19:44:59 +0000 (UTC)
From:   Michal Rostecki <mrostecki@opensuse.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v3 4/5] bpftool: Update bash completion for "bpftool feature" command
Date:   Tue, 25 Feb 2020 20:44:42 +0100
Message-Id: <20200225194446.20651-5-mrostecki@opensuse.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200225194446.20651-1-mrostecki@opensuse.org>
References: <20200225194446.20651-1-mrostecki@opensuse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Update bash completion for "bpftool feature" command with the new
argument: "full".

Signed-off-by: Michal Rostecki <mrostecki@opensuse.org>
---
 tools/bpf/bpftool/bash-completion/bpftool | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 754d8395e451..acd5ea76c91d 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -983,11 +983,12 @@ _bpftool()
                 probe)
                     [[ $prev == "prefix" ]] && return 0
                     if _bpftool_search_list 'macros'; then
-                        COMPREPLY+=( $( compgen -W 'prefix' -- "$cur" ) )
+                        _bpftool_once_attr 'prefix'
                     else
                         COMPREPLY+=( $( compgen -W 'macros' -- "$cur" ) )
                     fi
                     _bpftool_one_of_list 'kernel dev'
+                    _bpftool_once_attr 'full'
                     return 0
                     ;;
                 *)
-- 
2.25.1

