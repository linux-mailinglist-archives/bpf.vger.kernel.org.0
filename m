Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 489A0201E8B
	for <lists+bpf@lfdr.de>; Sat, 20 Jun 2020 01:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbgFSXTg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Jun 2020 19:19:36 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47842 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730379AbgFSXTf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Jun 2020 19:19:35 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 05JNF0Ml003026
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2020 16:19:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=PEOsKzlc21oVFnqVz+ZIM8/OMmzZ7OmqH3v4qLerN3k=;
 b=TnZZVCdTW04TXLhIw1IzUoTc8ZfKhUSU58S08Q1eEpE4XpvqTrAOF7vLqR8RIk+PFGO5
 hOX3J7gzuvIprQmE3j1uINhxsVi/ZyI2NmhRg1FI3Ki4Qg8TresqwErv1JGnW1aOc4Vg
 NRh4bOBoJ+csu31WpjoH6PXzAtqLjAZZRxk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 31rcbea7se-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2020 16:19:33 -0700
Received: from intmgw004.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 19 Jun 2020 16:19:31 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id A39302EC3763; Fri, 19 Jun 2020 16:17:15 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Quentin Monnet <quentin@isovalent.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v3 bpf-next 4/9] tools/bpftool: move map/prog parsing logic into common
Date:   Fri, 19 Jun 2020 16:16:58 -0700
Message-ID: <20200619231703.738941-5-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200619231703.738941-1-andriin@fb.com>
References: <20200619231703.738941-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-19_22:2020-06-19,2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 cotscore=-2147483648 malwarescore=0 adultscore=0 impostorscore=0
 bulkscore=0 suspectscore=29 mlxscore=0 mlxlogscore=630 spamscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190163
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Move functions that parse map and prog by id/tag/name/etc outside of
map.c/prog.c, respectively. These functions are used outside of those fil=
es
and are generic enough to be in common. This also makes heavy-weight map.=
c and
prog.c more decoupled from the rest of bpftool files and facilitates more
lightweight bootstrap bpftool variant.

