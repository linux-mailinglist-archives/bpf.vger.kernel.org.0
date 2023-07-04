Return-Path: <bpf+bounces-3983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2AD7473FB
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 16:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9AFF280EDE
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 14:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA18163B2;
	Tue,  4 Jul 2023 14:20:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9619C53B1
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 14:20:28 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2C8E4F
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 07:20:25 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51d805cb33aso7139633a12.3
        for <bpf@vger.kernel.org>; Tue, 04 Jul 2023 07:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688480424; x=1691072424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tGuYNSdIgUBRjL0V9Twj3LxUN39YcpENz5rnG9Fpc2s=;
        b=ZF6TrxiG8XfQo4T7iiuIr9NbvmdkR3hiAd+Bhgi9zB6DooTRXyae3GKre211wfntP+
         nkx4Ks9IXkAh2TCfgMIdEV9MEJ+3yrD6scX75oWtD0Ng/b4vUR0fQ8SvWTHgVUG5SKJj
         1CCjMKngPfQA4XVyjwDW/u58fJUtOKMqjiYfSnz/JMjHM013Th6ALk78FXe4HHlxtruS
         bYqD94Q9ksSUuuDuAFqFjaAENSde38neZ3cTaokuigZ3YPOeWsltgnvwV9rdLdHZ9K4G
         7P2WTEsy2yEFlXEsTGBI5taT/yWn7VHYjgde476FTxLpfwn53/MYjoto5B/8y2dvHLzK
         7MRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688480424; x=1691072424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGuYNSdIgUBRjL0V9Twj3LxUN39YcpENz5rnG9Fpc2s=;
        b=TDDPhYQdRE+O8ISfabN8mL4qi2EqnCL5ZTDDAp5psx29jmeAajWf54w+0ipjW5vt8r
         bDuERLB70GCnpQgsAD0X1lc7Iv07FCJgp3GMkKlzYVLv5EQPk5d9CjfjlKp6JCR0WViD
         g/WrycjSoP3Av9/mcIQcJ8fykCljxLAhHBt8DgnhXIX3+kIj+sEiPuXotdur2wov1ETt
         GiJcbo5mBD5AspbU01S8/uRDlWHlbFyMFEPlbSaNaAntURQKmvf2NWFNgmlrDfmlxJbH
         yw5zKZhvxk28u1u0BgSnJ6IsOch0QX1Tkk0o7uNVOASG52BVaACg2BiZ8FsSeeuWWneZ
         KhmQ==
X-Gm-Message-State: ABy/qLbKKkEpvOaS3lkRiUeTi9qrQbvFP1FTMgfCr1H6kPFyqjTqCAI6
	QgPVdToqCxqz55+scMTayvZOq+1RrisHnQ==
X-Google-Smtp-Source: APBJJlGCB9vNsjNtZWwgl85+wIh8oNWc/KQnkCM9jJKB5zvwNkFCEC0inF58L657qQ6g0b5kg8vVHA==
X-Received: by 2002:a50:fc10:0:b0:51b:c714:a2a1 with SMTP id i16-20020a50fc10000000b0051bc714a2a1mr9843654edr.7.1688480423657;
        Tue, 04 Jul 2023 07:20:23 -0700 (PDT)
Received: from krava ([193.46.31.82])
        by smtp.gmail.com with ESMTPSA id b17-20020aa7c6d1000000b0051de018af1esm6815556eds.59.2023.07.04.07.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 07:20:23 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 4 Jul 2023 16:20:19 +0200
To: Jackie Liu <liu.yun@linux.dev>
Cc: Jiri Olsa <olsajiri@gmail.com>, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yhs@fb.com, bpf@vger.kernel.org,
	liuyun01@kylinos.cn, lkp@intel.com
Subject: Re: [PATCH v3 1/2] libbpf: kprobe.multi: cross filter using
 available_filter_functions and kallsyms
Message-ID: <ZKQqo6bgbbkADkeG@krava>
References: <20230703013618.1959621-1-liu.yun@linux.dev>
 <ZKLGSFhBNZtOdulu@krava>
 <437ed462-8950-755d-388f-e82c57bb8c44@linux.dev>
 <ZKQnr0VZri1pWyrO@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKQnr0VZri1pWyrO@krava>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 04, 2023 at 04:07:48PM +0200, Jiri Olsa wrote:
