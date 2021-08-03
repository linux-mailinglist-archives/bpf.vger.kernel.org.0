Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759103DE3C2
	for <lists+bpf@lfdr.de>; Tue,  3 Aug 2021 03:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbhHCBEA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Aug 2021 21:04:00 -0400
Received: from mga07.intel.com ([134.134.136.100]:65282 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233050AbhHCBEA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Aug 2021 21:04:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="277327836"
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; 
   d="scan'208";a="277327836"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 18:03:49 -0700
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; 
   d="scan'208";a="419480111"
Received: from ticela-or-032.amr.corp.intel.com (HELO localhost.localdomain) ([10.212.166.34])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 18:03:49 -0700
From:   Ederson de Souza <ederson.desouza@intel.com>
To:     xdp-hints@xdp-project.net
Cc:     bpf@vger.kernel.org, Saeed Mahameed <saeedm@mellanox.com>
Subject: [[RFC xdp-hints] 04/16] tools/bpf: Add xdp set command for md btf
Date:   Mon,  2 Aug 2021 18:03:19 -0700
Message-Id: <20210803010331.39453-5-ederson.desouza@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210803010331.39453-1-ederson.desouza@intel.com>
References: <20210803010331.39453-1-ederson.desouza@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Saeed Mahameed <saeedm@mellanox.com>

Introduce a new bpftool net subcommand and use it to report and set XDP
attributes:

$ /usr/local/sbin/bpftool net xdp help
Usage: /usr/local/sbin/bpftool xdp xdp { show | list | set | md_btf} [dev <devname>]
       /usr/local/sbin/bpftool xdp help

$ /usr/local/sbin/bpftool net xdp set dev mlx0 md_btf on

$ /usr/local/sbin/bpftool net xdp show
xdp:
mlx0(3) md_btf_id(1) md_btf_enabled(1)

Issue: 2114293
Change-Id: Id6abe633209852b4957001fcbee6e8b1ae248e4b
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
---
 tools/bpf/bpftool/main.h |   3 +-
 tools/bpf/bpftool/net.c  |   7 +-
 tools/bpf/bpftool/xdp.c  | 310 +++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   |   2 +
 tools/lib/bpf/libbpf.map |   1 +
 tools/lib/bpf/netlink.c  |  49 +++++++
 6 files changed, 368 insertions(+), 4 deletions(-)
 create mode 100644 tools/bpf/bpftool/xdp.c

diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index c1cf29798b99..cb2ff2083000 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -168,7 +168,6 @@ int mount_bpffs_for_pin(const char *name);
 int do_pin_any(int argc, char **argv, int (*get_fd_by_id)(int *, char ***));
 int do_pin_fd(int fd, const char *name);
 
-/* commands available in bootstrap mode */
 int do_gen(int argc, char **argv);
 int do_btf(int argc, char **argv);
 
@@ -180,6 +179,7 @@ int do_event_pipe(int argc, char **argv) __weak;
 int do_cgroup(int argc, char **arg) __weak;
 int do_perf(int argc, char **arg) __weak;
 int do_net(int argc, char **arg) __weak;
+int do_xdp(int argc, char **arg) __weak;
 int do_tracelog(int argc, char **arg) __weak;
 int do_feature(int argc, char **argv) __weak;
 int do_struct_ops(int argc, char **argv) __weak;
@@ -257,6 +257,7 @@ struct tcmsg;
 int do_xdp_dump(struct ifinfomsg *ifinfo, struct nlattr **tb);
 int do_filter_dump(struct tcmsg *ifinfo, struct nlattr **tb, const char *kind,
 		   const char *devname, int ifindex);
+int xdp_dump_link_nlmsg(void *cookie, void *msg, struct nlattr **tb);
 
 int print_all_levels(__maybe_unused enum libbpf_print_level level,
 		     const char *format, va_list args);
diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index f836d115d7d6..264350a3ca3b 100644
--- a/tools/bpf/bpftool/net.c
+++ b/tools/bpf/bpftool/net.c
@@ -349,7 +349,7 @@ static int netlink_get_link(int sock, unsigned int nl_pid,
 			    dump_link_nlmsg, cookie);
 }
 