Reviewed-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/bpf/bpftool/common.c | 308 +++++++++++++++++++++++++++++++++++++
 tools/bpf/bpftool/main.h   |   2 +
 tools/bpf/bpftool/map.c    | 156 -------------------
 tools/bpf/bpftool/prog.c   | 152 ------------------
 4 files changed, 310 insertions(+), 308 deletions(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index c47bdc65de8e..6c864c3683fc 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -581,3 +581,311 @@ print_all_levels(__maybe_unused enum libbpf_print_l=
evel level,
 {
 	return vfprintf(stderr, format, args);
 }
+
+static int prog_fd_by_nametag(void *nametag, int **fds, bool tag)
+{
+	unsigned int id =3D 0;
+	int fd, nb_fds =3D 0;
+	void *tmp;
+	int err;
+
+	while (true) {
+		struct bpf_prog_info info =3D {};
+		__u32 len =3D sizeof(info);
+
+		err =3D bpf_prog_get_next_id(id, &id);
+		if (err) {
+			if (errno !=3D ENOENT) {
+				p_err("%s", strerror(errno));
+				goto err_close_fds;
+			}
+			return nb_fds;
+		}
+
+		fd =3D bpf_prog_get_fd_by_id(id);
+		if (fd < 0) {
+			p_err("can't get prog by id (%u): %s",
+			      id, strerror(errno));
+			goto err_close_fds;
+		}
+
+		err =3D bpf_obj_get_info_by_fd(fd, &info, &len);
+		if (err) {
+			p_err("can't get prog info (%u): %s",
+			      id, strerror(errno));
+			goto err_close_fd;
+		}
+
+		if ((tag && memcmp(nametag, info.tag, BPF_TAG_SIZE)) ||
+		    (!tag && strncmp(nametag, info.name, BPF_OBJ_NAME_LEN))) {
+			close(fd);
+			continue;
+		}
+
+		if (nb_fds > 0) {
+			tmp =3D realloc(*fds, (nb_fds + 1) * sizeof(int));
+			if (!tmp) {
+				p_err("failed to realloc");
+				goto err_close_fd;
+			}
+			*fds =3D tmp;
+		}
+		(*fds)[nb_fds++] =3D fd;
+	}
+
+err_close_fd:
+	close(fd);
+err_close_fds:
+	while (--nb_fds >=3D 0)
+		close((*fds)[nb_fds]);
+	return -1;
+}
+
+int prog_parse_fds(int *argc, char ***argv, int **fds)
+{
+	if (is_prefix(**argv, "id")) {
+		unsigned int id;
+		char *endptr;
+
+		NEXT_ARGP();
+
+		id =3D strtoul(**argv, &endptr, 0);
+		if (*endptr) {
+			p_err("can't parse %s as ID", **argv);
+			return -1;
+		}
+		NEXT_ARGP();
+
+		(*fds)[0] =3D bpf_prog_get_fd_by_id(id);
+		if ((*fds)[0] < 0) {
+			p_err("get by id (%u): %s", id, strerror(errno));
+			return -1;
+		}
+		return 1;
+	} else if (is_prefix(**argv, "tag")) {
+		unsigned char tag[BPF_TAG_SIZE];
+
+		NEXT_ARGP();
+
+		if (sscanf(**argv, BPF_TAG_FMT, tag, tag + 1, tag + 2,
+			   tag + 3, tag + 4, tag + 5, tag + 6, tag + 7)
+		    !=3D BPF_TAG_SIZE) {
+			p_err("can't parse tag");
+			return -1;
+		}
+		NEXT_ARGP();
+
+		return prog_fd_by_nametag(tag, fds, true);
+	} else if (is_prefix(**argv, "name")) {
+		char *name;
+
+		NEXT_ARGP();
+
+		name =3D **argv;
+		if (strlen(name) > BPF_OBJ_NAME_LEN - 1) {
+			p_err("can't parse name");
+			return -1;
+		}
+		NEXT_ARGP();
+
+		return prog_fd_by_nametag(name, fds, false);
+	} else if (is_prefix(**argv, "pinned")) {
+		char *path;
+
+		NEXT_ARGP();
+
+		path =3D **argv;
+		NEXT_ARGP();
+
+		(*fds)[0] =3D open_obj_pinned_any(path, BPF_OBJ_PROG);
+		if ((*fds)[0] < 0)
+			return -1;
+		return 1;
+	}
+
+	p_err("expected 'id', 'tag', 'name' or 'pinned', got: '%s'?", **argv);
+	return -1;
+}
+
+int prog_parse_fd(int *argc, char ***argv)
+{
+	int *fds =3D NULL;
+	int nb_fds, fd;
+
+	fds =3D malloc(sizeof(int));
+	if (!fds) {
+		p_err("mem alloc failed");
+		return -1;
+	}
+	nb_fds =3D prog_parse_fds(argc, argv, &fds);
+	if (nb_fds !=3D 1) {
+		if (nb_fds > 1) {
+			p_err("several programs match this handle");
+			while (nb_fds--)
+				close(fds[nb_fds]);
+		}
+		fd =3D -1;
+		goto exit_free;
+	}
+
+	fd =3D fds[0];
+exit_free:
+	free(fds);
+	return fd;
+}
+
+static int map_fd_by_name(char *name, int **fds)
+{
+	unsigned int id =3D 0;
+	int fd, nb_fds =3D 0;
+	void *tmp;
+	int err;
+
+	while (true) {
+		struct bpf_map_info info =3D {};
+		__u32 len =3D sizeof(info);
+
+		err =3D bpf_map_get_next_id(id, &id);
+		if (err) {
+			if (errno !=3D ENOENT) {
+				p_err("%s", strerror(errno));
+				goto err_close_fds;
+			}
+			return nb_fds;
+		}
+
+		fd =3D bpf_map_get_fd_by_id(id);
+		if (fd < 0) {
+			p_err("can't get map by id (%u): %s",
+			      id, strerror(errno));
+			goto err_close_fds;
+		}
+
+		err =3D bpf_obj_get_info_by_fd(fd, &info, &len);
+		if (err) {
+			p_err("can't get map info (%u): %s",
+			      id, strerror(errno));
+			goto err_close_fd;
+		}
+
+		if (strncmp(name, info.name, BPF_OBJ_NAME_LEN)) {
+			close(fd);
+			continue;
+		}
+
+		if (nb_fds > 0) {
+			tmp =3D realloc(*fds, (nb_fds + 1) * sizeof(int));
+			if (!tmp) {
+				p_err("failed to realloc");
+				goto err_close_fd;
+			}
+			*fds =3D tmp;
+		}
+		(*fds)[nb_fds++] =3D fd;
+	}
+
+err_close_fd:
+	close(fd);
+err_close_fds:
+	while (--nb_fds >=3D 0)
+		close((*fds)[nb_fds]);
+	return -1;
+}
+
+int map_parse_fds(int *argc, char ***argv, int **fds)
+{
+	if (is_prefix(**argv, "id")) {
+		unsigned int id;
+		char *endptr;
+
+		NEXT_ARGP();
+
+		id =3D strtoul(**argv, &endptr, 0);
+		if (*endptr) {
+			p_err("can't parse %s as ID", **argv);
+			return -1;
+		}
+		NEXT_ARGP();
+
+		(*fds)[0] =3D bpf_map_get_fd_by_id(id);
+		if ((*fds)[0] < 0) {
+			p_err("get map by id (%u): %s", id, strerror(errno));
+			return -1;
+		}
+		return 1;
+	} else if (is_prefix(**argv, "name")) {
+		char *name;
+
+		NEXT_ARGP();
+
+		name =3D **argv;
+		if (strlen(name) > BPF_OBJ_NAME_LEN - 1) {
+			p_err("can't parse name");
+			return -1;
+		}
+		NEXT_ARGP();
+
+		return map_fd_by_name(name, fds);
+	} else if (is_prefix(**argv, "pinned")) {
+		char *path;
+
+		NEXT_ARGP();
+
+		path =3D **argv;
+		NEXT_ARGP();
+
+		(*fds)[0] =3D open_obj_pinned_any(path, BPF_OBJ_MAP);
+		if ((*fds)[0] < 0)
+			return -1;
+		return 1;
+	}
+
+	p_err("expected 'id', 'name' or 'pinned', got: '%s'?", **argv);
+	return -1;
+}
+
+int map_parse_fd(int *argc, char ***argv)
+{
+	int *fds =3D NULL;
+	int nb_fds, fd;
+
+	fds =3D malloc(sizeof(int));
+	if (!fds) {
+		p_err("mem alloc failed");
+		return -1;
+	}
+	nb_fds =3D map_parse_fds(argc, argv, &fds);
+	if (nb_fds !=3D 1) {
+		if (nb_fds > 1) {
+			p_err("several maps match this handle");
+			while (nb_fds--)
+				close(fds[nb_fds]);
+		}
+		fd =3D -1;
+		goto exit_free;
+	}
+
+	fd =3D fds[0];
+exit_free:
+	free(fds);
+	return fd;
+}
+
+int map_parse_fd_and_info(int *argc, char ***argv, void *info, __u32 *in=
fo_len)
+{
+	int err;
+	int fd;
+
+	fd =3D map_parse_fd(argc, argv);
+	if (fd < 0)
+		return -1;
+
+	err =3D bpf_obj_get_info_by_fd(fd, info, info_len);
+	if (err) {
+		p_err("can't get map info: %s", strerror(errno));
+		close(fd);
+		return err;
+	}
+
+	return fd;
+}
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 5cdf0bc049bd..4338ab9d86d4 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -210,7 +210,9 @@ int do_iter(int argc, char **argv);
=20
 int parse_u32_arg(int *argc, char ***argv, __u32 *val, const char *what)=
;
 int prog_parse_fd(int *argc, char ***argv);
+int prog_parse_fds(int *argc, char ***argv, int **fds);
 int map_parse_fd(int *argc, char ***argv);
+int map_parse_fds(int *argc, char ***argv, int **fds);
 int map_parse_fd_and_info(int *argc, char ***argv, void *info, __u32 *in=
fo_len);
=20
 struct bpf_prog_linfo;
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index c5fac8068ba1..b9eee19b094c 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -92,162 +92,6 @@ static void *alloc_value(struct bpf_map_info *info)
 		return malloc(info->value_size);
 }
=20
-static int map_fd_by_name(char *name, int **fds)
-{
-	unsigned int id =3D 0;
-	int fd, nb_fds =3D 0;
-	void *tmp;
-	int err;
-
-	while (true) {
-		struct bpf_map_info info =3D {};
-		__u32 len =3D sizeof(info);
-
-		err =3D bpf_map_get_next_id(id, &id);
-		if (err) {
-			if (errno !=3D ENOENT) {
-				p_err("%s", strerror(errno));
-				goto err_close_fds;
-			}
-			return nb_fds;
-		}
-
-		fd =3D bpf_map_get_fd_by_id(id);
-		if (fd < 0) {
-			p_err("can't get map by id (%u): %s",
-			      id, strerror(errno));
-			goto err_close_fds;
-		}
-
-		err =3D bpf_obj_get_info_by_fd(fd, &info, &len);
-		if (err) {
-			p_err("can't get map info (%u): %s",
-			      id, strerror(errno));
-			goto err_close_fd;
-		}
-
-		if (strncmp(name, info.name, BPF_OBJ_NAME_LEN)) {
-			close(fd);
-			continue;
-		}
-
-		if (nb_fds > 0) {
-			tmp =3D realloc(*fds, (nb_fds + 1) * sizeof(int));
-			if (!tmp) {
-				p_err("failed to realloc");
-				goto err_close_fd;
-			}
-			*fds =3D tmp;
-		}
-		(*fds)[nb_fds++] =3D fd;
-	}
-
-err_close_fd:
-	close(fd);
-err_close_fds:
-	while (--nb_fds >=3D 0)
-		close((*fds)[nb_fds]);
-	return -1;
-}
-
-static int map_parse_fds(int *argc, char ***argv, int **fds)
-{
-	if (is_prefix(**argv, "id")) {
-		unsigned int id;
-		char *endptr;
-
-		NEXT_ARGP();
-
-		id =3D strtoul(**argv, &endptr, 0);
-		if (*endptr) {
-			p_err("can't parse %s as ID", **argv);
-			return -1;
-		}
-		NEXT_ARGP();
-
-		(*fds)[0] =3D bpf_map_get_fd_by_id(id);
-		if ((*fds)[0] < 0) {
-			p_err("get map by id (%u): %s", id, strerror(errno));
-			return -1;
-		}
-		return 1;
-	} else if (is_prefix(**argv, "name")) {
-		char *name;
-
-		NEXT_ARGP();
-
-		name =3D **argv;
-		if (strlen(name) > BPF_OBJ_NAME_LEN - 1) {
-			p_err("can't parse name");
-			return -1;
-		}
-		NEXT_ARGP();
-
-		return map_fd_by_name(name, fds);
-	} else if (is_prefix(**argv, "pinned")) {
-		char *path;
-
-		NEXT_ARGP();
-
-		path =3D **argv;
-		NEXT_ARGP();
-
-		(*fds)[0] =3D open_obj_pinned_any(path, BPF_OBJ_MAP);
-		if ((*fds)[0] < 0)
-			return -1;
-		return 1;
-	}
-
-	p_err("expected 'id', 'name' or 'pinned', got: '%s'?", **argv);
-	return -1;
-}
-
-int map_parse_fd(int *argc, char ***argv)
-{
-	int *fds =3D NULL;
-	int nb_fds, fd;
-
-	fds =3D malloc(sizeof(int));
-	if (!fds) {
-		p_err("mem alloc failed");
-		return -1;
-	}
-	nb_fds =3D map_parse_fds(argc, argv, &fds);
-	if (nb_fds !=3D 1) {
-		if (nb_fds > 1) {
-			p_err("several maps match this handle");
-			while (nb_fds--)
-				close(fds[nb_fds]);
-		}
-		fd =3D -1;
-		goto exit_free;
-	}
-
-	fd =3D fds[0];
-exit_free:
-	free(fds);
-	return fd;
-}
-
-int map_parse_fd_and_info(int *argc, char ***argv, void *info, __u32 *in=
fo_len)
-{
-	int err;
-	int fd;
-
-	fd =3D map_parse_fd(argc, argv);
-	if (fd < 0)
-		return -1;
-
-	err =3D bpf_obj_get_info_by_fd(fd, info, info_len);
-	if (err) {
-		p_err("can't get map info: %s", strerror(errno));
-		close(fd);
-		return err;
-	}
-
-	return fd;
-}
-
 static int do_dump_btf(const struct btf_dumper *d,
 		       struct bpf_map_info *map_info, void *key,
 		       void *value)
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index a5eff83496f2..53d47610ff58 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -86,158 +86,6 @@ static void print_boot_time(__u64 nsecs, char *buf, u=
nsigned int size)
 		strftime(buf, size, "%FT%T%z", &load_tm);
 }