> On Tue, Jul 04, 2023 at 09:33:15AM +0800, Jackie Liu wrote:
> 
> SNIP
> 
> > > 
> > > should you check if you found anything (infos.cnt != 0) and return early
> > > if there's nothing found
> > > 
> > > > +
> > > > +	/* sort available functions */
> > > > +	qsort(infos.syms, infos.cnt, sizeof(void *), qsort_compare_function);
> > > > +
> > > > +	f = fopen("/proc/kallsyms", "r");
> > > 
> > > why not use libbpf_kallsyms_parse for kallsyms parsing? the call below
> > > would be in its callback
> > 
> > This place cannot directly use libbpf_kallsyms_parse, because we need
> > info.syms, this value cannot be passed into the parameters of
> > libbpf_kallsyms_parse, 
> 
> hum, libbpf_kallsyms_parse takes 'void *ctx', so you can pass anything
> you want right? 

somthing like below should save some lines and ease up error handling

I'd add similar parse functions for both available_filter_functions and
available_filter_functions_addrs and add the logic to callbacks

jirka


---
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b9282ef3f8a7..04b980293240 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10559,8 +10559,31 @@ static int bsearch_compare_function(const void *a, const void *b)
 	return strcmp((const char *)a, *(const char **)b);
 }
 
+struct avail_kallsyms_data {
+	const char **syms;
+	struct kprobe_multi_resolve *res;
+};
+
+static int avail_kallsyms_cb(unsigned long long sym_addr, char sym_type,
+			     const char *sym_name, void *ctx)
+{
+	struct avail_kallsyms_data *data = ctx;
+	struct kprobe_multi_resolve *res = data->res;
+
+	if (!bsearch(&sym_name, data->syms, cnt, sizeof(void *), bsearch_compare_function))
+		continue;
+
+	err = libbpf_ensure_mem((void **)&res->addrs, &res->cap,
+				sizeof(unsigned long), res->cnt + 1);
+	if (err)
+		return err;
+	res->addrs[res->cnt++] = (unsigned long) sym_addr;
+	return 0;
+}
+
 static int libbpf_available_kallsyms_parse(struct kprobe_multi_resolve *res)
 {
+	struct avail_kallsyms_data data;
 	char sym_name[500];
 	const char *available_functions_file = tracefs_available_filter_functions();
 	FILE *f;
@@ -10614,42 +10637,13 @@ static int libbpf_available_kallsyms_parse(struct kprobe_multi_resolve *res)
 	/* sort available functions */
 	qsort(syms, cnt, sizeof(void *), qsort_compare_function);
 
-	f = fopen("/proc/kallsyms", "r");
-	if (!f) {
-		err = -errno;
-		pr_warn("failed to open /proc/kallsyms\n");
-		goto free_syms;
-	}
-
-	while (true) {
-		unsigned long long sym_addr;
-
-		ret = fscanf(f, "%llx %*c %499s%*[^\n]\n", &sym_addr, sym_name);
-		if (ret == EOF && feof(f))
-			break;
-
-		if (ret != 2) {
-			pr_warn("failed to read kallsyms entry: %d\n", ret);
-			err = -EINVAL;
-			goto cleanup;
-		}
-
-		if (!bsearch(&sym_name, syms, cnt, sizeof(void *), bsearch_compare_function))
-			continue;
-
-		err = libbpf_ensure_mem((void **)&res->addrs, &res->cap,
-					sizeof(unsigned long), res->cnt + 1);
-		if (err)
-			goto cleanup;
-
-		res->addrs[res->cnt++] = (unsigned long) sym_addr;
-	}
+	data.syms = syms;
+	data.res = res;
+	libbpf_kallsyms_parse(avail_kallsyms_cb, res);
 
 	if (!res->cnt)
 		err = -ENOENT;
 
-cleanup:
-	fclose(f);
 free_syms:
 	for (i = 0; i < cnt; i++)
 		free((char *)syms[i]);

