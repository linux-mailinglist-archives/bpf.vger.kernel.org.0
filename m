Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0014395B09
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2019 11:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbfHTJcQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Aug 2019 05:32:16 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50975 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729478AbfHTJcQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Aug 2019 05:32:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id v15so2002811wml.0
        for <bpf@vger.kernel.org>; Tue, 20 Aug 2019 02:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bYGXjdza9ebodrpHdoF7VcqI7w8cXeOlplyuQUJGn1o=;
        b=X0jgbo0llbcvuzMDamWeNyesm+VHuk53yOku+NI+JQOMPatAWl8On4heUm9WLcss4m
         8GhWlBadt4ftL6ZV4vaH1NKJyaCm9WULFLsAhj6y85yjI2IbbJg3T3UiJ183XqYWUlAG
         rIjLDxb7xBwRWRE1PuJ1WCWM470HOQ3R+thxx8+FTup5D679OJ6ObSu3w7lqrU7OeMFl
         68ObKBXrJdPdoZN4m1HYlQwr7J+j6Xv1D8fY8gqnqKOjwZVvuOMAPetKcJwt+xjmOVJ7
         j+JRvZodyaZyyflh5NticqJL+gGXNmzeEy10o1WUc/Bez3lyoU1GjeUyIOinmEs28gDv
         fxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bYGXjdza9ebodrpHdoF7VcqI7w8cXeOlplyuQUJGn1o=;
        b=NVGnNNVMCf71FHIuWIuaQQXg89WuxzhtLh17T+Qbp5vYFoCcIko+if2Bsnz5tiJ5rl
         Uq7TzePXGziovPHEMfVdc4KvK53pZo5eGH/ZO3uyUv+VnOgf1ZRg8xwz9cv2kNP7UKSX
         jefWo3xPe4FVwWBp6wv9OeFSF+b3oFNrbwxdeTvx9c9dK5vvC0q30S2ORbSBgyacAylg
         UMc3rZs4Y3aq25n85Zzp69K8LrIDdR4FvY2XhnAJ5/o5nYtY42F96K/B6/Y2i6209iV/
         nIgSJSBoz894empzQ9PVrm4rrm6nZEfhPKcCUg+k+5fS2EcQsAtQLYIB9xHsxnq/vHis
         acZg==
X-Gm-Message-State: APjAAAWjMr1VV8YWfE8tuSVM+80Z1lfJsnqBsyuppGJGTk68/RuceI5r
        DGR/Iho9h9W6iQicw5yUMKZMfA==
X-Google-Smtp-Source: APXvYqykQ9ZNLdy+J0DbI2lFa6OaQ6B0/FZt9PSlkXQPCXrarup+zEY0xoILRa2Aub1ikPKIulmRqg==
X-Received: by 2002:a1c:6145:: with SMTP id v66mr26150947wmb.42.1566293532128;
        Tue, 20 Aug 2019 02:32:12 -0700 (PDT)
Received: from cbtest32.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id p9sm16128190wru.61.2019.08.20.02.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 02:32:11 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH bpf-next v2 5/5] tools: bpftool: implement "bpftool btf show|list"
Date:   Tue, 20 Aug 2019 10:31:54 +0100
Message-Id: <20190820093154.14042-6-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190820093154.14042-1-quentin.monnet@netronome.com>
References: <20190820093154.14042-1-quentin.monnet@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a "btf list" (alias: "btf show") subcommand to bpftool in order to
dump all BTF objects loaded on a system.

When running the command, hash tables are built in bpftool to retrieve
all the associations between BTF objects and BPF maps and programs. This
allows for printing all such associations when listing the BTF objects.

The command is added at the top of the subcommands for "bpftool btf", so
that typing only "bpftool btf" also comes down to listing the programs.
We could not have this with the previous command ("dump"), which
required a BTF object id, so it should not break any previous behaviour.
This also makes the "btf" command behaviour consistent with "prog" or
"map".

Bash completion is updated to use "bpftool btf" instead of "bpftool
prog" to list the BTF ids, as it looks more consistent.

Example output (plain):

    # bpftool btf show
    9: size 2989B  prog_ids 21  map_ids 15
    17: size 2847B  prog_ids 36  map_ids 30,29,28
    26: size 2847B

Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 .../bpf/bpftool/Documentation/bpftool-btf.rst |   7 +
 tools/bpf/bpftool/bash-completion/bpftool     |  20 +-
 tools/bpf/bpftool/btf.c                       | 342 +++++++++++++++++-
 3 files changed, 363 insertions(+), 6 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
index 6694a0fc8f99..39615f8e145b 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
@@ -19,6 +19,7 @@ SYNOPSIS
 BTF COMMANDS
 =============
 
