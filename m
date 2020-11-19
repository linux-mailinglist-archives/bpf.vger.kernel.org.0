Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249542B95CA
	for <lists+bpf@lfdr.de>; Thu, 19 Nov 2020 16:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgKSPHF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Nov 2020 10:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgKSPHF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Nov 2020 10:07:05 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB490C0613CF;
        Thu, 19 Nov 2020 07:07:04 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id p6so704674plr.7;
        Thu, 19 Nov 2020 07:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3/2A9is2WEPTFRw0DC0vVX4ZW3Yc7P4pYqVZ5bG5f/8=;
        b=qw811nZn6MfAqstt4ctA4L6zT/EqH0b/LwFDxRZktIZPA8Nu7DJ+sSLPw+PkQwpWjw
         WPJD2u0WeaCjlt5VJ+wrcPqKuweOyTOh2j7L5I2kZXXjM2GBpAqFaFgrQh7ORtXbt4vT
         3VwHMk++10xWIXF9mwPgf8NmM5c1yhzn1IvO514yKElHHG9W5xQ3/q7euG4Z39YA6pkD
         D2tUFXK4ktzS7R3TLE5cI7kQw5uJC+A9zCm7kayPhkAPhgXr7fcvjIDuKtd5zMofaqr8
         Htm/Ojab8kg8Jq1Dvm85U6Ad83shrIFUvu8rCiR5BqFSj5w0SaTVyp8rbxOtRteI7o+a
         jGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3/2A9is2WEPTFRw0DC0vVX4ZW3Yc7P4pYqVZ5bG5f/8=;
        b=mv6cxDhtstpw4yQKsH2LGAXPesE+eOw0bh481uyadgX5jUy3wZiHZIjcOpjvuOHBDR
         6fcjKqc/OtLchMMVlQfi0OOkGoRlIhoL65aUxTK1Wh48ariv0pA4Kp+8xZPkxWnqZLqd
         KBEgUPlVqUNaiQjvft5KXtujAnrQNnmhdez8JPXU2NWI8sjZKUfLCGJrdCLTC2mIVqiY
         AuRUoQxbcmPAgX6fvFL4Wtox5wGeC8VmcGsWdjRbRc/8l74nRbECc0X/bkaBu6EUprd8
         /0LW1HbXnfUmGR97D+UmcA27KA6PyHXGesza/n6IghaZuZ0pcg8Sg0i+OrkAHt0h5mhT
         /Fmw==
X-Gm-Message-State: AOAM533Zz1C/pZjCu8oIrFC8/XjF2WIOAd9nlOzRcoFp7qZpIdrB/ra3
        n0zpfG/rukeSYEjk/z33cg==
X-Google-Smtp-Source: ABdhPJxm0yQBdXAwroWM1kfgSiieyK/S2RUdFHJKPoaTQ6a1V9k7S0h5Yli0PAs477+MyCjmqyT5EA==
X-Received: by 2002:a17:902:a9c7:b029:d6:da66:253c with SMTP id b7-20020a170902a9c7b02900d6da66253cmr9451721plr.19.1605798424300;
        Thu, 19 Nov 2020 07:07:04 -0800 (PST)
Received: from localhost.localdomain ([182.209.58.45])
        by smtp.gmail.com with ESMTPSA id b80sm77783pfb.40.2020.11.19.07.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 07:07:03 -0800 (PST)
From:   "Daniel T. Lee" <danieltimlee@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, brakmo <brakmo@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        David Ahern <dsa@cumulusnetworks.com>,
        Yonghong Song <yhs@fb.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, Thomas Graf <tgraf@suug.ch>,
        Jakub Kicinski <kuba@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Xdp <xdp-newbies@vger.kernel.org>
Subject: [PATCH bpf-next v2 7/7] samples: bpf: remove bpf_load loader completely
Date:   Thu, 19 Nov 2020 15:06:17 +0000
Message-Id: <20201119150617.92010-8-danieltimlee@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201119150617.92010-1-danieltimlee@gmail.com>
References: <20201119150617.92010-1-danieltimlee@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Numerous refactoring that rewrites BPF programs written with bpf_load
to use the libbpf loader was finally completed, resulting in BPF
programs using bpf_load within the kernel being completely no longer
present.

This commit removes bpf_load, an outdated bpf loader that is difficult
to keep up with the latest kernel BPF and causes confusion.

