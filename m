Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBFE16124B
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2020 13:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbgBQMoL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Feb 2020 07:44:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58402 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728572AbgBQMoL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Feb 2020 07:44:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581943450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1dfKb8VhAUHpNE+8sx5KQrsmTjov/Ukuls4u85EbYek=;
        b=fd/8X3W2WQJnu8JqHTdzkYVRhlxXZ+RVZbuA9iYRpNPIzQ/VIb0Y24qTXpC+IGlM1v9SPi
        UAarXGuxG8og1c9xdAmr9OEgMk6pZ4pH8xa61ra3aovbkvPx47ZCAVwWlD78+OvZJ20bfC
        hWRQgWirkzzGOFMlF55+Fom/oJNJpKA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-W68SItuCNIm98hN4wt2f2g-1; Mon, 17 Feb 2020 07:44:08 -0500
X-MC-Unique: W68SItuCNIm98hN4wt2f2g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98E3F801E66;
        Mon, 17 Feb 2020 12:44:06 +0000 (UTC)
Received: from localhost.localdomain (wsfd-netdev76.ntdv.lab.eng.bos.redhat.com [10.19.188.157])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4EACF5C10D;
        Mon, 17 Feb 2020 12:44:03 +0000 (UTC)
From:   Eelco Chaudron <echaudro@redhat.com>
To:     bpf@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, andriin@fb.com, toke@redhat.com
Subject: [PATCH bpf-next v4 2/3] libbpf: Add support for dynamic program attach target
Date:   Mon, 17 Feb 2020 12:43:34 +0000
Message-Id: <158194341424.104074.4927911845622583345.stgit@xdp-tutorial>
In-Reply-To: <158194337246.104074.6407151818088717541.stgit@xdp-tutorial>
References: <158194337246.104074.6407151818088717541.stgit@xdp-tutorial>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently when you want to attach a trace program to a bpf program
the section name needs to match the tracepoint/function semantics.

However the addition of the bpf_program__set_attach_target() API
allows you to specify the tracepoint/function dynamically.

The call flow would look something like this:

  xdp_fd =3D bpf_prog_get_fd_by_id(id);
  trace_obj =3D bpf_object__open_file("func.o", NULL);
  prog =3D bpf_object__find_program_by_title(trace_obj,
                                           "fentry/myfunc");
  bpf_program__set_expected_attach_type(prog, BPF_TRACE_FENTRY);
  bpf_program__set_attach_target(prog, xdp_fd,
                                 "xdpfilt_blk_all");
  bpf_object__load(trace_obj)

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
Signed-off-by: Eelco Chaudron <echaudro@redhat.com>
---
 tools/lib/bpf/libbpf.c   |   34 ++++++++++++++++++++++++++++++----
 tools/lib/bpf/libbpf.h   |    4 ++++
 tools/lib/bpf/libbpf.map |    2 ++
 3 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 514b1a524abb..0c25d78fb5d8 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4939,8 +4939,8 @@ int bpf_program__load(struct bpf_program *prog, cha=
r *license, __u32 kern_ver)
 {
 	int err =3D 0, fd, i, btf_id;
=20
-	if (prog->type =3D=3D BPF_PROG_TYPE_TRACING ||
-	    prog->type =3D=3D BPF_PROG_TYPE_EXT) {
+	if ((prog->type =3D=3D BPF_PROG_TYPE_TRACING ||
+	     prog->type =3D=3D BPF_PROG_TYPE_EXT) && !prog->attach_btf_id) {
 		btf_id =3D libbpf_find_attach_btf_id(prog);
 		if (btf_id <=3D 0)
 			return btf_id;
@@ -6583,6 +6583,9 @@ static inline int __find_vmlinux_btf_id(struct btf =
*btf, const char *name,
 	else
 		err =3D btf__find_by_name_kind(btf, name, BTF_KIND_FUNC);
=20
+	if (err <=3D 0)
+		pr_warn("%s is not found in vmlinux BTF\n", name);
+
 	return err;
 }
=20
@@ -6655,8 +6658,6 @@ static int libbpf_find_attach_btf_id(struct bpf_pro=
gram *prog)
 			err =3D __find_vmlinux_btf_id(prog->obj->btf_vmlinux,
 						    name + section_defs[i].len,
 						    attach_type);
-		if (err <=3D 0)
-			pr_warn("%s is not found in vmlinux BTF\n", name);
 		return err;
 	}
 	pr_warn("failed to identify btf_id based on ELF section name '%s'\n", n=
ame);
@@ -8132,6 +8133,31 @@ void bpf_program__bpil_offs_to_addr(struct bpf_pro=
g_info_linear *info_linear)
 	}
 }
=20
+int bpf_program__set_attach_target(struct bpf_program *prog,
+				   int attach_prog_fd,
+				   const char *attach_func_name)
+{
+	int btf_id;
+
+	if (!prog || attach_prog_fd < 0 || !attach_func_name)
+		return -EINVAL;
+
+	if (attach_prog_fd)
+		btf_id =3D libbpf_find_prog_btf_id(attach_func_name,
+						 attach_prog_fd);
+	else
+		btf_id =3D __find_vmlinux_btf_id(prog->obj->btf_vmlinux,
+					       attach_func_name,
+					       prog->expected_attach_type);
+
+	if (btf_id <=3D 0)
+		return btf_id;
+
+	prog->attach_btf_id =3D btf_id;
+	prog->attach_prog_fd =3D attach_prog_fd;
+	return 0;
+}
+
 int parse_cpu_mask_str(const char *s, bool **mask, int *mask_sz)
 {
 	int err =3D 0, n, len, start, end =3D -1;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 3fe12c9d1f92..02fc58a21a7f 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -334,6 +334,10 @@ LIBBPF_API void
 bpf_program__set_expected_attach_type(struct bpf_program *prog,
 				      enum bpf_attach_type type);
=20
+LIBBPF_API int
+bpf_program__set_attach_target(struct bpf_program *prog, int attach_prog=
_fd,
+			       const char *attach_func_name);
+
 LIBBPF_API bool bpf_program__is_socket_filter(const struct bpf_program *=
prog);
 LIBBPF_API bool bpf_program__is_tracepoint(const struct bpf_program *pro=
g);
 LIBBPF_API bool bpf_program__is_raw_tracepoint(const struct bpf_program =
*prog);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 45be19c9d752..7b014c8cdece 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -237,4 +237,6 @@ LIBBPF_0.0.7 {
 } LIBBPF_0.0.6;
=20
 LIBBPF_0.0.8 {
+	global:
+		bpf_program__set_attach_target;
 } LIBBPF_0.0.7;

