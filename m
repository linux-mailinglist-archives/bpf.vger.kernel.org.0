Return-Path: <bpf+bounces-7884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFEF77DDF6
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 11:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1144B1C20F1B
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 09:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D384EFBF6;
	Wed, 16 Aug 2023 09:57:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1398DDA8
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 09:57:03 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC1DD1
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 02:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=Lbl0IPycwFPi6lvRq5ZyzDayaARbfDYnomh+aJEUALo=; b=HahG1PTzxspGbTfXuXaFtMSaCb
	xKFFrqoAcetqJYAJ9+Mjt/xOc0xDO72aa1zHO1by2InaFyUqmj0yLqmSIqedjplnYQhRl+4ywTvEA
	lBYVDQRQGgwyfSDDfKmzGD2nMWZzjPwDvCox85gEOdYcKWl/nWlprV5ALgy1PAfuvMQKyk1wfqMXV
	gdacW9UiAbGAR/6r8Sh4Dduc0fyjVC5a5thys7IU4DJrAhfD/9wFHi77sugP7EXtsLKdVY7UUxlV9
	rg2lXlmLqMN+21kqCvGkbQaY5OrHfxJq6heeLkduuqXIFbCk1zwMiHrf0JM/DfVb3EsABxPa6J/D7
	bHxtGBPQ==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qWDGp-0009a1-Vd; Wed, 16 Aug 2023 11:56:55 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@linux.dev
Cc: bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Yafang Shao <laoar.shao@gmail.com>,
	Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 1/2] bpftool: Implement link show support for tcx
Date: Wed, 16 Aug 2023 11:56:50 +0200
Message-Id: <20230816095651.10014-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27002/Wed Aug 16 09:38:26 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support to dump tcx link information to bpftool. This adds a
common helper show_link_ifindex_{plain,json}() which can be reused
also for other link types. The plain text and json device output is
the same format as in bpftool net dump.

Below shows an example link dump output along with a cgroup link
for comparison:

  # bpftool link
  [...]
  10: cgroup  prog 1977
        cgroup_id 1  attach_type cgroup_inet6_post_bind
  [...]
  13: tcx  prog 2053
        ifindex enp5s0(3)  attach_type tcx_ingress
  14: tcx  prog 2080
        ifindex enp5s0(3)  attach_type tcx_egress
  [...]

Equivalent json output:

  # bpftool link --json
  [...]
  {
    "id": 10,
    "type": "cgroup",
    "prog_id": 1977,
    "cgroup_id": 1,
    "attach_type": "cgroup_inet6_post_bind"
  },
  [...]
  {
    "id": 13,
    "type": "tcx",
    "prog_id": 2053,
    "devname": "enp5s0",
    "ifindex": 3,
    "attach_type": "tcx_ingress"
  },
  {
    "id": 14,
    "type": "tcx",
    "prog_id": 2080,
    "devname": "enp5s0",
    "ifindex": 3,
    "attach_type": "tcx_egress"
  }
  [...]

Suggested-by: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/link.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 65a168df63bc..a3774594f154 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -150,6 +150,18 @@ static void show_link_attach_type_json(__u32 attach_type, json_writer_t *wtr)
 		jsonw_uint_field(wtr, "attach_type", attach_type);
 }
 
+static void show_link_ifindex_json(__u32 ifindex, json_writer_t *wtr)
+{
+	char devname[IF_NAMESIZE] = "(unknown)";
+
+	if (ifindex)
+		if_indextoname(ifindex, devname);
+	else
+		snprintf(devname, sizeof(devname), "(detached)");
+	jsonw_string_field(wtr, "devname", devname);
+	jsonw_uint_field(wtr, "ifindex", ifindex);
+}
+
 static bool is_iter_map_target(const char *target_name)
 {
 	return strcmp(target_name, "bpf_map_elem") == 0 ||
@@ -433,6 +445,10 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
 	case BPF_LINK_TYPE_NETFILTER:
 		netfilter_dump_json(info, json_wtr);
 		break;
+	case BPF_LINK_TYPE_TCX:
+		show_link_ifindex_json(info->tcx.ifindex, json_wtr);
+		show_link_attach_type_json(info->tcx.attach_type, json_wtr);
+		break;
 	case BPF_LINK_TYPE_STRUCT_OPS:
 		jsonw_uint_field(json_wtr, "map_id",
 				 info->struct_ops.map_id);
@@ -509,6 +525,22 @@ static void show_link_attach_type_plain(__u32 attach_type)
 		printf("attach_type %u  ", attach_type);
 }
 
+static void show_link_ifindex_plain(__u32 ifindex)
+{
+	char devname[IF_NAMESIZE * 2] = "(unknown)";
+	char tmpname[IF_NAMESIZE];
+	char *ret = NULL;
+
+	if (ifindex)
+		ret = if_indextoname(ifindex, tmpname);
+	else
+		snprintf(devname, sizeof(devname), "(detached)");
+	if (ret)
+		snprintf(devname, sizeof(devname), "%s(%d)",
+			 tmpname, ifindex);
+	printf("ifindex %s  ", devname);
+}
+
 static void show_iter_plain(struct bpf_link_info *info)
 {
 	const char *target_name = u64_to_ptr(info->iter.target_name);
@@ -745,6 +777,11 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
 	case BPF_LINK_TYPE_NETFILTER:
 		netfilter_dump_plain(info);
 		break;
+	case BPF_LINK_TYPE_TCX:
+		printf("\n\t");
+		show_link_ifindex_plain(info->tcx.ifindex);
+		show_link_attach_type_plain(info->tcx.attach_type);
+		break;
 	case BPF_LINK_TYPE_KPROBE_MULTI:
 		show_kprobe_multi_plain(info);
 		break;
-- 
2.34.1


