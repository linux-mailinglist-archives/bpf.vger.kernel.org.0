Return-Path: <bpf+bounces-17723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D9381215E
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 23:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8391C20E41
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 22:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8232E81827;
	Wed, 13 Dec 2023 22:24:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EC89C
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 14:23:56 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDLi1Yp014182
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 14:23:55 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uxx6qgqd3-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 14:23:55 -0800
Received: from twshared51573.38.frc1.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 13 Dec 2023 14:23:53 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 7C4D93D1AF7FA; Wed, 13 Dec 2023 14:23:42 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 1/2] bpf: support symbolic BPF FS delegation mount options
Date: Wed, 13 Dec 2023 14:23:26 -0800
Message-ID: <20231213222327.934981-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213222327.934981-1-andrii@kernel.org>
References: <20231213222327.934981-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: nAOZ_x_1MtIM9vkXKrZqx5dgcWFXESUS
X-Proofpoint-GUID: nAOZ_x_1MtIM9vkXKrZqx5dgcWFXESUS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_14,2023-12-13_01,2023-05-22_02

Besides already supported special "any" value and hex bit mask, support
string-based parsing of delegation masks based on exact enumerator
names. Utilize BTF information of `enum bpf_cmd`, `enum bpf_map_type`,
`enum bpf_prog_type`, and `enum bpf_attach_type` types to find supported
symbolic names (ignoring __MAX_xxx guard values). So "BPF_PROG_LOAD" and
"BPF_MAP_CREATE" are valid values to specify for delegate_cmds options,
"BPF_MAP_TYPE_ARRAY" is among supported for map types, etc.

Besides supporting string values, we also support multiple values
specified at the same time, using colon (':') separator.

There are corresponding changes on bpf_show_options side to use known
values to print them in human-readable format, falling back to hex mask
printing, if there are any unrecognized bits. This shouldn't be
necessary when enum BTF information is present, but in general we should
always be able to fall back to this even if kernel was built without BTF.

Example below shows various ways to specify delegate_cmds options
through mount command and how mount options are printed back:

  $ sudo mkdir -p /sys/fs/bpf/token
  $ sudo mount -t bpf bpffs /sys/fs/bpf/token \
               -o delegate_cmds=3DBPF_PROG_LOAD \
               -o delegate_cmds=3DBPF_MAP_CREATE \
               -o delegate_cmds=3DBPF_TOKEN_CREATE:BPF_BTF_LOAD:BPF_LINK_=
CREATE
  $ mount | grep token
  bpffs on /sys/fs/bpf/token type bpf (rw,relatime,delegate_cmds=3DBPF_MA=
P_CREATE:BPF_PROG_LOAD:BPF_BTF_LOAD:BPF_LINK_CREATE:BPF_TOKEN_CREATE)

Same approach works across delegate_maps, delegate_progs, and
delegate_attachs masks as well.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/inode.c | 231 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 193 insertions(+), 38 deletions(-)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 5359a0929c35..e90d4be5c759 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -595,6 +595,127 @@ struct bpf_prog *bpf_prog_get_type_path(const char =
*name, enum bpf_prog_type typ
 }
 EXPORT_SYMBOL(bpf_prog_get_type_path);
