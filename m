Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92AB724B33E
	for <lists+bpf@lfdr.de>; Thu, 20 Aug 2020 11:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbgHTJnf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Aug 2020 05:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729018AbgHTJmZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Aug 2020 05:42:25 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1ACDC061342
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2020 02:42:21 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id k4so1060676ilr.12
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2020 02:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Lj8AC0dSY26aIIm+lvhaB/Q7CIHxsMDnqhwGfm7MEo=;
        b=iDX77MiMQE6ho6myLRNZIrsLr5r7t/esa3pFgodG76uuGGpSYRCK85Aaea+9OPgwck
         BTLrld7ofq6OynQbGvPsMsWmfzkF1G9IqLz/pghOebFndsmlNADO9rzzMFa5/YdXlCzV
         iO/9K4fV3gEFoqptKASz+d4B4NQD7GXW72O+iHNJ3Smsxkys0RcElYwmF2PmNnqLQwll
         6aWy3cYhM9jUyivRcQWmzdM+AB6iCabxN3ErzdAGxBvBbjsqwpWsxtYpusGKp3rWygbc
         obRcG9j3nHWcozgeAvZF3j9mT0F1HM1dKGUpgsKZgMeyQFJVFMU9VDeTlAUsVXBqKY8N
         1jww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Lj8AC0dSY26aIIm+lvhaB/Q7CIHxsMDnqhwGfm7MEo=;
        b=RLvcBDo8+f1aTMjXA+DXyOCHDUzTl4evuN2pe/Z2rRaPP/q9CzordMLrwXfLk4HJWd
         9aPewC0LuZxIwgL0mgjzIEHOI5Jr9BOpABOyivhAt/7q5AKSwuBJgYkw5yEIH6UPiiZP
         WQVLF+tf1hE59f0WVx23uzEQv6VW4G58YY+ElW5MBfX1OhEyvf+ID8/zv8JW7efUwoyO
         lXG9E3rLpcdd48hngsCrVjNURbdL49rQTv8/dhiU7OFnjywcJ30tK4/NWtkJ86muV80Q
         ABgkBQWI/J5WK3SupzHXE5JL33CNx/0P152+mllargzg0P5ocYkscbQztNy2tzsjuqx/
         AHPQ==
X-Gm-Message-State: AOAM531qAj2FI1Oydy/2Ob6w+nay3jXSLN59PFVTl1gvkdL0dXzC1OuH
        RlprBHys/70nE1QijGd0NnnPVVPAxjHrwMsH
X-Google-Smtp-Source: ABdhPJwdsh75RRq6v47niVVMcp+iWvlhrnyjLstKTO5j1dUQN7ESJ7y73wj0S2bELS/rrjkpMLhC6w==
X-Received: by 2002:a92:d342:: with SMTP id a2mr2025074ilh.16.1597916538196;
        Thu, 20 Aug 2020 02:42:18 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-219.tnkngak.clients.pavlovmedia.com. [173.230.99.219])
        by smtp.gmail.com with ESMTPSA id r3sm1145597iov.22.2020.08.20.02.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 02:42:17 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH bpf-next 4/5] bpftool: support dumping metadata
Date:   Thu, 20 Aug 2020 04:42:10 -0500
Message-Id: <9138c60f036c68f02c41dae0605ef587a8347f4c.1597915265.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597915265.git.zhuyifei@google.com>
References: <cover.1597915265.git.zhuyifei@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: YiFei Zhu <zhuyifei@google.com>

Added a flag "--metadata" to `bpftool prog list` to dump the metadata
contents. For some formatting some BTF code is put directly in the
metadata dumping. Sanity checks on the map and the kind of the btf_type
to make sure we are actually dumping what we are expecting.

A helper jsonw_reset is added to json writer so we can reuse the same
json writer without having extraneous commas.

Sample output:

  $ bpftool prog --metadata
  6: cgroup_skb  name prog  tag bcf7977d3b93787c  gpl
  [...]
  	btf_id 4
  	metadata:
  		metadata_a = "foo"
  		metadata_b = 1

  $ bpftool prog --metadata --json --pretty
  [{
          "id": 6,
  [...]
          "btf_id": 4,
          "metadata": {
              "metadata_a": "foo",
              "metadata_b": 1
          }
      }
  ]

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 tools/bpf/bpftool/json_writer.c |   6 ++
 tools/bpf/bpftool/json_writer.h |   3 +
 tools/bpf/bpftool/main.c        |  10 +++
 tools/bpf/bpftool/main.h        |   1 +
 tools/bpf/bpftool/prog.c        | 135 ++++++++++++++++++++++++++++++++
 5 files changed, 155 insertions(+)