-static int dump_link_nlmsg(void *cookie, void *msg, struct nlattr **tb)
+int xdp_dump_link_nlmsg(void *cookie, void *msg, struct nlattr **tb)
 {
 	struct bpf_netdev_t *netinfo = cookie;
 	struct ifinfomsg *ifinfo = msg;
@@ -680,7 +680,7 @@ static int do_show(int argc, char **argv)
 		jsonw_start_array(json_wtr);
 	NET_START_OBJECT;
 	NET_START_ARRAY("xdp", "%s:\n");
-	ret = netlink_get_link(sock, nl_pid, dump_link_nlmsg, &dev_array);
+	ret = netlink_get_link(sock, nl_pid, xdp_dump_link_nlmsg, &dev_array);
 	NET_END_ARRAY("\n");
 
 	if (!ret) {
@@ -722,7 +722,7 @@ static int do_help(int argc, char **argv)
 	}
 
 	fprintf(stderr,
-		"Usage: %1$s %2$s { show | list } [dev <devname>]\n"
+		"Usage: %1$s %2$s { show | list | xdp } [dev <devname>]\n"
 		"       %1$s %2$s attach ATTACH_TYPE PROG dev <devname> [ overwrite ]\n"
 		"       %1$s %2$s detach ATTACH_TYPE dev <devname>\n"
 		"       %1$s %2$s help\n"
@@ -746,6 +746,7 @@ static const struct cmd cmds[] = {
 	{ "list",	do_show },
 	{ "attach",	do_attach },
 	{ "detach",	do_detach },
+	{ "xdp",	do_xdp },
 	{ "help",	do_help },
 	{ 0 }
 };
diff --git a/tools/bpf/bpftool/xdp.c b/tools/bpf/bpftool/xdp.c
new file mode 100644
index 000000000000..f38d692d187c
--- /dev/null
+++ b/tools/bpf/bpftool/xdp.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+// Copyright (C) 2019 Mellanox.
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <time.h>
+#include <net/if.h>
+#include <linux/if.h>
+#include <linux/rtnetlink.h>
+#include <sys/socket.h>
+
+#include "bpf/nlattr.h"
+#include "main.h"
+#include "netlink_dumper.h"
+
+
+/* TODO: reuse  form net.c */
+#ifndef SOL_NETLINK
+#define SOL_NETLINK 270
+#endif
+
+static int netlink_open(__u32 *nl_pid)
+{
+	struct sockaddr_nl sa;
+	socklen_t addrlen;
+	int one = 1, ret;
+	int sock;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.nl_family = AF_NETLINK;
+
+	sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
+	if (sock < 0)
+		return -errno;
+
+	if (setsockopt(sock, SOL_NETLINK, NETLINK_EXT_ACK,
+		       &one, sizeof(one)) < 0) {
+		p_err("Netlink error reporting not supported");
+	}
+
+	if (bind(sock, (struct sockaddr *)&sa, sizeof(sa)) < 0) {
+		ret = -errno;
+		goto cleanup;
+	}
+
+	addrlen = sizeof(sa);
+	if (getsockname(sock, (struct sockaddr *)&sa, &addrlen) < 0) {
+		ret = -errno;
+		goto cleanup;
+	}
+
+	if (addrlen != sizeof(sa)) {
+		ret = -LIBBPF_ERRNO__INTERNAL;
+		goto cleanup;
+	}
+
+	*nl_pid = sa.nl_pid;
+	return sock;
+
+cleanup:
+	close(sock);
+	return ret;
+}
+
+typedef int (*dump_nlmsg_t)(void *cookie, void *msg, struct nlattr **tb);
+
+typedef int (*__dump_nlmsg_t)(struct nlmsghdr *nlmsg, dump_nlmsg_t, void *cookie);
+
+static int netlink_recv(int sock, __u32 nl_pid, __u32 seq,
+			__dump_nlmsg_t _fn, dump_nlmsg_t fn,
+			void *cookie)
+{
+	bool multipart = true;
+	struct nlmsgerr *err;
+	struct nlmsghdr *nh;
+	char buf[4096];
+	int len, ret;
+
+	while (multipart) {
+		multipart = false;
+		len = recv(sock, buf, sizeof(buf), 0);
+		if (len < 0) {
+			ret = -errno;
+			goto done;
+		}
+
+		if (len == 0)
+			break;
+
+		for (nh = (struct nlmsghdr *)buf; NLMSG_OK(nh, len);
+		     nh = NLMSG_NEXT(nh, len)) {
+			if (nh->nlmsg_pid != nl_pid) {
+				ret = -LIBBPF_ERRNO__WRNGPID;
+				goto done;
+			}
+			if (nh->nlmsg_seq != seq) {
+				ret = -LIBBPF_ERRNO__INVSEQ;
+				goto done;
+			}
+			if (nh->nlmsg_flags & NLM_F_MULTI)
+				multipart = true;
+			switch (nh->nlmsg_type) {
+			case NLMSG_ERROR:
+				err = (struct nlmsgerr *)NLMSG_DATA(nh);
+				if (!err->error)
+					continue;
+				ret = err->error;
+				libbpf_nla_dump_errormsg(nh);
+				goto done;
+			case NLMSG_DONE:
+				return 0;
+			default:
+				break;
+			}
+			if (_fn) {
+				ret = _fn(nh, fn, cookie);
+				if (ret)
+					return ret;
+			}
+		}
+	}
+	ret = 0;
+done:
+	return ret;
+}
+
+
+static int __dump_link_nlmsg(struct nlmsghdr *nlh,
+			     dump_nlmsg_t dump_link_nlmsg, void *cookie)
+{
+	struct nlattr *tb[IFLA_MAX + 1], *attr;
+	struct ifinfomsg *ifi = NLMSG_DATA(nlh);
+	int len;
+
+	len = nlh->nlmsg_len - NLMSG_LENGTH(sizeof(*ifi));
+	attr = (struct nlattr *) ((void *) ifi + NLMSG_ALIGN(sizeof(*ifi)));
+	if (libbpf_nla_parse(tb, IFLA_MAX, attr, len, NULL) != 0)
+		return -LIBBPF_ERRNO__NLPARSE;
+
+	return dump_link_nlmsg(cookie, ifi, tb);
+}
+
+static int netlink_get_link(int sock, unsigned int nl_pid,
+			    dump_nlmsg_t dump_link_nlmsg, void *cookie)
+{
+	struct {
+		struct nlmsghdr nlh;
+		struct ifinfomsg ifm;
+	} req = {
+		.nlh.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg)),
+		.nlh.nlmsg_type = RTM_GETLINK,
+		.nlh.nlmsg_flags = NLM_F_DUMP | NLM_F_REQUEST,
+		.ifm.ifi_family = AF_PACKET,
+	};
+	int seq = time(NULL);
+
+	req.nlh.nlmsg_seq = seq;
+	if (send(sock, &req, req.nlh.nlmsg_len, 0) < 0)
+		return -errno;
+
+	return netlink_recv(sock, nl_pid, seq, __dump_link_nlmsg,
+			    dump_link_nlmsg, cookie);
+}
+
+struct ip_devname_ifindex {
+	char	devname[64];
+	int	ifindex;
+};
+
+struct bpf_netdev_t {
+	struct ip_devname_ifindex *devices;
+	int	used_len;
+	int	array_len;
+	int	filter_idx;
+};
+
+static int do_show(int argc, char **argv)
+{
+	int sock, ret, filter_idx = -1;
+	struct bpf_netdev_t dev_array;
+	unsigned int nl_pid = 0;
+	char err_buf[256];
+
+	if (argc == 2) {
+		if (strcmp(argv[0], "dev") != 0)
+			usage();
+		filter_idx = if_nametoindex(argv[1]);
+		if (filter_idx == 0) {
+			fprintf(stderr, "invalid dev name %s\n", argv[1]);
+			return -1;
+		}
+	} else if (argc != 0) {
+		usage();
+	}
+
+	sock = netlink_open(&nl_pid);
+	if (sock < 0) {
+		fprintf(stderr, "failed to open netlink sock\n");
+		return -1;
+	}
+
+	dev_array.devices = NULL;
+	dev_array.used_len = 0;
+	dev_array.array_len = 0;
+	dev_array.filter_idx = filter_idx;
+
+	if (json_output)
+		jsonw_start_array(json_wtr);
+	NET_START_OBJECT;
+	NET_START_ARRAY("xdp", "%s:\n");
+	ret = netlink_get_link(sock, nl_pid, xdp_dump_link_nlmsg, &dev_array);
+	NET_END_ARRAY("\n");
+
+	NET_END_OBJECT;
+	if (json_output)
+		jsonw_end_array(json_wtr);
+
+	if (ret) {
+		if (json_output)
+			jsonw_null(json_wtr);
+		libbpf_strerror(ret, err_buf, sizeof(err_buf));
+		fprintf(stderr, "Error: %s\n", err_buf);
+	}
+	free(dev_array.devices);
+	close(sock);
+	return ret;
+}
+
+static int set_usage(void)
+{
+	fprintf(stderr,
+		"Usage: %s net xdp set dev <devname> {md_btf {on|off}}\n"
+		"       %s net xdp set help\n"
+		"       md_btf {on|off}: enable/disable meta data btf\n",
+		bin_name, bin_name);
+
+	return -1;
+}
+
+static int xdp_set_md_btf(int ifindex, char *arg)
+{
+	__u8 enable = (strcmp(arg, "on") == 0) ? 1 : 0;
+	int ret;
+
+	ret = bpf_set_link_xdp_md_btf(ifindex, enable);
+	if (ret)
+		fprintf(stderr, "Failed to setup xdp md, err=%d\n", ret);
+
+	return -ret;
+}
+
+static int do_set(int argc, char **argv)
+{
+	char *set_cmd, *set_arg;
+	int dev_idx = -1;
+
+	if (argc < 4)
+		return set_usage();
+
+	if (strcmp(argv[0], "dev") != 0)
+		return set_usage();
+
+	dev_idx = if_nametoindex(argv[1]);
+	if (dev_idx == 0) {
+		fprintf(stderr, "invalid dev name %s\n", argv[1]);
+		return -1;
+	}
+
+	set_cmd = argv[2];
+	set_arg = argv[3];
+
+	if (strcmp(set_cmd, "md_btf") != 0)
+		return set_usage();
+
+	if (strcmp(set_arg, "on") != 0 && strcmp(set_arg, "off") != 0)
+		return set_usage();
+
+	return xdp_set_md_btf(dev_idx, set_arg);
+}
+
+static int do_help(int argc, char **argv)
+{
+	if (json_output) {
+		jsonw_null(json_wtr);
+		return 0;
+	}
+
+	fprintf(stderr,
+		"Usage: %s %s xdp { show | list | set } [dev <devname>]\n"
+		"       %s %s help\n",
+		bin_name, argv[-2], bin_name, argv[-2]);
+
+	return 0;
+}
+
+static const struct cmd cmds[] = {
+	{ "show",        do_show },
+	{ "list",        do_show },
+	{ "set",         do_set  },
+	{ "help",        do_help },
+	{ 0 }
+};
+
+int do_xdp(int argc, char **argv)
+{
+	return cmd_select(cmds, argc, argv, do_help);
+}
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 6e61342ba56c..5075cf9fd509 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -520,6 +520,7 @@ LIBBPF_API int bpf_set_link_xdp_fd(int ifindex, int fd, __u32 flags);
 LIBBPF_API int bpf_set_link_xdp_fd_opts(int ifindex, int fd, __u32 flags,
 					const struct bpf_xdp_set_link_opts *opts);
 LIBBPF_API int bpf_get_link_xdp_id(int ifindex, __u32 *prog_id, __u32 flags);