=20
+struct bpffs_btf_enums {
+	const struct btf *btf;
+	const struct btf_type *cmd_t;
+	const struct btf_type *map_t;
+	const struct btf_type *prog_t;
+	const struct btf_type *attach_t;
+};
+
+static int find_bpffs_btf_enums(struct bpffs_btf_enums *info)
+{
+	const struct btf *btf;
+	const struct btf_type *t;
+	const char *name;
+	int i, n;
+
+	memset(info, 0, sizeof(*info));
+
+	btf =3D bpf_get_btf_vmlinux();
+	if (IS_ERR(btf))
+		return PTR_ERR(btf);
+	if (!btf)
+		return -ENOENT;
+
+	info->btf =3D btf;
+
+	for (i =3D 1, n =3D btf_nr_types(btf); i < n; i++) {
+		t =3D btf_type_by_id(btf, i);
+		if (!btf_type_is_enum(t))
+			continue;
+
+		name =3D btf_name_by_offset(btf, t->name_off);
+		if (!name)
+			continue;
+
+		if (strcmp(name, "bpf_cmd") =3D=3D 0)
+			info->cmd_t =3D t;
+		else if (strcmp(name, "bpf_map_type") =3D=3D 0)
+			info->map_t =3D t;
+		else if (strcmp(name, "bpf_prog_type") =3D=3D 0)
+			info->prog_t =3D t;
+		else if (strcmp(name, "bpf_attach_type") =3D=3D 0)
+			info->attach_t =3D t;
+		else
+			continue;
+
+		if (info->cmd_t && info->map_t && info->prog_t && info->attach_t)
+			return 0;
+	}
+
+	return -ESRCH;
+}
+
+static bool find_btf_enum_const(const struct btf *btf, const struct btf_=
type *enum_t,
+			        const char *str, int *value)
+{
+	const struct btf_enum *e;
+	const char *name;
+	int i, n;
+
+	*value =3D 0;
+
+	if (!btf || !enum_t)
+		return false;
+
+	for (i =3D 0, n =3D btf_vlen(enum_t); i < n; i++) {
+		e =3D &btf_enum(enum_t)[i];
+
+		name =3D btf_name_by_offset(btf, e->name_off);
+		if (!name || (name[0] =3D=3D '_' && name[1] =3D=3D '_'))
+			continue;
+
+		if (strcmp(name, str) =3D=3D 0) {
+			*value =3D e->val;
+			return true;
+		}
+	}
+
+	return false;
+}
+
+static void seq_print_delegate_opts(struct seq_file *m,
+				    const char *opt_name,
+				    const struct btf *btf,
+				    const struct btf_type *enum_t,
+				    u64 delegate_msk, u64 any_msk)
+{
+	const struct btf_enum *e;
+	bool first =3D true;
+	const char *name;
+	u64 msk;
+	int i, n;
+
+	delegate_msk &=3D any_msk; /* clear unknown bits */
+
+	if (delegate_msk =3D=3D 0)
+		return;
+
+	seq_printf(m, ",%s", opt_name);
+	if (delegate_msk =3D=3D any_msk) {
+		seq_printf(m, "=3Dany");
+		return;
+	}
+
+	if (btf && enum_t) {
+		for (i =3D 0, n =3D btf_vlen(enum_t); i < n; i++) {
+			e =3D &btf_enum(enum_t)[i];
+			name =3D btf_name_by_offset(btf, e->name_off);
+			if (!name || (name[0] =3D=3D '_' && name[1] =3D=3D '_'))
+				continue;
+			msk =3D 1ULL << e->val;
+			if (delegate_msk & msk) {
+				seq_printf(m, "%c%s", first ? '=3D' : ':', name);
+				delegate_msk &=3D ~msk;
+				first =3D false;
+			}
+		}
+	}
+	if (delegate_msk)
+		seq_printf(m, "%c0x%llx", first ? '=3D' : ':', delegate_msk);
+}
+
 /*
  * Display the mount options in /proc/mounts.
  */
@@ -607,29 +728,30 @@ static int bpf_show_options(struct seq_file *m, str=
uct dentry *root)
 	if (mode !=3D S_IRWXUGO)
 		seq_printf(m, ",mode=3D%o", mode);
=20
-	mask =3D (1ULL << __MAX_BPF_CMD) - 1;
-	if ((opts->delegate_cmds & mask) =3D=3D mask)
-		seq_printf(m, ",delegate_cmds=3Dany");
-	else if (opts->delegate_cmds)
-		seq_printf(m, ",delegate_cmds=3D0x%llx", opts->delegate_cmds);
-
-	mask =3D (1ULL << __MAX_BPF_MAP_TYPE) - 1;
-	if ((opts->delegate_maps & mask) =3D=3D mask)
-		seq_printf(m, ",delegate_maps=3Dany");
-	else if (opts->delegate_maps)
-		seq_printf(m, ",delegate_maps=3D0x%llx", opts->delegate_maps);
-
-	mask =3D (1ULL << __MAX_BPF_PROG_TYPE) - 1;
-	if ((opts->delegate_progs & mask) =3D=3D mask)
-		seq_printf(m, ",delegate_progs=3Dany");
-	else if (opts->delegate_progs)
-		seq_printf(m, ",delegate_progs=3D0x%llx", opts->delegate_progs);
-
-	mask =3D (1ULL << __MAX_BPF_ATTACH_TYPE) - 1;
-	if ((opts->delegate_attachs & mask) =3D=3D mask)
-		seq_printf(m, ",delegate_attachs=3Dany");
-	else if (opts->delegate_attachs)
-		seq_printf(m, ",delegate_attachs=3D0x%llx", opts->delegate_attachs);
+	if (opts->delegate_cmds || opts->delegate_maps ||
+	    opts->delegate_progs || opts->delegate_attachs) {
+		struct bpffs_btf_enums info;
+
+		/* ignore errors, fallback to hex */
+		(void)find_bpffs_btf_enums(&info);
+
+		mask =3D (1ULL << __MAX_BPF_CMD) - 1;
+		seq_print_delegate_opts(m, "delegate_cmds", info.btf, info.cmd_t,
+					opts->delegate_cmds, mask);
+
+		mask =3D (1ULL << __MAX_BPF_MAP_TYPE) - 1;
+		seq_print_delegate_opts(m, "delegate_maps", info.btf, info.map_t,
+					opts->delegate_maps, mask);
+
+		mask =3D (1ULL << __MAX_BPF_PROG_TYPE) - 1;
+		seq_print_delegate_opts(m, "delegate_progs", info.btf, info.prog_t,
+					opts->delegate_progs, mask);
+
+		mask =3D (1ULL << __MAX_BPF_ATTACH_TYPE) - 1;
+		seq_print_delegate_opts(m, "delegate_attachs", info.btf, info.attach_t=
,
+					opts->delegate_attachs, mask);
+	}
+
 	return 0;
 }