Also, this commit removes the unused trace_helper and bpf_load from
samples/bpf target objects from Makefile.

Signed-off-by: Daniel T. Lee <danieltimlee@gmail.com>
Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
Changes in v2:
 - merge commit with changing Makefile

 samples/bpf/Makefile            |  10 +-
 samples/bpf/bpf_load.c          | 667 --------------------------------
 samples/bpf/bpf_load.h          |  57 ---
 samples/bpf/xdp2skb_meta_kern.c |   2 +-
 4 files changed, 5 insertions(+), 731 deletions(-)
 delete mode 100644 samples/bpf/bpf_load.c
 delete mode 100644 samples/bpf/bpf_load.h

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 25380e04897e..05db041f8b18 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -73,7 +73,7 @@ tracex5-objs := tracex5_user.o $(TRACE_HELPERS)
 tracex6-objs := tracex6_user.o
 tracex7-objs := tracex7_user.o
 test_probe_write_user-objs := test_probe_write_user_user.o
-trace_output-objs := trace_output_user.o $(TRACE_HELPERS)
+trace_output-objs := trace_output_user.o
 lathist-objs := lathist_user.o
 offwaketime-objs := offwaketime_user.o $(TRACE_HELPERS)
 spintest-objs := spintest_user.o $(TRACE_HELPERS)
@@ -91,8 +91,8 @@ test_current_task_under_cgroup-objs := $(CGROUP_HELPERS) \
 				       test_current_task_under_cgroup_user.o
 trace_event-objs := trace_event_user.o $(TRACE_HELPERS)
 sampleip-objs := sampleip_user.o $(TRACE_HELPERS)
-tc_l2_redirect-objs := bpf_load.o tc_l2_redirect_user.o
-lwt_len_hist-objs := bpf_load.o lwt_len_hist_user.o
+tc_l2_redirect-objs := tc_l2_redirect_user.o
+lwt_len_hist-objs := lwt_len_hist_user.o
 xdp_tx_iptunnel-objs := xdp_tx_iptunnel_user.o
 test_map_in_map-objs := test_map_in_map_user.o
 per_socket_stats_example-objs := cookie_uid_helper_example.o
@@ -108,7 +108,7 @@ xdpsock-objs := xdpsock_user.o
 xsk_fwd-objs := xsk_fwd.o
 xdp_fwd-objs := xdp_fwd_user.o
 task_fd_query-objs := task_fd_query_user.o $(TRACE_HELPERS)
-xdp_sample_pkts-objs := xdp_sample_pkts_user.o $(TRACE_HELPERS)
+xdp_sample_pkts-objs := xdp_sample_pkts_user.o
 ibumad-objs := ibumad_user.o
 hbm-objs := hbm.o $(CGROUP_HELPERS)
 
@@ -197,8 +197,6 @@ TPROGS_CFLAGS += --sysroot=$(SYSROOT)
 TPROGS_LDFLAGS := -L$(SYSROOT)/usr/lib
 endif
 
-TPROGCFLAGS_bpf_load.o += -Wno-unused-variable
-
 TPROGS_LDLIBS			+= $(LIBBPF) -lelf -lz
 TPROGLDLIBS_tracex4		+= -lrt
 TPROGLDLIBS_trace_output	+= -lrt