+|	**bpftool** **btf** { **show** | **list** } [**id** *BTF_ID*]
 |	**bpftool** **btf dump** *BTF_SRC* [**format** *FORMAT*]
 |	**bpftool** **btf help**
 |
@@ -29,6 +30,12 @@ BTF COMMANDS
 
 DESCRIPTION
 ===========
+	**bpftool btf { show | list }** [**id** *BTF_ID*]
+		  Show information about loaded BTF objects. If a BTF ID is
+		  specified, show information only about given BTF object,
+		  otherwise list all BTF objects currently loaded on the
+		  system.
+
 	**bpftool btf dump** *BTF_SRC*
 		  Dump BTF entries from a given *BTF_SRC*.
 
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 4549fd424069..2ffd351f9dbf 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -73,8 +73,8 @@ _bpftool_get_prog_tags()
 
 _bpftool_get_btf_ids()
 {
-    COMPREPLY+=( $( compgen -W "$( bpftool -jp prog 2>&1 | \
-        command sed -n 's/.*"btf_id": \(.*\),\?$/\1/p' )" -- "$cur" ) )
+    COMPREPLY+=( $( compgen -W "$( bpftool -jp btf 2>&1 | \
+        command sed -n 's/.*"id": \(.*\),$/\1/p' )" -- "$cur" ) )
 }
 
 _bpftool_get_obj_map_names()
@@ -670,7 +670,7 @@ _bpftool()
                                 map)
                                     _bpftool_get_map_ids
                                     ;;
-                                dump)
+                                $command)
                                     _bpftool_get_btf_ids
                                     ;;
                             esac
@@ -698,9 +698,21 @@ _bpftool()
                             ;;
                     esac
                     ;;
+                show|list)
+                    case $prev in
+                        $command)
+                            COMPREPLY+=( $( compgen -W "id" -- "$cur" ) )
+                            ;;
+                        id)
+                            _bpftool_get_btf_ids
+                            ;;
+                    esac
+                    return 0
+                    ;;
                 *)
                     [[ $prev == $object ]] && \
-                        COMPREPLY=( $( compgen -W 'dump help' -- "$cur" ) )
+                        COMPREPLY=( $( compgen -W 'dump help show list' \
+                            -- "$cur" ) )
                     ;;
             esac
             ;;
diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 8805637f1a7e..9a9376d1d3df 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -11,6 +11,7 @@
 #include <bpf.h>
 #include <libbpf.h>
 #include <linux/btf.h>
+#include <linux/hashtable.h>
 
 #include "btf.h"
 #include "json_writer.h"
@@ -35,6 +36,16 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
 	[BTF_KIND_DATASEC]	= "DATASEC",
 };
 
