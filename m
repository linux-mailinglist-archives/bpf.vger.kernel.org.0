Return-Path: <bpf+bounces-1660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A6C71FCBA
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 10:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508132816F1
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 08:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63503154A8;
	Fri,  2 Jun 2023 08:52:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA7014266
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 08:52:52 +0000 (UTC)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA9E170C
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 01:52:50 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-568af2f6454so18413737b3.1
        for <bpf@vger.kernel.org>; Fri, 02 Jun 2023 01:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685695969; x=1688287969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xoDDmMH61IBCnDqgz7C9NGBec5DAwaQUjkpv1nwzXHc=;
        b=Ou/cIdETxr1MRABUdYjGgSp9mkYeXnuvMfKBXqQcJRxtZsxV8gEUipxOtJ5z7Lhpqt
         mLaD5AXzNbGRQfg4TbPspYPFAUNRrCJaFxq7lR/CMPl8lS2znYRtNaEuQkV3SlAX+m7e
         kcNupg+BetpYCDw9v3RyR51d358WU1cULxOmtO54o0iRDjUzjW67Fc9CXzj56TkGnPh4
         fCOVKzh1JXh+ZAuNylAhr4ILjUZEQd0CrZhUscAK0USuFgNfv75DrCDxCsrA1HjkX/ps
         isqYclpViIn5fKWNsvKN65/Qo1newzIbvdGp3dP0vYAiQTapmDsOD6zwbM85bLhMY/YH
         AfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685695969; x=1688287969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xoDDmMH61IBCnDqgz7C9NGBec5DAwaQUjkpv1nwzXHc=;
        b=JY+dJ2JXp2XHQda7m9GKUTjIzzmmzx4kZRqlUXy8XcL5vKlpLJ1hqdIzoEzASZ1GTM
         DTAHU8Ar6Zr1KK1/qI9ZBvgZ3UQc2ocQ6lxGCTLjXUHedssf2ZqlabLT7Q2ne7NHc5H3
         8DpJgkbCM+bMUwCVD5MsFFrcjVgx4K63wTCYGejLPz1xtnQP54XKF/0LP3iZ8vu3cR4I
         8KTpnjevTQawII++iW6EjNCiax60y3g83M2bDeTYn4oDj2hDjrcZ/zn0QeHM71RjaGS7
         9S2+FagMEbbK4b8Yvx0pVecrJkVMtLTXDf/HCXlUun+PzTv51lWX6zX6+B2zUmAyEvgF
         BpEw==
X-Gm-Message-State: AC+VfDz7N5CkIFAzMd+K9UZBXcsWSIaXMUhKMLcrEQaDnEkh+zYoJ2Cd
	Hg42fPrAzPSCFN19uWYmBrc=
X-Google-Smtp-Source: ACHHUZ4sa9Ir5h8cVvqYyJBKPObI3uGhobpREMU/y8DJDT/jdUTihGtiZcag1XALJ2/WSY5rsLCS4Q==
X-Received: by 2002:a0d:d1c7:0:b0:55a:574f:327c with SMTP id t190-20020a0dd1c7000000b0055a574f327cmr11363480ywd.13.1685695969627;
        Fri, 02 Jun 2023 01:52:49 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:5401:1e90:5400:4ff:fe75:fb5d])
        by smtp.gmail.com with ESMTPSA id b123-20020a0dd981000000b00565c29cf592sm289828ywe.10.2023.06.02.01.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 01:52:49 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	quentin@isovalent.com
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 2/6] bpftool: Show probed function in kprobe_multi link info
Date: Fri,  2 Jun 2023 08:52:35 +0000
Message-Id: <20230602085239.91138-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230602085239.91138-1-laoar.shao@gmail.com>
References: <20230602085239.91138-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Show the already expose kprobe_multi link info in bpftool. The result as
follows,
$ tools/bpf/bpftool/bpftool link show
1: kprobe_multi  prog 5
        func_cnt 4  addrs            symbols
                    ffffffffb4d465b0 schedule_timeout_interruptible
                    ffffffffb4d465f0 schedule_timeout_killable
                    ffffffffb4d46630 schedule_timeout_uninterruptible
                    ffffffffb4d46670 schedule_timeout_idle
        pids trace(8729)

$ tools/bpf/bpftool/bpftool link show -j
[{"id":1,"type":"kprobe_multi","prog_id":5,"func_cnt":4,"addrs":[{"addr":18446744072448402864,"symbol":"schedule_timeout_interruptible"},{"addr":18446744072448402928,"symbol":"schedule_timeout_killable"},{"addr":18446744072448402992,"symbol":"schedule_timeout_uninterruptible"},{"addr":18446744072448403056,"symbol":"schedule_timeout_idle"}],"pids":[{"pid":8729,"comm":"trace"}]}]

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/bpf/bpftool/link.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 2d78607..3b00c07 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -166,6 +166,57 @@ static int get_prog_info(int prog_id, struct bpf_prog_info *info)
 	return err;
 }
 
