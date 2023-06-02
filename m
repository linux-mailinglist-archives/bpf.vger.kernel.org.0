Return-Path: <bpf+bounces-1664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D40571FCBF
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 10:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D70481C20B39
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 08:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03B817720;
	Fri,  2 Jun 2023 08:52:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0B246AA
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 08:52:56 +0000 (UTC)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B331713
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 01:52:53 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-565a3cdba71so20018137b3.0
        for <bpf@vger.kernel.org>; Fri, 02 Jun 2023 01:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685695973; x=1688287973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2vC5VC4yFEIJf6awDHKSY7ygYDdMqF7ISKjmMUJqgZ8=;
        b=p6ALRpcCoWAYSCUO0S9HG3Dx73tNS7HGqhVFtcdDozhYP6EeuGlp9Szt94Vk6l2LEl
         OCsYJD/Y6/Ro+lNSZOrQT6M7tOhp2MU3jr5QSCBhm0OiQlFOALzJpio9ctWWJw7HWVBE
         um1zsbxRFylGSl9WapiC2tOqv/EiavE3u2ok+QRQ69d6zNjldAawQvL0B6fwb8dO41t7
         bn1jqrqQvVPgonGU7rUYjKl1MK3fSp8DCKDEAk8pYdXu+RO8pr65ns+O4HchJVvFqKgK
         zVazgNWxBhRqBPH1TpRaS3o9xboRg5bHdy+wr6p89OryaD/0mhDL0M9ATYV5Xjs9Uhyl
         3gXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685695973; x=1688287973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2vC5VC4yFEIJf6awDHKSY7ygYDdMqF7ISKjmMUJqgZ8=;
        b=Ybj4eYtNSCvBxwkcPaImVaDt/4C0BGlAFYSmsxlkI/tiwGW9BtMy9cARnc9TVUKR/M
         H7JvSPyZevL0WbvBS8fOTJRXKTv37mLDjDoJ4RTo2q5lN3ROLh/I5nQMZTm7yxSfORZa
         QGpZrsrQnrSFOq3z5sq2xTgDjaHJ2PxMUV1AM010HUFSuwZSzXoG13UmtHqMpaBixDuI
         Vk+qfdjvJwqZ18K6CggR7UrVOdKGfA7PXt6u1UdndzBdLc4+j3fwW/9J8I6dSRwIm6/z
         y/0joA3/kjWcaFxvmoz8j29SBbkWNSJkcb7w7UmQT8aAa22upK8vNTtKP/xFS6MUUor9
         laoQ==
X-Gm-Message-State: AC+VfDyYAQb8y+4cNB+mdyHYUqCiTWG/Jfstv1vuakiJbIOLSZ+ABGB+
	hdJEsvK5VZ2EvVKhnUNHAkU=
X-Google-Smtp-Source: ACHHUZ7SHKrekYblIQYpIcUizpGJ0YWOZqEGgflxdJKOHrZaNQSb5xeFys5KdDw3DcnNYbnh/BSAVA==
X-Received: by 2002:a81:778b:0:b0:568:bc0b:bf92 with SMTP id s133-20020a81778b000000b00568bc0bbf92mr13348346ywc.34.1685695972769;
        Fri, 02 Jun 2023 01:52:52 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:5401:1e90:5400:4ff:fe75:fb5d])
        by smtp.gmail.com with ESMTPSA id b123-20020a0dd981000000b00565c29cf592sm289828ywe.10.2023.06.02.01.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 01:52:52 -0700 (PDT)
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
Subject: [PATCH bpf-next 6/6] bpftool: Show probed function in perf_event link info
Date: Fri,  2 Jun 2023 08:52:39 +0000
Message-Id: <20230602085239.91138-7-laoar.shao@gmail.com>
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

Show the exposed perf_event link info in bpftool. The result as follows,

$ bpftool link show
1: perf_event  prog 5
        func kernel_clone  addr ffffffffb40bc310  offset 0
        bpf_cookie 0
        pids trace(9726)
$ bpftool link show -j
[{"id":1,"type":"perf_event","prog_id":5,"func":"kernel_clone","addr":18446744072435254032,"offset":0,"bpf_cookie":0,"pids":[{"pid":9726,"comm":"trace"}]}]

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/bpf/bpftool/link.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 3b00c07..045f59f 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -280,6 +280,12 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
 			kernel_syms_show(addrs, info->kprobe_multi.count, 0);
 		jsonw_end_array(json_wtr);
 		break;
+	case BPF_LINK_TYPE_PERF_EVENT:
+		jsonw_string_field(json_wtr, "func",
+				   u64_to_ptr(info->perf_event.name));
+		jsonw_uint_field(json_wtr, "addr", info->perf_event.addr);
+		jsonw_uint_field(json_wtr, "offset", info->perf_event.offset);
+		break;
 	default:
 		break;
 	}
@@ -416,7 +422,7 @@ void netfilter_dump_plain(const struct bpf_link_info *info)
 static int show_link_close_plain(int fd, struct bpf_link_info *info)
 {
 	struct bpf_prog_info prog_info;
-	const char *prog_type_str;
+	const char *prog_type_str, *buf;
 	int err;
 
 	show_link_header_plain(info);
@@ -472,6 +478,12 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
 		addrs = (const __u64 *)u64_to_ptr(info->kprobe_multi.addrs);
 		kernel_syms_show(addrs, cnt, indent);
 		break;
+	case BPF_LINK_TYPE_PERF_EVENT:
+		buf = (const char *)u64_to_ptr(info->perf_event.name);
+		if (buf[0] != '\0' || info->perf_event.addr)
+			printf("\n\tfunc %s  addr %llx  offset %d  ", buf,
+			       info->perf_event.addr, info->perf_event.offset);
+		break;
 	default:
 		break;
 	}
@@ -498,6 +510,7 @@ static int do_show_link(int fd)
 	int count;
 	int err;
 
+	buf[0] = '\0';
 	memset(&info, 0, sizeof(info));
 again:
 	err = bpf_link_get_info_by_fd(fd, &info, &len);
@@ -533,6 +546,12 @@ static int do_show_link(int fd)
 			goto again;
 		}
 	}
+	if (info.type == BPF_LINK_TYPE_PERF_EVENT &&
+	    !info.perf_event.name) {
+		info.perf_event.name = (unsigned long)&buf;
+		info.perf_event.name_len = sizeof(buf);
+		goto again;
+	}
 
 	if (json_output)
 		show_link_close_json(fd, &info);
-- 
1.8.3.1


