Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DE86224D3
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 08:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiKIHpZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 02:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiKIHpY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 02:45:24 -0500
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAE8186FE
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 23:45:23 -0800 (PST)
Date:   Wed, 09 Nov 2022 07:45:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=industrialdiscipline.com; s=protonmail3; t=1667979921;
        x=1668239121; bh=osWqKS7d7AA7XQkvqnhF8DNAcNVgIDIxtZSx0nqSRDA=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Ig8LwaTXSVw8rGSVOlfYZwiUm7QJE+Mkx1R3j66P+PAjFZIlLzbl7OAJlmNO5TuNM
         XBySQVZ6b3WvKEeBUD/Kh9Tx/HJN/cdWT6Itxyy504y/VjfG7uU9wHyLxATeTlgm8A
         7iCcnpjZhf+YgAQ2m50cZGK7mRE5JhqGrd8BSkUU9BQN5VnMy3Csp0LLgHk+lKIll8
         eq8BO1tpn6mn+my02H39JTVWeBEdOZSldzC4t017aqdifHU0E6YQMrO0ILzDFqs8jg
         piEmoTSV4CO/b3oNY3KekxamVPT4aN5VQLAigtab6dCNLIO7cQ5wAoxp75R64sO0rv
         mzncBXCH4Wgyw==
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, quentin@isovalent.com
From:   Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Cc:     martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Subject: [PATCH bpf-next v2 1/5] bpftool: remove support of --legacy option for bpftool
Message-ID: <20221109074427.141751-2-sahid.ferdjaoui@industrialdiscipline.com>
In-Reply-To: <20221109074427.141751-1-sahid.ferdjaoui@industrialdiscipline.com>
References: <20221109074427.141751-1-sahid.ferdjaoui@industrialdiscipline.com>
Feedback-ID: 39921202:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Following:
  commit bd054102a8c7 ("libbpf: enforce strict libbpf 1.0 behaviors")
  commit 93b8952d223a ("libbpf: deprecate legacy BPF map definitions")

The --legacy option is no longer relevant as libbpf no longer supports
it. libbpf_set_strict_mode() is a no-op operation.

Signed-off-by: Sahid Orentino Ferdjaoui <sahid.ferdjaoui@industrialdiscipli=
ne.com>
---
 .../bpf/bpftool/Documentation/common_options.rst  |  9 ---------
 tools/bpf/bpftool/Documentation/substitutions.rst |  2 +-
 tools/bpf/bpftool/bash-completion/bpftool         |  2 +-
 tools/bpf/bpftool/main.c                          | 15 ---------------
 tools/bpf/bpftool/main.h                          |  3 +--
 tools/bpf/bpftool/prog.c                          |  5 -----
 .../selftests/bpf/test_bpftool_synctypes.py       |  6 +++---
 7 files changed, 6 insertions(+), 36 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/common_options.rst b/tools/bpf=
/bpftool/Documentation/common_options.rst
index 05350a1aadf9..30df7a707f02 100644
--- a/tools/bpf/bpftool/Documentation/common_options.rst
+++ b/tools/bpf/bpftool/Documentation/common_options.rst
@@ -23,12 +23,3 @@
 =09  Print all logs available, even debug-level information. This includes
 =09  logs from libbpf as well as from the verifier, when attempting to
 =09  load programs.
-
--l, --legacy
-=09  Use legacy libbpf mode which has more relaxed BPF program
-=09  requirements. By default, bpftool has more strict requirements
-=09  about section names, changes pinning logic and doesn't support
-=09  some of the older non-BTF map declarations.
-
-=09  See https://github.com/libbpf/libbpf/wiki/Libbpf:-the-road-to-v1.0
-=09  for details.
diff --git a/tools/bpf/bpftool/Documentation/substitutions.rst b/tools/bpf/=
bpftool/Documentation/substitutions.rst
index ccf1ffa0686c..827e3ffb1766 100644
--- a/tools/bpf/bpftool/Documentation/substitutions.rst
+++ b/tools/bpf/bpftool/Documentation/substitutions.rst
@@ -1,3 +1,3 @@
 .. SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)