diff --git a/samples/bpf/bpf_load.c b/samples/bpf/bpf_load.c
deleted file mode 100644
index c5ad528f046e..000000000000
--- a/samples/bpf/bpf_load.c
+++ /dev/null
@@ -1,667 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <libelf.h>
-#include <gelf.h>
-#include <errno.h>
-#include <unistd.h>
-#include <string.h>
-#include <stdbool.h>
-#include <stdlib.h>
-#include <linux/bpf.h>
-#include <linux/filter.h>
-#include <linux/perf_event.h>
-#include <linux/netlink.h>
-#include <linux/rtnetlink.h>
-#include <linux/types.h>
-#include <sys/socket.h>
-#include <sys/syscall.h>
-#include <sys/ioctl.h>
-#include <sys/mman.h>
-#include <poll.h>
-#include <ctype.h>
-#include <assert.h>
-#include <bpf/bpf.h>
-#include "bpf_load.h"
-#include "perf-sys.h"
-
-#define DEBUGFS "/sys/kernel/debug/tracing/"
-
-static char license[128];
-static int kern_version;
-static bool processed_sec[128];
-char bpf_log_buf[BPF_LOG_BUF_SIZE];
-int map_fd[MAX_MAPS];
-int prog_fd[MAX_PROGS];
-int event_fd[MAX_PROGS];
-int prog_cnt;
-int prog_array_fd = -1;
-
-struct bpf_map_data map_data[MAX_MAPS];
-int map_data_count;
-
-static int populate_prog_array(const char *event, int prog_fd)
-{
-	int ind = atoi(event), err;
-
-	err = bpf_map_update_elem(prog_array_fd, &ind, &prog_fd, BPF_ANY);
-	if (err < 0) {
-		printf("failed to store prog_fd in prog_array\n");
-		return -1;
-	}
-	return 0;
-}
-
-static int write_kprobe_events(const char *val)
-{
-	int fd, ret, flags;
-
-	if (val == NULL)
-		return -1;
-	else if (val[0] == '\0')
-		flags = O_WRONLY | O_TRUNC;
-	else
-		flags = O_WRONLY | O_APPEND;
-
-	fd = open(DEBUGFS "kprobe_events", flags);
-
-	ret = write(fd, val, strlen(val));
-	close(fd);
-
-	return ret;
-}
-
-static int load_and_attach(const char *event, struct bpf_insn *prog, int size)
-{
-	bool is_socket = strncmp(event, "socket", 6) == 0;
-	bool is_kprobe = strncmp(event, "kprobe/", 7) == 0;
-	bool is_kretprobe = strncmp(event, "kretprobe/", 10) == 0;
-	bool is_tracepoint = strncmp(event, "tracepoint/", 11) == 0;
-	bool is_raw_tracepoint = strncmp(event, "raw_tracepoint/", 15) == 0;
-	bool is_xdp = strncmp(event, "xdp", 3) == 0;
-	bool is_perf_event = strncmp(event, "perf_event", 10) == 0;
-	bool is_cgroup_skb = strncmp(event, "cgroup/skb", 10) == 0;
-	bool is_cgroup_sk = strncmp(event, "cgroup/sock", 11) == 0;
-	bool is_sockops = strncmp(event, "sockops", 7) == 0;
-	bool is_sk_skb = strncmp(event, "sk_skb", 6) == 0;
-	bool is_sk_msg = strncmp(event, "sk_msg", 6) == 0;
-	size_t insns_cnt = size / sizeof(struct bpf_insn);
-	enum bpf_prog_type prog_type;
-	char buf[256];
-	int fd, efd, err, id;
-	struct perf_event_attr attr = {};
-
-	attr.type = PERF_TYPE_TRACEPOINT;
-	attr.sample_type = PERF_SAMPLE_RAW;
-	attr.sample_period = 1;
-	attr.wakeup_events = 1;
-
-	if (is_socket) {
-		prog_type = BPF_PROG_TYPE_SOCKET_FILTER;
-	} else if (is_kprobe || is_kretprobe) {
-		prog_type = BPF_PROG_TYPE_KPROBE;
-	} else if (is_tracepoint) {
-		prog_type = BPF_PROG_TYPE_TRACEPOINT;
-	} else if (is_raw_tracepoint) {
-		prog_type = BPF_PROG_TYPE_RAW_TRACEPOINT;
-	} else if (is_xdp) {
-		prog_type = BPF_PROG_TYPE_XDP;
-	} else if (is_perf_event) {
-		prog_type = BPF_PROG_TYPE_PERF_EVENT;
-	} else if (is_cgroup_skb) {
-		prog_type = BPF_PROG_TYPE_CGROUP_SKB;
-	} else if (is_cgroup_sk) {
-		prog_type = BPF_PROG_TYPE_CGROUP_SOCK;
-	} else if (is_sockops) {
-		prog_type = BPF_PROG_TYPE_SOCK_OPS;
-	} else if (is_sk_skb) {
-		prog_type = BPF_PROG_TYPE_SK_SKB;
-	} else if (is_sk_msg) {
-		prog_type = BPF_PROG_TYPE_SK_MSG;
-	} else {
-		printf("Unknown event '%s'\n", event);
-		return -1;
-	}
-
-	if (prog_cnt == MAX_PROGS)
-		return -1;
-
-	fd = bpf_load_program(prog_type, prog, insns_cnt, license, kern_version,
-			      bpf_log_buf, BPF_LOG_BUF_SIZE);
-	if (fd < 0) {
-		printf("bpf_load_program() err=%d\n%s", errno, bpf_log_buf);
-		return -1;
-	}
-
-	prog_fd[prog_cnt++] = fd;
-
-	if (is_xdp || is_perf_event || is_cgroup_skb || is_cgroup_sk)
-		return 0;
-
-	if (is_socket || is_sockops || is_sk_skb || is_sk_msg) {
-		if (is_socket)
-			event += 6;
-		else
-			event += 7;
-		if (*event != '/')
-			return 0;
-		event++;
-		if (!isdigit(*event)) {
-			printf("invalid prog number\n");
-			return -1;
-		}
-		return populate_prog_array(event, fd);
-	}
-
-	if (is_raw_tracepoint) {
-		efd = bpf_raw_tracepoint_open(event + 15, fd);
-		if (efd < 0) {
-			printf("tracepoint %s %s\n", event + 15, strerror(errno));
-			return -1;
-		}
-		event_fd[prog_cnt - 1] = efd;
-		return 0;
-	}
-
-	if (is_kprobe || is_kretprobe) {
-		bool need_normal_check = true;
-		const char *event_prefix = "";
-
-		if (is_kprobe)
-			event += 7;
-		else
-			event += 10;
-
-		if (*event == 0) {
-			printf("event name cannot be empty\n");
-			return -1;
-		}
-
-		if (isdigit(*event))
-			return populate_prog_array(event, fd);
-
-#ifdef __x86_64__
-		if (strncmp(event, "sys_", 4) == 0) {
-			snprintf(buf, sizeof(buf), "%c:__x64_%s __x64_%s",
-				is_kprobe ? 'p' : 'r', event, event);
-			err = write_kprobe_events(buf);
-			if (err >= 0) {
-				need_normal_check = false;
-				event_prefix = "__x64_";
-			}
-		}
-#endif
-		if (need_normal_check) {
-			snprintf(buf, sizeof(buf), "%c:%s %s",
-				is_kprobe ? 'p' : 'r', event, event);
-			err = write_kprobe_events(buf);
-			if (err < 0) {
-				printf("failed to create kprobe '%s' error '%s'\n",
-				       event, strerror(errno));
-				return -1;
-			}
-		}
-
-		strcpy(buf, DEBUGFS);
-		strcat(buf, "events/kprobes/");
-		strcat(buf, event_prefix);
-		strcat(buf, event);
-		strcat(buf, "/id");
-	} else if (is_tracepoint) {
-		event += 11;
-
-		if (*event == 0) {
-			printf("event name cannot be empty\n");
-			return -1;
-		}
-		strcpy(buf, DEBUGFS);
-		strcat(buf, "events/");
-		strcat(buf, event);
-		strcat(buf, "/id");
-	}
-
-	efd = open(buf, O_RDONLY, 0);
-	if (efd < 0) {
-		printf("failed to open event %s\n", event);
-		return -1;
-	}
-
-	err = read(efd, buf, sizeof(buf));
-	if (err < 0 || err >= sizeof(buf)) {
-		printf("read from '%s' failed '%s'\n", event, strerror(errno));
-		return -1;
-	}
-
-	close(efd);
-
-	buf[err] = 0;
-	id = atoi(buf);
-	attr.config = id;
-
-	efd = sys_perf_event_open(&attr, -1/*pid*/, 0/*cpu*/, -1/*group_fd*/, 0);
-	if (efd < 0) {
-		printf("event %d fd %d err %s\n", id, efd, strerror(errno));
-		return -1;
-	}
-	event_fd[prog_cnt - 1] = efd;
-	err = ioctl(efd, PERF_EVENT_IOC_ENABLE, 0);
-	if (err < 0) {
-		printf("ioctl PERF_EVENT_IOC_ENABLE failed err %s\n",
-		       strerror(errno));
-		return -1;
-	}
-	err = ioctl(efd, PERF_EVENT_IOC_SET_BPF, fd);
-	if (err < 0) {
-		printf("ioctl PERF_EVENT_IOC_SET_BPF failed err %s\n",
-		       strerror(errno));
-		return -1;
-	}
-
-	return 0;
-}
-
-static int load_maps(struct bpf_map_data *maps, int nr_maps,
-		     fixup_map_cb fixup_map)
-{
-	int i, numa_node;
-
-	for (i = 0; i < nr_maps; i++) {
-		if (fixup_map) {
-			fixup_map(&maps[i], i);
-			/* Allow userspace to assign map FD prior to creation */
-			if (maps[i].fd != -1) {
-				map_fd[i] = maps[i].fd;
-				continue;
-			}
-		}
-
-		numa_node = maps[i].def.map_flags & BPF_F_NUMA_NODE ?
-			maps[i].def.numa_node : -1;
-
-		if (maps[i].def.type == BPF_MAP_TYPE_ARRAY_OF_MAPS ||
-		    maps[i].def.type == BPF_MAP_TYPE_HASH_OF_MAPS) {
-			int inner_map_fd = map_fd[maps[i].def.inner_map_idx];
-
-			map_fd[i] = bpf_create_map_in_map_node(maps[i].def.type,
-							maps[i].name,
-							maps[i].def.key_size,
-							inner_map_fd,
-							maps[i].def.max_entries,
-							maps[i].def.map_flags,
-							numa_node);
-		} else {
-			map_fd[i] = bpf_create_map_node(maps[i].def.type,
-							maps[i].name,
-							maps[i].def.key_size,
-							maps[i].def.value_size,
-							maps[i].def.max_entries,
-							maps[i].def.map_flags,
-							numa_node);
-		}
-		if (map_fd[i] < 0) {
-			printf("failed to create map %d (%s): %d %s\n",
-			       i, maps[i].name, errno, strerror(errno));
-			return 1;
-		}
-		maps[i].fd = map_fd[i];
-
-		if (maps[i].def.type == BPF_MAP_TYPE_PROG_ARRAY)
-			prog_array_fd = map_fd[i];
-	}
-	return 0;
-}
-
-static int get_sec(Elf *elf, int i, GElf_Ehdr *ehdr, char **shname,
-		   GElf_Shdr *shdr, Elf_Data **data)
-{
-	Elf_Scn *scn;
-
-	scn = elf_getscn(elf, i);
-	if (!scn)
-		return 1;
-
-	if (gelf_getshdr(scn, shdr) != shdr)
-		return 2;
-
-	*shname = elf_strptr(elf, ehdr->e_shstrndx, shdr->sh_name);
-	if (!*shname || !shdr->sh_size)
-		return 3;
-
-	*data = elf_getdata(scn, 0);
-	if (!*data || elf_getdata(scn, *data) != NULL)
-		return 4;
-
-	return 0;
-}
-
-static int parse_relo_and_apply(Elf_Data *data, Elf_Data *symbols,
-				GElf_Shdr *shdr, struct bpf_insn *insn,
-				struct bpf_map_data *maps, int nr_maps)
-{
-	int i, nrels;
-
-	nrels = shdr->sh_size / shdr->sh_entsize;
-
-	for (i = 0; i < nrels; i++) {
-		GElf_Sym sym;
-		GElf_Rel rel;
-		unsigned int insn_idx;
-		bool match = false;
-		int j, map_idx;
-
-		gelf_getrel(data, i, &rel);
-
-		insn_idx = rel.r_offset / sizeof(struct bpf_insn);
-
-		gelf_getsym(symbols, GELF_R_SYM(rel.r_info), &sym);
-
-		if (insn[insn_idx].code != (BPF_LD | BPF_IMM | BPF_DW)) {
-			printf("invalid relo for insn[%d].code 0x%x\n",
-			       insn_idx, insn[insn_idx].code);
-			return 1;
-		}
-		insn[insn_idx].src_reg = BPF_PSEUDO_MAP_FD;
-
-		/* Match FD relocation against recorded map_data[] offset */
-		for (map_idx = 0; map_idx < nr_maps; map_idx++) {
-			if (maps[map_idx].elf_offset == sym.st_value) {
-				match = true;
-				break;
-			}
-		}
-		if (match) {
-			insn[insn_idx].imm = maps[map_idx].fd;
-		} else {
-			printf("invalid relo for insn[%d] no map_data match\n",
-			       insn_idx);
-			return 1;
-		}
-	}
-
-	return 0;
-}
-
-static int cmp_symbols(const void *l, const void *r)
-{
-	const GElf_Sym *lsym = (const GElf_Sym *)l;
-	const GElf_Sym *rsym = (const GElf_Sym *)r;
-
-	if (lsym->st_value < rsym->st_value)
-		return -1;
-	else if (lsym->st_value > rsym->st_value)
-		return 1;
-	else
-		return 0;
-}
-
-static int load_elf_maps_section(struct bpf_map_data *maps, int maps_shndx,
-				 Elf *elf, Elf_Data *symbols, int strtabidx)
-{
-	int map_sz_elf, map_sz_copy;
-	bool validate_zero = false;
-	Elf_Data *data_maps;
-	int i, nr_maps;
-	GElf_Sym *sym;
-	Elf_Scn *scn;
-	int copy_sz;
-
-	if (maps_shndx < 0)
-		return -EINVAL;
-	if (!symbols)
-		return -EINVAL;
-
-	/* Get data for maps section via elf index */
-	scn = elf_getscn(elf, maps_shndx);
-	if (scn)
-		data_maps = elf_getdata(scn, NULL);
-	if (!scn || !data_maps) {
-		printf("Failed to get Elf_Data from maps section %d\n",
-		       maps_shndx);
-		return -EINVAL;
-	}
-
-	/* For each map get corrosponding symbol table entry */
-	sym = calloc(MAX_MAPS+1, sizeof(GElf_Sym));
-	for (i = 0, nr_maps = 0; i < symbols->d_size / sizeof(GElf_Sym); i++) {
-		assert(nr_maps < MAX_MAPS+1);
-		if (!gelf_getsym(symbols, i, &sym[nr_maps]))
-			continue;
-		if (sym[nr_maps].st_shndx != maps_shndx)
-			continue;
-		/* Only increment iif maps section */
-		nr_maps++;
-	}
-
-	/* Align to map_fd[] order, via sort on offset in sym.st_value */
-	qsort(sym, nr_maps, sizeof(GElf_Sym), cmp_symbols);
-
-	/* Keeping compatible with ELF maps section changes
-	 * ------------------------------------------------
-	 * The program size of struct bpf_load_map_def is known by loader
-	 * code, but struct stored in ELF file can be different.
-	 *
-	 * Unfortunately sym[i].st_size is zero.  To calculate the
-	 * struct size stored in the ELF file, assume all struct have
-	 * the same size, and simply divide with number of map
-	 * symbols.
-	 */
-	map_sz_elf = data_maps->d_size / nr_maps;
-	map_sz_copy = sizeof(struct bpf_load_map_def);
-	if (map_sz_elf < map_sz_copy) {
-		/*
-		 * Backward compat, loading older ELF file with
-		 * smaller struct, keeping remaining bytes zero.
-		 */
-		map_sz_copy = map_sz_elf;
-	} else if (map_sz_elf > map_sz_copy) {
-		/*
-		 * Forward compat, loading newer ELF file with larger
-		 * struct with unknown features. Assume zero means
-		 * feature not used.  Thus, validate rest of struct
-		 * data is zero.
-		 */
-		validate_zero = true;
-	}
-
-	/* Memcpy relevant part of ELF maps data to loader maps */
-	for (i = 0; i < nr_maps; i++) {
-		struct bpf_load_map_def *def;
-		unsigned char *addr, *end;
-		const char *map_name;
-		size_t offset;
-
-		map_name = elf_strptr(elf, strtabidx, sym[i].st_name);
-		maps[i].name = strdup(map_name);
-		if (!maps[i].name) {
-			printf("strdup(%s): %s(%d)\n", map_name,
-			       strerror(errno), errno);
-			free(sym);
-			return -errno;
-		}
-
-		/* Symbol value is offset into ELF maps section data area */
-		offset = sym[i].st_value;
-		def = (struct bpf_load_map_def *)(data_maps->d_buf + offset);
-		maps[i].elf_offset = offset;
-		memset(&maps[i].def, 0, sizeof(struct bpf_load_map_def));
-		memcpy(&maps[i].def, def, map_sz_copy);
-
-		/* Verify no newer features were requested */
-		if (validate_zero) {
-			addr = (unsigned char *) def + map_sz_copy;
-			end  = (unsigned char *) def + map_sz_elf;
-			for (; addr < end; addr++) {
-				if (*addr != 0) {
-					free(sym);
-					return -EFBIG;
-				}
-			}
-		}
-	}
-
-	free(sym);
-	return nr_maps;
-}
-
-static int do_load_bpf_file(const char *path, fixup_map_cb fixup_map)
-{
-	int fd, i, ret, maps_shndx = -1, strtabidx = -1;
-	Elf *elf;
-	GElf_Ehdr ehdr;
-	GElf_Shdr shdr, shdr_prog;
-	Elf_Data *data, *data_prog, *data_maps = NULL, *symbols = NULL;
-	char *shname, *shname_prog;
-	int nr_maps = 0;
-
-	/* reset global variables */
-	kern_version = 0;
-	memset(license, 0, sizeof(license));
-	memset(processed_sec, 0, sizeof(processed_sec));
-
-	if (elf_version(EV_CURRENT) == EV_NONE)
-		return 1;
-
-	fd = open(path, O_RDONLY, 0);
-	if (fd < 0)
-		return 1;
-
-	elf = elf_begin(fd, ELF_C_READ, NULL);
-
-	if (!elf)
-		return 1;
-
-	if (gelf_getehdr(elf, &ehdr) != &ehdr)
-		return 1;
-
-	/* clear all kprobes */
-	i = write_kprobe_events("");
-
-	/* scan over all elf sections to get license and map info */
-	for (i = 1; i < ehdr.e_shnum; i++) {
-
-		if (get_sec(elf, i, &ehdr, &shname, &shdr, &data))
-			continue;
-
-		if (0) /* helpful for llvm debugging */
-			printf("section %d:%s data %p size %zd link %d flags %d\n",
-			       i, shname, data->d_buf, data->d_size,
-			       shdr.sh_link, (int) shdr.sh_flags);
-
-		if (strcmp(shname, "license") == 0) {
-			processed_sec[i] = true;
-			memcpy(license, data->d_buf, data->d_size);
-		} else if (strcmp(shname, "version") == 0) {
-			processed_sec[i] = true;
-			if (data->d_size != sizeof(int)) {
-				printf("invalid size of version section %zd\n",
-				       data->d_size);
-				return 1;
-			}
-			memcpy(&kern_version, data->d_buf, sizeof(int));
-		} else if (strcmp(shname, "maps") == 0) {
-			int j;
-
-			maps_shndx = i;
-			data_maps = data;
-			for (j = 0; j < MAX_MAPS; j++)
-				map_data[j].fd = -1;
-		} else if (shdr.sh_type == SHT_SYMTAB) {
-			strtabidx = shdr.sh_link;
-			symbols = data;
-		}
-	}
-
-	ret = 1;
-
-	if (!symbols) {
-		printf("missing SHT_SYMTAB section\n");
-		goto done;
-	}
-
-	if (data_maps) {
-		nr_maps = load_elf_maps_section(map_data, maps_shndx,
-						elf, symbols, strtabidx);
-		if (nr_maps < 0) {
-			printf("Error: Failed loading ELF maps (errno:%d):%s\n",
-			       nr_maps, strerror(-nr_maps));
-			goto done;
-		}
-		if (load_maps(map_data, nr_maps, fixup_map))
-			goto done;
-		map_data_count = nr_maps;
-
-		processed_sec[maps_shndx] = true;
-	}
-
-	/* process all relo sections, and rewrite bpf insns for maps */
-	for (i = 1; i < ehdr.e_shnum; i++) {
-		if (processed_sec[i])
-			continue;
-
-		if (get_sec(elf, i, &ehdr, &shname, &shdr, &data))
-			continue;
-
-		if (shdr.sh_type == SHT_REL) {
-			struct bpf_insn *insns;
-
-			/* locate prog sec that need map fixup (relocations) */
-			if (get_sec(elf, shdr.sh_info, &ehdr, &shname_prog,
-				    &shdr_prog, &data_prog))
-				continue;
-
-			if (shdr_prog.sh_type != SHT_PROGBITS ||
-			    !(shdr_prog.sh_flags & SHF_EXECINSTR))
-				continue;
-
-			insns = (struct bpf_insn *) data_prog->d_buf;
-			processed_sec[i] = true; /* relo section */
-
-			if (parse_relo_and_apply(data, symbols, &shdr, insns,
-						 map_data, nr_maps))
-				continue;
-		}
-	}
-
-	/* load programs */
-	for (i = 1; i < ehdr.e_shnum; i++) {
-
-		if (processed_sec[i])
-			continue;
-
-		if (get_sec(elf, i, &ehdr, &shname, &shdr, &data))
-			continue;
-
-		if (memcmp(shname, "kprobe/", 7) == 0 ||
-		    memcmp(shname, "kretprobe/", 10) == 0 ||
-		    memcmp(shname, "tracepoint/", 11) == 0 ||
-		    memcmp(shname, "raw_tracepoint/", 15) == 0 ||
-		    memcmp(shname, "xdp", 3) == 0 ||
-		    memcmp(shname, "perf_event", 10) == 0 ||
-		    memcmp(shname, "socket", 6) == 0 ||
-		    memcmp(shname, "cgroup/", 7) == 0 ||
-		    memcmp(shname, "sockops", 7) == 0 ||
-		    memcmp(shname, "sk_skb", 6) == 0 ||
-		    memcmp(shname, "sk_msg", 6) == 0) {
-			ret = load_and_attach(shname, data->d_buf,
-					      data->d_size);
-			if (ret != 0)
-				goto done;
-		}
-	}
-
-done:
-	close(fd);
-	return ret;
-}
-
-int load_bpf_file(char *path)
-{
-	return do_load_bpf_file(path, NULL);
-}
-
-int load_bpf_file_fixup_map(const char *path, fixup_map_cb fixup_map)
-{
-	return do_load_bpf_file(path, fixup_map);
-}
diff --git a/samples/bpf/bpf_load.h b/samples/bpf/bpf_load.h
deleted file mode 100644
index 4fcd258c616f..000000000000
--- a/samples/bpf/bpf_load.h
+++ /dev/null
@@ -1,57 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __BPF_LOAD_H
-#define __BPF_LOAD_H
-
-#include <bpf/bpf.h>
-
-#define MAX_MAPS 32
-#define MAX_PROGS 32
-
-struct bpf_load_map_def {
-	unsigned int type;
-	unsigned int key_size;
-	unsigned int value_size;
-	unsigned int max_entries;
-	unsigned int map_flags;
-	unsigned int inner_map_idx;
-	unsigned int numa_node;
-};
-
-struct bpf_map_data {
-	int fd;
-	char *name;
-	size_t elf_offset;
-	struct bpf_load_map_def def;
-};
-
-typedef void (*fixup_map_cb)(struct bpf_map_data *map, int idx);
-
-extern int prog_fd[MAX_PROGS];
-extern int event_fd[MAX_PROGS];
-extern char bpf_log_buf[BPF_LOG_BUF_SIZE];
-extern int prog_cnt;
-
-/* There is a one-to-one mapping between map_fd[] and map_data[].
- * The map_data[] just contains more rich info on the given map.
- */
-extern int map_fd[MAX_MAPS];
-extern struct bpf_map_data map_data[MAX_MAPS];
-extern int map_data_count;
-
-/* parses elf file compiled by llvm .c->.o
- * . parses 'maps' section and creates maps via BPF syscall
- * . parses 'license' section and passes it to syscall
- * . parses elf relocations for BPF maps and adjusts BPF_LD_IMM64 insns by
- *   storing map_fd into insn->imm and marking such insns as BPF_PSEUDO_MAP_FD
- * . loads eBPF programs via BPF syscall
- *
- * One ELF file can contain multiple BPF programs which will be loaded
- * and their FDs stored stored in prog_fd array
- *
- * returns zero on success
- */
-int load_bpf_file(char *path);
-int load_bpf_file_fixup_map(const char *path, fixup_map_cb fixup_map);
-
-int bpf_set_link_xdp_fd(int ifindex, int fd, __u32 flags);
-#endif
diff --git a/samples/bpf/xdp2skb_meta_kern.c b/samples/bpf/xdp2skb_meta_kern.c
index 9b783316e860..d5631014a176 100644
--- a/samples/bpf/xdp2skb_meta_kern.c
+++ b/samples/bpf/xdp2skb_meta_kern.c
@@ -6,7 +6,7 @@
  * This uses the XDP data_meta infrastructure, and is a cooperation
  * between two bpf-programs (1) XDP and (2) clsact at TC-ingress hook.
  *
- * Notice: This example does not use the BPF C-loader (bpf_load.c),
+ * Notice: This example does not use the BPF C-loader,
  * but instead rely on the iproute2 TC tool for loading BPF-objects.
  */
 #include <uapi/linux/bpf.h>
-- 
2.25.1

