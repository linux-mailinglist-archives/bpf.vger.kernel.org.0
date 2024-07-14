Return-Path: <bpf+bounces-34775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5C6930A5F
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 16:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADDFC281B14
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 14:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABC41386C0;
	Sun, 14 Jul 2024 14:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="XxojI10V"
X-Original-To: bpf@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BB853376;
	Sun, 14 Jul 2024 14:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720967463; cv=none; b=Ybdj37JR8hKJ2HZXokIRgN6NPgll/sSr1ixN9tfpCIYnbm7yYjH1o/qaUVWwxyrTBViyfd1GA6F1VzGAb77A818qpPh84V14ETb+J1sBO+eEXaDNkvgbObQ0oQCuwkuunfu7IlLfb6gzhHWyGKZXYDKD+fu+qg+FmlMlK0pfpWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720967463; c=relaxed/simple;
	bh=wNzD30ls/A/KtZUscmloYPFWVgig1jjAdupOCWs3Nbc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=acVx/uN5FG4PDcBNPWa84iCs8b8jSLREMXhnG/pq/h7q26YKJv7p4c2DgfsohcQqhMm32/DfarSkfpBlYMvqaSNbJL+ZW4wGHt9yTQr6TTc49nDzhUnGj+kfY4s+vlo3Lq9G/GQom5gi3gHISK+aQ6CMGclQ820xiOgEHTIiNqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=XxojI10V; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720967439; x=1721572239; i=markus.elfring@web.de;
	bh=PrIIZ1hwepiHEYKDwlhsZNrIPHHnFlPFVd/ybT0GPKo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XxojI10VRIqB3RVUgDE4WYc+Ebm1ZuTZH4j2VK+8AKT5BViIBWuf096tekG0bzOI
	 Tft8gzWTIeRMLAFbHyUd3KEvOHfD7x2TcMF4eRb7GRg7uQuX5mJ41+ob6lWCA90yw
	 4mKPCanyw/LvPAim29L+JOouaApLYb2g699DXHRZ87sVOFv4QRuqUhxNPGzj+EyAm
	 DG4wzXFZJSC1WbL630rXtznIJ2WnzjRPDJwXjz8UWcBWxmV/95GU6P74OF7v0F+7Y
	 11Cl6PPfJUUMYHB/5tuUQrY/dR/9tledthAeawstHO66LCxwYsNX8vX+a4i8NFjeQ
	 in5qpWaRNcyddhTN0A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mmyqx-1s2iJk20FL-00iS2Y; Sun, 14
 Jul 2024 16:30:39 +0200
Message-ID: <e26b7df9-cd63-491f-85e8-8cabe60a85e5@web.de>
Date: Sun, 14 Jul 2024 16:30:38 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: bpf@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Yonghong Song <yonghong.song@linux.dev>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] bpf: Replace 8 seq_puts() calls by seq_putc() calls
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:buu0lALXmiiOY3ZcKb25GuuMJxErY+GsJDQe8zxy93ls7D8cuCn
 r7/Cj4/Td7GMV9woXUrqkXi5IS08jXRFRbWOabW9Gx3//Js0G9R0oKyfH3PehE3RvXWXdV6
 iyzCUpGzTLuap39pz3Zak+fVvqmrQv8KX7mQE9a0bZyAjR5rekad92k9FxpfiCc1M0m9tpF
 bfUeOFeT+MTDkMsQH5qQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:L+LWeD9bRzM=;aRE0jenjMrDiM+ISG8q/eoJvj4J
 I+oAT0qPH2FgqyoTIST+/dZWSUyCD9XVdfoS8gotLGMyBJMSp3d7lFwjCgv0wtjfGgxj5jGtz
 QXU0Kxdy8Uct3Cj4h502TgFDnn5rWaGa4UWlF5Bc5ck2aiO6SdTni8EWFdn7v+v2RpKf/fD4h
 VOmSOpvxMJ5ywGuUhyObA871YCaWdOoqwW2yk431GV1wu+vWHxWn10nh3rlgyVYhgJ7ChPnzq
 M7n00TKh9KaWNnURb21XV8XhQg7YJUyKHLgirgR5QNfeRVvmEXEMqnFo+1zkcMBMrFkSpaHz/
 rHrz4mBh2CATJSjYQuK7pSMGs6bNmS68mBSQb2XAjkFLdDPmwnXjvkobqQcgk//hz6+lknOJF
 EejTj9EuUzEv1eqiAbQyZzrz37wXKj8i3oSWSEzREHx8H/fKXnNJvt2l6fbN2p5BOPoNs3sSf
 37DjH0X3tpB1ugVlc99pnA9mV19KZrrIZWYtUAD/IRjm0YgJ8n0GhNNZ9wixdS6jCd2ovcU0e
 DAGNJ65bQHhSSNgWq+7vWaBJln+HroPMOQyKvieTDe3xU9SnVeOTwMyDMUMi3x9lV5VI2dPQZ
 D1pCa8WM3cdgmUwv7cqZwVDB8Djdlx8eXa4O5I2RLU/I+MtM6vOPM3B5UlANaTHHZrjMZtsQV
 FRzd5nrUnbDE6KjL9mkkFRxFfZg5PVjdxD3s15sofH+vYtZVvxTJ4MpkExKkNdfszzEC15bt3
 6S2NPK5PRJMYoeufxa5WRDHeJOmQhd8RPxT2VVlyYcifx6oHdeDXXmqHmVTJNHCQ9Q2gHnDRk
 3n9RpIYQwULuAEnNAPzx23Bg==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 14 Jul 2024 16:15:34 +0200