-.. |COMMON_OPTIONS| replace:: { **-j** | **--json** } [{ **-p** | **--pret=
ty** }] | { **-d** | **--debug** } | { **-l** | **--legacy** }
+.. |COMMON_OPTIONS| replace:: { **-j** | **--json** } [{ **-p** | **--pret=
ty** }] | { **-d** | **--debug** }
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/=
bash-completion/bpftool
index 2957b42cab67..35f26f7c1124 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -261,7 +261,7 @@ _bpftool()
     # Deal with options
     if [[ ${words[cword]} =3D=3D -* ]]; then
         local c=3D'--version --json --pretty --bpffs --mapcompat --debug \
-=09       --use-loader --base-btf --legacy'
+=09       --use-loader --base-btf'
         COMPREPLY=3D( $( compgen -W "$c" -- "$cur" ) )
         return 0
     fi
diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 741e50ee0b6c..87ceafa4b9b8 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -31,7 +31,6 @@ bool block_mount;
 bool verifier_logs;
 bool relaxed_maps;
 bool use_loader;
-bool legacy_libbpf;
 struct btf *base_btf;
 struct hashmap *refs_table;

@@ -160,7 +159,6 @@ static int do_version(int argc, char **argv)
 =09=09jsonw_start_object(json_wtr);=09/* features */
 =09=09jsonw_bool_field(json_wtr, "libbfd", has_libbfd);
 =09=09jsonw_bool_field(json_wtr, "llvm", has_llvm);
-=09=09jsonw_bool_field(json_wtr, "libbpf_strict", !legacy_libbpf);
 =09=09jsonw_bool_field(json_wtr, "skeletons", has_skeletons);
 =09=09jsonw_bool_field(json_wtr, "bootstrap", bootstrap);
 =09=09jsonw_end_object(json_wtr);=09/* features */
@@ -179,7 +177,6 @@ static int do_version(int argc, char **argv)
 =09=09printf("features:");
 =09=09print_feature("libbfd", has_libbfd, &nb_features);
 =09=09print_feature("llvm", has_llvm, &nb_features);
-=09=09print_feature("libbpf_strict", !legacy_libbpf, &nb_features);
 =09=09print_feature("skeletons", has_skeletons, &nb_features);
 =09=09print_feature("bootstrap", bootstrap, &nb_features);
 =09=09printf("\n");
@@ -451,7 +448,6 @@ int main(int argc, char **argv)
 =09=09{ "debug",=09no_argument,=09NULL,=09'd' },
 =09=09{ "use-loader",=09no_argument,=09NULL,=09'L' },
 =09=09{ "base-btf",=09required_argument, NULL, 'B' },
-=09=09{ "legacy",=09no_argument,=09NULL,=09'l' },
 =09=09{ 0 }
 =09};
 =09bool version_requested =3D false;
@@ -524,9 +520,6 @@ int main(int argc, char **argv)
 =09=09case 'L':
 =09=09=09use_loader =3D true;
 =09=09=09break;
-=09=09case 'l':
-=09=09=09legacy_libbpf =3D true;
-=09=09=09break;
 =09=09default:
 =09=09=09p_err("unrecognized option '%s'", argv[optind - 1]);
 =09=09=09if (json_output)
@@ -536,14 +529,6 @@ int main(int argc, char **argv)
 =09=09}
 =09}