+struct btf_attach_table {
+	DECLARE_HASHTABLE(table, 16);
+};
+
+struct btf_attach_point {
+	__u32 obj_id;
+	__u32 btf_id;
+	struct hlist_node hash;
+};
+
 static const char *btf_int_enc_str(__u8 encoding)
 {
 	switch (encoding) {
@@ -522,6 +533,330 @@ static int do_dump(int argc, char **argv)
 	return err;
 }
 
+static int btf_parse_fd(int *argc, char ***argv)
+{
+	unsigned int id;
+	char *endptr;
+	int fd;
+
+	if (!is_prefix(*argv[0], "id")) {
+		p_err("expected 'id', got: '%s'?", **argv);
+		return -1;
+	}
+	NEXT_ARGP();
+
+	id = strtoul(**argv, &endptr, 0);
+	if (*endptr) {
+		p_err("can't parse %s as ID", **argv);
+		return -1;
+	}
+	NEXT_ARGP();
+
+	fd = bpf_btf_get_fd_by_id(id);
+	if (fd < 0)
+		p_err("can't get BTF object by id (%u): %s",
+		      id, strerror(errno));
+
+	return fd;
+}
+
+static void delete_btf_table(struct btf_attach_table *tab)
+{
+	struct btf_attach_point *obj;
+	struct hlist_node *tmp;
+
+	unsigned int bkt;
+
+	hash_for_each_safe(tab->table, bkt, tmp, obj, hash) {
+		hash_del(&obj->hash);
+		free(obj);
+	}
+}
+
+static int
+build_btf_type_table(struct btf_attach_table *tab, enum bpf_obj_type type,
+		     void *info, __u32 *len)
+{
+	static const char * const names[] = {
+		[BPF_OBJ_UNKNOWN]	= "unknown",
+		[BPF_OBJ_PROG]		= "prog",
+		[BPF_OBJ_MAP]		= "map",
+	};
+	struct btf_attach_point *obj_node;
+	__u32 btf_id, id = 0;
+	int err;
+	int fd;
+
+	while (true) {
+		switch (type) {
+		case BPF_OBJ_PROG:
+			err = bpf_prog_get_next_id(id, &id);
+			break;
+		case BPF_OBJ_MAP:
+			err = bpf_map_get_next_id(id, &id);
+			break;
+		default:
+			err = -1;
+			p_err("unexpected object type: %d", type);
+			goto err_free;
+		}
+		if (err) {
+			if (errno == ENOENT) {
+				err = 0;
+				break;
+			}
+			p_err("can't get next %s: %s%s", names[type],
+			      strerror(errno),
+			      errno == EINVAL ? " -- kernel too old?" : "");
+			goto err_free;
+		}
+
+		switch (type) {
+		case BPF_OBJ_PROG:
+			fd = bpf_prog_get_fd_by_id(id);
+			break;
+		case BPF_OBJ_MAP:
+			fd = bpf_map_get_fd_by_id(id);
+			break;
+		default:
+			err = -1;
+			p_err("unexpected object type: %d", type);
+			goto err_free;
+		}
+		if (fd < 0) {
+			if (errno == ENOENT)
+				continue;
+			p_err("can't get %s by id (%u): %s", names[type], id,
+			      strerror(errno));
+			err = -1;
+			goto err_free;
+		}
+
+		memset(info, 0, *len);
+		err = bpf_obj_get_info_by_fd(fd, info, len);
+		close(fd);
+		if (err) {
+			p_err("can't get %s info: %s", names[type],
+			      strerror(errno));
+			goto err_free;
+		}
+
+		switch (type) {
+		case BPF_OBJ_PROG:
+			btf_id = ((struct bpf_prog_info *)info)->btf_id;
+			break;
+		case BPF_OBJ_MAP:
+			btf_id = ((struct bpf_map_info *)info)->btf_id;
+			break;
+		default:
+			err = -1;
+			p_err("unexpected object type: %d", type);
+			goto err_free;
+		}
+		if (!btf_id)
+			continue;
+
+		obj_node = calloc(1, sizeof(*obj_node));
+		if (!obj_node) {
+			p_err("failed to allocate memory: %s", strerror(errno));
+			goto err_free;
+		}
+
+		obj_node->obj_id = id;
+		obj_node->btf_id = btf_id;
+		hash_add(tab->table, &obj_node->hash, obj_node->btf_id);
+	}
+
+	return 0;
+
+err_free:
+	delete_btf_table(tab);
+	return err;
+}
+
+static int
+build_btf_tables(struct btf_attach_table *btf_prog_table,
+		 struct btf_attach_table *btf_map_table)
+{
+	struct bpf_prog_info prog_info;
+	__u32 prog_len = sizeof(prog_info);
+	struct bpf_map_info map_info;
+	__u32 map_len = sizeof(map_info);
+	int err = 0;
+
+	err = build_btf_type_table(btf_prog_table, BPF_OBJ_PROG, &prog_info,
+				   &prog_len);
+	if (err)
+		return err;
+
+	err = build_btf_type_table(btf_map_table, BPF_OBJ_MAP, &map_info,
+				   &map_len);
+	if (err) {
+		delete_btf_table(btf_prog_table);
+		return err;
+	}
+
+	return 0;
+}
+
+static void
+show_btf_plain(struct bpf_btf_info *info, int fd,
+	       struct btf_attach_table *btf_prog_table,
+	       struct btf_attach_table *btf_map_table)
+{
+	struct btf_attach_point *obj;
+	int n;
+
+	printf("%u: ", info->id);
+	printf("size %uB", info->btf_size);
+
+	n = 0;
+	hash_for_each_possible(btf_prog_table->table, obj, hash, info->id) {
+		if (obj->btf_id == info->id)
+			printf("%s%u", n++ == 0 ? "  prog_ids " : ",",
+			       obj->obj_id);
+	}
+
+	n = 0;
+	hash_for_each_possible(btf_map_table->table, obj, hash, info->id) {
+		if (obj->btf_id == info->id)
+			printf("%s%u", n++ == 0 ? "  map_ids " : ",",
+			       obj->obj_id);
+	}
+
+	printf("\n");
+}
+
+static void
+show_btf_json(struct bpf_btf_info *info, int fd,
+	      struct btf_attach_table *btf_prog_table,
+	      struct btf_attach_table *btf_map_table)
+{
+	struct btf_attach_point *obj;
+
+	jsonw_start_object(json_wtr);	/* btf object */
+	jsonw_uint_field(json_wtr, "id", info->id);
+	jsonw_uint_field(json_wtr, "size", info->btf_size);
+
+	jsonw_name(json_wtr, "prog_ids");
+	jsonw_start_array(json_wtr);	/* prog_ids */
+	hash_for_each_possible(btf_prog_table->table, obj, hash,
+			       info->id) {
+		if (obj->btf_id == info->id)
+			jsonw_uint(json_wtr, obj->obj_id);
+	}
+	jsonw_end_array(json_wtr);	/* prog_ids */
+
+	jsonw_name(json_wtr, "map_ids");
+	jsonw_start_array(json_wtr);	/* map_ids */
+	hash_for_each_possible(btf_map_table->table, obj, hash,
+			       info->id) {
+		if (obj->btf_id == info->id)
+			jsonw_uint(json_wtr, obj->obj_id);
+	}
+	jsonw_end_array(json_wtr);	/* map_ids */
+	jsonw_end_object(json_wtr);	/* btf object */
+}
+
+static int
+show_btf(int fd, struct btf_attach_table *btf_prog_table,
+	 struct btf_attach_table *btf_map_table)
+{
+	struct bpf_btf_info info = {};
+	__u32 len = sizeof(info);
+	int err;
+
+	err = bpf_obj_get_info_by_fd(fd, &info, &len);
+	if (err) {
+		p_err("can't get BTF object info: %s", strerror(errno));
+		return -1;
+	}
+
+	if (json_output)
+		show_btf_json(&info, fd, btf_prog_table, btf_map_table);
+	else
+		show_btf_plain(&info, fd, btf_prog_table, btf_map_table);
+
+	return 0;
+}
+
+static int do_show(int argc, char **argv)
+{
+	struct btf_attach_table btf_prog_table;
+	struct btf_attach_table btf_map_table;
+	int err, fd = -1;
+	__u32 id = 0;
+
+	if (argc == 2) {
+		fd = btf_parse_fd(&argc, &argv);
+		if (fd < 0)
+			return -1;
+	}
+
+	if (argc) {
+		if (fd >= 0)
+			close(fd);
+		return BAD_ARG();
+	}
+
+	hash_init(btf_prog_table.table);
+	hash_init(btf_map_table.table);
+	err = build_btf_tables(&btf_prog_table, &btf_map_table);
+	if (err) {
+		if (fd >= 0)
+			close(fd);
+		return err;
+	}
+
+	if (fd >= 0) {
+		err = show_btf(fd, &btf_prog_table, &btf_map_table);
+		close(fd);
+		goto exit_free;
+	}
+
+	if (json_output)
+		jsonw_start_array(json_wtr);	/* root array */
+
+	while (true) {
+		err = bpf_btf_get_next_id(id, &id);
+		if (err) {
+			if (errno == ENOENT) {
+				err = 0;
+				break;
+			}
+			p_err("can't get next BTF object: %s%s",
+			      strerror(errno),
+			      errno == EINVAL ? " -- kernel too old?" : "");
+			err = -1;
+			break;
+		}
+
+		fd = bpf_btf_get_fd_by_id(id);
+		if (fd < 0) {
+			if (errno == ENOENT)
+				continue;
+			p_err("can't get BTF object by id (%u): %s",
+			      id, strerror(errno));
+			err = -1;
+			break;
+		}
+
+		err = show_btf(fd, &btf_prog_table, &btf_map_table);
+		close(fd);
+		if (err)
+			break;
+	}
+
+	if (json_output)
+		jsonw_end_array(json_wtr);	/* root array */
+
+exit_free:
+	delete_btf_table(&btf_prog_table);
+	delete_btf_table(&btf_map_table);
+
+	return err;
+}
+
 static int do_help(int argc, char **argv)
 {
 	if (json_output) {
@@ -530,7 +865,8 @@ static int do_help(int argc, char **argv)
 	}
 
 	fprintf(stderr,
-		"Usage: %s btf dump BTF_SRC [format FORMAT]\n"
+		"Usage: %s btf { show | list } [id BTF_ID]\n"
+		"       %s btf dump BTF_SRC [format FORMAT]\n"
 		"       %s btf help\n"
 		"\n"
 		"       BTF_SRC := { id BTF_ID | prog PROG | map MAP [{key | value | kv | all}] | file FILE }\n"
@@ -539,12 +875,14 @@ static int do_help(int argc, char **argv)
 		"       " HELP_SPEC_PROGRAM "\n"
 		"       " HELP_SPEC_OPTIONS "\n"
 		"",
-		bin_name, bin_name);
+		bin_name, bin_name, bin_name);
 
 	return 0;
 }
 
 static const struct cmd cmds[] = {
+	{ "show",	do_show },
+	{ "list",	do_show },
 	{ "help",	do_help },
 	{ "dump",	do_dump },
 	{ 0 }
-- 
2.17.1