diff --git a/tools/bpf/bpftool/json_writer.c b/tools/bpf/bpftool/json_writer.c
index 86501cd3c763..7fea83bedf48 100644
--- a/tools/bpf/bpftool/json_writer.c
+++ b/tools/bpf/bpftool/json_writer.c
@@ -119,6 +119,12 @@ void jsonw_pretty(json_writer_t *self, bool on)
 	self->pretty = on;
 }
 
+void jsonw_reset(json_writer_t *self)
+{
+	assert(self->depth == 0);
+	self->sep = '\0';
+}
+
 /* Basic blocks */
 static void jsonw_begin(json_writer_t *self, int c)
 {
diff --git a/tools/bpf/bpftool/json_writer.h b/tools/bpf/bpftool/json_writer.h
index 35cf1f00f96c..8ace65cdb92f 100644
--- a/tools/bpf/bpftool/json_writer.h
+++ b/tools/bpf/bpftool/json_writer.h
@@ -27,6 +27,9 @@ void jsonw_destroy(json_writer_t **self_p);
 /* Cause output to have pretty whitespace */
 void jsonw_pretty(json_writer_t *self, bool on);
 
+/* Reset separator to create new JSON */
+void jsonw_reset(json_writer_t *self);
+
 /* Add property name */
 void jsonw_name(json_writer_t *self, const char *name);
 
diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 4a191fcbeb82..a681d568cfa7 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -28,6 +28,7 @@ bool show_pinned;
 bool block_mount;
 bool verifier_logs;
 bool relaxed_maps;
+bool dump_metadata;
 struct pinned_obj_table prog_table;
 struct pinned_obj_table map_table;
 struct pinned_obj_table link_table;
@@ -351,6 +352,10 @@ static int do_batch(int argc, char **argv)
 	return err;
 }
 
+enum bpftool_longonly_opts {
+	OPT_METADATA = 256,
+};
+
 int main(int argc, char **argv)
 {
 	static const struct option options[] = {
@@ -362,6 +367,7 @@ int main(int argc, char **argv)
 		{ "mapcompat",	no_argument,	NULL,	'm' },
 		{ "nomount",	no_argument,	NULL,	'n' },
 		{ "debug",	no_argument,	NULL,	'd' },
+		{ "metadata",	no_argument,	NULL,	OPT_METADATA },
 		{ 0 }
 	};
 	int opt, ret;
@@ -371,6 +377,7 @@ int main(int argc, char **argv)
 	json_output = false;
 	show_pinned = false;
 	block_mount = false;
+	dump_metadata = false;
 	bin_name = argv[0];
 
 	hash_init(prog_table.table);
@@ -412,6 +419,9 @@ int main(int argc, char **argv)
 			libbpf_set_print(print_all_levels);
 			verifier_logs = true;
 			break;
+		case OPT_METADATA:
+			dump_metadata = true;
+			break;
 		default:
 			p_err("unrecognized option '%s'", argv[optind - 1]);
 			if (json_output)
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index c46e52137b87..8750758e9150 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -90,6 +90,7 @@ extern bool show_pids;
 extern bool block_mount;
 extern bool verifier_logs;
 extern bool relaxed_maps;
+extern bool dump_metadata;
 extern struct pinned_obj_table prog_table;
 extern struct pinned_obj_table map_table;
 extern struct pinned_obj_table link_table;
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index d393eb8263a6..ee767b8d90fb 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -151,6 +151,135 @@ static void show_prog_maps(int fd, __u32 num_maps)
 	}
 }
 