-=09if (!legacy_libbpf) {
-=09=09/* Allow legacy map definitions for skeleton generation.
-=09=09 * It will still be rejected if users use LIBBPF_STRICT_ALL
-=09=09 * mode for loading generated skeleton.
-=09=09 */
-=09=09libbpf_set_strict_mode(LIBBPF_STRICT_ALL & ~LIBBPF_STRICT_MAP_DEFINI=
TIONS);
-=09}
-
 =09argc -=3D optind;
 =09argv +=3D optind;
 =09if (argc < 0)
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 467d8472df0c..2d1f4d7211cd 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -57,7 +57,7 @@ static inline void *u64_to_ptr(__u64 ptr)
 #define HELP_SPEC_PROGRAM=09=09=09=09=09=09\
 =09"PROG :=3D { id PROG_ID | pinned FILE | tag PROG_TAG | name PROG_NAME }=
"
 #define HELP_SPEC_OPTIONS=09=09=09=09=09=09\
-=09"OPTIONS :=3D { {-j|--json} [{-p|--pretty}] | {-d|--debug} | {-l|--lega=
cy}"
+=09"OPTIONS :=3D { {-j|--json} [{-p|--pretty}] | {-d|--debug}"
 #define HELP_SPEC_MAP=09=09=09=09=09=09=09\
 =09"MAP :=3D { id MAP_ID | pinned FILE | name MAP_NAME }"
 #define HELP_SPEC_LINK=09=09=09=09=09=09=09\
@@ -82,7 +82,6 @@ extern bool block_mount;
 extern bool verifier_logs;
 extern bool relaxed_maps;
 extern bool use_loader;
-extern bool legacy_libbpf;
 extern struct btf *base_btf;
 extern struct hashmap *refs_table;

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index a858b907da16..b6b62b3ef49b 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1804,11 +1804,6 @@ static int load_with_options(int argc, char **argv, =
bool first_prog_only)
 =09else
 =09=09bpf_object__unpin_programs(obj, pinfile);
 err_close_obj:
-=09if (!legacy_libbpf) {
-=09=09p_info("Warning: bpftool is now running in libbpf strict mode and ha=
s more stringent requirements about BPF programs.\n"
-=09=09       "If it used to work for this object file but now doesn't, see=
 --legacy option for more details.\n");
-=09}
-
 =09bpf_object__close(obj);
 err_free_reuse_maps:
 =09for (i =3D 0; i < old_map_fds; i++)
diff --git a/tools/testing/selftests/bpf/test_bpftool_synctypes.py b/tools/=
testing/selftests/bpf/test_bpftool_synctypes.py
index 9fe4c9336c6f..0cfece7ff4f8 100755
--- a/tools/testing/selftests/bpf/test_bpftool_synctypes.py
+++ b/tools/testing/selftests/bpf/test_bpftool_synctypes.py
@@ -309,11 +309,11 @@ class MainHeaderFileExtractor(SourceFileExtractor):
         commands), which looks to the lists of options in other source fil=
es
         but has different start and end markers:

-            "OPTIONS :=3D { {-j|--json} [{-p|--pretty}] | {-d|--debug} | {=
-l|--legacy}"
+            "OPTIONS :=3D { {-j|--json} [{-p|--pretty}] | {-d|--debug}"

         Return a set containing all options, such as:

-            {'-p', '-d', '--legacy', '--pretty', '--debug', '--json', '-l'=
, '-j'}
+            {'-p', '-d', '--pretty', '--debug', '--json', '-j'}
         """
         start_marker =3D re.compile(f'"OPTIONS :=3D')
         pattern =3D re.compile('([\w-]+) ?(?:\||}[ }\]"])')
@@ -336,7 +336,7 @@ class ManSubstitutionsExtractor(SourceFileExtractor):

         Return a set containing all options, such as:

-            {'-p', '-d', '--legacy', '--pretty', '--debug', '--json', '-l'=
, '-j'}
+            {'-p', '-d', '--pretty', '--debug', '--json', '-j'}
         """
         start_marker =3D re.compile('\|COMMON_OPTIONS\| replace:: {')
         pattern =3D re.compile('\*\*([\w/-]+)\*\*')
--
2.34.1


