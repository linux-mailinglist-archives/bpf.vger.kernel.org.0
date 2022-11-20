Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B807C6313AA
	for <lists+bpf@lfdr.de>; Sun, 20 Nov 2022 12:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiKTL0l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 06:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKTL0k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 06:26:40 -0500
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2974875C
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 03:26:39 -0800 (PST)
Date:   Sun, 20 Nov 2022 11:26:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=industrialdiscipline.com; s=protonmail3; t=1668943597;
        x=1669202797; bh=C0Z+iDw+3TpC36U6L6IWb4lHumoK+Cq02cBpx2pn5tE=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=xTYQWuVsYLuubs9vaEHt2ud0hCKGDeVzcn1GFw9sGfvNPvZctErrP+RXHSkYU5UOx
         SalPK/QbYfjsxfmN7WM8szJY/L6fVrZcvrAXzRp1ETaojCb8krLxfOk2Ai2TtwqNYO
         Q8NQhtATiDPDMcDlnDEz7B862k4634drrs4GQU+1/D9HdRVR5PIffXjvCCD84dSIRA
         vRTvkQPAg+PP2djv0jKFisRo/GMrT39k1QnzJEcn/ffu1oev+BHSWifnWXm0TzpfH4
         lZfXIchUsfxjxN74/vO+n2O9p05Yo4wnCP/08QwszKJjpgvRFFHTFgFDzDLC/j57gA
         vty+CDeyCjOfg==
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, quentin@isovalent.com, yhs@fb.com
From:   Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Cc:     martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org,
        Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Subject: [PATCH bpf-next v4 4/5] bpftool: clean-up usage of libbpf_get_error()
Message-ID: <20221120112515.38165-5-sahid.ferdjaoui@industrialdiscipline.com>
Feedback-ID: 39921202:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpftool is now totally compliant with libbpf 1.0 mode and is not
expected to be compiled with pre-1.0, let's clean-up the usage of
libbpf_get_error().

The changes stay aligned with returned errors always negative.

- In tools/bpf/bpftool/btf.c This fixes an uninitialized local
variable `err` in function do_dump() because it may now be returned
without having been set.
- This also removes the checks on NULL pointers before calling
btf__free() because that function already does the check.

Signed-off-by: Sahid Orentino Ferdjaoui <sahid.ferdjaoui@industrialdiscipli=
ne.com>
---
 tools/bpf/bpftool/btf.c        | 19 ++++++++-----------
 tools/bpf/bpftool/btf_dumper.c |  2 +-
 tools/bpf/bpftool/gen.c        | 10 ++++------
 tools/bpf/bpftool/iter.c       | 10 ++++++----
 tools/bpf/bpftool/main.c       |  7 +++----
 tools/bpf/bpftool/map.c        | 15 +++++++--------
 tools/bpf/bpftool/prog.c       | 10 +++++-----
 tools/bpf/bpftool/struct_ops.c | 11 +++++------
 8 files changed, 39 insertions(+), 45 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index b87e4a7fd689..352290ba7b29 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -467,9 +467,8 @@ static int dump_btf_c(const struct btf *btf,
 =09int err =3D 0, i;

 =09d =3D btf_dump__new(btf, btf_dump_printf, NULL, NULL);
-=09err =3D libbpf_get_error(d);
-=09if (err)
-=09=09return err;
+=09if (!d)
+=09=09return -errno;

 =09printf("#ifndef __VMLINUX_H__\n");
 =09printf("#define __VMLINUX_H__\n");
@@ -512,11 +511,9 @@ static struct btf *get_vmlinux_btf_from_sysfs(void)
 =09struct btf *base;

 =09base =3D btf__parse(sysfs_vmlinux, NULL);
-=09if (libbpf_get_error(base)) {
-=09=09p_err("failed to parse vmlinux BTF at '%s': %ld\n",
-=09=09      sysfs_vmlinux, libbpf_get_error(base));
-=09=09base =3D NULL;
-=09}
+=09if (!base)
+=09=09p_err("failed to parse vmlinux BTF at '%s': %d\n",
+=09=09      sysfs_vmlinux, -errno);

 =09return base;
 }