+static void show_prog_metadata(int fd, __u32 num_maps)
+{
+	struct bpf_prog_info prog_info = {};
+	struct bpf_map_info map_info = {};
+	__u32 prog_info_len = sizeof(prog_info);
+	__u32 map_info_len = sizeof(map_info);
+	__u32 map_ids[num_maps];
+	void *value = NULL;
+	struct btf *btf = NULL;
+	const struct btf_type *t_datasec, *t_var;
+	struct btf_var_secinfo *vsi;
+	int key = 0;
+	unsigned int i, vlen;
+	int map_fd;
+	int err;
+
+	prog_info.nr_map_ids = num_maps;
+	prog_info.map_ids = ptr_to_u64(map_ids);
+
+	err = bpf_obj_get_info_by_fd(fd, &prog_info, &prog_info_len);
+	if (err || !prog_info.nr_map_ids)
+		return;
+
+	for (i = 0; i < prog_info.nr_map_ids; i++) {
+		map_fd = bpf_map_get_fd_by_id(map_ids[i]);
+		if (map_fd < 0)
+			return;
+
+		err = bpf_obj_get_info_by_fd(map_fd, &map_info, &map_info_len);
+		if (err)
+			goto out_close;
+
+		if (map_info.type != BPF_MAP_TYPE_ARRAY)
+			goto next_map;
+		if (map_info.key_size != sizeof(int))
+			goto next_map;
+		if (map_info.max_entries != 1)
+			goto next_map;
+		if (!map_info.btf_value_type_id)
+			goto next_map;
+		if (!strstr(map_info.name, ".metadata"))
+			goto next_map;
+
+		goto found;
+
+next_map:
+		close(map_fd);
+	}
+
+	return;
+
+found:
+	value = malloc(map_info.value_size);
+	if (!value)
+		goto out_close;
+
+	if (bpf_map_lookup_elem(map_fd, &key, value))
+		goto out_free;
+
+	err = btf__get_from_id(map_info.btf_id, &btf);
+	if (err || !btf)
+		goto out_free;
+
+	t_datasec = btf__type_by_id(btf, map_info.btf_value_type_id);
+	if (BTF_INFO_KIND(t_datasec->info) != BTF_KIND_DATASEC)
+		goto out_free;
+
+	vlen = BTF_INFO_VLEN(t_datasec->info);
+	vsi = (struct btf_var_secinfo *)(t_datasec + 1);
+
+	if (json_output) {
+		struct btf_dumper d = {
+			.btf = btf,
+			.jw = json_wtr,
+			.is_plain_text = false,
+		};
+
+		jsonw_name(json_wtr, "metadata");
+
+		jsonw_start_object(json_wtr);
+		for (i = 0; i < vlen; i++) {
+			t_var = btf__type_by_id(btf, vsi[i].type);
+
+			if (BTF_INFO_KIND(t_var->info) != BTF_KIND_VAR)
+				continue;
+
+			jsonw_name(json_wtr, btf__name_by_offset(btf, t_var->name_off));
+			err = btf_dumper_type(&d, t_var->type, value + vsi[i].offset);
+			if (err)
+				break;
+		}
+		jsonw_end_object(json_wtr);
+	} else {
+		json_writer_t *btf_wtr = jsonw_new(stdout);
+		struct btf_dumper d = {
+			.btf = btf,
+			.jw = btf_wtr,
+			.is_plain_text = true,
+		};
+		if (!btf_wtr)
+			goto out_free;
+
+		printf("\tmetadata:");
+
+		for (i = 0; i < vlen; i++) {
+			t_var = btf__type_by_id(btf, vsi[i].type);
+
+			if (BTF_INFO_KIND(t_var->info) != BTF_KIND_VAR)
+				continue;
+
+			printf("\n\t\t%s = ", btf__name_by_offset(btf, t_var->name_off));
+
+			jsonw_reset(btf_wtr);
+			err = btf_dumper_type(&d, t_var->type, value + vsi[i].offset);
+			if (err)
+				break;
+		}
+
+		jsonw_destroy(&btf_wtr);
+	}
+
+out_free:
+	btf__free(btf);
+	free(value);
+
+out_close:
+	close(map_fd);
+}
+
 static void print_prog_header_json(struct bpf_prog_info *info)
 {
 	jsonw_uint_field(json_wtr, "id", info->id);
@@ -228,6 +357,9 @@ static void print_prog_json(struct bpf_prog_info *info, int fd)
 
 	emit_obj_refs_json(&refs_table, info->id, json_wtr);
 
+	if (dump_metadata)
+		show_prog_metadata(fd, info->nr_map_ids);
+
 	jsonw_end_object(json_wtr);
 }
 
@@ -297,6 +429,9 @@ static void print_prog_plain(struct bpf_prog_info *info, int fd)
 	emit_obj_refs_plain(&refs_table, info->id, "\n\tpids ");
 
 	printf("\n");
+
+	if (dump_metadata)
+		show_prog_metadata(fd, info->nr_map_ids);
 }
 
 static int show_prog(int fd)
-- 
2.28.0