+
 LIBBPF_API int bpf_get_link_xdp_info(int ifindex, struct xdp_link_info *info,
 				     size_t info_size, __u32 flags);
 
@@ -607,6 +608,7 @@ struct perf_buffer_opts {
 LIBBPF_API struct perf_buffer *
 perf_buffer__new(int map_fd, size_t page_cnt,
 		 const struct perf_buffer_opts *opts);
+LIBBPF_API int bpf_set_link_xdp_md_btf(int ifindex, __u8 enable);
 
 enum bpf_perf_event_ret {
 	LIBBPF_PERF_EVENT_DONE	= 0,
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 944c99d1ded3..492db50a4cd7 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -135,6 +135,7 @@ LIBBPF_0.0.2 {
 		bpf_object__btf;
 		bpf_object__find_map_fd_by_name;
 		bpf_get_link_xdp_id;
+		bpf_set_link_xdp_md_btf;
 		btf__dedup;
 		btf__get_map_kv_tids;
 		btf__get_nr_types;
diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
index 39f25e09b51e..4f79972943e4 100644
--- a/tools/lib/bpf/netlink.c
+++ b/tools/lib/bpf/netlink.c
@@ -242,6 +242,55 @@ int bpf_set_link_xdp_fd(int ifindex, int fd, __u32 flags)
 	return libbpf_err(ret);
 }
 
+int bpf_set_link_xdp_md_btf(int ifindex, __u8  enable)
+{
+	struct nlattr *nla, *nla_xdp;
+	int sock, seq = 0, ret;
+	__u32 nl_pid;
+	struct {
+		struct nlmsghdr  nh;
+		struct ifinfomsg ifinfo;
+		char             attrbuf[64];
+	} req;
+
+	sock = libbpf_netlink_open(&nl_pid);
+	if (sock < 0)
+		return sock;
+
+	memset(&req, 0, sizeof(req));
+	req.nh.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg));
+	req.nh.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
+	req.nh.nlmsg_type = RTM_SETLINK;
+	req.nh.nlmsg_pid = 0;
+	req.nh.nlmsg_seq = ++seq;
+	req.ifinfo.ifi_family = AF_UNSPEC;
+	req.ifinfo.ifi_index = ifindex;
+
+	/* started nested attribute for XDP */
+	nla = (struct nlattr *)(((char *)&req)
+				+ NLMSG_ALIGN(req.nh.nlmsg_len));
+	nla->nla_type = NLA_F_NESTED | IFLA_XDP;
+	nla->nla_len = NLA_HDRLEN;
+	/* add XDP MD setup */
+	nla_xdp = (struct nlattr *)((char *)nla + nla->nla_len);
+	nla_xdp->nla_type = IFLA_XDP_MD_BTF_STATE;
+	nla_xdp->nla_len = NLA_HDRLEN + sizeof(__u8);
+	memcpy((char *)nla_xdp + NLA_HDRLEN, &enable, sizeof(__u8));
+	nla->nla_len += nla_xdp->nla_len;
+
+	req.nh.nlmsg_len += NLA_ALIGN(nla->nla_len);
+
+	if (send(sock, &req, req.nh.nlmsg_len, 0) < 0) {
+		ret = -errno;
+		goto cleanup;
+	}
+	ret = libbpf_netlink_recv(sock, nl_pid, seq, NULL, NULL, NULL);
+
+cleanup:
+	close(sock);
+	return ret;
+}
+
 static int __dump_link_nlmsg(struct nlmsghdr *nlh,
 			     libbpf_dump_nlmsg_t dump_link_nlmsg, void *cookie)
 {
-- 
2.32.0