@@ -559,7 +556,7 @@ static int do_dump(int argc, char **argv)
 =09__u32 btf_id =3D -1;
 =09const char *src;
 =09int fd =3D -1;
-=09int err;
+=09int err =3D 0;

 =09if (!REQ_ARGS(2)) {
 =09=09usage();
@@ -634,8 +631,8 @@ static int do_dump(int argc, char **argv)
 =09=09=09base =3D get_vmlinux_btf_from_sysfs();

 =09=09btf =3D btf__parse_split(*argv, base ?: base_btf);
-=09=09err =3D libbpf_get_error(btf);
 =09=09if (!btf) {
+=09=09=09err =3D -errno;
 =09=09=09p_err("failed to load BTF from %s: %s",
 =09=09=09      *argv, strerror(errno));
 =09=09=09goto done;
@@ -681,8 +678,8 @@ static int do_dump(int argc, char **argv)
 =09=09}

 =09=09btf =3D btf__load_from_kernel_by_id_split(btf_id, base_btf);
-=09=09err =3D libbpf_get_error(btf);
 =09=09if (!btf) {
+=09=09=09err =3D -errno;
 =09=09=09p_err("get btf by id (%u): %s", btf_id, strerror(errno));
 =09=09=09goto done;
 =09=09}
diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.=
c
index 19924b6ce796..eda71fdfe95a 100644
--- a/tools/bpf/bpftool/btf_dumper.c
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -75,7 +75,7 @@ static int dump_prog_id_as_func_ptr(const struct btf_dump=
er *d,
 =09=09goto print;

 =09prog_btf =3D btf__load_from_kernel_by_id(info.btf_id);
-=09if (libbpf_get_error(prog_btf))
+=09if (!prog_btf)
 =09=09goto print;
 =09func_type =3D btf__type_by_id(prog_btf, finfo.type_id);
 =09if (!func_type || !btf_is_func(func_type))
diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 01bb8d8f5568..2883660d6b67 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -252,9 +252,8 @@ static int codegen_datasecs(struct bpf_object *obj, con=
st char *obj_name)
 =09int err =3D 0;

 =09d =3D btf_dump__new(btf, codegen_btf_dump_printf, NULL, NULL);
-=09err =3D libbpf_get_error(d);
-=09if (err)
-=09=09return err;
+=09if (!d)
+=09=09return -errno;

 =09bpf_object__for_each_map(map, obj) {
 =09=09/* only generate definitions for memory-mapped internal maps */
@@ -976,13 +975,12 @@ static int do_skeleton(int argc, char **argv)
 =09=09/* log_level1 + log_level2 + stats, but not stable UAPI */
 =09=09opts.kernel_log_level =3D 1 + 2 + 4;
 =09obj =3D bpf_object__open_mem(obj_data, file_sz, &opts);
-=09err =3D libbpf_get_error(obj);
-=09if (err) {
+=09if (!obj) {
 =09=09char err_buf[256];

+=09=09err =3D -errno;
 =09=09libbpf_strerror(err, err_buf, sizeof(err_buf));
 =09=09p_err("failed to open BPF object file: %s", err_buf);
-=09=09obj =3D NULL;
 =09=09goto out;
 =09}

diff --git a/tools/bpf/bpftool/iter.c b/tools/bpf/bpftool/iter.c
index a3e6b167153d..9a1d2365a297 100644
--- a/tools/bpf/bpftool/iter.c
+++ b/tools/bpf/bpftool/iter.c
@@ -4,6 +4,7 @@
 #ifndef _GNU_SOURCE
 #define _GNU_SOURCE
 #endif
+#include <errno.h>
 #include <unistd.h>
 #include <linux/err.h>
 #include <bpf/libbpf.h>
@@ -48,8 +49,8 @@ static int do_pin(int argc, char **argv)
 =09}

 =09obj =3D bpf_object__open(objfile);
-=09err =3D libbpf_get_error(obj);
-=09if (err) {
+=09if (!obj) {
+=09=09err =3D -errno;
 =09=09p_err("can't open objfile %s", objfile);
 =09=09goto close_map_fd;
 =09}
@@ -62,13 +63,14 @@ static int do_pin(int argc, char **argv)

 =09prog =3D bpf_object__next_program(obj, NULL);
 =09if (!prog) {
+=09=09err =3D -errno;
 =09=09p_err("can't find bpf program in objfile %s", objfile);
 =09=09goto close_obj;
 =09}

 =09link =3D bpf_program__attach_iter(prog, &iter_opts);
-=09err =3D libbpf_get_error(link);
-=09if (err) {
+=09if (!link) {
+=09=09err =3D -errno;
 =09=09p_err("attach_iter failed for program %s",
 =09=09      bpf_program__name(prog));
 =09=09goto close_obj;
diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index c53c553adcac..08d0ac543c67 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -510,10 +510,9 @@ int main(int argc, char **argv)
 =09=09=09break;
 =09=09case 'B':
 =09=09=09base_btf =3D btf__parse(optarg, NULL);
-=09=09=09if (libbpf_get_error(base_btf)) {
-=09=09=09=09p_err("failed to parse base BTF at '%s': %ld\n",
-=09=09=09=09      optarg, libbpf_get_error(base_btf));
-=09=09=09=09base_btf =3D NULL;
+=09=09=09if (!base_btf) {
+=09=09=09=09p_err("failed to parse base BTF at '%s': %d\n",
+=09=09=09=09      optarg, -errno);
 =09=09=09=09return -1;
 =09=09=09}
 =09=09=09break;
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index d884070a2314..eb362bd3d2c9 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -786,18 +786,18 @@ static int get_map_kv_btf(const struct bpf_map_info *=
info, struct btf **btf)
 =09if (info->btf_vmlinux_value_type_id) {
 =09=09if (!btf_vmlinux) {
 =09=09=09btf_vmlinux =3D libbpf_find_kernel_btf();
-=09=09=09err =3D libbpf_get_error(btf_vmlinux);
-=09=09=09if (err) {
+=09=09=09if (!btf_vmlinux) {
 =09=09=09=09p_err("failed to get kernel btf");
-=09=09=09=09return err;
+=09=09=09=09return -errno;
 =09=09=09}
 =09=09}
 =09=09*btf =3D btf_vmlinux;
 =09} else if (info->btf_value_type_id) {
 =09=09*btf =3D btf__load_from_kernel_by_id(info->btf_id);
-=09=09err =3D libbpf_get_error(*btf);
-=09=09if (err)
+=09=09if (!*btf) {
+=09=09=09err =3D -errno;
 =09=09=09p_err("failed to get btf");
+=09=09}
 =09} else {
 =09=09*btf =3D NULL;
 =09}
@@ -807,14 +807,13 @@ static int get_map_kv_btf(const struct bpf_map_info *=
info, struct btf **btf)

 static void free_map_kv_btf(struct btf *btf)
 {
-=09if (!libbpf_get_error(btf) && btf !=3D btf_vmlinux)
+=09if (btf !=3D btf_vmlinux)
 =09=09btf__free(btf);
 }

 static void free_btf_vmlinux(void)
 {
-=09if (!libbpf_get_error(btf_vmlinux))
-=09=09btf__free(btf_vmlinux);
+=09btf__free(btf_vmlinux);
 }

 static int
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 2266958f203f..cfc9fdc1e863 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -322,7 +322,7 @@ static void show_prog_metadata(int fd, __u32 num_maps)
 =09=09return;

 =09btf =3D btf__load_from_kernel_by_id(map_info.btf_id);
-=09if (libbpf_get_error(btf))
+=09if (!btf)
 =09=09goto out_free;

 =09t_datasec =3D btf__type_by_id(btf, map_info.btf_value_type_id);
@@ -726,7 +726,7 @@ prog_dump(struct bpf_prog_info *info, enum dump_mode mo=
de,

 =09if (info->btf_id) {
 =09=09btf =3D btf__load_from_kernel_by_id(info->btf_id);
-=09=09if (libbpf_get_error(btf)) {
+=09=09if (!btf) {
 =09=09=09p_err("failed to get btf");
 =09=09=09return -1;
 =09=09}
@@ -1663,7 +1663,7 @@ static int load_with_options(int argc, char **argv, b=
ool first_prog_only)
 =09=09open_opts.kernel_log_level =3D 1 + 2 + 4;

 =09obj =3D bpf_object__open_file(file, &open_opts);
-=09if (libbpf_get_error(obj)) {
+=09if (!obj) {
 =09=09p_err("failed to open object file");
 =09=09goto err_free_reuse_maps;
 =09}
@@ -1882,7 +1882,7 @@ static int do_loader(int argc, char **argv)
 =09=09open_opts.kernel_log_level =3D 1 + 2 + 4;

 =09obj =3D bpf_object__open_file(file, &open_opts);
-=09if (libbpf_get_error(obj)) {
+=09if (!obj) {
 =09=09p_err("failed to open object file");
 =09=09goto err_close_obj;
 =09}
@@ -2199,7 +2199,7 @@ static char *profile_target_name(int tgt_fd)
 =09}

 =09btf =3D btf__load_from_kernel_by_id(info.btf_id);
-=09if (libbpf_get_error(btf)) {
+=09if (!btf) {
 =09=09p_err("failed to load btf for prog FD %d", tgt_fd);
 =09=09goto out;
 =09}
diff --git a/tools/bpf/bpftool/struct_ops.c b/tools/bpf/bpftool/struct_ops.=
c
index ae9ad85f5cda..903b80ff4e9a 100644
--- a/tools/bpf/bpftool/struct_ops.c
+++ b/tools/bpf/bpftool/struct_ops.c
@@ -32,7 +32,7 @@ static const struct btf *get_btf_vmlinux(void)
 =09=09return btf_vmlinux;

 =09btf_vmlinux =3D libbpf_find_kernel_btf();
-=09if (libbpf_get_error(btf_vmlinux))
+=09if (!btf_vmlinux)
 =09=09p_err("struct_ops requires kernel CONFIG_DEBUG_INFO_BTF=3Dy");

 =09return btf_vmlinux;
@@ -45,7 +45,7 @@ static const char *get_kern_struct_ops_name(const struct =
bpf_map_info *info)
 =09const char *st_ops_name;

 =09kern_btf =3D get_btf_vmlinux();
-=09if (libbpf_get_error(kern_btf))
+=09if (!kern_btf)
 =09=09return "<btf_vmlinux_not_found>";

 =09t =3D btf__type_by_id(kern_btf, info->btf_vmlinux_value_type_id);
@@ -413,7 +413,7 @@ static int do_dump(int argc, char **argv)
 =09}

 =09kern_btf =3D get_btf_vmlinux();
-=09if (libbpf_get_error(kern_btf))
+=09if (!kern_btf)
 =09=09return -1;

 =09if (!json_output) {
@@ -496,7 +496,7 @@ static int do_register(int argc, char **argv)
 =09=09open_opts.kernel_log_level =3D 1 + 2 + 4;

 =09obj =3D bpf_object__open_file(file, &open_opts);
-=09if (libbpf_get_error(obj))
+=09if (!obj)
 =09=09return -1;

 =09set_max_rlimit();
@@ -590,8 +590,7 @@ int do_struct_ops(int argc, char **argv)

 =09err =3D cmd_select(cmds, argc, argv, do_help);

-=09if (!libbpf_get_error(btf_vmlinux))
-=09=09btf__free(btf_vmlinux);
+=09btf__free(btf_vmlinux);

 =09return err;
 }
--
2.34.1