+static int cmp_u64(const void *A, const void *B)
+{
+	const __u64 *a = A, *b = B;
+
+	return *a - *b;
+}
+
+static void kprobe_multi_print_plain(__u64 addr, char *sym, __u32 indent)
+{
+	printf("\n\t%*s  %0*llx %s", indent, "", 16, addr, sym);
+}
+
+static void kprobe_multi_print_json(__u64 addr, char *sym)
+{
+	jsonw_start_object(json_wtr);
+	jsonw_uint_field(json_wtr, "addr", addr);
+	jsonw_string_field(json_wtr, "symbol", sym);
+	jsonw_end_object(json_wtr);
+}
+
+static void kernel_syms_show(const __u64 *addrs, __u32 cnt, __u32 indent)
+{
+	char buff[256], sym[256];
+	__u64 addr;
+	int i = 0;
+	FILE *fp;
+
+	fp = fopen("/proc/kallsyms", "r");
+	if (!fp)
+		return;
+
+	/* Each address is guaranteed to be unique. */
+	qsort((void *)addrs, cnt, sizeof(__u64), cmp_u64);
+	/* The addresses in /proc/kallsyms are already sorted. */
+	while (fgets(buff, sizeof(buff), fp)) {
+		if (sscanf(buff, "%llx %*c %s", &addr, sym) != 2)
+			continue;
+		/* The addr probed by kprobe_multi is always in
+		 * /proc/kallsyms, so we can ignore some edge cases.
+		 */
+		if (addr != addrs[i])
+			continue;
+		if (indent)
+			kprobe_multi_print_plain(addr, sym, indent);
+		else
+			kprobe_multi_print_json(addr, sym);
+		i++;
+	}
+	fclose(fp);
+}
+
 static int show_link_close_json(int fd, struct bpf_link_info *info)
 {
 	struct bpf_prog_info prog_info;
@@ -218,6 +269,17 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
 		jsonw_uint_field(json_wtr, "map_id",
 				 info->struct_ops.map_id);
 		break;
+	case BPF_LINK_TYPE_KPROBE_MULTI:
+		const __u64 *addrs;
+
+		jsonw_uint_field(json_wtr, "func_cnt", info->kprobe_multi.count);
+		jsonw_name(json_wtr, "addrs");
+		jsonw_start_array(json_wtr);
+		addrs = (const __u64 *)u64_to_ptr(info->kprobe_multi.addrs);
+		if (info->kprobe_multi.count)
+			kernel_syms_show(addrs, info->kprobe_multi.count, 0);
+		jsonw_end_array(json_wtr);
+		break;
 	default:
 		break;
 	}
@@ -396,6 +458,20 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
 	case BPF_LINK_TYPE_NETFILTER:
 		netfilter_dump_plain(info);
 		break;
+	case BPF_LINK_TYPE_KPROBE_MULTI:
+		__u32 indent, cnt, i;
+		const __u64 *addrs;
+
+		cnt = info->kprobe_multi.count;
+		if (!cnt)
+			break;
+		printf("\n\tfunc_cnt %d  %-16s %s", cnt, "addrs", "symbols");
+		for (i = 0; cnt; i++)
+			cnt /= 10;
+		indent = strlen("func_cnt ") + i;
+		addrs = (const __u64 *)u64_to_ptr(info->kprobe_multi.addrs);
+		kernel_syms_show(addrs, cnt, indent);
+		break;
 	default:
 		break;
 	}
@@ -417,7 +493,9 @@ static int do_show_link(int fd)
 {
 	struct bpf_link_info info;
 	__u32 len = sizeof(info);
+	__u64 *addrs = NULL;
 	char buf[256];
+	int count;
 	int err;
 
 	memset(&info, 0, sizeof(info));
@@ -441,12 +519,28 @@ static int do_show_link(int fd)
 		info.iter.target_name_len = sizeof(buf);
 		goto again;
 	}
+	if (info.type == BPF_LINK_TYPE_KPROBE_MULTI &&
+	    !info.kprobe_multi.addrs) {
+		count = info.kprobe_multi.count;
+		if (count) {
+			addrs = calloc(count, sizeof(__u64));
+			if (!addrs) {
+				p_err("mem alloc failed");
+				close(fd);
+				return -1;
+			}
+			info.kprobe_multi.addrs = (unsigned long)addrs;
+			goto again;
+		}
+	}
 
 	if (json_output)
 		show_link_close_json(fd, &info);
 	else
 		show_link_close_plain(fd, &info);
 
+	if (addrs)
+		free(addrs);
 	close(fd);
 	return 0;
 }
-- 
1.8.3.1


