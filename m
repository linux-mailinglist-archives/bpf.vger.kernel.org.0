Return-Path: <bpf+bounces-1416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD23071543D
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 05:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E53528104F
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 03:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0F81C29;
	Tue, 30 May 2023 03:45:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCB310FF
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 03:45:33 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12623B7
	for <bpf@vger.kernel.org>; Mon, 29 May 2023 20:45:32 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34U24R6O010123;
	Mon, 29 May 2023 20:45:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=Ivp7SFn2qzMQF9zTheeqeldda7EW8hvLunX7qAt+Awo=;
 b=e/gxrqoTb0t0ch4lsBTSPA3CCwzCoOWiIzMoVkz4H8YBowwKy6WKaeyRhPfmI24jjSVy
 wQBw8UlEzwg020N5oyEnLs/FSPD6t1WQp6anieKh6qQnZrWGVzHKlF0bqUfiiUUmYZRh
 uDdrzTiLnDDioVEJs77TLNa25NyPUWEvILv55tbDwesujm7zHwZushbENY9ReBO7kzC5
 AWyCZGLQ8M15tUG4r8OZX59yjIHZ8IKIjf1TxIximsj23zoxOVrufRnlxaQSrlP5KjNC
 ftUtbKMPTleld9Gr9qrgXQ8XGSYcofYz2yfN4fvR7gxk7JIv/YlFe/rlPYKlnVlvftj+ kA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3quhcm6vm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Mon, 29 May 2023 20:45:12 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 29 May
 2023 20:45:10 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 29 May 2023 20:45:10 -0700
Received: from localhost.localdomain (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id ACAAF3F7084;
	Mon, 29 May 2023 20:45:07 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <liu.yun@linux.dev>, <olsajiri@gmail.com>, <andrii@kernel.org>
CC: <bpf@vger.kernel.org>, <liuyun01@kylinos.cn>, <martin.lau@linux.dev>,
        <song@kernel.org>, <yhs@fb.com>
Subject: [PATCH v7] libbpf: kprobe.multi: Filter with available_filter_functions
Date: Tue, 30 May 2023 09:14:41 +0530
Message-ID: <20230530010801.1558937-1-liu.yun@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230530010801.1558937-1-liu.yun@linux.dev>
References: <20230530010801.1558937-1-liu.yun@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 92nH-etbTu8tJvPtTpPmP1sUt4rL5gyc
X-Proofpoint-ORIG-GUID: 92nH-etbTu8tJvPtTpPmP1sUt4rL5gyc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_01,2023-05-29_02,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jackie Liu <liu.yun@linux.dev>

>+
>+	if (!glob_match(sym_name, res->pattern))
>+		return 0;
>+
>+	err = libbpf_ensure_mem((void **) &res->syms, &res->cap,
>+				sizeof(const char *), res->cnt + 1);
>+	if (err)
>+		return err;
>+
>+	name = strdup(sym_name);
>+	if (!name)
>+		return -errno;
>+
>+	res->syms[res->cnt++] = name;
>+	return 0;
>+}
>+
>+typedef int (*available_kprobe_cb_t)(const char *sym_name, void *ctx);
>+
>+static int
>+libbpf_available_kprobes_parse(available_kprobe_cb_t cb, void *ctx)
>+{
>+	char sym_name[256];
>+	FILE *f;
>+	int ret, err = 0;
>+	const char *available_path = tracefs_available_filter_functions();
Dont we need to follow reverse x-mas tree ?

>+
>+	f = fopen(available_path, "r");
>+	if (!f) {
>+		err = -errno;
>+		pr_warn("failed to open %s, fallback to /proc/kallsyms.\n",
>+			available_path);
>+		return err;
>+	}
>+
>+	while (true) {
>+		ret = fscanf(f, "%255s%*[^\n]\n", sym_name);
>+		if (ret == EOF && feof(f))
>+			break;
why fscanf() is not setting EOF. Why did you use feof() ?

>+		if (ret != 1) {
>+			pr_warn("failed to read available kprobe entry: %d\n",
>+				ret);
>+			err = -EINVAL;
>+			break;
>+		}
>+
>+		err = cb(sym_name, ctx);
>+		if (err)
>+			break;
>+	}
>+
>+	fclose(f);
>+	return err;
>+}
>+
>+static void kprobe_multi_resolve_free(struct kprobe_multi_resolve *res)
>+{
>+	while (res->syms && res->cnt)
>+		free((char *)res->syms[--res->cnt]);
>+
>+	free(res->syms);
>+	free(res->addrs);

it looks odd to do allocation in libbpf_xxx (libbpf_ensure_mem ) function and
freeing in a static function.

>+
>+	/* reset to zero, when fallback */
>+	res->cap = 0;
>+	res->cnt = 0;
>+	res->syms = NULL;
>+	res->addrs = NULL;
>+}
>+
> struct bpf_link *
> bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
> 				      const char *pattern,
>@@ -10476,13 +10558,21 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
> 		return libbpf_err_ptr(-EINVAL);
>
> 	if (pattern) {
>-		err = libbpf_kallsyms_parse(resolve_kprobe_multi_cb, &res);
>-		if (err)
>-			goto error;
>+		err = libbpf_available_kprobes_parse(ftrace_resolve_kprobe_multi_cb,
>+						     &res);
>+		if (err) {
>+			/* fallback to kallsyms */
>+			kprobe_multi_resolve_free(&res);
>+			err = libbpf_kallsyms_parse(kallsyms_resolve_kprobe_multi_cb,
>+						    &res);
>+			if (err)
>+				goto error;
>+		}
> 		if (!res.cnt) {
> 			err = -ENOENT;
> 			goto error;
> 		}
>+		syms = res.syms;
> 		addrs = res.addrs;
> 		cnt = res.cnt;
> 	}
>@@ -10511,12 +10601,12 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
> 		goto error;
> 	}
> 	link->fd = link_fd;
>-	free(res.addrs);
>+	kprobe_multi_resolve_free(&res);
> 	return link;
>
> error:
> 	free(link);
>-	free(res.addrs);
>+	kprobe_multi_resolve_free(&res);
> 	return libbpf_err_ptr(err);
> }
>
>--
>2.25.1

