Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEB8561675
	for <lists+bpf@lfdr.de>; Thu, 30 Jun 2022 11:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbiF3Jgn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jun 2022 05:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbiF3Jgm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jun 2022 05:36:42 -0400
Received: from sym2.noone.org (sym.noone.org [IPv6:2a01:4f8:120:4161::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD3D42EE6
        for <bpf@vger.kernel.org>; Thu, 30 Jun 2022 02:36:41 -0700 (PDT)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4LYYBH0r2Yzvjfm; Thu, 30 Jun 2022 11:36:38 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     bpf@vger.kernel.org
Subject: [PATCH bpf-next] bpftool: remove attach_type_name forward declaration
Date:   Thu, 30 Jun 2022 11:36:38 +0200
Message-Id: <20220630093638.25916-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The attach_type_name definition was removed in commit 1ba5ad36e00f
("bpftool: Use libbpf_bpf_attach_type_str"). Remove its forward
declaration in main.h as well.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 tools/bpf/bpftool/main.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 589cb76b227a..5e5060c2ac04 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -63,8 +63,6 @@ static inline void *u64_to_ptr(__u64 ptr)
 #define HELP_SPEC_LINK							\
 	"LINK := { id LINK_ID | pinned FILE }"
 
-extern const char * const attach_type_name[__MAX_BPF_ATTACH_TYPE];
-
 /* keep in sync with the definition in skeleton/pid_iter.bpf.c */
 enum bpf_obj_type {
 	BPF_OBJ_UNKNOWN,
-- 
2.36.1