Single line breaks should occasionally be put into a sequence.
Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 kernel/bpf/arraymap.c       | 6 +++---
 kernel/bpf/bpf_struct_ops.c | 2 +-
 kernel/bpf/hashtab.c        | 4 ++--
 kernel/bpf/local_storage.c  | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index feabc0193852..188e3c2effb2 100644
=2D-- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -494,7 +494,7 @@ static void array_map_seq_show_elem(struct bpf_map *ma=
p, void *key,
 	if (map->btf_key_type_id)
 		seq_printf(m, "%u: ", *(u32 *)key);
 	btf_type_seq_show(map->btf, map->btf_value_type_id, value, m);
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');

 	rcu_read_unlock();
 }
@@ -515,7 +515,7 @@ static void percpu_array_map_seq_show_elem(struct bpf_=
map *map, void *key,
 		seq_printf(m, "\tcpu%d: ", cpu);
 		btf_type_seq_show(map->btf, map->btf_value_type_id,
 				  per_cpu_ptr(pptr, cpu), m);
-		seq_puts(m, "\n");
+		seq_putc(m, '\n');
 	}
 	seq_puts(m, "}\n");

@@ -993,7 +993,7 @@ static void prog_array_map_seq_show_elem(struct bpf_ma=
p *map, void *key,
 			prog_id =3D prog_fd_array_sys_lookup_elem(ptr);
 			btf_type_seq_show(map->btf, map->btf_value_type_id,
 					  &prog_id, m);
-			seq_puts(m, "\n");
+			seq_putc(m, '\n');
 		}
 	}

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 0d515ec57aa5..bb3eabc0dc76 100644
=2D-- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -837,7 +837,7 @@ static void bpf_struct_ops_map_seq_show_elem(struct bp=
f_map *map, void *key,
 		btf_type_seq_show(st_map->btf,
 				  map->btf_vmlinux_value_type_id,
 				  value, m);
-		seq_puts(m, "\n");
+		seq_putc(m, '\n');
 	}

 	kfree(value);
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 06115f8728e8..be1f64c20125 100644
=2D-- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1586,7 +1586,7 @@ static void htab_map_seq_show_elem(struct bpf_map *m=
ap, void *key,
 	btf_type_seq_show(map->btf, map->btf_key_type_id, key, m);
 	seq_puts(m, ": ");
 	btf_type_seq_show(map->btf, map->btf_value_type_id, value, m);
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');

 	rcu_read_unlock();
 }
@@ -2450,7 +2450,7 @@ static void htab_percpu_map_seq_show_elem(struct bpf=
_map *map, void *key,
 		seq_printf(m, "\tcpu%d: ", cpu);
 		btf_type_seq_show(map->btf, map->btf_value_type_id,
 				  per_cpu_ptr(pptr, cpu), m);
-		seq_puts(m, "\n");
+		seq_putc(m, '\n');
 	}
 	seq_puts(m, "}\n");

diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index a04f505aefe9..3969eb0382af 100644
=2D-- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -431,7 +431,7 @@ static void cgroup_storage_seq_show_elem(struct bpf_ma=
p *map, void *key,
 		seq_puts(m, ": ");
 		btf_type_seq_show(map->btf, map->btf_value_type_id,
 				  &READ_ONCE(storage->buf)->data[0], m);
-		seq_puts(m, "\n");
+		seq_putc(m, '\n');
 	} else {
 		seq_puts(m, ": {\n");
 		for_each_possible_cpu(cpu) {
@@ -439,7 +439,7 @@ static void cgroup_storage_seq_show_elem(struct bpf_ma=
p *map, void *key,
 			btf_type_seq_show(map->btf, map->btf_value_type_id,
 					  per_cpu_ptr(storage->percpu_buf, cpu),
 					  m);
-			seq_puts(m, "\n");
+			seq_putc(m, '\n');
 		}
 		seq_puts(m, "}\n");
 	}
=2D-
2.45.2