=20
@@ -673,7 +795,6 @@ static int bpf_parse_param(struct fs_context *fc, str=
uct fs_parameter *param)
 	struct bpf_mount_opts *opts =3D fc->s_fs_info;
 	struct fs_parse_result result;
 	int opt, err;
-	u64 msk;
=20
 	opt =3D fs_parse(fc, bpf_fs_parameters, param, &result);
 	if (opt < 0) {
@@ -700,24 +821,58 @@ static int bpf_parse_param(struct fs_context *fc, s=
truct fs_parameter *param)
 	case OPT_DELEGATE_CMDS:
 	case OPT_DELEGATE_MAPS:
 	case OPT_DELEGATE_PROGS:
-	case OPT_DELEGATE_ATTACHS:
-		if (strcmp(param->string, "any") =3D=3D 0) {
-			msk =3D ~0ULL;
-		} else {
-			err =3D kstrtou64(param->string, 0, &msk);
-			if (err)
-				return err;
+	case OPT_DELEGATE_ATTACHS: {
+		struct bpffs_btf_enums info;
+		const struct btf_type *enum_t;
+		u64 *delegate_msk, msk =3D 0;
+		char *p;
+		int val;
+
+		/* ignore errors, fallback to hex */
+		(void)find_bpffs_btf_enums(&info);
+
+		switch (opt) {
+		case OPT_DELEGATE_CMDS:
+			delegate_msk =3D &opts->delegate_cmds;
+			enum_t =3D info.cmd_t;
+			break;
+		case OPT_DELEGATE_MAPS:
+			delegate_msk =3D &opts->delegate_maps;
+			enum_t =3D info.map_t;
+			break;
+		case OPT_DELEGATE_PROGS:
+			delegate_msk =3D &opts->delegate_progs;
+			enum_t =3D info.prog_t;
+			break;
+		case OPT_DELEGATE_ATTACHS:
+			delegate_msk =3D &opts->delegate_attachs;
+			enum_t =3D info.attach_t;
+			break;
+		default:
+			return -EINVAL;
 		}
+
+		while ((p =3D strsep(&param->string, ":"))) {
+			if (strcmp(p, "any") =3D=3D 0) {
+				msk |=3D ~0ULL;
+			} else if (find_btf_enum_const(info.btf, enum_t, p, &val)) {
+				msk |=3D 1ULL << val;
+			} else {
+				err =3D kstrtou64(p, 0, &msk);
+				if (err)
+					return err;
+			}
+		}
+
 		/* Setting delegation mount options requires privileges */
 		if (msk && !capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		switch (opt) {
-		case OPT_DELEGATE_CMDS: opts->delegate_cmds |=3D msk; break;
-		case OPT_DELEGATE_MAPS: opts->delegate_maps |=3D msk; break;
-		case OPT_DELEGATE_PROGS: opts->delegate_progs |=3D msk; break;
-		case OPT_DELEGATE_ATTACHS: opts->delegate_attachs |=3D msk; break;
-		default: return -EINVAL;
-		}
+
+		*delegate_msk |=3D msk;
+		break;
+	}
+	default:
+		/* ignore unknown mount options */
 		break;
 	}
=20
--=20
2.34.1


