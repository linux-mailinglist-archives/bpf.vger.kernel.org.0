Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5FF204F68
	for <lists+bpf@lfdr.de>; Tue, 23 Jun 2020 12:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732191AbgFWKme (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Jun 2020 06:42:34 -0400
Received: from sym2.noone.org ([178.63.92.236]:51010 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732172AbgFWKme (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jun 2020 06:42:34 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 49rjXQ6PDhzvjc1; Tue, 23 Jun 2020 12:42:27 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Quentin Monnet <quentin@isovalent.com>, bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 0/2] tools, bpftool: Define name arrays only once
Date:   Tue, 23 Jun 2020 12:42:25 +0200
Message-Id: <20200623104227.11435-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Define the prog_type_name and attach_type_name only once by moving them
out of main.h. This slightly reduces the binary size of bpftool:

Before:

   text	   data	    bss	    dec	    hex	filename
 401032	  11936	1573160	1986128	 1e4e50	bpftool

After:

   text	   data	    bss	    dec	    hex	filename
 398256	  10880	1573160	1982296	 1e3f58	bpftool

Tobias Klauser (2):
  tools, bpftool: Define prog_type_name array only once
  tools, bpftool: Define attach_type_name array only once

 tools/bpf/bpftool/common.c  | 36 +++++++++++++++++++
 tools/bpf/bpftool/feature.c |  4 +--
 tools/bpf/bpftool/link.c    |  4 +--
 tools/bpf/bpftool/main.h    | 69 ++-----------------------------------
 tools/bpf/bpftool/map.c     |  4 +--
 tools/bpf/bpftool/prog.c    | 34 ++++++++++++++++++
 6 files changed, 79 insertions(+), 72 deletions(-)

-- 
2.27.0