=20
-static int prog_fd_by_nametag(void *nametag, int **fds, bool tag)
-{
-	unsigned int id =3D 0;
-	int fd, nb_fds =3D 0;
-	void *tmp;
-	int err;
-
-	while (true) {
-		struct bpf_prog_info info =3D {};
-		__u32 len =3D sizeof(info);
-
-		err =3D bpf_prog_get_next_id(id, &id);
-		if (err) {
-			if (errno !=3D ENOENT) {
-				p_err("%s", strerror(errno));
-				goto err_close_fds;
-			}
-			return nb_fds;
-		}
-
-		fd =3D bpf_prog_get_fd_by_id(id);
-		if (fd < 0) {
-			p_err("can't get prog by id (%u): %s",
-			      id, strerror(errno));
-			goto err_close_fds;
-		}
-
-		err =3D bpf_obj_get_info_by_fd(fd, &info, &len);
-		if (err) {
-			p_err("can't get prog info (%u): %s",
-			      id, strerror(errno));
-			goto err_close_fd;
-		}
-
-		if ((tag && memcmp(nametag, info.tag, BPF_TAG_SIZE)) ||
-		    (!tag && strncmp(nametag, info.name, BPF_OBJ_NAME_LEN))) {
-			close(fd);
-			continue;
-		}
-
-		if (nb_fds > 0) {
-			tmp =3D realloc(*fds, (nb_fds + 1) * sizeof(int));
-			if (!tmp) {
-				p_err("failed to realloc");
-				goto err_close_fd;
-			}
-			*fds =3D tmp;
-		}
-		(*fds)[nb_fds++] =3D fd;
-	}
-
-err_close_fd:
-	close(fd);
-err_close_fds:
-	while (--nb_fds >=3D 0)
-		close((*fds)[nb_fds]);
-	return -1;
-}
-
-static int prog_parse_fds(int *argc, char ***argv, int **fds)
-{
-	if (is_prefix(**argv, "id")) {
-		unsigned int id;
-		char *endptr;
-
-		NEXT_ARGP();
-
-		id =3D strtoul(**argv, &endptr, 0);
-		if (*endptr) {
-			p_err("can't parse %s as ID", **argv);
-			return -1;
-		}
-		NEXT_ARGP();
-
-		(*fds)[0] =3D bpf_prog_get_fd_by_id(id);
-		if ((*fds)[0] < 0) {
-			p_err("get by id (%u): %s", id, strerror(errno));
-			return -1;
-		}
-		return 1;
-	} else if (is_prefix(**argv, "tag")) {
-		unsigned char tag[BPF_TAG_SIZE];
-
-		NEXT_ARGP();
-
-		if (sscanf(**argv, BPF_TAG_FMT, tag, tag + 1, tag + 2,
-			   tag + 3, tag + 4, tag + 5, tag + 6, tag + 7)
-		    !=3D BPF_TAG_SIZE) {
-			p_err("can't parse tag");
-			return -1;
-		}
-		NEXT_ARGP();
-
-		return prog_fd_by_nametag(tag, fds, true);
-	} else if (is_prefix(**argv, "name")) {
-		char *name;
-
-		NEXT_ARGP();
-
-		name =3D **argv;
-		if (strlen(name) > BPF_OBJ_NAME_LEN - 1) {
-			p_err("can't parse name");
-			return -1;
-		}
-		NEXT_ARGP();
-
-		return prog_fd_by_nametag(name, fds, false);
-	} else if (is_prefix(**argv, "pinned")) {
-		char *path;
-
-		NEXT_ARGP();
-
-		path =3D **argv;
-		NEXT_ARGP();
-
-		(*fds)[0] =3D open_obj_pinned_any(path, BPF_OBJ_PROG);
-		if ((*fds)[0] < 0)
-			return -1;
-		return 1;
-	}
-
-	p_err("expected 'id', 'tag', 'name' or 'pinned', got: '%s'?", **argv);
-	return -1;
-}
-
-int prog_parse_fd(int *argc, char ***argv)
-{
-	int *fds =3D NULL;
-	int nb_fds, fd;
-
-	fds =3D malloc(sizeof(int));
-	if (!fds) {
-		p_err("mem alloc failed");
-		return -1;
-	}
-	nb_fds =3D prog_parse_fds(argc, argv, &fds);
-	if (nb_fds !=3D 1) {
-		if (nb_fds > 1) {
-			p_err("several programs match this handle");
-			while (nb_fds--)
-				close(fds[nb_fds]);
-		}
-		fd =3D -1;
-		goto exit_free;
-	}
-
-	fd =3D fds[0];
-exit_free:
-	free(fds);
-	return fd;
-}
-
 static void show_prog_maps(int fd, __u32 num_maps)
 {
 	struct bpf_prog_info info =3D {};
--=20
2.24.1

